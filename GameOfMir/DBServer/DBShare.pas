unit DBShare;

interface
uses
  Windows, Messages, Classes, SysUtils, StrUtils, JSocket, WinSock, IniFiles,
  Grobal2, MudUtil, Common;

const
  //g_sVersion = '程序版本: 1.00 Build 20080825';
  g_sUpDateTime = '更新日期: 2018/10/05';

  SIZEOFTHUMAN = 44032;

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

  TSockaddr = record
    nIPaddr: Integer;
    dwStartAttackTick: LongWord;
    nAttackCount: Integer;
  end;
  pTSockaddr = ^TSockaddr;

  TCheckCode = record
    dwThread0: LongWord;
  end;
  TGateInfo = record
    Socket: TCustomWinSocket;
    sGateaddr: string; //0x04
    sText: string; //0x08
    sSendMsg: string;
    UserList: TList; //0x0C
    dwTick10: LongWord; //0x10
    nGateID: Integer; //网关ID
  end;
  pTGateInfo = ^TGateInfo;
  TUserInfo = record
    sAccount: string; //0x00
    sUserIPaddr: string; //0x0B
    sGateIPaddr: string;
    sConnID: string; //0x20
    sSockIndex: string;
    nSessionID: Integer; //0x24
    Socket: TCustomWinSocket;
//    s2C: string; //0x2C
    boChrSelected: Boolean; //0x30
    boChrQueryed: Boolean; //0x31
    dwTick34: LongWord; //0x34
    dwChrTick: LongWord; //0x38
    nSelGateID: ShortInt; //角色网关ID
    nDataCount: Integer;
    boWaitMsg: Boolean;
    nWaitID: Integer;
    sCreateChrMsg: string;
  end;
  pTUserInfo = ^TUserInfo;
  TRouteInfo = record
    nGateCount: Integer;
    sSelGateIP: string[15];
    sGameGateIP: array[0..7] of string[15];
    nGameGatePort: array[0..7] of Integer;
  end;
  pTRouteInfo = ^TRouteInfo;
procedure LoadConfig();
procedure LoadIPTable();
//procedure LoadGateID();
//function GetGateID(sIPaddr: string): Integer;
function GetCodeMsgSize(X: Double): Integer;
//function CheckChrName(sChrName: string): Boolean;
function InClearMakeIndexList(nIndex: Integer): Boolean;
procedure WriteLogMsg(sMsg: string);
function CheckServerIP(sIP: string): Boolean;
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
procedure MainOutMessage(sMsg: string);
function GetMagicName(wMagicId: Word): string;
function GetStdItemName(nPosition: Integer): string;
function CheckFiltrateUserName(sName: string): Boolean;
procedure LoadFiltrateName();
function GetWaitMsgID(): Integer;
//function AddAttackIP(sIPaddr: string): Boolean;
var
  //sHumDBFilePath: string = '.\GameData\DB\';
  sDataDBFilePath: string = '.\DB\';
  //sFeedPath: string = '.\FDB\';
  //sBackupPath: string = '.\FDB\';
  //sConnectPath: string = '.\Connects\';
