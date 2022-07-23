unit MNShare;

interface
uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Actor, Grobal2, HGEGUI, MyCommon, HGETextures;

const
  MCC_IF = 1;
  MCC_WRITE = 2;
  MCC_ENDIF = 3;

Type
  TMissionFlagInfo = packed record
    nFlag: Integer;
    btValue: Byte;
  end;

  TMissionItemInfo = packed record
    sItemName: string[ActorNameLen];
    wItemCount: Word;
  end;

  pTStatusInfo = ^TStatusInfo;
  TStatusInfo = packed record
    dwTime: LongWord;
    nPower: Integer;
    Button: TObject;
  end;

  pTMissionScript = ^TMissionScript;
  TMissionScript = packed record
    sCMDCode: Integer;
    sParam1: string;
    sParam2: string;
    sParam3: string;
    sParam4: string;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    nParam4: Integer;
    sAllParam: string;
  end;

  pTCenterMsg = ^TCenterMsg;
  TCenterMsg = record
    nID: Integer;
    nFColor: Integer;
    nBColor: Integer;
    sMsgStr: string;
    nTime: LongWord;
  end;

  pTClientMission = ^TClientMission;
  TClientMission = packed record
    boAccept: Boolean;
    sMissionMaster: string[MapNameLen * 2];
    sMissionName: string[MapNameLen];
    sMissionShowName: string[MapNameLen * 2];
    sNPCMapName: string[MapNameLen * 2];
    wNPCCurrX: Word;
    wNPCCurrY: Word;
    sCanAcceptText: string;
    sCanAcceptMapName: string;
    btJob: Byte;
    btSex: Byte;
    wLogoutIdx: Word;
    btCycCount: Byte;
    btCycVar: Byte;
    nMinLevel: Integer;
    nMaxLevel: Integer;
    AcceptFlag: array[0..2] of TMissionFlagInfo;
    //AcceptItem: array[0..2] of TMissionItemInfo;
    CompleteFlag: array[0..2] of TMissionFlagInfo;
    CompleteItem: array[0..2] of TMissionItemInfo;
    sKillMonName1: string[ActorNameLen];
    btKillCount1: Byte;
    sKillMonName2: string[ActorNameLen];
    btKillCount2: Byte;
    sMissionHint: string;
    MissionInfo: Pointer;
    NPC: TNPCActor;
    ScriptList: TList;
    boHide: Boolean;
  end;

  pTClientMissionInfo = ^TClientMissionInfo;
  TClientMissionInfo = packed record
    MissionIdx: Integer;
    MissionInfo: TMissionInfo;
    ClientMission: pTClientMission;
    DTreeNodes: pTDTreeNodes;
    nItemCount1: Word;
    nItemCount2: Word;
    nItemCount3: Word;
    boPinch: Boolean;
  end;

var
  g_nScriptGotoX: Integer;
  g_nScriptGotoY: Integer;
  g_nScriptGotoStr: string;
  g_sExitUrl: string = '';
  g_MissionList: TList;
  g_MissionFlag: TMissionFlag;
  g_MissionInfoList: TList;
  g_MissionArithmometer: TMissionArithmometer;
  g_RefMissionItemTick: LongWord = 0;
  g_ServerDateTime: TDateTime;
  g_ServerTimeRunTick: LongWord;
  g_OperateHintList: TStringList;
  g_nOperateHintIdx: Integer;
  g_dwOperateHintTick: LongWord;
  g_FilterMsgList: TStringList;
  g_CenterMsgList: TList;
  g_FileVersionInfo: TFileVersionInfo;
  g_LoginAddr: string[30];
  g_DESKey: string;
  g_PackPassword: string[8];
  g_LoginPort: Word;
  g_TopDWindow: TDWindow = nil;
  g_boCanDrawMissionInfo: Boolean = True;
{$IFDEF RELEASE}
  g_boSQLReg: Boolean = True;
{$ELSE}
  g_boSQLReg: Boolean = False;
{$ENDIF}
  g_LogoStr: string;
  g_boUseWuXin: Boolean = True;
  g_boCreateHumIsNew: Boolean = True;
  s5: string[20] = 'pES6ncJE';
  s6: string[20] = 'pKucfQL9';
  g_MissionDateStream: TMemoryStream;
  g_StditemsDateStream: TMemoryStream;
  g_MagicDateStream: TMemoryStream;
  g_MapDescDateStream: TMemoryStream;
  g_MakeMagicDateStream: TMemoryStream;
  g_boAllLoadStream: Boolean;
  g_MakeMagic: TMakeMagic;
  g_nMakeMagicPoint: Word;
  g_btMakeMagicAddPoint: Byte;
  g_btMakeMagicUsePoint: Byte;
  g_btMakeMagicAddRate: Byte;
  g_btMakeMagicMaxLevel: Byte;
  g_boSendMakeMagicAdd: Boolean;
  g_MakeMagicList: array[0..9] of TList;
  g_StatusInfoArr: array[0..STATUS_COUNT - 1] of TStatusInfo;
  g_StatusInfoList: TList;
  g_ShowStrengthenInfo: Boolean = False;
  g_boCancelDropItemHint: Boolean = False;
  g_boEasyNotShift: Boolean = False;
  g_Cmd_UserMove: string = '@传送';
  g_Cmd_Auth: string = '@联盟';
  g_Cmd_AuthCancel: string = '@取消联盟';
  g_Cmd_AllMsg: string = '@传';
  g_Cmd_EndGuild: string = '@退出行会';
  g_Cmd_TakeOnHorse: string = '@骑马';
  g_Cmd_TakeOffHorse: string = '@下马';
  g_Cmd_MemberFunction: string = '@会员';
  g_Cmd_MemberFunctionEx: string = '@帮助';

