unit RefineSystem;

interface

uses
  Windows, SysUtils, Classes, Grobal2, M2Share, ObjBase, ObjPlay, LocalDB;

// 凝练系统核心函数
function InitializeRefineSystem: Boolean;
procedure FinalizeRefineSystem;

// 凝练材料管理
function LoadRefineMaterials(const sFileName: string): Boolean;
function GetRefineMaterial(wIndex: Word): pTRefineMaterial;
function IsRefineMaterial(wIndex: Word): Boolean;

// 材料合成
function SynthesizeMaterial(PlayObject: TPlayObject; SourceGrade: Byte; Count: Integer): TRefineResult;
function CanSynthesizeMaterial(SourceGrade: Byte): Boolean;

// 凝练成功率计算
function CalculateRefineSuccessRate(RefineLevel: Byte; Materials: array of pTRefineMaterial): Integer;

// 装备凝练
function RefineEquipment(PlayObject: TPlayObject; Equipment: pTUserItem; Materials: array of pTRefineMaterial): TRefineResult;
function CanRefineEquipment(Equipment: pTUserItem): Boolean;
function GetEquipmentRefineLevel(Equipment: pTUserItem): Byte;
function GetEquipmentMaxRefineLevel(Equipment: pTUserItem): Byte;

// 凝练属性加成
procedure ApplyRefineBonus(Equipment: pTUserItem);
procedure ClearRefineBonus(Equipment: pTUserItem);
function GetRefineAttributeBonus(Equipment: pTUserItem; AttrType: Integer): Word;

// 新的凝练属性系统
function CalculateMaterialAttributePoints(Materials: array of pTRefineMaterial): Integer;
procedure GenerateRefineAttributes(Equipment: pTUserItem; nAttributePoints: Integer);
function GetRefineQuality(nTotalPoints: Word): TRefineQuality;
function GetRefineQualityName(Quality: TRefineQuality): string;
function GetRefineQualityColor(Quality: TRefineQuality): Integer;
procedure ApplyRefineAttributesToPlayer(PlayObject: TPlayObject; Equipment: pTUserItem);
function GetAttributeDisplayText(Attribute: TRefineAttribute): string;

// 灵魂绑定系统
function CanSoulBindEquipment(Equipment: pTUserItem): Boolean;
function SoulBindEquipment(PlayObject: TPlayObject; Equipment: pTUserItem): TSoulBindResult;
function GetSoulBindCost: Integer;
function GetSoulBindCurrencyName: string;
function GetSoulBindBonus(Quality: TRefineQuality): record HP, MP: Word; end;
function IsEquipmentSoulBound(Equipment: pTUserItem): Boolean;
procedure ApplySoulBindBonus(PlayObject: TPlayObject; Equipment: pTUserItem);
function GetSoulBindDisplayText(Equipment: pTUserItem): string;

// 辅助函数
function GetRefineInfo(Equipment: pTUserItem): pTRefineInfo;
procedure SetRefineInfo(Equipment: pTUserItem; RefineInfo: TRefineInfo);
function CreateDefaultRefineInfo: TRefineInfo;

implementation

// ========== 系统初始化和清理 ==========

function InitializeRefineSystem: Boolean;
begin
  Result := False;
  try
    // 加载凝练系统配置
    if not FrmDB.LoadRefineConfig then begin
      MainOutMessage('[警告] 凝练系统配置加载失败，使用默认配置');
    end;
    
    // 加载灵魂绑定系统配置
    if not FrmDB.LoadSoulBindConfig then begin
      MainOutMessage('[警告] 灵魂绑定系统配置加载失败，使用默认配置');
    end;
    
    // 加载融化系统配置
    if not FrmDB.LoadMeltingConfig then begin
      MainOutMessage('[警告] 融化系统配置加载失败，使用默认配置');
    end;
    
    // 加载元魄/精魂系统配置
    if not FrmDB.LoadSoulSystemConfig then begin
      MainOutMessage('[警告] 元魄/精魂系统配置加载失败，使用默认配置');
    end;
    
    // 加载凝练材料配置
    if FrmDB.LoadRefineMaterials = 0 then begin
      MainOutMessage('[警告] 凝练材料配置为空');
    end;
    
    g_boRefineSystemEnabled := g_RefineConfig.boEnabled;
    g_boSoulBindSystemEnabled := g_SoulBindConfig.boEnabled;
    Result := True;
  except
    on E: Exception do begin
      MainOutMessage('[异常] 凝练系统初始化失败: ' + E.Message);
      Result := False;
    end;
  end;
