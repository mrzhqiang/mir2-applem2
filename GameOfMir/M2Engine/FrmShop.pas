unit FrmShop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SDK, UsrEngn, DateUtils,
  Dialogs, Grobal2, ObjBase, ObjPlay, EDcodeEx, Hutil32, Common, IdSrvClient, M2Share, StdCtrls, Spin, ComCtrls;

type

  pTShopItem = ^TShopItem;
  TShopItem = packed record
    sName: string[14];
    btIdx: Byte;
    wIdent: Word;
    nPrict: Integer;
    nGoldPrict: Integer;
    wTime: Word;
    //nIntegral: Integer;
    btStatus: Byte;
    btAgio: Byte;
    nCount: Smallint;
    nSellCount: Word;
    //boGameGoldBuy: Boolean;
    nSupplySellCount: Smallint;
    btSupplyType: Byte;
    btSupplyTime: Byte;
    boSupply: Boolean;
    //sHint: string[255];
  end;


  TFormShop = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    ButtonAdd: TButton;
    ButtonDel: TButton;
    ButtonEdit: TButton;
    ButtonSave: TButton;
    ButtonRefur: TButton;
    SpinEditItems: TSpinEdit;
    EditName: TEdit;
    EditText: TEdit;
    GroupBox4: TGroupBox;
    ListBoxitemList: TListBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    ButtonOutHint: TButton;
    ComboBoxAgio: TComboBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    ComboBoxClass: TComboBox;
    Label1: TLabel;
    SpinEditCount: TSpinEdit;
    Label7: TLabel;
    SpinEditTime: TSpinEdit;
    Label3: TLabel;
    SpinEditPrice: TSpinEdit;
    Label8: TLabel;
    ListViewShopList: TListView;
    SpinEditSellCount: TSpinEdit;
    Label10: TLabel;
    ComboBoxSupplyType: TComboBox;
    SpinEditSupplyCount: TSpinEdit;
    ComboBoxSupplyTime: TComboBox;
    Button1: TButton;
    EditGold: TSpinEdit;
    Label9: TLabel;
    procedure ListBoxitemListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBoxitemListClick(Sender: TObject);
    procedure SpinEditPriceChange(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ListViewShopListChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonRefurClick(Sender: TObject);
    procedure ButtonOutHintClick(Sender: TObject);
    procedure ListViewShopListColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewShopListCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure Button1Click(Sender: TObject);
  private
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefShopItems();
  public
    procedure Open;
  end;

{ TShopEngine }

  TShopEngine = class(TObject)
    m_ListIndex: Word;
    m_boSave: Boolean;
    m_dwRunTick: LongWord;
    m_boInitialize: Boolean;
  private
    function AddShopItemToBag(PlayObject: TPlayObject; ShopItem: pTShopItem; nCount: Integer; GoldName: string): Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadShopItems();
    function SaveShopItems(boSupply: Boolean): Boolean;
    procedure initialize;
    procedure Freeinitialize;
    procedure Run;

    procedure ClientChangeGameGold(PlayObject: TPlayObject; nGoldCount: Integer; boAdd: Boolean);
    procedure ServerChangeGameGold(PlayObject: TPlayObject; nParam1, nParam2, nParam3, wParam: Integer; sData: string);
    procedure ClientTradeGameGold(PlayObject: TPlayObject; nTradeCount: Integer);
    procedure ServerTradeGameGold(PlayObject: TPlayObject; nParam1, nParam2, nParam3, wParam: Integer; sData: string);
    procedure ClientGetShopList(PlayObject: TPlayObject; nShowIndex: Integer);
    procedure ClientBuyShopItem(PlayObject: TPlayObject; nItemIndex, nIdent, nGameGold, nCount: Integer);
    procedure ServerBuyShopItem(PlayObject: TPlayObject; nParam1, nParam2, nParam3, wParam: Integer; sData: string);
  end;


var
  FormShop: TFormShop;
  ShopEngine: TShopEngine;

implementation

uses
  svMain;

var
  m_ShopItemList: TList;
  boStdItemBack: Boolean;
  ColumnToSort: Integer;

const
  SHOPLISTNAME  = 'ShopItemList.txt';
  SHOPSELLLIST = 'ShopSellList.txt';
  STATUSTEXT: array[Boolean] of String[2] = (' ', '√');

{$R *.dfm}

{ TFormShop }

procedure TFormShop.Button1Click(Sender: TObject);
var
  ShopItem: pTShopItem;
begin
  if Application.MessageBox('是否确定清空所有销售记录？', '提示信息',
    MB_OKCANCEL + MB_ICONQUESTION) = IDCANCEL then
  begin
    Exit;
  end;
  for ShopItem in m_ShopItemList do begin
    ShopItem.nSellCount := 0;
  end;
  ShopEngine.m_boSave := True;
  RefShopItems();
end;

procedure TFormShop.ButtonAddClick(Sender: TObject);
var
  ShopItem: pTShopItem;
  Item: TListItem;
begin
  for ShopItem in m_ShopItemList do begin
    if ShopItem.wIdent = SpinEditItems.Value then begin
      if ShopItem.wTime = SpinEditTime.Value then begin
        MessageBox(Handle, '列表当中已有相同的物品...', '提示信息', MB_OK or MB_ICONASTERISK);
        exit;
      end;
    end;
  end;
  New(ShopItem);
  SafeFillChar(ShopItem^, SizeOf(TShopItem), #0);
  ShopItem.btIdx := ComboBoxClass.ItemIndex;
  ShopItem.sName := EditName.Text;
  ShopItem.wIdent := SpinEditItems.Value;
  ShopItem.nPrict := SpinEditPrice.Value;
  ShopItem.nGoldPrict := EditGold.Value;
  ShopItem.wTime := SpinEditTime.Value;
  //ShopItem.nIntegral := SpinEditIntegral.Value;
  ShopItem.btAgio := ComboBoxAgio.ItemIndex;
  ShopItem.nCount := SpinEditCount.Value;
  ShopItem.nSellCount := SpinEditSellCount.Value;
  ShopItem.nSupplySellCount := SpinEditSupplyCount.Value;
  ShopItem.btSupplyType := ComboBoxSupplyType.ItemIndex;
  ShopItem.btSupplyTime := ComboBoxSupplyTime.ItemIndex;
  ShopItem.boSupply := False;
  //ShopItem.boGameGoldBuy := CheckBoxGameGoldBuy.Checked;

  SetByteStatus(ShopItem.btStatus, Ib_NoDeal, CheckBox1.Checked);
  SetByteStatus(ShopItem.btStatus, Ib_NoSave, CheckBox2.Checked);
  SetByteStatus(ShopItem.btStatus, Ib_NoRepair, CheckBox3.Checked);
  SetByteStatus(ShopItem.btStatus, Ib_NoDrop, CheckBox4.Checked);
  SetByteStatus(ShopItem.btStatus, Ib_NoDown, CheckBox5.Checked);
  SetByteStatus(ShopItem.btStatus, Ib_NoMake, CheckBox6.Checked);
  SetByteStatus(ShopItem.btStatus, Ib_NoSell, CheckBox7.Checked);
  SetByteStatus(ShopItem.btStatus, Ib_DropDestroy, CheckBox8.Checked);

 //ShopItem.sHint := EditText.Text;
  if (ShopItem.btIdx in [0..3]) and (ShopItem.wIdent > 0) and (ShopItem.nPrict > 0) then begin
    m_ShopItemList.Add(ShopItem);
    Inc(ShopEngine.m_ListIndex);
    Item := ListViewShopList.Items.Add;
    Item.Caption := ComboBoxClass.Items[ShopItem.btIdx];
    Item.SubItems.AddObject(ShopItem.sName, TObject(ShopItem));
    Item.SubItems.Add(IntToStr(ShopItem.nSellCount));
    Item.SubItems.Add(IntToStr(ShopItem.wIdent));
    Item.SubItems.Add(IntToStr(ShopItem.nPrict));
    Item.SubItems.Add(SpinEditTime.Text);
    //Item.SubItems.Add(SpinEditIntegral.Text);
    Item.SubItems.Add(ComboBoxAgio.Text);
    Item.SubItems.Add(SpinEditCount.Text);
    //Item.SubItems.Add(STATUSTEXT[ShopItem.boGameGoldBuy]);
    Item.SubItems.Add(STATUSTEXT[CheckBox1.Checked]);
    Item.SubItems.Add(STATUSTEXT[CheckBox2.Checked]);
    Item.SubItems.Add(STATUSTEXT[CheckBox3.Checked]);
    Item.SubItems.Add(STATUSTEXT[CheckBox4.Checked]);
    Item.SubItems.Add(STATUSTEXT[CheckBox5.Checked]);
    Item.SubItems.Add(STATUSTEXT[CheckBox6.Checked]);
    Item.SubItems.Add(STATUSTEXT[CheckBox7.Checked]);
    Item.SubItems.Add(STATUSTEXT[CheckBox8.Checked]);
    Item.SubItems.Add(IntToStr(ShopItem.nGoldPrict));
    //Item.SubItems.Add(ShopItem.sHint);
    ButtonAdd.Enabled := False;
    ButtonDel.Enabled := False;
    ButtonEdit.Enabled := False;
    ModValue;
  end
  else begin
    Dispose(ShopItem);
    Application.MessageBox('提交的信息不正确，请认真检查！', '提示信息', MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TFormShop.ButtonDelClick(Sender: TObject);
var
  ShopItem: pTShopItem;
  Item: TListItem;
  nIndex: Integer;
begin
  if (ListViewShopList.ItemIndex > -1) and (ListViewShopList.ItemIndex < ListViewShopList.Items.Count) then begin
    Item := ListViewShopList.Items[ListViewShopList.ItemIndex];
    if Item.SubItems.Count > 1 then begin
      ShopItem := pTShopItem(Item.SubItems.Objects[0]);
      nIndex := m_ShopItemList.IndexOf(ShopItem);
      if nIndex >= 0 then
        m_ShopItemList.Delete(nIndex);
      Dispose(ShopItem);
      ListViewShopList.Items.Delete(ListViewShopList.ItemIndex);
      Inc(ShopEngine.m_ListIndex);
      ButtonAdd.Enabled := False;
      ButtonDel.Enabled := False;
      ButtonEdit.Enabled := False;
      ModValue;
    end;
  end;
end;

procedure TFormShop.ButtonEditClick(Sender: TObject);
var
  ShopItem, ShopItemEx: pTShopItem;
  Item: TListItem;
begin
  if (ListViewShopList.ItemIndex > -1) and (ListViewShopList.ItemIndex < ListViewShopList.Items.Count) then begin
    Item := ListViewShopList.Items[ListViewShopList.ItemIndex];
    if Item.SubItems.Count > 14 then begin
      ShopItem := pTShopItem(Item.SubItems.Objects[0]);
      New(ShopItemEx);
      SafeFillChar(ShopItemEx^, SizeOf(TShopItem), #0);
      ShopItemEx.btIdx := ComboBoxClass.ItemIndex;
      ShopItemEx.sName := EditName.Text;
      ShopItemEx.wIdent := SpinEditItems.Value;
      ShopItemEx.nPrict := SpinEditPrice.Value;
      ShopItemEx.nGoldPrict := EditGold.Value;
      ShopItemEx.wTime := SpinEditTime.Value;
      //ShopItemEx.nIntegral := SpinEditIntegral.Value;
      ShopItemEx.btAgio := ComboBoxAgio.ItemIndex;
      ShopItemEx.nCount := SpinEditCount.Value;
      ShopItemEx.nSellCount := SpinEditSellCount.Value;
      ShopItemEx.nSupplySellCount := SpinEditSupplyCount.Value;
      ShopItemEx.btSupplyType := ComboBoxSupplyType.ItemIndex;
      ShopItemEx.btSupplyTime := ComboBoxSupplyTime.ItemIndex;
      ShopItemEx.boSupply := False;  
      //ShopItemEx.boGameGoldBuy := CheckBoxGameGoldBuy.Checked;

      SetByteStatus(ShopItemEx.btStatus, Ib_NoDeal, CheckBox1.Checked);
      SetByteStatus(ShopItemEx.btStatus, Ib_NoSave, CheckBox2.Checked);
      SetByteStatus(ShopItemEx.btStatus, Ib_NoRepair, CheckBox3.Checked);
      SetByteStatus(ShopItemEx.btStatus, Ib_NoDrop, CheckBox4.Checked);
      SetByteStatus(ShopItemEx.btStatus, Ib_NoDown, CheckBox5.Checked);
      SetByteStatus(ShopItemEx.btStatus, Ib_NoMake, CheckBox6.Checked);
      SetByteStatus(ShopItemEx.btStatus, Ib_NoSell, CheckBox7.Checked);
      SetByteStatus(ShopItemEx.btStatus, Ib_DropDestroy, CheckBox8.Checked);

      //ShopItemEx.sHint := EditText.Text;
      if (ShopItemEx.btIdx in [0..3]) and (ShopItemEx.wIdent > 0) and (ShopItemEx.nPrict > 0) then begin
        ShopItem^ := ShopItemEx^;
        Inc(ShopEngine.m_ListIndex);
        Item.Caption := ComboBoxClass.Items[ShopItemEx.btIdx];
        Item.SubItems[1] := (IntToStr(ShopItemEx.nSellCount));
        Item.SubItems[2] := (IntToStr(ShopItemEx.wIdent));
        Item.SubItems[3] := (IntToStr(ShopItemEx.nPrict));
        Item.SubItems[4] := (SpinEditTime.Text);
        //Item.SubItems[5] := (SpinEditIntegral.Text);
        Item.SubItems[5] := (ComboBoxAgio.Text);
        Item.SubItems[6] := (SpinEditCount.Text);
        //Item.SubItems[8] := (STATUSTEXT[ShopItemEx.boGameGoldBuy]);
        Item.SubItems[7] := (STATUSTEXT[CheckBox1.Checked]);
        Item.SubItems[8] := (STATUSTEXT[CheckBox2.Checked]);
        Item.SubItems[9] := (STATUSTEXT[CheckBox3.Checked]);
        Item.SubItems[10] := (STATUSTEXT[CheckBox4.Checked]);
        Item.SubItems[11] := (STATUSTEXT[CheckBox5.Checked]);
        Item.SubItems[12] := (STATUSTEXT[CheckBox6.Checked]);
        Item.SubItems[13] := (STATUSTEXT[CheckBox7.Checked]);
        Item.SubItems[14] := (STATUSTEXT[CheckBox8.Checked]);
        Item.SubItems[15] := (IntToStr(ShopItemEx.nGoldPrict));
        //Item.SubItems[15] := (ShopItemEx.sHint);
        ButtonAdd.Enabled := False;
        ModValue;
      end
      else begin
        Application.MessageBox('提交的信息不正确，请认真检查！', '提示信息', MB_OK + MB_ICONINFORMATION);
      end;
      Dispose(ShopItemEx);
    end;
  end;
end;

procedure TFormShop.ButtonOutHintClick(Sender: TObject);
{var
  ShopItem: pTShopItem;
  SaveList: TStringList;    }
begin
  {SaveList := TStringList.Create;
  Try
    for ShopItem in m_ShopItemList do begin
      if ShopItem.sHint <> '' then begin
        SaveList.Add(EncodeString(ShopItem.sName + '=' + ShopItem.sHint));
      end;
    end;
    SaveList.SaveToFile('.\ShopHint.dat');
  Finally
    SaveList.Free;
  End;
  MessageBox(Handle, '生成完成...', '提示信息', MB_OK or MB_ICONASTERISK);   }
end;

procedure TFormShop.ButtonRefurClick(Sender: TObject);
begin
  if MessageBox(Handle, PChar('是否确定重新加载物品列表?...'), '提示信息', MB_YESNO or MB_ICONQUESTION) = IDYES then begin
    ShopEngine.LoadShopItems;
    ShopEngine.m_boInitialize := True;
    RefShopItems;
  end;
end;

procedure TFormShop.ButtonSaveClick(Sender: TObject);
begin
  ShopEngine.SaveShopItems(False);
  uModValue;
end;

procedure TFormShop.ListBoxitemListClick(Sender: TObject);
var
  StdItem: pTStdItem;
begin
  if ListBoxItemList.ItemIndex > -1 then begin
    StdItem := pTStdItem(ListBoxItemList.Items.Objects[ListBoxItemList.ItemIndex]);
    EditName.Text := StdItem.Name;
    SpinEditItems.Value := StdItem.Idx + 1;
    ButtonAdd.Enabled := True;
    ButtonEdit.Enabled := False;
    ButtonDel.Enabled := False;
  end;
end;

procedure TFormShop.ListBoxitemListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  sIPaddr: string;
  I, nIdx: Integer;
begin
  if (ssCtrl in Shift) and (Key = word('F')) then begin
    sIPaddr := InputBox('查找信息', '请输入要查找的内容(支持模糊查找)', '');
    nIdx := ListBoxitemList.ItemIndex + 1;
    if nIdx >= ListBoxitemList.Count then
      nIdx := 0;
    for I := nIdx to ListBoxitemList.Count - 1 do begin
      if CompareLStr(ListBoxItemList.Items.Strings[I], sIPaddr, Length(sIPAddr)) then begin
        ListBoxitemList.Selected[I] := True;
        break;
      end;
    end;
  end;
end;

procedure TFormShop.ListViewShopListChange(Sender: TObject; Item: TListItem; Change: TItemChange);
var
  ShopItem: pTShopItem;
begin
  if Item.SubItems.Count > 14 then begin
    ShopItem := pTShopItem(Item.SubItems.Objects[0]);
    ComboBoxClass.ItemIndex := ShopItem.btIdx;
    EditName.Text := Item.SubItems.Strings[0];
    SpinEditSellCount.Text := Item.SubItems.Strings[1];
    SpinEditItems.Text := Item.SubItems.Strings[2];
    SpinEditPrice.Text := Item.SubItems.Strings[3];
    SpinEditTime.Text := Item.SubItems.Strings[4];
    //SpinEditIntegral.Text := Item.SubItems.Strings[5];
    ComboBoxAgio.ItemIndex := ShopItem.btAgio;
    SpinEditCount.Text := Item.SubItems.Strings[6];
    SpinEditSupplyCount.Value := ShopItem.nSupplySellCount;
    ComboBoxSupplyType.ItemIndex := ShopItem.btSupplyType;
    ComboBoxSupplyTime.ItemIndex := ShopItem.btSupplyTime;
    //CheckBoxGameGoldBuy.Checked := (Item.SubItems.Strings[8] = STATUSTEXT[True]);
    CheckBox1.Checked := (Item.SubItems.Strings[7] = STATUSTEXT[True]);
    CheckBox2.Checked := (Item.SubItems.Strings[8] = STATUSTEXT[True]);
    CheckBox3.Checked := (Item.SubItems.Strings[9] = STATUSTEXT[True]);
    CheckBox4.Checked := (Item.SubItems.Strings[10] = STATUSTEXT[True]);
    CheckBox5.Checked := (Item.SubItems.Strings[11] = STATUSTEXT[True]);
    CheckBox6.Checked := (Item.SubItems.Strings[12] = STATUSTEXT[True]);
    CheckBox7.Checked := (Item.SubItems.Strings[13] = STATUSTEXT[True]);
    CheckBox8.Checked := (Item.SubItems.Strings[14] = STATUSTEXT[True]);
    EditGold.Value := ShopItem.nGoldPrict;
    //EditText.Text := Item.SubItems.Strings[15];
    ButtonDel.Enabled := True;
    ButtonEdit.Enabled := True;
  end;
end;

procedure TFormShop.ListViewShopListColumnClick(Sender: TObject; Column: TListColumn);
begin
  if ColumnToSort = Column.Index then boStdItemBack := not boStdItemBack;
  ColumnToSort := Column.Index;
  (Sender as TCustomListView).AlphaSort;
end;

procedure TFormShop.ListViewShopListCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
begin
  if ColumnToSort = 0 then begin
    Compare := CompareStr(Item1.Caption, Item2.Caption);
    if not boStdItemBack then Compare := -Compare;
  end else begin
    ix := ColumnToSort - 1;
    Compare := CompareStr(Item1.SubItems[ix], Item2.SubItems[ix]);
    if not boStdItemBack then Compare := -Compare;
  end;
end;

procedure TFormShop.ModValue;
begin
  boModValued := True;
  ButtonSave.Enabled := True;
end;

procedure TFormShop.uModValue;
begin
  boModValued := False;
  ButtonSave.Enabled := False;
end;

procedure TFormShop.Open;
var
  i: Integer;
  StdItem: pTStdItem;
begin
  ListBoxitemList.Clear;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for i := 0 to UserEngine.StdItemList.Count - 1 do begin
      StdItem := UserEngine.StdItemList.Items[i];
      ListBoxitemList.Items.AddObject(StdItem.Name, TObject(StdItem));
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  RefShopItems;
  uModValue;
  ShowModal;
end;

procedure TFormShop.RefShopItems;
var
  ShopItem: pTShopItem;
  Item: TListItem;
begin
  ListViewShopList.Clear;
  for ShopItem in m_ShopItemList do begin
    Item := ListViewShopList.Items.Add;
    Item.Caption := ComboBoxClass.Items[ShopItem.btIdx];
    Item.SubItems.AddObject(ShopItem.sName, TObject(ShopItem));
    Item.SubItems.Add(IntToStr(ShopItem.nSellCount));
    Item.SubItems.Add(IntToStr(ShopItem.wIdent));
    Item.SubItems.Add(IntToStr(ShopItem.nPrict));
    Item.SubItems.Add(IntToStr(ShopItem.wTime));
    //Item.SubItems.Add(IntToStr(ShopItem.nIntegral));
    Item.SubItems.Add(ComboBoxAgio.Items[ShopItem.btAgio]);
    Item.SubItems.Add(IntToStr(ShopItem.nCount));
    //Item.SubItems.Add(STATUSTEXT[ShopItem.boGameGoldBuy]);
    Item.SubItems.Add(STATUSTEXT[CheckByteStatus(ShopItem.btStatus, Ib_NoDeal)]);
    Item.SubItems.Add(STATUSTEXT[CheckByteStatus(ShopItem.btStatus, Ib_NoSave)]);
    Item.SubItems.Add(STATUSTEXT[CheckByteStatus(ShopItem.btStatus, Ib_NoRepair)]);
    Item.SubItems.Add(STATUSTEXT[CheckByteStatus(ShopItem.btStatus, Ib_NoDrop)]);
    Item.SubItems.Add(STATUSTEXT[CheckByteStatus(ShopItem.btStatus, Ib_NoDown)]);
    Item.SubItems.Add(STATUSTEXT[CheckByteStatus(ShopItem.btStatus, Ib_NoMake)]);
    Item.SubItems.Add(STATUSTEXT[CheckByteStatus(ShopItem.btStatus, Ib_NoSell)]);
    Item.SubItems.Add(STATUSTEXT[CheckByteStatus(ShopItem.btStatus, Ib_DropDestroy)]);
    Item.SubItems.Add(IntToStr(ShopItem.nGoldPrict));
    //Item.SubItems.Add(ShopItem.sHint);
  end;
end;

procedure TFormShop.SpinEditPriceChange(Sender: TObject);
begin

end;

{ TShopEngine }

constructor TShopEngine.Create;
begin
  inherited;
  m_ListIndex := 0;
  m_boSave := False;
  m_dwRunTick := GetTickCount + 30 * 1000 * 60;
  m_boInitialize := False;
end;

destructor TShopEngine.Destroy;
begin

  inherited;
end;

procedure TShopEngine.Freeinitialize;
var
  ShopItem: pTShopItem;
begin
  for ShopItem in m_ShopItemList do begin
    Dispose(ShopItem);
  end;
  m_ShopItemList.Clear;
  m_boInitialize := False;
end;

procedure TShopEngine.initialize;
begin
  LoadShopItems;
  m_boInitialize := True;
end;

procedure TShopEngine.LoadShopItems;
var
  sFileName: string;
  LoadList: TStringList;
  ShopItem: pTShopItem;
  Stditem: pTStdItem;
  sLoadStr, sData: string;
  sName, sIdx, sIdent, sPrict, sGoldPrict, sTime, sStatus, sAgio, sCount, sSellCount, sSupplyCount, sSupplyType, sSupplyTime{, sHint}: string;
  nIdx, nIdent, nPrict, nTime, nStatus, nAgio, nCount, nSellCount, nSupplyCount, nGoldPrict: Integer;
begin
  Freeinitialize;
  sFileName := g_Config.sGameDataDir + SHOPLISTNAME;
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    Try
      LoadList.LoadFromFile(sFileName);
      for sData in LoadList do begin
        sLoadStr := sData;
        if (sLoadStr <> '') and (sLoadStr[1] <> ';') then begin
          sLoadStr := GetValidStr3(sLoadStr, sName, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sIdx, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sIdent, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sPrict, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sTime, [' ', #9]);
          //sLoadStr := GetValidStr3(sLoadStr, sIntegral, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sStatus, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sAgio, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sCount, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sSellCount, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sSupplyCount, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sSupplyType, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sSupplyTime, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sGoldPrict, [' ', #9]);
          //sHint := GetValidStr3(sLoadStr, sGoldBuy, [' ', #9]);
          nIdx := StrToIntDef(sIdx, -1);
          nIdent := StrToIntDef(sIdent, 0);
          nPrict := StrToIntDef(sPrict, -1);
          nTime := StrToIntDef(sTime, 0);
          //nIntegral := StrToIntDef(sIntegral, 0);
          nStatus := StrToIntDef(sStatus, 0);
          nAgio := StrToIntDef(sAgio, 0);
          nCount := StrToIntDef(sCount, 0);
          nSellCount := StrToIntDef(sSellCount, 0);
          nSupplyCount := StrToIntDef(sSupplyCount, 0);
          nGoldPrict := StrToIntDef(sGoldPrict, 0);
          if (nIdx in [0..3]) and (nIdent > 0) and (nPrict >= 0) then begin
            StdItem := UserEngine.GetStdItem(sName);
            if StdItem <> nil then begin
              New(ShopItem);
              SafeFillChar(ShopItem^, SizeOf(TShopItem), #0);
              ShopItem.btIdx := nIdx;
              ShopItem.sName := StdItem.Name;
              ShopItem.wIdent := StdItem.Idx + 1;
              ShopItem.nPrict := nPrict;
              ShopItem.nGoldPrict := nGoldPrict;
              ShopItem.wTime := nTime;
              //ShopItem.nIntegral := nIntegral;
              ShopItem.btAgio := nAgio;
              ShopItem.nCount := nCount;
              ShopItem.nSellCount := nSellCount;
              ShopItem.nSupplySellCount := nSupplyCount;
              ShopItem.btSupplyType := StrToIntDef(sSupplyType, 0);
              ShopItem.btSupplyTime := StrToIntDef(sSupplyTime, 0);
              ShopItem.boSupply := False;
              //ShopItem.boGameGoldBuy := sGoldBuy = '1';
              ShopItem.btStatus := nStatus;
              //ShopItem.sHint := sHint;
              m_ShopItemList.Add(ShopItem);
            end;
          end;
        end;
      end;
      Inc(m_ListIndex);
    Finally
      LoadList.Free;
    End;
  end;
end;

function TShopEngine.SaveShopItems(boSupply: Boolean): Boolean;
resourcestring
  sText = '%s'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d';
var
  ShopItem: pTShopItem;
  SaveList: TStringList;
  btWeek: Byte;
begin
  Result := False;
  if not m_boInitialize then exit;
  m_boSave := False;
  SaveList := TStringList.Create;
  btWeek := DayOfTheWeek(Now) - 1;
  Try
    for ShopItem in m_ShopItemList do begin
      if boSupply then begin
        if (ShopItem.nCount >= 0) and (ShopItem.btSupplyType > 0) and (ShopItem.nSupplySellCount > 0) then begin
          case ShopItem.btSupplyType of
            1: begin
                if ShopItem.nCount = 0 then begin
                  ShopItem.nCount := ShopItem.nSupplySellCount;
                  Result := True;
                end;
              end;
            2: begin
                if ShopItem.btSupplyTime = btWeek then begin
                  if not ShopItem.boSupply then begin
                    ShopItem.nCount := ShopItem.nSupplySellCount;
                    Result := True;
                    ShopItem.boSupply := True;
                  end;
                end else
                  ShopItem.boSupply := False;
              end;
            3: begin
                if ShopItem.btSupplyTime = btWeek then begin
                  if (not ShopItem.boSupply) and (ShopItem.nCount = 0) then begin
                    ShopItem.nCount := ShopItem.nSupplySellCount;
                    Result := True;
                    ShopItem.boSupply := True;
                  end;
                end else
                  ShopItem.boSupply := False;
              end;
          end;
        end;
      end;
      SaveList.Add(Format(sText, [
            ShopItem.sName,
            ShopItem.btIdx,
            ShopItem.wIdent,
            ShopItem.nPrict,
            ShopItem.wTime,
            //ShopItem.nIntegral,
            ShopItem.btStatus,
            ShopItem.btAgio,
            ShopItem.nCount,
            ShopItem.nSellCount,
            ShopItem.nSupplySellCount,
            ShopItem.btSupplyType,
            ShopItem.btSupplyTime,
            ShopItem.nGoldPrict
            //Integer(ShopItem.boGameGoldBuy),
            {ShopItem.sHint}]));


    end;
    SaveList.SaveToFile(g_Config.sGameDataDir + SHOPLISTNAME);
    Inc(m_ListIndex);
  Finally
    SaveList.Free;
  End;
end;

procedure TShopEngine.Run;
begin
  Try
    if m_boSave or (GetTickCount > m_dwRunTick) then begin
      m_boSave := False;
      m_dwRunTick := GetTickCount + 30 * 1000 * 60;
      SaveShopItems(True);
    end;
  Except
    On E:Exception do begin
      MainOutMessage('[Exception] TShopEngine.Run');
      MainOutMessage(E.Message);
    end;

  End;
end;

procedure TShopEngine.ServerBuyShopItem(PlayObject: TPlayObject; nParam1, nParam2, nParam3, wParam: Integer; sData: string);
var
  sBack, sGameCount, sPic, sIdent: string;
  nBack, nGameCount, nCount, nIdent, nItemIndex, nPic, nShopCount, nCheckCount: Integer;
  ShopItem: pTShopItem;
  Stditem: pTStdItem;
  Pic64: Int64;
begin
  sData := GetValidStr3(sData, sBack, ['/']);
  sData := GetValidStr3(sData, sGameCount, ['/']);
  sData := GetValidStr3(sData, sPic, ['/']);
  sData := GetValidStr3(sData, sIdent, ['/']);
  nBack := StrToIntDef(sBack, 0);
  nGameCount := StrToIntDef(sGameCount, -1);
  nIdent := StrToIntDef(sIdent, -1);
  nPic := StrToIntDef(sPic, 0);
  nCount := nParam2;
  nItemIndex := nParam3;
  nShopCount := 0;
  Pic64 := 0;
  if (nBack <> 0) and (nGameCount >= 0) and (nCount > 0) and (nIdent > 0) and (nPic > 0) then begin
    if nBack = 1 then begin
      AddGameLog(PlayObject, LOG_GAMEPOINTCHANGED, sSTRING_GAMEPOINT, nParam1, nPic,
        '商铺', '扣除', '成功', '购买', nil);
      nBack := -1; //购买的物品不存在
      if (nItemIndex >= 0) and (nItemIndex < m_ShopItemList.Count) then begin
        ShopItem := m_ShopItemList[nItemIndex];
        if (ShopItem.wIdent = nIdent) and ((ShopItem.nCount = -1) or (ShopItem.nCount > 0)) then begin
          Stditem := UserEngine.GetStdItem(nIdent);
          if Stditem <> nil then begin
            if (sm_Superposition in Stditem.StdModeEx) and (Stditem.DuraMax > 1) then begin
              nCount := _MIN(nCount, Stditem.DuraMax);
              if ShopItem.nCount > 0 then begin
                nCount := _MIN(nCount, ShopItem.nCount);
              end;
              nCheckCount := 1;
            end else begin
              nCount := _MIN(nCount, 10);
              if ShopItem.nCount > 0 then begin
                nCount := _MIN(nCount, ShopItem.nCount);
              end;
              nCheckCount := nCount;
            end;
            if (PlayObject.m_ItemList.Count + nCheckCount) <= PlayObject.m_nMaxItemListCount then begin
              Pic64 := Int64(GetShopAgio(ShopItem.nPrict, ShopItem.btAgio)) * Int64(nCount);
              if (Pic64 > 0) and (nPic >= Pic64) then begin
                nBack := AddShopItemToBag(PlayObject, ShopItem, nCount, sSTRING_GAMEPOINT);
                if nBack = 1 then begin
                  nShopCount := ShopItem.nCount;
                end;
              end;
            end else
              nBack := -3; //背包空间已满
          end;
        end else
          nBack := -2; //购买的物品已经卖完
      end;
      if nBack = 1 then begin
        if nPic > Pic64 then begin
          PlayObject.m_nGamePoint := nGameCount + (nPic - Pic64);
          IntegerChange(PlayObject.m_nGameDiamond, Pic64, INT_ADD);
          if g_boGameLogGameDiamond then begin
            AddGameLog(PlayObject, LOG_GAMEDIAMONDCHANGED, sSTRING_GAMEDIAMOND, 0, PlayObject.m_nGameDiamond, '商铺',
              '+', IntToStr(Pic64), '购买', nil);
          end;
          PlayObject.GameGoldChanged;
          PlayObject.DiamondChanged;

          ClientChangeGameGold(PlayObject, nPic - Pic64, True);
          FrmIDSoc.GameGoldChange(PlayObject, PlayObject.m_nGamePoint);
        end else begin
          PlayObject.m_nGamePoint := nGameCount;
          IntegerChange(PlayObject.m_nGameDiamond, nPic, INT_ADD);
          if g_boGameLogGameDiamond then begin
            AddGameLog(PlayObject, LOG_GAMEDIAMONDCHANGED, sSTRING_GAMEDIAMOND, 0, PlayObject.m_nGameDiamond, '商铺',
              '+', IntToStr(nPic), '购买', nil);
          end;
          PlayObject.GameGoldChanged;
          PlayObject.DiamondChanged;
          FrmIDSoc.GameGoldChange(PlayObject, nGameCount);
        end;
      end else begin
        ClientChangeGameGold(PlayObject, nPic, True);
      end;
    end else begin
      AddGameLog(PlayObject, LOG_GAMEPOINTCHANGED, sSTRING_GAMEPOINT, nParam1, nPic,
          '商铺', '扣除', '失败', '购买 ID=' + sBack, nil);
      if nBack = -4 then nBack := -5 //点卷不足
      else nBack := -7;
    end;
  end else
    nBack := -7; //系统错误
  PlayObject.SendDefMessage(SM_CLIENTBUYSHOPITEM, nBack, 0, 0, nShopCount, '');
end;

procedure TShopEngine.ServerChangeGameGold(PlayObject: TPlayObject; nParam1, nParam2, nParam3, wParam: Integer; sData: string);
const
  GOLDMODNAME: array[Boolean] of string[4] = ('扣除', '增加');
var
  sBack, sGameCount: string;
  nBack, nGameCount, nCount: Integer;
  boAdd: Boolean;
begin
  sData := GetValidStr3(sData, sBack, ['/']);
  sData := GetValidStr3(sData, sGameCount, ['/']);
  boAdd := wParam = 1;
  nBack := StrToIntDef(sBack, 0);
  nGameCount := StrToIntDef(sGameCount, -1);
  nCount := nParam2;
  if (nBack <> 0) and (nGameCount >= 0) and (nCount > 0) then begin
    if nBack = 1 then begin
      AddGameLog(PlayObject, LOG_GAMEPOINTCHANGED, sSTRING_GAMEPOINT, nParam1, nCount,
        '商铺', GOLDMODNAME[boAdd], '成功', '修改', nil);
      PlayObject.m_nGamePoint := nGameCount;
      PlayObject.GameGoldChanged;
    end else begin
      AddGameLog(PlayObject, LOG_GAMEPOINTCHANGED, sSTRING_GAMEPOINT, nParam1, nCount,
        '商铺', GOLDMODNAME[boAdd], '失败', '修改 ID=' + sBack, nil);
    end;
  end;
end;

procedure TShopEngine.ServerTradeGameGold(PlayObject: TPlayObject; nParam1, nParam2, nParam3, wParam: Integer; sData: string);
var
  sBack, sGameCount: string;
  nBack, nGameCount, nTradeCount: Integer;
begin
  sData := GetValidStr3(sData, sBack, ['/']);
  sData := GetValidStr3(sData, sGameCount, ['/']);
  nBack := StrToIntDef(sBack, 0);
  nGameCount := StrToIntDef(sGameCount, -1);
  nTradeCount := nParam2;
  if (nBack <> 0) and (nGameCount >= 0) and (nTradeCount > 0) then begin
    if nBack = 1 then begin
      AddGameLog(PlayObject, LOG_GAMEPOINTCHANGED, sSTRING_GAMEPOINT, nParam1, nTradeCount,
          '商铺', '扣除', '成功', '对换', nil);
      PlayObject.m_nGamePoint := nGameCount;
      IntegerChange(PlayObject.m_nGameGold, nTradeCount, INT_ADD);
      IntegerChange(PlayObject.m_nGameDiamond, nTradeCount, INT_ADD);
      if g_boGameLogGameGold then begin
        AddGameLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, PlayObject.m_nGameGold, '商铺',
          '+', IntToStr(nTradeCount), '对换', nil);
      end;
      if g_boGameLogGameDiamond then begin
        AddGameLog(PlayObject, LOG_GAMEDIAMONDCHANGED, sSTRING_GAMEDIAMOND, 0, PlayObject.m_nGameDiamond, '商铺',
          '+', IntToStr(nTradeCount), '对换', nil);
      end;
      PlayObject.GameGoldChanged;
      PlayObject.DiamondChanged;
      PlayObject.SendDefMessage(SM_CLIENTBUYITEM, -6, nTradeCount, 0, 0, '');
    end else begin
      AddGameLog(PlayObject, LOG_GAMEPOINTCHANGED, sSTRING_GAMEPOINT, nParam1, nTradeCount,
          '商铺', '扣除', '失败', '对换 ID=' + sBack, nil);
      if nBack = -4 then PlayObject.SendDefMessage(SM_CLIENTBUYITEM, -2, 0, 0, 0, '')
      else PlayObject.SendDefMessage(SM_CLIENTBUYITEM, -20, 0, 0, 0, '');
    end;
    FrmIDSoc.GameGoldChange(PlayObject, nGameCount);
  end;
end;

function TShopEngine.AddShopItemToBag(PlayObject: TPlayObject; ShopItem: pTShopItem; nCount: Integer; GoldName: string): Integer;
var
  Stditem: pTStdItem;
  UserItem, UserItem2: pTUserItem;
begin
  Result := -1;
  StdItem := UserEngine.GetStdItem(ShopItem.wIdent);
  if StdItem <> nil then begin
    New(UserItem);
//    MainOutMessage(IntToStr(UserItem.EffectValue.btEffect));
    if UserEngine.CopyToUserItemFromIdxEx(ShopItem.wIdent, UserItem) then begin
//    MainOutMessage(IntToStr(UserItem.EffectValue.btEffect));
      UserItem.btBindMode1 := ShopItem.btStatus;
      if ShopItem.wTime > 0 then
        UserItem.TermTime := DateTimeToLongWord(IncDay(Now, ShopItem.wTime));
      WordChange(ShopItem.nSellCount, nCount, INT_ADD);
      if ShopItem.nCount > -1 then begin
        if nCount >= ShopItem.nCount then ShopItem.nCount := 0
        else Dec(ShopItem.nCount, nCount);
        m_boSave := True;
      end;
      if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
        UserItem.Dura := _MIN(nCount, UserItem.DuraMax);
        UserItem.MakeIndex := GetItemNumber();
        PlayObject.m_ItemList.Add(UserItem);
//    MainOutMessage(IntToStr(UserItem.EffectValue.btEffect));
        PlayObject.SendAddItem(UserItem);
        if StdItem.NeedIdentify = 1 then
          AddGameLog(PlayObject, LOG_ADDITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, '商铺',
            IntToStr(nCount), GoldName, '购买', UserItem);
      end else begin
        while (nCount > 0) do begin
          New(UserItem2);
          UserItem2^ := UserItem^;
          UserItem2.MakeIndex := GetItemNumber();
          PlayObject.m_ItemList.Add(UserItem2);
//    MainOutMessage(IntToStr(UserItem.EffectValue.btEffect));
          PlayObject.SendAddItem(UserItem2);
          if StdItem.NeedIdentify = 1 then
            AddGameLog(PlayObject, LOG_ADDITEM, StdItem.Name, UserItem2.MakeIndex, UserItem2.Dura, '商铺',
              '1', GoldName, '购买', UserItem2);
          Dec(nCount);
        end;
        Dispose(UserItem);
      end;
      Result := 1;
    end else
      Dispose(UserItem);
  end;
end;

procedure TShopEngine.ClientBuyShopItem(PlayObject: TPlayObject; nItemIndex, nIdent, nGameGold, nCount: Integer);
var
  boGamePoint: Boolean;
  ShopItem: pTShopItem;
  Stditem: pTStdItem;
  nBack, nCheckCount: Integer;
  Pic64: Int64;
  nShopCount: SmallInt;
  sSendMsg: string;
begin
  //  nGameGold = 0 点卷购买
  nShopCount := -1;
  boGamePoint := nGameGold = 0;
  nBack := -1; //购买的物品不存在
  // 有效的商城物品
  if (nItemIndex >= 0) and (nItemIndex < m_ShopItemList.Count) and (nCount > 0) then begin
    ShopItem := m_ShopItemList[nItemIndex];
    if (ShopItem.wIdent = nIdent) and ((ShopItem.nCount = -1) or (ShopItem.nCount > 0)) then begin
      Stditem := UserEngine.GetStdItem(nIdent);
      if Stditem <> nil then begin
        // 支持叠加物品，超过数量 10 的购买
        if (sm_Superposition in Stditem.StdModeEx) and (Stditem.DuraMax > 1) then begin
          nCount := _MIN(nCount, Stditem.DuraMax);
          if ShopItem.nCount > 0 then begin
            nCount := _MIN(nCount, ShopItem.nCount);
          end;
          nCheckCount := 1;
        end else begin // 非叠加物品，最多是现有数量或者 10 个上限购买
          nCount := _MIN(nCount, 10);
          if ShopItem.nCount > 0 then begin
            nCount := _MIN(nCount, ShopItem.nCount);
          end;
          nCheckCount := nCount;
        end;
        // 检测背包是否可容纳购买的物品数量
        if (PlayObject.m_ItemList.Count + nCheckCount) <= PlayObject.m_nMaxItemListCount then begin
          // 2020-12-27 修复：金币购买时，因元宝价格为 0 而提示物品不存在
          if nGameGold = 2 then begin
            if ShopItem.nGoldPrict > 0 then begin
              Pic64 := Int64(GetShopAgio(ShopItem.nGoldPrict, ShopItem.btAgio)) * Int64(nCount);
              if Pic64 > 0 then begin
                // fixme: 修复金币数量超过 21 亿上限
                if Int64(PlayObject.m_nGold) >= Pic64 then begin
                  nBack := AddShopItemToBag(PlayObject, ShopItem, nCount, sSTRING_GOLDNAME);
                  if nBack = 1 then begin
                    IntegerChange(PlayObject.m_nGold, Pic64, INT_DEL);
                    if g_boGameLogGold then
                      AddGameLog(PlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayObject.m_nGold, '商铺', '-', IntToStr(Pic64), '购买', nil);
                    nShopCount := ShopItem.nCount;
                    PlayObject.GoldChanged;
                  end;
                end else
                  nBack := -8; //金币不足
              end;
            end else
              nBack := -9; //无法使用金币购买
          end else begin
            if ShopItem.nPrict > 0 then begin
              Pic64 := Int64(GetShopAgio(ShopItem.nPrict, ShopItem.btAgio)) * Int64(nCount);
              if Pic64 > 0 then begin
                if Int64(PlayObject.m_nGameGold) >= Pic64 then begin
                  nBack := AddShopItemToBag(PlayObject, ShopItem, nCount, sSTRING_GAMEGOLD);
                  if nBack = 1 then begin
                    IntegerChange(PlayObject.m_nGameGold, Pic64, INT_DEL);
                    if g_boGameLogGameGold then
                      AddGameLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, PlayObject.m_nGameGold, '商铺',
                                  '-', IntToStr(Pic64), '购买', nil);
                    nShopCount := ShopItem.nCount;
                    PlayObject.GameGoldChanged;
                  end;
                end else
                  nBack := -4; //元宝不足
              end;
            end else
              nBack := -1; //无法使元宝购买
          end;
          // 点券？
          if Pic64 > 0 then begin
            if boGamePoint then begin
              if Int64(PlayObject.m_nGamePoint) >= Pic64 then begin
                if PlayObject.m_nWaitIndex = 0 then begin
                  PlayObject.m_nWaitIndex := GetWaitMsgID;
                  PlayObject.m_nSQLAppendCount := nCount;
                  PlayObject.m_nSQLAppendShopIndex := nItemIndex;
                  PlayObject.m_nSQLAppendBool := True; //扣除
                  PlayObject.m_nSQLAppendString := IntToStr(Pic64) + '/' + IntToStr(nIdent) + '/';
                  AddGameLog(PlayObject, LOG_GAMEPOINTCHANGED, sSTRING_GAMEPOINT, PlayObject.m_nWaitIndex, Pic64,
                    '商铺', '扣除', '申请', '购买', nil);
                  sSendMsg := IntToStr(PlayObject.m_nWaitIndex) + '/';
                  sSendMsg := sSendMsg + IntToStr(PlayObject.m_nDBIndex) + '/';
                  sSendMsg := sSendMsg + IntToStr(RM_SHOPGAMEGOLDCHANGE) + '/';
                  sSendMsg := sSendMsg + '1/';
                  sSendMsg := sSendMsg + IntToStr(Pic64) + '/';
                  sSendMsg := sSendMsg + IntToStr(PlayObject.m_nIDIndex) + '/';
                  sSendMsg := sSendMsg + PlayObject.m_sUserID + '/';
                  sSendMsg := sSendMsg + PlayObject.m_sCharName;
                  FrmIDSoc.SendGameGoldChange(sSendMsg);
                  exit;
                end else
                  nBack := -6; //过多超过
              end else
                nBack := -5; //点卷不足
            end else
          end;
        end else
          nBack := -3; //背包空间已满
      end;
    end else
      nBack := -2; //购买的物品已经卖完
  end;
  PlayObject.SendDefMessage(SM_CLIENTBUYSHOPITEM, nBack, 0, 0, nShopCount, '');
end;

procedure TShopEngine.ClientChangeGameGold(PlayObject: TPlayObject; nGoldCount: Integer; boAdd: Boolean);
const
  GOLDMODNAME: array[Boolean] of string[4] = ('扣除', '增加');
var
  sSendMsg: string;
begin
  if PlayObject.m_nWaitIndex = 0 then begin
    PlayObject.m_nWaitIndex := GetWaitMsgID;
    PlayObject.m_nSQLAppendCount := nGoldCount;
    PlayObject.m_nSQLAppendBool := boAdd; //是否扣除
    AddGameLog(PlayObject, LOG_GAMEPOINTCHANGED, sSTRING_GAMEPOINT, PlayObject.m_nWaitIndex, nGoldCount,
      '商铺', GOLDMODNAME[boAdd], '申请', '修改', nil);
    sSendMsg := IntToStr(PlayObject.m_nWaitIndex) + '/';
    sSendMsg := sSendMsg + IntToStr(PlayObject.m_nDBIndex) + '/';
    sSendMsg := sSendMsg + IntToStr(RM_SHOPGETPOINT) + '/';
    if boAdd then sSendMsg := sSendMsg + '0/'
    else sSendMsg := sSendMsg + '1/';
    sSendMsg := sSendMsg + IntToStr(nGoldCount) + '/';
    sSendMsg := sSendMsg + IntToStr(PlayObject.m_nIDIndex) + '/';
    sSendMsg := sSendMsg + PlayObject.m_sUserID + '/';
    sSendMsg := sSendMsg + PlayObject.m_sCharName;
    FrmIDSoc.SendGameGoldChange(sSendMsg);
    exit;
  end;
end;

procedure TShopEngine.ClientGetShopList(PlayObject: TPlayObject; nShowIndex: Integer);
var
  ShopItem: pTShopItem;
  ClientShopItem: TClientShopItem;
  sSendMsg: string;
  DefMsg: TDefaultMessage;
  ClientDateTime: TClientDateTime;
  I: Integer;
begin
  sSendMsg := '';
  if (m_ListIndex <> nShowIndex) then begin
    for I := 0 to m_ShopItemList.Count - 1 do begin
      ShopItem := m_ShopItemList[I];
      //if ShopItem.nCount = 0 then Continue;
      SafeFillChar(ClientShopItem, SizeOf(TClientShopItem), #0);
      ClientShopItem.btIdx := ShopItem.btIdx;
      ClientShopItem.wIdent := ShopItem.wIdent;
      ClientShopItem.nPrict := ShopItem.nPrict;
      ClientShopItem.nGoldPrict := ShopItem.nGoldPrict;
      ClientShopItem.wTime := ShopItem.wTime;
      //ClientShopItem.nIntegral := ShopItem.nIntegral;
      ClientShopItem.btStatus := Shopitem.btStatus;
      ClientShopItem.btAgio := Shopitem.btAgio;
      ClientShopItem.nCount := Shopitem.nCount;
      ClientShopItem.nSellCount := Shopitem.nSellCount;
      //ClientShopItem.boGameGoldBuy := Shopitem.boGameGoldBuy;
      sSendMsg := sSendMsg + IntToStr(I) + '/' + EncodeBuffer(@ClientShopItem, SizeOf(TClientShopItem)) + '/';
    end;
  end;
  ClientDateTime.DateTime := Now;
  DefMsg := MakeDefaultMsg(SM_GETSHOPLIST, ClientDateTime.nInteger, ClientDateTime.wWord1, ClientDateTime.wWord2, m_ListIndex);
  PlayObject.SendSocket(@DefMsg, sSendMsg);
end;

procedure TShopEngine.ClientTradeGameGold(PlayObject: TPlayObject; nTradeCount: Integer);
var
  sSendMsg: string;
begin
  if PlayObject.m_nWaitIndex <> 0 then exit;
  if (nTradeCount > 0) and (PlayObject.m_nGamePoint >= nTradeCount) then begin
    PlayObject.m_nWaitIndex := GetWaitMsgID;
    PlayObject.m_nSQLAppendCount := nTradeCount;
    PlayObject.m_nSQLAppendBool := True; //扣除
    AddGameLog(PlayObject, LOG_GAMEPOINTCHANGED, sSTRING_GAMEPOINT, PlayObject.m_nWaitIndex, nTradeCount,
      '商铺', '扣除', '申请', '对换', nil);
    sSendMsg := IntToStr(PlayObject.m_nWaitIndex) + '/';
    sSendMsg := sSendMsg + IntToStr(PlayObject.m_nDBIndex) + '/';
    sSendMsg := sSendMsg + IntToStr(RM_SHOPGETGAMEPOINT) + '/';
    sSendMsg := sSendMsg + '1/';
    sSendMsg := sSendMsg + IntToStr(nTradeCount) + '/';
    sSendMsg := sSendMsg + IntToStr(PlayObject.m_nIDIndex) + '/';
    sSendMsg := sSendMsg + PlayObject.m_sUserID + '/';
    sSendMsg := sSendMsg + PlayObject.m_sCharName;
    FrmIDSoc.SendGameGoldChange(sSendMsg);
  end else
    PlayObject.SendDefMessage(SM_CLIENTBUYITEM, -2, 0, 0, 0, '');
end;

initialization
begin
  ShopEngine := TShopEngine.Create;
  m_ShopItemList := TList.Create;
end;

finalization
begin
  ShopEngine.Free;
  m_ShopItemList.Free;
end;


end.

