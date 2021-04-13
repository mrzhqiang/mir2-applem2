unit RunSock;

interface
uses
  Windows, Classes, SysUtils, StrUtils, SyncObjs, JSocket, ObjBase, ObjPlay, Grobal2,
  FrnEngn, UsrEngn, Common;
type
  TGateUserInfo = record
    sAccount: string;
    sCharName: string;
    sIPaddr: string;
    nSocket: Integer;
    nGSocketIdx: Integer;
    nSessionID: Integer;
    nClientVersion: Integer;
    UserEngine: TUserEngine;
    FrontEngine: TFrontEngine;
    PlayObject: TPlayObject;
    SessInfo: pTSessInfo;
    dwNewUserTick: LongWord;
    boCertification: Boolean;
  end;
  pTGateUserInfo = ^TGateUserInfo;

  TRunSocket = class
    m_RunSocketSection: TRTLCriticalSection;
    m_RunAddrList: TStringList;
    n8: Integer;
    m_IPaddrArr: array[0..19] of TIPaddr;
    n4F8: Integer;
    dwSendTestMsgTick: LongWord;
    m_nErrorCount: Integer;
  private
    procedure LoadRunAddr;
    procedure ExecGateBuffers(nGateIndex: Integer; Gate: pTGateInfo; Buffer: PChar; nMsgLen: Integer);
    procedure DoClientCertification(GateIdx: Integer; GateUser: pTGateUserInfo; nSocket: Integer; sMsg: string);
    procedure ExecGateMsg(GateIdx: Integer; Gate: pTGateInfo; MsgHeader: pTMsgHeader; MsgBuff: PChar; nMsgLen: Integer);
    procedure SendCheck(nIndex: Integer; nIdent: Integer);
    function OpenNewUser(nSocket: Integer; nGSocketIdx: Integer; sIPaddr: string; UserList: TList): Integer;
    procedure SendNewUserMsg(Socket: TCustomWinSocket; nSocket: Integer; nSocketIndex, nUserIdex: Integer);
    procedure SendGateTestMsg(nIndex: Integer);
    function SendGateBuffers(GateIdx: Integer; Gate: pTGateInfo; MsgList: TList): Boolean;
    function GetGateAddr(sIPaddr: string): string;
    {procedure SendScanMsg(DefMsg: pTDefaultMessage; sMsg: string; nGateIdx,
      nSocket, nGsIdx: Integer);     }
    //    procedure ProcessUserPacket(GateIdx: Integer; Gate: pTGateInfo);
  public
    constructor Create();
    destructor Destroy; override;
    procedure AddGate(Socket: TCustomWinSocket);
    procedure SocketRead(Socket: TCustomWinSocket);
    procedure CloseGate(Socket: TCustomWinSocket);
    procedure CloseErrGate(Socket: TCustomWinSocket; var ErrorCode: Integer);
    procedure CloseAllGate();
    procedure Run();
    procedure Execute;
    procedure CloseUser(GateIdx, nSocket: Integer);
    function AddGateBuffer(GateIdx: Integer; Buffer: PChar): Boolean;
    procedure SendOutConnectMsg(nGateIdx, nSocket, nGsIdx: Integer);
    procedure SetGateUserList(nGateIdx, nSocket: Integer; PlayObject: TPlayObject);
    procedure KickUser(sAccount: string; nSessionID: Integer);
  end;
var
  g_GateArr: array[0..15] of TGateInfo;
  g_nGateRecvMsgLenMin: Integer;
  g_nGateRecvMsgLenMax: Integer;
implementation

uses M2Share, IdSrvClient, HUtil32, EDcodeEx{$IFDEF PLUGOPEN}, PlugOfEngine{$ENDIF}, DES, RegDllFile;
var
  nRunSocketRun: Integer = -1;
  nExecGateBuffers: Integer = -1;
  { TRunSocket }

procedure TRunSocket.AddGate(Socket: TCustomWinSocket);
var
  i: Integer;
  sIPaddr: string;
  Gate: pTGateInfo;
resourcestring
  sGateOpen = '游戏网关[%d](%s:%d)已打开...';
  sKickGate = '服务器未就绪: %s';
begin
  Socket.nIndex := 0;
  sIPaddr := Socket.RemoteAddress;
  if boStartReady then begin
    EnterCriticalSection(m_RunSocketSection);
    Try
      for i := Low(g_GateArr) to High(g_GateArr) do begin
        Gate := @g_GateArr[i];
        if Gate.boUsed then Continue;
        Gate.boUsed := True;
        Gate.GateIndex := I;
        Gate.Socket := Socket;
        Gate.sAddr := GetGateAddr(sIPaddr);
        Gate.nPort := Socket.RemotePort;
        Gate.n520 := 1;
        Gate.UserList := TList.Create;
        Gate.nUserCount := 0;
        Gate.Buffer := nil;
        Gate.nBuffLen := 0;
        Gate.BufferList := TList.Create;
        Gate.boSendKeepAlive := False;
        Gate.dwSendKeepTick := GetTickCount;
        Gate.nSendChecked := 0;
        Gate.nSendBlockCount := 0;
        Gate.dwTime544 := GetTickCount;
        MainOutMessage(format(sGateOpen, [i, Socket.RemoteAddress, Socket.RemotePort]));
        Socket.nIndex := Integer(Gate);
        break;
      end;
    Finally
      LeaveCriticalSection(m_RunSocketSection);
    End;
  end
  else begin
    MainOutMessage(format(sKickGate, [sIPaddr]));
    Socket.Close;
  end;
end;

procedure TRunSocket.CloseAllGate;
var
  GateIdx: Integer;
  Gate: pTGateInfo;
begin
  for GateIdx := Low(g_GateArr) to High(g_GateArr) do begin
    Gate := @g_GateArr[GateIdx];
    if Gate.Socket <> nil then begin
      Gate.Socket.Close;
    end;
  end;
end;