end;

procedure FinalizeRefineSystem;
begin
  // 清理工作已在M2Share.pas的finalization中完成
end;

// ========== 凝练材料管理 ==========

function LoadRefineMaterials(const sFileName: string): Boolean;
begin
  // 现在通过LocalDB加载材料配置
  Result := FrmDB.LoadRefineMaterials > 0;
end;

procedure CreateDefaultMaterials;
var
  i: Integer;
  RefineMaterial: pTRefineMaterial;
begin
  // 创建默认的1-5阶凝练材料
  for i := 1 to 5 do begin
    New(RefineMaterial);
    with RefineMaterial^ do begin
      wIndex := 5000 + i;
      sName := '凝练石(' + IntToStr(i) + '阶)';
      btGrade := i;
      MaterialType := rmt_Basic;
      nBaseSuccessRate := g_RefineConfig.nBaseSuccessRate;
      nGradeBonus := g_RefineConfig.nGradeBonus;
      boCanSynthesize := True;
      nSynthesizeCount := 4;
    end;
    g_RefineMaterialList.Add(RefineMaterial);
  end;
end;

function GetRefineMaterial(wIndex: Word): pTRefineMaterial;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to g_RefineMaterialList.Count - 1 do begin
    if pTRefineMaterial(g_RefineMaterialList[i]).wIndex = wIndex then begin
      Result := g_RefineMaterialList[i];
      Break;
    end;
  end;
end;

function IsRefineMaterial(wIndex: Word): Boolean;
begin
  Result := GetRefineMaterial(wIndex) <> nil;
end;

// ========== 材料合成 ==========

function SynthesizeMaterial(PlayObject: TPlayObject; SourceGrade: Byte; Count: Integer): TRefineResult;
var
  TargetGrade: Byte;
  RequiredCount: Integer;
begin
  Result := rr_Failed;
  
  // 检查系统是否启用
  if not g_boRefineSystemEnabled then begin
    Result := rr_SystemDisabled;
    Exit;
  end;
  
  // 检查是否可以合成
  if SourceGrade >= g_RefineConfig.btMaxGrade then begin
    Result := rr_MaxLevel;
    Exit;
  end;
  
  RequiredCount := 4; // 默认4份合成1份
  if Count < RequiredCount then begin
    Result := rr_MaterialLack;
    Exit;
  end;
  
  TargetGrade := SourceGrade + 1;
  
  // 合成成功率100%
  // TODO: 实现实际的合成逻辑，包括消耗材料和生成新材料
  Result := rr_Success;
end;

function CanSynthesizeMaterial(SourceGrade: Byte): Boolean;
begin
  Result := (SourceGrade < g_RefineConfig.btMaxGrade) and g_boRefineSystemEnabled;
end;

// ========== 凝练成功率计算 ==========

function CalculateRefineSuccessRate(RefineLevel: Byte; Materials: array of pTRefineMaterial): Integer;
var
  i: Integer;
  nTotalRate: Integer;
  nMaterialRate: Integer;
  Material: pTRefineMaterial;
begin
  Result := 0;
  nTotalRate := 0;
  
  // 计算每份材料的成功率
  for i := Low(Materials) to High(Materials) do begin
    Material := Materials[i];
    if Material = nil then Continue;
    
    // 基础成功率 + 品阶加成 - 次数惩罚
    nMaterialRate := g_RefineConfig.nBaseSuccessRate + 
                     (Material.btGrade - 1) * g_RefineConfig.nGradeBonus - 
                     RefineLevel * g_RefineConfig.nLevelPenalty;
    
    // 累加到总成功率
    nTotalRate := nTotalRate + nMaterialRate;
  end;
  
  // 成功率限制在0-1000之间 (‰)
  if nTotalRate > 1000 then
    Result := 1000
  else if nTotalRate < 0 then
    Result := 0
  else
    Result := nTotalRate;
