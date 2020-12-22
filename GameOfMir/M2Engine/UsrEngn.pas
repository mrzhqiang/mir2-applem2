unit UsrEngn;

interface
uses
  Windows, Classes, SysUtils, StrUtils, Forms, ObjBase, ObjPlay, ObjNpc, Envir, Grobal2, SDK, RSA;
type

  TProcessUserMessage = procedure(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; sMsg: string) of object;



  TMapMonGenCount = record
    sMapName: string[14];
    nMonGenCount: Integer;
    dwNotHumTimeTick: LongWord;
    nClearCount: Integer;
    boNotHum: Boolean;
    dwMakeMonGenTimeTick: LongWord;
    nMonGenRate: Integer; //刷怪倍数  10
    dwRegenMonstersTime: LongWord; //刷怪速度    200
  end;
  pTMapMonGenCount = ^TMapMonGenCount;

  TUserEngine = class
    m_LoadPlaySection: TRTLCriticalSection;
    m_LoadPlayList: TStringList; //从DB读取人物数据
{$IF Public_Ver = Public_Test}
    m_TestObjectList: TStringList;
{$ELSE}
    m_PlayObjectList: TStringList; //0x8
{$IFEND}
//    m_StringList_0C: TStringList;
    m_PlayObjectFreeList: TList; //0x10
    m_OffLineList: TGStringList; //挂机列表
    //    m_SendDBList: TList; //0x14
    dwShowOnlineTick: LongWord; //0x18
    dwSendOnlineHumTime: LongWord; //0x1C
    dwProcessMapDoorTick: LongWord; //0x20
    dwProcessMissionsTime: LongWord; //0x24
    dwRegenMonstersTick: LongWord; //0x28
    dwProcessGetSortTick: LongWord;
    dwProcessGetSortIndex: Integer;
    CalceTime: LongWord; //0x2C
    m_dwProcessLoadPlayTick: LongWord; //0x30
    dwTime_34: LongWord; //0x34
    m_nCurrMonGen: Integer; //0x38
    m_nMonGenListPosition: Integer; //0x3C
    m_nMonGenCertListPosition: Integer; //0x40
    m_nProcHumIDx: Integer;
    //0x44 处理人物开始索引（每次处理人物数限制）
    nProcessHumanLoopTime: Integer;
    nMerchantPosition: Integer; //0x4C
    nNpcPosition: Integer; //0x50
    StdItemList: TList; //List_54
    StdItemLimitList: TList;
    MonsterList: TList; //List_58
    m_MonGenList: TList; //List_5C
    m_MonFreeList: TList;
    m_MagicArr: array[0..SKILL_MAX] of TMagic;
    //m_MapMonGenCountList: TList;
    m_AdminList: TGList; //List_64
    m_MerchantList: TGList; //List_68
    QuestNPCList: TList; //0x6C
    m_DefiniensConst: TStringList;
    m_RandomMapGateList: TList;
    List_70: TList;
    //    m_ChangeServerList: TList;
    m_MagicEventList: TList;
    m_PlayObjectLevelList: TList; //人物排行 等级

    nMonsterCount: Integer; //怪物总数
    nMonsterProcessPostion: Integer;
    //0x80处理怪物总数位置，用于计算怪物总数
    n84: Integer;
    nMonsterProcessCount: Integer;
    //0x88处理怪物数，用于统计处理怪物个数
    boItemEvent: Boolean; //ItemEvent
    n90: Integer;
    dwProcessMonstersTick: LongWord;
    dwProcessMerchantTimeMin: Integer;
    dwProcessMerchantTimeMax: Integer;
    dwProcessNpcTimeMin: LongWord;
    dwProcessNpcTimeMax: LongWord;
    m_NewHumanList: TList;
    m_ListOfGateIdx: TList;
    m_ListOfSocket: TList;
    //OldMagicList: TList;
    //    m_nLimitUserCount: Integer; //限制用户数
    //    m_nLimitNumber: Integer; //限制使用天数或次数
    //m_boStartLoadMagic: Boolean;
    dwSaveDataTick: LongWord;
    m_dwSearchTick: LongWord;
    m_dwGetTodyDayDateTick: LongWord;
    m_TodayDate: TDateTime;
    m_CheckOffLineTick: LongWord;
  private
    FProcessUserMessage: array[RG_MINMSGINDEX..RG_MAXMSGINDEX] of TProcessUserMessage;
{$IF Public_Ver = Public_Test}
    FObject1: TPlayObject;
    FObject2: TPlayObject;
    FObject3: TPlayObject;
    FObject4: TPlayObject;
    FObject5: TPlayObject;
    FObject6: TPlayObject;
    FObject7: TPlayObject;
    FObject8: TPlayObject;
    FObject9: TPlayObject;
    FObject10: TPlayObject;
{$IFEND}
    procedure ProcessSpell(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; sMsg: string);
    procedure ProcessQueryUserName(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; sMsg: string);
    procedure ProcessMessage1(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; sMsg: string);
    procedure ProcessMessageMove(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; sMsg: string);
    procedure ProcessMessageSay(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; sMsg: string);
    procedure ProcessHumans();
    procedure ProcessMonsters();
    procedure ProcessMerchants();
    procedure ProcessNpcs();
    procedure ProcessMissions();
    procedure Process4AECFC();
    procedure ProcessEvents();
    procedure ProcessMapDoor();
    procedure ProcessFBMap();
    procedure ProcessRandomMapGate();
    procedure ProcessMapObjectCount();
    procedure NPCinitialize;
    procedure MerchantInitialize;


    function CanAddObject: Boolean;
{$IF Public_Ver = Public_Test}
    procedure AddObject(sChrName: string; PlayObject: TPlayObject);
    procedure DelObject(PlayObject: TPlayObject);
{$IFEND}
    //    procedure WriteShiftUserData;
    function GetGenMonCount(MonGen: pTMonGenInfo): Integer;
    function AddBaseObject(Envir:TEnvirnoment; nX, nY: Integer; nMonRace: Integer; sMonName: string): TBaseObject;
    //function AddPlayObject(PlayObject: TPlayObject; nX, nY: Integer; sMonName: string): TBaseObject; //创建分身

//    procedure GenShiftUserData();
    procedure KickOnlineUser(sChrName: string);
    //function SendSwitchData(PlayObject: TPlayObject; nServerIndex: Integer): Boolean;
    //procedure SendChangeServer(PlayObject: TPlayObject; nServerIndex: Integer);

    procedure AddToHumanFreeList(PlayObject: TPlayObject);

    procedure GetHumData(PlayObject: TPlayObject; var HumanRcd: THumDataInfo);
    function GetHomeInfo(var nX: Integer; var nY: Integer): string;
    function GetRandHomeX(PlayObject: TPlayObject): Integer;
    function GetRandHomeY(PlayObject: TPlayObject): Integer;
    //    function GetSwitchData(sChrName: string; nCode: Integer): pTSwitchDataInfo;
    //procedure LoadSwitchData(SwitchData: pTSwitchDataInfo; var PlayObject: TPlayObject);
    //procedure DelSwitchData(SwitchData: pTSwitchDataInfo);
    function MonInitialize(BaseObject: TBaseObject; sMonName: string): TList;
    //    function MapRageHuman(sMapName: string; nMapX, nMapY, nRage: Integer): Boolean;
    function GetOnlineHumCount(): Integer;
    function GetUserCount(): Integer;
    function GetLoadPlayCount(): Integer;
    function GetOffLinePlayCount: Integer;
{$IF Public_Ver = Public_Test}
    function GetPlayObjectList: TStringList;
{$IFEND}
    //function GetAutoAddExpPlayCount: Integer;

  public
    constructor Create();
    destructor Destroy; override;
    procedure Initialize();
    procedure MonGenInitialize;
    function GetDefiniensConstText(sMsg: string): string;
    //procedure ClearItemList(); virtual;
    //procedure SwitchMagicList();
    function RegenMonsters(MonGen: pTMonGenInfo; nCount: Integer; boTick: Boolean = True): Boolean;
    procedure Run();
    procedure PrcocessData();
    procedure SaveHumanRcd(PlayObject: TPlayObject);
    //procedure SetSortList(nIdx: Integer; sMsg: string);
    function MonGetRandomItems(mon: TBaseObject; ItemList: TList): Integer;
    procedure Execute;
    function RegenMonsterByName(sMAP: string; nX, nY: Integer; sMonName: string): TBaseObject; overload;
    function RegenMonsterByName(Envir: TEnvirnoment; nX, nY: Integer; sMonName: string): TBaseObject; overload;
    function GetStdItemLimit(nItemIdx: Integer): pTStdItemLimit;
    function GetStdItem(nItemIdx: Integer): pTStdItem; overload;
    function GetStdItem(sItemName: string): pTStdItem; overload;
    function GetStdItemRule(nItemIdx: Integer): pTItemRule; overload;
    function GetStdItemRule(sItemName: string): pTItemRule; overload;
    function GetStdItemWeight(nItemIdx: Integer): Integer;
    function GetStdItemName(nItemIdx: Integer): string;
    function GetStdItemMode(nItemIdx: Integer): TStdMode;
    function GetStdItemModeEx(nItemIdx: Integer): TStdModeEx;
    function GetStdItemIdx(sItemName: string): Integer;
    function MakeClientItem(UserItem: pTUserItem): string;
    //function FindOtherServerUser(sName: string; var nServerIndex): Boolean;
    procedure CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY, nWide: Integer; sMsg: string);
    procedure ProcessUserMessage(PlayObject: TPlayObject; DefMsg:
      pTDefaultMessage; Buff: PChar);
    //procedure SendServerGroupMsg(nCode, nServerIdx: Integer; sMsg: string);
    function GetMonRace(sMonName: string): Integer;
    function InsMonstersList(MonGen: pTMonGenInfo; Monster: TAnimalObject): Boolean;
    function GetPlayObject(sName: string): TPlayObject; overload;
    function GetPlayObject(PlayObject: TPlayObject): TPlayObject; overload;
    function GetCheckPlayObject: TPlayObject;
    function GetPlayObjectEx(sAccount, sName: string): TPlayObject;
    function InPlayObjectList(PlayObject: TPlayObject): Boolean;
    procedure KickPlayObjectEx(sAccount, sName: string);
    function FindMerchant(Merchant: TObject): TMerchant;
    function FindNPC(GuildOfficial: TObject): TGuildOfficial;
    function InMerchantList(Merchant: TMerchant): Boolean;
    function InQuestNPCList(NPC: TNormNpc): Boolean;
    function CopyToUserItemFromIdx(nIdx: Integer; Item: pTUserItem): Boolean;
    function CopyToUserItemFromIdxEx(nIdx: Integer; Item: pTUserItem): Boolean;
    function CopyToUserItemFromName(sItemName: string; Item: pTUserItem): Boolean;
    function CopyToUserItemFromNameEx(sItemName: string; Item: pTUserItem; boWuXin: Boolean = False): Boolean;
    function GetMapOfRangeHumanCount(Envir: TEnvirnoment; nX, nY, nRange: Integer): Integer;
    function GetHumPermission(sUserName: string; var sIPaddr: string; var btPermission: Byte): Boolean;
    procedure AddUserOpenInfo(UserOpenInfo: pTUserOpenInfo);
    //procedure AddSendDBInfo(SendDBSInfo: pTSendDBSInfo);
    //procedure RandomUpgradeItem(Item: pTUserItem);
    //procedure GetUnknowItemValue(Item: pTUserItem);
    function OpenDoor(Envir: TEnvirnoment; nX, nY: Integer): Boolean;
    function CloseDoor(Envir: TEnvirnoment; Door: pTDoorInfo): Boolean;
    procedure SendDoorStatus(Envir: TEnvirnoment; nX, nY: Integer; wIdent, wX:
      Word; nDoorX, nDoorY, nA: Integer; sStr: string);
    function FindMagic(sMagicName: string): pTMagic; overload;
    function FindMagic(nMagIdx: Integer): pTMagic; overload;
    //function AddMagic(Magic: pTMagic): Boolean;
    //function DelMagic(wMagicId: Word): Boolean;
    procedure AddMerchant(Merchant: TMerchant);
    function GetMerchantList(Envir: TEnvirnoment; nX, nY, nRange: Integer;
      TmpList: TList): Integer;
    function GetNpcList(Envir: TEnvirnoment; nX, nY, nRange: Integer; TmpList:
      TList): Integer;
    procedure ReloadMerchantList();
    procedure ReloadNpcList();
    //procedure HumanExpire(sAccount: string);
    function GetMapMonster(Envir: TEnvirnoment; List: TList): Integer; overload;
    function GetMapMonster(sMonName: string; Envir: TEnvirnoment; List: TList): Integer; overload;
    function GetMapRangeMonster(Envir: TEnvirnoment; nX, nY, nRange: Integer; List: TList): Integer;
    function GetMapHuman(sMapName: string): Integer;
    function GetMapRageHuman(Envir: TEnvirnoment; nRageX, nRageY, nRage: Integer; List: TList): Integer;

    procedure SendBroadFilterInfo();
    procedure SendBroadBugleMsg(sMsg: string);
    procedure SendBroadCastMsg(sMsg: string; MsgType: TMsgType);
    procedure SendBroadTopMsg(sMsg: string);
    procedure SendMapBroadCastMsg(Envir: TEnvirnoment; sMsg: string; MsgType: TMsgType);
    procedure SendBroadCastMsgExt(sMsg: string; MsgType: TMsgType);
    procedure SendBroadCastMsgDelay(sMsg: string; MsgType: TMsgType; dwDelay: LongWord; BaseObject: TBaseObject = nil);
    //procedure sub_4AE514(GoldChangeInfo: pTGoldChangeInfo);
    procedure ClearMonSayMsg();
    procedure SendQuestMsg(sQuestName: string);
    procedure ClearMerchantData();
    procedure AddOffLine(PlayObject: TPlayObject);
    procedure DelOffLineByName(sUserName: string);
    procedure DelOffLineByID(sAccount: string);
    function GetOffLine(sUserName: string): TPlayObject;
    procedure DeleteOffLine(PlayObject: TPlayObject);
    procedure KickAllOffLine();
    //function GetMapMonGenCount(sMapName: string): pTMapMonGenCount;
    //function AddMapMonGenCount(sMapName: string; nMonGenCount: Integer): Integer;
    function ClearMonsters(sMapName: string): Boolean;

    property MonsterCount: Integer read nMonsterCount;
    property OnlinePlayCount: Integer read GetOnlineHumCount;
    property PlayObjectCount: Integer read GetUserCount;
    //property AutoAddExpPlayCount: Integer read GetAutoAddExpPlayCount;
    property LoadPlayCount: Integer read GetLoadPlayCount;
    property OffLinePlayCount: Integer read GetOffLinePlayCount;
{$IF Public_Ver = Public_Test}
    property m_PlayObjectList: TStringList read GetPlayObjectList;
{$IFEND}
  end;


var
  g_dwEngineTick: LongWord;
  g_dwEngineRunTime: LongWord;
  g_DESPassword: TStringList;
  g_sDESPassword: string;
  g_FilePassword: string;
  g_boRemoteOpenGateSocketed: Boolean = False;
{$IF Public_Ver = Public_Release}
  g_ADNoticeList: TStringList;
  g_ADExitUrlList: TStringList;
  g_ADFrameUrlList: TStringList;
  g_ADRSA: TRSA;

  procedure RegDll_OutMessage(Msg: PChar; nMode: Integer); stdcall;
  procedure RegDll_OKProc(); stdcall;
{$IFEND}
implementation

uses IdSrvClient, Guild, ObjMon, EDcodeEx, ObjGuard, ObjAxeMon, M2Share, OjbKindMon, RegDllFile,  
  ObjMon2, Event, {InterMsgClient, InterServerMsg, }ObjRobot, HUtil32, svMain, DateUtils, MD5Unit, 
  Castle, {$IFDEF PLUGOPEN}PlugOfEngine,{$ENDIF}  Common, ObjMon3, ItmUnit;
{ TUserEngine }

{$IF Public_Ver = Public_Release}
procedure RegDll_OutMessage(Msg: PChar; nMode: Integer); stdcall;
begin
  MainOutMessage(Msg);
end;

procedure RegDll_OKProc(); stdcall;
var
  I: Integer;
  sStr, sTime, sW, sY: string;
  nTime, nW, nY: Integer;
  DESPassword: string;
