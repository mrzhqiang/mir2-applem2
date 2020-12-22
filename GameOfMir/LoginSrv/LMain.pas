unit LMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, WinSock, IDDB,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, JSocket, SyncObjs, Grids,
  Buttons, IniFiles, MudUtil, Menus, Grobal2, LSShare, SDK, Common, AppEvnts;
type
  TConnInfo = record
    sAccount: string;
    sIPaddr: string;
    sServerName: string;
    nSessionID: Integer;
    //    boPayCost: Boolean;
    //    bo11: Boolean;
    nUserCDKey: Integer;
    dwKickTick: LongWord;
    dwStartTick: LongWord;
    boKicked: Boolean;
    nLockCount: Integer;
  end;
  pTConnInfo = ^TConnInfo;

  TFrmMain = class(TForm)
    GSocket: TServerSocket;
    ExecTimer: TTimer;
    Panel1: TPanel;
    Memo1: TMemo;
    Timer1: TTimer;
    StartTimer: TTimer;
    WebLogTimer: TTimer;
    BtnDump: TSpeedButton;
    LogTimer: TTimer;
    Panel2: TPanel;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    LbMasCount: TLabel;
    CkLogin: TCheckBox;
    CbViewLog: TCheckBox;
    BtnView: TSpeedButton;
    CountLogTimer: TTimer;
    BtnShowServerUsers: TSpeedButton;
    MonitorTimer: TTimer;
    SpeedButton2: TSpeedButton;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    MENU_CONTROL_EXIT: TMenuItem;
    MENU_VIEW: TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_HELP: TMenuItem;
    MENU_HELP_ABOUT: TMenuItem;
    MENU_OPTION_GENERAL: TMenuItem;
    MENU_OPTION_ROUTE: TMenuItem;
    MENU_VIEW_SESSION: TMenuItem;
    N1: TMenuItem;
    C1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    MonitorGrid: TStringGrid;
    MENU_OPTION_SELECT: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ExecTimerTimer(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure CountLogTimerTimer(Sender: TObject);
    procedure BtnShowServerUsersClick(Sender: TObject);
    procedure MonitorTimerTimer(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure GSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure GSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure GSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure CbViewLogClick(Sender: TObject);
    procedure MENU_CONTROL_EXITClick(Sender: TObject);
    procedure MENU_OPTION_ROUTEClick(Sender: TObject);
    procedure MENU_VIEW_SESSIONClick(Sender: TObject);
    procedure MENU_HELP_ABOUTClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure MENU_OPTION_GENERALClick(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; e: Exception);
    procedure MENU_OPTION_SELECTClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BtnViewClick(Sender: TObject);
  private
    SList_0344: TStringList;
    procedure OpenRouteConfig();

  public
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;

  end;
procedure StartService(Config: pTConfig);
procedure StopService(Config: pTConfig);
procedure InitializeConfig(Config: pTConfig);
procedure UnInitializeConfig(Config: pTConfig);
procedure LoadConfig(Config: pTConfig);
procedure LoadAddrTable(Config: pTConfig);

procedure WriteLogMsg(Config: pTConfig; sType: string; var UserEntry:
  TUserEntry; var UserAddEntry: TUserEntryAdd);
procedure SaveContLogMsg(Config: pTConfig; sLogMsg: string);

procedure SendGateMsg(GateIndex: Integer; sArryIndex, sSockIndex, sMsg: string);
procedure SendGateKickMsg(Socket: TCustomWinSocket; sSockIndex: string);
procedure SendUserSocket(GateIndex: Integer; sMsg: string);
procedure SendKeepAlivePacket(GateIndex: Integer);
procedure SendGateAddBlockList(Socket: TCustomWinSocket; sSockIndex: string);
procedure SendGateAddTempBlockList(Socket: TCustomWinSocket; sSockIndex: string);

function SessionAdd(Config: pTConfig; sAccount, sIPaddr: string; nUserCDKey: Integer; sServerName: string): Integer;
procedure SessionDel(Config: pTConfig; nSessionID: Integer);
procedure SessionKick(Config: pTConfig; sLoginID: string);
procedure SessionGoldChange(Config: pTConfig; sLoginID: string; nGmaeGold: Integer);

procedure SessionClearKick(Config: pTConfig);
function IsPayMent(Config: pTConfig; sIPaddr, sAccount: string): Boolean;

function IsLogin(Config: pTConfig; sLoginID: string): Boolean; overload;
//function IsLogin(Config: pTConfig; nSessionID: Integer): Boolean; overload;

function GetSelGateInfo(Config: pTConfig; sGateIP: string; var nPort: Integer): string;

//function KickUser(Config: pTConfig; UserInfo: pTUserInfo{; nKickType: Integer}): Boolean;
procedure CloseUser(Config: pTConfig; sAccount: string; nSessionID: Integer);

{procedure AccountLogin(Config: pTConfig; UserInfo: pTUserInfo; sData: string);
procedure AccountUpdateUserInfo(Config: pTConfig; UserInfo: pTUserInfo; sData: string);
procedure AccountGetBackPassword(UserInfo: pTUserInfo; sData: string);      }
function GetWaitMsgID(): Integer;
{$IF RUNVAR = VAR_SQL}
procedure AccountLogin(Config: pTConfig; UserInfo: pTUserInfo; sData: string);
{$IFEND}
{$IF RUNVAR = VAR_DB}
procedure AccountLogin(GateIndex: Integer; Config: pTConfig; UserInfo: pTUserInfo; sData: string);
{$IFEND}
procedure CheckMatrixCard(GateIndex: Integer; Config: pTConfig; UserInfo: pTUserInfo; nCard1, nCard2, nCard3: Byte);

procedure ReceiveSendUser(Config: pTConfig; sArryIndex, sSockIndex: string; GateIndex: Integer; sData: string; UserList: TList);
procedure ReceiveOpenUser(Config: pTConfig; sArryIndex, sSockIndex: string; sIPaddr: string; UserList: TList);
procedure ReceiveCloseUser(Config: pTConfig; sArryIndex, sSockIndex: string; UserList: TList);

procedure ProcessUserMsg(Config: pTConfig; UserInfo: pTUserInfo; sMsg: string; GateIndex: Integer);

procedure DecodeGateData(Config: pTConfig; GateIndex: Integer; sReadData: string; UserList: TList);
//procedure DecodeUserData(Config: pTConfig; UserInfo: pTUserInfo; sMsg: string);
procedure ProcessGate(Config: pTConfig);

{procedure LoadAccountCostList(Config: pTConfig; QuickList: TQuickList);
procedure LoadIPaddrCostList(Config: pTConfig; QuickList: TQuickList);       }
var
  FrmMain: TFrmMain;

implementation

uses MasSock, HUtil32, EDcode, GrobalSession, BasicSet, TestSelGate, RouteManage, SqlSock, FrmVarsion, FrmFindId;

{$R *.DFM}

procedure TFrmMain.OpenRouteConfig;
begin
  frmRouteManage.Open;
end;

procedure TFrmMain.MENU_OPTION_ROUTEClick(Sender: TObject);
begin
  OpenRouteConfig();
end;

procedure TFrmMain.MENU_OPTION_SELECTClick(Sender: TObject);
begin
  frmTestSelGate := TfrmTestSelGate.Create(Owner);
  frmTestSelGate.ShowModal;
  frmTestSelGate.Free;
end;

procedure TFrmMain.MENU_VIEW_SESSIONClick(Sender: TObject);
begin
  frmGrobalSession := TfrmGrobalSession.Create(nil);
  frmGrobalSession.Open;
  frmGrobalSession.Free;
end;

procedure TFrmMain.CbViewLogClick(Sender: TObject);
var
  Config: pTConfig;
begin
  Config := @g_Config;
  Config.boShowDetailMsg := CbViewLog.Checked;
end;

procedure TFrmMain.GSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  //GateInfo: pTGateInfo;
  Config: pTConfig;
  i: integer;
begin
  Config := @g_Config;
  Socket.nIndex := -1;

  if not ExecTimer.Enabled then begin
    Socket.Close;
    Exit;
  end;

  EnterCriticalSection(Config.GateCriticalSection);
  try
    for i := 0 to MAXGATELIST - 1 do begin
      if (Config.GateList[i].Socket = nil) and (Config.GateList[i].UserList = nil) then begin
        Config.GateList[i].Socket := Socket;
        Config.GateList[i].sIPaddr := Socket.RemoteAddress;
        Config.GateList[i].sReceiveMsg := '';
        Config.GateList[i].sSendMsg := '';

        //Config.GateList[i].sSendMsg := '';
        Config.GateList[i].UserList := TList.Create;
        //Config.GateList[i].dwKeepAliveTick := GetTickCount;
        Config.GateList[i].boDelete := False;
        Socket.nIndex := i;
        break;
      end;
    end;
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;
  if Socket.nIndex = -1 then begin
    MainOutMessage('超过连接数量');
    Socket.Close;
  end;
end;

procedure TFrmMain.GSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  //II: Integer;
  //GateInfo: pTGateInfo;
  //UserInfo: pTUserInfo;
  //Config: pTConfig;
begin
  //Config := @g_Config;
  I := Socket.nIndex;
  if (I >= 0) and (i < MAXGATELIST) then begin
    EnterCriticalSection(g_Config.GateCriticalSection);
    try
      g_Config.GateList[i].boDelete := True;
      g_Config.GateList[i].Socket := nil;
      g_Config.GateList[i].sReceiveMsg := '';
      g_Config.GateList[i].sSendMsg := '';
    finally
      LeaveCriticalSection(g_Config.GateCriticalSection);
    end;
  end;
  {for II := 0 to GateInfo.UserList.Count - 1 do begin
            UserInfo := GateInfo.UserList.Items[II];
            if Config.boShowDetailMsg then
              MainOutMessage('Close: ' + UserInfo.sUserIPaddr);
            Dispose(UserInfo);
          end;
          GateInfo.UserList.Free; }
end;

procedure TFrmMain.GSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmMain.GSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  //GateInfo: pTGateInfo;
  //Config: pTConfig;
begin
  I := Socket.nIndex;
  if (I >= 0) and (i < MAXGATELIST) then begin
    EnterCriticalSection(g_Config.GateCriticalSection);
    try
      // fixme debug
      //MainOutMessage('GSocketClientRead: '+Socket.ReceiveText);
      g_Config.GateList[i].sReceiveMsg := g_Config.GateList[i].sReceiveMsg + Socket.ReceiveText;

    finally
      LeaveCriticalSection(g_Config.GateCriticalSection);
    end;
  end;
  {Config := @g_Config;
  EnterCriticalSection(Config.GateCriticalSection);
  try
    for I := 0 to Config.GateList.Count - 1 do begin
      GateInfo := Config.GateList.Items[I];
      if GateInfo.Socket = Socket then begin
        GateInfo.sReceiveMsg := GateInfo.sReceiveMsg + Socket.ReceiveText;
        break;
      end;
    end;
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;}
end;

procedure LoadAddrTable(Config: pTConfig);
var
  i: Integer;
  LoadList: TStringList;
  nRouteIdx, nGateIdx: Integer;
  sLineText, sSelGateIPaddr, sGameGateIPaddr, sGameGate, sGameGatePort: string;
begin
  try
    LoadList := TStringList.Create;
    SafeFillChar(Config.GateRoute, SizeOf(Config.GateRoute), #0);
    LoadList.LoadFromFile(sGateConfFileName);
    nRouteIdx := 0;

    for i := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[i]);
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sGameGate := GetValidStr3(sLineText, sSelGateIPaddr, [' ', #9]);
        if (sGameGate = '') or (sSelGateIPaddr = '') then
          Continue;
        Config.GateRoute[nRouteIdx].sSelGateIP := Trim(sSelGateIPaddr);
        Config.GateRoute[nRouteIdx].nGateCount := 0;
        nGateIdx := 0;
        while (sGameGate <> '') do begin
          sGameGate := GetValidStr3(sGameGate, sGameGateIPaddr, [' ', #9]);
          sGameGate := GetValidStr3(sGameGate, sGameGatePort, [' ', #9]);
          Config.GateRoute[nRouteIdx].sGameGateIP[nGateIdx] := Trim(sGameGateIPaddr);
          Config.GateRoute[nRouteIdx].nGameGatePort[nGateIdx] :=
            StrToIntDef(sGameGatePort, 0);
          Inc(nGateIdx);
        end;
        Config.GateRoute[nRouteIdx].nGateCount := nGateIdx;
        Inc(nRouteIdx);
      end;
    end;
  finally
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  nX, nY: Integer;
  Config: pTConfig;
begin
  Randomize;
  Config := @g_Config;
  g_dwGameCenterHandle := StrToIntDef(ParamStr(1), 0);
  nX := StrToIntDef(ParamStr(2), -1);
  nY := StrToIntDef(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top := nY;
  end;
  Config.boRemoteClose := False;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));

  Config := @g_Config;
  StartService(Config);

  AccountDB := nil;

  CS_DB := TCriticalSection.Create;
  StringList_0 := TStringList.Create;
  nSessionIdx := 1;
  n47328C := 1;
  nMemoHeigh := Memo1.Height;
{$IF RUNVAR = VAR_SQL}
  SpeedButton1.Enabled := False;
  Caption := Caption + ' - SQL版';
{$IFEND}
  //Config.GateList := TList.Create;
  Config.SessionList := TGList.Create;

  SList_0344 := TStringList.Create;

  LoadAddrTable(Config);

  MonitorGrid.Cells[0, 0] := '服务器名';
  MonitorGrid.Cells[1, 0] := '编号';
  MonitorGrid.Cells[2, 0] := '用户数';
  MonitorGrid.Cells[3, 0] := '状态';
  MonitorGrid.Cells[4, 0] := '选号';
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
var
  //  I, II: Integer;
  //  GateInfo: pTGateInfo;
  //  UserInfo: pTUserInfo;
  Config: pTConfig;

begin
  Config := @g_Config;
  StopService(Config);
  if AccountDB <> nil then
    AccountDB.Free;
  {for I := 0 to Config.GateList.Count - 1 do begin
    GateInfo := Config.GateList.Items[I];
    for II := 0 to GateInfo.UserList.Count - 1 do begin
      UserInfo := GateInfo.UserList.Items[I];
      Dispose(UserInfo);
    end;
    GateInfo.UserList.Free;
    Dispose(GateInfo);
  end;   }
  //Config.GateList.Free;
  Config.SessionList.Free;

  SList_0344.Free;
  StringList_0.Free;
  CS_DB.Free;
end;

procedure TFrmMain.ExecTimerTimer(Sender: TObject);
var
  Config: pTConfig;
begin
  if bo470D20 and not g_boDataDBReady then
    Exit;
  bo470D20 := true;
  try
    Config := @g_Config;
    ProcessGate(Config);
  finally
    bo470D20 := False;
  end;
end;

procedure TFrmMain.Memo1DblClick(Sender: TObject);
begin
  OpenRouteConfig();
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
var
  I: Integer;
var
  Config: pTConfig;
begin
  Config := @g_Config;
  Label1.Caption := IntToStr(Config.dwProcessGateTime);
  CkLogin.Checked := GSocket.Socket.Connected;
  CkLogin.Caption := '连接 (' + IntToStr(GSocket.Socket.ActiveConnections) + ')';
  LbMasCount.Caption := IntToStr(nOnlineCountMin) + '/' + IntToStr(nOnlineCountMax);
  if Memo1.Lines.Count > 200 then
    Memo1.Clear;
  EnterCriticalSection(g_OutMessageCS);
  try
    for I := 0 to g_MainMsgList.Count - 1 do begin
      Memo1.Lines.Add(g_MainMsgList.Strings[I]);
    end;
    g_MainMsgList.Clear;
  finally
    LeaveCriticalSection(g_OutMessageCS);
  end;
  I := 0;
  while (true) do begin
    if StringList_0.Count <= I then
      break;
    if GetTickCount - LongWord(StringList_0.Objects[I]) > 60000 then begin
      StringList_0.Delete(I);
      Continue;
    end;
    Inc(I);
  end;
  SessionClearKick(Config);

end;

procedure TFrmMain.StartTimerTimer(Sender: TObject);
var
  Config: pTConfig;
begin
  StartTimer.Enabled := False;
  Config := @g_Config;
  SendGameCenterMsg(SG_STARTNOW, '正在启动登录服务器...');
  MainOutMessage('正在启动服务器...');
  Application.ProcessMessages;

{$IF RUNVAR = VAR_DB}
  AccountDB := TFileIDDB.Create(Config.sIdDir + 'Id.DB');
{$IFEND}
  //MainOutMessage('正在等待服务器连接...');
  {while (true) do begin
    Application.ProcessMessages;
    if Application.Terminated then
      Exit;
    if FrmMasSoc.CheckReadyServers then
      break;
    Sleep(1);
  end;   }
  GSocket.Active := False;
  GSocket.Address := Config.sGateAddr;
  GSocket.Port := Config.nGatePort;
  GSocket.Active := true;
{$IF RUNVAR = VAR_SQL}
  MainOutMessage('正在连接SQL服务器...');
  FrmSqlSock.SqlSocket.Active := true;
{$IFEND}
  ExecTimer.Enabled := true;

  MainOutMessage('服务器启动完成...');
  SendGameCenterMsg(SG_STARTOK, '登录服务器启动完成...');
end;

procedure TFrmMain.MENU_CONTROL_EXITClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Config: pTConfig;
resourcestring
  sExitMsg = '是否确认停止登录服务器 ?';
  sExitTitle = '确认信息';
begin
  Config := @g_Config;
  if Config.boRemoteClose then begin

    Exit;
  end;
  if MessageBox(Handle, PChar(sExitMsg), PChar(sExitTitle), MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    CanClose := true
  end
  else
    CanClose := False;
end;

procedure TFrmMain.CountLogTimerTimer(Sender: TObject);
var
  sLogMsg: string;
  Config: pTConfig;
resourcestring
  sFormatMsg = '%d/%d';
begin
  Config := @g_Config;
  sLogMsg := format(sFormatMsg, [nOnlineCountMin, nOnlineCountMax]);
  SaveContLogMsg(Config, sLogMsg);
  nOnlineCountMax := 0;
end;

procedure TFrmMain.BtnShowServerUsersClick(Sender: TObject);
begin

  MainOutMessage(UserLimit.sServerName + ' ' +
    IntToStr(UserLimit.nLimitCountMin) + '/' +
    IntToStr(UserLimit.nLimitCountMax));

end;

procedure TFrmMain.BtnViewClick(Sender: TObject);
begin
  FormVersion := TFormVersion.Create(Owner);
  FormVersion.Open;
  FormVersion.Free;
end;

procedure TFrmMain.MonitorTimerTimer(Sender: TObject);
var
  I: Integer;

  sServerName: string;
  ServerList: TGList;
  MsgServer: pTMsgServerInfo;
  TickTime: LongWord;
begin
  ServerList := FrmMasSoc.m_ServersList;
  ServerList.Lock;
  try
    try

      if ServerList.Count = 0 then begin
        MonitorGrid.RowCount := 2;
        MonitorGrid.Cells[0, 1] := '';
        MonitorGrid.Cells[1, 1] := '';
        MonitorGrid.Cells[2, 1] := '';
        MonitorGrid.Cells[3, 1] := '';
        MonitorGrid.Cells[4, 1] := '';
        MonitorGrid.RowCount := ServerList.Count + 2
      end
      else
        MonitorGrid.RowCount := ServerList.Count + 1;
      for i := 0 to ServerList.Count - 1 do begin
        MsgServer := ServerList.Items[I];
        sServerName := MsgServer.sServerName;
        if sServerName <> '' then begin
          MonitorGrid.Cells[0, I + 1] := sServerName;
          if MsgServer.nServerIndex = 0 then
            MonitorGrid.Cells[1, I + 1] := '[M2]'
          else if MsgServer.nServerIndex = 99 then
            MonitorGrid.Cells[1, I + 1] := '[DB]'
          else
            MonitorGrid.Cells[1, I + 1] := IntToStr(MsgServer.nServerIndex);
          MonitorGrid.Cells[2, I + 1] := IntToStr(MsgServer.nOnlineCount);
          MonitorGrid.Cells[4, I + 1] := IntToStr(MsgServer.nSelectID);
          TickTime := GetTickCount - MsgServer.dwKeepAliveTick;

          if TickTime < 30000 then
            MonitorGrid.Cells[3, I + 1] := '正常'
          else
            MonitorGrid.Cells[3, I + 1] := '超时';
          if TickTime > 60000 then begin
            MsgServer.Socket.Close;
            exit;
          end;
        end
        else begin
          MonitorGrid.Cells[0, I + 1] := '-';
          MonitorGrid.Cells[1, I + 1] := '-';
          MonitorGrid.Cells[2, I + 1] := '-';
          MonitorGrid.Cells[3, I + 1] := '-';
          MonitorGrid.Cells[4, I + 1] := '-';
        end;
      end;

    except
      MainOutMessage('TFrmMain.MonitorTimerTimer');
    end;
  finally
    ServerList.UnLock;
  end;
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
  FrmFindUserId.Top := Top;
  FrmFindUserId.Left := Left;
  FrmFindUserId.Show;
end;

procedure TFrmMain.SpeedButton2Click(Sender: TObject);
begin
  if Memo1.Height = nMemoHeigh then
    Memo1.Height := nMemoHeigh * 3
  else
    Memo1.Height := nMemoHeigh;
end;

function IsPayMent(Config: pTConfig; sIPaddr, sAccount: string): Boolean;
begin
  Result := False;

end;

procedure CloseUser(Config: pTConfig; sAccount: string; nSessionID: Integer);
var
  ConnInfo: pTConnInfo;
  I: Integer;
begin
  Config.SessionList.Lock;
  try
    for I := Config.SessionList.Count - 1 downto 0 do begin
      ConnInfo := Config.SessionList.Items[I];
      if (ConnInfo.sAccount = sAccount) or (ConnInfo.nSessionID = nSessionID) then begin
        FrmMasSoc.SendServerMsg(SS_CLOSESESSION, ConnInfo.sServerName,
          ConnInfo.sAccount + '/' + IntToStr(ConnInfo.nSessionID));
        Dispose(ConnInfo);
        Config.SessionList.Delete(I);
      end;
    end;
  finally
    Config.SessionList.UnLock;
  end;
end;

procedure ProcessGate(Config: pTConfig);
var
  I, II: Integer;
  sReceiveMsg, sData: string;
  UserInfo: pTUserInfo;
  UserList: TList;
  nSendLen: Integer;
begin
  Config.dwProcessGateTick := GetTickCount();
  for i := 0 to MAXGATELIST - 1 do begin
    EnterCriticalSection(Config.GateCriticalSection);
    try
      sReceiveMsg := '';
      UserList := nil;
      if Config.GateList[I].boDelete and (Config.GateList[I].UserList <> nil) then begin
        for II := 0 to Config.GateList[I].UserList.Count - 1 do begin
          UserInfo := Config.GateList[I].UserList.Items[II];
          if Config.boShowDetailMsg then
            MainOutMessage('Close: ' + UserInfo.sUserIPaddr);
          Dispose(UserInfo);
        end;
        Config.GateList[I].sReceiveMsg := '';
        Config.GateList[I].sSendMsg := '';
        Config.GateList[I].UserList.Free;
        Config.GateList[I].UserList := nil;
        Config.GateList[I].boDelete := False;
      end
      else if (Config.GateList[I].Socket <> nil) then begin
        if (Config.GateList[I].sSendMsg <> '') then begin
          while (Config.GateList[I].sSendMsg <> '') do begin
            nSendLen := Length(Config.GateList[I].sSendMsg);
            // fixme debug
//            MainOutMessage('Config.GateList'+IntToStr(I)+'.sSendMsg: '+Config.GateList[I].sSendMsg);
            if nSendLen > MAXSOCKETBUFFLEN then begin
              sData := Copy(Config.GateList[I].sSendMsg, 1, MAXSOCKETBUFFLEN);
              if Config.GateList[I].Socket.SendText(sData) <> -1 then begin
                Config.GateList[I].sSendMsg := Copy(Config.GateList[I].sSendMsg, MAXSOCKETBUFFLEN + 1,
                  nSendLen - MAXSOCKETBUFFLEN);
              end
              else
                break;
            end
            else begin
              if Config.GateList[I].Socket.SendText(Config.GateList[I].sSendMsg) <> -1 then
                Config.GateList[I].sSendMsg := '';
              break;
            end;
          end;
        end;
        if (Config.GateList[I].sReceiveMsg <> '') then begin
          Config.sGateIPaddr := Config.GateList[I].sIPaddr;
          sReceiveMsg := Config.GateList[I].sReceiveMsg;
          Config.GateList[I].sReceiveMsg := '';
          UserList := Config.GateList[I].UserList;
        end;
      end;
    finally
      LeaveCriticalSection(Config.GateCriticalSection);
    end;
    if (sReceiveMsg <> '') and (UserList <> nil) then begin
      DecodeGateData(Config, I, sReceiveMsg, UserList);
    end;
  end;
  if Config.dwProcessGateTime < Config.dwProcessGateTick then
    Config.dwProcessGateTime := GetTickCount - Config.dwProcessGateTick;
  if Config.dwProcessGateTime > 100 then
    Dec(Config.dwProcessGateTime, 100);
end;

procedure DecodeGateData(Config: pTConfig; GateIndex: Integer; sReadData: string; UserList: TList);
var
  nCount: Integer;
  sMsg: string;
  sSockIndex: string;
  sArryIndex: string;
  sData: string;
  Code: Char;
begin
  try
    nCount := 0;
    // fixme debug
    //MainOutMessage('DecodeGateData: '+sReadData);
    while (true) do begin
      if pos(MG_CodeEnd, sReadData) <= 0 then
        break;
      sReadData := ArrestStringEx(sReadData, MG_CodeHead, MG_CodeEnd, sMsg);
      if sMsg <> '' then begin
        Code := sMsg[1];
        sMsg := Copy(sMsg, 2, length(sMsg) - 1);
        case Code of
          '-': begin
              SendKeepAlivePacket(GateIndex);
            end;
          MG_SendUser: begin
              sData := GetValidStr3(sMsg, sArryIndex, ['/']);
              sData := GetValidStr3(sData, sSockIndex, ['/']);
              if sSockIndex <> '' then
                ReceiveSendUser(Config, sArryIndex, sSockIndex, GateIndex, sData, UserList);
            end;
          MG_OpenUser: begin
              sData := GetValidStr3(sMsg, sArryIndex, ['/']);
              sData := GetValidStr3(sData, sSockIndex, ['/']);
              if sSockIndex <> '' then
                ReceiveOpenUser(Config, sArryIndex, sSockIndex, sData, UserList);
            end;
          MG_CloseUser: begin
              sSockIndex := GetValidStr3(sMsg, sArryIndex, ['/']);
              if sSockIndex <> '' then
                ReceiveCloseUser(Config, sArryIndex, sSockIndex, UserList);
            end;
        end;
      end
      else begin
        if nCount >= 1 then
          sReadData := '';
        Inc(nCount);
      end;
    end;
    if sReadData <> '' then begin
      EnterCriticalSection(Config.GateCriticalSection);
      try
        Config.GateList[GateIndex].sReceiveMsg := sReadData + Config.GateList[GateIndex].sReceiveMsg;
      finally
        LeaveCriticalSection(Config.GateCriticalSection);
      end;
    end;
  except
    MainOutMessage('[Exception] TFrmMain.DecodeGateData');
  end;
end;

procedure SendKeepAlivePacket(GateIndex: Integer);
begin
  SendUserSocket(GateIndex, MG_CodeHead + '++' + MG_CodeEnd);
  {if Socket.Connected then
    Socket.SendText(MG_CodeHead + '++' + MG_CodeEnd);  }
end;

procedure SendUserSocket(GateIndex: Integer; sMsg: string);
begin
  EnterCriticalSection(g_Config.GateCriticalSection);
  try
    if (g_Config.GateList[GateIndex].Socket <> nil) and (g_Config.GateList[GateIndex].Socket.Connected) then begin
      if g_Config.GateList[GateIndex].sSendMsg <> '' then begin
        g_Config.GateList[GateIndex].sSendMsg := g_Config.GateList[GateIndex].sSendMsg + sMsg;
      end
      else if g_Config.GateList[GateIndex].Socket.SendText(sMsg) = -1 then begin
        g_Config.GateList[GateIndex].sSendMsg := sMsg;
      end;
    end;
  finally
    LeaveCriticalSection(g_Config.GateCriticalSection);
  end;
end;

procedure ReceiveCloseUser(Config: pTConfig; sArryIndex, sSockIndex: string; UserList: TList);
var
  UserInfo: pTUserInfo;
  I: Integer;
resourcestring
  sCloseMsg = 'Close: %s';
begin
  for I := 0 to UserList.Count - 1 do begin
    UserInfo := UserList.Items[I];
    if UserInfo.sArryIndex = sArryIndex then begin
      if Config.boShowDetailMsg then
        MainOutMessage(format(sCloseMsg, [UserInfo.sUserIPaddr]));
      if not UserInfo.boSelServer then
        SessionDel(Config, UserInfo.nSessionID);
      Dispose(UserInfo);
      UserList.Delete(I);
      break;
    end;
  end;
  {EnterCriticalSection(Config.GateCriticalSection);
  Try
    for I := 0 to g_Config.GateList[GateIndex].UserList.Count - 1 do begin
      UserInfo := g_Config.GateList[GateIndex].UserList.Items[I];
      if UserInfo.sArryIndex = sArryIndex then begin
        if Config.boShowDetailMsg then
          MainOutMessage(format(sCloseMsg, [UserInfo.sUserIPaddr]));
        if not UserInfo.boSelServer then
          SessionDel(Config, UserInfo.nSessionID);
        Dispose(UserInfo);
        g_Config.GateList[GateIndex].UserList.Delete(I);
        break;
      end;
    end;
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end; }
end;

procedure ReceiveOpenUser(Config: pTConfig; sArryIndex, sSockIndex, sIPaddr: string; UserList: TList);
var
  UserInfo: pTUserInfo;
  I: Integer;
  sGateIPaddr: string;
  sUserIPaddr: string;
resourcestring
  sOpenMsg = 'Open: %s/%s';
begin
  sGateIPaddr := GetValidStr3(sIPaddr, sUserIPaddr, ['/']);
  try
    for I := 0 to UserList.Count - 1 do begin
      UserInfo := UserList.Items[I];
      if (UserInfo.sArryIndex = sArryIndex) then begin
        UserInfo.sUserIPaddr := sUserIPaddr;
        UserInfo.sGateIPaddr := sGateIPaddr;
        UserInfo.sSockIndex := sSockIndex;
        UserInfo.sAccount := '';
        UserInfo.nSessionID := 0;
        UserInfo.nUserCDKey := 0;
        UserInfo.nGameGold := 0;
        UserInfo.nCheckEMail := 0;
        UserInfo.nWaitMsgID := 0;
        UserInfo.boWaitMsg := False;
        UserInfo.boMatrixCardCheck := False;
        Exit;
      end;
    end;
    New(UserInfo);
    UserInfo.sAccount := '';
    UserInfo.sUserIPaddr := sUserIPaddr;
    UserInfo.sGateIPaddr := sGateIPaddr;
    UserInfo.sSockIndex := sSockIndex;
    UserInfo.sArryIndex := sArryIndex;
    UserInfo.nUserCDKey := 0;
    UserInfo.nGameGold := 0;
    UserInfo.nCheckEMail := 0;
    UserInfo.nSessionID := 0;
    UserInfo.nWaitMsgID := 0;
    UserInfo.boWaitMsg := False;
    UserInfo.boMatrixCardCheck := False;
    UserList.Add(UserInfo);
    if Config.boShowDetailMsg then
      MainOutMessage(format(sOpenMsg, [sUserIPaddr, sGateIPaddr]));
  except
    MainOutMessage('TFrmMain.ReceiveOpenUser');
  end;
  { EnterCriticalSection(Config.GateCriticalSection);
   Try
     try
       for I := 0 to g_Config.GateList[GateIndex].UserList.Count - 1 do begin
         UserInfo := g_Config.GateList[GateIndex].UserList.Items[I];
         if (UserInfo.sArryIndex = sArryIndex) then begin
           UserInfo.sUserIPaddr := sUserIPaddr;
           UserInfo.sGateIPaddr := sGateIPaddr;
           UserInfo.sSockIndex := sSockIndex;
           UserInfo.sAccount := '';
           UserInfo.nSessionID := 0;
           UserInfo.nUserCDKey := 0;
           UserInfo.nGameGold := 0;
           UserInfo.boMatrixCardCheck := False;
           Exit;
         end;
       end;
       New(UserInfo);
       UserInfo.sAccount := '';
       UserInfo.sUserIPaddr := sUserIPaddr;
       UserInfo.sGateIPaddr := sGateIPaddr;
       UserInfo.sSockIndex := sSockIndex;
       UserInfo.sArryIndex := sArryIndex;
       UserInfo.nUserCDKey := 0;
       UserInfo.nGameGold := 0;
       UserInfo.nSessionID := 0;
       UserInfo.boMatrixCardCheck := False;
       g_Config.GateList[GateIndex].UserList.Add(UserInfo);
       if Config.boShowDetailMsg then
         MainOutMessage(format(sOpenMsg, [sUserIPaddr, sGateIPaddr]));
     except
       MainOutMessage('TFrmMain.ReceiveOpenUser');
     end;
   Finally
     LeaveCriticalSection(Config.GateCriticalSection);
   End; }

end;

procedure ReceiveSendUser(Config: pTConfig; sArryIndex, sSockIndex: string; GateIndex: Integer; sData: string;
  UserList: TList);
var
  UserInfo: pTUserInfo;
  I: Integer;
  sMsg: string;
begin

    // fixme debug
//    MainOutMessage('ReceiveSendUser: '+sData);
  try
    for I := UserList.Count - 1 downto 0 do begin
      UserInfo := UserList.Items[I];
      if UserInfo.sArryIndex = sArryIndex then begin

        if length(sData) < 512 then begin
          //if Pos(g_CodeEnd, sMsg) <= 0 then exit;
          ArrestStringEx(sData, g_CodeHead, g_CodeEnd, sMsg);
          if sMsg <> '' then begin
            sMsg := Copy(sMsg, 2, length(sMsg) - 1);
            if Length(sMsg) >= DEFBLOCKSIZE then
              ProcessUserMsg(Config, UserInfo, sMsg, GateIndex);
          end;
        end
        else
          MainOutMessage('[攻击] ' + UserInfo.sUserIPaddr + ' 长度：' + IntToStr(length(sData)));
        break;
      end;
    end;
  except
    MainOutMessage('TFrmMain.ReceiveSendUser');
  end;
end;

procedure SessionClearKick(Config: pTConfig);
var
  I: Integer;
  ConnInfo: pTConnInfo;
begin
  Config.SessionList.Lock;
  try
    for I := Config.SessionList.Count - 1 downto 0 do begin
      ConnInfo := Config.SessionList.Items[I];
      if ConnInfo.boKicked and ((GetTickCount - ConnInfo.dwKickTick) > 3 * 1000) then begin
        Dispose(ConnInfo);
        Config.SessionList.Delete(I);
      end;
    end;
  finally
    Config.SessionList.UnLock;
  end;
end;
{
procedure DecodeUserData(Config: pTConfig; UserInfo: pTUserInfo; sMsg: string);
begin
  try
    if TagCount(UserInfo.sReceiveMsg, g_CodeEnd) <= 0 then break;
    ArrestStringEx(sMsg, g_CodeHead, g_CodeEnd, sMsg);
    if sMsg <> '' then begin
      if length(sMsg) >= DEFBLOCKSIZE + 1 then begin
        sMsg := Copy(sMsg, 2, length(sMsg) - 1);
        ProcessUserMsg(Config, UserInfo, sMsg);
      end;
    end
    else begin
      UserInfo.sReceiveMsg := '';
      break;
    end;
    if UserInfo.sReceiveMsg = '' then break;
  except
    MainOutMessage('[Exception] TFrmMain.DecodeUserData ');
  end;
end;   }

procedure SessionDel(Config: pTConfig; nSessionID: Integer);
var
  ConnInfo: pTConnInfo;
  I: Integer;
begin
  Config.SessionList.Lock;
  try
    for I := 0 to Config.SessionList.Count - 1 do begin
      ConnInfo := Config.SessionList.Items[I];
      if ConnInfo.nSessionID = nSessionID then begin
        Dispose(ConnInfo);
        Config.SessionList.Delete(I);
        break;
      end;
    end;
  finally
    Config.SessionList.UnLock;
  end;
end;

procedure AccountCreate(GateIndex: Integer; Config: pTConfig; UserInfo: pTUserInfo; sData: string);
var
  UserEntry: TUserEntry;
  UserAddEntry: TUserEntryAdd;
  DBRecord: TAccountDBRecord;
  nLen: Integer;
  sUserEntryMsg: string;
  sUserAddEntryMsg: string;
  nErrCode: Integer;
  DefMsg: TDefaultMessage;
  bo21: Boolean;
  n10: Integer;
resourcestring
  sAddNewuserFail = '[新建帐号失败] %s/%s';
  sLogFlag = 'new';
begin
  try
    nErrCode := -1;
    SafeFillChar(UserEntry, SizeOf(TUserEntry), #0);
    SafeFillChar(UserAddEntry, SizeOf(TUserEntryAdd), #0);
    nLen := GetCodeMsgSize(SizeOf(TUserEntry) * 4 / 3);
    bo21 := False;
    sUserEntryMsg := Copy(sData, 1, nLen);
    sUserAddEntryMsg := Copy(sData, nLen + 1, length(sData) - nLen);
    if (sUserEntryMsg <> '') and (sUserAddEntryMsg <> '') then begin
      DecodeBuffer(sUserEntryMsg, @UserEntry, SizeOf(TUserEntry));
      DecodeBuffer(sUserAddEntryMsg, @UserAddEntry, SizeOf(TUserEntryAdd));
      if CheckAccountName(UserEntry.sAccount) then
        bo21 := true;
      if bo21 then begin
        try
          if AccountDB.Open then begin
            n10 := AccountDB.Index(UserEntry.sAccount);
            if n10 < 0 then begin
              SafeFillChar(DBRecord, SizeOf(TAccountDBRecord), #0);
              DBRecord.UserEntry := UserEntry;
              DBRecord.UserEntryAdd := UserAddEntry;
              if UserEntry.sAccount <> '' then begin
                if AccountDB.Add(DBRecord) then begin
                  nErrCode := 1;
                end;
              end;
            end
            else
              nErrCode := 0;
          end;
        finally
          AccountDB.Close;
        end;
      end
      else begin
        MainOutMessage(format(sAddNewuserFail, [UserEntry.sAccount, UserAddEntry.sQuiz2]));
      end;
    end;
    if nErrCode = 1 then begin
      WriteLogMsg(Config, sLogFlag, UserEntry, UserAddEntry);
      DefMsg := MakeDefaultMsg(SM_NEWID_SUCCESS, 0, 0, 0, 0);
    end
    else begin
      DefMsg := MakeDefaultMsg(SM_NEWID_FAIL, nErrCode, 0, 0, 0);
    end;
    SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
  except
    MainOutMessage('TFrmMain.AddNewUser');
  end;
end;

procedure AccountChangePassword(GateIndex: Integer; Config: pTConfig; UserInfo: pTUserInfo; sData: string);
var
  sMsg: string;
  sLoginID: string;
  sOldPassword: string;
  sNewPassword: string;
  DefMsg: TDefaultMessage;
  nCode: Integer;
  n10: Integer;
  DBRecord: TAccountDBRecord;
resourcestring
  sChgMsg = 'chg';
begin
  try
    sMsg := DecodeString(sData);
    sMsg := GetValidStr3(sMsg, sLoginID, [#9]);
    sNewPassword := GetValidStr3(sMsg, sOldPassword, [#9]);
    nCode := 0;
    try
      if AccountDB.Open and (length(sNewPassword) >= 3) then begin
        n10 := AccountDB.Index(sLoginID);
        if (n10 >= 0) and (AccountDB.Get(n10, DBRecord) >= 0) then begin

          if (DBRecord.nErrorCount < 5) or ((GetTickCount - DBRecord.dwActionTick) > 180000) then begin
            if DBRecord.UserEntry.sPassword = sOldPassword then begin
              DBRecord.nErrorCount := 0;
              DBRecord.UserEntry.sPassword := sNewPassword;
              nCode := 1;
            end
            else begin
              Inc(DBRecord.nErrorCount);
              DBRecord.dwActionTick := GetTickCount();
              nCode := -1;
            end;
            AccountDB.Update(n10, DBRecord);
          end
          else begin
            nCode := -2;
            if GetTickCount < DBRecord.dwActionTick then begin
              DBRecord.dwActionTick := GetTickCount();
              AccountDB.Update(n10, DBRecord);
            end;
          end;
        end;
      end;
    finally
      AccountDB.Close;
    end;
    if nCode = 1 then begin
      DefMsg := MakeDefaultMsg(SM_CHGPASSWD_SUCCESS, 0, 0, 0, 0);
      WriteLogMsg(Config, sChgMsg, DBRecord.UserEntry, DBRecord.UserEntryAdd);
    end
    else begin
      DefMsg := MakeDefaultMsg(SM_CHGPASSWD_FAIL, nCode, 0, 0, 0);
    end;
    SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
  except
    MainOutMessage('TFrmMain.ChangePassword');
  end;
end;

procedure AccountGetBackPassword(GateIndex: Integer; Config: pTConfig; UserInfo: pTUserInfo; sData: string);
var
  sMsg: string;
  sAccount: string;
  sQuest1: string;
  sAnswer1: string;
  sQuest2: string;
  sAnswer2: string;
  sPassword: string;
  sBirthDay: string;
  nCode: Integer;
  nIndex: Integer;
  DefMsg: TDefaultMessage;
  DBRecord: TAccountDBRecord;
begin
  sMsg := DecodeString(sData);
  sMsg := GetValidStr3(sMsg, sAccount, [#9]);
  sMsg := GetValidStr3(sMsg, sQuest1, [#9]);
  sMsg := GetValidStr3(sMsg, sAnswer1, [#9]);
  sMsg := GetValidStr3(sMsg, sQuest2, [#9]);
  sMsg := GetValidStr3(sMsg, sAnswer2, [#9]);
  sMsg := GetValidStr3(sMsg, sBirthDay, [#9]);

  nCode := 0;
  try
    if (sAccount <> '') and AccountDB.Open then begin
      nIndex := AccountDB.Index(sAccount);
      if (nIndex >= 0) and (AccountDB.Get(nIndex, DBRecord) >= 0) then begin
        if (DBRecord.nErrorCount < 5) or ((GetTickCount - DBRecord.dwActionTick) > 180000) then begin
          nCode := -1;
          if (DBRecord.UserEntry.sQuiz = sQuest1) then begin
            nCode := -3;
            if DBRecord.UserEntry.sAnswer = sAnswer1 then begin
              if DBRecord.UserEntryAdd.sBirthDay = sBirthDay then begin
                nCode := 1;
              end;
            end;
          end;
          if nCode <> 1 then begin
            if (DBRecord.UserEntryAdd.sQuiz2 = sQuest2) then begin
              nCode := -3;
              if DBRecord.UserEntryAdd.sAnswer2 = sAnswer2 then begin
                if DBRecord.UserEntryAdd.sBirthDay = sBirthDay then begin
                  nCode := 1;
                end;
              end;
            end;
          end;
          if nCode = 1 then begin
            sPassword := DBRecord.UserEntry.sPassword;
            DBRecord.nErrorCount := 0;
            DBRecord.dwActionTick := GetTickCount();
            AccountDB.Update(nIndex, DBRecord);
          end
          else begin
            Inc(DBRecord.nErrorCount);
            DBRecord.dwActionTick := GetTickCount();
            AccountDB.Update(nIndex, DBRecord);
          end;
        end
        else begin
          nCode := -2;
          if GetTickCount < DBRecord.dwActionTick then begin
            DBRecord.dwActionTick := GetTickCount();
            AccountDB.Update(nIndex, DBRecord);
          end;
        end;
      end;
    end;
  finally
    AccountDB.Close;
  end;
  if nCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_GETBACKPASSWD_SUCCESS, 0, 0, 0, 0);
    SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg) + EncodeString(sPassword));
  end
  else begin
    DefMsg := MakeDefaultMsg(SM_GETBACKPASSWD_FAIL, nCode, 0, 0, 0);
    SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
  end;
end;

{$IF RUNVAR = VAR_DB}

procedure AccountLogin(GateIndex: Integer; Config: pTConfig; UserInfo: pTUserInfo; sData: string);
var
  sLoginID: string;
  sPassword: string;
  nCode: Integer;
  DefMsg: TDefaultMessage;
  DBRecord: TAccountDBRecord;
  n10, nDBIndex: Integer;
  sSelGateIP: string;
  nSelGatePort: Integer;
begin
  try
    sPassword := GetValidStr3(DecodeString(sData), sLoginID, ['/']);
    nCode := 0;
    nDBIndex := 0;
    try
      if AccountDB.Open then begin
        n10 := AccountDB.Index(sLoginID);
        if (n10 >= 0) then begin
          nDBIndex := AccountDB.Get(n10, DBRecord);
          if (nDBIndex >= 0) then begin

            {if (Config.boUnLockAccount) and (DBRecord.nErrorCount >= 5) and
              ((GetTickCount - DBRecord.dwActionTick) >= Config.dwUnLockAccountTime * 60 * 1000) then begin
              DBRecord.nErrorCount := 0;
              DBRecord.dwActionTick := 0;
              DBRecord.dwActionTick := GetTickCount - 70000;
            end;    }

            //if (DBRecord.nErrorCount < 5) or ((GetTickCount - DBRecord.dwActionTick) > 60000) then begin
            if DBRecord.UserEntry.sPassword = sPassword then begin
              DBRecord.nErrorCount := 0;
              //DBRecord.Header.CreateDate := UserInfo.dtDateTime;
              nCode := 1;
            end
            else begin
              Inc(DBRecord.nErrorCount);
              DBRecord.dwActionTick := GetTickCount();
              nCode := -1;
            end;
            AccountDB.Update(n10, DBRecord);
            {end
            else begin
              nCode := -2;
              DBRecord.dwActionTick := GetTickCount();
              AccountDB.Update(n10, DBRecord);
            end;  }
          end;
        end;
      end;
    finally
      AccountDB.Close;
    end;
    if (nCode = 1) and IsLogin(Config, sLoginID) then begin
      UserInfo.sAccount := '';
      SessionKick(@g_Config, sLoginID); //踢除已登录用户
      nCode := -3;
    end;
    if nCode = 1 then begin
      UserInfo.sAccount := sLoginID;
      UserInfo.nUserCDKey := nDBIndex + 1;
      UserInfo.nGameGold := 0;
      UserInfo.nCheckEMail := 0;
      sSelGateIP := GetSelGateInfo(@g_Config, g_Config.sGateIPaddr, nSelGatePort);

    // fixme debug
//    MainOutMessage('sSelGateIP: '+sSelGateIP+', nSelGatePort: '+IntToStr(nSelGatePort));
      if (sSelGateIP <> '') and (nSelGatePort > 0) then begin
        if FrmMasSoc.IsNotUserFull() then begin
          UserInfo.boSelServer := True;
          UserInfo.nSessionID := SessionAdd(@g_Config, UserInfo.sAccount, UserInfo.sUserIPaddr,
            UserInfo.nUserCDKey, UserLimit.sServerName);

          FrmMasSoc.SendServerMsg(SS_OPENSESSION, UserLimit.sServerName,
            UserInfo.sAccount + '/' + IntToStr(UserInfo.nSessionID) + '/' +
            IntToStr(UserInfo.nUserCDKey) + '/' + IntToStr(UserInfo.nGameGold) + '/' + IntToStr(UserInfo.nCheckEMail) + '/' + UserInfo.sUserIPaddr);
          DefMsg := MakeDefaultMsg(SM_SELECTSERVER_OK, UserInfo.nSessionID, 0, 0, Integer(g_boCloseWuXin));
          SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex,
            EncodeMessage(DefMsg) + EncodeString(sSelGateIP + '/' + IntToStr(nSelGatePort) + '/' + IntToStr(UserInfo.nSessionID)));
        end
        else begin
          UserInfo.boSelServer := False;
          DefMsg := MakeDefaultMsg(SM_STARTFAIL, 0, 0, 0, 0);
          SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
        end;
      end;
    end
    else begin
      DefMsg := MakeDefaultMsg(SM_PASSWD_FAIL, nCode, 0, 0, 0);
      SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
    end;
  except
    MainOutMessage('TFrmMain.LoginUser');
  end;
end;
{$IFEND}

procedure ProcessUserMsg(Config: pTConfig; UserInfo: pTUserInfo; sMsg: string; GateIndex: Integer);
var
  sDefMsg: string;
  sData: string;
  DefMsg: TDefaultMessage;
begin
  try
    sDefMsg := Copy(sMsg, 1, DEFBLOCKSIZE);
    sData := Copy(sMsg, DEFBLOCKSIZE + 1, length(sMsg) - DEFBLOCKSIZE);
    DefMsg := DecodeMessage(sDefMsg);

    // fixme debug
//    MainOutMessage('ProcessUserMsg: '+sData);
    case DefMsg.Ident of
{$IF RUNVAR = VAR_DB}
      CM_IDPASSWORD: begin
          if (UserInfo.sAccount = '') then begin
            if (DefMsg.Param > Config.wMajor) or
                ((DefMsg.Param = Config.wMajor) and (DefMsg.tag > Config.wMinor)) or
                ((DefMsg.Param = Config.wMajor) and (DefMsg.tag = Config.wMinor) and (DefMsg.Series > Config.wRelease)) or
                ((DefMsg.Param = Config.wMajor) and (DefMsg.tag = Config.wMinor) and (DefMsg.Series = Config.wRelease) and (DefMsg.Recog >= Config.wBuild)) then begin
              AccountLogin(GateIndex, Config, UserInfo, sData);
            end
            else begin
              DefMsg := MakeDefaultMsg(SM_PASSWD_FAIL, -8, 0, 0, 0);
              SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
            end;

          end;
        end;
      CM_ADDNEWUSER: begin
          if (not Config.boDisabledCreateAccount) then
            AccountCreate(GateIndex, Config, UserInfo, sData);
        end;
      CM_CHANGEPASSWORD: begin
          if (not Config.boDisabledChangePassword) then
            AccountChangePassword(GateIndex, Config, UserInfo, sData);
        end;
      CM_GETBACKPASSWORD: begin
          if (not Config.boDisabledLostPassword) then
            AccountGetBackPassword(GateIndex, Config, UserInfo, sData);
        end;
{$IFEND}
{$IF RUNVAR = VAR_SQL}
      CM_IDPASSWORD: begin
          if not UserInfo.boWaitMsg then begin
            if UserInfo.sAccount = '' then begin
              if (DefMsg.Param > Config.wMajor) or
                ((DefMsg.Param = Config.wMajor) and (DefMsg.tag > Config.wMinor)) or
                ((DefMsg.Param = Config.wMajor) and (DefMsg.tag = Config.wMinor) and (DefMsg.Series > Config.wRelease)) or
                ((DefMsg.Param = Config.wMajor) and (DefMsg.tag = Config.wMinor) and (DefMsg.Series = Config.wRelease) and (DefMsg.Recog >= Config.wBuild)) then begin
                AccountLogin(Config, UserInfo, sData);
              end
              else begin
                DefMsg := MakeDefaultMsg(SM_PASSWD_FAIL, -8, 0, 0, 0);
                SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
              end;
            end;
          end;
        end;
      CM_CHECKMATRIXCARD: begin
          if not UserInfo.boWaitMsg then begin
            if (UserInfo.sAccount <> '') and UserInfo.boMatrixCardCheck then begin
              CheckMatrixCard(GateIndex, Config, UserInfo, DefMsg.Param, DefMsg.tag, DefMsg.Series);
              //SqlThread.CheckMatrixCard(Config, UserInfo, DefMsg.Param, DefMsg.tag, DefMsg.Series, GateIndex);
            end;
          end;
        end;
{$IFEND}
      {CM_ADDNEWUSER: begin
          if Config.boEnableMakingID then begin

            UserInfo.dwClientTick := GetTickCount();
            AccountCreate(Config, UserInfo, sData);

          end;
        end;
      CM_CHANGEPASSWORD: begin
          if UserInfo.sAccount = '' then begin

            UserInfo.dwClientTick := GetTickCount();
            AccountChangePassword(Config, UserInfo, sData);

          end
          else
            UserInfo.sAccount := '';
        end;
      CM_UPDATEUSER: begin

          UserInfo.dwClientTick := GetTickCount();
          AccountUpdateUserInfo(Config, UserInfo, sData);

        end;
      CM_GETBACKPASSWORD: begin
          if Config.boEnableGetbackPassword then begin

            UserInfo.dwClientTick := GetTickCount();
            AccountGetBackPassword(UserInfo, sData);

          end;
        end;   }
    end;
  except
    MainOutMessage('[Exception] TFrmMain.ProcessUserMsg ' + 'wIdent: ' +
      IntToStr(DefMsg.Ident) + ' sData: ' + sData);
  end;
end;

function GetWaitMsgID(): Integer;
begin
  Inc(g_nWaitMsgIndex);
  if g_nWaitMsgIndex <= 0 then
    g_nWaitMsgIndex := 1;
  Result := g_nWaitMsgIndex;
end;
{$IF RUNVAR = VAR_SQL}

procedure AccountLogin(Config: pTConfig; UserInfo: pTUserInfo; sData: string);
var
  sPassword, sLoginID: string;
begin
  sPassword := GetValidStr3(DecodeString(sData), sLoginID, ['/']);
  if (Length(sLoginID) in [5..16]) and (Length(sPassWord) = 16) then begin
    sLoginID := LowerCase(sLoginID);
    UserInfo.boWaitMsg := True;
    UserInfo.nWaitMsgID := GetWaitMsgID;
    UserInfo.sAccount := sLoginID;
    FrmSqlSock.SendUserLogin(UserInfo.nWaitMsgID, sLoginID + '/' + sPassword + '/' + UserInfo.sUserIPaddr);
  end;
end;
{$IFEND}

procedure CheckMatrixCard(GateIndex: Integer; Config: pTConfig; UserInfo: pTUserInfo; nCard1, nCard2, nCard3: Byte);
var
  DefMsg: TDefaultMessage;
  sSelGateIP: string;
  nSelGatePort: Integer;
begin
  UserInfo.boMatrixCardCheck := False;
  if (UserInfo.MatrixCard[0].CardNo = nCard1) and (UserInfo.MatrixCard[1].CardNo = nCard2) and
    (UserInfo.MatrixCard[2].CardNo = nCard3) then begin
    if IsLogin(@g_Config, UserInfo.sAccount) then begin
      UserInfo.sAccount := '';
      SessionKick(@g_Config, UserInfo.sAccount); //踢除已登录用户
      DefMsg := MakeDefaultMsg(SM_PASSWD_FAIL, -3, 0, 0, 0);
      SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
      exit;
    end;
    //UserInfo.nSessionID := GetSessionID();
    sSelGateIP := GetSelGateInfo(@g_Config, g_Config.sGateIPaddr, nSelGatePort);
    if (sSelGateIP <> '') and (nSelGatePort > 0) then begin
      if FrmMasSoc.IsNotUserFull() then begin
        UserInfo.boSelServer := True;
        UserInfo.nSessionID := SessionAdd(@g_Config, UserInfo.sAccount, UserInfo.sUserIPaddr, UserInfo.nUserCDKey,
          UserLimit.sServerName);

        FrmMasSoc.SendServerMsg(SS_OPENSESSION, UserLimit.sServerName,
          UserInfo.sAccount + '/' + IntToStr(UserInfo.nSessionID) + '/' +
          IntToStr(UserInfo.nUserCDKey) + '/' + IntToStr(UserInfo.nGameGold) + '/' + IntToStr(UserInfo.nCheckEMail) + '/' + UserInfo.sUserIPaddr);
        DefMsg := MakeDefaultMsg(SM_SELECTSERVER_OK, UserInfo.nSessionID, 0, 0, 0);
        SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex,
          EncodeMessage(DefMsg) + EncodeString(sSelGateIP + '/' + IntToStr(nSelGatePort) + '/' + IntToStr(UserInfo.nSessionID)));
      end
      else begin
        UserInfo.boSelServer := False;
        DefMsg := MakeDefaultMsg(SM_STARTFAIL, 0, 0, 0, 0);
        SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
      end;
    end;
  end
  else begin
    DefMsg := MakeDefaultMsg(SM_PASSWD_FAIL, -6, 0, 0, 0);
    SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
  end;
end;

(*
function KickUser(Config: pTConfig; UserInfo: pTUserInfo{; nKickType: Integer}):
  Boolean;
var
  I: Integer;
  II: Integer;
  GateInfo: pTGateInfo;
  User: pTUserInfo;
resourcestring
  sKickMsg = 'Kick: %s';
begin
  Result := False;
  //EnterCriticalSection(Config.GateCriticalSection);
  //try
  for I := 0 to Config.GateList.Count - 1 do begin
    GateInfo := Config.GateList.Items[I];
    for II := 0 to GateInfo.UserList.Count - 1 do begin
      User := GateInfo.UserList.Items[II];
      if User = UserInfo then begin
        if Config.boShowDetailMsg then
          MainOutMessage(format(sKickMsg, [UserInfo.sUserIPaddr]));
        SendGateKickMsg(GateInfo.Socket, UserInfo.sSockIndex);
        {case nKickType of
          0: SendGateKickMsg(GateInfo.Socket, UserInfo.sSockIndex);
          1: SendGateAddTempBlockList(GateInfo.Socket, UserInfo.sSockIndex);
          2: SendGateAddBlockList(GateInfo.Socket, UserInfo.sSockIndex);
        end;  }
        GateInfo.UserList.Delete(II);
        Dispose(UserInfo);
        Result := true;
        break;
      end;
    end;
  end;
  {finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;  }
end;        *)

function GetSelGateInfo(Config: pTConfig; sGateIP: string; var nPort: Integer): string;
  function GetRoute(RouteInfo: pTRouteInfo; var nGatePort: Integer): string;
  var
    nGateIndex: Integer;
  begin
    nGateIndex := Random(RouteInfo.nGateCount);
    Result := RouteInfo.sGameGateIP[nGateIndex];
    nGatePort := RouteInfo.nGameGatePort[nGateIndex];
  end;
var
  i: Integer;
  RouteInfo: pTRouteInfo;
begin
  nPort := 0;
  Result := '';
  for i := Low(Config.GateRoute) to High(Config.GateRoute) do begin
    RouteInfo := @Config.GateRoute[i];
    if RouteInfo.sSelGateIP = sGateIP then begin
      Result := GetRoute(RouteInfo, nPort);
      break;
    end;
  end;
end;
(*
procedure AccountUpdateUserInfo(Config: pTConfig; UserInfo: pTUserInfo; sData:
  string);
var
  UserEntry: TUserEntry;
  UserAddEntry: TUserEntryAdd;
  DBRecord: TAccountDBRecord;
  nLen: Integer;
  sUserEntryMsg: string;
  sUserAddEntryMsg: string;
  nCode: Integer;
  DefMsg: TDefaultMessage;
  n10: Integer;
begin
  try
    SafeFillChar(UserEntry, SizeOf(TUserEntry), #0);
    SafeFillChar(UserAddEntry, SizeOf(TUserEntryAdd), #0);
    nLen := GetCodeMsgSize(SizeOf(TUserEntry) * 4 / 3);
    sUserEntryMsg := Copy(sData, 1, nLen);
    sUserAddEntryMsg := Copy(sData, nLen + 1, length(sData) - nLen);
    DecodeBuffer(sUserEntryMsg, @UserEntry, SizeOf(TUserEntry));
    DecodeBuffer(sUserAddEntryMsg, @UserAddEntry, SizeOf(TUserEntryAdd));
    nCode := -1;
    if (UserInfo.sAccount = UserEntry.sAccount) and
      CheckAccountName(UserEntry.sAccount) then begin
      try
        if AccountDB.Open then begin
          n10 := AccountDB.Index(UserEntry.sAccount);
          if (n10 >= 0) then begin
            if (AccountDB.Get(n10, DBRecord) >= 0) then begin
              DBRecord.UserEntry := UserEntry;
              DBRecord.UserEntryAdd := UserAddEntry;
              AccountDB.Update(n10, DBRecord);
              nCode := 1;
            end;
          end
          else
            nCode := 0;
        end;
      finally
        AccountDB.Close;
      end;
    end;
    if nCode = 1 then begin
      WriteLogMsg(Config, 'upg', UserEntry, UserAddEntry);
      DefMsg := MakeDefaultMsg(SM_UPDATEID_SUCCESS, 0, 0, 0, 0);
    end
    else begin
      DefMsg := MakeDefaultMsg(SM_UPDATEID_FAIL, nCode, 0, 0, 0);
    end;
    SendGateMsg(UserInfo.Socket,
      UserInfo.sArryIndex,
      UserInfo.sSockIndex, EncodeMessage(DefMsg));
  except
    MainOutMessage('TFrmMain.UpdateUserInfo');
  end;
end;

procedure AccountGetBackPassword(UserInfo: pTUserInfo;
  sData: string);
var
  sMsg: string;
  sAccount: string;
  sQuest1: string;
  sAnswer1: string;
  sQuest2: string;
  sAnswer2: string;
  sPassword: string;
  sBirthDay: string;
  nCode: Integer;
  nIndex: Integer;
  DefMsg: TDefaultMessage;
  DBRecord: TAccountDBRecord;
begin
  sMsg := DecodeString(sData);
  sMsg := GetValidStr3(sMsg, sAccount, [#9]);
  sMsg := GetValidStr3(sMsg, sQuest1, [#9]);
  sMsg := GetValidStr3(sMsg, sAnswer1, [#9]);
  sMsg := GetValidStr3(sMsg, sQuest2, [#9]);
  sMsg := GetValidStr3(sMsg, sAnswer2, [#9]);
  sMsg := GetValidStr3(sMsg, sBirthDay, [#9]);
  nCode := 0;
  try
    if (sAccount <> '') and AccountDB.Open then begin
      nIndex := AccountDB.Index(sAccount);
      if (nIndex >= 0) and (AccountDB.Get(nIndex, DBRecord) >= 0) then begin
        if (DBRecord.nErrorCount < 5) or ((GetTickCount - DBRecord.dwActionTick)
          > 180000) then begin
          nCode := -1;
          if (DBRecord.UserEntry.sQuiz = sQuest1) then begin
            nCode := -3;
            if DBRecord.UserEntry.sAnswer = sAnswer1 then begin
              if DBRecord.UserEntryAdd.sBirthDay = sBirthDay then begin
                nCode := 1;
              end;
            end;
          end;
          if nCode <> 1 then begin
            if (DBRecord.UserEntryAdd.sQuiz2 = sQuest2) then begin
              nCode := -3;
              if DBRecord.UserEntryAdd.sAnswer2 = sAnswer2 then begin
                if DBRecord.UserEntryAdd.sBirthDay = sBirthDay then begin
                  nCode := 1;
                end;
              end;
            end;
          end;
          if nCode = 1 then begin
            sPassword := DBRecord.UserEntry.sPassword;
          end
          else begin
            Inc(DBRecord.nErrorCount);
            DBRecord.dwActionTick := GetTickCount();
            AccountDB.Update(nIndex, DBRecord);
          end;
        end
        else begin
          nCode := -2;
          if GetTickCount < DBRecord.dwActionTick then begin
            DBRecord.dwActionTick := GetTickCount();
            AccountDB.Update(nIndex, DBRecord);
          end;
        end;
      end;
    end;
  finally
    AccountDB.Close;
  end;
  if nCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_GETBACKPASSWD_SUCCESS, 0, 0, 0, 0);
    SendGateMsg(UserInfo.Socket,
      UserInfo.sArryIndex,
      UserInfo.sSockIndex, EncodeMessage(DefMsg) +
      EncodeString(sPassword));
  end
  else begin
    DefMsg := MakeDefaultMsg(SM_GETBACKPASSWD_FAIL, nCode, 0, 0, 0);
    SendGateMsg(UserInfo.Socket,
      UserInfo.sArryIndex,
      UserInfo.sSockIndex, EncodeMessage(DefMsg));
  end;
end;     *)

procedure SendGateMsg(GateIndex: Integer; sArryIndex, sSockIndex, sMsg: string);
var
  sSendMsg: string;
begin
  sSendMsg := MG_CodeHead + sArryIndex + '/' + sSockIndex + '/' + g_CodeHead + sMsg + g_CodeEnd + MG_CodeEnd;
  SendUserSocket(GateIndex, sSendMsg);
  //Socket.SendText(sSendMsg);
end;
{
function IsLogin(Config: pTConfig; nSessionID: Integer): Boolean;
var
  ConnInfo: pTConnInfo;
  I: Integer;
begin
  Result := False;
  Config.SessionList.Lock;
  try
    for I := 0 to Config.SessionList.Count - 1 do begin
      ConnInfo := Config.SessionList.Items[I];
      if (ConnInfo.nSessionID = nSessionID) then begin
        Result := true;
        break;
      end;
    end;
  finally
    Config.SessionList.UnLock;
  end;
end;      }

function IsLogin(Config: pTConfig; sLoginID: string): Boolean;
var
  ConnInfo: pTConnInfo;
  I: Integer;
begin
  Result := False;
  Config.SessionList.Lock;
  try
    for I := 0 to Config.SessionList.Count - 1 do begin
      ConnInfo := Config.SessionList.Items[I];
      if (ConnInfo.sAccount = sLoginID) then begin
        Result := true;
        break;
      end;
    end;
  finally
    Config.SessionList.UnLock;
  end;
end;

procedure SessionGoldChange(Config: pTConfig; sLoginID: string; nGmaeGold: Integer);
var
  ConnInfo: pTConnInfo;
  I: Integer;
begin
  Config.SessionList.Lock;
  try
    for I := 0 to Config.SessionList.Count - 1 do begin
      ConnInfo := Config.SessionList.Items[I];
      if (ConnInfo.sAccount = sLoginID) and (not ConnInfo.boKicked) then begin
        FrmMasSoc.SendServerMsgToServer(SS_M2GAMEGOLDCHANGE, sLoginID + '/' + IntToStr(nGmaeGold));
        break;
      end;
    end;
  finally
    Config.SessionList.UnLock;
  end;
end;

procedure SessionKick(Config: pTConfig; sLoginID: string);
var
  ConnInfo: pTConnInfo;
  I: Integer;
begin
  Config.SessionList.Lock;
  try
    for I := 0 to Config.SessionList.Count - 1 do begin
      ConnInfo := Config.SessionList.Items[I];
      if (ConnInfo.sAccount = sLoginID) and (not ConnInfo.boKicked) then begin
        FrmMasSoc.SendServerMsg(SS_CLOSESESSION, ConnInfo.sServerName,
          ConnInfo.sAccount + '/' + IntToStr(ConnInfo.nSessionID));

        ConnInfo.dwKickTick := GetTickCount();
        ConnInfo.boKicked := true;
        break;
      end;
    end;
  finally
    Config.SessionList.UnLock;
  end;
end;

function SessionAdd(Config: pTConfig; sAccount, sIPaddr: string; nUserCDKey: Integer; sServerName: string): Integer;
var
  ConnInfo: pTConnInfo;
begin
  New(ConnInfo);
  Result := GetSessionID;
  ConnInfo.sAccount := sAccount;
  ConnInfo.sIPaddr := sIPaddr;
  ConnInfo.nSessionID := Result;
  //ConnInfo.boPayCost := boPayCost;
  //ConnInfo.bo11 := bo11;
  ConnInfo.nUserCDKey := nUserCDKey;
  ConnInfo.dwKickTick := GetTickCount();
  ConnInfo.dwStartTick := GetTickCount();
  ConnInfo.boKicked := False;
  ConnInfo.sServerName := sServerName;
  Config.SessionList.Lock;
  try
    Config.SessionList.Add(ConnInfo);
  finally
    Config.SessionList.UnLock;
  end;
end;

procedure SendGateKickMsg(Socket: TCustomWinSocket;
  sSockIndex: string);
var
  sSendMsg: string;
begin
  sSendMsg := '%+-' + sSockIndex + '$';
  Socket.SendText(sSendMsg);
end;

procedure SendGateAddBlockList(Socket: TCustomWinSocket;
  sSockIndex: string);
var
  sSendMsg: string;
begin
  sSendMsg := '%+B' + sSockIndex + '$';
  Socket.SendText(sSendMsg);
end;

procedure SendGateAddTempBlockList(Socket: TCustomWinSocket;
  sSockIndex: string);
var
  sSendMsg: string;
begin
  sSendMsg := '%+T' + sSockIndex + '$';
  Socket.SendText(sSendMsg);
end;
{
procedure LoadIPaddrCostList(Config: pTConfig; QuickList: TQuickList);
begin

end;

procedure LoadAccountCostList(Config: pTConfig; QuickList: TQuickList);
begin

end;    }

procedure TFrmMain.MyMessage(var MsgData: TWmCopyData);
var
  sData: string;
  wIdent: Word;
  Config: pTConfig;
begin
  Config := @g_Config;
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of
    GS_QUIT: begin
        Config.boRemoteClose := true;
        Close();
      end;
    3: ;
  end;
end;

procedure SaveContLogMsg(Config: pTConfig; sLogMsg: string);
{var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  sLogDir, sLogFileName: string;
  LogFile: TextFile;  }
begin
  {  if sLogMsg = '' then
      Exit;
    DecodeDate(Date, Year, Month, Day);
    DecodeTime(Time, Hour, Min, Sec, MSec);
    if not DirectoryExists(Config.sCountLogDir) then begin
      CreateDir(Config.sCountLogDir);
    end;
    sLogDir := Config.sCountLogDir + IntToStr(Year) + '-' + IntToStr2(Month);
    if not DirectoryExists(sLogDir) then begin
      CreateDirectory(PChar(sLogDir), nil);
    end;
    sLogFileName := sLogDir + '\' + IntToStr(Year) + '-' + IntToStr2(Month) + '-'
      + IntToStr2(Day) + '.txt';
    AssignFile(LogFile, sLogFileName);
    if not FileExists(sLogFileName) then begin
      Rewrite(LogFile);
    end
    else begin
      Append(LogFile);
    end;
    sLogMsg := sLogMsg + #9 + TimeToStr(Time);
    WriteLn(LogFile, sLogMsg);
    CloseFile(LogFile);  }
end;

procedure WriteLogMsg(Config: pTConfig; sType: string; var UserEntry:
  TUserEntry;
  var UserAddEntry: TUserEntryAdd);
var
  Year, Month, Day: Word;
  sLogDir, sLogFileName: string;
  LogFile: TextFile;
  sLogFormat, sLogMsg: string;
begin
  DecodeDate(Date, Year, Month, Day);
  if not DirectoryExists(Config.sChrLogDir) then begin
    CreateDir(Config.sChrLogDir);
  end;
  sLogDir := Config.sChrLogDir + IntToStr(Year) + '-' + IntToStr2(Month);
  if not DirectoryExists(sLogDir) then begin
    CreateDirectory(PChar(sLogDir), nil);
  end;
  sLogFileName := sLogDir + '\Id_' + IntToStr2(Day) + '.log';
  AssignFile(LogFile, sLogFileName);
  if not FileExists(sLogFileName) then begin
    Rewrite(LogFile);
  end
  else begin
    Append(LogFile);
  end;
  sLogFormat :=
    '*%s*'#9'%s'#9'"%s"'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'%s'#9'[%s]';
  sLogMsg := format(sLogFormat, [sType,
    UserEntry.sAccount,
      UserEntry.sPassword,
      UserEntry.sUserName,
      UserEntry.sSSNo,
      UserEntry.sQuiz,
      UserEntry.sAnswer,
      UserEntry.sEMail,
      UserAddEntry.sQuiz2,
      UserAddEntry.sAnswer2,
      UserAddEntry.sBirthDay,
      UserAddEntry.sMobilePhone,
      TimeToStr(Now)]);

  WriteLn(LogFile, sLogMsg);
  CloseFile(LogFile);
end;

procedure StartService(Config: pTConfig);
begin
  InitializeConfig(Config);
  LoadConfig(Config);
end;

procedure StopService(Config: pTConfig);
begin
  UnInitializeConfig(Config);
end;

procedure InitializeConfig(Config: pTConfig);
begin
  Config.IniConf := TIniFile.Create(sConfFileName);
  InitializeCriticalSection(Config.GateCriticalSection);
end;

procedure UnInitializeConfig(Config: pTConfig);
begin
  Config.IniConf.Free;
  DeleteCriticalSection(Config.GateCriticalSection);
end;

procedure LoadConfig(Config: pTConfig);
  function LoadConfigString(sSection, sIdent, sDefault: string): string;
  var
    sString: string;
  begin
    sString := Config.IniConf.ReadString(sSection, sIdent, '');
    if sString = '' then begin
      Config.IniConf.WriteString(sSection, sIdent, sDefault);
      Result := sDefault;
    end
    else begin
      Result := sString;
    end;
  end;
  function LoadConfigInteger(sSection, sIdent: string; nDefault: Integer):
      Integer;
  var
    nLoadInteger: Integer;
  begin
    nLoadInteger := Config.IniConf.ReadInteger(sSection, sIdent, -1);
    if nLoadInteger < 0 then begin
      Config.IniConf.WriteInteger(sSection, sIdent, nDefault);
      Result := nDefault;
    end
    else begin
      Result := nLoadInteger;
    end;
  end;
  function LoadConfigBoolean(sSection, sIdent: string; boDefault: Boolean):
      Boolean;
  var
    nLoadInteger: Integer;
  begin
    nLoadInteger := Config.IniConf.ReadInteger(sSection, sIdent, -1);
    if nLoadInteger < 0 then begin
      Config.IniConf.WriteBool(sSection, sIdent, boDefault);
      Result := boDefault;
    end
    else begin
      Result := nLoadInteger = 1;
    end;
  end;
begin
  Config.sServerAddr := LoadConfigString(sSectionServer, sIdentServerAddr, Config.sServerAddr);
  Config.nServerPort := LoadConfigInteger(sSectionServer, sIdentServerPort, Config.nServerPort);
  Config.sGateAddr := LoadConfigString(sSectionServer, sIdentGateAddr, Config.sGateAddr);
  Config.nGatePort := LoadConfigInteger(sSectionServer, sIdentGatePort, Config.nGatePort);
  Config.sMonAddr := LoadConfigString(sSectionServer, sIdentMonAddr, Config.sMonAddr);
  Config.nMonPort := LoadConfigInteger(sSectionServer, sIdentMonPort, Config.nMonPort);
  Config.sSQLAddr := LoadConfigString(sSectionServer, sIdentSqlAddr, Config.sSQLAddr);
  Config.nSQLPort := LoadConfigInteger(sSectionServer, sIdentSqlPort, Config.nSQLPort);
  Config.sIdDir := LoadConfigString(sSectionServer, sIdentIdDir, Config.sIdDir);
  Config.sChrLogDir := LoadConfigString(sSectionServer, sIdentCountLogDir, Config.sChrLogDir);
  g_boCloseWuXin := Config.IniConf.ReadBool(sSectionServer, 'CloseWuXin', g_boCloseWuXin);

  Config.wMajor := LoadConfigInteger(sSectionServer, sMajor, Config.wMajor);
  Config.wMinor := LoadConfigInteger(sSectionServer, sMinor, Config.wMinor);
  Config.wRelease := LoadConfigInteger(sSectionServer, sRelease, Config.wRelease);
  Config.wBuild := LoadConfigInteger(sSectionServer, sBuild, Config.wBuild);
  Config.boDisabledCreateAccount := LoadConfigBoolean(sSectionServer, 'DisabledCreateAccount', Config.boDisabledCreateAccount);
  Config.boDisabledChangePassword := LoadConfigBoolean(sSectionServer, 'DisabledChangePassword', Config.boDisabledChangePassword);
  Config.boDisabledLostPassword := LoadConfigBoolean(sSectionServer, 'DisabledLostPassword', Config.boDisabledLostPassword);
end;

procedure TFrmMain.MENU_OPTION_GENERALClick(Sender: TObject);
begin
  FrmBasicSet := TFrmBasicSet.Create(Owner);
  FrmBasicSet.Top := Top;
  FrmBasicSet.Left := Left;
  FrmBasicSet.OpenBasicSet();
  FrmBasicSet.Free;
end;

procedure TFrmMain.MENU_HELP_ABOUTClick(Sender: TObject);
begin
  //FrmMasSoc.GetGoldChangeMsg('1/1234565/aaaccc/123/I则试服/1000/0');
  Memo1.Height := nMemoHeigh * 3;

  Memo1.Lines.Add(g_sUpDateTime);
  Memo1.Lines.Add(g_sProgram);
  Memo1.Lines.Add(g_sWebSite);
end;

procedure TFrmMain.N1Click(Sender: TObject);
var
  Config: pTConfig;

begin
  Config := @g_Config;

  LoadAddrTable(Config);
  MainOutMessage('加载路由列表完成...');
end;

procedure TFrmMain.C1Click(Sender: TObject);
var
  I: Integer;
begin
  for I := Low(ServerAddr) to High(ServerAddr) do begin
    ServerAddr[I] := '';
  end;
  FrmMasSoc.LoadServerAddr();

  UserLimit.sServerName := '';
  UserLimit.sName := '';
  UserLimit.nLimitCountMin := 3000;
  UserLimit.nLimitCountMax := 0;

  FrmMasSoc.LoadUserLimit();
  MainOutMessage('加载配制文件完成...');
end;

procedure TFrmMain.ApplicationEvents1Exception(Sender: TObject;
  e: Exception);
begin
  MainOutMessage(e.Message);
end;

end.