procedure ScriptGoto(sCmd: string);
procedure GotoClickNpc(nX, nY: Integer);
procedure LoadMakeMagicList(const MemoryStream: TMemoryStream);
procedure LoadMissionList(const StringList: TStringList);
procedure ClearMissionList();
procedure ClearMissionInfoList();
function GetMissionInfo(sMissionName: string): pTClientMission;
function GetMissionFlagStatus(nFlag: Integer): Integer;
function GetMissionFlagStatusEx(sFlag: string; nDef: Integer): Integer;
procedure SetMissionFlagStatus(nFlag: Integer; nValue: Integer);
procedure SetMissionFlagStatusEx(sFlag: string; nValue, nDef: Integer);
function FormatShowText(sMsg: string; ClientMissionInfo: pTClientMissionInfo): string;
function GetCanMissionAccept(): string;
function GAMERSADecodeString(sMsg: string): string;
function GAMERSAEncodeString(sMsg: string): string;
function HTTPDecode(const AStr: String): String;
function HTTPEncode(const AStr: String): String;
procedure RefM2SetupInfo(SetupInfo: LongWord);
function GetDefMagicIcon(Mag: pTClientDefMagic): TDXTexture;


implementation

uses
  Hutil32, MShare, CLMain, DrawScrn, RSA, FState, FState3, GameSetup, WMFile;

var
  GAMERSA: TRSA;


procedure RefM2SetupInfo(SetupInfo: LongWord);
begin
  g_ShowStrengthenInfo := CheckIntStatus(SetupInfo, M2SETUP_SHOWSTRENGTHENINFO);
  g_boCancelDropItemHint := CheckIntStatus(SetupInfo, M2SETUP_CANCELDROPITEMHINT);
  g_boEasyNotShift := CheckIntStatus(SetupInfo, M2SETUP_NOTSHIFTKEY);
  FrmDlg.DMagicCbo.Visible := CheckIntStatus(SetupInfo, M2SETUP_SHOWCBOFORM);
  FrmDlg.DMagicSub.Visible := CheckIntStatus(SetupInfo, M2SETUP_SHOWMAKEMAGICFORM);
  FrmDlg3.DDMCS.Visible := CheckIntStatus(SetupInfo, M2SETUP_SHOWWARLONGWIDE);
  if not FrmDlg3.DDMCS.Visible then g_SetupInfo.boAutoLongWide := False;
  if FrmDlg.DMagicSub.Visible and (not FrmDlg.DMagicCbo.Visible) then begin
    FrmDlg.DMagicSub.Left := FrmDlg.DMagicCbo.Left;
  end;
  if g_boEasyNotShift and g_SetupInfo.boExemptShift then g_boShiftOpen := True;
end;

procedure GotoClickNpc(nX, nY: Integer);
var
  Actor: TActor;
  i: Integer;
begin
  for i := PlayScene.m_ActorList.Count - 1 downto 0 do begin
    Actor := TActor(PlayScene.m_ActorList[i]);
    if (Actor.m_btRace = RCC_MERCHANT) and (Actor.m_nCurrX = nX) and (Actor.m_nCurrY = nY) then begin
      g_dwClickNpcTick := GetTickCount;
      FrmMain.SendClientMessage(CM_CLICKNPC, Actor.m_nRecogId, 0, 0, 0);
      Actor.Click;
      break;
    end;
  end;
end;

procedure ScriptGoto(sCmd: string);
var
  sPlace, sX, sY, sMapName: string;
  nX, nY: Integer;
begin
  if g_MySelf = nil then exit;
  g_nScriptGotoStr := sCmd;
  ArrestStringEx(sCmd, '(', ')', sCmd);
  while (True) do begin
    if sCmd = '' then break;
    sCmd := GetValidStr3(sCmd, sPlace, [';', ' ']);
    if sPlace = '' then break;
    sPlace := GetValidStr3(sPlace, sMapName, [',', ' ']);
    sPlace := GetValidStr3(sPlace, sX, [',', ' ']);
    sPlace := GetValidStr3(sPlace, sY, [',', ' ']);
    nX := StrToIntDef(sX, -1);
    nY := StrToIntDef(sY, -1);
    if (sMapName <> '') and (CompareText(sMapName, g_sMapTitle) = 0) and (nX <> -1) and (nY <> -1) then begin
      if (abs(g_MySelf.m_nCurrX - nX) <= 3) and (abs(g_MySelf.m_nCurrY - nY) <= 3) then begin
        GotoClickNpc(nX, nY);
        exit;
      end;
      g_nMiniMapOldX := -1;
      g_nMiniMapPath := FindPath(nX, nY);
      if High(g_nMiniMapPath) > 2 then begin
        g_boAutoMoveing := False;
        g_nMiniMapMoseX := nX;
        g_nMiniMapMoseY := nY;
        g_nScriptGotoX := nX;
        g_nScriptGotoY := nY;
        g_boAutoMoveing := True;
        g_boNpcMoveing := True;
      end
      else begin
        g_nMiniMapMoseX := -1;
        g_nMiniMapMoseY := -1;
        g_nScriptGotoX := -1;
        g_nScriptGotoY := -1;
        DScreen.AddSysMsg('[无法到达目的地]', clRed);
      end;
      exit;
    end;
  end;
  DScreen.AddSysMsg('[无法在当前地图使用]', clRed);
end;

