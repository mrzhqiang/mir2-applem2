unit MasSock;

interface

uses
  Windows, SysUtils, Classes, 
  Controls, Forms, Dialogs, JSocket, Common, LSShare, SDK, ExtCtrls;
type
  TMsgServerInfo = record
    sReceiveMsg: string;
    sSendMsg: string;
    Socket: TCustomWinSocket;
    sServerName: string; //0x08
    nServerIndex: Integer; //0x0C
    nOnlineCount: Integer; //0x10
    nSelectID: Integer;
    dwKeepAliveTick: LongWord; //0x14
    sIPaddr: string;
  end;
  pTMsgServerInfo = ^TMsgServerInfo;
  TLimitServerUserInfo = record
    sServerName: string;
    sName: string;
    nLimitCountMin: Integer;
    nLimitCountMax: Integer;
  end;
  pTLimitServerUserInfo = ^TLimitServerUserInfo;
  TFrmMasSoc = class(TForm)
    MSocket: TServerSocket;
    Timer1: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure MSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure MSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure MSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Timer1Timer(Sender: TObject);
  private
//    procedure SortServerList(nIndex: Integer);
    procedure RefServerLimit(sServerName: string);

    //function LimitName(sServerName: string): string;
    { Private declarations }
    procedure SendSocket(MsgServer: pTMsgServerInfo; sMsg: string);
  public
    m_ServersList: TGList;
    procedure LoadServerAddr();
    procedure LoadUserLimit;
    procedure GetGoldChangeMsg(body: string);
    procedure CreateNewChr(body: string);
    procedure CreateNewGuild(body: string);
    procedure GetLargessGold(body: string);
    //function CheckReadyServers(): Boolean;
    procedure SendServerMsg(wIdent: Word; sServerName, sMsg: string);
    procedure SendServerMsgToServer(wIdent: Word; sMsg: string);
    procedure SendDBServerMsgToServer(wIdent: Word; sMsg: string);
    procedure SendServerMsgA(wIdent: Word; sMsg: string);
    function IsNotUserFull(): Boolean;
    //function ServerStatus(sServerName: string): Integer;
    function GetOnlineHumCount(): Integer;
    { Public declarations }
  end;

var
  FrmMasSoc: TFrmMasSoc;
//  nUserLimit: Integer;
  //UserLimit: array[0..MAXGATEROUTE - 1] of TLimitServerUserInfo;
  UserLimit: TLimitServerUserInfo;

implementation

uses LMain, HUtil32, SqlSock;

{$R *.DFM}

procedure TFrmMasSoc.FormCreate(Sender: TObject);
var
  Config: pTConfig;
begin
  Config := @g_Config;
  m_ServersList := TGList.Create;
  MSocket.Address := Config.sServerAddr;
  MSocket.Port := Config.nServerPort;
  MSocket.Active := true;
  Timer1.Enabled := True;
  LoadServerAddr();
  LoadUserLimit();
end;

procedure TFrmMasSoc.MSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  sRemoteAddr: string;
  boAllowed: Boolean;
  MsgServer: pTMsgServerInfo;
