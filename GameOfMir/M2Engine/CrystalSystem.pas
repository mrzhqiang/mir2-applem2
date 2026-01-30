unit CrystalSystem;

interface

uses
  Windows, SysUtils, Classes, Grobal2, M2Share, ObjBase, ObjPlay, LocalDB, HUtil32, RefineSystem;

// 结晶系统核心函数
function InitializeCrystalSystem: Boolean;
procedure FinalizeCrystalSystem;

// 装备打孔系统
function PunchEquipmentHole(PlayObject: TPlayObject; Equipment: pTUserItem): TPunchResult;
function CanPunchHole(Equipment: pTUserItem): Boolean;
function GetEquipmentHoleCount(Equipment: pTUserItem): Byte;
function HasEmptyHole(Equipment: pTUserItem): Boolean;
procedure GenerateRandomHoles(Equipment: pTUserItem);

// 装备融化系统
function MeltEquipment(PlayObject: TPlayObject; Equipment: pTUserItem): TMeltingResult;
function CanMeltEquipment(Equipment: pTUserItem): Boolean;
function GetMeltingSuccessRate(Equipment: pTUserItem): Integer;
procedure GenerateCrystalFromEquipment(PlayObject: TPlayObject; Equipment: pTUserItem; CrystalCount: Integer);
procedure ReturnMaterialFromMelting(PlayObject: TPlayObject; MaterialGrade: Byte);

// 结晶镶嵌系统
function EmbedCrystal(PlayObject: TPlayObject; Equipment: pTUserItem; Crystal: pTUserItem; HoleIndex: Byte): Boolean;
function RemoveCrystal(PlayObject: TPlayObject; Equipment: pTUserItem; HoleIndex: Byte): Boolean;
function GetCrystalInfo(Crystal: pTUserItem): pTCrystalInfo;
procedure ApplyCrystalEffects(PlayObject: TPlayObject; Equipment: pTUserItem);

// 结晶管理
function LoadCrystals(const sFileName: string): Boolean;
function CreateCrystal(CrystalType: TCrystalType; Quality: TRefineQuality): pTCrystalInfo;
function GetCrystalDisplayText(Crystal: TCrystalInfo): string;

// 辅助函数
function GetEquipmentHoleInfo(Equipment: pTUserItem): pTEquipmentHoleInfo;
procedure SetEquipmentHoleInfo(Equipment: pTUserItem; HoleInfo: TEquipmentHoleInfo);
function HasHammer(PlayObject: TPlayObject): Boolean;
function ConsumeHammer(PlayObject: TPlayObject): Boolean;

implementation

// ========== 系统初始化和清理 ==========

function InitializeCrystalSystem: Boolean;
begin
  try
    // 加载结晶配置
    if not LoadCrystals('CrystalConfig.txt') then begin
      MainOutMessage('[警告] 结晶配置加载失败，使用默认配置');
    end;
    
    g_boMeltingSystemEnabled := g_MeltingConfig.boEnabled;
    Result := True;
  except
    on E: Exception do begin
      MainOutMessage('[异常] 结晶系统初始化失败: ' + E.Message);
      Result := False;
    end;
  end;
end;

procedure FinalizeCrystalSystem;
begin
  // 清理工作已在M2Share.pas的finalization中完成
end;

// ========== 装备打孔系统 ==========

function PunchEquipmentHole(PlayObject: TPlayObject; Equipment: pTUserItem): TPunchResult;
var
  HoleInfo: pTEquipmentHoleInfo;