function GetCanMissionAccept(): string;
var
  ClientMission: pTClientMission;
  boAccept: Boolean;
  sBACKMSG, sCmd: string;
  sPlace, sX, sY, sMapName: string;
  nX, nY: Integer;
  boAdd: Boolean;
begin
  if g_MySelf = nil then exit;
  Result := '当前没有可以接受的任务。';
  sBACKMSG := '';
  for ClientMission in g_MissionList do begin
    if ClientMission.boAccept then begin
      boAccept := True;
      if (ClientMission.AcceptFlag[0].nFlag <> 0) and
        (GetMissionFlagStatus(ClientMission.AcceptFlag[0].nFlag) <> ClientMission.AcceptFlag[0].btValue) then
        boAccept := False;
      if boAccept and (ClientMission.AcceptFlag[1].nFlag <> 0) and
        (GetMissionFlagStatus(ClientMission.AcceptFlag[1].nFlag) <> ClientMission.AcceptFlag[1].btValue) then
        boAccept := False;
      if boAccept and (ClientMission.AcceptFlag[2].nFlag <> 0) and
        (GetMissionFlagStatus(ClientMission.AcceptFlag[2].nFlag) <> ClientMission.AcceptFlag[2].btValue) then
        boAccept := False;

      if boAccept and (ClientMission.btJob <> 99) and (g_MySelf.m_btJob <> ClientMission.btJob) then
        boAccept := False;

      if boAccept and (ClientMission.btSex <> 99) and (g_MySelf.m_btSex <> ClientMission.btSex) then
        boAccept := False;

      if boAccept and
        ((g_MySelf.m_Abil.Level < ClientMission.nMinLevel) or (g_MySelf.m_Abil.Level > ClientMission.nMaxLevel)) then
        boAccept := False;

      if boAccept and (ClientMission.btCycCount > 0) and
          (ClientMission.btCycVar in [Low(g_MissionArithmometer)..High(g_MissionArithmometer)]) and
          (g_MissionArithmometer[ClientMission.btCycVar] >= ClientMission.btCycCount) then
        boAccept := False;

      boAdd := False;
      if boAccept then begin
        sCmd := ClientMission.sCanAcceptMapName;
        while (True) do begin
          if sCmd = '' then break;
          sCmd := GetValidStr3(sCmd, sPlace, [';', ' ']);
          if sPlace = '' then break;
          sPlace := GetValidStr3(sPlace, sMapName, [',', ' ']);
          sPlace := GetValidStr3(sPlace, sX, [',', ' ']);
          sPlace := GetValidStr3(sPlace, sY, [',', ' ']);
          nX := StrToIntDef(sX, -1);
          nY := StrToIntDef(sY, -1);
          if (sMapName <> '') and (CompareText(sMapName, g_sMapTitle) = 0) and (nX <> -1) and (nY <> -1) then begin
            sBACKMSG := sBACKMSG + '<' + ClientMission.sCanAcceptText + '/@move(' + ClientMission.sCanAcceptMapName + ')>\';
            boAdd := True;
            break;
          end;
        end;
        if not boAdd then
          sBACKMSG := sBACKMSG + '{' + ClientMission.sCanAcceptText + '=FCO=248}\';
      end;
    end;
  end;
  if sBACKMSG <> '' then
    Result := sBACKMSG;
end;

procedure LoadMakeMagicList(const MemoryStream: TMemoryStream);
var
  PackMakeItem:array of TPackMakeItem;
  nCount, I, K: Integer;
  pPackMakeItem: pTPackMakeItem;

begin
  for I := Low(g_MakeMagicList) to High(g_MakeMagicList) do begin
    for k := 0 to g_MakeMagicList[I].Count - 1 do begin
      Dispose(pTPackMakeItem(g_MakeMagicList[I][k]));
    end;
    g_MakeMagicList[I].Clear;
  end;
  nCount := MemoryStream.Size div SizeOf(TPackMakeItem);
  if nCount > 0 then begin
    SetLength(PackMakeItem, nCount);
    Move(MemoryStream.Memory^, PackMakeItem[0], SizeOf(TPackMakeItem) * nCount);
    for I := 0 to nCount - 1 do begin
      if PackMakeItem[I].btIdx in [Low(g_MakeMagicList)..High(g_MakeMagicList)] then begin
        New(pPackMakeItem);
        pPackMakeItem^ := PackMakeItem[I];
        g_MakeMagicList[PackMakeItem[I].btIdx].Add(pPackMakeItem);
      end;
    end;
    PackMakeItem := nil;
  end;
end;