procedure TRunSocket.CloseErrGate(Socket: TCustomWinSocket;
  var ErrorCode: Integer);
begin
  if Socket.Connected then
    Socket.Close;
  ErrorCode := 0;
end;

procedure TRunSocket.CloseGate(Socket: TCustomWinSocket);
var
  i, GateIdx: Integer;
  GateUser: pTGateUserInfo;
  UserList: TList;
  Gate: pTGateInfo;
resourcestring
  sGateClose = '游戏网关[%d](%s:%d)已关闭...';
begin
  if Socket = nil then Exit;
  EnterCriticalSection(m_RunSocketSection);
  try
    for GateIdx := Low(g_GateArr) to High(g_GateArr) do begin
      Gate := @g_GateArr[GateIdx];
      if Gate.Socket = Socket then begin
        UserList := Gate.UserList;
        if UserList <> nil then begin
          for i := 0 to UserList.Count - 1 do begin
            GateUser := UserList.Items[i];
            if GateUser <> nil then begin
              if GateUser.PlayObject <> nil then begin
                TPlayObject(GateUser.PlayObject).m_boEmergencyClose := True;
                TPlayObject(GateUser.PlayObject).m_boPlayOffLine := False;
                if not TPlayObject(GateUser.PlayObject).m_boReconnection then begin
                  FrmIDSoc.SendHumanLogOutmsg(GateUser.sAccount, GateUser.nSessionID);
                end;
              end;
              Dispose(GateUser);
              UserList.Items[i] := nil;
            end;
          end;
          Gate.UserList.Free;
          Gate.UserList := nil;
        end;
        if Gate.Buffer <> nil then
          FreeMem(Gate.Buffer);
        Gate.Buffer := nil;
        Gate.nBuffLen := 0;
        if Gate.BufferList <> nil then begin
          for i := 0 to Gate.BufferList.Count - 1 do begin
            FreeMem(Gate.BufferList.Items[i]);
          end;
          Gate.BufferList.Free;
          Gate.BufferList := nil;
        end;
        Gate.boUsed := False;
        Gate.Socket := nil;
        Socket.nIndex := 0;
        MainOutMessage(format(sGateClose, [GateIdx, Socket.RemoteAddress, Socket.RemotePort]));
        break;
      end;
    end;
  finally
    LeaveCriticalSection(m_RunSocketSection);
  end;
end;

procedure TRunSocket.ExecGateBuffers(nGateIndex: Integer; Gate: pTGateInfo; Buffer: PChar; nMsgLen: Integer);
var
  nLen: Integer;
  Buff: PChar;
  MsgBuff: PChar;
  MsgHeader: pTMsgHeader; {Size 20}
  nCheckMsgLen: Integer;
  TempBuff: PChar;
resourcestring
  sExceptionMsg1 = '[Exception] TRunSocket::ExecGateBuffers -> pBuffer';
  sExceptionMsg2 =
    '[Exception] TRunSocket::ExecGateBuffers -> @pwork,ExecGateMsg ';
  sExceptionMsg3 = '[Exception] TRunSocket::ExecGateBuffers -> FreeMem';
begin
  //nLen := 0;
  //Buff := nil;
  try
    if Buffer <> nil then begin
      ReallocMem(Gate.Buffer, Gate.nBuffLen + nMsgLen);
      Move(Buffer^, Gate.Buffer[Gate.nBuffLen], nMsgLen);
    end;
  except
    MainOutMessage(sExceptionMsg1);
  end;
  try
    nLen := Gate.nBuffLen + nMsgLen;
    Gate.nBuffLen := nLen;
    Buff := Gate.Buffer;
    if nLen >= SizeOf(TMsgHeader) then begin
      while (True) do begin
        {
        pMsg:=pTMsgHeader(Buff);
        if pMsg.dwCode = RUNGATECODE then begin
          if nLen < (pMsg.nLength + SizeOf(TMsgHeader)) then break;
          MsgBuff:=@Buff[SizeOf(TMsgHeader)];
        }
        MsgHeader := pTMsgHeader(Buff);
        nCheckMsgLen := abs(MsgHeader.nLength) + SizeOf(TMsgHeader);
        if (MsgHeader.dwCode = RUNGATECODE) and (nCheckMsgLen < $8000) then begin
          if nLen < nCheckMsgLen then
            break;
          MsgBuff := Buff + SizeOf(TMsgHeader); //Jacky 1009 换上
          //MsgBuff:=@Buff[SizeOf(TMsgHeader)];
          ExecGateMsg(nGateIndex, Gate, MsgHeader, MsgBuff, MsgHeader.nLength);
          Buff := Buff + SizeOf(TMsgHeader) + MsgHeader.nLength;
            //Jacky 1009 换上
          //Buff:=@Buff[SizeOf(TMsgHeader) + pMsg.nLength];
          nLen := nLen - (MsgHeader.nLength + SizeOf(TMsgHeader));
        end
        else begin
          Inc(Buff);
          Dec(nLen);
        end;
        if nLen < SizeOf(TMsgHeader) then
          break;
      end;
      try
        if nLen > 0 then begin
          if nLen = Gate.nBuffLen then exit;
          GetMem(TempBuff, nLen);
          Move(Buff^, TempBuff^, nLen);
          FreeMem(Gate.Buffer);
          Gate.Buffer := TempBuff;
          Gate.nBuffLen := nLen;
        end
        else begin
          FreeMem(Gate.Buffer);
          Gate.Buffer := nil;
          Gate.nBuffLen := 0;
        end;
      except
        MainOutMessage(sExceptionMsg3);
      end;
    end;
  except
    MainOutMessage(sExceptionMsg2);
  end;

end;

procedure TRunSocket.SocketRead(Socket: TCustomWinSocket);
var
  nMsgLen{, GateIdx}: Integer;
  Gate: pTGateInfo;
{$IF SOCKETTYPE = 0}
  RecvBuffer: array[0..DATA_BUFSIZE * 2 - 1] of Char;
{$ELSEIF SOCKETTYPE = 1}
  RecvBuffer: PChar;
{$IFEND}
  //  nLoopCheck: Integer;
