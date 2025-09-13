unit SoulSystem;

interface

uses
  Windows, SysUtils, Classes, Grobal2, M2Share, ObjBase, ObjPlay, LocalDB, RefineSystem;

// 元魄/精魂系统核心函数
function InitializeSoulSystem: Boolean;
procedure FinalizeSoulSystem;

// 元魄合成系统
function SynthesizeSoul(PlayObject: TPlayObject; Equipments: array of pTUserItem; JobType: TSoulJobType): TSoulSynthesisResult;
function CalculateSynthesisSuccessRate(Equipments: array of pTUserItem): Integer;
function CanSynthesizeSoul(Equipments: array of pTUserItem): Boolean;
function CreateSoulFromEquipments(Equipments: array of pTUserItem; JobType: TSoulJobType): pTSoulInfo;

// 元魄升级为精魂系统
function UpgradeSoulToEssence(PlayObject: TPlayObject; Soul: pTUserItem; Equipment: pTUserItem): TSoulUpgradeResult;
function CalculateUpgradeSuccessRate(Equipment: pTUserItem): Integer;
function CanUpgradeToEssence(Soul: pTUserItem; Equipment: pTUserItem): Boolean;

// 精魂材料升级系统
function UpgradeEssenceWithMaterials(PlayObject: TPlayObject; Essence: pTUserItem; Materials: array of pTRefineMaterial): TSoulUpgradeResult;
function CalculateMaterialUpgradeRate(Materials: array of pTRefineMaterial): Integer;
function CanUpgradeEssence(Essence: pTUserItem; Materials: array of pTRefineMaterial): Boolean;

// 特殊效果系统
procedure GenerateRandomEffects(Soul: pTSoulInfo);
function ApplySoulEffects(PlayObject: TPlayObject; Soul: pTSoulInfo): Boolean;
function GetEffectDescription(Effect: TSoulEffect): string;

// 元魄/精魂管理
function GetSoulInfo(Item: pTUserItem): pTSoulInfo;
procedure SetSoulInfo(Item: pTUserItem; SoulInfo: TSoulInfo);
function CreateDefaultSoulInfo(JobType: TSoulJobType; SoulType: TSoulType): TSoulInfo;
function GetJobTypeName(JobType: TSoulJobType): string;
function GetSoulTypeName(SoulType: TSoulType): string;
function GetSoulDisplayName(Soul: TSoulInfo): string;

// 配置文件管理
function LoadSoulConfigs(const sFileName: string): Boolean;

// 辅助函数
function GetPlayerJobType(PlayObject: TPlayObject): TSoulJobType;
function ValidateEquipmentArray(Equipments: array of pTUserItem): Boolean;
function ValidateMaterialArray(Materials: array of pTRefineMaterial): Boolean;

implementation

// ========== 系统初始化和清理 ==========

function InitializeSoulSystem: Boolean;
begin
  Result := False;
  try
    // 加载元魄/精魂配置
    if not LoadSoulConfigs('SoulConfig.ini') then begin
      MainOutMessage('[警告] 元魄/精魂配置加载失败，使用默认配置');
    end;
    
    g_boSoulSystemEnabled := g_SoulSynthesisConfig.boEnabled and g_EssenceUpgradeConfig.boEnabled;
    Result := True;
  except
    on E: Exception do begin
      MainOutMessage('[异常] 元魄/精魂系统初始化失败: ' + E.Message);
      Result := False;
    end;
  end;
end;

procedure FinalizeSoulSystem;
begin
  // 清理工作已在M2Share.pas的finalization中完成
end;

// ========== 元魄合成系统 ==========

function SynthesizeSoul(PlayObject: TPlayObject; Equipments: array of pTUserItem; JobType: TSoulJobType): TSoulSynthesisResult;
var
  nSuccessRate: Integer;
  nRandom: Integer;
  Soul: pTSoulInfo;
  i: Integer;