begin
  Result := pr_Failed;
  
  // 检查系统是否启用
  if not g_boMeltingSystemEnabled then begin
    Result := pr_SystemDisabled;
    Exit;
  end;
  
  // 检查装备是否有效
  if not CanPunchHole(Equipment) then begin
    HoleInfo := GetEquipmentHoleInfo(Equipment);
    if HoleInfo.btHoleCount >= 3 then
      Result := pr_MaxHoles
    else
      Result := pr_InvalidItem;
    Exit;
  end;
  
  // 检查是否有天工之锤
  if not HasHammer(PlayObject) then begin
    Result := pr_NoHammer;
    Exit;
  end;
  
  // 消耗天工之锤
  if not ConsumeHammer(PlayObject) then begin
    Result := pr_NoHammer;
    Exit;
  end;
  
  // 执行打孔
  HoleInfo := GetEquipmentHoleInfo(Equipment);
  if HoleInfo.btHoleCount < 3 then begin
    HoleInfo.Holes[HoleInfo.btHoleCount].boHasHole := True;
    HoleInfo.Holes[HoleInfo.btHoleCount].CrystalIndex := 0; // 空孔
    FillChar(HoleInfo.Holes[HoleInfo.btHoleCount].CrystalInfo, SizeOf(TCrystalInfo), 0);
    Inc(HoleInfo.btHoleCount);
    HoleInfo.dwPunchTime := GetTickCount;
    
    SetEquipmentHoleInfo(Equipment, HoleInfo^);
    Result := pr_Success;
    
    PlayObject.SysMsg('装备打孔成功！当前孔数：' + IntToStr(HoleInfo.btHoleCount), c_Green, t_Hint);
  end;
end;

function CanPunchHole(Equipment: pTUserItem): Boolean;
var
  HoleInfo: pTEquipmentHoleInfo;
begin
  Result := False;
  if Equipment = nil then Exit;
  
  HoleInfo := GetEquipmentHoleInfo(Equipment);
  Result := (HoleInfo.btHoleCount < 3);
end;

function GetEquipmentHoleCount(Equipment: pTUserItem): Byte;
var
  HoleInfo: pTEquipmentHoleInfo;
begin
  Result := 0;
  if Equipment = nil then Exit;
  
  HoleInfo := GetEquipmentHoleInfo(Equipment);
  Result := HoleInfo.btHoleCount;
end;

function HasEmptyHole(Equipment: pTUserItem): Boolean;
var
  HoleInfo: pTEquipmentHoleInfo;
  i: Integer;
begin
  Result := False;
  if Equipment = nil then Exit;
  
  HoleInfo := GetEquipmentHoleInfo(Equipment);
  for i := 0 to HoleInfo.btHoleCount - 1 do begin
    if HoleInfo.Holes[i].boHasHole and (HoleInfo.Holes[i].CrystalIndex = 0) then begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure GenerateRandomHoles(Equipment: pTUserItem);
var
  HoleInfo: pTEquipmentHoleInfo;
  nRandom: Integer;
  nHoleCount: Byte;
  i: Integer;
begin
  if Equipment = nil then Exit;
  if g_MeltingConfig.nRandomHoleRate <= 0 then Exit;
  
  // 检查是否触发随机带孔
  nRandom := Random(1000);
  if nRandom >= g_MeltingConfig.nRandomHoleRate then Exit;
  
  // 随机生成1-3个孔
  nHoleCount := 1 + Random(3);
  
  HoleInfo := GetEquipmentHoleInfo(Equipment);
  HoleInfo.btHoleCount := nHoleCount;
  HoleInfo.dwPunchTime := GetTickCount;
  
  for i := 0 to nHoleCount - 1 do begin
    HoleInfo.Holes[i].boHasHole := True;
    HoleInfo.Holes[i].CrystalIndex := 0; // 空孔
    FillChar(HoleInfo.Holes[i].CrystalInfo, SizeOf(TCrystalInfo), 0);
  end;
  
  SetEquipmentHoleInfo(Equipment, HoleInfo^);
end;

// ========== 装备融化系统 ==========

function MeltEquipment(PlayObject: TPlayObject; Equipment: pTUserItem): TMeltingResult;
var
  RefineInfo: pTRefineInfo;
  QualityConfig: TMeltingQualityConfig;
  nRandom: Integer;
  nSuccessRate: Integer;