resourcestring
  sExceptionMsg1 = '[Exception] TRunSocket::SocketRead';
begin
  if Socket.nIndex = 0 then exit;

  //for GateIdx := Low(g_GateArr) to High(g_GateArr) do begin
  //Gate := @g_GateArr[GateIdx];
  Gate := pTGateInfo(Socket.nIndex);
  if Gate.Socket = Socket then begin
    RecvBuffer := nil;
    try
{$IF SOCKETTYPE = 0}
      while (True) do begin
        nMsgLen := Socket.ReceiveBuf(RecvBuffer, SizeOf(RecvBuffer));
        if nMsgLen <= 0 then
          break;
        ExecGateBuffers(GateIdx, Gate, @RecvBuffer, nMsgLen);
      end;
{$ELSEIF SOCKETTYPE = 1}
      nMsgLen := Socket.ReceiveLength;
      GetMem(RecvBuffer, nMsgLen);
      nMsgLen := Socket.ReceiveBuf(RecvBuffer^, nMsgLen);
      ExecGateBuffers(Gate.GateIndex, Gate, RecvBuffer, nMsgLen);
      FreeMem(RecvBuffer);
{$IFEND}
      //break;
    except
{$IF SOCKETTYPE = 1}
      if RecvBuffer <> nil then begin
        FreeMem(RecvBuffer);
      end;
{$IFEND}
      MainOutMessage(sExceptionMsg1);
    end;
  end;
  //end;
end;

{procedure TRunSocket.ProcessUserPacket(GateIdx: Integer; Gate: pTGateInfo);
begin

end;     }

// 发送数据、统计信息、检测状态
procedure TRunSocket.Run;
var
  dwRunTick: LongWord;
  i, {ii,} nG: Integer;
  Gate: pTGateInfo;
  nCode: Integer;
  //  GateUser: pTGateUserInfo;
resourcestring
  sExceptionMsg = '[Exception] TRunSocket::Run nCode = ';
begin
  dwRunTick := GetTickCount();
  nCode := -1;
  if boStartReady then begin
    try
      EnterCriticalSection(m_RunSocketSection);
      try
        nCode := 2;
        // default: GateLoad == 0
        if g_Config.nGateLoad > 0 then begin
          if (GetTickCount - dwSendTestMsgTick) >= 100 then begin
            dwSendTestMsgTick := GetTickCount();
            for i := Low(g_GateArr) to High(g_GateArr) do begin
              Gate := @g_GateArr[i];
              if Gate.boUsed and (Gate.BufferList <> nil) then begin
                for nG := 0 to g_Config.nGateLoad - 1 do begin
                  SendGateTestMsg(i);
                end;
              end;
            end;
          end;
        end;
        nCode := 3;
        for i := Low(g_GateArr) to High(g_GateArr) do begin
          Gate := @g_GateArr[i];
          nCode := 4;
          if Gate.boUsed and (Gate.BufferList <> nil) and (Gate.Socket <> nil) then begin
            nCode := 5;
            Gate.nSendMsgCount := Gate.BufferList.Count;
            if SendGateBuffers(i, Gate, Gate.BufferList) then begin
              Gate.nSendRemainCount := Gate.BufferList.Count;
            end
            else begin
              Gate.nSendRemainCount := Gate.BufferList.Count;
            end;
          end;
        end;
        nCode := 6;
        for i := Low(g_GateArr) to High(g_GateArr) do begin
          if g_GateArr[i].Socket <> nil then begin
            nCode := 7;
            Gate := @g_GateArr[i];
            if Gate.boUsed then begin
              nCode := 8;
              // 发送超时，断开套接字
              if (GetTickCount - Gate.dwSendKeepTick) >= 60 * 1000 then begin
                Gate.Socket.Close;
                CloseGate(Gate.Socket);
                Continue;
              end;
              nCode := 9;
              // 每秒数据传输统计
              if (GetTickCount - Gate.dwSendTick) >= 1000 then begin
                Gate.dwSendTick := GetTickCount();
                Gate.nSendMsgBytes := Gate.nSendBytesCount;
                Gate.nSendedMsgCount := Gate.nSendCount;
                Gate.nSendBytesCount := 0;
                Gate.nSendCount := 0;
              end;
              nCode := 10;
              if Gate.boSendKeepAlive then begin
                Gate.boSendKeepAlive := False;
                SendCheck(i, GM_CHECKSERVER);
              end;
              nCode := 11;
            end;
          end;
        end;
      finally
        LeaveCriticalSection(m_RunSocketSection);
      end;
    except
      on E: Exception do begin
        MainOutMessage(sExceptionMsg + IntToStr(nCode));
        MainOutMessage(E.Message);
      end;
    end;
  end;
  g_nSockCountMin := GetTickCount - dwRunTick;
  if g_nSockCountMin > g_nSockCountMax then
    g_nSockCountMax := g_nSockCountMin;
end;

procedure TRunSocket.DoClientCertification(GateIdx: Integer; GateUser: pTGateUserInfo; nSocket: Integer; sMsg: string);

  function GetCertification(sMsg: string; var sAccount: string; var sChrName:
    string; var nSessionID: Integer; var nClientVersion: Integer; var boFlag:
    Boolean): Boolean; //004E0DE0
  var
    sData: string;
    sCodeStr, sClientVersion: string;
    sIdx: string;
{$IF (Public_Ver = Public_Release) and (Var_Free <> 1)}
    I: Integer;
    sENName: string;
    sName: string;
    ChrBuffer: array[0..100] of Char;
{$IFEND}
  resourcestring
    sExceptionMsg =
      '[Exception] TRunSocket::DoClientCertification -> GetCertification';
  begin
    Result := False;
    try
      sData := DeCodeString(sMsg);
      if (Length(sData) > 2) and (sData[1] = '*') and (sData[2] = '*') then begin
        sData := Copy(sData, 3, Length(sData) - 2);
        sData := GetValidStr3(sData, sAccount, ['/']);
        sData := GetValidStr3(sData, sChrName, ['/']);
        sData := GetValidStr3(sData, sCodeStr, ['/']);
        sData := GetValidStr3(sData, sClientVersion, ['/']);
        nClientVersion := StrToIntDef(sClientVersion, 0);