//  sLogPath: string = '.\Log\';

  nServerPort: Integer = 6000;
  sServerAddr: string = '0.0.0.0';
  g_nGatePort: Integer = 5100;
  g_sGateAddr: string = '0.0.0.0';
  nIDServerPort: Integer = 5600;
  sIDServerAddr: string = '127.0.0.1';
  g_nWaitMsgIndex: Integer = 0;
  g_boTestServer: Boolean = True;
  {nDataManagePort: Integer = 6600;
  sDataManageAddrPort: string = '0.0.0.0';}

  //boViewHackMsg: Boolean = False;
  //  sDBIdxHeaderDesc   :String = 'legend of mir database index file 2001/7';
  //  sDBHeaderDesc      :String = 'legend of mir database file 1999/1';
  HumDB_CS: TRTLCriticalSection; //0x004ADACC

  g_FiltrateUserName: TStringList;

  n4ADAE4: Integer;
  n4ADAE8: Integer;
  n4ADAEC: Integer;
  n4ADAF0: Integer;
  boDataDBReady: Boolean; //0x004ADAF4
  n4ADAFC: Integer;
  n4ADB00: Integer;
  n4ADB04: Integer;
  boHumDBReady: Boolean; //0x4ADB08
  n4ADBF4: Integer;
  n4ADBF8: Integer;
  n4ADBFC: Integer;
  n4ADC00: Integer;
  n4ADC04: Integer;
  boAutoClearDB: Boolean; //0x004ADC08
  g_nQueryChrCount: Integer; //0x004ADC0C
  nHackerNewChrCount: Integer; //0x004ADC10
  nHackerDelChrCount: Integer; //0x004ADC14
  nHackerSelChrCount: Integer; //0x004ADC18
  n4ADC1C: Integer;
  n4ADC20: Integer;
  n4ADC24: Integer;
  n4ADC28: Integer;
  n4ADC2C: Integer;
  n4ADB10: Integer;
  n4ADB14: Integer;
  n4ADB18: Integer;
  n4ADBB8: Integer;
  bo4ADB1C: Boolean;

  sServerName: string = 'Randall';
  sConfFileName: string = '.\Dbsrc.ini';
  sConfClass: string = 'DBServer';
  sGateConfFileName: string = '.\!serverinfo.txt';
  sServerIPConfFileNmae: string = '.\!addrtable.txt';
  sFiltrateUserName: String = '.\FUserName.txt';
  //sFiltrateSortName: String = '.\FUserName.txt';
  //sGateIDConfFileName: string = '.\SelectID.txt';
  sHeroDB: string = 'HeroDB';
  sMapFile: string;
  DenyChrNameList: TStringList;
  ServerIPList: TStringList;