begin
  Result := ssr_Failed;
  
  // 检查系统是否启用
  if not g_boSoulSystemEnabled then begin
    Result := ssr_SystemDisabled;
    Exit;
  end;
  
  // 检查装备数组是否有效
  if not ValidateEquipmentArray(Equipments) then begin
    if Length(Equipments) = 0 then
      Result := ssr_NoItems
    else if Length(Equipments) > g_SoulSynthesisConfig.nMaxEquipmentCount then
      Result := ssr_TooManyItems
    else
      Result := ssr_InvalidItem;
    Exit;
  end;
  
  // 检查是否可以合成
  if not CanSynthesizeSoul(Equipments) then begin
    Result := ssr_QualityTooLow;
    Exit;
  end;
  
  // 计算成功率
  nSuccessRate := CalculateSynthesisSuccessRate(Equipments);
  
  // 随机判定结果
  nRandom := Random(1000);
  if nRandom < nSuccessRate then begin
    // 合成成功，创建元魄
    Soul := CreateSoulFromEquipments(Equipments, JobType);
    if Soul <> nil then begin
      // TODO: 将元魄添加到玩家背包
      // PlayObject.AddItemToBag(Soul);
      
      // 消耗装备
      for i := 0 to High(Equipments) do begin
        if Equipments[i] <> nil then begin
          // TODO: 从玩家背包中移除装备
          // PlayObject.RemoveItemFromBag(Equipments[i]);
        end;
      end;
      
      Result := ssr_Success;
      PlayObject.SysMsg('元魄合成成功！获得 ' + GetSoulDisplayName(Soul^), c_Green, t_Hint);
      MainOutMessage('[调试] 合成元魄成功: ' + GetSoulDisplayName(Soul^));
    end else begin
      Result := ssr_Failed;
    end;
  end else begin
    // 合成失败，消耗装备
    for i := 0 to High(Equipments) do begin
      if Equipments[i] <> nil then begin
        // TODO: 从玩家背包中移除装备
        // PlayObject.RemoveItemFromBag(Equipments[i]);
      end;
    end;
    
    Result := ssr_Failed;
    PlayObject.SysMsg('元魄合成失败！', c_Red, t_Hint);
  end;
end;

function CalculateSynthesisSuccessRate(Equipments: array of pTUserItem): Integer;
var
  i: Integer;
  RefineInfo: pTRefineInfo;
  nQualityLevel: Integer;
  nRate: Integer;
begin
  Result := 0;
  
  for i := 0 to High(Equipments) do begin
    if Equipments[i] <> nil then begin
      RefineInfo := GetRefineInfo(Equipments[i]);
      nQualityLevel := Ord(RefineInfo.RefineQuality);
      
      // 计算单件装备的成功率
      // 精致品质(3)基础10%，每级增加10%
      nRate := g_SoulSynthesisConfig.nBaseSuccessRate + 
               (nQualityLevel - g_SoulSynthesisConfig.nMinQualityLevel) * g_SoulSynthesisConfig.nQualityBonus;
      
      Inc(Result, nRate);
    end;
  end;
  
  // 成功率上限100%
  if Result > 1000 then
    Result := 1000;
end;

function CanSynthesizeSoul(Equipments: array of pTUserItem): Boolean;
var
  i: Integer;
  RefineInfo: pTRefineInfo;
begin
  Result := False;
  
  if Length(Equipments) = 0 then Exit;
  
  for i := 0 to High(Equipments) do begin
    if Equipments[i] <> nil then begin
      RefineInfo := GetRefineInfo(Equipments[i]);
      if Ord(RefineInfo.RefineQuality) < g_SoulSynthesisConfig.nMinQualityLevel then
        Exit;
    end;
  end;
  
  Result := True;
end;

function CreateSoulFromEquipments(Equipments: array of pTUserItem; JobType: TSoulJobType): pTSoulInfo;
var
  Soul: TSoulInfo;
begin
  Result := nil;
  
  try
    // 创建基础元魄信息
    Soul := CreateDefaultSoulInfo(JobType, st_Soul);
    Soul.sCreatorName := 'System'; // TODO: 设置为玩家名称
    Soul.dwCreateTime := GetTickCount;
    
    // 生成随机特殊效果
    GenerateRandomEffects(@Soul);
    
    // 分配内存并返回
    New(Result);
    Result^ := Soul;
  except
    on E: Exception do begin
      MainOutMessage('[异常] 创建元魄失败: ' + E.Message);
      Result := nil;
    end;
  end;
end;

// ========== 元魄升级为精魂系统 ==========

function UpgradeSoulToEssence(PlayObject: TPlayObject; Soul: pTUserItem; Equipment: pTUserItem): TSoulUpgradeResult;
var
  nSuccessRate: Integer;
  nRandom: Integer;
  SoulInfo: pTSoulInfo;