procedure LoadMissionList(const StringList: TStringList);
  procedure GetSceipt(ClientMission: pTClientMission; sStr: string);
  var
    sCmd, sParam1, sParam2, sParam3, sParam4, sAllParam: string;
    MissionScript: pTMissionScript;
    nCode: Integer;
  begin
    sStr := GetValidStr3(sStr, sCmd, [' ', #9]);
    sAllParam := sStr;
    nCode := 0;
    sStr := GetValidStr3(sStr, sParam1, [' ', #9]);
    sStr := GetValidStr3(sStr, sParam2, [' ', #9]);
    sStr := GetValidStr3(sStr, sParam3, [' ', #9]);
    sStr := GetValidStr3(sStr, sParam4, [' ', #9]);
    if CompareText(sCmd, '#IF') = 0 then begin
      nCode := MCC_IF;
    end else
    if CompareText(sCmd, '#WRITE') = 0 then begin
      nCode := MCC_WRITE;
    end else
    if CompareText(sCmd, '#ENDIF') = 0 then begin
      nCode := MCC_ENDIF;
    end;
    if nCode > 0 then begin
      New(MissionScript);
      MissionScript.sCMDCode := nCode;
      MissionScript.sParam1 := sParam1;
      MissionScript.sParam2 := sParam2;
      MissionScript.sParam3 := sParam3;
      MissionScript.sParam4 := sParam4;
      MissionScript.sAllParam := sAllParam;
      MissionScript.nParam1 := StrToIntDef(sParam1, 0);
      MissionScript.nParam2 := StrToIntDef(sParam2, 0);
      MissionScript.nParam3 := StrToIntDef(sParam3, 0);
      MissionScript.nParam4 := StrToIntDef(sParam4, 0);
      if ClientMission.ScriptList = nil then ClientMission.ScriptList := TList.Create;
      ClientMission.ScriptList.Add(MissionScript);
    end;
  end;
var
//  MemoryStream: TMemoryStream;
  //StringList: TStringList;
  I: Integer;
  sStr, sName, sValue: string;
  ClientMission: pTClientMission;
  boBegin: Boolean;
begin
  ClearMissionList();
  {if (g_WSettingImages <> nil) and (g_WSettingImages.boInitialize) then begin
    MemoryStream := g_WSettingImages.GetDataStream(MISSIONFILE, dtData);
    if MemoryStream <> nil then begin
      StringList := TStringList.Create;
      StringList.LoadFromStream(MemoryStream); }
  boBegin := False;
  ClientMission := nil;
  for I := 0 to StringList.Count - 1 do begin
    sStr := Trim(StringList[i]);
    if (sStr = '') or (sStr[1] = ';') then Continue;
    if boBegin then begin
      if sStr <> '}' then begin
        if sStr[1] = '#' then begin
          GetSceipt(ClientMission, sStr);
        end else begin
          if ClientMission <> nil then
            ClientMission.sMissionHint := ClientMission.sMissionHint + sStr;
        end;
      end else
        boBegin := False;
    end else
    if sStr[1] = '[' then begin
      if (ClientMission <> nil) then begin
        g_MissionList.Add(ClientMission);
        ClientMission := nil;
      end;
      ArrestStringEx(sStr, '[', ']', sName);
      if sName <> '' then begin
        New(ClientMission);
        SafeFillChar(ClientMission^, SizeOf(TClientMission), #0);
        ClientMission.sMissionName := sName;
        ClientMission.MissionInfo := nil;
        ClientMission.btJob := 99;
        ClientMission.btSex := 99;
        ClientMission.NPC := nil;
        ClientMission.boAccept := True;
        ClientMission.ScriptList := nil;
      end;
    end else
    if (sStr = '{') and (ClientMission <> nil) then begin
      boBegin := True;
    end else
    if (ClientMission <> nil) then begin
      sValue := GetValidStr3(sStr, sName, [';', ',', '=', ' ', #9]);
      if sName = '任务分类' then begin
        ClientMission.sMissionMaster := sValue;
      end else
      if sName = '任务名称' then begin
        ClientMission.sMissionShowName := sValue;
      end else
      if sName = '可接任务提示' then begin
        ClientMission.sCanAcceptText := sValue;
      end else
      if sName = '可接任务地图' then begin
        ClientMission.sCanAcceptMapName := sValue;
      end else
      if sName = '隐藏显示' then begin
        ClientMission.boHide := sValue = '1';
      end else
      if sName = '注销任务标识' then begin
        ClientMission.wLogoutIdx := StrToIntDef(sValue, 0);
      end else
      if sName = '循环次数' then begin
        ClientMission.btCycCount := StrToIntDef(sValue, 0);
      end else
      if sName = '循环变量' then begin
        ClientMission.btCycVar := StrToIntDef(sValue, 0);
      end else
      if sName = '是否过程' then begin
        if sValue = '1' then ClientMission.boAccept := False
        else ClientMission.boAccept := True;
      end else
      if CompareText(sName, 'NPC_地图') = 0 then begin
        ClientMission.sNPCMapName := sValue;
      end else
      if CompareText(sName, 'NPC_坐标X') = 0 then begin
        ClientMission.wNPCCurrX := StrToIntDef(sValue, 0);
      end else
      if CompareText(sName, 'NPC_坐标Y') = 0 then begin
        ClientMission.wNPCCurrY := StrToIntDef(sValue, 0);
      end else
      if sName = '条件_变量' then begin
        if Pos(']', sValue) > 0 then
          ArrestStringEx(sValue, '[', ']', sValue);
        ClientMission.AcceptFlag[0].nFlag := StrToIntDef(sValue, 0);
      end else
      if sName = '条件_变量值' then begin
        ClientMission.AcceptFlag[0].btValue := StrToIntDef(sValue, 0);
      end else
      if sName = '条件_变量2' then begin
        if Pos(']', sValue) > 0 then
          ArrestStringEx(sValue, '[', ']', sValue);
        ClientMission.AcceptFlag[1].nFlag := StrToIntDef(sValue, 0);
      end else
      if sName = '条件_变量值2' then begin
        ClientMission.AcceptFlag[1].btValue := StrToIntDef(sValue, 0);
      end else
      if sName = '条件_变量3' then begin
        if Pos(']', sValue) > 0 then
          ArrestStringEx(sValue, '[', ']', sValue);
        ClientMission.AcceptFlag[2].nFlag := StrToIntDef(sValue, 0);
      end else
      if sName = '条件_变量值3' then begin
        ClientMission.AcceptFlag[2].btValue := StrToIntDef(sValue, 0);
      end else
      if sName = '条件_最低等级' then begin
        ClientMission.nMinLevel := StrToIntDef(sValue, 0);
      end else
      if sName = '条件_最高等级' then begin
        ClientMission.nMaxLevel := StrToIntDef(sValue, 0);
      end else
      if sName = '条件_职业' then begin
        ClientMission.btJob := StrToIntDef(sValue, 0);
      end else
      if sName = '条件_性别' then begin
        ClientMission.btSex := StrToIntDef(sValue, 0);
      end else
      if sName = '结束_变量' then begin
        if Pos(']', sValue) > 0 then
          ArrestStringEx(sValue, '[', ']', sValue);
        ClientMission.CompleteFlag[0].nFlag := StrToIntDef(sValue, 0);
      end else
      if sName = '结束_变量值' then begin
        ClientMission.CompleteFlag[0].btValue := StrToIntDef(sValue, 0);
      end else
      if sName = '结束_变量2' then begin
        if Pos(']', sValue) > 0 then
          ArrestStringEx(sValue, '[', ']', sValue);
        ClientMission.CompleteFlag[1].nFlag := StrToIntDef(sValue, 0);
      end else
      if sName = '结束_变量值2' then begin
        ClientMission.CompleteFlag[1].btValue := StrToIntDef(sValue, 0);
      end else
      if sName = '结束_变量3' then begin
        if Pos(']', sValue) > 0 then
          ArrestStringEx(sValue, '[', ']', sValue);
        ClientMission.CompleteFlag[2].nFlag := StrToIntDef(sValue, 0);
      end else
      if sName = '结束_变量值3' then begin
        ClientMission.CompleteFlag[2].btValue := StrToIntDef(sValue, 0);
      end else
      if sName = '结束_物品' then begin
        ClientMission.CompleteItem[0].sItemName := sValue;
      end else
      if sName = '结束_物品数量' then begin
        ClientMission.CompleteItem[0].wItemCount := StrToIntDef(sValue, 0);
      end else
      if sName = '结束_物品2' then begin
        ClientMission.CompleteItem[1].sItemName := sValue;
      end else
      if sName = '结束_物品数量2' then begin
        ClientMission.CompleteItem[1].wItemCount := StrToIntDef(sValue, 0);
      end else
      if sName = '结束_物品3' then begin
        ClientMission.CompleteItem[2].sItemName := sValue;
      end else
      if sName = '结束_物品数量3' then begin
        ClientMission.CompleteItem[2].wItemCount := StrToIntDef(sValue, 0);
      end else
      if sName = '结束_杀怪名称1' then begin
        ClientMission.sKillMonName1 := sValue;
      end else
      if sName = '结束_杀怪数量1' then begin
        ClientMission.btKillCount1 := StrToIntDef(sValue, 0);
      end else
      if sName = '结束_杀怪名称2' then begin
        ClientMission.sKillMonName2 := sValue;
      end else
      if sName = '结束_杀怪数量2' then begin
        ClientMission.btKillCount2 := StrToIntDef(sValue, 0);
      end;
    end;
  end;
  if (ClientMission <> nil) then begin
    g_MissionList.Add(ClientMission);
  end;
      //StringList.Free;
      //MemoryStream.Free;
    //end;
  //end;
end;

procedure ClearMissionList();
var
  ClientMission: pTClientMission;
begin
  for ClientMission in g_MissionList do
    Dispose(ClientMission);
  g_MissionList.Clear;
end;

procedure ClearMissionInfoList();
var
  ClientMissionInfo: pTClientMissionInfo;
begin
  for ClientMissionInfo in g_MissionInfoList do begin
    ClientMissionInfo.ClientMission.MissionInfo := nil;
    Dispose(ClientMissionInfo);
  end;
  g_MissionInfoList.Clear;
end;

function GetMissionInfo(sMissionName: string): pTClientMission;
var
  ClientMission: pTClientMission;
begin
  Result := nil;
  for ClientMission in g_MissionList do begin
    if CompareText(ClientMission.sMissionName,sMissionName) = 0 then begin
      Result := ClientMission;
      break;
    end;
  end;
end;

function GetMissionFlagStatus(nFlag: Integer): Integer;
var
  n10, n14: Integer;
begin
  Result := 0;
  Dec(nFlag);
  if nFlag < 0 then Exit;
  n10 := nFlag div 8;
  n14 := (nFlag mod 8);
  if (n10 >= Low(g_MissionFlag)) and (n10 <= High(g_MissionFlag)) then begin
    if ((128 shr n14) and (g_MissionFlag[n10])) <> 0 then
      Result := 1
    else
      Result := 0;
  end;
end;

function GetMissionFlagStatusEx(sFlag: string; nDef: Integer): Integer;
begin
  if Pos(']', sFlag) > 0 then
    ArrestStringEx(sFlag, '[', ']', sFlag);
  Result := GetMissionFlagStatus(StrToIntDef(sFlag, nDef));
end;

procedure SetMissionFlagStatus(nFlag: Integer; nValue: Integer);
var
  n10, n14: Integer;
  bt15: Byte;
begin
  Dec(nFlag);
  if nFlag < 0 then Exit;
  n10 := nFlag div 8;
  n14 := (nFlag mod 8);
  if (n10 >= Low(g_MissionFlag)) and (n10 <= High(g_MissionFlag)) then begin
    bt15 := g_MissionFlag[n10];
    if nValue = 0 then begin
      g_MissionFlag[n10] := (not (128 shr n14)) and (bt15);
    end
    else begin
      g_MissionFlag[n10] := (128 shr n14) or (bt15);
    end;
  end;
end;

procedure SetMissionFlagStatusEx(sFlag: string; nValue, nDef: Integer);
begin
  if Pos(']', sFlag) > 0 then
    ArrestStringEx(sFlag, '[', ']', sFlag);
  SetMissionFlagStatus(StrToIntDef(sFlag, nDef), nValue);
end;

function FormatShowText(sMsg: string; ClientMissionInfo: pTClientMissionInfo): string;
const
  VAR_ARH = '^ARH(';
  VAR_BJOB = '^BJOB(';
  VAR_BSEX = '^BSEX(';
  VAR_BJS = '^BJS(';
  VAR_FLAG = '^FLAG(';
  VAR_CMON1 = '^CMON1(';
  VAR_CMON2 = '^CMON2(';
  VAR_CITEM1 = '^CITEM1(';
  VAR_CITEM2 = '^CITEM2(';
  VAR_CITEM3 = '^CITEM3(';
  VAR_KILLMON1 = '^KILLMON1';
  VAR_KILLMON2 = '^KILLMON2';
  VAR_MAXKILLMON1 = '^MAXKILLMON1';
  VAR_MAXKILLMON2 = '^MAXKILLMON2';
  VAR_ITEMCOUNT1 = '^ITEMCOUNT1';
  VAR_ITEMCOUNT2 = '^ITEMCOUNT2';
  VAR_ITEMCOUNT3 = '^ITEMCOUNT3';
  VAR_MAXITEMCOUNT1 = '^MAXITEMCOUNT1';
  VAR_MAXITEMCOUNT2 = '^MAXITEMCOUNT2';
  VAR_MAXITEMCOUNT3 = '^MAXITEMCOUNT3';
var
  nC: Integer;
  s10, s14: string;
  tempstr: string;
  sLabel: string;
  n14: integer;
  sWar, sWizard, sTaos, sWar_W, sWizard_W, sTaos_W: string;
  sMan, sWoMan: string;
begin
  nC := 0;
  tempstr := sMsg;
  while (True) do begin
    if pos('>', tempstr) <= 0 then break;
    tempstr := ArrestStringEx(tempstr, '<', '>', s10);
    if s10 <> '' then begin
      if (pos('/', s10) <= 0) and (s10[1] = '^') then begin
        sLabel := UpperCase(s10);
        if CompareLStr(sLabel, VAR_ARH, Length(VAR_ARH)) then begin
          ArrestStringEx(sLabel, '(', ')', s14);
          n14 := StrToIntDef(s14, -1);
          if n14 in [Low(g_MissionArithmometer)..High(g_MissionArithmometer)] then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', IntToStr(g_MissionArithmometer[n14]))
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
        end else
        if CompareLStr(sLabel, VAR_BJOB, Length(VAR_BJOB)) then begin
          ArrestStringEx(sLabel, '(', ')', s14);
          s14 := GetValidStr3(s14, sWar, [',']);
          s14 := GetValidStr3(s14, sWizard, [',']);
          s14 := GetValidStr3(s14, sTaos, [',']);
          if g_MySelf <> nil then begin
            case g_MySelf.m_btJob of
              0: sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWar);
              1: sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWizard);
              2: sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sTaos);
            else sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
            end;
          end else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
        end else
        if CompareLStr(sLabel, VAR_BSEX, Length(VAR_BSEX)) then begin
          ArrestStringEx(sLabel, '(', ')', s14);
          s14 := GetValidStr3(s14, sMan, [',']);
          s14 := GetValidStr3(s14, sWoMan, [',']);
          if g_MySelf <> nil then begin
            case g_MySelf.m_btSex of
              0: sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sMan);
              1: sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWoMan);
            else sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
            end;
          end else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
        end else
        if CompareLStr(sLabel, VAR_BJS, Length(VAR_BJS)) then begin
          ArrestStringEx(sLabel, '(', ')', s14);
          s14 := GetValidStr3(s14, sWar, [',']);
          s14 := GetValidStr3(s14, sWizard, [',']);
          s14 := GetValidStr3(s14, sTaos, [',']);
          s14 := GetValidStr3(s14, sWar_W, [',']);
          s14 := GetValidStr3(s14, sWizard_W, [',']);
          s14 := GetValidStr3(s14, sTaos_W, [',']);
          if g_MySelf <> nil then begin
            case g_MySelf.m_btJob of
              0: begin
                  if g_MySelf.m_btSex = 0 then
                    sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWar)
                  else
                    sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWar_W);
                end;
              1: begin
                  if g_MySelf.m_btSex = 0 then
                    sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWizard)
                  else
                    sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWizard_W);
                end;
              2: begin
                  if g_MySelf.m_btSex = 0 then
                    sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sTaos)
                  else
                    sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sTaos_W);
                end
            else sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
            end;
          end else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
        end else
        if CompareLStr(sLabel, VAR_FLAG, Length(VAR_FLAG)) then begin
          ArrestStringEx(sLabel, '(', ')', s14);
          s14 := GetValidStr3(s14, sWar, [',']);
          s14 := GetValidStr3(s14, sWizard, [',']);
          s14 := GetValidStr3(s14, sTaos, [',']);
          n14 := StrToIntDef(sWar, -1);
          if GetMissionFlagStatus(n14) = 0 then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWizard)
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sTaos);
        end else
        if sLabel = VAR_KILLMON1 then begin
          if ClientMissionInfo <> nil then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', IntToStr(ClientMissionInfo.MissionInfo.btKillCount1))
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '0');
        end else
        if sLabel = VAR_KILLMON2 then begin
          if ClientMissionInfo <> nil then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', IntToStr(ClientMissionInfo.MissionInfo.btKillCount2))
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '0');
        end else
        if sLabel = VAR_MAXKILLMON1 then begin
          if (ClientMissionInfo <> nil) and (ClientMissionInfo.ClientMission <> nil) then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', IntToStr(ClientMissionInfo.ClientMission.btKillCount1))
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '0');
        end else
        if sLabel = VAR_MAXKILLMON2 then begin
          if (ClientMissionInfo <> nil) and (ClientMissionInfo.ClientMission <> nil) then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', IntToStr(ClientMissionInfo.ClientMission.btKillCount2))
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '0');
        end else
        if sLabel = VAR_ITEMCOUNT1 then begin
          if ClientMissionInfo <> nil then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', IntToStr(ClientMissionInfo.nItemCount1))
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '0');
        end else
        if sLabel = VAR_ITEMCOUNT2 then begin
          if ClientMissionInfo <> nil then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', IntToStr(ClientMissionInfo.nItemCount2))
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '0');
        end else
        if sLabel = VAR_ITEMCOUNT3 then begin
          if ClientMissionInfo <> nil then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', IntToStr(ClientMissionInfo.nItemCount3))
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '0');
        end else
        if sLabel = VAR_MAXITEMCOUNT1 then begin
          if (ClientMissionInfo <> nil) and (ClientMissionInfo.ClientMission <> nil) then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', IntToStr(ClientMissionInfo.ClientMission.CompleteItem[0].wItemCount))
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '0');
        end else
        if sLabel = VAR_MAXITEMCOUNT2 then begin
          if (ClientMissionInfo <> nil) and (ClientMissionInfo.ClientMission <> nil) then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', IntToStr(ClientMissionInfo.ClientMission.CompleteItem[1].wItemCount))
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '0');
        end else
        if sLabel = VAR_MAXITEMCOUNT3 then begin
          if (ClientMissionInfo <> nil) and (ClientMissionInfo.ClientMission <> nil) then
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', IntToStr(ClientMissionInfo.ClientMission.CompleteItem[2].wItemCount))
          else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '0');
        end else
        if CompareLStr(sLabel, VAR_CMON1, Length(VAR_CMON1)) then begin
          ArrestStringEx(sLabel, '(', ')', s14);
          s14 := GetValidStr3(s14, sMan, [',']);
          s14 := GetValidStr3(s14, sWoMan, [',']);
          if ClientMissionInfo <> nil then begin
            if ClientMissionInfo.MissionInfo.btKillCount1 >= ClientMissionInfo.ClientMission.btKillCount1 then
              sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sMan)
            else
              sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWoMan);
          end else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
        end else
        if CompareLStr(sLabel, VAR_CMON2, Length(VAR_CMON2)) then begin
          ArrestStringEx(sLabel, '(', ')', s14);
          s14 := GetValidStr3(s14, sMan, [',']);
          s14 := GetValidStr3(s14, sWoMan, [',']);
          if ClientMissionInfo <> nil then begin
            if ClientMissionInfo.MissionInfo.btKillCount2 >= ClientMissionInfo.ClientMission.btKillCount2 then
              sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sMan)
            else
              sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWoMan);
          end else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
        end else
        if CompareLStr(sLabel, VAR_CITEM1, Length(VAR_CITEM1)) then begin
          ArrestStringEx(sLabel, '(', ')', s14);
          s14 := GetValidStr3(s14, sMan, [',']);
          s14 := GetValidStr3(s14, sWoMan, [',']);
          if ClientMissionInfo <> nil then begin
            if ClientMissionInfo.nItemCount1 >= ClientMissionInfo.ClientMission.CompleteItem[0].wItemCount then
              sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sMan)
            else
              sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWoMan);
          end else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
        end else
        if CompareLStr(sLabel, VAR_CITEM2, Length(VAR_CITEM2)) then begin
          ArrestStringEx(sLabel, '(', ')', s14);
          s14 := GetValidStr3(s14, sMan, [',']);
          s14 := GetValidStr3(s14, sWoMan, [',']);
          if ClientMissionInfo <> nil then begin
            if ClientMissionInfo.nItemCount2 >= ClientMissionInfo.ClientMission.CompleteItem[1].wItemCount then
              sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sMan)
            else
              sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWoMan);
          end else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
        end else
        if CompareLStr(sLabel, VAR_CITEM3, Length(VAR_CITEM3)) then begin
          ArrestStringEx(sLabel, '(', ')', s14);
          s14 := GetValidStr3(s14, sMan, [',']);
          s14 := GetValidStr3(s14, sWoMan, [',']);
          if ClientMissionInfo <> nil then begin
            if ClientMissionInfo.nItemCount3 >= ClientMissionInfo.ClientMission.CompleteItem[2].wItemCount then
              sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sMan)
            else
              sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sWoMan);
          end else
            sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
        end;
      end;
    end else break;
    Inc(nC);
    if nC >= 100 then break;
  end;
  sMsg := AnsiReplaceText(sMsg, '#60', '<');
  Result := AnsiReplaceText(sMsg, '#62', '>');
