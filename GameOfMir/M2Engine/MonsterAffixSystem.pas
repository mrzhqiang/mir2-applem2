unit MonsterAffixSystem;

interface

uses
  Windows, SysUtils, Classes, Grobal2, M2Share, ObjBase, ObjNpc, ObjPlay, LocalDB, IniFiles;

// 怪物词条系统核心函数
function InitializeMonsterAffixSystem: Boolean;
procedure FinalizeMonsterAffixSystem;

// 词条生成系统
function GenerateMonsterAffix(Monster: TNormNpc; bIsBoss: Boolean): TMonsterAffixSet;
function GetRandomAffix(ElementType: TElementType; AffixLevel: TAffixLevel): pTMonsterAffix;
function CanGenerateAffix(Monster: TNormNpc; AffixLevel: TAffixLevel; bIsBoss: Boolean): Boolean;

// 词条名称系统
function GetElementName(ElementType: TElementType): string;
function GetAffixLevelName(AffixLevel: TAffixLevel): string;
function GetAffixPrefix(ElementType: TElementType; AffixLevel: TAffixLevel): string;
function BuildMonsterDisplayName(const sOriginalName: string; AffixSet: TMonsterAffixSet): string;

// 词条效果系统
function ApplyAffixEffect(Monster: TNormNpc; Affix: TMonsterAffix; Target: TBaseObject): Boolean;
function TriggerAffixEffect(Monster: TNormNpc; AffixStatus: pTMonsterAffixStatus; TriggerType: TAffixTriggerType; Target: TBaseObject): Boolean;
procedure ProcessAffixEffects(Monster: TNormNpc);

// 词条管理
function GetAffixByIndex(wIndex: Word): pTMonsterAffix;
procedure SetMonsterAffixSet(Monster: TNormNpc; AffixSet: TMonsterAffixSet);
function GetMonsterAffixSet(Monster: TNormNpc): TMonsterAffixSet;
function HasAffix(Monster: TNormNpc; ElementType: TElementType; AffixLevel: TAffixLevel): Boolean;

// 配置文件管理
function LoadMonsterAffixConfigs(const sFileName: string): Boolean;
function LoadAffixDatabase(const sFileName: string): Integer;

// 特效处理函数
procedure ApplyWeaponDurabilityEffect(Target: TBaseObject; nValue: Integer);
procedure ApplyAttackSpeedEffect(Target: TBaseObject; nValue: Integer; nDuration: Word);
procedure ApplyMovementSpeedEffect(Target: TBaseObject; nValue: Integer; nDuration: Word);
procedure ApplyGroundEffect(Monster: TNormNpc; nRange: Word; EffectType: TAffixEffectType);
procedure ApplyAreaDamage(Monster: TNormNpc; nRange: Word; nDamage: Integer);
procedure ApplyInvincibleEffect(Monster: TNormNpc; nDuration: Word);
procedure ApplyFullHealEffect(Monster: TNormNpc);
procedure ApplyInstantKillEffect(Monster: TNormNpc; nRange: Word);

// 辅助函数
function GetRandomElement: TElementType;
function GetRandomAffixLevel(bIsBoss: Boolean): TAffixLevel;
function CalculateAffixRate(AffixLevel: TAffixLevel): Word;
function IsAffixOnCooldown(AffixStatus: pTMonsterAffixStatus): Boolean;

// 内部辅助函数
procedure CreateDefaultAffixes;
procedure CreateDefaultAffixDatabase(const sFileName: string);
function ParseAffixLine(const sLine: string; out nIndex: Integer; out sName, sPrefix: string;
  out nElement, nLevel, nTrigger, nEffect, nRate, nValue, nDuration, nCooldown, nRange: Integer;
  out sDescription: string): Boolean;

implementation

// ========== 系统初始化和清理 ==========