{$IF (Public_Ver = Public_Release) and (Var_Free <> 1)}
        sData := GetValidStr3(sData, sENName, ['/']);
        sName := sChrName;
        sChrName := '';
        if sENName <> '' then begin
          for I := 0 to g_DESPassword.Count - 1 do begin
            Try
              sChrName := DecryStrHex(sENName, g_DESPassword[I]);
              if sChrName = sName then Break;
            Except
              sChrName := '';
            End;
          end;
        end;
        if sChrName <> sName then begin
          sChrName := '';
          if (nClientVersion and CLIENT_VERSION_MARK) = 506 then begin
            FillChar(ChrBuffer[0], SizeOf(ChrBuffer), #0);
            RegDll_GetText(PChar(sENName), @ChrBuffer[0], 100);
            if ChrBuffer = sName then
              sChrName := sName;
          end;
        end;
{$IFEND}
        sIdx := sData;
        nSessionID := StrToIntDef(sCodeStr, 0);
        if sIdx = '0' then begin
          boFlag := True;
        end
        else begin
          boFlag := False;
        end;
        if (sAccount <> '') and (sChrName <> '') and (nSessionID >= 2) then begin
          Result := True;
        end;
      end;
    except
      MainOutMessage(sExceptionMsg);
    end;
  end;
var
  nCheckCode: Integer;
  sData: string;
  sAccount, sChrName: string;
  nSessionID: Integer;
  boFlag: Boolean;
  nClientVersion: Integer;
  nGameGold: Integer;
  nIDIndex, nCheckEMail: Integer;
  SessInfo: pTSessInfo;
  PlayObject: TPlayObject;
//  i: Integer;
resourcestring
  sExceptionMsg = '[Exception] TRunSocket::DoClientCertification CheckCode: ';
  sDisable = '*disable*';
begin
  nCheckCode := 0;
  try
    if GateUser.sAccount = '' then begin
      if TagCount(sMsg, '!') > 0 then begin
        sData := ArrestStringEx(sMsg, '#', '!', sMsg);
        sMsg := Copy(sMsg, 2, Length(sMsg) - 1);
        if GetCertification(sMsg, sAccount, sChrName, nSessionID, nClientVersion, boFlag) then begin
          //if ScanCertification(sAccount, sChrName, nSessionID, nClientVersion) then exit;
          SessInfo := FrmIDSoc.GetAdmission(sAccount, GateUser.sIPaddr, nSessionID, nGameGold, nIDIndex, nCheckEMail);
          if (SessInfo <> nil) and (nIDIndex > 0) then begin
            PlayObject := UserEngine.GetOffLine(sChrName);
            if PlayObject = nil then begin
              GateUser.boCertification := True;
              GateUser.sAccount := Trim(sAccount);
              GateUser.sCharName := Trim(sChrName);
              GateUser.nSessionID := nSessionID;
              GateUser.nClientVersion := nClientVersion;
              GateUser.SessInfo := SessInfo;
              try
                FrontEngine.AddToLoadRcdList(sAccount,
                  sChrName,
                  GateUser.sIPaddr,
                  boFlag,
                  nSessionID,
                  nGameGold,
                  nIDIndex,
                  //nPayMent,
                  //nPayMode,
                  nClientVersion,
                  nSocket,
                  GateUser.nGSocketIdx,
                  GateIdx,
                  nCheckEMail);
              except
                MainOutMessage(format(sExceptionMsg, [nCheckCode]));
              end;
            end else
            if CompareText(PlayObject.m_sUserID, sAccount) = 0 then begin
              UserEngine.DelOffLineByName(sChrName);
              GateUser.boCertification := True;
              GateUser.sAccount := Trim(sAccount);
              GateUser.sCharName := Trim(sChrName);
              GateUser.nSessionID := nSessionID;
              GateUser.nClientVersion := nClientVersion;
              GateUser.SessInfo := SessInfo;
              GateUser.FrontEngine := nil;
              GateUser.UserEngine := UserEngine;
              GateUser.PlayObject := PlayObject;

              PlayObject.m_nIDIndex := nIDIndex;
              PlayObject.m_nGamePoint := nGameGold;
              PlayObject.m_nCheckEMail := nCheckEMail;
              PlayObject.m_sIPaddr := GateUser.sIPaddr;
              PlayObject.m_sIPLocal := GetIPLocal(GateUser.sIPaddr);
              PlayObject.m_nSocket := nSocket;
              PlayObject.m_nGSocketIdx := GateUser.nGSocketIdx;
              PlayObject.m_nGateIdx := GateIdx;
              PlayObject.m_nSessionID := nSessionID;
              PlayObject.m_boLoginNoticeOK := False;
              PlayObject.m_boSendNotice := False;
              PlayObject.m_boSafeOffLine := False;
              PlayObject.m_boOffLineLogin := True;
              //PlayObject.m_nSoftVersionDateEx := GetExVersionNO(nClientVersion, nClientVersion);

            end;
          end
          else begin
            nCheckCode := 2;
            GateUser.sAccount := sDisable;
            GateUser.boCertification := False;
            CloseUser(GateIdx, nSocket);
            nCheckCode := 3;
          end;
        end
        else begin
          nCheckCode := 4;
          GateUser.sAccount := sDisable;
          GateUser.boCertification := False;
          CloseUser(GateIdx, nSocket);
          nCheckCode := 5;
        end;
      end;
    end;
  except
    MainOutMessage(format(sExceptionMsg, [nCheckCode]));
  end;
end;

function TRunSocket.SendGateBuffers(GateIdx: Integer; Gate: pTGateInfo; MsgList: TList): Boolean;
var
  dwRunTick: LongWord;
  BufferA: PChar;
  BufferB: PChar;
  nBuffALen: Integer;
  SendBuffer: array[0..MAXSOCKETBUFFLEN - 1] of Byte;
  SendLength: Integer;
  Buffer: PChar;
  BufferLen: Integer;
resourcestring
  sExceptionMsg2 = '[Exception] TRunSocket::SendGateBuffers -> SendBuff';
begin
  Result := True;
  if MsgList.Count <= 0 then Exit;
  Try
    dwRunTick := GetTickCount();
    SendLength := 0;
    while (Gate.Socket <> nil) and (MsgList.Count > 0) do begin
      BufferA := MsgList.Items[0];
      Move(BufferA^, nBuffALen, SizeOf(Integer));
      Buffer := PChar(Integer(BufferA) + SizeOf(Integer));
      BufferLen := nBuffALen;
      if BufferLen >= MAXSOCKETBUFFLEN then begin
        if SendLength > 0 then begin
          if Gate.Socket.SendBuf(SendBuffer[0], SendLength) = -1 then
            break;
          Inc(Gate.nSendCount);
          Inc(Gate.nSendBytesCount, SendLength);
          SendLength := 0;
        end; 
        while True do begin
          if BufferLen > MAXSOCKETBUFFLEN then begin
            if Gate.Socket.SendBuf(Buffer^, MAXSOCKETBUFFLEN) <> -1 then begin
              Buffer := PChar(Integer(Buffer) + MAXSOCKETBUFFLEN);
              Dec(BufferLen, MAXSOCKETBUFFLEN);
              Inc(Gate.nSendCount);
              Inc(Gate.nSendBytesCount, MAXSOCKETBUFFLEN);
            end else
              break;
          end else begin
            if Gate.Socket.SendBuf(Buffer^, BufferLen) <> -1 then begin
              Inc(Gate.nSendCount);
              Inc(Gate.nSendBytesCount, BufferLen);
              BufferLen := 0;
            end;
            break;
          end;
        end;
        if BufferLen <= 0 then begin
          MsgList.Delete(0);
          FreeMem(BufferA);
          Continue;
        end else
        if BufferLen < nBuffALen then begin
          GetMem(BufferB, BufferLen + SizeOf(Integer));
          Move(BufferLen, BufferB^, SizeOf(Integer));
          Move(Buffer^, BufferB[SizeOf(Integer)], BufferLen);
          FreeMem(BufferA);
          MsgList.Items[0] := BufferB;
        end;
        break;
      end else
      if (BufferLen + SendLength) > MAXSOCKETBUFFLEN then begin
        if SendLength > 0 then begin
          if Gate.Socket.SendBuf(SendBuffer[0], SendLength) = -1 then
            break;
          Inc(Gate.nSendCount);
          Inc(Gate.nSendBytesCount, SendLength);
          SendLength := 0;
          Move(Buffer^, SendBuffer[SendLength], BufferLen);
          Inc(SendLength, BufferLen);
          MsgList.Delete(0);
          FreeMem(BufferA);
        end else
          break;
      end else begin
        Move(Buffer^, SendBuffer[SendLength], BufferLen);
        Inc(SendLength, BufferLen);
        MsgList.Delete(0);
        FreeMem(BufferA);
      end;
      if (GetTickCount - dwRunTick) > g_dwSocLimit then begin
        Result := False;
        break;
      end;
    end;
    if SendLength > 0 then begin
      if Gate.Socket.SendBuf(SendBuffer[0], SendLength) = -1 then begin
        GetMem(BufferB, SendLength + SizeOf(Integer));
        Move(SendLength, BufferB^, SizeOf(Integer));
        Move(SendBuffer[0], BufferB[SizeOf(Integer)], SendLength);
        MsgList.Insert(0, BufferB);
        exit;
      end;
      Inc(Gate.nSendCount);
      Inc(Gate.nSendBytesCount, SendLength);
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg2);
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TRunSocket.CloseUser(GateIdx, nSocket: Integer);
var
  i: Integer;
  GateUser: pTGateUserInfo;
  //  tStr: string;
  Gate: pTGateInfo;