begin
  
  // 检查系统是否启用
  if not g_boMeltingSystemEnabled then begin
    Result := mr_SystemDisabled;
    Exit;
  end;
  
  // 检查装备是否可以融化
  if not CanMeltEquipment(Equipment) then begin
    RefineInfo := GetRefineInfo(Equipment);
    if Integer(Ord(RefineInfo.RefineQuality)) < Integer(g_MeltingConfig.nMinQualityLevel) then
      Result := mr_QualityTooLow
    else
      Result := mr_InvalidItem;
    Exit;
  end;
  
  RefineInfo := GetRefineInfo(Equipment);
  QualityConfig := g_MeltingQualityConfigs[RefineInfo.RefineQuality];
  nSuccessRate := QualityConfig.nSuccessRate;
  
  // 随机判定融化结果
  nRandom := Random(1000);
  if nRandom < nSuccessRate then begin
    // 融化成功，生成结晶
    GenerateCrystalFromEquipment(PlayObject, Equipment, QualityConfig.nCrystalCount);
    Result := mr_Success;
    
    PlayObject.SysMsg('装备融化成功！获得 ' + IntToStr(QualityConfig.nCrystalCount) + ' 个结晶', c_Green, t_Hint);
  end else begin
    // 融化失败，返还材料
    if g_MeltingConfig.boReturnMaterials then begin
      ReturnMaterialFromMelting(PlayObject, QualityConfig.nReturnMaterialGrade);
      PlayObject.SysMsg('装备融化失败！返还 ' + IntToStr(QualityConfig.nReturnMaterialGrade) + ' 阶材料', c_Blue, t_Hint);
    end else begin
      PlayObject.SysMsg('装备融化失败！', c_Red, t_Hint);
    end;
    Result := mr_Failed;
  end;
end;

function CanMeltEquipment(Equipment: pTUserItem): Boolean;
var
  RefineInfo: pTRefineInfo;
begin
  Result := False;
  if Equipment = nil then Exit;
  
  RefineInfo := GetRefineInfo(Equipment);
  Result := (Integer(Ord(RefineInfo.RefineQuality)) >= Integer(g_MeltingConfig.nMinQualityLevel));
end;

function GetMeltingSuccessRate(Equipment: pTUserItem): Integer;
var
  RefineInfo: pTRefineInfo;
begin
  Result := 0;
  if Equipment = nil then Exit;
  
  RefineInfo := GetRefineInfo(Equipment);
  if CanMeltEquipment(Equipment) then
    Result := g_MeltingQualityConfigs[RefineInfo.RefineQuality].nSuccessRate;
end;

procedure GenerateCrystalFromEquipment(PlayObject: TPlayObject; Equipment: pTUserItem; CrystalCount: Integer);
var
  RefineInfo: pTRefineInfo;
  Crystal: pTCrystalInfo;
  i: Integer;
  CrystalType: TCrystalType;
begin
  if PlayObject = nil then Exit;
  
  RefineInfo := GetRefineInfo(Equipment);
  
  for i := 1 to CrystalCount do begin
    // 随机生成结晶类型
    case Random(3) of
      0: CrystalType := ct_AttributePercent;
      1: CrystalType := ct_SpecialEffect;
      2: CrystalType := ct_SkillEnhance;
      else CrystalType := ct_AttributePercent;
    end;
    
    Crystal := CreateCrystal(CrystalType, RefineInfo.RefineQuality);
    if Crystal <> nil then begin
      // TODO: 将结晶添加到玩家背包
      // PlayObject.AddItemToBag(Crystal);
      MainOutMessage('[调试] 生成结晶: ' + Crystal.sName);
    end;
  end;
end;

procedure ReturnMaterialFromMelting(PlayObject: TPlayObject; MaterialGrade: Byte);
var
  Material: pTRefineMaterial;
  i: Integer;
begin
  if PlayObject = nil then Exit;
  
  // 查找对应品阶的材料
  for i := 0 to g_RefineMaterialList.Count - 1 do begin
    Material := pTRefineMaterial(g_RefineMaterialList[i]);
    if Material.btGrade = MaterialGrade then begin
      // TODO: 将材料添加到玩家背包
      // PlayObject.AddItemToBag(Material);
      MainOutMessage('[调试] 返还材料: ' + Material.sName);
      Break;
    end;
  end;
end;

// ========== 结晶镶嵌系统 ==========

function EmbedCrystal(PlayObject: TPlayObject; Equipment: pTUserItem; Crystal: pTUserItem; HoleIndex: Byte): Boolean;
var
  HoleInfo: pTEquipmentHoleInfo;
  CrystalInfo: pTCrystalInfo;