function InitializeMonsterAffixSystem: Boolean;
begin
  try
    // 加载怪物词条配置
    if not LoadMonsterAffixConfigs('MonsterAffixConfig.ini') then begin
      MainOutMessage('[警告] 怪物词条配置加载失败，使用默认配置');
    end;
    
    // 加载词条数据库
    if LoadAffixDatabase('MonsterAffix.txt') = 0 then begin
      MainOutMessage('[警告] 怪物词条数据库为空，创建默认词条');
      CreateDefaultAffixes;
    end;
    
    g_boMonsterAffixEnabled := g_MonsterAffixConfig.boEnabled;
    Result := True;
  except
    on E: Exception do begin
      MainOutMessage('[异常] 怪物词条系统初始化失败: ' + E.Message);
      Result := False;
    end;
  end;
end;

procedure FinalizeMonsterAffixSystem;
begin
  // 清理工作已在M2Share.pas的finalization中完成
end;

// ========== 词条生成系统 ==========

function GenerateMonsterAffix(Monster: TNormNpc; bIsBoss: Boolean): TMonsterAffixSet;
var
  nAffixCount: Integer;
  i: Integer;
  ElementType: TElementType;
  AffixLevel: TAffixLevel;
  Affix: pTMonsterAffix;
  AffixStatus: TMonsterAffixStatus;
begin
  FillChar(Result, SizeOf(Result), 0);
  
  // 检查系统是否启用
  if not g_boMonsterAffixEnabled then Exit;
  
  // 随机决定词条数量
  if Random(1000) < g_MonsterAffixConfig.nMultiAffixRate then begin
    nAffixCount := 1 + Random(g_MonsterAffixConfig.nMaxMultiAffixCount);
  end else begin
    nAffixCount := 1;
  end;
  
  // 生成词条
  for i := 0 to nAffixCount - 1 do begin
    if i >= g_MonsterAffixConfig.nMaxAffixCount then Break;
    
    // 随机选择五行属性
    ElementType := GetRandomElement;
    
    // 随机选择词条等级
    AffixLevel := GetRandomAffixLevel(bIsBoss);
    
    // 检查是否可以生成该等级的词条
    if not CanGenerateAffix(Monster, AffixLevel, bIsBoss) then Continue;
    
    // 获取对应的词条
    Affix := GetRandomAffix(ElementType, AffixLevel);
    if Affix = nil then Continue;
    
    // 创建词条状态
    FillChar(AffixStatus, SizeOf(AffixStatus), 0);
    AffixStatus.Affix := Affix^;
    AffixStatus.boActive := True;
    AffixStatus.dwLastTriggerTime := 0;
    AffixStatus.dwEffectEndTime := 0;
    AffixStatus.nTriggerCount := 0;
    
    // 添加到词条集合
    Result.AffixList[Result.btAffixCount] := AffixStatus;
    Inc(Result.btAffixCount);
  end;
  
  // 生成显示名称
  if Result.btAffixCount > 0 then begin
    Result.sDisplayName := BuildMonsterDisplayName(Monster.m_sCharName, Result);
    Result.dwGenerateTime := GetTickCount;
  end else begin
    Result.sDisplayName := Monster.m_sCharName;
  end;
end;

function GetRandomAffix(ElementType: TElementType; AffixLevel: TAffixLevel): pTMonsterAffix;
var
  i: Integer;
  ValidAffixes: TList;
  Affix: pTMonsterAffix;
begin
  Result := nil;
  ValidAffixes := TList.Create;
  
  try
    // 收集符合条件的词条
    for i := 0 to g_MonsterAffixList.Count - 1 do begin
      Affix := pTMonsterAffix(g_MonsterAffixList[i]);
      if (Affix.ElementType = ElementType) and 
         (Affix.AffixLevel = AffixLevel) and 
         Affix.boEnabled then begin
        ValidAffixes.Add(Affix);
      end;
    end;
    
    // 随机选择一个
    if ValidAffixes.Count > 0 then begin
      Result := pTMonsterAffix(ValidAffixes[Random(ValidAffixes.Count)]);
    end;
  finally
    ValidAffixes.Free;
  end;
