unit ObjBase;
                                                                                                       
interface
uses
  Windows, Classes, SysUtils, Forms, StrUtils, Math, Grobal2, Envir, Common, DateUtils;

type
  TClientAction = (cHit, cMagHit, cRun, cWalk, cDigUp, cTurn);

  TAttackState = (as_None, as_Close, as_Dare);
  TClientVersion = set of (cv_Mir2, cv_Test, cv_Debug, cv_Free);
  //  TSayMsgType = (s_NoneMsg,s_GroupMsg,s_GuildMsg,s_SystemMsg,s_NoticeMsg);
  TGender = (gMan, gWoMan);
  TJob = (jWarr, jWizard, jTaos);

  TMagicFunState = (mfs_Self, mfs_Tag, mfs_TagEx, mfs_Mon);

//{$REGION 'TBaseObject Class'}
  TBaseObject = class
    m_sMapName: string[16]; //0x04
    m_sCharName: string[24]; //0x15
    m_nCurrX: Integer; //0x24  人物所在座标X(4字节)
    m_nCurrY: Integer; //0x28  人物所在座标Y(4字节)
    m_btDirection: Byte; //    人物所在方向(1字节)
    m_btGender: Byte; //0x2D  人物的性别(1字节)
    m_btHair: Byte; //0x2E  人物的头发(1字节)
    m_btJob: Byte; //0x2F  人物的职业(1字节)
    m_nGold: Integer; //0x30  人物金币数(4字节)
    m_Abil: TAbility; //0x34 -> 0x5B
    //m_DBAbil: TAbility;
    m_NakedAddAbil: TNakedAddAbil;
    m_nCharStatus: Integer; //0x5C
    m_sHomeMap: string[16]; //0x78  //回城地图
    m_nHomeX: Integer; //0x8C  //回城座标X
    m_nHomeY: Integer; //0x90  //回城座标Y
    m_sDieMap: string[16]; //0x78  //死亡地图
    m_nDieX: Integer; //0x8C  //死亡座标X
    m_nDieY: Integer; //0x90  //死亡座标Y
    //bo94: Boolean; //0x94
    m_boOnHorse: Boolean; //0x95
    m_boCanOnHorse: Boolean;
    m_dwCanOnHorseTime: LongWord;
    m_boHorseHit: Boolean;
    m_btHorseType: Byte;
    m_btHorseDress: Byte;
    m_btDressEffType: Byte;
    {n98: Integer; //0x98
    n9C: Integer; //0x9C
    nA0: Integer; //0xA0
    nA4: Integer; //0xA4
    nA8: Integer; //0xA8  }

    m_nPkPoint: Word; //0xAC  人物的PK值(4字节)
//    btB2: Byte; //0xB2
    //btB3: Byte; //0xB3
    m_nIncHealth: Integer; //0x0B4
    m_nIncSpell: Integer; //0x0B8
    m_nIncHealing: Integer; //0x0BC
    m_nIncHPStoneTime: LongWord;
    m_nIncMPStoneTime: LongWord;
    m_nFightZoneDieCount: Integer;

    //0x0C0  //在行会占争地图中死亡次数
  // nC4: Integer;
   //btC8: Byte; //0xC8
    //btC9: Byte; //0xC9
    //m_BonusAbil: TNakedAbility; //0x0CA TNakedAbility
    //m_CurBonusAbil: TNakedAbility; //0x0DE
//    m_nBonusPoint: Integer; //0x0F4
//    m_nHungerStatus: Integer; //0x0F8

    //      btFC               :Byte;
    {m_btFD: Byte;
    m_btFE: Byte;
    m_btFF: Byte;    }
    m_dBodyLuck: Double; //0x100
    m_nBodyLuckLevel: Integer; //0x108
    
    m_wGroupRcallTime: Word; //0x10C
    m_wGuildRcallTime: Word; //0x10C


    m_boAllowGroupReCall: Boolean; //0x10E  //允许天地合一
    m_boAllowGuildReCall: Boolean; //0xFC   //允许行会合一
    m_boOldChangeMapMode: Boolean;

    m_boCheckGroup: Boolean; //0xB0   组队需要验证
    m_boAllowGroup: Boolean; //0xB0  允许组队
    m_boAllowGuild: Boolean; //0xB1  允许加入行会
    m_boAllowFrieng: Boolean; //允许加为好友

    m_boBanHearChat: Boolean; //允许白字聊天
    m_boHearWhisper: Boolean; //0x27C  允许私聊
    m_boBanShout: Boolean; //0x27D  允许喊话
    m_boBanGuildChat: Boolean; //0x27E  允许行会聊天
    m_boBanGroupChat: Boolean; //允许队伍聊天
    m_boAllowDeal: Boolean; //0x27F  允许交易

    //m_QuestUnitOpen: TQuestUnit; //0x10F
    //m_QuestUnit: TQuestUnit; //0x11C


    m_nCharStatusEx: Integer;
    m_dwFightExp: LongWord; //0x194   //怪物经验值
    m_WAbil: TAbility; //0x198
    m_AddAbil: TAddAbility; //0x1C0
    m_TempAddAbil: TAddAbility;
    m_AddHP: Integer;
    m_OldHP: Integer;
    m_NotOnHorseHP: Integer;
    m_nViewRange: Integer; //0x1E4   //可视范围大小
    m_wStatusTimeArr: TStatusTime; //0x60
    m_dwStatusArrTick: array[0..MAX_STATUS_ATTRIBUTE - 1] of LongWord; //0x1E8
    //m_boStatus: Boolean; //人物属性TRUE =上升 FALSE =下降
    m_boAC: Boolean;
    m_boMAC: Boolean;
    m_boDC: Boolean;
    m_boMC: Boolean;
    m_boSC: Boolean;
    m_boHitSpeed: Boolean;
    m_boMaxHP: Boolean;
    m_boMaxMP: Boolean;
    m_wStatusArrValue: array[0..5] of Word; //0x218
    m_dwStatusArrTimeOutTick: array[0..5] of LongWord;
    // :Tarry220;           //0x220
    m_wAppr: Word; //0x238
    m_btRaceServer: Byte; //0x23A   //角色类型
    m_btRaceImg: Byte; //0x23B   //角色外形
    m_btHitPoint: Byte; //0x23C   人物攻击准确度(Byte)
    m_btAddAttack: Byte;
    m_btDelDamage: Byte;
    m_btAddWuXinAttack: Byte;
    m_btDelWuXinAttack: Byte;
    m_nHitPlus: ShortInt; //0x23D
    m_nHitDouble: ShortInt; //0x23E
    m_dwGroupRcallTick: LongWord; //0x240  记忆使用间隔(Dword)
    m_boRecallSuite: Boolean; //0x244  记忆全套
    //bo245: Boolean; //0x245
    m_boTestGa: Boolean; //0x246  //是否输入Testga 命令
    m_boGsa: Boolean; //0x247  //是否输入gsa 命令
    m_nHealthRecover: ShortInt; //0x248
    m_nSpellRecover: ShortInt; //0x249
    m_btAntiPoison: Byte; //0x24A
    m_nPoisonRecover: ShortInt; //0x24B
    m_nAntiMagic: ShortInt; //0x24C 魔法躲避几率
    m_nLuck: Integer; //0x250  人物的幸运值Luck
    m_btDeadliness: Byte; //致命一击
    m_nPerHealth: Integer; //0x254
    m_nPerHealing: Integer; //0x258
    m_nPerSpell: Integer; //0x25C
    m_dwIncHealthSpellTick: LongWord; //0x260
    m_btGreenPoisoningPoint: Byte; //0x264  中绿毒降HP点数
    m_nGoldMax: Integer; //0x268  人物身上最多可带金币数(Dword)
    m_btSpeedPoint: Byte; //0x26C  人物敏捷度(Byte)
    m_btPermission: Byte; //0x26D  人物权限等级
    m_nHitSpeed: ShortInt; //0x26E  //1-18 攻击速度
    //    m_nHitDunt: Byte; //致命一击
    m_boNotInSafe: Boolean;
    m_btLifeAttrib: Byte; //0x26F
    m_btCoolEye: Byte; //0x270
    m_GroupClass: Boolean;
    m_GroupOwner: TBaseObject; //0x274
    m_GroupMembers: TStringList; //0x278  组成员
    m_BlockWhisperList: TStringList; //0x280  禁止私聊人员列表
    m_dwShoutMsgTick: LongWord; //0x284
    m_Master: TBaseObject; //0x288  是否被召唤(主人)
    //m_AllMaster: TBaseObject;
    m_dwMasterRoyaltyTick: LongWord; //0x28C  怪物叛变时间
    m_dwMasterTick: LongWord; //0x290
    m_nKillMonCount: Integer; //0x294  杀怪计数
    m_btSlaveExpLevel: Byte; //0x298  宝宝等级 1-7
    m_btSlaveMakeLevel: Byte; //0x299  召唤等级
    m_SlaveList: TList; //0x29C  下属列表
    //bt2A0: Byte; //0x2A0
    m_boSlaveRelax: Boolean; //0x2A0  宝宝攻击状态(休息/攻击)(Byte)
    m_btAttatckMode: Byte; //0x2A1  下属攻击状态
    m_btNameColor: Byte; //0x2A2  人物名字的颜色(Byte)
    //m_nLight: Integer; //0x2A4  亮度
    m_boGuildWarArea: Boolean; //0x2A8  行会占争范围
    m_Castle: TObject; //0x2AC //所属城堡
    bo2B0: Boolean; //0x2B0
    m_dw2B4Tick: LongWord; //0x2B4
    m_boSuperMan: Boolean; //0x2B8  无敌模式
    bo2B9: Boolean; //0x2B9
    bo2BA: Boolean; //0x2BA
    m_boAnimal: Boolean; //0x2BB
    m_boNoItem: Boolean; //0x2BC
    m_boFixedHideMode: Boolean; //0x2BD
    m_boStickMode: Boolean; //0x2BE
    bo2BF: Boolean; //0x2BF
    m_boNoAttackMode: Boolean; //0x2C0
    //bo2C1: Boolean; //0x2C1
    m_boSkeleton: Boolean; //0x2C2
    m_nMeatQuality: Integer; //0x2C4
    m_nBodyLeathery: Integer; //0x2C8
    m_boHolySeize: Boolean; //0x2CC
    m_dwHolySeizeTick: LongWord; //0x2D0
    m_dwHolySeizeInterval: LongWord; //0x2D4
    m_boCrazyMode: Boolean; //0x2D8
    m_dwCrazyModeTick: LongWord; //0x2DC
    m_dwCrazyModeInterval: LongWord; //0x2E0
    m_boShowHP: Boolean; //0x2E4
    //      nC2E6                   :Integer;      //0x2E6
    m_dwShowHPTick: LongWord; //0x2E8  心灵启示检查时间(Dword)
    m_dwShowHPInterval: LongWord; //0x2EC  心灵启示有效时长(Dword)
    bo2F0: Boolean; //0x2F0
    m_dwDupObjTick: LongWord; //0x2F4
    m_PEnvir: TEnvirnoment; //0x2F8
    m_boGhost: Boolean; //0x2FC
    m_boDisappear: Boolean;
    m_dwGhostTick: LongWord; //0x300
    m_boDeath: Boolean; //0x304
    m_dwDeathTick: LongWord; //0x308
    //    m_btMonsterWeapon: Byte; //0x30C 怪物所拿的武器
    m_dwStruckTick: LongWord; //0x310
    m_boWantRefMsg: Boolean; //0x314
    m_boAddtoMapSuccess: Boolean; //0x315
//    m_bo316: Boolean; //0x316
    m_MyGuild: TObject; //0x320
    m_nGuildRankNo: Integer; //0x324
    m_sGuildRankName: string; //0x328
    m_sScriptLable: string; //0x32C
    m_btAttackSkillCount: Byte; //0x330
    m_btAttackSkillPointCount: Byte; //0x334
    m_boMission: Boolean; //0x338
    m_nMissionX: Integer; //0x33C
    m_nMissionY: Integer; //0x340
    m_btMissionDir: Byte;
    m_boHideMode: Boolean; //0x344  隐身戒指(Byte)
    m_boStoneMode: Boolean; //0x345
    m_boCoolEye: Boolean; //0x346  //是否可以看到隐身人物
    m_boUserUnLockDurg: Boolean; //0x347  //是否用了神水
    m_boTransparent: Boolean; //0x348  //魔法隐身了
    m_boAdminMode: Boolean; //0x349  管理模式(Byte)
    m_boObMode: Boolean; //0x34A  隐身模式(Byte)
    m_boTeleport, m_boTeleportEx: Boolean; //0x34B  传送戒指(Byte)
    m_boParalysis: Boolean; //0x34C  麻痹戒指(Byte)
    m_boUnParalysis: Boolean;
    m_boRevival: Boolean; //0x34D  复活戒指(Byte)
    m_boUnRevival: Boolean; //防复活
    m_dwRevivalTick: LongWord; //0x350  复活戒指使用间隔计数(Dword)
    m_boFlameRing: Boolean; //0x354  火焰戒指(Byte)
    m_boRecoveryRing: Boolean; //0x355  治愈戒指(Byte)
    m_boAngryRing: Boolean; //0x356  未知戒指(Byte)
    m_boMagicShield: Boolean; //0x357  护身戒指(Byte)
    m_boUnMagicShield: Boolean; //防护身
    m_boMuscleRing: Boolean; //0x358  活力戒指(Byte)
    m_boFastTrain: Boolean; //0x359  技巧项链(Byte)
    m_boProbeNecklace: Boolean; //0x35A  探测项链(Byte)
    m_boGuildMove: Boolean; //行会传送
    m_boSupermanItem: Boolean;
    m_bopirit: Boolean; //祈祷

    m_boNoDropItem: Boolean;
    m_boNoDropUseItem: Boolean;
    m_boExpItem: Boolean;
    m_boPowerItem: Boolean;

    m_rExpItem: real;
    m_rPowerItem: real;
    m_dwPKDieLostExp: LongWord; //PK 死亡掉经验，不够经验就掉等级
    m_nPKDieLostLevel: Integer; //PK 死亡掉等级
    m_nItemExp: Integer;
    m_nSetItemExp: Integer;

    m_boAbilSeeHealGauge: Boolean; //0x35B  //心灵启示
    m_boAbilMagBubbleDefence: Boolean; //0x35C  //魔法盾
    m_btMagBubbleDefenceLevel: Byte; //0x35D
    m_boAbilMagShieldDefence: Boolean; //0x35C  //金刚护盾
    m_btMagShieldDefenceLevel: Byte; //0x35D

    m_dwSearchTime: LongWord; //0x360
    m_dwSearchTick: LongWord; //0x364
    m_dwRunTick: LongWord; //0x368
    m_nRunTime: Integer; //0x36C
    m_nHealthTick: Integer;
    //0x370    //特别指定为 此类型  此处用到 004C7CF8
    m_nSpellTick: Integer; //0x374
    m_TargetCret: TBaseObject; //0x378
    m_dwTargetFocusTick: LongWord; //0x37C
    m_LastHiter: TBaseObject;
    //0x380  人物被对方杀害时对方指针(Dword)
    m_LastHiterTick: LongWord; //0x384
    m_ExpHitter: TBaseObject; //0x388
    m_ExpHitterTick: LongWord; //0x38C
    m_dwTeleportTick: LongWord; //0x390  传送戒指使用间隔(Dword)
    m_dwProbeTick: LongWord; //0x394  探测项链使用间隔(Dword)
    m_dwMapMoveTick: LongWord; //0x398
    m_boPKFlag: Boolean; //0x39C  人物攻击变色标志(Byte)
    m_dwPKTick: LongWord; //0x3A0  人物攻击变色时间长度(Dword)
    m_nMoXieSuite: Integer; //0x3A4  魔血一套(Dword)
    m_nHongMoSuite: Integer; //0x3A8 虹魔一套(Dword)
    m_n3AC: Integer; //0x3AC
    m_db3B0: Double; //0x3B0
    m_dwPoisoningTick: LongWord; //0x3B8 中毒处理间隔时间(Dword)
    m_dwDecPkPointTick: LongWord; //0x3BC  减PK值时间(Dword)
    m_DecLightItemDrugTick: LongWord; //0x3C0
    m_dwVerifyTick: LongWord; //0x3C4
    m_dwCheckRoyaltyTick: LongWord; //0x3C8
    m_dwDecHungerPointTick: LongWord; //0x3CC
    m_dwHPMPTick: LongWord; //0x3D0
    m_MsgList: TList; //0x3D4
    m_VisibleHumanList: TList; //0x3D8
    m_VisibleItems: TList; //0x3DC
    m_VisibleEvents: TList; //0x3E0
    m_SendRefMsgTick: LongWord; //0x3E4
    m_boInFreePKArea: Boolean; //0x3E8  是否在开行会战(Byte)
//    LIst_3EC: TList; //0x3EC
    dwTick3F0: LongWord; //0x3F0
    dwTick3F4: LongWord; //0x3F4
    m_dwHitTick: LongWord; //0x3F8
    m_dwWalkTick: LongWord; //0x3FC
    m_dwSearchEnemyTick: LongWord; //0x400
    m_boNameColorChanged: Boolean; //0x404
    m_boIsVisibleActive: Boolean; //是否在可视范围内有人物,及宝宝                          
    m_nVisibleActiveCount: Integer; //周围可视人物及宝宝数量
    m_nProcessRunCount: ShortInt;
    m_VisibleActors: TList; //0x408
    m_ItemList: TList; //0x40C  人物背包(Dword)数量
    m_CanDropItemList: TList; //怪物可爆物品列表
    m_nMaxItemListCount: Integer;

    m_UseItems: THumanUseItems; //这个是身上装备的定义
    m_SayMsgList: TList;
    m_nWalkSpeed: Integer; //0x4FC
    m_nWalkStep: Integer; //0x500
    m_nWalkCount: Integer; //0x504
    m_dwWalkWait: LongWord; //0x508
    m_dwWalkWaitTick: LongWord; //0x50C
    m_boWalkWaitLocked: Boolean; //0x510
    m_nNextHitTime: Integer; //0x514
{    m_MagicOneSwordSkill: pTUserMagic; //0x518
    m_MagicPowerHitSkill: pTUserMagic; //0x51C
    m_MagicErgumSkill: pTUserMagic; //0x520 刺杀剑法
    m_MagicBanwolSkill: pTUserMagic; //0x524 半月弯刀
    m_MagicFireSwordSkill: pTUserMagic; //0x528
    m_MagicCrsSkill: pTUserMagic; //0x528
    m_Magic41Skill: pTUserMagic; //0x528
    m_Magic42Skill: pTUserMagic; //0x528
    m_Magic43Skill: pTUserMagic; //0x528  }
    m_boPowerHit: Boolean; //0x52C
    m_boCanGetRandomItems: Boolean;

    

    {m_boCrsHitkill: Boolean; //0x52F
    m_bo41kill: Boolean; //0x52F
    m_bo42kill: Boolean; //0x52F
    m_bo43kill: Boolean; //0x52F    }

//    m_dwDoMotaeboTick: LongWord; //0x534
//    m_boDenyRefStatus: Boolean; //是否刷新在地图上信息；
    m_boAddToMaped: Boolean; //是否增加地图计数
    m_boDelFormMaped: Boolean; //是否从地图中删除计数
    m_boAutoChangeColor: Boolean;
    m_dwAutoChangeColorTick: LongWord;
    m_nAutoChangeIdx: Integer;

    m_boFixColor: Boolean; //固定颜色
    m_nFixColorIdx: Integer;
    m_nFixStatus: Integer;
    m_boFastParalysis: Boolean; //快速麻痹，受攻击后麻痹立即消失
    m_nFastParalysis: Byte; //快速麻痹，受攻击后麻痹立即消失
    m_dwFireBurnTick: LongWord;

    m_DefMsg: TDefaultMessage; //0x550
    m_nSocket: Integer; //0x59C nSocket
    m_nGSocketIdx: Integer;
    //0x5A0 wGateIndex 人物连接到游戏网关SOCKET ID
    m_nGateIdx: Integer; //0x5A8 nGateIdx   人物所在网关号
    m_nSoftVersionDate: Integer; //0x5AC

    //m_nCopyHumanLevel: Integer; //复制人辈分等级
    m_dwStationTick: LongWord; //增加检测人物站立不动时间
    m_dwSayMyInfoTick: LongWord;

    m_MapQuestList: TList;

    //Base英雄变量

    m_nGloryPoint: Integer;
    m_boDeliria: Boolean;
    m_TempItemList: TList;
    m_btStartType: Byte;
    m_btWuXin: Byte; //五行类型
    m_boMapApoise: Boolean; //客户端地图准备完毕
    m_dwMapApoiseTick: LongWord;
    m_btMapSpaceShow: Byte;
    m_btStrengthenName: Byte;
    m_nSlaveMagIndex: Integer;

    m_boKeepRun: Boolean;
    m_boMeltTarget: Boolean;
    m_nDieScript: Integer;
    m_PHookX: PInteger;
    m_PHookY: PInteger;
    m_boChangeMap: Boolean;
    m_boUseGodShield: Boolean;
    m_AttackState: TAttackState;
    m_ClientVersion: TClientVersion;
    m_nClientVersion: Integer;

    m_boReliveNoDrop: Boolean;
    //m_MonGen: pTMonGenInfo;
    //m_boRunAll: Boolean; //步行是否允许穿人穿怪
    //m_Magic: array[0..SKILL_MAX] of pTUserMagic;
//    m_btWuXinLevel: Byte;
//    m_nWuXinExp: LongWord;
//    m_nWuXinMaxExp: LongWord;
//    m_dwIsGetWuXinExpTime: LongWord; //是否增加五行经验时间
//    m_nItemKickMonExp: LongWord;
//    m_dwItemWuXinExpRate: LongWord;
  protected
    function InSafeArea: Boolean;
    function Walk(nIdent: Integer): Boolean;
    procedure HearMsg(sMsg: string);
    procedure SendGroupText(sMsg: string);
    procedure DoDamageWeapon(nWeaponDamage: Integer);
    procedure UpdateVisibleGay(BaseObject: TBaseObject);
    procedure UpdateVisibleItem(wX, wY: Integer; MapItem: PTMapItem);
    procedure UpdateVisibleEvent(wX, wY: Integer; MapEvent: TObject);

  private




    function AddToMap(): Boolean;
    //procedure UseLamp();
    procedure CheckPKStatus();


    procedure GetAccessory(Item: pTUserItem; var AddAbility: TAddAbility);
    //procedure RecalcHitSpeed();
    {procedure AddItemSkill(nIndex: Integer);
    procedure DelItemSkill(nIndex: Integer);  }
    procedure DecPKPoint(nPoint: Integer);

    procedure LeaveGroup();


  protected
    procedure AttackJump;
  public
    //function GetUserMagic(MagID: integer): pTUserMagic;
    //procedure SetUserMagic(MagID: integer; UserMagic: pTUserMagic);
    procedure SetClientVersion(AClientVersion: Integer);
    function IsMonster: Boolean;
    procedure DelMember(BaseObject: TBaseObject);
    procedure AttackDir(TargeTBaseObject: TBaseObject; wHitMode: Word; nDir: Integer); virtual;
    procedure DamageSpell(nSpellPoint: Integer);
    function GetCharColor(BaseObject: TBaseObject): Byte;
    function GetNamecolor: Byte; virtual;
    constructor Create(); virtual;
    destructor Destroy; override;
    procedure NpcGotoLable(NormNpc: TBaseObject; nLabel: Integer; boMaster: Boolean; sLabel: string = '');
    procedure MagicQuest(TagreBase: TBaseObject; nMagID: Integer; State: TMagicFunState);
    function GetLevelExp(nLevel: Integer): LongWord;
    function CanWork: Boolean;
    procedure ChangeStatusMode(nStatus: Integer; boMode: Boolean); virtual;
    //function GetWuXinLevelExp(nLevel: Integer): LongWord;
    procedure DuraChange(idx, Dura, DuraMax: Integer);
    procedure SendUpdateDelayMsg(BaseObject: TBaseObject; wIdent, wParam: Integer;
      lParam1, lParam2, lParam3: Integer; sMsg: string; dwDelay: LongWord); virtual;
    procedure SendMsg(BaseObject: TBaseObject; wIdent, wParam: Integer; nParam1,
      nParam2, nParam3: Integer; sMsg: string); { virtual;  }

    procedure SendUpdateDelayDefMsg(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer;
      Param, tag, Series: Integer; sMsg: string; dwDelay: LongWord);
    procedure SendDelayDefMsg(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer;
      Param, tag, Series: Integer; sMsg: string; dwDelay: LongWord);
    procedure SendFirstDefMsg(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer;
      Param, tag, Series: Integer; sMsg: string);
    procedure SendUpdateDefMsg(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer;
      Param, tag, Series: Integer; sMsg: string);
    procedure SendDefMsg(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer; Param, tag, Series: Integer; sMsg: string);
    procedure SendDefSocket(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer; Param, tag, Series: Integer; sMsg: string);
    procedure SendFirstMsg(BaseObject: TBaseObject; wIdent, wParam: Integer; lParam1, lParam2, lParam3: Integer; sMsg: string); virtual;
    procedure SendDelayMsg(BaseObject: TBaseObject; wIdent, wParam: Integer; lParam1, lParam2, lParam3, lParam4: Integer; sMsg: string; dwDelay: LongWord); virtual;
    procedure SendRefMsg(wIdent, wParam: Integer; nParam1, nParam2, nParam3: Integer; sMsg: string; dwDelay: LongWord = 0);
    procedure SendUpdateMsg(BaseObject: TBaseObject; wIdent, wParam: Integer; lParam1, lParam2, lParam3: Integer; sMsg: string); virtual;
    procedure SendAttackMsg(wIdent, wSendIdent: Integer; btDir: Byte; nX, nY: Integer);
    procedure SysMsg(sMsg: string; MsgColor: TMsgColor; MsgType: TMsgType = t_Hint);
    procedure MenuMsg(sMsg: string);
    procedure SysDelayMsg(sMsg: string; MsgColor: TMsgColor; MsgType: TMsgType; nDelayTime: LongWord);
    procedure SysHintMsg(sMsg: string; MsgColor: TMsgColor);
    procedure MonsterSayMsg(AttackBaseObject: TBaseObject; MonStatus: TMonStatus);
    procedure RecalcLevelAbilitys;
    function PKLevel(): Integer;
    function GetFeatureEx: Integer;
    procedure MeltTargetAll;

    procedure SendAbility;
    procedure SendSubAbility;
    function InSafeZone(): Boolean; overload;
    function InSafeZone(Envir: TEnvirnoment; nX, nY: Integer): Boolean; overload;
    procedure OpenHolySeizeMode(dwInterval: LongWord);
    procedure BreakHolySeizeMode;
    procedure OpenCrazyMode(nTime: Integer);
    procedure BreakCrazyMode();
    procedure HealthSpellChanged();
    function _Attack(var wHitMode: Word; AttackTarget: TBaseObject): Boolean; virtual;
    function GetHitStruckDamage(Target: TBaseObject; nDamage: Integer): Integer;
    procedure HasLevelUp(nLevel: Integer);
    procedure OnAction(ActionType: TOnActionType); virtual;
    procedure OrdinaryAttack(BaseObject: TBaseObject); virtual;
    //procedure HasWuXinLevelUp(nLevel: Integer);
//    procedure sub_4BC87C();
    procedure GoldChanged();
    procedure GameGoldChanged;
    procedure GoldPointChanged();
    function GetPoseCreate(): TBaseObject;
    function GetGuildRelation(cert1: TBaseObject; cert2: TBaseObject): Integer;
    function IsGoodKilling(Cert: TBaseObject): Boolean;
    procedure IncPkPoint(nPoint: Integer);
    procedure AddBodyLuck(dLuck: Double);
    procedure MakeWeaponUnlock();
    procedure ScatterGolds(GoldOfCreat: TBaseObject);
    function DropGoldDown(nGold: Integer; boFalg: Boolean; GoldOfCreat, DropGoldCreat: TBaseObject): Boolean;
    function DropItemDown(UserItem: pTUserItem; nScatterRange: Integer; boDieDrop: Boolean;
      ItemOfCreat, DropCreat: TBaseObject): Boolean;
    procedure DamageHealth(nDamage: Integer);
    function GetAttackPower(nBasePower, nPower: Integer; boDeadliness: Boolean = True): Integer;
    function CharPushed(nDir, nPushCount: Integer): Integer;
    function CharPushedcbo(nDir, nPushCount: Integer): Integer;
    function GetDropPosition(nOrgX, nOrgY, nRange: Integer; var nDX: Integer; var nDY: Integer): Boolean;
    function GetBackDir(nDir: Integer): Integer;
    function GetMapBaseObjects(tEnvir: TEnvirnoment; nX, nY: Integer; nRage: Integer; rList: TList): Boolean;
    function MagPassThroughMagic(sX, sY, tx, ty, nDir, magpwr, nMagID: Integer; undeadattack: Boolean): Integer;
    procedure KickException;
    function GetMagStruckDamage(BaseObject: TBaseObject; nDamage: Integer): Integer;
    procedure DamageBubbleDefence(nInt: Integer);
    procedure DamageShieldDefence(nInt: Integer);
    procedure BreakOpenHealth;
    function GetCharStatus: Integer;
    procedure MakeOpenHealth;
    procedure IncHealthSpell(nHP, nMP: Integer);
    procedure ItemDamageRevivalRing;
    function CalcGetExp(nLevel: Integer; nExp: Integer): Integer;
    procedure GainSlaveExp(nLevel: Integer);
    procedure MapRandomMove(sMapName: string; nInt: Integer); overload;
    procedure MapRandomMove(Envir: TEnvirnoment; nInt: Integer); overload;
    procedure TurnTo(nDir: Integer);
    procedure FeatureChanged();
    function GetFeatureToLong(): Integer;
    function GetFeature(BaseObject: TBaseObject): Integer;
    function IsGroupMember(Target: TBaseObject): Boolean;
    function IsGroupMemberEx(Target: TBaseObject): Boolean;
    procedure AbilCopyToWAbil();
    procedure ChangePKStatus(boWarFlag: Boolean);
    procedure StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);
    function sub_4C4CD4(sItemName: string; var nCount: Integer): pTUserItem;
    procedure StatusChanged;
    function GeTBaseObjectInfo(): string;
    procedure TrainSkill(UserMagic: pTUserMagic; nTranPoint: Integer);
    function CheckMagicLevelup(UserMagic: pTUserMagic): Boolean;
    function MagCanHitTarget(nX, nY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagCanMoveTarget(nX, nY: Integer): Boolean;
    procedure sub_4C713C(Magic: pTUserMagic);
    function MagBubbleDefenceUp(nLevel, nSec: Integer; nType: Byte): Boolean;
    function MagShieldDefenceUp(nLevel, nSec: Integer; nType: Byte): Boolean;
    procedure ApplyMeatQuality();
    //function TakeBagItems(BaseObject: TBaseObject): Boolean;
    function AddItemToBag(UserItem: pTUserItem; StdItem32: pTStdItem; boCheck: Boolean; sDealName, sLogName: string;
      var AddUserItem: pTUserItem): Integer;
    function GetBagitem(nMakeIndex: Integer; boDelete: Boolean = False): pTUserItem;
    function DelBagItem(nIndex: Integer): Boolean; overload;
    function DelBagItem(nItemIndex: Integer; sItemName: string): Boolean; overload;
    //function DelBagItem(UserItem: pTUserItem): Boolean; overload;


    function GetAttackDir(BaseObject: TBaseObject; var btDir: Byte): Boolean;
    function TargetInSpitRange(BaseObject: TBaseObject; var btDir: Byte): Boolean;
    procedure MonsterRecalcAbilitys();
    procedure RefNameColor;
    procedure SetPKFlag(BaseObject: TBaseObject);
    procedure SetLastHiter(BaseObject: TBaseObject);
    function EnterAnotherMap(Envir: TEnvirnoment; nDMapX, nDMapY: Integer): Boolean;
    function DefenceUp(nSec: Integer): Boolean;
    function MagDefenceUp(nSec: Integer): Boolean;
    procedure RefShowName; virtual;
    function MakeSlave(sMonName: string; nMakeLevel, nExpLevel, nMaxMob, nMagID: Integer; dwRoyaltySec: LongWord): TBaseObject;
    function MakePosion(nType, nTime, nPoint: Integer): Boolean;
    function GetFrontPosition(var nX: Integer; var nY: Integer): Boolean;
    function GetBackPosition(var nX: Integer; var nY: Integer): Boolean;
    function WalkTo(btDir: Byte; boFlag: Boolean): Boolean;
    procedure SpaceMove(sMAP: string; nX, nY: Integer; nInt: Integer); overload;
    procedure SpaceMove(Envir: TEnvirnoment; nX, nY: Integer; nInt: Integer); overload;
    function GetRandXY(Envir: TEnvirnoment; var nX: Integer; var nY: Integer): Boolean;
    function sub_4C5370(nX, nY: Integer; nRange: Integer; var nDX, nDY: Integer): Boolean;
    function CheckItems(sItemName: string): pTUserItem;
    function MagMakeDefenceArea(nX, nY, nRange, nSec, nMagID: Integer; btState: Byte; boState: Boolean): Integer;
    function MagChangeAbility(nSec: Integer; btState: Byte): Boolean;
    function MagMakeAbilityArea(nX, nY, nRange, nSec, nMagID: Integer; btState: Byte; boState: Boolean): Integer; //004C6F04
    //function IsStorage(): Boolean;
    //procedure ClearStorageItem();
    procedure ClearBagItem();
    function sub_4C3538(): Integer;
    function IsGuildMaster(): Boolean;
    procedure LoadSayMsg();
    procedure DisappearA();
    procedure DisappearB();
    function GetShowName(): string; virtual;
    procedure DropUseItems(BaseObject: TBaseObject); virtual;
    procedure ScatterBagItems(ItemOfCreat: TBaseObject); virtual;
    function GetMessage(Msg: pTProcessMessage): Boolean; virtual; //FFFF
    procedure Initialize(); virtual; //FFFE
    procedure Disappear(); virtual; //FFFD
    function Operate(ProcessMsg: pTProcessMessage): Boolean; virtual; //FFFC
    procedure ClearViewRange;
    procedure SearchObjectViewRange(); // virtual; //dynamic;
    procedure Run(); virtual; //dynamic;//FFFB
    procedure ProcessMonSayMsg(sMsg: string);
    procedure MakeGhost; virtual;
    procedure Die(); virtual;
    procedure ReAlive(); virtual; //FFF8;
    procedure RecalcAbilitys(); virtual; //FFF7
    function IsProtectTarget(BaseObject: TBaseObject): Boolean; virtual; //FFF6
    function IsAttackTarget(BaseObject: TBaseObject): Boolean; virtual; //FFF5
    function IsProperTarget(BaseObject: TBaseObject): Boolean; virtual; //FFF4
    function IsProperFriend(BaseObject: TBaseObject): Boolean; virtual; //FFF3
    procedure SetTargetCreat(BaseObject: TBaseObject); virtual; //FFF2
    procedure DelTargetCreat(); virtual; //FFF1

    function IsProperTargetSKILL_54(BaseObject: TBaseObject): Boolean;
    function IsProperTargetSKILL_55(nLevel: Integer; BaseObject: TBaseObject): Boolean; virtual;
    function IsProperTargetSKILL_56(BaseObject: TBaseObject; nTargetX, nTargetY: Integer): Boolean; virtual;
    function IsProperTargetSKILL_57(BaseObject: TBaseObject): Boolean; virtual;

    function RunTo(btDir: Byte; boFlag: Boolean; nDestX, nDestY: Integer): Boolean;
    //procedure ThrustingOnOff(boSwitch: Boolean);
    //procedure HalfMoonOnOff(boSwitch: Boolean);
    {procedure SkillCrsOnOff(boSwitch: Boolean);
    procedure Skill42OnOff(boSwitch: Boolean);
    procedure Skill43OnOff(boSwitch: Boolean);   }
    {procedure AddUserItemLog(nLogID: String; BaseObject: TBaseObject; UserItem: pTUserItem;
      Stditem: pTStdItem = nil; sDealName: String = '0'; sTest: string = '1');    }
    //function AllowFireHitSkill(): Boolean;
    function CretInNearXY(TargeTBaseObject: TBaseObject; nX, nY: Integer; nRate: Byte = 1): Boolean;
    procedure HintGotoScript(nScript: Integer);
    procedure GetStartType();
    procedure ChangeHorseState(boOnHorse: Boolean);
  end;
//{$ENDREGION}

//{$REGION 'TAnimalObject Class'}
  TAnimalObject = class(TBaseObject)
    m_nNotProcessCount: Integer; //未被处理次数，用于怪物处理循环
    m_nTargetX: Integer;
    m_nTargetY: Integer;
    m_boRunAwayMode: Boolean;
    m_dwRunAwayStart: LongWord;
    m_dwRunAwayTime: LongWord;
  private

  public
    constructor Create(); override;
    procedure SearchTarget();
    procedure sub_4C959C;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
    procedure DelTargetCreat(); override;
    procedure SetTargetXY(nX, nY: Integer); virtual;
    procedure GotoTargetXY(); virtual;
    procedure Wondering(); virtual;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); virtual;
    procedure Struck(hiter: TBaseObject); virtual;
    procedure HitMagAttackTarget(TargeTBaseObject: TBaseObject; nHitPower:
      Integer; nMagPower: Integer; boFlag: Boolean);

  end;
//{$ENDREGION}


implementation

uses M2Share, Guild, HUtil32, EDcodeEx, ObjNpc, IdSrvClient, ItmUnit, Event,
  ObjMon, LocalDB, Castle, svMain, {$IFDEF PLUGOPEN}PlugOfEngine,{$ENDIF} ObjPlay;

{ TBaseObject }

//{$REGION 'TBaseObject Procedure'}

constructor TBaseObject.Create;
//var
//  i: Integer;
begin
  m_boDeliria := False;
  //英雄变量
  m_btWuXin := 0;
  //m_btWuXinLevel := 0;
  m_btStartType := OT_NONE;
  m_boKeepRun := False;
  //m_boRunAll := False;
  m_boMeltTarget := False;
  m_boCanGetRandomItems := True;

  m_MapQuestList := nil;
  m_AttackState := as_None;
  m_boCanOnHorse := False;
  m_dwCanOnHorseTime := 0;
  m_boNotInSafe := False;
  m_boOldChangeMapMode := False;
  m_dwFireBurnTick := 0;
  m_PHookX := nil;
  m_PHookY := nil;
  m_ClientVersion := [];
  m_nClientVersion := 0;
  m_boUseGodShield := False;
  //m_MonGen := nil;
  m_TempItemList := TList.Create;
  m_nGloryPoint := 0;
  m_nDieScript := -1;
  m_btStrengthenName := 0;
  m_boGhost := False;
  m_boDisappear := False;
  m_nSlaveMagIndex := -1;
  m_dwGhostTick := 0;
  m_AddHP := 0;
  m_OldHP := 0;
  m_NotOnHorseHP := 0;
  m_btDeadliness := 0;
  m_boDeath := False;
  m_dwDeathTick := 0;
  m_nGloryPoint := 0;
  m_SendRefMsgTick := GetTickCount();
  m_btDirection := 4;
  m_btRaceServer := RC_ANIMAL;
  m_btRaceImg := 0;
  m_btHair := 0;
  m_btJob := 0;
  m_nGold := 0;
  m_wAppr := 0;
  bo2B9 := True;
  m_nViewRange := 5;
  m_sHomeMap := '0';
  //bo94 := False;
  m_btPermission := 0;
  //m_nLight := 0;
  m_btNameColor := 255;
  m_nHitPlus := 0;
  m_nHitDouble := 0;
  m_dBodyLuck := 0;
  m_wGroupRcallTime := 0;
  m_wGuildRcallTime := 0;
  //m_nItemKickMonExp := 0;
  //m_dwItemWuXinExpRate := 0;
  m_dwGroupRcallTick := GetTickCount();
  m_boRecallSuite := False;
  m_boMapApoise := True;
  //bo245 := False;
  m_boTestGa := False;
  m_boGsa := False;
  bo2BA := False;
  // fixme 默认血量可见，不需要心灵启示技能
  m_boAbilSeeHealGauge := True;
  m_boPowerHit := False;
  //m_boUseThrusting := False;
  //m_boUseHalfMoon := False;
  //m_boFireHitSkill := False;
  m_btHitPoint := 5;
  m_btSpeedPoint := 15;
  m_btAddAttack := 0;
  m_btDelDamage := 0;
  m_btAddWuXinAttack := 0;
  m_btDelWuXinAttack := 0;
  m_nHitSpeed := 0;
  //m_nHitDunt := 0;
  m_btLifeAttrib := 0;
  m_btAntiPoison := 0;
  m_nPoisonRecover := 0;
  m_nHealthRecover := 0;
  m_nSpellRecover := 0;
  m_nAntiMagic := 0;
  m_nLuck := 0;
  m_nIncSpell := 0;
  m_nIncHealth := 0;
  m_nIncHealing := 0;
  m_nIncHPStoneTime := GetTickCount;
  m_nIncMPStoneTime := GetTickCount;
  m_nPerHealth := 5;
  m_nPerHealing := 5;
  m_nPerSpell := 5;
  m_dwIncHealthSpellTick := GetTickCount();
  m_btGreenPoisoningPoint := 0;
  m_nFightZoneDieCount := 0;
  m_nMaxItemListCount := MAXBAGITEMS;
  //  m_nGoldMax       := 5000000;
  m_nGoldMax := g_Config.nHumanMaxGold;
  m_nCharStatus := 0;
  m_nCharStatusEx := 0;
  SafeFillChar(m_wStatusTimeArr, SizeOf(TStatusTime), #0); //004B7A83

  SafeFillChar(m_NakedAddAbil, SizeOf(m_NakedAddAbil), #0);
  SafeFillChar(m_TempAddAbil, SizeOf(m_TempAddAbil), #0);
  //SafeFillChar(m_BonusAbil, SizeOf(TNakedAbility), #0);
  //SafeFillChar(m_CurBonusAbil, SizeOf(TNakedAbility), #0);

  SafeFillChar(m_wStatusArrValue, SizeOf(m_wStatusArrValue), 0);
  SafeFillChar(m_dwStatusArrTimeOutTick, SizeOf(m_dwStatusArrTimeOutTick), #0);
  //SafeFillChar(m_Magic, SizeOf(m_Magic), #0);

  m_boCheckGroup := False;
  m_boAllowGroup := False;
  m_boAllowGuild := False;
  //btB2 := 0;
  m_btAttatckMode := 0;
  m_boInFreePKArea := False;
  m_boGuildWarArea := False;
  bo2B0 := False;
  m_boSuperMan := False;
  m_boSkeleton := False;
  bo2BF := False;
  m_boHolySeize := False;
  m_boCrazyMode := False;
  m_boShowHP := False;
  bo2F0 := False;
  m_boAnimal := False;
  m_boNoItem := False;
  m_nBodyLeathery := 50;
  m_boFixedHideMode := False;
  m_boStickMode := False;
  m_boNoAttackMode := False;
  //bo2C1 := False;
  m_boPKFlag := False;
  m_nMoXieSuite := 0;
  m_nHongMoSuite := 0;
  m_db3B0 := 0;
  SafeFillChar(m_AddAbil, SizeOf(m_AddAbil), #0);
  //SafeFillChar(m_DBAbil, SizeOf(m_DBAbil), #0);

  m_MsgList := TList.Create;
  m_VisibleHumanList := TList.Create;
  //LIst_3EC := TList.Create;
  m_VisibleActors := TList.Create;
  m_VisibleItems := TList.Create;
  m_VisibleEvents := TList.Create;
  m_ItemList := TList.Create;
  m_CanDropItemList := nil;

  m_boIsVisibleActive := False;
  m_nVisibleActiveCount := 0;
  m_nProcessRunCount := 0;

  SafeFillChar(m_UseItems, SizeOf(THumanUseItems), 0);
  //m_MagicOneSwordSkill := nil;
 { //m_MagicPowerHitSkill := nil;
  //m_MagicErgumSkill := nil;
  m_MagicBanwolSkill := nil;
  m_MagicFireSwordSkill := nil;
  m_MagicCrsSkill := nil;
  m_Magic41Skill := nil;
  m_Magic42Skill := nil;
  m_Magic43Skill := nil;   }
  m_GroupOwner := nil;
  m_Castle := nil;
  m_Master := nil;
  //m_AllMaster := nil;
  m_nKillMonCount := 0;
  m_btSlaveExpLevel := 0;
  //bt2A0 := 0;
  m_GroupMembers := TStringList.Create;
  m_boHearWhisper := True;
  m_boBanShout := True;
  m_boBanGuildChat := True;
  m_boAllowDeal := True;
  m_boAllowGroupReCall := False;
  m_BlockWhisperList := TStringList.Create;
  m_SlaveList := TList.Create;
  SafeFillChar(m_WAbil, SizeOf(TAbility), #0);
  //SafeFillChar(m_QuestUnitOpen, SizeOf(TQuestUnit), #0);
  //SafeFillChar(m_QuestUnit, SizeOf(TQuestUnit), #0);
  m_Abil.Level := 1;
  m_Abil.AC := 0;
  m_Abil.MAC := 0;
  m_Abil.DC := MakeLong(1, 4);
  m_Abil.MC := MakeLong(1, 2);
  m_Abil.SC := MakeLong(1, 2);
  m_Abil.HP := 15;
  m_Abil.MP := 15;
  m_Abil.MaxHP := 15;
  m_Abil.MaxMP := 15;
  m_Abil.Exp := 0;
  m_Abil.MaxExp := 50;
  m_Abil.Weight := 0;
  m_Abil.MaxWeight := 100;
  m_boWantRefMsg := False;

  m_MyGuild := nil;
  m_nGuildRankNo := 0;
  m_sGuildRankName := '';
  m_sScriptLable := '';
  m_boMission := False;
  m_boHideMode := False;
  m_boStoneMode := False;
  m_boCoolEye := False;
  m_boUserUnLockDurg := False;
  m_boTransparent := False;
  m_boAdminMode := False;
  m_boObMode := False;
  m_dwRunTick := GetTickCount + LongWord(Random(1500));
  m_nRunTime := 250;
  m_dwSearchTime := Random(2000) + 2000;
  m_dwSearchTick := GetTickCount;
  m_dwDecPkPointTick := GetTickCount;
  m_DecLightItemDrugTick := GetTickCount();
  m_dwPoisoningTick := GetTickCount;
  m_dwVerifyTick := GetTickCount();
  m_dwCheckRoyaltyTick := GetTickCount();
  m_dwDecHungerPointTick := GetTickCount();
  m_dwHPMPTick := GetTickCount();
  m_dwShoutMsgTick := 0;
  m_dwTeleportTick := 0;
  m_dwProbeTick := 0;
  m_dwMapMoveTick := GetTickCount();
  m_dwMasterTick := 0;
  m_nWalkSpeed := 1400;
  m_nNextHitTime := 2000;
  m_nWalkCount := 0;
  m_dwWalkWaitTick := GetTickCount();
  m_boWalkWaitLocked := False;
  m_nHealthTick := 0;
  m_nSpellTick := 0;
  m_TargetCret := nil;
  m_LastHiter := nil;
  m_ExpHitter := nil;
  m_SayMsgList := nil;
  //m_boDenyRefStatus := False;
  m_btHorseType := 0;
  m_btDressEffType := 0;
  m_dwPKDieLostExp := 0;
  m_nPKDieLostLevel := 0;
  m_boAddToMaped := True;
  m_boAutoChangeColor := False;
  m_dwAutoChangeColorTick := GetTickCount();
  m_nAutoChangeIdx := 0;

  m_boFixColor := False;
  m_nFixColorIdx := 0;
  m_nFixStatus := -1;
  m_boFastParalysis := False;
  m_nFastParalysis := 0;

  m_boAC := True;
  m_boMAC := True;
  m_boDC := True;
  m_boMC := True;
  m_boSC := True;
  m_boHitSpeed := True;
  m_boMaxHP := True;
  m_boMaxMP := True;
  //m_nCopyHumanLevel := 0; //复制人状态
  m_dwSayMyInfoTick := GetTickCount;
  m_dwStationTick := GetTickCount; //站的时间

  m_boReliveNoDrop := False;
 end;

destructor TBaseObject.Destroy;
var
  i: Integer;
  SendMessage: pTSendMessage;
  nCheckCode: Integer;
  VisibleBaseObject: pTVisibleBaseObject;
resourcestring
  sExceptionMsg = '[Exception] TBaseObject::Destroy Code: %d';
begin
  nCheckCode := 0;
  try
    nCheckCode := 1;
    if m_MsgList <> nil then begin
      if m_MsgList.Count > 0 then begin
        for i := 0 to m_MsgList.Count - 1 do begin
          nCheckCode := 2;
          SendMessage := m_MsgList.Items[i];
          if (SendMessage.wIdent = RM_SENDDELITEMLIST) and (SendMessage.nParam1 <> 0) then begin
            nCheckCode := 3;
            if TStringList(SendMessage.nParam1) <> nil then begin
              TStringList(SendMessage.nParam1).Free;
              nCheckCode := 4;
            end;
          end else
          if (SendMessage.wIdent = RM_MAKEPOISON) and (SendMessage.nParam2 <> 0) then begin
            nCheckCode := 3;
            if pTMakePoisonInfo(SendMessage.nParam2) <> nil then begin
              Dispose(pTMakePoisonInfo(SendMessage.nParam2));
              nCheckCode := 4;
            end;
          end;
          nCheckCode := 6;
          if (SendMessage.Buff <> nil) then begin
            nCheckCode := 7;
            FreeMem(SendMessage.Buff);
          end;
          DisPose(SendMessage);
          nCheckCode := 8;
        end;
      end;
      nCheckCode := 9;
      FreeAndNil(m_MsgList);
    end;

    nCheckCode := 10;
    if m_VisibleHumanList <> nil then
      FreeAndNil(m_VisibleHumanList);
    nCheckCode := 11;
    {for i := 0 to LIst_3EC.Count - 1 do begin

    end;
    FreeAndNil(LIst_3EC);   }
    nCheckCode := 12;
    if m_VisibleActors <> nil then begin
      if m_VisibleActors.Count > 0 then begin
        //MainOutMessage('[Exception] TBaseObject::Destroy VisibleActors = ' + IntToStr(m_VisibleActors.Count));
        for i := 0 to m_VisibleActors.Count - 1 do begin
          VisibleBaseObject := pTVisibleBaseObject(m_VisibleActors.Items[i]);
          if VisibleBaseObject <> nil then begin
            if (VisibleBaseObject.BaseObject <> nil) and (VisibleBaseObject.boAddCount) then
              Dec(TBaseObject(VisibleBaseObject.BaseObject).m_nVisibleActiveCount);
            DisPose(VisibleBaseObject);
          end;
        end;
      end;
      nCheckCode := 13;
      FreeAndNil(m_VisibleActors);
    end;
    nCheckCode := 14;
    if m_VisibleItems <> nil then begin
      if m_VisibleItems.Count > 0 then begin
        for i := 0 to m_VisibleItems.Count - 1 do begin
          if pTVisibleMapItem(m_VisibleItems.Items[i]) <> nil then
            DisPose(pTVisibleMapItem(m_VisibleItems.Items[i]));
        end;
      end;
      nCheckCode := 15;
      FreeAndNil(m_VisibleItems);
    end;
    nCheckCode := 16;
    if m_VisibleEvents <> nil then
      FreeAndNil(m_VisibleEvents);
    nCheckCode := 17;
    if m_ItemList <> nil then begin
      if m_ItemList.Count > 0 then begin
        for i := 0 to m_ItemList.Count - 1 do begin
          if pTUserItem(m_ItemList.Items[i]) <> nil then
            DisPose(pTUserItem(m_ItemList.Items[i]));
        end;
      end;
      nCheckCode := 18;
      FreeAndNil(m_ItemList);
    end;
    if m_GroupMembers <> nil then
      FreeAndNil(m_GroupMembers);
    nCheckCode := 23;
    if m_BlockWhisperList <> nil then
      FreeAndNil(m_BlockWhisperList);
    nCheckCode := 24;
    if m_SlaveList <> nil then
      FreeAndNil(m_SlaveList);
    nCheckCode := 25;
    m_TempItemList.Free;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg, [nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
  {
  for I := 0 to CertCheck.Count - 1 do begin
    if CertCheck.Items[I] = Self then begin
      CertCheck.Delete(I);
      break;
    end;
  end;
  }
  inherited;
end;

//照名物减持久
(*
procedure TBaseObject.UseLamp;
var
  nOldDura: Integer;
  nDura: Integer;
  PlayObject: TPlayObject;
  StdItem: pTStdItem;
resourcestring
  sExceptionMsg = '[Exception] TBaseObject::UseLamp';
begin
  try
    if m_UseItems[U_RIGHTHAND].wIndex > 0 then begin
      StdItem := UserEngine.GetStdItem(m_UseItems[U_RIGHTHAND].wIndex);
      if (StdItem = nil) or (StdItem.Source <> 0) then
        Exit;

      nOldDura := ROUND(m_UseItems[U_RIGHTHAND].Dura / 1000);
      if g_Config.boDecLampDura then begin
        nDura := m_UseItems[U_RIGHTHAND].Dura - 1;
      end
      else begin
        nDura := m_UseItems[U_RIGHTHAND].Dura;
      end;
      if nDura <= 0 then begin
        m_UseItems[U_RIGHTHAND].Dura := 0;
        if m_btRaceServer = RC_PLAYOBJECT then begin
          PlayObject := TPlayObject(Self);
          PlayObject.SendDelItems(@m_UseItems[U_RIGHTHAND]);
        end;
        m_UseItems[U_RIGHTHAND].wIndex := 0;
        //m_nLight := 0;
        //SendRefMsg(RM_CHANGELIGHT, 0, 0, 0, 0, '');
        SendMsg(Self, RM_LAMPCHANGEDURA, 0, m_UseItems[U_RIGHTHAND].Dura, 0, 0,
          '');
        RecalcAbilitys();
        //        FeatureChanged(); 01/21 取消 蜡烛是本人才可以看到的，不需要发送广播信息
      end
      else
        m_UseItems[U_RIGHTHAND].Dura := nDura;
      if nOldDura <> ROUND(nDura / 1000) then begin
        SendMsg(Self, RM_LAMPCHANGEDURA, 0, m_UseItems[U_RIGHTHAND].Dura, 0, 0,
          '');
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;    *)

function TBaseObject.GetPoseCreate: TBaseObject;
var
  nX, nY: Integer;
begin
  Result := nil;
  if GetFrontPosition(nX, nY) then begin
    Result := m_PEnvir.GetMovingObject(nX, nY, True);
  end;
end;

function TBaseObject.GetAttackDir(BaseObject: TBaseObject; var btDir: Byte):
  Boolean;
begin
  Result := False;
  if (m_nCurrX - 1 <= BaseObject.m_nCurrX) and
    (m_nCurrX + 1 >= BaseObject.m_nCurrX) and
    (m_nCurrY - 1 <= BaseObject.m_nCurrY) and
    (m_nCurrY + 1 >= BaseObject.m_nCurrY) and
    ((m_nCurrX <> BaseObject.m_nCurrX) or
    (m_nCurrY <> BaseObject.m_nCurrY)) then begin
    Result := True;
    if ((m_nCurrX - 1) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
      btDir := DR_LEFT;
      Exit;
    end;
    if ((m_nCurrX + 1) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
      btDir := DR_RIGHT;
      Exit;
    end;
    if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY - 1) = BaseObject.m_nCurrY) then begin
      btDir := DR_UP;
      Exit;
    end;
    if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY + 1) = BaseObject.m_nCurrY) then begin
      btDir := DR_DOWN;
      Exit;
    end;
    if ((m_nCurrX - 1) = BaseObject.m_nCurrX) and ((m_nCurrY - 1) = BaseObject.m_nCurrY) then begin
      btDir := DR_UPLEFT;
      Exit;
    end;
    if ((m_nCurrX + 1) = BaseObject.m_nCurrX) and ((m_nCurrY - 1) = BaseObject.m_nCurrY) then begin
      btDir := DR_UPRIGHT;
      Exit;
    end;
    if ((m_nCurrX - 1) = BaseObject.m_nCurrX) and ((m_nCurrY + 1) = BaseObject.m_nCurrY) then begin
      btDir := DR_DOWNLEFT;
      Exit;
    end;
    if ((m_nCurrX + 1) = BaseObject.m_nCurrX) and ((m_nCurrY + 1) = BaseObject.m_nCurrY) then begin
      btDir := DR_DOWNRIGHT;
      Exit;
    end;
    btDir := 0;
  end;
end;

function TBaseObject.TargetInSpitRange(BaseObject: TBaseObject; var btDir:
  Byte): Boolean; //004C3E68
var
  n14, n18: Integer;
begin
  Result := False;
  if (abs(BaseObject.m_nCurrX - m_nCurrX) <= 2) and (abs(BaseObject.m_nCurrY -
    m_nCurrY) <= 2) then begin
    n14 := BaseObject.m_nCurrX - m_nCurrX;
    n18 := BaseObject.m_nCurrY - m_nCurrY;
    if (abs(n14) <= 1) and (abs(n18) <= 1) then begin
      GetAttackDir(BaseObject, btDir);
      Result := True;
      Exit;
    end;
    Inc(n14, 2);
    Inc(n18, 2);
    if ((n14 >= 0) and (n14 <= 4)) and ((n18 >= 0) and (n18 <= 4)) then begin
      btDir := GetNextDirection(m_nCurrX, m_nCurrY, BaseObject.m_nCurrX,
        BaseObject.m_nCurrY);
      if g_Config.SpitMap[btDir, n18, n14] = 1 then
        Result := True;
    end;
  end;
end;

function TBaseObject.AddToMap(): Boolean;
var
  Point: Pointer;
begin
  //  Result := False;
  Point := m_PEnvir.AddToMap(m_nCurrX, m_nCurrY, OS_MOVINGOBJECT, Self);
  if Point <> nil then
    Result := True
  else
    Result := False;
  if not m_boFixedHideMode then
    SendRefMsg(RM_TURN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;

procedure TBaseObject.AttackDir(TargeTBaseObject: TBaseObject; wHitMode: Word; nDir: Integer);
var
  AttackTarget: TBaseObject;
  nCheckCode: Integer;
resourcestring
  sExceptionMsg = '[Exception] TBaseObject::AttackDir Code: %d';
begin
  nCheckCode := 0;
  try
    nCheckCode := 1;
    m_btDirection := nDir;
    if TargeTBaseObject = nil then begin
      nCheckCode := 2;
      AttackTarget := GetPoseCreate();
    end
    else
      AttackTarget := TargeTBaseObject;
    nCheckCode := 5;
    if _Attack(wHitMode, AttackTarget) then begin
      nCheckCode := 6;
      SetTargetCreat(AttackTarget);
      nCheckCode := 7;
    end;
    nCheckCode := 8;
    SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
    nCheckCode := 9;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg, [nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TBaseObject.CheckPKStatus;
begin
  if m_boPKFlag and ((GetTickCount - m_dwPKTick) > g_Config.dwPKFlagTime{60 * 1000}) then begin
    m_boPKFlag := False;
    RefNameColor();
  end;
end;

procedure TBaseObject.DamageSpell(nSpellPoint: Integer);
begin
  if nSpellPoint > 0 then begin
    if (m_WAbil.MP - nSpellPoint) > 0 then
      Dec(m_WAbil.MP, nSpellPoint)
    else
      m_WAbil.MP := 0;
  end
  else begin
    if (m_WAbil.MP - nSpellPoint) < m_WAbil.MaxMP then
      Dec(m_WAbil.MP, nSpellPoint)
    else
      m_WAbil.MP := m_WAbil.MaxMP;
  end;
end;

procedure TBaseObject.DecPKPoint(nPoint: Integer);
var
  nC: Integer;
begin
  nC := PKLevel();
  WordChange(m_nPkPoint, nPoint, INT_DEL);
  if (PKLevel <> nC) and (nC > 0) and (nC <= 2) then begin
    RefNameColor();
  end;
  if m_btRaceServer = RC_PLAYOBJECT then begin
    TPlayobject(self).DiamondChanged;
  end;
end;

//删除组成

procedure TBaseObject.DelMember(BaseObject: TBaseObject);
var
  i: Integer;
  PlayObject: TPlayObject;
  GroupOwner: TPlayObject;
begin
  if m_GroupOwner <> BaseObject then begin
    for i := m_GroupMembers.Count - 1 downto 0 do begin
      if m_GroupMembers.Count <= 0 then break;
      if (m_GroupMembers.Objects[i] <> nil) and (m_GroupMembers.Objects[i] = BaseObject) then begin
        BaseObject.LeaveGroup();
        m_GroupMembers.Delete(i);
        break;
      end;
    end;
    PlayObject := TPlayObject(Self);
    PlayObject.RefGroupWuXin(nil);
    if not PlayObject.CancelGroup then begin
      PlayObject.SendDefMsg(Self, SM_GROUPCANCEL, 1, 0, 0, 0, '');
    end;
    {else
      PlayObject.SendGroupMembers(nil);}
  end
  else begin
    if m_GroupMembers.Count > 0 then begin
      GroupOwner := TPlayObject(m_GroupMembers.Objects[0]);
      GroupOwner.LeaveGroup();
      m_GroupMembers.Delete(0);
      m_GroupOwner := nil;
      GroupOwner.RefGroupWuXin(Self);
    end;
    if m_GroupMembers.Count > 0 then begin
      GroupOwner := TPlayObject(m_GroupMembers.Objects[0]);
      GroupOwner.m_GroupMembers.Assign(m_GroupMembers);
      GroupOwner.m_GroupClass := m_GroupClass;
      m_GroupMembers.Clear;
      for i := 0 to GroupOwner.m_GroupMembers.Count - 1 do begin
        PlayObject := TPlayObject(GroupOwner.m_GroupMembers.Objects[i]);
        if PlayObject <> nil then begin
          PlayObject.ChangeGroup(GroupOwner);
        end;
      end;
      if not GroupOwner.CancelGroup then begin
        GroupOwner.SendDefMsg(GroupOwner, SM_GROUPCANCEL, 1, 0, 0, 0, '');
      end;
      if BaseObject.m_boGhost and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        PlayObject := TPlayObject(BaseObject);
        if (PlayObject.m_FBEnvir <> nil) and (PlayObject.m_FBEnvir.m_boFBCreate) and
          (PlayObject.m_FBEnvir.m_MasterObject = PlayObject) then
        begin
          GroupOwner.m_FBEnvir := PlayObject.m_FBEnvir;
          GroupOwner.m_FBEnvir.m_MasterObject := GroupOwner;
        end;
      end;
      GroupOwner.RefGroupWuXin(nil);
    end;
  end;
end;
{
procedure TBaseObject.SetUserMagic(MagID: integer; UserMagic: pTUserMagic);
begin
  if (MagID > 0) and (MagID < High(FMagic)) then
    FMagic[MagID] := UserMagic;
end;

function TBaseObject.GetUserMagic(MagID: integer): pTUserMagic;
begin
  if (MagID > 0) and (MagID < High(FMagic)) then
    Result := FMagic[MagID]
  else
    Result := nil;
end;   }

procedure TBaseObject.MagicQuest(TagreBase: TBaseObject; nMagID: Integer; State: TMagicFunState);
var magId : Integer;
begin
  if (m_btRaceServer <> RC_PLAYOBJECT) or (g_FunctionNPC = nil) then Exit;
  if (nMagID > 0) and (nMagID < SKILL_MAX) then begin
    magId :=  nMagID mod 1000;
    if TagreBase <> nil then
      TPlayObject(Self).m_sString[0] := TagreBase.m_sCharName;
    case State of
      mfs_Self: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FMagSelfFunc[magId], False);
      mfs_Tag: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FMagTagFunc[magId], False);
      mfs_TagEx: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FMagTagFuncEx[magId], False);
      mfs_Mon: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FMagMonFunc[magId], False);
    end;
  end;
end;

procedure TBaseObject.NpcGotoLable(NormNpc: TBaseObject; nLabel: Integer; boMaster: Boolean; sLabel: string = '');
var
  PlayObject: TPlayObject;
begin
  if (NormNpc <> nil) and (nLabel > -1) then begin
    PlayObject := nil;
    if m_btRaceServer = RC_PLAYOBJECT then begin
      PlayObject := TPlayObject(Self);
    end
    else begin
      if (boMaster) and (m_Master <> nil) and (m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
        PlayObject := TPlayObject(m_Master);
      end;
    end;
    if PlayObject <> nil then begin
      PlayObject.m_nScriptGotoCount := 0;
      PlayObject.m_ClickHideNPC := NormNpc;
      TNormNpc(NormNpc).GotoLable(PlayObject, nLabel, False, sLabel);
    end;
  end;
end;

procedure TBaseObject.DoDamageWeapon(nWeaponDamage: Integer);
var
  nDura, nDuraPoint: Integer;
  PlayObject: TPlayObject;
  StdItem: pTStdItem;
begin
  if m_UseItems[U_WEAPON].wIndex <= 0 then Exit;
  nDura := m_UseItems[U_WEAPON].Dura;
  nDuraPoint := ROUND(nDura / 1000);
  Dec(nDura, nWeaponDamage);
  if nDura <= 0 then begin
    nDura := 0;
    m_UseItems[U_WEAPON].Dura := nDura;
    if m_btRaceServer = RC_PLAYOBJECT then begin
      PlayObject := TPlayObject(Self);
      PlayObject.SendDelItems(@m_UseItems[U_WEAPON]);
      StdItem := UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
      if (StdItem <> Nil) and (StdItem.NeedIdentify = 1) then
        AddGameLog(Self, LOG_DELITEM, StdItem.Name, m_UseItems[U_WEAPON].MakeIndex, 0, '0', '0', '0', '持久', @m_UseItems[U_WEAPON]);
    end;
    m_UseItems[U_WEAPON].wIndex := 0;
  end
  else begin //004C199D
    m_UseItems[U_WEAPON].Dura := nDura;
    if Round(nDura / 1000) <> nDuraPoint then begin
      DuraChange(U_WEAPON, m_UseItems[U_WEAPON].Dura, m_UseItems[U_WEAPON].DuraMax);
    end;
  end;

end;

procedure TBaseObject.GetAccessory(Item: pTUserItem; var AddAbility: TAddAbility);
var
  StdItem: pTStdItem;
  StdItemA: TStdItem;
begin
  StdItem := UserEngine.GetStdItem(Item.wIndex);
  if (StdItem = nil) or (Stditem.StdMode = tm_House) then Exit;
  StdItemA := StdItem^;
  if not ItemUnit.GetItemAddValue(m_btWuXin, Item, StdItemA) then exit;

  AddAbility.AC := _MIN(High(Integer), AddAbility.AC + StdItemA.nAC);
  AddAbility.AC2 := _MIN(High(Integer), AddAbility.AC2 + StdItemA.nAC2);
  AddAbility.MAC := _MIN(High(Integer), AddAbility.MAC + StdItemA.nMAC);
  AddAbility.MAC2 := _MIN(High(Integer), AddAbility.MAC2 + StdItemA.nMAC2);
  AddAbility.DC := _MIN(High(Integer), AddAbility.DC + StdItemA.nDC);
  AddAbility.DC2 := _MIN(High(Integer), AddAbility.DC2 + StdItemA.nDC2);
  AddAbility.MC := _MIN(High(Integer), AddAbility.MC + StdItemA.nMC);
  AddAbility.MC2 := _MIN(High(Integer), AddAbility.MC2 + StdItemA.nMC2);
  AddAbility.SC := _MIN(High(Integer), AddAbility.SC + StdItemA.nSC);
  AddAbility.SC2 := _MIN(High(Integer), AddAbility.SC2 + StdItemA.nSC2);
  AddAbility.HP := _MIN(High(Integer), AddAbility.HP + StdItemA.HP);
  AddAbility.MP := _MIN(High(Integer), AddAbility.MP + StdItemA.MP);

  Inc(AddAbility.wAddAttack, StdItemA.AddAttack); //准确
  Inc(AddAbility.wDelDamage, StdItemA.DelDamage); //准确
  Inc(AddAbility.btDeadliness, StdItemA.Deadliness); //致命一击
  //if Item.Value.btWuXin > 0 then begin
  if not g_Config.boCloseWuXin then begin
    Inc(AddAbility.wAddWuXinAttack, StdItemA.AddWuXinAttack); //准确
    Inc(AddAbility.wDelWuXinAttack, StdItemA.DelWuXinAttack); //准确
  end;
  //end;

  Inc(AddAbility.btExpRate, StdItemA.ExpRate);
  Inc(AddAbility.btHPorMPRate, StdItemA.HPorMPRate);
  Inc(AddAbility.btAC2Rate, StdItemA.AC2Rate);
  Inc(AddAbility.btMAC2Rate, StdItemA.MAC2Rate);

  Inc(AddAbility.wHitPoint, StdItemA.HitPoint); //准确
  Inc(AddAbility.wSpeedPoint, StdItemA.SpeedPoint); //准确
  Inc(AddAbility.wAntiMagic, StdItemA.AntiMagic);
  Inc(AddAbility.wAntiPoison, StdItemA.PoisonMagic);
  Inc(AddAbility.wHealthRecover, StdItemA.HealthRecover);
  Inc(AddAbility.wSpellRecover, StdItemA.SpellRecover);
  Inc(AddAbility.wPoisonRecover, StdItemA.PoisonRecover);
  if StdItemA.StdMode = tm_Weapon then begin
    Inc(AddAbility.btWeaponStrong, StdItemA.Strong);
  end;

  Inc(AddAbility.btLuck, StdItemA.Luck); //幸运

  {if StdItemA.HitSpeed > 10 then begin //攻击速度
    Inc(AddAbility.nHitSpeed, StdItemA.HitSpeed - 10);
  end
  else begin
    Dec(AddAbility.nHitSpeed, StdItemA.HitSpeed);
  end;   }

  {//装备五行属性
  if CheckWuXinConsistent(m_btWuXin, Item.Value.btValue[tb_wuxin]) then begin
    AddAbility.AC2 := _MIN(High(Word), Round(AddAbility.AC2 * (m_btWuXinLevel / 100 + 1)));
    AddAbility.MAC2 := _MIN(High(Word), Round(AddAbility.MAC2 * (m_btWuXinLevel / 100 + 1)));
  end else
  if CheckWuXinRestraint(m_btWuXin, Item.Value.btValue[tb_wuxin]) then begin
    case m_btJob of
      0: AddAbility.DC2 := _MIN(High(Word), Round(AddAbility.DC2 * (m_btWuXinLevel / 100 + 1)));
      1: AddAbility.MC2 := _MIN(High(Word), Round(AddAbility.MC2 * (m_btWuXinLevel / 100 + 1)));
      2: AddAbility.SC2 := _MIN(High(Word), Round(AddAbility.SC2 * (m_btWuXinLevel / 100 + 1)));
    end;
  end;  }
end;

function TBaseObject.GetCharColor(BaseObject: TBaseObject): Byte;
var
  n10: Integer;
  Castle: TUserCastle;
begin
  Result := BaseObject.GetNamecolor();
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin

    //是否在城堡附近
    Castle := g_CastleManager.InCastleWarArea(BaseObject);
    if (Castle <> nil) and Castle.m_boUnderWar and m_boInFreePKArea and BaseObject.m_boInFreePKArea then begin
      Result := g_Config.btInFreePKAreaNameColor; //$DD;  //攻城区域
      m_boGuildWarArea := True;
      if (m_MyGuild = nil) or (BaseObject.m_MyGuild = nil) then Exit;
      if Castle.IsMasterGuild(TGuild(m_MyGuild)) then begin
        if (m_MyGuild = BaseObject.m_MyGuild) or (TGuild(m_MyGuild).IsAllyGuild(TGuild(BaseObject.m_MyGuild)))
        then begin
          Result := g_Config.btAllyAndGuildNameColor //$B4; //联盟行会
        end
        else begin //004BF2A8
          if Castle.IsAttackGuild(TGuild(BaseObject.m_MyGuild)) then begin
            Result := g_Config.btWarGuildNameColor //$45;    //敌对行会
          end;
        end;
      end else
      if Castle.IsAttackGuild(TGuild(m_MyGuild)) then begin
        if (m_MyGuild = BaseObject.m_MyGuild) or (TGuild(m_MyGuild).IsAllyGuild(TGuild(BaseObject.m_MyGuild)))
        then begin
          Result := g_Config.btAllyAndGuildNameColor //$B4;  //联盟行会
        end
        else begin
          if Castle.IsMember(BaseObject) then begin
            Result := g_Config.btWarGuildNameColor //$45;   //敌对行会
          end;
        end;
      end;
    end else begin
      if BaseObject.PKLevel < 2 then begin
        if BaseObject.m_boPKFlag then
          Result := g_Config.btPKFlagNameColor; //$2F
        n10 := GetGuildRelation(Self, BaseObject);
        case n10 of
          1, 3: Result := g_Config.btAllyAndGuildNameColor; //$B4;
          2: Result := g_Config.btWarGuildNameColor; //$45;
        end;
        if BaseObject.m_PEnvir.m_boFight3Zone then begin
          if m_MyGuild = BaseObject.m_MyGuild then
            Result := g_Config.btAllyAndGuildNameColor //$B4
          else
            Result := g_Config.btWarGuildNameColor //$45;
        end;
      end; //004BF218
    end;
  end else
  if BaseObject.m_btRaceServer = RC_CAMION then begin

  end else
  if BaseObject.m_btRaceServer = RC_NPC then begin

  end else begin
    if (Result = 255) and (BaseObject.m_btSlaveExpLevel < SLAVEMAXLEVEL) then begin
      Result := g_Config.SlaveColor[BaseObject.m_btSlaveExpLevel];
    end;
    if BaseObject.m_boCrazyMode then
      Result := $F9;
    if BaseObject.m_boHolySeize then
      Result := $7D;
  end;
end;

//身上装备持久改变

procedure TBaseObject.DuraChange(idx, Dura, DuraMax: Integer);
begin
  if (m_btRaceServer = RC_PLAYOBJECT) then begin
    SendDefMsg(Self, SM_DURACHANGE, 0, Dura, DuraMax, Idx, '');
  end;
end;
 {
function TBaseObject.GetWuXinLevelExp(nLevel: Integer): LongWord;
begin
  if (nLevel > 0) and (nLevel <= MAXWUXINLEVEL) then begin
    Result := g_Config.dwWuxinNeedExps[nLevel];
    Exit;
  end;
  Result := g_Config.dwWuxinNeedExps[MAXWUXINLEVEL];
end;    }

procedure TBaseObject.ChangeStatusMode(nStatus: Integer; boMode: Boolean);
begin
  //
end;

function TBaseObject.CanWork: Boolean;
begin
  Result := False;
  if (m_wStatusTimeArr[POISON_STONE] = 0) and (m_wStatusTimeArr[POISON_COBWEB] = 0) then
    Result := True;
end;

function TBaseObject.GetLevelExp(nLevel: Integer): LongWord;
  function GetBaseExp(): LongWord;
  var
    nInt64: Int64;
  begin
    nInt64 := (nLevel - 1000) * g_Config.nAddExp + g_Config.nBaseExp;
    if nInt64 > High(LongWord) then
      Result := High(LongWord)
    else
      Result := nInt64;
  end;
begin
  if (nLevel > 0) and (nLevel <= MAXCHANGELEVEL) then begin
    Result := g_Config.dwNeedExps[nLevel];
    Exit;
  end;
  if g_Config.boUseFixExp then begin
    if nLevel <= MAXLEVEL then begin
      Result := 2000000000 + nLevel * 1500;
    end
    else begin
      Result := High(LongWord); //g_Config.dwNeedExps[High(g_Config.dwNeedExps)];
    end;
  end
  else begin
    if nLevel <= MAXLEVEL then begin
      Result := GetBaseExp();
    end
    else begin
      Result := High(LongWord);
    end;
  end;
end;

function TBaseObject.GetNamecolor(): Byte;
begin
  Result := m_btNameColor;
  if PKLevel = 1 then
    Result := g_Config.btPKLevel1NameColor; //$FB;
  if PKLevel >= 2 then
    Result := g_Config.btPKLevel2NameColor; //$F9;
end;

procedure TBaseObject.HearMsg(sMsg: string);
begin
  if sMsg <> '' then
    SendMsg(nil, RM_HEAR, 0, g_Config.nHearMsgFColor, g_Config.nHearMsgBColor, 0, sMsg);
end;

{function TBaseObject.InSafeArea(): Boolean;
var
  i: Integer;
  SC: string;
  nStartX,nStartY:Integer;
  nEndX,nEndY:Integer;
  StartPoint: pTStartPoint;
begin
  Result := m_PEnvir.m_boSAFE;
  if Result then Exit;
  try
    g_StartPointList.Lock;
    for i := 0 to g_StartPointList.Count - 1 do begin
      SC := g_StartPointList.Strings[i];
      if SC = m_PEnvir.sMapName then begin
        StartPoint := pTStartPoint(g_StartPointList.Objects[i]);
        if StartPoint <> nil then begin
          nStartX:=StartPoint.m_nCurrX - StartPoint.m_nRange;
          nEndX:=StartPoint.m_nCurrX + StartPoint.m_nRange;
          nStartY:=StartPoint.m_nCurrY - StartPoint.m_nRange;
          nEndY:=StartPoint.m_nCurrY - StartPoint.m_nRange;
          if (m_nCurrX in [nStartX..nEndX]) and (m_nCurrY in [nStartY..nEndY]) then begin
            Result := True;
            break;
          end;
        end;
      end;
    end;
  finally
    g_StartPointList.UnLock;
  end;
end; }

function TBaseObject.InSafeArea(): Boolean;
{var
  i: Integer;
  SC: string;
  n14, n18: Integer;
  StartPoint: pTStartPoint; }
var
  MapStartPoint: pTMapStartPoint;
  i: Integer;
begin
  Result := m_PEnvir.m_boSAFE or (m_btStartType = OT_SAFEAREA);
  if not Result then begin
    for i := 0 to m_PEnvir.m_StartPointList.Count - 1 do begin
      MapStartPoint := m_PEnvir.m_StartPointList.Items[i];
      if (abs(m_nCurrX - MapStartPoint.nSafeX) <= 60) and
        (abs(m_nCurrY - MapStartPoint.nSafeY) <= 60) then begin
        Result := True;
        break;
      end;
    end;
  end;
end;

function TBaseObject.IsMonster: Boolean;
begin
  Result := (m_btRaceServer >= RC_ANIMAL) and (m_btRaceServer <> RC_ARCHERGUARD) and (m_Master = nil);
end;

//刷物等级属性
procedure TBaseObject.MonsterRecalcAbilitys;
var
  n8: Integer;
begin
  n8 := 0;
  if (m_btRaceServer = 100) or (m_btRaceServer = 113) or (m_btRaceServer = 114) or (m_btRaceServer = 128) then begin
    m_WAbil.DC := MakeLong(LoWord(m_WAbil.DC), ROUND((m_btSlaveExpLevel * 0.1 + 0.3) * HiWord(m_Abil.DC) + HiWord(m_Abil.DC)));
    m_WAbil.AC := MakeLong(LoWord(m_WAbil.AC), ROUND((m_btSlaveExpLevel * 0.1) * HiWord(m_Abil.AC) + HiWord(m_Abil.AC)));
    m_WAbil.MAC := MakeLong(LoWord(m_WAbil.MAC), ROUND((m_btSlaveExpLevel * 0.1) * HiWord(m_Abil.MAC) + HiWord(m_Abil.MAC)));
    n8 := n8 + ROUND((m_btSlaveExpLevel *  0.1 + 0.3) * m_Abil.MaxHP) * m_btSlaveExpLevel;
    n8 := n8 + m_Abil.MaxHP;
    if m_btSlaveExpLevel > 0 then
      m_WAbil.MaxHP := n8
    else
      m_WAbil.MaxHP := m_Abil.MaxHP;
  end
  else begin //004BEA85
    n8 := m_Abil.MaxHP;
    m_WAbil.DC := MakeLong(LoWord(m_Abil.DC), ROUND(m_btSlaveExpLevel * 2 +  HiWord(m_Abil.DC)));
    n8 := n8 + ROUND(m_Abil.MaxHP *  0.15) *  m_btSlaveExpLevel;
    m_WAbil.MaxHP := _MIN(ROUND(m_Abil.MaxHP + m_btSlaveExpLevel * 60), n8);
    //m_WAbil.MAC:=0; 01/20 取消此行，防止怪物升级后魔防变0
  end;
  //m_btHitPoint:=15; 01/20 取消此行，防止怪物升级后准确率变15
end;

procedure TBaseObject.HintGotoScript(nScript: Integer);
begin
  if nScript > -1 then begin
    g_FunctionNPC.m_GotoValue[0] := FilterShowName(m_sCharName);
    if m_PEnvir <> nil then g_FunctionNPC.m_GotoValue[1] := m_PEnvir.sMapDesc
    else g_FunctionNPC.m_GotoValue[1] := '';
    g_FunctionNPC.m_GotoValue[2] := IntToStr(m_nCurrX);
    g_FunctionNPC.m_GotoValue[3] := IntToStr(m_nCurrY);
    if m_PEnvir <> nil then g_FunctionNPC.m_GotoValue[8] := m_PEnvir.sMapName
    else g_FunctionNPC.m_GotoValue[8] := '';
    g_FunctionNPC.m_GotoValue[9] := m_sCharName;
    g_FunctionNPC.m_HookObject := Self;
    Try
      g_FunctionNPC.GotoLable(SystemObject, nScript, False, '');
    Finally
      g_FunctionNPC.m_HookObject := nil;
    End;
  end;
end;

//检查角色的座标是否在指定误差范围以内
//TargeTBaseObject 为要检查的角色，nX,nY 为比较的座标
//检查角色是否在指定座标的1x1 范围以内，如果在则返回True 否则返回 False

function TBaseObject.CretInNearXY(TargeTBaseObject: TBaseObject; nX, nY: Integer; nRate: Byte = 1): Boolean;
var
  i: Integer;
  nCX, nCY: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := False;
  if m_PEnvir = nil then begin
    MainOutMessage('CretInNearXY nil PEnvir');
    Exit;
  end;
  for nCX := nX - nRate to nX + nRate do begin
    for nCY := nY - nRate to nY + nRate do begin
      if m_PEnvir.GetMapCellInfo(nCX, nCY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for i := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := pTOSObject(MapCellInfo.ObjList.Items[i]);
          if OSObject <> nil then begin
            if OSObject.btType = OS_MOVINGOBJECT then begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if BaseObject <> nil then begin
                if not BaseObject.m_boGhost and BaseObject.m_boMapApoise and (BaseObject = TargeTBaseObject) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TBaseObject.SendFirstMsg(BaseObject: TBaseObject; wIdent, wParam: Integer; lParam1, lParam2, lParam3: Integer; sMsg: string);
var
  SendMessage: pTSendMessage;
begin
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    if not m_boGhost then begin
      New(SendMessage);
      SendMessage.wIdent := wIdent;
      SendMessage.wParam := wParam;
      SendMessage.nParam1 := lParam1;
      SendMessage.nParam2 := lParam2;
      SendMessage.nParam3 := lParam3;
      SendMessage.dwDeliveryTime := 0;
      SendMessage.BaseObject := BaseObject;
      if sMsg <> '' then begin
        try
          GetMem(SendMessage.Buff, Length(sMsg) + 1);
          Move(sMsg[1], SendMessage.Buff^, Length(sMsg) + 1);
        except
          SendMessage.Buff := nil;
        end;
      end
      else begin
        SendMessage.Buff := nil;
      end;
      m_MsgList.Insert(0, SendMessage);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

procedure TBaseObject.SendDelayDefMsg(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer; Param, tag, Series: Integer; sMsg: string; dwDelay: LongWord);
var
  SendMessage: pTSendMessage;
begin
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    if not m_boGhost then begin
      New(SendMessage);
      SendMessage.wIdent := RM_DEFMESSAGE;
      SendMessage.wParam := wIdent;
      SendMessage.nParam1 := Recog;
      SendMessage.nParam2 := Param;
      SendMessage.nParam3 := tag;
      SendMessage.nParam4 := Series;
      SendMessage.dwDeliveryTime := GetTickCount + dwDelay;
      SendMessage.BaseObject := BaseObject;
      SendMessage.boLateDelivery := False;
      if sMsg <> '' then begin
        try
          GetMem(SendMessage.Buff, Length(sMsg) + 1);
          Move(sMsg[1], SendMessage.Buff^, Length(sMsg) + 1);
        except
          SendMessage.Buff := nil;
        end;
      end
      else begin
        SendMessage.Buff := nil;
      end;
      m_MsgList.Insert(0, SendMessage);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

procedure TBaseObject.SendUpdateDelayDefMsg(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer; Param, tag, Series: Integer; sMsg: string; dwDelay: LongWord);
var
  SendMessage: pTSendMessage;
  i: Integer;
begin
  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    i := 0;
    while (True) do begin
      if m_MsgList.Count <= i then break;
      SendMessage := m_MsgList.Items[i];
      if (SendMessage.wIdent = wIdent) and (SendMessage.nParam1 = Recog) then begin
        m_MsgList.Delete(i);
        if SendMessage.Buff <> nil then
          FreeMem(SendMessage.Buff);
        DisPose(SendMessage);
        Continue;
      end;
      Inc(i);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
  SendDelayDefMsg(BaseObject, wIdent, Recog, Param, tag, Series, sMsg, dwDelay);
end;

procedure TBaseObject.SendFirstDefMsg(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer; Param, tag, Series: Integer; sMsg: string);
var
  SendMessage: pTSendMessage;
begin
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    if not m_boGhost then begin
      New(SendMessage);
      SendMessage.wIdent := RM_DEFMESSAGE;
      SendMessage.wParam := wIdent;
      SendMessage.nParam1 := Recog;
      SendMessage.nParam2 := Param;
      SendMessage.nParam3 := tag;
      SendMessage.nParam4 := Series;
      SendMessage.dwDeliveryTime := 0;
      SendMessage.BaseObject := BaseObject;
      SendMessage.boLateDelivery := False;
      if sMsg <> '' then begin
        try
          GetMem(SendMessage.Buff, Length(sMsg) + 1);
          Move(sMsg[1], SendMessage.Buff^, Length(sMsg) + 1);
        except
          SendMessage.Buff := nil;
        end;
      end
      else begin
        SendMessage.Buff := nil;
      end;
      m_MsgList.Insert(0, SendMessage);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

procedure TBaseObject.SendUpdateDefMsg(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer; Param, tag, Series: Integer; sMsg: string);
var
  SendMessage: pTSendMessage;
  i: Integer;
begin
  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    i := 0;
    while (True) do begin
      if m_MsgList.Count <= i then break;
      SendMessage := m_MsgList.Items[i];
      if (SendMessage.wIdent = RM_DEFMESSAGE) and (SendMessage.wParam = wIdent) and (SendMessage.nParam1 = Recog) then begin
        m_MsgList.Delete(i);
        if SendMessage.Buff <> nil then
          FreeMem(SendMessage.Buff);
        DisPose(SendMessage);
        Continue;
      end;
      Inc(i);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
  SendDefMsg(BaseObject, wIdent, Recog, Param, Tag, Series, sMsg);
end;

procedure TBaseObject.SendDefMsg(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer; Param, tag, Series: Integer; sMsg: string);
var
  SendMessage: pTSendMessage;
begin
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    if not m_boGhost then begin
      New(SendMessage);
      SendMessage.wIdent := RM_DEFMESSAGE;
      SendMessage.wParam := wIdent;
      SendMessage.nParam1 := Recog;
      SendMessage.nParam2 := Param;
      SendMessage.nParam3 := tag;
      SendMessage.nParam4 := Series;
      SendMessage.dwDeliveryTime := 0;
      SendMessage.BaseObject := BaseObject;
      SendMessage.boLateDelivery := False;
      if sMsg <> '' then begin
        try
          GetMem(SendMessage.Buff, Length(sMsg) + 1);
          Move(sMsg[1], SendMessage.Buff^, Length(sMsg) + 1);
        except
          SendMessage.Buff := nil;
        end;
      end
      else begin
        SendMessage.Buff := nil;
      end;
      m_MsgList.Add(SendMessage);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

procedure TBaseObject.SendDefSocket(BaseObject: TBaseObject; wIdent: Integer; Recog: Integer; Param, tag, Series: Integer; sMsg: string);
var
  SendMessage: pTSendMessage;
begin
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    if not m_boGhost then begin
      New(SendMessage);
      SendMessage.wIdent := RM_DEFSOCKET;
      SendMessage.wParam := wIdent;
      SendMessage.nParam1 := Recog;
      SendMessage.nParam2 := Param;
      SendMessage.nParam3 := tag;
      SendMessage.nParam4 := Series;
      SendMessage.dwDeliveryTime := 0;
      SendMessage.BaseObject := BaseObject;
      SendMessage.boLateDelivery := False;
      if sMsg <> '' then begin
        try
          GetMem(SendMessage.Buff, Length(sMsg) + 1);
          Move(sMsg[1], SendMessage.Buff^, Length(sMsg) + 1);
        except
          SendMessage.Buff := nil;
        end;
      end
      else begin
        SendMessage.Buff := nil;
      end;
      m_MsgList.Add(SendMessage);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

procedure TBaseObject.SendMsg(BaseObject: TBaseObject; wIdent, wParam: Integer; nParam1, nParam2, nParam3: Integer; sMsg: string); //004B865C
var
  SendMessage: pTSendMessage;
begin
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    if not m_boGhost then begin
      New(SendMessage);
      SendMessage.wIdent := wIdent;
      SendMessage.wParam := wParam;
      SendMessage.nParam1 := nParam1;
      SendMessage.nParam2 := nParam2;
      SendMessage.nParam3 := nParam3;
      SendMessage.dwDeliveryTime := 0;
      SendMessage.BaseObject := BaseObject;
      SendMessage.boLateDelivery := False;
      if sMsg <> '' then begin
        try
          GetMem(SendMessage.Buff, Length(sMsg) + 1);
          Move(sMsg[1], SendMessage.Buff^, Length(sMsg) + 1);
        except
          SendMessage.Buff := nil;
        end;
      end
      else begin
        SendMessage.Buff := nil;
      end;
      m_MsgList.Add(SendMessage);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

    {
    施法者发送延迟魔法：
    1 自己
    2 RM 常量
    3 伤害、中毒类型
    4 目标坐标、中毒点数
    5 不清楚、目标对象
    6 目标对象、等级系数
    7 空消息
    8 延迟时间——飞行时长、固定生效间隔
    }
procedure TBaseObject.SendDelayMsg(BaseObject: TBaseObject; wIdent, wParam: Integer; lParam1, lParam2, lParam3, lParam4: Integer; sMsg: string; dwDelay: LongWord);
var
  SendMessage: pTSendMessage;
begin
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    if not m_boGhost then begin
      New(SendMessage);
      SendMessage.wIdent := wIdent;
      SendMessage.wParam := wParam;
      SendMessage.nParam1 := lParam1;
      SendMessage.nParam2 := lParam2;
      SendMessage.nParam3 := lParam3;
      SendMessage.nParam4 := lParam4;
      SendMessage.dwDeliveryTime := GetTickCount + dwDelay;
      SendMessage.BaseObject := BaseObject;
      SendMessage.boLateDelivery := True;
      if sMsg <> '' then begin
        try
          GetMem(SendMessage.Buff, Length(sMsg) + 1);
          Move(sMsg[1], SendMessage.Buff^, Length(sMsg) + 1);
        except
          SendMessage.Buff := nil;
        end;
      end
      else begin
        SendMessage.Buff := nil;
      end;
      m_MsgList.Add(SendMessage);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

procedure TBaseObject.SendUpdateDelayMsg(BaseObject: TBaseObject; wIdent, wParam: Integer; lParam1, lParam2, lParam3: Integer; sMsg: string; dwDelay: LongWord);
var
  SendMessage: pTSendMessage;
  i: Integer;
begin
  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    i := 0;
    while (True) do begin
      if m_MsgList.Count <= i then
        break;
      SendMessage := m_MsgList.Items[i];
      if (SendMessage.wIdent = wIdent) and (SendMessage.nParam1 = lParam1) then begin
        m_MsgList.Delete(i);
        if SendMessage.Buff <> nil then
          FreeMem(SendMessage.Buff);
        DisPose(SendMessage);
        Continue;
      end;
      Inc(i);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
  SendDelayMsg(BaseObject, wIdent, wParam, lParam1, lParam2, lParam3, 0, sMsg, dwDelay);
end;

procedure TBaseObject.SendUpdateMsg(BaseObject: TBaseObject; wIdent, wParam: Integer; lParam1, lParam2, lParam3: Integer; sMsg: string);
var
  SendMessage: pTSendMessage;
  i: Integer;
begin
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    i := 0;
    while (True) do begin
      if m_MsgList.Count <= i then
        break;
      SendMessage := m_MsgList.Items[i];
      if SendMessage.wIdent = wIdent then begin
        m_MsgList.Delete(i);
        if SendMessage.Buff <> nil then
          FreeMem(SendMessage.Buff);
        DisPose(SendMessage);
        Continue;
      end;
      Inc(i);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
  SendMsg(BaseObject, wIdent, wParam, lParam1, lParam2, lParam3, sMsg);
end;

function TBaseObject.GetMessage(Msg: pTProcessMessage): Boolean;
var
  i: Integer;
  SendMessage: pTSendMessage;
begin
  Result := False;
  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    i := 0;
    Msg.wIdent := 0;
    while m_MsgList.Count > i do begin
      SendMessage := m_MsgList.Items[i];
      if (SendMessage.dwDeliveryTime <> 0) and (GetTickCount < SendMessage.dwDeliveryTime) then begin
        Inc(i);
        Continue;
      end;
      m_MsgList.Delete(i);
      Msg.wIdent := SendMessage.wIdent;
      Msg.wParam := SendMessage.wParam;
      Msg.nParam1 := SendMessage.nParam1;
      Msg.nParam2 := SendMessage.nParam2;
      Msg.nParam3 := SendMessage.nParam3;
      Msg.nParam4 := SendMessage.nParam4;
      Msg.BaseObject := SendMessage.BaseObject;
      Msg.dwDeliveryTime := SendMessage.dwDeliveryTime;
      Msg.boLateDelivery := SendMessage.boLateDelivery;
      if SendMessage.Buff <> nil then begin
        Msg.sMsg := StrPas(SendMessage.Buff);
        FreeMem(SendMessage.Buff);
      end
      else begin
        Msg.sMsg := '';
      end;
      DisPose(SendMessage);
      Result := True;
      break;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TBaseObject.GetMapBaseObjects(tEnvir: TEnvirnoment; nX, nY, nRage: Integer; rList: TList): Boolean;
var
  III: Integer;
  x, y: Integer;
  nStartX, nStartY, nEndX, nEndY: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
resourcestring
  sExceptionMsg = '[Exception] TBaseObject::GetMapBaseObjects';
begin
  Result := False;
  if rList = nil then
    Exit;
  try
    nStartX := nX - nRage;
    nEndX := nX + nRage;
    nStartY := nY - nRage;
    nEndY := nY + nRage;
    for x := nStartX to nEndX do begin
      for y := nStartY to nEndY do begin
        if tEnvir.GetMapCellInfo(x, y, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          for III := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := pTOSObject(MapCellInfo.ObjList.Items[III]);
            if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if (BaseObject <> nil) and (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) then begin
                rList.Add(BaseObject);
              end;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
  Result := True;
end;

procedure TBaseObject.SendRefMsg(wIdent, wParam: Integer; nParam1, nParam2, nParam3: Integer; sMsg: string; dwDelay: LongWord);
var
  ii, nC: Integer;
  nCX, nCY, nLX, nLY, nHX, nHY: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  //  btType: Byte;
resourcestring
  sExceptionMsg = '[Exception] TBaseObject::SendRefMsg Name = %s';
begin

  if m_PEnvir = nil then begin
    MainOutMessage(m_sCharName + ' SendRefMsg nil PEnvir ');
    Exit;
  end;
  //if not m_boMapApoise then exit;
  //if m_boObMode or m_boFixedHideMode then exit;
  //01/21 增加，原来直接不发信息，如果隐身模式则只发送信息给自己
  if m_boObMode or m_boFixedHideMode  then begin
    if dwDelay > 0 then SendDelayMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, 0, sMsg, dwDelay)
    else SendMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
    Exit;
  end;

  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    if ((GetTickCount - m_SendRefMsgTick) >= 500) or (m_VisibleHumanList.Count = 0) then begin
      m_SendRefMsgTick := GetTickCount();
      m_VisibleHumanList.Clear;
      nLX := m_nCurrX - g_Config.nSendRefMsgRange {12};
      nHX := m_nCurrX + g_Config.nSendRefMsgRange {12};
      nLY := m_nCurrY - g_Config.nSendRefMsgRange {12};
      nHY := m_nCurrY + g_Config.nSendRefMsgRange {12};
      for nCX := nLX to nHX do begin
        for nCY := nLY to nHY do begin
          if m_PEnvir.GetMapCellInfo(nCX, nCY, MapCellInfo) then begin
            if MapCellInfo.ObjList <> nil then begin
              for ii := MapCellInfo.ObjList.Count - 1 downto 0 do begin
                OSObject := MapCellInfo.ObjList.Items[ii];
                if OSObject <> nil then begin
                  if OSObject.btType = OS_MOVINGOBJECT then begin
                    if (GetTickCount - OSObject.dwAddTime) >= 180 * 1000 then begin
                      MapCellInfo.ObjList.Delete(ii);
                      DisPose(OSObject);
                      if MapCellInfo.ObjList.Count <= 0 then begin
                        FreeAndNil(MapCellInfo.ObjList);
                        break;
                      end;
                    end
                    else begin
                      try
                        BaseObject := TBaseObject(OSObject.CellObj);
                        if (BaseObject <> nil) and not BaseObject.m_boGhost then begin
                          if (BaseObject.m_btRaceServer = RC_PLAYOBJECT)  then begin
                            //if BaseObject.m_boMapApoise then begin
                              if dwDelay > 0 then
                                BaseObject.SendDelayMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, 0,sMsg, dwDelay)
                              else
                                BaseObject.SendMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
                              //BaseObject.SendMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
                            //end;
                            //BaseObject.m_nGroupIdent := m_nGroupIdent;
                            m_VisibleHumanList.Add(BaseObject);
                          end
                          else if BaseObject.m_boWantRefMsg then begin {增加分身的魔法盾效果}
                            if (wIdent = RM_STRUCK) or (wIdent = RM_HEAR) or
                              (wIdent = RM_DEATH) or (wIdent = RM_CHARSTATUSCHANGED) then begin
                              if dwDelay > 0 then
                                BaseObject.SendDelayMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, 0,sMsg, dwDelay)
                              else
                                BaseObject.SendMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
                              //BaseObject.SendMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
                              //BaseObject.m_nGroupIdent := wIdent;
                              m_VisibleHumanList.Add(BaseObject);
                            end;
                          end;
                        end;
                      except
                        on E: Exception do begin
                          MapCellInfo.ObjList.Delete(ii);
                          if MapCellInfo.ObjList.Count <= 0 then begin
                            FreeAndNil(MapCellInfo.ObjList);
                          end;
                          MainOutMessage(format(sExceptionMsg, [m_sCharName]));
                          MainOutMessage(E.Message);
                        end;
                      end;
                    end;
                  end;
                end;
              end; //for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            end; //if MapCellInfo.ObjList <> nil then begin
          end; //if PEnvir.GetMapCellInfo(nC,n10,MapCellInfo) then begin
        end;
      end;
      Exit;
    end;
    for nC := 0 to m_VisibleHumanList.Count - 1 do begin
      BaseObject := TBaseObject(m_VisibleHumanList.Items[nC]);
      if (BaseObject = nil) or (BaseObject.m_boGhost) then Continue;
      if (BaseObject.m_PEnvir = m_PEnvir) and
        (abs(BaseObject.m_nCurrX - m_nCurrX) <= g_Config.nSendRefMsgRange) and
        (abs(BaseObject.m_nCurrY - m_nCurrY) <= g_Config.nSendRefMsgRange) then begin
        if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
          //if BaseObject.m_boMapApoise then begin
            if dwDelay > 0 then BaseObject.SendDelayMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, 0,sMsg, dwDelay)
            else BaseObject.SendMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
            //BaseObject.SendMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
          //end;
        end
        else if BaseObject.m_boWantRefMsg then begin
          if (wIdent = RM_STRUCK) or (wIdent = RM_HEAR) or (wIdent = RM_DEATH) or (wIdent = RM_CHARSTATUSCHANGED) then
          begin
            if dwDelay > 0 then BaseObject.SendDelayMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, 0,sMsg, dwDelay)
            else BaseObject.SendMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
            //BaseObject.SendMsg(Self, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
          end;
        end; //if BaseObject.m_boWantRefMsg then begin
      end; //if (BaseObject.m_PEnvir = m_PEnvir) and
    end; //for nC:= 0 to m_VisibleHumanList.Count - 1 do begin
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

procedure TBaseObject.UpdateVisibleGay(BaseObject: TBaseObject);
var
  i: Integer;
  boIsVisible: Boolean;
  VisibleBaseObject: pTVisibleBaseObject;
begin
  boIsVisible := False;
  //if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_Master <> nil) then
    //m_boIsVisibleActive := True; //如果是人物或宝宝则置TRUE
  for i := 0 to m_VisibleActors.Count - 1 do begin
    VisibleBaseObject := m_VisibleActors.Items[i];
    if VisibleBaseObject <> nil then begin
      if VisibleBaseObject.BaseObject = BaseObject then begin
        VisibleBaseObject.nVisibleFlag := 1;
        boIsVisible := True;
        break;
      end;
    end;
  end;
  if boIsVisible then Exit;
  New(VisibleBaseObject);
  VisibleBaseObject.nVisibleFlag := 2;
  VisibleBaseObject.BaseObject := BaseObject;
  //2009-3-31 修改 增加周围可视人物及宝宝数量统计
  if (m_btRaceServer = RC_PLAYOBJECT) or ((m_Master <> nil) and (m_Master.m_btRaceServer = RC_PLAYOBJECT)) then begin
    VisibleBaseObject.boAddCount := True;
    Inc(BaseObject.m_nVisibleActiveCount);
  end
  else
    VisibleBaseObject.boAddCount := False;
  m_VisibleActors.Add(VisibleBaseObject);
end;

procedure TBaseObject.UpdateVisibleItem(wX, wY: Integer; MapItem: PTMapItem);
var
  i: Integer;
  boIsVisible: Boolean;
  VisibleMapItem: pTVisibleMapItem;
begin
  boIsVisible := False;
  for i := 0 to m_VisibleItems.Count - 1 do begin
    VisibleMapItem := m_VisibleItems.Items[i];
    if VisibleMapItem <> nil then begin
      if (VisibleMapItem.MapItem <> nil) and (VisibleMapItem.MapItem = MapItem) then begin
        VisibleMapItem.nVisibleFlag := 1;
        boIsVisible := True;
        break;
      end;
    end;
  end;
  if boIsVisible then
    Exit;
  New(VisibleMapItem);
  VisibleMapItem.nVisibleFlag := 2;
  VisibleMapItem.nX := wX;
  VisibleMapItem.nY := wY;
  VisibleMapItem.MapItem := MapItem;
  VisibleMapItem.sName := MapItem.Name;
  VisibleMapItem.wLooks := MapItem.Looks;
  m_VisibleItems.Add(VisibleMapItem);
end;

procedure TBaseObject.UpdateVisibleEvent(wX, wY: Integer; MapEvent: TObject);
var
  i: Integer;
  boIsVisible: Boolean;
  Event: TEvent;
begin
  boIsVisible := False;
  for i := 0 to m_VisibleEvents.Count - 1 do begin
    Event := m_VisibleEvents.Items[i];
    if Event <> nil then begin
      if Event = MapEvent then begin
        Event.nVisibleFlag := 1;
        boIsVisible := True;
        break;
      end;
    end;
  end;
  if boIsVisible then
    Exit;
  TEvent(MapEvent).nVisibleFlag := 2;
  TEvent(MapEvent).m_nX := wX;
  TEvent(MapEvent).m_nY := wY;
  m_VisibleEvents.Add(MapEvent);
end;

procedure TBaseObject.ClearViewRange;
resourcestring
  sExceptionMsg1 = '[Exception] TBaseObject::EnterAnotherMap -> MsgTargetList Clear';
  sExceptionMsg2 = '[Exception] TBaseObject::EnterAnotherMap -> VisbleItems Dispose';
  sExceptionMsg3 = '[Exception] TBaseObject::EnterAnotherMap -> VisbleItems Clear';
  sExceptionMsg4 = '[Exception] TBaseObject::EnterAnotherMap -> VisbleEvents Clear';
  sExceptionMsg5 = '[Exception] TBaseObject::EnterAnotherMap -> VisbleActors Dispose';
  sExceptionMsg6 = '[Exception] TBaseObject::EnterAnotherMap -> VisbleActors Clear';
var
  i: Integer;
  VisibleBaseObject: pTVisibleBaseObject;
begin
  try
    m_VisibleHumanList.Clear;
  except
    MainOutMessage(sExceptionMsg1);
  end;

  try
    for i := 0 to m_VisibleItems.Count - 1 do begin
      DisPose(pTVisibleMapItem(m_VisibleItems.Items[i]));
    end;
  except
    MainOutMessage(sExceptionMsg2);
  end;

  try
    m_VisibleItems.Clear;
  except
    MainOutMessage(sExceptionMsg3);
  end;

  try
    m_VisibleEvents.Clear;
  except
    MainOutMessage(sExceptionMsg4);
  end;
  try
    for i := 0 to m_VisibleActors.Count - 1 do begin
      VisibleBaseObject := pTVisibleBaseObject(m_VisibleActors.Items[i]);
      if VisibleBaseObject <> nil then begin
        if (VisibleBaseObject.BaseObject <> nil) and (VisibleBaseObject.boAddCount) then
          Dec(TBaseObject(VisibleBaseObject.BaseObject).m_nVisibleActiveCount);
        DisPose(VisibleBaseObject);
      end;
    end;
  except
    MainOutMessage(sExceptionMsg5);
  end;
  try
    m_VisibleActors.Clear;
  except
    MainOutMessage(sExceptionMsg6);
  end;

  {try
    m_VisibleHumanList.Clear;
    for i := 0 to m_VisibleItems.Count - 1 do begin
      if pTVisibleMapItem(m_VisibleItems.Items[i]) <> nil then
        DisPose(pTVisibleMapItem(m_VisibleItems.Items[i]));
    end;
    m_VisibleItems.Clear;
    for i := 0 to m_VisibleActors.Count - 1 do begin
      VisibleBaseObject := pTVisibleBaseObject(m_VisibleActors.Items[i]);
      if VisibleBaseObject <> nil then begin
        if (VisibleBaseObject.BaseObject <> nil) and (VisibleBaseObject.boAddCount) then
          Dec(TBaseObject(VisibleBaseObject.BaseObject).m_nVisibleActiveCount);
        DisPose(VisibleBaseObject);
      end;
    end;
    m_VisibleActors.Clear; //清除人物列表
    m_VisibleEvents.Clear;
  except
    KickException();
  end;      }
end;

procedure TBaseObject.SearchObjectViewRange;
var
  i: Integer;
  nStartX: Integer;
  nEndX: Integer;
  nStartY: Integer;
  nEndY: Integer;
  n18: Integer;
  n1C: Integer;
  nIdx: Integer;
  n24: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  //  MapItem: PTMapItem;
  //  MapEvent: TEvent;
  VisibleBaseObject: pTVisibleBaseObject;
  //VisibleMapItem: pTVisibleMapItem;
  nCheckCode: Integer;
  //  btType: Byte;
  //  nVisibleFlag: Integer;
resourcestring
  sExceptionMsg1 = '[Exception] TBaseObject::SearchViewRange Code:%d';
  sExceptionMsg2 =
    '[Exception] TBaseObject::SearchViewRange 1-%d %s %s %d %d %d';
begin
  //  nCheckCode := 0;
  if m_PEnvir = nil then begin
    MainOutMessage('SearchViewRange nil PEnvir by ' + m_sCharName);
    Exit;
  end;
  nCheckCode := 1;
  n24 := 0;
  //m_boIsVisibleActive := False; //先置为FALSE
  try
    m_VisibleHumanList.Clear;
    for i := 0 to m_VisibleItems.Count - 1 do begin
      DisPose(pTVisibleMapItem(m_VisibleItems.Items[i]));
    end;
    m_VisibleItems.Clear;
    m_VisibleEvents.Clear; //2008-08-20 清除无用视线列表
  except
    MainOutMessage(format(sExceptionMsg1, [nCheckCode]));
    KickException();
  end;
  try
    nCheckCode := 4;
    for i := 0 to m_VisibleActors.Count - 1 do begin
      pTVisibleBaseObject(m_VisibleActors.Items[i]).nVisibleFlag := 0;
    end;
    nCheckCode := 5;
  except
    MainOutMessage(format(sExceptionMsg1, [nCheckCode]));
    KickException();
  end;
  nCheckCode := 6;
  nStartX := m_nCurrX - m_nViewRange;
  nEndX := m_nCurrX + m_nViewRange;
  nStartY := m_nCurrY - m_nViewRange;
  nEndY := m_nCurrY + m_nViewRange;
  try
    nCheckCode := 7;
    for n18 := nStartX to nEndX do begin
      nCheckCode := 8;
      for n1C := nStartY to nEndY do begin
        nCheckCode := 9;
        if m_PEnvir.GetMapCellInfo(n18, n1C, MapCellInfo) and
          (MapCellInfo.ObjList <> nil) then begin
          nCheckCode := 10;
          n24 := 1;
          nIdx := 0;
          while (True) do begin
            nCheckCode := 11;
            if (MapCellInfo.ObjList <> nil) and (MapCellInfo.ObjList.Count <= 0) then begin //200-11-1 增加
              FreeAndNil(MapCellInfo.ObjList);
              break;
            end;
            if MapCellInfo.ObjList.Count <= nIdx then break;
            OSObject := MapCellInfo.ObjList.Items[nIdx];
            nCheckCode := 12;
            if OSObject <> nil then begin
              nCheckCode := 13;
              {try
                btType := OSObject.btType; //2006-10-14 防止内存出错
              except
                MapCellInfo.ObjList.Delete(nIdx);
                Continue;
              end; }
              if OSObject.btType = OS_MOVINGOBJECT then begin
                nCheckCode := 14;
                if (GetTickCount - OSObject.dwAddTime) >= 180 * 1000 then begin
                  //MainOutMessage(TBaseObject(OSObject.CellObj).m_sCharName);
                  //OSObject.CellObj;
                  DisPose(OSObject);
                  MapCellInfo.ObjList.Delete(nIdx);
                  if MapCellInfo.ObjList.Count <= 0 then begin
                    FreeAndNil(MapCellInfo.ObjList);
                    break;
                  end;
                  Continue;
                end;
                nCheckCode := 15;
                BaseObject := TBaseObject(OSObject.CellObj);
                if BaseObject <> nil then begin
                  //更新在地图上的时间
                  if BaseObject = Self then begin
                    //如果人物坐标与地图信息坐标不一致,则删除信息
                    if (m_nCurrX = n18) and (m_nCurrY = n1C) then begin
                      OSObject.dwAddTime := GetTickCount;
                      m_dwVerifyTick := GetTickCount();
                    end else begin
                      DisPose(OSObject);
                      MapCellInfo.ObjList.Delete(nIdx);
                      if MapCellInfo.ObjList.Count <= 0 then begin
                        FreeAndNil(MapCellInfo.ObjList);
                        break;
                      end;
                      Continue;
                    end;
                  end;
                  nCheckCode := 16;
                  if (not BaseObject.m_boGhost) and (not BaseObject.m_boFixedHideMode) and
                    (not BaseObject.m_boObMode) and (BaseObject.m_boMapApoise) then begin
                    nCheckCode := 17;
                    if (m_btRaceServer < RC_ANIMAL) or (m_Master <> nil) or m_boCrazyMode or m_boWantRefMsg or
                      ((BaseObject.m_Master <> nil) and
                      (abs(BaseObject.m_nCurrX - m_nCurrX) <= 3) and (abs(BaseObject.m_nCurrY - m_nCurrY) <= 3)) or
                      (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                      nCheckCode := 18;
                      UpdateVisibleGay(BaseObject);
                      nCheckCode := 19;
                    end;
                  end;
                end;
              end else {if OSObject.btType = OS_MOVINGOBJECT then begin 增加怪物检索地面超时物品,防止占用内存}
              if (OSObject.btType = OS_ITEMOBJECT) then begin
                nCheckCode := 21;
                if (pTMapItem(OSObject.CellObj).btIdx <> m_PEnvir.m_btFBIndex) or
                  ((GetTickCount - OSObject.dwAddTime) > g_Config.dwClearDropOnFloorItemTime)  then begin
                  DisPose(pTMapItem(OSObject.CellObj));   //防止占用内存不释放现象
                  DisPose(OSObject);
                  MapCellInfo.ObjList.Delete(nIdx);
                  if MapCellInfo.ObjList.Count <= 0 then begin
                    FreeAndNil(MapCellInfo.ObjList);
                    break;
                  end;
                  Continue;
                end;
              end;
            end;
            Inc(nIdx);
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg2, [n24, m_sCharName, m_sMapName,
        m_nCurrX, m_nCurrY, nCheckCode]));
      MainOutMessage(E.Message);
      KickException();
    end;
  end;
  nCheckCode := 40;
  n24 := 2;
  try

    n18 := 0;
    while (True) do begin
      if m_VisibleActors.Count <= n18 then
        break;
      nCheckCode := 41;
      VisibleBaseObject := m_VisibleActors.Items[n18];
      nCheckCode := 42;
      {try
//        nVisibleFlag := VisibleBaseObject.nVisibleFlag; //2006-10-14防止内存出错
      except
        m_VisibleActors.Delete(n18);
        Continue;
      end;  }
      if VisibleBaseObject.nVisibleFlag = 0 then begin
        nCheckCode := 43;
        if (VisibleBaseObject.BaseObject <> nil) and VisibleBaseObject.boAddCount then
          Dec(TBaseObject(VisibleBaseObject.BaseObject).m_nVisibleActiveCount);
        m_VisibleActors.Delete(n18);
        nCheckCode := 48;
        DisPose(VisibleBaseObject);
        nCheckCode := 49;
        Continue;
      end;
      Inc(n18);
    end;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg2, [n24, m_sCharName, m_sMapName, m_nCurrX, m_nCurrY, nCheckCode]));
      KickException();
    end;
  end;
end;

function TBaseObject.GetFeatureToLong: Integer;
begin
  Result := GetFeature(nil);
end;

function TBaseObject.GetFeatureEx(): Integer;
begin
  if m_boOnHorse then begin
    Result := MakeWord(m_btHorseType, m_btDressEffType);
  end
  else begin
    Result := MakeWord(0, m_btDressEffType);
  end;
end;

function TBaseObject.GetFeature(BaseObject: TBaseObject): Integer;
var
  nDress, nWeapon, nHair: Integer;
  StdItem: pTStdItem;
begin
    if (m_btRaceServer = RC_PLAYOBJECT) then begin
      nDress := 0;
      //衣服
      if m_UseItems[U_DRESS].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[U_DRESS].wIndex);
        if StdItem <> nil then begin
          nDress := StdItem.Shape * 2;
        end;
        if m_boOnHorse then
          nDress := m_btHorseDress * 2;
      end;
      Inc(nDress, m_btGender);
      nWeapon := 0;
      //武器
      if m_UseItems[U_WEAPON].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
        if StdItem <> nil then begin
          nWeapon := StdItem.Shape * 2;
        end;
      end;
      Inc(nWeapon, m_btGender);
      nHair := m_btHair * 2 + m_btGender;
      Result := MakeHumanFeature(0, nDress, nWeapon, nHair);
      Exit;
    end;
    Result := MakeMonsterFeature(m_btRaceImg, m_btRaceServer, m_wAppr);
end;

function TBaseObject.GetCharStatus(): Integer;
var
  i: Integer;
  nStatus: Integer;
begin
  nStatus := 0;
  for i := Low(TStatusTime) to High(TStatusTime) do begin
    if m_wStatusTimeArr[i] > 0 then begin
      nStatus := Integer($80000000 shr i) or nStatus;
    end;
  end;
  Result := (m_nCharStatusEx and $FFFFF) or nStatus;
end;

procedure TBaseObject.AbilCopyToWAbil;
begin
  m_WAbil := m_Abil;
end;

procedure TBaseObject.Initialize;
begin
  AbilCopyToWAbil();
  m_boAddtoMapSuccess := True;
  if m_PEnvir.CanWalk(m_nCurrX, m_nCurrY, True) and AddToMap() then
    m_boAddtoMapSuccess := False;
  m_nCharStatus := GetCharStatus();
  AddBodyLuck(0);
  if (m_btRaceServer <> RC_PLAYOBJECT) then begin
    if g_Config.boMonSayMsg then begin
      LoadSayMsg();
      MonsterSayMsg(nil, s_MonGen);
    end;
  end;
end;
//==============================
//取得怪物说话信息列表

procedure TBaseObject.LoadSayMsg();
var
  i: Integer;
begin
  for i := 0 to g_MonSayMsgList.Count - 1 do begin
    if CompareText(g_MonSayMsgList.Strings[i], m_sCharName) = 0 then begin
      m_SayMsgList := TList(g_MonSayMsgList.Objects[i]);
      break;
    end;
  end;
end;

procedure TBaseObject.Disappear();
begin
  m_boDisappear := True;
end;

procedure TBaseObject.FeatureChanged;
begin
  SendRefMsg(RM_FEATURECHANGED, GetFeatureEx, GetFeatureToLong, 0, 0, IntToStr(m_btStrengthenName))
end;

procedure TBaseObject.StatusChanged();
begin
  SendRefMsg(RM_CHARSTATUSCHANGED, m_nHitSpeed, m_nCharStatus, 0, 0, '')
end;

procedure TBaseObject.DisappearA();
begin
  m_PEnvir.DeleteFromMap(m_nCurrX, m_nCurrY, OS_MOVINGOBJECT, Self);
  SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
end;

procedure TBaseObject.DisappearB();
begin
  m_PEnvir.DeleteFromMap(m_nCurrX, m_nCurrY, OS_MOVINGOBJECT, Self);
end;

procedure TBaseObject.KickException;
var
  PlayObject: TPlayObject;
begin
  if m_btRaceServer = RC_PLAYOBJECT then begin
    m_sMapName := g_Config.sHomeMap;
    m_nCurrX := g_Config.nHomeX;
    m_nCurrY := g_Config.nHomeY;
    PlayObject := TPlayObject(Self);
    PlayObject.m_boEmergencyClose := True;
    PlayObject.m_boPlayOffLine := False; //关闭下线触发
  end
  else begin
    m_boDeath := True;
    m_dwDeathTick := GetTickCount;
    MakeGhost;
  end;
end;

procedure TBaseObject.ChangeHorseState(boOnHorse: Boolean);
begin
{$IF Var_Free = 1}
  SysMsg(frmMain.enmsg.DecryptStr('6eurQ1pkbOyZIRyY0SbI0xSEOKoQNW7PozjYRGBTBxTNBTi7'), c_Red, t_Hint); //enmsg
  exit;
{$IFEND}
  if m_boOnHorse then begin
    if not boOnHorse then begin
      m_boOnHorse := False;
      m_boCanOnHorse := False;
      m_dwCanOnHorseTime := 0;
      m_UseItems[u_House].wHP := m_WAbil.HP;
      if (g_Config.nHorseAliveTime <= 0) and (m_UseItems[u_House].wHP <= 0) then
        m_UseItems[u_House].wHP := 14;
      if m_btRaceServer = RC_PLAYOBJECT then
        TPlayObject(Self).SendUpdateItem(@m_UseItems[u_House]);
      RecalcAbilitys;
      SendAbility;
      SendSubAbility;
      FeatureChanged();
    end;
  end else begin
    if boOnHorse and m_PEnvir.m_boNotHorse then begin
      SysMsg('当前地图不允许使用坐骑...', c_Red, t_Hint);
      Exit;
    end;

    if boOnHorse and (not m_boCanOnHorse) and (g_Config.nTakeOnHorseUseTime > 1) then begin
      if (m_UseItems[u_House].btAliveTime > 0)  then begin
        SysMsg('坐骑正在恢复，暂时无法骑乘！', c_Red, t_Hint);
        //SendDefMessage(SM_SHOWBAR, ProcessMsg.nParam1, 1, CM_CLICKBOX, BaseObject.m_WAbil.MaxHP, '正在开启宝箱...');
        Exit;
      end;
      if (m_UseItems[u_House].wHP <= 0) then
        m_UseItems[u_House].wHP := 14;

      m_boCanOnHorse := True;
      m_dwCanOnHorseTime := GetTickCount + LongWord(g_Config.nTakeOnHorseUseTime * 1000);
      if m_btRaceServer = RC_PLAYOBJECT then
        TPlayObject(Self).SendDefMessage(SM_SHOWBAR, Integer(Self), 2, CM_CLICKBOX, g_Config.nTakeOnHorseUseTime, '正在准备坐骑...');

    end else
    if boOnHorse and ((m_boCanOnHorse and (GetTickCount > m_dwCanOnHorseTime)) or (g_Config.nTakeOnHorseUseTime <= 1)) then begin
      if (m_UseItems[u_House].btAliveTime > 0)  then begin
        SysMsg('坐骑正在恢复，暂时无法骑乘！', c_Red, t_Hint);
        //SendDefMessage(SM_SHOWBAR, ProcessMsg.nParam1, 1, CM_CLICKBOX, BaseObject.m_WAbil.MaxHP, '正在开启宝箱...');
        Exit;
      end;

      if (m_UseItems[u_House].wHP <= 0) then
        m_UseItems[u_House].wHP := 14;

      m_boOnHorse := True;
      m_boCanOnHorse := False;
      m_dwCanOnHorseTime := 0;
      RecalcAbilitys;
      SendAbility;
      SendSubAbility;
      FeatureChanged();
    end;
  end;

end;

procedure TBaseObject.GetStartType();
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  bo1D: Boolean;
  I: Integer;
begin
  try
    if m_PEnvir = nil then begin
      MainOutMessage('GetStartType nil PEnvir');
      exit;
    end;
    bo1D := m_PEnvir.GetMapCellInfo(m_nCurrX, m_nCurrY, MapCellInfo);
    if bo1D and (MapCellInfo.ObjList <> nil) then begin
      m_btStartType := OT_HAZARD;
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[i];
        if OSObject.btType = OS_SAFEAREA then begin
          m_btStartType := OT_SAFEAREA;
        end
        else if OSObject.btType = OS_SAFEPK then begin
          m_btStartType := OT_SAFEPK;
        end
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(E.Message);
      MainOutMessage('[Excetpion] TBaseObject.GetStartType');
    end;
  end;
end;

function TBaseObject.Walk(nIdent: Integer): Boolean;
var
  i: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  GateObj: pTGateObj;
  bo1D: Boolean;
  Event: TEvent;
//  PlayObject: TPlayObject;
  nCheckCode: Integer;
  MapEvent: pTMapEvent;
  BaseObject: TBaseObject;
  OldEnvir: TEnvirnoment;
  nOldX: Integer;
  nOldY: Integer;
  boInSafeMilieu: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TBaseObject::Walk  CheckCode:%d %s %s %d:%d';
begin
  Result := True;
  nCheckCode := -1;

  if m_PEnvir = nil then begin
    MainOutMessage('Walk nil PEnvir');
    Exit;
  end;

  
  //非玩家且无火墙不处理地图连接等事件
  if (m_btRaceServer <> RC_PLAYOBJECT) and (not m_PEnvir.GetFireBurn(m_nCurrX, m_nCurrY)) and (not m_boNotInSafe) then begin
    SendRefMsg(nIdent, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    exit;
  end;

  OnAction(AT_Walk);
  //设置五行活动时间
  //m_dwIsGetWuXinExpTime := GetTickCount + g_Config.dwGetWuXinExpTick;
  try
    nCheckCode := 1;
    bo1D := m_PEnvir.GetMapCellInfo(m_nCurrX, m_nCurrY, MapCellInfo);
    GateObj := nil;
    Event := nil;
    MapEvent := nil;
    m_btStartType := OT_HAZARD;
    nCheckCode := 2;
    boInSafeMilieu := False;
    if bo1D and (MapCellInfo.ObjList <> nil) then begin
      for i := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[i];
        if OSObject <> nil then begin
          if OSObject.btType = OS_GATEOBJECT then begin
            GateObj := pTGateObj(OSObject.CellObj);
          end
          else if OSObject.btType = OS_EVENTOBJECT then begin
            if TEvent(OSObject.CellObj).m_OwnBaseObject <> nil then
              Event := TEvent(OSObject.CellObj);
          end
          else if OSObject.btType = OS_SAFEAREA then begin
            m_btStartType := OT_SAFEAREA;
            boInSafeMilieu := True;
          end
          else if OSObject.btType = OS_SAFEPK then begin
            m_btStartType := OT_SAFEPK;
          end
          else if OSObject.btType = OS_SAFEMILIEU then begin
            boInSafeMilieu := True;
          end  
          else if (OSObject.btType = OS_WALK) and (nIdent = RM_WALK) and (g_Config.boStartWalkMapEvent) then begin
            MapEvent := pTMapEvent(OSObject.CellObj);
          end
          else if (OSObject.btType = OS_RUN) and (nIdent = RM_RUN) and (g_Config.boStartRunMapEvent) then begin
            MapEvent := pTMapEvent(OSObject.CellObj);
          end
          else if (OSObject.btType = OS_HORSERUN) and (nIdent = RM_HORSERUN) then begin
            MapEvent := pTMapEvent(OSObject.CellObj);
          end;
          {if OSObject.btType = OS_MAPEVENT then begin

          end;
          if OSObject.btType = OS_DOOR then begin

          end;
          if OSObject.btType = OS_ROON then begin

          end;  }
        end;
      end;
    end;
    nCheckCode := 3;
    if boInSafeMilieu and m_boNotInSafe then begin
      Result := False;
      SendMsg(Self, RM_RANDOMMOVE, 0, 0, 0, 0, '');
      Exit;
    end;

    //;
    if Event <> nil then begin
      if Event.m_OwnBaseObject <> nil then begin
        if Event.m_nEventType = ET_FIRE then begin
          if GetTickCount > m_dwFireBurnTick then begin
            if Event.m_OwnBaseObject.IsProperTarget(Self) then begin
              if m_btRaceServer = RC_PLAYOBJECT then m_dwFireBurnTick := GetTickCount + g_Config.nFirePlayDamageTimeRate
              else  m_dwFireBurnTick := GetTickCount + g_Config.nFireMonDamageTimeRate;
              SendMsg(Event.m_OwnBaseObject, RM_MAGSTRUCK_MINE, 0, Event.m_nDamage, 0, 0, '');
            end;
          end;
        end else
        if Event.m_OwnBaseObject.IsProperTarget(Self) then begin
          SendMsg(Event.m_OwnBaseObject, RM_MAGSTRUCK_MINE, 0, Event.m_nDamage, 0, 0, '');
        end;
      end;
    end;
    //非玩家且无火墙不处理地图连接等事件
    if (m_btRaceServer <> RC_PLAYOBJECT) then begin
      SendRefMsg(nIdent, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
      exit;
    end;
    nCheckCode := 4;
    if Result and (GateObj <> nil) and (GateObj.DEnvir <> nil) then begin
      if m_btRaceServer = RC_PLAYOBJECT then begin
        if m_PEnvir.ArroundDoorOpened(m_nCurrX, m_nCurrY) then begin
          OldEnvir := m_PEnvir;
          nOldX := m_nCurrX;
          nOldY := m_nCurrY;
          if EnterAnotherMap(TEnvirnoment(GateObj.DEnvir), GateObj.nDMapX, GateObj.nDMapY) then begin
            if m_SlaveList.Count > 0 then begin
              for I := m_SlaveList.Count - 1 downto 0 do begin
                BaseObject := TBaseObject(m_SlaveList.Items[I]);
                if BaseObject.m_boDeath or BaseObject.m_boGhost or (BaseObject.m_Master <> Self) then begin
                  m_SlaveList.Delete(I);
                  Continue;
                end;
                if (BaseObject.m_btRaceServer = RC_CAMION) and (BaseObject.m_PEnvir = OldEnvir) and
                  (abs(nOldX - BaseObject.m_nCurrX) < 6) and
                  (abs(nOldY - BaseObject.m_nCurrY) < 6) then begin
                  BaseObject.EnterAnotherMap(TEnvirnoment(GateObj.DEnvir), GateObj.nDMapX, GateObj.nDMapY)
                end;
              end;
            end;
          end;
        end else
          Result := False;
      end;
    end
    else begin
      nCheckCode := 5;
      if Result then begin
        nCheckCode := 6;
        SendRefMsg(nIdent, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
        if (MapEvent <> nil) and (m_btRaceServer = RC_PLAYOBJECT) then begin
          if (MapEvent.nRate <= 1) or (Random(MapEvent.nRate) = 0) then begin
            if (MapEvent.nFlag = -1) or (TPlayObject(Self).GetQuestFlagStatus(MapEvent.nFlag) = MapEvent.btValue) then begin
              if (not MapEvent.boGroup) or (m_GroupOwner <> nil) then begin
                //if MapEvent.boEvent then //移动地图事件解发
                NpcGotoLable(g_MapEventNpc, MapEvent.nEvent, False);
              end;
            end;
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg, [nCheckCode, m_sCharName, m_sMapName, m_nCurrX, m_nCurrY]));
      {MainOutMessage('[Exception] TBaseObject.Walk  CheckCode: ' + IntToStr(nCheckCode) + ' ' +
                    m_sCharname + ' ' +
                    m_sMapName + ' ' +
                    IntToStr(m_nCurrX) + ':' +
                    IntToStr(m_nCurrY));}
      MainOutMessage(E.Message);
    end;
  end;
end;

//切换地图

function TBaseObject.EnterAnotherMap(Envir: TEnvirnoment; nDMapX, nDMapY: Integer): Boolean;
var
//  i: Integer;
  MapCellInfo: pTMapCellinfo;
  OldEnvir: TEnvirnoment;
  OldMapName: string;
  nOldX: Integer;
  nOldY: Integer;
  Castle: TUserCastle;
resourcestring
  sExceptionMsg7 = '[Exception] TBaseObject::EnterAnotherMap';
begin
  Result := False;
  if not m_boMapApoise then exit;
{$IFDEF PLUGOPEN}
  if Assigned(zPlugOfEngine.EnterAnotherMap) then begin
    try
      Result := zPlugOfEngine.EnterAnotherMap(Self, Envir, nDMapX, nDMapY);
    except
    end;
  end
  else begin
{$ENDIF}
    try
      if m_btRaceServer = RC_PLAYOBJECT then begin
        with Self as TPlayObject do begin
          if m_boShoping then exit;

          //需要一个洞
          if (Envir.m_boNEEDHOLE) and (g_EventManager.GetEvent(m_PEnvir, m_nCurrX, m_nCurrY, ET_DIGOUTZOMBI) = nil) then
            Exit;

          if Envir.QuestNPC <> nil then NpcGotoLable(TMerchant(Envir.QuestNPC), 0, True);

          if (Envir.nNEEDSETONFlag > 0) and (GetQuestFlagStatus(Envir.nNEEDSETONFlag) <> Envir.nNeedONOFF) then
              Exit;

          if not Envir.GetMapCellInfo(nDMapX, nDMapY, MapCellInfo) then Exit;
          Castle := g_CastleManager.IsCastlePalaceEnvir(Envir);
          if (Castle <> nil) and (not (Castle.CheckInPalace(m_nCurrX, m_nCurrY, Self))) then
              Exit;
        end;
      end;

      OldEnvir := m_PEnvir;
      OldMapName := m_sMapName;
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      DisappearA();
      ClearViewRange;

      m_PEnvir := Envir;
      m_sMapName := Envir.sMapName;
      m_nCurrX := nDMapX;
      m_nCurrY := nDMapY;

      if AddToMap() then begin
{$IF CHANGEMAPMODE = OLDMAPMODE}
        SendMsg(Self, RM_CHANGEMAP, 0, Integer(Envir), 0, 0, g_MapManager.GetMainMap(Envir));
{$ELSE}
        if m_boOldChangeMapMode then SendMsg(Self, RM_CHANGEMAP, 0, Integer(Envir), 0, 0, g_MapManager.GetMainMap(Envir))
        else SendMsg(Self, RM_CHANGEMAP, 0, Integer(OldEnvir), 0, 0, g_MapManager.GetMainMap(Envir));
{$IFEND}
        m_dwMapMoveTick := GetTickCount();
        m_boChangeMap := True;
        Result := True;
        // 2023-12-21 新增：发送队友位置
        TPlayObject(Self).SendGroupMsg(TPlayObject(Self), SM_GROUPINFO1, Integer(Self), 0, 0, 0, 'GROUP_POSITION');
        GetStartType();
        if m_btRaceServer = RC_PLAYOBJECT then
          with Self as TPlayObject do begin
            ClearDare(4);
            m_AttackState := as_None;
            if m_nCheckChangeMapCount < 100 then Inc(m_nCheckChangeMapCount);
          end;

        //刷新人物当前所在位置的状态
      end
      else begin
        m_PEnvir := OldEnvir;
        m_sMapName := OldMapName;
        m_nCurrX := nOldX;
        m_nCurrY := nOldY;
        m_PEnvir.AddToMap(m_nCurrX, m_nCurrY, OS_MOVINGOBJECT, Self);
        GetStartType();
        //刷新人物当前所在位置的状态
      end;
      //复位泡点，及金币，时间
      if m_btRaceServer = RC_PLAYOBJECT then begin
        with Self as TPlayObject do begin
          m_dwAutoGetExpTick := GetTickCount();
          m_dwDecGameGoldTick := GetTickCount();
          m_dwIncGameGoldTick := GetTickCount();
          SafeFillChar(m_nMval, SizeOf(m_nMval), #0);
        end;
      end;
    except
      MainOutMessage(sExceptionMsg7);
    end;
{$IFDEF PLUGOPEN}
  end;
{$ENDIF}
end;

procedure TBaseObject.TurnTo(nDir: Integer);
begin
  m_btDirection := nDir;
  SendRefMsg(RM_TURN, nDir, m_nCurrX, m_nCurrY, 0, '');
end;

procedure TBaseObject.ProcessMonSayMsg(sMsg: string);
var
  sCharName: string;
begin
  if m_btRaceServer = RC_PLAYOBJECT then Exit; //修改
  sCharName := FilterShowName(m_sCharName);
  SendRefMsg(RM_HEAR, 0, g_Config.nHearMsgFColor, g_Config.nHearMsgBColor, 0, sCharName + #9 + sMsg);
end;

procedure TBaseObject.SysHintMsg(sMsg: string; MsgColor: TMsgColor);
begin
  if m_btRaceServer = RC_PLAYOBJECT then begin
    case MsgColor of
      c_Red: SendDefMsg(Self, SM_HINTMSG, g_Config.nHintMsgRColor, 0, 0, 0, sMsg);
      c_Green: SendDefMsg(Self, SM_HINTMSG, g_Config.nHintMsgGColor, 0, 0, 0, sMsg);
      c_White: SendDefMsg(Self, SM_HINTMSG, g_Config.nHintMsgWColor, 0, 0, 0, sMsg);
    end;
    //MakeDefaultMsg(SM_HINTMSG, ProcessMsg.nParam1, 0, 0, 1);
  end;
end;

procedure TBaseObject.SysMsg(sMsg: string; MsgColor: TMsgColor; MsgType: TMsgType);
begin
  if m_btRaceServer <> RC_PLAYOBJECT then Exit;
  if cv_Mir2 in TPlayObject(Self).m_ClientVersion then begin
    case MsgColor of
      c_Green: SendMsg(Self, RM_SYSMESSAGE, 0, g_Config.btGreenMsgFColor, g_Config.btGreenMsgBColor, 0, sMsg);
      c_Blue: SendMsg(Self, RM_SYSMESSAGE, 0, g_Config.btBlueMsgFColor, g_Config.btBlueMsgBColor, 0, sMsg);
    else
      begin
        case MsgType of
          t_Cust: SendMsg(Self, RM_SYSMESSAGE, 0, g_Config.btCustMsgFColor, g_Config.btCustMsgBColor, 0, sMsg);
          t_Cudt: SendMsg(Self, RM_SYSMESSAGE, 0, g_Config.btCudtMsgFColor, g_Config.btCudtMsgBColor, 0, sMsg);
        else
          SendMsg(Self, RM_SYSMESSAGE, 0, g_Config.btRedMsgFColor, g_Config.btRedMsgBColor, 0, sMsg);
        end;
      end;
    end;
  end else begin
    case MsgColor of
      c_Green: SendMsg(Self, RM_SYSMESSAGE, 0, g_Config.nGreenMsgFColor, g_Config.nGreenMsgBColor, 0, sMsg);
      c_Blue: SendMsg(Self, RM_SYSMESSAGE, 0, g_Config.nBlueMsgFColor, g_Config.nBlueMsgBColor, 0, sMsg);
    else begin
        case MsgType of
          t_Cust: SendMsg(Self, RM_SYSMESSAGE, 0, g_Config.nCustMsgFColor, g_Config.nCustMsgBColor, 0, sMsg);
          t_Cudt: SendMsg(Self, RM_SYSMESSAGE, 0, g_Config.nCudtMsgFColor,  g_Config.nCudtMsgBColor, 0, sMsg);
        else
          SendMsg(Self, RM_SYSMESSAGE, 0, g_Config.nRedMsgFColor, g_Config.nRedMsgBColor, 0, sMsg);
        end;
      end;
    end;
  end;
end;

procedure TBaseObject.MenuMsg(sMsg: string);
begin
  SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, sMsg);
end;

procedure TBaseObject.SysDelayMsg(sMsg: string; MsgColor: TMsgColor; MsgType: TMsgType; nDelayTime: LongWord);
begin
  if m_btRaceServer <> RC_PLAYOBJECT then Exit;
  
  if cv_Mir2 in TPlayObject(Self).m_ClientVersion then begin
    case MsgColor of
      c_Green: SendDelayMsg(Self, RM_SYSMESSAGE, 0, g_Config.btGreenMsgFColor, g_Config.btGreenMsgBColor, 0, 0, sMsg, nDelayTime);
      c_Blue: SendDelayMsg(Self, RM_SYSMESSAGE, 0, g_Config.btBlueMsgFColor, g_Config.btBlueMsgBColor, 0, 0, sMsg, nDelayTime);
    else
      begin
        case MsgType of
          t_Cust: SendDelayMsg(Self, RM_SYSMESSAGE, 0, g_Config.btCustMsgFColor, g_Config.btCustMsgBColor, 0,0, sMsg, nDelayTime);
          t_Cudt: SendDelayMsg(Self, RM_SYSMESSAGE, 0, g_Config.btCudtMsgFColor, g_Config.btCudtMsgBColor, 0,0, sMsg, nDelayTime);
        else
          SendDelayMsg(Self, RM_SYSMESSAGE, 0, g_Config.btRedMsgFColor, g_Config.btRedMsgBColor, 0, 0, sMsg, nDelayTime);
        end;
      end;
    end;
  end else begin
    case MsgColor of
      c_Green: SendDelayMsg(Self, RM_SYSMESSAGE, 0, g_Config.nGreenMsgFColor, g_Config.nGreenMsgBColor, 0,0, sMsg, nDelayTime);
      c_Blue: SendDelayMsg(Self, RM_SYSMESSAGE, 0, g_Config.nBlueMsgFColor, g_Config.nBlueMsgBColor, 0,0, sMsg, nDelayTime);
    else begin
        case MsgType of
          t_Cust: SendDelayMsg(Self, RM_SYSMESSAGE, 0, g_Config.nCustMsgFColor, g_Config.nCustMsgBColor, 0,0, sMsg, nDelayTime);
          t_Cudt: SendDelayMsg(Self, RM_SYSMESSAGE, 0, g_Config.nCudtMsgFColor,  g_Config.nCudtMsgBColor, 0,0, sMsg, nDelayTime);
        else
          SendDelayMsg(Self, RM_SYSMESSAGE, 0, g_Config.nRedMsgFColor, g_Config.nRedMsgBColor, 0,0, sMsg, nDelayTime);
        end;
      end;
    end;
  end;
end;

procedure TBaseObject.MonsterSayMsg(AttackBaseObject: TBaseObject; MonStatus:
  TMonStatus);
var
  i: Integer;
  //  nMsgColor: Integer;
  sMsg: string;
  MonSayMsg: pTMonSayMsg;
  sAttackName: string;
begin
  if m_SayMsgList = nil then
    Exit;
  if (m_btRaceServer = RC_PLAYOBJECT) then
    Exit;
  if (AttackBaseObject <> nil) then begin
    if (AttackBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and
      (AttackBaseObject.m_Master = nil) then begin
      Exit;
    end;
    if AttackBaseObject.m_Master <> nil then
      sAttackName := AttackBaseObject.m_Master.m_sCharName
    else
      sAttackName := AttackBaseObject.m_sCharName;
  end;
  for i := 0 to m_SayMsgList.Count - 1 do begin
    MonSayMsg := m_SayMsgList.Items[i];
    if MonSayMsg = nil then
      Continue;
    sMsg := AnsiReplaceText(MonSayMsg.sSayMsg, '%s', FilterShowName(m_sCharName));
    sMsg := AnsiReplaceText(sMsg, '%d', sAttackName);
    if (MonSayMsg.State = MonStatus) and (Random(MonSayMsg.nRate) = 0) then begin
      if MonStatus = s_MonGen then begin
        UserEngine.SendBroadCastMsg(sMsg, t_Mon);
        break;
      end;
      if MonSayMsg.Color = c_White then begin
        ProcessMonSayMsg(sMsg);
      end
      else begin
        AttackBaseObject.SysMsg(sMsg, MonSayMsg.Color, t_Mon);
      end;
      break;
    end;
  end;
end;

//发送队伍消息

procedure TBaseObject.SendGroupText(sMsg: string);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  //sMsg := g_Config.sGroupMsgPreFix + sMsg;
  if m_GroupOwner <> nil then begin
    for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
      PlayObject := TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
      if PlayObject = nil then Continue;
      if not PlayObject.m_boBanGroupChat then Continue;
      PlayObject.SendMsg(Self, RM_GROUPMESSAGE, 0, g_Config.nGroupMsgFColor, g_Config.nGroupMsgBColor, 0, sMsg);
    end;
  end;
end;

procedure TBaseObject.MakeGhost();
begin
  m_boGhost := True;
  m_dwGhostTick := GetTickCount();
  DisappearA();
  ClearViewRange;
end;

procedure TBaseObject.ApplyMeatQuality;
var
  i: Integer;
  StdItem: pTStdItem;
  UserItem: pTUserItem;
begin
  for i := 0 to m_ItemList.Count - 1 do begin
    UserItem := m_ItemList.Items[i];
    if UserItem = nil then Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then begin
      if StdItem.StdMode = tm_Flesh then begin
        UserItem.Dura := m_nMeatQuality;
      end;
    end;
  end;
end;
 {
function TBaseObject.TakeBagItems(BaseObject: TBaseObject): Boolean;
var
  UserItem, AddUserItem: pTUserItem;
  PlayObject: TPlayObject;
  nBack: Integer;
  Stditem: pTStdItem;
begin
  Result := False;
  while (True) do begin
    if BaseObject.m_ItemList.Count <= 0 then
      break;
    UserItem := BaseObject.m_ItemList.Items[0];
    if (UserItem = nil) then
      break;
    nBack := AddItemToBag(UserItem, nil, True, BaseObject.m_sCharName, '挖取', AddUserItem);
    if nBack = -1 then
      break;
    if nBack = 2 then begin
      if m_btRaceServer = RC_PLAYOBJECT then begin
        PlayObject := TPlayObject(Self);
        UserItem.MakeIndex := GetItemNumber(); //怪物爆出物品后再取物品ID,节约物品ID消耗
        PlayObject.SendAddItem(UserItem);
        Stditem := Userengine.GetStdItem(UserItem.wIndex);
        if (Stditem <> nil) and (Stditem.NeedIdentify = 1) then
          AddGameLog(Self, LOG_ADDITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, BaseObject.m_sCharName,
            '0', '0', '挖取', UserItem);
        Result := True;
      end;
    end
    else
      DisPose(UserItem);
    BaseObject.m_ItemList.Delete(0);
  end;
end;     }

procedure TBaseObject.ScatterBagItems(ItemOfCreat: TBaseObject);
var
  i, DropWide: Integer;
  UserItem: pTUserItem;
//  StdItem: pTStdItem;
  //boCanNotDrop: Boolean;
//  MonDrop: pTMonDrop;
  StdItemLimit: pTStdItemLimit;
  SysTime: LongWord;
resourcestring
  sExceptionMsg = '[Exception] TBaseObject::ScatterBagItems';
begin
  if m_boReliveNoDrop then
    exit;
  DropWide := 4;
  try
    SysTime := StrToIntDef(Format('%.4d%.2d%.2d%.2d', [g_wYear, g_wMonth, g_wDay, g_wHour]), 0);
    if m_ItemList <> nil then begin
      for i := m_ItemList.Count - 1 downto 0 do begin
        if m_ItemList.Count <= 0 then break;
        UserItem := m_ItemList.Items[i];
        if UserItem = nil then Continue;
        StdItemLimit := UserEngine.GetStdItemLimit(UserItem.wIndex);
        if (StdItemLimit <> nil) and (StdItemLimit.MonDropLimit <> nil) then begin
          if (SysTime >= StdItemLimit.MonDropLimit.dwTime) then begin
            if (StdItemLimit.MonDropLimit.nMaxCount = 0) or (StdItemLimit.MonDropLimit.nMinCount < StdItemLimit.MonDropLimit.nMaxCount) then begin
              Inc(StdItemLimit.MonDropLimit.nMinCount);
              UserItem.MakeIndex := GetItemNumber(); //怪物爆出物品后再取物品ID,节约物品ID消耗
              DropItemDown(UserItem, DropWide, True, ItemOfCreat, Self);
              g_boSaveMonDropLimit := True;
            end;
          end;
        end else begin
          UserItem.MakeIndex := GetItemNumber(); //怪物爆出物品后再取物品ID,节约物品ID消耗
          DropItemDown(UserItem, DropWide, True, ItemOfCreat, Self);
        end;
        DisPose(UserItem);
      end;
      m_ItemList.Clear;
    end;
  except
    MainOutMessage(sExceptionMsg + ' ' + m_sCharName);
  end;
end;

procedure TBaseObject.ScatterGolds(GoldOfCreat: TBaseObject);
var
  i, nGold: Integer;
begin
  if m_nGold > 0 then begin
    i := 0;
    while (True) do begin
      //      for i:=0 to 18 do begin
      if m_nGold > g_Config.nMonOneDropGoldCount then begin
        nGold := g_Config.nMonOneDropGoldCount;
        m_nGold := m_nGold - g_Config.nMonOneDropGoldCount;
      end
      else begin
        nGold := m_nGold;
        m_nGold := 0;
      end;
      if nGold > 0 then begin
        if not DropGoldDown(nGold, True, GoldOfCreat, Self) then begin
          m_nGold := m_nGold + nGold;
          break;
        end;
      end
      else
        break;
      Inc(i);
      if i >= 17 then
        break;
    end;
    GoldChanged;
  end;
end;

procedure TBaseObject.DropUseItems(BaseObject: TBaseObject);
begin

end;

procedure TBaseObject.Die;
var
  boPK, guildwarkill: Boolean;
  tStr: string;
  tExp: LongWord;
  i, k: Integer;
  GroupHuman: TPlayObject;
  QuestNPC: TMerchant;
  tCheck: Boolean;
  AttackBaseObject: TBaseObject;
  Castle: TUserCastle;
  nCheckCode: Integer;
  MapQuest: pTMapQuestInfo;
  //  n10: Integer;
resourcestring
  sExceptionMsg1 = '[Exception] TBaseObject::Die 1';
  sExceptionMsg2 = '[Exception] TBaseObject::Die 2';
  sExceptionMsg3 = '[Exception] TBaseObject::Die 3 CheckCode:';
begin

  if m_boSuperMan then Exit;
  if m_boSupermanItem then Exit;
{$IFDEF PLUGOPEN}
  if Assigned(zPlugOfEngine.Die) then begin
    try
      if zPlugOfEngine.Die(Self) then
        Exit;
    except
    end;
  end;
{$ENDIF}
  nCheckCode := 0;
  m_boDeath := True;
  m_boOnHorse := False;
  m_boHorseHit := False;
  m_dwDeathTick := GetTickCount();
  //sub_4BC87C();
  if m_Master <> nil then
  begin
    m_ExpHitter := nil;
    m_LastHiter := nil;
  end;
  m_nIncSpell := 0;
  m_nIncHealth := 0;
  m_nIncHealing := 0;
  m_AddHP := 0;
  HintGotoScript(m_nDieScript);
  //2010-02-06 增加，将怪物可爆物品刷新加于死亡函数当中，以节约内存
  if m_boCanGetRandomItems and (m_btRaceServer <> RC_PLAYOBJECT) and (m_CanDropItemList <> nil) then
    UserEngine.MonGetRandomItems(Self, m_CanDropItemList);

  try
    //获取经验
    if (m_btRaceServer <> RC_PLAYOBJECT) and ((m_LastHiter <> nil) or (m_ExpHitter <> nil)) then
    begin
      if (m_ExpHitter <> nil) then
        AttackBaseObject := m_ExpHitter
      else
        AttackBaseObject := m_LastHiter;
      //MainOutMessage(AttackBaseObject.m_sCharName);
      if (AttackBaseObject.m_btRaceServer <> RC_PLAYOBJECT) then begin
        if (AttackBaseObject.m_Master <> nil) and (AttackBaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) then
        begin
          AttackBaseObject.GainSlaveExp(m_Abil.Level);
          AttackBaseObject := AttackBaseObject.m_Master;
        end;
      end;
      if (AttackBaseObject <> nil) and (AttackBaseObject.m_btRaceServer = RC_PLAYOBJECT) then
      begin
        TPlayObject(AttackBaseObject).m_sLastKillMonName := m_sCharName;
        //人物获取经验
        tExp := AttackBaseObject.CalcGetExp(m_Abil.Level, m_dwFightExp);
        if not g_Config.boVentureServer then begin
          TPlayObject(AttackBaseObject).GainExp(tExp);
        end;
        if m_MapQuestList <> nil then begin
          for I := 0 to m_MapQuestList.Count - 1 do begin
            MapQuest := m_MapQuestList[I];
            if (MapQuest <> nil) and (MapQuest.NPC <> nil) and (MapQuest.Envir = m_PEnvir) then
            begin
              tStr := FilterShowName(m_sCharName);
              if MapQuest.boGroup and (AttackBaseObject.m_GroupOwner <> nil) and
                (AttackBaseObject.m_GroupOwner.m_GroupMembers <> nil) then
              begin
                for k := 0 to AttackBaseObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
                  if TBaseObject(AttackBaseObject.m_GroupOwner.m_GroupMembers.Objects[k]).m_btRaceServer = RC_PLAYOBJECT then
                  begin
                    GroupHuman := TPlayObject(AttackBaseObject.m_GroupOwner.m_GroupMembers.Objects[k]);
                    if (AttackBaseObject <> GroupHuman) and (not GroupHuman.m_boDeath) and (not GroupHuman.m_boGhost) and
                      (AttackBaseObject.m_PEnvir = GroupHuman.m_PEnvir) and
                      (abs(AttackBaseObject.m_nCurrX - GroupHuman.m_nCurrX) <= g_Config.nSendRefMsgRange) and
                      (abs(AttackBaseObject.m_nCurrY - GroupHuman.m_nCurrY) <= g_Config.nSendRefMsgRange) and
                      (TPlayObject(GroupHuman).GetQuestFlagStatus(MapQuest.nFlag) = MapQuest.nValue) and
                      (TPlayObject(GroupHuman).GetQuestFlagStatus(MapQuest.nFlag2) = MapQuest.nValue2) then begin
                      TPlayObject(GroupHuman).m_sString[0] := m_sCharName;
                      TPlayObject(GroupHuman).m_nInteger[0] := m_Abil.Level;
                      GroupHuman.NpcGotoLable(MapQuest.NPC, 0, True);
                    end;
                  end;
                end;
              end;
              if (not AttackBaseObject.m_boDeath) and (not AttackBaseObject.m_boGhost) and
                (TPlayObject(AttackBaseObject).GetQuestFlagStatus(MapQuest.nFlag) = MapQuest.nValue) and
                (TPlayObject(AttackBaseObject).GetQuestFlagStatus(MapQuest.nFlag2) = MapQuest.nValue2) then begin
                TPlayObject(AttackBaseObject).m_sString[0] := m_sCharName;
                TPlayObject(AttackBaseObject).m_nInteger[0] := m_Abil.Level;
                AttackBaseObject.NpcGotoLable(MapQuest.NPC, 0, True);
              end;
            end;
          end;
        end;
        if AttackBaseObject.m_MyGuild <> nil then begin //增加行会杀怪数量
          TGuild(AttackBaseObject.m_MyGuild).IncKillMobCount;
        end;
        {执行杀怪触发}
        TPlayObject(AttackBaseObject).KillMonsterFunc(Self);
      end;
    end;
    //怪物说话
    if (g_Config.boMonSayMsg) and (m_btRaceServer = RC_PLAYOBJECT) and (m_LastHiter <> nil) then begin
      m_LastHiter.MonsterSayMsg(Self, s_KillHuman);
    end;

    m_Master := nil;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg1);
      MainOutMessage(E.Message);
    end;
  end;
  
  if (m_LastHiter <> nil) and (m_btRaceServer = RC_PLAYOBJECT) then
    TPlayObject(Self).DieGotoLable();

  try
    boPK := False;
    //判断是否PK(非战斗地图)
    if (m_LastHiter <> nil) then AttackBaseObject := m_LastHiter
    else AttackBaseObject := m_ExpHitter;

    {执行杀人和死亡触发}


    if (not g_Config.boVentureServer) and (not m_PEnvir.m_boFightZone) and (not m_PEnvir.m_boFight3Zone) and (m_btStartType <> OT_SAFEPK) then begin
      if (m_btRaceServer = RC_PLAYOBJECT) and (AttackBaseObject <> nil) and (PKLevel < 2) then begin
        if AttackBaseObject.m_Master <> nil then
          if AttackBaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT then begin
            AttackBaseObject := AttackBaseObject.m_Master;
            boPK := True;
          end;
        //            if (AttackBaseObject.m_btRaceServer = RC_PLAYOBJECT) then
        if (AttackBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (AttackBaseObject.m_btRaceServer = RC_NPC) then begin
          {修改日期2004/07/21，允许NPC杀死人物}
          boPK := True;
        end;

      end;
    end;
    //判断为PK,检测是否行会战争或者攻城战争
    if boPK and (AttackBaseObject <> nil) then begin
      guildwarkill := False;
      if (m_MyGuild <> nil) and (AttackBaseObject.m_MyGuild <> nil) then begin
        if GetGuildRelation(Self, AttackBaseObject) = 2 then //是否行会战争
          guildwarkill := True;
      end;
      Castle := g_CastleManager.InCastleWarArea(Self);
      if ((Castle <> nil) and Castle.m_boUnderWar) or (m_boInFreePKArea) then
        guildwarkill := True; //是否攻城战争
      {
      if UserCastle.m_boUnderWar then
         if (m_boInFreePKArea) or (UserCastle.InCastleWarArea(m_PEnvir, m_nCurrX, m_nCurrY)) then
            guildwarkill := TRUE;
      }
      (*
      if not guildwarkill then begin
         if not m_LastHiter.IsGoodKilling(self) then begin
            m_LastHiter.IncPkPoint (nKillHumanAddPKPoint{100});
            m_LastHiter.SysMsg ('你犯了谋杀罪.', c_Red,t_Hint);
            SysMsg('你被 ' + m_LastHiter.m_sCharName + '杀害了.',c_Red,t_Hint);
            m_LastHiter.AddBodyLuck (-nKillHumanDecLuckPoint{500});
            if PkLevel < 1 then
               if Random(5) = 0 then
                  m_LastHiter.MakeWeaponUnlock;
         end else
            m_LastHiter.SysMsg ('[你受到正当规则保护。]', c_Green,t_Hint);
      end;
      *)
      //=================================================================
      //
      //非允许战争增加PK值
      if not guildwarkill then begin
        //判断是否有PK加等级经验等
        if (g_Config.boKillHumanWinLevel or g_Config.boKillHumanWinExp or m_PEnvir.m_boPKWINLEVEL or m_PEnvir.m_boPKWINEXP) and
          (AttackBaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
          TPlayObject(Self).PKDie(TPlayObject(AttackBaseObject));
        end
        else begin
          if not AttackBaseObject.IsGoodKilling(Self) then begin
            AttackBaseObject.IncPkPoint(g_Config.nKillHumanAddPKPoint {100});
            //增加PK值
            AttackBaseObject.SysMsg(g_sYouMurderedMsg {'你犯了谋杀罪.'}, c_Red, t_Hint);
            SysMsg(format(g_sYouKilledByMsg, [AttackBaseObject.m_sCharName]), c_Red, t_Hint);
            AttackBaseObject.AddBodyLuck(-g_Config.nKillHumanDecLuckPoint {500});
            if PKLevel < 1 then
              if Random(5) = 0 then
                AttackBaseObject.MakeWeaponUnlock; //武器加诅咒
          end
          else
            AttackBaseObject.SysMsg(g_sYouProtectedByLawOfDefense {'[你受到正当规则保护。]'}, c_Green, t_Hint);
        end;
        //检查攻击人是否用了着经验或等级装备
        if AttackBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if AttackBaseObject.m_dwPKDieLostExp > 0 then begin
            if m_Abil.Exp >= AttackBaseObject.m_dwPKDieLostExp then begin
              Dec(m_Abil.Exp, AttackBaseObject.m_dwPKDieLostExp);
            end
            else
              m_Abil.Exp := 0;
          end;
          if AttackBaseObject.m_nPKDieLostLevel > 0 then begin
            if m_Abil.Level >= AttackBaseObject.m_nPKDieLostLevel then begin
              Dec(m_Abil.Level, AttackBaseObject.m_nPKDieLostLevel);
            end
            else
              m_Abil.Level := 0;
          end;
        end;
      end;
      //=================================================================
    end;
  except
    MainOutMessage(sExceptionMsg2);
  end;

  try
    //掉装备处理
    if (m_ExpHitter <> nil) then AttackBaseObject := m_ExpHitter
    else AttackBaseObject := m_LastHiter;

    if (AttackBaseObject <> nil) and (AttackBaseObject.m_Master <> nil) then begin
      AttackBaseObject := AttackBaseObject.m_Master;
    end;

    //非人物处理
    if m_btRaceServer <> RC_PLAYOBJECT then begin
      nCheckCode := 1000;
      if AttackBaseObject <> nil then
        DropUseItems(AttackBaseObject);
      nCheckCode := 1001;
      if (m_Master = nil) and (AttackBaseObject <> nil) then
        ScatterBagItems(AttackBaseObject);
      nCheckCode := 1002;
      if (AttackBaseObject <> nil) and (m_Master = nil) then begin
        if (AttackBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (g_Config.boDropGoldToPlayBag) then begin
          if TPlayObject(AttackBaseObject).IncGold(m_nGold) then begin
            nCheckCode := 1003;
            TPlayObject(AttackBaseObject).GoldChanged();
            nCheckCode := 1004;
          end
          else begin
            ScatterGolds(AttackBaseObject);
            nCheckCode := 1005;
          end;
        end
        else begin
          ScatterGolds(AttackBaseObject);
          nCheckCode := 1006;
        end;
      end;
    end
    else begin
      {修改日期2004/07/21，增加此行，允许设置 m_boNoItem 后人物死亡不掉物品}
      //人物处理
      if (not m_PEnvir.m_boFightZone) and (not m_PEnvir.m_boFight3Zone) and (m_btStartType <> OT_SAFEPK) and (not m_boNoItem)
        and (not TPlayObject(Self).m_boSafeOffLine) then begin
        if AttackBaseObject <> nil then begin
          if (g_Config.boKillByHumanDropUseItem and (AttackBaseObject.m_btRaceServer = RC_PLAYOBJECT)) or
            (g_Config.boKillByMonstDropUseItem and (AttackBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and
            ((AttackBaseObject.m_Master = nil) or ((AttackBaseObject.m_Master <> nil) and (AttackBaseObject.m_Master.m_btRaceServer <> RC_PLAYOBJECT)))) or
            (g_Config.boKillByHumanDropUseItem and (AttackBaseObject.m_Master <> nil) and (AttackBaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT)) then
            nCheckCode := 1007;
          DropUseItems(AttackBaseObject);
          nCheckCode := 1008;
        end;
        {else begin
          nCheckCode := 1009;
          DropUseItems(nil);
          nCheckCode := 1010;
        end;   }
        nCheckCode := 1011;
        if g_Config.boDieScatterBag then
          ScatterBagItems(nil);
        if g_Config.boDieDropGold then
          ScatterGolds(nil);
        nCheckCode := 1012;
      end;
      AddBodyLuck(-(50 - (50 - m_Abil.Level * 5)));
      nCheckCode := 1013;
    end;
    //end;
    //掉装备处理结束

    //是否行会战争地图
    if m_PEnvir.m_boFight3Zone then begin
      Inc(m_nFightZoneDieCount);
      if m_MyGuild <> nil then begin
        nCheckCode := 1014;
        TGuild(m_MyGuild).TeamFightWhoDead(m_sCharName);
        nCheckCode := 1015;
      end;
      if (m_LastHiter <> nil) then begin
        if (m_LastHiter.m_MyGuild <> nil) and (m_MyGuild <> nil) then begin
          TGuild(m_LastHiter.m_MyGuild).TeamFightWhoWinPoint(m_LastHiter.m_sCharName, 100);
            //matchpoint 刘啊, 俺牢己利 扁废
          tStr := TGuild(m_LastHiter.m_MyGuild).m_sGuildName + ':' +
            IntToStr(TGuild(m_LastHiter.m_MyGuild).m_nContestPoint) + '  ' +
            TGuild(m_MyGuild).m_sGuildName + ':' +
            IntToStr(TGuild(m_MyGuild).m_nContestPoint);
          UserEngine.CryCry(RM_CRY, m_PEnvir, m_nCurrX, m_nCurrY, 1000, '- ' + tStr);
        end;
      end;
    end;

    if m_btRaceServer = RC_PLAYOBJECT then begin
      if m_LastHiter <> nil then begin
        if m_LastHiter.m_btRaceServer = RC_PLAYOBJECT then
          tStr := m_LastHiter.m_sCharName
        else
          tStr := '#' + m_LastHiter.m_sCharName;
      end
      else
        tStr := '####';
      if g_boGameLogHumanDie then
        AddGameLog(Self, LOG_PLAYDIE, '0', 0, 0, tStr,
          'FZ-' + BoolToIntStr(m_PEnvir.m_boFightZone), 'F3Z-' + BoolToIntStr(m_PEnvir.m_boFight3Zone), '死亡', nil);
    end;
    //减少地图上怪物计数
    if (m_Master = nil) and (not m_boDelFormMaped) then begin
      nCheckCode := 1016;
      m_PEnvir.DelObjectCount(Self);
      m_boDelFormMaped := True;
      nCheckCode := 1017;
    end;
    SendRefMsg(RM_DEATH, m_btDirection, m_nCurrX, m_nCurrY, 1, '');
  except
    MainOutMessage(sExceptionMsg3 + IntToStr(nCheckCode));
  end;
end;

procedure TBaseObject.ReAlive;
begin
  m_dwPKTick := 0;
  m_boDeath := False;
  SendRefMsg(RM_ALIVE, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;

procedure TBaseObject.SetLastHiter(BaseObject: TBaseObject);
begin
  m_LastHiter := BaseObject;
  m_LastHiterTick := GetTickCount();
  if m_ExpHitter = nil then begin
    m_ExpHitter := BaseObject;
    m_ExpHitterTick := GetTickCount();
  end
  else begin
    if m_ExpHitter = BaseObject then
      m_ExpHitterTick := GetTickCount();
  end;
end;

procedure TBaseObject.SetPKFlag(BaseObject: TBaseObject);
begin
  if (BaseObject <> nil) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (TPlayObject(BaseObject).m_AttackState = as_Dare) then
    Exit;
  
  if (PKLevel < 2) and
    (BaseObject.PKLevel < 2) and
    (not m_PEnvir.m_boFightZone) and
    (not m_PEnvir.m_boFight3Zone) and
    (not m_boPKFlag) then begin

    BaseObject.m_dwPKTick := GetTickCount();
    if not BaseObject.m_boPKFlag then begin
      BaseObject.m_boPKFlag := True;
      BaseObject.RefNameColor();
    end;
  end;
end;
    {
procedure TBaseObject.sub_4BC87C;
var
  i: Integer;
begin
  for i := 0 to LIst_3EC.Count - 1 do begin

  end;
  LIst_3EC.Clear;
end;       }

function TBaseObject.IsGoodKilling(Cert: TBaseObject): Boolean;
begin
  Result := False;
  if Cert.m_boPKFlag then
    Result := True;
end;

function TBaseObject.IsProtectTarget(BaseObject: TBaseObject): Boolean;
begin
  Result := True;
  if BaseObject = nil then
    Exit;
  if (InSafeZone) or (BaseObject.InSafeZone) then
    Result := False;
  if not BaseObject.m_boInFreePKArea then begin
    //新人保护
    if g_Config.boPKLevelProtect then begin
      if (m_Abil.Level > g_Config.nPKProtectLevel) then begin //如果大于指定等级
        if not BaseObject.m_boPKFlag and (BaseObject.m_Abil.Level <=
          g_Config.nPKProtectLevel) and (BaseObject.PKLevel < 2) then begin
          //被攻击的人物小指定等级没有红名，则不可以攻击。
          Result := False;
          Exit;
        end;
      end;
      if (m_Abil.Level <= g_Config.nPKProtectLevel) then begin //如果小于指定等级
        if not BaseObject.m_boPKFlag and (BaseObject.m_Abil.Level >
          g_Config.nPKProtectLevel) and (BaseObject.PKLevel < 2) then begin
          Result := False;
          Exit;
        end;
      end;
    end;

    {
    //大于指定级别的红名人物不可以杀指定级别未红名的人物。
    if (PKLevel >= 2) and (m_Abil.Level > 10) then begin
      if (BaseObject.m_Abil.Level <= 10) and (BaseObject.PKLevel < 2) then begin
        Result:=False;
        exit;
      end;
    end;

    //小于指定级别的非红名人物不可以杀指定级别红名人物。
    if (m_Abil.Level <= 10) and (PKLevel < 2) then begin
      if (BaseObject.PKLevel >= 2) and (BaseObject.m_Abil.Level > 10) then begin
        Result:=False;
        exit;
      end;
    end;
    }
    //大于指定级别的红名人物不可以杀指定级别未红名的人物。
    if (PKLevel >= 2) and (m_Abil.Level > g_Config.nRedPKProtectLevel) then begin
      if (BaseObject.m_Abil.Level <= g_Config.nRedPKProtectLevel) and
        (BaseObject.PKLevel < 2) then begin
        Result := False;
        Exit;
      end;
    end;

    //小于指定级别的非红名人物不可以杀指定级别红名人物。
    if (m_Abil.Level <= g_Config.nRedPKProtectLevel) and (PKLevel < 2) then begin
      if (BaseObject.PKLevel >= 2) and (BaseObject.m_Abil.Level >
        g_Config.nRedPKProtectLevel) then begin
        Result := False;
        Exit;
      end;
    end;

    if (GetTickCount - m_dwMapMoveTick < 3000) or (GetTickCount - BaseObject.m_dwMapMoveTick < 3000) then
      Result := False;
  end;
end;

function TBaseObject.IsAttackTarget(BaseObject: TBaseObject): Boolean;
  function sub_4C88E4(): Boolean;
  begin
    Result := True;
  end;
var
  I: Integer;
begin
  Result := False;
  if (BaseObject = nil) or (BaseObject = Self) then
    Exit;
  if m_btRaceServer >= RC_ANIMAL {50} then begin
    if m_Master <> nil then begin
      if (m_Master.m_LastHiter = BaseObject) or
        (m_Master.m_ExpHitter = BaseObject) or
        (m_Master.m_TargetCret = BaseObject) then
        Result := True; {宝宝攻击}

      if BaseObject.m_TargetCret <> nil then begin
        if (BaseObject.m_TargetCret = m_Master) or
          (BaseObject.m_TargetCret.m_Master = m_Master) and
          (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) then
          Result := True;
      end;

      if (BaseObject.m_TargetCret = Self) and (BaseObject.m_btRaceServer >= RC_ANIMAL) then
        Result := True;

      if BaseObject.m_Master <> nil then begin
        if (BaseObject.m_Master = m_Master.m_LastHiter) or (BaseObject.m_Master
          = m_Master.m_TargetCret) then
          Result := True;
      end;

      if BaseObject.m_Master = m_Master then
        Result := False; {检测是自己的宝宝}

      if BaseObject.m_boHolySeize then
        Result := False;

      if m_Master.m_boSlaveRelax then
        Result := False;

      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin {检测目标是人物}
        //if (m_Master.InSafeZone) or (BaseObject.InSafeZone) then begin
        if BaseObject.InSafeZone then
          Result := False;
      end;
      BreakCrazyMode();
    end
    else begin
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
        Result := True;
      if (m_btRaceServer > RC_PEACENPC {15}) and (m_btRaceServer < RC_ANIMAL{50}) then
        Result := True;
      if (BaseObject.m_Master <> nil) and (BaseObject.m_btRaceServer <> RC_CAMION) then
        Result := True;
    end;
    if m_boCrazyMode then
      Result := True;
  end
  else begin
    if m_btRaceServer = RC_PLAYOBJECT then begin {增加分身检测}
      case m_btAttatckMode of
        HAM_ALL {0}: begin
            if (BaseObject.m_btRaceServer < RC_NPC {10}) or
              (BaseObject.m_btRaceServer > RC_PEACENPC {15}) then
              Result := True;
            if g_Config.boNonPKServer then
              Result := sub_4C88E4();
          end;
        HAM_PEACE {1}: begin
            if BaseObject.m_btRaceServer >= RC_ANIMAL then
              Result := True;
          end;
        HAM_DEAR: begin
            if BaseObject <> TPlayObject(Self).m_DearHuman then begin
              Result := True;
            end;
          end;
        HAM_MASTER: begin
            Result := True;
            with TPlayObject(Self) do begin
              if m_MasterList.Count > 0 then begin
                if m_boMaster then begin
                  for I := 0 to m_MasterList.Count - 1 do begin
                    if m_MasterList.Objects[I] = BaseObject then begin
                      Result := False;
                      break;
                    end;
                  end;
                end else begin
                  if m_MasterList.Objects[0] = BaseObject then
                    Result := False;
                end;
              end;
            end;
          end;
        HAM_GROUP {2}: begin
            if (BaseObject.m_btRaceServer < RC_NPC) or (BaseObject.m_btRaceServer > RC_PEACENPC) then
              Result := True;
            if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
              if (m_GroupOwner <> nil) and (m_GroupOwner = BaseObject.m_GroupOwner) then
                Result := False;
            if g_Config.boNonPKServer then
              Result := sub_4C88E4();
          end;
        HAM_GUILD {3}: begin
            if (BaseObject.m_btRaceServer < RC_NPC) or (BaseObject.m_btRaceServer > RC_PEACENPC) then
              Result := True;
            if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
              if m_MyGuild <> nil then begin
                //if TGuild(m_MyGuild).IsMember(BaseObject.m_sCharName) then
                if m_MyGuild = BaseObject.m_MyGuild then
                  Result := False;
                if m_boGuildWarArea and (BaseObject.m_MyGuild <> nil) then begin
                  if TGuild(m_MyGuild).IsAllyGuild(TGuild(BaseObject.m_MyGuild)) then
                    Result := False;
                end;
              end;
            end else begin
              if (m_MyGuild <> nil) and (BaseObject.m_Castle <> nil) and
                (TUserCastle(BaseObject.m_Castle).m_MasterGuild = m_MyGuild) then
                Result := False;
            end;
            if g_Config.boNonPKServer then
              Result := sub_4C88E4();
          end;
        HAM_PKATTACK {4}: begin
            if (BaseObject.m_btRaceServer < RC_NPC) or (BaseObject.m_btRaceServer > RC_PEACENPC) then
              Result := True;
            if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
              if PKLevel >= 2 then begin
                if BaseObject.PKLevel < 2 then
                  Result := True
                else
                  Result := False;
              end
              else begin
                if BaseObject.PKLevel >= 2 then
                  Result := True
                else
                  Result := False;
              end;
            if g_Config.boNonPKServer then
              Result := sub_4C88E4();
          end;
      end;
    end
    else
      Result := True;
  end;
  if BaseObject.m_boAdminMode or BaseObject.m_boStoneMode then
    Result := False;
end;

function TBaseObject.IsProperTarget(BaseObject: TBaseObject): Boolean;
begin
  if m_AttackState = as_Dare then begin
    Result := False;
    if BaseObject <> nil then begin
      if (m_btRaceServer = RC_PLAYOBJECT) and (TPlayObject(Self).m_DareObject = BaseObject) then
        Result := True;
    end;
    Exit;
  end;
  if m_AttackState = as_Close then begin
    Result := False;
    Exit;
  end;
  if (BaseObject <> nil) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (TPlayObject(BaseObject).m_boSafeOffLine or (TPlayObject(BaseObject).m_AttackState = as_Close) or (TPlayObject(BaseObject).m_AttackState = as_Dare)) then begin
    Result := False;
    Exit;
  end;
  Result := IsAttackTarget(BaseObject);
  if Result then begin
    if (m_btRaceServer = RC_PLAYOBJECT) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      Result := IsProtectTarget(BaseObject);
      {检测人物是否符合攻击要求}
    end;
  end;
  if Result then begin
    if (BaseObject <> nil) and
      (m_btRaceServer = RC_PLAYOBJECT) and
      (BaseObject.m_Master <> nil) and
      (BaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
      if BaseObject.m_Master = Self then begin
        if m_btAttatckMode <> HAM_ALL {0} then
          Result := False; {检测是否是自己的宝宝}
      end
      else begin
        if InSafeZone or BaseObject.InSafeZone then
          Result := False {检测是否是在安全区}
        else
          Result := IsAttackTarget(BaseObject.m_Master);
      end;
    end else
    if (BaseObject <> nil) and (BaseObject.m_btRaceServer = RC_CAMION) and (BaseObject.m_Master = nil) then begin
      if InSafeZone or BaseObject.InSafeZone then
        Result := False; {检测是否是在安全区}
    end;
  end;

end;

//擒龙手目标检测

function TBaseObject.IsProperTargetSKILL_55(nLevel: Integer; BaseObject:
  TBaseObject): Boolean;
begin
  Result := False;
  if (BaseObject = nil) or (BaseObject = Self) then
    Exit;
  if (BaseObject.m_btRaceServer < RC_NPC) or (BaseObject.m_btRaceServer > RC_PEACENPC) then begin
    if (BaseObject.m_btRaceServer <> RC_GUARD) and
      (BaseObject.m_btRaceServer <> 55) and
      (BaseObject.m_btRaceServer <> RC_BOX) and
      (BaseObject.m_btRaceServer <> RC_ARCHERGUARD) and
      (BaseObject.m_btRaceServer <> 110) and
      (BaseObject.m_btRaceServer <> 111) and
      (nLevel >= BaseObject.m_Abil.Level) and
      (not BaseObject.m_boGhost) and
      (not BaseObject.m_boDeath) then begin
      if ((not g_Config.boPullPlayObject) or (nLevel < BaseObject.m_Abil.Level)) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then
        Exit;
      if g_Config.boPullCrossInSafeZone and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and BaseObject.InSafeZone then
        Exit;
      if g_Config.boPullCrossInSafeZone and (BaseObject.m_Master <> nil) and (BaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) and BaseObject.InSafeZone then
        Exit;
      Result := True;
    end;
  end;
end;

//移行换位

function TBaseObject.IsProperTargetSKILL_56(BaseObject: TBaseObject; nTargetX,
  nTargetY: Integer): Boolean;
begin
  Result := False;
  if (BaseObject <> nil) or (m_PEnvir = nil) then
    Exit;
  if m_PEnvir.CanWalk(nTargetX, nTargetY, True) then begin
    Result := True;
  end;
end;

//骷髅咒

function TBaseObject.IsProperTargetSKILL_54(BaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if (BaseObject = nil) or (BaseObject = Self) then
    Exit;
  if BaseObject.m_boDeath and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    if (BaseObject.m_btRaceServer < RC_NPC) or (BaseObject.m_btRaceServer >
      RC_PEACENPC) then begin
      if (BaseObject.m_btRaceServer <> RC_GUARD) and
        (BaseObject.m_btRaceServer <> RC_ARCHERGUARD) and
        (BaseObject.m_btRaceServer <> 110) and
        (BaseObject.m_btRaceServer <> 111) then
        Result := True;
    end;
  end;
end;

//复活术

function TBaseObject.IsProperTargetSKILL_57(BaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if (BaseObject = nil) or (BaseObject = Self) then
    Exit;
  if BaseObject.m_boDeath and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    if TPlayObject(BaseObject).m_boAllowReAlive then
      Result := True
    else
      SysMsg('对方禁止复活.', c_Green, t_Hint);
  end;
end;

procedure TBaseObject.MeltTargetAll;
{var
  I: Integer;
  List10: TList;
  BaseObject: TBaseObject;   }
begin
{  if (m_PEnvir = nil) or (not m_PEnvir.m_boFB) or m_boGhost or m_boDeath or m_boStoneMode or m_boFixedHideMode then exit;
  if (not m_boMeltTarget) and (m_TargetCret <> nil) then begin
    m_boMeltTarget := True;
    if m_boMission then begin
      List10 := TList.Create;
      GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 8, List10);
      for I := 0 to List10.Count - 1 do begin
        BaseObject := TBaseObject(List10.Items[I]);
        if (BaseObject <> nil) and (BaseObject.m_TargetCret = nil) and (not BaseObject.m_boMeltTarget) then begin
          BaseObject.m_boMeltTarget := True;
          BaseObject.SetTargetCreat(m_TargetCret);
        end;
      end; // for
      List10.Free;
    end;
  end else
  if (m_boMeltTarget) and (m_TargetCret = nil) then begin
    if m_boMission then begin
      List10 := TList.Create;
      GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 8, List10);
      for I := 0 to List10.Count - 1 do begin
        BaseObject := TBaseObject(List10.Items[I]);
        if (BaseObject <> nil) and BaseObject.m_boMeltTarget then begin
          BaseObject.m_boMeltTarget := False;
          BaseObject.SetTargetCreat(nil);
          BaseObject.m_btDirection := BaseObject.m_btMissionDir;
          if (BaseObject.m_nMissionX > 0) and (BaseObject.m_nMissionY > 0) and
            ((BaseObject.m_nCurrX <> BaseObject.m_nMissionX) or (BaseObject.m_nCurrY <> BaseObject.m_nMissionY)) then
            BaseObject.SpaceMove(BaseObject.m_PEnvir, BaseObject.m_nMissionX, BaseObject.m_nMissionY, 0);
        end;
      end; // for
      List10.Free;
    end;
    m_boMeltTarget := False;
  end;    }
end;

procedure TBaseObject.SendAbility;
begin
  if m_btRaceServer <> RC_PLAYOBJECT then exit;
  with Self as TPlayObject do begin
    m_WAbil.Exp := m_Abil.Exp;
    m_WAbil.MaxExp := m_Abil.MaxExp;
    SendDefSocket(Self, SM_ABILITY, m_nGold, MakeWord(m_btJob, 99), m_nBindGold, 0, EncodeBuffer(@m_WAbil, SizeOf(m_WAbil)));
  end;
end;

procedure TBaseObject.SendSubAbility;
var
  ClientAppendSubAbility: TClientAppendSubAbility;
begin
  if m_btRaceServer <> RC_PLAYOBJECT then exit;
  SafeFillChar(ClientAppendSubAbility, SizeOf(ClientAppendSubAbility), #0);
  ClientAppendSubAbility.nParam1 := MakeLong(MakeWord(m_btAddWuXinAttack, m_btDelWuXinAttack), MakeWord(m_btDeadliness, 0));
  ClientAppendSubAbility.nParam2 := TPlayObject(Self).m_nGameGird;
  ClientAppendSubAbility.nParam3 := TPlayObject(Self).m_CustomVariable[0];
  SendDefSocket(Self, SM_SUBABILITY, MakeLong(MakeWord(m_nAntiMagic, m_btWuXin), MakeWord(m_btAddAttack, m_btDelDamage)),
                 MakeLong(MakeWord(m_btHitPoint, 0), MakeWord(m_btSpeedPoint, 0)),
                 MakeLong(MakeWord(m_btAntiPoison, 0), MakeWord(m_nPoisonRecover, 0)),
                 MakeLong(MakeWord(m_nHealthRecover, 0), MakeWord(m_nSpellRecover, 0)),
    EncodeBuffer(@ClientAppendSubAbility, SizeOf(ClientAppendSubAbility)));
end;

function TBaseObject.InSafeZone: Boolean;
{var
  i,  nSafeX, nSafeY: Integer;
  sMapName: string;
  StartPoint: pTStartPoint;    }
var
  i: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  if m_PEnvir = nil then begin //修正机器人刷火墙的错误 叶随风飘
    Result := True;
    Exit;
  end;
  if m_btRaceServer = RC_PLAYOBJECT then begin
    Result := m_PEnvir.m_boSAFE or (m_btStartType = OT_SAFEAREA);
  end else begin
    Result := m_PEnvir.m_boSAFE;
    if not Result then begin
      if m_PEnvir.GetMapCellInfo(m_nCurrX, m_nCurrY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[i];
          if OSObject.btType = OS_SAFEAREA then begin
            Result := True;
            break;
          end;
        end;
      end;
    end;
  end;

  {if not Result then begin
    if (m_PEnvir.sMapName = g_Config.sRedHomeMap) and
      (abs(m_nCurrX - g_Config.nRedHomeX) <= g_Config.nSafeZoneSize) and
      (abs(m_nCurrY - g_Config.nRedHomeY) <= g_Config.nSafeZoneSize) then begin
      Result := True;
    end;
  end;  }
end;

function TBaseObject.InSafeZone(Envir: TEnvirnoment; nX, nY: Integer): Boolean;
var

  {, nSafeX, nSafeY: Integer;
  sMapName: string;
  StartPoint: pTStartPoint;}
  i: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  bo1D: Boolean;
begin
  if Envir = nil then begin //修正机器人刷火墙的错误
    Result := True;
    Exit;
  end;
  Result := Envir.m_boSAFE;
  {if not Result then begin
    if (Envir.sMapName = g_Config.sRedHomeMap) and
      (abs(nX - g_Config.nRedHomeX) <= g_Config.nSafeZoneSize) and
      (abs(nY - g_Config.nRedHomeY) <= g_Config.nSafeZoneSize) then begin
      Result := True;
    end;
  end;  }
  try
    if not Result then begin
      bo1D := Envir.GetMapCellInfo(nX, nY, MapCellInfo);
      if bo1D and (MapCellInfo.ObjList <> nil) then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[i];
          if OSObject.btType = OS_SAFEAREA then begin
            Result := True;
            break;
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(E.Message);
      MainOutMessage('[Exception] TBaseObject.InSafeZone');
    end;
  end;
end;

{function TBaseObject.InSafeZone: Boolean;
var
  i, nSafePoint, nSafeX, nSafeY: Integer;
  sMapName: string;
  StartPoint: pTStartPoint;
  nStartX,nStartY:Integer;
  nEndX,nEndY:Integer;
begin
  Result := m_PEnvir.m_boSAFE;
  if Result then Exit;
  if (m_PEnvir.sMapName <> g_Config.sRedHomeMap) or
    (abs(m_nCurrX - g_Config.nRedHomeX) > g_Config.nSafeZoneSize) or
    (abs(m_nCurrY - g_Config.nRedHomeY) > g_Config.nSafeZoneSize) then begin
    Result := False;
  end else begin
    Result := True;
  end;
  if Result then Exit;
  try
    g_StartPointList.Lock;
    for i := 0 to g_StartPointList.Count - 1 do begin
      sMapName := g_StartPointList.Strings[i];
      if (sMapName = m_PEnvir.sMapName) then begin
        StartPoint := pTStartPoint(g_StartPointList.Objects[i]);
        if StartPoint <> nil then begin
          nStartX:=StartPoint.m_nCurrX - StartPoint.m_nRange;
          nEndX:=StartPoint.m_nCurrX + StartPoint.m_nRange;
          nStartY:=StartPoint.m_nCurrY - StartPoint.m_nRange;
          nEndY:=StartPoint.m_nCurrY - StartPoint.m_nRange;
          if (m_nCurrX in [nStartX..nEndX]) and (m_nCurrY in [nStartY..nEndY]) then begin
            Result := True;
            break;
          end;
        end;
      end;
    end;
  finally
    g_StartPointList.UnLock;
  end;
end;

function TBaseObject.InSafeZone(Envir: TEnvirnoment; nX,
  nY: Integer): Boolean;
var
  i, nSafePoint, nSafeX, nSafeY: Integer;
  sMapName: string;
  StartPoint: pTStartPoint;
begin
  Result := Envir.m_boSAFE;
  if Result then Exit;
  if (Envir.sMapName <> g_Config.sRedHomeMap) or
    (abs(nX - g_Config.nRedHomeX) > g_Config.nSafeZoneSize) or
    (abs(nY - g_Config.nRedHomeY) > g_Config.nSafeZoneSize) then begin
    Result := False;
  end else begin
    Result := True;
  end;
  if Result then Exit;
  try
    g_StartPointList.Lock;
    for i := 0 to g_StartPointList.Count - 1 do begin
      sMapName := g_StartPointList.Strings[i];
      if (sMapName = Envir.sMapName) then begin
        StartPoint := pTStartPoint(g_StartPointList.Objects[i]);
        if StartPoint <> nil then begin
          nSafeX := StartPoint.m_nCurrX;
          nSafeY := StartPoint.m_nCurrY;
          if (abs(nX - nSafeX) <= g_Config.nSafeZoneSize) and
            (abs(nY - nSafeY) <= g_Config.nSafeZoneSize) then begin
            Result := True;
            break;
          end;
        end;
      end;
    end;
  finally
    g_StartPointList.UnLock;
  end;
end; }

procedure TBaseObject.OpenHolySeizeMode(dwInterval: LongWord);
begin
  m_dwHolySeizeTick := GetTickCount();
  m_dwHolySeizeInterval := dwInterval;
  if not m_boHolySeize then begin
    m_boHolySeize := True;
    RefNameColor();
  end;
end;

procedure TBaseObject.BreakHolySeizeMode;
begin
  if m_boHolySeize then begin
    m_boHolySeize := False;
    RefNameColor();
  end;
  //m_boHolySeize := False;
  //RefNameColor();
end;

procedure TBaseObject.OpenCrazyMode(nTime: Integer);
begin
  m_dwCrazyModeTick := GetTickCount();
  m_dwCrazyModeInterval := nTime * 1000;
  if not m_boCrazyMode then begin
    m_boCrazyMode := True;
    RefNameColor();
  end;
end;

procedure TBaseObject.BreakCrazyMode;
begin
  if m_boCrazyMode then begin
    m_boCrazyMode := False;
    RefNameColor();
  end;
end;
//离开队伍

procedure TBaseObject.LeaveGroup;
begin
  //SendGroupText(m_sCharName + ' 退出小组.');

  SendDefMsg(Self, SM_GROUPCANCEL, 0, 0, 0, 0, '');
  if m_btRaceServer = RC_PLAYOBJECT then begin
    TPlayObject(Self).SendGroupMsg(TPlayObject(Self), SM_GROUPDELMEM_OK, Integer(Self), 0, 0, 0, m_sCharName);
    m_GroupOwner := nil;
    TPlayObject(Self).RefGroupWuXin(Self);
  end;
  m_GroupOwner := nil;
end;

procedure TBaseObject.AttackJump;
var
  nIndex: Integer;
begin
  if (m_btRaceServer = RC_PLAYOBJECT) and (g_FunctionNPC <> nil) and (m_PEnvir.m_sHitMonLabel <> '') then
  begin
    nIndex := g_FunctionNPC.GetScriptIndex(m_PEnvir.m_sHitMonLabel);
    g_FunctionNPC.GotoLable(TPlayObject(Self), nIndex, False, '');
  end;
end;

procedure TBaseObject.TrainSkill(UserMagic: pTUserMagic; nTranPoint: Integer);
begin
  if m_boFastTrain then
    nTranPoint := nTranPoint * 3;
  Inc(UserMagic.nTranPoint, nTranPoint);
end;

function TBaseObject.CheckMagicLevelup(UserMagic: pTUserMagic): Boolean;
//004C7054
var
  n10: Integer;
begin
  Result := False;
  if (UserMagic.MagicInfo.btTrainLv <= 9) and (UserMagic.btLevel <= UserMagic.MagicInfo.btTrainLv) then
    n10 := UserMagic.btLevel
  else
    n10 := 0;

  if (UserMagic.MagicInfo.btTrainLv > UserMagic.btLevel) and
    (UserMagic.MagicInfo.MaxTrain[n10] <= UserMagic.nTranPoint) then begin

    if (UserMagic.MagicInfo.btTrainLv > UserMagic.btLevel) then begin
      Dec(UserMagic.nTranPoint, UserMagic.MagicInfo.MaxTrain[n10]);
      Inc(UserMagic.btLevel);
      SendUpdateDelayDefMsg(Self, SM_MAGIC_LVEXP, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel,
                             UserMagic.nTranPoint, 0, '', 800);
      sub_4C713C(UserMagic);
    end
    else begin
      UserMagic.nTranPoint := UserMagic.MagicInfo.MaxTrain[n10];
    end;
    Result := True;
  end;
end;

procedure TBaseObject.SetTargetCreat(BaseObject: TBaseObject);
begin
  m_TargetCret := BaseObject;
  m_dwTargetFocusTick := GetTickCount();
end;

procedure TBaseObject.DelTargetCreat();
begin
  m_TargetCret := nil;
end;

function TBaseObject._Attack(var wHitMode: Word; AttackTarget: TBaseObject): Boolean;
var
  nPower: Integer;
  n20: Integer;
  nCheckCode: Integer;
resourcestring
  sExceptionMsg = '[Exception] TBaseObject::_Attack Name:= %s Code:=%d';
begin
  Result := False;
  if AttackTarget = nil then Exit;
  nCheckCode := 0;
  try
    nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
    nCheckCode := 4;
    if IsProperTarget(AttackTarget) then begin
      nCheckCode := 41;
      if (Random(AttackTarget.m_btSpeedPoint) >= m_btHitPoint) then begin
        nCheckCode := 42;
        nPower := 0;
      end;
      nCheckCode := 43;
    end
    else
      nPower := 0;
    nCheckCode := 5;
    if nPower > 0 then begin
      nPower := AttackTarget.GetHitStruckDamage(Self, nPower);
    end;
    nCheckCode := 600;
    if nPower > 0 then begin
      nCheckCode := 601;
      AttackTarget.StruckDamage(nPower, Self);
      nCheckCode := 602;
      AttackTarget.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, AttackTarget.m_WAbil.HP,
        AttackTarget.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
      nCheckCode := 603;

      //麻痹
      if not AttackTarget.m_boUnParalysis and m_boParalysis and
        (Random(AttackTarget.m_btAntiPoison + g_Config.nAttackPosionRate {5}) = 0) then
      begin
        nCheckCode := 604;
        AttackTarget.MakePosion(POISON_STONE, g_Config.nAttackPosionTime {5}, 0);
      end;
      nCheckCode := 605;
      //虹魔，吸血
      if m_nHongMoSuite > 0 then begin
        m_db3B0 := nPower / 1.E2 * m_nHongMoSuite;
        if m_db3B0 >= 2.0 then begin
          n20 := Trunc(m_db3B0);
          m_db3B0 := n20;
          DamageHealth(-n20);
        end;
      end;

      nCheckCode := 8;
      Result := True;
    end;
    nCheckCode := 9;
    if (AttackTarget.m_btRaceServer <> RC_PLAYOBJECT) then
      AttackTarget.SendMsg(AttackTarget, RM_STRUCK, nPower,
        AttackTarget.m_WAbil.HP, AttackTarget.m_WAbil.MaxHP, Integer(Self), '');
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg, [m_sCharName, nCheckCode]));
      MainOutMessage(E.Message)
    end;
  end;
end;      

procedure TBaseObject.SendAttackMsg(wIdent, wSendIdent: Integer; btDir: Byte; nX, nY: Integer);
begin
  SendRefMsg(wIdent, btDir, nX, nY, wSendIdent, '');
end;

function TBaseObject.GetHitStruckDamage(Target: TBaseObject; nDamage: Integer):
  Integer;
var
  n14: Integer;
  nMagLevel: Integer;
  nRate: Integer;
begin
  m_boUseGodShield := False;
  if LoWord(m_WAbil.AC) > HiWord(m_WAbil.AC) then n14 := LoWord(m_WAbil.AC)
  else n14 := LoWord(m_WAbil.AC) + Random(SmallInt(HiWord(m_WAbil.AC) - LoWord(m_WAbil.AC)) + 1);
  nDamage := _MAX(0, nDamage - n14);
  {if (m_btLifeAttrib = LA_UNDEAD) and (Target <> nil) then begin
    Inc(nDamage, Target.m_AddAbil.bt1DF);
  end; }
  if (nDamage > 0) and m_boAbilMagBubbleDefence then begin
    nDamage := ROUND((nDamage / 1.0E2) * (m_btMagBubbleDefenceLevel + 2) * 8.0);
    DamageBubbleDefence(nDamage);
  end;
  if m_btRaceServer = RC_PLAYOBJECT then
  begin
    with Self as TPlayObject do begin
      if (nDamage > 0) and (m_MagicArr[SKILL_GODSHIELD] <> nil) then begin
        case m_MagicArr[SKILL_GODSHIELD].btLevel of
          1: begin
              nMagLevel := g_Config.nProtectShieldRunRate1;
              nRate := g_Config.nProtectShieldDelDamage1;
            end;
          2: begin
              nMagLevel := g_Config.nProtectShieldRunRate2;
              nRate := g_Config.nProtectShieldDelDamage2;
            end;
          3: begin
              nMagLevel := g_Config.nProtectShieldRunRate3;
              nRate := g_Config.nProtectShieldDelDamage3;
            end;
          else begin
              nMagLevel := g_Config.nProtectShieldRunRate0;
              nRate := g_Config.nProtectShieldDelDamage0;
            end;
        end;
        //g_Config.nProtectShieldRunRate0
        if Random(100) < nMagLevel then begin
          m_boUseGodShield := True;
          nDamage := nDamage - ROUND(nRate / 100 * nDamage);
          if nDamage <= 0 then
            nDamage := 1;
        end;
      end;
    end;
  end;
  Result := nDamage;
  if (Result > 0) and Assigned(Target) and Assigned(Target.m_Master) then
    Self.SetLastHiter(Target.m_Master);
end;

function TBaseObject.GetMagStruckDamage(BaseObject: TBaseObject; nDamage: Integer): Integer;
var
  n14: Integer;
  nMagLevel: Integer;
  nRate: Integer;
begin
  m_boUseGodShield := False;
  if LoWord(m_WAbil.MAC) > HiWord(m_WAbil.MAC) then n14 := LoWord(m_WAbil.MAC)
  else n14 := LoWord(m_WAbil.MAC) + Random(SmallInt(HiWord(m_WAbil.MAC) - LoWord(m_WAbil.MAC)) + 1);
  nDamage := _MAX(0, nDamage - n14);
  {if (m_btLifeAttrib = LA_UNDEAD) and (BaseObject <> nil) then begin
    Inc(nDamage, m_AddAbil.bt1DF);
  end; }
  if (nDamage > 0) and m_boAbilMagBubbleDefence then begin
    nDamage := ROUND((nDamage / 1.0E2) * (m_btMagBubbleDefenceLevel + 2) * 8.0);
    DamageBubbleDefence(nDamage);
  end;
  if m_btRaceServer = RC_PLAYOBJECT then begin
    with Self as TPlayObject do begin
      if (nDamage > 0) and (m_MagicArr[SKILL_GODSHIELD] <> nil) then begin
        case m_MagicArr[SKILL_GODSHIELD].btLevel of
          1: begin
              nMagLevel := g_Config.nProtectShieldRunRate1;
              nRate := g_Config.nProtectShieldDelDamage1;
            end;
          2: begin
              nMagLevel := g_Config.nProtectShieldRunRate2;
              nRate := g_Config.nProtectShieldDelDamage2;
            end;
          3: begin
              nMagLevel := g_Config.nProtectShieldRunRate3;
              nRate := g_Config.nProtectShieldDelDamage3;
            end;
          else begin
              nMagLevel := g_Config.nProtectShieldRunRate0;
              nRate := g_Config.nProtectShieldDelDamage0;
            end;
        end;
        //g_Config.nProtectShieldRunRate0
        if Random(100) < nMagLevel then begin
          m_boUseGodShield := True;
          nDamage := nDamage - ROUND(nRate / 100 * nDamage);
          if nDamage < 0 then
            nDamage := 1;
        end;
      end;
    end;
  end
  else if IsMonster() then
  begin
    if g_Config.nMagicAttackMonsteRate > 0 then
      nDamage := Round(nDamage * g_Config.nMagicAttackMonsteRate / 100);
  end;
  Result := nDamage;
  if (Result > 0) and Assigned(BaseObject) and Assigned(BaseObject.m_Master) then
    Self.SetLastHiter(BaseObject.m_Master);
end;

procedure TBaseObject.StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);
var
  i: Integer;
  nDam: Integer;
  nDura, nOldDura: Integer;
  PlayObject: TPlayObject;
  StdItem: pTStdItem;
  bo19, bo20: Boolean;
  AddRate: integer;
  UserItem: TUserItem;
  UserMagic: pTUserMagic;
//  nDander: Word;
begin
  if m_boUseGodShield then
  begin
    if m_btRaceServer = RC_PLAYOBJECT then
    begin
      PlayObject := TPlayObject(Self);
      UserMagic := PlayObject.GetMagicInfo(SKILL_GODSHIELD);
      if Assigned(UserMagic) and (UserMagic.MagicInfo.btTrainLv <=9) and (UserMagic.btLevel < UserMagic.MagicInfo.btTrainLv) then begin
        if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] <= PlayObject.m_Abil.Level then begin
          PlayObject.TrainSkill(UserMagic, Random(3) + 1);
          if not PlayObject.CheckMagicLevelup(UserMagic) then begin
            PlayObject.SendDelayDefMsg(PlayObject, SM_MAGIC_LVEXP, UserMagic.MagicInfo.wMagicId,
              UserMagic.btLevel, UserMagic.nTranPoint, 0, '', 1000);
          end;
        end;
      end;
    end;
    SendRefMsg(RM_SHOWEFFECT, EFFECT_SHIELD, Integer(Self), m_nCurrX, m_nCurrY, '');
  end;
  m_boUseGodShield := False;
  if nDamage <= 0 then Exit;
  nDam := Random(10) + 5;
  if m_wStatusTimeArr[POISON_DAMAGEARMOR {1 0x62}] > 0 then begin
    nDam := ROUND(nDam * (g_Config.nPosionDamagarmor / 10) {1.2});
    nDamage := ROUND(nDamage * (g_Config.nPosionDamagarmor / 10) {1.2});
  end;
  
  AddRate := 0;
  if AttackBase.m_btRaceServer = RC_PLAYOBJECT then begin
    Inc(AddRate, AttackBase.m_btAddAttack);  //人物攻击方计算伤害加成
    if (m_btRaceServer <> RC_PLAYOBJECT) then begin  //人物攻击怪物增加行会伤害加成
      if (AttackBase.m_MyGuild <> nil) and (TGuild(AttackBase.m_MyGuild).btLevel > 0) then begin
        if (m_Master = nil) or ((m_Master <> nil) and (m_Master.m_btRaceServer <> RC_PLAYOBJECT)) then
          Inc(AddRate, TGuild(AttackBase.m_MyGuild).m_btKillMonAttackRate);  //人物攻击方计算伤害加成
      end;
    end;
  end;

  //人物被攻击方计算伤害吸收
  if m_btRaceServer = RC_PLAYOBJECT then Dec(AddRate, m_btDelDamage);

  if (not g_Config.boCloseWuXin) and (AttackBase.m_btWuXin <> 0) and (m_btWuXin <> 0) and CheckWuXinRestraint(AttackBase.m_btWuXin, m_btWuXin) then
  begin

    if (m_btRaceServer = RC_PLAYOBJECT) and (AttackBase.m_btRaceServer = RC_PLAYOBJECT) then begin
      //人物攻击人物
      if (AttackBase.m_btAddWuXinAttack > m_btDelWuXinAttack) then
        Inc(AddRate, AttackBase.m_btAddWuXinAttack - m_btDelWuXinAttack);
    end else
    if (m_btRaceServer <> RC_PLAYOBJECT) and (AttackBase.m_btRaceServer = RC_PLAYOBJECT) then begin
      //人物攻击怪物
      Inc(AddRate, AttackBase.m_btAddWuXinAttack);
    end else
    if (m_btRaceServer = RC_PLAYOBJECT) and (AttackBase.m_btRaceServer <> RC_PLAYOBJECT) then begin
      //怪物攻击人物
      if (m_btDelWuXinAttack < 100) then Inc(AddRate, 100 - m_btDelWuXinAttack);
    end;
  end;

  if AddRate <> 0 then begin
    if AddRate > 80 then AddRate := 80
    else if AddRate < -80 then AddRate := -80;
    if AddRate > 0 then nDamage := Round(nDamage + (nDamage * (AddRate / 100)))
    else nDamage := Round(nDamage - (nDamage * (abs(AddRate) / 100)));
  end;
  
  bo19 := False;
  bo20 := False;
  if m_btRaceServer = RC_PLAYOBJECT then begin
    if m_boOnHorse and (m_UseItems[U_House].wIndex > 0) then begin
      for I := Low(m_UseItems[U_House].HorseItems) to High(m_UseItems[U_House].HorseItems) do begin
        if (m_UseItems[U_House].HorseItems[I].wIndex > 0) and (Random(10) = 0) then begin
          nDura := m_UseItems[U_House].HorseItems[I].Dura;
          nOldDura := ROUND(nDura / 1000);
          Dec(nDura, nDam);
          if nDura <= 0 then begin
            StdItem := UserEngine.GetStdItem(m_UseItems[U_House].HorseItems[I].wIndex);
            if (Stditem <> nil) and (StdItem.NeedIdentify = 1) then begin
              UserItem := HorseItemToUserItem(@m_UseItems[U_House].HorseItems[I], StdItem);
              AddGameLog(Self, LOG_DELITEM, Stditem.Name, UserItem.MakeIndex, 0, '0', '0', '马牌', '持久', @UserItem);
            end;
            m_UseItems[U_House].HorseItems[I].wIndex := 0;
            TPlayObject(Self).SendUpdateItem(@m_UseItems[U_House]);
            bo19 := True;
          end
          else begin
            m_UseItems[U_House].HorseItems[I].Dura := nDura;
            if nOldDura <> ROUND(nDura / 1000) then begin
              DuraChange(16 + i, m_UseItems[U_House].HorseItems[I].Dura, m_UseItems[U_House].HorseItems[I].Dura);
            end;
          end;
        end;
      end;
    end else begin
      for i := Low(THumanUseItems) to High(THumanUseItems) do begin
        if (m_UseItems[i].wIndex > 0) and (Random(10) = 0) and
          (sm_Arming in UserEngine.GetStdItemModeEx(m_UseItems[i].wIndex)) then begin

          nDura := m_UseItems[i].Dura;
          nOldDura := ROUND(nDura / 1000);
          Dec(nDura, nDam);
          if nDura <= 0 then begin
            PlayObject := TPlayObject(Self);
            PlayObject.SendDelItems(@m_UseItems[i]);
            StdItem := UserEngine.GetStdItem(m_UseItems[i].wIndex);
            if (Stditem <> nil) and (StdItem.NeedIdentify = 1) then
              AddGameLog(Self, LOG_DELITEM, Stditem.Name, m_UseItems[i].MakeIndex, 0, '0', '0', '0', '持久', @m_UseItems[i]);
            if (i = U_DRESS) or (i = U_WEAPON) then begin
              bo20 := True;
            end;
            m_UseItems[i].wIndex := 0;
            m_UseItems[i].Dura := 0;
            bo19 := True;
          end
          else begin
            m_UseItems[i].Dura := nDura;
            if nOldDura <> ROUND(nDura / 1000) then begin
              DuraChange(i, m_UseItems[i].Dura, m_UseItems[i].DuraMax);
            end;
          end;
        end;
      end;
    end;
  end;
  if bo19 then begin
    RecalcAbilitys();
  end;
  if bo20 then
    FeatureChanged();
  if nDamage > 0 then DamageHealth(nDamage)
  else nDamage := 0;
end;

function TBaseObject.GeTBaseObjectInfo(): string;
begin
  Result := m_sCharName + ' ' +
    '地图:' + m_sMapName + '(' + m_PEnvir.sMapDesc + ') ' +
    '座标:' + IntToStr(m_nCurrX) + '/' + IntToStr(m_nCurrY) + ' ' +
    '等级:' + IntToStr(m_Abil.Level) + ' ' +
    '经验:' + IntToStr(m_Abil.Exp) + ' ' +
    '生命值:' + IntToStr(m_WAbil.HP) + '-' + IntToStr(m_WAbil.MaxHP) + ' ' +
    '魔法值:' + IntToStr(m_WAbil.MP) + '-' + IntToStr(m_WAbil.MaxMP) + ' ' +
    '攻击力:' + IntToStr(LoWord(m_WAbil.DC)) + '-' + IntToStr(HiWord(m_WAbil.DC)) + ' ' +
    '魔法力:' + IntToStr(LoWord(m_WAbil.MC)) + '-' + IntToStr(HiWord(m_WAbil.MC)) + ' ' +
    '道术:' + IntToStr(LoWord(m_WAbil.SC)) + '-' + IntToStr(HiWord(m_WAbil.SC)) + ' ' +
    '防御力:' + IntToStr(LoWord(m_WAbil.AC)) + '-' + IntToStr(HiWord(m_WAbil.AC)) + ' ' +
    '魔防力:' + IntToStr(LoWord(m_WAbil.MAC)) + '-' + IntToStr(HiWord(m_WAbil.MAC)) + ' ' +
    '准确:' + IntToStr(m_btHitPoint) + ' ' +
    '敏捷:' + IntToStr(m_btSpeedPoint);
end;

function TBaseObject.GetBackPosition(var nX, nY: Integer): Boolean;
var
  Envir: TEnvirnoment;
begin
  Envir := m_PEnvir;
  nX := m_nCurrX;
  nY := m_nCurrY;
  case m_btDirection of
    DR_UP: if nY < (Envir.m_nHeight - 1) then
        Inc(nY);
    DR_DOWN: if nY > 0 then
        Dec(nY);
    DR_LEFT: if nX < (Envir.m_nWidth - 1) then
        Inc(nX);
    DR_RIGHT: if nX > 0 then
        Dec(nX);
    DR_UPLEFT: begin
        if (nX < (Envir.m_nWidth - 1)) and (nY < (Envir.m_nHeight - 1)) then begin
          Inc(nX);
          Inc(nY);
        end;
      end;
    DR_UPRIGHT: begin
        if (nX < (Envir.m_nWidth - 1)) and (nY > 0) then begin
          Dec(nX);
          Inc(nY);
        end
      end;
    DR_DOWNLEFT: begin
        if (nX > 0) and (nY < (Envir.m_nHeight - 1)) then begin
          Inc(nX);
          Dec(nY);
        end;
      end;
    DR_DOWNRIGHT: begin
        if (nX > 0) and (nY > 0) then begin
          Dec(nX);
          Dec(nY);
        end;
      end;
  end;
  Result := True;
end;

function TBaseObject.MakePosion(nType, nTime, nPoint: Integer): Boolean;
var
  nOldCharStatus: Integer;
begin
  Result := False;
  if nType < MAX_STATUS_ATTRIBUTE then begin
    nOldCharStatus := m_nCharStatus;
    m_dwStatusArrTick[nType] := GetTickCount();
    m_btGreenPoisoningPoint := nPoint;
    if m_wStatusTimeArr[nType] > 0 then begin
      if m_wStatusTimeArr[nType] < nTime then begin
        m_wStatusTimeArr[nType] := nTime;
        if nType = POISON_DECHEALTH then ChangeStatusMode(STATUS_DECHEALTH, True);
        if nType = POISON_DAMAGEARMOR then ChangeStatusMode(STATUS_DAMAGEARMOR, True);
        if nType = POISON_STONE then ChangeStatusMode(STATUS_STONE, True);
        if nType = POISON_COBWEB then ChangeStatusMode(STATUS_COBWEB, True);
      end;
    end
    else begin //004C35FF
      m_wStatusTimeArr[nType] := nTime;
      if nType = POISON_DECHEALTH then ChangeStatusMode(STATUS_DECHEALTH, True);
      if nType = POISON_DAMAGEARMOR then ChangeStatusMode(STATUS_DAMAGEARMOR, True);
      if nType = POISON_STONE then ChangeStatusMode(STATUS_STONE, True);
      if nType = POISON_COBWEB then ChangeStatusMode(STATUS_COBWEB, True);
    end;
    m_nCharStatus := GetCharStatus();
    if nOldCharStatus <> m_nCharStatus then
      StatusChanged();
    if m_btRaceServer = RC_PLAYOBJECT then begin
      SysMsg(sYouPoisoned {中毒了.}, c_Red, t_Hint);
    end;
    Result := True;
  end;
end;

function TBaseObject.sub_4C5370(nX, nY: Integer; nRange: Integer; var nDX, nDY:
  Integer): Boolean; //004C5370
var
  i: Integer;
  ii: Integer;
  III: Integer;
begin
  Result := False;
  if m_PEnvir.GetMovingObject(nX, nY, True) = nil then begin
    Result := True;
    nDX := nX;
    nDY := nY;
  end;
  if not Result then begin
    for i := 1 to nRange do begin
      for ii := -i to i do begin
        for III := -i to i do begin
          nDX := nX + III;
          nDY := nY + ii;
          if m_PEnvir.GetMovingObject(nDX, nDY, True) = nil then begin
            Result := True;
            break;
          end;
        end;
        if Result then
          break;
      end;
      if Result then
        break;
    end;
  end;
  if not Result then begin
    nDX := nX;
    nDY := nY;
  end;
end;

function TBaseObject.GetBagitem(nMakeIndex: Integer; boDelete: Boolean = False): pTUserItem;
var
  i: Integer;
  UserItem: pTUserItem;
begin
  Result := nil;
  for i := m_ItemList.Count - 1 downto 0 do begin
    if m_ItemList.Count <= 0 then break;
    UserItem := m_ItemList.Items[i];
    if (UserItem.MakeIndex = nMakeIndex) then begin
      Result := UserItem;
      if boDelete then
        m_ItemList.Delete(i);
      break;
    end;
  end;
end;

function TBaseObject.DelBagItem(nIndex: Integer): Boolean;
begin
  Result := False;
  if (nIndex < 0) or (nIndex >= m_ItemList.Count) then
    Exit;
  if pTUserItem(m_ItemList.Items[nIndex]) <> nil then begin
    DisPose(pTUserItem(m_ItemList.Items[nIndex]));
    m_ItemList.Delete(nIndex);
    Result := True;
  end;
end;

function TBaseObject.DelBagItem(nItemIndex: Integer;
  sItemName: string): Boolean;
var
  i: Integer;
  UserItem: pTUserItem;
begin
  Result := False;
  for i := m_ItemList.Count - 1 downto 0 do begin
    if m_ItemList.Count <= 0 then
      break;
    UserItem := m_ItemList.Items[i];
    if (UserItem.MakeIndex = nItemIndex) and
      (CompareText(UserEngine.GetStdItemName(UserItem.wIndex), sItemName) = 0) then begin
      DisPose(UserItem);
      m_ItemList.Delete(i);
      Result := True;
      break;
    end;
  end;
  {if Result then
    WeightChanged();  }
end;
{
function TBaseObject.DelBagItem(UserItem: pTUserItem): Boolean;
var
  i: Integer;
  Item: pTUserItem;
begin
  Result := False;
  for i := m_ItemList.Count - 1 downto 0 do begin
    if m_ItemList.Count <= 0 then
      break;
    Item := m_ItemList.Items[i];
    if Item = nil then
      Continue;
    if UserItem.wIndex = Item.wIndex then begin
      DisPose(Item);
      m_ItemList.Delete(i);
      Result := True;
      break;
    end;
  end;
  {if Result then
    WeightChanged();   
end;     }

function TBaseObject.sub_4C3538: Integer;
var
  nC, n10: Integer;
begin
  Result := 0;
  nC := -1;
  while (nC <> 2) do begin
    n10 := -1;
    while (n10 <> 2) do begin
      if not m_PEnvir.CanWalk(m_nCurrX + nC, m_nCurrY + n10, False) then begin
        if (nC <> 0) or (n10 <> 0) then
          Inc(Result);
      end;
      Inc(n10);
    end;
    Inc(nC);
  end;
end;

function TBaseObject.CheckItems(sItemName: string): pTUserItem; //004C4AB0
var
  i: Integer;
  UserItem: pTUserItem;
begin
  Result := nil;
  for i := 0 to m_ItemList.Count - 1 do begin
    UserItem := m_ItemList.Items[i];
    if CompareText(UserEngine.GetStdItemName(UserItem.wIndex), sItemName) = 0 then begin
      Result := UserItem;
      break;
    end;
  end; // for
end;

procedure TBaseObject.ClearBagItem();
var
  i: Integer;
begin
  for I := 0 to m_ItemList.Count - 1 do begin
    Dispose(pTUserItem(m_ItemList.Items[i]));
  end;
  m_ItemList.Clear;
end;
 {
function TBaseObject.IsStorage(): Boolean;
begin
  Result := m_StorageItemList.Count < MAXSTORAGEITEMS;
end;    }

function TBaseObject.sub_4C4CD4(sItemName: string; var nCount: Integer): pTUserItem;
var
  i: Integer;
  sName: string;
begin
  Result := nil;
  nCount := 0;
  for i := Low(THumanUseItems) to High(THumanUseItems) do begin
    sName := UserEngine.GetStdItemName(m_UseItems[i].wIndex);
    if CompareText(sName, sItemName) = 0 then begin
      Result := @m_UseItems[i];
      Inc(nCount);
    end;
  end;
end;

function TBaseObject.DefenceUp(nSec: Integer): Boolean;
begin
  Result := False;
  if m_wStatusTimeArr[STATE_DEFENCEUP {0x72}] > 0 then begin
    if m_wStatusTimeArr[STATE_DEFENCEUP {0x72}] < nSec then begin
      m_wStatusTimeArr[STATE_DEFENCEUP {0x72}] := nSec;
      Result := True;
      ChangeStatusMode(STATUS_AC, True);
    end;
  end
  else begin
    m_wStatusTimeArr[STATE_DEFENCEUP {0x72}] := nSec;
    Result := True;
    ChangeStatusMode(STATUS_AC, True);
  end;
  m_dwStatusArrTick[STATE_DEFENCEUP {0x20C}] := GetTickCount;
  if m_boAC then
    SysMsg(format(g_sDefenceUpTime, [nSec]), c_Green, t_Hint)
  else
    SysMsg(format(g_sDefenceDownTime, [nSec]), c_Green, t_Hint);
  //SysMsg('防御力增加' + IntToStr(nSec) + '秒',c_Green,t_Hint);
  RecalcAbilitys();
  SendAbility;
end;

function TBaseObject.MagDefenceUp(nSec: Integer): Boolean;
begin
  Result := False;
  if m_wStatusTimeArr[STATE_MAGDEFENCEUP] > 0 then begin
    if m_wStatusTimeArr[STATE_MAGDEFENCEUP] < nSec then begin
      m_wStatusTimeArr[STATE_MAGDEFENCEUP] := nSec;
      Result := True;
      ChangeStatusMode(STATUS_MAC, True);
    end;
  end
  else begin
    m_wStatusTimeArr[STATE_MAGDEFENCEUP] := nSec;
    Result := True;
    ChangeStatusMode(STATUS_MAC, True);
  end;
  m_dwStatusArrTick[STATE_MAGDEFENCEUP] := GetTickCount;
  if m_boMAC then
    SysMsg(format(g_sMagDefenceUpTime, [nSec]), c_Green, t_Hint)
  else
    SysMsg(format(g_sMagDefenceDownTime, [nSec]), c_Green, t_Hint);
  //  SysMsg('抗魔法力增加' + IntToStr(nSec) + '秒',c_Green,t_Hint);
  //m_WABil.MP := 10;
  RecalcAbilitys();
  SendAbility;
end;

//魔法盾

function TBaseObject.MagBubbleDefenceUp(nLevel, nSec: Integer; nType: Byte): Boolean;
var
  nOldStatus: Integer;
begin
  Result := False;
  if m_wStatusTimeArr[nType {0x76}] <> 0 then Exit;
  nOldStatus := m_nCharStatus;
  m_wStatusTimeArr[nType {0x76}] := nSec;
  m_dwStatusArrTick[nType {0x214}] := GetTickCount();
  m_nCharStatus := GetCharStatus();
  if nOldStatus <> m_nCharStatus then begin
    StatusChanged();
  end;
  m_boAbilMagBubbleDefence := True;
  m_btMagBubbleDefenceLevel := nLevel;
  Result := True;
end;

function TBaseObject.MagShieldDefenceUp(nLevel, nSec: Integer; nType: Byte): Boolean;
var
  nOldStatus: Integer;
begin
  Result := False;
  if m_wStatusTimeArr[nType {0x76}] <> 0 then
    Exit;
  nOldStatus := m_nCharStatus;
  m_wStatusTimeArr[nType {0x76}] := nSec;
  m_dwStatusArrTick[nType {0x214}] := GetTickCount();
  m_nCharStatus := GetCharStatus();
  if nOldStatus <> m_nCharStatus then begin
    StatusChanged();
  end;
  m_boAbilMagShieldDefence := True;
  m_btMagShieldDefenceLevel := nLevel;
  Result := True;
end;

function TBaseObject.MagMakeDefenceArea(nX, nY, nRange, nSec, nMagID: Integer;
  btState: Byte; boState: Boolean): Integer;
var
  III: Integer;
  i, ii: Integer;
  nStartX, nStartY, nEndX, nEndY: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := 0;
  nStartX := nX - nRange;
  nEndX := nX + nRange;
  nStartY := nY - nRange;
  nEndY := nY + nRange;
  for i := nStartX to nEndX do begin
    for ii := nStartY to nEndY do begin
      if m_PEnvir.GetMapCellInfo(i, ii, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for III := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[III];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) then begin
              if IsProperFriend(BaseObject) then begin
                if btState = 0 then begin
                  BaseObject.m_boAC := boState;
                  BaseObject.DefenceUp(nSec);
                end
                else begin
                  BaseObject.m_boMC := boState;
                  BaseObject.MagDefenceUp(nSec);
                end;
                Inc(Result);
                BaseObject.MagicQuest(Self, nMagID, mfs_TagEx);
              end
            end;
          end;
        end;
      end;
    end;
  end;
end;

  {诅咒术}
function TBaseObject.MagMakeAbilityArea(nX, nY, nRange, nSec, nMagID: Integer;
  btState: Byte; boState: Boolean): Integer;
var
  III: Integer;
  i, ii: Integer;
  nStartX, nStartY, nEndX, nEndY: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := 0;
  nStartX := nX - nRange;
  nEndX := nX + nRange;
  nStartY := nY - nRange;
  nEndY := nY + nRange;
  for i := nStartX to nEndX do begin
    for ii := nStartY to nEndY do begin
      if m_PEnvir.GetMapCellInfo(i, ii, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for III := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[III];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) then begin
              if IsProperTarget(BaseObject) then begin
                case btState of
                  0: begin
                     case BaseObject.m_btJob of
                       0: begin
                           if BaseObject.m_wStatusArrValue[0 {0x218}] = 0 then
                             BaseObject.m_wStatusArrValue[0 {0x218}] := MakeLong(LoWord(BaseObject.m_WAbil.DC), HiWord(BaseObject.m_WAbil.DC) - 10 - (nSec div BaseObject.m_Abil.Level));
                           BaseObject.m_boDC := boState;
                         end;
                       1: begin
                           if BaseObject.m_wStatusArrValue[1 {0x218}] = 0 then
                             BaseObject.m_wStatusArrValue[1 {0x218}] := MakeLong(LoWord(BaseObject.m_WAbil.MC), HiWord(BaseObject.m_WAbil.MC) - 10 - (nSec div BaseObject.m_Abil.Level));
                           BaseObject.m_boMC := boState;
                         end;
                       2: begin
                           if BaseObject.m_wStatusArrValue[2 {0x218}] = 0 then
                             BaseObject.m_wStatusArrValue[2 {0x218}] := MakeLong(LoWord(BaseObject.m_WAbil.SC), HiWord(BaseObject.m_WAbil.SC) - 10 - (nSec div BaseObject.m_Abil.Level));
                           BaseObject.m_boSC := boState;
                         end;
                     end;
                   end;
                end;
                BaseObject.MagicQuest(Self, nMagID, mfs_TagEx);
                BaseObject.MagChangeAbility(nSec, btState);
                Inc(Result);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TBaseObject.MagChangeAbility(nSec: Integer; btState: Byte): Boolean;
var
  bo06: Boolean;
begin
  bo06 := False;
  Result := False;
  case btState of
    0: begin
        if m_wStatusArrValue[0 {0x218}] > 0 then begin
          m_dwStatusArrTimeOutTick[0 {0x220}] := GetTickCount + LongWord(nSec * 1000);
          if m_boDC then
            SysMsg('攻击力增加' + IntToStr(nSec) + '秒', c_Green, t_Hint)
          else
            SysMsg('攻击力减少' + IntToStr(nSec) + '秒', c_Green, t_Hint);
          ChangeStatusMode(STATUS_DC, True);
          bo06 := True;
        end;
        if m_wStatusArrValue[1 {0x219}] > 0 then begin
          m_dwStatusArrTimeOutTick[1 {0x224}] := GetTickCount + LongWord(nSec * 1000);
          if m_boMC then
            SysMsg('魔法力增加' + IntToStr(nSec) + '秒', c_Green, t_Hint)
          else
            SysMsg('魔法力减少' + IntToStr(nSec) + '秒', c_Green, t_Hint);
          ChangeStatusMode(STATUS_MC, True);
          bo06 := True;
        end;
        if m_wStatusArrValue[2 {0x21A}] > 0 then begin
          m_dwStatusArrTimeOutTick[2 {0x228}] := GetTickCount + LongWord(nSec * 1000);
          if m_boSC then
            SysMsg('道术增加' + IntToStr(nSec) + '秒', c_Green, t_Hint)
          else
            SysMsg('道术减少' + IntToStr(nSec) + '秒', c_Green, t_Hint);
          ChangeStatusMode(STATUS_SC, True);
          bo06 := True;
        end;
      end;
  end;
  if bo06 then begin
    RecalcAbilitys();
    SendAbility;
    Result := True;
  end;
end;

function TBaseObject.MagCanMoveTarget(nX, nY: Integer): Boolean;
var
  n20, n14, n18, nSX, nSY, nTX, nTY: Integer;
  Flag: TWalkFlagArr;
begin
  Result := False;
  n20 := abs(nX - m_nCurrX) + abs(nY - m_nCurrY);
  nSX := m_nCurrX;
  nSY := m_nCurrY;
  n18 := m_btDirection;
  n14 := 0;
  Flag := [];
  if g_Config.boSkill70RunHum then Flag := Flag + [wf_Hum];
  if g_Config.boSkill70RunMon then Flag := Flag + [wf_Mon];
  if g_Config.boSkill70RunNpc then Flag := Flag + [wf_Npc];
  if g_Config.boSkill70RunGuard then Flag := Flag + [wf_Guard];
  if g_Config.boSkill70WarDisHumRun then Flag := Flag + [wf_War];
  while (n14 <= g_Config.nSendRefMsgRange) do begin
    n18 := GetNextDirection(nSX, nSY, nX, nY);
    if m_PEnvir.GetNextPosition(nSX, nSY, n18, 1, nTX, nTY) and m_PEnvir.CanWalkEx(nTX, nTY, Flag) then begin
      nSX := nTX;
      nSY := nTY;
      if (nTX = nX) and (nTY = nY) then begin
        Break;
      end else
      if (abs(nX - nTX) + abs(nY - nTY)) > n20 then begin
        break;
      end;
    end else begin
      Break;
    end;
  end;
  if (nSX <> m_nCurrX) or (nSY <> m_nCurrY) then begin
    if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nSX, nSY, True) > 0 then begin
      m_nCurrX := nSX;
      m_nCurrY := nSY;
      m_btDirection := n18;
      GetStartType();
      Result := True;
    end;
  end;
end;

function TBaseObject.MagCanHitTarget(nX, nY: Integer; TargeTBaseObject: TBaseObject): Boolean;
var
  n14, n18, n1C, n20: Integer;
begin
  Result := False;
  if TargeTBaseObject = nil then  Exit;
  n20 := abs(nX - TargeTBaseObject.m_nCurrX) + abs(nY - TargeTBaseObject.m_nCurrY);
  n14 := 0;
  while (n14 < 13) do begin
    n18 := GetNextDirection(nX, nY, TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);
    if m_PEnvir.GetNextPosition(nX, nY, n18, 1, nX, nY) and m_PEnvir.sub_4B5FC8(nX, nY) then begin
      if (nX = TargeTBaseObject.m_nCurrX) and (nY = TargeTBaseObject.m_nCurrY) then begin
        Result := True;
        break;
      end
      else begin
        n1C := abs(nX - TargeTBaseObject.m_nCurrX) + abs(nY - TargeTBaseObject.m_nCurrY);
        if n1C > n20 then begin
          Result := True;
          break;
        end;
        //        n1C := n20;
      end;
    end
    else begin
      break;
    end;
    Inc(n14);
  end;
end;

function TBaseObject.IsProperFriend(BaseObject: TBaseObject): Boolean;
  function IsFriend(cret: TBaseObject): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if cret.m_btRaceServer = RC_PLAYOBJECT then begin //措惑捞 荤恩牢 版快父
      case m_btAttatckMode of
        HAM_ALL: Result := True;
        HAM_PEACE: Result := True;
        HAM_DEAR: begin
            if (Self = cret) or (cret = TPlayObject(Self).m_DearHuman) then begin
              Result := True;
            end;
          end;
        HAM_MASTER: begin
            if (Self = cret) then begin
              Result := True;
            end else begin
              with TPlayObject(Self) do begin
                if m_MasterList.Count > 0 then begin
                  if m_boMaster then begin
                    for I := 0 to m_MasterList.Count - 1 do begin
                      if m_MasterList.Objects[I] = BaseObject then begin
                        Result := True;
                        break;
                      end;
                    end;
                  end else begin
                    if m_MasterList.Objects[0] = BaseObject then
                      Result := True;
                  end;
                end;
              end;
            end;
          end;
        HAM_GROUP: begin
            if cret = Self then
              Result := True;
            if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
              if (m_GroupOwner <> nil) and (m_GroupOwner = cret.m_GroupOwner) then
                Result := True;
            //if IsGroupMember(cret) then
              //Result := True;
          end;
        HAM_GUILD: begin
            if cret = Self then
              Result := True;
            if m_MyGuild <> nil then begin
              if m_MyGuild = cret.m_MyGuild then
                Result := True;
              if m_boGuildWarArea and (cret.m_MyGuild <> nil) then begin
                if TGuild(m_MyGuild).IsAllyGuild(TGuild(cret.m_MyGuild)) then
                  Result := True;
              end;
            end;
          end;
        HAM_PKATTACK: begin
            if cret = Self then
              Result := True;
            if PKLevel >= 2 then begin
              if cret.PKLevel < 2 then
                Result := True;
            end
            else begin
              if cret.PKLevel >= 2 then
                Result := True;
            end;
          end;
      end;
    end;
  end;
begin
  Result := False;
  if BaseObject = nil then Exit;


  if m_AttackState = as_Close then Exit;
  if m_AttackState = as_Dare then Exit;
  {if m_btRaceServer = RC_PLAYMOSTER then begin //分身检测
    if m_Master = nil then begin
      if (BaseObject.m_btRaceServer >= RC_ANIMAL) then
        Result := True;
      if (BaseObject.m_Master <> nil) or (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then
        Result := False;
    end else begin
      if (BaseObject.m_btRaceServer >= RC_ANIMAL) then
        Result := False;
      if BaseObject.m_Master <> nil then
        Result := IsFriend(BaseObject.m_Master);
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
        Result := IsFriend(BaseObject);
      if BaseObject = m_Master then
        Result := True;
    end;
    Exit;
  end;    }

  if (m_btRaceServer >= RC_ANIMAL) then begin
    if (BaseObject.m_btRaceServer >= RC_ANIMAL) then
      Result := True;
    if BaseObject.m_Master <> nil then
      Result := False;
    Exit;
  end;

  if m_btRaceServer = RC_PLAYOBJECT then begin
    Result := IsFriend(BaseObject);
    if BaseObject.m_btRaceServer < RC_ANIMAL then
      Exit;
    if BaseObject.m_Master = Self then begin
      Result := True;
      Exit;
    end;
    if BaseObject.m_Master <> nil then begin
      Result := IsFriend(BaseObject.m_Master);
      Exit;
    end;
  end
  else
    Result := True;
end;

procedure TBaseObject.DamageBubbleDefence(nInt: Integer);
begin
  if m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] > 0 then begin
    if m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] > 3 then
      Dec(m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP], 3)
    else
      m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] := 1;
  end;
end;

procedure TBaseObject.DamageShieldDefence(nInt: Integer);
begin
  if m_wStatusTimeArr[STATE_BUBBLEDEFENCEUPEX] > 0 then begin
    if m_wStatusTimeArr[STATE_BUBBLEDEFENCEUPEX] > nInt then
      Dec(m_wStatusTimeArr[STATE_BUBBLEDEFENCEUPEX], nInt)
    else
      m_wStatusTimeArr[STATE_BUBBLEDEFENCEUPEX] := 1;
  end;
end;

function TBaseObject.IsGuildMaster: Boolean;
begin
  Result := False;
  if (m_MyGuild <> nil) and (m_nGuildRankNo = 1) then
    Result := True;
end;

procedure TBaseObject.ChangePKStatus(boWarFlag: Boolean);
begin
  if m_boInFreePKArea <> boWarFlag then begin
    m_boInFreePKArea := boWarFlag;
    m_boNameColorChanged := True;
  end;
end;

function TBaseObject.GetDropPosition(nOrgX, nOrgY, nRange: Integer; var nDX: Integer; var nDY: Integer): Boolean;
var
  i, ii, III: Integer;
  nItemCount, n24, n28, n2C: Integer;
begin
  n24 := 999;
  Result := False;
  n28 := 0; //09/10
  n2C := 0; //09/10
  for i := 1 to nRange do begin
    for ii := -i to i do begin
      for III := -i to i do begin
        nDX := nOrgX + III;
        nDY := nOrgY + ii;
        if m_PEnvir.GetItemEx(nDX, nDY, nItemCount) = nil then begin
          if m_PEnvir.bo2C then begin
            Result := True;
            break;
          end;
        end
        else begin
          if m_PEnvir.bo2C and (n24 > nItemCount) then begin
            n24 := nItemCount;
            n28 := nDX;
            n2C := nDY;
          end;
        end;
      end;
      if Result then
        break;
    end;
    if Result then
      break;
  end;
  if not Result then begin
    if n24 < 8 then begin
      nDX := n28;
      nDY := n2C;
    end
    else begin
      nDX := nOrgX;
      nDY := nOrgY;
    end;
  end;
end;

procedure TBaseObject.RecalcLevelAbilitys();
var
  nLevel, n: Integer;
begin
  nLevel := m_Abil.Level;
  case m_btJob of
    2: begin
        //m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND((nLevel / 6 + 2.5) * nLevel));
        m_Abil.MaxHP := _MIN(MaxInt, 14 + ROUND(((nLevel /
          g_Config.nLevelValueOfTaosHP + g_Config.nLevelValueOfTaosHPRate) *
          nLevel)));

        //m_Abil.MaxMP:=_MIN(High(Word),13 + ROUND((nLevel / 8)* 2.2 * nLevel));
        m_Abil.MaxMP := _MIN(MaxInt, 13 + ROUND(((nLevel /
          g_Config.nLevelValueOfTaosMP) * 2.2 * nLevel)));

        m_Abil.MaxWeight := 50 + ROUND((nLevel / 4) * nLevel);
        m_Abil.MaxWearWeight := 15 + ROUND((nLevel / 50) * nLevel);
        m_Abil.MaxHandWeight := 12 + ROUND((nLevel / 42) * nLevel);

        n := nLevel div 7;
        m_Abil.DC := MakeLong(_MAX(n - 1, 0), _MAX(1, n));
        m_Abil.MC := 0;
        m_Abil.SC := MakeLong(_MAX(n - 1, 0), _MAX(1, n));
        m_Abil.AC := 0;

        n := ROUND(nLevel / 6);
        m_Abil.MAC := MakeLong(n div 2, n + 1);
      end;
    1: begin
        //m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND((nLevel / 15 + 1.8) * nLevel));
        m_Abil.MaxHP := _MIN(MaxInt, 14 + ROUND(((nLevel /
          g_Config.nLevelValueOfWizardHP + g_Config.nLevelValueOfWizardHPRate) *
          nLevel)));

        m_Abil.MaxMP := _MIN(High(Integer), 13 + ROUND((nLevel / 5 + 2) * 2.2 *
          nLevel));
        m_Abil.MaxWeight := 50 + ROUND((nLevel / 5) * nLevel);
        m_Abil.MaxWearWeight := 15 + ROUND((nLevel / 100) * nLevel);
        m_Abil.MaxHandWeight := 12 + ROUND((nLevel / 90) * nLevel);

        n := nLevel div 7;
        m_Abil.DC := MakeLong(_MAX(n - 1, 0), _MAX(1, n));
        m_Abil.MC := MakeLong(_MAX(n - 1, 0), _MAX(1, n));
        m_Abil.SC := 0;
        m_Abil.AC := 0;
        m_Abil.MAC := 0;
      end;
    0: begin
        //m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND((nLevel / 4.0 + 4.5 + nLevel / 20) * nLevel));
        m_Abil.MaxHP := _MIN(MaxInt, 14 + ROUND(((nLevel /
          g_Config.nLevelValueOfWarrHP + g_Config.nLevelValueOfWarrHPRate +
          nLevel
          / 20) * nLevel)));

        m_Abil.MaxMP := _MIN(MaxInt, 11 + ROUND(nLevel * 3.5));
        m_Abil.MaxWeight := 50 + ROUND((nLevel / 3) * nLevel);
        m_Abil.MaxWearWeight := 15 + ROUND((nLevel / 20) * nLevel);
        m_Abil.MaxHandWeight := 12 + ROUND((nLevel / 13) * nLevel);

        m_Abil.DC := MakeLong(_MAX((nLevel div 5) - 1, 1), _MAX(1, (nLevel div
          5)));
        m_Abil.SC := 0;
        m_Abil.MC := 0;
        m_Abil.AC := MakeLong(0, (nLevel div 7));
        m_Abil.MAC := 0;
      end;
  end;
  if m_Abil.HP > m_Abil.MaxHP then
    m_Abil.HP := m_Abil.MaxHP;
  if m_Abil.MP > m_Abil.MaxMP then
    m_Abil.MP := m_Abil.MaxMP;
end;
 {
procedure TBaseObject.HasWuXinLevelUp(nLevel: Integer);
begin
  //m_nWuXinMaxExp := GetWuXinLevelExp(m_btWuXinLevel);
  RecalcAbilitys();
  //SendMsg(Self, RM_SUBABILITY2, 0, 0, 0, 0, '');
  if m_btRaceServer = RC_PLAYOBJECT then begin

    SendMsg(Self, RM_LEVELUP, 0, m_Abil.Exp, 0, 0, '');
    //TPlayObject(Self).LevelUpFunc();
    if (m_GroupOwner <> nil) then begin
      TPlayObject(Self).SendGroupMsg(TPlayObject(Self),
        SM_GROUPINFO2, 0, 0, 0, 0, '');
    end;
  end
end;     }

procedure TBaseObject.OnAction(ActionType: TOnActionType);
begin
  //
end;

procedure TBaseObject.OrdinaryAttack(BaseObject: TBaseObject);
begin
  //
end;

procedure TBaseObject.HasLevelUp(nLevel: Integer);
begin
  m_Abil.MaxExp := GetLevelExp(m_Abil.Level);
  RecalcLevelAbilitys();
  RecalcAbilitys();
  if m_btRaceServer = RC_PLAYOBJECT then begin
    SendMsg(Self, RM_LEVELUP, 0, m_Abil.Exp, 0, 0, '');
    SendRefMsg(RM_SHOWEFFECT, EFFECT_LEVELUP, Integer(Self), m_nCurrX, m_nCurrY, '');
    TPlayObject(Self).LevelUpFunc();
    if (m_GroupOwner <> nil) then begin
      TPlayObject(m_GroupOwner).SendGroupMsg(TPlayObject(Self), SM_GROUPINFO2, 0, 0, 0, 0, '');
    end;
  end
  else begin
    SendMsg(Self, RM_LEVELUP, 0, m_Abil.Exp, 0, 0, '');
  end;
end;

function TBaseObject.WalkTo(btDir: Byte; boFlag: Boolean): Boolean; //004C3F64
var
  nOX, nOY, nNX, nNY, n20, n24: Integer;
  //Envir:TEnvirnoment;
  bo29: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TBaseObject::WalkTo';
begin
  Result := False;
  if m_boHolySeize then
    Exit;
  if m_nWalkSpeed < 0 then
    Exit;
  try
    nOX := m_nCurrX;
    nOY := m_nCurrY;
    //    Envir:=m_PEnvir;
    m_btDirection := btDir;
    nNX := 0;
    nNY := 0;
    case btDir of
      DR_UP: begin
          nNX := m_nCurrX;
          nNY := m_nCurrY - 1;
        end;
      DR_UPRIGHT: begin
          nNX := m_nCurrX + 1;
          nNY := m_nCurrY - 1;
        end;
      DR_RIGHT: begin
          nNX := m_nCurrX + 1;
          nNY := m_nCurrY;
        end;
      DR_DOWNRIGHT: begin
          nNX := m_nCurrX + 1;
          nNY := m_nCurrY + 1;
        end;
      DR_DOWN: begin
          nNX := m_nCurrX;
          nNY := m_nCurrY + 1;
        end;
      DR_DOWNLEFT: begin
          nNX := m_nCurrX - 1;
          nNY := m_nCurrY + 1;
        end;
      DR_LEFT: begin
          nNX := m_nCurrX - 1;
          nNY := m_nCurrY;
        end;
      DR_UPLEFT: begin
          nNX := m_nCurrX - 1;
          nNY := m_nCurrY - 1;
        end;
    end;
    if (nNX >= 0) and ((m_PEnvir.m_nWidth - 1) >= nNX) and
      (nNY >= 0) and ((m_PEnvir.m_nHeight - 1) >= nNY) then begin
      bo29 := True;
      if {(not m_boRunAll) and} bo2BA and (not m_PEnvir.CanSafeWalk(nNX, nNY)) then
        bo29 := False;
      if m_Master <> nil then begin
        m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master.m_btDirection, 1, n20, n24);
        if (nNX = n20) and (nNY = n24) then
          bo29 := False;
      end;
      if bo29 {or m_boRunAll} then begin
        if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nNX, nNY, boFlag {or m_boRunAll}) > 0 then begin
          m_nCurrX := nNX;
          m_nCurrY := nNY;
        end;
      end;
    end;
    if (m_nCurrX <> nOX) or (m_nCurrY <> nOY) then begin

      if Walk(RM_WALK) then begin
        if m_boTransparent and m_boHideMode then begin
          m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] := 1;
        end;
        Result := True;
      end
      else begin
        m_PEnvir.DeleteFromMap(m_nCurrX, m_nCurrY, OS_MOVINGOBJECT, Self);
        m_nCurrX := nOX;
        m_nCurrY := nOY;
        m_PEnvir.AddToMap(m_nCurrX, m_nCurrY, OS_MOVINGOBJECT, Self);
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;
{
function TBaseObject.IsAddWeightAvailable(nWeight: Integer): Boolean;
begin
  Result := False;
  if (m_WAbil.Weight + nWeight) <= m_WAbil.MaxWeight then
    Result := True;
end; }
//是否队伍成员

function TBaseObject.IsGroupMember(Target: TBaseObject): Boolean;
var
  i: Integer;
begin
  Result := False;
  if m_GroupOwner = nil then Exit;
  for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
    if m_GroupOwner.m_GroupMembers.Objects[i] = Target then begin
      Result := True;
      break;
    end;
  end;
end;

function TBaseObject.IsGroupMemberEx(Target: TBaseObject): Boolean;
var
  i: Integer;
begin
  Result := False;
  if m_GroupOwner = nil then Exit;
  for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
    if (m_GroupOwner.m_GroupMembers.Objects[i] = Target){ or
      (m_GroupOwner.m_GroupMembers[i] = Target.m_sCharName)} then begin
      Result := True;
      break;
    end;
  end;
end;

function TBaseObject.PKLevel(): Integer;
begin
  Result := m_nPkPoint div 100;
end;

procedure TBaseObject.HealthSpellChanged;
begin
  if m_boShowHP then begin
    SendRefMsg(RM_HEALTHSPELLCHANGED, 0, 0, 0, 0, '');
    if (m_btRaceServer = RC_PLAYOBJECT) and (m_GroupOwner <> nil) then begin
      TPlayObject(Self).SendRefGroupMsg(TPlayObject(Self), SM_GROUPINFO1,
        Integer(Self), m_WAbil.HP, m_WAbil.MP, m_WAbil.MaxHP, IntToStr(m_WAbil.MaxMP));
    end;
  end
  else begin
    if m_btRaceServer = RC_PLAYOBJECT then begin
      SendUpdateMsg(Self, RM_HEALTHSPELLCHANGED, 0, 0, 0, 0, '');

      if m_GroupOwner <> nil then begin
        TPlayObject(Self).SendGroupMsg(TPlayObject(Self), SM_GROUPINFO1,
          Integer(Self), m_WAbil.HP, m_WAbil.MP, m_WAbil.MaxHP, IntToStr(m_WAbil.MaxMP));
      end;
    end;
  end;
end;

function TBaseObject.CalcGetExp(nLevel: Integer; nExp: Integer): Integer;
begin
  //if True then
  if g_Config.boLowLevelKillMonContainExp and (m_Abil.Level < nLevel) then begin
    if (nLevel - m_Abil.Level) >= g_Config.nLowLevelKillMonLevel then begin
      nExp := Round(g_Config.nLowLevelKillMonGetExpRate / 100 * nExp);
    end;
  end;

  if g_Config.boHighLevelKillMonFixExp or (m_Abil.Level < (nLevel + 10)) then begin
    Result := nExp;
  end
  else begin
    Result := nExp - ROUND((nExp / 15) * (m_Abil.Level - (nLevel + 10)));
  end;
  if Result <= 0 then
    Result := 1;
end;

procedure TBaseObject.RefNameColor();
begin
  SendRefMsg(RM_CHANGENAMECOLOR, 0, 0, 0, 0, '');
end;

procedure TBaseObject.GainSlaveExp(nLevel: Integer);
  function GetUpKillCount(): Integer;
  var
    tCount: Integer;
  begin
    if m_btSlaveExpLevel < SLAVEMAXLEVEL - 2 then begin
      tCount := g_Config.MonUpLvNeedKillCount[m_btSlaveExpLevel];
    end
    else begin
      tCount := 0;
    end;
    Result := ((m_Abil.Level * g_Config.nMonUpLvRate) - m_Abil.Level) + g_Config.nMonUpLvNeedKillBase + tCount
  end;
begin
  Inc(m_nKillMonCount, nLevel);
  if GetUpKillCount() < m_nKillMonCount then begin
    Dec(m_nKillMonCount, GetUpKillCount);
    if m_btSlaveExpLevel < (m_btSlaveMakeLevel * 2 + 1) then begin
      Inc(m_btSlaveExpLevel);
      RecalcAbilitys();
      RefNameColor();
    end;
  end;
end;

function TBaseObject.DropGoldDown(nGold: Integer; boFalg: Boolean; GoldOfCreat,
  DropGoldCreat: TBaseObject): Boolean; //004C5794
var
  MapItem, MapItemA: PTMapItem;
  nX, nY: Integer;
  s20: string;
begin
  Result := False;
  New(MapItem);
  SafeFillChar(MapItem^, SizeOf(TMapItem), #0);
  MapItem.Name := sSTRING_GOLDNAME;
  MapItem.Count := nGold;
  MapItem.Looks := GetGoldShape(nGold);
  MapItem.OfBaseObject := GoldOfCreat;
  //Jason 更改当物品所有者不为人物时,设置该物品为公共物品
  if (GoldOfCreat <> nil) and (GoldOfCreat.m_btRaceServer <> RC_PLAYOBJECT) then
    MapItem.OfBaseObject := nil;
  MapItem.dwCanPickUpTick := GetTickCount();
  MapItem.DropBaseObject := DropGoldCreat;
  GetDropPosition(m_nCurrX, m_nCurrY, 3, nX, nY);
  MapItemA := m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
  if MapItemA <> nil then begin
    if MapItemA <> MapItem then begin
      DisPose(MapItem);
      MapItem := MapItemA;
    end;
    MapItem.btIdx := m_PEnvir.m_btFBIndex;
    SendRefMsg(RM_ITEMSHOW, MapItem.Looks, Integer(MapItem), nX, nY, MapItem.Name);
    if m_btRaceServer = RC_PLAYOBJECT then begin
      if boFalg then
        s20 := '掉落'
      else
        s20 := '丢弃';
      if g_boGameLogGold then
        AddGameLog(Self, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, m_nGold, '0', '-', IntToStr(nGold), s20, nil);
    end;
    Result := True;
  end
  else
    DisPose(MapItem);
end;

function TBaseObject.GetGuildRelation(cert1, cert2: TBaseObject): Integer;
begin
  Result := 0;
  m_boGuildWarArea := False;
  if (cert1.m_MyGuild = nil) or (cert2.m_MyGuild = nil) then
    Exit;
  if cert1.InSafeArea or (cert2.InSafeArea) then
    Exit;
  if TGuild(cert1.m_MyGuild).m_GuildWarList.Count <= 0 then
    Exit;
  m_boGuildWarArea := True;
  if TGuild(cert1.m_MyGuild).IsWarGuild(TGuild(cert2.m_MyGuild)) and
    TGuild(cert2.m_MyGuild).IsWarGuild(TGuild(cert1.m_MyGuild)) then
    Result := 2;
  if cert1.m_MyGuild = cert2.m_MyGuild then
    Result := 1;
  if TGuild(cert1.m_MyGuild).IsAllyGuild(TGuild(cert2.m_MyGuild)) and
    TGuild(cert2.m_MyGuild).IsAllyGuild(TGuild(cert1.m_MyGuild)) then
    Result := 3;
end;

procedure TBaseObject.IncPkPoint(nPoint: Integer);
var
  nOldPKLevel: Integer;
begin
  nOldPKLevel := PKLevel;
  WordChange(m_nPkPoint, nPoint, INT_ADD);
  if PKLevel <> nOldPKLevel then begin
    if PKLevel <= 2 then
      RefNameColor;
  end;
  if m_btRaceServer = RC_PLAYOBJECT then begin
    TPlayobject(self).DiamondChanged;
  end;
end;

procedure TBaseObject.AddBodyLuck(dLuck: Double);
var
  n: Integer;
begin
  if (dLuck > 0) and (m_dBodyLuck < 5 * BODYLUCKUNIT) then begin
    m_dBodyLuck := m_dBodyLuck + dLuck;
  end;
  if (dLuck < 0) and (m_dBodyLuck > -(5 * BODYLUCKUNIT)) then begin
    m_dBodyLuck := m_dBodyLuck + dLuck;
  end;
  n := Trunc(m_dBodyLuck / BODYLUCKUNIT);
  if n > 5 then
    n := 5;
  if n < -10 then
    n := -10;
  m_nBodyLuckLevel := n;
end;

procedure TBaseObject.MakeWeaponUnlock;
begin
  if m_UseItems[U_WEAPON].wIndex <= 0 then Exit;
  if m_UseItems[U_WEAPON].Value.btValue[tb_Luck] > 0 then begin
    Dec(m_UseItems[U_WEAPON].Value.btValue[tb_Luck]);
    SysMsg(g_sTheWeaponIsCursed, c_Red, t_Hint);
  end
  else begin
    if m_UseItems[U_WEAPON].Value.btValue[tb_UnLuck] < 10 then begin
      Inc(m_UseItems[U_WEAPON].Value.btValue[tb_UnLuck]);
      SysMsg(g_sTheWeaponIsCursed, c_Red, t_Hint);
    end;
  end;
  if m_btRaceServer = RC_PLAYOBJECT then begin
    RecalcAbilitys();
    SendAbility;
    SendSubAbility;
    TPlayObject(Self).SendUpdateItem(@m_UseItems[U_WEAPON]);
  end;
end;

function TBaseObject.GetAttackPower(nBasePower, nPower: Integer; boDeadliness: Boolean): Integer;
begin
  if nPower < 0 then nPower := 0;
  if m_nLuck > 0 then begin
    if Random((g_Config.nWeaponMakeUnLuckMaxCount + 1) - _MIN(g_Config.nWeaponMakeUnLuckMaxCount, m_nLuck)) = 0 then
      Result := nBasePower + nPower
    else
      Result := nBasePower + Random(nPower + 1);
  end
  else begin
    Result := nBasePower + Random(nPower + 1);
    if m_nLuck < 0 then begin
      if Random(10 - _MAX(0, -m_nLuck)) = 0 then
        Result := nBasePower;
    end;
  end;
  if m_btRaceServer = RC_PLAYOBJECT then begin
    with Self as TPlayObject do begin
      if boDeadliness and (m_btDeadliness > 0) and (Random(100) < m_btDeadliness) then begin       //致命一击
        // todo 致命伤害增加一个百分比系数，而不是直接的 2 倍
        Result := Result * 2;
        SendRefMsg(RM_SHOWEFFECT, Effect_DEADLINESS, Integer(Self), m_nCurrX, m_nCurrY, '');
      end;
      if m_nPowerRate <> 100 then
        Result := ROUND(Result * (m_nPowerRate / 100));
      // fixme 这种设定垃圾，不需要
      if m_boPowerItem then
        Result := ROUND(m_rPowerItem * Result);
    end;
  end;
  if m_boAutoChangeColor then begin
    Result := Result * m_nAutoChangeIdx + 1;
  end;
  if m_boFixColor then begin
    Result := Result * m_nFixColorIdx + 1;
  end;
end;

procedure TBaseObject.DamageHealth(nDamage: Integer); //减血
var
  nSpdam: Integer;
begin
  if ((m_LastHiter = nil) or (not m_LastHiter.m_boUnMagicShield)) and m_boMagicShield and (nDamage > 0) and (m_WAbil.MP > 0)
  then begin
    nSpdam := ROUND(nDamage * 1.5);
    if Integer(m_WAbil.MP) >= nSpdam then begin
      m_WAbil.MP := m_WAbil.MP - nSpdam;
      nSpdam := 0;
    end
    else begin
      nSpdam := nSpdam - m_WAbil.MP;
      m_WAbil.MP := 0;
    end;
    nDamage := ROUND(nSpdam / 1.5);
    HealthSpellChanged();
  end;
  if (nDamage > 0) and (m_WAbil.MP > 0) and m_boAbilMagShieldDefence then begin
    nSpdam := Round(nDamage / 100 * (m_btMagShieldDefenceLevel * 15 + 10));
    if Integer(m_WAbil.MP) >= nSpdam then begin
      m_WAbil.MP := m_WAbil.MP - nSpdam;
    end
    else begin
      nSpdam := m_WAbil.MP;
      m_WAbil.MP := 0;
    end;
    DamageShieldDefence(Round(nSpdam / 10) + 1);
    nDamage := nDamage - nSpdam;
    HealthSpellChanged();
  end;
  if nDamage > 0 then begin
    if (m_WAbil.HP - nDamage) > 0 then begin
      m_WAbil.HP := m_WAbil.HP - nDamage;
    end
    else begin
      m_WAbil.HP := 0;
    end;
  end
  else begin
    if (m_WAbil.HP - nDamage) < m_WAbil.MaxHP then begin
      m_WAbil.HP := m_WAbil.HP - nDamage;
    end
    else begin
      m_WAbil.HP := m_WAbil.MaxHP;
    end;
  end;
end;

function TBaseObject.GetBackDir(nDir: Integer): Integer;
begin
  Result := 0;
  case nDir of
    DR_UP: Result := DR_DOWN;
    DR_DOWN: Result := DR_UP;
    DR_LEFT: Result := DR_RIGHT;
    DR_RIGHT: Result := DR_LEFT;
    DR_UPLEFT: Result := DR_DOWNRIGHT;
    DR_UPRIGHT: Result := DR_DOWNLEFT;
    DR_DOWNLEFT: Result := DR_UPRIGHT;
    DR_DOWNRIGHT: Result := DR_UPLEFT;
  end;
end;

function TBaseObject.CharPushedcbo(nDir, nPushCount: Integer): Integer; //冲撞人
var
  i, nX, nY, olddir, nBackDir: Integer;
begin
  Result := 0;
  olddir := m_btDirection;
  m_btDirection := nDir;
  nBackDir := GetBackDir(nDir);
  for i := 0 to nPushCount - 1 do begin
    GetFrontPosition(nX, nY);
    if m_PEnvir.CanWalk(nX, nY, False) then begin
      if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False) > 0 then begin
        m_nCurrX := nX;
        m_nCurrY := nY;
        GetStartType();
        Inc(Result);
        OnAction(AT_Pushed);
        if m_btRaceServer >= RC_ANIMAL then
          m_dwWalkTick := m_dwWalkTick + 800;
      end
      else
        break;
    end
    else
      break;
  end;
  m_btDirection := nBackDir;
  if Result = 0 then
    m_btDirection := olddir;
end;

function TBaseObject.CharPushed(nDir, nPushCount: Integer): Integer; //冲撞人
var
  i, nX, nY, olddir, {oldx, oldy,} nBackDir: Integer;
begin
  Result := 0;
  olddir := m_btDirection;
  //  oldx := m_nCurrX;
  //  oldy := m_nCurrY;
  m_btDirection := nDir;
  nBackDir := GetBackDir(nDir);
  for i := 0 to nPushCount - 1 do begin
    GetFrontPosition(nX, nY);
    if m_PEnvir.CanWalk(nX, nY, False) then begin
      if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False) > 0 then begin
        m_nCurrX := nX;
        m_nCurrY := nY;
        GetStartType();
        SendRefMsg(RM_PUSH, nBackDir, m_nCurrX, m_nCurrY, 1, '');
        OnAction(AT_Pushed);
        Inc(Result);
        if m_btRaceServer >= RC_ANIMAL then
          m_dwWalkTick := m_dwWalkTick + 800;
      end
      else
        break;
    end
    else
      break;
  end;
  //m_btDirection:=GetBackDir(ndir);
  //m_btDirection:=GetBackDir(nBackDir);
  m_btDirection := nBackDir;
  if Result = 0 then
    m_btDirection := olddir;
end;

function TBaseObject.MagPassThroughMagic(sX, sY, tx, ty, nDir, magpwr, nMagID: Integer;
  undeadattack: Boolean): Integer; //004C69F4
var
  i, tCount, acpwr: Integer;
  BaseObject: TBaseObject;
  //   n14,n18:integer;
begin
  tCount := 0;
  for i := 0 to 12 do begin
    BaseObject := TBaseObject(m_PEnvir.GetMovingObject(sX, sY, True));
    if BaseObject <> nil then begin
      if IsProperTarget(BaseObject) then begin
        // fixme 魔法躲避
        if Random(10) >= BaseObject.m_nAntiMagic then begin
          if undeadattack then
            acpwr := ROUND(magpwr * 1.5)
          else
            acpwr := magpwr;
          BaseObject.SendDelayMsg(Self, RM_MAGSTRUCK, 0, acpwr, 0, 0, 0, '', 600);
          BaseObject.MagicQuest(Self, nMagID, mfs_TagEx);
          //BaseObject.SendMsg(Self, RM_MAGSTRUCK, 0, acpwr, 0, 0, '');
          Inc(tCount);
        end;
      end;
    end;
    if not ((abs(sX - tx) <= 0) and (abs(sY - ty) <= 0)) then begin
      nDir := GetNextDirection(sX, sY, tx, ty);
      if not m_PEnvir.GetNextPosition(sX, sY, nDir, 1, sX, sY) then
        break;
    end
    else
      break;
  end;
  Result := tCount;
end;

function TBaseObject.DropItemDown(UserItem: pTUserItem; nScatterRange: Integer;
  boDieDrop: Boolean; ItemOfCreat, DropCreat: TBaseObject): Boolean;
var
  dx, dy, idura: Integer;
  MapItem, pr: PTMapItem;
  StdItem: pTStdItem;
  logcap: string;
  //sUserItemName: string;
begin
  Result := False;
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem <> nil then begin
    if StdItem.StdMode = tm_Flesh then begin
      idura := UserItem.Dura;
      idura := idura - 2000;
      if idura < 0 then
        idura := 0;
      UserItem.Dura := idura;
    end;
    New(MapItem);
    MapItem.UserItem := UserItem^;
    MapItem.Name := StdItem.Name;
    MapItem.btIdx := m_PEnvir.m_btFBIndex;

    MapItem.Looks := StdItem.Looks;
    if StdItem.StdMode = tm_Dice then begin //林荤困, 格犁
      MapItem.Looks := GetRandomLook(MapItem.Looks, StdItem.Shape);
    end;
    MapItem.AniCount := StdItem.AniCount;
    MapItem.Reserved := 0;
    MapItem.Count := 1;
    MapItem.OfBaseObject := ItemOfCreat;
    if (ItemOfCreat <> nil) and (ItemOfCreat.m_btRaceServer <> RC_PLAYOBJECT) then
      MapItem.OfBaseObject := nil;

    if (MapItem.OfBaseObject <> nil) and (DropCreat <> nil) and (DropCreat.m_btRaceServer = RC_PLAYOBJECT) then
      MapItem.OfBaseObject := nil;
      
    MapItem.dwCanPickUpTick := GetTickCount();
    MapItem.DropBaseObject := DropCreat;
    GetDropPosition(m_nCurrX, m_nCurrY, nScatterRange, dx, dy);
    pr := m_PEnvir.AddToMap(dx, dy, OS_ITEMOBJECT, TObject(MapItem));
    if pr = MapItem then begin
      SendRefMsg(RM_ITEMSHOW, MapItem.Looks, Integer(MapItem), dx, dy, MapItem.Name);
      if boDieDrop then
        logcap := '掉落'
      else
        logcap := '丢弃';

      if StdItem.NeedIdentify = 1 then
        AddGameLog(Self, LOG_DELITEM, Stditem.Name, Useritem.MakeIndex, UserItem.Dura, '0',
          '0', BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT), logcap, Useritem);
      if boDieDrop and (StdItem.Rule.Rule[RULE_DOWNHINT]) and (DropCreat <> nil) and (DropCreat.m_btRaceServer <> RC_PLAYOBJECT) then
      begin
        logcap := '[#6FFFF/8#6传闻#5]：[#6FFFF/8#6' + FilterShowName(DropCreat.m_sCharName) + '#5]在[';
        logcap := logcap + m_PEnvir.sMapDesc + '(' + IntToStr(dx) + ',' + IntToStr(dy) + ')]被斩杀了，掉落了一件宝贝 ';
        logcap := logcap + '{' + IntToStr(SetSayItem(UserItem)) + '/';
        logcap := logcap + IntToStr(UserItem.wIndex) + '/';
        logcap := logcap + IntToStr(UserItem.MakeIndex) + '}';
        UserEngine.SendBroadCastMsg(logcap, t_Hint);
      end;

      Result := True;
    end
    else begin
      DisPose(MapItem);
    end;
  end;
end;

procedure TBaseObject.GoldChanged();
begin
  if m_btRaceServer = RC_PLAYOBJECT then begin
    SendUpdateDefMsg(Self, SM_GOLDCHANGED, m_nGold, TPlayObject(Self).m_nBindGold, 0, 0, '');
  end;
end;

procedure TBaseObject.GoldPointChanged();
begin
  if m_btRaceServer = RC_PLAYOBJECT then begin
    SendUpdateDefMsg(Self, SM_GOLDPOINTCHANGED, m_nGold, TPlayObject(Self).m_nGamePoint, 0, 0, '');
  end;
end;

procedure TBaseObject.GameGoldChanged();
begin
  if m_btRaceServer = RC_PLAYOBJECT then begin
    SendUpdateMsg(Self, RM_GAMEGOLDCHANGED, 0, 0, 0, 0, '');
  end;
end;

function TBaseObject.GetShowName: string;
var
  sShowName: string;
begin
  sShowName := m_sCharName;
  Result := FilterShowName(sShowName);
  //if m_nCopyHumanLevel in [0, 1] then begin
  if (m_Master <> nil) and not m_Master.m_boObMode then begin
    Result := Result + '(' + m_Master.m_sCharName + ')';
  end else begin
    if g_Config.boShowMonLevel and (not (m_btRaceServer in [RC_BOX, RC_GUARD, 55{练功师}, RC_ARCHERGUARD, 110, 111])) then begin
      sShowName := g_Config.sShowMonLevelFormat;
      sShowName := AnsiReplaceText(sShowName, '%d', IntToStr(m_Abil.Level));
      sShowName := AnsiReplaceText(sShowName, '%s', Result);
      Result := sShowName;
    end;
  end;
end;

//刷新人物状态信息

procedure TBaseObject.RecalcAbilitys;
var
  Abil: TAbility;
  boOldHideMode: Boolean;
  nOldLight: Integer;
  i, k, nIndex: Integer;
  StdItem: pTStdItem;
  boRecallSuite1: Boolean;
  boRecallSuite2: Boolean;
  boRecallSuite3: Boolean;
  boRecallSuite4: Boolean;
  boMoXieSuite1: Boolean;
  boMoXieSuite2: Boolean;
  boMoXieSuite3: Boolean;
  boHongMoSuite1: Boolean;
  boHongMoSuite2: Boolean;
  boHongMoSuite3: Boolean;
  boSpirit1: Boolean;
  boSpirit2: Boolean;
  boSpirit3: Boolean;
  boSpirit4: Boolean;
  n01, n02, n03, n04: Integer;
  CheckSource: Integer;
  nStrengthenCount: Integer;
  AddAbility: TAddAbility;
  boSetItem: Boolean;
  SetItems: pTSetItems;
  sItemNameL, sItemNameR: string;
  //  PlayObject:TPlayObject;
begin
  SafeFillChar(m_AddAbil, SizeOf(TAddAbility), #0);
  Abil := m_WAbil;
  m_WAbil := m_Abil;
  m_WAbil.HP := Abil.HP;
  m_WAbil.MP := Abil.MP;
  if m_boOnHorse and (m_UseItems[u_House].wIndex > 0) then begin
    if m_NotOnHorseHP = 0 then m_NotOnHorseHP := m_WAbil.HP;
    m_WAbil.HP := m_UseItems[u_House].wHP;
  end else begin
    if m_NotOnHorseHP <> 0 then
      m_WAbil.HP := m_NotOnHorseHP;
    m_NotOnHorseHP := 0;
  end;
  m_WAbil.Weight := 0;
  m_WAbil.WearWeight := 0;
  m_WAbil.HandWeight := 0;
  m_btAntiPoison := 0;
  m_nPoisonRecover := 0;
  m_nHealthRecover := 0;
  m_nSpellRecover := 0;
  m_btAddAttack := 0;
  m_btDelDamage := 0;
  m_btAddWuXinAttack := 10;
  m_btDelWuXinAttack := 10;
  m_nAntiMagic := 1;
  m_btDeadliness := 0;
  nStrengthenCount := 0;
  m_nLuck := 0;
  m_nHitSpeed := 0;
  m_nSetItemExp := 0;
  //m_nHitDunt := 0;
  m_nItemExp := 0;
  m_boExpItem := False;
  m_rExpItem := 0;
  m_boPowerItem := False;
  m_boHorseHit := False;
  m_rPowerItem := 0;
  boOldHideMode := m_boHideMode;
  m_boHideMode := False;
  m_boTeleport := False;
  m_boTeleportEx := False;
  m_boParalysis := False;
  m_boRevival := False;
  m_boUnRevival := False;
  m_boFlameRing := False;
  m_boRecoveryRing := False;
  m_boAngryRing := False;
  m_boMagicShield := False;
  m_boUnMagicShield := False;
  m_boMuscleRing := False;
  m_boFastTrain := False;
  m_boProbeNecklace := False;
  m_boSupermanItem := False;
  m_boGuildMove := False;
  m_boUnParalysis := False;
  m_boExpItem := False;
  m_boPowerItem := False;
  m_boNoDropItem := False;
  m_boNoDropUseItem := False;
  m_bopirit := False;
  m_btHorseType := 0;
  m_boHorseHit := False;
  m_btHorseDress := 0;
  m_btDressEffType := 0;

  m_nMoXieSuite := 0;
  boMoXieSuite1 := False;
  boMoXieSuite2 := False;
  boMoXieSuite3 := False;
  m_db3B0 := 0;
  m_nHongMoSuite := 0;
  boHongMoSuite1 := False;
  boHongMoSuite2 := False;
  boHongMoSuite3 := False;

  boSpirit1 := False;
  boSpirit2 := False;
  boSpirit3 := False;
  boSpirit4 := False;

  m_boRecallSuite := False;
  boRecallSuite1 := False;
  boRecallSuite2 := False;
  boRecallSuite3 := False;
  boRecallSuite4 := False;

  m_dwPKDieLostExp := 0;
  m_nPKDieLostLevel := 0;
  m_btStrengthenName := 0;

  //m_nItemKickMonExp := 0;
  //m_dwItemWuXinExpRate := 0;

  if m_btRaceServer = RC_PLAYOBJECT then begin
    if g_SetItemsArr <> nil then  //套装系统
      FillChar(g_SetItemsArr[0], Length(g_SetItemsArr), False);  //套装系统
    boSetItem := False;  
    for i := Low(THumanUseItems) to High(THumanUseItems) do begin
      if (m_UseItems[i].wIndex <= 0) or ((m_UseItems[i].Dura <= 0) and (i <> U_HOUSE)) then Continue;
      GetAccessory(@m_UseItems[i], m_AddAbil);
      StdItem := UserEngine.GetStdItem(m_UseItems[i].wIndex);
      if StdItem = nil then Continue;

      //套装系统 begin
      if (StdItem.SetItemList <> nil) and (g_SetItemsArr <> nil) then begin
        for k := 0 to StdItem.SetItemList.Count - 1 do begin
          nIndex := Integer(StdItem.SetItemList[K]);
          if (nIndex >= Low(g_SetItemsArr)) and (nIndex <= High(g_SetItemsArr)) then begin
            g_SetItemsArr[nIndex] := True;
            boSetItem := True;
          end;
        end;
      end;
      //套装系统 end

      if (sm_ArmingStrong in StdItem.StdModeEx) or (StdItem.StdMode = tm_Light) then begin
        Inc(nStrengthenCount, m_UseItems[i].Value.StrengthenInfo.btStrengthenCount);
        if (i = U_WEAPON) or (i = U_RIGHTHAND) or (i = U_DRESS) then begin
          if i = U_DRESS then begin
            Inc(m_WAbil.WearWeight, StdItem.Weight);
            m_btHorseDress := StdItem.Source;
          end
          else
            Inc(m_WAbil.HandWeight, StdItem.Weight);
          CheckSource := StdItem.AniCount;
        end
        else begin
          Inc(m_WAbil.WearWeight, StdItem.Weight);
          CheckSource := StdItem.Shape;
        end;

        //新增开始
        case CheckSource of
          111: begin
              m_wStatusTimeArr[STATE_TRANSPARENT {8 0x70}] := 6 * 10 * 1000;
              m_boHideMode := True;
            end;
          112: m_boTeleport := True;
          113: m_boParalysis := True;
          114: m_boRevival := True;
          115: m_boFlameRing := True;
          116: m_boRecoveryRing := True;
          117: m_boAngryRing := True;
          118: m_boMagicShield := True;
          119: m_boMuscleRing := True;
          120: m_boFastTrain := True;
          121: m_boProbeNecklace := True;
          122: boRecallSuite2 := True;
          123: boRecallSuite1 := True;
          124: boRecallSuite3 := True;
          125: boRecallSuite4 := True;
          126: boSpirit3 := True;
          127: boSpirit1 := True;
          128: boSpirit2 := True;
          129: boSpirit4 := True;
          133: begin
              boMoXieSuite2 := True;
              Inc(m_nMoXieSuite, StdItem.AniCount);
            end;
          134: begin
              boMoXieSuite3 := True;
              Inc(m_nMoXieSuite, StdItem.AniCount);
            end;
          135: begin
              boMoXieSuite1 := True;
              Inc(m_nMoXieSuite, StdItem.Weight div 10);
            end;
          136: begin
              boHongMoSuite2 := True;
              Inc(m_nHongMoSuite, StdItem.AniCount);
            end;
          137: begin
              boHongMoSuite3 := True;
              Inc(m_nHongMoSuite, StdItem.AniCount);
            end;
          138: Inc(m_nHongMoSuite, StdItem.Weight);
          139: m_boUnParalysis := True;
          140: m_boSupermanItem := True;
          141: begin
              m_boExpItem := True;
              m_rExpItem := m_rExpItem + (m_UseItems[i].Dura /
                g_Config.nItemExpRate);
            end;
          142: begin
              m_boPowerItem := True;
              m_rPowerItem := m_rPowerItem + (m_UseItems[i].Dura /
                g_Config.nItemPowerRate);
            end;
          143: m_boUnMagicShield := True;
          144: m_boUnRevival := True;
          145: m_boGuildMove := True;
          150: begin //麻痹护身
              m_boParalysis := True;
              m_boMagicShield := True;
            end;
          151: begin //麻痹火球
              m_boParalysis := True;
              m_boFlameRing := True;
            end;
          152: begin //麻痹防御
              m_boParalysis := True;
              m_boRecoveryRing := True;
            end;
          153: begin //麻痹负载
              m_boParalysis := True;
              m_boMuscleRing := True;
            end;
          154: begin //护身火球
              m_boMagicShield := True;
              m_boFlameRing := True;
            end;
          155: begin //护身防御
              m_boMagicShield := True;
              m_boRecoveryRing := True;
            end;
          156: begin //护身负载
              m_boMagicShield := True;
              m_boMuscleRing := True;
            end;
          157: begin //传送麻痹
              m_boTeleport := True;
              m_boParalysis := True;
            end;
          158: begin //传送护身
              m_boTeleport := True;
              m_boMagicShield := True;
            end;
          159: begin //传送探测
              m_boTeleport := True;
              m_boProbeNecklace := True;
            end;
          160: begin //传送复活
              m_boTeleport := True;
              m_boRevival := True;
            end;
          161: begin //麻痹复活
              m_boParalysis := True;
              m_boRevival := True;
            end;
          162: begin //护身复活
              m_boMagicShield := True;
              m_boRevival := True;
            end;
          163: begin //防麻传送
              m_boUnParalysis := True;
              m_boTeleport := True;
            end;
          {164: begin //防毒传送
              m_boTeleport := True;
            end;}
          170: m_boAngryRing := True;
          171: m_boNoDropItem := True;
          172: m_boNoDropUseItem := True;
          //PK 死亡掉经验
          180: m_dwPKDieLostExp := StdItem.DuraMax * g_Config.dwPKDieLostExpRate;
          181: m_nPKDieLostLevel := StdItem.DuraMax div g_Config.nPKDieLostLevelRate; //PK 死亡掉等级
          182: begin
              m_boExpItem := True;
              m_rExpItem := m_rExpItem + (m_UseItems[i].DuraMax /
                g_Config.nItemExpRate);
            end;
          183: begin
              m_boPowerItem := True;
              m_rPowerItem := m_rPowerItem + (m_UseItems[i].DuraMax /
                g_Config.nItemPowerRate);
            end;
        end;
      end;
      //新增结束

      if (i = U_RIGHTHAND) then begin
        if StdItem.Shape > 0 then
          m_btDressEffType := StdItem.Shape;
      end
      else if (i = U_DRESS) then begin
        //if m_UseItems[i].Value.btValue[5] > 0 then
          //m_btDressEffType := m_UseItems[i].Value.btValue[5];
        if StdItem.AniCount > 0 then
          m_btDressEffType := StdItem.AniCount;
      end
      else if i = U_BUJUK then begin //传送符
        if (StdItem.StdMode = tm_Amulet) and (StdItem.Shape = 6) then begin
          m_boTeleportEx := True;
        end;
      end
      {else if i = U_VIP then begin //传送符
        m_nItemKickMonExp := StdItem.AniCount;
        m_dwItemWuXinExpRate := StdItem.Source;
      end  }
      else if i = U_HOUSE then begin //坐骑信息
{$IF Var_Free = 1}
        m_btHorseType := 0;
        m_boHorseHit := False;
{$ELSE}
        m_btHorseType := StdItem.Shape;
        if StdItem.StdMode2 = 33 then
          m_boHorseHit := True;
{$IFEND}
      end;

    end; //for end

    //套装系统 begin
    if boSetItem and (g_SetItemsArr <> nil) then begin
      for I := Low(g_SetItemsArr) to High(g_SetItemsArr) do begin
        if g_SetItemsArr[I] and (I >= 0) and (I < g_SetItemsList.Count) then begin
          SetItems := g_SetItemsList[I];
          boSetItem := True;
          for k := Low(SetItems.Items) to High(SetItems.Items) do begin
            if not boSetItem then Break;
            if (SetItems.Items[k] <> '') then begin
              if (k = U_DRESS) or (k = U_BUJUK) then begin
                if (k = U_DRESS) and (m_btGender = 1) then Continue;
                if (k = U_BUJUK) and (m_btGender = 0) then Continue;
                if (m_UseItems[U_DRESS].wIndex <= 0) or (m_UseItems[U_DRESS].Dura <= 0) or (UserEngine.GetStdItemName(m_UseItems[U_DRESS].wIndex) <> SetItems.Items[k]) then begin
                  boSetItem := False;
                  Break;
                end;
              end else
              if (k = U_ARMRINGL) then begin
                sItemNameL := '';
                sItemNameR := '';
                if (m_UseItems[U_ARMRINGL].wIndex > 0) and (m_UseItems[U_ARMRINGL].Dura > 0) then
                  sItemNameL := UserEngine.GetStdItemName(m_UseItems[U_ARMRINGL].wIndex);
                if (m_UseItems[U_ARMRINGR].wIndex > 0) and (m_UseItems[U_ARMRINGR].Dura > 0) then
                  sItemNameR := UserEngine.GetStdItemName(m_UseItems[U_ARMRINGR].wIndex);

                if (sItemNameL <> SetItems.Items[k]) and (sItemNameR <> SetItems.Items[k]) then begin
                  boSetItem := False;
                  Break;
                end;
                
                if boSetItem and (SetItems.Items[U_ARMRINGR] <> '') then begin
                  if (sItemNameL = SetItems.Items[k]) and (sItemNameR <> SetItems.Items[U_ARMRINGR]) then begin
                    boSetItem := False;
                    Break;
                  end else
                  if (sItemNameR = SetItems.Items[k]) and (sItemNameL <> SetItems.Items[U_ARMRINGR]) then begin
                    boSetItem := False;
                    Break;
                  end;
                end;
              end else
              if (k = U_ARMRINGR) then begin
                sItemNameL := '';
                sItemNameR := '';
                if (m_UseItems[U_ARMRINGL].wIndex > 0) and (m_UseItems[U_ARMRINGL].Dura > 0) then
                  sItemNameL := UserEngine.GetStdItemName(m_UseItems[U_ARMRINGL].wIndex);
                if (m_UseItems[U_ARMRINGR].wIndex > 0) and (m_UseItems[U_ARMRINGR].Dura > 0) then
                  sItemNameR := UserEngine.GetStdItemName(m_UseItems[U_ARMRINGR].wIndex);

                if (sItemNameL <> SetItems.Items[k]) and (sItemNameR <> SetItems.Items[k]) then begin
                  boSetItem := False;
                  Break;
                end;
              end else
              if (k = U_RINGL) then begin
                sItemNameL := '';
                sItemNameR := '';
                if (m_UseItems[U_RINGL].wIndex > 0) and (m_UseItems[U_RINGL].Dura > 0) then
                  sItemNameL := UserEngine.GetStdItemName(m_UseItems[U_RINGL].wIndex);
                if (m_UseItems[U_RINGR].wIndex > 0) and (m_UseItems[U_RINGR].Dura > 0) then
                  sItemNameR := UserEngine.GetStdItemName(m_UseItems[U_RINGR].wIndex);

                if (sItemNameL <> SetItems.Items[k]) and (sItemNameR <> SetItems.Items[k]) then begin
                  boSetItem := False;
                  Break;
                end;
                
                if boSetItem and (SetItems.Items[U_RINGR] <> '') then begin
                  if (sItemNameL = SetItems.Items[k]) and (sItemNameR <> SetItems.Items[U_RINGR]) then begin
                    boSetItem := False;
                    Break;
                  end else
                  if (sItemNameR = SetItems.Items[k]) and (sItemNameL <> SetItems.Items[U_RINGR]) then begin
                    boSetItem := False;
                    Break;
                  end;
                end;
              end else
              if (k = U_RINGR) then begin
                sItemNameL := '';
                sItemNameR := '';
                if (m_UseItems[U_RINGL].wIndex > 0) and (m_UseItems[U_RINGL].Dura > 0) then
                  sItemNameL := UserEngine.GetStdItemName(m_UseItems[U_RINGL].wIndex);
                if (m_UseItems[U_RINGR].wIndex > 0) and (m_UseItems[U_RINGR].Dura > 0) then
                  sItemNameR := UserEngine.GetStdItemName(m_UseItems[U_RINGR].wIndex);

                if (sItemNameL <> SetItems.Items[k]) and (sItemNameR <> SetItems.Items[k]) then begin
                  boSetItem := False;
                  Break;
                end;
              end else begin
                if (m_UseItems[k].wIndex <= 0) or (m_UseItems[k].Dura <= 0) or (UserEngine.GetStdItemName(m_UseItems[k].wIndex) <> SetItems.Items[k]) then begin
                  boSetItem := False;
                  Break;
                end;
              end;
            end;
          end; // end for
          if boSetItem then begin
            for K := Low(SetItems.Value) to High(SetItems.Value) do begin
              if SetItems.Value[K] <= 0 then Continue;
              Try
                case K of
                  0: Inc(m_AddAbil.AC2, SetItems.Value[K]); //防御
                  1: Inc(m_AddAbil.MAC2, SetItems.Value[K]); //魔御
                  2: Inc(m_AddAbil.DC2, SetItems.Value[K]); //攻击
                  3: Inc(m_AddAbil.MC2, SetItems.Value[K]); //魔法
                  4: Inc(m_AddAbil.SC2, SetItems.Value[K]); //道术
                  5: Inc(m_AddAbil.wHitPoint, SetItems.Value[K]); //准确
                  6: Inc(m_AddAbil.wSpeedPoint, SetItems.Value[K]); //敏捷
                  7: Inc(m_AddAbil.HP, SetItems.Value[K]); //生命值
                  8: Inc(m_AddAbil.MP, SetItems.Value[K]); //魔法值
                  9: m_AddAbil.AC2 := Round(SetItems.Value[K] / 10 * m_AddAbil.AC2); //防御倍数
                  10: m_AddAbil.MAC2 := Round(SetItems.Value[K] / 10 * m_AddAbil.MAC2); //魔御倍数
                  11: m_AddAbil.DC2 := Round(SetItems.Value[K] / 10 * m_AddAbil.DC2); //攻击倍数
                  12: m_AddAbil.MC2 := Round(SetItems.Value[K] / 10 * m_AddAbil.MC2); //魔法倍数
                  13: m_AddAbil.SC2 := Round(SetItems.Value[K] / 10 * m_AddAbil.SC2); //道术倍数
                  14: Inc(m_AddAbil.wHealthRecover, SetItems.Value[K]); //体力恢复
                  15: Inc(m_AddAbil.wSpellRecover, SetItems.Value[K]); //魔法恢复
                  16: Inc(m_AddAbil.wPoisonRecover, SetItems.Value[K]); //中毒恢复
                  17: Inc(m_AddAbil.wAntiMagic, SetItems.Value[K]); //魔法躲避
                  18: Inc(m_AddAbil.wAntiPoison, SetItems.Value[K]); //毒物躲避
                  19: Inc(m_AddAbil.wAddAttack, SetItems.Value[K]); //伤害加成
                  20: Inc(m_AddAbil.wDelDamage, SetItems.Value[K]); //伤害吸收
                  21: Inc(m_AddAbil.btDeadliness, SetItems.Value[K]); //致命一击
                  22: Inc(m_nSetItemExp, SetItems.Value[K]); //经验倍数
                  23: m_boParalysis := True; //麻痹
                  24: m_boMagicShield := True; //护身
                  25: m_boRevival := True; //复活

                end;
              Except
              End;
            end;
          end;
        end;
      end;
    end;
    //套装系统 end       
  end;

  {
  Inc(m_btAddAttack, m_AddAbil.wAddAttack); //伤害加成
  Inc(m_btDelDamage, m_AddAbil.wDelDamage); //伤害吸收
  Inc(m_btAddWuXinAttack, m_AddAbil.wAddWuXinAttack); //五行攻击
  Inc(m_btDelWuXinAttack, m_AddAbil.wDelWuXinAttack); //五行防御
  Inc(m_btHitPoint, m_AddAbil.wHitPoint); //准确
  Inc(m_btSpeedPoint, m_AddAbil.wSpeedPoint); //敏捷
  Inc(m_btAntiPoison, m_AddAbil.wAntiPoison); //       //毒物躲避
  Inc(m_nPoisonRecover, m_AddAbil.wPoisonRecover); //毒物恢复
  Inc(m_nHealthRecover, m_AddAbil.wHealthRecover); //体力恢复
  Inc(m_nSpellRecover, m_AddAbil.wSpellRecover); //魔法恢复
  Inc(m_nAntiMagic, m_AddAbil.wAntiMagic); //魔法躲避
  Inc(m_nLuck, m_AddAbil.btLuck); //幸运
  Inc(m_btDeadliness, m_AddAbil.btDeadliness);

  sItemNameL, sItemNameR
  if (m_UseItems[i].wIndex <= 0) or ((m_UseItems[i].Dura <= 0) and (i <> U_HOUSE)) then Continue;
      GetAccessory(@m_UseItems[i], m_AddAbil);
      StdItem := UserEngine.GetStdItem(m_UseItems[i].wIndex);
      if StdItem = nil then Continue;
  U_DRESS = 0;
  U_WEAPON = 1;
  U_HELMET = 2;
  U_NECKLACE = 3;
  U_RIGHTHAND = 4;
  U_ARMRINGL = 5;
  U_ARMRINGR = 6;
  U_RINGL = 7;
  U_RINGR = 8;
  U_BUJUK = 9;
  U_BELT = 10;
  U_BOOTS = 11;
  U_CHARM = 12;
  U_HOUSE = 13;
  U_CIMELIA = 14;}


  if nStrengthenCount >= 150 then m_btStrengthenName := 10
  else if nStrengthenCount >= 130 then m_btStrengthenName := 9
  else if nStrengthenCount >= 120 then m_btStrengthenName := 8
  else if nStrengthenCount >= 100 then m_btStrengthenName := 7
  else if nStrengthenCount >= 90 then m_btStrengthenName := 6
  else if nStrengthenCount >= 70 then m_btStrengthenName := 5
  else if nStrengthenCount >= 60 then m_btStrengthenName := 4
  else if nStrengthenCount >= 40 then m_btStrengthenName := 3
  else if nStrengthenCount >= 30 then m_btStrengthenName := 2
  else if nStrengthenCount >= 10 then m_btStrengthenName := 1
  else m_btStrengthenName := 0;

  if boRecallSuite1 and
    boRecallSuite2 and
    boRecallSuite3 and
    boRecallSuite4 then
    m_boRecallSuite := True;
  if boMoXieSuite1 and
    boMoXieSuite2 and
    boMoXieSuite3 then
    Inc(m_nMoXieSuite, 50);
  if boHongMoSuite1 and
    boHongMoSuite2 and
    boHongMoSuite3 then
    Inc(m_AddAbil.wHitPoint, 2);

  if boSpirit1 and
    boSpirit2 and
    boSpirit3 and
    boSpirit4 then
    m_bopirit := True;

  m_WAbil.Weight := 0; //RecalcBagWeight();

  if m_boTransparent and (m_wStatusTimeArr[STATE_TRANSPARENT {8 0x70}] > 0) then begin
    m_boHideMode := True;
  end;

  if m_boHideMode then begin
    if not boOldHideMode then begin
      m_nCharStatus := GetCharStatus();
      StatusChanged();
    end;
  end
  else begin
    if boOldHideMode then begin
      m_wStatusTimeArr[STATE_TRANSPARENT {8 0x70}] := 0;
      m_nCharStatus := GetCharStatus();
      StatusChanged();
    end;
  end;
  //01-20 增加此行，只有类型为人物的角色才重新计算攻击敏捷
  if (m_btRaceServer = RC_PLAYOBJECT) then
    TPlayObject(Self).RecalcHitSpeed();


  //发送光照效果,已取消
  {nOldLight := m_nLight;
  if (m_UseItems[U_RIGHTHAND].wIndex > 0) and (m_UseItems[U_RIGHTHAND].Dura > 0)
    then
    m_nLight := 3
  else
    m_nLight := 0;
  if nOldLight <> m_nLight then
    SendRefMsg(RM_CHANGELIGHT, 0, 0, 0, 0, ''); }
  Inc(m_btAddAttack, m_AddAbil.wAddAttack); //伤害加成
  Inc(m_btDelDamage, m_AddAbil.wDelDamage); //伤害吸收
  Inc(m_btAddWuXinAttack, m_AddAbil.wAddWuXinAttack); //五行攻击
  Inc(m_btDelWuXinAttack, m_AddAbil.wDelWuXinAttack); //五行防御
  Inc(m_btHitPoint, m_AddAbil.wHitPoint); //准确
  Inc(m_btSpeedPoint, m_AddAbil.wSpeedPoint); //敏捷
  Inc(m_btAntiPoison, m_AddAbil.wAntiPoison); //       //毒物躲避
  Inc(m_nPoisonRecover, m_AddAbil.wPoisonRecover); //毒物恢复
  Inc(m_nHealthRecover, m_AddAbil.wHealthRecover); //体力恢复
  Inc(m_nSpellRecover, m_AddAbil.wSpellRecover); //魔法恢复
  Inc(m_nAntiMagic, m_AddAbil.wAntiMagic); //魔法躲避
  Inc(m_nLuck, m_AddAbil.btLuck); //幸运
  Inc(m_btDeadliness, m_AddAbil.btDeadliness);

  m_nHitSpeed := m_AddAbil.nHitSpeed; //攻击速度
  m_nItemExp := m_AddAbil.btExpRate; //装备经验加成

  {Inc(nHPorMPRate, m_AddAbil.btHPorMPRate);
    Inc(nAC2Rate, m_AddAbil.btAC2Rate);
    Inc(nMAC2Rate, m_AddAbil.btMAC2Rate);
    Inc(m_nItemExp, m_AddAbil.btExpRate);   }

  

  m_WAbil.MaxHP := _MIN(MaxInt,  Round((m_AddAbil.btHPorMPRate / 100 + 1) * m_Abil.MaxHP + m_AddAbil.HP + m_NakedAddAbil.nHP));
  m_WAbil.MaxMP := _MIN(MaxInt, Round((m_AddAbil.btHPorMPRate / 100 + 1) * m_Abil.MaxMP + m_AddAbil.MP));

  m_WAbil.AC := MakeLong(m_AddAbil.AC + LoWord(m_Abil.AC) + m_NakedAddAbil.nAc, m_AddAbil.AC2 + HiWord(m_Abil.AC));
  m_WAbil.MAC := MakeLong(m_AddAbil.MAC + LoWord(m_Abil.MAC) + m_NakedAddAbil.nMAc, m_AddAbil.MAC2 + HiWord(m_Abil.MAC));

  m_WAbil.AC := MakeLong(LoWord(m_WAbil.AC) + m_TempAddAbil.AC, Round((m_AddAbil.btAC2Rate / 100 + 1) * HiWord(m_WAbil.AC) + m_NakedAddAbil.nAc2) + m_TempAddAbil.AC2);
  m_WAbil.MAC := MakeLong(LoWord(m_WAbil.MAC) + m_TempAddAbil.MAC, Round((m_AddAbil.btMAC2Rate / 100 + 1) * HiWord(m_WAbil.MAC) + m_NakedAddAbil.nMAc2) + m_TempAddAbil.MAC2);


  m_WAbil.DC := MakeLong(m_AddAbil.DC + LoWord(m_Abil.DC) + m_NakedAddAbil.nDc + m_TempAddAbil.DC, m_AddAbil.DC2 + HiWord(m_Abil.DC) + m_NakedAddAbil.nDc2 + m_TempAddAbil.DC2);
  m_WAbil.MC := MakeLong(m_AddAbil.MC + LoWord(m_Abil.MC) + m_NakedAddAbil.nMc + m_TempAddAbil.MC, m_AddAbil.MC2 + HiWord(m_Abil.MC) + m_NakedAddAbil.nMc2 + m_TempAddAbil.MC2);
  m_WAbil.SC := MakeLong(m_AddAbil.SC + LoWord(m_Abil.SC) + m_NakedAddAbil.nSc + m_TempAddAbil.SC, m_AddAbil.SC2 + HiWord(m_Abil.SC) + m_NakedAddAbil.nSc2 + m_TempAddAbil.SC2);

  if m_wStatusTimeArr[STATE_DEFENCEUP {10 0x72}] > 0 then begin
    if m_boAC then
      m_WAbil.AC := MakeLong(LoWord(m_WAbil.AC), HiWord(m_WAbil.AC) + 10 + (m_wStatusTimeArr[STATE_DEFENCEUP] div 10))
    else
      m_WAbil.AC := MakeLong(LoWord(m_WAbil.AC), HiWord(m_WAbil.AC) - 10 - (m_wStatusTimeArr[STATE_DEFENCEUP] div (10+m_Abil.Level))); //新增减属性
  end;
  if m_wStatusTimeArr[STATE_MAGDEFENCEUP {11 0x74}] > 0 then begin
    if m_boMAC then
      m_WAbil.MAC := MakeLong(LoWord(m_WAbil.MAC), HiWord(m_WAbil.MAC) + 10 + (m_wStatusTimeArr[STATE_MAGDEFENCEUP] div 10))
    else
      m_WAbil.MAC := MakeLong(LoWord(m_WAbil.MAC), HiWord(m_WAbil.MAC) - 10 - (m_wStatusTimeArr[STATE_MAGDEFENCEUP] div (10+m_Abil.Level)));
  end;

  if m_wStatusArrValue[0] > 0 then begin
    if m_boDC then begin
      m_WAbil.DC := MakeLong(LoWord(m_WAbil.DC), HiWord(m_WAbil.DC) + 2 + m_wStatusArrValue[0] {n218})
    end
    else begin
      if LoWord(m_WAbil.DC) > (HiWord(m_WAbil.DC) - m_wStatusArrValue[0]) then
        m_WAbil.DC := MakeLong(LoWord(m_WAbil.DC), LoWord(m_WAbil.DC) {n218})
      else
        m_WAbil.DC := MakeLong(LoWord(m_WAbil.DC), HiWord(m_WAbil.DC) - m_wStatusArrValue[0] {n218})
    end;
  end;

  if m_wStatusArrValue[1] > 0 then begin
    if m_boMC then begin
      m_WAbil.MC := MakeLong(LoWord(m_WAbil.MC), HiWord(m_WAbil.MC) + 2 + m_wStatusArrValue[1] {n219})
    end
    else begin
      if LoWord(m_WAbil.MC) > (HiWord(m_WAbil.MC) - m_wStatusArrValue[1]) then
        m_WAbil.MC := MakeLong(LoWord(m_WAbil.MC), LoWord(m_WAbil.MC) {n218})
      else
        m_WAbil.MC := MakeLong(LoWord(m_WAbil.MC), HiWord(m_WAbil.MC) - m_wStatusArrValue[1] {n218})
    end;
  end;

  if m_wStatusArrValue[2] > 0 then begin
    if m_boSC then begin
      m_WAbil.SC := MakeLong(LoWord(m_WAbil.SC), HiWord(m_WAbil.SC) + 2 + m_wStatusArrValue[2] {n21A})
    end
    else begin
      if LoWord(m_WAbil.SC) > (HiWord(m_WAbil.SC) - m_wStatusArrValue[2]) then
        m_WAbil.SC := MakeLong(LoWord(m_WAbil.SC), LoWord(m_WAbil.SC) {n218})
      else
        m_WAbil.SC := MakeLong(LoWord(m_WAbil.SC), HiWord(m_WAbil.SC) - m_wStatusArrValue[2] {n218})
    end;
  end;

  if m_wStatusArrValue[3] > 0 then begin
    if m_boHitSpeed then
      Inc(m_nHitSpeed, m_wStatusArrValue[3] {n21B})
    else
      Dec(m_nHitSpeed, m_wStatusArrValue[3]);
  end;

  if m_wStatusArrValue[4] > 0 then begin //  if n21C > 0 then
    if m_boMaxHP then
      m_WAbil.MaxHP := _MIN(MaxInt, m_WAbil.MaxHP + m_wStatusArrValue[4])
    else
      m_WAbil.MaxHP := _MIN(MaxInt, m_WAbil.MaxHP - m_wStatusArrValue[4]);
  end;

  if m_wStatusArrValue[5] > 0 then begin
    if m_boMaxMP then
      m_WAbil.MaxMP := _MIN(MaxInt, m_WAbil.MaxMP + m_wStatusArrValue[5])
    else
      m_WAbil.MaxMP := _MIN(MaxInt, m_WAbil.MaxMP - m_wStatusArrValue[5]);
  end;

  //火球和治俞戒指取消
  {if (m_btRaceServer = RC_PLAYOBJECT) then begin
    if m_boFlameRing then
      AddItemSkill(1)
    else
      DelItemSkill(1);

    if m_boRecoveryRing then
      AddItemSkill(2)
    else
      DelItemSkill(2);
  end;  }

  if m_boMuscleRing then begin //活力
    Inc(m_WAbil.MaxWeight, m_WAbil.MaxWeight);
    Inc(m_WAbil.MaxWearWeight, m_WAbil.MaxWearWeight);
    Inc(m_WAbil.MaxHandWeight, m_WAbil.MaxHandWeight);
  end;
  if m_nMoXieSuite > 0 then begin //魔血
    if m_WAbil.MaxMP <= m_nMoXieSuite then
      m_nMoXieSuite := m_WAbil.MaxMP - 1;
    Dec(m_WAbil.MaxMP, m_nMoXieSuite);
    //Inc(m_WAbil.MaxHP,m_nMoXieSuite);
    m_WAbil.MaxHP := _MIN(MaxInt, m_WAbil.MaxHP + m_nMoXieSuite);
  end;

  if m_btRaceServer = RC_PLAYOBJECT then begin
    SendUpdateMsg(Self, RM_CHARSTATUSCHANGED, m_nHitSpeed, m_nCharStatus, 0, 0, '');
  end;

  if (m_btRaceServer >= RC_ANIMAL) then begin
    MonsterRecalcAbilitys();
  end;



  m_OldHP := m_WAbil.MaxHP;
  m_WAbil.MaxHP := _MIN(MaxInt, m_WAbil.MaxHP + m_AddHP);

  m_WAbil.HP := _MIN(m_WAbil.MaxHP, m_WAbil.HP);
  m_WAbil.MP := _MIN(m_WAbil.MaxMP, m_WAbil.MP);

  if m_boOnHorse and (m_UseItems[u_House].wIndex > 0) then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[u_House].wIndex);
    if StdItem <> nil then begin
      FillChar(AddAbility, SizeOf(AddAbility), #0);
      GetHorseLevelAbility(@m_UseItems[u_House], StdItem, AddAbility);
      for I := Low(m_UseItems[u_House].HorseItems) to High(m_UseItems[u_House].HorseItems) do begin
        if m_UseItems[u_House].HorseItems[I].wIndex > 0 then begin
          StdItem := UserEngine.GetStdItem(m_UseItems[u_House].HorseItems[I].wIndex);
          if StdItem <> nil then
            GetHorseAddAbility(@m_UseItems[u_House], StdItem, I, AddAbility);
        end;
      end;
      m_WAbil.AC := MakeLong(AddAbility.AC, AddAbility.AC2);
      m_WAbil.MAC := MakeLong(AddAbility.MAC, AddAbility.MAC2);
      m_WAbil.DC := MakeLong(AddAbility.DC, AddAbility.DC2);
      m_WAbil.MC := 0;
      m_WAbil.SC := 0;
      m_WAbil.MAXHP := AddAbility.HP;

      m_btAddAttack := 0;
      m_btDelDamage := 0;
      m_btAddWuXinAttack := 0;
      m_btDelWuXinAttack := 0;
      m_btHitPoint := AddAbility.wHitPoint;
      m_btSpeedPoint := AddAbility.wSpeedPoint;
      m_btAntiPoison := 0;
      m_nPoisonRecover := 0;
      m_nHealthRecover := 0;
      m_nSpellRecover := 0;
      m_nAntiMagic := 1;
      m_nLuck := 0;
      m_btDeadliness := 0;

      m_OldHP := m_WAbil.MaxHP;

      m_WAbil.HP := _MIN(m_WAbil.MaxHP, m_WAbil.HP);
      m_WAbil.MP := _MIN(m_WAbil.MaxMP, m_WAbil.MP);
    end;
  end;
end;

procedure TBaseObject.BreakOpenHealth();
begin
  if m_boShowHP then begin
    m_boShowHP := False;
    m_nCharStatusEx := m_nCharStatusEx xor STATE_OPENHEATH;
    m_nCharStatus := GetCharStatus();
    SendRefMsg(RM_CLOSEHEALTH, 0, 0, 0, 0, '');
  end;
end;

procedure TBaseObject.MakeOpenHealth();
begin
  m_boShowHP := True;
  m_nCharStatusEx := m_nCharStatusEx or STATE_OPENHEATH;
  m_nCharStatus := GetCharStatus();
  SendRefMsg(RM_OPENHEALTH, 0, m_WAbil.HP, m_WAbil.MaxHP, 0, '');
end;

procedure TBaseObject.IncHealthSpell(nHP, nMP: Integer);
begin
  if (nHP < 0) or (nMP < 0) then Exit;
  if (m_WAbil.HP + nHP) >= m_WAbil.MaxHP then
    m_WAbil.HP := m_WAbil.MaxHP
  else
    Inc(m_WAbil.HP, nHP);
  if (m_WAbil.MP + nMP) >= m_WAbil.MaxMP then
    m_WAbil.MP := m_WAbil.MaxMP
  else
    Inc(m_WAbil.MP, nMP);
  HealthSpellChanged();
end;

procedure TBaseObject.ItemDamageRevivalRing();
var
  i: Integer;
  pSItem: pTStdItem;
  nDura, tDura: Integer;
  PlayObject: TPlayObject;
begin
  for i := Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[i].wIndex > 0 then begin
      pSItem := UserEngine.GetStdItem(m_UseItems[i].wIndex);
      if pSItem <> nil then begin
        //        if (i = U_RINGR) or (i = U_RINGL) then begin
        if (pSItem.Shape in [114, 160, 161, 162]) or (((i = U_WEAPON) or (i =
          U_RIGHTHAND)) and (pSItem.AniCount in [114, 160, 161, 162])) then begin
          nDura := m_UseItems[i].Dura;
          tDura := ROUND(nDura / 1000 {1.03});
          Dec(nDura, 1000);
          if nDura <= 0 then begin
            nDura := 0;
            m_UseItems[i].Dura := nDura;
            if m_btRaceServer = RC_PLAYOBJECT then begin
              PlayObject := TPlayObject(Self);
              PlayObject.SendDelItems(@m_UseItems[i]);
            end; //004C0310
            m_UseItems[i].wIndex := 0;
            RecalcAbilitys();
          end
          else begin //004C0331
            m_UseItems[i].Dura := nDura;
          end;
          if tDura <> ROUND(nDura / 1000 {1.03}) then begin
            DuraChange(i, m_UseItems[i].Dura, m_UseItems[i].DuraMax);
            //SendMsg(Self, RM_aDURACHANGE, i, nDura, m_UseItems[i].DuraMax, 0, '');
          end;
          //break;
        end; //004C0397
        //        end;//004C0397
      end; //004C0397 if pSItem <> nil then begin
    end; //if UseItems[i].wIndex > 0 then begin
  end; // for i:=Low(UseItems) to High(UseItems) do begin
end;

procedure TBaseObject.Run;
var
  i: Integer;
  boChg: Boolean;
  boNeedRecalc: Boolean;
  nHP, nMP, n18: Integer;
  dwC, dwInChsTime: LongWord;
  ProcessMsg: TProcessMessage;
  BaseObject: TBaseObject;
  nCheckCode: Integer;
  //dwRunTick: LongWord;
  nInteger: Integer;
  StdItem: pTStdItem;
  nCount, dCount, bCount: Integer;
  boSendChange: Boolean;
resourcestring
  sExceptionMsg0 = '[Exception] TBaseObject::Run 0';
  sExceptionMsg1 = '[Exception] TBaseObject::Run 1 ';
  sExceptionMsg2 = '[Exception] TBaseObject::Run 2';
  sExceptionMsg3 = '[Exception] TBaseObject::Run 3 ';
  sExceptionMsg4 = '[Exception] TBaseObject::Run 4 Code:%d';
  sExceptionMsg5 = '[Exception] TBaseObject::Run 5';
  sExceptionMsg6 = '[Exception] TBaseObject::Run 6';
  sExceptionMsg7 = '[Exception] TBaseObject::Run 7';
begin
  nCheckCode := 0;
  //dwRunTick := GetTickCount();
  try
    while GetMessage(@ProcessMsg) do begin
      nCheckCode := 1000;
      Operate(@ProcessMsg);
      nCheckCode := 1001;
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg0);
      MainOutMessage(E.Message);
    end;
  end;
  //SetProcessName('TBaseObject.Run 1');
  //004C7798
  try
    if m_boSuperMan then begin
      m_WAbil.HP := m_WAbil.MaxHP;
      m_WAbil.MP := m_WAbil.MaxMP;
    end;

    dwC := (GetTickCount() - m_dwHPMPTick) div 20;
    m_dwHPMPTick := GetTickCount();
    Inc(m_nHealthTick, dwC);
    Inc(m_nSpellTick, dwC);
    if not m_boDeath then begin
      nCheckCode := 2003;
      if m_WAbil.HP = 0 then begin
        if m_LastHiter = nil then begin
          if m_boRevival and (GetTickCount - m_dwRevivalTick > g_Config.dwRevivalTime {60 * 1000}) then begin
            m_dwRevivalTick := GetTickCount();
            nCheckCode := 1006;
            ItemDamageRevivalRing;
            nCheckCode := 1007;
            m_WAbil.HP := m_WAbil.MaxHP;
            HealthSpellChanged;
            nCheckCode := 1008;
            SysMsg(g_sRevivalRecoverMsg {'复活戒指生效，体力恢复'}, c_Green, t_Hint);
          end;
        end
        else if m_LastHiter <> nil then begin
          if not m_LastHiter.m_boUnRevival {防复活} and m_boRevival and (GetTickCount - m_dwRevivalTick > g_Config.dwRevivalTime {60 * 1000}) then begin
            m_dwRevivalTick := GetTickCount();
            nCheckCode := 1006;
            ItemDamageRevivalRing;
            nCheckCode := 1007;
            m_WAbil.HP := m_WAbil.MaxHP;
            HealthSpellChanged;
            nCheckCode := 1008;
            SysMsg(g_sRevivalRecoverMsg {'复活戒指生效，体力恢复'}, c_Green, t_Hint);
          end;
        end;
        nCheckCode := 2004;
        if (m_WAbil.HP = 0) and (not m_boGhost) then begin
          if (m_btRaceServer = RC_PLAYOBJECT) and (TPlayObject(Self).m_DareObject <> nil) and (TPlayObject(Self).m_DareNpc <> nil) and (TPlayObject(Self).m_DareState = ds_InProgress) then begin
            m_WAbil.HP := m_WAbil.MaxHP;
            HealthSpellChanged;
            TPlayObject(Self).ClearDare(2);
          end else
          if m_boOnHorse then begin
            m_UseItems[u_House].btAliveTime := g_Config.nHorseAliveTime;
            ChangeHorseState(False);
          end else Die;
        end;
      end else begin
        if (m_WAbil.HP < m_WAbil.MaxHP) and (m_nHealthTick >= g_Config.nHealthFillTime) then begin
          n18 := (m_WAbil.MaxHP div 75) + 1;
          //nPlus = m_WAbility.MaxHP / 15 + 1;
          if (m_WAbil.HP + n18) < m_WAbil.MaxHP then begin
            Inc(m_WAbil.HP, n18);
          end
          else begin
            m_WAbil.HP := m_WAbil.MaxHP;
          end;
          nCheckCode := 1002;
          HealthSpellChanged;
          nCheckCode := 1003;
        end;
        nCheckCode := 2002;
        if (m_WAbil.MP < m_WAbil.MaxMP) and (m_nSpellTick >= g_Config.nSpellFillTime) then begin
          n18 := (m_WAbil.MaxMP div 18) + 1;
          if (m_WAbil.MP + n18) < m_WAbil.MaxMP then begin
            Inc(m_WAbil.MP, n18);
          end
          else begin
            m_WAbil.MP := m_WAbil.MaxMP;
          end;
          nCheckCode := 1004;
          HealthSpellChanged;
          nCheckCode := 1005;
        end;
      end;
      if m_nHealthTick >= g_Config.nHealthFillTime then
        m_nHealthTick := 0;
      if m_nSpellTick >= g_Config.nSpellFillTime then
        m_nSpellTick := 0;
      nCheckCode := 1009;
    end
    else begin
      nCheckCode := 1010;
      if m_btRaceServer = RC_PLAYOBJECT then begin
        if m_PEnvir.m_boDieTime and (m_PEnvir.m_dwDieTime > 0) then begin
          if ((GetTickCount() - m_dwDeathTick) > m_PEnvir.m_dwDieTime) then
            MakeGhost();
        end else begin
          if ((GetTickCount() - m_dwDeathTick) > g_Config.dwHumDieMaxTime{60 * 60 * 1000}) then
            MakeGhost();
        end;
      end else begin
        if (GetTickCount() - m_dwDeathTick > g_Config.dwMakeGhostTime{3 * 60 * 1000}) then
          MakeGhost();
      end;

      nCheckCode := 1011;
    end;
  except
    on E: Exception do begin
      //if nCheckCode = 2004 then MakeGhost();
      MainOutMessage(sExceptionMsg1 + IntToStr(nCheckCode) + ' ' + IntToStr(m_btRaceServer));
      MainOutMessage(E.Message);
    end;
  end;

  //血气石处理开始
  try
    boSendChange := False;
    if (not m_boDeath) and (m_btRaceServer = RC_PLAYOBJECT) and (not m_PEnvir.m_boNotStone) and (TPlayObject(Self).m_AttackState <> as_Dare) then begin
      //加HP
      if (m_nIncHealth = 0) and (m_UseItems[U_CHARM].wIndex > 0) and ((GetTickCount - m_nIncHPStoneTime) > g_Config.HPStoneIntervalTime)
        and ((m_WAbil.HP / m_WAbil.MaxHP * 100) < g_Config.HPStoneStartRate) then begin
        m_nIncHPStoneTime := GetTickCount;
        StdItem := UserEngine.GetStdItem(m_UseItems[U_CHARM].wIndex);
        if (StdItem.StdMode = tm_Rock) and (StdItem.Shape in [1, 3]) then begin
          nCount := m_UseItems[U_CHARM].Dura * 10;
          bCount := Trunc(nCount / g_Config.HPStoneAddRate);
          dCount := m_WAbil.MaxHP - m_WAbil.HP;
          if dCount > bCount then
            dCount := bCount;
          //MainOutMessage(Format('%d/%d',[nCount,dCount]));
          if nCount > dCount then begin
            //Dec(nCount,dCount);
            Inc(m_nIncHealth, dCount);
            Dec(m_UseItems[U_CHARM].Dura, Round(dCount / 10));
          end
          else begin
            nCount := 0;
            Inc(m_nIncHealth, nCount);
            m_UseItems[U_CHARM].Dura := 0;
          end;
          if m_UseItems[U_CHARM].Dura >= 1000 then begin
            boSendChange := True;
          end
          else begin
            boSendChange := False;
            m_UseItems[U_CHARM].Dura := 0;
            if m_btRaceServer = RC_PLAYOBJECT then
              TPlayObject(Self).SendDelItems(@m_UseItems[U_CHARM]);
            m_UseItems[U_CHARM].wIndex := 0;
          end;
        end;
      end;
      //加MP
      if (m_nIncSpell = 0) and (m_UseItems[U_CHARM].wIndex > 0) and ((GetTickCount - m_nIncMPStoneTime) > g_Config.MPStoneIntervalTime)
        and ((m_WAbil.MP / m_WAbil.MaxMP * 100) < g_Config.MPStoneStartRate) then begin
        m_nIncMPStoneTime := GetTickCount;
        StdItem := UserEngine.GetStdItem(m_UseItems[U_CHARM].wIndex);
        if (StdItem.StdMode = tm_Rock) and (StdItem.Shape in [2, 3]) then begin
          nCount := m_UseItems[U_CHARM].Dura * 10;
          bCount := Trunc(nCount / g_Config.MPStoneAddRate);
          dCount := m_WAbil.MaxMP - m_WAbil.MP;
          if dCount > bCount then
            dCount := bCount;
          if nCount > dCount then begin
            //Dec(nCount,dCount);
            Inc(m_nIncSpell, dCount);
            Dec(m_UseItems[U_CHARM].Dura, Round(dCount / 10));
          end
          else begin
            nCount := 0;
            Inc(m_nIncSpell, nCount);
            m_UseItems[U_CHARM].Dura := 0;
          end;
          if m_UseItems[U_CHARM].Dura >= 1000 then begin
            boSendChange := True;
          end
          else begin
            boSendChange := False;
            m_UseItems[U_CHARM].Dura := 0;
            if m_btRaceServer = RC_PLAYOBJECT then
              TPlayObject(Self).SendDelItems(@m_UseItems[U_CHARM]);
            m_UseItems[U_CHARM].wIndex := 0;
          end;
        end;
      end;
      if boSendChange and (m_btRaceServer = RC_PLAYOBJECT) then
        DuraChange(U_CHARM, m_UseItems[U_CHARM].Dura,
          m_UseItems[U_CHARM].DuraMax);
    end;
  except
    MainOutMessage(sExceptionMsg7);
  end;
  //血气石处理结束

  try
    if not m_boDeath and ((m_nIncSpell > 0) or (m_nIncHealth > 0) or (m_nIncHealing > 0)) then begin
      dwInChsTime := 600 - _MIN(400, m_Abil.Level * 10);
      if ((GetTickCount - m_dwIncHealthSpellTick) >= dwInChsTime) and not m_boDeath then begin
        dwC := _MIN(200, (GetTickCount - m_dwIncHealthSpellTick - dwInChsTime));
        m_dwIncHealthSpellTick := GetTickCount() + dwC;
        if (m_nIncSpell > 0) or (m_nIncHealth > 0) or (m_nPerHealing > 0) then begin
          if (m_nPerHealth <= 0) then
            m_nPerHealth := 1;
          if (m_nPerSpell <= 0) then
            m_nPerSpell := 1;
          if (m_nPerHealing <= 0) then
            m_nPerHealing := 1;
          if m_nIncHealth < m_nPerHealth then begin
            nHP := m_nIncHealth;
            m_nIncHealth := 0;
          end
          else begin
            nHP := m_nPerHealth;
            Dec(m_nIncHealth, m_nPerHealth);
          end;
          if m_nIncSpell < m_nPerSpell then begin
            nMP := m_nIncSpell;
            m_nIncSpell := 0;
          end
          else begin
            nMP := m_nPerSpell;
            Dec(m_nIncSpell, m_nPerSpell);
          end;
          if m_nIncHealing < m_nPerHealing then begin
            Inc(nHP, m_nIncHealing);
            m_nIncHealing := 0;
          end
          else begin
            Inc(nHP, m_nPerHealing);
            Dec(m_nIncHealing, m_nPerHealing);
          end;
          m_nPerHealth := (m_Abil.Level div 10 + 5);
          m_nPerSpell := (m_Abil.Level div 10 + 5);
          m_nPerHealing := 5;
          IncHealthSpell(nHP, nMP);
          if m_WAbil.HP = m_WAbil.MaxHP then begin
            m_nIncHealth := 0;
            m_nIncHealing := 0;
          end;
          if m_WAbil.MP = m_WAbil.MaxMP then begin
            m_nIncSpell := 0;
          end;
        end;
      end;
    end
    else begin
      m_dwIncHealthSpellTick := GetTickCount();
    end;
    if (m_nHealthTick < -g_Config.nHealthFillTime) and (m_WAbil.HP > 1) then begin //Jacky ????
      Dec(m_WAbil.HP);
      Inc(m_nHealthTick, g_Config.nHealthFillTime);
      HealthSpellChanged();
    end;
    //检查HP/MP值是否大于最大值，大于则降低到正常大小
    boNeedRecalc := False;
    if m_WAbil.HP > m_WAbil.MaxHP then begin
      boNeedRecalc := True;
      m_WAbil.HP := m_WAbil.MaxHP - 1;
    end;
    if m_WAbil.MP > m_WAbil.MaxMP then begin
      boNeedRecalc := True;
      m_WAbil.MP := m_WAbil.MaxMP - 1;
    end;
    if boNeedRecalc then
      HealthSpellChanged();

  except
    MainOutMessage(sExceptionMsg2);
  end;
  //TBaseObject.Run 3 清理目标对象
  try
    if (m_TargetCret <> nil) then begin
      if ((GetTickCount() - m_dwTargetFocusTick) > 30000) or
        m_TargetCret.m_boDeath or
        m_TargetCret.m_boGhost or
        (m_TargetCret.m_PEnvir <> m_PEnvir) or
        // 08/06 增加，弓箭卫士在人物进入房间后再出来，还会攻击人物(人物的攻击目标没清除)
      (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 15) or
        (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 15) then begin
        m_TargetCret := nil;
      end;
    end;
    if (m_LastHiter <> nil) then begin
      if ((GetTickCount() - m_LastHiterTick) > 30000) or
        m_LastHiter.m_boDeath or
        m_LastHiter.m_boGhost or
        (m_LastHiter.m_PEnvir <> m_PEnvir) then begin
        m_LastHiter := nil;
      end;
    end;
    if (m_ExpHitter <> nil) then begin
      if ((GetTickCount() - m_ExpHitterTick) > 6000) or
        m_ExpHitter.m_boDeath or
        m_ExpHitter.m_boGhost or
        (m_ExpHitter.m_PEnvir <> m_PEnvir) then begin
        m_ExpHitter := nil;
      end;
    end;
    if m_Master <> nil then begin
      m_boNoItem := True;
      //宝宝变色
      {if m_boAutoChangeColor and ((GetTickCount - m_dwAutoChangeColorTick) >
        LongWord(g_Config.dwBBMonAutoChangeColorTime)) then begin
        m_dwAutoChangeColorTick := GetTickCount();
        case m_nAutoChangeIdx of
          0: nInteger := STATE_TRANSPARENT;
          1: nInteger := POISON_STONE;
          2: nInteger := POISON_DONTMOVE;
          3: nInteger := POISON_68;
          4: nInteger := POISON_DECHEALTH;
          5: nInteger := POISON_LOCKSPELL;
          6: nInteger := POISON_DAMAGEARMOR;
        else begin
            m_nAutoChangeIdx := 0;
            nInteger := STATE_TRANSPARENT;
          end;
        end;
        Inc(m_nAutoChangeIdx);
        m_nCharStatus := INteger(m_nCharStatusEx and $FFFFF) or
          Integer(($80000000 shr nInteger) or 0);
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
        m_nCharStatus := Integer(m_nCharStatusEx and $FFFFF) or
          Integer(($80000000 shr nInteger) or 0);
        m_nFixStatus := m_nCharStatus;
        StatusChanged();
      end;         }
      // 宝宝在主人死亡后死亡处理
      if m_Master.m_boDeath and (m_btRaceServer <> RC_CAMION) then begin
        m_WAbil.HP := 0;
      end;
      if m_Master.m_boGhost then begin
        if (m_btRaceServer = RC_CAMION) and (m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
          with TCamionMonster(Self) do begin
            m_sMasterName := m_Master.m_sCharName;
            m_MasterGhostTick := GetTickCount + 5 * 60 * 1000;
            m_nMasterIndex := TPlayObject(m_Master).m_nDBIndex;
            m_Master := nil;
            RefNameColor;
          end;
        end else
          MakeGhost;
      end;
    end;
    //004C7F0B
    //清除宝宝列表中已经死亡及叛变的宝宝信息
    nCheckCode := 3010;
    for i := m_SlaveList.Count - 1 downto 0 do begin
      if m_SlaveList.Count <= 0 then break;
      if TBaseObject(m_SlaveList.Items[i]) <> nil then begin
        if TBaseObject(m_SlaveList.Items[i]).m_boDeath or
          TBaseObject(m_SlaveList.Items[i]).m_boGhost or
          (TBaseObject(m_SlaveList.Items[i]).m_Master <> Self) then
          m_SlaveList.Delete(i);
      end;
    end;
    nCheckCode := 3011;
    if m_boHolySeize and ((GetTickCount() - m_dwHolySeizeTick) > m_dwHolySeizeInterval) then begin
      BreakHolySeizeMode();
    end;
    nCheckCode := 3012;
    if m_boCrazyMode and ((GetTickCount() - m_dwCrazyModeTick) > m_dwCrazyModeInterval) then begin
      BreakCrazyMode();
    end;
    nCheckCode := 3013;
    if m_boShowHP and ((GetTickCount() - m_dwShowHPTick) > m_dwShowHPInterval) then begin
      BreakOpenHealth();
    end;
    nCheckCode := 3014;
  except
    MainOutMessage(sExceptionMsg3 + IntToStr(nCheckCode));
  end;

  //SetProcessName('TBaseObject.Run ');
  //004C802F
  try
    nCheckCode := 4;
    // 减少PK值开始
    if (GetTickCount() - m_dwDecPkPointTick) > g_Config.dwDecPkPointTime {120000} then begin
      m_dwDecPkPointTick := GetTickCount();
      if m_nPkPoint > 0 then begin
        DecPKPoint(g_Config.nDecPkPointCount {1});
      end;
    end;
    // 减少PK值结束

    //检查照明物品及PK状态 开始
    nCheckCode := 41;
    if (GetTickCount - m_DecLightItemDrugTick) > g_Config.dwDecLightItemDrugTime {500}then begin
      Inc(m_DecLightItemDrugTick, g_Config.dwDecLightItemDrugTime {500});
      if m_btRaceServer = RC_PLAYOBJECT then begin
        //UseLamp();
        CheckPKStatus();
      end;
    end;
    //检查照明物品及PK状态 结束

    nCheckCode := 42;
    if (GetTickCount - m_dwCheckRoyaltyTick) > 10000 then begin
      m_dwCheckRoyaltyTick := GetTickCount();
      // 清组队已死亡成员
      nCheckCode := 430;
      if m_btRaceServer = RC_PLAYOBJECT then begin
        if (m_GroupOwner <> nil) then begin
          nCheckCode := 431;
          if m_GroupOwner.m_boGhost then begin
            m_GroupOwner.DelMember(m_GroupOwner);
            m_GroupOwner := nil;
            nCheckCode := 432;
          end;
          nCheckCode := 433;
        end;
        nCheckCode := 44;
        if m_GroupOwner = Self then begin
          for i := m_GroupMembers.Count - 1 downto 0 do begin
            if m_GroupMembers.Count <= 0 then break;
            BaseObject := TBaseObject(m_GroupMembers.Objects[i]);
            if (BaseObject <> nil) and ((BaseObject.m_boGhost) or (BaseObject.m_GroupOwner <> self)) then begin
              BaseObject.LeaveGroup();
              m_GroupMembers.Delete(i);
            end;
          end;
          if not TPlayObject(Self).CancelGroup then begin
            SendDefMsg(Self, SM_GROUPCANCEL, 1, 0, 0, 0, '');
          end;
        end;
        TPlayObject(Self).RefGroupWuXin(Self); //刷新五行信息
        // 清组队已死亡成员 结束
        nCheckCode := 45;
        // 检查交易双方 状态
        if (TPlayObject(Self).m_DealCreat <> nil) and (TPlayObject(Self).m_DealCreat.m_boGhost) then
          TPlayObject(Self).m_DealCreat := nil;
        nCheckCode := 46;
      end;
      if m_Master <> nil then begin
        if (g_dwSpiritMutinyTick > GetTickCount) and (m_btSlaveExpLevel < 5) then begin
          m_dwMasterRoyaltyTick := 0;
        end;

        //宝宝叛变  开始
        nCheckCode := 423;
        if (GetTickCount > m_dwMasterRoyaltyTick) then begin
          for i := m_Master.m_SlaveList.Count - 1 downto 0 do begin
            if m_Master.m_SlaveList.Count <= 0 then
              break;
            nCheckCode := 424;
            if m_Master.m_SlaveList.Items[i] = Self then begin
              nCheckCode := 425;
              m_Master.m_SlaveList.Delete(i);
              break;
            end;
          end;
          m_Master := nil;
          m_WAbil.HP := m_WAbil.HP div 10;
          nCheckCode := 426;
          RefShowName();
        end;
        //宝宝叛变 结束
        nCheckCode := 427;
        // 优化：宝宝永不死亡
        {if m_dwMasterTick <> 0 then begin
          if (GetTickCount - m_dwMasterTick) > 3 * 60 * 60 * 1000 then begin
            m_WAbil.HP := 0;
          end;
        end;}
      end;
    end;
    nCheckCode := 43;
    if (GetTickCount - m_dwVerifyTick) > 30 * 1000 then begin
      m_dwVerifyTick := GetTickCount();
      //if not m_boDenyRefStatus then
      //刷新在地图上位置的时间
      m_PEnvir.VerifyMapTime(m_nCurrX, m_nCurrY, Self);
    end;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg4, [nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;

  //SetProcessName('TBaseObject.Run 5');
  try
    boChg := False;
    boNeedRecalc := False;
    //    for i:=0 to MAX_STATUS_ATTRIBUTE - 1 do begin
    for i := Low(m_dwStatusArrTick) to High(m_dwStatusArrTick) do begin //004C832E
      if (m_wStatusTimeArr[i] > 0) and (m_wStatusTimeArr[i] < 60000) then begin
        if (GetTickCount() - m_dwStatusArrTick[i]) > 1000 then begin
          Dec(m_wStatusTimeArr[i]);
          Inc(m_dwStatusArrTick[i], 1000);
          if (m_wStatusTimeArr[i] = 0) then begin
            boChg := True;
            case i of
              STATE_TRANSPARENT: begin
                  m_boHideMode := False;
                  ChangeStatusMode(STATUS_HIDEMODE, False);
                end;
              STATE_DEFENCEUP: begin
                  boNeedRecalc := True;
                  SysMsg('防御力回复正常', c_Green, t_Hint);
                  ChangeStatusMode(STATUS_AC, False);
                end;
              STATE_MAGDEFENCEUP: begin
                  boNeedRecalc := True;
                  SysMsg('魔御力回复正常', c_Green, t_Hint);
                  ChangeStatusMode(STATUS_MAC, False);
                end;
              STATE_BUBBLEDEFENCEUP: begin
                  m_boAbilMagBubbleDefence := False;
                end;
              STATE_BUBBLEDEFENCEUPEX: begin
                  m_boAbilMagShieldDefence := False;
                end;
              POISON_DECHEALTH: ChangeStatusMode(STATUS_DECHEALTH, False);
              POISON_DAMAGEARMOR: ChangeStatusMode(STATUS_DAMAGEARMOR, False);
              POISON_STONE: ChangeStatusMode(STATUS_STONE, False);
              POISON_COBWEB: ChangeStatusMode(STATUS_COBWEB, False);
            end;
          end;
        end;
      end;
    end;
    //004C8409
    for i := Low(m_wStatusArrValue) to High(m_wStatusArrValue) do begin
      if m_wStatusArrValue {218} [i] > 0 then begin
        if GetTickCount() > m_dwStatusArrTimeOutTick {220} [i] then begin
          m_wStatusArrValue[i] := 0;
          boNeedRecalc := True;
          case i of
            0: begin
                SysMsg('攻击力回复正常', c_Green, t_Hint);
                ChangeStatusMode(STATUS_DC, False);
              end;
            1: begin
                SysMsg('魔法力回复正常', c_Green, t_Hint);
                ChangeStatusMode(STATUS_MC, False);
              end;
            2: begin
                SysMsg('道术回复正常', c_Green, t_Hint);
                ChangeStatusMode(STATUS_SC, False);
              end;
            3: begin
                SysMsg('攻击速度回复正常', c_Green, t_Hint);
              end;
            4: begin
                SysMsg('体力回复正常', c_Green, t_Hint);
                ChangeStatusMode(STATUS_HP, False);
              end;
            5: begin
                SysMsg('魔法值回复正常', c_Green, t_Hint);
                ChangeStatusMode(STATUS_MP, False);
              end;
          end;
        end;
      end;
    end;
    //004C84F5
    if boChg then begin
      m_nCharStatus := GetCharStatus();
      StatusChanged();
    end;
    //004C8511
    if boNeedRecalc then begin
      RecalcAbilitys();
      SendAbility;
    end;
  except
    MainOutMessage(sExceptionMsg5);
  end;

  //SetProcessName('TBaseObject.Run 6');
  //004C855A
  try
    if (GetTickCount - m_dwPoisoningTick) > g_Config.dwPosionDecHealthTime {2500} then begin
      m_dwPoisoningTick := GetTickCount();
      if m_wStatusTimeArr[POISON_DECHEALTH {0 0x60}] > 0 then begin
        if m_boAnimal then
          Dec(m_nMeatQuality, 1000);
        DamageHealth(m_btGreenPoisoningPoint + 1);
        m_nHealthTick := 0;
        m_nSpellTick := 0;
        HealthSpellChanged();
      end;
    end;
  except
    MainOutMessage(sExceptionMsg6);
  end;
  if m_PHookX <> nil then m_PHookX^ := m_nCurrX;
  if m_PHookY <> nil then m_PHookY^ := m_nCurrY;
  {
  if boOpenHealth then begin
    if (GetTickCount() - dwOpenHealthStart) > dwOpenHealthTime then begin
      BreakOpenHealth();
    end;
  end;
  }
  {g_nBaseObjTimeMin := GetTickCount - dwRunTick;
  if g_nBaseObjTimeMax < g_nBaseObjTimeMin then
    g_nBaseObjTimeMax := g_nBaseObjTimeMin;   }
end;

{function TPlayObject.DayBright: Byte;
begin
  Result := 0;
  if m_PEnvir <> nil then begin
    if m_PEnvir.m_boDarkness then
      Result := 1
    else if m_PEnvir.m_boDayLight then Result := 0;
  end;
end; }

function TBaseObject.GetFrontPosition(var nX: Integer; var nY: Integer):
  Boolean;
var
  Envir: TEnvirnoment;
begin
  Envir := m_PEnvir;
  nX := m_nCurrX;
  nY := m_nCurrY;
  case m_btDirection of
    DR_UP: begin
        if nY > 0 then
          Dec(nY);
      end;
    DR_UPRIGHT: begin
        if (nX < (Envir.m_nWidth - 1)) and (nY > 0) then begin
          Inc(nX);
          Dec(nY);
        end;
      end;
    DR_RIGHT: begin
        if nX < (Envir.m_nWidth - 1) then
          Inc(nX);
      end;
    DR_DOWNRIGHT: begin
        if (nX < (Envir.m_nWidth - 1)) and (nY < (Envir.m_nHeight - 1)) then begin
          Inc(nX);
          Inc(nY);
        end;
      end;
    DR_DOWN: begin
        if nY < (Envir.m_nHeight - 1) then
          Inc(nY);
      end;
    DR_DOWNLEFT: begin
        if (nX > 0) and (nY < (Envir.m_nHeight - 1)) then begin
          Dec(nX);
          Inc(nY);
        end;
      end;
    DR_LEFT: begin
        if nX > 0 then
          Dec(nX);
      end;
    DR_UPLEFT: begin
        if (nX > 0) and (nY > 0) then begin
          Dec(nX);
          Dec(nY);
        end;
      end;
  end;
  Result := True;
end;

function TBaseObject.GetRandXY(Envir: TEnvirnoment; var nX: Integer; var nY: Integer): Boolean;
var
  n14, n18, n1C: Integer;
begin
  Result := False;
  if Envir.m_nWidth < 80 then
    n18 := 3
  else
    n18 := 10;
  if Envir.m_nHeight < 150 then begin
    if Envir.m_nHeight < 50 then
      n1C := 2
    else
      n1C := 15;
  end
  else
    n1C := 50;
  n14 := 0;
  while (True) do begin
    if Envir.CanWalk(nX, nY, True) then begin
      Result := True;
      break;
    end;
    if nX < (Envir.m_nWidth - n1C - 1) then
      Inc(nX, n18)
    else begin
      nX := Random(Envir.m_nWidth);
      if nY < (Envir.m_nHeight - n1C - 1) then
        Inc(nY, n18)
      else
        nY := Random(Envir.m_nHeight);
    end;
    Inc(n14);
    if n14 >= 201 then
      break;
  end;
end;

procedure TBaseObject.SpaceMove(Envir: TEnvirnoment; nX, nY: Integer; nInt: Integer);
var
  OldEnvir: TEnvirnoment;
  nOldX, nOldY: Integer;
  bo21: Boolean;
  OldMapName: string;
begin
  //摆摊不允许切换地图
  if (m_btRaceServer = RC_PLAYOBJECT) and (TPlayObject(Self).m_boShoping) then exit;
  if not m_boMapApoise then exit;
  if Envir <> nil then begin
    //if nServerIndex = Envir.nServerIndex then begin
    OldEnvir := m_PEnvir;
    OldMapName := m_sMapName;
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;
    bo21 := False;
    m_PEnvir.DeleteFromMap(m_nCurrX, m_nCurrY, OS_MOVINGOBJECT, Self);
    ClearViewRange;
    m_PEnvir := Envir;
    m_sMapName := Envir.sMapName;
    m_nCurrX := nX;
    m_nCurrY := nY;
    if GetRandXY(m_PEnvir, m_nCurrX, m_nCurrY) then begin
      m_PEnvir.AddToMap(m_nCurrX, m_nCurrY, OS_MOVINGOBJECT, Self);
{$IF CHANGEMAPMODE = OLDMAPMODE}
      SendMsg(Self, RM_CHANGEMAP, 0, Integer(Envir), 0, 0, g_MapManager.GetMainMap(Envir));
      if nInt = 1 then SendRefMsg(RM_SPACEMOVE_SHOW2, m_btDirection, m_nCurrX, m_nCurrY, 0, '')
      else if nInt >= 2 then SendRefMsg(RM_SPACEMOVE_SHOW3, m_btDirection, m_nCurrX, m_nCurrY, nInt, '')
      else SendRefMsg(RM_SPACEMOVE_SHOW, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
{$ELSE}
      if m_boOldChangeMapMode then SendMsg(Self, RM_CHANGEMAP, 0, Integer(Envir), 0, 0, g_MapManager.GetMainMap(Envir))
      else SendMsg(Self, RM_CHANGEMAP, 0, Integer(OldEnvir), 0, 0, g_MapManager.GetMainMap(Envir));
      m_btMapSpaceShow := nInt + 1;
{$IFEND}
      m_dwMapMoveTick := GetTickCount();
      if m_btRaceServer = RC_PLAYOBJECT then begin
        // 2023-12-21 新增：发送队友位置
        TPlayObject(Self).SendGroupMsg(TPlayObject(Self), SM_GROUPINFO1, Integer(Self), 0, 0, 0, 'GROUP_POSITION');
        with TPlayObject(Self) do begin
          GetStartType(); //刷新人物当前所在位置的状态

          ClearDare(4);
          m_AttackState := as_None;
          if m_PEnvir <> OldEnvir then begin
            m_dwAutoGetExpTick := GetTickCount();
            m_dwDecGameGoldTick := GetTickCount();
            m_dwIncGameGoldTick := GetTickCount();
          end;
          SafeFillChar(m_nMval, SizeOf(m_nMval), #0);
          if m_nCheckChangeMapCount < 100 then Inc(m_nCheckChangeMapCount);
        end;
{$IF CHANGEMAPMODE = NEWMAPMODE}
      end else begin
        if nInt = 1 then  begin
          SendRefMsg(RM_SPACEMOVE_SHOW2, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
        end
        else
          SendRefMsg(RM_SPACEMOVE_SHOW, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
{$IFEND}
      end;
      //m_bo316 := True;
      bo21 := True;
    end;
    if not bo21 then begin
      m_PEnvir := OldEnvir;
      m_sMapName := OldMapName;
      m_nCurrX := nOldX;
      m_nCurrY := nOldY;
      m_PEnvir.AddToMap(m_nCurrX, m_nCurrY, OS_MOVINGOBJECT, Self);
    end;
    //end;
  end;
end;

procedure TBaseObject.SpaceMove(sMAP: string; nX, nY: Integer; nInt: Integer);
begin
  if not m_boMapApoise then exit;
  if (m_btRaceServer = RC_PLAYOBJECT) and (TPlayObject(Self).m_boShoping) then exit;
  SpaceMove(g_MapManager.FindMap(sMAP), nX, nY, nInt);
end;

procedure TBaseObject.RefShowName();
begin
  SendRefMsg(RM_USERNAME, 0, 0, 0, 0, GetShowName);
end;

function TBaseObject.Operate(ProcessMsg: pTProcessMessage): Boolean;
var
  nDamage: Integer;
  nTargetX: Integer;
  nTargetY: Integer;
  nPower: Integer;
  nRage: Integer;
  TargeTBaseObject: TBaseObject;
  MakePoisonInfo: pTMakePoisonInfo;
resourcestring
  sExceptionMsg = '[Exception] TBaseObject::Operate ';
begin
  Result := False;
  if ProcessMsg = nil then
    Exit;
  try
    case ProcessMsg.wIdent of
      RM_MAGSTRUCK,
        RM_MAGSTRUCK_MINE: begin //10025
          if (ProcessMsg.wIdent = RM_MAGSTRUCK) and (m_btRaceServer >= RC_ANIMAL) and (not bo2BF) and (m_Abil.Level < 35) then
          begin
            m_dwWalkTick := m_dwWalkTick + 800 + LongWord(Random(1000));
          end;
          nDamage := GetMagStruckDamage(nil, ProcessMsg.nParam1);
          if nDamage > 0 then begin
            StruckDamage(nDamage, TBaseObject(ProcessMsg.BaseObject));
            HealthSpellChanged();
            SendRefMsg(RM_STRUCK_MAG, nDamage, m_WAbil.HP, m_WAbil.MaxHP, Integer(ProcessMsg.BaseObject), '');
            if m_btRaceServer <> RC_PLAYOBJECT then begin
              if m_boAnimal then
                Dec(m_nMeatQuality, nDamage * 1000);
              SendMsg(Self, RM_STRUCK, nDamage, m_WAbil.HP, m_WAbil.MaxHP, Integer(ProcessMsg.BaseObject), '');
            end;
          end;
          if m_boFastParalysis then begin
            m_wStatusTimeArr[POISON_STONE] := 1;
            m_boFastParalysis := False;
          end;
          if m_nFastParalysis > 0 then begin
            Dec(m_nFastParalysis);
            if m_nFastParalysis = 0 then
              m_wStatusTimeArr[POISON_STONE] := 1;
          end;
        end;
      RM_MAGHEALING: begin //10026
          if (m_nIncHealing + ProcessMsg.nParam1) < 300 then begin
            if m_btRaceServer = RC_PLAYOBJECT then begin
              Inc(m_nIncHealing, ProcessMsg.nParam1);
              m_nPerHealing := 5;
            end
            else begin
              Inc(m_nIncHealing, ProcessMsg.nParam1);
              m_nPerHealing := 5;
            end;
          end
          else
            m_nIncHealing := 300;
        end;
      RM_10101: begin //10101
          SendRefMsg(Integer(ProcessMsg.BaseObject),
            ProcessMsg.wParam {nPower},
            ProcessMsg.nParam1 {HP},
            ProcessMsg.nParam2 {MaxHP},
            ProcessMsg.nParam3 {AttackSrc},
            ProcessMsg.sMsg);
          if (Integer(ProcessMsg.BaseObject) = RM_STRUCK) and (m_btRaceServer <> RC_PLAYOBJECT) then begin
            SendMsg(Self, Integer(ProcessMsg.BaseObject),
              ProcessMsg.wParam,
              ProcessMsg.nParam1,
              ProcessMsg.nParam2,
              ProcessMsg.nParam3 {AttackBaseObject},
              ProcessMsg.sMsg);
          end;
          if m_boFastParalysis then begin
            m_wStatusTimeArr[POISON_STONE] := 1;
            m_boFastParalysis := False;
          end;
        end;
      RM_DELAYMAGIC: begin
          nPower := ProcessMsg.wParam;
          nTargetX := ProcessMsg.nParam1;
          nTargetY := ProcessMsg.nParam2;
          nRage := ProcessMsg.nParam3;
          TargeTBaseObject := TBaseObject(ProcessMsg.nParam4);
          if (TargeTBaseObject <> nil) and (TargeTBaseObject.GetMagStruckDamage(Self, nPower) > 0) then begin

            SetTargetCreat(TargeTBaseObject);
            if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
              nPower := ROUND(nPower / 1.2);
            if (abs(nTargetX - TargeTBaseObject.m_nCurrX) <= nRage) and
              (abs(nTargetY - TargeTBaseObject.m_nCurrY) <= nRage) then
              TargeTBaseObject.SendMsg(Self, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
          end;
        end;
      RM_DELAYMAGIC2: begin
          nPower := ProcessMsg.wParam;
          nTargetX := ProcessMsg.nParam1;
          nTargetY := ProcessMsg.nParam2;
          nRage := ProcessMsg.nParam3;
          TargeTBaseObject := TBaseObject(ProcessMsg.nParam4);
          if (TargeTBaseObject <> nil) and (TargeTBaseObject.GetMagStruckDamage(Self, nPower) > 0) then begin
            SetTargetCreat(TargeTBaseObject);
            if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
              nPower := ROUND(nPower / 1.2);
            if (abs(nTargetX - TargeTBaseObject.m_nCurrX) <= nRage) and
              (abs(nTargetY - TargeTBaseObject.m_nCurrY) <= nRage) then begin
              TargeTBaseObject.SendMsg(Self, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
              SendMsg(Self, RM_MAGHEALING, 0, nPower, 0, 0, '');
              SendRefMsg(RM_SHOWEFFECT, Effect_VAMPIRE, Integer(Self), m_nCurrX, m_nCurrY, '');
            end;
          end;
        end;
      RM_10155: begin
          MapRandomMove(ProcessMsg.sMsg, ProcessMsg.wParam);
        end;
      RM_DELAYPUSHED: begin
          nPower := ProcessMsg.wParam;
          //nTargetX := LoWord(ProcessMsg.nParam1);
//          nTargetY := HiWord(ProcessMsg.nParam1);
          nRage := ProcessMsg.nParam2;
          TargeTBaseObject := TBaseObject(ProcessMsg.nParam3);
          if (TargeTBaseObject <> nil) then begin
            TargeTBaseObject.CharPushed(nPower, nRage);
          end;
        end;
      RM_MONMOVE: SpaceMove(m_PEnvir, ProcessMsg.nParam2, ProcessMsg.nParam3, 0);
      RM_MAKEPOISON: begin
          MakePoisonInfo := pTMakePoisonInfo(ProcessMsg.nParam2);
          if MakePoisonInfo <> nil then begin
            TargeTBaseObject := MakePoisonInfo.BaseObject;
            nTargetX := MakePoisonInfo.nX;
            nTargetY := MakePoisonInfo.nY;
            nRage := MakePoisonInfo.nRate;
            if (TargeTBaseObject <> nil) and (abs(nTargetX - m_nCurrX) <= nRage) and (abs(nTargetY - m_nCurrY) <= nRage) then begin
              SetTargetCreat {0FFF2}(TargeTBaseObject);
              if (m_btRaceServer = RC_PLAYOBJECT) and (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                SetPKFlag(TargeTBaseObject);
              end;
              SetLastHiter(TargeTBaseObject);

              if (m_Master <> nil) and (TargeTBaseObject <> m_Master) and
                (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                m_Master.SetPKFlag(TargeTBaseObject);
                if (g_CastleManager.IsCastleMember(m_Master) <> nil) and
                  (m_Master.m_MyGuild <> TargeTBaseObject.m_MyGuild) then begin
                  TargeTBaseObject.bo2B0 := True;
                  TargeTBaseObject.m_dw2B4Tick := GetTickCount();
                end;
              end;
              if (m_Castle <> nil) then begin
                TargeTBaseObject.bo2B0 := True;
                TargeTBaseObject.m_dw2B4Tick := GetTickCount();
              end;
              MakePosion(ProcessMsg.wParam {中毒类型}, ProcessMsg.nParam1{nPower}, ProcessMsg.nParam3);
              if (ProcessMsg.wParam = POISON_STONE) and MakePoisonInfo.boFastParalysis then
                m_nFastParalysis := 2;
            end;
            Dispose(MakePoisonInfo);
          end;
        end;
      RM_POISON: begin
          TargeTBaseObject := TBaseObject(ProcessMsg.nParam2);
          if TargeTBaseObject <> nil then begin
            //if IsProperTarget {FFF4}(TargeTBaseObject) then begin
              SetTargetCreat {0FFF2}(TargeTBaseObject);
              if (m_btRaceServer = RC_PLAYOBJECT) and (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                SetPKFlag(TargeTBaseObject);
              end;
              SetLastHiter(TargeTBaseObject);
            //end;
            if (m_Master <> nil) and (TargeTBaseObject <> m_Master) and
              (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
              m_Master.SetPKFlag(TargeTBaseObject);
              if (g_CastleManager.IsCastleMember(m_Master) <> nil) and
                (m_Master.m_MyGuild <> TargeTBaseObject.m_MyGuild) then begin
                TargeTBaseObject.bo2B0 := True;
                TargeTBaseObject.m_dw2B4Tick := GetTickCount();
              end;
            end;
            if (m_Castle <> nil) then begin
              TargeTBaseObject.bo2B0 := True;
              TargeTBaseObject.m_dw2B4Tick := GetTickCount();
            end;
            MakePosion(ProcessMsg.wParam {中毒类型}, ProcessMsg.nParam1{nPower}, ProcessMsg.nParam3);
          end
          else
            MakePosion(ProcessMsg.wParam {中毒类型}, ProcessMsg.nParam1{nPower}, ProcessMsg.nParam3);

        end;
      RM_TRANSPARENT: begin //10308
          MagicManager.MagMakePrivateTransparent(Self, ProcessMsg.nParam1);
        end;
      RM_DOOPENHEALTH: begin //10412
          MakeOpenHealth();
        end;
      RM_RANDOMMOVE: begin
          MapRandomMove(m_PEnvir, 0);
        end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

//创建宝宝

function TBaseObject.MakeSlave(sMonName: string; nMakeLevel, nExpLevel, nMaxMob, nMagID:
  Integer; dwRoyaltySec: LongWord): TBaseObject; //004C37C0
var
  nX, nY: Integer;
  MonObj: TBaseObject;
begin
  Result := nil;
  //if (m_SlaveList.Count < nMaxMob) or (nMagID = -1) then begin
  GetFrontPosition(nX, nY);
  MonObj := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, nX, nY, sMonName);
  if MonObj <> nil then begin
    MonObj.m_Master := Self;
    MonObj.m_btWuXin := 0;
    MonObj.m_nSlaveMagIndex := nMagID;
    MonObj.m_dwMasterRoyaltyTick := GetTickCount + dwRoyaltySec * 1000;
    MonObj.m_btSlaveMakeLevel := nMakeLevel;
    MonObj.m_btSlaveExpLevel := nExpLevel;
    MonObj.RecalcAbilitys;
    if MonObj.m_WAbil.HP < MonObj.m_WAbil.MaxHP then begin
      MonObj.m_WAbil.HP := MonObj.m_WAbil.HP + (MonObj.m_WAbil.MaxHP - MonObj.m_WAbil.HP) div 2;
    end;
    MonObj.RefNameColor;
    m_SlaveList.Add(MonObj);
    Result := MonObj;
  end;
  //end;
end;

function TBaseObject.RunTo(btDir: Byte; boFlag: Boolean; nDestX, nDestY:
  Integer): Boolean;
  function CheckWalk(nWalkX, nWalkY: Integer): Boolean;
  begin
    Result := (g_Config.boSafeAreaLimited and InSafeZone) or
      m_PEnvir.CanWalkEx(nWalkX, nWalkY, g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll));
  end;
var
  nOldX, nOldY: Integer;
resourcestring
  sExceptionMsg = '[Exception] TBaseObject::RunTo';
begin
  Result := False;
  if m_PEnvir = nil then exit;
  try
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;
    m_btDirection := btDir;
    case btDir of
      DR_UP {0}: begin
          if (m_nCurrY > 1) and
            CheckWalk(m_nCurrX, m_nCurrY - 1) and
            CheckWalk(m_nCurrX, m_nCurrY - 2) and
            (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX, m_nCurrY - 2, True) > 0) then
          begin
            Dec(m_nCurrY, 2);
          end;
        end;
      DR_UPRIGHT {1}: begin
          if (m_nCurrX < m_PEnvir.m_nWidth - 2) and
            (m_nCurrY > 1) and
            CheckWalk(m_nCurrX + 1, m_nCurrY - 1) and
            CheckWalk(m_nCurrX + 2, m_nCurrY - 2) and
            (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX + 2, m_nCurrY - 2, True) > 0) then
          begin
            Inc(m_nCurrX, 2);
            Dec(m_nCurrY, 2);
          end;
        end;
      DR_RIGHT {2}: begin
          if (m_nCurrX < m_PEnvir.m_nWidth - 2) and
            CheckWalk(m_nCurrX + 1, m_nCurrY) and
            CheckWalk(m_nCurrX + 2, m_nCurrY) and
            (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX + 2, m_nCurrY, True) > 0) then
          begin
            Inc(m_nCurrX, 2);
          end;
        end;
      DR_DOWNRIGHT {3}: begin
          if (m_nCurrX < m_PEnvir.m_nWidth - 2) and
            (m_nCurrY < m_PEnvir.m_nHeight - 2) and
            CheckWalk(m_nCurrX + 1, m_nCurrY + 1) and
            CheckWalk(m_nCurrX + 2, m_nCurrY + 2) and
            (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX + 2, m_nCurrY + 2, True) > 0) then
          begin
            Inc(m_nCurrX, 2);
            Inc(m_nCurrY, 2);
          end;
        end;
      DR_DOWN {4}: begin
          if (m_nCurrY < m_PEnvir.m_nHeight - 2) and
            CheckWalk(m_nCurrX, m_nCurrY + 1) and
            CheckWalk(m_nCurrX, m_nCurrY + 2) and
            (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX, m_nCurrY + 2, True) > 0) then
          begin
            Inc(m_nCurrY, 2);
          end;
        end;
      DR_DOWNLEFT {5}: begin
          if (m_nCurrX > 1) and
            (m_nCurrY < m_PEnvir.m_nHeight - 2) and
            CheckWalk(m_nCurrX - 1, m_nCurrY + 1) and
            CheckWalk(m_nCurrX - 2, m_nCurrY + 2) and
            (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX - 2, m_nCurrY + 2, True) > 0) then
          begin
            Dec(m_nCurrX, 2);
            Inc(m_nCurrY, 2);
          end;
        end;
      DR_LEFT {6}: begin
          if (m_nCurrX > 1) and
            CheckWalk(m_nCurrX - 1, m_nCurrY) and
            CheckWalk(m_nCurrX - 2, m_nCurrY) and
            (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX - 2, m_nCurrY, True) > 0) then
          begin
            Dec(m_nCurrX, 2);
          end;
        end;
      DR_UPLEFT {7}: begin
          if (m_nCurrX > 1) and
            (m_nCurrY > 1) and
            CheckWalk(m_nCurrX - 1, m_nCurrY - 1) and
            CheckWalk(m_nCurrX - 2, m_nCurrY - 2) and
            (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX - 2, m_nCurrY - 2, True) > 0) then
          begin
            Dec(m_nCurrX, 2);
            Dec(m_nCurrY, 2);
          end;
        end;
    end;
    if ((m_nCurrX <> nOldX) or (m_nCurrY <> nOldY)) then begin
      if Walk(RM_RUN) then
        Result := True
      else begin
        m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nOldX, nOldY, True);
        m_nCurrX := nOldX;
        m_nCurrY := nOldY;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;
 {
procedure TBaseObject.ThrustingOnOff(boSwitch: Boolean);
begin
  m_boUseThrusting := boSwitch;
  if m_boUseThrusting then begin
    SysMsg(sThrustingOn, c_Green, t_Hint);
  end
  else begin
    SysMsg(sThrustingOff, c_Green, t_Hint);
  end;
end;      }
 {
procedure TBaseObject.HalfMoonOnOff(boSwitch: Boolean);
begin
  m_boUseHalfMoon := boSwitch;
  if m_boUseHalfMoon then begin
    SysMsg(sHalfMoonOn, c_Green, t_Hint);
  end
  else begin
    SysMsg(sHalfMoonOff, c_Green, t_Hint);
  end;
end;        }
{
procedure TBaseObject.SkillCrsOnOff(boSwitch: Boolean);
begin
  m_boCrsHitkill := boSwitch;
  if m_boCrsHitkill then begin
    SysMsg(sCrsHitOn, c_Green, t_Hint);
  end
  else begin
    SysMsg(sCrsHitOff, c_Green, t_Hint);
  end;
end;

procedure TBaseObject.Skill42OnOff(boSwitch: Boolean);
begin
  m_bo42kill := boSwitch;
  if m_bo42kill then begin
    SysMsg('开启狂风斩', c_Green, t_Hint);
  end
  else begin
    SysMsg('关闭狂风斩', c_Green, t_Hint);
  end;
end;

procedure TBaseObject.Skill43OnOff(boSwitch: Boolean);
begin
  m_bo43kill := boSwitch;
  if m_bo43kill then begin
    SysMsg('开启破空剑', c_Green, t_Hint);
  end
  else begin
    SysMsg('关闭破空剑', c_Green, t_Hint);
  end;
end;           }
  {
function TBaseObject.AllowFireHitSkill(): Boolean;
begin
  Result := False;
  if (GetTickCount - m_dwLatestFireHitTick) > 10 * 1000 then begin
    m_dwLatestFireHitTick := GetTickCount();
    m_boFireHitSkill := True;
    SysMsg(sFireSpiritsSummoned, c_Green, t_Hint);
    Result := True;
  end
  else begin
    SysMsg(sFireSpiritsFail, c_Red, t_Hint);
  end;
end;      }
{
procedure TBaseObject.AddUserItemLog(nLogID: String; BaseObject: TBaseObject; UserItem: pTUserItem;
  Stditem: pTStdItem = nil; sDealName: String = '0'; sTest: string = '1');
begin
  if StdItem = nil then
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (StdItem <> nil) and (StdItem.NeedIdentify = 1) then begin
    AddGameDataLog(nLogID + #9 +
        BaseObject.m_sMapName + #9 +
        IntToStr(BaseObject.m_nCurrX) + #9 +
        IntToStr(BaseObject.m_nCurrY) + #9 +
        BaseObject.m_sCharName + #9 +
        StdItem.Name + #9 +
        IntToStr(UserItem.MakeIndex) + #9 +
        sTest + #9 +
        sDealName);
  end;

end;     }

procedure TBaseObject.MapRandomMove(Envir: TEnvirnoment; nInt: Integer);
var
  n10, n14, n18: Integer;
begin
  if Envir <> nil then begin
    if Envir.m_nHeight < 150 then begin
      if Envir.m_nHeight < 30 then begin
        n18 := 2;
      end
      else
        n18 := 20;
    end
    else
      n18 := 50;
    n10 := Random(Envir.m_nWidth - n18 - 1) + n18;
    n14 := Random(Envir.m_nHeight - n18 - 1) + n18;
    SpaceMove(Envir, n10, n14, nInt);
  end;
end;

procedure TBaseObject.MapRandomMove(sMapName: string; nInt: Integer);
begin
  MapRandomMove(g_MapManager.FindMap(sMapName), nInt);
end;
//返回值 -1增加失败
//       1 增加成功，清除原Useritem
//       2 增加成功，不清楚原Useritem

function TBaseObject.AddItemToBag(UserItem: pTUserItem; StdItem32: pTStdItem; boCheck: Boolean;
  sDealName, sLogName: string; var AddUserItem: pTUserItem): Integer;
var
  StdItem: pTStdItem;
  I: Integer;
  UserItem32: pTUserItem;
  nCount, nMaxCount: Word;
  boSendAdd: BOolean;
  nAddCount: Integer;
begin
  Result := -1;
  AddUserItem := nil;
  //是否检测叠加物品
  try
    if boCheck then begin
      if StdItem32 = nil then
        StdItem := UserEngine.GetStdItem(UserItem.wIndex)
      else
        StdItem := StdItem32;
      if Stditem <> nil then begin
        //判断是否是可以叠加的物品，是的话，先查找背包是否有相同的物品
        if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) and (UserItem.DuraMax > 1) and
          (UserItem.Dura < UserItem.DuraMax) then
        begin
          m_TempItemList.Clear;
          nMaxCount := UserItem.Dura;
          nAddCount := nMaxCount;
          boSendAdd := False;
          for I := 0 to m_ItemList.Count - 1 do begin
            if nMaxCount < 1 then
              Break;
            UserItem32 := m_ItemList.Items[i];
            if (UserItem32 <> nil) and
              (UserItem32.wIndex = UserItem.wIndex) and
              (UserItem32.Dura < UserItem32.DuraMax) and
              (UserItem32.btBindMode1 = UserItem.btBindMode1) and
              (UserItem32.btBindMode2 = UserItem.btBindMode2) then begin
              nCount := UserItem32.DuraMax - UserItem32.Dura;
              m_TempItemList.Add(UserItem32);
              if (nMaxCount > nCount) then
                Dec(nMaxCount, nCount)
              else
                nMaxCount := 0;
            end;
          end;
          //背包中有足够的叠加空间
          if (nMaxCount = 0) and (m_TempItemList.Count > 0) then begin
            Result := 1;     //增加成功，没有增加新物品，传入物品可释放内存
          end
          else if (nMaxCount > 0) and (m_ItemList.Count < m_nMaxItemListCount) then begin
            //无足够的叠加空间，直接增加为新物品
            UserItem.Dura := nAddCount;
            m_ItemList.Add(UserItem);
            Result := 2;  //增加成功
            exit;
          end;
          if Result <> -1 then begin
            for I := 0 to m_TempItemList.Count - 1 do begin
              if UserItem.Dura < 1 then
                break;
              UserItem32 := m_TempItemList.Items[i];
              nCount := UserItem32.DuraMax - UserItem32.Dura;
              if nCount > 0 then begin
                if UserItem.Dura > nCount then begin
                  Inc(UserItem32.Dura, nCount);
                  Dec(UserItem.Dura, nCount);
                  if Stditem.NeedIdentify = 1 then
                    AddGameLog(Self, LOG_ITEMDURACHANGE, Stditem.Name, UserItem32.MakeIndex, UserItem32.Dura, sDealName,
                      '+', IntToStr(nCount), sLogName, UserItem32);
                end
                else begin
                  Inc(UserItem32.Dura, UserItem.Dura);
                  if Stditem.NeedIdentify = 1 then
                    AddGameLog(Self, LOG_ITEMDURACHANGE, Stditem.Name, UserItem32.MakeIndex, UserItem32.Dura, sDealName,
                      '+', IntToStr(UserItem.Dura), sLogName, UserItem32);
                  UserItem.Dura := 0;
                end;
                if m_btRaceServer = RC_PLAYOBJECT then begin
                  if boSendAdd then begin
                    TPlayObject(Self).SendDefMessage(SM_BAG_DURACHANGE,
                      UserItem32.MakeIndex,
                      UserItem32.Dura,
                      UserItem32.DuraMax,
                      0,
                      '');
                  end
                  else begin
                    boSendAdd := True;
                    TPlayObject(Self).SendDefMessage(SM_BAG_DURACHANGE2,
                      UserItem32.MakeIndex,
                      UserItem32.Dura,
                      UserItem32.DuraMax,
                      nAddCount,
                      '');
                  end;
                end;
              end;
            end;
          end;
        end
        else if m_ItemList.Count < m_nMaxItemListCount then begin
          m_ItemList.Add(UserItem);
          Result := 2;
        end;
      end;
    end
    else begin
      if m_ItemList.Count < m_nMaxItemListCount then begin
        m_ItemList.Add(UserItem);
        Result := 2;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(E.Message);
      MainOutMessage('[Exception] TBaseObject.AddItemToBag');
    end;
  end;
end;

procedure TBaseObject.sub_4C713C(Magic: pTUserMagic);
begin
  if Magic <> nil then begin
    if Magic.MagicInfo.wMagicId = SKILL_SHOWHP then begin
      if Magic.btLevel >= 2 then
        m_boAbilSeeHealGauge := True;
    end else
    if Magic.MagicInfo.wMagicID in [SKILL_ONESWORD, SKILL_ILKWANG, SKILL_YEDO] then begin
      RecalcAbilitys();
      SendAbility;
      SendSubAbility;
    end;
  end;
end;

procedure TBaseObject.SetClientVersion(AClientVersion: Integer);
begin
  if AClientVersion <= 0 then
    exit;
  m_nClientVersion := AClientVersion and CLIENT_VERSION_MARK;
  m_ClientVersion := [];
  if (AClientVersion and CLIENT_VERSIONEX_MIR2) <> 0 then
    m_ClientVersion := m_ClientVersion + [cv_Mir2];
  if (AClientVersion and CLIENT_VERSIONEX_TEST) <> 0 then
    m_ClientVersion := m_ClientVersion + [cv_Test];
  if (AClientVersion and CLIENT_VERSIONEX_FREE) <> 0 then
    m_ClientVersion := m_ClientVersion + [cv_Free];
  if (AClientVersion and CLIENT_VERSIONEX_DEBUG) <> 0 then
    m_ClientVersion := m_ClientVersion + [cv_Debug];
end;


{procedure TPlayObject.GetStartPoint;
var
  i: Integer;
  StartPoint: pTStartPoint;
  nStartX,nStartY:Integer;
  nEndX,nEndY:Integer;
begin
  try
    g_StartPointList.Lock;
    for i := 0 to g_StartPointList.Count - 1 do begin
      if g_StartPointList.Strings[i] = m_PEnvir.sMapName then begin
        StartPoint := pTStartPoint(g_StartPointList.Objects[i]);
        if StartPoint <> nil then begin
          //nXY := Integer(g_StartPointList.Objects[i]);
          nStartX:=StartPoint.m_nCurrX - StartPoint.m_nRange;
          nEndX:=StartPoint.m_nCurrX + StartPoint.m_nRange;
          nStartY:=StartPoint.m_nCurrY - StartPoint.m_nRange;
          nEndY:=StartPoint.m_nCurrY - StartPoint.m_nRange;
          if (m_nCurrX in [nStartX..nEndX]) and (m_nCurrY in [nStartY..nEndY]) then begin
            m_sHomeMap := g_StartPointList.Strings[i];
            m_nHomeX := StartPoint.m_nCurrX;
            m_nHomeY := StartPoint.m_nCurrY;
            break;
          end;
        end;
      end;
    end;
    if PKLevel >= 2 then begin
      m_sHomeMap := g_Config.sRedHomeMap;
      m_nHomeX := g_Config.nRedHomeX;
      m_nHomeY := g_Config.nRedHomeY;
    end;
  finally
    g_StartPointList.UnLock;
  end;
end;}
//{$ENDREGION}

{ TAnimalObject }

//{$REGION 'TAnimalObject Procedure'}

constructor TAnimalObject.Create;
begin
  inherited;
  m_nNotProcessCount := 0;
  m_nTargetX := -1;
  dwTick3F0 := Random(4) * 500 + 1000;
  dwTick3F4 := GetTickCount();
  m_btRaceServer := RC_ANIMAL;
  m_dwHitTick := GetTickCount - LongWord(Random(3000));
  m_dwWalkTick := GetTickCount - LongWord(Random(3000));
  m_dwSearchEnemyTick := GetTickCount();
  m_boRunAwayMode := False;
  m_dwRunAwayStart := GetTickCount();
  m_dwRunAwayTime := 0;
  //m_nCopyHumanLevel := 0;
end;

procedure TAnimalObject.HitMagAttackTarget(TargeTBaseObject: TBaseObject;
  nHitPower,
  nMagPower: Integer; boFlag: Boolean);
var
  i: Integer;
  nDamage: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
begin
  m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);
  BaseObjectList := TList.Create;
  m_PEnvir.GeTBaseObjects(TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY, True, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject = nil then Continue;
    if IsProperTarget(BaseObject) then begin
      nDamage := 0;
      Inc(nDamage, BaseObject.GetHitStruckDamage(Self, nHitPower));
      Inc(nDamage, BaseObject.GetMagStruckDamage(Self, nMagPower));
      if nDamage > 0 then begin
        BaseObject.StruckDamage(nDamage, Self);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
          BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0, '', 200);
      end;
    end;
  end;
  BaseObjectList.Free;
  //SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, SM_HIT, '');
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

procedure TAnimalObject.DelTargetCreat;
begin
  inherited;
  m_nTargetX := -1;
  m_nTargetY := -1;
end;

procedure TAnimalObject.SearchTarget;
var
  BaseObject, BaseObject18: TBaseObject;
  i, nC, n10: Integer;
begin
  BaseObject18 := nil;
  n10 := 999;
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if BaseObject <> nil then begin
      if not BaseObject.m_boDeath then begin
        if IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then begin
          nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
          if nC < n10 then begin
            n10 := nC;
            BaseObject18 := BaseObject;
          end;
        end;
      end;
    end;
  end;
  if BaseObject18 <> nil then
    SetTargetCreat(BaseObject18);
end;

procedure TAnimalObject.sub_4C959C;
var
  i, nC, n10: Integer;
  Creat, BaseObject: TBaseObject;
begin
  Creat := nil;
  n10 := 999;
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if BaseObject <> nil then begin
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
        if nC < n10 then begin
          n10 := nC;
          Creat := BaseObject;
        end;
      end;
    end;
  end; // for
  if Creat <> nil then
    SetTargetCreat(Creat);
end;

procedure TAnimalObject.SetTargetXY(nX, nY: Integer);
begin
  m_nTargetX := nX;
  m_nTargetY := nY;
end;

procedure TAnimalObject.Wondering;
begin
  if (Random(20) = 0) then
    if (Random(4) = 1) then
      TurnTo(Random(8))
    else
      WalkTo(m_btDirection, False);
end;

procedure TAnimalObject.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
begin
  inherited AttackDir(TargeTBaseObject, 0, nDir);
end;

procedure TAnimalObject.GotoTargetXY;
var
  i: Integer;
  nDir: Integer;
  n10: Integer;
  n14: Integer;
  n20: Integer;
  nOldX: Integer;
  nOldY: Integer;
begin
  if ((m_nCurrX <> m_nTargetX) or (m_nCurrY <> m_nTargetY)) then begin
    n10 := m_nTargetX;
    n14 := m_nTargetY;
    dwTick3F4 := GetTickCount();
    nDir := DR_DOWN;
    if n10 > m_nCurrX then begin
      nDir := DR_RIGHT;
      if n14 > m_nCurrY then
        nDir := DR_DOWNRIGHT;
      if n14 < m_nCurrY then
        nDir := DR_UPRIGHT;
    end
    else begin
      if n10 < m_nCurrX then begin
        nDir := DR_LEFT;
        if n14 > m_nCurrY then
          nDir := DR_DOWNLEFT;
        if n14 < m_nCurrY then
          nDir := DR_UPLEFT;
      end
      else begin
        if n14 > m_nCurrY then
          nDir := DR_DOWN
        else if n14 < m_nCurrY then
          nDir := DR_UP;
      end;
    end;
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;
    WalkTo(nDir, False);
    n20 := Random(3);
    for i := DR_UP to DR_UPLEFT do begin
      if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
        if n20 <> 0 then
          Inc(nDir)
        else if nDir > 0 then
          Dec(nDir)
        else
          nDir := DR_UPLEFT;
        if (nDir > DR_UPLEFT) then
          nDir := DR_UP;
        WalkTo(nDir, False);
      end;
    end;
  end;
end;

function TAnimalObject.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  //  Result:=False;
  if ProcessMsg.wIdent = RM_STRUCK then begin
    if (ProcessMsg.BaseObject = Self) and (TBaseObject(ProcessMsg.nParam3 {AttackBaseObject}) <> nil) then begin
      SetLastHiter(TBaseObject(ProcessMsg.nParam3 {AttackBaseObject}));
      Struck(TBaseObject(ProcessMsg.nParam3 {AttackBaseObject})); {0FFEC}
      BreakHolySeizeMode();
      if (m_Master <> nil) and
        (TBaseObject(ProcessMsg.nParam3) <> m_Master) and
        (TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_PLAYOBJECT) then begin
        m_Master.SetPKFlag(TBaseObject(ProcessMsg.nParam3));
        if (g_CastleManager.IsCastleMember(m_Master) <> nil) and
          (m_Master.m_MyGuild <> TBaseObject(ProcessMsg.nParam3).m_MyGuild) then begin
          TBaseObject(ProcessMsg.nParam3).bo2B0 := True;
          TBaseObject(ProcessMsg.nParam3).m_dw2B4Tick := GetTickCount();
        end;
      end;
      if (m_Castle <> nil) then begin
        TBaseObject(ProcessMsg.nParam3).bo2B0 := True;
        TBaseObject(ProcessMsg.nParam3).m_dw2B4Tick := GetTickCount();
      end;
      if g_Config.boMonSayMsg then
        MonsterSayMsg(TBaseObject(ProcessMsg.nParam3), s_UnderFire);
    end;
    Result := True;
  end
  else begin
    Result := inherited Operate(ProcessMsg);
  end;
end;

procedure TAnimalObject.Run;
begin
  inherited;
end;

procedure TAnimalObject.Struck(hiter: TBaseObject);
var
  btDir: Byte;
begin
  m_dwStruckTick := GetTickCount;
  if hiter <> nil then begin
    if (m_TargetCret = nil) or GetAttackDir(m_TargetCret, btDir) or (Random(6) = 0) then begin
      if IsProperTarget(hiter) then
        SetTargetCreat(hiter);
    end;
  end;
  if m_boAnimal then begin
    m_nMeatQuality := m_nMeatQuality - Random(300);
    if m_nMeatQuality < 0 then
      m_nMeatQuality := 0;
  end;
  if m_Abil.Level < 35 then
    m_dwHitTick := m_dwHitTick + LongWord(150 - _MIN(130, m_Abil.Level * 4));
  //WalkTime := WalkTime + (300 - _MIN(200, (Abil.Level div 5) * 20));
end;

//{$ENDREGION}


end.