end;

function GetDefMagicIcon(Mag: pTClientDefMagic): TDXTexture;
begin
  case Mag.Magic.wMagicId of
    36: Result := g_WDefMagIconImages.Images[78];
    38: Result := g_WDefMagIconImages.Images[8];
    41: Result := g_WDefMagIconImages.Images[70];
    42: Result := g_WDefMagIcon2Images.Images[594];
    43: Result := g_WDefMagIconImages.Images[66];
    44: Result := g_WDefMagIconImages.Images[78];
    45: Result := g_WDefMagIconImages.Images[68];
    47: Result := g_WDefMagIconImages.Images[90];
    48: Result := g_WDefMagIconImages.Images[72];
    50: Result := g_WDefMagIconImages.Images[80];
    52: Result := g_WDefMagIconImages.Images[92];
    53: Result := g_WDefMagIconImages.Images[96];
    55: Result := g_WDefMagIconImages.Images[68];
    56: Result := g_WDefMagIconImages.Images[106];
    57: Result := g_WDefMagIconImages.Images[102];
    58: Result := g_WDefMagIconImages.Images[100];
    60: Result := g_WDefMagIconImages.Images[54];
    62: Result := g_WDefMagIconImages.Images[54];
    63: Result := g_WDefMagIconImages.Images[84];
    64: Result := g_WDefMagIconImages.Images[100];
    65: Result := g_WDefMagIconImages.Images[82];
    66: Result := g_WDefMagIcon2Images.Images[590];
    67: Result := g_WDefMagIcon2Images.Images[588];
    70: Result := g_WDefMagIcon2Images.Images[584];
    71: Result := g_WDefMagIcon2Images.Images[582];
    72: Result := g_WDefMagIcon2Images.Images[586];
    100: Result := g_WMain99Images.Images[1870];
    110: Result := g_WMain99Images.Images[1956];
    111: Result := g_WMain99Images.Images[1954];
    112: Result := g_WMain99Images.Images[1960];
    113: Result := g_WMain99Images.Images[1958];
    114: Result := g_WMain99Images.Images[1948];
    115: Result := g_WMain99Images.Images[1946];
    116: Result := g_WMain99Images.Images[1950];
    117: Result := g_WMain99Images.Images[1944];
    118: Result := g_WMain99Images.Images[1938];
    119: Result := g_WMain99Images.Images[1940];
    120: Result := g_WMain99Images.Images[1936];
    121: Result := g_WMain99Images.Images[1934];
    122: Result := g_WDefMagIconImages.Images[94];
    123: Result := g_WDefMagIconImages.Images[90];
    124: Result := g_WDefMagIconImages.Images[110];
    else Result := g_WDefMagIconImages.Images[Mag.Magic.btEffect * 2];
  end;