end;

function CanGenerateAffix(Monster: TNormNpc; AffixLevel: TAffixLevel; bIsBoss: Boolean): Boolean;
var
  nRate: Word;
begin
  Result := False;
  
  // 天级词条仅限Boss
  if (AffixLevel = al_Heaven) and g_MonsterAffixConfig.nBossOnlyHeaven then begin
    if not bIsBoss then Exit;
  end;
  
  // 检查生成几率
  nRate := CalculateAffixRate(AffixLevel);
  Result := Random(1000) < nRate;
end;

// ========== 词条名称系统 ==========

function GetElementName(ElementType: TElementType): string;
begin
  case ElementType of
    et_Metal: Result := '金';
    et_Wood: Result := '木';
    et_Water: Result := '水';
    et_Flame: Result := '火';
    et_Earth: Result := '土';
    else Result := '未知';
  end;
end;

function GetAffixLevelName(AffixLevel: TAffixLevel): string;
begin
  case AffixLevel of
    al_Human: Result := '人级';
    al_Earth: Result := '地级';
    al_Heaven: Result := '天级';
    else Result := '未知';
  end;
end;

function GetAffixPrefix(ElementType: TElementType; AffixLevel: TAffixLevel): string;
begin
  case ElementType of
    et_Metal: begin
      case AffixLevel of
        al_Human: Result := '锐利之';
        al_Earth: Result := '钢铁之';
        al_Heaven: Result := '神兵之';
      end;
    end;
    et_Wood: begin
      case AffixLevel of
        al_Human: Result := '生机之';
        al_Earth: Result := '森林之';
        al_Heaven: Result := '世界树之';
      end;
    end;
    et_Water: begin
      case AffixLevel of
        al_Human: Result := '寒冰之';
        al_Earth: Result := '冰川之';
        al_Heaven: Result := '极冰之';
      end;
    end;
    et_Flame: begin
      case AffixLevel of
        al_Human: Result := '炙热之';
        al_Earth: Result := '烈焰之';
        al_Heaven: Result := '焚灭之';
      end;
    end;
    et_Earth: begin
      case AffixLevel of
        al_Human: Result := '坚石之';
        al_Earth: Result := '大地之';
        al_Heaven: Result := '山岳之';
      end;
    end;
    else Result := '神秘之';
  end;
end;

function BuildMonsterDisplayName(const sOriginalName: string; AffixSet: TMonsterAffixSet): string;
var
  i: Integer;
  sPrefix: string;
begin
  sPrefix := '';
  
  // 按顺序添加所有词条前缀
  for i := 0 to AffixSet.btAffixCount - 1 do begin
    sPrefix := sPrefix + GetAffixPrefix(AffixSet.AffixList[i].Affix.ElementType, 
                                       AffixSet.AffixList[i].Affix.AffixLevel);
  end;
  
  Result := sPrefix + sOriginalName;
end;

// ========== 词条效果系统 ==========

function ApplyAffixEffect(Monster: TNormNpc; Affix: TMonsterAffix; Target: TBaseObject): Boolean;
var
  nRandom: Integer;