end;

// ========== 装备凝练 ==========

function RefineEquipment(PlayObject: TPlayObject; Equipment: pTUserItem; Materials: array of pTRefineMaterial): TRefineResult;
var
  nSuccessRate: Integer;
  nRandom: Integer;
  nAttributePoints: Integer;
  RefineInfo: pTRefineInfo;
begin
  Result := rr_Failed;
  
  // 检查系统是否启用
  if not g_boRefineSystemEnabled then begin
    Result := rr_SystemDisabled;
    Exit;
  end;
  
  // 检查装备是否可以凝练
  if not CanRefineEquipment(Equipment) then begin
    Result := rr_InvalidItem;
    Exit;
  end;
  
  RefineInfo := GetRefineInfo(Equipment);
  
  // 检查是否已达最大凝练次数
  if RefineInfo.btRefineLevel >= RefineInfo.btMaxRefineLevel then begin
    Result := rr_MaxLevel;
    Exit;
  end;
  
  // 检查材料数量
  if Length(Materials) <> g_RefineConfig.nMaterialRequired then begin
    Result := rr_MaterialLack;
    Exit;
  end;
  
  // 计算成功率
  nSuccessRate := CalculateRefineSuccessRate(RefineInfo.btRefineLevel, Materials);
  
  // 计算本次获得的属性点数
  nAttributePoints := CalculateMaterialAttributePoints(Materials);
  
  // 随机判定
  nRandom := Random(1000);
  if nRandom < nSuccessRate then begin
    // 凝练成功
    Inc(RefineInfo.btRefineLevel);
    
    // 生成随机属性
    GenerateRefineAttributes(Equipment, nAttributePoints);
    
    // 更新装备信息
    RefineInfo := GetRefineInfo(Equipment);
    RefineInfo.RefineQuality := GetRefineQuality(RefineInfo.nTotalAttributePoints);
    SetRefineInfo(Equipment, RefineInfo^);
    
    // 应用属性到玩家
    ApplyRefineAttributesToPlayer(PlayObject, Equipment);
    
    Result := rr_Success;
    
    // 发送成功消息
    PlayObject.SysMsg('装备凝练成功！当前凝练等级：+' + IntToStr(RefineInfo.btRefineLevel) + 
                      ' 品质：' + GetRefineQualityName(RefineInfo.RefineQuality), c_Green, t_Hint);
    PlayObject.SysMsg('获得属性点数：' + IntToStr(nAttributePoints) + 
                      ' 总属性点数：' + IntToStr(RefineInfo.nTotalAttributePoints), c_Blue, t_Hint);
  end else begin
    // 凝练失败
    Result := rr_Failed;
    PlayObject.SysMsg('装备凝练失败！', c_Red, t_Hint);
  end;
  
  // 消耗材料
  // TODO: 实现实际的材料消耗逻辑
end;

function CanRefineEquipment(Equipment: pTUserItem): Boolean;
var
  StdItem: pTStdItem;
begin
  Result := False;
  if Equipment = nil then Exit;
  
  StdItem := UserEngine.GetStdItem(Equipment.wIndex);
  if StdItem = nil then Exit;
  
  // 检查装备类型是否可以凝练
  // 武器、防具可以凝练
  Result := StdItem.StdMode in [5, 6, 10, 11, 15];
end;

function GetEquipmentRefineLevel(Equipment: pTUserItem): Byte;
var
  RefineInfo: pTRefineInfo;
begin
  RefineInfo := GetRefineInfo(Equipment);
  Result := RefineInfo.btRefineLevel;
end;

function GetEquipmentMaxRefineLevel(Equipment: pTUserItem): Byte;
var
  RefineInfo: pTRefineInfo;
