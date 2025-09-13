unit SoulForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grobal2, M2Share, SoulSystem, RefineSystem, ObjPlay;

type
  TfrmSoul = class(TForm)
    pnlMain: TPanel;
    lblTitle: TLabel;
    
    // 元魄合成区域
    gbSoulSynthesis: TGroupBox;
    lblSoulJob: TLabel;
    cbSoulJob: TComboBox;
    lblEquipments: TLabel;
    lbEquipments: TListBox;
    btnAddEquipment: TButton;
    btnRemoveEquipment: TButton;
    btnClearEquipments: TButton;
    
    // 元魄升级区域
    gbSoulUpgrade: TGroupBox;
    lblSelectedSoul: TLabel;
    edtSelectedSoul: TEdit;
    btnSelectSoul: TButton;
    lblUpgradeEquipment: TLabel;
    edtUpgradeEquipment: TEdit;
    btnSelectUpgradeEquipment: TButton;
    
    // 精魂升级区域
    gbEssenceUpgrade: TGroupBox;
    lblSelectedEssence: TLabel;
    edtSelectedEssence: TEdit;
    btnSelectEssence: TButton;
    lblMaterials: TLabel;
    lbMaterials: TListBox;
    btnAddMaterial: TButton;
    btnRemoveMaterial: TButton;
    btnClearMaterials: TButton;
    
    // 成功率显示
    gbSuccessRate: TGroupBox;
    lblSuccessRate: TLabel;
    pbSuccessRate: TProgressBar;
    
    // 操作按钮
    btnSynthesizeSoul: TButton;
    btnUpgradeSoul: TButton;
    btnUpgradeEssence: TButton;
    btnClose: TButton;
    
    // 属性显示区域
    gbAttributes: TGroupBox;
    lblSoulInfo: TLabel;
    memoSoulInfo: TMemo;
    
    // 操作日志
    gbLog: TGroupBox;
    memoLog: TMemo;
    
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbSoulJobChange(Sender: TObject);
    procedure btnAddEquipmentClick(Sender: TObject);
    procedure btnRemoveEquipmentClick(Sender: TObject);
    procedure btnClearEquipmentsClick(Sender: TObject);
    procedure btnSelectSoulClick(Sender: TObject);
    procedure btnSelectUpgradeEquipmentClick(Sender: TObject);
    procedure btnSelectEssenceClick(Sender: TObject);
    procedure btnAddMaterialClick(Sender: TObject);
    procedure btnRemoveMaterialClick(Sender: TObject);
    procedure btnClearMaterialsClick(Sender: TObject);
    procedure btnSynthesizeSoulClick(Sender: TObject);
    procedure btnUpgradeSoulClick(Sender: TObject);
    procedure btnUpgradeEssenceClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure lbEquipmentsClick(Sender: TObject);
    procedure lbMaterialsClick(Sender: TObject);
    
  private
    FPlayObject: TPlayObject;
    FSelectedEquipments: array[0..3] of pTUserItem;
    FSelectedSoul: pTUserItem;
    FSelectedUpgradeEquipment: pTUserItem;
    FSelectedEssence: pTUserItem;
    FSelectedMaterials: array[0..2] of pTRefineMaterial;
    
    procedure UpdateUI;
    procedure UpdateSuccessRate;
    procedure UpdateSoulInfo;
    procedure AddLog(const sMessage: string);
    procedure ClearSelections;
    function GetSelectedJobType: TSoulJobType;
    function GetEquipmentCount: Integer;
    function GetMaterialCount: Integer;
    
  public
    procedure ShowSoulForm(PlayObject: TPlayObject);
  end;

var
  frmSoul: TfrmSoul;

implementation

{$R *.dfm}

// ========== 窗体事件 ==========