resourcestring
  sExceptionMsg0 = '[Exception] TRunSocket::CloseUser 0';
  sExceptionMsg1 = '[Exception] TRunSocket::CloseUser 1';
  sExceptionMsg2 = '[Exception] TRunSocket::CloseUser 2';
  sExceptionMsg3 = '[Exception] TRunSocket::CloseUser 3';
  sExceptionMsg4 = '[Exception] TRunSocket::CloseUser 4';
begin
  if GateIdx in [Low(g_GateArr)..High(g_GateArr)] then begin
    Gate := @g_GateArr[GateIdx];
    if Gate.UserList <> nil then begin
      EnterCriticalSection(m_RunSocketSection);
      try
        try
          for i := 0 to Gate.UserList.Count - 1 do begin
            if Gate.UserList.Items[i] <> nil then begin
              GateUser := Gate.UserList.Items[i];
              if GateUser.nSocket = nSocket then begin
                try
                  if GateUser.FrontEngine <> nil then begin
                    TFrontEngine(GateUser.FrontEngine).DeleteHuman(i, GateUser.nSocket);
                  end;
                except
                  MainOutMessage(sExceptionMsg1);
                end;

                try
                  if TPlayObject(GateUser.PlayObject) <> nil then begin
                    with TPlayObject(GateUser.PlayObject) do begin
                      if (not m_boSoftClose) and (not m_boEmergencyClose) and (not m_boKickFlag) and (not m_boGhost) and (not m_boDeath) then
                      begin
                        if MakeOffLine then begin
                          m_nGateIdx := -1;
                          FrmIDSoc.SendHumanLogOutmsg(GateUser.sAccount, GateUser.nSessionID);
                        end else begin
                          m_boSoftClose := True;
                          if m_boGhost and (not m_boReconnection) then
                            FrmIDSoc.SendHumanLogOutmsg(GateUser.sAccount,  GateUser.nSessionID);
                        end;
                      end else begin
                        m_boSoftClose := True;
                        if m_boGhost and (not m_boReconnection) then
                          FrmIDSoc.SendHumanLogOutmsg(GateUser.sAccount,  GateUser.nSessionID);
                      end;
                    end;
                  end;
                except
                  MainOutMessage(sExceptionMsg2);
                end;

                {try
                  if (GateUser.PlayObject <> nil) and (TPlayObject(GateUser.PlayObject).m_boGhost) and (not TPlayObject(GateUser.PlayObject).m_boReconnection) then
                  begin
                    FrmIDSoc.SendHumanLogOutmsg(GateUser.sAccount,  GateUser.nSessionID);
                  end;
                except
                  MainOutMessage(sExceptionMsg3);
                end;  }

                try
                  Dispose(GateUser);
                  Gate.UserList.Items[i] := nil;
                  Dec(Gate.nUserCount);
                except
                  MainOutMessage(sExceptionMsg4);
                end;
                break;
              end;
            end;
          end;
        except
          MainOutMessage(sExceptionMsg0);
        end;
      finally
        LeaveCriticalSection(m_RunSocketSection);
      end;
    end;
  end;