begin
  Result := False;
  
  // 检查触发几率
  nRandom := Random(1000);
  if nRandom >= Affix.nTriggerRate then Exit;
  
  // 根据效果类型应用效果
  case Affix.EffectType of
    aet_WeaponDurability: begin
      ApplyWeaponDurabilityEffect(Target, Affix.nEffectValue);
      Result := True;
    end;
    
    aet_AttackSpeed: begin
      ApplyAttackSpeedEffect(Target, Affix.nEffectValue, Affix.nDuration);
      Result := True;
    end;
    
    aet_MovementSpeed: begin
      ApplyMovementSpeedEffect(Target, Affix.nEffectValue, Affix.nDuration);
      Result := True;
    end;
    
    aet_GroundEffect: begin
      ApplyGroundEffect(Monster, Affix.nRange, Affix.EffectType);
      Result := True;
    end;
    
    aet_AreaDamage: begin
      ApplyAreaDamage(Monster, Affix.nRange, Affix.nEffectValue);
      Result := True;
    end;
    
    aet_Invincible: begin
      ApplyInvincibleEffect(Monster, Affix.nDuration);
      Result := True;
    end;
    
    aet_FullHeal: begin
      ApplyFullHealEffect(Monster);
      Result := True;
    end;
    
    aet_InstantKill: begin
      ApplyInstantKillEffect(Monster, Affix.nRange);
      Result := True;
    end;
  end;
  
  if Result then begin
    MainOutMessage('[调试] 怪物词条效果触发: ' + Affix.sName + ' -> ' + Affix.sDescription);
  end;
end;

function TriggerAffixEffect(Monster: TNormNpc; AffixStatus: pTMonsterAffixStatus; TriggerType: TAffixTriggerType; Target: TBaseObject): Boolean;
var
  dwCurrentTime: LongWord;
begin
  Result := False;
  
  if (AffixStatus = nil) or (not AffixStatus.boActive) then Exit;
  if AffixStatus.Affix.TriggerType <> TriggerType then Exit;
  
  dwCurrentTime := GetTickCount;
  
  // 检查冷却时间
  if IsAffixOnCooldown(AffixStatus) then Exit;
  
  // 应用效果
  if ApplyAffixEffect(Monster, AffixStatus.Affix, Target) then begin
    AffixStatus.dwLastTriggerTime := dwCurrentTime;
    AffixStatus.dwEffectEndTime := dwCurrentTime + (AffixStatus.Affix.nDuration * 1000);
    Inc(AffixStatus.nTriggerCount);
    Result := True;
  end;
end;

procedure ProcessAffixEffects(Monster: TNormNpc);
var
  AffixSet: TMonsterAffixSet;
  i: Integer;
begin
  if not g_boMonsterAffixEnabled then Exit;
  
  AffixSet := GetMonsterAffixSet(Monster);
  if AffixSet.btAffixCount = 0 then Exit;
  
  // 处理定时触发的词条
  for i := 0 to AffixSet.btAffixCount - 1 do begin
    if AffixSet.AffixList[i].Affix.TriggerType = att_OnInterval then begin
      TriggerAffixEffect(Monster, @AffixSet.AffixList[i], att_OnInterval, nil);
    end;
    
    // 检查低血量触发
    if (AffixSet.AffixList[i].Affix.TriggerType = att_OnHealthLow) and
       (Monster.m_WAbil.HP < Monster.m_WAbil.MaxHP div 4) then begin
      TriggerAffixEffect(Monster, @AffixSet.AffixList[i], att_OnHealthLow, nil);
    end;
  end;
end;

// ========== 特效处理函数 ==========

procedure ApplyWeaponDurabilityEffect(Target: TBaseObject; nValue: Integer);
begin
  if Target = nil then Exit;
  // 尝试类型转换
  if Target is TPlayObject then begin
    // TODO: 实现武器耐久度降低效果
    // PlayObject.DecWeaponDura(nValue);
    MainOutMessage('[调试] 应用武器耐久度效果: ' + IntToStr(nValue));
  end;
end;

procedure ApplyAttackSpeedEffect(Target: TBaseObject; nValue: Integer; nDuration: Word);
begin
  // TODO: 实现攻击速度影响效果
  // Target.AddStatusEffect(EFFECT_ATTACK_SPEED, nValue, nDuration);
  MainOutMessage('[调试] 应用攻击速度效果: ' + IntToStr(nValue) + ', 持续: ' + IntToStr(nDuration) + '秒');
end;