procedure TfrmSoul.FormCreate(Sender: TObject);
begin
  FPlayObject := nil;
  ClearSelections;
  
  // 初始化职业选择
  cbSoulJob.Items.Clear;
  cbSoulJob.Items.Add('战士');
  cbSoulJob.Items.Add('法师');
  cbSoulJob.Items.Add('道士');
  cbSoulJob.ItemIndex := 0;
end;

procedure TfrmSoul.FormShow(Sender: TObject);
begin
  UpdateUI;
end;

// ========== 控件事件 ==========

procedure TfrmSoul.cbSoulJobChange(Sender: TObject);
begin
  UpdateSuccessRate;
end;

procedure TfrmSoul.btnAddEquipmentClick(Sender: TObject);
var
  nCount: Integer;
begin
  if FPlayObject = nil then Exit;
  
  nCount := GetEquipmentCount;
  if nCount >= g_SoulSynthesisConfig.nMaxEquipmentCount then begin
    AddLog('装备数量已达上限（' + IntToStr(g_SoulSynthesisConfig.nMaxEquipmentCount) + '件）！');
    Exit;
  end;
  
  // TODO: 打开装备选择对话框
  // 临时模拟添加装备
  AddLog('请选择要添加的凝练装备...');
  // FSelectedEquipments[nCount] := SelectedEquipment;
  // lbEquipments.Items.Add('屠龙刀+8 (传说品质)');
  // UpdateUI;
end;

procedure TfrmSoul.btnRemoveEquipmentClick(Sender: TObject);
var
  nIndex: Integer;
  i: Integer;
begin
  nIndex := lbEquipments.ItemIndex;
  if nIndex < 0 then begin
    AddLog('请先选择要移除的装备！');
    Exit;
  end;
  
  // 移除选中的装备
  FSelectedEquipments[nIndex] := nil;
  
  // 重新整理数组
  for i := nIndex to High(FSelectedEquipments) - 1 do begin
    FSelectedEquipments[i] := FSelectedEquipments[i + 1];
  end;
  FSelectedEquipments[High(FSelectedEquipments)] := nil;
  
  // 更新列表
  lbEquipments.Items.Delete(nIndex);
  UpdateUI;
  AddLog('装备移除成功');
end;

procedure TfrmSoul.btnClearEquipmentsClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to High(FSelectedEquipments) do
    FSelectedEquipments[i] := nil;
  
  lbEquipments.Items.Clear;
  UpdateUI;
  AddLog('已清空所有装备');
end;

procedure TfrmSoul.btnSelectSoulClick(Sender: TObject);
begin
  if FPlayObject = nil then Exit;
  
  // TODO: 打开元魄选择对话框
  AddLog('请选择要升级的元魄...');
  // FSelectedSoul := SelectedSoul;
  // edtSelectedSoul.Text := GetSoulDisplayName(SoulInfo);
  // UpdateUI;
end;

procedure TfrmSoul.btnSelectUpgradeEquipmentClick(Sender: TObject);
begin
  if FPlayObject = nil then Exit;
  
  // TODO: 打开装备选择对话框（绝世及以上品质）
  AddLog('请选择用于升级的装备（绝世及以上品质）...');
  // FSelectedUpgradeEquipment := SelectedEquipment;
  // edtUpgradeEquipment.Text := EquipmentName;
  // UpdateUI;
end;

procedure TfrmSoul.btnSelectEssenceClick(Sender: TObject);
begin
  if FPlayObject = nil then Exit;
  
  // TODO: 打开精魂选择对话框
  AddLog('请选择要升级的精魂...');
  // FSelectedEssence := SelectedEssence;
  // edtSelectedEssence.Text := GetSoulDisplayName(SoulInfo);
  // UpdateUI;
end;

procedure TfrmSoul.btnAddMaterialClick(Sender: TObject);
var
  nCount: Integer;