begin
  Result := sur_Failed;
  
  // 检查系统是否启用
  if not g_boSoulSystemEnabled then begin
    Result := sur_SystemDisabled;
    Exit;
  end;
  
  // 检查是否可以升级
  if not CanUpgradeToEssence(Soul, Equipment) then begin
    SoulInfo := GetSoulInfo(Soul);
    if SoulInfo = nil then
      Result := sur_InvalidSoul
    else if SoulInfo.SoulType <> st_Soul then
      Result := sur_InvalidSoul
    else
      Result := sur_QualityTooLow;
    Exit;
  end;
  
  // 计算成功率
  nSuccessRate := CalculateUpgradeSuccessRate(Equipment);
  
  // 随机判定结果
  nRandom := Random(1000);
  if nRandom < nSuccessRate then begin
    // 升级成功，转换为精魂
    SoulInfo := GetSoulInfo(Soul);
    SoulInfo.SoulType := st_Essence;
    SoulInfo.nDamageDeepen := 150;  // 伤害加深+15%
    SoulInfo.nDamageAbsorb := 150;  // 伤害吸收+15%
    SoulInfo.sName := GetSoulDisplayName(SoulInfo^);
    
    SetSoulInfo(Soul, SoulInfo^);
    
    // 消耗装备
    // TODO: PlayObject.RemoveItemFromBag(Equipment);
    
    Result := sur_Success;
    PlayObject.SysMsg('元魄升级成功！转化为 ' + GetSoulDisplayName(SoulInfo^), c_Green, t_Hint);
  end else begin
    // 升级失败，仅消耗装备，元魄不消失
    // TODO: PlayObject.RemoveItemFromBag(Equipment);
    
    Result := sur_Failed;
    PlayObject.SysMsg('元魄升级失败！', c_Red, t_Hint);
  end;
end;

function CalculateUpgradeSuccessRate(Equipment: pTUserItem): Integer;
var
  RefineInfo: pTRefineInfo;
  nQualityLevel: Integer;
begin
  Result := 0;
  
  if Equipment = nil then Exit;
  
  RefineInfo := GetRefineInfo(Equipment);
  nQualityLevel := Ord(RefineInfo.RefineQuality);
  
  // 根据品质计算成功率
  // 绝世(8)=20%, 史诗(9)=40%, 传说(10)=60%, 永恒(11)=80%, 神话(12)=100%
  case nQualityLevel of
    8: Result := 200;   // 绝世 20%
    9: Result := 400;   // 史诗 40%
    10: Result := 600;  // 传说 60%
    11: Result := 800;  // 永恒 80%
    12: Result := 1000; // 神话 100%
    else Result := 0;
  end;
end;

function CanUpgradeToEssence(Soul: pTUserItem; Equipment: pTUserItem): Boolean;
var
  SoulInfo: pTSoulInfo;
  RefineInfo: pTRefineInfo;
begin
  Result := False;
  
  if (Soul = nil) or (Equipment = nil) then Exit;
  
  SoulInfo := GetSoulInfo(Soul);
  if (SoulInfo = nil) or (SoulInfo.SoulType <> st_Soul) then Exit;
  
  RefineInfo := GetRefineInfo(Equipment);
  if Ord(RefineInfo.RefineQuality) < g_EssenceUpgradeConfig.nMinQualityForUpgrade then Exit;
  
  Result := True;
end;

// ========== 精魂材料升级系统 ==========

function UpgradeEssenceWithMaterials(PlayObject: TPlayObject; Essence: pTUserItem; Materials: array of pTRefineMaterial): TSoulUpgradeResult;
var
  nSuccessRate: Integer;
  nRandom: Integer;
  SoulInfo: pTSoulInfo;
  bSafeUpgrade: Boolean;
  i: Integer;
