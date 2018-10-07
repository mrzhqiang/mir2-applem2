unit SqlSock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JSocket, ExtCtrls, LSShare, EDCode, Grobal2;

type
  TFrmSqlSock = class(TForm)
    Timer1: TTimer;
    SqlSocket: TClientSocket;
    procedure FormCreate(Sender: TObject);
    procedure SqlSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure SqlSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure SqlSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure SqlSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Timer1Timer(Sender: TObject);
  private
    m_ConnTick: LongWord;
    m_boConn: Boolean;
    m_SendStr: string;
    m_ReadStr: string;
    m_boSendKeepAlive: Boolean;
    m_dwKeepAliveTick: LongWord;
    procedure SendKeepAlive();
    procedure SendSocket(sSendMsg: string);
    procedure ProcessUserMsg(sMsg: string);
    procedure UserLogin(GateIndex: Integer; UserInfo: LSShare.pTUserInfo; Msg: pTDefaultMessage; sData: string);
    procedure KickUser(sData: string);
  public
    procedure SendUserLogin(WaitID: Integer; sSendMsg: string);
    procedure SendNewChr(WaitID, nHair, nJob, nSex: Integer; sSendMsg: string);
    procedure SendNewGuild(WaitID, nDBIndex, nCMD: Integer; sSendMsg: string);
    procedure SendGetLargessGold(WaitID, nDBIndex, nCMD: Integer; sSendMsg: string);
    procedure SendGameGoldChange(WaitID, nDBIndex, nCMD: Integer; sSendMsg: string);
  end;

var
  FrmSqlSock: TFrmSqlSock;

implementation
uses
  Common, Hutil32, MasSock, LMain;

{$R *.dfm}

procedure TFrmSqlSock.FormCreate(Sender: TObject);
var
  Config: pTConfig;
begin
  Config := @g_Config;
  SqlSocket.Host := Config.sSQLAddr;
  SqlSocket.Port := Config.nSQLPort;
  //SqlSocket.Active := true;
{$IF RUNVAR = VAR_SQL}
  Timer1.Enabled := True;
{$IFEND}
  m_ConnTick := GetTickCount + 5000;
  m_boConn := False;
  m_SendStr := '';
  m_ReadStr := '';
  m_boSendKeepAlive := False;
  m_dwKeepAliveTick := GetTickCount;
end;

procedure TFrmSqlSock.KickUser(sData: string);
begin
  SessionKick(@g_Config, DecodeString(sData));
end;

procedure TFrmSqlSock.ProcessUserMsg(sMsg: string);
  function GetUserInfo(nWaitIndex: Integer; out GateIndex: Integer): LSShare.pTUserInfo;
  var
    i, ii: integer;
    UserInfo: LSShare.pTUserInfo;
  begin
    Result := nil;
    for i := 0 to MAXGATELIST - 1 do begin
      GateIndex := I;
      if (g_Config.GateList[I].Socket <> nil) and (g_Config.GateList[I].UserList <> nil) then begin
        for II := 0 to g_Config.GateList[I].UserList.Count - 1 do begin
          UserInfo := g_Config.GateList[I].UserList.Items[II];
          if (UserInfo <> nil) and UserInfo.boWaitMsg and (UserInfo.nWaitMsgID = nWaitIndex) then begin
            UserInfo.boWaitMsg := False;
            UserInfo.nWaitMsgID := 0;
            Result := UserInfo;
            exit;
          end;
        end;
      end;
    end;
  end;
var
  sDefMsg: string;
  sData: string;
  DefMsg: TDefaultMessage;
  UserInfo: LSShare.pTUserInfo;
  GateIndex: Integer;