begin
  Result := False;
  if (PlayObject = nil) or (Equipment = nil) or (Crystal = nil) then Exit;
  
  HoleInfo := GetEquipmentHoleInfo(Equipment);
  
  // 检查孔洞索引是否有效
  if HoleIndex >= HoleInfo.btHoleCount then Exit;
  
  // 检查孔洞是否存在且为空
  if not HoleInfo.Holes[HoleIndex].boHasHole then Exit;
  if HoleInfo.Holes[HoleIndex].CrystalIndex <> 0 then Exit;
  
  // 获取结晶信息
  CrystalInfo := GetCrystalInfo(Crystal);
  if CrystalInfo = nil then Exit;
  
  // 镶嵌结晶
  HoleInfo.Holes[HoleIndex].CrystalIndex := Crystal.wIndex;
  HoleInfo.Holes[HoleIndex].CrystalInfo := CrystalInfo^;
  
  SetEquipmentHoleInfo(Equipment, HoleInfo^);
  
  // 应用结晶效果
  ApplyCrystalEffects(PlayObject, Equipment);
  
  // TODO: 从背包中移除结晶
  // PlayObject.RemoveItemFromBag(Crystal);
  
  Result := True;
  PlayObject.SysMsg('结晶镶嵌成功！', c_Green, t_Hint);
end;

function RemoveCrystal(PlayObject: TPlayObject; Equipment: pTUserItem; HoleIndex: Byte): Boolean;
var
  HoleInfo: pTEquipmentHoleInfo;
begin
  Result := False;
  if (PlayObject = nil) or (Equipment = nil) then Exit;
  
  HoleInfo := GetEquipmentHoleInfo(Equipment);
  
  // 检查孔洞索引是否有效
  if HoleIndex >= HoleInfo.btHoleCount then Exit;
  
  // 检查孔洞是否存在且有结晶
  if not HoleInfo.Holes[HoleIndex].boHasHole then Exit;
  if HoleInfo.Holes[HoleIndex].CrystalIndex = 0 then Exit;
  
  // TODO: 将结晶返还到背包
  // PlayObject.AddItemToBag(HoleInfo.Holes[HoleIndex].CrystalInfo);
  
  // 移除结晶
  HoleInfo.Holes[HoleIndex].CrystalIndex := 0;
  FillChar(HoleInfo.Holes[HoleIndex].CrystalInfo, SizeOf(TCrystalInfo), 0);
  
  SetEquipmentHoleInfo(Equipment, HoleInfo^);
  
  Result := True;
  PlayObject.SysMsg('结晶移除成功！', c_Blue, t_Hint);
end;

function GetCrystalInfo(Crystal: pTUserItem): pTCrystalInfo;
var
  i: Integer;
  CrystalInfo: pTCrystalInfo;
begin
  Result := nil;
  if Crystal = nil then Exit;
  
  // 从结晶列表中查找对应的结晶信息
  for i := 0 to g_CrystalList.Count - 1 do begin
    CrystalInfo := pTCrystalInfo(g_CrystalList[i]);
    if CrystalInfo.wIndex = Crystal.wIndex then begin
      Result := CrystalInfo;
      Exit;
    end;
  end;
end;

procedure ApplyCrystalEffects(PlayObject: TPlayObject; Equipment: pTUserItem);
var
  HoleInfo: pTEquipmentHoleInfo;
  i: Integer;
  Crystal: TCrystalInfo;
  nValue: Integer;
