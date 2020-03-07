unit GateShare;

interface
uses
  Windows, Messages, SysUtils, Classes, JSocket, WinSock, SyncObjs, IniFiles,
  Common, Grobal2;
const
  tRunGate = 8;

  g_sUpDateTime = '程序版本: v2020.1.0';
  BlockIPListName = '.\BlockIPList.txt';
  TeledataBlockIPListName = '.\Config\RunGate_BlockIPList.txt';
  ConfigFileName = '.\Config.ini';
  TeledataConfigFileName = '.\Config\Config.ini';

  RUNATEMAXSESSION = 1000;
  MSGMAXLENGTH = 200000;
  //SENDCHECKSIZE = 512;
  //SENDCHECKSIZEMAX = 20480;

  sSTATUS_FAIL = '+FAIL/';
  sSTATUS_GOOD = '+GOOD/';
  sSTATUS_SPEED = '+Fail/';
  sSTATUS_TIME = '+TIME/';
type
  TGList = class(TList)
  private
    GLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

  TBlockIPMethod = (mDisconnect, mBlock, mBlockList);
  TBlockSysMode = (mAllBlock, mSelfBolck, mClose, mDisMsg, mDisMsgorSys);
  TSockaddr = record
    nIPaddr: Integer;
    nCount: Integer;
    dwIPCountTick1: LongWord;
    nIPCount1: Integer;
    dwIPCountTick2: LongWOrd;
    nIPCount2: Integer;
    dwDenyTick: LongWord;
    nIPDenyCount: Integer;
  end;
  pTSockaddr = ^TSockaddr;

  TBlockaddr = record
    nBeginAddr: LongWord;
    nEndAddr: LongWord;
  end;
  pTBlockaddr = ^TBlockaddr;

  TConfig = record
    boCheckSpeed: Boolean;
    boHit: Boolean;
    boSpell: Boolean;
    boRun: Boolean;
    boWalk: Boolean;
    boTurn: Boolean;
    nHitTime: Integer;
    nSpellTime: Integer;
    nRunTime: Integer;
    nWalkTime: Integer;
    nTurnTime: Integer;
    nHitCount: Integer;
    nSpellCount: Integer;
    nRunCount: Integer;
    nWalkCount: Integer;
    nTurnCount: Integer;
    btSpeedControlMode: Byte;
    boSpeedShowMsg: Boolean;
    sSpeedShowMsg: string;
    btMsgColor: Byte;
    nIncErrorCount: Byte;
    nDecErrorCount: Byte;
  end;

  TGameSpeed = record
    dwHitTimeTick: LongWord;
    dwSpellTimeTick: LongWord;
    dwRunTimeTick: LongWord;
    dwWalkTimeTick: LongWord;
    dwTurnTimeTick: LongWord;
    nHitCount: Integer;
    nSpellCount: Integer;
    nRunCount: Integer;
    nWalkCount: Integer;
    nTurnCount: Integer;
  end;
  pTGameSpeed = ^TGameSpeed;

  TSessionInfo = record
    Socket: TCustomWinSocket;
    sSocData: string;
    sSendData: string;
    nUserListIndex: Integer;
    nPacketIdx: Integer;
    nPacketErrCount: Integer;
    //数据包序号重复计数（客户端用封包发送数据检测）
    boStartLogon: Boolean;
    boSendLock: Boolean;
    boOverNomSize: Boolean;
    nOverNomSizeCount: ShortInt;
    dwSendLatestTime: LongWord;
    //nCheckSendLength: Integer;
    //boSendAvailable: Boolean;
    //boSendCheck: Boolean;
    dwTimeOutTime: LongWord;
    nReceiveLength: Integer;
    dwReceiveLengthTick: LongWord;
    dwReceiveTick: LongWord;
    dwSendClientCheckTick: LongWord;
    dwSpeedTick: Integer;
    boLuck: Boolean;
    nSpeedTimeCount: integer;
    nSckHandle: Integer;
    sRemoteAddr: string;
    sUserName: string[15];
    nSessionID: Integer;
    sAccount: string[20];
    dwSuspendedTick: LongWord;
    dwSuspendedCount: Integer;
    dwSayMsgTick: LongWord; //发言间隔控制
    dwSayMsgCount: Integer;
    dwSayMsgCloseTime: LongWord;
    dwHitTick: LongWord; //攻击时间
    GameSpeed: TGameSpeed;
  end;

  pTSessionInfo = ^TSessionInfo;
  TSendUserData = record
    nSocketIdx: Integer; //0x00
    nSocketHandle: Integer; //0x04
    sMsg: string; //0x08
  end;
  pTSendUserData = ^TSendUserData;
