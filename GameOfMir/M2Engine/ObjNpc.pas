unit ObjNpc;

interface
uses
  Windows, Classes, SysUtils, StrUtils, ObjBase, ObjPlay, Grobal2, SDK, IniFiles, DateUtils;

const
  MAXNPCPROCEDURECOUNT = 200;
  MAXGOTOLABELID = 83;
  MAXAPPENDFUNCCOUNT = 255;
  MAXMAGICFUNCOUNT = 150;

  NPC_RC_NORM = 1;
  NPC_RC_MERCHANT = 2;
  NPC_RC_FUNMERCHANT = 3;

type
  TUpgradeInfo = record //0x40
    sUserName: string[14]; //0x00
    UserItem: TUserItem; //0x10
    btDc: Byte; //0x28
    btSc: Byte; //0x29
    btMc: Byte; //0x2A
    btDura: Byte; //0x2B
    n2C: Integer;
    dtTime: TDateTime; //0x30
    dwGetBackTick: LongWord; //0x38
    n3C: Integer;
  end;
  pTUpgradeInfo = ^TUpgradeInfo;
  { TItemPrice = record
     wIndex: Word;
     nPrice: Integer;
   end;
   pTItemPrice = ^TItemPrice;   }
  TGoods = packed record //0x1C
    btIdx: Byte;
    sItemName: string[14];
    UserItem: TUserItem;
    nCount, nStock: Integer;
    dwRefillTime: LongWord;
    dwRefillTick: LongWord;
  end;
  pTGoods = ^TGoods;

  { TSellItemPrice = record
     wIndex: Word;
     nPrice: Integer;
   end;
   pTSellItemPrice = ^TSellItemPrice;  }

  TQuestActionInfo = record //0x1C
    TCmdList: TStringList;
    nCMDCode: Integer; //0x00
    sParam1: string; //0x04
    nParam1: Integer; //0x08
    boDynamic1: Boolean;
    sParam2: string; //0x0C
    nParam2: Integer; //0x10
    boDynamic2: Boolean;
    sParam3: string; //0x14
    nParam3: Integer; //0x18
    boDynamic3: Boolean;
    sParam4: string;
    nParam4: Integer;
    boDynamic4: Boolean;
    sParam5: string;
    nParam5: Integer;
    boDynamic5: Boolean;
    sParam6: string;
    nParam6: Integer;
    boDynamic6: Boolean;
    sParam7: string;
    nParam7: Integer;
    boDynamic7: Boolean;
    sParam8: string;
    nParam8: Integer;
    boDynamic8: Boolean;
    sParam9: string;
    nParam9: Integer;
    boDynamic9: Boolean;
  end;
  pTQuestActionInfo = ^TQuestActionInfo;
  TQuestConditionInfo = record //0x14
    TCmdList: TStringList;
    nCMDCode: Integer; //0x00
    boResult: Boolean;
    sParam1: string; //0x04
    nParam1: Integer; //0x08
    boDynamic1: Boolean;
    sParam2: string; //0x0C
    nParam2: Integer; //0x10
    boDynamic2: Boolean;
    sParam3: string;
    nParam3: Integer;
    boDynamic3: Boolean;
    sParam4: string;
    nParam4: Integer;
    boDynamic4: Boolean;
    sParam5: string;
    nParam5: Integer;
    boDynamic5: Boolean;
    sParam6: string;
    nParam6: Integer;
    boDynamic6: Boolean;
    sParam7: string;
    nParam7: Integer;
    boDynamic7: Boolean;
    sParam8: string;
    nParam8: Integer;
    boDynamic8: Boolean;
    sParam9: string;
    nParam9: Integer;
    boDynamic9: Boolean;
  end;
  pTQuestConditionInfo = ^TQuestConditionInfo;

  TSayingProcedure = record
    ConditionList: TList;
    ActionList: TList;
    sSayMsg: string;
    SayOldLabelList: TStringList;
    SayNewLabelList: TStringList;
    ElseActionList: TList;
    sElseSayMsg: string;
    ElseSayOldLabelList: TStringList;
    ElseSayNewLabelList: TStringList;
  end;
  pTSayingProcedure = ^TSayingProcedure;
  TSayingRecord = record //0x08
    sLabel: string;
    ProcedureList: TList; //0x04
    boExtJmp: Boolean; //是否允许外部跳转
    boUserWindow: Boolean; //是否自定义窗口
    nResID: SmallInt; //窗口在资源里的ID
    nWindowWidth, nWindowHeight: SmallInt; //窗体宽高
  end;
  pTSayingRecord = ^TSayingRecord;

  TNpcCondition = procedure(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo;
    var Result: Boolean) of object;
  TNpcAction = procedure(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo) of object;

  TNormNpc = class(TAnimalObject) //0x564
    n54C: Integer; //0x54C
    m_nFlag: ShortInt;
    m_boFB: Boolean;
    //0x550 //用于标识此NPC是否有效，用于重新加载NPC列表(-1 为无效)
    m_ScriptList: TList; //0x554
    m_sFilePath: string; //0x558 脚本文件所在目录
    m_boIsHide: Boolean; //0x55C 此NPC是否是隐藏的，不显示在地图中
    m_boIsQuest: Boolean;
    //0x55D NPC类型为地图任务型的，加载脚本时的脚本文件名为 角色名-地图号.txt
    m_sPath: string; //0x560
    m_sHintName: string;
    m_boNpcAutoChangeColor: Boolean;
    m_dwNpcAutoChangeColorTick: LongWord;
    m_dwNpcAutoChangeColorTime: LongWord;
    m_nNpcAutoChangeIdx: Integer;
    m_btNPCRaceServer: Byte;
    m_HookObject: TBaseObject;
    m_boNameFlag: Boolean;
    m_nNameFlag: Integer;
    m_nEffigyState: Integer;
    m_nEffigyOffset: Integer;
    FGotoLable: array[0 .. MAXGOTOLABELID] of Integer;
    m_GotoValue: array[0..9] of string;
  private
    FNpcCondition: array[1..MAXNPCPROCEDURECOUNT - 1] of TNpcCondition;
    FNpcAction: array[1..MAXNPCPROCEDURECOUNT - 1] of TNpcAction;

    Fn34: Integer;
    Fs44: string;
    Fn38: Integer;
    Fs48: string;
    Fn3C: Integer;
    Fs4C: string;
    Fn40: Integer;
    Fn14: Integer;
    Fs50: string;
    Fn18: Integer;
    Fn1C: Integer;
    bo11: Boolean;
    Fn20: Integer;
    FList1C: TStringList;
    FResult: Boolean;
    FOldLabel: Integer;
    //FResetLabel: Boolean;
    FGiveItemList: TList;
    FHookItemList: TList;
    FMasterBase: TBaseObject;
    function CheckVarNameNo(PlayObject: TPlayObject; CheckQuestConditionInfo: pTQuestConditionInfo; var n140, n180: Integer): Boolean;
    procedure ScriptActionError(PlayObject: TPlayObject; sErrMsg: string;
      QuestActionInfo: pTQuestActionInfo; sCmd: string);
    procedure ScriptConditionError(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; sCmd: string);

    procedure ExeAction(PlayObject: TPlayObject; sParam1, sParam2, sParam3:
      string; nParam1, nParam2, nParam3: Integer);

    procedure ActionOfSet(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTake(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTakeW(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClose(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfReset(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfResetMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTimeReCall(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfParam1(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfParam2(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfParam3(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfParam4(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfExeAction(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMapMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMap(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMonGen(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMonClear(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMov(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfInc(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDec(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDiv(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMod(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMul(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPercent(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSum(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfBreakTimeRecall(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPkPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKick(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMovr(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfExChangeMap(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddBatch(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfBatchDelay(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfBatchMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPlayDice(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddNameList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelNameList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddGuildList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelGuildList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddAccountList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelAccountList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddIPList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelIPList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    //procedure ActionOfGoQuest(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    //procedure ActionOfEndQuest(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGoto(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfBreak(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelayGoto(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearDelayGoto(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddTextList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelTextList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGroupMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGroupMapMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRecallHuman(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfReGoto(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildMapMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRandomMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetSendMsgFlag(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfChangeLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDare(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUnMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUnMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGiveItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDynamicGive(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfGetMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    //procedure ActionOfGetMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelNoJobSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSkillLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangePkPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeExp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeCreditPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeJob(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRecallGroupMembers(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearNameList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMapTing(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMobPlace(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetMemberType(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetMemberLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfGamePoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeHairStyle(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfLineMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeNameColor(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfReNewLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeGender(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKillSlave(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKillMonExpRate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPowerRate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeMode(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangePerMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfBonusPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRestReNewLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    //procedure ActionOfDelMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearNeedItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearMakeItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpgradeItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpgradeItemsEx(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMonGenEx(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearMapMon(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfSetMapMode(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfPkZone(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfRestBonusPoint(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfTakeCastleGold(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfHumanHP(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfHumanMP(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGuildBuildPoint(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGuildAuraePoint(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGuildstabilityPoint(PlayObject: TPlayObject;
      QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildFlourishPoint(PlayObject: TPlayObject;
      QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfOpenMagicBox(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSetRankLevelName(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGmExecute(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfGuildChiefItemCount(PlayObject: TPlayObject;
      QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddNameDateList(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfDelNameDateList(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfMobFireBurn(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfMessageBox(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfSetScriptFlag(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfAutoGetExp(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfRecallmob(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfLoadVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSaveVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCalcVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfNotLineAddPiont(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKickNotLineAddPiont(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    //procedure ActionOfStartTakeGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfAnsiReplaceText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfUseBonusPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRepairItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTakeCount(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfStorageTimeChange(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpdateMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpdateMissionTime(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeMissionKillMonCount(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeArithmonmeterCount(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfShowEffect(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAutoMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeGiveItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMobMachineryEvent(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearMachineryEvent(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCreateEctype(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMoveEctype(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMobEctypeMon(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearEctypeMon(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetMapQuest(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfResetMapQuest(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfOpenBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeGameDiamond(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeGameGird(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGetRandomName(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMobSlave(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfHookObject(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRefShowName(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetEffigyState(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfStartWallconquestWar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetGuageBar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddMakeMagic(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddRandomMapGate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelRandomMapGate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGetLargessGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfResetNakedAbilPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangePullulation(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetLimitExpLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeGuildLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfHCall(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCreateGroupFail(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfHookItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeNakedCount(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeHumWuXin(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeMakeMagicLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeMakeMagicPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddGuildMember(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfOpenUrl(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeHumAbility(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSendCenterMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearSendCenterMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfSendEMail(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetHumIcon(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTakeOffItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ConditionOfCheck(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMission(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfRandom(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfGender(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckJob(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfBBCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckItem(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckItemW(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckGold(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckDura(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfDayOfWeek(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfHour(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfMin(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckPkPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckHum(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckBagGage(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckNameList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckAccountList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckIPList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfEqual(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfLapge(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfSmall(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfISSYSOP(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfISAdmin(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfISNewHuman(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckGuildList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCheckTextList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfIsGroupMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfCHECKCONTAINSTEXTLIST(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckOnLine(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);
    procedure ConditionOfIsDupMode(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
      Boolean);

    procedure ConditionOfCheckGroupCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckPoseDir(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckPoseLevel(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckPoseGender(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckPoseMarry(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckLevelEx(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckSlaveCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckBonusPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckAccountIPList(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckNameIPList(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMarry(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMarryCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMaster(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfHaveMaster(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckPoseMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfPoseHaveMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);

    procedure ConditionOfCheckIsMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckPoseIsMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckHaveGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckIsGuildMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckIsCastleaGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckIsCastleMaster(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMemberType(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMemBerLevel(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    {procedure ConditionOfCheckGameGold(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);   }
    procedure ConditionOfCheckGamePoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckNameListPostion(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    //    procedure ConditionOfCheckGuildList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckReNewLevel(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckSlaveLevel(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckSlaveName(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);

    procedure ConditionOfCheckCreditPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckOfGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    {procedure ConditionOfCheckPayMent(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);   }
    procedure ConditionOfCheckUseItem(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckBagSize(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckListCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckDC(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMC(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckSC(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckHP(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMP(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckItemType(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckExp(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckCastleGold(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    {procedure ConditionOfCheckPasswordErrorCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo):
      Boolean;  }
    {procedure ConditionOfIsLockPassword(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfIsLockStorage(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);   }
    procedure ConditionOfCheckGuildBuildPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckGuildAuraePoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckStabilityPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckFlourishPoint(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckContribution(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckRangeMonCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckItemAddValue(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckInMapRange(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckIsAttackGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckIsDefenseGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckCastleDoorStatus(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    {procedure ConditionOfCheckIsAttackAllyGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);  }
    procedure ConditionOfCheckIsDefenseAllyGuild(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckCastleChageDay(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckCastleWarDay(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckOnlineLongMin(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckChiefItemCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckNameDateList(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMapHumanCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMapMonCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckVar(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckServerName(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);

    procedure ConditionOfCheckMapName(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckSafeZone(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckSkill(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfAnsiContainsText(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCompareText(PlayObject: TPlayObject; QuestConditionInfo:
      pTQuestConditionInfo; var Result: Boolean);

    procedure ConditionOfCheckMonMapCount(PlayObject: TPlayObject;
      QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckItemCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckCastleState(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMissionCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMissionKillMonCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckArithmometerCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCanMoveEctype(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckEctypeMonCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMapQuest(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckGameDiamond(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckGameGird(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckEMailOK(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfISUnderWar(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckHumOrNPCRange(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckGroupJobCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckPullulation(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckGuildLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckItemStrengthenCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckItemFluteCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckHumWuXin(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckItemWuXin(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMakeMagicLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckGuildIsFull(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckStrengthenCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckHorseLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfIsOnHouse(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckKillMobName(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckMapSameMonCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
    procedure ConditionOfCheckHitMonName(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);

    function GetDynamicVarList(PlayObject: TPlayObject; sType: string; var sName: string): TList;

    procedure ScriptListError(PlayObject: TPlayObject; List: TStringList);
    //function GetValValue(PlayObject: TPlayObject; sMsg: string; var sValue: string): Boolean; overload;
    //function GetValValue(PlayObject: TPlayObject; sMsg: string; var nValue: Integer): Boolean; overload;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    function GetScriptIndex(sLabel: string): Integer;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
    procedure Click(PlayObject: TPlayObject); virtual;
    procedure UserSelect(PlayObject: TPlayObject; sData: string); virtual;
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); // virtual;
    function GetLineVariableText(PlayObject: TPlayObject; sMsg: string): string;
    function GotoLable(PlayObjectEx: TPlayObject; nLabel: Integer; boExtJmp: Boolean; sLabel: string = ''): string;
    function sub_49ADB8(sMsg, sStr, sText: string): string;
    procedure LoadNpcScript();
    procedure ClearScript(); virtual;
    //procedure SendMsgToUser(PlayObject: TPlayObject; sMsg: string);
    function GetShowName(): string; override;
    //procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); virtual;
  public
    property HookItemList: TList read FHookItemList;
  end;
  TMerchant = class(TNormNpc)
    m_sScript: string;
    m_sScriptFile: string;
    n56C: Integer;
    //m_nPriceRate: Integer; //物品价格倍率 默认为 100%
//    bo574: Boolean;
    m_boCastle: Boolean;
    m_boHide: Boolean;
    dwRefillGoodsTick: LongWord; //0x578
    dwClearExpreUpgradeTick: LongWord; //0x57C
    //m_ItemTypeList: TList;
    //0x580  NPC买卖物品类型列表，脚本中前面的 +1 +30 之类的
  //m_RefillGoodsList: TList; //0x584
  //m_GoodsList: TList; //0x588
    m_NewGoodsList: TList; //0x588
    m_MakeItemsList: TList;
    m_MakeItemsCode: string;
    m_MakeItemsLen: Word;
    m_MakeNamesCode: string;
    m_MakeNamesLen: Word;
    //m_ItemPriceList: TList; //0x58C

    m_UpgradeWeaponList: TList;
    m_boCanMove: Boolean;
    m_dwMoveTime: LongWord;
    m_dwMoveTick: LongWord;
    m_boBuy: Boolean;
    m_boSell: Boolean;
    m_boMakeDrug: Boolean;
    m_boPrices: Boolean;
    m_boStorage: Boolean;
    //    m_boGetback: Boolean;
    m_boArmStrengthen: Boolean; //可以强化装备
    m_boArmUnseal: Boolean;
    m_boArmRemoveStone: Boolean;

    m_boArmAbilityMove: Boolean; //可以属性转移

    //m_boUpgradenow: Boolean;
    //m_boGetBackupgnow: Boolean;
    m_boRepair: Boolean;
    m_boS_repair: Boolean;
    m_boSendmsg2: Boolean;
    m_boGetMarry: Boolean;
    m_boGetMaster: Boolean;
    m_boUseItemName: Boolean;

    m_boGetSellGold: Boolean;
    m_boSellOff: Boolean;
    m_boBuyOff: Boolean;
    m_boDealGold: Boolean;
    m_boInputInteger: Boolean;
    m_boInputString: Boolean;

    m_boUpgradeNow: Boolean;
    m_boGetBackUpgnow: Boolean;
  private
    procedure RefillGoods();
    procedure ClearExpreUpgradeListData();
    function GetSellItemPrice(nPrice: Integer): Integer;
    procedure SaveUpgradingList;
    procedure UpgradeWapon(User: TPlayObject);
    procedure GetBackupgWeapon(User: TPlayObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function GetItemPrice(nIndex: Integer): Integer;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override;
    procedure LoadNPCData();
    procedure SaveNPCData();
    procedure RefSelf();
    procedure LoadUpgradeList();

    procedure LoadNpcScript(); virtual;
    procedure Click(PlayObject: TPlayObject); override;
    procedure ClearScript(); override;
    procedure ClearData();
    //procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string);
    procedure ClientBuyItem(PlayObject: TPlayObject; nInt, nCount: Integer; boBindGold: Boolean);
    function ClientSellItem(PlayObject: TPlayObject; UserItem: pTUserItem): Boolean;
    procedure ClientMakeDrugItem(PlayObject: TPlayObject; nID, nAuto: Integer; sMsg: string);
    procedure ClientUnsealItem(PlayObject: TPlayObject; nItemIndex: Integer; sMsg: string);
    function ClientRepairItem(PlayObject: TPlayObject; UserItem: pTUserItem; boSuperRepair: Boolean): Boolean;

  end;
  TFunMerchant = class(TMerchant)
    FStdModeFunc: array[0..MAXAPPENDFUNCCOUNT] of Integer;
    FPlayLevelUp: array[0..MAXAPPENDFUNCCOUNT] of Integer;
    FUserCmd: array[0..MAXAPPENDFUNCCOUNT] of Integer;
    FMagSelfFunc: array[0..MAXMAGICFUNCOUNT] of Integer;
    FMagTagFunc: array[0..MAXMAGICFUNCOUNT] of Integer;
    FMagTagFuncEx: array[0..MAXMAGICFUNCOUNT] of Integer;
    FMagMonFunc: array[0..MAXMAGICFUNCOUNT] of Integer;
    FClearMission: array[Low(TMissionIndex)..High(TMissionIndex)] of Integer;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure LoadNpcScript(); override;
  end;

  TMapEventMerchant = class(TMerchant)
  public
    procedure LoadNpcScript(); override;
  end;

  TGuildOfficial = class(TNormNpc)
  private
    function ReQuestBuildGuild(PlayObject: TPlayObject; sGuildName: string): Integer;
    function ReQuestGuildWar(PlayObject: TPlayObject; sGuildName: string): Integer;
    procedure DoNate(PlayObject: TPlayObject);
    procedure ReQuestCastleWar(PlayObject: TPlayObject; sIndex: string);
  public
    constructor Create(); override;
    destructor Destroy; override;
    { procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string;
       sVariable: string); override; //FFE9   }
    procedure Run; override; //FFFB
    procedure Click(PlayObject: TPlayObject); override; //FFEB
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override;
    //FFEA
    //procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
  end;
  TTrainer = class(TAnimalObject) //0x574
    n564: Integer;
    m_dw568: LongWord;
    n56C: Integer;
    n570: Integer;
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;

  TBoxMonster = class(TAnimalObject) //0x574
    m_nBoxIndex: Integer;
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
  //  TCastleManager = class(TMerchant)
  TCastleOfficial = class(TMerchant)
  private
    procedure HireArcher(sIndex: string; PlayObject: TPlayObject);
    procedure HireGuard(sIndex: string; PlayObject: TPlayObject);
    procedure RepairDoor(PlayObject: TPlayObject);
    procedure RepairWallNow(nWallIndex: Integer; PlayObject: TPlayObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Click(PlayObject: TPlayObject); override; //FFEB
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override;
    //FFEA
    {procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string;
      sVariable: string); override; //FFE9 }
    //procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
  end;

  pTCenterMsg = ^TCenterMsg;
  TCenterMsg = record
    Npc: TNormNpc;
    nLable: Integer;
    dwRunTick: LongWord;
    dwTimeout: LongWord;
    nFlag: Integer;
  end;

implementation

uses Castle, HUtil32, LocalDB, Envir, Guild, EDcodeEx, ObjMon2, UsrEngn,
  Event, {$IFDEF PLUGOPEN}PlugOfEngine, {$ENDIF}Common, IdSrvClient, ObjPlayCmd, M2Share, ItmUnit, FrnEmail;

procedure AddList(sHumName, sListFileName: string); //0049B620
var
  i: Integer;
  LoadList: TStringList;
  s10: string;
  bo15: Boolean;
begin
  sListFileName := g_Config.sGameDataDir + sListFileName;
  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
  end;
  bo15 := False;
  for i := 0 to LoadList.Count - 1 do begin
    s10 := Trim(LoadList.Strings[i]);
    if CompareText(sHumName, s10) = 0 then begin
      bo15 := True;
      break;
    end;
  end;
  if not bo15 then begin
    LoadList.Add(sHumName);
    try
      LoadList.SaveToFile(sListFileName);
    except
      MainOutMessage('saving fail.... => ' + sListFileName);
    end;
  end;
  LoadList.Free;
end;

procedure DelList(sHumName, sListFileName: string);
var
  i: Integer;
  LoadList: TStringList;
  s10: string;
  bo15: Boolean;
begin
  sListFileName := g_Config.sGameDataDir + sListFileName;
  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
  end;
  bo15 := False;
  for i := 0 to LoadList.Count - 1 do begin
    if LoadList.Count <= 0 then
      break;
    s10 := Trim(LoadList.Strings[i]);
    if CompareText(sHumName, s10) = 0 then begin
      LoadList.Delete(i);
      bo15 := True;
      break;
    end;
  end;
  if bo15 then begin
    try
      LoadList.SaveToFile(sListFileName);
    except
      MainOutMessage('saving fail.... => ' + sListFileName);
    end;
  end;
  LoadList.Free;
end;

function CheckStringList(sHumName, sListFileName: string): Boolean;
var
  i: Integer;
  LoadList: TStringList;
begin
  Result := False;
  sListFileName := g_Config.sGameDataDir + sListFileName;
  if FileExists(sListFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
    for i := 0 to LoadList.Count - 1 do begin
      if CompareText(Trim(LoadList.Strings[i]), sHumName) = 0 then begin
        Result := True;
        break;
      end;
    end;
    LoadList.Free;
  end
  else begin
    MainOutMessage('file not found => ' + sListFileName);
  end;
end;

function CheckAnsiContainsTextList(sTest, sListFileName: string): Boolean;
var
  i: Integer;
  LoadList: TStringList;
begin
  Result := False;
  sListFileName := g_Config.sGameDataDir + sListFileName;
  if FileExists(sListFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
    for i := 0 to LoadList.Count - 1 do begin
      if AnsiContainsText(Trim(LoadList.Strings[i]), sTest) then begin
        Result := True;
        break;
      end;
    end;
    LoadList.Free;
  end
  else begin
    MainOutMessage('file not found => ' + sListFileName);
  end;
end;

function TNormNpc.CheckVarNameNo(PlayObject: TPlayObject; CheckQuestConditionInfo: pTQuestConditionInfo; var n140, n180: Integer): Boolean;
var
  n100: Integer;
begin
  Result := False;
  n140 := -1;
  n180 := CheckQuestConditionInfo.nParam2;
  n100 := GetValNameNo(CheckQuestConditionInfo.sParam1);
  if n100 >= 0 then begin
    case n100 of
      0..99: begin
          n140 := PlayObject.m_nVal[n100];
          Result := True;
        end;
      2000..2999: begin
          n140 := g_Config.GlobalVal[n100 - 2000];
          Result := True;
        end;
      200..209: begin
          n140 := PlayObject.m_DyVal[n100 - 200];
          Result := True;
        end;
      300..399: begin
          n140 := PlayObject.m_nMval[n100 - 300];
          Result := True;
        end;
      400..499: begin
          n140 := g_Config.GlobaDyMval[n100 - 400];
          Result := True;
        end;
      5000..5999: begin
          n140 := PlayObject.m_nInteger[n100 - 5000];
          Result := True;
        end;
      6000..6999: begin
          if (CompareText(PlayObject.m_sString[n100 - 6000], CheckQuestConditionInfo.sParam2) = 0) then begin
            n140 := 0;
            n180 := 0;
            Result := True;
          end;
        end;
      7000..7999: begin
          if (CompareText(g_Config.GlobalAVal[n100 - 7000], CheckQuestConditionInfo.sParam2) = 0) then begin
            n140 := 0;
            n180 := 0;
            Result := True;
          end;
        end;
      800..899: begin
          if (CompareText(g_Config.GlobalUVal[n100 - 800], CheckQuestConditionInfo.sParam2) = 0) then begin
            n140 := 0;
            n180 := 0;
            Result := True;
          end;
        end;
      900..909: begin
          if (CompareText(m_GotoValue[n100 - 900], CheckQuestConditionInfo.sParam2) = 0) then begin
            n140 := 0;
            n180 := 0;
            Result := True;
          end;
        end;
      1000..1019: begin
          n140 := PlayObject.m_CustomVariable[n100 - 1000];
          Result := True;
          if n100 = 1000 then
            PlayObject.LiteraryChange(True);
        end;
    end;
  end;
end;

procedure TCastleOfficial.Click(PlayObject: TPlayObject); //004A4588
begin
  if m_Castle = nil then begin
    PlayObject.MenuMsg('NPC不属于城堡.');
    Exit;
  end;
  if TUserCastle(m_Castle).IsMasterGuild(TGuild(PlayObject.m_MyGuild)) or (PlayObject.m_btPermission >= 3) then
    inherited;
end;
{
procedure TCastleOfficial.GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string);
begin
  inherited;

end;       }

procedure TCastleOfficial.UserSelect(PlayObject: TPlayObject; sData: string);
var
  s3C, s20, sMsg, sLabel, s18: string;
  //  boCanJmp: Boolean;
  nLabel: integer;
resourcestring
  sExceptionMsg = '[Exception] TCastleManager::UserSelect... ';
begin
  if m_Castle = nil then begin
    PlayObject.SendDefMsg(Self, SM_MENU_OK, Integer(Self), 0, 0, 0, 'NPC不属于城堡.');
    Exit;
  end;
  if TUserCastle(m_Castle).IsMasterGuild(TGuild(PlayObject.m_MyGuild)) and (PlayObject.IsGuildMaster) then begin
    inherited;
    try
      PlayObject.m_nScriptGotoCount := 0;

      if (sData <> '') and (sData[1] = '@') then begin
        sMsg := GetValidStr3(sData, sLabel, [#13]);
        s3C := '';
        s18 := sLabel;

        if Length(sLabel) < 2 then
          exit;
        if (sLabel[2] = '@') and (sLabel[1] = '@') then begin
          sLabel := Copy(sLabel, 3, length(sLabel) - 2);
        end
        else begin
          sLabel := Copy(sLabel, 2, length(sLabel) - 1);
        end;
        nLabel := StrToIntDef(sLabel, -99999);
        if nLabel >= 100000 then
          nLabel := nLabel mod 100000;
        //boCanJmp :=
        PlayObject.LableIsCanJmp(s18, PlayObject.m_boResetLabel and (nLabel = -99999));
        PlayObject.m_sScriptLable := s18;
        //if FResetLabel and (nLabel = -99999) then
//          nLabel := GetScriptIndex(s18);
        //else nLabel := StrToIntDef(sLabel, 0);
        //nLabel := StrToIntDef(sLabel, 0);

        //GotoLable(PlayObject, nLabel, not boCanJmp, s18);
        //if not boCanJmp then Exit;

        {if CompareText(sLabel, sSL_SENDMSG) = 0 then begin
          SendCustemMsg(PlayObject, sMsg);
          PlayObject.SendDefMsg(Self, SM_MENU_OK, Integer(Self), 0, 0, 0, s3C);
        end
        else }
        if CompareText(s18, sCASTLENAME) = 0 then begin
          sMsg := Trim(sMsg);
          if sMsg <> '' then begin
            TUserCastle(m_Castle).m_sName := sMsg;
            TUserCastle(m_Castle).Save;
            TUserCastle(m_Castle).m_MasterGuild.RefMemberName;
            s3C := '城堡名称更改成功...';
          end
          else begin
            s3C := '城堡名称更改失败.';
          end;
          PlayObject.SendDefMsg(Self, SM_MENU_OK, Integer(Self), 0, 0, 0, s3C);
        end
        else if CompareText(s18, sWITHDRAWAL) = 0 then begin
          case TUserCastle(m_Castle).WithDrawalGolds(PlayObject, StrToIntDef(sMsg, 0)) of
            -4: s3C := '输入的金币数不正确.';
            -3: s3C := '您无法携带更多的东西了。';
            -2: s3C := '该城内没有这么多金币.';
            -1: s3C := '只有行会 ' + TUserCastle(m_Castle).m_sOwnGuild + ' 的掌门人才能使用.';
            1: GotoLable(PlayObject, 0, False);
          end;
          PlayObject.SendDefMsg(Self, SM_MENU_OK, Integer(Self), 0, 0, 0, s3C);
        end
        else if CompareText(s18, sRECEIPTS) = 0 then begin
          case TUserCastle(m_Castle).ReceiptGolds(PlayObject, StrToIntDef(sMsg, 0)) of
            -4: s3C := '输入的金币数不正确.';
            -3: s3C := '你已经达到在城内存放货物的限制了。';
            -2: s3C := '你没有那么多金币.';
            -1: s3C := '只有行会 ' + TUserCastle(m_Castle).m_sOwnGuild + ' 的掌门人才能使用.';
            1: GotoLable(PlayObject, 0, False);
          end;
          PlayObject.SendDefMsg(Self, SM_MENU_OK, Integer(Self), 0, 0, 0, s3C);
        end
        else if CompareText(s18, sOPENMAINDOOR) = 0 then begin
          TUserCastle(m_Castle).MainDoorControl(False);
          GotoLable(PlayObject, FOldLabel, False);
        end
        else if CompareText(s18, sCLOSEMAINDOOR) = 0 then begin
          TUserCastle(m_Castle).MainDoorControl(True);
          GotoLable(PlayObject, FOldLabel, False);
        end
        else if CompareText(s18, sREPAIRDOORNOW) = 0 then begin
          RepairDoor(PlayObject);
          GotoLable(PlayObject, FOldLabel, False);
        end
        else if CompareText(s18, sREPAIRWALLNOW1) = 0 then begin
          RepairWallNow(1, PlayObject);
          GotoLable(PlayObject, FOldLabel, False);
        end
        else if CompareText(s18, sREPAIRWALLNOW2) = 0 then begin
          RepairWallNow(2, PlayObject);
          GotoLable(PlayObject, FOldLabel, False);
        end
        else if CompareText(s18, sREPAIRWALLNOW3) = 0 then begin
          RepairWallNow(3, PlayObject);
          GotoLable(PlayObject, FOldLabel, False);
        end
        else if CompareText(s18, sGuardRule_NormalNow) = 0 then begin
          TUserCastle(m_Castle).m_boGuardRule := False;
          GotoLable(PlayObject, FOldLabel, False);
        end
        else if CompareText(s18, sGuardRule_PKAttack) = 0 then begin
          TUserCastle(m_Castle).m_boGuardRule := True;
          GotoLable(PlayObject, FOldLabel, False);
        end
        else if CompareLStr(s18, sHIREGUARDNOW, Length(sHIREGUARDNOW)) then begin
          s20 := Copy(s18, Length(sHIREGUARDNOW) + 1, Length(s18));
          HireGuard(s20, PlayObject);
          PlayObject.SendDefMsg(Self, SM_MENU_OK, Integer(Self), 0, 0, 0, '');
          GotoLable(PlayObject, FOldLabel, False);
        end
        else if CompareLStr(s18, sHIREARCHERNOW, Length(sHIREARCHERNOW)) then begin
          s20 := Copy(s18, Length(sHIREARCHERNOW) + 1, Length(s18));
          HireArcher(s20, PlayObject);
          PlayObject.SendDefMsg(Self, SM_MENU_OK, Integer(Self), 0, 0, 0, '');
          GotoLable(PlayObject, FOldLabel, False);
        end;
      end;
    except
      MainOutMessage(sExceptionMsg);
    end;
  end
  else begin
    s3C := '你没有权利使用.';
    PlayObject.SendDefMsg(Self, SM_MENU_OK, Integer(Self), 0, 0, 0, s3C);
  end;
  //  inherited;
end;

procedure TCastleOfficial.HireGuard(sIndex: string; PlayObject: TPlayObject);
var
  n10: Integer;
  ObjUnit: pTObjUnit;
begin
  if m_Castle = nil then begin
    PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, 'NPC不属于城堡.');
    //PlayObject.SysMsg('NPC不属于城堡.', c_Red, t_Hint);
    Exit;
  end;
  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nHireGuardPrice then begin
    n10 := StrToIntDef(sIndex, 0) - 1;
    if n10 <= MAXCALSTEGUARD then begin
      if TUserCastle(m_Castle).m_Guard[n10].BaseObject = nil then begin
        if not TUserCastle(m_Castle).m_boUnderWar then begin
          ObjUnit := @TUserCastle(m_Castle).m_Guard[n10];
          ObjUnit.BaseObject :=
            UserEngine.RegenMonsterByName(TUserCastle(m_Castle).m_sMapName,
            ObjUnit.nX,
            ObjUnit.nY,
            ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nHireGuardPrice);
            ObjUnit.BaseObject.m_Castle := TUserCastle(m_Castle);
            //TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
            //TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
            //PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '雇佣成功.');
            PlayObject.SysMsg('雇佣成功.', c_Red, t_Hint);
          end;
        end
        else begin
          //PlayObject.SysMsg('现在无法雇佣.', c_Red, t_Hint);
          PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '攻城期间不能雇佣.');
        end;
      end
    end
    else begin
      //PlayObject.SysMsg('指令错误.', c_Red, t_Hint);
      PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '指令错误.');
    end;
  end
  else begin
    //PlayObject.SysMsg('城内资金不足.', c_Red, t_Hint);
    PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '城内资金不足.');
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nHireGuardPrice then begin
    n10:=StrToIntDef(sIndex,0) - 1;
    if n10 <= MAXCALSTEGUARD then begin
      if UserCastle.m_Guard[n10].BaseObject = nil then begin
        if not UserCastle.m_boUnderWar then begin
          ObjUnit:=@UserCastle.m_Guard[n10];
          ObjUnit.BaseObject:=UserEngine.RegenMonsterByName(UserCastle.m_sMapName,
                                                          ObjUnit.nX,
                                                          ObjUnit.nY,
                                                          ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(UserCastle.m_nTotalGold,g_Config.nHireGuardPrice);
            ObjUnit.BaseObject.m_Castle:=UserCastle;
            TGuardUnit(ObjUnit.BaseObject).m_nX550:=ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554:=ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_n558:=3;
            PlayObject.SysMsg('雇佣成功.',c_Green,t_Hint);
          end;

        end else begin
          PlayObject.SysMsg('现在无法雇佣.',c_Red,t_Hint);
        end;
      end
    end else begin
      PlayObject.SysMsg('指令错误.',c_Red,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('城内资金不足.',c_Red,t_Hint);
  end;
  }
end;

procedure TCastleOfficial.HireArcher(sIndex: string; PlayObject: TPlayObject);
var
  n10: Integer;
  ObjUnit: pTObjUnit;
begin
  if m_Castle = nil then begin
    PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, 'NPC不属于城堡.');
    //PlayObject.SysMsg('NPC不属于城堡.', c_Red, t_Hint);
    Exit;
  end;
  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nHireArcherPrice then begin
    n10 := StrToIntDef(sIndex, 0) - 1;
    if n10 <= MAXCASTLEARCHER then begin
      if TUserCastle(m_Castle).m_Archer[n10].BaseObject = nil then begin
        if not TUserCastle(m_Castle).m_boUnderWar then begin
          ObjUnit := @TUserCastle(m_Castle).m_Archer[n10];
          ObjUnit.BaseObject := UserEngine.RegenMonsterByName(TUserCastle(m_Castle).m_sMapName,
            ObjUnit.nX, ObjUnit.nY, ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nHireArcherPrice);
            ObjUnit.BaseObject.m_Castle := TUserCastle(m_Castle);
            //TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
            //TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
            PlayObject.SysMsg('雇佣成功.', c_Red, t_Hint);
          end;
        end
        else begin
          //PlayObject.SysMsg('现在无法雇佣.', c_Red, t_Hint);
          PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '攻城期间不能雇佣.');
        end;
      end
      else begin
        PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '已经成功雇佣.');
        //PlayObject.SysMsg('已经雇佣.', c_Red, t_Hint);
      end;
    end
    else begin
      //PlayObject.SysMsg('指令错误.', c_Red, t_Hint);
      PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '指令错误.');
    end;
  end
  else begin
    //PlayObject.SysMsg('城内资金不足.', c_Red, t_Hint);
    PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '城内资金不足.');
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nHireArcherPrice then begin
    n10:=StrToIntDef(sIndex,0) - 1;
    if n10 <= MAXCASTLEARCHER then begin
      if UserCastle.m_Archer[n10].BaseObject = nil then begin
        if not UserCastle.m_boUnderWar then begin
          ObjUnit:=@UserCastle.m_Archer[n10];
          ObjUnit.BaseObject:=UserEngine.RegenMonsterByName(UserCastle.m_sMapName,
                                                          ObjUnit.nX,
                                                          ObjUnit.nY,
                                                          ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(UserCastle.m_nTotalGold,g_Config.nHireArcherPrice);
            ObjUnit.BaseObject.m_Castle:=UserCastle;
            TGuardUnit(ObjUnit.BaseObject).m_nX550:=ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554:=ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_n558:=3;
            PlayObject.SysMsg('雇佣成功.',c_Green,t_Hint);
          end;

        end else begin
          PlayObject.SysMsg('现在无法雇佣.',c_Red,t_Hint);
        end;
      end else begin
        PlayObject.SysMsg('早已雇佣.',c_Red,t_Hint);
      end;
    end else begin
      PlayObject.SysMsg('指令错误.',c_Red,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('城内资金不足.',c_Red,t_Hint);
  end;
  }
end;
{ TMerchant }
{
function TMerchant.CheckItemType(nStdMode: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to m_ItemTypeList.Count - 1 do begin
    if (Integer(m_ItemTypeList.Items[i]) = 999) or
      (Integer(m_ItemTypeList.Items[i]) = nStdMode) then begin
      Result := True;
      break;
    end;
  end;
end;

function TMerchant.CheckItemTypeEx(wIdent: Integer): Boolean;
var
  i: Integer;
  StdItem: pTStdItem;
begin
  Result := False;
  StdItem := UserEngine.GetStdItem(wIdent);
  if StdItem <> nil then begin
    for i := 0 to m_ItemTypeList.Count - 1 do begin
      if (Integer(m_ItemTypeList.Items[i]) = 999) or
        (Integer(m_ItemTypeList.Items[i]) = StdItem.StdMode2) then begin
        Result := True;
        break;
      end;
    end;
  end;
end;       }

function TMerchant.GetItemPrice(nIndex: Integer): Integer;
var
  StdItem: pTStdItem;
begin
  Result := -1;
  //if Result < 0 then begin  }
  StdItem := UserEngine.GetStdItem(nIndex);
  if StdItem <> nil then begin
    //if CheckItemType(StdItem.StdMode2) then
    Result := StdItem.Price;
  end;
  //end;
end;

procedure TMerchant.UserSelect(PlayObject: TPlayObject; sData: string);
{procedure SuperRepairItem(User: TPlayObject);
begin
  User.SendDefMsg(Self, SM_SUPERSENDUSERREPAIR, Integer(Self), 0, 0, 0, '');
end;   }

//获取可打造物品列表
  procedure MakeDurg(User: TPlayObject);
    {var
      i: Integer;
      sSENDMSG: string;
      MakeGoods: pTMakeGoods; }
  begin
    {sSENDMSG := '';
    for i := 0 to m_MakeItemsList.Count - 1 do begin
      MakeGoods := m_MakeItemsList[i];
      sSENDMSG := sSENDMSG + IntToStr(I) + '/' + EncodeString(MakeGoods.sName) + '/';
      sSENDMSG := sSENDMSG + EncodeBuffer(@MakeGoods.MakeItem, SizeOf(MakeGoods.MakeItem)) + '/';
    end;  }
    if (m_MakeItemsCode <> '') and (m_MakeNamesCode <> '') then
      User.SendDefSocket(User, SM_SENDUSERMAKEDRUGITEMLIST, Integer(Self),
        m_MakeItemsList.Count, m_MakeItemsLen, m_MakeNamesLen,
        m_MakeNamesCode + '/' + m_MakeItemsCode);
  end;

  //获取商店物品列表
  procedure BuyItem(User: TPlayObject; nInt, nFlag: Integer);
  var
    i: Integer;
    sSENDMSG: string;
    Goods: pTGoods;
    UserGoods: TUserGoods;
  begin
    sSENDMSG := '';
    if (nFlag or 1 = nFlag) then
    begin
      for i := 0 to m_NewGoodsList.Count - 1 do begin
        Goods := m_NewGoodsList.Items[i];
        if (Goods = nil) then
          Continue;
        UserGoods.btIdx := Goods.btIdx;
        UserGoods.nItemIdx := Goods.UserItem.wIndex;
        UserGoods.nItemPic := GetItemPrice(Goods.UserItem.wIndex);
        UserGoods.nStock := Goods.nStock;
        sSENDMSG := sSENDMSG + EncodeBuffer(@UserGoods, SizeOf(TUserGoods)) + '/';
      end;
    end;
    //if sSENDMSG <> '' then
    User.SendDefSocket(Self, SM_SENDGOODSLIST, Integer(Self), nInt, LoWord(nFlag), HiWord(nFlag), sSENDMSG);
  end;

  {procedure SellItem(User: TPlayObject);
  begin
    User.SendDefMsg(Self, SM_SENDUSERSELL, Integer(Self), 0, 0, 0, '');
  end;

  procedure RepairItem(User: TPlayObject);
  begin
    User.SendDefMsg(Self, SM_SENDUSERREPAIR, Integer(Self), 0, 0, 0, '');
  end;      }
  {procedure ItemPrices(User: TPlayObject); //
  begin

  end;   }
  procedure Storage(User: TPlayObject); //004A1648
  begin
    User.SendStorageInfo();
    //User.SendDefMsg(Self, SM_SENDUSERSTORAGEITEM, Integer(Self), 0, 0, 0, '');
  end;
  procedure StoragePass(User: TPlayObject); //004A1648
  begin
    User.SetStoragePass();
    //User.SendDefMsg(Self, SM_SENDUSERSTORAGEITEM, Integer(Self), 0, 0, 0, '');
  end;
  {procedure GetBack(User: TPlayObject); //004A1674
  begin
    User.SendMsg(Self, RM_USERGETBACKITEM, 0, Integer(Self), 0, 0, '');
  end;  }

  procedure OpenArmStrengthenDlg(User: TPlayObject); //004A1674
  begin
    if g_Config.boOpenArmStrengthen then
      User.SendDefMsg(Self, SM_OPENARMSTRENGTHENDLG, Integer(Self), 0, 0, 0, '');
  end;

  procedure OpenArmAbilityMoveDlg(User: TPlayObject); //004A1674
  begin
    //if g_Config.boOpenArmAbilityMove then
      User.SendDefMsg(Self, SM_OPENARMABILITYMOVEDLG, Integer(Self), 0, 0, 0, '');
  end;

  procedure OpenArmUnseal(User: TPlayObject); //004A1674
  begin
    User.SendDefMsg(Self, SM_UNSEAL, Integer(Self), 0, 0, 0, '');
  end;
  procedure OpenArmRemoveStone(User: TPlayObject); //004A1674
  begin
    User.SendDefMsg(Self, SM_REMOVESTONE, Integer(Self), 0, 0, 0, '');
  end;
  {procedure GetPreviousPage(User: TPlayObject);
  begin
    if User.m_nBigStoragePage > 0 then
      Dec(User.m_nBigStoragePage)
    else User.m_nBigStoragePage := 0;
    User.SendMsg(Self, RM_USERBIGGETBACKITEM, User.m_nBigStoragePage, Integer(Self), 0, 0, '');
  end;
  procedure GetNextPage(User: TPlayObject);
  begin
    Inc(User.m_nBigStoragePage);
    User.SendMsg(Self, RM_USERBIGGETBACKITEM, User.m_nBigStoragePage, Integer(Self), 0, 0, '');
  end;   }
var
  sLabel, s18, sMsg, sVar: string;
  boCanJmp: Boolean;
  nLabel, nVar, nParam, nFlag: integer;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::UserSelect... Data: %s';
begin
  inherited;
  //if not (ClassNameIs(TMerchant.ClassName)) then Exit; //如果类名不是 TMerchant 则不执行以下处理函数
  try
    PlayObject.m_nScriptGotoCount := 0;

    if (not m_boCastle) or (not ((m_Castle <> nil) and TUserCastle(m_Castle).m_boUnderWar)) and (PlayObject <> nil) then begin
      if not PlayObject.m_boDeath and (sData <> '') and (sData[1] = '@') then begin
        sMsg := GetValidStr3(sData, sLabel, [#13]);
        s18 := sLabel;
        if Length(sLabel) < 2 then
          exit;
        if (sLabel[2] = '@') and (sLabel[1] = '@') then begin
          sLabel := Copy(sLabel, 3, length(sLabel) - 2);
        end
        else begin
          sLabel := Copy(sLabel, 2, length(sLabel) - 1);
        end;
        nLabel := StrToIntDef(sLabel, -99999);
        if nLabel >= 100000 then
          nLabel := nLabel mod 100000;
        boCanJmp := PlayObject.LableIsCanJmp(s18, PlayObject.m_boResetLabel and (nLabel = -99999));
        PlayObject.m_sScriptLable := s18;

        if PlayObject.m_boResetLabel and (nLabel = -99999) then
          nLabel := GetScriptIndex(s18);

        nFlag := 0;
        if m_boBuy then
          nFlag := nFlag or 1;
        if m_boSell then
          nFlag := nFlag or 2;
        if m_boRepair then
          nFlag := nFlag or 4;
        if m_boS_repair then
          nFlag := nFlag or 8;

        if CompareText(s18, sBUY) = 0 then begin
          if m_boBuy then
            BuyItem(PlayObject, 0, nFlag);
          exit;
        end
        else if CompareText(s18, sBINDBUY) = 0 then begin
          if m_boBuy then
            BuyItem(PlayObject, 1, nFlag);
          exit;
        end
        else if CompareText(s18, sSELL) = 0 then begin
          if m_boSell then
            BuyItem(PlayObject, 2, nFlag);
          exit;
        end
        else if CompareText(s18, sREPAIR) = 0 then begin
          if m_boRepair then
            BuyItem(PlayObject, 3, nFlag);
          exit;
        end
        else if CompareText(s18, sSUPERREPAIR) = 0 then begin
          if m_boS_repair then
            BuyItem(PlayObject, 4, nFlag);
          exit;
        end
        else if CompareLStr(s18, sINPUTINTEGER, Length(sINPUTINTEGER)) then begin
          if m_boInputInteger and (sMsg <> '') then begin
            sVar := Copy(s18, Length(sINPUTINTEGER) + 1, Length(sINPUTINTEGER));
            nVar := StrToIntDef(sVar, -1);
            nParam := StrToIntDef(sMsg, 0);
            if (nVar >= Low(PlayObject.m_nInteger)) and (nVar <= High(PlayObject.m_nInteger)) and (nParam >= 0) then begin
              PlayObject.m_nInteger[nVar] := nParam;
              GotoLable(PlayObject, nLabel, not boCanJmp, s18);
            end;
          end;
          exit;
        end
        else if CompareLStr(s18, sINPUTSTRING, Length(sINPUTSTRING)) then begin
          if m_boInputString and (sMsg <> '') then begin
            sVar := Copy(s18, Length(sINPUTSTRING) + 1, Length(sINPUTSTRING));
            nVar := StrToIntDef(sVar, -1);
            if (nVar >= Low(PlayObject.m_nInteger)) and (nVar <= High(PlayObject.m_nInteger)) then begin
              PlayObject.m_sString[nVar] := sMsg;
              GotoLable(PlayObject, nLabel, not boCanJmp, s18);
            end;
          end;
          exit;
        end;
        GotoLable(PlayObject, nLabel, not boCanJmp, s18);

        if not boCanJmp then
          exit;

        if CompareText(s18, sMAKEDURG) = 0 then begin
          if m_boMakeDrug then
            MakeDurg(PlayObject);
        end
        else if CompareText(s18, sSTORAGE) = 0 then begin
          if m_boStorage then
            Storage(PlayObject);
        end
        else if CompareText(s18, sSTORAGEPASS) = 0 then begin
          if m_boStorage then
            StoragePass(PlayObject);
        end
        else if CompareText(s18, sARMSTRENGTHEN) = 0 then begin
          if m_boArmStrengthen then
            OpenArmStrengthenDlg(PlayObject);
        end
        else if CompareText(s18, sARMABILITYMOVE) = 0 then begin
          if m_boArmAbilityMove then
            OpenArmAbilityMoveDlg(PlayObject);
        end
        else if CompareText(s18, sARMUNSEAL) = 0 then begin
          if m_boArmUnseal then
            OpenArmUnseal(PlayObject);
        end
        else if CompareText(s18, sARMREMOVESTONE) = 0 then begin
          if m_boArmRemoveStone then
            OpenArmRemoveStone(PlayObject);
        end
        else if CompareText(s18, sUPGRADENOW) = 0 then begin
          if m_boUpgradenow then
            UpgradeWapon(PlayObject);
        end
        else if CompareText(s18, sGETBACKUPGNOW) = 0 then begin
          if m_boGetBackupgnow then
            GetBackupgWeapon(PlayObject);
        end;
      end;
    end;
  except
    MainOutMessage(format(sExceptionMsg, [sData]));
  end;
end;

procedure TMerchant.Run();
var
  nCheckCode: Integer;
resourcestring
  sExceptionMsg1 = '[Exception] TMerchant::Run... Code = %d';
  sExceptionMsg2 = '[Exception] TMerchant::Run -> Move Code = %d';
begin
  nCheckCode := 0;
  try
    if (GetTickCount() - dwRefillGoodsTick) > 30000 then begin
      dwRefillGoodsTick := GetTickCount();
      RefillGoods();
    end;

    nCheckCode := 1;
    if (GetTickCount - dwClearExpreUpgradeTick) > 10 * 60 * 1000 then begin
      dwClearExpreUpgradeTick := GetTickCount();
      ClearExpreUpgradeListData();
    end;
    {nCheckCode := 2;
    if Random(50) = 0 then begin
      TurnTo(Random(8));
    end
    else begin
      if Random(50) = 0 then    SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;   }
    nCheckCode := 3;
    //    if m_boCastle and (UserCastle.m_boUnderWar)then begin
    if not m_boHide then begin
      if m_boCastle and (m_Castle <> nil) and TUserCastle(m_Castle).m_boUnderWar then begin
        if not m_boFixedHideMode then begin
          SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
          m_boFixedHideMode := True;
        end;
      end
      else begin
        if m_boFixedHideMode then begin
          m_boFixedHideMode := False;
          TurnTo(m_btDirection);
          //SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
        end;
      end;
    end
    else begin
      if not m_boFixedHideMode then begin
        SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
        m_boFixedHideMode := True;
      end;
    end;
    nCheckCode := 4;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg1, [nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
  try
    if m_boCanMove and (GetTickCount - m_dwMoveTick > m_dwMoveTime * 1000) then begin
      m_dwMoveTick := GetTickCount();
      SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      MapRandomMove(m_PEnvir, 0);
    end;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg2, [nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
  inherited;
end;

function TMerchant.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TMerchant.LoadNPCData;
var
  sFile: string;
begin
  sFile := m_sScript + '-' + m_sScriptFile;
  LoadUpgradeList();
end;

procedure TMerchant.SaveNPCData;
begin
  //
end;

procedure TMerchant.SaveUpgradingList;
begin
  try
    try
      FrmDB.SaveUpgradeWeaponRecord(m_sScript + '-' + m_sMapName, m_UpgradeWeaponList);
    except
      MainOutMessage('Failure in saving upgradinglist - ' + m_sCharName);
    end;
  except
    MainOutMessage('[Exception] TMerchant.SaveUpgradingList');
  end;
end;

constructor TMerchant.Create;
begin
  inherited;
  m_sScript := '';
  m_sScriptFile := '';
  m_btRaceImg := RCC_MERCHANT;
  m_wAppr := 0;
  //m_nPriceRate := 100;
  m_boCastle := False;
  m_btNPCRaceServer := NPC_RC_MERCHANT;
  m_boHide := False;
  //m_ItemTypeList := TList.Create;
  //m_RefillGoodsList := TList.Create;
  //m_GoodsList := TList.Create;
  m_NewGoodsList := TList.Create;
  m_MakeItemsList := TList.Create;
  m_MakeItemsCode := '';
  m_MakeNamesCode := '';
  //m_ItemPriceList := TList.Create;
  m_UpgradeWeaponList := TList.Create;

  dwRefillGoodsTick := GetTickCount();
  dwClearExpreUpgradeTick := GetTickCount();
  m_dwMoveTick := GetTickCount();
  RefSelf();
end;

procedure TMerchant.RefillGoods;
var
  i, nCHECK: Integer;
  Goods: pTGoods;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::RefillGoods %s/%d:%d [%s] Code:%d';
begin
  nCHECK := 0;
  try
    for i := 0 to m_NewGoodsList.Count - 1 do
    begin
      Goods := m_NewGoodsList.Items[i];
      if not Assigned(Goods) then
        Continue;
      if (GetTickCount() - Goods.dwRefillTick) > Goods.dwRefillTime * 60 * 1000 then
      begin
        Goods.dwRefillTick := GetTickCount();
        Goods.nStock := Goods.nCount;
      end;
    end;  
  except
    on E: Exception do
      MainOutMessage(Format(sExceptionMsg, [m_sCharName, m_nCurrX, m_nCurrY, E.Message, nCHECK]));
  end;
end;

procedure TMerchant.RefSelf();
begin
  m_boBuy := False;
  m_boSell := False;
  m_boMakeDrug := False;
  m_boPrices := False;
  m_boStorage := False;
  //m_boGetback := False;
  m_boArmStrengthen := False;
  m_boArmUnseal := False;
  m_boArmRemoveStone := False;
  m_boArmAbilityMove := False;

  m_boSendmsg2 := False;
  m_boGetMarry := False;
  m_boGetMaster := False;

  //m_boUpgradenow := False;
//  m_boGetBackupgnow := False;
  m_boRepair := False;
  m_boS_repair := False;
  m_boGetMarry := False;
  m_boGetMaster := False;
  m_boUseItemName := False;

  m_boGetSellGold := False;
  m_boSellOff := False;
  m_boBuyOff := False;
  m_boDealGold := False;

  m_boInputInteger := False;
  m_boInputString := False;

  m_boUpgradeNow := False;
  m_boGetBackUpgnow := False;
end;

destructor TMerchant.Destroy;
var
  i: Integer;
  //  ii: Integer;
  //  List: TList;
begin
  //m_ItemTypeList.Free;
  {for i := 0 to m_RefillGoodsList.Count - 1 do begin
    DisPose(pTGoods(m_RefillGoodsList.Items[i]));
  end;     }

  for i := 0 to m_NewGoodsList.Count - 1 do begin
    Dispose(pTGoods(m_NewGoodsList.Items[i]));
  end;
  m_NewGoodsList.Free;

  for i := 0 to m_MakeItemsList.Count - 1 do begin
    Dispose(pTMakeGoods(m_MakeItemsList.Items[i]));
  end;
  m_MakeItemsList.Free;
  m_MakeItemsCode := '';
  m_MakeNamesCode := '';

  for i := 0 to m_UpgradeWeaponList.Count - 1 do begin
    DisPose(pTUpgradeInfo(m_UpgradeWeaponList.Items[i]));
  end;
  m_UpgradeWeaponList.Free;

  inherited;
end;

procedure TMerchant.ClearExpreUpgradeListData;
var
  i: Integer;
  UpgradeInfo: pTUpgradeInfo;
begin
  for i := m_UpgradeWeaponList.Count - 1 downto 0 do begin
    if m_UpgradeWeaponList.Count <= 0 then
      break;
    UpgradeInfo := m_UpgradeWeaponList.Items[i];
    if UpgradeInfo = nil then
      Continue;
    if Integer(ROUND(Now - UpgradeInfo.dtTime)) >= g_Config.nClearExpireUpgradeWeaponDays then begin
      DisPose(UpgradeInfo);
      m_UpgradeWeaponList.Delete(i);
    end;
  end;
end;

procedure TMerchant.LoadNpcScript;
var
  SC: string;
begin
  //m_ItemTypeList.Clear;
  m_sPath := sMarket_Def;
  SC := m_sScript + '-' + m_sScriptFile;
  FrmDB.LoadScriptFile(Self, sMarket_Def, SC, True);
  //  call    sub_49ABE0
end;

procedure TMerchant.Click(PlayObject: TPlayObject); //0049FF24
begin
  //  GotoLable(PlayObject,'@main');
  inherited;
end;
{
procedure TMerchant.GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string);
begin
inherited GetVariableText;

end;  }
(*
function TMerchant.GetUserItemPrice(UserItem: pTUserItem): Integer;
{var
 n10: Integer;
 StdItem: pTStdItem; }
 //  n20: real;
 //  nC: Integer;
 //  n14: Integer;
begin
 {n10 := GetItemPrice(UserItem.wIndex);
 if n10 > 0 then begin
   StdItem := UserEngine.GetStdItem(UserItem.wIndex);
   n10 := GetUserItemPrice(UserItem, StdItem);
 end;
 Result := n10; }
 Result := GetSellItemPrice(UserItem, UserEngine.GetStdItem(UserItem.wIndex));
end;        *)

//新修改购买物品

procedure TMerchant.ClientBuyItem(PlayObject: TPlayObject; nInt, nCount: Integer; boBindGold: Boolean);
var
  UserItem, AddUserItem: pTUserItem;
  StdItem: pTStdItem;
  n1C, nPrice: Integer;
  nBack, I: Integer;
  Goods: pTGoods;
  boPileUp: Boolean;
  pGold: pInteger;
  nCheckCode: Integer;
label
  LbEnd;
begin
  nCheckCode := 1;
  try
    n1C := 1;
    UserItem := nil;
    if boBindGold then
      pGold := @PlayObject.m_nBindGold
    else
      pGold := @PlayObject.m_nGold;
    nCheckCode := 2;
    Goods := nil;
    if (nInt >= 0) and (nInt < m_NewGoodsList.Count) then begin
      nCheckCode := 3;
      Goods := m_NewGoodsList.Items[nInt];
      New(UserItem);
      UserItem^ := Goods.UserItem;
      if Goods.nStock > 0 then
      begin
        if boBindGold then begin
          SetByteStatus(UserItem.btBindMode1, Ib_NoSell, True);
          //SetByteStatus(UserItem.btBindMode1, Ib_DropDestroy, True);
        end;
        nCheckCode := 4;
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem <> nil then begin
          nCheckCode := 5;
          if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
            nCount := _MIN(nCount, Stditem.DuraMax);
            UserItem.Dura := nCount;
            UserItem.DuraMax := Stditem.DuraMax;
            nPrice := GetItemPrice(UserItem.wIndex) * nCount;
            boPileUp := True;
          end
          else begin
            if nCount > 10 then
              nCount := 10;
            if (PlayObject.m_ItemList.Count + nCount) > PlayObject.m_nMaxItemListCount then begin
              n1C := 2;
              goto LbEnd;
            end;
            boPileUp := False;
            nPrice := GetItemPrice(UserItem.wIndex) * nCount;
          end;
          nCheckCode := 6;
          if (pGold^ >= nPrice) and (nPrice > 0) then begin
            nCheckCode := 7;
            if boPileUp then begin //叠加购买
              nCheckCode := 8;
              nBack := PlayObject.AddItemToBag(UserItem, StdItem, True, m_sCharName, '购买', AddUserItem);
              if nBack <> -1 then begin
                nCheckCode := 9;
                n1C := 0;
                Dec(pGold^, nPrice);
                if m_boCastle or g_Config.boGetAllNpcTax then begin //城堡税收
                  if m_Castle <> nil then begin
                    TUserCastle(m_Castle).IncRateGold(nPrice);
                  end
                  else if g_Config.boGetAllNpcTax then begin
                    g_CastleManager.IncRateGold(nPrice);
                  end;
                end;
                if nBack = 2 then begin
                  UserItem.MakeIndex := GetItemNumber();
                  //商店购买物品重新取物品ID
                  PlayObject.SendAddItem(UserItem);
                  if Stditem.NeedIdentify = 1 then
                    AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName,
                      '0', BoolToStr(boBindGold), '购买', UserItem);
                  UserItem := nil;
                end
                else begin
                  DisPose(UserItem);
                  UserItem := nil;
                end;
              end
              else begin
                nCheckCode := 10;
                n1C := 2;
                DisPose(UserItem);
                UserItem := nil;
              end;
            end
            else begin
              nCheckCode := 11;
              n1C := 0;
              Dec(pGold^, nPrice);
              if m_boCastle or g_Config.boGetAllNpcTax then begin //城堡税收
                if m_Castle <> nil then begin
                  TUserCastle(m_Castle).IncRateGold(nPrice);
                end
                else if g_Config.boGetAllNpcTax then begin
                  g_CastleManager.IncRateGold(nPrice);
                end;
              end;
              nCheckCode := 12;
              for I := 1 to nCount do begin
                nCheckCode := 13;
                nBack := PlayObject.AddItemToBag(UserItem, StdItem, False, '', '', AddUserItem);
                if nBack <> -1 then begin
                  UserItem.MakeIndex := GetItemNumber();
                  //商店购买物品重新取物品ID
                  PlayObject.SendAddItem(UserItem);
                  if Stditem.NeedIdentify = 1 then
                    AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName,
                      '0', BoolToStr(boBindGold), '购买', UserItem);
                  UserItem := nil;
                end
                else begin
                  DisPose(UserItem);
                  UserItem := nil;
                end;
                nCheckCode := 14;
                if I <> nCount then begin
                  New(UserItem);
                  UserItem^ := Goods.UserItem;
                  if boBindGold then begin
                    SetByteStatus(UserItem.btBindMode1, Ib_NoSell, True);
                  end;
                end;
              end;
              if UserItem <> nil then begin
                Dispose(UserItem);
                UserItem := nil;
              end;
            end;
            nCheckCode := 15;
          end
          else
            n1C := 3 + Integer(boBindGold); //金币不足
        end;
      end
      else
        n1C := 5; //库存不足
    end;
    LbEnd:
    nCheckCode := 16;
    if n1C = 0 then begin
      nCheckCode := 17;
      PlayObject.SendDefMsg(Self, SM_BUYITEM_SUCCESS, PlayObject.m_nGold, nInt,
        LoWord(PlayObject.m_nBindGold), HiWord(PlayObject.m_nBindGold), '');
      nCheckCode := 19;
      if Assigned(Goods) and (Goods.nStock > 0) then
        Dec(Goods.nStock)
      else
        MainOutMessage('TMerchant.ClientBuyItem code = ' + IntToStr(nCheckCode));
    end
    else begin
      nCheckCode := 18;
      if UserItem <> nil then
        Dispose(UserItem);
      PlayObject.SendDefMsg(Self, SM_BUYITEM_FAIL, n1C, 0, 0, 0, '');
    end;
  except
    on E: Exception do begin
      MainOutMessage('TMerchant.ClientBuyItem code = ' + IntToStr(nCheckCode));
      MainOutMessage(E.Message);
    end;
  end;
end;
{
procedure TMerchant.ClientQuerySellPrice(PlayObject: TPlayObject; UserItem: pTUserItem);
var
 nC: Integer;
begin
 //nC := GetSellItemPrice(GetUserItemPrice(UserItem));
 nC := GetSellItemPrice(GetUserItemPrice(UserItem, UserEngine.GetStdItem(UserItem.wIndex)));
 if (nC >= 0) then begin
   PlayObject.SendDefMsg(Self, SM_SENDBUYPRICE, nC, 0, 0, 0, '');
 end
 else begin
   PlayObject.SendDefMsg(Self, SM_SENDBUYPRICE, 0, 0, 0, 0, '');
 end;
end;       }

procedure TMerchant.UpgradeWapon(User: TPlayObject);
  procedure sub_4A0218(ItemList: TList; var btDc: Byte; var btSc: Byte; var
    btMc: Byte; var btDura: Byte);
  var
    I, II: Integer;
    DuraList: TList;
    UserItem: pTUserItem;
    StdItem: TStdItem;
    pStdItem: PTStdItem;
    DelItemList: TStringList;
    nDc, nSc, nMc, nDcMin, nDcMax, nScMin, nScMax, nMcMin, nMcMax, nDura,
      nItemCount: Integer;
  begin
    nDcMin := 0;
    nDcMax := 0;
    nScMin := 0;
    nScMax := 0;
    nMcMin := 0;
    nMcMax := 0;
    nDura := 0;
    nItemCount := 0;
    DelItemList := nil;
    DuraList := TList.Create;
    for I := ItemList.Count - 1 downto 0 do begin
      UserItem := ItemList.Items[I];
      if UserEngine.GetStdItemName(UserItem.wIndex) = g_Config.sBlackStone then begin
        DuraList.Add(Pointer(ROUND(UserItem.Dura / 1.0E3)));
        if DelItemList = nil then
          DelItemList := TStringList.Create;
        DelItemList.AddObject(g_Config.sBlackStone, TObject(UserItem.MakeIndex));
        pStdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if (pStdItem <> nil) and (StdItem.NeedIdentify = 1) then
          AddGameLog(User, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName, '0', '材料', '武器升级', UserItem);

        DisPose(UserItem);
        ItemList.Delete(I);
      end
      else begin
        pStdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if (pStdItem <> nil) and (pStdItem.StdMode in [tm_Necklace, tm_Ring, tm_ArmRing]) then begin
          StdItem := pStdItem^;
          ItemUnit.GetItemAddValue(User.m_btWuXin, UserItem, StdItem);
          nDc := 0;
          nSc := 0;
          nMc := 0;
          case StdItem.StdMode of
            tm_Necklace: begin //004A0421
                nDc := HiWord(StdItem.nDC) + LoWord(StdItem.nDC);
                nSc := HiWord(StdItem.nSC) + LoWord(StdItem.nSC);
                nMc := HiWord(StdItem.nMC) + LoWord(StdItem.nMC);
              end;
            tm_Ring: begin //004A046E
                nDc := HiWord(StdItem.nDC) + LoWord(StdItem.nDC);
                nSc := HiWord(StdItem.nSC) + LoWord(StdItem.nSC);
                nMc := HiWord(StdItem.nMC) + LoWord(StdItem.nMC);
              end;
            tm_ArmRing: begin
                nDc := HiWord(StdItem.nDC) + LoWord(StdItem.nDC) + 1;
                nSc := HiWord(StdItem.nSC) + LoWord(StdItem.nSC) + 1;
                nMc := HiWord(StdItem.nMC) + LoWord(StdItem.nMC) + 1;
              end;
          end;
          if nDcMin < nDc then begin
            nDcMax := nDcMin;
            nDcMin := nDc;
          end
          else begin
            if nDcMax < nDc then
              nDcMax := nDc;
          end;
          if nScMin < nSc then begin
            nScMax := nScMin;
            nScMin := nSc;
          end
          else begin
            if nScMax < nSc then
              nScMax := nSc;
          end;
          if nMcMin < nMc then begin
            nMcMax := nMcMin;
            nMcMin := nMc;
          end
          else begin
            if nMcMax < nMc then
              nMcMax := nMc;
          end;
          if DelItemList = nil then
            DelItemList := TStringList.Create;
          DelItemList.AddObject(IntToStr(UserItem.wIndex), TObject(UserItem.MakeIndex));
          //004A06DB
          if StdItem.NeedIdentify = 1 then
            AddGameLog(User, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName, '0', '材料', '武器升级', UserItem);

          DisPose(UserItem);
          ItemList.Delete(I);
        end;
      end;
    end; // for
    for I := 0 to DuraList.Count - 1 do begin
      for II := DuraList.Count - 1 downto i + 1 do begin
        if Integer(DuraList.Items[II]) > Integer(DuraList.Items[II - 1]) then
          DuraList.Exchange(II, II - 1);
      end; // for
    end; // for
    for I := 0 to DuraList.Count - 1 do begin
      nDura := nDura + Integer(DuraList.Items[I]);
      Inc(nItemCount);
      if nItemCount >= 5 then
        break;
    end;
    btDura := ROUND(_MIN(5, nItemCount) + _MIN(5, nItemCount) * ((nDura / nItemCount) / 5.0));
    btDc := nDcMin div 5 + nDcMax div 3;
    btSc := nScMin div 5 + nScMax div 3;
    btMc := nMcMin div 5 + nMcMax div 3;
    if DelItemList <> nil then
      User.SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(DelItemList), 0, 0, '');

    if DuraList <> nil then
      DuraList.Free;

  end;
var
  I: Integer;
  bo0D: Boolean;
  UpgradeInfo: pTUpgradeInfo;
  StdItem: PTStdItem;
begin
  try
    bo0D := False;
    for I := 0 to m_UpgradeWeaponList.Count - 1 do begin
      UpgradeInfo := m_UpgradeWeaponList.Items[I];
      if UpgradeInfo.sUserName = User.m_sCharName then begin
        GotoLable(User, FGotoLable[NUPGRADENOW_ING], False);
        exit;
      end;
    end;
    if (User.m_UseItems[U_WEAPON].wIndex <> 0) and (User.m_nGold >= g_Config.nUpgradeWeaponPrice) and (User.CheckItems(g_Config.sBlackStone) <> nil) then begin
      StdItem := UserEngine.GetStdItem(User.m_UseItems[U_WEAPON].wIndex);
      if StdItem = nil then
        Exit;

      {if StdItem.nRule[RULE_NOLEVEL] then begin
        SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, '你身上的武器禁止在此处升级！！');
        exit;
      end;   }
      User.DecGold(g_Config.nUpgradeWeaponPrice);
      //    if m_boCastle or g_Config.boGetAllNpcTax then UserCastle.IncRateGold(g_Config.nUpgradeWeaponPrice);
      if m_boCastle or g_Config.boGetAllNpcTax then begin
        if m_Castle <> nil then begin
          TUserCastle(m_Castle).IncRateGold(g_Config.nUpgradeWeaponPrice);
        end
        else if g_Config.boGetAllNpcTax then begin
          g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
        end;
      end;
      User.GoldChanged();
      New(UpgradeInfo);
      UpgradeInfo.sUserName := User.m_sCharName;
      UpgradeInfo.UserItem := User.m_UseItems[U_WEAPON];

      //004A0B2F
      if StdItem.NeedIdentify = 1 then
        AddGameLog(User, LOG_DELITEM, StdItem.Name, User.m_UseItems[U_WEAPON].MakeIndex, User.m_UseItems[U_WEAPON].Dura, m_sCharName, '0', '放入', '武器升级',
          @User.m_UseItems[U_WEAPON]);

      User.SendDelItems(@User.m_UseItems[U_WEAPON]);
      User.m_UseItems[U_WEAPON].wIndex := 0;
      User.RecalcAbilitys();
      User.FeatureChanged();
      User.SendAbility;
      User.SendSubAbility;
      sub_4A0218(User.m_ItemList, UpgradeInfo.btDc, UpgradeInfo.btSc, UpgradeInfo.btMc, UpgradeInfo.btDura);
      UpgradeInfo.dtTime := Now();
      UpgradeInfo.dwGetBackTick := GetTickCount();
      m_UpgradeWeaponList.Add(UpgradeInfo);
      SaveUpgradingList();
      bo0D := True;
    end;
    if bo0D then
      GotoLable(User, FGotoLable[NUPGRADENOW_OK], False)
    else
      GotoLable(User, FGotoLable[NUPGRADENOW_FAIL], False);
  except
    MainOutMessage('[Exception] TMerchant.UpgradeWapon');
  end;
end;

procedure TMerchant.GetBackupgWeapon(User: TPlayObject);
var
  I: Integer;
  UpgradeInfo: pTUpgradeInfo;
  n10, {n14,} n18, n1C, n90: Integer;
  UserItem: pTUserItem;
  StdItem: PTStdItem;
begin
  try
    n18 := 0;
    UpgradeInfo := nil;
    if not User.IsEnoughBag then begin
      GotoLable(User, FGotoLable[NGETBACKUPGNOW_BAGFULL], False);
      exit;
    end;
    for I := 0 to m_UpgradeWeaponList.Count - 1 do begin
      if pTUpgradeInfo(m_UpgradeWeaponList.Items[I]).sUserName = User.m_sCharName then begin
        n18 := 1;
        if ((GetTickCount - pTUpgradeInfo(m_UpgradeWeaponList.Items[I]).dwGetBackTick) > g_Config.dwUPgradeWeaponGetBackTime) or (User.m_btPermission >= 4) then begin
          UpgradeInfo := m_UpgradeWeaponList.Items[I];
          m_UpgradeWeaponList.Delete(I);
          SaveUpgradingList();
          n18 := 2;
          break;
        end;
      end;
    end;
    //004A0DC2
    if UpgradeInfo <> nil then begin
      case UpgradeInfo.btDura of //
        0..8: begin
            if UpgradeInfo.UserItem.DuraMax > 3000 then begin
              Dec(UpgradeInfo.UserItem.DuraMax, 3000);
            end
            else begin
              UpgradeInfo.UserItem.DuraMax := UpgradeInfo.UserItem.DuraMax shr 1;
            end;
            if UpgradeInfo.UserItem.Dura > UpgradeInfo.UserItem.DuraMax then
              UpgradeInfo.UserItem.Dura := UpgradeInfo.UserItem.DuraMax;
          end;
        9..15: begin //004A0E41
            if Random(UpgradeInfo.btDura) < 6 then begin
              if UpgradeInfo.UserItem.DuraMax > 1000 then
                Dec(UpgradeInfo.UserItem.DuraMax, 1000);
              if UpgradeInfo.UserItem.Dura > UpgradeInfo.UserItem.DuraMax then
                UpgradeInfo.UserItem.Dura := UpgradeInfo.UserItem.DuraMax;
            end;

          end;
        18..255: begin
            case Random(UpgradeInfo.btDura - 18) of
              1..4: Inc(UpgradeInfo.UserItem.DuraMax, 1000);
              5..7: Inc(UpgradeInfo.UserItem.DuraMax, 2000);
              8..255: Inc(UpgradeInfo.UserItem.DuraMax, 4000)
            end;
          end;
      end; // case
      if (UpgradeInfo.btDc = UpgradeInfo.btMc) and (UpgradeInfo.btMc = UpgradeInfo.btSc) then begin
        n1C := Random(3);
      end
      else begin
        n1C := -1;
      end;
      if ((UpgradeInfo.btDc >= UpgradeInfo.btMc) and (UpgradeInfo.btDc >= UpgradeInfo.btSc)) or (n1C = 0) then begin
        n90 := _MIN(11, UpgradeInfo.btDc);
        n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.Value.btValue[tb_AC2] - UpgradeInfo.UserItem.Value.btValue[tb_MAC2] + User.m_nBodyLuckLevel);
        //      n10:=_MIN(85,n90 * 8 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

        if Random(g_Config.nUpgradeWeaponDCRate) < n10 then begin //if Random(100) < n10 then begin
          UpgradeInfo.UserItem.EffectValue.btUpgrade := 10;

          if (n10 > 63) and (Random(g_Config.nUpgradeWeaponDCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
            UpgradeInfo.UserItem.EffectValue.btUpgrade := 11;

          if (n10 > 79) and (Random(g_Config.nUpgradeWeaponDCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
            UpgradeInfo.UserItem.EffectValue.btUpgrade := 12;
        end
        else
          UpgradeInfo.UserItem.EffectValue.btUpgrade := 1; //004A0F89
      end;

      if ((UpgradeInfo.btMc >= UpgradeInfo.btDc) and (UpgradeInfo.btMc >= UpgradeInfo.btSc)) or (n1C = 1) then begin
        n90 := _MIN(11, UpgradeInfo.btMc);
        n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.Value.btValue[tb_AC2] - UpgradeInfo.UserItem.Value.btValue[tb_MAC2] + User.m_nBodyLuckLevel);

        if Random(g_Config.nUpgradeWeaponMCRate) < n10 then begin //if Random(100) < n10 then begin
          UpgradeInfo.UserItem.EffectValue.btUpgrade := 20;

          if (n10 > 63) and (Random(g_Config.nUpgradeWeaponMCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
            UpgradeInfo.UserItem.EffectValue.btUpgrade := 21;

          if (n10 > 79) and (Random(g_Config.nUpgradeWeaponMCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
            UpgradeInfo.UserItem.EffectValue.btUpgrade := 22;
        end
        else
          UpgradeInfo.UserItem.EffectValue.btUpgrade := 1;
      end;

      if ((UpgradeInfo.btSc >= UpgradeInfo.btMc) and (UpgradeInfo.btSc >= UpgradeInfo.btDc)) or (n1C = 2) then begin
        n90 := _MIN(11, UpgradeInfo.btMc);
        n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.Value.btValue[tb_AC2] - UpgradeInfo.UserItem.Value.btValue[tb_MAC2] + User.m_nBodyLuckLevel);

        if Random(g_Config.nUpgradeWeaponSCRate) < n10 then begin //if Random(100) < n10 then begin
          UpgradeInfo.UserItem.EffectValue.btUpgrade := 30;

          if (n10 > 63) and (Random(g_Config.nUpgradeWeaponSCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
            UpgradeInfo.UserItem.EffectValue.btUpgrade := 31;

          if (n10 > 79) and (Random(g_Config.nUpgradeWeaponSCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
            UpgradeInfo.UserItem.EffectValue.btUpgrade := 32;
        end
        else
          UpgradeInfo.UserItem.EffectValue.btUpgrade := 1;
      end;
      New(UserItem);
      UserItem^ := UpgradeInfo.UserItem;
      DisPose(UpgradeInfo);
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      //004A120E
      if StdItem.NeedIdentify = 1 then
        AddGameLog(User, LOG_ADDITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName, '0', '取回', '武器升级', UserItem);

      User.m_ItemList.Add(UserItem);
      User.SendAddItem(UserItem);
    end;
    case n18 of //
      0: GotoLable(User, FGotoLable[NGETBACKUPGNOW_FAIL], False);
      1: GotoLable(User, FGotoLable[NGETBACKUPGNOW_ING], False);
      2: GotoLable(User, FGotoLable[NGETBACKUPGNOW_OK], False);
    end; // case

  except
    MainOutMessage('[Exception] TMerchant.GetBackupgWeapon');
  end;
end;

function TMerchant.GetSellItemPrice(nPrice: Integer): Integer;
begin
  Result := nPrice div 2;
end;

function TMerchant.ClientSellItem(PlayObject: TPlayObject; UserItem: pTUserItem): Boolean;
var
  nPrice: Integer;
  StdItem: pTStdItem;
begin
  Result := False;
  nPrice := GetSellItemPrice(GetUserItemPrice(UserItem, UserEngine.GetStdItem(UserItem.wIndex)));
  if (nPrice > 0) then begin
    Stditem := Userengine.GetStdItem(UserItem.wIndex);
    if (Stditem <> nil) and (not (CheckItemBindMode(UserItem, bm_NoSell))) then begin
      //绑定金币购买的, 卖给商店同样给绑定金币,防止刷钱
      {if CheckByteStatus(UserItem.btBindMode2, Ib2_BindGold) then begin
        IntegerChange(PlayObject.m_nBindGold, nPrice, INT_ADD);
        PlayObject.SendDefMsg(Self, SM_USERSELLITEM_OK, PlayObject.m_nGold, 0, LoWord(PlayObject.m_nBindGold),
          HiWord(PlayObject.m_nBindGold), '');
        if (Stditem.NeedIdentify = 1) then
          AddGameLog(PlayObject, LOG_DELITEM, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName, '0', '0', '出售');
        PlayObject.m_ReturnItemsList.Insert(0,UserItem);
        if PlayObject.m_ReturnItemsList.Count > MAXRETURNITEMSCOUNT then begin
          Dispose(pTUserItem(PlayObject.m_ReturnItemsList[MAXRETURNITEMSCOUNT]));
          PlayObject.m_ReturnItemsList.Delete(MAXRETURNITEMSCOUNT);
        end;
        Result := True;
      end else    }
      if PlayObject.IncGold(nPrice) then begin
        PlayObject.SendDefMsg(Self, SM_USERSELLITEM_OK, PlayObject.m_nGold, 0, LoWord(PlayObject.m_nBindGold),
          HiWord(PlayObject.m_nBindGold), '');
        if (Stditem.NeedIdentify = 1) then
          AddGameLog(PlayObject, LOG_DELITEM, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName,
            '0', '0', '出售', UserItem);
        PlayObject.m_ReturnItemsList.Insert(0, UserItem);
        if PlayObject.m_ReturnItemsList.Count > MAXRETURNITEMSCOUNT then begin
          Dispose(pTUserItem(PlayObject.m_ReturnItemsList[MAXRETURNITEMSCOUNT]));
          PlayObject.m_ReturnItemsList.Delete(MAXRETURNITEMSCOUNT);
        end;
        Result := True;
      end
      else
        PlayObject.SendDefMsg(Self, SM_USERSELLITEM_FAIL, 1, 0, 0, 0, '');
    end
    else begin
      PlayObject.SendDefMsg(Self, SM_USERSELLITEM_FAIL, 0, 0, 0, 0, '');
    end;
  end
  else begin
    PlayObject.SendDefMsg(Self, SM_USERSELLITEM_FAIL, 0, 0, 0, 0, '');
  end;
end;

procedure TMerchant.ClientUnsealItem(PlayObject: TPlayObject; nItemIndex: Integer; sMsg: string);
var
  ItemList: TList;
  nBack: Byte;
  sItemIndex: string;
  nIndex: Integer;
  UserItem, UnUserItem: pTUserItem;
  StdItem: pTStdItem;
  UserItemLevelArr: array[0..7] of pTUserItem;
  StdItemLevelArr: array[0..7] of pTStdItem;
  I, II: Integer;
  nPos: Byte;
  UnsealItem: TUnsealItem;
  sSendMsg: string;
begin
  nBack := 0;
  sSendMsg := '';
  try
    ItemList := TList.Create;
    try
      while sMsg <> '' do begin
        sMsg := GetValidStr3(sMsg, sItemIndex, ['/']);
        if sItemIndex = '' then
          break;
        nIndex := StrToIntDef(sItemIndex, 0);
        if nIndex > 0 then begin
          ItemList.Add(Pointer(nIndex));
          if ItemList.Count > High(UserItemLevelArr) then
            break;
        end
        else
          break;
      end;
      SafeFillChar(UserItemLevelArr, SizeOf(UserItemLevelArr), #0);
      SafeFillChar(StdItemLevelArr, SizeOf(StdItemLevelArr), #0);
      UnUserItem := nil;
      //      UnStdItem := nil;
      nPos := 0;
      //获取背包是否有指定的物品
      nBack := 2; //要升级的物品不正常
      for i := PlayObject.m_ItemList.Count - 1 downto 0 do begin
        UserItem := PlayObject.m_ItemList[i];
        if UserItem <> nil then begin
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem = nil then
            Continue;
          if UserItem.MakeIndex = nItemIndex then begin
            if ((sm_ArmingStrong in StdItem.StdModeEx) or (sm_HorseArm in StdItem.StdModeEx)) and CheckItemBindMode(UserItem, bm_Unknown) then begin
              UnUserItem := UserItem;
              //              UnStdItem := StdItem;
              if ItemList.Count <= 0 then
                break;
            end
            else
              break;
          end
          else begin
            for II := ItemList.Count - 1 downto 0 do begin
              if UserItem.MakeIndex = Integer(ItemList[II]) then begin
                if (sm_ArmingStrong in StdItem.StdModeEx) or ((tm_MakeStone = StdItem.StdMode) and (StdItem.Shape = 2)) then begin
                  if nPos <= High(UserItemLevelArr) then begin
                    UserItemLevelArr[nPos] := UserItem;
                    StdItemLevelArr[nPos] := StdItem;
                    PlayObject.m_ItemList.Delete(I);
                    Inc(nPos);
                  end;
                end;
                ItemList.Delete(II);
                break;
              end;
            end;
            if (ItemList.Count <= 0) and (UnUserItem <> nil) then
              break;
          end;
        end;
      end; // end for
      if UnUserItem <> nil then begin
        if (PlayObject.GetMissionFlagStatus(MISSIONVAR_UNSEAL) = 0) then
          PlayObject.SetMissionFlagStatus(MISSIONVAR_UNSEAL, 1);
        nBack := 8; //升级成功
        SafeFillChar(UnsealItem, SizeOf(UnsealItem), #0);
        for I := Low(UserItemLevelArr) to High(UserItemLevelArr) do begin
          if UserItemLevelArr[i] <> nil then begin
            if sm_ArmingStrong in StdItemLevelArr[i].StdModeEx then begin
              Inc(UnsealItem.nAC, StdItemLevelArr[i].nAC2);
              Inc(UnsealItem.nMAC, StdItemLevelArr[i].nMAC2);
              Inc(UnsealItem.nDC, StdItemLevelArr[i].nDC2);
              Inc(UnsealItem.nMC, StdItemLevelArr[i].nMC2);
              Inc(UnsealItem.nSC, StdItemLevelArr[i].nSC2);
            end
            else
              Inc(UnsealItem.nRate, StdItemLevelArr[i].Reserved);

            if StdItemLevelArr[i].NeedIdentify = 1 then
              AddGameLog(PlayObject, LOG_DELITEM, StdItemLevelArr[I].Name, UserItemLevelArr[I].MakeIndex,
                UserItemLevelArr[I].Dura, m_sCharName, '0', '0', '开光', UserItemLevelArr[I]);
            Dispose(UserItemLevelArr[i]);
          end;
          UserItemLevelArr[i] := nil;
          StdItemLevelArr[i] := nil;
        end;
        ItemUnit.RandomUpgradeItem(UnUserItem, UnsealItem);
        sSendMsg := PlayObject.MakeClientItem(UnUserItem);
      end;
      if sSendMsg <> '' then begin
        m_DefMsg := MakeDefaultMsg(SM_UNSEAL_OK, 0, 0, 0, nBack);
        PlayObject.SendSocket(@m_DefMsg, sSENDMSG);
      end
      else
        PlayObject.SendDefMessage(SM_UNSEAL_OK, 0, 0, 0, nBack, '');
    finally
      ItemList.Free;
      for I := Low(UserItemLevelArr) to High(UserItemLevelArr) do begin
        if UserItemLevelArr[i] <> nil then
          PlayObject.m_ItemList.Add(UserItemLevelArr[i]);
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage('[Exception] TMerchant.ClientUnsealItem ' + PlayObject.m_sCharName + ' ' + IntToStr(nBack));
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TMerchant.ClientMakeDrugItem(PlayObject: TPlayObject; nID, nAuto: Integer; sMsg: string);
begin
  if (nID >= 0) and (nID < m_MakeItemsList.Count) and (sMsg <> '') then begin
    PlayObject.MakeItem(m_MakeItemsList[nID], sMsg, Self, 0, nAuto);
  end;
end;
(*
procedure TMerchant.ClientMakeDrugItem(PlayObject: TPlayObject; nID: Integer; sMsg: string);
  procedure ChangeUserItemDura(var UserItem: pTUserItem; StdItem: pTStdItem; nCount: Word);
  begin
    if UserItem = nil then exit;
    if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
      if UserItem.Dura > nCount then begin
        Dec(UserItem.Dura, nCount);
        if (StdItem.NeedIdentify = 1) then
          AddGameLog(PlayObject, LOG_ITEMDURACHANGE, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName,
            '-', IntToStr(nCount), '打造');

        PlayObject.m_ItemList.Add(UserItem);
        UserItem := nil;
      end else begin
        if (StdItem.NeedIdentify = 1) then
          AddGameLog(PlayObject, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, 0, m_sCharName,
            '0', '0', '打造');
        Dispose(UserItem);
        UserItem := nil;

      end;
    end else begin
      if (StdItem.NeedIdentify = 1) then
        AddGameLog(PlayObject, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, 0, m_sCharName,
            '0', '0', '打造');
      Dispose(UserItem);
      UserItem := nil;
    end;
  end;
var
  nBack: Integer;
  sSendMsg: string;
  ItemL: TMessageItemWL;
  MakeGoods: pTMakeGoods;
  StdItem, StdItem1, StdItem2, StdItem3, StdItem4, StdItem5: pTStditem;
  UserItem, UserItem1, UserItem2, UserItem3, UserItem4, UserItem5: pTUserItem;
  pGold: pInteger;
  i: integer;
  boBindGold: Boolean;
begin
  nBack := 0; //金币不够
  sSendMsg := '';
  Try
    if (nID >= 0) and (nID < m_MakeItemsList.Count) and (sMsg <> '') then begin
      UserItem1 := nil;
      UserItem2 := nil;
      UserItem3 := nil;
      UserItem4 := nil;
      UserItem5 := nil;
      StdItem1 := nil;
      StdItem2 := nil;
      StdItem3 := nil;
      StdItem4 := nil;
      StdItem5 := nil;
      pGold := nil;
      MakeGoods := m_MakeItemsList[nID];
      SafeFillChar(ItemL, SizeOf(ItemL), #0);
      DecodeBuffer(sMsg, @ItemL, SizeOf(ItemL));
      boBindGold := False;
      if PlayObject.m_nBindGold >= MakeGoods.MakeItem.nMoney then begin
        pGold := @PlayObject.m_nBindGold;
        boBindGold := True;
      end else if PlayObject.m_nGold >= MakeGoods.MakeItem.nMoney then
        pGold := @PlayObject.m_nGold;
      if pGold <> nil then begin
        //获取背包是否有指定的物品
        Try
          for i := PlayObject.m_ItemList.Count - 1 downto 0 do begin
            UserItem := PlayObject.m_ItemList[i];
            if UserItem <> nil then begin
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if StdItem = nil then Continue;
              if (UserItem.MakeIndex = ItemL.lParam1) and (MakeGoods.MakeItem.StuffArr[1].wIdent = UserItem.wIndex)
              then begin
                if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
                  if UserItem.Dura < MakeGoods.MakeItem.StuffArr[1].wCount then
                    Continue;
                end;
                StdItem1 := StdItem;
                UserItem1 := UserItem;
                PlayObject.m_ItemList.Delete(i);
              end else
              if (UserItem.MakeIndex = ItemL.lParam2) and (MakeGoods.MakeItem.StuffArr[2].wIdent = UserItem.wIndex)
              then begin
                if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
                  if UserItem.Dura < MakeGoods.MakeItem.StuffArr[2].wCount then
                    Continue;
                end;
                UserItem2 := UserItem;
                StdItem2 := StdItem;
                PlayObject.m_ItemList.Delete(i);
              end else
              if (UserItem.MakeIndex = ItemL.lParam3) and (MakeGoods.MakeItem.StuffArr[3].wIdent = UserItem.wIndex)
              then begin
                if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
                  if UserItem.Dura < MakeGoods.MakeItem.StuffArr[3].wCount then
                    Continue;
                end;
                UserItem3 := UserItem;
                StdItem3 := StdItem;
                PlayObject.m_ItemList.Delete(i);
              end else
              if (UserItem.MakeIndex = ItemL.lParam4) and (MakeGoods.MakeItem.StuffArr[4].wIdent = UserItem.wIndex)
              then begin
                if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
                  if UserItem.Dura < MakeGoods.MakeItem.StuffArr[4].wCount then
                    Continue;
                end;
                UserItem4 := UserItem;
                StdItem4 := StdItem;
                PlayObject.m_ItemList.Delete(i);
              end else
              if (UserItem.MakeIndex = ItemL.lParam5) and (MakeGoods.MakeItem.StuffArr[5].wIdent = UserItem.wIndex)
              then begin
                if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
                  if UserItem.Dura < MakeGoods.MakeItem.StuffArr[5].wCount then
                    Continue;
                end;
                UserItem5 := UserItem;
                StdItem5 := StdItem;
                PlayObject.m_ItemList.Delete(i);
              end;
            end;
          end;
          nBack := 1; //材料不足
          if ((MakeGoods.MakeItem.StuffArr[1].wIdent = 0) or (UserItem1 <> nil)) and
             ((MakeGoods.MakeItem.StuffArr[2].wIdent = 0) or (UserItem2 <> nil)) and
             ((MakeGoods.MakeItem.StuffArr[3].wIdent = 0) or (UserItem3 <> nil)) and
             ((MakeGoods.MakeItem.StuffArr[4].wIdent = 0) or (UserItem4 <> nil)) and
             ((MakeGoods.MakeItem.StuffArr[5].wIdent = 0) or (UserItem5 <> nil))
          then begin
            ChangeUserItemDura(UserItem1, StdItem1, MakeGoods.MakeItem.StuffArr[1].wCount);
            ChangeUserItemDura(UserItem2, StdItem2, MakeGoods.MakeItem.StuffArr[2].wCount);
            ChangeUserItemDura(UserItem3, StdItem3, MakeGoods.MakeItem.StuffArr[3].wCount);
            ChangeUserItemDura(UserItem4, StdItem4, MakeGoods.MakeItem.StuffArr[4].wCount);
            ChangeUserItemDura(UserItem5, StdItem5, MakeGoods.MakeItem.StuffArr[5].wCount);
            Dec(pGold^, MakeGoods.MakeItem.nMoney);
            if boBindGold then begin
              if g_boGameLogBindGold then
                AddGameLog(PlayObject, LOG_BINDGOLDCHANGED, sSTRING_BINDGOLDNAME, 0, PlayObject.m_nBindGold, m_sCharName,
                  '-', IntToStr(MakeGoods.MakeItem.nMoney), '打造');
            end else begin
              if g_boGameLogGold then
                AddGameLog(PlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayObject.m_nGold, m_sCharName,
                  '-', IntToStr(MakeGoods.MakeItem.nMoney), '打造');
            end;
            if Random(100) < MakeGoods.MakeItem.btRate then begin
              nBack := 4;   //系统错误
              New(UserItem);
              if UserEngine.CopyToUserItemFromIdx(MakeGoods.MakeItem.StuffArr[0].wIdent, UserItem) then begin
                StdItem1 := UserEngine.GetStdItem(UserItem.wIndex);
                if StdItem1.NeedIdentify = 1 then
                  AddGameLog(PlayObject, LOG_ADDITEM, StdItem1.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName,
                    '0', '0', '打造');
                PlayObject.m_ItemList.Add(UserItem);
                sSendMsg := PlayObject.MakeClientItem(UserItem);
                nBack := 2;
              end else
                Dispose(UserItem);
            end else
              nBack := 3;  //打造失败
          end;
        Finally
          if UserItem1 <> nil then PlayObject.m_ItemList.Add(UserItem1);
          if UserItem2 <> nil then PlayObject.m_ItemList.Add(UserItem2);
          if UserItem3 <> nil then PlayObject.m_ItemList.Add(UserItem3);
          if UserItem4 <> nil then PlayObject.m_ItemList.Add(UserItem4);
          if UserItem5 <> nil then PlayObject.m_ItemList.Add(UserItem5);
        End;
      end;
    end;
    PlayObject.SendDefSocket(Self, SM_MAKEDRUG, PlayObject.m_nGold,
      LoWord(PlayObject.m_nGold), HiWord(PlayObject.m_nGold), nBack, sSendMsg);
  Except
    on E:Exception do begin
      MainOutMessage('[Exception] TMerchant.ClientMakeDrugItem ' + PlayObject.m_sCharName + ' ' + IntToStr(nBack));
      MainOutMessage(E.Message);
    end;
  End;
end; *)
(*
procedure TMerchant.ClientQueryRepairCost(PlayObject: TPlayObject; UserItem: pTUserItem);
var
  nPrice, nRepairPrice: Integer;
  StdItem: pTStdItem;
begin
  nPrice := GetUserItemPrice(UserItem, UserEngine.GetStdItem(UserItem.wIndex));
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (nPrice > 0) and (UserItem.DuraMax > UserItem.Dura) and (StdItem <> nil) and (StdItem.StdModeEx = sm_Arming)
  then begin
    if UserItem.DuraMax > 0 then begin
      nRepairPrice := ROUND(nPrice div 3 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
    end
    else begin
      nRepairPrice := nPrice;
    end;
    if (PlayObject.m_sScriptLable = sSUPERREPAIR) then begin
      if m_boS_repair then
        nRepairPrice := nRepairPrice * g_Config.nSuperRepairPriceRate {3}
      else
        nRepairPrice := -1;
    end
    else begin
      if not m_boRepair then
        nRepairPrice := -1;
    end;
    PlayObject.SendDefMsg(Self, SM_SENDREPAIRCOST, nRepairPrice, 0, 0, 0, '');
  end
  else begin
    PlayObject.SendDefMsg(Self, SM_SENDREPAIRCOST, -1, 0, 0, 0, '');
  end;
end;
            *)

function TMerchant.ClientRepairItem(PlayObject: TPlayObject; UserItem: pTUserItem; boSuperRepair: Boolean): Boolean;
var
  StdItem: pTStdItem;
  nPrice: Integer;
begin
  Result := False;
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem = nil then
    exit;

  nPrice := GetRepairItemPrice(UserItem, StdItem);
  if boSuperRepair then begin
    nPrice := nPrice * g_Config.nSuperRepairPriceRate {3};
  end;
  if (nPrice > 0) and (UserItem.DuraMax > UserItem.Dura) and ((sm_Arming in StdItem.StdModeEx) or (sm_HorseArm in StdItem.StdModeEx)) then begin
    if PlayObject.DecGold(nPrice) then begin
      if m_boCastle or g_Config.boGetAllNpcTax then begin
        if m_Castle <> nil then begin
          TUserCastle(m_Castle).IncRateGold(nPrice);
        end
        else if g_Config.boGetAllNpcTax then begin
          g_CastleManager.IncRateGold(nPrice);
        end;
      end;
      if boSuperRepair then begin
        UserItem.Dura := UserItem.DuraMax;
        PlayObject.SendDefMsg(Self, SM_USERREPAIRITEM_OK, PlayObject.m_nGold, LoWord(PlayObject.m_nBindGold),
          HiWord(PlayObject.m_nBindGold), UserItem.DuraMax, '');
      end
      else begin
        Dec(UserItem.DuraMax, (UserItem.DuraMax - UserItem.Dura) div g_Config.nRepairItemDecDura);
        UserItem.Dura := UserItem.DuraMax;
        PlayObject.SendDefMsg(Self, SM_USERREPAIRITEM_OK, PlayObject.m_nGold, LoWord(PlayObject.m_nBindGold),
          HiWord(PlayObject.m_nBindGold), UserItem.DuraMax, '');
      end;
      Result := True;
    end
    else
      PlayObject.SendDefMsg(Self, SM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
  end
  else
    PlayObject.SendDefMsg(Self, SM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
end;

procedure TMerchant.ClearScript;
begin
  m_boBuy := False;
  m_boSell := False;
  m_boMakeDrug := False;
  m_boPrices := False;
  m_boStorage := False;
  //m_boGetback := False;
  m_boArmStrengthen := False;
  m_boArmUnseal := False;
  m_boArmRemoveStone := False;
  m_boArmAbilityMove := False;
  //m_boUpgradenow := False;
  //m_boGetBackupgnow := False;
  m_boRepair := False;
  m_boS_repair := False;
  m_boGetMarry := False;
  m_boGetMaster := False;
  m_boUseItemName := False;

  m_boGetSellGold := False;
  m_boSellOff := False;
  m_boBuyOff := False;
  m_boDealGold := False;
  inherited;
end;

procedure TMerchant.LoadUpgradeList;
var
  i: Integer;
begin
  for i := 0 to m_UpgradeWeaponList.Count - 1 do begin
    DisPose(pTUpgradeInfo(m_UpgradeWeaponList.Items[i]));
  end; // for
  m_UpgradeWeaponList.Clear;
  try
    //FrmDB.LoadUpgradeWeaponRecord(m_sCharName,m_UpgradeWeaponList);
    FrmDB.LoadUpgradeWeaponRecord(m_sScript + '-' + m_sScriptFile, m_UpgradeWeaponList);
  except
    MainOutMessage('Failure in loading upgradinglist - ' + m_sCharName);
  end;
end;

{procedure TMerchant.GetMarry(PlayObject: TPlayObject; sDearName: string);
var
  MarryHuman: TPlayObject;
begin
  MarryHuman := UserEngine.GetPlayObject(sDearName);
  if (MarryHuman <> nil) and
    (MarryHuman.m_PEnvir = PlayObject.m_PEnvir) and
    (abs(PlayObject.m_nCurrX - MarryHuman.m_nCurrX) < 5) and
    (abs(PlayObject.m_nCurrY - MarryHuman.m_nCurrY) < 5) then begin
    SendMsgToUser(MarryHuman, PlayObject.m_sCharName + ' 向你求婚，你是否愿意嫁给他为妻？');
  end else begin
    Self.SendMsgToUser(PlayObject, sDearName + ' 没有在你身边，你的请求无效.');
  end;
end;  }

{procedure TMerchant.GetMaster(PlayObject: TPlayObject; sMasterName: string);
begin

end;  }
{
procedure TMerchant.SendCustemMsg(PlayObject: TPlayObject; sMsg: string);
begin
  inherited;

end;         }
//清除临时文件，包括交易库存，价格表

procedure TMerchant.ClearData;
var
  i: Integer;
  //  UserItem: pTUserItem;
  //  ItemList: TList;
    //ItemPrice: pTItemPrice;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::ClearData';
begin
  try

    for i := 0 to m_NewGoodsList.Count - 1 do begin
      Dispose(pTGoods(m_NewGoodsList.Items[i]));
    end;
    m_NewGoodsList.Clear;

    for i := 0 to m_MakeItemsList.Count - 1 do begin
      Dispose(pTMakeGoods(m_MakeItemsList.Items[i]));
    end;
    m_MakeItemsList.Clear;
    m_MakeItemsCode := '';
    m_MakeNamesCode := '';
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;
(*
procedure TMerchant.ChangeUseItemName(PlayObject: TPlayObject;
  sLabel, sItemName: string);
var
  sWhere: string;
  btWhere: Byte;
  UserItem: pTUserItem;
//  nLabelLen: Integer;
  sMsg: string;
//  sItemNewName: string;
///  StdItem: pTStdItem;
begin
  if not PlayObject.m_boChangeItemNameFlag then begin
    Exit;
  end;
  PlayObject.m_boChangeItemNameFlag := False;
  sWhere := Copy(sLabel, Length(sUSEITEMNAME) + 1, Length(sLabel) - Length(sUSEITEMNAME));
  btWhere := StrToIntDef(sWhere, -1);
  if btWhere in [Low(THumanUseItems)..High(THumanUseItems)] then begin
    UserItem := @PlayObject.m_UseItems[btWhere];
    if UserItem.wIndex = 0 then begin
      sMsg := format(g_sYourUseItemIsNul, [GetUseItemName(btWhere)]);
      PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
      Exit;
    end;
    if UserItem.Value.btValue[13] = 1 then begin
      ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
    end;
    if sItemName <> '' then begin
      if g_Config.boChangeUseItemNameByPlayName then begin
        ItemUnit.AddCustomItemName(UserItem.MakeIndex, UserItem.wIndex, PlayObject.m_sCharName + '的' + sItemName);
        UserItem.Value.btValue[13] := 1;
      end else begin
        ItemUnit.AddCustomItemName(UserItem.MakeIndex, UserItem.wIndex, g_Config.sChangeUseItemName + sItemName);
        UserItem.Value.btValue[13] := 1;
      end;
    end else begin
      ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      UserItem.Value.btValue[13] := 0;
    end;
    ItemUnit.SaveCustomItemName();
    PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, '');
  end;
end;     *)

{ TTrainer }

constructor TTrainer.Create;
begin
  inherited;
  m_dw568 := GetTickCount();
  n56C := 0;
  n570 := 0;
  //m_btWuXin := 4;
end;

destructor TTrainer.Destroy;
begin

  inherited;
end;

function TTrainer.Operate(ProcessMsg: pTProcessMessage): Boolean; //004A38C4
var
  nDamage: Integer;
begin
  Result := False;
  case ProcessMsg.wIdent of
    RM_MAGSTRUCK: begin
        nDamage := GetMagStruckDamage(nil, ProcessMsg.nParam1);
        Inc(n56C, nDamage);
        m_dw568 := GetTickCount();
        Inc(n570);
        ProcessMonSayMsg('破坏力为 ' + IntToStr(nDamage) + ',平均值为 ' + IntToStr(n56C div n570));
      end;
    RM_STRUCK: begin
        Inc(n56C, ProcessMsg.wParam);
        m_dw568 := GetTickCount();
        Inc(n570);
        ProcessMonSayMsg('破坏力为 ' + IntToStr(ProcessMsg.wParam) + ',平均值为 ' + IntToStr(n56C div n570));
      end;
  end;
end;

procedure TTrainer.Run;
begin
  m_WAbil.HP := m_WAbil.MaxHP;
  if m_Master <> nil then
    m_Master := nil;
  if n570 > 0 then begin
    if (GetTickCount - m_dw568) > 3 * 1000 then begin
      ProcessMonSayMsg('总破坏力为  ' + IntToStr(n56C) + ',平均值为 ' + IntToStr(n56C div n570));
      n570 := 0;
      n56C := 0;
    end;
  end;
  inherited;
end;
{ TNormNpc }

procedure TNormNpc.ActionOfAddAccountList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  AddList(PlayObject.m_sUserID, m_sPath + QuestActionInfo.sParam1)
end;

procedure TNormNpc.ActionOfAddBatch(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  FList1C.AddObject(QuestActionInfo.sParam1, TObject(Fn18));
end;

procedure TNormNpc.ActionOfAddGuildList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  if PlayObject.m_MyGuild <> nil then
    AddList(TGuild(PlayObject.m_MyGuild).m_sGuildName, m_sPath + QuestActionInfo.sParam1);
end;

procedure TNormNpc.ActionOfAddGuildMember(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  Guild: TGuild;
  AddPlay: TPlayObject;
begin
  Guild := g_GuildManager.FindGuild(QuestActionInfo.sParam1);
  AddPlay := UserEngine.GetPlayObject(QuestActionInfo.sParam2);
  if (Guild = nil) or (AddPlay = nil) or (AddPlay.m_boGhost) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDGUILDMEMBER);
    Exit;
  end;
  if (AddPlay.m_MyGuild = nil) and (not Guild.IsFull) then begin
    Guild.AddMember(AddPlay);
    AddPlay.m_MyGuild := Guild;
    AddPlay.m_sGuildName := Guild.m_sGuildName;
    AddPlay.m_boAddStabilityPoint := True;
    Guild.MemberLogin(AddPlay);
    AddPlay.RefShowName();
    AddPlay.SysMsg('成功加入行会: ' + Guild.m_sGuildName, c_red, t_hint);
  end;
end;

procedure TNormNpc.ActionOfAddIPList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  AddList(PlayObject.m_sIPaddr, m_sPath + QuestActionInfo.sParam1)
end;

procedure TNormNpc.ActionOfAddNameDateList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  LoadList: TStringList;
  boFound: Boolean;
  sListFileName, sLineText, sHumName, sDate: string;
begin
  sListFileName := g_Config.sGameDataDir + m_sPath + QuestActionInfo.sParam1;
  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
  end;
  boFound := False;
  for i := 0 to LoadList.Count - 1 do begin
    sLineText := Trim(LoadList.Strings[i]);
    sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
    sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
    if CompareText(sHumName, PlayObject.m_sCharName) = 0 then begin
      LoadList.Strings[i] := PlayObject.m_sCharName + #9 + DateTimeToStr(Now());
      boFound := True;
      break;
    end;
  end;
  if not boFound then
    LoadList.Add(PlayObject.m_sCharName + #9 + DateTimeToStr(Now()));
  try
    LoadList.SaveToFile(sListFileName);
  except
    MainOutMessage('saving fail.... => ' + sListFileName);
  end;
  LoadList.Free;
end;

procedure TNormNpc.ActionOfAddNameList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  AddList(PlayObject.m_sCharName, m_sPath + QuestActionInfo.sParam1)
end;

procedure TNormNpc.ActionOfAddRandomMapGate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  SEnvir, DEnvir: TEnvirnoment;
  nSX, nSY, nDX, nDY: Integer;
  dwRunTime: LongWord;
  boEffect: Boolean;
  sName: string;
  GateObj: pTGateObj;
  RandomGateObj: pTRandomGateObj;
begin
  sName := QuestActionInfo.sParam1;
  SEnvir := g_MapManager.FindMap(QuestActionInfo.sParam2);
  DEnvir := g_MapManager.FindMap(QuestActionInfo.sParam5);
  nSX := QuestActionInfo.nParam3;
  nSY := QuestActionInfo.nParam4;
  nDX := QuestActionInfo.nParam6;
  nDY := QuestActionInfo.nParam7;
  dwRunTime := StrToIntDef(QuestActionInfo.sParam8, 0);
  boEffect := (QuestActionInfo.sParam9 = '1');
  if (SEnvir = nil) or (DEnvir = nil) or (nDX <= 0) or (nDY <= 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDRANDOMMAPGATE);
    Exit;
  end;
  New(GateObj);
  GateObj.boRandom := True;
  GateObj.DEnvir := DEnvir;
  GateObj.nDMapX := nDX;
  GateObj.nDMapY := nDY;
  SEnvir.AddToMap(nSX, nSY, OS_GATEOBJECT, TObject(GateObj));
  New(RandomGateObj);
  RandomGateObj.sName := sName;
  RandomGateObj.SEnvir := SEnvir;
  RandomGateObj.GateObj := GateObj;
  RandomGateObj.nX := nSX;
  RandomGateObj.nY := nSY;
  RandomGateObj.Event := nil;
  if dwRunTime > 0 then begin
    RandomGateObj.dwRunTime := GetTickCount + dwRunTime * 1000;
    if boEffect then begin
      RandomGateObj.Event := THolyCurtainEvent.Create(SEnvir, nSX, nSY, ET_RANDOMGATE, High(Integer));
    end;
    UserEngine.m_RandomMapGateList.Add(RandomGateObj);
  end
  else begin
    SEnvir.m_RandomMapGateList.Add(RandomGateObj);
    if boEffect then begin
      RandomGateObj.Event := THolyCurtainEvent.Create(SEnvir, nSX, nSY, ET_RANDOMGATE, High(Integer));
    end;
  end;
end;

procedure TNormNpc.ActionOfDelRandomMapGate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  SEnvir: TEnvirnoment;
  sName: string;
  I: Integer;
  RandomGateObj: pTRandomGateObj;
begin
  sName := QuestActionInfo.sParam1;
  SEnvir := g_MapManager.FindMap(QuestActionInfo.sParam2);
  if (SEnvir = nil) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELRANDOMMAPGATE);
    Exit;
  end;
  for I := SEnvir.m_RandomMapGateList.Count - 1 downto 0 do begin
    RandomGateObj := SEnvir.m_RandomMapGateList[I];
    if CompareText(RandomGateObj.sName, sName) = 0 then begin
      SEnvir.DeleteFromMap(RandomGateObj.nX, RandomGateObj.nY, OS_GATEOBJECT, TObject(RandomGateObj.GateObj));
      if RandomGateObj.Event <> nil then begin
        RandomGateObj.Event.m_boClosed := True;
        RandomGateObj.Event.Close;
      end;
      Dispose(RandomGateObj.GateObj);
      Dispose(RandomGateObj);
      SEnvir.m_RandomMapGateList.Delete(I);
    end;
  end;
end;

procedure TNormNpc.ActionOfDelNameDateList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  LoadList: TStringList;
  sLineText, sListFileName, sHumName, sDate: string;
  boFound: Boolean;
begin
  sListFileName := g_Config.sGameDataDir + m_sPath + QuestActionInfo.sParam1;
  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
      LoadList.Free;
      Exit;
    end;
  end;
  boFound := False;
  for i := 0 to LoadList.Count - 1 do begin
    sLineText := Trim(LoadList.Strings[i]);
    sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
    sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
    if CompareText(sHumName, PlayObject.m_sCharName) = 0 then begin
      LoadList.Delete(i);
      boFound := True;
      break;
    end;
  end;
  if boFound then begin
    try
      LoadList.SaveToFile(sListFileName);
    except
      MainOutMessage('saving fail.... => ' + sListFileName);
    end;
  end;
  LoadList.Free;
end;

procedure TNormNpc.ActionOfDelNameList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  DelList(PlayObject.m_sCharName, m_sPath + QuestActionInfo.sParam1)
end;

procedure TNormNpc.ActionOfAddSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  //  i: Integer;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel: Integer;
begin
  nLevel := _MIN(3, StrToIntDef(QuestActionInfo.sParam2, 1));
  if nLevel <= 0 then
    nLevel := 1;
  Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
  if Magic <> nil then begin
    if not PlayObject.IsTrainingSkill(Magic.wMagicId) then begin
      New(UserMagic);
      UserMagic.MagicInfo := Magic;
      UserMagic.wMagIdx := Magic.wMagicId;
      UserMagic.btLevel := nLevel;
      UserMagic.nTranPoint := 0;
      UserMagic.dwInterval := 0;
      UserMagic.btKey := 0;
      PlayObject.m_MagicList.Add(UserMagic);
      PlayObject.SendAddMagic(UserMagic);
      PlayObject.RecalcAbilitys();
      if g_Config.boShowScriptActionMsg then begin
        PlayObject.SysMsg(Magic.sMagicName + ' 练习成功.', c_Green, t_Hint);
      end;
    end;
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDSKILL);
  end;
end;

procedure TNormNpc.ActionOfAddTextList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  AddList(QuestActionInfo.sParam1, m_sPath + QuestActionInfo.sParam2);
end;

{
procedure TNormNpc.ActionOfAutoAddGameGold(PlayObject: TPlayObject;
 QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
//var
//  sMsg: string;
begin
 if CompareText(QuestActionInfo.sParam1, 'START') = 0 then begin
   if (nPoint > 0) and (nTime > 0) then begin
     PlayObject.m_nIncGameGold := nPoint;
     PlayObject.m_dwIncGameGoldTime := LongWord(nTime * 1000);
     PlayObject.m_dwIncGameGoldTick := GetTickCount();
     PlayObject.m_boIncGameGold := True;
     Exit;
   end;
 end;
 if CompareText(QuestActionInfo.sParam1, 'STOP') = 0 then begin
   PlayObject.m_boIncGameGold := False;
   Exit;
 end;
 ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOADDGAMEGOLD);
end;
          }
//SETAUTOGETEXP 时间 点数 是否安全区 地图号

procedure TNormNpc.ActionOfAutoGetExp(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTime, nPoint: Integer;
  boIsSafeZone: Boolean;
  sMAP: string;
  Envir: TEnvirnoment;
begin
  Envir := nil;
  nTime := StrToIntDef(QuestActionInfo.sParam1, -1);
  nPoint := StrToIntDef(QuestActionInfo.sParam2, -1);

  sMAP := QuestActionInfo.sParam4;
  if sMAP <> '' then begin
    Envir := g_MapManager.FindMap(sMAP);
  end;
  if (nTime <= 0) or (nPoint <= 0) or ((sMAP <> '') and (Envir = nil)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETAUTOGETEXP);
    Exit;
  end;
  boIsSafeZone := QuestActionInfo.sParam3[1] = '1';
  PlayObject.m_boAutoGetExpInSafeZone := boIsSafeZone;
  PlayObject.m_AutoGetExpEnvir := Envir;
  PlayObject.m_nAutoGetExpTime := nTime * 1000;
  PlayObject.m_nAutoGetExpPoint := nPoint;
end;
{
procedure TNormNpc.ActionOfAutoSubGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
//var
//  sMsg: string;
begin
  if CompareText(QuestActionInfo.sParam1, 'START') = 0 then begin
    if (nPoint > 0) and (nTime > 0) then begin
      PlayObject.m_nDecGameGold := nPoint;
      PlayObject.m_dwDecGameGoldTime := LongWord(nTime * 1000);
      PlayObject.m_dwDecGameGoldTick := 0;
      PlayObject.m_boDecGameGold := True;
      Exit;
    end;
  end;
  if CompareText(QuestActionInfo.sParam1, 'STOP') = 0 then begin
    PlayObject.m_boDecGameGold := False;
    Exit;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOSUBGAMEGOLD);
end;           }

procedure TNormNpc.ActionOfChangeGameDiamond(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nGameDiamond: Integer;
  cMethod: Char;
  nOldDiamond: integer;
begin
  nOldDiamond := PlayObject.m_nGameDiamond;
  nGameDiamond := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (nGameDiamond < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGAMEDIAMOND);
    Exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': IntegerChange(PlayObject.m_nGameDiamond, nGameDiamond, INT_SET);
    '-': IntegerChange(PlayObject.m_nGameDiamond, nGameDiamond, INT_DEL);
    '+': IntegerChange(PlayObject.m_nGameDiamond, nGameDiamond, INT_ADD);
  else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGAMEDIAMOND);
      Exit;
    end;
  end;
  if PlayObject.m_nGameDiamond <> nOldDiamond then
    PlayObject.DiamondChanged;
end;

procedure TNormNpc.ActionOfChangeGameGird(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nGameGird: Integer;
  cMethod: Char;
  nOldGird: integer;
begin
  nOldGird := PlayObject.m_nGameGird;
  nGameGird := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (nGameGird < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGAMEGIRD);
    Exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': IntegerChange(PlayObject.m_nGameGird, nGameGird, INT_SET);
    '-': IntegerChange(PlayObject.m_nGameGird, nGameGird, INT_DEL);
    '+': IntegerChange(PlayObject.m_nGameGird, nGameGird, INT_ADD);
  else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGAMEGIRD);
      Exit;
    end;
  end;
  if PlayObject.m_nGameGird <> nOldGird then
    PlayObject.GameGirdChanged;
end;

procedure TNormNpc.ActionOfChangeCreditPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nCreditPoint: Integer;
  cMethod: Char;
  nOldPoint: integer;
begin
  nOldPoint := PlayObject.m_nCreditPoint;
  nCreditPoint := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (nCreditPoint < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREDITPOINT);
    Exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': IntegerChange(PlayObject.m_nCreditPoint, nCreditPoint, INT_SET);
    '-': IntegerChange(PlayObject.m_nCreditPoint, nCreditPoint, INT_DEL);
    '+': IntegerChange(PlayObject.m_nCreditPoint, nCreditPoint, INT_ADD);
  else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREDITPOINT);
      Exit;
    end;
  end;
  if g_boGameLogCreditPoint then begin
    AddGameLog(PlayObject, LOG_CREDITPOINT, sSTRING_CREDITPOINT, 0, PlayObject.m_nCreditPoint, m_sCharName,
      cMethod, IntToStr(nCreditPoint), '脚本' + sSC_CREDITPOINT, nil);
  end;
  if PlayObject.m_nCreditPoint <> nOldPoint then
    PlayObject.DiamondChanged;
end;

procedure TNormNpc.ActionOfChangeExp(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  //  boChgOK: Boolean;
  nExp: Int64;
  //  nLv: Integer;
  //  nOldLevel: Integer;
  cMethod: Char;
  //dwInt: LongWord;
begin
  //  boChgOK := False;
  nExp := StrToInt64Def(QuestActionInfo.sParam2, -1);
  if (nExp < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEEXP);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if nExp >= 0 then begin
          PlayObject.m_Abil.Exp := Int64(nExp);
          //          dwInt := LongWord(nExp);
        end;

      end;
    '-': begin
        if PlayObject.m_Abil.Exp > nExp then begin
          Dec(PlayObject.m_Abil.Exp, nExp);
        end
        else begin
          PlayObject.m_Abil.Exp := 0;
        end;

      end;
    '+': begin
        PlayObject.GetExp(nExp);
        {if PlayObject.m_Abil.Exp >= LongWord(nExp) then begin
          if (PlayObject.m_Abil.Exp - LongWord(nExp)) > (High(LongWord) - PlayObject.m_Abil.Exp) then begin
            dwInt := High(LongWord) - PlayObject.m_Abil.Exp;
          end
          else begin
            dwInt := LongWord(nExp);
          end;
        end
        else begin
          if (LongWord(nExp) - PlayObject.m_Abil.Exp) > (High(LongWord) - LongWord(nExp)) then begin
            dwInt := High(LongWord) - LongWord(nExp);
          end
          else begin
            dwInt := LongWord(nExp);
          end;
        end;     }
        //Inc(PlayObject.m_Abil.Exp, dwInt);
        //PlayObject.GetExp(dwInt);

      end;
  end;
end;

procedure TNormNpc.ActionOfChangeHairStyle(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nHair: Integer;
begin
  nHair := StrToIntDef(QuestActionInfo.sParam1, -1);
  if (QuestActionInfo.sParam1 <> '') and (nHair >= 0) then begin
    PlayObject.m_btHair := nHair;
    PlayObject.FeatureChanged;
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HAIRSTYLE);
  end;
end;

procedure TNormNpc.ActionOfChangeHumWuXin(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nWuXin: Integer;
begin
  nWuXin := StrToIntDef(QuestActionInfo.sParam1, -1);
  if nWuXin < 1 then begin
    if QuestActionInfo.sParam1 = '金' then
      nWuXin := 1
    else if QuestActionInfo.sParam1 = '木' then
      nWuXin := 2
    else if QuestActionInfo.sParam1 = '水' then
      nWuXin := 3
    else if QuestActionInfo.sParam1 = '火' then
      nWuXin := 4
    else if QuestActionInfo.sParam1 = '土' then
      nWuXin := 5;
  end;
  if not (nWuXin in [1..5]) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHUMWUXIN);
    Exit;
  end;
  PlayObject.m_btWuXin := nWuXin;
  PlayObject.HasLevelUp(-1);
end;

procedure TNormNpc.ActionOfChangeJob(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nJob: Integer;
begin
  nJob := -1;
  if CompareLStr(QuestActionInfo.sParam1, sWARRIOR, 3) then
    nJob := 0;
  if CompareLStr(QuestActionInfo.sParam1, sWIZARD, 3) then
    nJob := 1;
  if CompareLStr(QuestActionInfo.sParam1, sTAOS, 3) then
    nJob := 2;

  if nJob < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEJOB);
    Exit;
  end;

  if PlayObject.m_btJob <> nJob then begin
    PlayObject.m_btJob := nJob;
    {
    PlayObject.RecalcLevelAbilitys();
    PlayObject.RecalcAbilitys();
    }
    PlayObject.HasLevelUp(0);
  end;
end;

procedure TNormNpc.ActionOfSendCenterMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nFColor, nBColor, nMode, nTime, nLable: Integer;
  CenterMsg: pTCenterMsg;
  I, II, nFlag: Integer;
  SendObject: TPlayObject;
  Guild: TGuild;
  GuildRank: pTGuildRank;
begin
  nFColor := StrToIntDef(QuestActionInfo.sParam1, -1);
  nBColor := StrToIntDef(QuestActionInfo.sParam2, -1);
  nMode := StrToIntDef(QuestActionInfo.sParam4, -1);
  nTime := StrToIntDef(QuestActionInfo.sParam5, -1);
  nLable := GetScriptIndex(QuestActionInfo.sParam6);
  nFlag := StrToIntDef(QuestActionInfo.sParam7, -1);
  if nLable = -1 then begin
    ScriptActionError(PlayObject, QuestActionInfo.sParam6 + ' 不存在！', QuestActionInfo, sSC_SENDCENTERMSG);
    Exit;
  end;
  if (nFColor in [0..255]) and (nBColor in [0..255]) and (nMode in [0..4]) then begin
    if (nMode = 2) and (PlayObject.m_MyGuild = nil) then nMode := 0;
    if (nMode = 3) and (PlayObject.m_GroupOwner = nil) then nMode := 0;
    case nMode of
      0: begin
          New(CenterMsg);
          CenterMsg.Npc := Self;
          CenterMsg.nLable := nLable;
          CenterMsg.dwRunTick := GetTickCount + LongWord(nTime * 1000);
          CenterMsg.dwTimeout := GetTickCount + LongWord((nTime + 180) * 1000);
          CenterMsg.nFlag := nFlag;
          PlayObject.m_CenterMsgList.Add(CenterMsg);
          PlayObject.SendDefMsg(PlayObject, SM_CENTERMSG, Integer(CenterMsg), nFColor, nBColor, nTime, QuestActionInfo.sParam3);
        end;
      1: begin
          for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
            SendObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[i]);
            if SendObject <> nil then begin
              if (not SendObject.m_boGhost) and (not SendObject.m_boSafeOffLine) then begin
                New(CenterMsg);
                CenterMsg.Npc := Self;
                CenterMsg.nLable := nLable;
                CenterMsg.dwRunTick := GetTickCount + LongWord(nTime * 1000);
                CenterMsg.dwTimeout := GetTickCount + LongWord((nTime + 180) * 1000);
                CenterMsg.nFlag := nFlag;
                SendObject.m_CenterMsgList.Add(CenterMsg);
                SendObject.SendDefMsg(SendObject, SM_CENTERMSG, Integer(CenterMsg), nFColor, nBColor, nTime, QuestActionInfo.sParam3);
              end;
            end;
          end;
        end;
      2: begin
          if PlayObject.m_MyGuild <> nil then begin
            Guild := TGuild(PlayObject.m_MyGuild);
            for I := 0 to Guild.m_RankList.Count - 1 do begin
              GuildRank := Guild.m_RankList.Items[I];
              if GuildRank.MembersList = nil then Continue;
              for II := 0 to GuildRank.MembersList.Count - 1 do begin
                SendObject := TPlayObject(pTGuildUserInfo(GuildRank.MembersList.Objects[II]).PlayObject);
                if SendObject = nil then Continue;
                if (not SendObject.m_boGhost) and (not SendObject.m_boSafeOffLine) then begin
                  New(CenterMsg);
                  CenterMsg.Npc := Self;
                  CenterMsg.nLable := nLable;
                  CenterMsg.dwRunTick := GetTickCount + LongWord(nTime * 1000);
                  CenterMsg.dwTimeout := GetTickCount + LongWord((nTime + 180) * 1000);
                  CenterMsg.nFlag := nFlag;
                  SendObject.m_CenterMsgList.Add(CenterMsg);
                  SendObject.SendDefMsg(SendObject, SM_CENTERMSG, Integer(CenterMsg), nFColor, nBColor, nTime, QuestActionInfo.sParam3);
                end;
              end;
            end;
          end;
        end;
      3: begin
          if PlayObject.m_GroupOwner <> nil then begin
            for I := 0 to PlayObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
              SendObject := TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[I]);
              if SendObject = nil then Continue;
              if (not SendObject.m_boGhost) and (not SendObject.m_boSafeOffLine) then begin
                New(CenterMsg);
                CenterMsg.Npc := Self;
                CenterMsg.nLable := nLable;
                CenterMsg.dwRunTick := GetTickCount + LongWord(nTime * 1000);
                CenterMsg.dwTimeout := GetTickCount + LongWord((nTime + 180) * 1000);
                CenterMsg.nFlag := nFlag;
                SendObject.m_CenterMsgList.Add(CenterMsg);
                SendObject.SendDefMsg(SendObject, SM_CENTERMSG, Integer(CenterMsg), nFColor, nBColor, nTime, QuestActionInfo.sParam3);
              end;
            end;
          end;
        end;
      4: begin
          for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
            SendObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[i]);
            if SendObject <> nil then begin
              if (not SendObject.m_boGhost) and (not SendObject.m_boSafeOffLine) and (SendObject.m_PEnvir = PlayObject.m_PEnvir) then begin
                New(CenterMsg);
                CenterMsg.Npc := Self;
                CenterMsg.nLable := nLable;
                CenterMsg.dwRunTick := GetTickCount + LongWord(nTime * 1000);
                CenterMsg.dwTimeout := GetTickCount + LongWord((nTime + 180) * 1000);
                CenterMsg.nFlag := nFlag;
                SendObject.m_CenterMsgList.Add(CenterMsg);
                SendObject.SendDefMsg(SendObject, SM_CENTERMSG, Integer(CenterMsg), nFColor, nBColor, nTime, QuestActionInfo.sParam3);
              end;
            end;
          end;
        end;
    end;
  end else
    ScriptActionError(PlayObject, '参数错误', QuestActionInfo, sSC_SENDCENTERMSG);
end;

procedure TNormNpc.ActionOfClearSendCenterMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i, ii, nMode: Integer;
  nFlag: Integer;
  SendObject: TPlayObject;
  Guild: TGuild;
  GuildRank: pTGuildRank;
begin
  nFlag := StrToIntDef(QuestActionInfo.sParam1, -1);
  nMode := StrToIntDef(QuestActionInfo.sParam2, 0);
  if (nMode in [0..4]) then begin
    if (nMode = 2) and (PlayObject.m_MyGuild = nil) then nMode := 0;
    if (nMode = 3) and (PlayObject.m_GroupOwner = nil) then nMode := 0;
    case nMode of
      0: begin
          PlayObject.ClearCenterMsg(nFlag);
        end;
      1: begin
          for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
            SendObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[i]);
            if SendObject <> nil then begin
              if (not SendObject.m_boGhost) and (not SendObject.m_boSafeOffLine) then begin
                SendObject.ClearCenterMsg(nFlag);
              end;
            end;
          end;
        end;
      2: begin
          if PlayObject.m_MyGuild <> nil then begin
            Guild := TGuild(PlayObject.m_MyGuild);
            for I := 0 to Guild.m_RankList.Count - 1 do begin
              GuildRank := Guild.m_RankList.Items[I];
              if GuildRank.MembersList = nil then Continue;
              for II := 0 to GuildRank.MembersList.Count - 1 do begin
                SendObject := TPlayObject(pTGuildUserInfo(GuildRank.MembersList.Objects[II]).PlayObject);
                if SendObject = nil then Continue;
                if (not SendObject.m_boGhost) and (not SendObject.m_boSafeOffLine) then begin
                  SendObject.ClearCenterMsg(nFlag);
                end;
              end;
            end;
          end;
        end;
      3: begin
          if PlayObject.m_GroupOwner <> nil then begin
            for I := 0 to PlayObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
              SendObject := TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[I]);
              if SendObject = nil then Continue;
              if (not SendObject.m_boGhost) and (not SendObject.m_boSafeOffLine) then begin
                SendObject.ClearCenterMsg(nFlag);
              end;
            end;
          end;
        end;
      4: begin
          for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
            SendObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[i]);
            if SendObject <> nil then begin
              if (not SendObject.m_boGhost) and (not SendObject.m_boSafeOffLine) and (SendObject.m_PEnvir = PlayObject.m_PEnvir) then begin
                SendObject.ClearCenterMsg(nFlag);
              end;
            end;
          end;
        end;
    end;
  end else
    ScriptActionError(PlayObject, '参数错误', QuestActionInfo, sSC_SENDCENTERMSG);
end;

procedure TNormNpc.ActionOfChangeHumAbility(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  cMethod: Char;
  nOptions: Integer;
  nCount: Integer;
  pChangeWord: PWord;
  OldWord, NewWord: Word;
begin
  nCount := StrToIntDef(QuestActionInfo.sParam3, -1);
  nOptions := StrToIntDef(QuestActionInfo.sParam1, -1);
  case nOptions of
    1: pChangeWord := @PlayObject.m_TempAddAbil.AC2;
    2: pChangeWord := @PlayObject.m_TempAddAbil.AC;
    3: pChangeWord := @PlayObject.m_TempAddAbil.MAC2;
    4: pChangeWord := @PlayObject.m_TempAddAbil.MAC;
    5: pChangeWord := @PlayObject.m_TempAddAbil.DC2;
    6: pChangeWord := @PlayObject.m_TempAddAbil.DC;
    7: pChangeWord := @PlayObject.m_TempAddAbil.MC2;
    8: pChangeWord := @PlayObject.m_TempAddAbil.MC;
    9: pChangeWord := @PlayObject.m_TempAddAbil.SC2;
    10: pChangeWord := @PlayObject.m_TempAddAbil.SC;
  else
    pChangeWord := nil;
  end;
  if (pChangeWord = nil) or (nCount < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHUMABILITY);
    Exit;
  end;
  OldWord := pChangeWord^;
  NewWord := pChangeWord^;
  cMethod := QuestActionInfo.sParam2[1];
  case cMethod of
    '=': WordChange(NewWord, nCount, INT_SET);
    '+': WordChange(NewWord, nCount, INT_ADD);
    '-': WordChange(NewWord, nCount, INT_DEL);
  end;
  pChangeWord^ := NewWord;
  if OldWord <> NewWord then begin
    PlayObject.RecalcAbilitys;
    PlayObject.SendAbility;
  end;
end;

procedure TNormNpc.ActionOfChangeLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boChgOK: Boolean;
  nLevel: Integer;
  nLv: Integer;
  nOldLevel: Integer;
  cMethod: Char;
begin
  boChgOK := False;
  nOldLevel := PlayObject.m_Abil.Level;
  nLevel := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (nLevel < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGELEVEL);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if (nLevel > 0) and (nLevel <= MAXLEVEL) then begin
          PlayObject.m_Abil.Level := nLevel;
          boChgOK := True;
        end;
      end;
    '-': begin
        nLv := _MAX(0, PlayObject.m_Abil.Level - nLevel);
        nLv := _MIN(MAXLEVEL, nLv);
        PlayObject.m_Abil.Level := nLv;
        boChgOK := True;
      end;
    '+': begin
        nLv := _MAX(0, PlayObject.m_Abil.Level + nLevel);
        nLv := _MIN(MAXLEVEL, nLv);
        PlayObject.m_Abil.Level := nLv;
        boChgOK := True;
      end;
  end;
  if boChgOK then
    PlayObject.HasLevelUp(nOldLevel);
end;

procedure TNormNpc.ActionOfChangePkPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nPKPOINT: Integer;
  nOldPKLevel: Integer;
  cMethod: Char;
  nOldPkPoint: Integer;
begin
  nOldPKLevel := PlayObject.PKLevel;
  nOldPkPoint := Playobject.m_nPkPoint;
  nPKPOINT := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (nPKPOINT < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEPKPOINT);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        WordChange(PlayObject.m_nPkPoint, nPKPOINT, INT_SET);
      end;
    '-': begin
        WordChange(PlayObject.m_nPkPoint, nPKPOINT, INT_DEL);
      end;
    '+': begin
        WordChange(PlayObject.m_nPkPoint, nPKPOINT, INT_ADD);
      end;
  end;
  if nOldPKLevel <> PlayObject.PKLevel then
    PlayObject.RefNameColor;
  if nOldPkPoint <> Playobject.m_nPkPoint then
    PlayObject.DiamondChanged;
end;

procedure TNormNpc.ActionOfCreateGroupFail(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_boCanCreateGroup := False;
end;

procedure TNormNpc.ActionOfHCall(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  ObjPlay: TPlayObject;
  nIdx: Integer;
begin
  ObjPlay := UserEngine.GetPlayObject(QuestActionInfo.sParam1);
  if ObjPlay = nil then begin
    ScriptActionError(PlayObject, QuestActionInfo.sParam1 + ' 不在线', QuestActionInfo, sSC_HCALL);
    Exit;
  end;
  nIdx := g_ManageNPC.GetScriptIndex(QuestActionInfo.sParam2);
  if nIdx = -1 then begin
    ScriptActionError(PlayObject, QuestActionInfo.sParam2 + ' 脚本段不存在', QuestActionInfo, sSC_HCALL);
    Exit;
  end;
  ObjPlay.NpcGotoLable(g_ManageNPC, nIdx, False);
end;

procedure TNormNpc.ActionOfChangeGuildLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nLevel: Integer;
  Guild: TGuild;
  cMethod: Char;
begin
  nLevel := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (nLevel < 0) or (PlayObject.m_MyGuild = nil) then begin
    ScriptActionError(PlayObject, '当前人物没有行会或等级设置错误', QuestActionInfo, sSC_CHANGEGUILDLEVEL);
    Exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '+': Guild.SetLevel(nLevel + Guild.btLevel);
    '-': Guild.SetLevel(Guild.btLevel - nLevel);
    '=': Guild.SetLevel(nLevel);
  end;
end;

procedure TNormNpc.ActionOfSetLimitExpLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nLevel: Word;
  nExp: Byte;
begin
  nLevel := StrToIntDef(QuestActionInfo.sParam1, 0);
  nExp := StrToIntDef(QuestActionInfo.sParam2, 0);
  if (nLevel = 0) or (nExp > 100) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETLIMITEXPLEVEL);
    Exit;
  end;
  g_Config.nLimitExpLevel := nLevel;
  g_Config.nLimitExpValue := nExp;

  if QuestActionInfo.sParam3 = '1' then begin
    ExpConf.WriteInteger('Exp', 'LimitExpLevel', g_Config.nLimitExpLevel);
    ExpConf.WriteInteger('Exp', 'LimitExpValue', g_Config.nLimitExpValue);
  end;
end;

procedure TNormNpc.ActionOfChangePullulation(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nPullulation: Integer;
  nOldPullulation: Integer;
  cMethod: Char;
begin
  nOldPullulation := PlayObject.m_nPullulation;
  nPullulation := StrToIntDef(QuestActionInfo.sParam2, -1) * 60;
  if (nPullulation < 0) or (nPullulation > MAXPULLULATION) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEPULLULATION);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        IntegerChange(PlayObject.m_nPullulation, nPullulation, INT_SET);
      end;
    '-': begin
        IntegerChange(PlayObject.m_nPullulation, nPullulation, INT_DEL);
      end;
    '+': begin
        IntegerChange(PlayObject.m_nPullulation, nPullulation, INT_ADD);
      end;
  end;
  if PlayObject.m_nPullulation < 0 then
    PlayObject.m_nPullulation := 0;
  if PlayObject.m_nPullulation > MAXPULLULATION then
    PlayObject.m_nPullulation := MAXPULLULATION;
  if nOldPullulation <> PlayObject.m_nPullulation then
    PlayObject.GameGoldChanged;
end;

procedure TNormNpc.ActionOfClearMapMon(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  MonList: TList;
  mon: TBaseObject;
  ii: Integer;
begin
  MonList := TList.Create;
  UserEngine.GetMapMonster(g_MapManager.FindMap(QuestActionInfo.sParam1), MonList);
  for ii := 0 to MonList.Count - 1 do begin
    mon := TBaseObject(MonList.Items[ii]);
    if mon.m_Master <> nil then
      Continue;
    //if GetNoClearMonList(mon.m_sCharName) then
     // Continue;

    mon.m_boNoItem := True;
    mon.MakeGhost;
  end;
  MonList.Free;
end;

procedure TNormNpc.ActionOfClearNameList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName: string;
begin
  sListFileName := g_Config.sGameDataDir + m_sPath + QuestActionInfo.sParam1;
  LoadList := TStringList.Create;
  {
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
  end;
  }
  LoadList.Clear;
  try
    LoadList.SaveToFile(sListFileName);
  except
    MainOutMessage('saving fail.... => ' + sListFileName);
  end;
  LoadList.Free;
end;

procedure TNormNpc.ActionOfClearSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  UserMagic: pTUserMagic;
begin
  for i := PlayObject.m_MagicList.Count - 1 downto 0 do begin
    UserMagic := PlayObject.m_MagicList.Items[i];
    if UserMagic.MagicInfo.wMagicId = 100 then
      Continue;
    PlayObject.SendDelMagic(UserMagic);
    DisPose(UserMagic);
  end;
  PlayObject.m_MagicList.Clear;
  PlayObject.RecalcAbilitys();
end;

procedure TNormNpc.ActionOfClose(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.SendDefMsg(Self, SM_MERCHANTDLGCLOSE, Integer(Self), 0, 0, 0, '');
end;

procedure TNormNpc.ActionOfDelNoJobSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  UserMagic: pTUserMagic;
begin
  for i := PlayObject.m_MagicList.Count - 1 downto 0 do begin
    if PlayObject.m_MagicList.Count <= 0 then
      break;
    UserMagic := PlayObject.m_MagicList.Items[i];
    if UserMagic = nil then
      Continue;
    if (UserMagic.MagicInfo.btJob <> PlayObject.m_btJob) and (UserMagic.MagicInfo.btJob <> 99) then begin
      PlayObject.SendDelMagic(UserMagic);
      DisPose(UserMagic);
      PlayObject.m_MagicList.Delete(i);
    end;
  end;
  PlayObject.RecalcAbilitys;
end;

procedure TNormNpc.ActionOfDelSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
begin
  Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
  if Magic = nil then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELSKILL);
    Exit;
  end;
  for i := PlayObject.m_MagicList.Count - 1 downto 0 do begin
    if PlayObject.m_MagicList.Count <= 0 then
      break;
    UserMagic := PlayObject.m_MagicList.Items[i];
    if UserMagic = nil then
      Continue;
    if UserMagic.MagicInfo = Magic then begin
      PlayObject.m_MagicList.Delete(i);
      PlayObject.SendDelMagic(UserMagic);
      DisPose(UserMagic);
      PlayObject.RecalcAbilitys();
      break;
    end;
  end;
end;

procedure TNormNpc.ActionOfDelTextList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  DelList(QuestActionInfo.sParam1, m_sPath + QuestActionInfo.sParam2);
end;

procedure TNormNpc.ActionOfDiv(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14: integer;
begin
  n14 := GetValNameNo(QuestActionInfo.sParam1);
  if n14 >= 0 then begin
    case n14 of //
      0..99: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nVal[n14] := PlayObject.m_nVal[n14] div QuestActionInfo.nParam2
          else
            PlayObject.m_nVal[n14] := QuestActionInfo.nParam2 div QuestActionInfo.nParam3;
        end;
      2000..2999: begin
          if QuestActionInfo.sParam3 = '' then
            g_Config.GlobalVal[n14 - 2000] := g_Config.GlobalVal[n14 - 2000] div QuestActionInfo.nParam2
          else
            g_Config.GlobalVal[n14 - 2000] := QuestActionInfo.nParam2 div QuestActionInfo.nParam3;
        end;
      200..209: begin

          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_DyVal[n14 - 200] := PlayObject.m_DyVal[n14 - 200] div QuestActionInfo.nParam2
          else
            PlayObject.m_DyVal[n14 - 200] := QuestActionInfo.nParam2 div QuestActionInfo.nParam3;
        end;
      300..399: begin

          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nMval[n14 - 300] := PlayObject.m_nMval[n14 - 300] div QuestActionInfo.nParam2
          else
            PlayObject.m_nMval[n14 - 300] := QuestActionInfo.nParam2 div QuestActionInfo.nParam3;
        end;
      400..499: begin

          if QuestActionInfo.sParam3 = '' then
            g_Config.GlobaDyMval[n14 - 400] := g_Config.GlobaDyMval[n14 - 400] div QuestActionInfo.nParam2
          else
            g_Config.GlobaDyMval[n14 - 400] := QuestActionInfo.nParam2 div QuestActionInfo.nParam3;
        end;
      5000..5999: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nInteger[n14 - 5000] := PlayObject.m_nInteger[n14 - 5000] div QuestActionInfo.nParam2
          else
            PlayObject.m_nInteger[n14 - 5000] := QuestActionInfo.nParam2 div QuestActionInfo.nParam3;
        end;
      1000..1019: begin
          if QuestActionInfo.sParam3 = '' then begin
            PlayObject.m_CustomVariable[n14 - 1000] := PlayObject.m_CustomVariable[n14 - 1000] div QuestActionInfo.nParam2
          end
          else begin
            PlayObject.m_CustomVariable[n14 - 1000] := QuestActionInfo.nParam2 div QuestActionInfo.nParam3;
          end;
          if n14 = 1000 then
            PlayObject.LiteraryChange(True);

          if g_boGameLogCustomVariable then begin
            AddGameLog(PlayObject, LOG_CUSTOMVARIABLE, SSTRING_CUSTOMVARIABLE, n14 - 1000, PlayObject.m_CustomVariable[n14 - 1000], m_sCharName,
              'div', QuestActionInfo.sParam2 + '/' + QuestActionInfo.sParam3, '脚本div', nil);
          end;
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DIV);
      end;
    end; // case
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DIV);
  end;
end;

procedure TNormNpc.ActionOfMod(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14: integer;
begin
  n14 := GetValNameNo(QuestActionInfo.sParam1);
  if n14 >= 0 then begin
    case n14 of //
      0..99: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nVal[n14] := PlayObject.m_nVal[n14] mod QuestActionInfo.nParam2
          else
            PlayObject.m_nVal[n14] := QuestActionInfo.nParam2 mod QuestActionInfo.nParam3;
        end;
      2000..2999: begin
          if QuestActionInfo.sParam3 = '' then
            g_Config.GlobalVal[n14 - 2000] := g_Config.GlobalVal[n14 - 2000] mod QuestActionInfo.nParam2
          else
            g_Config.GlobalVal[n14 - 2000] := QuestActionInfo.nParam2 mod QuestActionInfo.nParam3;
        end;
      200..209: begin

          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_DyVal[n14 - 200] := PlayObject.m_DyVal[n14 - 200] mod QuestActionInfo.nParam2
          else
            PlayObject.m_DyVal[n14 - 200] := QuestActionInfo.nParam2 mod QuestActionInfo.nParam3;
        end;
      300..399: begin

          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nMval[n14 - 300] := PlayObject.m_nMval[n14 - 300] mod QuestActionInfo.nParam2
          else
            PlayObject.m_nMval[n14 - 300] := QuestActionInfo.nParam2 mod QuestActionInfo.nParam3;
        end;
      400..499: begin

          if QuestActionInfo.sParam3 = '' then
            g_Config.GlobaDyMval[n14 - 400] := g_Config.GlobaDyMval[n14 - 400] mod QuestActionInfo.nParam2
          else
            g_Config.GlobaDyMval[n14 - 400] := QuestActionInfo.nParam2 mod QuestActionInfo.nParam3;
        end;
      5000..5999: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nInteger[n14 - 5000] := PlayObject.m_nInteger[n14 - 5000] mod QuestActionInfo.nParam2
          else
            PlayObject.m_nInteger[n14 - 5000] := QuestActionInfo.nParam2 mod QuestActionInfo.nParam3;
        end;
      1000..1019: begin
          if QuestActionInfo.sParam3 = '' then begin
            PlayObject.m_CustomVariable[n14 - 1000] := PlayObject.m_CustomVariable[n14 - 1000] mod QuestActionInfo.nParam2
          end
          else begin
            PlayObject.m_CustomVariable[n14 - 1000] := QuestActionInfo.nParam2 mod QuestActionInfo.nParam3;
          end;
          if n14 = 1000 then
            PlayObject.LiteraryChange(True);

          if g_boGameLogCustomVariable then begin
            AddGameLog(PlayObject, LOG_CUSTOMVARIABLE, SSTRING_CUSTOMVARIABLE, n14 - 1000, PlayObject.m_CustomVariable[n14 - 1000], m_sCharName,
              'Mod', QuestActionInfo.sParam2 + '/' + QuestActionInfo.sParam3, '脚本Mod', nil);
          end;
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOD);
      end;
    end; // case
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOD);
  end;
end;

{
procedure TNormNpc.ActionOfEndQuest(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_Script := nil;
end;     }

procedure TNormNpc.ActionOfExChangeMap(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  s4C: string;
  Envir: TEnvirnoment;
  List58: TList;
  User: TPlayObject;
begin
  s4C := QuestActionInfo.sParam1;
  Envir := g_MapManager.FindMap(s4C);
  if Envir <> nil then begin
    List58 := TList.Create;
    UserEngine.GetMapRageHuman(Envir, 0, 0, 1000, List58);
    if List58.Count > 0 then begin
      User := TPlayObject(List58.Items[0]);
      User.MapRandomMove(m_PEnvir, 0);
    end;
    List58.Free;
    PlayObject.MapRandomMove(Envir, 0);
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sEXCHANGEMAP);
  end;
end;

procedure TNormNpc.ActionOfExeAction(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  Fn40 := QuestActionInfo.nParam1;
  Fs50 := QuestActionInfo.sParam1;
  ExeAction(PlayObject, QuestActionInfo.sParam1,
    QuestActionInfo.sParam2, QuestActionInfo.sParam3,
    QuestActionInfo.nParam1, QuestActionInfo.nParam2,
    QuestActionInfo.nParam3);
end;

{
procedure TNormNpc.ActionOfGameGold(PlayObject: TPlayObject;
 QuestActionInfo: pTQuestActionInfo);
var
 nGameGold: Integer;
 nOldGameGold: Integer;
 cMethod: Char;
begin
 nOldGameGold := PlayObject.m_nGameGold;
 nGameGold := StrToIntDef(QuestActionInfo.sParam2, -1);
 if (nGameGold < 0) then begin
   ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEGOLD);
   Exit;
 end;

 cMethod := QuestActionInfo.sParam1[1];
 case cMethod of
   '=': begin
       if (nGameGold >= 0) then begin
         PlayObject.m_nGameGold := nGameGold;
       end;
     end;
   '-': begin
       nGameGold := _MAX(0, PlayObject.m_nGameGold - nGameGold);
       PlayObject.m_nGameGold := nGameGold;
     end;
   '+': begin
       nGameGold := _MAX(0, PlayObject.m_nGameGold + nGameGold);
       PlayObject.m_nGameGold := nGameGold;
     end;
 end;
 //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
 if g_boGameLogGameGold then begin
   AddGameDataLog(format(g_sGameLogMsg1, [LOG_GAMEGOLD,
     PlayObject.m_sMapName,
       PlayObject.m_nCurrX,
       PlayObject.m_nCurrY,
       PlayObject.m_sCharName,
       g_Config.sGameGoldName,
       nGameGold,
       cMethod,
       m_sCharName]));
 end;
 if nOldGameGold <> PlayObject.m_nGameGold then
   PlayObject.GameGoldChanged;
end;
        }

procedure TNormNpc.ActionOfGamePoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGamePoint: Integer;
  nOldGamePoint: Integer;
  cMethod: Char;
begin
  nOldGamePoint := PlayObject.m_nGameGold;
  nGamePoint := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (nGamePoint < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEPOINT);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': IntegerChange(PlayObject.m_nGameGold, nGamePoint, INT_SET);
    '-': IntegerChange(PlayObject.m_nGameGold, nGamePoint, INT_DEL);
    '+': IntegerChange(PlayObject.m_nGameGold, nGamePoint, INT_ADD);
  end;
  if g_boGameLogGameGold then begin
    AddGameLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, PlayObject.m_nGameGold, m_sCharName,
      cMethod, IntToStr(nGamePoint), '脚本GameGold', nil);
  end;
  if nOldGamePoint <> PlayObject.m_nGameGold then
    PlayObject.GameGoldChanged;
end;

procedure TNormNpc.ActionOfResetNakedAbilPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nPoint, nTempNakedCount: Integer;
begin
  nPoint := StrToIntDef(QuestActionInfo.sParam1, -1);
  if (nPoint < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_RESETNAKEDABILPOINT);
    Exit;
  end;
  nTempNakedCount := 0;
  Inc(nTempNakedCount, PlayObject.m_NakedAbil.nAc);
  Inc(nTempNakedCount, PlayObject.m_NakedAbil.nMAc);
  Inc(nTempNakedCount, PlayObject.m_NakedAbil.nDc);
  Inc(nTempNakedCount, PlayObject.m_NakedAbil.nMc);
  Inc(nTempNakedCount, PlayObject.m_NakedAbil.nSc);
  Inc(nTempNakedCount, PlayObject.m_NakedAbil.nHP);
  if nTempNakedCount >= (nPoint + PlayObject.m_nNakedBackCount) then
    Inc(PlayObject.m_nNakedBackCount, nPoint)
  else begin
    PlayObject.m_nNakedBackCount := 0;
    SafeFillChar(PlayObject.m_NakedAbil, SizeOf(PlayObject.m_NakedAbil), #0);
    Inc(PlayObject.m_nNakedCount, nTempNakedCount);
    //PlayObject.m_nNakedBackCount := nTempNakedCount;
  end;
  PlayObject.SendNakedAbility;
end;

procedure TNormNpc.ActionOfGetLargessGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sSendMsg: string;
begin
  if PlayObject.m_nWaitIndex = 0 then begin
    PlayObject.m_nSQLAppendString := m_sCharName;
    PlayObject.m_nWaitIndex := GetWaitMsgID;
    sSendMsg := IntToStr(PlayObject.m_nWaitIndex) + '/';
    sSendMsg := sSendMsg + IntToStr(PlayObject.m_nDBIndex) + '/';
    sSendMsg := sSendMsg + IntToStr(RM_GETLARGESSGOLD) + '/';
    sSendMsg := sSendMsg + PlayObject.m_sUserID + '/' + PlayObject.m_sCharName;
    FrmIDSoc.SendGetLargessGold(sSendMsg);
  end
  else
    PlayObject.NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NGETLARGESSGOLD_ERROR], False);
end;

procedure TNormNpc.ActionOfGetMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseBaseObject: TBaseObject;
begin
  PoseBaseObject := PlayObject.GetPoseCreate();
  if (PoseBaseObject <> nil) and (PoseBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (PoseBaseObject.m_btGender <> PlayObject.m_btGender) then begin
    PlayObject.m_sDearName := PoseBaseObject.m_sCharName;
    PlayObject.RefShowName;
    PoseBaseObject.RefShowName;
  end
  else begin
    GotoLable(PlayObject, FGotoLable[nMarryError], False);
  end;
end;
{
procedure TNormNpc.ActionOfGetMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
 PoseBaseObject: TBaseObject;
begin
 PoseBaseObject := PlayObject.GetPoseCreate();
 if (PoseBaseObject <> nil) and (PoseBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (PoseBaseObject.m_btGender <> PlayObject.m_btGender) then begin
   PlayObject.m_sMasterName := PoseBaseObject.m_sCharName;
   PlayObject.RefShowName;
   PoseBaseObject.RefShowName;
 end
 else begin
   GotoLable(PlayObject, FGotoLable[nMasterError], False);
 end;
end;
     }

procedure TNormNpc.ActionOfGetRandomName(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sListFileName: string;
  LoadList: TStringList;
  n14: integer;
begin
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
  if FileExists(sListFileName) then begin
    LoadList := TStringList.Create;
    try
      try
        LoadList.LoadFromFile(sListFileName);
        if LoadList.Count > 0 then begin
          n14 := GetValNameNo(QuestActionInfo.sParam2);
          if n14 >= 0 then begin
            case n14 of
              6000..6999: begin
                  PlayObject.m_sString[n14 - 6000] := LoadList[Random(LoadList.Count)];
                end;
              7000..7999: begin
                  g_Config.GlobalAVal[n14 - 7000] := LoadList[Random(LoadList.Count)];
                end;
              800..899: begin
                  g_Config.GlobalUVal[n14 - 800] := LoadList[Random(LoadList.Count)];
                end;
            else
              ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GETRANDOMNAME);
            end;
          end;
        end;
      except
        MainOutMessage('Load fail.... => ' + sListFileName);
      end;
    finally
      LoadList.Free;
    end;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GETRANDOMNAME);
end;

procedure TNormNpc.ActionOfLineMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg: string;
  sParam2: string;
begin
  sParam2 := QuestActionInfo.sParam2;
  sMsg := GetLineVariableText(PlayObject, sParam2);
  sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
  sMsg := AnsiReplaceText(sMsg, '%x', IntToStr(PlayObject.m_nCurrX));
  sMsg := AnsiReplaceText(sMsg, '%y', IntToStr(PlayObject.m_nCurrY));
  if PlayObject.m_PEnvir <> nil then
    sMsg := AnsiReplaceText(sMsg, '%m', PlayObject.m_PEnvir.sMapDesc)
  else
    sMsg := AnsiReplaceText(sMsg, '%m', '????');
  sMsg := AnsiReplaceText(sMsg, '%d', m_sCharName);
  case QuestActionInfo.nParam1 of
    0: UserEngine.SendBroadCastMsg(sMsg, t_System);
    1: UserEngine.SendBroadCastMsg('(*) ' + sMsg, t_System);
    2: UserEngine.SendBroadCastMsg('[' + m_sCharName + ']' + sMsg, t_System);
    3: UserEngine.SendBroadCastMsg('[' + PlayObject.m_sCharName + ']' + sMsg, t_System);
    4: ProcessMonSayMsg(sMsg);
    5: PlayObject.SysMsg(sMsg, c_Red, t_Say);
    6: PlayObject.SysMsg(sMsg, c_Green, t_Say);
    7: PlayObject.SysMsg(sMsg, c_Blue, t_Say);
    8: UserEngine.SendBroadTopMsg(sMsg);
  else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SENDMSG);
    end;
  end;
end;

procedure TNormNpc.ActionOfMap(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  Fs4C := QuestActionInfo.sParam1;
  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
  PlayObject.MapRandomMove(Fs4C, 0);
  bo11 := True;
end;

procedure TNormNpc.ActionOfMapMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  Fs4C := QuestActionInfo.sParam1;
  Fn14 := QuestActionInfo.nParam2;
  Fn40 := QuestActionInfo.nParam3;
  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
  PlayObject.SpaceMove(Fs4C, Fn14, Fn40, 0);
  bo11 := True;
end;

procedure TNormNpc.ActionOfMapTing(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin

end;

procedure TNormNpc.ActionOfMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  PoseObject: TBaseObject;
  sSayMsg: string;
begin
  if PlayObject.m_sDearName <> '' then
    Exit;
  PoseObject := PlayObject.GetPoseCreate();
  if PoseObject = nil then begin
    GotoLable(PlayObject, FGotoLable[nMarryCheckDir], False);
    Exit;
  end;
  if PoseObject.m_btRaceServer <> RC_PLAYOBJECT then begin
    GotoLable(PlayObject, FGotoLable[nHumanTypeErr], False);
    Exit;
  end;
  PoseHuman := TPlayObject(PoseObject);

  if PoseHuman.m_sDearName <> '' then begin
    //GotoLable(PlayObject, FGotoLable[nMarryCheckDir], False);
    Exit;
  end;

  if QuestActionInfo.sParam1 = '' then begin
    if PoseHuman.GetPoseCreate = PlayObject then begin
      if PlayObject.m_btGender <> PoseHuman.m_btGender then begin
        GotoLable(PlayObject, FGotoLable[nStartMarry], False);
        GotoLable(PoseHuman, FGotoLable[nStartMarry], False);
        if (PlayObject.m_btGender = 0) and (PoseHuman.m_btGender = 1) then begin
          sSayMsg := AnsiReplaceText(g_sStartMarryManMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendMapBroadCastMsg(PlayObject.m_PEnvir, sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sStartMarryManAskQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendMapBroadCastMsg(PlayObject.m_PEnvir, sSayMsg, t_Say);
        end
        else if (PlayObject.m_btGender = 1) and (PoseHuman.m_btGender = 0) then begin
          sSayMsg := AnsiReplaceText(g_sStartMarryWoManMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendMapBroadCastMsg(PlayObject.m_PEnvir, sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sStartMarryWoManAskQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendMapBroadCastMsg(PlayObject.m_PEnvir, sSayMsg, t_Say);
        end;
        PlayObject.m_boStartMarry := True;
        PoseHuman.m_boStartMarry := True;
        PlayObject.m_PoseBaseObject := PoseHuman;
        PoseHuman.m_PoseBaseObject := PlayObject;
      end
      else begin
        GotoLable(PoseHuman, FGotoLable[nMarrySexErr], False);
        GotoLable(PlayObject, FGotoLable[nMarrySexErr], False);
      end;
    end
    else begin
      GotoLable(PlayObject, FGotoLable[nMarryDirErr], False);
      GotoLable(PoseHuman, FGotoLable[nMarryCheckDir], False);
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'REQUESTMARRY' {sREQUESTMARRY}) = 0 then begin
    if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then begin
      if (PlayObject.m_PoseBaseObject = PoseHuman) and (PoseHuman.m_PoseBaseObject = PlayObject) then begin
        if (PlayObject.m_btGender = 0) and (PoseHuman.m_btGender = 1) then begin
          sSayMsg := AnsiReplaceText(g_sMarryManAnswerQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendMapBroadCastMsg(PlayObject.m_PEnvir, sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sMarryManAskQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendMapBroadCastMsg(PlayObject.m_PEnvir, sSayMsg, t_Say);
          GotoLable(PlayObject, FGotoLable[nWateMarry], False);
          GotoLable(PoseHuman, FGotoLable[nRevMarry], False);
        end;
      end;
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'RESPONSEMARRY' {sRESPONSEMARRY}) = 0 then begin
    if (PlayObject.m_btGender = 1) and (PoseHuman.m_btGender = 0) and (PlayObject.m_sDearName = '') and (PoseHuman.m_sDearName = '') then begin
      if CompareText(QuestActionInfo.sParam2, 'OK') = 0 then begin
        if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then begin
          if (PlayObject.m_PoseBaseObject = PoseHuman) and (PoseHuman.m_PoseBaseObject = PlayObject) then begin
            sSayMsg := AnsiReplaceText(g_sMarryWoManAnswerQuestionMsg, '%n', m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendMapBroadCastMsg(PlayObject.m_PEnvir, sSayMsg, t_Say);
            sSayMsg := AnsiReplaceText(g_sMarryWoManGetMarryMsg, '%n', m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
            GotoLable(PlayObject, FGotoLable[nEndMarry], False);
            GotoLable(PoseHuman, FGotoLable[nEndMarry], False);
            PlayObject.m_boStartMarry := False;
            PoseHuman.m_boStartMarry := False;
            PlayObject.m_PoseBaseObject := nil;
            PoseHuman.m_PoseBaseObject := nil;
            PlayObject.m_sDearName := PoseHuman.m_sCharName;
            PlayObject.m_DearHuman := PoseHuman;
            PoseHuman.m_sDearName := PlayObject.m_sCharName;
            PoseHuman.m_DearHuman := PlayObject;
            PlayObject.RefShowName;
            PoseHuman.RefShowName;
          end;
        end;
      end
      else begin
        if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then begin
          if (PlayObject.m_PoseBaseObject = PoseHuman) and (PoseHuman.m_PoseBaseObject = PlayObject) then begin
            GotoLable(PlayObject, FGotoLable[nEndMarryFail], False);
            GotoLable(PoseHuman, FGotoLable[nEndMarryFail], False);
            PlayObject.m_boStartMarry := False;
            PoseHuman.m_boStartMarry := False;
            PlayObject.m_PoseBaseObject := nil;
            PoseHuman.m_PoseBaseObject := nil;
            sSayMsg := AnsiReplaceText(g_sMarryWoManDenyMsg, '%n', m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendMapBroadCastMsg(PlayObject.m_PEnvir, sSayMsg, t_Say);
            sSayMsg := AnsiReplaceText(g_sMarryWoManCancelMsg, '%n', m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendMapBroadCastMsg(PlayObject.m_PEnvir, sSayMsg, t_Say);
          end;
        end;
      end;
    end;
    Exit;
  end;
end;

//挑战
procedure TNormNpc.ActionOfDare(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  PoseObject: TBaseObject;
begin
  if CompareText(QuestActionInfo.sParam1, 'START') = 0 then begin
    if (PlayObject.m_DareObject <> nil) and (PlayObject.m_DareObject.m_DareObject = PlayObject) then begin
      PlayObject.m_DareState := ds_InProgress;
      PlayObject.m_DareObject.m_DareState := ds_InProgress;
      PlayObject.m_DareTick := GetTickCount + LongWord(QuestActionInfo.nParam2 * 1000);
      PlayObject.m_DareObject.m_DareTick := GetTickCount + LongWord(QuestActionInfo.nParam2 * 1000);
      GotoLable(SystemObject, GetScriptIndex('~System_DareStart'), False);
    end;
  end else
  if CompareText(QuestActionInfo.sParam1, 'MOVE') = 0 then begin
    PlayObject.SpaceMove(QuestActionInfo.sParam2, QuestActionInfo.nParam3, QuestActionInfo.nParam4, 0);
    PlayObject.m_AttackState := as_Close;
    if PlayObject.m_DareObject <> nil then
      PlayObject.m_AttackState := as_Dare;
  end else begin
    PoseObject := PlayObject.GetPoseCreate();
    if PoseObject = nil then begin
      GotoLable(PlayObject, GetScriptIndex('~DareCheckPose_Fail'), False);
      Exit;
    end;
    if PoseObject.m_btRaceServer <> RC_PLAYOBJECT then begin
      GotoLable(PlayObject, GetScriptIndex('~DareCheckPose_Fail'), False);
      Exit;
    end;
    PoseHuman := TPlayObject(PoseObject);
    if QuestActionInfo.sParam1 = '' then begin
      if PoseHuman.GetPoseCreate = PlayObject then begin
        PlayObject.m_DareObject := nil;
        PoseHuman.m_DareObject := nil;
        GotoLable(PlayObject, GetScriptIndex('~DareReady'), False);
        GotoLable(PoseHuman, GetScriptIndex('~DarePoseReady'), False);
      end else begin
        GotoLable(PlayObject, GetScriptIndex('~DareCheckPose_Fail'), False);
      end;
    end else
    if CompareText(QuestActionInfo.sParam1, 'ACCEPT') = 0 then begin
      PlayObject.m_DareObject := PoseHuman;
      PoseHuman.m_DareObject := PlayObject;
      GotoLable(PoseHuman, GetScriptIndex('~DareAccept'), False);
    end else
    if CompareText(QuestActionInfo.sParam1, 'REFUSE') = 0 then begin
      GotoLable(PoseHuman, GetScriptIndex('~DareRefuse'), False);
    end;
    if PlayObject.m_DareObject <> PoseHuman then Exit;
    if PoseHuman.m_DareObject <> PlayObject then Exit;
    if CompareText(QuestActionInfo.sParam1, 'READY') = 0 then begin
      PlayObject.m_DareNpc := Self;
      PlayObject.m_BoDareMaster := True;
      PoseHuman.m_DareNpc := Self;
      PoseHuman.m_BoDareMaster := False;
      PlayObject.m_DareState := ds_Ready;
      PoseHuman.m_DareState := ds_Ready;
      PlayObject.m_DareTick := GetTickCount + LongWord(QuestActionInfo.nParam2 * 1000);
      PoseHuman.m_DareTick := GetTickCount + LongWord(QuestActionInfo.nParam2 * 1000);
      GotoLable(PlayObject, GetScriptIndex('~DareReadyOK'), False);
      GotoLable(PoseHuman, GetScriptIndex('~DareReadyOK'), False);
      GotoLable(SystemObject, GetScriptIndex('~System_DareReady'), False);
    end;
  end;
end;

procedure TNormNpc.ActionOfMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  PoseObject: TBaseObject;
begin
  //if PlayObject.m_MasterList.Count > 0 then Exit;
  PoseObject := PlayObject.GetPoseCreate();
  if PoseObject = nil then begin
    GotoLable(PlayObject, FGotoLable[nMasterCheckDir], False);
    Exit;
  end;
  if PoseObject.m_btRaceServer <> RC_PLAYOBJECT then begin
    GotoLable(PlayObject, FGotoLable[nHumanTypeErr], False);
    Exit;
  end;
  PoseHuman := TPlayObject(PoseObject);

  if QuestActionInfo.sParam1 = '' then begin
    if (PoseHuman.m_MasterList.Count > 0) and (not PoseHuman.m_boMaster) then begin
      //师父为别人的徒弟
      GotoLable(PlayObject, FGotoLable[nMasterIsPrentice], False);
      Exit;
    end;
    if (PoseHuman.m_MasterList.Count >= High(THumMasterName)) then begin
      //师父的收徒列表已满
      GotoLable(PlayObject, FGotoLable[nMasterIsFull], False);
      Exit;
    end;
    if PoseHuman.GetPoseCreate = PlayObject then begin
      GotoLable(PlayObject, FGotoLable[nStartGetMaster], False);
      GotoLable(PoseHuman, FGotoLable[nStartMaster], False);
      PlayObject.m_boStartMaster := True;
      PoseHuman.m_boStartMaster := True;
      PlayObject.m_PoseBaseObject := PoseHuman;
      PoseHuman.m_PoseBaseObject := PlayObject;
    end
    else begin
      GotoLable(PlayObject, FGotoLable[nMasterDirErr], False);
      GotoLable(PoseHuman, FGotoLable[nMasterCheckDir], False);
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'REQUESTMASTER') = 0 then begin
    if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then begin
      if (PlayObject.m_PoseBaseObject = PoseHuman) and (PoseHuman.m_PoseBaseObject = PlayObject) then begin
        GotoLable(PlayObject, FGotoLable[nWateMaster], False);
        GotoLable(PoseHuman, FGotoLable[nRevMaster], False);
      end;
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'RESPONSEMASTER') = 0 then begin
    if CompareText(QuestActionInfo.sParam2, 'OK') = 0 then begin
      if (PlayObject.m_PoseBaseObject = PoseHuman) and (PoseHuman.m_PoseBaseObject = PlayObject) then begin
        if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then begin
          if (PlayObject.m_MasterList.Count = 0) or ((PlayObject.m_MasterList.Count < High(THumMasterName)) and PlayObject.m_boMaster) then begin
            GotoLable(PlayObject, FGotoLable[nEndMaster], False);
            GotoLable(PoseHuman, FGotoLable[nEndMaster], False);
            PlayObject.m_boStartMaster := False;
            PoseHuman.m_boStartMaster := False;
            PlayObject.m_PoseBaseObject := nil;
            PoseHuman.m_PoseBaseObject := nil;
            //if PlayObject.m_sMasterName = '' then begin
            //PlayObject.m_sMasterName := PoseHuman.m_sCharName;
            //PlayObject.m_MasterHuman := PoseHuman;
            PlayObject.m_MasterList.AddObject(PoseHuman.m_sCharName, PoseHuman);
            PlayObject.m_boMaster := True;
            //end;
            //PlayObject.m_MasterList.Add(PoseHuman);
            //PoseHuman.m_sMasterName := PlayObject.m_sCharName;
            //PoseHuman.m_MasterHuman := PlayObject;
            PoseHuman.m_MasterList.AddObject(PlayObject.m_sCharName, PlayObject);
            PoseHuman.m_boMaster := False;
            PlayObject.RefShowName;
            PoseHuman.RefShowName;
          end;
        end;
      end;
    end
    else begin
      if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then begin
        GotoLable(PlayObject, FGotoLable[nEndMasterFail], False);
        GotoLable(PoseHuman, FGotoLable[nEndMasterFail], False);
        PlayObject.m_boStartMaster := False;
        PoseHuman.m_boStartMaster := False;
        PlayObject.m_PoseBaseObject := nil;
        PoseHuman.m_PoseBaseObject := nil;
      end;
    end;
    Exit;
  end;
end;

procedure TNormNpc.ActionOfMessageBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sParam1: string;
begin
  sParam1 := QuestActionInfo.sParam1;

  PlayObject.SendDefMsg(Self, SM_MENU_OK, Integer(PlayObject), 0, 0, 0,
    GetLineVariableText(PlayObject, sParam1));
end;

procedure TNormNpc.ActionOfMission(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.nParam2 > 0) and
    (QuestActionInfo.nParam3 > 0) then begin
    g_sMissionMap := QuestActionInfo.sParam1;
    g_nMissionX := QuestActionInfo.nParam2;
    g_nMissionY := QuestActionInfo.nParam3;
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MISSION);
  end;
end;

//MOBFIREBURN MAP X Y TYPE TIME POINT

procedure TNormNpc.ActionOfMobFireBurn(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sMAP: string;
  nX, nY, nType, nTime, nPoint: Integer;
  FireBurnEvent: TFireBurnEvent;
  Envir: TEnvirnoment;
  OldEnvir: TEnvirnoment;
begin
  sMAP := QuestActionInfo.sParam1;
  nX := StrToIntDef(QuestActionInfo.sParam2, -1);
  nY := StrToIntDef(QuestActionInfo.sParam3, -1);
  nType := StrToIntDef(QuestActionInfo.sParam4, -1);
  nTime := StrToIntDef(QuestActionInfo.sParam5, -1);
  nPoint := StrToIntDef(QuestActionInfo.sParam6, -1);
  if (sMAP = '') or (nX < 0) or (nY < 0) or (nType < 0) or (nTime < 0) or (nPoint
    < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBFIREBURN);
    Exit;
  end;
  Envir := g_MapManager.FindMap(sMAP);
  if Envir <> nil then begin
    OldEnvir := PlayObject.m_PEnvir;
    PlayObject.m_PEnvir := Envir;
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, nType, nTime * 1000, nPoint);
    g_EventManager.AddEvent(FireBurnEvent);
    PlayObject.m_PEnvir := OldEnvir;
    Exit;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBFIREBURN);
end;

procedure TNormNpc.ActionOfMobPlace(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  nRandX, nRandY: Integer;
  mon: TBaseObject;
begin
  for i := 0 to Fn3C - 1 do begin
    nRandX := Random(Fn40 * 2 + 1) + (Fn34 - Fn40);
    nRandY := Random(Fn40 * 2 + 1) + (Fn38 - Fn40);
    mon := UserEngine.RegenMonsterByName(g_sMissionMap, nRandX, nRandY, QuestActionInfo.sParam1);
    if mon <> nil then begin
      mon.m_boMission := True;
      mon.m_nMissionX := g_nMissionX;
      mon.m_nMissionY := g_nMissionY;
    end
    else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBPLACE);
      break;
    end;
  end;
end;

procedure TNormNpc.ActionOfRandomMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14, n40: integer;
begin
  if PlayObject.m_PEnvir = nil then
    Exit;
  n14 := Random(PlayObject.m_PEnvir.m_nWidth);
  n40 := Random(PlayObject.m_PEnvir.m_nHeight);
  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
  PlayObject.SpaceMove(PlayObject.m_PEnvir, n14, n40, 0);
  bo11 := True;
end;

procedure TNormNpc.ActionOfRecallGroupMembers(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin

end;

procedure TNormNpc.ActionOfRecallHuman(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  if QuestActionInfo.sParam1 <> '' then begin
    PlayObject.RecallHuman(QuestActionInfo.sParam1);
  end;
end;

procedure TNormNpc.ActionOfSetRankLevelName(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sRankLevelName: string;
begin
  sRankLevelName := QuestActionInfo.sParam1;
  if sRankLevelName = '' then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETRANKLEVELNAME);
    exit;
  end;
  PlayObject.m_sRankLevelName := sRankLevelName;
  PlayObject.RefShowName;
end;

procedure TNormNpc.ActionOfSetScriptFlag(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boFlag: Boolean;
  nWhere: Integer;
begin
  nWhere := StrToIntDef(QuestActionInfo.sParam1, -1);
  boFlag := StrToIntDef(QuestActionInfo.sParam2, -1) = 1;
  case nWhere of
    0: begin
        PlayObject.m_boSendMsgFlag := boFlag;
      end;
    1: begin
        PlayObject.m_boChangeItemNameFlag := boFlag;
      end;
  else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETSCRIPTFLAG);
    end;
  end;
end;

procedure TNormNpc.ActionOfSetSendMsgFlag(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_boSendMsgFlag := True;
end;

procedure TNormNpc.ActionOfSkillLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel: Integer;
  cMethod: Char;
begin
  nLevel := StrToIntDef(QuestActionInfo.sParam3, 0);
  if nLevel < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SKILLLEVEL);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam2[1];
  Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
  if Magic <> nil then begin
    for i := 0 to PlayObject.m_MagicList.Count - 1 do begin
      UserMagic := PlayObject.m_MagicList.Items[i];
      if UserMagic.MagicInfo = Magic then begin
        case cMethod of
          '=': begin
              if nLevel >= 0 then begin
                nLevel := _MAX(3, nLevel);
                UserMagic.btLevel := nLevel;
              end;
            end;
          '-': begin
              if UserMagic.btLevel >= nLevel then begin
                Dec(UserMagic.btLevel, nLevel);
              end
              else begin
                UserMagic.btLevel := 0;
              end;
            end;
          '+': begin
              if UserMagic.btLevel + nLevel <= 3 then begin
                Inc(UserMagic.btLevel, nLevel);
              end
              else begin
                UserMagic.btLevel := 3;
              end;
            end;
        end;
        PlayObject.SendDelayDefMsg(PlayObject, SM_MAGIC_LVEXP, UserMagic.MagicInfo.wMagicId,
          UserMagic.btLevel, LoWord(UserMagic.nTranPoint), HiWord(UserMagic.nTranPoint), '', 100);
        break;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfAddMakeMagic(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  if not (QuestActionInfo.nParam1 in [Low(TMakeMagic)..High(TMakeMagic)]) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDMAKEMAGIC);
    Exit;
  end;
  if PlayObject.m_MakeMagic[QuestActionInfo.nParam1] = 0 then begin
    PlayObject.m_MakeMagic[QuestActionInfo.nParam1] := 1;
    PlayObject.SendMakeMagic;
  end;

end;

procedure TNormNpc.ActionOfSetGuageBar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  if QuestActionInfo.sParam3 = '' then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETGUAGEBAR);
    Exit;
  end;
  PlayObject.m_boClickOpenGuage := True;
  PlayObject.m_dwClickOpenGuageTime := GetTickCount + LongWord(QuestActionInfo.nParam1 * 1000);
  PlayObject.m_ClickGuageNPC := Self;
  PlayObject.m_ClickGuageNPCLabel := QuestActionInfo.sParam2;
  PlayObject.SendDefMessage(SM_SHOWBAR, Integer(Self), 0,
    CM_GUAGEBAR, QuestActionInfo.nParam1, QuestActionInfo.sParam3);
end;

procedure TNormNpc.ActionOfStartWallconquestWar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  Castle: TUserCastle;
begin
  Castle := g_CastleManager.Find(QuestActionInfo.sParam1);
  if Castle = nil then
    Castle := g_CastleManager.GetCastle(0);
  if (Castle <> nil) and (not Castle.m_boUnderWar) then begin
    Castle.StartWallconquestWarOnAllGuild;
  end
  else
    ScriptActionError(PlayObject, '正在攻城当中', QuestActionInfo, sSC_STARTWALLCONQUESTWAR);
end;

procedure TNormNpc.ActionOfStorageTimeChange(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nTime: Integer;
  nIdx: Integer;
  cMethod: Char;
begin
  nTime := StrToIntDef(QuestActionInfo.sParam3, -1);
  nIdx := StrToIntDef(QuestActionInfo.sParam1, -1) - 1;
  if (nTime < 0) or (not (nIdx in [1..4])) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_STORAGETIMECHANGE);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam2[1];
  try
    case cMetHod of
      '=': begin
          PlayObject.m_dwStorageTime[nIdx] := IncDay(Now, nTime);
          if PlayObject.m_dwStorageTime[nIdx] > Now then begin
            PlayObject.m_boStorageOpen[nIdx] := True;
          end
          else
            PlayObject.m_boStorageOpen[nIdx] := False;
        end;
      '+': begin
          if PlayObject.m_boStorageOpen[nIdx] then
            PlayObject.m_dwStorageTime[nIdx] := IncDay(PlayObject.m_dwStorageTime[nIdx], nTime)
          else
            PlayObject.m_dwStorageTime[nIdx] := IncDay(Now, nTime);
          PlayObject.m_boStorageOpen[nIdx] := True;
        end;
      '-': begin
          if PlayObject.m_boStorageOpen[nIdx] then begin
            PlayObject.m_dwStorageTime[nIdx] := IncDay(PlayObject.m_dwStorageTime[nIdx], -nTime);
            if Now >= PlayObject.m_dwStorageTime[nIdx] then begin
              PlayObject.m_dwStorageTime[nIdx] := 0;
              PlayObject.m_boStorageOpen[nIdx] := False;
            end;
          end;
        end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(E.Message);
      MainOutMessage('[Exception] TNormNpc.ActionOfStorageTimeChange ' + cMetHod + ' ' + QuestActionInfo.sParam3);
    end;
  end;
end;

procedure TNormNpc.ActionOfAddMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i, nIdx: Integer;
  sName: string;
  nTime: Integer;
begin
  sName := Trim(QuestActionInfo.sParam2);
  nTime := StrToIntDef(QuestActionInfo.sParam3, -1);
  if (sName = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDMISSION);
    Exit;
  end;
  nIdx := -1;

  for I := High(PlayObject.m_MissionInfo) downto Low(PlayObject.m_MissionInfo) do begin
    if PlayObject.m_MissionInfo[I].sMissionName = '' then begin
      nIdx := I;
    end
    else if CompareText(PlayObject.m_MissionInfo[I].sMissionName, sName) = 0 then begin
      ScriptActionError(PlayObject, '任务已接受', QuestActionInfo, sSC_ADDMISSION);
      exit;
    end;
  end;
  if nIdx <> -1 then begin
    if QuestActionInfo.nParam1 in [Low(PlayObject.m_MissionIndex)..High(PlayObject.m_MissionIndex)] then begin
      PlayObject.m_MissionIndex[QuestActionInfo.nParam1] := nIdx;
      PlayObject.m_MissionInfo[nIdx].sMissionName := sName;
      PlayObject.m_MissionInfo[nIdx].btKillCount1 := 0;
      PlayObject.m_MissionInfo[nIdx].btKillCount2 := 0;
      PlayObject.m_MissionInfo[nIdx].boTrack := True;
      if nTime > 0 then
        PlayObject.m_MissionInfo[nIdx].wTime := nTime
      else
        PlayObject.m_MissionInfo[nIdx].wTime := 0;
      PlayObject.SendDefMsg(PlayObject, SM_MISSIONINFO, nIdx, 0, PlayObject.m_MissionInfo[nIdx].wTime, MISSTAG_ADDMISSION, sName);
    end
    else begin
      ScriptActionError(PlayObject, '任务索引错误', QuestActionInfo, sSC_ADDMISSION);
    end;
  end
  else
    ScriptActionError(PlayObject, '任务列表已满', QuestActionInfo, sSC_ADDMISSION);
end;

procedure TNormNpc.ActionOfDelMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nIdx: Integer;
begin
  if QuestActionInfo.nParam1 in [Low(PlayObject.m_MissionIndex)..High(PlayObject.m_MissionIndex)] then begin
    nIdx := PlayObject.m_MissionIndex[QuestActionInfo.nParam1];
    if (nIdx in [Low(PlayObject.m_MissionInfo)..High(PlayObject.m_MissionInfo)]) then begin
      if PlayObject.m_MissionInfo[nIdx].sMissionName <> '' then begin
        PlayObject.m_MissionInfo[nIdx].sMissionName := '';
        PlayObject.SendDefMsg(PlayObject, SM_MISSIONINFO, nIdx, 0, 0, MISSTAG_DELMISSION, '');
      end;
      PlayObject.m_MissionIndex[QuestActionInfo.nParam1] := 0;
    end; { else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELMISSION); }
  end
  else begin
    ScriptActionError(PlayObject, '任务索引错误', QuestActionInfo, sSC_DELMISSION);
  end;
end;

procedure TNormNpc.ActionOfUpdateMissionTime(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nIdx, nTime: Integer;
begin
  nTime := StrToIntDef(QuestActionInfo.sParam2, -1);

  if QuestActionInfo.nParam1 in [Low(PlayObject.m_MissionIndex)..High(PlayObject.m_MissionIndex)] then begin
    nIdx := PlayObject.m_MissionIndex[QuestActionInfo.nParam1];
    if (nIdx in [Low(PlayObject.m_MissionInfo)..High(PlayObject.m_MissionInfo)]) then begin
      {PlayObject.m_MissionInfo[nIdx].sMissionName := Trim(QuestActionInfo.sParam2);
      PlayObject.m_MissionInfo[nIdx].btKillCount1 := 0;
      PlayObject.m_MissionInfo[nIdx].btKillCount2 := 0;
      PlayObject.SendDefMsg(PlayObject, SM_MISSIONINFO, nIdx,
        PlayObject.m_MissionInfo[nIdx].btKillCount1,
        PlayObject.m_MissionInfo[nIdx].btKillCount2,
        MISSTAG_UPDATEMISSION, Trim(QuestActionInfo.sParam2));}
      if nTime > 0 then
        PlayObject.m_MissionInfo[nIdx].wTime := nTime
      else
        PlayObject.m_MissionInfo[nIdx].wTime := 0;
      PlayObject.SendDefMsg(PlayObject, SM_MISSIONINFO, nIdx, 0, PlayObject.m_MissionInfo[nIdx].wTime, MISSTAG_UPDATEMISSIONTIME, '');
    end
    else
      ScriptActionError(PlayObject, '索引引导错误', QuestActionInfo, sSC_UPDATEMISSIONTIME);
  end
  else begin
    ScriptActionError(PlayObject, '任务索引错误', QuestActionInfo, sSC_UPDATEMISSIONTIME);
  end;
end;

procedure TNormNpc.ActionOfUpdateMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nIdx: Integer;
begin
  if (Trim(QuestActionInfo.sParam2) = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPDATEMISSION);
    Exit;
  end;
  if QuestActionInfo.nParam1 in [Low(PlayObject.m_MissionIndex)..High(PlayObject.m_MissionIndex)] then begin
    nIdx := PlayObject.m_MissionIndex[QuestActionInfo.nParam1];
    if (nIdx in [Low(PlayObject.m_MissionInfo)..High(PlayObject.m_MissionInfo)]) then begin
      PlayObject.m_MissionInfo[nIdx].sMissionName := Trim(QuestActionInfo.sParam2);
      PlayObject.m_MissionInfo[nIdx].btKillCount1 := 0;
      PlayObject.m_MissionInfo[nIdx].btKillCount2 := 0;
      PlayObject.SendDefMsg(PlayObject, SM_MISSIONINFO, nIdx,
        PlayObject.m_MissionInfo[nIdx].btKillCount1,
        PlayObject.m_MissionInfo[nIdx].btKillCount2,
        MISSTAG_UPDATEMISSION, Trim(QuestActionInfo.sParam2));
    end
    else
      ScriptActionError(PlayObject, '索引引导错误', QuestActionInfo, sSC_UPDATEMISSION);
  end
  else begin
    ScriptActionError(PlayObject, '任务索引错误', QuestActionInfo, sSC_UPDATEMISSION);
  end;
end;

procedure TNormNpc.ActionOfChangeMakeMagicLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nMagicIdx: Integer;
  nLevel: Integer;
begin
  nMagicIdx := StrToIntDef(QuestActionInfo.sParam1, -1);
  nLevel := StrToIntDef(QuestActionInfo.sParam3, -1);
  if (not (nMagicIdx in [Low(TMakeMagic)..High(TMakeMagic)])) or (not (nLevel in [0..100])) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEMAKEMAGICLEVEL);
    exit;
  end;
  case QuestActionInfo.sParam2[1] of
    '+': begin
        if (PlayObject.m_MakeMagic[nMagicIdx] + nLevel) > 100 then
          PlayObject.m_MakeMagic[nMagicIdx] := 100
        else
          PlayObject.m_MakeMagic[nMagicIdx] := PlayObject.m_MakeMagic[nMagicIdx] + nLevel;
      end;
    '-': begin
        if PlayObject.m_MakeMagic[nMagicIdx] > nLevel then
          PlayObject.m_MakeMagic[nMagicIdx] := PlayObject.m_MakeMagic[nMagicIdx] - nLevel
        else
          PlayObject.m_MakeMagic[nMagicIdx] := 0;
      end;
    '=': PlayObject.m_MakeMagic[nMagicIdx] := nLevel
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEMAKEMAGICLEVEL);
  end;
  PlayObject.SendMakeMagic;
end;

procedure TNormNpc.ActionOfChangeMakeMagicPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nLevel: Integer;
begin
  nLevel := StrToIntDef(QuestActionInfo.sParam2, -1);
  if nLevel < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEMAKEMAGICPOINT);
    exit;
  end;
  case QuestActionInfo.sParam1[1] of
    '+': WordChange(PlayObject.m_nMakeMagicPoint, nLevel, INT_ADD);
    '-': WordChange(PlayObject.m_nMakeMagicPoint, nLevel, INT_DEL);
    '=': WordChange(PlayObject.m_nMakeMagicPoint, nLevel, INT_SET);
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEMAKEMAGICPOINT);
  end;
  PlayObject.SendMakeMagic;
end;

procedure TNormNpc.ActionOfChangeMissionKillMonCount(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nIdx, nCount: Integer;
  PCount: PByte;
  btCount: Byte;
begin
  nCount := StrToIntDef(QuestActionInfo.sParam4, -1);
  if nCount = -1 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEMISSIONKILLMONCOUNT);
    exit;
  end;
  if QuestActionInfo.nParam1 in [Low(PlayObject.m_MissionIndex)..High(PlayObject.m_MissionIndex)] then begin
    nIdx := PlayObject.m_MissionIndex[QuestActionInfo.nParam1];
    if (nIdx in [Low(PlayObject.m_MissionInfo)..High(PlayObject.m_MissionInfo)]) then begin
      if QuestActionInfo.sParam2 = '2' then
        PCount := @PlayObject.m_MissionInfo[nIdx].btKillCount2
      else
        PCount := @PlayObject.m_MissionInfo[nIdx].btKillCount1;
      btCount := PCount^;
      case QuestActionInfo.sParam3[1] of
        '+': ByteChange(btCount, nCount, INT_ADD);
        '-': ByteChange(btCount, nCount, INT_DEL);
        '=': ByteChange(btCount, nCount, INT_SET);
      else
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEMISSIONKILLMONCOUNT);
      end;
      PCount^ := btCount;
      PlayObject.SendDefMsg(PlayObject, SM_MISSIONINFO, nIdx, StrToIntDef(QuestActionInfo.sParam2, 1),
        PCount^, MISSTAG_CHANGEKILLMONCOUNT, '');
    end
    else
      ScriptActionError(PlayObject, '索引引导错误', QuestActionInfo, sSC_CHANGEMISSIONKILLMONCOUNT);
  end
  else begin
    ScriptActionError(PlayObject, '任务索引错误', QuestActionInfo, sSC_CHANGEMISSIONKILLMONCOUNT);
  end;
end;

procedure TNormNpc.ActionOfChangeArithmonmeterCount(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nCount: Integer;
begin
  nCount := StrToIntDef(QuestActionInfo.sParam3, -1);
  if nCount = -1 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEARITHMOMETERCOUNT);
    exit;
  end;
  if QuestActionInfo.nParam1 in [Low(PlayObject.m_MissionArithmometer)..High(PlayObject.m_MissionArithmometer)] then begin
    case QuestActionInfo.sParam2[1] of
      '+': ByteChange(PlayObject.m_MissionArithmometer[QuestActionInfo.nParam1], nCount, INT_ADD);
      '-': ByteChange(PlayObject.m_MissionArithmometer[QuestActionInfo.nParam1], nCount, INT_DEL);
      '=': ByteChange(PlayObject.m_MissionArithmometer[QuestActionInfo.nParam1], nCount, INT_SET);
    else
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEARITHMOMETERCOUNT);
    end;
    PlayObject.SendDefMsg(PlayObject, SM_MISSIONINFO, QuestActionInfo.nParam1,
      PlayObject.m_MissionArithmometer[QuestActionInfo.nParam1], 0, MISSTAG_ARITHMOMETERCHANGE, '');
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEARITHMOMETERCOUNT);
end;

procedure TNormNpc.ActionOfShowEffect(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  if CompareText('SELF', QuestActionInfo.sParam2) = 0 then
    PlayObject.SendDefMsg(PlayObject, SM_SHOWEFFECT, Integer(PlayObject),
      QuestActionInfo.nParam1, PlayObject.m_nCurrX, PlayObject.m_nCurrY, '')
  else
    PlayObject.SendRefMsg(RM_SHOWEFFECT, QuestActionInfo.nParam1, Integer(PlayObject),
      PlayObject.m_nCurrX, PlayObject.m_nCurrY, '');
end;

procedure TNormNpc.ActionOfAutoMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.SendDefMsg(PlayObject, SM_AUTOMOVE, 0, 0, 0, 0, QuestActionInfo.sParam1);
end;

procedure TNormNpc.ActionOfMobMachineryEvent(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sMAP, sName: string;
  nX, nY, nIdx, nTime: Integer;
  Envir: TEnvirnoment;
  Event: TEvent;
  AddList: TList;
begin
  sMAP := QuestActionInfo.sParam1;
  nX := StrToIntDef(QuestActionInfo.sParam2, -1);
  nY := StrToIntDef(QuestActionInfo.sParam3, -1);
  nTime := StrToIntDef(QuestActionInfo.sParam4, -1);
  sName := QuestActionInfo.sParam5;
  if (sMAP = '') or (nX < 0) or (nY < 0) or (sName = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBMACHINERYEVENT);
    Exit;
  end;
  if CompareText(sMAP, 'NPCMAP') = 0 then
    Envir := m_PEnvir
  else if CompareText(sMAP, 'FBMAP') = 0 then
    Envir := PlayObject.m_FBEnvir
  else if CompareText(sMAP, 'SELF') = 0 then
    Envir := PlayObject.m_PEnvir
  else
    Envir := g_MapManager.FindMap(sMAP);
  if (Envir <> nil) and (Envir.m_boFB) then begin
    nIdx := Envir.m_Event.IndexOf(sName);
    if nIdx = -1 then begin
      AddList := TList.Create;
      Envir.m_Event.AddObject(sName, TObject(AddList));
    end
    else
      AddList := TList(Envir.m_Event.Objects[nIdx]);
    Event := TMachineryEvent.Create(Envir, nX, nY, nTime);
    g_EventManager.AddEvent(Event);
    AddList.Add(Event);
    Exit;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBMACHINERYEVENT);
end;

procedure TNormNpc.ActionOfClearEctypeMon(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sMAP: string;
  Envir: TEnvirnoment;
  mon: TBaseObject;
  I: Integer;
begin
  sMAP := QuestActionInfo.sParam1;
  if (sMAP = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARECTYPEMON);
    Exit;
  end;
  if CompareText(sMAP, 'NPCMAP') = 0 then
    Envir := m_PEnvir
  else if CompareText(sMAP, 'FBMAP') = 0 then
    Envir := PlayObject.m_FBEnvir
  else if CompareText(sMAP, 'SELF') = 0 then
    Envir := PlayObject.m_PEnvir
  else
    Envir := g_MapManager.FindMap(sMAP);
  if (Envir <> nil) then begin
    for I := 0 to Envir.m_MonsterList.Count - 1 do begin
      mon := TBaseObject(Envir.m_MonsterList.Items[I]);
      if (not mon.m_boGhost) and (mon.m_Master = nil) then begin
        mon.MakeGhost;
      end;
    end;
    Envir.m_MonsterList.Clear;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARECTYPEMON);
end;

procedure TNormNpc.ActionOfClearList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName: string;
begin
  sListFileName := g_Config.sGameDataDir + m_sPath + QuestActionInfo.sParam1;
  if FileExists(sListFileName) then begin
    LoadList := TStringList.Create;
    try
      try
        //LoadList.Add(#13#10);
        LoadList.SaveToFile(sListFileName);
      except
        MainOutMessage('saving fail.... => ' + m_sPath + QuestActionInfo.sParam1);
      end;
    finally
      LoadList.Free;
    end;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARLIST);
end;

procedure TNormNpc.ActionOfSetMapQuest(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sMAP: string;
  Envir: TEnvirnoment;
begin
  sMAP := QuestActionInfo.sParam1;
  if (sMAP = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMAPQUEST);
    Exit;
  end;
  if CompareText(sMAP, 'NPCMAP') = 0 then
    Envir := m_PEnvir
  else if CompareText(sMAP, 'FBMAP') = 0 then
    Envir := PlayObject.m_FBEnvir
  else if CompareText(sMAP, 'SELF') = 0 then
    Envir := PlayObject.m_PEnvir
  else
    Envir := g_MapManager.FindMap(sMAP);
  if (Envir <> nil) then begin
    Envir.SetQuestFlagStatus(StrToIntDef(QuestActionInfo.sParam2, 0), StrToIntDef(QuestActionInfo.sParam3, 0));
  end;
end;

procedure TNormNpc.ActionOfOpenBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  if not PlayObject.OpenBox(QuestActionInfo.nParam1, Random(100) < StrToIntDef(QuestActionInfo.sParam2, -1)) then
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENBOX);
end;

procedure TNormNpc.ActionOfResetMapQuest(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  II: integer;
  sMAP: string;
  Envir: TEnvirnoment;
begin
  sMAP := QuestActionInfo.sParam1;
  if (sMAP = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_RESETMAPQUEST);
    Exit;
  end;
  if CompareText(sMAP, 'NPCMAP') = 0 then
    Envir := m_PEnvir
  else if CompareText(sMAP, 'FBMAP') = 0 then
    Envir := PlayObject.m_FBEnvir
  else if CompareText(sMAP, 'SELF') = 0 then
    Envir := PlayObject.m_PEnvir
  else
    Envir := g_MapManager.FindMap(sMAP);
  if (Envir <> nil) then begin
    for ii := 0 to QuestActionInfo.nParam3 - 1 do begin
      Envir.SetQuestFlagStatus(QuestActionInfo.nParam2 + ii, 0);
    end;
  end;
end;

procedure TNormNpc.ActionOfMobEctypeMon(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sMAP, sName: string;
  nX, nY {, nDir}: Integer;
  Envir: TEnvirnoment;
  //mon: TBaseObject;
  I: Integer;
begin
  sMAP := QuestActionInfo.sParam1;
  nX := StrToIntDef(QuestActionInfo.sParam2, -1);
  nY := StrToIntDef(QuestActionInfo.sParam3, -1);
  sName := QuestActionInfo.sParam4;
  //  nDir := StrToIntDef(QuestActionInfo.sParam7, -1);
  if (sMAP = '') or (nX < 0) or (nY < 0) or (sName = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBECTYPEMON);
    Exit;
  end;
  if CompareText(sMAP, 'NPCMAP') = 0 then
    Envir := m_PEnvir
  else if CompareText(sMAP, 'FBMAP') = 0 then
    Envir := PlayObject.m_FBEnvir
  else if CompareText(sMAP, 'SELF') = 0 then
    Envir := PlayObject.m_PEnvir
  else
    Envir := g_MapManager.FindMap(sMAP);
  if (Envir <> nil) and (Envir.m_boFB) then begin
    for i := 0 to QuestActionInfo.nParam5 - 1 do begin
      nX := Random(QuestActionInfo.nParam6 * 2 + 1) + (nX - QuestActionInfo.nParam6);
      nY := Random(QuestActionInfo.nParam6 * 2 + 1) + (nY - QuestActionInfo.nParam6);
      //mon :=
      UserEngine.RegenMonsterByName(Envir, nX, nY, sName);
      //if mon <> nil then begin
        //Envir.m_MonsterList.Add(mon);
       { if nDir in [0..7] then mon.m_btDirection := nDir;
        mon.m_boMission := True;
        mon.m_nMissionX := nX;
        mon.m_nMissionY := nY;
        mon.m_btMissionDir := mon.m_btDirection; }
     // end;
    end;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBECTYPEMON);
end;

procedure TNormNpc.ActionOfMoveEctype(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nX, nY: Integer;
  Envir: TEnvirnoment;
  sFBName: string;
begin
  sFBName := QuestActionInfo.sParam1;
  nX := StrToIntDef(QuestActionInfo.sParam2, -1);
  nY := StrToIntDef(QuestActionInfo.sParam3, -1);
  if (nX < 0) or (nY < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOVEECTYPE);
    Exit;
  end;

  if (PlayObject.m_GroupOwner <> nil) and (TPlayObject(PlayObject.m_GroupOwner).m_FBEnvir <> nil) and
    (CompareText(sFBName, TPlayObject(PlayObject.m_GroupOwner).m_FBEnvir.m_sFBName) = 0) then
    Envir := TPlayObject(PlayObject.m_GroupOwner).m_FBEnvir
  else if (PlayObject.m_FBEnvir <> nil) and (CompareText(sFBName, PlayObject.m_FBEnvir.m_sFBName) = 0) then
    Envir := PlayObject.m_FBEnvir
  else
    Envir := nil;

  if (Envir <> nil) and (Envir.m_boFBCreate) then begin
    PlayObject.EnterAnotherMap(Envir, nX, nY);
  end
end;

procedure TNormNpc.ActionOfCreateEctype(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sFBName: string;
  FBList: TList;
  nIdx, I, k: Integer;
  dwTime: LongWord;
  Envir: TEnvirnoment;
  MonGen: pTMonGenInfo;
begin
  sFBName := QuestActionInfo.sParam1;
  dwTime := StrToIntDef(QuestActionInfo.sParam2, 0);
  if (sFBName = '') or (dwTime = 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREATEECTYPE);
    Exit;
  end;
  if ((PlayObject.m_FBEnvir <> nil) and (CompareText(sFBName, PlayObject.m_FBEnvir.m_sFBName) = 0)) or
    ((PlayObject.m_GroupOwner <> nil) and (TPlayObject(PlayObject.m_GroupOwner).m_FBEnvir <> nil) and
    (CompareText(sFBName, TPlayObject(PlayObject.m_GroupOwner).m_FBEnvir.m_sFBName) = 0)) then begin
    GotoLable(PlayObject, FGotoLable[nCreateEctype_IN], False); //队伍副本已经存在，可直接传送进入
    Exit;
  end
  else begin
    nIdx := g_FBMapManager.IndexOf(sFBName);
    if nIdx <> -1 then begin
      FBList := TList(g_FBMapManager.Objects[nIdx]);
      for I := 0 to FBList.Count - 1 do begin
        Envir := FBList[I];
        if (g_MapObjectCount[Envir.m_nMapIndex] <= 0) and (not Envir.m_boFBCreate) then begin
          Inc(Envir.m_btFBIndex);
          Envir.m_boFBCreate := True;
          Envir.m_dwFBTime := GetTickCount + dwTime * 60 * 1000;
          Envir.m_MasterObject := PlayObject;
          Envir.m_dwFBCreateTime := GetTickCount;
          Envir.m_dwFBFailTime := 0;
          Envir.m_boFBFail := False;
          PlayObject.m_FBEnvir := Envir;
          GotoLable(PlayObject, FGotoLable[nCreateEctype_OK], False); //副本创建成功
          for k := 0 to Envir.m_MonGenList.Count - 1 do begin
            MonGen := Envir.m_MonGenList[k];
            UserEngine.RegenMonsters(MonGen, MonGen.nCount, False);
          end;
          Exit;
        end;
      end;
      GotoLable(PlayObject, FGotoLable[nCreateEctype_Fail], False); //副本创建失败
    end
    else
      ScriptActionError(PlayObject, '副本不存在', QuestActionInfo, sSC_CREATEECTYPE);
  end;
end;

procedure TNormNpc.ActionOfClearMachineryEvent(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sMAP, sName: string;
  nIdx, I, k: Integer;
  Envir: TEnvirnoment;
  Event: TEvent;
  AddList: TList;
begin
  sMAP := QuestActionInfo.sParam1;
  sName := QuestActionInfo.sParam2;
  if CompareText(sMAP, 'NPCMAP') = 0 then
    Envir := m_PEnvir
  else if CompareText(sMAP, 'FBMAP') = 0 then
    Envir := PlayObject.m_FBEnvir
  else if CompareText(sMAP, 'SELF') = 0 then
    Envir := PlayObject.m_PEnvir
  else
    Envir := g_MapManager.FindMap(sMAP);
  if Envir <> nil then begin
    if sName = '' then begin
      for k := Envir.m_Event.Count - 1 downto 0 do begin
        AddList := TList(Envir.m_Event.Objects[k]);
        for I := AddList.Count - 1 downto 0 do begin
          Event := TEvent(AddList[I]);
          Event.m_boClosed := True;
          Event.m_boManualClose := True;
          Event.Close;
        end;
        AddList.Free;
      end;
      Envir.m_Event.Clear;
      Exit;
    end
    else begin
      nIdx := Envir.m_Event.IndexOf(sName);
      if nIdx > -1 then begin
        AddList := TList(Envir.m_Event.Objects[nIdx]);
        for I := AddList.Count - 1 downto 0 do begin
          Event := TEvent(AddList[I]);
          Event.m_boClosed := True;
          Event.m_boManualClose := True;
          Event.Close;
        end;
        AddList.Free;
        Envir.m_Event.Delete(nIdx);
      end;
      Exit;
    end;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARMACHINERYEVENT);
end;

procedure TNormNpc.ActionOfChangeGiveItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
  function ChangeInteger(nMin, nMax, nValue: Integer; sValue: string): Integer;
  var
    nInt: Integer;
  begin
    Result := nValue;
    if Length(sValue) > 1 then begin
      if sValue[1] in ['+', '-', '='] then begin
        nInt := StrToIntDef(Copy(sValue, 2, Length(sValue) - 1), nValue);
        case sValue[1] of
          '+': begin
              if (nInt + nValue) > nMax then Result := nMax
              else Result := nInt + nValue;
              if Result < nMin then
                Result := nMin;
            end;
          '-': begin
              if (nValue - nInt) < nMin then Result := nMin
              else Result := nValue - nInt;
              if Result > nMax then
                Result := nMax;
            end;
          '=': begin
              if (nInt >= nMin) and (nInt <= nMax) then
                Result := nInt;
            end;
        end;
      end else begin
        nInt := StrToIntDef(sValue, nValue);
        if (nInt >= nMin) and (nInt <= nMax) then
          Result := nInt;
      end;
    end else begin
      nInt := StrToIntDef(sValue, nValue);
      if (nInt >= nMin) and (nInt <= nMax) then
        Result := nInt;
    end;
  end;
var
  UserItem: pTUserItem;
  dUserItem: TUserItem;
  Stditem: pTStdItem;
  boUseItem, boHookItem: Boolean;
  ItemList: TList;
  I: Integer;
  boHorseItem: Boolean;
  btHorseItemWhere: Byte;
begin
  boHookItem := False;
  if FGiveItemList.Count > 0 then begin
    ItemList := FGiveItemList;
    boUseItem := False;
  end
  else if FHookItemList.Count > 0 then begin
    ItemList := FHookItemList;
    boUseItem := True;
  end
  else if PlayObject.m_HookItemEx.Count > 0 then begin
    ItemList := PlayObject.m_HookItemEx;
    boUseItem := True;
    boHookItem := True;
  end
  else begin
    ScriptActionError(PlayObject, '没有指定物品数据', QuestActionInfo, sSC_CHANGEGIVEITEM);
    Exit;
  end;
  StdItem := nil;
  for I := 0 to ItemList.Count - 1 do begin
    UserItem := ItemList[I];
    boHorseItem := False;
    btHorseItemWhere := 0;
    
    if (not boHookItem) and (Integer(UserItem) in [16..20]) then
    begin
      if not boUseItem then Continue;
      btHorseItemWhere := Integer(UserItem) - 16;
      
      if (PlayObject.m_UseItems[u_House].wIndex > 0) and (PlayObject.m_UseItems[u_House].HorseItems[btHorseItemWhere].wIndex > 0) then begin
        StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[u_House].HorseItems[btHorseItemWhere].wIndex);
        if StdItem <> nil then begin
          dUserItem := HorseItemToUserItem(@PlayObject.m_UseItems[u_House].HorseItems[btHorseItemWhere], StdItem);
          UserItem := @dUserItem;
          boHorseItem := True;
        end else Continue;
      end else Continue;
    end else
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if Stditem = nil then Continue;
    if QuestActionInfo.nParam1 = 8 then begin
      if boUseItem then begin
        if boHorseItem then
          PlayObject.SendUpdateItem(@PlayObject.m_UseItems[u_House])
        else
          PlayObject.SendUpdateItem(UserItem);
        if (StdItem <> nil) and (StdItem.NeedIdentify = 1) then
          AddGameLog(PlayObject, LOG_UPDATEITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
            'ChangeGive', 'Hook', '脚本', Useritem);
      end
      else begin
        PlayObject.SendAddItem(UserItem);
        if (StdItem <> nil) and (StdItem.NeedIdentify = 1) then
          AddGameLog(PlayObject, LOG_UPDATEITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
            'ChangeGive', 'Give', '脚本', Useritem);
      end;
    end else
    if Stditem.StdMode = tm_House then begin
      case QuestActionInfo.nParam1 of
        1: begin
            if CompareText(QuestActionInfo.sParam3, 'HOUR') = 0 then begin
              UserItem.TermTime := DateTimeToLongWord(IncHour(Now, QuestActionInfo.nParam2));
            end
            else
              UserItem.TermTime := DateTimeToLongWord(IncDay(Now, QuestActionInfo.nParam2));
          end;
        2: begin
            case QuestActionInfo.nParam2 of
              0: SetByteStatus(UserItem.btBindMode1, 0, QuestActionInfo.nParam3 = 1);
              1: SetByteStatus(UserItem.btBindMode1, 1, QuestActionInfo.nParam3 = 1);
              2: SetByteStatus(UserItem.btBindMode1, 2, QuestActionInfo.nParam3 = 1);
              3: SetByteStatus(UserItem.btBindMode1, 3, QuestActionInfo.nParam3 = 1);
              4: SetByteStatus(UserItem.btBindMode1, 4, QuestActionInfo.nParam3 = 1);
              5: SetByteStatus(UserItem.btBindMode1, 5, QuestActionInfo.nParam3 = 1);
              6: SetByteStatus(UserItem.btBindMode1, 6, QuestActionInfo.nParam3 = 1);
              7: SetByteStatus(UserItem.btBindMode1, 7, QuestActionInfo.nParam3 = 1);
              8: SetByteStatus(UserItem.btBindMode2, 0, QuestActionInfo.nParam3 = 1);
            end;
          end;
        10: UserItem.btLevel := ChangeInteger(1, High(Byte), UserItem.btLevel, QuestActionInfo.sParam2);
        11: begin
            UserItem.dwExp := ChangeInteger(0, 2000000000, UserItem.dwExp, QuestActionInfo.sParam2);
            PlayObject.HorseGetExp(0);
          end;
      end;
    end else begin
      case QuestActionInfo.nParam1 of
        0: begin
            //UserItem.DuraMax := QuestActionInfo.nParam2;
            UserItem.DuraMax := ChangeInteger(0, High(Word), UserItem.DuraMax, QuestActionInfo.sParam2);  
          end;
        1: begin
            if CompareText(QuestActionInfo.sParam3, 'HOUR') = 0 then begin
              UserItem.TermTime := DateTimeToLongWord(IncHour(Now, QuestActionInfo.nParam2));
            end
            else
              UserItem.TermTime := DateTimeToLongWord(IncDay(Now, QuestActionInfo.nParam2));
          end;
        2: begin
            case QuestActionInfo.nParam2 of
              0: SetByteStatus(UserItem.btBindMode1, 0, QuestActionInfo.nParam3 = 1);
              1: SetByteStatus(UserItem.btBindMode1, 1, QuestActionInfo.nParam3 = 1);
              2: SetByteStatus(UserItem.btBindMode1, 2, QuestActionInfo.nParam3 = 1);
              3: SetByteStatus(UserItem.btBindMode1, 3, QuestActionInfo.nParam3 = 1);
              4: SetByteStatus(UserItem.btBindMode1, 4, QuestActionInfo.nParam3 = 1);
              5: SetByteStatus(UserItem.btBindMode1, 5, QuestActionInfo.nParam3 = 1);
              6: SetByteStatus(UserItem.btBindMode1, 6, QuestActionInfo.nParam3 = 1);
              7: SetByteStatus(UserItem.btBindMode1, 7, QuestActionInfo.nParam3 = 1);
              8: SetByteStatus(UserItem.btBindMode2, 0, QuestActionInfo.nParam3 = 1);
            end;
          end;
        3: begin
            if QuestActionInfo.nParam2 in [0..5] then
              UserItem.Value.btWuXin := QuestActionInfo.nParam2;
          end;
        4: begin
            UserItem.Value.btFluteCount := ChangeInteger(0, 3, UserItem.Value.btFluteCount, QuestActionInfo.sParam2);
            //if QuestActionInfo.nParam2 in [0..3] then
              //UserItem.Value.btFluteCount := QuestActionInfo.nParam2;
          end;
        5: begin
            if QuestActionInfo.nParam2 in [0, 3, 6, 9, 12, 15, 18] then //CanStrengthenMax
              UserItem.Value.StrengthenInfo.btCanStrengthenCount := QuestActionInfo.nParam2;
          end;
        6: begin
            case QuestActionInfo.nParam2 of
              0: begin
                  if QuestActionInfo.nParam3 in [0..(CanStrengthenMax[0] - 1)] then
                    UserItem.Value.StrengthenInfo.btStrengthenInfo[0] := QuestActionInfo.nParam3;
                end;
              1: begin
                  if QuestActionInfo.nParam3 in [0..(CanStrengthenMax[1] - 1)] then
                    UserItem.Value.StrengthenInfo.btStrengthenInfo[1] := QuestActionInfo.nParam3;
                end;
              2: begin
                  if QuestActionInfo.nParam3 in [0..(CanStrengthenMax[2] - 1)] then
                    UserItem.Value.StrengthenInfo.btStrengthenInfo[2] := QuestActionInfo.nParam3;
                end;
              3: begin
                  if QuestActionInfo.nParam3 in [0..(CanStrengthenMax[3] - 1)] then
                    UserItem.Value.StrengthenInfo.btStrengthenInfo[3] := QuestActionInfo.nParam3;
                end;
              4: begin
                  if QuestActionInfo.nParam3 in [0..(CanStrengthenMax[4] - 1)] then
                    UserItem.Value.StrengthenInfo.btStrengthenInfo[4] := QuestActionInfo.nParam3;
                end;
              5: begin
                  if QuestActionInfo.nParam3 in [0..(CanStrengthenMax[5] - 1)] then
                    UserItem.Value.StrengthenInfo.btStrengthenInfo[5] := QuestActionInfo.nParam3;
                end;
            end;
          end;
        7: begin
            if QuestActionInfo.nParam2 in [Low(TUserItemValueArray)..High(TUserItemValueArray)] then begin
              //UserItem.Value.btValue[QuestActionInfo.nParam2] := Byte(QuestActionInfo.nParam3);
              UserItem.Value.btValue[QuestActionInfo.nParam2] := ChangeInteger(0, High(Byte), UserItem.Value.btValue[QuestActionInfo.nParam2], QuestActionInfo.sParam3);
            end
            else if QuestActionInfo.nParam2 = 27 then begin
              UserItem.EffectValue.btColor := QuestActionInfo.nParam3;
            end
            else if QuestActionInfo.nParam2 = 28 then begin
              UserItem.EffectValue.btEffect := QuestActionInfo.nParam3;
            end;
          end;
        9: begin
            UserItem.Value.StrengthenInfo.btStrengthenCount := ChangeInteger(0, _MIN(UserItem.Value.StrengthenInfo.btCanStrengthenCount, 18), UserItem.Value.StrengthenInfo.btStrengthenCount, QuestActionInfo.sParam2);
            //if QuestActionInfo.nParam2 <= 18 then //CanStrengthenMax
              //UserItem.Value.StrengthenInfo.btStrengthenCount := _MIN(QuestActionInfo.nParam2, UserItem.Value.StrengthenInfo.btCanStrengthenCount);

          end;
        10: ;
        11: ;
      end;
    end;
    if boHorseItem and (UserItem <> nil) and (btHorseItemWhere in [Low(PlayObject.m_UseItems[u_House].HorseItems)..High(PlayObject.m_UseItems[u_House].HorseItems)]) then begin
      PlayObject.m_UseItems[u_House].HorseItems[btHorseItemWhere] := UserItemToHorseItem(UserItem);
    end;
  end;
  if QuestActionInfo.nParam1 = 8 then begin
    FGiveItemList.Clear;
    FHookItemList.Clear;
  end;
end;

//sItemName: string; nItemCount: Integer; sVarNo: string)

procedure TNormNpc.ActionOfTake(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  nCount: Integer;
  sName: string;
begin
  nCount := QuestActionInfo.nParam2;
  sName := QuestActionInfo.sParam1;
  if nCount <= 0 then
    Exit;
  if CompareText(sName, sSTRING_BINDGOLDNAME) = 0 then begin
    IntegerChange(PlayObject.m_nBindGold, nCount, INT_DEL);
    PlayObject.GoldChanged();
    if g_boGameLogBindGold then
      AddGameLog(PlayObject, LOG_BINDGOLDCHANGED, sSTRING_BINDGOLDNAME, 0, PlayObject.m_nBindGold, m_sCharName,
        '-', IntToStr(nCount), '脚本Take', nil);
    Exit;
  end;
  if CompareText(sName, sSTRING_GOLDNAME) = 0 then begin
    PlayObject.DecGold(nCount);
    PlayObject.GoldChanged();
    if g_boGameLogGold then
      AddGameLog(PlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayObject.m_nGold, m_sCharName,
        '-', IntToStr(nCount), '脚本Take', nil);
    Exit;
  end;

  for i := PlayObject.m_ItemList.Count - 1 downto 0 do begin
    if nCount <= 0 then
      break;
    UserItem := PlayObject.m_ItemList.Items[i];
    if UserItem = nil then
      Continue;
    if CompareText(UserEngine.GetStdItemName(UserItem.wIndex), sName) = 0 then begin
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (Stditem <> nil) and (Stditem.NeedIdentify = 1) then
        AddGameLog(PlayObject, LOG_DELITEM, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName,
          'Take', '0', '出售', UserItem);
      PlayObject.m_ItemList.Delete(i);
      PlayObject.SendDelItems(UserItem);
      DisPose(UserItem);
      Dec(nCount);
    end;
  end;
end;

procedure TNormNpc.ActionOfTakeCastleGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nGold: Integer;
begin
  nGold := StrToIntDef(QuestActionInfo.sParam1, -1);
  if (nGold < 0) or (m_Castle = nil) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TAKECASTLEGOLD);
    Exit;
  end;
  if nGold <= TUserCastle(m_Castle).m_nTotalGold then begin
    Dec(TUserCastle(m_Castle).m_nTotalGold, nGold);
  end
  else begin
    TUserCastle(m_Castle).m_nTotalGold := 0;
  end;
end;

procedure TNormNpc.ActionOfTakeCount(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sItemname: string;
  nItemCount: integer;
  StdItem: pTStdItem;
  i: Integer;
  UserItem: pTUserItem;
begin
  sItemname := QuestActionInfo.sParam1;
  nItemCount := StrToIntDef(QuestActionInfo.sParam2, 1);
  if CompareText(sItemname, sSTRING_BINDGOLDNAME) = 0 then begin
    IntegerChange(PlayObject.m_nBindGold, nItemCount, INT_DEL);
    PlayObject.GoldChanged();
    if g_boGameLogBindGold then
      AddGameLog(PlayObject, LOG_BINDGOLDCHANGED, sSTRING_BINDGOLDNAME, 0, PlayObject.m_nBindGold, m_sCharName,
        '-', IntToStr(nItemCount), '脚本TakeCount', nil);
    Exit;
  end;
  if CompareText(sItemname, sSTRING_GOLDNAME) = 0 then begin
    PlayObject.DecGold(nItemCount);
    PlayObject.GoldChanged();
    if g_boGameLogGold then
      AddGameLog(PlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayObject.m_nGold, m_sCharName,
        '-', IntToStr(nItemCount), '脚本TakeCount', nil);
    Exit;
  end;
  StdItem := UserEngine.GetStdItem(sItemName);
  if (StdItem = nil) then begin
    ScriptActionError(PlayObject, '物品不存在', QuestActionInfo,
      sSC_TAKECOUNT);
    Exit;
  end;
  if PlayObject.m_ItemList.Count > 0 then
    for I := PlayObject.m_ItemList.Count - 1 downto 0 do begin
      if nItemCount <= 0 then
        Break;
      UserItem := PlayObject.m_ItemList.Items[i];
      if (UserItem <> nil) and ((UserItem.wIndex - 1) = StdItem.Idx) then begin
        if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
          if nItemCount >= UserItem.Dura then begin
            if Stditem.NeedIdentify = 1 then
              AddGameLog(PlayObject, LOG_DELITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
                'TakeCount', '0', '出售', UserItem);
            Dec(nItemCount, UserItem.Dura);
            PlayObject.m_ItemList.Delete(i);
            PlayObject.SendDelItems(UserItem);
            DisPose(UserItem);

          end
          else begin
            Dec(UserItem.Dura, nItemCount);
            if Stditem.NeedIdentify = 1 then
              AddGameLog(PlayObject, LOG_ITEMDURACHANGE, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
                '-', IntToStr(nItemCount), 'TakeCount', UserItem);
            PlayObject.SendDefMessage(SM_BAG_DURACHANGE,
              UserItem.MakeIndex,
              UserItem.Dura,
              UserItem.DuraMax,
              0,
              '');
            Break;
          end;
        end
        else begin
          if Stditem.NeedIdentify = 1 then
            AddGameLog(PlayObject, LOG_DELITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
              'TakeCount', '0', '出售', UserItem);
          PlayObject.m_ItemList.Delete(i);
          PlayObject.SendDelItems(UserItem);
          DisPose(UserItem);
          Dec(nItemCount);
        end;
      end;
    end;
end;

procedure TNormNpc.ActionOfTakeW(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  sName: string;
  nItemCount: integer;
  sItemName: string;
  nWhere: Integer;
  boChange: Boolean;
  StdItem: pTStdItem;
begin
  nItemCount := QuestActionInfo.nParam2;
  sItemName := QuestActionInfo.sParam1;
  nWhere := StrToIntDef(sItemName, -1);
  boChange := False;
  if nWhere in [Low(THumanUseItems)..High(THumanUseItems)] then begin
    if PlayObject.m_UseItems[nWhere].wIndex > 0 then begin
    
      StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nWhere].wIndex);
      if (StdItem <> nil) and (StdItem.NeedIdentify = 1) then
        AddGameLog(PlayObject, LOG_DELITEM, StdItem.Name, PlayObject.m_UseItems[nWhere].MakeIndex,
          PlayObject.m_UseItems[nWhere].Dura, m_sCharName, '0', '0', 'TakeW', @PlayObject.m_UseItems[nWhere]);

      PlayObject.SendDelItems(@PlayObject.m_UseItems[nWhere]);
      PlayObject.m_UseItems[nWhere].wIndex := 0;
      boChange := True;
    end;
  end else begin
    for i := Low(THumanUseItems) to High(THumanUseItems) do begin
      if nItemCount <= 0 then Exit;
      if PlayObject.m_UseItems[i].wIndex > 0 then begin
        sName := UserEngine.GetStdItemName(PlayObject.m_UseItems[i].wIndex);
        if CompareText(sName, sItemName) = 0 then begin

          StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[i].wIndex);
          if (StdItem <> nil) and (StdItem.NeedIdentify = 1) then
            AddGameLog(PlayObject, LOG_DELITEM, StdItem.Name, PlayObject.m_UseItems[i].MakeIndex,
              PlayObject.m_UseItems[i].Dura, m_sCharName, '0', '0', 'TakeW', @PlayObject.m_UseItems[i]);

          PlayObject.SendDelItems(@PlayObject.m_UseItems[i]);
          PlayObject.m_UseItems[i].wIndex := 0;
          Dec(nItemCount);
          boChange := True;
        end;
      end;
    end;
  end;
  if boChange then begin
    PlayObject.RecalcAbilitys();
    PlayObject.SendAbility;
    PlayObject.SendSubAbility;
    PlayObject.FeatureChanged();
  end;
end;

procedure TNormNpc.ActionOfTimeReCall(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_boTimeRecall := True;
  PlayObject.m_MoveEnvir := PlayObject.m_PEnvir;
  PlayObject.m_nMoveX := PlayObject.m_nCurrX;
  PlayObject.m_nMoveY := PlayObject.m_nCurrY;
  PlayObject.m_dwTimeRecallTick := GetTickCount + LongWord(QuestActionInfo.nParam1 * 60 * 1000);
end;

procedure TNormNpc.ActionOfNotLineAddPiont(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo); //离线挂机
{var
  dwAutoGetExpTime: LongWord;
  nAutoGetExpPoint: Integer;    }
begin
  { if not PlayObject.m_boNotOnlineAddExp then begin
     dwAutoGetExpTime := StrToIntDef(QuestActionInfo.sParam1, 0);
     nAutoGetExpPoint := StrToIntDef(QuestActionInfo.sParam2, 0);
     PlayObject.m_dwNotOnlineAddExpTime := dwAutoGetExpTime * 60 * 1000;
     PlayObject.m_nNotOnlineAddExpPoint := nAutoGetExpPoint;
     PlayObject.m_boNotOnlineAddExp := True;
     PlayObject.m_boStartAutoAddExpPoint := True;
     PlayObject.m_dwAutoAddExpPointTimeTick := GetTickCount;
     PlayObject.m_dwAutoAddExpPointTick := GetTickCount; //GetTickCount;
     PlayObject.m_boKickAutoAddExpUser := False;
     PlayObject.m_boAllowDeal := False; //禁止交易
     PlayObject.m_boAllowGuild := False; //禁止加入行会
     PlayObject.m_boAllowGroup := False; //禁止组队
     PlayObject.m_boCanMasterRecall := False; //禁止师徒传送
     PlayObject.m_boCanDearRecall := False; //禁止夫妻传送
     PlayObject.m_boAllowGuildReCall := False; //禁止行会合一
     PlayObject.m_boAllowGroupReCall := False; //禁止天地合一
     PlayObject.ClearViewRange;
   end;        }
end;

procedure TNormNpc.ActionOfKickNotLineAddPiont(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  {if PlayObject.m_boNotOnlineAddExp then begin
    PlayObject.m_boPlayOffLine := False;
    PlayObject.m_boReconnection := False;
    PlayObject.m_boSoftClose := True;
  end;       }
end;

procedure TNormNpc.ActionOfUnMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  PoseObject: TBaseObject;
begin
  if PlayObject.m_sDearName = '' then begin
    GotoLable(PlayObject, FGotoLable[nExeMarryFail], False);
    Exit;
  end;
  if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMARRY') = 0) and (CompareText(QuestActionInfo.sParam2, 'FORCE') = 0) then begin
    //强行离婚
    if (CompareText(QuestActionInfo.sParam2, 'FORCE') = 0) then begin
      UserEngine.SendBroadCastMsg('[' + m_sCharName + ']: ' + '我宣布 #7'
        + PlayObject.m_sCharName + '#7 与 #7' + PlayObject.m_sDearName + '#7 正式脱离夫妻关系.', t_Say);
      PoseHuman := UserEngine.GetPlayObject(PlayObject.m_sDearName);
      if PoseHuman <> nil then begin
        PoseHuman.m_sDearName := '';
        PoseHuman.m_DearHuman := nil;
        PoseHuman.RefShowName;
      end
      else begin
        g_UnMarryList.Lock;
        try
          g_UnMarryList.add(PlayObject.m_sDearName);
          SaveUnMarryList
        finally
          g_UnMarryList.UnLock;
        end;
      end;
      PlayObject.m_sDearName := '';
      PlayObject.m_DearHuman := nil;
      GotoLable(PlayObject, FGotoLable[nUnMarryEnd], False);
      PlayObject.RefShowName;
    end;
    Exit;
  end
  else begin
    PoseObject := PlayObject.GetPoseCreate;
    if PoseObject = nil then begin
      GotoLable(PlayObject, FGotoLable[nUnMasterCheckDir], False);
      Exit;
    end;
    if PoseObject.m_btRaceServer <> RC_PLAYOBJECT then begin
      GotoLable(PlayObject, FGotoLable[nUnMasterTypeErr], False);
      Exit;
    end;
    PoseHuman := TPlayObject(PoseObject);
    if PoseHuman <> nil then begin
      if PoseHuman = nil then begin
        GotoLable(PlayObject, FGotoLable[nUnMarryCheckDir], False);
        Exit;
      end;
      if QuestActionInfo.sParam1 = '' then begin
        if PoseHuman.GetPoseCreate = PlayObject then begin
          if (PlayObject.m_sDearName = PoseHuman.m_sCharName) then begin
            GotoLable(PlayObject, FGotoLable[nStartUnMarry], False);
            GotoLable(PoseHuman, FGotoLable[nStartUnMarry], False);
            Exit;
          end
          else begin
            GotoLable(PlayObject, FGotoLable[nExeMarryFail], False);
            Exit;
          end;
        end;
      end;
    end;
    if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMARRY') = 0) then begin
      if (QuestActionInfo.sParam2 = '') then begin
        if (PoseHuman <> nil) and (PlayObject.m_sDearName = PoseHuman.m_sCharName) then begin
          PlayObject.m_boStartUnMarry := True;
          if PlayObject.m_boStartUnMarry and PoseHuman.m_boStartUnMarry then begin
            UserEngine.SendBroadCastMsg('[' + m_sCharName + ']: ' + '我宣布 #7'
              + PlayObject.m_sCharName + '#7 与 #7' + PoseHuman.m_sCharName + '#7 正式脱离夫妻关系.', t_Say);
            PlayObject.m_sDearName := '';
            PoseHuman.m_sDearName := '';
            PlayObject.m_DearHuman := nil;
            PoseHuman.m_DearHuman := nil;
            PlayObject.m_boStartUnMarry := False;
            PoseHuman.m_boStartUnMarry := False;
            PlayObject.RefShowName;
            PoseHuman.RefShowName;
            GotoLable(PlayObject, FGotoLable[nUnMarryEnd], False);
            GotoLable(PoseHuman, FGotoLable[nUnMarryEnd], False);
          end
          else begin
            GotoLable(PlayObject, FGotoLable[nWateUnMarry], False);
          end;
        end
        else
          GotoLable(PlayObject, FGotoLable[nUnMarryCheckDir], False);
        Exit;
      end;
    end;
  end;
end;
{
procedure TNormNpc.ActionOfStartTakeGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
 PoseHuman: TPlayObject;
begin
 PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
 if (PoseHuman <> nil) and (PoseHuman.GetPoseCreate = PlayObject) and
   (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
   PlayObject.m_nDealGoldPose := 1;
   GotoLable(PlayObject, '@startdealgold', False);
 end
 else begin
   GotoLable(PlayObject, '@dealgoldpost', False);
 end;
end;         }

procedure TNormNpc.ActionOfSum(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14: integer;
begin
  Fn18 := 0;
  n14 := GetValNameNo(QuestActionInfo.sParam1);
  if n14 >= 0 then begin
    case n14 of //
      0..99: begin
          Fn18 := PlayObject.m_nVal[n14];
        end;
      2000..2999: begin
          Fn18 := g_Config.GlobalVal[n14 - 2000];
        end;
      200..209: begin
          Fn18 := PlayObject.m_DyVal[n14 - 200];
        end;
      300..399: begin
          Fn18 := PlayObject.m_nMval[n14 - 300];
        end;
      400..499: begin
          Fn18 := g_Config.GlobaDyMval[n14 - 400];
        end;
      5000..5999: begin
          Fn18 := PlayObject.m_nInteger[n14 - 5000];
        end;
      1000..1019: begin
          Fn18 := PlayObject.m_CustomVariable[n14 - 1000];
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSUM);
      end;
    end; // case
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSUM);
  end;
  Fn1C := 0;
  n14 := GetValNameNo(QuestActionInfo.sParam2);
  if n14 >= 0 then begin
    case n14 of //
      0..99: begin
          Fn1C := PlayObject.m_nVal[n14];
        end;
      2000..2999: begin
          Fn1C := g_Config.GlobalVal[n14 - 2000];
        end;
      200..209: begin
          Fn1C := PlayObject.m_DyVal[n14 - 200];
        end;
      300..399: begin
          Fn1C := PlayObject.m_nMval[n14 - 300];
        end;
      400..499: begin
          Fn1C := g_Config.GlobaDyMval[n14 - 400];
        end;
      5000..5999: begin
          Fn1C := PlayObject.m_nInteger[n14 - 5000];
        end;
      1000..1019: begin
          Fn1C := PlayObject.m_CustomVariable[n14 - 1000];
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSUM);
      end;
    end;
  end
  else begin
    //ScriptActionError(PlayObject, '', QuestActionInfo, sSUM);
  end;
  n14 := GetValNameNo(QuestActionInfo.sParam1);
  if n14 >= 0 then begin
    case n14 of //
      0..99: begin
          PlayObject.m_nVal[99] := PlayObject.m_nVal[99] + Fn18 + Fn1C;
        end;
      2000..2999: begin
          g_Config.GlobalVal[999] := g_Config.GlobalVal[999] + Fn18 + Fn1C;
        end;
      200..209: begin
          PlayObject.m_DyVal[9] := PlayObject.m_DyVal[9] + Fn18 + Fn1C;
        end;
      300..399: begin
          PlayObject.m_nMval[99] := PlayObject.m_nMval[99] + Fn18 + Fn1C;
        end;
      400..499: begin
          g_Config.GlobaDyMval[99] := g_Config.GlobaDyMval[99] + Fn18 + Fn1C;
        end;
      5000..5999: begin
          PlayObject.m_nInteger[999] := PlayObject.m_nInteger[999] + Fn18 + Fn1C;
        end;
      1000..1019: begin
          PlayObject.m_CustomVariable[19] := PlayObject.m_nInteger[19] + Fn18 + Fn1C;
          if n14 = 1000 then
            PlayObject.LiteraryChange(True);

          if g_boGameLogCustomVariable then begin
            AddGameLog(PlayObject, LOG_CUSTOMVARIABLE, SSTRING_CUSTOMVARIABLE, 19, PlayObject.m_CustomVariable[19], m_sCharName,
              'sum', IntToStr(Fn18) + '/' + IntToStr(Fn1C), '脚本sum', nil);
          end;
        end;
    end;
  end;
end;

procedure TNormNpc.ActionOfSendEMail(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sUserName, sText, sTitle: string;
  boAll: Boolean;
begin
  sUserName := QuestActionInfo.sParam1;
  sTitle := QuestActionInfo.sParam2;
  sText := QuestActionInfo.sParam3;
  boAll := False;
  if CompareText('All', sUserName) = 0 then
  begin
    boAll := True;
    sUserName := '';
  end
  else if CompareText('Self', sUserName) = 0 then
    sUserName := PlayObject.m_sCharName;
  sText := AnsiReplaceText(sText, '#10', #13#10);
  UserEMail.SendMail(sUserName, sText, sTitle, boAll);
end;

procedure TNormNpc.ActionOfSetHumIcon(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nIndex: Integer;
begin
  nIndex := StrToIntDef(QuestActionInfo.sParam1, -1);
  if not(nIndex in [Low(TIconInfos) .. High(TIconInfos)]) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETHUMICON);
    exit;
  end;

  PlayObject.m_IconInfo[nIndex].wIndex := StrToIntDef(QuestActionInfo.sParam2, 0);
  PlayObject.m_IconInfo[nIndex].wStart := StrToIntDef(QuestActionInfo.sParam3, 0);
  PlayObject.m_IconInfo[nIndex].btFrame := StrToIntDef(QuestActionInfo.sParam4, 0);
  PlayObject.m_IconInfo[nIndex].wFrameTime := StrToIntDef(QuestActionInfo.sParam5, 0);
  PlayObject.m_IconInfo[nIndex].bo01 := StrToIntDef(QuestActionInfo.sParam6, 0);
  PlayObject.m_IconInfo[nIndex].nX := StrToIntDef(QuestActionInfo.sParam7, 0);
  PlayObject.m_IconInfo[nIndex].nY := StrToIntDef(QuestActionInfo.sParam8, 0);
  PlayObject.RefIconInfo;
end;

procedure TNormNpc.ClearScript;
var
  III, IIII: Integer;
  i: Integer;
  //Script: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
begin
  for i := 0 to m_ScriptList.Count - 1 do begin
    SayingRecord := m_ScriptList.Items[i];
    for III := 0 to SayingRecord.ProcedureList.Count - 1 do begin
      SayingProcedure := SayingRecord.ProcedureList.Items[III];
      for IIII := 0 to SayingProcedure.ConditionList.Count - 1 do begin
        if pTQuestConditionInfo(SayingProcedure.ConditionList.Items[IIII]).TCmdList <> nil then
          FreeAndNil(pTQuestConditionInfo(SayingProcedure.ConditionList.Items[IIII]).TCmdList);
        DisPose(pTQuestConditionInfo(SayingProcedure.ConditionList.Items[IIII]));
      end;
      for IIII := 0 to SayingProcedure.ActionList.Count - 1 do begin
        if pTQuestActionInfo(SayingProcedure.ActionList.Items[IIII]).TCmdList <> nil then
          FreeAndNil(pTQuestActionInfo(SayingProcedure.ActionList.Items[IIII]).TCmdList);
        DisPose(pTQuestActionInfo(SayingProcedure.ActionList.Items[IIII]));
      end;
      for IIII := 0 to SayingProcedure.ElseActionList.Count - 1 do begin
        if pTQuestActionInfo(SayingProcedure.ElseActionList.Items[IIII]).TCmdList <> nil then
          FreeAndNil(pTQuestActionInfo(SayingProcedure.ElseActionList.Items[IIII]).TCmdList);
        DisPose(pTQuestActionInfo(SayingProcedure.ElseActionList.Items[IIII]));
      end;
      SayingProcedure.SayNewLabelList.Free;
      SayingProcedure.ElseSayNewLabelList.Free;
      SayingProcedure.SayOldLabelList.Free;
      SayingProcedure.ElseSayOldLabelList.Free;
      SayingProcedure.ConditionList.Free;
      SayingProcedure.ActionList.Free;
      SayingProcedure.ElseActionList.Free;
      DisPose(SayingProcedure);
    end; // for
    SayingRecord.ProcedureList.Free;
    DisPose(SayingRecord);
  end; // for
  m_ScriptList.Clear;
end;

procedure TNormNpc.Click(PlayObject: TPlayObject); //0049EC18
begin
  PlayObject.m_nScriptGotoCount := 0;
  PlayObject.m_nScriptGoBackLable := 0;
  PlayObject.m_nScriptCurrLable := 0;
  PlayObject.m_boResetLabel := False;
  GotoLable(PlayObject, 0, False);
end;

procedure TNormNpc.ConditionOfCheck(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
var
  n18, n10: integer;
begin
  Result := True;
  n18 := StrToIntDef(QuestConditionInfo.sParam2, 0);
  n10 := PlayObject.GetQuestFlagStatus(QuestConditionInfo.sParam1, 0);
  if n10 = 0 then begin
    if n18 <> 0 then
      Result := False;
  end
  else begin
    if n18 = 0 then
      Result := False;
  end;
end;

procedure TNormNpc.ConditionOfCheckMission(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  n18, n10: integer;
begin
  Result := True;
  n18 := StrToIntDef(QuestConditionInfo.sParam2, 0);
  n10 := PlayObject.GetMissionFlagStatus(QuestConditionInfo.sParam1, 0);
  if n10 = 0 then begin
    if n18 <> 0 then
      Result := False;
  end
  else begin
    if n18 = 0 then
      Result := False;
  end;
end;

procedure TNormNpc.ConditionOfCheckAccountIPList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  i: Integer;
  LoadList: TStringList;
  sCharName: string;
  sCharAccount: string;
  sCharIPaddr: string;
  sLine: string;
  sName: string;
  sIPaddr: string;
begin
  Result := False;
  LoadList := TStringList.Create;
  try
    sCharName := PlayObject.m_sCharName;
    sCharAccount := PlayObject.m_sUserID;
    sCharIPaddr := PlayObject.m_sIPaddr;

    if FileExists(g_Config.sGameDataDir + QuestConditionInfo.sParam1) then begin
      LoadList.LoadFromFile(g_Config.sGameDataDir + QuestConditionInfo.sParam1);
      for i := 0 to LoadList.Count - 1 do begin
        sLine := LoadList.Strings[i];
        if sLine[1] = ';' then
          Continue;
        sIPaddr := GetValidStr3(sLine, sName, [' ', '/', #9]);
        sIPaddr := Trim(sIPaddr);
        if (sName = sCharAccount) and (sIPaddr = sCharIPaddr) then begin
          Result := True;
          break;
        end;
      end;
    end
    else begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKACCOUNTIPLIST);
    end;
  finally
    LoadList.Free
  end;
end;

procedure TNormNpc.ConditionOfCheckAccountList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := CheckStringList(PlayObject.m_sUserID, m_sPath + QuestConditionInfo.sParam1);
end;

procedure TNormNpc.ConditionOfCheckBagGage(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var
  Result: Boolean);
begin
  Result := True;
  if PlayObject.IsEnoughBag then begin
    if QuestConditionInfo.sParam1 <> '' then begin
      Result := False;
      if UserEngine.GetStdItem(QuestConditionInfo.sParam1) <> nil then begin
        Result := True;
      end;
    end;
  end
  else
    Result := False;
end;

procedure TNormNpc.ConditionOfCheckBagSize(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nSize: Integer;
begin
  Result := False;
  nSize := QuestConditionInfo.nParam1;
  if (nSize <= 0) or (nSize > PlayObject.m_nMaxItemListCount) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKBAGSIZE);
    Exit;
  end;
  if PlayObject.m_ItemList.Count + nSize <= PlayObject.m_nMaxItemListCount then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckBonusPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
{var
  nTotlePoint, nCount: Integer;
  cMethod: Char; }
begin
  Result := False;
  {nTotlePoint := PlayObject.m_BonusAbil.DC +
    PlayObject.m_BonusAbil.MC +
    PlayObject.m_BonusAbil.SC +
    PlayObject.m_BonusAbil.AC +
    PlayObject.m_BonusAbil.MAC +
    PlayObject.m_BonusAbil.HP +
    PlayObject.m_BonusAbil.MP +
    PlayObject.m_BonusAbil.Hit +
    PlayObject.m_BonusAbil.Speed +
    PlayObject.m_BonusAbil.X2;
  nTotlePoint := nTotlePoint + PlayObject.m_nBonusPoint;
  cMethod := QuestConditionInfo.sParam1[1];
  nCount := QuestConditionInfo.nParam2;
  case cMethod of
    '=': if nTotlePoint = nCount then
        Result := True;
    '>': if nTotlePoint > nCount then
        Result := True;
    '<': if nTotlePoint < nCount then
        Result := True;
  else if nTotlePoint >= nCount then
    Result := True;
  end;  }
end;

procedure TNormNpc.ConditionOfCheckHP(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethodMin, cMethodMax: Char;
  nMin, nMax: Integer;
  dwMin, dwMax: Integer; //Jay BigHP
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if PlayObject.m_WAbil.MaxHP = dwMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if PlayObject.m_WAbil.MaxHP > dwMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if PlayObject.m_WAbil.MaxHP < dwMax then begin
            Result := True;
          end;
        end;
    else begin
        if PlayObject.m_WAbil.MaxHP >= dwMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  if not(TryStrToInt(QuestConditionInfo.sParam2, nMin) and TryStrToInt(QuestConditionInfo.sParam4, nMax)) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHP);
    Exit;
  end;
  dwMin := nMin;
  dwMax := nMax;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  case cMethodMin of
    '=': begin
        if (PlayObject.m_WAbil.HP = dwMin) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (PlayObject.m_WAbil.HP > dwMin) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (PlayObject.m_WAbil.HP < dwMin) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (PlayObject.m_WAbil.HP >= dwMin) then begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckHum(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := UserEngine.GetMapHuman(QuestConditionInfo.sParam1) >= QuestConditionInfo.nParam2;
end;

procedure TNormNpc.ConditionOfCheckMP(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  dwMIN, dwMax: Integer; //Jay BigHP
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if PlayObject.m_WAbil.MaxMP = dwMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if PlayObject.m_WAbil.MaxMP > dwMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if PlayObject.m_WAbil.MaxMP < dwMax then begin
            Result := True;
          end;
        end;
    else begin
        if PlayObject.m_WAbil.MaxMP >= dwMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  if not(TryStrToInt(QuestConditionInfo.sParam2, nMin) and TryStrToInt(QuestConditionInfo.sParam4, nMax)) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMP);
    Exit;
  end;
  dwMin := nMin;
  dwMax := nMax;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  case cMethodMin of
    '=': begin
        if (PlayObject.m_WAbil.MP = dwMin) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (PlayObject.m_WAbil.MP > dwMin) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (PlayObject.m_WAbil.MP < dwMin) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (PlayObject.m_WAbil.MP >= dwMin) then begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckDC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if HiWord(PlayObject.m_WAbil.DC) = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if HiWord(PlayObject.m_WAbil.DC) > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if HiWord(PlayObject.m_WAbil.DC) < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if HiWord(PlayObject.m_WAbil.DC) >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  nMIN := StrToIntDef(QuestConditionInfo.sParam2, -1);
  nMax := StrToIntDef(QuestConditionInfo.sParam4, -1);
  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKDC);
    Exit;
  end;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  case cMethodMin of
    '=': begin
        if (LoWord(PlayObject.m_WAbil.DC) = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (LoWord(PlayObject.m_WAbil.DC) > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (LoWord(PlayObject.m_WAbil.DC) < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (LoWord(PlayObject.m_WAbil.DC) >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckDura(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
var
  n1C, nMaxDura, nDura: Integer;
begin
  Result := True;
  PlayObject.QuestCheckItem(QuestConditionInfo.sParam1, n1C, nMaxDura, nDura);
  if ROUND(nDura / 1000) < QuestConditionInfo.nParam2 then
    Result := False;
end;

procedure TNormNpc.ConditionOfCheckMC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if HiWord(PlayObject.m_WAbil.MC) = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if HiWord(PlayObject.m_WAbil.MC) > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if HiWord(PlayObject.m_WAbil.MC) < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if HiWord(PlayObject.m_WAbil.MC) >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  nMIN := StrToIntDef(QuestConditionInfo.sParam2, -1);
  nMax := StrToIntDef(QuestConditionInfo.sParam4, -1);
  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMC);
    Exit;
  end;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  case cMethodMin of
    '=': begin
        if (LoWord(PlayObject.m_WAbil.MC) = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (LoWord(PlayObject.m_WAbil.MC) > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (LoWord(PlayObject.m_WAbil.MC) < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (LoWord(PlayObject.m_WAbil.MC) >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckSC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if HiWord(PlayObject.m_WAbil.SC) = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if HiWord(PlayObject.m_WAbil.SC) > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if HiWord(PlayObject.m_WAbil.SC) < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if HiWord(PlayObject.m_WAbil.SC) >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  nMIN := StrToIntDef(QuestConditionInfo.sParam2, -1);
  nMax := StrToIntDef(QuestConditionInfo.sParam4, -1);
  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSC);
    Exit;
  end;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  case cMethodMin of
    '=': begin
        if (LoWord(PlayObject.m_WAbil.SC) = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (LoWord(PlayObject.m_WAbil.SC) > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (LoWord(PlayObject.m_WAbil.SC) < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (LoWord(PlayObject.m_WAbil.SC) >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckExp(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethod: Char;
  dwExp: LongWord;
  //  nExp: Integer;
begin
  Result := False;
  dwExp := StrToIntDef(QuestConditionInfo.sParam2, 0);
  if QuestConditionInfo.sParam2 = '' then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKEXP);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_Abil.Exp = dwExp then
        Result := True;
    '>': if PlayObject.m_Abil.Exp > dwExp then
        Result := True;
    '<': if PlayObject.m_Abil.Exp < dwExp then
        Result := True;
  else if PlayObject.m_Abil.Exp >= dwExp then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckFlourishPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  Result := False;
  nPoint := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKFLOURISHPOINT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nFlourishingPoint = nPoint then
        Result := True;
    '>': if Guild.nFlourishingPoint > nPoint then
        Result := True;
    '<': if Guild.nFlourishingPoint < nPoint then
        Result := True;
  else if Guild.nFlourishingPoint >= nPoint then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckChiefItemCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
{var
  cMethod: Char;
  nCount: Integer;
  Guild: TGuild;   }
begin
  {Result := False;
  nCount := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo,
      sSC_CHECKFLOURISHPOINT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nChiefItemCount = nCount then
        Result := True;
    '>': if Guild.nChiefItemCount > nCount then
        Result := True;
    '<': if Guild.nChiefItemCount < nCount then
        Result := True;
  else if Guild.nChiefItemCount >= nCount then
    Result := True;
  end;    }
end;

procedure TNormNpc.ConditionOfCHECKCONTAINSTEXTLIST(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := CheckAnsiContainsTextList(QuestConditionInfo.sParam1, m_sPath + QuestConditionInfo.sParam2);
end;

procedure TNormNpc.ConditionOfCheckGuildAuraePoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  Result := False;
  nPoint := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKAURAEPOINT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nActivityPoint = nPoint then
        Result := True;
    '>': if Guild.nActivityPoint > nPoint then
        Result := True;
    '<': if Guild.nActivityPoint < nPoint then
        Result := True;
  else if Guild.nActivityPoint >= nPoint then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckGuildBuildPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  Result := False;
  nPoint := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKBUILDPOINT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nBuildPoint = nPoint then
        Result := True;
    '>': if Guild.nBuildPoint > nPoint then
        Result := True;
    '<': if Guild.nBuildPoint < nPoint then
        Result := True;
  else if Guild.nBuildPoint >= nPoint then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfIsOnHouse(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := PlayObject.m_boOnHorse;
end;

procedure TNormNpc.ConditionOfCheckKillMobName(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := CompareText(QuestConditionInfo.sParam1, PlayObject.m_sLastKillMonName) = 0;
end;

procedure TNormNpc.ConditionOfCheckMapSameMonCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  sMapName, sMonName: string;
  nCount: Integer;
  nMapRangeCount: Integer;
  Envir: TEnvirnoment;
  cMethod: Char;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  sMonName := QuestConditionInfo.sParam2; 
  nCount := StrToIntDef(QuestConditionInfo.sParam4, -1);
  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (nCount < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMAPSAMEMONCOUNT);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam3[1];
  nMapRangeCount := UserEngine.GetMapMonster(sMonName, Envir, nil);
  case cMethod of
    '=': if nMapRangeCount = nCount then Result := True;
    '>': if nMapRangeCount > nCount then Result := True;
    '<': if nMapRangeCount < nCount then Result := True;
  else if nMapRangeCount >= nCount then Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckHitMonName(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  sTargetName: string;
begin
  Result := False;
  if PlayObject.m_TargetCret = nil then
    exit;
  sTargetName := QuestConditionInfo.sParam1;
  Result := CompareText(sTargetName, PlayObject.m_TargetCret.m_sCharName) = 0;
end;

procedure TNormNpc.ConditionOfCheckHorseLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nLevel: Integer;
  cMethod: Char;
begin
  Result := False;
  nLevel := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if PlayObject.m_UseItems[U_House].wIndex <= 0 then exit;
  if nLevel < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHORSELEVEL);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_UseItems[U_House].btLevel = nLevel then Result := True;
    '>': if PlayObject.m_UseItems[U_House].btLevel > nLevel then Result := True;
    '<': if PlayObject.m_UseItems[U_House].btLevel < nLevel then Result := True;
  else if PlayObject.m_UseItems[U_House].btLevel >= nLevel then Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckStrengthenCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  I: Integer;
  StdItem: pTStdItem;
  nStrengthenCount, nCount: Integer;
  cMethod: Char;
begin
  Result := False;
  nCount := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSTRENGTHENCOUNT);
    Exit;
  end;
  nStrengthenCount := 0;
  for i := Low(THumanUseItems) to High(THumanUseItems) do begin
    if (PlayObject.m_UseItems[i].wIndex <= 0) or ((PlayObject.m_UseItems[i].Dura <= 0)) then Continue;
    StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[i].wIndex);
    if StdItem = nil then Continue;
    if (sm_ArmingStrong in StdItem.StdModeEx) or (StdItem.StdMode = tm_Light) then begin
      Inc(nStrengthenCount, PlayObject.m_UseItems[i].Value.StrengthenInfo.btStrengthenCount);
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nStrengthenCount = nCount then Result := True;
    '>': if nStrengthenCount > nCount then Result := True;
    '<': if nStrengthenCount < nCount then Result := True;
  else if nStrengthenCount >= nCount then Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckGuildIsFull(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  Guild: TGuild;
begin
  Result := False;
  Guild := g_GuildManager.FindGuild(QuestConditionInfo.sParam1);
  if Guild = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGUILDISFULL);
    Exit;
  end;
  Result := not Guild.IsFull;
end;

procedure TNormNpc.ConditionOfCheckGuildList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var
  Result: Boolean);
begin
  Result := True;
  if PlayObject.m_MyGuild <> nil then begin
    if not CheckStringList(TGuild(PlayObject.m_MyGuild).m_sGuildName, m_sPath + QuestConditionInfo.sParam1) then
      Result := False;
  end
  else
    Result := False;
end;

procedure TNormNpc.ConditionOfCheckStabilityPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  Result := False;
  nPoint := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSTABILITYPOINT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nStabilityPoint = nPoint then
        Result := True;
    '>': if Guild.nStabilityPoint > nPoint then
        Result := True;
    '<': if Guild.nStabilityPoint < nPoint then
        Result := True;
  else if Guild.nStabilityPoint >= nPoint then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckTextList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var
  Result: Boolean);
begin
  Result := CheckStringList(QuestConditionInfo.sParam1, m_sPath + QuestConditionInfo.sParam2);
end;

{
procedure TNormNpc.ConditionOfCheckGameGold(PlayObject: TPlayObject;
 QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
 cMethod: Char;
 nGameGold: Integer;
begin
 Result := False;
 nGameGold := StrToIntDef(QuestConditionInfo.sParam2, -1);
 if nGameGold < 0 then begin
   ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEGOLD);
   Exit;
 end;
 cMethod := QuestConditionInfo.sParam1[1];
 case cMethod of
   '=': if PlayObject.m_nGameGold = nGameGold then
       Result := True;
   '>': if PlayObject.m_nGameGold > nGameGold then
       Result := True;
   '<': if PlayObject.m_nGameGold < nGameGold then
       Result := True;
 else if PlayObject.m_nGameGold >= nGameGold then
   Result := True;
 end;
end;           }

procedure TNormNpc.ConditionOfCheckGamePoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethod: Char;
  nGamePoint: Integer;
begin
  Result := False;
  nGamePoint := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nGamePoint < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEPOINT);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nGameGold = nGamePoint then
        Result := True;
    '>': if PlayObject.m_nGameGold > nGamePoint then
        Result := True;
    '<': if PlayObject.m_nGameGold < nGamePoint then
        Result := True;
  else if PlayObject.m_nGameGold >= nGamePoint then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckGold(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  if CompareText(QuestConditionInfo.sParam2, 'BIND') = 0 then begin
    Result := PlayObject.m_nBindGold >= QuestConditionInfo.nParam1;
  end
  else
    Result := PlayObject.m_nGold >= QuestConditionInfo.nParam1;
end;

procedure TNormNpc.ConditionOfCheckGroupCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethod: Char;
  nCount: Integer;
begin
  Result := False;
  if PlayObject.m_GroupOwner = nil then
    Exit;

  nCount := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGROUPCOUNT);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_GroupOwner.m_GroupMembers.Count = nCount then
        Result := True;
    '>': if PlayObject.m_GroupOwner.m_GroupMembers.Count > nCount then
        Result := True;
    '<': if PlayObject.m_GroupOwner.m_GroupMembers.Count < nCount then
        Result := True;
  else if PlayObject.m_GroupOwner.m_GroupMembers.Count >= nCount then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckHaveGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  //  Result:=PlayObject.m_MyGuild = nil;
  Result := PlayObject.m_MyGuild <> nil; // 01-16 更正检查结果反了
end;

procedure TNormNpc.ConditionOfCheckInMapRange(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  sMapName: string;
  nX, nY, nRange: Integer;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  nX := StrToIntDef(QuestConditionInfo.sParam2, -1);
  nY := StrToIntDef(QuestConditionInfo.sParam3, -1);
  nRange := StrToIntDef(QuestConditionInfo.sParam4, -1);
  if (sMapName = '') or (nX < 0) or (nY < 0) or (nRange < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKINMAPRANGE);
    Exit;
  end;
  if CompareText(PlayObject.m_sMapName, sMapName) <> 0 then
    Exit;
  if (abs(PlayObject.m_nCurrX - nX) <= nRange) and (abs(PlayObject.m_nCurrY - nY) <= nRange) then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckIPList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := CheckStringList(PlayObject.m_sIPaddr, m_sPath + QuestConditionInfo.sParam1);
end;

procedure TNormNpc.ConditionOfCheckIsAttackGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISATTACKGUILD);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then
    Exit;
  Result := TUserCastle(m_Castle).IsAttackGuild(TGuild(PlayObject.m_MyGuild));
end;

procedure TNormNpc.ConditionOfCheckCastleChageDay(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nDay: Integer;
  cMethod: Char;
  nChangeDay: Integer;
begin
  Result := False;
  nDay := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if (nDay < 0) or (m_Castle = nil) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CASTLECHANGEDAY);
    Exit;
  end;
  nChangeDay := GetDayCount(Now, TUserCastle(m_Castle).m_ChangeDate);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nChangeDay = nDay then
        Result := True;
    '>': if nChangeDay > nDay then
        Result := True;
    '<': if nChangeDay < nDay then
        Result := True;
  else if nChangeDay >= nDay then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckCastleWarDay(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nDay: Integer;
  cMethod: Char;
  nWarDay: Integer;
begin
  Result := False;
  nDay := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if (nDay < 0) or (m_Castle = nil) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CASTLEWARDAY);
    Exit;
  end;
  nWarDay := GetDayCount(Now, TUserCastle(m_Castle).m_WarDate);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nWarDay = nDay then
        Result := True;
    '>': if nWarDay > nDay then
        Result := True;
    '<': if nWarDay < nDay then
        Result := True;
  else if nWarDay >= nDay then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckCastleDoorStatus(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  //nDay: Integer;
  //  cMethod: Char;
  nDoorStatus: Integer;
  CastleDoor: TCastleDoor;
begin
  Result := False;
  //nDay := StrToIntDef(QuestConditionInfo.sParam2, -1);
  nDoorStatus := -1;
  if CompareText(QuestConditionInfo.sParam1, '损坏') = 0 then
    nDoorStatus := 0;
  if CompareText(QuestConditionInfo.sParam1, '开启') = 0 then
    nDoorStatus := 1;
  if CompareText(QuestConditionInfo.sParam1, '关闭') = 0 then
    nDoorStatus := 2;

  if {(nDay < 0) or}(m_Castle = nil) or (nDoorStatus < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLEDOOR);
    Exit;
  end;
  CastleDoor := TCastleDoor(TUserCastle(m_Castle).m_MainDoor.BaseObject);

  case nDoorStatus of
    0: if CastleDoor.m_boDeath then
        Result := True;
    1: if CastleDoor.m_boOpened then
        Result := True;
    2: if not CastleDoor.m_boOpened then
        Result := True;
  end;
end;
{
procedure TNormNpc.ConditionOfCheckIsAttackAllyGuild(
 PlayObject: TPlayObject;
 QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
 Result := False;
 if m_Castle = nil then begin
   ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISATTACKALLYGUILD);
   Exit;
 end;
 if PlayObject.m_MyGuild = nil then
   Exit;
 Result := TUserCastle(m_Castle).IsAttackAllyGuild(TGUild(PlayObject.m_MyGuild));
end;       }

procedure TNormNpc.ConditionOfCheckIsDefenseAllyGuild(
  PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo,
      sSC_ISDEFENSEALLYGUILD);
    Exit;
  end;

  if PlayObject.m_MyGuild = nil then
    Exit;
  Result := TUserCastle(m_Castle).IsDefenseAllyGuild(TGuild(PlayObject.m_MyGuild));
end;

procedure TNormNpc.ConditionOfCheckIsDefenseGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISDEFENSEGUILD);
    Exit;
  end;

  if PlayObject.m_MyGuild = nil then
    Exit;
  Result := TUserCastle(m_Castle).IsDefenseGuild(TGuild(PlayObject.m_MyGuild));
end;

procedure TNormNpc.ConditionOfCheckIsCastleaGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  //  if (PlayObject.m_MyGuild <> nil) and (UserCastle.m_MasterGuild = PlayObject.m_MyGuild) then
  if g_CastleManager.IsCastleMember(PlayObject) <> nil then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckIsCastleMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  //if PlayObject.IsGuildMaster and (UserCastle.m_MasterGuild = PlayObject.m_MyGuild) then
  if PlayObject.IsGuildMaster and (g_CastleManager.IsCastleMember(PlayObject) <> nil) then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckIsGuildMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := PlayObject.IsGuildMaster;
end;

procedure TNormNpc.ConditionOfCheckIsMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  if (PlayObject.m_MasterList.Count > 0) and (PlayObject.m_boMaster) then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckListCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := True;
end;

procedure TNormNpc.ConditionOfCheckItem(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
var
  n1C, nMaxDura, nDura: Integer;
begin
  Result := True;
  PlayObject.QuestCheckItem(QuestConditionInfo.sParam1, n1C, nMaxDura, nDura);
  if n1C < QuestConditionInfo.nParam2 then
    Result := False;
end;

procedure TNormNpc.ConditionOfCheckItemAddValue(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  //  i: Integer;
  nWhere: Integer;
  nAddAllValue, nAddValue: Integer;
  UserItem: pTUserItem;
  cMethod: Char;
  nValType: Integer;
begin
  Result := False;
  nWhere := StrToIntDef(QuestConditionInfo.sParam1, -3);
  nValType := StrToIntDef(QuestConditionInfo.sParam2, -1);
  nAddValue := StrToIntDef(QuestConditionInfo.sParam4, -1);
  if (nValType < 0) or (nValType >= (tb_Count + 2)) or (nWhere < -2) or (nWhere > High(THumanUseItems)) or (nAddValue < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMADDVALUE);
    exit;
  end;
  if (nWhere < 0) then
  begin
    nWhere := (nWhere * -1) - 1;
    if (nWhere >= 0) and (nWhere < PlayObject.m_HookItemEx.Count) then
      UserItem := PlayObject.m_HookItemEx[nWhere]
    else
      UserItem := nil;
  end
  else
    UserItem := @PlayObject.m_UseItems[nWhere];
  if (UserItem = nil) or (UserItem.wIndex = 0) then
    exit;
  cMethod := QuestConditionInfo.sParam3[1];
  if nValType >= tb_Count then
  begin
    if nValType = 27 then
      nAddAllValue := UserItem.EffectValue.btColor
    else if nValType = 28 then
      nAddAllValue := UserItem.EffectValue.btEffect
    else
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMADDVALUE);
      exit;
    end;
  end
  else
    nAddAllValue := UserItem.Value.btValue[nValType];
  case cMethod of
    '=':
      if nAddAllValue = nAddValue then
        Result := True;
    '>':
      if nAddAllValue > nAddValue then
        Result := True;
    '<':
      if nAddAllValue < nAddValue then
        Result := True;
  else
    if nAddAllValue >= nAddValue then
      Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckMissionCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nCount, nCheckCount: Integer;
  I: Integer;
begin
  Result := False;
  nCheckCount := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nCheckCount = -1 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMISSIONCOUNT);
    exit;
  end;
  nCount := 0;
  for I := Low(PlayObject.m_MissionInfo) to High(PlayObject.m_MissionInfo) do begin
    if PlayObject.m_MissionInfo[I].sMissionName = '' then
      Inc(nCount);
  end;
  case QuestConditionInfo.sParam1[1] of
    '=': if nCount = nCheckCount then
        Result := True;
    '>': if nCount > nCheckCount then
        Result := True;
    '<': if nCount < nCheckCount then
        Result := True;
  else if nCount >= nCheckCount then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckMissionKillMonCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nCheckCount: Integer;
  nCount, nIdx: Integer;
begin
  Result := False;
  nCheckCount := StrToIntDef(QuestConditionInfo.sParam4, -1);
  if nCheckCount = -1 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMISSIONKILLMONCOUNT);
    exit;
  end;

  if QuestConditionInfo.nParam1 in [Low(PlayObject.m_MissionIndex)..High(PlayObject.m_MissionIndex)] then begin
    nIdx := PlayObject.m_MissionIndex[QuestConditionInfo.nParam1];
    if (nIdx in [Low(PlayObject.m_MissionInfo)..High(PlayObject.m_MissionInfo)]) then begin
      if (QuestConditionInfo.sParam2 = '2') then
        nCount := PlayObject.m_MissionInfo[nIdx].btKillCount2
      else
        nCount := PlayObject.m_MissionInfo[nIdx].btKillCount1;
    end
    else begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMISSIONKILLMONCOUNT);
      exit;
    end;
    case QuestConditionInfo.sParam3[1] of
      '=': if nCount = nCheckCount then
          Result := True;
      '>': if nCount > nCheckCount then
          Result := True;
      '<': if nCount < nCheckCount then
          Result := True;
    else if nCount >= nCheckCount then
      Result := True;
    end;
  end
  else begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMISSIONKILLMONCOUNT);
  end;
end;

procedure TNormNpc.ConditionOfCheckGroupJobCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  GroupObject: TBaseObject;
  I, nCount, nCheckJob, nCheckCount, nLevel: Integer;
begin
  Result := False;
  nCount := 0;
  nCheckJob := StrToIntDef(QuestConditionInfo.sParam1, -1);
  nCheckCount := StrToIntDef(QuestConditionInfo.sParam3, -1);
  nLevel := StrToIntDef(QuestConditionInfo.sParam5, 0);
  if (not (nCheckJob in [0..2])) or (nCheckCount < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGROUPJOBCOUNT);
    exit;
  end;
  if PlayObject.m_GroupOwner <> nil then begin
    for I := 0 to PlayObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
      GroupObject := TBaseObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[I]);
      if (GroupObject <> nil) and (not GroupObject.m_boGhost) then begin
        if GroupObject.m_btJob = nCheckJob then begin
          if nLevel > 0 then begin
            case QuestConditionInfo.sParam4[1] of
              '=': if GroupObject.m_Abil.Level = nLevel then
                  Inc(nCount);
              '>': if GroupObject.m_Abil.Level > nLevel then
                  Inc(nCount);
              '<': if GroupObject.m_Abil.Level < nLevel then
                  Inc(nCount);
            else if GroupObject.m_Abil.Level >= nLevel then
              Inc(nCount);
            end;
          end
          else
            Inc(nCount);
        end;
      end;
    end;
    case QuestConditionInfo.sParam2[1] of
      '=': if nCount = nCheckCount then
          Result := True;
      '>': if nCount > nCheckCount then
          Result := True;
      '<': if nCount < nCheckCount then
          Result := True;
    else if nCount >= nCheckCount then
      Result := True;
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckArithmometerCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nCheckCount: Integer;
begin
  Result := False;
  nCheckCount := StrToIntDef(QuestConditionInfo.sParam3, -1);
  if nCheckCount = -1 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKARITHMOMETERCOUNT);
    exit;
  end;
  if QuestConditionInfo.nParam1 in [Low(PlayObject.m_MissionArithmometer)..High(PlayObject.m_MissionArithmometer)] then begin
    case QuestConditionInfo.sParam2[1] of
      '=': if PlayObject.m_MissionArithmometer[QuestConditionInfo.nParam1] = nCheckCount then
          Result := True;
      '>': if PlayObject.m_MissionArithmometer[QuestConditionInfo.nParam1] > nCheckCount then
          Result := True;
      '<': if PlayObject.m_MissionArithmometer[QuestConditionInfo.nParam1] < nCheckCount then
          Result := True;
    else if PlayObject.m_MissionArithmometer[QuestConditionInfo.nParam1] >= nCheckCount then
      Result := True;
    end;
  end
  else
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKARITHMOMETERCOUNT);
end;

procedure TNormNpc.ConditionOfCanMoveEctype(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  sFBName: string;
begin
  Result := False;
  sFBName := QuestConditionInfo.sParam1;
  if (sFBName = '') then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CANMOVEECTYPE);
    Exit;
  end;
  if (PlayObject.m_GroupOwner <> nil) and (TPlayObject(PlayObject.m_GroupOwner).m_FBEnvir <> nil) and
    (CompareText(sFBName, TPlayObject(PlayObject.m_GroupOwner).m_FBEnvir.m_sFBName) = 0) then
    Result := True
  else if (PlayObject.m_FBEnvir <> nil) and (CompareText(sFBName, PlayObject.m_FBEnvir.m_sFBName) = 0) then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckEctypeMonCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  sMAP: string;
  Envir: TEnvirnoment;
  mon: TBaseObject;
  I, nCheckCount, nMonCount: Integer;
begin
  Result := False;
  sMAP := QuestConditionInfo.sParam1;
  nCheckCount := StrToIntDef(QuestConditionInfo.sParam3, -1);
  if (sMAP = '') or (nCheckCount < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKECTYPEMONCOUNT);
    Exit;
  end;
  if CompareText(sMAP, 'NPCMAP') = 0 then
    Envir := m_PEnvir
  else if CompareText(sMAP, 'FBMAP') = 0 then
    Envir := PlayObject.m_FBEnvir
  else if CompareText(sMAP, 'SELF') = 0 then
    Envir := PlayObject.m_PEnvir
  else
    Envir := g_MapManager.FindMap(sMAP);
  if (Envir <> nil) then begin
    nMonCount := 0;
    for I := 0 to Envir.m_MonsterList.Count - 1 do begin
      mon := Envir.m_MonsterList[I];
      if not (mon.m_boGhost or mon.m_boDeath or (mon.m_Master <> nil)) then
        Inc(nMonCount);
    end;
    case QuestConditionInfo.sParam2[1] of
      '=': if nMonCount = nCheckCount then
          Result := True;
      '>': if nMonCount > nCheckCount then
          Result := True;
      '<': if nMonCount < nCheckCount then
          Result := True;
    else if nMonCount >= nCheckCount then
      Result := True;
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckEMailOK(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo;
  var Result: Boolean);
begin
  Result := PlayObject.m_nCheckEMail > 0;
end;

procedure TNormNpc.ConditionOfCheckMapQuest(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  sMAP: string;
  Envir: TEnvirnoment;
  n14, n18, n10: integer;
begin
  Result := False;
  sMAP := QuestConditionInfo.sParam1;
  n14 := StrToIntDef(QuestConditionInfo.sParam2, 0);
  n18 := StrToIntDef(QuestConditionInfo.sParam3, 0);
  if (sMAP = '') then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMAPQUEST);
    Exit;
  end;
  if CompareText(sMAP, 'NPCMAP') = 0 then
    Envir := m_PEnvir
  else if CompareText(sMAP, 'FBMAP') = 0 then
    Envir := PlayObject.m_FBEnvir
  else if CompareText(sMAP, 'SELF') = 0 then
    Envir := PlayObject.m_PEnvir
  else
    Envir := g_MapManager.FindMap(sMAP);
  if (Envir <> nil) then begin
    n10 := Envir.GetQuestFalgStatus(n14);
    if n10 = 0 then begin
      if n18 = 0 then
        Result := True;
    end
    else begin
      if n18 <> 0 then
        Result := True;
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckCastleState(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  if m_Castle = nil then
    Exit;
  with TUserCastle(m_Castle) do begin
    if CompareText(QuestConditionInfo.sParam1, 'DOOR') = 0 then begin
      if TCastleDoor(m_MainDoor.BaseObject) <> nil then begin
        with TCastleDoor(m_MainDoor.BaseObject) do
          Result := m_WAbil.HP >= m_WAbil.MAXHP;
      end;
    end
    else if CompareText(QuestConditionInfo.sParam1, 'WALL') = 0 then begin
      case QuestConditionInfo.nParam2 of
        1: Result := m_LeftWall.BaseObject.m_WAbil.HP >= m_LeftWall.BaseObject.m_WAbil.MAXHP;
        2: Result := m_CenterWall.BaseObject.m_WAbil.HP >= m_CenterWall.BaseObject.m_WAbil.MAXHP;
        3: Result := m_RightWall.BaseObject.m_WAbil.HP >= m_RightWall.BaseObject.m_WAbil.MAXHP;
      else
        ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLESTATE);
      end;
    end
    else if CompareText(QuestConditionInfo.sParam1, 'ARCHER') = 0 then begin
      if QuestConditionInfo.nParam2 in [Low(m_Archer)..High(m_Archer)] then begin
        Result := m_Archer[QuestConditionInfo.nParam2].BaseObject <> nil;
      end
      else
        ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLESTATE);
    end
    else if CompareText(QuestConditionInfo.sParam1, 'GUARD') = 0 then begin
      if QuestConditionInfo.nParam2 in [Low(m_Guard)..High(m_Guard)] then begin
        Result := m_Guard[QuestConditionInfo.nParam2].BaseObject <> nil;
      end
      else
        ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLESTATE);
    end
    else begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLESTATE);
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckItemCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  sItemName: string;
  nItemCount, I: Integer;
  nCount: Integer;
  cMethod: Char;
  StdItem: pTStdItem;
  UserItem: pTUserItem;
begin
  Result := False;
  sItemName := QuestConditionInfo.sParam1;
  nItemCount := StrToIntDef(QuestConditionInfo.sParam3, -1);
  StdItem := UserEngine.GetStdItem(sItemName);
  nCount := 0;
  if (StdItem = nil) or (nItemCount < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMCOUNT);
    Exit;
  end;
  for I := 0 to PlayObject.m_ItemList.Count - 1 do begin
    UserItem := PlayObject.m_ItemList.Items[i];
    if UserItem <> nil then begin
      if (UserItem.wIndex - 1) = Stditem.Idx then begin
        if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
          Inc(nCount, UserItem.Dura);
        end
        else
          Inc(nCount);
      end;
    end;
  end;
  cMethod := QuestConditionInfo.sParam2[1];
  case cMethod of
    '=': if nCount = nItemCount then
        Result := True;
    '>': if nCount > nItemCount then
        Result := True;
    '<': if nCount < nItemCount then
        Result := True;
  else if nCount >= nItemCount then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckItemType(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nWhere: Integer;
  nType: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;
  nWhere := StrToIntDef(QuestConditionInfo.sParam1, -1);
  nType := StrToIntDef(QuestConditionInfo.sParam2, -1);

  if not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)]) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMTYPE);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  if UserItem.wIndex = 0 then
    Exit;
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (StdItem <> nil) and (StdItem.StdMode2 = nType) then begin
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckItemW(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
var
  nCount: Integer;
begin
  Result := True;
  PlayObject.sub_4C4CD4(QuestConditionInfo.sParam1, nCount);
  if nCount < QuestConditionInfo.nParam2 then
    Result := False;
end;

procedure TNormNpc.ConditionOfCheckItemWuXin(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nCheck: Integer;
  btWhere: Integer;
begin
  Result := False;
  btWhere := QuestConditionInfo.nParam1;
  nCheck := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nCheck < 0 then begin
    if QuestConditionInfo.sParam2 = '无' then
      nCheck := 0
    else if QuestConditionInfo.sParam2 = '金' then
      nCheck := 1
    else if QuestConditionInfo.sParam2 = '木' then
      nCheck := 2
    else if QuestConditionInfo.sParam2 = '水' then
      nCheck := 3
    else if QuestConditionInfo.sParam2 = '火' then
      nCheck := 4
    else if QuestConditionInfo.sParam2 = '土' then
      nCheck := 5;
  end;
  if (not (nCheck in [0..5])) or (not (btWhere in [Low(THumanUseItems)..High(THumanUseItems)])) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMWUXIN);
    Exit;
  end;
  if (PlayObject.m_UseItems[btWhere].MakeIndex > 0) and (PlayObject.m_UseItems[btWhere].wIndex > 0) then
    Result := (PlayObject.m_UseItems[btWhere].Value.btWuXin = nCheck);
end;

procedure TNormNpc.ConditionOfCheckJob(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := True;
  if CompareLStr(QuestConditionInfo.sParam1, sWARRIOR, 3) then begin
    if PlayObject.m_btJob <> 0 then
      Result := False;
  end;
  if CompareLStr(QuestConditionInfo.sParam1, sWIZARD, 3) then begin
    if PlayObject.m_btJob <> 1 then
      Result := False;
  end;
  if CompareLStr(QuestConditionInfo.sParam1, sTAOS, 3) then begin
    if PlayObject.m_btJob <> 2 then
      Result := False;
  end;
end;

procedure TNormNpc.ConditionOfCheckLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := PlayObject.m_Abil.Level >= QuestConditionInfo.nParam1;
end;

procedure TNormNpc.ConditionOfCheckLevelEx(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nLevel: Integer;
  cMethod: Char;
begin
  Result := False;
  nLevel := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKLEVELEX);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_Abil.Level = nLevel then
        Result := True;
    '>': if PlayObject.m_Abil.Level > nLevel then
        Result := True;
    '<': if PlayObject.m_Abil.Level < nLevel then
        Result := True;
  else if PlayObject.m_Abil.Level >= nLevel then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckNameList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var
  Result: Boolean);
begin
  Result := CheckStringList(PlayObject.m_sCharName, m_sPath + QuestConditionInfo.sParam1);
end;

procedure TNormNpc.ConditionOfCheckNameListPostion(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  i: Integer;
  LoadList: TStringList;
  sCharName: string;
  nNamePostion, nPostion: Integer;
  sLine: string;
begin
  Result := False;
  nNamePostion := -1;
  LoadList := TStringList.Create;
  try
    sCharName := PlayObject.m_sCharName;

    if FileExists(g_Config.sGameDataDir + QuestConditionInfo.sParam1) then begin
      LoadList.LoadFromFile(g_Config.sGameDataDir + QuestConditionInfo.sParam1);
      for i := 0 to LoadList.Count - 1 do begin
        sLine := Trim(LoadList.Strings[i]);
        if sLine[1] = ';' then
          Continue;
        if CompareText(sLine, sCharName) = 0 then begin
          nNamePostion := i;
          break;
        end;
      end;
    end
    else begin
      ScriptConditionError(PlayObject, QuestConditionInfo,
        sSC_CHECKNAMELISTPOSITION);
    end;
  finally
    LoadList.Free
  end;
  nPostion := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nPostion < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo,
      sSC_CHECKNAMELISTPOSITION);
    Exit;
  end;
  if nNamePostion >= nPostion then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckMarry(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  if PlayObject.m_sDearName <> '' then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckMarryCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
{var
  nCount: Integer;
  cMethod: Char;   }
begin
  Result := False;
  {nCount := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMARRYCOUNT);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btMarryCount = nCount then
        Result := True;
    '>': if PlayObject.m_btMarryCount > nCount then
        Result := True;
    '<': if PlayObject.m_btMarryCount < nCount then
        Result := True;
  else if PlayObject.m_btMarryCount >= nCount then
    Result := True;
  end;  }
end;

procedure TNormNpc.ConditionOfCheckMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  if (PlayObject.m_MasterList.Count > 0) and (not PlayObject.m_boMaster) then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckMemBerLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nLevel: Integer;
  cMethod: Char;
begin
  Result := False;
  nLevel := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMEMBERLEVEL);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nMemberLevel = nLevel then
        Result := True;
    '>': if PlayObject.m_nMemberLevel > nLevel then
        Result := True;
    '<': if PlayObject.m_nMemberLevel < nLevel then
        Result := True;
  else if PlayObject.m_nMemberLevel >= nLevel then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckMemberType(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nType: Integer;
  cMethod: Char;
begin
  Result := False;
  nType := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nType < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMEMBERTYPE);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nMemberType = nType then
        Result := True;
    '>': if PlayObject.m_nMemberType > nType then
        Result := True;
    '<': if PlayObject.m_nMemberType < nType then
        Result := True;
  else if PlayObject.m_nMemberType >= nType then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckNameIPList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  i: Integer;
  LoadList: TStringList;
  sCharName: string;
  sCharAccount: string;
  sCharIPaddr: string;
  sLine: string;
  sName: string;
  sIPaddr: string;
begin
  Result := False;
  LoadList := TStringList.Create;
  try
    sCharName := PlayObject.m_sCharName;
    sCharAccount := PlayObject.m_sUserID;
    sCharIPaddr := PlayObject.m_sIPaddr;

    if FileExists(g_Config.sGameDataDir + QuestConditionInfo.sParam1) then begin
      LoadList.LoadFromFile(g_Config.sGameDataDir + QuestConditionInfo.sParam1);
      for i := 0 to LoadList.Count - 1 do begin
        sLine := LoadList.Strings[i];
        if sLine[1] = ';' then
          Continue;
        sIPaddr := GetValidStr3(sLine, sName, [' ', '/', #9]);
        sIPaddr := Trim(sIPaddr);
        if (sName = sCharName) and (sIPaddr = sCharIPaddr) then begin
          Result := True;
          break;
        end;
      end;
    end
    else begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMEIPLIST);
    end;
  finally
    LoadList.Free
  end;
end;

procedure TNormNpc.ConditionOfCheckPkPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var
  Result: Boolean);
begin
  Result := PlayObject.PKLevel >= QuestConditionInfo.nParam1;
end;

procedure TNormNpc.ConditionOfCheckPoseDir(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  PoseHuman: TBaseObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.GetPoseCreate = PlayObject) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    case QuestConditionInfo.nParam1 of
      1: if PoseHuman.m_btGender = PlayObject.m_btGender then
          Result := True; //要求相同性别
      2: if PoseHuman.m_btGender <> PlayObject.m_btGender then
          Result := True; //要求不同性别
    else
      Result := True; //无参数时不判别性别
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckPoseGender(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  PoseHuman: TBaseObject;
  btSex: Byte;
begin
  Result := False;
  btSex := 0;
  if CompareText(QuestConditionInfo.sParam1, 'MAN') = 0 then begin
    btSex := 0;
  end
  else if CompareText(QuestConditionInfo.sParam1, '男') = 0 then begin
    btSex := 0;
  end
  else if CompareText(QuestConditionInfo.sParam1, 'WOMAN') = 0 then begin
    btSex := 1;
  end
  else if CompareText(QuestConditionInfo.sParam1, '女') = 0 then begin
    btSex := 1;
  end;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if PoseHuman.m_btGender = btSex then
      Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckPoseIsMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  PoseHuman: TBaseObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if (TPlayObject(PoseHuman).m_MasterList.Count > 0) and (TPlayObject(PoseHuman).m_boMaster) then
      Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckPoseLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nLevel: Integer;
  PoseHuman: TBaseObject;
  cMethod: Char;
begin
  Result := False;
  nLevel := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKPOSELEVEL);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    case cMethod of
      '=': if PoseHuman.m_Abil.Level = nLevel then
          Result := True;
      '>': if PoseHuman.m_Abil.Level > nLevel then
          Result := True;
      '<': if PoseHuman.m_Abil.Level < nLevel then
          Result := True;
    else if PoseHuman.m_Abil.Level >= nLevel then
      Result := True;
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckPoseMarry(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  PoseHuman: TBaseObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if TPlayObject(PoseHuman).m_sDearName <> '' then
      Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckPoseMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  PoseHuman: TBaseObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if (TPlayObject(PoseHuman).m_MasterList.Count > 0) and not (TPlayObject(PoseHuman).m_boMaster) then
      Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckItemStrengthenCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  btWhere: Integer;
  nCheckCount: Integer;
  cMethod: Char;
  UserItem: pTUserItem;
begin
  Result := False;
  btWhere := StrToIntDef(QuestConditionInfo.sParam1, -1);
  nCheckCount := StrToIntDef(QuestConditionInfo.sParam4, -1);
  if (not (btWhere in [Low(THumanUseItems)..High(THumanUseItems)])) or (nCheckCount < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMSTRENGTHENCOUNT);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[btWhere];
  if (UserItem.MakeIndex <= 0) or (UserItem.wIndex <= 0) then
    Exit;
  cMethod := QuestConditionInfo.sParam3[1];
  if QuestConditionInfo.nParam2 = 1 then begin
    case cMethod of
      '=': if UserItem.Value.StrengthenInfo.btCanStrengthenCount = nCheckCount then
          Result := True;
      '>': if UserItem.Value.StrengthenInfo.btCanStrengthenCount > nCheckCount then
          Result := True;
      '<': if UserItem.Value.StrengthenInfo.btCanStrengthenCount < nCheckCount then
          Result := True;
    else if UserItem.Value.StrengthenInfo.btCanStrengthenCount >= nCheckCount then
      Result := True;
    end;
  end
  else begin
    case cMethod of
      '=': if UserItem.Value.StrengthenInfo.btStrengthenCount = nCheckCount then
          Result := True;
      '>': if UserItem.Value.StrengthenInfo.btStrengthenCount > nCheckCount then
          Result := True;
      '<': if UserItem.Value.StrengthenInfo.btStrengthenCount < nCheckCount then
          Result := True;
    else if UserItem.Value.StrengthenInfo.btStrengthenCount >= nCheckCount then
      Result := True;
    end;
  end;

end;

procedure TNormNpc.ConditionOfCheckItemFluteCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  btWhere: Integer;
  nCheckCount: Integer;
  cMethod: Char;
  UserItem: pTUserItem;
begin
  Result := False;
  btWhere := StrToIntDef(QuestConditionInfo.sParam1, -1);
  nCheckCount := StrToIntDef(QuestConditionInfo.sParam3, -1);
  if (not (btWhere in [Low(THumanUseItems)..High(THumanUseItems)])) or (nCheckCount < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMFLUTECOUNT);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[btWhere];
  if (UserItem.MakeIndex <= 0) or (UserItem.wIndex <= 0) then
    Exit;
  cMethod := QuestConditionInfo.sParam2[1];
  case cMethod of
    '=': if UserItem.Value.btFluteCount = nCheckCount then
        Result := True;
    '>': if UserItem.Value.btFluteCount > nCheckCount then
        Result := True;
    '<': if UserItem.Value.btFluteCount < nCheckCount then
        Result := True;
  else if UserItem.Value.btFluteCount >= nCheckCount then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckGuildLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nLevel: Integer;
  Guild: TGuild;
  cMethod: Char;
begin
  Result := False;
  nLevel := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if (nLevel < 0) or (PlayObject.m_MyGuild = nil) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGUILDLEVEL);
    Exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.btLevel = nLevel then
        Result := True;
    '>': if Guild.btLevel > nLevel then
        Result := True;
    '<': if Guild.btLevel < nLevel then
        Result := True;
  else if Guild.btLevel >= nLevel then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckPullulation(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nPullulation, nPlayPullulation: Integer;
  cMethod: Char;
begin
  Result := False;
  nPullulation := StrToIntDef(QuestConditionInfo.sParam2, -1) * 60;
  if (nPullulation < 0) or (nPullulation > MAXPULLULATION) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKPULLULATION);
    Exit;
  end;
  nPullulation := nPullulation div 60;
  nPlayPullulation := PlayObject.m_nPullulation div 60;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nPlayPullulation = nPullulation then
        Result := True;
    '>': if nPlayPullulation > nPullulation then
        Result := True;
    '<': if nPlayPullulation < nPullulation then
        Result := True;
  else if nPlayPullulation >= nPullulation then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckServerName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
//var
//  sServerName: string;
begin
  Result := False;
  if QuestConditionInfo.sParam1 = g_Config.sServerName then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckSlaveCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nCount: Integer;
  cMethod: Char;
begin
  Result := False;
  nCount := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSLAVECOUNT);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_SlaveList.Count = nCount then
        Result := True;
    '>': if PlayObject.m_SlaveList.Count > nCount then
        Result := True;
    '<': if PlayObject.m_SlaveList.Count < nCount then
        Result := True;
  else if PlayObject.m_SlaveList.Count >= nCount then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckSafeZone(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := PlayObject.InSafeZone;
end;

procedure TNormNpc.ConditionOfCheckMapName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  if QuestConditionInfo.sParam1 = PlayObject.m_sMapName then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckSkill(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo;
  var Result: Boolean);
var
  nSkillLevel: Integer;
  cMethod: Char;
  UserMagic: pTUserMagic;
begin
  Result := False;
  nSkillLevel := StrToIntDef(QuestConditionInfo.sParam3, -1);
  if nSkillLevel < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sCHECKSKILL);
    Exit;
  end;
  //  UserMagic := nil;
  UserMagic := TPlayObject(PlayObject).GetMagicInfo(QuestConditionInfo.sParam1);
  if UserMagic = nil then
    Exit;
  cMethod := QuestConditionInfo.sParam2[1];
  case cMethod of
    '=': if UserMagic.btLevel = nSkillLevel then
        Result := True;
    '>': if UserMagic.btLevel > nSkillLevel then
        Result := True;
    '<': if UserMagic.btLevel < nSkillLevel then
        Result := True;
  else if UserMagic.btLevel >= nSkillLevel then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckMakeMagicLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  btMagicIdx: Integer;
  nLevel: Integer;
  cMethod: Char;
begin
  Result := False;
  btMagicIdx := StrToIntDef(QuestConditionInfo.sParam1, -1);
  nLevel := StrToIntDef(QuestConditionInfo.sParam3, -1);
  if (nLevel < 0) or (not (btMagicIdx in [Low(TMakeMagic)..High(TMakeMagic)])) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMAKEMAGICLEVEL);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam2[1];
  case cMethod of
    '=': if PlayObject.m_MakeMagic[btMagicIdx] = nLevel then
        Result := True;
    '>': if PlayObject.m_MakeMagic[btMagicIdx] > nLevel then
        Result := True;
    '<': if PlayObject.m_MakeMagic[btMagicIdx] < nLevel then
        Result := True;
  else if PlayObject.m_MakeMagic[btMagicIdx] >= nLevel then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfAnsiContainsText(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  sValue1: string;
  sValue2: string;
begin
  Result := False;
  sValue1 := QuestConditionInfo.sParam1;
  sValue2 := QuestConditionInfo.sParam2;
  if AnsiContainsText(sValue1, sValue2) then
    Result := True;
end;

procedure TNormNpc.ConditionOfBBCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := PlayObject.m_SlaveList.Count >= QuestConditionInfo.nParam1;
end;

procedure TNormNpc.ConditionOfCompareText(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  sValue1: string;
  sValue2: string;
begin
  Result := False;
  sValue1 := QuestConditionInfo.sParam1;
  sValue2 := QuestConditionInfo.sParam2;
  if CompareText(sValue1, sValue2) = 0 then
    Result := True;
end;

procedure TNormNpc.ConditionOfDayOfWeek(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := True;
  if CompareLStr(QuestConditionInfo.sParam1, sSUN, Length(sSUN)) then begin
    if DayOfWeek(Now) <> 1 then
      Result := False;
  end;
  if CompareLStr(QuestConditionInfo.sParam1, sMON, Length(sMON)) then begin
    if DayOfWeek(Now) <> 2 then
      Result := False;
  end;
  if CompareLStr(QuestConditionInfo.sParam1, sTUE, Length(sTUE)) then begin
    if DayOfWeek(Now) <> 3 then
      Result := False;
  end;
  if CompareLStr(QuestConditionInfo.sParam1, sWED, Length(sWED)) then begin
    if DayOfWeek(Now) <> 4 then
      Result := False;
  end;
  if CompareLStr(QuestConditionInfo.sParam1, sTHU, Length(sTHU)) then begin
    if DayOfWeek(Now) <> 5 then
      Result := False;
  end;
  if CompareLStr(QuestConditionInfo.sParam1, sFRI, Length(sFRI)) then begin
    if DayOfWeek(Now) <> 6 then
      Result := False;
  end;
  if CompareLStr(QuestConditionInfo.sParam1, sSAT, Length(sSAT)) then begin
    if DayOfWeek(Now) <> 7 then
      Result := False;
  end;
end;

procedure TNormNpc.ConditionOfEqual(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
var
  n14, n18: integer;
begin
  Result := False;
  if CheckVarNameNo(PlayObject, QuestConditionInfo, n14, n18) and (n14 = n18) then
    Result := True;
end;

procedure TNormNpc.ConditionOfGender(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := True;
  if CompareText(QuestConditionInfo.sParam1, sMAN) = 0 then begin
    if PlayObject.m_btGender <> 0 then
      Result := False;
  end
  else begin
    if PlayObject.m_btGender <> 1 then
      Result := False;
  end;
end;

procedure TNormNpc.ActionOfAnsiReplaceText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sValue1: string;
  sValue2: string;
  sValue3: string;
  n01: Integer;
begin
  sValue1 := QuestActionInfo.sParam1;
  sValue2 := QuestActionInfo.sParam2;
  sValue3 := QuestActionInfo.sParam3;
  if (sValue1 = '') or (sValue2 = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ANSIREPLACETEXT);
    Exit;
  end;
  n01 := GetValNameNo(sValue1);
  if n01 >= 0 then begin
    case n01 of
      6000..6999: begin
          sValue1 := PlayObject.m_sString[n01 - 6000];
          if AnsiContainsText(sValue1, sValue2) then
            PlayObject.m_sString[n01 - 6000] := AnsiReplaceText(sValue1, sValue2, sValue3);
        end;
      7000..7999: begin
          sValue1 := g_Config.GlobalAVal[n01 - 7000];
          if AnsiContainsText(sValue1, sValue2) then
            g_Config.GlobalAVal[n01 - 7000] := AnsiReplaceText(sValue1, sValue2,
              sValue3);
        end;
      800..899: begin
          sValue1 := g_Config.GlobalUVal[n01 - 800];
          if AnsiContainsText(sValue1, sValue2) then
            g_Config.GlobalUVal[n01 - 800] := AnsiReplaceText(sValue1, sValue2,
              sValue3);
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ANSIREPLACETEXT);
      end;
    end;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ANSIREPLACETEXT);
end;

procedure TNormNpc.ActionOfTakeOffItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  btWhere: Integer;
  boForce: Boolean;
begin
  btWhere := StrToIntDef(QuestActionInfo.sParam1, -1);
  boForce := StrToIntDef(QuestActionInfo.sParam2, -1) = 1;
  if not (btWhere in [0 .. 20]) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TAKEOFFITEM);
    Exit;
  end;
  PlayObject.TakeOffItem(btWhere, 0, False, boForce);
end;

procedure TNormNpc.ActionOfRepairItem(PlayObject: TPlayObject; QuestActionInfo:
  pTQuestActionInfo);
var
  nWhere: Integer;
  StdItem: pTStdItem;
  //  sCheckItemName: string;
begin
  if StrToIntDef(QuestActionInfo.sParam1, -1) >= 0 then begin
    nWhere := StrToIntDef(QuestActionInfo.sParam1, -1);
    if (nWhere in [Low(THumanUseItems)..High(THumanUseItems)]) then begin
      if PlayObject.m_UseItems[nWhere].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nWhere].wIndex);
        if StdItem <> nil then begin
          if (PlayObject.m_UseItems[nWhere].DuraMax > PlayObject.m_UseItems[nWhere].Dura) and
            (sm_Arming in StdItem.StdModeEx) and
           (not (CheckItemBindMode(@PlayObject.m_UseItems[nWhere], bm_NoRepair))) then begin

            {if Assigned(zPlugOfEngine.CheckCanRepairItem) then begin
              sCheckItemName := StdItem.Name;
              if not zPlugOfEngine.CheckCanRepairItem(PlayObject, PChar(sCheckItemName)) then Exit;
            end;  }
            PlayObject.m_UseItems[nWhere].Dura := PlayObject.m_UseItems[nWhere].DuraMax;
            PlayObject.DuraChange(nWhere, PlayObject.m_UseItems[nWhere].Dura, PlayObject.m_UseItems[nWhere].DuraMax);
            //PlayObject.SendMsg(PlayObject, RM_aDURACHANGE, nWhere, PlayObject.m_UseItems[nWhere].Dura, PlayObject.m_UseItems[nWhere].DuraMax, 0, ''); //这个是发送人物身上装备的信息 如果装备持久改变或者其他什么信息改变就要用这个命令发送一下
          end;
        end;
      end;
    end else
    if (nWhere in [16..18]) then begin
      nWhere := nWhere - 16;
      if PlayObject.m_UseItems[U_House].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_House].HorseItems[nWhere].wIndex);
        if (StdItem <> nil) and (PlayObject.m_UseItems[U_House].HorseItems[nWhere].Dura < StdItem.DuraMax) and
          (not (CheckByteStatus(StdItem.Bind, Ib_NoRepair) or CheckByteStatus(PlayObject.m_UseItems[U_House].HorseItems[nWhere].btBindMode1, Ib_NoRepair))) then begin
          PlayObject.m_UseItems[U_House].HorseItems[nWhere].Dura := StdItem.DuraMax;
          PlayObject.DuraChange(16 + nWhere, StdItem.DuraMax, StdItem.DuraMax);
        end;
      end;
    end
    else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_REPAIRITEM);
    end;
  end
  else if StrToIntDef(QuestActionInfo.sParam1, -1) < 0 then begin
    for nWhere := Low(THumanUseItems) to High(THumanUseItems) do begin
      if PlayObject.m_UseItems[nWhere].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nWhere].wIndex);
        if StdItem <> nil then begin
          if (PlayObject.m_UseItems[nWhere].DuraMax > PlayObject.m_UseItems[nWhere].Dura) and (sm_Arming in StdItem.StdModeEx) and
           (not (CheckItemBindMode(@PlayObject.m_UseItems[nWhere], bm_NoRepair))) then begin
            PlayObject.m_UseItems[nWhere].Dura := PlayObject.m_UseItems[nWhere].DuraMax;
            PlayObject.DuraChange(nWhere, PlayObject.m_UseItems[nWhere].Dura, PlayObject.m_UseItems[nWhere].DuraMax);
          end;
        end;
      end;
    end;
    if PlayObject.m_UseItems[U_House].wIndex > 0 then begin
      for nWhere := Low(PlayObject.m_UseItems[U_House].HorseItems) to High(PlayObject.m_UseItems[U_House].HorseItems) do begin
        StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_House].HorseItems[nWhere].wIndex);
        if (StdItem <> nil) and (PlayObject.m_UseItems[U_House].HorseItems[nWhere].Dura < StdItem.DuraMax) and
          (not (CheckByteStatus(StdItem.Bind, Ib_NoRepair) or CheckByteStatus(PlayObject.m_UseItems[U_House].HorseItems[nWhere].btBindMode1, Ib_NoRepair))) then begin
          PlayObject.m_UseItems[U_House].HorseItems[nWhere].Dura := StdItem.DuraMax;
          PlayObject.DuraChange(16 + nWhere, StdItem.DuraMax, StdItem.DuraMax);
        end;
      end;
    end;
  end
  else begin
    //ScriptActionError(PlayObject, '', QuestActionInfo, sSC_REPAIRITEM);
  end;
end;

constructor TNormNpc.Create;
begin
  inherited;
  m_boSuperMan := True;
  m_btRaceServer := RC_NPC;
  m_btNPCRaceServer := NPC_RC_NORM;
  m_GotoValue[0] := '';
  m_GotoValue[1] := '';
  m_GotoValue[2] := '';
  m_GotoValue[3] := '';
  m_GotoValue[4] := '';
  m_GotoValue[5] := '';
  m_GotoValue[6] := '';
  m_GotoValue[7] := '';
  m_GotoValue[8] := '';
  m_GotoValue[9] := '';

  m_boNameFlag := False;
  m_nNameFlag := -1;
  m_nEffigyState := -1;

  //m_nLight := 2;
  m_HookObject := nil;
  m_btAntiPoison := 99;
  m_ScriptList := TList.Create;
  FGiveItemList := TList.Create;
  FHookItemList := TList.Create;
  m_boStickMode := True;
  m_sFilePath := '';
  m_sHintName := '';
  m_boFB := False;
  m_boIsHide := False;
  m_boIsQuest := True;
  m_btNameColor := 250;
  FMasterBase := nil;
  m_boNpcAutoChangeColor := False;
  m_dwNpcAutoChangeColorTick := GetTickCount;
  m_dwNpcAutoChangeColorTime := 0;
  m_nNpcAutoChangeIdx := 0;
  FList1C := TStringList.Create;
  FOldLabel := 0;

  //检测脚本
  SafeFillChar(FNpcCondition, SizeOf(FNpcCondition), #0);
  FNpcCondition[nCHECK] := ConditionOfCheck;
  FNpcCondition[nSC_CHECKMISSION] := ConditionOfCheckMission;
  FNpcCondition[nRANDOM] := ConditionOfRandom;
  FNpcCondition[nGENDER] := ConditionOfGender;
  FNpcCondition[nCHECKLEVEL] := ConditionOfCheckLevel;
  FNpcCondition[nCHECKJOB] := ConditionOfCheckJob;
  FNpcCondition[nCHECKBBCOUNT] := ConditionOfBBCount;
  FNpcCondition[nCHECKITEM] := ConditionOfCheckItem;
  FNpcCondition[nCHECKITEMW] := ConditionOfCheckItemW;
  FNpcCondition[nCHECKGOLD] := ConditionOfCheckGold;
  FNpcCondition[nCHECKDURA] := ConditionOfCheckDura;
  FNpcCondition[nDAYOFWEEK] := ConditionOfDayOfWeek;
  FNpcCondition[nHOUR] := ConditionOfHour;
  FNpcCondition[nMIN] := ConditionOfMin;
  FNpcCondition[nCHECKPKPOINT] := ConditionOfCheckPkPoint;
  FNpcCondition[nCHECKMONMAP] := ConditionOfCheckMonMapCount;
  FNpcCondition[nCHECKHUM] := ConditionOfCheckHum;
  FNpcCondition[nCHECKBAGGAGE] := ConditionOfCheckBagGage;
  FNpcCondition[nCHECKNAMELIST] := ConditionOfCheckNameList;
  FNpcCondition[nCHECKACCOUNTLIST] := ConditionOfCheckAccountList;
  FNpcCondition[nCHECKIPLIST] := ConditionOfCheckIPList;
  FNpcCondition[nEQUAL] := ConditionOfEqual;
  FNpcCondition[nLARGE] := ConditionOfLapge;
  FNpcCondition[nSMALL] := ConditionOfSmall;
  FNpcCondition[nSC_ISSYSOP] := ConditionOfISSYSOP;
  FNpcCondition[nSC_ISADMIN] := ConditionOfISAdmin;
  FNpcCondition[nSC_CHECKGROUPCOUNT] := ConditionOfCheckGroupCount;
  FNpcCondition[nSC_CHECKPOSEDIR] := ConditionOfCheckPoseDir;
  FNpcCondition[nSC_CHECKPOSELEVEL] := ConditionOfCheckPoseLevel;
  FNpcCondition[nSC_CHECKPOSEGENDER] := ConditionOfCheckPoseGender;
  FNpcCondition[nSC_CHECKLEVELEX] := ConditionOfCheckLevelEx;
  FNpcCondition[nSC_CHECKBONUSPOINT] := ConditionOfCheckBonusPoint;
  FNpcCondition[nSC_CHECKMARRY] := ConditionOfCheckMarry;
  FNpcCondition[nSC_CHECKPOSEMARRY] := ConditionOfCheckPoseMarry;
  FNpcCondition[nSC_CHECKMARRYCOUNT] := ConditionOfCheckMarryCount;
  FNpcCondition[nSC_CHECKMASTER] := ConditionOfCheckMaster;
  FNpcCondition[nSC_HAVEMASTER] := ConditionOfHaveMaster;
  FNpcCondition[nSC_CHECKPOSEMASTER] := ConditionOfCheckPoseMaster;
  FNpcCondition[nSC_POSEHAVEMASTER] := ConditionOfPoseHaveMaster;
  FNpcCondition[nSC_CHECKISMASTER] := ConditionOfCheckIsMaster;
  FNpcCondition[nSC_HASGUILD] := ConditionOfCheckHaveGuild;
  FNpcCondition[nSC_ISGUILDMASTER] := ConditionOfCheckIsGuildMaster;
  FNpcCondition[nSC_CHECKCASTLEMASTER] := ConditionOfCheckIsCastleMaster;
  FNpcCondition[nSC_ISCASTLEGUILD] := ConditionOfCheckIsCastleaGuild;
  FNpcCondition[nSC_ISATTACKGUILD] := ConditionOfCheckIsAttackGuild;
  FNpcCondition[nSC_ISDEFENSEGUILD] := ConditionOfCheckIsDefenseGuild;
  FNpcCondition[nSC_CHECKCASTLEDOOR] := ConditionOfCheckCastleDoorStatus;
  //FNpcCondition[nSC_ISATTACKALLYGUILD] := ConditionOfCheckIsAttackAllyGuild;
  FNpcCondition[nSC_ISDEFENSEALLYGUILD] := ConditionOfCheckIsDefenseAllyGuild;
  FNpcCondition[nSC_CHECKPOSEISMASTER] := ConditionOfCheckPoseIsMaster;
  FNpcCondition[nSC_CHECKNAMEIPLIST] := ConditionOfCheckNameIPList;
  FNpcCondition[nSC_CHECKACCOUNTIPLIST] := ConditionOfCheckAccountIPList;
  FNpcCondition[nSC_CHECKSLAVECOUNT] := ConditionOfCheckSlaveCount;
  FNpcCondition[nSC_ISNEWHUMAN] := ConditionOfISNewHuman;
  FNpcCondition[nSC_CHECKMEMBERTYPE] := ConditionOfCheckMemberType;
  FNpcCondition[nSC_CHECKMEMBERLEVEL] := ConditionOfCheckMemBerLevel;
  FNpcCondition[nSC_CHECKGAMEPOINT] := ConditionOfCheckGamePoint;
  FNpcCondition[nSC_CHECKNAMELISTPOSITION] := ConditionOfCheckNameListPostion;
  FNpcCondition[nSC_CHECKGUILDLIST] := ConditionOfCheckGuildList;
  FNpcCondition[nSC_CHECKRENEWLEVEL] := ConditionOfCheckReNewLevel;
  FNpcCondition[nSC_CHECKSLAVELEVEL] := ConditionOfCheckSlaveLevel;
  FNpcCondition[nSC_CHECKSLAVENAME] := ConditionOfCheckSlaveName;
  FNpcCondition[nSC_CHECKCREDITPOINT] := ConditionOfCheckCreditPoint;
  FNpcCondition[nSC_CHECKOFGUILD] := ConditionOfCheckOfGuild;
  FNpcCondition[nSC_CHECKUSEITEM] := ConditionOfCheckUseItem;
  FNpcCondition[nSC_CHECKBAGSIZE] := ConditionOfCheckBagSize;
  FNpcCondition[nSC_CHECKLISTCOUNT] := ConditionOfCheckListCount;
  FNpcCondition[nSC_CHECKDC] := ConditionOfCheckDC;
  FNpcCondition[nSC_CHECKMC] := ConditionOfCheckMC;
  FNpcCondition[nSC_CHECKSC] := ConditionOfCheckSC;
  FNpcCondition[nSC_CHECKHP] := ConditionOfCheckHP;
  FNpcCondition[nSC_CHECKMP] := ConditionOfCheckMP;
  FNpcCondition[nSC_CHECKITEMTYPE] := ConditionOfCheckItemType;
  FNpcCondition[nSC_CHECKEXP] := ConditionOfCheckExp;
  FNpcCondition[nSC_CHECKCASTLEGOLD] := ConditionOfCheckCastleGold;
  FNpcCondition[nSC_CHECKBUILDPOINT] := ConditionOfCheckGuildBuildPoint;
  FNpcCondition[nSC_CHECKAURAEPOINT] := ConditionOfCheckGuildAuraePoint;
  FNpcCondition[nSC_CHECKSTABILITYPOINT] := ConditionOfCheckStabilityPoint;
  FNpcCondition[nSC_CHECKFLOURISHPOINT] := ConditionOfCheckFlourishPoint;
  FNpcCondition[nSC_CHECKCONTRIBUTION] := ConditionOfCheckContribution;
  FNpcCondition[nSC_CHECKRANGEMONCOUNT] := ConditionOfCheckRangeMonCount;
  FNpcCondition[nSC_CHECKITEMADDVALUE] := ConditionOfCheckItemAddValue;
  FNpcCondition[nSC_CHECKINMAPRANGE] := ConditionOfCheckInMapRange;
  FNpcCondition[nSC_CASTLECHANGEDAY] := ConditionOfCheckCastleChageDay;
  FNpcCondition[nSC_CASTLEWARDAY] := ConditionOfCheckCastleWarDay;
  FNpcCondition[nSC_ONLINELONGMIN] := ConditionOfCheckOnlineLongMin;
  FNpcCondition[nSC_CHECKGUILDCHIEFITEMCOUNT] := ConditionOfCheckChiefItemCount;
  FNpcCondition[nSC_CHECKNAMEDATELIST] := ConditionOfCheckNameDateList;
  FNpcCondition[nSC_CHECKMAPHUMANCOUNT] := ConditionOfCheckMapHumanCount;
  FNpcCondition[nSC_CHECKMAPMONCOUNT] := ConditionOfCheckMapMonCount;
  FNpcCondition[nSC_CHECKVAR] := ConditionOfCheckVar;
  FNpcCondition[nSC_CHECKSERVERNAME] := ConditionOfCheckServerName;
  FNpcCondition[nCHECKMAPNAME] := ConditionOfCheckMapName;
  FNpcCondition[nINSAFEZONE] := ConditionOfCheckSafeZone;
  FNpcCondition[nCHECKSKILL] := ConditionOfCheckSkill;
  FNpcCondition[nSC_CHECKCONTAINSTEXT] := ConditionOfAnsiContainsText;
  FNpcCondition[nSC_COMPARETEXT] := ConditionOfCompareText;
  FNpcCondition[nSC_CHECKTEXTLIST] := ConditionOfCheckTextList;
  FNpcCondition[nSC_ISGROUPMASTER] := ConditionOfIsGroupMaster;
  FNpcCondition[nSC_CHECKCONTAINSTEXTLIST] := ConditionOfCHECKCONTAINSTEXTLIST;
  FNpcCondition[nSC_CHECKONLINE] := ConditionOfCheckOnLine;
  FNpcCondition[nSC_ISDUPMODE] := ConditionOfIsDupMode;
  FNpcCondition[nSC_CHECKITEMCOUNT] := ConditionOfCheckItemCount;
  FNpcCondition[nSC_CHECKCASTLESTATE] := ConditionOfCheckCastleState;
  FNpcCondition[nSC_CHECKMISSIONCOUNT] := ConditionOfCheckMissionCount;
  FNpcCondition[nSC_CHECKMISSIONKILLMONCOUNT] := ConditionOfCheckMissionKillMonCount;
  FNpcCondition[nSC_CHECKARITHMOMETERCOUNT] := ConditionOfCheckArithmometerCount;
  FNpcCondition[nSC_CANMOVEECTYPE] := ConditionOfCanMoveEctype;
  FNpcCondition[nSC_CHECKECTYPEMONCOUNT] := ConditionOfCheckEctypeMonCount;
  FNpcCondition[nSC_CHECKMAPQUEST] := ConditionOfCheckMapQuest;
  FNpcCondition[nSC_CHECKGAMEDIAMOND] := ConditionOfCheckGameDiamond;
  FNpcCondition[nSC_CHECKGAMEGIRD] := ConditionOfCheckGameGird;
  FNpcCondition[nSC_CHECKEMAILOK] := ConditionOfCheckEMailOK;
  FNpcCondition[nSC_ISUNDERWAR] := ConditionOfISUnderWar;
  FNpcCondition[nSC_CHECKHUMORNPCRANGE] := ConditionOfCheckHumOrNPCRange;
  FNpcCondition[nSC_CHECKGROUPJOBCOUNT] := ConditionOfCheckGroupJobCount;
  FNpcCondition[nSC_CHECKPULLULATION] := ConditionOfCheckPullulation;
  FNpcCondition[nSC_CHECKGUILDLEVEL] := ConditionOfCheckGuildLevel;
  FNpcCondition[nSC_CHECKITEMSTRENGTHENCOUNT] := ConditionOfCheckItemStrengthenCount;
  FNpcCondition[nSC_CHECKITEMFLUTECOUNT] := ConditionOfCheckItemFluteCount;
  FNpcCondition[nSC_CHECKHUMWUXIN] := ConditionOfCheckHumWuXin;
  FNpcCondition[nSC_CHECKITEMWUXIN] := ConditionOfCheckItemWuXin;
  FNpcCondition[nSC_CHECKMAKEMAGICLEVEL] := ConditionOfCheckMakeMagicLevel;
  FNpcCondition[nSC_CHECKGUILDISFULL] := ConditionOfCheckGuildIsFull;
  FNpcCondition[nSC_CHECKSTRENGTHENCOUNT] := ConditionOfCheckStrengthenCount;
  FNpcCondition[nSC_CHECKHORSELEVEL] := ConditionOfCheckHorseLevel;
  FNpcCondition[nSC_ISONHOUSE] := ConditionOfIsOnHouse;
  FNpcCondition[nSC_CHECKKILLMOBNAME] := ConditionOfCheckKillMobName;
  FNpcCondition[nSC_CHECKMAPSAMEMONCOUNT] := ConditionOfCheckMapSameMonCount;
  FNpcCondition[nSC_CHECKHITMONNAME] := ConditionOfCheckHitMonName;
  //功能脚本
  SafeFillChar(FNpcAction, SizeOf(FNpcAction), #0);
  FNpcAction[nSET] := ActionOfSet;
  FNpcAction[nSETMISSION] := ActionOfSetMission;
  FNpcAction[nTAKE] := ActionOfTake;
  FNpcAction[nSC_GIVE] := ActionOfGiveItem;
  FNpcAction[nSC_DYNAMICGIVE] := ActionOfDynamicGive;
  FNpcAction[nTAKEW] := ActionOfTakeW;
  FNpcAction[nCLOSE] := ActionOfClose;
  FNpcAction[nBREAK] := ActionOfBreak;
  FNpcAction[nRESET] := ActionOfReset;
  FNpcAction[nRESETMISSION] := ActionOfResetMission;
  FNpcAction[nTIMERECALL] := ActionOfTimeReCall;
  FNpcAction[nSC_PARAM1] := ActionOfParam1;
  FNpcAction[nSC_PARAM2] := ActionOfParam2;
  FNpcAction[nSC_PARAM3] := ActionOfParam3;
  FNpcAction[nSC_PARAM4] := ActionOfParam4;
  FNpcAction[nSC_MOBPLACE] := ActionOfMobPlace;
  FNpcAction[nSC_EXEACTION] := ActionOfExeAction;
  FNpcAction[nMAPMOVE] := ActionOfMapMove;
  FNpcAction[nMAP] := ActionOfMap;
  FNpcAction[nMONGEN] := ActionOfMonGen;
  FNpcAction[nMONCLEAR] := ActionOfMonClear;
  FNpcAction[nMOV] := ActionOfMov;
  FNpcAction[nINC] := ActionOfInc;
  FNpcAction[nDEC] := ActionOfDec;
  FNpcAction[nSC_DIV] := ActionOfDiv;
  FNpcAction[nSC_MUL] := ActionOfMul;
  FNpcAction[nSC_PERCENT] := ActionOfPercent;
  FNpcAction[nSUM] := ActionOfSum;
  FNpcAction[nBREAKTIMERECALL] := ActionOfBreakTimeRecall;
  FNpcAction[nPKPOINT] := ActionOfPkPoint;
  FNpcAction[nSC_RECALLMOB] := ActionOfRecallmob;
  FNpcAction[nKICK] := ActionOfKick;
  FNpcAction[nMOVR] := ActionOfMovr;
  FNpcAction[nEXCHANGEMAP] := ActionOfExChangeMap;
  FNpcAction[nRECALLMAP] := ActionOfExChangeMap;
  FNpcAction[nADDBATCH] := ActionOfAddBatch;
  FNpcAction[nBATCHDELAY] := ActionOfBatchDelay;
  FNpcAction[nBATCHMOVE] := ActionOfBatchMove;
  FNpcAction[nPLAYDICE] := ActionOfPlayDice;
  FNpcAction[nADDNAMELIST] := ActionOfAddNameList;
  FNpcAction[nDELNAMELIST] := ActionOfDelNameList;
  FNpcAction[nADDGUILDLIST] := ActionOfAddGuildList;
  FNpcAction[nDELGUILDLIST] := ActionOfDelGuildList;
  FNpcAction[nSC_LINEMSG] := ActionOfLineMsg;
  FNpcAction[nADDACCOUNTLIST] := ActionOfAddAccountList;
  FNpcAction[nDELACCOUNTLIST] := ActionOfDelAccountList;
  FNpcAction[nADDIPLIST] := ActionOfAddIPList;
  FNpcAction[nDELIPLIST] := ActionOfDelIPList;
  //FNpcAction[nGOQUEST] := ActionOfGoQuest;
   //FNpcAction[nENDQUEST] := ActionOfEndQuest;
  FNpcAction[nGOTO] := ActionOfGoto;
  FNpcAction[nSC_HAIRSTYLE] := ActionOfChangeHairStyle;
  FNpcAction[nSC_RECALLGROUPMEMBERS] := ActionOfRecallGroupMembers;
  FNpcAction[nSC_CLEARNAMELIST] := ActionOfClearNameList;
  FNpcAction[nSC_MAPTING] := ActionOfMapTing;
  FNpcAction[nSC_CHANGELEVEL] := ActionOfChangeLevel;
  FNpcAction[nSC_MARRY] := ActionOfMarry;
  FNpcAction[nSC_MASTER] := ActionOfMaster;
  FNpcAction[nSC_UNMASTER] := ActionOfUnMaster;
  FNpcAction[nSC_UNMARRY] := ActionOfUnMarry;
  FNpcAction[nSC_GETMARRY] := ActionOfGetMarry;
  //FNpcAction[nSC_GETMASTER] := ActionOfGetMaster;
  FNpcAction[nSC_CLEARSKILL] := ActionOfClearSkill;
  FNpcAction[nSC_DELNOJOBSKILL] := ActionOfDelNoJobSkill;
  FNpcAction[nSC_DELSKILL] := ActionOfDelSkill;
  FNpcAction[nSC_ADDSKILL] := ActionOfAddSkill;
  FNpcAction[nSC_SKILLLEVEL] := ActionOfSkillLevel;
  FNpcAction[nSC_CHANGEPKPOINT] := ActionOfChangePkPoint;
  FNpcAction[nSC_CHANGEEXP] := ActionOfChangeExp;
  FNpcAction[nSC_CHANGEJOB] := ActionOfChangeJob;
  FNpcAction[nSC_MISSION] := ActionOfMission;
  FNpcAction[nSC_SETMEMBERTYPE] := ActionOfSetMemberType;
  FNpcAction[nSC_SETMEMBERLEVEL] := ActionOfSetMemberLevel;
  FNpcAction[nSC_GAMEPOINT] := ActionOfGamePoint;
  FNpcAction[nSC_CHANGENAMECOLOR] := ActionOfChangeNameColor;
  FNpcAction[nSC_RENEWLEVEL] := ActionOfReNewLevel;
  FNpcAction[nSC_KILLSLAVE] := ActionOfKillSlave;
  FNpcAction[nSC_CHANGEGENDER] := ActionOfChangeGender;
  FNpcAction[nSC_KILLMONEXPRATE] := ActionOfKillMonExpRate;
  FNpcAction[nSC_POWERRATE] := ActionOfPowerRate;
  FNpcAction[nSC_CHANGEMODE] := ActionOfChangeMode;
  FNpcAction[nSC_CHANGEPERMISSION] := ActionOfChangePerMission;
  FNpcAction[nSC_KILL] := ActionOfKill;
  FNpcAction[nSC_BONUSPOINT] := ActionOfBonusPoint;
  FNpcAction[nSC_RESTRENEWLEVEL] := ActionOfRestReNewLevel;
  FNpcAction[nSC_DELMARRY] := ActionOfDelMarry;
  //FNpcAction[nSC_DELMASTER] := ActionOfDelMaster;
  FNpcAction[nSC_CREDITPOINT] := ActionOfChangeCreditPoint;
  FNpcAction[nSC_CLEARNEEDITEMS] := ActionOfClearNeedItems;
  FNpcAction[nSC_CLEARMAEKITEMS] := ActionOfClearMakeItems;
  FNpcAction[nSC_SETSENDMSGFLAG] := ActionOfSetSendMsgFlag;
  FNpcAction[nSC_UPGRADEITEMS] := ActionOfUpgradeItems;
  FNpcAction[nSC_UPGRADEITEMSEX] := ActionOfUpgradeItemsEx;
  FNpcAction[nSC_MONGENEX] := ActionOfMonGenEx;
  FNpcAction[nSC_CLEARMAPMON] := ActionOfClearMapMon;
  FNpcAction[nSC_SETMAPMODE] := ActionOfSetMapMode;
  FNpcAction[nSC_PKZONE] := ActionOfPkZone;
  FNpcAction[nSC_RESTBONUSPOINT] := ActionOfRestBonusPoint;
  FNpcAction[nSC_TAKECASTLEGOLD] := ActionOfTakeCastleGold;
  FNpcAction[nSC_HUMANHP] := ActionOfHumanHP;
  FNpcAction[nSC_HUMANMP] := ActionOfHumanMP;
  FNpcAction[nSC_BUILDPOINT] := ActionOfGuildBuildPoint;
  FNpcAction[nSC_AURAEPOINT] := ActionOfGuildAuraePoint;
  FNpcAction[nSC_STABILITYPOINT] := ActionOfGuildstabilityPoint;
  FNpcAction[nSC_FLOURISHPOINT] := ActionOfGuildFlourishPoint;
  FNpcAction[nSC_OPENMAGICBOX] := ActionOfOpenMagicBox;
  FNpcAction[nSC_SETRANKLEVELNAME] := ActionOfSetRankLevelName;
  FNpcAction[nSC_GMEXECUTE] := ActionOfGmExecute;
  FNpcAction[nSC_GUILDCHIEFITEMCOUNT] := ActionOfGuildChiefItemCount;
  FNpcAction[nSC_ADDNAMEDATELIST] := ActionOfAddNameDateList;
  FNpcAction[nSC_DELNAMEDATELIST] := ActionOfDelNameDateList;
  FNpcAction[nSC_MOBFIREBURN] := ActionOfMobFireBurn;
  FNpcAction[nSC_MESSAGEBOX] := ActionOfMessageBox;
  FNpcAction[nSC_SETSCRIPTFLAG] := ActionOfSetScriptFlag;
  FNpcAction[nSC_SETAUTOGETEXP] := ActionOfAutoGetExp;
  FNpcAction[nSC_VAR] := ActionOfVar;
  FNpcAction[nSC_LOADVAR] := ActionOfLoadVar;
  FNpcAction[nSC_SAVEVAR] := ActionOfSaveVar;
  FNpcAction[nSC_CALCVAR] := ActionOfCalcVar;
  FNpcAction[nOFFLINEPLAY] := ActionOfNotLineAddPiont;
  FNpcAction[nKICKOFFLINE] := ActionOfKickNotLineAddPiont;
  //FNpcAction[nSTARTTAKEGOLD] := ActionOfStartTakeGold;
  FNpcAction[nSC_DELAYGOTO] := ActionOfDelayGoto;
  FNpcAction[nSC_CLEARDELAYGOTO] := ActionOfClearDelayGoto;
  FNpcAction[nSC_ANSIREPLACETEXT] := ActionOfAnsiReplaceText;
  FNpcAction[nSC_ADDTEXTLIST] := ActionOfAddTextList;
  FNpcAction[nSC_DELTEXTLIST] := ActionOfDelTextList;
  FNpcAction[nSC_GROUPMOVE] := ActionOfGroupMove;
  FNpcAction[nSC_GROUPMAPMOVE] := ActionOfGroupMapMove;
  FNpcAction[nSC_RECALLHUMAN] := ActionOfRecallHuman;
  FNpcAction[nSC_REGOTO] := ActionOfReGoto;
  FNpcAction[nSC_GUILDMOVE] := ActionOfGuildMove;
  FNpcAction[nSC_GUILDMAPMOVE] := ActionOfGuildMapMove;
  FNpcAction[nSC_RANDOMMOVE] := ActionOfRandomMove;
  FNpcAction[nSC_USEBONUSPOINT] := ActionOfUseBonusPoint;
  FNpcAction[nSC_REPAIRITEM] := ActionOfRepairItem;
  FNpcAction[nSC_TAKECOUNT] := ActionOfTakeCount;
  FNpcAction[nSC_STORAGETIMECHANGE] := ActionOfStorageTimeChange;
  FNpcAction[nSC_ADDMISSION] := ActionOfAddMission;
  FNpcAction[nSC_DELMISSION] := ActionOfDelMission;
  FNpcAction[nSC_UPDATEMISSION] := ActionOfUpdateMission;
  FNpcAction[nSC_UPDATEMISSIONTIME] := ActionOfUpdateMissionTime;
  FNpcAction[nSC_CHANGEMISSIONKILLMONCOUNT] := ActionOfChangeMissionKillMonCount;
  FNpcAction[nSC_CHANGEARITHMOMETERCOUNT] := ActionOfChangeArithmonmeterCount;
  FNpcAction[nSC_SHOWEFFECT] := ActionOfShowEffect;
  FNpcAction[nSC_AUTOMOVE] := ActionOfAutoMove;
  FNpcAction[nSC_CHANGEGIVEITEM] := ActionOfChangeGiveItem;
  FNpcAction[nSC_MOBMACHINERYEVENT] := ActionOfMobMachineryEvent;
  FNpcAction[nSC_CLEARMACHINERYEVENT] := ActionOfClearMachineryEvent;
  FNpcAction[nSC_CREATEECTYPE] := ActionOfCreateEctype;
  FNpcAction[nSC_MOVEECTYPE] := ActionOfMoveEctype;
  FNpcAction[nSC_MOBECTYPEMON] := ActionOfMobEctypeMon;
  FNpcAction[nSC_CLEARECTYPEMON] := ActionOfClearEctypeMon;
  FNpcAction[nSC_SETMAPQUEST] := ActionOfSetMapQuest;
  FNpcAction[nSC_RESETMAPQUEST] := ActionOfResetMapQuest;
  FNpcAction[nSC_OPENBOX] := ActionOfOpenBox;
  FNpcAction[nSC_CHANGEGAMEDIAMOND] := ActionOfChangeGameDiamond;
  FNpcAction[nSC_CHANGEGAMEGIRD] := ActionOfChangeGameGird;
  FNpcAction[nSC_GETRANDOMNAME] := ActionOfGetRandomName;
  FNpcAction[nSC_MOBSLAVE] := ActionOfMobSlave;
  FNpcAction[nSC_CLEARLIST] := ActionOfClearList;
  FNpcAction[nSC_HOOKOBJECT] := ActionOfHookObject;
  FNpcAction[nSC_REFSHOWNAME] := ActionOfRefShowName;
  FNpcAction[nSC_SETEFFIGYSTATE] := ActionOfSetEffigyState;
  FNpcAction[nSC_STARTWALLCONQUESTWAR] := ActionOfStartWallconquestWar;
  FNpcAction[nSC_SETGUAGEBAR] := ActionOfSetGuageBar;
  FNpcAction[nSC_ADDMAKEMAGIC] := ActionOfAddMakeMagic;
  FNpcAction[nSC_ADDRANDOMMAPGATE] := ActionOfAddRandomMapGate;
  FNpcAction[nSC_DELRANDOMMAPGATE] := ActionOfDelRandomMapGate;
  FNpcAction[nSC_GETLARGESSGOLD] := ActionOfGetLargessGold;
  FNpcAction[nSC_RESETNAKEDABILPOINT] := ActionOfResetNakedAbilPoint;
  FNpcAction[nSC_CHANGEPULLULATION] := ActionOfChangePullulation;
  FNpcAction[nSC_SETLIMITEXPLEVEL] := ActionOfSetLimitExpLevel;
  FNpcAction[nSC_CHANGEGUILDLEVEL] := ActionOfChangeGuildLevel;
  FNpcAction[nSC_HCALL] := ActionOfHCall;
  FNpcAction[nSC_CREATEGROUPFAIL] := ActionOfCreateGroupFail;
  FNpcAction[nSC_HOOKITEM] := ActionOfHookItem;
  FNpcAction[nSC_CHANGENAKEDCOUNT] := ActionOfChangeNakedCount;
  FNpcAction[nSC_CHANGEHUMWUXIN] := ActionOfChangeHumWuXin;
  FNpcAction[nSC_CHANGEMAKEMAGICLEVEL] := ActionOfChangeMakeMagicLevel;
  FNpcAction[nSC_ADDGUILDMEMBER] := ActionOfAddGuildMember;
  FNpcAction[nSC_CHANGEMAKEMAGICPOINT] := ActionOfChangeMakeMagicPoint;
  FNpcAction[nSC_OPENURL] := ActionOfOpenUrl;
  FNpcAction[nSC_CHANGEHUMABILITY] := ActionOfChangeHumAbility;
  FNpcAction[nSC_SENDCENTERMSG] := ActionOfSendCenterMsg;
  FNpcAction[nSC_DARE] := ActionOfDare;
  FNpcAction[nSC_SENDEMAIL] := ActionOfSendEMail;
  FNpcAction[nSC_MOD] := ActionOfMod;
  FNpcAction[nSC_SETHUMICON] := ActionOfSetHumIcon;
  FNpcAction[nSC_CLEARSENDCENTERMSG] := ActionOfClearSendCenterMsg;
  FNpcAction[nSC_TAKEOFFITEM] := ActionOfTakeOffItem;
end;

destructor TNormNpc.Destroy; //0049AAE4
//var
//  i: Integer;
begin
  ClearScript();
  {
  for I := 0 to ScriptList.Count - 1 do begin
    Dispose(pTScript(ScriptList.Items[I]));
  end;
  }
  FGiveItemList.Free;
  FHookItemList.Free;
  m_ScriptList.Free;
  FList1C.Free;
  inherited;
end;

procedure TNormNpc.ExeAction(PlayObject: TPlayObject; sParam1, sParam2,
  sParam3: string; nParam1, nParam2, nParam3: Integer);
var
  nInt1 {, nInt2, nInt3}: Integer;
  dwInt: LongWord;
  //  BaseObject: TBaseObject;
begin
  //================================================
  //更改人物当前经验值
  //EXEACTION CHANGEEXP 0 经验数  设置为指定经验值
  //EXEACTION CHANGEEXP 1 经验数  增加指定经验
  //EXEACTION CHANGEEXP 2 经验数  减少指定经验
  //================================================
  if CompareText(sParam1, 'CHANGEEXP') = 0 then begin
    nInt1 := StrToIntDef(sParam2, -1);
    case nInt1 of //
      0: begin
          if nParam3 >= 0 then begin
            PlayObject.m_Abil.Exp := LongWord(nParam3);
            PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
          end;
        end;
      1: begin
          if PlayObject.m_Abil.Exp >= LongWord(nParam3) then begin
            if (PlayObject.m_Abil.Exp - LongWord(nParam3)) > (High(LongWord) -
              PlayObject.m_Abil.Exp) then begin
              dwInt := High(LongWord) - PlayObject.m_Abil.Exp;
            end
            else begin
              dwInt := LongWord(nParam3);
            end;
          end
          else begin
            if (LongWord(nParam3) - PlayObject.m_Abil.Exp) > (High(LongWord) -
              LongWord(nParam3)) then begin
              dwInt := High(LongWord) - LongWord(nParam3);
            end
            else begin
              dwInt := LongWord(nParam3);
            end;
          end;
          Inc(PlayObject.m_Abil.Exp, dwInt);
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
        end;
      2: begin
          if PlayObject.m_Abil.Exp > LongWord(nParam3) then begin
            Dec(PlayObject.m_Abil.Exp, LongWord(nParam3));
          end
          else begin
            PlayObject.m_Abil.Exp := 0;
          end;
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
        end;
    end;
    PlayObject.SysMsg('您当前经验为: ' + IntToStr(PlayObject.m_Abil.Exp) + '/' + IntToStr(PlayObject.m_Abil.MaxExp), c_Green, t_Hint);
    Exit;
  end;

  //================================================
  //更改人物当前等级
  //EXEACTION CHANGELEVEL 0 等级数  设置为指定等级
  //EXEACTION CHANGELEVEL 1 等级数  增加指定等级
  //EXEACTION CHANGELEVEL 2 等级数  减少指定等级
  //================================================
  if CompareText(sParam1, 'CHANGELEVEL') = 0 then begin
    nInt1 := StrToIntDef(sParam2, -1);
    case nInt1 of //
      0: begin
          if nParam3 >= 0 then begin
            PlayObject.m_Abil.Level := LongWord(nParam3);
            PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
          end;
        end;
      1: begin
          if PlayObject.m_Abil.Level >= LongWord(nParam3) then begin
            if (PlayObject.m_Abil.Level - Word(nParam3)) > (High(Word) -
              PlayObject.m_Abil.Level) then begin
              dwInt := High(Word) - PlayObject.m_Abil.Level;
            end
            else begin
              dwInt := LongWord(nParam3);
            end;
          end
          else begin
            if (LongWord(nParam3) - PlayObject.m_Abil.Level) > (High(Word) -
              LongWord(nParam3)) then begin
              dwInt := High(LongWord) - LongWord(nParam3);
            end
            else begin
              dwInt := LongWord(nParam3);
            end;
          end;
          Inc(PlayObject.m_Abil.Level, dwInt);
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
        end;
      2: begin
          if PlayObject.m_Abil.Level > LongWord(nParam3) then begin
            Dec(PlayObject.m_Abil.Level, LongWord(nParam3));
          end
          else begin
            PlayObject.m_Abil.Level := 0;
          end;
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
        end;
    end;
    PlayObject.SysMsg('您当前等级为: ' + IntToStr(PlayObject.m_Abil.Level), c_Green, t_Hint);
    Exit;
  end;

  //================================================
  //杀死人物
  //EXEACTION KILL 0 人物死亡,不显示凶手信息
  //EXEACTION KILL 1 人物死亡不掉物品,不显示凶手信息
  //EXEACTION KILL 2 人物死亡,显示凶手信息为NPC
  //EXEACTION KILL 3 人物死亡不掉物品,显示凶手信息为NPC
  //================================================
  if CompareText(sParam1, 'KILL') = 0 then begin
    nInt1 := StrToIntDef(sParam2, -1);
    case nInt1 of //
      1: begin
          PlayObject.m_boNoItem := True;
          PlayObject.Die;
        end;
      2: begin
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
      3: begin
          PlayObject.m_boNoItem := True;
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
    else begin
        PlayObject.Die;
      end;
    end;
    Exit;
  end;

  //================================================
  //踢人物下线
  //EXEACTION KICK
  //================================================
  if CompareText(sParam1, 'KICK') = 0 then begin
    PlayObject.m_boKickFlag := True;
    Exit;
  end;

  //==============================================================================
end;

function TNormNpc.GetLineVariableText(PlayObject: TPlayObject; sMsg: string): string;
var
  nC, nR: Integer;
  s10: string;
  tempstr: string;
begin
  for nR := 0 to 2 do begin
    nC := 0;
    if pos('<$', sMsg) <= 0 then
      break;
    tempstr := sMsg;
    while (True) do begin
      if pos('<$', tempstr) <= 0 then
        break;
      tempstr := ArrestStringEx(tempstr, '<', '>', s10);
      if (s10 <> '') and (s10[1] = '$') then begin
        GetVariableText(PlayObject, sMsg, s10);
      end { else break};
      Inc(nC);
      if nC >= 100 then
        break;
    end;
  end;
  Result := sMsg;
end;

function TNormNpc.GetScriptIndex(sLabel: string): Integer;
var
  i: Integer;
  SayingRecord: pTSayingRecord;
begin
  Result := -1;
  if Pos('(', sLabel) > 0 then
    GetValidStr3(sLabel, sLabel, ['(']);
  for i := 0 to m_ScriptList.Count - 1 do begin
    SayingRecord := m_ScriptList.Items[i];
    if SayingRecord = nil then
      Continue;
    if CompareText(sLabel, SayingRecord.sLabel) = 0 then begin
      Result := i;
      break;
    end;
  end;
end;

function TNormNpc.GetShowName: string;
var
  sShowName: string;
begin
  if m_boNameFlag and (m_nNameFlag >= Low(g_Config.GlobalAVal)) and (m_nNameFlag <= High(g_Config.GlobalAVal)) then begin
    sShowName := Trim(g_Config.GlobalAVal[m_nNameFlag]);
    if sShowName = '' then
      Result := '(未知)\' + m_sCharName
    else
      Result := '　' + sShowName + '　\' + m_sCharName;
  end
  else begin
    sShowName := m_sCharName;
    Result := '　' + FilterShowName(sShowName) + '　';
    if m_sHintName <> '' then
      Result := Result + '\' + m_sHintName;
  end;
end;

procedure TNormNpc.GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string);
var
  sText, s14: string;
  i {, ii}: Integer;
  n18 {, n20}: Integer;
  //  ii: Integer;
  //  List: TStringList;
  //  sStr: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  CastleDoor: TCastleDoor;
  PoseHuman: TPlayObject;
  sIdx, sID: string;
  nIdx, nID: integer;
  Castle: TUserCastle;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  //全局信息
  if sVariable = '' then
    exit;
  if sVariable[1] <> '$' then
    exit;
  sIdx := Copy(sVariable, 2, Length(sVariable) - 1);
  sID := GetValidStrEx(sIdx, sIdx, ['/']);
  nIDx := StrToIntDef(sIdx, -1);
  nID := StrToIntDef(sID, -1);
  if nIdx < 0 then begin
    sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '????');
    exit;
  end;
  if m_Castle = nil then
    Castle := g_CastleManager.GetCastle(0)
  else
    Castle := TUserCastle(m_Castle);
  case nIdx of
    {nVAR_REQUESTCASTLELIST: begin
        sText := '';
        List := TStringList.Create;
        g_CastleManager.GetCastleNameList(List);
        for i := 0 to List.Count - 1 do begin
          ii := i + 1;
          if ((ii div 2) * 2 = ii) then
            sStr := '\'
          else
            sStr := '';
          sText := sText + format('<%s/@requestcastlewarnow%d> %s', [List.Strings[i], i, sStr]);
        end;
        sText := sText + '\ \';
        List.Free;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;   }
    nVAR_SERVERNAME: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sServerName);

      end;
    nVAR_SERVERIP: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sServerIPaddr);

      end;
    nVAR_WEBSITE: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sWebSite);

      end;
    nVAR_BBSSITE: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sBbsSite);

      end;
    nVAR_CLIENTDOWNLOAD: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sClientDownload);

      end;
    nVAR_QQ: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sQQ);

      end;
    nVAR_PHONE: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sPhone);

      end;
    nVAR_BANKACCOUNT0: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sBankAccount0);

      end;
    nVAR_BANKACCOUNT1: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sBankAccount1);

      end;
    nVAR_BANKACCOUNT2: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sBankAccount2);

      end;
    nVAR_BANKACCOUNT3: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sBankAccount3);

      end;
    nVAR_BANKACCOUNT4: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sBankAccount4);

      end;
    nVAR_BANKACCOUNT5: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sBankAccount5);

      end;
    nVAR_BANKACCOUNT6: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sBankAccount6);

      end;
    nVAR_BANKACCOUNT7: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sBankAccount7);

      end;
    nVAR_BANKACCOUNT8: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sBankAccount8);

      end;
    nVAR_BANKACCOUNT9: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sBankAccount9);
      end;
    {nVAR_GAMEGOLDNAME: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sSTRING_GOLDNAME);

      end;
    nVAR_GAMEPOINTNAME: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sGamePointName);

      end;   }
    nVAR_USERCOUNT: begin
        sText := IntToStr(UserEngine.PlayObjectCount);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_DATETIME: begin
        sText := FormatDateTime('dddddd,dddd,hh:mm:ss', Now);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_USERNAME: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_sCharName);
      end;
    nVAR_FBMAPNAME: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_FBEnvir.sMapDesc);
      end;
    nVAR_ACCOUNT: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_sUserID);
      end;
    nVAR_ASSEMBLEITEMNAME: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_sASSEMBLEITEMNAME);
      end;
    nVAR_FBMAP: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_FBEnvir.sMapName);
      end;
    nVAR_SELFNAME: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', m_sCharName);
      end;
    nVAR_POSENAME: begin
        PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
        if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PoseHuman.m_sCharName);
        end
        else
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '????');
      end;
    nVAR_MAPNAME: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_PEnvir.sMapDesc);

      end;
    nVAR_MAP: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_PEnvir.sMapName);

      end;
    nVAR_X: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_nCurrX));

      end;
    nVAR_Y: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_nCurrY));

      end;
    nVAR_TEAM: begin
        sText := '????';
        
        if nID in [0..7] then begin
          if PlayObject.m_GroupOwner <> nil then begin
            if nID < TPlayObject(PlayObject.m_GroupOwner).m_GroupMembers.Count then begin
              sText := TPlayObject(PlayObject.m_GroupOwner).m_GroupMembers[nID];
            end;
          end;
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_UNMASTER_FORCE: begin
        sText := '';
        for I := 0 to PlayObject.m_MasterList.Count - 1 do begin
          sText := sText + Format('<&%s/@UnMaster_Force(%d)>\', [PlayObject.m_MasterList[I], I]);
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_GUILDNAME: begin
        if PlayObject.m_MyGuild <> nil then begin
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', TGuild(PlayObject.m_MyGuild).m_sGuildName);
        end
        else begin
          sMsg := '无';
        end;

      end;
    nVAR_RANKNAME: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_sGuildRankName);

      end;
    nVAR_LEVEL: begin
        sText := IntToStr(PlayObject.m_Abil.Level);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_HP: begin
        sText := IntToStr(PlayObject.m_WAbil.HP);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_MAXHP: begin
        sText := IntToStr(PlayObject.m_WAbil.MaxHP);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_MP: begin
        sText := IntToStr(PlayObject.m_WAbil.MP);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_MAXMP: begin
        sText := IntToStr(PlayObject.m_WAbil.MaxMP);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_AC: begin
        sText := IntToStr(LoWord(PlayObject.m_WAbil.AC));
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_MAXAC: begin
        sText := IntToStr(HiWord(PlayObject.m_WAbil.AC));
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_MAC: begin
        sText := IntToStr(LoWord(PlayObject.m_WAbil.MAC));
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_MAXMAC: begin
        sText := IntToStr(HiWord(PlayObject.m_WAbil.MAC));
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_DC: begin
        sText := IntToStr(LoWord(PlayObject.m_WAbil.DC));
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_MAXDC: begin
        sText := IntToStr(HiWord(PlayObject.m_WAbil.DC));
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_MC: begin
        sText := IntToStr(LoWord(PlayObject.m_WAbil.MC));
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_MAXMC: begin
        sText := IntToStr(HiWord(PlayObject.m_WAbil.MC));
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_SC: begin
        sText := IntToStr(LoWord(PlayObject.m_WAbil.SC));
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_MAXSC: begin
        sText := IntToStr(HiWord(PlayObject.m_WAbil.SC));
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_EXP: begin
        sText := IntToStr(PlayObject.m_Abil.Exp);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_MAXEXP: begin
        sText := IntToStr(PlayObject.m_Abil.MaxExp);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_PKPOINT: begin
        sText := IntToStr(PlayObject.m_nPkPoint);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_CREDITPOINT: begin
        sText := IntToStr(PlayObject.m_nCreditPoint);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_GOLDCOUNT: begin
        sText := IntToStr(PlayObject.m_nGold) + '/' + IntToStr(PlayObject.m_nGoldMax);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_USERGOLDCOUNT: begin
        sText := IntToStr(PlayObject.m_nGold);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_MAXGOLDCOUNT: begin
        sText := IntToStr(PlayObject.m_nGoldMax);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_STORAGEGOLDCOUNT: begin
        sText := IntToStr(PlayObject.m_nStorageGold);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_BINDGOLDCOUNT: begin
        sText := IntToStr(PlayObject.m_nBindGold);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_GAMEDIAMOND: begin
        sText := IntToStr(PlayObject.m_nGameDiamond);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_GAMEGIRD: begin
        sText := IntToStr(PlayObject.m_nGameGird);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_GAMEGOLD: begin
        sText := IntToStr(PlayObject.m_nGameGold);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    {nVAR_GAMEPOINT: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.sGamePointName);

      end;   }

    nVAR_UPGRADEWEAPONFEE: begin
        sText := IntToStr(g_Config.nUpgradeWeaponPrice);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_USERWEAPON: begin
        sText := 'Weapon';
        if PlayObject.m_UseItems[U_WEAPON].wIndex <> 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_LOGINTIME: begin
        sText := DateTimeToStr(PlayObject.m_dLogonTime);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_LOGINLONG: begin
        sText := IntToStr((GetTickCount - PlayObject.m_dwLogonTick) div 60000) + '分钟';
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_DRESS: begin
        if PlayObject.m_UseItems[U_DRESS].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_DRESS].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_WEAPON: begin
        if PlayObject.m_UseItems[U_WEAPON].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_RIGHTHAND: begin
        if PlayObject.m_UseItems[U_RIGHTHAND].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RIGHTHAND].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_HELMET: begin
        if PlayObject.m_UseItems[U_HELMET].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_HELMET].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_NECKLACE: begin
        if PlayObject.m_UseItems[U_NECKLACE].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_NECKLACE].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_RING_R: begin
        if PlayObject.m_UseItems[U_RINGR].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGR].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_RING_L: begin
        if PlayObject.m_UseItems[U_RINGL].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGL].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_ARMRING_R: begin
        if PlayObject.m_UseItems[U_ARMRINGR].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGR].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_ARMRING_L: begin
        if PlayObject.m_UseItems[U_ARMRINGL].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_BUJUK: begin
        if PlayObject.m_UseItems[U_BUJUK].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BUJUK].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_BELT: begin
        if PlayObject.m_UseItems[U_BELT].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BELT].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_BOOTS: begin
        if PlayObject.m_UseItems[U_BOOTS].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BOOTS].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_CHARM: begin
        if PlayObject.m_UseItems[U_CHARM].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_CHARM].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_HOUSE: begin
        if PlayObject.m_UseItems[U_HOUSE].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_HOUSE].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_CIMELIA: begin
        if PlayObject.m_UseItems[U_CIMELIA].MakeIndex > 0 then begin
          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_CIMELIA].wIndex);
        end
        else begin
          sText := '无';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_IPADDR: begin
        sText := PlayObject.m_sIPaddr;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_IPLOCAL: begin
        sText := PlayObject.m_sIPLocal;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_GUILDBUILDPOINT: begin
        if PlayObject.m_MyGuild = nil then begin
          sText := '无';
        end
        else begin
          sText := IntToStr(TGuild(PlayObject.m_MyGuild).nBuildPoint);
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_GUILDAURAEPOINT: begin
        if PlayObject.m_MyGuild = nil then begin
          sText := '无';
        end
        else begin
          sText := IntToStr(TGuild(PlayObject.m_MyGuild).nActivityPoint);
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_GUILDSTABILITYPOINT: begin
        if PlayObject.m_MyGuild = nil then begin
          sText := '无';
        end
        else begin
          sText := IntToStr(TGuild(PlayObject.m_MyGuild).nStabilityPoint);
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_GUILDFLOURISHPOINT: begin
        if PlayObject.m_MyGuild = nil then begin
          sText := '无';
        end
        else begin
          sText := IntToStr(TGuild(PlayObject.m_MyGuild).nFlourishingPoint);
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_GUILDMONEYCOUNT: begin
        if PlayObject.m_MyGuild = nil then begin
          sText := '无';
        end
        else begin
          sText := IntToStr(TGuild(PlayObject.m_MyGuild).nMoneyCount);
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_REQUESTCASTLEWARITEM: begin
        sText := g_Config.sZumaPiece;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_REQUESTCASTLEWARDAY: begin
        sText := g_Config.sZumaPiece;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_REQUESTBUILDGUILDITEM: begin
        sText := g_Config.sWomaHorn;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_OWNERGUILD: begin
        if Castle <> nil then begin
          sText := Castle.m_sOwnGuild;
          if sText = '' then
            sText := '[游戏管理]';
        end
        else begin
          sText := '????';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_CASTLENAME: begin
        if Castle <> nil then begin
          sText := Castle.m_sName;
        end
        else begin
          sText := '????';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_LORD: begin
        if Castle <> nil then begin
          if Castle.m_MasterGuild <> nil then begin
            sText := Castle.m_MasterGuild.GetChiefName();
          end
          else
            sText := '[管理员]';
        end
        else begin
          sText := '????';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_GUILDWARFEE: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(g_Config.nGuildWarPrice));

      end;
    nVAR_BUILDGUILDFEE: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(g_Config.nBuildGuildPrice));

      end;
    nVAR_CASTLEWARDATE: begin
        if Castle <> nil then begin
          if not Castle.m_boUnderWar then begin
            sText := Castle.GetWarDate();
            if sText <> '' then begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
            end
            else
              sMsg := '　目前没有行会申请攻城战\ \<返回/@0>';
          end
          else
            sMsg := '现正在攻城中.\ \<返回/@0>';
        end
        else begin
          sText := '????';
        end;

      end;
    nVAR_LISTOFWAR: begin
        if Castle <> nil then begin
          if not Castle.m_boUnderWar then begin
            sText := Castle.GetAttackWarList();
            if sText <> '' then begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
            end
            else
              sMsg := '　目前没有行会申请攻城战\ \<&关闭/@exit>\';
          end
          else
            sMsg := '　正在攻城当中.\ \<&关闭/@exit>\';
        end
        else
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '????');
      end;
    nVAR_CASTLECHANGEDATE: begin
        if Castle <> nil then begin
          sText := DateTimeToStr(Castle.m_ChangeDate);
        end
        else begin
          sText := '????';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_CASTLEWARLASTDATE: begin
        if Castle <> nil then begin
          sText := DateTimeToStr(Castle.m_WarDate);
        end
        else begin
          sText := '????';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_CASTLEGETDAYS: begin
        if Castle <> nil then begin
          sText := IntToStr(GetDayCount(Now, Castle.m_ChangeDate));
        end
        else begin
          sText := '????';
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);

      end;
    nVAR_CMD_DATE: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.Data.sCmd);

      end;
    nVAR_CMD_PRVMSG: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.PRVMSG.sCmd);

      end;
    nVAR_CMD_ALLOWMSG: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.ALLOWMSG.sCmd);

      end;
    nVAR_CMD_LETSHOUT: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.LETSHOUT.sCmd);

      end;
    nVAR_CMD_LETTRADE: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.LETTRADE.sCmd);

      end;
    nVAR_CMD_LETGUILD: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.LETGUILD.sCmd);

      end;
    nVAR_CMD_ENDGUILD: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.ENDGUILD.sCmd);

      end;
    nVAR_CMD_BANGUILDCHAT: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.BANGUILDCHAT.sCmd);

      end;
    nVAR_CMD_AUTHALLY: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.AUTHALLY.sCmd);

      end;
    nVAR_CMD_AUTH: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.AUTHALLY.sCmd);

      end;
    nVAR_CMD_AUTHCANCEL: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.AUTHCANCEL.sCmd);

      end;
    nVAR_CMD_USERMOVE: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.USERMOVE.sCmd);

      end;
    nVAR_CMD_SEARCHING: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.SEARCHING.sCmd);

      end;
    nVAR_CMD_ALLOWGROUPCALL: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
          g_GameCommand.ALLOWGROUPCALL.sCmd);

      end;
    nVAR_CMD_GROUPRECALLL: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',
          g_GameCommand.GROUPRECALLL.sCmd);

      end;
    nVAR_CMD_ALLOWGUILDRECALL: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.ALLOWGUILDRECALL.sCmd);

      end;
    nVAR_CMD_GUILDRECALLL: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.GUILDRECALLL.sCmd);

      end;
    nVAR_CMD_DEAR: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.DEAR.sCmd);

      end;
    nVAR_CMD_ALLOWDEARRCALL: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.ALLOWDEARRCALL.sCmd);

      end;
    nVAR_CMD_DEARRECALL: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.DEARRECALL.sCmd);

      end;
    nVAR_CMD_MASTER: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.MASTER.sCmd);

      end;
    nVAR_CMD_ALLOWMASTERRECALL: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.ALLOWMASTERRECALL.sCmd);

      end;
    nVAR_CMD_MASTERECALL: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.MASTERECALL.sCmd);

      end;
    nVAR_CMD_TAKEONHORSE: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.TAKEONHORSE.sCmd);

      end;
    nVAR_CMD_TAKEOFHORSE: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.TAKEOFHORSE.sCmd);

      end;
    nVAR_CMD_ALLSYSMSG: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.ALLSYSMSG.sCmd);

      end;
    nVAR_CMD_MEMBERFUNCTION: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.MEMBERFUNCTION.sCmd);

      end;
    nVAR_CMD_MEMBERFUNCTIONEX: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.MEMBERFUNCTIONEX.sCmd);

      end;
    nVAR_CMD_ALLOWFIREND: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.ALLOWFIREND.sCmd);
      end;
    nVAR_CMD_STARTQUEST: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_GameCommand.STARTQUEST.sCmd);
      end;
    nVAR_EFFIGYSTATE: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.GetFeature(Self) or PlayObject.m_btDressEffType));
      end;
    nVAR_EFFIGYOFFSET: begin
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(m_nEffigyOffset));
      end;
    nVAR_YEAR: begin
        DecodeDate(Now, Year, Month, Day);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(Year));
      end;
    nVAR_MONTH: begin
        DecodeDate(Now, Year, Month, Day);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(Month));
      end;
    nVAR_DAY: begin
        DecodeDate(Now, Year, Month, Day);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(Day));
      end;
    nVAR_HOUR: begin
        DecodeTime(Time, Hour, Min, Sec, MSec);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(Hour));
      end;
    nVAR_MINUTE: begin
        DecodeTime(Time, Hour, Min, Sec, MSec);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(Min));
      end;
    nVAR_SEC: begin
        DecodeTime(Time, Hour, Min, Sec, MSec);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(Sec));
      end;
    nVAR_CASTLEGOLD: begin
        if Castle = nil then begin
          sMsg := '????';
          Exit;
        end;
        sText := IntToStr(Castle.m_nTotalGold);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_TODAYINCOME: begin
        if Castle = nil then begin
          sMsg := '????';
          Exit;
        end;
        sText := IntToStr(Castle.m_nTodayIncome);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_CASTLEDOORSTATE: begin
        if Castle = nil then begin
          sMsg := '????';
          Exit;
        end;
        CastleDoor := TCastleDoor(Castle.m_MainDoor.BaseObject);
        if CastleDoor.m_boDeath then
          sText := '损坏'
        else if CastleDoor.m_boOpened then
          sText := '开启'
        else
          sText := '关闭';
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_REPAIRDOORGOLD: begin
        sText := IntToStr(g_Config.nRepairDoorPrice);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_REPAIRWALLGOLD: begin
        sText := IntToStr(g_Config.nRepairWallPrice);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_GUARDFEE: begin
        sText := IntToStr(g_Config.nHireGuardPrice);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_ARCHERFEE: begin
        sText := IntToStr(g_Config.nHireArcherPrice);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_GUARDRULE: begin
        if Castle = nil then begin
          sMsg := '????';
          Exit;
        end;
        if Castle.m_boGuardRule then
          sText := '进攻PK者'
        else
          sText := '正常防御';
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_STORAGE2STATE: begin
        if PlayObject.m_boStorageOpen[1] then begin
          sText := FormatDateTime('YYYY年MM月DD日 HH时', PlayObject.m_dwStorageTime[1]);
        end
        else
          sText := '尚未开启';
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_STORAGE3STATE: begin
        if PlayObject.m_boStorageOpen[2] then begin
          sText := FormatDateTime('YYYY年MM月DD日 HH时', PlayObject.m_dwStorageTime[2]);
        end
        else
          sText := '尚未开启';
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_STORAGE4STATE: begin
        if PlayObject.m_boStorageOpen[3] then begin
          sText := FormatDateTime('YYYY年MM月DD日 HH时', PlayObject.m_dwStorageTime[3]);
        end
        else
          sText := '尚未开启';
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_STORAGE5STATE: begin
        if PlayObject.m_boStorageOpen[4] then begin
          sText := FormatDateTime('YYYY年MM月DD日 HH时', PlayObject.m_dwStorageTime[4]);
        end
        else
          sText := '尚未开启';
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      end;
    nVAR_HUMAN: begin
        s14 := sID;
        boFoundVar := False;
        for i := 0 to PlayObject.m_DynamicVarList.Count - 1 do begin
          DynamicVar := PlayObject.m_DynamicVarList.Items[i];
          if CompareText(DynamicVar.sName, s14) = 0 then begin
            case DynamicVar.VarType of
              vInteger: begin
                  sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
                  boFoundVar := True;
                end;
              vString: begin
                  sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
                  boFoundVar := True;
                end;
            end;
            break;
          end;
        end;
        if not boFoundVar then
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '????');
      end;
    nVAR_GUILD: begin
        if PlayObject.m_MyGuild = nil then
          Exit;
        s14 := sID;
        boFoundVar := False;
        for i := 0 to TGuild(PlayObject.m_MyGuild).m_DynamicVarList.Count - 1 do begin
          DynamicVar := TGuild(PlayObject.m_MyGuild).m_DynamicVarList.Items[i];
          if CompareText(DynamicVar.sName, s14) = 0 then begin
            case DynamicVar.VarType of
              vInteger: begin
                  sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
                  boFoundVar := True;
                end;
              vString: begin
                  sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
                  boFoundVar := True;
                end;
            end;
            break;
          end;
        end;
        if not boFoundVar then
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '????');
      end;
    nVAR_GLOBAL: begin
        s14 := sID;
        boFoundVar := False;
        for i := 0 to g_DynamicVarList.Count - 1 do begin
          DynamicVar := g_DynamicVarList.Items[i];
          if CompareText(DynamicVar.sName, s14) = 0 then begin
            case DynamicVar.VarType of
              vInteger: begin
                  sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
                  boFoundVar := True;
                end;
              vString: begin
                  sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
                  boFoundVar := True;
                end;
            end;
            break;
          end;
        end;
        if not boFoundVar then
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '????');
      end;
    nVAR_STR: begin
        n18 := GetValNameNo(sID);
        if n18 >= 0 then begin
          case n18 of
            0..99: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_nVal[n18]));
                exit;
              end;
            2000..2999: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(g_Config.GlobalVal[n18 - 2000]));
                exit;
              end;
            200..209: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_DyVal[n18 - 200]));
                exit;
              end;
            300..399: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_nMval[n18 - 300]));
                exit;
              end;
            400..499: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(g_Config.GlobaDyMval[n18 - 400]));
                exit;
              end;
            5000..5999: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_nInteger[n18 - 5000]));
                exit;
              end;
            6000..6999: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_sString[n18 - 6000]);
                exit;
              end;
            7000..7999: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.GlobalAVal[n18 - 7000]);
                exit;
              end;
            800..899: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.GlobalUVal[n18 - 800]);
                exit;
              end;
            900..909: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', m_GotoValue[n18 - 900]);
                exit;
              end;
            1000..1019: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_CustomVariable[n18 - 1000]));
                exit;
              end;
          else begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '????');
            end;
          end;
        end;
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '????');
      end;
    nVAR_MISSIONARITHMOMETER: begin
        nID := StrToIntDef(sID, -1);
        if nID in [Low(PlayObject.m_MissionArithmometer)..High(PlayObject.m_MissionArithmometer)] then
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_MissionArithmometer[nID]))
        else
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '????');
      end;
  else
    sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', '????');
  end;

end;

function TNormNpc.GotoLable(PlayObjectEx: TPlayObject; nLabel: Integer; boExtJmp: Boolean; sLabel: string): string;
var
  //i, ii,
  III: Integer;
  sSENDMSG: string;
  //Script: pTScript;
  //Script3C: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
  //  UserItem: pTUserItem;
  PlayObject: TPlayObject;
  OldLabelList: TStringList;
  NewLabelList: TStringList;
  //  SC: string;

  {function CheckQuestStatus(ScriptInfo: pTScript): Boolean; //0049BA00
  var
    i: Integer;
  begin
    Result := True;
    if not ScriptInfo.boQuest then
      Exit;
    i := 0;
    while (True) do begin
      if (ScriptInfo.QuestInfo[i].nRandRage > 0) and
        (Random(ScriptInfo.QuestInfo[i].nRandRage) <> 0) then begin
        Result := False;
        break;
      end;
      if PlayObject.GetQuestFalgStatus(ScriptInfo.QuestInfo[i].wFlag) <>
        ScriptInfo.QuestInfo[i].btValue then begin
        Result := False;
        break;
      end;
      Inc(i);
      if i >= 10 then
        break;
    end; // while
  end;               }

  procedure GetValStringAndInteger(var Str: string; var Int: Integer);
  begin
    Str := GetLineVariableText(PlayObject, Str);
    Int := StrToIntDef(Str, 0);
  end;

  procedure ChangQuestCheckConditionVal(QuestConditionInfo: pTQuestConditionInfo);
  var
    i: Integer;
  begin
    for i := 1 to 9 do begin
      case i of
        1: begin
            if QuestConditionInfo.boDynamic1 then
              GetValStringAndInteger(QuestConditionInfo.sParam1, QuestConditionInfo.nParam1);
          end;
        2: begin
            if QuestConditionInfo.boDynamic2 then
              GetValStringAndInteger(QuestConditionInfo.sParam2, QuestConditionInfo.nParam2);
          end;
        3: begin
            if QuestConditionInfo.boDynamic3 then
              GetValStringAndInteger(QuestConditionInfo.sParam3, QuestConditionInfo.nParam3);
          end;
        4: begin
            if QuestConditionInfo.boDynamic4 then
              GetValStringAndInteger(QuestConditionInfo.sParam4, QuestConditionInfo.nParam4);
          end;
        5: begin
            if QuestConditionInfo.boDynamic5 then
              GetValStringAndInteger(QuestConditionInfo.sParam5, QuestConditionInfo.nParam5);
          end;
        6: begin
            if QuestConditionInfo.boDynamic6 then
              GetValStringAndInteger(QuestConditionInfo.sParam6, QuestConditionInfo.nParam6);
          end;
        7: begin
            if QuestConditionInfo.boDynamic7 then
              GetValStringAndInteger(QuestConditionInfo.sParam7, QuestConditionInfo.nParam7);
          end;
        8: begin
            if QuestConditionInfo.boDynamic8 then
              GetValStringAndInteger(QuestConditionInfo.sParam8, QuestConditionInfo.nParam8);
          end;
        9: begin
            if QuestConditionInfo.boDynamic9 then
              GetValStringAndInteger(QuestConditionInfo.sParam9, QuestConditionInfo.nParam9);
          end;
      end;
    end;
  end;

  function QuestCheckCondition(ConditionList: TList): Boolean;
  var
    i, II: integer;
    QuestConditionInfo: pTQuestConditionInfo;
    TempQuestConditionInfo: TQuestConditionInfo;
    boFlag: Boolean;
    sName: string;
  begin
    Result := True;
    try
      for i := 0 to ConditionList.Count - 1 do begin
        PlayObject := PlayObjectEx;
        QuestConditionInfo := ConditionList.Items[i];
        TempQuestConditionInfo := QuestConditionInfo^;
        QuestConditionInfo := @TempQuestConditionInfo;
        //通用三方执行脚本支持
        if QuestConditionInfo.TCmdList <> nil then begin
          boFlag := False;
          for II := 0 to QuestConditionInfo.TCmdList.Count - 1 do begin
            sName := QuestConditionInfo.TCmdList.Strings[II];
            sName := GetLineVariableText(PlayObject, sName);
            PlayObject := UserEngine.GetPlayObject(sName);
            if PlayObject = nil then begin
              ScriptListError(PlayObjectEx, QuestConditionInfo.TCmdList);
              boFlag := True;
              break;
            end;
          end;
          if boFlag then
            Continue;
        end;
        ChangQuestCheckConditionVal(QuestConditionInfo);
        if (QuestConditionInfo.nCMDCode > 0) and (QuestConditionInfo.nCMDCode < MAXNPCPROCEDURECOUNT) then begin
          try
            if Assigned(FNpcCondition[QuestConditionInfo.nCMDCode]) then
              FNpcCondition[QuestConditionInfo.nCMDCode](PlayObject, QuestConditionInfo, Result);
          except
            on E: Exception do begin
              MainOutMessage('[Exception] TNormNpc->QuestCheckCondition->Condition->' +
                IntToStr(QuestConditionInfo.nCMDCode) + ' ' +
                QuestConditionInfo.sParam1 + ' ' +
                QuestConditionInfo.sParam2 + ' ' +
                QuestConditionInfo.sParam3 + ' ' +
                QuestConditionInfo.sParam4 + ' ' +
                QuestConditionInfo.sParam5 + ' ' +
                QuestConditionInfo.sParam6 + ' ' +
                QuestConditionInfo.sParam7 + ' ');
              MainOutMessage(E.Message);
              Result := False;
              break;
            end;
          end;
{$IFDEF PLUGOPEN}
        end
        else begin
          if Assigned(zPlugOfEngine.ScriptCondition) then begin
            try
              if not zPlugOfEngine.ScriptCondition(Self,
                PlayObject,
                QuestConditionInfo.nCMDCode,
                PChar(QuestConditionInfo.sParam1),
                QuestConditionInfo.nParam1,
                PChar(QuestConditionInfo.sParam2),
                QuestConditionInfo.nParam2,
                PChar(QuestConditionInfo.sParam3),
                QuestConditionInfo.nParam3,
                PChar(QuestConditionInfo.sParam4),
                QuestConditionInfo.nParam4,
                PChar(QuestConditionInfo.sParam5),
                QuestConditionInfo.nParam5,
                PChar(QuestConditionInfo.sParam6),
                QuestConditionInfo.nParam6) then
                Result := False;
            except
              Result := False;
            end;
          end;
{$ENDIF}
        end;
        if Result <> QuestConditionInfo.boResult then begin
          Result := False;
          break;
        end
        else
          Result := True;
      end;
    except
      on E: Exception do begin
        MainOutMessage('[Exception] TNormNpc->QuestCheckCondition');
        MainOutMessage(E.Message);
        Result := False;
      end;
    end;
  end;

  procedure ChangQuestCheckActionVal(QuestActionInfo: pTQuestActionInfo);
  var
    i: Integer;
  begin
    for i := 1 to 9 do begin
      case i of
        1: begin
            if QuestActionInfo.boDynamic1 then
              GetValStringAndInteger(QuestActionInfo.sParam1, QuestActionInfo.nParam1);
          end;
        2: begin
            if QuestActionInfo.boDynamic2 then
              GetValStringAndInteger(QuestActionInfo.sParam2, QuestActionInfo.nParam2);
          end;
        3: begin
            if QuestActionInfo.boDynamic3 then
              GetValStringAndInteger(QuestActionInfo.sParam3, QuestActionInfo.nParam3);
          end;
        4: begin
            if QuestActionInfo.boDynamic4 then
              GetValStringAndInteger(QuestActionInfo.sParam4, QuestActionInfo.nParam4);
          end;
        5: begin
            if QuestActionInfo.boDynamic5 then
              GetValStringAndInteger(QuestActionInfo.sParam5, QuestActionInfo.nParam5);
          end;
        6: begin
            if QuestActionInfo.boDynamic6 then
              GetValStringAndInteger(QuestActionInfo.sParam6, QuestActionInfo.nParam6);
          end;
        7: begin
            if QuestActionInfo.boDynamic7 then
              GetValStringAndInteger(QuestActionInfo.sParam7, QuestActionInfo.nParam7);
          end;
        8: begin
            if QuestActionInfo.boDynamic8 then
              GetValStringAndInteger(QuestActionInfo.sParam8, QuestActionInfo.nParam8);
          end;
        9: begin
            if QuestActionInfo.boDynamic9 then
              GetValStringAndInteger(QuestActionInfo.sParam9, QuestActionInfo.nParam9);
          end;
      end;
    end;
  end;

  function QuestActionProcess(ActionList: TList): Boolean; //0049D660
  var
    i, II: Integer;
    QuestActionInfo: pTQuestActionInfo;
    TempQuestActionInfo: TQuestActionInfo;
    boFlag: Boolean;
    sName: string;
  begin
    FResult := True;
    Fn18 := 0;
    Fn34 := 0;
    Fn38 := 0;
    Fn3C := 0;
    Fn40 := 0;
    try
      FGiveItemList.Clear;
      FHookItemList.Clear;
      FMasterBase := nil;
      for i := 0 to ActionList.Count - 1 do begin
        PlayObject := PlayObjectEx;
        QuestActionInfo := ActionList.Items[i];
        TempQuestActionInfo := QuestActionInfo^;
        QuestActionInfo := @TempQuestActionInfo;
        //通用三方执行脚本支持
        if QuestActionInfo.TCmdList <> nil then begin
          boFlag := False;
          for II := 0 to QuestActionInfo.TCmdList.Count - 1 do begin
            sName := QuestActionInfo.TCmdList.Strings[II];
            sName := GetLineVariableText(PlayObject, sName);
            PlayObject := UserEngine.GetPlayObject(sName);
            if PlayObject = nil then begin
              ScriptListError(PlayObjectEx, QuestActionInfo.TCmdList);
              boFlag := True;
              break;
            end;
          end;
          if boFlag then
            Continue;
        end;
        ChangQuestCheckActionVal(QuestActionInfo);
        if (QuestActionInfo.nCMDCode > 0) and (QuestActionInfo.nCMDCode < MAXNPCPROCEDURECOUNT) then begin
          try
            if Assigned(FNpcAction[QuestActionInfo.nCMDCode]) then begin
              if (QuestActionInfo.nCMDCode <> nSC_DYNAMICGIVE) and (QuestActionInfo.nCMDCode <> nSC_CHANGEGIVEITEM) then begin
                FGiveItemList.Clear;
              end;
              if (QuestActionInfo.nCMDCode <> nSC_CHANGEGIVEITEM) and (QuestActionInfo.nCMDCode <> nSC_HOOKITEM) then begin
                FHookItemList.Clear;
              end;
              if (QuestActionInfo.nCMDCode <> nSC_MOBECTYPEMON) then
                FMasterBase := nil;
              FNpcAction[QuestActionInfo.nCMDCode](PlayObject, QuestActionInfo);
            end;
          except
            on E: Exception do begin
              MainOutMessage('[Exception] TNormNpc->QuestActionProcess->Action->' +
                IntToStr(QuestActionInfo.nCMDCode) + ' ' +
                QuestActionInfo.sParam1 + ' ' +
                QuestActionInfo.sParam2 + ' ' +
                QuestActionInfo.sParam3 + ' ' +
                QuestActionInfo.sParam4 + ' ' +
                QuestActionInfo.sParam5 + ' ' +
                QuestActionInfo.sParam6 + ' ' +
                QuestActionInfo.sParam7 + ' ');
              MainOutMessage(E.Message);
              FResult := False;
              break;
            end;
          end;
{$IFDEF PLUGOPEN}
        end
        else begin
          if Assigned(zPlugOfEngine.ScriptAction) then begin
            try
              zPlugOfEngine.ScriptAction(Self,
                PlayObject,
                QuestActionInfo.nCMDCode,
                PChar(QuestActionInfo.sParam1),
                QuestActionInfo.nParam1,
                PChar(QuestActionInfo.sParam2),
                QuestActionInfo.nParam2,
                PChar(QuestActionInfo.sParam3),
                QuestActionInfo.nParam3,
                PChar(QuestActionInfo.sParam4),
                QuestActionInfo.nParam4,
                PChar(QuestActionInfo.sParam5),
                QuestActionInfo.nParam5,
                PChar(QuestActionInfo.sParam6),
                QuestActionInfo.nParam6);
            except
            end;
          end;
{$ENDIF}
        end;
      end;
    except
      on E: Exception do begin
        MainOutMessage('[Exception] TNormNpc->QuestActionProcess');
        MainOutMessage(E.Message);
        FResult := False;
      end;
    end;
    Result := FResult;
  end;
  procedure SendMerChantSayMsg(sMsg: string; boFlag: Boolean); //0049E3E0
    {var
      s10, s14: string;
      nC: Integer;}
  begin
    //s14 := sMsg;
    {nC := 0;
    while (True) do begin
      if Pos('>', sMsg) <= 0 then break;
      if Pos('<$', sMsg) <= 0 then break;
      ArrestStringEx(sMsg, '$', '>', s10);
      if s10 = '' then break;
      GetVariableText(PlayObject, sMsg, '$' + s10);
      Inc(nC);
      if nC >= 101 then break;
    end;      }
    if sMsg <> '' then begin
      sMsg := GetLineVariableText(PlayObject, sMsg);
      PlayObject.m_boResetLabel := False;
      if CompareLStr(sMsg, RESETLABEL, 11) then begin
        sMsg := Copy(sMsg, 12, Length(sMsg) - 11);
      end;
      PlayObject.m_boResetLabel := True;
      PlayObject.GetScriptLabel(sMsg);
      PlayObject.GetScriptLabel(NewLabelList, OldLabelList);
      if boFlag then begin
        if SayingRecord.boUserWindow then
          PlayObject.SendFirstDefMsg(Self, SM_MERCHANTSAY, Integer(Self), SayingRecord.nResID, SayingRecord.nWindowWidth, SayingRecord.nWindowHeight, m_sCharName + '/' + sMsg)
        else
          PlayObject.SendFirstDefMsg(Self, SM_MERCHANTSAY, Integer(Self), 0, 0, 0, m_sCharName + '/' + sMsg);
      end
      else begin
        if SayingRecord.boUserWindow then
          PlayObject.SendDefMsg(Self, SM_MERCHANTSAY, Integer(Self), SayingRecord.nResID, SayingRecord.nWindowWidth, SayingRecord.nWindowHeight, m_sCharName + '/' + sMsg)
        else
          PlayObject.SendDefMsg(Self, SM_MERCHANTSAY, Integer(Self), 0, 0, 0, m_sCharName + '/' + sMsg);
      end;
      PlayObject.m_ClickNPC := Self;
      FOldLabel := nLabel;
    end;
  end;

  procedure FormatLabelStr(sLabel: string);
  var
    sStr: string;
    nIdx: Integer;
    //I: Integer;
  begin
    {for I := Low(m_GotoValue) to High(m_GotoValue) do
      m_GotoValue[I] := '';  }

    if (sLabel <> '') and (Pos('(', sLabel) > 0) then begin
      ArrestStringEx(sLabel, '(', ')', sLabel);
      nIdx := Low(m_GotoValue);
      while True do begin
        if sLabel = '' then
          break;
        sLabel := GetValidStr3(sLabel, sStr, [' ', ',', #9]);
        if sStr = '' then
          break;
        sStr := AnsiReplaceText(sStr, '#40', '(');
        sStr := AnsiReplaceText(sStr, '#41', ')');
        m_GotoValue[nIdx] := sStr;
        Inc(nIdx);
        if nIdx > High(m_GotoValue) then
          break;
      end;
    end;
  end;
begin
  //Script := nil;
  Result := '';
  OldLabelList := nil;
  NewLabelList := nil;
  PlayObject := PlayObjectEx;
  FList1C.Clear;
  Fn20 := 0;
  if PlayObject.m_NPC <> Self then begin
    PlayObject.m_NPC := nil;
    SafeFillChar(PlayObject.m_nVal[0], SizeOf(Integer) * Length(PlayObject.m_nVal), #0);
  end;

  //跳转到指定示签，执行
  if (nLabel >= 0) and (nLabel < m_ScriptList.Count) then begin
    PlayObject.m_NPC := Self;
    SayingRecord := m_ScriptList.Items[nLabel];
    if boExtJmp and not SayingRecord.boExtJmp then
      exit;
    sSENDMSG := '';
    Result := SayingRecord.sLabel;
    FormatLabelStr(sLabel);
    for III := 0 to SayingRecord.ProcedureList.Count - 1 do begin
      SayingProcedure := SayingRecord.ProcedureList.Items[III];
      if SayingProcedure = nil then
        Continue;
      bo11 := False;
      PlayObject := PlayObjectEx;
      if QuestCheckCondition(SayingProcedure.ConditionList) then begin
        sSENDMSG := sSENDMSG + SayingProcedure.sSayMsg;
        OldLabelList := SayingProcedure.SayOldLabelList;
        NewLabelList := SayingProcedure.SayNewLabelList;
        if not QuestActionProcess(SayingProcedure.ActionList) then
          break;
        if bo11 then begin
          PlayObject := PlayObjectEx;
          SendMerChantSayMsg(sSENDMSG, True);
        end;
      end
      else begin
        sSENDMSG := sSENDMSG + SayingProcedure.sElseSayMsg;
        OldLabelList := SayingProcedure.ElseSayOldLabelList;
        NewLabelList := SayingProcedure.ElseSayNewLabelList;
        if not QuestActionProcess(SayingProcedure.ElseActionList) then
          break;
        if bo11 then begin
          PlayObject := PlayObjectEx;
          SendMerChantSayMsg(sSENDMSG, True);
        end;
      end;
      PlayObject := PlayObjectEx;
    end;
    if sSENDMSG <> '' then begin
      PlayObject := PlayObjectEx;
      SendMerChantSayMsg(sSENDMSG, False);
    end;
  end;

  //跳转到指定示签，执行
  {for ii := 0 to m_ScriptList.Count - 1 do begin
    SayingRecord := m_ScriptList.Items[ii];
    if SayingRecord = nil then
      Continue;
    if CompareText(sLabel, SayingRecord.sLabel) = 0 then begin

    end;
  end; }
end;

procedure TNormNpc.LoadNpcScript;
var
  s08: string;
begin
  if m_boIsQuest then begin
    m_sPath := sNpc_def;
    s08 := m_sCharName + '-' + m_sMapName;
    FrmDB.LoadNpcScript(Self, m_sFilePath, s08);
  end
  else begin
    m_sPath := m_sFilePath;
    s08 := m_sCharName;
    if (Self is TMerchant) and (TMerchant(Self).m_sScript <> '') then
      s08 := TMerchant(Self).m_sScript;
    FrmDB.LoadNpcScript(Self, m_sFilePath, s08);
  end;
end;

function TNormNpc.Operate(ProcessMsg: pTProcessMessage): Boolean; //0049AB64
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TNormNpc.Run;
//var
//  nInteger: Integer;
begin
  if m_Master <> nil then
    m_Master := nil; //不允许召唤为宝宝
  //NPC变色
  {if (m_boNpcAutoChangeColor) and (m_dwNpcAutoChangeColorTime > 0) and
    (GetTickCount - m_dwNpcAutoChangeColorTick > m_dwNpcAutoChangeColorTime) then begin
    m_dwNpcAutoChangeColorTick := GetTickCount();
    case m_nNpcAutoChangeIdx of
      0: nInteger := STATE_TRANSPARENT;
      1: nInteger := POISON_STONE;
      2: nInteger := POISON_DONTMOVE;
      3: nInteger := POISON_68;
      4: nInteger := POISON_DECHEALTH;
      5: nInteger := POISON_LOCSPELL;
      6: nInteger := POISON_DAMAGEARMOR;
    else begin
        m_nNpcAutoChangeIdx := 0;
        nInteger := STATE_TRANSPARENT;
      end;
    end;
    m_nNpcAutoChangeIdx := 0;
    nInteger := STATE_TRANSPARENT;
    Inc(m_nNpcAutoChangeIdx);
    m_nCharStatus := Integer(m_nCharStatusEx and $FFFFF) or Integer(($80000000 shr nInteger) or 0);
    StatusChanged();
  end;
  if m_boFixColor and (m_nFixStatus <> m_nCharStatus) then begin
    case m_nFixColorIdx of
      0: nInteger := STATE_TRANSPARENT;
      1: nInteger := POISON_STONE;
      2: nInteger := POISON_DONTMOVE;
      3: nInteger := POISON_68;
      4: nInteger := POISON_DECHEALTH;
      5: nInteger := POISON_LOCKSPELL;
      6: nInteger := POISON_DAMAGEARMOR;
    else begin
        m_nFixColorIdx := 0;
        nInteger := STATE_TRANSPARENT;
      end;
    end;
    m_nCharStatus := Integer(m_nCharStatusEx and $FFFFF) or Integer(($80000000
      shr nInteger) or 0);
    m_nFixStatus := m_nCharStatus;
    StatusChanged();
  end;    }
  inherited;
end;

procedure TNormNpc.ScriptActionError(PlayObject: TPlayObject; sErrMsg: string;
  QuestActionInfo: pTQuestActionInfo; sCmd: string);
var
  sMsg: string;
resourcestring
  sOutMessage =
    '[脚本错误] %s 脚本命令:%s NPC名称:%s 地图:%s(%d:%d) 参数1:%s 参数2:%s 参数3:%s 参数4:%s 参数5:%s 参数6:%s';
begin
  sMsg := format(sOutMessage, [sErrMsg,
    sCmd,
      m_sCharName,
      m_sMapName,
      m_nCurrX,
      m_nCurrY,
      QuestActionInfo.sParam1,
      QuestActionInfo.sParam2,
      QuestActionInfo.sParam3,
      QuestActionInfo.sParam4,
      QuestActionInfo.sParam5,
      QuestActionInfo.sParam6]);
  {
  sMsg:='脚本命令:' + sCmd +
        ' NPC名称:' + m_sCharName +
        ' 地图:' + m_sMapName +
        ' 座标:' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) +
        ' 参数1:' + QuestActionInfo.sParam1 +
        ' 参数2:' + QuestActionInfo.sParam2 +
        ' 参数3:' + QuestActionInfo.sParam3 +
        ' 参数4:' + QuestActionInfo.sParam4 +
        ' 参数5:' + QuestActionInfo.sParam5 +
        ' 参数6:' + QuestActionInfo.sParam6;
  }
  MainOutMessage(sMsg);
end;

procedure TNormNpc.ScriptConditionError(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; sCmd: string);
var
  sMsg: string;
begin
  sMsg := 'Cmd:' + sCmd +
    ' NPC名称:' + m_sCharName +
    ' 地图:' + m_sMapName +
    ' 座标:' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) +
    ' 参数1:' + QuestConditionInfo.sParam1 +
    ' 参数2:' + QuestConditionInfo.sParam2 +
    ' 参数3:' + QuestConditionInfo.sParam3 +
    ' 参数4:' + QuestConditionInfo.sParam4 +
    ' 参数5:' + QuestConditionInfo.sParam5;
  MainOutMessage('[脚本参数不正确] ' + sMsg);
end;

procedure TNormNpc.ScriptListError(PlayObject: TPlayObject; List: TStringList);
var
  sMsg: string;
  I: Integer;
begin
  sMsg := '[多级脚本错误] NPC名称:' + m_sCharName + ' ';
  for i := 0 to List.Count - 1 do begin
    sMsg := sMsg + List.Strings[I] + ' ';
  end;
  MainOutMessage(sMsg);
end;
{
procedure TNormNpc.SendMsgToUser(PlayObject: TPlayObject; sMsg: string);
//0049AD14
begin
PlayObject.SendDefMsg(Self, SM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/' + sMsg);
end;       }

function TNormNpc.sub_49ADB8(sMsg, sStr, sText: string): string; //0049ADB8
var
  n10: Integer;
  s14, s18: string;
begin
  //Result := AnsiReplaceText(sMsg, sStr, sText);
  n10 := Pos(sStr, sMsg);
  if n10 > 0 then begin
    s14 := Copy(sMsg, 1, n10 - 1);
    s18 := Copy(sMsg, Length(sStr) + n10, Length(sMsg));
    Result := s14 + sText + s18;
  end
  else
    Result := sMsg;
end;

procedure TNormNpc.UserSelect(PlayObject: TPlayObject; sData: string); //0049EC28
//var
//  sMsg, sLabel: string;
begin
  PlayObject.m_nScriptGotoCount := 0;

  //==============================================
  //处理脚本命令 @back 返回上级标签内容
  {if (sData <> '') and (sData[1] = '@') then begin
    sMsg := GetValidStr3(sData, sLabel, [#13]);
    if (PlayObject.m_sScriptCurrLable <> sLabel) then begin
      if (sLabel <> sBACK) then begin
        PlayObject.m_sScriptGoBackLable := PlayObject.m_sScriptCurrLable;
        PlayObject.m_sScriptCurrLable := sLabel;
      end
      else begin
        if PlayObject.m_sScriptCurrLable <> '' then begin
          PlayObject.m_sScriptCurrLable := '';
        end
        else begin
          PlayObject.m_sScriptGoBackLable := '';
        end;
      end;
    end;
  end;    }
  //==============================================
end;

procedure TNormNpc.ActionOfChangeNakedCount(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nCount, nOldCount: Integer;
  cMethod: Char;
begin
  nCount := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (nCount < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGENAKEDCOUNT);
    Exit;
  end;
  nOldCount := PlayObject.m_nNakedCount;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '+': IntegerChange(PlayObject.m_nNakedCount, nCount, INT_ADD);
    '-': IntegerChange(PlayObject.m_nNakedCount, nCount, INT_DEL);
    '=': PlayObject.m_nNakedCount := nCount;
  end;
  if PlayObject.m_nNakedCount <> nOldCount then
    PlayObject.SendNakedAbility;
end;

procedure TNormNpc.ActionOfChangeNameColor(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nColor: Integer;
begin
  nColor := QuestActionInfo.nParam1;
  if (nColor < 0) or (nColor > 255) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGENAMECOLOR);
    Exit;
  end;
  PlayObject.m_btNameColor := nColor;
  PlayObject.RefNameColor();
end;
{
procedure TNormNpc.ActionOfClearPassword(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_sStoragePwd := '';
  PlayObject.m_boPasswordLocked := False;
end;     }
//RECALLMOB 怪物名称 等级 叛变时间 变色(0,1) 固定颜色(1 - 7)
//变色为0 时固定颜色才起作用

procedure TNormNpc.ActionOfRecallmob(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  //  boAutoChangeColor: Boolean;
  mon: TBaseObject;
  //  i: Integer;
  //  UserItem: pTUserItem;
begin
  if QuestActionInfo.nParam3 <= 1 then begin
    mon := PlayObject.MakeSlave(QuestActionInfo.sParam1, 3, StrToIntDef(QuestActionInfo.sParam2, 0), 100, -1, 5 * 24 * 60 * 60);
  end
  else begin
    mon := PlayObject.MakeSlave(QuestActionInfo.sParam1, 3, StrToIntDef(QuestActionInfo.sParam2, 0), 100, -1, QuestActionInfo.nParam3 * 60)
  end;
  if mon <> nil then begin
    if (QuestActionInfo.sParam4 <> '') and (QuestActionInfo.sParam4[1] = '1') then begin
      mon.m_boAutoChangeColor := True;
    end
    else if QuestActionInfo.nParam5 > 0 then begin
      mon.m_boFixColor := True;
      mon.m_nFixColorIdx := QuestActionInfo.nParam5 - 1;
    end;

    {if mon.m_btRaceServer = RC_PLAYMOSTER then begin //如果是人形怪，可以吃药和捡物品
      mon.m_nCopyHumanLevel := 1;
      for i := 0 to m_ItemList.Count - 1 do begin //清除包裹
        DisPose(m_ItemList.Items[i]);
      end;
      m_ItemList.Clear;
      TPlayMonster(mon).InitializeMonster; //重新加载怪物设置
    end;        }
  end;
end;

procedure TNormNpc.ActionOfReGoto(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  s4C: string;
  OnLinePlayObject: TPlayObject;
begin
  s4C := QuestActionInfo.sParam1;
  if s4C <> '' then begin
    OnLinePlayObject := UserEngine.GetPlayObject(s4C);
    if PlayObject <> nil then begin
      PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      PlayObject.SpaceMove(OnLinePlayObject.m_PEnvir, OnLinePlayObject.m_nCurrX,
        OnLinePlayObject.m_nCurrY, 0);
      bo11 := True;
    end;
  end;
end;

procedure TNormNpc.ActionOfReNewLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nReLevel, nLevel: Integer;
  nBounsuPoint: Integer;
begin
  nReLevel := StrToIntDef(QuestActionInfo.sParam1, -1);
  nLevel := StrToIntDef(QuestActionInfo.sParam2, -1);
  nBounsuPoint := StrToIntDef(QuestActionInfo.sParam3, -1);
  if (nReLevel < 0) or (nLevel < 0) or (nBounsuPoint < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_RENEWLEVEL);
    Exit;
  end;
  if (PlayObject.m_btReLevel + nReLevel) <= 255 then begin
    Inc(PlayObject.m_btReLevel, nReLevel);
    if nLevel > 0 then
      PlayObject.m_Abil.Level := nLevel;
    if g_Config.boReNewLevelClearExp then
      PlayObject.m_Abil.Exp := 0;
    if nBounsuPoint > 0 then begin
      IntegerChange(PlayObject.m_nNakedCount, nBounsuPoint, INT_ADD);
      PlayObject.SendNakedAbility;
    end;
    PlayObject.HasLevelUp(0);
    PlayObject.RefShowName();
  end;
end;

procedure TNormNpc.ActionOfChangeGender(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGENDER: Integer;
begin
  nGENDER := StrToIntDef(QuestActionInfo.sParam1, -1);
  if not (nGENDER in [0, 1]) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGENDER);
    Exit;
  end;
  PlayObject.m_btGender := nGENDER;
  PlayObject.FeatureChanged;
end;

procedure TNormNpc.ActionOfMobSlave(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sMonName: string;
  nMakeLevel, nExpLevel, nCount: Integer;
  dwRoyaltySec: LongWord;
begin
  sMonName := QuestActionInfo.sParam1;
  nCount := StrToIntDef(QuestActionInfo.sParam2, -1);
  nExpLevel := QuestActionInfo.nParam3;
  nMakeLevel := _MIN(3, nExpLevel);
  dwRoyaltySec := 10 * 24 * 60 * 60;
  if (nCount <= 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBSLAVE);
    Exit;
  end;
  if PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, 100, -1, dwRoyaltySec) = nil then
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBSLAVE);
end;

procedure TNormNpc.ActionOfKillSlave(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  Slave: TBaseObject;
begin
  if QuestActionInfo.sParam1 <> '' then begin
    for i := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
      Slave := TBaseObject(PlayObject.m_SlaveList.Items[i]);
      if CompareText(Slave.m_sCharName, QuestActionInfo.sParam1) = 0 then begin
        Slave.MakeGhost;
        PlayObject.m_SlaveList.Delete(i);
      end;
    end;
  end
  else begin
    for i := 0 to PlayObject.m_SlaveList.Count - 1 do begin
      Slave := TBaseObject(PlayObject.m_SlaveList.Items[i]);
      Slave.MakeGhost;
    end;
    PlayObject.m_SlaveList.Clear;
  end;
end;

procedure TNormNpc.ActionOfKillMonExpRate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate: Integer;
  nTime: Integer;
begin
  nRate := StrToIntDef(QuestActionInfo.sParam1, -1);
  nTime := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (nRate < 0) or (nTime < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_KILLMONEXPRATE);
    Exit;
  end;

  PlayObject.m_nKillMonExpRate := nRate;
  if g_Config.boExpIsCumulative then
    PlayObject.m_dwKillMonExpRateTime := PlayObject.m_dwKillMonExpRateTime + LongWord(nTime)
  else
    PlayObject.m_dwKillMonExpRateTime := LongWord(nTime);
  PlayObject.ChangeStatusMode(STATUS_EXP, True);
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sChangeKillMonExpRateMsg, [PlayObject.m_nKillMonExpRate / 100,
      PlayObject.m_dwKillMonExpRateTime]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfMonClear(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  List58: TList;
  II: integer;
begin
  List58 := TList.Create;
  UserEngine.GetMapMonster(g_MapManager.FindMap(QuestActionInfo.sParam1), List58);
  for ii := 0 to List58.Count - 1 do begin
    TBaseObject(List58.Items[ii]).m_boNoItem := True;
    TBaseObject(List58.Items[ii]).m_WAbil.HP := 0;
  end;
  List58.Free;
end;

procedure TNormNpc.ActionOfMonGen(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  ii, n20X, n24Y: integer;
begin
  for ii := 0 to QuestActionInfo.nParam2 - 1 do begin
    n20X := Random(QuestActionInfo.nParam3 * 2 + 1) + (Fn38 - QuestActionInfo.nParam3);
    n24Y := Random(QuestActionInfo.nParam3 * 2 + 1) + (Fn3C - QuestActionInfo.nParam3);
    UserEngine.RegenMonsterByName(Fs44, n20X, n24Y, QuestActionInfo.sParam1);
  end;
end;

procedure TNormNpc.ActionOfMonGenEx(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  sMapName, sMonName: string;
  nMapX, nMapY, nRange, nCount: Integer;
  nRandX, nRandY: Integer;
begin
  sMapName := QuestActionInfo.sParam1;
  nMapX := StrToIntDef(QuestActionInfo.sParam2, -1);
  nMapY := StrToIntDef(QuestActionInfo.sParam3, -1);
  sMonName := QuestActionInfo.sParam4;
  nRange := QuestActionInfo.nParam5;
  nCount := QuestActionInfo.nParam6;
  if (sMapName = '') or (nMapX <= 0) or (nMapY <= 0) or (sMapName = '') or
    (nRange <= 0) or (nCount <= 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MONGENEX);
    Exit;
  end;
  for i := 0 to nCount - 1 do begin
    nRandX := Random(nRange * 2 + 1) + (nMapX - nRange);
    nRandY := Random(nRange * 2 + 1) + (nMapY - nRange);
    if UserEngine.RegenMonsterByName(sMapName, nRandX, nRandY, sMonName) = nil then begin
      //ScriptActionError(PlayObject,'',QuestActionInfo,sSC_MONGENEX);
      break;
    end;
  end;
end;

procedure TNormNpc.ActionOfMov(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14: integer;
begin
  n14 := GetValNameNo(QuestActionInfo.sParam1);
  if n14 >= 0 then begin
    case n14 of //
      0..99: begin
          PlayObject.m_nVal[n14] := QuestActionInfo.nParam2;
        end;
      2000..2999: begin
          g_Config.GlobalVal[n14 - 2000] := QuestActionInfo.nParam2;
        end;
      200..209: begin
          PlayObject.m_DyVal[n14 - 200] := QuestActionInfo.nParam2;
        end;
      300..399: begin
          PlayObject.m_nMval[n14 - 300] := QuestActionInfo.nParam2;
        end;
      400..499: begin
          g_Config.GlobaDyMval[n14 - 400] := QuestActionInfo.nParam2;
        end;
      5000..5999: begin
          PlayObject.m_nInteger[n14 - 5000] := QuestActionInfo.nParam2;
        end;
      6000..6999: begin
          PlayObject.m_sString[n14 - 6000] := QuestActionInfo.sParam2;
        end;
      7000..7999: begin
          g_Config.GlobalAVal[n14 - 7000] := QuestActionInfo.sParam2;
        end;
      800..899: begin
          g_Config.GlobalUVal[n14 - 800] := QuestActionInfo.sParam2;
        end;
      1000..1019: begin
          PlayObject.m_CustomVariable[n14 - 1000] := StrToIntDef(QuestActionInfo.sParam2, 0);
          if n14 = 1000 then
            PlayObject.LiteraryChange(True);
          if g_boGameLogCustomVariable then begin
            AddGameLog(PlayObject, LOG_CUSTOMVARIABLE, SSTRING_CUSTOMVARIABLE, n14 - 1000, PlayObject.m_CustomVariable[n14 - 1000], m_sCharName,
              'mov', QuestActionInfo.sParam2, '脚本mov', nil);
          end;
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
      end;
    end; // case
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
  end;
end;

procedure TNormNpc.ActionOfMovr(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14, n18: integer;
begin
  n14 := GetValNameNo(QuestActionInfo.sParam1);
  if (QuestActionInfo.nParam3 < QuestActionInfo.nParam2) then
    n18 := Random(QuestActionInfo.nParam2)
  else
    n18 := Random(QuestActionInfo.nParam3 - QuestActionInfo.nParam2) + QuestActionInfo.nParam2;
  if n14 >= 0 then begin
    case n14 of //
      0..99: begin
          PlayObject.m_nVal[n14] := n18;
        end;
      2000..2999: begin
          g_Config.GlobalVal[n14 - 2000] := n18;
        end;
      200..209: begin
          PlayObject.m_DyVal[n14 - 200] := n18;
        end;
      300..399: begin
          PlayObject.m_nMval[n14 - 300] := n18;
        end;
      400..499: begin
          g_Config.GlobaDyMval[n14 - 400] := n18;
        end;
      5000..5999: begin
          PlayObject.m_nInteger[n14 - 5000] := n18;
        end;
      1000..1019: begin
          PlayObject.m_CustomVariable[n14 - 1000] := n18;
          if n14 = 1000 then
            PlayObject.LiteraryChange(True);
          if g_boGameLogCustomVariable then begin
            AddGameLog(PlayObject, LOG_CUSTOMVARIABLE, SSTRING_CUSTOMVARIABLE, n14 - 1000, PlayObject.m_CustomVariable[n14 - 1000], m_sCharName,
              'movr', IntToStr(n18), '脚本movr', nil);
          end;
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sMOVR);
      end;
    end;
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sMOVR);
  end;
end;

procedure TNormNpc.ActionOfMul(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14: integer;
begin
  n14 := GetValNameNo(QuestActionInfo.sParam1);
  if n14 >= 0 then begin
    case n14 of //
      0..99: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nVal[n14] := PlayObject.m_nVal[n14] * QuestActionInfo.nParam2
          else
            PlayObject.m_nVal[n14] := QuestActionInfo.nParam2 * QuestActionInfo.nParam3;
        end;
      2000..2999: begin
          if QuestActionInfo.sParam3 = '' then
            g_Config.GlobalVal[n14 - 2000] := g_Config.GlobalVal[n14 - 2000] * QuestActionInfo.nParam2
          else
            g_Config.GlobalVal[n14 - 2000] := QuestActionInfo.nParam2 * QuestActionInfo.nParam3;
        end;
      200..209: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_DyVal[n14 - 200] := PlayObject.m_DyVal[n14 - 200] * QuestActionInfo.nParam2
          else
            PlayObject.m_DyVal[n14 - 200] := QuestActionInfo.nParam2 * QuestActionInfo.nParam3;
        end;
      300..399: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nMval[n14 - 300] := PlayObject.m_nMval[n14 - 300] * QuestActionInfo.nParam2
          else
            PlayObject.m_nMval[n14 - 300] := QuestActionInfo.nParam2 * QuestActionInfo.nParam3;
        end;
      400..499: begin
          if QuestActionInfo.sParam3 = '' then
            g_Config.GlobaDyMval[n14 - 400] := g_Config.GlobaDyMval[n14 - 400] * QuestActionInfo.nParam2
          else
            g_Config.GlobaDyMval[n14 - 400] := QuestActionInfo.nParam2 * QuestActionInfo.nParam3;
        end;
      5000..5999: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nInteger[n14 - 5000] := PlayObject.m_nInteger[n14 - 5000] * QuestActionInfo.nParam2
          else
            PlayObject.m_nInteger[n14 - 5000] := QuestActionInfo.nParam2 * QuestActionInfo.nParam3;
        end;
      1000..1019: begin
          if QuestActionInfo.sParam3 = '' then begin
            PlayObject.m_CustomVariable[n14 - 1000] := PlayObject.m_CustomVariable[n14 - 1000] * QuestActionInfo.nParam2;
          end
          else begin
            PlayObject.m_CustomVariable[n14 - 1000] := QuestActionInfo.nParam2 * QuestActionInfo.nParam3;
          end;
          if n14 = 1000 then
            PlayObject.LiteraryChange(True);
          if g_boGameLogCustomVariable then begin
            AddGameLog(PlayObject, LOG_CUSTOMVARIABLE, SSTRING_CUSTOMVARIABLE, n14 - 1000, PlayObject.m_CustomVariable[n14 - 1000], m_sCharName,
              'mul', QuestActionInfo.sParam2 + '/' + QuestActionInfo.sParam3, '脚本mul', nil);
          end;
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MUL);
      end;
    end; // case
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MUL);
  end;
end;

procedure TNormNpc.ActionOfOpenMagicBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Monster: TBaseObject;
  sMonName: string;
  nX, nY: Integer;
begin
  sMonName := QuestActionInfo.sParam1;
  if sMonName = '' then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENMAGICBOX);
    Exit;
  end;
  PlayObject.GetFrontPosition(nX, nY);
  Monster := UserEngine.RegenMonsterByName(PlayObject.m_PEnvir.sMapName, nX, nY,
    sMonName);
  if Monster = nil then begin
    Exit;
  end;
  Monster.Die;
end;

procedure TNormNpc.ActionOfOpenUrl(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nWidth: Integer;
  nHeight: Integer;
begin
  nWidth := QuestActionInfo.nParam2;
  nHeight := QuestActionInfo.nParam3;
  if (QuestActionInfo.sParam1 = '') or (nWidth <= 0) or (nHeight <= 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENURL);
    Exit;
  end;
  PlayObject.SendDefMsg(PlayObject, SM_OPENURL, 0, nWidth, nHeight, 0, QuestActionInfo.sParam1);
end;

procedure TNormNpc.ActionOfParam1(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  Fn34 := QuestActionInfo.nParam1;
  Fs44 := QuestActionInfo.sParam1;
end;

procedure TNormNpc.ActionOfParam2(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  Fn38 := QuestActionInfo.nParam1;
  Fs48 := QuestActionInfo.sParam1;
end;

procedure TNormNpc.ActionOfParam3(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  Fn3C := QuestActionInfo.nParam1;
  Fs4C := QuestActionInfo.sParam1;
end;

procedure TNormNpc.ActionOfParam4(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  Fn40 := QuestActionInfo.nParam1;
  Fs50 := QuestActionInfo.sParam1;
end;

procedure TNormNpc.ActionOfPercent(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14: integer;
begin
  n14 := GetValNameNo(QuestActionInfo.sParam1);
  if n14 >= 0 then begin
    case n14 of //
      0..99: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nVal[n14] := Trunc(PlayObject.m_nVal[n14] / QuestActionInfo.nParam2 * 100)
          else
            PlayObject.m_nVal[n14] := Trunc(QuestActionInfo.nParam2 / QuestActionInfo.nParam3 * 100);
        end;
      2000..2999: begin
          if QuestActionInfo.sParam3 = '' then
            g_Config.GlobalVal[n14 - 2000] := Trunc(g_Config.GlobalVal[n14 - 2000] / QuestActionInfo.nParam2 * 100)
          else
            g_Config.GlobalVal[n14 - 2000] := Trunc(QuestActionInfo.nParam2 / QuestActionInfo.nParam3 * 100);

        end;
      200..209: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_DyVal[n14 - 200] := Trunc(PlayObject.m_DyVal[n14 - 200] / QuestActionInfo.nParam2 * 100)
          else
            PlayObject.m_DyVal[n14 - 200] := Trunc(QuestActionInfo.nParam2 / QuestActionInfo.nParam3 * 100);

        end;
      300..399: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nMval[n14 - 300] := Trunc(PlayObject.m_nMval[n14 - 300] / QuestActionInfo.nParam2 * 100)
          else
            PlayObject.m_nMval[n14 - 300] := Trunc(QuestActionInfo.nParam2 / QuestActionInfo.nParam3 * 100);
        end;
      400..499: begin
          if QuestActionInfo.sParam3 = '' then
            g_Config.GlobaDyMval[n14 - 400] := Trunc(g_Config.GlobaDyMval[n14 - 400] / QuestActionInfo.nParam2 * 100)
          else
            g_Config.GlobaDyMval[n14 - 400] := Trunc(QuestActionInfo.nParam2 / QuestActionInfo.nParam3 * 100);
        end;
      5000..5999: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_nInteger[n14 - 5000] := Trunc(PlayObject.m_nInteger[n14 - 5000] / QuestActionInfo.nParam2 * 100)
          else
            PlayObject.m_nInteger[n14 - 5000] := Trunc(QuestActionInfo.nParam2 / QuestActionInfo.nParam3 * 100);
        end;
      1000..1019: begin
          if QuestActionInfo.sParam3 = '' then
            PlayObject.m_CustomVariable[n14 - 1000] := Trunc(PlayObject.m_CustomVariable[n14 - 1000] / QuestActionInfo.nParam2 * 100)
          else
            PlayObject.m_CustomVariable[n14 - 1000] := Trunc(QuestActionInfo.nParam2 / QuestActionInfo.nParam3 * 100);
          if n14 = 1000 then
            PlayObject.LiteraryChange(True);
          if g_boGameLogCustomVariable then begin
            AddGameLog(PlayObject, LOG_CUSTOMVARIABLE, SSTRING_CUSTOMVARIABLE, n14 - 1000, PlayObject.m_CustomVariable[n14 - 1000], m_sCharName,
              'percent', QuestActionInfo.sParam2 + '/' + QuestActionInfo.sParam3, '脚本percent', nil);
          end;
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_PERCENT);
      end;
    end; // case
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_PERCENT);
  end;
end;

procedure TNormNpc.ActionOfPkPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14: integer;
begin
  n14 := QuestActionInfo.nParam1;
  if n14 = 0 then begin
    PlayObject.m_nPkPoint := 0;
  end
  else begin
    if n14 < 0 then begin
      WordChange(PlayObject.m_nPkPoint, -n14, INT_DEL);
    end
    else begin
      WordChange(PlayObject.m_nPkPoint, n14, INT_ADD);
    end;
  end;
  PlayObject.RefNameColor();
  PlayObject.DiamondChanged;
end;

procedure TNormNpc.ActionOfPkZone(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nX, nY: Integer;
  FireBurnEvent: TFireBurnEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  nRange, nType, nTime, nPoint: Integer;
begin
  nRange := StrToIntDef(QuestActionInfo.sParam1, -1);
  nType := StrToIntDef(QuestActionInfo.sParam2, -1);
  nTime := StrToIntDef(QuestActionInfo.sParam3, -1);
  nPoint := StrToIntDef(QuestActionInfo.sParam4, -1);
  if (nRange < 0) or (nType < 0) or (nTime < 0) or (nPoint < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_PKZONE);
    Exit;
  end;
  {
  nMinX:=PlayObject.m_nCurrX - nRange;
  nMaxX:=PlayObject.m_nCurrX + nRange;
  nMinY:=PlayObject.m_nCurrY - nRange;
  nMaxY:=PlayObject.m_nCurrY + nRange;
  }
  nMinX := m_nCurrX - nRange;
  nMaxX := m_nCurrX + nRange;
  nMinY := m_nCurrY - nRange;
  nMaxY := m_nCurrY + nRange;
  for nX := nMinX to nMaxX do begin
    for nY := nMinY to nMaxY do begin
      if ((nX < nMaxX) and (nY = nMinY)) or
        ((nY < nMaxY) and (nX = nMinX)) or
        (nX = nMaxX) or (nY = nMaxY) then begin
        FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, nType, nTime * 1000, nPoint);
        g_EventManager.AddEvent(FireBurnEvent);
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfPlayDice(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_sPlayDiceLabel := QuestActionInfo.sParam2;
  PlayObject.SendMsg(Self,
    RM_PLAYDICE,
    QuestActionInfo.nParam1,
    MakeLong(MakeWord(PlayObject.m_DyVal[0], PlayObject.m_DyVal[1]),
    MakeWord(PlayObject.m_DyVal[2], PlayObject.m_DyVal[3])),
    MakeLong(MakeWord(PlayObject.m_DyVal[4], PlayObject.m_DyVal[5]),
    MakeWord(PlayObject.m_DyVal[6], PlayObject.m_DyVal[7])),
    MakeLong(MakeWord(PlayObject.m_DyVal[8], PlayObject.m_DyVal[9]),
    0),
    QuestActionInfo.sParam2);
  bo11 := True;
end;

procedure TNormNpc.ActionOfPowerRate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate: Integer;
  nTime: Integer;
begin
  nRate := StrToIntDef(QuestActionInfo.sParam1, -1);
  nTime := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (nRate < 0) or (nTime < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_POWERRATE);
    Exit;
  end;

  PlayObject.m_nPowerRate := nRate;
  //PlayObject.m_dwPowerRateTime:=_MIN(High(Word),nTime);
  PlayObject.m_dwPowerRateTime := LongWord(nTime);
  PlayObject.ChangeStatusMode(STATUS_POW, True);
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sChangePowerRateMsg, [PlayObject.m_nPowerRate /
      100, PlayObject.m_dwPowerRateTime]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfChangeMode(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMode: Integer;
  boOpen: Boolean;
begin
  nMode := QuestActionInfo.nParam1;
  boOpen := StrToIntDef(QuestActionInfo.sParam2, -1) = 1;
  if nMode in [1..3] then begin
    case nMode of //
      1: begin
          PlayObject.m_boAdminMode := boOpen;
          if PlayObject.m_boAdminMode then
            PlayObject.SysMsg(sGameMasterMode, c_Green, t_Hint)
          else
            PlayObject.SysMsg(sReleaseGameMasterMode, c_Green, t_Hint);
        end;
      2: begin
          PlayObject.m_boSuperMan := boOpen;
          if PlayObject.m_boSuperMan then
            PlayObject.SysMsg(sSupermanMode, c_Green, t_Hint)
          else
            PlayObject.SysMsg(sReleaseSupermanMode, c_Green, t_Hint);
        end;
      3: begin
          PlayObject.m_boObMode := boOpen;
          if PlayObject.m_boObMode then
            PlayObject.SysMsg(sObserverMode, c_Green, t_Hint)
          else
            PlayObject.SysMsg(g_sReleaseObserverMode, c_Green, t_Hint);
        end;
    end;
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEMODE);
  end;
end;

procedure TNormNpc.ActionOfChangePerMission(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPermission: Integer;
begin
  nPermission := StrToIntDef(QuestActionInfo.sParam1, -1);
  if nPermission in [0..10] then begin
    PlayObject.m_btPermission := nPermission;
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEPERMISSION);
    Exit;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sChangePermissionMsg, [PlayObject.m_btPermission]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfDynamicGive(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  UserItem, UserItem32, AddUserItem: pTUserItem;
  StdItem: pTStdItem;
  sItemName: string;
  nItemCount: Integer;
  nBack: Integer;
begin
  sItemName := QuestactionInfo.sParam1;
  nItemCount := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (sItemName = '') or (nItemCount <= 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DYNAMICGIVE);
    Exit;
  end;
  if nItemCount <= 0 then
    Exit;
  if CompareText(sItemName, sSTRING_BINDGOLDNAME) = 0 then begin
    IntegerChange(PlayObject.m_nBindGold, nItemCount, INT_ADD);
    PlayObject.GoldChanged();
    if g_boGameLogBindGold then
      AddGameLog(PlayObject, LOG_BINDGOLDCHANGED, sSTRING_BINDGOLDNAME, 0, PlayObject.m_nBindGold, m_sCharName,
        '+', IntToStr(nItemCount), '脚本Give', nil);
    Exit;
  end;
  if CompareText(sItemName, sSTRING_GOLDNAME) = 0 then begin
    PlayObject.IncGold(nItemCount);
    PlayObject.GoldChanged();
    //0049D2FE
    if g_boGameLogGold then
      AddGameLog(PlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayObject.m_nGold, m_sCharName,
        '+', IntToStr(nItemCount), '脚本Give', nil);
    Exit;
  end;
  StdItem := UserEngine.GetStdItem(sItemName);
  //  nCount := 0;
  if StdItem <> nil then begin
    if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
      if nItemCount < 1 then
        nItemCount := 1;
      New(UserItem32);
      if UserEngine.CopyToUserItemFromNameEx(sItemName, UserItem32) then begin
        while True do begin
          if nItemCount <= 0 then
            Break;
          New(UserItem);
          UserItem^ := UserItem32^;

          if nItemCount > UserItem.DuraMax then begin
            UserItem.Dura := UserItem.DuraMax;
            Dec(nItemCount, UserItem.DuraMax);
            //            Inc(nCount, UserItem.DuraMax);
          end
          else begin
            UserItem.Dura := nItemCount;
            //            Inc(nCount, nItemCount);
            nItemCount := 0;
          end;
          nBack := PlayObject.AddItemToBag(UserItem, StdItem, False, m_sCharName, '购买', AddUserItem);
          if nBack = 2 then begin
            UserItem.MakeIndex := GetItemNumber;
            //FGiveItem := UserItem;
            FGiveItemList.Add(UserItem);
            //PlayObject.SendAddItem(UserItem);
            if StdItem.NeedIdentify = 1 then
              AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
                'Give', '0', '购买', UserItem);
            {end
            else if nBack = -1 then begin
              UserItem.MakeIndex := GetItemNumber;
              if StdItem.NeedIdentify = 1 then
                AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
                  'Give', '0', '购买');
              PlayObject.DropItemDown(UserItem, 3, False, PlayObject, nil);
              Dispose(UserItem); }
          end
          else { if nBack = 1 then}
            Dispose(UserItem);

          //if nBack = -1 then
            //Break;
        end;
      end;
      Dispose(UserItem32);
    end
    else begin
      if not (nItemCount in [1..PlayObject.m_nMaxItemListCount]) then
        nItemCount := 1;
      for i := 0 to nItemCount - 1 do begin //nItemCount 为0时出死循环
        if PlayObject.IsEnoughBag then begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
            //FGiveItem := UserItem;
            FGiveItemList.Add(UserItem);
            PlayObject.m_ItemList.Add((UserItem));
            //PlayObject.SendAddItem(UserItem);
            //0049D46B
            if StdItem.NeedIdentify = 1 then
              AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
                'Give', '0', '购买', UserItem);
          end
          else
            DisPose(UserItem);
          {end
          else begin
            New(UserItem);
            if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
              //StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              //0049D5A5
              //FGiveItem := UserItem;
              if StdItem.NeedIdentify = 1 then
                AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
                  'Give', '0', '购买');

              PlayObject.DropItemDown(UserItem, 3, False, PlayObject, nil);
            end;
            Dispose(UserItem); }
        end;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfGiveItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  UserItem, UserItem32, AddUserItem: pTUserItem;
  StdItem: pTStdItem;
  sItemName: string;
  nItemCount: Integer;
  nBack: Integer;
  where: Byte;
  UserItem34: TUserItem;
begin
  sItemName := QuestactionInfo.sParam1;
  if CompareText(QuestActionInfo.sParam3, 'TAKEON') = 0 then begin
    where := StrToIntDef(QuestActionInfo.sParam4, 255);
    if PlayObject.IsEnoughBag then begin
      StdItem := UserEngine.GetStdItem(sItemName);
      if StdItem <> nil then begin
        if not (where in [0..MAXUSEITEMS - 1]) then
          where := GetTakeOnPosition(StdItem.StdMode);
        if where in [0..MAXUSEITEMS - 1] then begin
          if UserEngine.CopyToUserItemFromIdx(StdItem.Idx + 1, @UserItem34) then begin
            if PlayObject.m_UseItems[where].wIndex > 0 then begin
              New(UserItem);
              UserItem^ := PlayObject.m_UseItems[where];
              PlayObject.m_ItemList.Add(UserItem);
              PlayObject.SendAddItem(UserItem);
              PlayObject.m_UseItems[where].wIndex := 0;
            end;
            PlayObject.m_UseItems[where] := UserItem34;
            PlayObject.RecalcAbilitys();
            PlayObject.SendAbility;
            PlayObject.SendSubAbility;
            m_DefMsg := MakeDefaultMsg(SM_TAKEON_AUTO, GetFeatureToLong, GetFeatureEx, 0, where);
            PlayObject.SendSocket(@m_DefMsg, PlayObject.MakeClientItem(@UserItem34));
            PlayObject.FeatureChanged();
            if StdItem.NeedIdentify = 1 then
              AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, UserItem34.MakeIndex, UserItem34.Dura, m_sCharName,
                'Give', '0', '购买', @UserItem34);
            exit;
          end;
        end;
      end;
    end;
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GIVE);
  end
  else begin
    nItemCount := QuestActionInfo.nParam2;
    if (sItemName = '') or (nItemCount <= 0) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GIVE);
      Exit;
    end;
    if nItemCount <= 0 then
      Exit;
    if CompareText(sItemName, sSTRING_BINDGOLDNAME) = 0 then begin
      IntegerChange(PlayObject.m_nBindGold, nItemCount, INT_ADD);
      PlayObject.GoldChanged();
      if g_boGameLogBindGold then
        AddGameLog(PlayObject, LOG_BINDGOLDCHANGED, sSTRING_BINDGOLDNAME, 0, PlayObject.m_nBindGold, m_sCharName,
          '+', IntToStr(nItemCount), '脚本Give', nil);
      Exit;
    end;
    if CompareText(sItemName, sSTRING_GOLDNAME) = 0 then begin
      PlayObject.IncGold(nItemCount);
      PlayObject.GoldChanged();
      //0049D2FE
      if g_boGameLogGold then
        AddGameLog(PlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayObject.m_nGold, m_sCharName,
          '+', IntToStr(nItemCount), '脚本Give', nil);
      Exit;
    end;
    StdItem := UserEngine.GetStdItem(sItemName);
    //  nCount := 0;
    if StdItem <> nil then begin
      if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
        if nItemCount < 1 then
          nItemCount := 1;
        New(UserItem32);
        if UserEngine.CopyToUserItemFromNameEx(sItemName, UserItem32) then begin
          while True do begin
            if nItemCount <= 0 then
              Break;
            New(UserItem);
            UserItem^ := UserItem32^;

            if nItemCount > UserItem.DuraMax then begin
              UserItem.Dura := UserItem.DuraMax;
              Dec(nItemCount, UserItem.DuraMax);
              //            Inc(nCount, UserItem.DuraMax);
            end
            else begin
              UserItem.Dura := nItemCount;
              //            Inc(nCount, nItemCount);
              nItemCount := 0;
            end;
            nBack := PlayObject.AddItemToBag(UserItem, StdItem, True, m_sCharName, '购买', AddUserItem);
            if nBack = 2 then begin
              UserItem.MakeIndex := GetItemNumber;
              //FGiveItem := UserItem;
              PlayObject.SendAddItem(UserItem);
              if StdItem.NeedIdentify = 1 then
                AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
                  'Give', '0', '购买', UserItem);
            end
            else if nBack = -1 then begin
              UserItem.MakeIndex := GetItemNumber;
              if StdItem.NeedIdentify = 1 then
                AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
                  'Give', '0', '购买', UserItem);
              PlayObject.DropItemDown(UserItem, 3, False, PlayObject, nil);
              Dispose(UserItem);
            end
            else if nBack = 1 then
              Dispose(UserItem);

            //if nBack = -1 then
              //Break;
          end;
        end;
        Dispose(UserItem32);
      end
      else begin
        if not (nItemCount in [1..PlayObject.m_nMaxItemListCount]) then
          nItemCount := 1;
        for i := 0 to nItemCount - 1 do begin //nItemCount 为0时出死循环
          if PlayObject.IsEnoughBag then begin
            New(UserItem);
            if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
              //FGiveItem := UserItem;
              PlayObject.m_ItemList.Add((UserItem));
              PlayObject.SendAddItem(UserItem);
              //0049D46B
              if StdItem.NeedIdentify = 1 then
                AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
                  'Give', '0', '购买', UserItem);
            end
            else
              DisPose(UserItem);
          end
          else begin
            New(UserItem);
            if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
              //StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              //0049D5A5
              //FGiveItem := UserItem;
              if StdItem.NeedIdentify = 1 then
                AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, m_sCharName,
                  'Give', '0', '购买', UserItem);

              PlayObject.DropItemDown(UserItem, 3, False, PlayObject, nil);
            end;
            Dispose(UserItem);
          end;
        end;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfGmExecute(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sData: string;
  btOldPermission: Byte;
  sParam1, sParam2, sParam3, sParam4, sParam5, sParam6: string;
begin
  sParam1 := QuestActionInfo.sParam1;
  sParam2 := QuestActionInfo.sParam2;
  sParam3 := QuestActionInfo.sParam3;
  sParam4 := QuestActionInfo.sParam4;
  sParam5 := QuestActionInfo.sParam5;
  sParam6 := QuestActionInfo.sParam6;
  if CompareText(sParam2, 'Self') = 0 then
    sParam2 := PlayObject.m_sCharName;

  sData := format('@%s %s %s %s %s %s', [sParam1,
    sParam2,
      sParam3,
      sParam4,
      sParam5,
      sParam6]);
  btOldPermission := PlayObject.m_btPermission;
  try
    PlayObject.m_btPermission := 10;
    PlayObject.ProcessUserLineMsg(sData);
  finally
    PlayObject.m_btPermission := btOldPermission;
  end;
end;
{
procedure TNormNpc.ActionOfGoQuest(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  Script: pTScript;
begin
  for i := 0 to m_ScriptList.Count - 1 do begin
    Script := m_ScriptList.Items[i];
    if Script.nQuest = QuestActionInfo.nParam1 then begin
      PlayObject.m_Script := Script;
      PlayObject.m_NPC := Self;
      GotoLable(PlayObject, sMAIN, False);
      break;
    end;
  end;
end;
          }

procedure TNormNpc.ActionOfGoto(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  Inc(PlayObject.m_nScriptGotoCount);
  if PlayObject.m_nScriptGotoCount > g_Config.nScriptGotoCountLimit {10} then begin
    MainOutMessage('[脚本死循环] NPC:' + m_sCharName +
      ' 位置:' + m_sMapName + '(' + IntToStr(m_nCurrX) + ':' +
      IntToStr(m_nCurrY) + ')' +
      ' 命令:' + sGOTO + ' ' + QuestActionInfo.sParam1);
    FResult := False;
    Exit;
  end;
  if QuestActionInfo.boDynamic1 then begin
    QuestActionInfo.nParam1 := GetScriptIndex(QuestActionInfo.sParam1);
  end;
  GotoLable(PlayObject, QuestActionInfo.nParam1, False, QuestActionInfo.sParam1);
end;

procedure TNormNpc.ActionOfGroupMapMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  ii: integer;
begin
  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
  PlayObject.SpaceMove(QuestActionInfo.sParam1, QuestActionInfo.nParam2, QuestActionInfo.nParam3, 0);
  if PlayObject.m_GroupOwner.m_GroupMembers.Count > 0 then begin
    for ii := 0 to PlayObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
      if (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[ii]).m_boDeath) and
        (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[ii]).m_boGhost) then begin
        TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[ii]).SpaceMove(QuestActionInfo.sParam1,
          QuestActionInfo.nParam2, QuestActionInfo.nParam3, 0);
      end;
    end;
  end;
  bo11 := True;
end;

procedure TNormNpc.ActionOfGroupMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  ii: integer;
begin
  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
  PlayObject.MapRandomMove(QuestActionInfo.sParam1, 0);
  if PlayObject.m_GroupOwner.m_GroupMembers.Count > 0 then begin
    for ii := 0 to PlayObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
      if (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[ii]).m_boDeath) and
        (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[ii]).m_boGhost) then begin
        TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[ii]).MapRandomMove(QuestActionInfo.sParam1, 0);
      end;
    end;
  end;
  bo11 := True;
end;

procedure TNormNpc.ActionOfGuildAuraePoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nAuraePoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  nAuraePoint := StrToIntDef(QuestActionInfo.sParam2, -1);
  if nAuraePoint < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AURAEPOINT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildAuraePointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nActivityPoint := nAuraePoint;
      end;
    '-': begin
        Guild.DecActivityPoint(nAuraePoint);
        {if Guild.m_nActivityPoint >= nAuraePoint then begin
          Guild.m_nActivityPoint := Guild.m_nActivityPoint - nAuraePoint;
        end
        else begin
          Guild.m_nActivityPoint := 0;
        end; }
      end;
    '+': begin
        Guild.IncActivityPoint(nAuraePoint);
        {if (High(Integer) - Guild.m_nActivityPoint) >= nAuraePoint then begin
          Guild.m_nActivityPoint := Guild.m_nActivityPoint + nAuraePoint;
        end
        else begin
          Guild.m_nActivityPoint := High(Integer);
        end;  }
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sScriptGuildAuraePointMsg, [Guild.nActivityPoint]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfGuildBuildPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nBuildPoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  nBuildPoint := StrToIntDef(QuestActionInfo.sParam2, -1);
  if nBuildPoint < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_BUILDPOINT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildBuildPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nBuildPoint := nBuildPoint;
      end;
    '-': begin
        Guild.DecBuildPoint(nBuildPoint);
        {if Guild.nBuildPoint >= nBuildPoint then begin
          Guild.nBuildPoint := Guild.nBuildPoint - nBuildPoint;
        end
        else begin
          Guild.nBuildPoint := 0;
        end;  }
      end;
    '+': begin
        Guild.IncBuildPoint(nBuildPoint);
        {if (High(Integer) - Guild.m_nBuildPoint) >= m_nBuildPoint then begin
          Guild.m_nBuildPoint := Guild.m_nBuildPoint + m_nBuildPoint;
        end
        else begin
          Guild.m_nBuildPoint := High(Integer);
        end; }
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sScriptGuildBuildPointMsg, [Guild.nBuildPoint]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfGuildChiefItemCount(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
{var
  nItemCount: Integer;
  cMethod: Char;
  Guild: TGuild; }
begin
  {nItemCount := StrToIntDef(QuestActionInfo.sParam2, -1);
  if nItemCount < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GUILDCHIEFITEMCOUNT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildFlourishPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nChiefItemCount := nItemCount;
      end;
    '-': begin
        if Guild.nChiefItemCount >= nItemCount then begin
          Guild.nChiefItemCount := Guild.nChiefItemCount - nItemCount;
        end
        else begin
          Guild.nChiefItemCount := 0;
        end;
      end;
    '+': begin
        if (High(Integer) - Guild.nChiefItemCount) >= nItemCount then begin
          Guild.nChiefItemCount := Guild.nChiefItemCount + nItemCount;
        end
        else begin
          Guild.nChiefItemCount := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sScriptChiefItemCountMsg,
      [Guild.nChiefItemCount]), c_Green, t_Hint);
  end;  }
end;

procedure TNormNpc.ActionOfGuildFlourishPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nFlourishPoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  nFlourishPoint := StrToIntDef(QuestActionInfo.sParam2, -1);
  if nFlourishPoint < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_FLOURISHPOINT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildFlourishPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nFlourishingPoint := nFlourishPoint;
      end;
    '-': begin
        Guild.DecFlourishingPoint(nFlourishPoint);
        {if Guild.m_nFlourishingPoint >= nFlourishPoint then begin
          Guild.m_nFlourishingPoint := Guild.m_nFlourishingPoint - nFlourishPoint;
        end
        else begin
          Guild.m_nFlourishingPoint := 0;
        end; }
      end;
    '+': begin
        Guild.IncFlourishingPoint(nFlourishPoint);
        {if (High(Integer) - Guild.m_nFlourishingPoint) >= nFlourishPoint then begin
          Guild.m_nFlourishingPoint := Guild.m_nFlourishingPoint + nFlourishPoint;
        end
        else begin
          Guild.m_nFlourishingPoint := High(Integer);
        end;  }
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sScriptGuildFlourishPointMsg, [Guild.nFlourishingPoint]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfGuildMapMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  s4C: string;
  II, III, n14, n40: integer;
  BaseObject: TBaseObject;
  GuildRank: pTGuildRank;
begin
  if PlayObject.m_MyGuild = nil then
    Exit;
  s4C := QuestActionInfo.sParam1;
  n14 := QuestActionInfo.nParam2;
  n40 := QuestActionInfo.nParam3;
  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
  PlayObject.SpaceMove(s4C, n14, n40, 0);
  for ii := 0 to TGuild(PlayObject.m_MyGuild).m_RankList.Count - 1 do begin
    GuildRank := TGuild(PlayObject.m_MyGuild).m_RankList.Items[ii];
    if GuildRank = nil then
      Continue;
    for III := 0 to GuildRank.MembersList.Count - 1 do begin
      BaseObject := TBaseObject(pTGuildUserInfo(GuildRank.MembersList.Objects[III]).PlayObject);
      if BaseObject = nil then
        Continue;
      if (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) then
        TPlayObject(BaseObject).SpaceMove(s4C, n14, n40, 0);
    end;
  end;
  bo11 := True;
end;

procedure TNormNpc.ActionOfGuildMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  s4C: string;
  II, III: integer;
  BaseObject: TBaseObject;
  GuildRank: pTGuildRank;
begin
  if PlayObject.m_MyGuild = nil then
    Exit;
  s4C := QuestActionInfo.sParam1;
  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
  PlayObject.MapRandomMove(s4C, 0);
  for ii := 0 to TGuild(PlayObject.m_MyGuild).m_RankList.Count - 1 do begin
    GuildRank := TGuild(PlayObject.m_MyGuild).m_RankList.Items[ii];
    if GuildRank = nil then
      Continue;
    for III := 0 to GuildRank.MembersList.Count - 1 do begin
      BaseObject := TBaseObject(pTGuildUserInfo(GuildRank.MembersList.Objects[III]).PlayObject);
      if BaseObject = nil then
        Continue;
      if (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) then
        TPlayObject(BaseObject).MapRandomMove(s4C, 0);
    end;
  end;
  bo11 := True;
end;

procedure TNormNpc.ActionOfGuildstabilityPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  nStabilityPoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  nStabilityPoint := StrToIntDef(QuestActionInfo.sParam2, -1);
  if nStabilityPoint < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_STABILITYPOINT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildStabilityPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nStabilityPoint := nStabilityPoint;
      end;
    '-': begin
        Guild.DecStabilityPoint(nStabilityPoint);
        {if Guild.m_nStabilityPoint >= nStabilityPoint then begin
          Guild.m_nStabilityPoint := Guild.m_nStabilityPoint - nStabilityPoint;
        end
        else begin
          Guild.m_nStabilityPoint := 0;
        end; }
      end;
    '+': begin
        Guild.IncStabilityPoint(nStabilityPoint);
        {if (High(Integer) - Guild.m_nStabilityPoint) >= nStabilityPoint then begin
          Guild.m_nStabilityPoint := Guild.m_nStabilityPoint + nStabilityPoint;
        end
        else begin
          Guild.m_nStabilityPoint := High(Integer);
        end; }
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sScriptGuildStabilityPointMsg, [Guild.nStabilityPoint]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfRefShowName(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  RefShowName;
end;

procedure TNormNpc.ActionOfSetEffigyState(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  OldEffigyState: Integer;
  OldEffigyOffset: Integer;
begin
  if QuestActionInfo.sParam2 = '' then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETEFFIGYSTATE);
    Exit;
  end;
  OldEffigyState := m_nEffigyState;
  OldEffigyOffset := m_nEffigyOffset;
  m_nEffigyState := StrToIntDef(QuestActionInfo.sParam1, -1);
  m_nEffigyOffset := QuestActionInfo.nParam2;
  if (OldEffigyState <> m_nEffigyState) or (OldEffigyOffset <> m_nEffigyOffset) then
    SendRefMsg(RM_DEFMESSAGE, SM_CHANGEEFFIGYSTATE, Integer(Self),
      LoWord(m_nEffigyState),
      MakeLong(HiWord(m_nEffigyState), m_nEffigyOffset), '');
end;

procedure TNormNpc.ActionOfHookItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  btWhere: Integer;
begin
  btWhere := StrToIntDef(QuestActionInfo.sParam1, -1);
  if not (btWhere in [0..22]) then begin
    ScriptActionError(PlayObject, '装备位置设置错误', QuestActionInfo, sSC_HOOKITEM);
    Exit;
  end;
  if btWhere in [Low(THumanUseItems)..High(THumanUseItems)] then begin
    if (PlayObject.m_UseItems[btWhere].MakeIndex <= 0) or (PlayObject.m_UseItems[btWhere].wIndex <= 0) then begin
      ScriptActionError(PlayObject, '装备位置无数据', QuestActionInfo, sSC_HOOKITEM);
      Exit;
    end;
    FHookItemList.Add(@PlayObject.m_UseItems[btWhere]);
  end else
  if btWhere in [16..20] then begin
    if (PlayObject.m_UseItems[u_House].MakeIndex <= 0) or (PlayObject.m_UseItems[u_House].wIndex <= 0) then begin
      ScriptActionError(PlayObject, '装备位置无数据', QuestActionInfo, sSC_HOOKITEM);
      Exit;
    end;
    if PlayObject.m_UseItems[u_House].HorseItems[btWhere - 16].wIndex <= 0 then begin
      ScriptActionError(PlayObject, '装备位置无数据', QuestActionInfo, sSC_HOOKITEM);
      Exit;
    end;
    FHookItemList.Add(Pointer(btWhere));
  end else
  if (btWhere > 20) and ((btWhere - 21) < PlayObject.m_HookItemEx.Count) then
  begin
    FHookItemList.Add(PlayObject.m_HookItemEx[(btWhere - 21)]);
  end
  else
    ScriptActionError(PlayObject, '装备位置设置错误', QuestActionInfo, sSC_HOOKITEM);
end;

procedure TNormNpc.ActionOfHookObject(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14: Integer;
begin
  if m_HookObject = nil then begin
    ScriptActionError(PlayObject, 'Object nil', QuestActionInfo, sSC_HOOKOBJECT);
    Exit;
  end;
  n14 := GetValNameNo(QuestActionInfo.sParam1);
  if n14 >= 0 then begin
    case n14 of //
      2000..2999: begin
          if CompareText(QuestActionInfo.sParam2, 'X') = 0 then begin
            m_HookObject.m_PHookX := @g_Config.GlobalVal[n14 - 100];
            g_Config.GlobalVal[n14 - 2000] := m_HookObject.m_nCurrX;
          end
          else begin
            m_HookObject.m_PHookY := @g_Config.GlobalVal[n14 - 100];
            g_Config.GlobalVal[n14 - 2000] := m_HookObject.m_nCurrY;
          end;
        end;
      400..499: begin
          if CompareText(QuestActionInfo.sParam2, 'X') = 0 then begin
            m_HookObject.m_PHookX := @g_Config.GlobaDyMval[n14 - 400];
            g_Config.GlobaDyMval[n14 - 400] := m_HookObject.m_nCurrX;
          end
          else begin
            m_HookObject.m_PHookY := @g_Config.GlobaDyMval[n14 - 400];
            g_Config.GlobaDyMval[n14 - 400] := m_HookObject.m_nCurrY;
          end;
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HOOKOBJECT);
      end;
    end;
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HOOKOBJECT);
  end;
end;

procedure TNormNpc.ActionOfHumanHP(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nHP: Integer;
  dwHP: Integer; //Jay BigHP
  cMethod: Char;
begin
  if not TryStrToInt(QuestActionInfo.sParam2, nHP) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HUMANHP);
    Exit;
  end;
  dwHP := nHP;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        PlayObject.m_WAbil.HP := dwHP;
      end;
    '-': begin
        if PlayObject.m_WAbil.HP >= dwHP then begin
          Dec(PlayObject.m_WAbil.HP, dwHP);
        end
        else begin
          PlayObject.m_WAbil.HP := 0;
        end;
      end;
    '+': begin
        if PlayObject.m_WAbil.HP + dwHP >= PlayObject.m_WAbil.MaxHP then
          PlayObject.m_WAbil.HP := PlayObject.m_WAbil.MaxHP
        else
          Inc(PlayObject.m_WAbil.HP, dwHP);
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sScriptChangeHumanHPMsg,
      [PlayObject.m_WAbil.MaxHP]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfHumanMP(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMP: Integer;
  dwMP: Integer; //Jay BigHP
  cMethod: Char;
begin
  if TryStrToInt(QuestActionInfo.sParam2, nMP) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HUMANMP);
    Exit;
  end;
  dwMP := nMP;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        PlayObject.m_WAbil.MP := dwMP;
      end;
    '-': begin
        if PlayObject.m_WAbil.MP >= dwMP then begin
          Dec(PlayObject.m_WAbil.MP, dwMP);
        end
        else begin
          PlayObject.m_WAbil.MP := 0;
        end;
      end;
    '+': begin
        if PlayObject.m_WAbil.MP + dwMP >= PlayObject.m_WAbil.MaxMP then
          PlayObject.m_WAbil.MP := PlayObject.m_WAbil.MaxMP
        else
          Inc(PlayObject.m_WAbil.MP, dwMP);
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sScriptChangeHumanMPMsg,
      [PlayObject.m_WAbil.MaxMP]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfInc(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14: Integer;
begin
  n14 := GetValNameNo(QuestActionInfo.sParam1);
  if n14 >= 0 then begin
    case n14 of //
      0..99: begin
          Fn18 := PlayObject.m_nVal[n14];
          if (QuestActionInfo.nParam2 > 0) then begin
            Inc(PlayObject.m_nVal[n14], StrToIntDef(QuestActionInfo.sParam2, 0));
          end;
          //else
           //ScriptActionError(PlayObject, '参数二必需大于等于0', QuestActionInfo, sINC);
        end;
      2000..2999: begin
          Fn18 := g_Config.GlobalVal[n14 - 2000];
          if (QuestActionInfo.nParam2 > 0) then begin
            Inc(g_Config.GlobalVal[n14 - 2000], StrToIntDef(QuestActionInfo.sParam2, 0));
          end;
          //else
           // ScriptActionError(PlayObject, '参数二必需大于等于0', QuestActionInfo, sINC);
        end;
      200..209: begin
          Fn18 := PlayObject.m_DyVal[n14 - 200];
          if (QuestActionInfo.nParam2 > 0) then begin
            Inc(PlayObject.m_DyVal[n14 - 200], StrToIntDef(QuestActionInfo.sParam2, 0));
          end;
          //else
            //ScriptActionError(PlayObject, '参数二必需大于等于0', QuestActionInfo, sINC);
        end;
      300..399: begin
          Fn18 := PlayObject.m_nMval[n14 - 300];
          if (QuestActionInfo.nParam2 > 0) then begin
            Inc(PlayObject.m_nMval[n14 - 300], QuestActionInfo.nParam2);
          end;
          //else
            //ScriptActionError(PlayObject, '参数二必需大于等于0', QuestActionInfo, sINC);
        end;
      400..499: begin
          Fn18 := g_Config.GlobaDyMval[n14 - 400];
          if (QuestActionInfo.nParam2 > 0) then begin
            Inc(g_Config.GlobaDyMval[n14 - 400], QuestActionInfo.nParam2);
          end;
          //else
            //ScriptActionError(PlayObject, '参数二必需大于等于0', QuestActionInfo, sINC);
        end;
      5000..5999: begin
          Fn18 := PlayObject.m_nInteger[n14 - 5000];
          if (QuestActionInfo.nParam2 > 0) then begin
            Inc(PlayObject.m_nInteger[n14 - 5000], QuestActionInfo.nParam2);
          end;
          //else
           // ScriptActionError(PlayObject, '参数二必需大于等于0', QuestActionInfo, sINC);
        end;
      1000..1019: begin
          Fn18 := PlayObject.m_CustomVariable[n14 - 1000];
          if (QuestActionInfo.nParam2 > 0) then begin
            Inc(PlayObject.m_CustomVariable[n14 - 1000], QuestActionInfo.nParam2);
            if n14 = 1000 then
              PlayObject.LiteraryChange(True);
          end;
          if g_boGameLogCustomVariable then begin
            AddGameLog(PlayObject, LOG_CUSTOMVARIABLE, SSTRING_CUSTOMVARIABLE, n14 - 1000, PlayObject.m_CustomVariable[n14 - 1000], m_sCharName,
              'inc', QuestActionInfo.sParam2, '脚本inc', nil);
          end;
        end;
      6000..6999: begin
          PlayObject.m_sString[n14 - 6000] := PlayObject.m_sString[n14 - 6000] + QuestActionInfo.sParam2;
        end;
      7000..7999: begin
          g_Config.GlobalAVal[n14 - 7000] := g_Config.GlobalAVal[n14 - 7000] + QuestActionInfo.sParam2;
        end;
      800..899: begin
          g_Config.GlobalUVal[n14 - 800] := g_Config.GlobalUVal[n14 - 800] + QuestActionInfo.sParam2;
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
      end;
    end; // case
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
  end;
end;

procedure TNormNpc.ActionOfUseBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
{var
  nPosition, nCount: Integer;
  cMethod: Char;  }
begin
  {nPosition := StrToIntDef(QuestActionInfo.sParam1, -1);
  cMethod := QuestActionInfo.sParam2[1];
  nCount := StrToIntDef(QuestActionInfo.sParam3, -1);
  if (nPosition < 0) or (nCount < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_USEBONUSPOINT);
    Exit;
  end;
  case cMethod of
    '+': begin
        case nPosition of
          1: Inc(PlayObject.m_BonusAbil.DC, nCount);
          2: Inc(PlayObject.m_BonusAbil.MC, nCount);
          3: Inc(PlayObject.m_BonusAbil.SC, nCount);
          4: Inc(PlayObject.m_BonusAbil.AC, nCount);
          5: Inc(PlayObject.m_BonusAbil.MAC, nCount);
          6: Inc(PlayObject.m_BonusAbil.HP, nCount);
          7: Inc(PlayObject.m_BonusAbil.MP, nCount);
          8: Inc(PlayObject.m_BonusAbil.Hit, nCount);
          9: Inc(PlayObject.m_BonusAbil.Speed, nCount);
        end;
      end;
    '-': begin
        case nPosition of
          1: Dec(PlayObject.m_BonusAbil.DC, nCount);
          2: Dec(PlayObject.m_BonusAbil.MC, nCount);
          3: Dec(PlayObject.m_BonusAbil.SC, nCount);
          4: Dec(PlayObject.m_BonusAbil.AC, nCount);
          5: Dec(PlayObject.m_BonusAbil.MAC, nCount);
          6: Dec(PlayObject.m_BonusAbil.HP, nCount);
          7: Dec(PlayObject.m_BonusAbil.MP, nCount);
          8: Dec(PlayObject.m_BonusAbil.Hit, nCount);
          9: Dec(PlayObject.m_BonusAbil.Speed, nCount);
        end;
      end;
    '=': begin
        case nPosition of
          1: PlayObject.m_BonusAbil.DC := nCount;
          2: PlayObject.m_BonusAbil.MC := nCount;
          3: PlayObject.m_BonusAbil.SC := nCount;
          4: PlayObject.m_BonusAbil.AC := nCount;
          5: PlayObject.m_BonusAbil.MAC := nCount;
          6: PlayObject.m_BonusAbil.HP := nCount;
          7: PlayObject.m_BonusAbil.MP := nCount;
          8: PlayObject.m_BonusAbil.Hit := nCount;
          9: PlayObject.m_BonusAbil.Speed := nCount;
        end;
      end;
  end;
  PlayObject.RecalcAbilitys(); }
end;

procedure TNormNpc.ActionOfKick(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_boKickFlag := True;
  {PlayObject.m_boReconnection := True;
  PlayObject.m_boSoftClose := True;
  PlayObject.m_boPlayOffLine := False;  }
end;

procedure TNormNpc.ActionOfKill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMode: Integer;
begin
  nMode := StrToIntDef(QuestActionInfo.sParam1, -1);
  if nMode in [0..3] then begin
    case nMode of //
      1: begin
          PlayObject.m_boNoItem := True;
          PlayObject.Die;
        end;
      2: begin
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
      3: begin
          PlayObject.m_boNoItem := True;
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
    else begin
        PlayObject.Die;
      end;
    end;
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_KILL);
  end;
end;

procedure TNormNpc.ActionOfBatchDelay(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  Fn18 := QuestActionInfo.nParam1 * 1000;
end;

procedure TNormNpc.ActionOfBatchMove(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  ii: integer;
begin
  for ii := 0 to FList1C.Count - 1 do begin
    PlayObject.SendDelayMsg(Self, RM_10155, 0, 0, 0, 0, FList1C.Strings[ii], Integer(FList1C.Objects[ii]) + Fn20);
    Inc(Fn20, Integer(FList1C.Objects[ii]));
  end;
end;

procedure TNormNpc.ActionOfBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
{var
  nBonusPoint: Integer;
  //  nPoint: Integer;
  //  nOldPKLevel: Integer;
  cMethod: Char;   }
begin
  {nBonusPoint := StrToIntDef(QuestActionInfo.sParam2, -1);
  if (nBonusPoint < 0) or (nBonusPoint > 10000) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_BONUSPOINT);
    Exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        SafeFillChar(PlayObject.m_BonusAbil, SizeOf(TNakedAbility), #0);
        PlayObject.HasLevelUp(0);
        PlayObject.m_nBonusPoint := nBonusPoint;
        PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
    '-': begin
        if PlayObject.m_nBonusPoint >= nBonusPoint then begin
          Dec(PlayObject.m_nBonusPoint, nBonusPoint);
        end
        else begin
          PlayObject.m_nBonusPoint := 0;
        end;
        PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
    '+': begin
        Inc(PlayObject.m_nBonusPoint, nBonusPoint);
        PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
  end;     }
end;

procedure TNormNpc.ActionOfBreak(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  FResult := False;
end;

procedure TNormNpc.ActionOfBreakTimeRecall(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_boTimeRecall := False;
end;

procedure TNormNpc.ActionOfDec(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14: integer;
begin
  n14 := GetValNameNo(QuestActionInfo.sParam1);
  if n14 >= 0 then begin
    case n14 of //
      0..99: begin
          Fn18 := PlayObject.m_nVal[n14];
          if (Fn18 > QuestActionInfo.nParam2) then begin
            if QuestActionInfo.nParam2 > 0 then
              Dec(PlayObject.m_nVal[n14], QuestActionInfo.nParam2);
          end
          else
            PlayObject.m_nVal[n14] := 0;
        end;
      2000..2999: begin
          Fn18 := g_Config.GlobalVal[n14 - 2000];
          if (Fn18 > QuestActionInfo.nParam2) then begin
            if QuestActionInfo.nParam2 > 0 then
              Dec(g_Config.GlobalVal[n14 - 2000], QuestActionInfo.nParam2);
          end
          else
            g_Config.GlobalVal[n14 - 2000] := 0;
        end;
      200..209: begin
          Fn18 := PlayObject.m_DyVal[n14 - 200];
          if (Fn18 > QuestActionInfo.nParam2) then begin
            if QuestActionInfo.nParam2 > 0 then
              Dec(PlayObject.m_DyVal[n14 - 200], QuestActionInfo.nParam2);
          end
          else
            PlayObject.m_DyVal[n14 - 200] := 0;
        end;
      300..399: begin
          Fn18 := PlayObject.m_nMval[n14 - 300];
          if (Fn18 > QuestActionInfo.nParam2) then begin
            if QuestActionInfo.nParam2 > 0 then
              Dec(PlayObject.m_nMval[n14 - 300], QuestActionInfo.nParam2);
          end
          else
            PlayObject.m_nMval[n14 - 300] := 0;
        end;
      400..499: begin
          Fn18 := g_Config.GlobaDyMval[n14 - 400];
          if (Fn18 > QuestActionInfo.nParam2) then begin
            if QuestActionInfo.nParam2 > 0 then
              Dec(g_Config.GlobaDyMval[n14 - 400], QuestActionInfo.nParam2);
          end
          else
            g_Config.GlobaDyMval[n14 - 400] := 0;
        end;
      5000..5999: begin
          Fn18 := PlayObject.m_nInteger[n14 - 5000];
          if (Fn18 > QuestActionInfo.nParam2) then begin
            if QuestActionInfo.nParam2 > 0 then
              Dec(PlayObject.m_nInteger[n14 - 5000], QuestActionInfo.nParam2);
          end
          else
            PlayObject.m_nInteger[n14 - 5000] := 0;
        end;
      1000..1019: begin
          Fn18 := PlayObject.m_CustomVariable[n14 - 1000];
          if (Fn18 > QuestActionInfo.nParam2) then begin
            if QuestActionInfo.nParam2 > 0 then
              Dec(PlayObject.m_CustomVariable[n14 - 1000], QuestActionInfo.nParam2);
          end
          else
            PlayObject.m_CustomVariable[n14 - 1000] := 0;
          if n14 = 1000 then
            PlayObject.LiteraryChange(True);
          if g_boGameLogCustomVariable then begin
            AddGameLog(PlayObject, LOG_CUSTOMVARIABLE, SSTRING_CUSTOMVARIABLE, n14 - 1000, PlayObject.m_CustomVariable[n14 - 1000], m_sCharName,
              'dec', QuestActionInfo.sParam2, '脚本dec', nil);
          end;
        end;
      6000..6999: begin
          if QuestActionInfo.sParam2 <> '' then
            PlayObject.m_sString[n14 - 6000] := AnsiReplaceText(PlayObject.m_sString[n14 - 6000],
              QuestActionInfo.sParam2, '');
        end;
      7000..7999: begin
          if QuestActionInfo.sParam2 <> '' then
            g_Config.GlobalAVal[n14 - 7000] := AnsiReplaceText(g_Config.GlobalAVal[n14 - 7000],
              QuestActionInfo.sParam2, '');
        end;
      800..899: begin
          if QuestActionInfo.sParam2 <> '' then
            g_Config.GlobalUVal[n14 - 800] := AnsiReplaceText(g_Config.GlobalUVal[n14 - 800],
              QuestActionInfo.sParam2, '');
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
      end;
    end; // case
  end
  else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
  end;
end;

procedure TNormNpc.ActionOfDelAccountList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  DelList(PlayObject.m_sUserID, m_sPath + QuestActionInfo.sParam1)
end;

procedure TNormNpc.ActionOfDelayGoto(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  NPCDelayGoto: pTNPCDelayGoto;
begin
  if QuestActionInfo.nParam2 > -1 then begin
    New(NPCDelayGoto);
    NPCDelayGoto.sName := QuestActionInfo.sParam3;
    NPCDelayGoto.dwTimeGotoTick := GetTickCount + LongWord(QuestActionInfo.nParam1 * 1000);
    if QuestActionInfo.boDynamic2 then
      QuestActionInfo.nParam2 := GetScriptIndex(QuestActionInfo.sParam2);
    NPCDelayGoto.nGotoLable := QuestActionInfo.nParam2;
    NPCDelayGoto.GotoNPC := Self;
    NPCDelayGoto.sParam := QuestActionInfo.sParam2;
    PlayObject.m_DelayGotoList.Add(NPCDelayGoto);
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELAYGOTO);
end;

procedure TNormNpc.ActionOfDelGuildList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  if PlayObject.m_MyGuild <> nil then
    DelList(TGuild(PlayObject.m_MyGuild).m_sGuildName, m_sPath + QuestActionInfo.sParam1);
end;

procedure TNormNpc.ActionOfDelIPList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  DelList(PlayObject.m_sIPaddr, m_sPath + QuestActionInfo.sParam1)
end;

procedure TNormNpc.ActionOfDelMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_sDearName := '';
  PlayObject.RefShowName;
end;
{
procedure TNormNpc.ActionOfDelMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
PlayObject.m_sMasterName := '';
PlayObject.RefShowName;
end;       }

procedure TNormNpc.ActionOfReset(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.SetQuestFlagStatus(QuestActionInfo.sParam1, 0, QuestActionInfo.nParam1, QuestActionInfo.nParam2);
end;

procedure TNormNpc.ActionOfResetMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.SetMissionFlagStatus(QuestActionInfo.sParam1, 0, QuestActionInfo.nParam1, QuestActionInfo.nParam2);
end;

procedure TNormNpc.ActionOfRestBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
{var
  nTotleUsePoint: Integer; }
begin
  {nTotleUsePoint := PlayObject.m_BonusAbil.DC +
    PlayObject.m_BonusAbil.MC +
    PlayObject.m_BonusAbil.SC +
    PlayObject.m_BonusAbil.AC +
    PlayObject.m_BonusAbil.MAC +
    PlayObject.m_BonusAbil.HP +
    PlayObject.m_BonusAbil.MP +
    PlayObject.m_BonusAbil.Hit +
    PlayObject.m_BonusAbil.Speed +
    PlayObject.m_BonusAbil.X2;
  SafeFillChar(PlayObject.m_BonusAbil, SizeOf(TNakedAbility), #0);
  Inc(PlayObject.m_nBonusPoint, nTotleUsePoint);
  PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
  PlayObject.HasLevelUp(0);
  PlayObject.SysMsg('分配点数已复位.', c_Red, t_Hint);  }
end;

procedure TNormNpc.ActionOfRestReNewLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_btReLevel := 0;
  PlayObject.HasLevelUp(0);
end;

procedure TNormNpc.ActionOfSet(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.SetQuestFlagStatus(QuestActionInfo.sParam1, StrToIntDef(QuestActionInfo.sParam2, 0), 0, 1);
end;

procedure TNormNpc.ActionOfSetMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.SetMissionFlagStatus(QuestActionInfo.sParam1, StrToIntDef(QuestActionInfo.sParam2, 0), 0, 1);
end;

procedure TNormNpc.ActionOfSetMapMode(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Envir: TEnvirnoment;
  sMapName: string;
  sMapMode, sParam1, sParam2 {,sParam3,sParam4}: string;
begin
  sMapName := QuestActionInfo.sParam1;
  sMapMode := QuestActionInfo.sParam2;
  sParam1 := QuestActionInfo.sParam3;
  sParam2 := QuestActionInfo.sParam4;
  //  sParam3:=QuestActionInfo.sParam5;
  //  sParam4:=QuestActionInfo.sParam6;

  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (sMapMode = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMAPMODE);
    Exit;
  end;
  if CompareText(sMapMode, 'SAFE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boSAFE := True;
    end
    else begin
      Envir.m_boSAFE := False;
    end;
  end
  else if CompareText(sMapMode, 'DARK') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boDARK := True;
    end
    else begin
      Envir.m_boDARK := False;
    end;
  end
  else if CompareText(sMapMode, 'DARK') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boDARK := True;
    end
    else begin
      Envir.m_boDARK := False;
    end;
  end
  else if CompareText(sMapMode, 'FIGHT') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boFightZone := True;
    end
    else begin
      Envir.m_boFightZone := False;
    end;
  end
  else if CompareText(sMapMode, 'FIGHT3') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boFight3Zone := True;
    end
    else begin
      Envir.m_boFight3Zone := False;
    end;
  end
  else if CompareText(sMapMode, 'DAY') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boDAY := True;
    end
    else begin
      Envir.m_boDAY := False;
    end;
  end
  else if CompareText(sMapMode, 'QUIZ') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boQUIZ := True;
    end
    else begin
      Envir.m_boQUIZ := False;
    end;
  end
  else if CompareText(sMapMode, 'NORECONNECT') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNORECONNECT := True;
      Envir.sNoReconnectMap := sParam1;
    end
    else begin
      Envir.m_boNORECONNECT := False;
    end;
  end
  else if CompareText(sMapMode, 'MUSIC') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boMUSIC := True;
      Envir.m_nMUSICID := StrToIntDef(sParam1, -1);
    end
    else begin
      Envir.m_boMUSIC := False;
    end;
  end
  else if CompareText(sMapMode, 'EXPRATE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boEXPRATE := True;
      Envir.m_nEXPRATE := StrToIntDef(sParam1, -1);
    end
    else begin
      Envir.m_boEXPRATE := False;
    end;
  end
  else if CompareText(sMapMode, 'PKWINLEVEL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKWINLEVEL := True;
      Envir.m_nPKWINLEVEL := StrToIntDef(sParam1, -1);
    end
    else begin
      Envir.m_boPKWINLEVEL := False;
    end;
  end
  else if CompareText(sMapMode, 'PKWINEXP') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKWINEXP := True;
      Envir.m_nPKWINEXP := StrToIntDef(sParam1, -1);
    end
    else begin
      Envir.m_boPKWINEXP := False;
    end;
  end
  else if CompareText(sMapMode, 'PKLOSTLEVEL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKLOSTLEVEL := True;
      Envir.m_nPKLOSTLEVEL := StrToIntDef(sParam1, -1);
    end
    else begin
      Envir.m_boPKLOSTLEVEL := False;
    end;
  end
  else if CompareText(sMapMode, 'PKLOSTEXP') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKLOSTEXP := True;
      Envir.m_nPKLOSTEXP := StrToIntDef(sParam1, -1);
    end
    else begin
      Envir.m_boPKLOSTEXP := False;
    end;
  end
  else if CompareText(sMapMode, 'DECHP') = 0 then begin
    if (sParam1 <> '') and (sParam2 <> '') then begin
      Envir.m_boDECHP := True;
      Envir.m_nDECHPTIME := StrToIntDef(sParam1, -1);
      Envir.m_nDECHPPOINT := StrToIntDef(sParam2, -1);
    end
    else begin
      Envir.m_boDECHP := False;
    end;
  end
  else if CompareText(sMapMode, 'DECGAMEGOLD') = 0 then begin
    if (sParam1 <> '') and (sParam2 <> '') then begin
      Envir.m_boDecGameGold := True;
      Envir.m_nDECGAMEGOLDTIME := StrToIntDef(sParam1, -1);
      Envir.m_nDecGameGold := StrToIntDef(sParam2, -1);
    end
    else begin
      Envir.m_boDecGameGold := False;
    end;
  end
  else if CompareText(sMapMode, 'RUNHUMAN') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boRUNHUMAN := True;
    end
    else begin
      Envir.m_boRUNHUMAN := False;
    end;
  end
  else if CompareText(sMapMode, 'RUNMON') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boRUNMON := True;
    end
    else begin
      Envir.m_boRUNMON := False;
    end;
  end
  else if CompareText(sMapMode, 'NEEDHOLE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNEEDHOLE := True;
    end
    else begin
      Envir.m_boNEEDHOLE := False;
    end;
  end
  else if CompareText(sMapMode, 'NORECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNORECALL := True;
    end
    else begin
      Envir.m_boNORECALL := False;
    end;
  end
  else if CompareText(sMapMode, 'NOGUILDRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNOGUILDRECALL := True;
    end
    else begin
      Envir.m_boNOGUILDRECALL := False;
    end;
  end
  else if CompareText(sMapMode, 'NODEARRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNODEARRECALL := True;
    end
    else begin
      Envir.m_boNODEARRECALL := False;
    end;
  end
  else if CompareText(sMapMode, 'NOMASTERRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNOMASTERRECALL := True;
    end
    else begin
      Envir.m_boNOMASTERRECALL := False;
    end;
  end
  else if CompareText(sMapMode, 'NORANDOMMOVE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNORANDOMMOVE := True;
    end
    else begin
      Envir.m_boNORANDOMMOVE := False;
    end;
  end
  else if CompareText(sMapMode, 'NODRUG') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNODRUG := True;
    end
    else begin
      Envir.m_boNODRUG := False;
    end;
  end
  else if CompareText(sMapMode, 'MINE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boMINE := True;
    end
    else begin
      Envir.m_boMINE := False;
    end;
  end
  else if CompareText(sMapMode, 'NOPOSITIONMOVE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNOPOSITIONMOVE := True;
    end
    else begin
      Envir.m_boNOPOSITIONMOVE := False;
    end;
  end;
end;

procedure TNormNpc.ActionOfSetMemberLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nLevel: Integer;
  cMethod: Char;
begin
  nLevel := StrToIntDef(QuestActionInfo.sParam2, -1);
  if nLevel < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMEMBERLEVEL);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        PlayObject.m_nMemberLevel := nLevel;
      end;
    '-': begin
        Dec(PlayObject.m_nMemberLevel, nLevel);
        if PlayObject.m_nMemberLevel < 0 then
          PlayObject.m_nMemberLevel := 0;
      end;
    '+': begin
        Inc(PlayObject.m_nMemberLevel, nLevel);
        if PlayObject.m_nMemberLevel > 65535 then
          PlayObject.m_nMemberLevel := 65535;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sChangeMemberLevelMsg,
      [PlayObject.m_nMemberLevel]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfSetMemberType(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nType: Integer;
  cMethod: Char;
begin
  nType := StrToIntDef(QuestActionInfo.sParam2, -1);
  if nType < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMEMBERTYPE);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        PlayObject.m_nMemberType := nType;
      end;
    '-': begin
        Dec(PlayObject.m_nMemberType, nType);
        if PlayObject.m_nMemberType < 0 then
          PlayObject.m_nMemberType := 0;
      end;
    '+': begin
        Inc(PlayObject.m_nMemberType, nType);
        if PlayObject.m_nMemberType > 65535 then
          PlayObject.m_nMemberType := 65535;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(format(g_sChangeMemberTypeMsg,
      [PlayObject.m_nMemberType]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ConditionOfCheckMonMapCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  i: Integer;
  sMapName: string;
  nCount: Integer;
  nMapRangeCount: Integer;
  Envir: TEnvirnoment;
  MonList: TList;
  BaseObject: TBaseObject;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  nCount := StrToIntDef(QuestConditionInfo.sParam2, -1);
  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (nCount < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sCHECKMONMAP);
    Exit;
  end;
  MonList := TList.Create;
  UserEngine.GetMapMonster(Envir, MonList);
  for i := MonList.Count - 1 downto 0 do begin
    if MonList.Count <= 0 then
      break;
    BaseObject := TBaseObject(MonList.Items[i]);
    if not BaseObject.IsMonster() then
      MonList.Delete(i);
  end;
  nMapRangeCount := MonList.Count;
  if nMapRangeCount >= nCount then
    Result := True;
  MonList.Free;
end;

procedure TNormNpc.ConditionOfCheckRangeMonCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  i: Integer;
  sMapName: string;
  nX, nY, nRange, nCount: Integer;
  cMethod: Char;
  nMapRangeCount: Integer;
  Envir: TEnvirnoment;
  MonList: TList;
  BaseObject: TBaseObject;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  nX := StrToIntDef(QuestConditionInfo.sParam2, -1);
  nY := StrToIntDef(QuestConditionInfo.sParam3, -1);
  nRange := StrToIntDef(QuestConditionInfo.sParam4, -1);

  nCount := StrToIntDef(QuestConditionInfo.sParam6, -1);
  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (nX < 0) or (nY < 0) or (nRange < 0) or (nCount < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo,
      sSC_CHECKRANGEMONCOUNT);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam5[1];
  MonList := TList.Create;
  Envir.GetRangeBaseObject(nX, nY, nRange, True, MonList);
  for i := MonList.Count - 1 downto 0 do begin
    if MonList.Count <= 0 then
      break;
    BaseObject := TBaseObject(MonList.Items[i]);
    if not BaseObject.IsMonster() then
      MonList.Delete(i);
  end;
  nMapRangeCount := MonList.Count;
  case cMethod of
    '=': if nMapRangeCount = nCount then Result := True;
    '>': if nMapRangeCount > nCount then Result := True;
    '<': if nMapRangeCount < nCount then Result := True;
  else if nMapRangeCount >= nCount then
    Result := True;
  end;
  MonList.Free;
end;

procedure TNormNpc.ConditionOfCheckReNewLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nLevel: Integer;
  cMethod: Char;
begin
  Result := False;
  nLevel := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKLEVELEX);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btReLevel = nLevel then
        Result := True;
    '>': if PlayObject.m_btReLevel > nLevel then
        Result := True;
    '<': if PlayObject.m_btReLevel < nLevel then
        Result := True;
  else if PlayObject.m_btReLevel >= nLevel then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckSlaveLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  i: Integer;
  nLevel: Integer;
  cMethod: Char;
  BaseObject: TBaseObject;
  nSlaveLevel: Integer;
begin
  Result := False;
  nLevel := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKLEVELEX);
    Exit;
  end;
  nSlaveLevel := -1;
  for i := 0 to PlayObject.m_SlaveList.Count - 1 do begin
    BaseObject := TBaseObject(PlayObject.m_SlaveList.Items[i]);
    if BaseObject.m_Abil.Level > nSlaveLevel then
      nSlaveLevel := BaseObject.m_Abil.Level;
  end;
  if nSlaveLevel < 0 then
    Exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nSlaveLevel = nLevel then
        Result := True;
    '>': if nSlaveLevel > nLevel then
        Result := True;
    '<': if nSlaveLevel < nLevel then
        Result := True;
  else if nSlaveLevel >= nLevel then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckUseItem(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nWhere: Integer;
  //  UserItem: pTUserItem;
  //  StdItem: pTStdItem;
begin
  Result := False;
  nWhere := StrToIntDef(QuestConditionInfo.sParam1, -1);

  if (nWhere < 0) or (nWhere > High(THumanUseItems)) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKUSEITEM);
    Exit;
  end;
  if (PlayObject.m_UseItems[nWhere].wIndex > 0) and (PlayObject.m_UseItems[nWhere].MakeIndex > 0) then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckVar(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  i: Integer;
  sType: string;
  //  VarType: TVarType;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sName: string;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s已存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  Result := False;
  boFoundVar := False;
  sType := QuestConditionInfo.sParam1;
  sVarName := QuestConditionInfo.sParam2;
  sMethod := QuestConditionInfo.sParam3;
  nVarValue := StrToIntDef(QuestConditionInfo.sParam4, 0);
  sVarValue := QuestConditionInfo.sParam4;

  if (sType = '') or (sVarName = '') or (sMethod = '') then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKVAR);
    Exit;
  end;
  cMethod := sMethod[1];
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKVAR);
    Exit;
  end
  else begin
    for i := 0 to DynamicVarList.Count - 1 do begin
      DynamicVar := DynamicVarList.Items[i];
      if DynamicVar <> nil then begin
        if CompareText(DynamicVar.sName, sVarName) = 0 then begin
          case DynamicVar.VarType of
            vInteger: begin
                case cMethod of
                  '=': if DynamicVar.nInternet = nVarValue then
                      Result := True;
                  '>': if DynamicVar.nInternet > nVarValue then
                      Result := True;
                  '<': if DynamicVar.nInternet < nVarValue then
                      Result := True;
                else if DynamicVar.nInternet >= nVarValue then
                  Result := True;
                end;
              end;
            vString: ;
          end;
          boFoundVar := True;
          break;
        end;
      end;
    end;
    if not boFoundVar then
      ScriptConditionError(PlayObject, {format(sVarFound,[sVarName,sType]),}
        QuestConditionInfo, sSC_CHECKVAR);
  end;
end;

(*procedure TNormNpc.ConditionOfCheckVar(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  i: Integer;
  sType: string;
  VarType: TVarType;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sVarValue2: string;
  nVarValue2: Integer;
  sName: string;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s已存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  Result := False;
  sType := QuestConditionInfo.sParam1;
  sVarName := QuestConditionInfo.sParam2;
  sMethod := QuestConditionInfo.sParam3;
  sVarValue := QuestConditionInfo.sParam4;
  sVarValue2 := QuestConditionInfo.sParam5;
  if (sType = '') or (sVarName = '') or (sMethod = '') then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKVAR);
    Exit;
  end;
  boFoundVar := False;
  if (sVarValue <> '') and (sVarValue2 <> '') and (not IsStringNumber(sVarValue)) and (not IsStringNumber(sVarValue2)) then begin
    DynamicVarList := GetDynamicVarList(PlayObject, sVarValue, sName);
    if DynamicVarList = nil then begin
      DisPose(DynamicVar);
      ScriptConditionError(PlayObject {,format(sVarTypeError,[sType])}, QuestConditionInfo, sSC_CHECKVAR);
      Exit;
    end else begin
      for i := 0 to DynamicVarList.Count - 1 do begin
        DynamicVar := DynamicVarList.Items[i];
        if DynamicVar <> nil then begin
          if CompareText(DynamicVar.sName, sVarValue2) = 0 then begin
            case DynamicVar.VarType of
              vInteger: begin
                  nVarValue := DynamicVar.nInternet;
                end;
              vString: begin

                end;
            end;
            boFoundVar := True;
            break;
          end;
        end;
      end;
      if not boFoundVar then begin
        ScriptConditionError(PlayObject, {format(sVarFound,[sVarName,sType]),} QuestConditionInfo, sSC_CHECKVAR);
        Exit;
      end;
    end;
  end else nVarValue := StrToIntDef(QuestConditionInfo.sParam4, 0);
  cMethod := sMethod[1];
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    ScriptConditionError(PlayObject {,format(sVarTypeError,[sType])}, QuestConditionInfo, sSC_CHECKVAR);
    Exit;
  end;
  for i := 0 to DynamicVarList.Count - 1 do begin
    DynamicVar := DynamicVarList.Items[i];
    if CompareText(DynamicVar.sName, sVarName) = 0 then begin
      case DynamicVar.VarType of
        vInteger: begin
            case cMethod of
              '=': if DynamicVar.nInternet = nVarValue then Result := True;
              '>': if DynamicVar.nInternet > nVarValue then Result := True;
              '<': if DynamicVar.nInternet < nVarValue then Result := True;
              else if DynamicVar.nInternet >= nVarValue then Result := True;
            end;
          end;
        vString: ;
      end;
      boFoundVar := True;
      break;
    end;
  end;
  if not boFoundVar then
    ScriptConditionError(PlayObject, {format(sVarFound,[sVarName,sType]),} QuestConditionInfo, sSC_CHECKVAR);
end;*)

procedure TNormNpc.ConditionOfHaveMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  if PlayObject.m_MasterList.Count > 0 then
    Result := True;
end;

procedure TNormNpc.ConditionOfHour(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
var
  Hour, Min, Sec, MSec: Word;
begin
  Result := True;
  if (QuestConditionInfo.nParam1 <> 0) and (QuestConditionInfo.nParam2 = 0) then
    QuestConditionInfo.nParam2 := QuestConditionInfo.nParam1;
  DecodeTime(Time, Hour, Min, Sec, MSec);
  if (Hour < QuestConditionInfo.nParam1) or (Hour > QuestConditionInfo.nParam2) then
    Result := False;

end;

procedure TNormNpc.ConditionOfISAdmin(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := (PlayObject.m_btPermission >= 6);
end;

procedure TNormNpc.ConditionOfIsDupMode(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := True;
  if PlayObject.m_PEnvir <> nil then begin
    if PlayObject.m_PEnvir.GetXYObjCount(PlayObject.m_nCurrX, PlayObject.m_nCurrY) <= 1 then
      Result := False;
  end
  else
    Result := False;
end;

procedure TNormNpc.ConditionOfIsGroupMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var
  Result: Boolean);
begin
  Result := PlayObject.m_GroupOwner = PlayObject;
end;

procedure TNormNpc.ConditionOfISNewHuman(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := PlayObject.m_boNewHuman;
end;

procedure TNormNpc.ConditionOfISSYSOP(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := (PlayObject.m_btPermission >= 4);
end;

procedure TNormNpc.ConditionOfCheckHumOrNPCRange(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := False;
  if (m_PEnvir = PlayObject.m_PEnvir) and
    (abs(m_nCurrX - PlayObject.m_nCurrX) <= QuestConditionInfo.nParam1) and
    (abs(m_nCurrY - PlayObject.m_nCurrY) <= QuestConditionInfo.nParam1) then
    Result := True;
end;

procedure TNormNpc.ConditionOfCheckHumWuXin(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nCheck: Integer;
begin
  Result := False;
  nCheck := StrToIntDef(QuestConditionInfo.sParam1, -1);
  if nCheck < 0 then begin
    if QuestConditionInfo.sParam1 = '无' then
      nCheck := 0
    else if QuestConditionInfo.sParam1 = '金' then
      nCheck := 1
    else if QuestConditionInfo.sParam1 = '木' then
      nCheck := 2
    else if QuestConditionInfo.sParam1 = '水' then
      nCheck := 3
    else if QuestConditionInfo.sParam1 = '火' then
      nCheck := 4
    else if QuestConditionInfo.sParam1 = '土' then
      nCheck := 5;
  end;
  if not (nCheck in [0..5]) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHUMWUXIN);
    Exit;
  end;
  Result := (PlayObject.m_btWuXin = nCheck);
end;

procedure TNormNpc.ConditionOfISUnderWar(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo;
  var Result: Boolean);
var
  Castle: TUserCastle;
begin
  Result := False;
  Castle := TUserCastle(m_Castle);
  if Castle = nil then
    Castle := g_CastleManager.GetCastle(0);
  if Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISUNDERWAR);
    Exit;
  end;
  Result := Castle.m_boUnderWar;
end;

procedure TNormNpc.ConditionOfLapge(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
var
  n14, n18: integer;
begin
  Result := False;
  if CheckVarNameNo(PlayObject, QuestConditionInfo, n14, n18) and (n14 > n18) then
    Result := True;
end;

procedure TNormNpc.ConditionOfMin(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
var
  Hour, Min, Sec, MSec: Word;
begin
  Result := True;
  if (QuestConditionInfo.nParam1 <> 0) and (QuestConditionInfo.nParam2 = 0) then
    QuestConditionInfo.nParam2 := QuestConditionInfo.nParam1;
  DecodeTime(Time, Hour, Min, Sec, MSec);
  if (Min < QuestConditionInfo.nParam1) or (Min > QuestConditionInfo.nParam2) then
    Result := False;
end;

procedure TNormNpc.ConditionOfPoseHaveMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  PoseHuman: TBaseObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if (TPlayObject(PoseHuman).m_MasterList.Count > 0) then
      Result := True;
  end;
end;

procedure TNormNpc.ConditionOfRandom(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := Random(QuestConditionInfo.nParam1) = 0;
end;

procedure TNormNpc.ConditionOfSmall(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
var
  n14, n18: integer;
begin
  Result := False;
  if CheckVarNameNo(PlayObject, QuestConditionInfo, n14, n18) and (n14 < n18) then
    Result := True;
end;

procedure TNormNpc.ActionOfUnMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  PoseObject: TBaseObject;
  PoseHuman: TPlayObject;
  I: Integer;
  //  LoadList: TStringList;
  //  sUnMarryFileName: string;
  nIdx: Integer;
  sName, sSayMsg: string;
begin
  if PlayObject.m_MasterList.Count <= 0 then begin
    GotoLable(PlayObject, FGotoLable[nExeMasterFail], False);
    Exit;
  end;
  if (CompareText(QuestActionInfo.sParam1, 'FORCE') = 0) then begin
    nIdx := StrToIntDef(QuestActionInfo.sParam2, 0);
    if (nIdx >= 0) and (nIdx < PlayObject.m_MasterList.Count) then begin
      sName := PlayObject.m_sCharName;
      PoseHuman := UserEngine.GetPlayObject(PlayObject.m_MasterList[nIdx]);
      if PoseHuman = PlayObject then
        Exit;
      if PoseHuman <> nil then begin
        if PlayObject.m_boMaster then
          sSayMsg := AnsiReplaceText(g_sfUnMasterListLoginMsg, '%s', sName)
        else
          sSayMsg := AnsiReplaceText(g_sfUnMasterLoginMsg, '%s', sName);
        PoseHuman.SysMsg(sSayMsg, c_Red, t_Hint);
        PoseHuman.DeleteMasterByName(sName);
        PoseHuman.RefShowName;
      end
      else begin
        g_UnForceMasterList.Lock;
        try
          g_UnForceMasterList.AddObject(PlayObject.m_MasterList[nIdx], TObject(StrNew(PChar(sName))));
          SaveUnForceMasterList();
        finally
          g_UnForceMasterList.UnLock;
        end;
      end;
      PlayObject.m_MasterList.Delete(nIdx);
      if PlayObject.m_MasterList.Count <= 0 then
        PlayObject.m_boMaster := False;
      GotoLable(PlayObject, FGotoLable[nUnMasterEnd], False);
      PlayObject.RefShowName;
      Exit;
    end;
  end
  else if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMASTER') = 0) and (CompareText(QuestActionInfo.sParam2, 'FORCE') = 0) then begin
    sName := PlayObject.m_sCharName;
    for I := PlayObject.m_MasterList.Count - 1 downto 0 do begin
      PoseHuman := UserEngine.GetPlayObject(PlayObject.m_MasterList[I]);
      if PoseHuman = PlayObject then
        Continue;
      if PoseHuman <> nil then begin
        if PlayObject.m_boMaster then
          sSayMsg := AnsiReplaceText(g_sfUnMasterListLoginMsg, '%s', sName)
        else
          sSayMsg := AnsiReplaceText(g_sfUnMasterLoginMsg, '%s', sName);
        PoseHuman.SysMsg(sSayMsg, c_Red, t_Hint);
        PoseHuman.DeleteMasterByName(sName);
        PoseHuman.RefShowName;
      end
      else begin
        g_UnForceMasterList.Lock;
        try
          g_UnForceMasterList.AddObject(PlayObject.m_MasterList[I], TObject(StrNew(PChar(sName))));
          SaveUnForceMasterList();
        finally
          g_UnForceMasterList.UnLock;
        end;
      end;
    end;
    PlayObject.m_MasterList.Clear;
    PlayObject.m_boMaster := False;
    GotoLable(PlayObject, FGotoLable[nUnMasterEnd], False);
    PlayObject.RefShowName;
    Exit;
  end
  else begin
    PoseObject := PlayObject.GetPoseCreate;
    if PoseObject = nil then begin
      GotoLable(PlayObject, FGotoLable[nUnMasterCheckDir], False);
      Exit;
    end;
    if PoseObject.m_btRaceServer <> RC_PLAYOBJECT then begin
      GotoLable(PlayObject, FGotoLable[nUnMasterTypeErr], False);
      Exit;
    end;
    PoseHuman := TPlayObject(PoseObject);
    if QuestActionInfo.sParam1 = '' then begin
      if PoseHuman.GetPoseCreate = PlayObject then begin
        if PlayObject.m_boMaster then begin
          GotoLable(PlayObject, FGotoLable[nUnIsMaster], False);
          Exit;
        end;
        if (PlayObject.m_MasterList[0] = PoseHuman.m_sCharName) then begin
          PlayObject.m_boStartUnMaster := False;
          PoseHuman.m_boStartUnMaster := False;
          GotoLable(PlayObject, FGotoLable[nStartUnMaster], False);
          GotoLable(PoseHuman, FGotoLable[nWateUnMaster], False);
        end
        else
          GotoLable(PlayObject, FGotoLable[nUnMasterError], False);
        Exit;
      end;
    end
    else if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMASTER') = 0) then begin
      if (QuestActionInfo.sParam2 = '') then begin
        if (PoseHuman <> nil) and (PoseHuman.m_MasterList.IndexOf(PlayObject.m_sCharName) > -1) then begin
          PlayObject.m_boStartUnMaster := True;
          if PlayObject.m_boStartUnMaster and PoseHuman.m_boStartUnMaster then begin
            PlayObject.DeleteMasterByName(PoseHuman.m_sCharName);
            PoseHuman.DeleteMasterByName(PlayObject.m_sCharName);
            PlayObject.m_boStartUnMaster := False;
            PoseHuman.m_boStartUnMaster := False;
            PlayObject.RefShowName;
            PoseHuman.RefShowName;
            GotoLable(PlayObject, FGotoLable[nUnMasterEnd], False);
            GotoLable(PoseHuman, FGotoLable[nUnMasterEnd], False);
          end
          else begin
            GotoLable(PlayObject, FGotoLable[nWateUnMaster], False);
            GotoLable(PoseHuman, FGotoLable[nRevUnMaster], False);
          end;
        end
        else
          GotoLable(PlayObject, FGotoLable[nUnMasterCheckDir], False);
        Exit;
      end;
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckCastleGold(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethod: Char;
  nGold: Integer;
begin
  Result := False;
  nGold := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if (nGold < 0) or (m_Castle = nil) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLEGOLD);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if TUserCastle(m_Castle).m_nTotalGold = nGold then
        Result := True;
    '>': if TUserCastle(m_Castle).m_nTotalGold > nGold then
        Result := True;
    '<': if TUserCastle(m_Castle).m_nTotalGold < nGold then
        Result := True;
  else if TUserCastle(m_Castle).m_nTotalGold >= nGold then
    Result := True;
  end;
  {
  Result:=False;
  nGold:=StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nGold < 0 then begin
    ScriptConditionError(PlayObject,QuestConditionInfo,sSC_CHECKCASTLEGOLD);
    exit;
  end;
  cMethod:=QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if UserCastle.m_nTotalGold = nGold then Result:=True;
    '>': if UserCastle.m_nTotalGold > nGold then Result:=True;
    '<': if UserCastle.m_nTotalGold < nGold then Result:=True;
    else if UserCastle.m_nTotalGold >= nGold then Result:=True;
  end;
  }
end;

procedure TNormNpc.ConditionOfCheckContribution(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nContribution: Integer;
  cMethod: Char;
begin
  Result := False;
  nContribution := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nContribution < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCONTRIBUTION);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_wContribution = nContribution then
        Result := True;
    '>': if PlayObject.m_wContribution > nContribution then
        Result := True;
    '<': if PlayObject.m_wContribution < nContribution then
        Result := True;
  else if PlayObject.m_wContribution >= nContribution then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckGameDiamond(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nGameDiamond: Integer;
  cMethod: Char;
begin
  Result := False;
  nGameDiamond := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nGameDiamond < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEDIAMOND);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nGameDiamond = nGameDiamond then
        Result := True;
    '>': if PlayObject.m_nGameDiamond > nGameDiamond then
        Result := True;
    '<': if PlayObject.m_nGameDiamond < nGameDiamond then
        Result := True;
  else if PlayObject.m_nGameDiamond >= nGameDiamond then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckGameGird(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nGameGird: Integer;
  cMethod: Char;
begin
  Result := False;
  nGameGird := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nGameGird < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEGIRD);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nGameGird = nGameGird then
        Result := True;
    '>': if PlayObject.m_nGameGird > nGameGird then
        Result := True;
    '<': if PlayObject.m_nGameGird < nGameGird then
        Result := True;
  else if PlayObject.m_nGameGird >= nGameGird then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckCreditPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nCreditPoint: Integer;
  cMethod: Char;
begin
  Result := False;
  nCreditPoint := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nCreditPoint < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCREDITPOINT);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nCreditPoint = nCreditPoint then
        Result := True;
    '>': if PlayObject.m_nCreditPoint > nCreditPoint then
        Result := True;
    '<': if PlayObject.m_nCreditPoint < nCreditPoint then
        Result := True;
  else if PlayObject.m_nCreditPoint >= nCreditPoint then
    Result := True;
  end;
end;

procedure TNormNpc.ActionOfClearNeedItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i, ii: Integer;
  nNeed: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  nNeed := StrToIntDef(QuestActionInfo.sParam1, -1);
  if (nNeed < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARNEEDITEMS);
    Exit;
  end;
  for i := PlayObject.m_ItemList.Count - 1 downto 0 do begin
    if PlayObject.m_ItemList.Count <= 0 then
      break;
    UserItem := PlayObject.m_ItemList.Items[i];
    if UserItem = nil then
      Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and (StdItem.Need = nNeed) then begin
      PlayObject.SendDelItems(UserItem);
      DisPose(UserItem);
      PlayObject.m_ItemList.Delete(i);
    end;
  end;
  for ii := High(PlayObject.m_StorageItemList) downto Low(PlayObject.m_StorageItemList) do begin
    for i := PlayObject.m_StorageItemList[ii].Count - 1 downto 0 do begin
      if PlayObject.m_StorageItemList[ii].Count <= 0 then
        break;
      UserItem := @pTStorageItem(PlayObject.m_StorageItemList[ii].Items[i]).UserItem;
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and (StdItem.Need = nNeed) then begin
        DisPose(pTStorageItem(PlayObject.m_StorageItemList[ii].Items[i]));
        PlayObject.m_StorageItemList[ii].Delete(i);
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfClearDelayGoto(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  NPCDelayGoto: pTNPCDelayGoto;
  I: Integer;
begin
  for I := 0 to PlayObject.m_DelayGotoList.Count - 1 do begin
    NPCDelayGoto := PlayObject.m_DelayGotoList[I];
    if {(NPCDelayGoto.GotoNPC = Self) and }(CompareText(NPCDelayGoto.sName, QuestActionInfo.sParam1) = 0) then begin
      Dispose(NPCDelayGoto);
      PlayObject.m_DelayGotoList.Delete(I);
      Break;
    end;
  end;
end;

procedure TNormNpc.ActionOfClearMakeItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i, ii: Integer;
  nMakeIndex: Integer;
  sItemName: string;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  boMatchName: Boolean;
begin
  sItemName := QuestActionInfo.sParam1;
  nMakeIndex := QuestActionInfo.nParam2;
  boMatchName := QuestActionInfo.sParam3 = '1';
  if (sItemName = '') or (nMakeIndex <= 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARMAKEITEMS);
    Exit;
  end;
  for i := PlayObject.m_ItemList.Count - 1 downto 0 do begin
    if PlayObject.m_ItemList.Count <= 0 then
      break;
    UserItem := PlayObject.m_ItemList.Items[i];
    if UserItem = nil then
      Continue;
    if UserItem.MakeIndex <> nMakeIndex then
      Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name,
      sItemName) = 0)) then begin
      PlayObject.SendDelItems(UserItem);
      DisPose(UserItem);
      PlayObject.m_ItemList.Delete(i);
    end;
  end;
  for ii := High(PlayObject.m_StorageItemList) downto Low(PlayObject.m_StorageItemList) do begin
    for i := PlayObject.m_StorageItemList[ii].Count - 1 downto 0 do begin
      if PlayObject.m_StorageItemList[ii].Count <= 0 then
        break;
      UserItem := @pTStorageItem(PlayObject.m_ItemList.Items[i]).UserItem;
      if UserItem = nil then
        Continue;
      if UserItem.MakeIndex <> nMakeIndex then
        Continue;
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0)) then begin
        DisPose(pTStorageItem(PlayObject.m_ItemList.Items[i]));
        PlayObject.m_StorageItemList[ii].Delete(i);
      end;
    end;
  end;

  for i := Low(PlayObject.m_UseItems) to High(PlayObject.m_UseItems) do begin
    UserItem := @PlayObject.m_UseItems[i];
    if UserItem.MakeIndex <> nMakeIndex then
      Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name,
      sItemName) = 0)) then begin
      UserItem.wIndex := 0;
    end;
  end;
end;
{
procedure TNormNpc.SendCustemMsg(PlayObject: TPlayObject; sMsg: string);
begin
 if not g_Config.boSendCustemMsg then begin
   PlayObject.SysMsg(g_sSendCustMsgCanNotUseNowMsg, c_Red, t_Hint);
   Exit;
 end;
 if PlayObject.m_boSendMsgFlag then begin
   PlayObject.m_boSendMsgFlag := False;
   UserEngine.SendBroadCastMsg(PlayObject.m_sCharName + ': ' + sMsg, t_Cust);
 end
 else begin

 end;
end;    }

procedure TNormNpc.ConditionOfCheckOfGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  sGuildName: string;
begin
  Result := False;
  if QuestConditionInfo.sParam1 = '' then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKOFGUILD);
    Exit;
  end;
  if (PlayObject.m_MyGuild <> nil) then begin
    sGuildName := QuestConditionInfo.sParam1;
    if CompareText(TGuild(PlayObject.m_MyGuild).m_sGuildName, sGuildName) = 0 then begin
      Result := True;
    end;
  end;
end;

procedure TNormNpc.ConditionOfCheckOnLine(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; var Result:
  Boolean);
begin
  Result := UserEngine.GetPlayObject(QuestConditionInfo.sParam1) <> nil;
end;

procedure TNormNpc.ConditionOfCheckOnlineLongMin(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  cMethod: Char;
  nOnlineMin: Integer;
  nOnlineTime: Integer;
begin
  Result := False;
  nOnlineMin := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nOnlineMin < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ONLINELONGMIN);
    Exit;
  end;
  nOnlineTime := (GetTickCount - PlayObject.m_dwLogonTick) div 60000;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nOnlineTime = nOnlineMin then
        Result := True;
    '>': if nOnlineTime > nOnlineMin then
        Result := True;
    '<': if nOnlineTime < nOnlineMin then
        Result := True;
  else if nOnlineTime >= nOnlineMin then
    Result := True;
  end;
end;
{
procedure TNormNpc.ConditionOfCheckPasswordErrorCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nErrorCount: Integer;
  cMethod: Char;
begin
  Result := False;
  nErrorCount := StrToIntDef(QuestConditionInfo.sParam2, -1);
  if nErrorCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo,
      sSC_PASSWORDERRORCOUNT);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btPwdFailCount = nErrorCount then
        Result := True;
    '>': if PlayObject.m_btPwdFailCount > nErrorCount then
        Result := True;
    '<': if PlayObject.m_btPwdFailCount < nErrorCount then
        Result := True;
  else if PlayObject.m_btPwdFailCount >= nErrorCount then
    Result := True;
  end;
end;     }
 {
procedure TNormNpc.ConditionOfIsLockPassword(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := PlayObject.m_boPasswordLocked;
end;

procedure TNormNpc.ConditionOfIsLockStorage(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
begin
  Result := not PlayObject.m_boCanGetBackItem;
end;

procedure TNormNpc.ConditionOfCheckPayMent(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nPayMent: Integer;
begin
  Result := False;
  nPayMent := StrToIntDef(QuestConditionInfo.sParam1, -1);
  if nPayMent < 1 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKPAYMENT);
    Exit;
  end;
  if PlayObject.m_nPayMent = nPayMent then
    Result := True;
end;       }

procedure TNormNpc.ConditionOfCheckSlaveName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  i, nRate: Integer;
  sSlaveName: string;
  BaseObject: TBaseObject;
begin
  Result := False;
  if QuestConditionInfo.sParam1 = '' then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSLAVENAME);
    Exit;
  end;
  sSlaveName := QuestConditionInfo.sParam1;
  nRate := StrToIntDef(QuestConditionInfo.sParam2, 0);
  for i := 0 to PlayObject.m_SlaveList.Count - 1 do begin
    BaseObject := TBaseObject(PlayObject.m_SlaveList.Items[i]);
    if CompareText(sSlaveName, BaseObject.m_sCharName) = 0 then begin
      if (nRate = 0) or ((abs(BaseObject.m_nCurrX - m_nCurrX) <= nRate) and
        (abs(BaseObject.m_nCurrY - m_nCurrY) <= nRate) and (BaseObject.m_PEnvir = m_PEnvir)) then begin
        Result := True;
        break;
      end;
    end;
  end;
end;

procedure TNormNpc.ActionOfUpgradeItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate, nWhere, nValType, nPoint, nAddPoint: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  nWhere := StrToIntDef(QuestActionInfo.sParam1, -1);
  nRate := StrToIntDef(QuestActionInfo.sParam2, -1);
  nPoint := StrToIntDef(QuestActionInfo.sParam3, -1);

  if (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nRate < 0) or (nPoint <
    0) or (nPoint > 65535) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPGRADEITEMS);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    PlayObject.SysMsg('你身上没有戴指定物品.', c_Red, t_Hint);
    Exit;
  end;
  nRate := Random(nRate);
  nPoint := Random(nPoint);
  nValType := Random(tb_Count);
  if nRate <> 0 then begin
    PlayObject.SysMsg('装备升级失败.', c_Red, t_Hint);
    Exit;
  end;
  nAddPoint := nPoint;
  if UserItem.Value.btValue[nValType] + nAddPoint > High(Word) then begin
    nAddPoint := High(Byte) - UserItem.Value.btValue[nValType];
  end;
  UserItem.Value.btValue[nValType] := UserItem.Value.btValue[nValType] + nAddPoint;
  PlayObject.SendUpdateItem(UserItem);
  PlayObject.SysMsg('装备升级成功', c_Green, t_Hint);
  {PlayObject.SysMsg(StdItem.Name + ': ' +
    IntToStr(UserItem.Dura) + '/' +
    IntToStr(UserItem.DuraMax) + '/' +
    IntToStr(UserItem.Value.btValue[0]) + '/' +
    IntToStr(UserItem.Value.btValue[1]) + '/' +
    IntToStr(UserItem.Value.btValue[2]) + '/' +

    IntToStr(UserItem.Value.btValue[3]) + '/' +
    IntToStr(UserItem.Value.btValue[4]) + '/' +
    IntToStr(UserItem.Value.btValue[5]) + '/' +
    IntToStr(UserItem.Value.btValue[6]) + '/' +
    IntToStr(UserItem.Value.btValue[7]) + '/' +
    IntToStr(UserItem.Value.btValue[8]) + '/' +
    IntToStr(UserItem.Value.btValue[9]) + '/' +
    IntToStr(UserItem.Value.btValue[10]) + '/' +
    IntToStr(UserItem.Value.btValue[11]) + '/' +
    IntToStr(UserItem.Value.btValue[12]) + '/' +
    IntToStr(UserItem.Value.btValue[13])
    , c_Blue, t_Hint);    }
end;

procedure TNormNpc.ActionOfUpgradeItemsEx(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
{var
  nRate, nWhere, nValType, nPoint, nAddPoint: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  nUpgradeItemStatus: Integer;
  nRatePoint: Integer;  }
begin
  {nWhere := StrToIntDef(QuestActionInfo.sParam1, -1);
  nValType := StrToIntDef(QuestActionInfo.sParam2, -1);
  nRate := StrToIntDef(QuestActionInfo.sParam3, -1);
  nPoint := StrToIntDef(QuestActionInfo.sParam4, -1);

  nUpgradeItemStatus := StrToIntDef(QuestActionInfo.sParam5, -1);
  if (nValType < 0) or (nValType > 14) or (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nRate < 0) or (nPoint < 0) or (nPoint > 255) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPGRADEITEMSEX);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    PlayObject.SysMsg('你身上没有戴指定物品.', c_Red, t_Hint);
    Exit;
  end;
  nRatePoint := Random(nRate * 10);
  nPoint := _MAX(1, Random(nPoint));

  if not (nRatePoint in [0..10]) then begin
    case nUpgradeItemStatus of //
      0: begin
          PlayObject.SysMsg('装备升级未成功.', c_Red, t_Hint);
        end;
      1: begin
          PlayObject.SendDelItems(UserItem);
          UserItem.wIndex := 0;
          PlayObject.SysMsg('装备破碎.', c_Red, t_Hint);
        end;
      2: begin
          PlayObject.SysMsg('装备升级失败，装备属性恢复默认.', c_Red, t_Hint);
          UserItem.nAddValue[nValType] := 0;
        end;
    end;
    Exit;
  end;
  if nValType = 14 then begin
    nAddPoint := (nPoint * 1000);
    if UserItem.DuraMax + nAddPoint > High(Word) then begin
      nAddPoint := High(Word) - UserItem.DuraMax;
    end;
    UserItem.DuraMax := UserItem.DuraMax + nAddPoint;
  end else begin
    nAddPoint := nPoint;
    if UserItem.Value.btValue[nValType] + nAddPoint > High(Byte) then begin
      nAddPoint := High(Byte) - UserItem.Value.btValue[nValType];
    end;
    UserItem.Value.btValue[nValType] := UserItem.Value.btValue[nValType] + nAddPoint;
  end;
  PlayObject.SendUpdateItem(UserItem);
  PlayObject.SysMsg('装备升级成功', c_Green, t_Hint);
  PlayObject.SysMsg(StdItem.Name + ': ' +
    IntToStr(UserItem.Dura) + '/' +
    IntToStr(UserItem.DuraMax) + '-' +
    IntToStr(UserItem.Value.btValue[0]) + '/' +
    IntToStr(UserItem.Value.btValue[1]) + '/' +
    IntToStr(UserItem.Value.btValue[2]) + '/' +
    IntToStr(UserItem.Value.btValue[3]) + '/' +
    IntToStr(UserItem.Value.btValue[4]) + '/' +
    IntToStr(UserItem.Value.btValue[5]) + '/' +
    IntToStr(UserItem.Value.btValue[6]) + '/' +
    IntToStr(UserItem.Value.btValue[7]) + '/' +
    IntToStr(UserItem.Value.btValue[8]) + '/' +
    IntToStr(UserItem.Value.btValue[9]) + '/' +
    IntToStr(UserItem.Value.btValue[10]) + '/' +
    IntToStr(UserItem.Value.btValue[11]) + '/' +
    IntToStr(UserItem.Value.btValue[12]) + '/' +
    IntToStr(UserItem.Value.btValue[13])
    , c_Blue, t_Hint);    }
end;
//声明变量
//VAR 数据类型(Integer String) 类型(HUMAN GUILD GLOBAL) 变量值

procedure TNormNpc.ActionOfVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  sType: string;
  VarType: TVarType;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s已存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  sType := QuestActionInfo.sParam2;
  sVarName := QuestActionInfo.sParam3;
  sVarValue := QuestActionInfo.sParam4;
  nVarValue := StrToIntDef(QuestActionInfo.sParam4, 0);
  VarType := vNone;
  if CompareText(QuestActionInfo.sParam1, 'Integer') = 0 then
    VarType := vInteger;
  if CompareText(QuestActionInfo.sParam1, 'String') = 0 then
    VarType := vString;

  if (sType = '') or (sVarName = '') or (VarType = vNone) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_VAR);
    Exit;
  end;
  New(DynamicVar);
  DynamicVar.sName := sVarName;
  DynamicVar.VarType := VarType;
  DynamicVar.nInternet := nVarValue;
  DynamicVar.sString := sVarValue;
  boFoundVar := False;
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    DisPose(DynamicVar);
    ScriptActionError(PlayObject, format(sVarTypeError, [sType]), QuestActionInfo, sSC_VAR);
    Exit;
  end;
  for i := 0 to DynamicVarList.Count - 1 do begin
    if CompareText(pTDynamicVar(DynamicVarList.Items[i]).sName, sVarName) = 0 then begin
      boFoundVar := True;
      break;
    end;
  end;
  if not boFoundVar then begin
    DynamicVarList.Add(DynamicVar);
  end
  else begin
    DisPose(DynamicVar); //2006-12-10 叶随风飘增加防止内存泄露
    ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_VAR);
  end;
end;
//读取变量值
//LOADVAR 变量类型 变量名 文件名

procedure TNormNpc.ActionOfLoadVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  sType: string;
  sVarName: string;
  sFileName: string;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
  IniFile: TIniFile;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  sType := QuestActionInfo.sParam1;
  sVarName := QuestActionInfo.sParam2;
  sFileName := g_Config.sGameDataDir + m_sPath + QuestActionInfo.sParam3;
  if (sType = '') or (sVarName = '') or not FileExists(sFileName) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_LOADVAR);
    Exit;
  end;
  boFoundVar := False;
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    ScriptActionError(PlayObject, format(sVarTypeError, [sType]), QuestActionInfo, sSC_VAR);
    Exit;
  end
  else begin
    IniFile := TIniFile.Create(sFileName);
    for i := 0 to DynamicVarList.Count - 1 do begin
      DynamicVar := DynamicVarList.Items[i];
      if DynamicVar <> nil then begin
        if CompareText(DynamicVar.sName, sVarName) = 0 then begin
          case DynamicVar.VarType of
            vInteger: DynamicVar.nInternet := IniFile.ReadInteger(sName, DynamicVar.sName, 0);
            vString: DynamicVar.sString := IniFile.ReadString(sName, DynamicVar.sName, '');
          end;
          boFoundVar := True;
          break;
        end;
      end;
    end;
    if not boFoundVar then
      ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_LOADVAR);
    IniFile.Free;
  end;
end;

//保存变量值
//SAVEVAR 变量类型 变量名 文件名

procedure TNormNpc.ActionOfSaveVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  sType: string;
  sVarName: string;
  sFileName: string;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
  IniFile: TIniFile;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError =
    '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  sType := QuestActionInfo.sParam1;
  sVarName := QuestActionInfo.sParam2;
  sFileName := g_Config.sGameDataDir + m_sPath + QuestActionInfo.sParam3;
  if (sType = '') or (sVarName = ''){ or not FileExists(sFileName)} then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SAVEVAR);
    Exit;
  end;
  boFoundVar := False;
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    ScriptActionError(PlayObject, format(sVarTypeError, [sType]), QuestActionInfo, sSC_VAR);
    Exit;
  end
  else begin
    IniFile := TIniFile.Create(sFileName);
    for i := 0 to DynamicVarList.Count - 1 do begin
      DynamicVar := DynamicVarList.Items[i];
      if DynamicVar <> nil then begin
        if CompareText(DynamicVar.sName, sVarName) = 0 then begin
          case DynamicVar.VarType of
            vInteger: IniFile.WriteInteger(sName, DynamicVar.sName, DynamicVar.nInternet);
            vString: IniFile.WriteString(sName, DynamicVar.sName, DynamicVar.sString);
          end;
          boFoundVar := True;
          break;
        end;
      end;
    end;
    if not boFoundVar then
      ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_SAVEVAR);
    IniFile.Free;
  end;
end;
//对变量进行运算(+、-、*、/)

procedure TNormNpc.ActionOfCalcVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  i: Integer;
  sType: string;
  sVarName: string;
  sName: string;
  sVarValue: string;
  //sVarValue2: string;
  nVarValue: Integer;
  //  nVarValue2: Integer;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
  //  sString: string;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  sType := QuestActionInfo.sParam1;
  sVarName := QuestActionInfo.sParam2;
  sMethod := QuestActionInfo.sParam3;
  sVarValue := QuestActionInfo.sParam4;
  nVarValue := StrToIntDef(QuestActionInfo.sParam4, 0);
  //sVarValue2 := QuestActionInfo.sParam5;
  //nVarValue := 0;
  if (sType = '') or (sVarName = '') or (sMethod = '') or (sVarValue = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CALCVAR);
    Exit;
  end;
  {boFoundVar := False;
  if (sVarValue <> '') and (sVarValue2 <> '') and (not IsStringNumber(sVarValue)) and (not IsStringNumber(sVarValue2)) then begin
    DynamicVarList := GetDynamicVarList(PlayObject, sVarValue, sName);
    if DynamicVarList = nil then begin
      ScriptActionError(PlayObject, format(sVarTypeError, [sVarValue]), QuestActionInfo, sSC_CALCVAR);
      Exit;
    end;
    for i := 0 to DynamicVarList.Count - 1 do begin
      DynamicVar := DynamicVarList.Items[i];
      if CompareText(DynamicVar.sName, sVarValue2) = 0 then begin
        case DynamicVar.VarType of
          vInteger: begin
              nVarValue := DynamicVar.nInternet;
            end;
          vString: begin

            end;
        end;
        boFoundVar := True;
        break;
      end;
    end;
    if not boFoundVar then begin
      ScriptActionError(PlayObject, format(sVarFound, [sVarValue2, sVarValue]), QuestActionInfo, sSC_CALCVAR);
      Exit;
    end;
  end
  else
            }

  boFoundVar := False;
  cMethod := sMethod[1];
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    ScriptActionError(PlayObject, format(sVarTypeError, [sType]), QuestActionInfo, sSC_CALCVAR);
    Exit;
  end
  else begin
    for i := 0 to DynamicVarList.Count - 1 do begin
      DynamicVar := DynamicVarList.Items[i];
      if DynamicVar <> nil then begin
        if CompareText(DynamicVar.sName, sVarName) = 0 then begin
          case DynamicVar.VarType of
            vInteger: begin
                case cMethod of
                  '=': DynamicVar.nInternet := nVarValue;
                  '+': DynamicVar.nInternet := DynamicVar.nInternet + nVarValue;
                  '-': DynamicVar.nInternet := DynamicVar.nInternet - nVarValue;
                  '*': DynamicVar.nInternet := DynamicVar.nInternet * nVarValue;
                  '/': DynamicVar.nInternet := DynamicVar.nInternet div nVarValue;
                end;
              end;
            vString: begin
                case cMethod of
                  '=': DynamicVar.sString := sVarValue;
                  '+': DynamicVar.sString := DynamicVar.sString + sVarValue;
                  '-': DynamicVar.sString := AnsiReplaceText(DynamicVar.sString, sVarValue, '');
                end;
              end;
          end;
          boFoundVar := True;
          break;
        end;
      end;
    end;
    if not boFoundVar then
      ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_CALCVAR);
  end;
end;

procedure TNormNpc.Initialize;
begin
  inherited;
  m_Castle := g_CastleManager.InCastleWarArea(Self);
end;

procedure TNormNpc.ConditionOfCheckNameDateList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  i: Integer;
  LoadList: TStringList;
  sListFileName, sLineText, sHumName, sDate: string;
  boDeleteExprie, boNoCompareHumanName: Boolean;
  dOldDate: TDateTime;
  cMethod: Char;
  nValNo, nValNoDay, nDayCount, nDay: Integer;
begin
  Result := False;
  nDayCount := StrToIntDef(QuestConditionInfo.sParam3, -1);
  nValNo := GetValNameNo(QuestConditionInfo.sParam4);
  nValNoDay := GetValNameNo(QuestConditionInfo.sParam5);
  boDeleteExprie := CompareText(QuestConditionInfo.sParam6, '清理') = 0;
  boNoCompareHumanName := CompareText(QuestConditionInfo.sParam6, '1') = 0;
  cMethod := QuestConditionInfo.sParam2[1];
  if nDayCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMEDATELIST);
    Exit;
  end;
  sListFileName := g_Config.sGameDataDir + m_sPath + QuestConditionInfo.sParam1;
  if FileExists(sListFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
    for i := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[i]);
      sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
      sDate := sLineText;
      //sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
      if (CompareText(sHumName, PlayObject.m_sCharName) = 0) or
        boNoCompareHumanName then begin
        nDay := High(Integer);
        if TryStrToDateTime(sDate, dOldDate) then
        begin
          if CompareText(QuestConditionInfo.sParam7, '年') = 0 then
            nDay := _MAX(0, YearsBetween(Now(), dOldDate) * CompareDateTime(Now(), dOldDate))
          else if CompareText(QuestConditionInfo.sParam7, '周') = 0 then
            nDay := _MAX(0, WeeksBetween(Now(), dOldDate) * CompareDateTime(Now(), dOldDate))
          else if CompareText(QuestConditionInfo.sParam7, '月') = 0 then
            nDay := _MAX(0, MonthsBetween(Now(), dOldDate) * CompareDateTime(Now(), dOldDate))
          else if CompareText(QuestConditionInfo.sParam7, '时') = 0 then
            nDay := _MAX(0, HoursBetween(Now(), dOldDate) * CompareDateTime(Now(), dOldDate))
          else if CompareText(QuestConditionInfo.sParam7, '分') = 0 then
            nDay := _MAX(0, MinutesBetween(Now(), dOldDate) * CompareDateTime(Now(), dOldDate))
          else
            nDay := GetDayCount(Now, dOldDate);
        end;
        case cMethod of
          '=': if nDay = nDayCount then
              Result := True;
          '>': if nDay > nDayCount then
              Result := True;
          '<': if nDay < nDayCount then
              Result := True;
        else if nDay >= nDayCount then
          Result := True;
        end;
        if nValNo >= 0 then begin
          case nValNo of
            0..99: begin
                PlayObject.m_nVal[nValNo] := nDay;
              end;
            2000..2999: begin
                g_Config.GlobalVal[nValNo - 2000] := nDay;
              end;
            200..209: begin
                PlayObject.m_DyVal[nValNo - 200] := nDay;
              end;
            300..399: begin
                PlayObject.m_nMval[nValNo - 300] := nDay;
              end;
            400..499: begin
                g_Config.GlobaDyMval[nValNo - 400] := nDay;
              end;
            5000..5999: begin
                PlayObject.m_nInteger[nValNo - 5000] := nDay;
              end;
            {1000..1019: begin
                PlayObject.m_CustomVariable[nValNo - 1000] := nDay;
                if nValNo = 1000 then PlayObject.LiteraryChange(True);
                if g_boGameLogCustomVariable then begin
                  AddGameLog(PlayObject, LOG_CUSTOMVARIABLE, SSTRING_CUSTOMVARIABLE, n14 - 1000, PlayObject.m_CustomVariable[n14 - 1000], m_sCharName,
                    'dec', QuestActionInfo.sParam2, '脚本dec', nil);
                end;
              end; }
          end;
        end;

        if nValNoDay >= 0 then begin
          case nValNoDay of
            0..99: begin
                PlayObject.m_nVal[nValNoDay] := nDayCount - nDay;
              end;
            2000..2999: begin
                g_Config.GlobalVal[nValNoDay - 2000] := nDayCount - nDay;
              end;
            200..209: begin
                PlayObject.m_DyVal[nValNoDay - 200] := nDayCount - nDay;
              end;
            300..399: begin
                PlayObject.m_nMval[nValNoDay - 300] := nDayCount - nDay;
              end;
            400..499: begin
                g_Config.GlobaDyMval[nValNo - 400] := nDayCount - nDay;
              end;
            5000..5999: begin
                PlayObject.m_nInteger[nValNo - 5000] := nDayCount - nDay;
              end;
            {1000..1019: begin
                PlayObject.m_CustomVariable[nValNo - 1000] := nDayCount - nDay;
                if nValNo = 1000 then PlayObject.LiteraryChange(True);
              end;   }
          end;
        end;
        if not Result then begin
          if boDeleteExprie then begin
            LoadList.Delete(i);
            try
              LoadList.SaveToFile(sListFileName);
            except
              MainOutMessage('Save fail.... => ' + sListFileName);
            end;
          end;
        end;
        break;
      end;
    end;
    LoadList.Free;
  end
  else begin
    MainOutMessage('file not found => ' + sListFileName);
  end;
end;
//CHECKMAPHUMANCOUNT MAP = COUNT

procedure TNormNpc.ConditionOfCheckMapHumanCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nCount, nHumanCount: Integer;
  cMethod: Char;
  sMapName: string;
begin
  Result := False;
  nCount := StrToIntDef(QuestConditionInfo.sParam3, -1);
  if nCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo,
      sSC_CHECKMAPHUMANCOUNT);
    Exit;
  end;
  sMapName := QuestConditionInfo.sParam1;
  nHumanCount := UserEngine.GetMapHuman(sMapName);
  cMethod := QuestConditionInfo.sParam2[1];
  case cMethod of
    '=': if nHumanCount = nCount then
        Result := True;
    '>': if nHumanCount > nCount then
        Result := True;
    '<': if nHumanCount < nCount then
        Result := True;
  else if nHumanCount >= nCount then
    Result := True;
  end;
end;

procedure TNormNpc.ConditionOfCheckMapMonCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; var Result: Boolean);
var
  nCount, nMonCount: Integer;
  cMethod: Char;
  Envir: TEnvirnoment;
begin
  Result := False;
  nCount := StrToIntDef(QuestConditionInfo.sParam3, -1);
  Envir := g_MapManager.FindMap(QuestConditionInfo.sParam1);

  if (nCount < 0) or (Envir = nil) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMAPMONCOUNT);
    Exit;
  end;
  nMonCount := UserEngine.GetMapMonster(Envir, nil);
  cMethod := QuestConditionInfo.sParam2[1];
  case cMethod of
    '=': if nMonCount = nCount then
        Result := True;
    '>': if nMonCount > nCount then
        Result := True;
    '<': if nMonCount < nCount then
        Result := True;
  else if nMonCount >= nCount then
    Result := True;
  end;
end;

function TNormNpc.GetDynamicVarList(PlayObject: TPlayObject;
  sType: string; var sName: string): TList;
begin
  Result := nil;
  if CompareLStr(sType, 'HUMAN', Length('HUMAN')) then begin
    Result := PlayObject.m_DynamicVarList;
    sName := PlayObject.m_sCharName;
  end
  else if CompareLStr(sType, 'GUILD', Length('GUILD')) then begin
    if PlayObject.m_MyGuild = nil then
      Exit;
    Result := TGuild(PlayObject.m_MyGuild).m_DynamicVarList;
    sName := TGuild(PlayObject.m_MyGuild).m_sGuildName;
  end
  else if CompareLStr(sType, 'GLOBAL', Length('GLOBAL')) then begin
    Result := g_DynamicVarList;
    sName := 'GLOBAL';
  end;
end;

{ TGuildOfficial }

procedure TGuildOfficial.Click(PlayObject: TPlayObject);
begin
  //  GotoLable(PlayObject,'@main');
  inherited;
end;
{
procedure TGuildOfficial.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string);

begin
  inherited;

end;    }

procedure TGuildOfficial.Run;
begin
  {if Random(40) = 0 then begin
    TurnTo(Random(8));
  end
  else begin
    if Random(30) = 0 then
      SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  end;  }
  inherited;
end;

procedure TGuildOfficial.UserSelect(PlayObject: TPlayObject; sData: string);
var
  sMsg, sLabel, s18: string;
  boCanJmp: Boolean;
  nLabel: integer;
resourcestring
  sExceptionMsg = '[Exception] TGuildOfficial::UserSelect... ';
begin
  inherited;
  try
    PlayObject.m_nScriptGotoCount := 0;
    if (sData <> '') and (sData[1] = '@') then begin
      sMsg := GetValidStr3(sData, sLabel, [#13]);
      s18 := sLabel;
      if Length(sLabel) < 2 then
        exit;
      if (sLabel[2] = '@') and (sLabel[1] = '@') then begin
        sLabel := Copy(sLabel, 3, length(sLabel) - 2);
      end
      else begin
        sLabel := Copy(sLabel, 2, length(sLabel) - 1);
      end;
      nLabel := StrToIntDef(sLabel, -99999);
      if nLabel >= 100000 then
        nLabel := nLabel mod 100000;
      boCanJmp := PlayObject.LableIsCanJmp(s18, PlayObject.m_boResetLabel and (nLabel = -99999));
      PlayObject.m_sScriptLable := s18;

      if PlayObject.m_boResetLabel and (nLabel = -99999) then
        nLabel := GetScriptIndex(s18);
      //nLabel := StrToIntDef(sLabel, 0);

      GotoLable(PlayObject, nLabel, not boCanJmp, s18);

      if not boCanJmp then
        Exit;

      if CompareText(s18, sBUILDGUILDNOW) = 0 then begin
        ReQuestBuildGuild(PlayObject, sMsg);
      end
      else if CompareText(s18, sSCL_GUILDWAR) = 0 then begin
        ReQuestGuildWar(PlayObject, sMsg);
      end
      else if CompareText(s18, sDONATE) = 0 then begin
        DoNate(PlayObject);
      end
      else if CompareLStr(s18, sREQUESTCASTLEWAR, Length(sREQUESTCASTLEWAR)) then begin
        ReQuestCastleWar(PlayObject, Copy(s18, Length(sREQUESTCASTLEWAR) + 1, Length(s18) - Length(sREQUESTCASTLEWAR)));
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
  //  inherited;
end;

function TGuildOfficial.ReQuestBuildGuild(PlayObject: TPlayObject; sGuildName: string): Integer;
var
  UserItem: pTUserItem;
  //  sKey: string;
  sSendMsg: string;
begin
  Result := 0;
  try
    if PlayObject.m_nWaitIndex <> 0 then
      exit;
    sGuildName := Trim(sGuildName);
    //  UserItem := nil;
    if not (length(sGuildName) in [6..14]) then begin
      Result := -5;
    end
    else if not CheckCorpsChr(sGuildName) then begin
      Result := -4;
    end;
    if CheckFilterGuild(sGuildName) then begin
      Result := -7;
    end;
    if Result = 0 then begin
      if PlayObject.m_MyGuild = nil then begin
        if PlayObject.m_nGold >= g_Config.nBuildGuildPrice then begin
          UserItem := PlayObject.CheckItems(g_Config.sWomaHorn);
          if UserItem = nil then begin
            Result := -3; //'你没有准备好需要的全部物品。'
          end;
        end
        else
          Result := -2; //'缺少创建费用。'
      end
      else
        Result := -1; //'您已经加入其它行会。'
    end;
    if g_GuildManager.FindGuild(sGuildName) <> nil then
      Result := -6;

    if Result = 0 then begin
      if not g_boTestServer then begin
        PlayObject.m_nWaitIndex := GetWaitMsgID;
        sSendMsg := IntToStr(PlayObject.m_nWaitIndex) + '/';
        sSendMsg := sSendMsg + IntToStr(PlayObject.m_nDBIndex) + '/';
        sSendMsg := sSendMsg + IntToStr(RM_CREATENEWGUILD) + '/';
        sSendMsg := sSendMsg + sGuildName;
        FrmIDSoc.SendCreateGuildMsg(sSendMsg);
      end
      else
        PlayObject.SendMsg(PlayObject, RM_CREATENEWGUILD, 0, 0, 0, 0, sGuildName);
    end
    else begin
      PlayObject.SendDefMsg(Self, SM_BUILDGUILD_FAIL, Result, 0, 0, 0, '');
    end;
  except
    on E: Exception do begin
      MainOutMessage('[Exception] TGuildOfficial.ReQuestBuildGuild');
      MainOutMessage(E.Message);
    end;
  end;
end;

function TGuildOfficial.ReQuestGuildWar(PlayObject: TPlayObject; sGuildName: string): Integer;
begin
  try
    if g_GuildManager.FindGuild(sGuildName) <> nil then begin
      if PlayObject.m_nGold >= g_Config.nGuildWarPrice then begin
        PlayObject.DecGold(g_Config.nGuildWarPrice);
        PlayObject.GoldChanged();
        PlayObject.ReQuestGuildWar(sGuildName);
      end
      else begin
        PlayObject.SendDefMessage(SM_MENU_OK, Integer(Self), 0, 0, 0, '你没有足够的金币.');
        //PlayObject.SysMsg('你没有足够的金币.', c_Red, t_Hint);
      end;
    end
    else begin
      //PlayObject.SysMsg('行会 ' + sGuildName + ' 不存在.', c_Red, t_Hint);
      PlayObject.SendDefMessage(SM_MENU_OK, Integer(Self), 0, 0, 0, '行会[' + sGuildName + ']不存在.');
    end;
  except
    on E: Exception do begin
      MainOutMessage('[Exception] TGuildOfficial.ReQuestGuildWar');
      MainOutMessage(E.Message);
    end;
  end;
  Result := 1;
end;

procedure TGuildOfficial.DoNate(PlayObject: TPlayObject); //004A346C
begin
  PlayObject.SendDefMsg(Self, SM_DONATE_OK, 0, 0, 0, 0, '');
end;

procedure TGuildOfficial.ReQuestCastleWar(PlayObject: TPlayObject; sIndex: string); //004A3498
var
  UserItem: pTUserItem;
  Castle: TUserCastle;
  nIndex: Integer;
  nCode: Integer;
begin
  //  if PlayObject.IsGuildMaster and
  //     (not UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild))) then begin
  nCode := 0;
  try
    nIndex := StrToIntDef(sIndex, -1);
    if nIndex < 0 then
      nIndex := 0;
    nCode := 1;
    Castle := g_CastleManager.GetCastle(nIndex);
    if PlayObject.IsGuildMaster and (Castle <> nil) and (not Castle.IsMember(PlayObject)) then begin
      nCode := 2;
      UserItem := PlayObject.CheckItems(g_Config.sZumaPiece);
      if UserItem <> nil then begin
        nCode := 3;
        if Castle.AddAttackerInfo(TGuild(PlayObject.m_MyGuild)) then begin
          nCode := 4;
          PlayObject.SendDelItems(UserItem);
          PlayObject.DelBagItem(UserItem.MakeIndex, g_Config.sZumaPiece);
          nCode := 5;
          GotoLable(PlayObject, FGotoLable[nSuprequest_ok], False);
          nCode := 6;
        end
        else begin
          //PlayObject.SysMsg('你现在无法请求攻城.', c_Red, t_Hint);
          PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '您现在无法请求攻城战争.');
        end;

      end
      else begin
        PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0,
          '您的请求被取消，您缺少物品 ' + g_Config.sZumaPiece + '.');
        //PlayObject.SysMsg('你没有' + g_Config.sZumaPiece + '.', c_Red, t_Hint);
      end;
    end
    else begin
      PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '您的请求被取消，只有行会掌门人才可以申请.');
      //PlayObject.SysMsg('你的请求被取消.', c_Red, t_Hint);
    end;
  except
    on E: Exception do begin
      MainOutMessage('[Exception] TGuildOfficial.ReQuestCastleWar ' + IntToStr(nCode));
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TCastleOfficial.RepairDoor(PlayObject: TPlayObject); //004A3FB8
begin
  if m_Castle = nil then begin
    PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, 'NPC不属于城堡.');
    //PlayObject.SysMsg('NPC不属于城堡.', c_Red, t_Hint);
    Exit;
  end;
  if TUserCastle(m_Castle).m_boUnderWar then begin
    PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '攻城期间不能修复.');
    exit;
  end;
  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nRepairDoorPrice then begin
    if TUserCastle(m_Castle).RepairDoor then begin
      Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nRepairDoorPrice);
      PlayObject.SysMsg('城门修理成功.', c_Red, t_Hint);
      //PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '修理成功.');
    end
    else begin
      PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '城门不需要修理.');
      //PlayObject.SysMsg('城门不需要修理.', c_Green, t_Hint);
    end;
  end
  else begin
    PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '城内资金不足.');
    //PlayObject.SysMsg('城内资金不足.', c_Red, t_Hint);
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nRepairDoorPrice then begin
    if UserCastle.RepairDoor then begin
      Dec(UserCastle.m_nTotalGold,g_Config.nRepairDoorPrice);
      PlayObject.SysMsg('修理成功。',c_Green,t_Hint);
    end else begin
      PlayObject.SysMsg('城门不需要修理.',c_Green,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('城内资金不足.',c_Red,t_Hint);
  end;
  }
end;

procedure TCastleOfficial.RepairWallNow(nWallIndex: Integer;
  PlayObject: TPlayObject); //004A4074
begin
  if m_Castle = nil then begin
    PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, 'NPC不属于城堡.');
    //PlayObject.SysMsg('NPC不属于城堡.', c_Red, t_Hint);
    Exit;
  end;
  if TUserCastle(m_Castle).m_boUnderWar then begin
    PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '攻城期间不能修复.');
    exit;
  end;

  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nRepairWallPrice then begin
    if TUserCastle(m_Castle).RepairWall(nWallIndex) then begin
      Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nRepairWallPrice);
      PlayObject.SysMsg('城墙修理成功。', c_Red, t_Hint);
      //PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '修理成功.');
    end
    else begin
      //PlayObject.SysMsg('城墙不需要修理.', c_Green, t_Hint);
      PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '该城墙不需要修理.');
    end;
  end
  else begin
    //PlayObject.SysMsg('城内资金不足.', c_Red, t_Hint);
    PlayObject.SendDefMsg(PlayObject, SM_MENU_OK, Integer(Self), 0, 0, 0, '城内资金不足.');
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nRepairWallPrice then begin
    if UserCastle.RepairWall(nWallIndex) then begin
      Dec(UserCastle.m_nTotalGold,g_Config.nRepairWallPrice);
      PlayObject.SysMsg('修理成功。',c_Green,t_Hint);
    end else begin
      PlayObject.SysMsg('城门不需要修理.',c_Green,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('城内资金不足.',c_Red,t_Hint);
  end;
  }
end;

constructor TCastleOfficial.Create;
begin
  inherited;

end;

destructor TCastleOfficial.Destroy;
begin

  inherited;
end;

constructor TGuildOfficial.Create;
begin
  inherited;
  m_btRaceImg := RCC_MERCHANT;
  m_wAppr := 8;
end;

destructor TGuildOfficial.Destroy;
begin

  inherited;
end;
{
procedure TGuildOfficial.SendCustemMsg(PlayObject: TPlayObject;
  sMsg: string);
begin
  inherited;

end;   }
 {
procedure TCastleOfficial.SendCustemMsg(PlayObject: TPlayObject;
  sMsg: string);
begin
  if not g_Config.boSubkMasterSendMsg then begin
    PlayObject.SysMsg(g_sSubkMasterMsgCanNotUseNowMsg, c_Red, t_Hint);
    Exit;
  end;
  if PlayObject.m_boSendMsgFlag then begin
    PlayObject.m_boSendMsgFlag := False;
    UserEngine.SendBroadCastMsg(PlayObject.m_sCharName + ': ' + sMsg, t_Castle);
  end
  else begin

  end;
end;     }

{ TFunMerchant }

constructor TFunMerchant.Create;
begin
  inherited;
  SafeFillChar(FStdModeFunc[0], SizeOf(FStdModeFunc), 0);
  SafeFillChar(FPlayLevelUp[0], SizeOf(FPlayLevelUp), 0);
  SafeFillChar(FUserCmd[0], SizeOf(FUserCmd), 0);
  SafeFillChar(FClearMission[0], SizeOf(FClearMission), 0);
  SafeFillChar(FMagSelfFunc[0], SizeOf(FMagSelfFunc), 0);
  SafeFillChar(FMagTagFunc[0], SizeOf(FMagTagFunc), 0);
  SafeFillChar(FMagTagFuncEx[0], SizeOf(FMagTagFuncEx), 0);
  SafeFillChar(FMagMonFunc[0], SizeOf(FMagMonFunc), 0);
  m_btNPCRaceServer := NPC_RC_FUNMERCHANT;
end;

destructor TFunMerchant.Destroy;
begin

  inherited;
end;

procedure TFunMerchant.LoadNpcScript;
begin
  inherited;
  UserEngine.MonGenInitialize;
end;

{ TMapEventMerchant }

procedure TMapEventMerchant.LoadNpcScript;
begin
  inherited LoadNpcScript;
  FrmDB.LoadMapEvent;
end;

{ TBoxMonster }

constructor TBoxMonster.Create;
begin
  inherited;
  m_btRaceServer := RC_BOX;
end;

destructor TBoxMonster.Destroy;
begin
  inherited;
end;

procedure TBoxMonster.Initialize;
begin
  m_btDirection := Random(3);
  inherited;
  m_nBoxIndex := m_Abil.Level;
  m_Abil.Level := High(Word);
  m_WAbil.Level := High(Word);
end;

function TBoxMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := False;
  {if ProcessMsg.wIdent = RM_MAGSTRUCK then
    Result := inherited Operate(ProcessMsg); }
end;

procedure TBoxMonster.Run;
begin
  m_WAbil.HP := m_WAbil.MaxHP;
  if m_Master <> nil then
    m_Master := nil;
  inherited Run;
end;

end.

