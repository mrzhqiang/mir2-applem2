unit RefineForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grobal2, M2Share, RefineSystem, ObjPlay;

type
  TfrmRefine = class(TForm)
    pnlMain: TPanel;
    lblTitle: TLabel;
    
    // 装备区域
    gbEquipment: TGroupBox;
    lblEquipment: TLabel;
    lblRefineLevel: TLabel;
    btnSelectEquipment: TButton;
    
    // 材料区域
    gbMaterials: TGroupBox;
    lblMaterial1: TLabel;
    lblMaterial2: TLabel;
    lblMaterial3: TLabel;
    btnSelectMaterial1: TButton;
    btnSelectMaterial2: TButton;
    btnSelectMaterial3: TButton;
    btnClearMaterials: TButton;
    
    // 成功率显示
    gbSuccessRate: TGroupBox;
    lblSuccessRate: TLabel;
    pbSuccessRate: TProgressBar;
    
    // 操作按钮
    btnRefine: TButton;
    btnSynthesize: TButton;
    btnSoulBind: TButton;
    btnClose: TButton;
    
    // 凝练属性区域
    gbAttributes: TGroupBox;
    lblQuality: TLabel;
    lblTotalPoints: TLabel;
    memoAttributes: TMemo;
    
    // 日志区域
    gbLog: TGroupBox;
    memoLog: TMemo;
    
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectEquipmentClick(Sender: TObject);
    procedure btnSelectMaterial1Click(Sender: TObject);
    procedure btnSelectMaterial2Click(Sender: TObject);
    procedure btnSelectMaterial3Click(Sender: TObject);
    procedure btnClearMaterialsClick(Sender: TObject);
    procedure btnRefineClick(Sender: TObject);
    procedure btnSynthesizeClick(Sender: TObject);
    procedure btnSoulBindClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    
  private
    FPlayObject: TPlayObject;
    FSelectedEquipment: pTUserItem;
    FSelectedMaterials: array[0..2] of pTRefineMaterial;
    FCurrentSuccessRate: Integer;
    
    procedure UpdateUI;
    procedure UpdateSuccessRate;
    procedure UpdateAttributeDisplay;
    procedure ClearMaterials;
    procedure AddLog(const sMsg: string);
    function SelectItemFromBag(ItemType: Integer): pTUserItem;
    function GetMaterialFromItem(UserItem: pTUserItem): pTRefineMaterial;
    
  public
    procedure ShowRefineDialog(PlayObject: TPlayObject);
    
  end;

var
  frmRefine: TfrmRefine;

implementation

{$R *.dfm}

// ========== 窗体事件 ==========

procedure TfrmRefine.FormCreate(Sender: TObject);
begin
  FPlayObject := nil;
  FSelectedEquipment := nil;
  FillChar(FSelectedMaterials, SizeOf(FSelectedMaterials), 0);
  FCurrentSuccessRate := 0;
  
  // 设置窗体属性
  Position := poScreenCenter;
  BorderStyle := bsDialog;
  FormStyle := fsStayOnTop;
  
  // 初始化UI
  UpdateUI;
end;

procedure TfrmRefine.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

// ========== 按钮事件 ==========

procedure TfrmRefine.btnSelectEquipmentClick(Sender: TObject);
var
  UserItem: pTUserItem;
begin
  if FPlayObject = nil then Exit;
  
  UserItem := SelectItemFromBag(1); // 1表示选择装备
  if UserItem <> nil then begin
    if CanRefineEquipment(UserItem) then begin
      FSelectedEquipment := UserItem;
      UpdateUI;
      AddLog('选择装备: ' + UserEngine.GetStdItemName(UserItem.wIndex));
    end else begin
      AddLog('该装备无法进行凝练！');
    end;
  end;
end;

procedure TfrmRefine.btnSelectMaterial1Click(Sender: TObject);
var
  UserItem: pTUserItem;
  Material: pTRefineMaterial;
begin
  if FPlayObject = nil then Exit;
  
  UserItem := SelectItemFromBag(2); // 2表示选择材料
  if UserItem <> nil then begin
    Material := GetMaterialFromItem(UserItem);
    if Material <> nil then begin
      FSelectedMaterials[0] := Material;
      UpdateUI;
      AddLog('选择材料1: ' + Material.sName + '(' + IntToStr(Material.btGrade) + '阶)');
    end else begin
      AddLog('该物品不是凝练材料！');
    end;
  end;