begin
  sDefMsg := Copy(sMsg, 1, DEFBLOCKSIZE);
  sData := Copy(sMsg, DEFBLOCKSIZE + 1, length(sMsg) - DEFBLOCKSIZE);
  DefMsg := DecodeMessage(sDefMsg);
  case DefMsg.Ident of
    SQL_KEEPALIVE: begin
        m_boSendKeepAlive := False;
        m_dwKeepAliveTick := GetTickCount;
        //m_ConnTick := GetTickCount + 5000;
      end;
    SQL_SM_USERLOGIN_OK: begin
        UserInfo := GetUserInfo(DefMsg.Recog, GateIndex);
        if UserInfo <> nil then begin
          UserLogin(GateIndex, UserInfo, @DefMsg, sData);
        end;
      end;
    SQL_SM_USERLOGIN_FAIL: begin
        UserInfo := GetUserInfo(DefMsg.Recog, GateIndex);
        if UserInfo <> nil then begin
          UserInfo.sAccount := '';
          if DefMsg.Param = 2 then DefMsg := MakeDefaultMsg(SM_PASSWD_FAIL, -1, 0, 0, 0)
          else DefMsg := MakeDefaultMsg(SM_PASSWD_FAIL, -7, 0, 0, 0);
          SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
        end;
      end;
    SQL_SM_NEWCHR_OK: begin
        sData := DecodeString(sData);
        FrmMasSoc.SendDBServerMsgToServer(SS_CREATENEWCHR,
          IntToStr(DefMsg.Recog) + '/' + sData + '/' +
          IntToStr(DefMsg.Param) + '/' + IntToStr(DefMsg.tag) + '/' + IntToStr(DefMsg.Series) + '/');
      end;
    SQL_SM_NEWCHR_FAIL: begin
        FrmMasSoc.SendDBServerMsgToServer(SS_CREATENEWCHR, IntToStr(DefMsg.Recog) + '/');
      end;
    SQL_SM_NEWGUILD_OK: begin
        sData := DecodeString(sData);
        FrmMasSoc.SendServerMsgToServer(SS_M2SERVERBACK, IntToStr(DefMsg.Recog) + '/' +
          IntToStr(MakeLong(DefMsg.Param, DefMsg.tag)) + '/' + IntToStr(DefMsg.Series) + '/' + sData);
      end;
    SQL_SM_NEWGUILD_FAIL: begin
        FrmMasSoc.SendServerMsgToServer(SS_M2SERVERBACK, IntToStr(DefMsg.Recog) + '/' +
          IntToStr(MakeLong(DefMsg.Param, DefMsg.tag)) + '/' + IntToStr(DefMsg.Series) + '/');
      end;
    SQL_SM_GAMEGOLDCHANGE: begin
        FrmMasSoc.SendServerMsgToServer(SS_M2SERVERBACK, IntToStr(DefMsg.Recog) + '/' +
          IntToStr(MakeLong(DefMsg.Param, DefMsg.tag)) + '/' + IntToStr(DefMsg.Series) + '/' + DecodeString(sData));
      end;
    SQL_SM_GETLARGESSGOLD: begin
        FrmMasSoc.SendServerMsgToServer(SS_M2SERVERBACK, IntToStr(DefMsg.Recog) + '/' +
          IntToStr(MakeLong(DefMsg.Param, DefMsg.tag)) + '/' + IntToStr(DefMsg.Series) + '/' + DecodeString(sData));
      end;
    SQL_SM_KICKUSER: begin
        KickUser(sData);
      end;
    SQL_SM_GAMEGOLDCHANGE_EX: begin
        SessionGoldChange(@g_Config, DecodeString(sData), DefMsg.Recog);
      end;
  end;
end;

procedure TFrmSqlSock.SendGameGoldChange(WaitID, nDBIndex, nCMD: Integer; sSendMsg: string);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(SQL_CM_GAMEGOLDCHANGE { 10004 }, WaitID, LoWord(nDBIndex), HiWord(nDBIndex), nCMD);
  SendSocket(EncodeMessage(DefMsg) + EncodeString(sSendMsg));
end;

procedure TFrmSqlSock.SendKeepAlive;
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(SQL_KEEPALIVE { 1000 }, 0, 0, 0, 0);
  SendSocket(EncodeMessage(DefMsg) + EncodeString(UserLimit.sServerName + '/' + IntToStr(nOnlineCountMin)));
end;

procedure TFrmSqlSock.SendNewChr(WaitID, nHair, nJob, nSex: Integer; sSendMsg: string);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(SQL_CM_NEWCHR, WaitID, nHair, nJob, nSex);
  SendSocket(EncodeMessage(DefMsg) + EncodeString(sSendMsg));
end;

procedure TFrmSqlSock.SendGetLargessGold(WaitID, nDBIndex, nCMD: Integer; sSendMsg: string);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(SQL_CM_GETLARGESSGOLD, WaitID, LoWord(nDBIndex), HiWord(nDBIndex), nCMD);
  SendSocket(EncodeMessage(DefMsg) + EncodeString(sSendMsg));
end;

