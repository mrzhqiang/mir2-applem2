unit FrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, Grids, ExtCtrls, StdCtrls, DB, DBTables, Share,
  ImgList;

type
  TFormMain = class(TForm)
    Query: TQuery;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    S1: TMenuItem;
    R1: TMenuItem;
    S2: TMenuItem;
    A1: TMenuItem;
    ImageList1: TImageList;
    Panel4: TPanel;
    ProgressBar1: TProgressBar;
    N2: TMenuItem;
    W1: TMenuItem;
    PageControl1: TPageControl;
    TabStdItems: TTabSheet;
    ListView1: TListView;
    TabMagic: TTabSheet;
    ListViewMagic: TListView;
    ID1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure ListView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure S1Click(Sender: TObject);
    procedure W1Click(Sender: TObject);
    procedure ListViewMagicColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewMagicCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure ListViewMagicMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ID1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure RefTabItem();
    procedure RefMagicTabItem();
    //procedure LoadSaveItem();
    //procedure LoadSaveMagic();
    procedure SaveSaveItem();
    procedure SaveSaveMagic();
    procedure ClearSaveItem();
    procedure ClearSaveMagic();
    procedure ClearStdItem();
    procedure ClearMagic();
   // procedure SetStdItem(ClientStditem: pTItemStditem);
    //procedure SetMagic(ClientMagic: pTItemMagic);
    procedure SetStdItemStatus(Title: string);
    procedure SetMagicStatus(Title: string);
    procedure WriteClientItem();
    procedure WriteClientMagic();
  end;

var
  FormMain: TFormMain;
  ColumnToSort: Integer;

implementation
uses
  FrmLogin, Grobal2, HUtil32, EDcode, FrmDesc;

const
  STDITEMSAVENAME = '.\StdItemSave.dat';
  MAGICSAVENAME = '.\MagicSave.dat';
  CLIENTSTDITEMNAME = '.\Goods.dat';
  CLIENTMAGICNAME = '.\Magic.Dat';

{$R *.dfm}

procedure TFormMain.A1Click(Sender: TObject);
var
  i: Integer;
  Item: TListItem;
begin
  if PageControl1.TabIndex = 0 then begin
    boStdItemSelect := not boStdItemSelect;
    for i := 0 to ListView1.Items.Count - 1 do begin
      Item := ListView1.Items[i];
      Item.Selected := boStdItemSelect;
    end;
  end
  else begin
    boMagicSelect := not boMagicSelect;
    for i := 0 to ListViewMagic.Items.Count - 1 do begin
      Item := ListViewMagic.Items[i];
      Item.Selected := boMagicSelect;
    end;
  end;
end;

procedure TFormMain.ClearSaveItem;
var
  i: Integer;
begin
  for i := 0 to SaveList.Count - 1 do begin
    Dispose(pTGoodsStditem(SaveList[i]));
  end;
  SaveList.Clear;
end;

procedure TFormMain.ClearSaveMagic;
var
  i: Integer;
begin
  for i := 0 to SaveMagicList.Count - 1 do begin
    Dispose(pTGoodsMagic(SaveMagicList[i]));
  end;
  SaveMagicList.Clear;
end;

procedure TFormMain.ClearStdItem;
var
  i: Integer;
begin
  for i := 0 to DBList.Count - 1 do begin
    Dispose(pTItemStditem(DBList[i]));
  end;
  DBList.Clear;
end;

procedure TFormMain.ClearMagic();
var
  i: Integer;
begin
  for i := 0 to MagicList.Count - 1 do begin
    Dispose(pTItemMagic(MagicList[i]));
  end;
  MagicList.Clear;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  if boChange then begin
    if Application.MessageBox('上次更改尚未保存,是否现在保存?', '提示信息',
      MB_YESNO + MB_ICONINFORMATION) = IDYES then begin
      SaveSaveItem;
      SaveSaveMagic;
    end;
  end;
  ClearStdItem;
  ClearSaveItem;
  ClearMagic;
  ClearSaveMagic;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  DatabaseList: TStringList;
  I: Integer;
begin
  FormLogin := TFormLogin.Create(Self);
  DatabaseList := TStringList.Create;
  try
    Query.DBSession.GetDatabaseNames(DatabaseList);

    FormLogin.ComboBox.Items.Clear;
    for i := 0 to DatabaseList.Count - 1 do begin
      FormLogin.ComboBox.Items.Add(DatabaseList[i]);
    end;
  finally
    DatabaseList.Free;
  end;
  FormLogin.ShowModal;
  FormLogin.Free;
  if DBNAME = '' then begin
    PostMessage(Handle, WM_CLOSE, 0, 0);
    Exit;
  end;
  PageControl1.TabIndex := 0;
  Query.DatabaseName := DBNAME;
  //LoadSaveItem();
  //LoadSaveMagic;
  RefTabItem;
  RefMagicTabItem;
end;

procedure TFormMain.ID1Click(Sender: TObject);
resourcestring
  sSQLString = 'UPDATE StdItems.DB set Idx=%d where Name=' + '''%s''';
