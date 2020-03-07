unit LSShare;

interface
uses
  Windows, Messages, Classes, SysUtils, SyncObjs, IniFiles, SDK, JSocket;
const
  VAR_DB = 0;
  VAR_SQL = 1;
  RUNVAR = VAR_DB;
  
  g_sUpDateTime = '程序版本: v2020.1.0';

  {sConfFileName = '.\Config\Config.ini';
  sGateConfFileName = '.\Config\LoginSrv_GateInfo.txt';
  sServerIPConfFileNmae = '.\Config\LoginSrv_AllowAddr.txt';
  sUserLimitFileNmae = '.\Config\LoginSrv_UserLimit.txt';    }
  sConfFileName = '.\Logsrv.ini';
  sGateConfFileName = '.\!addrtable.txt';
  sServerIPConfFileNmae = '.\!serveraddr.txt';
  sUserLimitFileNmae = '.\!UserLimit.txt';
  sSectionServer = 'LoginSrv';
  sIdentServerAddr = 'ServerAddr';
  sIdentServerPort = 'ServerPort';
  sIdentGateAddr = 'GateAddr';
  sIdentGatePort = 'GatePort';
  sIdentMonAddr = 'MonAddr';
  sIdentMonPort = 'MonPort';
  sIdentSqlAddr = 'SQLAddr';
  sIdentSqlPort = 'SQLPort';
  sIdentIdDir = 'IDDir';
  sMajor = 'Major';
  sMinor = 'Minor';
  sRelease = 'Release';
  sBuild = 'Build';
  sIdentCountLogDir = 'CountLogDir';

  MAXGATELIST = 5; //最大登录网关连接数量

  {IDFILEMODE = 0; //文件模式
  IDSQLDBMODE = 1; //Sql数据库模式

  IDMODE = IDFILEMODE; }

  tLoginSrv = 1;
  MAXGATEROUTE = 20;
type
  TSockaddr = record
    nIPaddr: Integer;
    dwStartAttackTick: LongWord;
    nAttackCount: Integer;
  end;
  pTSockaddr = ^TSockaddr;

  TGateInfo = record
    Socket: TCustomWinSocket;
    sIPaddr: string;
    sReceiveMsg: string;
    sSendMsg: string;
    UserList: TList;
    boDelete: Boolean;
  end;
  pTGateInfo = ^TGateInfo;

  TMatrixCard = packed record
    CardID: Byte;
    CardNo: Word;
  end;

  TUserInfo = record
    sAccount: string;
    sUserIPaddr: string;
    sGateIPaddr: string;
    sSockIndex: string;
    sArryIndex: string;
    nSessionID: Integer;
    nUserCDKey: Integer;
    nGameGold: Integer;
    nCheckEMail: Integer;
    nWaitMsgID: Integer;
    dtDateTime: TDateTime;
    boSelServer: Boolean;
    boMatrixCardCheck: Boolean;
    boWaitMsg: Boolean;
    dwCheckMatrixCardTime: LongWord;
    MatrixCard: array[0..2] of TMatrixCard;
  end;
  pTUserInfo = ^TUserInfo;
  pTDBUserInfo = pTUserInfo;

  TGateNet = record
    sIPaddr: string;
    nPort: Integer;
    boEnable: Boolean;
  end;
  TRouteInfo = record
    nGateCount: Integer;
    sSelGateIP: string[15];
    sGameGateIP: array[0..7] of string[15];
    nGameGatePort: array[0..7] of Integer;
  end;
  pTRouteInfo = ^TRouteInfo;

  
  TConfig = record
    IniConf: TIniFile;
    boRemoteClose: Boolean;
    sGateAddr: string[30];
    nGatePort: Integer;
    sServerAddr: string[30];
    nServerPort: Integer;
    sMonAddr: string[30];
    nMonPort: Integer;
    sSQLAddr: string[30];
    nSQLPort: Integer;
    sGateIPaddr: string[30]; 
    sIdDir: string[50];
    sChrLogDir: string[50];
    SQLCONNHOST: string[20];
    SQLCONNUSER: string[50];
    SQLCONNPASS: string[50];
    SQLDATABASE: string[20];
    wMajor: Word;
    wMinor: Word;
    wRelease: Word;
    wBuild: Word;

    GateCriticalSection: TRTLCriticalSection;
    GateList: array[0..MAXGATELIST - 1] of TGateInfo;
    SessionList: TGList;
    boShowDetailMsg: Boolean;
    boDisabledCreateAccount: Boolean;
    boDisabledChangePassword: Boolean;
    boDisabledLostPassword: Boolean;
    dwProcessGateTick: LongWord;
    dwProcessGateTime: LongWord; 
    nRouteCount: Integer; 
    GateRoute: array[0..MAXGATEROUTE - 1] of TRouteInfo;
  end;
  pTConfig = ^TConfig;