begin
  if FPlayObject = nil then Exit;
  
  nCount := GetMaterialCount;
  if nCount >= g_EssenceUpgradeConfig.nMaxMaterialCount then begin
    AddLog('材料数量已达上限（' + IntToStr(g_EssenceUpgradeConfig.nMaxMaterialCount) + '个）！');
    Exit;
  end;
  
  // TODO: 打开材料选择对话框（5阶及以上）
  AddLog('请选择要添加的凝练材料（5阶及以上）...');
  // FSelectedMaterials[nCount] := SelectedMaterial;
  // lbMaterials.Items.Add(MaterialName + ' (' + IntToStr(Grade) + '阶)');
  // UpdateUI;
end;

procedure TfrmSoul.btnRemoveMaterialClick(Sender: TObject);
var
  nIndex: Integer;
  i: Integer;
begin
  nIndex := lbMaterials.ItemIndex;
  if nIndex < 0 then begin
    AddLog('请先选择要移除的材料！');
    Exit;
  end;
  
  // 移除选中的材料
  FSelectedMaterials[nIndex] := nil;
  
  // 重新整理数组
  for i := nIndex to High(FSelectedMaterials) - 1 do begin
    FSelectedMaterials[i] := FSelectedMaterials[i + 1];
  end;
  FSelectedMaterials[High(FSelectedMaterials)] := nil;
  
  // 更新列表
  lbMaterials.Items.Delete(nIndex);
  UpdateUI;
  AddLog('材料移除成功');
end;

procedure TfrmSoul.btnClearMaterialsClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to High(FSelectedMaterials) do
    FSelectedMaterials[i] := nil;
  
  lbMaterials.Items.Clear;
  UpdateUI;
  AddLog('已清空所有材料');
end;

procedure TfrmSoul.btnSynthesizeSoulClick(Sender: TObject);
var
  Result: TSoulSynthesisResult;
  JobType: TSoulJobType;
  nSuccessRate: Integer;