procedure ApplyMovementSpeedEffect(Target: TBaseObject; nValue: Integer; nDuration: Word);
begin
  // TODO: 实现移动速度影响效果
  // Target.AddStatusEffect(EFFECT_MOVEMENT_SPEED, nValue, nDuration);
  MainOutMessage('[调试] 应用移动速度效果: ' + IntToStr(nValue) + ', 持续: ' + IntToStr(nDuration) + '秒');
end;

procedure ApplyGroundEffect(Monster: TNormNpc; nRange: Word; EffectType: TAffixEffectType);
begin
  // TODO: 实现地面效果
  // CreateGroundEffect(Monster.m_nCurrX, Monster.m_nCurrY, nRange, EffectType);
  MainOutMessage('[调试] 应用地面效果: 范围' + IntToStr(nRange) + ', 类型' + IntToStr(Ord(EffectType)));
end;

procedure ApplyAreaDamage(Monster: TNormNpc; nRange: Word; nDamage: Integer);
begin
  // TODO: 实现范围伤害
  // DamageAreaTargets(Monster.m_nCurrX, Monster.m_nCurrY, nRange, nDamage);
  MainOutMessage('[调试] 应用范围伤害: 范围' + IntToStr(nRange) + ', 伤害' + IntToStr(nDamage));
end;

procedure ApplyInvincibleEffect(Monster: TNormNpc; nDuration: Word);
begin
  // TODO: 实现无敌效果
  // Monster.AddStatusEffect(EFFECT_INVINCIBLE, 0, nDuration);
  MainOutMessage('[调试] 应用无敌效果: 持续' + IntToStr(nDuration) + '秒');
end;

procedure ApplyFullHealEffect(Monster: TNormNpc);
begin
  Monster.m_WAbil.HP := Monster.m_WAbil.MaxHP;
  Monster.HealthSpellChanged;
  MainOutMessage('[调试] 应用满血恢复效果');
end;

procedure ApplyInstantKillEffect(Monster: TNormNpc; nRange: Word);
begin
  // TODO: 实现秒杀效果
  // InstantKillAreaTargets(Monster.m_nCurrX, Monster.m_nCurrY, nRange);
  MainOutMessage('[调试] 应用秒杀效果: 范围' + IntToStr(nRange));
end;

// ========== 词条管理 ==========

function GetAffixByIndex(wIndex: Word): pTMonsterAffix;
var
  i: Integer;
  Affix: pTMonsterAffix;
begin
  Result := nil;
  
  for i := 0 to g_MonsterAffixList.Count - 1 do begin
    Affix := pTMonsterAffix(g_MonsterAffixList[i]);
    if Affix.wIndex = wIndex then begin
      Result := Affix;
      Break;
    end;
  end;
end;

procedure SetMonsterAffixSet(Monster: TNormNpc; AffixSet: TMonsterAffixSet);
begin
  // TODO: 将词条集合保存到怪物的扩展数据中
  // 临时实现：使用怪物的自定义数据字段
  Monster.m_sCharName := AffixSet.sDisplayName;
end;

function GetMonsterAffixSet(Monster: TNormNpc): TMonsterAffixSet;
begin
  // TODO: 从怪物的扩展数据中获取词条集合
  // 临时实现：返回空的词条集合
  FillChar(Result, SizeOf(Result), 0);
  Result.sDisplayName := Monster.m_sCharName;
end;

function HasAffix(Monster: TNormNpc; ElementType: TElementType; AffixLevel: TAffixLevel): Boolean;
var
  AffixSet: TMonsterAffixSet;
  i: Integer;
begin
  Result := False;
  
  AffixSet := GetMonsterAffixSet(Monster);
  for i := 0 to AffixSet.btAffixCount - 1 do begin
    if (AffixSet.AffixList[i].Affix.ElementType = ElementType) and
       (AffixSet.AffixList[i].Affix.AffixLevel = AffixLevel) then begin
      Result := True;
      Break;
    end;
  end;
end;

// ========== 配置文件管理 ==========