var
//  sFileName: string;
//  FileHandle: Integer;
//  Goods: TGoodsStditem;
  i: Integer;
  ClientStditem: pTItemStditem;
begin
  for i := 0 to DBList.Count - 1 do begin
    ClientStditem := DBList.Items[i];
    Query.SQL.Clear;
    Query.SQL.Add(Format(sSQLString, [i, ClientStditem.StdItem.Name]));
    Query.ExecSQL;
    Query.Close;
    ProgressBar1.Position := Round((i / (DBList.Count - 1)) * 100)
  end;
  //LoadSaveItem();
  //LoadSaveMagic;
  RefTabItem;
  RefMagicTabItem;
end;

procedure TFormMain.ListView1ColumnClick(Sender: TObject; Column: TListColumn);
begin
  if ColumnToSort = Column.Index then
    boStdItemBack := not boStdItemBack;
  ColumnToSort := Column.Index;
  (Sender as TCustomListView).AlphaSort;
end;

procedure TFormMain.ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  ix: Integer;
begin
  if ColumnToSort = 0 then begin
    Compare := CompareStr(Item1.Caption, Item2.Caption);
    if not boStdItemBack then
      Compare := -Compare;
  end
  else begin
    ix := ColumnToSort - 1;
    Compare := CompareStr(Item1.SubItems[ix], Item2.SubItems[ix]);
    if not boStdItemBack then
      Compare := -Compare;
  end;
end;

procedure TFormMain.ListView1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Column: TListColumn;
  i: Integer;
  nLen: Integer;
begin
  if mbRight = Button then begin
    nLen := 0;
    for i := 0 to ListView1.Columns.Count - 1 do begin
      Column := ListView1.Columns.Items[i];
      Inc(nLen, Column.Width);
      if nLen > X then begin
        SetStdItemStatus(Column.Caption);
        Break;
      end;
    end;
  end;
end;

procedure TFormMain.ListViewMagicColumnClick(Sender: TObject; Column: TListColumn);
begin
  if ColumnToSort = Column.Index then
    boMagicBack := not boMagicBack;
  ColumnToSort := Column.Index;
  (Sender as TCustomListView).AlphaSort;
end;

procedure TFormMain.ListViewMagicCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
begin
  if ColumnToSort = 0 then begin
    Compare := CompareStr(Item1.Caption, Item2.Caption);
    if not boMagicBack then
      Compare := -Compare;
  end
  else begin
    ix := ColumnToSort - 1;
    Compare := CompareStr(Item1.SubItems[ix], Item2.SubItems[ix]);
    if not boMagicBack then
      Compare := -Compare;
  end;
end;

procedure TFormMain.ListViewMagicMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Column: TListColumn;
  i: Integer;
  nLen: Integer;
begin
  if mbRight = Button then begin
    nLen := 0;
    for i := 0 to ListViewMagic.Columns.Count - 1 do begin
      Column := ListViewMagic.Columns.Items[i];
      Inc(nLen, Column.Width);
      if nLen > X then begin
        SetMagicStatus(Column.Caption);
        Break;
      end;
    end;
  end;
end;
  {
procedure TFormMain.LoadSaveItem;
var
  sFileName: string;
  FileHandle: Integer;
  Goods: TGoodsStditem;
  GoodsStditem: pTGoodsStditem;
begin
  sFileName := STDITEMSAVENAME;
  ClearSaveItem;
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    try
      while FileRead(FileHandle, Goods, SizeOf(Goods)) = SizeOf(Goods) do begin
        New(GoodsStditem);
        GoodsStditem^ := Goods;
        SaveList.Add(GoodsStditem);
      end;
    finally
      FileClose(FileHandle);
    end;
  end;
end;      }
  {
procedure TFormMain.LoadSaveMagic;
var
  sFileName: string;
  FileHandle: Integer;
  Magic: TGoodsMagic;
  GoodsMagic: pTGoodsMagic;
begin
  sFileName := MAGICSAVENAME;
  ClearSaveMagic;
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    try
      while FileRead(FileHandle, Magic, SizeOf(Magic)) = SizeOf(Magic) do begin
        New(GoodsMagic);
        GoodsMagic^ := Magic;
        SaveMagicList.Add(GoodsMagic);
      end;
    finally
      FileClose(FileHandle);
    end;
  end;
end;    }