begin
  if FPlayObject = nil then Exit;
  
  if GetEquipmentCount = 0 then begin
    AddLog('请先添加凝练装备！');
    Exit;
  end;
  
  JobType := GetSelectedJobType;
  nSuccessRate := CalculateSynthesisSuccessRate(FSelectedEquipments);
  
  // 确认对话框
  if MessageDlg('确定要合成元魄吗？成功率：' + IntToStr(nSuccessRate div 10) + '.' + IntToStr(nSuccessRate mod 10) + '%' + #13#10 +
                '职业：' + cbSoulJob.Text + #13#10 +
                '将消耗所有选中的装备！', 
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit;
  
  // 执行合成
  Result := SynthesizeSoul(FPlayObject, FSelectedEquipments, JobType);
  
  case Result of
    ssr_Success: begin
      AddLog('元魄合成成功！');
      btnClearEquipmentsClick(nil); // 清空装备列表
    end;
    ssr_Failed: AddLog('元魄合成失败！');
    ssr_QualityTooLow: AddLog('装备品质不足，需要精致品质及以上！');
    ssr_TooManyItems: AddLog('装备数量过多！');
    ssr_NoItems: AddLog('没有选择装备！');
    ssr_InvalidItem: AddLog('无效的装备！');
    ssr_SystemDisabled: AddLog('元魄合成系统未启用！');
    else AddLog('元魄合成失败！');
  end;
  
  UpdateUI;
end;

procedure TfrmSoul.btnUpgradeSoulClick(Sender: TObject);
var
  Result: TSoulUpgradeResult;
  nSuccessRate: Integer;
begin
  if FPlayObject = nil then Exit;
  
  if FSelectedSoul = nil then begin
    AddLog('请先选择要升级的元魄！');
    Exit;
  end;
  
  if FSelectedUpgradeEquipment = nil then begin
    AddLog('请先选择用于升级的装备！');
    Exit;
  end;
  
  nSuccessRate := CalculateUpgradeSuccessRate(FSelectedUpgradeEquipment);
  
  // 确认对话框
  if MessageDlg('确定要升级元魄为精魂吗？成功率：' + IntToStr(nSuccessRate div 10) + '.' + IntToStr(nSuccessRate mod 10) + '%' + #13#10 +
                '失败时元魄不消失，仅消耗装备！', 
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit;
  
  // 执行升级
  Result := UpgradeSoulToEssence(FPlayObject, FSelectedSoul, FSelectedUpgradeEquipment);
  
  case Result of
    sur_Success: begin
      AddLog('元魄升级成功！转化为精魂');
      FSelectedUpgradeEquipment := nil;
      edtUpgradeEquipment.Text := '';
    end;
    sur_Failed: AddLog('元魄升级失败！');
    sur_QualityTooLow: AddLog('装备品质不足，需要绝世品质及以上！');
    sur_InvalidSoul: AddLog('无效的元魄！');
    sur_SystemDisabled: AddLog('元魄升级系统未启用！');
    else AddLog('元魄升级失败！');
  end;
  
  UpdateUI;
end;

procedure TfrmSoul.btnUpgradeEssenceClick(Sender: TObject);
var
  Result: TSoulUpgradeResult;
  nSuccessRate: Integer;
  SoulInfo: pTSoulInfo;
  bSafeUpgrade: Boolean;
begin
  if FPlayObject = nil then Exit;
  
  if FSelectedEssence = nil then begin
    AddLog('请先选择要升级的精魂！');
    Exit;
  end;
  
  if GetMaterialCount = 0 then begin
    AddLog('请先添加凝练材料！');
    Exit;
  end;
  
  SoulInfo := GetSoulInfo(FSelectedEssence);
  bSafeUpgrade := (SoulInfo.btLevel < g_EssenceUpgradeConfig.nSafeLevelThreshold);
  nSuccessRate := CalculateMaterialUpgradeRate(FSelectedMaterials);
  
  // 确认对话框
  if MessageDlg('确定要升级精魂吗？成功率：' + IntToStr(nSuccessRate div 10) + '.' + IntToStr(nSuccessRate mod 10) + '%' + #13#10 +
                '当前等级：+' + IntToStr(SoulInfo.btLevel) + #13#10 +
                (if bSafeUpgrade then '安全升级，失败不掉级' else '危险升级，失败等级清零') + #13#10 +
                '将消耗所有选中的材料！', 
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit;
  
  // 执行升级
  Result := UpgradeEssenceWithMaterials(FPlayObject, FSelectedEssence, FSelectedMaterials);
  
  case Result of
    sur_Success: begin
      AddLog('精魂升级成功！当前等级：+' + IntToStr(GetSoulInfo(FSelectedEssence).btLevel));
      btnClearMaterialsClick(nil); // 清空材料列表
    end;
    sur_Failed: AddLog('精魂升级失败！');
    sur_LevelReset: begin
      AddLog('精魂升级失败！等级已清零');
      btnClearMaterialsClick(nil); // 清空材料列表
    end;
    sur_MaxLevel: AddLog('精魂已达最高等级！');
    sur_InvalidSoul: AddLog('无效的精魂！');
    sur_NoMaterials: AddLog('没有选择材料！');
    sur_SystemDisabled: AddLog('精魂升级系统未启用！');
    else AddLog('精魂升级失败！');
  end;
  
  UpdateUI;
end;

procedure TfrmSoul.btnCloseClick(Sender: TObject);
begin
  Hide;
end;

procedure TfrmSoul.lbEquipmentsClick(Sender: TObject);
begin
  UpdateSoulInfo;
end;

procedure TfrmSoul.lbMaterialsClick(Sender: TObject);
begin
  UpdateSoulInfo;
end;

// ========== 私有方法 ==========

procedure TfrmSoul.UpdateUI;
begin
  // 更新按钮状态
  btnSynthesizeSoul.Enabled := (FPlayObject <> nil) and 
                               (GetEquipmentCount > 0) and
                               g_boSoulSystemEnabled;
                               
  btnUpgradeSoul.Enabled := (FPlayObject <> nil) and 
                            (FSelectedSoul <> nil) and 
                            (FSelectedUpgradeEquipment <> nil) and
                            g_boSoulSystemEnabled;
                            
  btnUpgradeEssence.Enabled := (FPlayObject <> nil) and 
                               (FSelectedEssence <> nil) and 
                               (GetMaterialCount > 0) and
                               g_boSoulSystemEnabled;
  
  // 更新成功率显示
  UpdateSuccessRate;
  
  // 更新属性显示
  UpdateSoulInfo;
end;

procedure TfrmSoul.UpdateSuccessRate;
var
  nRate: Integer;
begin
  nRate := 0;
  
  // 根据当前选中的标签页计算成功率
  if (gbSoulSynthesis.Visible) and (GetEquipmentCount > 0) then begin
    nRate := CalculateSynthesisSuccessRate(FSelectedEquipments);
  end else if (gbSoulUpgrade.Visible) and (FSelectedUpgradeEquipment <> nil) then begin
    nRate := CalculateUpgradeSuccessRate(FSelectedUpgradeEquipment);
  end else if (gbEssenceUpgrade.Visible) and (GetMaterialCount > 0) then begin
    nRate := CalculateMaterialUpgradeRate(FSelectedMaterials);
  end;
  
  // 更新显示
  lblSuccessRate.Caption := '成功率: ' + IntToStr(nRate div 10) + '.' + IntToStr(nRate mod 10) + '%';
  pbSuccessRate.Position := nRate div 10;
  
  if nRate >= 1000 then
    pbSuccessRate.Color := clLime
  else if nRate >= 500 then
    pbSuccessRate.Color := clYellow
  else
    pbSuccessRate.Color := clRed;
end;

procedure TfrmSoul.UpdateSoulInfo;
var
  sInfo: string;
  i: Integer;
  SoulInfo: pTSoulInfo;
  RefineInfo: pTRefineInfo;
begin
  memoSoulInfo.Lines.Clear;
  
  // 显示选中元魄/精魂的信息
  if FSelectedSoul <> nil then begin
    SoulInfo := GetSoulInfo(FSelectedSoul);
    if SoulInfo <> nil then begin
      memoSoulInfo.Lines.Add('=== 选中元魄 ===');
      memoSoulInfo.Lines.Add('名称: ' + GetSoulDisplayName(SoulInfo^));
      memoSoulInfo.Lines.Add('伤害加深: +' + IntToStr(SoulInfo.nDamageDeepen div 10) + '.' + IntToStr(SoulInfo.nDamageDeepen mod 10) + '%');
      memoSoulInfo.Lines.Add('伤害吸收: +' + IntToStr(SoulInfo.nDamageAbsorb div 10) + '.' + IntToStr(SoulInfo.nDamageAbsorb mod 10) + '%');
      
      if SoulInfo.btEffectCount > 0 then begin
        memoSoulInfo.Lines.Add('');
        memoSoulInfo.Lines.Add('--- 特殊效果 ---');
        for i := 0 to SoulInfo.btEffectCount - 1 do begin
          memoSoulInfo.Lines.Add(GetEffectDescription(SoulInfo.Effects[i]));
        end;
      end;
    end;
  end;
  
  if FSelectedEssence <> nil then begin
    SoulInfo := GetSoulInfo(FSelectedEssence);
    if SoulInfo <> nil then begin
      memoSoulInfo.Lines.Add('=== 选中精魂 ===');
      memoSoulInfo.Lines.Add('名称: ' + GetSoulDisplayName(SoulInfo^));
      memoSoulInfo.Lines.Add('等级: +' + IntToStr(SoulInfo.btLevel));
      memoSoulInfo.Lines.Add('伤害加深: +' + IntToStr(SoulInfo.nDamageDeepen div 10) + '.' + IntToStr(SoulInfo.nDamageDeepen mod 10) + '%');
      memoSoulInfo.Lines.Add('伤害吸收: +' + IntToStr(SoulInfo.nDamageAbsorb div 10) + '.' + IntToStr(SoulInfo.nDamageAbsorb mod 10) + '%');
      
      if SoulInfo.btEffectCount > 0 then begin
        memoSoulInfo.Lines.Add('');
        memoSoulInfo.Lines.Add('--- 特殊效果 ---');
        for i := 0 to SoulInfo.btEffectCount - 1 do begin
          memoSoulInfo.Lines.Add(GetEffectDescription(SoulInfo.Effects[i]));
        end;
      end;
    end;
  end;
  
  // 显示选中装备的信息
  if GetEquipmentCount > 0 then begin
    memoSoulInfo.Lines.Add('');
    memoSoulInfo.Lines.Add('=== 选中装备 ===');
    for i := 0 to High(FSelectedEquipments) do begin
      if FSelectedEquipments[i] <> nil then begin
        RefineInfo := GetRefineInfo(FSelectedEquipments[i]);
        sInfo := '装备' + IntToStr(i + 1) + ': ' + 
                 GetRefineQualityName(RefineInfo.RefineQuality) + '品质';
        memoSoulInfo.Lines.Add(sInfo);
      end;
    end;
  end;
  
  // 显示选中材料的信息
  if GetMaterialCount > 0 then begin
    memoSoulInfo.Lines.Add('');
    memoSoulInfo.Lines.Add('=== 选中材料 ===');
    for i := 0 to High(FSelectedMaterials) do begin
      if FSelectedMaterials[i] <> nil then begin
        sInfo := '材料' + IntToStr(i + 1) + ': ' + 
                 FSelectedMaterials[i].sName + ' (' + IntToStr(FSelectedMaterials[i].btGrade) + '阶)';
        memoSoulInfo.Lines.Add(sInfo);
      end;
    end;
  end;
end;

procedure TfrmSoul.AddLog(const sMessage: string);
begin
  memoLog.Lines.Add('[' + TimeToStr(Now) + '] ' + sMessage);
  
  // 自动滚动到最后一行
  memoLog.SelStart := Length(memoLog.Text);
  memoLog.SelLength := 0;
  SendMessage(memoLog.Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TfrmSoul.ClearSelections;
var
  i: Integer;
begin
  for i := 0 to High(FSelectedEquipments) do
    FSelectedEquipments[i] := nil;
    
  for i := 0 to High(FSelectedMaterials) do
    FSelectedMaterials[i] := nil;
    
  FSelectedSoul := nil;
  FSelectedUpgradeEquipment := nil;
  FSelectedEssence := nil;
  
  lbEquipments.Items.Clear;
  lbMaterials.Items.Clear;
  edtSelectedSoul.Text := '';
  edtUpgradeEquipment.Text := '';
  edtSelectedEssence.Text := '';
end;

function TfrmSoul.GetSelectedJobType: TSoulJobType;
begin
  case cbSoulJob.ItemIndex of
    0: Result := sjt_Warrior;
    1: Result := sjt_Wizard;
    2: Result := sjt_Taoist;
    else Result := sjt_Warrior;
  end;
end;

function TfrmSoul.GetEquipmentCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to High(FSelectedEquipments) do begin
    if FSelectedEquipments[i] <> nil then
      Inc(Result);
  end;
end;

function TfrmSoul.GetMaterialCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to High(FSelectedMaterials) do begin
    if FSelectedMaterials[i] <> nil then
      Inc(Result);
  end;
end;

// ========== 公共方法 ==========

procedure TfrmSoul.ShowSoulForm(PlayObject: TPlayObject);
begin
  FPlayObject := PlayObject;
  ClearSelections;
  
  if FPlayObject <> nil then begin
    // 根据玩家职业设置默认选择
    cbSoulJob.ItemIndex := Ord(GetPlayerJobType(FPlayObject));
  end;
  
  UpdateUI;
  Show;
end;

end.