begin
  Result := sur_Failed;
  
  // 检查系统是否启用
  if not g_boSoulSystemEnabled then begin
    Result := sur_SystemDisabled;
    Exit;
  end;
  
  // 检查是否可以升级
  if not CanUpgradeEssence(Essence, Materials) then begin
    SoulInfo := GetSoulInfo(Essence);
    if SoulInfo = nil then
      Result := sur_InvalidSoul
    else if SoulInfo.SoulType <> st_Essence then
      Result := sur_InvalidSoul
    else if SoulInfo.btLevel >= g_EssenceUpgradeConfig.nMaxLevel then
      Result := sur_MaxLevel
    else if Length(Materials) = 0 then
      Result := sur_NoMaterials
    else
      Result := sur_InvalidSoul;
    Exit;
  end;
  
  SoulInfo := GetSoulInfo(Essence);
  bSafeUpgrade := (SoulInfo.btLevel < g_EssenceUpgradeConfig.nSafeLevelThreshold);
  
  // 计算成功率
  nSuccessRate := CalculateMaterialUpgradeRate(Materials);
  
  // 消耗材料
  for i := 0 to High(Materials) do begin
    if Materials[i] <> nil then begin
      // TODO: PlayObject.ConsumeMaterial(Materials[i]);
    end;
  end;
  
  // 随机判定结果
  nRandom := Random(1000);
  if nRandom < nSuccessRate then begin
    // 升级成功
    Inc(SoulInfo.btLevel);
    Inc(SoulInfo.nDamageDeepen, g_EssenceUpgradeConfig.nLevelDamageBonus);
    Inc(SoulInfo.nDamageAbsorb, g_EssenceUpgradeConfig.nLevelAbsorbBonus);
    SoulInfo.sName := GetSoulDisplayName(SoulInfo^);
    
    SetSoulInfo(Essence, SoulInfo^);
    
    Result := sur_Success;
    PlayObject.SysMsg('精魂升级成功！当前等级：+' + IntToStr(SoulInfo.btLevel), c_Green, t_Hint);
  end else begin
    // 升级失败
    if not bSafeUpgrade then begin
      // 6级以上失败等级清零
      SoulInfo.btLevel := 0;
      SoulInfo.nDamageDeepen := 150;  // 重置为基础属性
      SoulInfo.nDamageAbsorb := 150;
      SoulInfo.sName := GetSoulDisplayName(SoulInfo^);
      
      SetSoulInfo(Essence, SoulInfo^);
      
      Result := sur_LevelReset;
      PlayObject.SysMsg('精魂升级失败！等级已清零', c_Red, t_Hint);
    end else begin
      // 6级以下安全升级，仅消耗材料
      Result := sur_Failed;
      PlayObject.SysMsg('精魂升级失败！', c_Red, t_Hint);
    end;
  end;
end;

function CalculateMaterialUpgradeRate(Materials: array of pTRefineMaterial): Integer;
var
  i: Integer;
  nRate: Integer;
begin
  Result := 0;
  
  for i := 0 to High(Materials) do begin
    if Materials[i] <> nil then begin
      // 5阶材料基础10%，每阶增加5%
      nRate := g_EssenceUpgradeConfig.nBaseMaterialRate + 
               (Materials[i].btGrade - 5) * g_EssenceUpgradeConfig.nMaterialRateBonus;
      
      Inc(Result, nRate);
    end;
  end;
  
  // 成功率上限100%
  if Result > 1000 then
    Result := 1000;
end;

function CanUpgradeEssence(Essence: pTUserItem; Materials: array of pTRefineMaterial): Boolean;
var
  SoulInfo: pTSoulInfo;
  i: Integer;
begin
  Result := False;
  
  if Essence = nil then Exit;
  if Length(Materials) = 0 then Exit;
  if Length(Materials) > g_EssenceUpgradeConfig.nMaxMaterialCount then Exit;
  
  SoulInfo := GetSoulInfo(Essence);
  if (SoulInfo = nil) or (SoulInfo.SoulType <> st_Essence) then Exit;
  if SoulInfo.btLevel >= g_EssenceUpgradeConfig.nMaxLevel then Exit;
  
  // 检查材料品阶（至少5阶）
  for i := 0 to High(Materials) do begin
    if (Materials[i] = nil) or (Materials[i].btGrade < 5) then Exit;
  end;
  
  Result := True;
end;

// ========== 特殊效果系统 ==========

procedure GenerateRandomEffects(Soul: pTSoulInfo);
var
  nRandom: Integer;
  nEffectCount: Integer;
  i, j: Integer;
  EffectType: TSoulEffectType;
  bEffectExists: Boolean;