end;

function TRunSocket.OpenNewUser(nSocket: Integer; nGSocketIdx: Integer; sIPaddr:
  string; UserList: TList): Integer; //004E0364
var
  GateUser: pTGateUserInfo;
  i: Integer;
begin
  New(GateUser);
  GateUser.sAccount := '';
  GateUser.sCharName := '';
  GateUser.sIPaddr := sIPaddr;
  GateUser.nSocket := nSocket;
  GateUser.nGSocketIdx := nGSocketIdx;
  GateUser.nSessionID := 0;
  GateUser.UserEngine := nil;
  GateUser.FrontEngine := nil;
  GateUser.PlayObject := nil;
  GateUser.dwNewUserTick := GetTickCount();
  GateUser.boCertification := False;
  for i := 0 to UserList.Count - 1 do begin
    if UserList.Items[i] = nil then begin
      UserList.Items[i] := GateUser;
      Result := i;
      Exit;
    end;
  end;
  //MainOutMessage('连接用户: ' + IntToStr(nSocket));
  UserList.Add(GateUser);
  Result := UserList.Count - 1;
end;

procedure TRunSocket.SendNewUserMsg(Socket: TCustomWinSocket; nSocket: Integer;
  nSocketIndex, nUserIdex: Integer);
var
  MsgHeader: TMsgHeader;
begin
  if not Socket.Connected then
    Exit;
  MsgHeader.dwCode := RUNGATECODE;
  MsgHeader.nSocket := nSocket;
  MsgHeader.wGSocketIdx := nSocketIndex;
  MsgHeader.wIdent := GM_SERVERUSERINDEX;
  MsgHeader.wUserListIndex := nUserIdex;
  MsgHeader.nLength := 0;
  if (Socket <> nil) and Socket.Connected then
    Socket.SendBuf(MsgHeader, SizeOf(TMsgHeader));
end;

procedure TRunSocket.ExecGateMsg(GateIdx: Integer; Gate: pTGateInfo; MsgHeader:
  pTMsgHeader; MsgBuff: PChar; nMsgLen: Integer);
var
  nCheckCode: Integer;
  nUserIdx: Integer;
  sIPaddr: string;
  GateUser: pTGateUserInfo;
  i: Integer;
resourcestring
  sExceptionMsg = '[Exception] TRunSocket::ExecGateMsg %d';
begin
  nCheckCode := 0;
  try
    case MsgHeader.wIdent of
      GM_OPEN {1}: begin
          nCheckCode := 1;
          sIPaddr := StrPas(MsgBuff);
          nUserIdx := OpenNewUser(MsgHeader.nSocket, MsgHeader.wGSocketIdx, sIPaddr, Gate.UserList);
          SendNewUserMsg(Gate.Socket, MsgHeader.nSocket, MsgHeader.wGSocketIdx, nUserIdx + 1);
          Inc(Gate.nUserCount);
        end;
      GM_CLOSE {2}: begin
          nCheckCode := 2;
          CloseUser(GateIdx, MsgHeader.nSocket);
        end;
      GM_CHECKCLIENT {4}: begin
          nCheckCode := 3;
          Gate.boSendKeepAlive := True;
          Gate.dwSendKeepTick := GetTickCount;
        end;
      GM_RECEIVE_OK {7}: begin
          nCheckCode := 4;
          Gate.nSendChecked := 0;
          Gate.nSendBlockCount := 0;
        end;
      GM_DATA {5}: begin
          nCheckCode := 5;
          GateUser := nil;
          if MsgHeader.wUserListIndex >= 1 then begin
            nUserIdx := MsgHeader.wUserListIndex - 1;
            if Gate.UserList.Count > nUserIdx then begin
              GateUser := Gate.UserList.Items[nUserIdx];
              if (GateUser <> nil) and (GateUser.nSocket <> MsgHeader.nSocket) then begin
                GateUser := nil;
              end;
            end;
          end;
          if GateUser = nil then begin
            for i := 0 to Gate.UserList.Count - 1 do begin
              if Gate.UserList.Items[i] = nil then Continue;
              if pTGateUserInfo(Gate.UserList.Items[i]).nSocket = MsgHeader.nSocket then begin
                GateUser := Gate.UserList.Items[i];
                break;
              end;
            end;
          end;

          nCheckCode := 6;
          if GateUser <> nil then begin
            if (GateUser.PlayObject <> nil) and (GateUser.UserEngine <> nil) then begin
              if GateUser.boCertification and (nMsgLen >= SizeOf(TDefaultMessage)) then begin
                if nMsgLen = SizeOf(TDefaultMessage) then begin
                  UserEngine.ProcessUserMessage(TPlayObject(GateUser.PlayObject), pTDefaultMessage(MsgBuff), nil)
                end
                else begin
                  UserEngine.ProcessUserMessage(TPlayObject(GateUser.PlayObject), pTDefaultMessage(MsgBuff),
                    @MsgBuff[SizeOf(TDefaultMessage)]);
                end;
              end;
            end
            else begin
              DoClientCertification(GateIdx, GateUser, MsgHeader.nSocket, StrPas(MsgBuff));
            end;
          end;
        end;
    end;
  except
    MainOutMessage(format(sExceptionMsg, [nCheckCode]));
  end;