procedure AddMainLogMsg(Msg: string; nLevel: Integer);
procedure LoadBlockIPList();
procedure SaveBlockIPList();
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  g_Config: TConfig = (
    boHit: False;
    boSpell: False;
    boRun: False;
    boWalk: False;
    boTurn: False;
    nHitTime: 550;
    nSpellTime: 730;
    nRunTime: 440;
    nWalkTime: 440;
    nTurnTime: 440;
    nHitCount: 15;
    nSpellCount: 15;
    nRunCount: 15;
    nWalkCount: 15;
    nTurnCount: 15;
    btSpeedControlMode: 1;
    boSpeedShowMsg: True;
    sSpeedShowMsg:
    '〖提示〗: 请爱护游戏环境,不要使用非法外挂!';
    btMsgColor: 0;
    nIncErrorCount: 5;
    nDecErrorCount: 3;
    );

  g_boTeledata: Boolean = False;

  CS_MainLog: TCriticalSection;
  CS_FilterMsg: TCriticalSection;
  MainLogMsgList: TStringList;
  nShowLogLevel: Integer = 0;
  GateClass: string = 'RunGate';
  nMaxMemoListCount: Integer = 100;
  GateName: string = '游戏网关';

  TitleName: string = 'GameOfMir';

  ServerAddr: string = '127.0.0.1';
  ServerPort: Integer = 5000;
  GateAddr: string = '0.0.0.0';
  GatePort: Integer = 7200;
  CenterPort: Integer = 5600;
  CenterAddr: string = '127.0.0.1';
  boStarted: Boolean = False;
  boCenterReady: boolean = False;
  boClose: Boolean = False;
  boShowBite: Boolean = True; //显示B 或 KB
  boServiceStart: Boolean = False;
  boGateReady: Boolean = False; //0045AA74 网关是否就绪
  boCheckServerFail: Boolean = False;
  //网关 <->游戏服务器之间检测是否失败（超时）