begin
  RefineInfo := GetRefineInfo(Equipment);
  Result := RefineInfo.btMaxRefineLevel;
end;

// ========== 凝练属性加成 ==========

procedure ApplyRefineBonus(Equipment: pTUserItem);
var
  StdItem: pTStdItem;
  RefineInfo: pTRefineInfo;
  RefineLevel: Byte;
  BonusRate: Double;
begin
  StdItem := UserEngine.GetStdItem(Equipment.wIndex);
  if StdItem = nil then Exit;
  
  RefineInfo := GetRefineInfo(Equipment);
  RefineLevel := RefineInfo.btRefineLevel;
  if RefineLevel = 0 then Exit;
  
  // 凝练加成比例 (每级+5%)
  BonusRate := RefineLevel * 0.05;
  
  // 应用到装备属性
  with RefineInfo^ do begin
    // 清空之前的加成
    FillChar(wRefineAttrib, SizeOf(wRefineAttrib), 0);
    
    // 攻击力加成
    if StdItem.DC > 0 then
      wRefineAttrib[0] := Round(StdItem.DC * BonusRate);
    if StdItem.MC > 0 then
      wRefineAttrib[1] := Round(StdItem.MC * BonusRate);
    if StdItem.SC > 0 then
      wRefineAttrib[2] := Round(StdItem.SC * BonusRate);
      
    // 防御力加成
    if StdItem.AC > 0 then
      wRefineAttrib[3] := Round(StdItem.AC * BonusRate);
    if StdItem.MAC > 0 then
      wRefineAttrib[4] := Round(StdItem.MAC * BonusRate);
  end;
  
  // 更新装备信息
  SetRefineInfo(Equipment, RefineInfo^);
end;

procedure ClearRefineBonus(Equipment: pTUserItem);
var
  RefineInfo: pTRefineInfo;
begin
  RefineInfo := GetRefineInfo(Equipment);
  FillChar(RefineInfo.wRefineAttrib, SizeOf(RefineInfo.wRefineAttrib), 0);
  SetRefineInfo(Equipment, RefineInfo^);
end;

function GetRefineAttributeBonus(Equipment: pTUserItem; AttrType: Integer): Word;
var
  RefineInfo: pTRefineInfo;
begin
  Result := 0;
  RefineInfo := GetRefineInfo(Equipment);
  if (AttrType >= 0) and (AttrType <= High(RefineInfo.wLegacyAttrib)) then
    Result := RefineInfo.wLegacyAttrib[AttrType];
end;

// ========== 新的凝练属性系统 ==========

function CalculateMaterialAttributePoints(Materials: array of pTRefineMaterial): Integer;
var
  i: Integer;
  Material: pTRefineMaterial;
  nMinValue, nMaxValue: Integer;
  nMaterialPoints: Integer;
begin
  Result := 0;
  
  for i := Low(Materials) to High(Materials) do begin
    Material := Materials[i];
    if Material = nil then Continue;
    
    // 计算随机区间：最小值=材料品阶/2（四舍五入），最大值=材料品阶，超过10封顶
    nMinValue := Round(Material.btGrade / 2.0);
    if nMinValue < 1 then nMinValue := 1;
    
    nMaxValue := Material.btGrade;
    if nMaxValue > 10 then nMaxValue := 10;
    
    // 在区间内随机获得属性点数
    nMaterialPoints := nMinValue + Random(nMaxValue - nMinValue + 1);
    Result := Result + nMaterialPoints;
  end;
end;

procedure GenerateRefineAttributes(Equipment: pTUserItem; nAttributePoints: Integer);
var
  RefineInfo: pTRefineInfo;
  nRemainingPoints: Integer;
  nRandomAttr: Integer;
  nRandomValue: Integer;
  AttributeType: TRefineAttributeType;
  i: Integer;