procedure TFrmSqlSock.SendNewGuild(WaitID, nDBIndex, nCMD: Integer; sSendMsg: string);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(SQL_CM_NEWGUILD, WaitID, LoWord(nDBIndex), HiWord(nDBIndex), nCMD);
  SendSocket(EncodeMessage(DefMsg) + EncodeString(sSendMsg));
end;

procedure TFrmSqlSock.SendSocket(sSendMsg: string);
begin
  if SqlSocket.Socket.Connected then begin
    if m_SendStr <> '' then begin
      m_SendStr := m_SendStr + g_CodeHead + sSendMsg + g_CodeEnd;
    end
    else if SqlSocket.Socket.SendText(g_CodeHead + sSendMsg + g_CodeEnd) = -1 then begin
      m_SendStr := g_CodeHead + sSendMsg + g_CodeEnd;
    end;
  end;
end;

procedure TFrmSqlSock.SendUserLogin(WaitID: Integer; sSendMsg: string);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(SQL_CM_USERLOGIN, WaitID, 0, 0, 0);
  SendSocket(EncodeMessage(DefMsg) + EncodeString(sSendMsg));
end;

procedure TFrmSqlSock.SqlSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  m_SendStr := '';
  m_ReadStr := '';
  if not m_boConn then
    MainOutMessage('连接SQL服务器成功...');
  m_boConn := True;
  m_boSendKeepAlive := False;
  m_dwKeepAliveTick := GetTickCount;
end;

procedure TFrmSqlSock.SqlSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  m_SendStr := '';
  m_ReadStr := '';
  if m_boConn then
    MainOutMessage('与SQL服务器断开连接...');
  m_boConn := False;
end;

procedure TFrmSqlSock.SqlSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmSqlSock.SqlSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  sData: string;
begin
  m_ReadStr := m_ReadStr + Socket.ReceiveText;
  while (m_ReadStr <> '') do begin
    if Pos(g_CodeEnd, m_ReadStr) > 0 then begin
      m_ReadStr := ArrestStringEx(m_ReadStr, g_CodeHead, g_CodeEnd, sData);
      if Length(sData) >= DEFBLOCKSIZE then begin
        ProcessUserMsg(sData);
      end;
    end
    else
      break;
  end;
end;

procedure TFrmSqlSock.Timer1Timer(Sender: TObject);
const
  boRun: Boolean = False;
  MAXSENDCOUNT = 8192;
var
  nLen: Integer;
  sData: string;
begin
  if boRun then
    exit;
  boRun := True;
  try
    if m_boConn and ((GetTickCount - m_dwKeepAliveTick) > 60000) then begin
      SqlSocket.Socket.Close;
      Exit;
    end;
    if m_boConn and SqlSocket.Socket.Connected then begin
      if not m_boSendKeepAlive then begin
        SendKeepAlive;
        m_boSendKeepAlive := True;
        m_dwKeepAliveTick := GetTickCount;
      end;
      if (m_SendStr <> '') then begin
        while (m_SendStr <> '') do begin
          nLen := Length(m_SendStr);
          if nLen > MAXSENDCOUNT then begin
            sData := Copy(m_SendStr, 1, MAXSENDCOUNT);
            if SqlSocket.Socket.SendText(sData) <> -1 then begin
              m_SendStr := Copy(m_SendStr, MAXSENDCOUNT + 1, nLen - MAXSENDCOUNT);
            end
            else
              break;
          end
          else begin
            if SqlSocket.Socket.SendText(m_SendStr) <> -1 then
              m_SendStr := '';
            break;
          end;
        end;
      end;
    end else begin
      m_boConn := False;
      if GetTickCount > m_ConnTick then begin
        m_ConnTick := GetTickCount + 5000;
        SqlSocket.Open;
      end;
    end;

    {if GetTickCount > m_ConnTick then begin
      m_ConnTick := GetTickCount + 5000;
      if not SqlSocket.Socket.Connected then begin
        SqlSocket.Open;
        Exit;
      end
      else if not m_boSendKeepAlive then begin
        SendKeepAlive;
        m_boSendKeepAlive := True;
        m_dwKeepAliveTick := GetTickCount;
      end;
    end;
    if SqlSocket.Socket.Connected then begin
      if m_boSendKeepAlive and ((GetTickCount - m_dwKeepAliveTick) > 60000) then begin
        SqlSocket.Socket.Close;
      end
      else if (m_SendStr <> '') then begin
        while (m_SendStr <> '') do begin
          nLen := Length(m_SendStr);
          if nLen > MAXSENDCOUNT then begin
            sData := Copy(m_SendStr, 1, MAXSENDCOUNT);
            if SqlSocket.Socket.SendText(sData) <> -1 then begin
              m_SendStr := Copy(m_SendStr, MAXSENDCOUNT + 1, nLen - MAXSENDCOUNT);
            end
            else
              break;
          end
          else begin
            if SqlSocket.Socket.SendText(m_SendStr) <> -1 then
              m_SendStr := '';
            break;
          end;
        end;
      end;
    end;     }
  finally
    boRun := False;
  end;