//  dwCheckServerTimeOutTime    :LongWord = 60 * 1000 ;//网关 <->游戏服务器之间检测超时时间长度
  dwCheckServerTimeOutTime: LongWord = 3 * 60 * 1000;
  //网关 <->游戏服务器之间检测超时时间长度
  AbuseList: TStringList; //004694F4
  SessionArray: array[0..RUNATEMAXSESSION - 1] of TSessionInfo;
  SessionCount: Integer; //0x32C 连接会话数
  boShowSckData: Boolean; //0x324 是否显示SOCKET接收的信息

  sReplaceWord: string = '*';
  ReviceMsgList: TList; //0x45AA64
  //SendMsgList: TList; //0x45AA68
  nCurrConnCount: Integer;
  boSendHoldTimeOut: Boolean;
  dwSendHoldTick: LongWord;
  n45AA80: Integer;
  n45AA84: Integer;
  //dwCheckRecviceTick: LongWord;
  dwCheckRecviceMin: LongWord;
  dwCheckRecviceMax: LongWord;

  dwCheckServerTick: LongWord;
  dwCheckServerTimeMin: LongWord;
  dwCheckServerTimeMax: LongWord;
  SocketBuffer: PChar; //45AA5C
  nBuffLen: Integer; //45AA60
  List_45AA58: TList;
  boDecodeMsgLock: Boolean;
  dwProcessReviceMsgTimeLimit: LongWord;
  dwProcessSendMsgTimeLimit: LongWord;

  BlockIPList: TGList; //禁止连接IP列表
  TempBlockIPList: TGList; //临时禁止连接IP列表
  IpList: TGList; //IP段禁止连接列表
  CurrIPaddrList: TGList;
  //AttackIPaddrList: TGList; //攻击IP临时列表

  nMaxClientPacketSize: Integer = 7000;
  nNomClientPacketSize: Integer = 200;
  nMaxClientMsgCount: Integer = 15;
  nEditSpeedCount: integer = 1;
  nEditSpeedTick: Integer = 60 * 1000;
  //nEditSpeedTime: Integer = 1000;
  //nMaxOverNomSizeCount: Integer = 2;

  nCheckServerFail: Integer = 0;
  //dwAttackTick: LongWord = 300;
  //nAttackCount: Integer = 5;
  g_dwGameCenterHandle: THandle;

  BlockMethod: TBlockIPMethod = mDisconnect;
  BlockSysMode: TBlockSysMode = mDisMsgorSys;
  boBlockSayMsg: Boolean = False;
  bokickOverPacketSize: Boolean = True;
  sDropFilterMsgAlert: string = '您发送的信息里包含了非法字符[%s]。';

  //  nClientSendBlockSize        :Integer = 250; //发送给客户端数据包大小限制
  nClientSendBlockSize: Integer = 8192; //发送给客户端数据包大小限制

  nMaxConnOfIPaddr: Integer = 50;
  dwClientTimeOutTime: LongWord = 30 * 1000;
  dwSessionTimeOutTime: LongWord = 3 * 60 * 1000;
  dwSendClientCheckTime: LongWord = 60 * 1000;
  //间隔多久往客户端发送检测通信消息

  nIPCountLimitTime1: LongWord = 1000;
  nIPCountLimit1: Integer = 20;
  nIPCountLimitTime2: LongWord = 3000;
  nIPCountLimit2: Integer = 40;

  nSayMsgMaxLen: Integer = 70; //发言字符长度
  nSayMsgTime: LongWord = 3000; //发言间隔时间
  nSayMsgCount: Integer = 2; //发言次数
  nSayMsgCloseTime: LongWord = 600000; //禁言时间
  boBlockSay: Boolean = False;
  //客户端连接会话超时(指定时间内未有数据传输)
  Conf: TIniFile;
  sConfigFileName: string;

  //sHintMsgPreFix: string = '〖提示〗';
  btRedMsgFColor: Byte = $FF; //前景
  btRedMsgBColor: Byte = $38; //背景
  btGreenMsgFColor: Byte = $DB; //前景
  btGreenMsgBColor: Byte = $FF; //背景
  btBlueMsgFColor: Byte = $FF; //前景
  btBlueMsgBColor: Byte = $FC; //背景

  boCCProtect: Boolean = True;

  nOldShowLogLevel: Integer = 0;
  nOldIPCountLimitTime1: LongWord = 1000;
  nOldIPCountLimit1: Integer = 20;
  nOldIPCountLimitTime2: LongWord = 3000;
  nOldIPCountLimit2: Integer = 40;
  boOldCheckClientMsg: Boolean = True;
  OldBlockMethod: TBlockIPMethod = mDisconnect;
  dwOldSessionTimeOutTime: LongWord = 3 * 60 * 1000;
  dwOldClientTimeOutTime: LongWord = 10 * 1000;
  nOldMaxConnOfIPaddr: Integer = 50;
implementation
uses
Hutil32;

procedure AddMainLogMsg(Msg: string; nLevel: Integer);
var
  tMsg: string;
begin
  try
    CS_MainLog.Enter;
    if nLevel <= nShowLogLevel then begin
      tMsg := '[' + TimeToStr(Now) + '] ' + Msg;
      MainLogMsgList.Add(tMsg);
    end;
  finally
    CS_MainLog.Leave;
  end;