begin
  if PlayObject = nil then Exit;
  
  HoleInfo := GetEquipmentHoleInfo(Equipment);
  
  for i := 0 to HoleInfo.btHoleCount - 1 do begin
    if HoleInfo.Holes[i].boHasHole and (HoleInfo.Holes[i].CrystalIndex <> 0) then begin
      Crystal := HoleInfo.Holes[i].CrystalInfo;
      
      case Crystal.CrystalType of
        ct_AttributePercent: begin
          // 应用百分比属性加成
          nValue := (Crystal.nValue * 10); // 转换为千分比
          case Crystal.AttributeType of
            cat_HP_Percent: Inc(PlayObject.m_WAbil.HP, (PlayObject.m_WAbil.HP * nValue) div 1000);
            cat_MP_Percent: Inc(PlayObject.m_WAbil.MP, (PlayObject.m_WAbil.MP * nValue) div 1000);
            cat_DC_Percent: Inc(PlayObject.m_WAbil.DC, (PlayObject.m_WAbil.DC * nValue) div 1000);
            cat_MC_Percent: Inc(PlayObject.m_WAbil.MC, (PlayObject.m_WAbil.MC * nValue) div 1000);
            cat_SC_Percent: Inc(PlayObject.m_WAbil.SC, (PlayObject.m_WAbil.SC * nValue) div 1000);
            cat_AC_Percent: Inc(PlayObject.m_WAbil.AC, (PlayObject.m_WAbil.AC * nValue) div 1000);
            cat_MAC_Percent: Inc(PlayObject.m_WAbil.MAC, (PlayObject.m_WAbil.MAC * nValue) div 1000);
          end;
        end;
        ct_SpecialEffect: begin
          // TODO: 实现特殊效果
          // 根据nSpecialEffectID应用不同的特殊效果
        end;
        ct_SkillEnhance: begin
          // TODO: 实现技能增强
          // 根据nSkillID和nSkillLevel增强技能
        end;
      end;
    end;
  end;
end;

// ========== 结晶管理 ==========

function LoadCrystals(const sFileName: string): Boolean;
var
  LoadList: TStringList;
  i: Integer;
  sLineText, sTemp: string;
  Crystal: pTCrystalInfo;
  nIndex, nType, nAttrType, nValue: Integer;