end;

procedure TfrmRefine.btnSelectMaterial2Click(Sender: TObject);
var
  UserItem: pTUserItem;
  Material: pTRefineMaterial;
begin
  if FPlayObject = nil then Exit;
  
  UserItem := SelectItemFromBag(2); // 2表示选择材料
  if UserItem <> nil then begin
    Material := GetMaterialFromItem(UserItem);
    if Material <> nil then begin
      FSelectedMaterials[1] := Material;
      UpdateUI;
      AddLog('选择材料2: ' + Material.sName + '(' + IntToStr(Material.btGrade) + '阶)');
    end else begin
      AddLog('该物品不是凝练材料！');
    end;
  end;
end;

procedure TfrmRefine.btnSelectMaterial3Click(Sender: TObject);
var
  UserItem: pTUserItem;
  Material: pTRefineMaterial;
begin
  if FPlayObject = nil then Exit;
  
  UserItem := SelectItemFromBag(2); // 2表示选择材料
  if UserItem <> nil then begin
    Material := GetMaterialFromItem(UserItem);
    if Material <> nil then begin
      FSelectedMaterials[2] := Material;
      UpdateUI;
      AddLog('选择材料3: ' + Material.sName + '(' + IntToStr(Material.btGrade) + '阶)');
    end else begin
      AddLog('该物品不是凝练材料！');
    end;
  end;
end;

procedure TfrmRefine.btnClearMaterialsClick(Sender: TObject);
begin
  ClearMaterials;
  UpdateUI;
  AddLog('已清空所有材料');
end;

procedure TfrmRefine.btnRefineClick(Sender: TObject);
var
  Result: TRefineResult;
  i: Integer;
  bAllMaterialsSelected: Boolean;
begin
  if FPlayObject = nil then Exit;
  if FSelectedEquipment = nil then begin
    AddLog('请先选择要凝练的装备！');
    Exit;
  end;
  
  // 检查是否选择了所有材料
  bAllMaterialsSelected := True;
  for i := 0 to 2 do begin
    if FSelectedMaterials[i] = nil then begin
      bAllMaterialsSelected := False;
      Break;
    end;
  end;
  
  if not bAllMaterialsSelected then begin
    AddLog('请选择3个凝练材料！');
    Exit;
  end;
  
  // 执行凝练
  Result := RefineEquipment(FPlayObject, FSelectedEquipment, FSelectedMaterials);
  
  case Result of
    rr_Success: begin
      AddLog('凝练成功！装备等级提升到 +' + IntToStr(GetEquipmentRefineLevel(FSelectedEquipment)));
      ClearMaterials;
    end;
    rr_Failed: AddLog('凝练失败！材料已消耗');
    rr_MaterialLack: AddLog('材料不足！');
    rr_MaxLevel: AddLog('装备已达到最大凝练等级！');
    rr_InvalidItem: AddLog('无效的装备！');
    rr_SystemDisabled: AddLog('凝练系统未启用！');
  end;
  
  UpdateUI;
end;

procedure TfrmRefine.btnSynthesizeClick(Sender: TObject);
begin
  // TODO: 实现材料合成功能
  AddLog('材料合成功能开发中...');
end;

procedure TfrmRefine.btnSoulBindClick(Sender: TObject);
var
  Result: TSoulBindResult;
  nCost: Integer;
  sCurrencyName: string;