function LoadMonsterAffixConfigs(const sFileName: string): Boolean;
var
  sFullPath: string;
  IniFile: TIniFile;
begin
  sFullPath := g_Config.sGameDataDir + sFileName;
  
  try
    if FileExists(sFullPath) then begin
      IniFile := TIniFile.Create(sFullPath);
      try
        // 加载怪物词条配置
        with g_MonsterAffixConfig do begin
          boEnabled := IniFile.ReadBool('MonsterAffix', 'Enabled', True);
          nMaxAffixCount := IniFile.ReadInteger('MonsterAffix', 'MaxAffixCount', 5);
          nHumanAffixRate := IniFile.ReadInteger('MonsterAffix', 'HumanAffixRate', 100);
          nEarthAffixRate := IniFile.ReadInteger('MonsterAffix', 'EarthAffixRate', 30);
          nHeavenAffixRate := IniFile.ReadInteger('MonsterAffix', 'HeavenAffixRate', 5);
          nBossOnlyHeaven := IniFile.ReadBool('MonsterAffix', 'BossOnlyHeaven', True);
          nMultiAffixRate := IniFile.ReadInteger('MonsterAffix', 'MultiAffixRate', 200);
          nMaxMultiAffixCount := IniFile.ReadInteger('MonsterAffix', 'MaxMultiAffixCount', 3);
        end;
        
        g_boMonsterAffixEnabled := g_MonsterAffixConfig.boEnabled;
        MainOutMessage('[提示] 怪物词条系统配置加载成功');
        Result := True;
      finally
        IniFile.Free;
      end;
    end else begin
      // 创建默认配置文件
      IniFile := TIniFile.Create(sFullPath);
      try
        with g_MonsterAffixConfig do begin
          IniFile.WriteBool('MonsterAffix', 'Enabled', boEnabled);
          IniFile.WriteInteger('MonsterAffix', 'MaxAffixCount', nMaxAffixCount);
          IniFile.WriteInteger('MonsterAffix', 'HumanAffixRate', nHumanAffixRate);
          IniFile.WriteInteger('MonsterAffix', 'EarthAffixRate', nEarthAffixRate);
          IniFile.WriteInteger('MonsterAffix', 'HeavenAffixRate', nHeavenAffixRate);
          IniFile.WriteBool('MonsterAffix', 'BossOnlyHeaven', nBossOnlyHeaven);
          IniFile.WriteInteger('MonsterAffix', 'MultiAffixRate', nMultiAffixRate);
          IniFile.WriteInteger('MonsterAffix', 'MaxMultiAffixCount', nMaxMultiAffixCount);
          
          IniFile.WriteString('MonsterAffix', '; 说明1', '人级词条几率10%，地级3%，天级0.5%');
          IniFile.WriteString('MonsterAffix', '; 说明2', '多词条几率20%，最多3个词条');
        end;
        
        MainOutMessage('[提示] 创建默认怪物词条系统配置文件');
        Result := True;
      finally
        IniFile.Free;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage('[异常] 加载怪物词条系统配置失败: ' + E.Message);
      Result := False;
    end;
  end;
end;

function LoadAffixDatabase(const sFileName: string): Integer;
var
  sFullPath: string;
  LoadList: TStringList;
  i: Integer;
  sLineText: string;
  Affix: pTMonsterAffix;
  nIndex, nElement, nLevel, nTrigger, nEffect, nRate, nValue, nDuration, nCooldown, nRange: Integer;
  sName, sPrefix, sDescription: string;