begin
  RefineInfo := GetRefineInfo(Equipment);
  nRemainingPoints := nAttributePoints;
  
  // 随机分配属性点数到不同的属性上
  while nRemainingPoints > 0 do begin
    // 随机选择一个属性类型
    nRandomAttr := Random(Ord(High(TRefineAttributeType)) + 1);
    AttributeType := TRefineAttributeType(nRandomAttr);
    
    // 检查该属性是否启用
    if not g_RefineAttributeConfigs[AttributeType].boEnabled then Continue;
    
    // 随机分配1-min(剩余点数,10)点到该属性
    nRandomValue := 1 + Random(Min(nRemainingPoints, 10));
    
    // 查找是否已存在该属性
    for i := 0 to High(RefineInfo.RefineAttributes) do begin
      if RefineInfo.RefineAttributes[i].AttributeType = AttributeType then begin
        // 累加到现有属性
        Inc(RefineInfo.RefineAttributes[i].nValue, nRandomValue);
        if RefineInfo.RefineAttributes[i].nValue > 10 then
          RefineInfo.RefineAttributes[i].nValue := 10;
        RefineInfo.RefineAttributes[i].boEnabled := True;
        Break;
      end else if not RefineInfo.RefineAttributes[i].boEnabled then begin
        // 添加新属性
        RefineInfo.RefineAttributes[i].AttributeType := AttributeType;
        RefineInfo.RefineAttributes[i].nValue := nRandomValue;
        RefineInfo.RefineAttributes[i].boEnabled := True;
        Break;
      end;
    end;
    
    Dec(nRemainingPoints, nRandomValue);
  end;
  
  // 更新总属性点数
  Inc(RefineInfo.nTotalAttributePoints, nAttributePoints);
  
  // 保存更新后的信息
  SetRefineInfo(Equipment, RefineInfo^);
end;

function GetRefineQuality(nTotalPoints: Word): TRefineQuality;
var
  Quality: TRefineQuality;
begin
  Result := rq_Rough; // 默认粗糙品质
  
  // 从高到低检查品质等级
  for Quality := High(TRefineQuality) downto Low(TRefineQuality) do begin
    if nTotalPoints >= g_RefineQualityConfigs[Quality].nMinPoints then begin
      Result := Quality;
      Break;
    end;
  end;
end;

function GetRefineQualityName(Quality: TRefineQuality): string;
begin
  Result := g_RefineQualityConfigs[Quality].sName;
end;

function GetRefineQualityColor(Quality: TRefineQuality): Integer;
begin
  Result := g_RefineQualityConfigs[Quality].nColor;
end;

procedure ApplyRefineAttributesToPlayer(PlayObject: TPlayObject; Equipment: pTUserItem);
var
  RefineInfo: pTRefineInfo;
  i: Integer;
  Attribute: TRefineAttribute;
  AttributeConfig: TRefineAttributeConfig;
  nActualValue: Integer;
