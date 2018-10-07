unit GShare;

interface
uses
  Windows, Messages, Classes, SysUtils, INIFiles, DataBackUp, Common, ComCtrls;

const
  MAXRUNGATECOUNT = 8;
  tDBServer = 0;
  tLoginSrv = 1;
  tLogServer = 2;
  tM2Server = 3;
  tLoginGate = 4;
  tSelGate = 6;
  tRunGate = 8;
  tPlugTop = 9;

  BasicSectionName = 'GameConfig';
  DBServerSectionName = 'DBServer';
  LoginSrvSectionName = 'LoginSrv';
  M2ServerSectionName = 'M2Server';
  LogServerSectionName = 'LogServer';
  RunGateSectionName = 'RunGate';
  SelGateSectionName = 'SelGate';
  LoginGateSectionName = 'LoginGate';
  PlugTopSectionName = 'PlugTop';

  sAllIPaddr = '0.0.0.0';
  sLocalIPaddr = '127.0.0.1';
  sLocalIPaddr2 = '127.0.0.2';
  nLimitOnlineUser = 2000; //服务器最高上线人数

  SERVERCONFIGDIR = 'Config\';
  SERVERCONFIGFILE = 'Config.ini';
  PLUGTOPCONFIGFILE = 'TopSetup.ini';
  SERVERGAMEDATADIR = 'GameData\';
  SERVERLOGDIR = 'Log\';

  DBSERVERSECTIONNAME2 = 'DBServer';
  DBSERVERDBDIR = 'DB\';
  DBSERVERALLOWADDR = 'AllowAddr.txt';
  DBSERVERGATEINFO = 'GateInfo.txt';

  LOGINSRVSECTIONNAME2 = 'LoginSrv';
  LOGINSRVCHRLOGNAME = SERVERLOGDIR + 'ChrLog\';
  LOGINSRVALLOWADDR = 'LoginSrv_AllowAddr.txt';
  LOGINSRVGETINFO = 'LoginSrv_GateInfo.txt';
  LOGINSRVUSERLIMIT = 'LoginSrv_UserLimit.txt';

  M2SERVERCONFIGFILE = '!Setup.txt';
  M2SERVERSECTIONNAME1 = 'Server';
  M2SERVERSECTIONNAME2 = 'Share';
  M2SERVERSEGuildBase = SERVERGAMEDATADIR + 'GuildBase\';
  M2SERVERSEGuildDir = M2SERVERSEGuildBase + 'Guilds\';
  M2SERVERSEGuildFile = M2SERVERSEGuildBase + 'GuildList.txt';
  M2SERVERSEConLogDir = SERVERLOGDIR + 'M2ConLog\';
  M2SERVERSECastleDir = SERVERGAMEDATADIR + 'Castle\';
  M2SERVERSECastleFile = SERVERGAMEDATADIR + 'Castle\List.txt';
  M2SERVERSELogDir = SERVERLOGDIR + 'M2Log\';
  M2SERVERSEEMailDir = SERVERLOGDIR + 'M2Log\';
  M2SERVERSEnvirDir = {SERVERGAMEDATADIR + }'Envir\';
  M2SERVERSMapDir = 'Map\';
  M2SERVERSALLOWADDR = 'M2Server_AllowAddr.txt';
  M2SERVERSEmailDir = SERVERGAMEDATADIR + 'EMail\';

  LOGSERVERSECTIONNAME2 = 'LogDataServer';
  LOGSERVERBaseDir = SERVERGAMEDATADIR + 'GameLog\';

  RunGateSectionName2 = 'RunGate';

  SelGateSectionName2 = 'SelGate';

  PlugTopSectionName2 = 'Setup';
  LoginGateSectionName2 = 'LoginGate';