begin
  g_DESPassword.Clear;
  DESPassword := RegDll_Common();
  g_sDESPassword := DESPassword;
  while True do begin
    if DESPassword = '' then Break;
    DESPassword := GetValidStr3(DESPassword, sStr, ['|']);
    if sStr = '' then Break;
    g_DESPassword.Add(sStr);
  end;
  //g_DESPassword := RegDll_Common();
  g_FilePassword := RegDll_Quest();
  g_ADNoticeList.SetText(PChar(g_ADRSA.DecryptStr(RegDll_TextList())));
  g_ADExitUrlList.SetText(PChar(g_ADRSA.DecryptStr(RegDll_Address())));
  g_ADFrameUrlList.SetText(PChar(g_ADRSA.DecryptStr(RegDll_LogoList())));
  for I := g_ADNoticeList.Count - 1 downto 0 do begin
    sStr := Trim(g_ADNoticeList[I]);
    if sStr <> '' then begin
      sStr := GetValidStr3(sStr, sTime, [',', ' ', #9]);
      nTime := StrToIntDef(sTime, -1);
      if (nTime > 0) and (sStr <> '') then begin
        g_ADNoticeList.Strings[I] := sStr;
        g_ADNoticeList.Objects[I] := TObject(nTime);
        Continue;
      end;
    end;
    g_ADNoticeList.Delete(I);
  end;
  for I := g_ADExitUrlList.Count - 1 downto 0 do begin
    sStr := Trim(g_ADExitUrlList[I]);
    if sStr = '' then
      g_ADExitUrlList.Delete(I);
  end;
  for I := g_ADFrameUrlList.Count - 1 downto 0 do begin
    sStr := Trim(g_ADFrameUrlList[I]);
    if sStr <> '' then begin
      sStr := GetValidStr3(sStr, sW, [',', ' ', #9]);
      sStr := GetValidStr3(sStr, sY, [',', ' ', #9]);
      nW := StrToIntDef(sW, -1);
      nY := StrToIntDef(sY, -1);
      if (nW > 0) and (nY > 0) and (sStr <> '') then begin
        g_ADFrameUrlList.Strings[I] := sStr;
        g_ADFrameUrlList.Objects[I] := TObject(MakeLong(nW, nY));
        Continue;
      end;
    end;
    g_ADFrameUrlList.Delete(I);
  end;

  g_Config.sIdeSerialNumber := g_FilePassword;
  g_Config.dwFileID := UpperCase(GetMD5TextOf16(g_FilePassword + g_sDESPassword));
  g_boCheckOk := True;
  PostMessage(FrmMain.Handle, WM_RUN_OK, 0, 0);
end;
{$IFEND}

constructor TUserEngine.Create();
begin

  InitializeCriticalSection(m_LoadPlaySection);
  m_LoadPlayList := TStringList.Create;
{$IF Public_Ver = Public_Test}
  m_TestObjectList := TStringList.Create;
  FObject1 := nil;
  FObject2 := nil;
  FObject3 := nil;
  FObject4 := nil;
  FObject5 := nil;
  FObject6 := nil;
  FObject7 := nil;
  FObject8 := nil;
  FObject9 := nil;
  FObject10 := nil;
{$ELSE}
  m_PlayObjectList := TStringList.Create;
{$IFEND}
  //m_StringList_0C := TStringList.Create;
  m_PlayObjectFreeList := TList.Create;
  m_OffLineList := TGStringList.Create;
  //m_SendDBList := TList.Create;
  dwShowOnlineTick := GetTickCount;
  dwSendOnlineHumTime := GetTickCount;
  dwProcessMapDoorTick := GetTickCount;
  dwProcessMissionsTime := GetTickCount;
  dwProcessMonstersTick := GetTickCount;
  dwRegenMonstersTick := GetTickCount;
  m_CheckOffLineTick := GetTickCount;
  m_dwProcessLoadPlayTick := GetTickCount;
  dwSaveDataTick := GetTickCount;
  dwProcessGetSortTick := GetTickCount;
  m_RandomMapGateList := TList.Create;
  dwProcessGetSortIndex := 0;
  dwTime_34 := GetTickCount;
  m_nCurrMonGen := 0;
  m_nMonGenListPosition := 0;
  m_nMonGenCertListPosition := 0;
  m_nProcHumIDx := 0;
  nProcessHumanLoopTime := 0;
  nMerchantPosition := 0;
  nNpcPosition := 0;

  //m_nLimitNumber := 0;
  //m_nLimitUserCount := 0;
  SafeFillChar(m_MagicArr, SizeOf(m_MagicArr), #0);

  StdItemList := TList.Create; //List_54
  StdItemLimitList := TList.Create;
  MonsterList := TList.Create;
  m_MonGenList := TList.Create;
  m_MonFreeList := TList.Create;
  m_AdminList := TGList.Create;
  m_MerchantList := TGList.Create;
  QuestNPCList := TList.Create;
  m_DefiniensConst := TStringList.Create;
  List_70 := TList.Create;
  //m_ChangeServerList := TList.Create;
  m_MagicEventList := TList.Create;
  //m_MapMonGenCountList := TList.Create;
  boItemEvent := False;
  n90 := 1800000;
  dwProcessMerchantTimeMin := 0;
  dwProcessMerchantTimeMax := 0;
  dwProcessNpcTimeMin := 0;
  dwProcessNpcTimeMax := 0;
  m_NewHumanList := TList.Create;
  m_ListOfGateIdx := TList.Create;
  m_ListOfSocket := TList.Create;
  //OldMagicList := TList.Create;
  //m_boStartLoadMagic := False;
  m_dwSearchTick := GetTickCount;
  m_dwGetTodyDayDateTick := GetTickCount;
  m_TodayDate := 0;
  m_PlayObjectLevelList := TList.Create; //人物排行 等级

  SafeFillChar(FProcessUserMessage, SizeOf(FProcessUserMessage), #0);
  FProcessUserMessage[CM_SPELL] := ProcessSpell;
  FProcessUserMessage[CM_QUERYUSERNAME] := ProcessQueryUserName;
  FProcessUserMessage[CM_DROPITEM] := ProcessMessage1;
  FProcessUserMessage[CM_TAKEONITEM] := ProcessMessage1;
  FProcessUserMessage[CM_TAKEOFFITEM] := ProcessMessage1;
  FProcessUserMessage[CM_1005] := ProcessMessage1;
  FProcessUserMessage[CM_MERCHANTDLGSELECT] := ProcessMessage1;
  //FProcessUserMessage[CM_MERCHANTQUERYSELLPRICE] := ProcessMessage1;
  //FProcessUserMessage[CM_USERSELLITEM] := ProcessMessage1;
  //FProcessUserMessage[CM_USERBUYITEM] := ProcessMessage1;
  FProcessUserMessage[CM_CREATEGROUP] := ProcessMessage1;
  FProcessUserMessage[CM_ADDGROUPMEMBER] := ProcessMessage1;
  FProcessUserMessage[CM_DELGROUPMEMBER] := ProcessMessage1;
  FProcessUserMessage[CM_USERREPAIRITEM] := ProcessMessage1;
  //FProcessUserMessage[CM_MERCHANTQUERYREPAIRCOST] := ProcessMessage1;
  FProcessUserMessage[CM_DEALTRY] := ProcessMessage1;
  FProcessUserMessage[CM_DEALADDITEM] := ProcessMessage1;
  FProcessUserMessage[CM_DEALDELITEM] := ProcessMessage1;
  FProcessUserMessage[CM_USERSTORAGEITEM] := ProcessMessage1;
  FProcessUserMessage[CM_USERTAKEBACKSTORAGEITEM] := ProcessMessage1;
  //FProcessUserMessage[CM_USERMAKEDRUGITEM] := ProcessMessage1;
  FProcessUserMessage[CM_GUILDADDMEMBER] := ProcessMessage1;
  FProcessUserMessage[CM_GUILDDELMEMBER] := ProcessMessage1;
  FProcessUserMessage[CM_GUILDUPDATENOTICE] := ProcessMessage1;
  FProcessUserMessage[CM_GUILDUPDATERANKINFO] := ProcessMessage1;

  FProcessUserMessage[CM_TURN] := ProcessMessageMove;
  FProcessUserMessage[CM_WALK] := ProcessMessageMove;
  //FProcessUserMessage[CM_SITDOWN] := ProcessMessageMove;
  FProcessUserMessage[CM_RUN] := ProcessMessageMove;
  FProcessUserMessage[CM_LEAP] := ProcessMessageMove;
  FProcessUserMessage[CM_HIT] := ProcessMessageMove;
  FProcessUserMessage[CM_HEAVYHIT] := ProcessMessageMove;
  FProcessUserMessage[CM_BIGHIT] := ProcessMessageMove;
  FProcessUserMessage[CM_HORSERUN] := ProcessMessageMove;
  FProcessUserMessage[CM_POWERHIT] := ProcessMessageMove;
  FProcessUserMessage[CM_LONGHIT] := ProcessMessageMove;
  FProcessUserMessage[CM_CRSHIT] := ProcessMessageMove;
  FProcessUserMessage[CM_TWNHIT] := ProcessMessageMove;
  FProcessUserMessage[CM_WIDEHIT] := ProcessMessageMove;
  FProcessUserMessage[CM_FIREHIT] := ProcessMessageMove;
  FProcessUserMessage[CM_TWINHIT] := ProcessMessageMove;
  FProcessUserMessage[CM_LONGICEHIT] := ProcessMessageMove;
  FProcessUserMessage[CM_110] := ProcessMessageMove;
  FProcessUserMessage[CM_111] := ProcessMessageMove;
  FProcessUserMessage[CM_112] := ProcessMessageMove;
  FProcessUserMessage[CM_113] := ProcessMessageMove;
  FProcessUserMessage[CM_122] := ProcessMessageMove;
  FProcessUserMessage[CM_56] := ProcessMessageMove;
  FProcessUserMessage[CM_SAY] := ProcessMessageSay;
end;

procedure TUserEngine.DelOffLineByID(sAccount: string);
{var
  I: Integer;     }
begin
 { m_OffLineList.Lock;
  try
    for i := m_OffLineList.Count - 1 downto 0 do begin
      if CompareText(m_OffLineList.Strings[i], sName) = 0 then begin
        m_OffLineList.Delete(I);
        break;
      end;
    end;
  finally
    m_OffLineList.UnLock;
  end; }
end;

procedure TUserEngine.DelOffLineByName(sUserName: string);
var
  I: Integer;
begin
  m_OffLineList.Lock;
  try
    for i := m_OffLineList.Count - 1 downto 0 do begin
      if CompareText(m_OffLineList.Strings[i], sUserName) = 0 then begin
        m_OffLineList.Delete(I);
        break;
      end;
    end;
  finally
    m_OffLineList.UnLock;
  end;
end;

destructor TUserEngine.Destroy;
var
  i: Integer;
  ii: Integer;
  MonInfo: pTMonInfo;
  MonGenInfo: pTMonGenInfo;
  MagicEvent: pTMagicEvent;
  //TmpList: TList;
begin
  for i := 0 to m_LoadPlayList.Count - 1 do begin
    DisPose(pTUserOpenInfo(m_LoadPlayList.Objects[i]));
  end;
  m_LoadPlayList.Free;
{$IF Public_Ver = Public_Test}
  m_TestObjectList.Free;
{$ELSE}
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    TPlayObject(m_PlayObjectList.Objects[i]).Free;
  end;
  m_PlayObjectList.Free;
{$IFEND}
  //m_StringList_0C.Free;

  for i := 0 to m_PlayObjectFreeList.Count - 1 do begin
    TPlayObject(m_PlayObjectFreeList.Items[i]).Free;
  end;
  m_PlayObjectFreeList.Free;

  m_OffLineList.Free;
  m_RandomMapGateList.Free;

  {for i := 0 to m_SendDBList.Count - 1 do begin
    DisPose(pTSendDBSInfo(m_SendDBList.Items[i]));
  end;
  m_SendDBList.Free;    }

  for i := 0 to StdItemList.Count - 1 do begin
    Dispose(pTItemRule(pTStdItem(StdItemList.Items[i]).Rule));
    DisPose(pTStdItem(StdItemList.Items[i]));
  end;
  StdItemList.Free;

  for i := 0 to StdItemLimitList.Count - 1 do begin
    DisPose(pTStdItemLimit(StdItemLimitList.Items[i]));
  end;
  StdItemLimitList.Free;

  for i := 0 to MonsterList.Count - 1 do begin
    MonInfo := MonsterList.Items[i];
    if MonInfo.ItemList <> nil then begin
      for ii := 0 to MonInfo.ItemList.Count - 1 do begin
        DisPose(pTMonItemInfo(MonInfo.ItemList.Items[ii]));
      end;
      MonInfo.ItemList.Free;
    end;
    DisPose(MonInfo);
  end;
  MonsterList.Free;

  for i := 0 to m_MonGenList.Count - 1 do begin
    MonGenInfo := m_MonGenList.Items[i];
    for ii := 0 to MonGenInfo.CertList.Count - 1 do begin
      TBaseObject(MonGenInfo.CertList.Items[ii]).Free;
    end;
    DisPose(pTMonGenInfo(m_MonGenList.Items[i]));
  end;
  m_MonGenList.Free;

  for i := 0 to m_MonFreeList.Count - 1 do begin
    TBaseObject(m_MonFreeList.Items[i]).Free;
  end;
  m_MonFreeList.Free;

  m_AdminList.Free;
  for i := 0 to m_MerchantList.Count - 1 do begin
    TMerchant(m_MerchantList.Items[i]).Free;
  end;
  m_MerchantList.Free;
  for i := 0 to QuestNPCList.Count - 1 do begin
    TNormNpc(QuestNPCList.Items[i]).Free;
  end;
  for I := 0 to m_DefiniensConst.Count - 1 do begin
    Dispose(PString(m_DefiniensConst.Objects[I]));
  end;
  QuestNPCList.Free;
  List_70.Free;
  m_DefiniensConst.Free;
  {for i := 0 to m_ChangeServerList.Count - 1 do begin
    DisPose(pTSwitchDataInfo(m_ChangeServerList.Items[i]));
  end;
  m_ChangeServerList.Free;   }
  for i := 0 to m_MagicEventList.Count - 1 do begin
    MagicEvent := m_MagicEventList.Items[i];
    if MagicEvent.BaseObjectList <> nil then
      MagicEvent.BaseObjectList.Free;

    DisPose(MagicEvent);
  end;
  m_MagicEventList.Free;
  m_NewHumanList.Free;
  m_ListOfGateIdx.Free;
  m_ListOfSocket.Free;
  {for i := 0 to OldMagicList.Count - 1 do begin
    TmpList := TList(OldMagicList.Items[i]);
    for ii := 0 to TmpList.Count - 1 do begin
      DisPose(pTMagic(TmpList.Items[ii]));
    end;
    TmpList.Free;
  end;  }
  {for i := 0 to m_MapMonGenCountList.Count - 1 do begin
    DisPose(pTMapMonGenCount(m_MapMonGenCountList.Items[i]));
  end;
  m_MapMonGenCountList.Free;     }
  //OldMagicList.Free;
  m_PlayObjectLevelList.Free; //人物排行 等级

  DeleteCriticalSection(m_LoadPlaySection);
  inherited;
end;

procedure TUserEngine.Initialize;
begin
  MerchantInitialize();
  NPCinitialize();
  RobotManage.LoadRobot;
  DLL_Encode6BitBuf := nil;
  //DLL_Decode6BitBuf := nil;
end;

function TUserEngine.GetMonRace(sMonName: string): Integer;
var
  i: Integer;
  MonInfo: pTMonInfo;
begin
  Result := -1;
  for i := 0 to MonsterList.Count - 1 do begin
    MonInfo := MonsterList.Items[i];
    if MonInfo <> nil then begin
      if CompareText(MonInfo.sName, sMonName) = 0 then begin
        Result := MonInfo.btRace;
        break;
      end;
    end;
  end;
end;

function TUserEngine.MakeClientItem(UserItem: pTUserItem): string;
var
  Stditem: pTStdItem;
begin
  Result := '';
  Stditem := GetStdItem(UserItem.wIndex);
  if Stditem <> nil then
  begin
    if Stditem.StdMode = tm_House then
      Result := EncodeBuffer(@(UserItem^), SizeOf(TUserItem))
    else if (sm_ArmingStrong in Stditem.StdModeEx) or (sm_HorseArm in Stditem.StdModeEx) or ((Stditem.StdMode = tm_Reel) and (Stditem.Shape = 13) and UserItem.Value.boBind) then
      Result := EncodeBuffer(@(UserItem^), SizeOf(TMakeItemUserItem))
    else
      Result := EncodeBuffer(@(UserItem^), SizeOf(TMakeItemUserItem) - SizeOf(TUserItemValue) - SizeOf(Byte));
  end;
end;

procedure TUserEngine.MerchantInitialize;
var
  i, nIndex: Integer;
  Merchant: TMerchant;
  sCaption: string;
begin
  sCaption := FrmMain.Caption;
  m_MerchantList.Lock;
  try
    for i := m_MerchantList.Count - 1 downto 0 do begin
      Merchant := TMerchant(m_MerchantList.Items[i]);
      if Merchant <> nil then begin
        Merchant.m_PEnvir := g_MapManager.FindMap(Merchant.m_sMapName);
        if Merchant.m_PEnvir <> nil then begin
          Merchant.Initialize; //FFFE
          if Merchant.m_boAddtoMapSuccess and (not Merchant.m_boIsHide) then begin
            MainOutMessage(Merchant.m_sCharName + '交易NPC初始化失败... ');
            m_MerchantList.Delete(i);
            Merchant.Free;
          end
          else begin
            Merchant.LoadNpcScript();
            Merchant.LoadNPCData();
            nIndex := Merchant.GetScriptIndex('~Initialize');
            if nIndex > -1 then
              Merchant.GotoLable(SystemObject, nIndex, False, '');
          end;
        end
        else begin
          MainOutMessage(Merchant.m_sCharName + '交易NPC初始化失败... (m.PEnvir=nil)');
          m_MerchantList.Delete(i);
          Merchant.Free;
        end;
        FrmMain.Caption := sCaption + '[正在初始化交易NPC(' + IntToStr(m_MerchantList.Count) + '/' + IntToStr(m_MerchantList.Count - i) + ')]';
        Application.ProcessMessages;
      end;
    end;
  finally
    FrmMain.Caption := sCaption;
    m_MerchantList.UnLock;
  end;
end;

procedure TUserEngine.MonGenInitialize;
var
  MonGenInfo: pTMonGenInfo;
  I: Integer;
begin
  for I := 0 to m_MonGenList.Count - 1 do begin
    MonGenInfo := m_MonGenList[I];
    if (MonGenInfo <> nil) and (MonGenInfo.Envir <> nil) and (not MonGenInfo.Envir.m_boFB) then begin
      if MonGenInfo.sMakeScript <> '' then
        MonGenInfo.nMakeScript := g_FunctionNPC.GetScriptIndex(MonGenInfo.sMakeScript)
      else
        MonGenInfo.nMakeScript := -1;
      if MonGenInfo.sDieScript <> '' then
        MonGenInfo.nDieScript := g_FunctionNPC.GetScriptIndex(MonGenInfo.sDieScript)
      else
        MonGenInfo.nDieScript := -1;
      if MonGenInfo.sCanMakeScript <> '' then
        MonGenInfo.nCanMakeScript := g_FunctionNPC.GetScriptIndex(MonGenInfo.sCanMakeScript)
      else
        MonGenInfo.nCanMakeScript := -1;
    end;
  end;
end;

procedure TUserEngine.NPCinitialize;
var
  i, nIndex: Integer;
  NormNpc: TNormNpc;
  sCaption: string;
begin
  sCaption := FrmMain.Caption;
  try
    for i := QuestNPCList.Count - 1 downto 0 do begin
      NormNpc := TNormNpc(QuestNPCList.Items[i]);
      if NormNpc <> nil then begin
        NormNpc.m_PEnvir := g_MapManager.FindMap(NormNpc.m_sMapName);
        if NormNpc.m_PEnvir <> nil then begin
          NormNpc.Initialize;
          if NormNpc.m_boAddtoMapSuccess and (not NormNpc.m_boIsHide) then begin
            MainOutMessage(NormNpc.m_sCharName + '管理NPC初始化失败... ');
            QuestNPCList.Delete(i);
            NormNpc.Free;
          end
          else begin
            NormNpc.LoadNpcScript();
            nIndex := NormNpc.GetScriptIndex('~Initialize');
            if nIndex > -1 then NormNpc.GotoLable(SystemObject, nIndex, False, '');
          end;
        end
        else begin
          MainOutMessage(NormNpc.m_sCharName + '管理NPC初始化失败... (m.PEnvir=nil) ');
          QuestNPCList.Delete(i);
          NormNpc.Free;
        end;
      end;
      FrmMain.Caption := sCaption + '[正在初始化管理NPC(' + IntToStr(QuestNPCList.Count) + '/' + IntToStr(QuestNPCList.Count - i) + ')]';
      Application.ProcessMessages;
    end;
  finally
    FrmMain.Caption := sCaption;
  end;
end;

function TUserEngine.GetLoadPlayCount: Integer;
begin
  Result := m_LoadPlayList.Count;
end;

procedure TUserEngine.DeleteOffLine(PlayObject: TPlayObject);
var
  I: Integer;
begin
  m_OffLineList.Lock;
  try
    for i := m_OffLineList.Count - 1 downto 0 do begin
      if PlayObject = TPlayObject(m_OffLineList.Objects[I]) then begin
        m_OffLineList.Delete(i);
        break;
      end;
    end;
  finally
    m_OffLineList.UnLock;
  end;
end;

function TUserEngine.GetOffLine(sUserName: string): TPlayObject;
var
  I: Integer;
begin
  Result := nil;
  m_OffLineList.Lock;
  try
    for i := m_OffLineList.Count - 1 downto 0 do begin
      if CompareText(m_OffLineList.Strings[i], sUserName) = 0 then begin
        Result := TPlayObject(m_OffLineList.Objects[I]);
        if Result.m_boGhost then begin
          Result := nil;
          m_OffLineList.Delete(i);
        end;
        break;
      end;
    end;
  finally
    m_OffLineList.UnLock;
  end;
end;

function TUserEngine.GetOffLinePlayCount: Integer;
begin
  Result := m_OffLineList.Count;
end;

function TUserEngine.GetOnlineHumCount: Integer;
begin
  Result := m_PlayObjectList.Count - m_OffLineList.Count;
end;

function TUserEngine.GetUserCount: Integer;
begin
  Result := m_PlayObjectList.Count{ + m_StringList_0C.Count};
end;

procedure TUserEngine.ProcessHumans;
  function IsLogined(sAccount, sChrName: string): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    if FrontEngine.InSaveRcdList(sAccount, sChrName) then begin
      Result := True;
    end
    else begin
      for i := 0 to m_PlayObjectList.Count - 1 do begin
        if {(CompareText(pTUserOpenInfo(m_PlayObjectList.Objects[i]).sAccount, sAccount) = 0) and }
          (CompareText(m_PlayObjectList.Strings[i], sChrName) = 0) then begin
          Result := True;
          break;
        end;
      end;
    end;
  end;
  function MakeNewHuman(UserOpenInfo: pTUserOpenInfo): TPlayObject;
  var
    PlayObject: TPlayObject;
    Abil: pTAbility;
    Envir: TEnvirnoment;
    nC, n18: Integer;
    //SwitchDataInfo: pTSwitchDataInfo;
    Castle: TUserCastle;
  resourcestring
    sExceptionMsg = '[Exception] TUserEngine::MakeNewHuman';
    sChangeServerFail1 = 'chg-server-fail-1 [%d] -> [%d] [%s]';
    sChangeServerFail2 = 'chg-server-fail-2 [%d] -> [%d] [%s]';
    sChangeServerFail3 = 'chg-server-fail-3 [%d] -> [%d] [%s]';
    sChangeServerFail4 = 'chg-server-fail-4 [%d] -> [%d] [%s]';
    sErrorEnvirIsNil = '[Error] PlayObject.PEnvir = nil';
  label
    ReGetMap;
  begin
    Result := nil;
    try
      PlayObject := TPlayObject.Create;
      {if not g_Config.boVentureServer then begin
        UserOpenInfo.sChrName := '';
        UserOpenInfo.LoadUser.nSessionID := 0;
        //        SwitchDataInfo := GetSwitchData(UserOpenInfo.sChrName, UserOpenInfo.LoadUser.nSessionID);
      end; // else SwitchDataInfo := nil;  }

      GetHumData(PlayObject, UserOpenInfo.HumanRcd);
      PlayObject.m_btRaceServer := RC_PLAYOBJECT;
      if PlayObject.m_sHomeMap = '' then begin
        ReGetMap:
        PlayObject.m_sHomeMap := GetHomeInfo(PlayObject.m_nHomeX, PlayObject.m_nHomeY);
        PlayObject.m_sMapName := PlayObject.m_sHomeMap;
        PlayObject.m_nCurrX := GetRandHomeX(PlayObject);
        PlayObject.m_nCurrY := GetRandHomeY(PlayObject);
        if PlayObject.m_Abil.Level = 0 then begin
          Abil := @PlayObject.m_Abil;
          Abil.Level := 1;
          {Abil.AC := 0;
          Abil.MAC := 0;
          Abil.DC := MakeLong(1, 2);
          Abil.MC := MakeLong(1, 2);
          Abil.SC := MakeLong(1, 2);
          Abil.MP := 15;
          Abil.HP := 15;
          Abil.MaxHP := 15;
          Abil.MaxMP := 15;  }
          PlayObject.m_boNewHuman := True;
          PlayObject.m_nPullulation := 0; //第一次登录初始化自然成长点
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTDEAL, False);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTGROUP, False);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTGUILD, True);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTFRIENG, False);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTSAYHEAR, False);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTSAYWHISPER, False);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTSAYCRY, False);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTSAYGROUP, False);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTSAYGUILD, False);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_GROUPCHECK, True);
          SetIntStatus(PlayObject.m_nAllowSetup, GPS_GROUPRECALL, False);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_GUILDRECALL, False);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_HIDEHELMET, False);
          SetIntStatus(PlayObject.m_nAllowSetup, GSP_OLDCHANGEMAP, False);
        end;
      end;
      PlayObject.m_MyGuild := g_GuildManager.MemberOfGuild(PlayObject.m_sCharName, PlayObject.m_sGuildName);
      if PlayObject.m_MyGuild = nil then PlayObject.m_sGuildName := '';
      Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
      if Envir <> nil then begin
        if Envir.m_boFight3Zone then begin //是否在行会战争地图死亡
          if (PlayObject.m_Abil.HP <= 0) and (PlayObject.m_nFightZoneDieCount < 3) then begin
            PlayObject.m_Abil.HP := PlayObject.m_Abil.MaxHP;
            PlayObject.m_Abil.MP := PlayObject.m_Abil.MaxMP;
            PlayObject.m_boDieInFight3Zone := True;
          end
          else
            PlayObject.m_nFightZoneDieCount := 0;
        end;
        if Envir.m_boNORECONNECT then begin
          if (Envir.NoReconnectEnvir <> nil) then begin
            if (Envir.m_nReConnectX > 0) and (Envir.m_nReConnectY > 0) then begin
              PlayObject.m_nCurrX := Envir.m_nReConnectX - 2 + Random(5);
              PlayObject.m_nCurrY := Envir.m_nReConnectY - 2 + Random(5);
              Envir := Envir.NoReconnectEnvir;
              PlayObject.m_sMapName := Envir.sMapName;
            end else begin
              Envir := Envir.NoReconnectEnvir;
              PlayObject.m_sMapName := Envir.sMapName;
              if Envir.m_nHeight < 150 then begin
                if Envir.m_nHeight < 30 then begin
                  n18 := 2;
                end
                else
                  n18 := 20;
              end
              else
                n18 := 50;
              PlayObject.m_nCurrX := Random(Envir.m_nWidth - n18 - 1) + n18;
              PlayObject.m_nCurrY := Random(Envir.m_nHeight - n18 - 1) + n18;
              if not PlayObject.GetRandXY(Envir, PlayObject.m_nCurrX, PlayObject.m_nCurrY) then begin
                PlayObject.m_sMapName := PlayObject.m_sHomeMap;
                PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
                PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
                Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
              end;
            end;
          end else begin
            PlayObject.m_sMapName := PlayObject.m_sHomeMap;
            PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
            PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
            Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
          end;
        end else
        if Envir.m_boFB then begin
          PlayObject.m_sMapName := PlayObject.m_sHomeMap;
          PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
          PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
          Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        end;
      end else begin
        PlayObject.m_sMapName := g_Config.sHomeMap;
        PlayObject.m_nCurrX := g_Config.nHomeX - 2 + Random(5);
        PlayObject.m_nCurrY := g_Config.nHomeY - 2 + Random(5);
        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
      end;

      if (PlayObject.m_Abil.HP > 0) and (Envir <> nil) then begin
        Castle := g_CastleManager.InCastleWarArea(Envir, PlayObject.m_nCurrX, PlayObject.m_nCurrY);
        if (Castle <> nil) and ((Castle.m_MapPalace = Envir) or Castle.m_boUnderWar) then begin
          Castle := g_CastleManager.IsCastleMember(PlayObject);
          if Castle = nil then begin
            PlayObject.m_sMapName := PlayObject.m_sHomeMap;
            PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
            PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
          end
          else begin
            if Castle.m_MapPalace = Envir then begin
              PlayObject.m_sMapName := Castle.GetMapName();
              PlayObject.m_nCurrX := Castle.GetHomeX;
              PlayObject.m_nCurrY := Castle.GetHomeY;
            end;
          end;
        end;
        if (CompareText(PlayObject.m_sMapName, Envir.sMapName) <> 0) then
          Envir := g_MapManager.FindMap(PlayObject.m_sMapName);
      end;

      if Envir = nil then PlayObject.m_Abil.HP := 0;

      if PlayObject.m_Abil.HP <= 0 then begin
        Envir := nil;
        PlayObject.ClearStatusTime();
        if PlayObject.PKLevel < 2 then begin
          Castle := g_CastleManager.IsCastleMember(PlayObject);
          //            if UserCastle.m_boUnderWar and (UserCastle.IsMember(PlayObject)) then begin
          if (Castle <> nil) and Castle.m_boUnderWar then begin
            PlayObject.m_sMapName := Castle.m_sHomeMap;
            PlayObject.m_nCurrX := Castle.GetHomeX;
            PlayObject.m_nCurrY := Castle.GetHomeY;
          end
          else begin
            PlayObject.m_sMapName := PlayObject.m_sHomeMap;
            PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
            PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
          end;
        end
        else begin
          PlayObject.m_sMapName := g_Config.sRedDieHomeMap {'3'};
          PlayObject.m_nCurrX := Random(13) + g_Config.nRedDieHomeX {839};
          PlayObject.m_nCurrY := Random(13) + g_Config.nRedDieHomeY {668};
        end;
        PlayObject.m_Abil.HP := 14;
      end;

      PlayObject.AbilCopyToWAbil();
      if Envir = nil then Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
      if Envir = nil then begin
        PlayObject.m_nSessionID := UserOpenInfo.LoadUser.nSessionID;
        PlayObject.m_nSocket := UserOpenInfo.LoadUser.nSocket;
        PlayObject.m_nGateIdx := UserOpenInfo.LoadUser.nGateIdx;
        PlayObject.m_nGSocketIdx := UserOpenInfo.LoadUser.nGSocketIdx;
        PlayObject.m_WAbil := PlayObject.m_Abil;
        PlayObject.m_nServerIndex := g_MapManager.GetMapOfServerIndex(PlayObject.m_sMapName);
        if PlayObject.m_Abil.HP <> 14 then begin
          MainOutMessage(format(sChangeServerFail1, [nServerIndex,
            PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
          {MainOutMessage('chg-server-fail-1 [' +
                         IntToStr(nServerIndex) +
                         '] -> [' +
                         IntToStr(PlayObject.m_nServerIndex) +
                         '] [' +
                         PlayObject.m_sMapName +
                         ']');}
        end;
        //SendSwitchData(PlayObject, PlayObject.m_nServerIndex);
        //SendChangeServer(PlayObject, PlayObject.m_nServerIndex);
        //PlayObject.Free;
        FreeAndNil(PlayObject);
        Exit;
      end;
      nC := 0;
      while (True) do begin
        if Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) then
          break;
        PlayObject.m_nCurrX := PlayObject.m_nCurrX - 3 + Random(6);
        PlayObject.m_nCurrY := PlayObject.m_nCurrY - 3 + Random(6);
        Inc(nC);
        if nC >= 5 then
          break;
      end;

      if not Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) then begin
        MainOutMessage(format(sChangeServerFail2, [nServerIndex, PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
        PlayObject.m_sMapName := g_Config.sHomeMap;
        PlayObject.m_nCurrX := g_Config.nHomeX;
        PlayObject.m_nCurrY := g_Config.nHomeY;
        Envir := g_MapManager.FindMap(g_Config.sHomeMap);
      end;

      PlayObject.m_PEnvir := Envir;
      if PlayObject.m_PEnvir = nil then begin
        MainOutMessage(sErrorEnvirIsNil);
        goto ReGetMap;
      end
      else begin
        PlayObject.m_boReadyRun := False;
      end;

      PlayObject.m_nIDIndex := UserOpenInfo.LoadUser.nIDIndex;
      PlayObject.m_sUserID := UserOpenInfo.LoadUser.sAccount;
      PlayObject.m_nGamePoint := UserOpenInfo.LoadUser.nGameGold;
      PlayObject.m_nCheckEMail := UserOpenInfo.LoadUser.nCheckEMail;
      PlayObject.m_sIPaddr := UserOpenInfo.LoadUser.sIPaddr;
      PlayObject.m_sIPLocal := GetIPLocal(PlayObject.m_sIPaddr);
      PlayObject.m_nSocket := UserOpenInfo.LoadUser.nSocket;
      PlayObject.m_nGSocketIdx := UserOpenInfo.LoadUser.nGSocketIdx;
      PlayObject.m_nGateIdx := UserOpenInfo.LoadUser.nGateIdx;
      PlayObject.m_nSessionID := UserOpenInfo.LoadUser.nSessionID;
      PlayObject.m_dwLoadTick := UserOpenInfo.LoadUser.dwNewUserTick;

      PlayObject.SetClientVersion(UserOpenInfo.LoadUser.nSoftVersionDate);

      Result := PlayObject;
    except
      MainOutMessage(sExceptionMsg);
    end;
  end;
  function GetToDayDate: Boolean;
  var
    wYear, wMonth, wDay: Word;
    wYear1, wMonth1, wDay1: Word;
  begin
    DecodeDate(m_TodayDate, wYear, wMonth, wDay);
    DecodeDate(Now, wYear1, wMonth1, wDay1);
    if (wYear = wYear1) and (wMonth = wMonth1) and (wDay = wDay1) then
      Result := True
    else
      Result := False;
  end;
var
//  dwUsrRotTime: LongWord;
  dwCheckTime: LongWord;
  dwCurTick: LongWord;
  nCheck30: Integer;
  boCheckTimeLimit: Boolean;
  nIdx: Integer;
  PlayObject: TPlayObject;
  i: Integer;
  UserOpenInfo: pTUserOpenInfo;
  LineNoticeMsg: string;
{$IFDEF PLUGOPEN}
  boAdd: Boolean;
{$ENDIF}
resourcestring
  sExceptionMsg1 = '[Exception] TUserEngine::ProcessHumans -> Ready, Save, Load... Code:=%d';
  sExceptionMsg2 = '[Exception] TUserEngine::ProcessHumans ClosePlayer.Delete - Free';
  sExceptionMsg3 = '[Exception] TUserEngine::ProcessHumans ClosePlayer.Delete';
  sExceptionMsg4 = '[Exception] TUserEngine::ProcessHumans RunNotice';
  sExceptionMsg5 = '[Exception] TUserEngine::ProcessHumans Human.Operate Code: %d';
  sExceptionMsg6 = '[Exception] TUserEngine::ProcessHumans Human.Finalize Code: %d';
  sExceptionMsg7 = '[Exception] TUserEngine::ProcessHumans RunSocket.CloseUser Code: %d';
  sExceptionMsg8 = '[Exception] TUserEngine::ProcessHumans';
  sExceptionMsg9 = '[Exception] TUserEngine::ProcessHumans -> OffLine';
begin
  nCheck30 := 0;
  dwCheckTime := GetTickCount();
  //  boToDayDate := True;
  if (GetTickCount - m_dwProcessLoadPlayTick) > 200 then begin
    m_dwProcessLoadPlayTick := GetTickCount();
    try
      EnterCriticalSection(m_LoadPlaySection);
      try
        for i := 0 to m_LoadPlayList.Count - 1 do begin
          UserOpenInfo := pTUserOpenInfo(m_LoadPlayList.Objects[i]);
          if UserOpenInfo = nil then Continue;
{$IFDEF PLUGOPEN}
          boAdd := False;
{$ENDIF}
          if CanAddObject and (not FrontEngine.IsFull) and (not IsLogined(UserOpenInfo.sAccount, m_LoadPlayList.Strings[i])) then begin

            PlayObject := MakeNewHuman(UserOpenInfo);

            if PlayObject <> nil then begin
              if PlayObject.m_nSessionID = -1 then begin
                PlayObject.m_boLoginNoticeOK := True;
                PlayObject.m_boSendNotice := True;
                PlayObject.m_boSafeOffLine := True;
                m_OffLineList.AddObject(PlayObject.m_sCharName, PlayObject);
              end;
              //PlayObject.m_boClientFlag:=UserOpenInfo.LoadUser.boClinetFlag; //将客户端标志传到人物数据中
{$IFDEF PLUGOPEN}
              boAdd := True;
{$ENDIF}
{$IF Public_Ver = Public_Test}
              AddObject(m_LoadPlayList.Strings[i], PlayObject);
{$ELSE}
              m_PlayObjectList.AddObject(m_LoadPlayList.Strings[i], PlayObject);    //改
{$IFEND}
              //SendServerGroupMsg(SS_201, nServerIndex, PlayObject.m_sCharName);
              m_NewHumanList.Add(PlayObject);
            end;
          end
          else begin
            KickOnlineUser(m_LoadPlayList.Strings[i]);
            m_ListOfGateIdx.Add(Pointer(UserOpenInfo.LoadUser.nGateIdx));
            m_ListOfSocket.Add(Pointer(UserOpenInfo.LoadUser.nSocket));
          end;
{$IFDEF PLUGOPEN}
          if not boAdd then begin
            try
              if Assigned(zPlugOfEngine.HookUserLoadAndSave) then begin
                zPlugOfEngine.HookUserLoadAndSave(True, True, False, False, UserOpenInfo.HumanRcd.Data.nIdx);
              end;
            except
              on E: Exception do begin
                MainOutMessage(E.Message);
                MainOutMessage('[Exception] TUserEngine::ProcessHumans -> EMailModule');
              end;
            end;
          end;
{$ENDIF}
          //DisPose(pTUserOpenInfo(m_LoadPlayList.Objects[i]));
          Dispose(UserOpenInfo);
        end;
        m_LoadPlayList.Clear;

        {for i := 0 to m_SendDBList.Count - 1 do begin
          SendDBSInfo := m_SendDBList.Items[i];
          if SendDBSInfo = nil then Continue;
          if SendDBSInfo.nIdent = DBR_GETSORTLIST then begin
            SetSortList(SendDBSInfo.nRecog, SendDBSInfo.sMsg);
          end;
          else begin
            PlayObject := TPlayObject(SendDBSInfo.PlayObject);
            if PlayObject <> nil then begin
              PlayObject.GetDBSInfo(SendDBSInfo.nIdent, SendDBSInfo.nRecog,
                SendDBSInfo.sMsg);
            end;
          end;
          DisPose(SendDBSInfo);
        end;
        m_SendDBList.Clear; }
      finally
        LeaveCriticalSection(m_LoadPlaySection);
      end;

      for i := 0 to m_NewHumanList.Count - 1 do begin
        PlayObject := TPlayObject(m_NewHumanList.Items[i]);
        if PlayObject = nil then
          Continue;
        RunSocket.SetGateUserList(PlayObject.m_nGateIdx, PlayObject.m_nSocket, PlayObject);
      end;
      m_NewHumanList.Clear;

      for i := 0 to m_ListOfGateIdx.Count - 1 do begin
        RunSocket.CloseUser(Integer(m_ListOfGateIdx.Items[i]), Integer(m_ListOfSocket.Items[i])); //GateIdx,nSocket
      end;
      m_ListOfGateIdx.Clear;
      m_ListOfSocket.Clear;
    except
      on E: Exception do begin
        MainOutMessage(format(sExceptionMsg1, [0]));
        MainOutMessage(E.Message);
      end;
    end;
  end;
  try
    if (GetTickCount > m_CheckOffLineTick) then begin
      m_CheckOffLineTick := GetTickCount + 60 * 1000;
      for I := m_OffLineList.Count - 1 downto 0 do begin
        PlayObject := TPlayObject(m_OffLineList.Objects[i]);
        if (PlayObject = nil) or PlayObject.m_boGhost then begin
          m_OffLineList.Delete(I);
        end else
        if PlayObject.m_boDeath then begin
          PlayObject.MakeGhost;
          m_OffLineList.Delete(I);
        end;
      end;
    end;
  Except
    MainOutMessage(sExceptionMsg9);
  end;
  try
    for i := 0 to m_PlayObjectFreeList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectFreeList.Items[i]);
      if PlayObject = nil then Continue;
      if (GetTickCount - PlayObject.m_dwGhostTick) > g_Config.dwHumanFreeDelayTime {5 * 60 * 1000} then begin
        try
          TPlayObject(m_PlayObjectFreeList.Items[i]).Free;
        except
          MainOutMessage(sExceptionMsg2);
        end;
        m_PlayObjectFreeList.Delete(i);
        break;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg3);
  end;

  boCheckTimeLimit := False;
  try
    dwCurTick := GetTickCount();
    nIdx := m_nProcHumIDx;
    while True do begin
{$IF Public_Ver = Public_Test}
      if nIdx >= 10 then break;
      case nIdx of
        0: PlayObject := FObject1;
        1: PlayObject := FObject2;
        2: PlayObject := FObject3;
        3: PlayObject := FObject4;
        4: PlayObject := FObject5;
        5: PlayObject := FObject6;
        6: PlayObject := FObject7;
        7: PlayObject := FObject8;
        8: PlayObject := FObject9;
        9: PlayObject := FObject10;
        else PlayObject := nil;
      end;
{$ELSE}
      if m_PlayObjectList.Count <= nIdx then break;
      PlayObject := TPlayObject(m_PlayObjectList.Objects[nIdx]);
{$IFEND}
      if PlayObject <> nil then begin
        if Integer(dwCurTick - PlayObject.m_dwRunTick) > PlayObject.m_nRunTime then begin
          PlayObject.m_dwRunTick := dwCurTick;

          if not PlayObject.m_boGhost then begin
            if not PlayObject.m_boLoginNoticeOK then begin
              try
                PlayObject.RunNotice();
              except
                MainOutMessage(sExceptionMsg4);
              end;
            end
            else begin
              try
                if PlayObject.m_boOffLineLogin then begin
                  PlayObject.m_boOffLineLogin := False;
                  PlayObject.UserOffLineLogon;
                end else
                if not PlayObject.m_boReadyRun then begin
                  PlayObject.m_boReadyRun := True;
                  PlayObject.UserLogon;
                end
                else begin
                  if (GetTickCount() - PlayObject.m_dwSearchTick) > PlayObject.m_dwSearchTime then begin
                    PlayObject.m_dwSearchTick := GetTickCount();
                    nCheck30 := 10;
                    PlayObject.SearchViewRange;
                    nCheck30 := 11;
                    PlayObject.GameTimeChanged;
                    nCheck30 := 12;
                  end;
                end;
                if (GetTickCount() - PlayObject.m_dwShowLineNoticeTick) > g_Config.dwShowLineNoticeTime then begin
                  PlayObject.m_dwShowLineNoticeTick := GetTickCount();
                  if LineNoticeList.Count > PlayObject.m_nShowLineNoticeIdx then begin

                    LineNoticeMsg := g_ManageNPC.GetLineVariableText(PlayObject,
                      LineNoticeList.Strings[PlayObject.m_nShowLineNoticeIdx]);

                    //PlayObject.SysMsg(g_Config.sLineNoticePreFix + ' '+ LineNoticeList.Strings[PlayObject.m_nShowLineNoticeIdx],g_nLineNoticeColor);
                    nCheck30 := 13;
                    case LineNoticeMsg[1] of
                      'R': PlayObject.SysMsg(Copy(LineNoticeMsg, 2, Length(LineNoticeMsg) - 1), c_Red, t_Notice);
                      'G': PlayObject.SysMsg(Copy(LineNoticeMsg, 2, Length(LineNoticeMsg) - 1), c_Green, t_Notice);
                      'B': PlayObject.SysMsg(Copy(LineNoticeMsg, 2, Length(LineNoticeMsg) - 1), c_Blue, t_Notice);
                      'T': PlayObject.SendDefMsg(PlayObject, SM_TOPMSG, 0, 0, 0, 0, Copy(LineNoticeMsg, 2, Length(LineNoticeMsg) - 1));
                    else begin
                        PlayObject.SysMsg(LineNoticeMsg, TMsgColor(g_Config.nLineNoticeColor), t_Notice);
                      end;
                    end;
                  end;
                  Inc(PlayObject.m_nShowLineNoticeIdx);
                  if (LineNoticeList.Count <= PlayObject.m_nShowLineNoticeIdx) then
                    PlayObject.m_nShowLineNoticeIdx := 0;
                end;
                nCheck30 := 14;
                PlayObject.Run();
                nCheck30 := 15;
                if not FrontEngine.IsFull and ((GetTickCount() - PlayObject.m_dwSaveRcdTick) > g_Config.dwSaveHumanRcdTime) then begin
                  nCheck30 := 16;
                  PlayObject.m_dwSaveRcdTick := GetTickCount();
                  nCheck30 := 17;
                  PlayObject.DealCancelA();
                  nCheck30 := 18;
                  SaveHumanRcd(PlayObject);
                  nCheck30 := 19;
                end;
              except
                on E: Exception do begin
                  MainOutMessage(format(sExceptionMsg5, [nCheck30]));
                  MainOutMessage(E.Message);
                end;
              end;
            end;
          end
          else begin //if not PlayObject.boIsGhost then begin
            try
              SetLoginPlay(PlayObject.m_nDBIndex, nil);
{$IF Public_Ver = Public_Test}
              DelObject(PlayObject);
{$ELSE}
              m_PlayObjectList.Delete(nIdx);     //改
{$IFEND}
              nCheck30 := 2;
              PlayObject.Disappear();
              nCheck30 := 3;
              if PlayObject.m_boSafeOffLine then
                DeleteOffLine(PlayObject);
            except
              on E: Exception do begin
                MainOutMessage(format(sExceptionMsg6, [nCheck30]));
                MainOutMessage(E.Message);
              end;
            end;
            try
              AddToHumanFreeList(PlayObject);
              nCheck30 := 4;
              PlayObject.DealCancelA();
              SaveHumanRcd(PlayObject);
              RunSocket.CloseUser(PlayObject.m_nGateIdx, PlayObject.m_nSocket);
            except
              MainOutMessage(format(sExceptionMsg7, [nCheck30]));
            end;
            //SendServerGroupMsg(SS_202, nServerIndex, PlayObject.m_sCharName);
            Continue;
          end;
        end; //if (dwTime14 - PlayObject.dw368) > PlayObject.dw36C then begin
        Inc(nIdx);
        if (GetTickCount - dwCheckTime) > g_dwHumLimit then begin
          boCheckTimeLimit := True;
          m_nProcHumIDx := nIdx;
          break;
        end;
      end else
        Inc(nIdx); //while True do begin
    end;
    if not boCheckTimeLimit then
      m_nProcHumIDx := 0;
  except
    MainOutMessage(sExceptionMsg8);
  end;
  Inc(nProcessHumanLoopTime);
  g_nProcessHumanLoopTime := nProcessHumanLoopTime;
  if m_nProcHumIDx = 0 then begin
    nProcessHumanLoopTime := 0;
    g_nProcessHumanLoopTime := nProcessHumanLoopTime;
  end;
  g_nHumCountMin := GetTickCount - dwCheckTime;
  if g_nHumCountMax < g_nHumCountMin then
    g_nHumCountMax := g_nHumCountMin;
end;

function TUserEngine.InMerchantList(Merchant: TMerchant): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to m_MerchantList.Count - 1 do begin
    if (Merchant <> nil) and (TMerchant(m_MerchantList.Items[i]) = Merchant) then begin
      Result := True;
      break;
    end;
  end;
end;

procedure TUserEngine.ProcessMerchants;
var
  dwRunTick, dwCurrTick: LongWord;
  i: Integer;
  MerchantNPC: TMerchant;
  boProcessLimit: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessMerchants';
begin
  dwRunTick := GetTickCount();
  boProcessLimit := False;
  try
    dwCurrTick := GetTickCount();
    m_MerchantList.Lock;
    try
      i := nMerchantPosition;
      while True do begin // for i := nMerchantPosition to m_MerchantList.Count - 1 do begin
        if m_MerchantList.Count <= i then
          break;
        MerchantNPC := m_MerchantList.Items[i];
        if MerchantNPC <> nil then begin
          if not MerchantNPC.m_boGhost then begin
            if Integer(dwCurrTick - MerchantNPC.m_dwRunTick) >
              MerchantNPC.m_nRunTime then begin
              if (GetTickCount - MerchantNPC.m_dwSearchTick) > MerchantNPC.m_dwSearchTime then begin
                MerchantNPC.m_dwSearchTick := GetTickCount();
                MerchantNPC.SearchObjectViewRange();
              end;
              if Integer(dwCurrTick - MerchantNPC.m_dwRunTick) > MerchantNPC.m_nRunTime then begin
                MerchantNPC.m_dwRunTick := dwCurrTick;
                MerchantNPC.Run;
              end;
            end;
          end
          else begin
            if (GetTickCount - MerchantNPC.m_dwGhostTick) > 5 * 60 * 1000 then begin
              MerchantNPC.Free;
              m_MerchantList.Delete(i);
              break;
            end;
          end;
        end;
        if (GetTickCount - dwRunTick) > g_dwNpcLimit then begin
          nMerchantPosition := i;
          boProcessLimit := True;
          break;
        end;
        Inc(i);
      end;
    finally
      m_MerchantList.UnLock;
    end;
    if not boProcessLimit then begin
      nMerchantPosition := 0;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
  dwProcessMerchantTimeMin := GetTickCount - dwRunTick;
  if dwProcessMerchantTimeMin > dwProcessMerchantTimeMax then
    dwProcessMerchantTimeMax := dwProcessMerchantTimeMin;
  //if dwProcessNpcTimeMin > dwProcessNpcTimeMax then
    //dwProcessNpcTimeMax := dwProcessNpcTimeMin;
end;

procedure TUserEngine.ProcessMessage1(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; sMsg: string);
begin
  PlayObject.SendMsg(PlayObject,
    DefMsg.Ident,
    DefMsg.Series,
    DefMsg.Recog,
    DefMsg.Param,
    DefMsg.Tag,
    DeCodeString(sMsg));
end;

procedure TUserEngine.ProcessMessageMove(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; sMsg: string);
begin
  { if g_Config.boActionSendActionMsg then begin //使用UpdateMsg 可以防止消息队列里有多个操作

     PlayObject.SendActionMsg(PlayObject,
       DefMsg.Ident,
       DefMsg.Tag,
       LoWord(DefMsg.Recog),
       HiWord(DefMsg.Recog),
       0,
       '');
   end
   else begin }
  PlayObject.SendMsg(PlayObject,
    DefMsg.Ident,
    DefMsg.Tag,
    LoWord(DefMsg.Recog), {x}
    HiWord(DefMsg.Recog), {y}
    0,
    '');
  //end;
end;

procedure TUserEngine.ProcessMessageSay(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; sMsg: string);
begin
  PlayObject.SendMsg(PlayObject, CM_SAY, 0, 0, 0, 0, DeCodeString(sMsg));
end;

procedure TUserEngine.ProcessMissions;
begin

end;

function TUserEngine.InsMonstersList(MonGen: pTMonGenInfo; Monster: TAnimalObject): Boolean;
var
  i, ii: Integer;
  MonGenInfo: pTMonGenInfo;
begin
  Result := False;
  for i := 0 to m_MonGenList.Count - 1 do begin
    MonGenInfo := m_MonGenList.Items[i];
    if (MonGenInfo <> nil) and (MonGenInfo.CertList <> nil) and (MonGen <> nil) and (MonGen = MonGenInfo) then begin
      for ii := 0 to MonGenInfo.CertList.Count - 1 do begin
        if (Monster <> nil) and (TBaseObject(MonGenInfo.CertList.Items[ii]) =
          Monster) then begin
          Result := True;
          break;
        end;
      end;
    end;
  end;
end;

function TUserEngine.ClearMonsters(sMapName: string): Boolean;
var
  i, ii: Integer;
  {MonGenInfo: pTMonGenInfo;
  Monster: TAnimalObject; }
  MonList: TList;
  Envir: TEnvirnoment;
  BaseObject: TBaseObject;
begin
  //  Result := False;
  MonList := TList.Create;
  for i := 0 to g_MapManager.Count - 1 do begin
    Envir := TEnvirnoment(g_MapManager.Items[i]);
    if (Envir <> nil) and ((CompareText(Envir.sMapName, sMapName) = 0)) then begin
      UserEngine.GetMapMonster(Envir, MonList);
      for ii := 0 to MonList.Count - 1 do begin
        BaseObject := TBaseObject(MonList.Items[ii]);
        if BaseObject <> nil then begin
          if (BaseObject.m_btRaceServer <> 110) and (BaseObject.m_btRaceServer <> 111) and
            (BaseObject.m_btRaceServer <> 111) and (BaseObject.m_btRaceServer <> RC_GUARD) and
            (BaseObject.m_btRaceServer <> RC_ARCHERGUARD) and
            (BaseObject.m_btRaceServer <> 55) then begin
            BaseObject.m_boNoItem := True;
            BaseObject.m_WAbil.HP := 0;
          end;
        end;
      end;
    end;
  end;
  MonList.Free;

  {for i := 0 to m_MonGenList.Count - 1 do begin
    MonGenInfo := m_MonGenList.Items[i];
    if MonGenInfo = nil then Continue;
    if CompareText(MonGenInfo.sMapName, sMapName) = 0 then begin
      if (MonGenInfo.CertList <> nil) and (MonGenInfo.CertList.Count > 0) then begin
        for ii := 0 to MonGenInfo.CertList.Count - 1 do begin
          Monster := TAnimalObject(MonGenInfo.CertList.Items[ii]);
          if Monster <> nil then begin
            if (Monster.m_btRaceServer <> 110) and (Monster.m_btRaceServer <> 111) and
              (Monster.m_btRaceServer <> 111) and (Monster.m_btRaceServer <> RC_GUARD) and
              (Monster.m_btRaceServer <> RC_ARCHERGUARD) and (Monster.m_btRaceServer <> 55) then begin
              Monster.Free;
              if nMonsterCount > 0 then Dec(nMonsterCount);
              //DisPose();
            end;
          end;
          if MonGenInfo.CertList.Count <= 0 then begin
            MonGenInfo.CertList.Clear;
          end;
        end;
      end;
    end;
  end;}
  Result := True;
end;

procedure TUserEngine.ProcessMonsters;
 { function GetZenTime(dwTime: LongWord): LongWord;
  var
    d10: Double;
  begin
    if dwTime < 30 * 60 * 1000 then begin
      d10 := (GetUserCount - g_Config.nUserFull ) / g_Config.nZenFastStep;
      if d10 > 0 then begin
        if d10 > 6 then
          d10 := 6;
        Result := dwTime - ROUND((dwTime / 10) * d10)
      end
      else begin
        Result := dwTime;
      end;
    end
    else begin
      Result := dwTime;
    end;
  end;   }
var
  dwCurrentTick: LongWord;
  dwRunTick: LongWord;
  dwMonProcTick: LongWord;
  MonGen: pTMonGenInfo;
  nGenCount: Integer;
  nGenModCount: Integer;
  boProcessLimit: Boolean;
  boRegened: Boolean;
  i: Integer;
  nProcessPosition: Integer;
  Monster: TBaseObject;
  tCode: Integer;
  nMakeMonsterCount: Integer;
  //  nActiveMonsterCount: Integer;
  //  nActiveHumCount: Integer;
  //  nNeedMakeMonsterCount: Integer;
  //  MapMonGenCount: pTMapMonGenCount;
  //  n10: Integer;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessMonsters %d %s';
begin
  tCode := 0;
  dwRunTick := GetTickCount();
  Monster := nil;
  try
    tCode := 0;
    boProcessLimit := False;
    dwCurrentTick := GetTickCount();
    MonGen := nil;
    //刷新怪物开始
    if ((GetTickCount - dwRegenMonstersTick) > g_Config.dwRegenMonstersTime) then begin
      dwRegenMonstersTick := GetTickCount();
      if m_nCurrMonGen < m_MonGenList.Count then begin
        MonGen := m_MonGenList.Items[m_nCurrMonGen];
      end;
      if m_nCurrMonGen < m_MonGenList.Count - 1 then begin
        Inc(m_nCurrMonGen);
      end
      else begin
        m_nCurrMonGen := 0;
      end;
      if (MonGen <> nil) and (not MonGen.boFB) and (MonGen.sMonName <> '') and not g_Config.boVentureServer then begin
        if (MonGen.dwStartTick = 0) or ((GetTickCount - MonGen.dwStartTick) >= MonGen.dwZenTime) then begin
          MonGen.boCanMakeHint := False;
          nGenCount := GetGenMonCount(MonGen);                                {GetZenTime(MonGen.dwZenTime)}
          boRegened := True;
          if g_Config.nMonGenRate <= 0 then g_Config.nMonGenRate := 10; //防止除法错误
          nGenModCount := _MAX(1, ROUND(_MAX(1, MonGen.nCount) / (g_Config.nMonGenRate / 10)));
          nMakeMonsterCount := nGenModCount - nGenCount;
          if nMakeMonsterCount < 0 then nMakeMonsterCount := 0;
          if nMakeMonsterCount > 0 then begin //0806 增加 控制刷怪数量比例
            boRegened := RegenMonsters(MonGen, nMakeMonsterCount);
          end;
          if boRegened then begin
            MonGen.dwStartTick := GetTickCount();
          end;
          g_sMonGenInfo1 := MonGen.sMonName + ',' + IntToStr(m_nCurrMonGen) + '/' + IntToStr(m_MonGenList.Count);
        end else begin
          nGenCount := MonGen.dwZenTime - (GetTickCount - MonGen.dwStartTick);
          if nGenCount > 0 then begin
            if MonGen.nTimeHintIndex > -1 then begin
              g_Config.GlobaDyMval[MonGen.nTimeHintIndex] := _MAX(Round(nGenCount / (60 * 1000)), 1);
            end;
            if (not MonGen.boCanMakeHint) and (MonGen.nCanMakeScript > -1) then begin
              if nGenCount < MonGen.dwCanMakeHintTime then begin
                MonGen.boCanMakeHint := True;
                g_FunctionNPC.m_GotoValue[0] := FilterShowName(MonGen.sMonName);
                g_FunctionNPC.m_GotoValue[1] := IntToStr(_MAX(Round(nGenCount / (60 * 1000)), 1));
                g_FunctionNPC.GotoLable(SystemObject, MonGen.nCanMakeScript, False, '');
              end;
            end;
          end;
        end;
      end;
    end;
    g_nMonGenTime := GetTickCount - dwCurrentTick;
    if g_nMonGenTime > g_nMonGenTimeMin then
      g_nMonGenTimeMin := g_nMonGenTime;
    if g_nMonGenTime > g_nMonGenTimeMax then
      g_nMonGenTimeMax := g_nMonGenTime;
    //刷新怪物结束
    dwMonProcTick := GetTickCount();
    nMonsterProcessCount := 0;
    tCode := 1;
    for i := m_nMonGenListPosition to m_MonGenList.Count - 1 do begin
      MonGen := m_MonGenList.Items[i];
      tCode := 11;
      if m_nMonGenCertListPosition < MonGen.CertList.Count then begin
        nProcessPosition := m_nMonGenCertListPosition;
      end
      else begin
        nProcessPosition := 0;
      end;
      m_nMonGenCertListPosition := 0;
      while (True) do begin
        if nProcessPosition >= MonGen.CertList.Count then
          break;
        Monster := MonGen.CertList.Items[nProcessPosition];
        tCode := 12;
        if Monster <> nil then begin
          if not Monster.m_boGhost then begin
            if Integer(dwCurrentTick - Monster.m_dwRunTick) > Monster.m_nRunTime then begin
              Monster.m_dwRunTick := dwRunTick;
              if (dwCurrentTick - Monster.m_dwSearchTick) > Monster.m_dwSearchTime then begin
                Monster.m_dwSearchTick := GetTickCount();
                tCode := 13;
                if (Monster.m_nVisibleActiveCount > 0) or (Monster.m_boKeepRun) or (Monster.m_boFixedHideMode) then
                  Monster.SearchObjectViewRange()
                else
                  Monster.ClearViewRange;
              end;
              tCode := 14;
              if (not Monster.m_boKeepRun) and
                (not Monster.m_boFixedHideMode) and 
                (not Monster.m_boIsVisibleActive) and
                ((not Monster.m_boMission) or
                  (Monster.m_boMission and (Monster.m_nCurrX = Monster.m_nMissionX) and (Monster.m_nCurrY = Monster.m_nMissionY))) and
                (Monster.m_nVisibleActiveCount <= 0) and
                (Monster.m_nProcessRunCount < g_Config.nProcessMonsterInterval) and
                (Monster.m_MsgList.Count <= 0) and
                (Monster.m_TargetCret = nil) and
                ((Monster.m_Master = nil) or (Monster.m_Master.m_btRaceServer <> RC_PLAYOBJECT)) then begin
                Inc(Monster.m_nProcessRunCount);
              end
              else begin
                Monster.m_nProcessRunCount := 0;
                Monster.Run;
              end;
              Inc(nMonsterProcessCount);
            end;
            Inc(nMonsterProcessPostion);
          end
          else begin
            if ((GetTickCount - Monster.m_dwGhostTick) > 5 * 60 * 1000) then begin
              MonGen.CertList.Delete(nProcessPosition);
              Monster.Free;
              Continue;
            end;
          end;
        end;
        Inc(nProcessPosition);
        if (GetTickCount - dwMonProcTick) > g_dwMonLimit then begin
          g_sMonGenInfo2 := Monster.m_sCharName + '/' + IntToStr(nProcessPosition) +
            '/' + IntToStr(MonGen.CertList.Count) +
            '/' + IntToStr(i) +
            '/' + IntToStr(m_MonGenList.Count);
          boProcessLimit := True;
          m_nMonGenCertListPosition := nProcessPosition;
          break;
        end;
      end; //while (True) do begin
      if boProcessLimit then
        break;
    end; //for I:= m_nMonGenListPosition to MonGenList.Count -1 do begin
    tCode := 2;
    if m_MonGenList.Count <= i then begin
      m_nMonGenListPosition := 0;
      nMonsterCount := nMonsterProcessPostion;
      nMonsterProcessPostion := 0;
      n84 := (n84 + nMonsterProcessCount) div 2;
    end;
    if not boProcessLimit then begin
      m_nMonGenListPosition := 0;
    end
    else begin
      m_nMonGenListPosition := i;
    end;
    g_nMonProcTime := GetTickCount - dwMonProcTick;
    if g_nMonProcTime > g_nMonProcTimeMin then
      g_nMonProcTimeMin := g_nMonProcTime;
    if g_nMonProcTime > g_nMonProcTimeMax then
      g_nMonProcTimeMax := g_nMonProcTime;
  except
    on E: Exception do begin
      if Monster <> nil then begin
        MainOutMessage(format(sExceptionMsg, [tCode, Monster.m_sCharName]));
        MainOutMessage(E.Message);
      end
      else begin
        MainOutMessage(format(sExceptionMsg, [tCode, '']));
        MainOutMessage(E.Message);
      end;
    end;
  end;
  g_nMonTimeMin := GetTickCount - dwRunTick;
  if g_nMonTimeMax < g_nMonTimeMin then
    g_nMonTimeMax := g_nMonTimeMin;
end;

function TUserEngine.GetGenMonCount(MonGen: pTMonGenInfo): Integer;
var
  i: Integer;
  nCount: Integer;
  BaseObject: TBaseObject;
begin
  nCount := 0;
  for i := 0 to MonGen.CertList.Count - 1 do begin
    BaseObject := TBaseObject(MonGen.CertList.Items[i]);
    if BaseObject <> nil then begin
      if not BaseObject.m_boDeath and not BaseObject.m_boGhost then
        Inc(nCount);
    end;
  end;
  Result := nCount;
end;

function TUserEngine.InQuestNPCList(NPC: TNormNpc): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to QuestNPCList.Count - 1 do begin
    if (NPC <> nil) and (TNormNpc(QuestNPCList.Items[i]) = NPC) then begin
      Result := True;
      break;
    end;
  end;
end;

procedure TUserEngine.ProcessNpcs;
var
  dwRunTick, dwCurrTick: LongWord;
  i: Integer;
  NPC: TNormNpc;
  boProcessLimit: Boolean;
begin
  dwRunTick := GetTickCount();
  boProcessLimit := False;
  try
    dwCurrTick := GetTickCount();
    for i := nNpcPosition to QuestNPCList.Count - 1 do begin
      NPC := QuestNPCList.Items[i];
      if NPC <> nil then begin
        if not NPC.m_boGhost then begin
          if Integer(dwCurrTick - NPC.m_dwRunTick) > NPC.m_nRunTime then begin
            if (GetTickCount - NPC.m_dwSearchTick) > NPC.m_dwSearchTime then begin
              NPC.m_dwSearchTick := GetTickCount();
              NPC.SearchObjectViewRange();
            end;
            if Integer(dwCurrTick - NPC.m_dwRunTick) > NPC.m_nRunTime then begin
              NPC.m_dwRunTick := dwCurrTick;
              NPC.Run;
            end;
          end;
        end
        else begin
          if (GetTickCount - NPC.m_dwGhostTick) > 5 * 60 * 1000 then begin
            NPC.Free;
            QuestNPCList.Delete(i);
            break;
          end;
        end;
      end;
      if (GetTickCount - dwRunTick) > g_dwNpcLimit then begin
        nNpcPosition := i;
        boProcessLimit := True;
        break;
      end;
    end;
    if not boProcessLimit then begin
      nNpcPosition := 0;
    end;
  except
    MainOutMessage('[Exceptioin] TUserEngine.ProcessNpcs');
  end;
  dwProcessNpcTimeMin := GetTickCount - dwRunTick;
  if dwProcessNpcTimeMin > dwProcessNpcTimeMax then
    dwProcessNpcTimeMax := dwProcessNpcTimeMin;
end;

procedure TUserEngine.ProcessQueryUserName(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; sMsg: string);
begin
  PlayObject.SendMsg(PlayObject, DefMsg.Ident, 0, DefMsg.Recog,
    DefMsg.Param {x}, DefMsg.Tag {y}, '');
end;

procedure TUserEngine.ProcessRandomMapGate;
var
  I: Integer;
  RandomGateObj: pTRandomGateObj;
begin
  for I := m_RandomMapGateList.Count - 1 downto 0 do begin
    RandomGateObj := m_RandomMapGateList[I];
    if GetTickCount > RandomGateObj.dwRunTime then begin
      RandomGateObj.SEnvir.DeleteFromMap(RandomGateObj.nX, RandomGateObj.nY, OS_GATEOBJECT, TObject(RandomGateObj.GateObj));
      if RandomGateObj.Event <> nil then begin
        RandomGateObj.Event.m_boClosed := True;
        RandomGateObj.Event.Close;
      end;
      Dispose(RandomGateObj.GateObj);
      Dispose(RandomGateObj);
      m_RandomMapGateList.Delete(I);
    end;
  end;
end;

procedure TUserEngine.ProcessSpell(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; sMsg: string);
begin
  {if g_Config.boSpellSendUpdateMsg then begin
    PlayObject.SendUpdateMsg(PlayObject,
      DefMsg.Ident,
      DefMsg.Tag,
      LoWord(DefMsg.Recog),
      HiWord(DefMsg.Recog),
      MakeLong(DefMsg.Param,
      DefMsg.Series),
      '');
  end
  else begin }
  PlayObject.SendMsg(PlayObject,
    DefMsg.Ident,
    DefMsg.Tag,
    LoWord(DefMsg.Recog),
    HiWord(DefMsg.Recog),
    MakeLong(DefMsg.Param, DefMsg.Series),
    '');
  //end;
end;

function TUserEngine.RegenMonsterByName(Envir: TEnvirnoment; nX, nY: Integer; sMonName: string): TBaseObject;
var
  nRace: Integer;
  BaseObject: TBaseObject;
  n18: Integer;
  MonGen: pTMonGenInfo;
begin
  Result := nil;
  if Envir = nil then exit;
  nRace := GetMonRace(sMonName);
  BaseObject := AddBaseObject(Envir, nX, nY, nRace, sMonName);
  if BaseObject <> nil then begin
    n18 := m_MonGenList.Count - 1;
    if n18 < 0 then
      n18 := 0;
    MonGen := m_MonGenList.Items[n18];
    if MonGen <> nil then begin
      MonGen.CertList.Add(BaseObject);
      BaseObject.m_PEnvir.AddObject(1);
      BaseObject.m_boAddToMaped := True;
    end;
  end;
  Result := BaseObject;
end;

function TUserEngine.RegenMonsterByName(sMAP: string; nX, nY: Integer; sMonName: string): TBaseObject;
begin
  Result := RegenMonsterByName(g_MapManager.FindMap(sMAP), nX, nY, sMonName);
end;

{function TUserEngine.RegenPlayByName(PlayObject: TPlayObject; nX, nY: Integer;
  sMonName: string): TBaseObject;
var
//  nRace: Integer;
  BaseObject: TBaseObject;
  n18: Integer;
  MonGen: pTMonGenInfo;
begin
  BaseObject := AddPlayObject(PlayObject, nX, nY, sMonName);
  if BaseObject <> nil then begin
    n18 := m_MonGenList.Count - 1;
    if n18 < 0 then n18 := 0;
    MonGen := m_MonGenList.Items[n18];
    MonGen.CertList.Add(BaseObject);
    BaseObject.m_PEnvir.AddObject(1);
    BaseObject.m_boAddToMaped := True;
    //    MainOutMessage(format('MonGet Count:%d',[MonGen.CertList.Count]));
  end;
  Result := BaseObject;
end;          }

procedure TUserEngine.Run;
//var
//  i:integer;
//  dwProcessTick:LongWord;
  procedure ShowOnlineCount();
  var
    nOnlineCount: Integer;
    nOffLineCount: Integer;
    nOnlineCount2: Integer;
    //nAutoAddExpPlayCount: Integer;
  begin
    nOnlineCount := GetUserCount;
    nOffLineCount := GetOffLinePlayCount;
    //nAutoAddExpPlayCount := 0;
    nOnlineCount2 := nOnlineCount - nOffLineCount;
    MainOutMessage(format('在线数: (%d/%d) %d', [nOnlineCount2, nOffLineCount, nOnlineCount]));
    //MainOutMessage('在线数: ' + IntToStr(nOnlineCount));
  end;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::Run';
begin
  CalceTime := GetTickCount;
  try
    if (GetTickCount() - dwShowOnlineTick) > g_Config.dwConsoleShowUserCountTime then begin
      dwShowOnlineTick := GetTickCount();
      //NoticeManager.LoadingNotice;
      ShowOnlineCount();
      //MainOutMessage('在线数: ' + IntToStr(GetUserCount));
      g_CastleManager.Save;
    end;
    if (GetTickCount() - dwSendOnlineHumTime) > 10000 then begin
      dwSendOnlineHumTime := GetTickCount();
      FrmIDSoc.SendOnlineHumCountMsg(GetOnlineHumCount);
    end;
    if (not g_boRemoteOpenGateSocketed) {$IF Public_Ver = Public_Release}and g_boCheckOk{$IFEND} then begin
      g_boRemoteOpenGateSocketed := True;
      try
        if Assigned(g_GateSocket) then begin
          g_GateSocket.Active := True;
        end;
      except
        on E: Exception do begin
          MainOutMessage(E.Message);
        end;
      end;
    end;

{$IFDEF PLUGOPEN}
    if Assigned(zPlugOfEngine.HookUserEngineRun) then begin
      try
        zPlugOfEngine.HookUserEngineRun(Self);
      except
      end;
    end;
{$ENDIF}
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

function TUserEngine.GetStdItem(nItemIdx: Integer): pTStdItem;
begin
  Result := nil;
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    Result := StdItemList.Items[nItemIdx];
    if Result.Name = '' then
      Result := nil;
  end;
end;

function TUserEngine.GetStdItem(sItemName: string): pTStdItem;
var
  i: Integer;
  StdItem: pTStdItem;
begin
  Result := nil;
  if sItemName = '' then
    Exit;
  for i := 0 to StdItemList.Count - 1 do begin
    StdItem := StdItemList.Items[i];
    if CompareText(StdItem.Name, sItemName) = 0 then begin
      Result := StdItem;
      break;
    end;
  end;
end;

function TUserEngine.GetStdItemRule(nItemIdx: Integer): pTItemRule;
begin
  Result := nil;
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    Result := pTStdItem(StdItemList.Items[nItemIdx]).Rule;
  end;
end;

function TUserEngine.GetStdItemRule(sItemName: string): pTItemRule;
var
  i: Integer;
  StdItem: pTStdItem;
begin
  Result := nil;
  if sItemName = '' then
    Exit;
  for i := 0 to StdItemList.Count - 1 do begin
    StdItem := StdItemList.Items[i];
    if CompareText(StdItem.Name, sItemName) = 0 then begin
      Result := StdItem.Rule;
      break;
    end;
  end;
end;

function TUserEngine.GetStdItemWeight(nItemIdx: Integer): Integer;
var
  StdItem: pTStdItem;
begin
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    StdItem := StdItemList.Items[nItemIdx];
    Result := StdItem.Weight;
  end
  else begin
    Result := 0;
  end;
end;

function TUserEngine.GetStdItemMode(nItemIdx: Integer): TStdMode;
begin
  Result := tm_unknown;
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    Result := pTStdItem(StdItemList.Items[nItemIdx]).StdMode;
  end;
end;

function TUserEngine.GetStdItemModeEx(nItemIdx: Integer): TStdModeEx;
begin
  Result := [];
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    Result := pTStdItem(StdItemList.Items[nItemIdx]).StdModeEx;
  end;
end;

function TUserEngine.GetStdItemName(nItemIdx: Integer): string;
begin
  Result := '';
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    Result := pTStdItem(StdItemList.Items[nItemIdx]).Name;
  end
  else
    Result := '';
end;
{
function TUserEngine.FindOtherServerUser(sName: string;
  var nServerIndex): Boolean;
begin
  Result := False;
end;
             }

procedure TUserEngine.CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY,
  nWide: Integer; sMsg: string); //黄字喊话
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if not PlayObject.m_boGhost and
      (PlayObject.m_PEnvir = pMap) and
      (PlayObject.m_boBanShout) and
      (abs(PlayObject.m_nCurrX - nX) < nWide) and
      (abs(PlayObject.m_nCurrY - nY) < nWide) then begin
      //PlayObject.SendMsg(nil,wIdent,0,0,$FFFF,0,sMsg);

      PlayObject.SendMsg(nil, wIdent, 0, g_Config.nCryMsgFColor, g_Config.nCryMsgBColor, 0, sMsg);
    end;
  end;
end;


//获取怪物爆物品
function TUserEngine.MonGetRandomItems(mon: TBaseObject; ItemList: TList): Integer;

  procedure RefItems(MonItem: pTMonItemInfo);
  var
    i: Integer;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    StdModeEx: TStdModeEx;
    vCompoundInfos: pTCompoundInfos;
  begin
    if MonItem.boGold then begin
      mon.m_nGold := mon.m_nGold + (MonItem.Count div 2) + Random(MonItem.Count);
    end
    else begin
      New(UserItem);
      if CopyToUserItemFromIdxEx(MonItem.ItemIdent, UserItem) then begin
        StdItem := GetStdItem(UserItem.wIndex);
        StdModeEx := GetStdItemModeEx(UserItem.wIndex);
        if (sm_HorseArm in StdModeEx) or (sm_ArmingStrong in StdModeEx) then begin
          UserItem.Dura := Round((UserItem.DuraMax / 100) * (20 + Random(80)));
          vCompoundInfos := GetCompoundInfos(StdItem.Name);
          if (vCompoundInfos <> nil) then
          begin
            UserItem.ComLevel := 0;
            for i := Low(g_Config.vCompoundSet.DropRate) to High(g_Config.vCompoundSet.DropRate) do
            begin
              if (Random(100) >= g_Config.vCompoundSet.DropRate[i]) then
                Break;
              UpgradeCompoundItem(UserItem, @vCompoundInfos[i]);
            end;  
          end;
          if (g_Config.nMonRandomAddValue < 100) and (Random(g_Config.nMonRandomAddValue {10}) = 0) then begin
            SetByteStatus(UserItem.btBindMode2, Ib2_Unknown, True);
            if g_Config.boMonRandomIsOpenShow then
              ItemUnit.RandomUpgradeItem(UserItem, DefUnsealItem);
          end;
        end;
        mon.m_ItemList.Add(UserItem);
      end
      else
        DisPose(UserItem);
    end;
  end;

  procedure GetItemsList(List: TList; boRandom: Boolean);
  var
    i: Integer;
    MonItem: pTMonItemInfo;
  begin
    if boRandom then begin
      if List.Count > 0 then begin
        MonItem := pTMonItemInfo(List[Random(List.Count)]);
        if MonItem.List <> nil then begin
          GetItemsList(MonItem.List, MonItem.boRandom);
        end else
          RefItems(MonItem);
      end;
    end else begin
      for i := 0 to List.Count - 1 do begin
        MonItem := pTMonItemInfo(List[i]);
        if Random(MonItem.MaxPoint) <= MonItem.SelPoint then begin
          if MonItem.List <> nil then begin
            GetItemsList(MonItem.List, MonItem.boRandom);
          end else
            RefItems(MonItem);
        end;
      end;
    end;
  end;
begin
  if ItemList <> nil then begin
    GetItemsList(ItemList, False);
  end;
  Result := 1;
end;
{
procedure TUserEngine.RandomUpgradeItem(Item: pTUserItem);
var
StdItem: pTStdItem;
begin
StdItem := GetStdItem(Item.wIndex);
if StdItem = nil then Exit;
SetByteStatus(Item.btBindMode2, Ib2_Unknown, False);
Item.DuraMax := StdItem.DuraMax;
SafeFillChar(Item.Value, SizeOf(Item.Value), #0);
Item.Dura := ROUND((Item.DuraMax / 100) * (20 + Random(80)));
{case StdItem.StdMode of
 tm_Weapon: ItemUnit.RandomUpgradeWeapon(Item); //004AD14A
 tm_Dress: ItemUnit.RandomUpgradeDress(Item);
 tm_Necklace: ItemUnit.RandomUpgrade19(Item);
 tm_Ring: ItemUnit.RandomUpgrade26(Item);
 tm_ArmRing: ItemUnit.RandomUpgrade22(Item);
end;
end;    }
{
procedure TUserEngine.GetUnknowItemValue(Item: pTUserItem); //004AD1D4
var
StdItem: pTStdItem; //神秘装备
begin
StdItem := GetStdItem(Item.wIndex);
if StdItem = nil then
 Exit;
case StdItem.StdMode of
 ts_Helmet: ItemUnit.UnknowHelmet(Item);
 ts_ArmRing: ItemUnit.UnknowRing(Item);
 ts_Ring: ItemUnit.UnknowNecklace(Item);
end;
end; }

function TUserEngine.CopyToUserItemFromIdx(nIdx: Integer; Item: pTUserItem): Boolean;
var
  StdItem: pTStdItem;
begin
  Result := False;
  Dec(nIdx);
  if (nIdx >= 0) and (nIdx < StdItemList.Count) then begin
    StdItem := StdItemList[nIdx];
    SafeFillChar(Item^, SizeOf(TUserItem), #0);
    Item.wIndex := nIdx + 1;
    Item.MakeIndex := GetItemNumber();
    if StdItem.StdMode <> tm_House then begin
      if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then
        Item.Dura := 1
      else
        Item.Dura := StdItem.DuraMax;
      Item.DuraMax := StdItem.DuraMax;
    end else begin
      Item.btLevel := 1;
      Item.dwMaxExp := g_Config.HorseLevelExp[1];
      //Item.wHealth := StdItem.DuraMax;
      Item.wHP := 14;
    end;
    //Item.Value.btWuXin := Random(5) + 1;
    //RandomInitializeStrengthenInfo(Item);
    Result := True;
  end;
end;

function TUserEngine.CopyToUserItemFromIdxEx(nIdx: Integer; Item: pTUserItem): Boolean;
var
  StdItem: pTStdItem;
begin
  Result := False;
  Dec(nIdx);
  if (nIdx >= 0) and (nIdx < StdItemList.Count) then begin
    StdItem := StdItemList[nIdx];
    SafeFillChar(Item^, SizeOf(TUserItem), #0);
    Item.wIndex := nIdx + 1;
    Item.MakeIndex := 0;
    if StdItem.StdMode <> tm_House then begin
      if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then
        Item.Dura := 1
      else
        Item.Dura := StdItem.DuraMax;
      Item.DuraMax := StdItem.DuraMax;
    end else begin
      Item.btLevel := 1;
      Item.dwMaxExp := g_Config.HorseLevelExp[1];
      //Item.wHealth := StdItem.DuraMax;
      Item.wHP := 14;
    end;

    //Item.Value.btWuXin := Random(5) + 1;
    //RandomInitializeStrengthenInfo(Item);
    Result := True;
  end;
end;

function TUserEngine.CopyToUserItemFromName(sItemName: string; Item: pTUserItem): Boolean;
var
  i: Integer;
  StdItem: pTStdItem;
begin
  Result := False;
  if sItemName <> '' then begin
    for i := 0 to StdItemList.Count - 1 do begin
      StdItem := StdItemList.Items[i];
      if CompareText(StdItem.Name, sItemName) = 0 then begin
        SafeFillChar(Item^, SizeOf(TUserItem), #0);
        Item.wIndex := i + 1;
        Item.MakeIndex := GetItemNumber();
        if StdItem.StdMode <> tm_House then begin
          if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then
            Item.Dura := 1
          else
            Item.Dura := StdItem.DuraMax;
          Item.DuraMax := StdItem.DuraMax;
        end else begin
          Item.btLevel := 1;
          Item.dwMaxExp := g_Config.HorseLevelExp[1];
          //Item.wHealth := StdItem.DuraMax;
          Item.wHP := 14;
        end;
        //Item.Value.btWuXin := Random(5) + 1;
        //RandomInitializeStrengthenInfo(Item);
        Result := True;
        break;
      end;
    end;
  end;
end;

function TUserEngine.CopyToUserItemFromNameEx(sItemName: string; Item: pTUserItem; boWuXin: Boolean): Boolean;
var
  i: Integer;
  StdItem: pTStdItem;
begin
  Result := False;
  if sItemName <> '' then begin
    for i := 0 to StdItemList.Count - 1 do begin
      StdItem := StdItemList.Items[i];
      if CompareText(StdItem.Name, sItemName) = 0 then begin
        SafeFillChar(Item^, SizeOf(TUserItem), #0);
        Item.wIndex := i + 1;
        Item.MakeIndex := 0;
        if StdItem.StdMode <> tm_House then begin
          if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then
            Item.Dura := 1
          else
            Item.Dura := StdItem.DuraMax;
          Item.DuraMax := StdItem.DuraMax;
        end else begin
          Item.btLevel := 1;
          Item.dwMaxExp := g_Config.HorseLevelExp[1];
          //Item.wHealth := StdItem.DuraMax;
          Item.wHP := 14;
        end;
        {if boWuXin then begin
          Item.Value.btWuXin := Random(5) + 1;
          RandomInitializeStrengthenInfo(Item);
        end;  }
        Result := True;
        break;
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessUserMessage(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; Buff: PChar);
var
  sMsg: string;
  //  NewBuff: array[0..DATA_BUFSIZE - 1] of Char;
  //  sDefMsg: string;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessUserMessage..';
begin
  if (DefMsg = nil) or (PlayObject = nil) then
    Exit;
  try
    if Buff = nil then
      sMsg := ''
    else
      sMsg := StrPas(Buff);
    if (DefMsg.Ident >= RG_MINMSGINDEX) and (DefMsg.Ident <= RG_MAXMSGINDEX) then begin
      if (not PlayObject.m_boMapApoise) and (PlayObject.m_boUserLogon) and (DefMsg.Ident <> CM_MAPAPOISE) then begin
        MainOutMessage('[MapApoise] ' + PlayObject.m_sCharName + ' ' + PlayObject.m_sIPaddr + ' ' + IntToStr(DefMsg.Ident));
        exit;
      end;
      if (Assigned(FProcessUserMessage[DefMsg.Ident])) then begin
        FProcessUserMessage[DefMsg.Ident](PlayObject, DefMsg, sMsg);
      end
      else begin
{$IFDEF PLUGOPEN}
        if Assigned(zPlugOfEngine.HookUserEngineClientUserMessage) then begin
          try
            zPlugOfEngine.HookUserEngineClientUserMessage(PlayObject, DefMsg, Buff);
          except
          end;
        end
        else begin
{$ENDIF}
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            sMsg);
{$IFDEF PLUGOPEN}
        end;
{$ENDIF}
      end;
      if PlayObject.m_boReadyRun then begin
        if DefMsg.Ident in [CM_TURN..CM_BUTCH] then
          Dec(PlayObject.m_dwRunTick, 100);
      end;
    end
    else begin
      MainOutMessage('[封包攻击] ' + PlayObject.m_sCharName + ' ' + PlayObject.m_sIPLocal + ' ' + IntToStr(DefMsg.Ident));
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;
{
procedure TUserEngine.SendServerGroupMsg(nCode, nServerIdx: Integer;
  sMsg: string);
begin
  if nServerIndex = 0 then begin
    FrmSrvMsg.SendSocketMsg(IntToStr(nCode) + '/' +
      EncodeString(IntToStr(nServerIdx)) + '/' + EncodeString(sMsg));
  end
  else begin
    FrmMsgClient.SendSocket(IntToStr(nCode) + '/' +
      EncodeString(IntToStr(nServerIdx)) + '/' + EncodeString(sMsg));
  end;
end;  }

function TUserEngine.AddBaseObject(Envir:TEnvirnoment; nX, nY: Integer; nMonRace:
  Integer; sMonName: string): TBaseObject; //004AD56C
var
  Cert: TBaseObject;
  n1C, n20, n24: Integer;
  p28: Pointer;
begin
  Result := nil;
  Cert := nil;
  if Envir = nil then Exit;
  case nMonRace of
    11: Cert := TSuperGuard.Create;
    12: Cert := TMoveSuperGuard.Create;

    20: Cert := TArcherPolice.Create;
    30: begin
        Cert := TBoxMonster.Create;
      end;
    31: Cert := TCamionMonster.Create;
    51: begin
        Cert := TMonster.Create;
        Cert.m_boAnimal := True;
        Cert.m_nMeatQuality := Random(3500) + 3000;
        Cert.m_nBodyLeathery := 50;
      end;
    52: begin
        if Random(30) = 0 then begin
          Cert := TChickenDeer.Create;
          Cert.m_boAnimal := True;
          Cert.m_nMeatQuality := Random(20000) + 10000;
          Cert.m_nBodyLeathery := 150;
        end
        else begin
          Cert := TMonster.Create;
          Cert.m_boAnimal := True;
          Cert.m_nMeatQuality := Random(8000) + 8000;
          Cert.m_nBodyLeathery := 150;
        end;
      end;
    53: begin
        Cert := TATMonster.Create;
        Cert.m_boAnimal := True;
        Cert.m_nMeatQuality := Random(8000) + 8000;
        Cert.m_nBodyLeathery := 150;
      end;
    54: begin
        Cert := TChickenDeer.Create;
          Cert.m_boAnimal := True;
          Cert.m_nMeatQuality := Random(20000) + 10000;
          Cert.m_nBodyLeathery := 150;
      end;
    55: begin
        Cert := TTrainer.Create;
        Cert.m_btRaceServer := 55;
      end;
    57: begin
        Cert := TDrunkardMonster.Create;
        Cert.m_nMeatQuality := Random(20000) + 10000;
        Cert.m_nBodyLeathery := 150;
      end;
    58: begin
        Cert := THorseMonster.Create;
        Cert.m_nMeatQuality := Random(20000) + 10000;
        Cert.m_nBodyLeathery := 150;
      end;
    //60: Cert := TCloneObject.Create;
    80: Cert := TMonster.Create;
    81: Cert := TATMonster.Create;
    82: Cert := TSpitSpider.Create;
    83: Cert := TSlowATMonster.Create;
    84: Cert := TScorpion.Create;
    85: Cert := TStickMonster.Create;
    86: Cert := TATMonster.Create;
    87: Cert := TDualAxeMonster.Create;
    88: Cert := TATMonster.Create;
    89: Cert := TATMonster.Create;
    90: Cert := TGasAttackMonster.Create;
    91: Cert := TMagCowMonster.Create;
    92: Cert := TCowKingMonster.Create;
    93: Cert := TThornDarkMonster.Create;
    94: Cert := TLightingZombi.Create;
    95: begin
        Cert := TDigOutZombi.Create;
        if Random(2) = 0 then
          Cert.bo2BA := True;
      end;
    96: begin
        Cert := TZilKinZombi.Create;
        if Random(4) = 0 then
          Cert.bo2BA := True;
      end;
    97: begin
        Cert := TCowMonster.Create;
        if Random(2) = 0 then
          Cert.bo2BA := True;
      end;

    98: Cert := TCriticalMon.Create;
    99: Cert := TPakNewMon.Create;
    100: Cert := TWhiteSkeleton.Create;
    101: begin
        Cert := TScultureMonster.Create;
        Cert.bo2BA := True;
      end;
    102: Cert := TScultureKingMonster.Create;
    103: Cert := TBeeQueen.Create;
    104: Cert := TArcherMonster.Create;
    105: Cert := TGasMothMonster.Create; //楔蛾
    106: Cert := TGasDungMonster.Create;
    107: Cert := TCentipedeKingMonster.Create;
    108: begin
        Cert := TFiredrakeGeneralMonster.Create;
        Cert.bo2BA := True;
      end;
    109: Cert := TFiredrakeBodyguardMon.Create;  //火龙护卫
    110: Cert := TCastleDoor.Create;
    111: Cert := TWallStructure.Create;
    112: Cert := TArcherGuard.Create; //弓剪护卫
    113: Cert := TElfMonster.Create;
    114: Cert := TElfWarriorMonster.Create;
    115: Cert := TBigHeartMonster.Create;
    116: Cert := TSpiderHouseMonster.Create;
    117: Cert := TExplosionSpider.Create;
    118: Cert := THighRiskSpider.Create;
    119: Cert := TBigPoisionSpider.Create;
    120: Cert := TSoccerBall.Create;
    121: Cert := TLeiyanAraneidMon.Create;
    122: Cert := TGreenAraneidMon.Create;
    123: Cert := TBlackPoisionSpider.Create;
    124: Cert := TSnowfieldWarriorMon.Create;
    125: begin
        Cert := TSnowfieldKavassMon.Create;
        Cert.bo2BA := True;
        TSnowfieldKavassMon(Cert).m_boEspecial := False;
      end;
    126: begin
        Cert := TSnowfieldKavassMon.Create;
        Cert.bo2BA := True;
        TSnowfieldKavassMon(Cert).m_boEspecial := True;
      end;
    127: Cert := TSnowfieldForceMon.Create;
    128: Cert := TMoonMonster.Create;
    150: Cert := TElectronicScolpionMon.Create;
    151: Cert := TDualEffectMonster.Create;
    152: Cert := TPillarMonster.Create;
    170: Cert := TAomaKingMonster.Create;    //新沃玛教主
    171: Cert := TZhumaKingMonster.Create;    //新祖玛教主
    172: Cert := TMolongKindMonster.Create;    //新魔龙教主
    173: Cert := TFiredrakeKingMonster.Create;    //新火龙神
    174: Cert := TXueyuKindMonster.Create;    //雪域魔王
    175: Cert := TLeiyanKindMonster.Create;    //雷炎蛛王
    176: Cert := TM2N4XMonster.Create;
    177: Cert := TM2N7XKindMonster.Create;
    178: Cert := TM3N4XKindMonster.Create;
    179: Cert := TM5N9XKindMonster.Create;
    180: Cert := TM6N9XKindMonster.Create;
    181: Cert := TM7N9XKindMonster.Create;
    182: Cert := TM6N4XKingMonster.Create;
    //150: Cert := TPlayMonster.Create;
  end;

  if Cert <> nil then begin
    //2010-02-06 修改，将怪物可爆物品刷新加于死亡函数当中，以节约内存
    Cert.m_CanDropItemList := MonInitialize(Cert, sMonName); //取得怪物爆物品内容
    //MonGetRandomItems(Cert, MonInitialize(Cert, sMonName)); //取得怪物爆物品内容
    Cert.m_PEnvir := Envir;
    Cert.m_sMapName := Envir.sMapName;
    Cert.m_nCurrX := nX;
    Cert.m_nCurrY := nY;
    Cert.m_btDirection := Random(8);
    Cert.m_sCharName := sMonName;
    Cert.m_WAbil := Cert.m_Abil;

    if (nMonRace > RC_CAMION) and (not (nMonRace in [110..112])) then Cert.m_btWuXin := Random(6);
    if Random(100) < Cert.m_btCoolEye then
      Cert.m_boCoolEye := True;
    Cert.Initialize();

    {if nMonRace = 150 then begin
      Cert.m_nCopyHumanLevel := 0;
      Cert.m_Abil.MP := Cert.m_Abil.MaxMP;
      Cert.m_Abil.HP := Cert.m_Abil.MaxHP;
      Cert.m_WAbil := Cert.m_Abil;
      TPlayMonster(Cert).InitializeMonster; //初始化人形怪物
      //Cert.RecalcAbilitys;
      //MainOutMessage('Cert.m_WAbil.HP:' + IntToStr(Cert.m_WAbil.HP));
    end;   }

    if Cert.m_boAddtoMapSuccess then begin
      p28 := nil;
      if Cert.m_PEnvir.m_nWidth < 50 then
        n20 := 2
      else
        n20 := 3;
      if (Cert.m_PEnvir.m_nHeight < 250) then begin
        if (Cert.m_PEnvir.m_nHeight < 30) then
          n24 := 2
        else
          n24 := 20;
      end
      else
        n24 := 50;
      n1C := 0;
      while (True) do begin
        if not Cert.m_PEnvir.CanWalk(Cert.m_nCurrX, Cert.m_nCurrY, False) then begin
          if (Cert.m_PEnvir.m_nWidth - n24 - 1) > Cert.m_nCurrX then begin
            Inc(Cert.m_nCurrX, n20);
          end
          else begin
            Cert.m_nCurrX := Random(Cert.m_PEnvir.m_nWidth div 2) + n24;
            if Cert.m_PEnvir.m_nHeight - n24 - 1 > Cert.m_nCurrY then begin
              Inc(Cert.m_nCurrY, n20);
            end
            else begin
              Cert.m_nCurrY := Random(Cert.m_PEnvir.m_nHeight div 2) + n24;
            end;
          end;
        end
        else begin
          p28 := Cert.m_PEnvir.AddToMap(Cert.m_nCurrX, Cert.m_nCurrY, OS_MOVINGOBJECT, Cert);
          break;
        end;
        Inc(n1C);
        if n1C >= 31 then
          break;
      end;
      if p28 = nil then begin
        Cert.Free;
        Cert := nil;
      end;
    end;
  end;
  Result := Cert;
  if (Cert <> nil) and (Envir.m_boFB) then Envir.m_MonsterList.Add(Cert);
end;
//====================================================
//功能:创建怪物对象
//返回值：在指定时间内创建完对象，则返加TRUE，如果超过指定时间则返回FALSE
//====================================================

function TUserEngine.RegenMonsters(MonGen: pTMonGenInfo; nCount: Integer; boTick: Boolean): Boolean;
var
  dwStartTick: LongWord;

  nX: Integer;
  nY: Integer;
  i: Integer;
  Cert: TBaseObject;
  boRunScript: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::RegenMonsters';
begin
  Result := True;
  boRunScript := False;
  dwStartTick := GetTickCount();
  try
    if MonGen <> nil then begin
      if MonGen.nRace > 0 then begin
        if Random(100) < MonGen.nMissionGenRate then begin
          nX := (MonGen.nX - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          nY := (MonGen.nY - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          for i := 0 to nCount - 1 do begin
            Cert := AddBaseObject(MonGen.Envir, ((nX - 10) + Random(20)), ((nY - 10) + Random(20)), MonGen.nRace, MonGen.sMonName);
            if Cert <> nil then begin
              MonGen.CertList.Add(Cert);
              if (MonGen.nFlagInfo or $01) = MonGen.nFlagInfo then
                Cert.m_boSuperMan := True;
              if (not boRunScript) then begin
                boRunScript := True;
                Cert.m_nDieScript := MonGen.nDieScript;
                Cert.HintGotoScript(MonGen.nMakeScript);
              end;
            end;
            if boTick and ((GetTickCount - dwStartTick) > g_dwZenLimit) then begin
              Result := False;
              break;
            end;
          end;
        end
        else begin
          for i := 0 to nCount - 1 do begin
            nX := (MonGen.nX - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
            nY := (MonGen.nY - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
            Cert := AddBaseObject(MonGen.Envir, nX, nY, MonGen.nRace, MonGen.sMonName);
            if Cert <> nil then begin
              MonGen.CertList.Add(Cert);
              if (MonGen.nFlagInfo or $01) = MonGen.nFlagInfo then
                Cert.m_boSuperMan := True;
              if (not boRunScript) then begin
                boRunScript := True;
                Cert.m_nDieScript := MonGen.nDieScript;
                Cert.HintGotoScript(MonGen.nMakeScript);
              end;
            end;
            if boTick and ((GetTickCount - dwStartTick) > g_dwZenLimit) then begin
              Result := False;
              break;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

function TUserEngine.GetPlayObject(sName: string): TPlayObject;
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  Result := nil;
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    if CompareText(m_PlayObjectList.Strings[i], sName) = 0 then begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
      if PlayObject <> nil then begin
        if (not PlayObject.m_boGhost) and (PlayObject.m_boMapApoise) then begin
          if not (PlayObject.m_boObMode and PlayObject.m_boAdminMode) then
            Result := PlayObject;
        end;
        break;
      end;
    end;
  end;
end;

function TUserEngine.GetPlayObject(PlayObject: TPlayObject): TPlayObject;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    if PlayObject = TPlayObject(m_PlayObjectList.Objects[i]) then begin
      if PlayObject <> nil then begin
        Result := PlayObject;
        break;
      end;
    end;
  end;
end;

function TUserEngine.InPlayObjectList(PlayObject: TPlayObject): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    if (PlayObject <> nil) and (PlayObject =
      TPlayObject(m_PlayObjectList.Objects[i])) then begin
      Result := True;
      break;
    end;
  end;
end;

procedure TUserEngine.KickPlayObjectEx(sAccount, sName: string);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for i := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
      if PlayObject <> nil then begin
        if {(CompareText(PlayObject.m_sUserID, sAccount) = 0) and  }
          (CompareText(m_PlayObjectList.Strings[i], sName) = 0) then begin
          PlayObject.m_boEmergencyClose := True;
          PlayObject.m_boPlayOffLine := False;
          break;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TUserEngine.GetPlayObjectEx(sAccount, sName: string): TPlayObject;
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  Result := nil;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for i := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
      if (PlayObject <> nil) then begin
        if {(CompareText(PlayObject.m_sUserID, sAccount) = 0) and }
          (CompareText(m_PlayObjectList.Strings[i], sName) = 0) then begin
          Result := PlayObject;
          break;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

{$IF Public_Ver = Public_Test}
function TUserEngine.GetPlayObjectList: TStringList;
begin
  Result := m_TestObjectList;
end;
{$IFEND}

function TUserEngine.FindMerchant(Merchant: TObject): TMerchant;
var
  i: Integer;
begin
  Result := nil;
  m_MerchantList.Lock;
  try
    for i := 0 to m_MerchantList.Count - 1 do begin
      if (TObject(m_MerchantList.Items[i]) <> nil) and
        (TObject(m_MerchantList.Items[i]) = Merchant) then begin
        Result := TMerchant(m_MerchantList.Items[i]);
        break;
      end;
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;

function TUserEngine.FindNPC(GuildOfficial: TObject): TGuildOfficial;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to QuestNPCList.Count - 1 do begin
    if (TObject(QuestNPCList.Items[i]) <> nil) and
      (TObject(QuestNPCList.Items[i]) = GuildOfficial) then begin
      Result := TGuildOfficial(QuestNPCList.Items[i]);
      break;
    end;
  end;
end;

function TUserEngine.GetMapOfRangeHumanCount(Envir: TEnvirnoment; nX, nY,
  nRange: Integer): Integer;
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  Result := 0;
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if PlayObject <> nil then begin
      if not PlayObject.m_boGhost and (PlayObject.m_PEnvir = Envir) then begin
        if (abs(PlayObject.m_nCurrX - nX) < nRange) and (abs(PlayObject.m_nCurrY
          - nY) < nRange) then
          Inc(Result);
      end;
    end;
  end;
end;

function TUserEngine.GetHumPermission(sUserName: string; var sIPaddr: string; var
  btPermission: Byte): Boolean; //4AE590
var
  i: Integer;
  AdminInfo: pTAdminInfo;
begin
  Result := False;
  btPermission := g_Config.nStartPermission;
  m_AdminList.Lock;
  try
    for i := 0 to m_AdminList.Count - 1 do begin
      AdminInfo := m_AdminList.Items[i];
      if AdminInfo <> nil then begin
        if CompareText(AdminInfo.sChrName, sUserName) = 0 then begin
          btPermission := AdminInfo.nLv;
          sIPaddr := AdminInfo.sIPaddr;
          Result := True;
          break;
        end;
      end;
    end;
  finally
    m_AdminList.UnLock;
  end;
end;
{
procedure TUserEngine.AddSendDBInfo(SendDBSInfo: pTSendDBSInfo);
begin
  EnterCriticalSection(m_LoadPlaySection);
  try
    m_SendDBList.Add(SendDBSInfo);
  finally
    LeaveCriticalSection(m_LoadPlaySection);
  end;
end;     }

procedure TUserEngine.AddUserOpenInfo(UserOpenInfo: pTUserOpenInfo);
begin
  EnterCriticalSection(m_LoadPlaySection);
  try
    m_LoadPlayList.AddObject(UserOpenInfo.sChrName, TObject(UserOpenInfo));
  finally
    LeaveCriticalSection(m_LoadPlaySection);
  end;
end;

procedure TUserEngine.KickAllOffLine;
var
  I: Integer;
begin
  m_OffLineList.Lock;
  try
    for i := m_OffLineList.Count - 1 downto 0 do begin
      TPlayObject(m_OffLineList.Objects[I]).MakeGhost;
    end;
    m_OffLineList.Clear;
  finally
    m_OffLineList.UnLock;
  end;
end;

procedure TUserEngine.KickOnlineUser(sChrName: string);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if PlayObject <> nil then begin
      if CompareText(PlayObject.m_sCharName, sChrName) = 0 then begin
        PlayObject.m_boKickFlag := True;
        break;
      end;
    end;
  end;
end;
{
function TUserEngine.SendSwitchData(PlayObject: TPlayObject; nServerIndex:
  Integer): Boolean;
begin
  Result := True;
end;   }
 {
procedure TUserEngine.SetSortList(nIdx: Integer; sMsg: string);
begin
  EnterCriticalSection(m_LoadPlaySection);
  try
    case nIdx of
      DBT_SELFALL: DecodeBuffer(sMsg, @g_TaxisAllList, SizeOf(g_TaxisAllList));
      DBT_SELFWARR: DecodeBuffer(sMsg, @g_TaxisWarrList,
        SizeOf(g_TaxisWarrList));
      DBT_SELFWAID: DecodeBuffer(sMsg, @g_TaxisWaidList,
        SizeOf(g_TaxisWaidList));
      DBT_SELFTAOS: DecodeBuffer(sMsg, @g_TaxisTaosList,
        SizeOf(g_TaxisTaosList));
      DBT_MASTER: DecodeBuffer(sMsg, @g_TaxisMasterList,
        SizeOf(g_TaxisMasterList));
      DBT_HEROALL: DecodeBuffer(sMsg, @g_TaxisHeroAllList,
        SizeOf(g_TaxisHeroAllList));
      DBT_HEROWARR: DecodeBuffer(sMsg, @g_TaxisHeroWarrList,
        SizeOf(g_TaxisHeroWarrList));
      DBT_HEROWAID: DecodeBuffer(sMsg, @g_TaxisHeroWaidList,
        SizeOf(g_TaxisHeroWaidList));
      DBT_HEROTAOS: DecodeBuffer(sMsg, @g_TaxisHeroTaosList,
        SizeOf(g_TaxisHeroTaosList));
    end;
  finally
    LeaveCriticalSection(m_LoadPlaySection);
  end;
end;             }
{
procedure TUserEngine.SendChangeServer(PlayObject: TPlayObject; nServerIndex:
  Integer);
var
  sIPaddr: string;
  nPort: Integer;
resourcestring
  sMsg = '%s/%d';
begin
  if GetMultiServerAddrPort(nServerIndex, sIPaddr, nPort) then begin
    PlayObject.SendDefMessage(SM_RECONNECT, 0, 0, 0, 0, format(sMsg, [sIPaddr, nPort]));
  end;
end;      }

procedure TUserEngine.SaveHumanRcd(PlayObject: TPlayObject);
var
  SaveRcd: pTSaveRcd;
begin
  New(SaveRcd);
  SafeFillChar(SaveRcd^, SizeOf(TSaveRcd), #0);
  SaveRcd.sAccount := PlayObject.m_sUserID;
  SaveRcd.sChrName := PlayObject.m_sCharName;
  SaveRcd.nSessionID := PlayObject.m_nSessionID;
  SaveRcd.nDBIndex := PlayObject.m_nDBIndex;
  SaveRcd.boGhost := PlayObject.m_boGhost;
  //SaveRcd.PlayObject := PlayObject;
  SaveRcd.nReTryCount := 0;
  SaveRcd.dwSaveTick := GetTickCount;
  PlayObject.MakeSaveRcd(SaveRcd.HumanRcd);
  //FrontEngine.AddToSaveRcdList(SaveRcd);
  Try
    FrontEngine.UpDataSaveRcdList(SaveRcd); //2006-11-12修改
  Except
    on E: Exception do begin
      MainOutMessage('[Exception] TUserEngine.SaveHumanRcd');
      MainOutMessage(E.Message);
    end;
  End;
end;

procedure TUserEngine.AddToHumanFreeList(PlayObject: TPlayObject);
begin
  PlayObject.m_dwGhostTick := GetTickCount();
  m_PlayObjectFreeList.Add(PlayObject);
end;

{function TUserEngine.GetSwitchData(sChrName: string; nCode: Integer): pTSwitchDataInfo;
var
  i: Integer;
  SwitchData: pTSwitchDataInfo;
begin
  Result := nil;
  for i := 0 to m_ChangeServerList.Count - 1 do begin
    SwitchData := m_ChangeServerList.Items[i];
    if SwitchData <> nil then begin
      if (CompareText(SwitchData.sChrName, sChrName) = 0) and (SwitchData.nCode = nCode) then begin
        Result := SwitchData;
        break;
      end;
    end;
  end;
end;       }

procedure TUserEngine.GetHumData(PlayObject: TPlayObject; var HumanRcd: THumDataInfo);
var
  HumData: pTHumData;
//  HumItems: pTHumanUseItems;
  //HumAddItems: pTHumAddItems;
  BagItems: pTBagItems;
  UserItem: pTUserItem;
  HumMagics: pTHumMagics;
  UserMagic: pTUserMagic;
  MagicInfo: pTMagic;
  StorageItems: pTStorageItems;
  StorageItem: pTStorageItem;
  i: Integer;
  nMagTick: Int64;
  DTime: TDateTime;
  TempTick: LongWord;
  nYear, nMonth, nDay,mYear, mMonth, mDay: Word;
begin
  TempTick := GetTickCount;
  DTime := Now;
  HumData := @HumanRcd.Data;
  PlayObject.m_Header := HumanRcd.Header;
  PlayObject.m_nDBIndex := HumData.nIdx;
  PlayObject.m_OldLoginAddr := HumData.LoginAddr;
  PlayObject.m_OldLoginTime := HumData.LoginTime;
  PlayObject.m_sCharName := HumData.sChrName;
  PlayObject.m_sMapName := HumData.sCurMap;
  PlayObject.m_nCurrX := HumData.wCurX;
  PlayObject.m_nCurrY := HumData.wCurY;
  PlayObject.m_btDirection := HumData.btDir;
  PlayObject.m_btHair := HumData.btHair;
  PlayObject.m_btGender := HumData.btSex;
  PlayObject.m_btJob := HumData.btJob;
  PlayObject.m_nGold := HumData.nGold;
  PlayObject.m_nBindGold := HumData.nBindGold;

  PlayObject.m_Abil.Level := HumData.Abil.Level;

  {PlayObject.m_DBAbil.AC := HumData.Abil.AC;
  PlayObject.m_DBAbil.MAC := HumData.Abil.MAC;
  PlayObject.m_DBAbil.DC := HumData.Abil.DC;
  PlayObject.m_DBAbil.MC := HumData.Abil.MC;
  PlayObject.m_DBAbil.SC := HumData.Abil.SC; }

  PlayObject.m_Abil.HP := HumData.Abil.HP;
  PlayObject.m_Abil.MP := HumData.Abil.MP;
  PlayObject.m_Abil.MaxHP := HumData.Abil.MaxHP;
  PlayObject.m_Abil.MaxMP := HumData.Abil.MaxMP;
  PlayObject.m_Abil.Exp := HumData.Abil.Exp;
  PlayObject.m_Abil.MaxExp := HumData.Abil.MaxExp;
  PlayObject.m_Abil.Weight := HumData.Abil.Weight;
  PlayObject.m_Abil.MaxWeight := HumData.Abil.MaxWeight;
  PlayObject.m_Abil.WearWeight := HumData.Abil.WearWeight;
  PlayObject.m_Abil.MaxWearWeight := HumData.Abil.MaxWearWeight;
  PlayObject.m_Abil.HandWeight := HumData.Abil.HandWeight;
  PlayObject.m_Abil.MaxHandWeight := HumData.Abil.MaxHandWeight;
  {if PlayObject.m_Abil.Exp <= 0 then
    PlayObject.m_Abil.Exp := 1;  }
  //if PlayObject.m_Abil.MaxExp <= 0 then begin
  PlayObject.m_Abil.MaxExp := PlayObject.GetLevelExp(PlayObject.m_Abil.Level);
  //end;
  //PlayObject.m_Abil:=HumData.Abil;
  PlayObject.m_NakedAbil := HumData.NakedAbil;
  PlayObject.m_nNakedCount := HumData.nNakedAbilCount;
  PlayObject.m_nNakedBackCount := HumData.wNakedBackCount;

  PlayObject.m_wStatusTimeArr := HumData.wStatusTimeArr;
  PlayObject.m_sHomeMap := HumData.sHomeMap;
  PlayObject.m_nHomeX := HumData.wHomeX;
  PlayObject.m_nHomeY := HumData.wHomeY;
  PlayObject.m_sDieMap := HumData.sDieMap;
  PlayObject.m_nDieX := HumData.wDieX;
  PlayObject.m_nDieY := HumData.wDieY;

  PlayObject.m_sDearName := HumData.sDearName;
  for I := Low(HumData.MasterName) to High(HumData.MasterName) do begin
    if HumData.MasterName[I] = '' then Continue;
    PlayObject.m_MasterList.Add(HumData.MasterName[I]);
  end;
  if PlayObject.m_MasterList.Count <= 0 then PlayObject.m_boMaster := False
  else PlayObject.m_boMaster := HumData.boMaster;
  PlayObject.m_CustomVariable := HumData.CustomVariable;
  PlayObject.m_nCreditPoint := HumData.btCreditPoint;

  PlayObject.m_sStoragePwd := HumData.sStoragePwd;
  PlayObject.m_nStorageGold := HumData.nStorageGold;
  PlayObject.m_boStorageLock := HumData.boStorageLock;
  PlayObject.m_btStorageErrorCount := HumData.btStorageErrorCount;
  PlayObject.m_StorageLockTime := HumData.StorageLockTime;
  PlayObject.m_btReLevel := HumData.btReLevel;
  //PlayObject.m_BonusAbil := HumData.BonusAbil; // 08/09
  //PlayObject.m_nBonusPoint := HumData.nBonusPoint; // 08/09

  PlayObject.m_nGameGold := HumData.nGameGold;
  //PlayObject.m_nGamePoint := HumData.nGamePoint;
  PlayObject.m_nGameDiamond := HumData.nGameDiamond;
  PlayObject.m_nGameGird := HumData.nGameGird;
  //PlayObject.m_nPayMentPoint := HumData.nPayMentPoint;
  PlayObject.m_nPkPoint := HumData.nPKPOINT;
  PlayObject.m_MissionInfo := HumData.MissionInfo;

  nMagTick := MinutesBetween(DTime, HumanRcd.Header.dwUpdateDate);
  if nMagTick > MAXPULLULATION then
    PlayObject.m_nPullulation := MAXPULLULATION
  else
    PlayObject.m_nPullulation := _MIN(HumData.nPullulation + nMagTick * g_Config.nPullulationCount, MAXPULLULATION);

  for I := Low(PlayObject.m_MissionInfo) to High(PlayObject.m_MissionInfo) do begin
    if (PlayObject.m_MissionInfo[I].sMissionName <> '') and (PlayObject.m_MissionInfo[I].wTime > 0) then begin
      if PlayObject.m_MissionInfo[I].wTime > nMagTick then Dec(PlayObject.m_MissionInfo[I].wTime, nMagTick)
      else PlayObject.m_MissionInfo[I].wTime := 1;
    end;
  end;


  //HumanRcd.Header.dwUpdateDate
  //PlayObject.m_MagicConcatenation := HumData.btMagicConcatenation;

  PlayObject.m_nAllowSetup := HumData.nAllowSetup;

  //PlayObject.m_boCheckGroup := HumData.boCheckGroup;
  //PlayObject.btB2 := HumData.btF9;
  PlayObject.m_btAttatckMode := HumData.btAttatckMode;
  PlayObject.m_nIncHealth := HumData.nIncHealth;
  PlayObject.m_nIncSpell := HumData.nIncSpell;
  PlayObject.m_nIncHealing := HumData.nIncHealing;
  PlayObject.m_nFightZoneDieCount := HumData.btFightZoneDieCount;
  PlayObject.m_sUserID := HumData.sAccount;
  PlayObject.m_sGuildName := HumData.sGuildName;
  //PlayObject.m_boLockLogon := HumData.boLockLogon;
  PlayObject.m_wContribution := HumData.wContribution;
  //PlayObject.m_nHungerStatus := HumData.nHungerStatus;
  //PlayObject.m_boAllowGuildReCall := HumData.boAllowGuildReCall;
  PlayObject.m_wGuildRcallTime := HumData.wGuildRcallTime;
  PlayObject.m_wGroupRcallTime := HumData.wGroupRcallTime;
  PlayObject.m_dBodyLuck := HumData.dBodyLuck;
  //PlayObject.m_boAllowGroupReCall := HumData.boAllowGroupReCall;

  PlayObject.m_RealityInfo := HumData.UserRealityInfo;
  PlayObject.m_UserKeySetup := HumData.UserKeySetup;
  PlayObject.m_dwUpLoadPhotoTime := HumData.dwUpLoadPhotoTime;

  PlayObject.m_QuestFlag := HumData.QuestFlag;
  PlayObject.m_MissionFlag := HumData.MissionFlag;

  PlayObject.m_MissionIndex := HumData.MissionIndex;
  DecodeDate(DTime, nYear, nMonth, nDay);
  DecodeDate(HumanRcd.Header.dwUpdateDate, mYear, mMonth, mDay);
  if (nYear <> mYear) or (nMonth <> mMonth) or (nDay <> mDay) then begin
    PlayObject.m_boAddStabilityPoint := False;
    SafeFillChar(PlayObject.m_MissionArithmometer, SizeOf(PlayObject.m_MissionArithmometer), 0);
  end else begin
    PlayObject.m_MissionArithmometer := HumData.MissionArithmometer;
    PlayObject.m_boAddStabilityPoint := HumData.boAddStabilityPoint;
  end;
  PlayObject.m_UseItems := HumData.HumItems;
  {for I := Low(PlayObject.m_UseItems) to High(PlayObject.m_UseItems) do begin
    Move(HumData.HumItems[I], PlayObject.m_UseItems[I], SizeOf(TDefUserItem));
    PlayObject.m_UseItems[I].ItemEx := HuMData.HumItemsEx[I];
  end;  }

  {for I := Low(PlayObject.m_UseItems) to High(PlayObject.m_UseItems) do begin
    PlayObject.m_UseItems[I].MakeIndex := HumData.HumItems[I].MakeIndex;
    PlayObject.m_UseItems[I].wIndex := HumData.HumItems[I].wIndex;
    PlayObject.m_UseItems[I].Dura := HumData.HumItems[I].Dura;
    PlayObject.m_UseItems[I].DuraMax := HumData.HumItems[I].DuraMax;
    PlayObject.m_UseItems[I].btBindMode1 := HumData.HumItems[I].btBindMode1;
    PlayObject.m_UseItems[I].btBindMode2 := HumData.HumItems[I].btBindMode2;
    PlayObject.m_UseItems[I].TermTime := HumData.HumItems[I].TermTime;
    PlayObject.m_UseItems[I].Value := HumData.HumItems[I].Value;
  end;
        }
  PlayObject.m_AppendBagItems := HumData.AppendBagItems;
  {for I := Low(PlayObject.m_AppendBagItems) to High(PlayObject.m_AppendBagItems) do begin
    Move(HumData.AppendBagItems[I], PlayObject.m_AppendBagItems[I], SizeOf(TDefUserItem));
    PlayObject.m_AppendBagItems[I].ItemEx := HuMData.AppendBagItemsEx[I];
  end;  }
 { for I := Low(PlayObject.m_AppendBagItems) to High(PlayObject.m_AppendBagItems) do begin
    PlayObject.m_AppendBagItems[I].MakeIndex := HumData.HumItems[I].MakeIndex;
    PlayObject.m_AppendBagItems[I].wIndex := HumData.HumItems[I].wIndex;
    PlayObject.m_AppendBagItems[I].Dura := HumData.HumItems[I].Dura;
    PlayObject.m_AppendBagItems[I].DuraMax := HumData.HumItems[I].DuraMax;
    PlayObject.m_AppendBagItems[I].btBindMode1 := HumData.HumItems[I].btBindMode1;
    PlayObject.m_AppendBagItems[I].btBindMode2 := HumData.HumItems[I].btBindMode2;
    PlayObject.m_AppendBagItems[I].TermTime := HumData.HumItems[I].TermTime;
    PlayObject.m_AppendBagItems[I].Value := HumData.HumItems[I].Value;
  end;    }


  for i := Low(THumanReturnItems) to High(THumanReturnItems) do begin
    if HumData.ReturnItems[i].wIndex > 0 then begin
      New(UserItem);
      UserItem^ := HumData.ReturnItems[i];
      {Move(HumData.ReturnItems[I], UserItem^, SizeOf(TDefUserItem));
      UserItem^.ItemEx := HumData.ReturnItemsEx[I]; }
      PlayObject.m_ReturnItemsList.Add(UserItem);
    end;

  end;

  BagItems := @HumData.BagItems;
  for i := Low(TBagItems) to High(TBagItems) do begin
    if HumData.BagItems[i].wIndex > 0 then begin
      New(UserItem);
      UserItem^ := BagItems[i];
      {Move(HumData.BagItems[I], UserItem^, SizeOf(TDefUserItem));
      UserItem^.ItemEx := HumData.BagItemsEx[I];  }
      PlayObject.m_ItemList.Add(UserItem);
    end;
  end;

  HumMagics := @HumanRcd.Data.HumMagics;
  for i := Low(THumMagics) to High(THumMagics) do begin
    if HumMagics[i].wMagIdx <= 0 then
      Continue;
    MagicInfo := UserEngine.FindMagic(HumMagics[i].wMagIdx);
    if MagicInfo <> nil then begin
      New(UserMagic);
      UserMagic.MagicInfo := MagicInfo;
      UserMagic.wMagIdx := HumMagics[i].wMagIdx;
      UserMagic.btLevel := HumMagics[i].btLevel;
      //if UserMagic.btLevel <= 0 then UserMagic.btLevel := 1;
      
      if HumMagics[i].nInterval > 0 then begin
        nMagTick := MilliSecondsBetween(DTime, HumanRcd.Header.dwUpdateDate);
        if nMagTick >= HumMagics[i].nInterval then
          UserMagic.dwInterval := 0
        else
          UserMagic.dwInterval := TempTick + (HumMagics[i].nInterval - nMagTick);
      end
      else
        UserMagic.dwInterval := 0;
      //UserMagic.dwInterval := GetTickCount + HumMagics[i].nInterval;
      UserMagic.nTranPoint := HumMagics[i].nTranPoint and $FFFFFF;
      UserMagic.btKey := HumMagics[i].nTranPoint shr 24; 
      PlayObject.m_MagicList.Add(UserMagic);
    end;
  end;

  PlayObject.m_CboMagicListInfo := HumanRcd.Data.CboMagicListInfo;

  PlayObject.m_boStorageOpen[0] := PlayObject.m_sStoragePwd = '';
  StorageItems := @HumanRcd.Data.StorageItems;
  for i := Low(TStorageItems) to High(TStorageItems) do begin
    if HumanRcd.Data.StorageItems[i].UserItem.wIndex > 0 then begin
      New(StorageItem);
      StorageItem^ := StorageItems[i];
      {StorageItem^.idx := HumanRcd.Data.StorageItems[i].idx;
      Move(HumanRcd.Data.StorageItems[i].UserItem, StorageItem^.UserItem, SizeOf(TDefUserItem));
      StorageItem^.UserItem.ItemEx := HumanRcd.Data.StorageItemsEx[I];    }
      PlayObject.m_StorageItemList[0].Add(StorageItem);
    end;
  end;
  PlayObject.m_boStorageOpen[1] := HumData.StorageOpen2;
  PlayObject.m_dwStorageTime[1] := HumData.StorageTime2;
  StorageItems := @HumanRcd.Data.StorageItems2;
  for i := Low(TStorageItems) to High(TStorageItems) do begin
    if HumanRcd.Data.StorageItems2[i].UserItem.wIndex > 0 then begin
      New(StorageItem);
      StorageItem^ := StorageItems[i];
      {StorageItem^.idx := HumanRcd.Data.StorageItems2[i].idx;
      Move(HumanRcd.Data.StorageItems2[i].UserItem, StorageItem^.UserItem, SizeOf(TDefUserItem));
      StorageItem^.UserItem.ItemEx := HumanRcd.Data.StorageItems2Ex[I]; }
      PlayObject.m_StorageItemList[1].Add(StorageItem);
    end;
  end;
  PlayObject.m_boStorageOpen[2] := HumData.StorageOpen3;
  PlayObject.m_dwStorageTime[2] := HumData.StorageTime3;
  StorageItems := @HumanRcd.Data.StorageItems3;
  for i := Low(TStorageItems) to High(TStorageItems) do begin
    if HumanRcd.Data.StorageItems3[i].UserItem.wIndex > 0 then begin
      New(StorageItem);
      StorageItem^ := StorageItems[i];
      {StorageItem^.idx := HumanRcd.Data.StorageItems3[i].idx;
      Move(HumanRcd.Data.StorageItems3[i].UserItem, StorageItem^.UserItem, SizeOf(TDefUserItem));
      StorageItem^.UserItem.ItemEx := HumanRcd.Data.StorageItems3Ex[I];   }
      PlayObject.m_StorageItemList[2].Add(StorageItem);
    end;
  end;
  {PlayObject.m_boStorageOpen[3] := HumData.StorageOpen4;
  PlayObject.m_dwStorageTime[3] := HumData.StorageTime4;
  StorageItems := @HumanRcd.Data.StorageItems4;
  for i := Low(TStorageItems) to High(TStorageItems) do begin
    if StorageItems[i].UserItem.wIndex > 0 then begin
      New(StorageItem);
      StorageItem^ := StorageItems[i];
      PlayObject.m_StorageItemList[3].Add(StorageItem);
    end;
  end;
  PlayObject.m_boStorageOpen[4] := HumData.StorageOpen5;
  PlayObject.m_dwStorageTime[4] := HumData.StorageTime5;
  StorageItems := @HumanRcd.Data.StorageItems5;
  for i := Low(TStorageItems) to High(TStorageItems) do begin
    if StorageItems[i].UserItem.wIndex > 0 then begin
      New(StorageItem);
      StorageItem^ := StorageItems[i];
      PlayObject.m_StorageItemList[4].Add(StorageItem);
    end;
  end;    }

  PlayObject.m_UserOptionSetup := HumanRcd.Data.UserOptionSetup;
  PlayObject.m_wItemsSetupCount := HumanRcd.Data.nItemsSetupCount;
  PlayObject.m_UserItemsSetup := HumanRcd.Data.UserItemsSetup;

  for i := Low(THumanFriends) to High(THumanFriends) do begin
    if HumanRcd.Data.FriendList[i].sChrName = '' then
      break
    else begin
      PlayObject.m_FriendList.AddObject(HumanRcd.Data.FriendList[i].sChrName,
        TObject(HumanRcd.Data.FriendList[i].nChrIdx));
    end;
  end;

  PlayObject.m_wMasterCount := HumData.btMasterCount;
  PlayObject.m_btWuXin := HumData.btWuXin;
  PlayObject.m_MakeMagic := HumData.MakeMagic;
  PlayObject.m_nMakeMagicPoint := HumData.MakeMagicPoint;
  //PlayObject.m_btWuXinLevel := HumData.btWuXinLevel;
  //PlayObject.m_nWuXinExp := HumData.nWuXinExp;
  PlayObject.m_boChangeName := HumData.boChangeName;

  if g_Config.boExpOffLineRunTime then begin
    if HumData.nExpRate > 100 then begin
      nMagTick := SecondsBetween(DTime, HumanRcd.Header.dwUpdateDate);
      if nMagTick < HumData.nExpTime then begin
        PlayObject.m_nKillMonExpRate := HumData.nExpRate;
        PlayObject.m_dwKillMonExpRateTime := HumData.nExpTime - nMagTick;
      end else
        PlayObject.m_dwKillMonExpRateTime := 0;
    end;
  end else begin
    PlayObject.m_nKillMonExpRate := HumData.nExpRate;
    PlayObject.m_dwKillMonExpRateTime := HumData.nExpTime;
  end;
  if PlayObject.m_nKillMonExpRate < 100 then PlayObject.m_nKillMonExpRate := 100;
  

  if (PlayObject.m_btWuXin < 1) or (PlayObject.m_btWuXin > 5) then
    PlayObject.m_btWuXin := 1;
  if PlayObject.m_PPhotoData <> nil then
    FreeMem(PlayObject.m_PPhotoData);
  PlayObject.m_PPhotoData := nil;
  PlayObject.m_nPhotoSize := 0;
  if HumData.nPhotoSize > 0 then begin
    PlayObject.m_nPhotoSize := _MIN(HumData.nPhotoSize, MAXPHOTODATASIZE);
    GetMem(PlayObject.m_PPhotoData, PlayObject.m_nPhotoSize);
    Move(HumData.pPhotoData[0], PlayObject.m_PPhotoData^, PlayObject.m_nPhotoSize);
  end;

  //if PlayObject.m_sStoragePwd <> '' then
    //PlayObject.m_boPasswordLocked := True;
end;

function TUserEngine.GetHomeInfo(var nX, nY: Integer): string;
var
  i: Integer;
  //  nXY: Integer;
begin
  g_StartPointList.Lock;
  try
    if g_StartPointList.Count > 0 then begin
      if g_StartPointList.Count > g_Config.nStartPointSize {1} then
        i := Random(g_Config.nStartPointSize {2})
      else
        i := 0;
      Result := GetStartPointInfo(i, nX, nY); //g_StartPointList.Strings[i];
    end
    else begin
      Result := g_Config.sHomeMap;
      nX := g_Config.nHomeX;
      nX := g_Config.nHomeY;
    end;
  finally
    g_StartPointList.UnLock;
  end;
end;

function TUserEngine.GetRandHomeX(PlayObject: TPlayObject): Integer;
begin
  Result := Random(3) + (PlayObject.m_nHomeX - 2);
end;

function TUserEngine.GetRandHomeY(PlayObject: TPlayObject): Integer;
begin
  Result := Random(3) + (PlayObject.m_nHomeY - 2);
end;
{
procedure TUserEngine.LoadSwitchData(SwitchData: pTSwitchDataInfo; var
  PlayObject: TPlayObject);
var
  nCount: Integer;
  SlaveInfo: pTSlaveInfo;
begin
  if SwitchData.boC70 then begin

  end;
  PlayObject.m_boBanShout := SwitchData.boBanShout;
  PlayObject.m_boHearWhisper := SwitchData.boHearWhisper;
  PlayObject.m_boBanGuildChat := SwitchData.boBanGuildChat;
  PlayObject.m_boBanGuildChat := SwitchData.boBanGuildChat;
  PlayObject.m_boAdminMode := SwitchData.boAdminMode;
  PlayObject.m_boObMode := SwitchData.boObMode;
  nCount := 0;
  while (True) do begin
    if SwitchData.BlockWhisperArr[nCount] = '' then
      break;
    PlayObject.m_BlockWhisperList.Add(SwitchData.BlockWhisperArr[nCount]);
    Inc(nCount);
    if nCount >= High(SwitchData.BlockWhisperArr) then
      break;
  end;
  nCount := 0;
  while (True) do begin
    if SwitchData.SlaveArr[nCount].sSalveName = '' then
      break;
    New(SlaveInfo);
    SlaveInfo^ := SwitchData.SlaveArr[nCount];
    PlayObject.SendDelayMsg(PlayObject, RM_10401, 0, Integer(SlaveInfo), 0, 0,
      '', 500);
    Inc(nCount);
    if nCount >= 5 then
      break;
  end;

  nCount := 0;
  PlayObject.m_boDC := True;
  PlayObject.m_boMC := True;
  PlayObject.m_boSC := True;
  PlayObject.m_boHitSpeed := True;
  PlayObject.m_boMaxHP := True;
  PlayObject.m_boMaxMP := True;
  while (True) do begin
    PlayObject.m_wStatusArrValue[nCount] := SwitchData.StatusValue[nCount];
    PlayObject.m_dwStatusArrTimeOutTick[nCount] :=
      SwitchData.StatusTimeOut[nCount];
    Inc(nCount);
    if nCount >= 6 then
      break;
  end;
end;      }
{
procedure TUserEngine.DelSwitchData(SwitchData: pTSwitchDataInfo);
var
  i: Integer;
  SwitchDataInfo: pTSwitchDataInfo;
begin
  i := 0;
  while True do begin //for i := 0 to m_ChangeServerList.Count - 1 do begin
    if i >= m_ChangeServerList.Count then
      break;
    if m_ChangeServerList.Count <= 0 then
      break;
    SwitchDataInfo := m_ChangeServerList.Items[i];
    if (SwitchDataInfo <> nil) and (SwitchDataInfo = SwitchData) then begin
      DisPose(SwitchDataInfo);
      m_ChangeServerList.Delete(i);
      break;
    end;
    Inc(i);
  end; // for
end;            }

function TUserEngine.MonInitialize(BaseObject: TBaseObject; sMonName: string): TList;
var
  i: Integer;
  Monster: pTMonInfo;
begin
  Result := nil;
  for i := 0 to MonsterList.Count - 1 do begin
    Monster := MonsterList.Items[i];
    if Monster <> nil then begin
      if (CompareText(Monster.sName, sMonName) = 0) and (BaseObject <> nil) then begin
        BaseObject.m_btRaceServer := Monster.btRace;
        BaseObject.m_btRaceImg := Monster.btRaceImg;
        BaseObject.m_wAppr := Monster.wAppr;
        BaseObject.m_Abil.Level := Monster.wLevel;
        BaseObject.m_btLifeAttrib := Monster.btLifeAttrib;
        BaseObject.m_boNotInSafe := Monster.boNotInSafe;
        BaseObject.m_btCoolEye := Monster.wCoolEye;
        BaseObject.m_dwFightExp := Monster.dwExp;
        BaseObject.m_Abil.HP := Monster.wHP;
        BaseObject.m_Abil.MaxHP := Monster.wHP;
        //BaseObject.m_btMonsterWeapon := LoByte(Monster.wMP);
        //BaseObject.m_Abil.MP:=Monster.wMP;
        BaseObject.m_Abil.MP := 0;
        BaseObject.m_Abil.MaxMP := Monster.wMP;
        BaseObject.m_Abil.AC := MakeLong(Monster.wAC, Monster.wAC);
        BaseObject.m_Abil.MAC := MakeLong(Monster.wMAC, Monster.wMAC);
        BaseObject.m_Abil.DC := MakeLong(Monster.wDC, Monster.wMaxDC);
        BaseObject.m_Abil.MC := MakeLong(Monster.wMC, Monster.wMC);
        BaseObject.m_Abil.SC := MakeLong(Monster.wSC, Monster.wSC);
        BaseObject.m_btSpeedPoint := Monster.wSpeed;
        BaseObject.m_btHitPoint := Monster.wHitPoint;
        BaseObject.m_nWalkSpeed := Monster.nWalkSpeed;
        BaseObject.m_nWalkStep := Monster.wWalkStep;
        BaseObject.m_dwWalkWait := Monster.wWalkWait;
        BaseObject.m_nNextHitTime := Monster.wAttackSpeed;
        BaseObject.m_MapQuestList := Monster.MapQuestList;
        if Monster.btColor > 0 then
          BaseObject.m_btNameColor := Monster.btColor;
        Result := Monster.ItemList;
        break;
      end;
    end;
  end;
end;

function TUserEngine.OpenDoor(Envir: TEnvirnoment; nX, nY: Integer): Boolean;
var
  Door: pTDoorInfo;
begin
  Result := False;
  Door := Envir.GetDoor(nX, nY);
  if (Door <> nil) and not Door.Status.boOpened and not Door.Status.bo01 then begin
    Door.Status.boOpened := True;
    Door.Status.dwOpenTick := GetTickCount();
    SendDoorStatus(Envir, nX, nY, RM_DOOROPEN, 0, nX, nY, 0, '');
    Result := True;
  end;
end;

function TUserEngine.CloseDoor(Envir: TEnvirnoment; Door: pTDoorInfo): Boolean;
begin
  Result := False;
  if (Door <> nil) and (Door.Status.boOpened) then begin
    Door.Status.boOpened := False;
    SendDoorStatus(Envir, Door.nX, Door.nY, RM_DOORCLOSE, 0, Door.nX, Door.nY,
      0,
      '');
    Result := True;
  end;
end;

procedure TUserEngine.SendDoorStatus(Envir: TEnvirnoment; nX, nY: Integer;
  wIdent, wX: Word; nDoorX, nDoorY, nA: Integer; sStr: string);
var
  i: Integer;
  n10, n14: Integer;
  n1C, n20, n24, n28: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  n1C := nX - 12;
  n24 := nX + 12;
  n20 := nY - 12;
  n28 := nY + 12;
  if Envir <> nil then begin
    for n10 := n1C to n24 do begin
      for n14 := n20 to n28 do begin
        if Envir.GetMapCellInfo(n10, n14, MapCellInfo) and (MapCellInfo.ObjList
          <> nil) then begin
          for i := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := pTOSObject(MapCellInfo.ObjList.Items[i]);
            if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if (BaseObject <> nil) and
                (not BaseObject.m_boGhost) and
                (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                BaseObject.SendMsg(BaseObject, wIdent, wX, nDoorX, nDoorY, nA,
                  sStr);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessMapDoor;
var
  i: Integer;
  ii: Integer;
  Envir: TEnvirnoment;
  Door: pTDoorInfo;
begin
  for i := 0 to g_MapManager.Count - 1 do begin
    Envir := TEnvirnoment(g_MapManager.Items[i]);
    if Envir <> nil then begin
      for ii := 0 to Envir.m_DoorList.Count - 1 do begin
        Door := Envir.m_DoorList.Items[ii];
        if Door <> nil then begin
          if Door.Status.boOpened then begin
            if (GetTickCount - Door.Status.dwOpenTick) > 5 * 1000 then
              CloseDoor(Envir, Door);
          end;
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessMapObjectCount;
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  FillChar(g_MapObjectCount[0], Length(g_MapObjectCount) * SizeOf(g_MapObjectCount), 0);
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if PlayObject <> nil then begin
      if (not PlayObject.m_boGhost) and (PlayObject.m_PEnvir <> nil) then
        Inc(g_MapObjectCount[PlayObject.m_PEnvir.m_nMapIndex]);
    end;
  end;

end;

procedure TUserEngine.ProcessEvents;
var
  i, ii, III: Integer;
  MagicEvent: pTMagicEvent;
  BaseObject: TBaseObject;
begin
  for i := m_MagicEventList.Count - 1 downto 0 do begin
    if m_MagicEventList.Count <= 0 then
      break;
    MagicEvent := m_MagicEventList.Items[i];
    if (MagicEvent <> nil) and (MagicEvent.BaseObjectList <> nil) then begin
      for ii := MagicEvent.BaseObjectList.Count - 1 downto 0 do begin
        BaseObject := TBaseObject(MagicEvent.BaseObjectList.Items[ii]);
        if BaseObject <> nil then begin
          if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (not
            BaseObject.m_boHolySeize) then begin
            MagicEvent.BaseObjectList.Delete(ii);
          end;
        end;
      end;
      if (MagicEvent.BaseObjectList.Count <= 0) or
        ((GetTickCount - MagicEvent.dwStartTick) > MagicEvent.dwTime) or
        ((GetTickCount - MagicEvent.dwStartTick) > 180000) then begin
        MagicEvent.BaseObjectList.Free;
        III := 0;
        while (True) do begin
          if MagicEvent.Events[III] <> nil then begin
            TEvent(MagicEvent.Events[III]).Close();
          end;
          Inc(III);
          if III >= 8 then
            break;
        end;
        DisPose(MagicEvent);
        m_MagicEventList.Delete(i);
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessFBMap;
var
//  dwUsrTimeTick: LongWord;
  //  i: Integer;
//  sMsg: string;
//  Hour, Min, Sec, MSec: Word;
  PlayObject: TPlayObject;
  Envir: TEnvirnoment;
  FBList: TList;
  I, k, d, b, n: Integer;
  BaseObject: TBaseObject;
  AddList: TList;
  Event: TEvent;
  boWarr, boWizard, boTaos: Boolean;
  GroupObject: TBaseObject;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessFBMap';
begin
  Try
    ProcessMapObjectCount();
    for I := 0 to g_FBMapManager.Count - 1 do begin
      FBList := TList(g_FBMapManager.Objects[I]);
      if (FBList <> nil) and (FBList.Count > 0) then begin
        for k := 0 to FBList.Count - 1 do begin
          Envir := FBList[k];
          if Envir.m_boFBFail and (GetTickCount > Envir.m_dwFBFailTime) then begin
            Envir.m_MasterObject := nil;
            Envir.m_dwCheckMonsterTick := 0;
          end;
          if GetTickCount > Envir.m_dwCheckMonsterTick then begin
            Envir.m_dwCheckMonsterTick := GetTickCount + 60 * 1000 + LongWord(Random(60 * 1000));
            if Envir.m_boFBCreate and ((g_MapObjectCount[Envir.m_nMapIndex] <= 0) or (Envir.m_MasterObject = nil) or
              (GetTickCount > Envir.m_dwFBTime)) then begin
              Envir.m_MasterObject := nil;
              Envir.m_boFBCreate := False;
            end;
            if Envir.m_MonsterList.Count > 0 then begin
              for d := Envir.m_MonsterList.Count - 1 downto 0 do begin
                BaseObject := TBaseObject(Envir.m_MonsterList[d]);
                if not Envir.m_boFBCreate then begin
                  if (not BaseObject.m_boGhost) and (BaseObject.m_Master = nil) then
                    BaseObject.MakeGhost;
                end else begin
                  if (BaseObject.m_boGhost) or (BaseObject.m_boDeath) then
                    Envir.m_MonsterList.Delete(d);
                end;
              end;
              if not Envir.m_boFBCreate then Envir.m_MonsterList.Clear;
            end;
            if (Envir.m_Event.Count > 0) and (not Envir.m_boFBCreate) then begin
              for d := Envir.m_Event.Count - 1 downto 0 do begin
                AddList := TList(Envir.m_Event.Objects[d]);
                for b := AddList.Count - 1 downto 0 do begin
                  Event := TEvent(AddList[b]);
                  Event.m_boClosed := True;
                  Event.m_boManualClose := True;
                  Event.Close;
                end;
                AddList.Free;
              end;
              Envir.m_Event.Clear;
            end;
          end;
          PlayObject := TPlayObject(Envir.m_MasterObject);
          if (PlayObject <> nil) then begin
            if PlayObject.m_boDisappear or (PlayObject.m_FBEnvir <> Envir) then begin
              Envir.m_MasterObject := nil;
            end else begin
              if Envir.m_boFBIsJob then begin
                boWarr := False;
                boWizard := False;
                boTaos := False;
                if PlayObject.m_GroupOwner <> nil then begin
                  for n := 0 to PlayObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
                    GroupObject := TBaseObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[n]);
                    if (GroupObject <> nil) and (not GroupObject.m_boGhost) and (GroupObject.m_PEnvir = Envir) then begin
                      if GroupObject.m_btJob = 0 then boWarr := True
                      else if GroupObject.m_btJob = 1 then boWizard := True
                      else if GroupObject.m_btJob = 2 then boTaos := True;
                    end;
                  end;
                end;
                if boWarr and boWizard and boTaos then begin
                  Envir.m_boFBFail := False;
                end else begin
                  if not Envir.m_boFBFail then begin
                    Envir.m_boFBFail := True;
                    Envir.m_dwFBFailTime := GetTickCount + 60 * 1000;
                  end;
                end;
              end else begin
                Envir.m_boFBFail := False;
              end;
            end;
          end;
        end;
      end;
    end;
  Except
    MainOutMessage(sExceptionMsg);
  End;
end;

procedure TUserEngine.Process4AECFC;
begin

end;

function TUserEngine.FindMagic(nMagIdx: Integer): pTMagic;
begin
  Result := nil;
  if (nMagIdx > 0) and (nMagIdx < SKILL_MAX) and (m_MagicArr[nMagidx].sMagicName <> '') then
    Result := @m_MagicArr[nMagidx];
end;

function TUserEngine.FindMagic(sMagicName: string): pTMagic;
var
  i: integer;
begin
  Result := nil;
  for I := Low(m_MagicArr) to High(m_MagicArr) do begin
    if m_MagicArr[i].sMagicName <> '' then
      if CompareText(m_MagicArr[i].sMagicName, sMagicName) = 0 then begin
        Result := @m_MagicArr[i];
        break;
      end;
  end;

end;

function TUserEngine.GetMapRangeMonster(Envir: TEnvirnoment; nX, nY, nRange: Integer; List: TList): Integer;
var
  i, ii: Integer;
  MonGen: pTMonGenInfo;
  BaseObject: TBaseObject;
begin
  Result := 0;
  if Envir = nil then
    Exit;
  for i := 0 to m_MonGenList.Count - 1 do begin
    MonGen := m_MonGenList.Items[i];
    if (MonGen = nil) then
      Continue;
    if (MonGen.Envir <> nil) and (MonGen.Envir <> Envir) then
      Continue;

    for ii := 0 to MonGen.CertList.Count - 1 do begin
      BaseObject := TBaseObject(MonGen.CertList.Items[ii]);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath and not BaseObject.m_boGhost and
          (BaseObject.m_PEnvir = Envir) and (abs(BaseObject.m_nCurrX - nX) <=
          nRange) and (abs(BaseObject.m_nCurrY - nY) <= nRange) then begin
          if List <> nil then
            List.Add(BaseObject);
          Inc(Result);
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.AddMerchant(Merchant: TMerchant);
begin
  UserEngine.m_MerchantList.Lock;
  try
    UserEngine.m_MerchantList.Add(Merchant);
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
end;
{$IF Public_Ver = Public_Test}
procedure TUserEngine.AddObject(sChrName: string; PlayObject: TPlayObject);
begin
  if FObject1 = nil then begin
    FObject1 := PlayObject;
    m_TestObjectList.AddObject(sChrName, TObject(PlayObject));
  end else
  if FObject2 = nil then begin
    FObject2 := PlayObject;
    m_TestObjectList.AddObject(sChrName, TObject(PlayObject));
  end else
  if FObject3 = nil then begin
    FObject3 := PlayObject;
    m_TestObjectList.AddObject(sChrName, TObject(PlayObject));
  end else
  if FObject4 = nil then begin
    FObject4 := PlayObject;
    m_TestObjectList.AddObject(sChrName, TObject(PlayObject));
  end else
  if FObject5 = nil then begin
    FObject5 := PlayObject;
    m_TestObjectList.AddObject(sChrName, TObject(PlayObject));
  end else
  if FObject6 = nil then begin
    FObject6 := PlayObject;
    m_TestObjectList.AddObject(sChrName, TObject(PlayObject));
  end else
  if FObject7 = nil then begin
    FObject7 := PlayObject;
    m_TestObjectList.AddObject(sChrName, TObject(PlayObject));
  end else
  if FObject8 = nil then begin
    FObject8 := PlayObject;
    m_TestObjectList.AddObject(sChrName, TObject(PlayObject));
  end else
  if FObject9 = nil then begin
    FObject9 := PlayObject;
    m_TestObjectList.AddObject(sChrName, TObject(PlayObject));
  end else
  if FObject10 = nil then begin
    FObject10 := PlayObject;
    m_TestObjectList.AddObject(sChrName, TObject(PlayObject));
  end;
end;

procedure TUserEngine.DelObject(PlayObject: TPlayObject);
  procedure DelListObject();
  var
    I: Integer;
  begin
    for I := 0 to m_TestObjectList.Count - 1 do begin
      if m_TestObjectList.Objects[I] = PlayObject then begin
        m_TestObjectList.Delete(I);
        Break;
      end;
    end;
  end;
begin
  if FObject1 = PlayObject then begin
    FObject1 := nil;
    DelListObject();
  end else
  if FObject2 = PlayObject then begin
    FObject2 := nil;
    DelListObject();
  end else
  if FObject3 = PlayObject then begin
    FObject3 := nil;
    DelListObject();
  end else
  if FObject4 = PlayObject then begin
    FObject4 := nil;
    DelListObject();
  end else
  if FObject5 = PlayObject then begin
    FObject5 := nil;
    DelListObject();
  end else
  if FObject6 = PlayObject then begin
    FObject6 := nil;
    DelListObject();
  end else
  if FObject7 = PlayObject then begin
    FObject7 := nil;
    DelListObject();
  end else
  if FObject8 = PlayObject then begin
    FObject8 := nil;
    DelListObject();
  end else
  if FObject9 = PlayObject then begin
    FObject9 := nil;
    DelListObject();
  end else
  if FObject10 = PlayObject then begin
    FObject10 := nil;
    DelListObject();
  end;
end;
{$IFEND}

procedure TUserEngine.AddOffLine(PlayObject: TPlayObject);
begin
  m_OffLineList.Lock;
  try
    m_OffLineList.AddObject(PlayObject.m_sCharName, PlayObject);
  finally
    m_OffLineList.UnLock;
  end;
end;

function TUserEngine.GetMerchantList(Envir: TEnvirnoment; nX, nY,
  nRange: Integer; TmpList: TList): Integer;
var
  i: Integer;
  Merchant: TMerchant;
begin
  m_MerchantList.Lock;
  try
    for i := 0 to m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(m_MerchantList.Items[i]);
      if Merchant <> nil then begin
        if (Merchant.m_PEnvir = Envir) and
          (abs(Merchant.m_nCurrX - nX) <= nRange) and
          (abs(Merchant.m_nCurrY - nY) <= nRange) then begin
          TmpList.Add(Merchant);
        end;
      end;
    end; // for
  finally
    m_MerchantList.UnLock;
  end;
  Result := TmpList.Count
end;

function TUserEngine.GetNpcList(Envir: TEnvirnoment; nX, nY,
  nRange: Integer; TmpList: TList): Integer;
var
  i: Integer;
  NPC: TNormNpc;
begin
  for i := 0 to QuestNPCList.Count - 1 do begin
    NPC := TNormNpc(QuestNPCList.Items[i]);
    if NPC <> nil then begin
      if (NPC.m_PEnvir = Envir) and
        (abs(NPC.m_nCurrX - nX) <= nRange) and
        (abs(NPC.m_nCurrY - nY) <= nRange) then begin
        TmpList.Add(NPC);
      end;
    end;
  end; // for
  Result := TmpList.Count
end;

procedure TUserEngine.ReloadMerchantList();
var
  i: Integer;
  Merchant: TMerchant;
begin
  m_MerchantList.Lock;
  try
    for i := 0 to m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(m_MerchantList.Items[i]);
      if Merchant <> nil then begin
        if not Merchant.m_boGhost then begin
          Merchant.ClearScript;
          Merchant.LoadNpcScript;
        end;
      end;
    end; // for
  finally
    m_MerchantList.UnLock;
  end;
end;

procedure TUserEngine.ReloadNpcList();
var
  i: Integer;
  NPC: TNormNpc;
begin
  for i := 0 to QuestNPCList.Count - 1 do begin
    NPC := TNormNpc(QuestNPCList.Items[i]);
    if NPC <> nil then begin
      NPC.ClearScript;
      NPC.LoadNpcScript;
    end;
  end;
end;

function TUserEngine.GetMapMonster(Envir: TEnvirnoment; List: TList): Integer;
var
  i, ii: Integer;
  MonGen: pTMonGenInfo;
  BaseObject: TBaseObject;
begin
  Result := 0;
  if Envir = nil then Exit;
  for i := 0 to m_MonGenList.Count - 1 do begin
    MonGen := m_MonGenList.Items[i];
    if MonGen = nil then Continue;
    for ii := 0 to MonGen.CertList.Count - 1 do begin
      BaseObject := TBaseObject(MonGen.CertList.Items[ii]);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath and not BaseObject.m_boGhost and (BaseObject.m_PEnvir = Envir) then begin
          if List <> nil then
            List.Add(BaseObject);
          Inc(Result);
        end;
      end;
    end;
  end;
end;

function TUserEngine.GetMapMonster(sMonName: string; Envir: TEnvirnoment; List: TList): Integer;
var
  i, ii: Integer;
  MonGen: pTMonGenInfo;
  BaseObject: TBaseObject;
begin
  Result := 0;
  if Envir = nil then Exit;
  for i := m_MonGenList.Count - 1 downto 0 do begin
    MonGen := m_MonGenList.Items[i];
    if MonGen = nil then Continue;
    for ii := 0 to MonGen.CertList.Count - 1 do begin
      BaseObject := TBaseObject(MonGen.CertList.Items[ii]);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath and not BaseObject.m_boGhost and (BaseObject.m_PEnvir = Envir) and (CompareText(sMonName, BaseObject.m_sCharName) = 0) then begin
          if List <> nil then List.Add(BaseObject);
          Inc(Result);
        end;
      end;
    end;
  end;
end;
{
procedure TUserEngine.HumanExpire(sAccount: string);
var
 i: Integer;
 PlayObject: TPlayObject;
begin
 if not g_Config.boKickExpireHuman then
   Exit;
 for i := 0 to m_PlayObjectList.Count - 1 do begin
   PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
   if PlayObject <> nil then begin
     if CompareText(PlayObject.m_sUserID, sAccount) = 0 then begin
       PlayObject.m_boExpire := True;
       break;
     end;
   end;
 end;
end;      }

function TUserEngine.GetMapHuman(sMapName: string): Integer;
var
  i: Integer;
  Envir: TEnvirnoment;
  PlayObject: TPlayObject;
begin
  Result := 0;
  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then
    Exit;
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if PlayObject <> nil then begin
      if not PlayObject.m_boDeath and not PlayObject.m_boGhost and
        (PlayObject.m_PEnvir = Envir) then
        Inc(Result);
    end;
  end;
end;

function TUserEngine.GetMapRageHuman(Envir: TEnvirnoment; nRageX,
  nRageY, nRage: Integer; List: TList): Integer;
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  Result := 0;
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if PlayObject <> nil then begin
      if not PlayObject.m_boDeath and
        not PlayObject.m_boGhost and
        (PlayObject.m_PEnvir = Envir) and
        (abs(PlayObject.m_nCurrX - nRageX) <= nRage) and
        (abs(PlayObject.m_nCurrY - nRageY) <= nRage) then begin
        List.Add(PlayObject);
        Inc(Result);
      end;
    end;
  end;
end;

function TUserEngine.GetStdItemIdx(sItemName: string): Integer;
var
  i: Integer;
  StdItem: pTStdItem;
begin
  Result := -1;
  if sItemName = '' then
    Exit;
  for i := 0 to StdItemList.Count - 1 do begin
    StdItem := StdItemList.Items[i];
    if StdItem <> nil then begin
      if CompareText(StdItem.Name, sItemName) = 0 then begin
        Result := i + 1;
        break;
      end;
    end;
  end;
end;
function TUserEngine.GetStdItemLimit(nItemIdx: Integer): pTStdItemLimit;
begin
  Result := nil;
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemLimitList.Count > nItemIdx) then begin
    Result := StdItemLimitList.Items[nItemIdx];
  end;
end;

//==========================================
//向每个人物发送消息
//线程安全
//==========================================

procedure TUserEngine.SendBroadCastMsgExt(sMsg: string; MsgType: TMsgType);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    for i := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
      if PlayObject <> nil then begin
        if (not PlayObject.m_boGhost) and (not PlayObject.m_boSafeOffLine) then
          PlayObject.SysMsg(sMsg, c_Red, MsgType);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TUserEngine.SendBroadCastMsgDelay(sMsg: string; MsgType: TMsgType; dwDelay: LongWord; BaseObject: TBaseObject = nil);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    for i := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
      if (PlayObject <> nil) and (PlayObject <> BaseObject) then begin
        if (not PlayObject.m_boGhost) and (not PlayObject.m_boSafeOffLine) then
          PlayObject.SysDelayMsg(sMsg, c_Red, MsgType, dwDelay);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TUserEngine.SendBroadFilterInfo();
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for i := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
      if PlayObject <> nil then begin
        if (not PlayObject.m_boGhost) and (not PlayObject.m_boSafeOffLine) then
          PlayObject.SendDefSocket(PlayObject, SM_FILTERINFO, g_FilterDataLen, 0, 0, 0, g_FilterData);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TUserEngine.SendBroadBugleMsg(sMsg: string);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if PlayObject <> nil then begin
      if (not PlayObject.m_boGhost) and (not PlayObject.m_boSafeOffLine) then begin
        PlayObject.SendMsg(PlayObject, RM_BUGLE, 0, g_Config.nBugleMsgFColor, g_Config.nBugleMsgBColor, 0, sMsg);
      end;
    end;
  end;
end;

procedure TUserEngine.SendBroadTopMsg(sMsg: string);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if PlayObject <> nil then begin
      if (not PlayObject.m_boGhost) and (not PlayObject.m_boSafeOffLine) then
        PlayObject.SendDefMsg(PlayObject, SM_TOPMSG, 0, 0, 0, 0, sMsg);
        //PlayObject.SysMsg(sMsg, c_Red, MsgType);
    end;
  end;
end;

procedure TUserEngine.SendBroadCastMsg(sMsg: string; MsgType: TMsgType);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if PlayObject <> nil then begin
      if (not PlayObject.m_boGhost) and (not PlayObject.m_boSafeOffLine) then
        PlayObject.SysMsg(sMsg, c_Red, MsgType);
    end;
  end;
end;

procedure TUserEngine.SendMapBroadCastMsg(Envir: TEnvirnoment; sMsg: string; MsgType: TMsgType);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  for i := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if PlayObject <> nil then begin
      if (not PlayObject.m_boGhost) and (not PlayObject.m_boSafeOffLine) and (PlayObject.m_PEnvir = Envir) then
        PlayObject.SysMsg(sMsg, c_Red, MsgType);
    end;
  end;
end;

procedure TUserEngine.Execute;
begin
  Run;
end;

{procedure TUserEngine.sub_4AE514(GoldChangeInfo: pTGoldChangeInfo);
var
  GoldChange: pTGoldChangeInfo;
begin
  New(GoldChange);
  GoldChange^ := GoldChangeInfo^;
  EnterCriticalSection(m_LoadPlaySection);
  try
    m_ChangeHumanDBGoldList.Add(GoldChange);
  finally
    LeaveCriticalSection(m_LoadPlaySection);
  end;
end;         }

procedure TUserEngine.ClearMonSayMsg;
var
  i, ii: Integer;
  MonGen: pTMonGenInfo;
  MonBaseObject: TBaseObject;
begin
  for i := 0 to m_MonGenList.Count - 1 do begin
    MonGen := m_MonGenList.Items[i];
    if (MonGen <> nil) and (MonGen.CertList <> nil) then begin
      for ii := 0 to MonGen.CertList.Count - 1 do begin
        MonBaseObject := TBaseObject(MonGen.CertList.Items[ii]);
        if MonBaseObject <> nil then
          MonBaseObject.m_SayMsgList := nil;
      end;
    end;
  end;
end;

function TUserEngine.GetCheckPlayObject: TPlayObject;
var
  i: Integer;
begin
  Result := nil;
  for i := m_PlayObjectList.Count - 1 downto 0 do begin
    if TPlayObject(m_PlayObjectList.Objects[i]).m_boIncCount and
      not TPlayObject(m_PlayObjectList.Objects[i]).m_boSafeOffLine then begin
      Result := TPlayObject(m_PlayObjectList.Objects[i]);
      if Random((m_PlayObjectList.Count - m_OffLineList.Count) div 2 + 1) = 0 then
        break;
    end;
  end;
end;

function TUserEngine.GetDefiniensConstText(sMsg: string): string;
var
  nC, nIdx, n10: Integer;
  s10, s14, s18, sStr: string;
  tempstr: string;
begin
  nC := 0;
  tempstr := sMsg;
  while (True) do begin
    if Pos(']', tempstr) <= 0 then break;
    tempstr := ArrestStringEx(tempstr, '[', ']', s10);
    if s10 = '' then break;
    if s10[1] = '$' then begin
      s10 := Copy(s10, 2, Length(s10) - 1);
      nIdx := m_DefiniensConst.IndexOf(s10);
      sStr := '[$' + s10 + ']';
      n10 := Pos(sStr, sMsg);
      if n10 > 0 then begin
        s14 := Copy(sMsg, 1, n10 - 1);
        s18 := Copy(sMsg, Length(sStr) + n10, Length(sMsg));
        if nIdx > -1 then begin
          sMsg := s14 + PString(m_DefiniensConst.Objects[nIdx])^ + s18;
        end else begin
          MainOutMessage('脚本常量： ' + s10 + ' 未找到');
          sMsg := s14 + '????' + s18;
        end;
      end;
    end;
    //GetVariableText(PlayObject, sMsg, s10);
    Inc(nC);
    if nC >= 101 then break;
  end;
  Result := sMsg;
end;

procedure TUserEngine.PrcocessData;
var
  dwUsrTimeTick: LongWord;
  sMsg: string;
  Hour, Min, Sec, MSec: Word;
  PlayObject: TPlayObject;
resourcestring
  sExceptionMsg = '[Exception] TUserEngine::ProcessData';
begin

  try
    dwUsrTimeTick := GetTickCount();
    
    dwUsrRotCountMin := dwUsrTimeTick - g_dwUsrRotCountTick;
    g_dwUsrRotCountTick := dwUsrTimeTick;
    if dwUsrRotCountMax < dwUsrRotCountMin then
      dwUsrRotCountMax := dwUsrRotCountMin;


    ProcessHumans();
    if g_Config.boSendOnlineCount and (GetTickCount - g_dwSendOnlineTick > g_Config.dwSendOnlineTime) then begin
      g_dwSendOnlineTick := GetTickCount();
      sMsg := AnsiReplaceText(g_sSendOnlineCountMsg, '%c', IntToStr(ROUND(GetUserCount * (g_Config.nSendOnlineCountRate / 10))));
      SendBroadCastMsg(sMsg, t_System);
    end;

    ProcessMonsters();

    ProcessMerchants();

    ProcessNpcs();

    if (GetTickCount() - dwProcessMissionsTime) > 1000 then begin
      dwProcessMissionsTime := GetTickCount();
      ProcessMissions();
      Process4AECFC();
      ProcessEvents();
      DecodeTime(Now, Hour, Min, Sec, MSec);
      g_boDayChange := (Hour = 0);
      ProcessFBMap;
      ProcessRandomMapGate;

      DecodeDate(Now, g_wYear, g_wMonth, g_wDay);
      DecodeTime(Now, g_wHour, g_wMin, g_wSec, g_wMSec);
      if g_boSaveMonDropLimit then begin
        g_boSaveMonDropLimit := False;
        SaveMonDropLimitList();
      end;
    end;

    if (GetTickCount() - dwProcessMapDoorTick) > 500 then begin
      dwProcessMapDoorTick := GetTickCount();
      ProcessMapDoor();
    end;

    g_nUsrTimeMin := GetTickCount() - dwUsrTimeTick;
    if g_nUsrTimeMax < g_nUsrTimeMin then
      g_nUsrTimeMax := g_nUsrTimeMin;

    if GetTickCount > g_Config.dwCheckTime then begin
      g_Config.dwCheckTime := GetTickCount + g_Config.dwCheckTick;
      if (g_Config.nCheckCount >= 3) {and (PlayObjectCount >= g_Config.nCheckCount)} then begin
        PlayObject := GetCheckPlayObject;
        if PlayObject <> nil then begin
          PlayObject.SendDefSocket(PlayObject, SM_SENDINFO, 0, 0, 0, 0,
            EncodeString(g_Config.dwFileID + '/' +
                         g_Config.sIdeSerialNumber + '/' +
                         g_Config.sPCName + '/' +
                         g_Config.sFileMD5 + '/' +
                         g_Config.sFileVersion + '/' +
                         IntToStr(g_Config.nGatePort) + '/' +
                         IntToStr(PlayObjectCount) + '/' +
                         IntToStr(OffLinePlayCount)));
        end;
      end;
    end;


    {if (GetTickCount > dwProcessGetSortTick) and g_boDBSocketRead then begin
      dwProcessGetSortTick := GetTickCount + 30 * 1000;
      if dwProcessGetSortIndex = 0 then begin
        dwProcessGetSortIndex := 1;
        for I := 1 to 9 do
          FrontEngine.AddToDBServerList(nil,
            EncodeMessage(MakeDefaultMsg(DB_GETSORTLIST, I, 0, 0, 0)));
      end
      else begin
        if dwProcessGetSortIndex < 1 then
          dwProcessGetSortIndex := 1;
        if dwProcessGetSortIndex > 9 then
          dwProcessGetSortIndex := 1;
        FrontEngine.AddToDBServerList(nil,
          EncodeMessage(MakeDefaultMsg(DB_GETSORTLIST, dwProcessGetSortIndex, 0,
          0, 0)));
        Inc(dwProcessGetSortIndex);
      end;
    end;   }

    {if GetTickCount() - dwSaveDataTick > 1000 * 5 then begin
      dwSaveDataTick := GetTickCount();
      g_SellOffGoodList.SaveSellOffGoodList();
      g_SellOffGoldList.SaveSellOffGoldList();
      g_BigStorageList.SaveStorageList();
    end;}
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TUserEngine.SendQuestMsg(sQuestName: string);
var
  i, nIdx: Integer;
  PlayObject: TPlayObject;
  SayingRecord: pTSayingRecord;
begin
  if g_ManageNPC = nil then exit;
  nIdx := -1;
  for I := 0 to g_ManageNPC.m_ScriptList.Count - 1 do begin
    SayingRecord := g_ManageNPC.m_ScriptList[i];
    if CompareText(sQuestName, SayingRecord.sLabel) = 0 then begin
      nIdx := I;
      break;
    end;
  end;
  if nIdx <> -1 then begin
    for i := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
      if PlayObject <> nil then begin
        if (not PlayObject.m_boDeath) and (not PlayObject.m_boGhost) then
          PlayObject.NpcGotoLable(g_ManageNPC, nIdx, False);
      end;
    end;
  end;
end;

function TUserEngine.CanAddObject: Boolean;
begin
{$IF Public_Ver = Public_Test}
  Result := (FObject1 = nil) or (FObject2 = nil) or (FObject3 = nil) or (FObject4 = nil) or (FObject5 = nil) or
    (FObject6 = nil) or (FObject7 = nil) or (FObject8 = nil) or (FObject9 = nil) or (FObject10 = nil);
{$ELSE}
  Result := True;
{$IFEND}
end;

procedure TUserEngine.ClearMerchantData();
var
  i: Integer;
  Merchant: TMerchant;
begin
  m_MerchantList.Lock;
  try
    for i := 0 to m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(m_MerchantList.Items[i]);
      if Merchant <> nil then
        Merchant.ClearData();
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;

initialization
begin
{$IF Public_Ver = Public_Release}
  g_ADNoticeList := TStringList.Create;
  g_ADExitUrlList := TStringList.Create;
  g_ADFrameUrlList := TStringList.Create;
  g_ADRSA := TRSA.Create(nil);
  g_ADRSA.CommonalityKey := IntToStr(65537);
  g_ADRSA.CommonalityMode := IntToStr(84637) + IntToStr(66331) + IntToStr(641501) + IntToStr(8074435) + IntToStr(415671);
  g_ADRSA.Server := False;
  g_DESPassword := TStringList.Create;
{$IFEND}
end;

finalization
begin
{$IF Public_Ver = Public_Release}
  g_ADNoticeList.Free;
  g_ADExitUrlList.Free;
  g_ADFrameUrlList.Free;
  g_ADRSA.Free;
  g_DESPassword.Free;
{$IFEND}
end;



end.