begin
  if Soul = nil then Exit;
  
  // 清空现有效果
  Soul.btEffectCount := 0;
  FillChar(Soul.Effects, SizeOf(Soul.Effects), 0);
  
  // 随机决定是否获得特殊效果
  nRandom := Random(1000);
  if nRandom >= g_SoulSynthesisConfig.nEffectChance then Exit;
  
  // 随机生成0-2个特殊效果
  nEffectCount := Random(g_SoulSynthesisConfig.nMaxEffectCount + 1);
  
  for i := 0 to nEffectCount - 1 do begin
    // 随机选择效果类型
    repeat
      EffectType := TSoulEffectType(1 + Random(3)); // 1-3
      
      // 检查是否已存在相同效果
      bEffectExists := False;
      for j := 0 to Soul.btEffectCount - 1 do begin
        if Soul.Effects[j].EffectType = EffectType then begin
          bEffectExists := True;
          Break;
        end;
      end;
    until not bEffectExists;
    
    // 添加特殊效果
    with Soul.Effects[Soul.btEffectCount] do begin
      EffectType := EffectType;
      nTriggerRate := 100; // 10%触发几率
      boEnabled := True;
      
      case EffectType of
        set_SoulStrike: nEffectValue := 100;  // 造成当前生命值10%伤害
        set_SoulStun: nEffectValue := 2000;   // 震慑2秒
        set_EvilAttack: nEffectValue := 330;  // 额外33%伤害
      end;
    end;
    
    Inc(Soul.btEffectCount);
  end;
end;

function ApplySoulEffects(PlayObject: TPlayObject; Soul: pTSoulInfo): Boolean;
var
  i: Integer;
  Effect: TSoulEffect;
begin
  Result := False;
  if (PlayObject = nil) or (Soul = nil) then Exit;
  
  for i := 0 to Soul.btEffectCount - 1 do begin
    Effect := Soul.Effects[i];
    if not Effect.boEnabled then Continue;
    
    // 随机判定是否触发
    if Random(1000) < Effect.nTriggerRate then begin
      case Effect.EffectType of
        set_SoulStrike: begin
          // TODO: 实现灵魂一击效果
          // 对目标造成当前生命值10%的真实伤害
          MainOutMessage('[调试] 触发灵魂一击效果');
        end;
        set_SoulStun: begin
          // TODO: 实现灵魂震慑效果
          // 对目标造成2秒震慑效果
          MainOutMessage('[调试] 触发灵魂震慑效果');
        end;
        set_EvilAttack: begin
          // TODO: 实现邪恶攻击效果
          // 对人物额外造成33%伤害
          MainOutMessage('[调试] 触发邪恶攻击效果');
        end;
      end;
      Result := True;
    end;
  end;
end;

function GetEffectDescription(Effect: TSoulEffect): string;
begin
  case Effect.EffectType of
    set_SoulStrike: Result := '灵魂一击: ' + IntToStr(Effect.nTriggerRate div 10) + '%几率造成目标当前生命值' + 
                              IntToStr(Effect.nEffectValue div 10) + '%真实伤害';
    set_SoulStun: Result := '灵魂震慑: ' + IntToStr(Effect.nTriggerRate div 10) + '%几率震慑目标' + 
                            IntToStr(Effect.nEffectValue div 1000) + '秒';
    set_EvilAttack: Result := '邪恶攻击: ' + IntToStr(Effect.nTriggerRate div 10) + '%几率对人物造成额外' + 
                              IntToStr(Effect.nEffectValue div 10) + '%伤害';
    else Result := '未知效果';
  end;
end;

// ========== 元魄/精魂管理 ==========

function GetSoulInfo(Item: pTUserItem): pTSoulInfo;
begin
  Result := nil;
  if Item = nil then Exit;
  
  // TODO: 从物品的扩展数据中获取元魄/精魂信息
  // 这里需要根据实际的物品数据结构来实现
  // 临时实现：从temp1数组中获取
  if SizeOf(TSoulInfo) <= SizeOf(Item.temp1) then begin
    New(Result);
    Move(Item.temp1[0], Result^, SizeOf(TSoulInfo));
  end;
end;

procedure SetSoulInfo(Item: pTUserItem; SoulInfo: TSoulInfo);
begin
  if Item = nil then Exit;
  
  // TODO: 将元魄/精魂信息保存到物品的扩展数据中
  // 临时实现：保存到temp1数组中
  if SizeOf(TSoulInfo) <= SizeOf(Item.temp1) then begin
    Move(SoulInfo, Item.temp1[0], SizeOf(TSoulInfo));
  end;
end;