end;

procedure TFrmSqlSock.UserLogin(GateIndex: Integer; UserInfo: LSShare.pTUserInfo; Msg: pTDefaultMessage; sData: string);
var
  sLoginID, sUserID, sGameGold, sCheckEMail: string;
  nUserID, nGameGold: Integer;
  DefMsg: TDefaultMessage;
  sSelGateIP: string;
  nSelGatePort: Integer;
begin
  sData := GetValidStr3(DecodeString(sData), sLoginID, ['/']);
  sData := GetValidStr3(sData, sUserID, ['/']);
  sCheckEMail := GetValidStr3(sData, sGameGold, ['/']);
  nUserID := StrToIntDef(sUserID, 0);
  nGameGold := StrToIntDef(sGameGold, 0);
  if (nUserID > 0) and (sLoginID <> '') and (sLoginID = UserInfo.sAccount) then begin
    //处理密保卡
    UserInfo.nUserCDKey := nUserID;
    UserInfo.nGameGold := nGameGold;
    UserInfo.nCheckEMail := StrToIntDef(sCheckEMail, 0);
    if (Msg.Param <> 0) and (Msg.tag <> 0) and (Msg.Series <> 0) then begin
      UserInfo.boMatrixCardCheck := True;
      UserInfo.MatrixCard[0].CardNo := HiByte(Msg.Param);
      UserInfo.MatrixCard[1].CardNo := HiByte(Msg.tag);
      UserInfo.MatrixCard[2].CardNo := HiByte(Msg.Series);
      DefMsg := MakeDefaultMsg(SM_CHECKMATRIXCARD, 0, LoByte(Msg.Param), LoByte(Msg.tag), LoByte(Msg.Series));
      SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
      exit;
    end;
    if IsLogin(@g_Config, sLoginID) then begin
      UserInfo.sAccount := '';
      SessionKick(@g_Config, sLoginID); //踢除已登录用户
      DefMsg := MakeDefaultMsg(SM_PASSWD_FAIL, -3, 0, 0, 0);
      SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
      exit;
    end;
    UserInfo.sAccount := sLoginID;
    sSelGateIP := GetSelGateInfo(@g_Config, g_Config.sGateIPaddr, nSelGatePort);
    if (sSelGateIP <> '') and (nSelGatePort > 0) then begin
      if FrmMasSoc.IsNotUserFull() then begin
        UserInfo.boSelServer := True;
        UserInfo.nSessionID := SessionAdd(@g_Config, UserInfo.sAccount, UserInfo.sUserIPaddr, UserInfo.nUserCDKey,
          UserLimit.sServerName);

        FrmMasSoc.SendServerMsg(SS_OPENSESSION, UserLimit.sServerName,
            UserInfo.sAccount + '/' + IntToStr(UserInfo.nSessionID) + '/' +
            IntToStr(UserInfo.nUserCDKey) + '/' + IntToStr(UserInfo.nGameGold) + '/' + IntToStr(UserInfo.nCheckEMail) + '/' + UserInfo.sUserIPaddr);
        DefMsg := MakeDefaultMsg(SM_SELECTSERVER_OK, UserInfo.nSessionID, 0, 0, Integer(g_boCloseWuXin));
        SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex,
          EncodeMessage(DefMsg) + EncodeString(sSelGateIP + '/' + IntToStr(nSelGatePort) + '/' + IntToStr(UserInfo.nSessionID)));
      end else begin
        UserInfo.boSelServer := False;
        DefMsg := MakeDefaultMsg(SM_STARTFAIL, 0, 0, 0, 0);
        SendGateMsg(GateIndex, UserInfo.sArryIndex, UserInfo.sSockIndex, EncodeMessage(DefMsg));
      end;
    end;
  end;
end;

end.