begin
  
  // 清空现有结晶列表
  for i := 0 to g_CrystalList.Count - 1 do begin
    Dispose(pTCrystalInfo(g_CrystalList[i]));
  end;
  g_CrystalList.Clear;
  
  if not FileExists(g_Config.sGameDataDir + sFileName) then begin
    // 创建默认结晶配置文件
    LoadList := TStringList.Create;
    try
      LoadList.Add('; 结晶配置文件');
      LoadList.Add('; 格式: Index Name Type AttrType Value Quality');
      LoadList.Add('; Type: 1=属性百分比 2=特殊效果 3=技能增强');
      LoadList.Add('; AttrType: 0=HP 1=MP 2=攻击 3=魔法 4=道术 5=防御 6=魔防');
      LoadList.Add('');
      LoadList.Add('7001 HP结晶 1 0 5 7');
      LoadList.Add('7002 MP结晶 1 1 5 7');
      LoadList.Add('7003 攻击结晶 1 2 3 7');
      LoadList.SaveToFile(g_Config.sGameDataDir + sFileName);
      MainOutMessage('[提示] 创建默认结晶配置文件');
    finally
      LoadList.Free;
    end;
  end;
  
  LoadList := TStringList.Create;
  try
    LoadList.LoadFromFile(g_Config.sGameDataDir + sFileName);
    
    for i := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList[i]);
      if (sLineText = '') or (sLineText[1] = ';') then Continue;
      
      sLineText := GetValidStr3(sLineText, sTemp, [' ', #9]);
      nIndex := Str_ToInt(sTemp, 0);
      if nIndex <= 0 then Continue;
      
      New(Crystal);
      Crystal.wIndex := nIndex;
      
      sLineText := GetValidStr3(sLineText, sTemp, [' ', #9]);
      Crystal.sName := sTemp;
      
      sLineText := GetValidStr3(sLineText, sTemp, [' ', #9]);
      nType := Str_ToInt(sTemp, 1);
      Crystal.CrystalType := TCrystalType(nType);
      
      sLineText := GetValidStr3(sLineText, sTemp, [' ', #9]);
      nAttrType := Str_ToInt(sTemp, 0);
      Crystal.AttributeType := TCrystalAttributeType(nAttrType);
      
      sLineText := GetValidStr3(sLineText, sTemp, [' ', #9]);
      nValue := Str_ToInt(sTemp, 1);
      Crystal.nValue := nValue;
      
      sLineText := GetValidStr3(sLineText, sTemp, [' ', #9]);
      Crystal.Quality := TRefineQuality(Str_ToInt(sTemp, 7));
      
      Crystal.boEnabled := True;
      
      g_CrystalList.Add(Crystal);
    end;
    
    MainOutMessage('[提示] 加载结晶配置成功，共' + IntToStr(g_CrystalList.Count) + '个结晶');
    Result := True;
  finally
    LoadList.Free;
  end;
end;

function CreateCrystal(CrystalType: TCrystalType; Quality: TRefineQuality): pTCrystalInfo;
var
  i: Integer;
  Crystal: pTCrystalInfo;
begin
  
  // 从配置中查找匹配的结晶模板
  for i := 0 to g_CrystalList.Count - 1 do begin
    Crystal := pTCrystalInfo(g_CrystalList[i]);
    if (Crystal.CrystalType = CrystalType) and (Crystal.Quality = Quality) then begin
      New(Result);
      Result^ := Crystal^;
      // 可以在这里添加随机数值变化
      Exit;
    end;
  end;
  
  // 如果没有找到模板，创建默认结晶
  New(Result);
  with Result^ do begin
    wIndex := 7000 + Random(100);
    sName := '未知结晶';
    CrystalType := CrystalType;
    AttributeType := cat_HP_Percent;
    nValue := 1 + Random(5);
    Quality := Quality;
    boEnabled := True;
  end;
end;

function GetCrystalDisplayText(Crystal: TCrystalInfo): string;
begin
  Result := Crystal.sName;
  
  case Crystal.CrystalType of
    ct_AttributePercent: begin
      case Crystal.AttributeType of
        cat_HP_Percent: Result := Result + ': HP+' + IntToStr(Crystal.nValue) + '%';
        cat_MP_Percent: Result := Result + ': MP+' + IntToStr(Crystal.nValue) + '%';
        cat_DC_Percent: Result := Result + ': 攻击+' + IntToStr(Crystal.nValue) + '%';
        cat_MC_Percent: Result := Result + ': 魔法+' + IntToStr(Crystal.nValue) + '%';
        cat_SC_Percent: Result := Result + ': 道术+' + IntToStr(Crystal.nValue) + '%';
        cat_AC_Percent: Result := Result + ': 防御+' + IntToStr(Crystal.nValue) + '%';
        cat_MAC_Percent: Result := Result + ': 魔防+' + IntToStr(Crystal.nValue) + '%';
      end;
    end;
    ct_SpecialEffect: Result := Result + ': 特殊效果[' + IntToStr(Crystal.nSpecialEffectID) + ']';
    ct_SkillEnhance: Result := Result + ': 技能增强[' + IntToStr(Crystal.nSkillID) + '+' + IntToStr(Crystal.nSkillLevel) + ']';
  end;
end;

// ========== 辅助函数 ==========

function GetEquipmentHoleInfo(Equipment: pTUserItem): pTEquipmentHoleInfo;
var
  RefineInfo: pTRefineInfo;
begin
  RefineInfo := GetRefineInfo(Equipment);
  Result := @RefineInfo.HoleInfo;
end;

procedure SetEquipmentHoleInfo(Equipment: pTUserItem; HoleInfo: TEquipmentHoleInfo);
var
  RefineInfo: pTRefineInfo;
begin
  RefineInfo := GetRefineInfo(Equipment);
  RefineInfo.HoleInfo := HoleInfo;
  SetRefineInfo(Equipment, RefineInfo^);
end;

function HasHammer(PlayObject: TPlayObject): Boolean;
begin
  Result := False;
  if PlayObject = nil then Exit;
  
  // TODO: 检查玩家背包中是否有天工之锤
  // Result := PlayObject.HasItemInBag(g_MeltingConfig.nHammerItemIndex);
  Result := True; // 临时返回True用于测试
end;

function ConsumeHammer(PlayObject: TPlayObject): Boolean;
begin
  Result := False;
  if PlayObject = nil then Exit;
  
  // TODO: 从玩家背包中消耗天工之锤
  // Result := PlayObject.ConsumeItemFromBag(g_MeltingConfig.nHammerItemIndex, 1);
  Result := True; // 临时返回True用于测试
end;

end.