procedure TFormMain.S1Click(Sender: TObject);
begin
  SaveSaveItem();
  SaveSaveMagic;
  Application.MessageBox('保存完成!', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TFormMain.SaveSaveItem();
resourcestring
  sSQLString = 'UPDATE StdItems.DB set Bind=%d, Text=''%s'' where Idx=%d';
var
  {sFileName: string;
  FileHandle: Integer;
  Goods: TGoodsStditem;   }
  i: Integer;
  ClientStditem: pTItemStditem;
begin
  {sFileName := STDITEMSAVENAME;
  if FileExists(sFileName) then begin
    CopyFile(PChar(sFileName), PChar(sFileName + '.bak'), False);
    DeleteFile(sFileName);
  end;
  FileHandle := FileCreate(sFileName);  }
  try
    for i := 0 to DBList.Count - 1 do begin
      //FillChar(Goods, SizeOf(Goods), #0);
      ClientStditem := DBList.Items[i];
      {Goods.sItemname := ClientStditem.StdItem.Name;
      Goods.Filtrate := ClientStditem.Filtrate;
      Goods.sDesc := ClientStditem.sDesc;
      Goods.isshow := ClientStditem.isshow;
      FileWrite(FileHandle, Goods, SizeOf(Goods)); }
      if ClientStditem.boChange then begin
        Query.SQL.Clear;
        Query.SQL.Add(Format(sSQLString, [ClientStditem.Bind, ClientStditem.sDesc, ClientStditem.StdItem.Idx]));
        Query.ExecSQL;
        Query.Close;
        ClientStditem.boChange := False;
      end;
      ProgressBar1.Position := Round((i / (DBList.Count - 1)) * 100)
    end;
  finally
    //FileClose(FileHandle);
  end;
  boChange := False;
end;

procedure TFormMain.SaveSaveMagic;
resourcestring
  sSQLString = 'UPDATE Magic.DB set Bind=%d, Text=''%s'' where MagName=''%s''';
{var
  sFileName: string;
  FileHandle: Integer;
  Magic: TGoodsMagic;
  i: Integer;
  ClientMagic: pTItemMagic;    }
var
  ClientMagic: pTItemMagic;
  I: integer;
begin
  for i := 0 to MagicList.Count - 1 do begin
    ClientMagic := MagicList.Items[i];
    if ClientMagic.boChange then begin
      Query.SQL.Clear;
      Query.SQL.Add(Format(sSQLString, [Integer(ClientMagic.isshow), ClientMagic.sDesc, ClientMagic.Magic.sMagicName]));
      Query.ExecSQL;
      Query.Close;
      ClientMagic.boChange := False;
    end;
    ProgressBar1.Position := Round((i / (MagicList.Count - 1)) * 100);
  end;
  {sFileName := MAGICSAVENAME;
  if FileExists(sFileName) then begin
    CopyFile(PChar(sFileName), PChar(sFileName + '.bak'), False);
    DeleteFile(sFileName);
  end;
  FileHandle := FileCreate(sFileName);  }
  //try
    {for i := 0 to MagicList.Count - 1 do begin
      FillChar(Magic, SizeOf(Magic), #0);
      ClientMagic := MagicList.Items[i];
      Magic.sMagID := ClientMagic.Magic.wMagicId;
      Magic.sDesc := ClientMagic.sDesc;
      Magic.isshow := ClientMagic.isshow;
      FileWrite(FileHandle, Magic, SizeOf(Magic));
      ProgressBar1.Position := Round((i / (MagicList.Count - 1)) * 100)
    end; }
  {finally
    FileClose(FileHandle);
  end; }
  boChange := False;
end;

procedure TFormMain.W1Click(Sender: TObject);
begin
  //WriteClientItem;
  //WriteClientMagic;
  Application.MessageBox('生成客户端文件成功!', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TFormMain.WriteClientItem;
{var
  ClientStditem: TClientStditem;
  ItemStditem: pTItemStditem;
  sFileName: string;
  FileHandle: Integer;
  i: Integer;
  str: string;
  Buff: PChar;  }
begin
  {sFileName := CLIENTSTDITEMNAME;
  if FileExists(sFileName) then
    DeleteFile(sFileName);

  FileHandle := FileCreate(sFileName);
  try
    GetMem(Buff, GetCodeMsgSize((SizeOf(TClientStditem) - 256) * 4 / 3));
    for i := 0 to DBList.Count - 1 do begin
      FillChar(ClientStditem, SizeOf(TClientStditem), #0);
      ItemStditem := DBList.Items[i];
      ClientStditem.StdItem := ItemStditem.StdItem;
      ClientStditem.Filtrate := ItemStditem.Filtrate;
      ClientStditem.isshow := ItemStditem.isshow;
      Move(ItemStditem.sDesc[0], ClientStditem.StdItem.NeedIdentify, 1);
      str := EncodeBuffer(@ClientStditem, SizeOf(TClientStditem) - 256);
      Move(str[1], Buff^, Length(str));
      FileWrite(FileHandle, Buff^, Length(str));
      if ClientStditem.StdItem.NeedIdentify > 0 then begin
        str := EncodeString(ItemStditem.sDesc);
        FileWrite(FileHandle, str[1], Length(str));
      end;
      ProgressBar1.Position := Round((i / (DBList.Count - 1)) * 100);
      //Break;
    end;
    FreeMem(Buff);
  finally
    FileClose(FileHandle);
  end;    }
end;

procedure TFormMain.WriteClientMagic;
var
  ClientMagic: TClientDefMagic;
  ItemMagic: pTItemMagic;
  sFileName: string;
  FileHandle: Integer;
  i, nLen: Integer;
  str: string;
  Buff: PChar;
begin
  sFileName := CLIENTMAGICNAME;
  if FileExists(sFileName) then
    DeleteFile(sFileName);

  FileHandle := FileCreate(sFileName);
  try
    GetMem(Buff, GetCodeMsgSize((SizeOf(TClientDefMagic) - 256) * 4 / 3));
    for i := 0 to MagicList.Count - 1 do begin
      FillChar(ClientMagic, SizeOf(TClientDefMagic), #0);
      ItemMagic := MagicList.Items[i];
      ClientMagic.Magic := ItemMagic.Magic;
      ClientMagic.isshow := ItemMagic.isshow;
      Move(ItemMagic.sDesc[0], ClientMagic.Magic.MagicMode, 1);
      str := EncodeBuffer(@ClientMagic, SizeOf(TClientDefMagic) - 256);
      Move(str[1], Buff^, Length(str));
      FileWrite(FileHandle, Buff^, Length(str));
      nLen := Byte(ClientMagic.Magic.MagicMode);
      if nLen > 0 then begin
        str := EncodeString(ItemMagic.sDesc);
        FileWrite(FileHandle, str[1], Length(str));
      end;
      ProgressBar1.Position := Round((i / (MagicList.Count - 1)) * 100);
      //Break;
    end;
    FreeMem(Buff);
  finally
    FileClose(FileHandle);
  end;
end;

procedure TFormMain.R1Click(Sender: TObject);
begin
  if Application.MessageBox('是否确定重新加载配置信息?', '提示信息', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
    //LoadSaveItem();
    //LoadSaveMagic;
    RefTabItem;
    RefMagicTabItem;
    boChange := False;
  end;
end;

procedure TFormMain.RefMagicTabItem;
resourcestring
  sSQLString = 'select * from Magic.DB';
var
  ItemMagic: pTItemMagic;
  i: integer;
  Item: TListItem;
begin
  ListViewMagic.Visible := False;
  ListViewMagic.Items.Clear;
  ClearMagic;
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try

    Query.Open;
    for I := 0 to Query.RecordCount - 1 do begin
      New(ItemMagic);
      FillChar(ItemMagic^, SizeOf(TItemMagic), #0);
      ItemMagic.Magic.wMagicId := Query.FieldByName('MagId').AsInteger;
      ItemMagic.Magic.wCopy := Query.FieldByName('Copy').AsInteger;
      ItemMagic.Magic.sMagicName := Query.FieldByName('MagName').AsString;
      ItemMagic.Magic.wMagicIcon := Query.FieldByName('MagicIcon').AsInteger;
      ItemMagic.Magic.btEffectType := Query.FieldByName('EffectType').AsInteger;
      ItemMagic.Magic.btEffect := Query.FieldByName('Effect').AsInteger;
      ItemMagic.Magic.wSpell := Query.FieldByName('Spell').AsInteger;
      ItemMagic.Magic.btDefSpell := Query.FieldByName('DefSpell').AsInteger;
      ItemMagic.Magic.wPower := Query.FieldByName('Power').AsInteger;
      ItemMagic.Magic.wMaxPower := Query.FieldByName('MaxPower').AsInteger;
      ItemMagic.Magic.btJob := Query.FieldByName('Job').AsInteger;
      ItemMagic.Magic.TrainLevel[0] := Query.FieldByName('NeedL1').AsInteger;
      ItemMagic.Magic.TrainLevel[1] := Query.FieldByName('NeedL2').AsInteger;
      ItemMagic.Magic.TrainLevel[2] := Query.FieldByName('NeedL3').AsInteger;
      ItemMagic.Magic.TrainLevel[3] := Query.FieldByName('NeedL3').AsInteger;
      ItemMagic.Magic.MaxTrain[0] := Query.FieldByName('L1Train').AsInteger;
      ItemMagic.Magic.MaxTrain[1] := Query.FieldByName('L2Train').AsInteger;
      ItemMagic.Magic.MaxTrain[2] := Query.FieldByName('L3Train').AsInteger;
      ItemMagic.Magic.TrainLevel[3] := Query.FieldByName('NeedL4').AsInteger;
      ItemMagic.Magic.TrainLevel[4] := Query.FieldByName('NeedL5').AsInteger;
      ItemMagic.Magic.TrainLevel[5] := Query.FieldByName('NeedL6').AsInteger;
      ItemMagic.Magic.TrainLevel[6] := Query.FieldByName('NeedL7').AsInteger;
      ItemMagic.Magic.TrainLevel[7] := Query.FieldByName('NeedL8').AsInteger;
      ItemMagic.Magic.TrainLevel[8] := Query.FieldByName('NeedL9').AsInteger;
      ItemMagic.Magic.TrainLevel[9] := Query.FieldByName('NeedL10').AsInteger;
      ItemMagic.Magic.TrainLevel[10] := Query.FieldByName('NeedL11').AsInteger;
      ItemMagic.Magic.TrainLevel[11] := Query.FieldByName('NeedL12').AsInteger;
      ItemMagic.Magic.TrainLevel[12] := Query.FieldByName('NeedL13').AsInteger;
      ItemMagic.Magic.TrainLevel[13] := Query.FieldByName('NeedL14').AsInteger;
      ItemMagic.Magic.TrainLevel[14] := Query.FieldByName('NeedL15').AsInteger;
      ItemMagic.Magic.TrainLevel[15] := Query.FieldByName('NeedL16').AsInteger;
      ItemMagic.Magic.TrainLevel[16] := Query.FieldByName('NeedL17').AsInteger;
      ItemMagic.Magic.TrainLevel[17] := Query.FieldByName('NeedL18').AsInteger;
      ItemMagic.Magic.TrainLevel[18] := Query.FieldByName('NeedL19').AsInteger;
      ItemMagic.Magic.TrainLevel[19] := Query.FieldByName('NeedL19').AsInteger;
      ItemMagic.Magic.MaxTrain[0] := Query.FieldByName('L1Train').AsInteger;
      ItemMagic.Magic.MaxTrain[1] := Query.FieldByName('L2Train').AsInteger;
      ItemMagic.Magic.MaxTrain[2] := Query.FieldByName('L3Train').AsInteger;
      ItemMagic.Magic.MaxTrain[3] := Query.FieldByName('L4Train').AsInteger;
      ItemMagic.Magic.MaxTrain[4] := Query.FieldByName('L5Train').AsInteger;
      ItemMagic.Magic.MaxTrain[5] := Query.FieldByName('L6Train').AsInteger;
      ItemMagic.Magic.MaxTrain[6] := Query.FieldByName('L7Train').AsInteger;
      ItemMagic.Magic.MaxTrain[7] := Query.FieldByName('L8Train').AsInteger;
      ItemMagic.Magic.MaxTrain[8] := Query.FieldByName('L9Train').AsInteger;
      ItemMagic.Magic.MaxTrain[9] := Query.FieldByName('L10Train').AsInteger;
      ItemMagic.Magic.MaxTrain[10] := Query.FieldByName('L11Train').AsInteger;
      ItemMagic.Magic.MaxTrain[11] := Query.FieldByName('L12Train').AsInteger;
      ItemMagic.Magic.MaxTrain[12] := Query.FieldByName('L13Train').AsInteger;
      ItemMagic.Magic.MaxTrain[13] := Query.FieldByName('L14Train').AsInteger;
      ItemMagic.Magic.MaxTrain[14] := Query.FieldByName('L15Train').AsInteger;
      ItemMagic.Magic.MaxTrain[15] := Query.FieldByName('L16Train').AsInteger;
      ItemMagic.Magic.MaxTrain[16] := Query.FieldByName('L17Train').AsInteger;
      ItemMagic.Magic.MaxTrain[17] := Query.FieldByName('L18Train').AsInteger;
      ItemMagic.Magic.MaxTrain[18] := Query.FieldByName('L19Train').AsInteger;
      ItemMagic.Magic.MaxTrain[19] := Query.FieldByName('L19Train').AsInteger;
      ItemMagic.Magic.btTrainLv := Query.FieldByName('NeedMax').AsInteger;
      ItemMagic.Magic.dwDelayTime := Query.FieldByName('Delay').AsInteger;
      ItemMagic.Magic.btDefPower := Query.FieldByName('DefPower').AsInteger;
      ItemMagic.Magic.btDefMaxPower := Query.FieldByName('DefMaxPower').AsInteger;
      ItemMagic.Magic.nInterval := Query.FieldByName('Interval').AsInteger;
      ItemMagic.Magic.nSpellFrame := Query.FieldByName('SpellFrame').AsInteger;
      ItemMagic.sDesc := Query.FieldByName('Text').AsString;
      ItemMagic.isshow := Query.FieldByName('Bind').AsInteger <> 0;
      if ItemMagic.Magic.wMagicId > 0 then begin
        MagicList.Add(ItemMagic);
        ItemMagic.boChange := False;
        //SetMagic(ItemMagic);
        Item := ListViewMagic.Items.Add;
        Item.Caption := Format('%.3d', [ItemMagic.Magic.wMagicId]);
        Item.SubItems.AddObject(ItemMagic.Magic.sMagicName, TObject(ItemMagic));
        if ItemMagic.isshow then
          Item.SubItems.Add('√')
        else
          Item.SubItems.Add(' ');
        Item.SubItems.Add(IntToStr(ItemMagic.Magic.btJob));
        Item.SubItems.Add(IntToStr(ItemMagic.Magic.dwDelayTime));
        Item.SubItems.Add(IntToStr(ItemMagic.Magic.nInterval));
        Item.SubItems.Add(ItemMagic.sDesc);
        ItemMagic.Item := Item;
        ItemMagic.boChange := False;
      end
      else begin
        DisPose(ItemMagic);
      end;
      Query.Next;
      ProgressBar1.Position := Round((i / (Query.RecordCount - 1)) * 100)
    end;
  finally
    Query.Close;
  end;
  ListViewMagic.Visible := True;
end;

procedure TFormMain.RefTabItem;
resourcestring
  sSQLString = 'select * from StdItems.DB';
var
  i, ii: Integer;
  ClientStditem: pTItemStditem;
  StdItem: pTStdItem;
  Item: TListItem;
begin
  ListView1.Visible := False;
  ListView1.Items.Clear;
  ClearStdItem;
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.Open;
    for I := 0 to Query.RecordCount - 1 do begin
      New(ClientStditem);
      FillChar(ClientStditem^, SizeOf(TItemStditem), #0);
      StdItem := @ClientStditem.StdItem;
      StdItem.Idx := Query.FieldByName('Idx').AsInteger;
      StdItem.Name := Query.FieldByName('Name').AsString;
      StdItem.StdMode2 := Query.FieldByName('StdMode').AsInteger;
      StdItem.Shape := Query.FieldByName('Shape').AsInteger;
      StdItem.Weight := Query.FieldByName('Weight').AsInteger;
      StdItem.AniCount := Query.FieldByName('AniCount').AsInteger;
      StdItem.Source := Query.FieldByName('Source').AsInteger;
      StdItem.Reserved := Query.FieldByName('Reserved').AsInteger;
      StdItem.Looks := Query.FieldByName('Looks').AsInteger;
      StdItem.Effect := Query.FieldByName('Effect').AsInteger;
      StdItem.DuraMax := Query.FieldByName('DuraMax').AsInteger;
      StdItem.nAC := Query.FieldByName('AC').AsInteger;
      StdItem.nAC2 := Query.FieldByName('AC2').AsInteger;
      StdItem.nMAC := Query.FieldByName('MAC').AsInteger;
      StdItem.nMAC2 := Query.FieldByName('MAC2').AsInteger;
      StdItem.nDC := Query.FieldByName('DC').AsInteger;
      StdItem.nDC2 := Query.FieldByName('DC2').AsInteger;
      StdItem.nMC := Query.FieldByName('MC').AsInteger;
      StdItem.nMC2 := Query.FieldByName('MC2').AsInteger;
      StdItem.nSC := Query.FieldByName('SC').AsInteger;
      StdItem.nSC2 := Query.FieldByName('SC2').AsInteger;
      StdItem.HP := Query.FieldByName('HP').AsInteger;
      StdItem.MP := Query.FieldByName('MP').AsInteger;
      StdItem.AddAttack := Query.FieldByName('AddDamage').AsInteger;
      StdItem.DelDamage := Query.FieldByName('DelDamage').AsInteger;
      StdItem.HitPoint := Query.FieldByName('HitPoint').AsInteger;
      StdItem.SpeedPoint := Query.FieldByName('SpeedPoint').AsInteger;
      StdItem.Strong := Query.FieldByName('Strong').AsInteger;
      StdItem.Luck := Query.FieldByName('Luck').AsInteger;
      StdItem.HitSpeed := Query.FieldByName('HitSpeed').AsInteger;
      StdItem.AntiMagic := Query.FieldByName('AntiMagic').AsInteger;
      StdItem.PoisonMagic := Query.FieldByName('PoisonMagic').AsInteger;
      StdItem.HealthRecover := Query.FieldByName('HealthRecover').AsInteger;
      StdItem.SpellRecover := Query.FieldByName('SpellRecover').AsInteger;
      StdItem.PoisonRecover := Query.FieldByName('PoisonRecover').AsInteger;
      ClientStditem.Bind := Query.FieldByName('Bind').AsInteger;

      StdItem.AddWuXinAttack := 0;
      StdItem.DelWuXinAttack := 0;
      StdItem.Need := Query.FieldByName('Need').AsInteger;
      StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;
      StdItem.Price := Query.FieldByName('Price').AsInteger;
      ClientStditem.sDesc := Query.FieldByName('Text').AsString;
      if sm_Superposition in StdItem.StdModeEx then
        if StdItem.DuraMax < 1 then
          StdItem.DuraMax := 1;
      //StdItem.NeedIdentify := GetGameLogItemNameList(StdItem.Name);
      ClientStditem.boChange := False;
      DBList.Add(ClientStditem);
      //SetStdItem(ClientStditem);
      Item := ListView1.Items.Add;
      Item.Caption := Format('%.4d', [StdItem.Idx]);
      Item.SubItems.AddObject(StdItem.Name, TObject(ClientStditem));
      if CheckIntStatus(ClientStditem.Bind, II_Publicity) then
        Item.SubItems.Add('√')
      else
        Item.SubItems.Add(' ');
      for ii := 0 to 7 do begin
        if CheckIntStatus(ClientStditem.Bind, ii) then begin
          Item.SubItems.Add('√');
        end else begin
          Item.SubItems.Add(' ');
        end;
      end;
      if CheckIntStatus(ClientStditem.Bind, II_Show) then
        Item.SubItems.Add('√')
      else
        Item.SubItems.Add(' ');
      if CheckIntStatus(ClientStditem.Bind, II_PickUp) then
        Item.SubItems.Add('√')
      else
        Item.SubItems.Add(' ');
      if CheckIntStatus(ClientStditem.Bind, II_Color) then
        Item.SubItems.Add('√')
      else
        Item.SubItems.Add(' ');
      if CheckIntStatus(ClientStditem.Bind, II_Hint) then
        Item.SubItems.Add('√')
      else
        Item.SubItems.Add(' ');
      Item.SubItems.Add(ClientStditem.sDesc);
      ClientStditem.Item := Item;
      Query.Next;
      ProgressBar1.Position := Round((i / (Query.RecordCount - 1)) * 100)
    end;
  finally
    Query.Close;
  end;
  ListView1.Visible := True;
end;
   {
procedure TFormMain.SetMagic(ClientMagic: pTItemMagic);
var
  i: Integer;
  GoodsMagic: pTGoodsMagic;
begin
  for i := 0 to SaveMagicList.Count - 1 do begin
    GoodsMagic := SaveMagicList[i];
    if GoodsMagic.sMagID = ClientMagic.Magic.wMagicId then begin
      ClientMagic.sDesc := GoodsMagic.sDesc;
      ClientMagic.isshow := GoodsMagic.isshow;
      Break;
    end;
  end;
end;   }
   {
procedure TFormMain.SetStdItem(ClientStditem: pTItemStditem);
var
  i: Integer;
  GoodsStditem: pTGoodsStditem;
begin
  for i := 0 to SaveList.Count - 1 do begin
    GoodsStditem := SaveList[i];
    if GoodsStditem.sItemname = ClientStditem.StdItem.Name then begin
      ClientStditem.Filtrate := Goodsstditem.Filtrate;
      ClientStditem.sDesc := Goodsstditem.sDesc;
      ClientStditem.isshow := GoodsStditem.isshow;
      Break;
    end;
  end;
end;  }

procedure TFormMain.SetMagicStatus(Title: string);
var
  i: Integer;
  ItemStditem: pTItemMagic;
  boOne: Boolean;
  bool: Boolean;
  str: string;
begin
  if (Title <> '公开') and (Title <> '备注') then
    exit;

  boOne := True;
  bool := False;
  boChange := True;
  str := '';
  for i := 0 to MagicList.Count - 1 do begin
    ItemStditem := MagicList.Items[i];
    if ItemStditem.Item.Selected then begin
      if Title = '公开' then begin
        if boOne then begin
          if ItemStditem.isshow then begin
            ItemStditem.isshow := False;
            ItemStditem.Item.SubItems[1] := ' ';
          end
          else begin
            ItemStditem.isshow := True;
            ItemStditem.Item.SubItems[1] := '√';
          end;
          ItemStditem.boChange := True;
          bool := ItemStditem.isshow;
          boOne := False;
        end
        else begin
          if not bool then begin
            ItemStditem.isshow := False;
            ItemStditem.Item.SubItems[1] := ' ';
          end
          else begin
            ItemStditem.isshow := True;
            ItemStditem.Item.SubItems[1] := '√';
          end;
          ItemStditem.boChange := True;
        end;
      end
      else if Title = '备注' then begin
        if boOne then begin
          DescStr := ItemStditem.sDesc;
          FormDesc.Memo1.Lines.SetText(PChar(DescStr));
          if FormDesc.ShowModal <> mrOk then
            Break;
          ItemStditem.sDesc := DescStr;
          ItemStditem.Item.SubItems[5] := DescStr;
          ItemStditem.boChange := True;
          str := DescStr;
          boOne := False;
        end
        else begin
          ItemStditem.boChange := True;
          ItemStditem.sDesc := str;
          ItemStditem.Item.SubItems[5] := str;
        end;
      end
    end;
  end;
end;

procedure TFormMain.SetStdItemStatus(Title: string);
var
  i: Integer;
  ItemStditem: pTItemStditem;
  boOne: Boolean;
  bool: Boolean;
  bttype: byte;
  nIndex: Integer;
  str: string;
begin
  boOne := True;
  bool := False;
  bttype := 0;
  nIndex := 0;
  boChange := True;
  str := '';
  for i := 0 to DBList.Count - 1 do begin
    ItemStditem := DBList.Items[i];
    if ItemStditem.Item.Selected then begin
      {if Title = '公开' then begin
        if boOne then begin
          if ItemStditem.isshow then begin
            ItemStditem.isshow := False;
            ItemStditem.Item.SubItems[1] := ' ';
          end
          else begin
            ItemStditem.isshow := True;
            ItemStditem.Item.SubItems[1] := '√';
          end;
          bool := ItemStditem.isshow;
          boOne := False;
        end
        else begin
          if not bool then begin
            ItemStditem.isshow := False;
            ItemStditem.Item.SubItems[1] := ' ';
          end
          else begin
            ItemStditem.isshow := True;
            ItemStditem.Item.SubItems[1] := '√';
          end;
        end;
      end
      else if Title = '显' then begin
        if boOne then begin
          ItemStditem.Filtrate.boShow := not ItemStditem.Filtrate.boShow;
          if ItemStditem.Filtrate.boShow then begin
            ItemStditem.Item.SubItems[10] := '√';
            bool := True;
          end
          else begin
            ItemStditem.Item.SubItems[10] := ' ';
            bool := False;
          end;
          boOne := False;
        end
        else begin
          ItemStditem.Filtrate.boShow := bool;
          if ItemStditem.Filtrate.boShow then begin
            ItemStditem.Item.SubItems[10] := '√';
          end
          else begin
            ItemStditem.Item.SubItems[10] := ' ';
          end;
        end;
      end
      else if Title = '捡' then begin
        if boOne then begin
          ItemStditem.Filtrate.boPickUp := not ItemStditem.Filtrate.boPickUp;
          if ItemStditem.Filtrate.boPickUp then begin
            ItemStditem.Item.SubItems[11] := '√';
            bool := True;
          end
          else begin
            ItemStditem.Item.SubItems[11] := ' ';
            bool := False;
          end;
          boOne := False;
        end
        else begin
          ItemStditem.Filtrate.boPickUp := bool;
          if ItemStditem.Filtrate.boPickUp then begin
            ItemStditem.Item.SubItems[11] := '√';
          end
          else begin
            ItemStditem.Item.SubItems[11] := ' ';
          end;
        end;
      end
      else if Title = '特' then begin
        if boOne then begin
          ItemStditem.Filtrate.boColor := not ItemStditem.Filtrate.boColor;
          if ItemStditem.Filtrate.boColor then begin
            ItemStditem.Item.SubItems[12] := '√';
            bool := True;
          end
          else begin
            ItemStditem.Item.SubItems[12] := ' ';
            bool := False;
          end;
          boOne := False;
        end
        else begin
          ItemStditem.Filtrate.boColor := bool;
          if ItemStditem.Filtrate.boColor then begin
            ItemStditem.Item.SubItems[12] := '√';
          end
          else begin
            ItemStditem.Item.SubItems[12] := ' ';
          end;
        end;
      end
      else if Title = '提' then begin
        if boOne then begin
          ItemStditem.Filtrate.boHint := not ItemStditem.Filtrate.boHint;
          if ItemStditem.Filtrate.boHint then begin
            ItemStditem.Item.SubItems[13] := '√';
            bool := True;
          end
          else begin
            ItemStditem.Item.SubItems[13] := ' ';
            bool := False;
          end;
          boOne := False;
        end
        else begin
          ItemStditem.Filtrate.boHint := bool;
          if ItemStditem.Filtrate.boHint then begin
            ItemStditem.Item.SubItems[13] := '√';
          end
          else begin
            ItemStditem.Item.SubItems[13] := ' ';
          end;
        end;
      end
      else}
      if Title = '备注' then begin
        if boOne then begin
          DescStr := ItemStditem.sDesc;
          FormDesc.Memo1.Lines.SetText(PChar(DescStr));
          if FormDesc.ShowModal <> mrOk then
            Break;
          if ItemStditem.sDesc <> DescStr then
            ItemStditem.boChange := True;
          ItemStditem.sDesc := DescStr;
          ItemStditem.Item.SubItems[14] := DescStr;
          str := DescStr;
          boOne := False;
        end
        else begin
          ItemStditem.sDesc := str;
          ItemStditem.Item.SubItems[14] := str;
        end;
      end
      else begin
        if Title = '公开' then begin
          bttype := II_Publicity;
          nIndex := 1;
        end else
        if Title = '交易' then begin
          bttype := Ib_NoDeal;
          nIndex := 2;
        end
        else if Title = '存仓' then begin
          bttype := Ib_NoSave;
          nIndex := 3;
        end
        else if Title = '修理' then begin
          bttype := Ib_NoRepair;
          nIndex := 4;
        end
        else if Title = '丢弃' then begin
          bttype := Ib_NoDrop;
          nIndex := 5;
        end
        else if Title = '掉落' then begin
          bttype := Ib_NoDown;
          nIndex := 6;
        end
        else if Title = '打造' then begin
          bttype := Ib_NoMake;
          nIndex := 7;
        end
        else if Title = '出售' then begin
          bttype := Ib_NoSell;
          nIndex := 8;
        end
        else if Title = '消失' then begin
          bttype := Ib_DropDestroy;
          nIndex := 9;
        end
        else if Title = '显' then begin
          bttype := II_Show;
          nIndex := 10;
        end
        else if Title = '捡' then begin
          bttype := II_PickUp;
          nIndex := 11;
        end
        else if Title = '特' then begin
          bttype := II_Color;
          nIndex := 12;
        end
        else if Title = '提' then begin
          bttype := II_Hint;
          nIndex := 13;
        end
        else
          Break;
        if boOne then begin
          if CheckIntStatus(ItemStditem.Bind, bttype) then begin
            SetIntStatus(ItemStditem.Bind, bttype, False);
            ItemStditem.Item.SubItems[nIndex] := ' ';
            bool := False;
          end
          else begin
            SetIntStatus(ItemStditem.Bind, bttype, True);
            ItemStditem.Item.SubItems[nIndex] := '√';
            bool := True;
          end;
          boOne := False;
        end
        else begin
          SetIntStatus(ItemStditem.Bind, bttype, bool);
          if bool then begin
            ItemStditem.Item.SubItems[nIndex] := '√';
          end
          else begin
            ItemStditem.Item.SubItems[nIndex] := ' ';
          end;
        end;
        ItemStditem.boChange := True;
      end;
    end;
  end;

end;

end.