type
  pTProgram = ^TProgram;
  TProgram = packed record
    // 是否允许启动
    boGetStart: Boolean;
    // 程序异常停止，是否重新启动
    boReStart: Boolean;
    // 0,1,2,3 未启动，正在启动，已启动, 正在关闭
    btStartStatus: Byte;
    // 程序文件
    sProgramFile: string[50];
    // 目录
    sDirectory: string[100];
    // 进程信息
    ProcessInfo: TProcessInformation;
    // 进程处理
    ProcessHandle: THandle;
    // 主窗口处理
    MainFormHandle: THandle;
    // 窗口位置
    nMainFormX: Integer;
    nMainFormY: Integer;
  end;

  pTDataListInfo = ^TDataListInfo;
  TDataListInfo = packed record
    sFileName: string[255];
    MapFileHandle: THandle;
    MapFileBuffer: PChar;
    DateTime: TDateTime;
    Data: PChar;
    DataSize: Integer;
    Item: TListItem;
  end;



  {TRunGateInfo = packed record
    boGetStart: Boolean;
    sGateAddr: string[15];
    nGatePort: Integer;
  end;   }

  TCheckCode = packed record
    dwThread0: LongWord;
    sThread0: string;
  end;

  TDBServerConfig = packed record
    MainFormX: Integer;
    MainFormY: Integer;
    GatePort: Integer;
    ServerPort: Integer;
    GetStart: Boolean;
    ProgramFile: string[50];
  end;

  TLoginSrvConfig = packed record
    MainFormX: Integer;
    MainFormY: Integer;
    GatePort: Integer;
    ServerPort: Integer;
    MonPort: Integer;
    GetStart: Boolean;
    ProgramFile: string[50];
  end;

  TM2ServerConfig = packed record
    MainFormX: Integer;
    MainFormY: Integer;
    GatePort: Integer;
    MsgSrvPort: Integer;
    GetStart: Boolean;
    ProgramFile: string[50];
  end;

  TLogServerConfig = packed record
    MainFormX: Integer;
    MainFormY: Integer;
    Port: Integer;
    GetStart: Boolean;
    ProgramFile: string[50];
  end;

  TRunGateConfig = packed record
    MainFormX: Integer;
    MainFormY: Integer;
    GetStart: array[0..MAXRUNGATECOUNT - 1] of Boolean;
    GatePort: array[0..MAXRUNGATECOUNT - 1] of Integer;
    ProgramFile: string[50];
  end;

  TSelGateConfig = packed record
    MainFormX: Integer;
    MainFormY: Integer;
    GatePort: array[0..1] of Integer;
    GetStart1: Boolean;
    GetStart2: Boolean;
    ProgramFile: string[50];
  end;

  TLoginGateConfig = packed record
    MainFormX: Integer;
    MainFormY: Integer;
    GatePort: Integer;
    GetStart: Boolean;
    ProgramFile: string[50];
  end;

  TPlugTopConfig = packed record
    MainFormX: Integer;
    MainFormY: Integer;
    GetStart: Boolean;
    ProgramFile: string[50];
  end;

  pTConfig = ^TConfig;
  TConfig = packed record
    DBServer: TDBServerConfig;
    LoginSrv: TLoginSrvConfig;
    M2Server: TM2ServerConfig;
    LogServer: TLogServerConfig;
    RunGate: TRunGateConfig;
    SelGate: TSelGateConfig;
    LoginGate: TLoginGateConfig;
    PlugTop: TPlugTopConfig;
  end;

