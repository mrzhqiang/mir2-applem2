unit DBSMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, JSocket, Buttons, IniFiles,
  Menus, Grobal2, HumDB, DBShare, ComCtrls, ActnList, AppEvnts, DB,
  DBTables, Common;
type
  TServerInfo = record
    nSckHandle: Integer; //0x00
    //sStr: string; //0x04
    RecvBuff: PChar;
    BuffLeng: Integer;
    // bo08: Boolean; //0x08
    Socket: TCustomWinSocket; //0x0C
  end;
  pTServerInfo = ^TServerInfo;
  {THumSession = record
    sChrName: string[14];
    nIndex: Integer;
    Socket: TCustomWinSocket; //0x20
    bo24: Boolean;
    bo2C: Boolean;
    dwTick30: LongWord;
  end;
  pTHumSession = ^THumSession;   }

  TFrmDBSrv = class(TForm)
    ServerSocket: TServerSocket;
    Timer1: TTimer;
    StartTimer: TTimer;
    Timer2: TTimer;
    MemoLog: TMemo;
    Panel2: TPanel;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_MANAGE: TMenuItem;
    MENU_OPTION_GAMEGATE: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    T1: TMenuItem;
    N1: TMenuItem;
    G1: TMenuItem;
    MENU_MANAGE_DATA: TMenuItem;
    MENU_MANAGE_INFO: TMenuItem;
    MENU_TEST: TMenuItem;
    MENU_TEST_SELGATE: TMenuItem;
    ListView: TListView;
    ApplicationEvents1: TApplicationEvents;
    N2: TMenuItem;
    N3: TMenuItem;
    X1: TMenuItem;
    Query: TQuery;
    DataSource: TDataSource;
    Panel1: TPanel;
    Label4: TLabel;
    LbAutoClean: TLabel;
    LbTransCount: TLabel;
    Label6: TLabel;
    LbUserCount: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CheckBox1: TCheckBox;
    F1: TMenuItem;
    T2: TMenuItem;
    MENU_MANAGE_TOOL: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StartTimerTimer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure BtnUserDBToolClick(Sender: TObject);
    procedure CkViewHackMsgClick(Sender: TObject);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure MENU_MANAGE_DATAClick(Sender: TObject);
    procedure MENU_MANAGE_INFOClick(Sender: TObject);
    procedure MENU_TEST_SELGATEClick(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure G1Click(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure X1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure T2Click(Sender: TObject);
    procedure MENU_MANAGE_TOOLClick(Sender: TObject);
  private
    //    n334: Integer;
//    m_DefMsg: TDefaultMessage;
    n344: Integer;
    n348: Integer;
    //    s34C: string;
    ServerList: TList; //0x354
    //HumSessionList: TList; //0x358
    m_boRemoteClose: Boolean;
    procedure ProcessServerPacket(ServerInfo: pTServerInfo);
    //procedure ProcessServerMsg(sMsg: string; nLen: Integer; Socket: TCustomWinSocket);
    procedure SendSocket(Socket: TCustomWinSocket; SendBuff: PChar; BuffLen: Integer);
    procedure LoadHumanRcd(RecvBuff: PChar; BuffLen, QueryID: Integer; Socket: TCustomWinSocket);
    //    procedure NewHeroHum(sMsg: string; Socket: TCustomWinSocket);
    //    procedure DelHeroHum(sMsg: string; Socket: TCustomWinSocket);
    //    procedure GetSortList(sMsg: string; nRecog: Integer; Socket:
         // TCustomWinSocket);
    procedure SaveHumanRcd(nRecog, QueryID: Integer; RecvBuff: PChar; BuffLen: Integer; Socket: TCustomWinSocket);
    {    procedure SaveHumanRcdEx(sMsg: string; nRecog: Integer;
          Socket: TCustomWinSocket);   }
    procedure ClearSocket(Socket: TCustomWinSocket);
    procedure ShowModule();
    function LoadItemsDB(): Integer;
    function LoadMagicDB(): Integer;
    { Private declarations }
  public
    function CopyHumData(sSrcChrName, sDestChrName, sUserId: string): Boolean;
    procedure DelHum(sChrName: string);
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
    { Public declarations }
  end;

var
  FrmDBSrv: TFrmDBSrv;
implementation
uses FIDHum, UsrSoc, AddrEdit, HUtil32, EDcode,
  IDSocCli, DBTools, TestSelGate, RouteManage, FDBexpl;

{$R *.DFM}

procedure TFrmDBSrv.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  ServerInfo: pTServerInfo;
  sIPaddr: string;
begin
  sIPaddr := Socket.RemoteAddress;
  if not CheckServerIP(sIPaddr) then begin
    MainOutMessage('非法服务器连接: ' + sIPaddr);
    Socket.Close;
    Exit;
  end;
  Server_sRemoteAddress := sIPaddr;
  Server_nRemotePort := Socket.RemotePort;
  ServerSocketClientConnected := True;
  //MainOutMessage('ServerSocketClientConnect' + sIPaddr);
  if not boOpenDBBusy then begin
    New(ServerInfo);
    //ServerInfo.bo08 := True;
    ServerInfo.nSckHandle := Socket.SocketHandle;
    ServerInfo.RecvBuff := nil;
    ServerInfo.BuffLeng := 0;
    ServerInfo.Socket := Socket;
    ServerList.Add(ServerInfo);
  end
  else begin
    Socket.Close;
  end;
end;

procedure TFrmDBSrv.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i: Integer;
  ServerInfo: pTServerInfo;
begin
  for i := 0 to ServerList.Count - 1 do begin
    ServerInfo := ServerList.Items[i];
    if ServerInfo.nSckHandle = Socket.SocketHandle then begin
      if ServerInfo.RecvBuff <> nil then
        FreeMem(ServerInfo.RecvBuff);
      ServerInfo.RecvBuff := nil;
      ServerInfo.BuffLeng := 0;
      Dispose(ServerInfo);
      ServerList.Delete(i);
      ClearSocket(Socket);
      break;
    end;
  end;
end;

procedure TFrmDBSrv.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
  ServerSocketClientConnected := False;
end;

procedure TFrmDBSrv.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);

var
  i: Integer;
  ServerInfo: pTServerInfo;
  nMsgLen: Integer;
  tBuffer: PChar;
begin
  dwKeepServerAliveTick := GetTickCount;
  g_CheckCode.dwThread0 := 1001000;
  for i := 0 to ServerList.Count - 1 do begin
    g_CheckCode.dwThread0 := 1001001;
    ServerInfo := ServerList.Items[i];
    g_CheckCode.dwThread0 := 1001002;
    if ServerInfo.nSckHandle = Socket.SocketHandle then begin
      g_CheckCode.dwThread0 := 1001003;
      nMsgLen := Socket.ReceiveLength;
      GetMem(tBuffer, nMsgLen);
      nMsgLen := Socket.ReceiveBuf(tBuffer^, nMsgLen);
      ReallocMem(ServerInfo.RecvBuff, ServerInfo.BuffLeng + nMsgLen);
      Move(tBuffer^, ServerInfo.RecvBuff[ServerInfo.BuffLeng], nMsgLen);
      Inc(ServerInfo.BuffLeng, nMsgLen);
      FreeMem(tBuffer);
      ProcessServerPacket(ServerInfo);
    end;
  end;
  {nMsgLen := Socket.ReceiveLength;
  GetMem(tBuffer, nMsgLen);
  nMsgLen := Socket.ReceiveBuf(tBuffer^, nMsgLen);
  //ProcReceiveBuffer(tBuffer, nMsgLen);
  FreeMem(tBuffer);  }
(*
var
  i: Integer;
  ServerInfo: pTServerInfo;
  s10: string;
begin

  dwKeepServerAliveTick := GetTickCount;
  g_CheckCode.dwThread0 := 1001000;
  for i := 0 to ServerList.Count - 1 do begin
    g_CheckCode.dwThread0 := 1001001;
    ServerInfo := ServerList.Items[i];
    g_CheckCode.dwThread0 := 1001002;
    if ServerInfo.nSckHandle = Socket.SocketHandle then begin
      g_CheckCode.dwThread0 := 1001003;
      s10 := Socket.ReceiveText;
      Inc(n4ADBF4);
      if s10 <> '' then begin
        g_CheckCode.dwThread0 := 1001004;
        ServerInfo.sStr := ServerInfo.sStr + s10;
        g_CheckCode.dwThread0 := 1001005;
        if Pos(g_CodeEnd, s10) > 0 then begin
          g_CheckCode.dwThread0 := 1001006;
          ProcessServerPacket(ServerInfo);
          g_CheckCode.dwThread0 := 1001007;
          Inc(n4ADBF8);
          Inc(n348);
          break;
        end
        else begin //004A7DC7
          if Length(ServerInfo.sStr) > 81920 then begin
            ServerInfo.sStr := '';
            Inc(n4ADC2C);
          end;
        end;
      end;
      break;
    end;
  end;
  g_CheckCode.dwThread0 := 1001008;    *)
end;

procedure TFrmDBSrv.ProcessServerPacket(ServerInfo: pTServerInfo);
var
  Buff, TempBuff, MsgBuff: PChar;
  nLen: Integer;
  pMsg: pTDBMsgHeader;
begin
  Buff := ServerInfo.RecvBuff;
  nLen := ServerInfo.BuffLeng;
  //  MsgBuff := nil;
  if nLen >= SizeOf(TDBMsgHeader) then begin
    while (True) do begin
      pMsg := pTDBMsgHeader(Buff);
      if (pMsg.dwHead = RUNGATECODE) and (pMsg.dwCode = pMsg.dwCheckCode) then begin
        if (pMsg.nLength + SizeOf(TDBMsgHeader)) > nLen then
          break;
        MsgBuff := Ptr(LongInt(Buff) + SizeOf(TDBMsgHeader));
        case pMsg.DefMsg.Ident of
          DB_LOADHUMANRCD: begin
              LoadHumanRcd(MsgBuff, pMsg.nLength, pMsg.dwCode, ServerInfo.Socket);
            end;
          DB_SAVEHUMANRCD: begin
              SaveHumanRcd(pMsg.DefMsg.Recog, pMsg.dwCode, MsgBuff, pMsg.nLength, ServerInfo.Socket);
            end;
        end;
        Buff := Buff + SizeOf(TDBMsgHeader) + pMsg.nLength;
        nLen := nLen - (pMsg.nLength + SizeOf(TDBMsgHeader));
        //Buff := @Buff[SizeOf(TDBMsgHeader) + pMsg.nLength];
        //nLen := nLen - (pMsg.nLength + SizeOf(TDBMsgHeader));
        //nLen := 0;
      end
      else begin
        Inc(Buff);
        Dec(nLen);
      end;
      if nLen < SizeOf(TMsgHeader) then
        break;
    end;
    if nLen > 0 then begin
      if ServerInfo.BuffLeng = nLen then
        exit;
      GetMem(TempBuff, nLen);
      Move(Buff^, TempBuff^, nLen);
      FreeMem(ServerInfo.RecvBuff);
      ServerInfo.RecvBuff := TempBuff;
      ServerInfo.BuffLeng := nLen;
    end
    else begin
      if ServerInfo.RecvBuff <> nil then
        FreeMem(ServerInfo.RecvBuff);
      ServerInfo.RecvBuff := nil;
      ServerInfo.BuffLeng := 0;
    end;
  end;

end;
(*

var
  sDefMsg, sData: string;
  DefMsg: TDefaultMessage;
begin
  if nLen = DEFBLOCKSIZE then begin
    sDefMsg := sMsg;
    sData := '';
  end
  else begin
    sDefMsg := Copy(sMsg, 1, DEFBLOCKSIZE);
    sData := Copy(sMsg, DEFBLOCKSIZE + 1, Length(sMsg) - DEFBLOCKSIZE - 6);
  end; //0x004A9304
  DefMsg := DecodeMessage(sDefMsg);
  //MemoLog.Lines.Add('DefMsg.Ident ' + IntToStr(DefMsg.Ident));
  case DefMsg.Ident of
    DB_LOADHUMANRCD: begin
        LoadHumanRcd(sData, Socket);
      end;
    DB_SAVEHUMANRCD: begin
        SaveHumanRcd(DefMsg.Recog, sData, Socket);
      end;
  else begin
      m_DefMsg := MakeDefaultMsg(DBR_FAIL, 0, 0, 0, 0);
      SendSocket(Socket, EncodeMessage(m_DefMsg));
      Inc(n4ADC04);
      MemoLog.Lines.Add('Fail ' + IntToStr(n4ADC04));
    end;
  end;
  g_CheckCode.dwThread0 := 1001216;

var
  bo25: Boolean;
  SC, s1C, s20, s24: string;
  n14, n18: Integer;
  wE, w10: Word;
  //  DefMsg: TDefaultMessage;
begin
  g_CheckCode.dwThread0 := 1001100;
  if boOpenDBBusy then
    Exit;
  try
    bo25 := False;
    //s1C := ServerInfo.sStr;
    //ServerInfo.sStr := '';
    s20 := '';
    g_CheckCode.dwThread0 := 1001101;
    s1C := ArrestStringEx(s1C, g_CodeHead, g_CodeEnd, s20);
    g_CheckCode.dwThread0 := 1001102;
    if s20 <> '' then begin
      g_CheckCode.dwThread0 := 1001103;
      s20 := GetValidStr3(s20, s24, ['/']);
      n14 := Length(s20);
      if (n14 >= DEFBLOCKSIZE) and (s24 <> '') then begin
        wE := StrToIntDef(s24, 0) xor 170;
        w10 := n14;
        n18 := MakeLong(wE, w10);
        SC := EncodeBuffer(@n18, SizeOf(Integer));
        s34C := s24;
        if CompareBackLStr(s20, SC, Length(SC)) then begin
          g_CheckCode.dwThread0 := 1001104;
          ProcessServerMsg(s20, n14, ServerInfo.Socket);
          g_CheckCode.dwThread0 := 1001105;
          bo25 := True;
        end;
      end; //0x004A7F7B
    end; //0x004A7F7B
    if s1C <> '' then begin
      Inc(n4ADC00);
      Label4.Caption := 'Error ' + IntToStr(n4ADC00);
    end; //0x004A7FB5
    if not bo25 then begin
      m_DefMsg := MakeDefaultMsg(DBR_FAIL, 0, 0, 0, 0);
      {
      DefMsg:=MakeDefaultMsg(DBR_FAIL,0,0,0,0);
      n338:=DefMsg.Recog;
      n33C:=DefMsg.Ident;
      n340:=DefMsg.Tag;
      }
      SendSocket(ServerInfo.Socket, EncodeMessage(m_DefMsg));
      Inc(n4ADC00);
      Label4.Caption := 'Error ' + IntToStr(n4ADC00);
    end;
  finally
  end;
  g_CheckCode.dwThread0 := 1001106;
end;                                     *)

procedure TFrmDBSrv.SendSocket(Socket: TCustomWinSocket; SendBuff: PChar; BuffLen: Integer);
//0x004A8764
var
  nCheckCode: Integer;
  //s18: string;
begin
  Inc(n4ADBFC);
  nCheckCode := 0;
  if Socket.Connected then begin
    while (Socket.SendBuf(SendBuff^, BuffLen) = -1) do begin
      {nSendLen := Socket.SendBuf(SendBuff^, BuffLen);
      if nSendLen = BuffLen then Break; }
      Inc(nCheckCode);
      if nCheckCode >= 10 then
        Break;
      Sleep(10);
    end;
  end;
  {n10 := MakeLong(StrToIntDef(s34C, 0) xor 170, Length(sMsg) + 6);
  s18 := EncodeBuffer(@n10, SizeOf(Integer));
  Socket.SendText(g_CodeHead + s34C + '/' + sMsg + s18 + g_CodeEnd);   }
end;
{
procedure TFrmDBSrv.ProcessServerMsg(sMsg: string; nLen: Integer; Socket:
  TCustomWinSocket); //0x004A9278
var
  sDefMsg, sData: string;
  DefMsg: TDefaultMessage;
begin
  if nLen = DEFBLOCKSIZE then begin
    sDefMsg := sMsg;
    sData := '';
  end
  else begin
    sDefMsg := Copy(sMsg, 1, DEFBLOCKSIZE);
    sData := Copy(sMsg, DEFBLOCKSIZE + 1, Length(sMsg) - DEFBLOCKSIZE - 6);
  end; //0x004A9304
  DefMsg := DecodeMessage(sDefMsg);
  //MemoLog.Lines.Add('DefMsg.Ident ' + IntToStr(DefMsg.Ident));
  case DefMsg.Ident of
    DB_LOADHUMANRCD: begin
        LoadHumanRcd(sData, Socket);
      end;
    DB_SAVEHUMANRCD: begin
        SaveHumanRcd(DefMsg.Recog, sData, Socket);
      end;
  else begin
      m_DefMsg := MakeDefaultMsg(DBR_FAIL, 0, 0, 0, 0);
      SendSocket(Socket, EncodeMessage(m_DefMsg));
      Inc(n4ADC04);
      MemoLog.Lines.Add('Fail ' + IntToStr(n4ADC04));
    end;
  end;
  g_CheckCode.dwThread0 := 1001216;
end;     }

procedure TFrmDBSrv.LoadHumanRcd(RecvBuff: PChar; BuffLen, QueryID: Integer; Socket: TCustomWinSocket);
var
  sHumName: string;
  sAccount: string;
  sIPaddr: string;
  nIndex: Integer;
  nSessionID: Integer;
  nCheckCode: Integer;
  DBHumDataInfo: TDBHumDataInfo;
  LoadHuman: TLoadHuman;
  boFoundSession: Boolean;
  pMsg: TDBMsgHeader;
  SendBuff: PChar;
begin
  Move(RecvBuff^, LoadHuman, SizeOf(TLoadHuman));
  //DecodeBuffer(sMsg, @LoadHuman, SizeOf(TLoadHuman));
  sAccount := LoadHuman.sAccount;
  sHumName := LoadHuman.sChrName;
  sIPaddr := LoadHuman.sUserAddr;
  nSessionID := LoadHuman.nSessionID;
  nCheckCode := -1;
  DBHumDataInfo.UserName := sHumName;
  if (sAccount = '') and (nSessionID = -1) then begin
    nCheckCode := 1; //系统自动脱机时读取
  end else
  if (sAccount <> '') and (sHumName <> '') then begin
    if (FrmIDSoc.CheckSessionLoadRcd(sAccount, sIPaddr, nSessionID, boFoundSession)) then begin
      nCheckCode := 1;
    end
    else begin
      if boFoundSession then begin
        MainOutMessage('[非法重复请求] ' + '帐号: ' + sAccount + ' IP: ' + sIPaddr + ' 标识: ' + IntToStr(nSessionID));
      end
      else begin
        MainOutMessage('[非法请求] ' + '帐号: ' + sAccount + ' IP: ' + sIPaddr + ' 标识: ' + IntToStr(nSessionID));
      end;
      //nCheckCode:= 1; //测试用，正常去掉
    end;
  end;
  if nCheckCode = 1 then begin
    try
      if HumDataDB.OpenEx then begin
        nIndex := HumDataDB.Index(sHumName);
        if nIndex >= 0 then begin
          if HumDataDB.Get(nIndex, DBHumDataInfo.HumDataInfo) < 0 then
            nCheckCode := -2;
        end
        else
          nCheckCode := -3;
      end
      else
        nCheckCode := -4;
    finally
      HumDataDB.Close();
    end;
  end;
  if (nCheckCode = 1) and (DBHumDataInfo.HumDataInfo.Data.sAccount <> '') and (sAccount <> '') and
    (DBHumDataInfo.HumDataInfo.Data.sAccount <> sAccount) then begin
    MainOutMessage('[非法登录] ' + '帐号: ' + sAccount + ' IP: ' + sIPaddr + ' 标识: ' + IntToStr(nSessionID));
    nCheckCode := -1;
  end;
  if nCheckCode = 1 then begin
    pMsg.dwHead := RUNGATECODE;
    pMsg.dwCode := QueryID;
    pMsg.dwCheckCode := QueryID;
    pMsg.nLength := SizeOf(TDBHumDataInfo);
    pMsg.DefMsg.Recog := 1;
    pMsg.DefMsg.Series := 1;
    pMsg.DefMsg.Ident := DBR_LOADHUMANRCD;
    GetMem(SendBuff, SizeOf(TDBMsgHeader) + pMsg.nLength);
    Move(pMsg, SendBuff^, SizeOf(TDBMsgHeader));
    Move(DBHumDataInfo, SendBuff[SizeOf(TDBMsgHeader)], pMsg.nLength);
    SendSocket(Socket, SendBuff, SizeOf(TDBMsgHeader) + pMsg.nLength);
    FreeMem(SendBuff);
  end
  else begin
    pMsg.dwHead := RUNGATECODE;
    pMsg.dwCode := QueryID;
    pMsg.dwCheckCode := QueryID;
    pMsg.nLength := 0;
    pMsg.DefMsg.Recog := nCheckCode;
    pMsg.DefMsg.Ident := DBR_LOADHUMANRCD;
    SendSocket(Socket, @pMsg, SizeOf(TDBMsgHeader));
  end;
end;

procedure TFrmDBSrv.SaveHumanRcd(nRecog, QueryID: Integer; RecvBuff: PChar; BuffLen: Integer; Socket: TCustomWinSocket);
var
  sChrName: string;
  sUserId: string;
  //  sHumanRCD: string;
  nIndex: Integer;
  bo21: Boolean;
  pMsg: TDBMsgHeader;
  DBHumDataInfo: TDBHumDataInfo;
begin
  Move(RecvBuff^, DBHumDataInfo, SizeOf(TDBHumDataInfo));
  sUserId := DBHumDataInfo.sAccount;
  sChrName := DBHumDataInfo.UserName;
  {sHumanRCD := GetValidStr3(sMsg, sUserId, ['/']);
  sHumanRCD := GetValidStr3(sHumanRCD, sChrName, ['/']);
  sUserId := DecodeString(sUserId);
  sChrName := DecodeString(sChrName);  }
  {bo21 := False;
  SafeFillChar(HumanRCD.Data, SizeOf(THumData), #0);
  if Length(sHumanRCD) = GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3) then
    DecodeBuffer(sHumanRCD, @HumanRCD, SizeOf(THumDataInfo))
  else
    bo21 := True; }
  bo21 := True;
  if sChrName = DBHumDataInfo.HumDataInfo.Data.sChrName then begin
    try
      if HumDataDB.Open then begin
        nIndex := HumDataDB.Index(sChrName);
        if nIndex < 0 then begin
          DBHumDataInfo.HumDataInfo.Header.sName := sChrName;
          HumDataDB.Add(DBHumDataInfo.HumDataInfo);
          nIndex := HumDataDB.Index(sChrName);
        end;
        if nIndex >= 0 then begin
          DBHumDataInfo.HumDataInfo.Header.sName := sChrName;
          HumDataDB.Update(nIndex, DBHumDataInfo.HumDataInfo);
          bo21 := False;
        end;
      end;
    finally
      HumDataDB.Close;
    end;
    FrmIDSoc.SetSessionSaveRcd(sUserId);
  end;
  pMsg.dwHead := RUNGATECODE;
  pMsg.dwCode := QueryID;
  pMsg.dwCheckCode := QueryID;
  pMsg.nLength := 0;
  pMsg.DefMsg.Ident := DBR_SAVEHUMANRCD;

  if not bo21 then begin
    {for i := 0 to HumSessionList.Count - 1 do begin
      HumSession := HumSessionList.Items[i];
      if (HumSession.sChrName = sChrName) and (HumSession.nIndex = nRecog) then
        begin
        HumSession.dwTick30 := GetTickCount();
        break;
      end;
    end;    }
    {m_DefMsg := MakeDefaultMsg(DBR_SAVEHUMANRCD, 1, 0, 0, 0);
    SendSocket(Socket, EncodeMessage(m_DefMsg));   }
    pMsg.DefMsg.Recog := 1;
  end
  else begin
    {m_DefMsg := MakeDefaultMsg(DBR_LOADHUMANRCD, 0, 0, 0, 0);
    SendSocket(Socket, EncodeMessage(m_DefMsg));}
    pMsg.DefMsg.Recog := 0;
  end;
  SendSocket(Socket, @pMsg, SizeOf(TDBMsgHeader));
end;
{
procedure TFrmDBSrv.SaveHumanRcdEx(sMsg: string; nRecog: Integer; Socket:
  TCustomWinSocket);
var
  sChrName: string;
  sUserId: string;
  sHumanRCD: string;
  i: Integer;
  //  bo21: Boolean;
  //  DefMsg: TDefaultMessage;
  //  HumanRCD: THumDataInfo;
  HumSession: pTHumSession;
begin
  sHumanRCD := GetValidStr3(sMsg, sUserId, ['/']);
  sHumanRCD := GetValidStr3(sHumanRCD, sChrName, ['/']);
  sUserId := DecodeString(sUserId);
  sChrName := DecodeString(sChrName);
  for i := 0 to HumSessionList.Count - 1 do begin
    HumSession := HumSessionList.Items[i];
    if (HumSession.sChrName = sChrName) and (HumSession.nIndex = nRecog) then
      begin
      HumSession.bo24 := False;
      HumSession.Socket := Socket;
      HumSession.bo2C := True;
      HumSession.dwTick30 := GetTickCount();
      break;
    end;
  end;
  SaveHumanRcd(nRecog, sMsg, Socket);
end;            }

procedure TFrmDBSrv.T2Click(Sender: TObject);
begin
  g_boTestServer := not g_boTestServer;
  T2.Checked := g_boTestServer;
  if not g_boTestServer then Caption := '数据库服务器 - 人物不重名'
  else Caption := '数据库服务器';
end;

procedure TFrmDBSrv.Timer1Timer(Sender: TObject);
var
  i: Integer;
begin
  LbTransCount.Caption := '访问次数=' + IntToStr(n348);
  n348 := 0;
  if ServerList.Count > 0 then
    CheckBox1.Checked := True
  else
    CheckBox1.Checked := False;
  ;
  CheckBox1.Caption := '通迅(' + IntToStr(ServerList.Count) + ')';
  //Label2.Caption := '连接数: ' + IntToStr(ServerList.Count);
  LbUserCount.Caption := IntToStr(FrmUserSoc.GetUserCount);
  if boOpenDBBusy then begin
    if n4ADB18 > 0 then begin
      if not bo4ADB1C then begin
        Label4.Caption := '[1/4] ' + IntToStr(ROUND((n4ADB10 / n4ADB18) * 1.0E2))
          + '% ' +
          IntToStr(n4ADB14) + '/' +
          IntToStr(n4ADB18);
      end;
    end;
    if n4ADB04 > 0 then begin
      if not boHumDBReady then begin
        Label4.Caption := '[3/4] ' + IntToStr(ROUND((n4ADAFC / n4ADB04) * 1.0E2))
          + '% ' +
          IntToStr(n4ADB00) + '/' +
          IntToStr(n4ADB04);
      end;
    end;
    if n4ADAF0 > 0 then begin
      if not boDataDBReady then begin
        Label4.Caption := '[4/4] ' + IntToStr(ROUND((n4ADAE4 / n4ADAF0) * 1.0E2))
          + '% ' +
          IntToStr(n4ADAE8) + '/' +
          IntToStr(n4ADAEC) + '/' +
          IntToStr(n4ADAF0);
      end;
    end;
  end;

  {LbAutoClean.Caption := IntToStr(g_nClearIndex) + '/(' + IntToStr(g_nClearCount)
    + '/' + IntToStr(g_nClearItemIndexCount) + ')/' +
    IntToStr(g_nClearRecordCount);  }
  LbAutoClean.Caption := IntToStr(HumDataDB.Count) + '/' + IntToStr(HumChrDB.Count);
  Label8.Caption := '查询角色=' + IntToStr(g_nQueryChrCount);
  Label9.Caption := '创建角色=' + IntToStr(nHackerNewChrCount);
  Label10.Caption := '删除角色=' + IntToStr(nHackerDelChrCount);
  Label11.Caption := '选择角色=' + IntToStr(nHackerSelChrCount);
  EnterCriticalSection(g_OutMessageCS);
  try
    ShowModule();
    for i := 0 to g_MainMsgList.Count - 1 do begin
      MemoLog.Lines.Add(FormatDateTime('[DD-HH:MM:SS] ', Now) +
        g_MainMsgList.Strings[i]);
    end;
    g_MainMsgList.Clear;
  finally
    LeaveCriticalSection(g_OutMessageCS);
  end;
  if MemoLog.Lines.Count > 200 then
    MemoLog.Lines.Clear;
end;

procedure TFrmDBSrv.ShowModule();
//var
//  nIndex: Integer;
//  dwTempTick, dwAliveTick: LongWord;
  function GetModule(nPort: Integer): Boolean;
  var
    i: Integer;
    Items: TListItem;
  begin
    Result := False;
    ListView.Items.BeginUpdate;
    try
      for i := 0 to FrmDBSrv.ListView.Items.Count - 1 do begin
        Items := ListView.Items.Item[i];
        if Items.Data <> nil then begin
          if Integer(Items.Data) = nPort then begin
            Result := True;
            break;
          end;
        end;
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;

  procedure DelModule(nPort: Integer);
  var
    i: Integer;
    DelItems: TListItem;
  begin
    ListView.Items.BeginUpdate;
    try
      for i := ListView.Items.Count - 1 downto 0 do begin
        DelItems := ListView.Items.Item[i];
        if DelItems.Data <> nil then begin
          if Integer(DelItems.Data) = nPort then begin
            ListView.Items.Delete(i);
            break;
          end;
        end;
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;

  procedure UpDateModule(nPort: Integer; sName, sAddr, sTimeTick: string);
  var
    UpDateItems: TListItem;
    i: Integer;
  begin
    ListView.Items.BeginUpdate;
    try
      if sTimeTick <> '' then begin
        for i := 0 to ListView.Items.Count - 1 do begin
          UpDateItems := ListView.Items.Item[i];
          if UpDateItems.Data <> nil then begin
            if Integer(UpDateItems.Data) = nPort then begin
              // UpDateItems.Caption := sName;
               //UpDateItems.SubItems[0] := sAddr;
              UpDateItems.SubItems[1] := sTimeTick;
              break;
            end;
          end;
        end;
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;

  procedure AddModule(nPort: Integer; sName, sAddr, sTimeTick: string);
  var
    AddItems: TListItem;
  begin
    ListView.Items.BeginUpdate;
    try
      if (nPort > 0) and (sName <> '') and (sAddr <> '') then begin
        AddItems := ListView.Items.Add;
        AddItems.Data := TObject(nPort);
        AddItems.Caption := sName;
        AddItems.SubItems.Add(sAddr);
        AddItems.SubItems.Add(sTimeTick);
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;
  function GetSelectTickStr(): string;
  var
    s01, s02: string;
  begin
    s01 := IntToStr(dwKeepAliveTick);
    s01 := Copy(s01, Length(s01) - 4, 4);
    s02 := IntToStr(GetTickCount + dwKeepAliveTick);
    s02 := Copy(s02, Length(s02) - 4, 4);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    Result := format('%s%s%s', [s01, '/', s02]);
  end;
  function GetIDServerTickStr(): string;
  var
    s01, s02: string;
  begin
    s01 := IntToStr(dwKeepIDAliveTick);
    s01 := Copy(s01, Length(s01) - 4, 4);
    s02 := IntToStr(GetTickCount + dwKeepIDAliveTick);
    s02 := Copy(s02, Length(s02) - 4, 4);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    Result := format('%s%s%s', [s01, '/', s02]);
  end;
  function GetM2ServerTickStr(): string;
  var
    s01, s02: string;
  begin
    s01 := IntToStr(dwKeepServerAliveTick);
    s01 := Copy(s01, Length(s01) - 4, 4);
    s02 := IntToStr(GetTickCount + dwKeepServerAliveTick);
    s02 := Copy(s02, Length(s02) - 4, 4);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then
      s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then
      s02 := Copy(s02, 2, Length(s02) - 1);
    Result := format('%s%s%s', [s01, '/', s02]);
  end;
begin
  if UserSocketClientConnected then begin
    if GetModule(g_nGatePort) then
      UpDateModule(g_nGatePort, '角色网关', User_sRemoteAddress + ':' +
        IntToStr(User_nRemotePort) + ' → ' + User_sRemoteAddress + ':' +
        IntToStr(g_nGatePort), GetSelectTickStr())
    else
      AddModule(g_nGatePort, '角色网关', User_sRemoteAddress + ':' +
        IntToStr(User_nRemotePort) + ' → ' + User_sRemoteAddress + ':' +
        IntToStr(g_nGatePort), GetSelectTickStr());
  end
  else begin
    if GetModule(g_nGatePort) then
      DelModule(g_nGatePort);
  end;
  if IDSocketConnected then begin
    if GetModule(nIDServerPort) then
      UpDateModule(nIDServerPort, sServerName, ID_sRemoteAddress + ':' +
        IntToStr(ID_nRemotePort) + ' → ' + ID_sRemoteAddress + ':' +
        IntToStr(nIDServerPort), GetIDServerTickStr())
    else
      AddModule(nIDServerPort, sServerName, ID_sRemoteAddress + ':' +
        IntToStr(ID_nRemotePort) + ' → ' + ID_sRemoteAddress + ':' +
        IntToStr(nIDServerPort), GetIDServerTickStr());
  end
  else begin
    if GetModule(nIDServerPort) then
      DelModule(nIDServerPort);
  end;
  if ServerSocketClientConnected then begin
    if GetModule(nServerPort) then
      UpDateModule(nServerPort, '游戏中心', Server_sRemoteAddress + ':' +
        IntToStr(Server_nRemotePort) + ' → ' + Server_sRemoteAddress + ':' +
        IntToStr(nServerPort), GetM2ServerTickStr())
    else
      AddModule(nServerPort, '游戏中心', Server_sRemoteAddress + ':' +
        IntToStr(Server_nRemotePort) + ' → ' + Server_sRemoteAddress + ':' +
        IntToStr(nServerPort), GetM2ServerTickStr());
  end
  else begin
    if GetModule(nServerPort) then
      DelModule(nServerPort);
  end;
  {if DataManageSocketClientConnected then begin
    if GetModule(nDataManagePort) then
      UpDateModule(nDataManagePort, '数据管理', DataManage_sRemoteAddress + ':' + IntToStr(DataManage_nRemotePort) + ' → ' + DataManage_sRemoteAddress + ':' + IntToStr(nServerPort), '')
    else AddModule(nDataManagePort, '数据管理', DataManage_sRemoteAddress + ':' + IntToStr(DataManage_nRemotePort) + ' → ' + DataManage_sRemoteAddress + ':' + IntToStr(nServerPort), '');
  end else begin
    if GetModule(nDataManagePort) then DelModule(nDataManagePort);
  end;}
end;

procedure TFrmDBSrv.FormCreate(Sender: TObject);
var
  //  Conf: TIniFile;
  nX, nY: Integer;
begin
  g_dwGameCenterHandle := StrToIntDef(ParamStr(1), 0);
  nX := StrToIntDef(ParamStr(2), -1);
  nY := StrToIntDef(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top := nY;
  end;
  m_boRemoteClose := False;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  //MainOutMessage('正在启动数据库服务器...');
  boOpenDBBusy := True;
  Label4.Caption := '';
  LbAutoClean.Caption := '-/-';
  HumChrDB := nil;
  HumDataDB := nil;
  {
  Conf:=TIniFile.Create('sConfFileName');
  if Conf <> nil then begin
    sDataDBFilePath:=Conf.ReadString('DB','Dir',sDataDBFilePath);
    sHumDBFilePath:=Conf.ReadString('DB','HumDir',sHumDBFilePath);
    sFeedPath:=Conf.ReadString('DB','FeeDir',sFeedPath);
    sBackupPath:=Conf.ReadString('DB','Backup',sBackupPath);
    sConnectPath:=Conf.ReadString('DB','ConnectDir',sConnectPath);
    sLogPath:=Conf.ReadString('DB','LogDir',sLogPath);
    nServerPort:=Conf.ReadInteger('Setup','ServerPort',nServerPort);
    sServerAddr:=Conf.ReadString('Setup','ServerAddr',sServerAddr);
    boViewHackMsg:=Conf.ReadBool('Setup','ViewHackMsg',boViewHackMsg);
    sServerName:=Conf.ReadString('Setup','ServerName',sServerName);
    Conf.Free;
  end;
  }
  LoadConfig();
  ServerList := TList.Create;
  //HumSessionList := TList.Create;
  //AttackIPaddrList := TGList.Create; //攻击IP临时列表
  //Label5.Caption:='FDB: ' + sDataDBFilePath + 'Mir.DB  ' + 'Backup: ' + sBackupPath;
  //n334 := 0;
  n4ADBF4 := 0;
  n4ADBF8 := 0;
  n4ADBFC := 0;
  n4ADC00 := 0;
  n4ADC04 := 0;
  n344 := 2;
  n348 := 0;
  nHackerNewChrCount := 0;
  nHackerDelChrCount := 0;
  nHackerSelChrCount := 0;
  n4ADC1C := 0;
  n4ADC20 := 0;
  n4ADC24 := 0;
  n4ADC28 := 0;
  SendGameCenterMsg(SG_STARTNOW, '正在启动数据库服务器...');
  StartTimer.Enabled := True;
  if not g_boTestServer then Caption := '数据库服务器 - 人物不重名'
  else Caption := '数据库服务器';
end;

procedure TFrmDBSrv.StartTimerTimer(Sender: TObject);
begin
  StartTimer.Enabled := False;
  if SizeOf(THumDataInfo) <> SIZEOFTHUMAN then begin
    ShowMessage('SizeOf(THumData) ' + IntToStr(SizeOf(THumDataInfo)) + ' <> SIZEOFTHUMAN ' + IntToStr(SIZEOFTHUMAN));
    Close;
    Exit;
  end;
  ListView.Items.Clear;
  boOpenDBBusy := True;
  HumChrDB := TFileHumDB.Create(sDataDBFilePath + 'Hum.DB');
  if HumChrDB.m_Header.sDesc <> HumDB.sDBHeaderDesc then begin
    ShowMessage('Hum.DB 文件版本不符合程序要求 ' + #13#10 + '文件版本：' + HumChrDB.m_Header.sDesc + #13#10 + '要求版本：' + HumDB.sDBHeaderDesc);
    Exit;
  end;
  HumDataDB := TFileDB.Create(sDataDBFilePath + 'Mir.DB');
  if HumDataDB.m_Header.sDesc <> HumDB.sDBHeaderDesc then begin
    ShowMessage('Mir.DB 文件版本不符合程序要求 ' + #13#10 + '文件版本：' + HumDataDB.m_Header.sDesc + #13#10 + '要求版本：' + HumDB.sDBHeaderDesc);
    Exit;
  end;
  if HumDataDB.Count >= Trunc(PLAYOBJECTINDEXCOUNT / 10 * 8) then begin
    ShowMessage('用户数量即将达到影响程序安全数量 ' + IntToStr(HumDataDB.Count) + '/' + IntToStr(PLAYOBJECTINDEXCOUNT));
    //Close;
    //exit;
  end;

  boOpenDBBusy := False;
  boAutoClearDB := True;
  Label4.Caption := '';
  LoadMagicDB();
  LoadItemsDB();
  LoadFiltrateName();
  //MainOutMessage('排行榜计算完成(' + IntToStr(LoadGameSort()) + ')...');
  g_boArraySortTime := LongWord(GetTickCount + g_btSortMinute * 60000 + g_btSortHour * 3600000);
  Timer1.Enabled := True;
  Timer2.Enabled := True;
  ServerSocket.Address := sServerAddr;
  ServerSocket.Port := nServerPort;
  ServerSocket.Active := True;
  FrmIDSoc.OpenConnect();
  MainOutMessage('数据库服务器已启动完成...');
  SendGameCenterMsg(SG_STARTOK, '数据库服务器启动完成...');
  SendGameCenterMsg(SG_CHECKCODEADDR, IntToStr(Integer(@g_CheckCode)));
end;

procedure TFrmDBSrv.FormDestroy(Sender: TObject);
var
  i: Integer;
  ServerInfo: pTServerInfo;
  //HumSession: pTHumSession;
  //  IPList: TList;
begin
  if HumDataDB <> nil then
    HumDataDB.Free;
  if HumChrDB <> nil then
    HumChrDB.Free;
  for i := 0 to ServerList.Count - 1 do begin
    ServerInfo := ServerList.Items[i];
    if ServerInfo.RecvBuff <> nil then
      FreeMem(ServerInfo.RecvBuff);
    Dispose(ServerInfo);
  end;
  ServerList.Free;
  {for i := 0 to HumSessionList.Count - 1 do begin
    HumSession := HumSessionList.Items[i];
    Dispose(HumSession);
  end;
  HumSessionList.Free; }

  {AttackIPaddrList.Lock;
  try
    for i := 0 to AttackIPaddrList.Count - 1 do begin
      Dispose(pTSockaddr(AttackIPaddrList.Items[i]));
    end;
  finally
    AttackIPaddrList.UnLock;
    AttackIPaddrList.Free;
  end;         }
end;

procedure TFrmDBSrv.F1Click(Sender: TObject);
begin
  LoadFiltrateName();
  MainOutMessage('加载过滤列表完成...');
end;

procedure TFrmDBSrv.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if m_boRemoteClose then
    Exit;
  if Application.MessageBox('是否确定退出数据库服务器 ?',
    '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    CanClose := True;
    ServerSocket.Active := False;
    MainOutMessage('正在关闭服务器...');
  end
  else begin
    CanClose := False;
  end;
end;

function TFrmDBSrv.LoadItemsDB(): Integer;
var
  i, Idx: Integer;
  StdItem: pTStdItem;
  nRecordCount: Integer;
resourcestring
  sSQLString = 'select * from StdItems';
begin
  //MainOutMessage('正在加载物品数据...');
  try
    Result := -1;
    Query.SQL.Clear;
    Query.DatabaseName := sHeroDB;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -2;
    end;
    nRecordCount := Query.RecordCount;
    for i := 0 to nRecordCount - 1 do begin
      New(StdItem);
      Idx := Query.FieldByName('Idx').AsInteger;
      StdItem.Idx := Idx;
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
      StdItem.Bind := Query.FieldByName('Bind').AsInteger;
      StdItem.AddWuXinAttack := 0;
      StdItem.DelWuXinAttack := 0;
      StdItem.StdMode := GetItemType(StdItem.StdMode2);
      StdItem.StdModeEx := GetItemTypeEx(StdItem.StdMode);
      StdItem.Need := Query.FieldByName('Need').AsInteger;
      StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;
      StdItem.Price := Query.FieldByName('Price').AsInteger;
      if StdItemList.Count = Idx then begin
        StdItemList.Add(StdItem);
        Result := 1;
      end
      else begin
        MainOutMessage(format('加载物品(Idx:%d Name:%s)数据失败！！！', [Idx, StdItem.Name]));
        Result := -100;
        Exit;
      end;
      Query.Next;
    end;
    Result := nRecordCount;
    MainOutMessage(format('物品数据库加载完成(%d)...', [nRecordCount]));
  finally
    Query.Close;
  end;
end;

function TFrmDBSrv.LoadMagicDB(): Integer;
var
  i, nRecordCount: Integer;
  Magic: pTMagic;
resourcestring
  sSQLString = 'select * from Magic';
begin
  //  Result := -1;
    //MainOutMessage('正在加载技能数据库...');
  Query.SQL.Clear;
  Query.DatabaseName := sHeroDB;
  Query.SQL.Add(sSQLString);
  try
    Query.Open;
  finally
    Result := -2;
  end;
  nRecordCount := Query.RecordCount;
  for i := 0 to nRecordCount - 1 do begin
    New(Magic);
    Magic.wMagicId := Query.FieldByName('MagId').AsInteger;
    Magic.sMagicName := Query.FieldByName('MagName').AsString;
    Magic.btEffectType := Query.FieldByName('EffectType').AsInteger;
    Magic.btEffect := Query.FieldByName('Effect').AsInteger;
    Magic.wMagicIcon := Query.FieldByName('MagicIcon').AsInteger;
    Magic.btJob := Query.FieldByName('Job').AsInteger;
    Magic.dwDelayTime := Query.FieldByName('Delay').AsInteger;
    Magic.nInterval := Query.FieldByName('Interval').AsInteger;
    Magic.nSpellFrame := Query.FieldByName('SpellFrame').AsInteger;
    Magic.wSpell := Query.FieldByName('Spell').AsInteger;
    Magic.btDefSpell := Query.FieldByName('DefSpell').AsInteger;
    Magic.wPower := Query.FieldByName('Power').AsInteger;
    Magic.wMaxPower := Query.FieldByName('MaxPower').AsInteger;
    Magic.btDefPower := Query.FieldByName('DefPower').AsInteger;
    Magic.btDefMaxPower := Query.FieldByName('DefMaxPower').AsInteger;
    // 原先是满级 3 级，现在改为 20 级。未来的转生技能，可能是 100 级。
    Magic.btTrainLv := 20;
    // 改为每级增加的百分比伤害
    Magic.TrainLevel[0] := Query.FieldByName('NeedL1').AsInteger;
    Magic.TrainLevel[1] := Query.FieldByName('NeedL2').AsInteger;
    Magic.TrainLevel[2] := Query.FieldByName('NeedL3').AsInteger;
    Magic.TrainLevel[3] := Query.FieldByName('NeedL3').AsInteger;
    // 改为基础百分比伤害
    Magic.MaxTrain[0] := Query.FieldByName('L1Train').AsInteger;
    Magic.MaxTrain[1] := Query.FieldByName('L2Train').AsInteger;
    Magic.MaxTrain[2] := Query.FieldByName('L3Train').AsInteger;
    Magic.MaxTrain[3] := Magic.MaxTrain[2];
    if Magic.wMagicId > 0 then begin
      MagicList.Add(Magic);
    end
    else begin
      Dispose(Magic);
    end;
    Result := 1;
    Query.Next;
  end;
  MainOutMessage(format('技能数据库加载完成(%d)...', [nRecordCount]));
  Query.Close;
end;

procedure TFrmDBSrv.Timer2Timer(Sender: TObject);
//var
  //i: Integer;
  //HumSession: pTHumSession;
//  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  {i := 0;
  while (True) do begin
    if HumSessionList.Count <= i then
      break;
    HumSession := HumSessionList.Items[i];
    if not HumSession.bo24 then begin
      if HumSession.bo2C then begin
        if (GetTickCount - HumSession.dwTick30) > 20 * 1000 then begin
          Dispose(HumSession);
          HumSessionList.Delete(i);
          Continue;
        end;
      end
      else begin
        if (GetTickCount - HumSession.dwTick30) > 2 * 60 * 1000 then begin
          Dispose(HumSession);
          HumSessionList.Delete(i);
          Continue;
        end;
      end;
    end;
    if (GetTickCount - HumSession.dwTick30) > 40 * 60 * 1000 then begin
      Dispose(HumSession);
      HumSessionList.Delete(i);
      Continue;
    end;
    Inc(i);
  end;       }
 { if g_boAutoSort then begin
    DecodeDate(Date, Year, Month, Day);
    DecodeTime(Time, Hour, Min, Sec, MSec);
    if g_boSortClass then begin
      if (Hour = g_btSortHour) and (Min = g_btSortMinute) and (not g_boArraySort)
        then begin
        g_boArraySort := True;
        AccountGameSort();
      end;
      if Hour <> g_btSortHour then
        g_boArraySort := False;
    end
    else begin
      if GetTickCount > g_boArraySortTime then begin
        g_boArraySortTime := LongWord(GetTickCount + g_btSortMinute * 60000 +
          g_btSortHour * 3600000);
        AccountGameSort();
      end;
    end;
  end;    }
end;

procedure TFrmDBSrv.BtnUserDBToolClick(Sender: TObject);
begin
  if boHumDBReady and boDataDBReady then
    FrmIDHum.Show;
end;

procedure TFrmDBSrv.CkViewHackMsgClick(Sender: TObject);
{var
  Conf: TIniFile; }
begin
  {  Conf := TIniFile.Create(sConfFileName);
    if Conf <> nil then begin
      Conf.WriteBool('Setup', 'ViewHackMsg', CkViewHackMsg.Checked);
      Conf.Free;
    end;   }
end;

procedure TFrmDBSrv.ClearSocket(Socket: TCustomWinSocket);
//var
//  nIndex: Integer;
  //HumSession: pTHumSession;
begin
  {nIndex := 0;
  while (True) do begin
    if HumSessionList.Count <= nIndex then
      break;
    HumSession := HumSessionList.Items[nIndex];
    if HumSession.Socket = Socket then begin
      Dispose(HumSession);
      HumSessionList.Delete(nIndex);
      Continue;
    end;
    Inc(nIndex);
  end;   }
end;

function TFrmDBSrv.CopyHumData(sSrcChrName, sDestChrName,
  sUserId: string): Boolean;
var
  n14: Integer;
  bo15: Boolean;
  HumanRCD: THumDataInfo;
begin
  Result := False;
  bo15 := False;
  try
    if HumDataDB.Open then begin
      n14 := HumDataDB.Index(sSrcChrName);
      if (n14 >= 0) and (HumDataDB.Get(n14, HumanRCD) >= 0) then
        bo15 := True;
      if bo15 then begin
        n14 := HumDataDB.Index(sDestChrName);
        if (n14 >= 0) then begin
          HumanRCD.Header.sName := sDestChrName;
          HumanRCD.Data.sChrName := sDestChrName;
          HumanRCD.Data.sAccount := sUserId;
          HumDataDB.Update(n14, HumanRCD);
          Result := True;
        end;
      end;
    end;
  finally
    HumDataDB.Close;
  end;
end;

procedure TFrmDBSrv.DelHum(sChrName: string);
begin
  try
    if HumChrDB.Open then
      HumChrDB.Delete(sChrName);
  finally
    HumChrDB.Close;
  end;
end;

procedure TFrmDBSrv.MENU_MANAGE_DATAClick(Sender: TObject);
begin
  if boHumDBReady and boDataDBReady then
    FrmIDHum.Show;
end;

procedure TFrmDBSrv.MENU_MANAGE_INFOClick(Sender: TObject);
begin
  frmDBTool.Top := Self.Top + 20;
  frmDBTool.Left := Self.Left;
  frmDBTool.Open();
end;

procedure TFrmDBSrv.MENU_MANAGE_TOOLClick(Sender: TObject);
begin
  FrmFDBExplore.Top := Self.Top + 20;
  FrmFDBExplore.Left := Self.Left;
  FrmFDBExplore.ShowModal;
end;

procedure TFrmDBSrv.MyMessage(var MsgData: TWmCopyData);
var
  sData: string;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of
    GS_QUIT: begin
        ServerSocket.Active := False;
        m_boRemoteClose := True;
        Close();
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TFrmDBSrv.MENU_TEST_SELGATEClick(Sender: TObject);
begin
  frmTestSelGate := TfrmTestSelGate.Create(Owner);
  frmTestSelGate.ShowModal;
  frmTestSelGate.Free;
end;

procedure TFrmDBSrv.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  if Sender = MENU_CONTROL_START then begin

  end
  else if Sender = MENU_OPTION_GAMEGATE then begin
    frmRouteManage.Open;
  end;
end;

procedure TFrmDBSrv.G1Click(Sender: TObject);
begin
  try
    FrmUserSoc.LoadServerInfo();
    LoadIPTable();
    //LoadGateID();
    MainOutMessage('加载网关设置完成...');
  except
    MainOutMessage('加载网关设置失败...');
  end;
end;
{
procedure TFrmDBSrv.GetSortList(sMsg: string; nRecog: Integer;
  Socket: TCustomWinSocket);
var
  sSendMsg: string;
begin
  sSendMsg := '';
  HumDataDB.Lock;
  try
    case nRecog of
      DBT_SELFALL: sSendMsg := EncodeBuffer(@g_TaxisAllList, SizeOf(g_TaxisAllList));
      DBT_SELFWARR: sSendMsg := EncodeBuffer(@g_TaxisWarrList,
        SizeOf(g_TaxisWarrList));
      DBT_SELFWAID: sSendMsg := EncodeBuffer(@g_TaxisWaidList,
        SizeOf(g_TaxisWaidList));
      DBT_SELFTAOS: sSendMsg := EncodeBuffer(@g_TaxisTaosList,
        SizeOf(g_TaxisTaosList));
      DBT_MASTER: sSendMsg := EncodeBuffer(@g_TaxisMasterList,
        SizeOf(g_TaxisMasterList));
      DBT_HEROALL: sSendMsg := EncodeBuffer(@g_TaxisHeroAllList,
          SizeOf(g_TaxisHeroAllList));
      DBT_HEROWARR: sSendMsg := EncodeBuffer(@g_TaxisHeroWarrList,
          SizeOf(g_TaxisHeroWarrList));
      DBT_HEROWAID: sSendMsg := EncodeBuffer(@g_TaxisHeroWaidList,
          SizeOf(g_TaxisHeroWaidList));
      DBT_HEROTAOS: sSendMsg := EncodeBuffer(@g_TaxisHeroTaosList,
          SizeOf(g_TaxisHeroTaosList));
    end;
  finally
    HumDataDB.UnLock;
  end;
  m_DefMsg := MakeDefaultMsg(DBR_GETSORTLIST, nRecog, 0, 0, 0);
  SendSocket(Socket, EncodeMessage(m_DefMsg) + sSendMsg);
end;                                                      }

procedure TFrmDBSrv.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
  MemoLog.Lines.Add(E.Message);
end;

procedure TFrmDBSrv.X1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmDBSrv.N3Click(Sender: TObject);
begin
  //ShellAbout(Handle,'szapp','szotherstuff',Application.Icon.Handle);
  //MainOutMessage(g_sVersion);
  MainOutMessage(g_sUpDateTime);
  MainOutMessage(g_sProgram);
  MainOutMessage(g_sWebSite);
end;

end.