begin
  sRemoteAddr := Socket.RemoteAddress;
  boAllowed := False;
  for I := Low(ServerAddr) to High(ServerAddr) do
    if sRemoteAddr = ServerAddr[I] then begin
      boAllowed := true;
      break;
    end;
  if boAllowed then begin
    New(MsgServer);
    SafeFillChar(MsgServer^, SizeOf(TMsgServerInfo), #0);
    MsgServer.sReceiveMsg := '';
    MsgServer.sSendMsg := '';
    MsgServer.Socket := Socket;
    m_ServersList.Lock;
    Try
      m_ServersList.Add(MsgServer);
    Finally
      m_ServersList.UnLock;
    End;
  end
  else begin
    MainOutMessage('非法地址连接:' + sRemoteAddr);
    Socket.Close;
  end;
end;

procedure TFrmMasSoc.MSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  MsgServer: pTMsgServerInfo;
begin
  m_ServersList.Lock;
  Try
    for I := 0 to m_ServersList.Count - 1 do begin
      MsgServer := m_ServersList.Items[I];
      if MsgServer.Socket = Socket then begin
        Dispose(MsgServer);
        m_ServersList.Delete(I);
        break;
      end;
    end;
  Finally
    m_ServersList.UnLock;
  End;
end;

procedure TFrmMasSoc.MSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmMasSoc.MSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  MsgServer: pTMsgServerInfo;
  sReviceMsg: string;
  sMsg: string;
  sCode: string;
  sAccount: string;
  sServerName: string;
  sIndex: string;
  sOnlineCount: string;
  nCode: Integer;
  Config: pTConfig;
begin
  Config := @g_Config;
  m_ServersList.Lock;
  Try
    for I := 0 to m_ServersList.Count - 1 do begin
      MsgServer := m_ServersList.Items[I];
      if MsgServer.Socket = Socket then begin
        sReviceMsg := MsgServer.sReceiveMsg + Socket.ReceiveText;
        while (Pos(')', sReviceMsg) > 0) do begin
          //(103/叶随风飘/99/0)
          //MainOutMessage(sReviceMsg);
          sReviceMsg := ArrestStringEx(sReviceMsg, '(', ')', sMsg);
          if sMsg = '' then
            break;
          sMsg := GetValidStr3(sMsg, sCode, ['/']);
          nCode := StrToIntDef(sCode, -1);
          case nCode of
            SS_CREATENEWCHR: CreateNewChr(sMsg);
            SS_CHANGEGOLD: GetGoldChangeMsg(sMsg);
            SS_CREATENEWGUILD: CreateNewGuild(sMsg);
            SS_GETLARGESSGOLD: GetLargessGold(sMsg);
            SS_SOFTOUTSESSION: begin
                sMsg := GetValidStr3(sMsg, sAccount, ['/']);
                CloseUser(Config, sAccount, StrToIntDef(sMsg, 0));
              end;
            SS_SERVERINFO: begin
                sMsg := GetValidStr3(sMsg, sServerName, ['/']);
                sMsg := GetValidStr3(sMsg, sIndex, ['/']);
                sMsg := GetValidStr3(sMsg, sOnlineCount, ['/']);
                MsgServer.sServerName := sServerName;
                MsgServer.nServerIndex := StrToIntDef(sIndex, 0);
                MsgServer.nOnlineCount := StrToIntDef(sOnlineCount, 0);
                if sMsg = '' then
                  MsgServer.nSelectID := 0
                else
                  MsgServer.nSelectID := StrToIntDef(sMsg, 0);
                MsgServer.dwKeepAliveTick := GetTickCount();
                //SortServerList(I);
                if MsgServer.nServerIndex = 0 then begin
                  nOnlineCountMin := GetOnlineHumCount();
                  if nOnlineCountMin > nOnlineCountMax then
                    nOnlineCountMax := nOnlineCountMin;
                end;
                SendServerMsgA(SS_KEEPALIVE {1040}, IntToStr(nOnlineCountMin));
                RefServerLimit(sServerName);
              end;
            UNKNOWMSG: SendServerMsgA(UNKNOWMSG, sMsg);
          end;
        end;
      end;
      MsgServer.sReceiveMsg := sReviceMsg;
    end;
  Finally
    m_ServersList.UnLock;
  End;

end;

procedure TFrmMasSoc.FormDestroy(Sender: TObject);
begin
  m_ServersList.Free;
end;

procedure TFrmMasSoc.RefServerLimit(sServerName: string);
var
  I: Integer;
  nCount: Integer;
  MsgServer: pTMsgServerInfo;
begin

  try
    nCount := 0;
    m_ServersList.Lock;
    try
      for I := 0 to m_ServersList.Count - 1 do begin
        MsgServer := m_ServersList.Items[I];
        if (MsgServer.nServerIndex <> 99) then
          Inc(nCount, MsgServer.nOnlineCount);
      end;
      UserLimit.nLimitCountMin := nCount;
    finally
      m_ServersList.UnLock;
    end;
    {for I := 0 to m_ServerList.Count - 1 do begin
      MsgServer := m_ServerList.Items[I];
      if (MsgServer.nServerIndex <> 99) and (MsgServer.sServerName = sServerName)
        then
        Inc(nCount, MsgServer.nOnlineCount);
    end;
    for I := Low(UserLimit) to High(UserLimit) do begin
      if CompareText(UserLimit[I].sServerName, sServerName) = 0 then begin
        UserLimit[I].nLimitCountMin := nCount;
        break;
      end;
    end; }
  except
    MainOutMessage('TFrmMasSoc.RefServerLimit');
  end;
end;

function TFrmMasSoc.IsNotUserFull(): Boolean;
begin
  Result := UserLimit.nLimitCountMin < UserLimit.nLimitCountMax;
end;
{
procedure TFrmMasSoc.SortServerList(nIndex: Integer);
var
  nC, n10, n14: Integer;
  MsgServerSort: pTMsgServerInfo;
  MsgServer: pTMsgServerInfo;
  nNewIndex: Integer;
begin
  try
    if m_ServerList.Count <= nIndex then
      Exit;
    MsgServerSort := m_ServerList.Items[nIndex];
    m_ServerList.Delete(nIndex);
    for nC := 0 to m_ServerList.Count - 1 do begin
      MsgServer := m_ServerList.Items[nC];
      if MsgServer.sServerName = MsgServerSort.sServerName then begin
        if MsgServer.nServerIndex < MsgServerSort.nServerIndex then begin
          m_ServerList.Insert(nC, MsgServerSort);
          Exit;
        end
        else begin
          nNewIndex := nC + 1;
          if nNewIndex < m_ServerList.Count then begin //Jacky 增加
            for n10 := nNewIndex to m_ServerList.Count - 1 do begin
              MsgServer := m_ServerList.Items[n10];
              if MsgServer.sServerName = MsgServerSort.sServerName then begin
                if MsgServer.nServerIndex < MsgServerSort.nServerIndex then begin
                  m_ServerList.Insert(n10, MsgServerSort);
                  for n14 := n10 + 1 to m_ServerList.Count - 1 do begin
                    MsgServer := m_ServerList.Items[n14];
                    if (MsgServer.sServerName = MsgServerSort.sServerName) and
                      (MsgServer.nServerIndex = MsgServerSort.nServerIndex) then
                        begin
                      m_ServerList.Delete(n14);
                      Exit;
                    end;
                  end;
                  Exit;
                end
                else begin
                  nNewIndex := n10 + 1;
                end;
              end;
            end;
            m_ServerList.Insert(nNewIndex, MsgServerSort);
            Exit;
          end;
        end;
      end;
    end;
    m_ServerList.Add(MsgServerSort);
  except
    MainOutMessage('TFrmMasSoc.SortServerList');
  end;
end;    }

procedure TFrmMasSoc.SendSocket(MsgServer: pTMsgServerInfo; sMsg: string);
var
  sSendMsg: string;
  nLen: Integer;
begin
  if MsgServer.Socket.Connected then begin
    MsgServer.sSendMsg := MsgServer.sSendMsg + sMsg;
    while MsgServer.sSendMsg <> '' do begin
      nLen := Length(MsgServer.sSendMsg);
      if nLen > MAXSOCKETBUFFLEN then begin
        sSendMsg := Copy(MsgServer.sSendMsg, 1, MAXSOCKETBUFFLEN);
        if MsgServer.Socket.SendText(sSendMsg) <> -1 then begin
          MsgServer.sSendMsg := Copy(MsgServer.sSendMsg, MAXSOCKETBUFFLEN + 1, nLen - MAXSOCKETBUFFLEN);
        end else
          break;
      end else begin
        if MsgServer.Socket.SendText(MsgServer.sSendMsg) <> -1 then
          MsgServer.sSendMsg := '';
        break;
      end;
    end;
  end else
    MsgServer.sSendMsg := '';
  {nSendLen := 0;
  if MsgServer.Socket.Connected then
    nSendLen := MsgServer.Socket.SendText(MsgServer.sSendMsg);
  if nSendLen <> -1 then
    MsgServer.sSendMsg := '';   }
  {if (nSendLen = nLen) or (nSendLen = 0) then begin
    MsgServer.sSendMsg := '';
  end else
  if (nSendLen < nLen) then begin
    MsgServer.sSendMsg := Copy(MsgServer.sSendMsg, nSendLen + 1, nLen - nSendLen);
  end; }
end;

procedure TFrmMasSoc.Timer1Timer(Sender: TObject);
Const
  boRun: Boolean = False;
var
  I: Integer;
  MsgServer: pTMsgServerInfo;
begin
  if boRun then exit;
  try
    boRun := True;
    m_ServersList.Lock;
    Try
      for I := 0 to m_ServersList.Count - 1 do begin
        MsgServer := pTMsgServerInfo(m_ServersList.Items[I]);
        if MsgServer.sSendMsg <> '' then begin
          SendSocket(MsgServer, '');
        end;
      end;
    Finally
      m_ServersList.UnLock;
      boRun := False;
    End;
  except
    MainOutMessage('TFrmMasSoc.Timer1Timer');
  end;
end;

procedure TFrmMasSoc.SendDBServerMsgToServer(wIdent: Word; sMsg: string);
var
  I: Integer;
  MsgServer: pTMsgServerInfo;
  sSendMsg: string;
resourcestring
  sFormatMsg = '(%d/%s)';
begin
  try
    m_ServersList.Lock;
    Try
      sSendMsg := format(sFormatMsg, [wIdent, sMsg]);
      for I := 0 to m_ServersList.Count - 1 do begin
        MsgServer := pTMsgServerInfo(m_ServersList.Items[I]);
        if {MsgServer.Socket.Connected and }(MsgServer.nServerIndex = 99){M2Server} then begin
          SendSocket(MsgServer, sSendMsg);
          //MsgServer.Socket.SendText(sSendMsg);
        end;
      end;
    Finally
      m_ServersList.UnLock;
    End;
  except
    MainOutMessage('TFrmMasSoc.SendDBServerMsgToServer');
  end;
end;

procedure TFrmMasSoc.SendServerMsg(wIdent: Word; sServerName, sMsg: string);
var
  I: Integer;
  MsgServer: pTMsgServerInfo;
  sSendMsg: string;
resourcestring
  sFormatMsg = '(%d/%s)';
begin
  try
    m_ServersList.Lock;
    Try
      sSendMsg := format(sFormatMsg, [wIdent, sMsg]);
      for I := 0 to m_ServersList.Count - 1 do begin
        MsgServer := pTMsgServerInfo(m_ServersList.Items[I]);
        SendSocket(MsgServer, sSendMsg);
        {if MsgServer.Socket.Connected then begin
          MsgServer.Socket.SendText(sSendMsg);
        end;  }
      end;
    Finally
      m_ServersList.UnLock;
    End;
  except
    MainOutMessage('TFrmMasSoc.SendServerMsg');
  end;
end;

procedure TFrmMasSoc.LoadServerAddr();
var
  sFileName: string;
  LoadList: TStringList;
  I, nServerIdx: Integer;
  sLineText: string;
begin
  sFileName := sServerIPConfFileNmae;
  nServerIdx := 0;
  SafeFillChar(ServerAddr, SizeOf(ServerAddr), #0);
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if (sLineText <> '') and (sLineText[I] <> ';') then begin
        if TagCount(sLineText, '.') = 3 then begin
          ServerAddr[nServerIdx] := sLineText;
          Inc(nServerIdx);
          if nServerIdx >= MAXGATEROUTE - 1 then
            break;
        end;
      end;
    end;
    LoadList.Free;
  end;
end;
{$IF RUNVAR = VAR_DB}
procedure TFrmMasSoc.CreateNewChr(body: string);
var
  sWaitID, sChrName, sHair, sJob, sSex: string;
begin
  body := GetValidStr3(body, sWaitID, ['/']);
  body := GetValidStr3(body, sHair, ['/']);
  body := GetValidStr3(body, sJob, ['/']);
  sChrName := GetValidStr3(body, sSex, ['/']);
  if sChrName <> '' then begin
    SendDBServerMsgToServer(SS_CREATENEWCHR, sWaitID + '/' + sChrName + '/' + sHair + '/' + sJob + '/' + sSex + '/');
  end;
end;
{$IFEND}

{$IF RUNVAR = VAR_SQL}
procedure TFrmMasSoc.CreateNewChr(body: string);
var
  sWaitID, sChrName, sHair, sJob, sSex: string;
begin
  body := GetValidStr3(body, sWaitID, ['/']);
  body := GetValidStr3(body, sHair, ['/']);
  body := GetValidStr3(body, sJob, ['/']);
  sChrName := GetValidStr3(body, sSex, ['/']);
  if sChrName <> '' then begin
    FrmSqlSock.SendNewChr(StrToIntDef(sWaitID, 0), StrToIntDef(sHair, 0), StrToIntDef(sJob, 0), StrToIntDef(sSex, 0), sChrName);
  end;
 { body := GetValidStrEx(body, sChrName, ['/']);
  if sChrName <> '' then begin
    New(ServerNewChr);
    ServerNewChr.sChrName := sChrName;
    ServerNewChr.sAppendStr := body;
    New(ServerSqlMsg);
    ServerSqlMsg.ServerMsgType := st_CreateNewChr;
    ServerSqlMsg.ServerMsgPointer := ServerNewChr;
    SQLThread.Lock;
    try
      SQLThread.m_MsgList.Add(ServerSqlMsg);
    finally
      SQLThread.UnLock;
    end;
  end;  }
end;
{$IFEND}

{$IF RUNVAR = VAR_DB}
procedure TFrmMasSoc.GetLargessGold(body: string);
var
  sWaitID, sDBIndex, sCmd, sSendMsg: string;
begin
  body := GetValidStr3(body, sWaitID, ['/']);
  body := GetValidStr3(body, sDBIndex, ['/']);
  sSendMsg := GetValidStr3(body, sCmd, ['/']);
  if sSendMsg <> '' then begin
    FrmMasSoc.SendServerMsgToServer(SS_M2SERVERBACK, sWaitID + '/' + sDBIndex + '/' + sCmd + '/0');
  end;
end;
{$IFEND}

{$IF RUNVAR = VAR_SQL}
procedure TFrmMasSoc.GetLargessGold(body: string);
var
  sWaitID, sDBIndex, sCmd, sSendMsg: string;
begin
  body := GetValidStr3(body, sWaitID, ['/']);
  body := GetValidStr3(body, sDBIndex, ['/']);
  sSendMsg := GetValidStr3(body, sCmd, ['/']);
  if sSendMsg <> '' then begin
    FrmSqlSock.SendGetLargessGold(StrToIntDef(sWaitID, 0), StrToIntDef(sDBIndex, 0), StrToIntDef(sCmd, 0), sSendMsg);
  end;
end;
{$IFEND}

{$IF RUNVAR = VAR_DB}
procedure TFrmMasSoc.CreateNewGuild(body: string);
var
  sWaitID, sDBIndex, sCmd, sGuildName: string;
begin
  body := GetValidStr3(body, sWaitID, ['/']);
  body := GetValidStr3(body, sDBIndex, ['/']);
  sGuildName := GetValidStr3(body, sCmd, ['/']);
  if sGuildName <> '' then begin
    FrmMasSoc.SendServerMsgToServer(SS_M2SERVERBACK, sWaitID + '/' + sDBIndex + '/' + sCmd + '/' + sGuildName);
  end;
end;
{$IFEND}

{$IF RUNVAR = VAR_SQL}
procedure TFrmMasSoc.CreateNewGuild(body: string);
var
  sWaitID, sDBIndex, sCmd, sGuildName: string;
begin
  body := GetValidStr3(body, sWaitID, ['/']);
  body := GetValidStr3(body, sDBIndex, ['/']);
  sGuildName := GetValidStr3(body, sCmd, ['/']);
  if sGuildName <> '' then begin
    FrmSqlSock.SendNewGuild(StrToIntDef(sWaitID, 0), StrToIntDef(sDBIndex, 0), StrToIntDef(sCmd, 0), sGuildName);
  end;
 { body := GetValidStrEx(body, sChrName, ['/']);
  if sChrName <> '' then begin
    New(ServerNewGuild);
    ServerNewGuild.sGuildName := sChrName;
    ServerNewGuild.sAppendStr := body;
    New(ServerSqlMsg);
    ServerSqlMsg.ServerMsgType := st_CreateNewGuild;
    ServerSqlMsg.ServerMsgPointer := ServerNewGuild;
    SQLThread.Lock;
    try
      SQLThread.m_MsgList.Add(ServerSqlMsg);
    finally
      SQLThread.UnLock;
    end;
  end;   }
end;
{$IFEND}

{$IF RUNVAR = VAR_DB}
procedure TFrmMasSoc.GetGoldChangeMsg(body: string);
var
  sWaitID, sDBIndex, sCmd, sData: string;
begin
  body := GetValidStr3(body, sWaitID, ['/']);
  body := GetValidStr3(body, sDBIndex, ['/']);
  sData := GetValidStr3(body, sCmd, ['/']);
  if sData <> '' then begin
    FrmMasSoc.SendServerMsgToServer(SS_M2SERVERBACK, sWaitID + '/' + sDBIndex + '/' + sCmd + '/-4/0');
    //FrmSqlSock.SendGameGoldChange(StrToIntDef(sWaitID, 0), StrToIntDef(sDBIndex, 0), StrToIntDef(sCmd, 0), sData);
  end;
end;
{$IFEND}

{$IF RUNVAR = VAR_SQL}
procedure TFrmMasSoc.GetGoldChangeMsg(body: string);
var
  sWaitID, sDBIndex, sCmd, sData: string;
begin
  body := GetValidStr3(body, sWaitID, ['/']);
  body := GetValidStr3(body, sDBIndex, ['/']);
  sData := GetValidStr3(body, sCmd, ['/']);
  if sData <> '' then begin
    FrmSqlSock.SendGameGoldChange(StrToIntDef(sWaitID, 0), StrToIntDef(sDBIndex, 0), StrToIntDef(sCmd, 0), sData);
  end;
{  body := GetValidStrEx(body, sAccountID, ['/']);
  body := GetValidStrEx(body, sAccount, ['/']);
  body := GetValidStrEx(body, sChrName, ['/']);
  body := GetValidStrEx(body, sLogIndex, ['/']);
  body := GetValidStrEx(body, sServerName, ['/']);
  body := GetValidStrEx(body, sGoldCount, ['/']);
  body := GetValidStrEx(body, sAdd, ['/']);
  nGoldCount := StrToIntDef(sGoldCount, -1);
  nAccountID := StrToIntDef(sAccountID, -1);
  nLogIndex := StrToIntDef(sLogIndex, -1);
  if sAdd = '0' then boAdd := False
  else boAdd := True;
  if (nAccountID > 0) and (nGoldCount > 0) and (nLogIndex > 0) then begin
    New(ServerGoldMsg);
    ServerGoldMsg.nAccountID := nAccountID;
    ServerGoldMsg.sAccount := sAccount;
    ServerGoldMsg.sChrName := sChrName;
    ServerGoldMsg.nLogIndex := nLogIndex;
    ServerGoldMsg.sServerName := sServerName;
    ServerGoldMsg.nGoldCount := nGoldCount;
    ServerGoldMsg.boAdd := boAdd;
    ServerGoldMsg.sAppendStr := body;
    New(ServerSqlMsg);
    ServerSqlMsg.ServerMsgType := st_GoldChange;
    ServerSqlMsg.ServerMsgPointer := ServerGoldMsg;
    SQLThread.Lock;
    try
      SQLThread.m_MsgList.Add(ServerSqlMsg);
    finally
      SQLThread.UnLock;
    end;
  end;     }

end;
{$IFEND}


function TFrmMasSoc.GetOnlineHumCount(): Integer;
var
  I, nCount: Integer;
  MsgServer: pTMsgServerInfo;
begin
  Result := 0;
  try
    m_ServersList.Lock;
    Try
      nCount := 0;
      for I := 0 to m_ServersList.Count - 1 do begin
        MsgServer := m_ServersList.Items[I];
        if MsgServer.nServerIndex = 0 then
          {nCount += nOnlineCount}
          Inc(nCount, MsgServer.nOnlineCount);
      end;
      Result := nCount;
    Finally
      m_ServersList.UnLock;
    End;

  except
    MainOutMessage('TFrmMasSoc.GetOnlineHumCount');
  end;
end;
         {
function TFrmMasSoc.CheckReadyServers: Boolean;
var
  Config: pTConfig;
begin
  Config := @g_Config;
  Result := False;
  if m_ServersList.Count >= Config.nReadyServers then
    Result := true;
end;         }

procedure TFrmMasSoc.SendServerMsgA(wIdent: Word; sMsg: string);
var
  I: Integer;
  sSendMsg: string;
  MsgServer: pTMsgServerInfo;
resourcestring
  sFormatMsg = '(%d/%s/%s)';
begin
  try
    m_ServersList.Lock;
    Try
      sSendMsg := format(sFormatMsg, [wIdent, sMsg, '游戏中心']);
      for I := 0 to m_ServersList.Count - 1 do begin
        MsgServer := pTMsgServerInfo(m_ServersList.Items[I]);
        SendSocket(MsgServer, sSendMsg);
        {if MsgServer.Socket.Connected then
          MsgServer.Socket.SendText(sSendMsg);  }
      end;
    Finally
      m_ServersList.UnLock;
    End;
  except
    on e: Exception do begin
      MainOutMessage('TFrmMasSoc.SendServerMsgA');
      MainOutMessage(e.Message);
    end;
  end;
end;
procedure TFrmMasSoc.SendServerMsgToServer(wIdent: Word; sMsg: string);
var
  I: Integer;
  MsgServer: pTMsgServerInfo;
  sSendMsg: string;
resourcestring
  sFormatMsg = '(%d/%s)';
begin
  try
    m_ServersList.Lock;
    Try
      sSendMsg := format(sFormatMsg, [wIdent, sMsg]);
      for I := 0 to m_ServersList.Count - 1 do begin
        MsgServer := pTMsgServerInfo(m_ServersList.Items[I]);
        if {MsgServer.Socket.Connected and }(MsgServer.nServerIndex = 0){M2Server} then begin
          SendSocket(MsgServer, sSendMsg);
          //MsgServer.Socket.SendText(sSendMsg);
        end;
      end;
    Finally
      m_ServersList.UnLock;
    End;
  except
    MainOutMessage('TFrmMasSoc.SendServerMsgToServer');
  end;
end;

{
function TFrmMasSoc.LimitName(sServerName: string): string;
var
  I: Integer;
begin
  try
    Result := '';
    for I := Low(UserLimit) to High(UserLimit) do begin
      if CompareText(UserLimit[I].sServerName, sServerName) = 0 then begin
        Result := UserLimit[I].sName;
        break;
      end;
    end;
  except
    MainOutMessage('TFrmMasSoc.LimitName');
  end;
end;   }

procedure TFrmMasSoc.LoadUserLimit();
var
  LoadList: TStringList;
  sFileName: string;
  I: Integer;
  sLineText, sServerName, s10, s14: string;
begin
  sFileName := sUserLimitFileNmae;
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      sLineText := GetValidStr3(sLineText, sServerName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, s10, [' ', #9]);
      sLineText := GetValidStr3(sLineText, s14, [' ', #9]);
      if sServerName <> '' then begin
        UserLimit.sServerName := sServerName;
        UserLimit.sName := s10;
        UserLimit.nLimitCountMax := StrToIntDef(s14, 3000);
        UserLimit.nLimitCountMin := 0;
      end;
      break;
    end;
    //nUserLimit := nC;
    LoadList.Free;
  end
  else
    ShowMessage('[Critical Failure] file not found. ' + sUserLimitFileNmae);
end;
{
function TFrmMasSoc.ServerStatus(sServerName: string): Integer;
var
  I: Integer;
  nStatus: Integer;
  MsgServer: pTMsgServerInfo;
  boServerOnLine: Boolean;
begin
  Result := 0;
  try
    boServerOnLine := False;
    for I := 0 to m_ServerList.Count - 1 do begin
      MsgServer := m_ServerList.Items[I];
      if (MsgServer.nServerIndex <> 99) and (MsgServer.sServerName = sServerName)
        then begin
        boServerOnLine := true;
      end;
    end;
    if not boServerOnLine then
      Exit;
    nStatus := 1; //空闲
    for I := Low(UserLimit) to High(UserLimit) do begin
      if UserLimit[I].sServerName = sServerName then begin
        if UserLimit[I].nLimitCountMin <= UserLimit[I].nLimitCountMax div 2 then
          begin
          nStatus := 1; //空闲
          break;
        end;

        if UserLimit[I].nLimitCountMin <= UserLimit[I].nLimitCountMax -
          (UserLimit[I].nLimitCountMax div 5) then begin
          nStatus := 2; //良好
          break;
        end;
        if UserLimit[I].nLimitCountMin < UserLimit[I].nLimitCountMax then begin
          nStatus := 3; //繁忙
          break;
        end;
        if UserLimit[I].nLimitCountMin >= UserLimit[I].nLimitCountMax then begin
          nStatus := 4; //满员
          break;
        end;
      end;
    end;
    Result := nStatus;
  except
    MainOutMessage('TFrmMasSoc.ServerStatus');
  end;
end;  }

end.