begin
  if PlayObject = nil then Exit;
  
  RefineInfo := GetRefineInfo(Equipment);
  
  // 遍历所有凝练属性并应用到玩家
  for i := 0 to High(RefineInfo.RefineAttributes) do begin
    Attribute := RefineInfo.RefineAttributes[i];
    if not Attribute.boEnabled then Continue;
    
    AttributeConfig := g_RefineAttributeConfigs[Attribute.AttributeType];
    
    // 根据属性类型计算实际数值
    case Attribute.AttributeType of
      rat_HP_Fixed: begin
        nActualValue := (Attribute.nValue * AttributeConfig.nFixedRatio) div 100;
        Inc(PlayObject.m_WAbil.HP, nActualValue);
      end;
      rat_HP_Percent: begin
        nActualValue := (PlayObject.m_WAbil.HP * Attribute.nValue * AttributeConfig.nPercentRatio) div 1000;
        Inc(PlayObject.m_WAbil.HP, nActualValue);
      end;
      rat_MP_Fixed: begin
        nActualValue := (Attribute.nValue * AttributeConfig.nFixedRatio) div 100;
        Inc(PlayObject.m_WAbil.MP, nActualValue);
      end;
      rat_MP_Percent: begin
        nActualValue := (PlayObject.m_WAbil.MP * Attribute.nValue * AttributeConfig.nPercentRatio) div 1000;
        Inc(PlayObject.m_WAbil.MP, nActualValue);
      end;
      rat_DC_Fixed: begin
        nActualValue := (Attribute.nValue * AttributeConfig.nFixedRatio) div 100;
        Inc(PlayObject.m_WAbil.DC, nActualValue);
      end;
      rat_DC_Percent: begin
        nActualValue := (PlayObject.m_WAbil.DC * Attribute.nValue * AttributeConfig.nPercentRatio) div 1000;
        Inc(PlayObject.m_WAbil.DC, nActualValue);
      end;
      rat_MC_Fixed: begin
        nActualValue := (Attribute.nValue * AttributeConfig.nFixedRatio) div 100;
        Inc(PlayObject.m_WAbil.MC, nActualValue);
      end;
      rat_MC_Percent: begin
        nActualValue := (PlayObject.m_WAbil.MC * Attribute.nValue * AttributeConfig.nPercentRatio) div 1000;
        Inc(PlayObject.m_WAbil.MC, nActualValue);
      end;
      rat_SC_Fixed: begin
        nActualValue := (Attribute.nValue * AttributeConfig.nFixedRatio) div 100;
        Inc(PlayObject.m_WAbil.SC, nActualValue);
      end;
      rat_SC_Percent: begin
        nActualValue := (PlayObject.m_WAbil.SC * Attribute.nValue * AttributeConfig.nPercentRatio) div 1000;
        Inc(PlayObject.m_WAbil.SC, nActualValue);
      end;
      rat_AC_Fixed: begin
        nActualValue := (Attribute.nValue * AttributeConfig.nFixedRatio) div 100;
        Inc(PlayObject.m_WAbil.AC, nActualValue);
      end;
      rat_AC_Percent: begin
        nActualValue := (PlayObject.m_WAbil.AC * Attribute.nValue * AttributeConfig.nPercentRatio) div 1000;
        Inc(PlayObject.m_WAbil.AC, nActualValue);
      end;
      rat_MAC_Fixed: begin
        nActualValue := (Attribute.nValue * AttributeConfig.nFixedRatio) div 100;
        Inc(PlayObject.m_WAbil.MAC, nActualValue);
      end;
      rat_MAC_Percent: begin
        nActualValue := (PlayObject.m_WAbil.MAC * Attribute.nValue * AttributeConfig.nPercentRatio) div 1000;
        Inc(PlayObject.m_WAbil.MAC, nActualValue);
      end;
      // TODO: 实现其他属性类型的应用逻辑
    end;
  end;
end;

function GetAttributeDisplayText(Attribute: TRefineAttribute): string;
var
  AttributeConfig: TRefineAttributeConfig;
  nActualValue: Integer;
begin
  Result := '';
  if not Attribute.boEnabled then Exit;
  
  AttributeConfig := g_RefineAttributeConfigs[Attribute.AttributeType];
  
  // 计算显示数值
  if Pos('百分比', AttributeConfig.sName) > 0 then begin
    nActualValue := (Attribute.nValue * AttributeConfig.nPercentRatio) div 100;
    Result := AttributeConfig.sName + ': +' + IntToStr(nActualValue) + AttributeConfig.sUnit;
  end else begin
    nActualValue := (Attribute.nValue * AttributeConfig.nFixedRatio) div 100;
    Result := AttributeConfig.sName + ': +' + IntToStr(nActualValue) + AttributeConfig.sUnit;
  end;
end;

// ========== 辅助函数 ==========

function GetRefineInfo(Equipment: pTUserItem): pTRefineInfo;
begin
  // 在temp1数组的开始位置存储凝练信息
  // temp1数组有49个字节，TRefineInfo需要约34个字节，足够使用
  Result := pTRefineInfo(@Equipment.temp1[0]);
  
  // 如果是新装备，初始化凝练信息
  if (Result.btRefineLevel = 0) and (Result.btMaxRefineLevel = 0) then begin
    Result^ := CreateDefaultRefineInfo;
  end;
end;