procedure LoadConfig();
procedure SaveConfig();
function RunProgram(var ProgramInfo: TProgram; sHandle: string; dwWaitTime: LongWord): LongWord;
function StopProgram(var ProgramInfo: TProgram; dwWaitTime: LongWord): Integer;
procedure SendProgramMsg(DesForm: THandle; wIdent: Word; sSendMsg: string);
var
  g_sDataListAddrs: string = '127.0.0.1';
  g_wDataListPort: Word = 18888;
  g_sDataListPassWord: string = '123456';
  g_boGetDataListOK: Boolean = False;

  g_DataListReadBuffer: PChar;
  g_nDataListReadLength: Integer;
  g_GetDatList: TStringList;


  g_nFormIdx: Integer;
  g_IniConf: Tinifile;
  g_sButtonStartGame: string = '启动游戏服务器(&S)';
  g_sButtonStopGame: string = '停止游戏服务器(&T)';
  g_sButtonStopStartGame: string = '中止启动游戏服务器(&T)';
  g_sButtonStopStopGame: string = '中止停止游戏服务器(&T)';

  g_sConfFile: string = '.\Config.ini';
  g_sBackListFile: string = '.\BackupList.txt';

  g_sGameName: string = 'GameOfMir';
  g_sGameDirectory: string = '.\';
  g_sHeroDBName: string = 'HeroDB';
  g_sExtIPaddr: string = '127.0.0.1';
  g_sExtIPaddr2: string = '127.0.0.1';
  g_boAutoRunBak: Boolean = False;
  g_boCloseWuXin: Boolean = False;
  g_boIP2: Boolean = False;

  g_Config: TConfig = (
      DBServer: (
        MainFormX: 0;
        MainFormY: 373;
        GatePort: 5100;
        ServerPort: 6000;
        GetStart: True;
        ProgramFile: 'DBServer.exe';
      );
      LoginSrv: (
        MainFormX: 252;
        MainFormY: 0;
        GatePort: 5500;
        ServerPort: 5600;
        MonPort: 3000;
        GetStart: True;
        ProgramFile: 'LoginSrv.exe';
      );
      M2Server:(
        MainFormX: 561;
        MainFormY: 0;
        GatePort: 5000;
        MsgSrvPort: 4900;
        GetStart: True;
        ProgramFile: 'M2Server.exe';
      );
      LogServer:(
        MainFormX: 252;
        MainFormY: 286;
        Port: 10000;
        GetStart: True;
        ProgramFile: 'LogDataServer.exe';
      );
      RunGate:(
        MainFormX: 437;
        MainFormY: 373;
        GetStart: (True, True, True, False, False, False, False, False);
        GatePort: (7200, 7201, 7202, 7203, 7204, 7205, 7206, 7207);
        ProgramFile: 'RunGate.exe';
      );
      SelGate:(
        MainFormX: 0;
        MainFormY: 180;
        GatePort: (7100, 7101);
        GetStart1: True;
        GetStart2: False;
        ProgramFile: 'SelGate.exe';
      );
      LoginGate:(
        MainFormX: 0;
        MainFormY: 0;
        GatePort: 7000;
        GetStart: True;
        ProgramFile: 'LoginGate.exe';
      );
      PlugTop: (
        MainFormX: 200;
        MainFormY: 0;
        GetStart: True;
        ProgramFile: 'PlugTop.exe';
      );
    );

  DBServer: TProgram;
  LoginServer: TProgram;
  LogServer: TProgram;
  M2Server: TProgram;
  RunGate: array[0..MAXRUNGATECOUNT - 1] of TProgram; //2006-11-12 增加
  SelGate: TProgram;
  SelGate1: TProgram;
  LoginGate: TProgram;
  LoginGate2: TProgram;
  PlugTop: TProgram;

  g_dwStopTick: LongWord;
  g_dwStopTimeOut: LongWord = 10000;
  //  g_boShowDebugTab: Boolean = False;
  g_dwM2CheckCodeAddr: LongWord;
  g_dwDBCheckCodeAddr: LongWord;

  g_BackUpManager: TBackUpManager; //文件备份
  m_nBackStartStatus: Integer = 0;

implementation

uses
  MemRun;

function RunProgram(var ProgramInfo: TProgram; sHandle: string; dwWaitTime: LongWord): LongWord;
var
  StartupInfo: TStartupInfo;
  sCommandLine: string;
  sCurDirectory: string;