function GetCodeMsgSize(X: Double): Integer;
function CheckAccountName(sName: string): Boolean;
function GetSessionID(): Integer;
procedure SaveGateConfig(Config: pTConfig);

function GenSpaceString(sStr: string; nSpaceCOunt: Integer): string;
procedure MainOutMessage(sMsg: string);
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  g_Config: TConfig = (
    boRemoteClose: False;
    sGateAddr: '0.0.0.0';
    nGatePort: 5500;
    sServerAddr: '0.0.0.0';
    nServerPort: 5600;
    sMonAddr: '0.0.0.0';
    nMonPort: 3000;
    sSQLAddr: '127.0.0.1';
    nSQLPort: 20000;
    sIdDir: '.\DB\';
    sChrLogDir: '.\ChrLog\';
    boShowDetailMsg: False;
    boDisabledCreateAccount: False;
    boDisabledChangePassword: False;
    boDisabledLostPassword: False
    );

  StringList_0: TStringList; 
  nOnlineCountMin: Integer; 
  nOnlineCountMax: Integer; 
  nMemoHeigh: Integer; 
  g_OutMessageCS: TRTLCriticalSection;
  g_MainMsgList: TStringList; 
  CS_DB: TCriticalSection; 
  n4753A4: Integer; 
  n4753A8: Integer; 
  n4753B0: Integer;



  n47328C: Integer;

  nSessionIdx: Integer;
  g_nWaitMsgIndex: Integer;

  g_n472A6C: Integer;
  g_n472A70: Integer;
  g_n472A74: Integer;
  g_boDataDBReady: Boolean;
  bo470D20: Boolean;
  g_boCloseWuXin: Boolean = False;

  //nVersionDate: Integer = 20011006;

  ServerAddr: array[0..MAXGATEROUTE - 1] of string[15];
  g_dwGameCenterHandle: THandle;
implementation

function GetCodeMsgSize(X: Double): Integer;
begin
  if INT(X) < X then
    Result := TRUNC(X) + 1
  else
    Result := TRUNC(X)
end;

function CheckAccountName(sName: string): Boolean;
var
  I: Integer;
  nLen: Integer;
begin
  Result := False;
  if sName = '' then Exit;
  Result := true;
  nLen := length(sName);
  I := 1;
  while (true) do begin
    if I > nLen then break;
    if not (sName[I] in [#48..#57, #65..#90, #95, #97..#122]) then begin
      Result := false;
      break;
    end;

    {if (sName[I] < '0') or (sName[I] > 'z') then begin
      Result := False;
      if (sName[I] >= #$B0) and (sName[I] <= #$C8) then begin
        Inc(I);
        if I <= nLen then
          if (sName[I] >= #$A1) and (sName[I] <= #$FE) then
            Result := true;
      end;
      if not Result then
        break; }
    //end;
    Inc(I);
  end;
end;

function GetSessionID(): Integer;
begin
  Inc(nSessionIdx);
  if nSessionIdx <= 0 then begin
    nSessionIdx := 2;
  end;
  Result := nSessionIdx;
end;


procedure SaveGateConfig(Config: pTConfig);
var
  I, II: Integer;
  sTest: string;
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  try
    SaveList.Clear;
    for I := Low(Config.GateRoute) to High(Config.GateRoute) do begin
      sTest := '';
      if (Config.GateRoute[I].sSelGateIP <> '') and (Config.GateRoute[I].nGateCount > 0)
        then begin
        sTest := Config.GateRoute[I].sSelGateIP;
        for II := 0 to Config.GateRoute[I].nGateCount - 1 do begin
          if (Config.GateRoute[I].sGameGateIP[II] <> '') and
            (Config.GateRoute[I].nGameGatePort[II] > 0) then
            sTest := sTest + ' ' + Config.GateRoute[I].sGameGateIP[II] + ' ' +
              IntToStr(Config.GateRoute[I].nGameGatePort[II]);
        end;
        SaveList.Add(sTest);
      end;
    end;
    SaveList.SaveToFile(sGateConfFileName);
  finally
    SaveList.Free;
  end;
end;


function GenSpaceString(sStr: string; nSpaceCOunt: Integer): string;
var
  I: Integer;
begin
  Result := sStr + ' ';
  for I := 1 to nSpaceCOunt - length(sStr) do begin
    Result := Result + ' ';
  end;
end;

procedure MainOutMessage(sMsg: string);
begin
  EnterCriticalSection(g_OutMessageCS);
  try
    g_MainMsgList.Add(FormatDateTime('[DD HH:MM] ', Now) + sMsg)
  finally
    LeaveCriticalSection(g_OutMessageCS);
  end;
end;

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tLoginSrv), wIdent);
  SendData.cbData := length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

initialization
  begin
    InitializeCriticalSection(g_OutMessageCS);
    
    g_MainMsgList := TStringList.Create;
  end;
finalization
  begin
    g_MainMsgList.Free;
    
    DeleteCriticalSection(g_OutMessageCS);
  end;
end.