end;

function GAMERSADecodeString(sMsg: string): string;
begin
  Try
    Result := GAMERSA.DecryptStr(sMsg);
  Except
    Result := '';
  End;
end;

function GAMERSAEncodeString(sMsg: string): string;
begin
  Try
    Result := GAMERSA.EncryptStr(sMsg);
  Except
    Result := '';
  End;
end;


function HTTPDecode(const AStr: String): String;
var
  Sp, Rp, Cp: PChar;
  S: String;
begin
  SetLength(Result, Length(AStr));
  Sp := PChar(AStr);
  Rp := PChar(Result);
//  Cp := Sp;
  try
    while Sp^ <> #0 do
    begin
      case Sp^ of
        '+': Rp^ := ' ';
        '%': begin
               // Look for an escaped % (%%) or %<hex> encoded character
               Inc(Sp);
               if Sp^ = '%' then
                 Rp^ := '%'
               else
               begin
                 Cp := Sp;
                 Inc(Sp);
                 if (Cp^ <> #0) and (Sp^ <> #0) then
                 begin
                   S := '$' + Cp^ + Sp^;
                   Rp^ := Chr(StrToInt(S));
                 end
                 else
                   raise Exception.CreateFmt('Error decoding URL style (%%XX) encoded string at position %d', [Cp - PChar(AStr)]);
               end;
             end;
      else
        Rp^ := Sp^;
      end;
      Inc(Rp);
      Inc(Sp);
    end;
  except
  end;
  SetLength(Result, Rp - PChar(Result));
end;

function HTTPEncode(const AStr: String): String;
// The NoConversion set contains characters as specificed in RFC 1738 and
// should not be modified unless the standard changes.
const
  NoConversion = ['A'..'Z','a'..'z','*','@','.','_','-',
                  '0'..'9','$','!','''','(',')'];
var
  Sp, Rp: PChar;
begin
  SetLength(Result, Length(AStr) * 3);
  Sp := PChar(AStr);
  Rp := PChar(Result);
  while Sp^ <> #0 do
  begin
    if Sp^ in NoConversion then
      Rp^ := Sp^
    else
      if Sp^ = ' ' then
        Rp^ := '+'
      else
      begin
        FormatBuf(Rp^, 3, '%%%.2x', 6, [Ord(Sp^)]);
        Inc(Rp,2);
      end;
    Inc(Rp);
    Inc(Sp);
  end;
  SetLength(Result, Rp - PChar(Result));
end;



initialization
begin
  g_MissionList := TList.Create;
  g_MissionInfoList := TList.Create;
  g_OperateHintList := TStringList.Create;
  g_FilterMsgList := TStringList.Create;
  g_CenterMsgList := TList.Create;
  g_StatusInfoList := TList.Create;
  GAMERSA := TRSA.Create(nil);
  GAMERSA.Server := False;
  GAMERSA.CommonalityKey := IntToStr(203643379);
  GAMERSA.CommonalityMode := IntToStr(317412961) + IntToStr(797764302) + IntToStr(7182567) + IntToStr(61869);
end;

finalization
begin
  g_StatusInfoList.Free;
  g_MissionList.Free;
  g_MissionInfoList.Free;
  g_OperateHintList.Free;
  g_FilterMsgList.Free;
  g_CenterMsgList.Free;
  GAMERSA.Free;
end;

end.