begin
  Result := 0;
  sFullPath := g_Config.sGameDataDir + sFileName;
  
  if not FileExists(sFullPath) then begin
    CreateDefaultAffixDatabase(sFullPath);
  end;
  
  LoadList := TStringList.Create;
  try
    LoadList.LoadFromFile(sFullPath);
    
    for i := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList[i]);
      if (sLineText = '') or (sLineText[1] = ';') then Continue;
      
      // 解析词条数据
      // 格式: Index Name Prefix Element Level Trigger Effect Rate Value Duration Cooldown Range Description
      if ParseAffixLine(sLineText, nIndex, sName, sPrefix, nElement, nLevel, 
                        nTrigger, nEffect, nRate, nValue, nDuration, nCooldown, nRange, sDescription) then begin
        New(Affix);
        with Affix^ do begin
          wIndex := nIndex;
          Affix^.sName := sName;
          Affix^.sPrefix := sPrefix;
          ElementType := TElementType(nElement);
          AffixLevel := TAffixLevel(nLevel);
          TriggerType := TAffixTriggerType(nTrigger);
          EffectType := TAffixEffectType(nEffect);
          nTriggerRate := nRate;
          nEffectValue := nValue;
          Affix^.nDuration := nDuration;
          Affix^.nCooldown := nCooldown;
          Affix^.nRange := nRange;
          boEnabled := True;
          Affix^.sDescription := sDescription;
        end;
        
        g_MonsterAffixList.Add(Affix);
        Inc(Result);
      end;
    end;
    
    MainOutMessage('[提示] 加载怪物词条数据库完成，共' + IntToStr(Result) + '个词条');
  finally
    LoadList.Free;
  end;
end;

// ========== 辅助函数 ==========

function GetRandomElement: TElementType;
begin
  Result := TElementType(Random(5)); // 0-4 对应金木水火土
end;

function GetRandomAffixLevel(bIsBoss: Boolean): TAffixLevel;
var
  nRandom: Integer;
begin
  nRandom := Random(1000);
  
  if bIsBoss and (nRandom < g_MonsterAffixConfig.nHeavenAffixRate) then
    Result := al_Heaven
  else if nRandom < g_MonsterAffixConfig.nEarthAffixRate then
    Result := al_Earth
  else if nRandom < g_MonsterAffixConfig.nHumanAffixRate then
    Result := al_Human
  else
    Result := al_Human; // 默认人级
end;

function CalculateAffixRate(AffixLevel: TAffixLevel): Word;
begin
  case AffixLevel of
    al_Human: Result := g_MonsterAffixConfig.nHumanAffixRate;
    al_Earth: Result := g_MonsterAffixConfig.nEarthAffixRate;
    al_Heaven: Result := g_MonsterAffixConfig.nHeavenAffixRate;
    else Result := 0;
  end;
end;

function IsAffixOnCooldown(AffixStatus: pTMonsterAffixStatus): Boolean;
var
  dwCurrentTime: LongWord;
begin
  dwCurrentTime := GetTickCount;
  Result := (AffixStatus.dwLastTriggerTime > 0) and 
            (dwCurrentTime - AffixStatus.dwLastTriggerTime < AffixStatus.Affix.nCooldown * 1000);
end;

// ========== 内部辅助函数 ==========

procedure CreateDefaultAffixes;
begin
  // TODO: 创建默认的词条数据
  MainOutMessage('[提示] 创建默认怪物词条数据');
end;

