unit GateShare;

interface
uses
  Windows, Messages, Classes, SysUtils, JSocket, WinSock, SyncObjs, Common, Grobal2;

const
  g_sUpDateTime = '程序版本: v2021.1.0';
  BlockIPListName = '.\BlockIPList.txt';
  TeledataBlockIPListName = '.\Config\LoginGate_BlockIPList.txt';
  ConfigFileName = '.\Config.ini';
  TeledataConfigFileName = '.\Config\Config.ini';

type
  // class 表示继承于某个类，必须在 type 中先声明，后扩展 
  TGList = class(TList)
  private
    // 一个临界区对象声明，在多线程下，提供同步锁功能 
    GLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

  TBlockIPMethod = (mDisconnect, mBlock, mBlockList);
  TSockaddr = record
    nIPaddr: Integer;
    nCount: Integer;
    dwIPCountTick1: LongWord;
    nIPCount1: Integer;
    dwIPCountTick2: LongWord;
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

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
function GetSocketHandle(): Integer;
procedure LoadBlockIPList();
procedure SaveBlockIPList();

var
  CS_MainLog: TCriticalSection;
  MainLogMsgList: TStringList;
  BlockIPList: TGList;
  TempBlockIPList: TGList;
  IpList: TGList; //IP段禁止连接列表
  CurrIPaddrList: TGList;

  nShowLogLevel: Integer = 0;

  GateClass: string = 'LoginGate';
  GateName: string = '登录网关';
  TitleName: string = 'GameOfMir';
  ServerPort: Integer = 5500;
  ServerAddr: string = '127.0.0.1';
  GatePort: Integer = 7000;
  GateAddr: string = '0.0.0.0';
  boGateReady: Boolean = False;
  boShowMessage: Boolean;
  boStarted: Boolean = False;
  boClose: Boolean = False;
  boServiceStart: Boolean = False;
  dwKeepAliveTick: LongWord;
  boKeepAliveTimcOut: Boolean = False;
  wSocketHandle: Word = 0;

  boDecodeLock: Boolean;
  nMaxConnOfIPaddr: Integer = 50;
  BlockMethod: TBlockIPMethod = mDisconnect;
  dwKeepConnectTimeOut: LongWord = 5 * 60 * 1000;
  dwConnectTimeOut: LongWord = 10 * 1000;

  g_dwGameCenterHandle: THandle;
  g_sNowStartGate: string = '正在启动登录网关...';
  g_sNowStartOK: string = '启动登录网关完成...';

  g_boTeledata: Boolean = False;

  g_PublicAddr: string = '127.0.0.1';
  g_ClientSendStr: string = '';

  nIPCountLimitTime1: LongWord = 1000;
  nIPCountLimit1: Integer = 20;
  nIPCountLimitTime2: LongWord = 3000;
  nIPCountLimit2: Integer = 40;
  boCheckClientMsg: Boolean = True;
  boCCProtect: Boolean = True;

  nAddNewUserTime: LongWord = 4000;
  nChangePassword: LongWord = 1000;
  nLoadPassword: LongWord = 2000;

  nOldShowLogLevel: Integer = 0;
  nOldIPCountLimitTime1: LongWord = 1000;
  nOldIPCountLimit1: Integer = 20;
  nOldIPCountLimitTime2: LongWord = 3000;
  nOldIPCountLimit2: Integer = 40;
  boOldCheckClientMsg: Boolean = True;
  OldBlockMethod: TBlockIPMethod = mDisconnect;
  dwOldKeepConnectTimeOut: LongWord = 5 * 60 * 1000;
  dwOldConnectTimeOut: LongWord = 10 * 1000;
  nOldMaxConnOfIPaddr: Integer = 50;

const
  tLoginGate = 4;

implementation
uses Hutil32;

function GetSocketHandle(): Integer;
begin
  Inc(wSocketHandle);
  if wSocketHandle = 0 then
    wSocketHandle := 1;
  Result := wSocketHandle;
end;

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
    // 标记这个占用内存可以再次被拿去使用，也就是说，黑名单列表可以重新加载
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
  nParam := MakeLong(Word(tLoginGate), wIdent);
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
    MainLogMsgList := TStringList.Create;
  end;

finalization
  begin
    MainLogMsgList.Free;
    CS_MainLog.Free;
  end;

end.