begin
  Result := 0;
  FillChar(StartupInfo, SizeOf(TStartupInfo), #0);
  GetStartupInfo(StartupInfo);
  sCommandLine := format('%s%s %s %d %d', [ProgramInfo.sDirectory, ProgramInfo.sProgramFile, sHandle, ProgramInfo.nMainFormX, ProgramInfo.nMainFormY]);

  sCurDirectory := ProgramInfo.sDirectory;
  if not CreateProcess(nil, //lpApplicationName,
    PChar(sCommandLine), //lpCommandLine,
    nil, //lpProcessAttributes,
    nil, //lpThreadAttributes,
    True, //bInheritHandles,
    0, //dwCreationFlags,
    nil, //lpEnvironment,
    PChar(sCurDirectory), //lpCurrentDirectory,
    StartupInfo, //lpStartupInfo,
    ProgramInfo.ProcessInfo) then begin //lpProcessInformation

    Result := GetLastError();
  end;
  Sleep(dwWaitTime);
{var
  sCommandLine: string;
begin
  Result := 0;
  sCommandLine := format('.\Execute\%s %s %d %d 1', [ProgramInfo.sProgramFile, sHandle, ProgramInfo.nMainFormX, ProgramInfo.nMainFormY]);
  if not ((ABuffer <> nil) and MemExecute(ABuffer^, nLen, sCommandLine, ProgramInfo.ProcessInfo)) then
    Result := GetLastError();
  Sleep(dwWaitTime);   }
end;

function StopProgram(var ProgramInfo: TProgram; dwWaitTime: LongWord): Integer;
var
  dwExitCode: LongWord;
begin
  Result := 0;
  dwExitCode := 0;
  if TerminateProcess(ProgramInfo.ProcessHandle, dwExitCode) then begin
    Result := GetLastError();
  end;
  Sleep(dwWaitTime);
end;

procedure SendProgramMsg(DesForm: THandle; wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(0, wIdent);
  SendData.cbData := length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(DesForm, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

procedure LoadConfig();
begin
  g_sGameDirectory := g_IniConf.ReadString(BasicSectionName, 'GameDirectory', g_sGameDirectory);
  g_sHeroDBName := g_IniConf.ReadString(BasicSectionName, 'HeroDBName', g_sHeroDBName);
  g_sGameName := g_IniConf.ReadString(BasicSectionName, 'GameName', g_sGameName);
  g_sExtIPaddr := g_IniConf.ReadString(BasicSectionName, 'ExtIPaddr', g_sExtIPaddr);
  g_sExtIPaddr2 := g_IniConf.ReadString(BasicSectionName, 'ExtIPaddr2', g_sExtIPaddr2);
  g_boAutoRunBak := g_IniConf.ReadBool(BasicSectionName, 'AutoRunBak', g_boAutoRunBak);
  g_boIP2 := g_IniConf.ReadBool(BasicSectionName, 'IP2', g_boIP2);
  g_boCloseWuXin := g_IniConf.ReadBool(BasicSectionName, 'CloseWuXin', g_boCloseWuXin);

  g_Config.DBServer.MainFormX := g_IniConf.ReadInteger(DBServerSectionName, 'MainFormX', g_Config.DBServer.MainFormX);
  g_Config.DBServer.MainFormY := g_IniConf.ReadInteger(DBServerSectionName, 'MainFormY', g_Config.DBServer.MainFormY);
  g_Config.DBServer.GatePort := g_IniConf.ReadInteger(DBServerSectionName, 'GatePort', g_Config.DBServer.GatePort);
  g_Config.DBServer.ServerPort := g_IniConf.ReadInteger(DBServerSectionName, 'ServerPort', g_Config.DBServer.ServerPort);
  g_Config.DBServer.GetStart := g_IniConf.ReadBool(DBServerSectionName, 'GetStart', g_Config.DBServer.GetStart);

  g_Config.LoginSrv.MainFormX := g_IniConf.ReadInteger(LoginSrvSectionName, 'MainFormX', g_Config.LoginSrv.MainFormX);
  g_Config.LoginSrv.MainFormY := g_IniConf.ReadInteger(LoginSrvSectionName, 'MainFormY', g_Config.LoginSrv.MainFormY);
  g_Config.LoginSrv.GatePort := g_IniConf.ReadInteger(LoginSrvSectionName, 'GatePort', g_Config.LoginSrv.GatePort);
  g_Config.LoginSrv.ServerPort := g_IniConf.ReadInteger(LoginSrvSectionName, 'ServerPort', g_Config.LoginSrv.ServerPort);
  g_Config.LoginSrv.MonPort := g_IniConf.ReadInteger(LoginSrvSectionName, 'MonPort', g_Config.LoginSrv.MonPort);
  g_Config.LoginSrv.GetStart := g_IniConf.ReadBool(LoginSrvSectionName, 'GetStart', g_Config.LoginSrv.GetStart);

  g_Config.M2Server.MainFormX := g_IniConf.ReadInteger(M2ServerSectionName, 'MainFormX', g_Config.M2Server.MainFormX);
  g_Config.M2Server.MainFormY := g_IniConf.ReadInteger(M2ServerSectionName, 'MainFormY', g_Config.M2Server.MainFormY);
  g_Config.M2Server.GatePort := g_IniConf.ReadInteger(M2ServerSectionName, 'GatePort', g_Config.M2Server.GatePort);
  g_Config.M2Server.MsgSrvPort := g_IniConf.ReadInteger(M2ServerSectionName, 'MsgSrvPort', g_Config.M2Server.MsgSrvPort);
  g_Config.M2Server.GetStart := g_IniConf.ReadBool(M2ServerSectionName, 'GetStart', g_Config.M2Server.GetStart);

  g_Config.LogServer.MainFormX := g_IniConf.ReadInteger(LogServerSectionName, 'MainFormX', g_Config.LogServer.MainFormX);
  g_Config.LogServer.MainFormY := g_IniConf.ReadInteger(LogServerSectionName, 'MainFormY', g_Config.LogServer.MainFormY);
  g_Config.LogServer.Port := g_IniConf.ReadInteger(LogServerSectionName, 'Port', g_Config.LogServer.Port);
  g_Config.LogServer.GetStart := g_IniConf.ReadBool(LogServerSectionName, 'GetStart', g_Config.LogServer.GetStart);

  g_Config.RunGate.MainFormX := g_IniConf.ReadInteger(RunGateSectionName, 'MainFormX', g_Config.RunGate.MainFormX);
  g_Config.RunGate.MainFormY := g_IniConf.ReadInteger(RunGateSectionName, 'MainFormY', g_Config.RunGate.MainFormY);
  g_Config.RunGate.GetStart[0] := g_IniConf.ReadBool(RunGateSectionName, 'GetStart1', g_Config.RunGate.GetStart[0]);
  g_Config.RunGate.GetStart[1] := g_IniConf.ReadBool(RunGateSectionName, 'GetStart2', g_Config.RunGate.GetStart[1]);
  g_Config.RunGate.GetStart[2] := g_IniConf.ReadBool(RunGateSectionName, 'GetStart3', g_Config.RunGate.GetStart[2]);
  g_Config.RunGate.GetStart[3] := g_IniConf.ReadBool(RunGateSectionName, 'GetStart4', g_Config.RunGate.GetStart[3]);
  g_Config.RunGate.GetStart[4] := g_IniConf.ReadBool(RunGateSectionName, 'GetStart5', g_Config.RunGate.GetStart[4]);
  g_Config.RunGate.GetStart[5] := g_IniConf.ReadBool(RunGateSectionName, 'GetStart6', g_Config.RunGate.GetStart[5]);
  g_Config.RunGate.GetStart[6] := g_IniConf.ReadBool(RunGateSectionName, 'GetStart7', g_Config.RunGate.GetStart[6]);
  g_Config.RunGate.GetStart[7] := g_IniConf.ReadBool(RunGateSectionName, 'GetStart8', g_Config.RunGate.GetStart[7]);

  g_Config.RunGate.GatePort[0] := g_IniConf.ReadInteger(RunGateSectionName, 'GatePort1', g_Config.RunGate.GatePort[0]);
  g_Config.RunGate.GatePort[1] := g_IniConf.ReadInteger(RunGateSectionName, 'GatePort2', g_Config.RunGate.GatePort[1]);
  g_Config.RunGate.GatePort[2] := g_IniConf.ReadInteger(RunGateSectionName, 'GatePort3', g_Config.RunGate.GatePort[2]);
  g_Config.RunGate.GatePort[3] := g_IniConf.ReadInteger(RunGateSectionName, 'GatePort4', g_Config.RunGate.GatePort[3]);
  g_Config.RunGate.GatePort[4] := g_IniConf.ReadInteger(RunGateSectionName, 'GatePort5', g_Config.RunGate.GatePort[4]);
  g_Config.RunGate.GatePort[5] := g_IniConf.ReadInteger(RunGateSectionName, 'GatePort6', g_Config.RunGate.GatePort[5]);
  g_Config.RunGate.GatePort[6] := g_IniConf.ReadInteger(RunGateSectionName, 'GatePort7', g_Config.RunGate.GatePort[6]);
  g_Config.RunGate.GatePort[7] := g_IniConf.ReadInteger(RunGateSectionName, 'GatePort8', g_Config.RunGate.GatePort[7]);

  g_Config.SelGate.MainFormX := g_IniConf.ReadInteger(SelGateSectionName, 'MainFormX', g_Config.SelGate.MainFormX);
  g_Config.SelGate.MainFormY := g_IniConf.ReadInteger(SelGateSectionName, 'MainFormY', g_Config.SelGate.MainFormY);
  g_Config.SelGate.GatePort[0] := g_IniConf.ReadInteger(SelGateSectionName, 'GatePort1', g_Config.SelGate.GatePort[0]);
  g_Config.SelGate.GatePort[1] := g_IniConf.ReadInteger(SelGateSectionName, 'GatePort2', g_Config.SelGate.GatePort[1]);
  g_Config.SelGate.GetStart1 := g_IniConf.ReadBool(SelGateSectionName, 'GetStart1', g_Config.SelGate.GetStart1);
  g_Config.SelGate.GetStart2 := g_IniConf.ReadBool(SelGateSectionName, 'GetStart2', g_Config.SelGate.GetStart2);

  g_Config.LoginGate.MainFormX := g_IniConf.ReadInteger(LoginGateSectionName, 'MainFormX', g_Config.LoginGate.MainFormX);
  g_Config.LoginGate.MainFormY := g_IniConf.ReadInteger(LoginGateSectionName, 'MainFormY', g_Config.LoginGate.MainFormY);
  g_Config.LoginGate.GatePort := g_IniConf.ReadInteger(LoginGateSectionName, 'GatePort', g_Config.LoginGate.GatePort);
  g_Config.LoginGate.GetStart := g_IniConf.ReadBool(LoginGateSectionName, 'GetStart', g_Config.LoginGate.GetStart);

  g_Config.PlugTop.MainFormX := g_IniConf.ReadInteger(PlugTopSectionName, 'MainFormX', g_Config.PlugTop.MainFormX);
  g_Config.PlugTop.MainFormY := g_IniConf.ReadInteger(PlugTopSectionName, 'MainFormY', g_Config.PlugTop.MainFormY);
  g_Config.PlugTop.GetStart := g_IniConf.ReadBool(PlugTopSectionName, 'GetStart', g_Config.PlugTop.GetStart);

end;

procedure SaveConfig();
begin
  g_IniConf.WriteString(BasicSectionName, 'GameDirectory', g_sGameDirectory);
  g_IniConf.WriteString(BasicSectionName, 'HeroDBName', g_sHeroDBName);
  g_IniConf.WriteString(BasicSectionName, 'GameName', g_sGameName);
  g_IniConf.WriteString(BasicSectionName, 'ExtIPaddr', g_sExtIPaddr);
  g_IniConf.WriteString(BasicSectionName, 'ExtIPaddr2', g_sExtIPaddr2);
  g_IniConf.WriteBool(BasicSectionName, 'AutoRunBak', g_boAutoRunBak);
  g_IniConf.WriteBool(BasicSectionName, 'IP2', g_boIP2);
  g_IniConf.WriteBool(BasicSectionName, 'CloseWuXin', g_boCloseWuXin);

  g_IniConf.WriteInteger(DBServerSectionName, 'MainFormX', g_Config.DBServer.MainFormX);
  g_IniConf.WriteInteger(DBServerSectionName, 'MainFormY', g_Config.DBServer.MainFormY);
  g_IniConf.WriteInteger(DBServerSectionName, 'GatePort', g_Config.DBServer.GatePort);
  g_IniConf.WriteInteger(DBServerSectionName, 'ServerPort', g_Config.DBServer.ServerPort);
  g_IniConf.WriteBool(DBServerSectionName, 'GetStart', g_Config.DBServer.GetStart);

  g_IniConf.WriteInteger(LoginSrvSectionName, 'MainFormX', g_Config.LoginSrv.MainFormX);
  g_IniConf.WriteInteger(LoginSrvSectionName, 'MainFormY', g_Config.LoginSrv.MainFormY);
  g_IniConf.WriteInteger(LoginSrvSectionName, 'GatePort', g_Config.LoginSrv.GatePort);
  g_IniConf.WriteInteger(LoginSrvSectionName, 'ServerPort', g_Config.LoginSrv.ServerPort);
  g_IniConf.WriteInteger(LoginSrvSectionName, 'MonPort', g_Config.LoginSrv.MonPort);
  g_IniConf.WriteBool(LoginSrvSectionName, 'GetStart', g_Config.LoginSrv.GetStart);

  g_IniConf.WriteInteger(M2ServerSectionName, 'MainFormX', g_Config.M2Server.MainFormX);
  g_IniConf.WriteInteger(M2ServerSectionName, 'MainFormY', g_Config.M2Server.MainFormY);
  g_IniConf.WriteInteger(M2ServerSectionName, 'GatePort', g_Config.M2Server.GatePort);
  g_IniConf.WriteInteger(M2ServerSectionName, 'MsgSrvPort', g_Config.M2Server.MsgSrvPort);
  g_IniConf.WriteBool(M2ServerSectionName, 'GetStart', g_Config.M2Server.GetStart);

  g_IniConf.WriteInteger(LogServerSectionName, 'MainFormX', g_Config.LogServer.MainFormX);
  g_IniConf.WriteInteger(LogServerSectionName, 'MainFormY', g_Config.LogServer.MainFormY);
  g_IniConf.WriteInteger(LogServerSectionName, 'Port', g_Config.LogServer.Port);
  g_IniConf.WriteBool(LogServerSectionName, 'GetStart', g_Config.LogServer.GetStart);

  g_IniConf.WriteInteger(RunGateSectionName, 'MainFormX', g_Config.RunGate.MainFormX);
  g_IniConf.WriteInteger(RunGateSectionName, 'MainFormY', g_Config.RunGate.MainFormY);

  g_IniConf.WriteBool(RunGateSectionName, 'GetStart1', g_Config.RunGate.GetStart[0]);
  g_IniConf.WriteBool(RunGateSectionName, 'GetStart2', g_Config.RunGate.GetStart[1]);
  g_IniConf.WriteBool(RunGateSectionName, 'GetStart3', g_Config.RunGate.GetStart[2]);
  g_IniConf.WriteBool(RunGateSectionName, 'GetStart4', g_Config.RunGate.GetStart[3]);
  g_IniConf.WriteBool(RunGateSectionName, 'GetStart5', g_Config.RunGate.GetStart[4]);
  g_IniConf.WriteBool(RunGateSectionName, 'GetStart6', g_Config.RunGate.GetStart[5]);
  g_IniConf.WriteBool(RunGateSectionName, 'GetStart7', g_Config.RunGate.GetStart[6]);
  g_IniConf.WriteBool(RunGateSectionName, 'GetStart8', g_Config.RunGate.GetStart[7]);

  g_IniConf.WriteInteger(RunGateSectionName, 'GatePort1', g_Config.RunGate.GatePort[0]);
  g_IniConf.WriteInteger(RunGateSectionName, 'GatePort2', g_Config.RunGate.GatePort[1]);
  g_IniConf.WriteInteger(RunGateSectionName, 'GatePort3', g_Config.RunGate.GatePort[2]);
  g_IniConf.WriteInteger(RunGateSectionName, 'GatePort4', g_Config.RunGate.GatePort[3]);
  g_IniConf.WriteInteger(RunGateSectionName, 'GatePort5', g_Config.RunGate.GatePort[4]);
  g_IniConf.WriteInteger(RunGateSectionName, 'GatePort6', g_Config.RunGate.GatePort[5]);
  g_IniConf.WriteInteger(RunGateSectionName, 'GatePort7', g_Config.RunGate.GatePort[6]);
  g_IniConf.WriteInteger(RunGateSectionName, 'GatePort8', g_Config.RunGate.GatePort[7]);

  g_IniConf.WriteInteger(SelGateSectionName, 'MainFormX', g_Config.SelGate.MainFormX);
  g_IniConf.WriteInteger(SelGateSectionName, 'MainFormY', g_Config.SelGate.MainFormY);
  g_IniConf.WriteInteger(SelGateSectionName, 'GatePort1', g_Config.SelGate.GatePort[0]);
  g_IniConf.WriteInteger(SelGateSectionName, 'GatePort2', g_Config.SelGate.GatePort[1]);
  g_IniConf.WriteBool(SelGateSectionName, 'GetStart1', g_Config.SelGate.GetStart1);
  g_IniConf.WriteBool(SelGateSectionName, 'GetStart2', g_Config.SelGate.GetStart2);

  g_IniConf.WriteInteger(LoginGateSectionName, 'MainFormX', g_Config.LoginGate.MainFormX);
  g_IniConf.WriteInteger(LoginGateSectionName, 'MainFormY', g_Config.LoginGate.MainFormY);
  g_IniConf.WriteInteger(LoginGateSectionName, 'GatePort', g_Config.LoginGate.GatePort);
  g_IniConf.WriteBool(LoginGateSectionName, 'GetStart', g_Config.LoginGate.GetStart);

//  g_IniConf.WriteInteger(PlugTopSectionName, 'MainFormX', g_Config.PlugTop.MainFormX);
//  g_IniConf.WriteInteger(PlugTopSectionName, 'MainFormY', g_Config.PlugTop.MainFormY);
  g_IniConf.WriteBool(PlugTopSectionName, 'GetStart', g_Config.PlugTop.GetStart);

end;

initialization
  begin
    g_IniConf := Tinifile.Create(g_sConfFile);
  end;

finalization
  begin
    g_IniConf.Free;
  end;

end.

