unit GMain;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, INIFiles, ExtCtrls, SEShare, GShare,
  Spin, JSocket, RzSpnEdt, Mask, RzEdit, RzBtnEdt, ShlObj, ActiveX, ShellApi,
  VCLUnZip, VCLZip, Common, Menus;

type
  TfrmMain = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditGameDir: TEdit;
    Label2: TLabel;
    EditHeroDB: TEdit;
    ButtonNext1: TButton;
    ButtonNext2: TButton;
    GroupBox2: TGroupBox;
    ButtonPrv2: TButton;
    EditGameName: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EditGameExtIPaddr: TEdit;
    GroupBox5: TGroupBox;
    ButtonStartGame: TButton;
    CheckBoxM2Server: TCheckBox;
    CheckBoxDBServer: TCheckBox;
    CheckBoxLoginServer: TCheckBox;
    CheckBoxLogServer: TCheckBox;
    CheckBoxSelGate1: TCheckBox;
    CheckBoxRunGate: TCheckBox;
    CheckBoxRunGate1: TCheckBox;
    CheckBoxRunGate2: TCheckBox;
    TimerStartGame: TTimer;
    TimerStopGame: TTimer;
    TimerCheckRun: TTimer;
    MemoLog: TMemo;
    ButtonReLoadConfig: TButton;
    GroupBox7: TGroupBox;
    Label9: TLabel;
    EditLoginGate_MainFormX: TSpinEdit;
    Label10: TLabel;
    EditLoginGate_MainFormY: TSpinEdit;
    GroupBox3: TGroupBox;
    GroupBox8: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    EditSelGate_MainFormX: TSpinEdit;
    EditSelGate_MainFormY: TSpinEdit;
    TabSheet7: TTabSheet;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    EditLoginServer_MainFormX: TSpinEdit;
    EditLoginServer_MainFormY: TSpinEdit;
    TabSheet8: TTabSheet;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    EditDBServer_MainFormX: TSpinEdit;
    EditDBServer_MainFormY: TSpinEdit;
    TabSheet9: TTabSheet;
    GroupBox13: TGroupBox;
    GroupBox14: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    EditLogServer_MainFormX: TSpinEdit;
    EditLogServer_MainFormY: TSpinEdit;
    TabSheet10: TTabSheet;
    GroupBox15: TGroupBox;
    GroupBox16: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    EditM2Server_MainFormX: TSpinEdit;
    EditM2Server_MainFormY: TSpinEdit;
    TabSheet11: TTabSheet;
    ButtonSave: TButton;
    ButtonGenGameConfig: TButton;
    ButtonPrv3: TButton;
    ButtonNext3: TButton;
    TabSheet12: TTabSheet;
    ButtonPrv4: TButton;
    ButtonNext4: TButton;
    ButtonPrv5: TButton;
    ButtonNext5: TButton;
    ButtonPrv6: TButton;
    ButtonNext6: TButton;
    ButtonPrv7: TButton;
    ButtonNext7: TButton;
    ButtonPrv8: TButton;
    ButtonNext8: TButton;
    ButtonPrv9: TButton;
    GroupBox17: TGroupBox;
    GroupBox18: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    EditRunGate_MainFormX: TSpinEdit;
    EditRunGate_MainFormY: TSpinEdit;
    GroupBox19: TGroupBox;
    Label23: TLabel;
    Timer: TTimer;
    GroupBox22: TGroupBox;
    LabelRunGate_GatePort1: TLabel;
    EditRunGate_GatePort1: TEdit;
    LabelLabelRunGate_GatePort2: TLabel;
    EditRunGate_GatePort2: TEdit;
    LabelRunGate_GatePort3: TLabel;
    EditRunGate_GatePort3: TEdit;
    LabelRunGate_GatePort4: TLabel;
    EditRunGate_GatePort4: TEdit;
    LabelRunGate_GatePort5: TLabel;
    EditRunGate_GatePort5: TEdit;
    LabelRunGate_GatePort6: TLabel;
    EditRunGate_GatePort6: TEdit;
    LabelRunGate_GatePort7: TLabel;
    EditRunGate_GatePort7: TEdit;
    EditRunGate_GatePort8: TEdit;
    LabelRunGate_GatePort78: TLabel;
    ButtonRunGateDefault: TButton;
    ButtonSelGateDefault: TButton;
    ButtonGeneralDefalult: TButton;
    ButtonLoginGateDefault: TButton;
    ButtonLoginSrvDefault: TButton;
    ButtonDBServerDefault: TButton;
    ButtonLogServerDefault: TButton;
    ButtonM2ServerDefault: TButton;
    GroupBox23: TGroupBox;
    Label28: TLabel;
    EditLoginGate_GatePort: TEdit;
    GroupBox24: TGroupBox;
    Label29: TLabel;
    EditSelGate_GatePort: TEdit;
    GroupBox27: TGroupBox;
    CheckBoxboLoginGate_GetStart: TCheckBox;
    GroupBox28: TGroupBox;
    CheckBoxboSelGate_GetStart: TCheckBox;
    TabSheetDebug: TTabSheet;
    GroupBox29: TGroupBox;
    GroupBox30: TGroupBox;
    Label45: TLabel;
    EditM2CheckCodeAddr: TEdit;
    TimerCheckDebug: TTimer;
    Label46: TLabel;
    EditM2CheckCode: TEdit;
    ButtonM2Suspend: TButton;
    GroupBox31: TGroupBox;
    Label47: TLabel;
    Label48: TLabel;
    EditDBCheckCodeAddr: TEdit;
    EditDBCheckCode: TEdit;
    Button3: TButton;
    Label49: TLabel;
    EditSelGate_GatePort1: TEdit;
    GroupBox33: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    EditLoginServerGatePort: TEdit;
    EditLoginServerServerPort: TEdit;
    GroupBox34: TGroupBox;
    CheckBoxboLoginServer_GetStart: TCheckBox;
    GroupBox35: TGroupBox;
    CheckBoxDBServerGetStart: TCheckBox;
    GroupBox36: TGroupBox;
    Label52: TLabel;
    Label53: TLabel;
    EditDBServerGatePort: TEdit;
    EditDBServerServerPort: TEdit;
    GroupBox37: TGroupBox;
    CheckBoxLogServerGetStart: TCheckBox;
    GroupBox38: TGroupBox;
    Label54: TLabel;
    EditLogServerPort: TEdit;
    GroupBox39: TGroupBox;
    Label55: TLabel;
    EditM2ServerGatePort: TEdit;
    GroupBox40: TGroupBox;
    CheckBoxM2ServerGetStart: TCheckBox;
    Label56: TLabel;
    EditM2ServerMsgSrvPort: TEdit;
    Label57: TLabel;
    EditDBCheckStr: TEdit;
    Label58: TLabel;
    EditM2CheckStr: TEdit;
    CheckBoxRunGate3: TCheckBox;
    CheckBoxRunGate4: TCheckBox;
    CheckBoxRunGate5: TCheckBox;
    CheckBoxRunGate6: TCheckBox;
    CheckBoxRunGate7: TCheckBox;
    GroupBox4: TGroupBox;
    ListViewDataBackup: TListView;
    GroupBox6: TGroupBox;
    ButtonBackChg: TButton;
    ButtonBackDel: TButton;
    ButtonBackAdd: TButton;
    ButtonBackStart: TButton;
    ButtonBackSave: TButton;
    RadioButtonBackMode1: TRadioButton;
    Label5: TLabel;
    Label6: TLabel;
    RzButtonEditSource: TRzButtonEdit;
    RzButtonEditDest: TRzButtonEdit;
    RadioButtonBackMode2: TRadioButton;
    RzSpinEditHour1: TRzSpinEdit;
    RzSpinEditHour2: TRzSpinEdit;
    Label7: TLabel;
    RzSpinEditMin1: TRzSpinEdit;
    Label8: TLabel;
    CheckBoxBackUp: TCheckBox;
    Label64: TLabel;
    RzSpinEditMin2: TRzSpinEdit;
    Label65: TLabel;
    CheckBoxZip: TCheckBox;
    LabelBackMsg: TLabel;
    tsDataList: TTabSheet;
    GroupBox21: TGroupBox;
    ListViewDataList: TListView;
    btDataListSelect: TButton;
    btDataListAll: TButton;
    CSocket: TClientSocket;
    CheckBoxSelGate: TCheckBox;
    CheckBoxLoginGate: TCheckBox;
    ComboBoxRunStatus: TComboBox;
    EditHour: TSpinEdit;
    EditMinute: TSpinEdit;
    Label24: TLabel;
    Label25: TLabel;
    EditLoginServerMonPort: TEdit;
    Label26: TLabel;
    CheckBoxboSelGate_GetStart2: TCheckBox;
    CheckBoxboRunGate_GetStart1: TCheckBox;
    CheckBoxboRunGate_GetStart2: TCheckBox;
    CheckBoxboRunGate_GetStart3: TCheckBox;
    CheckBoxboRunGate_GetStart4: TCheckBox;
    CheckBoxboRunGate_GetStart5: TCheckBox;
    CheckBoxboRunGate_GetStart6: TCheckBox;
    CheckBoxboRunGate_GetStart7: TCheckBox;
    CheckBoxboRunGate_GetStart8: TCheckBox;
    btDataListList: TButton;
    Label27: TLabel;
    LabelLog: TLabel;
    CheckDBServer: TCheckBox;
    CheckM2Server: TCheckBox;
    CheckRunGate1: TCheckBox;
    CheckRunGate7: TCheckBox;
    CheckRunGate5: TCheckBox;
    CheckRunGate3: TCheckBox;
    CheckLoginSrv: TCheckBox;
    CheckLogServer: TCheckBox;
    CheckRunGate2: TCheckBox;
    CheckRunGate4: TCheckBox;
    CheckRunGate6: TCheckBox;
    CheckRunGate8: TCheckBox;
    CheckSelGate2: TCheckBox;
    CheckLoginGate: TCheckBox;
    CheckSelGate1: TCheckBox;
    CheckBoxAutoRunBak: TCheckBox;
    pm1: TPopupMenu;
    N1: TMenuItem;
    dlgSave: TSaveDialog;
    CheckBoxIP2: TCheckBox;
    EditGameExtIPaddr2: TEdit;
    Label30: TLabel;
    GroupBox20: TGroupBox;
    CheckBoxCloseWuXin: TCheckBox;
    TabSheet13: TTabSheet;
    GroupBox25: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    Button1: TButton;
    CheckBox12: TCheckBox;
    procedure ButtonNext1Click(Sender: TObject);
    procedure ButtonPrv2Click(Sender: TObject);
    procedure ButtonNext2Click(Sender: TObject);
    procedure ButtonPrv3Click(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonGenGameConfigClick(Sender: TObject);
    procedure ButtonStartGameClick(Sender: TObject);
    procedure TimerStartGameTimer(Sender: TObject);
    procedure CheckBoxDBServerClick(Sender: TObject);
    procedure CheckBoxLoginServerClick(Sender: TObject);
    procedure CheckBoxM2ServerClick(Sender: TObject);
    procedure CheckBoxLogServerClick(Sender: TObject);
    procedure CheckBoxLoginGateClick(Sender: TObject);
    procedure CheckBoxRunGateClick(Sender: TObject);
    procedure TimerStopGameTimer(Sender: TObject);
    procedure TimerCheckRunTimer(Sender: TObject);
    procedure ButtonReLoadConfigClick(Sender: TObject);
    procedure EditLoginGate_MainFormXChange(Sender: TObject);
    procedure EditLoginGate_MainFormYChange(Sender: TObject);
    procedure EditSelGate_MainFormXChange(Sender: TObject);
    procedure EditSelGate_MainFormYChange(Sender: TObject);
    procedure EditLoginServer_MainFormXChange(Sender: TObject);
    procedure EditLoginServer_MainFormYChange(Sender: TObject);
    procedure EditDBServer_MainFormXChange(Sender: TObject);
    procedure EditDBServer_MainFormYChange(Sender: TObject);
    procedure EditLogServer_MainFormXChange(Sender: TObject);
    procedure EditLogServer_MainFormYChange(Sender: TObject);
    procedure EditM2Server_MainFormXChange(Sender: TObject);
    procedure EditM2Server_MainFormYChange(Sender: TObject);
    procedure MemoLogChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonNext3Click(Sender: TObject);
    procedure ButtonNext4Click(Sender: TObject);
    procedure ButtonNext5Click(Sender: TObject);
    procedure ButtonNext6Click(Sender: TObject);
    procedure ButtonNext7Click(Sender: TObject);
    procedure ButtonPrv4Click(Sender: TObject);
    procedure ButtonPrv5Click(Sender: TObject);
    procedure ButtonPrv6Click(Sender: TObject);
    procedure ButtonPrv7Click(Sender: TObject);
    procedure ButtonPrv8Click(Sender: TObject);
    procedure ButtonNext8Click(Sender: TObject);
    procedure ButtonPrv9Click(Sender: TObject);
    procedure ButtonRunGateDefaultClick(Sender: TObject);
    procedure ButtonGeneralDefalultClick(Sender: TObject);
    procedure ButtonLoginGateDefaultClick(Sender: TObject);
    procedure ButtonSelGateDefaultClick(Sender: TObject);
    procedure ButtonLoginSrvDefaultClick(Sender: TObject);
    procedure ButtonDBServerDefaultClick(Sender: TObject);
    procedure ButtonLogServerDefaultClick(Sender: TObject);
    procedure ButtonM2ServerDefaultClick(Sender: TObject);
    procedure CheckBoxboLoginGate_GetStartClick(Sender: TObject);
    procedure CheckBoxboSelGate_GetStartClick(Sender: TObject);
    procedure TimerCheckDebugTimer(Sender: TObject);
    procedure ButtonM2SuspendClick(Sender: TObject);
    procedure CheckBoxboLoginServer_GetStartClick(Sender: TObject);
    procedure CheckBoxDBServerGetStartClick(Sender: TObject);
    procedure CheckBoxLogServerGetStartClick(Sender: TObject);
    procedure CheckBoxM2ServerGetStartClick(Sender: TObject);
    procedure ButtonBackStartClick(Sender: TObject);
    procedure ButtonBackSaveClick(Sender: TObject);
    procedure ButtonBackAddClick(Sender: TObject);
    procedure ButtonBackDelClick(Sender: TObject);
    procedure ButtonBackChgClick(Sender: TObject);
    procedure ListViewDataBackupClick(Sender: TObject);
    procedure RzButtonEditSourceButtonClick(Sender: TObject);
    procedure RzButtonEditDestButtonClick(Sender: TObject);
    procedure RadioButtonBackMode1Click(Sender: TObject);
    procedure RadioButtonBackMode2Click(Sender: TObject);
    procedure EditRunGate_MainFormXChange(Sender: TObject);
    procedure EditRunGate_MainFormYChange(Sender: TObject);
    procedure btDataListAllClick(Sender: TObject);
    procedure CSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure CSocketConnecting(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormDestroy(Sender: TObject);
    procedure ListViewDataListDblClick(Sender: TObject);
    procedure btDataListSelectClick(Sender: TObject);
    procedure CheckBoxSelGateClick(Sender: TObject);
    procedure CheckBoxboSelGate_GetStart2Click(Sender: TObject);
    procedure CheckBoxSelGate1Click(Sender: TObject);
    procedure CheckBoxboRunGate_GetStart2Click(Sender: TObject);
    procedure btDataListListClick(Sender: TObject);
    procedure CheckDBServerClick(Sender: TObject);
    procedure CheckM2ServerClick(Sender: TObject);
    procedure CheckLoginSrvClick(Sender: TObject);
    procedure CheckLogServerClick(Sender: TObject);
    procedure CheckLoginGateClick(Sender: TObject);
    procedure CheckSelGate1Click(Sender: TObject);
    procedure CheckSelGate2Click(Sender: TObject);
    procedure CheckRunGate1Click(Sender: TObject);
    procedure ComboBoxRunStatusChange(Sender: TObject);
    procedure CheckBoxAutoRunBakClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure CheckBoxIP2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    m_boOpen: Boolean;
    m_nStartStatus: Integer;
    m_dwShowTick: LongWord;
    m_dwRefTick: LongWord;
    m_btHour: Byte;
    m_btMinute: Byte;
    m_dwRunTime: LongWord;
    m_dwRunTick: LongWord;
    m_boGateStop: Boolean;
    m_boGateStopTick: LongWord;
    procedure RefGameConsole();
    procedure GenGameConfig();
    procedure GenDBServerConfig();
    procedure GenLoginServerConfig();
    procedure GenLogServerConfig();
    procedure GenM2ServerConfig();
    procedure GenLoginGateConfig();
    procedure GenSelGateConfig();
    procedure GenRunGateConfig;
    procedure StartGame();
    procedure StopGame();
    procedure MainOutMessage(sMsg: string);
    procedure MainOutDataListMessage(sMsg: string);
    procedure ProcessDBServerMsg(wIdent: Word; sData: string);
    procedure ProcessLoginSrvMsg(wIdent: Word; sData: string);
    //procedure ProcessLoginSrvGetUserAccount(sData: string);
    //procedure ProcessLoginSrvChangeUserAccountStatus(sData: string);
//    procedure UserAccountEditMode(boChecked: Boolean);
    procedure ProcessLogServerMsg(wIdent: Word; sData: string);

    procedure ProcessLoginGateMsg(wIdent: Word; sData: string);
    //procedure ProcessLoginGate1Msg(wIdent: Word; sData: string);

    procedure ProcessSelGateMsg(wIdent: Word; sData: string);
    //procedure ProcessSelGate1Msg(wIdent: Word; sData: string);

    procedure ProcessRunGateMsg(wIdent: Word; sData: string);
    function ProcessM2ServerMsg(wIdent: Word; sData: string): Integer;
    procedure GetMutRunGateConfing(nIndex: Integer);

    function StartService(): Boolean;
    //procedure StopService();
    procedure RefGameDebug();
    procedure GenMutSelGateConfig(nIndex: Integer);
    procedure GenMutLoginGateConfig(nIndex: Integer);

    procedure LoadBackList();
    procedure RefBackListToView();
    function SendDataListData(wIdent: Word; sData: string): Boolean;
    function RefDataListItem(): Boolean;
    procedure ClearDataListItem();
    function NewDataListInfo(): pTDataListInfo;
    procedure DisposeDataListInfo(DataListInfo: pTDataListInfo);
    function GetNextData(): Boolean;
//    function GetFileData(sFileName: string; out FileBuffer: PChar; out nBufferLen: Integer): Boolean;
    function MapGetFileData(sFileName: string; boBackData: Boolean): Integer;
    { Private declarations }
  public
    procedure ProcessMessage(var Msg: TMsg; var Handled: Boolean);
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;

    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses HUtil32, Grobal2, DataBackUp, EDcode, MD5Unit, TextForm;

{$R *.dfm}
//文件夹浏览函数    uses ShlObj, ActiveX

function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer
  stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) and (lpData <> 0) then
    SendMessage(Wnd, BFFM_SETSELECTION, Integer(True), lpData);
  Result := 0;
end;

function SelectDirectory(const Caption: string; const Root: WideString;
  var Directory: string; Owner: THandle): Boolean;
var
  WindowList: Pointer;
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;
begin
  Result := False;
  if not DirectoryExists(Directory) then
    Directory := '';
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
          POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
      with BrowseInfo do begin
        hwndOwner := Owner; //Application.Handle;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS;
        if Directory <> '' then begin
          lpfn := SelectDirCB;
          lParam := Integer(PChar(Directory));
        end;
      end;
      WindowList := DisableTaskWindows(0);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        EnableTaskWindows(WindowList);
      end;
      Result := ItemIDList <> nil;
      if Result then begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Directory := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;

procedure TfrmMain.MainOutMessage(sMsg: string);
begin
  sMsg := '[' + DateTimeToStr(Now) + '] ' + sMsg;
  MemoLog.Lines.Add(sMsg);
end;

procedure TfrmMain.MainOutDataListMessage(sMsg: string);
begin
  LabelLog.Caption := sMsg;
  //sMsg := '[' + DateTimeToStr(Now) + '] ' + sMsg;
  //mmoDataListLog.Lines.Add(sMsg);
end;

procedure TfrmMain.ButtonNext1Click(Sender: TObject);
var
  sGameDirectory: string;
  sHeroDBName: string;
  sGameName: string;
  sExtIPAddr, sExtIPAddr2: string;
begin
  sGameDirectory := Trim(EditGameDir.Text);
  sHeroDBName := Trim(EditHeroDB.Text);

  sGameName := Trim(EditGameName.Text);
  sExtIPAddr := Trim(EditGameExtIPaddr.Text);
  sExtIPAddr2 := Trim(EditGameExtIPaddr2.Text);
  if sGameName = '' then begin
    Application.MessageBox('游戏服务器名称输入不正确！！！', '提示信息', MB_OK + MB_ICONEXCLAMATION);
    EditGameName.SetFocus;
    Exit;
  end;
  if (sExtIPAddr = '') or not IsIPaddr(sExtIPAddr) then begin
    Application.MessageBox('游戏服务器外部IP地址输入不正确！！！', '提示信息', MB_OK + MB_ICONEXCLAMATION);
    EditGameExtIPaddr.SetFocus;
    Exit;
  end;

  if CheckBoxIP2.Checked and (sExtIPAddr2 = '') or not IsIPaddr(sExtIPAddr2) then begin
    Application.MessageBox('游戏服务器外部IP地址输入不正确！！！', '提示信息', MB_OK + MB_ICONEXCLAMATION);
    EditGameExtIPaddr2.SetFocus;
    Exit;
  end;

  if (sGameDirectory = '') or not DirectoryExists(sGameDirectory) then begin
    Application.MessageBox('游戏目录输入不正确！！！', '提示信息', MB_OK + MB_ICONEXCLAMATION);
    EditGameDir.SetFocus;
    Exit;
  end;
  if not (sGameDirectory[length(sGameDirectory)] = '\') then begin
    Application.MessageBox('游戏目录名称最后一个字符必须为"\"！！！', '提示信息', MB_OK + MB_ICONEXCLAMATION);
    EditGameDir.SetFocus;
    Exit;
  end;
  if sHeroDBName = '' then begin
    Application.MessageBox('游戏数据库名称输入不正确！！！', '提示信息', MB_OK + MB_ICONEXCLAMATION);
    EditHeroDB.SetFocus;
    Exit;
  end;
  g_sGameDirectory := sGameDirectory;
  g_sHeroDBName := sHeroDBName;
  g_sGameName := sGameName;
  g_sExtIPaddr := sExtIPAddr;
  g_sExtIPaddr2 := sExtIPAddr2;
  g_boIP2 := CheckBoxIP2.Checked;
  g_boCloseWuXin := CheckBoxCloseWuXin.Checked;

  PageControl3.ActivePageIndex := 1;
end;

procedure TfrmMain.ButtonPrv2Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 0;
end;

procedure TfrmMain.ButtonNext2Click(Sender: TObject);
var
  nPort: Integer;
begin
  nPort := StrToIntDef(Trim(EditLoginGate_GatePort.Text), -1);
  if (nPort < 0) or (nPort > 65535) then begin
    Application.MessageBox('网关端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditLoginGate_GatePort.SetFocus;
    Exit;
  end;
  g_Config.LoginGate.GatePort := nPort;
  PageControl3.ActivePageIndex := 2;
end;

procedure TfrmMain.ButtonPrv3Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 1;
end;

procedure TfrmMain.ButtonNext3Click(Sender: TObject);
var
  nPort: Integer;
begin
  nPort := StrToIntDef(Trim(EditSelGate_GatePort.Text), -1);
  if (nPort < 0) or (nPort > 65535) then begin
    Application.MessageBox('网关端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditSelGate_GatePort.SetFocus;
    Exit;
  end;
  g_Config.SelGate.GatePort[0] := nPort;

  nPort := StrToIntDef(Trim(EditSelGate_GatePort1.Text), -1);
  if (nPort < 0) or (nPort > 65535) then begin
    Application.MessageBox('网关端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditSelGate_GatePort1.SetFocus;
    Exit;
  end;
  g_Config.SelGate.GatePort[1] := nPort;
  PageControl3.ActivePageIndex := 3;
end;

procedure TfrmMain.ButtonNext4Click(Sender: TObject);
var
  nPort1, nPort2, nPort3, nPort4, nPort5, nPort6, nPort7, nPort8: Integer;
begin
  nPort1 := StrToIntDef(Trim(EditRunGate_GatePort1.Text), -1);
  nPort2 := StrToIntDef(Trim(EditRunGate_GatePort2.Text), -1);
  nPort3 := StrToIntDef(Trim(EditRunGate_GatePort3.Text), -1);
  nPort4 := StrToIntDef(Trim(EditRunGate_GatePort4.Text), -1);
  nPort5 := StrToIntDef(Trim(EditRunGate_GatePort5.Text), -1);
  nPort6 := StrToIntDef(Trim(EditRunGate_GatePort6.Text), -1);
  nPort7 := StrToIntDef(Trim(EditRunGate_GatePort7.Text), -1);
  nPort8 := StrToIntDef(Trim(EditRunGate_GatePort8.Text), -1);

  if (nPort1 < 0) or (nPort1 > 65535) then begin
    Application.MessageBox('网关一端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort1.SetFocus;
    Exit;
  end;
  if (nPort2 < 0) or (nPort2 > 65535) then begin
    Application.MessageBox('网关二端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort2.SetFocus;
    Exit;
  end;
  if (nPort3 < 0) or (nPort3 > 65535) then begin
    Application.MessageBox('网关三端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort3.SetFocus;
    Exit;
  end;
  if (nPort4 < 0) or (nPort4 > 65535) then begin
    Application.MessageBox('网关四端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort4.SetFocus;
    Exit;
  end;
  if (nPort5 < 0) or (nPort5 > 65535) then begin
    Application.MessageBox('网关五端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort5.SetFocus;
    Exit;
  end;
  if (nPort6 < 0) or (nPort6 > 65535) then begin
    Application.MessageBox('网关六端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort6.SetFocus;
    Exit;
  end;
  if (nPort7 < 0) or (nPort7 > 65535) then begin
    Application.MessageBox('网关七端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort7.SetFocus;
    Exit;
  end;
  if (nPort8 < 0) or (nPort8 > 65535) then begin
    Application.MessageBox('网关八端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort8.SetFocus;
    Exit;
  end;
  g_Config.RunGate.GatePort[0] := nPort1;
  g_Config.RunGate.GatePort[1] := nPort2;
  g_Config.RunGate.GatePort[2] := nPort3;
  g_Config.RunGate.GatePort[3] := nPort4;
  g_Config.RunGate.GatePort[4] := nPort5;
  g_Config.RunGate.GatePort[5] := nPort6;
  g_Config.RunGate.GatePort[6] := nPort7;
  g_Config.RunGate.GatePort[7] := nPort8;
  PageControl3.ActivePageIndex := 4;
end;

procedure TfrmMain.ButtonNext5Click(Sender: TObject);
var
  nGatePort, nServerPort, nMonPort: Integer;
begin
  nGatePort := StrToIntDef(Trim(EditLoginServerGatePort.Text), -1);
  nServerPort := StrToIntDef(Trim(EditLoginServerServerPort.Text), -1);
  nMonPort := StrToIntDef(Trim(EditLoginServerMonPort.Text), -1);
  if (nGatePort < 0) or (nGatePort > 65535) then begin
    Application.MessageBox('网关端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditLoginServerGatePort.SetFocus;
    Exit;
  end;
  if (nServerPort < 0) or (nServerPort > 65535) then begin
    Application.MessageBox('通讯端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditLoginServerServerPort.SetFocus;
    Exit;
  end;
  if (nMonPort < 0) or (nMonPort > 65535) then begin
    Application.MessageBox('监控端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditLoginServerServerPort.SetFocus;
    Exit;
  end;
  g_Config.LoginSrv.GatePort := nGatePort;
  g_Config.LoginSrv.ServerPort := nServerPort;
  g_Config.LoginSrv.MonPort := nMonPort;
  PageControl3.ActivePageIndex := 5;
end;

procedure TfrmMain.ButtonNext6Click(Sender: TObject);
var
  nGatePort, nServerPort: Integer;
begin
  nGatePort := StrToIntDef(Trim(EditDBServerGatePort.Text), -1);
  nServerPort := StrToIntDef(Trim(EditDBServerServerPort.Text), -1);

  if (nGatePort < 0) or (nGatePort > 65535) then begin
    Application.MessageBox('网关端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditDBServerGatePort.SetFocus;
    Exit;
  end;
  if (nServerPort < 0) or (nServerPort > 65535) then begin
    Application.MessageBox('通讯端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditDBServerServerPort.SetFocus;
    Exit;
  end;
  g_Config.DBServer.GatePort := nGatePort;
  g_Config.DBServer.ServerPort := nServerPort;
  PageControl3.ActivePageIndex := 6;
end;

procedure TfrmMain.ButtonNext7Click(Sender: TObject);
var
  nPort: Integer;
begin
  nPort := StrToIntDef(Trim(EditLogServerPort.Text), -1);
  if (nPort < 0) or (nPort > 65535) then begin
    Application.MessageBox('端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditLogServerPort.SetFocus;
    Exit;
  end;
  g_Config.LogServer.Port := nPort;
  PageControl3.ActivePageIndex := 7;
end;

procedure TfrmMain.ButtonNext8Click(Sender: TObject);
var
  nGatePort, nMsgSrvPort: Integer;
begin
  nGatePort := StrToIntDef(Trim(EditM2ServerGatePort.Text), -1);
  nMsgSrvPort := StrToIntDef(Trim(EditM2ServerMsgSrvPort.Text), -1);
  if (nGatePort < 0) or (nGatePort > 65535) then begin
    Application.MessageBox('网关端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditM2ServerGatePort.SetFocus;
    Exit;
  end;
  if (nMsgSrvPort < 0) or (nMsgSrvPort > 65535) then begin
    Application.MessageBox('通讯端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditM2ServerMsgSrvPort.SetFocus;
    Exit;
  end;
  g_Config.M2Server.GatePort := nGatePort;
  g_Config.M2Server.MsgSrvPort := nMsgSrvPort;
  PageControl3.ActivePageIndex := 8;
end;

procedure TfrmMain.ButtonPrv4Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 2;
end;

procedure TfrmMain.ButtonPrv5Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 3;
end;

procedure TfrmMain.ButtonPrv6Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 4;
end;

procedure TfrmMain.ButtonPrv7Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 5;
end;

procedure TfrmMain.ButtonPrv8Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 6;
end;

procedure TfrmMain.ButtonPrv9Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 7;
end;

procedure TfrmMain.ButtonSaveClick(Sender: TObject);
begin
  SaveConfig;
  Application.MessageBox('配置文件已经保存完毕...', '提示信息', MB_OK + MB_ICONINFORMATION);
  if Application.MessageBox('是否生成新的游戏服务器配置文件...', '提示信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    ButtonGenGameConfigClick(ButtonGenGameConfig);
  end;
  PageControl3.ActivePageIndex := 0;
  PageControl1.ActivePageIndex := 0;
end;

procedure TfrmMain.LoadBackList();
var
  I: Integer;
  List: TStringList;
  Conini: Tinifile;
  BackUpObject: TBackUpObject;
  sSource, sDest: string;
  wHour, wMin: Word;
  btBackMode: Byte;
  boGetBack: Boolean;
  boZip: Boolean;
begin
  ButtonBackDel.Enabled := False;
  ButtonBackChg.Enabled := False;
  g_BackUpManager := TBackUpManager.Create;
  List := TStringList.Create;
  Conini := Tinifile.Create(g_sBackListFile);
  Conini.ReadSections(List);
  if Conini <> nil then begin
    for I := 0 to List.Count - 1 do begin
      sSource := Conini.ReadString(List.Strings[I], 'Source', '');
      sDest := Conini.ReadString(List.Strings[I], 'Save', '');
      wHour := Conini.ReadInteger(List.Strings[I], 'Hour', 0);
      wMin := Conini.ReadInteger(List.Strings[I], 'Min', 0);
      btBackMode := Conini.ReadInteger(List.Strings[I], 'BackMode', 0);
      boGetBack := Conini.ReadBool(List.Strings[I], 'GetBack', True);
      boZip := Conini.ReadBool(List.Strings[I], 'Zip', True);
      if (sSource <> '') and (sDest <> '') then begin
        BackUpObject := TBackUpObject.Create;
        BackUpObject.m_nIndex := I;
        BackUpObject.m_sSourceDir := sSource;
        BackUpObject.m_sDestDir := sDest;
        BackUpObject.m_btBackUpMode := btBackMode;
        BackUpObject.m_boBackUp := boGetBack;
        BackUpObject.m_boZip := boZip;
        BackUpObject.m_wHour := wHour;
        BackUpObject.m_wMin := wMin;
        g_BackUpManager.AddObjectToList(BackUpObject);
      end;
    end;
    Conini.Free;
  end;
  List.Free;
end;

procedure TfrmMain.RefBackListToView();
var
  I: Integer;
  BackUpObject: TBackUpObject;
  ListItem: TListItem;
begin
  ListViewDataBackup.Items.Clear;
  for I := 0 to g_BackUpManager.m_BackUpList.Count - 1 do begin
    BackUpObject := TBackUpObject(g_BackUpManager.m_BackUpList.Items[I]);
    ListItem := ListViewDataBackup.Items.Add;
    ListItem.Caption := BackUpObject.m_sSourceDir;
    ListItem.SubItems.AddObject(BackUpObject.m_sDestDir, BackUpObject);
  end;
end;

procedure TfrmMain.N1Click(Sender: TObject);
var
  Item: TListItem;
  DataListInfo: pTDataListInfo;
  FileStream: TFileStream;
begin
  if (ListViewDataList.ItemIndex >= 0) and (ListViewDataList.ItemIndex < ListViewDataList.Items.Count) then begin
    Item := ListViewDataList.Items[ListViewDataList.ItemIndex];
    DataListInfo := pTDataListInfo(Item.SubItems.Objects[0]);
    if (DataListInfo <> nil) and (DataListInfo.Data <> nil) and (DataListInfo.DataSize > 0) then begin
      dlgSave.FileName := '.\' + ExtractFileName(Item.Caption);
      if dlgSave.Execute(Handle) then begin
        if FileExists(dlgSave.FileName) then begin
          if Application.MessageBox('文件已经存在，是否覆盖原文件？', '提示信息',
            MB_OKCANCEL + MB_ICONQUESTION + MB_DEFBUTTON2) = IDCANCEL then
          begin
            Exit;
          end;
          if not DeleteFile(dlgSave.FileName) then begin
            Application.MessageBox('删除原文件失败！', '提示信息', MB_OK + MB_ICONSTOP);
            Exit;
          end;
        end;
        FileStream := TFileStream.Create(dlgSave.FileName, fmCreate);
        Try
          if not FileStream.Write(DataListInfo.Data^, DataListInfo.DataSize) = DataListInfo.DataSize then begin
            Application.MessageBox('保存文件失败', '提示信息', MB_OK + MB_ICONSTOP);
          end else
            Application.MessageBox('输入完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
        Finally
          FileStream.Free;
        End;
      end;
    end;
  end;
end;

function TfrmMain.NewDataListInfo(): pTDataListInfo;
begin
  New(Result);
  FillChar(Result^, SizeOf(TDataListInfo), #0);
end;

procedure TfrmMain.DisposeDataListInfo(DataListInfo: pTDataListInfo);
begin
  if DataListInfo.MapFileBuffer <> nil then
    UnMapViewOfFile(DataListInfo.MapFileBuffer);
  if DataListInfo.MapFileHandle <> 0 then
    CloseHandle(DataListInfo.MapFileHandle);
  if DataListInfo.Data <> nil then
    FreeMem(DataListInfo.Data);
  Dispose(DataListInfo);
end;

procedure TfrmMain.ClearDataListItem();
var
  Item: TListItem;
begin
  for Item in ListViewDataList.Items do
    DisposeDataListInfo(pTDataListInfo(Item.SubItems.Objects[0]));
  ListViewDataList.Clear;
  GroupBox21.Caption := '数据列表';
end;

procedure TfrmMain.ComboBoxRunStatusChange(Sender: TObject);
begin
  if Sender = ComboBoxRunStatus then begin
    EditHour.Enabled := (ComboBoxRunStatus.ItemIndex > 0) and ComboBoxRunStatus.Enabled;
    EditMinute.Enabled := (ComboBoxRunStatus.ItemIndex > 0) and ComboBoxRunStatus.Enabled;
  end;
  m_btHour := EditHour.Value;
  m_btMinute := EditMinute.Value;
  m_dwRunTime := (60 * 1000 * m_btMinute) + (60 * 60 * 1000 * m_btHour);
end;

function TfrmMain.RefDataListItem: Boolean;
  function CheckAddItem(sFileName: string): TListItem;
  var
    Item: TListItem;
  begin
    Result := nil;
    for Item in ListViewDataList.Items do begin
      if CompareText(sFileName, Item.Caption) = 0 then begin
        Result := Item;
        break;
      end;
    end;
  end;
var
  sData, sFileName, sFileTime: string;
  I: Integer;
  Item: TListItem;
  DataListInfo: pTDataListInfo;
begin
  Result := False;
  //ClearDataListItem;
  for I := 0 to g_GetDatList.Count - 1 do begin
    sData := g_GetDatList[i];
    sData := GetValidStr3(sData, sFileName, [#9]);
    sData := GetValidStr3(sData, sFileTime, [#9]);
    if (sFileName <> '') and (sFileTime <> '') then begin
      Item := CheckAddItem(sFileName);
      if Item = nil then begin
        DataListInfo := NewDataListInfo;
        DataListInfo.sFileName := sFileName;
        DataListInfo.DateTime := 0;
        Item := ListViewDataList.Items.Add;
        Item.Caption := sFileName;
        Item.SubItems.AddObject(DateTimeToStr(DataListInfo.DateTime), TObject(DataListInfo));
        Item.SubItems.Add('0');
        Item.SubItems.Add('未更新');
        DataListInfo.Item := Item;
      end else begin
        if StrToDateTimeDef(Item.SubItems[0], 0) < StrToDateTimeDef(sFileTime, 0) then begin
          Item.SubItems[2] := '有新版本';
        end;
      end;
    end;
  end;
  g_GetDatList.Clear;
  GroupBox21.Caption := Format('数据列表(%d)', [ListViewDataList.Items.Count]);
  MainOutDataListMessage('列表更新完成...');
  g_boGetDataListOK := True;
  //Result := GetNextData();

end;

function TfrmMain.GetNextData(): Boolean;
var
  DefMessage: TDefMessage;
  SendBuffer: PChar;
  nSendCount: Integer;
  nWaitTick: LongWord;
  nMsgLen: Integer;
  DataListInfo: pTDataListInfo;
  sData: string;
  Item: TListItem;
begin
  Result := False;
  if (g_GetDatList.Count > 0) then begin
    if g_GetDatList.Objects[0] <> nil then begin
      DataListInfo := pTDataListInfo(g_GetDatList.Objects[0]);
      Item := DataListInfo.Item;
      Item.SubItems.Strings[2] := '正在更新';
      MainOutDataListMessage('正在更新[' + DataListInfo.sFileName + ']...');
      sData := Trim(DataListInfo.sFileName);
      nMsgLen := Length(sData) + 1;
      DefMessage := MakeDefMessage(SEC_GETFILE, Integer(DataListInfo), DataListInfo.DateTime, nMsgLen);
      SendBuffer := AllocMem(SizeOf(TDefMessage) + nMsgLen);
      try
        Move(DefMessage, SendBuffer^, SizeOf(TDefMessage));
        Move(sData[1], SendBuffer[SizeOf(TDefMessage)], nMsgLen);
        nSendCount := 0;
        while CSocket.Active and (CSocket.Socket.SendBuf(SendBuffer^, SizeOf(TDefMessage) + nMsgLen) = -1) do begin
          Inc(nSendCount);
          if nSendCount > 10 then begin
            MainOutDataListMessage('发送获取[' + sData + ']的数据失败...');
            exit;
          end;
          nWaitTick := GetTickCount + 1000;
          while GetTickCount < nWaitTick do begin
            Application.ProcessMessages;
            Sleep(1);
          end;
        end;
      finally
        FreeMem(SendBuffer);
      end;
      Result := True;
    end else begin
      g_GetDatList.Delete(0);
      Result := GetNextData;
    end;
  end else begin
    MainOutDataListMessage('数据更新完成...');
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  m_boOpen := False;
//  g_nFormIdx := g_IniConf.ReadInteger('Setup', 'FormID', g_nFormIdx);
//  Application.OnMessage := ProcessMessage;
  PageControl1.ActivePageIndex := 0;
  PageControl3.ActivePageIndex := 0;
  m_nStartStatus := 0;
  m_nBackStartStatus := 0;
  MemoLog.Clear;
  //mmoDataListLog.Clear;
  g_GetDatList := TStringList.Create;
  m_dwRefTick := GetTickCount;
  LoadConfig();
  LoadBackList();
  RefBackListToView();
  ListViewDataList.Clear;
  if not StartService() then
    Exit;
  RefGameConsole();
  TabSheetDebug.TabVisible := False;
  tsDataList.TabVisible := False;
  {if g_boShowDebugTab then begin
    TabSheetDebug.TabVisible := True;
    TimerCheckDebug.Enabled := True;
  end;    }
  CheckBoxAutoRunBak.Checked := g_boAutoRunBak;
  m_boOpen := True;
  if g_boAutoRunBak then ButtonBackStartClick(ButtonBackStart);
  //MainOutMessage('游戏控制器启动成功...');
//  SetWindowPos(Self.Handle,HWND_TOPMOST,Self.Left,Self.Top,Self.Width,Self.Height,$40);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  ClearDataListItem;
  g_GetDatList.Free;
end;

procedure TfrmMain.ButtonGenGameConfigClick(Sender: TObject);
begin
  GenGameConfig();
  RefGameConsole();
  Application.MessageBox('引擎配置文件已经生成完毕...', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmMain.GenGameConfig;
begin
  GenDBServerConfig();
  GenLoginServerConfig();
  GenM2ServerConfig();
  GenLogServerConfig();
  GenRunGateConfig();
  GenSelGateConfig();
  GenLoginGateConfig();
end;

procedure TfrmMain.GenDBServerConfig;
var
  IniGameConf: Tinifile;
  sIniFile, sDir: string;
  SaveList: TStringList;
  I: Integer;
begin
  sIniFile := g_sGameDirectory + 'DBServer\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  sDir := g_sGameDirectory + 'DBServer\DB\';
  if not DirectoryExists(sDir) then begin
    CreateDir(sDir);
  end;

  IniGameConf := Tinifile.Create(sIniFile + 'Dbsrc.ini');
  IniGameConf.WriteString(DBSERVERSECTIONNAME2, 'ServerName', g_sGameName);
  IniGameConf.WriteString(DBSERVERSECTIONNAME2, 'ServerAddr', sLocalIPaddr);
  IniGameConf.WriteInteger(DBSERVERSECTIONNAME2, 'ServerPort', g_Config.DBServer.ServerPort);
  IniGameConf.WriteString(DBSERVERSECTIONNAME2, 'GateAddr', sAllIPaddr);
  IniGameConf.WriteInteger(DBSERVERSECTIONNAME2, 'GatePort', g_Config.DBServer.GatePort);
  IniGameConf.WriteString(DBSERVERSECTIONNAME2, 'IDSAddr', sLocalIPaddr);
  IniGameConf.WriteInteger(DBSERVERSECTIONNAME2, 'IDSPort', g_Config.LoginSrv.ServerPort);
  IniGameConf.WriteString(DBSERVERSECTIONNAME2, 'DBName', g_sHeroDBName);
  IniGameConf.WriteString(DBSERVERSECTIONNAME2, 'DBDir', '.\DB\');
  IniGameConf.Free;

  SaveList := TStringList.Create;
  SaveList.Add(sLocalIPaddr);
  if g_boIP2 then SaveList.Add(sLocalIPaddr2);
  SaveList.SaveToFile(sIniFile + '!addrtable.txt');

  SaveList.Clear;
  sIniFile := sLocalIPaddr;
  for I := Low(g_Config.RunGate.GetStart) to High(g_Config.RunGate.GetStart) do begin
    if g_Config.RunGate.GetStart[I] then
      sIniFile := sIniFile + Format(' %s %d', [g_sExtIPaddr, g_Config.RunGate.GatePort[I]]);
  end;
  SaveList.Add(sIniFile);
  if g_boIP2 then begin
    sIniFile := sLocalIPaddr2;
    for I := Low(g_Config.RunGate.GetStart) to High(g_Config.RunGate.GetStart) do begin
      if g_Config.RunGate.GetStart[I] then
        sIniFile := sIniFile + Format(' %s %d', [g_sExtIPaddr2, g_Config.RunGate.GatePort[I]]);
    end;
    SaveList.Add(sIniFile);
  end;
  SaveList.SaveToFile(g_sGameDirectory + 'DBServer\!serverinfo.txt');
  SaveList.Free;

  {if not FileExists(g_sGameDirectory + 'DBServer\FSortName.txt') then begin
    SaveList := TStringList.Create;
    SaveList.Add(';排行榜过滤人物名称');
    SaveList.SaveToFile(g_sGameDirectory + 'DBServer\FSortName.txt');
    SaveList.Free;
  end;     }

  if not FileExists(g_sGameDirectory + 'DBServer\FUserName.txt') then begin
    SaveList := TStringList.Create;
    SaveList.Add(';创建人物过滤字符，一行一个过滤');
    SaveList.SaveToFile(g_sGameDirectory + 'DBServer\FUserName.txt');
    SaveList.Free;
  end;
end;

procedure TfrmMain.GenLoginServerConfig;
var
  IniGameConf: Tinifile;
  sIniFile: string;
  SaveList: TStringList;
begin
  sIniFile := g_sGameDirectory + 'LoginSrv\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  IniGameConf := Tinifile.Create(sIniFile + 'Logsrv.ini');
  IniGameConf.WriteString(LOGINSRVSECTIONNAME2, 'ServerAddr', sAllIPaddr);
  IniGameConf.WriteInteger(LOGINSRVSECTIONNAME2, 'ServerPort', g_Config.LoginSrv.ServerPort);
  IniGameConf.WriteString(LOGINSRVSECTIONNAME2, 'GateAddr', sAllIPaddr);
  IniGameConf.WriteInteger(LOGINSRVSECTIONNAME2, 'GatePort', g_Config.LoginSrv.GatePort);
  IniGameConf.WriteString(LOGINSRVSECTIONNAME2, 'MonAddr', sAllIPaddr);
  IniGameConf.WriteInteger(LOGINSRVSECTIONNAME2, 'MonPort', g_Config.LoginSrv.MonPort);
  IniGameConf.WriteBool(LOGINSRVSECTIONNAME2, 'CloseWuXin', g_boCloseWuXin);
  IniGameConf.WriteString(LOGINSRVSECTIONNAME2, 'IDDir', '.\DB\');
  IniGameConf.WriteString(LOGINSRVSECTIONNAME2, 'CountLogDir', '.\ChrLog\');
  IniGameConf.Free;

  SaveList := TStringList.Create;
  SaveList.Add(sLocalIPaddr);
  if g_boIP2 then SaveList.Add(sLocalIPaddr2);
  SaveList.SaveToFile(sIniFile + '!serveraddr.txt');

  SaveList.Clear;
  SaveList.Add(format('%s %s %d', [g_sGameName, g_sGameName, nLimitOnlineUser]));
  SaveList.SaveToFile(sIniFile + '!UserLimit.txt');

  SaveList.Clear;
  if g_boIP2 then begin
    sIniFile := sLocalIPaddr;
    if g_Config.SelGate.GetStart1 then
      sIniFile := sIniFile + Format(' %s %d', [g_sExtIPaddr, g_Config.SelGate.GatePort[0]]);
    SaveList.Add(sIniFile);
    sIniFile := sLocalIPaddr2;
    if g_Config.SelGate.GetStart2 then
      sIniFile := sIniFile + Format(' %s %d', [g_sExtIPaddr2, g_Config.SelGate.GatePort[1]]);
    SaveList.Add(sIniFile);
  end else begin
    sIniFile := sLocalIPaddr;
    if g_Config.SelGate.GetStart1 then
      sIniFile := sIniFile + Format(' %s %d', [g_sExtIPaddr, g_Config.SelGate.GatePort[0]]);
    if g_Config.SelGate.GetStart2 then
      sIniFile := sIniFile + Format(' %s %d', [g_sExtIPaddr, g_Config.SelGate.GatePort[1]]);
    SaveList.Add(sIniFile);
  end;
  SaveList.SaveToFile(g_sGameDirectory + 'LoginSrv\!addrtable.txt');


  {sIniFile := g_sGameDirectory + 'LoginSrv\IdLog';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;      }

  sIniFile := g_sGameDirectory + 'LoginSrv\ChrLog';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  sIniFile := g_sGameDirectory + 'LoginSrv\DB';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
end;

procedure TfrmMain.GenLogServerConfig;
var
  IniGameConf: Tinifile;
  sIniFile: string;
begin
  sIniFile := g_sGameDirectory + 'LogServer\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  IniGameConf := Tinifile.Create(sIniFile + 'LogData.ini');
  IniGameConf.WriteString(LOGSERVERSECTIONNAME2, 'ServerName', g_sGameName);
  IniGameConf.WriteInteger(LOGSERVERSECTIONNAME2, 'Port', g_Config.LogServer.Port);
  IniGameConf.WriteString(LOGSERVERSECTIONNAME2, 'BaseDir', '.\BaseDir\');

  sIniFile := g_sGameDirectory + 'LogServer\BaseDir\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  IniGameConf.Free;
end;

procedure TfrmMain.GenM2ServerConfig;
var
  IniGameConf: Tinifile;
  sIniFile: string;
  SaveList: TStringList;
begin
  sIniFile := g_sGameDirectory + 'Mir200\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  IniGameConf := Tinifile.Create(sIniFile + M2SERVERCONFIGFILE);
  IniGameConf.WriteString(M2SERVERSECTIONNAME1, 'ServerName', g_sGameName);
  IniGameConf.WriteString(M2SERVERSECTIONNAME1, 'DBName', g_sHeroDBName);
  IniGameConf.WriteString(M2SERVERSECTIONNAME1, 'GateAddr', sAllIPaddr);
  IniGameConf.WriteInteger(M2SERVERSECTIONNAME1, 'GatePort', g_Config.M2Server.GatePort);
  IniGameConf.WriteString(M2SERVERSECTIONNAME1, 'DBAddr', sLocalIPaddr);
  IniGameConf.WriteInteger(M2SERVERSECTIONNAME1, 'DBPort', g_Config.DBServer.ServerPort);
  IniGameConf.WriteString(M2SERVERSECTIONNAME1, 'IDSAddr', sLocalIPaddr);
  IniGameConf.WriteInteger(M2SERVERSECTIONNAME1, 'IDSPort', g_Config.LoginSrv.ServerPort);
  IniGameConf.WriteString(M2SERVERSECTIONNAME1, 'MsgSrvAddr', sAllIPaddr);
  IniGameConf.WriteInteger(M2SERVERSECTIONNAME1, 'MsgSrvPort', g_Config.M2Server.MsgSrvPort);
  IniGameConf.WriteString(M2SERVERSECTIONNAME1, 'LogServerAddr', sLocalIPaddr);
  IniGameConf.WriteInteger(M2SERVERSECTIONNAME1, 'LogServerPort', g_Config.LogServer.Port);
  IniGameConf.WriteBool(M2SERVERSECTIONNAME1, 'CloseWuXin', g_boCloseWuXin);

  IniGameConf.WriteString(M2SERVERSECTIONNAME2, 'GuildDir', '.\GuildBase\Guilds\');
  IniGameConf.WriteString(M2SERVERSECTIONNAME2, 'GuildFile', '.\GuildBase\GuildList.txt');
  IniGameConf.WriteString(M2SERVERSECTIONNAME2, 'ConLogDir', '.\ConLog\');
  IniGameConf.WriteString(M2SERVERSECTIONNAME2, 'CastleDir', '.\Castle\');
  IniGameConf.WriteString(M2SERVERSECTIONNAME2, 'CastleFile', '.\Castle\List.txt');
  IniGameConf.WriteString(M2SERVERSECTIONNAME2, 'GameDataDir', '.\Envir\');
  IniGameConf.WriteString(M2SERVERSECTIONNAME2, 'EnvirDir', '.\Envir\');
  IniGameConf.WriteString(M2SERVERSECTIONNAME2, 'MapDir', '.\Map\');
  IniGameConf.WriteString(M2SERVERSECTIONNAME2, 'NoticeDir', '.\Notice\');
  IniGameConf.WriteString(M2SERVERSECTIONNAME2, 'LogDir', '.\Log\');
  IniGameConf.WriteString(M2SERVERSECTIONNAME2, 'EMailDir', '.\EMail\');

  IniGameConf.Free;

  sIniFile := g_sGameDirectory + 'Mir200\' + 'GuildBase\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  sIniFile := g_sGameDirectory + 'Mir200\' + 'GuildBase\Guilds\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  sIniFile := g_sGameDirectory + 'Mir200\' + 'ConLog\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + 'Mir200\' + 'Castle\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + 'Mir200\' + 'Envir\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + 'Mir200\' + 'Map\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + 'Mir200\' + 'Notice\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + 'Mir200\' + 'Log\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + 'Mir200\' + 'EMail\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  sIniFile := g_sGameDirectory + 'Mir200\';
  SaveList := TStringList.Create;
  SaveList.Add(sLocalIPaddr);
  SaveList.SaveToFile(sIniFile + '!servertable.txt');
  SaveList.Free;
end;

procedure TfrmMain.GenLoginGateConfig;
var
  IniGameConf: Tinifile;
  sIniFile: string;
begin
  sIniFile := g_sGameDirectory + 'LoginGate\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  IniGameConf := Tinifile.Create(sIniFile + SERVERCONFIGFILE);
  IniGameConf.WriteString(LoginGateSectionName2, 'Title', g_sGameName);
  IniGameConf.WriteString(LoginGateSectionName2, 'ServerAddr', sLocalIPaddr);
  IniGameConf.WriteInteger(LoginGateSectionName2, 'ServerPort', g_Config.LoginSrv.GatePort);
  IniGameConf.WriteString(LoginGateSectionName2, 'GateAddr', sAllIPaddr);
  IniGameConf.WriteInteger(LoginGateSectionName2, 'GatePort', g_Config.LoginGate.GatePort);
  IniGameConf.Free;
end;

procedure TfrmMain.GenSelGateConfig();
var
  IniGameConf: Tinifile;
  sIniFile: string;
begin
  sIniFile := g_sGameDirectory + 'SelGate\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  IniGameConf := Tinifile.Create(sIniFile + SERVERCONFIGFILE);
  IniGameConf.WriteString(SelGateSectionName2, 'Title', g_sGameName);
  IniGameConf.WriteString(SelGateSectionName2, 'ServerAddr', sLocalIPaddr);
  IniGameConf.WriteInteger(SelGateSectionName2, 'ServerPort', g_Config.DBServer.GatePort);
  IniGameConf.WriteString(SelGateSectionName2, 'GateAddr', sAllIPaddr);
  IniGameConf.WriteInteger(SelGateSectionName2, 'GatePort', g_Config.SelGate.GatePort[0]);

  IniGameConf.Free;
end;

procedure TfrmMain.GenMutLoginGateConfig(nIndex: Integer);
var
  IniGameConf: Tinifile;
  sIniFile: string;
begin
  if (not (nIndex in [0, 1])) then exit;

  sIniFile := g_sGameDirectory + 'LoginGate\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  if g_boIP2 then begin
    IniGameConf := Tinifile.Create(sIniFile + SERVERCONFIGFILE);
    IniGameConf.WriteString(LoginGateSectionName2, 'Title', g_sGameName);
    IniGameConf.WriteInteger(LoginGateSectionName2, 'GatePort', g_Config.LoginGate.GatePort);
    if nIndex = 0 then begin
      IniGameConf.WriteString(LoginGateSectionName2, 'GateAddr', g_sExtIPaddr);
      IniGameConf.WriteString(LoginGateSectionName2, 'ServerAddr', sLocalIPaddr);
    end else begin
      IniGameConf.WriteString(LoginGateSectionName2, 'GateAddr', g_sExtIPaddr2);
      IniGameConf.WriteString(LoginGateSectionName2, 'ServerAddr', sLocalIPaddr2);
    end;
    IniGameConf.Free;
  end else begin
    IniGameConf := Tinifile.Create(sIniFile + SERVERCONFIGFILE);
    IniGameConf.WriteString(LoginGateSectionName2, 'Title', g_sGameName);
    IniGameConf.WriteString(LoginGateSectionName2, 'GateAddr', sAllIPaddr);
    IniGameConf.WriteInteger(LoginGateSectionName2, 'GatePort', g_Config.LoginGate.GatePort);
    IniGameConf.Free;
  end;
end;

procedure TfrmMain.GenMutSelGateConfig(nIndex: Integer);
var
  IniGameConf: Tinifile;
  sIniFile: string;
begin
  if (not (nIndex in [0, 1])) then exit;

  sIniFile := g_sGameDirectory + 'SelGate\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  if g_boIP2 then begin
    IniGameConf := Tinifile.Create(sIniFile + SERVERCONFIGFILE);
    IniGameConf.WriteString(SelGateSectionName2, 'Title', g_sGameName);
    IniGameConf.WriteString(SelGateSectionName2, 'GateAddr', sAllIPaddr);
    IniGameConf.WriteInteger(SelGateSectionName2, 'GatePort', g_Config.SelGate.GatePort[nIndex]);
    if nIndex = 0 then begin
      IniGameConf.WriteString(SelGateSectionName2, 'ServerAddr', sLocalIPaddr);
    end else begin
      IniGameConf.WriteString(SelGateSectionName2, 'ServerAddr', sLocalIPaddr2);
    end;
    IniGameConf.Free;
  end else begin
    IniGameConf := Tinifile.Create(sIniFile + SERVERCONFIGFILE);
    IniGameConf.WriteString(SelGateSectionName2, 'Title', g_sGameName);
    IniGameConf.WriteString(SelGateSectionName2, 'GateAddr', sAllIPaddr);
    IniGameConf.WriteInteger(SelGateSectionName2, 'GatePort', g_Config.SelGate.GatePort[nIndex]);
    IniGameConf.Free;
  end;
end;

procedure TfrmMain.GenRunGateConfig;
var
  IniGameConf: Tinifile;
  sIniFile: string;
begin
  sIniFile := g_sGameDirectory + 'RunGate\';
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  IniGameConf := Tinifile.Create(sIniFile + SERVERCONFIGFILE);
  IniGameConf.WriteString(RunGateSectionName2, 'Title', g_sGameName);
  IniGameConf.WriteString(RunGateSectionName2, 'ServerAddr', sLocalIPaddr);
  IniGameConf.WriteInteger(RunGateSectionName2, 'ServerPort', g_Config.M2Server.GatePort);
  IniGameConf.WriteString(RunGateSectionName2, 'GateAddr', sAllIPaddr);
  IniGameConf.WriteInteger(RunGateSectionName2, 'GatePort', g_Config.RunGate.GatePort[0]);
  IniGameConf.WriteString(RunGateSectionName2, 'CenterAddr', sLocalIPaddr);
  IniGameConf.WriteInteger(RunGateSectionName2, 'CenterPort', g_Config.LoginSrv.ServerPort);
  IniGameConf.Free;
end;

procedure TfrmMain.RefGameConsole;
begin
  m_boOpen := False;
  CheckBoxM2Server.Checked := g_Config.M2Server.GetStart;
  CheckBoxDBServer.Checked := g_Config.DBServer.GetStart;
  CheckBoxLoginServer.Checked := g_Config.LoginSrv.GetStart;
  CheckBoxLogServer.Checked := g_Config.LogServer.GetStart;
  CheckBoxLoginGate.Checked := g_Config.LoginGate.GetStart;
  CheckBoxSelGate.Checked := g_Config.SelGate.GetStart1;
  CheckBoxSelGate1.Checked := g_Config.SelGate.GetStart2;
  CheckBoxRunGate.Checked := g_Config.RunGate.GetStart[0];
  CheckBoxRunGate1.Checked := g_Config.RunGate.GetStart[1];
  CheckBoxRunGate2.Checked := g_Config.RunGate.GetStart[2];
  CheckBoxRunGate3.Checked := g_Config.RunGate.GetStart[3];
  CheckBoxRunGate4.Checked := g_Config.RunGate.GetStart[4];
  CheckBoxRunGate5.Checked := g_Config.RunGate.GetStart[5];
  CheckBoxRunGate6.Checked := g_Config.RunGate.GetStart[6];
  CheckBoxRunGate7.Checked := g_Config.RunGate.GetStart[7];
  
  EditGameDir.Text := g_sGameDirectory;
  EditHeroDB.Text := g_sHeroDBName;
  EditGameName.Text := g_sGameName;
  EditGameExtIPaddr.Text := g_sExtIPaddr;
  EditGameExtIPAddr2.Text := g_sExtIPAddr2;
  CheckBoxIP2.Checked := g_boIP2;
  CheckBoxCloseWuXin.Checked := g_boCloseWuXin;

  EditDBServer_MainFormX.Value := g_Config.DBServer.MainFormX;
  EditDBServer_MainFormY.Value := g_Config.DBServer.MainFormY;
  EditDBServerGatePort.Text := IntToStr(g_Config.DBServer.GatePort);
  EditDBServerServerPort.Text := IntToStr(g_Config.DBServer.ServerPort);
  CheckBoxDBServerGetStart.Checked := g_Config.DBServer.GetStart;

  EditLoginServer_MainFormX.Value := g_Config.LoginSrv.MainFormX;
  EditLoginServer_MainFormY.Value := g_Config.LoginSrv.MainFormY;
  EditLoginServerGatePort.Text := IntToStr(g_Config.LoginSrv.GatePort);
  EditLoginServerServerPort.Text := IntToStr(g_Config.LoginSrv.ServerPort);
  EditLoginServerMonPort.Text := IntToStr(g_Config.LoginSrv.MonPort);
  CheckBoxboLoginServer_GetStart.Checked := g_Config.LoginSrv.GetStart;

  EditM2Server_MainFormX.Value := g_Config.M2Server.MainFormX;
  EditM2Server_MainFormY.Value := g_Config.M2Server.MainFormY;
  EditM2ServerGatePort.Text := IntToStr(g_Config.M2Server.GatePort);
  EditM2ServerMsgSrvPort.Text := IntToStr(g_Config.M2Server.MsgSrvPort);
  CheckBoxM2ServerGetStart.Checked := g_Config.M2Server.GetStart;

  EditLogServer_MainFormX.Value := g_Config.LogServer.MainFormX;
  EditLogServer_MainFormY.Value := g_Config.LogServer.MainFormY;
  EditLogServerPort.Text := IntToStr(g_Config.LogServer.Port);
  CheckBoxLogServerGetStart.Checked := g_Config.LogServer.GetStart;

  //EditRunGate_Connt.Value := g_Config.RunGate.Count;
  CheckBoxboRunGate_GetStart1.Checked := g_Config.RunGate.GetStart[0];
  CheckBoxboRunGate_GetStart2.Checked := g_Config.RunGate.GetStart[1];
  CheckBoxboRunGate_GetStart3.Checked := g_Config.RunGate.GetStart[2];
  CheckBoxboRunGate_GetStart4.Checked := g_Config.RunGate.GetStart[3];
  CheckBoxboRunGate_GetStart5.Checked := g_Config.RunGate.GetStart[4];
  CheckBoxboRunGate_GetStart6.Checked := g_Config.RunGate.GetStart[5];
  CheckBoxboRunGate_GetStart7.Checked := g_Config.RunGate.GetStart[6];
  CheckBoxboRunGate_GetStart8.Checked := g_Config.RunGate.GetStart[7];
  EditRunGate_MainFormX.Value := g_Config.RunGate.MainFormX;
  EditRunGate_MainFormY.Value := g_Config.RunGate.MainFormY;
  EditRunGate_GatePort1.Text := IntToStr(g_Config.RunGate.GatePort[0]);
  EditRunGate_GatePort2.Text := IntToStr(g_Config.RunGate.GatePort[1]);
  EditRunGate_GatePort3.Text := IntToStr(g_Config.RunGate.GatePort[2]);
  EditRunGate_GatePort4.Text := IntToStr(g_Config.RunGate.GatePort[3]);
  EditRunGate_GatePort5.Text := IntToStr(g_Config.RunGate.GatePort[4]);
  EditRunGate_GatePort6.Text := IntToStr(g_Config.RunGate.GatePort[5]);
  EditRunGate_GatePort7.Text := IntToStr(g_Config.RunGate.GatePort[6]);
  EditRunGate_GatePort8.Text := IntToStr(g_Config.RunGate.GatePort[7]);

  EditSelGate_MainFormX.Value := g_Config.SelGate.MainFormX;
  EditSelGate_MainFormY.Value := g_Config.SelGate.MainFormY;
  CheckBoxboSelGate_GetStart.Checked := g_Config.SelGate.GetStart1;
  CheckBoxboSelGate_GetStart2.Checked := g_Config.SelGate.GetStart2;
  EditSelGate_GatePort.Text := IntToStr(g_Config.SelGate.GatePort[0]);
  EditSelGate_GatePort1.Text := IntToStr(g_Config.SelGate.GatePort[1]);

  EditLoginGate_MainFormX.Value := g_Config.LoginGate.MainFormX;
  EditLoginGate_MainFormY.Value := g_Config.LoginGate.MainFormY;
  CheckBoxboLoginGate_GetStart.Checked := g_Config.LoginGate.GetStart;
  EditLoginGate_GatePort.Text := IntToStr(g_Config.LoginGate.GatePort);

  m_boOpen := True;
end;

procedure TfrmMain.CheckBoxDBServerClick(Sender: TObject);
begin
  g_Config.DBServer.GetStart := CheckBoxDBServer.Checked;
end;

procedure TfrmMain.CheckBoxLoginServerClick(Sender: TObject);
begin
  g_Config.LoginSrv.GetStart := CheckBoxLoginServer.Checked;
end;

procedure TfrmMain.CheckBoxM2ServerClick(Sender: TObject);
begin
  g_Config.M2Server.GetStart := CheckBoxM2Server.Checked;
end;

procedure TfrmMain.CheckBoxLogServerClick(Sender: TObject);
begin
  g_Config.LogServer.GetStart := CheckBoxLogServer.Checked;
end;

procedure TfrmMain.CheckBoxLoginGateClick(Sender: TObject);
begin
  g_Config.LoginGate.GetStart := CheckBoxLoginGate.Checked;
end;

procedure TfrmMain.CSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  btDataListAll.Enabled := False;
  btDataListSelect.Enabled := False;
  btDataListList.Enabled := False;
  if g_DataListReadBuffer <> nil then
    FreeMem(g_DataListReadBuffer);
  g_DataListReadBuffer := nil;
  g_nDataListReadLength := 0;
  MainOutDataListMessage('连接远程服务器成功...');
  MainOutDataListMessage('正在验证连接密码...');
  if not SendDataListData(SEC_CHECKPASS, g_sDataListPassWord) then begin
    MainOutDataListMessage('发送验证连接密码失败...');
    Socket.Close;
  end;
end;

procedure TfrmMain.CSocketConnecting(Sender: TObject; Socket: TCustomWinSocket);
begin
  MainOutDataListMessage('正在连接远程服务器...');
  btDataListAll.Enabled := False;
  btDataListSelect.Enabled := False;
  btDataListList.Enabled := False;
end;

procedure TfrmMain.CSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  btDataListAll.Enabled := True;
  btDataListSelect.Enabled := True;
  btDataListList.Enabled := True;
  if g_DataListReadBuffer <> nil then
    FreeMem(g_DataListReadBuffer);
  g_DataListReadBuffer := nil;
  g_nDataListReadLength := 0;
  //MainOutDataListMessage('与远程服务器断开连接...');
end;

procedure TfrmMain.CSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
  MainOutDataListMessage('连接远程服务器失败...');
end;

procedure TfrmMain.CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  nMsgLen: Integer;
  RecvBuffer: PChar;
  Buff, TempBuff: PChar;
  nLen: Integer;
  DefMessage: pTDefMessage;
  Item: TListItem;
  DataListInfo: pTDataListInfo;
begin
  nMsgLen := Socket.ReceiveLength;
  GetMem(RecvBuffer, nMsgLen);
  nMsgLen := Socket.ReceiveBuf(RecvBuffer^, nMsgLen);
  ReallocMem(g_DataListReadBuffer, g_nDataListReadLength + nMsgLen);
  Move(RecvBuffer^, g_DataListReadBuffer[g_nDataListReadLength], nMsgLen);
  Inc(g_nDataListReadLength, nMsgLen);
  FreeMem(RecvBuffer);

  Buff := g_DataListReadBuffer;
  nLen := g_nDataListReadLength;
  while (True) do begin
    if nLen >= SizeOf(TDefMessage) then begin
      DefMessage := pTDefMessage(Buff);
      if DefMessage.Recog = MSGHEADCODE then begin
        if (DefMessage.DataSize + SizeOf(TDefMessage)) > nLen then begin
          if DefMessage.Ident = SES_FILE then begin
            if GetTickCount > m_dwRefTick then begin
              m_dwRefTick := GetTickCount + 500;
              if (g_GetDatList.Count > 0) and (Integer(g_GetDatList.Objects[0]) = DefMessage.Param) then begin
                DataListInfo := pTDataListInfo(g_GetDatList.Objects[0]);

                Item := DataListInfo.Item;
                Item.SubItems.Strings[0] := FormatDateTime('yyyy-mm-dd hh:mm:ss', DefMessage.DataTime);
                Item.SubItems.Strings[1] := IntToStr(DefMessage.DataSize);
                Item.SubItems.Strings[2] := IntToStr(Round((nLen - SizeOf(TDefMessage)) / DefMessage.DataSize * 100)) + '%';
              end;
            end;
          end;
          break;
        end;
        case DefMessage.Ident of
          SES_CHECKPASS_OK: begin
              if g_GetDatList.Count = 0 then begin
                MainOutDataListMessage('正在获取数据列表...');
                if not SendDataListData(SEC_GETFILELIST, 'TEST') then begin
                  MainOutDataListMessage('发送获取数据列表失败...');
                  Socket.Close;
                  Exit;
                end;
              end else begin
                if g_GetDatList.Objects[0] <> nil then begin
                  GetNextData;
                end else begin
                  Socket.Close;
                  Exit;
                end;
              end;
            end;
          SES_CHECKPASS_FAIR: begin
              MainOutDataListMessage('密码验证失败...');
              Socket.Close;
              Exit;
            end;
          SES_FILELIST: begin
              if DefMessage.DataSize > 0 then begin
                TempBuff := PChar(@Buff[SizeOf(TDefMessage)]);
                g_GetDatList.SetText(TempBuff);
                if (g_GetDatList.Count > 0) then begin
                  if not RefDataListItem then begin
                    Socket.Close;
                    Exit;
                  end;
                end else begin
                  MainOutDataListMessage('没有可更新的数据列表...');
                  Socket.Close;
                  Exit;
                end;
              end else begin
                MainOutDataListMessage('没有可更新的数据列表...');
                Socket.Close;
                Exit;
              end;
            end;
          SES_FILE: begin
              if (g_GetDatList.Count > 0) and (Integer(g_GetDatList.Objects[0]) = DefMessage.Param) then begin
                DataListInfo := pTDataListInfo(g_GetDatList.Objects[0]);
                Item := DataListInfo.Item;
                TempBuff := PChar(@Buff[SizeOf(TDefMessage)]);
                Dec(nLen, SizeOf(TDefMessage));
                if (DefMessage.DataSize > 0) and (nLen >= DefMessage.DataSize) then begin
                  if DataListInfo.MapFileBuffer <> nil then
                    UnMapViewOfFile(DataListInfo.MapFileBuffer);
                  if DataListInfo.MapFileHandle <> 0 then
                    CloseHandle(DataListInfo.MapFileHandle);
                  DataListInfo.MapFileBuffer := nil;
                  DataListInfo.MapFileHandle := 0;
                  ReallocMem(DataListInfo.Data, nLen);
                  Move(TempBuff^, DataListInfo.Data^, nLen);
                  DataListInfo.DateTime := DefMessage.DataTime;
                  DataListInfo.DataSize := DefMessage.DataSize;
                  Item.SubItems.Strings[0] := FormatDateTime('yyyy-mm-dd hh:mm:ss', DefMessage.DataTime);
                  Item.SubItems.Strings[1] := IntToStr(DefMessage.DataSize);
                  Item.SubItems.Strings[2] := '完成';
                end else begin
                  if (DefMessage.DataTime > 0) and (nLen >= DefMessage.DataSize) then begin
                    DataListInfo.DateTime := DefMessage.DataTime;
                    Item.SubItems.Strings[0] := FormatDateTime('yyyy-mm-dd hh:mm:ss', DefMessage.DataTime);
                    Item.SubItems.Strings[1] := IntToStr(DataListInfo.DataSize);
                    Item.SubItems.Strings[2] := '完成';
                  end else begin
                    MainOutDataListMessage('更新文件[' + g_GetDatList[0] + ']失败...');
                    Item.SubItems.Strings[2] := '失败';
                  end;
                end;
                g_GetDatList.Delete(0);
                if not GetNextData then begin
                  Socket.Close;
                  Exit;
                end;
              end;
            end;
        end;
        FreeMem(g_DataListReadBuffer);
        g_DataListReadBuffer := nil;
        g_nDataListReadLength := 0;
        nLen := 0;
        break;
      end
      else begin
        Inc(Buff);
        Dec(nLen);
      end;
    end
    else
      break;
  end;
  if nLen > 0 then begin
    if g_nDataListReadLength = nLen then
      exit;
    GetMem(TempBuff, nLen);
    Move(Buff^, TempBuff^, nLen);
    FreeMem(g_DataListReadBuffer);
    g_DataListReadBuffer := TempBuff;
    g_nDataListReadLength := nLen;
  end
  else begin
    if g_DataListReadBuffer <> nil then
      FreeMem(g_DataListReadBuffer);
    g_DataListReadBuffer := nil;
    g_nDataListReadLength := 0;
  end;
end;

procedure TfrmMain.CheckBoxRunGateClick(Sender: TObject);
begin
  with Sender as TCheckBox do begin
    if Tag in [Low(g_Config.RunGate.GetStart)..High(g_Config.RunGate.GetStart)] then
      g_Config.RunGate.GetStart[Tag] := Checked;
  end;
end;

procedure TfrmMain.ButtonStartGameClick(Sender: TObject);
begin
  SetWindowPos(Self.Handle, Self.Handle, Self.Left, Self.Top, Self.Width, Self.Height, $40);
  case m_nStartStatus of
    0: begin
        if Application.MessageBox('是否确认启动游戏服务器 ?',
          '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
          //if g_boGetDataListOK then begin
            StartGame();
          //end;
        end;
      end;
    1: begin
        if Application.MessageBox('是否确认中止启动游戏服务器 ?',
          '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
          TimerStartGame.Enabled := False;
          m_nStartStatus := 2;
          ButtonStartGame.Caption := g_sButtonStopGame;
        end;
      end;
    2: begin
        if Application.MessageBox('是否确认停止游戏服务器 ?',
          '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
          StopGame();
        end;
      end;
    3: begin
        if Application.MessageBox('是否确认中止启动游戏服务器 ?',
          '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
          TimerStopGame.Enabled := False;
          m_nStartStatus := 2;
          ButtonStartGame.Caption := g_sButtonStopGame;
        end;
      end;
  end;
  {
  if CreateProcess(nil,
                   PChar(sProgamFile),
                   nil,
                   nil,
                   False,
                   IDLE_PRIORITY_CLASS,
                   nil,
                   nil,
                   StartUpInfo,
                   ProcessInfo) then begin
  }
end;

function TfrmMain.SendDataListData(wIdent: Word; sData: string): Boolean;
var
  DefMessage: TDefMessage;
  SendBuffer: PChar;
  nSendCount: Integer;
  nWaitTick: LongWord;
  nMsgLen: Integer;
begin
  Result := False;
  sData := GetMD5TextOf16(Trim(sData));
  nMsgLen := Length(sData) + 1;
  DefMessage := MakeDefMessage(wIdent, 0, Now, nMsgLen);
  SendBuffer := AllocMem(SizeOf(TDefMessage) + nMsgLen);
  try
    Move(DefMessage, SendBuffer^, SizeOf(TDefMessage));
    Move(sData[1], SendBuffer[SizeOf(TDefMessage)], nMsgLen);
    nSendCount := 0;
    while CSocket.Active and (CSocket.Socket.SendBuf(SendBuffer^, SizeOf(TDefMessage) + nMsgLen) = -1) do begin
      Inc(nSendCount);
      if nSendCount > 10 then
        exit;
      nWaitTick := GetTickCount + 1000;
      while GetTickCount < nWaitTick do begin
        Application.ProcessMessages;
        Sleep(1);
      end;
    end;
    Result := True;
  finally
    FreeMem(SendBuffer);
  end;
end;

procedure TfrmMain.StartGame;
var
  //  nRetCode: Integer;
  I: Integer;
begin
  m_dwRunTick := GetTickCount;
  FillChar(DBServer, SizeOf(TProgram), #0);
  DBServer.boGetStart := g_Config.DBServer.GetStart;
  DBServer.boReStart := True;
  DBServer.sDirectory := g_sGameDirectory + 'DBServer\';
  DBServer.sProgramFile := g_Config.DBServer.ProgramFile;
  DBServer.nMainFormX := g_Config.DBServer.MainFormX;
  DBServer.nMainFormY := g_Config.DBServer.MainFormY;

  FillChar(LoginServer, SizeOf(TProgram), #0);
  LoginServer.boGetStart := g_Config.LoginSrv.GetStart;
  LoginServer.boReStart := True;
  LoginServer.sDirectory := g_sGameDirectory + 'LoginSrv\';
  LoginServer.sProgramFile := g_Config.LoginSrv.ProgramFile;
  LoginServer.nMainFormX := g_Config.LoginSrv.MainFormX;
  LoginServer.nMainFormY := g_Config.LoginSrv.MainFormY;

  FillChar(LogServer, SizeOf(TProgram), #0);
  LogServer.boGetStart := g_Config.LogServer.GetStart;
  LogServer.boReStart := True;
  LogServer.sDirectory := g_sGameDirectory + 'LogServer\';
  LogServer.sProgramFile := g_Config.LogServer.ProgramFile;
  LogServer.nMainFormX := g_Config.LogServer.MainFormX;
  LogServer.nMainFormY := g_Config.LogServer.MainFormY;

  FillChar(M2Server, SizeOf(TProgram), #0);
  M2Server.boGetStart := g_Config.M2Server.GetStart;
  M2Server.boReStart := True;
  M2Server.sDirectory := g_sGameDirectory + 'Mir200\';
  M2Server.sProgramFile := g_Config.M2Server.ProgramFile;
  M2Server.nMainFormX := g_Config.M2Server.MainFormX;
  M2Server.nMainFormY := g_Config.M2Server.MainFormY;

  FillChar(RunGate, SizeOf(RunGate), #0);
  for I := Low(RunGate) to High(RunGate) do begin
    RunGate[I].btStartStatus := 0;
    RunGate[I].boGetStart := g_Config.RunGate.GetStart[I];
    RunGate[I].boReStart := True;
    RunGate[I].sDirectory := g_sGameDirectory + 'RunGate\';
    RunGate[I].sProgramFile := g_Config.RunGate.ProgramFile;
    if ((I + 1) mod 2) = 0 then
      RunGate[I].nMainFormX := g_Config.RunGate.MainFormX + 276
    else
      RunGate[I].nMainFormX := g_Config.RunGate.MainFormX;
    if I in [2, 3, 6, 7] then
      RunGate[I].nMainFormY := g_Config.RunGate.MainFormY + 187
    else
      RunGate[I].nMainFormY := g_Config.RunGate.MainFormY; //187
  end;

  FillChar(SelGate, SizeOf(TProgram), #0);
  SelGate.boGetStart := g_Config.SelGate.GetStart1;
  SelGate.boReStart := True;
  SelGate.sDirectory := g_sGameDirectory + 'SelGate\';
  SelGate.sProgramFile := g_Config.SelGate.ProgramFile;
  SelGate.nMainFormX := g_Config.SelGate.MainFormX;
  SelGate.nMainFormY := g_Config.SelGate.MainFormY;

  FillChar(SelGate1, SizeOf(TProgram), #0);
  SelGate1.boGetStart := g_Config.SelGate.GetStart2;
  SelGate1.boReStart := True;
  SelGate1.sDirectory := g_sGameDirectory + 'SelGate\';
  SelGate1.sProgramFile := g_Config.SelGate.ProgramFile;
  SelGate1.nMainFormX := g_Config.SelGate.MainFormX;
  SelGate1.nMainFormY := g_Config.SelGate.MainFormY;

  FillChar(LoginGate, SizeOf(TProgram), #0);
  LoginGate.boGetStart := g_Config.LoginGate.GetStart;
  LoginGate.boReStart := True;
  LoginGate.sDirectory := g_sGameDirectory + 'LoginGate\';
  LoginGate.sProgramFile := g_Config.LoginGate.ProgramFile;
  LoginGate.nMainFormX := g_Config.LoginGate.MainFormX;
  LoginGate.nMainFormY := g_Config.LoginGate.MainFormY;

  FillChar(LoginGate2, SizeOf(TProgram), #0);
  LoginGate2.boGetStart := g_Config.LoginGate.GetStart and g_boIP2;
  LoginGate2.boReStart := True;
  LoginGate2.sDirectory := g_sGameDirectory + 'LoginGate\';
  LoginGate2.sProgramFile := g_Config.LoginGate.ProgramFile;
  LoginGate2.nMainFormX := g_Config.LoginGate.MainFormX;
  LoginGate2.nMainFormY := g_Config.LoginGate.MainFormY;



  CheckDBServer.Checked := DBServer.boGetStart;
  CheckLoginSrv.Checked := LoginServer.boGetStart;
  CheckM2Server.Checked := M2Server.boGetStart;
  CheckLogServer.Checked := LogServer.boGetStart;
  CheckLoginGate.Checked := LoginGate.boGetStart;
  CheckSelGate1.Checked := SelGate.boGetStart;
  CheckSelGate2.Checked := SelGate1.boGetStart;
  CheckRunGate1.Checked := RunGate[0].boGetStart;
  CheckRunGate2.Checked := RunGate[1].boGetStart;
  CheckRunGate3.Checked := RunGate[2].boGetStart;
  CheckRunGate4.Checked := RunGate[3].boGetStart;
  CheckRunGate5.Checked := RunGate[4].boGetStart;
  CheckRunGate6.Checked := RunGate[5].boGetStart;
  CheckRunGate7.Checked := RunGate[6].boGetStart;
  CheckRunGate8.Checked := RunGate[7].boGetStart;

  ButtonStartGame.Caption := g_sButtonStopStartGame;
  m_nStartStatus := 1;
  TimerStartGame.Enabled := True;
end;

procedure TfrmMain.StopGame;
begin
  ButtonStartGame.Caption := g_sButtonStopStopGame;
  MainOutMessage('正在开始停止服务器...');
  TimerCheckRun.Enabled := False;
  TimerStopGame.Enabled := True;
  m_boGateStop := False;
  m_nStartStatus := 3;
end;

procedure TfrmMain.TimerStartGameTimer(Sender: TObject);
  function GetStartRunGate: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := Low(RunGate) to High(RunGate) do begin
      if RunGate[I].boGetStart and (RunGate[I].btStartStatus = 1) then begin
        Result := True;
        break;
      end;
    end;
  end;
var
  nRetCode: Integer;
  I: Integer;
  boStartRunGateOK: Boolean;
  wHour, wMin, wSec, wMSec: Word;
begin
  if DBServer.boGetStart then begin
    case DBServer.btStartStatus of
      0: begin
          nRetCode := RunProgram(DBServer, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            DBServer.btStartStatus := 1;
            DBServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, DBServer.ProcessInfo.dwProcessId);
          end
          else begin
            //ShowMessage(IntToStr(nRetCode));
          end;
          Exit;
        end;
      1: begin //如果状态为1 则还没启动完成
          //        DBServer.btStartStatus:=2;
          Exit;
        end;
    end;
  end;
  if LoginServer.boGetStart then begin
    case LoginServer.btStartStatus of //
      0: begin
          nRetCode := RunProgram(LoginServer, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            LoginServer.btStartStatus := 1;
            LoginServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LoginServer.ProcessInfo.dwProcessId);
          end
          else begin
            LoginServer.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          Exit;
        end;
      1: begin //如果状态为1 则还没启动完成
          //        LoginServer.btStartStatus:=2;
          Exit;
        end;
    end;
  end;

  if LogServer.boGetStart then begin
    case LogServer.btStartStatus of //
      0: begin
          nRetCode := RunProgram(LogServer, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            LogServer.btStartStatus := 1;
            LogServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LogServer.ProcessInfo.dwProcessId);
          end
          else begin
            LogServer.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          Exit;
        end;
      1: begin //如果状态为1 则还没启动完成
          //        LogServer.btStartStatus:=2;
          Exit;
        end;
    end;
  end;

  if M2Server.boGetStart then begin
    case M2Server.btStartStatus of //
      0: begin
          nRetCode := RunProgram(M2Server, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            M2Server.btStartStatus := 1;
            M2Server.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, M2Server.ProcessInfo.dwProcessId);
          end
          else begin
            M2Server.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          Exit;
        end;
      1: begin //如果状态为1 则还没启动完成
          //        M2Server.btStartStatus:=2;
          Exit;
        end;
    end;
  end;

  if GetStartRunGate then
    Exit; //有网关正在启动等待
    
  boStartRunGateOK := True;
  for I := Low(RunGate) to High(RunGate) do begin
    if RunGate[I].boGetStart then begin
      if RunGate[I].btStartStatus = 0 then begin
        GetMutRunGateConfing(I);
        nRetCode := RunProgram(RunGate[I], IntToStr(Self.Handle), 0);
        if nRetCode = 0 then begin
          RunGate[I].btStartStatus := 1;
          RunGate[I].ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate[I].ProcessInfo.dwProcessId);
        end
        else begin
          RunGate[I].btStartStatus := 9;
        end;
        boStartRunGateOK := False;
        break;
      end;
    end;
  end;
  if not boStartRunGateOK then
    Exit;

  if SelGate.boGetStart then begin
    case SelGate.btStartStatus of //
      0: begin
          GenMutSelGateConfig(0);
          nRetCode := RunProgram(SelGate, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            SelGate.btStartStatus := 1;
            SelGate.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, SelGate.ProcessInfo.dwProcessId);
          end
          else begin
            SelGate.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          Exit;
        end;
      1: begin //如果状态为1 则还没启动完成
          //        SelGate.btStartStatus:=2;
          Exit;
        end;
    end;
  end;

  if SelGate1.boGetStart then begin
    case SelGate1.btStartStatus of //
      0: begin
          GenMutSelGateConfig(1);
          nRetCode := RunProgram(SelGate1, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            SelGate1.btStartStatus := 1;
            SelGate1.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, SelGate1.ProcessInfo.dwProcessId);
          end
          else begin
            SelGate1.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          Exit;
        end;
      1: begin //如果状态为1 则还没启动完成
          //        SelGate1.btStartStatus:=2;
          Exit;
        end;
    end;
  end;
  if ComboBoxRunStatus.ItemIndex = 1 then begin
    if (GetTickCount - m_dwRunTick) < m_dwRunTime then
      exit;
  end else
  if ComboBoxRunStatus.ItemIndex = 2 then begin
    DecodeTime(Time, wHour, wMin, wSec, wMSec);
    if (wHour <> m_btHour) or (wMin <> m_btMinute) then
      exit;
  end;
  if LoginGate.boGetStart then begin
    case LoginGate.btStartStatus of //
      0: begin
          GenMutLoginGateConfig(0);
          nRetCode := RunProgram(LoginGate, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            LoginGate.btStartStatus := 1;
            LoginGate.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LoginGate.ProcessInfo.dwProcessId);
          end
          else begin
            LoginGate.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          Exit;
        end;
      1: begin //如果状态为1 则还没启动完成
          //        LoginGate.btStartStatus:=2;
          Exit;
        end;
    end;
  end;
  if LoginGate2.boGetStart then begin
    case LoginGate2.btStartStatus of //
      0: begin
          GenMutLoginGateConfig(1);
          nRetCode := RunProgram(LoginGate2, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            LoginGate2.btStartStatus := 1;
            LoginGate2.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LoginGate2.ProcessInfo.dwProcessId);
          end
          else begin
            LoginGate2.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          Exit;
        end;
      1: begin //如果状态为1 则还没启动完成
          //        LoginGate2.btStartStatus:=2;
          Exit;
        end;
    end;
  end;

  TimerStartGame.Enabled := False;
  TimerCheckRun.Enabled := True;
  ButtonStartGame.Caption := g_sButtonStopGame;
  //  ButtonStartGame.Enabled:=True;
  m_nStartStatus := 2;
  //  SetWindowPos(Self.Handle,HWND_TOPMOST,Self.Left,Self.Top,Self.Width,Self.Height,$40);
end;

procedure TfrmMain.TimerStopGameTimer(Sender: TObject);
  function GetStopRunGate: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := Low(RunGate) to High(RunGate) do begin
      if RunGate[I].boGetStart and (RunGate[I].btStartStatus in [2, 3]) then begin
        Result := True;
        break;
      end;
    end;
  end;
var
  dwExitCode: LongWord;
  //  nRetCode: Integer;
  I: Integer;
begin
  if LoginGate.boGetStart and (LoginGate.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(LoginGate.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if LoginGate.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(LoginGate, 0);
          MainOutMessage('正常关闭超时，登录网关一已被强行停止...');
        end;
        Exit; //如果正在关闭则等待，不处理下面
      end;
      SendProgramMsg(LoginGate.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      LoginGate.btStartStatus := 3;
      Exit;
    end
    else begin
      CloseHandle(LoginGate.ProcessHandle);
      LoginGate.btStartStatus := 0;
      MainOutMessage('登录网关一已停止...');
    end;
  end;

  if LoginGate2.boGetStart and (LoginGate2.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(LoginGate2.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if LoginGate2.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(LoginGate2, 0);
          MainOutMessage('正常关闭超时，登录网关二已被强行停止...');
        end;
        Exit; //如果正在关闭则等待，不处理下面
      end;
      SendProgramMsg(LoginGate2.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      LoginGate2.btStartStatus := 3;
      Exit;
    end
    else begin
      CloseHandle(LoginGate2.ProcessHandle);
      LoginGate2.btStartStatus := 0;
      MainOutMessage('登录网关二已停止...');
    end;
  end;

  if SelGate.boGetStart and (SelGate.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(SelGate.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if SelGate.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(SelGate, 0);
          MainOutMessage('正常关闭超时，角色网关一已被强行停止...');
        end;
        Exit; //如果正在关闭则等待，不处理下面
      end;
      SendProgramMsg(SelGate.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      SelGate.btStartStatus := 3;
      Exit;
    end
    else begin
      CloseHandle(SelGate.ProcessHandle);
      SelGate.btStartStatus := 0;
      MainOutMessage('角色网关一已停止...');
    end;
  end;

  if SelGate1.boGetStart and (SelGate1.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(SelGate1.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if SelGate1.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(SelGate1, 0);
          MainOutMessage('正常关闭超时，角色网关二已被强行停止...');
        end;
        Exit; //如果正在关闭则等待，不处理下面
      end;
      SendProgramMsg(SelGate1.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      SelGate1.btStartStatus := 3;
      Exit;
    end
    else begin
      CloseHandle(SelGate1.ProcessHandle);
      SelGate1.btStartStatus := 0;
      MainOutMessage('角色网关二已停止...');
    end;
  end;

  for I := Low(RunGate) to High(RunGate) do begin
    if RunGate[I].boGetStart and (RunGate[I].btStartStatus in [2, 3]) then begin
      GetExitCodeProcess(RunGate[I].ProcessHandle, dwExitCode);
      if dwExitCode = STILL_ACTIVE then begin
        if RunGate[I].btStartStatus = 3 then begin
          if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
            StopProgram(RunGate[I], 0);
            case I of
              0:
                MainOutMessage('正常关闭超时，游戏网关一已被强行停止...');
              1:
                MainOutMessage('正常关闭超时，游戏网关二已被强行停止...');
              2:
                MainOutMessage('正常关闭超时，游戏网关三已被强行停止...');
              3:
                MainOutMessage('正常关闭超时，游戏网关四已被强行停止...');
              4:
                MainOutMessage('正常关闭超时，游戏网关五已被强行停止...');
              5:
                MainOutMessage('正常关闭超时，游戏网关六已被强行停止...');
              6:
                MainOutMessage('正常关闭超时，游戏网关七已被强行停止...');
              7:
                MainOutMessage('正常关闭超时，游戏网关八已被强行停止...');
            end;
          end;
          break; //如果正在关闭则等待，不处理下面
        end;
        SendProgramMsg(RunGate[I].MainFormHandle, GS_QUIT, '');
        g_dwStopTick := GetTickCount();
        RunGate[I].btStartStatus := 3;
        break;
      end
      else begin
        CloseHandle(RunGate[I].ProcessHandle);
        RunGate[I].btStartStatus := 0;
        case I of
          0: MainOutMessage('游戏网关一已停止...');
          1: MainOutMessage('游戏网关二已停止...');
          2: MainOutMessage('游戏网关三已停止...');
          3: MainOutMessage('游戏网关四已停止...');
          4: MainOutMessage('游戏网关五已停止...');
          5: MainOutMessage('游戏网关六已停止...');
          6: MainOutMessage('游戏网关七已停止...');
          7: MainOutMessage('游戏网关八已停止...');
        end;
        break;
      end;
    end;
  end;

  if GetStopRunGate then begin
    m_boGateStop := False;
    Exit;
  end;

  if M2Server.boGetStart and (M2Server.btStartStatus in [2, 3]) then begin
    if not m_boGateStop then begin
      m_boGateStop := True;
      m_boGateStopTick := GetTickCount + 5000;
      MainOutMessage('网关已全部关闭，延时5秒关闭游戏引擎...');
      Exit;
    end;
    if GetTickCount < m_boGateStopTick then exit;

    GetExitCodeProcess(M2Server.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if M2Server.btStartStatus = 3 then begin
        {if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(M2Server, 1000);
          MainOutMessage('正常关闭超时，游戏引擎主程序已被强行停止...');
        end;    }
        Exit; //如果正在关闭则等待，不处理下面
      end;
      SendProgramMsg(M2Server.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      M2Server.btStartStatus := 3;
      Exit;
    end
    else begin
      CloseHandle(M2Server.ProcessHandle);
      M2Server.btStartStatus := 0;
      MainOutMessage('游戏引擎主程序已停止...');
    end;
  end;

  if LoginServer.boGetStart and (LoginServer.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(LoginServer.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if LoginServer.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(LoginServer, 1000);
          MainOutMessage('正常关闭超时，游戏引擎主程序已被强行停止...');
        end;
        Exit; //如果正在关闭则等待，不处理下面
      end;
      SendProgramMsg(LoginServer.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      LoginServer.btStartStatus := 3;
      Exit;
    end
    else begin
      CloseHandle(LoginServer.ProcessHandle);
      LoginServer.btStartStatus := 0;
      MainOutMessage('登录服务器已停止...');
    end;
  end;

  if LogServer.boGetStart and (LogServer.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(LogServer.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if LogServer.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(LogServer, 0);
          MainOutMessage('正常关闭超时，游戏引擎主程序已被强行停止...');
        end;
        Exit; //如果正在关闭则等待，不处理下面
      end;
      SendProgramMsg(LogServer.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      LogServer.btStartStatus := 3;
      Exit;
    end
    else begin
      CloseHandle(LogServer.ProcessHandle);
      LogServer.btStartStatus := 0;
      MainOutMessage('游戏日志服务器已停止...');
    end;
  end;

  if DBServer.boGetStart and (DBServer.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(DBServer.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if DBServer.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(DBServer, 0);
          MainOutMessage('正常关闭超时，游戏引擎主程序已被强行停止...');
        end;
        Exit; //如果正在关闭则等待，不处理下面
      end;
      SendProgramMsg(DBServer.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      DBServer.btStartStatus := 3;
      Exit;
    end
    else begin
      CloseHandle(DBServer.ProcessHandle);
      DBServer.btStartStatus := 0;
      MainOutMessage('游戏数据库服务器已停止...');
    end;
  end;
  TimerStopGame.Enabled := False;
  ButtonStartGame.Caption := g_sButtonStartGame;
  m_nStartStatus := 0;
end;

procedure TfrmMain.TimerCheckRunTimer(Sender: TObject);
var
  dwExitCode: LongWord;
  nRetCode: Integer;
  I: Integer;
begin
  if DBServer.boGetStart then begin
    GetExitCodeProcess(DBServer.ProcessHandle, dwExitCode);
    if (dwExitCode <> STILL_ACTIVE) or (DBServer.ProcessHandle = 0) then begin
      nRetCode := RunProgram(DBServer, IntToStr(Self.Handle), 0);

      if nRetCode = 0 then begin
        CloseHandle(DBServer.ProcessHandle);
        DBServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, DBServer.ProcessInfo.dwProcessId);
        if DBServer.MainFormHandle <> 0 then
          MainOutMessage('数据库异常关闭，已被重新启动...');
        DBServer.MainFormHandle := 0;
      end;
    end;
  end;

  if LoginServer.boGetStart then begin
    GetExitCodeProcess(LoginServer.ProcessHandle, dwExitCode);
    if (dwExitCode <> STILL_ACTIVE) or (LoginServer.ProcessHandle = 0) then begin
      nRetCode := RunProgram(LoginServer, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(LoginServer.ProcessHandle);
        LoginServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LoginServer.ProcessInfo.dwProcessId);
        if LoginServer.MainFormHandle <> 0 then
          MainOutMessage('登录服务器异常关闭，已被重新启动...');
        LoginServer.MainFormHandle := 0;
      end;
    end;
  end;

  if LogServer.boGetStart then begin
    GetExitCodeProcess(LogServer.ProcessHandle, dwExitCode);
    if (dwExitCode <> STILL_ACTIVE) or (LogServer.ProcessHandle = 0) then begin
      nRetCode := RunProgram(LogServer, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(LogServer.ProcessHandle);
        LogServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LogServer.ProcessInfo.dwProcessId);
        if LogServer.MainFormHandle <> 0 then
          MainOutMessage('日志服务器异常关闭，已被重新启动...');
        LogServer.MainFormHandle := 0;
      end;
    end;
  end;

  if M2Server.boGetStart then begin
    GetExitCodeProcess(M2Server.ProcessHandle, dwExitCode);
    if (dwExitCode <> STILL_ACTIVE) or (M2Server.ProcessHandle = 0) then begin
      nRetCode := RunProgram(M2Server, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(M2Server.ProcessHandle);
        M2Server.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, M2Server.ProcessInfo.dwProcessId);
        if M2Server.MainFormHandle <> 0 then
          MainOutMessage('游戏引擎服务器异常关闭，已被重新启动...');
        M2Server.MainFormHandle := 0;
      end;
    end;
  end;

  for I := Low(RunGate) to High(RunGate) do begin
    if RunGate[I].boGetStart then begin
      GetExitCodeProcess(RunGate[I].ProcessHandle, dwExitCode);
      if (dwExitCode <> STILL_ACTIVE) or (RunGate[I].ProcessHandle = 0) then begin
        GetMutRunGateConfing(I);
        nRetCode := RunProgram(RunGate[I], IntToStr(Self.Handle), 0);
        if nRetCode = 0 then begin
          CloseHandle(RunGate[I].ProcessHandle);
          RunGate[I].ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate[I].ProcessInfo.dwProcessId);
          if RunGate[I].MainFormHandle <> 0 then begin
            case I of
              0:
                MainOutMessage('游戏网关一异常关闭，已被重新启动...');
              1:
                MainOutMessage('游戏网关二异常关闭，已被重新启动...');
              2:
                MainOutMessage('游戏网关三异常关闭，已被重新启动...');
              3:
                MainOutMessage('游戏网关四异常关闭，已被重新启动...');
              4:
                MainOutMessage('游戏网关五异常关闭，已被重新启动...');
              5:
                MainOutMessage('游戏网关六异常关闭，已被重新启动...');
              6:
                MainOutMessage('游戏网关七异常关闭，已被重新启动...');
              7:
                MainOutMessage('游戏网关八异常关闭，已被重新启动...');
            end;
          end;
          RunGate[I].MainFormHandle := 0;
        end;
        break;
      end;
    end;
  end;

  if SelGate.boGetStart then begin
    GetExitCodeProcess(SelGate.ProcessHandle, dwExitCode);
    if (dwExitCode <> STILL_ACTIVE) or (SelGate.ProcessHandle = 0) then begin
      GenMutSelGateConfig(0);
      nRetCode := RunProgram(SelGate, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(SelGate.ProcessHandle);
        SelGate.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, SelGate.ProcessInfo.dwProcessId);
        if SelGate.MainFormHandle <> 0 then
          MainOutMessage('角色网关一异常关闭，已被重新启动...');
        SelGate.MainFormHandle := 0;
      end;
    end;
  end;

  if SelGate1.boGetStart then begin
    GetExitCodeProcess(SelGate1.ProcessHandle, dwExitCode);
    if (dwExitCode <> STILL_ACTIVE) or (SelGate1.ProcessHandle = 0) then begin
      GenMutSelGateConfig(1);
      nRetCode := RunProgram(SelGate1, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(SelGate1.ProcessHandle);
        SelGate1.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, SelGate1.ProcessInfo.dwProcessId);
        if SelGate1.MainFormHandle <> 0 then
          MainOutMessage('角色网关二异常关闭，已被重新启动...');
        SelGate1.MainFormHandle := 0;
      end;
    end;
  end;

  if LoginGate.boGetStart then begin
    GetExitCodeProcess(LoginGate.ProcessHandle, dwExitCode);
    if (dwExitCode <> STILL_ACTIVE) or (LoginGate.ProcessHandle = 0) then begin
      GenMutLoginGateConfig(0);
      nRetCode := RunProgram(LoginGate, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(LoginGate.ProcessHandle);
        if LoginGate.MainFormHandle <> 0 then
          MainOutMessage('登录网关一异常关闭，已被重新启动...');
        LoginGate.MainFormHandle := 0;
        LoginGate.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LoginGate.ProcessInfo.dwProcessId);
      end;
    end;
  end;

  if LoginGate2.boGetStart then begin
    GetExitCodeProcess(LoginGate2.ProcessHandle, dwExitCode);
    if (dwExitCode <> STILL_ACTIVE) or (LoginGate2.ProcessHandle = 0) then begin
      GenMutLoginGateConfig(1);
      nRetCode := RunProgram(LoginGate2, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(LoginGate2.ProcessHandle);
        if LoginGate2.MainFormHandle <> 0 then
          MainOutMessage('登录网关二异常关闭，已被重新启动...');
        LoginGate2.MainFormHandle := 0;
        LoginGate2.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LoginGate2.ProcessInfo.dwProcessId);

      end;
    end;
  end;
end;

procedure TfrmMain.ProcessMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.message = WM_SENDPROCMSG then begin
    //    ShowMessage('asfd');
    Handled := True;
  end;
end;

procedure TfrmMain.MyMessage(var MsgData: TWmCopyData);
var
  sData: string;
  wIdent, wRecog: Word;
begin
  MsgData.Result := 0;
  wIdent := HiWord(MsgData.From);
  wRecog := LoWord(MsgData.From);
  //ProgramType:=TProgamType(LoWord(MsgData.From));
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wRecog of //
    tDBServer: ProcessDBServerMsg(wIdent, sData);
    tLoginSrv: ProcessLoginSrvMsg(wIdent, sData);
    tLogServer: ProcessLogServerMsg(wIdent, sData);
    tM2Server: MsgData.Result := ProcessM2ServerMsg(wIdent, sData);
    tLoginGate: ProcessLoginGateMsg(wIdent, sData);
    tSelGate: ProcessSelGateMsg(wIdent, sData);
    tRunGate: ProcessRunGateMsg(wIdent, sData);
  end;

end;

procedure TfrmMain.ProcessDBServerMsg(wIdent: Word; sData: string);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := StrToIntDef(sData, 0);
        if Handle <> 0 then begin
          DBServer.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    SG_STARTNOW: begin
        MainOutMessage(sData);
      end;
    SG_STARTOK: begin
        DBServer.btStartStatus := 2;
        MainOutMessage(sData);
      end;
    SG_CHECKCODEADDR: begin
        g_dwDBCheckCodeAddr := StrToIntDef(sData, -1);
      end;
    3: ;
  end;
end;

procedure TfrmMain.ProcessLoginGateMsg(wIdent: Word; sData: string);
var
  Handle: THandle;
begin
  Handle := StrToIntDef(sData, 0);
  if Handle <> 0 then begin
    case wIdent of
      SG_FORMHANDLE: begin


          if LoginGate.boGetStart and (LoginGate.MainFormHandle = 0) then begin
            LoginGate.MainFormHandle := Handle;
          end else
          if LoginGate2.boGetStart and (LoginGate2.MainFormHandle = 0) then begin
            LoginGate2.MainFormHandle := Handle;
          end;
         // Handle := StrToIntDef(sData, 0);
         // if Handle <> 0 then begin
           // LoginGate.MainFormHandle := Handle;
            //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
          //end;
        end;
      SG_STARTNOW: begin
          if LoginGate.MainFormHandle = Handle then begin
            MainOutMessage('正在启动登录网关一...');
          end else
          if LoginGate2.MainFormHandle = Handle then begin
            MainOutMessage('正在启动登录网关二...');
          end;
          //MainOutMessage(sData);
        end;
      SG_STARTOK: begin
          if LoginGate.MainFormHandle = Handle then begin
            LoginGate.btStartStatus := 2;
            MainOutMessage('登录网关一启动完成...');

          end else
          if LoginGate2.MainFormHandle = Handle then begin
            LoginGate2.btStartStatus := 2;
            MainOutMessage('登录网关二启动完成...');
          end;
          //LoginGate.btStartStatus := 2;
          //MainOutMessage(sData);
        end;
      2: ;
      3: ;
    end;
  end;

{  SG_FORMHANDLE: begin
          if SelGate.boGetStart and (SelGate.MainFormHandle = 0) then begin
            SelGate.MainFormHandle := Handle;
          end else
          if SelGate1.boGetStart and (SelGate1.MainFormHandle = 0) then begin
            SelGate1.MainFormHandle := Handle;
          end;
        end;
      SG_STARTNOW: begin
          if SelGate.MainFormHandle = Handle then begin
            MainOutMessage('正在启动角色网关一...');
          end else
          if SelGate1.MainFormHandle = Handle then begin
            MainOutMessage('正在启动角色网关二...');
          end;
        end;
      SG_STARTOK: begin
          if SelGate.MainFormHandle = Handle then begin
            SelGate.btStartStatus := 2;
            MainOutMessage('角色网关一启动完成...');

          end else
          if SelGate1.MainFormHandle = Handle then begin
            SelGate1.btStartStatus := 2;
            MainOutMessage('角色网关二启动完成...');
          end;
        end;}
end;
    {
procedure TfrmMain.ProcessLoginGate1Msg(wIdent: Word; sData: string);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := StrToIntDef(sData, 0);
        if Handle <> 0 then begin
          LoginGate1.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;     }

procedure TfrmMain.ProcessSelGateMsg(wIdent: Word; sData: string);
var
  Handle: THandle;
begin
  Handle := StrToIntDef(sData, 0);
  if Handle <> 0 then begin
    case wIdent of
      SG_FORMHANDLE: begin
          if SelGate.boGetStart and (SelGate.MainFormHandle = 0) then begin
            SelGate.MainFormHandle := Handle;
          end else
          if SelGate1.boGetStart and (SelGate1.MainFormHandle = 0) then begin
            SelGate1.MainFormHandle := Handle;
          end;
        end;
      SG_STARTNOW: begin
          if SelGate.MainFormHandle = Handle then begin
            MainOutMessage('正在启动角色网关一...');
          end else
          if SelGate1.MainFormHandle = Handle then begin
            MainOutMessage('正在启动角色网关二...');
          end;
        end;
      SG_STARTOK: begin
          if SelGate.MainFormHandle = Handle then begin
            SelGate.btStartStatus := 2;
            MainOutMessage('角色网关一启动完成...');

          end else
          if SelGate1.MainFormHandle = Handle then begin
            SelGate1.btStartStatus := 2;
            MainOutMessage('角色网关二启动完成...');
          end;
        end;
    end;
  end;
end;
{
procedure TfrmMain.ProcessSelGate1Msg(wIdent: Word; sData: string);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := StrToIntDef(sData, 0);
        if Handle <> 0 then begin
          SelGate1.MainFormHandle := Handle;
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;       }

function TfrmMain.ProcessM2ServerMsg(wIdent: Word; sData: string): integer;
var
  Handle: THandle;
begin
  Result := 0;
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := StrToIntDef(sData, 0);
        if Handle <> 0 then begin
          M2Server.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    SG_STARTNOW: begin
        MainOutMessage(sData);
      end;
    SG_STARTOK: begin
        M2Server.btStartStatus := 2;
        MainOutMessage(sData);
      end;
    SG_CHECKCODEADDR: begin
        g_dwM2CheckCodeAddr := StrToIntDef(sData, -1);
      end;
    SG_GETFILEDATA: begin
      Result := MapGetFileData(sData, True);
    end;
    SG_CHECKFILE: begin
      Result := MapGetFileData(sData, False);
    end;
  end;
end;

function TfrmMain.MapGetFileData(sFileName: string; boBackData: Boolean): Integer;
var
  nPos: Integer;
  sName: string;
  Item: TListItem;
  Buffer: PChar;
  FileHandle: THandle;
  DataListInfo: pTDataListInfo;
begin
  Result := 0;
  nPos := Pos('Envir\', sFileName);
  if nPos > 0 then begin
    sName := Copy(sFileName, nPos + 6, Length(sFileName) - 6);
    sName := AnsiReplaceText(sName, '//', '\');
    sName := AnsiReplaceText(sName, '/', '\');
    sName := AnsiReplaceText(sName, '\\', '\');
    sName := AnsiReplaceText(sName, '\\', '\');
    if sName <> '' then begin
      for Item in ListViewDataList.Items do begin
        if CompareText(item.Caption, sName) = 0 then begin
          if boBackData then begin
            DataListInfo := pTDataListInfo(Item.SubItems.Objects[0]);
            if (DataListInfo <> nil) and (DataListInfo.Data <> nil) and (DataListInfo.DataSize > 0) then begin
              if (DataListInfo.MapFileHandle <> 0) and (DataListInfo.MapFileBuffer <> nil) then begin
                Result := Integer(DataListInfo);
              end else begin
                FileHandle := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, DataListInfo.DataSize + 4, PChar(IntToStr(Integer(DataListInfo))));
                if FileHandle <> 0 then begin
                  DataListInfo.MapFileHandle := FileHandle;
                  Buffer := MapViewOfFile(FileHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
                  if Buffer <> nil then begin
                    DataListInfo.MapFileBuffer := Buffer;
                    Move(DataListInfo.DataSize, Buffer^, SizeOf(Integer));
                    Move(DataListInfo.Data^, Buffer[SizeOf(Integer)], DataListInfo.DataSize);
                    Result := Integer(DataListInfo);
                  end;
                end;
              end;
            end;
          end else
            Result := 1;
          break;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ProcessLoginSrvMsg(wIdent: Word; sData: string);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := StrToIntDef(sData, 0);
        if Handle <> 0 then begin
          LoginServer.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    SG_STARTNOW: begin
        MainOutMessage(sData);
      end;
    SG_STARTOK: begin
        LoginServer.btStartStatus := 2;
        MainOutMessage(sData);
      end;
  end;
end;

procedure TfrmMain.ProcessLogServerMsg(wIdent: Word; sData: string);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := StrToIntDef(sData, 0);
        if Handle <> 0 then begin
          LogServer.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    SG_STARTNOW: begin
        MainOutMessage(sData);
      end;
    SG_STARTOK: begin
        LogServer.btStartStatus := 2;
        MainOutMessage(sData);
      end;
  end;
end;

procedure TfrmMain.ProcessRunGateMsg(wIdent: Word; sData: string);
var
  Handle: THandle;
  I: Integer;
begin
  Handle := StrToIntDef(sData, 0);
  if Handle <> 0 then begin
    case wIdent of
      SG_FORMHANDLE: begin
          for I := Low(RunGate) to High(RunGate) do begin
            if RunGate[I].boGetStart and (RunGate[I].MainFormHandle = 0) then begin
              RunGate[I].MainFormHandle := Handle;
              break;
            end;
          end;
        end;
      SG_STARTNOW: begin
          for I := Low(RunGate) to High(RunGate) do begin
            if RunGate[I].MainFormHandle = Handle then begin
              case I of
                0: MainOutMessage('正在启动游戏网关一...');
                1: MainOutMessage('正在启动游戏网关二...');
                2: MainOutMessage('正在启动游戏网关三...');
                3: MainOutMessage('正在启动游戏网关四...');
                4: MainOutMessage('正在启动游戏网关五...');
                5: MainOutMessage('正在启动游戏网关六...');
                6: MainOutMessage('正在启动游戏网关七...');
                7: MainOutMessage('正在启动游戏网关八...');
              end;
              break;
            end;
          end;
        end;
      SG_STARTOK: begin
          for I := Low(RunGate) to High(RunGate) do begin
            if RunGate[I].MainFormHandle = Handle then begin
              RunGate[I].btStartStatus := 2;
              case I of
                0: MainOutMessage('游戏网关一启动完成...');
                1: MainOutMessage('游戏网关二启动完成...');
                2: MainOutMessage('游戏网关三启动完成...');
                3: MainOutMessage('游戏网关四启动完成...');
                4: MainOutMessage('游戏网关五启动完成...');
                5: MainOutMessage('游戏网关六启动完成...');
                6: MainOutMessage('游戏网关七启动完成...');
                7: MainOutMessage('游戏网关八启动完成...');
              end;
              break;
            end;
          end;
        end;
    end;
  end;
end;

procedure TfrmMain.ButtonReLoadConfigClick(Sender: TObject);
begin
  LoadConfig();
  RefGameConsole();
  Application.MessageBox('配置重加载完成...', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmMain.EditLoginGate_MainFormXChange(Sender: TObject);
begin
  if EditLoginGate_MainFormX.Text = '' then begin
    EditLoginGate_MainFormX.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.LoginGate.MainFormX := EditLoginGate_MainFormX.Value;
end;

procedure TfrmMain.EditLoginGate_MainFormYChange(Sender: TObject);
begin
  if EditLoginGate_MainFormY.Text = '' then begin
    EditLoginGate_MainFormY.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.LoginGate.MainFormY := EditLoginGate_MainFormY.Value;
end;

procedure TfrmMain.CheckBoxSelGate1Click(Sender: TObject);
begin
  g_Config.SelGate.GetStart2 := CheckBoxSelGate1.Checked;
end;

procedure TfrmMain.CheckBoxSelGateClick(Sender: TObject);
begin
  g_Config.SelGate.GetStart1 := CheckBoxSelGate.Checked;
end;

procedure TfrmMain.CheckDBServerClick(Sender: TObject);
begin
  DBServer.boGetStart := CheckDBServer.Checked;
end;

procedure TfrmMain.CheckLoginGateClick(Sender: TObject);
begin
  LoginGate.boGetStart := CheckLoginGate.Checked;
end;

procedure TfrmMain.CheckLoginSrvClick(Sender: TObject);
begin
  LoginServer.boGetStart := CheckLoginSrv.Checked;
end;

procedure TfrmMain.CheckLogServerClick(Sender: TObject);
begin
  LogServer.boGetStart := CheckLogServer.Checked;
end;

procedure TfrmMain.CheckM2ServerClick(Sender: TObject);
begin
  M2Server.boGetStart := CheckM2Server.Checked;
end;

procedure TfrmMain.CheckRunGate1Click(Sender: TObject);
begin
  with Sender as TCheckBox do begin
    if Tag in [Low(RunGate)..High(RunGate)] then begin
      RunGate[Tag].boGetStart := Checked;
    end;
  end;
end;

procedure TfrmMain.CheckSelGate1Click(Sender: TObject);
begin
  SelGate.boGetStart := CheckSelGate1.Checked;
end;

procedure TfrmMain.CheckSelGate2Click(Sender: TObject);
begin
  SelGate1.boGetStart := CheckSelGate2.Checked;
end;

procedure TfrmMain.CheckBoxAutoRunBakClick(Sender: TObject);
begin
  g_boAutoRunBak := CheckBoxAutoRunBak.Checked;
  g_IniConf.WriteBool(BasicSectionName, 'AutoRunBak', g_boAutoRunBak);
end;

procedure TfrmMain.CheckBoxboLoginGate_GetStartClick(Sender: TObject);
begin
  if not m_boOpen then
    Exit;
  g_Config.LoginGate.GetStart := CheckBoxboLoginGate_GetStart.Checked;
end;

procedure TfrmMain.EditSelGate_MainFormXChange(Sender: TObject);
begin
  if EditSelGate_MainFormX.Text = '' then begin
    EditSelGate_MainFormX.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.SelGate.MainFormX := EditSelGate_MainFormX.Value;
end;

procedure TfrmMain.EditSelGate_MainFormYChange(Sender: TObject);
begin
  if EditSelGate_MainFormY.Text = '' then begin
    EditSelGate_MainFormY.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.SelGate.MainFormY := EditSelGate_MainFormY.Value;
end;

procedure TfrmMain.CheckBoxboSelGate_GetStart2Click(Sender: TObject);
begin
  if not m_boOpen then Exit;
  g_Config.SelGate.GetStart2 := CheckBoxboSelGate_GetStart2.Checked;
end;

procedure TfrmMain.CheckBoxboSelGate_GetStartClick(Sender: TObject);
begin
  if not m_boOpen then Exit;
  g_Config.SelGate.GetStart1 := CheckBoxboSelGate_GetStart.Checked;
end;

procedure TfrmMain.EditLoginServer_MainFormXChange(Sender: TObject);
begin
  if EditLoginServer_MainFormX.Text = '' then begin
    EditLoginServer_MainFormX.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.LoginSrv.MainFormX := EditLoginServer_MainFormX.Value;
end;

procedure TfrmMain.EditLoginServer_MainFormYChange(Sender: TObject);
begin
  if EditLoginServer_MainFormY.Text = '' then begin
    EditLoginServer_MainFormY.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.LoginSrv.MainFormY := EditLoginServer_MainFormY.Value;
end;

procedure TfrmMain.CheckBoxboLoginServer_GetStartClick(Sender: TObject);
begin
  if not m_boOpen then
    Exit;
  g_Config.LoginSrv.GetStart := CheckBoxboLoginServer_GetStart.Checked;
end;

procedure TfrmMain.CheckBoxboRunGate_GetStart2Click(Sender: TObject);
begin
  if not m_boOpen then Exit;
  with Sender as TCheckBox do begin
    if Tag in [Low(g_Config.RunGate.GetStart)..High(g_Config.RunGate.GetStart)] then
      g_Config.RunGate.GetStart[Tag] := Checked;
  end;
end;

procedure TfrmMain.EditDBServer_MainFormXChange(Sender: TObject);
begin
  if EditDBServer_MainFormX.Text = '' then begin
    EditDBServer_MainFormX.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.DBServer.MainFormX := EditDBServer_MainFormX.Value;
end;

procedure TfrmMain.EditDBServer_MainFormYChange(Sender: TObject);
begin
  if EditDBServer_MainFormY.Text = '' then begin
    EditDBServer_MainFormY.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.DBServer.MainFormY := EditDBServer_MainFormY.Value;
end;

procedure TfrmMain.CheckBoxDBServerGetStartClick(Sender: TObject);
begin
  if not m_boOpen then
    Exit;
  g_Config.DBServer.GetStart := CheckBoxDBServerGetStart.Checked;
end;

procedure TfrmMain.CheckBoxIP2Click(Sender: TObject);
begin
  if CheckBoxIP2.Checked then begin
    CheckBoxboSelGate_GetStart.Checked := True;
    CheckBoxboSelGate_GetStart2.Checked := True;
    CheckBoxboSelGate_GetStart.Enabled := False;
    CheckBoxboSelGate_GetStart2.Enabled := False;
    Label30.Visible := True;
    EditGameExtIpAddr2.Visible := True;
  end else begin
    CheckBoxboSelGate_GetStart2.Checked := False;
    CheckBoxboSelGate_GetStart.Enabled := True;
    CheckBoxboSelGate_GetStart2.Enabled := True;
    Label30.Visible := False;
    EditGameExtIpAddr2.Visible := False;
  end;
end;

procedure TfrmMain.EditLogServer_MainFormXChange(Sender: TObject);
begin
  if EditLogServer_MainFormX.Text = '' then begin
    EditLogServer_MainFormX.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.LogServer.MainFormX := EditLogServer_MainFormX.Value;
end;

procedure TfrmMain.EditLogServer_MainFormYChange(Sender: TObject);
begin
  if EditLogServer_MainFormY.Text = '' then begin
    EditLogServer_MainFormY.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.LogServer.MainFormY := EditLogServer_MainFormY.Value;
end;

procedure TfrmMain.CheckBoxLogServerGetStartClick(Sender: TObject);
begin
  if not m_boOpen then
    Exit;
  g_Config.LogServer.GetStart := CheckBoxLogServerGetStart.Checked;
end;

procedure TfrmMain.EditM2Server_MainFormXChange(Sender: TObject);
begin
  if EditM2Server_MainFormX.Text = '' then begin
    EditM2Server_MainFormX.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.M2Server.MainFormX := EditM2Server_MainFormX.Value;
end;

procedure TfrmMain.EditM2Server_MainFormYChange(Sender: TObject);
begin
  if EditM2Server_MainFormY.Text = '' then begin
    EditM2Server_MainFormY.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.M2Server.MainFormY := EditM2Server_MainFormY.Value;
end;

procedure TfrmMain.CheckBoxM2ServerGetStartClick(Sender: TObject);
begin
  if not m_boOpen then
    Exit;
  g_Config.M2Server.GetStart := CheckBoxM2ServerGetStart.Checked;
end;

procedure TfrmMain.MemoLogChange(Sender: TObject);
begin
  if MemoLog.Lines.Count > 500 then
    MemoLog.Clear;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if m_nStartStatus = 2 then begin
    if
      Application.MessageBox('游戏服务器正在运行，是否停止游戏服务器 ?', '确认信息', MB_YESNO +
        MB_ICONQUESTION) = mrYes then begin
      ButtonStartGameClick(ButtonStartGame);
    end;
    CanClose := False;
    Exit;
  end;

  if Application.MessageBox('是否确认关闭控制台 ?', '确认信息',
    MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    CanClose := True;
  end
  else begin
    CanClose := False;
  end;

  if g_BackUpManager <> nil then begin
    try
      g_BackUpManager.Free;
    except
    end;
  end;
end;
 {
function TfrmMain.GetFileData(sFileName: string; out FileBuffer: PChar; out nBufferLen: Integer): Boolean;
var
  Item: TListItem;
  DataListInfo: pTDataListInfo;
begin
  Result := False;
  FileBuffer := nil;
  nBufferLen := 0;
  for Item in ListViewDataList.Items do begin
    if CompareText(Item.Caption, sFileName) = 0 then begin
      DataListInfo := pTDataListInfo(Item.SubItems.Objects[0]);
      if (DataListInfo <> nil) and (DataListInfo.DataSize > 0) and (DataListInfo.Data <> nil) then begin
        FileBuffer := DataListInfo.Data;
        nBufferLen := DataListInfo.DataSize;
      end;
      Result := True;
      break;
    end;
  end;
end;      }

procedure TfrmMain.GetMutRunGateConfing(nIndex: Integer);
var
  IniGameConf: Tinifile;
  sIniFile: string;                           
begin
  if (nIndex >= 0) and (nIndex < MAXRUNGATECOUNT) then begin
    sIniFile := g_sGameDirectory + 'RunGate\';
    if not DirectoryExists(sIniFile) then begin
      CreateDir(sIniFile);
    end;
    IniGameConf := Tinifile.Create(sIniFile + SERVERCONFIGFILE);
    IniGameConf.WriteString(RunGateSectionName2, 'Title', g_sGameName);
    IniGameConf.WriteString(RunGateSectionName2, 'GateAddr', sAllIPaddr);
    IniGameConf.WriteInteger(RunGateSectionName2, 'GatePort', g_Config.RunGate.GatePort[nIndex]);
    IniGameConf.Free;
  end;
end;

procedure TfrmMain.EditRunGate_MainFormXChange(Sender: TObject);
begin
  if EditRunGate_MainFormX.Text = '' then begin
    EditRunGate_MainFormX.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.RunGate.MainFormX := EditRunGate_MainFormX.Value;
end;

procedure TfrmMain.EditRunGate_MainFormYChange(Sender: TObject);
begin
  if EditRunGate_MainFormY.Text = '' then begin
    EditRunGate_MainFormY.Text := '0';
  end;
  if not m_boOpen then
    Exit;
  g_Config.RunGate.MainFormY := EditRunGate_MainFormY.Value;
end;

function TfrmMain.StartService: Boolean;
begin
  //  Result := False;
  MainOutMessage('正在启动游戏客户端控制器...');
  m_dwShowTick := GetTickCount();
  Timer.Enabled := True;
  MainOutMessage('游戏控制台启动完成...');
  Result := True;
end;
{
procedure TfrmMain.StopService;
begin
  Timer.Enabled := False;
  g_IniConf.Free;
end;      }

procedure TfrmMain.ButtonGeneralDefalultClick(Sender: TObject);
begin
  EditGameDir.Text := '.\';
  EditHeroDB.Text := 'randall';
  EditGameName.Text := 'GameOfMir';
  EditGameExtIPaddr.Text := '127.0.0.1';
  //CheckBoxDynamicIPMode.Checked := False;
end;

procedure TfrmMain.ButtonRunGateDefaultClick(Sender: TObject);
begin
  CheckBoxboRunGate_GetStart1.Checked := True;
  CheckBoxboRunGate_GetStart2.Checked := True;
  CheckBoxboRunGate_GetStart3.Checked := True;
  CheckBoxboRunGate_GetStart4.Checked := False;
  CheckBoxboRunGate_GetStart5.Checked := False;
  CheckBoxboRunGate_GetStart6.Checked := False;
  CheckBoxboRunGate_GetStart7.Checked := False;
  CheckBoxboRunGate_GetStart8.Checked := False;
  EditRunGate_GatePort1.Text := '7200';
  EditRunGate_GatePort2.Text := '7201';
  EditRunGate_GatePort3.Text := '7202';
  EditRunGate_GatePort4.Text := '7203';
  EditRunGate_GatePort5.Text := '7204';
  EditRunGate_GatePort6.Text := '7205';
  EditRunGate_GatePort7.Text := '7206';
  EditRunGate_GatePort8.Text := '7207';
  EditRunGate_MainFormX.Text := '437';
  EditRunGate_MainFormY.Text := '373';
end;

procedure TfrmMain.ButtonLoginGateDefaultClick(Sender: TObject);
begin
  EditLoginGate_MainFormX.Text := '0';
  EditLoginGate_MainFormY.Text := '0';
  EditLoginGate_GatePort.Text := '7000';
  CheckBoxboLoginGate_GetStart.Checked := True;
end;

procedure TfrmMain.ButtonSelGateDefaultClick(Sender: TObject);
begin
  EditSelGate_MainFormX.Text := '0';
  EditSelGate_MainFormY.Text := '180';
  EditSelGate_GatePort.Text := '7100';
  EditSelGate_GatePort1.Text := '7101';
  CheckBoxboSelGate_GetStart.Checked := True;
  CheckBoxboSelGate_GetStart2.Checked := False;
end;

procedure TfrmMain.ButtonLoginSrvDefaultClick(Sender: TObject);
begin
  EditLoginServer_MainFormX.Text := '252';
  EditLoginServer_MainFormY.Text := '0';
  EditLoginServerGatePort.Text := '5500';
  EditLoginServerServerPort.Text := '5600';
  EditLoginServerMonPort.Text := '3000';
  CheckBoxboLoginServer_GetStart.Checked := True;
end;

procedure TfrmMain.ButtonDBServerDefaultClick(Sender: TObject);
begin
  EditDBServer_MainFormX.Text := '0';
  EditDBServer_MainFormY.Text := '373';
  EditDBServerGatePort.Text := '5100';
  EditDBServerServerPort.Text := '6000';
  CheckBoxDBServerGetStart.Checked := True;
end;

procedure TfrmMain.ButtonLogServerDefaultClick(Sender: TObject);
begin
  EditLogServer_MainFormX.Text := '252';
  EditLogServer_MainFormY.Text := '286';
  EditLogServerPort.Text := '10000';
  CheckBoxLogServerGetStart.Checked := True;
end;

procedure TfrmMain.ButtonM2ServerDefaultClick(Sender: TObject);
begin
  EditM2Server_MainFormX.Text := '561';
  EditM2Server_MainFormY.Text := '0';
  EditM2ServerGatePort.Text := '5000';
  EditM2ServerMsgSrvPort.Text := '4900';
  CheckBoxM2ServerGetStart.Checked := True;
end;

procedure TfrmMain.RefGameDebug;
//var
//  CheckCode: TCheckCode;
//  dwReturn: LongWord;
begin
  {EditM2CheckCodeAddr.Text := IntToHex(g_dwM2CheckCodeAddr, 2);
  FillChar(CheckCode, SizeOf(CheckCode), 0);
  ReadProcessMemory(M2Server.ProcessHandle, Pointer(g_dwM2CheckCodeAddr), @CheckCode, SizeOf(CheckCode), dwReturn);
  if dwReturn = SizeOf(CheckCode) then begin
    EditM2CheckCode.Text := IntToStr(CheckCode.dwThread0);
    EditM2CheckStr.Text := string(CheckCode.sThread0);
  end;

  EditDBCheckCodeAddr.Text := IntToHex(g_dwDBCheckCodeAddr, 2);
  FillChar(CheckCode, SizeOf(CheckCode), 0);
  ReadProcessMemory(DBServer.ProcessHandle, Pointer(g_dwDBCheckCodeAddr), @CheckCode, SizeOf(CheckCode), dwReturn);
  if dwReturn = SizeOf(CheckCode) then begin
    EditDBCheckCode.Text := IntToStr(CheckCode.dwThread0);
    EditDBCheckStr.Text := string(CheckCode.sThread0);
  end;}
end;

procedure TfrmMain.TimerCheckDebugTimer(Sender: TObject);
begin
  RefGameDebug();
end;

procedure TfrmMain.ButtonM2SuspendClick(Sender: TObject);
begin
  SuspendThread(M2Server.ProcessInfo.hThread);
end;

procedure TfrmMain.ButtonBackStartClick(Sender: TObject);
begin
  case m_nBackStartStatus of
    0: begin
        m_nBackStartStatus := 1;
        ButtonBackStart.Caption := '停止(&T)';
        g_BackUpManager.Start();
        LabelBackMsg.Font.Color := clGreen;
        LabelBackMsg.Caption := '数据备份功能启动中...';
      end;
    1: begin
        m_nBackStartStatus := 0;
        ButtonBackStart.Caption := '启动(&B)';
        g_BackUpManager.Stop();
        LabelBackMsg.Font.Color := clRed;
        LabelBackMsg.Caption := '数据备份功能已停止...';
      end;
  end;
end;

procedure TfrmMain.ButtonBackSaveClick(Sender: TObject);
var
  I: Integer;
  BackUpObject: TBackUpObject;
  Conini: Tinifile;
begin
  ButtonBackSave.Enabled := False;
  DeleteFile(g_sBackListFile);
  Conini := Tinifile.Create(g_sBackListFile);
  if Conini <> nil then begin
    for I := 0 to g_BackUpManager.m_BackUpList.Count - 1 do begin
      BackUpObject := TBackUpObject(g_BackUpManager.m_BackUpList.Items[I]);
      Conini.WriteString(IntToStr(I), 'Source', BackUpObject.m_sSourceDir);
      Conini.WriteString(IntToStr(I), 'Save', BackUpObject.m_sDestDir);
      Conini.WriteInteger(IntToStr(I), 'Hour', BackUpObject.m_wHour);
      Conini.WriteInteger(IntToStr(I), 'Min', BackUpObject.m_wMin);
      Conini.WriteInteger(IntToStr(I), 'BackMode', BackUpObject.m_btBackUpMode);
      Conini.WriteBool(IntToStr(I), 'GetBack', BackUpObject.m_boBackUp);
      Conini.WriteBool(IntToStr(I), 'Zip', BackUpObject.m_boZip);
    end;
    Conini.Free;
  end;
  Application.MessageBox('保存成功！！！', '提示信息', MB_OK +
    MB_ICONINFORMATION);
  ButtonBackSave.Enabled := True;
end;

procedure TfrmMain.btDataListAllClick(Sender: TObject);
var
  Item: TListItem;
  DataListInfo: pTDataListInfo;
  boSend: Boolean;
begin
  if not g_boGetDataListOK then exit;
  boSend := False;
  for Item in ListViewDataList.Items do begin
    DataListInfo := pTDataListInfo(Item.SubItems.Objects[0]);
    if DataListInfo <> nil then begin
      g_GetDatList.AddObject(Item.Caption, TObject(DataListInfo));
      boSend := True;
    end;
  end;
  if boSend then begin
    CSocket.Active := False;
    CSocket.Host := g_sDataListAddrs;
    CSocket.Port := g_wDataListPort;
    CSocket.Active := True;
  end;
end;

procedure TfrmMain.btDataListSelectClick(Sender: TObject);
var
  Item: TListItem;
  DataListInfo: pTDataListInfo;
  boSend: Boolean;
begin

  if not g_boGetDataListOK then exit;
  boSend := False;
  for Item in ListViewDataList.Items do begin
    if Item.Selected then begin
      DataListInfo := pTDataListInfo(Item.SubItems.Objects[0]);
      if DataListInfo <> nil then begin
        g_GetDatList.AddObject(Item.Caption, TObject(DataListInfo));
        boSend := True;
      end;
    end;
  end;
  if boSend then begin
    CSocket.Active := False;
    CSocket.Host := g_sDataListAddrs;
    CSocket.Port := g_wDataListPort;
    CSocket.Active := True;
  end;

  {if (ListViewDataList.ItemIndex >= 0) and (ListViewDataList.ItemIndex < ListViewDataList.Items.Count) then begin
    Item := ListViewDataList.Items[ListViewDataList.ItemIndex];
    DataListInfo := pTDataListInfo(Item.SubItems.Objects[0]);
    if DataListInfo <> nil then begin
      g_GetDatList.AddObject(Item.Caption, TObject(DataListInfo));
      CSocket.Active := False;
      CSocket.Host := g_sDataListAddrs;
      CSocket.Port := g_wDataListPort;
      CSocket.Active := True;
    end;
  end;  }
end;

procedure TfrmMain.btDataListListClick(Sender: TObject);
var
  sPort: string;
begin
  g_sDataListAddrs := InputBox('输入信息', '请输入远程地址', g_sDataListAddrs);
  sPort := InputBox('输入信息', '请输入远程端口', IntToStr(g_wDataListPort));
  g_wDataListPort := StrToIntDef(sPort, g_wDataListPort);
  g_sDataListPassWord := InputBox('输入信息', '请输入连接密码', g_sDataListPassWord);
  CSocket.Active := False;
  CSocket.Host := g_sDataListAddrs;
  CSocket.Port := g_wDataListPort;
  CSocket.Active := True;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
  procedure DeleteAllFile(sDir: string);
  var
    sr: TSearchRec;
    I: Integer;
  begin
    I := FindFirst(sDir + '*.*', faAnyFile or faDirectory, sr);
    Try
      while i = 0 do begin
        if (Sr.Attr and faDirectory) = faDirectory then begin
          if (sr.Name[1] <> '.') and (sr.Name[1] <> '..') then begin
            DeleteAllFile(sDir + sr.Name + '\');
            RemoveDir(sDir + sr.Name + '\');
          end;
        end
        else if (Sr.Attr and faDirectory) = 0 then begin
          if sr.Name[1] <> '.' then begin
            DeleteFile(sDir + sr.Name);
          end;
        end;
        i := FindNext(sr);
      end;
    finally
      FindClose(sr);
    end;
  end;
var
  TempString, TempString2: TStringList;
  I: Integer;
  INI: TINIFile;
begin
  if m_nStartStatus = 0 then begin
    Button1.Enabled := False;
    TempString := TStringList.Create;
    TempString2 := TStringList.Create;
    Try
      if CheckBox1.Checked then begin
        DeleteFile('.\DBServer\DB\Hum.DB');
        DeleteFile('.\DBServer\DB\Mir.DB');
        DeleteFile('.\DBServer\DB\Mir.DB.idx');
      end;
      if CheckBox2.Checked then begin
        DeleteFile('.\LoginSrv\DB\Id.DB');
        DeleteFile('.\LoginSrv\DB\Id.DB.idx');
      end;
      if CheckBox3.Checked then begin
        DeleteAllFile('.\Mir200\GuildBase\Guilds\');
        if FileExists('.\Mir200\GuildBase\GuildList.txt') then
          TempString.SaveToFile('.\Mir200\GuildBase\GuildList.txt');
      end;
      if CheckBox4.Checked then begin
        TempString2.LoadFromFile('.\Mir200\Castle\List.txt');
        for I := 0 to TempString2.Count - 1 do begin
          if FileExists('.\Mir200\Castle\' + TempString2[I] + '\AttackSabukWall.txt') then
            TempString.SaveToFile('.\Mir200\Castle\' + TempString2[I] + '\AttackSabukWall.txt');
          if FileExists('.\Mir200\Castle\' + TempString2[I] + '\SabukW.txt') then begin
            INI := TINIFile.Create('.\Mir200\Castle\' + TempString2[I] + '\SabukW.txt');
            INI.WriteString('Setup', 'OwnGuild', '');
            INI.WriteString('Setup', 'ChangeDate', '');
            INI.WriteString('Setup', 'WarDate', '');
            INI.WriteString('Setup', 'IncomeToday', '');
            INI.WriteString('Setup', 'TotalGold', '0');
            INI.WriteString('Setup', 'TodayIncome', '0');

            INI.WriteString('Defense', 'MainDoorHP', '10000');
            INI.WriteString('Defense', 'LeftWallHP', '5000');
            INI.WriteString('Defense', 'CenterWallHP', '5000');
            INI.WriteString('Defense', 'RightWallHP', '5000');
            INI.WriteString('Defense', 'Archer_1_HP', '2000');
            INI.WriteString('Defense', 'Archer_2_HP', '2000');
            INI.WriteString('Defense', 'Archer_3_HP', '2000');
            INI.WriteString('Defense', 'Archer_4_HP', '2000');
            INI.WriteString('Defense', 'Archer_5_HP', '2000');
            INI.WriteString('Defense', 'Archer_6_HP', '2000');
            INI.WriteString('Defense', 'Archer_7_HP', '2000');
            INI.WriteString('Defense', 'Archer_8_HP', '2000');
            INI.WriteString('Defense', 'Archer_9_HP', '2000');
            INI.WriteString('Defense', 'Archer_10_HP', '2000');
            INI.WriteString('Defense', 'Archer_11_HP', '2000');
            INI.WriteString('Defense', 'Archer_12_HP', '2000');
            INI.Free;
          end;
        end;
        if CheckBox5.Checked then begin
          DeleteFile('.\Mir200\Global.ini');
        end;
        if CheckBox6.Checked then begin
          if FileExists('.\Mir200\!Setup.txt') then begin
            INI := TINIFile.Create('.\Mir200\!Setup.txt');
            INI.WriteInteger('Setup', 'ItemNumber', 10000);
            INI.WriteInteger('Setup', 'ItemNumberEx', 2000000000);
            INI.Free;
          end;
        end;
        if CheckBox7.Checked then begin
          if FileExists('.\Mir200\Envir\UnForceMaster.txt') then
            TempString.SaveToFile('.\Mir200\Envir\UnForceMaster.txt');
          if FileExists('.\Mir200\Envir\UnFriend.txt') then
            TempString.SaveToFile('.\Mir200\Envir\UnFriend.txt');
          if FileExists('.\Mir200\Envir\UnMarry.txt') then
            TempString.SaveToFile('.\Mir200\Envir\UnMarry.txt');
          if FileExists('.\Mir200\Envir\UnMaster.txt') then
            TempString.SaveToFile('.\Mir200\Envir\UnMaster.txt');
        end;
        if CheckBox8.Checked then begin
          DeleteAllFile('.\Mir200\Envir\Market_Upg\');
        end;
        if CheckBox9.Checked then begin
          DeleteFile('.\Mir200\EMail\EMailData.dat');
          DeleteFile('.\Mir200\EMail\EMailName.txt');
        end;
        if CheckBox10.Checked then begin
          DeleteAllFile('.\LoginSrv\ChrLog\');
        end;
        if CheckBox11.Checked then begin
          DeleteAllFile('.\Mir200\Log\');
          DeleteAllFile('.\Mir200\ConLog\');
        end;
        if CheckBox12.Checked then begin
          DeleteAllFile('.\LogServer\BaseDir\');
        end;
      end;
    Finally
      TempString.Free;
      TempString2.Free;
      Button1.Enabled := True;
    End;
    Application.MessageBox('全部清理完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
  end else
    Application.MessageBox('请将服务器处于停止状态下再进行操作！', '提示信息', MB_OK + MB_ICONWARNING);
end;

procedure TfrmMain.ButtonBackAddClick(Sender: TObject);
var
  //  I: Integer;
  BackUpObject: TBackUpObject;
  sSource, sDest: string;
  wHour, wMin: Word;
begin
  sSource := Trim(RzButtonEditSource.Text);
  sDest := Trim(RzButtonEditDest.Text);
  if sSource = '' then begin
    Application.MessageBox('请选择数据目录！！！', '提示信息',
      MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  if sDest = '' then begin
    Application.MessageBox('请选择备份目录！！！', '提示信息',
      MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  if g_BackUpManager.FindObject(sSource) <> nil then begin
    Application.MessageBox('此数据目录已经存在！！！',
      '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  if RadioButtonBackMode1.Checked then begin
    wHour := RzSpinEditHour1.IntValue;
    wMin := RzSpinEditMin1.IntValue;
  end
  else begin
    wHour := RzSpinEditHour2.IntValue;
    wMin := RzSpinEditMin2.IntValue;
  end;
  BackUpObject := TBackUpObject.Create;
  BackUpObject.m_nIndex := g_BackUpManager.m_BackUpList.Count;
  BackUpObject.m_sSourceDir := sSource;
  BackUpObject.m_sDestDir := sDest;
  BackUpObject.m_wHour := wHour;
  BackUpObject.m_wMin := wMin;
  BackUpObject.m_boBackUp := CheckBoxBackUp.Checked;
  BackUpObject.m_boZip := CheckBoxZip.Checked;
  if RadioButtonBackMode1.Checked then begin
    BackUpObject.m_btBackUpMode := 0;
  end
  else begin
    BackUpObject.m_btBackUpMode := 1;
  end;

  g_BackUpManager.AddObjectToList(BackUpObject);
  RefBackListToView();
  Application.MessageBox('增加成功！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmMain.ButtonBackDelClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListViewDataBackup.Selected;
  if ListItem <> nil then begin
    if g_BackUpManager.DeleteObject(ListItem.Caption) then begin
      RefBackListToView();
      Application.MessageBox('删除成功！！！', '提示信息', MB_OK +
        MB_ICONINFORMATION);
    end
    else
      Application.MessageBox('删除失败！！！', '提示信息', MB_OK +
        MB_ICONERROR);
  end;
end;

procedure TfrmMain.ButtonBackChgClick(Sender: TObject);
var
  ListItem: TListItem;
  BackUpObject: TBackUpObject;
  sSource, sDest: string;
  wHour, wMin: Word;
begin
  ListItem := ListViewDataBackup.Selected;
  if ListItem <> nil then begin
    sSource := Trim(RzButtonEditSource.Text);
    sDest := Trim(RzButtonEditDest.Text);
    if sSource = '' then begin
      Application.MessageBox('请选择数据目录！！！', '提示信息',
        MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
    if sDest = '' then begin
      Application.MessageBox('请选择备份目录！！！', '提示信息',
        MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
    {if g_BackUpManager.FindObject(sSource) <> nil then begin
      Application.MessageBox('此备份目录已经存在！！！', '提示信息', MB_OK + MB_ICONERROR);
      Exit;
    end;}
    if RadioButtonBackMode1.Checked then begin
      wHour := RzSpinEditHour1.IntValue;
      wMin := RzSpinEditMin1.IntValue;
    end
    else begin
      wHour := RzSpinEditHour2.IntValue;
      wMin := RzSpinEditMin2.IntValue;
    end;
    ListItem.Caption := sSource;
    ListItem.SubItems.Strings[0] := sDest;
    BackUpObject := TBackUpObject(ListItem.SubItems.Objects[0]);
    BackUpObject.m_sSourceDir := sSource;
    BackUpObject.m_sDestDir := sDest;
    BackUpObject.m_wHour := wHour;
    BackUpObject.m_wMin := wMin;
    BackUpObject.m_boBackUp := CheckBoxBackUp.Checked;
    if RadioButtonBackMode1.Checked then begin
      BackUpObject.m_btBackUpMode := 0;
    end
    else begin
      BackUpObject.m_btBackUpMode := 1;
    end;
    BackUpObject.m_boZip := CheckBoxZip.Checked;
    Application.MessageBox('修改成功！！！', '提示信息', MB_OK +
      MB_ICONINFORMATION);
  end;
end;

procedure TfrmMain.ListViewDataBackupClick(Sender: TObject);
var
  ListItem: TListItem;
  BackUpObject: TBackUpObject;
begin
  try
    if ListViewDataBackup.Selected = nil then exit;
    ListItem := ListViewDataBackup.Selected;
    BackUpObject := TBackUpObject(ListItem.SubItems.Objects[0]);
    RzButtonEditSource.Text := BackUpObject.m_sSourceDir;
    RzButtonEditDest.Text := BackUpObject.m_sDestDir;
    CheckBoxBackUp.Checked := BackUpObject.m_boBackUp;
    CheckBoxZip.Checked := BackUpObject.m_boZip;
    if BackUpObject.m_btBackUpMode = 0 then begin
      RadioButtonBackMode1.Checked := True;
      RadioButtonBackMode2.Checked := False;
      RzSpinEditHour1.IntValue := BackUpObject.m_wHour;
      RzSpinEditMin1.IntValue := BackUpObject.m_wMin;
    end
    else begin
      RadioButtonBackMode1.Checked := False;
      RadioButtonBackMode2.Checked := True;
      RzSpinEditHour2.IntValue := BackUpObject.m_wHour;
      RzSpinEditMin2.IntValue := BackUpObject.m_wMin;
    end;
    RzSpinEditHour1.Enabled := RadioButtonBackMode1.Checked;
    RzSpinEditMin1.Enabled := RadioButtonBackMode1.Checked;
    RzSpinEditHour2.Enabled := RadioButtonBackMode2.Checked;
    RzSpinEditMin2.Enabled := RadioButtonBackMode2.Checked;
    ButtonBackDel.Enabled := True;
    ButtonBackChg.Enabled := True;
  except
    ButtonBackDel.Enabled := False;
    ButtonBackChg.Enabled := False;
  end;
end;

procedure TfrmMain.ListViewDataListDblClick(Sender: TObject);
var
  Item: TListItem;
  DataListInfo: pTDataListInfo;
  ShowBuffer: PChar;
begin
  if (ListViewDataList.ItemIndex >= 0) and (ListViewDataList.ItemIndex < ListViewDataList.Items.Count) then begin
    Item := ListViewDataList.Items[ListViewDataList.ItemIndex];
    if CompareText(RightStr(Item.Caption, 3), 'TXT') = 0 then begin
      DataListInfo := pTDataListInfo(Item.SubItems.Objects[0]);
      if (DataListInfo <> nil) then begin
        FormText := TFormText.Create(nil);
        FormText.Memo1.Lines.Clear;
        if (DataListInfo.Data <> nil) and (DataListInfo.DataSize > 0) then begin
          ShowBuffer := AllocMem(DataListInfo.DataSize + 1);
          Move(DataListInfo.Data^, ShowBuffer^, DataListInfo.DataSize);
          FormText.Memo1.Lines.SetText(ShowBuffer);
          FreeMem(ShowBuffer);
        end;
        if mrYes = FormText.ShowModal then begin
          if DataListInfo.MapFileBuffer <> nil then
            UnMapViewOfFile(DataListInfo.MapFileBuffer);
          if DataListInfo.MapFileHandle <> 0 then
            CloseHandle(DataListInfo.MapFileHandle);
          DataListInfo.MapFileBuffer := nil;
          DataListInfo.MapFileHandle := 0;
          if DataListInfo.Data <> nil then
            FreeMem(DataListInfo.Data);
          DataListInfo.Data := nil;
          DataListInfo.DataSize := 0;
          ShowBuffer := FormText.Memo1.Lines.GetText;
          if ShowBuffer <> nil then begin
            DataListInfo.DataSize := Length(Strpas(ShowBuffer));
            if DataListInfo.DataSize > 0 then begin
              GetMem(DataListInfo.Data, DataListInfo.DataSize);
              Move(ShowBuffer^, DataListInfo.Data^, DataListInfo.DataSize);
            end;
            StrDispose(ShowBuffer);
          end;
          Item.SubItems.Strings[1] := IntToStr(DataListInfo.DataSize);
        end;
        FreeAndNil(FormText);
      end;
    end;
  end;
end;

procedure TfrmMain.RadioButtonBackMode1Click(Sender: TObject);
begin
  RzSpinEditHour2.Enabled := not RadioButtonBackMode1.Checked;
  RzSpinEditMin2.Enabled := not RadioButtonBackMode1.Checked;
  RzSpinEditHour1.Enabled := RadioButtonBackMode1.Checked;
  RzSpinEditMin1.Enabled := RadioButtonBackMode1.Checked;
end;

procedure TfrmMain.RadioButtonBackMode2Click(Sender: TObject);
begin
  RzSpinEditHour1.Enabled := not RadioButtonBackMode2.Checked;
  RzSpinEditMin1.Enabled := not RadioButtonBackMode2.Checked;
  RzSpinEditHour2.Enabled := RadioButtonBackMode2.Checked;
  RzSpinEditMin2.Enabled := RadioButtonBackMode2.Checked;
end;

procedure TfrmMain.RzButtonEditSourceButtonClick(Sender: TObject);
var
  NewDir: string;
begin
  NewDir := RzButtonEditSource.Text;
  if SelectDirectory('请选择你要备份的文件夹', '', NewDir, Handle) then begin
    RzButtonEditSource.Text := NewDir;
  end;
end;

procedure TfrmMain.RzButtonEditDestButtonClick(Sender: TObject);
var
  NewDir: string;
begin
  NewDir := RzButtonEditDest.Text;
  if SelectDirectory('请选择备份文件夹', '', NewDir, Handle) then begin
    RzButtonEditDest.Text := NewDir;
  end;
end;

end.