procedure SetRefineInfo(Equipment: pTUserItem; RefineInfo: TRefineInfo);
begin
  // 将凝练信息保存到temp1数组
  Move(RefineInfo, Equipment.temp1[0], SizeOf(TRefineInfo));
end;

function CreateDefaultRefineInfo: TRefineInfo;
begin
  with Result do begin
    btRefineLevel := 0;
    btMaxRefineLevel := g_RefineConfig.btDefaultMaxLevel;
    RefineQuality := rq_Rough;
    nTotalAttributePoints := 0;
    FillChar(RefineAttributes, SizeOf(RefineAttributes), 0);
    FillChar(SoulBindInfo, SizeOf(SoulBindInfo), 0);
    FillChar(HoleInfo, SizeOf(HoleInfo), 0);
    FillChar(wLegacyAttrib, SizeOf(wLegacyAttrib), 0);
  end;
end;

// ========== 灵魂绑定系统 ==========

function CanSoulBindEquipment(Equipment: pTUserItem): Boolean;
var
  RefineInfo: pTRefineInfo;
begin
  Result := False;
  
  // 检查系统是否启用
  if not g_boSoulBindSystemEnabled then Exit;
  
  // 检查装备是否有效
  if Equipment = nil then Exit;
  
  RefineInfo := GetRefineInfo(Equipment);
  
  // 检查是否已经绑定
  if RefineInfo.SoulBindInfo.boSoulBound then Exit;
  
  // 检查品质是否达到要求
  if Ord(RefineInfo.RefineQuality) < g_SoulBindConfig.nMinQualityLevel then Exit;
  
  // 检查该品质是否支持灵魂绑定
  Result := g_RefineQualityConfigs[RefineInfo.RefineQuality].boCanSoulBind;
end;

function SoulBindEquipment(PlayObject: TPlayObject; Equipment: pTUserItem): TSoulBindResult;
var
  RefineInfo: pTRefineInfo;
  QualityConfig: TRefineQualityConfig;
  nCost: Integer;
begin
  Result := sbr_Failed;
  
  // 检查系统是否启用
  if not g_boSoulBindSystemEnabled then begin
    Result := sbr_SystemDisabled;
    Exit;
  end;
  
  // 检查装备是否可以绑定
  if not CanSoulBindEquipment(Equipment) then begin
    RefineInfo := GetRefineInfo(Equipment);
    if RefineInfo.SoulBindInfo.boSoulBound then
      Result := sbr_AlreadyBound
    else if Ord(RefineInfo.RefineQuality) < g_SoulBindConfig.nMinQualityLevel then
      Result := sbr_QualityTooLow
    else
      Result := sbr_InvalidItem;
    Exit;
  end;
  
  RefineInfo := GetRefineInfo(Equipment);
  QualityConfig := g_RefineQualityConfigs[RefineInfo.RefineQuality];
  nCost := g_SoulBindConfig.nCurrencyAmount;
  
  // 检查货币是否足够
  if not CheckPlayerCurrency(PlayObject, g_SoulBindConfig.nCurrencyType, nCost) then begin
    Result := sbr_InsufficientCurrency;
    Exit;
  end;
  
  // 扣除货币
  if not ConsumePlayerCurrency(PlayObject, g_SoulBindConfig.nCurrencyType, nCost) then begin
    Result := sbr_InsufficientCurrency;
    Exit;
  end;
  
  // 执行灵魂绑定
  with RefineInfo.SoulBindInfo do begin
    boSoulBound := True;
    nBindHP := QualityConfig.nSoulBindHP;
    nBindMP := QualityConfig.nSoulBindMP;
    dwBindTime := GetTickCount;
    sBindPlayerName := PlayObject.m_sCharName;
  end;
  
  // 保存装备信息
  SetRefineInfo(Equipment, RefineInfo^);
  
  // 应用灵魂绑定加成
  ApplySoulBindBonus(PlayObject, Equipment);
  
  Result := sbr_Success;
  
  // 发送成功消息
  PlayObject.SysMsg('装备灵魂绑定成功！获得 +' + IntToStr(QualityConfig.nSoulBindHP) + 'HP +' + 
                    IntToStr(QualityConfig.nSoulBindMP) + 'MP', c_Green, t_Hint);