//  GateIDList: TStringList;
  StdItemList: TList;
  MagicList: TList;

  g_SortMinLevel: Integer = 0;
  g_SortMaxLevel: Integer = 200;

  g_boAutoSort: Boolean = True;
  g_boSortClass: Boolean = False;
  g_btSortHour: Byte = 0;
  g_btSortMinute: Byte = 4;

  g_boArraySort: Boolean = False;
  g_boArraySortTime: LongWord;

  {
  nClearIndex        :Integer;   //当前清理位置（记录的ID）
  nClearCount        :Integer;   //当前已经清量数量
  nRecordCount       :Integer;   //当前总记录数
  }
  {
  boClearLevel1      :Boolean = True;
  boClearLevel2      :Boolean = True;
  boClearLevel3      :Boolean = True;
  }
{  dwInterval: LongWord = 3000; //清理时间间隔长度

  nLevel1: Integer = 1; //清理等级 1
  nLevel2: Integer = 7; //清理等级 2
  nLevel3: Integer = 14; //清理等级 3

  nDay1: Integer = 14; //清理未登录天数 1
  nDay2: Integer = 62; //清理未登录天数 2
  nDay3: Integer = 124; //清理未登录天数 3

  nMonth1: Integer = 0; //清理未登录月数 1
  nMonth2: Integer = 0; //清理未登录月数 2
  nMonth3: Integer = 0; //清理未登录月数 3  }

  g_nClearRecordCount: Integer;
  g_nClearIndex: Integer; //0x324
  g_nClearCount: Integer; //0x328
  g_nClearItemIndexCount: Integer;

  boOpenDBBusy: Boolean; //0x350
  g_dwGameCenterHandle: THandle;
  g_boDynamicIPMode: Boolean = False;
  g_CheckCode: TCheckCode;
  g_ClearMakeIndex: TStringList;

  g_RouteInfo: array[0..19] of TRouteInfo;
  g_MainMsgList: TStringList;
  g_OutMessageCS: TRTLCriticalSection;
  ProcessHumanCriticalSection: TRTLCriticalSection;
  IDSocketConnected: Boolean;
  UserSocketClientConnected: Boolean;
  ServerSocketClientConnected: Boolean;
  DataManageSocketClientConnected: Boolean;

  ID_sRemoteAddress: string;
  User_sRemoteAddress: string;
  Server_sRemoteAddress: string;
  DataManage_sRemoteAddress: string;

  ID_nRemotePort: Integer;
  User_nRemotePort: Integer;
  Server_nRemotePort: Integer;
  DataManage_nRemotePort: Integer;

  dwKeepAliveTick: LongWord;
  dwKeepIDAliveTick: LongWord;
  dwKeepServerAliveTick: LongWord;

  //AttackIPaddrList: TGList; //攻击IP临时列表
  //boAttack: Boolean = False;
//  boDenyChrName: Boolean = True;

const
  tDBServer = 0;
implementation

uses DBSMain, HUtil32;
  {
procedure LoadGateID();
var
  i: Integer;
  LoadList: TStringList;
  sLineText: string;
  sID: string;
  sIPaddr: string;
  nID: Integer;
begin
  GateIDList.Clear;
  if FileExists(sGateIDConfFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sGateIDConfFileName);
    for i := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[i];
      if (sLineText = '') or (sLineText[1] = ';') then
        Continue;
      sLineText := GetValidStr3(sLineText, sID, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sIPaddr, [' ', #9]);
      nID := StrToIntDef(sID, -1);
      if nID < 0 then
        Continue;
      GateIDList.AddObject(sIPaddr, TObject(nID))
    end;
    LoadList.Free;
  end;
end;        }
       {
function GetGateID(sIPaddr: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to GateIDList.Count - 1 do begin
    if GateIDList.Strings[i] = sIPaddr then begin
      Result := Integer(GateIDList.Objects[i]);
      break;
    end;
  end;
end;            }

procedure LoadIPTable();
begin
  ServerIPList.Clear;
  try
    ServerIPList.LoadFromFile(sServerIPConfFileNmae);
  except
    MainOutMessage('加载IP列表文件 ' + sServerIPConfFileNmae + ' 出错！！！');
  end;
end;

function GetWaitMsgID(): Integer;
begin
  Inc(g_nWaitMsgIndex);
  if g_nWaitMsgIndex <= 0 then g_nWaitMsgIndex := 1;
  Result := g_nWaitMsgIndex;
end;

procedure LoadConfig();
var
  Conf: TIniFile;
  //  LoadInteger: Integer;
begin
  Conf := TIniFile.Create(sConfFileName);
  if Conf <> nil then begin
    //boViewHackMsg := Conf.ReadBool('Setup', 'ViewHackMsg', boViewHackMsg);
    sServerName := Conf.ReadString(sConfClass, 'ServerName', sServerName);
    nServerPort := Conf.ReadInteger(sConfClass, 'ServerPort', nServerPort);
    sServerAddr := Conf.ReadString(sConfClass, 'ServerAddr', sServerAddr);
    g_nGatePort := Conf.ReadInteger(sConfClass, 'GatePort', g_nGatePort);
    g_sGateAddr := Conf.ReadString(sConfClass, 'GateAddr', g_sGateAddr);
    sIDServerAddr := Conf.ReadString(sConfClass, 'IDSAddr', sIDServerAddr);
    nIDServerPort := Conf.ReadInteger(sConfClass, 'IDSPort', nIDServerPort);
    sHeroDB := Conf.ReadString(sConfClass, 'DBName', sHeroDB);
    sDataDBFilePath := Conf.ReadString(sConfClass, 'DBDir', sDataDBFilePath);
    g_boTestServer := not Conf.ReadBool(sConfClass, 'NotRepeatName', not g_boTestServer);
    g_boAutoSort := Conf.ReadBool(sConfClass, 'AutoSort', g_boAutoSort);
    g_boSortClass := Conf.ReadBool(sConfClass, 'SortClass', g_boSortClass);
    g_btSortHour := Conf.ReadInteger(sConfClass, 'SortHour', g_btSortHour);
    g_btSortMinute := Conf.ReadInteger(sConfClass, 'SortMinute', g_btSortMinute);
    g_SortMinLevel := Conf.ReadInteger(sConfClass, 'SortMinLevel', g_SortMinLevel);
    g_SortMaxLevel := Conf.ReadInteger(sConfClass, 'SortMaxLevel', g_SortMaxLevel);


    Conf.WriteString(sConfClass, 'ServerName', sServerName);
    Conf.WriteInteger(sConfClass, 'ServerPort', nServerPort);
    Conf.WriteString(sConfClass, 'ServerAddr', sServerAddr);
    Conf.WriteInteger(sConfClass, 'GatePort', g_nGatePort);
    Conf.WriteString(sConfClass, 'GateAddr', g_sGateAddr);
    Conf.WriteString(sConfClass, 'IDSAddr', sIDServerAddr);
    Conf.WriteInteger(sConfClass, 'IDSPort', nIDServerPort);
    Conf.WriteString(sConfClass, 'DBName', sHeroDB);
    Conf.WriteString(sConfClass, 'DBDir', sDataDBFilePath);
    Conf.WriteBool(sConfClass, 'AutoSort', g_boAutoSort);
    Conf.WriteBool(sConfClass, 'SortClass', g_boSortClass);
    Conf.WriteInteger(sConfClass, 'SortHour', g_btSortHour);
    Conf.WriteInteger(sConfClass, 'SortMinute', g_btSortMinute);
    Conf.WriteInteger(sConfClass, 'SortMinLevel', g_SortMinLevel);
    Conf.WriteInteger(sConfClass, 'SortMaxLevel', g_SortMaxLevel);
    Conf.WriteBool(sConfClass, 'NotRepeatName', not g_boTestServer);
    {dwInterval := Conf.ReadInteger('DBClear', 'Interval', dwInterval);
    nLevel1 := Conf.ReadInteger('DBClear', 'Level1', nLevel1);
    nLevel2 := Conf.ReadInteger('DBClear', 'Level2', nLevel2);
    nLevel3 := Conf.ReadInteger('DBClear', 'Level3', nLevel3);
    nDay1 := Conf.ReadInteger('DBClear', 'Day1', nDay1);
    nDay2 := Conf.ReadInteger('DBClear', 'Day2', nDay2);
    nDay3 := Conf.ReadInteger('DBClear', 'Day3', nDay3);
    nMonth1 := Conf.ReadInteger('DBClear', 'Month1', nMonth1);
    nMonth2 := Conf.ReadInteger('DBClear', 'Month2', nMonth2);
    nMonth3 := Conf.ReadInteger('DBClear', 'Month3', nMonth3); }

    {LoadInteger := Conf.ReadInteger('Setup', 'DynamicIPMode', -1);
    if LoadInteger < 0 then begin
      Conf.WriteBool('Setup', 'DynamicIPMode', g_boDynamicIPMode);
    end
    else
      g_boDynamicIPMode := LoadInteger = 1;   }
    Conf.Free;
  end;
  LoadIPTable();
  //LoadGateID();
end;

function GetStdItemName(nPosition: Integer): string;
var
  //  i: Integer;
  StdItem: pTStdItem;
begin
  if (nPosition - 1 >= 0) and (nPosition < StdItemList.Count) then begin
    StdItem := StdItemList.Items[nPosition - 1];
    if StdItem <> nil then begin
      Result := StdItem.Name;
    end;
  end;
end;

{获取技能名字，通过技能 ID}
function GetMagicName(wMagicId: Word): string;
var
  i: Integer;
  Magic: pTMagic;
begin
  for i := 0 to MagicList.Count - 1 do begin
    Magic := MagicList.Items[i];
    if Magic <> nil then begin
      if Magic.wMagicId = wMagicId then begin
        Result := Magic.sMagicName;
        break;
      end;
    end;
  end;
end;

function GetCodeMsgSize(X: Double): Integer;
begin
  if INT(X) < X then
    Result := TRUNC(X) + 1
  else
    Result := TRUNC(X)
end;
{
function CheckChrName(sChrName: string): Boolean;
var
  i: Integer;
  Chr: Char;
  boIsTwoByte: Boolean;
  FirstChr: Char;
begin
  Result := True;
  boIsTwoByte := False;
  FirstChr := #0;
  for i := 1 to Length(sChrName) do begin
    Chr := (sChrName[i]);
    if boIsTwoByte then begin
      Result := CheckTwoByteChar(FirstChr, Chr);
      boIsTwoByte := False;
    end else begin
      if (Chr >= #$81) and (Chr <= #$FE) then begin
        boIsTwoByte := True;
        FirstChr := Chr;
      end
      else begin
        Result := CheckOneByteChar(Chr);
      end;
    end;
    if not Result then break;
  end;
  if boIsTwoByte then Result := False;
end;              }

function InClearMakeIndexList(nIndex: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to g_ClearMakeIndex.Count - 1 do begin
    if nIndex = Integer(g_ClearMakeIndex.Objects[i]) then begin
      Result := True;
      break;
    end;
  end;
end;

procedure MainOutMessage(sMsg: string);
begin
  EnterCriticalSection(g_OutMessageCS);
  try
    g_MainMsgList.Add(sMsg);
  finally
    LeaveCriticalSection(g_OutMessageCS);
  end;
end;

procedure WriteLogMsg(sMsg: string);
begin

end;

function CheckServerIP(sIP: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to ServerIPList.Count - 1 do begin
    if CompareText(sIP, ServerIPList.Strings[i]) = 0 then begin
      Result := True;
      break;
    end;
  end;
end;

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tDBServer), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

function CheckFiltrateUserName(sName: string): Boolean;
var
  i: integer;
begin
  Result := False;
  for I := 0 to g_FiltrateUserName.Count - 1 do begin
    if AnsiContainsText(sName, g_FiltrateUserName.Strings[I]) then begin
      Result := True;
      break;
    end;
  end;
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

procedure LoadFiltrateName();
var
  i:Integer;
  TempList:TStringList;
  sStr:String;
begin
  g_FiltrateUserName.Clear;
  TempList:=TStringList.Create;
  TempList.Clear;
  Try
    if FileExists(sFiltrateUserName) then begin
      TempList.LoadFromFile(sFiltrateUserName);
      For i:=0 to TempList.Count -1 do begin
        sStr:=TempList.Strings[I];
        if (Length(sStr) > 0) and (sStr[1]<>';') then
          g_FiltrateUserName.Add(sStr);
      end;
    end else begin
      TempList.Add(';创建人物过滤字符，一行一个过滤');
      TempList.SaveToFile(sFiltrateUserName);
    end;
  Finally
    TempList.Free;
  end;
end;

initialization
  begin
    InitializeCriticalSection(g_OutMessageCS);
    InitializeCriticalSection(HumDB_CS);
    g_MainMsgList := TStringList.Create;
    DenyChrNameList := TStringList.Create;
    ServerIPList := TStringList.Create;
    //GateIDList := TStringList.Create;
    g_ClearMakeIndex := TStringList.Create;
    StdItemList := TList.Create;
    MagicList := TList.Create;
    g_FiltrateUserName := TStringList.Create;
  end;

finalization
  begin
    DeleteCriticalSection(HumDB_CS);
    DeleteCriticalSection(g_OutMessageCS);
    DenyChrNameList.Free;
    ServerIPList.Free;
    //GateIDList.Free;
    g_ClearMakeIndex.Free;
    g_MainMsgList.Free;
    StdItemList.Free;
    MagicList.Free;
    g_FiltrateUserName.Free;
  end;

end.