function CreateDefaultSoulInfo(JobType: TSoulJobType; SoulType: TSoulType): TSoulInfo;
begin
  FillChar(Result, SizeOf(Result), 0);
  
  with Result do begin
    wIndex := 8000 + Ord(JobType) * 10 + Ord(SoulType); // 基础索引
    SoulType := SoulType;
    JobType := JobType;
    btLevel := 0;
    
    if SoulType = st_Soul then begin
      // 元魄基础属性
      nDamageDeepen := 100;   // 伤害加深+10%
      nDamageAbsorb := 100;   // 伤害吸收+10%
    end else begin
      // 精魂基础属性
      nDamageDeepen := 150;   // 伤害加深+15%
      nDamageAbsorb := 150;   // 伤害吸收+15%
    end;
    
    btEffectCount := 0;
    sName := GetSoulDisplayName(Result);
  end;
end;

function GetJobTypeName(JobType: TSoulJobType): string;
begin
  case JobType of
    sjt_Warrior: Result := '战';
    sjt_Wizard: Result := '法';
    sjt_Taoist: Result := '道';
    else Result := '未知';
  end;
end;

function GetSoulTypeName(SoulType: TSoulType): string;
begin
  case SoulType of
    st_Soul: Result := '元魄';
    st_Essence: Result := '精魂';
    else Result := '未知';
  end;
end;

function GetSoulDisplayName(Soul: TSoulInfo): string;
var
  sJobName, sSoulName: string;
begin
  sJobName := GetJobTypeName(Soul.JobType);
  
  if Soul.SoulType = st_Soul then begin
    sSoulName := sJobName + '之元魄';
  end else begin
    case Soul.JobType of
      sjt_Warrior: sSoulName := '战圣精魂';
      sjt_Wizard: sSoulName := '法神精魂';
      sjt_Taoist: sSoulName := '道尊精魂';
      else sSoulName := sJobName + '精魂';
    end;
    
    if Soul.btLevel > 0 then
      sSoulName := sSoulName + '+' + IntToStr(Soul.btLevel);
  end;
  
  Result := sSoulName;
end;

// ========== 配置文件管理 ==========

function LoadSoulConfigs(const sFileName: string): Boolean;
var
  sFullPath: string;
  IniFile: TIniFile;