end;
 {
procedure SaveAbuseFile();
var
  sFileName: string;
begin
  sFileName := '.\WordFilter.txt';
  try
    CS_FilterMsg.Enter;
    AbuseList.SaveToFile(sFileName);
  finally
    CS_FilterMsg.Leave;
  end;
end;

procedure LoadAbuseFile();
var
  sFileName: string;
begin
  AddMainLogMsg('正在加载文字过滤配置信息...', 4);
  sFileName := '.\WordFilter.txt';
  try
    CS_FilterMsg.Enter;
    AbuseList.Clear;
  finally
    CS_FilterMsg.Leave;
  end;
  if FileExists(sFileName) then begin
    try
      CS_FilterMsg.Enter;
      AbuseList.LoadFromFile(sFileName);
    finally
      CS_FilterMsg.Leave;
    end;
  end;
  AddMainLogMsg('文字过滤信息加载完成...', 4);
end;   }

procedure LoadBlockIPList();
var
  i: Integer;
  sFileName: string;
  LoadList: TStringList;
  sIPaddr, sBeginaddr, sEndaddr: string;
  nBeginaddr, nEndaddr: Integer;
  Blockaddr: pTBlockaddr;
  IPaddr: pTSockaddr;
begin
  if g_boTeledata then sFileName := TeledataBlockIPListName
  else sFileName := BlockIPListName;
  
  for i := 0 to BlockIPList.Count - 1 do begin
    Dispose(pTSockaddr(BlockIPList[i]))
  end;
  BlockIPList.Clear;

  for i := 0 to IPList.Count - 1 do begin
    Dispose(pTBlockaddr(IPList[i]))
  end;
  IPList.Clear;
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for i := 0 to LoadList.Count - 1 do begin
      sIPaddr := Trim(LoadList.Strings[i]);
      if sIPaddr = '' then
        Continue;
      sEndaddr := GetValidStr3(sIPaddr, sBeginaddr, [' ', #9]);
      nBeginaddr := inet_addr(PChar(sBeginaddr));
      nEndaddr := inet_addr(PChar(sEndaddr));
      if (nBeginaddr <> INADDR_NONE) and (nEndaddr <> INADDR_NONE) and (LongWord(nEndaddr) >= LongWord(nBeginaddr)) then begin
        New(Blockaddr);
        Blockaddr.nBeginAddr := nBeginaddr;
        Blockaddr.nEndAddr := nEndaddr;
        IPList.Add(Blockaddr);
      end else
      if (nBeginaddr <> INADDR_NONE) then begin
        New(IPaddr);
        SafeFillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr.nIPaddr := nBeginaddr;
        BlockIPList.Add(IPaddr);
      end;
    end;
    LoadList.Free;
  end;
end;

procedure SaveBlockIPList();
var
  i: Integer;
  SaveList: TStringList;
  sFileName: string;
begin
  if g_boTeledata then sFileName := TeledataBlockIPListName
  else sFileName := BlockIPListName;
  SaveList := TStringList.Create;
  for i := 0 to IPList.Count - 1 do begin
    SaveList.Add(StrPas(inet_ntoa(TInAddr(pTBlockaddr(IPList[i]).nBeginAddr))) + #9 +
      StrPas(inet_ntoa(TInAddr(pTBlockaddr(IPList[i]).nEndAddr))));
  end;
  for I := 0 to BlockIPList.Count - 1 do begin
    SaveList.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr))));
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
end;

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tRunGate), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

constructor TGList.Create;
begin
  inherited Create;
  InitializeCriticalSection(GLock);
end;

destructor TGList.Destroy;
begin
  DeleteCriticalSection(GLock);
  inherited;
end;

procedure TGList.Lock;
begin
  EnterCriticalSection(GLock);
end;

procedure TGList.UnLock;
begin
  LeaveCriticalSection(GLock);
end;

initialization
  begin
    
    CS_MainLog := TCriticalSection.Create;
    CS_FilterMsg := TCriticalSection.Create;
    MainLogMsgList := TStringList.Create;
    AbuseList := TStringList.Create;
    ReviceMsgList := TList.Create;
    //SendMsgList := TList.Create;
    List_45AA58 := TList.Create;
    boShowSckData := False;
  end;

finalization
  begin
    List_45AA58.Free;
    ReviceMsgList.Free;
    //SendMsgList.Free;
    AbuseList.Free;
    MainLogMsgList.Free;
    CS_MainLog.Free;
    CS_FilterMsg.Free;

  end;

end.


