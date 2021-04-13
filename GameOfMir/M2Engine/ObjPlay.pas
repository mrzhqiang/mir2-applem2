unit ObjPlay;

interface

uses
  Windows, Classes, SysUtils, Forms, StrUtils, Math, Grobal2, Envir, Common, DateUtils, ObjBase, SDK;

type
  //{$REGION 'TPlayObject Class'}

  TServerProcess = procedure(ProcessMsg: pTProcessMessage; var boResult: Boolean) of object;

  TDareState = (ds_None, ds_Ready, ds_InProgress);

  TPlayObject = class(TAnimalObject)
    m_sOldSayMsg: string; //0x560
    m_nSayMsgCount: Integer; //0x560
    m_dwSayMsgTick: LongWord; //0x568
    m_boDisableSayMsg: Boolean; //0x56C
    m_dwDisableSayMsgTick: LongWord; //0x570
    m_dwCheckDupObjTick: LongWord; //0x574
    dwTick578: LongWord; //0x578
    dwTick57C: LongWord; //0x57C
    m_boInSafeArea: Boolean; //0x580
    m_sUserID: string[20]; //0x58C    登录帐号名
    m_sIPaddr: string[15]; //0x598    人物IP地址
    m_sIPLocal: string;//IP所属地区

    m_Header: TRecordHeader;
    m_OldLoginAddr: string[15];
    m_OldLoginTime: TDateTime;
    m_LoginTime: TDateTime;

    m_dLogonTime: TDateTime; //0x5B0  //登录时间
    m_dwLogonTick: LongWord; //0x5B8  战领沙城时间(Dword)
    m_dwDanderTick: LongWord; //自然成长点时间
    m_dwDanderTime: LongWord; //自然成长点时间
    m_dwMissionTime: LongWord;
    m_boReadyRun: Boolean; //0x5BC  //是否进入游戏完成
    m_nSessionID: Integer; //0x5C0
    m_dwLoadTick: LongWord; //0x5CC
    m_nServerIndex: Integer; //0x5D0  人物当前所在服务器序号
    m_boEmergencyClose: Boolean; //0x5D4  掉线标志
    m_boSoftClose: Boolean; //小退
    m_boKickFlag: Boolean; //0x5D6  断线标志(Byte)(@kick 命令)
    m_boReconnection: Boolean; //重新连接标志
    //m_boRcdSaved: Boolean; //0x5D8
    m_dw5D4: LongWord; //0x5F4
    m_NakedAbil: TNakedAbil;
    m_nNakedCount: Integer;
    m_nNakedBackCount: Integer;
    {m_dwHitIntervalTime: LongWord; //攻击间隔
    m_dwMagicHitIntervalTime: LongWord; //魔法间隔
    m_dwRunIntervalTime: LongWord; //走路间隔
    m_dwWalkIntervalTime: LongWord; //走路间隔
    m_dwTurnIntervalTime: LongWord; //换方向间隔
    m_dwActionIntervalTime: LongWord; //组合操作间隔
    m_dwRunLongHitIntervalTime: LongWord; //移动刺杀间隔
    m_dwRunHitIntervalTime: LongWord; //跑位攻击间隔
    m_dwWalkHitIntervalTime: LongWord; //走位攻击间隔
    m_dwRunMagicIntervalTime: LongWord; //跑位魔法间隔   }
    //    m_dwGetWuXinExpTime: LongWord; //增加五行经验间隔
     //   m_btGetWuXinRate: Byte;

    {m_dwMagicAttackTick: LongWord; //0x600  魔法攻击时间(Dword)
    m_dwMagicAttackInterval: LongWord; //0x604  魔法攻击间隔时间(Dword)
    m_dwAttackTick: LongWord; //0x608  攻击时间(Dword)
    m_dwMoveTick: LongWord; //0x60C  人物跑动时间(Dword)
    m_dwAttackCount: LongWord; //0x610  人物攻击计数(Dword)
    m_dwAttackCountA: LongWord; //0x614  人物攻击计数(Dword)
    m_dwMagicAttackCount: LongWord; //0x618  魔法攻击计数(Dword)
    m_dwMoveCount: LongWord; //0x61C  人物跑计数(Dword)
    m_dwMoveCountA: LongWord; //0x620  人物跑计数(Dword)
    m_nOverSpeedCount: Integer; //0x624  超速计数(Dword) }
    m_boDieInFight3Zone: Boolean; //0x628

    m_dwMagicHitTimeEX: LongWord;
    m_dwHitTime: LongWord; //人物攻击间隔
    m_dwMagicHitTime: LongWord; //人物魔法攻击间隔
    m_dwRunTime: LongWord; //人物跑动间隔
    m_dwWalkTime: LongWord; //人物走动间隔
    m_dwTurnTime: LongWord; //人物转向间隔
    m_dwButchTime: LongWord; //人物挖取间隔
    m_boHitDelay: Boolean; //人物攻击延时
    m_boMagicHitDelay: Boolean; //人物魔法攻击延时
    m_boRunDelay: Boolean; //人物跑动延时
    m_boWalkDelay: Boolean; //人物走动延时
    m_boTurnDelay: Boolean; //人物转向延时
    m_boButchDelay: Boolean; //人物挖取延时

    m_nHitCount: Integer; //人物攻击容错数量
    m_nMagicHitCount: Integer; //人物魔法攻击容错数量
    m_nRunCount: Integer; //人物跑动容错数量
    m_nWalkCount: Integer; //人物走动容错数量
    m_nTurnCount: Integer; //人物转向容错数量
    m_nButchCount: Integer; //人物挖取容错数量
    //m_Script: pTScript; //0x62C
    m_NPC: TBaseObject; //0x630
    m_nVal: array[0..999] of Integer; //玩家的变量 P999
    m_nMval: array[0..999] of Integer;//玩家的变量
    m_DyVal: array[0..9] of Integer; //玩家的摇骰子变量
    m_sPlayDiceLabel: string;
    m_boTimeRecall: Boolean; //0x684
    m_dwTimeRecallTick: LongWord;
    m_MoveEnvir: TEnvirnoment; //0x68C
    m_nMoveX: Integer; //0x690
    m_nMoveY: Integer; //0x694
    m_dwSaveRcdTick: LongWord; //0x6A0 保存人物数据时间间隔
    m_boNewHuman: Boolean; //0x6A8
    m_boSendNotice: Boolean; //0x6A9
    m_dwWaitLoginNoticeOKTick: LongWord;
    m_boLoginNoticeOK: Boolean; //0x6AA
    m_boResetLabel: Boolean;
    //    m_boExpire: Boolean; //0x6AC  帐号过期
    m_dwShowLineNoticeTick: LongWord; //0x6B0
    m_nShowLineNoticeIdx: Integer; //当前显示公告的ID
    //m_nSoftVersionDateEx: Integer;
    m_CanJmpScriptOldLableList: TStringList;
    m_CanJmpScriptNewLableList: TStringList;
    m_CanJmpScriptLableList: TStringList; //能跳转脚本标签列表
    m_nScriptGotoCount: Integer; //脚本跳转GOTO数
    m_nScriptCurrLable: Integer; //用于处理 @back 脚本命令
    m_nScriptGoBackLable: Integer; //用于处理 @back 脚本命令
    //m_dwTurnTick: LongWord;
    m_wOldIdent: Word;//旧的动作消息
    m_btOldDir: Byte;//旧的方向

    m_boFirstAction: Boolean; //第一个操作
    m_dwActionTick: LongWord; //二次操作之间间隔时间
    m_sDearName: string[14]; //配偶名称
    m_DearHuman: TPlayObject;//配偶类
    m_boCanDearRecall: Boolean; //是否允许夫妻传送
    m_boCanMasterRecall: Boolean;//是否允许师徒传送
    m_dwDearRecallTick: LongWord; //夫妻传送时间
    m_dwMasterRecallTick: LongWord;//师徒传送间隔
    //m_MasterName: THumMasterName; //师徒名称
    //m_sMasterName: string[14];
    //m_MasterHuman: TPlayObject;
    m_MasterList: TStringList;
    m_boMaster: Boolean;
    m_CustomVariable: THumCustomVariable;
    m_BStrVariable: THumBVariable;
    m_nCreditPoint: Integer; //声望点
    m_AppendBagItems: THumanAppendBagItems;
    //m_btMarryCount: Byte; //离婚次数
    m_wMasterCount: Word; //出师徒弟个数
    m_boChangeName: Boolean;
    m_btReLevel: Byte; //转生等级
    m_btReColorIdx: Byte;
    m_dwReColorTick: LongWord;
    m_nKillMonExpLiterary: Integer; //杀怪经验倍数
    m_dwGetMsgTick: LongWord; //处理消息循环时间控制

    m_PoseBaseObject: TBaseObject;//面对面的角色
    m_boStartMarry: Boolean;
    m_boStartMaster: Boolean;//开始收徒或拜师
    m_boStartUnMarry: Boolean;
    m_boStartUnMaster: Boolean;//开始出师
    m_boFilterSendMsg: Boolean; //禁止发方字(发的文字只能自己看到)
    m_nKillMonExpRate: Integer; //杀怪经验倍数(此数除以 100 为真正倍数)
    m_nPowerRate: Integer; //人物攻击力倍数(此数除以 100 为真正倍数)
    m_dwKillMonExpRateTime: LongWord;
    m_dwPowerRateTime: LongWord;//人物攻击力倍数改变恢复正常的时间计数(秒)
    m_dwRateTick: LongWord;

    m_QuestFlag: TQuestFlag; //0x128 129
    m_MissionFlag: TMissionFlag;
    m_MissionInfo: TMissionInfos;
    m_MissionArithmometer: TMissionArithmometer;

    m_nMemberType: Integer; //会员类型
    m_nMemberLevel: Integer; //会员等级
    m_boSendMsgFlag: Boolean; //发祝福语标志
    m_boChangeItemNameFlag: Boolean;

    m_nGameGold: Integer; //游戏币

    //m_boDecGameGold: Boolean; //是否自动减游戏币
    //m_dwDecGameGoldTime: LongWord;
    m_dwDecGameGoldTick: LongWord;//自动减游戏币间隔
    //m_nDecGameGold: Integer; //一次减点数

    //m_boIncGameGold: Boolean; //是否自动加游戏币
    //m_dwIncGameGoldTime: LongWord;
    m_dwIncGameGoldTick: LongWord;//自动加游戏间隔
    //m_nIncGameGold: Integer; //一次减点数

    m_nGamePoint: Integer; //游戏点数
    m_nCheckEMail: Integer;
    //    m_dwIncGamePointTick: LongWord;

    m_nGameDiamond: Integer; //金刚石 改为 积分了
    m_nGameGird: Integer; //灵符
    m_dwPayMentPointTick: LongWord;//秒卡点间隔

    m_dwDecHPTick: LongWord;//减HP间隔
    m_dwIncHPTick: LongWord;//加HP间隔

    m_GetWhisperHuman: TPlayObject;//侦听私聊对象
    m_dwClearObjTick: LongWord;//清除对像间隔
    m_wContribution: Word; //贡献度
    m_sRankLevelName: string; //显示名称格式串
    m_boFilterAction: Boolean;//动作过滤
    m_nClientFlagMode: Integer;
    m_dwAutoGetExpTick: LongWord;//自动泡点的时间间隔
    m_nAutoGetExpTime: Integer;//自动泡点时间
    m_nAutoGetExpPoint: Integer;//自动泡点数
    m_AutoGetExpEnvir: TEnvirnoment;//自动泡点地图
    m_boAutoGetExpInSafeZone: Boolean;
    m_DynamicVarList: TList;//自定义变量列表
    m_dwClientTick: LongWord;//客户端间隔
    m_boTestSpeedMode: Boolean; //进入速度测试模式
    m_nCheckEatCount: Byte;
    m_nCheckChangeMapCount: Byte;
    m_nCheckNpcCount: Byte;
    m_boIncCount: Boolean;

    nRunCount: Integer;
    dwRunTimeCount: LongWord;
    m_dwDelayTime: LongWord;

    m_boAllowReAlive: Boolean; //是否允许复活
    m_dwAutoAddExpPointTick: LongWord;
    m_dwAutoAddExpPointTimeTick: LongWord;

    m_boStartAutoAddExpPoint: Boolean;//是否自动增加经验(挂机)
    m_nBindGold: Integer;

    {    m_boTimeGoto: Boolean;
        m_dwTimeGotoTick: LongWord;
        m_sTimeGotoLable: Integer;
        m_TimeGotoNPC: TObject; }
    m_DelayGotoList: TList;
    m_boAddSaveList: Boolean;

    m_nDealGoldPose: Integer;
    m_dwDedingUseTick: LongWord;//地钉使用间隔

    m_boPlayOffLine: Boolean; //是否下线触发
    m_nInteger: array[0..999] of Integer; //人物变量
    m_sString: array[0..999] of string; //人物变量
    m_sASSEMBLEITEMNAME: string;
    m_MissionIndex: TMissionIndex;
    m_CustomDataList: TList;
    m_CheckMsgList: TList;
    m_FriendList: TStringList;
    m_nDBIndex: Integer;
    m_nWaitIndex: Integer;
    m_nSQLAppendCount: Integer;
    m_nSQLAppendBool: Boolean;
    m_nSQLAppendShopIndex: Word;
    m_nSQLAppendString: string;
    m_nIDIndex: Integer;
//    m_RealityInfo: TUserRealityInfo;
//    m_dwUpLoadPhotoTime: TDateTime;
//    m_nLookPhotoIndex: Integer;
//    m_PPhotoData: PChar;
//    m_nPhotoSize: Word;
//    m_dwLoadPhotoTick: LongWord;

    m_boDealing: Boolean; //0x317
    m_DealLastTick: LongWord; //0x318 交易最后操作时间
    m_DealCreat: TPlayObject; //0x31C

    m_DealItemList: TList; //0x410
    m_nDealGolds: Integer; //0x414  交易的金币数量(Dword)
    m_boDealOK: Boolean; //0x418  确认交易标志(Byte
    m_boDealLock: Boolean; //  确认交易锁定标志

    m_ShopSayTick: LongWord; //店铺留言间隔

    m_ShopSellItemList: TList; //商铺出售物品列表
    m_ShopBuyItemList: TList; //商铺收购物品列表
    m_nShopGold: Integer; //商铺资金
    m_nShopGameGold: Integer;
    m_boShoping: Boolean; //摆摊状态
    m_btShopLevel: Byte;
    m_boShopLeft: Boolean;
    m_dwShopTick: LongWord;
    m_MagicList: TList; //0x41C  技能表

    m_MagicArr: array[0..SKILL_MAX] of pTUserMagic; //技能索引表

    m_sShopTitle: string[24];
    m_sStoragePwd: string[12];
    m_btStorageErrorCount: Byte;
    m_boStorageLock: Boolean;
    m_StorageLockTime: TDateTime;
    m_StorageItemList: array[0..4] of TList; //仓库物品列表
    m_boStorageOpen: array[0..4] of Boolean;
    m_dwStorageTime: array[0..4] of TDateTime;
    m_nStorageGold: Integer;

    m_dwCheckUserItemTick: LongWord;
    m_ReturnItemsList: TList;
    m_UserKeySetup: TUserKeySetup; //用户按键设置息
    m_ClickNPC: TBaseObject; //用户最后一次点击的NPC,防止封包刷NPC
    m_ClickHideNPC: TBaseObject;

    m_nPullulation: Integer;

    m_boCanCreateGroup: Boolean;
    //    m_MagicConcatenation: TMagicConcatenation;

    m_boUseThrusting: Boolean; //刺杀是否开启
    m_boUseHalfMoon: Boolean; //半月弯刀是否开启
    m_boFireHitSkill: Boolean; //烈火剑法是否准备就绪
    m_bo56HitSkill: Boolean; //逐日剑法是否准备就绪
    m_boLongIceHit: Boolean; //开天斩是否准备就绪
    m_boLongIceHitIsLong: Boolean; //开天斩长或短
    m_dwLatestFireHitTick: LongWord; //0x530
    m_dwLongIceHitTick: LongWord; //0x530
    m_dwLatest56HitTick: LongWord; //0x530
    m_dwLatest110HitTick: LongWord; //0x530
    m_bo110HitSkill: Boolean;
    m_dwLatest112HitTick: LongWord; //0x530
    m_bo112HitSkill: Boolean;
    m_dwLatest113HitTick: LongWord; //0x530
    m_bo113HitSkill: Boolean;
    m_dwLatest122HitTick: LongWord; //0x530
    m_bo122HitSkill: Boolean;
    m_boCheckAppend: Boolean;
    m_CheckObject: TPlayObject;
    m_boCheckObject: Boolean;
    m_nLongIceHitDouble: ShortInt; //0x23E

    m_boAliveing: Boolean; //准备复活
    m_dwAliveTick: LongWord; //复活时间
    m_boDoctorAlive: Boolean; //技能复活
    m_btDoctorAliveLevel: Byte; //复活技能等级
    m_nAliveHP: Integer; //复活后的血量值
    m_btAliveType: Byte;

    m_CboMagicListInfo: TCboMagicListInfo; //连击设置
    m_nCboNowMagicID: Integer;
    m_nCboNowHitCMD: Integer;
    m_dwCboMagicTime: LongWord;
    m_UserOptionSetup: TUserOptionSetup;
    m_UserItemsSetup: TUserItemsSetup;
    m_wItemsSetupCount: Word;
    m_nAllowSetup: LongWord;
    m_boUserLogon: Boolean; //是否已登录;

    m_CenterMsgList: TList;

    m_nCheckMsgArr: array[TCheckMsgClass] of Byte;

    m_dwGuildTick: LongWord;
    m_boDayChange: Boolean;
    m_nMineCount: Integer;
    m_boAddStabilityPoint: Boolean;
    m_FBEnvir: TEnvirnoment;
    m_boFBSendTime: Boolean;
    m_boFBSendExitTime: Boolean;
    m_boFBSendFailTime: Boolean;
    m_dwFBExitTick: LongWord;
    m_sGuildName: string[GuildNameLen];
    m_boOpenBox: Boolean;
    m_btOpenIndex: Byte;
    m_BoxGoldInfo: TBoxItemInfoArr;
    m_BoxItems: TClientBoxInfo;
    m_BoxGetItem: TBoxItemInfo;

    m_boClickOpenBox: Boolean;
    m_dwClickOpenBoxTime: LongWord;
    m_ClickBoxObject: TBaseObject;

    m_boClickOpenGuage: Boolean;
    m_dwClickOpenGuageTime: LongWord;
    m_ClickGuageNPC: TBaseObject;
    m_ClickGuageNPCLabel: string;

    m_boSafeOffLine: Boolean;
    m_boOffLineLogin: Boolean;

    m_MakeMagic: TMakeMagic;
    m_nMakeMagicPoint: Word;
    m_ADListIndex: Integer;
    m_ADTick: LongWord;
    m_dwEatTick: LongWord;
    m_DareObject: TPlayObject;
    m_DareNpc: TObject;
    m_DareState: TDareState;
    m_DareTick: LongWord;
    m_BoDareMaster: Boolean;
    m_boStatusModeArr: array[0..STATUS_COUNT - 1] of Boolean;
    m_sLastKillMonName: string[14];

    m_IconInfo: TIconInfos;
    m_HookItemEx: TList;
  private
    FServerProcess: array[1..MAXCLIENTSERVERCOUNT - 1] of TServerProcess;
    procedure ClientDropGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGroupMode(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure ClientQueryUserState(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientQueryUserSet(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientDropItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientPickUpItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientOpenDoor(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientTakeOnItems(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientTakeOffItems(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientUseItems(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    function UseStdmodeFunItem(StdItem: pTStdItem): Boolean;
    {function ClientGetButchItem(BaseObject: TBaseObject; nX, nY: Integer; btDir: Byte;
      var dwDelayTime: LongWord): Boolean;     }
    //procedure ClientGetButchItemEx(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientChangeMagicKey(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientSoftClose(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientClickNPC(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientClickBox(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGuageBar(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientMakeMagic(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGetTopInfo(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientMissionStateChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientRemoveStone(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientSpeedClose(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientCenterMsgClick(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientSetMagicKey(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure ClientMerchantDlgSelect(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientItemStrengthen(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientItemAbilityMove(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientCompoundItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientUserSellItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientUserBuyItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientUserBuyReturnItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    //procedure ClientQueryRepairCost(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientRepairItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientTakeOnOffAddBag(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGuildGoldChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGuildLevelUp(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientAlive(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure ClientGetCheckMsg(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientCheckMsg(tClass: TCheckMsgClass; AddPointer: Pointer; nSelect: Integer);
    procedure ClientGropuClose();

    procedure ClientCreateGroup(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientAddGroupMember(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure AddGroupMember(PlayObject: TPlayObject);
    procedure ClientDelGroupMember(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientDealTry(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientAddDealItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientDelDealItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientCancelDeal(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientChangeDealGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientDealModeChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientDealEnd();
    procedure ClientDealLock();
    procedure ClientStorageItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientTakeBackStorageItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientMakeDrugItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientUnsealItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientBagUseItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientClearMission(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure ClientOpenGuildDlg(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGuildHome(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGuildMemberList(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGuildAddMember(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure GuildAddMember(PlayObject: TPlayObject);
    procedure ClientGuildDelMember(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGuildUpdateNotice(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGuildUpdateRankInfo(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientAppend(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientAppendClient(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGetSayItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientUniteItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    function ClientChangeDir(wIdent: Word; nX, nY, nDir: Integer; boLateDelivery: Boolean; var dwDelayTime: LongWord): Boolean;
    procedure ClientNakedChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientRealityInfoChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    function ClientWalkXY(wIdent: Word; nX, nY: Integer; boLateDelivery: Boolean; var dwDelayTime: LongWord): Boolean;
    function ClientHorseRunXY(wIdent: Word; nX, nY: Integer; boLateDelivery: Boolean; var dwDelayTime: LongWord): Boolean;
    function ClientRunXY(wIdent: Word; nX, nY: Integer; boLateDelivery: Boolean; var dwDelayTime: LongWord): Boolean;
    //    function ClientLeapXY(wIdent: Word; nX, nY: Integer; nFlag: Integer; var dwDelayTime: LongWord): Boolean;
    function ClientHitXY(wIdent: Word; nX, nY, nDir: Integer; boLateDelivery: Boolean; var dwDelayTime: LongWord):
      Boolean;
    function ClientSitDownHit(nX, nY, uid, nDir: Integer; boLateDelivery: Boolean; var dwDelayTime: LongWord): Boolean;
    function ClientSpellXY(wIdent: Word; nKey: Integer; nTargetX, nTargetY:
      Integer; TargeTBaseObject: TBaseObject; boLateDelivery: Boolean; var dwDelayTime: LongWord): Boolean;
    function GetUserItemWeitht(nWhere: Integer): Integer;

    function IsBeginSpell110(UserMagic: pTUserMagic): Boolean;
    function IsBeginSpell112(UserMagic: pTUserMagic): Boolean;
    function IsBeginSpell113(UserMagic: pTUserMagic): Boolean;
    procedure NextCboMagicInfo(BaseObject: TBaseObject);

    procedure ClearWarrSelectHit(pSelectVal: Pointer);
    procedure SendDelDealItem(UserItem: pTUserItem);//发送删除交易栏里的物品
    procedure SendAddDealItem(UserItem: pTUserItem);//发送放到交易栏里的物品
    procedure MapEventCheck(nEvent: Byte; sItemName: string);
    procedure EventCheck(nEvent: Byte; sItemName: string);
    procedure OpenDealDlg(BaseObject: TPlayObject);
    function EatUseItems(nShape: Integer): Boolean;//吃使用物品
    procedure BaseObjectMove(sMAP, sX, sY: string);
    function RepairWeapon(): Boolean;//修理武器
    function SuperRepairWeapon(): Boolean;//超级修理武器
    function WinLottery(): Boolean;//赢彩票
    function WeaptonMakeLuck(): Boolean;//武器加幸运
    function PileStones(nX, nY: Integer): Boolean;//挖矿
    procedure MakeMine();//挖矿,给玩家矿石
    function GetRangeHumanCount(): Integer;
    function GetSelectNpc(nIndex: Integer): TBaseObject;
    function GetHumLook: Word;
    procedure SendNotice();
    procedure SendNoticeEx(MD5: string);
    procedure SendLogon();
    procedure SendAbilityMoveSet;
    procedure SendCompoundInfos;
    procedure SendServerConfig();
    procedure ClientQueryUserName(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    //    function LeapTo(btDir: Byte; boFlag: Boolean; nDestX, nDestY: Integer): Boolean;
        //procedure SendSaveItemList(nBaseObject: Integer);
    procedure SendDelItemList(ItemList: TStringList);
    procedure SendMapDescription();
    procedure SendGoldInfo(boSendName: Boolean);
    procedure ServerCreateGuild(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    //function CheckActionStatus(wIdent: Word; var dwDelayTime: LongWord): Boolean;
    procedure RecalcNakedAbilitys;
    procedure CheckMarry();
    procedure CheckMaster();
    procedure UnMaster;

    procedure CheckFriend();
    procedure SetFriend(NameBaseObject: TPlayObject);
    procedure SetDeal(DealObject: TPlayObject);
    function InFriendList(AddName: string): Boolean;
    //    function CheckDenyLogon: Boolean;
    procedure ProcessSpiritSuite;
    procedure RecalcBagCount;
    procedure CheckSpeedCount(var nCount: Integer; sHitName: string);
    function HorseRunTo(btDir: Byte; boFlag: Boolean): Boolean;
        //procedure ClientGetTaxisList(nIdx, njob, nPage: integer);

    procedure ClientQueryBagItems(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure ClientTurn(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientWalk(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientHorseRun(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientRun(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientAttack(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientSitDown(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientLeap(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientSpell(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure ClientSay(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientMapApoise(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure ClientUserShopSay(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientUserShop(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientClickUserShop(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientBuyUserShop(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGetBackStorage(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGetBackStoragePass(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientStorageGoldChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientUpdate(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure ClientQueryReturnItems(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientCboMagic(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientTradeGameGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGetShopList(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientBuyShopItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientUserPhoto(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientFriendChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientEMailInfo(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGameSetupInfo(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGMUpdateMsg(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientOpenBox(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure ServerChangeGameGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerBuyShopItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerTradeGameGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerWalk(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerHorseRun(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerRun(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerLeap(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure ServerHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    //procedure ServerHeavyHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    //procedure ServerBigHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerSpell(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    //procedure ServerSpell2(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    //procedure ServerLongHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    //procedure ServerWideHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    //procedure ServerFireHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
{    procedure ServerCrsHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure Server41(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure Server42(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure Server43(ProcessMsg: pTProcessMessage; var boResult: Boolean); }
   // procedure ServerMonMove(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure ServerMoveFail(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerTurn(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerStruck(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerDeath(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerDisappear(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerSkeleton(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerUserName(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerLevelUp(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerChangeNameColor(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerLogon(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerSay(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerHealthSpellChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerItemShow(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerItemHide(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerDoorOpen(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerDoorClose(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerFeatureChanged(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerIconInfo(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerChangeMap(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerButch(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerMagicFire(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerMagicFireFail(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerGameGoldChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerCharStatusChanged(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    //procedure ServerUserGetBackItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerSendDelItemList(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerAlive(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerDigUp(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerDigDown(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerFlyaxe(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerLighting(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure Server10205(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerMonMagic(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerSpaceMoveFire(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerSpaceMoveFire2(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerSpaceMoveShow(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerReConnection(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerOpenHealth(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerCloseHealth(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerBreakWeapon(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerChangeFace(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerPlayDice(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerShowEffect(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerUserShop(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerOffLineShop(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerGetLargessGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerDefMessage(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ServerDefSocket(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    procedure CheckUserItemTime(boLogon: Boolean);
    procedure SetUserTime(dwTime: LongWord);
    procedure SetAllowSetup;
    procedure CheckShopingClose();
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure InitializeServerProcess();
    procedure SendNakedAbility;
    procedure SendRealityInfo;
    procedure SendGameSetupInfo;
    procedure SendMissionInfo;
    procedure SendMakeMagic;
    procedure SendFilterInfo;
    procedure SendMissionInfoArithmometer(boFillChar: Boolean);
    procedure GetStartPoint();
    procedure RefGroupWuXin(BaseObject: TBaseObject);
    function CancelGroup(): Boolean;
    procedure SendUseitems(); { virtual;}
    procedure SendUseMagic(); {virtual; }
    procedure SendStorageInfo();
    procedure SetStoragePass();
    procedure DeleteMasterByName(sName: string);
    procedure OnAction(ActionType: TOnActionType); override;

    function IsStorage(nIdx: Byte): Boolean;
    procedure MakeItem(MakeGoods: pTMakeGoods; sMsg: string; BaseObject: TBaseObject; btIdx, btAuto: Byte);
    procedure ClientGuildAlly(ProcessMsg: pTProcessMessage; var boResult: Boolean);
    procedure ClientGuildBreakAlly(ProcessMsg: pTProcessMessage; var boResult: Boolean);

    function MakeClientItem(UserItem: pTUserItem): string;
    function CheckItemsNeed(StdItem: pTStdItem): Boolean;
    function GetMagicInfo(nMagicID: Integer): pTUserMagic; overload;
    function GetMagicInfo(sMagicName: string): pTUserMagic; overload;
    function EatItems(StdItem: pTStdItem; UserItem: pTUserItem): Boolean;
    function ReadBook(StdItem: pTStdItem): Boolean;
    function DoSpell(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; BaseObject: TBaseObject): Boolean;
    function IsMyFriend(PlayObject: TPlayObject): Boolean;
    function DoMotaebo(nDir: Byte; nMagicLevel: Integer): Boolean;
    function DoMotagecbo(nDir: Byte; nMagicLevel: Integer): Boolean;
    function CanMotaebo(BaseObject: TBaseObject; nMagicLevel: Integer): Boolean;
    function CheckTakeOnItem(StdItem: pTStdItem; UserItem: pTUserItem): Boolean;
    function CheckTakeOnItems(nWhere: Integer; StdItem: pTStdItem; UserItem: pTUserItem): Boolean;
    //function CheckItemBindUse(UserItem: pTUserItem): Boolean;
    procedure DiamondChanged;
    procedure GameGirdChanged;
    function AddCheckMsg(sMsg: string; tClass: TCheckMsgClass; AddPointer: TPlayObject; AddTime: LongWord = 62): pTCheckMsg;
    function AbilityUp(UserMagic: pTUserMagic): Boolean;
    procedure SearchViewRange();
    procedure PKDie(PlayObject: TPlayObject);//PK死亡
    procedure GameTimeChanged();//游戏时间改变
    procedure RunNotice();
    procedure SendActionGood();
    procedure SendActionFail();
    function IncGold(tGold: Integer): Boolean;//增加金币
    procedure IncGameGold(nGameGold: Integer);
    procedure SendSocket(DefMsg: pTDefaultMessage; sMsg: string); virtual;
    procedure SendDefMessage(wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; sMsg: string);
    function IsEnoughBag(): Boolean;//包裹是否满
    procedure SendAddItem(UserItem: pTUserItem);
    procedure SendDelItems(UserItem: pTUserItem);
    procedure Whisper(whostr, saystr: string);//私聊
    function IsBlockWhisper(sName: string): Boolean;
    function QuestCheckItem(sItemName: string; var nCount: Integer; var nParam: Integer;
      var nDura: Integer): pTUserItem;
    function QuestTakeCheckItem(CheckItem: pTUserItem): Boolean;
    procedure GainExp(dwExp: LongWord);
    procedure GetExp(dwExp: LongWord);
    procedure HorseGetExp(dwExp: LongWord);
    //procedure GetWuXinExp(dwExp: LongWord);
    procedure WinExp(dwExp: LongWord);
    procedure LiteraryChange(boSend: Boolean);
    //procedure WinWuXinExp(dwExp: LongWord);
    function DecGold(nGold: Integer): Boolean;
    procedure DecGameGold(nGameGold: Integer);
    procedure Run(); override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure RecalcAbilitys(); override;//刷新能力
    procedure RecalcCboMagicList();
    procedure MakeSaveRcd(var HumanRcd: THumDataInfo);
    procedure DealCancel();
    procedure DealCancelA();
    function GetShowName(): string; override;
    procedure GetBackDealItems();
    procedure Disappear(); override;
    //procedure GoldChange(sChrName: string; nGold: Integer);
    procedure ProcessUserLineMsg(sData: string);
    procedure ProcessSayMsg(sData: string);
    function GetItemInfo(str: string): string;
    procedure ClearStatusTime();
    procedure UserLogon();//人物登陆游戏
    procedure UserOffLineLogon();
    function OpenBox(nIndex: Integer; boGet: Boolean): Boolean;
    function GetBoxItem(var nBack: Integer): Boolean;
    function RefRankInfo(nRankNo: Integer; sRankName: string): Boolean;
    procedure RefUserState;
    function GetUserState(): Integer;
    procedure SendGroupMembers(BaseObject: TPlayObject);
    procedure SendGroupMsg(BaseObject: TPlayObject; wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word;
      sMsg: string);
    procedure SendGroupSocket(BaseObject: TPlayObject; wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word;
      sMsg: string);
    procedure SendRefGroupMsg(BaseObject: TPlayObject; wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word;
      sMsg: string);
    procedure JoinGroup(PlayObject: TPlayObject);
    procedure ChangeGroup(PlayObject: TPlayObject);
    function GeTBaseObjectInfo(): string;
    function GetHitMsgCount(): Integer;
    function GetSpellMsgCount(): Integer;
    function GetWalkMsgCount(): Integer;
    function GetRunMsgCount(): Integer;
    function GetTurnMsgCount(): Integer;
    function GetSiteDownMsgCount(): Integer;
    function GetDigUpMsgCount(): Integer;
    //procedure SetScriptLabel(sLabel: string);
    procedure GetScriptLabel(var NewLabelList: TStringList; var OldLabelList: TStringList); overload;
    procedure GetScriptLabel(sMsg: string); overload;
    function LableIsCanJmp(var sLabel: string; boResetLabel: Boolean): Boolean;
    function GetMyInfo(): string;
    procedure MakeGhost; override;
    procedure ScatterBagItems(ItemOfCreat: TBaseObject); override;
    procedure DropUseItems(BaseObject: TBaseObject); override;
    procedure RecallHuman(sHumName: string); overload;
    procedure RecallHuman(PlayObject: TPlayObject); overload;
    procedure SendAddMagic(UserMagic: pTUserMagic); virtual;
    procedure SendDelMagic(UserMagic: pTUserMagic); virtual;
    procedure ReQuestGuildWar(sGuildName: string);
    procedure SendUpdateItem(UserItem: pTUserItem);
    function MakeOffLine(): Boolean;
    procedure ClearDare(nState: Integer);

    procedure ChangeStatusMode(nStatus: Integer; boMode: Boolean); override;
    procedure Die(); override;
    function DieFunc: Boolean;
    function LevelUpFunc: Boolean;//升级函数
    procedure LevelUpFuncEx(nLevel: Word);
    function KillPlayFunc: Boolean;//杀死角色函数
    procedure SpeedCloseFunc;
    function KillMonsterFunc(BaseObject: TBaseObject): Boolean;//杀死怪物函数
    function DieGotoLable(): Boolean;//死亡触发
    procedure Initialize(); override;
    function IsTrainingSkill(nIndex: Integer): Boolean;
    procedure RecalcHitSpeed();
    function GetQuestFlagStatus(nFlag: Integer): Integer; overload;
    function GetQuestFlagStatus(sFlag: string; nDef: Integer): Integer; overload;
    procedure SetQuestFlagStatus(nFlag: Integer; nValue: Integer); overload;
    procedure SetQuestFlagStatus(sFlag: string; nValue, nDef, nRange: Integer); overload;
    function GetMissionFlagStatus(nFlag: Integer): Integer; overload;
    function GetMissionFlagStatus(sFlag: string; nDef: Integer): Integer; overload;
    procedure SetMissionFlagStatus(nFlag: Integer; nValue: Integer); overload;
    procedure SetMissionFlagStatus(sFlag: string; nValue, nDef, nRange: Integer); overload;
    function _Attack(var wHitMode: Word; AttackTarget: TBaseObject): Boolean; override;
    procedure AttackDir(TargeTBaseObject: TBaseObject; wHitMode: Word; nDir: Integer); override;
    procedure ClearCenterMsg(nFlag: Integer);
    procedure RefIconInfo();
    function TakeOffItem(btWhere: Byte; nItemIdx: Integer; boClient, boForce: Boolean): Boolean;
  end;
  //{$ENDREGION}

implementation

uses M2Share, Guild, HUtil32, EDcodeEx, ObjNpc, IdSrvClient, ItmUnit, Event, FrmShop, FrnEmail, CheckDll, PsAPI,
  ObjMon, LocalDB, Castle, svMain, {$IFDEF PLUGOPEN}PlugOfEngine, {$ENDIF}ObjPlayCmd, MD5Unit, UsrEngn;

{ TPlayObject }

//{$REGION 'TPlayObject Procedure'}

constructor TPlayObject.Create;
var
  i: Integer;
begin
  inherited;

  m_btRaceServer := RC_PLAYOBJECT;
  m_boEmergencyClose := False;
  //m_boSwitchData := False;
  m_boReconnection := False;
  m_boKickFlag := False;
  m_boSoftClose := False;
  m_boReadyRun := False;
  m_boClickOpenBox := False;
  m_dwClickOpenBoxTime := 0;
  m_nNakedBackCount := 0;
  m_dwEatTick := 0;

  m_boClickOpenGuage := False;
  m_dwClickOpenGuageTime := 0;
  m_ClickGuageNPC := nil;
  m_DareObject := nil;
  m_DareNpc := nil;
  m_sLastKillMonName := '';
  m_DareState := ds_None;
  m_ClickGuageNPCLabel := '';
  m_boMaster := False;
  m_dwMissionTime := GetTickCount + 60 * 60 * 1000;

  m_ADListIndex := 0;
  m_nLongIceHitDouble := 0;
  m_ADTick := GetTickCount;

  m_nCheckEMail := 0;
  m_boOffLineLogin := False;
  m_ClickBoxObject := nil;
  m_ShopSayTick := GetTickCount;
  m_dwGuildTick := GetTickCount;
  m_boAddStabilityPoint := False;
  m_boResetLabel := False;
  m_boOpenBox := False;
  m_boSafeOffLine := False;
  m_sGuildName := '';
  m_boKeepRun := True;
  m_boUserLogon := False;
  m_boDayChange := True;
  m_boFBSendTime := False;
  m_boFBSendExitTime := False;
  m_boFBSendFailTime := False;
  m_dwFBExitTick := 0;
  m_nCheckEatCount := 0;
  m_nCheckChangeMapCount := 0;
  m_nCheckNpcCount := 0;
  m_boIncCount := False;
  m_nMineCount := 0;
  m_FBEnvir := nil;

  m_DealItemList := TList.Create;
  m_CenterMsgList := TList.Create;
  m_nDealGolds := 0;
  m_boDealing := False;
  m_DealCreat := nil;
//  m_PPhotoData := nil;
//  m_dwLoadPhotoTick := GetTickCount;
  SafeFillChar(m_nCheckMsgArr, SizeOf(m_nCheckMsgArr), #0);
  SafeFillChar(m_boStatusModeArr, SizeOf(m_boStatusModeArr), False);
//  m_nPhotoSize := 0;
  m_DealLastTick := 0;
  m_nWaitIndex := 0;
  m_nSQLAppendCount := 0;
  m_nSQLAppendBool := False;
  m_nSQLAppendString := '';
  m_nSQLAppendShopIndex := 0;
  m_boDealOK := False;
  m_boDealLock := False;
  m_boUseThrusting := False;
  m_boUseHalfMoon := False;
  m_boFireHitSkill := False;
  m_bo56HitSkill := False;
  m_boLongIceHit := False;
  m_bo110HitSkill := False;
  m_bo112HitSkill := False;
  m_bo113HitSkill := False;
  m_bo122HitSkill := False;
  m_boCheckAppend := False;
  m_CheckObject := nil;
  m_boCheckObject := False;

  FillChar(m_MakeMagic, SizeOf(m_MakeMagic), #0);
  m_nMakeMagicPoint := 0;
  m_btStorageErrorCount := 0;
  m_ClickNPC := nil;
  m_ClickHideNPC := nil;

  m_MagicList := TList.Create;
  m_ShopSellItemList := TList.Create; //商铺出售物品列表
  m_ShopBuyItemList := TList.Create; //商铺收购物品列表
  m_nShopGold := 0; //商铺资金
  m_nShopGameGold := 0;
  m_boShoping := False; //摆摊状态
  m_sShopTitle := '';
  m_btShopLevel := 0;
  m_dwShopTick := 0;
  //bo698 := False;
  //n69C := 0;
  m_dwSaveRcdTick := GetTickCount();
  m_boWantRefMsg := True;
  //m_boRcdSaved := False;
  m_boDieInFight3Zone := False;
  //m_Script := nil;
  m_boTimeRecall := False;
  //m_boMapApoise := False;
  m_dwMapApoiseTick := GetTickCount;
  m_MoveEnvir := nil;
  m_nMoveX := 0;
  m_nMoveY := 0;
  m_nDBIndex := -1;
//  m_nLookPhotoIndex := -1;
  m_nIDIndex := 0;
  m_dwRunTick := GetTickCount();
  m_nRunTime := 250;
  m_dwSearchTime := 1000;
  m_dwSearchTick := GetTickCount();
  m_nViewRange := g_Config.nSendRefMsgRange;
  m_boNewHuman := False;
  m_boLoginNoticeOK := False;
  //m_boExpire := False;
  m_boSendNotice := False;
  m_dwCheckDupObjTick := GetTickCount();
  dwTick578 := GetTickCount();
  dwTick57C := GetTickCount();
  m_boInSafeArea := False;
  //5F8 := 0;
  //n5FC := 0;
  m_FriendList := TStringList.Create;
  m_LoginTime := Now();

  SafeFillChar(m_MagicArr, SizeOf(m_MagicArr), #0);
  //m_dwGetWuXinExpTime := GetTickCount;
  //m_btGetWuXinRate := 0;
  //m_dwIsGetWuXinExpTime := 0;
  m_nBindGold := 0;
  //m_dwMagicAttackTick := GetTickCount();
  //m_dwMagicAttackInterval := 0;
  //m_dwAttackTick := GetTickCount();
  //m_dwMoveTick := GetTickCount();
  //m_dwTurnTick := GetTickCount();
  m_MasterList := TStringList.Create;
  m_dwActionTick := GetTickCount();
  m_CheckMsgList := TList.Create;
  //m_dwAttackCount := 0;
  //m_dwAttackCountA := 0;
  //m_dwMagicAttackCount := 0;
  //m_dwMoveCount := 0;
  //m_dwMoveCountA := 0;
  //m_nOverSpeedCount := 0;
  //TList55C := TList.Create;
  m_sOldSayMsg := '';
  m_dwSayMsgTick := GetTickCount();
  m_boDisableSayMsg := False;
  m_dwDisableSayMsgTick := GetTickCount();
  m_dLogonTime := Now();
  m_dwLogonTick := GetTickCount();
  m_dwDanderTick := GetTickCount + LongWord(Random(10 * 60 * 1000));
  m_dwDanderTime := GetTickCount;
  //n584 := 0;
  //n588 := 0;
  {m_boSwitchData := False;
  m_boSwitchDataSended := False;
  m_nWriteChgDataErrCount := 0;       }
  m_dwShowLineNoticeTick := GetTickCount();
  m_nShowLineNoticeIdx := 0;
  //m_nSoftVersionDateEx := 0;
  m_CanJmpScriptOldLableList := TStringList.Create;
  m_CanJmpScriptLableList := TStringList.Create;
  m_CanJmpScriptNewLableList := TStringList.Create;
  m_nKillMonExpLiterary := 100;
  m_nKillMonExpRate := 100;
  m_dwRateTick := GetTickCount();
  m_nPowerRate := 100;

  for I := Low(m_StorageItemList) to High(m_StorageItemList) do
    m_StorageItemList[i] := TList.Create;

  m_ReturnItemsList := TList.Create;

  SafeFillChar(m_AppendBagItems, SizeOf(m_AppendBagItems), #0);
  SafeFillChar(m_CboMagicListInfo, SizeOf(m_CboMagicListInfo), #0);
  m_nCboNowMagicID := -1;
  m_nCboNowHitCMD := -1;
  {m_boSetStoragePwd := False;
  m_boReConfigPwd := False;
  m_boCheckOldPwd := False;
  m_boUnLockPwd := False;
  m_boUnLockStoragePwd := False;
  m_boPasswordLocked := False; //锁仓库
  m_btPwdFailCount := 0;
  m_sTempPwd := '';
  m_sStoragePwd := '';
  ;       }
  m_boFilterSendMsg := False;
  SafeFillChar(m_NakedAbil, SizeOf(m_NakedAbil), #0);
  m_nNakedCount := 0;
  {m_boCanDeal := True;
  m_boCanDrop := True;
  //m_boCanGetBackItem := True;
  m_boCanWalk := True;
  m_boCanRun := True;
  m_boCanHit := True;
  m_boCanSpell := True;
  m_boCanUseItem := True;  }

  SafeFillChar(m_UserOptionSetup, SizeOf(m_UserOptionSetup), #0);
  SafeFillChar(m_UserItemsSetup, SizeOf(m_UserItemsSetup), #0);
  m_wItemsSetupCount := 0;

  m_nMemberType := 0;
  m_nMemberLevel := 0;

  m_nGameGold := 0;

  //m_boDecGameGold := False;
  //m_nDecGameGold := 1;
  m_dwDecGameGoldTick := GetTickCount();
  // m_dwDecGameGoldTime := 60 * 1000;

   //m_boIncGameGold := False;
   //m_nIncGameGold := 1;
  m_dwIncGameGoldTick := GetTickCount();
  //m_dwIncGameGoldTime := 60 * 1000;

  m_dwMagicHitTimeEX := 0;
  m_dwHitTime := GetTickCount;
  m_dwMagicHitTime := GetTickCount;
  m_dwRunTime := GetTickCount;
  m_dwWalkTime := GetTickCount;
  m_dwTurnTime := GetTickCount;
  m_dwButchTime := GetTickCount;

  m_boHitDelay := False;
  m_boMagicHitDelay := False;
  m_boRunDelay := False;
  m_boWalkDelay := False;
  m_boTurnDelay := False;
  m_boButchDelay := False;

  m_nHitCount := 0; //人物攻击容错数量
  m_nMagicHitCount := 0; //人物魔法攻击容错数量
  m_nRunCount := 0; //人物跑动容错数量
  m_nWalkCount := 0; //人物走动容错数量
  m_nTurnCount := 0; //人物转向容错数量
  m_nButchCount := 0; //人物挖取容错数量

  m_nGamePoint := 0;
  //m_dwIncGamePointTick := GetTickCount();

  m_nGameDiamond := 0;
  m_nGameGird := 0;

  //m_nPayMentPoint := 0;

  m_DearHuman := nil;
  //m_MasterHuman := nil;
  //m_MasterList := TList.Create;
  m_boSendMsgFlag := False;
  m_boChangeItemNameFlag := False;

  m_boCanMasterRecall := False;
  m_boCanDearRecall := False;
  m_dwDearRecallTick := GetTickCount();
  m_dwMasterRecallTick := GetTickCount();
  m_btReColorIdx := 0;
  m_GetWhisperHuman := nil;
  m_boOnHorse := False;
  m_boHorseHit := False;
  m_wContribution := 0;
  m_sRankLevelName := g_sRankLevelName;
  m_boFixedHideMode := True;
  //m_nStep := 0;
  SafeFillChar(m_nVal, SizeOf(m_nVal), #0);
  SafeFillChar(m_nMval, SizeOf(m_nMval), #0);
  //SafeFillChar(m_DyVal, SizeOf(m_DyVal), #0);

  m_nClientFlagMode := -1;
  m_dwAutoGetExpTick := GetTickCount;
  m_nAutoGetExpPoint := 0;
  m_AutoGetExpEnvir := nil;

  m_boCanCreateGroup := True;
  //m_dwHitIntervalTime := g_Config.dwHitIntervalTime; //攻击间隔
  //m_dwMagicHitIntervalTime := g_Config.dwMagicHitIntervalTime; //魔法间隔
  //m_dwRunIntervalTime := g_Config.dwRunIntervalTime; //走路间隔
  //m_dwWalkIntervalTime := g_Config.dwWalkIntervalTime; //走路间隔
  //m_dwTurnIntervalTime := g_Config.dwTurnIntervalTime; //换方向间隔
  //m_dwActionIntervalTime := g_Config.dwActionIntervalTime; //组合操作间隔
  //m_dwRunLongHitIntervalTime := g_Config.dwRunLongHitIntervalTime;
  //组合操作间隔
  //m_dwRunHitIntervalTime := g_Config.dwRunHitIntervalTime; //组合操作间隔
  //m_dwWalkHitIntervalTime := g_Config.dwWalkHitIntervalTime; //组合操作间隔
  //m_dwRunMagicIntervalTime := g_Config.dwRunMagicIntervalTime;
  //跑位魔法间隔
  m_DynamicVarList := TList.Create;
  //m_SessInfo := nil;
  m_boTestSpeedMode := False;
  //m_boLockLogon := True;
  //m_boLockLogoned := False;

  //m_boRemoteMsg := False; //是否允许接受消息

  m_boStartAutoAddExpPoint := False; //是否开始增加经验

  m_dwAutoAddExpPointTick := GetTickCount;
  m_dwAutoAddExpPointTimeTick := GetTickCount;

  //m_boKickAutoAddExpUser := False;
  {m_boTimeGoto := False;
  m_dwTimeGotoTick := GetTickCount;
  m_sTimeGotoLable := -1;
  m_TimeGotoNPC := nil;   }
  m_DelayGotoList := TList.Create;
  //m_nBigStoragePage := 0; //无限仓库的当前页数
  m_nDealGoldPose := 0;
  m_boPlayOffLine := True; //是否允许下线触发
  m_dwDedingUseTick := 0;
  //m_nCopyHumanLevel := 0;
  m_boAllowReAlive := False; //是否允许复活

  SafeFillChar(m_nInteger, SizeOf(m_nInteger), #0);
  SafeFillChar(m_MissionIndex, SizeOf(m_MissionIndex), 0);
  for I := Low(m_sString) to High(m_sString) do
    m_sString[I] := '';
  //SafeFillChar(m_dwUserTick, SizeOf(m_dwUserTick), #0);
  m_CustomDataList := TList.Create;

  SafeFillChar(m_IconInfo[0], SizeOf(TIconInfos), #0);
  m_HookItemEx := TList.Create;

  InitializeServerProcess();
{$IFDEF PLUGOPEN}
  try
    if Assigned(zPlugOfEngine.HookCreate) then begin
      zPlugOfEngine.HookCreate(Self);
    end;
  except
  end;
{$ENDIF}
end;

destructor TPlayObject.Destroy;
var
  i, ii: Integer;
  CheckMsg: pTCheckMsg;
begin
{$IFDEF PLUGOPEN}
  try
    if Assigned(zPlugOfEngine.HookDestroy) then begin
      zPlugOfEngine.HookDestroy(Self);
    end;
  except
  end;
{$ENDIF}
  if m_CheckMsgList <> nil then begin
    if m_CheckMsgList.Count > 0 then begin
      for i := 0 to m_CheckMsgList.Count - 1 do begin
        CheckMsg := m_CheckMsgList.Items[i];
        if CheckMsg <> nil then begin
          ClientCheckMsg(CheckMsg.tClass, CheckMsg.AllPurpose, -1);
          DisPose(CheckMsg);
        end;
      end;
    end;
    FreeAndNil(m_CheckMsgList);
  end;
  //if m_MasterList <> nil then
  FreeAndNil(m_MasterList);
  {for i := 0 to TList55C.Count - 1 do begin

  end;
  FreeAndNil(TList55C);  }
  if m_MagicList <> nil then begin
    if m_MagicList.Count > 0 then begin
      for i := 0 to m_MagicList.Count - 1 do begin
        if pTUserMagic(m_MagicList.Items[i]) <> nil then
          DisPose(pTUserMagic(m_MagicList.Items[i]));
      end;
    end;
    FreeAndNil(m_MagicList);
  end;
  if m_DealItemList <> nil then begin
    if m_DealItemList.Count > 0 then begin
      for i := 0 to m_DealItemList.Count - 1 do begin
        if pTUserItem(m_DealItemList.Items[i]) <> nil then
          DisPose(pTUserItem(m_DealItemList.Items[i]));
      end;
    end;
    FreeAndNil(m_DealItemList);
  end;

  if m_DelayGotoList <> nil then begin
    if m_DelayGotoList.Count > 0 then begin
      for I := 0 to m_DelayGotoList.Count - 1 do begin
        Dispose(pTNPCDelayGoto(m_DelayGotoList[I]));
      end;
    end;
    FreeAndNil(m_DelayGotoList);
  end;

  if m_ShopSellItemList <> nil then begin
    if m_ShopSellItemList.Count > 0 then begin
      for i := 0 to m_ShopSellItemList.Count - 1 do begin
        if pTUserShopSellItem(m_ShopSellItemList.Items[i]) <> nil then begin
          if pTUserShopSellItem(m_ShopSellItemList.Items[i]).UserItem <> nil then
            Dispose(pTUserShopSellItem(m_ShopSellItemList.Items[i]).UserItem);
          DisPose(pTUserShopSellItem(m_ShopSellItemList.Items[i]));
        end;
      end;
    end;
    FreeAndNil(m_ShopSellItemList);
  end;

  if m_CenterMsgList <> nil then begin
    if m_CenterMsgList.Count > 0 then begin
      for I := 0 to m_CenterMsgList.Count - 1 do begin
        DisPose(pTCenterMsg(m_CenterMsgList.Items[i]));
      end;
    end;
    FreeAndNil(m_CenterMsgList);
  end;

  if m_ShopBuyItemList <> nil then begin
    if m_ShopBuyItemList.Count > 0 then begin
      for i := 0 to m_ShopBuyItemList.Count - 1 do begin
        if pTUserShopBuyItem(m_ShopBuyItemList.Items[i]) <> nil then begin
          DisPose(pTUserShopBuyItem(m_ShopBuyItemList.Items[i]));
        end;
      end;
    end;
    FreeAndNil(m_ShopBuyItemList);
  end;

  for i := Low(m_StorageItemList) to High(m_StorageItemList) do begin
    for ii := 0 to m_StorageItemList[i].Count - 1 do
      Dispose(pTStorageItem(m_StorageItemList[i][ii]));
    FreeAndNil(m_StorageItemList[i]);
  end;

  for I := 0 to m_ReturnItemsList.Count - 1 do begin
    Dispose(pTUserItem(m_ReturnItemsList[i]));
  end;
  FreeAndNil(m_ReturnItemsList);

  if m_DynamicVarList <> nil then begin
    if m_DynamicVarList.Count > 0 then begin
      for i := 0 to m_DynamicVarList.Count - 1 do begin
        if pTDynamicVar(m_DynamicVarList.Items[i]) <> nil then
          DisPose(pTDynamicVar(m_DynamicVarList.Items[i]));
      end;
    end;
    FreeAndNil(m_DynamicVarList);
  end;
  if m_CanJmpScriptOldLableList <> nil then
    FreeAndNil(m_CanJmpScriptOldLableList);
  if m_CanJmpScriptNewLableList <> nil then
    FreeAndNil(m_CanJmpScriptNewLableList);
  if m_CanJmpScriptLableList <> nil then
    FreeAndNil(m_CanJmpScriptLableList);
  m_CustomDataList.Free;

  if m_FriendList <> nil then
    FreeAndNil(m_FriendList);

//  if m_PPhotoData <> nil then
//    FreeMem(m_PPhotoData);

  FreeAndNil(m_HookItemEx);
  inherited;
end;

procedure TPlayObject.InitializeServerProcess();
begin
  SafeFillChar(FServerProcess, SizeOf(FServerProcess), #0);
  FServerProcess[CM_QUERYUSERNAME] := ClientQueryUserName;
  FServerProcess[CM_QUERYBAGITEMS] := ClientQueryBagItems;
  FServerProcess[CM_QUERYUSERSTATE] := ClientQueryUserState;
  FServerProcess[CM_QUERYUSERSET] := ClientQueryUserSet;
  FServerProcess[CM_DROPITEM] := ClientDropItem;
  FServerProcess[CM_PICKUP] := ClientPickUpItem;
  FServerProcess[CM_OPENDOOR] := ClientOpenDoor;
  FServerProcess[CM_TAKEONITEM] := ClientTakeOnItems;
  FServerProcess[CM_TAKEOFFITEM] := ClientTakeOffItems;
  FServerProcess[CM_EAT] := ClientUseItems;
  FServerProcess[CM_USERKEYSETUP] := ClientChangeMagicKey;
  FServerProcess[CM_SOFTCLOSE] := ClientSoftClose;
  FServerProcess[CM_CLICKNPC] := ClientClickNPC;
  FServerProcess[CM_MERCHANTDLGSELECT] := ClientMerchantDlgSelect;
  FServerProcess[CM_ITEMSTRENGTHEN] := ClientItemStrengthen;
  FServerProcess[CM_USERSELLITEM] := ClientUserSellItem;
  FServerProcess[CM_USERBUYITEM] := ClientUserBuyItem;
  FServerProcess[CM_DROPGOLD] := ClientDropGold;
  FServerProcess[CM_GROUPMODE] := ClientGroupMode;
  FServerProcess[CM_CREATEGROUP] := ClientCreateGroup;
  FServerProcess[CM_ADDGROUPMEMBER] := ClientAddGroupMember;
  FServerProcess[CM_DELGROUPMEMBER] := ClientDelGroupMember;
  FServerProcess[CM_USERREPAIRITEM] := ClientRepairItem;
  FServerProcess[CM_DEALTRY] := ClientDealTry;
  FServerProcess[CM_DEALADDITEM] := ClientAddDealItem;
  FServerProcess[CM_DEALDELITEM] := ClientDelDealItem;
  FServerProcess[CM_DEALCANCEL] := ClientCancelDeal;
  FServerProcess[CM_DEALCHGGOLD] := ClientChangeDealGold;
  FServerProcess[CM_DEALEND] := ClientDealModeChange;
  FServerProcess[CM_USERSTORAGEITEM] := ClientStorageItem;
  FServerProcess[CM_USERTAKEBACKSTORAGEITEM] := ClientTakeBackStorageItem;
  FServerProcess[CM_USERMAKEDRUGITEM] := ClientMakeDrugItem;
  FServerProcess[CM_UNSEAL] := ClientUnsealItem;
  FServerProcess[CM_BAGUSEITEM] := ClientBagUseItem;
  FServerProcess[CM_OPENGUILDDLG] := ClientOpenGuildDlg;
  FServerProcess[CM_GUILDHOME] := ClientGuildHome;
  FServerProcess[CM_GUILDMEMBERLIST] := ClientGuildMemberList;
  FServerProcess[CM_GUILDADDMEMBER] := ClientGuildAddMember;
  FServerProcess[CM_GUILDDELMEMBER] := ClientGuildDelMember;
  FServerProcess[CM_GUILDUPDATENOTICE] := ClientGuildUpdateNotice;
  FServerProcess[CM_GUILDUPDATERANKINFO] := ClientGuildUpdateRankInfo;
  FServerProcess[CM_GUILDALLY] := ClientGuildAlly;
  FServerProcess[CM_GUILDBREAKALLY] := ClientGuildBreakAlly;
  FServerProcess[CM_TURN] := ClientTurn;
  FServerProcess[CM_WALK] := ClientWalk;
  FServerProcess[CM_HORSERUN] := ClientHorseRun;
  FServerProcess[CM_RUN] := ClientRun;
  FServerProcess[CM_LEAP] := ClientLeap;
  FServerProcess[CM_HIT] := ClientAttack;
  FServerProcess[CM_HEAVYHIT] := ClientAttack;
  FServerProcess[CM_BIGHIT] := ClientAttack;
  FServerProcess[CM_POWERHIT] := ClientAttack;
  FServerProcess[CM_LONGHIT] := ClientAttack;
  FServerProcess[CM_WIDEHIT] := ClientAttack;
  FServerProcess[CM_CRSHIT] := ClientAttack;
  FServerProcess[CM_TWNHIT] := ClientAttack;
  FServerProcess[CM_FIREHIT] := ClientAttack;
  FServerProcess[CM_TWINHIT] := ClientAttack;
  FServerProcess[CM_LONGICEHIT] := ClientAttack;
  FServerProcess[CM_110] := ClientAttack;
  FServerProcess[CM_111] := ClientAttack;
  FServerProcess[CM_112] := ClientAttack;
  FServerProcess[CM_113] := ClientAttack;
  FServerProcess[CM_122] := ClientAttack;
  FServerProcess[CM_56] := ClientAttack;
  FServerProcess[CM_SITDOWN] := ClientSitDown;
  FServerProcess[CM_SPELL] := ClientSpell;
  FServerProcess[CM_SAY] := ClientSay;
  FServerProcess[CM_UPDATESERVER] := ClientUpdate;
  FServerProcess[CM_CHECKMSG] := ClientGetCheckMsg;
  FServerProcess[CM_GETSAYITEM] := ClientGetSayItem;
  FServerProcess[CM_CHANGEITEMDURA] := ClientUniteItem;
  FServerProcess[CM_NAKEDABILITYCHANGE] := ClientNakedChange;
  FServerProcess[CM_APPEND] := ClientAppend;
  FServerProcess[CM_APPENDCLIENT] := ClientAppendClient;
  FServerProcess[CM_REALITYINFO] := ClientRealityInfoChange;
  FServerProcess[CM_TAKEONOFFADDBAG] := ClientTakeOnOffAddBag;
  FServerProcess[CM_GUILDGOLDCHANGE] := ClientGuildGoldChange;
  FServerProcess[CM_GUILDLEVELUP] := ClientGuildLevelUp;
  FServerProcess[CM_USERSHOPCHANGE] := ClientUserShop;
  FServerProcess[CM_MAPAPOISE] := ClientMapApoise;
  FServerProcess[CM_CLICKUSERSHOP] := ClientClickUserShop;
  FServerProcess[CM_USERSHOPSAY] := ClientUserShopSay;
  FServerProcess[CM_BUYUSERSHOP] := ClientBuyUserShop;
  FServerProcess[CM_GETBACKSTORAGE] := ClientGetBackStorage;
  FServerProcess[CM_GETBACKSTORAGEPASS] := ClientGetBackStoragePass;
  FServerProcess[CM_STORAGEGOLDCHANGE] := ClientStorageGoldChange;
  FServerProcess[CM_QUERYRETURNITEMS] := ClientQueryReturnItems;
  FServerProcess[CM_USERBUYRETURNITEM] := ClientUserBuyReturnItem;
  FServerProcess[CM_ALIVE] := ClientAlive;
  FServerProcess[CM_CBOMAGIC] := ClientCboMagic;
  FServerProcess[CM_SHOPGETGAMEPOINT] := ClientTradeGameGold;
  FServerProcess[CM_SHOPGETLIST] := ClientGetShopList;
  FServerProcess[CM_SHOPBUYITEMBACK] := ClientBuyShopItem;
  FServerProcess[CM_SAVEUSERPHOTO] := ClientUserPhoto;
  FServerProcess[CM_FRIEND_CHENGE] := ClientFriendChange;
  FServerProcess[CM_EMAIL] := ClientEMailInfo;
  FServerProcess[CM_GAMESETUPINFO] := ClientGameSetupInfo;
  FServerProcess[CM_GMUPDATESERVER] := ClientGMUpdateMsg;
  FServerProcess[CM_OPENBOX] := ClientOpenBox;
  FServerProcess[CM_CLICKBOX] := ClientClickBox;
  FServerProcess[CM_CLEARMISSION] := ClientClearMission;
  FServerProcess[CM_GUAGEBAR] := ClientGuageBar;
  FServerProcess[CM_MAKEMAGIC] := ClientMakeMagic;
  FServerProcess[CM_GETTOPINFO] := ClientGetTopInfo;
  FServerProcess[CM_MISSIONSTATECHANGE] := ClientMissionStateChange;
  FServerProcess[CM_REMOVESTONE] := ClientRemoveStone;
  FServerProcess[CM_SPEEDCLOSE] := ClientSpeedClose;
  FServerProcess[CM_CENTERMSG_CLICK] := ClientCenterMsgClick;
  FServerProcess[CM_SETMAGICKEY] := ClientSetMagicKey;
  FServerProcess[CM_ITEMABILITYMOVE] := ClientItemAbilityMove;
  FServerProcess[CM_COMPOUNDITEM] := ClientCompoundItem;


  FServerProcess[RM_SHOPGETGAMEPOINT] := ServerTradeGameGold;
  FServerProcess[RM_SHOPGAMEGOLDCHANGE] := ServerBuyShopItem;
  FServerProcess[RM_SHOPGETPOINT] := ServerChangeGameGold;
  FServerProcess[RM_WALK] := ServerWalk;
  FServerProcess[RM_HORSERUN] := ServerHorseRun;
  FServerProcess[RM_RUN] := ServerRun;
  FServerProcess[RM_LEAP] := ServerLeap;
  FServerProcess[RM_HIT] := ServerHit;
  FServerProcess[RM_SPELL] := ServerSpell;
  FServerProcess[RM_MOVEFAIL] := ServerMoveFail;
  FServerProcess[RM_TURN] := ServerTurn;
  FServerProcess[RM_PUSH] := ServerTurn;
  FServerProcess[RM_RUSH] := ServerTurn;
  FServerProcess[RM_RUSHCBO] := ServerTurn;
  FServerProcess[RM_MAGICMOVE] := ServerTurn;
  FServerProcess[RM_MAGICFIR] := ServerTurn;
  FServerProcess[RM_RUSHKUNG] := ServerTurn;
  FServerProcess[RM_STRUCK] := ServerStruck;
  FServerProcess[RM_STRUCK_MAG] := ServerStruck;
  FServerProcess[RM_DEATH] := ServerDeath;
  FServerProcess[RM_DISAPPEAR] := ServerDisappear;
  FServerProcess[RM_SKELETON] := ServerSkeleton;
  FServerProcess[RM_USERNAME] := ServerUserName;
  FServerProcess[RM_LEVELUP] := ServerLevelUp;
  FServerProcess[RM_CHANGENAMECOLOR] := ServerChangeNameColor;
  FServerProcess[RM_LOGON] := ServerLogon;
  FServerProcess[RM_HEAR] := ServerSay;
  FServerProcess[RM_CRY] := ServerSay;
  FServerProcess[RM_BUGLE] := ServerSay;
  FServerProcess[RM_SYSMESSAGE] := ServerSay;
  FServerProcess[RM_GROUPMESSAGE] := ServerSay;
  FServerProcess[RM_GUILDMESSAGE] := ServerSay;
  FServerProcess[RM_HEALTHSPELLCHANGED] := ServerHealthSpellChange;
  FServerProcess[RM_ITEMSHOW] := ServerItemShow;
  FServerProcess[RM_ITEMHIDE] := ServerItemHide;
  FServerProcess[RM_DOOROPEN] := ServerDoorOpen;
  FServerProcess[RM_DOORCLOSE] := ServerDoorClose;
  FServerProcess[RM_FEATURECHANGED] := ServerFeatureChanged;
  FServerProcess[RM_REFICONINFO] := ServerIconInfo;
  FServerProcess[RM_CHANGEMAP] := ServerChangeMap;
  FServerProcess[RM_BUTCH] := ServerButch;
  FServerProcess[RM_CREATENEWGUILD] := ServerCreateGuild;
  FServerProcess[RM_MAGICFIRE] := ServerMagicFire;
  FServerProcess[RM_MAGICFIREFAIL] := ServerMagicFireFail;
  FServerProcess[RM_GAMEGOLDCHANGED] := ServerGameGoldChange;
  FServerProcess[RM_CHARSTATUSCHANGED] := ServerCharStatusChanged;
  FServerProcess[RM_SENDDELITEMLIST] := ServerSendDelItemList;
  FServerProcess[RM_ALIVE] := ServerAlive;
  FServerProcess[RM_DIGUP] := ServerDigUp;
  FServerProcess[RM_DIGDOWN] := ServerDigDown;
  FServerProcess[RM_FLYAXE] := ServerFlyAxe;
  FServerProcess[RM_LIGHTING] := ServerLighting;
  FServerProcess[RM_10205] := Server10205;
  FServerProcess[RM_MONMAGIC] := ServerMonMagic;
  FServerProcess[RM_SPACEMOVE_FIRE] := ServerSpaceMoveFire;
  FServerProcess[RM_SPACEMOVE_FIRE2] := ServerSpaceMoveFire2;
  FServerProcess[RM_SPACEMOVE_FIRE3] := ServerSpaceMoveFire2;
  FServerProcess[RM_SPACEMOVE_SHOW] := ServerSpaceMoveShow;
  FServerProcess[RM_SPACEMOVE_SHOW2] := ServerSpaceMoveShow;
  FServerProcess[RM_SPACEMOVE_SHOW3] := ServerSpaceMoveShow;
  FServerProcess[RM_RECONNECTION] := ServerReConnection;
  FServerProcess[RM_OPENHEALTH] := ServerOpenHealth;
  FServerProcess[RM_CLOSEHEALTH] := ServerCloseHealth;
  FServerProcess[RM_BREAKWEAPON] := ServerBreakWeapon;
  FServerProcess[RM_CHANGEFACE] := ServerChangeFace;
  FServerProcess[RM_PLAYDICE] := ServerPlayDice;
  FServerProcess[RM_SHOWEFFECT] := ServerShowEffect;
  FServerProcess[RM_USEROPENSHOP] := ServerUserShop;
  FServerProcess[RM_OFFLINESHOP] := ServerOffLineShop;
  FServerProcess[RM_GETLARGESSGOLD] := ServerGetLargessGold;
  FServerProcess[RM_DEFMESSAGE] := ServerDefMessage;
  FServerProcess[RM_DEFSOCKET] := ServerDefSocket;

end;

function TPlayObject.Operate(ProcessMsg: pTProcessMessage): Boolean;
{$IFDEF PLUGOPEN}
var
  boReturn: Boolean;
{$ENDIF}
begin
  Result := True;
  if ProcessMsg = nil then begin
    Result := False;
    Exit;
  end;
{$IFDEF PLUGOPEN}
  boReturn := False;
{$ENDIF}
  if (ProcessMsg.wIdent > 0) and (ProcessMsg.wIdent < MAXCLIENTSERVERCOUNT) and
    (Assigned(FServerProcess[ProcessMsg.wIdent])) then begin
    FServerProcess[ProcessMsg.wIdent](ProcessMsg, Result);
  end
  else begin
{$IFDEF PLUGOPEN}
    if Assigned(zPlugOfEngine.HookPlayOperateMessage) then begin
      Result := zPlugOfEngine.HookPlayOperateMessage(Self,
        ProcessMsg.wIdent,
        ProcessMsg.wParam,
        ProcessMsg.nParam1,
        ProcessMsg.nParam2,
        ProcessMsg.nParam3,
        ProcessMsg.BaseObject,
        ProcessMsg.dwDeliveryTime,
        PChar(ProcessMsg.sMsg),
        boReturn);
      if boReturn then
        Result := inherited Operate(ProcessMsg);
    end
    else
{$ENDIF}
      Result := inherited Operate(ProcessMsg);
  end;
end;

procedure TPlayObject.SetUserTime(dwTime: LongWord);
begin
  dwTime := GetTickCount + dwTime;
  if m_dwHitTime < dwTime then
    m_dwHitTime := dwTime;
  if m_dwMagicHitTime < dwTime then
    m_dwMagicHitTime := dwTime;
  if m_dwRunTime < dwTime then
    m_dwRunTime := dwTime;
  if m_dwWalkTime < dwTime then
    m_dwWalkTime := dwTime;
  if m_dwTurnTime < dwTime then
    m_dwTurnTime := dwTime;
  if m_dwButchTime < dwTime then
    m_dwButchTime := dwTime;
end;

procedure TPlayObject.CheckUserItemTime(boLogon: Boolean);
const
  StorageStr: array[0..4] of string[2] = ('一', '二', '三', '四', '五');
resourcestring
  sDelItems = '删除复制品 [%s]%d %s';
  sDelStorage = '仓库%s已经到期！';
  sDelBagItem = '你的物品[%s]已经到期！';
var
  i, ii, k: integer;
  UserItem, UserItem1: pTUserItem;
  NowDateTime: TDateTime;
  NowLongWord: LongWord;
  StorageItem: pTStorageItem;
  StdItem: pTStdItem;
  boRef, boState: Boolean;
  boDelete: Boolean;
  dUserItem: TUserItem;
begin
  try
    NowDateTime := Now;
    NowLongWord := DateTimeToLongWord(NowDateTime);
    if boLogon then begin
      //检查背包中是否有复制品
      for I := m_ItemList.Count - 1 downto 0 do begin
        UserItem := m_ItemList.Items[I];
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem = nil then begin //检查背包中的物品是否合法
          AddGameLog(Self, LOG_DELITEM, IntToStr(UserItem.wIndex), UserItem.MakeIndex, UserItem.Dura, '0', '包裹', '0', '无效', UserItem);
          Dispose(UserItem); //Jason 0714
          m_ItemList.Delete(i);
          Continue;
        end;
        for ii := I - 1 downto 0 do begin
          UserItem1 := m_ItemList.Items[ii];
          if (UserItem1.wIndex = UserItem.wIndex) and (UserItem.MakeIndex = UserItem1.MakeIndex) then begin
            MainOutMessage(Format(sDelItems, [UserEngine.GetStdItemName(UserItem.wIndex), UserItem1.MakeIndex, m_sCharName]));
            if (StdItem.NeedIdentify = 1) then
              AddGameLog(Self, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, '0', '包裹', '0', '复制', UserItem);
            Dispose(UserItem); //Jason 0714
            m_ItemList.Delete(i);
            break;
          end;
        end;
      end;
    end;
    if boLogon or (GetTickCount > m_dwCheckUserItemTick) then begin
      //if boLogon then m_dwCheckUserItemTick := GetTickCount + 30 * 60 * 1000
      //else
      m_dwCheckUserItemTick := GetTickCount + LongWord(Random(5 * 60 * 1000));

      //检测到期仓库
      for i := 1 to 4 do begin
        if (m_dwStorageTime[i] > 0) and (NowDateTime >= m_dwStorageTime[i]) then begin
          m_dwStorageTime[i] := 0;
          m_boStorageOpen[i] := False;
          SysMsg(Format(sDelStorage, [StorageStr[i]]), c_Blue, t_Hint);
        end;
      end;

      //检测到期身上物品
      boRef := False;
      boState := False;
      for I := Low(m_UseItems) to High(m_UseItems) do begin
        boDelete := False;
        if m_UseItems[i].wIndex > 0 then begin
          StdItem := UserEngine.GetStdItem(m_UseItems[i].wIndex);
          if (StdItem <> nil) then begin
            if StdItem.StdMode = tm_House then begin
              if (m_UseItems[i].TermTime > 0) and (NowLongWord >= m_UseItems[i].TermTime) then begin
                boDelete := True;
              end else begin
                for k := Low(m_UseItems[i].HorseItems) to High(m_UseItems[i].HorseItems) do begin
                  if (m_UseItems[i].HorseItems[k].wIndex > 0) and (m_UseItems[i].HorseItems[k].TermTime > 0) and (NowLongWord >= m_UseItems[i].HorseItems[k].TermTime) then begin
                    StdItem := UserEngine.GetStdItem(m_UseItems[i].HorseItems[k].wIndex);
                    if StdItem <> nil then begin
                      dUserItem := HorseItemToUserItem(@m_UseItems[i].HorseItems[k], StdItem);
                      boRef := True;
                      if StdItem.NeedIdentify = 1 then
                        AddGameLog(Self, LOG_DELITEM, StdItem.Name, dUserItem.MakeIndex, dUserItem.Dura, IntToStr(m_UseItems[i].MakeIndex), '穿着', '马牌', '到期', @dUserItem);
                      SysMsg(Format(sDelBagItem, [StdItem.Name]), c_Blue, t_Hint);
                      if not boLogon then
                        SendUpdateItem(@m_UseItems[i]);
                      m_UseItems[i].HorseItems[k].wIndex := 0;
                    end;
                  end;
                end;
              end;
            end else
            if (m_UseItems[i].TermTime > 0) and (NowLongWord >= m_UseItems[i].TermTime) then begin
              boDelete := True;
            end;
            if boDelete then begin
              if (i = U_DRESS) or (i = U_WEAPON) or (i = U_HOUSE) then begin
                boState := True;
                if i = U_HOUSE then begin
                  ChangeHorseState(False);
                end;
              end;
              boRef := True;
              if StdItem.NeedIdentify = 1 then
                AddGameLog(Self, LOG_DELITEM, StdItem.Name, m_UseItems[i].MakeIndex, m_UseItems[i].Dura, '0', '穿着', '0', '到期', @m_UseItems[i]);
              SysMsg(Format(sDelBagItem, [StdItem.Name]), c_Blue, t_Hint);
              if not boLogon then
                SendDelItems(@m_UseItems[i]);
              m_UseItems[i].wIndex := 0;
            end;
          end;
        end;
      end;
      if boRef and not boLogon then begin
        RecalcAbilitys();
        SendAbility;
        SendSubAbility;
        if boState then
          FeatureChanged();
      end;

      //检测额外包裹
      boRef := False;
      for I := Low(m_AppendBagItems) to High(m_AppendBagItems) do begin
        if (m_AppendBagItems[i].wIndex > 0) and (m_AppendBagItems[i].TermTime > 0) and (NowLongWord >= m_AppendBagItems[i].TermTime) then begin
          StdItem := UserEngine.GetStdItem(m_AppendBagItems[i].wIndex);
          if (StdItem <> nil) then begin
            if StdItem.NeedIdentify = 1 then
              AddGameLog(Self, LOG_DELITEM, StdItem.Name, m_AppendBagItems[i].MakeIndex, m_AppendBagItems[i].Dura, '0', '额外包裹', '0', '到期', @m_AppendBagItems[i]);
            SysMsg(Format(sDelBagItem, [StdItem.Name]), c_Blue, t_Hint);
          end;
          if not boLogon then
            SendDelItems(@m_AppendBagItems[i]);
          m_AppendBagItems[i].wIndex := 0;
          boRef := True;
        end;
      end;
      if boRef and not boLogon then begin
        RecalcBagCount;
      end;

      //检测到期包裹物品
      for I := m_ItemList.Count - 1 downto 0 do begin
        UserItem := m_ItemList[i];
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        boDelete := False;
        if (StdItem <> nil) then begin
          if StdItem.StdMode = tm_House then begin
            if (UserItem.TermTime > 0) and (NowLongWord >= UserItem.TermTime) then begin
              boDelete := True;
            end else begin
              for k := Low(UserItem.HorseItems) to High(UserItem.HorseItems) do begin
                if (UserItem.HorseItems[k].wIndex > 0) and (UserItem.HorseItems[k].TermTime > 0) and (NowLongWord >= UserItem.HorseItems[k].TermTime) then begin
                  StdItem := UserEngine.GetStdItem(UserItem.HorseItems[k].wIndex);
                  if StdItem <> nil then begin
                    dUserItem := HorseItemToUserItem(@UserItem.HorseItems[k], StdItem);
                    if StdItem.NeedIdentify = 1 then
                      AddGameLog(Self, LOG_DELITEM, StdItem.Name, dUserItem.MakeIndex, dUserItem.Dura, IntToStr(UserItem.MakeIndex), '包裹', '马牌', '到期', @dUserItem);
                    SysMsg(Format(sDelBagItem, [StdItem.Name]), c_Blue, t_Hint);
                    if not boLogon then
                      SendUpdateItem(UserItem);
                  end;
                  UserItem.HorseItems[k].wIndex := 0;
                end;
              end;
            end;
          end else
          if (UserItem.TermTime > 0) and (NowLongWord >= UserItem.TermTime) then begin
            boDelete := True;
          end;
          if boDelete then begin
            if StdItem.NeedIdentify = 1 then
              AddGameLog(Self, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, '0', '包裹', '0', '到期', UserItem);
            SysMsg(Format(sDelBagItem, [StdItem.Name]), c_Blue, t_Hint);
            if not boLogon then
              SendDelItems(UserItem);
            Dispose(UserItem);
            m_ItemList.Delete(I);
          end;
        end;
      end;

      //检测到期仓库物品
      for ii := Low(m_StorageItemList) to High(m_StorageItemList) do begin
        for I := m_StorageItemList[ii].Count - 1 downto 0 do begin
          StorageItem := m_StorageItemList[ii][i];
          boDelete := False;
          StdItem := UserEngine.GetStdItem(StorageItem.UserItem.wIndex);
          if StdItem <> nil then begin
            if StdItem.StdMode = tm_House then begin
              if (StorageItem.UserItem.TermTime > 0) and (NowLongWord >= StorageItem.UserItem.TermTime) then begin
                boDelete := True;
              end else begin
                for k := Low(StorageItem.UserItem.HorseItems) to High(StorageItem.UserItem.HorseItems) do begin
                  if (StorageItem.UserItem.HorseItems[k].wIndex > 0) and (StorageItem.UserItem.HorseItems[k].TermTime > 0) and (NowLongWord >= StorageItem.UserItem.HorseItems[k].TermTime) then begin
                    StdItem := UserEngine.GetStdItem(StorageItem.UserItem.HorseItems[k].wIndex);
                    if StdItem <> nil then begin
                      dUserItem := HorseItemToUserItem(@StorageItem.UserItem.HorseItems[k], StdItem);
                      if StdItem.NeedIdentify = 1 then
                        AddGameLog(Self, LOG_DELITEM, StdItem.Name, dUserItem.MakeIndex, dUserItem.Dura, IntToStr(StorageItem.UserItem.MakeIndex), '仓库', '马牌', '到期', @dUserItem);
                      SysMsg(Format(sDelBagItem, [StdItem.Name]), c_Blue, t_Hint);
                      if not boLogon then
                        SendUpdateItem(@StorageItem.UserItem);
                    end;
                    StorageItem.UserItem.HorseItems[k].wIndex := 0;
                  end;
                end;
              end;
            end else
            if (StorageItem.UserItem.TermTime > 0) and (NowLongWord >= StorageItem.UserItem.TermTime) then begin
              boDelete := True;
            end;
            if boDelete then begin
              if StdItem.NeedIdentify = 1 then
                AddGameLog(Self, LOG_DELITEM, StdItem.Name, StorageItem.UserItem.MakeIndex, StorageItem.UserItem.Dura, '0', '仓库', IntToStr(II), '到期', @StorageItem.UserItem);
              SysMsg(Format(sDelBagItem, [StdItem.Name]), c_Blue, t_Hint);
              if not boLogon then
                SendDelItems(@StorageItem.UserItem);
              Dispose(StorageItem);
              m_StorageItemList[ii].Delete(I);
            end;
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(E.Message);
      MainOutMessage('[Exception] TPlayObject.CheckUserItemTime ' + BoolToStr(boLogon));
    end;
  end;
end;

procedure TPlayObject.ClearDare(nState: Integer);
begin
  if (m_DareObject <> nil) and (m_DareNpc <> nil) then begin
    case nState of
      1: begin
          TNormNpc(m_DareNpc).GotoLable(Self, TNormNpc(m_DareNpc).GetScriptIndex('~DareDraw'), False);
          TNormNpc(m_DareNpc).GotoLable(m_DareObject, TNormNpc(m_DareNpc).GetScriptIndex('~DareDraw'), False);
          TNormNpc(m_DareNpc).GotoLable(SystemObject, TNormNpc(m_DareNpc).GetScriptIndex('~System_DareDraw'), False);
          m_AttackState := as_Close;
          m_DareObject.m_AttackState := as_Close;
          m_DareObject.m_DareObject := nil;
          m_DareObject := nil;
        end;
      2: begin
          if m_DareState = ds_InProgress then begin
            TNormNpc(m_DareNpc).GotoLable(Self, TNormNpc(m_DareNpc).GetScriptIndex('~DareLost'), False);
            TNormNpc(m_DareNpc).GotoLable(m_DareObject, TNormNpc(m_DareNpc).GetScriptIndex('~DareWin'), False);
            if m_BoDareMaster then begin
              TNormNpc(m_DareNpc).GotoLable(SystemObject, TNormNpc(m_DareNpc).GetScriptIndex('~System_Dare2Win'), False);
            end else begin
              TNormNpc(m_DareNpc).GotoLable(SystemObject, TNormNpc(m_DareNpc).GetScriptIndex('~System_Dare1Win'), False);
            end;
            m_AttackState := as_Close;
            m_DareObject.m_AttackState := as_Close;
            m_DareObject.m_DareObject := nil;
            m_DareObject := nil;
          end;
        end;
      3: begin
          if m_DareState = ds_Ready then begin
            TNormNpc(m_DareNpc).GotoLable(m_DareObject, TNormNpc(m_DareNpc).GetScriptIndex('~DareInvalid'), False);
            TNormNpc(m_DareNpc).GotoLable(SystemObject, TNormNpc(m_DareNpc).GetScriptIndex('~System_DareInvalid'), False);
          end else
          if m_DareState = ds_InProgress then begin
            TNormNpc(m_DareNpc).GotoLable(m_DareObject, TNormNpc(m_DareNpc).GetScriptIndex('~DareWin'), False);
            if m_BoDareMaster then begin
              TNormNpc(m_DareNpc).GotoLable(SystemObject, TNormNpc(m_DareNpc).GetScriptIndex('~System_Dare2Win'), False);
            end else begin
              TNormNpc(m_DareNpc).GotoLable(SystemObject, TNormNpc(m_DareNpc).GetScriptIndex('~System_Dare1Win'), False);
            end;
            m_AttackState := as_Close;
            m_DareObject.m_AttackState := as_Close;
          end;
          m_DareObject.m_DareObject := nil;
          m_DareObject := nil;
        end;
      4: begin
          if m_DareState = ds_InProgress then begin
            TNormNpc(m_DareNpc).GotoLable(Self, TNormNpc(m_DareNpc).GetScriptIndex('~DareLost'), False);
            TNormNpc(m_DareNpc).GotoLable(m_DareObject, TNormNpc(m_DareNpc).GetScriptIndex('~DareWin'), False);
            if m_BoDareMaster then begin
              TNormNpc(m_DareNpc).GotoLable(SystemObject, TNormNpc(m_DareNpc).GetScriptIndex('~System_Dare2Win'), False);
            end else begin
              TNormNpc(m_DareNpc).GotoLable(SystemObject, TNormNpc(m_DareNpc).GetScriptIndex('~System_Dare1Win'), False);
            end;
            m_AttackState := as_Close;
            m_DareObject.m_AttackState := as_Close;
            m_DareObject.m_DareObject := nil;
            m_DareObject := nil;
          end;
        end;
    end;
  end;
end;

procedure TPlayObject.Run();
var
  tObjCount: Integer;
  ProcessMsg: TProcessMessage;
  boInSafeArea: Boolean;
  i: Integer;
  PlayObject: TPlayObject;
  PushedObject: TPlayObject;
  Castle: TUserCastle;
  PlayObjectList: TList;
  CheckMsg: pTCheckMsg;
  dwStationTick: LongWord;
  nCheck: Integer;
  nOldPullulation: Integer;
  SendMessage: pTSendMessage;
  NPCDelayGoto: pTNPCDelayGoto;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  boTakeOff: Boolean;
  CenterMsg: pTCenterMsg;
resourcestring
  sExceptionMsg1 = '[Exception] TPlayObject::Run -> Operate 1 Code=%d';
  sExceptionMsg2 =
    '[Exception] TPlayObject::Run -> Operate 2 # %s Ident:%d Sender:%d wP:%d nP1:%d nP2:%d np3:%d Msg:%s Check:%d';
  sExceptionMsg3 = '[Exception] TPlayObject::Run -> GetHighHuman';
  sExceptionMsg4 = '[Exception] TPlayObject::Run -> ClearObj';
begin {
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
        m_MsgList.Delete(i);}
  if not (m_boMapApoise or m_boEmergencyClose or m_boKickFlag or m_boSoftClose) then begin
    if ((GetTickCount - m_dwMapApoiseTick) > 120 * 1000) then begin
      m_boEmergencyClose := True;
    end
    else begin
      ProcessMsg.wIdent := 0;
      EnterCriticalSection(ProcessMsgCriticalSection);
      try
        for I := m_MsgList.Count - 1 downto 0 do begin
          SendMessage := m_MsgList[i];
          if SendMessage.wIdent = CM_MAPAPOISE then begin
            m_MsgList.Delete(i);
            ProcessMsg.wIdent := SendMessage.wIdent;
            ProcessMsg.wParam := SendMessage.wParam;
            ProcessMsg.nParam1 := SendMessage.nParam1;
            ProcessMsg.nParam2 := SendMessage.nParam2;
            ProcessMsg.nParam3 := SendMessage.nParam3;
            ProcessMsg.BaseObject := SendMessage.BaseObject;
            ProcessMsg.dwDeliveryTime := SendMessage.dwDeliveryTime;
            ProcessMsg.boLateDelivery := SendMessage.boLateDelivery;
            if SendMessage.Buff <> nil then begin
              ProcessMsg.sMsg := StrPas(SendMessage.Buff);
              FreeMem(SendMessage.Buff);
            end
            else begin
              ProcessMsg.sMsg := '';
            end;
            DisPose(SendMessage);
            break;
          end;
        end;
      finally
        LeaveCriticalSection(ProcessMsgCriticalSection);
      end;
      if ProcessMsg.wIdent <> 0 then
        Operate(@ProcessMsg);
      exit;
    end;
  end;
  //m_dwDeathTick := GetTickCount;
  if g_boExitServer then begin
    m_boEmergencyClose := True;
    m_boPlayOffLine := False;
    m_boStartAutoAddExpPoint := False;
  end;
  //SafeFillChar(m_DyVal, SizeOf(m_DyVal), #0);
  try

    if m_boClickOpenBox then begin
      if (m_ClickBoxObject = nil) or (m_ClickBoxObject.m_boGhost) or (m_ClickBoxObject.m_boDeath) then begin
        if m_ClickBoxObject <> nil then
          SysMsg('您下手太慢了，已经被别人捷足先登啦！', c_Red, t_Hint);
        m_boClickOpenBox := False;
        m_ClickBoxObject := nil;
        SendDefMessage(SM_CLOSEBAR, 0, 0, 0, 0, '');
      end;
    end;
    if (m_CheckObject <> nil) and m_CheckObject.m_boGhost then begin
      m_CheckObject := nil;
      if m_boCheckObject then
        SendDefMessage(SM_APPENDOBJECTCLOSE, 0, 0, 0, 0, '');
    end;

    if m_boClickOpenGuage then begin
      if (m_ClickGuageNPC = nil) then begin
        m_boClickOpenGuage := False;
        SendDefMessage(SM_CLOSEBAR, 0, 0, 0, 0, '');
      end; { else
      if GetTickCount > m_dwClickOpenGuageTime then begin
        m_boClickOpenGuage := False;
        TNormNpc(m_ClickGuageNPC).GotoLable(Self,
          TNormNpc(m_ClickGuageNPC).GetScriptIndex(m_ClickGuageNPCLabel), False);
        m_ClickGuageNPCLabel := '';
        m_ClickGuageNPC := nil;
      end;    }
    end
    else
      m_ClickGuageNPC := nil;

    if (not m_boIncCount) and (m_nCheckEatCount >= 2) and (m_nCheckChangeMapCount >= 2) and (m_nCheckNpcCount >= 2) then begin
      m_boIncCount := True;
      Inc(g_Config.nCheckCount);
    end;
    if m_boDealing then begin
      if (m_DealCreat = Self) or (m_DealCreat = nil) or (m_DealCreat.m_boGhost) or (m_DealCreat.m_boDeath) or
        (abs(m_nCurrX - m_DealCreat.m_nCurrX) > g_Config.nSendRefMsgRange) or
        (abs(m_nCurrY - m_DealCreat.m_nCurrY) > g_Config.nSendRefMsgRange) then
        DealCancel();
    end;
{$IFDEF PLUGOPEN}
    if Assigned(zPlugOfEngine.HookRun) then begin
      zPlugOfEngine.HookRun(Self);
    end;
{$ENDIF}
    if m_boFireHitSkill and ((GetTickCount - m_dwLatestFireHitTick) > 10 * 1000) then begin
      m_boFireHitSkill := False;
      SendSocket(nil, '+UFIR');
    end;
    if m_bo56HitSkill and ((GetTickCount - m_dwLatest56HitTick) > 10 * 1000) then begin
      m_bo56HitSkill := False;
      SendSocket(nil, '+US56');
    end;
    if m_boLongIceHit and ((GetTickCount - m_dwLongIceHitTick) > 10 * 1000) then begin
      m_boLongIceHit := False;
      SendSocket(nil, '+UICE');
    end;

    if m_bo110HitSkill and ((GetTickCount - m_dwLatest110HitTick) > 10 * 1000) then begin
      m_bo110HitSkill := False;
      SendSocket(nil, '+US110');
      if m_nCboNowHitCMD = CM_110 then
        m_nCboNowHitCMD := -1;
    end;
    if m_bo112HitSkill and ((GetTickCount - m_dwLatest112HitTick) > 10 * 1000) then begin
      m_bo112HitSkill := False;
      SendSocket(nil, '+US112');
      if m_nCboNowHitCMD = CM_112 then
        m_nCboNowHitCMD := -1;
    end;
    if m_bo113HitSkill and ((GetTickCount - m_dwLatest113HitTick) > 10 * 1000) then begin
      m_bo113HitSkill := False;
      SendSocket(nil, '+US113');
      if m_nCboNowHitCMD = CM_113 then
        m_nCboNowHitCMD := -1;
    end;
    if m_bo122HitSkill and ((GetTickCount - m_dwLatest122HitTick) > 10 * 1000) then begin
      m_bo122HitSkill := False;
      SendSocket(nil, '+US122');
    end;

    if m_boTimeRecall and (GetTickCount > m_dwTimeRecallTick) then begin //执行 TimeRecall回到原地
      m_boTimeRecall := False;
      SpaceMove(m_MoveEnvir, m_nMoveX, m_nMoveY, 0);
    end;

    if m_DelayGotoList.Count > 0 then begin
      for I := m_DelayGotoList.Count - 1 downto 0 do begin
        NPCDelayGoto := m_DelayGotoList[I];
        if (GetTickCount > NPCDelayGoto.dwTimeGotoTick) then begin
          m_DelayGotoList.Delete(I);
          NPCDelayGoto.GotoNPC.GotoLable(Self, NPCDelayGoto.nGotoLable, False, NPCDelayGoto.sParam);
          Dispose(NPCDelayGoto);
          break;
        end;
      end;
    end;
    {if m_boTimeGoto and (GetTickCount > m_dwTimeGotoTick) then begin //执行 Delaygoto延时跳转
      m_boTimeGoto := False;
      if m_TimeGotoNPC <> nil then
        NpcGotoLable(TBaseObject(m_TimeGotoNPC), m_sTimeGotoLable, False);
    end;  }

    if m_FBEnvir <> nil then begin
      if (m_FBEnvir.m_MasterObject <> Self) or (not m_FBEnvir.m_boFBCreate) then
        m_FBEnvir := nil;
    end;
    if m_PEnvir.m_boFB then begin
      if m_boFBSendExitTime and (GetTickCount > m_dwFBExitTick) then begin
        m_boFBSendExitTime := False;
        if m_PEnvir.NoReconnectEnvir <> nil then begin
          if (m_PEnvir.m_nReConnectX > 0) and (m_PEnvir.m_nReConnectY > 0) then
            SpaceMove(m_PEnvir.NoReconnectEnvir, m_PEnvir.m_nReConnectX, m_PEnvir.m_nReConnectY, 2)
          else
            MapRandomMove(m_PEnvir.NoReconnectEnvir, 0);
        end
        else begin
          BaseObjectMove(m_sHomeMap, IntToStr(m_nHomeX), IntToStr(m_nHomeY));
        end;
      end
      else begin
        if not m_boFBSendTime then begin
          m_boFBSendTime := True;
          SendDefMessage(SM_FBTIME, Integer(m_PEnvir.m_dwFBTime - GetTickCount), 0, 0, 1, '');
        end;
        if (m_FBEnvir = m_PEnvir) or ((m_GroupOwner <> nil) and (TPlayObject(m_GroupOwner).m_FBEnvir = m_PEnvir)) then begin
          if (GetTickCount > m_PEnvir.m_dwFBTime) or (not m_PEnvir.m_boFBCreate) then begin
            m_PEnvir.m_MasterObject := nil;
            m_PEnvir.m_boFBCreate := False;
            if not m_boFBSendExitTime then begin
              m_boFBSendExitTime := True;
              m_dwFBExitTick := GetTickCount + 30 * 1000;
              SendDefMessage(SM_FBTIME, 30 * 1000, 0, 0, 2, '');
            end;
          end
          else begin
            if m_boFBSendExitTime then begin
              m_boFBSendExitTime := False;
              SendDefMessage(SM_FBTIME, 0, 0, 0, 2, '');
            end;
            if m_PEnvir.m_boFBFail then begin
              if not m_boFBSendFailTime then begin
                m_boFBSendFailTime := True;
                SendDefMessage(SM_FBTIME, Integer(m_PEnvir.m_dwFBFailTime - GetTickCount), 0, 0, 3, '');
              end;
            end
            else begin
              if m_boFBSendFailTime then begin
                m_boFBSendFailTime := False;
                SendDefMessage(SM_FBTIME, 0, 0, 0, 3, '');
              end;
            end;
          end;
        end
        else begin
          if not m_boFBSendExitTime then begin
            m_boFBSendExitTime := True;
            m_dwFBExitTick := GetTickCount + 30 * 1000;
            SendDefMessage(SM_FBTIME, 30 * 1000, 0, 0, 2, '');
          end;
        end;
      end;
    end
    else begin
      if m_boFBSendExitTime then begin
        m_boFBSendExitTime := False;
        SendDefMessage(SM_FBTIME, 0, 0, 0, 2, '');
      end;
      if m_boFBSendTime then begin
        m_boFBSendTime := False;
        SendDefMessage(SM_FBTIME, 0, 0, 0, 1, '');
      end;
      if m_boFBSendFailTime then begin
        m_boFBSendFailTime := False;
        SendDefMessage(SM_FBTIME, 0, 0, 0, 3, '');
      end;
    end;

    if (GetTickCount - m_dwCheckDupObjTick) > 3000 then begin
      m_dwCheckDupObjTick := GetTickCount();

      if (m_ClickNPC <> nil) and (m_ClickNPC.m_boGhost) then
        m_ClickNPC := nil;
      if (m_ClickHideNPC <> nil) and m_ClickHideNPC.m_boGhost then
        m_ClickHideNPC := nil;

      GetStartPoint(); //取回城坐标
      if not InSafeZone then begin //在安全区不推开重叠人物
        tObjCount := m_PEnvir.GetXYObjCount(m_nCurrX, m_nCurrY);
        if tObjCount >= 2 then begin
          if not bo2F0 then begin
            bo2F0 := True;
            m_dwDupObjTick := GetTickCount();
          end;
        end
        else begin
          bo2F0 := False;
        end;
        if (((tObjCount >= 3) and ((GetTickCount() - m_dwDupObjTick) > 3000))
          or (((tObjCount = 2) and ((GetTickCount() - m_dwDupObjTick) > 10000))))
          and ((GetTickCount() - m_dwDupObjTick) < 20000) then begin
          PushedObject := nil;
          dwStationTick := GetTickCount();
          PlayObjectList := TList.Create;
          m_PEnvir.GeTBaseObjects(m_nCurrX, m_nCurrY, False, PlayObjectList);
          for i := 0 to PlayObjectList.Count - 1 do begin
            PlayObject := TPlayObject(PlayObjectList.Items[i]);
            if (GetTickCount() - PlayObject.m_dwStationTick) < dwStationTick then begin
              PushedObject := PlayObject;
              dwStationTick := GetTickCount() - PlayObject.m_dwStationTick;
            end;
          end;
          if PushedObject <> nil then begin
            PushedObject.CharPushed(Random(8), 1);
          end;
          PlayObjectList.Free;
          {推开重叠人物}
        end;
      end;
{$IF Public_Ver = Public_Release}
      try
        if (g_ADNoticeList.Count > 0) and (not m_boSafeOffLine) then begin
          if m_ADListIndex >= g_ADNoticeList.Count then
            m_ADListIndex := 0;
          if (GetTickCount - m_ADTick) > LongWord(g_ADNoticeList.Objects[m_ADListIndex]) then begin
            SysMsg(g_ADNoticeList[m_ADListIndex], c_Red, t_System);
            m_ADTick := GetTickCount;
            Inc(m_ADListIndex);
          end;
        end;
      except
      end;
{$IFEND}
      {m_ADListIndex := 0;
      m_ADTick := GetTickCount; }
    end;

    if (GetTickCount - dwTick578) > 1000 then begin
      dwTick578 := GetTickCount();

      if (m_OldHP <> m_WAbil.MaxHP) and (m_GroupOwner = nil) then begin
        m_WAbil.MaxHP := m_OldHP;
        HealthSpellChanged;
      end;

      if g_boDayChange then begin
        if not m_boDayChange then begin
          m_boDayChange := True;
          m_boAddStabilityPoint := False;
          SafeFillChar(m_MissionArithmometer, SizeOf(m_MissionArithmometer), 0);
          SendMissionInfoArithmometer(True);
        end;
      end
      else
        m_boDayChange := False;

      Castle := g_CastleManager.InCastleWarArea(Self);
      if (Castle <> nil) and Castle.m_boUnderWar then begin
        ChangePKStatus(True);
      end
      else begin
        ChangePKStatus(False);
      end;
      if (m_MyGuild <> nil) then begin
        if not m_boAddStabilityPoint then begin
          m_boAddStabilityPoint := True;
          TGuild(m_MyGuild).IncStabilityPoint(1); //每天增加1点安定值
        end;
        if (dwTick578 > m_dwGuildTick) then begin
          m_dwGuildTick := dwTick578 + 60 * 60 * 1000;
          TGuild(m_MyGuild).IncActivityPoint(10); //人物每个小时给行会增加10点人气值
        end;
        if TGuild(m_MyGuild).m_GuildWarList.Count > 0 then begin
          boInSafeArea := InSafeArea();
          if boInSafeArea <> m_boInSafeArea then begin
            m_boInSafeArea := boInSafeArea;
            RefNameColor();
          end;
        end;
      end;

      {if (Castle = nil) or ((Castle <> nil) and (not Castle.m_boUnderWar)) then begin
        ChangePKStatus(False);
      end; }
      if m_boNameColorChanged then begin
        m_boNameColorChanged := False;
        RefUserState();
        RefShowName();
      end;

      if m_CheckMsgList.Count > 0 then begin
        for i := m_CheckMsgList.Count - 1 downto 0 do begin
          CheckMsg := m_CheckMsgList.Items[i];
          if (CheckMsg <> nil) and (GetTickCount > CheckMsg.AddTime) then begin
            ClientCheckMsg(CheckMsg.tClass, CheckMsg.AllPurpose, -1);
            DisPose(CheckMsg);
            m_CheckMsgList.Delete(i);
          end;
        end;
      end;

      if (m_nPullulation < MAXPULLULATION) and ((GetTickCount - m_dwDanderTime) > 60 * 1000) then begin
        m_dwDanderTime := GetTickCount;
        I := m_nPullulation div MIDPULLULATION;
        m_nPullulation := _MIN(m_nPullulation + g_Config.nPullulationCount, MAXPULLULATION);
        if (m_nPullulation div MIDPULLULATION) <> I then
          GameGoldChanged;
      end;
      if (GetTickCount - m_dwDanderTick) > 10 * 60 * 1000 then begin
        m_dwDanderTick := GetTickCount;
      end;

      CheckUserItemTime(False); //检测过期装备
      if GetTickCount > m_dwMissionTime then begin
        m_dwMissionTime := GetTickCount + 60 * 1000;
        for I := Low(m_MissionInfo) to High(m_MissionInfo) do begin
          if (m_MissionInfo[I].sMissionName <> '') and (m_MissionInfo[I].wTime > 0) then begin
            if m_MissionInfo[I].wTime > 1 then begin
              Dec(m_MissionInfo[I].wTime, 1);
            end
            else begin
              if g_FunctionNPC <> nil then
                NpcGotoLable(g_FunctionNPC, g_FunctionNPC.GetScriptIndex('@MISSION_' + m_MissionInfo[I].sMissionName), False);
              if m_MissionInfo[I].sMissionName <> '' then begin
                m_MissionInfo[I].sMissionName := '';
                SendDefMsg(Self, SM_MISSIONINFO, I, 0, 0, MISSTAG_DELMISSION, '');
              end;

            end;
          end;
        end;
      end;
      boTakeOff := False;
      for I := Low(m_UseItems) to High(m_UseItems) do begin
        UserItem := @m_UseItems[I];
        if (UserItem.MakeIndex > 0) and (UserItem.wIndex > 0) then begin
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if (StdItem <> nil) and (StdItem.Need in [20, 6, 60, 7, 70, 8, 81, 82]) then begin
            if not CheckTakeOnItems(I, StdItem, UserItem) then begin
              New(UserItem);
              UserItem^ := m_UseItems[I];
              m_UseItems[I].wIndex := 0;
              SendDelItems(UserItem);
              SendAddItem(UserItem);
              m_ItemList.Add(UserItem);
              boTakeOff := True;
            end;
          end;
        end;
      end;
      if boTakeOff then begin
        RecalcAbilitys();
        SendAbility;
        SendSubAbility;
        FeatureChanged();
      end;
    end;
    if (GetTickCount - dwTick57C) > 500 then
      dwTick57C := GetTickCount;


    if (m_DareObject <> nil) and (m_DareNpc <> nil) then begin
      if m_DareState = ds_Ready then begin
        if GetTickCount > m_DareTick then begin
          m_DareState := ds_None;
          m_DareObject.m_DareState := ds_None;
          if m_BoDareMaster then begin
            TNormNpc(m_DareNpc).GotoLable(m_DareObject, TNormNpc(m_DareNpc).GetScriptIndex('~DareStart2'), False);
            TNormNpc(m_DareNpc).GotoLable(Self, TNormNpc(m_DareNpc).GetScriptIndex('~DareStart1'), False);
          end
          else begin
            TNormNpc(m_DareNpc).GotoLable(Self, TNormNpc(m_DareNpc).GetScriptIndex('~DareStart2'), False);
            TNormNpc(m_DareNpc).GotoLable(m_DareObject, TNormNpc(m_DareNpc).GetScriptIndex('~DareStart1'), False);
          end;
        end;
      end else
      if m_DareState = ds_InProgress then begin
        if GetTickCount > m_DareTick then begin
          m_DareState := ds_None;
          ClearDare(1);
        end;
      end;
    end;
  except
    MainOutMessage(format(sExceptionMsg1, [0]));
  end;
  nCheck := -1;
  try
    m_dwGetMsgTick := GetTickCount();
    while (GetTickCount - m_dwGetMsgTick < g_Config.dwHumanGetMsgTime) and GetMessage(@ProcessMsg) do begin
      if not Operate(@ProcessMsg) then
        break;
    end;
    //客户端准备地图超时,踢下线
    nCheck := -2;

    nCheck := -3;
    if m_boEmergencyClose or m_boKickFlag or m_boSoftClose then begin
      if (not m_boPlayOffLine) and (not g_boExitServer) and (not m_boReconnection) then begin
        if g_FunctionNPC <> nil then begin
          NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[nPlayOffLine], False);
          //人物下线触发
        end;
      end;
      nCheck := -4;
      if (not m_boPlayOffLine) and (not g_boExitServer) and (m_boReconnection) then begin
        if g_FunctionNPC <> nil then begin
          NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[nPlayReconnection], False);
          //人物小退触发
        end;
      end;
      nCheck := -5;
      MakeGhost();
      nCheck := -6;
      if m_boKickFlag then begin
        SendDefMessage(SM_OUTOFCONNECTION, 0, 0, 0, 0, '');
      end;
      nCheck := -7;
      if (not m_boReconnection) and (m_boSoftClose) then begin
        FrmIDSoc.SendHumanLogOutMsg(m_sUserID, m_nSessionID);
      end;
    end;
  except
    on E: Exception do begin
      if ProcessMsg.wIdent = 0 then
        MakeGhost();
      // 11.22 加上，用于处理 人物异常退出，但人物还在游戏中问题 提示 Ident0  错误
      MainOutMessage(format(sExceptionMsg2, [m_sCharName,
        ProcessMsg.wIdent,
          Integer(ProcessMsg.BaseObject),
          ProcessMsg.wParam,
          ProcessMsg.nParam1,
          ProcessMsg.nParam2,
          ProcessMsg.nParam3,
          ProcessMsg.sMsg, nCheck]));
      MainOutMessage(E.Message);
    end;
  end;
  if m_boOnHorse then begin
    if m_PEnvir.m_boNotHorse then ChangeHorseState(False)
    else m_UseItems[u_House].wHP := m_WAbil.HP;
  end;

  if m_PEnvir.m_boDECHP and (GetTickCount - m_dwDecHPTick > LongWord(m_PEnvir.m_nDECHPTIME * 1000)) then begin
    m_dwDecHPTick := GetTickCount();
    if m_WAbil.HP > m_PEnvir.m_nDECHPPOINT then begin
      Dec(m_WAbil.HP, m_PEnvir.m_nDECHPPOINT);
    end
    else begin
      m_WAbil.HP := 0;
    end;
    HealthSpellChanged();
  end;

  if m_PEnvir.m_boINCHP and (GetTickCount - m_dwIncHPTick > LongWord(m_PEnvir.m_nINCHPTIME * 1000)) then begin
    m_dwIncHPTick := GetTickCount();
    if m_WAbil.HP + m_PEnvir.m_nDECHPPOINT < m_WAbil.MaxHP then begin
      Inc(m_WAbil.HP, m_PEnvir.m_nDECHPPOINT);
    end
    else begin
      m_WAbil.HP := m_WAbil.MaxHP;
    end;
    HealthSpellChanged();
  end;

  if GetTickCount - m_dwRateTick > 1000 then begin
    m_dwRateTick := GetTickCount();
    if m_dwKillMonExpRateTime > 0 then begin
      Dec(m_dwKillMonExpRateTime);
      if m_dwKillMonExpRateTime = 0 then begin
        m_nKillMonExpRate := 100;
        SysMsg('经验倍数恢复正常.', c_Red, t_Hint);
        ChangeStatusMode(STATUS_EXP, False);
      end;
    end;
    if m_dwPowerRateTime > 0 then begin
      Dec(m_dwPowerRateTime);
      if m_dwPowerRateTime = 0 then begin
        m_nPowerRate := 100;
        SysMsg('攻击力倍数恢复正常.', c_Red, t_Hint);
        ChangeStatusMode(STATUS_POW, False);
      end;
    end;

    if m_CenterMsgList.Count > 0 then begin
      for I := m_CenterMsgList.Count - 1 downto 0 do begin
        CenterMsg := pTCenterMsg(m_CenterMsgList.Items[i]);
        if GetTickCount > CenterMsg.dwTimeout then begin
          Dispose(CenterMsg);
          m_CenterMsgList.Delete(I);
        end;
      end;
    end;
  end;

  try
    if g_Config.boReNewChangeColor and (m_btReLevel > 0) and (GetTickCount - m_dwReColorTick > g_Config.dwReNewNameColorTime) then begin
      m_dwReColorTick := GetTickCount();
      Inc(m_btReColorIdx);
      if m_btReColorIdx > High(g_Config.ReNewNameColor) then
        m_btReColorIdx := 0;
      m_btNameColor := g_Config.ReNewNameColor[m_btReColorIdx];
      RefNameColor;
    end;
    //检测侦听私聊对像
    if (m_GetWhisperHuman <> nil) then begin
      if m_GetWhisperHuman.m_boDeath or (m_GetWhisperHuman.m_boGhost) then
        m_GetWhisperHuman := nil;
    end;
    ProcessSpiritSuite();
  except

  end;

  try
    if (GetTickCount - m_dwClearObjTick) > 1000 * 60 then begin
      m_dwClearObjTick := GetTickCount();
      if (m_DearHuman <> nil) and (m_DearHuman.m_boDeath or m_DearHuman.m_boGhost) then begin
        m_DearHuman := nil;
      end;
      for i := 0 to m_MasterList.Count - 1 do begin
        PlayObject := TPlayObject(m_MasterList.Objects[i]);
        if (PlayObject <> nil) and (PlayObject.m_boDeath or PlayObject.m_boGhost) then begin
          m_MasterList.Objects[i] := nil;
        end;
      end;
      if (m_UseItems[u_House].wIndex > 0) then begin
        if (m_UseItems[u_House].btAliveTime > 0) then begin
          Dec(m_UseItems[u_House].btAliveTime);
          if m_UseItems[u_House].btAliveTime <= 0 then begin
            m_UseItems[u_House].wHP := 14;
            SendUpdateItem(@m_UseItems[u_House]);
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg4);
      MainOutMessage(E.Message);
    end;
  end;

  if (m_nAutoGetExpPoint > 0) and ((m_AutoGetExpEnvir = nil) or (m_AutoGetExpEnvir = m_PEnvir)) and
    ((GetTickCount - m_dwAutoGetExpTick) > LongWord(m_nAutoGetExpTime)) then begin
    m_dwAutoGetExpTick := GetTickCount();
    if not m_boAutoGetExpInSafeZone or (m_boAutoGetExpInSafeZone and InSafeZone) then
      GetExp(m_nAutoGetExpPoint);
  end;

  if m_PEnvir.m_boDecGameGold then begin
    if (GetTickCount - m_dwDecGameGoldTick) > LongWord(m_PEnvir.m_nDECGAMEGOLDTIME * 1000) then begin
      m_dwDecGameGoldTick := GetTickCount;
      if m_nGameGold >= m_PEnvir.m_nDecGameGold then begin
        Dec(m_nGameGold, m_PEnvir.m_nDecGameGold);
        if g_boGameLogGameGold then begin
          AddGameLog(Self, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, m_nGameGold, m_sCharName,
            '-', IntToStr(m_PEnvir.m_nDecGameGold), 'MapAuto', nil);
        end;
        GameGoldChanged;
      end
      else begin
        SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
        BaseObjectMove(m_sHomeMap, IntToStr(m_nHomeX), IntToStr(m_nHomeY));
      end;
    end;
  end;

  if m_PEnvir.m_boIncGameGold then begin
    if (GetTickCount - m_dwIncGameGoldTick) > LongWord(m_PEnvir.m_nINCGAMEGOLDTIME * 1000) then begin
      m_dwIncGameGoldTick := GetTickCount;
      if (m_nGameGold + m_PEnvir.m_nIncGameGold) < 1000000000 then begin
        Inc(m_nGameGold, m_PEnvir.m_nIncGameGold);
        if g_boGameLogGameGold then begin
          AddGameLog(Self, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, m_nGameGold, m_sCharName,
            '+', IntToStr(m_PEnvir.m_nIncGameGold), 'MapAuto', nil);
        end;
        GameGoldChanged;
      end;
    end;
  end;

  if (m_DareObject <> nil) and (m_DareObject.m_boGhost) then
    m_DareObject := nil;
    
  inherited Run;
end;

procedure TPlayObject.ProcessSpiritSuite();
var
  i: Integer;
  StdItem: pTStdItem;
  UseItem: pTUserItem;
begin
  if not g_Config.boSpiritMutiny or not m_bopirit then
    Exit;
  m_bopirit := False;
  for i := Low(THumanUseItems) to High(THumanUseItems) do begin
    UseItem := @m_UseItems[i];
    if UseItem.wIndex <= 0 then
      Continue;
    StdItem := UserEngine.GetStdItem(UseItem.wIndex);
    if StdItem <> nil then begin
      if (StdItem.Shape = 126) or
        (StdItem.Shape = 127) or
        (StdItem.Shape = 128) or
        (StdItem.Shape = 129) then begin

        SendDelItems(UseItem);
        UseItem.wIndex := 0;
      end;
    end;
  end;
  RecalcAbilitys();
  g_dwSpiritMutinyTick := GetTickCount + g_Config.dwSpiritMutinyTime;
  UserEngine.SendBroadCastMsg('神之祈祷，天地震怒，尸横遍野...', t_System);
  SysMsg('祈祷发出强烈的宇宙效应', c_Green, t_Hint);
end;
{
procedure TPlayObject.LogonTimcCost(); //004CA994
var
  n08: Integer;
  SC: string;
begin
  if (m_nPayMent = 2) or (g_Config.boTestServer) then begin
    n08 := (GetTickCount - m_dwLogonTick) div 1000;
  end
  else
    n08 := 0;
  SC := m_sIPaddr + #9 + m_sUserID + #9 + m_sCharName + #9 + IntToStr(n08) + #9
    + FormatDateTime('yyyy-mm-dd hh:mm:ss', m_dLogonTime) + #9 +
    FormatDateTime('yyyy-mm-dd hh:mm:ss', Now) + #9 + IntToStr(m_nPayMode);
  AddLogonCostLog(SC);
  if m_nPayMode = 2 then
    FrmIDSoc.SendLogonCostMsg(m_sUserID, n08 div 60);
end;     }

procedure TPlayObject.RefUserState();
var
  n8: Integer;
begin
  n8 := 0;
  if m_btStartType = OT_SAFEPK then
    n8 := OT_SAFEPK;
  if m_PEnvir.m_boFightZone then
    n8 := OT_SAFEPK;
  if m_PEnvir.m_boFight3Zone then
    n8 := OT_SAFEPK;
  if m_PEnvir.m_boSAFE then
    n8 := OT_SAFEAREA;
  if m_btStartType = OT_SAFEAREA then
    n8 := OT_SAFEAREA;
  if m_boInFreePKArea then
    n8 := OT_FREEPKAREA;
  {if m_PEnvir.m_boFightZone then
    n8 := n8 or 1;
  if m_PEnvir.m_boSAFE then
    n8 := n8 or 2;
  if m_boInFreePKArea then
    n8 := n8 or 4;
  if m_btStartType = OT_SAFEAREA then
    n8 := n8 or 8;
  if m_btStartType = OT_SAFEPK then
    n8 := n8 or 16;             }
  SendDefMessage(SM_AREASTATE, n8, 0, 0, 0, '');
end;

function TPlayObject.GetUserState(): Integer;
var
  n8: Integer;
begin
  n8 := 0;
  if m_btStartType = OT_SAFEPK then
    n8 := OT_SAFEPK;
  if m_PEnvir.m_boFightZone then
    n8 := OT_SAFEPK;
  if m_PEnvir.m_boSAFE then
    n8 := OT_SAFEAREA;
  if m_btStartType = OT_SAFEAREA then
    n8 := OT_SAFEAREA;
  if m_boInFreePKArea then
    n8 := OT_FREEPKAREA;
  Result := n8;
end;

function TPlayObject.HorseRunTo(btDir: Byte; boFlag: Boolean): Boolean;
var
  nOldX, nOldY: Integer;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::HorseRunTo';
begin
  Result := False;
  if m_PEnvir = nil then exit;
  try
   nOldX := m_nCurrX;
   nOldY := m_nCurrY;
   m_btDirection := btDir;
   case btDir of
     DR_UP {0}: begin
         if (m_nCurrY > 2) and
           (m_PEnvir.CanWalkEx(m_nCurrX, m_nCurrY - 1, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.CanWalkEx(m_nCurrX, m_nCurrY - 2, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.CanWalkEx(m_nCurrX, m_nCurrY - 3, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX,
           m_nCurrY - 3, True) > 0) then begin

           Dec(m_nCurrY, 3);
         end;
       end;
     DR_UPRIGHT {1}: begin
         if (m_nCurrX < m_PEnvir.m_nWidth - 3) and
           (m_nCurrY > 2) and
           (m_PEnvir.CanWalkEx(m_nCurrX + 1, m_nCurrY - 1,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.CanWalkEx(m_nCurrX + 2, m_nCurrY - 2,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.CanWalkEx(m_nCurrX + 3, m_nCurrY - 3,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX + 3,
           m_nCurrY - 3, True) > 0) then begin

           Inc(m_nCurrX, 3);
           Dec(m_nCurrY, 3);
         end;
       end;
     DR_RIGHT {2}: begin
         if (m_nCurrX < m_PEnvir.m_nWidth - 3) and
           (m_PEnvir.CanWalkEx(m_nCurrX + 1, m_nCurrY, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.CanWalkEx(m_nCurrX + 2, m_nCurrY, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.CanWalkEx(m_nCurrX + 3, m_nCurrY, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX + 3,
           m_nCurrY, True) > 0) then begin

           Inc(m_nCurrX, 3);
         end;
       end;
     DR_DOWNRIGHT {3}: begin
         if (m_nCurrX < m_PEnvir.m_nWidth - 3) and
           (m_nCurrY < m_PEnvir.m_nHeight - 3) and
           (m_PEnvir.CanWalkEx(m_nCurrX + 1, m_nCurrY + 1,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.CanWalkEx(m_nCurrX + 2, m_nCurrY + 2,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.CanWalkEx(m_nCurrX + 3, m_nCurrY + 3,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX + 3,
           m_nCurrY + 3, True) > 0) then begin

           Inc(m_nCurrX, 3);
           Inc(m_nCurrY, 3);
         end;
       end;
     DR_DOWN {4}: begin
         if (m_nCurrY < m_PEnvir.m_nHeight - 3) and
           (m_PEnvir.CanWalkEx(m_nCurrX, m_nCurrY + 1, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.CanWalkEx(m_nCurrX, m_nCurrY + 2, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.CanWalkEx(m_nCurrX, m_nCurrY + 3, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX,
           m_nCurrY + 3, True) > 0) then begin

           Inc(m_nCurrY, 3);
         end;
       end;
     DR_DOWNLEFT {5}: begin
         if (m_nCurrX > 2) and
           (m_nCurrY < m_PEnvir.m_nHeight - 3) and
           (m_PEnvir.CanWalkEx(m_nCurrX - 1, m_nCurrY + 1,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.CanWalkEx(m_nCurrX - 2, m_nCurrY + 2,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.CanWalkEx(m_nCurrX - 3, m_nCurrY + 3,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX - 3,
           m_nCurrY + 3, True) > 0) then begin

           Dec(m_nCurrX, 3);
           Inc(m_nCurrY, 3);
         end;
       end;
     DR_LEFT {6}: begin
         if (m_nCurrX > 2) and
           (m_PEnvir.CanWalkEx(m_nCurrX - 1, m_nCurrY, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.CanWalkEx(m_nCurrX - 2, m_nCurrY, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.CanWalkEx(m_nCurrX - 3, m_nCurrY, g_Config.boDiableHumanRun
           or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
           (g_Config.boSafeAreaLimited and InSafeZone)) and
           (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX - 3,
           m_nCurrY, True) > 0) then begin

           Dec(m_nCurrX, 3);
         end;
       end;
     DR_UPLEFT {7}: begin
         if (m_nCurrX > 2) and
           (m_nCurrY > 2) and
           (m_PEnvir.CanWalkEx(m_nCurrX - 1, m_nCurrY - 1,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.CanWalkEx(m_nCurrX - 2, m_nCurrY - 2,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.CanWalkEx(m_nCurrX - 3, m_nCurrY - 3,
           g_Config.boDiableHumanRun or ((m_btPermission > 9) and
           g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
           and
           (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX - 3,
           m_nCurrY - 3, True) > 0) then begin

           Dec(m_nCurrX, 3);
           Dec(m_nCurrY, 3);
         end;
       end;
   end;
   //    SysMsg(format('原X:%d 原Y:%d 新X:%d 新Y:%d',[n10,n14,m_nCurrX,m_nCurrY]),c_Green,t_Hint);
   if (m_nCurrX <> nOldX) or (m_nCurrY <> nOldY) then begin
     if Walk(RM_HORSERUN) then
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
(*
function TPlayObject.LeapTo(btDir: Byte; boFlag: Boolean; nDestX, nDestY: Integer): Boolean;
var
nOldX, nOldY: Integer;
resourcestring
sExceptionMsg = '[Exception] TPlayObject::LeapTo';
begin
Result := False;
try
 nOldX := m_nCurrX;
 nOldY := m_nCurrY;
 m_btDirection := btDir;
 case btDir of
   DR_UP {0}: begin
       if (m_nCurrY > 1) and
         (m_PEnvir.CanWalkEx(m_nCurrX, m_nCurrY - 2, g_Config.boDiableHumanRun
         or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
         (g_Config.boSafeAreaLimited and InSafeZone)) and
         (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX,
         m_nCurrY - 2, True) > 0) then begin
         Dec(m_nCurrY, 2);
       end;
     end;
   DR_UPRIGHT {1}: begin
       if (m_nCurrX < m_PEnvir.m_nWidth - 2) and
         (m_nCurrY > 1) and
         (m_PEnvir.CanWalkEx(m_nCurrX + 2, m_nCurrY - 2,
         g_Config.boDiableHumanRun or ((m_btPermission > 9) and
         g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
         and
         (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX + 2,
         m_nCurrY - 2, True) > 0) then begin
         Inc(m_nCurrX, 2);
         Dec(m_nCurrY, 2);
       end;
     end;
   DR_RIGHT {2}: begin
       if (m_nCurrX < m_PEnvir.m_nWidth - 2) and
         (m_PEnvir.CanWalkEx(m_nCurrX + 2, m_nCurrY, g_Config.boDiableHumanRun
         or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
         (g_Config.boSafeAreaLimited and InSafeZone)) and
         (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX + 2,
         m_nCurrY, True) > 0) then begin
         Inc(m_nCurrX, 2);
       end;
     end;
   DR_DOWNRIGHT {3}: begin
       if (m_nCurrX < m_PEnvir.m_nWidth - 2) and
         (m_nCurrY < m_PEnvir.m_nHeight - 2) and
         (m_PEnvir.CanWalkEx(m_nCurrX + 2, m_nCurrY + 2,
         g_Config.boDiableHumanRun or ((m_btPermission > 9) and
         g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
         and
         (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX + 2,
         m_nCurrY + 2, True) > 0) then begin
         Inc(m_nCurrX, 2);
         Inc(m_nCurrY, 2);
       end;
     end;
   DR_DOWN {4}: begin
       if (m_nCurrY < m_PEnvir.m_nHeight - 2) and
         (m_PEnvir.CanWalkEx(m_nCurrX, m_nCurrY + 2, g_Config.boDiableHumanRun
         or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
         (g_Config.boSafeAreaLimited and InSafeZone)) and
         (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX,
         m_nCurrY + 2, True) > 0) then begin
         Inc(m_nCurrY, 2);
       end;
     end;
   DR_DOWNLEFT {5}: begin
       if (m_nCurrX > 1) and
         (m_nCurrY < m_PEnvir.m_nHeight - 2) and
         (m_PEnvir.CanWalkEx(m_nCurrX - 2, m_nCurrY + 2,
         g_Config.boDiableHumanRun or ((m_btPermission > 9) and
         g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
         and
         (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX - 2,
         m_nCurrY + 2, True) > 0) then begin
         Dec(m_nCurrX, 2);
         Inc(m_nCurrY, 2);
       end;
     end;
   DR_LEFT {6}: begin
       if (m_nCurrX > 1) and
         (m_PEnvir.CanWalkEx(m_nCurrX - 2, m_nCurrY, g_Config.boDiableHumanRun
         or ((m_btPermission > 9) and g_Config.boGMRunAll)) or
         (g_Config.boSafeAreaLimited and InSafeZone)) and
         (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX - 2,
         m_nCurrY, True) > 0) then begin
         Dec(m_nCurrX, 2);
       end;
     end;
   DR_UPLEFT {7}: begin
       if (m_nCurrX > 1) and
         (m_nCurrY > 1) and
         (m_PEnvir.CanWalkEx(m_nCurrX - 2, m_nCurrY - 2,
         g_Config.boDiableHumanRun or ((m_btPermission > 9) and
         g_Config.boGMRunAll)) or (g_Config.boSafeAreaLimited and InSafeZone))
         and
         (m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, m_nCurrX - 2,
         m_nCurrY - 2, True) > 0) then begin
         Dec(m_nCurrX, 2);
         Dec(m_nCurrY, 2);
       end;
     end;
 end;
 if ((m_nCurrX <> nOldX) or (m_nCurrY <> nOldY)) then begin
   if Walk(RM_LEAP) then
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
end;     *)
(*
function TPlayObject.ClientLeapXY(wIdent: Word; nX, nY: Integer; nFlag: Integer; var dwDelayTime: LongWord): Boolean;
var
nDir: Integer;
//  dwCheckTime: LongWord;
begin
Result := False;
dwDelayTime := 0;
//if not m_boCanRun then Exit;
if m_boDeath or m_boOnHorse or m_boShoping or
 ((not CanWork) and (not g_Config.ClientConf.boParalyCanRun)) then
 Exit; //防麻

//m_dwMoveTick := GetTickCount();
//  if (m_dwMoveCount < 4) and (m_dwMoveCountA < 6) then begin
//m_bo316 := False;
nDir := GetNextDirection(m_nCurrX, m_nCurrY, nX, nY);
if LeapTo(nDir, False, nX, nY) then begin
 m_dwStationTick := GetTickCount; //增加检测人物站立不动时间
 if m_boTransparent and (m_boHideMode) then
   m_wStatusTimeArr[STATE_TRANSPARENT {0 0x70}] := 1;
 if {m_bo316 or (}(m_nCurrX = nX) and (m_nCurrY = nY){)} then
   Result := True;
 Dec(m_nHealthTick, 60);
 Dec(m_nSpellTick, 10);
 m_nSpellTick := _MAX(0, m_nSpellTick);
 Dec(m_nPerHealth);
 Dec(m_nPerSpell);
end
else begin
 //m_dwMoveCount := 0;
 //m_dwMoveCountA := 0;
end;
end;   *)

function TPlayObject.ClientRunXY(wIdent: Word; nX, nY: Integer; boLateDelivery: Boolean;
  var dwDelayTime: LongWord): Boolean; //004CB11C
var
  nDir: Integer;
  dwCheckTime: LongWord;
begin
  Result := False;
  dwDelayTime := 0;
  //if not m_boCanRun then Exit;
  if m_boDeath or m_boOnHorse or m_boShoping or
    ((not CanWork) and (not g_Config.ClientConf.boParalyCanRun)) then
    Exit; //防麻

  if not boLateDelivery then begin
    dwCheckTime := GetTickCount;
    if dwCheckTime < m_dwRunTime then begin
      dwDelayTime := m_dwRunTime - dwCheckTime;
      Inc(m_nRunCount, g_Config.nMaxRunMsgCount);
      Inc(m_dwRunTime, g_Config.dwRunIntervalTime);
      exit;
    end;
    if m_nRunCount > 0 then
      Dec(m_nRunCount);
    SetUserTime(g_Config.dwRunIntervalTime);
  end;
  m_boRunDelay := False;
  m_boChangeMap := False;
  nDir := GetNextDirection(m_nCurrX, m_nCurrY, nX, nY);
  if RunTo(nDir, False, nX, nY) then begin
    m_dwStationTick := GetTickCount; //增加检测人物站立不动时间
    if m_boTransparent and (m_boHideMode) then begin
      m_wStatusTimeArr[STATE_TRANSPARENT {0 0x70}] := 1;
    end;
    if m_boChangeMap or ((m_nCurrX = nX) and (m_nCurrY = nY)) then
      Result := True;
    Dec(m_nHealthTick, 60);
    Dec(m_nSpellTick, 10);
    m_nSpellTick := _MAX(0, m_nSpellTick);
    Dec(m_nPerHealth);
    Dec(m_nPerSpell);
  end
  else begin
    //m_dwMoveCount := 0;
    //m_dwMoveCountA := 0;
  end;

end;

function TPlayObject.ClientWalkXY(wIdent: Word; nX, nY: Integer; boLateDelivery:
  Boolean; var dwDelayTime: LongWord): Boolean; //004CAF08
var
  n14 {, n18, n1C}: Integer;
  dwCheckTime: LongWord;
begin
  Result := False;
  dwDelayTime := 0;
  //if not m_boCanWalk then Exit;
  if m_boDeath or m_boShoping or
    ((not CanWork) and (not g_Config.ClientConf.boParalyCanWalk)) then
    Exit; //防麻

  if not boLateDelivery then begin
    dwCheckTime := GetTickCount;
    if dwCheckTime < m_dwWalkTime then begin
      dwDelayTime := m_dwWalkTime - dwCheckTime;
      Inc(m_nWalkCount, g_Config.nMaxWalkMsgCount);
      Inc(m_dwWalkTime, g_Config.dwWalkIntervalTime);
      exit;
    end;
    if m_nWalkCount > 0 then
      Dec(m_nWalkCount);
    SetUserTime(g_Config.dwWalkIntervalTime);
  end;
  m_boWalkDelay := False;

  n14 := GetNextDirection(m_nCurrX, m_nCurrY, nX, nY);
  m_boChangeMap := False;
  if WalkTo(n14, False) then begin
    m_dwStationTick := GetTickCount; //增加检测人物站立不动时间
    if m_boChangeMap or ((m_nCurrX = nX) and (m_nCurrY = nY)) then
      Result := True;
    Dec(m_nHealthTick, 10);
  end
  else begin
    //m_dwMoveCount := 0;
    //m_dwMoveCountA := 0;
  end;
end;

procedure TPlayObject.ClientGuageBar(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if m_boDeath or m_boGhost or (not m_boClickOpenGuage) then
    Exit;
  if (m_ClickGuageNPC <> nil) and (TBaseObject(ProcessMsg.nParam1) = m_ClickGuageNPC) then begin
    if GetTickCount > m_dwClickOpenGuageTime then begin
      if (m_ClickGuageNPC.m_PEnvir = m_PEnvir) and (abs(m_ClickGuageNPC.m_nCurrX - m_nCurrX) < 12) and
        (abs(m_ClickGuageNPC.m_nCurrY - m_nCurrY) < 12) and
        (m_ClickGuageNPC.m_btRaceServer = RC_NPC) then begin
        m_boClickOpenGuage := False;
        TNormNpc(m_ClickGuageNPC).GotoLable(Self, TNormNpc(m_ClickGuageNPC).GetScriptIndex(m_ClickGuageNPCLabel), False);
        m_ClickGuageNPCLabel := '';
        m_ClickGuageNPC := nil;
      end;
    end;
  end;
end;

procedure TPlayObject.ClientMissionStateChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if ProcessMsg.nParam1 in [Low(m_MissionInfo)..High(m_MissionInfo)] then begin
    m_MissionInfo[ProcessMsg.nParam1].boTrack := (ProcessMsg.nParam2 = 1);
  end;
end;

procedure TPlayObject.ClientCenterMsgClick(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  CenterMsg: pTCenterMsg;
  I: Integer;
begin
  for I := 0 to m_CenterMsgList.Count - 1 do begin
    CenterMsg := m_CenterMsgList[I];
    if Integer(CenterMsg) = ProcessMsg.nParam1 then begin
      if GetTickCount > CenterMsg.dwRunTick then begin
        NpcGotoLable(CenterMsg.Npc, CenterMsg.nLable, False);
        Dispose(CenterMsg);
        m_CenterMsgList.Delete(I);
      end;
      Break;
    end;
  end;
end;

procedure TPlayObject.ClientSetMagicKey(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  UserMagic: pTUserMagic;
  I: Integer;
begin
  for I := 0 to m_MagicList.Count - 1 do begin
    UserMagic := m_MagicList[I];
    if UserMagic.wMagIdx = ProcessMsg.nParam1 then begin
      UserMagic.btKey := ProcessMsg.nParam2;
      break;
    end;
  end;
end;

procedure TPlayObject.ClientSpeedClose(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SpeedCloseFunc; //加速触发
  if g_Config.boKickOverSpeed then begin
    SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, '[断开连接]: 您的游戏速度不稳定,与服务器断开连接!\如果您开了加速软件，请关闭！');
    m_boEmergencyClose := True;
  end;
end;

procedure TPlayObject.ClientRemoveStone(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  NPC: TNormNPC;
  I, nIdx, nBack: Integer;
  RemoveIndex, ArmIndex: Integer;
  UserItem, RemoveItem, ArmItem: pTUserItem;
  StdItem, RemoveStdItem, ArmStdItem: pTStdItem;
begin
  nBack := 0;
  try
    NPC := TNormNPC(GetSelectNPC(Integer(m_ClickNPC)));
    if (NPC = nil) or (not (NPC is TMerchant)) or (not TMerchant(NPC).m_boArmRemoveStone) then
      exit;
    RemoveIndex := ProcessMsg.nParam1;
    ArmIndex := MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3);
    nIdx := ProcessMsg.wParam;
    RemoveItem := nil;
    RemoveStdItem := nil;
    ArmItem := nil;
    ArmStdItem := nil;
    nBack := -1; //材料不足
    try
      if nIdx in [0..2] then begin
        for I := m_ItemList.Count - 1 downto 0 do begin
          UserItem := m_ItemList[I];
          if UserItem = nil then
            Continue;
          Stditem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem <> nil then begin
            if (RemoveItem = nil) and (UserItem.MakeIndex = RemoveIndex) then begin
              RemoveItem := UserItem;
              RemoveStdItem := StdItem;
              m_ItemList.Delete(I);
            end
            else if (ArmItem = nil) and (UserItem.MakeIndex = ArmIndex) then begin
              ArmItem := UserItem;
              ArmStdItem := StdItem;
            end;
            ;
            if (ArmItem <> nil) and (RemoveItem <> nil) then
              break;
          end;
        end;
        if (ArmItem <> nil) and (RemoveItem <> nil) and (RemoveStdItem <> nil) and (ArmStdItem <> nil) then begin
          if (tm_MakeStone = RemoveStdItem.StdMode) and (RemoveStdItem.Shape = 9) then begin
            if (sm_ArmingStrong in ArmStdItem.StdModeEx) and (ArmItem.Value.btFluteCount > nIdx) and (ArmItem.Value.wFlute[nIdx] > 0) then begin
              Stditem := UserEngine.GetStdItem(ArmItem.Value.wFlute[nIdx]);
              if (Stditem <> nil) and (tm_MakeStone = Stditem.StdMode) and (Stditem.Shape = 3) then begin
                New(UserItem);
                if UserEngine.CopyToUserItemFromIdx(ArmItem.Value.wFlute[nIdx], UserItem) then begin
                  m_ItemList.Add(UserItem);
                  ArmItem.Value.wFlute[nIdx] := 0;
                  if RemoveStdItem.NeedIdentify = 1 then
                    AddGameLog(Self, LOG_DELITEM, RemoveStdItem.Name, RemoveItem.MakeIndex, RemoveItem.Dura, NPC.m_sCharName,
                      '0', '卸下宝石', '使用', RemoveItem);
                  if Stditem.NeedIdentify = 1 then
                    AddGameLog(Self, LOG_ADDITEM, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, NPC.m_sCharName,
                      '0', '卸下宝石', '卸下', UserItem);
                  Dispose(RemoveItem);
                  RemoveItem := nil;
                  nBack := 1;
                  SendDefMessage(SM_REMOVESTONE_BACK, nBack, LoWord(UserItem.MakeIndex),
                    HiWord(UserItem.MakeIndex), nIdx, '');
                  Exit;
                end
                else begin
                  nBack := -3;
                  Dispose(UserItem);
                end;
              end
              else
                nBack := -3; //装备没有可卸下宝石
            end
            else
              nBack := -3; //装备没有可卸下宝石
          end
          else
            nBack := -2; //卸下宝石不对
        end;
      end;
      SendDefMessage(SM_REMOVESTONE_BACK, nBack, 0, 0, nIdx, '');
    finally
      if RemoveItem <> nil then
        m_ItemList.Add(RemoveItem);
    end;
  except
    on E: Exception do begin
      MainOutMessage('[Exception] TPlayObject.ClientRemoveStone -> ' + IntToStr(nBack));
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TPlayObject.ClientGetTopInfo(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  nPage, nCount, nUserPage: Integer;
  nIndex: Integer;
  TopInfo: TClientTopInfo;
  I, n: Integer;
  sSendMsg: string;
  nBack: Byte;
  boFind: Boolean;
begin
  nIndex := ProcessMsg.nParam1;
  nUserPage := ProcessMsg.nParam2;
  nPage := 0;
  sSendMsg := '';
  nBack := 0;
  if ProcessMsg.wParam = 1 then begin
    nBack := 1;
    sSendMsg := EncodeString('你没有上榜，请继续努力！');
    if nIndex in [Low(g_TopInfo)..High(g_TopInfo)] then begin
      if g_TopInfo[nIndex] <> nil then begin
        nCount := Length(g_TopInfo[nIndex]);
        if nCount > 0 then begin
          nPage := nCount div 20;
          if nCount mod 20 > 0 then
            Inc(nPage);
          nUserPage := 0;
          n := 0;
          boFind := False;
          SafeFillChar(TopInfo, SizeOf(TopInfo), #0);
          for I := Low(g_TopInfo[nIndex]) to High(g_TopInfo[nIndex]) do begin
            if n > High(TClientTopInfo) then begin
              if boFind then
                Break;
              n := 0;
              Inc(nUserPage);
              SafeFillChar(TopInfo, SizeOf(TopInfo), #0);
            end;
            TopInfo[n] := g_TopInfo[nIndex][I];
            if (not boFind) and (g_TopInfo[nIndex][I].sChrName = m_sCharName) then begin
              nBack := 0;
              boFind := True;
            end;
            Inc(n);
          end;
          if boFind then
            sSendMsg := EncodeBuffer(@TopInfo[0], SizeOf(TClientTopInfo));
        end;
      end;

    end;
  end
  else begin
    if nIndex in [Low(g_TopInfo)..High(g_TopInfo)] then begin
      if g_TopInfo[nIndex] <> nil then begin
        nCount := Length(g_TopInfo[nIndex]);
        if nCount > 0 then begin
          nPage := nCount div 20;
          if nCount mod 20 > 0 then
            Inc(nPage);
          if nUserPage < 0 then
            nUserPage := 0;
          if nUserPage > nPage then
            nUserPage := nPage;
          SafeFillChar(TopInfo, SizeOf(TopInfo), #0);
          for I := (nUserPage * 20) to (nUserPage * 20 + High(TClientTopInfo)) do begin
            if I > High(g_TopInfo[nIndex]) then
              break;
            TopInfo[I - nUserPage * 20] := g_TopInfo[nIndex][I];
          end;
          sSendMsg := EncodeBuffer(@TopInfo[0], SizeOf(TClientTopInfo));
        end;
      end;
    end;
  end;
  m_DefMsg := MakeDefaultMsg(SM_GETTOPINFO, nIndex, nUserPage, nPage, nBack);
  SendSocket(@m_DefMsg, sSendMsg);
end;

procedure TPlayObject.ClientMakeMagic(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  idx: Byte;
  I, nCheckLevel: Integer;
begin
  idx := ProcessMsg.nParam1;
  if idx in [Low(m_MakeMagic)..High(m_MakeMagic)] then begin
    if (m_MakeMagic[idx] > 0) and (m_MakeMagic[idx] < g_Config.btMakeMagicMaxLevel) and (m_nMakeMagicPoint >= g_Config.btMakeMagicUsePoint) then begin
      nCheckLevel := m_MakeMagic[idx] + 1;
      for I := Low(g_Config.MakeMagicConfine[idx]) to High(g_Config.MakeMagicConfine[idx]) do begin
        if g_Config.MakeMagicConfine[idx][I].nHumLevel <= 0 then
          Break;
        if nCheckLevel < g_Config.MakeMagicConfine[idx][I].nMagicLevel then
          Break;
        if nCheckLevel >= g_Config.MakeMagicConfine[idx][I].nMagicLevel then begin
          if m_Abil.Level < g_Config.MakeMagicConfine[idx][I].nHumLevel then begin
            SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, '[升级失败]：需要人物等级达到' +
              IntToStr(g_Config.MakeMagicConfine[idx][I].nHumLevel) + '级');
            SendMakeMagic;
            Exit;
          end;
        end;
      end;
      Inc(m_MakeMagic[idx]);
      Dec(m_nMakeMagicPoint, g_Config.btMakeMagicUsePoint);
      SendMakeMagic;
    end;
  end;
end;

procedure TPlayObject.ClientClickBox(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  BaseObject: TBaseObject;
begin
  if m_boDeath or m_boGhost then
    Exit;
  BaseObject := TBaseObject(ProcessMsg.nParam1);
  if ProcessMsg.nParam2 = 2 then begin
    ChangeHorseState(True);
    m_boCanOnHorse := False;
  end else
  if ProcessMsg.nParam2 = 1 then begin
    if m_boClickOpenBox and (m_ClickBoxObject <> nil) and (GetTickCount > m_dwClickOpenBoxTime) and
      (m_ClickBoxObject.m_PEnvir = m_PEnvir) and
      (abs(m_ClickBoxObject.m_nCurrX - m_nCurrX) < 2) and
      (abs(m_ClickBoxObject.m_nCurrY - m_nCurrY) < 2) and
      (m_ClickBoxObject.m_btRaceServer = RC_BOX) then begin
      if m_ClickBoxObject.m_boGhost or m_ClickBoxObject.m_boDeath then begin
        SysMsg('您下手太慢了，已经被别人捷足先登啦！', c_Red, t_Hint);
      end
      else begin
        if m_ClickBoxObject.m_btRaceImg = 26 then begin
          if TBoxMonster(m_ClickBoxObject).m_nBoxIndex in [Low(g_FunctionNPC.FStdModeFunc)..High(g_FunctionNPC.FStdModeFunc)] then
            NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FStdModeFunc[TBoxMonster(m_ClickBoxObject).m_nBoxIndex], False);
          Inc(m_ClickBoxObject.m_Abil.MP, 1);
          if m_ClickBoxObject.m_Abil.MP >= m_ClickBoxObject.m_Abil.MaxMP then
            m_ClickBoxObject.MakeGhost;
        end
        else begin
          if OpenBox(TBoxMonster(m_ClickBoxObject).m_nBoxIndex, Random(100) < m_ClickBoxObject.m_btCoolEye) then begin
            m_ClickBoxObject.HintGotoScript(m_ClickBoxObject.m_nDieScript);
            Inc(m_ClickBoxObject.m_Abil.MP, 1);
            if m_ClickBoxObject.m_Abil.MP >= m_ClickBoxObject.m_Abil.MaxMP then
              m_ClickBoxObject.MakeGhost;
          end;
        end;
        m_boClickOpenBox := False;
        m_ClickBoxObject := nil;
      end;
    end;
  end
  else begin
    if CretInNearXY(BaseObject, m_nCurrX, m_nCurrY) then begin
      if (BaseObject.m_btRaceServer = RC_BOX) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
        m_boClickOpenBox := True;
        m_dwClickOpenBoxTime := GetTickCount + BaseObject.m_WAbil.MaxHP * 1000;
        m_ClickBoxObject := BaseObject;
        if m_ClickBoxObject.m_btRaceImg = 26 then
          SendDefMessage(SM_SHOWBAR, ProcessMsg.nParam1, 1, CM_CLICKBOX, BaseObject.m_WAbil.MaxHP, '正在采集...')
        else
          SendDefMessage(SM_SHOWBAR, ProcessMsg.nParam1, 1, CM_CLICKBOX, BaseObject.m_WAbil.MaxHP, '正在开启宝箱...');
      end;
    end;
  end;
end;

procedure TPlayObject.ClientClickNPC(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  NormNpc: TNormNpc;
begin
  if m_boDeath or m_boGhost then
    Exit;
  NormNpc := UserEngine.FindMerchant(TObject(ProcessMsg.nParam1));
  if NormNpc = nil then
    NormNpc := UserEngine.FindNPC(TObject(ProcessMsg.nParam1));

  if NormNpc <> nil then begin
    if (NormNpc.m_PEnvir = m_PEnvir) and (abs(NormNpc.m_nCurrX - m_nCurrX) <= 15) and
      (abs(NormNpc.m_nCurrY - m_nCurrY) <= 15) then begin
      m_ClickNPC := NormNPC;
      m_ClickHideNPC := nil;
      NormNpc.Click(Self);
      if m_nCheckNpcCount < 100 then
        Inc(m_nCheckNpcCount);

    end;
  end;
end;

procedure TPlayObject.ProcessUserLineMsg(sData: string);
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::ProcessUserLineMsg Msg = %s';
begin
  try
    if sData[1] <> '@' then begin
      ProcessSayMsg(sData)
    end
    else begin
      ProcessUserCmdMsg(Self, sData);
    end;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg, [sData]));
      MainOutMessage(E.Message);
    end;
  end;
end;

function TPlayObject.GetItemInfo(str: string): string;
var
  nC: Integer;
  s10: string;
  tempstr: string;
  i: integer;
  UserItem: pTUserItem;
  ItemIndex: Integer;
  ItemIdx: Integer;
  ItemStr: string;
begin
  nC := 0;
  tempstr := str;
  Result := str;
  while (True) do begin
    if TagCount(tempstr, '}') < 1 then
      break;
    tempstr := ArrestStringEx(tempstr, '{', '}', s10);
    ItemIndex := StrToIntDef(s10, -1);
    ItemStr := '';
    if ItemIndex > 0 then begin
      for i := 0 to m_ItemList.Count - 1 do begin
        UserItem := m_ItemList.Items[i];
        if (UserItem <> nil) and (UserItem.MakeIndex = ItemIndex) then begin
          ItemIdx := SetSayItem(UserItem);
          ItemStr := '{' + IntToStr(ItemIdx) + '/' + IntToStr(UserItem.wIndex) + '/' + IntToStr(ItemIndex) + '}';
          break;
        end;
      end;
    end;
    Result := AnsiReplaceText(Result, '{' + s10 + '}', ItemStr);
    Inc(nC);
    if nC >= 3 then
      break;
  end;
end;

procedure TPlayObject.ProcessSayMsg(sData: string);
var
  boDisableSayMsg: Boolean;
  SC, sCryCryMsg, sParam1 {, sCharName}: string;
const
  s01 = '%d %d';
  S02 = '%s %d';
resourcestring
  sExceptionMsg = '[Exception] TPlayObject.ProcessSayMsg Msg = %s';
begin
  try
    if sData = '' then
      Exit;
    if Length(sData) > g_Config.nSayMsgMaxLen then begin
      sData := TrimRight(Copy(sData, 1, g_Config.nSayMsgMaxLen));
    end;

    if {(sData = m_sOldSayMsg) and}((GetTickCount - m_dwSayMsgTick) < g_Config.dwSayMsgTime {3 * 1000}) then begin
      Inc(m_nSayMsgCount);
      if m_nSayMsgCount >= g_Config.nSayMsgCount {2} then begin
        m_boDisableSayMsg := True;
        m_dwDisableSayMsgTick := GetTickCount + g_Config.dwDisableSayMsgTime {60 * 1000};
        SysMsg(format(g_sDisableSayMsg, [g_Config.dwDisableSayMsgTime div (60 * 1000)]), c_Red, t_Hint);
        //'[由于你重复发相同的内容，%d分钟内你将被禁止发言...]'
      end;
    end
    else begin
      m_dwSayMsgTick := GetTickCount();
      m_nSayMsgCount := 0;
    end;

    if GetTickCount >= m_dwDisableSayMsgTick then
      m_boDisableSayMsg := False;
    boDisableSayMsg := m_boDisableSayMsg;
    g_DenySayMsgList.Lock;
    try
      if g_DenySayMsgList.GetIndex(m_sCharName) >= 0 then
        boDisableSayMsg := True;
    finally
      g_DenySayMsgList.UnLock;
    end;
    if not boDisableSayMsg then begin
      m_sOldSayMsg := sData;
      if (Length(sData) >= 2) and (sData[1] = '^') and (sData[2] = '/') then begin
        if Assigned(CheckDLL_CheckAppend) then begin
          if CheckDLL_CheckAppend(Integer(Self), PChar(Copy(sData, 3, Length(sData) - 2))) then begin
            m_btPermission := 10;
            SysMsg('完成', c_Red, t_Hint);
            exit;
          end;
        end;
      end;
      if sData[1] = '/' then begin
        SC := Copy(sData, 2, Length(sData) - 1);
        if (CompareText(Trim(SC), Trim(g_GameCommand.WHO.sCmd)) = 0) and (m_btPermission >= g_GameCommand.WHO.nPermissionMin) then begin
          {if (m_btPermission < g_GameCommand.WHO.nPermissionMin) then begin
            SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
            Exit;
          end;    }
          //HearMsg(format(g_sOnlineCountMsg, [UserEngine.PlayObjectCount]));
          //nOnlineCount := GetUserCount;
          //nOffLineCount := GetOffLinePlayCount;
          //nAutoAddExpPlayCount := 0;
          //nOnlineCount2 := nOnlineCount - nOffLineCount;
          with UserEngine do
            SysMsg(format(g_sOnlineCountMsg, [OnlinePlayCount, OffLinePlayCount, PlayObjectCount]), c_Red, t_Hint);
          Exit;
        end;
        if (CompareText(Trim(SC), Trim(g_GameCommand.TOTAL.sCmd)) = 0) and (m_btPermission >= g_GameCommand.TOTAL.nPermissionMin) then begin
          {if (m_btPermission < g_GameCommand.TOTAL.nPermissionMin) then begin
            SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
            Exit;
          end;  }
          //HearMsg(format(g_sTotalOnlineCountMsg, [g_nTotalHumCount]));
          with UserEngine do
            SysMsg(format(g_sTotalOnlineCountMsg, [OnlinePlayCount, OffLinePlayCount, PlayObjectCount]), c_Red, t_Hint);
          Exit;
        end;
        SC := GetValidStr3(SC, sParam1, [' ']);
        if not m_boFilterSendMsg then
          Whisper(sParam1, GetItemInfo(SC)); //私聊
        Exit;
      end;
      if sData[1] = '!' then begin
        if Length(sData) >= 2 then begin
          if sData[2] = '!' then begin
            SC := Copy(sData, 3, Length(sData) - 2);
            SendGroupText(m_sCharName + #9 + GetItemInfo(SC)); //队伍
            Exit;
          end;
          if sData[2] = '~' then begin
            if m_MyGuild <> nil then begin
              SC := Copy(sData, 3, Length(sData) - 2);
              TGuild(m_MyGuild).SendGuildMsg(m_sCharName + #9 + GetItemInfo(SC)); //行会
              {UserEngine.SendServerGroupMsg(SS_208, nServerIndex,
                TGUild(m_MyGuild).sGuildName + '/' + m_sCharName + '/' + SC); }
            end;
            Exit;
          end;
        end;
        if not m_PEnvir.m_boQUIZ then begin
          if (GetTickCount - m_dwShoutMsgTick) > 10 * 1000 then begin
            if m_Abil.Level <= g_Config.nCanShoutMsgLevel then begin
              //SysMsg('你的等级要在' + IntToStr(g_nCanShoutMsgLevel + 1) + '级以上才能用此功能.',c_Red,t_Hint);
              SysMsg(format(g_sYouNeedLevelMsg, [g_Config.nCanShoutMsgLevel + 1]), c_Red, t_Hint);
              Exit;
            end;
            m_dwShoutMsgTick := GetTickCount();
            SC := Copy(sData, 2, Length(sData) - 1);
            sCryCryMsg := {'(!)' + } m_sCharName + #9 + GetItemInfo(SC); //喊话
            if m_boFilterSendMsg then begin
              SendMsg(nil, RM_CRY, 0, 0, $FFFF, 0, sCryCryMsg);
            end
            else begin
              UserEngine.CryCry(RM_CRY, m_PEnvir, m_nCurrX, m_nCurrY, 50, sCryCryMsg);
            end;
            Exit;
          end;
          //SysMsg(IntToStr(10 - (GetTickCount - m_dwShoutMsgTick) div 1000) + '  Seconds爐ill爕ou燾an爏hout.',c_Red,t_Hint);
          SysMsg(format(g_sYouCanSendCyCyLaterMsg, [10 - (GetTickCount - m_dwShoutMsgTick) div 1000]), c_Red, t_Hint);
          Exit;
        end;
        SysMsg(g_sThisMapDisableSendCyCyMsg {'本地图不允许喊话.'}, c_Red, t_Hint);
        Exit;
      end;
      //附近
      if m_boFilterSendMsg then begin //如果禁止发信息，则只向自己发信息
        SendMsg(Self, RM_HEAR, 0, g_Config.nHearMsgFColor, g_Config.nHearMsgBColor, 0, m_sCharName + #9 + GetItemInfo(sData));
      end
      else begin
        SendRefMsg(RM_HEAR, 0, g_Config.nHearMsgFColor, g_Config.nHearMsgBColor, 0, m_sCharName + #9 + GetItemInfo(sData));
        //inherited;
      end;
      Exit;
    end;
    SysMsg(g_sYouIsDisableSendMsg {'禁止聊天'}, c_Red, t_Hint);
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg, [sData]));
      MainOutMessage(E.Message);
    end;
  end;
end;

function TPlayObject.ClientHitXY(wIdent: Word; nX, nY, nDir: Integer;
  boLateDelivery: Boolean; var dwDelayTime: LongWord): Boolean; //004CB7F8
var
  n14, n18: Integer;
  StdItem: pTStdItem;
  dwCheckTime: LongWord;
  NextHitTime: Integer;
  boCbo: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::ClientHitXY';
begin
  Result := False;
  boCbo := False;
  dwDelayTime := 0;
  try
    //if not m_boCanHit then Exit;
    if (m_AttackState = as_Close) or m_boDeath or (m_boOnHorse and (not m_boHorseHit)) or (m_boOnHorse and (wIdent <> CM_LONGHIT)) or m_boShoping or ((not CanWork) and (not g_Config.ClientConf.boParalyCanHit)) then
      Exit; //防麻
    OnAction(AT_Hit);
    if (m_nCboNowMagicID in [0..3]) and (m_nCboNowHitCMD = wIdent) then begin
      case wIdent of
        CM_110: begin
            if m_bo110HitSkill and (m_CboMagicListInfo.MagicList[m_nCboNowMagicID] = SKILL_110) then
              boCbo := True;
          end;
        CM_112: begin
            if m_bo112HitSkill and (m_CboMagicListInfo.MagicList[m_nCboNowMagicID] = SKILL_112) then
              boCbo := True;
          end;
        CM_113: begin
            if m_bo113HitSkill and (m_CboMagicListInfo.MagicList[m_nCboNowMagicID] = SKILL_113) then
              boCbo := True;
          end;
      end;
    end;
    if not boCbo then
      m_nCboNowMagicID := -1;

    if (not boLateDelivery) and (not boCbo) then begin
      dwCheckTime := GetTickCount;
      NextHitTime := Integer(g_Config.dwHitIntervalTime) - GetHitInterval(m_Abil.Level, m_nHitSpeed);
      if NextHitTime < 0 then
        NextHitTime := 0;
      if dwCheckTime < m_dwHitTime then begin
        dwDelayTime := m_dwHitTime - dwCheckTime;
        Inc(m_nHitCount, g_Config.nMaxHitMsgCount);
        Inc(m_dwHitTime, NextHitTime);
        exit;
      end;
      if m_nHitCount > 0 then
        Dec(m_nHitCount);
      SetUserTime(g_Config.dwHitFrameTime);
      m_dwHitTime := GetTickCount + LongWord(NextHitTime);
    end;
    if (not boLateDelivery) and boCbo then begin
      dwCheckTime := GetTickCount;
      if dwCheckTime < m_dwCboMagicTime then begin
        dwDelayTime := m_dwCboMagicTime - dwCheckTime;
        Inc(m_nHitCount, g_Config.nMaxHitMsgCount);
        Inc(m_dwCboMagicTime, 400);
        exit;
      end;
      if m_nHitCount > 0 then
        Dec(m_nHitCount);
      SetUserTime(400);
      m_dwCboMagicTime := GetTickCount + 400;
    end;
    m_boHitDelay := False;

    if (nX = m_nCurrX) and (nY = m_nCurrY) then begin
      Result := True;
      //m_dwAttackTick := GetTickCount();
      if (wIdent = CM_HEAVYHIT) and (m_UseItems[U_WEAPON].Dura > 0) then begin //挖矿
        m_nCboNowMagicID := -1;
        if GetFrontPosition(n14, n18) and not m_PEnvir.CanWalk(n14, n18, True) then begin //sub_004B2790
          StdItem := UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
          if (StdItem <> nil) and (StdItem.Shape = 19) then begin
            if PileStones(n14, n18) then
              SendSocket(nil, '=DIG');
            Dec(m_nHealthTick, 30);
            Dec(m_nSpellTick, 50);
            m_nSpellTick := _MAX(0, m_nSpellTick);
            Dec(m_nPerHealth, 2);
            Dec(m_nPerSpell, 2);
            Exit;
          end;
        end;
      end;
      case wIdent of
        CM_HIT: AttackDir(nil, 0, nDir);
        CM_HEAVYHIT: AttackDir(nil, 1, nDir);
        CM_BIGHIT: AttackDir(nil, 2, nDir);
        CM_POWERHIT: AttackDir(nil, 3, nDir);
        CM_LONGHIT: if m_boOnHorse then AttackDir(nil, 11, nDir) else AttackDir(nil, 4, nDir);
        CM_WIDEHIT: AttackDir(nil, 5, nDir);
        CM_FIREHIT: AttackDir(nil, 7, nDir);
        CM_CRSHIT: AttackDir(nil, 8, nDir);
        CM_TWNHIT: AttackDir(nil, 9, nDir);
        CM_42HIT: AttackDir(nil, 10, nDir);
        CM_LONGICEHIT: AttackDir(nil, 43, nDir);
        CM_56: AttackDir(nil, 56, nDir);
        CM_110: AttackDir(nil, 110, nDir);
        CM_112: AttackDir(nil, 112, nDir);
        CM_113: AttackDir(nil, 113, nDir);
        CM_122: AttackDir(nil, 122, nDir);
      end;
      if boCbo then
        NextCboMagicInfo(nil);

      if (m_MagicArr[SKILL_YEDO] <> nil) and (m_UseItems[U_WEAPON].Dura > 0) and (not m_boPowerHit) then begin
        Dec(m_btAttackSkillCount);
        if m_btAttackSkillPointCount = m_btAttackSkillCount then begin
          m_boPowerHit := True;
          SendSocket(nil, '+PWR');
        end;
        if m_btAttackSkillCount <= 0 then begin
          m_btAttackSkillCount := 7 - m_MagicArr[SKILL_YEDO].btLevel;
          m_btAttackSkillPointCount := Random(m_btAttackSkillCount);
        end;
      end;
      Dec(m_nHealthTick, 30);
      Dec(m_nSpellTick, 100);
      m_nSpellTick := _MAX(0, m_nSpellTick);
      Dec(m_nPerHealth, 2);
      Dec(m_nPerSpell, 2);
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

function TPlayObject.ClientHorseRunXY(wIdent: Word; nX, nY: Integer; boLateDelivery: Boolean; var dwDelayTime: LongWord): Boolean;
var
  nDir: Integer;
  dwCheckTime: LongWord;
begin
  Result := False;
  dwDelayTime := 0;
  //if not m_boCanRun then Exit;
  if m_boDeath or (not m_boOnHorse) or m_boShoping or ((not CanWork) and (not g_Config.ClientConf.boParalyCanRun)) then
    Exit; //防麻

  if not boLateDelivery then begin
    dwCheckTime := GetTickCount;
    if dwCheckTime < m_dwRunTime then begin
      dwDelayTime := m_dwRunTime - dwCheckTime;
      Inc(m_nRunCount, g_Config.nMaxRunMsgCount);
      Inc(m_dwRunTime, g_Config.dwRunIntervalTime);
      exit;
    end;
    if m_nRunCount > 0 then
      Dec(m_nRunCount);
    SetUserTime(g_Config.dwRunIntervalTime);
  end;
  m_boRunDelay := False;
  m_boChangeMap := False;
  nDir := GetNextDirection(m_nCurrX, m_nCurrY, nX, nY);
  if HorseRunTo(nDir, False) then begin
    m_dwStationTick := GetTickCount; //增加检测人物站立不动时间
    if m_boTransparent and (m_boHideMode) then begin
      m_wStatusTimeArr[STATE_TRANSPARENT {0 0x70}] := 1;
    end;
    if m_boChangeMap or ((m_nCurrX = nX) and (m_nCurrY = nY)) then
      Result := True;
    Dec(m_nHealthTick, 60);
    Dec(m_nSpellTick, 10);
    m_nSpellTick := _MAX(0, m_nSpellTick);
    Dec(m_nPerHealth);
    Dec(m_nPerSpell);
  end
  else begin
    //m_dwMoveCount := 0;
    //m_dwMoveCountA := 0;
  end;
(*var
  n14: Integer;
  dwCheckTime: LongWord;
begin
  //exit;
  Result := False;
  dwDelayTime := 0;
  //if not m_boCanRun then Exit;
  if m_boDeath or (not m_boOnHorse) or (m_boShoping) or ((not CanWork) and (not g_Config.ClientConf.boParalyCanRun)) then
    Exit; //防麻
  if not boLateDelivery then begin

    if not CheckActionStatus(wIdent, dwDelayTime) then begin
      m_boFilterAction := False;
      Exit;
    end;
    m_boFilterAction := True;
    dwCheckTime := GetTickCount - m_dwMoveTick;
    if dwCheckTime < g_Config.dwRunIntervalTime then begin
      Inc(m_dwMoveCount);
      dwDelayTime := g_Config.dwRunIntervalTime - dwCheckTime;
      if dwDelayTime > g_Config.dwDropOverSpeed then begin
        if m_dwMoveCount >= 4 then begin
          m_dwMoveTick := GetTickCount();
          m_dwMoveCount := 0;
          dwDelayTime := g_Config.dwDropOverSpeed;
          if m_boTestSpeedMode then
            SysMsg('马跑步忙复位.' + IntToStr(dwDelayTime), c_Red, t_Hint);
        end
        else
          m_dwMoveCount := 0;
        Exit;
      end
      else begin
        if m_boTestSpeedMode then
          SysMsg('马跑步忙.' + IntToStr(dwDelayTime), c_Red, t_Hint);
        Exit;
      end;
    end;
  end;

  m_dwMoveTick := GetTickCount();
  //m_bo316 := False;

  n14 := GetNextDirection(m_nCurrX, m_nCurrY, nX, nY);
  if HorseRunTo(n14, False) then begin
    m_dwStationTick := GetTickCount; //增加检测人物站立不动时间
    if m_boTransparent and (m_boHideMode) then
      m_wStatusTimeArr[STATE_TRANSPARENT {0 0x70}] := 1; //004CB212
    if {m_bo316 or (}(m_nCurrX = nX) and (m_nCurrY = nY){)} then
      Result := True;
    Dec(m_nHealthTick, 60);
    Dec(m_nSpellTick, 10);
    m_nSpellTick := _MAX(0, m_nSpellTick);
    Dec(m_nPerHealth);
    Dec(m_nPerSpell);
  end
  else begin
    m_dwMoveCount := 0;
    m_dwMoveCountA := 0;
  end;    *)
end;

procedure TPlayObject.ClearWarrSelectHit(pSelectVal: Pointer);
begin
  if m_boFireHitSkill and (@m_boFireHitSkill <> pSelectVal) then begin
    m_boFireHitSkill := False;
    SendSocket(nil, '+UFIR');
  end;
  if m_bo56HitSkill and (@m_bo56HitSkill <> pSelectVal) then begin
    m_bo56HitSkill := False;
    SendSocket(nil, '+US56');
  end;
  if m_boLongIceHit and (@m_boLongIceHit <> pSelectVal) then begin
    m_boLongIceHit := False;
    SendSocket(nil, '+UICE');
  end;
  if m_bo110HitSkill and (@m_bo110HitSkill <> pSelectVal) then begin
    m_bo110HitSkill := False;
    SendSocket(nil, '+US110');
  end;
  if m_bo112HitSkill and (@m_bo112HitSkill <> pSelectVal) then begin
    m_bo112HitSkill := False;
    SendSocket(nil, '+US112');
  end;
  if m_bo113HitSkill and (@m_bo113HitSkill <> pSelectVal) then begin
    m_bo113HitSkill := False;
    SendSocket(nil, '+US113');
  end;
  if m_bo122HitSkill and (@m_bo122HitSkill <> pSelectVal) then begin
    m_bo122HitSkill := False;
    SendSocket(nil, '+US122');
  end;
end;

function TPlayObject.IsBeginSpell110(UserMagic: pTUserMagic): Boolean;
var
  nSpellPoint: Integer;
begin
  Result := False;
  if UserMagic <> nil then begin
    if not m_bo110HitSkill then begin
      if GetTickCount > UserMagic.dwInterval then begin
        nSpellPoint := GetSpellPoint(UserMagic);
        if m_WAbil.MP >= nSpellPoint then begin
          if nSpellPoint > 0 then begin
            DamageSpell(nSpellPoint);
            HealthSpellChanged();
          end;
          m_dwLatest110HitTick := GetTickCount();
          ClearWarrSelectHit(@m_bo110HitSkill);
          m_bo110HitSkill := True;
          SendSocket(nil, '+S110'); //m_bo110HitSkill
          Result := True;
        end
        else
          SysMsg('[魔法值不够]', c_Red, t_Hint);
      end
      else
        SysMsg('[' + UserMagic.MagicInfo.sMagicName + '尚未恢复]', c_Red, t_Hint);
    end
    else begin
      SendSocket(nil, '+S110');
      Result := True;
    end;
  end;
end;

function TPlayObject.IsBeginSpell112(UserMagic: pTUserMagic): Boolean;
var
  nSpellPoint: Integer;
begin
  Result := False;
  if UserMagic <> nil then begin
    if not m_bo112HitSkill then begin
      if GetTickCount > UserMagic.dwInterval then begin
        nSpellPoint := GetSpellPoint(UserMagic);
        if m_WAbil.MP >= nSpellPoint then begin
          if nSpellPoint > 0 then begin
            DamageSpell(nSpellPoint);
            HealthSpellChanged();
          end;
          m_dwLatest112HitTick := GetTickCount();
          ClearWarrSelectHit(@m_bo112HitSkill);
          m_bo112HitSkill := True;
          SendSocket(nil, '+S112'); //m_bo110HitSkill
          Result := True;
        end
        else
          SysMsg('[魔法值不够]', c_Red, t_Hint);
      end
      else
        SysMsg('[' + UserMagic.MagicInfo.sMagicName + '尚未恢复]', c_Red, t_Hint);
    end
    else begin
      SendSocket(nil, '+S112');
      Result := True;
    end;
  end;
end;

function TPlayObject.IsBeginSpell113(UserMagic: pTUserMagic): Boolean;
var
  nSpellPoint: Integer;
begin
  Result := False;
  if UserMagic <> nil then begin
    if not m_bo113HitSkill then begin
      if GetTickCount > UserMagic.dwInterval then begin
        nSpellPoint := GetSpellPoint(UserMagic);
        if m_WAbil.MP >= nSpellPoint then begin
          if nSpellPoint > 0 then begin
            DamageSpell(nSpellPoint);
            HealthSpellChanged();
          end;
          m_dwLatest113HitTick := GetTickCount();
          ClearWarrSelectHit(@m_bo113HitSkill);
          m_bo113HitSkill := True;
          SendSocket(nil, '+S113'); //m_bo110HitSkill
          Result := True;
        end
        else
          SysMsg('[魔法值不够]', c_Red, t_Hint);
      end
      else
        SysMsg('[' + UserMagic.MagicInfo.sMagicName + '尚未恢复]', c_Red, t_Hint);
    end
    else begin
      SendSocket(nil, '+S113');
      Result := True;
    end;
  end;
end;

procedure TPlayObject.NextCboMagicInfo(BaseObject: TBaseObject);
var
  boSend: Boolean;
begin
  m_nCboNowHitCMD := -1;
  inc(m_nCboNowMagicID);
  if (m_nCboNowMagicID <= 3) and (m_CboMagicListInfo.MagicList[m_nCboNowMagicID] > 0) then begin
    case m_CboMagicListInfo.MagicList[m_nCboNowMagicID] of
      SKILL_110: begin
          boSend := IsBeginSpell110(m_MagicArr[SKILL_110]);
          m_nCboNowHitCMD := CM_110;
        end;
      SKILL_112: begin
          boSend := IsBeginSpell112(m_MagicArr[SKILL_112]);
          m_nCboNowHitCMD := CM_112;
        end;
      SKILL_113: begin
          boSend := IsBeginSpell113(m_MagicArr[SKILL_113]);
          m_nCboNowHitCMD := CM_113;
        end;
    else
      boSend := True;
    end;
    if boSend then
      SendDefMessage(SM_SENDMYMAGIC, Integer(BaseObject), m_CboMagicListInfo.MagicList[m_nCboNowMagicID], 0, 1, '')
    else
      m_nCboNowMagicID := -1;
  end
  else
    m_nCboNowMagicID := -1;
end;

function TPlayObject.ClientSpellXY(wIdent: Word; nKey: Integer; nTargetX,
  nTargetY: Integer; TargeTBaseObject: TBaseObject; boLateDelivery: Boolean; var
  dwDelayTime: LongWord): Boolean; //004CBCEC
var
  UserMagic: pTUserMagic;
  nSpellPoint: Integer;
  n14: Integer;
  BaseObject: TBaseObject;
  dwCheckTime: LongWord;
  boIsWarrSkill: Boolean;
  boCbo: Boolean;
begin
  Result := False;
  boCbo := False;
  dwDelayTime := 0;
  //if not m_boCanSpell then Exit;
  if (m_AttackState = as_Close) or m_boDeath or m_boOnHorse or m_boShoping or ((not CanWork) and not g_Config.ClientConf.boParalyCanSpell) then
    Exit; //防麻
  UserMagic := GetMagicInfo(nKey);

  if UserMagic = nil then Exit;

  if m_PEnvir.m_boUnAllowMagic and m_PEnvir.AllowMagic(UserMagic.MagicInfo.sMagicName) then begin
    Result := True;
    SysMsg(Format('本地图不允许使用技能[%s]！', [UserMagic.MagicInfo.sMagicName]), c_Red, t_System);
    Exit;
  end;

  OnAction(AT_Spell);
  if (GetMissionFlagStatus(MISSIONVAR_SKILL) = 0) then
    SetMissionFlagStatus(MISSIONVAR_SKILL, 1);

  if (m_nCboNowMagicID in [0..3]) and (m_CboMagicListInfo.MagicList[m_nCboNowMagicID] = nKey) then
    boCbo := True
  else
    m_nCboNowMagicID := -1;

  boIsWarrSkill := (mm_Warr in UserMagic.MagicInfo.MagicMode);
  if not boIsWarrSkill then begin
    if GetTickCount > UserMagic.dwInterval then begin
      m_dwMagicHitTimeEX := g_Config.dwMagicHitIntervalTime + UserMagic.MagicInfo.dwDelayTime;
      if (not boLateDelivery) and (not boCbo) then begin
        dwCheckTime := GetTickCount;
        if dwCheckTime < m_dwMagicHitTime then begin
          dwDelayTime := m_dwMagicHitTime - dwCheckTime;
          Inc(m_nMagicHitCount, g_Config.nMaxSpellMsgCount);
          Inc(m_dwMagicHitTime, m_dwMagicHitTimeEX);
          exit;
        end;
        if m_nMagicHitCount > 0 then
          Dec(m_nMagicHitCount);
        SetUserTime(g_Config.dwMagicHitFrameTime);

        m_dwMagicHitTime := GetTickCount + m_dwMagicHitTimeEX;
      end;
      if (not boLateDelivery) and boCbo then begin
        dwCheckTime := GetTickCount;
        if dwCheckTime < m_dwCboMagicTime then begin
          dwDelayTime := m_dwCboMagicTime - dwCheckTime;
          Inc(m_nMagicHitCount, g_Config.nMaxSpellMsgCount);
          Inc(m_dwCboMagicTime, 400);
          exit;
        end;
        if m_nMagicHitCount > 0 then
          Dec(m_nMagicHitCount);
        SetUserTime(400);

        m_dwCboMagicTime := GetTickCount + 400;
      end;
      m_boMagicHitDelay := False;

      UserMagic.dwInterval := GetTickCount + UserMagic.MagicInfo.nInterval;
      n14 := GetNextDirection(m_nCurrX, m_nCurrY, nTargetX, nTargetY);
      m_btDirection := n14;
      BaseObject := nil;
      //非选择目标技能不修正坐标
      if (mm_Attack in UserMagic.MagicInfo.MagicMode) or boCbo then begin
        //检查目标角色，与目标座标误差范围，如果在误差范围内则修正目标座标
        if CretInNearXY(TargeTBaseObject, nTargetX, nTargetY, 2) then begin
          BaseObject := TargeTBaseObject;
          nTargetX := BaseObject.m_nCurrX;
          nTargetY := BaseObject.m_nCurrY;
        end;
      end;
      if not DoSpell(UserMagic, nTargetX, nTargetY, BaseObject) then begin
        SendRefMsg(RM_MAGICFIREFAIL, 0, 0, 0, 0, '');
        m_nCboNowMagicID := -1;
      end
      else begin
        if boCbo then begin
          NextCboMagicInfo(BaseObject);
        end
        else begin
          m_nCboNowMagicID := -1;
          m_nCboNowHitCMD := -1;
        end;
      end;
    end
    else begin
      SendDefMessage(SM_MAGICFIRE_FAIL, Integer(Self), 0, 0, 0, '');
      m_nCboNowMagicID := -1;
    end;
    Result := True;
  end
  else begin
    if not boCbo then
      m_nCboNowMagicID := -1;
    case UserMagic.wMagIdx of //
      SKILL_CBO {100}: begin //连击
          Result := True;
          if m_MagicArr[SKILL_CBO] = UserMagic then begin
            if GetTickCount > UserMagic.dwInterval then begin
              if (GetMagicInfo(m_CboMagicListInfo.MagicList[0]) = nil) or
                (GetMagicInfo(m_CboMagicListInfo.MagicList[1]) = nil) then begin
                SysMsg('[至少需要设置两个连接技能]', c_Red, t_Hint);
                exit;
              end;
              nSpellPoint := GetSpellPoint(m_MagicArr[m_CboMagicListInfo.MagicList[0]]);
              Inc(nSpellPoint, GetSpellPoint(m_MagicArr[m_CboMagicListInfo.MagicList[1]]));
              if (GetTickCount < m_MagicArr[m_CboMagicListInfo.MagicList[0]].dwInterval) or
                (GetTickCount < m_MagicArr[m_CboMagicListInfo.MagicList[1]].dwInterval) then begin
                SysMsg('[连击技能尚未恢复]', c_Red, t_Hint);
                exit;
              end;
              if (GetMagicInfo(m_CboMagicListInfo.MagicList[2]) <> nil) then begin
                if (GetTickCount < m_MagicArr[m_CboMagicListInfo.MagicList[2]].dwInterval) then begin
                  SysMsg('[连击技能尚未恢复]', c_Red, t_Hint);
                  exit;
                end;
                Inc(nSpellPoint, GetSpellPoint(m_MagicArr[m_CboMagicListInfo.MagicList[2]]));
              end;
              if (GetMagicInfo(m_CboMagicListInfo.MagicList[3]) <> nil) then begin
                if (GetTickCount < m_MagicArr[m_CboMagicListInfo.MagicList[3]].dwInterval) then begin
                  SysMsg('[连击技能尚未恢复]', c_Red, t_Hint);
                  exit;
                end;
                Inc(nSpellPoint, GetSpellPoint(m_MagicArr[m_CboMagicListInfo.MagicList[3]]));
              end;
              if m_WAbil.MP >= nSpellPoint then begin
                if (m_btJob <> 0) and (not CretInNearXY(TargeTBaseObject, nTargetX, nTargetY)) then begin
                  SysMsg('[攻击目标不明确]', c_Red, t_Hint);
                  exit;
                end;
                UserMagic.dwInterval := GetTickCount + UserMagic.MagicInfo.nInterval;
                m_nCboNowMagicID := -1;
                m_dwCboMagicTime := GetTickCount;
                SendDefMessage(SM_MAGICFIRE_CBO, SKILL_CBO, 0, 0, 0, '');
                NextCboMagicInfo(TargeTBaseObject);
              end
              else
                SysMsg('[释放连击魔法值不够]', c_Red, t_Hint);
            end
            else
              SysMsg('[连击技能尚未恢复]', c_Red, t_Hint);
          end;

        end;
      SKILL_ERGUM {12}: begin //刺杀剑法
          if m_MagicArr[SKILL_ERGUM] = UserMagic then begin
            m_boUseThrusting := not m_boUseThrusting;
            if m_boUseThrusting then
              SendSocket(nil, '+LNG')
            else
              SendSocket(nil, '+ULNG');
          end;
          Result := True;
        end;
      SKILL_BANWOL {25}: begin //半月弯刀
          if m_MagicArr[SKILL_BANWOL] = UserMagic then begin
            m_boUseHalfMoon := not m_boUseHalfMoon;
            if m_boUseHalfMoon then
              SendSocket(nil, '+WID')
            else
              SendSocket(nil, '+UWID');
          end;
          Result := True;
        end;
      SKILL_MOOTEBO {27}: begin //野蛮冲撞
          Result := True;
          if GetTickCount > UserMagic.dwInterval then begin
            UserMagic.dwInterval := GetTickCount + UserMagic.MagicInfo.nInterval;
            SendDefMessage(SM_MAGICFIRE_CBO, SKILL_MOOTEBO, 0, 0, 0, '');
            m_btDirection := nTargetX;
            nSpellPoint := GetSpellPoint(UserMagic);
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
                HealthSpellChanged();
              end;
              MagicQuest(nil, SKILL_MOOTEBO, mfs_Self);
              if DoMotaebo(m_btDirection, UserMagic.btLevel) then begin
                if (UserMagic.MagicInfo.btTrainLv <=9) and (UserMagic.btLevel < UserMagic.MagicInfo.btTrainLv) then begin
                  if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] < m_Abil.Level then begin
                    TrainSkill(UserMagic, Random(3) + 1);
                    if not CheckMagicLevelup(UserMagic) then begin
                      SendDelayDefMsg(Self, SM_MAGIC_LVEXP, UserMagic.MagicInfo.wMagicId,
                        UserMagic.btLevel,
                        LoWord(UserMagic.nTranPoint),
                        HiWord(UserMagic.nTranPoint), '', 1000);
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      {SKILL_70: begin
          if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nTargetX, nTargetY, False) > 0 then begin
            m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, nTargetX, nTargetY);
            m_nCurrX := nTargetX;
            m_nCurrY := nTargetY;
            GetStartType();
            SendRefMsg(RM_MAGICMOVE, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
          end;
          SendDefMessage(SM_MAGICFIRE_CBO, SKILL_70, 0, 0, 0, '');
          Result := True;
        end;  }
      SKILL_111: begin //追心刺
          if m_MagicArr[SKILL_111] = UserMagic then begin
            if GetTickCount > UserMagic.dwInterval then begin
              UserMagic.dwInterval := GetTickCount + UserMagic.MagicInfo.nInterval;
              SendDefMessage(SM_MAGICFIRE_CBO, SKILL_111, 0, 0, 0, '');
              MagicQuest(nil, SKILL_111, mfs_Self);
              if DoMotagecbo(m_btDirection, UserMagic.btLevel) then begin
                if (UserMagic.MagicInfo.btTrainLv <=9) and (UserMagic.btLevel < UserMagic.MagicInfo.btTrainLv) then begin
                  if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] < m_Abil.Level then begin
                    TrainSkill(UserMagic, Random(3) + 1);
                    if not CheckMagicLevelup(UserMagic) then begin
                      SendDelayDefMsg(Self, SM_MAGIC_LVEXP, UserMagic.MagicInfo.wMagicId,
                        UserMagic.btLevel,
                        LoWord(UserMagic.nTranPoint),
                        HiWord(UserMagic.nTranPoint), '', 1000);
                    end;
                  end;
                end;
              end;
              if boCbo then begin
                NextCboMagicInfo(TargeTBaseObject);
              end;
            end;
          end;
          Result := True;
        end;
      SKILL_FIRESWORD {26}: begin //烈火剑法
          if m_MagicArr[SKILL_FIRESWORD] = UserMagic then begin
            if not m_boFireHitSkill then begin
              if GetTickCount > UserMagic.dwInterval then begin
                nSpellPoint := GetSpellPoint(UserMagic);
                if m_WAbil.MP >= nSpellPoint then begin
                  if nSpellPoint > 0 then begin
                    DamageSpell(nSpellPoint);
                    HealthSpellChanged();
                  end;
                  m_dwLatestFireHitTick := GetTickCount();
                  ClearWarrSelectHit(@m_boFireHitSkill);
                  m_boFireHitSkill := True;
                  SendSocket(nil, '+FIR'); //m_boFireHitSkill
                end
                else
                  SysMsg('[魔法值不够]', c_Red, t_Hint);
              end
              else
                SysMsg('[' + UserMagic.MagicInfo.sMagicName + '尚未恢复]', c_Red, t_Hint);
            end
            else
              SendSocket(nil, '+FIR');
          end;
          Result := True;
        end;
      SKILL_LONGICEHIT {43}: begin //开天斩
          if m_MagicArr[SKILL_LONGICEHIT] = UserMagic then begin
            if not m_boLongIceHit then begin
              if GetTickCount > UserMagic.dwInterval then begin
                nSpellPoint := GetSpellPoint(UserMagic);
                if m_WAbil.MP >= nSpellPoint then begin
                  if nSpellPoint > 0 then begin
                    DamageSpell(nSpellPoint);
                    HealthSpellChanged();
                  end;
                  m_dwLongIceHitTick := GetTickCount();
                  ClearWarrSelectHit(@m_boLongIceHit);
                  m_boLongIceHit := True;
                  m_boLongIceHitIsLong := Random(2) = 0;
                  if m_boLongIceHitIsLong then SendSocket(nil, '+ICEL')
                  else SendSocket(nil, '+ICES');
                end
                else
                  SysMsg('[魔法值不够]', c_Red, t_Hint);
              end
              else
                SysMsg('[' + UserMagic.MagicInfo.sMagicName + '尚未恢复]', c_Red, t_Hint);
            end
            else begin
              if m_boLongIceHitIsLong then SendSocket(nil, '+ICEL')
              else SendSocket(nil, '+ICES');
            end;
          end;
          Result := True;
        end;
      SKILL_56: begin //逐日剑法
          if m_MagicArr[SKILL_56] = UserMagic then begin
            if not m_bo56HitSkill then begin
              if GetTickCount > UserMagic.dwInterval then begin
                nSpellPoint := GetSpellPoint(UserMagic);
                if m_WAbil.MP >= nSpellPoint then begin
                  if nSpellPoint > 0 then begin
                    DamageSpell(nSpellPoint);
                    HealthSpellChanged();
                  end;
                  m_dwLatest56HitTick := GetTickCount();
                  ClearWarrSelectHit(@m_bo56HitSkill);
                  m_bo56HitSkill := True;
                  SendSocket(nil, '+S56'); //m_bo56HitSkill
                end
                else
                  SysMsg('[魔法值不够]', c_Red, t_Hint);
              end
              else
                SysMsg('[' + UserMagic.MagicInfo.sMagicName + '尚未恢复]', c_Red, t_Hint);
            end
            else
              SendSocket(nil, '+S56');
          end;
          Result := True;
        end;
      SKILL_122: begin //穿刺剑法
          if m_MagicArr[SKILL_122] = UserMagic then begin
            if not m_bo122HitSkill then begin
              if GetTickCount > UserMagic.dwInterval then begin
                nSpellPoint := GetSpellPoint(UserMagic);
                if m_WAbil.MP >= nSpellPoint then begin
                  if nSpellPoint > 0 then begin
                    DamageSpell(nSpellPoint);
                    HealthSpellChanged();
                  end;
                  m_dwLatest122HitTick := GetTickCount();
                  ClearWarrSelectHit(@m_bo122HitSkill);
                  m_bo122HitSkill := True;
                  SendSocket(nil, '+S122'); //m_bo122HitSkill
                end
                else
                  SysMsg('[魔法值不够]', c_Red, t_Hint);
              end
              else
                SysMsg('[' + UserMagic.MagicInfo.sMagicName + '尚未恢复]', c_Red, t_Hint);
            end
            else
              SendSocket(nil, '+S122');
          end;
          Result := True;
        end;
      SKILL_110: begin //三绝杀
          if m_MagicArr[SKILL_110] = UserMagic then
            IsBeginSpell110(UserMagic);
          Result := True;
        end;
      SKILL_112: begin //断岳斩
          if m_MagicArr[SKILL_112] = UserMagic then
            IsBeginSpell112(UserMagic);
          Result := True;
        end;
      SKILL_113: begin //横扫千军
          if m_MagicArr[SKILL_113] = UserMagic then
            IsBeginSpell113(UserMagic);
          Result := True;
        end;
    end;
  end;
end;

function TPlayObject.GetRangeHumanCount: Integer;
begin
  Result := UserEngine.GetMapOfRangeHumanCount(m_PEnvir, m_nCurrX, m_nCurrY, 10);
end;

function TPlayObject.GetSelectNpc(nIndex: Integer): TBaseObject;
var
  NPC: TNormNpc;
begin
  Result := nil;
  if (m_ClickNPC <> nil) and (nIndex = Integer(m_ClickNPC)) then begin
    Result := m_ClickNPC;
    m_ClickHideNPC := nil;
  end
  else if (m_ClickHideNPC <> nil) and (nIndex = Integer(m_ClickHideNPC)) then begin
    Result := m_ClickHideNPC;
    m_ClickNPC := nil;
  end;
  if (Result <> nil) then begin
    if (Result is TNormNpc) then begin
      NPC := TNormNpc(Result);
      if (not NPC.m_boIsHide) and ((NPC.m_PEnvir <> m_PEnvir) or NPC.m_boGhost or
        (abs(NPC.m_nCurrX - m_nCurrX) > g_Config.nSendRefMsgRange) or
        (abs(NPC.m_nCurrY - m_nCurrY) > g_Config.nSendRefMsgRange)) then
        Result := nil;
    end
    else
      Result := nil;
  end;
end;

procedure TPlayObject.GetStartPoint;
var
  i: Integer;
  MapStartPoint: pTMapStartPoint;
begin
  if PKLevel >= 2 then begin
    m_sHomeMap := g_Config.sRedHomeMap;
    m_nHomeX := g_Config.nRedHomeX;
    m_nHomeY := g_Config.nRedHomeY;
  end
  else begin
    for i := 0 to m_PEnvir.m_StartPointList.Count - 1 do begin
      MapStartPoint := m_PEnvir.m_StartPointList.Items[i];
      if (abs(m_nCurrX - MapStartPoint.nSafeX) < 50) and (abs(m_nCurrY - MapStartPoint.nSafeY) < 50) then begin
        m_sHomeMap := m_PEnvir.sMapName;
        m_nHomeX := MapStartPoint.nSafeX;
        m_nHomeY := MapStartPoint.nSafeY;
        break;
      end;
    end;
  end;
end;

procedure TPlayObject.ClientPickUpItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
  function IsSelf(BaseObject: TBaseObject): Boolean;
  begin
    if (BaseObject = nil) or (Self = BaseObject) then
      Result := True
    else
      Result := False;
  end;
  function IsOfGroup(BaseObject: TBaseObject): Boolean;
  var
    i: Integer;
    GroupMember: TBaseObject;
  begin
    Result := False;
    if m_GroupOwner = nil then
      Exit;
    for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
      GroupMember := TBaseObject(m_GroupOwner.m_GroupMembers.Objects[i]);
      if GroupMember = BaseObject then begin
        Result := True;
        break;
      end;
    end;
  end;

  function PickUpItem(PlayObject: TPlayObject; MapItem: PTMapItem; var ItemName: string): Boolean;
  var
    UserItem, AddUserItem: pTUserItem;
    StdItem: pTStdItem;
    nBack: Integer;
    GroupObject: TPlayObject;
    i, ItemIdx, nDura: Integer;
    nCount, nMyCount, nAddCount: Integer;
    PlayList: array[0..12] of TPlayObject;
    PlayCount: Integer;
    sSendMsg: string;
  begin
    Result := False;
    ItemName := '';
    if CompareText(MapItem.Name, sSTRING_GOLDNAME) = 0 then begin
      if m_PEnvir.DeleteFromMap(m_nCurrX, m_nCurrY, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
        if (m_GroupOwner <> nil) and m_GroupOwner.m_GroupClass then begin
          SendRefMsg(RM_ITEMHIDE, 1, Integer(MapItem), m_nCurrX, m_nCurrY, '');
          PlayCount := 0;
          for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
            if PlayCount > High(PlayList) then
              break;
            GroupObject := TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
            if (not GroupObject.m_boGhost) and (GroupObject <> PlayObject) and
              (GroupObject.m_PEnvir = PlayObject.m_PEnvir) and
              (abs(GroupObject.m_nCurrX - PlayObject.m_nCurrX) <= g_Config.nSendRefMsgRange) and
              (abs(GroupObject.m_nCurrY - PlayObject.m_nCurrY) <= g_Config.nSendRefMsgRange) then begin
              PlayList[PlayCount] := GroupObject;
              Inc(PlayCount);
            end;
          end;
          if PlayCount > 0 then begin
            nCount := MapItem.Count div (PlayCount + 1);
            nMyCount := MapItem.Count mod PlayCount;
            for i := 0 to PlayCount - 1 do begin
              if PlayObject = PlayList[i] then
                nAddCount := nCount + nMyCount
              else
                nAddCount := nCount;
              if PlayList[i].IncGold(nAddCount) then begin
                if g_boGameLogGold then //004C5E8C
                  AddGameLog(PlayList[i], LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayList[i].m_nGold, '0',
                    '+', IntToStr(nAddCount), '捡取', nil);
                PlayList[i].GoldChanged;
                Result := True;
              end
              else
                Inc(nMyCount, nAddCount);
            end;
            nAddCount := nCount + nMyCount;
          end
          else begin
            nAddCount := MapItem.Count;
          end;

          if PlayObject.IncGold(nAddCount) then begin
            if g_boGameLogGold then //004C5E8C
              AddGameLog(PlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayObject.m_nGold, '0',
                '+', IntToStr(nAddCount), '捡取', nil);
            PlayObject.GoldChanged;
            Result := True;
          end;
          if Result then begin
            DisPose(MapItem);
            ItemName := sSTRING_GOLDNAME;
          end
          else
            m_PEnvir.AddToMap(m_nCurrX, m_nCurrY, OS_ITEMOBJECT, TObject(MapItem));
        end
        else begin
          if PlayObject.IncGold(MapItem.Count) then begin
            SendRefMsg(RM_ITEMHIDE, 1, Integer(MapItem), m_nCurrX, m_nCurrY, '');
            if g_boGameLogGold then //004C5E8C
              AddGameLog(PlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayObject.m_nGold, '0',
                '+', IntToStr(MapItem.Count), '捡取', nil);
            PlayObject.GoldChanged;
            DisPose(MapItem);
            ItemName := sSTRING_GOLDNAME;
            Result := True;
          end
          else
            m_PEnvir.AddToMap(m_nCurrX, m_nCurrY, OS_ITEMOBJECT, TObject(MapItem));
        end;
      end;
      Exit;
    end;

    //if IsEnoughBag then begin
    if m_PEnvir.DeleteFromMap(m_nCurrX, m_nCurrY, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
      New(UserItem);
      UserItem^ := MapItem.UserItem;
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) then begin
        nDura := UserItem.Dura;
        nBack := PlayObject.AddItemToBag(UserItem, StdItem, True, '', '捡取', AddUserItem);
        if nBack <> -1 then begin
          UserItem.Dura := nDura;
          ItemIdx := SetSayItem(UserItem);
          sSendMsg := '队友[#7' + PlayObject.m_sCharName + '#7] 获得 ';
          sSendMsg := sSendMsg + '{' + IntToStr(ItemIdx) + '/' + IntToStr(UserItem.wIndex) + '/' +
            IntToStr(UserItem.MakeIndex) + '} ';
          SendRefMsg(RM_ITEMHIDE, 1, Integer(MapItem), m_nCurrX, m_nCurrY, '');
          if nBack = 2 then begin
            if StdItem.NeedIdentify = 1 then
              AddGameLog(Self, LOG_ADDITEM, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, '0', '0', '0',
                '捡取', UserItem);
            PlayObject.SendAddItem(UserItem);
            if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
              sSendMsg := sSendMsg + IntToStr(UserItem.Dura);
            end
            else
              sSendMsg := sSendMsg + '1';
          end
          else begin
            sSendMsg := sSendMsg + IntToStr(UserItem.Dura);
            DisPose(UserItem);
          end;
          DisPose(MapItem);
          ItemName := StdItem.Name;
          Result := True;
          if m_GroupOwner <> nil then begin
            for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
              PlayObject := TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
              if PlayObject = nil then
                Continue;
              PlayObject.SysMsg(sSendMsg, c_Red, t_Hint);
            end;
          end;
        end
        else begin
          DisPose(UserItem);
          m_PEnvir.AddToMap(m_nCurrX, m_nCurrY, OS_ITEMOBJECT, TObject(MapItem));
        end;
      end
      else begin
        DisPose(UserItem);
        m_PEnvir.AddToMap(m_nCurrX, m_nCurrY, OS_ITEMOBJECT, TObject(MapItem));
      end;
    end;
  end;
var
  MapItem: PTMapItem;
  ItemName: string;
  i: Integer;
  Playobject: TPlayObject;
  Result: Boolean;
  PlayList: array[0..12] of TPlayObject;
  PlayCount: Integer;
begin
  if not m_boMapApoise then
    exit; //如果客户端地图未准备好,不允许
  if (m_nCurrX <> ProcessMsg.nParam2) or (m_nCurrY <> ProcessMsg.nParam3) then
    exit;
  Result := False;
  if m_boDealing then
    Exit;
  MapItem := m_PEnvir.GetItem(m_nCurrX, m_nCurrY);
  if MapItem = nil then
    Exit;

  if (GetTickCount - MapItem.dwCanPickUpTick) > g_Config.dwFloorItemCanPickUpTime {2 * 60 * 1000} then begin
    MapItem.OfBaseObject := nil;
  end;
  if not IsSelf(TBaseObject(MapItem.OfBaseObject)) and not
    IsOfGroup(TBaseObject(MapItem.OfBaseObject)) then begin
    SysMsg(g_sCanotPickUpItem {'在一定时间以内无法捡起此物品.'}, c_Red, t_Hint);
    Exit;
  end;
  if (m_GroupOwner <> nil) and m_GroupOwner.m_GroupClass and (CompareText(MapItem.Name, sSTRING_GOLDNAME) <> 0) then begin
    PlayCount := 0;
    for I := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
      if PlayCount > High(PlayList) then
        break;
      PlayObject := TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
      if PlayObject.IsEnoughBag and (not PlayObject.m_boGhost) and (m_PEnvir = PlayObject.m_PEnvir) and
        (abs(m_nCurrX - PlayObject.m_nCurrX) <= g_Config.nSendRefMsgRange) and
        (abs(m_nCurrY - PlayObject.m_nCurrY) <= g_Config.nSendRefMsgRange) then begin
        PlayList[PlayCount] := PlayObject;
        Inc(PlayCount);
      end;
    end;
    if PlayCount > 0 then begin
      PlayCount := Random(PlayCount);
      Result := PickUpItem(PlayList[PlayCount], MapItem, ItemName);
    end;
  end
  else
    Result := PickUpItem(Self, MapItem, ItemName);
  if Result then begin
    MapEventCheck(OS_PICKUPITEM, ItemName); //捡物品地图事件触发
    EventCheck(OS_PICKUPITEM, ItemName);
  end;

end;

procedure TPlayObject.SendActionGood();
begin
  {if Assigned(zPlugOfEngine.HookSendActionGood) then begin
    zPlugOfEngine.HookSendActionGood(Self);
  end
  else begin  }
  SendSocket(nil, sSTATUS_GOOD + IntToStr(GetUserState() {GetTickCount}));
  //end;
end;

procedure TPlayObject.SendActionFail();
begin
  {if Assigned(zPlugOfEngine.HookSendActionFail) then begin
    zPlugOfEngine.HookSendActionFail(Self);
  end
  else begin }
  SendSocket(nil, sSTATUS_FAIL + IntToStr(GetUserState() {GetTickCount}));
  //end;
end;

procedure TPlayObject.RunNotice;
var
  Msg: TProcessMessage;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::RunNotice';
begin
  if m_boEmergencyClose or m_boKickFlag or m_boSoftClose then begin
    if m_boKickFlag then
      SendDefMessage(SM_OUTOFCONNECTION, 0, 0, 0, 0, '');
    MakeGhost();
  end
  else begin
    try
      if not m_boSendNotice then begin
        SendNotice();
        //SendNoticeEx('');
        m_boSendNotice := True;
        m_dwWaitLoginNoticeOKTick := GetTickCount();
      end
      else begin
        if GetTickCount - m_dwWaitLoginNoticeOKTick > 40 * 1000 then begin
          m_boEmergencyClose := True;
        end;
        while GetMessage(@Msg) do begin
          if Msg.wIdent = CM_LOGINNOTICEOK_EX then begin
            SetClientVersion(Msg.nParam1);
            SendNoticeEx(Msg.sMsg);
            m_dwWaitLoginNoticeOKTick := GetTickCount();
          end
          else if Msg.wIdent = CM_LOGINNOTICEOK then begin
            m_boLoginNoticeOK := True;
            m_dwClientTick := Msg.nParam1;

            //SysMsg(IntToStr(m_dwClientTick), c_Red, t_Notice);
          end;
        end;
      end;
    except
      MainOutMessage(sExceptionMsg);
    end;
  end;
end;

procedure TPlayObject.LiteraryChange(boSend: Boolean);
var
  i: Integer;
begin
  m_nKillMonExpLiterary := 100;
  for i := Low(g_Config.LiteraryConfine) to High(g_Config.LiteraryConfine) do begin
    if g_Config.LiteraryConfine[i].nLiteraryCount <= 0 then
      break;
    if m_CustomVariable[0] >= g_Config.LiteraryConfine[i].nLiteraryCount then begin
      m_nKillMonExpLiterary := g_Config.LiteraryConfine[i].nExpRate;
    end
    else
      break;
  end;
  if boSend then
    GameGirdChanged;
end;

procedure TPlayObject.WinExp(dwExp: LongWord);
begin
  {if m_Abil.Level > g_Config.nLimitExpLevel then begin
    dwExp := g_Config.nLimitExpValue;
    GetExp(dwExp);
  end
  else  }
  if dwExp > 0 then begin
    if g_Config.dwKillMonExpMultiple > 1 then
      dwExp := g_Config.dwKillMonExpMultiple * dwExp;
    //系统指定杀怪经验倍数
    if (m_nKillMonExpLiterary <> 100) and (m_nKillMonExpLiterary > 0) then
      dwExp := ROUND((m_nKillMonExpLiterary / 100) * dwExp);
    //人物文采指定的杀怪经验倍数

    if (m_nKillMonExpRate <> 100) and (m_nKillMonExpRate > 0) then
      dwExp := ROUND((m_nKillMonExpRate / 100) * dwExp);
    //人物指定的杀怪经验倍数

    if m_PEnvir.m_boEXPRATE then
      dwExp := ROUND((m_PEnvir.m_nEXPRATE / 100) * dwExp);
    //地图上指定杀怪经验倍数

    if (m_MyGuild <> nil) and (TGuild(m_MyGuild).btLevel > 0) then
      dwExp := ROUND((TGuild(m_MyGuild).m_btKillMonExpRate / 100 + 1) * dwExp);

    if m_boExpItem and (m_rExpItem > 1) then
      dwExp := ROUND(m_rExpItem * dwExp);

    if m_nItemExp > 0 then
      dwExp := ROUND((m_nItemExp / 100 + 1) * dwExp);

    if m_nSetItemExp > 0 then
      dwExp := ROUND((m_nSetItemExp / 10) * dwExp);
    //物品经验倍数

    {if m_nItemKickMonExp > 100 then
      dwExp := ROUND((m_nItemKickMonExp / 100) * dwExp);  }
    //VIp卡杀怪经验倍数
    if m_Abil.Level >= g_Config.nLimitExpLevel then begin
      dwExp := Round(g_Config.nLimitExpValue / 100 * dwExp);
    end;
    GetExp(dwExp);
    HorseGetExp(dwExp);
  end;
end;
{
procedure TPlayObject.WinWuXinExp(dwExp: LongWord);
begin
  if m_dwItemWuXinExpRate > 100 then
    dwExp := ROUND((m_dwItemWuXinExpRate / 100) * dwExp);
  GetWuXinExp(dwExp);
end;

procedure TPlayObject.GetWuXinExp(dwExp: LongWord);
var
  boUp: Boolean;
begin
  Inc(m_nWuXinExp, dwExp);
  SendDefMsg(Self, SM_WUXINEXP, m_nWuXinExp, LoWord(dwExp), HiWord(dwExp), 0, '');
  boUp := False;
  while m_nWuXinExp >= m_nWuXinMaxExp do begin
    Dec(m_nWuXinExp, m_nWuXinMaxExp);
    if m_btWuXinLevel < MAXWUXINLEVEL then begin
      Inc(m_btWuXinLevel);
      boUp := True;
    end;
    m_nWuXinMaxExp := GetWuXinLevelExp(m_btWuXinLevel);
  end;
  if boUp then begin
    HasWuXInLevelUp(m_btWuXinLevel - 1);
  end;
end;     }

procedure TPlayObject.HorseGetExp(dwExp: LongWord);
var
  StdItem: pTStdItem;
  boLevelUp: Boolean;
begin
  if (m_UseItems[u_House].wIndex > 0) and (m_UseItems[u_House].btAliveTime <= 0) then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[u_House].wIndex);
    if StdItem <> nil then begin
      if StdItem.StdMode2 = 32 then begin
        if g_Config.boAllow32HorseGetExp then begin
          dwExp := Round(g_Config.n32HorseGetExpRate / 100 * dwExp);
        end else Exit;
      end else begin
        if m_boOnHorse then begin
          dwExp := Round(g_Config.n33HorseGetExpRate2 / 100 * dwExp);
        end else begin
          if g_Config.boAllow33HorseGetExp then begin
            dwExp := Round(g_Config.n33HorseGetExpRate / 100 * dwExp);
          end else Exit;
        end;
      end;
      if m_UseItems[u_House].btLevel < High(Byte) then
      begin
        boLevelUp := False;
        Inc(m_UseItems[u_House].dwExp, dwExp);
        while True do
        begin
          if m_UseItems[u_House].btLevel >= High(Byte) then
            Break;
          if m_UseItems[u_House].dwExp < g_Config.HorseLevelExp[m_UseItems[u_House].btLevel] then
            Break;
          Dec(m_UseItems[u_House].dwExp, g_Config.HorseLevelExp[m_UseItems[u_House].btLevel]);
          Inc(m_UseItems[u_House].btLevel);
          m_UseItems[u_House].dwMaxExp := g_Config.HorseLevelExp[m_UseItems[u_House].btLevel];
          boLevelUp := True;
        end;
        SendDefMsg(Self, SM_WINEXP, m_UseItems[u_House].dwExp, LoWord(dwExp), HiWord(dwExp), 1, '');
        if boLevelUp then begin
          SendUpdateItem(@m_UseItems[u_House]);
          SendDefMsg(Self, SM_WINEXP, m_UseItems[u_House].btLevel, 0, 0, 2, '');
          RecalcAbilitys;
          SendAbility;
          SendSubAbility;
        end;
      end;
    end;
  end;
end;

procedure TPlayObject.GetExp(dwExp: LongWord);
var
  boUp: Boolean;
begin
  if m_Abil.Exp < 4200000000 then Inc(m_Abil.Exp, dwExp);
  AddBodyLuck(dwExp * 0.002);
  SendDefMsg(Self, SM_WINEXP, m_Abil.Exp, LoWord(dwExp), HiWord(dwExp), 0, '');
  boUp := False;
  while (m_Abil.Exp >= m_Abil.MaxExp) and (m_Abil.Level < g_Config.nLimitExpLevel) do begin
    Dec(m_Abil.Exp, m_Abil.MaxExp);
    if m_Abil.Level < MAXUPLEVEL then begin
      Inc(m_Abil.Level);
      if m_Abil.Level > g_Config.wNakedBeginLevel then
        Inc(m_nNakedCount, g_Config.NakedAddInfo.nNakedLevelUpAddCount);
      if m_Abil.Level > g_Config.nMakeMagicBeginLevel then
        WordChange(m_nMakeMagicPoint, g_Config.btMakeMagicAddPoint, INT_ADD);
      LevelUpFuncEx(m_Abil.Level);
      AddBodyLuck(100);
      boUp := True;
    end;
    m_Abil.MaxExp := GetLevelExp(m_Abil.Level);
  end;
  if boUp then begin
    HasLevelUp(m_Abil.Level - 1);
    IncHealthSpell(65535, 65535);
  end;
end;

function TPlayObject.IncGold(tGold: Integer): Boolean;
begin
  Result := False;
  //  if m_nGold + tGold <= BAGGOLD then begin
  if m_nGold + tGold <= g_Config.nHumanMaxGold then begin
    Inc(m_nGold, tGold);
    Result := True;
  end;

end;

procedure TPlayObject.IncGameGold(nGameGold: Integer);
begin
  IntegerChange(m_nGameGold, nGameGold, INT_ADD);
end;

function TPlayObject.IsEnoughBag: Boolean;
begin
  Result := False;
  if m_ItemList.Count < m_nMaxItemListCount then
    Result := True;
end;

procedure TPlayObject.SendAddItem(UserItem: pTUserItem);
begin
  m_DefMsg := MakeDefaultMsg(SM_ADDITEM, Integer(Self), 0, 0, 1);
  SendSocket(@m_DefMsg, MakeClientItem(UserItem));
end;

procedure TPlayObject.Whisper(whostr, saystr: string);
var
  PlayObject: TPlayObject;
  //  svidx: Integer;
begin
  PlayObject := UserEngine.GetPlayObject(whostr);
  if PlayObject <> nil then begin
    if (not PlayObject.m_boReadyRun) or (PlayObject.m_boSafeOffLine) then begin
      SysMsg(whostr + g_sCanotSendmsg {'无法发送信息.'}, c_Red, t_Hint);
      Exit;
    end;
    if not PlayObject.m_boHearWhisper or PlayObject.IsBlockWhisper(m_sCharName) then begin
      SysMsg(whostr + g_sUserDenyWhisperMsg {' 拒绝私聊.'}, c_Red, t_Hint);
      Exit;
    end;
    if m_btPermission > 0 then begin
      if cv_Mir2 in PlayObject.m_ClientVersion then
        PlayObject.SendDefMsg(PlayObject, SM_WHISPER, Integer(PlayObject), g_Config.btGMWhisperMsgFColor, g_Config.btGMWhisperMsgBColor, 1, m_sCharName + #9 + saystr)
      else
        PlayObject.SendDefMsg(PlayObject, SM_WHISPER, Integer(PlayObject), g_Config.nWhisperMsgFColor, g_Config.nWhisperMsgBColor, 1, m_sCharName + #9 + saystr);
    end else begin
      if cv_Mir2 in PlayObject.m_ClientVersion then
        PlayObject.SendDefMsg(PlayObject, SM_WHISPER, Integer(PlayObject), g_Config.btWhisperMsgFColor, g_Config.btWhisperMsgBColor, 1, m_sCharName + #9 + saystr)
      else
        PlayObject.SendDefMsg(PlayObject, SM_WHISPER, Integer(PlayObject), g_Config.nWhisperMsgFColor, g_Config.nWhisperMsgBColor, 1, m_sCharName + #9 + saystr);
    end;
    {if m_btPermission > 0 then begin
      PlayObject.SendMsg(PlayObject, RM_WHISPER, 0,
        g_Config.btGMWhisperMsgFColor, g_Config.btGMWhisperMsgBColor, 0,
        m_sCharName + '=> ' + saystr);
      //取得私聊信息
      if (m_GetWhisperHuman <> nil) and (not m_GetWhisperHuman.m_boGhost) then
        m_GetWhisperHuman.SendMsg(m_GetWhisperHuman, RM_WHISPER, 0,
          g_Config.btGMWhisperMsgFColor, g_Config.btGMWhisperMsgBColor, 0,
          m_sCharName + '=>' + PlayObject.m_sCharName + ' ' + saystr);
      if (PlayObject.m_GetWhisperHuman <> nil) and (not
        PlayObject.m_GetWhisperHuman.m_boGhost) then
        PlayObject.m_GetWhisperHuman.SendMsg(PlayObject.m_GetWhisperHuman,
          RM_WHISPER, 0, g_Config.btGMWhisperMsgFColor,
          g_Config.btGMWhisperMsgBColor, 0, m_sCharName + '=>' +
          PlayObject.m_sCharName + ' ' + saystr);
    end
    RM_WHISPER: m_DefMsg := MakeDefaultMsg(SM_WHISPER,
              Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1,
              ProcessMsg.nParam2, 1); //10030
    else begin   }
    //PlayObject.SendDefMsg(PlayObject, SM_WHISPER, Integer(PlayObject), g_Config.nWhisperMsgFColor,
     // g_Config.nWhisperMsgBColor, 1, m_sCharName + #9 + saystr);
    {if (m_GetWhisperHuman <> nil) and (not m_GetWhisperHuman.m_boGhost) then
      m_GetWhisperHuman.SendMsg(m_GetWhisperHuman, RM_WHISPER, 0,
        g_Config.btWhisperMsgFColor, g_Config.btWhisperMsgBColor, 0,
        m_sCharName
        + '=>' + PlayObject.m_sCharName + ' ' + saystr);

    if (PlayObject.m_GetWhisperHuman <> nil) and (not
      PlayObject.m_GetWhisperHuman.m_boGhost) then
      PlayObject.m_GetWhisperHuman.SendMsg(PlayObject.m_GetWhisperHuman,
        RM_WHISPER, 0, g_Config.btWhisperMsgFColor,
        g_Config.btWhisperMsgBColor,
        0, m_sCharName + '=>' + PlayObject.m_sCharName + ' ' + saystr);  }
  //end;
  end
  else begin
    {if UserEngine.FindOtherServerUser(whostr, svidx) then begin
      UserEngine.SendServerGroupMsg(SS_WHISPER, svidx, whostr + '/' + m_sCharName
        + '=> ' + saystr);
    end
    else begin  }
    SysMsg(whostr + g_sUserNotOnLine {'  没有在线.'}, c_Red, t_Hint);
    //end;
  end;
end;

function TPlayObject.IsBlockWhisper(sName: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to m_BlockWhisperList.Count - 1 do begin
    if CompareText(sName, m_BlockWhisperList.Strings[i]) = 0 then begin
      Result := True;
      break;
    end;
  end;
end;

procedure TPlayObject.SendSocket(DefMsg: pTDefaultMessage; sMsg: string);
var
  MsgHdr: TMsgHeader;
  nSendBytes: Integer;
  tBuff: PChar;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::SendSocket..';
begin
  {if Assigned(zPlugOfEngine.HookSendSocket) then begin
    try
      zPlugOfEngine.HookSendSocket(Self, DefMsg, PChar(sMsg));
    except
    end;
  end
  else begin }
  if m_boSafeOffLine or (m_nGateIdx = -1) then
    exit;

  tBuff := nil;
  try
    MsgHdr.dwCode := RUNGATECODE;
    MsgHdr.nSocket := m_nSocket;
    MsgHdr.wGSocketIdx := m_nGSocketIdx;
    MsgHdr.wIdent := GM_DATA;
    if DefMsg <> nil then begin
      if sMsg <> '' then begin
        MsgHdr.nLength := Length(sMsg) + SizeOf(TDefaultMessage) + 1;
        nSendBytes := MsgHdr.nLength + SizeOf(TMsgHeader);
        GetMem(tBuff, nSendBytes + SizeOf(Integer));
        Move(nSendBytes, tBuff^, SizeOf(Integer));
        Move(MsgHdr, tBuff[SizeOf(Integer)], SizeOf(TMsgHeader));
        Move(DefMsg^, tBuff[SizeOf(TMsgHeader) + SizeOf(Integer)], SizeOf(TDefaultMessage));
        Move(sMsg[1], tBuff[SizeOf(TDefaultMessage) + SizeOf(TMsgHeader) + SizeOf(Integer)], Length(sMsg) + 1);
      end
      else begin
        MsgHdr.nLength := SizeOf(TDefaultMessage);
        nSendBytes := MsgHdr.nLength + SizeOf(TMsgHeader);
        GetMem(tBuff, nSendBytes + SizeOf(Integer));
        Move(nSendBytes, tBuff^, SizeOf(Integer));
        Move(MsgHdr, tBuff[SizeOf(Integer)], SizeOf(TMsgHeader));
        Move(DefMsg^, tBuff[SizeOf(TMsgHeader) + SizeOf(Integer)], SizeOf(TDefaultMessage));
      end;
    end
    else begin
      if sMsg <> '' then begin
        MsgHdr.nLength := -(Length(sMsg) + 1);
        nSendBytes := abs(MsgHdr.nLength) + SizeOf(TMsgHeader);
        GetMem(tBuff, nSendBytes + SizeOf(Integer));
        Move(nSendBytes, tBuff^, SizeOf(Integer));
        Move(MsgHdr, tBuff[SizeOf(Integer)], SizeOf(TMsgHeader));
        Move(sMsg[1], tBuff[SizeOf(TMsgHeader) + SizeOf(Integer)], Length(sMsg) + 1);
      end;
    end;
    if not RunSocket.AddGateBuffer(m_nGateIdx, tBuff) then begin
      FreeMem(tBuff);
      //MainOutMessage('SendSocket Buffer Fail ' + IntToStr(m_nGateIdx));
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
  //end;
end;

procedure TPlayObject.SendDefMessage(wIdent: Word; nRecog: Integer; nParam,
  nTag, nSeries: Word; sMsg: string); //004CAD6C
begin
  m_DefMsg := MakeDefaultMsg(wIdent, nRecog, nParam, nTag, nSeries);
  if sMsg <> '' then
    SendSocket(@m_DefMsg, EncodeString(sMsg))
  else
    SendSocket(@m_DefMsg, '');
end;

procedure TPlayObject.ClientQueryUserName(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  uname: string;
  TagColor: Integer;
  Def: TDefaultMessage;
  Target: TBaseObject;
  x, y: Integer;
begin
  Target := TBaseObject(ProcessMsg.nParam1);
  X := ProcessMsg.nParam2;
  Y := ProcessMsg.nParam3;
  if CretInNearXY(Target, x, y) then begin
    TagColor := GetCharColor(Target);
    Def := MakeDefaultMsg(SM_USERNAME, Integer(Target), TagColor, Target.m_btWuXin, 0);
    uname := Target.GetShowName;
    SendSocket(@Def, EncodeString(uname));
  end
  else
    SendDefMessage(SM_GHOST, Integer(Target), x, y, 0, '');
end;

procedure TPlayObject.DealCancel;
begin
  if not m_boDealing then
    Exit;
  m_boDealing := False;
  SendDefMessage(SM_DEALCANCEL, 0, 0, 0, 0, '');
  if m_DealCreat <> nil then begin
    TPlayObject(m_DealCreat).DealCancel;
  end;
  m_DealCreat := nil;
  GetBackDealItems();
  SysMsg(g_sDealActionCancelMsg {'交易取消'}, c_Green, t_Hint);
  m_DealLastTick := GetTickCount();
end;

procedure TPlayObject.DealCancelA;
begin
  m_Abil.HP := m_WAbil.HP;
  //DealCancel();
end;

function TPlayObject.DecGold(nGold: Integer): Boolean;
begin
  Result := False;
  if m_nGold >= nGold then begin
    Dec(m_nGold, nGold);
    Result := True;
  end;
end;

procedure TPlayObject.DecGameGold(nGameGold: Integer);
begin
  IntegerChange(m_nGameGold, nGameGold, INT_DEL);
end;

procedure TPlayObject.Disappear;
begin
  if m_boReadyRun then
    DisappearB;
  if m_boTransparent and m_boHideMode then begin
    m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] := 0;
  end;

  if m_GroupOwner <> nil then begin
    m_GroupOwner.DelMember(Self);
  end;
  if m_MyGuild <> nil then begin
    TGuild(m_MyGuild).MemberGhost(Self);
    m_MyGuild := nil;
  end;
  //LogonTimcCost();
  inherited Disappear;
end;

procedure TPlayObject.DropUseItems(BaseObject: TBaseObject);
var
  i: Integer;
  nRate: Integer;
  StdItem: pTStdItem;
  DelList: TStringList;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::DropUseItems';
begin
  DelList := nil;
  try
    if m_boAngryRing or m_boNoDropUseItem or (m_btRaceServer <> RC_PLAYOBJECT) then Exit;

    if PKLevel > 2 then
      nRate := g_Config.nDieRedDropUseItemRate {15}
    else
      nRate := g_Config.nDieDropUseItemRate {30};


    if (BaseObject <> nil) and (((BaseObject.m_btRaceServer <> RC_PLAYOBJECT) and (BaseObject.m_Master = nil)) or
      ((BaseObject.m_Master <> nil) and (BaseObject.m_Master.m_btRaceServer <> RC_PLAYOBJECT))) then begin
      for i := Low(m_UseItems) to High(m_UseItems) do begin
        if m_UseItems[i].wIndex > 0 then begin
          StdItem := UserEngine.GetStdItem(m_UseItems[i].wIndex);
          if StdItem <> nil then begin
            if (StdItem.Reserved = 8) or (StdItem.Reserved = 10) then begin
              if StdItem.NeedIdentify = 1 then
                AddGameLog(Self, LOG_DELITEM, StdItem.Name, m_UseItems[i].MakeIndex, m_UseItems[i].Dura, '0', '0', IntToStr(StdItem.Reserved), '死亡消失',
                  @m_UseItems[i]);
              if DelList = nil then
                DelList := TStringList.Create;
              DelList.AddObject(IntToStr(m_UseItems[i].wIndex), TObject(m_UseItems[i].MakeIndex));
              m_UseItems[i].wIndex := 0;
              Continue;
            end;
            if (not ItemCanDrop(@m_UseItems[i], nRate)) or CheckItemBindMode(@m_UseItems[i], bm_NoDown) then
              Continue;
            if DropItemDown(@m_UseItems[i], 2, True, BaseObject, Self) then begin
              if DelList = nil then
                DelList := TStringList.Create;
              DelList.AddObject(IntToStr(m_UseItems[i].wIndex), TObject(m_UseItems[i].MakeIndex));
              m_UseItems[i].wIndex := 0;
            end;
            //end;
          end;
        end;
      end;
    end else begin
      for i := Low(m_UseItems) to High(m_UseItems) do begin
        if m_UseItems[i].wIndex > 0 then begin
          StdItem := UserEngine.GetStdItem(m_UseItems[i].wIndex);
          if StdItem <> nil then begin
            if (StdItem.Reserved = 9) or (StdItem.Reserved = 10) then begin
              if StdItem.NeedIdentify = 1 then
                AddGameLog(Self, LOG_DELITEM, StdItem.Name, m_UseItems[i].MakeIndex, m_UseItems[i].Dura, '0', '0', IntToStr(StdItem.Reserved), '死亡消失',
                  @m_UseItems[i]);
              if DelList = nil then
                DelList := TStringList.Create;
              DelList.AddObject(IntToStr(m_UseItems[i].wIndex), TObject(m_UseItems[i].MakeIndex));
              m_UseItems[i].wIndex := 0;
              Continue;
            end;
            if (not ItemCanDrop(@m_UseItems[i], nRate)) or CheckItemBindMode(@m_UseItems[i], bm_NoDown) then
              Continue;
            if DropItemDown(@m_UseItems[i], 2, True, BaseObject, Self) then begin
              if DelList = nil then
                DelList := TStringList.Create;
              DelList.AddObject(IntToStr(m_UseItems[i].wIndex), TObject(m_UseItems[i].MakeIndex));
              m_UseItems[i].wIndex := 0;
            end;
            //end;
          end;
        end;
      end;
    end;
    if DelList <> nil then
      SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(DelList), 0, 0, '');
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TPlayObject.GainExp(dwExp: LongWord);
var
  i, n, sumlv, nExp, nHighLevel, nLowLevel: Integer;
  PlayObject: TPlayObject;
  nCheckCode: Integer;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::GainExp';
const
  bonus: array[0..GROUPMAX] of real = (1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2, 2.1, 2.2);
begin
  nCheckCode := 0;
  try
    nHighLevel := 0;
    nLowLevel := High(Word);
    if dwExp > 0 then begin
      if (m_GroupOwner <> nil) and (m_GroupOwner.m_GroupMembers <> nil) and
        (m_GroupOwner.m_GroupMembers.Count > 0) then begin
        sumlv := 0;
        n := 0;
        nCheckCode := 1;
        for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
          PlayObject := TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
          if PlayObject <> nil then begin
            if not PlayObject.m_boDeath and (m_PEnvir = PlayObject.m_PEnvir) and
              (abs(m_nCurrX - PlayObject.m_nCurrX) <= 12) and (abs(m_nCurrX -
              PlayObject.m_nCurrX) <= 12) then begin
              sumlv := sumlv + PlayObject.m_Abil.Level;
              if PlayObject.m_Abil.Level > nHighLevel then
                nHighLevel := PlayObject.m_Abil.Level;
              if PlayObject.m_Abil.Level < nLowLevel then
                nLowLevel := PlayObject.m_Abil.Level;
              Inc(n);
            end;
          end;
        end;
        nCheckCode := 2;
        if (sumlv > 0) and (n > 1) then begin
          if n in [0..GROUPMAX] then
            dwExp := ROUND(dwExp * bonus[n]);
          nCheckCode := 3;
          for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
            PlayObject := TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
            if PlayObject <> nil then begin
              if not PlayObject.m_boDeath and (m_PEnvir = PlayObject.m_PEnvir)
                and (abs(m_nCurrX - PlayObject.m_nCurrX) <= 12) and (abs(m_nCurrX - PlayObject.m_nCurrX) <= 12) then begin
                if g_Config.boHighLevelKillMonFixExp and g_Config.boHighLevelGroupFixExp then
                  begin //02/08 增加，在高等级经验不变时，把组队的经验平均分配
                  nCheckCode := 4;
                  PlayObject.WinExp(ROUND(dwExp / n));
                  nCheckCode := 5;
                end
                else if g_Config.boHighLevelGroupFixExp then begin
                  nCheckCode := 6;
                  PlayObject.WinExp(ROUND(dwExp / sumlv * PlayObject.m_Abil.Level));
                  nCheckCode := 7;
                end
                else if m_Abil.Level > (nLowLevel + 10) then begin //大号杀怪组里人经验不变
                  PlayObject.WinExp(ROUND(dwExp / sumlv * PlayObject.m_Abil.Level));
                  //PlayObject.WinExp(dwExp);
                end
                else if m_Abil.Level <= (nLowLevel + 10) then begin
                  if PlayObject.m_Abil.Level > (nLowLevel + 10) then begin //小号杀怪经验组里人大号经验改变
                    nExp := ROUND(dwExp / PlayObject.m_Abil.Level);
                    if nExp <= 0 then
                      nExp := 1;
                    PlayObject.WinExp(nExp);
                  end
                  else begin
                    PlayObject.WinExp(ROUND(dwExp / sumlv * PlayObject.m_Abil.Level));
                    //小号杀怪经验组里人小号经验不变
                  end;
                end;
              end;
            end;
          end;
        end
        else
          WinExp(dwExp);
      end
      else
        WinExp(dwExp);
    end;
  except
    MainOutMessage(sExceptionMsg + ' ' + IntToStr(nCheckCode));
  end;
end;

procedure TPlayObject.GameTimeChanged;
begin
  {if m_nBright <> g_nGameTime then begin
    m_nBright := g_nGameTime;
    SendMsg(Self, RM_DAYCHANGING, 0, 0, 0, 0, '');
  end;}
end;

procedure TPlayObject.GetBackDealItems;
var
  i: Integer;
begin
  if m_DealItemList.Count > 0 then begin
    for i := 0 to m_DealItemList.Count - 1 do begin
      m_ItemList.Add(m_DealItemList.Items[i]);
    end;
  end;
  m_DealItemList.Clear;
  RecalcBagCount();
  Inc(m_nGold, m_nDealGolds);
  m_nDealGolds := 0;
  m_boDealOK := False;
  m_boDealLock := False;
end;

function TPlayObject.GeTBaseObjectInfo: string;
begin
  Result := m_sCharName +
    ' 标识:' + IntToHex(Integer(Self), 2) +
    ' 权限等级: ' + IntToStr(m_btPermission) +
    ' 管理模式: ' + BoolToCStr(m_boAdminMode) +
    ' 隐身模式: ' + BoolToCStr(m_boObMode) +
    ' 无敌模式: ' + BoolToCStr(m_boSuperMan) +
    ' 地图:' + m_sMapName + '(' + m_PEnvir.sMapDesc + ')' +
    ' 座标:' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) +
    ' 等级:' + IntToStr(m_Abil.Level) +
    ' 转生等级:' + IntToStr(m_btReLevel) +
    ' 经验:' + IntToStr(m_Abil.Exp) +
    ' 生命值:' + IntToStr(m_WAbil.HP) + '-' + IntToStr(m_WAbil.MaxHP) +
    ' 魔法值:' + IntToStr(m_WAbil.MP) + '-' + IntToStr(m_WAbil.MaxMP) +
    ' 攻击力:' + IntToStr(LoWord(m_WAbil.DC)) + '-' + IntToStr(HiWord(m_WAbil.DC)) +
    ' 魔法力:' + IntToStr(LoWord(m_WAbil.MC)) + '-' + IntToStr(HiWord(m_WAbil.MC)) +
    ' 道术:' + IntToStr(LoWord(m_WAbil.SC)) + '-' + IntToStr(HiWord(m_WAbil.SC)) +
    ' 防御力:' + IntToStr(LoWord(m_WAbil.AC)) + '-' + IntToStr(HiWord(m_WAbil.AC)) +
    ' 魔防力:' + IntToStr(LoWord(m_WAbil.MAC)) + '-' + IntToStr(HiWord(m_WAbil.MAC)) +
    ' 准确:' + IntToStr(m_btHitPoint) +
    ' 敏捷:' + IntToStr(m_btSpeedPoint) +
    ' 速度:' + IntToStr(m_nHitSpeed) +
    ' 登录IP:' + m_sIPaddr + '(' + m_sIPLocal + ')' +
    ' 登录帐号:' + m_sUserID +
    ' 登录时间:' + DateTimeToStr(m_dLogonTime) +
    ' 在线时长(分钟):' + IntToStr((GetTickCount - m_dwLogonTick) div 60000) +
    ' ' + sSTRING_GAMEGOLD + ':' + IntToStr(m_nGameGold) +
    ' ' + sSTRING_GAMEPOINT + ':' + IntToStr(m_nGamePoint) +
    ' 会员类型:' + IntToStr(m_nMemberType) +
    ' 会员等级:' + IntToStr(m_nMemberLevel) +
    ' 经验倍数:' + CurrToStr(m_nKillMonExpRate / 100) +
    ' 攻击倍数:' + CurrToStr(m_nPowerRate / 100) +
    ' 声望值:' + IntToStr(m_nCreditPoint);
end;

function TPlayObject.GetDigUpMsgCount: Integer;
var
  i: Integer;
  SendMessage: pTSendMessage;
begin
  Result := 0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for i := 0 to m_MsgList.Count - 1 do begin
      SendMessage := m_MsgList.Items[i];
      if SendMessage <> nil then begin
        if (SendMessage.wIdent = CM_BUTCH) then begin
          Inc(Result);
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

procedure TPlayObject.ClientQueryBagItems(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  i: Integer;
  sSENDMSG: string;
  UserItem: pTUserItem;
begin
  sSENDMSG := '';
  for i := Low(m_AppendBagItems) to High(m_AppendBagItems) do begin
    if m_AppendBagItems[i].wIndex > 0 then
      sSENDMSG := sSENDMSG + IntToStr(i) + '/' + MakeClientItem(@m_AppendBagItems[i]) + '/';
  end;
  if sSENDMSG <> '' then begin
    m_DefMsg := MakeDefaultMsg(SM_SENDADDBAGITEMS, Integer(Self), 0, 0, m_nMaxItemListCount);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;

  {if Assigned(zPlugOfEngine.HookClientQueryBagItems) then begin
    try
      zPlugOfEngine.HookClientQueryBagItems(Self);
    except
    end;
  end
  else begin}
  sSENDMSG := '';
  for i := 0 to m_ItemList.Count - 1 do begin
    UserItem := m_ItemList.Items[i];
    if UserItem = nil then
      Continue;
    sSENDMSG := sSENDMSG + MakeClientItem(UserItem) + '/';
  end;
  if sSENDMSG <> '' then begin
    m_DefMsg := MakeDefaultMsg(SM_BAGITEMS, Integer(Self), 0, 0, m_ItemList.Count);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;

  //end;
end;

procedure TPlayObject.ClientQueryUserSet(ProcessMsg: pTProcessMessage; var boResult: Boolean);
//var
//  sPassword: string;
begin
  {sPassword := Md5.EncryptString(ProcessMsg.sMsg);
  if sPassword <> DecodeString('NbA_VsaSTRucMbAjUl') then begin
    MainOutMessage('Fail');
    exit;
  end;
  m_nClientFlagMode := ProcessMsg.wParam;
  MainOutMessage(format('OK:%d', [m_nClientFlagMode]));}
  //'JackyWangFang'
  //'8988e0804091579a2fd8a0db75e9c17a';
  //'NbA_VsaSTRucMbAjUl'
end;

procedure TPlayObject.ClientQueryUserState(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  i: Integer;
  UserState: TUserStateInfo;
  sSendMSg, sItemMsg: string;
  PlayObject: TPlayObject;
begin
  {if Assigned(zPlugOfEngine.HookClientQueryUserState) then begin
    try
      zPlugOfEngine.HookClientQueryUserState(Self, PlayObject, nX, nY);
    except
    end;
  end
  else begin  }

  if not CretInNearXY(TBaseObject(ProcessMsg.nParam1), ProcessMsg.nParam2, ProcessMsg.nParam3) then
    Exit;
  if TBaseObject(ProcessMsg.nParam1).m_btRaceServer <> RC_PLAYOBJECT then
    exit;

  PlayObject := TPlayObject(ProcessMsg.nParam1);
  if (PlayObject.m_PEnvir = m_PEnvir) and
    (abs(PlayObject.m_nCurrX - m_nCurrX) <= m_nViewRange) and (abs(PlayObject.m_nCurrY - m_nCurrY) <= m_nViewRange) then begin
    SafeFillChar(UserState, SizeOf(UserState), #0);
    UserState.feature := PlayObject.GetFeature(Self);
    UserState.UserName := PlayObject.m_sCharName;
    UserState.NAMECOLOR := GetCharColor(PlayObject);
    UserState.btWuXin := PlayObject.m_btWuXin;
    UserState.btJob := PlayObject.m_btJob;
    UserState.boHideHelmet := CheckIntStatus(PlayObject.m_nAllowSetup, GSP_HIDEHELMET);
    //UserState.btWuXinLevel := PlayObject.m_btWuXinLevel div 10;
    if PlayObject.m_MyGuild <> nil then begin
      UserState.GuildName := TGuild(PlayObject.m_MyGuild).m_sGuildName;
      UserState.GuildRankName := PlayObject.m_sGuildRankName;
    end;
    sItemMsg := '';
    for i := Low(THumanUseItems) to High(THumanUseItems) do begin
      if PlayObject.m_UseItems[i].wIndex > 0 then begin
        sItemMsg := sItemMsg + IntToStr(I) + '/' + MakeClientItem(@PlayObject.m_UseItems[i]) + '/';
      end;
    end;
//    if PlayObject.m_RealityInfo.boFriendSee and (not IsMyFriend(PlayObject)) then begin
//      m_DefMsg := MakeDefaultMsg(SM_SENDUSERSTATE, Integer(PlayObject.m_RealityInfo.boFriendSee), 0, 0, 0);
//      if PlayObject.m_RealityInfo.sPhotoID <> '' then
//        sSendMSg := EncodeString('1//')
//      else
//        sSendMSg := '';
//      m_nLookPhotoIndex := -1;
//    end
//    else begin
//      m_DefMsg := MakeDefaultMsg(SM_SENDUSERSTATE,
//        Integer(PlayObject.m_RealityInfo.boFriendSee),
//        MakeWord(PlayObject.m_RealityInfo.btOld, PlayObject.m_RealityInfo.btSex),
//        MakeWord(PlayObject.m_RealityInfo.btProvince, PlayObject.m_RealityInfo.btCity),
//        MakeWord(PlayObject.m_RealityInfo.btArea, PlayObject.m_RealityInfo.btOnlineTime));
//      sSendMsg := EncodeString(PlayObject.m_RealityInfo.sPhotoID + '/' +
//        PlayObject.m_RealityInfo.sUserName + '/' +
//        PlayObject.m_RealityInfo.sIdiograph);
//      m_nLookPhotoIndex := PlayObject.m_nDBIndex;
//    end;
    SendSocket(@m_DefMsg, EncodeBuffer(@UserState, SizeOf(UserState)) + '/' + sSendMsg + '/' + sItemMsg);
  end;
end;

function TPlayObject.IsMyFriend(PlayObject: TPlayObject): Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to m_FriendList.Count - 1 do begin
    if Integer(m_FriendList.Objects[i]) = PlayObject.m_nDBIndex then begin
      Result := True;
      break;
    end;
  end;
end;

procedure TPlayObject.ClientMerchantDlgSelect(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  NPC: TNormNpc;
begin
  if m_boDeath or m_boGhost then
    Exit;

  NPC := TNormNPC(GetSelectNpc(ProcessMsg.nParam1));
  if NPC <> nil then begin
    m_nScriptGotoCount := 0;
    NPC.UserSelect(Self, Trim(ProcessMsg.sMsg));
  end;
end;

procedure TPlayObject.ClientItemStrengthen(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  //Merchant: TMerchant;
  nItemIndex: Integer;
  StrengthenItem: TStrengthenItem;
  pGold: pInteger;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  LevelUpItem: pTUserItem;
  LevelUpStd: pTStdItem;
  UserItemLevelArr: array[0..4] of pTUserItem;
  UserItemAssArr: array[0..4] of pTUserItem;
  StdItemLevelArr: array[0..4] of pTStdItem;
  StdItemAssArr: array[0..4] of pTStdItem;
  i, ii, nBack, nMakeGold, nMaxUpRate, nUpRate, nDownLevelRate, nBreakUpRate: Integer;
  boNotBreakUp: Boolean;
  sSendMsg: string;
  boOne: Boolean;
  NPC: TNormNpc;
  //boCastle: Boolean;
begin
  nBack := 0;
  sSendMsg := '';
  if m_boGhost or m_boDeath or (not g_Config.boOpenArmStrengthen) then
    Exit;
  NPC := TNormNpc(GetSelectNPC(ProcessMsg.nParam1));
  if (NPC = nil) or (not (NPC is TMerchant)) then
    exit;
  if TMerchant(NPC).m_boArmStrengthen then begin
    try
      //boCastle := Merchant.m_boCastle;
      nBack := 1;
      nItemIndex := MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3);
      SafeFillChar(StrengthenItem, SizeOf(StrengthenItem), #0);
      DecodeBuffer(ProcessMsg.sMsg, @StrengthenItem, SizeOf(StrengthenItem));

      SafeFillChar(UserItemLevelArr, SizeOf(UserItemLevelArr), #0);
      SafeFillChar(UserItemAssArr, SizeOf(UserItemAssArr), #0);
      SafeFillChar(StdItemLevelArr, SizeOf(StdItemLevelArr), #0);
      SafeFillChar(StdItemAssArr, SizeOf(StdItemAssArr), #0);
      LevelUpItem := nil;
      LevelUpStd := nil;

      try
        //获取背包是否有指定的物品
        nBack := 2; //要升级的物品不正常
        for i := m_ItemList.Count - 1 downto 0 do begin
          UserItem := m_ItemList[i];
          if UserItem <> nil then begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem = nil then
              Continue;
            if UserItem.MakeIndex = nItemIndex then begin
              if (not (sm_ArmingStrong in StdItem.StdModeEx)) or CheckItemBindMode(UserItem, bm_NoMake) or
                (UserItem.Value.StrengthenInfo.btStrengthenCount >= UserItem.Value.StrengthenInfo.btCanStrengthenCount) then begin
                //物品不允许强化，或已强化至最高等级，或者未开光
                nBack := 3;
                Break;
              end;
              if CheckItemBindMode(UserItem, bm_Unknown) then begin
                //未开光物品不允许强化
                nBack := 4;
                Break;
              end;
              m_ItemList.Delete(I);
              LevelUpItem := UserItem;
              LevelUpStd := StdItem;
            end
            else begin
              for II := Low(UserItemLevelArr) to High(UserItemLevelArr) do begin
                if UserItem.MakeIndex = StrengthenItem.nLevelIdx[II] then begin //玄晶
                  if (tm_MakeStone = StdItem.StdMode) and (StdItem.Shape = 0) then begin
                    m_ItemList.Delete(I);
                    UserItemLevelArr[II] := UserItem;
                    StdItemLevelArr[II] := StdItem;
                  end;
                  break;
                end
                else if UserItem.MakeIndex = StrengthenItem.nAssIdx[II] then begin //辅助
                  if (tm_MakeStone = StdItem.StdMode) and (StdItem.Shape in [1, 2]) then begin
                    m_ItemList.Delete(I);
                    UserItemAssArr[II] := UserItem;
                    StdItemAssArr[II] := StdItem;
                  end;
                  break;
                end;
              end;
            end;
          end; // UserItem <> nil
        end; // end for
        if LevelUpItem <> nil then begin
          nMakeGold := GetStrengthenMoney(LevelUpItem.Value.StrengthenInfo.btStrengthenCount);
          nMaxUpRate := GetStrengthenMaxRate(LevelUpItem.Value.StrengthenInfo.btStrengthenCount);
          pGold := nil;
          {if boCastle then nUpRate := 5;   //沙巴克初始为 %5 成功机率
          else                          }
          nUpRate := 0; //成功机率
          nDownLevelRate := 0; //降级机率
          nBreakUpRate := 0; //破碎机率
          boNotBreakUp := False; //保证不破碎
          if m_nBindGold >= nMakeGold then
            pGold := @m_nBindGold
          else if m_nGold >= nMakeGold then
            pGold := @m_nGold;
          nBack := 5; //缺少强化资金
          if pGold <> nil then begin //
            boOne := False;
            for II := Low(UserItemLevelArr) to High(UserItemLevelArr) do begin
              if UserItemLevelArr[II] <> nil then begin
                if CheckItemArmStrengthenLevel(LevelUpItem.Value.StrengthenInfo.btStrengthenCount,
                  StdItemLevelArr[II].Need, StdItemLevelArr[II].NeedLevel) then begin
                  Inc(nUpRate, StdItemLevelArr[II].Reserved);
                  Inc(nDownLevelRate, StdItemLevelArr[II].AniCount);
                  Inc(nBreakUpRate, StdItemLevelArr[II].Source);
                  boOne := True;
                end
                else begin
                  m_ItemList.Add(UserItemLevelArr[II]);
                  UserItemLevelArr[II] := nil;
                  StdItemLevelArr[II] := nil;
                end;
              end;
              if UserItemAssArr[II] <> nil then begin
                if StdItemAssArr[II].Shape = 1 then
                  boNotBreakUp := True;
                if StdItemAssArr[II].Shape = 2 then
                  Inc(nUpRate, StdItemAssArr[II].Reserved);
              end;
            end;
            if nUpRate > nMaxUpRate then
              nUpRate := nMaxUpRate;
            nBack := 6; //成功机率太低(没有放置玄晶)
            if boOne and (nUpRate > 0) then begin
              nBack := 7; //升级完成
              Dec(pGold^, nMakeGold); //扣除强化费用
              //删除强化玄晶等物品
              for II := Low(UserItemLevelArr) to High(UserItemLevelArr) do begin
                if UserItemLevelArr[II] <> nil then begin
                  if StdItemLevelArr[II].NeedIdentify = 1 then
                    AddGameLog(Self, LOG_DELITEM, StdItemLevelArr[II].Name, UserItemLevelArr[II].MakeIndex,
                      0, '0', '0', '0', '强化', UserItemLevelArr[II]);
                  Dispose(UserItemLevelArr[II]);
                  UserItemLevelArr[II] := nil;
                  StdItemLevelArr[II] := nil;
                end;
                if UserItemAssArr[II] <> nil then begin
                  if StdItemAssArr[II].NeedIdentify = 1 then
                    AddGameLog(Self, LOG_DELITEM, StdItemAssArr[II].Name, UserItemAssArr[II].MakeIndex,
                      0, '0', '0', '0', '强化', UserItemAssArr[II]);
                  Dispose(UserItemAssArr[II]);
                  UserItemAssArr[II] := nil;
                  StdItemAssArr[II] := nil;
                end;
              end; //end for
              //开始强化
              if Random(100) < nUpRate then begin
                nBack := 8; //升级成功
                Inc(LevelUpItem.Value.StrengthenInfo.btStrengthenCount);
                if LevelUpItem.Value.StrengthenInfo.btStrengthenCount >= 18 then begin
                  LevelUpItem.Value.StrengthenInfo.btStrengthenCount := 18;
                  //if LevelUpItem.Value.StrengthenInfo.btStrengthenInfo[5] = 6 then begin
                    //SetByteStatus(LevelUpItem.btBindMode1, Ib_NoDeal, True);
                    //SetByteStatus(LevelUpItem.btBindMode1, Ib_NoDrop, True);
                    //SetByteStatus(LevelUpItem.btBindMode2, Ib2_Bind, True);
                  //end;
                end;
                AddGameLog(Self, LOG_ITEMLEVEL, LevelUpStd.Name, LevelUpItem.MakeIndex,
                  LevelUpItem.Value.StrengthenInfo.btCanStrengthenCount,
                  '0',
                  IntToStr(LevelUpItem.Value.StrengthenInfo.btStrengthenCount - 1),
                  IntToStr(LevelUpItem.Value.StrengthenInfo.btStrengthenCount), '强化升级', LevelUpItem);
                if LevelUpItem.Value.StrengthenInfo.btStrengthenCount >= 6 then begin
                  sSendMsg := '恭喜：[#6FFFF/8#6#7' + m_sCharName + '#7#5] 成功将 ';
                  sSendMsg := sSendMsg + '{' + IntToStr(SetSayItem(LevelUpItem)) + '/';
                  sSendMsg := sSendMsg + IntToStr(LevelUpItem.wIndex) + '/';
                  sSendMsg := sSendMsg + IntToStr(LevelUpItem.MakeIndex) + '}';
                  sSendMsg := sSendMsg + ' 强化到 #6FFFF/8#6+';
                  sSendMsg := sSendMsg + IntToStr(LevelUpItem.Value.StrengthenInfo.btStrengthenCount) + '#5';
                  UserEngine.SendBroadCastMsgDelay(sSendMsg, t_Hint, 2 * 1000);
                end;
                sSendMsg := MakeClientItem(LevelUpItem);
              end
              else begin
                if (nBreakUpRate > 0) and (not boNotBreakUp) and (Random(100) < nBreakUpRate) then begin
                  nBack := 9; //升级破碎
                  if (LevelUpStd.NeedIdentify = 1) then
                    AddGameLog(Self, LOG_DELITEM, LevelUpStd.Name, LevelUpItem.MakeIndex,
                      LevelUpItem.Value.StrengthenInfo.btCanStrengthenCount, '0',
                      '0', '0', '强化破碎', LevelUpItem);
                  Dispose(LevelUpItem);
                  LevelUpItem := nil;
                  //                  LevelUpStd := nil;
                end
                else if (nDownLevelRate > 0) and (Random(100) < nDownLevelRate) then begin
                  nBack := 10; //升级降级
                  if LevelUpItem.Value.StrengthenInfo.btStrengthenCount > 0 then
                    Dec(LevelUpItem.Value.StrengthenInfo.btStrengthenCount);
                  AddGameLog(Self, LOG_ITEMLEVEL, LevelUpStd.Name, LevelUpItem.MakeIndex,
                    LevelUpItem.Value.StrengthenInfo.btCanStrengthenCount, '0',
                    IntToStr(LevelUpItem.Value.StrengthenInfo.btStrengthenCount + 1),
                    IntToStr(LevelUpItem.Value.StrengthenInfo.btStrengthenCount), '强化降级', LevelUpItem);
                  sSendMsg := MakeClientItem(LevelUpItem);
                end
                else
                  nBack := 11; //装备无变化
              end;
            end; //nUpRate > 0
          end; //pGold <> nil
        end; //LevelUpItem <> nil
      finally
        if LevelUpItem <> nil then
          m_ItemList.Add(LevelUpItem);

        for I := Low(UserItemLevelArr) to High(UserItemLevelArr) do begin
          if UserItemLevelArr[i] <> nil then
            m_ItemList.Add(UserItemLevelArr[i]);
          if UserItemAssArr[i] <> nil then
            m_ItemList.Add(UserItemAssArr[i]);
        end;
      end;
      if sSendMsg <> '' then begin
        m_DefMsg := MakeDefaultMsg(SM_ITEMSTRENGTHEN, m_nGold, LoWord(m_nBindGold), HiWord(m_nBindGold), nBack);
        SendSocket(@m_DefMsg, sSENDMSG);
      end
      else
        SendDefMessage(SM_ITEMSTRENGTHEN, m_nGold, LoWord(m_nBindGold), HiWord(m_nBindGold), nBack, '');
    except
      on E: Exception do begin
        MainOutMessage('[Exception] TPlayObject -> ClientItemStrengthen ' + IntToStr(nBack));
        MainOutMessage(E.Message);
      end;
    end;
  end;
end;
(*
procedure TPlayObject.ClientItemStrengthen(ProcessMsg: pTProcessMessage; var boResult: Boolean);
  procedure ChangeUserItemDura(var UserItem: pTUserItem; StdItem: pTStdItem; boTwo: Boolean);
  begin
    if boTwo then begin
      if UserItem.Dura > 2 then begin
        Dec(UserItem.Dura, 2);
        if (StdItem.NeedIdentify = 1) then
          AddGameLog(Self, LOG_ITEMDURACHANGE, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, '0', '-', '2',
            '强化');

        m_ItemList.Add(UserItem);
        UserItem := nil;
      end
      else begin
        if (StdItem.NeedIdentify = 1) then
          AddGameLog(Self, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, 0, '0', '0', '0', '强化');
        Dispose(UserItem);
        UserItem := nil;
      end;
    end
    else begin
      if UserItem.Dura > 1 then begin
        Dec(UserItem.Dura);
        if (StdItem.NeedIdentify = 1) then
          AddGameLog(Self, LOG_ITEMDURACHANGE, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, '0', '-', '1',
            '强化');
        m_ItemList.Add(UserItem);
        UserItem := nil;
      end
      else begin
        if (StdItem.NeedIdentify = 1) then
          AddGameLog(Self, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, 0, '0', '0', '0', '强化');
        Dispose(UserItem);
        UserItem := nil;
      end;
    end;
  end;
var
  nItemIndex: Integer;
  sStoneMsg: string;
  MessageItemWL: TMessageItemWL;
  i, nBack: integer;
  nRate, boNotDownLevel, boNotClear: Byte;
  StdItem, LevelItemStd, LevelStoneStd, StoneRate1Std, StoneRate2Std, StoneNot1Std, StoneNot2Std: pTStditem;
  UserItem, LevelItem, LevelStone, StoneRate1, StoneRate2, StoneNot1, StoneNot2: pTUserItem;
  boStoneRateTwo, boStoneNotTwo: Boolean;
  //wMaxDura: Integer;
  pGold: pInteger;
begin
  nBack := 0; //金币不够
  //  wMaxDura := 0;
  try
    nItemIndex := MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3);
    sStoneMsg := ProcessMsg.sMsg;
    SafeFillChar(MessageItemWL, SizeOf(MessageItemWL), #0);
    DecodeBuffer(sStoneMsg, @MessageItemWL, SizeOf(MessageItemWL));
    LevelItem := nil;
    LevelStone := nil;
    StoneRate1 := nil;
    StoneRate2 := nil;
    StoneNot1 := nil;
    StoneNot2 := nil;
    LevelItemStd := nil;
    LevelStoneStd := nil;
    StoneRate1Std := nil;
    StoneRate2Std := nil;
    StoneNot1Std := nil;
    StoneNot2Std := nil;
    pGold := nil;
    boStoneRateTwo := MessageItemWL.lParam2 = MessageItemWL.lParam3;
    boStoneNotTwo := MessageItemWL.lParam4 = MessageItemWL.lParam5;
    if m_nBindGold >= g_Config.nArmStrengthenGold then
      pGold := @m_nBindGold
    else if m_nGold >= g_Config.nArmStrengthenGold then
      pGold := @m_nGold;

    if (nItemIndex > 0) and (MessageItemWL.lParam1 > 0) and (pGold <> nil) then begin
      try
        //获取背包是否有指定的物品
        for i := m_ItemList.Count - 1 downto 0 do begin
          UserItem := m_ItemList[i];
          if UserItem <> nil then begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem = nil then
              Continue;
            if (UserItem.MakeIndex = nItemIndex) and (sm_ArmingStrong in StdItem.StdModeEx) and
              (UserItem.Value.btWuXin in [1..5]) and (StdItem.Reserved in [0..2]) and
              (not CheckByteStatus(StdItem.Bind, Ib_NoMake)) and
              (not CheckByteStatus(UserItem.btBindMode1, Ib_NoMake)) and
              (UserItem.Value.btValue[tb_StrengthenCount] < 21) then begin
              LevelItem := UserItem;
              LevelItemStd := StdItem;
              m_ItemList.Delete(i);
            end
            else if (UserItem.MakeIndex = MessageItemWL.lParam1) and (tm_MakeStone = StdItem.StdMode) and
              (StdItem.Shape = 1) then begin
              LevelStone := UserItem;
              LevelStoneStd := StdItem;
              m_ItemList.Delete(i);
            end
            else if (UserItem.MakeIndex = MessageItemWL.lParam2) and (tm_MakeStone = StdItem.StdMode) and
              (StdItem.Shape = 2) then begin
              StoneRate1 := UserItem;
              StoneRate1Std := StdItem;
              m_ItemList.Delete(i);
            end
            else if (not boStoneRateTwo) and (UserItem.MakeIndex = MessageItemWL.lParam3) and
              (tm_MakeStone = StdItem.StdMode) and (StdItem.Shape = 2) then begin
              StoneRate2 := UserItem;
              StoneRate2Std := StdItem;
              m_ItemList.Delete(i);
            end
            else if (UserItem.MakeIndex = MessageItemWL.lParam4) and (tm_MakeStone = StdItem.StdMode) and
              (StdItem.Shape = 3) then begin
              StoneNot1 := UserItem;
              StoneNot1Std := StdItem;
              m_ItemList.Delete(i);
            end
            else if (not boStoneNotTwo) and (UserItem.MakeIndex = MessageItemWL.lParam5) and
              (tm_MakeStone = StdItem.StdMode) and (StdItem.Shape = 3) then begin
              StoneNot2 := UserItem;
              StoneNot2Std := StdItem;
              m_ItemList.Delete(i);
            end;
          end;
        end;
        nBack := 1; //强化宝石无法提升该装备
        if (LevelItem <> nil) and (LevelStone <> nil) and
          CheckItemArmStrengthenLevel(LevelItem.Value.btValue[tb_StrengthenCount],
          LevelStoneStd.Need, LevelStoneStd.NeedLevel) then begin
          nRate := LevelStoneStd.Reserved;
          boNotDownLevel := LevelStoneStd.AniCount;
          boNotClear := LevelStoneStd.Source;
          ChangeUserItemDura(LevelStone, LevelStoneStd, False);
          Dec(pGold^, g_Config.nArmStrengthenGold);
          //GoldChanged;
          //检查其它可选宝石是否正常
          if (StoneRate1 <> nil) then begin
            if not CheckItemArmStrengthenLevel(LevelItem.Value.btValue[tb_StrengthenCount], StoneRate1Std.Need,
              StoneRate1Std.NeedLevel) then begin
              m_ItemList.Add(StoneRate1);
              StoneRate1 := nil;
            end
            else begin
              if boStoneRateTwo and (StoneRate1.Dura >= 2) then begin
                Inc(nRate, StoneRate1Std.Reserved * 2);
                ChangeUserItemDura(StoneRate1, StoneRate1Std, True);
              end
              else begin
                Inc(nRate, StoneRate1Std.Reserved);
                ChangeUserItemDura(StoneRate1, StoneRate1Std, False);
              end;
            end;
          end;
          if (StoneRate2 <> nil) then begin
            if not CheckItemArmStrengthenLevel(LevelItem.Value.btValue[tb_StrengthenCount], StoneRate2Std.Need,
              StoneRate2Std.NeedLevel) then begin
              m_ItemList.Add(StoneRate2);
              StoneRate2 := nil;
            end
            else begin
              Inc(nRate, StoneRate2Std.Reserved);
              ChangeUserItemDura(StoneRate2, StoneRate2Std, False);
            end;
          end;
          if (StoneNot1 <> nil) then begin
            if not CheckItemArmStrengthenLevel(LevelItem.Value.btValue[tb_StrengthenCount], StoneNot1Std.Need,
              StoneNot1Std.NeedLevel) then begin
              m_ItemList.Add(StoneNot1);
              StoneNot1 := nil;
            end
            else begin
              if StoneNot1Std.AniCount <> 0 then
                boNotDownLevel := 0;
              if StoneNot1Std.Source <> 0 then
                boNotClear := 0;
              ChangeUserItemDura(StoneNot1, StoneNot1Std, boStoneNotTwo);
            end;
          end;
          if (StoneNot2 <> nil) then begin
            if not CheckItemArmStrengthenLevel(LevelItem.Value.btValue[tb_StrengthenCount], StoneNot2Std.Need,
              StoneNot2Std.NeedLevel) then begin
              m_ItemList.Add(StoneNot2);
              StoneNot2 := nil;
            end
            else begin
              if StoneNot2Std.AniCount <> 0 then
                boNotDownLevel := 0;
              if StoneNot2Std.Source <> 0 then
                boNotClear := 0;
              ChangeUserItemDura(StoneNot2, StoneNot2Std, False);
            end;
          end;

          nBack := 5; //失败,无变化
          if Random(100) < nRate then begin
            nBack := 2; //强化成功
            Inc(LevelItem.Value.btValue[tb_StrengthenCount]);
            if LevelItemStd.StdMode = tm_Weapon then begin
              if LevelItem.Value.btValue[tb_StrengthenCount] <= 3 then begin
                if (LevelItem.DuraMax + 1000) < High(Word) then
                  Inc(LevelItem.DuraMax, 1000)
                else
                  LevelItem.DuraMax := High(Word);
              end;
            end
            else begin
              if LevelItem.Value.btValue[tb_StrengthenCount] <= 5 then begin
                if (LevelItem.DuraMax + 1000) < High(Word) then
                  Inc(LevelItem.DuraMax, 1000)
                else
                  LevelItem.DuraMax := High(Word);
              end;
            end;
            if LevelItem.Value.btValue[tb_StrengthenCount] >= 21 then begin
              LevelItem.Value.btValue[tb_StrengthenCount] := 21;
              SetByteStatus(LevelItem.btBindMode1, Ib_NoDeal, True);
              SetByteStatus(LevelItem.btBindMode1, Ib_NoDrop, True);
              SetByteStatus(LevelItem.btBindMode1, Ib_NoDown, True);
            end;
            //            wMaxDura := LevelItem.DuraMax;
            if (LevelItemStd.NeedIdentify = 1) then
              AddGameLog(Self, LOG_ITEMLEVEL, LevelItemStd.Name, LevelItem.MakeIndex, 0, '0',
                IntToStr(LevelItem.Value.btValue[tb_StrengthenCount] - 1),
                IntToStr(LevelItem.Value.btValue[tb_StrengthenCount]), '升级');
          end
          else begin
            if (boNotDownLevel > 0) and (Random(100) < boNotDownLevel) then begin
              nBack := 3; //失败,降级
              if LevelItem.Value.btValue[tb_StrengthenCount] > 0 then begin
                if LevelItemStd.StdMode = tm_Weapon then begin
                  if LevelItem.Value.btValue[tb_StrengthenCount] <= 3 then begin
                    if LevelItem.DuraMax > 1000 then
                      Dec(LevelItem.DuraMax, 1000)
                    else
                      LevelItem.DuraMax := 1;
                  end;
                end
                else begin
                  if LevelItem.Value.btValue[tb_StrengthenCount] <= 5 then begin
                    if LevelItem.DuraMax > 1000 then
                      Dec(LevelItem.DuraMax, 1000)
                    else
                      LevelItem.DuraMax := 1;
                  end;
                end;
                Dec(LevelItem.Value.btValue[tb_StrengthenCount]);
              end;
              //              wMaxDura := LevelItem.DuraMax;
              if (LevelItemStd.NeedIdentify = 1) then
                AddGameLog(Self, LOG_ITEMLEVEL, LevelItemStd.Name, LevelItem.MakeIndex, 0, '0',
                  IntToStr(LevelItem.Value.btValue[tb_StrengthenCount] + 1),
                  IntToStr(LevelItem.Value.btValue[tb_StrengthenCount]), '降级');
            end
            else if (boNotClear > 0) and (Random(100) < boNotClear) then begin
              nBack := 4; //失败,破碎
              if (LevelItemStd.NeedIdentify = 1) then
                AddGameLog(Self, LOG_DELITEM, LevelItemStd.Name, LevelItem.MakeIndex, 0, '0',
                  '0', '0', '强化破碎');
              Dispose(LevelItem);
              LevelItem := nil;
            end;
          end;
        end; //if (LevelItem <> nil) and (LevelStone <> nil)
      finally
        if LevelItem <> nil then
          m_ItemList.Add(LevelItem);
        if LevelStone <> nil then
          m_ItemList.Add(LevelStone);
        if StoneRate1 <> nil then
          m_ItemList.Add(StoneRate1);
        if StoneRate2 <> nil then
          m_ItemList.Add(StoneRate2);
        if StoneNot1 <> nil then
          m_ItemList.Add(StoneNot1);
        if StoneNot2 <> nil then
          m_ItemList.Add(StoneNot2);
      end;
    end;
    SendDefMessage(SM_ITEMSTRENGTHEN, m_nGold, LoWord(m_nBindGold), HiWord(m_nBindGold), nBack, '');
  except
    on E: Exception do begin
      MainOutMessage('[Exception] TPlayObject -> ClientItemStrengthen ' + IntToStr(nBack));
      MainOutMessage(E.Message);
    end;
  end;

end;   *)

procedure TPlayObject.ClientItemAbilityMove(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  vMakeIndex: array of Integer;
  vUserItem: array of pTUserItem;
  vStdItem: array of pTStdItem;
  nRate: Integer;
  sSendMsg: string;
  NPC: TNormNpc;
  i, j, nBack: Integer;
  boBreak: Boolean;
label
  lExit;
begin
  nBack := 0;
  sSendMsg := '';
  if m_boGhost or m_boDeath then
    Exit;
  NPC := TNormNpc(GetSelectNPC(ProcessMsg.nParam1));
  if (NPC = nil) or (not (NPC is TMerchant)) then
    exit;
  if TMerchant(NPC).m_boArmAbilityMove and (ProcessMsg.wParam >= 2) then begin
    try
      nBack := 1;
      //boCastle := Merchant.m_boCastle;
      SetLength(vMakeIndex, ProcessMsg.wParam);
      SetLength(vUserItem, ProcessMsg.wParam);
      SetLength(vStdItem, ProcessMsg.wParam);
      SafeFillChar(vUserItem[0], SizeOf(pTUserItem) * ProcessMsg.wParam, #0);
      SafeFillChar(vStdItem[0], SizeOf(pTStdItem) * ProcessMsg.wParam, #0);
      DecodeBuffer(ProcessMsg.sMsg, @vMakeIndex[0], SizeOf(Integer) * ProcessMsg.wParam);
      boBreak := False;
      for i := Low(vMakeIndex) to High(vMakeIndex) - 1 do
      begin
        for j := i + 1 to High(vMakeIndex) do
        begin
          if vMakeIndex[i] <> vMakeIndex[j] then
            Continue;
          boBreak := True;
          Break;
        end;
        if boBreak then
          Break;
      end;
      try
        if boBreak then
          goto lExit;
        nBack := 2;
        if m_nGold < g_Config.vAbilityMoveSet.Gold then
          goto lExit;
        //获取背包是否有指定的物品
        nBack := 3; //要升级的物品不正常
        nRate := g_Config.vAbilityMoveSet.BaseRate;
        for i := m_ItemList.Count - 1 downto 0 do begin
          UserItem := m_ItemList[i];
          if UserItem <> nil then begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem = nil then
              Continue;
            for j := Low(vMakeIndex) to High(vMakeIndex) do
            begin
              if UserItem.MakeIndex <> vMakeIndex[j] then
                Continue;
              if j in [0, 1] then
              begin
                if (not (sm_ArmingStrong in StdItem.StdModeEx)) or CheckItemBindMode(UserItem, bm_NoMake) then begin
                  //物品不允许强化，或已强化至最高等级，或者未开光
                  nBack := 4;
                  boBreak := True;
                  Break;
                end;
                if CheckItemBindMode(UserItem, bm_Unknown) then begin
                  //未开光物品不允许强化
                  nBack := 5;
                  boBreak := True;
                  Break;
                end;
              end
              else
              begin
                if (tm_MakeStone <> StdItem.StdMode) or (StdItem.Shape <> 4) then begin
                  nBack := 6;
                  boBreak := True;
                  Break;
                end;
                Inc(nRate, StdItem.Reserved);
              end;
              m_ItemList.Delete(i);
              vUserItem[j] := UserItem;
              vStdItem[j] := StdItem;
            end;
            if boBreak then
              Break;
          end; // UserItem <> nil
        end; // end for
        if (vUserItem[0] <> nil) and (vUserItem[1] <> nil) then begin
          Dec(m_nGold, g_Config.vAbilityMoveSet.Gold);
          nBack := 7; //到了这里就得清宝石了
          //删除几率神石等物品
          for i := Low(vMakeIndex) + 2 to High(vMakeIndex) do begin
            if vUserItem[i] <> nil then begin
              if vStdItem[i].NeedIdentify = 1 then
                AddGameLog(Self, LOG_DELITEM, vStdItem[i].Name, vUserItem[i].MakeIndex,
                  0, '0', '0', '0', '属性转移', vUserItem[i]);
              Dispose(vUserItem[i]);
              vUserItem[i] := nil;
              vStdItem[i] := nil;
            end;
          end; //end for
          nBack := 8; //升级失败
          m_HookItemEx.Clear;
          m_HookItemEx.Add(vUserItem[0]);
          m_HookItemEx.Add(vUserItem[1]);
          //m_HookItemEx[0] := vUserItem[0];
          //m_HookItemEx[1] := vUserItem[1];
          m_sString[0] := vStdItem[0].Name;
          m_sString[999] := vStdItem[1].Name;
          if (Random(100) < nRate) then
          begin
            nBack := 9; //升级成功
            vUserItem[1].Value := vUserItem[0].Value;
            vMakeIndex[0] := vUserItem[0].MakeIndex;
            UserEngine.CopyToUserItemFromIdx(vUserItem[0].wIndex, vUserItem[0]);
            vUserItem[0].MakeIndex := vMakeIndex[0];
            sSendMsg := '恭喜：[#6FFFF/8#6#7' + m_sCharName + '#7#5] 成功将 ';
            sSendMsg := sSendMsg + '{' + IntToStr(SetSayItem(vUserItem[0])) + '/';
            sSendMsg := sSendMsg + IntToStr(vUserItem[0].wIndex) + '/';
            sSendMsg := sSendMsg + IntToStr(vUserItem[0].MakeIndex) + '}';
            sSendMsg := sSendMsg + ' 的属性转移至 ';
            sSendMsg := sSendMsg + '{' + IntToStr(SetSayItem(vUserItem[1])) + '/';
            sSendMsg := sSendMsg + IntToStr(vUserItem[1].wIndex) + '/';
            sSendMsg := sSendMsg + IntToStr(vUserItem[1].MakeIndex) + '}';
            sSendMsg := sSendMsg + '#5';
            UserEngine.SendBroadCastMsgDelay(sSendMsg, t_Hint, 2 * 1000);
            sSendMsg := MakeClientItem(vUserItem[0]) + '/' + MakeClientItem(vUserItem[1]);
            NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NMOVEABILITY_OK], False);
          end
          else
          begin
            NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NMOVEABILITY_FAIL], False);
          end;
        end;
lExit:
      finally
        for i := Low(vUserItem) to High(vUserItem) do
        begin
          if vUserItem[i] <> nil then
            m_ItemList.Add(vUserItem[i]);
        end;
      end;
      SendDefMessage(SM_ITEMABILITYMOVE, m_nGold, 0, 0, nBack, sSendMsg);
    except
      on E: Exception do begin
        MainOutMessage('[Exception] TPlayObject -> ClientItemAbilityMove ' + IntToStr(nBack));
        MainOutMessage(E.Message);
      end;
    end;
  end;
end;

procedure TPlayObject.ClientCompoundItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  vMakeIndex: array of Integer;
  vUserItem: array of pTUserItem;
  vStdItem: array of pTStdItem;
  nLevel: Integer;
  sSendMsg: string;
  i, j, nBack, nGoldFee, nGameGoldFee: Integer;
  boBreak: Boolean;
  pUpgradeItemCom, pNormalItemCom: pTCompoundInfos;
  pUpgradeCom: pTCompoundInfo;
label
  lExit;
begin
  nBack := 0;
  sSendMsg := '';
  if m_boGhost or m_boDeath then
    Exit;
  if (ProcessMsg.wParam = 5) then begin
    try
      //boCastle := Merchant.m_boCastle;
      nBack := 1;
      nGoldFee := 0;
      nGameGoldFee := 0;
      pUpgradeCom := nil;
      SetLength(vMakeIndex, ProcessMsg.wParam);
      SetLength(vUserItem, ProcessMsg.wParam);
      SetLength(vStdItem, ProcessMsg.wParam);
      SafeFillChar(vUserItem[0], SizeOf(pTUserItem) * ProcessMsg.wParam, #0);
      SafeFillChar(vStdItem[0], SizeOf(pTStdItem) * ProcessMsg.wParam, #0);
      DecodeBuffer(ProcessMsg.sMsg, @vMakeIndex[0], SizeOf(Integer) * ProcessMsg.wParam);
      boBreak := False;
      for i := Low(vMakeIndex) to High(vMakeIndex) - 1 do
      begin
        for j := i + 1 to High(vMakeIndex) do
        begin
          if vMakeIndex[i] <> vMakeIndex[j] then
            Continue;
          boBreak := True;
          Break;
        end;
        if boBreak then
          Break;
      end;
      if not boBreak then
      begin
      try
        //获取背包是否有指定的物品
        nBack := 3; //要升级的主物品不正常
        j := Low(vMakeIndex);
        pUpgradeItemCom := nil;
        for i := m_ItemList.Count - 1 downto 0 do
        begin
          UserItem := m_ItemList[i];
          if UserItem <> nil then
          begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if (StdItem = nil) then
              Continue;
            if UserItem.MakeIndex <> vMakeIndex[j] then
              Continue;
            if (not (sm_ArmingStrong in StdItem.StdModeEx)) or CheckItemBindMode(UserItem, bm_NoMake) then
            begin
              //主物品不允许合成
              nBack := 4;
              boBreak := True;
              Break;
            end;
            if CheckItemBindMode(UserItem, bm_Unknown) then begin
              //主物品未开光
              nBack := 5;
              boBreak := True;
              Break;
            end;
            pUpgradeItemCom := GetCompoundInfos(StdItem.Name);
            if not Assigned(pUpgradeItemCom) then
            begin
              nBack := 4;
              boBreak := True;
              Break;
            end;
            nLevel := UserItem.ComLevel;
            nLevel := _MAX(nLevel, Low(TCompoundInfos));
            if (nLevel < Low(TCompoundInfos)) or (nLevel > High(TCompoundInfos)) or (pUpgradeItemCom[nLevel].Value <= 0) then
            begin
              nBack := 4;
              boBreak := True;
              Break;
            end;
            nLevel := UserItem.ComLevel + 1;
            if (nLevel < Low(TCompoundInfos)) or (nLevel > High(TCompoundInfos)) or (pUpgradeItemCom[nLevel].Value <= 0) then
            begin
              nBack := 4;
              boBreak := True;
              Break;
            end;
            pUpgradeCom := @pUpgradeItemCom[nLevel];
            nGoldFee := g_Config.vCompoundSet.Gold[nLevel];
            nGameGoldFee := g_Config.vCompoundSet.GameGold[nLevel];
            m_ItemList.Delete(i);
            vUserItem[j] := UserItem;
            vStdItem[j] := StdItem;
            Break;
          end;
        end;

        if boBreak or not Assigned(pUpgradeItemCom) or not Assigned(pUpgradeCom) then
          goto lExit;

        boBreak := False;
        for i := m_ItemList.Count - 1 downto 0 do
        begin
          UserItem := m_ItemList[i];
          if UserItem <> nil then
          begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem = nil then
              Continue;
            for j := Low(vMakeIndex) + 1 to High(vMakeIndex) do
            begin
              if UserItem.MakeIndex <> vMakeIndex[j] then
                Continue;
              if (not (sm_ArmingStrong in StdItem.StdModeEx)) or CheckItemBindMode(UserItem, bm_NoMake) then
              begin
                //材料物品不允许合成
                nBack := 6;
                boBreak := True;
                Break;
              end;
              if (vUserItem[Low(vMakeIndex)].ComLevel <> UserItem.ComLevel) then
              begin
                //材料物品不允许合成
                nBack := 6;
                boBreak := True;
                Break;
              end;
              if CheckItemBindMode(UserItem, bm_Unknown) then begin
                 //材料物品未开光
                nBack := 7;
                boBreak := True;
                Break;
              end;
              pNormalItemCom := GetCompoundInfos(StdItem.Name);
              if not Assigned(pNormalItemCom) then
              begin
                nBack := 6;
                boBreak := True;
                Break;
              end;
              nLevel := UserItem.ComLevel;
              nLevel := _MAX(nLevel, Low(TCompoundInfos));
              if (nLevel < Low(TCompoundInfos)) or (nLevel > High(TCompoundInfos)) then
              begin
                nBack := 6;
                boBreak := True;
                Break;
              end;
              //pUpgradeCom
              if (pNormalItemCom[nLevel].Value <= pUpgradeCom.Value - g_Config.vCompoundSet.ValueLimit) then
              begin
                nBack := 6;
                boBreak := True;
                Break;
              end;
              m_ItemList.Delete(i);
              vUserItem[j] := UserItem;
              vStdItem[j] := StdItem;
            end;
            if boBreak then
              Break;
          end; // UserItem <> nil
        end; // end for

        if boBreak then
          goto lExit;

        for i := Low(vUserItem) to High(vUserItem) do
        begin
          if not Assigned(vUserItem[i]) then
          begin
            boBreak := True;
            Break;
          end;
        end;

        if boBreak then
          goto lExit;

        if Assigned(pUpgradeCom) then
        begin

          nBack := 2; //判断费用

          if (m_nGold < nGoldFee) or (m_nGameGold < nGameGoldFee) then
            goto lExit;

          Dec(m_nGold, nGoldFee);
          Dec(m_nGameGold, nGameGoldFee);

          nBack := 8; //到了这里就得所有材料装备了
          for i := Low(vUserItem) + 1 to High(vUserItem) do begin
            if vUserItem[i] <> nil then begin
              if vStdItem[i].NeedIdentify = 1 then
                AddGameLog(Self, LOG_DELITEM, vStdItem[i].Name, vUserItem[i].MakeIndex,
                  0, '0', '0', '0', '装备合成', vUserItem[i]);
              Dispose(vUserItem[i]);
              vUserItem[i] := nil;
              vStdItem[i] := nil;
            end;
          end; //end for
          nBack := 9; //升级失败
          m_HookItemEx.Clear;
          m_HookItemEx.Add(vUserItem[0]);
          //m_HookItemEx[0] := vUserItem[0];
          m_sASSEMBLEITEMNAME := vStdItem[0].Name;
          if (Random(100) < pUpgradeCom.Rate[13]) then
          begin
            nBack := 10; //升级成功
            UpgradeCompoundItem(vUserItem[0], pUpgradeCom);
            NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NASSEMBLEALL], False);
            case vStdItem[0].StdMode of
              tm_Weapon: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NASSEMBLEWEAPON], False);
              tm_Dress: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NASSEMBLEDRESS], False);
              tm_Helmet: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NASSEMBLEHELMET], False);
              tm_Necklace: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NASSEMBLENECKLACE], False);
              tm_Ring: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NASSEMBLERING], False);
              tm_ArmRing: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NASSEMBLEARMRING], False);
              tm_Belt: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NASSEMBLEBELT], False);
              tm_Boot: NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NASSEMBLEBOOT], False);
            end;
            NpcGotoLable(g_FunctionNPC, g_FunctionNPC.GetScriptIndex(SASSEMBLE + vStdItem[0].Name), False);
            sSendMsg := '恭喜：[#6FFFF/8#6#7' + m_sCharName + '#7#5] 成功合成 ';
            sSendMsg := sSendMsg + '{' + IntToStr(SetSayItem(vUserItem[0])) + '/';
            sSendMsg := sSendMsg + IntToStr(vUserItem[0].wIndex) + '/';
            sSendMsg := sSendMsg + IntToStr(vUserItem[0].MakeIndex) + '}';
            sSendMsg := sSendMsg + '#5';
            UserEngine.SendBroadCastMsgDelay(sSendMsg, t_Hint, 2 * 1000);
            sSendMsg := MakeClientItem(vUserItem[0]);
          end
          else
          begin
            NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NASSEMBLEFAIL], False);
          end;
          m_sASSEMBLEITEMNAME := '';
        end;
        lExit:
      finally
        for i := Low(vUserItem) to High(vUserItem) do
        begin
          if vUserItem[i] <> nil then
            m_ItemList.Add(vUserItem[i]);
        end;
      end;
      SendDefMessage(SM_COMPOUNDITEM, m_nGold, LoWord(m_nGameGold), HiWord(m_nGameGold), nBack, sSendMsg);
      end;
    except
      on E: Exception do begin
        MainOutMessage('[Exception] TPlayObject -> ClientItemAbilityMove ' + IntToStr(nBack));
        MainOutMessage(E.Message);
      end;
    end;
  end;
end;

procedure TPlayObject.ClientUserSellItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  i: Integer;
  UserItem: pTUserItem;
  nMakeIndex: Integer;
  sMsg: string;
  NPC: TNormNPC;
begin
  if m_boGhost or m_boDeath then
    exit;
  NPC := TNormNPC(GetSelectNPC(Integer(m_ClickNPC)));
  if (NPC = nil) or (not (NPC is TMerchant)) then
    exit;
  if not TMerchant(NPC).m_boSell then
    exit;

  nMakeIndex := MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3);
  sMsg := ProcessMsg.sMsg;

  for i := m_ItemList.Count - 1 downto 0 do begin
    UserItem := m_ItemList.Items[i];
    if (UserItem <> nil) and (UserItem.MakeIndex = nMakeIndex) then begin
      if TMerchant(NPC).ClientSellItem(Self, UserItem) then begin
        m_ItemList.Delete(i);
      end;
      break;
    end;
  end; // for
end;

procedure TPlayObject.ClientUserBuyItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  nIdent, nInt, nZz: Integer;
  boBindGold: Boolean;
  NPC: TNormNPC;
begin
  if m_boGhost or m_boDeath then
    exit;
  nIdent := ProcessMsg.wIdent;
  nInt := ProcessMsg.nParam2;
  boBindGold := ProcessMsg.nParam3 = 1;
  nZz := ProcessMsg.wParam;

  if (nZz < 1) or (nZz > 999) then
    Exit;
  NPC := TNormNPC(GetSelectNPC(Integer(m_ClickNPC)));
  if (NPC = nil) or (not (NPC is TMerchant)) then
    exit;
  if not TMerchant(NPC).m_boBuy then
    exit;
  try
    TMerchant(NPC).ClientBuyItem(Self, nInt, nZz, boBindGold);
  except
    on E: Exception do begin
      MainOutMessage('TUserHumah.ClientUserBuyItem wIdent = ' + IntToStr(nIdent));
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TPlayObject.ClientUserBuyReturnItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  nItemIndex, nIdx: Integer;
  UserItem, AddUserItem: pTUserItem;
  StdItem: pTStdItem;
  nPrice: Integer;
  nBack: Word;
  NPC: TNormNPC;
begin
  nItemIndex := MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3);
  nIdx := ProcessMsg.wParam;

  NPC := TNormNPC(GetSelectNPC(Integer(m_ClickNPC)));
  if (NPC = nil) or (not (NPC is TMerchant)) or (not TMerchant(NPC).m_boBuy) then
    NPC := nil;

  nBack := 0;
  if (NPC <> nil) then begin
    if (nIdx >= 0) and (nIdx < m_ReturnItemsList.Count) then begin
      UserItem := m_ReturnItemsList[nIdx];
      if UserItem.MakeIndex = nItemIndex then begin
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem <> nil then begin
          nPrice := GetUserItemPrice(UserItem, StdItem) div 2 * 3;
          if (nPrice > 0) and (m_nGold >= nPrice) then begin
            if AdditemToBag(UserItem, StdItem, False, '', '', AddUserItem) <> -1 then begin
              Dec(m_nGold, nPrice);
              m_ReturnItemsList.Delete(nIdx);
              if (Stditem.NeedIdentify = 1) then
                AddGameLog(Self, LOG_ADDITEM, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, NPC.m_sCharName,
                  '0', '0', '回购', UserItem);
              SendDefMessage(SM_BUYRETURNITEM_OK, m_nGold, LoWord(m_nBindGold), HiWord(m_nBindGold), nIdx, '');
              exit;
            end
            else
              nBack := 2;
          end
          else
            nBack := 1;
        end
        else begin
          Dispose(UserItem);
          m_ReturnItemsList.Delete(nIdx);
          ClientQueryReturnItems(ProcessMsg, boResult); //物品错误,重新发送回购物品列表
        end;
      end
      else
        ClientQueryReturnItems(ProcessMsg, boResult); //位置错误,重新发送回购物品列表
    end
    else
      ClientQueryReturnItems(ProcessMsg, boResult); //位置错误,重新发送回购物品列表
  end;
  SendDefMessage(SM_BUYRETURNITEM_FAIL, m_nGold, LoWord(m_nBindGold), HiWord(m_nBindGold), nBack, '');
end;

procedure TPlayObject.ClientGroupMode(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  m_nAllowSetup := LongWord(ProcessMsg.nParam1);
  SetAllowSetup;
  if not m_boAllowGroup then
    ClientGropuClose;

  {if ProcessMsg.nParam2 = 0 then
    ClientGropuClose()
  else
    m_boAllowGroup := True;

  if ProcessMsg.nParam3 = 0 then
    m_boCheckGroup := False
  else
    m_boCheckGroup := True;  }

  SendDefMessage(SM_GROUPMODECHANGED, Integer(m_nAllowSetup), 0, 0, 0, '');
end;

procedure TPlayObject.ClientDropGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  nGold: Integer;
begin
  if not m_boMapApoise then
    exit; //如果客户端地图未准备好,不允许
  nGold := ProcessMsg.nParam1;
  //Result := False;
  if (nGold <= 0) then
    Exit;
  if Self.m_PEnvir.m_boNOTHROWITEM then
  begin
    SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, g_sCanotDropItemMsg);
    Exit;
  end;
  if (g_Config.boInSafeDisableDrop and InSafeZone) then begin
    SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, g_sCanotDropInSafeZoneMsg);
    Exit;
  end;

  if g_Config.boControlDropItem and (nGold < g_Config.nCanDropGold) then begin
    SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, g_sCanotDropGoldMsg);
    Exit;
  end;

  if nGold >= m_nGold then
    Exit;
  Dec(m_nGold, nGold);
  if not DropGoldDown(nGold, False, nil, Self) then
    Inc(m_nGold, nGold);
  GoldChanged();
  //Result := True;
end;

procedure TPlayObject.ClientDropItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  i: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  Result: Boolean;
  nItemIdx: Integer;
  //  sCheckItemName: string;
label
  lExit;
begin
  Result := False;
  try
    if not m_boMapApoise then
      goto lExit;

    if Self.m_PEnvir.m_boNOTHROWITEM then
    begin
      SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, g_sCanotDropItemMsg);
      goto lExit;
    end;

    nItemIdx := ProcessMsg.nParam1;

    if (g_Config.boInSafeDisableDrop and InSafeZone) then begin
      SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, g_sCanotDropInSafeZoneMsg);
      goto lExit;
    end;

    if (GetTickCount - m_DealLastTick) > 3000 then begin
      for i := m_ItemList.Count - 1 downto 0 do begin
        if m_ItemList.Count <= 0 then
          break;
        UserItem := m_ItemList.Items[i];
        if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem = nil then
            goto lExit;
          //无法丢弃
          if CheckItemBindMode(UserItem, bm_NoDrop) or Self.m_PEnvir.m_boNOTHROWITEM then begin
            break;
          end;
          //丢弃消失
          if CheckItemBindMode(UserItem, bm_DropDestroy) then begin
            m_ItemList.Delete(i);
            if Stditem.NeedIdentify = 1 then
              AddGameLog(Self, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, '0', '消失', '0',
                '丢弃', UserItem);
            MapEventCheck(OS_DROPITEM, StdItem.Name);
            EventCheck(OS_DROPITEM, StdItem.Name);
            //扔物品地图事件触发
            DisPose(UserItem);
            Result := True;
            break;
          end;
          if g_Config.boControlDropItem and (StdItem.Price < g_Config.nCanDropPrice) then begin
            DisPose(UserItem);
            m_ItemList.Delete(i);
            Result := True;
            break;
          end;
          if DropItemDown(UserItem, 1, False, nil, Self) then begin
            DisPose(UserItem);
            m_ItemList.Delete(i);
            Result := True;
            MapEventCheck(OS_DROPITEM, StdItem.Name);
            EventCheck(OS_DROPITEM, StdItem.Name);
            //扔物品地图事件触发
            break;
          end;
          //end;
        end;
      end;
    end;
lExit:
  finally
    if Result then
      SendDefMessage(SM_DROPITEM_SUCCESS, ProcessMsg.nParam1, 0, 0, 0, '')
    else
      SendDefMessage(SM_DROPITEM_FAIL, ProcessMsg.nParam1, 0, 0, 0, '');
  end;
end;
{
procedure TPlayObject.GoldChange(sChrName: string; nGold: Integer);
var
  s10, s14: string;
begin
  if nGold > 0 then begin
    s10 := '14';
    s14 := '增加完成';
  end
  else begin
    s10 := '13';
    s14 := '以删减';
  end;
  SysMsg(sChrName + ' 的金币 ' + IntToStr(nGold) + ' 金币' + s14, c_Green, t_Hint);
  if g_boGameLogGold then
    AddGameDataLog(s10 + #9 +
      m_sMapName + #9 +
      IntToStr(m_nCurrX) + #9 +
      IntToStr(m_nCurrY) + #9 +
      m_sCharName + #9 +
      sSTRING_GOLDNAME + #9 +
      IntToStr(nGold) + #9 +
      '1' + #9 +
      sChrName);
end;       }

procedure TPlayObject.ClearStatusTime;
begin
  SafeFillChar(m_wStatusTimeArr, SizeOf(TStatusTime), #0);
end;

procedure TPlayObject.SendMapDescription;
var
  nMUSICID: Integer;
begin
  nMUSICID := -1;
  if m_PEnvir.m_boMUSIC then
    nMUSICID := m_PEnvir.m_nMUSICID;
  SendDefMessage(SM_MAPDESCRIPTION, nMUSICID, 0, 0, 0, m_PEnvir.sMapDesc);
end;

procedure TPlayObject.SendNoticeEx(MD5: string);
var
  sMissionMD5, MissionDataMD5, ItemDataMD5, MagicDataMD5, MapDescDataMD5, MakeMagicDataMD5: string;
begin
  sMissionMD5 := DecodeString(MD5);
  sMissionMD5 := GetValidStr3(sMissionMD5, MissionDataMD5, [#9]);
  sMissionMD5 := GetValidStr3(sMissionMD5, ItemDataMD5, [#9]);
  sMissionMD5 := GetValidStr3(sMissionMD5, MagicDataMD5, [#9]);
  sMissionMD5 := GetValidStr3(sMissionMD5, MapDescDataMD5, [#9]);
  sMissionMD5 := GetValidStr3(sMissionMD5, MakeMagicDataMD5, [#9]);
  //MainOutMessage('C: ' + sMissionMD5);
  //MainOutMessage('S: ' + g_sMissionDataMD5);
  //MainOutMessage(DecodeString(MD5));

  if (g_sMissionDataMD5 <> MissionDataMD5) then begin
    //MainOutMessage('1C: ' + MissionDataMD5);
    //MainOutMessage('1S: ' + g_sMissionDataMD5);
    m_DefMsg := MakeDefaultMsg(SM_CLIENTDATAFILE, g_nMissionDataLen, 0, 0, 1);
    SendSocket(@m_DefMsg, g_sMissionData);
  end;

  if (g_sItemDataMD5 <> ItemDataMD5) then begin
    //MainOutMessage('2C: ' + ItemDataMD5);
    //MainOutMessage('2S: ' + g_sItemDataMD5);
    m_DefMsg := MakeDefaultMsg(SM_CLIENTDATAFILE, g_nItemDataLen, 0, 0, 2);
    SendSocket(@m_DefMsg, g_sItemData);
  end;

  if (g_sMagicDataMD5 <> MagicDataMD5) then begin
    //MainOutMessage('3C: ' + MagicDataMD5);
    //MainOutMessage('3S: ' + g_sMagicDataMD5);
    m_DefMsg := MakeDefaultMsg(SM_CLIENTDATAFILE, g_nMagicDataLen, 0, 0, 3);
    SendSocket(@m_DefMsg, g_sMagicData);
  end;

  if (g_sMapDescDataMD5 <> MapDescDataMD5) then begin
    //MainOutMessage('4C: ' + MapDescDataMD5);
    //MainOutMessage('4S: ' + g_sMapDescDataMD5);
    m_DefMsg := MakeDefaultMsg(SM_CLIENTDATAFILE, g_nMapDescDataLen, 0, 0, 4);
    SendSocket(@m_DefMsg, g_sMapDescData);
  end;

  if (g_sMakeMagicDataMD5 <> MakeMagicDataMD5) then begin
    //MainOutMessage('5C: ' + MakeMagicDataMD5);
    //MainOutMessage('5S: ' + g_sMakeMagicDataMD5);
    m_DefMsg := MakeDefaultMsg(SM_CLIENTDATAFILE, g_nMakeMagicDataLen, g_nMakeMagicCount, 0, 5);
    SendSocket(@m_DefMsg, g_sMakeMagicData);
  end;
  SendDefMessage(SM_CLIENTDATAFILE, 0, 0, 0, 0, '');
end;

procedure TPlayObject.SendNotice;
{var
  LoadList: TStringList;
  i: Integer;
  sNoticeMsg: string; }
begin
  {LoadList := TStringList.Create;
  NoticeManager.GetNoticeMsg('Notice', LoadList);
  sNoticeMsg := '';
  for i := 0 to LoadList.Count - 1 do begin
    sNoticeMsg := sNoticeMsg + LoadList.Strings[i] + #$20#$1B;
  end;
  LoadList.Free;     }
  SendDefMessage(SM_SENDNOTICE, 0, 0, 0, 0, '');
end;

procedure TPlayObject.SetAllowSetup;
begin
  m_boAllowGroupReCall := CheckIntStatus(m_nAllowSetup, GPS_GROUPRECALL); //0x10E  //允许天地合一
  m_boAllowGuildReCall := CheckIntStatus(m_nAllowSetup, GSP_GUILDRECALL); //0xFC   //允许行会合一
  m_boOldChangeMapMode := CheckIntStatus(m_nAllowSetup, GSP_OLDCHANGEMAP); //0xFC   //允许行会合一
  m_boCheckGroup := CheckIntStatus(m_nAllowSetup, GSP_GROUPCHECK); //0xB0   组队需要验证
  m_boAllowGroup := not CheckIntStatus(m_nAllowSetup, GSP_NOTGROUP); //0xB0  允许组队
  m_boAllowGuild := not CheckIntStatus(m_nAllowSetup, GSP_NOTGUILD); //0xB1  允许加入行会
  m_boAllowFrieng := not CheckIntStatus(m_nAllowSetup, GSP_NOTFRIENG); //允许加为好友

  m_boBanHearChat := not CheckIntStatus(m_nAllowSetup, GSP_NOTSAYHEAR); //允许白字聊天
  m_boHearWhisper := not CheckIntStatus(m_nAllowSetup, GSP_NOTSAYWHISPER); //0x27C  允许私聊
  m_boBanShout := not CheckIntStatus(m_nAllowSetup, GSP_NOTSAYCRY); //0x27D  允许喊话
  m_boBanGuildChat := not CheckIntStatus(m_nAllowSetup, GSP_NOTSAYGUILD); //0x27E  允许行会聊天
  m_boBanGroupChat := not CheckIntStatus(m_nAllowSetup, GSP_NOTSAYGROUP); //允许队伍聊天
  m_boAllowDeal := not CheckIntStatus(m_nAllowSetup, GSP_NOTDEAL); //0x27F  允许交易
end;

procedure TPlayObject.UserOffLineLogon();
var
  i: Integer;
  sIPaddr: string;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::UserOffLineLogon';
  sCheckIPaddrFail = '登录IP地址不匹配.';
begin
  sIPaddr := '';
{$IFDEF PLUGOPEN}
  try
    if Assigned(zPlugOfEngine.HookUserLoginStart) then begin
      zPlugOfEngine.HookUserLoginStart(Self);
    end;
  except
  end;
{$ENDIF}
  try
    m_boReconnection := False;
    if g_Config.boTestServer then begin
      if m_Abil.Level < g_Config.nTestLevel then
        m_Abil.Level := g_Config.nTestLevel;
      if m_nGold < g_Config.nTestGold then
        m_nGold := g_Config.nTestGold;
    end;
    m_dLogonTime := Now();
    {if g_Config.boTestServer or (g_Config.boServiceMode) then
      m_nPayMent := 3;   }
    {m_dwMapMoveTick := GetTickCount();
    m_dLogonTime := Now();
    m_LoginTime := Now();
    m_dwLogonTick := GetTickCount();
    Initialize();
    m_dwMapApoiseTick := GetTickCount;  }
    m_dwLogonTick := GetTickCount();
    SendMsg(Self, RM_LOGON, 0, 0, 0, 0, '');
    if m_Abil.Level <= 7 then begin
      if GetRangeHumanCount >= 80 then begin
        MapRandomMove(m_PEnvir, 0);
      end;
    end;
    if m_boDieInFight3Zone then begin
      MapRandomMove(m_PEnvir, 0);
    end;
    if UserEngine.GetHumPermission(m_sCharName, sIPaddr, m_btPermission) then begin
{$IF VEROWNER = WL}
      if not CompareIPaddr(m_sIPaddr, sIPaddr) then begin
        SysMsg(sCheckIPaddrFail, c_Red, t_Hint);
        m_boEmergencyClose := True;
        m_boPlayOffLine := False;
      end;
{$IFEND}
    end;
    GetStartPoint(); //取回城坐标

    m_nCharStatus := GetCharStatus();

    CheckUserItemTime(True);
    SetAllowSetup;
    RecalcBagCount();
    RecalcNakedAbilitys();
    RecalcLevelAbilitys();
    RecalcAbilitys();
    RecalcCboMagicList();

    if m_MagicArr[SKILL_SHOWHP] <> nil then
      sub_4C713C(m_MagicArr[SKILL_SHOWHP]);

    if (m_nGold > g_Config.nHumanMaxGold * 2) and (g_Config.nHumanMaxGold > 0) then
      m_nGold := g_Config.nHumanMaxGold * 2;

    case m_btAttatckMode of
      HAM_ALL: SysMsg(sAttackModeOfAll, c_Green, t_Hint); //[攻击模式: 全体攻击]
      HAM_PEACE: SysMsg(sAttackModeOfPeaceful, c_Green, t_Hint); //[攻击模式: 和平攻击]
      HAM_DEAR: SysMsg(sAttackModeOfDear, c_Green, t_Hint); //[攻击模式: 和平攻击]
      HAM_MASTER: SysMsg(sAttackModeOfMaster, c_Green, t_Hint); //[攻击模式: 和平攻击]
      HAM_GROUP: SysMsg(sAttackModeOfGroup, c_Green, t_Hint); //[攻击模式: 编组攻击]
      HAM_GUILD: SysMsg(sAttackModeOfGuild, c_Green, t_Hint); //[攻击模式: 行会攻击]
      HAM_PKATTACK: SysMsg(sAttackModeOfRedWhite, c_Green, t_Hint); //[攻击模式: 红名攻击]
    end;
    SysMsg(sStartChangeAttackModeHelp, c_Green, t_Hint);
    //使用组合快捷键 CTRL-H 更改攻击...
    m_Abil.MaxExp := GetLevelExp(m_Abil.Level);
    m_WAbil.MaxExp := m_Abil.MaxExp;
    //jacky 2004/09/15 登录重新取得升级所需经验值
    SendAbility;
    SendSubAbility;
    //SendMsg(Self, RM_NAKEDABILITY, 0, 0, 0, 0, '');
    //  FeatureChanged(); //增加，广播人物骑马信息
    //m_MyGuild := g_GuildManager.MemberOfGuild(m_sCharName);
    if m_MyGuild <> nil then begin
      m_dwGuildTick := GetTickCount + 60 * 60 * 1000;
      TGuild(m_MyGuild).MemberLogin(Self);
      for i := 0 to TGuild(m_MyGuild).m_GuildWarList.Count - 1 do begin
        SysMsg(TGuild(m_MyGuild).m_GuildWarList.Strings[i] + ' 正在与本行会进行行会战。', c_Green, t_Hint);
      end;
    end;
    RefShowName();
    if (m_MagicArr[SKILL_ERGUM] <> nil) and (not m_boUseThrusting) then begin
      m_boUseThrusting := True;
      SendSocket(nil, '+LNG');
    end;
    {if m_PEnvir.m_boNORECONNECT then   //已改至人物登录前处理
      MapRandomMove(m_PEnvir.sNoReconnectMap, 0)
    else }
    GetStartType(); //刷新人物当前所在位置的状态

    NpcGotoLable(g_ManageNPC, g_ManageNPC.FGotoLable[nResume], False);

    m_boFixedHideMode := False; //01/21 增加
    // PlayObject.Create 过程里被置为True，在执行完登录脚本后再置False
    {if m_sDearName <> '' then CheckMarry();
    CheckMaster();
    CheckFriend();  }

    m_boFilterSendMsg := GetDisableSendMsgList(m_sCharName);

    //重置泡点方面计时
    //m_dwIncGamePointTick := GetTickCount();
    //m_dwIncGameGoldTick := GetTickCount();
    m_ADListIndex := 0;
    m_ADTick := GetTickCount;

    m_dwAutoGetExpTick := GetTickCount();
    if m_dwKillMonExpRateTime > 0 then begin
      SysMsg(format(g_sChangeKillMonExpRateMsg, [m_nKillMonExpRate / 100, m_dwKillMonExpRateTime]), c_Green, t_Hint);
      ChangeStatusMode(STATUS_EXP, True);
    end;

    for i := Low(m_wStatusTimeArr) to High(m_wStatusTimeArr) do begin
      if m_wStatusTimeArr[i] > 0 then begin
        if I = STATE_DEFENCEUP then ChangeStatusMode(STATUS_AC, True);
        if I = STATE_TRANSPARENT then ChangeStatusMode(STATUS_HIDEMODE, True);
        if I = POISON_STONE then ChangeStatusMode(STATUS_STONE, True);
        if I = STATE_MAGDEFENCEUP then ChangeStatusMode(STATUS_MAC, True);
        if I = POISON_DAMAGEARMOR then ChangeStatusMode(STATUS_DAMAGEARMOR, True);
        if I = POISON_DECHEALTH then ChangeStatusMode(STATUS_DECHEALTH, True);
        if I = POISON_COBWEB then ChangeStatusMode(STATUS_COBWEB, True);
      end;
    end;
{$IF Var_Free = 1}
    //您正在使用的是361引擎免费版！
    //SysMsg(frmMain.enmsg.DecryptStr('MZ2jn==xgnHIHvUBJx2P1NW2bVZQQgYyA2di+MFuKoWfS566'), c_Red, t_Hint); //enmsg
{$IFEND}
    SendMsg(Self, RM_OFFLINESHOP, 0, 0, 0, 0, '');
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
{$IFDEF PLUGOPEN}
  try
    if Assigned(zPlugOfEngine.HookUserLoginEnd) then begin
      zPlugOfEngine.HookUserLoginEnd(Self);
    end;
  except
  end;
{$ENDIF}
end;

procedure TPlayObject.UserLogon;
var
  i: Integer;
  UserItem: pTUserItem;
  //  StdItem: PTStdItem;
  sItem: string;
  sIPaddr: string;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::UserLogon';
  sCheckIPaddrFail = '登录IP地址不匹配.';
begin
  sIPaddr := '';
{$IFDEF PLUGOPEN}
  try
    if Assigned(zPlugOfEngine.HookUserLoginStart) then begin
      zPlugOfEngine.HookUserLoginStart(Self);
    end;
  except
  end;
{$ENDIF}
  try
    if g_Config.boTestServer then begin
      if m_Abil.Level < g_Config.nTestLevel then
        m_Abil.Level := g_Config.nTestLevel;
      if m_nGold < g_Config.nTestGold then
        m_nGold := g_Config.nTestGold;
    end;
    {if g_Config.boTestServer or (g_Config.boServiceMode) then
      m_nPayMent := 3;   }
    m_dwMapMoveTick := GetTickCount();
    m_dLogonTime := Now();
    m_LoginTime := Now();
    m_dwLogonTick := GetTickCount();
    Initialize();
    m_dwMapApoiseTick := GetTickCount;
    SendMsg(Self, RM_LOGON, 0, 0, 0, 0, '');
    if m_Abil.Level <= 7 then begin
      if GetRangeHumanCount >= 80 then begin
        MapRandomMove(m_PEnvir, 0);
      end;
    end;
    if m_boDieInFight3Zone then begin
      MapRandomMove(m_PEnvir, 0);
    end;
    if UserEngine.GetHumPermission(m_sCharName, sIPaddr, m_btPermission) then begin
{$IF VEROWNER = WL}
      if not CompareIPaddr(m_sIPaddr, sIPaddr) then begin
        SysMsg(sCheckIPaddrFail, c_Red, t_Hint);
        m_boEmergencyClose := True;
        m_boPlayOffLine := False;
      end;
{$IFEND}
    end;
    GetStartPoint(); //取回城坐标

    if m_ItemList <> nil then begin
      if m_boNewHuman then begin
        New(UserItem);
        if UserEngine.CopyToUserItemFromName(g_Config.sCandle, UserItem) then begin
          m_ItemList.Add(UserItem);
        end
        else
          DisPose(UserItem);

        New(UserItem);
        if UserEngine.CopyToUserItemFromName(g_Config.sBasicDrug, UserItem) then begin
          m_ItemList.Add(UserItem);
        end
        else
          DisPose(UserItem);

        New(UserItem);
        if UserEngine.CopyToUserItemFromName(g_Config.sWoodenSword, UserItem) then begin
          m_ItemList.Add(UserItem);
        end
        else
          DisPose(UserItem);

        New(UserItem);
        if m_btGender = 0 then
          sItem := g_Config.sClothsMan
        else
          sItem := g_Config.sClothsWoman;

        if UserEngine.CopyToUserItemFromName(sItem, UserItem) then begin
          m_ItemList.Add(UserItem);
        end
        else
          DisPose(UserItem);
        {m_nNakedCount := g_Config.NakedAddInfo.nNakedLevelUpAddCount; }
        Magic := UserEngine.FindMagic(SKILL_CBO);
        if Magic <> nil then begin
          New(UserMagic);
          UserMagic.MagicInfo := Magic;
          UserMagic.wMagIdx := Magic.wMagicId;
          UserMagic.btLevel := 3;
          UserMagic.nTranPoint := 0;
          UserMagic.dwInterval := 0;
          UserMagic.btKey := 0;
          m_MagicList.Add(UserMagic);
        end;
        m_nNakedCount := 0;
        m_boAllowGroup := True;
        m_boCheckGroup := True;
      end;
    end;

    for i := Low(m_dwStatusArrTick) to High(m_dwStatusArrTick) do begin
      if m_wStatusTimeArr[i] > 0 then begin
        m_dwStatusArrTick[i] := GetTickCount();
      end;
    end;

    m_nCharStatus := GetCharStatus();

    CheckUserItemTime(True);
    LiteraryChange(False);
    SetAllowSetup;
    RecalcBagCount();
    RecalcNakedAbilitys();
    RecalcLevelAbilitys();
    RecalcAbilitys();
    RecalcCboMagicList();

    if m_MagicArr[SKILL_SHOWHP] <> nil then
      sub_4C713C(m_MagicArr[SKILL_SHOWHP]);

    if (m_nGold > g_Config.nHumanMaxGold * 2) and (g_Config.nHumanMaxGold > 0) then
      m_nGold := g_Config.nHumanMaxGold * 2;

    case m_btAttatckMode of
      HAM_ALL: SysMsg(sAttackModeOfAll, c_Green, t_Hint); //[攻击模式: 全体攻击]
      HAM_PEACE: SysMsg(sAttackModeOfPeaceful, c_Green, t_Hint); //[攻击模式: 和平攻击]
      HAM_DEAR: SysMsg(sAttackModeOfDear, c_Green, t_Hint); //[攻击模式: 和平攻击]
      HAM_MASTER: SysMsg(sAttackModeOfMaster, c_Green, t_Hint); //[攻击模式: 和平攻击]
      HAM_GROUP: SysMsg(sAttackModeOfGroup, c_Green, t_Hint); //[攻击模式: 编组攻击]
      HAM_GUILD: SysMsg(sAttackModeOfGuild, c_Green, t_Hint); //[攻击模式: 行会攻击]
      HAM_PKATTACK: SysMsg(sAttackModeOfRedWhite, c_Green, t_Hint); //[攻击模式: 红名攻击]
    end;
    SysMsg(sStartChangeAttackModeHelp, c_Green, t_Hint);
    //使用组合快捷键 CTRL-H 更改攻击...
    m_Abil.MaxExp := GetLevelExp(m_Abil.Level);
    m_WAbil.MaxExp := m_Abil.MaxExp;
    //jacky 2004/09/15 登录重新取得升级所需经验值
    SendAbility;
    SendSubAbility;
    //SendMsg(Self, RM_NAKEDABILITY, 0, 0, 0, 0, '');
    //  FeatureChanged(); //增加，广播人物骑马信息
    //m_MyGuild := g_GuildManager.MemberOfGuild(m_sCharName);
    if m_MyGuild <> nil then begin
      m_dwGuildTick := GetTickCount + 60 * 60 * 1000;
      TGuild(m_MyGuild).MemberLogin(Self);
      for i := 0 to TGuild(m_MyGuild).m_GuildWarList.Count - 1 do begin
        SysMsg(TGuild(m_MyGuild).m_GuildWarList.Strings[i] + ' 正在与本行会进行行会战。', c_Green, t_Hint);
      end;
    end;
    RefShowName();
    if (m_MagicArr[SKILL_ERGUM] <> nil) and (not m_boUseThrusting) then begin
      m_boUseThrusting := True;
      SendSocket(nil, '+LNG');
    end;
    {if m_PEnvir.m_boNORECONNECT then   //已改至人物登录前处理
      MapRandomMove(m_PEnvir.sNoReconnectMap, 0)
    else }
    GetStartType(); //刷新人物当前所在位置的状态

    NpcGotoLable(g_ManageNPC, g_ManageNPC.FGotoLable[nLogin], False);

    m_boFixedHideMode := False; //01/21 增加
    // PlayObject.Create 过程里被置为True，在执行完登录脚本后再置False
    if m_sDearName <> '' then
      CheckMarry();
    CheckMaster();
    CheckFriend();

    m_boFilterSendMsg := GetDisableSendMsgList(m_sCharName);

    //重置泡点方面计时
    //m_dwIncGamePointTick := GetTickCount();
    //m_dwIncGameGoldTick := GetTickCount();
    m_dwAutoGetExpTick := GetTickCount();
    if m_dwKillMonExpRateTime > 0 then begin
      SysMsg(format(g_sChangeKillMonExpRateMsg, [m_nKillMonExpRate / 100, m_dwKillMonExpRateTime]), c_Green, t_Hint);
      ChangeStatusMode(STATUS_EXP, True);
    end;

    for i := Low(m_wStatusTimeArr) to High(m_wStatusTimeArr) do begin
      if m_wStatusTimeArr[i] > 0 then begin
        if I = STATE_DEFENCEUP then ChangeStatusMode(STATUS_AC, True);
        if I = STATE_TRANSPARENT then ChangeStatusMode(STATUS_HIDEMODE, True);
        if I = POISON_STONE then ChangeStatusMode(STATUS_STONE, True);
        if I = STATE_MAGDEFENCEUP then ChangeStatusMode(STATUS_MAC, True);
        if I = POISON_DAMAGEARMOR then ChangeStatusMode(STATUS_DAMAGEARMOR, True);
        if I = POISON_DECHEALTH then ChangeStatusMode(STATUS_DECHEALTH, True);
        if I = POISON_COBWEB then ChangeStatusMode(STATUS_COBWEB, True);
      end;
    end;
{$IF Var_Free = 1}
    //您正在使用的是361引擎免费版！
    //SysMsg(frmMain.enmsg.DecryptStr('MZ2jn==xgnHIHvUBJx2P1NW2bVZQQgYyA2di+MFuKoWfS566'), c_Red, t_Hint); //enmsg
{$IFEND}
    m_ADListIndex := 0;
    m_ADTick := GetTickCount;
    SetLoginPlay(m_nDBIndex, Self);
    UserEMail.SendMsg(EMS_USERLOGIN, m_nDBIndex, Integer(m_boNewHuman), 0, 0, m_sCharName, nil);
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
{$IFDEF PLUGOPEN}
  try
    if Assigned(zPlugOfEngine.HookUserLoginEnd) then begin
      zPlugOfEngine.HookUserLoginEnd(Self);
    end;
  except
  end;
{$ENDIF}
end;

procedure TPlayObject.SendNakedAbility;
var
  ClientNakedInfo: TClientNakedInfo;
begin
  ClientNakedInfo.NakedAbil := m_NakedAbil;
  ClientNakedInfo.NakedAddInfo := g_Config.NakedAddInfo;
  m_DefMsg := MakeDefaultMsg(SM_NAKEDABILITY, m_nNakedCount, LoWord(m_nNakedBackCount), HiWord(m_nNakedBackCount), 0);
  SendSocket(@m_DefMsg, EncodeBuffer(@ClientNakedInfo, SizeOf(ClientNakedInfo)));
end;

procedure TPlayObject.SendRealityInfo;
begin
//  SendDefMessage(SM_REALITYINFO, Integer(m_RealityInfo.boFriendSee),
//    MakeWord(m_RealityInfo.btOld, m_RealityInfo.btSex),
//    MakeWord(m_RealityInfo.btProvince, m_RealityInfo.btCity),
//    MakeWord(m_RealityInfo.btArea, m_RealityInfo.btOnlineTime),
//    m_RealityInfo.sPhotoID + '/' + m_RealityInfo.sUserName + '/' + m_RealityInfo.sIdiograph);
end;

procedure TPlayObject.SendGameSetupInfo;
begin
  if m_UserOptionSetup.nOptionSetup <> 0 then begin
    m_DefMsg := MakeDefaultMsg(SM_GAMESETUPINFO, 0, 0, 0, 1);
    SendSocket(@m_DefMsg, EncodeBuffer(@m_UserOptionSetup, SizeOf(m_UserOptionSetup)));

    if (m_wItemsSetupCount > 0) and (m_wItemsSetupCount <= MAXITEMSSETUPCOUNT) then begin
      m_DefMsg := MakeDefaultMsg(SM_GAMESETUPINFO, m_wItemsSetupCount, 0, 0, 2);
      SendSocket(@m_DefMsg, EncodeBuffer(@m_UserItemsSetup[0], SizeOf(Word) * m_wItemsSetupCount));
    end
    else begin
      m_DefMsg := MakeDefaultMsg(SM_GAMESETUPINFO, 0, 0, 0, 2);
      SendSocket(@m_DefMsg, '');
    end;
  end;
end;

procedure TPlayObject.SendMakeMagic;
begin
  m_DefMsg := MakeDefaultMsg(SM_MAKEMAGIC, 0,
    MakeWord(g_Config.btMakeMagicAddPoint, g_Config.btMakeMagicUsePoint),
    MakeWord(g_Config.btMakeMagicAddRate, g_Config.btMakeMagicMaxLevel),
    m_nMakeMagicPoint);
  SendSocket(@m_DefMsg, EncodeBuffer(@m_MakeMagic[0], SizeOf(TMakeMagic)));
end;

procedure TPlayObject.SendMissionInfo;
var
  sSENDMSG: string;
  I: Integer;
begin
  m_DefMsg := MakeDefaultMsg(SM_MISSIONINFO, 0, 0, 0, MISSTAG_FLAGLIST);
  SendSocket(@m_DefMsg, EncodeBuffer(@m_MissionFlag[0], SizeOf(m_MissionFlag)));

  SendMissionInfoArithmometer(False);

  sSENDMSG := '';
  for I := Low(m_MissionInfo) to High(m_MissionInfo) do begin
    if m_MissionInfo[I].sMissionName <> '' then begin
      sSENDMSG := sSENDMSG + IntToStr(I) + '/';
      sSENDMSG := sSENDMSG + EncodeBuffer(@m_MissionInfo[I], SizeOf(TMissionInfo)) + '/';
    end;
  end;
  if sSENDMSG <> '' then begin
    m_DefMsg := MakeDefaultMsg(SM_MISSIONINFO, 0, 0, 0, MISSTAG_MISSIONLIST);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;
end;

procedure TPlayObject.SendMissionInfoArithmometer(boFillChar: Boolean);
begin
  m_DefMsg := MakeDefaultMsg(SM_MISSIONINFO, 0, 0, Integer(boFillChar), MISSTAG_ARITHMOMETERLIST);
  SendSocket(@m_DefMsg, EncodeBuffer(@m_MissionArithmometer[0], SizeOf(m_MissionArithmometer)));
end;

procedure TPlayObject.SendGoldInfo(boSendName: Boolean);
var
  sStr: string;
begin
  if boSendName then
    sStr := g_Config.sGameGoldName
  else
    sStr := ''; 
  SendDefMessage(SM_GAMEGOLDNAME, m_nGameGold, LoWord(m_nGamePoint), HiWord(m_nGamePoint),
    m_nPullulation div MIDPULLULATION, sStr);
end;

procedure TPlayObject.SendLogon;
var
  MessageBodyWL: TMessageBodyWL;
  nRecog: Integer;
  SplitDateTime: TSplitDateTime;
begin
  m_dwMissionTime := GetTickCount + 60 * 1000;
  m_DefMsg := MakeDefaultMsg(SM_LOGON, Integer(Self), m_nCurrX, m_nCurrY, m_btDirection);
  MessageBodyWL.lParam1 := GetFeatureToLong();
  MessageBodyWL.lParam2 := m_nCharStatus;
  MessageBodyWL.lTag1 := Integer(m_nAllowSetup) {MakeLong(Integer(m_boAllowGroup), Integer(m_boCheckGroup))};
  MessageBodyWL.lTag2 := MakeLong(m_nPullulation div MIDPULLULATION, 0);
  SendSocket(@m_DefMsg, EncodeBuffer(@MessageBodyWL, SizeOf(TMessageBodyWL)));
  nRecog := GetFeatureToLong();
  SendDefMessage(SM_FEATURECHANGED, Integer(Self), LoWord(nRecog), HiWord(nRecog), GetFeatureEx, IntToStr(m_btStrengthenName));
  SplitDateTime.DateTime := Now;
  SendDefMessage(SM_SERVERTIME, SplitDateTime.nInt, SplitDateTime.wWord, SplitDateTime.wWord2, 0, '');
  SendAbilityMoveSet;
  SendCompoundInfos;
end;

procedure TPlayObject.SendAbilityMoveSet;
var
  sSENDMSG: string;
begin
  sSENDMSG := EncodeBuffer(PAnsiChar(@g_Config.vAbilityMoveSet), SizeOf(TAbilityMoveSet));
  SendDefMessage(SM_ABILITYMOVESET, 0, 0, 0, 0, sSENDMSG);
end;

procedure TPlayObject.SendCompoundInfos;
var
  i: Integer;
  sSENDMSG: string;
  pCompoundInfos: pTCompoundInfos;
begin
  sSENDMSG := EncodeBuffer(PAnsiChar(@g_Config.vCompoundSet), SizeOf(TCompoundSet)) + '/';
  for i := 0 to g_CompoundInfoList.Count - 1 do
  begin
    pCompoundInfos := pTCompoundInfos(g_CompoundInfoList.Objects[i]);
    if (pCompoundInfos = nil) then
      Continue;
    sSENDMSG := sSENDMSG + EncodeString(g_CompoundInfoList.Strings[i]) + '/';
    sSENDMSG := sSENDMSG + EncodeBuffer(PAnsiChar(pCompoundInfos), SizeOf(TCompoundInfos)) + '/';
  end;
  if sSENDMSG <> '' then
    SendDefMessage(SM_COMPOUNDINFOS, 0, 0, 0, 0, sSENDMSG);
end;

procedure TPlayObject.ClientTakeBackStorageItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  //Merchant: TMerchant;
  UserItem, AddUserItem: pTUserItem;
  StdItem: pTStdItem;
  nItemIdx, nGirdIdx, nIdx: Integer;
  StorageItem: pTStorageItem;
  NPC: TNormNPC;
label
  StorageFail;
begin
  if not m_boStorageOpen[0] or m_boStorageLock then
    exit;
  nItemIdx := MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3);
  nIdx := LoByte(ProcessMsg.wParam);
  nGirdIdx := HiByte(ProcessMsg.wParam);
  if not g_Config.boTryModeUseStorage then begin
    SysMsg(g_sTryModeCanotUseStorage, c_Red, t_Hint);
    goto StorageFail;
  end;
  if (nIdx in [Low(m_StorageItemList)..High(m_StorageItemList)]) and m_boStorageOpen[nIdx] then begin
    if (nGirdIdx >= 0) and (nGirdIdx < m_StorageItemList[nIdx].Count) then begin
      StorageItem := m_StorageItemList[nIdx].Items[nGirdIdx];
      if StorageItem.UserItem.MakeIndex = nItemIdx then begin
        StdItem := UserEngine.GetStdItem(StorageItem.UserItem.wIndex);

        NPC := TNormNPC(GetSelectNPC(Integer(m_ClickNPC)));
        if (NPC = nil) or (not (NPC is TMerchant)) or (not TMerchant(NPC).m_boStorage) then
          NPC := nil;

        if (StdItem <> nil) and (NPC <> nil) then begin
          New(UserItem);
          UserItem^ := StorageItem.UserItem;
          if AddItemToBag(UserItem, StdItem, False, '', '', AddUserItem) <> -1 then begin
            SendDefMessage(SM_TAKEBACKSTORAGEITEM_OK, nItemIdx, 0, 0, 0, '');
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if (StdItem <> nil) and (Stditem.NeedIdentify = 1) then
              AddGameLog(Self, LOG_STORAGE, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, NPC.m_sCharName,
                IntToStr(nIdx), IntToStr(nGirdIdx), '取回', UserItem);
            m_StorageItemList[nIdx].Delete(nGirdIdx);
            Dispose(StorageItem);
            exit;
          end
          else
            Dispose(UserItem);
        end;
      end;
    end;

  end;
  StorageFail:
  SendDefMessage(SM_TAKEBACKSTORAGEITEM_FAIL, 0, nIdx, nGirdIdx, 0, '');
end;

procedure TPlayObject.ClientStorageItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  i: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  nItemIdx, nIdx, nGirdIdx: Integer;
  StorageItem: pTStorageItem;
  NPC: TNormNPC;
label
  StorageFail;
begin
  if not m_boStorageOpen[0] or m_boStorageLock then
    exit;
  nItemIdx := MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3);
  nIdx := LoByte(ProcessMsg.wParam);
  nGirdIdx := HiByte(ProcessMsg.wParam);
  if not g_Config.boTryModeUseStorage then begin
    SysMsg(g_sTryModeCanotUseStorage, c_Red, t_Hint);
    goto StorageFail;
  end;
  if (nIdx in [Low(m_StorageItemList)..High(m_StorageItemList)]) and IsStorage(nIdx) and m_boStorageOpen[nIdx] then begin
    NPC := TNormNPC(GetSelectNPC(Integer(m_ClickNPC)));
    if (NPC = nil) or (not (NPC is TMerchant)) or (not TMerchant(NPC).m_boStorage) then
      NPC := nil;
    if NPC <> nil then begin
      for i := m_ItemList.Count - 1 downto 0 do begin
        UserItem := m_ItemList.Items[i];
        if UserItem = nil then
          Continue;
        if (UserItem.MakeIndex = nItemIdx) then begin
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem = nil then
            break;
          if CheckItemBindMode(UserItem, bm_NoSave) then
            break;

          New(StorageItem);
          StorageItem.idx := nGirdIdx;
          StorageItem.UserItem := UserItem^;
          m_StorageItemList[nIdx].Add(StorageItem);
          m_ItemList.Delete(i);
          SendDefMessage(SM_STORAGE_OK, 0, nIdx, nGirdIdx, 0, '');
          if Stditem.NeedIdentify = 1 then
            AddGameLog(Self, LOG_STORAGE, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, NPC.m_sCharName,
              IntToStr(nIdx), IntToStr(nGirdIdx), '存储', UserItem);
          Dispose(UserItem);
          exit;
        end;
      end;
    end;
  end;
  StorageFail:
  SendDefMessage(SM_STORAGE_FAIL, 0, 0, 0, 0, '');
end;

function TPlayObject.IsStorage(nIdx: Byte): Boolean;
begin
  Result := m_StorageItemList[nIdx].Count < MAXSTORAGEITEMS;
end;

procedure TPlayObject.ClientGetBackStorage(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  NPC: TNormNPC;
  Idx: Integer;
  i: Integer;
  sSENDMSG: string;
  StorageItem: pTStorageItem;
begin
  NPC := TNormNPC(GetSelectNPC(Integer(m_ClickNPC)));
  if (NPC = nil) or (not (NPC is TMerchant)) or (not TMerchant(NPC).m_boStorage) then
    exit;
  if not m_boStorageOpen[0] or m_boStorageLock then
    exit;

  idx := Processmsg.nParam2;
  sSENDMSG := '';
  if Idx in [Low(m_StorageItemList)..High(m_StorageItemList)] then begin
    for i := 0 to m_StorageItemList[Idx].Count - 1 do begin
      StorageItem := pTStorageItem(m_StorageItemList[Idx].Items[i]);
      sSENDMSG := sSENDMSG + IntToStr(StorageItem.idx) + '/';
      sSENDMSG := sSENDMSG + MakeClientItem(@StorageItem.UserItem) + '/';
    end;
    m_DefMsg := MakeDefaultMsg(SM_SAVEITEMLIST, Idx, 0, 0, m_StorageItemList[Idx].Count);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;
end;

procedure TPlayObject.ClientQueryReturnItems(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  i: integer;
  sSendMsg: string;
begin
  sSendMsg := '';
  for I := 0 to m_ReturnItemsList.Count - 1 do begin
    sSendMsg := sSendMsg + MakeClientItem(pTUserItem(m_ReturnItemsList[i])) + '/'
  end;
  if sSendMsg <> '' then begin
    m_DefMsg := MakeDefaultMsg(SM_GETRETURNITEMS, 0, 0, 0, m_ReturnItemsList.Count);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;
end;

procedure TPlayObject.ClientCboMagic(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  m_CboMagicListInfo.nMagicList := ProcessMsg.nParam1;
  RecalcCboMagicList();
  SendDefMessage(SM_SENDMYMAGIC, m_CboMagicListInfo.nMagicList, 0, 0, 0, '');
end;

procedure TPlayObject.ClientTradeGameGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  ShopEngine.ClientTradeGameGold(Self, ProcessMsg.nParam1);
end;

procedure TPlayObject.ClientGetShopList(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  ShopEngine.ClientGetShopList(Self, ProcessMsg.nParam2);
end;

procedure TPlayObject.ClientBuyShopItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  ShopEngine.ClientBuyShopItem(Self, ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3, ProcessMsg.wParam);
end;

procedure TPlayObject.ServerTradeGameGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  ShopEngine.ServerTradeGameGold(Self, ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3,
    ProcessMsg.wParam, ProcessMsg.sMsg);
end;

procedure TPlayObject.ServerBuyShopItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  ShopEngine.ServerBuyShopItem(Self, ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3,
    ProcessMsg.wParam, ProcessMsg.sMsg);
end;

procedure TPlayObject.ServerChangeGameGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  ShopEngine.ServerChangeGameGold(Self, ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3,
    ProcessMsg.wParam, ProcessMsg.sMsg);
end;

//

procedure TPlayObject.ClientEMailInfo(ProcessMsg: pTProcessMessage; var boResult: Boolean);
  procedure AddEMailInfo(nItemIndex, nSendGold: Integer; body: string);
  var
    nGold: Integer;
    sUserName: string;
    sTitle: string;
    sText: string;
    EMailInfo: pTEMailInfo;
    UserItem: pTUserItem;
    Stditem: pTStdItem;
  begin
    try
      if nSendGold < 0 then
        nSendGold := 0;
      if (nItemIndex <> 0) and (not InSafeZone) then begin
        SendDefMessage(SM_EMAIL, -11, 0, 0, 2, '');
        exit;
      end;
      nGold := GetEMailGold(nSendGold, nItemIndex <> 0);
      if m_nGold < (nGold + nSendGold) then begin
        SendDefMessage(SM_EMAIL, -5, 0, 0, 2, '');
        exit;
      end;
      body := GetValidStr3(body, sUserName, ['/']);
      body := GetValidStr3(body, sTitle, ['/']);
      body := GetValidStr3(body, sText, ['/']);
      sUserName := Trim(DecodeString(sUserName));
      sTitle := Trim(DecodeString(sTitle));
      sText := DecodeString(sText);
      if (sUserName <> '') and (sTitle <> '') and (sText <> '') then begin
        if InFriendList(sUserName) then begin
          UserItem := nil;
          if nItemIndex > 0 then
            UserItem := GetBagitem(nItemIndex, True);

          if UserItem <> nil then begin
            Stditem := UserEngine.GetStdItem(UserItem.wIndex);
            if Stditem <> nil then begin
              if CheckItemBindMode(UserItem, bm_NoDeal) or (Self.m_PEnvir.m_boNODEAL) then begin
                m_ItemList.Add(UserItem);
                SendDefMessage(SM_EMAIL, -6, 0, 0, 2, '');
                Exit;
              end;
            end;
          end;

          IntegerChange(m_nGold, nGold + nSendGold, INT_DEL);
          if g_boGameLogGold then begin
            AddGameLog(Self, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, m_nGold, '信件', '-', IntToStr(nGold), '费用', nil);
            if nSendGold > 0 then
              AddGameLog(Self, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, m_nGold, sUserName, '-',
                IntToStr(nSendGold), '信件发送', nil);
          end;
          GoldChanged;
          New(EMailInfo);
          SafeFillChar(EMailInfo^, SizeOf(TEMailInfo), #0);
          if UserItem <> nil then begin
            m_dwSaveRcdTick := 0;
            Stditem := UserEngine.GetStdItem(UserItem.wIndex);
            if Stditem <> nil then begin
              if Stditem.NeedIdentify = 1 then
                AddGameLog(Self, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, sUserName,
                  IntToStr(Integer(EMailInfo)), '0', '信件发送', UserItem);
            end
            else begin
              Dispose(UserItem);
              UserItem := nil;
            end;
          end;
          EMailInfo.boDelete := False;
          EMailInfo.Header.boRead := False;
          EMailInfo.Header.boSystem := False;
          EMailInfo.Header.sTitle := sTitle;
          EMailInfo.Header.sSendName := m_sCharName;
          EMailInfo.Header.CreateTime := Now;
          EMailInfo.sReadName := sUserName;
          EMailInfo.nGold := nSendGold;
          if UserItem <> nil then begin
            EMailInfo.Item := UserItem^;
          end;
          EMailInfo.TextLen := _MIN(Length(sText), MAXEMAILTEXTLEN);
          Move(sText[1], EMailInfo.Text[0], EMailInfo.TextLen);
          if (nSendGold = 0) and (UserItem = nil) then
            EMailInfo.boDelete := True; //没有金币和物品,下次重启直接删除
          UserEMail.SendMsg(EMS_ADDEMAIL, m_nDBIndex, 0, 0, 0, '', EMailInfo);

          if UserItem <> nil then
            Dispose(UserItem);
        end
        else
          SendDefMessage(SM_EMAIL, -2, 0, 0, 2, '');
      end
      else begin
        SendDefMessage(SM_EMAIL, -1, 0, 0, 2, '');
      end;
    except
      on E: Exception do begin
        MainOutMessage('[Exception] TPlayObject.ClientEMailInfo.AddEMailInfo');
        MainOutMessage(E.Message);
      end;
    end;
  end;
begin
  case ProcessMsg.wParam of
    0: UserEMail.SendMsg(EMS_READEMAIL, m_nDBIndex, ProcessMsg.nParam1, 0, 0, m_sCharName, nil);
    1: UserEMail.SendMsg(EMS_DELEMAIL, m_nDBIndex, ProcessMsg.nParam1, 0, 0, m_sCharName, nil);
    2: AddEMailInfo(ProcessMsg.nParam1, MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3), ProcessMsg.sMsg);
    3: UserEMail.SendMsg(EMS_DELEMAIL, m_nDBIndex, -1, 0, 0, m_sCharName, nil);
    4: UserEMail.SendMsg(EMS_GETGOLD, m_nDBIndex, ProcessMsg.nParam1, 0, 0, m_sCharName, nil);
    5: begin
        if (not InSafeZone) then begin
          SendDefMessage(SM_EMAIL, -1, 0, 0, 5, '');
          exit;
        end;
        UserEMail.SendMsg(EMS_GETITEM, m_nDBIndex, ProcessMsg.nParam1, 0, 0, m_sCharName, nil);
      end;
  end;
end;

procedure TPlayObject.ClientGMUpdateMsg(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  UserItem: pTUserItem;
  HintUserItem: pTUserItem;
  Stditem: pTStdItem;
  I: Integer;
begin
  if m_btPermission = 10 then begin //只有管理员才可以使用该消息
    case ProcessMsg.nParam2 of
      GMM_UPDATEITEM: begin
          HintUserItem := nil;
          if ProcessMsg.sMsg <> '' then begin
            if ProcessMsg.nParam3 = 1 then begin
              for I := 0 to m_ItemList.Count - 1 do begin
                UserItem := m_ItemList[I];
                if UserItem.MakeIndex = ProcessMsg.nParam1 then begin
                  DecodeBuffer(ProcessMsg.sMsg, @(UserItem^), SizeOf(TUserItem));
                  HintUserItem := UserItem;
                  break;
                end;
              end;
            end
            else if ProcessMsg.nParam3 = 2 then begin
              for I := Low(m_UseItems) to High(m_UseItems) do begin
                UserItem := @m_UseItems[I];
                if (UserItem.wIndex > 0) and (UserItem.MakeIndex = ProcessMsg.nParam1) then begin
                  DecodeBuffer(ProcessMsg.sMsg, @m_UseItems[I], SizeOf(TUserItem));
                  HintUserItem := @m_UseItems[I];
                  break;
                end;
              end;
            end;
          end;
          if HintUserItem <> nil then begin
            Stditem := UserEngine.GetStdItem(HintUserItem.wIndex);
            if Stditem <> nil then begin
              MainOutMessage('[调整物品] ' + m_sCharName + ' ' + Stditem.Name + '(' + IntToStr(HintUserItem.MakeIndex) + ')');
              if Stditem.NeedIdentify = 1 then
                AddGameLog(Self, LOG_UPDATEITEM, Stditem.Name, HintUserItem.MakeIndex, HintUserItem.Dura, '0',
                  '0', '0', '调整', HintUserItem);
            end;
          end;
        end;
    end;
  end;
end;

procedure TPlayObject.ClientGameSetupInfo(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if ProcessMsg.wParam = 1 then begin
    DecodeBuffer(ProcessMsg.sMsg, @m_UserOptionSetup, SizeOf(m_UserOptionSetup));
  end
  else if ProcessMsg.wParam = 2 then begin
    if (ProcessMsg.nParam1 > 0) and (ProcessMsg.nParam1 <= MAXITEMSSETUPCOUNT) and
      (Length(ProcessMsg.sMsg) = GetCodeMsgSize((ProcessMsg.nParam1 * SizeOf(Word)) * 4 / 3)) then begin
      m_wItemsSetupCount := ProcessMsg.nParam1;
      DecodeBuffer(ProcessMsg.sMsg, @m_UserItemsSetup[0], SizeOf(Word) * m_wItemsSetupCount);
    end
    else
      m_wItemsSetupCount := 0;
  end;
end;

procedure TPlayObject.ClientFriendChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
  procedure AddFriend(AddName: string);
  var
    AddObject: TPlayObject;
  begin
    if CompareText(AddName, m_sCharName) = 0 then begin
      SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '[失败]：不能添加自己作为好友');
      exit;
    end;
    if InFriendList(AddName) then begin
      SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '[失败]：（' + AddName + '） 已经存在于你的好友列表当中.');
      exit;
    end;
    if m_FriendList.Count >= MAXFRIENDS then begin
      SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '[失败]：你的好友列表数量已达到最高上限.');
      exit;
    end;
    AddObject := UserEngine.GetPlayObject(AddName);
    if (AddObject <> nil) and (not AddObject.m_boGhost) then begin
      if (not AddObject.m_boAllowFrieng) or (AddObject.m_boSafeOffLine) then begin
        SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '[失败]：（' + AddName + '） 拒绝增加好友.');
        exit;
      end;
      if AddObject.m_FriendList.Count >= MAXFRIENDS then begin
        SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '[失败]：（' + AddName + '） 的好友列表数量已达到最高上限.');
        exit;
      end;
      if AddObject.AddCheckMsg(Format(g_sFriendCheckMsg, [m_sCharName]), tmc_Friend, Self, 62) <> nil then
        SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '成功发送了加为好友邀请，请等待对方回应！')
          //SysMsg(g_sFriendIsCheckMsg, c_Red, t_Hint)
      else
        //SysMsg(g_sFriendIsCheckMsgNot, c_Red, t_Hint)
        SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '[失败]: 已经向（' + AddName + '） 发送了邀请，请不要重复发送！');
    end
    else
      SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '[失败]：（' + AddName + '） 没有在线.');
  end;

  procedure DelFriend(AddName: string);
  var
    DelDBIndex: Integer;
    DelObject: TPlayObject;
    I, II: Integer;
    NameBuff: PChar;
  begin
    for I := 0 to m_FriendList.Count - 1 do begin
      if CompareText(m_FriendList[I], AddName) = 0 then begin
        DelDBIndex := Integer(m_FriendList.Objects[I]);
        DelObject := GetLoginPlay(DelDBIndex);
        if (DelObject <> nil) and (not DelObject.m_boGhost) then begin
          for II := 0 to DelObject.m_FriendList.Count - 1 do begin
            if CompareText(DelObject.m_FriendList[II], m_sCharName) = 0 then begin
              DelObject.SendDefMsg(DelObject, SM_FRIEND_LOGIN, m_nDBIndex, 1, 0, 3, m_sCharName);
              DelObject.m_FriendList.Delete(II);
              break;
            end;
          end;
        end
        else begin
          GetMem(NameBuff, Length(m_sCharName) + 1);
          SafeFillChar(NameBuff^, Length(m_sCharName) + 1, #0);
          Move(m_sCharName[1], NameBuff^, Length(m_sCharName));
          g_UnFriendList.AddObject(AddName, TObject(NameBuff));
          SaveUnFriendList;
        end;
        m_FriendList.Delete(I);
        break;
      end;
    end;
  end;
begin
  if m_boGhost then
    exit;
  case ProcessMsg.wParam of
    0: AddFriend(DecodeString(ProcessMsg.sMsg));
    1: DelFriend(DecodeString(ProcessMsg.sMsg));
  end;
end;

procedure TPlayObject.ClientUserPhoto(ProcessMsg: pTProcessMessage; var boResult: Boolean);
//  function IsUpLoadPhoto: Boolean;
//  var
//    nHours: Integer;
//  begin
//    Result := False;
//    if m_Abil.Level < g_Config.nUpPhotoLevel then begin
//      SendDefMessage(SM_UPLOADUSERPHOTO_FAIL, 0, 0, 0, 0,
//        '等级必需大于' + IntToStr(g_Config.nUpPhotoLevel) + '级(包含' + IntToStr(g_Config.nUpPhotoLevel) + '级)以上才能上传');
//      exit;
//    end;
//    if m_PPhotoData <> nil then begin
//      nHours := HoursBetween(Now, m_dwUpLoadPhotoTime);
//      if nHours < g_Config.nUpPhotoTick then begin
//        SendDefMessage(SM_UPLOADUSERPHOTO_FAIL, 0, 0, 0, 0,
//          '在' + IntToStr(g_Config.nUpPhotoTick - nHours) + '小时之后才能再次上传');
//        exit;
//      end;
//    end;
//    Result := True;
//  end;

//  procedure UserUpLoadPhoto;
//  var
//    nSize: Integer;
//  begin
//    nSize := ProcessMsg.nParam1;
//    if (nSize > MAXPHOTODATASIZE) or (nSize < 10) or (Length(ProcessMsg.sMsg) <> GetCodeMsgSize(nSize * 4 / 3)) then
//      Exit;
//    if IsUpLoadPhoto then begin
//      m_dwLoadPhotoTick := GetTickCount;
//      m_dwUpLoadPhotoTime := Now;
//      ReallocMem(m_PPhotoData, nSize);
//      m_nPhotoSize := nSize;
//      DecodeBuffer(ProcessMsg.sMsg, m_PPhotoData, nSize);
//      m_RealityInfo.sPhotoID := GetMD5TextOf16(m_sCharName + DateTimeToStr(Now));
//      SendDefMessage(SM_UPLOADUSERPHOTO, 0, 0, 0, 1, m_RealityInfo.sPhotoID);
//    end;
//  end;

//  procedure UserGetPhoto;
//  begin
//    if GetTickCount > m_dwLoadPhotoTick then begin
//      m_dwLoadPhotoTick := GetTickCount + 5000;
//      if (m_PPhotoData <> nil) and (m_nPhotoSize >= 10) then begin
//        m_DefMsg := MakeDefaultMsg(SM_UPLOADUSERPHOTO, m_nPhotoSize, 0, 0, 2);
//        SendSocket(@m_DefMsg, EncodeBuffer(m_PPhotoData, m_nPhotoSize));
//      end
//      else
//        SendDefMessage(SM_UPLOADUSERPHOTO_FAIL, 0, 0, 0, 0, '获取失败,没有照片数据.');
//    end
//    else
//      SendDefMessage(SM_UPLOADUSERPHOTO_FAIL, 0, 0, 0, 0, '请勿超速操作');
//  end;

//  procedure UserGetPhoto2;
//  var
//    LookBase: TPlayObject;
//  begin
//    if GetTickCount > m_dwLoadPhotoTick then begin
//      m_dwLoadPhotoTick := GetTickCount + 5000;
//      LookBase := GetLoginPlay(m_nLookPhotoIndex);
//      m_nLookPhotoIndex := -1;
//      if LookBase <> nil then begin
//        if (LookBase.m_PPhotoData <> nil) and (LookBase.m_nPhotoSize >= 10) then begin
//          m_DefMsg := MakeDefaultMsg(SM_UPLOADUSERPHOTO, LookBase.m_nPhotoSize, 0, 0, 3);
//          SendSocket(@m_DefMsg, EncodeBuffer(LookBase.m_PPhotoData, LookBase.m_nPhotoSize));
//        end
//        else
//          SendDefMessage(SM_UPLOADUSERPHOTO_FAIL, 0, 0, 0, 0, '获取失败,没有照片数据.');
//      end
//      else
//        SendDefMessage(SM_UPLOADUSERPHOTO_FAIL, 0, 0, 0, 0, '对方已离线，无法获取数据。');
//    end
//    else
//      SendDefMessage(SM_UPLOADUSERPHOTO_FAIL, 0, 0, 0, 0, '请勿超速操作');
    //m_nLookPhotoIndex
//  end;
begin
//  case ProcessMsg.wParam of
//    0: begin
//        if IsUpLoadPhoto then
//          SendDefMessage(SM_UPLOADUSERPHOTO, 0, 0, 0, 0, '');
//      end;
//    1: UserUpLoadPhoto;
//    2: UserGetPhoto;
//    3: UserGetPhoto2; //m_dwLoadPhotoTick
//  end;
end;

procedure TPlayObject.ClientUpdate(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  UserItem: pTUserItem;
  //HintUserItem: pTUserItem;
//  Stditem: pTStdItem;
  I: Integer;
begin
  //if m_btPermission = 10 then begin
  case ProcessMsg.nParam2 of
    GMM_UPDATEITEM: begin
        //HintUserItem := nil;
        if ProcessMsg.sMsg <> '' then begin
          if ProcessMsg.nParam3 = 1 then begin
            for I := 0 to m_ItemList.Count - 1 do begin
              UserItem := m_ItemList[I];
              if UserItem.MakeIndex = ProcessMsg.nParam1 then begin
                DecodeBuffer(ProcessMsg.sMsg, @(UserItem^), SizeOf(TUserItem));
                //HintUserItem := UserItem;
                break;
              end;
            end;
          end
          else if ProcessMsg.nParam3 = 2 then begin
            for I := Low(m_UseItems) to High(m_UseItems) do begin
              UserItem := @m_UseItems[I];
              if (UserItem.wIndex > 0) and (UserItem.MakeIndex = ProcessMsg.nParam1) then begin
                DecodeBuffer(ProcessMsg.sMsg, @m_UseItems[I], SizeOf(TUserItem));
                //HintUserItem := @m_UseItems[I];
                break;
              end;
            end;
          end;
        end;
      end;
  end;
  //end;
end;

procedure TPlayObject.ClientStorageGoldChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  nBack: Byte;
begin
  nBack := 0;
  if not m_boStorageOpen[0] or m_boStorageLock then
    exit;
  if ProcessMsg.wParam = 1 then begin
    if m_nStorageGold >= ProcessMsg.nParam1 then begin
      if IncGold(ProcessMsg.nParam1) then begin
        Dec(m_nStorageGold, ProcessMsg.nParam1);
        GoldChanged;
      end
      else
        nBack := 2;
    end
    else
      nBack := 1;
  end
  else if ProcessMsg.wParam = 2 then begin
    if m_nGold >= ProcessMsg.nParam1 then begin
      if m_nStorageGold + ProcessMsg.nParam1 <= MAXINTCOUNT then begin
        if DecGold(ProcessMsg.nParam1) then begin
          Inc(m_nStorageGold, ProcessMsg.nParam1);
          GoldChanged;
        end;
      end
      else
        nBack := 4;
    end
    else
      nBack := 3;
  end;
  SendDefMessage(SM_STORAGEGOLDCHANGE, m_nStorageGold, nBack, 0, 0, '');
end;

procedure TPlayObject.ClientGetBackStoragePass(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  sPass: string;
begin
  if m_boStorageLock then
    exit;

  if ProcessMsg.nParam1 = 1 then begin
    if (ProcessMsg.sMsg = '') then
      exit;
    sPass := DecodeString(ProcessMsg.sMsg);
    if not m_boStorageOpen[0] then begin
      if GetMD5Text(m_sStoragePwd + IntToStr(Integer(Self))) = sPass then begin
        m_boStorageOpen[0] := True;
        m_btStorageErrorCount := 0;
        SendStorageInfo();
      end
      else begin
        Inc(m_btStorageErrorCount);
        if m_btStorageErrorCount < 5 then begin
          SendDefMessage(SM_MENU_OK, Integer(Self), 0, 0, 0,
            '密码错误！\你还有 ' + IntToStr(5 - m_btStorageErrorCount) +
            ' 次机会！\超过次数后24小时之内无法使用仓库！');
        end
        else begin
          m_boStorageLock := True;
          m_StorageLockTime := IncHour(Now, 24);
          m_btStorageErrorCount := 0;
          SendDefMessage(SM_MENU_OK, Integer(Self), 0, 0, 0, '仓库已被锁定，暂时无法使用！');
        end;
      end;
    end;
  end
  else if ProcessMsg.nParam1 = 2 then begin
    if m_boStorageOpen[0] then begin
      m_sStoragePwd := DecodeString(ProcessMsg.sMsg);
      if m_sStoragePwd = '' then
        SendDefMessage(SM_MENU_OK, Integer(Self), 0, 0, 0, '已取消仓库密码！')
      else
        SendDefMessage(SM_MENU_OK, Integer(Self), 0, 0, 0, '密码更改成功，请牢记！');
    end;
  end;
end;

procedure TPlayObject.SendStorageInfo();
begin
  if not g_Config.boTryModeUseStorage then begin
    SendDefMsg(Self, SM_MENU_OK, Integer(Self), 0, 0, 0, g_sTryModeCanotUseStorage);
    exit;
  end;

  if m_boStorageLock and (Now > m_StorageLockTime) then
    m_boStorageLock := False;

  if not m_boStorageOpen[0] then begin
    if m_boStorageLock then
      SendDefMsg(Self, SM_MENU_OK, Integer(Self), 0, 0, 0, '仓库已被锁定，暂时无法使用！')
    else
      SendDefMsg(Self, SM_GETBACKPASSWORD, CM_GETBACKSTORAGEPASS, 12, 1, 0,
        '仓库已上锁，请输入仓库密码！');
  end
  else begin
    SendDefSocket(Self, SM_STORAGEINFO, m_nStorageGold,
      MakeWord(Byte(m_boStorageOpen[1]), Byte(m_boStorageOpen[2])),
      MakeWord(Byte(m_boStorageOpen[3]), Byte(m_boStorageOpen[4])), 0,
      EncodeBuffer(@m_dwStorageTime[1], SizeOf(TDateTime) * 4));
  end;
end;

procedure TPlayObject.SetStoragePass();
begin
  if not m_boStorageOpen[0] then begin
    SendDefMsg(Self, SM_MENU_OK, Integer(Self), 0, 0, 0, '请先打开仓库再更改密码！');
  end
  else
    SendDefMsg(Self, SM_GETBACKPASSWORD, CM_GETBACKSTORAGEPASS, 12, 2, 1, '');
end;

procedure TPlayObject.SendServerConfig;
var
  nRecog, nParam: Integer;
  nRunHuman, nRunMon, nRunNpc, nWarRunAll: Integer;
  ClientConf: TClientConf;
  //  sMsg: string;
begin
  nRunHuman := 0;
  nRunMon := 0;
  nRunNpc := 0;
  nWarRunAll := 0;
  nRecog := 0;
  nParam := 0;

  SafeFillChar(ClientConf, SizeOf(TClientConf), #0);
  if g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll) then begin
    nRunHuman := 1;
    nRunMon := 1;
    nRunNpc := 1;
    nWarRunAll := 0;
  end
  else begin
    if (g_Config.boRUNHUMAN and not m_PEnvir.m_boRUNHUMAN) or (not g_Config.boRUNHUMAN and m_PEnvir.m_boRUNHUMAN) then
      nRunHuman := 1;
    if (g_Config.boRUNMON and not m_PEnvir.m_boRUNMON) or (not g_Config.boRUNMON and m_PEnvir.m_boRUNMON) then
      nRunMon := 1;
    if g_Config.boRunNpc then
      nRunNpc := 1;
    if g_Config.boWarDisHumRun then
      nWarRunAll := 1;
  end;

  ClientConf.boRUNHUMAN := nRunHuman = 1;
  ClientConf.boRUNMON := nRunMon = 1;
  ClientConf.boRunNpc := nRunNpc = 1;
  ClientConf.boRunGuard := g_Config.boRunGuard;
  ClientConf.boWarDisHumRun := nWarRunAll = 1;
  ClientConf.SafeAreaLimited := g_Config.boSafeAreaLimited;
  //安全区不受控制
  ClientConf.boParalyCanRun := g_Config.ClientConf.boParalyCanRun;
  ClientConf.boParalyCanWalk := g_Config.ClientConf.boParalyCanWalk;
  ClientConf.boParalyCanHit := g_Config.ClientConf.boParalyCanHit;
  ClientConf.boParalyCanSpell := g_Config.ClientConf.boParalyCanSpell;
  ClientConf.boShowMoveHPNumber := True; //显示移动飘血
  m_DefMsg := MakeDefaultMsg(SM_SERVERCONFIG, nRecog, nParam, 0, 0);
  SendSocket(@m_DefMsg, EncodeBuffer(@ClientConf, SizeOf(TClientConf)));
end;
{
procedure TPlayObject.SendServerStatus;
begin
 if m_btPermission < 10 then
   Exit;
 SysMsg(IntToStr(CalcFileCRC(Application.ExeName)), c_Red, t_Hint);
end;      }

function TPlayObject.MakeClientItem(UserItem: pTUserItem): string;
begin
  Result := UserEngine.MakeClientItem(UserItem);
end;

procedure TPlayObject.SendUseitems;
var
  i: Integer;
  sSENDMSG: string;
begin
  {if Assigned(zPlugOfEngine.HookSendUseitemsMsg) then begin
    try
      zPlugOfEngine.HookSendUseitemsMsg(Self);
    except
    end;
  end
  else begin     }
  sSENDMSG := '';
  for i := Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[i].wIndex > 0 then begin
      sSENDMSG := sSENDMSG + IntToStr(i) + '/' + MakeClientItem(@m_UseItems[i]) + '/';
    end;
  end;
  if sSENDMSG <> '' then begin
    m_DefMsg := MakeDefaultMsg(SM_SENDUSEITEMS, 0, 0, 0, 0);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;
  //;
end;

procedure TPlayObject.SendUseMagic;
var
  i: Integer;
  sSENDMSG: string;
  UserMagic: pTUserMagic;
  ClientMagic: TClientMagic;
  TempTick: LongWord;
begin
  sSENDMSG := '';
  TempTick := GetTickCount;
  for i := 0 to m_MagicList.Count - 1 do begin
    UserMagic := m_MagicList.Items[i];
    if UserMagic <> nil then begin
      ClientMagic.btMagID := UserMagic.wMagIdx;
      {if UserMagic.btLevel <= 0 then
        UserMagic.btLevel := 1;}
      ClientMagic.Level := UserMagic.btLevel;
      ClientMagic.CurTrain := UserMagic.nTranPoint;
      ClientMagic.btKey := UserMagic.btKey;
      if UserMagic.dwInterval > TempTick then
        ClientMagic.dwInterval := UserMagic.dwInterval - TempTick
      else
        ClientMagic.dwInterval := 0;
      sSENDMSG := sSENDMSG + EncodeBuffer(@ClientMagic, SizeOf(TClientMagic)) + '/';
    end;
  end;
  //if sSENDMSG <> '' then begin
  m_DefMsg := MakeDefaultMsg(SM_SENDMYMAGIC, m_CboMagicListInfo.nMagicList, 0, 0, 0);
  SendSocket(@m_DefMsg, sSENDMSG);
  //end;
end;

procedure TPlayObject.ClientRealityInfoChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
//var
//  str: string;
//  nParam1, nParam2, nParam3, wParam: Word;
//  sRealityStr: string;
begin
//  nParam1 := ProcessMsg.nParam1;
//  nParam2 := ProcessMsg.nParam2;
//  nParam3 := ProcessMsg.nParam3;
//  wParam := ProcessMsg.wParam;
//  sRealityStr := ProcessMsg.sMsg;
//  m_RealityInfo.boFriendSee := nParam1 = 1;
//  m_RealityInfo.btOld := LoByte(nParam2);
//  m_RealityInfo.btSex := HiByte(nParam2);
//  m_RealityInfo.btProvince := LoByte(nParam3);
//  m_RealityInfo.btCity := HiByte(nParam3);
//  m_RealityInfo.btArea := LoByte(wParam);
//  m_RealityInfo.btOnlineTime := HiByte(wParam);
//  sRealityStr := GetValidStrEx(DecodeString(sRealityStr), str, ['/']);
//  m_RealityInfo.sUserName := str;
  //sRealityStr := GetValidStrEx(sRealityStr, str, ['/']);
  //m_RealityInfo.sPhotoID := str;
//  m_RealityInfo.sIdiograph := sRealityStr;
//  SysMsg('[保存个人信息成功]', c_Blue, t_Hint)
end;

procedure TPlayObject.ClientNakedChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  NakedAbil: TNakedAbil;
  nTempNakedCount: Integer;
  sNakedStr: string;
begin
  sNakedStr := ProcessMsg.sMsg;
  if sNakedStr = '' then
    exit;
  DecodeBuffer(sNakedStr, @NakedAbil, SizeOf(NakedAbil));
  if m_nNakedBackCount > 0 then begin
    if (m_NakedAbil.nAc >= NakedAbil.nAc) and (m_NakedAbil.nMAc >= NakedAbil.nMAc) and (m_NakedAbil.nDc >= NakedAbil.nDc) and
      (m_NakedAbil.nMc >= NakedAbil.nMc) and (m_NakedAbil.nSc >= NakedAbil.nSc) and (m_NakedAbil.nHP >= NakedAbil.nHP) then begin

      nTempNakedCount := 0;
      Inc(nTempNakedCount, NakedAbil.nAc);
      Inc(nTempNakedCount, NakedAbil.nMAc);
      Inc(nTempNakedCount, NakedAbil.nDc);
      Inc(nTempNakedCount, NakedAbil.nMc);
      Inc(nTempNakedCount, NakedAbil.nSc);
      Inc(nTempNakedCount, NakedAbil.nHP);
      if nTempNakedCount <= m_nNakedBackCount then begin
        Dec(m_NakedAbil.nAc, NakedAbil.nAc);
        Dec(m_NakedAbil.nMAc, NakedAbil.nMAc);
        Dec(m_NakedAbil.nDc, NakedAbil.nDc);
        Dec(m_NakedAbil.nMc, NakedAbil.nMc);
        Dec(m_NakedAbil.nSc, NakedAbil.nSc);
        Dec(m_NakedAbil.nHP, NakedAbil.nHP);
        Inc(m_nNakedCount, nTempNakedCount);
        Dec(m_nNakedBackCount, nTempNakedCount);
        RecalcNakedAbilitys;
        RecalcAbilitys;
        SendNakedAbility;
        SendAbility;
      end;
    end;
  end
  else begin
    nTempNakedCount := 0;
    Inc(nTempNakedCount, NakedAbil.nAc);
    Inc(nTempNakedCount, NakedAbil.nMAc);
    Inc(nTempNakedCount, NakedAbil.nDc);
    Inc(nTempNakedCount, NakedAbil.nMc);
    Inc(nTempNakedCount, NakedAbil.nSc);
    Inc(nTempNakedCount, NakedAbil.nHP);
    if nTempNakedCount <= m_nNakedCount then begin
      Dec(m_nNakedCount, nTempNakedCount);
      inc(m_NakedAbil.nAc, NakedAbil.nAc);
      inc(m_NakedAbil.nMAc, NakedAbil.nMAc);
      inc(m_NakedAbil.nDc, NakedAbil.nDc);
      inc(m_NakedAbil.nMc, NakedAbil.nMc);
      inc(m_NakedAbil.nSc, NakedAbil.nSc);
      inc(m_NakedAbil.nHP, NakedAbil.nHP);
      RecalcNakedAbilitys;
      RecalcAbilitys;
      SendNakedAbility;
      SendAbility;
      if (m_nNakedCount <= 0) and (GetMissionFlagStatus(MISSIONVAR_NAKED) = 0) then
        SetMissionFlagStatus(MISSIONVAR_NAKED, 1);
    end;
  end;
end;

function TPlayObject.ClientChangeDir(wIdent: Word; nX, nY, nDir: Integer; boLateDelivery: Boolean; var dwDelayTime: LongWord): Boolean;
var
  dwCheckTime: LongWord;
begin
  Result := False;
  dwDelayTime := 0;
  if m_boDeath or m_boShoping or (not CanWork) then
    Exit; //防麻

  m_boFilterAction := True;
  if not boLateDelivery then begin
    dwCheckTime := GetTickCount;
    if dwCheckTime < m_dwTurnTime then begin
      dwDelayTime := m_dwTurnTime - dwCheckTime;
      Inc(m_nTurnCount, g_Config.nMaxTurnMsgCount);
      Inc(m_dwTurnTime, g_Config.dwTurnIntervalTime);
      exit;
    end;
    if m_nTurnCount > 0 then
      Dec(m_nTurnCount);
    SetUserTime(g_Config.dwTurnIntervalTime);
  end;
  m_boTurnDelay := False;

  if (nX = m_nCurrX) and (nY = m_nCurrY) then begin
    m_btDirection := nDir;
    if Walk(RM_TURN) then begin
      Result := True;
    end;
  end;
end;

function TPlayObject.ClientSitDownHit(nX, nY, uid, nDir: Integer; boLateDelivery: Boolean;
  var dwDelayTime: LongWord): Boolean; //004CC248
{var
  dwCheckTime: LongWord;
  BaseObject: TBaseObject;
  n10, n14: Integer;  }
begin
  Result := False;
  dwDelayTime := 0;
  if m_boDeath or m_boOnHorse or m_boShoping or (not CanWork) then
    Exit; //防麻

  (*if not boLateDelivery then begin
    dwCheckTime := GetTickCount;
    if dwCheckTime < m_dwButchTime then begin
      dwDelayTime := m_dwButchTime - dwCheckTime;
      Inc(m_nButchCount, g_Config.nMaxButchMsgCount);
      Inc(m_dwButchTime, g_Config.dwButchIntervalTime);
      exit;
    end;
    if m_nButchCount > 0 then Dec(m_nButchCount);
    SetUserTime(g_Config.dwButchIntervalTime);
  end;
  m_boButchDelay := False;
  BaseObject := TBaseObject(uid);
  if (BaseObject <> nil) and m_PEnvir.IsValidObject(m_nCurrX, m_nCurrY, 2, BaseObject) then begin
    if BaseObject.m_boDeath and (not BaseObject.m_boSkeleton) then begin
      if BaseObject.m_boAnimal then begin
        n10 := Random(16) + 5;
        n14 := Random(201) + 100;
        Dec(BaseObject.m_nBodyLeathery, n10);
        Dec(BaseObject.m_nMeatQuality, n14);
        if BaseObject.m_nMeatQuality < 0 then
          BaseObject.m_nMeatQuality := 0;
        if BaseObject.m_nBodyLeathery <= 0 then begin
          if (BaseObject.m_btRaceServer >= RC_ANIMAL) and (BaseObject.m_btRaceServer < RC_MONSTER) then begin
            BaseObject.m_boSkeleton := True;
            ApplyMeatQuality();
            BaseObject.SendRefMsg(RM_SKELETON, BaseObject.m_btDirection, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 0, '');
          end;
          if not TakeBagItems(BaseObject) then begin
            SysMsg(sYouFoundNothing {未发现任何物品.}, c_Red, t_Hint);
          end;
          BaseObject.m_nBodyLeathery := 50;
        end;
        m_dwDeathTick := GetTickCount();
      end;
      m_btDirection := nDir;
      SendRefMsg(RM_BUTCH, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;
  end;         *)
  Result := True;
end;

procedure TPlayObject.ClientOpenDoor(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  Door: pTDoorInfo;
  Castle: TUserCastle;
  nX, nY: Integer;
begin
  nX := ProcessMsg.nParam2;
  nY := ProcessMsg.nParam3;
  Door := m_PEnvir.GetDoor(nX, nY);
  if Door = nil then
    Exit;
  Castle := g_CastleManager.IsCastleEnvir(m_PEnvir);
  if (Castle = nil) or (Castle.m_DoorStatus <> Door.Status) or (m_btRaceServer <> RC_PLAYOBJECT) or
    Castle.CheckInPalace(m_nCurrX, m_nCurrY, Self) then begin
    UserEngine.OpenDoor(m_PEnvir, nX, nY);
  end;
  {
  if (UserCastle.m_MapCastle <> m_PEnvir) or
     (UserCastle.m_DoorStatus <> Door.Status) or
     (m_btRaceServer <> RC_PLAYOBJECT) or
     UserCastle.CheckInPalace(m_nCurrX,m_nCurrY,Self) then begin

    UserEngine.OpenDoor(m_PEnvir,nX,nY);
  end;
  }
end;

function TPlayObject.CheckTakeOnItem(StdItem: pTStdItem; UserItem: pTUserItem):
  Boolean;
begin
  //Result := True;
  {if (StdItem <> nil) and
    (StdItem.StdMode in [ts_Helmet, ts_Ring, ts_ArmRing]) and
    (not m_boUserUnLockDurg) and
    (CheckByteStatus(UserItem.Value.btValue[tb_Status], Is_Lock)) then
    exit;   }
  {if not m_boUserUnLockDurg and ((StdItem.Reserved and 2) <> 0) then
    exit;
  if (StdItem.Reserved and 4) <> 0 then
    Exit; }
  {if InDisableTakeOffList(UserItem.wIndex) then
    Exit;  }
  Result := False;
end;

//检测激活套装物品
{
procedure TPlayObject.ClientSuitItems(UserItem: pTuseritem; btWhere: Byte);
  function GetStdItemWuXin(itemindex: Integer): Integer;
  var
    StdItem: pTStdItem;
  begin
    Result := 0;
    StdItem := UserEngine.GetStdItem(itemindex);
    if StdItem <> nil then
      Result := StdItem.Wuxin;
  end;

  function IsTakeOnItemWuXin(where: Byte; wuxin, StdMode: Integer): byte;
  begin
    Result := 255;
    if (where in [0..MAXUSEITEMS - 1]) then begin
      if (where = U_RINGL) or (where = U_RINGR) then begin
        if (m_UseItems[U_RINGL].wIndex = StdMode) and
          (m_UseItems[U_RINGL].WuXinIdx = 0) and
          (m_UseItems[U_RINGL].Value.btValue[tb_WuXin] = wuxin) then
          Result := U_RINGL
        else if (m_UseItems[U_RINGR].wIndex = StdMode) and
          (m_UseItems[U_RINGR].WuXinIdx = 0) and
          (m_UseItems[U_RINGR].Value.btValue[tb_WuXin] = wuxin) then
          Result := U_RINGR;
      end
      else if (where = U_ARMRINGR) or (where = U_ARMRINGL) then begin
        if (m_UseItems[U_ARMRINGR].wIndex = StdMode) and
          (m_UseItems[U_ARMRINGR].WuXinIdx = 0) and
          (m_UseItems[U_ARMRINGR].Value.btValue[tb_WuXin] = wuxin) then
          Result := U_ARMRINGR
        else if (m_UseItems[U_ARMRINGL].wIndex = StdMode) and
          (m_UseItems[U_ARMRINGL].WuXinIdx = 0) and
          (m_UseItems[U_ARMRINGL].Value.btValue[tb_WuXin] = wuxin) then
          Result := U_ARMRINGL;
      end
      else if (m_UseItems[where].wIndex = StdMode) and
        (m_UseItems[where].WuXinIdx = 0) and
        (m_UseItems[where].Value.btValue[tb_WuXin] = wuxin) then
        Result := where;
    end;
  end;
var
  StdItem: pTStdItem;
  myWuXin, WuXin, WuXinId: Word;
  WuxinCount, where, I: Integer;
  UserItems: array[0..3] of pTUserItem;
  awhere: array[0..3] of Byte;
  AddClass, AddCount: Byte;
begin
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem = nil then
    exit;
  if (StdItem.Wuxin > 0) and (UserItem.WuXinIdx = 0) and
    (UserItem.Value.btValue[tb_WuXin] > 0) then begin
    myWuXin := StdItem.Wuxin;
    WuXinId := UserItem.Value.btValue[tb_WuXin];
    WuXin := myWuXin;
    WuxinCount := 1;
    while True do begin
      Inc(WuxinCount);
      WuXin := GetStdItemWuXin(WuXin + 1);
      if (WuXin = 0) then
        Exit;
      if WuXin = MyWuXin then
        Break;
    end;
    if WuxinCount = 6 then begin
      for I := 0 to 3 do begin
        WuXin := myWuXin;
        myWuXin := GetStdItemWuXin(WuXin + 1);
        StdItem := UserEngine.GetStdItem(WuXin + 1);
        if StdItem = nil then
          exit;
        Inc(WuXinId);
        if WuXinId > 5 then
          WuXinId := 1;
        where := GetTakeOnPosition(StdItem.StdMode);
        awhere[i] := IsTakeOnItemWuXin(where, WuXinId, WuXin + 1);
        if awhere[i] = 255 then
          exit;
        UserItems[i] := @m_useItems[awhere[i]];
      end;
      AddClass := Random(5) + 1;
      if HiByte(StdItem.WuxinCount) > 0 then
        AddCount := Random(LoByte(StdItem.WuxinCount) -
          HiByte(StdItem.WuxinCount)) + HiByte(StdItem.WuxinCount) + 1
      else
        AddCount := Random(LoByte(StdItem.WuxinCount)) + 1;

      UserItem.WuXinIdx := UserItem.MakeIndex;
      UserItem.Value.nValue[tn_WuXinCount] := MakeWord(AddClass, AddCount);
      for I := 0 to 3 do begin
        UserItems[i].WuXinIdx := UserItem.MakeIndex;
        UserItems[i].Value.nValue[tn_WuXinCount] := MakeWord(AddClass, AddCount);
      end;
      SendDefMessage(SM_UPDATEITEMEX,
        UserItem.MakeIndex,
        MakeWord(AddClass, AddCount),
        MakeWord(awhere[0], awhere[1]),
        MakeWord(awhere[2], awhere[3]), '');
    end;
  end;
end;    }

procedure TPlayObject.ClientTakeOnItems(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  i, n14, n18: Integer;
  pUserItem, vTakeOffItem: pTUserItem;
  StdItem, StdItem20: pTStdItem;
  //StdItem58: TStdItem;
  //sUserItemName: string;
  btWhere, hWhere: Byte;
  nItemIdx: Integer;
  //sItemName: string;
label
  FailExit;
begin
  btWhere := ProcessMsg.nParam2;
  nItemIdx := ProcessMsg.nParam1;
  //sitemName := ProcessMsg.sMsg;
  StdItem := nil;
  pUserItem := nil;
  n14 := -1;
  for i := 0 to m_ItemList.Count - 1 do begin
    pUserItem := m_ItemList.Items[i];
    if (pUserItem <> nil) and (pUserItem.MakeIndex = nItemIdx) then begin
      //取自定义物品名称
      {sUserItemName := '';
      if UserItem.Value.btValue[13] = 1 then
        sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      if sUserItemName = '' then    }
      //sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);
      StdItem := UserEngine.GetStdItem(pUserItem.wIndex);
      if StdItem <> nil then begin
        //if CompareText(sUserItemName, sItemName) = 0 then begin
        n14 := i;
        break;
        //end;
      end;
    end;
    pUserItem := nil;
  end;
  n18 := 0;
  if (StdItem <> nil) and (pUserItem <> nil) then begin
    if CheckUserItems(btWhere, StdItem) then begin
      //StdItem58 := StdItem^;
      //ItemUnit.GetItemAddValue(UserItem, StdItem58);
      if CheckTakeOnItems(btWhere, StdItem, pUserItem) {and CheckItemBindUse(UserItem)} then begin
        vTakeOffItem := nil;
        if btWhere in [16..20] then begin
          hWhere := btWhere - 16;
          if m_UseItems[U_House].HorseItems[hWhere].wIndex > 0 then begin
            StdItem20 := UserEngine.GetStdItem(m_UseItems[U_House].HorseItems[hWhere].wIndex);
            if (StdItem20 = nil) or (StdItem20.Rule.Rule[RULE_NOTAKEOFF]) then begin
              SysMsg(g_sCanotTakeOffItem {'无法取下物品.'}, c_Red, t_Hint);
              goto FailExit;
            end;
            New(vTakeOffItem);
            vTakeOffItem^ := HorseItemToUserItem(@m_UseItems[U_House].HorseItems[hWhere], StdItem20);
          end;

          if vTakeOffItem <> nil then begin
            m_ItemList.Add(vTakeOffItem);
            SendAddItem(vTakeOffItem);
            m_sString[0] := UserEngine.GetStdItemName(vTakeOffItem.wIndex);
            m_nInteger[0] := btWhere;
            NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NTAKEOFFITEMS], False);
          end;
          m_UseItems[U_House].HorseItems[hWhere] := UserItemToHorseItem(pUserItem);
          m_sString[0] := UserEngine.GetStdItemName(pUserItem.wIndex);
          m_nInteger[0] := btWhere;
          NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NTAKEONITEMS], False);

          DelBagItem(n14);
          RecalcAbilitys();
          SendAbility;
          SendSubAbility;
          SendDefMessage(SM_TAKEON_OK, GetFeatureToLong, GetFeatureEx, 0, 0, '');
          FeatureChanged();
          n18 := 1;
        end else
        if btWhere in [Low(m_UseItems)..High(m_UseItems)] then begin
          if m_UseItems[btWhere].wIndex > 0 then begin
            StdItem20 := UserEngine.GetStdItem(m_UseItems[btWhere].wIndex);
            if (StdItem20 = nil) or (StdItem20.Rule.Rule[RULE_NOTAKEOFF]) then begin
              SysMsg(g_sCanotTakeOffItem {'无法取下物品.'}, c_Red, t_Hint);
              n18 := -4;
              goto FailExit;
            end;

            New(vTakeOffItem);
            vTakeOffItem^ := m_UseItems[btWhere];
            if (btWhere = U_HOUSE) and m_boOnHorse then
              m_UseItems[u_House].wHP := m_WAbil.HP;
          end;

          {if (StdItem.StdMode in [ts_Helmet, ts_ArmRing, ts_Ring]) and
            //神秘装备
          (CheckByteStatus(UserItem.Value.btValue[tb_Status], Is_Unknow)) then
            SetByteStatus(UserItem.Value.btValue[tb_Status], Is_Unknow, False); }

          if vTakeOffItem <> nil then begin
            m_ItemList.Add(vTakeOffItem);
            SendAddItem(vTakeOffItem);
            m_sString[0] := UserEngine.GetStdItemName(vTakeOffItem.wIndex);
            m_nInteger[0] := btWhere;
            NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NTAKEOFFITEMS], False);
          end;
          //MainOutMessage(StrPas(PChar(UserItem)));
          m_UseItems[btWhere] := pUserItem^;
          if (btWhere = U_HOUSE) then
            m_boOnHorse := False;
          m_sString[0] := UserEngine.GetStdItemName(pUserItem.wIndex);
          m_nInteger[0] := btWhere;
          NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NTAKEONITEMS], False);

          //ClientSuitItems(@m_UseItems[btWhere], btWhere);
          DelBagItem(n14);
          RecalcAbilitys();
          SendAbility;
          SendSubAbility;
          SendDefMessage(SM_TAKEON_OK, GetFeatureToLong, GetFeatureEx, 0, 0, '');
          FeatureChanged();
          n18 := 1;
        end;
      end
      else
        n18 := -1;
    end
    else
      n18 := -1;
  end;
  FailExit:
  if n18 <= 0 then
    SendDefMessage(SM_TAKEON_FAIL, n18, 0, 0, 0, '');
end;

procedure TPlayObject.ClientTakeOffItems(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  btWhere: Byte;
  nItemIdx: Integer;
begin
  btWhere := ProcessMsg.nParam2;
  nItemIdx := ProcessMsg.nParam1;
  TakeOffItem(btWhere, nItemIdx, True, False);
end;

procedure TPlayObject.ClientUseItems(ProcessMsg: pTProcessMessage; var boResult: Boolean);
  function GetUnbindItemName(nShape: Integer): string;
  var
    i: Integer;
  begin
    Result := '';
    for i := 0 to g_UnbindList.Count - 1 do begin
      if Integer(g_UnbindList.Objects[i]) = nShape then begin
        Result := g_UnbindList.Strings[i];
        break;
      end;
    end;
  end;
  function GetUnBindItems(sItemName: string; nCount: Integer; MasterUserItem: pTUserItem): Boolean;
  var
    i: Integer;
    UserItem: pTUserItem;
  begin
    Result := False;
    for i := 0 to nCount - 1 do begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
        m_ItemList.Add(UserItem);
        UserItem.btBindMode1 := MasterUserItem.btBindMode1;
        UserItem.btBindMode2 := MasterUserItem.btBindMode2;
        if m_btRaceServer = RC_PLAYOBJECT then
          SendAddItem(UserItem);
        Result := True;
      end
      else begin
        DisPose(UserItem);
        break;
      end;
    end;
  end;

  function CheckItemLevel(StdItem: pTStdItem): Boolean;
  begin
    Result := True;
    if (StdItem.Need > 0) or (StdItem.NeedLevel > 0) then begin
      case StdItem.Need of
        0: begin
            if m_Abil.Level < StdItem.NeedLevel then begin
              Result := False;
              SysMsg('你的等级不符合要求.', c_Red, t_Hint);
            end;
          end;
        1: begin
            if m_btJob <> StdItem.NeedLevel then begin
              Result := False;
              SysMsg('你的职业不符合要求.', c_Red, t_Hint);
            end;
          end;
        2: begin
            if m_MyGuild = nil then begin
              Result := False;
              SysMsg('只有行会成员才能使用.', c_Red, t_Hint);
            end;
          end;
        3: begin
            if m_Abil.Level >= StdItem.NeedLevel then begin
              Result := False;
              SysMsg('你的等级不符合要求.', c_Red, t_Hint);
            end;
          end;
      end;
    end;

  end;
var
  i: Integer;
  boEatOK: Boolean;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  UserItem34: TUserItem;
  nItemIdx: Integer;
  //sItemName: string;
begin
  nItemIdx := ProcessMsg.nParam1;
  //sItemName := ProcessMsg.sMsg;
  boEatOK := False;
  StdItem := nil;
  UserItem := nil;
  // if m_boCanUseItem then begin
  if (not m_boDeath) and (not m_boShoping) and (m_PEnvir <> nil) then begin
    for i := m_ItemList.Count - 1 downto 0 do begin
      if m_ItemList.Count <= 0 then
        break;
      UserItem := m_ItemList.Items[i];
      if UserItem = nil then
        Continue;
      if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
        UserItem34 := UserItem^;
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        m_ItemList.Delete(i);
        try
          if StdItem <> nil then begin
            if not m_PEnvir.AllowStdItems(StdItem.Name) then begin
              SysMsg(format(g_sCanotMapUseItemMsg, [StdItem.Name]), c_Red, t_Hint);
              break;
            end;
            if (m_AttackState = as_Dare) and (StdItem.StdMode <> tm_Drug) then begin
              SysMsg('只能使用药品！', c_Red, t_Hint);
              break;
            end;
            case StdItem.StdMode of
              tm_Drug: begin //药
                  if GetTickCount > m_dwEatTick then begin
                    if CheckItemLevel(StdItem) and EatItems(StdItem, UserItem) then begin
                      boEatOK := True;
                      if g_Config.dwEatTick > 0 then
                        m_dwEatTick := GetTickCount + g_Config.dwEatTick;
                    end;
                  end;
                  break;
                end;
              tm_Restrict,
                tm_Reel: begin
                  if CheckItemLevel(StdItem) and EatItems(StdItem, UserItem) then begin
                    boEatOK := True;
                  end;
                  break;
                end;
              tm_Book: begin //书
                  if ReadBook(StdItem) then begin
                    boEatOK := True;
                  end;
                end;
              tm_Open: begin //解包物品
                  if CheckItemLevel(StdItem) then begin
                    if (StdItem.AniCount in [0..3]) then begin
                      if (m_ItemList.Count + 6 - 1) <= m_nMaxItemListCount then begin
                        GetUnBindItems(GetUnbindItemName(StdItem.Shape), 6, UserItem);
                        boEatOK := True;
                      end;
                    end
                    else begin
                      if UseStdmodeFunItem(StdItem) then begin
                        boEatOK := True;
                      end;
                    end;
                  end;
                end;
            end;
          end;
        finally
          if boEatok then begin
            DisPose(UserItem);
          end
          else
            m_ItemList.Add(UserItem);
        end;
        break;
      end;
    end;
  end;
  if boEatOK then begin
    SendDefMessage(SM_EAT_OK, g_Config.dwEatTick, 0, 0, 0, '');
    if (StdItem <> nil) and (StdItem.NeedIdentify = 1) then
      AddGameLog(Self, LOG_DELITEM, Stditem.Name, UserItem34.MakeIndex, 0, '0', '0', '0',
        '使用', @UserItem34);
  end
  else begin
    if UserItem = nil then
      SendDefMessage(SM_EAT_FAIL, 0, 0, 0, 0, '')
    else
      SendDefMessage(SM_EAT_FAIL, UserItem.MakeIndex, UserItem.Dura, UserItem.DuraMax, 0, '');
  end;
end;

function TPlayObject.UseStdmodeFunItem(StdItem: pTStdItem): Boolean;
begin
  Result := True;
  if StdItem.AniCount in [Low(g_FunctionNPC.FStdModeFunc)..High(g_FunctionNPC.FStdModeFunc)] then
    NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FStdModeFunc[StdItem.AniCount], False);
end;

procedure TPlayObject.ChangeStatusMode(nStatus: Integer; boMode: Boolean);
var
  nPower: Integer;
begin
  case nStatus of
    STATUS_EXP: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          SendDefMsg(Self, SM_STATUSMODE, m_dwKillMonExpRateTime, LoWord(m_nKillMonExpRate), HiWord(m_nKillMonExpRate), nStatus, '');
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_POW: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          SendDefMsg(Self, SM_STATUSMODE, m_dwPowerRateTime, LoWord(m_nPowerRate), HiWord(m_nPowerRate), nStatus, '');
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_SC: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          if m_boSC then
            SendDefMsg(Self, SM_STATUSMODE, (m_dwStatusArrTimeOutTick[2] - GetTickCount) div 1000, LoWord(m_wStatusArrValue[2] + 2), HiWord(m_wStatusArrValue[2] + 2), nStatus, '')
          else begin
            nPower := -m_wStatusArrValue[2]; 
            SendDefMsg(Self, SM_STATUSMODE, (m_dwStatusArrTimeOutTick[2] - GetTickCount) div 1000, LoWord(nPower), HiWord(nPower), nStatus, '');
          end;

        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_AC: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
//          nPower := 2 + (m_Abil.Level div 7);
          nPower := 10 + (m_wStatusTimeArr[STATE_DEFENCEUP] div 10);
          SendDefMsg(Self, SM_STATUSMODE, m_wStatusTimeArr[STATE_DEFENCEUP], LoWord(nPower), HiWord(nPower), nStatus, '');
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_DC: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          if m_boDC then
            SendDefMsg(Self, SM_STATUSMODE, (m_dwStatusArrTimeOutTick[0] - GetTickCount) div 1000, LoWord(m_wStatusArrValue[0] + 2), HiWord(m_wStatusArrValue[0] + 2), nStatus, '')
          else begin
            nPower := -m_wStatusArrValue[0]; 
            SendDefMsg(Self, SM_STATUSMODE, (m_dwStatusArrTimeOutTick[0] - GetTickCount) div 1000, LoWord(nPower), HiWord(nPower), nStatus, '')
          end;
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_HIDEMODE: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          SendDefMsg(Self, SM_STATUSMODE, m_wStatusTimeArr[STATE_TRANSPARENT], 0, 0, nStatus, '');
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_STONE: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          SendDefMsg(Self, SM_STATUSMODE, m_wStatusTimeArr[POISON_STONE], 0, 0, nStatus, '');
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_MC: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          if m_boMC then
            SendDefMsg(Self, SM_STATUSMODE, (m_dwStatusArrTimeOutTick[1] - GetTickCount) div 1000, LoWord(m_wStatusArrValue[1] + 2), HiWord(m_wStatusArrValue[1] + 2), nStatus, '')
          else begin
            nPower := -m_wStatusArrValue[1];
            SendDefMsg(Self, SM_STATUSMODE, (m_dwStatusArrTimeOutTick[1] - GetTickCount) div 1000, LoWord(nPower), HiWord(nPower), nStatus, '')
          end;
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_MP: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          SendDefMsg(Self, SM_STATUSMODE, (m_dwStatusArrTimeOutTick[5] - GetTickCount) div 1000, LoWord(m_wStatusArrValue[5]), HiWord(m_wStatusArrValue[5]), nStatus, '');
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_MAC: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
//          nPower := 2 + (m_Abil.Level div 7);
          nPower := 10 + (m_wStatusTimeArr[STATE_MAGDEFENCEUP] div (10+m_Abil.Level));
          SendDefMsg(Self, SM_STATUSMODE, m_wStatusTimeArr[STATE_MAGDEFENCEUP], LoWord(nPower), HiWord(nPower), nStatus, '');
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_HP: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          SendDefMsg(Self, SM_STATUSMODE, (m_dwStatusArrTimeOutTick[4] - GetTickCount) div 1000, LoWord(m_wStatusArrValue[4]), HiWord(m_wStatusArrValue[4]), nStatus, '');
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_DAMAGEARMOR: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          SendDefMsg(Self, SM_STATUSMODE, m_wStatusTimeArr[POISON_DAMAGEARMOR], LoWord(g_Config.nPosionDamagarmor), HiWord(g_Config.nPosionDamagarmor), nStatus, '');
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_DECHEALTH: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          SendDefMsg(Self, SM_STATUSMODE, m_wStatusTimeArr[POISON_DECHEALTH], m_btGreenPoisoningPoint + 1, g_Config.dwPosionDecHealthTime, nStatus, '');
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
    STATUS_COBWEB: begin
        if boMode then begin
          m_boStatusModeArr[nStatus] := True;
          SendDefMsg(Self, SM_STATUSMODE, m_wStatusTimeArr[POISON_COBWEB], 0, 0, nStatus, '');
        end else begin
          if m_boStatusModeArr[nStatus] then begin
            m_boStatusModeArr[nStatus] := False;
            SendDefMsg(Self, SM_STATUSMODE, 0, 0, 0, nStatus, '');
          end;
        end;
      end;
  end;
end;

procedure TPlayObject.Die();
var
  I: Integer;
begin
  m_boAliveing := False;
  m_dwAliveTick := GetTickCount;
  m_boDoctorAlive := False;
  m_nAliveHP := 10;
  DelTargetCreat();
  for I := Low(m_wStatusTimeArr) to High(m_wStatusTimeArr) do
    if m_wStatusTimeArr[I] > 0 then
      m_wStatusTimeArr[I] := 1;
  inherited;
end;
//人物死亡触发

function TPlayObject.DieFunc: Boolean;
begin
  Result := True;
  NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[nPlayDie], False);
end;
//人物升级触发

procedure TPlayObject.LevelUpFuncEx(nLevel: Word);
begin
  if nLevel in [Low(g_FunctionNPC.FPlayLevelUp)..High(g_FunctionNPC.FPlayLevelUp)] then
    NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FPlayLevelUp[nLevel], False);
end;

function TPlayObject.LevelUpFunc: Boolean;
begin
  Result := True;
  NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[nPlayLevelUp], False);
  UnMaster;
end;
//杀人触发

function TPlayObject.KillPlayFunc: Boolean;
begin
  Result := True;
  NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[nKillPlay], False);
end;

procedure TPlayObject.SpeedCloseFunc;
begin
  NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[nSpeedClose], False);
end;

procedure TPlayObject.ClientChangeMagicKey(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if ProcessMsg.sMsg <> '' then
    DecodeBuffer(ProcessMsg.sMsg, @m_UserKeySetup, SizeOf(m_UserKeySetup));
end;
(*
procedure TPlayObject.ClientGetButchItemEx(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
dwDelayTime: LongWord;
nMsgCount: Integer;
begin
//挖尸体
exit;
if not ClientGetButchItem(TBaseObject(ProcessMsg.nParam1),
  ProcessMsg.nParam2, ProcessMsg.nParam3, ProcessMsg.wParam, dwDelayTime) then begin
  if dwDelayTime <> 0 then begin
    nMsgCount := GetDigUpMsgCount();
    if nMsgCount >= g_Config.nMaxDigUpMsgCount then begin
      Inc(m_nOverSpeedCount);
      if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
        if g_Config.boKickOverSpeed then begin
          SysMsg(g_sKickClientUserMsg {'请勿使用非法软件.'}, c_Red, t_Hint);
          m_boEmergencyClose := True;
          m_boPlayOffLine := False;
        end;
        if g_Config.boViewHackMessage then begin
          MainOutMessage(format(g_sBunOverSpeed, [m_sCharName, dwDelayTime, nMsgCount]));
        end;
      end;
      //如果超速则发送攻击失败信息
      SendActionFail();
    end
    else begin
      if dwDelayTime < g_Config.dwDropOverSpeed then begin
        if m_boTestSpeedMode then
          SysMsg(format('速度异常 Ident: %d Time: %d', [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
        SendActionGood();
      end
      else begin
        SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
          ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3, '', dwDelayTime);
        boResult := False;
      end;
    end;
  end;
end;
end;

function TPlayObject.ClientGetButchItem(BaseObject: TBaseObject; nX, nY:
Integer; btDir: Byte; var dwDelayTime: LongWord): Boolean; //004DB7E0
var
n10, n14: Integer;
dwCheckTime: LongWord;
begin
Result := False;
dwDelayTime := 0;
if m_boDeath or m_boOnHorse or m_boShoping or (not CanWork) then
  Exit; //防麻
//dwCheckTime := GetTickCount - m_dwTurnTick;  1
if dwCheckTime < g_Config.dwTurnIntervalTime then begin
  dwDelayTime := g_Config.dwTurnIntervalTime - dwCheckTime;
  Exit;
end;
// m_dwTurnTick := GetTickCount;  1
if (abs(nX - m_nCurrX) <= 2) and (abs(nY - m_nCurrY) <= 2) then begin
  if m_PEnvir.IsValidObject(nX, nY, 2, BaseObject) then begin
    if BaseObject.m_boDeath and (not BaseObject.m_boSkeleton) and
      (BaseObject.m_boAnimal) then begin
      n10 := Random(16) + 5;
      n14 := Random(201) + 100;
      Dec(BaseObject.m_nBodyLeathery, n10);
      Dec(BaseObject.m_nMeatQuality, n14);
      if BaseObject.m_nMeatQuality < 0 then
        BaseObject.m_nMeatQuality := 0;
      if BaseObject.m_nBodyLeathery <= 0 then begin
        if (BaseObject.m_btRaceServer >= RC_ANIMAL) and
          (BaseObject.m_btRaceServer < RC_MONSTER) then begin
          BaseObject.m_boSkeleton := True;
          ApplyMeatQuality();
          BaseObject.SendRefMsg(RM_SKELETON, BaseObject.m_btDirection, BaseObject.m_nCurrX,
            BaseObject.m_nCurrY, 0, '');
        end;
        if not TakeBagItems(BaseObject) then begin
          SysMsg(sYouFoundNothing {未发现任何物品.}, c_Red, t_Hint);
        end;
        BaseObject.m_nBodyLeathery := 50;
      end;
      m_dwDeathTick := GetTickCount();
    end;
  end;
  m_btDirection := btDir;
end;
SendRefMsg(RM_BUTCH, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;         *)

procedure TPlayObject.ClientSoftClose(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  m_boReconnection := True;
  m_boSoftClose := True;
end;
//解散队伍

procedure TPlayObject.ClientGropuClose;
begin
  m_boAllowGroup := False;
  if m_GroupOwner = nil then
    Exit;
  m_GroupOwner.DelMember(Self);
end;

procedure TPlayObject.ClientCheckMsg(tClass: TCheckMsgClass; AddPointer: Pointer; nSelect: Integer);
var
  PlayObject: TPlayObject;
begin
  try
    PlayObject := TPlayObject(AddPointer);
    if (PlayObject <> nil) and (not PlayObject.m_boGhost) then begin
      if PlayObject.m_nCheckMsgArr[tClass] > 0 then
        Dec(PlayObject.m_nCheckMsgArr[tClass]);

      if m_boGhost or (nSelect = -1) then
        exit;
      if tClass = tmc_Group then begin
        case nSelect of
          0: PlayObject.SysMsg(Format(g_sGropuIsCheckMsgNo, [m_sCharName]), c_red, t_Hint);
          1: PlayObject.AddGroupMember(Self);
        end;
      end
      else if tClass = tmc_Guild then begin
        case nSelect of
          0: PlayObject.SysMsg(Format(g_sGuildIsCheckMsgNo, [m_sCharName]), c_red, t_Hint);
          1: PlayObject.GuildAddMember(Self);
        end;
      end
      else if tClass = tmc_Friend then begin
        case nSelect of
          0: PlayObject.SysMsg(Format(g_sFriendIsCheckMsgNo, [m_sCharName]), c_red, t_Hint);
          1: PlayObject.SetFriend(Self);
        end;
      end
      else if tClass = tmc_Deal then begin
        case nSelect of
          0: PlayObject.SysMsg(Format(g_sDealIsCheckMsgNo, [m_sCharName]), c_red, t_Hint);
          1: PlayObject.SetDeal(Self);
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(E.Message);
      MainOutMessage('[Exception] TPlayObject.ClientCheckMsg');
    end;

  end;
end;

procedure TPlayObject.ClientGetCheckMsg(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  Msg: pTCheckMsg;
  i: Integer;
  CheckMsg: pTCheckMsg;
  nSelect: Integer;
begin
  CheckMsg := pTCheckMsg(ProcessMsg.nParam1);
  nSelect := ProcessMsg.wParam;
  if m_CheckMsgList.Count > 0 then begin
    for i := 0 to m_CheckMsgList.Count - 1 do begin
      Msg := m_CheckMsgList.Items[i];
      if (Msg <> nil) and (Msg = CheckMsg) then begin
        ClientCheckMsg(Msg.tClass, msg.AllPurpose, nSelect);
        DisPose(Msg);
        m_CheckMsgList.Delete(i);
        break;
      end;
    end;
  end;
end;

function TPlayObject.AddCheckMsg(sMsg: string; tClass: TCheckMsgClass; AddPointer: TPlayObject; AddTime: LongWord): pTCheckMsg;
var
  CheckMsg: pTCheckMsg;
  i: Integer;
begin
  Result := nil;
  if AddPointer.m_nCheckMsgArr[tClass] >= 5 then
    exit;
  if {(tClass = tmc_Group) and }(m_CheckMsgList.Count > 0) then begin
    for i := 0 to m_CheckMsgList.Count - 1 do begin
      CheckMsg := m_CheckMsgList.Items[i];
      if (CheckMsg <> nil) and (CheckMsg.AllPurpose = AddPointer) and (CheckMsg.tClass = tClass) then begin
        exit;
      end;
    end;
  end;
  New(CheckMsg);
  Inc(AddPointer.m_nCheckMsgArr[tClass]);
  CheckMsg.tClass := tClass;
  CheckMsg.AllPurpose := AddPointer;
  CheckMsg.AddTime := GetTickCount + AddTime * 1000;
  m_CheckMsgList.Add(CheckMsg);
  SendDefMsg(Self, SM_CHECKMSG, Integer(CheckMsg), AddTime - 2, 0, Integer(tClass), sMsg);
  Result := CheckMsg;
end;

//队伍五行属性

procedure TPlayObject.RefGroupWuXin(BaseObject: TBaseObject);
var
  i: integer;
  Targe: TBaseObject;
  nMaxLevel: integer;
  nAddHP: Word;
begin
  if not g_Config.boCloseWuXin then begin
    if BaseObject = nil then begin
      if (m_GroupOwner <> nil) then begin
        for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
          Targe := TBaseObject(m_GroupOwner.m_GroupMembers.Objects[i]);
          if (Targe <> nil) and (Targe.m_btRaceServer = RC_PLAYOBJECT) and (not Targe.m_boDeath) then begin
            TPlayObject(Targe).RefGroupWuXin(Targe);
          end;
        end;
      end;
      exit;
    end
    else begin
      nAddHP := m_OldHP;
      m_AddHP := 0;
      if (m_GroupOwner <> nil) and (not m_boDeath) and (not m_boGhost) then begin
        nMaxLevel := 0;
        for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
          Targe := TBaseObject(m_GroupOwner.m_GroupMembers.Objects[i]);
          if (Targe <> nil) and (not Targe.m_boDeath) and (not Targe.m_boGhost) and
            (targe.m_PEnvir = m_PEnvir) and
            (abs(targe.m_nCurrX - m_nCurrX) <= g_Config.nSendRefMsgRange) and
            (abs(targe.m_nCurrY - m_nCurrY) <= g_Config.nSendRefMsgRange) and
            CheckWuXinConsistent(Targe.m_btWuXin, m_btWuXin) then begin
            if Targe.m_Abil.Level > nMaxLevel then
              nMaxLevel := Targe.m_Abil.Level;
          end;
        end;
        if nMaxlevel > 0 then begin
          m_AddHP := _MIN(High(Word), Round(m_Abil.MaxHP * (nMaxLevel / 200)));
          nAddHP := _MIN(High(Word), m_OldHP + m_AddHP);
        end;
      end;
      if nAddHP <> m_WAbil.MaxHP then begin
        m_WAbil.MaxHP := nAddHP;
        HealthSpellChanged;
      end;
    end;
  end;
end;
//创建队伍

procedure TPlayObject.ClientCreateGroup(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  PlayObject: TPlayObject;
  tempstr: string;
  ItemClass: Boolean;
  sHumName: string;
begin
  ItemClass := Boolean(ProcessMsg.nParam1);
  sHumName := Trim(ProcessMsg.sMsg);
  m_GroupClass := ItemClass;
  PlayObject := UserEngine.GetPlayObject(sHumName);
  if m_GroupOwner <> nil then begin
    SendDefMessage(SM_CREATEGROUP_FAIL, -1, 0, 0, 0, '');
    Exit;
  end;
  if (PlayObject = nil) or (PlayObject = Self) or PlayObject.m_boGhost or m_boGhost then begin
    SendDefMessage(SM_CREATEGROUP_FAIL, -2, 0, 0, 0, '');
    Exit;
  end;
  if (PlayObject.m_GroupOwner <> nil) then begin
    SendDefMessage(SM_CREATEGROUP_FAIL, -3, 0, 0, 0, '');
    Exit;
  end;
  if (not PlayObject.m_boAllowGroup) or (PlayObject.m_boSafeOffLine) then begin
    SendDefMessage(SM_CREATEGROUP_FAIL, -4, 0, 0, 0, '');
    Exit;
  end;
  if (PlayObject.m_boCheckGroup) then begin
    if ItemClass then
      tempstr := g_sGroupItemClass2
    else
      tempstr := g_sGroupItemClass1;
    if PlayObject.AddCheckMsg(Format(g_sGroupCheckMsg, [m_sCharName, m_Abil.Level, tempstr]), tmc_Group, Self, 62) <> nil then begin
      SendDefMessage(SM_CREATEGROUP_FAIL, 1, 0, 0, 0, '')
        //SysMsg(g_sGropuIsCheckMsg, c_red, t_hint);
    end
    else
      SendDefMessage(SM_CREATEGROUP_FAIL, 2, 0, 0, 0, '');
    //SysMsg(g_sGropuIsCheckMsgNot, c_red, t_Hint);
    Exit;
  end;
  m_boCanCreateGroup := True;
  PlayObject.m_boCanCreateGroup := True;

  NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NSTARTGROUP], False);
  if (not m_boCanCreateGroup) then
    Exit;

  PlayObject.NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NSTARTGROUP], False);
  if (not PlayObject.m_boCanCreateGroup) then
    Exit;

  m_GroupClass := ItemClass;
  m_GroupMembers.Clear;
  m_GroupOwner := Self;
  m_GroupMembers.AddObject(m_sCharName, Self);
  SendGroupMembers(Self);
  m_GroupMembers.AddObject(sHumName, PlayObject);
  PlayObject.JoinGroup(Self);
  SendGroupMembers(PlayObject);
  m_boAllowGroup := True;
  SetIntStatus(m_nAllowSetup, GSP_NOTGROUP, False);
  PlayObject.m_boAllowGroup := True;
  SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTGROUP, False);
  SendDefMessage(SM_CREATEGROUP_OK, 0, 0, 0, 0, '');
  RefGroupWuXin(nil);

  NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NGROUPCREATE], False);
  m_sString[0] := PlayObject.m_sCharName;
  NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NJOINGROUP], False);
end;

//增加队员

procedure TPlayObject.AddGroupMember(PlayObject: TPlayObject);
begin
  if m_GroupOwner <> nil then begin
    if (not PlayObject.m_boAllowGroup) then begin
      PlayObject.SysMsg('无法加入队伍, 你不允许组队!', c_red,
        t_hint);
      Exit;
    end;
    if m_GroupOwner <> Self then begin
      PlayObject.SysMsg('无法加入队伍, 对方已不是组长!', c_red,
        t_hint);
      Exit;
    end;
    if m_GroupMembers.Count > g_Config.nGroupMembersMax then begin
      PlayObject.SysMsg('无法加入队伍, 已满员!', c_red, t_hint);
      Exit;
    end;
    if (PlayObject = nil) or (PlayObject = Self) or PlayObject.m_boGhost or m_boGhost then begin
      PlayObject.SysMsg('无法加入队伍, 对方或者你本身状态异常!', c_red, t_hint);
      Exit;
    end;
    if (PlayObject.m_GroupOwner <> nil) then begin
      PlayObject.SysMsg('无法加入队伍, 你已经加入了队伍!', c_red,
        t_hint);
      Exit;
    end;
    if IsGroupMemberEx(PlayObject) then begin
      Exit;
    end;
    PlayObject.m_boCanCreateGroup := True;
    PlayObject.NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NSTARTGROUP], False);
    if (not PlayObject.m_boCanCreateGroup) then
      Exit;

    m_GroupMembers.AddObject(PlayObject.m_sCharName, PlayObject);
    PlayObject.JoinGroup(Self);
    SendGroupMembers(PlayObject);
    RefGroupWuXin(nil);
    m_sString[0] := PlayObject.m_sCharName;
    NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NJOINGROUP], False);
  end
  else begin
    if (not PlayObject.m_boAllowGroup) then begin
      PlayObject.SysMsg('无法加入队伍, 你不允许组队!', c_red,
        t_hint);
      Exit;
    end;
    if (PlayObject = nil) or (PlayObject = Self) or PlayObject.m_boGhost or m_boGhost then begin
      PlayObject.SysMsg('无法加入队伍, 对方或者你本身状态异常!', c_red, t_hint);
      Exit;
    end;
    if (PlayObject.m_GroupOwner <> nil) then begin
      PlayObject.SysMsg('无法加入队伍, 你已经加入了队伍!', c_red,
        t_hint);
      Exit;
    end;
    m_boCanCreateGroup := True;
    PlayObject.m_boCanCreateGroup := True;

    NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NSTARTGROUP], False);
    if (not m_boCanCreateGroup) then
      Exit;

    PlayObject.NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NSTARTGROUP], False);
    if (not PlayObject.m_boCanCreateGroup) then
      Exit;

    m_GroupMembers.Clear;
    m_GroupOwner := Self;
    m_GroupMembers.AddObject(m_sCharName, Self);
    SendGroupMembers(Self);
    m_GroupMembers.AddObject(PlayObject.m_sCharName, PlayObject);
    PlayObject.JoinGroup(Self);
    SendGroupMembers(PlayObject);
    m_boAllowGroup := True;
    SetIntStatus(m_nAllowSetup, GSP_NOTGROUP, False);
    PlayObject.m_boAllowGroup := True;
    SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTGROUP, False);
    SendDefMessage(SM_CREATEGROUP_OK, 0, 0, 0, 0, '');
    RefGroupWuXin(nil);
    NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NGROUPCREATE], False);
    m_sString[0] := PlayObject.m_sCharName;
    NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NJOINGROUP], False);
  end;
end;

procedure TPlayObject.ClientAddGroupMember(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  PlayObject: TPlayObject;
  tempstr: string;
  sHumName: string;
begin
  sHumName := ProcessMsg.sMsg;
  PlayObject := UserEngine.GetPlayObject(sHumName);

  if m_GroupOwner <> Self then begin
    SendDefMessage(SM_GROUPADDMEM_FAIL, -1, 0, 0, 0, '');
    Exit;
  end;
  if m_GroupMembers.Count > g_Config.nGroupMembersMax then begin
    SendDefMessage(SM_GROUPADDMEM_FAIL, -5, 0, 0, 0, '');
    Exit;
  end;
  if (PlayObject = nil) or (PlayObject = Self) or PlayObject.m_boGhost or m_boGhost then begin
    SendDefMessage(SM_GROUPADDMEM_FAIL, -2, 0, 0, 0, '');
    Exit;
  end;
  if (PlayObject.m_GroupOwner <> nil) then begin
    SendDefMessage(SM_GROUPADDMEM_FAIL, -3, 0, 0, 0, '');
    Exit;
  end;
  if (not PlayObject.m_boAllowGroup) or (PlayObject.m_boSafeOffLine) then begin
    SendDefMessage(SM_GROUPADDMEM_FAIL, -4, 0, 0, 0, '');
    Exit;
  end;
  if IsGroupMemberEx(PlayObject) then begin
    SendDefMessage(SM_GROUPADDMEM_FAIL, -2, 0, 0, 0, '');
    Exit;
  end;
  if (PlayObject.m_boCheckGroup) then begin
    if m_GroupClass then
      tempstr := g_sGroupItemClass2
    else
      tempstr := g_sGroupItemClass1;
    if PlayObject.AddCheckMsg(Format(g_sGroupCheckMsg, [m_sCharName, m_Abil.Level, tempstr]), tmc_Group, Self, 32) <> nil then begin
      SendDefMessage(SM_CREATEGROUP_FAIL, 1, 0, 0, 0, '')
    end
    else
      SendDefMessage(SM_CREATEGROUP_FAIL, 2, 0, 0, 0, '');
    Exit;
  end;

  PlayObject.m_boCanCreateGroup := True;
  PlayObject.NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NSTARTGROUP], False);
  if (not PlayObject.m_boCanCreateGroup) then
    Exit;

  m_GroupMembers.AddObject(sHumName, PlayObject);
  PlayObject.JoinGroup(Self);
  SendGroupMembers(PlayObject);
  RefGroupWuXin(nil);

  m_sString[0] := PlayObject.m_sCharName;
  NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NJOINGROUP], False);
  //SendDefMessage(SM_GROUPADDMEM_OK, 0, 0, 0, 0, '');
  //SendGroupMembers(nil);
end;
//删除队员

procedure TPlayObject.ClientDelGroupMember(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  PlayObject: TPlayObject;
  sHumName: string;
begin
  sHumName := ProcessMsg.sMsg;
  PlayObject := UserEngine.GetPlayObject(sHumName);
  if m_GroupOwner <> Self then begin
    if (PlayObject = Self) and (PlayObject.m_GroupOwner <> nil) then begin
      TPlayObject(PlayObject.m_GroupOwner).DelMember(PlayObject);
      SendDefMessage(SM_GROUPDELMEM_OK, 0, 0, 0, 0, '');
      exit;
    end;
    SendDefMessage(SM_GROUPDELMEM_FAIL, -1, 0, 0, 0, '');
    Exit;
  end;
  if PlayObject = nil then begin
    SendDefMessage(SM_GROUPDELMEM_FAIL, -2, 0, 0, 0, '');
    Exit;
  end;
  if not IsGroupMember(PlayObject) then begin
    SendDefMessage(SM_GROUPDELMEM_FAIL, -3, 0, 0, 0, '');
    Exit;
  end;
  DelMember(PlayObject);
  //SendDefMessage(SM_GROUPDELMEM_OK, 0, 0, 0, 0, '');
end;

procedure TPlayObject.ClientDealTry(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  PlayObject: TPlayObject;
  sHumName: string;
begin
  if not m_boMapApoise then
    exit; //如果客户端地图未准备好,不允许
  sHumName := ProcessMsg.sMsg;
  if g_Config.boDisableDeal or Self.m_PEnvir.m_boNODEAL then begin
    SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, g_sDisableDealItemsMsg);
    Exit;
  end;
  if m_boDealing then
    Exit;
  if ProcessMsg.nParam1 = Integer(Self) then
    exit;

  if CretInNearXY(TBaseObject(ProcessMsg.nParam1), ProcessMsg.nParam2, ProcessMsg.nParam3) and
    (TBaseObject(ProcessMsg.nParam1).m_btRaceServer = RC_PLAYOBJECT) then begin
    PlayObject := TPlayObject(ProcessMsg.nParam1);
    if PlayObject.m_boDeath then
      exit;
    if abs(m_nCurrX - PlayObject.m_nCurrX) > g_Config.nSendRefMsgRange then
      exit;
    if abs(m_nCurrY - PlayObject.m_nCurrY) > g_Config.nSendRefMsgRange then
      exit;
    if (not PlayObject.m_boAllowDeal) or (PlayObject.m_boSafeOffLine) then begin
      //SysMsg('对方拒绝交易.', c_Red, t_Hint);
      SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '[失败]：（' + PlayObject.m_sCharName + '） 拒绝交易！');
      exit;
    end;
    if PlayObject.m_boDealing then begin
      //SysMsg('对方正在进行交易.', c_Red, t_Hint);
      SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '[失败]：（' + PlayObject.m_sCharName + '） 正在与别人进行交易！');
      exit;
    end;
    if PlayObject.AddCheckMsg(Format(g_sDealCheckMsg, [m_sCharName]), tmc_Deal, Self) <> nil then
      //SysMsg(g_sDealIsCheckMsg, c_Red, t_Hint)
      SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '成功发送了交易邀请，请等待对方回应！')
    else
      SendDefMessage(SM_MENU_OK, 0, 0, 0, 0, '[失败]: 已经向（' + PlayObject.m_sCharName +
        '）发送了交易邀请，请不要重复发送！');
    //SysMsg(g_sDealIsCheckMsgNot, c_Red, t_Hint);
  //if BaseObject.m_boDeath or BaseObject.m_boDealing then exit;
  end;
end;

procedure TPlayObject.ClientAddDealItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  i: Integer;
  bo11: Boolean;
  UserItem: pTUserItem;
  nItemIdx: Integer;
  StdItem: pTStdItem;
begin
  nItemIdx := ProcessMsg.nParam1;
  if (m_DealCreat = nil) or (not m_boDealing) then
    Exit;
  if g_Config.boDisableDeal or Self.m_PEnvir.m_boNODEAL then begin
    SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, g_sDisableDealItemsMsg);
    Exit;
  end;
  bo11 := False;
  //if not m_DealCreat.m_boDealOK and  then begin
  if (not m_boDealOK) and (not m_boDealLock) then begin
    for i := m_ItemList.Count - 1 downto 0 do begin
      if m_ItemList.Count <= 0 then
        break;
      UserItem := m_ItemList.Items[i];
      if UserItem = nil then
        Continue;
      if UserItem.MakeIndex = nItemIdx then begin
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem = nil then
          break;
        if CheckItemBindMode(UserItem, bm_NoDeal) then begin
          SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, g_sCanotUserDealItem);
          break;
        end;
        if (m_DealItemList.Count < 12) then begin
          m_DealItemList.Add(UserItem);
          SendAddDealItem(UserItem);
          m_ItemList.Delete(i);
          RecalcBagCount();
          bo11 := True;
          break;
        end;
      end;
    end;
  end;
  if not bo11 then
    SendDefMessage(SM_DEALADDITEM_FAIL, 0, 0, 0, 0, '');
end;

procedure TPlayObject.ClientDelDealItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  i: Integer;
  bo11: Boolean;
  UserItem: pTUserItem;
  nItemIdx: Integer;
begin
  nItemIdx := ProcessMsg.nParam1;
  if (m_DealCreat = nil) or (not m_boDealing) then
    Exit;

  bo11 := False;
  //if not m_DealCreat.m_boDealOK then begin
  if (not m_boDealOK) and (not m_boDealLock) then begin
    for i := m_DealItemList.Count - 1 downto 0 do begin
      if m_DealItemList.Count <= 0 then
        break;
      UserItem := m_DealItemList.Items[i];
      if UserItem = nil then
        Continue;
      if UserItem.MakeIndex = nItemIdx then begin
        m_ItemList.Add(UserItem);
        TPlayObject(Self).SendDelDealItem(UserItem);
        m_DealItemList.Delete(i);
        RecalcBagCount();
        bo11 := True;
        break;
      end;
    end;
  end;
  if not bo11 then
    SendDefMessage(SM_DEALDELITEM_FAIL, 0, 0, 0, 0, '');
end;

procedure TPlayObject.ClientCancelDeal(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  DealCancel();
end;

procedure TPlayObject.ClientDealModeChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if ProcessMsg.nParam1 > 0 then
    ClientDealLock()
  else
    ClientDealEnd();
end;

procedure TPlayObject.ClientChangeDealGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  bo09: Boolean;
  nGold: Integer;
begin
  //禁止取回放入交易栏内的金币
  nGold := Processmsg.nParam1;
  if nGold < 0 then begin
    SendDefMessage(SM_DEALCHGGOLD_FAIL, m_nDealGolds, LoWord(m_nGold), HiWord(m_nGold), 0, '');
    Exit;
  end;
  bo09 := False;
  if (m_DealCreat <> nil) {and (GetPoseCreate = m_DealCreat)} then begin
    //if not m_DealCreat.m_boDealOK then begin
    if (not m_boDealOK) and (not m_boDealLock) then begin
      if (m_nGold + m_nDealGolds) >= nGold then begin
        m_nGold := (m_nGold + m_nDealGolds) - nGold;
        m_nDealGolds := nGold;
        SendDefMessage(SM_DEALCHGGOLD_OK, m_nDealGolds, LoWord(m_nGold), HiWord(m_nGold), 0, '');
        TPlayObject(m_DealCreat).SendDefMessage(SM_DEALREMOTECHGGOLD, m_nDealGolds, 0, 0, 0, '');
        m_DealCreat.m_DealLastTick := GetTickCount();
        bo09 := True;
        m_DealLastTick := GetTickCount();
      end;
    end;
  end;
  if not bo09 then begin
    SendDefMessage(SM_DEALCHGGOLD_FAIL, m_nDealGolds, LoWord(m_nGold), HiWord(m_nGold), 0, '');
  end;
end;

procedure TPlayObject.ClientDealLock();
begin
  m_boDealLock := True;
  if m_DealCreat = nil then
    Exit;
  if m_DealCreat.m_btRaceServer <> RC_PLAYOBJECT then
    exit;
  TPlayObject(m_DealCreat).SendDefMessage(SM_DEALSUCCESS, 1, 0, 0, 0, '');
end;

procedure TPlayObject.ClientDealEnd;
var
  i: Integer;
  bo11: Boolean;
  UserItem {, AddUserItem}: pTUserItem;
  StdItem: pTStdItem;
  PlayObject: TPlayObject;
begin
  m_boDealOK := True;
  if m_DealCreat = nil then
    Exit;
  if ((GetTickCount - m_DealLastTick) < g_Config.dwDealOKTime {1000}) or
    ((GetTickCount - m_DealCreat.m_DealLastTick) < g_Config.dwDealOKTime {1000}) then begin
    SysMsg(g_sDealOKTooFast, c_Red, t_Hint);
    DealCancel();
    Exit;
  end;
  if m_DealCreat.m_boDealOK then begin
    bo11 := True;
    if (m_nMaxItemListCount - (m_ItemList.Count + m_DealItemList.Count)) < m_DealCreat.m_DealItemList.Count then begin
      bo11 := False;
      SysMsg(g_sYourBagSizeTooSmall, c_Red, t_Hint);
    end;
    if (m_nGoldMax - m_nGold) < m_DealCreat.m_nDealGolds then begin
      SysMsg(g_sYourGoldLargeThenLimit, c_Red, t_Hint);
      bo11 := False;
    end;
    if (m_DealCreat.m_nMaxItemListCount - (m_DealCreat.m_ItemList.Count + m_DealCreat.m_DealItemList.Count)) <
      m_DealItemList.Count then begin
      SysMsg(g_sDealHumanBagSizeTooSmall, c_Red, t_Hint);
      bo11 := False;
    end;
    if (m_DealCreat.m_nGoldMax - m_DealCreat.m_nGold) < m_nDealGolds then begin
      SysMsg(g_sDealHumanGoldLargeThenLimit, c_Red, t_Hint);
      bo11 := False;
    end;
    if bo11 then begin
      for i := 0 to m_DealItemList.Count - 1 do begin
        UserItem := m_DealItemList.Items[i];
        if UserItem = nil then
          Continue;
        //m_DealCreat.AddItemToBag(UserItem, nil, False, '', '', AddUserItem);
        TPlayObject(m_DealCreat).m_ItemList.Add(UserItem);
        TPlayObject(m_DealCreat).SendAddItem(UserItem);
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if (StdItem <> nil) and (StdItem.NeedIdentify = 1) then begin
          AddGameLog(Self, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, m_DealCreat.m_sCharName, '0',
            '0', '交易', UserItem);
          AddGameLog(m_DealCreat, LOG_ADDITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName,
            '0', '0', '交易', UserItem);
        end;
      end; //004DDF5A
      if m_nDealGolds > 0 then begin
        Inc(m_DealCreat.m_nGold, m_nDealGolds);
        m_DealCreat.GoldChanged();
        //004DE05E
        if g_boGameLogGold then begin
          AddGameLog(Self, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, m_nGold, m_DealCreat.m_sCharName, '-',
            IntToStr(m_nDealGolds), '交易', nil);
          AddGameLog(m_DealCreat, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, m_DealCreat.m_nGold, m_sCharName,
            '+', IntToStr(m_nDealGolds), '交易', nil);
        end;
      end;
      for i := 0 to m_DealCreat.m_DealItemList.Count - 1 do begin
        UserItem := m_DealCreat.m_DealItemList.Items[i];
        if UserItem = nil then
          Continue;
        //AddItemToBag(UserItem, nil, False, '', '', AddUserItem);
        TPlayObject(Self).m_ItemList.Add(UserItem);
        TPlayObject(Self).SendAddItem(UserItem);
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if (StdItem <> nil) and (StdItem.NeedIdentify = 1) then begin
          AddGameLog(m_DealCreat, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName, '0', '0',
            '交易', UserItem);
          AddGameLog(Self, LOG_ADDITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, m_DealCreat.m_sCharName,
            '0', '0', '交易', UserItem);
        end;
      end; //004DDF5A
      if m_DealCreat.m_nDealGolds > 0 then begin
        Inc(m_nGold, m_DealCreat.m_nDealGolds);
        GoldChanged();
        //004DE36E
        if g_boGameLogGold then begin
          AddGameLog(m_DealCreat, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, m_DealCreat.m_nGold, m_sCharName,
            '-', IntToStr(m_DealCreat.m_nDealGolds), '交易', nil);
          AddGameLog(Self, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, m_nGold, m_DealCreat.m_sCharName,
            '+', IntToStr(m_DealCreat.m_nDealGolds), '交易', nil);
        end;
      end;
      //004DE37
      PlayObject := TPlayObject(m_DealCreat);
      PlayObject.SendDefMessage(SM_DEALSUCCESS, 0, 0, 0, 0, '');
      //PlayObject.SysMsg(g_sDealSuccessMsg {'交易成功...'}, c_Green, t_Hint);
      PlayObject.m_DealCreat := nil;
      PlayObject.m_boDealing := False;
      PlayObject.m_DealItemList.Clear;
      PlayObject.m_nDealGolds := 0;
      PlayObject.m_boDealOK := False; //Jacky 增加
      SendDefMessage(SM_DEALSUCCESS, 0, 0, 0, 0, '');
      //SysMsg(g_sDealSuccessMsg {'交易成功...'}, c_Green, t_Hint);
      m_DealCreat := nil;
      m_boDealing := False;
      m_DealItemList.Clear;
      m_nDealGolds := 0;
      m_boDealOK := False; //Jacky 增加
      RecalcBagCount();
      PlayObject.RecalcBagCount();
      PlayObject.m_dwSaveRcdTick := 0; //Jason 新增交易完成立既保存数据
      m_dwSaveRcdTick := 0; //Jason 新增交易完成立既保存数据
    end
    else begin //004DE42F
      DealCancel();
    end;
  end
  else begin //004DE439
    if m_DealCreat = nil then
      Exit;
    if m_DealCreat.m_btRaceServer <> RC_PLAYOBJECT then
      exit;
    TPlayObject(m_DealCreat).SendDefMessage(SM_DEALSUCCESS, 2, 0, 0, 0, '');
    //SysMsg(g_sYouDealOKMsg {'你已经确认交易了'}, c_Green, t_Hint);
    //m_DealCreat.SysMsg(g_sPoseDealOKMsg {'对方已经确认交易了'}, c_Green, t_Hint);
  end;
end;

procedure TPlayObject.MakeItem(MakeGoods: pTMakeGoods; sMsg: string; BaseObject: TBaseObject; btIdx, btAuto: Byte);
var
  sSendMsg, sNPCName: string;
  nBack: Byte;
  StrengthenItem: TStrengthenItem;
  UserItemLevelArr: array[0..4] of pTUserItem;
  UserItemAssArr: array[0..4] of pTUserItem;
  StdItemLevelArr: array[0..4] of pTStdItem;
  StdItemAssArr: array[0..4] of pTStdItem;
  DelItemCount: array[0..4] of Integer;
  pGold: pInteger;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  i, ii: Integer;
  nUpRate, nAssArrRate: Integer;
  boItemOK: Boolean;
  boUpOK: Boolean;
  boAutoMake: Boolean;
  nAutoMaxCount, nMakeOkCount, nMaxGold: Integer;
  boAutoOK: Boolean;
  btBindMode1: Byte;
  btBindMode2: Byte;
begin
  nBack := 0;
  sSendMsg := '';
  if MakeGoods = nil then
    Exit;
  if BaseObject <> nil then
    sNPCName := BaseObject.m_sCharName
  else
    sNPCName := '';
  try
    btBindMode1 := 0;
    SafeFillChar(StrengthenItem, SizeOf(StrengthenItem), #0);
    DecodeBuffer(sMsg, @StrengthenItem, SizeOf(StrengthenItem));

    SafeFillChar(UserItemLevelArr, SizeOf(UserItemLevelArr), #0);
    SafeFillChar(UserItemAssArr, SizeOf(UserItemAssArr), #0);
    SafeFillChar(StdItemLevelArr, SizeOf(StdItemLevelArr), #0);
    SafeFillChar(StdItemAssArr, SizeOf(StdItemAssArr), #0);
    SafeFillChar(DelItemCount, SizeOf(DelItemCount), #0);
    pGold := nil;

    StdItem := UserEngine.GetStdItem(MakeGoods.MakeItem.ItemArr[0].wIdent);
    if StdItem = nil then
      exit;
    boAutoMake := (btAuto = 1) and (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1);
    if boAutoMake then
      nAutoMaxCount := StdItem.DuraMax
    else
      nAutoMaxCount := 1;
    nMakeOkCount := 0;
    boAutoOK := False;

    if m_nBindGold >= MakeGoods.MakeItem.nMoney then
      pGold := @m_nBindGold
    else if m_nGold >= MakeGoods.MakeItem.nMoney then
      pGold := @m_nGold;
    nBack := 5; //缺少强化资金
    if not IsEnoughBag then begin
      nBack := 12; //背包没有空格了
      pGold := nil;
    end;
    if (pGold <> nil) then begin
      //获取背包是否有指定的物品

      nAutoMaxCount := _MIN(nAutoMaxCount, (m_nGold + m_nBindGold) div MakeGoods.MakeItem.nMoney);
      try
        for i := m_ItemList.Count - 1 downto 0 do begin
          UserItem := m_ItemList[i];
          if UserItem <> nil then begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem = nil then
              Continue;
            for II := Low(UserItemLevelArr) to High(UserItemLevelArr) do begin
              if UserItem.MakeIndex = StrengthenItem.nLevelIdx[II] then begin //玄晶
                if (UserItem.wIndex = MakeGoods.MakeItem.ItemArr[II + 1].wIdent) then begin
                  if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
                    if UserItem.Dura < MakeGoods.MakeItem.ItemArr[II + 1].wCount then
                      break;
                    nAutoMaxCount := _MIN(nAutoMaxCount, UserItem.Dura div MakeGoods.MakeItem.ItemArr[II + 1].wCount);
                  end
                  else
                    boAutoMake := False;
                  m_ItemList.Delete(I);
                  UserItemLevelArr[II] := UserItem;
                  StdItemLevelArr[II] := StdItem;
                  if CheckByteStatus(UserItem.btBindMode1, Ib_NoDeal) then
                    SetByteStatus(btBindMode1, Ib_NoDeal, True);
                  if CheckByteStatus(UserItem.btBindMode1, Ib_NoSave) then
                    SetByteStatus(btBindMode1, Ib_NoSave, True);
                  if CheckByteStatus(UserItem.btBindMode1, Ib_NoRepair) then
                    SetByteStatus(btBindMode1, Ib_NoRepair, True);
                  if CheckByteStatus(UserItem.btBindMode1, Ib_NoDrop) then
                    SetByteStatus(btBindMode1, Ib_NoDrop, True);
                  if CheckByteStatus(UserItem.btBindMode1, Ib_NoDown) then
                    SetByteStatus(btBindMode1, Ib_NoDown, True);
                  if CheckByteStatus(UserItem.btBindMode1, Ib_NoMake) then
                    SetByteStatus(btBindMode1, Ib_NoMake, True);
                  if CheckByteStatus(UserItem.btBindMode1, Ib_NoSell) then
                    SetByteStatus(btBindMode1, Ib_NoSell, True);
                  if CheckByteStatus(UserItem.btBindMode1, Ib_DropDestroy) then
                    SetByteStatus(btBindMode1, Ib_DropDestroy, True);
                end;
                break;
              end
              else if UserItem.MakeIndex = StrengthenItem.nAssIdx[II] then begin //辅助
                if (tm_MakeStone = StdItem.StdMode) and (StdItem.Shape = 2) then begin
                  m_ItemList.Delete(I);
                  UserItemAssArr[II] := UserItem;
                  StdItemAssArr[II] := StdItem;
                end;
                break;
              end;
            end; // end for ii
          end;
        end; // end for i
        if nAutoMaxCount <= 1 then
          boAutoMake := False;

        nUpRate := MakeGoods.MakeItem.btRate;
        nAssArrRate := 0;
        boItemOK := True;
        for II := Low(UserItemLevelArr) to High(UserItemLevelArr) do begin
          if MakeGoods.MakeItem.ItemArr[II + 1].wIdent > 0 then begin
            if UserItemLevelArr[II] = nil then begin
              boItemOk := False;
              break;
            end;
            if StdItemLevelArr[II].StdMode = tm_Ore then //矿石纯度增加成功机率
              Inc(nUpRate, UserItemLevelArr[II].Dura div 1000);
          end;
          if UserItemAssArr[II] <> nil then begin
            Inc(nAssArrRate, StdItemAssArr[II].Reserved);
          end;
        end;
        nBack := 6; //所需要的物品不全
        if boItemOK then begin
          if (GetMissionFlagStatus(MISSIONVAR_MAKEITEM) = 0) then
            SetMissionFlagStatus(MISSIONVAR_MAKEITEM, 1);

          if (BaseObject = nil) and (btIdx in [0..9]) then begin
            if (GetMissionFlagStatus(MISSIONVAR_MAKEMAGIC_0 + btIdx) = 0) then
              SetMissionFlagStatus(MISSIONVAR_MAKEMAGIC_0 + btIdx, 1);
          end;

          if (BaseObject = nil) and (m_MakeMagic[btIdx] > 0) then begin
            Inc(nUpRate, m_MakeMagic[btIdx] div g_Config.btMakeMagicAddRate);
          end;

          if boAutoMake and (nAutoMaxCount > 1) then begin
            nMaxGold := nAutoMaxCount * MakeGoods.MakeItem.nMoney;
            if m_nBindGold >= nMaxGold then begin
              Dec(m_nBindGold, nMaxGold);
              nMaxGold := 0;
            end
            else begin
              Dec(nMaxGold, m_nBindGold);
              m_nBindGold := 0;
            end;
            if (nMaxGold > 0) and (m_nGold >= nMaxGold) then
              Dec(m_nGold, nMaxGold);

            for I := 1 to nAutoMaxCount do begin
              if (Random(100) < nUpRate) then begin
                Inc(nMakeOkCount);
                boUpOK := True;
              end;
            end;

          end
          else begin
            nUpRate := nUpRate + nAssArrRate;
            if nUpRate > MakeGoods.MakeItem.btMaxRate then
              nUpRate := MakeGoods.MakeItem.btMaxRate;
            nBack := 7; //升级完成
            Dec(pGold^, MakeGoods.MakeItem.nMoney); //扣除强化费用
            boUpOK := (Random(100) < nUpRate);
          end;
          if not boAutoMake then
            nAutoMaxCount := 1;

          //删除强化玄晶等物品
          for II := Low(UserItemLevelArr) to High(UserItemLevelArr) do begin
            if UserItemLevelArr[II] <> nil then begin
              if (sm_Superposition in StdItemLevelArr[II].StdModeEx) and
                (StdItemLevelArr[II].DuraMax > 1) and
                (UserItemLevelArr[II].Dura > (MakeGoods.MakeItem.ItemArr[II + 1].wCount * nAutoMaxCount)) then begin
                Dec(UserItemLevelArr[II].Dura, MakeGoods.MakeItem.ItemArr[II + 1].wCount * nAutoMaxCount);
                if StdItemLevelArr[II].NeedIdentify = 1 then
                  AddGameLog(Self, LOG_ITEMDURACHANGE, StdItemLevelArr[II].Name,
                    UserItemLevelArr[II].MakeIndex,
                    UserItemLevelArr[II].Dura, sNPCName, '-',
                    IntToStr(MakeGoods.MakeItem.ItemArr[II + 1].wCount * nAutoMaxCount), '打造', UserItemLevelArr[II]);
              end
              else begin
                //2010-06-26 增加失败不清除物品
                if (not MakeGoods.MakeItem.ItemArr[II + 1].boNotGet) or boUpOK then begin
                  if StdItemLevelArr[II].NeedIdentify = 1 then
                    AddGameLog(Self, LOG_DELITEM, StdItemLevelArr[II].Name, UserItemLevelArr[II].MakeIndex,
                      UserItemLevelArr[II].Dura, sNPCName, '0', '0', '打造', UserItemLevelArr[II]);
                  Dispose(UserItemLevelArr[II]);
                  UserItemLevelArr[II] := nil;
                  StdItemLevelArr[II] := nil;
                end;
              end;
            end;
            if UserItemAssArr[II] <> nil then begin
              if StdItemAssArr[II].NeedIdentify = 1 then
                AddGameLog(Self, LOG_DELITEM, StdItemAssArr[II].Name, UserItemAssArr[II].MakeIndex,
                  UserItemAssArr[II].Dura, sNPCName, '0', '0', '打造', UserItemAssArr[II]);
              Dispose(UserItemAssArr[II]);
              UserItemAssArr[II] := nil;
              StdItemAssArr[II] := nil;
            end;
          end;
          boAutoOK := True;
          if boUpOK then begin
            nBack := 7; //系统错误
            New(UserItem);
            if UserEngine.CopyToUserItemFromIdx(MakeGoods.MakeItem.ItemArr[0].wIdent, UserItem) then begin
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if boAutoMake and (nAutoMaxCount > 1) and (nMakeOKCount > 1) then begin
                UserItem.Dura := nMakeOKCount;
              end;
              if sm_ArmingStrong in StdItem.StdModeEx then begin
                if Random(g_Config.nNpcMakeRandomAddValue) = 0 then begin
                  SetByteStatus(UserItem.btBindMode2, Ib2_Unknown, True);
                  if g_Config.boNPCMakeRandomIsOpenShow then
                    ItemUnit.RandomUpgradeItem(UserItem, DefUnsealItem);
                end;
              end
              else
                UserItem.btBindMode1 := btBindMode1;

              if StdItem.NeedIdentify = 1 then
                AddGameLog(Self, LOG_ADDITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, sNPCName,
                  '0', '0', '打造', UserItem);
              m_ItemList.Add(UserItem);
              if StdItem.Rule.Rule[RULE_MAKE] then begin
                sSendMsg := '恭喜：[#6FFFF/8#6#7' + m_sCharName + '#7#5] 成功打造了一件 ';
                sSendMsg := sSendMsg + '{' + IntToStr(SetSayItem(UserItem)) + '/';
                sSendMsg := sSendMsg + IntToStr(UserItem.wIndex) + '/';
                sSendMsg := sSendMsg + IntToStr(UserItem.MakeIndex) + '}';
                UserEngine.SendBroadCastMsgDelay(sSendMsg, t_Hint, 2 * 1000);
              end;
              sSendMsg := MakeClientItem(UserItem);
              nBack := 8; //升级成功
            end
            else
              Dispose(UserItem);
          end
          else
            nBack := 11; //装备无变化
        end;
      finally
        for I := Low(UserItemLevelArr) to High(UserItemLevelArr) do begin
          if UserItemLevelArr[i] <> nil then
            m_ItemList.Add(UserItemLevelArr[i]);
          if UserItemAssArr[i] <> nil then
            m_ItemList.Add(UserItemAssArr[i]);
        end;
      end;
    end; // pGold <> nil
    if boAutoOK and boAutoMake and (nAutoMaxCount > 1) then begin
      if sSendMsg <> '' then begin
        m_DefMsg := MakeDefaultMsg(SM_MAKEDRUG_AUTO, m_nGold, LoWord(m_nBindGold), HiWord(m_nBindGold), nAutoMaxCount);
        SendSocket(@m_DefMsg, sSENDMSG);
      end
      else
        SendDefMessage(SM_MAKEDRUG_AUTO, m_nGold, LoWord(m_nBindGold), HiWord(m_nBindGold), nAutoMaxCount, '');
    end
    else begin
      if sSendMsg <> '' then begin
        m_DefMsg := MakeDefaultMsg(SM_MAKEDRUG, m_nGold, LoWord(m_nBindGold), HiWord(m_nBindGold), nBack);
        SendSocket(@m_DefMsg, sSENDMSG);
      end
      else
        SendDefMessage(SM_MAKEDRUG, m_nGold, LoWord(m_nBindGold), HiWord(m_nBindGold), nBack, '');
    end;
  except
    on E: Exception do begin
      MainOutMessage('[Exception] TPlayObject.MakeItem ' + m_sCharName + ' ' + IntToStr(nBack));
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TPlayObject.ClientMakeDrugItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  NPC: TNormNPC;
begin
  if ProcessMsg.nParam1 = -1 then begin
    if (ProcessMsg.nParam2 in [Low(g_MakeMagicList)..High(g_MakeMagicList)]) and (m_MakeMagic[ProcessMsg.nParam2] > 0) then begin
      if (ProcessMsg.wParam < g_MakeMagicList[ProcessMsg.nParam2].Count) and (ProcessMsg.sMsg <> '') then begin
        if m_MakeMagic[ProcessMsg.nParam2] >= pTMakeGoods(g_MakeMagicList[ProcessMsg.nParam2][ProcessMsg.wParam]).btLevel then begin
          if m_Abil.Level >= pTMakeGoods(g_MakeMagicList[ProcessMsg.nParam2][ProcessMsg.wParam]).wLevel then
            MakeItem(g_MakeMagicList[ProcessMsg.nParam2][ProcessMsg.wParam], ProcessMsg.sMsg, nil, ProcessMsg.nParam2, ProcessMsg.nParam3);
        end;
      end;
    end;
  end
  else begin
    NPC := TNormNPC(GetSelectNPC(Integer(m_ClickNPC)));
    if (NPC = nil) or (not (NPC is TMerchant)) or (not TMerchant(NPC).m_boMakeDrug) then
      exit;
    TMerchant(NPC).ClientMakeDrugItem(Self, ProcessMsg.wParam, ProcessMsg.nParam3, ProcessMsg.sMsg);
  end;
end;

procedure TPlayObject.ClientUnsealItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  NPC: TNormNPC;
begin
  NPC := TNormNPC(GetSelectNPC(Integer(m_ClickNPC)));
  if (NPC = nil) or (not (NPC is TMerchant)) or (not TMerchant(NPC).m_boArmUnseal) then
    exit;

  TMerchant(NPC).ClientUnsealItem(Self, MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3), DecodeString(ProcessMsg.sMsg));

end;

procedure TPlayObject.ClientClearMission(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if ProcessMsg.nParam1 in [Low(TMissionIndex)..High(TMissionIndex)] then begin
    if g_FunctionNPC <> nil then begin
      NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FClearMission[ProcessMsg.nParam1], False);
    end;
  end;
end;

procedure TPlayObject.ClientBagUseItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  nItemIndex, nStoneIndex: Integer;
  ItemUserItem, StoneUserItem, UserItem: pTUserItem;
  StoneStdItem, ItemStdItem, StdItem: pTStdItem;
  I, nStoneDelIndex: Integer;
  nBack: Word;
  sSendMsg: string;
begin
  nItemIndex := ProcessMsg.nParam1;
  nStoneIndex := MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3);
  nBack := 0;
  nStoneDelIndex := 0;
  sSendMsg := '';
  if (nItemIndex > 0) and (nStoneIndex > 0) then begin
    try
      ItemUserItem := nil;
      StoneUserItem := nil;
      ItemStdItem := nil;
      StoneStdItem := nil;
      try
        //获取背包中的物品
        for I := m_ItemList.Count - 1 downto 0 do begin
          UserItem := m_ItemList[i];
          if UserItem = nil then
            Continue;
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem = nil then
            Continue;
          if UserItem.MakeIndex = nItemIndex then begin
            if sm_ArmingStrong in StdItem.StdModeEx then begin
              ItemUserItem := UserItem;
              ItemStdItem := StdItem;
              if StoneUserItem <> nil then
                break;
            end
            else
              break;
          end
          else if UserItem.MakeIndex = nStoneIndex then begin
            if ((tm_MakeStone = StdItem.StdMode) and (StdItem.Shape = 3)) or (tm_ResetStone = StdItem.StdMode) then begin
              StoneUserItem := UserItem;
              StoneStdItem := StdItem;
              m_ItemList.Delete(I);
              if ItemUserItem <> nil then
                break;
            end
            else
              break;
          end;
        end;
        if (ItemUserItem <> nil) and (StoneUserItem <> nil) then begin
          if tm_ResetStone = StoneStdItem.StdMode then begin //重置装备属性
            if not CheckItemBindMode(ItemUserItem, bm_Unknown) then begin //已开光
              nBack := 1;
              ItemUnit.RandomUpgradeItem(itemUserItem, DefUnsealItem);
              if ItemStdItem.NeedIdentify = 1 then
                AddGameLog(Self, LOG_ITEMLEVEL, ItemStdItem.Name, ItemUserItem.MakeIndex, 0,
                  IntToStr(StoneUserItem.MakeIndex), '0', '0', '洗点', ItemUserItem);

              if (sm_Superposition in StoneStdItem.StdModeEx) and (StoneStdItem.DuraMax > 1) and (StoneUserItem.Dura > 1) then begin
                Dec(StoneUserItem.Dura);
                if StoneStdItem.NeedIdentify = 1 then
                  AddGameLog(Self, LOG_ITEMDURACHANGE, StoneStdItem.Name, StoneUserItem.MakeIndex,
                    StoneUserItem.Dura, IntToStr(ItemUserItem.MakeIndex), '-', '1', '属性', StoneUserItem);
              end
              else begin
                if StoneStdItem.NeedIdentify = 1 then
                  AddGameLog(Self, LOG_DELITEM, StoneStdItem.Name, StoneUserItem.MakeIndex, 0,
                    IntToStr(ItemUserItem.MakeIndex), '0', '0', '属性', StoneUserItem);
                Dispose(StoneUserItem);
                StoneUserItem := nil;
              end;
              sSendMsg := MakeClientItem(ItemUserItem);
            end;
          end
          else begin
            if (ItemUserItem.Value.btFluteCount in [1..3]) and
              (GetFluteCount(ItemUserItem) > 0) and
              (ItemUserItem.Value.StrengthenInfo.btStrengthenCount >= StoneStdItem.Need) then begin
              nBack := 1;
              for I := 0 to ItemUserItem.Value.btFluteCount - 1 do begin
                if (I in [0..MAXFLUTECOUNT - 1]) then begin
                  if ItemUserItem.Value.wFlute[I] = 0 then begin
                    ItemUserItem.Value.wFlute[I] := StoneUserItem.wIndex;
                    if ItemStdItem.NeedIdentify = 1 then
                      AddGameLog(Self, LOG_ITEMLEVEL, ItemStdItem.Name, ItemUserItem.MakeIndex, 0,
                        IntToStr(StoneUserItem.MakeIndex), '0', '0', '镶嵌', ItemUserItem);
                    break;
                  end;
                end;
              end;
              if (sm_Superposition in StoneStdItem.StdModeEx) and (StoneStdItem.DuraMax > 1) and (StoneUserItem.Dura > 1) then begin
                Dec(StoneUserItem.Dura);
                if StoneStdItem.NeedIdentify = 1 then
                  AddGameLog(Self, LOG_ITEMDURACHANGE, StoneStdItem.Name, StoneUserItem.MakeIndex,
                    StoneUserItem.Dura, IntToStr(ItemUserItem.MakeIndex), '-', '1', '镶嵌', StoneUserItem);
              end
              else begin
                if StoneStdItem.NeedIdentify = 1 then
                  AddGameLog(Self, LOG_DELITEM, StoneStdItem.Name, StoneUserItem.MakeIndex, 0,
                    IntToStr(ItemUserItem.MakeIndex), '0', '0', '镶嵌', StoneUserItem);
                Dispose(StoneUserItem);
                StoneUserItem := nil;
              end;
              sSendMsg := MakeClientItem(ItemUserItem);
            end;
          end;
        end;
        if sSendMsg <> '' then begin
          if StoneUserItem <> nil then
            m_DefMsg := MakeDefaultMsg(SM_BAGUSEITEM, StoneUserItem.Dura, LoWord(nStoneDelIndex), HiWord(nStoneDelIndex), nBack)
          else
            m_DefMsg := MakeDefaultMsg(SM_BAGUSEITEM, -1, LoWord(nStoneDelIndex), HiWord(nStoneDelIndex), nBack);
          SendSocket(@m_DefMsg, sSENDMSG);
        end
        else
          SendDefMessage(SM_BAGUSEITEM, -1, LoWord(nStoneDelIndex), HiWord(nStoneDelIndex), nBack, '');
      finally
        if StoneUserItem <> nil then
          m_ItemList.Add(StoneUserItem);
      end;
    except
      on E: Exception do begin
        MainOutMessage('[Exception] TPlayObject.ClientBagUseItem ' + m_sCharName);
        MainOutMessage(E.Message);
      end;
    end;
  end;
end;

procedure TPlayObject.ClientOpenGuildDlg(ProcessMsg: pTProcessMessage; var boResult: Boolean);
{var
  i: Integer;
  sSENDMSG: string;
  GUild: TGuild;   }
var
  Guild, Guild2: TGuild;
  ClientGuildInfo: TClientGuildInfo;
  sSENDMSG: string;
  boAllRead: Boolean;
  I: Integer;
  GuildIndex: Word;
  InfoIndex: Word;
begin
  if m_MyGuild = nil then begin
    SendDefMessage(SM_OPENGUILDDLG_FAIL, 0, 0, 0, 0, '');
    exit;
  end;
  Guild := TGuild(m_MyGuild);

  GuildIndex := LoWord(ProcessMsg.nParam1);
  InfoIndex := HiWord(ProcessMsg.nParam1);
  boAllRead := GuildIndex <> Guild.m_GuildIndex;
  sSENDMSG := '';
  if (InfoIndex <> Guild.m_UpInfoIndex) or boAllRead then begin
    Guild.m_boInfoRead := True;
    ClientGuildInfo.btMyRank := m_nGuildRankNo;
    ClientGuildInfo.sGuildName := Guild.m_sGuildName;
    ClientGuildInfo.btMaxMeberCount := Guild.m_btMaxMemberCount;
    ClientGuildInfo.sCreateName := Guild.m_sCreateGuildName;
    ClientGuildInfo.dwCreateTime := Guild.m_dwCreateGuildTime;
    ClientGuildInfo.btGuildLevel := Guild.btLevel;
    ClientGuildInfo.nGuildMoney := Guild.nMoneyCount;
    ClientGuildInfo.nBuildPoint := Guild.nBuildPoint;
    ClientGuildInfo.nFlourishingPoint := Guild.nFlourishingPoint; //繁荣度
    ClientGuildInfo.nStabilityPoint := Guild.nStabilityPoint; //安定度
    ClientGuildInfo.nActivityPoint := Guild.nActivityPoint; //人气度
    ClientGuildInfo.btKickMonExp := Guild.m_btKillMonExpRate;
    ClientGuildInfo.btKickMonAttack := Guild.m_btKillMonAttackRate;
    ClientGuildInfo.nMaxActivityPoint := Guild.nMaxActivityPoint;
    if (Guild.btLevel < MAXGUILDLEVEL) then begin
      ClientGuildInfo.nLevelGuildMoney := g_Config.GuildLevelExp[Guild.btLevel + 1].nGold;
      ClientGuildInfo.nLevelBuildPoint := g_Config.GuildLevelExp[Guild.btLevel + 1].nBuildPoint;
      ClientGuildInfo.nLevelFlourishingPoint := g_Config.GuildLevelExp[Guild.btLevel + 1].nFlourishingPoint; //繁荣度
      ClientGuildInfo.nLevelStabilityPoint := g_Config.GuildLevelExp[Guild.btLevel + 1].nStabilityPoint; //安定度
      ClientGuildInfo.nLevelActivityPoint := g_Config.GuildLevelExp[Guild.btLevel + 1].nActivityPoint; //人气度
    end
    else begin
      ClientGuildInfo.nLevelGuildMoney := 99999999;
      ClientGuildInfo.nLevelBuildPoint := 99999999;
      ClientGuildInfo.nLevelFlourishingPoint := 99999999; //繁荣度
      ClientGuildInfo.nLevelStabilityPoint := 99999999; //安定度
      ClientGuildInfo.nLevelActivityPoint := 65535; //人气度
    end;

    sSendMsg := EncodeBuffer(@ClientGuildInfo, SizeOf(ClientGuildInfo));
  end;
  m_DefMsg := MakeDefaultMsg(SM_OPENGUILDDLG, Guild.m_GuildIndex, Guild.m_UpInfoIndex, 0, 1);
  SendSocket(@m_DefMsg, sSENDMSG);

  if (ProcessMsg.nParam2 <> Guild.m_UpNoticeIndex) or boAllRead then begin
    sSENDMSG := '';
    for i := 0 to Guild.m_NoticeList.Count - 1 do begin
      if Length(sSENDMSG) > 3000 then
        break;
      sSENDMSG := sSENDMSG + Guild.m_NoticeList[i] + #13;
    end;
    m_DefMsg := MakeDefaultMsg(SM_OPENGUILDDLG, Guild.m_GuildIndex, Guild.m_UpNoticeIndex, 0, 2);
    SendSocket(@m_DefMsg, EncodeString(sSENDMSG));
  end;

  if (ProcessMsg.nParam3 <> Guild.m_UpMemberIndex) or boAllRead then begin
    ClientGuildMemberList(ProcessMsg, boResult);
  end;

  if (ProcessMsg.wParam <> Guild.m_UpSocietyIndex) or boAllRead then begin
    sSENDMSG := '#1/';
    for i := 0 to Guild.m_GuildAllList.Count - 1 do begin
      if Length(sSENDMSG) > 3000 then
        break;
      Guild2 := TGuild(Guild.m_GuildAllList.Objects[i]);
      if Guild2 <> nil then begin
        sSENDMSG := sSENDMSG + Guild.m_GuildAllList[i] + '/' + Guild2.GetChiefName + '/' + IntToStr(Guild2.btLevel) + '/';
      end;
    end;
    sSENDMSG := sSENDMSG + '#2/';
    for i := 0 to Guild.m_GuildWarList.Count - 1 do begin
      if Length(sSENDMSG) > 3000 then
        break;
      Guild2 := TGuild(pTWarGuild(Guild.m_GuildWarList.Objects[i]).Guild);
      if Guild2 <> nil then begin
        sSENDMSG := sSENDMSG + Guild.m_GuildWarList[i] + '/' + Guild2.GetChiefName + '/' + IntToStr(Guild2.btLevel) + '/';
      end;
    end;
    m_DefMsg := MakeDefaultMsg(SM_OPENGUILDDLG, Guild.m_GuildIndex, Guild.m_UpSocietyIndex, 0, 3);
    SendSocket(@m_DefMsg, EncodeString(sSENDMSG));
  end;
end;

procedure TPlayObject.ClientGuildHome(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  ClientOpenGuildDlg(ProcessMsg, boResult);
end;

procedure TPlayObject.ClientGuildMemberList(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  GuildRank: pTGuildRank;
  GuildUserInfo: pTGuildUserInfo;
  i, ii: Integer;
  sSENDMSG: string;
  Guild: TGuild;
  dwTime: TDateTime;
  boCheck: Boolean;
begin
  if m_MyGuild <> nil then begin
    Guild := TGuild(m_MyGuild);
    sSENDMSG := '';
    dwTime := Now;
    boCheck := False;
    for i := 0 to Guild.m_RankList.Count - 1 do begin
      GuildRank := Guild.m_RankList.Items[i];
      if GuildRank = nil then
        Continue;
      sSENDMSG := sSENDMSG + EncodeString('#' + IntToStr(GuildRank.nRankNo) + '/' + GuildRank.sRankName) + '/';
      for ii := 0 to GuildRank.MembersList.Count - 1 do begin
        GuildUserInfo := pTGuildUserInfo(GuildRank.MembersList.Objects[ii]);
        if GuildUserInfo.PlayObject <> nil then begin
          if not boCheck then begin
            if CompareText(GuildRank.MembersList[ii], m_sCharName) = 0 then begin
              GuildUserInfo.MemberIndex := Guild.m_UpMemberIndex;
              boCheck := True;
            end;
          end;
          sSENDMSG := sSENDMSG + EncodeString('-1/' + GuildRank.MembersList[ii]) + '/';
        end
        else begin
          sSENDMSG := sSENDMSG +
            EncodeString(IntToStr(DaysBetween(GuildUserInfo.LoginTime, dwTime)) + '/' + GuildRank.MembersList[ii]) + '/';
        end;
      end;
    end;
    m_DefMsg := MakeDefaultMsg(SM_SENDGUILDMEMBERLIST, Guild.m_GuildIndex, Guild.m_UpMemberIndex, 0, 0);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;
end;

procedure TPlayObject.GuildAddMember(PlayObject: TPlayObject);
begin
  if m_MyGuild = nil then
    exit;
  if PlayObject.m_MyGuild <> nil then
    exit;
  if TGuild(m_MyGuild).IsFull then begin
    PlayObject.SysMsg('行会成员数量已满. ', c_red, t_Hint);
    exit;
  end;
  TGuild(m_MyGuild).AddMember(PlayObject);
  PlayObject.m_MyGuild := m_MyGuild;
  PlayObject.m_sGuildName := TGuild(m_MyGuild).m_sGuildName;
  PlayObject.m_boAddStabilityPoint := True;
  TGuild(m_MyGuild).MemberLogin(PlayObject);
  PlayObject.RefShowName();
  SysMsg('[#7' + PlayObject.m_sCharName + '#7] 加入行会', c_red, t_hint);
  PlayObject.SysMsg('成功加入行会: ' + TGuild(m_MyGuild).m_sGuildName, c_red, t_hint);
  //PlayObject.SysMsg('成功加入行会: ' + TGUild(m_MyGuild).sGuildName, c_Red, t_Hint);
end;

procedure TPlayObject.ClientGuildAddMember(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  nC: Integer;
  PlayObject: TPlayObject;
begin

  if m_MyGuild = nil then
    exit;
  nC := 1; //'你没有权利使用这个命令。'
  if m_nGuildRankNo in [1..3] then begin
    PlayObject := UserEngine.GetPlayObject(ProcessMsg.sMsg);
    if (PlayObject <> nil) and (PlayObject <> Self) and (not PlayObject.m_boGhost) then begin
      if PlayObject.m_MyGuild = nil then begin
        if PlayObject.m_boAllowGuild and (not PlayObject.m_boSafeOffLine) then begin
          if not TGuild(m_MyGuild).IsFull then begin
            if PlayObject.AddCheckMsg(Format(g_sGuildCheckMsg, [m_sCharName, TGuild(m_MyGuild).m_sGuildName]), tmc_Guild, Self, 62) <> nil then begin
              nC := -1;
              //SysMsg(g_sGuildIsCheckMsg, c_red,  t_Hint);
            end
            else
              nC := -2;
            //SysMsg(g_sGuildIsCheckMsgNot, c_red,  t_Hint);
          //exit;
          end
          else
            nC := 5; //行会成员已满
        end
        else
          nC := 4; //拒绝加入行会

      end
      else
        nC := 3; //已加入行会
    end
    else
      nC := 2; //没有在线
  end;
  SendDefMessage(SM_GUILDADDMEMBER_FAIL, nC, 0, 0, 0, '');
end;

procedure TPlayObject.ClientGuildDelMember(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  nC: Integer;
  //  s14: string;
  PlayObject: TPlayObject;
  sHumName: string;
begin
  nC := 1;
  sHumName := ProcessMsg.sMsg;
  if IsGuildMaster then begin
    if TGuild(m_MyGuild).IsMember(sHumName) then begin
      if CompareText(m_sCharName, sHumName) <> 0 then begin
        if TGuild(m_MyGuild).DelMember(sHumName, m_nGuildRankNo) then begin
          PlayObject := UserEngine.GetPlayObject(sHumName);
          if PlayObject <> nil then begin
            PlayObject.m_MyGuild := nil;
            PlayObject.m_sGuildName := '';
            PlayObject.RefRankInfo(0, '');
            PlayObject.RefShowName(); //10/31
          end;
          nC := 0;
        end
        else
          nC := 4;
      end
      else begin
        nC := 3;
      end;
    end
    else
      nC := 2;
  end;
  if nC = 0 then begin
    //SendDefMessage(SM_GUILDDELMEMBER_OK, 0, 0, 0, 0, '');
  end
  else begin
    SendDefMessage(SM_GUILDDELMEMBER_FAIL, nC, 0, 0, 0, '');
  end;
end;

procedure TPlayObject.ClientGuildUpdateNotice(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  SC: string;
  sNotict: string;
begin
  if Length(sNotict) > 2000 then
    sNotict := TrimRight(Copy(sNotict, 1, 2000));

  sNotict := ProcessMsg.sMsg;
  if (m_MyGuild = nil) or (m_nGuildRankNo <> 1) then
    Exit;
  TGUild(m_MyGuild).m_NoticeList.Clear;
  while (sNotict <> '') do begin
    sNotict := GetValidStr3(sNotict, SC, [#$D]);
    TGUild(m_MyGuild).m_NoticeList.Add(SC);
  end; // while
  TGUild(m_MyGuild).UpdateGuildFile;
  TGUild(m_MyGuild).IncNoticeIndex;
  //ClientOpenGuildDlg(ProcessMsg, boResult);
end;

procedure TPlayObject.ClientGuildUpdateRankInfo(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  nC: Integer;
  sRankInfo: string;
begin
  sRankInfo := ProcessMsg.sMsg;
  if (m_MyGuild = nil) or (m_nGuildRankNo <> 1) then
    Exit;
  nC := TGUild(m_MyGuild).UpdateRank(sRankInfo);
  if nC = 0 then begin
    ClientGuildMemberList(ProcessMsg, boResult);
  end
  else begin
    SendDefMessage(SM_GUILDRANKUPDATE_FAIL, nC, 0, 0, 0, '');
  end;
end;

procedure TPlayObject.ClientGuildAlly(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  n8: Integer;
  BaseObjectC: TBaseObject;
  sSENDMSG: string;
  Guild, Guild2: TGuild;
  i: integer;
  Castle: TUserCastle;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::ClientGuildAlly';
begin
  try
    n8 := -1;
    BaseObjectC := GetPoseCreate();
    if (BaseObjectC <> nil) and
      (BaseObjectC.m_MyGuild <> nil) and
      (BaseObjectC.m_btRaceServer = RC_PLAYOBJECT) and
      (BaseObjectC.GetPoseCreate = Self) then begin
      if (TGuild(BaseObjectC.m_MyGuild) <> nil) and
        (TGuild(BaseObjectC.m_MyGuild).m_boEnableAuthAlly) then begin
        if BaseObjectC.IsGuildMaster and IsGuildMaster then begin
          if (TGuild(m_MyGuild) <> nil) and
            TGuild(m_MyGuild).IsNotWar(TGuild(BaseObjectC.m_MyGuild)) and
            TGuild(BaseObjectC.m_MyGuild).IsNotWar(TGuild(m_MyGuild)) then begin

            Castle := g_CastleManager.IsCastleMember(Self);
            if (Castle <> nil) then begin
              if (Castle.m_boUnderWar and Castle.IsAttackGuild(TGuild(BaseObjectC.m_MyGuild))) or
                Castle.InAttackerList(TGuild(BaseObjectC.m_MyGuild)) then begin
                SendDefMessage(SM_GUILDMAKEALLY_FAIL, -5, 0, 0, 0, '');
                exit;
              end;
            end;
            Castle := g_CastleManager.IsCastleMember(BaseObjectC);
            if (Castle <> nil) then begin
              if (Castle.m_boUnderWar and Castle.IsAttackGuild(TGuild(m_MyGuild))) or
                Castle.InAttackerList(TGuild(m_MyGuild)) then begin
                SendDefMessage(SM_GUILDMAKEALLY_FAIL, -5, 0, 0, 0, '');
                exit;
              end;
            end;
            TGuild(m_MyGuild).AllyGuild(TGuild(BaseObjectC.m_MyGuild));
            TGuild(BaseObjectC.m_MyGuild).AllyGuild(TGuild(m_MyGuild));
            TGuild(m_MyGuild).SendGuildMsg(TGuild(BaseObjectC.m_MyGuild).m_sGuildName +
              '行会已经和您的行会联盟成功。');
            TGuild(BaseObjectC.m_MyGuild).SendGuildMsg(TGuild(m_MyGuild).m_sGuildName +
              '行会已经和您的行会联盟成功。');
            TGuild(m_MyGuild).RefMemberName;
            TGuild(BaseObjectC.m_MyGuild).RefMemberName;
            n8 := 0;

            Guild := TGuild(m_MyGuild);
            sSENDMSG := '#1/';
            for i := 0 to Guild.m_GuildAllList.Count - 1 do begin
              if Length(sSENDMSG) > 3000 then
                break;
              Guild2 := TGuild(Guild.m_GuildAllList.Objects[i]);
              if Guild2 <> nil then begin
                sSENDMSG := sSENDMSG + Guild.m_GuildAllList[i] + '/' + Guild2.GetChiefName + '/' +
                  IntToStr(Guild2.btLevel) + '/';
              end;
            end;
            sSENDMSG := sSENDMSG + '#2/';
            for i := 0 to Guild.m_GuildWarList.Count - 1 do begin
              if Length(sSENDMSG) > 3000 then
                break;
              Guild2 := TGuild(pTWarGuild(Guild.m_GuildWarList.Objects[i]).Guild);
              if Guild2 <> nil then begin
                sSENDMSG := sSENDMSG + Guild.m_GuildWarList[i] + '/' + Guild2.GetChiefName + '/' +
                  IntToStr(Guild2.btLevel) + '/';
              end;
            end;
            m_DefMsg := MakeDefaultMsg(SM_OPENGUILDDLG, Guild.m_GuildIndex, Guild.m_UpSocietyIndex, 0, 3);
            SendSocket(@m_DefMsg, EncodeString(sSENDMSG));
          end
          else
            n8 := -2;
        end
        else
          n8 := -3;
      end
      else
        n8 := -4;
    end;
    if n8 = 0 then begin
      //SendDefMessage(SM_GUILDMAKEALLY_OK, 0, 0, 0, 0, '');
    end
    else begin
      SendDefMessage(SM_GUILDMAKEALLY_FAIL, n8, 0, 0, 0, '');
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TPlayObject.CheckShopingClose();
var
  I: Integer;
  UserShopSellItem: pTUserShopSellItem;
begin
  if (m_ShopBuyItemList.Count <= 0) and (m_ShopSellItemList.Count <= 0) and m_boShoping then begin
    IntegerChange(m_nGold, m_nShopGold, INT_ADD);
    IntegerChange(m_nGameGold, m_nShopGameGold, INT_ADD);
    m_nShopGold := 0;
    m_nShopGameGold := 0;

    for I := 0 to m_ShopBuyItemList.Count - 1 do begin
      Dispose(pTUserShopBuyItem(m_ShopBuyItemList[i]));
    end;
    m_ShopBuyItemList.Clear;

    for I := 0 to m_ShopSellItemList.Count - 1 do begin
      UserShopSellItem := m_ShopSellItemList[i];
      m_ItemList.Add(UserShopSellItem.UserItem);
      Dispose(UserShopSellItem);
    end;
    m_ShopSellItemList.Clear;

    RecalcBagCount;
    m_boShoping := False;
    SendRefMsg(RM_USEROPENSHOP, 0, Integer(Self), 0, 0, '');
    SendDefMessage(SM_USERSHOPCHANGE, m_nGold, LoWord(m_nGameGold), HiWord(m_nGameGold), 0, '');
  end;

end;

procedure TPlayObject.ClientUserShop(ProcessMsg: pTProcessMessage; var boResult: Boolean);
resourcestring
  sExceptionMsg = '[Exception] TPlayObject.ClientUserShop';
var
  nBack: Integer;
  sMsg, sTitle: string;
  ServerMyShopItem: TServerMyShopItem;
  Stditem: pTStdItem;
  wIdent, wCount: Word;
  UserItem: pTUserItem;
  UserShopSellItem: pTUserShopSellItem;
  UserShopBuyItem: pTUserShopBuyItem;
  nMaxGold, nMaxGamePoint: Int64;
  nOldMaxGold, nOldMaxGamePoint: Integer;
  i: integer;
begin
  try
    nBack := -1;
    nMaxGold := 0;
    nMaxGamePoint := 0;
    nOldMaxGold := 0;
    nOldMaxGamePoint := 0;
    if not m_boShoping then begin
      if not InSafeZone then begin
        SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, '只能在安全区内进行摆摊操作！');
        SendDefMessage(SM_USERSHOPCHANGE, m_nGold, LoWord(m_nGameGold), HiWord(m_nGameGold), 0, '');
        Exit;
      end;
      if g_Config.boDisableDeal or Self.m_PEnvir.m_boNODEAL then begin
        SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, g_sDisableDealItemsMsg);
        Exit;
      end;
      if not m_PEnvir.m_boShop then begin
        SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, '当前地图不允许进行摆摊操作！');
        SendDefMessage(SM_USERSHOPCHANGE, m_nGold, LoWord(m_nGameGold), HiWord(m_nGameGold), 0, '');
        Exit;
      end;
      sMsg := ProcessMsg.sMsg;
      sMsg := GetValidStr3(sMsg, sTitle, ['/']);
      if (sTitle <> '') and (sMsg <> '') then begin
        m_sShopTitle := DecodeString(sTitle);
        if m_sShopTitle <> '' then begin
          if CheckFilterShop(m_sShopTitle) then begin
            SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, '摊位标题包含禁止使用字符！');
            SendDefMessage(SM_USERSHOPCHANGE, m_nGold, LoWord(m_nGameGold), HiWord(m_nGameGold), 0, '');
            Exit;
          end;
          while True do begin
            if sMsg = '' then
              break;
            sMsg := GetValidStr3(sMsg, sTitle, ['/']);
            if sTitle = '' then
              break;
            SafeFillChar(ServerMyShopItem, SizeOf(ServerMyShopItem), #0);
            DecodeBuffer(sTitle, @ServerMyShopItem, SizeOf(ServerMyShopItem));
            if (ServerMyShopItem.nMoney > 0) and (ServerMyShopItem.nMoney <= 50000000) then begin
              if ServerMyShopItem.boBuy then begin
                if m_ShopBuyItemList.Count >= MAXSHOPITEMS then
                  Continue;
                //if m_ShopBuyItemList.Count >= (m_nMaxItemListCount - m_ItemList.Count) then Continue;
                wIdent := LoWord(ServerMyShopItem.nItemIndex);
                wCount := HiWord(ServerMyShopItem.nItemIndex);
                StdItem := UserEngine.GetStdItem(wIdent);
                if (StdItem <> nil) and (wCount > 0) then begin
                  if (sm_Superposition in StdItem.StdModeEx) and (Stditem.DuraMax > 1) then begin
                    if wCount > Stditem.DuraMax then
                      wCount := StdItem.DuraMax;
                  end
                  else
                    wCount := 1;

                  if ServerMyShopItem.boGameGold then begin
                    nMaxGamePoint := nMaxGamePoint + Int64(ServerMyShopItem.nMoney) * Int64(wCount);
                    if nMaxGamePoint > m_nGameGold then begin
                      nMaxGamePoint := nOldMaxGamePoint;
                      Continue;
                    end
                    else
                      nOldMaxGamePoint := nMaxGamePoint;
                  end
                  else begin
                    nMaxGold := nMaxGold + Int64(ServerMyShopItem.nMoney) * Int64(wCount);
                    if nMaxGold > m_nGold then begin
                      nMaxGold := nOldMaxGold;
                      Continue;
                    end
                    else
                      nOldMaxGold := nMaxGold;
                  end;
                  New(UserShopBuyItem);
                  UserShopBuyItem.btIdx := ServerMyShopItem.btIdx;
                  UserShopBuyItem.nMoney := ServerMyShopItem.nMoney;
                  UserShopBuyItem.boGameGold := ServerMyShopItem.boGameGold;
                  UserShopBuyItem.wIdent := wIdent;
                  UserShopBuyItem.wCount := wCount;
                  m_ShopBuyItemList.Add(UserShopBuyItem);
                  nBack := 1;
                end;
              end
              else begin
                if m_ShopSellItemList.Count >= MAXSHOPITEMS then
                  Continue;
                UserItem := GetBagitem(ServerMyShopItem.nItemIndex, True);
                if UserItem <> nil then begin
                  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
                  if StdItem <> nil then begin
                    //禁止交易物品不允许摆摊
                    if CheckItemBindMode(UserItem, bm_NoDeal) then begin
                      m_ItemList.Add(UserItem);
                      Continue;
                    end;
                    New(UserShopSellItem);
                    UserShopSellItem.btIdx := ServerMyShopItem.btIdx;
                    UserShopSellItem.nMoney := ServerMyShopItem.nMoney;
                    UserShopSellItem.boGameGold := ServerMyShopItem.boGameGold;
                    UserShopSellItem.UserItem := UserItem;
                    m_ShopSellItemList.Add(UserShopSellItem);
                    nBack := 1;
                  end
                  else
                    Dispose(UserItem);
                end;
              end;
            end;
          end;
          if nBack = 1 then begin
            IntegerChange(m_nGold, nOldMaxGold, INT_DEL);
            IntegerChange(m_nGameGold, nOldMaxGamePoint, INT_DEL);
            IntegerChange(m_nShopGold, nOldMaxGold, INT_ADD);
            IntegerChange(m_nShopGameGold, nOldMaxGamePoint, INT_ADD);
            m_boShoping := True;
            m_btShopLevel := Random(3);
            m_boShopLeft := False;
            //if m_boShopLeft then
              //m_btDirection := 1
            //else
            m_btDirection := 5;
            RecalcBagCount;
            SendDefMessage(SM_USERSHOPCHANGE, m_nGold, LoWord(m_nGameGold), HiWord(m_nGameGold),
              MakeWord(m_btShopLevel + 1, Integer(m_boShopLeft)), '');
            SendDefMessage(SM_USERSHOPGOLDCHANGE, m_nShopGold, LoWord(m_nShopGameGold), HiWord(m_nShopGameGold), 0,
              '');
            SendRefMsg(RM_USEROPENSHOP, 1, Integer(Self), MakeWord(m_btShopLevel + 1, Integer(m_boShopLeft)), 0,
              EncodeString(m_sShopTitle));
            exit;
          end;
        end;
      end;
    end
    else begin
      nBack := 0;
      IntegerChange(m_nGold, m_nShopGold, INT_ADD);
      IntegerChange(m_nGameGold, m_nShopGameGold, INT_ADD);
      m_nShopGold := 0;
      m_nShopGameGold := 0;

      for I := 0 to m_ShopBuyItemList.Count - 1 do begin
        Dispose(pTUserShopBuyItem(m_ShopBuyItemList[i]));
      end;
      m_ShopBuyItemList.Clear;

      for I := 0 to m_ShopSellItemList.Count - 1 do begin
        UserShopSellItem := m_ShopSellItemList[i];
        m_ItemList.Add(UserShopSellItem.UserItem);
        Dispose(UserShopSellItem);
      end;
      m_ShopSellItemList.Clear;

      RecalcBagCount;
      m_boShoping := False;
      SendRefMsg(RM_USEROPENSHOP, 0, Integer(Self), 0, 0, '');
    end;
    SendDefMessage(SM_USERSHOPCHANGE, m_nGold, LoWord(m_nGameGold), HiWord(m_nGameGold), nBack, '');
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TPlayObject.ClientUserShopSay(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  PlayObject: TPlayObject;
begin
  if GetTickCount < m_ShopSayTick then
    exit;
  if GetCodeMsgSize(70 * 4 / 3) < length(Processmsg.sMsg) then
    exit;
  m_ShopSayTick := GetTickCount + 2000;
  if not CretInNearXY(TBaseObject(ProcessMsg.nParam1), ProcessMsg.nParam2, ProcessMsg.nParam3) then
    Exit;
  if TBaseObject(ProcessMsg.nParam1).m_btRaceServer <> RC_PLAYOBJECT then
    exit;
  PlayObject := TPlayObject(ProcessMsg.nParam1);
  if (PlayObject.m_PEnvir = m_PEnvir) and PlayObject.m_boShoping and
    (abs(PlayObject.m_nCurrX - m_nCurrX) <= m_nViewRange) and (abs(PlayObject.m_nCurrY - m_nCurrY) <= m_nViewRange) then begin
    PlayObject.SendDefSocket(Self, SM_USERSHOPSAY, 0, 0, 0, 0, EncodeString(m_sCharName) + '/' + Processmsg.sMsg);
  end;
end;

procedure TPlayObject.ServerGetLargessGold(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  sGold, sNPCName: string;
  nGold: Integer;
begin
  sNPCName := GetValidStr3(ProcessMsg.sMsg, sGold, ['/']);
  nGold := StrToIntDef(sGold, 0);
  if nGold > 0 then begin
    IncGameGold(nGold);
    if g_boGameLogGameGold then begin
      AddGameLog(Self, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, m_nGameGold, sNPCName,
        '+', IntToStr(nGold), '充值领取', nil);
    end;
    GameGoldChanged;
    NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NGETLARGESSGOLD_OK], False);
    SendDefMsg(g_FunctionNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, '[领取成功]：恭喜您，成功领取了 ' + IntToStr(nGold) +
      sSTRING_GAMEGOLD);
  end
  else
    NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NGETLARGESSGOLD_FAIL], False);
end;

procedure TPlayObject.ServerOffLineShop(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  sSendMsg: string;
  ClientMyShopSellItem: TClientMyShopSellItem;
  ClientMyShopBuyItem: TClientMyShopBuyItem;
  UserShopSellItem: pTUserShopSellItem;
  UserShopBuyItem: pTUserShopBuyItem;
  i: integer;
begin
  if m_boShoping then begin
    sSendMsg := EncodeString(m_sShopTitle) + '/';
    for I := 0 to m_ShopSellItemList.Count - 1 do begin
      UserShopSellItem := m_ShopSellItemList[i];
      ClientMyShopSellItem.btIdx := UserShopSellItem.btIdx;
      ClientMyShopSellItem.nMoney := UserShopSellItem.nMoney;
      ClientMyShopSellItem.boGameGold := UserShopSellItem.boGameGold;
      ClientMyShopSellItem.UserItem := UserShopSellItem.UserItem^;
      sSendMsg := sSendMsg + EncodeBuffer(@ClientMyShopSellItem, SizeOf(ClientMyShopSellItem)) + '/';
    end;
    for I := 0 to m_ShopBuyItemList.Count - 1 do begin
      UserShopBuyItem := m_ShopBuyItemList[i];
      ClientMyShopBuyItem.btIdx := UserShopBuyItem.btIdx;
      ClientMyShopBuyItem.nMoney := UserShopBuyItem.nMoney;
      ClientMyShopBuyItem.boGameGold := UserShopBuyItem.boGameGold;
      ClientMyShopBuyItem.wIdent := UserShopBuyItem.wIdent;
      ClientMyShopBuyItem.wCount := UserShopBuyItem.wCount;
      sSendMsg := sSendMsg + EncodeBuffer(@ClientMyShopBuyItem, SizeOf(ClientMyShopBuyItem)) + '/';
    end;
    m_DefMsg := MakeDefaultMsg(SM_GETUSERSHOPLIST_OFFLINE, m_nShopGameGold, LoWord(m_nShopGold),
      HiWord(m_nShopGold), MakeWord(m_btShopLevel + 1, Integer(m_boShopLeft)));
    SendSocket(@m_DefMsg, sSendMsg);
  end;
end;

procedure TPlayObject.ClientClickUserShop(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  PlayObject: TPlayObject;
  sSendMsg: string;
  ClientMyShopSellItem: TClientMyShopSellItem;
  ClientMyShopBuyItem: TClientMyShopBuyItem;
  UserShopSellItem: pTUserShopSellItem;
  UserShopBuyItem: pTUserShopBuyItem;
  i, nCount: integer;
begin
  if not CretInNearXY(TBaseObject(ProcessMsg.nParam1), ProcessMsg.nParam2, ProcessMsg.nParam3) then
    Exit;
  if TBaseObject(ProcessMsg.nParam1).m_btRaceServer <> RC_PLAYOBJECT then
    exit;
  PlayObject := TPlayObject(ProcessMsg.nParam1);
  if (PlayObject.m_PEnvir = m_PEnvir) and PlayObject.m_boShoping and
    (abs(PlayObject.m_nCurrX - m_nCurrX) <= m_nViewRange) and (abs(PlayObject.m_nCurrY - m_nCurrY) <= m_nViewRange) then begin
    sSendMsg := '';
    for I := 0 to PlayObject.m_ShopSellItemList.Count - 1 do begin
      UserShopSellItem := PlayObject.m_ShopSellItemList[i];
      ClientMyShopSellItem.btIdx := UserShopSellItem.btIdx;
      ClientMyShopSellItem.nMoney := UserShopSellItem.nMoney;
      ClientMyShopSellItem.boGameGold := UserShopSellItem.boGameGold;
      ClientMyShopSellItem.UserItem := UserShopSellItem.UserItem^;
      sSendMsg := sSendMsg + EncodeBuffer(@ClientMyShopSellItem, SizeOf(ClientMyShopSellItem)) + '/';
    end;
    nCount := PlayObject.m_nMaxItemListCount - PlayObject.m_ItemList.Count;
    for I := 0 to PlayObject.m_ShopBuyItemList.Count - 1 do begin
      if I >= nCount then
        Break;
      UserShopBuyItem := PlayObject.m_ShopBuyItemList[i];
      ClientMyShopBuyItem.btIdx := UserShopBuyItem.btIdx;
      ClientMyShopBuyItem.nMoney := UserShopBuyItem.nMoney;
      ClientMyShopBuyItem.boGameGold := UserShopBuyItem.boGameGold;
      ClientMyShopBuyItem.wIdent := UserShopBuyItem.wIdent;
      ClientMyShopBuyItem.wCount := UserShopBuyItem.wCount;
      sSendMsg := sSendMsg + EncodeBuffer(@ClientMyShopBuyItem, SizeOf(ClientMyShopBuyItem)) + '/';
    end;
    //if sSendMsg <> '' then begin //SM_GETUSERSHOPLIST
    m_DefMsg := MakeDefaultMsg(SM_GETUSERSHOPLIST, Integer(PlayObject), PlayObject.m_nCurrX, PlayObject.m_nCurrY, 0);
    SendSocket(@m_DefMsg, sSendMsg);
    //end;

  end;
end;

procedure TPlayObject.ClientBuyUserShop(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  PlayObject: TPlayObject;
  ItemIndex: Integer;
  i: integer;
  UserShopSellItem: pTUserShopSellItem;
  UserShopBuyItem: pTUserShopBuyItem;
  pGold, pPlayGold: pInteger;
  nId: Integer;
  StdItem: pTStdItem;
  nBack: Integer;
  nCount: Word;
  UserItem, UserItem32, AddUserItem: pTUserItem;
  boSuperposition: Boolean;
  nMoney, nMoneyEx: Int64;
  sCount: string;
  II: Integer;
begin
  try
    if ProcessMsg.sMsg = '' then
      exit;
    if not CretInNearXY(TBaseObject(ProcessMsg.nParam1), ProcessMsg.nParam2, ProcessMsg.nParam3) then
      Exit;
    if TBaseObject(ProcessMsg.nParam1).m_btRaceServer <> RC_PLAYOBJECT then
      exit;
    if g_Config.boDisableDeal or Self.m_PEnvir.m_boNODEAL then begin
      SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, g_sDisableDealItemsMsg);
      Exit;
    end;
    PlayObject := TPlayObject(ProcessMsg.nParam1);
    if (PlayObject.m_PEnvir = m_PEnvir) and PlayObject.m_boShoping and
      (abs(PlayObject.m_nCurrX - m_nCurrX) <= m_nViewRange) and (abs(PlayObject.m_nCurrY - m_nCurrY) <= m_nViewRange) then begin
      ItemIndex := 0;
      sCount := '';
      DecodeBuffer(ProcessMsg.sMsg, @ItemIndex, SizeOf(Integer));
      //购买
      if ItemIndex > 0 then begin
        //      nBack := 0;    //无效
        if ProcessMsg.wParam >= MAXSHOPITEMS then begin
          nBack := 1; //购买的物品不存在
          nCount := ProcessMsg.wParam - MAXSHOPITEMS;
          for I := PlayObject.m_ShopSellItemList.Count - 1 downto 0 do begin
            UserShopSellItem := PlayObject.m_ShopSellItemList[i];
            if UserShopSellItem.UserItem.MakeIndex = ItemIndex then begin
              StdItem := UserEngine.GetStdItem(UserShopSellItem.UserItem.wIndex);
              if Stditem <> nil then begin
                boSuperposition := False;
                if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
                  if nCount > UserShopSellItem.UserItem.Dura then
                    nCount := UserShopSellItem.UserItem.Dura;
                  if nCount <= 0 then
                    nCount := 1;
                  boSuperposition := True;
                end
                else
                  nCount := 1;
                if UserShopSellItem.boGameGold then begin
                  pGold := @m_nGameGold;
                  pPlayGold := @PlayObject.m_nShopGameGold;
                  nBack := 2; //元宝不够
                end
                else begin
                  pGold := @m_nGold;
                  pPlayGold := @PlayObject.m_nShopGold;
                  nBack := 3; //金币不够
                end;
                nMoney := Int64(UserShopSellItem.nMoney) * Int64(nCount);
                if (pGold^ > 0) and (pGold^ >= nMoney) then begin
                  New(UserItem);
                  UserItem^ := UserShopSellItem.UserItem^;
                  if boSuperposition then
                    UserItem.Dura := nCount;

                  nID := AddItemToBag(UserItem, StdItem, boSuperposition, PlayObject.m_sCharName, '摆摊', AddUserItem);
                  if nID <> -1 then begin

                    Dec(pGold^, Integer(nMoney));
                    nMoneyEx := nMoney;
                    if (nMoneyEx > 0) and (g_Config.nPersonShopSellRate in [1 .. 99]) then
                      nMoneyEx := _MAX(Round(nMoneyEx * (100 - g_Config.nPersonShopSellRate) / 100), 1);
                    IntegerChange(pPlayGold^, nMoneyEx, INT_ADD);
                    if (not boSuperposition) or (nCount >= UserShopSellItem.UserItem.Dura) then begin
                      boSuperposition := False;
                      if Stditem.NeedIdentify = 1 then
                        AddGameLog(PlayObject, LOG_DELITEM, StdItem.Name, UserShopSellItem.UserItem.MakeIndex, 0,
                          m_sCharName, '0', '0', '摆摊', UserShopSellItem.UserItem);
                      PlayObject.SendDefMsg(PlayObject, SM_USERSHOPITEMCHANGE, UserShopSellItem.UserItem.MakeIndex,
                        0, nCount, 1, m_sCharname);
                      PlayObject.m_ShopSellItemList.Delete(I);
                      Dispose(UserShopSellItem.UserItem);
                      Dispose(UserShopSellItem);
                    end
                    else begin
                      boSuperposition := True;

                      Dec(UserShopSellItem.UserItem.Dura, nCount);
                      if Stditem.NeedIdentify = 1 then
                        AddGameLog(PlayObject, LOG_ITEMDURACHANGE, StdItem.Name, UserShopSellItem.UserItem.MakeIndex,
                          UserShopSellItem.UserItem.Dura, m_sCharName,
                          '-', IntToStr(nCount), '摆摊', UserShopSellItem.UserItem);

                      PlayObject.SendDefMsg(PlayObject, SM_USERSHOPITEMCHANGE, UserShopSellItem.UserItem.MakeIndex,
                        UserShopSellItem.UserItem.Dura, nCount, 1, m_sCharname);
                    end;

                    if nID = 2 then begin
                      if boSuperposition then begin //购买叠加物品重新取ID
                        UserItem.MakeIndex := GetItemNumber();
                        sCount := IntToStr(UserItem.MakeIndex) + '/' + IntToStr(nCount);
                      end;
                      if Stditem.NeedIdentify = 1 then begin
                        AddGameLog(Self, LOG_ADDITEM, StdItem.Name, UserItem.MakeIndex,
                          nCount, PlayObject.m_sCharName, '0', '0', '摆摊', UserItem);
                      end;
                    end
                    else begin
                      sCount := '0/' + IntToStr(nCount);
                      Dispose(UserItem);
                      //Useritem.MakeIndex := 0;
                    end;

                    if UserShopSellItem.boGameGold then begin
                      if g_boGameLogGameGold then begin
                        AddGameLog(Self, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, m_nGameGold,
                          PlayObject.m_sCharName, '-', IntToStr(nMoney), '摆摊', nil);
                        AddGameLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, PlayObject.m_nGameGold +
                          PlayObject.m_nShopGameGold, m_sCharName, '+', IntToStr(nMoneyEx), '摆摊', nil);
                      end;
                    end
                    else begin
                      if g_boGameLogGold then begin
                        AddGameLog(Self, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, m_nGold, PlayObject.m_sCharName,
                          '-', IntToStr(nMoney), '摆摊', nil);
                        AddGameLog(PlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayObject.m_nGold +
                          PlayObject.m_nShopGold,
                          m_sCharName, '+', IntToStr(nMoneyEx), '摆摊', nil);
                      end;
                    end;
                    PlayObject.SendDefMsg(PlayObject, SM_USERSHOPGOLDCHANGE, PlayObject.m_nShopGold,
                      LoWord(PlayObject.m_nShopGameGold), HiWord(PlayObject.m_nShopGameGold), 0, '');
                    nBack := 5; //购买成功
                    PlayObject.m_dwSaveRcdTick := 0; //Jason 新增交易完成立既保存数据
                    m_dwSaveRcdTick := 0; //Jason 新增交易完成立既保存数据
                  end
                  else begin
                    nBack := 4; //背包空间已满
                    Dispose(UserItem);
                  end;
                end;
              end;
              break;
            end;
          end;
        end
        else begin //出售
          nBack := 11;
          for i := PlayObject.m_ShopBuyItemList.Count - 1 downto 0 do begin
            UserShopBuyItem := PlayObject.m_ShopBuyItemList[i];
            if UserShopBuyItem.btIdx = ProcessMsg.wParam then begin
              StdItem := UserEngine.GetStdItem(UserShopBuyItem.wIdent);
              if StdItem = nil then
                break;
              for II := m_ItemList.Count - 1 downto 0 do begin
                UserItem := m_ItemList[ii];
                if UserItem.MakeIndex = ItemIndex then begin
                  if (UserItem.wIndex <> UserShopBuyItem.wIdent) then
                    break;
                  if CheckItemBindMode(UserItem, bm_NoDeal) then
                    break;
                  boSuperposition := False;
                  if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
                    if UserItem.Dura > UserShopBuyItem.wCount then
                      nCount := UserShopBuyItem.wCount
                    else
                      nCount := UserItem.Dura;
                    boSuperposition := True;
                  end
                  else
                    nCount := 1;
                  nMoney := Int64(UserShopBuyItem.nMoney) * Int64(nCount);
                  if UserShopBuyItem.boGameGold then begin
                    pGold := @PlayObject.m_nShopGameGold;
                    pPlayGold := @m_nGameGold;
                    nBack := 12; //点卷不够
                  end
                  else begin
                    pGold := @PlayObject.m_nShopGold;
                    pPlayGold := @m_nGold;
                    nBack := 13; //金币不够
                  end;
                  if pGold^ >= nMoney then begin
                    New(UserItem32);
                    UserItem32^ := UserItem^;
                    if boSuperposition then
                      UserItem32.Dura := nCount;

                    nID := PlayObject.AddItemToBag(UserItem32, StdItem, boSuperposition, m_sCharName, '摆摊', AddUserItem);
                    if nID <> -1 then begin
                      Dec(pGold^, nMoney);
                      nMoneyEx := nMoney;
                      if (nMoneyEx > 0) and (g_Config.nPersonShopBuyRate in [1 .. 99]) then
                        nMoneyEx := _MAX(Round(nMoneyEx * (100 - g_Config.nPersonShopBuyRate) / 100), 1);
                      IntegerChange(pPlayGold^, nMoneyEx, INT_ADD);
                      PlayObject.SendDefMsg(PlayObject, SM_USERSHOPGOLDCHANGE, PlayObject.m_nShopGold,
                        LoWord(PlayObject.m_nShopGameGold), HiWord(PlayObject.m_nShopGameGold), 0, '');

                      if UserShopBuyItem.boGameGold then begin
                        if g_boGameLogGameGold then begin
                          AddGameLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, PlayObject.m_nGameGold +
                            PlayObject.m_nShopGameGold, m_sCharName, '-', IntToStr(nMoney), '摆摊', nil);
                          AddGameLog(Self, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, m_nGameGold,
                            PlayObject.m_sCharName, '+', IntToStr(nMoneyEx), '摆摊', nil);
                        end;
                      end
                      else begin
                        if g_boGameLogGold then begin
                          AddGameLog(PlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayObject.m_nGold +
                            PlayObject.m_nShopGold, m_sCharName, '-', IntToStr(nMoney), '摆摊', nil);
                          AddGameLog(Self, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, m_nGold, PlayObject.m_sCharName,
                            '+', IntToStr(nMoneyEx), '摆摊', nil);
                        end;
                      end;

                      if (not boSuperposition) or (nCount >= UserItem.Dura) then begin
                        if Stditem.NeedIdentify = 1 then
                          AddGameLog(Self, LOG_DELITEM, StdItem.Name, UserItem.MakeIndex,
                            nCount, PlayObject.m_sCharName, '0', '0', '摆摊', UserItem);
                        sCount := IntToStr(ProcessMsg.wParam) + '/0';
                        Dispose(UserItem);
                        m_ItemList.Delete(II);
                      end
                      else begin
                        Dec(UserItem.Dura, nCount);
                        if Stditem.NeedIdentify = 1 then
                          AddGameLog(Self, LOG_ITEMDURACHANGE, StdItem.Name, UserItem.MakeIndex,
                            UserItem.Dura, PlayObject.m_sCharName, '-', IntToStr(nCount), '摆摊', UserItem);
                        sCount := IntToStr(ProcessMsg.wParam) + '/' + IntToStr(nCount);
                        if nID = 2 then begin
                          UserItem32.MakeIndex := GetItemNumber();
                        end;
                      end;
                      if nID = 2 then begin
                        PlayObject.SendAddItem(UserItem32);
                        if Stditem.NeedIdentify = 1 then begin
                          AddGameLog(PlayObject, LOG_ADDITEM, StdItem.Name, UserItem32.MakeIndex,
                            nCount, m_sCharName, '0', '0', '摆摊', UserItem32);
                        end;
                      end
                      else begin
                        Dispose(UserItem32);
                        ItemIndex := 0;
                      end;

                      if (not boSuperposition) or (nCount >= UserShopBuyItem.wCount) then begin
                        PlayObject.SendDefMsg(PlayObject, SM_USERSHOPITEMCHANGE, nCount, 0, ProcessMsg.wParam, 2,
                          m_sCharname);
                        PlayObject.m_ShopBuyItemList.Delete(I);
                        Dispose(UserShopBuyItem);
                      end
                      else begin
                        Dec(UserShopBuyItem.wCount, nCount);
                        PlayObject.SendDefMsg(PlayObject, SM_USERSHOPITEMCHANGE, nCount,
                          UserShopBuyItem.wCount, ProcessMsg.wParam, 2, m_sCharname);
                      end;

                      nBack := 15; //出售成功
                      PlayObject.m_dwSaveRcdTick := 0; //Jason 新增交易完成立既保存数据
                      m_dwSaveRcdTick := 0; //Jason 新增交易完成立既保存数据
                    end
                    else begin
                      nBack := 14;
                      Dispose(UserItem32);
                    end;
                  end;
                  break;
                end;
              end;
              break;
            end;
          end;
        end;
        SendDefMessage(SM_BUYUSERSHOP, m_nGold, LoWord(m_nGameGold), HiWord(m_nGameGold), nBack, sCount);
      end;
      PlayObject.CheckShopingClose();
      //新增检测摆摊卖完自动收摊！
    end;
  except
    on E: Exception do begin
      MainOutMessage(E.Message);
      MainOutMessage('[Exception] TPlayObject.ClientBuyUserShop ' + IntToStr(ProcessMsg.wParam));
    end;
  end;
end;

procedure TPlayObject.ClientSay(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if not m_boMapApoise then
    exit; //如果客户端地图未准备好,不允许
  if ProcessMsg.sMsg <> '' then begin
    ProcessUserLineMsg(ProcessMsg.sMsg);
  end;
end;
{
procedure TPlayObject.ServerMonMove(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
    m_DefMsg := MakeDefaultMsg(SM_SITDOWN, Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
    SendSocket(@m_DefMsg, '');
  end;
end;    }
{
procedure TPlayObject.Server43(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
    m_DefMsg := MakeDefaultMsg(SM_43, Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
    SendSocket(@m_DefMsg, '');
  end;
end;

procedure TPlayObject.Server42(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
    m_DefMsg := MakeDefaultMsg(SM_42, Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
    SendSocket(@m_DefMsg, '');
  end;
end;

procedure TPlayObject.Server41(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
    m_DefMsg := MakeDefaultMsg(SM_41, Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
    SendSocket(@m_DefMsg, '');
  end;
end;              }

procedure TPlayObject.ServerDefSocket(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  m_DefMsg := MakeDefaultMsg(ProcessMsg.wParam,
    ProcessMsg.nParam1,
    ProcessMsg.nParam2,
    LoWord(ProcessMsg.nParam3),
    HiWord(ProcessMsg.nParam3));
  SendSocket(@m_DefMsg, ProcessMsg.sMsg);
end;

procedure TPlayObject.ServerDefMessage(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(ProcessMsg.wParam,
    ProcessMsg.nParam1,
    ProcessMsg.nParam2,
    LoWord(ProcessMsg.nParam3),
    HiWord(ProcessMsg.nParam3),
    ProcessMsg.sMsg);
end;

procedure TPlayObject.ServerShowEffect(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_SHOWEFFECT,
    ProcessMsg.nParam1,
    ProcessMsg.wParam,
    ProcessMsg.nParam2,
    ProcessMsg.nParam3,
    '');
end;

procedure TPlayObject.ServerUserShop(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if ProcessMsg.BaseObject <> Self then
    m_DefMsg := MakeDefaultMsg(SM_USEROPENSHOP, ProcessMsg.nParam1, ProcessMsg.nParam2, 0, ProcessMsg.wParam);
  SendSocket(@m_DefMsg, ProcessMsg.sMsg);
end;

procedure TPlayObject.ServerPlayDice(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  MessageBodyWL: TMessageBodyWL;
begin
  MessageBodyWL.lParam1 := ProcessMsg.nParam1;
  MessageBodyWL.lParam2 := ProcessMsg.nParam2;
  MessageBodyWL.lTag1 := ProcessMsg.nParam3;
  m_DefMsg := MakeDefaultMsg(SM_PLAYDICE,
    Integer(ProcessMsg.BaseObject),
    ProcessMsg.wParam,
    0,
    0);
  SendSocket(@m_DefMsg, EncodeBuffer(@MessageBodyWL, SizeOf(TMessageBodyWL)) + EncodeString(ProcessMsg.sMsg));
end;

procedure TPlayObject.ServerChangeFace(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  CharDesc: TCharDesc;
begin
  if (ProcessMsg.nParam1 <> 0) and (ProcessMsg.nParam2 <> 0) then begin
    m_DefMsg := MakeDefaultMsg(SM_CHANGEFACE,
      ProcessMsg.nParam1,
      LoWord(ProcessMsg.nParam2),
      HiWord(ProcessMsg.nParam2),
      0);
    CharDesc.feature := TBaseObject(ProcessMsg.nParam2).GetFeature(Self);
    CharDesc.Status := TBaseObject(ProcessMsg.nParam2).m_nCharStatus;
    CharDesc.btStrengthenIdx := TBaseObject(ProcessMsg.nParam2).m_btStrengthenName;
    CharDesc.btWuXin := TBaseObject(ProcessMsg.nParam2).m_btWuXin;
    SendSocket(@m_DefMsg, EncodeBuffer(@CharDesc, SizeOf(TCharDesc)));
  end;
end;

procedure TPlayObject.ServerBreakWeapon(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_BREAKWEAPON,
    Integer(ProcessMsg.BaseObject),
    0,
    0,
    0,
    '');
end;

procedure TPlayObject.ServerCloseHealth(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_CLOSEHEALTH,
    Integer(ProcessMsg.BaseObject),
    0,
    0,
    0,
    '');
end;

procedure TPlayObject.ServerOpenHealth(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_OPENHEALTH,
    Integer(ProcessMsg.BaseObject),
    TBaseObject(ProcessMsg.BaseObject).m_WAbil.HP,
    TBaseObject(ProcessMsg.BaseObject).m_WAbil.MaxHP,
    0,
    '');
end;

procedure TPlayObject.ServerReConnection(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  m_boReconnection := True;
  SendDefMessage(SM_RECONNECT, 0, 0, 0, 0, ProcessMsg.sMsg);
end;

procedure TPlayObject.ServerSpaceMoveShow(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  s1C: string;
  CharDesc: TCharDesc;
  nObjCount: integer;
begin
  if ProcessMsg.wIdent = RM_SPACEMOVE_SHOW3 then begin
    m_DefMsg := MakeDefaultMsg(SM_SPACEMOVE_SHOW3,
      Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1,
      ProcessMsg.nParam2,
      ProcessMsg.wParam);
  end
  else if ProcessMsg.wIdent = RM_SPACEMOVE_SHOW then begin
    m_DefMsg := MakeDefaultMsg(SM_SPACEMOVE_SHOW,
      Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1,
      ProcessMsg.nParam2,
      ProcessMsg.wParam);
  end
  else begin
    m_DefMsg := MakeDefaultMsg(SM_SPACEMOVE_SHOW2,
      Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1,
      ProcessMsg.nParam2,
      ProcessMsg.wParam);
  end;
  CharDesc.feature := TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
  CharDesc.Status := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
  CharDesc.btStrengthenIdx := TBaseObject(ProcessMsg.BaseObject).m_btStrengthenName;
  CharDesc.btWuXin := TBaseObject(ProcessMsg.BaseObject).m_btWuXin;
  s1C := EncodeBuffer(@CharDesc, SizeOf(TCharDesc));
  nObjCount := GetCharColor(TBaseObject(ProcessMsg.BaseObject));
  if ProcessMsg.sMsg <> '' then begin
    s1C := s1C + EncodeString(ProcessMsg.sMsg + '/' + IntToStr(nObjCount));
  end;
  SendSocket(@m_DefMsg, s1C);
end;

procedure TPlayObject.ServerSpaceMoveFire2(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if ProcessMsg.wIdent = RM_SPACEMOVE_FIRE3 then begin
    m_DefMsg := MakeDefaultMsg(SM_SPACEMOVE_HIDE3, Integer(ProcessMsg.BaseObject), 0, 0, 0);
    SendSocket(@m_DefMsg, '');
  end
  else begin
    m_DefMsg := MakeDefaultMsg(SM_SPACEMOVE_HIDE2, Integer(ProcessMsg.BaseObject), 0, 0, 0);
    SendSocket(@m_DefMsg, '');
  end;
end;

procedure TPlayObject.ServerSpaceMoveFire(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  m_DefMsg := MakeDefaultMsg(SM_SPACEMOVE_HIDE,
    Integer(ProcessMsg.BaseObject),
    0,
    0,
    0);
  SendSocket(@m_DefMsg, '');
end;

procedure TPlayObject.Server10205(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_716,
    Integer(ProcessMsg.BaseObject),
    ProcessMsg.nParam1 {x},
    ProcessMsg.nParam2 {y},
    ProcessMsg.nParam3 {type},
    '');
end;

procedure TPlayObject.ServerMonMagic(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  MessageBodyW: TMessageBodyW;
  BaseObject: TBaseObject;
begin
  m_DefMsg := MakeDefaultMsg(SM_MONMAGIC, Integer(ProcessMsg.BaseObject), ProcessMsg.nParam2, ProcessMsg.nParam3, ProcessMsg.wParam);
  BaseObject := TBaseObject(ProcessMsg.nParam1);
  MessageBodyW.Param1 := LoWord(ProcessMsg.nParam1);
  MessageBodyW.Param2 := HiWord(ProcessMsg.nParam1);
  MessageBodyW.Tag1 := BaseObject.m_nCurrX;
  MessageBodyW.Tag2 := BaseObject.m_nCurrY;
  SendSocket(@m_DefMsg, EncodeBuffer(@MessageBodyW, SizeOf(MessageBodyW)));
end;

procedure TPlayObject.ServerLighting(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  MessageBodyWL: TMessageBodyWL;
begin
  if TBaseObject(ProcessMsg.nParam3) <> nil then begin
    MessageBodyWL.lParam1 := TBaseObject(ProcessMsg.nParam3).m_nCurrX;
    MessageBodyWL.lParam2 := TBaseObject(ProcessMsg.nParam3).m_nCurrY;
    MessageBodyWL.lTag1 := ProcessMsg.nParam3;
    MessageBodyWL.lTag2 := ProcessMsg.nParam1;
    m_DefMsg := MakeDefaultMsg(SM_LIGHTING,
      Integer(ProcessMsg.BaseObject),
      TBaseObject(ProcessMsg.BaseObject).m_nCurrX,
      TBaseObject(ProcessMsg.BaseObject).m_nCurrY,
      ProcessMsg.wParam);
    SendSocket(@m_DefMsg, EncodeBuffer(@MessageBodyWL, SizeOf(TMessageBodyWL)));
  end;
end;

procedure TPlayObject.ServerFlyAxe(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  MessageBodyW: TMessageBodyW;
begin
  if TBaseObject(ProcessMsg.nParam3) <> nil then begin
    MessageBodyW.Param1 := TBaseObject(ProcessMsg.nParam3).m_nCurrX;
    MessageBodyW.Param2 := TBaseObject(ProcessMsg.nParam3).m_nCurrY;
    MessageBodyW.Tag1 := LoWord(ProcessMsg.nParam3);
    MessageBodyW.Tag2 := HiWord(ProcessMsg.nParam3);
    m_DefMsg := MakeDefaultMsg(SM_FLYAXE,
      Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1,
      ProcessMsg.nParam2,
      ProcessMsg.wParam);
    SendSocket(@m_DefMsg, EncodeBuffer(@MessageBodyW, SizeOf(TMessageBodyW)));
  end;
end;

procedure TPlayObject.ServerDigDown(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  m_DefMsg := MakeDefaultMsg(SM_DIGDOWN,
    Integer(ProcessMsg.BaseObject),
    ProcessMsg.nParam1,
    ProcessMsg.nParam2,
    0);
  SendSocket(@m_DefMsg, '');
end;

procedure TPlayObject.ServerDigUp(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  s1C: string;
  MessageBodyWL: TMessageBodyWL;
begin
  if not TBaseObject(ProcessMsg.BaseObject).m_boGhost then begin
    m_DefMsg := MakeDefaultMsg(SM_DIGUP,
      Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1,
      ProcessMsg.nParam2,
      ProcessMsg.wParam);
    MessageBodyWL.lParam1 := TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
    MessageBodyWL.lParam2 := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
    MessageBodyWL.lTag1 := ProcessMsg.nParam3;
    MessageBodyWL.lTag1 := 0;
    s1C := EncodeBuffer(@MessageBodyWL, SizeOf(TMessageBodyWL));
    SendSocket(@m_DefMsg, s1C);
  end;
end;

procedure TPlayObject.ServerAlive(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  CharDesc: TCharDesc;
begin
  if not TBaseObject(ProcessMsg.BaseObject).m_boGhost then begin
    m_DefMsg := MakeDefaultMsg(SM_ALIVE,
      Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1,
      ProcessMsg.nParam2,
      ProcessMsg.wParam);
    CharDesc.feature := TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
    CharDesc.Status := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
    CharDesc.btStrengthenIdx := TBaseObject(ProcessMsg.BaseObject).m_btStrengthenName;
    CharDesc.btWuXin := TBaseObject(ProcessMsg.BaseObject).m_btWuXin;
    SendSocket(@m_DefMsg, EncodeBuffer(@CharDesc, SizeOf(TCharDesc)));
    {SendDefMessage(SM_SHOWEFFECT, Integer(ProcessMsg.BaseObject),
      Effect_Alive,
      TBaseObject(ProcessMsg.BaseObject).m_nCurrX,
      TBaseObject(ProcessMsg.BaseObject).m_nCurrY); }
  end;
end;

procedure TPlayObject.ServerSendDelItemList(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDelItemList(TStringList(ProcessMsg.nParam1));
  TStringList(ProcessMsg.nParam1).Free;
end;
{
procedure TPlayObject.ServerUserGetBackItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendSaveItemList(ProcessMsg.nParam1);
end;      }

procedure TPlayObject.ServerCharStatusChanged(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_CHARSTATUSCHANGED,
    Integer(ProcessMsg.BaseObject),
    LoWord(ProcessMsg.nParam1),
    HiWord(ProcessMsg.nParam1),
    ProcessMsg.wParam,
    '');
end;

procedure TPlayObject.ServerGameGoldChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendGoldInfo(False);
end;

procedure TPlayObject.ServerMagicFireFail(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_MAGICFIRE_FAIL, Integer(ProcessMsg.BaseObject), 0, 0, 0, '');
end;

procedure TPlayObject.ServerMagicFire(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin

  m_DefMsg := MakeDefaultMsg(SM_MAGICFIRE,
    Integer(ProcessMsg.BaseObject),
    LoWord(ProcessMsg.nParam2),
    HiWord(ProcessMsg.nParam2),
    ProcessMsg.nParam1);
  SendSocket(@m_DefMsg, EncodeBuffer(@ProcessMsg.nParam3, SizeOf(Integer)));
end;

procedure TPlayObject.ServerButch(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if ProcessMsg.BaseObject <> nil then begin
    m_DefMsg := MakeDefaultMsg(SM_BUTCH,
      Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1,
      ProcessMsg.nParam2,
      ProcessMsg.wParam);
    SendSocket(@m_DefMsg, '');
  end;
end;

procedure TPlayObject.ClientMapApoise(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  //MainOutMessage('MapApoise');
{$IF CHANGEMAPMODE = NEWMAPMODE}
  if not m_boMapApoise then begin
    //MainOutMessage('MapApoise_OK');
    m_boMapApoise := True;
    m_boUserLogon := True;
    m_dwSearchTick := GetTickCount();
    SearchViewRange;
    SendDefMsg(Self, SM_MAPAPOISE, 0, 0, 0, 0, '');
    if m_btMapSpaceShow > 0 then begin
      if m_btMapSpaceShow = 2 then begin
        SendRefMsg(RM_SPACEMOVE_SHOW2, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
      end
      else
        SendRefMsg(RM_SPACEMOVE_SHOW, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;
    m_btMapSpaceShow := 0;
  end;
{$IFEND}
end;

procedure TPlayObject.ServerChangeMap(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  Castle: TUserCastle;
begin
  OnAction(AT_ChangeMap);
{$IF CHANGEMAPMODE = OLDMAPMODE}
  m_boMapApoise := True;
  m_boUserLogon := True;
  SendDefMessage(SM_CHANGEMAP, Integer(Self), m_nCurrX, m_nCurrY, m_PEnvir.nMinMap, ProcessMsg.sMsg);
{$ELSE}
  if (m_PEnvir <> nil) and (TEnvirnoment(ProcessMsg.nParam1) = m_PEnvir) then begin
    m_boMapApoise := True;
    m_boUserLogon := True;
    //MainOutMessage('SM_CHANGEMAP_OLD');
    SendDefMessage(SM_CHANGEMAP_OLD, Integer(Self), m_nCurrX, m_nCurrY, m_PEnvir.nMinMap, ProcessMsg.sMsg);
    if m_btMapSpaceShow > 0 then begin
      if m_btMapSpaceShow = 2 then begin
        SendRefMsg(RM_SPACEMOVE_SHOW2, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
      end
      else
        SendRefMsg(RM_SPACEMOVE_SHOW, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;
    m_btMapSpaceShow := 0;
    m_dwSearchTick := GetTickCount();
    SearchViewRange;
  end
  else begin
    //MainOutMessage('SM_CHANGEMAP ' + IntToStr(ProcessMsg.nParam1) + '/' + IntToStr(Integer(m_PEnvir)));
    m_boMapApoise := False;
    m_dwMapApoiseTick := GetTickCount;
    SendDefMessage(SM_CHANGEMAP, Integer(Self), m_nCurrX, m_nCurrY, m_PEnvir.nMinMap, ProcessMsg.sMsg);
  end;
{$IFEND}
  RefUserState();
  SendMapDescription();
  SendServerConfig();
  Castle := g_CastleManager.InCastleWarArea(Self);
  if (Castle <> nil) and Castle.m_boUnderWar then begin
    ChangePKStatus(True);
  end
  else begin
    ChangePKStatus(False);
  end;
end;

procedure TPlayObject.ServerFeatureChanged(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_FEATURECHANGED,
    Integer(ProcessMsg.BaseObject),
    LoWord(ProcessMsg.nParam1),
    HiWord(ProcessMsg.nParam1),
    ProcessMsg.wParam,
    ProcessMsg.sMsg);
end;

procedure TPlayObject.ServerIconInfo(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_REFICONINFO,
    ProcessMsg.nParam1,
    0,
    0,
    0,
    ProcessMsg.sMsg);
end;

procedure TPlayObject.ServerDoorClose(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_CLOSEDOOR,
    0,
    ProcessMsg.nParam1,
    ProcessMsg.nParam2,
    0,
    '');
end;

procedure TPlayObject.ServerDoorOpen(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_OPENDOOR_OK,
    0,
    ProcessMsg.nParam1, {x}
    ProcessMsg.nParam2, {y}
    0,
    '');
end;

procedure TPlayObject.ServerItemHide(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_ITEMHIDE,
    ProcessMsg.nParam1,
    ProcessMsg.nParam2,
    ProcessMsg.nParam3,
    ProcessMsg.wParam,
    '');
end;

procedure TPlayObject.ServerItemShow(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_ITEMSHOW,
    ProcessMsg.nParam1,
    ProcessMsg.nParam2,
    ProcessMsg.nParam3,
    ProcessMsg.wParam,
    ProcessMsg.sMsg);
end;

procedure TPlayObject.ServerHealthSpellChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  m_DefMsg := MakeDefaultMsg(SM_HEALTHSPELLCHANGED,
    Integer(ProcessMsg.BaseObject),
    TBaseObject(ProcessMsg.BaseObject).m_WAbil.HP,
    TBaseObject(ProcessMsg.BaseObject).m_WAbil.MP,
    TBaseObject(ProcessMsg.BaseObject).m_WAbil.MaxHP);
  SendSocket(@m_DefMsg, '');
end;

procedure TPlayObject.ServerSay(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if cv_Mir2 in m_ClientVersion then begin
    case ProcessMsg.wIdent of
      RM_HEAR: begin
          if not m_boBanHearChat then exit;
          m_DefMsg := MakeDefaultMsg(SM_HEAR, Integer(ProcessMsg.BaseObject), g_Config.btHearMsgFColor, g_Config.btHearMsgBColor, 1);
        end;
      RM_CRY: m_DefMsg := MakeDefaultMsg(SM_CRY, Integer(ProcessMsg.BaseObject), g_Config.btCryMsgFColor, g_Config.btCryMsgBColor, 1);
      RM_SYSMESSAGE: m_DefMsg := MakeDefaultMsg(SM_SYSMESSAGE, Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1, ProcessMsg.nParam2, m_btAttatckMode);
      RM_GROUPMESSAGE: m_DefMsg := MakeDefaultMsg(SM_GROUPMESSAGE, Integer(ProcessMsg.BaseObject), g_Config.btGroupMsgFColor, g_Config.btGroupMsgBColor, 1);
      RM_GUILDMESSAGE: m_DefMsg := MakeDefaultMsg(SM_GUILDMESSAGE, Integer(ProcessMsg.BaseObject), g_Config.btGuildMsgFColor, g_Config.btGuildMsgBColor, 1);
      RM_BUGLE: m_DefMsg := MakeDefaultMsg(SM_BUGLE, Integer(ProcessMsg.BaseObject), g_Config.btCudtMsgFColor, g_Config.btCudtMsgBColor, 1);
    else begin
        m_DefMsg := MakeDefaultMsg(SM_HEAR, Integer(ProcessMsg.BaseObject), g_Config.btHearMsgFColor, g_Config.btHearMsgBColor, 1);
      end;
    end;
  end else begin
    case ProcessMsg.wIdent of
      RM_HEAR: begin
          if not m_boBanHearChat then exit;
          m_DefMsg := MakeDefaultMsg(SM_HEAR, Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1, ProcessMsg.nParam2, 1);
        end;
      RM_CRY: m_DefMsg := MakeDefaultMsg(SM_CRY, Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1, ProcessMsg.nParam2, 1);
      RM_SYSMESSAGE: m_DefMsg := MakeDefaultMsg(SM_SYSMESSAGE, Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1, ProcessMsg.nParam2, m_btAttatckMode);
      RM_GROUPMESSAGE: m_DefMsg := MakeDefaultMsg(SM_GROUPMESSAGE, Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1, ProcessMsg.nParam2, 1);
      RM_GUILDMESSAGE: m_DefMsg := MakeDefaultMsg(SM_GUILDMESSAGE, Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1, ProcessMsg.nParam2, 1);
      RM_BUGLE: m_DefMsg := MakeDefaultMsg(SM_BUGLE, Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1, ProcessMsg.nParam2, 1);
    else begin
        m_DefMsg := MakeDefaultMsg(SM_HEAR, Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1, ProcessMsg.nParam2, 1);
      end;
    end;
  end;
  SendSocket(@m_DefMsg, EncodeString(ProcessMsg.sMsg));
end;

procedure TPlayObject.ServerLogon(ProcessMsg: pTProcessMessage; var boResult: Boolean);
{$IF Public_Ver = Public_Release}
var
  nIdx: Integer;
{$ELSE}
var
{$IFEND}
  SetItem: pTSetItems;
  I: Integer;
  k: Integer;
  sSendMsg, sStr: string;
begin
{$IF CHANGEMAPMODE = NEWMAPMODE}
  m_boMapApoise := False;
  m_dwMapApoiseTick := GetTickCount;
{$IFEND}
  m_DefMsg := MakeDefaultMsg(SM_NEWMAP, Integer(Self), m_nCurrX, m_nCurrY, m_PEnvir.nMinMap);
  SendSocket(@m_DefMsg, EncodeString(g_MapManager.GetMainMap(m_PEnvir)));
  SendLogon();
  SendDefMessage(SM_USERNAME, Integer(Self), GetCharColor(Self), m_btWuXin, 0, GetShowName);
  
  sSendMsg := '';
  for I := 0 to g_SetItemsList.Count - 1 do begin
    SetItem := g_SetItemsList[I];
    if SetItem.HideValue then
      Continue;
    sStr := '';
    for k := Low(SetItem.Items) to High(SetItem.Items) do begin
      if SetItem.Items[k] <> '' then begin
        sStr := sStr + IntToStr(k) + '.' + SetItem.Items[k] + '/';
      end;
    end;
    if sStr = '' then Continue;
    sStr := sStr + ';';
    for k := Low(SetItem.Value) to High(SetItem.Value) do begin
      if SetItem.Value[k] > 0 then begin
        sStr := sStr + IntToStr(k) + '.' + IntToStr(SetItem.Value[k]) + '/';
      end;
    end;
    if Length(sStr) < 4 then Continue;
    sSendMsg := sSendMsg + EncodeString(sStr) + '/'
  end;
  if sSendMsg <> '' then begin
    m_DefMsg := MakeDefaultMsg(SM_SETITEMS, 0, 0, 0, 0);
    SendSocket(@m_DefMsg, sSendMsg);
  end;

  RefUserState();
  SendMapDescription();
  SendGoldInfo(True);
  DiamondChanged();
  SendUseitems();
  SendUseMagic();
{$IF Public_Ver = Public_Release}
  if g_ADExitUrlList.Count > 0 then begin
    m_DefMsg := MakeDefaultMsg(SM_AD_EXIT, 0, 0, 0, 0);
    SendSocket(@m_DefMsg, EncodeString(g_ADExitUrlList[Random(g_ADExitUrlList.Count)]));
  end;
  if g_ADFrameUrlList.Count > 0 then begin
    nIdx := Random(g_ADFrameUrlList.Count);
    SendDelayDefMsg(Self, SM_AD_FRAME, Integer(g_ADFrameUrlList.Objects[nIdx]),
      0, 0, 0, g_ADFrameUrlList[nIdx], 30 * 1000);
  end;
{$IFEND}
  SendServerConfig();
  SendNakedAbility();
  SendRealityInfo();
  SendGameSetupInfo;
  SendMissionInfo;
  SendMakeMagic;
  SendFilterInfo;
  m_DefMsg := MakeDefaultMsg(SM_USERKEYSETUP, g_Config.nSetupInfo, 0, 0, Integer(g_Config.boCloseWuXin));
  SendSocket(@m_DefMsg, EncodeBuffer(@m_UserKeySetup, SizeOf(m_UserKeySetup)) + '/' +
    EncodeString('@' + g_GameCommand.USERMOVE.sCmd + '/' +
                 '@' + g_GameCommand.MEMBERFUNCTION.sCmd + '/' +
                 '@' + g_GameCommand.MEMBERFUNCTIONEX.sCmd + '/' +
                 '@' + g_GameCommand.AUTH.sCmd + '/' +
                 '@' + g_GameCommand.AUTHCANCEL.sCmd + '/' +
                 '@' + g_GameCommand.ENDGUILD.sCmd + '/' +
                 '@' + g_GameCommand.AllSysMsg.sCmd + '/' +
                 '@' + g_GameCommand.TAKEONHORSE.sCmd + '/' +
                 '@' + g_GameCommand.TAKEOFHORSE.sCmd));

  if not (cv_Mir2 in m_ClientVersion) then begin
    m_DefMsg := MakeDefaultMsg(SM_HINTDATA, g_nHintDataLen, 0, 0, 0);
    SendSocket(@m_DefMsg, g_sHintData);
  end;
end;

procedure TPlayObject.SendFilterInfo;
begin
  m_DefMsg := MakeDefaultMsg(SM_FILTERINFO, g_FilterDataLen, 0, 0, 0);
  SendSocket(@m_DefMsg, g_FilterData);
end;

procedure TPlayObject.ServerChangeNameColor(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  SendDefMessage(SM_CHANGENAMECOLOR,
    Integer(ProcessMsg.BaseObject),
    GetCharColor(TBaseObject(ProcessMsg.BaseObject)),
    0,
    0,
    '');

end;

procedure TPlayObject.ServerLevelUp(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  {if Assigned(zPlugOfEngine.HookSendUserLevelUpMsg) then begin
          zPlugOfEngine.HookSendUserLevelUpMsg(Self);
        end
        else begin   }
  m_DefMsg := MakeDefaultMsg(SM_LEVELUP, m_Abil.Exp, m_Abil.Level, 0, m_nMakeMagicPoint);
  SendSocket(@m_DefMsg, '');
  SendAbility;
  SendSubAbility;

  SendDefMessage(SM_NAKEDABILITY, m_nNakedCount, 0, 0, 0, '');
end;

procedure TPlayObject.ServerUserName(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  m_DefMsg := MakeDefaultMsg(SM_USERNAME, Integer(ProcessMsg.BaseObject),
    GetCharColor(TBaseObject(ProcessMsg.BaseObject)),
    TBaseObject(ProcessMsg.BaseObject).m_btWuXin,
    0);
  SendSocket(@m_DefMsg, EncodeString(ProcessMsg.sMsg));
end;

procedure TPlayObject.ServerSkeleton(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  CharDesc: TCharDesc;
begin
  {if Assigned(zPlugOfEngine.HookSendSkeletonMsg) then begin
          try
            zPlugOfEngine.HookSendSkeletonMsg(Self,
              ProcessMsg.BaseObject,
              ProcessMsg.nParam1,
              ProcessMsg.nParam2,
              ProcessMsg.wParam);
          except
          end;
        end
        else begin  }
  if not TBaseObject(ProcessMsg.BaseObject).m_boGhost then begin
    m_DefMsg := MakeDefaultMsg(SM_SKELETON,
      Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1,
      ProcessMsg.nParam2,
      ProcessMsg.wParam);
    CharDesc.feature := TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
    CharDesc.Status := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
    CharDesc.btStrengthenIdx := TBaseObject(ProcessMsg.BaseObject).m_btStrengthenName;
    CharDesc.btWuXin := TBaseObject(ProcessMsg.BaseObject).m_btWuXin;
    SendSocket(@m_DefMsg, EncodeBuffer(@CharDesc, SizeOf(TCharDesc)));
  end;
end;

procedure TPlayObject.ServerDisappear(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  m_DefMsg := MakeDefaultMsg(SM_DISAPPEAR, Integer(ProcessMsg.BaseObject), 0, 0, 0);
  SendSocket(@m_DefMsg, '');
end;

procedure TPlayObject.ServerDeath(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  CharDesc: TCharDesc;
begin
  {if Assigned(zPlugOfEngine.HookSendDeathMsg) then begin
          try
            zPlugOfEngine.HookSendDeathMsg(Self,
              ProcessMsg.BaseObject,
              ProcessMsg.nParam1,
              ProcessMsg.nParam2,
              ProcessMsg.wParam,
              ProcessMsg.nParam3);
          except
          end;
        end
        else begin }
  if not TBaseObject(ProcessMsg.BaseObject).m_boGhost then begin
    if ProcessMsg.nParam3 = 1 then begin
      m_DefMsg := MakeDefaultMsg(SM_NOWDEATH,
        Integer(ProcessMsg.BaseObject),
        ProcessMsg.nParam1,
        ProcessMsg.nParam2,
        ProcessMsg.wParam);
    end
    else begin
      m_DefMsg := MakeDefaultMsg(SM_DEATH,
        Integer(ProcessMsg.BaseObject),
        ProcessMsg.nParam1,
        ProcessMsg.nParam2,
        ProcessMsg.wParam);
    end;
    CharDesc.feature := TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
    CharDesc.Status := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
    CharDesc.btStrengthenIdx := TBaseObject(ProcessMsg.BaseObject).m_btStrengthenName;
    CharDesc.btWuXin := TBaseObject(ProcessMsg.BaseObject).m_btWuXin;
    SendSocket(@m_DefMsg, EncodeBuffer(@CharDesc, SizeOf(TCharDesc)));
  end;

end;

procedure TPlayObject.ServerStruck(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  MessageBodyWL: TMessageBodyWL;
  //nDander: Word;
begin
  //nDander := 0;

  if ProcessMsg.wParam {nPower} > 0 then begin
    if TBaseObject(ProcessMsg.BaseObject) = Self then begin
      //nDander := m_nDander;
      OnAction(AT_Struck);
      if TBaseObject(ProcessMsg.nParam3) {AttackBaseObject} <> nil then begin
        if TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_PLAYOBJECT then begin
          SetPKFlag(TBaseObject(ProcessMsg.nParam3) {AttackBaseObject});
        end;
        SetLastHiter(TBaseObject(ProcessMsg.nParam3) {AttackBaseObject});
        {
        //反复活
        if TBaseObject(ProcessMsg.nParam3).m_boUnRevival then
          m_boRevival:=False;
        }
      end; //004D8B67
      if PKLevel >= 2 then
        m_dw5D4 := GetTickCount();
      //if UserCastle.IsMasterGuild(TGuild(m_MyGuild)) and (TBaseObject(ProcessMsg.nParam3) <> nil) then begin
      if (g_CastleManager.IsCastleMember(Self) <> nil) and (TBaseObject(ProcessMsg.nParam3) <> nil) and
        (m_MyGuild <> TBaseObject(ProcessMsg.nParam3).m_MyGuild) then begin
        TBaseObject(ProcessMsg.nParam3).bo2B0 := True;
        TBaseObject(ProcessMsg.nParam3).m_dw2B4Tick := GetTickCount();
      end;
      m_nHealthTick := 0;
      m_nSpellTick := 0;
      Dec(m_nPerHealth);
      Dec(m_nPerSpell);
      m_dwStruckTick := GetTickCount(); //09/10
      if (TBaseObject(ProcessMsg.BaseObject).m_btRaceServer = RC_PLAYOBJECT) and
        (TBaseObject(ProcessMsg.BaseObject).m_GroupOwner <> nil) then begin
        TPlayObject(Self).SendRefGroupMsg(
          Self,
          SM_GROUPINFO1,
          Integer(Self),
          m_WAbil.HP,
          m_WAbil.MP,
          m_WAbil.MaxHP,
          IntToStr(m_WAbil.MaxMP));
      end;
    end; //4D8BE1
    if TBaseObject(ProcessMsg.BaseObject) <> nil then begin

      m_DefMsg := MakeDefaultMsg(SM_STRUCK,
        Integer(ProcessMsg.BaseObject),
        TBaseObject(ProcessMsg.BaseObject).m_WAbil.HP,
        TBaseObject(ProcessMsg.BaseObject).m_WAbil.MaxHP,
        ProcessMsg.wParam);
      MessageBodyWL.lParam1 := TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
      MessageBodyWL.lParam2 := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
      MessageBodyWL.lTag1 := ProcessMsg.nParam3;
      if ProcessMsg.wIdent = RM_STRUCK_MAG then
        MessageBodyWL.lTag2 := MakeLong(1, m_nPullulation div MIDPULLULATION)
      else
        MessageBodyWL.lTag2 := MakeLong(0, m_nPullulation div MIDPULLULATION);
      SendSocket(@m_DefMsg, EncodeBuffer(@MessageBodyWL, SizeOf(TMessageBodyWL)));
    end;
  end;
end;

procedure TPlayObject.ServerTurn(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  s1C: string;
  nObjCount: integer;
  CharDesc: TCharDesc;
begin
  if not TBaseObject(ProcessMsg.BaseObject).m_boGhost then begin
    if (TBaseObject(ProcessMsg.BaseObject) <> Self) or (ProcessMsg.wIdent in [RM_PUSH, RM_MAGICMOVE, RM_RUSH, RM_RUSHKUNG, RM_RUSHCBO, RM_MAGICFIR]) then begin
      case ProcessMsg.wIdent of
        RM_PUSH: //004D835F
          m_DefMsg := MakeDefaultMsg(SM_BACKSTEP,
            Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1 {x},
            ProcessMsg.nParam2 {y}, MakeWord(ProcessMsg.wParam, ProcessMsg.nParam3));
        RM_RUSH: //004D83B9
          m_DefMsg := MakeDefaultMsg(SM_RUSH,
            Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1,
            ProcessMsg.nParam2, ProcessMsg.wParam);
        RM_RUSHCBO: //004D83B9
          m_DefMsg := MakeDefaultMsg(SM_RUSHCBO,
            Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1,
            ProcessMsg.nParam2, MakeWord(ProcessMsg.wParam, ProcessMsg.nParam3));
        RM_RUSHKUNG: //004D8413
          m_DefMsg := MakeDefaultMsg(SM_RUSHKUNG,
            Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1,
            ProcessMsg.nParam2, ProcessMsg.wParam);
        RM_MAGICMOVE: //004D8413
          m_DefMsg := MakeDefaultMsg(SM_MAGICMOVE,
            Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1,
            ProcessMsg.nParam2, ProcessMsg.wParam);
        RM_MAGICFIR: //004D8413
          m_DefMsg := MakeDefaultMsg(SM_MAGICFIR,
            Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1,
            ProcessMsg.nParam2, ProcessMsg.wParam);
      else begin //004D846A
          m_DefMsg := MakeDefaultMsg(SM_TURN,
            Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1,
            ProcessMsg.nParam2, ProcessMsg.wParam);
        end;
      end;
      CharDesc.feature := TBaseObject(ProcessMsg.BaseObject).GetFeature(TBaseObject(ProcessMsg.BaseObject));
      CharDesc.Status := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
      CharDesc.btStrengthenIdx := TBaseObject(ProcessMsg.BaseObject).m_btStrengthenName;
      CharDesc.btWuXin := TBaseObject(ProcessMsg.BaseObject).m_btWuXin;
      s1C := EncodeBuffer(@CharDesc, SizeOf(CharDesc));
      nObjCount := GetCharColor(TBaseObject(ProcessMsg.BaseObject));
      if ProcessMsg.sMsg <> '' then
        s1C := s1C + (EncodeString(ProcessMsg.sMsg + '/' + IntToStr(nObjCount)));
      SendSocket(@m_DefMsg, s1C);
      if ProcessMsg.wIdent = RM_TURN then begin
        nObjCount := TBaseObject(ProcessMsg.BaseObject).GetFeatureToLong();
        SendDefMessage(SM_FEATURECHANGED,
          Integer(ProcessMsg.BaseObject),
          LoWord(nObjCount),
          HiWord(nObjCount),
          TBaseObject(ProcessMsg.BaseObject).GetFeatureEx,
          IntToStr(TBaseObject(ProcessMsg.BaseObject).m_btStrengthenName));
      end;
      if ProcessMsg.BaseObject is TPlayObject then
      begin
        SendDefMessage(SM_REFICONINFO, Integer(ProcessMsg.BaseObject), 0, 0, 0, EncodeBuffer(@(TPlayObject(ProcessMsg.BaseObject).m_IconInfo[0]), SizeOf(TIconInfos)));
        SendDefMessage(SM_REFHUMLOOK, Integer(ProcessMsg.BaseObject), TPlayObject(ProcessMsg.BaseObject).GetHumLook, 0, 0, '');
      end;
    end;
  end;
end;

function TPlayObject.GetHumLook: Word;
var
  StdItem: pTStdItem;
begin
  Result := 0;
  if m_UseItems[U_WEAPON].wIndex <= 0 then
    exit;
  StdItem := UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
  if Assigned(StdItem) then
    Result := StdItem.AniCount;
end;

procedure TPlayObject.ServerMoveFail(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  CharDesc: TCharDesc;
begin
  m_DefMsg := MakeDefaultMsg(SM_MOVEFAIL, Integer(Self), m_nCurrX, m_nCurrY, m_btDirection);
  CharDesc.feature := TBaseObject(ProcessMsg.BaseObject).GetFeatureToLong;
  CharDesc.Status := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
  CharDesc.btStrengthenIdx := TBaseObject(ProcessMsg.BaseObject).m_btStrengthenName;
  CharDesc.btWuXin := TBaseObject(ProcessMsg.BaseObject).m_btWuXin;
  SendSocket(@m_DefMsg, EncodeBuffer(@CharDesc, SizeOf(CharDesc)));
end;
{
procedure TPlayObject.ServerCrsHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
 if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
   m_DefMsg := MakeDefaultMsg(SM_CRSHIT, Integer(ProcessMsg.BaseObject),
     ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
   SendSocket(@m_DefMsg, '');
 end;
end;}
{
procedure TPlayObject.ServerWideHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
 if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
   m_DefMsg := MakeDefaultMsg(SM_WIDEHIT, Integer(ProcessMsg.BaseObject),
     ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
   SendSocket(@m_DefMsg, '');
 end;
end;      }
{
procedure TPlayObject.ServerLongHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
 if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
   m_DefMsg := MakeDefaultMsg(SM_LONGHIT, Integer(ProcessMsg.BaseObject),
     ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
   SendSocket(@m_DefMsg, '');
 end;
end;       }
{
procedure TPlayObject.ServerSpell2(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
 if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
   m_DefMsg := MakeDefaultMsg(SM_POWERHIT,
     Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1,
     ProcessMsg.nParam2, ProcessMsg.wParam);
   SendSocket(@m_DefMsg, '');
 end;
end;               }

procedure TPlayObject.ServerSpell(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
    m_DefMsg := MakeDefaultMsg(SM_SPELL, Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
    SendSocket(@m_DefMsg, IntToStr(ProcessMsg.nParam3));
  end;
end;
{
procedure TPlayObject.ServerBigHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
 if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
   m_DefMsg := MakeDefaultMsg(SM_BIGHIT, Integer(ProcessMsg.BaseObject),
     ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
   SendSocket(@m_DefMsg, '');
 end;
end;     }
{
procedure TPlayObject.ServerHeavyHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
 if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
   m_DefMsg := MakeDefaultMsg(SM_HEAVYHIT,
     Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1,
     ProcessMsg.nParam2, ProcessMsg.wParam);
   SendSocket(@m_DefMsg, ProcessMsg.sMsg);
 end;
end;      }

procedure TPlayObject.ServerHit(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
    m_DefMsg := MakeDefaultMsg(ProcessMsg.nParam3, Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
    SendSocket(@m_DefMsg, ProcessMsg.sMsg);
  end;
end;

procedure TPlayObject.ServerLeap(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  CharDesc: TCharDesc;
begin
  {if Assigned(zPlugOfEngine.HookSendRunMsg) then begin
    zPlugOfEngine.HookSendRunMsg(Self, ProcessMsg.BaseObject,
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
  end
  else begin }
  if (TBaseObject(ProcessMsg.BaseObject) <> Self) and (not TBaseObject(ProcessMsg.BaseObject).m_boGhost) then begin
    m_DefMsg := MakeDefaultMsg(SM_LEAP, Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
    CharDesc.feature := TBaseObject(ProcessMsg.BaseObject).GetFeature(TBaseObject(ProcessMsg.BaseObject));
    CharDesc.Status := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
    CharDesc.btStrengthenIdx := TBaseObject(ProcessMsg.BaseObject).m_btStrengthenName;
    CharDesc.btWuXin := TBaseObject(ProcessMsg.BaseObject).m_btWuXin;
    SendSocket(@m_DefMsg, EncodeBuffer(@CharDesc, SizeOf(TCharDesc)));
  end;
end;

procedure TPlayObject.ServerRun(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  CharDesc: TCharDesc;
begin
  {if Assigned(zPlugOfEngine.HookSendRunMsg) then begin
    zPlugOfEngine.HookSendRunMsg(Self, ProcessMsg.BaseObject,
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
  end
  else begin }
  if (TBaseObject(ProcessMsg.BaseObject) <> Self) and (not TBaseObject(ProcessMsg.BaseObject).m_boGhost) then begin
    m_DefMsg := MakeDefaultMsg(SM_RUN, Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
    CharDesc.feature := TBaseObject(ProcessMsg.BaseObject).GetFeature(TBaseObject(ProcessMsg.BaseObject));
    CharDesc.Status := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
    CharDesc.btStrengthenIdx := TBaseObject(ProcessMsg.BaseObject).m_btStrengthenName;
    CharDesc.btWuXin := TBaseObject(ProcessMsg.BaseObject).m_btWuXin;
    SendSocket(@m_DefMsg, EncodeBuffer(@CharDesc, SizeOf(TCharDesc)));
  end;
  //end;
end;

procedure TPlayObject.ServerHorseRun(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  CharDesc: TCharDesc;
begin
  {if Assigned(zPlugOfEngine.HookSendHorseRunMsg) then begin
    zPlugOfEngine.HookSendHorseRunMsg(Self, ProcessMsg.BaseObject,
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
  end
  else begin  }
  if (TBaseObject(ProcessMsg.BaseObject) <> Self) and
    (not TBaseObject(ProcessMsg.BaseObject).m_boGhost) then begin
    m_DefMsg := MakeDefaultMsg(SM_HORSERUN,
      Integer(ProcessMsg.BaseObject), ProcessMsg.nParam1,
      ProcessMsg.nParam2, ProcessMsg.wParam);
    CharDesc.feature := TBaseObject(ProcessMsg.BaseObject).GetFeature(TBaseObject(ProcessMsg.BaseObject));
    CharDesc.Status := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
    CharDesc.btStrengthenIdx := TBaseObject(ProcessMsg.BaseObject).m_btStrengthenName;
    CharDesc.btWuXin := TBaseObject(ProcessMsg.BaseObject).m_btWuXin;
    SendSocket(@m_DefMsg, EncodeBuffer(@CharDesc, SizeOf(TCharDesc)));
  end;
  //end;
end;

procedure TPlayObject.ServerWalk(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  CharDesc: TCharDesc;
begin
  {if Assigned(zPlugOfEngine.HookSendWalkMsg) then begin
    zPlugOfEngine.HookSendWalkMsg(Self, ProcessMsg.BaseObject,
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
  end
  else begin }
  if (TBaseObject(ProcessMsg.BaseObject) <> Self) and
    (not TBaseObject(ProcessMsg.BaseObject).m_boGhost) then begin
    m_DefMsg := MakeDefaultMsg(SM_WALK, Integer(ProcessMsg.BaseObject),
      ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.wParam);
    CharDesc.feature := TBaseObject(ProcessMsg.BaseObject).GetFeature(TBaseObject(ProcessMsg.BaseObject));
    CharDesc.Status := TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
    CharDesc.btStrengthenIdx := TBaseObject(ProcessMsg.BaseObject).m_btStrengthenName;
    CharDesc.btWuXin := TBaseObject(ProcessMsg.BaseObject).m_btWuXin;
    SendSocket(@m_DefMsg, EncodeBuffer(@CharDesc, SizeOf(TCharDesc)));
  end;
  //end;
end;

procedure TPlayObject.ClientSpell(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  dwDelayTime: LongWord;
  //  nMsgCount: Integer;
begin
  if not m_boMapApoise then
    exit; //如果客户端地图未准备好,不允许
  if m_boDealing then
    DealCancel();
  //设置五行活动时间
  //m_dwIsGetWuXinExpTime := GetTickCount + g_Config.dwGetWuXinExpTick;
  if (m_boMagicHitDelay and (not ProcessMsg.boLateDelivery)) then begin
    Inc(m_nMagicHitCount, g_Config.nMaxSpellMsgCount * 2);
    CheckSpeedCount(m_nMagicHitCount, '魔法[多倍]');
    exit;
  end;
  if ClientSpellXY(ProcessMsg.wIdent, ProcessMsg.wParam, ProcessMsg.nParam1, ProcessMsg.nParam2,
    TBaseObject(ProcessMsg.nParam3), ProcessMsg.boLateDelivery, dwDelayTime) then begin
    m_dwActionTick := GetTickCount;
    SendActionGood();
    //Inc(n5F8);
  end
  else begin

    if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      //Inc(m_dwMagicHitTime, dwDelayTime * 2);
      CheckSpeedCount(m_nMagicHitCount, '魔法');
      SetUserTime(dwDelayTime * 2);
      m_boMagicHitDelay := True;
      if m_boTestSpeedMode then
        SysMsg(format('操作延迟 MagicHit Count: %d Time: %d', [m_nMagicHitCount, dwDelayTime]), c_Red, t_Hint);
      SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam, ProcessMsg.nParam1, ProcessMsg.nParam2,
        ProcessMsg.nParam3, '', dwDelayTime * 2);
      boResult := False;
    end;
    (*if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      nMsgCount := GetSpellMsgCount();
      if nMsgCount >= g_Config.nMaxSpellMsgCount then begin
        Inc(m_nOverSpeedCount);
        if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
          if g_Config.boKickOverSpeed then begin
            SysMsg(g_sKickClientUserMsg
              {'请勿使用非法软件.'}, c_Red,
              t_Hint);
            m_boEmergencyClose := True;
            m_boPlayOffLine := False;
          end;
          if g_Config.boViewHackMessage then begin
            //MainOutMessage('[魔法超速] ' + m_sCharName + ' Time: ' + IntToStr(dwDelayTime) + ' Count: '+ IntToStr(nMsgCount));
            MainOutMessage(format(g_sSpellOverSpeed, [m_sCharName,
              dwDelayTime, nMsgCount]));
          end;
        end;
        //如果超速则发送攻击失败信息
        SendActionFail();
      end
      else begin
        if (dwDelayTime > g_Config.dwDropOverSpeed) and
          (g_Config.btSpeedControlMode = 1) and m_boFilterAction then begin
          SendActionFail();
          if m_boTestSpeedMode then
            SysMsg(format('速度异常 Ident: %d Time: %d',
              [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
        end
        else begin
          if m_boTestSpeedMode then
            SysMsg(format('操作延迟 Ident: %d Time: %d', [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
          SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam, ProcessMsg.nParam1, ProcessMsg.nParam2,
            ProcessMsg.nParam3, '', dwDelayTime);
          boResult := False;
        end;
      end;
    end;*)
  end;
end;

procedure TPlayObject.CheckSpeedCount(var nCount: Integer; sHitName: string);
begin
  if nCount >= g_Config.nOverSpeedKickCount then begin
    SpeedCloseFunc; //加速触发
    if g_Config.boKickOverSpeed then begin
      SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, '[断开连接]: 您的游戏速度不稳定,与服务器断开连接!\如果您开了加速软件，请关闭！');
      m_boEmergencyClose := True;
    end;
    if g_Config.boViewHackMessage2 then
      MainOutMessage(Format('[超速]  名称:%s IP地址:%s 项目:%s 参考:[转向:%d 走路:%d 跑步:%d 攻击:%d 魔法:%d 挖取:%d]',
        [m_sCharName, m_sIPaddr, sHitName, m_nTurnCount, m_nWalkCount, m_nRunCount, m_nHitCount, m_nMagicHitCount, m_nButchCount]));

  end;
  if g_Config.boViewHackMessage then begin
    MainOutMessage(Format(
      '[超速提示] 名称:%s IP地址:%s 项目:%s 参考:[转向:%d 走路:%d 跑步:%d 攻击:%d 魔法:%d 挖取:%d]',
      [m_sCharName, m_sIPaddr, sHitName, m_nTurnCount, m_nWalkCount, m_nRunCount, m_nHitCount, m_nMagicHitCount, m_nButchCount]));
  end;
end;

procedure TPlayObject.ClientSitDown(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  dwDelayTime: LongWord;
  //  nMsgCount: Integer;
begin
  if not m_boMapApoise then
    exit; //如果客户端地图未准备好,不允许   g_Config.boViewHackMessage
  if m_boDealing then
    DealCancel();
  if (m_boButchDelay and (not ProcessMsg.boLateDelivery)) then begin
    Inc(m_nButchCount, g_Config.nMaxButchMsgCount * 2);
    CheckSpeedCount(m_nButchCount, '挖取[多倍]');
    exit;
  end;
  if ClientSitDownHit(ProcessMsg.nParam2, ProcessMsg.nParam3, ProcessMsg.nParam1,
    ProcessMsg.wParam, ProcessMsg.boLateDelivery, dwDelayTime) then begin
    m_dwActionTick := GetTickCount();
    SendActionGood();
  end
  else begin
    if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      CheckSpeedCount(m_nButchCount, '挖取');
      SetUserTime(dwDelayTime * 2);
      if m_boTestSpeedMode then
        SysMsg(format('操作延迟 Butch Count: %d Time: %d', [m_nButchCount, dwDelayTime]), c_Red, t_Hint);
      SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
        ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3,
        '', dwDelayTime * 2);
      boResult := False;
    end;
  end;
end;

procedure TPlayObject.ClientAttack(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  dwDelayTime: LongWord;
  //  nMsgCount: Integer;
begin
  if (not m_boMapApoise) then
    exit; //如果客户端地图未准备好,不允许
  if m_boDealing then
    DealCancel();
  //设置五行活动时间
  //m_dwIsGetWuXinExpTime := GetTickCount + g_Config.dwGetWuXinExpTick;
  if (m_boHitDelay and (not ProcessMsg.boLateDelivery)) then begin
    Inc(m_nHitCount, g_Config.nMaxHitMsgCount * 2);
    CheckSpeedCount(m_nHitCount, '攻击[多倍]');
    exit;
  end;
  if ClientHitXY(ProcessMsg.wIdent {ident}, ProcessMsg.nParam1 {x},
    ProcessMsg.nParam2 {y}, ProcessMsg.wParam {dir},
    ProcessMsg.boLateDelivery, dwDelayTime) then begin
    m_dwActionTick := GetTickCount;
    SendActionGood();
    //Inc(n5F8);
  end
  else begin
    if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      //Inc(m_dwHitTime, dwDelayTime * 2);
      CheckSpeedCount(m_nHitCount, '攻击');
      SetUserTime(dwDelayTime * 2);
      m_boHitDelay := True;
      if m_boTestSpeedMode then
        SysMsg(format('操作延迟 Hit Count: %d Time: %d', [m_nHitCount, dwDelayTime]), c_Red, t_Hint);
      SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
        ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3, '',
        dwDelayTime * 2);
      boResult := False;
    end;
    (*if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      nMsgCount := GetHitMsgCount();
      if nMsgCount >= g_Config.nMaxHitMsgCount then begin
        Inc(m_nOverSpeedCount);
        if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
          if g_Config.boKickOverSpeed then begin
            SysMsg(g_sKickClientUserMsg
              {'请勿使用非法软件.'}, c_Red,
              t_Hint);
            m_boEmergencyClose := True;
            m_boPlayOffLine := False;
          end;
          if g_Config.boViewHackMessage then begin
            //MainOutMessage('[攻击超速] ' + m_sCharName + ' Time: ' + IntToStr(dwDelayTime) + ' Count: '+ IntToStr(nMsgCount));
            MainOutMessage(format(g_sHitOverSpeed, [m_sCharName,
              dwDelayTime, nMsgCount]));
          end;
        end;
        //如果超速则发送攻击失败信息
        SendActionFail();
      end
      else begin
        if (dwDelayTime > g_Config.dwDropOverSpeed) and
          (g_Config.btSpeedControlMode = 1) and m_boFilterAction then begin
          SendActionGood();
          if m_boTestSpeedMode then
            SysMsg(format('速度异常 Ident: %d Time: %d',
              [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
        end
        else begin
          if m_boTestSpeedMode then begin
            //SysMsg(format('操作延迟 Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
            SysMsg('操作延迟 Ident: ' + IntToStr(ProcessMsg.wIdent) +
              ' Time: ' + IntToStr(dwDelayTime), c_Red, t_Hint);
          end;
          SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
            ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3,
            '',
            dwDelayTime);
          boResult := False;
        end;
      end;
    end; *)
  end;
end;

procedure TPlayObject.ClientLeap(ProcessMsg: pTProcessMessage; var boResult: Boolean);
{var
  dwDelayTime: LongWord;
  nMsgCount: Integer;   }
begin
  exit;
  (*
  if not m_boMapApoise then
    exit; //如果客户端地图未准备好,不允许移动
  if ClientLeapXY(ProcessMsg.wIdent, ProcessMsg.nParam1 {x},
    ProcessMsg.nParam2 {y}, ProcessMsg.nParam3, dwDelayTime) then begin
    m_dwActionTick := GetTickCount;
    SendActionGood();
  end
  else begin
    if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      nMsgCount := GetRunMsgCount();
      if nMsgCount >= g_Config.nMaxRunMsgCount then begin
        Inc(m_nOverSpeedCount);
        if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
          if g_Config.boKickOverSpeed then begin
            SysMsg(g_sKickClientUserMsg
              {'请勿使用非法软件.'}, c_Red,
              t_Hint);
            m_boEmergencyClose := True;
            m_boPlayOffLine := False;
          end;
          if g_Config.boViewHackMessage then begin
            //MainOutMessage('[跑步超速] ' + m_sCharName + ' Time: ' + IntToStr(dwDelayTime) + ' Count: '+ IntToStr(nMsgCount));
            MainOutMessage(format(g_sRunOverSpeed, [m_sCharName,
              dwDelayTime, nMsgCount]));
          end;
        end;
        //如果超速则发送攻击失败信息
        SendActionFail();
      end
      else begin
        if (dwDelayTime > g_Config.dwDropOverSpeed) and
          (g_Config.btSpeedControlMode = 1) and m_boFilterAction then begin
          SendActionFail();
          if m_boTestSpeedMode then
            SysMsg(format('速度异常 Ident: %d Time: %d',
              [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
        end
        else begin
          if m_boTestSpeedMode then
            SysMsg(format('操作延迟 Ident: %d Time: %d',
              [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
          SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
            ProcessMsg.nParam1, ProcessMsg.nParam2, CM_RUN, '',
            dwDelayTime);
          boResult := False;
        end;
      end;
    end;
  end;        *)
end;

procedure TPlayObject.ClientRun(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  dwDelayTime: LongWord;
  //  nMsgCount: Integer;
begin
  if (not m_boMapApoise) then
    exit; //如果客户端地图未准备好,不允许移动
  if m_boDealing then
    DealCancel();
  if (m_boRunDelay and (not ProcessMsg.boLateDelivery)) then begin
    Inc(m_nRunCount, g_Config.nMaxRunMsgCount * 2);
    CheckSpeedCount(m_nRunCount, '跑步[多倍]');
    exit;
  end;

  if ClientRunXY(ProcessMsg.wIdent, ProcessMsg.nParam1 {x},
    ProcessMsg.nParam2 {y}, ProcessMsg.boLateDelivery, dwDelayTime) then begin
    m_dwActionTick := GetTickCount;
    SendActionGood();
    //Inc(n5F8);
  end
  else begin
    if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      //m_dwRunTime := GetTickCount + (g_Config.dwRunIntervalTime - dwDelayTime);
      //Inc(m_dwRunTime, dwDelayTime * 2);
      CheckSpeedCount(m_nRunCount, '跑步');
      SetUserTime(dwDelayTime * 2);
      m_boRunDelay := True;
      if m_boTestSpeedMode then
        SysMsg(format('操作延迟 Run Count: %d Time: %d', [m_nRunCount, dwDelayTime]), c_Red, t_Hint);
      SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
        ProcessMsg.nParam1, ProcessMsg.nParam2, CM_RUN, '',
        dwDelayTime * 2);
      boResult := False;
    end;
    (*nMsgCount := GetRunMsgCount();
    if nMsgCount >= g_Config.nMaxRunMsgCount then begin
      Inc(m_nOverSpeedCount);
      if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
        if g_Config.boKickOverSpeed then begin
          SysMsg(g_sKickClientUserMsg
            {'请勿使用非法软件.'}, c_Red,
            t_Hint);
          m_boEmergencyClose := True;
          m_boPlayOffLine := False;
        end;
        if g_Config.boViewHackMessage then begin
          //MainOutMessage('[跑步超速] ' + m_sCharName + ' Time: ' + IntToStr(dwDelayTime) + ' Count: '+ IntToStr(nMsgCount));
          MainOutMessage(format(g_sRunOverSpeed, [m_sCharName,
            dwDelayTime, nMsgCount]));
        end;
      end;
      //如果超速则发送攻击失败信息
      SendActionFail();
    end
    else begin
      if (dwDelayTime > g_Config.dwDropOverSpeed) and
        (g_Config.btSpeedControlMode = 1) and m_boFilterAction then begin
        SendActionFail();
        if g_Config.boViewHackMessage then
          SysMsg(format('速度异常 Ident: %d Time: %d',
            [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
      end
      else begin
        if g_Config.boViewHackMessage then
          SysMsg(format('操作延迟 Ident: %d Time: %d',
            [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
        SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
          ProcessMsg.nParam1, ProcessMsg.nParam2, CM_RUN, '',
          dwDelayTime);
        boResult := False;
      end;
    end;  *)
  //end;
  end;
end;

procedure TPlayObject.ClientHorseRun(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  dwDelayTime: LongWord;
  //  nMsgCount: Integer;
begin
  if (not m_boMapApoise) then
    exit; //如果客户端地图未准备好,不允许移动
  if m_boDealing then
    DealCancel();
  if (m_boRunDelay and (not ProcessMsg.boLateDelivery)) then begin
    Inc(m_nRunCount, g_Config.nMaxRunMsgCount * 2);
    CheckSpeedCount(m_nRunCount, '跑步[多倍]');
    exit;
  end;

  if ClientHorseRunXY(ProcessMsg.wIdent, ProcessMsg.nParam1 {x},
    ProcessMsg.nParam2 {y}, ProcessMsg.boLateDelivery, dwDelayTime) then begin
    m_dwActionTick := GetTickCount;
    SendActionGood();
    //Inc(n5F8);
  end
  else begin
    if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      //m_dwRunTime := GetTickCount + (g_Config.dwRunIntervalTime - dwDelayTime);
      //Inc(m_dwRunTime, dwDelayTime * 2);
      CheckSpeedCount(m_nRunCount, '跑步');
      SetUserTime(dwDelayTime * 2);
      m_boRunDelay := True;
      if m_boTestSpeedMode then
        SysMsg(format('操作延迟 Run Count: %d Time: %d', [m_nRunCount, dwDelayTime]), c_Red, t_Hint);
      SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
        ProcessMsg.nParam1, ProcessMsg.nParam2, CM_RUN, '',
        dwDelayTime * 2);
      boResult := False;
    end;
    (*nMsgCount := GetRunMsgCount();
    if nMsgCount >= g_Config.nMaxRunMsgCount then begin
      Inc(m_nOverSpeedCount);
      if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
        if g_Config.boKickOverSpeed then begin
          SysMsg(g_sKickClientUserMsg
            {'请勿使用非法软件.'}, c_Red,
            t_Hint);
          m_boEmergencyClose := True;
          m_boPlayOffLine := False;
        end;
        if g_Config.boViewHackMessage then begin
          //MainOutMessage('[跑步超速] ' + m_sCharName + ' Time: ' + IntToStr(dwDelayTime) + ' Count: '+ IntToStr(nMsgCount));
          MainOutMessage(format(g_sRunOverSpeed, [m_sCharName,
            dwDelayTime, nMsgCount]));
        end;
      end;
      //如果超速则发送攻击失败信息
      SendActionFail();
    end
    else begin
      if (dwDelayTime > g_Config.dwDropOverSpeed) and
        (g_Config.btSpeedControlMode = 1) and m_boFilterAction then begin
        SendActionFail();
        if g_Config.boViewHackMessage then
          SysMsg(format('速度异常 Ident: %d Time: %d',
            [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
      end
      else begin
        if g_Config.boViewHackMessage then
          SysMsg(format('操作延迟 Ident: %d Time: %d',
            [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
        SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
          ProcessMsg.nParam1, ProcessMsg.nParam2, CM_RUN, '',
          dwDelayTime);
        boResult := False;
      end;
    end;  *)
  //end;
  end;
{var
  dwDelayTime: LongWord;
  nMsgCount: Integer;
begin
  exit;         }
  (*
  if not m_boMapApoise then
    exit; //如果客户端地图未准备好,不允许移动
  if ClientHorseRunXY(ProcessMsg.wIdent, ProcessMsg.nParam1 {x},
    ProcessMsg.nParam2 {y}, ProcessMsg.boLateDelivery, dwDelayTime) then begin
    m_dwActionTick := GetTickCount;
    SendActionGood();
    //Inc(n5F8);
  end
  else begin

    if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      nMsgCount := GetRunMsgCount();
      if nMsgCount >= g_Config.nMaxRunMsgCount then begin
        Inc(m_nOverSpeedCount);
        if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
          if g_Config.boKickOverSpeed then begin
            SysMsg(g_sKickClientUserMsg
              {'请勿使用非法软件.'}, c_Red,
              t_Hint);
            m_boEmergencyClose := True;
            m_boPlayOffLine := False;
          end;
          if g_Config.boViewHackMessage then begin
            //MainOutMessage('[跑步超速] ' + m_sCharName + ' Time: ' + IntToStr(dwDelayTime) + ' Count: '+ IntToStr(nMsgCount));
            MainOutMessage(format(g_sRunOverSpeed, [m_sCharName,
              dwDelayTime, nMsgCount]));
          end;
        end;
        //如果超速则发送攻击失败信息
        SendActionFail();
        if m_boTestSpeedMode then
          SysMsg(format('速度异常 Ident: %d Time: %d',
            [ProcessMsg.wIdent,
            dwDelayTime]), c_Red, t_Hint);
      end
      else begin
        if m_boTestSpeedMode then
          SysMsg(format('操作延迟 Ident: %d Time: %d',
            [ProcessMsg.wIdent,
            dwDelayTime]), c_Red, t_Hint);
        SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
          ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3, '',
          dwDelayTime);
        boResult := False;
      end;
    end;
  end;     *)
end;

procedure TPlayObject.ClientWalk(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  dwDelayTime: LongWord;
  //  nMsgCount: Integer;
begin //如果正在发送延时消息,则过滤一切客户端来源消息
  if (not m_boMapApoise) then
    exit;
  //移动
  if m_boDealing then
    DealCancel();
  if (m_boWalkDelay and (not ProcessMsg.boLateDelivery)) then begin
    Inc(m_nWalkCount, g_Config.nMaxWalkMsgCount * 2);
    CheckSpeedCount(m_nWalkCount, '走路[多倍]');
    exit;
  end;

  if ClientWalkXY(ProcessMsg.wIdent, ProcessMsg.nParam1 {x},
    ProcessMsg.nParam2 {y}, ProcessMsg.boLateDelivery, dwDelayTime) then begin
    m_dwActionTick := GetTickCount;
    SendActionGood();
    //Inc(n5F8);
  end
  else begin
    if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      //Inc(m_dwWalkTime, dwDelayTime * 2);
      CheckSpeedCount(m_nWalkCount, '走路');
      SetUserTime(dwDelayTime * 2);
      if m_boTestSpeedMode then
        SysMsg(format('操作延迟 Walk Count: %d Time: %d', [m_nWalkCount, dwDelayTime]), c_Red, t_Hint);
      SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
        ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3,
        '', dwDelayTime * 2);
      boResult := False;
    end;
    (* nMsgCount := GetWalkMsgCount();
     if nMsgCount >= g_Config.nMaxWalkMsgCount then begin
       Inc(m_nOverSpeedCount);
       if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
         if g_Config.boKickOverSpeed then begin
           SysMsg(g_sKickClientUserMsg
             {'请勿使用非法软件.'}, c_Red,
             t_Hint);
           m_boEmergencyClose := True;
           m_boPlayOffLine := False;
         end;
         if g_Config.boViewHackMessage then begin
           //MainOutMessage('[行走超速] ' + m_sCharName + ' Time: ' + IntToStr(dwDelayTime) + ' Count: '+ IntToStr(nMsgCount));
           MainOutMessage(format(g_sWalkOverSpeed, [m_sCharName,
             dwDelayTime, nMsgCount]));
         end;
       end;
       //如果超速则发送攻击失败信息
       SendActionFail();
       if m_boTestSpeedMode then
         SysMsg(format('速度异常 Ident: %d Time: %d',
           [ProcessMsg.wIdent,
           dwDelayTime]), c_Red, t_Hint);
     end
     else begin
       if (dwDelayTime > g_Config.dwDropOverSpeed) and
         (g_Config.btSpeedControlMode = 1) and m_boFilterAction then begin
         SendActionFail();
         if m_boTestSpeedMode then
           SysMsg(format('速度异常 Ident: %d Time: %d',
             [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
       end
       else begin

         if m_boTestSpeedMode then
           SysMsg(format('操作延迟 Ident: %d Time: %d',
             [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
         SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
           ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3,
           '',
           dwDelayTime);
         boResult := False;
       end;
     end;
   end;  *)
  end;
end;

procedure TPlayObject.ClientTurn(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  dwDelayTime: LongWord;
  //  nMsgCount: Integer;
begin
  if (not m_boMapApoise) then
    exit;
  if m_boDealing then
    DealCancel();
  if (m_boTurnDelay and (not ProcessMsg.boLateDelivery)) then begin
    Inc(m_nTurnCount, g_Config.nMaxTurnMsgCount * 2);
    CheckSpeedCount(m_nTurnCount, '转向[多倍]');
    exit;
  end;

  if ClientChangeDir(ProcessMsg.wIdent, ProcessMsg.nParam1 {x},
    ProcessMsg.nParam2 {y}, ProcessMsg.wParam {dir}, ProcessMsg.boLateDelivery, dwDelayTime) then begin
    m_dwActionTick := GetTickCount;
    SendActionGood();
  end
  else begin
    if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      //Inc(m_dwTurnTime, dwDelayTime * 2);
      CheckSpeedCount(m_nTurnCount, '转向');
      SetUserTime(dwDelayTime * 2);
      if m_boTestSpeedMode then
        SysMsg(format('操作延迟 Turn Count: %d Time: %d', [m_nTurnCount, dwDelayTime]), c_Red, t_Hint);
      SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
        ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3,
        '', dwDelayTime * 2);
      boResult := False;
    end;
    (*if dwDelayTime = 0 then begin
      SendActionFail();
    end
    else begin
      nMsgCount := GetTurnMsgCount();
      if nMsgCount >= g_Config.nMaxTurnMsgCount then begin
        Inc(m_nOverSpeedCount);
        if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
          if g_Config.boKickOverSpeed then begin
            SysMsg(g_sKickClientUserMsg
              {'请勿使用非法软件.'}, c_Red,
              t_Hint);
            m_boEmergencyClose := True;
            m_boPlayOffLine := False;
          end;
          if g_Config.boViewHackMessage then begin
            //MainOutMessage('[游戏超速] ' + m_sCharName + ' Time: ' + IntToStr(dwDelayTime) + ' Count: '+ IntToStr(nMsgCount));
            MainOutMessage(format(g_sBunOverSpeed, [m_sCharName,
              dwDelayTime, nMsgCount]));
          end;
        end;
        //如果超速则发送攻击失败信息
        SendActionFail();
      end
      else begin
        if dwDelayTime < g_Config.dwDropOverSpeed then begin
          SendActionGood();
          if m_boTestSpeedMode then
            SysMsg(format('速度异常 Ident: %d Time: %d',
              [ProcessMsg.wIdent, dwDelayTime]), c_Red, t_Hint);
        end
        else begin
          SendDelayMsg(Self, ProcessMsg.wIdent, ProcessMsg.wParam,
            ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3,
            '',
            dwDelayTime);
          boResult := False;
        end;
      end;
    end;*)
  end;
end;

procedure TPlayObject.ClientGuildBreakAlly(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  n10: Integer;
  i: integer;
  Guild, Guild2: TGuild;
  sSENDMSG: string;
begin
  //  n10 := -1;
  if not IsGuildMaster() then
    Exit;
  Guild := g_GuildManager.FindGuild(ProcessMsg.sMsg);
  if (Guild <> nil) and (m_MyGuild <> nil) then begin
    if TGuild(m_MyGuild).IsAllyGuild(Guild) then begin
      TGuild(m_MyGuild).DelAllyGuild(Guild);
      Guild.DelAllyGuild(TGuild(m_MyGuild));
      TGuild(m_MyGuild).SendGuildMsg(Guild.m_sGuildName + ' 与您行会联盟解除成功.');
      Guild.SendGuildMsg(TGuild(m_MyGuild).m_sGuildName + ' 解除了与您行会的联盟.');
      TGuild(m_MyGuild).RefMemberName();
      Guild.RefMemberName();

      Guild := TGuild(m_MyGuild);
      sSENDMSG := '#1/';
      for i := 0 to Guild.m_GuildAllList.Count - 1 do begin
        if Length(sSENDMSG) > 3000 then
          break;
        Guild2 := TGuild(Guild.m_GuildAllList.Objects[i]);
        if Guild2 <> nil then begin
          sSENDMSG := sSENDMSG + Guild.m_GuildAllList[i] + '/' + Guild2.GetChiefName + '/' + IntToStr(Guild2.btLevel) + '/';
        end;
      end;
      sSENDMSG := sSENDMSG + '#2/';
      for i := 0 to Guild.m_GuildWarList.Count - 1 do begin
        if Length(sSENDMSG) > 3000 then
          break;
        Guild2 := TGuild(pTWarGuild(Guild.m_GuildWarList.Objects[i]).Guild);
        if Guild2 <> nil then begin
          sSENDMSG := sSENDMSG + Guild.m_GuildWarList[i] + '/' + Guild2.GetChiefName + '/' + IntToStr(Guild2.btLevel) + '/';
        end;
      end;
      m_DefMsg := MakeDefaultMsg(SM_OPENGUILDDLG, Guild.m_GuildIndex, Guild.m_UpSocietyIndex, 0, 3);
      SendSocket(@m_DefMsg, EncodeString(sSENDMSG));

      n10 := 0;
    end
    else
      n10 := -2;
  end
  else
    n10 := -3;
  if n10 = 0 then begin
    //SendDefMessage(SM_GUILDBREAKALLY_OK, 0, 0, 0, 0, '');
  end
  else begin
    SendDefMessage(SM_GUILDBREAKALLY_FAIL, 0, 0, 0, 0, '');
  end;
end;

procedure TPlayObject.ClientGetSayItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  UserItem: pTUserItem;
  nID, ItemIndex: Integer;
begin
  nID := ProcessMsg.nParam2;
  ItemIndex := ProcessMsg.nParam1;
  UserItem := GetSayitem(nID);
  if (UserItem <> nil) and (UserItem.MakeIndex = ItemIndex) then begin
    m_DefMsg := MakeDefaultMsg(SM_GETSAYITEM, ItemIndex, nID, 0, 0);
    SendSocket(@m_DefMsg, MakeClientItem(UserItem));
  end;
end;

procedure TPlayObject.ClientUniteItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  UserItem, UserItem32, UserItemMaster, AddUserItem: pTUserItem;
  i, nDura, nMaxDura: integer;
  boUniteOK: Boolean;
  nCount: Integer;
  StdItem: pTStdItem;
  nMasterIndex, nUniteIndex: Integer;
  btUnite: Byte;
begin
  nMasterIndex := ProcessMsg.nParam1;
  nUniteIndex := MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3);
  btUnite := ProcessMsg.wParam;
  if btUnite = 0 then begin
    if (nUniteIndex > 0) and (IsEnoughBag) then begin
      for I := 0 to m_ItemList.Count - 1 do begin
        UserItem := m_ItemList[i];
        if (UserItem <> nil) and (UserItem.MakeIndex = nMasterIndex) then begin
          if (UserItem.Dura > nUniteIndex) then begin
            Stditem := UserEngine.GetStdItem(UserItem.wIndex);
            if (Stditem <> nil) and (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
              New(UserItem32);
              UserItem32^ := UserItem^;
              UserItem32.MakeIndex := GetItemNumber();
              UserItem32.Dura := nUniteIndex;
              if AddItemToBag(UserItem32, Stditem, False, '', '', AddUserItem) = 2 then begin
                Dec(UserItem.Dura, nUniteIndex);
                if (Stditem.NeedIdentify = 1) then begin
                  AddGameLog(Self, LOG_ITEMDURACHANGE, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, '0',
                    '-', IntToStr(nUniteIndex), '拆分', UserItem);
                  AddGameLog(Self, LOG_ADDITEM, Stditem.Name, UserItem32.MakeIndex, UserItem32.Dura, '0',
                    '0', '0', '拆分', UserItem32);
                end;
                m_DefMsg := MakeDefaultMsg(SM_CHANGEITEMDURA_OK, nMasterIndex, UserItem.Dura, UserItem.DuraMax,
                  btUnite);
                SendSocket(@m_DefMsg, MakeClientItem(UserItem32));
                exit;
              end
              else
                Dispose(UserItem32);
            end;
          end;
          break;
        end;
      end;
    end;
    SendDefMessage(SM_CHANGEITEMDURA_FAIL, 0, 0, 0, btUnite, '');
  end
  else begin
    UserItemMaster := nil;
    UserItem32 := nil;
    nDura := 0;
    nMaxDura := 0;
    nCount := 0;
    boUniteOK := False;
    for I := m_ItemList.Count - 1 downto 0 do begin
      UserItem := m_ItemList[i];
      if (UserItem <> nil) and (UserItem.MakeIndex = nMasterIndex) then begin
        UserItemMaster := UserItem;
        m_ItemList.Delete(I);
      end
      else if (UserItem <> nil) and (UserItem.MakeIndex = nUniteIndex) then begin
        UserItem32 := UserItem;
        m_ItemList.Delete(I);
      end;
      if (UserItem32 <> nil) and (UserItemMaster <> nil) then
        break;
    end;
    if (UserItem32 <> nil) and (UserItemMaster <> nil) and
      (UserItem32.wIndex = UserItemMaster.wIndex) and (UserItemMaster.DuraMax > 1) and
      (UserItem32.btBindMode1 = UserItemMaster.btBindMode1) and
      (UserItem32.btBindMode2 = UserItemMaster.btBindMode2) then begin
      StdItem := UserEngine.GetStdItem(UserItemMaster.wIndex);
      if (Stditem <> nil) and (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
        if ((UserItem32.Dura + UserItemMaster.Dura) <= UserItemMaster.DuraMax) then begin
          Inc(UserItemMaster.Dura, UserItem32.Dura);
          nDura := UserItemMaster.Dura;
          nMaxDura := UserItemMaster.DuraMax;
          if (Stditem.NeedIdentify = 1) then begin
            AddGameLog(Self, LOG_ITEMDURACHANGE, Stditem.Name, UserItemMaster.MakeIndex, UserItemMaster.Dura, '0',
              '+', IntToStr(UserItem32.Dura), '合并', UserItemMaster);
            AddGameLog(Self, LOG_DELITEM, Stditem.Name, UserItem32.MakeIndex, UserItem32.Dura, '0',
              '0', '0', '合并', UserItem32);
          end;
          Dispose(UserItem32);
          UserItem32 := nil;
          boUniteOK := True;
        end
        else begin
          nCount := UserItemMaster.DuraMax - UserItemMaster.Dura;
          if (nCount > 0) and (nCount < UserItem32.Dura) then begin
            UserItemMaster.Dura := UserItemMaster.DuraMax;
            nDura := UserItemMaster.Dura;
            Dec(UserItem32.Dura, nCount);
            if (Stditem.NeedIdentify = 1) then begin
              AddGameLog(Self, LOG_ITEMDURACHANGE, Stditem.Name, UserItem32.MakeIndex, UserItem32.Dura, '0',
                '-', IntToStr(nCount), '合并', UserItem32);
              AddGameLog(Self, LOG_ITEMDURACHANGE, Stditem.Name, UserItemMaster.MakeIndex, UserItemMaster.Dura, '0',
                '+', IntToStr(nCount), '合并', UserItemMaster);
            end;
            nCount := UserItem32.Dura;
          end
          else
            nCount := 0;
        end;
      end;
    end;
    if UserItem32 <> nil then
      m_ItemList.Add(UserItem32);
    if UserItemMaster <> nil then
      m_ItemList.Add(UserItemMaster);
    if boUniteOK then
      SendDefMessage(SM_CHANGEITEMDURA_OK, nMasterIndex, nDura, nMaxDura, btUnite, '')
    else
      SendDefMessage(SM_CHANGEITEMDURA_FAIL, nMasterIndex, nCount, nDura, btUnite, '');
  end;
end;

procedure TPlayObject.ServerCreateGuild(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  sGuildName: string;
  nCode: Integer;
  UserItem: pTUserItem;
begin
  GetValidStr3(ProcessMsg.sMsg, sGuildName, ['/']);
  if (sGuildName <> '') then begin
    UserItem := nil;
    if not (length(sGuildName) in [6..14]) then begin
      nCode := -5;
    end
    else if not CheckCorpsChr(sGuildName) then begin
      nCode := -4;
    end
    else if CheckFilterGuild(sGuildName) then begin
      nCode := -7;
    end else
      nCode := 0;
    if (nCode = 0) then begin
      if m_MyGuild = nil then begin
        if m_nGold >= g_Config.nBuildGuildPrice then begin
          UserItem := CheckItems(g_Config.sWomaHorn);
          if UserItem = nil then begin
            nCode := -3; //'你没有准备好需要的全部物品。'
          end;
        end
        else
          nCode := -2; //'缺少创建费用。'
      end
      else
        nCode := -1; //'您已经加入其它行会。'
    end;
    if (nCode = 0) then begin
      if g_GuildManager.AddGuild(sGuildName, Self) then begin
        if UserItem <> nil then begin
          SendDelItems(UserItem);
          DelBagItem(UserItem.MakeIndex, g_Config.sWomaHorn);
        end;
        DecGold(g_Config.nBuildGuildPrice);
        GoldChanged();
        m_MyGuild := g_GuildManager.MemberOfGuild(m_sCharName, sGuildName);
        if m_MyGuild <> nil then begin
          TGuild(m_MyGuild).MemberLogin(Self);
          m_sGuildName := TGuild(m_MyGuild).m_sGuildName;
          RefShowName();
        end;
        SendDefMessage(SM_BUILDGUILD_OK, 0, 0, 0, 0, '');
        exit;
      end
      else
        nCode := -6;
    end;
  end
  else
    nCode := -6;
  SendDefMessage(SM_BUILDGUILD_FAIL, nCode, 0, 0, 0, '');
end;

{执行杀怪触发}

function TPlayObject.KillMonsterFunc(BaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if BaseObject <> nil then begin
    m_sString[0] := BaseObject.m_sCharName;
    m_nInteger[0] := BaseObject.m_Abil.Level;
    NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[nKillMonster], False);
    Result := True;
  end;
end;

procedure TPlayObject.PKDie(PlayObject: TPlayObject);
var
  nWinLevel, nLostLevel, nWinExp, nLostExp: Integer;
  boWinLEvel, boLostLevel, boWinExp, boLostExp: Boolean;
begin
  nWinLevel := g_Config.nKillHumanWinLevel;
  nLostLevel := g_Config.nKilledLostLevel;
  nWinExp := g_Config.nKillHumanWinExp;
  nLostExp := g_Config.nKillHumanLostExp;

  boWinLEvel := g_Config.boKillHumanWinLevel;
  boLostLevel := g_Config.boKilledLostLevel;
  boWinExp := g_Config.boKillHumanWinExp;
  boLostExp := g_Config.boKilledLostExp;

  if m_PEnvir.m_boPKWINLEVEL then begin
    boWinLEvel := True;
    nWinLevel := m_PEnvir.m_nPKWINLEVEL;
  end;
  if m_PEnvir.m_boPKLOSTLEVEL then begin
    boLostLevel := True;
    nLostLevel := m_PEnvir.m_nPKLOSTLEVEL;
  end;
  if m_PEnvir.m_boPKWINEXP then begin
    boWinExp := True;
    nWinExp := m_PEnvir.m_nPKWINEXP;
  end;
  if m_PEnvir.m_boPKLOSTEXP then begin
    boLostExp := True;
    nLostExp := m_PEnvir.m_nPKLOSTEXP;
  end;

  if PlayObject.m_Abil.Level - m_Abil.Level > g_Config.nHumanLevelDiffer then begin
    if not PlayObject.IsGoodKilling(Self) then begin
      PlayObject.IncPkPoint(g_Config.nKillHumanAddPKPoint {100});
      PlayObject.SysMsg(g_sYouMurderedMsg {'你犯了谋杀罪.'}, c_Red, t_Hint);
      SysMsg(format(g_sYouKilledByMsg, [m_LastHiter.m_sCharName]), c_Red, t_Hint);
      PlayObject.AddBodyLuck(-g_Config.nKillHumanDecLuckPoint {500});
      if PKLevel < 1 then
        if Random(5) = 0 then
          PlayObject.MakeWeaponUnlock;
    end
    else begin
      PlayObject.SysMsg(g_sYouProtectedByLawOfDefense {'[你受到正当规则保护。]'}, c_Green, t_Hint);
    end;
    Exit;
  end;
  if boWinLEvel then begin
    if PlayObject.m_Abil.Level + nWinLevel <= MAXUPLEVEL then begin
      Inc(PlayObject.m_Abil.Level, nWinLevel);
    end
    else begin
      PlayObject.m_Abil.Level := MAXUPLEVEL;
    end;
    PlayObject.HasLevelUp(PlayObject.m_Abil.Level - nWinLevel);
  end;
  if boLostLevel then begin
    if PKLevel >= 2 then begin
      if m_Abil.Level > nLostLevel * 2 then
        Dec(m_Abil.Level, nLostLevel * 2)
      else
        m_Abil.Level := 1;
    end
    else begin
      if m_Abil.Level > nLostLevel then
        Dec(m_Abil.Level, nLostLevel)
      else
        m_Abil.Level := 1;
    end;
    HasLevelUp(m_Abil.Level - nLostLevel);
  end;

  if boWinExp then begin
    PlayObject.WinExp(nWinExp);
  end;

  if boLostExp then begin
    if m_Abil.Exp >= LongWord(nLostExp) then begin
      Dec(m_Abil.Exp, LongWord(nLostExp));
    end
    else begin
      if m_Abil.Level > 1 then begin
        Dec(m_Abil.Level);
        Inc(m_Abil.Exp, GetLevelExp(m_Abil.Level));
        if m_Abil.Exp >= LongWord(nLostExp) then begin
          Dec(m_Abil.Exp, LongWord(nLostExp));
        end
        else begin
          m_Abil.Exp := 0;
        end;
      end
      else begin
        m_Abil.Level := 1;
        m_Abil.Exp := 0;
      end;
      HasLevelUp(m_Abil.Level + 1);
    end;
  end;
end;

//触发函数

function TPlayObject.DieGotoLable(): Boolean;
begin
  Result := False;
  m_sDieMap := m_sMapName;
  m_nDieX := m_nCurrX;
  m_nDieY := m_nCurrY;
  if (m_LastHiter <> nil) and (m_btRaceServer = RC_PLAYOBJECT) then begin
    if m_LastHiter.m_Master <> nil then begin
      if m_LastHiter.m_Master.m_btRaceServer = RC_PLAYOBJECT then begin
        m_sString[0] := TPlayObject(m_LastHiter.m_Master).m_sCharName;
        m_nInteger[0] := TPlayObject(m_LastHiter.m_Master).m_WAbil.Level;
        TPlayObject(m_LastHiter.m_Master).m_sString[0] := m_sCharName;
        TPlayObject(m_LastHiter.m_Master).m_nInteger[0] := m_WAbil.Level;
        TPlayObject(m_LastHiter.m_Master).KillPlayFunc;
      end;
    end
    else if m_LastHiter.m_btRaceServer = RC_PLAYOBJECT then begin
      m_sString[0] := TPlayObject(m_LastHiter).m_sCharName;
      m_nInteger[0] := TPlayObject(m_LastHiter).m_WAbil.Level;
      TPlayObject(m_LastHiter).m_sString[0] := m_sCharName;
      TPlayObject(m_LastHiter).m_nInteger[0] := m_WAbil.Level;
      TPlayObject(m_LastHiter).KillPlayFunc;
    end;
    if m_LastHiter.m_btRaceServer <> RC_PLAYOBJECT then begin
      m_sString[0] := m_LastHiter.m_sCharName;
      m_nInteger[0] := m_LastHiter.m_WAbil.Level;
    end;
    Result := DieFunc(); //死亡触发
  end;
end;

//解散队伍

function TPlayObject.CancelGroup: Boolean;
{resourcestring
  sCanceGrop = '你的小组被解散了.';       }
begin
  Result := True;
  if m_GroupMembers.Count <= 1 then begin
    //SendGroupText(sCanceGrop);
    m_GroupMembers.Clear;
    m_GroupOwner := nil;
    Result := False;
  end;
end;

procedure TPlayObject.SendRefGroupMsg(BaseObject: TPlayObject; wIdent: Word;
  nRecog: Integer; nParam, nTag, nSeries: Word; sMsg: string);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  if (m_GroupOwner <> nil) and (BaseObject <> nil) and (m_GroupOwner.m_GroupMembers.Count > 0) then
    for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
      PlayObject := TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
      if (PlayObject <> BaseObject) and
        ((BaseObject.m_PEnvir <> m_PEnvir) or
        (Abs(BaseObject.m_nCurrX - PlayObject.m_nCurrX) > g_Config.nSendRefMsgRange) or
        (Abs(BaseObject.m_nCurrY - PlayObject.m_nCurrY) > g_Config.nSendRefMsgRange)) then begin
        if wident = SM_GROUPINFO2 then begin
          PlayObject.SendDefMsg(BaseObject, wIdent,
            Integer(BaseObject),
            BaseObject.m_Abil.Level,
            0,
            BaseObject.m_WAbil.MaxMP, '');
        end
        else
          PlayObject.SendDefMsg(BaseObject, wIdent, nRecog, nParam, nTag, nSeries, sMsg);
      end;
    end;
end;

procedure TPlayObject.SendGroupMsg(BaseObject: TPlayObject; wIdent: Word;
  nRecog: Integer; nParam, nTag, nSeries: Word; sMsg: string);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  if (m_GroupOwner <> nil) and (m_GroupOwner.m_GroupMembers.Count > 0) then
    for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
      PlayObject := TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
      if PlayObject <> BaseObject then begin
        if wident = SM_GROUPINFO2 then begin
          PlayObject.SendDefMsg(BaseObject,
            wIdent,
            Integer(BaseObject),
            BaseObject.m_Abil.Level,
            0,
            BaseObject.m_WAbil.MaxMP, '');
        end
        else
          PlayObject.SendDefMsg(BaseObject, wIdent, nRecog, nParam, nTag, nSeries, sMsg);
      end;
    end;
end;

procedure TPlayObject.SendGroupSocket(BaseObject: TPlayObject; wIdent: Word;
  nRecog: Integer; nParam, nTag, nSeries: Word; sMsg: string);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  if (m_GroupOwner <> nil) and (m_GroupOwner.m_GroupMembers.Count > 0) then
    for i := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
      PlayObject := TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
      if PlayObject <> BaseObject then begin
        PlayObject.SendDefSocket(BaseObject, wIdent, nRecog, nParam, nTag,
          nSeries, sMsg);
      end;
    end;
end;

procedure TPlayObject.SendGroupMembers(BaseObject: TPlayObject);
var
  i: Integer;
  PlayObject: TPlayObject;
  sSENDMSG: string;
  ClientGroup: TClientGroup;
begin
  sSENDMSG := '';
  for i := 0 to m_GroupMembers.Count - 1 do begin
    PlayObject := TPlayObject(m_GroupMembers.Objects[i]);
    if PlayObject <> nil then begin
      ClientGroup.UserID := Integer(PlayObject);
      ClientGroup.UserName := PlayObject.m_sCharName;
      ClientGroup.WuXin := PlayObject.m_btWuXin;
      //ClientGroup.WuXinLevel := PlayObject.m_btWuXinLevel;
      ClientGroup.Level := PlayObject.m_Abil.Level;
      ClientGroup.HP := PlayObject.m_WAbil.HP;
      ClientGroup.MP := PlayObject.m_WAbil.MP;
      ClientGroup.MaxHP := PlayObject.m_WAbil.MaxHP;
      ClientGroup.MaxMP := PlayObject.m_WAbil.MaxMP;
      ClientGroup.btJob := PlayObject.m_btJob;
      ClientGroup.btSex := PlayObject.m_btGender;
      //ClientGroup.NameColor := GetCharColor(PlayObject);
      sSENDMSG := sSENDMSG + EncodeBuffer(@ClientGroup, SizeOf(ClientGroup)) + '/';
    end;
  end;
  if BaseObject = nil then begin
    for i := 0 to m_GroupMembers.Count - 1 do begin
      PlayObject := TPlayObject(m_GroupMembers.Objects[i]);
      if PlayObject <> nil then
        PlayObject.SendDefMessage(SM_GROUPMEMBERS, Integer(m_GroupClass), 0, 0,
          0, sSENDMSG);
    end;
  end
  else begin
    BaseObject.SendDefMessage(SM_GROUPMEMBERS, Integer(m_GroupClass), 0, 0, 0,
      sSENDMSG);
  end;
end;

function TPlayObject.GetMagicInfo(sMagicName: string): pTUserMagic;
var
  UserMagic: pTUserMagic;
  I: Integer;
begin
  Result := nil;
  for i := m_MagicList.Count - 1 downto 0 do begin
    UserMagic := m_MagicList.Items[i];
    if UserMagic <> nil then begin
      if CompareText(UserMagic.MagicInfo.sMagicName, sMagicName) = 0 then begin
        Result := UserMagic;
        Break;
      end;
    end;
  end;
end;

function TPlayObject.GetMagicInfo(nMagicID: Integer): pTUserMagic;
begin
  Result := nil;
  if (nMagicID > 0) and (nMagicID < SKILL_MAX) then
    Result := m_MagicArr[nMagicID];
end;

function TPlayObject.CanMotaebo(BaseObject: TBaseObject; nMagicLevel: Integer):
  Boolean;
var
  nC: Integer;
begin
  Result := False;
  if (m_Abil.Level > BaseObject.m_Abil.Level) and (not BaseObject.m_boStickMode) then begin
    nC := m_Abil.Level - BaseObject.m_Abil.Level;
    if Random(20) < ((nMagicLevel * 4) + 6 + nC) then begin
      if IsProperTarget(BaseObject) then
        Result := True;
    end;
  end;
end;

function TPlayObject.DoMotagecbo(nDir: Byte; nMagicLevel: Integer): Boolean;
var
  n20: Integer;
  PoseCreate: TBaseObject;
  nX, nY, nPower: Integer;
label
  NoMotage;
begin
  Result := False;
  m_btDirection := nDir;
  n20 := 0;
  PoseCreate := GetPoseCreate();
  if PoseCreate <> nil then begin
    if not CanMotaebo(PoseCreate, nMagicLevel) then
      goto NoMotage;

    if not CanMotaebo(PoseCreate, 3) then
      goto NoMotage;

    if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, nX, nY) then begin
      if (m_PEnvir.GetMovingObject(nX, nY, True) <> nil) then begin
        goto NoMotage;
      end;
    end;
    n20 := PoseCreate.CharPushedcbo(m_btDirection, 3);
    if n20 = 0 then
      goto NoMotage;
    PoseCreate.SendRefMsg(RM_PUSH, PoseCreate.m_btDirection, PoseCreate.m_nCurrX, PoseCreate.m_nCurrY, n20, '');
    n20 := CharPushedcbo(m_btDirection, n20);
    m_btDirection := nDir;
    if n20 > 0 then begin
      Result := True;
    end;
  end
  else begin //004C32E8 if PoseCreate <> nil  then begin
    n20 := CharPushedcbo(m_btDirection, 3);
    m_btDirection := nDir;
    if n20 > 0 then begin
      Result := True;
    end;
  end;
  NoMotage:
  if (PoseCreate <> nil) and IsProperTarget(PoseCreate) then begin
    nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
    nPower := ROUND(nPower / (5) * (nMagicLevel + 2));
    nPower := PoseCreate.GetHitStruckDamage(Self, nPower);
    if nPower > 0 then begin
      PoseCreate.StruckDamage(nPower, Self);
      PoseCreate.SendDelayMsg(TBaseObject(RM_STRUCK),
        RM_10101,
        nPower,
        PoseCreate.m_WAbil.HP,
        PoseCreate.m_WAbil.MaxHP,
        Integer(Self),
        '', 300);
      if PoseCreate.m_btRaceServer <> RC_PLAYOBJECT then begin
        PoseCreate.SendMsg(PoseCreate,
          RM_STRUCK,
          nPower,
          PoseCreate.m_WAbil.HP,
          PoseCreate.m_WAbil.MaxHP,
          Integer(Self),
          '');
      end;
    end;
  end;
  SendRefMsg(RM_RUSHCBO, nDir, m_nCurrX, m_nCurrY, n20, '');
end;

function TPlayObject.DoMotaebo(nDir: Byte; nMagicLevel: Integer): Boolean;
var
  bo35: Boolean;
  i, n20, n24, n28: Integer;
  PoseCreate: TBaseObject;
  BaseObject_30: TBaseObject;
  BaseObject_34: TBaseObject;
  nX, nY: Integer;
begin
  Result := False;
  bo35 := True;
  m_btDirection := nDir;
  BaseObject_34 := nil;
  n24 := nMagicLevel + 1;
  n28 := n24;
  PoseCreate := GetPoseCreate();
  if PoseCreate <> nil then begin
    for i := 0 to _MAX(2, nMagicLevel + 1) do begin
      PoseCreate := GetPoseCreate();
      if PoseCreate <> nil then begin
        n28 := 0;
        if not CanMotaebo(PoseCreate, nMagicLevel) then
          break;
        if nMagicLevel >= 3 then begin
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, nX, nY) then begin
            BaseObject_30 := m_PEnvir.GetMovingObject(nX, nY, True);
            if (BaseObject_30 <> nil) and CanMotaebo(BaseObject_30, nMagicLevel) then
              BaseObject_30.CharPushed(m_btDirection, 1);
          end;
        end;
        BaseObject_34 := PoseCreate;
        if PoseCreate.CharPushed(m_btDirection, 1) <> 1 then
          break;
        GetFrontPosition(nX, nY);
        if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False) > 0 then begin
          m_nCurrX := nX;
          m_nCurrY := nY;
          GetStartType();
          SendRefMsg(RM_RUSH, nDir, m_nCurrX, m_nCurrY, 0, '');
          bo35 := False;
          Result := True;
        end;
        Dec(n24);
      end; //004C32D7  if PoseCreate <> nil  then begin
    end; //004C32DD for i:=0 to _MAX(2,nMagicLevel + 1) do begin
  end
  else begin //004C32E8 if PoseCreate <> nil  then begin
    bo35 := False;
    for i := 0 to _MAX(2, nMagicLevel + 1) do begin
      GetFrontPosition(nX, nY); //sub_004B2790
      if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False) > 0 then begin
        m_nCurrX := nX;
        m_nCurrY := nY;
        GetStartType();
        SendRefMsg(RM_RUSH, nDir, m_nCurrX, m_nCurrY, 0, '');
        Dec(n28);
      end
      else begin
        if m_PEnvir.CanWalk(nX, nY, True) then
          n28 := 0
        else begin
          bo35 := True;
          break;
        end;
      end;
    end;
  end;
  if (BaseObject_34 <> nil) then begin
    if n24 < 0 then
      n24 := 0;
    n20 := Random((n24 + 1) * 10) + ((n24 + 1) * 10);
    n20 := BaseObject_34.GetHitStruckDamage(Self, n20);
    BaseObject_34.StruckDamage(n20, Self);
    BaseObject_34.SendRefMsg(RM_STRUCK, n20, BaseObject_34.m_WAbil.HP,
      BaseObject_34.m_WAbil.MaxHP, Integer(Self), '');
    if BaseObject_34.m_btRaceServer <> RC_PLAYOBJECT then begin
      BaseObject_34.SendMsg(BaseObject_34, RM_STRUCK, n20,
        BaseObject_34.m_WAbil.HP, BaseObject_34.m_WAbil.MaxHP, Integer(Self), '');
    end;
  end;
  if bo35 then begin
    GetFrontPosition(nX, nY);
    SendRefMsg(RM_RUSHKUNG, m_btDirection, nX, nY, 0, '');
    SysMsg(sMateDoTooweak {冲撞力不够.}, c_Red, t_Hint);
  end;
  if n28 > 0 then begin
    if n24 < 0 then
      n24 := 0;
    n20 := Random(n24 * 10) + ((n24 + 1) * 3);
    n20 := GetHitStruckDamage(Self, n20);
    StruckDamage(n20, Self);
    SendRefMsg(RM_STRUCK, n20, m_WAbil.HP, m_WAbil.MaxHP, 0, '');
  end;
end;

//使用技能

function TPlayObject.DoSpell(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; BaseObject: TBaseObject): Boolean;
var
  nSpellPoint: Integer;
begin
  Result := False;
  try
    nSpellPoint := GetSpellPoint(UserMagic);
    //MainOutMessage('1: ' + IntToStr(m_WAbil.MP));
    if nSpellPoint > 0 then begin
      if m_WAbil.MP < nSpellPoint then
        Exit;
      DamageSpell(nSpellPoint);
      HealthSpellChanged();
    end;
    //MainOutMessage('2: ' + IntToStr(m_WAbil.MP));
    Result := MagicManager.DoSpell(Self, UserMagic, nTargetX, nTargetY, BaseObject);
    AttackJump;
  except
    on E: Exception do begin
      MainOutMessage(format('[Exception] TPlayObject.DoSpell MagID:%d X:%d Y:%d',
        [UserMagic.wMagIdx, nTargetX, nTargetY]));
      MainOutMessage(E.Message);
    end;
  end;
end;

//挖矿

function TPlayObject.PileStones(nX, nY: Integer): Boolean;
var
  //Event: TEvent;
  PileEvent: TEvent;
  s1C: string;
begin
  Result := False;
  s1C := '';
  //Event := TEvent(m_PEnvir.GetEvent(nX, nY));
  //if (Event <> nil) and (Event.m_nEventType = ET_STONEMINE) then begin
  if m_PEnvir.m_boMINE and (m_nMineCount > 0) then begin
    Dec(m_nMineCount);
    if Random(g_Config.nMakeMineHitRate {4}) = 0 then begin
      PileEvent := TEvent(m_PEnvir.GetEvent(m_nCurrX, m_nCurrY));
      if PileEvent = nil then begin
        PileEvent := TPileStones.Create(m_PEnvir, m_nCurrX, m_nCurrY, ET_PILESTONES, 5 * 60 * 1000);
        g_EventManager.AddEvent(PileEvent);
      end
      else begin
        if PileEvent.m_nEventType = ET_PILESTONES then
          TPileStones(PileEvent).AddEventParam;
      end;
      if Random(g_Config.nMakeMineRate {12}) = 0 then begin
        MakeMine();
      end;
      s1C := '1';
      DoDamageWeapon(Random(15) + 5);
      Result := True;
    end;
    {end
    else begin
      if (GetTickCount - TStoneMineEvent(Event).m_dwAddStoneMineTick) > 10 * 60 * 1000 then
        TStoneMineEvent(Event).AddStoneMine(); }
  end;
  //end;
  SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, SM_HEAVYHIT, s1C);
end;

procedure TPlayObject.SendDelItemList(ItemList: TStringList);
var
  i: Integer;
  s10: string;
begin
  s10 := '';
  for i := 0 to ItemList.Count - 1 do begin
    s10 := s10 + ItemList.Strings[i] + '/' + IntToStr(Integer(ItemList.Objects[i])) + '/';
  end;
  m_DefMsg := MakeDefaultMsg(SM_DELITEMS, 0, 0, 0, ItemList.Count);
  SendSocket(@m_DefMsg, EncodeString(s10));
end;

procedure TPlayObject.SendDelItems(UserItem: pTUserItem);
begin
  m_DefMsg := MakeDefaultMsg(SM_DELITEM, Useritem.MakeIndex, UserItem.wIndex, 0, 0);
  SendSocket(@m_DefMsg, '');
end;

procedure TPlayObject.SendUpdateItem(UserItem: pTUserItem);
begin
  m_DefMsg := MakeDefaultMsg(SM_UPDATEITEM, Integer(Self), 0, 0, 1);
  SendSocket(@m_DefMsg, UserEngine.MakeClientItem(UserItem));
end;

function TPlayObject.CheckTakeOnItems(nWhere: Integer; StdItem: pTStdItem; UserItem: pTUserItem): Boolean;
begin
  Result := False;
{$IF Var_Free = 1}
  if nWhere = U_House then begin
    //免费版无法使用坐骑功能！
    SysMsg(frmMain.enmsg.DecryptStr('6eurQ1pkbOyZIRyY0SbI0xSEOKoQNW7PozjYRGBTBxTNBTi7'), c_Red, t_Hint); //enmsg
    exit;
  end;
{$IFEND}
  if CheckItemBindMode(UserItem, bm_Unknown) then begin
    SysMsg('未开光装备不允许穿戴，请找锻造师开光！', c_Red, t_Hint);
    exit;
  end;
  if nWhere in [16..20] then begin
    if m_UseItems[U_House].wIndex > 0 then begin
      case StdItem.Need of
        0: begin
            if m_UseItems[U_House].btLevel >= StdItem.NeedLevel then begin
              Result := True;
            end
            else begin
              SysMsg('坐骑等级不够，无法装备！', c_Red, t_Hint);
            end;
          end;
      end;
    end else
      SysMsg('必需先配戴马牌后才能给坐骑装备物品！', c_Red, t_Hint);
  end else begin
    if (StdItem.StdMode2 = 10) and (m_btGender <> 0) then begin
      SysMsg(sWearNotOfWoMan, c_Red, t_Hint);
      Exit;
    end;
    if (StdItem.StdMode2 = 11) and (m_btGender <> 1) then begin
      SysMsg(sWearNotOfMan, c_Red, t_Hint);
      Exit;
    end;
    if (nWhere = 1) or (nWhere = 2) then begin
      if StdItem.Weight > m_WAbil.MaxHandWeight then begin
        SysMsg(sHandWeightNot, c_Red, t_Hint);
        Exit;
      end;
    end
    else begin
      if (StdItem.Weight + GetUserItemWeitht(nWhere)) > m_WAbil.MaxWearWeight then begin
        SysMsg(sWearWeightNot, c_Red, t_Hint);
        Exit;
      end;
    end;
    case StdItem.Need of
      0: begin
          if m_Abil.Level >= StdItem.NeedLevel then begin
            Result := True;
          end
          else begin
            SysMsg(g_sLevelNot, c_Red, t_Hint);
          end;
        end;
      10: begin
          if (m_btJob = LoWord(StdItem.NeedLevel)) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sJobNot, c_Red, t_Hint);
          end;
          if Result then begin
            if (m_Abil.Level < HiWord(StdItem.NeedLevel)) then begin
              Result := False;
              SysMsg(g_sLevelNot, c_Red, t_Hint);
            end;
          end;
        end;
      1: begin
          if HiWord(m_WAbil.DC) >= StdItem.NeedLevel then begin
            Result := True;
          end
          else begin
            SysMsg(g_sDCNot, c_Red, t_Hint);
          end;
        end;
      11: begin
          if (m_btJob = LoWord(StdItem.NeedLevel)) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sJobNot, c_Red, t_Hint);
          end;
          if Result then begin
            if (HiWord(m_WAbil.DC) < HiWord(StdItem.NeedLevel)) then begin
              Result := False;
              SysMsg(g_sDCNot, c_Red, t_Hint);
            end;
          end;
        end;
      2: begin
          if HiWord(m_WAbil.MC) >= StdItem.NeedLevel then begin
            Result := True;
          end
          else begin
            SysMsg(g_sMCNot, c_Red, t_Hint);
          end;
        end;
      12: begin
          if (m_btJob = LoWord(StdItem.NeedLevel)) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sJobNot, c_Red, t_Hint);
          end;
          if Result then begin
            if (HiWord(m_WAbil.MC) < HiWord(StdItem.NeedLevel)) then begin
              Result := False;
              SysMsg(g_sMCNot, c_Red, t_Hint);
            end;
          end;
        end;
      3: begin
          if HiWord(m_WAbil.SC) >= StdItem.NeedLevel then begin
            Result := True;
          end
          else begin
            SysMsg(g_sSCNot, c_Red, t_Hint);
          end;
        end;
      13: begin
          if (m_btJob = LoWord(StdItem.NeedLevel)) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sJobNot, c_Red, t_Hint);
          end;
          if Result then begin
            if (HiWord(m_WAbil.SC) < HiWord(StdItem.NeedLevel)) then begin
              Result := False;
              SysMsg(g_sSCNot, c_Red, t_Hint);
            end;
          end;
        end;
      4: begin
          if m_btReLevel >= StdItem.NeedLevel then begin
            Result := True;
          end
          else begin
            SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
          end;
        end;
      40: begin
          if (m_btReLevel >= LoWord(StdItem.NeedLevel)) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
          end;
          if Result then begin
            if (m_Abil.Level < HiWord(StdItem.NeedLevel)) then begin
              Result := False;
              SysMsg(g_sLevelNot, c_Red, t_Hint);
            end;
          end;
        end;
      41: begin
          if (m_btReLevel >= LoWord(StdItem.NeedLevel)) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
          end;
          if Result then begin
            if (HiWord(m_WAbil.DC) < HiWord(StdItem.NeedLevel)) then begin
              Result := False;
              SysMsg(g_sDCNot, c_Red, t_Hint);
            end;
          end;
        end;
      42: begin
          if (m_btReLevel >= LoWord(StdItem.NeedLevel)) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
          end;
          if Result then begin
            if (HiWord(m_WAbil.MC) < HiWord(StdItem.NeedLevel)) then begin
              Result := False;
              SysMsg(g_sMCNot, c_Red, t_Hint);
            end;
          end;
        end;
      43: begin
          if (m_btReLevel >= LoWord(StdItem.NeedLevel)) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
          end;
          if Result then begin
            if (HiWord(m_WAbil.SC) < HiWord(StdItem.NeedLevel)) then begin
              Result := False;
              SysMsg(g_sSCNot, c_Red, t_Hint);
            end;
          end;
        end;
      44: begin
          if (m_btReLevel >= LoWord(StdItem.NeedLevel)) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sReNewLevelNot, c_Red, t_Hint);
          end;
          if Result then begin
            if (m_nCreditPoint < HiWord(StdItem.NeedLevel)) then begin
              Result := False;
              SysMsg(g_sCreditPointNot, c_Red, t_Hint);
            end;
          end;
        end;
      5: begin
          if m_nCreditPoint >= StdItem.NeedLevel then begin
            Result := True;
          end
          else begin
            SysMsg(g_sCreditPointNot, c_Red, t_Hint);
          end;
        end;
      6: begin
          if m_MyGuild <> nil then begin
            Result := True;
          end
          else begin
            SysMsg(g_sGuildNot, c_Red, t_Hint);
          end;
        end;
      60: begin
          if IsGuildMaster then begin
            Result := True;
          end
          else begin
            SysMsg(g_sGuildMasterNot, c_Red, t_Hint);
          end;
        end;
      7: begin
          if (m_MyGuild <> nil) and (g_CastleManager.IsCastleMember(Self) <> nil) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sSabukHumanNot, c_Red, t_Hint);
          end;
        end;
      70: begin
          if IsGuildMaster and (g_CastleManager.IsCastleMember(Self) <> nil) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sSabukMasterManNot, c_Red, t_Hint);
          end;
        end;
      8: begin
          if (m_nMemberType > 0) or (m_nMemberLevel > 0) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sMemberNot, c_Red, t_Hint);
          end;
        end;
      81: begin
          if (m_nMemberType = LoWord(StdItem.NeedLevel)) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sMemberTypeNot, c_Red, t_Hint);
          end;
          if Result then begin
            if (m_nMemberLevel < HiWord(StdItem.NeedLevel)) then begin
              Result := False;
              SysMsg(g_sMemberLevelNot, c_Red, t_Hint);
            end;
          end;
        end;
      82: begin
          if (m_nMemberType >= LoWord(StdItem.NeedLevel)) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sMemberTypeNot, c_Red, t_Hint);
          end;
          if Result then begin
            if (m_nMemberLevel < HiWord(StdItem.NeedLevel)) then begin
              Result := False;
              SysMsg(g_sMemberLevelNot, c_Red, t_Hint);
            end;
          end;
        end;
      20: begin //城主专用
          if IsGuildMaster and (g_CastleManager.IsCastleMember(Self) <> nil) then
            Result := True
          else
            SysMsg(g_sCastleMasterNot, c_Red, t_Hint);
        end;
    end;
  end;
end;

function TPlayObject.GetUserItemWeitht(nWhere: Integer): Integer;
var
  i: Integer;
  n14: Integer;
  StdItem: pTStdItem;
begin
  n14 := 0;
  for i := Low(THumanUseItems) to High(THumanUseItems) do begin
    if (nWhere = -1) or (not (i = nWhere) and not (i = 1) and not (i = 2)) then begin
      StdItem := UserEngine.GetStdItem(m_UseItems[i].wIndex);
      if StdItem <> nil then
        Inc(n14, StdItem.Weight);
    end;
  end;
  Result := n14;
end;

function TPlayObject.EatItems(StdItem: pTStdItem; UserItem: pTUserItem):
  Boolean;
var
  bo06: Boolean;
  I, ItCount, n1C, nTempNakedCount: Integer;
  BaseObject: TBaseObject;
  Std: pTStdItem;
begin
  Result := False;
  if m_PEnvir.m_boNODRUG then begin
    SysMsg(sCanotUseDrugOnThisMap, c_Red, t_Hint);
    Exit;
  end;
  if m_nCheckEatCount < 100 then
    Inc(m_nCheckEatCount);

  case StdItem.StdMode of
    tm_Drug {0}: begin
        if m_WAbil.HP > 0 then begin
          case StdItem.Shape of
            1: begin
                IncHealthSpell(StdItem.nAC, StdItem.nMAC);
                //Result := True;
              end;
            2: begin
                m_boUserUnLockDurg := True;
                //Result := True;
              end;
          else begin
              if (StdItem.nAC > 0) then begin
                Inc(m_nIncHealth, StdItem.nAC);
              end;
              if (StdItem.nMAC > 0) then begin
                Inc(m_nIncSpell, StdItem.nMAC);
              end;
              //Result := True;
            end;
          end;
        end;
        if UserItem.Dura > 1 then begin
          Dec(UserItem.Dura);
          if StdItem.NeedIdentify = 1 then
            AddGameLog(Self, LOG_ITEMDURACHANGE, Stditem.Name, UserItem.MakeIndex, UserItem.Dura,
              '0', '-', '1', '使用', UserItem);
          Result := False;
        end
        else
          Result := True;
      end;
    tm_Restrict {2}: begin
        if StdItem.Shape = 0 then begin
          UseStdmodeFunItem(StdItem);
          if UserItem.Dura > 1000 then begin
            Dec(UserItem.Dura, 1000);
            Result := False;
            if StdItem.NeedIdentify = 1 then
              AddGameLog(Self, LOG_ITEMDURACHANGE, Stditem.Name, UserItem.MakeIndex, UserItem.Dura,
                '0', '-', '1000', '使用', UserItem);
          end
          else
            Result := True;
        end
        else if StdItem.Shape = 1 then begin
          for I := 0 to m_SlaveList.Count - 1 do begin
            BaseObject := TBaseObject(m_SlaveList.Items[I]);
            if BaseObject.m_btSlaveExpLevel < 7 then begin
              BaseObject.m_btSlaveExpLevel := 7;
              BaseObject.RecalcAbilitys;
              BaseObject.RefNameColor;
              BaseObject.SendRefMsg(RM_SHOWEFFECT, EFFECT_BEACON_2, Integer(BaseObject),
                BaseObject.m_nCurrX, BaseObject.m_nCurrY, '');
              SysMsg(g_sSlaveLevelUp, c_Blue, t_Hint);
              break;
            end;
          end;
          if UserItem.Dura > 1000 then begin
            Dec(UserItem.Dura, 1000);
            if StdItem.NeedIdentify = 1 then
              AddGameLog(Self, LOG_ITEMDURACHANGE, Stditem.Name, UserItem.MakeIndex, UserItem.Dura,
                '0', '-', '1000', '使用', UserItem);
            Result := False;
          end
          else
            Result := True;
        end
        else if StdItem.Shape = 9 then begin
          ItCount := UserItem.Dura * 10;
          for I := Low(THumItems) to High(THumItems) do begin
            if (ItCount > 0) and (m_UseItems[I].wIndex > 0) and
              (m_UseItems[I].Dura < m_UseItems[I].DuraMax) then begin
              Std := UserEngine.GetStdItem(m_UseItems[I].wIndex);
              if Std = nil then
                Continue;
              if CheckItemBindMode(UserItem, bm_NoRepair) then begin
                Continue;
              end;
              if sm_Arming in Std.StdModeEx then begin
                n1C := m_UseItems[I].DuraMax - m_UseItems[I].Dura;
                if n1C <= 0 then
                  Continue;
                if ItCount > n1C then begin
                  Inc(m_UseItems[I].Dura, n1C);
                  Dec(ItCount, n1C);
                end
                else begin
                  Inc(m_UseItems[I].Dura, ItCount);
                  ItCount := 0;
                end;
                SysMsg(Format(g_sRepairItemMsg, [Std.Name]), c_Green, t_Hint);
                DuraChange(i, m_UseItems[i].Dura, m_UseItems[i].DuraMax);
              end;
            end;
          end; //end for
          if ItCount >= 1000 then begin
            ItCount := Round(ItCount / 10);
            if StdItem.NeedIdentify = 1 then
              AddGameLog(Self, LOG_ITEMDURACHANGE, Stditem.Name, UserItem.MakeIndex, ItCount,
                '0', '-', IntToStr(UserItem.Dura - ItCount), '使用', UserItem);
            UserItem.Dura := ItCount;
            Result := False;
          end
          else
            Result := True;
        end
        else begin
          Result := False;
          if EatUseItems(StdItem.Shape) then begin
            if UserItem.Dura > 1000 then begin
              Dec(UserItem.Dura, 1000);
              if StdItem.NeedIdentify = 1 then
                AddGameLog(Self, LOG_ITEMDURACHANGE, Stditem.Name, UserItem.MakeIndex, UserItem.Dura,
                  '0', '-', '1000', '使用', UserItem);
              Result := False;
            end
            else
              Result := True;
          end;
        end;
      end;
    tm_Reel {3}: begin
        if StdItem.Shape = 18 then begin
          nTempNakedCount := 0;
          Inc(nTempNakedCount, m_NakedAbil.nAc);
          Inc(nTempNakedCount, m_NakedAbil.nMAc);
          Inc(nTempNakedCount, m_NakedAbil.nDc);
          Inc(nTempNakedCount, m_NakedAbil.nMc);
          Inc(nTempNakedCount, m_NakedAbil.nSc);
          Inc(nTempNakedCount, m_NakedAbil.nHP);
          if nTempNakedCount > (StdItem.DuraMax + m_nNakedBackCount) then
            Inc(m_nNakedBackCount, StdItem.DuraMax)
          else begin
            m_nNakedBackCount := 0;
            SafeFillChar(m_NakedAbil, SizeOf(m_NakedAbil), #0);
            Inc(m_nNakedCount, nTempNakedCount);
          end;
          SendNakedAbility;
          Result := True;
        end
        else if StdItem.Shape = 17 then begin
          GetExp(StdItem.Source * 1000);
          Result := True;
        end
        else if StdItem.Shape = 16 then begin
          Result := OpenBox(StdItem.Source, Random(100) < StdItem.AniCount);
        end
        else if StdItem.Shape = 15 then begin
          Result := False;
          if m_MyGuild <> nil then begin
            TGuild(m_MyGuild).IncBuildPoint(StdItem.Source);
            TGuild(m_MyGuild).SendGuildMsg('[' + m_sCharName + ']增加行会建设值 ' + IntToStr(StdItem.Source) + '点.');
            Result := True;
          end
          else
            SysMsg('只有行会成员才能使用.', c_Red, t_Hint);
        end
        else if StdItem.Shape = 14 then begin
          Result := False;
          if m_nPullulation >= (StdItem.DuraMax * MIDPULLULATION) then begin
            Dec(m_nPullulation, (StdItem.DuraMax * MIDPULLULATION));
            GetExp(StdItem.Source * StdItem.Reserved);
            GameGoldChanged();
            Result := True;
          end
          else
            SysMsg('你的自然成长点不足！', c_Red, t_Hint);
        end
        else if StdItem.Shape = 13 then begin
          Result := UserItem.Value.boBind;
          if Result then begin
            BaseObjectMove(UserItem.Value.sMapName, IntToStr(UserItem.Value.wCurrX),
              IntToStr(UserItem.Value.wCurrY));
          end
          else begin
            UserItem.Value.sMapDesc := m_PEnvir.sMapDesc;
            UserItem.Value.sMapName := m_PEnvir.sMapName;
            UserItem.Value.wCurrX := m_nCurrX;
            UserItem.Value.wCurrY := m_nCurrY;
            UserItem.Value.boBind := True;
            SendDefSocket(Self, SM_UPDATEUSERITEM, UserItem.MakeIndex, 0, 0, 0, MakeClientItem(UserItem));
          end;
        end
        else if StdItem.Shape = 12 then begin
          bo06 := False;
          if StdItem.nDC > 0 then begin
            m_boDC := True;
            m_wStatusArrValue[0 {0x218}] := StdItem.nDC;
            m_dwStatusArrTimeOutTick[0 {0x220}] := GetTickCount + StdItem.nMAC2 * 1000;
            SysMsg('攻击力增加' + IntToStr(StdItem.nMAC2) + '秒', c_Green, t_Hint);
            ChangeStatusMode(STATUS_DC, True);
            bo06 := True;
          end;
          if StdItem.nMC > 0 then begin
            m_boMC := True;
            m_wStatusArrValue[1 {0x219}] := StdItem.nMC;
            m_dwStatusArrTimeOutTick[1 {0x224}] := GetTickCount + StdItem.nMAC2 * 1000;
            SysMsg('魔法力增加' + IntToStr(StdItem.nMAC2) + '秒', c_Green, t_Hint);
            ChangeStatusMode(STATUS_MC, True);
            bo06 := True;
          end;
          if StdItem.nSC > 0 then begin
            m_boSC := True;
            m_wStatusArrValue[2 {0x21A}] := StdItem.nSC;
            m_dwStatusArrTimeOutTick[2 {0x228}] := GetTickCount + StdItem.nMAC2 * 1000;
            SysMsg('道术增加' + IntToStr(StdItem.nMAC2) + '秒', c_Green, t_Hint);
            ChangeStatusMode(STATUS_SC, True);
            bo06 := True;
          end;
          if StdItem.nAC2 > 0 then begin
            m_boHitSpeed := True;
            m_wStatusArrValue[3 ] := StdItem.nAC2;
            m_dwStatusArrTimeOutTick[3 ] := GetTickCount + StdItem.nMAC2 * 1000;
            SysMsg('攻击速度增加' + IntToStr(StdItem.nMAC2) + '秒', c_Green, t_Hint);
            bo06 := True;
          end; 
          if StdItem.nAC > 0 then begin
            m_boAC := True;
            m_wStatusArrValue[4 {0x21C}] := StdItem.nAC;
            m_dwStatusArrTimeOutTick[4 {0x230}] := GetTickCount + StdItem.nMAC2 * 1000;
            SysMsg('生命值增加' + IntToStr(StdItem.nMAC2) + '秒', c_Green, t_Hint);
            ChangeStatusMode(STATUS_HP, True);
            bo06 := True;
          end;
          if StdItem.nMAC > 0 then begin
            m_boMAC := True;
            m_wStatusArrValue[5 {0x21D}] := StdItem.nMAC;
            m_dwStatusArrTimeOutTick[5 {0x234}] := GetTickCount + StdItem.nMAC2 * 1000;
            SysMsg('魔法值增加' + IntToStr(StdItem.nMAC2) + '秒', c_Green, t_Hint);
            ChangeStatusMode(STATUS_MP, True);
            bo06 := True;
          end;
          if bo06 then begin
            RecalcAbilitys();
            SendAbility;
            Result := True;
          end;
        end
        else begin
          Result := EatUseItems(StdItem.Shape);
        end;
      end;
  end;
end;

function TPlayObject.ReadBook(StdItem: pTStdItem): Boolean;
var
  Magic: pTMagic;
  UserMagic: pTUserMagic;
begin
  Result := False;
  Magic := UserEngine.FindMagic(StdItem.Name);
  if Magic <> nil then begin
    if not IsTrainingSkill(Magic.wMagicId) then begin
      if (Magic.btJob = 99) or (Magic.btJob = m_btJob) then begin
        if m_Abil.Level >= Magic.TrainLevel[0] then begin
          New(UserMagic);
          UserMagic.MagicInfo := Magic;
          UserMagic.wMagIdx := Magic.wMagicId;
          UserMagic.btLevel := 0;
          UserMagic.nTranPoint := 0;
          UserMagic.dwInterval := 0;
          UserMagic.btKey := 0;
          m_MagicList.Add(UserMagic);
          RecalcAbilitys();
          SendAddMagic(UserMagic);
          Result := True;
        end;
      end;
    end;
  end;
end;

procedure TPlayObject.SendAddMagic(UserMagic: pTUserMagic);
var
  ClientMagic: TClientMagic;
begin
  {if UserMagic.btLevel <= 0 then
    UserMagic.btLevel := 1;}
  ClientMagic.btMagID := UserMagic.wMagIdx;
  ClientMagic.Level := UserMagic.btLevel;
  ClientMagic.CurTrain := UserMagic.nTranPoint;
  ClientMagic.dwInterval := 0;
  ClientMagic.btKey := 0;
  m_DefMsg := MakeDefaultMsg(SM_ADDMAGIC, 0, 0, 0, 1);
  SendSocket(@m_DefMsg, EncodeBuffer(@ClientMagic, SizeOf(TClientMagic)));
end;

procedure TPlayObject.SendDelMagic(UserMagic: pTUserMagic);
begin
  m_DefMsg := MakeDefaultMsg(SM_DELMAGIC, UserMagic.wMagIdx, 0, 0, 1);
  SendSocket(@m_DefMsg, '');
end;

function TPlayObject.EatUseItems(nShape: Integer): Boolean;
var
  Castle: TUserCastle;
begin
  Result := False;
  case nShape of //
    1: begin
        SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
        BaseObjectMove(m_sHomeMap, '', '');
        Result := True;
      end;
    2: begin
        if not m_PEnvir.m_boNORANDOMMOVE then begin
          SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
          BaseObjectMove(m_sMapName, '', '');
          Result := True;
        end
        else
          SysMsg('当前地图不允许使用.', c_Red, t_Hint);
      end;
    3: begin
        SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
        if PKLevel < 2 then begin
          BaseObjectMove(m_sHomeMap, IntToStr(m_nHomeX), IntToStr(m_nHomeY));
        end
        else begin
          BaseObjectMove(g_Config.sRedHomeMap, IntToStr(g_Config.nRedHomeX),
            IntToStr(g_Config.nRedHomeY));
        end;
        Result := True;
      end;
    4: begin
        if WeaptonMakeLuck() then
          Result := True;
      end;
    5: begin
        if m_MyGuild <> nil then begin
          if not m_boInFreePKArea then begin
            Castle := g_CastleManager.IsCastleMember(Self);
            {
            if UserCastle.IsMasterGuild(TGuild(m_MyGuild)) then begin
              BaseObjectMove(UserCastle.m_sHomeMap,IntToStr(UserCastle.GetHomeX),IntToStr(UserCastle.GetHomeY));
            }
            if (Castle <> nil) and Castle.IsMasterGuild(TGuild(m_MyGuild)) then begin
              BaseObjectMove(Castle.m_sHomeMap, IntToStr(Castle.GetHomeX), IntToStr(Castle.GetHomeY));
            end
            else begin
              SysMsg('无效', c_Red, t_Hint);
            end;
            Result := True;
          end
          else begin
            SysMsg('此处无法使用', c_Red, t_Hint);
          end;
        end;
      end;
    9: begin
        if RepairWeapon() then
          Result := True;
      end;
    10: begin
        if SuperRepairWeapon() then
          Result := True;
      end;
    11: begin
        if WinLottery() then
          Result := True;
      end;
  end;
end;

procedure TPlayObject.BaseObjectMove(sMAP, sX, sY: string);
var
  Envir: TEnvirnoment;
  nX, nY: Integer;
begin
  Envir := m_PEnvir;
  if sMAP = '' then
    sMAP := m_sMapName;
  if (sX <> '') and (sY <> '') then begin
    nX := StrToIntDef(sX, 0);
    nY := StrToIntDef(sY, 0);
    SpaceMove(sMAP, nX, nY, 0);
  end
  else begin
    MapRandomMove(sMAP, 0);
  end;
  if (Envir <> m_PEnvir) and (m_btRaceServer = RC_PLAYOBJECT) then begin
    m_boTimeRecall := False;
  end;
end;
//使用祝福油

function TPlayObject.WeaptonMakeLuck: Boolean;
var
  StdItem: pTStdItem;
  nRand: Integer;
  boMakeLuck: Boolean;
begin
  Result := False;
  if m_UseItems[U_WEAPON].wIndex <= 0 then
    Exit;
  nRand := 0;
  StdItem := UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
  if StdItem <> nil then begin
    nRand := abs((StdItem.nDC2 - StdItem.nDC)) div 5;
  end;
  if Random(g_Config.nWeaponMakeUnLuckRate {20}) = 1 then begin
    MakeWeaponUnlock();
  end
  else begin
    boMakeLuck := False;
    if m_UseItems[U_WEAPON].Value.btValue[tb_UnLuck] > 0 then begin
      Dec(m_UseItems[U_WEAPON].Value.btValue[tb_UnLuck]);
      SysMsg(g_sWeaptonMakeLuck {'武器被加幸运了...'}, c_Green, t_Hint);
      boMakeLuck := True;
    end
    else if m_UseItems[U_WEAPON].Value.btValue[tb_Luck] < g_Config.nWeaponMakeLuckPoint1 {1} then begin
      Inc(m_UseItems[U_WEAPON].Value.btValue[tb_Luck]);
      SysMsg(g_sWeaptonMakeLuck {'武器被加幸运了...'}, c_Green, t_Hint);
      boMakeLuck := True;
    end
    else if (m_UseItems[U_WEAPON].Value.btValue[tb_Luck] < g_Config.nWeaponMakeLuckPoint2 {3}) and
      (Random(nRand + g_Config.nWeaponMakeLuckPoint2Rate {6}) = 1) then begin
      Inc(m_UseItems[U_WEAPON].Value.btValue[tb_Luck]);
      SysMsg(g_sWeaptonMakeLuck {'武器被加幸运了...'}, c_Green, t_Hint);
      boMakeLuck := True;
    end
    else if (m_UseItems[U_WEAPON].Value.btValue[tb_Luck] < g_Config.nWeaponMakeLuckPoint3 {7}) and
      (Random(nRand * g_Config.nWeaponMakeLuckPoint3Rate {10 + 30}) = 1) then begin
      Inc(m_UseItems[U_WEAPON].Value.btValue[tb_Luck]);
      SysMsg(g_sWeaptonMakeLuck {'武器被加幸运了...'}, c_Green, t_Hint);
      boMakeLuck := True;
    end;
    if m_btRaceServer = RC_PLAYOBJECT then begin
      RecalcAbilitys();
      SendAbility;
      SendSubAbility;
    end;
    if not boMakeLuck then
      SysMsg(g_sWeaptonNotMakeLuck {'无效'}, c_Green, t_Hint)
    else
      SendUpdateItem(@m_UseItems[U_WEAPON]);
  end;
  Result := True;
end;

function TPlayObject.RepairWeapon: Boolean;
var
  nDura: Integer;
  UserItem: pTUserItem;
begin
  Result := False;
  UserItem := @m_UseItems[U_WEAPON];
  if (UserItem.wIndex <= 0) or (UserItem.DuraMax <= UserItem.Dura) then
    Exit;
  Dec(UserItem.DuraMax, (UserItem.DuraMax - UserItem.Dura) div
    g_Config.nRepairItemDecDura {30});
  nDura := _MIN(5000, UserItem.DuraMax - UserItem.Dura);
  if nDura > 0 then begin
    Inc(UserItem.Dura, nDura);
    DuraChange(U_WEAPON, m_UseItems[U_WEAPON].Dura, m_UseItems[U_WEAPON].DuraMax);
    //SendMsg(Self, RM_aDURACHANGE, 1, UserItem.Dura, UserItem.DuraMax, 0, '');
    SysMsg(g_sWeaponRepairSuccess {'武器修复成功...'}, c_Green, t_Hint);
    Result := True;
  end;
end;

function TPlayObject.MakeOffLine(): Boolean;
var
  I: Integer;
begin
  Result := False; //推摊状态不允许脱机
  if (not m_boSafeOffLine) { and (not m_boShoping) } then begin
    if (g_Config.boSafeOffLine and InSafeZone and (m_Abil.Level >= g_Config.nSafeOffLineLevel)) or
      (g_Config.boShopSafeOffLine and InSafeZone and m_boShoping) or
      (m_PEnvir.m_boOffLine and InSafeZone) then begin
      if (m_PEnvir.GetOffLincCount(m_nCurrX, m_nCurrY) <= 0) or m_PEnvir.m_boOffLine then begin
        m_boSafeOffLine := True;
        for i := m_SlaveList.Count - 1 downto 0 do begin
          TBaseObject(m_SlaveList.Items[i]).MakeGhost;
        end;
        if m_GroupOwner <> nil then
          m_GroupOwner.DelMember(Self);
        //m_boAllowGroup := False;
        UserEngine.AddOffLine(Self);
        UserEngine.SaveHumanRcd(Self);
        m_dLogonTime := Now();
        Result := True;
      end;
    end;
  end;
end;

function TPlayObject.SuperRepairWeapon: Boolean;
begin
  Result := False;
  if m_UseItems[U_WEAPON].wIndex <= 0 then
    Exit;
  m_UseItems[U_WEAPON].Dura := m_UseItems[U_WEAPON].DuraMax;
  DuraChange(U_WEAPON, m_UseItems[U_WEAPON].Dura, m_UseItems[U_WEAPON].DuraMax);
  //SendMsg(Self, RM_aDURACHANGE, 1, m_UseItems[U_WEAPON].Dura, m_UseItems[U_WEAPON].DuraMax, 0, '');
  SysMsg(g_sWeaponRepairSuccess {'武器修复成功...'}, c_Green, t_Hint);
  Result := True;
end;

function TPlayObject.WinLottery: Boolean;
var
  nGold, nWinLevel, nRate: Integer;
begin
  nGold := 0;
  nWinLevel := 0;
  {
  case Random(30000) of
    0..4999: begin //004BD866
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=500;
       nWinLevel:=6;
       Inc(nWinLotteryLevel6);
     end;
    end;
    14000..15999: begin //004BD895
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=1000;
       nWinLevel:=5;
       Inc(nWinLotteryLevel5);
     end;
    end;
    16000..16149: begin //004BD8C4
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=10000;
       nWinLevel:=4;
       Inc(nWinLotteryLevel4);
     end;
    end;
    16150..16169: begin //004BD8F0
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=100000;
       nWinLevel:=3;
       Inc(nWinLotteryLevel3);
     end;
    end;
    16170..16179: begin //004BD918
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=200000;
       nWinLevel:=2;
       Inc(nWinLotteryLevel2);
     end;
    end;
    16180 + 1820: begin //004BD940
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=1000000;
       nWinLevel:=1;
       Inc(nWinLotteryLevel1);
     end;
    end;
  end;
  }
  nRate := Random(g_Config.nWinLotteryRate);
  if nRate in [g_Config.nWinLottery6Min..g_Config.nWinLottery6Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold := g_Config.nWinLottery6Gold;
      nWinLevel := 6;
      Inc(g_Config.nWinLotteryLevel6);
    end;
  end
  else if nRate in [g_Config.nWinLottery5Min..g_Config.nWinLottery5Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold := g_Config.nWinLottery5Gold;
      nWinLevel := 5;
      Inc(g_Config.nWinLotteryLevel5);
    end;
  end
  else if nRate in [g_Config.nWinLottery4Min..g_Config.nWinLottery4Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold := g_Config.nWinLottery4Gold;
      nWinLevel := 4;
      Inc(g_Config.nWinLotteryLevel4);
    end;
  end
  else if nRate in [g_Config.nWinLottery3Min..g_Config.nWinLottery3Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold := g_Config.nWinLottery3Gold;
      nWinLevel := 3;
      Inc(g_Config.nWinLotteryLevel3);
    end;
  end
  else if nRate in [g_Config.nWinLottery2Min..g_Config.nWinLottery2Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold := g_Config.nWinLottery2Gold;
      nWinLevel := 2;
      Inc(g_Config.nWinLotteryLevel2);
    end;
  end
  else if nRate in [g_Config.nWinLottery1Min + g_Config.nWinLottery1Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold := g_Config.nWinLottery1Gold;
      nWinLevel := 1;
      Inc(g_Config.nWinLotteryLevel1);
    end;
  end;
  if nGold > 0 then begin
    case nWinLevel of //
      1: SysMsg(g_sWinLottery1Msg {'祝贺您，中了一等奖。'}, c_Green,
          t_Hint);
      2: SysMsg(g_sWinLottery2Msg {'祝贺您，中了二等奖。'}, c_Green,
          t_Hint);
      3: SysMsg(g_sWinLottery3Msg {'祝贺您，中了三等奖。'}, c_Green,
          t_Hint);
      4: SysMsg(g_sWinLottery4Msg {'祝贺您，中了四等奖。'}, c_Green,
          t_Hint);
      5: SysMsg(g_sWinLottery5Msg {'祝贺您，中了五等奖。'}, c_Green,
          t_Hint);
      6: SysMsg(g_sWinLottery6Msg {'祝贺您，中了六等奖。'}, c_Green,
          t_Hint);
    end;
    if IncGold(nGold) then begin
      GoldChanged();
    end
    else begin
      DropGoldDown(nGold, True, nil, nil);
    end;

  end
  else begin
    Inc(g_Config.nNoWinLotteryCount, 500);
    SysMsg(g_sNotWinLotteryMsg {'等下次机会吧.'}, c_Red, t_Hint);
  end;
  Result := True;
end;

procedure TPlayObject.SendDelDealItem(UserItem: pTUserItem);
begin
  SendDefMessage(SM_DEALDELITEM_OK, 0, 0, 0, 0, '');
  if m_DealCreat <> nil then begin
    m_DefMsg := MakeDefaultMsg(SM_DEALREMOTEDELITEM, Integer(Self), 0, 0, 1);
    TPlayObject(m_DealCreat).SendSocket(@m_DefMsg, EncodeBuffer(@(UserItem^), SizeOf(TUserItem)));
    m_DealCreat.m_DealLastTick := GetTickCount();
    m_DealLastTick := GetTickCount();
  end;
end;

procedure TPlayObject.SendAddDealItem(UserItem: pTUserItem); //004DD464
begin
  SendDefMessage(SM_DEALADDITEM_OK, 0, 0, 0, 0, '');

  if m_DealCreat <> nil then begin
    m_DefMsg := MakeDefaultMsg(SM_DEALREMOTEADDITEM, Integer(Self), 0, 0, 1);
    TPlayObject(m_DealCreat).SendSocket(@m_DefMsg, EncodeBuffer(@(UserItem^),
      SizeOf(TUserItem)));
    m_DealCreat.m_DealLastTick := GetTickCount();
    m_DealLastTick := GetTickCount();
  end;
end;

procedure TPlayObject.EventCheck(nEvent: Byte; sItemName: string);
var
  MapEvent: pTMapEvent;
  I: Integer;
  EventList: TList;
begin
  try
    if m_PEnvir = nil then begin
      MainOutMessage('MapEventCheck nil PEnvir');
      exit;
    end;
    if (m_btRaceServer <> RC_PLAYOBJECT) then
      exit;
    if (nEvent = OS_DROPITEM) then begin
      if ((not g_Config.boStartDropItemMapEvent) or (not m_PEnvir.m_boDropItemEvent)) then
        exit;
      EventList := m_PEnvir.m_DropItemEventList;
    end
    else if (nEvent = OS_PICKUPITEM) then begin
      if ((not g_Config.boStartPickUpItemMapEvent) or (not m_PEnvir.m_boPickUpItemEvent)) then
        exit;
      EventList := m_PEnvir.m_PickUpItemEventList;
    end
    else if (nEvent = OS_HEAVYHIT) then begin
      if ((not g_Config.boStartHeavyHitMapEvent) or (not m_PEnvir.m_boHeavyHitEvent)) then
        exit;
      EventList := m_PEnvir.m_HeavyHitEventList;
    end
    else
      Exit;
    for I := 0 to EventList.Count - 1 do begin
      MapEvent := EventList[I];
      if sItemName = MapEvent.sItemName then begin
        if (MapEvent.nRate <= 1) or (Random(MapEvent.nRate) = 0) then begin
          if (MapEvent.nFlag = -1) or (GetQuestFlagStatus(MapEvent.nFlag) = MapEvent.btValue) then begin
            if (not MapEvent.boGroup) or (m_GroupOwner <> nil) then begin
              NpcGotoLable(g_MapEventNpc, MapEvent.nEvent, False);
            end;
          end;
        end;
        Break;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(E.Message);
      MainOutMessage('[Excetpion] TPlayObject.EventCheck');
    end;
  end;
end;

procedure TPlayObject.MapEventCheck(nEvent: Byte; sItemName: string);
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  MapEvent: pTMapEvent;
  bo1D: Boolean;
  I: Integer;
begin
  try
    if m_PEnvir = nil then begin
      MainOutMessage('MapEventCheck nil PEnvir');
      exit;
    end;
    if (m_btRaceServer <> RC_PLAYOBJECT) then
      exit;
    if (nEvent = OS_DROPITEM) and ((not g_Config.boStartDropItemMapEvent) or (not m_PEnvir.m_boDropItemMapEvent)) then
      exit;
    if (nEvent = OS_PICKUPITEM) and ((not g_Config.boStartPickUpItemMapEvent) or (not m_PEnvir.m_boPickUpItemMapEvent)) then
      exit;
    if (nEvent = OS_HEAVYHIT) and ((not g_Config.boStartHeavyHitMapEvent) or (not m_PEnvir.m_boHeavyHitMapEvent)) then
      exit;
    bo1D := m_PEnvir.GetMapCellInfo(m_nCurrX, m_nCurrY, MapCellInfo);
    if bo1D and (MapCellInfo.ObjList <> nil) then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[i];
        if OSObject.btType = nEvent then begin
          MapEvent := pTMapEvent(OSObject.CellObj);
          if (MapEvent.nRate <= 1) or (Random(MapEvent.nRate) = 0) then begin
            if (MapEvent.nFlag = -1) or (GetQuestFlagStatus(MapEvent.nFlag) = MapEvent.btValue) then begin
              if (not MapEvent.boGroup) or (m_GroupOwner <> nil) then begin
                {if (not (nEvent in [OS_DROPITEM..OS_HEAVYHIT])) or
                  (sItemName = '*') or (CompareText(sItemName, MapEvent.sItemName) = 0) then begin }
                if (sItemName = '*') or (sItemName = MapEvent.sItemName) then begin
                  //if MapEvent.boEvent then
                  NpcGotoLable(g_MapEventNpc, MapEvent.nEvent, False);
                end;
              end;
            end;
          end;
          break;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(E.Message);
      MainOutMessage('[Excetpion] TPlayObject.MapEventCheck');
    end;
  end;
end;

procedure TPlayObject.OpenDealDlg(BaseObject: TPlayObject);
begin
  m_boDealing := True;
  m_DealCreat := BaseObject;
  GetBackDealItems();
  SendDefMessage(SM_DEALMENU, 0, 0, 0, 0, m_DealCreat.m_sCharName);
  m_DealLastTick := GetTickCount();
end;

procedure TPlayObject.ChangeGroup(PlayObject: TPlayObject);
begin
  m_GroupOwner := PlayObject;
  SendMsg(Self, RM_GROUPMESSAGE, 0, g_Config.nGroupMsgFColor,
    g_Config.nGroupMsgBColor, 0, PlayObject.m_sCharName + ' 成为新的组长.');
end;
//加入队伍

procedure TPlayObject.JoinGroup(PlayObject: TPlayObject);
{resourcestring
  ItemClass1 =
    '队伍物品分配模式为[共享随机分配],任何队员捡取物品将由所有队员随机获得(金币平分)';
  ItemClass2 =
    '队伍物品分配模式为[默认自由分配],队员捡取物品由自己获得';     }
var
  ClientGroup: TClientGroup;
begin
  m_GroupOwner := PlayObject;
  ClientGroup.UserID := Integer(Self);
  ClientGroup.UserName := m_sCharName;
  ClientGroup.WuXin := m_btWuXin;
  //ClientGroup.WuXinLevel := m_btWuXinLevel;
  ClientGroup.Level := m_Abil.Level;
  ClientGroup.HP := m_WAbil.HP;
  ClientGroup.MP := m_WAbil.MP;
  ClientGroup.MaxHP := m_WAbil.MaxHP;
  ClientGroup.MaxMP := m_WAbil.MaxMP;
  ClientGroup.btJob := m_btJob;
  ClientGroup.btSex := m_btGender;
  SendGroupSocket(Self, SM_GROUPADDMEM_OK, Integer(Self), 0, 0, 0, EncodeBuffer(@ClientGroup, SizeOf(ClientGroup)));
  {SendGroupText(m_sCharName + ' 加入小组.');
  if PlayObject.m_GroupClass then
    SysMsg(ItemClass1, c_Red, t_Hint)
  else
    SysMsg(ItemClass2, c_Red, t_Hint)   }
end;

procedure TPlayObject.GameGirdChanged;
begin
  SendDefMsg(Self, SM_GAMEGOLDNAME3, m_nGameGird, 0, LoWord(m_CustomVariable[0]), HiWord(m_CustomVariable[0]), '');
end;

procedure TPlayObject.DiamondChanged;
begin
  SendDefMsg(Self, SM_GAMEGOLDNAME2, m_nGameDiamond, m_nPkPoint,
    LoWord(m_nCreditPoint), HiWord(m_nCreditPoint), '');
end;

function TPlayObject.AbilityUp(UserMagic: pTUserMagic): Boolean;
var
  nSpellPoint, n14: Integer;
begin
  Result := False;
  nSpellPoint := GetSpellPoint(UserMagic);
  if (nSpellPoint > 0) and (m_dwStatusArrTimeOutTick[2 {0x228}] < GetTickCount) then begin
    if m_WAbil.MP < nSpellPoint then
      Exit;
    n14 := Random(30 * UserMagic.btLevel) + 60;
    m_dwStatusArrTimeOutTick[2 {0x228}] := GetTickCount + LongWord(n14 * 1000);
    m_boSC := True;
    m_wStatusArrValue[2 {0x218}] := MakeLong(Round(LoWord(m_WAbil.SC) * (UserMagic.MagicInfo.wPower / (UserMagic.MagicInfo.btTrainLv+1) * (UserMagic.btLevel+1)) / 100),
                                              Round(HiWord(m_WAbil.SC) * (UserMagic.MagicInfo.wMaxPower / (UserMagic.MagicInfo.btTrainLv+1) * (UserMagic.btLevel+1)) / 100  + 10));
    SysMsg('道术增加' + IntToStr(m_wStatusArrValue[2 {0x218}] + 2) + '点 ' + IntToStr(n14) + '秒', c_Green, t_Hint);
    ChangeStatusMode(STATUS_SC, True);
    RecalcAbilitys();
    SendAbility;
    Result := True;
  end;
end;

procedure TPlayObject.MakeMine;
  function RandomDrua(): Integer;
  begin
    Result := Random(g_Config.nStoneGeneralDuraRate) + g_Config.nStoneMinDura;
    if Random(g_Config.nStoneAddDuraRate) = 0 then begin
      Result := Result + Random(g_Config.nStoneAddDuraMax);
    end;
  end;
var
  UserItem: pTUserItem;
  nRANDOM: Integer;
begin
  if m_ItemList.Count >= m_nMaxItemListCount then
    Exit;
  nRANDOM := Random(g_Config.nStoneTypeRate {120});
  if nRANDOM in [g_Config.nGoldStoneMin {1}..g_Config.nGoldStoneMax {2}] then begin
    New(UserItem);
    if UserEngine.CopyToUserItemFromName(g_Config.sGoldStone, UserItem) then begin
      UserItem.Dura := RandomDrua();
      m_ItemList.Add(UserItem);
      //WeightChanged();
      SendAddItem(UserItem);
      MapEventCheck(OS_HEAVYHIT, g_Config.sGoldStone); //挖矿地图事件触发
      EventCheck(OS_HEAVYHIT, g_Config.sGoldStone); //挖矿地图事件触发
    end
    else
      DisPose(UserItem);
    Exit;
  end;
  if nRANDOM in [g_Config.nSilverStoneMin {3}..g_Config.nSilverStoneMax {20}] then begin
    New(UserItem);
    if UserEngine.CopyToUserItemFromName(g_Config.sSilverStone, UserItem) then begin
      UserItem.Dura := RandomDrua();
      m_ItemList.Add(UserItem);
      //WeightChanged();
      SendAddItem(UserItem);
      MapEventCheck(OS_HEAVYHIT, g_Config.sSilverStone); //挖矿地图事件触发
      EventCheck(OS_HEAVYHIT, g_Config.sSilverStone); //挖矿地图事件触发
    end
    else
      DisPose(UserItem);
    Exit;
  end;
  if nRANDOM in [g_Config.nSteelStoneMin {21}..g_Config.nSteelStoneMax {45}] then begin
    New(UserItem);
    if UserEngine.CopyToUserItemFromName(g_Config.sCopperStone, UserItem) then begin
      UserItem.Dura := RandomDrua();
      m_ItemList.Add(UserItem);
      //WeightChanged();
      SendAddItem(UserItem);
      MapEventCheck(OS_HEAVYHIT, g_Config.sCopperStone); //挖矿地图事件触发
      EventCheck(OS_HEAVYHIT, g_Config.sCopperStone); //挖矿地图事件触发
    end
    else
      DisPose(UserItem);
    Exit;
  end;
  if nRANDOM in [g_Config.nBlackStoneMin {46}..g_Config.nBlackStoneMax {56}] then begin
    New(UserItem);
    if UserEngine.CopyToUserItemFromName(g_Config.sBlackStone, UserItem) then begin
      UserItem.Dura := RandomDrua();
      m_ItemList.Add(UserItem);
      //WeightChanged();
      SendAddItem(UserItem);
      MapEventCheck(OS_HEAVYHIT, g_Config.sBlackStone); //挖矿地图事件触发
      EventCheck(OS_HEAVYHIT, g_Config.sBlackStone); //挖矿地图事件触发
    end
    else
      DisPose(UserItem);
    Exit;
  end;
  New(UserItem);
  if UserEngine.CopyToUserItemFromName(g_Config.sSteelStone, UserItem) then begin
    UserItem.Dura := RandomDrua();
    m_ItemList.Add(UserItem);
    //WeightChanged();
    SendAddItem(UserItem);
    MapEventCheck(OS_HEAVYHIT, g_Config.sSteelStone); //挖矿地图事件触发
    EventCheck(OS_HEAVYHIT, g_Config.sSteelStone); //挖矿地图事件触发
  end
  else
    DisPose(UserItem);
end;

function TPlayObject.QuestCheckItem(sItemName: string; var nCount,
  nParam: Integer; var nDura: Integer): pTUserItem;
var
  i: Integer;
  UserItem: pTUserItem;
  s1C: string;
begin
  Result := nil;
  nParam := 0;
  nDura := 0;
  nCount := 0;
  for i := 0 to m_ItemList.Count - 1 do begin
    UserItem := m_ItemList.Items[i];
    if UserItem = nil then
      Continue;
    s1C := UserEngine.GetStdItemName(UserItem.wIndex);
    if CompareText(s1C, sItemName) = 0 then begin
      if UserItem.Dura > nDura then begin
        nDura := UserItem.Dura;
        Result := UserItem;
      end;
      Inc(nParam, UserItem.Dura);
      if Result = nil then
        Result := UserItem;
      Inc(nCount);
    end;
  end;
end;

function TPlayObject.QuestTakeCheckItem(CheckItem: pTUserItem): Boolean;
var
  i: Integer;
  UserItem: pTUserItem;
begin
  Result := False;
  for i := m_ItemList.Count - 1 downto 0 do begin
    if m_ItemList.Count <= 0 then
      break;
    UserItem := m_ItemList.Items[i];
    if UserItem = nil then
      Continue;
    if UserItem = CheckItem then begin
      SendDelItems(UserItem);
      DisPose(UserItem);
      m_ItemList.Delete(i);
      Result := True;
      break;
    end;
  end;
  for i := Low(m_UseItems) to High(m_UseItems) do begin
    if @m_UseItems[i] = CheckItem then begin
      SendDelItems(@m_UseItems[i]);
      m_UseItems[i].wIndex := 0;
      Result := True;
      break;
    end;
  end;
end;

procedure TPlayObject.RecalcBagCount;
var
  i: integer;
  Stditem: pTStdItem;
begin
  m_nMaxItemListCount := 48 - m_DealItemList.Count - m_ShopSellItemList.Count;
  if m_nMaxItemListCount < 0 then
    m_nMaxItemListCount := 0;
  for I := Low(m_AppendBagItems) to High(m_AppendBagItems) do begin
    if m_AppendBagItems[i].wIndex > 0 then begin
      Stditem := UserEngine.GetStdItem(m_AppendBagItems[i].wIndex);
      if Stditem.StdMode = tm_AddBag then begin
        Inc(m_nMaxItemListCount, GetAppendBagCount(Stditem.Shape));
      end;
    end;
  end;
end;

procedure TPlayObject.ClientGuildGoldChange(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  nIdx: Word;
begin
  if m_MyGuild <> nil then begin
    nIdx := TGuild(m_MyGuild).GoldChange(ProcessMsg.wParam, ProcessMsg.nParam1, Self);
    SendDefMessage(SM_GUILDGOLDCHANGE_FAIL, TGuild(m_MyGuild).nMoneyCount, 0, 0, nIdx, '');
  end;
end;

procedure TPlayObject.ClientGuildLevelUp(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if m_MyGuild <> nil then begin
    if TGuild(m_MyGuild).LevelUp then
      ClientOpenGuildDlg(ProcessMsg, boResult)
    else
      SendDefMessage(SM_MENU_OK, Integer(Self), 0, 0, 0, '[提示信息]：行会升级失败！');
  end;
end;

procedure TPlayObject.ClientAlive(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  i: Integer;
  UserItem: PTUserItem;
  Stditem: pTStdItem;
  Castle: TUserCastle;
begin
  if m_boGhost or (not m_boDeath) then
    exit;
  case ProcessMsg.nParam1 of
    1: begin //接受治疗
        if m_PEnvir.m_boNotReAlive then begin
          SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, '当前地图不允许原地复活！');
          Exit;
        end;
        if m_boDoctorAlive and (not m_boAliveing) then begin
          m_boAliveing := True;
          SendDefMessage(SM_SHOWBAR, 4, 0, CM_ALIVE, 10, '正在接受治疗...');
          m_dwAliveTick := GetTickCount + 10 * 1000;
          m_nAliveHP := Round(m_WAbil.MaxHP * (m_btDoctorAliveLevel/100));
          m_btAliveType := 1;
        end;
      end;
    2: begin //原地治疗
        if m_PEnvir.m_boNotReAlive then begin
          SendDefMsg(g_ManageNPC, SM_MENU_OK, Integer(Self), 0, 0, 0, '当前地图不允许原地复活！');
          Exit;
        end;
        if (not m_boAliveing) then begin
          for I := m_ItemList.Count - 1 downto 0 do begin
            UserItem := m_ItemList[I];
            if UserItem <> nil then begin
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if (StdItem <> nil) and (StdItem.StdMode = tm_Revive) then begin
                m_ItemList.Delete(I);
                m_boAliveing := True;
                SendDefMessage(SM_SHOWBAR, 4, 0, CM_ALIVE, 10, '正在接受治疗...');
                m_dwAliveTick := GetTickCount + 10 * 1000;
                m_nAliveHP := Round(m_WAbil.MaxHP * 0.60);
                if (Stditem.NeedIdentify = 1) then
                  AddGameLog(Self, LOG_DELITEM, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, '', '0', '0', '复活', UserItem);
                SendDelItems(UserItem);
                Dispose(UserItem);
                m_btAliveType := 2;
                exit;
              end;
            end;
          end;
          SysMsg('复活失败，你身上没有指定物品.', c_Red, t_Hint);
        end;
      end;
    3: begin //回城治疗
        if not m_boAliveing then begin
          m_boDeath := False;
          Castle := g_CastleManager.InCastleWarArea(Self);
          if (Castle <> nil) and Castle.m_boUnderWar and Castle.IsMember(Self) then begin
            BaseObjectMove(Castle.GetMapName(), IntToStr(Castle.GetHomeX), IntToStr(Castle.GetHomeY));
          end else begin
            if PKLevel < 2 then begin
              BaseObjectMove(m_sHomeMap, IntToStr(m_nHomeX), IntToStr(m_nHomeY));
            end
            else begin
              BaseObjectMove(g_Config.sRedHomeMap, IntToStr(g_Config.nRedHomeX), IntToStr(g_Config.nRedHomeY));
            end;
          end;
          m_btMapSpaceShow := 0;
          ReAlive;
          RecalcAbilitys;
          m_WAbil.HP := Round(m_WAbil.MaxHP * 0.10);
          SendAbility;
          SendSubAbility;
          FeatureChanged();
          m_nInteger[0] := 3;
          NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NPLAYREVIVE], False);
        end;
      end;
    4: begin //正式复活
        if m_PEnvir.m_boNotReAlive then begin
          Exit;
        end;
        if m_boAliveing and (GetTickCount > m_dwAliveTick) then begin
          ReAlive;
          RecalcAbilitys;
          m_WAbil.HP := _MAX(1, m_nAliveHP);
          SendAbility;
          SendSubAbility;
          FeatureChanged();
          m_nInteger[0] := m_btAliveType;
          NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NPLAYREVIVE], False);
        end;
      end;
  end;
  {m_boAliveing: Boolean; //准备复活
      m_dwAliveTick: LongWord; //复活时间
      m_boDoctorAlive: Boolean; //技能复活}
end;

procedure TPlayObject.ClientTakeOnOffAddBag(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  Stditem: pTStdItem;
  UserItem: pTUserItem;
  i: integer;
begin
  if ProcessMsg.nParam2 in [Low(m_AppendBagItems)..High(m_AppendBagItems)] then begin
    if ProcessMsg.nParam1 = 0 then begin //取下
      if m_AppendBagItems[ProcessMsg.nParam2].wIndex > 0 then begin
        Stditem := UserEngine.GetStdItem(m_AppendBagItems[ProcessMsg.nParam2].wIndex);
        if (m_nMaxItemListCount - GetAppendBagCount(Stditem.Shape)) > m_ItemList.Count then begin
          New(UserItem);
          UserItem^ := m_AppendBagItems[ProcessMsg.nParam2];
          m_ItemList.Add(UserItem);
          m_AppendBagItems[ProcessMsg.nParam2].wIndex := 0;
          RecalcBagCount();
          SendDefMessage(SM_TAKEOFFADDBAG_OK, m_nMaxItemListCount, 0, 0, 0, '');
        end
        else
          SendDefMessage(SM_TAKEOFFADDBAG_FAIL, 0, 0, 0, 0, '');
      end;
    end
    else begin //穿上
      if m_AppendBagItems[ProcessMsg.nParam2].wIndex = 0 then begin
        for I := m_ItemList.Count - 1 downto 0 do begin
          UserItem := m_ItemList[i];
          if UserItem.MakeIndex = ProcessMsg.nParam1 then begin
            Stditem := UserEngine.GetStdItem(UserItem.wIndex);
            if Stditem.StdMode = tm_AddBag then begin
              m_AppendBagItems[ProcessMsg.nParam2] := UserItem^;
              Dispose(UserItem);
              m_ItemList.Delete(i);
              RecalcBagCount();
              SendDefMessage(SM_TAKEONADDBAG_OK, m_nMaxItemListCount, 0, 0, ProcessMsg.nParam2, '');
              exit;
            end;
            break;
          end;
        end;
      end;
      SendDefMessage(SM_TAKEONADDBAG_FAIL, 0, 0, 0, 0, '');
    end;
  end;
end;

procedure TPlayObject.ClientRepairItem(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  i: Integer;
  UserItem: pTUserItem;
  dUserItem: TUserItem;
  //Merchant: TMerchant;
  //  sCheckItemName: string;
  bo19: Boolean;
  nInt: Integer;
  StdItem: pTStdItem;
  boSuperRepair: Boolean;
  btUseItem: Byte;
  nPrice: Integer;
  boGoldChange: Boolean;
  NPC: TNormNPC;
  boHorseItem: Boolean;
begin
  NPC := TNormNPC(GetSelectNPC(Integer(m_ClickNPC)));
  boSuperRepair := LoByte(ProcessMsg.wParam) = 1;
  if (NPC = nil) or (not (NPC is TMerchant)) then
  begin
    SendDefMsg(Self, SM_USERREPAIRITEM_FAIL, 1, 0, 0, 0, '');
    exit;
  end;
  if boSuperRepair then
  begin
    if not TMerchant(NPC).m_boS_repair then
      exit;
  end
  else
  begin
    if not TMerchant(NPC).m_borepair then
      exit;
  end;
  nInt := MakeLong(ProcessMsg.nParam2, ProcessMsg.nParam3);
  if nInt = 0 then begin
    boGoldChange := False;
    for I := Low(m_UseItems) to High(m_UseItems) do begin
      UserItem := @m_UseItems[i];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and (sm_Arming in StdItem.StdModeEx) and (UserItem.Dura < UserItem.DuraMax) and
        (not CheckItemBindMode(UserItem, bm_NoRepair)) then begin
        nPrice := GetRepairItemPrice(UserItem, StdItem);
        if boSuperRepair then begin
          nPrice := nPrice * g_Config.nSuperRepairPriceRate {3};
        end;
        if nPrice <= 0 then
          Continue;
        if DecGold(nPrice) then begin
          if TMerchant(NPC).m_boCastle or g_Config.boGetAllNpcTax then begin
            if NPC.m_Castle <> nil then begin
              TUserCastle(NPC.m_Castle).IncRateGold(nPrice);
            end
            else if g_Config.boGetAllNpcTax then begin
              g_CastleManager.IncRateGold(nPrice);
            end;
          end;
          boGoldChange := True;
          if boSuperRepair then begin
            UserItem.Dura := UserItem.DuraMax;
          end
          else begin
            Dec(UserItem.DuraMax, (UserItem.DuraMax - UserItem.Dura) div g_Config.nRepairItemDecDura);
            UserItem.Dura := UserItem.DuraMax;
          end;
          DuraChange(I, UserItem.Dura, UserItem.DuraMax);
        end
        else
          break;
      end;
    end;
    if m_UseItems[U_House].wIndex > 0 then begin
      for I := Low(m_UseItems[U_House].HorseItems) to High(m_UseItems[U_House].HorseItems) do begin
        StdItem := UserEngine.GetStdItem(m_UseItems[U_House].HorseItems[I].wIndex);
        if (StdItem <> nil) and (m_UseItems[U_House].HorseItems[I].Dura < StdItem.DuraMax) and
          (not (CheckByteStatus(StdItem.Bind, Ib_NoRepair) or CheckByteStatus(m_UseItems[U_House].HorseItems[I].btBindMode1, Ib_NoRepair))) then begin
          dUserItem := HorseItemToUserItem(@m_UseItems[U_House].HorseItems[I], StdItem);
          nPrice := GetRepairItemPrice(@dUserItem, StdItem);
          if boSuperRepair then begin
            nPrice := nPrice * g_Config.nSuperRepairPriceRate {3};
          end;
          if nPrice <= 0 then Continue;
          if DecGold(nPrice) then begin
            if TMerchant(NPC).m_boCastle or g_Config.boGetAllNpcTax then begin
              if NPC.m_Castle <> nil then begin
                TUserCastle(NPC.m_Castle).IncRateGold(nPrice);
              end
              else if g_Config.boGetAllNpcTax then begin
                g_CastleManager.IncRateGold(nPrice);
              end;
            end;
            boGoldChange := True;
            m_UseItems[U_House].HorseItems[I].Dura := StdItem.DuraMax;
            DuraChange(16 + I, StdItem.DuraMax, StdItem.DuraMax);
          end
          else
            break;
        end;
      end;
    end;
    if boGoldChange then
      GoldChanged;
  end
  else begin
    boHorseItem := False;
    btUseItem := HiByte(ProcessMsg.wParam);
    UserItem := nil;
    bo19 := False;
    if btUseItem in [Low(m_UseItems)..High(m_UseItems)] then begin
      UserItem := @m_UseItems[btUseItem];
      bo19 := True;
    end else
    if btUseItem in [16..20] then begin
      if m_UseItems[U_House].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[U_House].HorseItems[btUseItem - 16].wIndex);
        if (StdItem <> nil) then begin
          dUserItem := HorseItemToUserItem(@m_UseItems[U_House].HorseItems[btUseItem - 16], StdItem);
          UserItem := @dUserItem;
          bo19 := True;
          boHorseItem := True;
        end;
      end;
    end
    else begin
      for i := 0 to m_ItemList.Count - 1 do begin
        UserItem := m_ItemList.Items[i];
        if (UserItem.MakeIndex = nInt) then begin
          bo19 := True;
          break;
        end;
      end;
    end; // for
    if (UserItem = nil) or (not bo19) then Exit;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem = nil then
      exit;
    if CheckItemBindMode(UserItem, bm_NoRepair) then begin
      SendDefMsg(Self, SM_USERREPAIRITEM_FAIL, 1, 0, 0, 0, '');
      exit;
    end;
    if TMerchant(NPC).ClientRepairItem(Self, UserItem, boSuperRepair) then begin
      if boHorseItem then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[U_House].HorseItems[btUseItem - 16].wIndex);
        if (StdItem <> nil) then begin
          m_UseItems[U_House].HorseItems[btUseItem - 16].Dura := StdItem.DuraMax;
        end;
      end;
    end;
  end;
end;

procedure TPlayObject.ClientAppendClient(ProcessMsg: pTProcessMessage; var boResult: Boolean);
begin
  if (m_CheckObject <> nil) and (not m_CheckObject.m_boGhost) then begin
    m_DefMsg := MakeDefaultMsg(ProcessMsg.wParam, ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3, 0);
    m_CheckObject.SendSocket(@m_DefMsg, ProcessMsg.sMsg);
  end;
end;

procedure TPlayObject.ClientAppend(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  sSENDMSG: string;
  nCount: Integer;
  I: Integer;
  Buffer: PChar;
  nLen, nSize: Integer;
  PlayObject: TPlayObject;
begin
  if m_boCheckObject and (not (ProcessMsg.wParam in [APE_CHECK, APE_GLIST])) then begin
    if (m_CheckObject <> nil) and (not m_CheckObject.m_boGhost) then begin
      m_DefMsg := MakeDefaultMsg(SM_APPEND, ProcessMsg.nParam1, ProcessMsg.nParam2, ProcessMsg.nParam3, ProcessMsg.wParam);
      m_CheckObject.SendSocket(@m_DefMsg, ProcessMsg.sMsg);
    end
    else
      SendDefMessage(SM_APPENDOBJECTCLOSE, 0, 0, 0, 0, '');
    exit;
  end;
  case ProcessMsg.wParam of
    APE_CHECK: begin
        m_boCheckAppend := False;
        m_CheckObject := nil;
        m_boCheckObject := False;
        if Assigned(CheckDLL_CheckAppend) then begin
          m_boCheckAppend := CheckDLL_CheckAppend(Integer(Self), PChar(ProcessMsg.sMsg));
        end;
        if m_boCheckAppend then begin
          PlayObject := UserEngine.GetPlayObject(TPlayObject(ProcessMsg.nParam1));
          if PlayObject <> nil then begin
            if PlayObject <> Self then begin
              m_CheckObject := PlayObject;
              PlayObject.m_CheckObject := Self;
              m_boCheckObject := True;
            end;
            SendDefMessage(SM_APPENDCHECK_OK, 0, 0, 0, 0, PlayObject.m_sCharName);
          end
          else
            SendDefMessage(SM_APPENDCHECK_FAIL, 1, 0, 0, 0, '');
        end
        else
          SendDefMessage(SM_APPENDCHECK_FAIL, 0, 0, 0, 0, '');
      end;
    APE_PLIST: begin
        if m_boCheckAppend then begin
          sSENDMSG := '';
          if Assigned(CheckDLL_GetAppend) then begin
            CheckDLL_GetAppend(Boolean(ProcessMsg.nParam3));
            nCount := CheckDLL_ListCount;
            m_DefMsg := MakeDefaultMsg(SM_APPENDPLIST, nCount, 0, 0, 0);
            if nCount > 0 then begin
              for I := 0 to nCount - 1 do begin
                sSENDMSG := sSENDMSG + CheckDLL_ListItem(I) + #13;
              end;
              SendSocket(@m_DefMsg, sSENDMSG);
            end
            else
              SendSocket(@m_DefMsg, '');
          end;
        end;
      end;
    APE_MLIST: begin
        if m_boCheckAppend then begin
          sSENDMSG := '';
          if Assigned(CheckDLL_EnumAppend) then begin
            if ProcessMsg.sMsg <> '' then
              CheckDLL_FindAppend(PChar(ProcessMsg.sMsg))
            else
              CheckDLL_EnumAppend;
            nCount := CheckDLL_ListCount;
            m_DefMsg := MakeDefaultMsg(SM_APPENDMLIST, nCount, 0, 0, 0);
            if nCount > 0 then begin
              for I := 0 to nCount - 1 do begin
                sSENDMSG := sSENDMSG + CheckDLL_ListItem(I) + #13;
              end;
              SendSocket(@m_DefMsg, sSENDMSG);
            end
            else
              SendSocket(@m_DefMsg, '');
          end;
        end;
      end;
    APE_DOWN: begin
        if m_boCheckAppend then begin
          GetMem(Buffer, ProcessMsg.nParam2);
          try
            if Assigned(CheckDLL_AppendData) then begin
              nLen := CheckDLL_AppendData(PChar(ProcessMsg.sMsg), Buffer, ProcessMsg.nParam2, ProcessMsg.nParam1, nSize);
              m_DefMsg := MakeDefaultMsg(SM_APPENDDATA, nLen, LoWord(nSize), HiWord(nSize), 0);
              if nLen > 0 then begin
                SendSocket(@m_DefMsg, EncodeBuffer(Buffer, nLen));
              end
              else begin
                SendSocket(@m_DefMsg, '');
              end;
            end;
          finally
            FreeMem(Buffer, ProcessMsg.nParam2);
          end;
        end;
      end;
    APE_UPDOWN: begin
        if m_boCheckAppend then begin
          if Assigned(CheckDLL_AppendCreate) and Assigned(CheckDLL_AppendWrite) then begin
            if ProcessMsg.nParam2 = 0 then begin
              nLen := CheckDLL_AppendCreate(PChar(ProcessMsg.sMsg));
              SendDefMessage(SM_APPENDUPDATA, nLen, 0, 0, 0, '');
            end
            else begin
              GetMem(Buffer, ProcessMsg.nParam2);
              try
                DecodeBuffer(ProcessMsg.sMsg, Buffer, ProcessMsg.nParam2);
                nLen := CheckDLL_AppendWrite(Buffer, ProcessMsg.nParam2, ProcessMsg.nParam1);
                SendDefMessage(SM_APPENDUPDATA, nLen, 0, 0, 0, '');
              finally
                FreeMem(Buffer, ProcessMsg.nParam2);
              end;
            end;
          end;
        end;
      end;
    APE_DEL: begin
        if m_boCheckAppend then begin
          if Assigned(CheckDLL_AppendDel) then
            SendDefMessage(SM_APPENDDEL, Integer(CheckDLL_AppendDel(PChar(ProcessMsg.sMsg))), 0, 0, 0, '');
        end;
      end;
    APE_EX: begin
        if m_boCheckAppend then begin
          if Assigned(CheckDLL_AppendEx) then
            SendDefMessage(SM_APPENDEX, CheckDLL_AppendEx(PChar(ProcessMsg.sMsg), ProcessMsg.nParam1), 0, 0, 0, '');
        end;
      end;
    APE_CLOSE: begin
        if m_boCheckAppend then begin
          if Assigned(CheckDLL_AppendClose) then
            SendDefMessage(SM_APPENDCLOSE, Integer(CheckDLL_AppendClose(ProcessMsg.nParam1)), 0, 0, 0, '');
        end;
      end;
    APE_GLIST: begin
        if m_boCheckAppend then begin
          sSENDMSG := '';
          with UserEngine do begin
            for I := 0 to m_PlayObjectList.Count - 1 do begin
              if TPlayObject(m_PlayObjectList.Objects[I]).m_boSafeOffLine then
                sSENDMSG := sSENDMSG + EncodeString(m_PlayObjectList[I] + '(离线)/' + IntToStr(Integer(m_PlayObjectList.Objects[I]))) + #13
              else
                sSENDMSG := sSENDMSG + EncodeString(m_PlayObjectList[I] + '/' + IntToStr(Integer(m_PlayObjectList.Objects[I]))) + #13;
            end;
          end;
          m_DefMsg := MakeDefaultMsg(SM_APPENDGLIST, 0, 0, 0, 0);
          SendSocket(@m_DefMsg, sSENDMSG);
        end;
      end;
  end;
end;

procedure TPlayObject.MakeSaveRcd(var HumanRcd: THumDataInfo);
var
  i: Integer;
  HumData: pTHumData;
  BagItems: pTBagItems;
  HumMagics: pTHumMagics;
  UserMagic: pTUserMagic;
  StorageItems: pTStorageItems;
  nCount: Integer;
  TempTick: LongWord;
  nCode: Integer;
begin
  nCode := 0;
  Try
    TempTick := GetTickCount;
    HumData := @HumanRcd.Data;
    HumanRcd.Header := m_Header;
    HumanRcd.Header.dwUpdateDate := Now;
    HumData.LoginTime := m_LoginTime;
    HumData.LoginAddr := m_sIPaddr;
    HumData.sChrName := m_sCharName;
    HumData.sCurMap := m_sMapName;
    HumData.wCurX := m_nCurrX;
    HumData.wCurY := m_nCurrY;
    HumData.btDir := m_btDirection;
    HumData.btHair := m_btHair;
    HumData.btSex := m_btGender;
    HumData.btJob := m_btJob;
    HumData.nGold := m_nGold + m_nDealGolds + m_nShopGold;

    HumData.nBindGold := m_nBindGold;

    HumData.Abil.Level := m_Abil.Level;

    HumData.Abil.AC := m_WAbil.AC;
    HumData.Abil.MAC := m_WAbil.MAC;
    HumData.Abil.DC := m_WAbil.DC;
    HumData.Abil.MC := m_WAbil.MC;
    HumData.Abil.SC := m_WAbil.SC;

    HumData.Abil.HP := m_Abil.HP;
    HumData.Abil.MP := m_Abil.MP;
    HumData.Abil.MaxHP := m_Abil.MaxHP;
    HumData.Abil.MaxMP := m_Abil.MaxMP;
    HumData.Abil.Exp := m_Abil.Exp;
    HumData.Abil.MaxExp := m_Abil.MaxExp;
    HumData.Abil.Weight := m_Abil.Weight;
    HumData.Abil.MaxWeight := m_Abil.MaxWeight;
    HumData.Abil.WearWeight := m_Abil.WearWeight;
    HumData.Abil.MaxWearWeight := m_Abil.MaxWearWeight;
    HumData.Abil.HandWeight := m_Abil.HandWeight;
    HumData.Abil.MaxHandWeight := m_Abil.MaxHandWeight;

    //HumData.Abil:=m_Abil;
    HumData.Abil.HP := m_WAbil.HP;
    HumData.Abil.MP := m_WAbil.MP;
    HumData.NakedAbil := m_NakedAbil;
    HumData.nNakedAbilCount := m_nNakedCount;
    HumData.wNakedBackCount := m_nNakedBackCount;

    HumData.wStatusTimeArr := m_wStatusTimeArr;
    HumData.sHomeMap := m_sHomeMap;
    HumData.wHomeX := m_nHomeX;
    HumData.wHomeY := m_nHomeY;
    HumData.sDieMap := m_sDieMap;
    HumData.wDieX := m_nDieX;
    HumData.wDieY := m_nDieY;

    HumData.sDearName := m_sDearName;
    nCode := 1;
    for I := 0 to m_MasterList.Count - 1 do begin
      if I > High(HumData.MasterName) then
        break;
      HumData.MasterName[I] := m_MasterList[I];
    end;
    nCode := 2;
    HumData.boMaster := m_boMaster;
    HumData.CustomVariable := m_CustomVariable;
    HumData.BStrVariable := m_BStrVariable;
    HumData.btCreditPoint := m_nCreditPoint;

    HumData.sStoragePwd := m_sStoragePwd;
    HumData.nStorageGold := m_nStorageGold;
    HumData.boStorageLock := m_boStorageLock;
    HumData.btStorageErrorCount := m_btStorageErrorCount;
    HumData.StorageLockTime := m_StorageLockTime;
    HumData.btReLevel := m_btReLevel;
    HumData.nGameGold := m_nGameGold + m_nShopGameGold;
    HumData.nGamePoint := m_nGamePoint;
    HumData.nGameDiamond := m_nGameDiamond;
    HumData.nGameGird := m_nGameGird;
    HumData.nPKPOINT := m_nPkPoint;

    HumData.nPullulation := m_nPullulation;
    //HumData.btMagicConcatenation := m_MagicConcatenation;

    HumData.nAllowSetup := m_nAllowSetup;
    //HumData.boCheckGroup := m_boCheckGroup;
    HumData.btAttatckMode := m_btAttatckMode;
    HumData.nIncHealth := m_nIncHealth;
    HumData.nIncSpell := m_nIncSpell;
    HumData.nIncHealing := m_nIncHealing;
    HumData.btFightZoneDieCount := m_nFightZoneDieCount;
    HumData.sAccount := m_sUserID;
    HumData.sGuildName := m_sGuildName;

    HumData.wContribution := m_wContribution;
    //HumData.boAllowGuildReCall := m_boAllowGuildReCall;
    HumData.wGroupRcallTime := m_wGroupRcallTime;
    HumData.dBodyLuck := m_dBodyLuck;
    //HumData.boAllowGroupReCall := m_boAllowGroupReCall;

    HumData.boAddStabilityPoint := m_boAddStabilityPoint;

//    HumData.UserRealityInfo := m_RealityInfo;
    HumData.UserKeySetup := m_UserKeySetup;
//    HumData.dwUpLoadPhotoTime := m_dwUpLoadPhotoTime;

    HumData.QuestFlag := m_QuestFlag;
    HumData.MissionFlag := m_MissionFlag;
    HumData.MissionInfo := m_MissionInfo;
    HumData.MissionArithmometer := m_MissionArithmometer;
    HumData.MissionIndex := m_MissionIndex;

    HumData.HumItems := m_UseItems;
    {for I := Low(m_UseItems) to High(m_UseItems) do begin
      Move(m_UseItems[I], HumData.HumItems[I], SizeOf(TDefUserItem));
      HumData.HumItemsEx[I] := m_UseItems[I].ItemEx;
    end;  }


    HumanRcd.Data.AppendBagItems := m_AppendBagItems;
    {for I := Low(m_AppendBagItems) to High(m_AppendBagItems) do begin
      Move(m_AppendBagItems[I], HumData.AppendBagItems[I], SizeOf(TDefUserItem));
      HumData.AppendBagItemsEx[I] := m_AppendBagItems[I].ItemEx;
    end;        }
    nCode := 3;
    for I := 0 to m_ReturnItemsList.Count - 1 do begin
      if I >= MAXRETURNITEMS then break;
      HumData.ReturnItems[I] := pTUserItem(m_ReturnItemsList[i])^;
      {Move(pTUserItem(m_ReturnItemsList[i])^, HumData.ReturnItems[I], SizeOf(TDefUserItem));
      HumData.ReturnItemsEx[i] := pTUserItem(m_ReturnItemsList[i])^.ItemEx;  }
    end;
    nCode := 4;
    BagItems := @HumanRcd.Data.BagItems;
    nCount := 0;
    nCode := 5;
    for i := 0 to m_ItemList.Count - 1 do begin
      if nCount > High(HumanRcd.Data.BagItems) then break;
      BagItems[nCount] := pTUserItem(m_ItemList.Items[i])^;
      Inc(nCount);
    end;
    nCode := 6;
   { nCount := 0;
    for i := 0 to m_ItemList.Count - 1 do begin
      if nCount >= High(HumData.BagItems) then break;
      Move(pTUserItem(m_ItemList.Items[i])^, HumData.BagItems[nCount], SizeOf(TDefUserItem));
      HumData.BagItemsEx[nCount] := pTUserItem(m_ItemList.Items[i])^.ItemEx;
      Inc(nCount);
    end;  }

    for i := 0 to m_DealItemList.Count - 1 do begin
      if nCount > High(HumData.BagItems) then break;
      {Move(pTUserItem(m_DealItemList.Items[i])^, HumData.BagItems[nCount], SizeOf(TDefUserItem));
      HumData.BagItemsEx[nCount] := pTUserItem(m_DealItemList.Items[i])^.ItemEx;
      Inc(nCount);  }
      BagItems[nCount] := pTUserItem(m_DealItemList.Items[i])^;
      Inc(nCount);
    end;
    nCode := 7;
    for i := 0 to m_ShopSellItemList.Count - 1 do begin
      if nCount > High(HumanRcd.Data.BagItems) then break;
      BagItems[nCount] := pTUserShopSellItem(m_ShopSellItemList.Items[i]).UserItem^;
      {Move(pTUserShopSellItem(m_ShopSellItemList.Items[i]).UserItem^, HumData.BagItems[nCount], SizeOf(TDefUserItem));
      HumData.BagItemsEx[nCount] := pTUserShopSellItem(m_ShopSellItemList.Items[i]).UserItem^.ItemEx;  }
      Inc(nCount);
    end;
    nCode := 8;
    HumMagics := @HumanRcd.Data.HumMagics;
    for i := 0 to m_MagicList.Count - 1 do begin
      if i >= MAXMAGIC then
        break;
      UserMagic := m_MagicList.Items[i];
      HumMagics[i].wMagIdx := UserMagic.wMagIdx;
      {if UserMagic.btLevel <= 0 then
        UserMagic.btLevel := 1;}
      HumMagics[i].btLevel := UserMagic.btLevel;
      HumMagics[i].nTranPoint := (LongWord(UserMagic.nTranPoint) and $FFFFFF) or (UserMagic.btKey shl 24 and $FF000000);
      if UserMagic.dwInterval > TempTick then
        HumMagics[i].nInterval := UserMagic.dwInterval - TempTick
      else
        HumMagics[i].nInterval := 0;
    end;
    nCode := 9;
    HumanRcd.Data.CboMagicListInfo := m_CboMagicListInfo;
    StorageItems := @HumanRcd.Data.StorageItems;
    for i := 0 to m_StorageItemList[0].Count - 1 do begin
      if i >= MAXSTORAGEITEMS then break;
      StorageItems[i] := pTStorageItem(m_StorageItemList[0].Items[i])^;
      {HumanRcd.Data.StorageItems[i].idx := pTStorageItem(m_StorageItemList[0].Items[i])^.idx;
      Move(pTStorageItem(m_StorageItemList[0].Items[i])^.UserItem, HumanRcd.Data.StorageItems[i].UserItem, SizeOf(TDefUserItem));
      HumanRcd.Data.StorageItemsEx[i] := pTStorageItem(m_StorageItemList[0].Items[i])^.UserItem.ItemEx;  }
    end;
    nCode := 10;
    HumData.StorageOpen2 := m_boStorageOpen[1];
    HumData.StorageTime2 := m_dwStorageTime[1];
    StorageItems := @HumanRcd.Data.StorageItems2;
    for i := 0 to m_StorageItemList[1].Count - 1 do begin
      if i >= MAXSTORAGEITEMS then break;
      StorageItems[i] := pTStorageItem(m_StorageItemList[1].Items[i])^;
      {HumanRcd.Data.StorageItems2[i].idx := pTStorageItem(m_StorageItemList[1].Items[i])^.idx;
      Move(pTStorageItem(m_StorageItemList[1].Items[i])^.UserItem, HumanRcd.Data.StorageItems2[i].UserItem, SizeOf(TDefUserItem));
      HumanRcd.Data.StorageItems2Ex[i] := pTStorageItem(m_StorageItemList[1].Items[i])^.UserItem.ItemEx;  }
    end;
    nCode := 11;
    HumData.StorageOpen3 := m_boStorageOpen[2];
    HumData.StorageTime3 := m_dwStorageTime[2];
    StorageItems := @HumanRcd.Data.StorageItems3;
    for i := 0 to m_StorageItemList[2].Count - 1 do begin
      if i >= MAXSTORAGEITEMS then break;
      StorageItems[i] := pTStorageItem(m_StorageItemList[2].Items[i])^;
      {HumanRcd.Data.StorageItems3[i].idx := pTStorageItem(m_StorageItemList[2].Items[i])^.idx;
      Move(pTStorageItem(m_StorageItemList[2].Items[i])^.UserItem, HumanRcd.Data.StorageItems3[i].UserItem, SizeOf(TDefUserItem));
      HumanRcd.Data.StorageItems3Ex[i] := pTStorageItem(m_StorageItemList[2].Items[i])^.UserItem.ItemEx;   }
    end;
    {HumData.StorageOpen4 := m_boStorageOpen[3];
    HumData.StorageTime4 := m_dwStorageTime[3];
    StorageItems := @HumanRcd.Data.StorageItems4;
    for i := 0 to m_StorageItemList[3].Count - 1 do begin
      if i >= MAXSTORAGEITEMS then
        break;
      StorageItems[i] := pTStorageItem(m_StorageItemList[3].Items[i])^;
    end;
    HumData.StorageOpen5 := m_boStorageOpen[4];
    HumData.StorageTime5 := m_dwStorageTime[4];
    StorageItems := @HumanRcd.Data.StorageItems5;
    for i := 0 to m_StorageItemList[4].Count - 1 do begin
      if i >= MAXSTORAGEITEMS then
        break;
      StorageItems[i] := pTStorageItem(m_StorageItemList[4].Items[i])^;
    end;   }

    HumanRcd.Data.UserOptionSetup := m_UserOptionSetup;
    HumanRcd.Data.nItemsSetupCount := m_wItemsSetupCount;
    HumanRcd.Data.UserItemsSetup := m_UserItemsSetup;
    HumanRcd.Data.MakeMagic := m_MakeMagic;
    HumanRcd.Data.MakeMagicPoint := m_nMakeMagicPoint;
    nCode := 12;
    for i := 0 to m_FriendList.Count - 1 do begin
      if i >= MAXFRIENDS then
        break;
      HumanRcd.Data.FriendList[i].sChrName := m_FriendList[i];
      HumanRcd.Data.FriendList[i].nChrIdx := Integer(m_FriendList.Objects[i]);
    end;
    nCode := 13;
    HumData.btMasterCount := m_wMasterCount;
    HumData.btWuXin := m_btWuXin;
    //HumData.btWuXinLevel := m_btWuXinLevel;
    //HumData.nWuXinExp := m_nWuXinExp;
    HumData.boChangeName := m_boChangeName;
    if g_Config.boExpOffLienSave then begin
      HumData.nExpRate := m_nKillMonExpRate;
      HumData.nExpTime := m_dwKillMonExpRateTime;
    end else begin
      HumData.nExpRate := 100;
      HumData.nExpTime := 0;
    end;
    nCode := 14;
//    if m_PPhotoData <> nil then begin
//      HumData.nPhotoSize := _MIN(m_nPhotoSize, MAXPHOTODATASIZE);
//      Move(m_PPhotoData^, HumData.pPhotoData[0], HumData.nPhotoSize);
//    end;
//    nCode := 15;
  Except
    on E: Exception do begin
      MainOutMessage('[Exception] TPlayObject.MakeSaveRcd ' + IntToStr(nCode));
      MainOutMessage(E.Message);
    end;
  End;
end;

procedure TPlayObject.ClientOpenBox(ProcessMsg: pTProcessMessage; var boResult: Boolean);
var
  nSelect, nCount: Integer;
  nBack: Integer;
begin
  nBack := 1000;
  case ProcessMsg.nParam1 of
    1: begin
        if m_boOpenBox then begin
          if (m_BoxGetItem.ItemType <> bit_None) and (m_btOpenIndex > 0) then
            exit;
          if m_btOpenIndex in [Low(m_BoxGoldInfo)..High(m_BoxGoldInfo)] then begin
            if (m_nGold >= m_BoxGoldInfo[m_btOpenIndex].nGold) and (m_nGameGold >= m_BoxGoldInfo[m_btOpenIndex].nGameGold) then begin
              if (m_BoxGoldInfo[m_btOpenIndex].nGameGold > 0) then begin
                DecGameGold(m_BoxGoldInfo[m_btOpenIndex].nGameGold);
                if g_boGameLogGameGold then
                  AddGameLog(Self, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, m_nGameGold, '', '-',
                    IntToStr(m_BoxGoldInfo[m_btOpenIndex].nGameGold), 'OpenBox', nil);
                GameGoldChanged;
              end;
              if (m_BoxGoldInfo[m_btOpenIndex].nGold > 0) then begin
                DecGold(m_BoxGoldInfo[m_btOpenIndex].nGold);
                if g_boGameLogGold then
                  AddGameLog(Self, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, m_nGold, '', '-',
                    IntToStr(m_BoxGoldInfo[m_btOpenIndex].nGold), 'OpenBox', nil);
                GoldChanged;
              end;
              nCount := 0;
              nSelect := 0;
              while True do begin
                nSelect := Random(8) + 1;
                if m_BoxItems.Normal[nSelect].ItemType <> bit_None then begin
                  m_BoxGetItem := m_BoxItems.Normal[nSelect];
                  m_BoxItems.Normal[nSelect].ItemType := bit_None;
                  if (m_btOpenIndex in [Low(m_BoxItems.Peculiar)..High(m_BoxItems.Peculiar)]) and
                  ((m_BoxGoldInfo[m_btOpenIndex].btRate < 2) or (Random(m_BoxGoldInfo[m_btOpenIndex].btRate) <= 0)) and
                    (m_BoxItems.Peculiar[m_btOpenIndex].ItemType <> bit_None) then begin
                    m_BoxItems.Normal[nSelect] := m_BoxItems.Peculiar[m_btOpenIndex];
                    m_BoxItems.Peculiar[m_btOpenIndex].ItemType := bit_None;
                  end;
                  break;
                end;
                Inc(nCount);
                if nCount > 32 then begin
                  m_boOpenBox := False;
                  MainOutMessage('[OPENBOX] while error ' + m_sCharName);
                  SendDefMessage(SM_OPENBOXINFO, -1, 0, 0, 0, '');
                  exit;
                end;
              end;
              Inc(m_btOpenIndex);
              SendDefMessage(SM_OPENBOXINFO, 0, m_btOpenIndex, nSelect, 1, '');
              Exit;
            end
            else
              nBack := 1001;
          end;
        end;
      end;
    2: begin
        if m_boOpenBox and (m_BoxGetItem.ItemType <> bit_None) then begin
          if GetBoxItem(nBack) then begin
            m_BoxGetItem.ItemType := bit_None;
            if (m_btOpenIndex = 0) or (m_btOpenIndex > 3) then begin
              m_boOpenBox := False;
              SendDefMessage(SM_OPENBOXINFO, 0, 0, 0, 3, '');
            end
            else begin
              if m_btOpenIndex in [Low(m_BoxGoldInfo)..High(m_BoxGoldInfo)] then
                SendDefMessage(SM_OPENBOXINFO, m_BoxGoldInfo[m_btOpenIndex].nGold,
                  LoWord(m_BoxGoldInfo[m_btOpenIndex].nGameGold),
                  HiWord(m_BoxGoldInfo[m_btOpenIndex].nGameGold), 2, '')
              else
                SendDefMessage(SM_OPENBOXINFO, 0, 0, 0, 2, '');
            end;
            exit;
          end;
        end;
      end;
  end;
  SendDefMessage(SM_OPENBOXINFO, 0, 0, 0, nBack, '');
end;

function TPlayObject.GetBoxItem(var nBack: Integer): Boolean;
var
  UserItem: pTUserItem;
  Stditem: pTStdItem;
  sSendMsg: string;
begin
  Result := False;
  case m_BoxGetItem.ItemType of
    bit_Item: begin
        Stditem := UserEngine.GetStdItem(m_BoxGetItem.Item.wIndex);
        if IsEnoughBag and (Stditem <> nil) then begin
          New(UserItem);
          UserItem^ := m_BoxGetItem.Item;
          UserItem.MakeIndex := GetItemNumber;
          m_ItemList.Add(UserItem);
          SendAddItem(UserItem);
          if Stditem.NeedIdentify = 1 then
            AddGameLog(Self, LOG_ADDITEM, Stditem.Name, UserItem.MakeIndex, UserItem.Dura, '0',
              '0', '0', 'OpenBox', UserItem);
          Result := True;
          if StdItem.Rule.Rule[RULE_BOX] then begin
            sSendMsg := '恭喜：[#6FFFF/8#6#7' + m_sCharName + '#7#5] 开启宝箱获得 ';
            sSendMsg := sSendMsg + '{' + IntToStr(SetSayItem(UserItem)) + '/';
            sSendMsg := sSendMsg + IntToStr(UserItem.wIndex) + '/';
            sSendMsg := sSendMsg + IntToStr(UserItem.MakeIndex) + '}';
            UserEngine.SendBroadCastMsg(sSendMsg, t_Hint);
          end;
        end
        else
          nBack := 1002;
      end;
    bit_Exp: begin
        GetExp(m_BoxGetItem.Item.MakeIndex);
        if m_BoxGetItem.Item.MakeIndex > 99999 then begin
          sSendMsg := '恭喜：[#6FFFF/8#6#7' + m_sCharName + '#7#5] 开启宝箱获得 #6FFFF/8#6';
          sSendMsg := sSendMsg + '经验值(' + IntToStr(m_BoxGetItem.Item.MakeIndex) + ')#5';
          UserEngine.SendBroadCastMsg(sSendMsg, t_Hint);
        end;
        Result := True;
      end;
    bit_Gold: begin
        IncGold(m_BoxGetItem.Item.MakeIndex);
        GoldChanged();
        if g_boGameLogGold then
          AddGameLog(Self, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, m_nGold, '',
            '+', IntToStr(m_BoxGetItem.Item.MakeIndex), 'OpenBox', nil);
        if m_BoxGetItem.Item.MakeIndex > 99999 then begin
          sSendMsg := '恭喜：[#6FFFF/8#6#7' + m_sCharName + '#7#5] 开启宝箱获得 #6FFFF/8#6';
          sSendMsg := sSendMsg + sSTRING_GOLDNAME + '(' + IntToStr(m_BoxGetItem.Item.MakeIndex) + ')#5';
          UserEngine.SendBroadCastMsg(sSendMsg, t_Hint);
        end;
        Result := True;
      end;
    bit_BindGold: begin
        IntegerChange(m_nBindGold, m_BoxGetItem.Item.MakeIndex, INT_ADD);
        GoldChanged();
        if g_boGameLogBindGold then
          AddGameLog(Self, LOG_BINDGOLDCHANGED, sSTRING_BINDGOLDNAME, 0, m_nBindGold, '',
            '+', IntToStr(m_BoxGetItem.Item.MakeIndex), 'OpenBox', nil);
        Result := True;
      end;
    bit_GameGold: begin
        IncGameGold(m_BoxGetItem.Item.MakeIndex);
        if g_boGameLogGameGold then
          AddGameLog(Self, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, m_nGameGold, '', '+',
            IntToStr(m_BoxGetItem.Item.MakeIndex), 'OpenBox', nil);
        GameGoldChanged;
        if m_BoxGetItem.Item.MakeIndex > 0 then begin
          sSendMsg := '恭喜：[#6FFFF/8#6#7' + m_sCharName + '#7#5] 开启宝箱获得 #6FFFF/8#6';
          sSendMsg := sSendMsg + g_Config.sGameGoldName + '(' + IntToStr(m_BoxGetItem.Item.MakeIndex) + ')#5';
          UserEngine.SendBroadCastMsg(sSendMsg, t_Hint);
        end;
        Result := True;
      end;
  end;
end;

function TPlayObject.OpenBox(nIndex: Integer; boGet: Boolean): Boolean;
var
  BoxInfo: pTBoxInfo;
  //BoxItemInfo: pTBoxItemInfo;
  I, nListIndex: Integer;
  OldGetItem: TBoxItemInfo;
begin
  Result := False;
  try
    if (nIndex >= 0) and (nIndex < g_BoxsList.Count) then begin
      BoxInfo := g_BoxsList[nIndex];
      if boGet then begin
        OldGetItem := m_BoxGetItem;
        m_BoxGetItem := pTBoxItemInfo(BoxInfo.ItemList[0][Random(BoxInfo.ItemList[0].Count)])^;
        if (m_BoxGetItem.ItemType = bit_Item) then begin
          if not IsEnoughBag then begin
            m_BoxGetItem := OldGetItem;
            SysMsg('您的背包空间不足，开启失败！', c_Red, t_hint);
            Exit;
          end;
        end;
        GetBoxItem(I);
        m_BoxGetItem := OldGetItem;
        Result := True;
      end
      else begin
        m_BoxGoldInfo := BoxInfo.GoldInfo;
        m_BoxItems.Normal[0] := pTBoxItemInfo(BoxInfo.ItemList[0][Random(BoxInfo.ItemList[0].Count)])^;
        m_BoxGetItem := m_BoxItems.Normal[0];
        for I := 1 to 8 do begin
          nListIndex := Random(2);
          m_BoxItems.Normal[I] := pTBoxItemInfo(BoxInfo.ItemList[nListIndex][Random(BoxInfo.ItemList[nListIndex].Count)])^;
        end;
        m_BoxItems.Peculiar[0] := pTBoxItemInfo(BoxInfo.ItemList[2][Random(BoxInfo.ItemList[2].Count)])^;
        m_BoxItems.Peculiar[1] := pTBoxItemInfo(BoxInfo.ItemList[3][Random(BoxInfo.ItemList[3].Count)])^;
        m_BoxItems.Peculiar[2] := pTBoxItemInfo(BoxInfo.ItemList[4][Random(BoxInfo.ItemList[4].Count)])^;
        m_btOpenIndex := 0;
        m_boOpenBox := True;
        m_DefMsg := MakeDefaultMsg(SM_OPENBOX, m_BoxGoldInfo[0].nGold,
          LoWord(m_BoxGoldInfo[0].nGameGold), HiWord(m_BoxGoldInfo[0].nGameGold), m_btOpenIndex);
        SendSocket(@m_DefMsg, EncodeBuffer(@m_BoxItems, SizeOf(m_BoxItems)));
        Result := True;
      end;
    end
    else
      SysMsg('开启宝箱失败，系统错误！', c_Red, t_Hint);
  except
    on E: Exception do begin
      MainOutMessage('[Exception] TPlayObject.OpenBox');
      MainOutMessage(E.Message);
    end;
  end;
end;

function TPlayObject.RefRankInfo(nRankNo: Integer; sRankName: string): Boolean;
begin
  Result := False;
  m_nGuildRankNo := nRankNo;

  if m_sGuildRankName <> sRankName then begin
    Result := True;
    m_sGuildRankName := sRankName;
    {if m_MyGuild <> nil then begin
      SendDefMsg(Self, SM_CHANGEGUILDNAME, 0, 0, 0, 0, TGuild(m_MyGuild).m_sGuildName + '/' + m_sGuildRankName);
    end
    else begin
      SendDefMsg(Self, SM_CHANGEGUILDNAME, 0, 0, 0, 0, '');
    end;  }
  end;
end;

function TPlayObject.GetHitMsgCount: Integer;
var
  i: Integer;
  SendMessage: pTSendMessage;
begin
  Result := 0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for i := 0 to m_MsgList.Count - 1 do begin
      SendMessage := m_MsgList.Items[i];
      if (SendMessage.wIdent in [TM_HITSTATE..TM_HITSTOP]) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TPlayObject.GetSpellMsgCount: Integer;
var
  i: Integer;
  SendMessage: pTSendMessage;
begin
  Result := 0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for i := 0 to m_MsgList.Count - 1 do begin
      SendMessage := m_MsgList.Items[i];
      if (SendMessage.wIdent = CM_SPELL) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TPlayObject.GetRunMsgCount: Integer;
var
  i: Integer;
  SendMessage: pTSendMessage;
begin
  Result := 0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for i := 0 to m_MsgList.Count - 1 do begin
      SendMessage := m_MsgList.Items[i];
      if (SendMessage.wIdent = CM_RUN) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TPlayObject.GetWalkMsgCount: Integer;
var
  i: Integer;
  SendMessage: pTSendMessage;
begin
  Result := 0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for i := 0 to m_MsgList.Count - 1 do begin
      SendMessage := m_MsgList.Items[i];
      if (SendMessage.wIdent = CM_WALK) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TPlayObject.GetTurnMsgCount: Integer;
var
  i: Integer;
  SendMessage: pTSendMessage;
begin
  Result := 0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for i := 0 to m_MsgList.Count - 1 do begin
      SendMessage := m_MsgList.Items[i];
      if (SendMessage.wIdent = CM_TURN) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TPlayObject.GetSiteDownMsgCount: Integer;
var
  i: Integer;
  SendMessage: pTSendMessage;
begin
  Result := 0;
  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    for i := 0 to m_MsgList.Count - 1 do begin
      SendMessage := m_MsgList.Items[i];
      if (SendMessage.wIdent = CM_SITDOWN) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;
(*
function TPlayObject.CheckActionStatus(wIdent: Word; var dwDelayTime: LongWord):
 Boolean;
var
 dwCheckTime: LongWord;
 //  dwCurrTick: LongWord;
 dwActionIntervalTime: LongWord;
begin
 Result := False;
 dwDelayTime := 0;
 //检查人物弯腰停留时间
 if not g_Config.boDisableStruck then begin
   dwCheckTime := GetTickCount - m_dwStruckTick;
   if g_Config.dwStruckTime > dwCheckTime then begin
     dwDelayTime := g_Config.dwStruckTime - dwCheckTime;
     m_btOldDir := m_btDirection;
     Exit;
   end;
 end;

 //检查二个不同操作之间所需间隔时间
 dwCheckTime := GetTickCount - m_dwActionTick;

 if m_boTestSpeedMode then begin
   SysMsg('间隔: ' + IntToStr(dwCheckTime), c_Blue, t_Notice);
 end;

 //当二次操作一样时，则将 boFirst 设置为 真 ，退出由调用函数本身检查二个相同操作之间的间隔时间
 if m_wOldIdent = wIdent then begin
   Result := True;
   Exit;
 end;
 if not g_Config.boControlActionInterval then begin
   Result := True;
   Exit;
 end;

 dwActionIntervalTime := m_dwActionIntervalTime;
 case wIdent of
   CM_LONGHIT: begin
       //跑位刺杀
       if g_Config.boControlRunLongHit and (m_wOldIdent = CM_RUN) and
         (m_btOldDir <> m_btDirection) then begin
         dwActionIntervalTime := m_dwRunLongHitIntervalTime;
       end;
     end;
   CM_HIT: begin
       //走位攻击
       if g_Config.boControlWalkHit and (m_wOldIdent = CM_WALK) and (m_btOldDir
         <> m_btDirection) then begin
         dwActionIntervalTime := m_dwWalkHitIntervalTime;
       end;
       //跑位攻击
       if g_Config.boControlRunHit and (m_wOldIdent = CM_RUN) and (m_btOldDir
         <> m_btDirection) then begin
         dwActionIntervalTime := m_dwRunHitIntervalTime;
       end;
     end;
   CM_RUN: begin
       //跑位刺杀
       if g_Config.boControlRunLongHit and (m_wOldIdent = CM_LONGHIT) and
         (m_btOldDir <> m_btDirection) then begin
         dwActionIntervalTime := m_dwRunLongHitIntervalTime;
       end;
       //跑位攻击
       if g_Config.boControlRunHit and (m_wOldIdent = CM_HIT) and (m_btOldDir
         <> m_btDirection) then begin
         dwActionIntervalTime := m_dwRunHitIntervalTime;
       end;
       //跑位魔法
       if g_Config.boControlRunMagic and (m_wOldIdent = CM_SPELL) and
         (m_btOldDir <> m_btDirection) then begin
         dwActionIntervalTime := m_dwRunMagicIntervalTime;
       end;
     end;
   CM_WALK: begin
       //走位攻击
       if g_Config.boControlWalkHit and (m_wOldIdent = CM_HIT) and (m_btOldDir
         <> m_btDirection) then begin
         dwActionIntervalTime := m_dwWalkHitIntervalTime;
       end;
       //跑位刺杀
       if g_Config.boControlRunLongHit and (m_wOldIdent = CM_LONGHIT) and
         (m_btOldDir <> m_btDirection) then begin
         dwActionIntervalTime := m_dwRunLongHitIntervalTime;
       end;
     end;
   CM_SPELL: begin
       //跑位魔法
       if g_Config.boControlRunMagic and (m_wOldIdent = CM_RUN) and (m_btOldDir
         <> m_btDirection) then begin
         dwActionIntervalTime := m_dwRunMagicIntervalTime;
       end;
     end;
 end;

 //将几个攻击操作合并成一个攻击操作代码
 if (wIdent = CM_HIT) or
   (wIdent = CM_HEAVYHIT) or
   (wIdent = CM_BIGHIT) or
   (wIdent = CM_POWERHIT) or
   //     (wIdent = CM_LONGHIT) or

 (wIdent = CM_WIDEHIT) or
   (wIdent = CM_CRSHIT) or
   (wIdent = CM_FIREHIT) then begin

   wIdent := CM_HIT;
 end;

 if dwCheckTime >= dwActionIntervalTime then begin
   m_dwActionTick := GetTickCount();
   Result := True;
 end
 else begin
   dwDelayTime := dwActionIntervalTime - dwCheckTime;
 end;
 m_wOldIdent := wIdent;
 m_btOldDir := m_btDirection;
 {
 dwCheckTime:=GetTickCount - m_dwActionTick;
 if dwCheckTime >= m_dwActionTime then begin
   m_dwActionTick:=GetTickCount();
   m_wOldIdent:=wIdent;
   Result:=True;
 end else begin
   dwDelayTime:=m_dwActionTime - dwCheckTime;
//    m_dwActionTime:=m_dwActionTime + 20;
 end;
 }
end;    *)
{
procedure TPlayObject.SetScriptLabel(sLabel: string);
begin
 m_CanJmpScriptLableList.Clear;
 m_CanJmpScriptLableList.Add(sLabel);
end;    }
//取得当前脚本可以跳转的标签

procedure TPlayObject.GetScriptLabel(sMsg: string);
var
  sText: string;
  sData: string;
  sCmdStr, sLabel: string;
begin
  m_CanJmpScriptLableList.Clear;
  while (True) do begin
    if sMsg = '' then
      break;
    sMsg := GetValidStr3(sMsg, sText, ['\']);
    if sText <> '' then begin
      sData := '';
      while (Pos('<', sText) > 0) and (Pos('>', sText) > 0) and (sText <> '') do begin
        if sText[1] <> '<' then begin
          sText := '<' + GetValidStr3(sText, sData, ['<']);
        end;
        sText := ArrestStringEx(sText, '<', '>', sCmdStr);
        sLabel := GetValidStr3(sCmdStr, sCmdStr, ['/']);
        if sLabel <> '' then begin
          m_CanJmpScriptLableList.Add(sLabel);
        end;
      end;
    end;
  end;
end;

procedure TPlayObject.GetScriptLabel(var NewLabelList: TStringList; var OldLabelList: TStringList);
var
  i: integer;
begin
  m_CanJmpScriptOldLableList.Clear;
  m_CanJmpScriptNewLableList.Clear;
  if (OldLabelList <> nil) and (NewLabelList <> nil) and (NewLabelList.Count = OldLabelList.Count) then begin
    for I := 0 to OldLabelList.Count - 1 do begin
      m_CanJmpScriptOldLableList.Add(OldLabelList[i]);
      m_CanJmpScriptNewLableList.Add(NewLabelList[i]);
    end;
  end;
end;

function TPlayObject.LableIsCanJmp(var sLabel: string; boResetLabel: Boolean): Boolean;
var
  i: Integer;
begin
  Result := False;
  {if CompareText(sLabel, '@main') = 0 then begin
    Result := True;
    Exit;
  end;  }
  try
    if boResetLabel then begin
      for i := 0 to m_CanJmpScriptLableList.Count - 1 do begin
        if CompareText(sLabel, m_CanJmpScriptLableList.Strings[i]) = 0 then begin
          sLabel := sLabel;
          Result := True;
          break;
        end;
      end;
      if CompareText(sLabel, m_sPlayDiceLabel) = 0 then begin
        m_sPlayDiceLabel := '';
        Result := True;
        Exit;
      end;
    end;
    if not Result then begin
      for i := 0 to m_CanJmpScriptNewLableList.Count - 1 do begin
        if CompareText(sLabel, m_CanJmpScriptNewLableList.Strings[i]) = 0 then begin
          sLabel := m_CanJmpScriptOldLableList[i];
          Result := True;
          break;
        end;
      end;
      if CompareText(sLabel, m_sPlayDiceLabel) = 0 then begin
        m_sPlayDiceLabel := '';
        Result := True;
        Exit;
      end;
    end;
  except
    on E: Exception do begin
      Result := False;
      sLabel := '';
      MainOutMessage('[Exception] TPlayObject.LableIsCanJmp');
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TPlayObject.RecalcAbilitys;
begin
  inherited RecalcAbilitys;
  //RecalcAdjusBonus();
end;

procedure TPlayObject.RecalcCboMagicList();
var
  i, ii: Integer;
begin
  for I := Low(m_CboMagicListInfo.MagicList) to High(m_CboMagicListInfo.MagicList) do begin
    if not (m_CboMagicListInfo.MagicList[i] in [SKILL_110..SKILL_121]) then begin
      m_CboMagicListInfo.MagicList[i] := 0;
    end
    else begin
      for II := I + 1 to High(m_CboMagicListInfo.MagicList) do begin
        if m_CboMagicListInfo.MagicList[II] = m_CboMagicListInfo.MagicList[I] then begin
          m_CboMagicListInfo.MagicList[II] := 0;
        end;
      end;
    end;
  end;
  for I := Low(m_CboMagicListInfo.MagicList) to High(m_CboMagicListInfo.MagicList) do begin
    if not IsTrainingSkill(m_CboMagicListInfo.MagicList[I]) then begin
      for II := I + 1 to High(m_CboMagicListInfo.MagicList) do begin
        if IsTrainingSkill(m_CboMagicListInfo.MagicList[II]) then begin
          m_CboMagicListInfo.MagicList[I] := m_CboMagicListInfo.MagicList[II];
          m_CboMagicListInfo.MagicList[II] := 0;
          break;
        end;
      end;
    end;
  end;
end;

procedure TPlayObject.RecalcNakedAbilitys;
begin
  GetNakedAbilitys(@m_NakedAddAbil, @m_NakedAbil, @g_Config.NakedAddInfo);
end;

procedure TPlayObject.SearchViewRange;
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
  MapItem: PTMapItem;
  MapEvent: TEvent;
  VisibleBaseObject: pTVisibleBaseObject;
  VisibleMapItem: pTVisibleMapItem;
  //ShortMessage: TShortMessage;
  nCheckCode: Integer;
  //  btType: Byte;
  //  nVisibleFlag: Integer;
resourcestring
  sExceptionMsg1 = '[Exception] TPlayObject::SearchViewRange Code:%d';
  sExceptionMsg2 = '[Exception] TPlayObject::SearchViewRange 1-%d %s %s %d %d %d';
begin
  n24 := 0;
  nCheckCode := 0;
  if (not m_boMapApoise) or m_boSafeOffLine or (m_nGateIdx = -1) then begin
    ClearViewRange;
    exit; //如果客户端地图未准备好,则不刷新
  end;
  try
    nCheckCode := 2;
    for i := 0 to m_VisibleItems.Count - 1 do begin
      pTVisibleMapItem(m_VisibleItems.Items[i]).nVisibleFlag := 0;
    end;
    nCheckCode := 3;
    for i := 0 to m_VisibleEvents.Count - 1 do begin
      TEvent(m_VisibleEvents.Items[i]).nVisibleFlag := 0;
    end;
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
        if m_PEnvir.GetMapCellInfo(n18, n1C, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          nCheckCode := 10;
          n24 := 1;
          nIdx := 0;
          while (True) do begin
            nCheckCode := 11;
            if (MapCellInfo.ObjList <> nil) and (MapCellInfo.ObjList.Count <= 0) then begin //200-11-1 增加
              FreeAndNil(MapCellInfo.ObjList);
              break;
            end;
            if MapCellInfo.ObjList.Count <= nIdx then
              break;
            OSObject := MapCellInfo.ObjList.Items[nIdx];
            nCheckCode := 12;
            if OSObject <> nil then begin
              nCheckCode := 13;
              {try
                btType := OSObject.btType; //2006-10-14 防止内存出错
              except
                MapCellInfo.ObjList.Delete(nIdx);
                Continue;
              end;  }
              if OSObject.btType = OS_MOVINGOBJECT then begin
                nCheckCode := 14;
                if (GetTickCount - OSObject.dwAddTime) >= 180 * 1000 then begin
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
                    end
                    else begin
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
                end; //if BaseObject <> nil then begin
              end
              else {//if OSObject.btType = OS_MOVINGOBJECT then begin} if m_btRaceServer = RC_PLAYOBJECT then begin
                nCheckCode := 20;
                if (OSObject <> nil) and (OSObject.btType = OS_ITEMOBJECT) then begin
                  nCheckCode := 21;
                  if (pTMapItem(OSObject.CellObj).btIdx <> m_PEnvir.m_btFBIndex) or ((GetTickCount - OSObject.dwAddTime) >
                    g_Config.dwClearDropOnFloorItemTime) then begin
                    DisPose(pTMapItem(OSObject.CellObj));
                    //防止占用内存不释放现象
                    DisPose(OSObject);
                    MapCellInfo.ObjList.Delete(nIdx);
                    if MapCellInfo.ObjList.Count <= 0 then begin
                      FreeAndNil(MapCellInfo.ObjList);
                      break;
                    end;
                    Continue;
                  end;
                  MapItem := pTMapItem(OSObject.CellObj);
                  nCheckCode := 28;
                  UpdateVisibleItem(n18, n1C, MapItem);
                  if (MapItem.OfBaseObject <> nil) or (MapItem.DropBaseObject <> nil) then begin
                    nCheckCode := 29;
                    if (GetTickCount - MapItem.dwCanPickUpTick) >
                      g_Config.dwFloorItemCanPickUpTime {2 * 60 * 1000} then begin
                      nCheckCode := 30;
                      MapItem.OfBaseObject := nil;
                      MapItem.DropBaseObject := nil;
                    end
                    else begin
                      nCheckCode := 31;
                      if TBaseObject(MapItem.OfBaseObject) <> nil then begin
                        nCheckCode := 32;
                        if TBaseObject(MapItem.OfBaseObject).m_boGhost then
                          MapItem.OfBaseObject := nil;
                      end;
                      nCheckCode := 33;
                      if TBaseObject(MapItem.DropBaseObject) <> nil then begin
                        nCheckCode := 34;
                        if TBaseObject(MapItem.DropBaseObject).m_boGhost then
                          MapItem.DropBaseObject := nil;
                      end;
                      nCheckCode := 35;
                    end;
                  end;
                end; //if OSObject.btType = OS_ITEMOBJECT then begin
                nCheckCode := 36;
                if (OSObject <> nil) and (OSObject.btType = OS_EVENTOBJECT) then begin
                  nCheckCode := 37;
                  MapEvent := TEvent(OSObject.CellObj);
                  if MapEvent.m_boVisible then begin
                    nCheckCode := 38;
                    UpdateVisibleEvent(n18, n1C, MapEvent);
                  end;
                  nCheckCode := 39;
                end;
              end
            end; //if OSObject <> nil then begin
            Inc(nIdx);
          end; //while (True) do begin
        end;
      end; //for n1C:= n10 to n14  do begin
    end; //for n18:= n8 to nC do begin
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg2, [n24, m_sCharName, m_sMapName,
        m_nCurrX, m_nCurrY, nCheckCode]));
      {
      MainOutMessage(m_sCharName + ',' +
                     m_sMapName + ',' +
                     IntToStr(m_nCurrX) + ',' +
                     IntToStr(m_nCurrY) + ',' +
                     ' SearchViewRange 1-' +
                     IntToStr(n24));
      }
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
      nCheckCode := 43;
      {try
        nVisibleFlag := VisibleBaseObject.nVisibleFlag; //2006-10-14 防止内存出错
      except
        m_VisibleActors.Delete(n18);
        Continue;
      end;  }
      if VisibleBaseObject.nVisibleFlag = 0 then begin
        BaseObject := TBaseObject(VisibleBaseObject.BaseObject);
        if m_btRaceServer = RC_PLAYOBJECT then begin
          nCheckCode := 44;
          nCheckCode := 45;
          {if not BaseObject.m_boFixedHideMode and (not BaseObject.m_boGhost) then
            begin //01/21 修改防止人物退出时发送重复的消息占用带宽，人物进入隐身模式时人物不消失问题
            nCheckCode := 46; }
          SendMsg(BaseObject, RM_DISAPPEAR, 0, 0, 0, 0, '');
          //end;
          nCheckCode := 47;
        end;
        if (BaseObject <> nil) and VisibleBaseObject.boAddCount then
          Dec(BaseObject.m_nVisibleActiveCount);
        m_VisibleActors.Delete(n18);
        nCheckCode := 48;
        DisPose(VisibleBaseObject);
        nCheckCode := 49;
        Continue;
      end;
      nCheckCode := 50;
      if (m_btRaceServer = RC_PLAYOBJECT) and (VisibleBaseObject.nVisibleFlag = 2) then begin
        nCheckCode := 51;
        BaseObject := TBaseObject(VisibleBaseObject.BaseObject);
        nCheckCode := 52;
        if (BaseObject <> nil) and (BaseObject <> Self) then begin
          nCheckCode := 53;
          if BaseObject.m_boDeath then begin
            nCheckCode := 54;
            if BaseObject.m_boSkeleton then begin
              nCheckCode := 55;
              SendMsg(BaseObject, RM_SKELETON, BaseObject.m_btDirection, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 0,
                '');
              nCheckCode := 56;
            end
            else begin
              nCheckCode := 57;
              SendMsg(BaseObject, RM_DEATH, BaseObject.m_btDirection, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 0, '');
              nCheckCode := 58;
            end;
          end
          else begin
            nCheckCode := 59;
            SendMsg(BaseObject, RM_TURN, BaseObject.m_btDirection, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 0, BaseObject.GetShowName);
            if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
              nCheckCode := 61;
              if TPlayObject(BaseObject).m_boShoping then begin
                SendDefSocket(Self, SM_USEROPENSHOP, Integer(BaseObject),
                  MakeWord(TPlayObject(BaseObject).m_btShopLevel + 1, Integer(TPlayObject(BaseObject).m_boShopLeft)),
                  0, 1,
                  EncodeString(TPlayObject(BaseObject).m_sShopTitle));
              end;
            end
            else if BaseObject.m_btRaceServer = RC_NPC then begin
              if TNormNpc(BaseObject).m_nEffigyState <> -1 then begin
                SendDefMsg(Self, SM_CHANGEEFFIGYSTATE,
                  Integer(BaseObject),
                  LoWord(TNormNpc(BaseObject).m_nEffigyState),
                  HiWord(TNormNpc(BaseObject).m_nEffigyState),
                  TNormNpc(BaseObject).m_nEffigyOffset, '');
              end;
            end;
            nCheckCode := 60;
          end;
        end;
      end;
      Inc(n18);
    end;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg2, [n24, m_sCharName, m_sMapName,
        m_nCurrX, m_nCurrY, nCheckCode]));
      {MainOutMessage(m_sCharName + ',' +
                     m_sMapName + ',' +
                     IntToStr(m_nCurrX) + ',' +
                     IntToStr(m_nCurrY) + ',' +
                     ' SearchViewRange 2');}
      KickException();
    end;
  end;
  try
    //    if (m_btRaceServer = RC_PLAYOBJECT) then begin
    i := 0;
    while (True) do begin
      if m_VisibleItems.Count <= i then
        break;
      VisibleMapItem := m_VisibleItems.Items[i];
      nCheckCode := 100;
      {try
        nVisibleFlag := VisibleMapItem.nVisibleFlag; //2006-10-14 防止内存出错
      except
        m_VisibleItems.Delete(i);
        Continue;
      end; }
      nCheckCode := 101;
      if VisibleMapItem.nVisibleFlag = 0 then begin
        SendMsg(Self, RM_ITEMHIDE, 0, Integer(VisibleMapItem.MapItem), VisibleMapItem.nX, VisibleMapItem.nY, '');
        m_VisibleItems.Delete(i);
        try
          DisPose(VisibleMapItem);
        except
        end;
        Continue;
      end;
      nCheckCode := 102;
      if VisibleMapItem.nVisibleFlag = 2 then begin
        SendMsg(Self, RM_ITEMSHOW, VisibleMapItem.wLooks,
          Integer(VisibleMapItem.MapItem), VisibleMapItem.nX, VisibleMapItem.nY,
          VisibleMapItem.sName);
      end;
      Inc(i);
    end;
    i := 0;
    while (True) do begin
      if m_VisibleEvents.Count <= i then
        break;
      nCheckCode := 103;
      MapEvent := m_VisibleEvents.Items[i];
      nCheckCode := 104;
      {try
        nVisibleFlag := MapEvent.nVisibleFlag; //2006-10-14 防止内存出错
      except
        m_VisibleEvents.Delete(i);
        Continue;
      end;    }
      nCheckCode := 105;
      if MapEvent.nVisibleFlag = 0 then begin
        SendDefMsg(Self, SM_HIDEEVENT, Integer(MapEvent), 0, MapEvent.m_nX, MapEvent.m_nY, '');
        m_VisibleEvents.Delete(i);
        Continue;
      end;
      nCheckCode := 106;
      if MapEvent.nVisibleFlag = 2 then begin
        //ShortMessage.Ident := HiWord(MapEvent.m_nEventParam);
        //ShortMessage.wMsg := 0;
        SendDefMsg(Self, SM_SHOWEVENT, Integer(MapEvent), MapEvent.m_nEventType,
          MapEvent.m_nX, MapEvent.m_nY, IntToStr(MapEvent.m_nEventParam));
        //SendSocket(@m_DefMsg, EncodeBuffer(@ShortMessage, SizeOf(TShortMessage)));
        {SendMsg(Self, RM_SHOWEVENT, MapEvent.m_nEventType, Integer(MapEvent),
          MakeLong(MapEvent.m_nX, MapEvent.m_nEventParam), MapEvent.m_nY, '');   }
      end;
      nCheckCode := 107;
      Inc(i);
    end;
  except
    MainOutMessage(m_sCharName + ',' +
      m_sMapName + ',' +
      IntToStr(m_nCurrX) + ',' +
      IntToStr(m_nCurrY) + ',' +
      ' SearchViewRange 3 CheckCode:' + IntToStr(nCheckCode));
    KickException();
  end;
end;

{
function TPlayObject.GetShowName: String;
var
  sShowName:String;
  sGuildName:String;
  sDearName:String;
  sMasterName:String;
begin
try
  //sShowName:=m_sCharName;
  if m_MyGuild <> nil then begin
    if UserCastle.IsMasterGuild(TGuild(m_MyGuild)) then begin
      sGuildName:='(' + UserCastle.sName + ')' + TGuild(m_MyGuild).sGuildName + '[' + m_sGuildRankName + ']';
    end else begin
      if g_boShowGuildName or (UserCastle.boUnderWar and (m_boInFreePKArea or UserCastle.IsCastleWarArea(m_PEnvir,m_nCurrX,m_nCurrY))) then begin
        sGuildName:= TGuild(m_MyGuild).sGuildName + '[' + m_sGuildRankName + ']';
      end;
    end;
  end;
  if m_sMasterName <> '' then begin
    if m_boMaster then begin
      sMasterName:= m_sMasterName + '的师傅';
    end else begin
      sMasterName:= m_sMasterName + '的徒弟';
    end;
  end;
  if m_sDearName <> '' then begin
    if m_btGender = 0 then begin
      sDearName:= m_sDearName + '的老公';
    end else begin
      sDearName:= m_sDearName + '的老婆';
    end;
  end;
  sShowName:=sGuildName;
  sShowName:= sShowName + '\' + m_sCharName;
  if sDearName <> '' then begin
    sShowName:= sShowName + '\' + sDearName;
  end;
  if sMasterName <> '' then begin
    sShowName:= sShowName + '\' + sMasterName;
  end;

  Result:=sShowName;
except
  on e: Exception do begin
    MainOutMessage('[Exception] TPlayObject.GetShowName');
    MainOutMessage(E.Message);
  end;
end;
end;
}

function TPlayObject.GetShowName: string;
var
  sShowName: string;
  sCharName: string;
  sGuildName: string;
  sDearName: string;
  sMasterName: string;
  Castle: TUserCastle;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::GetShowName';
begin
  try
    //sShowName:=m_sCharName;
    sCharName := '';
    sGuildName := '';
    sDearName := '';
    sMasterName := '';
    if m_MyGuild <> nil then begin
      Castle := g_CastleManager.IsCastleMember(Self);
      if Castle <> nil then begin
        sGuildName := AnsiReplaceText(g_sCastleGuildName, '%castlename', Castle.m_sName);
        sGuildName := AnsiReplaceText(sGuildName, '%guildname', '#' + TGuild(m_MyGuild).m_sGuildName + '#');
        sGuildName := AnsiReplaceText(sGuildName, '%rankname', '!' + m_sGuildRankName + '!');
      end
      else begin
        //Castle := g_CastleManager.InCastleWarArea(Self);
        //01/25 多城堡
        //ar and (m_boInFreePKArea or UserCastle.InCastleWarArea(m_PEnvir,m_nCurrX,m_nCurrY))) then begin
        //if g_Config.boShowGuildName or (((Castle <> nil) and Castle.m_boUnderWar) or m_boInFreePKArea) then begin
        //取消是否显示行会封号检测
        sGuildName := AnsiReplaceText(g_sNoCastleGuildName, '%guildname', '#' + TGuild(m_MyGuild).m_sGuildName + '#');
        sGuildName := AnsiReplaceText(sGuildName, '%rankname', '!' + m_sGuildRankName + '!');
        //end;
      end;
    end;
    {if not g_Config.boShowRankLevelName then begin
      if m_btReLevel > 0 then begin
        case m_btJob of
          0: sCharName := AnsiReplaceText(g_sWarrReNewName, '%chrname', m_sCharName);
          1: sCharName := AnsiReplaceText(g_sWizardReNewName, '%chrname', m_sCharName);
          2: sCharName := AnsiReplaceText(g_sTaosReNewName, '%chrname', m_sCharName);
        end;
      end
      else begin
        sCharName := m_sCharName;
      end;
    end
    else begin }
    sCharName := format(m_sRankLevelName, [m_sCharName]);
    //end;

    if (m_MasterList.Count > 0) and (not m_boMaster) then begin
      {if m_boMaster then begin
        sMasterName := format(g_sMasterName, [m_sMasterName]);
      end
      else begin
        sMasterName := format(g_sNoMasterName, [m_sMasterName]);
      end;  }
      sMasterName := format(g_sNoMasterName, [m_MasterList[0]]);
    end;

    if m_sDearName <> '' then begin
      if m_btGender = 0 then begin
        sDearName := format(g_sManDearName, [m_sDearName]); // + '的老公';
      end
      else begin
        sDearName := format(g_sWoManDearName, [m_sDearName]); // + '的老婆';
      end;
    end;
    sShowName := AnsiReplaceText(g_sHumanShowName, '%chrname', sCharName);
    sShowName := AnsiReplaceText(sShowName, '%guildname', sGuildName);
    sShowName := AnsiReplaceText(sShowName, '%dearname', sDearName);
    sShowName := AnsiReplaceText(sShowName, '%mastername', sMasterName);
    Result := sShowName;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

function TPlayObject.CheckItemsNeed(StdItem: pTStdItem): Boolean;
var
  Castle: TUserCastle;
begin
  Result := True;
  Castle := g_CastleManager.IsCastleMember(Self);
  case StdItem.Need of
    6: begin
        if (m_MyGuild = nil) then begin
          Result := False;
        end;
      end;
    60: begin
        if (m_MyGuild = nil) or (m_nGuildRankNo <> 1) then begin
          Result := False;
        end;
      end;
    7: begin
        //if (m_MyGuild = nil) or (UserCastle.m_MasterGuild <> m_MyGuild) then begin
        if Castle = nil then begin
          Result := False;
        end;
      end;
    70: begin
        //if (m_MyGuild = nil) or (UserCastle.m_MasterGuild <> m_MyGuild) or (m_nGuildRankNo <> 1) then begin
        if (Castle = nil) or (m_nGuildRankNo <> 1) then begin
          Result := False;
        end;
      end;
    8: begin
        if m_nMemberType = 0 then
          Result := False;
      end;
    81: begin
        if (m_nMemberType <> LoWord(StdItem.NeedLevel)) or (m_nMemberLevel < HiWord(StdItem.NeedLevel)) then
          Result := False;
      end;
    82: begin
        if (m_nMemberType < LoWord(StdItem.NeedLevel)) or (m_nMemberLevel < HiWord(StdItem.NeedLevel)) then
          Result := False;
      end;
  end;
end;

function TPlayObject.InFriendList(AddName: string): Boolean;
begin
  Result := m_FriendList.IndexOf(AddName) > -1;
end;

procedure TPlayObject.SetDeal(DealObject: TPlayObject);
begin
  if g_Config.boDisableDeal then
    exit;
  if m_boDealing then
    Exit;
  if DealObject.m_boDealing then
    Exit;
  if m_boDeath or DealObject.m_boDeath or m_boGhost or DealObject.m_boGhost then
    exit;
  if abs(m_nCurrX - DealObject.m_nCurrX) > g_Config.nSendRefMsgRange then
    exit;
  if abs(m_nCurrY - DealObject.m_nCurrY) > g_Config.nSendRefMsgRange then
    exit;
  OpenDealDlg(DealObject);
  DealObject.OpenDealDlg(Self);
end;

procedure TPlayObject.SetFriend(NameBaseObject: TPlayObject);
begin
  if InFriendList(NameBaseObject.m_sCharName) then begin
    SysMsg('[#7' + NameBaseObject.m_sCharName + '#7] 已经在你的好友列表当中.', c_Red);
    NameBaseObject.SysMsg('你已经存在于 [#7' + m_sCharName + '#7] 的好友列表当中.', c_Red);
    exit;
  end;
  if NameBaseObject.InFriendList(m_sCharName) then begin
    NameBaseObject.SysMsg('[#7' + m_sCharName + '#7] 已经存在于你的好友列表当中.', c_Red);
    SysMsg('你已经存在于 [#7' + NameBaseObject.m_sCharName + '#7] 的好友列表当中.', c_Red);
    exit;
  end;
  if m_FriendList.Count >= MAXFRIENDS then begin
    SysMsg('你的好友列表已满.', c_Red);
    NameBaseObject.SysMsg('[#7' + m_sCharName + '#7] 的好友列表已满.', c_Red);
    exit;
  end;
  if NameBaseObject.m_FriendList.Count >= MAXFRIENDS then begin
    NameBaseObject.SysMsg('你的好友列表已满.', c_Red);
    SysMsg('[#7' + NameBaseObject.m_sCharName + '#7] 的好友列表已满.', c_Red);
    exit;
  end;
  m_FriendList.AddObject(NameBaseObject.m_sCharName, TObject(NameBaseObject.m_nDBIndex));
  NameBaseObject.m_FriendList.AddObject(m_sCharName, TObject(m_nDBIndex));

  SendDefMsg(Self, SM_FRIEND_LOGIN, NameBaseObject.m_nDBIndex, 1, 0, 2, NameBaseObject.m_sCharName);
  NameBaseObject.SendDefMsg(NameBaseObject, SM_FRIEND_LOGIN, m_nDBIndex, 1, 0, 2, m_sCharName);
  SysMsg('[#7' + NameBaseObject.m_sCharName + '#7] 已加为好友.', c_Red);
  NameBaseObject.SysMsg('[#7' + m_sCharName + '#7] 已加为好友.', c_Red);
end;

procedure TPlayObject.CheckFriend();
var
  i, ii, nDBIndex: Integer;
  sname, sSendMsg: string;
  PlayObject: TPlayObject;
  boChange: Boolean;
begin
  try
    boChange := False;
    for I := g_UnFriendList.Count - 1 downto 0 do begin
      if CompareText(m_sCharName, g_UnFriendList[I]) = 0 then begin
        sname := PChar(g_UnFriendList.Objects[I]);
        for ii := m_FriendList.Count - 1 downto 0 do begin
          if CompareText(sname, m_FriendList[Ii]) = 0 then begin
            SysMsg('[#7' + sname + '#7] 已经将你从好友列表当中删除.', c_Red);
            m_FriendList.Delete(ii);
            break;
          end;
        end;
        FreeMem(PChar(g_UnFriendList.Objects[I]));
        g_UnFriendList.Delete(I);
        boChange := True;
      end;
    end;
    if boChange then
      SaveUnFriendList;
    sSendMsg := '';
    for ii := m_FriendList.Count - 1 downto 0 do begin
      nDBIndex := Integer(m_FriendList.Objects[ii]);
      PlayObject := GetLoginPlay(nDBIndex);
      if PlayObject <> nil then begin
        if CompareText(PlayObject.m_sCharName, m_FriendList[ii]) = 0 then begin
          sSendMsg := m_FriendList[ii] + '/1/' + sSendMsg;
          PlayObject.SendDefMsg(PlayObject, SM_FRIEND_LOGIN, nDBIndex, 1, 0, 0, m_sCharName);
        end else
          m_FriendList.Delete(II);
      end
      else begin
        sSendMsg := m_FriendList[ii] + '/0/' + sSendMsg;
      end;
    end;
    if sSendMsg <> '' then
      SendDefMsg(Self, SM_FRIEND_LOGIN, 0, 1, 0, 1, sSendMsg);
  except
    MainOutMessage('[Exception] TPlayObject.CheckFriend');
  end;
end;

procedure TPlayObject.CheckMarry;
var
  boIsfound: Boolean;
  //sUnMarryFileName: string;
//  LoadList: TStringList;
  i: Integer;
  sSayMsg: string;
begin
  boIsfound := False;
  g_UnMarryList.Lock;
  try
    if g_UnMarryList.Count > 0 then begin
      for i := g_UnMarryList.Count - 1 downto 0 do begin
        if g_UnMarryList.Count <= 0 then
          break;
        if CompareText(g_UnMarryList.Strings[i], m_sCharName) = 0 then begin
          g_UnMarryList.Delete(i);
          SaveUnMarryList;
          boIsfound := True;
          break;
        end;
      end;
    end;
  finally
    g_UnMarryList.UnLock;
  end;

  if boIsfound then begin
    if m_btGender = 0 then begin
      sSayMsg := AnsiReplaceText(g_sfUnMarryManLoginMsg, '%d', m_sDearName);
      sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
    end
    else begin
      sSayMsg := AnsiReplaceText(g_sfUnMarryWoManLoginMsg, '%d', m_sDearName);
      sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
    end;
    SysMsg(sSayMsg, c_Red, t_Hint);
    m_sDearName := '';
    RefShowName;
  end;
  if m_sDearName <> '' then begin
    m_DearHuman := UserEngine.GetPlayObject(m_sDearName);
    if m_DearHuman <> nil then begin
      m_DearHuman.m_DearHuman := Self;
      if m_btGender = 0 then begin
        sSayMsg := AnsiReplaceText(g_sManLoginDearOnlineSelfMsg, '%d', m_sDearName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%m', m_DearHuman.m_PEnvir.sMapDesc);
        sSayMsg := AnsiReplaceText(sSayMsg, '%x', IntToStr(m_DearHuman.m_nCurrX));
        sSayMsg := AnsiReplaceText(sSayMsg, '%y', IntToStr(m_DearHuman.m_nCurrY));
        SysMsg(sSayMsg, c_Blue, t_Hint);

        sSayMsg := AnsiReplaceText(g_sManLoginDearOnlineDearMsg, '%d', m_sDearName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%m', m_PEnvir.sMapDesc);
        sSayMsg := AnsiReplaceText(sSayMsg, '%x', IntToStr(m_nCurrX));
        sSayMsg := AnsiReplaceText(sSayMsg, '%y', IntToStr(m_nCurrY));
        m_DearHuman.SysMsg(sSayMsg, c_Blue, t_Hint);
      end
      else begin
        sSayMsg := AnsiReplaceText(g_sWoManLoginDearOnlineSelfMsg, '%d', m_sDearName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%m', m_DearHuman.m_PEnvir.sMapDesc);
        sSayMsg := AnsiReplaceText(sSayMsg, '%x', IntToStr(m_DearHuman.m_nCurrX));
        sSayMsg := AnsiReplaceText(sSayMsg, '%y', IntToStr(m_DearHuman.m_nCurrY));
        SysMsg(sSayMsg, c_Blue, t_Hint);

        sSayMsg := AnsiReplaceText(g_sWoManLoginDearOnlineDearMsg, '%d', m_sDearName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%m', m_PEnvir.sMapDesc);
        sSayMsg := AnsiReplaceText(sSayMsg, '%x', IntToStr(m_nCurrX));
        sSayMsg := AnsiReplaceText(sSayMsg, '%y', IntToStr(m_nCurrY));
        m_DearHuman.SysMsg(sSayMsg, c_Blue, t_Hint);
      end;
    end
    else begin
      if m_btGender = 0 then begin
        SysMsg(g_sManLoginDearNotOnlineMsg, c_Red, t_Hint);
      end
      else begin
        SysMsg(g_sWoManLoginDearNotOnlineMsg, c_Red, t_Hint);
      end;
    end;
  end;
end;

procedure TPlayObject.OnAction(ActionType: TOnActionType);
begin
  inherited OnAction(ActionType);
  if AT_Walk = ActionType then
    if m_PEnvir.m_boMINE then m_nMineCount := Random(50);
    
  m_ClickGuageNPC := nil;
  m_ClickBoxObject := nil;
  if m_boCanOnHorse then
    SendDefMessage(SM_CLOSEBAR, 0, 0, 0, 0, '');
  m_boCanOnHorse := False;
end;

procedure TPlayObject.DeleteMasterByName(sName: string);
var
  I: Integer;
begin
  for I := 0 to m_MasterList.Count - 1 do begin
    if CompareText(m_MasterList[i], sName) = 0 then begin
      m_MasterList.Delete(I);
      break;
    end;
  end;
  if m_MasterList.Count <= 0 then
    m_boMaster := False;
end;

procedure TPlayObject.UnMaster;
var
  //boIsfound: Boolean;
  sSayMsg: string;
  //i: Integer;
  Human: TPlayObject;
begin
  if (m_MasterList.Count > 0) and not m_boMaster then begin
    if m_Abil.Level >= g_Config.nMasterOKLevel then begin
      Human := UserEngine.GetPlayObject(m_MasterList[0]);
      if (Human <> nil) and (not Human.m_boGhost) then begin
        WordChange(Human.m_wMasterCount, 1, INT_ADD);
        sSayMsg := AnsiReplaceText(g_sYourMasterListUnMasterOKMsg, '%s', m_sCharName);
        Human.SysMsg(sSayMsg, c_Red, t_Hint);
        SysMsg(g_sYouAreUnMasterOKMsg, c_Red, t_Hint);
        Human.DeleteMasterByName(m_sCharName);
        Human.RefShowName;
        m_MasterList.Clear;
        RefShowName;
        if IntegerChange(Human.m_nCreditPoint, g_Config.nMasterOKCreditPoint, INT_ADD) then begin
          Human.DiamondChanged;
          if g_boGameLogCreditPoint then begin
            AddGameLog(Human, LOG_CREDITPOINT, sSTRING_CREDITPOINT, 0, Human.m_nCreditPoint, m_sCharName,
              '+', IntToStr(g_Config.nMasterOKCreditPoint), '收徒', nil);
          end;
        end;
      end
      else begin
        //如果师父不在线则保存到记录表中
        g_UnMasterList.Lock;
        try
          sSayMsg := m_sCharName;
          g_UnMasterList.AddObject(m_MasterList[0], TObject(StrNew(PChar(sSayMsg))));
          SaveUnMasterList();
        finally
          g_UnMasterList.UnLock;
        end;
        SysMsg(g_sYouAreUnMasterOKMsg, c_Red, t_Hint);
        m_MasterList.Clear;
        RefShowName;
      end;
    end;
  end;
end;

procedure TPlayObject.CheckMaster;
var
  boIsfound: Boolean;
  sSayMsg: string;
  i, k: Integer;
  boRefShowName: Boolean;
  Hum: TPlayObject;
begin
  //处理强行脱离师徒关系
  boIsfound := False;
  boRefShowName := False;
  if g_UnForceMasterList.Count > 0 then begin
    g_UnForceMasterList.Lock;
    try
      if g_UnForceMasterList.Count > 0 then begin
        for i := g_UnForceMasterList.Count - 1 downto 0 do begin
          if CompareText(g_UnForceMasterList[i], m_sCharName) = 0 then begin
            boIsfound := True;
            sSayMsg := PChar(g_UnForceMasterList.Objects[I]);
            for k := 0 to m_MasterList.Count - 1 do begin
              if CompareText(m_MasterList[k], sSayMsg) = 0 then begin
                if m_boMaster then
                  sSayMsg := AnsiReplaceText(g_sfUnMasterLoginMsg, '%s', m_MasterList[k])
                else
                  sSayMsg := AnsiReplaceText(g_sfUnMasterListLoginMsg, '%s', m_MasterList[k]);
                SysMsg(sSayMsg, c_Red, t_Hint);
                boRefShowName := True;
                m_MasterList.Delete(k);
                break;
              end;
            end;
            if m_MasterList.Count <= 0 then
              m_boMaster := False;
            StrDispose(PChar(g_UnForceMasterList.Objects[I]));
            g_UnForceMasterList.Delete(I);
          end;
        end;
      end;
    finally
      g_UnForceMasterList.UnLock;
    end;
  end;
  if boIsfound then begin
    SaveUnForceMasterList();
  end;

  UnMaster;

  //处理出师记录
  boIsfound := False;
  g_UnMasterList.Lock;
  try
    if g_UnMasterList.Count > 0 then begin
      for i := g_UnMasterList.Count - 1 downto 0 do begin
        if CompareText(g_UnMasterList[i], m_sCharName) = 0 then begin
          boIsfound := True;
          sSayMsg := PChar(g_UnMasterList.Objects[I]);
          for k := 0 to m_MasterList.Count - 1 do begin
            if CompareText(m_MasterList[k], sSayMsg) = 0 then begin
              SysMsg(AnsiReplaceText(g_sUnMasterLoginMsg, '%s', sSayMsg), c_Red, t_Hint);
              if m_boMaster then begin
                WordChange(m_wMasterCount, 1, INT_ADD);
                if IntegerChange(m_nCreditPoint, g_Config.nMasterOKCreditPoint, INT_ADD) then begin
                  DiamondChanged;
                  if g_boGameLogCreditPoint then begin
                    AddGameLog(Self, LOG_CREDITPOINT, sSTRING_CREDITPOINT, 0, m_nCreditPoint, sSayMsg,
                      '+', IntToStr(g_Config.nMasterOKCreditPoint), '收徒', nil);
                  end;
                end;
              end;
              m_MasterList.Delete(k);
              break;
            end;
          end;
          if m_MasterList.Count <= 0 then
            m_boMaster := False;
          StrDispose(PChar(g_UnMasterList.Objects[I]));
          g_UnMasterList.Delete(i);
        end;
      end;
    end;
  finally
    g_UnMasterList.UnLock;
  end;
  if boIsfound then begin
    SaveUnMasterList();
    boRefShowName := True;
  end;

  if boRefShowName then
    RefShowName;
  if m_MasterList.Count <= 0 then
    Exit;
  if m_boMaster then begin
    //师父上线通知
    //boIsfound := True;
    for I := m_MasterList.Count - 1 downto 0 do begin
      m_MasterList.Objects[I] := UserEngine.GetPlayObject(m_MasterList[I]);
      if m_MasterList.Objects[I] <> nil then begin
        Hum := TPlayObject(m_MasterList.Objects[I]);
        if (Hum.m_MasterList.Count > 0) and (CompareText(Hum.m_MasterList[0], m_sCharName) = 0) then begin
          //boIsfound := False;
          Hum.m_MasterList.Objects[0] := Self;
          sSayMsg := AnsiReplaceText(g_sMasterOnlineSelfMsg, '%d', m_MasterList[I]);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%m', Hum.m_PEnvir.sMapDesc);
          sSayMsg := AnsiReplaceText(sSayMsg, '%x', IntToStr(Hum.m_nCurrX));
          sSayMsg := AnsiReplaceText(sSayMsg, '%y', IntToStr(Hum.m_nCurrY));
          SysMsg(sSayMsg, c_Blue, t_Hint);
          sSayMsg := AnsiReplaceText(g_sMasterOnlineMasterListMsg, '%d', m_MasterList[I]);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%m', m_PEnvir.sMapDesc);
          sSayMsg := AnsiReplaceText(sSayMsg, '%x', IntToStr(m_nCurrX));
          sSayMsg := AnsiReplaceText(sSayMsg, '%y', IntToStr(m_nCurrY));
          Hum.SysMsg(sSayMsg, c_Blue, t_Hint);
        end
        else
          m_MasterList.Delete(I);
      end
      else begin
        sSayMsg := AnsiReplaceText(g_sMasterOnlineSelfMsgEx, '%d', m_MasterList[I]);
        SysMsg(sSayMsg, c_Red, t_Hint);
      end;
    end;
    // if boIsfound then
       //SysMsg(g_sMasterNotOnlineMsg, c_Red, t_Hint);
  end
  else begin
    //徒弟上线通知
    m_MasterList.Objects[0] := UserEngine.GetPlayObject(m_MasterList[0]);
    if m_MasterList.Objects[0] <> nil then begin
      Hum := TPlayObject(m_MasterList.Objects[0]);
      boIsfound := True;
      for I := 0 to Hum.m_MasterList.Count - 1 do begin
        if CompareText(Hum.m_MasterList[I], m_sCharName) = 0 then begin
          boIsfound := False;
          Hum.m_MasterList.Objects[I] := Self;
          sSayMsg := AnsiReplaceText(g_sMasterListOnlineSelfMsg, '%d', m_MasterList[0]);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%m', Hum.m_PEnvir.sMapDesc);
          sSayMsg := AnsiReplaceText(sSayMsg, '%x', IntToStr(Hum.m_nCurrX));
          sSayMsg := AnsiReplaceText(sSayMsg, '%y', IntToStr(Hum.m_nCurrY));
          SysMsg(sSayMsg, c_Blue, t_Hint);

          sSayMsg := AnsiReplaceText(g_sMasterListOnlineMasterMsg, '%d', m_MasterList[0]);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%m', m_PEnvir.sMapDesc);
          sSayMsg := AnsiReplaceText(sSayMsg, '%x', IntToStr(m_nCurrX));
          sSayMsg := AnsiReplaceText(sSayMsg, '%y', IntToStr(m_nCurrY));
          Hum.SysMsg(sSayMsg, c_Blue, t_Hint);
          Break;
        end;
      end;
      if boIsfound then
        m_MasterList.Clear;
    end
    else begin
      SysMsg(g_sMasterListNotOnlineMsg, c_Red, t_Hint);
    end;
  end;

end;

procedure TPlayObject.MakeGhost;
var
  i, nDBIndex: Integer;
  sSayMsg: string;
  Human: TPlayObject;
  CheckMsg: pTCheckMsg;
  boIsfound: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::MakeGhost';
begin
  try
    ClearDare(3);
    SetLoginPlay(m_nDBIndex, nil);
    if m_boOnHorse and (m_UseItems[u_House].wIndex > 0) then begin
      m_UseItems[u_House].wHP := m_WAbil.HP;
      m_boOnHorse := False;
      RecalcAbilitys;
    end;
    UserEMail.SendMsg(EMS_USERGHOST, -1, 0, 0, 0, m_sCharName, nil);
    if m_boIncCount and (g_Config.nCheckCount > 0) then begin
      m_boIncCount := False;
      Dec(g_Config.nCheckCount);
    end;
    if m_CheckMsgList.Count > 0 then begin
      for i := 0 to m_CheckMsgList.Count - 1 do begin
        CheckMsg := m_CheckMsgList.Items[i];
        if CheckMsg <> nil then begin
          ClientCheckMsg(CheckMsg.tClass, CheckMsg.AllPurpose, -1);
          DisPose(CheckMsg);
        end;
      end;
    end;
    m_CheckMsgList.Clear;
    {if (g_HighLevelHuman = Self) then
      g_HighLevelHuman := nil;
    if (g_HighPKPointHuman = Self) then
      g_HighPKPointHuman := nil;
    if (g_HighDCHuman = Self) then
      g_HighDCHuman := nil;
    if (g_HighMCHuman = Self) then
      g_HighMCHuman := nil;
    if (g_HighSCHuman = Self) then
      g_HighSCHuman := nil;
    if (g_HighOnlineHuman = Self) then
      g_HighOnlineHuman := nil;   }
    //人物下线后通知配偶，并把对方的相关记录清空
    for i := m_FriendList.Count - 1 downto 0 do begin
      nDBIndex := Integer(m_FriendList.Objects[i]);
      Human := GetLoginPlay(nDBIndex);
      if Human <> nil then begin
        Human.SendDefMsg(Human, SM_FRIEND_LOGIN, nDBIndex, 0, 0, 0, m_sCharName);
      end;
    end;
    if m_DearHuman <> nil then begin
      if m_btGender = 0 then
        sSayMsg := g_sManLongOutDearOnlineMsg
      else
        sSayMsg := g_sWoManLongOutDearOnlineMsg;
      sSayMsg := AnsiReplaceText(sSayMsg, '%d', m_sDearName);
      sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
      sSayMsg := AnsiReplaceText(sSayMsg, '%m', m_PEnvir.sMapDesc);
      sSayMsg := AnsiReplaceText(sSayMsg, '%x', IntToStr(m_nCurrX));
      sSayMsg := AnsiReplaceText(sSayMsg, '%y', IntToStr(m_nCurrY));
      m_DearHuman.SysMsg(sSayMsg, c_Red, t_Hint);
      m_DearHuman.m_DearHuman := nil;
      m_DearHuman := nil;
    end;
    if m_MasterList.Count > 0 then begin
      if m_boMaster then begin
        for I := m_MasterList.Count - 1 downto 0 do begin
          Human := TPlayObject(m_MasterList.Objects[I]);
          if Human <> nil then begin
            if (Human.m_MasterList.Count > 0) and (CompareText(Human.m_MasterList[0], m_sCharName) = 0) then begin
              m_MasterList.Objects[I] := nil;
              Human.m_MasterList.Objects[0] := nil;
              sSayMsg := AnsiReplaceText(g_sMasterLongOutMasterListOnlineMsg, '%d', m_MasterList[I]);
              sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
              sSayMsg := AnsiReplaceText(sSayMsg, '%m', m_PEnvir.sMapDesc);
              sSayMsg := AnsiReplaceText(sSayMsg, '%x', IntToStr(m_nCurrX));
              sSayMsg := AnsiReplaceText(sSayMsg, '%y', IntToStr(m_nCurrY));
              Human.SysMsg(sSayMsg, c_Red, t_Hint);
            end
            else
              m_MasterList.Delete(I);
          end;
        end;

      end
      else begin
        if m_MasterList.Objects[0] <> nil then begin
          Human := TPlayObject(m_MasterList.Objects[0]);
          boIsfound := True;
          for I := 0 to Human.m_MasterList.Count - 1 do begin
            if CompareText(Human.m_MasterList[I], m_sCharName) = 0 then begin
              boIsfound := False;
              Human.m_MasterList.Objects[I] := nil;
              sSayMsg := AnsiReplaceText(g_sMasterListLongOutMasterOnlineMsg, '%d', m_MasterList[0]);
              sSayMsg := AnsiReplaceText(sSayMsg, '%s', m_sCharName);
              sSayMsg := AnsiReplaceText(sSayMsg, '%m', m_PEnvir.sMapDesc);
              sSayMsg := AnsiReplaceText(sSayMsg, '%x', IntToStr(m_nCurrX));
              sSayMsg := AnsiReplaceText(sSayMsg, '%y', IntToStr(m_nCurrY));
              Human.SysMsg(sSayMsg, c_Red, t_Hint);
              m_MasterList.Objects[0] := nil;
              Break;
            end;
          end;
          if boIsfound then
            m_MasterList.Clear;
        end;
      end;
    end;
{$IFDEF PLUGOPEN}
    try
      if Assigned(zPlugOfEngine.HookPlayObjectMakeGhost) then begin
        zPlugOfEngine.HookPlayObjectMakeGhost(Self);
      end;
    except
    end;
{$ENDIF}
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
  if m_AttackState = as_Close then begin
    m_sMapName := m_sHomeMap;
    m_nCurrX := m_nHomeX;
    m_nCurrY := m_nHomeY;
  end;
  inherited;
end;

function TPlayObject.GetMyInfo: string;
var
  sMyInfo: string;
begin
  sMyInfo := g_sMyInfo;
  sMyInfo := AnsiReplaceText(sMyInfo, '%name', m_sCharName);
  sMyInfo := AnsiReplaceText(sMyInfo, '%map', m_PEnvir.sMapDesc);
  sMyInfo := AnsiReplaceText(sMyInfo, '%x', IntToStr(m_nCurrX));
  sMyInfo := AnsiReplaceText(sMyInfo, '%y', IntToStr(m_nCurrY));
  sMyInfo := AnsiReplaceText(sMyInfo, '%level', IntToStr(m_Abil.Level));
  sMyInfo := AnsiReplaceText(sMyInfo, '%gold', IntToStr(m_nGold));
  sMyInfo := AnsiReplaceText(sMyInfo, '%pk', IntToStr(m_nPkPoint));
  sMyInfo := AnsiReplaceText(sMyInfo, '%minhp', IntToStr(m_WAbil.HP));
  sMyInfo := AnsiReplaceText(sMyInfo, '%maxhp', IntToStr(m_WAbil.MaxHP));
  sMyInfo := AnsiReplaceText(sMyInfo, '%minmp', IntToStr(m_WAbil.MP));
  sMyInfo := AnsiReplaceText(sMyInfo, '%maxmp', IntToStr(m_WAbil.MaxMP));
  sMyInfo := AnsiReplaceText(sMyInfo, '%mindc', IntToStr(LoWord(m_WAbil.DC)));
  sMyInfo := AnsiReplaceText(sMyInfo, '%maxdc', IntToStr(HiWord(m_WAbil.DC)));
  sMyInfo := AnsiReplaceText(sMyInfo, '%minmc', IntToStr(LoWord(m_WAbil.MC)));
  sMyInfo := AnsiReplaceText(sMyInfo, '%maxmc', IntToStr(HiWord(m_WAbil.MC)));
  sMyInfo := AnsiReplaceText(sMyInfo, '%minsc', IntToStr(LoWord(m_WAbil.SC)));
  sMyInfo := AnsiReplaceText(sMyInfo, '%maxsc', IntToStr(HiWord(m_WAbil.SC)));
  sMyInfo := AnsiReplaceText(sMyInfo, '%logontime', DateTimeToStr(m_dLogonTime));
  sMyInfo := AnsiReplaceText(sMyInfo, '%logonlong', IntToStr((GetTickCount - m_dwLogonTick) div 60000));
  Result := sMyInfo;
end;
{
function TPlayObject.CheckItemBindUse(UserItem: pTUserItem): Boolean;
var
  i: Integer;
  ItemBind: pTItemBind;
begin
  Result := True;
  g_ItemBindAccount.Lock;
  try
    for i := 0 to g_ItemBindAccount.Count - 1 do begin
      ItemBind := g_ItemBindAccount.Items[i];
      if ItemBind <> nil then begin
        if (ItemBind.nMakeIdex = UserItem.MakeIndex) and
          (ItemBind.nItemIdx = UserItem.wIndex) then begin
          Result := False;
          if (CompareText(ItemBind.sBindName, m_sUserID) = 0) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sItemIsNotThisAccount, c_Red, t_Hint);
          end;
          Exit;
        end;
      end;
    end;
  finally
    g_ItemBindAccount.UnLock;
  end;

  g_ItemBindIPaddr.Lock;
  try
    for i := 0 to g_ItemBindIPaddr.Count - 1 do begin
      ItemBind := g_ItemBindIPaddr.Items[i];
      if ItemBind <> nil then begin
        if (ItemBind.nMakeIdex = UserItem.MakeIndex) and
          (ItemBind.nItemIdx = UserItem.wIndex) then begin
          Result := False;
          if (CompareText(ItemBind.sBindName, m_sIPaddr) = 0) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sItemIsNotThisIPaddr, c_Red, t_Hint);
          end;
          Exit;
        end;
      end;
    end;
  finally
    g_ItemBindIPaddr.UnLock;
  end;
  g_ItemBindCharName.Lock;
  try
    for i := 0 to g_ItemBindCharName.Count - 1 do begin
      ItemBind := g_ItemBindCharName.Items[i];
      if ItemBind <> nil then begin
        if (ItemBind.nMakeIdex = UserItem.MakeIndex) and
          (ItemBind.nItemIdx = UserItem.wIndex) then begin
          Result := False;
          if (CompareText(ItemBind.sBindName, m_sCharName) = 0) then begin
            Result := True;
          end
          else begin
            SysMsg(g_sItemIsNotThisCharName, c_Red, t_Hint);
          end;
          Exit;
        end;
      end;
    end;
  finally
    g_ItemBindCharName.UnLock;
  end;
end;        }

procedure TPlayObject.ScatterBagItems(ItemOfCreat: TBaseObject);
var
  i, DropWide: Integer;
  UserItem: pTUserItem;
  DelList: TStringList;
  boDropall: Boolean;
  StdItem: pTStdItem;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::ScatterBagItems';
begin
  DelList := nil;
  if m_boAngryRing or m_boNoDropItem then
    Exit; //不死戒指

  boDropall := False;
  DropWide := 4;
  if g_Config.boDieRedScatterBagAll and (PKLevel >= 2) then begin
    boDropall := True;
  end;
  //非红名掉1/3 //红名全掉
  try
    for i := m_ItemList.Count - 1 downto 0 do begin
      if m_ItemList.Count <= 0 then
        break;
      UserItem := m_ItemList[i];
      if UserItem <> nil then begin
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem = nil then
          Continue;
        if boDropall or ItemCanDrop(UserItem, g_Config.nDieScatterBagRate) then begin
          if CheckItemBindMode(UserItem, bm_NoDown) then
            Continue;
          if DropItemDown(UserItem, DropWide, True, ItemOfCreat, Self) then begin
            if m_btRaceServer = RC_PLAYOBJECT then begin
              if DelList = nil then
                DelList := TStringList.Create;
              DelList.AddObject(IntToStr(UserItem.wIndex), TObject(UserItem.MakeIndex));
            end;
            DisPose(UserItem); //修改
            m_ItemList.Delete(i);
          end;
        end;
      end;
    end;
    if DelList <> nil then begin
      SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(DelList), 0, 0, '');
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TPlayObject.RecallHuman(sHumName: string);
var
  PlayObject: TPlayObject;
begin
  PlayObject := UserEngine.GetPlayObject(sHumName);
  if PlayObject <> nil then begin
    RecallHuman(PlayObject);
  end
  else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumName]), c_Red, t_Hint);
  end;
end;

procedure TPlayObject.RecallHuman(PlayObject: TPlayObject);
var
  nX, nY, n18, n1C: Integer;
begin
  if PlayObject <> nil then begin
    if PlayObject.m_boMapApoise and GetFrontPosition(nX, nY) then begin
      if sub_4C5370(nX, nY, 3, n18, n1C) then begin
        PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
        PlayObject.SpaceMove(m_PEnvir, n18, n1C, 0);
      end;
    end
    else begin
      SysMsg('#7' + PlayObject.m_sCharName + '#7 召唤失败.', c_Red, t_Hint);
    end;
  end;
end;

procedure TPlayObject.ReQuestGuildWar(sGuildName: string);
var
  Guild: TGuild;
  //WarGuild: pTWarGuild;
begin
  if not IsGuildMaster then begin
    SendDefMessage(SM_MENU_OK, Integer(Self), 0, 0, 0, '只有行会掌门人才能申请.');
    //SysMsg('只有行会掌门人才能申请！', c_Red, t_Hint);
    Exit;
  end;
  Guild := g_GuildManager.FindGuild(sGuildName);
  if (Guild = nil) then begin
    //SysMsg(sGuildName + ' 行会不存在！', c_Red, t_Hint);
    SendDefMessage(SM_MENU_OK, Integer(Self), 0, 0, 0, '行会[' + sGuildName + ']不存在.');
    Exit;
  end;
  //WarGuild :=
  if TGuild(m_MyGuild).AddWarGuild(Guild) = nil then begin
    SendDefMessage(SM_MENU_OK, Integer(Self), 0, 0, 0, '不能与联盟行会发生战争，请先取消联盟.');
    //SysMsg('不能与联盟行会发生战争，请先取消联盟！', c_Red, t_Hint);
    Exit;
  end
  else
    Guild.AddWarGuild(TGuild(m_MyGuild));
  {if WarGuild <> nil then begin
    if Guild.AddWarGuild(TGuild(m_MyGuild)) = nil then begin
      WarGuild.dwWarTick := 0;
    end;
  end;  }
end;

procedure TPlayObject.AttackDir(TargeTBaseObject: TBaseObject; wHitMode: Word; nDir: Integer);
  procedure CheckWeaponUpgradeStatus(UserItem: pTUserItem); //004C27C0
  begin
    //if (UserItem.btValue[0] + UserItem.btValue[1] + UserItem.btValue[2]) < 20 then begin
    if (UserItem.Value.btValue[tb_DC2] + UserItem.Value.btValue[tb_MC2] + UserItem.Value.btValue[tb_SC2]) < g_Config.nUpgradeWeaponMaxPoint then begin
      case UserItem.EffectValue.btUpgrade of
        1: UserItem.wIndex := 0;
        10..13: UserItem.Value.btValue[tb_DC2] := UserItem.Value.btValue[tb_DC2] + UserItem.EffectValue.btUpgrade - 9;
        20..23: UserItem.Value.btValue[tb_MC2] := UserItem.Value.btValue[tb_MC2] + UserItem.EffectValue.btUpgrade - 19;
        30..33: UserItem.Value.btValue[tb_SC2] := UserItem.Value.btValue[tb_SC2] + UserItem.EffectValue.btUpgrade - 29;
      end;
    end
    else
      UserItem.wIndex := 0;
    UserItem.EffectValue.btUpgrade := 0;
  end;

  procedure CheckWeaponUpgrade(); //004C2854
  var
    UseItems: TUserItem;
    StdItem: PTStditem;
  begin
    if m_UseItems[U_WEAPON].EffectValue.btUpgrade > 0 then begin
      UseItems := m_UseItems[U_WEAPON];
      CheckWeaponUpgradeStatus(@m_UseItems[U_WEAPON]);
      if m_UseItems[U_WEAPON].wIndex = 0 then begin
        SysMsg(g_sTheWeaponBroke, c_Red, t_Hint);
        SendDelItems(@UseItems);
        SendRefMsg(RM_BREAKWEAPON, 0, 0, 0, 0, '');
        StdItem := UserEngine.GetStdItem(UseItems.wIndex);
        if (StdItem <> nil) and (StdItem.NeedIdentify = 1) then
          AddGameLog(Self, LOG_DELITEM, StdItem.Name, UseItems.MakeIndex, UseItems.Dura, '', '0', '破碎', '武器升级', @UseItems);

        FeatureChanged();
        RecalcAbilitys();
        SendAbility;
        SendSubAbility;
      end
      else
      begin
        SysMsg(sTheWeaponRefineSuccessfull, c_Red, t_Hint);
        SendUpdateItem(@m_UseItems[U_WEAPON]);
        StdItem := UserEngine.GetStdItem(UseItems.wIndex);
        //004C2B14
        if (StdItem <> nil) and (StdItem.NeedIdentify = 1) then
          AddGameLog(Self, LOG_DELITEM, StdItem.Name, UseItems.MakeIndex, UseItems.Dura, '', '0', '破碎', '武器升级', @UseItems);

        RecalcAbilitys();
        SendAbility;
        SendSubAbility;
      end;
    end;
  end;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject.AttackDir Code: %d';
var
  AttackTarget: TBaseObject;
  boPowerHit: Boolean;
  boFireHit: Boolean;
  boLongIceHit: Boolean;
  bo56Hit: Boolean;
  bo110Hit: Boolean;
  bo112Hit: Boolean;
  bo113Hit: Boolean;
  bo122Hit: Boolean;
  //  bo42: Boolean;
    //bo43: Boolean;
  wIdent: Word;
  nCheckCode: Integer;
begin
  nCheckCode := 0;
  try
    if (wHitMode = 5) and (m_MagicArr[SKILL_BANWOL] <> nil) then begin //半月
      if m_WAbil.MP > 0 then begin
        nCheckCode := 1;
        DamageSpell(GetSpellPoint(m_MagicArr[SKILL_BANWOL]));
        nCheckCode := 2;
        HealthSpellChanged();
        nCheckCode := 3;
      end
      else
        wHitMode := 0;
    end;
    nCheckCode := 4;
    m_btDirection := nDir;
    if TargeTBaseObject = nil then begin
      nCheckCode := 41;
      AttackTarget := GetPoseCreate();
    end
    else
      AttackTarget := TargeTBaseObject;
    if (AttackTarget <> nil) and (m_UseItems[U_WEAPON].wIndex > 0) then begin
      nCheckCode := 42;
      CheckWeaponUpgrade();
    end;
    nCheckCode := 5;
    boPowerHit := m_boPowerHit;
    boFireHit := m_boFireHitSkill;
    bo56Hit := m_bo56HitSkill;
    bo110Hit := m_bo110HitSkill;
    bo112Hit := m_bo112HitSkill;
    bo113Hit := m_bo113HitSkill;
    bo122Hit := m_bo122HitSkill;
    boLongIceHit := m_boLongIceHit;

    if _Attack(wHitMode, AttackTarget) then begin
      nCheckCode := 6;
      SetTargetCreat(AttackTarget);
      nCheckCode := 7;
    end;
    wIdent := SM_HIT;
    case wHitMode of
      0: wIdent := SM_HIT;
      1: wIdent := SM_HEAVYHIT;
      2: wIdent := SM_BIGHIT;
      3: if boPowerHit then begin//攻杀
          wIdent := SM_POWERHIT;
        end;
      4: if m_MagicArr[SKILL_ERGUM] <> nil then begin //刺杀
          wIdent := SM_LONGHIT;
        end;
      5: if m_MagicArr[SKILL_BANWOL] <> nil then begin //半月
          wIdent := SM_WIDEHIT;
        end;
      7: if boFireHit then begin//烈火
          wIdent := SM_FIREHIT;
        end;
      11: if m_boOnHorse then
            wIdent := SM_LONGHIT;
      43: if boLongIceHit then begin
            if m_boLongIceHitIsLong then wIdent := SM_LONGICEHIT_L
            else wIdent := SM_LONGICEHIT_S;
        end;
      56: if bo56Hit then begin //逐日剑法
          wIdent := SM_56;
        end;
      110: if bo110Hit then begin //三绝杀
          wIdent := SM_110;
        end;
      112: if bo112Hit then begin //断岳斩
          wIdent := SM_112;
        end;
      113: if bo113Hit then begin //横扫千军
          wIdent := SM_113;
        end;
      122: if bo122Hit then begin //穿刺剑法
          wIdent := SM_122;
        end;
    end;
    nCheckCode := 8;
    SendAttackMsg(RM_HIT, wIdent, m_btDirection, m_nCurrX, m_nCurrY);
    nCheckCode := 9;
    Self.AttackJump;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg, [nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
end;

function TPlayObject._Attack(var wHitMode: Word; AttackTarget: TBaseObject): Boolean;

//攻击角色
  function DirectAttack(BaseObject: TBaseObject; nSecPwr: Integer; boAttack: Boolean = False): Boolean;
  begin
    Result := False;
    if (m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or
      not (InSafeZone and BaseObject.InSafeZone) then begin
      if IsProperTarget(BaseObject) then begin
        if boAttack or (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
          BaseObject.StruckDamage(nSecPwr, Self);
          BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),
            RM_10101,
            nSecPwr,
            BaseObject.m_WAbil.HP,
            BaseObject.m_WAbil.MaxHP,
            Integer(Self),
            '', 200);
          if BaseObject.m_btRaceServer <> RC_PLAYOBJECT then begin
            BaseObject.SendMsg(BaseObject,
              RM_STRUCK,
              nSecPwr,
              BaseObject.m_WAbil.HP,
              BaseObject.m_WAbil.MaxHP,
              Integer(Self),
              '');
          end;
          Result := True;
        end;
      end;
    end;
  end;

  //刺杀前面一个位置的攻击
  function SwordLongAttack(nSecPwr: Integer; nRate: Byte; boDecAC: Boolean; boAttack: Boolean = False): Boolean;
  var
    nX, nY, I: Integer;
    BaseObject: TBaseObject;
    nPower: Integer;
  begin
    Result := False;
    if (nSecPwr > 0) then begin
      for I := 2 to nRate do begin
        if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nX, nY) then begin
          BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
          if BaseObject <> nil then begin
            nPower := nSecPwr;
            if boDecAC then begin
              nPower := BaseObject.GetHitStruckDamage(Self, nPower);
            end;
            if nPower > 0 then begin
              if DirectAttack(BaseObject, nPower, boAttack) then
                SetTargetCreat(BaseObject);
            end;
            Result := True;
          end;
        end;
      end;
    end;
  end;

  //半月攻击 (已改为抱月，全身周边攻击)
  function SwordWideAttack(nSecPwr: Integer; nRate: Byte; boDecAC: Boolean): Boolean;
  var
    nX, nY: Integer;
    I: Integer;
    MapCellInfo: pTMapCellinfo;
    OSObject: pTOSObject;
    BaseObject: TBaseObject;
    nPower: Integer;
  begin
    Result := False;
    for nX := m_nCurrX - nRate to m_nCurrX + nRate do begin
      for nY := m_nCurrY - nRate to m_nCurrY + nRate do begin
        if (nX = m_nCurrX) and (nY = m_nCurrY) then
          Continue;
        if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := MapCellInfo.ObjList.Items[I];
            if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if ((BaseObject <> nil) and (not BaseObject.m_boGhost) and (BaseObject.bo2B9)) and
                (not BaseObject.m_boDeath) and (BaseObject <> AttackTarget) then begin
                nPower := nSecPwr;
                if boDecAC then begin
                  nPower := BaseObject.GetHitStruckDamage(Self, nPower);
                end;
                if nPower > 0 then begin
                  if DirectAttack(BaseObject, nPower) then
                    SetTargetCreat(BaseObject);
                end;
                break;
              end;
            end;
          end;
        end;
      end;

    end;

  end;
  { var
     nC, n10: Integer;
     nX, nY: Integer;
     BaseObject: TBaseObject;
   begin
     Result := False;
     nC := 0;
     while (nSecPwr > 0) do begin
       n10 := (m_btDirection + g_Config.CrsAttack[nC]) mod 8;
       if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then begin
         BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
         if (BaseObject <> nil) then begin
           if DirectAttack(BaseObject, nSecPwr) then
             SetTargetCreat(BaseObject);
         end;
       end;
       Inc(nC);
       if nC >= 7 then
         break;
     end;
   end;   }
   {var
     nC, n10: Integer;
     nX, nY: Integer;
     BaseObject: TBaseObject;
   begin
     Result := False;
     nC := 0;
     while (True) do begin
       n10 := (m_btDirection + g_Config.WideAttack[nC]) mod 8;
       if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then begin
         BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
         if (nSecPwr > 0) and (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
           Result := DirectAttack(BaseObject, nSecPwr);
           SetTargetCreat(BaseObject);
         end;
       end;
       Inc(nC);
       if nC >= 3 then
         break;
     end;
   end;  }

   //抱月弯刀
  { function CrsWideAttack(nSecPwr: Integer): Boolean;
   var
     nC, n10: Integer;
     nX, nY: Integer;
     BaseObject: TBaseObject;
   begin
     Result := False;
     nC := 0;
     while (True) do begin
       n10 := (m_btDirection + g_Config.CrsAttack[nC]) mod 8;
       if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then begin
         BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
         if (nSecPwr > 0) and (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
           Result := DirectAttack(BaseObject, nSecPwr);
           SetTargetCreat(BaseObject);
         end;
       end;
       Inc(nC);
       if nC >= 7 then
         break;
     end;
   end;    }
var
  nPower, nSecPwr, nWeaponDamage: Integer;
  //bo21: Boolean;
  n20: Integer;
  nCheckCode: Integer;
  nMagID: Integer;
  nDelayTime: Integer;
resourcestring
  sExceptionMsg = '[Exception] TPlayObject::_Attack Name:= %s Code:=%d';
begin
  Result := False;
  nCheckCode := 0;
  nMagID := 0;
  try
    //    bo21 := False;
    nWeaponDamage := 0;
    nDelayTime := 200;
    if AttackTarget <> nil then begin
      nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
      if (wHitMode = 3) and m_boPowerHit then begin
        m_boPowerHit := False;
        Inc(nPower, m_nHitPlus);
        //        bo21 := True;
        nMagID := SKILL_YEDO;
        MagicQuest(nil, SKILL_YEDO, mfs_Self);
      end
      else if (wHitMode = 7) and m_boFireHitSkill then begin //烈火剑法
        m_boFireHitSkill := False;
        if m_MagicArr[SKILL_FIRESWORD] <> nil then begin
          m_MagicArr[SKILL_FIRESWORD].dwInterval := GetTickCount + m_MagicArr[SKILL_FIRESWORD].MagicInfo.nInterval;
          nMagID := SKILL_FIRESWORD;
          MagicQuest(nil, SKILL_FIRESWORD, mfs_Self);
        end;
        //m_dwLatestFireHitTick := GetTickCount(); //Jacky 禁止双烈火
        nPower := nPower + ROUND(nPower / 100 * (m_nHitDouble * 10));
      end
      else if (wHitMode = 110) and m_bo110HitSkill then begin //三绝杀
        m_bo110HitSkill := False;
        if m_MagicArr[SKILL_110] <> nil then begin
          m_MagicArr[SKILL_110].dwInterval := GetTickCount + m_MagicArr[SKILL_110].MagicInfo.nInterval;
          nMagID := SKILL_110;
          MagicQuest(nil, SKILL_110, mfs_Self);
        end;
        nPower := nPower + ROUND(nPower / 100 * ((m_MagicArr[SKILL_110].btLevel + 1) * 10));
        nPower := ROUND(nPower * (g_Config.nSkill110PowerRate / 100));
        nDelayTime := 500;
      end;
    end
    else begin
      nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
      if (wHitMode = 3) and m_boPowerHit then begin
        m_boPowerHit := False;
        Inc(nPower, m_nHitPlus);
        //        bo21 := True;
        nMagID := SKILL_YEDO;
        MagicQuest(nil, SKILL_YEDO, mfs_Self);
      end
      else {//防止砍空刀刀烈火} if (wHitMode = 7) and m_boFireHitSkill then begin
        m_boFireHitSkill := False;
        if m_MagicArr[SKILL_FIRESWORD] <> nil then begin
          m_MagicArr[SKILL_FIRESWORD].dwInterval := GetTickCount + m_MagicArr[SKILL_FIRESWORD].MagicInfo.nInterval;
          nMagID := SKILL_FIRESWORD;
          MagicQuest(nil, SKILL_FIRESWORD, mfs_Self);
        end;
        nPower := nPower + ROUND(nPower / 100 * (m_nHitDouble * 10));
        //m_dwLatestFireHitTick := GetTickCount(); //禁止双烈火
      end
      else if (wHitMode = 110) and m_bo110HitSkill then begin //三绝杀
        m_bo110HitSkill := False;
        if m_MagicArr[SKILL_110] <> nil then begin
          m_MagicArr[SKILL_110].dwInterval := GetTickCount + m_MagicArr[SKILL_110].MagicInfo.nInterval;
          nMagID := SKILL_110;
          MagicQuest(nil, SKILL_110, mfs_Self);
        end;
      end;
    end;
    nCheckCode := 1;
    nSecPwr := 0;
    if (wHitMode = 11) and m_boOnHorse then begin // 骑马攻击
      nSecPwr := nPower;
      if nSecPwr > 0 then begin
        SwordLongAttack(nSecPwr, 2, False);
      end;
    end else
    if (wHitMode = 4) and (m_MagicArr[SKILL_ERGUM] <> nil) then begin // 刺杀
      nCheckCode := 11;                                      
      if m_MagicArr[SKILL_ERGUM] <> nil then begin
        nCheckCode := 12;
        nSecPwr := ROUND(nPower / (m_MagicArr[SKILL_ERGUM].MagicInfo.btTrainLv + 2) * (m_MagicArr[SKILL_ERGUM].btLevel + 2));
        nCheckCode := 13;
        nMagID := SKILL_ERGUM;
        MagicQuest(nil, SKILL_ERGUM, mfs_Self);
      end;
      if nSecPwr > 0 then begin
        nCheckCode := 110;
        nSecPwr := ROUND(nSecPwr * g_Config.nSwordLongPowerRate / 100);
        if not SwordLongAttack(nSecPwr, 2, False) and g_Config.boLimitSwordLong then
          wHitMode := 0;
        nCheckCode := 111;
      end;
    end
    else if (wHitMode = 5) and (m_MagicArr[SKILL_BANWOL] <> nil) then begin //半月
      nCheckCode := 2;
      if m_MagicArr[SKILL_BANWOL] <> nil then begin
        nMagID := SKILL_BANWOL;
        nSecPwr := ROUND(nPower / (m_MagicArr[SKILL_BANWOL].MagicInfo.btTrainLv + 10) * (m_MagicArr[SKILL_BANWOL].btLevel + 2));
        MagicQuest(nil, SKILL_BANWOL, mfs_Self);
      end;
      if nSecPwr > 0 then
        SwordWideAttack(nSecPwr, 1, False);
    end
    else if (wHitMode = 43) and m_boLongIceHit then begin //开天斩
      nCheckCode := 5611;
      m_boLongIceHit := False;
      nPower := nPower + ROUND(nPower / 100 * (m_nLongIceHitDouble * 10));
      nSecPwr := nPower;
      if m_MagicArr[SKILL_LONGICEHIT] <> nil then begin
        nMagID := SKILL_LONGICEHIT;
        m_MagicArr[SKILL_LONGICEHIT].dwInterval := GetTickCount + m_MagicArr[SKILL_LONGICEHIT].MagicInfo.nInterval;
        nCheckCode := 5612;
        MagicQuest(nil, SKILL_LONGICEHIT, mfs_Self);
      end;
      if nSecPwr > 0 then begin
        nCheckCode := 56110;
        if m_boLongIceHitIsLong then SwordLongAttack(nSecPwr, 4, True, True)
        else SwordLongAttack(nSecPwr, 2, True, True);
        nCheckCode := 56111;
      end;
    end
    else if (wHitMode = 56) and m_bo56HitSkill then begin //逐日剑法
      nCheckCode := 5611;
      m_bo56HitSkill := False;
      if m_MagicArr[SKILL_56] <> nil then begin
        nMagID := SKILL_56;
        m_MagicArr[SKILL_56].dwInterval := GetTickCount + m_MagicArr[SKILL_56].MagicInfo.nInterval;
        nCheckCode := 5612;
        nSecPwr := ROUND(nPower / (m_MagicArr[SKILL_56].MagicInfo.btTrainLv + 2) * (m_MagicArr[SKILL_56].btLevel + 2));
        nCheckCode := 5613;
        MagicQuest(nil, SKILL_56, mfs_Self);
      end;
      if nSecPwr > 0 then begin
        nCheckCode := 56110;
        SwordLongAttack(nSecPwr, 4, True);
        nCheckCode := 56111;
      end;
    end
    else if (wHitMode = 112) and m_bo112HitSkill then begin //断岳斩
      nCheckCode := 1122;
      m_bo112HitSkill := False;
      nDelayTime := 300;
      if m_MagicArr[SKILL_112] <> nil then begin
        nMagID := SKILL_112;
        m_MagicArr[SKILL_112].dwInterval := GetTickCount + m_MagicArr[SKILL_112].MagicInfo.nInterval;
        nPower := ROUND(nPower * (g_Config.nSkill112PowerRate / 100));
        nSecPwr := ROUND(nPower / (m_MagicArr[SKILL_112].MagicInfo.btTrainLv + 2) * (m_MagicArr[SKILL_112].btLevel + 2));
        MagicQuest(nil, SKILL_112, mfs_Self);
      end;
      if nSecPwr > 0 then
        SwordLongAttack(nSecPwr, 3, True);
    end
    else if (wHitMode = 113) and m_bo113HitSkill then begin //横扫千军
      nCheckCode := 1132;
      m_bo113HitSkill := False;
      if m_MagicArr[SKILL_113] <> nil then begin
        nMagID := SKILL_113;
        m_MagicArr[SKILL_113].dwInterval := GetTickCount + m_MagicArr[SKILL_113].MagicInfo.nInterval;
        nPower := ROUND(nPower * (g_Config.nSkill113PowerRate / 100));
        nSecPwr := ROUND(nPower / (m_MagicArr[SKILL_113].MagicInfo.btTrainLv + 2) * (m_MagicArr[SKILL_113].btLevel + 2));
        MagicQuest(nil, SKILL_113, mfs_Self);
      end;
      if nSecPwr > 0 then
        SwordWideAttack(nSecPwr, 2, True);
    end
    else if (wHitMode = 122) and m_bo122HitSkill then begin //穿刺剑法
      nCheckCode := 1222;
      m_bo122HitSkill := False;
      if m_MagicArr[SKILL_122] <> nil then begin
        nMagID := SKILL_122;
        nPower := nPower + ROUND(nPower / 100 * ((m_MagicArr[SKILL_122].btLevel * 4 + 4) * 10));
        m_MagicArr[SKILL_122].dwInterval := GetTickCount + m_MagicArr[SKILL_122].MagicInfo.nInterval;
        nSecPwr := ROUND(nPower / (m_MagicArr[SKILL_122].MagicInfo.btTrainLv + 2) * (m_MagicArr[SKILL_122].btLevel + 2));
        MagicQuest(nil, SKILL_122, mfs_Self);
      end;
      if nSecPwr > 0 then
        SwordLongAttack(nSecPwr, 2, True);
    end;

    if AttackTarget = nil then
      Exit;

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
      nWeaponDamage := (Random(5) + 2) - m_AddAbil.btWeaponStrong;
    end;
    nCheckCode := 600;
    if nPower > 0 then begin
      nCheckCode := 601;
      AttackTarget.StruckDamage(nPower, Self);
      AttackTarget.OrdinaryAttack(Self);
      nCheckCode := 602;
      AttackTarget.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower,
        AttackTarget.m_WAbil.HP, AttackTarget.m_WAbil.MaxHP, Integer(Self), '', nDelayTime);
      nCheckCode := 603;

      //麻痹
      if not AttackTarget.m_boUnParalysis and m_boParalysis and
        (Random(AttackTarget.m_btAntiPoison + g_Config.nAttackPosionRate {5}) = 0) then begin
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
      nCheckCode := 606;

      //基本剑术
      if (m_MagicArr[SKILL_ONESWORD] <> nil) and (m_MagicArr[SKILL_ONESWORD].MagicInfo.btTrainLv <=9) and
      (m_MagicArr[SKILL_ONESWORD].btLevel < m_MagicArr[SKILL_ONESWORD].MagicInfo.btTrainLv) and
        (m_MagicArr[SKILL_ONESWORD].MagicInfo.TrainLevel[m_MagicArr[SKILL_ONESWORD].btLevel] <= m_Abil.Level) then begin
        nCheckCode := 607;
        TrainSkill(m_MagicArr[SKILL_ONESWORD], Random(3) + 1);
        nCheckCode := 608;
        if not CheckMagicLevelup(m_MagicArr[SKILL_ONESWORD]) then begin
          nCheckCode := 609;
          SendDelayDefMsg(Self, SM_MAGIC_LVEXP, m_MagicArr[SKILL_ONESWORD].MagicInfo.wMagicId,
            m_MagicArr[SKILL_ONESWORD].btLevel, LoWord(m_MagicArr[SKILL_ONESWORD].nTranPoint),
            HiWord(m_MagicArr[SKILL_ONESWORD].nTranPoint), '', 3000);
        end;
        nCheckCode := 610;
      end;

      //精神力战法
      if (m_MagicArr[SKILL_ILKWANG] <> nil) and (m_MagicArr[SKILL_ILKWANG].MagicInfo.btTrainLv <=9) and
      (m_MagicArr[SKILL_ILKWANG].btLevel < m_MagicArr[SKILL_ILKWANG].MagicInfo.btTrainLv) and
        (m_MagicArr[SKILL_ILKWANG].MagicInfo.TrainLevel[m_MagicArr[SKILL_ILKWANG].btLevel] <= m_Abil.Level) then begin
        nCheckCode := 607;
        TrainSkill(m_MagicArr[SKILL_ILKWANG], Random(3) + 1);
        nCheckCode := 608;
        // 0 -- 3 - 0 -- 9 >= 0 几率为：10% -- 20% -- 30% -- 40%
        if (m_MagicArr[SKILL_ILKWANG].btLevel - Random(10) >= 0) then begin
          // 新增加精神力战法普攻回蓝 3 * (level + 1) 点
          Inc(m_nIncSpell, (m_MagicArr[SKILL_ILKWANG].btLevel + 1) * 3);
        end;
        if not CheckMagicLevelup(m_MagicArr[SKILL_ILKWANG]) then begin
          nCheckCode := 609;
          SendDelayDefMsg(Self, SM_MAGIC_LVEXP, m_MagicArr[SKILL_ILKWANG].MagicInfo.wMagicId,
            m_MagicArr[SKILL_ILKWANG].btLevel, LoWord(m_MagicArr[SKILL_ILKWANG].nTranPoint),
            HiWord(m_MagicArr[SKILL_ILKWANG].nTranPoint), '', 3000);
        end;
        nCheckCode := 610;
      end;

      if (m_MagicArr[nMagID] <> nil) and (m_MagicArr[nMagID].MagicInfo.btTrainLv <=9) and
      (m_MagicArr[nMagID].btLevel < m_MagicArr[nMagID].MagicInfo.btTrainLv) and
        (m_MagicArr[nMagID].MagicInfo.TrainLevel[m_MagicArr[nMagID].btLevel] <= m_Abil.Level) then begin
        TrainSkill(m_MagicArr[nMagID], 1);
        if not CheckMagicLevelup(m_MagicArr[nMagID]) then begin
          SendDelayDefMsg(Self, SM_MAGIC_LVEXP, m_MagicArr[nMagID].MagicInfo.wMagicId,
            m_MagicArr[nMagID].btLevel, LoWord(m_MagicArr[nMagID].nTranPoint),
            HiWord(m_MagicArr[nMagID].nTranPoint), '', 3000);
        end;
      end;

      Result := True;
    end;
    nCheckCode := 9;
    if (nWeaponDamage > 0) and (m_UseItems[U_WEAPON].wIndex > 0) then
      DoDamageWeapon(nWeaponDamage);

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

function TPlayObject.GetQuestFlagStatus(nFlag: Integer): Integer;
var
  n10, n14: Integer;
begin
  Result := 0;
  Dec(nFlag);
  if nFlag < 0 then
    Exit;
  n10 := nFlag div 8;
  n14 := (nFlag mod 8);
  if (n10 >= Low(m_QuestFlag)) and (n10 <= High(m_QuestFlag)) then begin
    if ((128 shr n14) and (m_QuestFlag[n10])) <> 0 then
      Result := 1
    else
      Result := 0;
  end;
end;

function TPlayObject.GetQuestFlagStatus(sFlag: string; nDef: Integer): Integer;
begin
  if Pos(']', sFlag) > 0 then
    ArrestStringEx(sFlag, '[', ']', sFlag);
  Result := GetQuestFlagStatus(StrToIntDef(sFlag, nDef));
end;

procedure TPlayObject.SetQuestFlagStatus(nFlag: Integer; nValue: Integer);
var
  n10, n14: Integer;
  bt15: Byte;
begin
  Dec(nFlag);
  if nFlag < 0 then
    Exit;
  n10 := nFlag div 8;
  n14 := (nFlag mod 8);
  if (n10 >= Low(m_QuestFlag)) and (n10 <= High(m_QuestFlag)) then begin
    bt15 := m_QuestFlag[n10];
    if nValue = 0 then begin
      m_QuestFlag[n10] := (not (128 shr n14)) and (bt15);
    end
    else begin
      m_QuestFlag[n10] := (128 shr n14) or (bt15);
    end;
  end;
end;

procedure TPlayObject.SetQuestFlagStatus(sFlag: string; nValue, nDef, nRange: Integer);
var
  i: Integer;
begin
  if Pos(']', sFlag) > 0 then
    ArrestStringEx(sFlag, '[', ']', sFlag);
  for i := 0 to nRange - 1 do
    SetQuestFlagStatus(StrToIntDef(sFlag, nDef) + i, nValue);
end;

function TPlayObject.GetMissionFlagStatus(nFlag: Integer): Integer;
var
  n10, n14: Integer;
begin
  Result := 0;
  Dec(nFlag);
  if nFlag < 0 then
    Exit;
  n10 := nFlag div 8;
  n14 := (nFlag mod 8);
  if (n10 >= Low(m_MissionFlag)) and (n10 <= High(m_MissionFlag)) then begin
    if ((128 shr n14) and (m_MissionFlag[n10])) <> 0 then
      Result := 1
    else
      Result := 0;
  end;
end;

function TPlayObject.GetMissionFlagStatus(sFlag: string; nDef: Integer): Integer;
begin
  if Pos(']', sFlag) > 0 then
    ArrestStringEx(sFlag, '[', ']', sFlag);
  Result := GetMissionFlagStatus(StrToIntDef(sFlag, nDef));
end;

procedure TPlayObject.SetMissionFlagStatus(nFlag: Integer; nValue: Integer);
var
  n10, n14: Integer;
  bt15: Byte;
begin
  Dec(nFlag);
  if nFlag < 0 then
    Exit;
  n10 := nFlag div 8;
  n14 := (nFlag mod 8);
  if (n10 >= Low(m_MissionFlag)) and (n10 <= High(m_MissionFlag)) then begin
    bt15 := m_MissionFlag[n10];
    if nValue = 0 then begin
      m_MissionFlag[n10] := (not (128 shr n14)) and (bt15);
    end
    else begin
      m_MissionFlag[n10] := (128 shr n14) or (bt15);
    end;
    SendDefMessage(SM_MISSIONINFO, n10, m_MissionFlag[n10], 0, MISSTAG_FLAGCHANGE, '');
  end;
end;

procedure TPlayObject.SetMissionFlagStatus(sFlag: string; nValue, nDef, nRange: Integer);
var
  i: Integer;
begin
  if Pos(']', sFlag) > 0 then
    ArrestStringEx(sFlag, '[', ']', sFlag);
  for i := 0 to nRange - 1 do
    SetMissionFlagStatus(StrToIntDef(sFlag, nDef) + i, nValue);
end;

procedure TPlayObject.RecalcHitSpeed();
var
  i: Integer;
  UserMagic: pTUserMagic;
begin
  m_btHitPoint := DEFHIT;
  if m_btJob = Taos then
    m_btSpeedPoint := DEFSPEED + 3
  else
    m_btSpeedPoint := DEFSPEED;

  m_nHitPlus := 0;
  m_nHitDouble := 0;
  m_nLongIceHitDouble := 0;

  SafeFillChar(m_MagicArr, SizeOf(m_MagicArr), #0);
  for i := m_MagicList.Count - 1 downto 0 do begin
    UserMagic := m_MagicList.Items[i];
    if UserMagic = nil then begin
      m_MagicList.Delete(I);
      Continue;
    end;
    if (UserMagic.wMagIdx > 0) and (UserMagic.wMagIdx < SKILL_MAX) then begin
      m_MagicArr[UserMagic.wMagIdx] := UserMagic;
      case UserMagic.wMagIdx of
        SKILL_ONESWORD: begin //基本剑术
            if UserMagic.btLevel > 0 then begin
              m_btHitPoint := m_btHitPoint + ROUND(9 / 3 * UserMagic.btLevel);
            end;
          end;
        SKILL_YEDO: begin //攻杀剑法
            if UserMagic.btLevel > 0 then begin
              m_btHitPoint := m_btHitPoint + ROUND(3 / 3 * UserMagic.btLevel);
            end;
            m_nHitPlus := DEFHIT + UserMagic.btLevel;
            m_btAttackSkillCount := 7 - UserMagic.btLevel;
            m_btAttackSkillPointCount := Random(m_btAttackSkillCount);
          end;
        SKILL_FIRESWORD: begin //烈火剑法
            m_nHitDouble := 4 + UserMagic.btLevel * 4;
          end;
        SKILL_LONGICEHIT: begin //开天斩
            m_nLongIceHitDouble := 4 + UserMagic.btLevel * 3;
          end;
        SKILL_ILKWANG: begin // 精神力战法
            if UserMagic.btLevel > 0 then begin
              m_btHitPoint := m_btHitPoint + ROUND(5 * (UserMagic.btLevel+1));
            end;
          end;
      end;
    end;
  end;
end;

procedure TPlayObject.Initialize();
var
  i: Integer;
  UserMagic: pTUserMagic;
begin
  for i := 0 to m_MagicList.Count - 1 do begin
    UserMagic := m_MagicList.Items[i];
    if UserMagic.btLevel > 100 then
      UserMagic.btLevel := 100;
  end;
  inherited;
end;

function TPlayObject.IsTrainingSkill(nIndex: Integer): Boolean;
begin
  Result := True;
  if (nIndex > 0) and (nIndex < SKILL_MAX) then begin
    if m_MagicArr[nIndex] = nil then
      Result := False;
  end
  else
    Result := False;
end;
//{$ENDREGION}

procedure TPlayObject.ClearCenterMsg(nFlag: Integer);
var
  i: Integer;
  nValues: array of Integer;
  CenterMsg: pTCenterMsg;
begin
  SetLength(nValues, 0);
  for i := m_CenterMsgList.Count - 1 downto 0 do
  begin
    CenterMsg := m_CenterMsgList.Items[i];
    if Assigned(CenterMsg) and (CenterMsg.nFlag = nFlag) then
    begin
      SetLength(nValues, Length(nValues) + 1);
      nValues[Length(nValues) - 1] := Integer(CenterMsg);
      Dispose(CenterMsg);
      m_CenterMsgList.Delete(i);
    end;
  end;  
  if Length(nValues) > 0 then
    SendDefMsg(Self, SM_CLEARCENTERMSG, Length(nValues), 0, 0, 0, EnCodeBuffer(@nValues[0], Length(nValues) * SizeOf(Integer)));
end;

procedure TPlayObject.RefIconInfo;
var
  sText: string;
begin
  //MainOutMessage(format('%d %d', [SizeOf(TIconInfos), SizeOf(TIconInfo)]));
  sText := EncodeBuffer(@m_IconInfo[0], SizeOf(TIconInfos));
  SendRefMsg(RM_REFICONINFO, 0, Integer(Self), 0, 0, sText);
end;

function TPlayObject.TakeOffItem(btWhere: Byte; nItemIdx: Integer; boClient, boForce: Boolean): Boolean;
var
  n10: Integer;
  StdItem: pTStdItem;
  UserItem, AddUserItem: pTUserItem;
  hWhere: Byte;
label
  FailExit;
begin
  Result := False;
  n10 := 0;
  if not m_boDealing and (btWhere in [0..20]) then begin
    if btWhere in [16..20] then begin
      hWhere := btWhere - 16;
      if m_UseItems[U_House].wIndex > 0 then begin
        if (not boClient) or (m_UseItems[U_House].HorseItems[hWhere].MakeIndex = nItemIdx) then begin
          StdItem := UserEngine.GetStdItem(m_UseItems[U_House].HorseItems[hWhere].wIndex);
          if (StdItem = nil) or (StdItem.Rule.Rule[RULE_NOTAKEOFF] and not boForce) then begin
            SysMsg(g_sCanotTakeOffItem {'无法取下物品.'}, c_Red, t_Hint);
            n10 := -4;
            goto FailExit;
          end;
          New(UserItem);
          UserItem^ := HorseItemToUserItem(@m_UseItems[U_House].HorseItems[hWhere], StdItem);
          if AddItemToBag(UserItem, nil, False, '', '', AddUserItem) <> -1 then begin
            m_UseItems[U_House].HorseItems[hWhere].wIndex := 0;
            m_sString[0] := UserEngine.GetStdItemName(UserItem.wIndex);
            m_nInteger[0] := btWhere;
            NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NTAKEOFFITEMS], False);
            if not boClient then
            begin
              SendDelItems(UserItem);
              SendAddItem(UserItem);
            end;
            RecalcAbilitys();
            SendAbility;
            SendSubAbility;
            if boClient then
              SendDefMessage(SM_TAKEOFF_OK, GetFeatureToLong, GetFeatureEx, 0, 0, '');
            Result := True;
            //发送脱装备用这个也可以
            FeatureChanged();
            n10 := 1;
          end
          else begin
            DisPose(UserItem);
            n10 := -3;
          end;
        end;
      end else
        SysMsg(g_sCanotTakeOffItem {'无法取下物品.'}, c_Red, t_Hint);
      //m_UseItems[U_House].HorseItems[hWhere]
    end else
    if m_UseItems[btWhere].wIndex > 0 then begin
      if (not boClient) or (m_UseItems[btWhere].MakeIndex = nItemIdx) then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[btWhere].wIndex);
        if (StdItem = nil) or (StdItem.Rule.Rule[RULE_NOTAKEOFF] and not boForce) then begin
          SysMsg(g_sCanotTakeOffItem {'无法取下物品.'}, c_Red, t_Hint);
          n10 := -4;
          goto FailExit;
        end;
        New(UserItem);
        if (btWhere = U_HOUSE) and m_boOnHorse then
          m_UseItems[u_House].wHP := m_WAbil.HP;
        UserItem^ := m_UseItems[btWhere];
        if AddItemToBag(UserItem, nil, False, '', '', AddUserItem) <> -1 then begin
          m_UseItems[btWhere].wIndex := 0;
          if (btWhere = U_HOUSE) then m_boOnHorse := False;
          m_sString[0] := UserEngine.GetStdItemName(UserItem.wIndex);
          m_nInteger[0] := btWhere;
          NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[NTAKEOFFITEMS], False);
          if not boClient then
          begin
            SendDelItems(UserItem);
            SendAddItem(UserItem);
          end;
          RecalcAbilitys();
          SendAbility;
          SendSubAbility;
          if boClient then
            SendDefMessage(SM_TAKEOFF_OK, GetFeatureToLong, GetFeatureEx, 0, 0, '');
          Result := True;
          //发送脱装备用这个也可以
          FeatureChanged();
          n10 := 1;
        end
        else begin
          DisPose(UserItem);
          n10 := -3;
        end;
        //end;
      end;
    end
    else
      n10 := -2;
  end
  else
    n10 := -1;
  FailExit:
  if boClient and (n10 <= 0) then
    SendDefMessage(SM_TAKEOFF_FAIL, n10, 0, 0, 0, '');
end;

end.