begin
  Result := False;
  sFullPath := g_Config.sGameDataDir + sFileName;
  
  try
    if FileExists(sFullPath) then begin
      IniFile := TIniFile.Create(sFullPath);
      try
        // 加载元魄合成配置
        with g_SoulSynthesisConfig do begin
          boEnabled := IniFile.ReadBool('SoulSynthesis', 'Enabled', True);
          nMinQualityLevel := IniFile.ReadInteger('SoulSynthesis', 'MinQualityLevel', 3);
          nMaxEquipmentCount := IniFile.ReadInteger('SoulSynthesis', 'MaxEquipmentCount', 4);
          nBaseSuccessRate := IniFile.ReadInteger('SoulSynthesis', 'BaseSuccessRate', 100);
          nQualityBonus := IniFile.ReadInteger('SoulSynthesis', 'QualityBonus', 100);
          nEffectChance := IniFile.ReadInteger('SoulSynthesis', 'EffectChance', 300);
          nMaxEffectCount := IniFile.ReadInteger('SoulSynthesis', 'MaxEffectCount', 2);
        end;
        
        // 加载精魂升级配置
        with g_EssenceUpgradeConfig do begin
          boEnabled := IniFile.ReadBool('EssenceUpgrade', 'Enabled', True);
          nMinQualityForUpgrade := IniFile.ReadInteger('EssenceUpgrade', 'MinQualityForUpgrade', 8);
          nMaxLevel := IniFile.ReadInteger('EssenceUpgrade', 'MaxLevel', 9);
          nSafeLevelThreshold := IniFile.ReadInteger('EssenceUpgrade', 'SafeLevelThreshold', 6);
          nBaseMaterialRate := IniFile.ReadInteger('EssenceUpgrade', 'BaseMaterialRate', 100);
          nMaterialRateBonus := IniFile.ReadInteger('EssenceUpgrade', 'MaterialRateBonus', 50);
          nMaxMaterialCount := IniFile.ReadInteger('EssenceUpgrade', 'MaxMaterialCount', 3);
          nLevelDamageBonus := IniFile.ReadInteger('EssenceUpgrade', 'LevelDamageBonus', 20);
          nLevelAbsorbBonus := IniFile.ReadInteger('EssenceUpgrade', 'LevelAbsorbBonus', 20);
        end;
        
        MainOutMessage('[提示] 元魄/精魂系统配置加载成功');
        Result := True;
      finally
        IniFile.Free;
      end;
    end else begin
      // 创建默认配置文件
      IniFile := TIniFile.Create(sFullPath);
      try
        // 写入元魄合成配置
        with g_SoulSynthesisConfig do begin
          IniFile.WriteBool('SoulSynthesis', 'Enabled', boEnabled);
          IniFile.WriteInteger('SoulSynthesis', 'MinQualityLevel', nMinQualityLevel);
          IniFile.WriteInteger('SoulSynthesis', 'MaxEquipmentCount', nMaxEquipmentCount);
          IniFile.WriteInteger('SoulSynthesis', 'BaseSuccessRate', nBaseSuccessRate);
          IniFile.WriteInteger('SoulSynthesis', 'QualityBonus', nQualityBonus);
          IniFile.WriteInteger('SoulSynthesis', 'EffectChance', nEffectChance);
          IniFile.WriteInteger('SoulSynthesis', 'MaxEffectCount', nMaxEffectCount);
          
          IniFile.WriteString('SoulSynthesis', '; 说明', '精致品质基础成功率10%，每级增加10%');
        end;
        
        // 写入精魂升级配置
        with g_EssenceUpgradeConfig do begin
          IniFile.WriteBool('EssenceUpgrade', 'Enabled', boEnabled);
          IniFile.WriteInteger('EssenceUpgrade', 'MinQualityForUpgrade', nMinQualityForUpgrade);
          IniFile.WriteInteger('EssenceUpgrade', 'MaxLevel', nMaxLevel);
          IniFile.WriteInteger('EssenceUpgrade', 'SafeLevelThreshold', nSafeLevelThreshold);
          IniFile.WriteInteger('EssenceUpgrade', 'BaseMaterialRate', nBaseMaterialRate);
          IniFile.WriteInteger('EssenceUpgrade', 'MaterialRateBonus', nMaterialRateBonus);
          IniFile.WriteInteger('EssenceUpgrade', 'MaxMaterialCount', nMaxMaterialCount);
          IniFile.WriteInteger('EssenceUpgrade', 'LevelDamageBonus', nLevelDamageBonus);
          IniFile.WriteInteger('EssenceUpgrade', 'LevelAbsorbBonus', nLevelAbsorbBonus);
          
          IniFile.WriteString('EssenceUpgrade', '; 说明', '5阶材料基础成功率10%，每阶增加5%');
        end;
        
        MainOutMessage('[提示] 创建默认元魄/精魂系统配置文件');
        Result := True;
      finally
        IniFile.Free;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage('[异常] 加载元魄/精魂系统配置失败: ' + E.Message);
      Result := False;
    end;
  end;
end;

// ========== 辅助函数 ==========

function GetPlayerJobType(PlayObject: TPlayObject): TSoulJobType;
begin
  if PlayObject = nil then begin
    Result := sjt_Warrior;
    Exit;
  end;
  
  case PlayObject.m_btJob of
    0: Result := sjt_Warrior;  // 战士
    1: Result := sjt_Wizard;   // 法师
    2: Result := sjt_Taoist;   // 道士
    else Result := sjt_Warrior;
  end;
end;

function ValidateEquipmentArray(Equipments: array of pTUserItem): Boolean;
var
  i: Integer;
  nValidCount: Integer;
begin
  Result := False;
  nValidCount := 0;
  
  for i := 0 to High(Equipments) do begin
    if Equipments[i] <> nil then
      Inc(nValidCount);
  end;
  
  if (nValidCount = 0) or (nValidCount > g_SoulSynthesisConfig.nMaxEquipmentCount) then
    Exit;
  
  Result := True;
end;

function ValidateMaterialArray(Materials: array of pTRefineMaterial): Boolean;
var
  i: Integer;
  nValidCount: Integer;
begin
  Result := False;
  nValidCount := 0;
  
  for i := 0 to High(Materials) do begin
    if Materials[i] <> nil then
      Inc(nValidCount);
  end;
  
  if (nValidCount = 0) or (nValidCount > g_EssenceUpgradeConfig.nMaxMaterialCount) then
    Exit;
  
  Result := True;
end;

end.