end;

function GetSoulBindCost: Integer;
begin
  Result := g_SoulBindConfig.nCurrencyAmount;
end;

function GetSoulBindCurrencyName: string;
begin
  Result := g_SoulBindConfig.sCurrencyName;
end;

function GetSoulBindBonus(Quality: TRefineQuality): record HP, MP: Word; end;
begin
  Result.HP := g_RefineQualityConfigs[Quality].nSoulBindHP;
  Result.MP := g_RefineQualityConfigs[Quality].nSoulBindMP;
end;

function IsEquipmentSoulBound(Equipment: pTUserItem): Boolean;
var
  RefineInfo: pTRefineInfo;
begin
  Result := False;
  if Equipment = nil then Exit;
  
  RefineInfo := GetRefineInfo(Equipment);
  Result := RefineInfo.SoulBindInfo.boSoulBound;
end;

procedure ApplySoulBindBonus(PlayObject: TPlayObject; Equipment: pTUserItem);
var
  RefineInfo: pTRefineInfo;
begin
  if PlayObject = nil then Exit;
  
  RefineInfo := GetRefineInfo(Equipment);
  
  if RefineInfo.SoulBindInfo.boSoulBound then begin
    // 应用灵魂绑定的HP和MP加成
    Inc(PlayObject.m_WAbil.HP, RefineInfo.SoulBindInfo.nBindHP);
    Inc(PlayObject.m_WAbil.MP, RefineInfo.SoulBindInfo.nBindMP);
  end;
end;

function GetSoulBindDisplayText(Equipment: pTUserItem): string;
var
  RefineInfo: pTRefineInfo;
begin
  Result := '';
  if Equipment = nil then Exit;
  
  RefineInfo := GetRefineInfo(Equipment);
  
  if RefineInfo.SoulBindInfo.boSoulBound then begin
    Result := '【灵魂绑定】' + RefineInfo.SoulBindInfo.sBindPlayerName + #13#10 +
              '绑定加成: +' + IntToStr(RefineInfo.SoulBindInfo.nBindHP) + 'HP +' + 
              IntToStr(RefineInfo.SoulBindInfo.nBindMP) + 'MP';
  end else if CanSoulBindEquipment(Equipment) then begin
    Result := '可进行灵魂绑定';
  end;
end;

// 辅助函数：检查玩家货币
function CheckPlayerCurrency(PlayObject: TPlayObject; CurrencyType: Byte; Amount: Integer): Boolean;
begin
  Result := False;
  if PlayObject = nil then Exit;
  
  case CurrencyType of
    0: Result := PlayObject.m_nGold >= Amount;        // 金币
    1: Result := PlayObject.m_nGameGold >= Amount;    // 元宝
    2: Result := PlayObject.m_nGamePoint >= Amount;   // 积分
    // 可以扩展其他货币类型
  end;
end;

// 辅助函数：消耗玩家货币
function ConsumePlayerCurrency(PlayObject: TPlayObject; CurrencyType: Byte; Amount: Integer): Boolean;
begin
  Result := False;
  if PlayObject = nil then Exit;
  if not CheckPlayerCurrency(PlayObject, CurrencyType, Amount) then Exit;
  
  case CurrencyType of
    0: begin
      Dec(PlayObject.m_nGold, Amount);
      Result := True;
    end;
    1: begin
      Dec(PlayObject.m_nGameGold, Amount);
      Result := True;
    end;
    2: begin
      Dec(PlayObject.m_nGamePoint, Amount);
      Result := True;
    end;
    // 可以扩展其他货币类型
  end;
  
  if Result then begin
    // 发送货币更新消息
    PlayObject.SendUpdateMsg(PlayObject, SM_CHANGEGOLD, 0, PlayObject.m_nGold, PlayObject.m_nGameGold, PlayObject.m_nGamePoint, '');
  end;
end;

end.