end;

procedure TRunSocket.SendCheck(nIndex: Integer; nIdent: Integer);
var
  MsgHeader: TMsgHeader;
  Buff: PChar;
  nLen: Integer;
begin
  MsgHeader.dwCode := RUNGATECODE;
  MsgHeader.nSocket := 0;
  MsgHeader.wIdent := nIdent;
  MsgHeader.nLength := 0;
  nLen := SizeOf(TMsgHeader);
  GetMem(Buff, nLen + SizeOf(Integer));
  Move(nLen, Buff^, SizeOf(Integer));
  Move(MsgHeader, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
  if not AddGateBuffer(nIndex, Buff) then
    FreeMem(Buff);
end;

procedure TRunSocket.LoadRunAddr();
var
  sFileName: string;
begin
  sFileName := '.\RunAddr.txt';
  if FileExists(sFileName) then begin
    m_RunAddrList.LoadFromFile(sFileName);
    TrimStringList(m_RunAddrList);
  end;
end;

constructor TRunSocket.Create();
var
  i: Integer;
  Gate: pTGateInfo;
begin
  InitializeCriticalSection(m_RunSocketSection);
  m_RunAddrList := TStringList.Create;
  for i := Low(g_GateArr) to High(g_GateArr) do begin
    Gate := @g_GateArr[i];
    Gate.boUsed := False;
    Gate.Socket := nil;
    Gate.boSendKeepAlive := False;
    Gate.dwSendKeepTick := GetTickCount;
    Gate.nSendMsgCount := 0;
    Gate.nSendRemainCount := 0;
    Gate.dwSendTick := GetTickCount();
    Gate.nSendMsgBytes := 0;
    Gate.nSendedMsgCount := 0;
  end;
  m_nErrorCount := 0;
  LoadRunAddr();
  n4F8 := 0;
end;

destructor TRunSocket.Destroy;
begin
  m_RunAddrList.Free;
  DeleteCriticalSection(m_RunSocketSection);
  inherited;
end;

function TRunSocket.AddGateBuffer(GateIdx: Integer; Buffer: PChar): Boolean;
var
  Gate: pTGateInfo;
begin
  Result := False;
  EnterCriticalSection(m_RunSocketSection);
  try
    if GateIdx in [Low(g_GateArr)..High(g_GateArr)] then begin
      Gate := @g_GateArr[GateIdx];
      if (Gate.BufferList <> nil) and (Buffer <> nil) then begin
        if Gate.boUsed and (Gate.Socket <> nil) then begin
          Gate.BufferList.Add(Buffer);
          Result := True;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(m_RunSocketSection);
  end;
end;

procedure TRunSocket.SendOutConnectMsg(nGateIdx, nSocket, nGsIdx: Integer);
var
  DefMsg: TDefaultMessage;
  MsgHeader: TMsgHeader;
  nLen: Integer;
  Buff: PChar;
begin
  DefMsg := MakeDefaultMsg(SM_OUTOFCONNECTION, 0, 0, 0, 0);
  MsgHeader.dwCode := RUNGATECODE;
  MsgHeader.nSocket := nSocket;
  MsgHeader.wGSocketIdx := nGsIdx;
  MsgHeader.wIdent := GM_DATA;
  MsgHeader.nLength := SizeOf(TDefaultMessage);

  nLen := MsgHeader.nLength + SizeOf(TMsgHeader);
  GetMem(Buff, nLen + SizeOf(Integer));
  Move(nLen, Buff^, SizeOf(Integer));
  Move(MsgHeader, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
  Move(DefMsg, Buff[SizeOf(Integer) + SizeOf(TMsgHeader)], SizeOf(TDefaultMessage));
  if not AddGateBuffer(nGateIdx, Buff) then begin
    FreeMem(Buff);
  end;
end;
{
procedure TRunSocket.SendScanMsg(DefMsg: pTDefaultMessage; sMsg: string;
  nGateIdx, nSocket, nGsIdx: Integer);
var
  MsgHdr: TMsgHeader;
  //  nLen: Integer;
  Buff: PChar;
  nSendBytes: Integer;
begin
  MsgHdr.dwCode := RUNGATECODE;
  MsgHdr.nSocket := nSocket;
  MsgHdr.wGSocketIdx := nGsIdx;
  MsgHdr.wIdent := GM_DATA;
  MsgHdr.nLength := SizeOf(TDefaultMessage);
  Buff := nil;
  if DefMsg <> nil then begin
    if sMsg <> '' then begin
      MsgHdr.nLength := Length(sMsg) + SizeOf(TDefaultMessage) + 1;
      nSendBytes := MsgHdr.nLength + SizeOf(TMsgHeader);
      GetMem(Buff, nSendBytes + SizeOf(Integer));
      Move(nSendBytes, Buff^, SizeOf(Integer));
      Move(MsgHdr, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
      Move(DefMsg^, Buff[SizeOf(TMsgHeader) + SizeOf(Integer)],
        SizeOf(TDefaultMessage));
      Move(sMsg[1], Buff[SizeOf(TDefaultMessage) + SizeOf(TMsgHeader) +
        SizeOf(Integer)], Length(sMsg) + 1);
    end
    else begin
      MsgHdr.nLength := SizeOf(TDefaultMessage);
      nSendBytes := MsgHdr.nLength + SizeOf(TMsgHeader);
      GetMem(Buff, nSendBytes + SizeOf(Integer));
      Move(nSendBytes, Buff^, SizeOf(Integer));
      Move(MsgHdr, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
      Move(DefMsg^, Buff[SizeOf(TMsgHeader) + SizeOf(Integer)],
        SizeOf(TDefaultMessage));
    end;
  end
  else begin
    if sMsg <> '' then begin
      MsgHdr.nLength := -(Length(sMsg) + 1);
      nSendBytes := abs(MsgHdr.nLength) + SizeOf(TMsgHeader);
      GetMem(Buff, nSendBytes + SizeOf(Integer));
      Move(nSendBytes, Buff^, SizeOf(Integer));
      Move(MsgHdr, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
      Move(sMsg[1], Buff[SizeOf(TMsgHeader) + SizeOf(Integer)], Length(sMsg) +
        1);
    end;
  end;
  if not RunSocket.AddGateBuffer(nGateIdx, Buff) then begin
    if Buff <> nil then
      FreeMem(Buff);
  end;
end;            }

procedure TRunSocket.SetGateUserList(nGateIdx, nSocket: Integer; PlayObject: TPlayObject);
var
  i: Integer;
  GateUserInfo: pTGateUserInfo;
  Gate: pTGateInfo;
begin
  if nGateIdx in [Low(g_GateArr)..High(g_GateArr)] then begin
    Gate := @g_GateArr[nGateIdx];
    if Gate.UserList = nil then
      Exit;
    EnterCriticalSection(m_RunSocketSection);
    try
      for i := 0 to Gate.UserList.Count - 1 do begin
        GateUserInfo := Gate.UserList.Items[i];
        if (GateUserInfo <> nil) and (GateUserInfo.nSocket = nSocket) then begin
          GateUserInfo.FrontEngine := nil;
          GateUserInfo.UserEngine := UserEngine;
          GateUserInfo.PlayObject := PlayObject;
          break;
        end;
      end;
    finally
      LeaveCriticalSection(m_RunSocketSection);
    end;
  end;
end;

procedure TRunSocket.SendGateTestMsg(nIndex: Integer);
var
  MsgHdr: TMsgHeader;
  Buff: PChar;
  nLen: Integer;
  DefMsg: TDefaultMessage;
begin
  MsgHdr.dwCode := RUNGATECODE;
  MsgHdr.nSocket := 0;
  MsgHdr.wIdent := GM_TEST;
  MsgHdr.nLength := 100;
  nLen := MsgHdr.nLength + SizeOf(TMsgHeader);
  GetMem(Buff, nLen + SizeOf(Integer));
  Move(nLen, Buff^, SizeOf(Integer));
  Move(MsgHdr, Buff[SizeOf(Integer)], SizeOf(TMsgHeader));
  Move(DefMsg, Buff[SizeOf(TMsgHeader) + SizeOf(Integer)], SizeOf(TDefaultMessage));
  if not AddGateBuffer(nIndex, Buff) then begin
    FreeMem(Buff);
    //MainOutMessage('SendGateTestMsg Buffer Fail ' + IntToStr(nIndex));
  end;
end;

procedure TRunSocket.KickUser(sAccount: string; nSessionID: Integer);
var
  i: Integer;
  ii: Integer;
  GateUserInfo: pTGateUserInfo;
  Gate: pTGateInfo;
  nCheckCode: Integer;
resourcestring
  sExceptionMsg = '[Exception] TRunSocket::KickUser';
  sKickUserMsg = '当前登录帐号正在其它位置登录，本机已被强行离线.';
begin
  nCheckCode := 0;
  try
    for i := Low(g_GateArr) to High(g_GateArr) do begin
      Gate := @g_GateArr[i];
      nCheckCode := 1;
      if Gate.boUsed and (Gate.Socket <> nil) and (Gate.UserList <> nil) then begin
        nCheckCode := 2;
        EnterCriticalSection(m_RunSocketSection);
        try
          nCheckCode := 3;
          for ii := 0 to Gate.UserList.Count - 1 do begin
            nCheckCode := 4;
            GateUserInfo := Gate.UserList.Items[ii];
            if GateUserInfo = nil then
              Continue;
            nCheckCode := 5;
            if (GateUserInfo.sAccount = sAccount) or (GateUserInfo.nSessionID = nSessionID) then begin
              nCheckCode := 6;
              if GateUserInfo.FrontEngine <> nil then begin
                nCheckCode := 7;
                TFrontEngine(GateUserInfo.FrontEngine).DeleteHuman(i, GateUserInfo.nSocket);
              end;
              nCheckCode := 8;
              if GateUserInfo.PlayObject <> nil then begin
                nCheckCode := 9;
                TPlayObject(GateUserInfo.PlayObject).SysMsg(sKickUserMsg, c_Red, t_Hint);
                TPlayObject(GateUserInfo.PlayObject).m_boEmergencyClose := True;
                TPlayObject(GateUserInfo.PlayObject).m_boSoftClose := True;
                TPlayObject(GateUserInfo.PlayObject).m_boPlayOffLine := False;
              end;
              nCheckCode := 10;
              Dispose(GateUserInfo);
              nCheckCode := 11;
              Gate.UserList.Items[ii] := nil;
              nCheckCode := 12;
              Dec(Gate.nUserCount);
              break;
            end;
          end;
          nCheckCode := 13;
        finally
          LeaveCriticalSection(m_RunSocketSection);
        end;
        nCheckCode := 14;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg, [nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
end;

function TRunSocket.GetGateAddr(sIPaddr: string): string;
var
  i: Integer;
begin
  Result := sIPaddr;
  for i := 0 to n8 - 1 do begin
    if m_IPaddrArr[i].sIPaddr = sIPaddr then begin
      Result := m_IPaddrArr[i].dIPaddr;
      break;
    end;
  end;
end;

procedure TRunSocket.Execute;
begin
  Run;
end;

end.