procedure CreateDefaultAffixDatabase(const sFileName: string);
var
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  try
    SaveList.Add('; 怪物词条数据库');
    SaveList.Add('; 格式: Index Name Prefix Element Level Trigger Effect Rate Value Duration Cooldown Range Description');
    SaveList.Add('; Element: 0=金 1=木 2=水 3=火 4=土');
    SaveList.Add('; Level: 0=人级 1=地级 2=天级');
    SaveList.Add('; Trigger: 1=攻击时 2=被攻击时 3=死亡时 4=生成时 5=定时 6=低血量 7=玩家接近 8=释放技能时');
    SaveList.Add('; Effect: 1=武器耐久 2=攻击速度 3=移动速度 4=伤害 5=防御 6=生命恢复 7=魔法恢复 8=地面效果 9=范围伤害 10=无敌 11=满血 12=秒杀 13=传送 14=召唤 15=状态效果');
    SaveList.Add('');
    
    // 火系词条
    SaveList.Add('1001 炙热 炙热之 3 0 2 1 500 10 0 5 0 攻击者武器耐久快速下降');
    SaveList.Add('1002 烈焰 烈焰之 3 1 4 8 300 100 5 10 3 生成时在周围产生火焰地面效果');
    SaveList.Add('1003 焚灭 焚灭之 3 2 6 9 100 500 0 30 5 低血量时释放大范围火焰伤害');
    
    // 水系词条
    SaveList.Add('2001 寒冰 寒冰之 2 0 2 2 400 20 10 8 0 攻击者攻击速度降低');
    SaveList.Add('2002 冰川 冰川之 2 1 7 8 200 0 15 15 4 玩家接近时产生冰冻地面效果');
    SaveList.Add('2003 极冰 极冰之 2 2 6 10 50 0 10 60 0 低血量时获得无敌状态');
    
    // 金系词条
    SaveList.Add('3001 锐利 锐利之 0 0 1 4 600 50 0 0 0 攻击时增加伤害');
    SaveList.Add('3002 钢铁 钢铁之 0 1 2 5 400 100 0 0 0 被攻击时增加防御');
    SaveList.Add('3003 神兵 神兵之 0 2 8 13 80 0 0 45 0 释放技能时随机传送');
    
    // 木系词条
    SaveList.Add('4001 生机 生机之 1 0 5 6 800 50 0 10 0 定时恢复生命值');
    SaveList.Add('4002 森林 森林之 1 1 4 14 300 0 0 20 5 生成时召唤小怪');
    SaveList.Add('4003 世界树 世界树之 1 2 6 11 100 0 0 120 0 低血量时满血恢复');
    
    // 土系词条
    SaveList.Add('5001 坚石 坚石之 4 0 2 3 500 30 8 6 0 被攻击时降低攻击者移动速度');
    SaveList.Add('5002 大地 大地之 4 1 5 8 250 0 20 25 6 定时产生地震效果');
    SaveList.Add('5003 山岳 山岳之 4 2 6 12 50 0 0 180 8 低血量时秒杀周围玩家');
    
    SaveList.SaveToFile(sFileName);
    MainOutMessage('[提示] 创建默认怪物词条数据库: ' + sFileName);
  finally
    SaveList.Free;
  end;
end;

function ParseAffixLine(const sLine: string; out nIndex: Integer; out sName, sPrefix: string;
  out nElement, nLevel, nTrigger, nEffect, nRate, nValue, nDuration, nCooldown, nRange: Integer;
  out sDescription: string): Boolean;
var
  sList: TStringList;
  i: Integer;
begin
  Result := False;
  sList := TStringList.Create;
  
  try
    // 简单的空格分割解析
    sList.Delimiter := ' ';
    sList.DelimitedText := sLine;
    
    if sList.Count >= 13 then begin
      nIndex := StrToIntDef(sList[0], 0);
      sName := sList[1];
      sPrefix := sList[2];
      nElement := StrToIntDef(sList[3], 0);
      nLevel := StrToIntDef(sList[4], 0);
      nTrigger := StrToIntDef(sList[5], 1);
      nEffect := StrToIntDef(sList[6], 1);
      nRate := StrToIntDef(sList[7], 100);
      nValue := StrToIntDef(sList[8], 0);
      nDuration := StrToIntDef(sList[9], 0);
      nCooldown := StrToIntDef(sList[10], 0);
      nRange := StrToIntDef(sList[11], 0);
      
      // 描述可能包含空格，需要特殊处理
      sDescription := '';
      for i := 12 to sList.Count - 1 do begin
        if sDescription <> '' then sDescription := sDescription + ' ';
        sDescription := sDescription + sList[i];
      end;
      
      Result := (nIndex > 0);
    end;
  finally
    sList.Free;
  end;
end;

end.