begin
  if FPlayObject = nil then Exit;
  if FSelectedEquipment = nil then begin
    AddLog('请先选择要进行灵魂绑定的装备！');
    Exit;
  end;
  
  // 检查是否可以进行灵魂绑定
  if not CanSoulBindEquipment(FSelectedEquipment) then begin
    if IsEquipmentSoulBound(FSelectedEquipment) then
      AddLog('该装备已经进行过灵魂绑定！')
    else
      AddLog('该装备品质不足，无法进行灵魂绑定！');
    Exit;
  end;
  
  nCost := GetSoulBindCost;
  sCurrencyName := GetSoulBindCurrencyName;
  
  // 确认对话框
  if MessageDlg('确定要花费 ' + IntToStr(nCost) + ' ' + sCurrencyName + ' 进行灵魂绑定吗？', 
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit;
  
  // 执行灵魂绑定
  Result := SoulBindEquipment(FPlayObject, FSelectedEquipment);
  
  case Result of
    sbr_Success: begin
      AddLog('灵魂绑定成功！装备已与您的灵魂绑定');
      UpdateUI; // 刷新界面显示
    end;
    sbr_AlreadyBound: AddLog('该装备已经进行过灵魂绑定！');
    sbr_QualityTooLow: AddLog('装备品质不足，需要精致品质及以上！');
    sbr_InsufficientCurrency: AddLog('货币不足，需要 ' + IntToStr(nCost) + ' ' + sCurrencyName);
    sbr_InvalidItem: AddLog('无效的装备！');
    sbr_SystemDisabled: AddLog('灵魂绑定系统未启用！');
    else AddLog('灵魂绑定失败！');
  end;
end;

procedure TfrmRefine.btnCloseClick(Sender: TObject);
begin
  Hide;
end;

// ========== 私有方法 ==========

procedure TfrmRefine.UpdateUI;
var
  i: Integer;
  RefineLevel, MaxRefineLevel: Byte;
begin
  // 更新装备信息
  if FSelectedEquipment <> nil then begin
    RefineLevel := GetEquipmentRefineLevel(FSelectedEquipment);
    MaxRefineLevel := GetEquipmentMaxRefineLevel(FSelectedEquipment);
    
    lblEquipment.Caption := UserEngine.GetStdItemName(FSelectedEquipment.wIndex);
    lblRefineLevel.Caption := '凝练等级: +' + IntToStr(RefineLevel) + '/' + IntToStr(MaxRefineLevel);
    btnSelectEquipment.Caption := '更换装备';
  end else begin
    lblEquipment.Caption := '未选择装备';
    lblRefineLevel.Caption := '凝练等级: --';
    btnSelectEquipment.Caption := '选择装备';
  end;
  
  // 更新材料信息
  if FSelectedMaterials[0] <> nil then
    lblMaterial1.Caption := FSelectedMaterials[0].sName + '(' + IntToStr(FSelectedMaterials[0].btGrade) + '阶)'
  else
    lblMaterial1.Caption := '未选择材料';
    
  if FSelectedMaterials[1] <> nil then
    lblMaterial2.Caption := FSelectedMaterials[1].sName + '(' + IntToStr(FSelectedMaterials[1].btGrade) + '阶)'
  else
    lblMaterial2.Caption := '未选择材料';
    
  if FSelectedMaterials[2] <> nil then
    lblMaterial3.Caption := FSelectedMaterials[2].sName + '(' + IntToStr(FSelectedMaterials[2].btGrade) + '阶)'
  else
    lblMaterial3.Caption := '未选择材料';
  
  // 更新成功率
  UpdateSuccessRate;
  
  // 更新属性显示
  UpdateAttributeDisplay;
  
  // 更新按钮状态
  btnRefine.Enabled := (FSelectedEquipment <> nil) and 
                       (FSelectedMaterials[0] <> nil) and 
                       (FSelectedMaterials[1] <> nil) and 
                       (FSelectedMaterials[2] <> nil) and
                       g_boRefineSystemEnabled;
                       
  btnSoulBind.Enabled := (FSelectedEquipment <> nil) and 
                         CanSoulBindEquipment(FSelectedEquipment) and
                         g_boSoulBindSystemEnabled;
end;

procedure TfrmRefine.UpdateSuccessRate;
var
  RefineLevel: Byte;
begin
  FCurrentSuccessRate := 0;
  
  if (FSelectedEquipment <> nil) and 
     (FSelectedMaterials[0] <> nil) and 
     (FSelectedMaterials[1] <> nil) and 
     (FSelectedMaterials[2] <> nil) then begin
    
    RefineLevel := GetEquipmentRefineLevel(FSelectedEquipment);
    FCurrentSuccessRate := CalculateRefineSuccessRate(RefineLevel, FSelectedMaterials);
  end;
  
  lblSuccessRate.Caption := '成功率: ' + IntToStr(FCurrentSuccessRate div 10) + '.' + IntToStr(FCurrentSuccessRate mod 10) + '%';
  pbSuccessRate.Position := FCurrentSuccessRate div 10;
end;

procedure TfrmRefine.UpdateAttributeDisplay;
var
  RefineInfo: pTRefineInfo;
  i: Integer;
  sAttributeText: string;
  nPredictedPoints: Integer;
begin
  // 清空属性显示
  memoAttributes.Clear;
  lblQuality.Caption := '品质: 粗糙';
  lblTotalPoints.Caption := '总属性点数: 0';
  
  if FSelectedEquipment = nil then Exit;
  
  RefineInfo := GetRefineInfo(FSelectedEquipment);
  
  // 显示当前品质和总点数
  lblQuality.Caption := '品质: ' + GetRefineQualityName(RefineInfo.RefineQuality);
  lblQuality.Font.Color := GetRefineQualityColor(RefineInfo.RefineQuality);
  lblTotalPoints.Caption := '总属性点数: ' + IntToStr(RefineInfo.nTotalAttributePoints);
  
  // 显示当前属性
  for i := 0 to High(RefineInfo.RefineAttributes) do begin
    if RefineInfo.RefineAttributes[i].boEnabled then begin
      sAttributeText := GetAttributeDisplayText(RefineInfo.RefineAttributes[i]);
      if sAttributeText <> '' then
        memoAttributes.Lines.Add(sAttributeText);
    end;
  end;
  
  // 显示灵魂绑定信息
  sAttributeText := GetSoulBindDisplayText(FSelectedEquipment);
  if sAttributeText <> '' then begin
    memoAttributes.Lines.Add('');
    memoAttributes.Lines.Add('--- 灵魂绑定 ---');
    memoAttributes.Lines.Add(sAttributeText);
  end;
  
  // 如果选择了材料，显示预测的属性点数增加
  if (FSelectedMaterials[0] <> nil) and 
     (FSelectedMaterials[1] <> nil) and 
     (FSelectedMaterials[2] <> nil) then begin
    nPredictedPoints := CalculateMaterialAttributePoints(FSelectedMaterials);
    memoAttributes.Lines.Add('');
    memoAttributes.Lines.Add('--- 预计获得 ---');
    memoAttributes.Lines.Add('属性点数: +' + IntToStr(nPredictedPoints));
    
    // 显示预计品质
    if RefineInfo.nTotalAttributePoints + nPredictedPoints > RefineInfo.nTotalAttributePoints then begin
      memoAttributes.Lines.Add('预计品质: ' + GetRefineQualityName(GetRefineQuality(RefineInfo.nTotalAttributePoints + nPredictedPoints)));
    end;
  end;
end;

procedure TfrmRefine.ClearMaterials;
begin
  FillChar(FSelectedMaterials, SizeOf(FSelectedMaterials), 0);
end;

procedure TfrmRefine.AddLog(const sMsg: string);
begin
  memoLog.Lines.Add('[' + TimeToStr(Now) + '] ' + sMsg);
  if memoLog.Lines.Count > 100 then
    memoLog.Lines.Delete(0);
  memoLog.Perform(WM_VSCROLL, SB_BOTTOM, 0);
end;

function TfrmRefine.SelectItemFromBag(ItemType: Integer): pTUserItem;
begin
  // TODO: 实现从背包选择物品的逻辑
  // 这里需要调用游戏的物品选择界面
  Result := nil;
end;

function TfrmRefine.GetMaterialFromItem(UserItem: pTUserItem): pTRefineMaterial;
begin
  if UserItem = nil then begin
    Result := nil;
    Exit;
  end;
  
  Result := GetRefineMaterial(UserItem.wIndex);
end;

// ========== 公共方法 ==========

procedure TfrmRefine.ShowRefineDialog(PlayObject: TPlayObject);
begin
  FPlayObject := PlayObject;
  ClearMaterials;
  FSelectedEquipment := nil;
  
  memoLog.Clear;
  AddLog('欢迎使用装备凝练系统！');
  
  UpdateUI;
  Show;
end;

end.
