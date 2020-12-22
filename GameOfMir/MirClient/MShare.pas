unit MShare;

interface
uses
  Windows, Classes, SysUtils, StrUtils, HGETextures, HGEGUI, ZLIB, DateUtils,
  WIL, Actor, Grobal2, Share, Graphics, HGECanvas, HGEFonts, HGESounds, 
  FindMapPath, WMFile, Dialogs, MudUtil, DirectXGraphics, SDK, Guaji;

const
  REG_SETUP_OPATH = 'SOFTWARE\Jason\Mir2\Setup';
  REG_SETUP_PATH = 'SOFTWARE\IEngine\Mir2\Setup';
  REG_SETUP_BITDEPTH = 'BitDepth';
  REG_SETUP_DISPLAY = 'DisplaySize';
  REG_SETUP_WINDOWS = 'Window';
  REG_SETUP_MP3VOLUME = 'MusicVolume';
  REG_SETUP_SOUNDVOLUME = 'SoundVolume';
  REG_SETUP_MP3OPEN = 'MusicOpen';
  REG_SETUP_SOUNDOPEN = 'SoundOpen';

  FLASHBASE = 1840;  //snda is 410

  NEWPOINTOX = 35;
  NEWPOINTOY = 5;
  ITEMTABLEWIDTH = 42;
  ITEMTABLEHEIGHT = 42;

type
  TTimerCommand = (tcSoftClose, tcReSelConnect, tcFastQueryChr,
    tcQueryItemPrice);
  TChrAction = (caWalk, caRun, caHorseRun, caHit, caSpell, caSitdown, caLeap);
  TConnectionStep = (cnsLogin, cnsSelChr, cnsReSelChr, cnsPlay, cnsSelServer);

  pTMovingItem = ^TMovingItem;
  TItemType = (i_HPDurg, i_MPDurg, i_HPMPDurg, i_OtherDurg, i_Weapon, i_Dress,
    i_Helmet, i_Necklace, i_Armring, i_Ring, i_Belt, i_Boots, i_Charm, i_Book,
    i_PosionDurg, i_UseItem, i_Scroll, i_Stone, i_Gold, i_Other);


  TUserSayMode = (usm_Hear, usm_Whisper, usm_Cry, usm_Group, usm_Guild, usm_World);
  TUserSayType = (us_All, us_Hear, us_Whisper, us_Cry, us_Group, us_Guild, us_Sys, us_Custom, us_None);

  TUserSaySet = set of TUserSayType;

  TMoveItemType = (mtBagItem, mtBagGold, mtDealGold, mtStateItem, mtStateMagic, mtBottom);
  //TMoveItemDlg = (mdBagGold, mdDealGold{mdBag, , mdDeal, mdDealGold, mdState});
  TMoveItemState = set of (mis_MyDeal, mis_Sell, mis_Repair, mis_SuperRepair, mis_Storage, mis_Bag, mis_State,
    mis_AddBag, mis_ArmStrengthen, mis_MakeItem, mis_ShopSell, mis_ShopBuy, mis_ReadShop, mis_StorageBack,
    mis_buy, mis_EMailItem, mis_EMailReadItem, mis_bottom, mis_ArmStrengthenAdd, mis_ArmAbilityMoveAdd, mis_MakeItemAdd,
    mis_ItemUnsealAdd, mis_ItemRemoveStoneAdd, mis_CompoundItemAdd);

  TClickPoint = record
    rc: TRect;
    rstr: string;
    sstr: string;
    boNewPoint: Boolean;
    Color: TColor;
    boItem: Boolean;
    Item: TNewClientItem;
  end;
  pTClickPoint = ^TClickPoint;

  TClientOpenBoxInfo = packed record
    ItemType: TBoxItemType;
    Item: TNewClientItem;
  end;

  TMovingItem = record
    Index2: Integer;
    wCount: Word;
    Item: TNewClientItem;
    ItemType: TMoveItemType;
  end;

  TArmStrengthenArr = array[0..5] of TMovingItem;
  TClientBagitems = array[0..MAXBAGITEMS - 1] of TNewClientItem;
  
  pTEMailInfo = ^TEMailInfo;
  TEMailInfo = record
    ClientEMail: TClientEMailHeader;
    sText: string;
    nGold: Integer;
    Item: TNewClientItem;
  end;

  PTNewClientMagic = ^TNewClientMagic;
  TNewClientMagic = packed record
    boStudy: Boolean;
    boNotUse: Boolean;
    Level: Byte;
    CurTrain: Integer;
    dwInterval: LongWord;
    boUse: Boolean;
    btEffIdx: Word;
    btKey: Byte;
    dwTime: LongWord;
    Def: TClientDefMagic;
  end;


  pTClientMakeGoods = ^TClientMakeGoods;
  TClientMakeGoods = packed record
    nID: Integer;
    btLevel: Byte;
    wLevel: Word;
    MakeItem: TMakeItem;
    Item: array[0..5] of TNewClientItem;
  end;

  TMoveHMShow = packed record
    Surface: TDirectDrawSurface;
    dwMoveHpTick: LongWord;
  end;
  pTMoveHMShow = ^TMoveHMShow;

  TShopItem = record
    nIndex: Integer;
    ClientShopItem: TClientShopItem;
    CLientItem: TNewClientItem;
    sHint: string;
  end;
  pTShopItem = ^TShopItem;

  TServerInfo = packed record
    ShowName: string[50];
    Name: string[30];
    Addr: string[16];
    Port: word;
  end;
  pTServerInfo = ^TServerInfo;

  TGuildMemberInfo = packed record
    btRank: Byte;
    RankName: string[16];
    UserName: string[14];
    nCount: Word;
    nTime: Integer;
    //GuildMemberInfo: TClienGuildMemberInfo;
  end;
  pTGuildMemberInfo = ^TGuildMemberInfo;

  {TMessageDlg = record
    sMsg: string;
    DlgButtons: TMsgDlgButtons;
    MsgLen: Integer;
    EClass: TDEditClass;
    sDefmsg: string;
  end;
  pTMessageDlg = ^TMessageDlg; }

  pTFaceImage = ^TFaceImage;
  TFaceImage = record
    ImageIndex: Integer;
    dwShowTime: LongWord;
    nShowX: Word;
  end;

  TMapDescList = record
    sMapName: string[50];
    MaxList: TList;
    MinList: TList;
  end;
  pTMapDescList = ^TMapDescList;

  pTClientMapEffect = ^TClientMapEffect;
  TClientMapEffect = record
    wX, wY: Integer;
    btType: Byte;
    sName: string[10];
  end;

  pTNewShowHint = ^TNewShowHint;
  TNewShowHint = record
    Surfaces: TWMImages;
    IndexList: TStringList;
    nX, nY: Integer;
    Rect: TRect;
    Reduce: Byte;
    boTransparent: Boolean;
    Alpha: Byte;
    dwTime: LongWord;
    boMove: Boolean;
    boBlend: Boolean;
    boLine: Boolean;
    boRect: Boolean;
  end;

  TMapDesc = record
    sName: string[50];
    nX, nY: Word;
    nColor: TColor;
  end;
  pTMapDesc = ^TMapDesc;

  TSysMsg = record
    nMsgType: Integer;
    sSysMsg: string;
    Color: TColor;
    nX: Integer;
    nY: Integer;
    dwSpellTime: Longword;
  end;
  pTSysMsg = ^TSysMsg;

  pTClientCheckMsg = ^TClientCheckMsg;
  TClientCheckMsg = packed record
    str: string;
    EndTime: LongWord;
    MsgIndex: Integer;
    MsgType: TCheckMsgClass;
    ShowTime: LongWord;
  end;

  TClickName = record
    nLeft, nRight: Word;
    sStr: string;
    Index: Integer;
  end;
  pTClickName = ^TClickName;

  TClickItem = record
    nLeft, nRight: Word;
    sStr: string;
    nIndex: Word;
    wIdent: Word;
    ItemIndex: Integer;
    Index: Integer;
    pc: TNewClientItem;
  end;
  pTClickItem = ^TClickItem;

  TSayImage = record
    nLeft, nRight: Word;
    nIndex: Word;
  end;
  pTSayImage = ^TSayImage;

  TAddBagInfo = packed record
    nStateCount: Byte;
    nItemCount: Byte;
  end;

  pTSayMessage = ^TSayMessage;
  TSayMessage = record
//    SayMsg: string;
//    boSys: Boolean;
//    boFirst: Boolean;
//    fcolor, bcolor: TColor;
    SaySurface: TDXImageTexture;
    ClickList: TList;
    ItemList: TList;
    ImageList: TList;
    UserSayType: TUserSayType;
//    boTransfer: Boolean;
  end;

  pTMyShopItem = ^TMyShopItem;
  TMyShopItem = packed record
    nMoney: Integer;
    boGamePoint: Boolean;
    ShopItem: TMovingItem;
  end;

  THDInfoType = (HIT_Prior, HIT_Desktop, HIT_Pictures, HIT_Personal, HIT_Folder, HIT_HD, HIT_IMAGE);

  pTHDInfo = ^THDInfo;
  THDInfo = record
    nImageID: Integer;
    sShowName: string;
    sName: string;
    sPlace: string;
    HDInfoType: THDInfoType;
    nLevel: Integer;
    boChange: Boolean;
  end;

  TDropItem = record
    X: Integer;
    Y: Integer;
    Width: Integer;
    Height: Integer;
    Id: Integer;
    Looks: Integer;
    Name: string;
    FlashTime: DWORD;
    FlashStepTime: DWORD;
    FlashStep: Integer;
    BoFlash: Boolean;
    nColor: LongWord;
    Filtr: pTClientItemFiltrate;
//    d: TDXImageTexture;
    m_dwDeleteTime: LongWord;
  end;
  pTDropItem = ^TDropItem;

  TControlInfo = record
    Image: Integer;
    Left: Integer;
    Top: Integer;
    Width: Integer;
    Height: Integer;
    Obj: TDControl;
  end;
  pTControlInfo = ^TControlInfo;

var
  g_sPhotoDirname:String = RESOURCEDIRNAME + 'UploadCache\';
  g_FaceIndexList: array[0..44] of Word = (
    0, 7, 12, 17, 23, 33, 38, 48, 59, 66,
    73, 84, 106, 114, 117, 122, 127, 134, 141, 154,
    156, 161, 167, 176, 188, 201, 218, 224, 227, 247,
    250, 255, 261, 266, 271, 290, 295, 298, 303, 309,
    313, 321, 324, 327, 330);

  g_FaceTextList1: array[0..High(g_FaceIndexList)] of string[10] = (
    '惊讶', '撇嘴', '好色', '发呆', '得意', '流泪', '害羞', '闭嘴', '睡觉', '大哭',
    '尴尬', '发怒', '调皮', '呲牙', '微笑', '难过', '酷', '抓狂', '恶心', '偷笑',
    '可爱', '白眼', '傲慢', '饥饿', '困', '惊恐', '流汗', '憨笑', '大兵', '奋斗',
    '咒骂', '疑问', '嘘...', '晕', '折磨', '敲打', '再见', '大便', '吻', '爱心',
    '心碎', '强', '弱', '握手', '胜利'

    );
  {g_FaceTextList2: array[0..High(g_FaceIndexList)] of String[10] = (
  'jy', 'pz', 'se', 'fd', 'dy', 'll', 'hx', 'bz', 'shui', 'dk',
  'gg', 'fn', 'tp', 'cy', 'wx', 'ng', 'kuk', 'zk', 'tu', 'tx',
  'ka', 'by', 'am', 'je', 'kun', 'jk', 'lh', 'hanx', 'db', 'fendou',
  'zhm', 'yiw', 'xu', 'yun', 'zhem', 'qiao', 'zj', 'bian', 'wen', 'xin',
  'xs', 'qiang', 'ruo', 'ws', 'shl'
  );  }

  g_FaceIndexInfo: array[0..High(g_FaceIndexList)] of TFaceImage;

  g_TempList: TStringList;

  g_sLogoText: string = 'Legend of Mir2';
  g_sGoldName: string = '金币';
  g_sGameGoldName: string = '元宝';
  g_sGamePointName: string = '点卷';
  g_sWarriorName: string = '战士'; //职业名称
  g_sWizardName: string = '魔法师'; //职业名称
  g_sTaoistName: string = '道士'; //职业名称
  g_sUnKnowName: string = '';
  g_sBindGoldName: string = '绑定金币';
  g_sGameDiamondName: string = '积分';

  g_nGameDiamond: Integer = 0;
  g_nGameGird: Integer = 0;
  g_nCreditPoint: Integer = 0;
  g_nPkPoint: Integer = 0;
  g_nBindGold: Integer = 0;
  g_nLiterary: Integer = 0;

  g_nNakedCount: Integer = 0;
  g_nNakedBackCount: Integer = 0;

  g_boCanDraw: Boolean = True;
  g_boSendLuck: Boolean = False;

  g_MapDescList: TList;
  g_MapDesc: pTMapDescList = nil;
  g_MapEffectList: TStringList;

  g_ClientNakedInfo: TClientNakedInfo;
  g_ClientNakedAddAbil: TNakedAddAbil;
  g_ClientCheckMsg: pTClientCheckMsg = nil;
  g_UserRealityInfo: TUserRealityInfo;
  //g_tempLong: LongWord;
  //Moudle: THandle;
  //GetTickCountEx: TGetTickCountEx;

  g_sWuXinJ: string = '金';
  g_sWuXinM: string = '木';
  g_sWuXinS: string = '水';
  g_sWuXinH: string = '火';
  g_sWuXinT: string = '土';

  g_sMainParam1: string; //读取设置参数
  g_sMainParam2: string; //读取设置参数
  g_sMainParam3: string; //读取设置参数
  g_sMainParam4: string; //读取设置参数
  g_sMainParam5: string; //读取设置参数
  g_sMainParam6: string; //读取设置参数

  //g_DXDraw: TDXDraw;
  g_DWinMan: TDWinManager;
  g_DXSound: TDXSound;
  g_DXFont: TDXFont;
  g_Sound: TSoundEngine;
  g_DXCanvas: TDXDrawCanvas;
  g_DControlFreeList: TList;
  g_Font: TFont;

  //g_UIBImages: TUIBImages;

{$IFDEF DEBUG}
  g_nParam1: Integer = 0;
  g_nParam2: Integer = 0;
  g_nParam3: Integer = 0;
  g_nParam4: Integer = 0;
  g_nParam5: Integer = 0;
{$ENDIF}
  g_nThisCRC: Integer;
  g_sServerName: string; //服务器显示名称
  g_sServerMiniName: string; //服务器名称
  g_sServerAddr: string = '127.0.0.1';
  g_nServerPort: Integer = 7000;
  g_sSelChrAddr: string;
  g_nSelChrPort: Integer;
  g_sRunServerAddr: string;
  g_nRunServerPort: Integer;
  g_StditemList: TList;
  g_StditemFiltrateList: TList;


  g_boSendLogin: Boolean; //是否发送登录消息
  g_boServerConnected: Boolean;
  g_SoftClosed: Boolean; //小退游戏
  g_ChrAction: TChrAction;
  g_ConnectionStep: TConnectionStep;

  g_ShopHintList: TStringList;
  g_CompoundInfoList: TGStringList;

  g_GuildNoticeIndex: Integer;
  g_GuildMemberIndex: Integer;
  g_FriendList: TStringList;
  g_UserKeySetup: TUserKeySetup;
  g_UserKeyIndex: array[Low(g_UserKeySetup)..High(g_UserKeySetup)] of Integer;
  g_UserKeyChange: Boolean = False;
  g_boDoctorAlive: Boolean = False;

  //  g_boSayMsgDown: Boolean = False;

  g_CloseAllSys: Boolean; //拒绝所有公聊信息
  g_CloseCrcSys: Boolean; //拒绝所有喊话信息
  g_CloseMySys: Boolean; //拒绝所有私聊信息
  g_CloseGuildSys: Boolean; //拒绝所有行会信息
  g_AutoSysMsg: Boolean; //自动喊话
  g_AutoMsg: string[90]; //自动喊话内容
  g_AutoMsgTick: LongWord;
  g_AutoMsgTime: LongWord = 10000;

  MAKEITEMCOLOR: string = '$FFFFFF';
  SELLDEFCOLOR: string = '$847CCF'; //售价默认颜色 $847CCF
  HINTDEFCOLOR: string = '$FFFFFF'; //提示默认颜色 $65D16A
  NOTDOWNCOLOR: string = '$99C5E2'; //不可交易颜色 $99C5E2  128/131
  ADDVALUECOLOR: string = '$FF7979'; //普通属性颜色 $FF7979   156/155
  ADDVALUECOLOR2: string = '$DA65C0'; //特殊属性颜色 $DA65C0  20/156
  ADDVALUECOLOR3: string = '$DA65C0'; //特殊属性颜色 $DA65C0  20/156
  ITEMNAMECOLOR: string = '$00FFFF';
  SUITITEMCOLOR: string;
  SUITITEMCOLOR2: string;
  WUXINCOLOR: string = '$CF8170';
  WUNXINENABLECOLOR: string = '$828282';
  WUXINISMYCOLOR: string = '$53BD8E';
  HINTCOLOR1: string = '$BE8276';
  HINTCOLOR2: string = '$848385';
  //套装 145  售价 67/68

  g_boFullScreen: Boolean = False;

  //g_ImgMixSurface: TDirectDrawSurface = nil;
  //g_MiniMapSurface: TDirectDrawSurface = nil;

  g_boFirstTime: Boolean;
  g_boInitialize: Boolean;
  g_nInitializePer: Integer;
  //  g_boChangeWin: Boolean;
  g_sMapTitle: string;
  g_nMapMusic: Integer;

  //g_ServerList: TList;

  g_GroupMembers: TList; //组成员列表
  g_GroupItemMode: Boolean = False; //物品分配模式
  g_SaveItemList: TList;
  g_MenuItemList: TList;
  g_DropedItemList: TList; //地面物品列表
  g_ChangeFaceReadyList: TList; //
  g_FreeActorList: TList; //释放角色列表
  g_FreeItemList: TList; //释放地面物品列表
  g_SoundList: TStringList; //声音列表

  g_GuildIndex: array[0..4] of Word;
  g_ClientGuildInfo: TClientGuildInfo;
//  g_nBonusPoint: Integer;
 // g_nSaveBonusPoint: Integer;
//  g_BonusTick: TNakedAbility;
//  g_BonusAbil: TNakedAbility;
//  g_NakedAbil: TNakedAbility;
//  g_BonusAbilChg: TNakedAbility;

//  g_sGuildName: string; //行会名称
 // g_sGuildRankName: string; //职位名称
  g_dwClickNpcTick: LongWord = 0;

  g_boLatestSpell: Boolean;

  g_dwLastAttackTick: LongWord;
  //最后攻击时间(包括物理攻击及魔法攻击)
  g_dwLastMoveTick: LongWord; //最后移动时间
  g_dwLatestStruckTick: LongWord; //最后弯腰时间
  g_dwLatestSpellTick: LongWord; //最后魔法攻击时间
  //g_dwLatestFireHitTick: LongWord; //最后列火攻击时间
  g_dwLatestRushRushTick: LongWord; //最后被推动时间
  g_dwLatestHitTick: LongWord;
  //最后物理攻击时间(用来控制攻击状态不能退出游戏)
  g_dwLatestMagicTick: LongWord;
  //最后放魔法时间(用来控制攻击状态不能退出游戏)

  g_dwMagicDelayTime: LongWord;
  g_dwMagicPKDelayTime: LongWord;

  g_nMouseCurrX: Integer; //鼠标所在地图位置座标X
  g_nMouseCurrY: Integer; //鼠标所在地图位置座标Y
  g_nMouseX: Integer; //鼠标所在屏幕位置座标X
  g_nMouseY: Integer; //鼠标所在屏幕位置座标Y

  g_nTargetX: Integer; //目标座标
  g_nTargetY: Integer; //目标座标
  g_TargetCret: TActor;
  g_FocusCret: TActor;
  g_MagicTarget: TActor;
  g_MagicLockTarget: TActor;
  g_NPCTarget: TNPCActor;

{$IFDEF DEBUG}
  g_boShowItemID: Boolean = False;
{$ENDIF}
  g_boAttackSlow: Boolean; //腕力不够时慢动作攻击.
  g_boMoveSlow: Boolean; //负重不够时慢动作跑
  g_nMoveSlowLevel: Integer;
  g_boMapMoving: Boolean; //甘 捞悼吝, 钱副锭鳖瘤 捞悼 救凳
  g_boMapMovingWait: Boolean;
  g_boMapInitialize: Boolean;
  //g_boMapOldChange: Boolean;
  g_btMapinitializePos: Byte;
  g_boMapApoise: Boolean;
  g_boCheckBadMapMode: Boolean;
  //是否显示相关检查地图信息(用于调试)
  g_boCheckSpeedHackDisplay: Boolean; //是否显示机器速度数据
  g_boShowGreenHint: Boolean = False;
  g_boShowWhiteHint: Boolean;
  g_boViewMiniMapMark: Boolean = False; //是否显示小地图
  g_nViewMinMapLv: Integer = 1;
  //Jacky 小地图显示模式(0为不显示，1为透明显示，2为清析显示)
  g_nMiniMapIndex: Integer; //小地图号
  g_nMiniMapX: Integer;
  g_nMiniMapY: Integer;
  g_nMiniMapOldX: Integer = -1;
  g_nMiniMapOldY: Integer = -1;
  g_nMiniMapMaxX: Integer = -1;
  g_nMiniMapMaxY: Integer = -1;
  g_nMiniMapMosX: Integer;
  g_nMiniMapMosY: Integer;
  g_nMiniMapMaxMosX: Integer;
  g_nMiniMapMaxMosY: Integer;
  g_nMiniMapMoseX: Integer = -1;
  g_nMiniMapMoseY: Integer = -1;
  g_nMiniMaxShow: Boolean;
  g_nMiniMapPath: TPath;
  g_boMiniMapClose: Boolean = False;
  g_boMiniMapShow: Boolean = False;
  //  g_nMiniMapMovePath: Boolean;
  g_LegendMap: TLegendMap;
  g_GuaJi: TGuaJi;
//  g_LegendMapName: string = '';
//  g_LegendMapRun: Boolean = False;
  g_FrmMainWinHandle: THandle;

  g_boAutoMoveing: Boolean;
  g_boNpcMoveing: Boolean;

  //g_boShowMsgDlg: Boolean = False;
  //g_ShowMsgDlgList: TList;

  //NPC 相关
  g_nCurMerchant, g_nCurMerFlag: Integer; //弥辟俊 皋春甫 焊辰 惑牢
  g_nMDlgX: Integer;
  g_nMDlgY: Integer; //皋春甫 罐篮 镑
  g_dwChangeGroupModeTick: LongWord;
  g_dwDealActionTick: LongWord;
  g_dwQueryMsgTick: LongWord;
  g_nDupSelection: Integer;

//  g_boAllowGroup: Boolean;
  //g_boCheckGroup: Boolean;

  //人物信息相关
  g_nMySpeedPoint: Integer; //敏捷
  g_nMyHitPoint: Integer; //准确
  g_nMyAntiPoison: Integer; //魔法躲避
  g_nMyPoisonRecover: Integer; //中毒恢复
  g_nMyHealthRecover: Integer; //体力恢复
  g_nMySpellRecover: Integer; //魔法恢复
  g_nMyAntiMagic: Integer; //魔法躲避
  g_nMyAddAttack: Byte;
  g_nMyDelDamage: Byte;
  g_nMyAddWuXinAttack: Byte;
  g_nMyDelWuXInAttack: Byte;
  g_nMyHungryState: Integer; //饥饿状态
  g_wAvailIDDay: Word;
  g_wAvailIDHour: Word;
  g_wAvailIPDay: Word;
  g_wAvailIPHour: Word;
  g_nDeadliness: Integer;

  //g_MagicList: TList; //技能列表
  g_MagicArry: array[0..SKILL_MAX] of TClientDefMagic;  //系统技能表
  g_MyMagicArry: array[0..SKILL_MAX] of TNewClientMagic; //用户技能表
  g_nLastMagicIdx: Integer = -1;     //最后使用的技能ID
  //g_MyMagic: array[0..300] of PTClientMagic;

  //g_MouseHeroItem           :TClientItem;

  g_TaxisSelf: TClientTaxisSelf;
  g_SetItemsList: TList;

  g_ShopDateTime: TDateTime;
  g_ShopLoading: array[0..5] of Word;
  g_ShopList: array[0..5] of TList;
  g_ShopGoldList: array[0..5] of TList;
  g_ShopBuyItem: pTShopItem;
  g_MySelf: THumActor;
  g_MyDrawActor: THumActor; //未用
  g_UseItems: TClientUserItems;
  g_ItemArr: TClientBagitems;
  g_TempItemArr: TClientBagitems;
  g_StorageArr: array[0..4, 0..MAXSTORAGEITEMS - 1] of TNewClientItem;
  g_StorageArrList: array[0..4] of TList;
  g_boStorageOpen: array[0..4] of Boolean;
  g_dwStorageTime: array[0..4] of TDateTime;
  g_boStorageRead: array[0..4] of Boolean;
  g_nStorageGold: Integer;
  g_Selectitem: TNewClientItem;
  g_SendSelectItem: TNewClientItem;
  g_RemoveStoneItem: TNewClientItem;
  g_SendRemoveStoneItem: TNewClientItem;

  g_CboMagicList: TCboMagicListInfo;
  g_CboMagicID: Integer;
  g_CboUserID: Integer;

  g_ArmStrengthenArr: TArmStrengthenArr;
  g_MakeItemArr: TArmStrengthenArr;
  g_MakeGoods: TClientMakeGoods;

  g_NonceBagCount: Integer = MAXBAGITEMS;

  //  g_GetSayItemList: TList;

  g_boServerChanging: Boolean;

  //键盘相关
  g_ToolMenuHook: HHOOK;
  g_nLastHookKey: Integer;
  g_dwLastHookKeyTime: LongWord;

  g_WgHintList: TStringList;

  g_nCaptureSerial: Integer; //抓图文件名序号
  g_nSendCount: Integer; //发送操作计数
  g_nReceiveCount: Integer; //接改操作状态计数
  g_nTestSendCount: Integer;
  g_nTestReceiveCount: Integer;
  g_nSpellCount: Integer; //使用魔法计数
  g_nSpellFailCount: Integer; //使用魔法失败计数
  g_nFireCount: Integer; //
  g_nDebugCount: Integer;
  g_nDebugCount1: Integer;
  g_nDebugCount2: Integer;

  //买卖相关
  //g_SellDlgItem: TMovingItem;
  g_SellDlgItemSellWait: TMovingItem;
  g_DealDlgItem: TMovingItem;
  //g_boQueryPrice: Boolean;
  //g_dwQueryPriceTime: LongWord;
  //g_sSellPriceStr: string;

  //交易相关
  g_DealItems: array[0..MAXDEALITEMCOUNT - 1] of TNewClientItem;
  g_DealRemoteItems: array[0..MAXDEALITEMCOUNT - 1] of TNewClientItem;
  g_nDealGold: Integer;
  g_nDealRemoteGold: Integer;
  g_boDealEnd: Boolean;
  g_boDealLock: Boolean;
  g_sDealWho: string; //交易对方名字

  g_AddBagItems: array[0..MAXAPPENDBAGITEMS - 1] of TNewClientItem;
  g_AddBagInfo: array[0..3] of TAddBagInfo;

  g_MyShopSellItems: array[0..MAXSHOPITEMS - 1] of TMyShopItem;
  g_MyShopBuyItems: array[0..MAXSHOPITEMS - 1] of TMyShopItem;
  g_MyReadShopSellItems: array[0..MAXSHOPITEMS - 1] of TMyShopItem;
  g_MyReadShopBuyItems: array[0..MAXSHOPITEMS - 1] of TMyShopItem;
  g_MyShopItem: TMovingItem;
  g_MyReadTitle: string;
  g_MyShopTitle: string[24];
  g_MyShopGold: Integer;
  g_MyShopGameGold: Integer;

  g_nMyReadShopDlgID: Integer;
  g_nMyReadShopDlgX: Integer;
  g_nMyReadShopDlgY: Integer; //皋春甫 罐篮 镑
  //g_MouseItem: TClientItem;
  //g_MouseStateItem: TClientItem;
  //g_MouseUserStateItem: TClientItem; //泅犁 付快胶啊 啊府虐绊 乐绰 酒捞袍

  g_boItemMoving: Boolean; //正在移动物品
  g_MovingItem: TMovingItem;
  g_WaitingUseItem: TMovingItem;
  g_UniteUseItem: TMovingItem;
  g_EatingItem: TMovingItem;
  g_MoveAddBagItem: TMovingItem;

  g_FocusItem: pTDropItem;

  g_tempTime: LongWord = 0;

  g_SayUpDownLock: Boolean = False;

  g_EMailList: TQuickStringPointerList;
  g_SendEMailItem: TMovingItem;

  g_SayShowType: TUserSayType = us_All;
  g_SayShowCustom: TUserSaySet = [us_Hear, us_Whisper, us_Cry, us_Group, us_Guild, us_Sys];
  g_SayEffectIndex: array[TUserSayType] of Boolean;

  g_SayMode: TUserSayMode;

  //g_boViewFog: Boolean = False; //是否显示黑暗
  //g_boForceNotViewFog: Boolean = True; //免蜡烛
  //g_nDayBright: Integer;
  g_nAreaStateValue: Integer; //显示当前所在地图状态(攻城区域、)

  //g_boNoDarkness: Boolean;
  //g_nRunReadyCount: Integer; //助跑就绪次数，在跑前必须走几步助跑


  g_dwEatTime: LongWord = 0; //timeout...
  g_dwEatTick: LongWord = 0; //使用药品时间间隔
  g_dwDizzyDelayStart: LongWord;
  g_dwDizzyDelayTime: LongWord;

  g_boDoFadeOut: Boolean;
  g_boDoFadeIn: Boolean;
  g_nFadeIndex: Integer;
  g_boDoFastFadeOut: Boolean;
  g_nDander: Word;

  g_boAutoDig: Boolean; //自动锄矿
  g_boSelectMyself: Boolean; //鼠标是否指到自己

  //游戏速度检测相关变量
  g_dwFirstServerTime: LongWord;
  g_dwFirstClientTime: LongWord;
  //ServerTimeGap: int64;
  g_nTimeFakeDetectCount: Integer;
  g_dwSHGetTime: LongWord;
  g_dwSHTimerTime: LongWord;
  g_nSHFakeCount: Integer;

  //检查机器速度异常次数，如果超过4次则提示速度不稳定

  //g_nDelMoveTime: LongWord;
  g_dwLatestClientTime2: LongWord;
  g_dwFirstClientTimerTime: LongWord; //timer 矫埃
  g_dwLatestClientTimerTime: LongWord;
  g_dwFirstClientGetTime: LongWord; //gettickcount 矫埃
  g_dwLatestClientGetTime: LongWord;
  g_nTimeFakeDetectSum: Integer;
  g_nTimeFakeDetectTimer: Integer;

  g_dwLastestClientGetTime: LongWord;

  //外挂功能变量开始
  g_DeathColorEffect: TColorEffect = ceGrayScale;

  g_boCanStartRun: Boolean = True; //是否允许免助跑

  g_MagicLockActor: TActor;
  g_boNextTimePowerHit: Boolean;
  g_boCanLongHit: Boolean;
  g_boCanWideHit: Boolean;
  g_boCanCrsHit: Boolean;
  g_boCanTwnHit: Boolean; //重击开天斩
  g_boCanStnHit: Boolean;
  g_boCan110Hit: Boolean;
  g_boCan111Hit: Boolean;
  g_boCan112Hit: Boolean;
  g_boCan113Hit: Boolean;
  g_boCan122Hit: Boolean;
  g_boCan56Hit: Boolean;
  g_boNextTimeFireHit: Boolean;
  g_boCanLongIceHit: Boolean;
  g_boLongIceHitIsLong: Boolean;

  g_boDrawTileMap: Boolean = True;
  g_boDrawDropItem: Boolean = True;
  g_QuestMsgList: TList;
  g_MasterHDInfoList: TList;

  g_nTestX: Integer = 71;
  g_nTestY: Integer = 212;

  g_boShowRollBarHint: Boolean = True;

  g_ColorTable: TRGBQuads;

  g_DefClientItemFiltrate: TClientItemFiltrate = (
    boShow: True;
    boPickUp: True;
    boColor: False;
    boHint: False;
    boChange: False;
    );

   g_CompoundSet: TCompoundSet;
   g_AbilityMoveSet: TAbilityMoveSet;

function GetBagItemCount(nIndex: Integer): Integer;
function GetBagItemImg(nIndex: Integer): TDirectDrawSurface; overload;
function GetBagItemImg(nIndex: Integer; var ax, ay: Integer): TDirectDrawSurface; overload;
function GetBagItemIndex(nIndex: Integer): Integer;
function GetBagItemImgXY(nIndex: Integer; var ax, ay: Integer):
  TDirectDrawSurface;
function GetStateItemImg(nIndex: Integer): TDirectDrawSurface;
function GetStateItemImgXY(nIndex: Integer; var ax, ay: Integer):
  TDirectDrawSurface;
//function GetHairImg(nHair: Integer): TDirectDrawSurface;
//function GetHairImgXY(nHair: Integer; var ax, ay: Integer): TDirectDrawSurface;
function GetDnItemImg(nIndex: Integer): TDirectDrawSurface;
function GetWHumImg(Dress, m_btSex, nFrame: Integer; var ax, ay: Integer): TDirectDrawSurface;
function GetWWeaponImg(Weapon, m_btSex, nFrame: Integer; var ax, ay: Integer): TDirectDrawSurface;
function GetWHumWinImage(nEffectIdx: Integer; var ax, ay: Integer): TDirectDrawSurface;
function GetWcboHumImg(Dress, nFrame: Integer; var ax, ay: Integer): TDirectDrawSurface;
function GetWcboHumEffectImg(Effect, nFrame: Integer; var ax, ay: Integer): TDirectDrawSurface;
function GetWcboWeaponImg(Weapon, nFrame: Integer; var ax, ay: Integer): TDirectDrawSurface;

function GetNpcImg(wAppr: Integer; var ax, ay: Integer): TDirectDrawSurface;
function GetObjs(nUnit, nIdx: Integer): TDirectDrawSurface;
function GetObjsEx(nUnit, nIdx: Integer; var px, py: Integer): TDirectDrawSurface;
function GetMonImg(nAppr: Integer): TWMImages;
function GetJobName(nJob: Integer): string;
function GetsexName(sex: Integer): string;
function GetGuildJobName(rank: Integer): string;
function GetWuXinName(WuXin: Integer): string;
function GetWuXinColor(WuXin: Integer): TColor;

function FindPath(StartX, StartY, StopX, StopY: Integer): TPath; overload;
function FindPath(StopX, StopY: Integer): TPath; overload;
procedure DynArrayDelete(var A; elSize: Longint; index, Count: Integer);
procedure LoadMagicList(MemoryStream: TMemoryStream);
function GetMagicInfo(wMagID: Word): TClientDefMagic;
//procedure ClearMagicList();
procedure LoadStditemList(MemoryStream: TMemoryStream);
//procedure RefStditemList;
procedure ClearStditemList();
procedure DisopseDropItem(DropItem: pTDropItem; pickup: Integer);
procedure LoadMapDescList(const StringList: TStringList);
procedure ClearMapDescList();
function GetMapDescList(sMapName: string): pTMapDescList;

procedure LoadMapEffectList();
procedure ClearMapEffectList();
function GetMapEffectList(sMapName: string): TList;

procedure LoadShopHintList();
function GetShopHintList(ItemName: string): string;
//procedure ClearMsgDlgList();

procedure ClearGroupMember(boHint: Boolean = False; Hint: Boolean = False);

//function GetStdItemWuXin(nIndex: Integer): Integer;
function GetStditem(nIndex: Integer): TStdItem;
function GetStditemByName(sName: string): TStdItem;
function GetPStditem(sName: string): pTStdItem;
function GetClientStditem(nIndex: Integer): pTClientStditem;
function GetStditemLook(nIndex: Integer): Integer;
function GetStditemDesc(nIndex: Integer): string;
function GetStditemFiltrate(sName: string): pTClientItemFiltrate;
procedure SetStditemFiltrate(sName: string; Filtrate: pTClientItemFiltrate);
procedure DrawWindow(dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface);
//procedure ClearGetSayItemList();
//
//function GetLineVariableText(sMsg: string): string;
function LoadImageFileToSurface(FileName: string; var HDInfoSurface: TDXImageTexture): Byte;
//function MakeSaveUserPhoto(HDInfoDib: TDib; SaveBuff: PChar): Integer;
//function MakeLoadUserPhoto(HDInfoDib: TDib; LoadBuff: PChar): Boolean;
function CheckFilePath(sFilePath: String): string;
function CheckFileNameLen(sOldName: string; var boChange: Boolean): string;
function GetHDInfoImage(HDType: THDInfoType): Integer;
procedure ClearEMailInfo();
procedure LoadMasterHDInfo();
procedure ClearMasterHDInfo(List: TList);
function InFriendList(sName: string): Boolean;
procedure CopyStrToClipboard(sStr: string);
function InGroupList(sName: string): Boolean;
procedure DeleteEMailByIndex(nIndex: Integer);
//function GetItemShowName(Item: TNewClientItem): string;
function ShowItemInfo(Item: TNewClientItem; MoveItemState: TMoveItemState; btNum: array of Integer): string;
function ShowMagicInfo(PMagic: pTNewClientMagic): string;
//function GetNeedStr(var sMsg: string; Item: pTNewClientItem {; boHero: Boolean}): Boolean;
function GetNeedStr(Item: pTNewClientItem; AddStr: string = ''): String;
function GetItemNeedStr(Item: pTNewClientItem): String;
function GetNeedStrEx(var sNeedStr: string; Item: pTNewClientItem): Boolean;
//function CheckItemsInDlg(MoveItemDlg: TMoveItemDlg; MoveItemType: TMoveItemType): Boolean;
function DlgShowText(DSurface: TDirectDrawSurface; X, Y: Integer; Points, DrawList: TList; Msg: string;
  nMaxHeight: Integer; DefaultColor: TColor = {$IF Var_Interface = Var_Mir2}clWhite{$ELSE}clSilver{$IFEND}): integer;

function AddSellItemToMyShop(cu: TMyShopItem; nIdx: Integer = -1): Boolean;

function GetMapDirAndName(sFileName: string): string;
function ZIPCompress(const InBuf: Pointer; InBytes: Integer; Level: TZIPLevel; out OutBuf: PChar): Integer;
function ZIPDecompress(const InBuf: Pointer; InBytes: Integer; OutEstimate: Integer; out OutBuf: PChar): Integer;
function GetSpellPoint(Magic: pTNewClientMagic): Integer;

function HorseItemToClientItem(HorseItem: pTHorseItem): TNewClientItem;
function CheckItemBindMode(UserItem: pTUserItem; BindMode: TBindMode): Boolean;

procedure SetMagicUse(nMagId: Word);
function GetMagIDByKey(nKey: Integer): Integer;

function GetCompoundInfos(const sItemName: string): pTCompoundInfos;

{ function DlgShowText(DSurface: TDirectDrawSurface; Msg,
 SelectStr: string; X, Y: Integer; Points: TList; var AddPoints: Boolean;
 MoveStr: string; MoveRC: TRect): integer;}

implementation

uses FState, ClMain, Math, HUtil32, EDcodeEx, ClFunc, Clipbrd, Registry, jpeg, GIFImg, MNShare, FState3, FState4;

//const
  //WuXinStr: array[1..5] of string = ('[金]', '[木]', '[水]', '[火]', '[土]');

procedure SetMagicUse(nMagId: Word);
begin
  if (nMagId > 0) and (nMagId < SKILL_MAX) then begin
    g_MyMagicArry[nMagId].dwInterval := GetTickCount + g_MyMagicArry[nMagId].Def.Magic.nInterval;
    g_MyMagicArry[nMagId].boUse := True;
    g_MyMagicArry[nMagId].btEffidx := 0;
    g_MyMagicArry[nMagId].dwTime := GetTickCount + 100;
  end;
end;

function GetMagIDByKey(nKey: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(g_MyMagicArry) to High(g_MyMagicArry) do begin
    if g_MyMagicArry[I].boStudy and (g_MyMagicArry[I].btKey = nKey) then begin
      Result := I;
      Break;
    end;
  end;
end;

function GetMapDirAndName(sFileName: string): string;
begin
  if FileExists(MAPDIRNAME + sFileName + '.map') then Result := MAPDIRNAME + sFileName + '.map'
  else Result := OLDMAPDIRNAME + sFileName + '.map';
end;

procedure DrawWindow(dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface);
begin
  dsuf.Draw(x, y, ssuf.ClientRect, ssuf, True);
  //DrawAlphaWin(dsuf, x, y, ssuf, 0, 0, ssuf.Width, ssuf.Height);
end;

function AddSellItemToMyShop(cu: TMyShopItem; nIdx: Integer = -1): Boolean;
var
  idx: integer;
begin
  Result := False;
  if (nIdx in [Low(g_MyShopSellItems)..High(g_MyShopSellItems)]) and (g_MyShopSellItems[nIdx].ShopItem.Item.s.Name = '')
  then begin
    g_MyShopSellItems[nIdx] := cu;
  end else begin
    for idx := Low(g_MyShopSellItems) to High(g_MyShopSellItems) do begin
      if g_MyShopSellItems[idx].ShopItem.Item.s.Name = '' then
        g_MyShopSellItems[idx] := cu;
    end;
  end;
end;

procedure DisopseDropItem(DropItem: pTDropItem; pickup: Integer);
begin
  //if pickup = 0 then begin
  {if DropItem.d <> nil then
    DropItem.d.Free;
  DropItem.d := nil;   }
  Dispose(DropItem);
  {end
  else begin
    DropItem.m_dwDeleteTime := GetTickCount;
    g_FreeItemList.Add(DropItem);
  end; }
end;
{
procedure ClearGetSayItemList();
var
  i: integer;
begin
  for I := 0 to g_GetSayItemList.Count - 1 do begin
    Dispose(pTNewClientItem(g_GetSayItemList[i]));
  end;
  g_GetSayItemList.Clear;
end;  }

function GetBagItemCount(nIndex: Integer): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Low(g_ItemArr) to High(g_ItemArr) do begin
    if (g_ItemArr[i].s.Name <> '') and
      (g_ItemArr[i].s.Idx = nIndex) then begin
      if (sm_Superposition in g_ItemArr[i].s.StdModeEx) and (g_ItemArr[i].s.DuraMax > 1) then
        Inc(Result, g_ItemArr[i].UserItem.Dura)
      else
        Inc(Result);
    end;
  end;
end;

function GetBagItemImg(nIndex: Integer; var ax, ay: Integer): TDirectDrawSurface;
var
  nUnit, nItemIndex: Integer;
begin
  Result := nil;
  nUnit := nIndex div 10000;
  nItemIndex := nIndex mod 10000;
  if (nUnit >= 0) and (nUnit <= ITEMCOUNT) then begin
    Result := g_WBagItems[nUnit].GetCachedImage(nItemIndex, ax, ay);
  end;
end;

function GetBagItemImg(nIndex: Integer): TDirectDrawSurface;
var
  nUnit, nItemIndex: Integer;
begin
  Result := nil;
  nUnit := nIndex div 10000;
  nItemIndex := nIndex mod 10000;
  if (nUnit >= 0) and (nUnit <= ITEMCOUNT) then begin
    Result := g_WBagItems[nUnit].Images[nItemIndex];
  end;
end;

function GetBagItemIndex(nIndex: Integer): Integer;
var
  nUnit: Integer;
begin
  Result := -1;
  nUnit := nIndex div 10000;
  if (nUnit >= 0) and (nUnit <= ITEMCOUNT) then begin
    Result := Images_ItemsBegin + nUnit;
  end;
end;

function GetBagItemImgXY(nIndex: Integer; var ax, ay: Integer): TDirectDrawSurface;
var
  nUnit, nItemIndex: Integer;
begin
  Result := nil;
  nUnit := nIndex div 10000;
  nItemIndex := nIndex mod 10000;
  if (nUnit >= 0) and (nUnit <= ITEMCOUNT) then begin
    Result := g_WBagItems[nUnit].GetCachedImage(nItemIndex, ax, ay);
  end;
end;

function GetStateItemImg(nIndex: Integer): TDirectDrawSurface;
var
  nUnit, nItemIndex: Integer;
begin
  Result := nil;
  nUnit := nIndex div 10000;
  nItemIndex := nIndex mod 10000;
  if (nUnit >= 0) and (nUnit <= ITEMCOUNT) then begin
    Result := g_WStateItems[nUnit].Images[nItemIndex];
  end;
end;

function GetStateItemImgXY(nIndex: Integer; var ax, ay: Integer): TDirectDrawSurface;
var
  nUnit, nItemIndex: Integer;
begin
  Result := nil;
  nUnit := nIndex div 10000;
  nItemIndex := nIndex mod 10000;
  if (nUnit >= 0) and (nUnit <= ITEMCOUNT) then begin
    Result := g_WStateItems[nUnit].GetCachedImage(nItemIndex, ax, ay);
  end;
end;
{
function GetHairImg(nHair: Integer): TDirectDrawSurface;
var
  nUnit, nIndex: Integer;
begin
  Result := nil;
  nUnit := nHair div 24000;
  nIndex := nHair mod 24000;
  if (nUnit >= 0) and (nUnit <= HAIRCOUNT) then begin
    Result := g_WHairs[nUnit].Images[nIndex];
  end;
end;

function GetHairImgXY(nHair: Integer; var ax, ay: Integer): TDirectDrawSurface;
var
  nUnit, nIndex: Integer;
begin
  Result := nil;
  nUnit := nHair div 24000;
  nIndex := nHair mod 24000;
  if (nUnit >= 0) and (nUnit <= HAIRCOUNT) then begin
    Result := g_WHairs[nUnit].GetCachedImage(nIndex, ax, ay);
  end;
end;    }

function GetDnItemImg(nIndex: Integer): TDirectDrawSurface;
var
  nUnit, nItemIndex: Integer;
begin
  Result := nil;
  nUnit := nIndex div 10000;
  nItemIndex := nIndex mod 10000;
  if (nUnit >= 0) and (nUnit <= ITEMCOUNT) then begin
    Result := g_WDnItems[nUnit].Images[nItemIndex];
  end;
end;

//取衣服图库

function GetWHumImg(Dress, m_btSex, nFrame: Integer; var ax, ay: Integer): TDirectDrawSurface;
var
  FileIdx, ImageIdx: Integer;
begin
  if Dress < 24 then begin
    FileIdx := 0;
    ImageIdx := Dress; {0 - 23}
  end
  else if Dress < 48 then begin
    FileIdx := 1;
    ImageIdx := Dress - 24; {24 - 49}
  end
  else if Dress < 200 then begin
    FileIdx := 2;
    ImageIdx := Dress - 48; {24 - 49}
  end
  else begin
    FileIdx := 3;
    ImageIdx := Dress - 200; {110 - 127}
  end;
  Result := g_WHums[FileIdx].GetCachedImage(HUMANFRAME * ImageIdx + nFrame, ax, ay);
end;

//取武器图库

function GetWWeaponImg(Weapon, m_btSex, nFrame: Integer; var ax, ay:
  Integer): TDirectDrawSurface;
var
  FileIdx, ImageIdx: Integer;
begin
  if Weapon < 76 then begin
    FileIdx := 0;
    ImageIdx := Weapon; {0 - 39}
  end
  else if Weapon < 118 then begin
    FileIdx := 1;
    ImageIdx := Weapon - 76; {40 - 79}
  end
  else if Weapon < 200 then begin
    FileIdx := 2;
    ImageIdx := Weapon - 118; {40 - 79}
  end
  else begin
    FileIdx := 3;
    ImageIdx := Weapon - 200; {110 - 127}
  end;
  Result := g_WWeapons[FileIdx].GetCachedImage(HUMANFRAME * ImageIdx + nFrame, ax, ay);
end;

function GetWHumWinImage(nEffectIdx: Integer; var ax, ay: Integer): TDirectDrawSurface;
var
  FileIdx: Integer;
begin
  if nEffectIdx > 119399 then begin
    Dec(nEffectIdx, 119400);
    Result := g_WMyHumEffect.GetCachedImage(nEffectIdx, ax, ay);
  end else begin
    if nEffectIdx > 26399 then begin
      FileIdx := 2;
      Dec(nEffectIdx, 26400);
    end
    else if nEffectIdx > 11999 then begin
      FileIdx := 1;
      Dec(nEffectIdx, 12000);
    end
    else FileIdx := 0;
    Result := g_WHumEffects[FileIdx].GetCachedImage(nEffectIdx, ax, ay);
  end;
end;

function GetWcboHumImg(Dress, nFrame: Integer; var ax, ay: Integer): TDirectDrawSurface;
begin
  if Dress < 48 then begin
    Result := g_WcboHumImages.GetCachedImage(HUMCBOANFRAME * Dress + nFrame, ax, ay);
  end
  else begin
    Result := g_WcboHum2Images.GetCachedImage(HUMCBOANFRAME * (Dress - 48) + nFrame, ax, ay);
  end;
end;

function GetWcboHumEffectImg(Effect, nFrame: Integer; var ax, ay: Integer): TDirectDrawSurface;
begin
  if Effect < 28 then begin
    Result := g_WcboHumEffectImages.GetCachedImage(HUMCBOANFRAME * Effect + nFrame, ax, ay);
  end
  else begin
    Result := g_WcboHumEffect2Images.GetCachedImage(HUMCBOANFRAME * (Effect - 28) + nFrame, ax, ay);
  end;
end;

function GetWcboWeaponImg(Weapon, nFrame: Integer; var ax, ay: Integer): TDirectDrawSurface;
begin
  if Weapon < 118 then begin
    Result := g_WcboWeaponImages.GetCachedImage(HUMCBOANFRAME * Weapon + nFrame, ax, ay);
  end
  else begin
    Result := g_WcboWeapon2Images.GetCachedImage(HUMCBOANFRAME * (Weapon - 118) + nFrame, ax, ay);
  end;
end;

//取NPC图库

function GetNpcImg(wAppr: Integer; var ax, ay: Integer): TDirectDrawSurface;
var
  nUnit: Integer;
  nIdx: Integer;
begin
  Result := nil;
  nUnit := wAppr div 30000;
  nIdx := wAppr mod 30000;
  if (nUnit >= 0) and (nUnit <= NPCSCOUNT) then begin
    if nIdx > 9999 then Result := g_WNpc2.GetCachedImage(nIdx - 10000, ax, ay)
    else Result := g_WNpcs[nUnit].GetCachedImage(nIdx, ax, ay);
  end;
end;

//取地图图库

function GetObjs(nUnit, nIdx: Integer): TDirectDrawSurface;
begin
  Result := nil;
  if (nUnit >= 0) and (nUnit <= OBJECTSCOUNT) then begin
    Result := g_WObjects[nUnit].Images[nIdx];
  end;
end;

//取地图图库

function GetObjsEx(nUnit, nIdx: Integer; var px, py: Integer): TDirectDrawSurface;
begin
  Result := nil;
  if (nUnit >= 0) and (nUnit <= OBJECTSCOUNT) then begin
    Result := g_WObjects[nUnit].GetCachedImage(nIdx, px, py);
  end;
end;

//取怪物图库

function GetMonImg(nAppr: Integer): TWMImages;
var
  nUnit: Integer;
begin
  Result := g_WMons[1];
  nUnit := nAppr div 10 + 1;
  if nUnit in [111..151] then begin
    Result := g_WRideImages;  
  end else
  if nUnit = 81 then begin
    if ((nAppr mod 10) in [0..2]) then Result := g_WDragonImages
    else if ((nAppr mod 10) = 8) then Result := g_WNpcs[1]
    else Result := g_WNpcs[0];
  end
  else
  if nUnit = 82 then begin
    Result := g_WKuLouImages;
  end else
  if nUnit = 91 then begin
    if (nAppr mod 10) in [0..3] then Result := g_WEffectImages
    else Result := g_WMons[34];
  end
  else if (nUnit > 0) and (nUnit <= MONSCOUNT) then begin
    Result := g_WMons[nUnit];
  end;                                      
end;

function GetWuXinColor(WuXin: Integer): TColor;
begin
  Result := clWhite;
  case WuXin of
    1: Result := $FFFF;
    2: Result := $29CB29;
    3: Result := $FF7D63;
    4: Result := $FF;
    5: Result := $848284;
  end;

end;

function GetWuXinName(WuXin: Integer): string;
begin
  Result := '';
  case WuXin of
    1: Result := g_sWuXinJ;
    2: Result := g_sWuXinM;
    3: Result := g_sWuXinS;
    4: Result := g_sWuXinH;
    5: Result := g_sWuXinT;
  end;
end;

//取得职业名称
//0 武士
//1 魔法师
//2 道士

function GetJobName(nJob: Integer): string;
begin
  Result := '';
  case nJob of
    0: Result := g_sWarriorName;
    1: Result := g_sWizardName;
    2: Result := g_sTaoistName;
  else begin
      Result := g_sUnKnowName;
    end;
  end;
end;

function GetSexName(sex: Integer): string;
begin
  if sex = 0 then
    Result := '男'
  else
    Result := '女';
end;

function GetGuildJobName(rank: Integer): string;
begin
  case rank of
    1: Result := '掌门';
    2..3: Result := '副掌门';
    4..20: Result := '护法';
    21..40: Result := '长老';
    41..60: Result := '堂主';
    61..80: Result := '香主';
  else
    Result := '精英';
  end;
end;

function FindPath(StartX, StartY, StopX, StopY: Integer): TPath;
begin
  Result := nil;
  {if g_LegendMap = nil then begin
    g_LegendMap := TLegendMap.Create;
    if not g_LegendMap.LoadMap(Map.m_sFileName) then begin
      g_LegendMap.Free;
      g_LegendMap := nil;
      exit;
    end;
  end;    }
  Result := g_LegendMap.FindPath(StartX, StartY, StopX, StopY, 0);
  if High(Result) < 2 then begin
    Result := nil
  end;
end;

function FindPath(StopX, StopY: Integer): TPath;
begin
  Result := nil;
  {if g_LegendMap = nil then begin
    g_LegendMap := TLegendMap.Create;
    if not g_LegendMap.LoadMap(Map.m_sFileName) then begin
      g_LegendMap.Free;
      g_LegendMap := nil;
      exit;
    end;
  end;   }
  Result := g_LegendMap.FindPath(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, StopX, StopY, 0);
  if High(Result) < 2 then begin
    Result := nil
  end;
end;
{
procedure ClearMsgDlgList();
var
  i: integer;
begin
  for I := 0 to g_ShowMsgDlgList.Count - 1 do begin
    Dispose(pTMessageDlg(g_ShowMsgDlgList[i]));
  end;
  g_ShowMsgDlgList.Clear;
end;    }

function GetMapDescList(sMapName: string): pTMapDescList;
var
  i: integer;
  MapDescList: pTMapDescList;
begin
  Result := nil;
  for i := 0 to g_MapDescList.Count - 1 do begin
    MapDescList := g_MapDescList[i];
    if MapDescList.sMapName = sMapname then begin
      Result := MapDescList;
      break;
    end;
  end;
end;

procedure ClearMapDescList();
var
  i, ii: integer;
  MapDescList: pTMapDescList;
begin
  for i := 0 to g_MapDescList.Count - 1 do begin
    MapDescList := g_MapDescList[i];
    for ii := 0 to MapDescList.MaxList.Count - 1 do
      Dispose(pTMapDesc(MapDescList.MaxList[ii]));
    for ii := 0 to MapDescList.MinList.Count - 1 do
      Dispose(pTMapDesc(MapDescList.MinList[ii]));
    MapDescList.MaxList.Free;
    MapDescList.MinList.Free;
    Dispose(MapDescList);
  end;
  g_MapDescList.Clear;
end;

function GetShopHintList(ItemName: string): string;
var
  str: string;
  i: integer;
begin
  Result := '';
  ItemName := ItemName + '=';
  for I := 0 to g_ShopHintList.Count - 1 do begin
    str := g_ShopHintList[i];
    if CompareLStr(str, ItemName, Length(Itemname)) then begin
      Result := GetValidStr3(str, ItemName, ['=']);
      break;
    end;
  end;
end;

procedure LoadShopHintList();
var
  StringList: TStringList;
  str: string;
  i: integer;
  MemoryStream: TMemoryStream;
begin
  g_ShopHintList.Clear;
  MemoryStream := g_WSettingImages.GetDataStream(SHOPHINTFILE, dtData);
  if MemoryStream <> nil then begin
    StringList := TStringList.Create;
    StringList.LoadFromStream(MemoryStream);
    for I := 0 to StringList.Count - 1 do begin
      str := DecodeString(StringList[i]);
      if str <> '' then
        g_ShopHintList.Add(str);
    end;
    StringList.Free;
    MemoryStream.Free;
  end;

end;

procedure LoadMapDescList(const StringList: TStringList);
  procedure AddMapDescToList(sMapName: string; MapDesc: pTMapDesc; boMax: Boolean);
  var
    i: integer;
    MapDescList: pTMapDescList;
  begin
    for I := g_MapDescList.Count - 1 downto 0 do begin
      MapDescList := g_MapDescList[i];
      if MapDescList.sMapName = sMapName then begin
        if boMax then
          MapDescList.MaxList.Add(MapDesc)
        else
          MapDescList.MinList.Add(MapDesc);
        exit;
      end;
    end;
    New(MapDescList);
    MapDescList.sMapName := sMapName;
    MapDescList.MaxList := TList.Create;
    MapDescList.MinList := TList.Create;
    if boMax then
      MapDescList.MaxList.Add(MapDesc)
    else
      MapDescList.MinList.Add(MapDesc);
    g_MapDescList.Add(MapDescList);
  end;
var
  //StringList: TStringList;
  i: integer;
  str: string;
  MapDesc: pTMapDesc;
  sMapName, sx, sy, sName, sColor, sMax: string;
//  MemoryStream: TMemoryStream;
begin
  ClearMapDescList();
  //MemoryStream := g_WSettingImages.GetDataStream(MAPDESCFILE, dtData);
  //if MemoryStream <> nil then begin
   // StringList := TStringList.Create;
   // StringList.LoadFromStream(MemoryStream);
  for I := 0 to StringList.Count - 1 do begin
    str := stringlist[i];
    if (str <> '') and (str[1] <> ';') then begin
      str := GetValidStr3(str, sMapName, [' ', #9, ',']);
      str := GetValidStr3(str, sx, [' ', #9, ',']);
      str := GetValidStr3(str, sy, [' ', #9, ',']);
      str := GetValidStr3(str, sName, [' ', #9, ',']);
      str := GetValidStr3(str, sColor, [' ', #9, ',']);
      str := GetValidStr3(str, sMax, [' ', #9, ',']);
      if (sMax <> '') then begin
        New(MapDesc);
        MapDesc.sName := sName;
        MapDesc.nX := StrToIntDef(sX, -1);
        MapDesc.nY := StrToIntDef(sY, -1);
        MapDesc.nColor := StrToIntDef(sColor, 0);
        AddMapDescToList(sMapName, MapDesc, (sMax = '0'));
      end;
    end;
  end;
   // StringList.Free;
   // MemoryStream.Free;
  //end;
end;

procedure LoadMapEffectList();
  procedure AddMapEffectToList(sMapName: string; MapEffect: pTClientMapEffect);
  var
    i: integer;
    List: TList;
  begin
    for I := g_MapEffectList.Count - 1 downto 0 do begin
      if CompareText(sMapName, g_MapEffectList[i]) = 0 then begin
        TList(g_MapEffectList.Objects[i]).Add(MapEffect);
        exit;
      end;
    end;
    List := TList.Create;
    List.Add(MapEffect);
    g_MapEffectList.AddObject(sMapName, TObject(List));
  end;
var
  StringList: TStringList;
  i: integer;
  str: string;
  MapEffect: pTClientMapEffect;
  sMapName, sx, sy, sType: string;
  MemoryStream: TMemoryStream;
begin
  ClearMapEffectList();
  MemoryStream := g_WSettingImages.GetDataStream(MAPEFFECTFILE, dtData);
  if MemoryStream <> nil then begin
    StringList := TStringList.Create;
    StringList.LoadFromStream(MemoryStream);
    for I := 0 to StringList.Count - 1 do begin
      str := stringlist[i];
      if (str <> '') and (str[1] <> ';') then begin
        str := GetValidStr3(str, sMapName, [' ', #9, ',']);
        str := GetValidStr3(str, sx, [' ', #9, ',']);
        str := GetValidStr3(str, sy, [' ', #9, ',']);
        str := GetValidStr3(str, sType, [' ', #9, ',']);
        if str <> '' then begin
          New(MapEffect);
          MapEffect.wX := StrToIntDef(sX, -1);
          MapEffect.wY := StrToIntDef(sy, -1);
          MapEffect.btType := StrToIntDef(sType, 0);
          MapEffect.sName := str;
          AddMapEffectToList(sMapName, MapEffect);
        end;
      end;
    end;
    StringList.Free;
    MemoryStream.Free;
  end;
end;

procedure ClearMapEffectList();
var
  i, ii: Integer;
  List: TList;
begin
  for I := 0 to g_MapEffectList.Count - 1 do begin
    List := TList(g_MapEffectList.Objects[i]);
    for ii := 0 to List.Count - 1 do
      Dispose(pTClientMapEffect(List[ii]));
    List.Free;
  end;
  g_MapEffectList.Clear;
end;

function GetMapEffectList(sMapName: string): TList;
var
  i: Integer;
begin
  Result := nil;
  for I := 0 to g_MapEffectList.Count - 1 do begin
    if CompareText(sMapName, g_MapEffectList[i]) = 0 then begin
      Result := TList(g_MapEffectList.Objects[i]);
    end;
  end;
end;

function GetMagicInfo(wMagID: Word): TClientDefMagic;
begin
  SafeFillChar(Result, SizeOf(TClientDefMagic), #0);
  if (wMagID > 0) and (wMagID < SKILL_MAX) then
    Result := g_MagicArry[wMagID];
end;

procedure LoadMagicList(MemoryStream: TMemoryStream);
var
  ClientMagic: pTClientDefMagic;
  Buff, StrBuff: PChar;
  ReadLen, StrReadLen: Integer;
  str: string;
  //MemoryStream: TMemoryStream;
begin
  SafeFillChar(g_MagicArry, SizeOf(g_MagicArry), #0);
  {if (g_WSettingImages <> nil) and (g_WSettingImages.boInitialize) then begin
    MemoryStream := g_WSettingImages.GetDataStream(MAGICFILE, dtData);}
  if MemoryStream <> nil then begin
    //try
    MemoryStream.Position := 0;
    ReadLen := GetCodeMsgSize((SizeOf(TClientDefMagic) - 256) * 4 / 3);
    GetMem(Buff, ReadLen + 1);
    SafeFillChar(Buff^, ReadLen + 1, #0);
    New(ClientMagic);
    while MemoryStream.Read(Buff^, ReadLen) = ReadLen do begin
      SafeFillChar(ClientMagic^, SizeOf(TClientDefMagic), #0);
      str := StrPas(Buff);
      DecodeBuffer(str, @ClientMagic^, SizeOf(TClientDefMagic) - 256);
      if Byte(ClientMagic.Magic.MagicMode) > 0 then begin
        StrReadLen := GetCodeMsgSize(Byte(ClientMagic.Magic.MagicMode) * 4 / 3);
        GetMem(StrBuff, StrReadLen + 1);
        SafeFillChar(StrBuff^, StrReadLen + 1, #0);
        if MemoryStream.Read(StrBuff^, StrReadLen) <> StrReadLen then begin
          Dispose(ClientMagic);
          FreeMem(StrBuff);
          Break;
        end;
        str := StrPas(StrBuff);
        ClientMagic.sDesc := DecodeString(str);
        FreeMem(StrBuff);
      end;
      ClientMagic.Magic.MagicMode := GetMagicType(ClientMagic.Magic.wMagicId);
      if (ClientMagic.Magic.wMagicId > 0) and (ClientMagic.Magic.wMagicId < SKILL_MAX) then
        g_MagicArry[ClientMagic.Magic.wMagicId] := ClientMagic^;
      SafeFillChar(Buff^, ReadLen + 1, #0);
    end;
    Dispose(ClientMagic);
    FreeMem(Buff);
    {finally
      MemoryStream.Free;
    end; }
  end;
  //end;
end;
{
procedure RefStditemList;
var
  ClientStdItem: TClientStditem;
  pClientStdItem: pTClientStditem;
  Buff, StrBuff: PChar;
  ReadLen, StrReadLen: Integer;
  str: string;
  MemoryStream: TMemoryStream;
begin
  if (g_WSettingImages <> nil) and (g_WSettingImages.boInitialize) then begin
    MemoryStream := g_WSettingImages.GetDataStream(GOODSFILE, dtData);
    if MemoryStream <> nil then begin
      try
        MemoryStream.Position := 0;
        ReadLen := GetCodeMsgSize((SizeOf(TClientStditem) - 256) * 4 / 3);
        GetMem(Buff, ReadLen + 1);
        SafeFillChar(Buff^, ReadLen + 1, #0);
        while MemoryStream.Read(Buff^, ReadLen) = ReadLen do begin
          SafeFillChar(ClientStdItem, SizeOf(TClientStditem), #0);
          str := StrPas(Buff);
          DecodeBuffer(str, @ClientStditem, SizeOf(TClientStditem) - 256);
          if ClientStditem.StdItem.NeedIdentify > 0 then begin
            StrReadLen := GetCodeMsgSize(ClientStditem.StdItem.NeedIdentify * 4 / 3);
            GetMem(StrBuff, StrReadLen + 1);
            SafeFillChar(StrBuff^, StrReadLen + 1, #0);
            if MemoryStream.Read(StrBuff^, StrReadLen) <> StrReadLen then begin
              FreeMem(StrBuff);
              Break;
            end;
            str := StrPas(StrBuff);
            ClientStditem.sDesc := DecodeString(str);
            FreeMem(StrBuff);
          end;
          ClientStdItem.StdItem.StdMode := GetItemType(ClientStdItem.StdItem.StdMode2);
          ClientStdItem.StdItem.StdModeEx := GetItemTypeEx(ClientStdItem.StdItem.StdMode);
          if sm_Superposition in ClientStdItem.StdItem.StdModeEx then
            if ClientStdItem.StdItem.DuraMax < 1 then
              ClientStdItem.StdItem.DuraMax := 1;
          ClientStdItem.Filtrate.boChange := False;
          pClientStdItem := GetClientStditem(ClientStdItem.StdItem.Idx + 1);
          if pClientStdItem <> nil then
            pClientStdItem^ := ClientStdItem;
          SafeFillChar(Buff^, ReadLen + 1, #0);
        end;
        FreeMem(Buff);
      finally
        MemoryStream.Free;
      end;
    end;
  end;
end;      }

procedure LoadStditemList(MemoryStream: TMemoryStream);
var
  ClientStdItem: pTClientStditem;
  ClientItemFiltrate: pTClientItemFiltrate;
  Buff, StrBuff: PChar;
  ReadLen, StrReadLen: Integer;
  str: string;

begin
  ClearStditemList();
 // if (g_WSettingImages <> nil) and (g_WSettingImages.boInitialize) then begin
   // MemoryStream := g_WSettingImages.GetDataStream(GOODSFILE, dtData);
  if MemoryStream <> nil then begin
    MemoryStream.Position := 0;
    ReadLen := GetCodeMsgSize((SizeOf(TClientStditem) - 256) * 4 / 3);
    GetMem(Buff, ReadLen + 1);
    SafeFillChar(Buff^, ReadLen + 1, #0);
    while MemoryStream.Read(Buff^, ReadLen) = ReadLen do begin
      New(ClientStdItem);
      SafeFillChar(ClientStdItem^, SizeOf(TClientStditem), #0);
      str := StrPas(Buff);
      DecodeBuffer(str, @ClientStditem^, SizeOf(TClientStditem) - 256);
      if ClientStditem.StdItem.NeedIdentify > 0 then begin
        StrReadLen := GetCodeMsgSize(ClientStditem.StdItem.NeedIdentify * 4 / 3);
        GetMem(StrBuff, StrReadLen + 1);
        SafeFillChar(StrBuff^, StrReadLen + 1, #0);
        if MemoryStream.Read(StrBuff^, StrReadLen) <> StrReadLen then begin
          Dispose(ClientStdItem);
          FreeMem(StrBuff);
          Break;
        end;
        str := StrPas(StrBuff);
        ClientStditem.sDesc := DecodeString(str);
        FreeMem(StrBuff);
      end;
      ClientStdItem.StdItem.StdMode := GetItemType(ClientStdItem.StdItem.StdMode2);
      ClientStdItem.StdItem.StdModeEx := GetItemTypeEx(ClientStdItem.StdItem.StdMode);
      if (sm_Superposition in ClientStdItem.StdItem.StdModeEx) then
        if ClientStdItem.StdItem.DuraMax < 1 then
          ClientStdItem.StdItem.DuraMax := 1;
      ClientStdItem.Filtrate.boChange := False;
      ClientStdItem.StdItem.SetItemList := nil;
      g_StditemList.Add(ClientStdItem);
      New(ClientItemFiltrate);
      ClientItemFiltrate^ := ClientStdItem.Filtrate;
      g_StditemFiltrateList.Add(ClientItemFiltrate);
      SafeFillChar(Buff^, ReadLen + 1, #0);
    end;
    FreeMem(Buff);
  end;
  //end;
end;

procedure ClearStditemList();
var
  I: Integer;
begin
  for I := 0 to g_StditemList.Count - 1 do
    Dispose(pTClientStditem(g_StditemList.Items[i]));
  for I := 0 to g_StditemFiltrateList.Count - 1 do
    Dispose(pTClientItemFiltrate(g_StditemFiltrateList.Items[i]));
  g_StditemList.Clear;
  g_StditemFiltrateList.Clear;
end;


procedure ClearGroupMember(boHint: Boolean; Hint: Boolean);
var
  GroupMember: pTGroupMember;
  i: Integer;
begin
  for i := 0 to g_GroupMembers.Count - 1 do begin
    GroupMember := g_GroupMembers.Items[i];
    Dispose(GroupMember);
  end;
  PlayScene.ClearGroup();
  g_GroupMembers.Clear;
  FrmDlg.SetGroupWnd;
  if boHint then begin
    if Hint then
      DScreen.AddSysMsg('[你的小组已经解散了]', clYellow)
    else
      DScreen.AddSysMsg('[你已经退出小组]', clYellow);
  end;
end;

function GetStditemFiltrate(sName: string): pTClientItemFiltrate;
var
  i: Integer;
  ClientStditem: pTClientStditem;
begin
  Result := @g_DefClientItemFiltrate;
  if sName = '' then
    Exit;
  for i := 0 to g_StditemList.Count - 1 do begin
    ClientStditem := g_StditemList.Items[i];
    if CompareText(ClientStditem.StdItem.Name, sName) = 0 then begin
      Result := @ClientStditem.Filtrate;
      break;
    end;
  end;
end;

procedure SetStditemFiltrate(sName: string; Filtrate: pTClientItemFiltrate);
var
  i: Integer;
  ClientStditem: pTClientStditem;
begin
  for i := 0 to g_StditemList.Count - 1 do begin
    ClientStditem := g_StditemList.Items[i];
    if CompareText(ClientStditem.StdItem.Name, sName) = 0 then begin
      ClientStditem.Filtrate := Filtrate^;
      break;
    end;
  end;
end;

function GetStditem(nIndex: Integer): TStdItem;
begin
  Result.Name := '';
  Dec(nIndex);
  if (nIndex >= 0) and (nIndex < g_StditemList.Count) then
    Result := pTClientStditem(g_StditemList.Items[nIndex]).StdItem;
end;

function GetPStditem(sName: string): pTStdItem;
var
  I: Integer;
begin
  Result := nil;
  if sName <> '' then begin
    for I := 0 to g_StditemList.Count - 1 do begin
      if CompareText(pTClientStditem(g_StditemList.Items[I]).StdItem.Name, sName) = 0 then begin
        Result := @pTClientStditem(g_StditemList.Items[I]).StdItem;
        Break;
      end;
    end;
  end;
end;

function GetStditemByName(sName: string): TStdItem;
var
  I: Integer;
begin
  Result.Name := '';
  if sName <> '' then begin
    for I := 0 to g_StditemList.Count - 1 do begin
      if CompareText(pTClientStditem(g_StditemList.Items[I]).StdItem.Name, sName) = 0 then begin
        Result := pTClientStditem(g_StditemList.Items[I]).StdItem;
        Break;
      end;
    end;
  end;
end;

function GetClientStditem(nIndex: Integer): pTClientStditem;
begin
  Result := nil;
  Dec(nIndex);
  if (nIndex >= 0) and (nIndex < g_StditemList.Count) then
    Result := pTClientStditem(g_StditemList.Items[nIndex]);
end;

function GetStditemLook(nIndex: Integer): Integer;
begin
  Result := -1;
  Dec(nIndex);
  if (nIndex > 0) and (nIndex < g_StditemList.Count) then
    Result := pTClientStditem(g_StditemList.Items[nIndex]).StdItem.Looks;
end;

function GetStditemDesc(nIndex: Integer): string;
begin
  Result := '';
  Dec(nIndex);
  if (nIndex >= 0) and (nIndex < g_StditemList.Count) then
    Result := pTClientStditem(g_StditemList.Items[nIndex]).sDesc;
end;

procedure DynArrayDelete(var A; elSize: Longint; index, Count: Integer);
var
  len, MaxDelete: Integer;

  P: PLongint; //4   个字节的长整形指针
begin
  P := PLongint(A); //   取的   A   的地址
  if P = nil then
    Exit;
  len := PLongint(PChar(P) - 4)^; //   变量的长度   ，偏移量   -4
  if index >= len then //要删除的位置超出范围，退出
    Exit;
  MaxDelete := len - index; //   最多删除的数量
  Count := Min(Count, MaxDelete); //   取得一个较小值
  if Count = 0 then //   不要求删除
    Exit;
  Dec(len, Count); //   移动到要删除的位置
  MoveMemory(PChar(P) + index * elSize, PChar(P) + (index + Count) * elSize, (len - index) * elSize); //移动内存
  Dec(P); //移出   “数组长度”位置
  Dec(P); //移出“引用计数”   位置
  //重新再分配调整内存,len   新的长度.   Sizeof(Longint)   *   2   =   2*Dec(P)
  ReallocMem(P, len * elSize + Sizeof(Longint) * 2);
  Inc(P); //   指向数组长度
  P^ := len; //   new   length
  Inc(P); //   指向数组元素，开始的位置
  PLongint(A) := P;
end;
 {
function GetItemShowName(Item: TNewClientItem): string;
begin
  Result := Item.s.Name;
  if sm_Arming2 in Item.s.StdModeEx then begin
    if (Item.UserItem.Value.btValue[tb_WuXin] in [1..5]) then
      Result := Item.s.Name + ' 【' + GetWuXinName(Item.UserItem.Value.btValue[tb_WuXin]) + '】'
  end;

end;        }

procedure ClearEMailInfo();
var
  i: integer;
begin
  for I := 0 to g_EMailList.Count - 1 do begin
    Dispose(pTEMailInfo(g_EMailList.Objects[i]));
  end;
  g_EMailList.Clear;
end;

function GetHDInfoImage(HDType: THDInfoType): Integer;
begin
  Result := -1;
  case HDType of
    HIT_Prior: Result := 450;
    HIT_Desktop: Result := 445;
    HIT_Pictures: Result := 447;
    HIT_Personal: Result := 446;
    HIT_Folder: Result := 448;
    HIT_HD: Result := 444;
    HIT_IMAGE: Result := 449;
  end;
end;
{
function MakeSaveUserPhoto(HDInfoDib: TDib; SaveBuff: PChar): Integer;
var
  RLEBuffer, Buffer: Pointer;
  LineSize: Integer;
  i, WriteLength: Integer;
  LineBuffer: PChar;
begin
  Result := -1;
  if g_WMain99Images <> nil then begin
    LineBuffer := HDInfoDib.PBits;
    LineSize := HDInfoDib.Width * (HDInfoDib.BitCount div 8);
    RLEBuffer := AllocMem(2 * LineSize);
    Result := 0;
    for I := 0 to HDInfoDib.Height - 1 do begin
      Buffer := @LineBuffer[LineSize * i];
      WriteLength := EncodeRLE(Buffer, RLEBuffer, HDInfoDib.Width, HDInfoDib.BitCount div 8);
      Move(RLEBuffer^, SaveBuff[Result], WriteLength);
      Inc(Result, WriteLength);
    end;
    FreeMem(RLEBuffer);
  end;
end;

function MakeLoadUserPhoto(HDInfoDib: TDib; LoadBuff: PChar): Boolean;
var
  RLEBuffer, Buffer: Pointer;
  LineSize: Integer;
  i, ReadLength: Integer;
  LineBuffer: PChar;
begin
  Result := False;
  if g_WMain99Images <> nil then begin
    LineSize := HDInfoDib.Width * (HDInfoDib.BitCount div 8);
    RLEBuffer := AllocMem(2 * LineSize);
    LineBuffer := HDInfoDib.PBits;
    ReadLength := 0;
    for I := 0 to HDInfoDib.Height - 1 do begin
      Buffer := @LineBuffer[LineSize * i];
      RLEBuffer := @LoadBuff[ReadLength];
      Inc(ReadLength, DecodeRLE(RLEBuffer, Buffer, LineSize, HDInfoDib.BitCount));
    end;
    FreeMem(RLEBuffer);
    Result := True;
  end;
end;         }

function LoadImageFileToSurface(FileName: string; var HDInfoSurface: TDXImageTexture): Byte;
var
  FileHandle: THandle;
  ChrBuff: array[0..9] of Char;
  nImageType: Byte;
  Gif: TGIFImage;
  Jpeg: TJPEGImage;
  Stream: TStream;
  Bmp: TBitmap;
  y: Integer;
  ReadBuffer, WriteBuffer: PChar;
  Access: TDXAccessInfo;
begin
  Bmp := nil;
  Gif := nil;
  Jpeg := nil;
  Try
    nImageType := 0;
    if FileExists(FileName) then begin
      FileHandle := FileOpen(FileName, fmOpenRead or fmShareDenyNone);
      if FileHandle > 0 then begin
        try
          if FileRead(FileHandle, ChrBuff, SizeOf(ChrBuff)) = SizeOf(ChrBuff) then begin
            if (ChrBuff[0] + ChrBuff[1]) = 'BM' then begin
              nImageType := 1; // BMP
            end
            else if (ChrBuff[0] + ChrBuff[1] + ChrBuff[2]) = 'GIF' then begin
              nImageType := 2; // GIF
            end
            else if (ChrBuff[0] = Char($FF)) and (ChrBuff[1] = Char($D8)) then begin
              nImageType := 3; // JPEG
            end;
          end;
        finally
          FileClose(FileHandle);
        end;
      end;
    end;
    Result := 1;    //图像大小不合格
    case nImageType of
      1: begin
        Bmp := TBitmap.Create;
        Bmp.LoadFromFile(FileName);
        if (Bmp.Width < 10) or (Bmp.Height < 10) or (Bmp.Width > g_FScreenWidth) or (Bmp.Height > g_FScreenHeight)
        then begin
          Bmp.Free;
          Bmp := nil;
        end;
      end;
      2: begin
        Gif := TGIFImage.Create;
        Gif.LoadFromFile(FileName);
        if (Gif.Width > 10) or (Gif.Height > 10) or (Gif.Width <= g_FScreenWidth) or (Gif.Height <= g_FScreenHeight)
        then begin
          Bmp := TBitmap.Create;
          Bmp.Assign(Gif);
        end;
        Gif.Free;
        Gif := nil;
      end;
      3: begin
        Jpeg := TJPEGImage.Create;
        Jpeg.LoadFromFile(FileName);
        if (Jpeg.Width > 10) or (Jpeg.Height > 10) or (Jpeg.Width <= g_FScreenWidth) or (Jpeg.Height <= g_FScreenHeight)
        then begin
          Bmp := TBitmap.Create;
          Bmp.Assign(Jpeg);
        end;
        Jpeg.Free;
        Jpeg := nil;
      end;
      else Result := 0;
    end;
    if (Bmp <> nil)then begin
      Stream := TMemoryStream.Create;
      Try
        //将图像转换成JPEG压缩后再转换为BMP,不知道为什么要这三个步骤,不然会报 JPEG error #42 的错误,郁闷中~~
        Jpeg := TJPEGImage.Create;
        Jpeg.Assign(bmp);
        Jpeg.CompressionQuality := 60;
        Jpeg.Compress;
        Bmp.Free;
        Bmp := nil;

        Jpeg.SaveToStream(Stream);
        Jpeg.Free;
        Jpeg := nil;
        
        Jpeg := TJPEGImage.Create;
        Stream.Seek(0, 0);
        Jpeg.LoadFromStream(Stream);
        Bmp := TBitmap.Create;
        Bmp.Assign(Jpeg);
        Jpeg.Free;
        Jpeg := nil;
      Finally
        Stream.Free;
      End;
      Result := 2;
      BMP.PixelFormat := pf32bit;
      HDInfoSurface := TDXImageTexture.Create(g_DXCanvas);
      HDInfoSurface.Size := Point(BMP.Width, BMP.Height);
      HDInfoSurface.PatternSize := Point(BMP.Width, BMP.Height);
      HDInfoSurface.Format := D3DFMT_A8R8G8B8;
      HDInfoSurface.Active := True;
      if HDInfoSurface.Active then begin
        if HDInfoSurface.Lock(lfWriteOnly, Access) then begin
          try
            for Y := 0 to Bmp.Height - 1 do begin
              ReadBuffer := Bmp.ScanLine[y];
              WriteBuffer := Pointer(Integer(Access.Bits) + Y * Access.Pitch);
              Move(ReadBuffer^, WriteBuffer^, Bmp.Width * 4);
            end;
            Result := 255;
          finally
            HDInfoSurface.Unlock;
          end;
        end;
      end;
    end;
    if Bmp <> nil then Bmp.Free;
    if Gif <> nil then Gif.Free;
    if Jpeg <> nil then Jpeg.Free;
    if Result <> 255 then begin
      if HDInfoSurface <> nil then begin
        HDInfoSurface.Free;
        HDInfoSurface := nil;
      end;
    end;
  Except
    Result := 0;     //非图像文件
    if HDInfoSurface <> nil then begin
      HDInfoSurface.Free;
      HDInfoSurface := nil;
    end;
    if Bmp <> nil then Bmp.Free;
    if Gif <> nil then Gif.Free;
    if Jpeg <> nil then Jpeg.Free;
  End;
end;

function CheckFilePath(sFilePath: String): string;
begin
  if RightStr(sFilePath, 1) <> '\' then Result := sFilePath + '\'
  else Result := sFilePath;
end;

function CheckFileNameLen(sOldName: string; var boChange: Boolean): string;
Const
  MaxLen = 140;
  ShowLen = 119;
var
  WideStr: WideString;
  i: integer;
  str: string;
begin
  boChange := False;
  Result := sOldName;
  if FrmMain.Canvas.TextWidth(sOldName) > MaxLen then begin
    WideStr := sOldName;
    boChange := True;
    Result := '';
    for i := 1 to Length(WideStr) do begin
      str := WideStr[i];
      if FrmMain.Canvas.TextWidth(Result + str) > ShowLen then begin
        Result := Result + '...';
        break;
      end;
      Result := Result + str;
    end;
  end;
end;

procedure LoadMasterHDInfo();
resourcestring
  sUserShellFolders = 'Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders';
  sShellFolders = 'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders';
var
  Reg: TRegistry;
  HDInfo: pTHDInfo;
  sStr: string;
  Count,I:Integer;
  buff:array[0..255] of array[0..3] of Char;
  Volname,FileSysname: PChar;
  wComponent, wMacComponent, wFileSystemFlag: DWord;
begin
  ClearMasterHDInfo(g_MasterHDInfoList);
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey(sUserShellFolders,False) or Reg.OpenKey(sShellFolders,False)then begin
      sStr := Reg.ReadString('Desktop');
      if sStr <> '' then begin
        New(HDInfo);
        HDInfo.HDInfoType := HIT_Desktop;
        HDInfo.sShowName := '桌面';
        HDInfo.boChange := False;
        HDInfo.sName := '桌面';
        HDInfo.sPlace := CheckFilePath(sStr);
        HDInfo.nImageID := GetHDInfoImage(HIT_Desktop);
        HDInfo.nLevel := 1;
        g_MasterHDInfoList.Add(HDInfo);
      end;
      sStr := Reg.ReadString('Personal');
      if sStr <> '' then begin
        New(HDInfo);
        HDInfo.HDInfoType := HIT_Personal;
        HDInfo.sShowName := '我的文档';
        HDInfo.boChange := False;
        HDInfo.sName := '我的文档';
        HDInfo.sPlace := CheckFilePath(sStr);
        HDInfo.nImageID := GetHDInfoImage(HIT_Personal);
        HDInfo.nLevel := 1;
        g_MasterHDInfoList.Add(HDInfo);
      end;
      sStr := Reg.ReadString('My Pictures');
      if sStr <> '' then begin
        New(HDInfo);
        HDInfo.HDInfoType := HIT_Pictures;
        HDInfo.sShowName := '我的图片';
        HDInfo.boChange := False;
        HDInfo.sName := '我的图片';
        HDInfo.sPlace := CheckFilePath(sStr);
        HDInfo.nImageID := GetHDInfoImage(HIT_Pictures);
        HDInfo.nLevel := 1;
        g_MasterHDInfoList.Add(HDInfo);
      end;
      Reg.CloseKey;
    end;
    Count:=GetLogicalDriveStrings(SizeOf(Buff),@buff);
    GetMem(Volname, 255);
    GetMem(FileSysname, 100);
    for I:=0 to (Count div 4) -1 do begin
      if GetDriveType(Buff[i]) in [DRIVE_REMOVABLE, DRIVE_REMOTE,DRIVE_FIXED] then begin
        New(HDInfo);
        SafeFillChar(Volname^, 255, #0);
        if not GetVolumeInformation(PChar(@Buff[i]), Volname, 255, @wComponent, wMacComponent, wFileSystemFlag, FileSysname, 100)
        then sStr := '本地磁盘'
        else sStr := StrPas(Volname);    //CheckFileNameLen
        if sStr = '' then sStr := '本地磁盘';
        HDInfo.HDInfoType := HIT_HD;
        HDInfo.sName := sStr + ' (' + Buff[i][0] + Buff[i][1] + ')';
        HDInfo.sShowName := CheckFileNameLen(HDInfo.sName, HDInfo.boChange);
        HDInfo.sPlace := CheckFilePath(Buff[i]);
        HDInfo.nImageID := GetHDInfoImage(HIT_HD);
        HDInfo.nLevel := 1;
        g_MasterHDInfoList.Add(HDInfo);
      end;
    end;
    FreeMem(Volname, 255);
    FreeMem(FileSysname, 100);
  finally
    Reg.Free;
  end;
end;
procedure ClearMasterHDInfo(List: TList);
var
  i: integer;
begin
  for I := 0 to List.Count - 1 do
    Dispose(pTHDInfo(List[i]));
  List.Clear;
end;

function InFriendList(sName: string): Boolean;
var
  i: integer;
begin
  Result := False;
  for I := 0 to g_FriendList.Count - 1 do begin
    if CompareText(sName, g_FriendList[i]) = 0 then begin
      Result := True;
      break;
    end;
  end;
end;

procedure CopyStrToClipboard(sStr: string);
var
  Clipboard: TClipboard;
begin
  Clipboard := TClipboard.Create;
  Try
    Clipboard.AsText := sStr;
  Finally
    Clipboard.Free;
  End;
end;

function InGroupList(sName: string): Boolean;
var
  i: integer;
begin
  Result := False;
  for I := 0 to g_GroupMembers.Count - 1 do begin
    if CompareText(sName, pTGroupMember(g_GroupMembers[i]).ClientGroup.UserName) = 0 then begin
      Result := True;
      break;
    end;
  end;
end;

procedure DeleteEMailByIndex(nIndex: Integer);
var
  i: integer;
  EMailInfo: pTEMailInfo;
begin
  for I := 0 to g_EMailList.Count - 1 do begin
    EMailInfo := pTEMailInfo(g_EMailList.Objects[i]);
    if EMailInfo.ClientEMail.nIdx = nIndex then begin
      Dispose(EMailInfo);
      g_EMailList.Delete(i);
      break;
    end;
  end;
end;

//20091104修改
function ShowItemInfo(Item: TNewClientItem; MoveItemState: TMoveItemState; btNum: array of Integer): string;
{var
  Item: TNewClientItem; }

  function GetDuraStr(Dura, maxdura: Integer): string;
  begin
    //if not BoNoDisplayMaxDura then begin
    Result := IntToStr(Round(Dura / 1000)) + '/';
    if Item.UserItem.DuraMax > Item.s.DuraMax then
      //Result := Result + '<' + IntToStr(Round(maxdura / 1000)) + '/FCOLOR=' + ADDVALUECOLOR + '>'
      Result := Result + IntToStr(Round(maxdura / 1000))
    else
      Result := Result + IntToStr(Round(maxdura / 1000));
    {end
    else
      Result := IntToStr(Round(Dura / 1000));   }
  end;
  function GetDura100Str(Dura, maxdura: Integer): string;
  begin
    //if not BoNoDisplayMaxDura then
    Result := IntToStr(Round(Dura / 100)) + '/' + IntToStr(Round(maxdura / 100))
      {else
Result := IntToStr(Round(Dura / 100)); }
  end;
  function GetDura1Str(Dura, maxdura: Integer): string;
  begin
    Result := IntToStr(Dura) + '/' + IntToStr(maxdura);
  end;
  function GetJPStr(OldInt: Word; Mode: Byte): string;
  begin
    Result := IntToStr(OldInt);
    if Item.UserItem.Value.btValue[Mode] > 0 then begin
      //Result := '<' + IntToStr(OldInt + Item.UserItem.Value.btValue[Mode]) + '/FCOLOR=' + ADDVALUECOLOR + '>';
      Result := IntToStr(OldInt + Item.UserItem.Value.btValue[Mode]);
    end;
  end;

  function GetJPStr2(OldInt: Word; Mode: Byte): string;
  begin
    Result := '+' + IntToStr(OldInt);
    if Item.UserItem.Value.btValue[Mode] > 0 then begin
      Result := '<+' + IntToStr(OldInt + Item.UserItem.Value.btValue[Mode]) + '/FCOLOR=' + ADDVALUECOLOR3 + '>';
    end;
  end;

  function GetJPBtStr2(OldInt: Integer; Mode: Byte): string;
  begin
    Result := '+' + IntToStr(OldInt);
    if Item.UserItem.Value.btValue[Mode] > 0 then begin
      Result := '<+' + IntToStr(OldInt + Item.UserItem.Value.btValue[Mode]) + '/FCOLOR=' + ADDVALUECOLOR3 + '>';
    end;
  end;

  function GetJPBtStr3(OldInt: Integer; Mode: Byte): string;
  begin
    Result := '+' + IntToStr(OldInt * 10) + '%';
    if Item.UserItem.Value.btValue[Mode] > 0 then begin
      Result := '<+' + IntToStr(OldInt * 10 + Item.UserItem.Value.btValue[Mode] * 10) + '%/FCOLOR=' + ADDVALUECOLOR3 + '>';
    end;
  end;

  function GetJPBtStr4(OldInt: Integer; Mode: Byte): string;
    //  var
    //    str: string;
  begin
    if OldInt > 10 then begin
      Dec(OldInt, 10);
      Result := '+'
    end
    else
      Result := '-';
    if Item.UserItem.Value.btValue[Mode] > 0 then begin
      Result := '<' + Result + IntToStr(OldInt * 10) + '%/FCOLOR=' + ADDVALUECOLOR + '>';
    end
    else
      Result := Result + IntToStr(OldInt * 10) + '%';
  end;

  function GetJPBtStr5(OldInt: Integer; Mode: Byte): string;
  begin
    Result := '+' + IntToStr(OldInt) + '%';
    if Item.UserItem.Value.btValue[Mode] > 0 then begin
      Result := '<+' + IntToStr(OldInt + Item.UserItem.Value.btValue[Mode]) + '%/FCOLOR=' + ADDVALUECOLOR3 + '>';
    end;
  end;

  function GetJPBtStr6(OldInt: Integer; Mode1, Mode2: Byte): string;
  begin
    Result := '+' + IntToStr(OldInt);
    if (Item.UserItem.Value.btValue[Mode1] > 0) or (Item.UserItem.Value.btValue[Mode2] > 0) then begin
      Result := '<+' + IntToStr(OldInt) + '/FCOLOR=' + ADDVALUECOLOR3 + '>';
    end;
  end;

  function GetJPBtStr(OldInt: Word; Mode: Byte): string;
  begin
    Result := '+' + IntToStr(OldInt);
    if Item.UserItem.Value.btValue[Mode] > 0 then begin
      Result := '<+' + IntToStr(OldInt + Item.UserItem.Value.btValue[Mode]) +
        '/FCOLOR=' + ADDVALUECOLOR + '>';
    end;
  end;

  function GetStrSpace(sMsg: string): string;
  var
    nLen: Integer;
    I: Integer;
    sTemp: string;
  begin
    Result := sMsg;
    ArrestStringEx(sMsg, '<', '/', sTemp);
    if sTemp = '' then nLen := Length(sMsg)
    else nLen := Length(sTemp);
    if nLen < 8 then begin
      for I := 1 to 8 - nLen do
        Result := Result + ' ';
    end else Result := Result + ' ';
  end;

  function GetJPStrEx(nCount: Integer): string;
  begin
    Result := '';
    if nCount > 0 then begin
      Result := '<[+' + IntToStr(nCount) + ']/FCOLOR=$63CEFF>';
    end;
  end;

  function GetJPStrEx2(nCount: Integer): string;
  begin
    Result := '';
    if nCount > 0 then begin
      Result := '<[+' + IntToStr(nCount * 10) + '%]/FCOLOR=$63CEFF>';
    end;
  end;

  function GetJPStrEx3(nCount: Integer): string;
  begin
    Result := '';
    if nCount > 0 then begin
      Result := '<[+' + IntToStr(nCount) + '%]/FCOLOR=$63CEFF>';
    end;
  end;
var
  boBuy: Boolean;
  boBindGold: Boolean;
  nRepair: Integer;
  nSell: Integer;
  I, K: Integer;
  Stditem: TStdItem;
  itValue: TUserItemValueArray;
  ShowString, AddShowString: string;
  sNeedStr, TempStr, AddStr, sGoldStr: string;
  TempByte: Byte;
  TempInt, nInt: Integer;
  MyWuXin{, MyJob}, MySex: Byte;
  boArmST: Boolean;
  ArrCount: Integer;
  MyUseItems: pTClientUserItems;
  //  ItemIndex: Integer;
//  StdItem: TStdItem;

  function AddBindStr(sStr, sAddStr: string; var nCount: Integer): string;
  begin
    //sNeedStr := '<永不掉落' + '/FCOLOR=' + NOTDOWNCOLOR + '>\';
    Result := '';
    if sStr = '' then begin
      if sAddStr <> '' then begin
        Result := sAddStr;
        Inc(nCount);
      end;
    end else begin
      if sAddStr = '' then begin
        Result := sStr + '\';
      end else begin
        Result := sStr + '、' + sAddStr;
        Inc(nCount);
        if nCount >= 2 then begin
          ShowString := ShowString + Result + '\';
          Result := '';
          nCount := 0;
        end;
      end;
    end;
  end;
const
  HorseItemNames: array[0..4] of String[4] = ('缰绳', '铃铛', '马鞍', '装饰', '脚钉');
var
  AddAbility: TAddAbility;
  sNameColor: string;
  SetItem: pTSetItems;
  boOK: Boolean;
begin
  Result := '';
  DScreen.ClearHint;
  ShowString := '';
  AddShowString := '';
//  boArmST := False;
  if g_MySelf = nil then Exit;
  //Item := ReadItem;
  ArrCount := SizeOf(btNum) div SizeOf(Integer);
  if ArrCount <> 3 then begin
    MyWuXin := g_MySelf.m_btWuXin;
    MySex := g_MySelf.m_btSex;
    MyUseItems := @g_UseItems[0];
    //MyJob := g_MySelf.m_btJob;
  end else begin
    MyWuXin := btNum[0];
    MySex := btNum[1];
    MyUseItems := pTClientUserItems(btNum[2]);
    //MyJob := btNum[1];
  end;
  if Item.UserItem.EffectValue.btColor > 0 then sNameColor := IntToStr(GetRGB(Item.UserItem.EffectValue.btColor))
  else if Item.S.Color > 0 then sNameColor := IntToStr(GetRGB(Item.S.Color))
  else sNameColor := '$63CEFF';
  
  boBuy := False;
  boBindGold := False;
  nRepair := GetRepairItemPrice(@Item.UserItem, @Item.s);
  nSell := GetUserItemPrice(@Item.UserItem, @Item.s) div 2;
  if mis_buy in MoveItemState then begin
    boBuy := True;
    if SizeOf(btNum) div SizeOf(Integer) = 2 then begin
      sGoldStr := '<购买单价: ' + GetGoldStr(btNum[0]) + ' ';
      if btNum[1] = 0 then
        sGoldStr := sGoldStr + g_sGoldName
      else begin
        sGoldStr := sGoldStr + g_sBindGoldName;
        boBindGold := True;
      end;

      sGoldStr := sGoldStr + '/FCOLOR=' + SELLDEFCOLOR + '>\';
      sGoldStr := sGoldStr + '<Line>';
    end;
  end else
  if mis_ShopSell in MoveItemState then begin
    if SizeOf(btNum) div SizeOf(Integer) = 2 then begin
      AddShowString := '<出售单价: ' + GetGoldStr(btNum[0]) + ' ';
      if btNum[1] = 0 then
        AddShowString := AddShowString + g_sGoldName
      else
        AddShowString := AddShowString + g_sGameGoldName;

      AddShowString := AddShowString + '/FCOLOR=';
      if btNum[1] = 0 then
        AddShowString := AddShowString + '$FFFFFF>\'
      else
        AddShowString := AddShowString + '$CCFF>\';
      AddShowString := AddShowString + '<Line>';
    end;
  end else
  if mis_ShopBuy in MoveItemState then begin
    if SizeOf(btNum) div SizeOf(Integer) = 2 then begin
      AddShowString := '<收购单价: ' + GetGoldStr(btNum[0]) + ' ';
      if btNum[1] = 0 then
        AddShowString := AddShowString + g_sGoldName
      else
        AddShowString := AddShowString + g_sGameGoldName;

      AddShowString := AddShowString + '/FCOLOR=';
      if btNum[1] = 0 then
        AddShowString := AddShowString + '$FFFFFF>\'
      else
        AddShowString := AddShowString + '$CCFF>\';
      AddShowString := AddShowString + '<Line>';
    end;
  end;

  //MyWuXin := g_MySelf.m_btWuXin;
  if Item.S.name <> '' then begin
    ShowString := '<' + Item.S.name + '/FCOLOR=' + sNameColor + '>\';
    case Item.S.StdMode of
      tm_Reel: begin
          if Item.s.Shape = 13 then begin
            ShowString := ShowString + ' \';
            if Item.UserItem.Value.boBind then begin
              ShowString := ShowString + '<记忆地图：' + Item.UserItem.Value.sMapDesc + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              ShowString := ShowString + '<记忆坐标：' + IntToStr(Item.UserItem.Value.wCurrX) + ',' +
                IntToStr(Item.UserItem.Value.wCurrY) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
            end else begin
              ShowString := ShowString + '<尚未使用/FCOLOR=' + ADDVALUECOLOR2 + '>\';
            end;
            ShowString := ShowString + GetItemNeedStr(@Item);
          end else
          if Item.s.Shape = 14 then begin
            ShowString := ShowString + ' \对换自然成长点：' + IntToStr(Item.s.DuraMax) + ' 点\';
            ShowString := ShowString + '获得经验值：' + IntToStr(Item.s.Source * Item.s.Reserved) + '\';
            ShowString := ShowString + GetItemNeedStr(@Item);
          end else
          if Item.s.Shape = 15 then begin
            ShowString := ShowString + ' \增加行会建设值：' + IntToStr(Item.s.Source) + ' 点\';

            ShowString := ShowString + GetItemNeedStr(@Item);
          end else
          if Item.s.Shape = 17 then begin
            ShowString := ShowString + ' \获得经验值：' + IntToStr(Item.s.Source * 1000) + '\';
            ShowString := ShowString + GetItemNeedStr(@Item);
          end else
          if Item.s.Shape = 18 then begin
            ShowString := ShowString + ' \还原属性点：' + IntToStr(Item.s.DuraMax) + '\';
            ShowString := ShowString + GetItemNeedStr(@Item);
          end else begin
            sNeedStr := GetItemNeedStr(@Item);
            if sNeedStr <> '' then
              ShowString := ShowString + ' \' + sNeedStr;
          end;
        end;
      tm_Drug: begin //药品
          ShowString := ShowString + ' \';
          if Item.S.nAC > 0 then
            ShowString := ShowString + '恢复HP ' + IntToStr(Item.S.nAC) + ' 点\';
          if Item.S.nMAC > 0 then
            ShowString := ShowString + '恢复MP ' + IntToStr(Item.S.nMAC) + ' 点\';
          ShowString := ShowString + GetItemNeedStr(@Item);
        end;
      tm_Restrict: begin //解包物品
          if Item.S.StdMode = tm_Restrict then begin
            if Item.S.Shape = 9 then begin
              ShowString := ShowString + ' \修复装备持久 ' +
                IntToStr(Round(Item.UserItem.dura / 100)) + ' 点\'
            end
            else begin
              if mis_bottom in MoveItemState then begin
                ShowString := ShowString + ' \剩余 ' + IntToStr(Item.UserItem.Dura) + ' 次\';
              end else
                ShowString := ShowString + ' \剩余 ' + GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' 次\';
            end;
          end;
          ShowString := ShowString + GetItemNeedStr(@Item);
        end;
      tm_Rock: begin //气血石等
          ShowString := ShowString + ' \重量 ' + IntToStr(Item.S.Weight) + '\';
          case Item.S.Shape of
            0: ShowString := ShowString + '剩余 ' +
              GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' 次\';
            1: ShowString := ShowString + '恢复HP ' +
              GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' 万\';
            2: ShowString := ShowString + '恢复MP ' +
              GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' 万\';
            3: ShowString := ShowString + '恢复HP和MP ' +
              GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' 万\';
          end;
        end;
      tm_Book: {// 技能书} begin
          case Item.S.Shape of
            0: begin
                ShowString := ShowString + ' \武士秘籍\';
              end;
            1: begin
                ShowString := ShowString + ' \法师秘籍\';
              end;
            2: begin
                ShowString := ShowString + ' \道士秘籍\';
              end;
            3: begin
                ShowString := ShowString + ' \合击秘籍\';
              end;
          end;
          ShowString := ShowString + GetNeedStr(@Item);
        end;
      tm_Amulet: {符类} begin
          ShowString := ShowString + ' \重量 ' + IntToStr(Item.S.Weight) + '\';
          case Item.S.Shape of
            5: ShowString := ShowString + '剩余 ' +
              GetDura1Str(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' 张\';
            1, 2: ShowString := ShowString + '剩余 ' +
              GetDura1Str(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' 次\';
          end;
        end;
      tm_Cowry: begin
          ShowString := ShowString + ' \重量 ' + IntToStr(Item.S.Weight) + '\';
          if Item.s.Shape = 0 then begin
            ShowString := ShowString + '剩余 ' + GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' 次\';
          end;
        end;
      tm_Ore: begin
          ShowString := ShowString + ' \纯度 ' + IntToStr(Round(Item.UserItem.Dura / 1000)) + '\';
        end;
      tm_Open: begin
          sNeedStr := GetItemNeedStr(@Item);
          if sNeedStr <> '' then
            ShowString := ShowString + ' \' + sNeedStr;
        end;
      tm_MakeStone: begin

          //ShowString := ShowString + '重量: ' + IntToStr(Item.S.Weight) + '\ \';
          case Item.s.Shape of
            0: begin
              ShowString := ShowString + ' \';
              ShowString := ShowString + '<强化属性/FCOLOR=' + NOTDOWNCOLOR + '>\';
              ShowString := ShowString + '<强化成功机率: +' + IntToStr(Item.s.Reserved) +
                  '%/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              ShowString := ShowString + '<强化成功提高装备等级: +1/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              if item.s.AniCount > 0 then
                ShowString := ShowString + '<强化失败降低装备强化等级机率: +' + IntToStr(item.s.AniCount) +
                  '%/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              if item.s.Source > 0 then
                ShowString := ShowString + '<强化失败装备破碎机率: +' + IntToStr(item.s.Source) +
                  '%/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              ShowString := ShowString + ' \';
              ShowString := ShowString + '<强化使用要求/FCOLOR=' + NOTDOWNCOLOR + '>\';
              if Item.s.Need > 0 then
                ShowString := ShowString + '<装备强化等级大于或等于: +' + IntToStr(Item.s.Need) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              ShowString := ShowString + '<装备强化等级小于或等于: +' + IntToStr(Item.s.NeedLevel) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
            end;
            2, 4: begin
              ShowString := ShowString + ' \';
              ShowString := ShowString + '<宝石属性/FCOLOR=' + NOTDOWNCOLOR + '>\';
              ShowString := ShowString + '<提高成功机率: +' + IntToStr(Item.s.Reserved) + '%/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              //ShowString := ShowString + '<可以在强化装备、打造物品和装备开光时使用/FCOLOR=' + ADDVALUECOLOR2 + '>\';
            end;
            1: begin
              //ShowString := ShowString + '<强化装备时使用，保护装备不会破碎/FCOLOR=' + WUXINISMYCOLOR + '>\';
            end;
            3: begin
              ShowString := ShowString + ' \';
              ShowString := ShowString + '<宝石属性/FCOLOR=' + NOTDOWNCOLOR + '>\';
              case Item.s.AniCount of
                1: ShowString := ShowString + '<防御  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                2: ShowString := ShowString + '<魔御  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                3: ShowString := ShowString + '<攻击  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                4: ShowString := ShowString + '<魔法  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                5: ShowString := ShowString + '<道术  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                6: ShowString := ShowString + '<生命值  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                7: ShowString := ShowString + '<魔法值  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              end;
              ShowString := ShowString + ' \<镶嵌要求/FCOLOR=' + NOTDOWNCOLOR + '>\';
              if Item.s.Need > 0 then
                ShowString := ShowString + '<装备强化等级大于或等于: +' + IntToStr(Item.s.Need) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\'
              else
                ShowString := ShowString + '<可用于任何有凹槽的装备/FCOLOR=' + ADDVALUECOLOR2 + '>\';
            end;
            9: begin
            
            end;
          end;
        end;
      {tm_ResetStone: begin
        ShowString := ShowString + ' \<COLOR=$00FFFF>';
        ShowString := ShowString + '拥有女娲神奇的力量，可以随机刷新装备极品属性点\';
        ShowString := ShowString + '使用方法\';
        ShowString := ShowString + '右键单击该宝石，然后再左键单击的装备';
        ShowString := ShowString + '<ENDCOLOR>\'
      end;   }
      tm_House: begin
          ShowString := '<' + Item.S.name + '/FCOLOR=' + sNameColor + '>\';

          ShowString := ShowString + '<Height>';
          ShowString := ShowString + '重量        ' + IntToStr(Item.S.Weight) + '\';

          GetHorseLevelAbility(@Item.UserItem, @Item.S, AddAbility);
          for I := Low(Item.UserItem.HorseItems) to High(Item.UserItem.HorseItems) do begin
            if Item.UserItem.HorseItems[I].wIndex > 0 then begin
              StdItem := GetStditem(Item.UserItem.HorseItems[I].wIndex);
              if StdItem.Name <> '' then
                GetHorseAddAbility(@Item.UserItem, @StdItem, I, AddAbility);
            end;
          end;

          ShowString := ShowString + '坐骑等级    ' + IntToStr(Item.UserItem.btLevel) + '\';
          if Item.UserItem.btAliveTime > 0 then ShowString := ShowString + '坐骑状态    <已死亡 ' + IntToStr(Item.UserItem.btAliveTime) + '分钟后自动复活/FCOLOR=$C0C0C0>\'
          else ShowString := ShowString + '坐骑状态    <正常/FCOLOR=$00FF00>\';
          ShowString := ShowString + '坐骑经验    ' + IntToStr(Item.UserItem.dwExp) + '/' + IntToStr(Item.UserItem.dwMaxExp) + '\';

          ShowString := ShowString + ' \';
          if (AddAbility.AC > 0) or (AddAbility.AC2 > 0) then
            ShowString := ShowString + '坐骑防御    ' + GetStrSpace(IntToStr(AddAbility.AC) + '-' + IntToStr(AddAbility.AC2)) + '\';

          if (AddAbility.MAC > 0) or (AddAbility.MAC2 > 0) then
            ShowString := ShowString + '坐骑魔御    ' + GetStrSpace(IntToStr(AddAbility.MAC) + '-' + IntToStr(AddAbility.MAC2)) + '\';

          if (AddAbility.DC > 0) or (AddAbility.DC2 > 0) then
            ShowString := ShowString + '坐骑攻击    ' + GetStrSpace(IntToStr(AddAbility.DC) + '-' + IntToStr(AddAbility.DC2)) + '\';


          if (AddAbility.wHitPoint > 0) then
            ShowString := ShowString + '<坐骑准确    /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(IntToStr(AddAbility.wHitPoint)) + '\';

          if (Item.s.SpeedPoint > 0) or (Item.UserItem.Value.btValue[tb_Speed] > 0) then
            ShowString := ShowString + '<坐骑敏捷    /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(IntToStr(AddAbility.wSpeedPoint)) + '\';


          if (AddAbility.HP > 0) then
            ShowString := ShowString + '<坐骑生命值  /FCOLOR=' + ADDVALUECOLOR3 + '>'  + GetStrSpace(IntToStr(AddAbility.HP)) + '\';

          ShowString := ShowString + GetNeedStr(@Item, '  ');


          ShowString := ShowString + ' \坐骑装备\';

          for I := Low(Item.UserItem.HorseItems) to High(Item.UserItem.HorseItems) do begin
            ShowString := ShowString + '<  [' + HorseItemNames[I] + ']  ';
            if Item.UserItem.HorseItems[I].wIndex > 0 then begin
              ShowString := ShowString + '  ' + GetStditem(Item.UserItem.HorseItems[I].wIndex).Name + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '  未装备' + '/FCOLOR=' + HINTCOLOR2 + '>\';
            end;
          end;

        end;
      tm_Rein,
        tm_Bell,
        tm_Saddle,
        tm_Decoration,
        tm_Nail: begin
          sNeedStr := Item.S.name;
          TempStr := '';
          AddStr := '';

          itValue := Item.UserItem.Value.btValue;
          ShowString := '<' + sNeedStr + ' (坐骑专用装备)/FCOLOR=' + sNameColor + '>\ \';


          ShowString := ShowString + '<Height>';
          ShowString := ShowString + '重量      ' + IntToStr(Item.S.Weight) + '\';
          ShowString := ShowString + '持久      ' + GetStrSpace(GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax));
          
          TempInt := Item.UserItem.DuraMax - Item.s.DuraMax;
          if TempInt > 500 then begin
            TempInt := Round(TempInt / 1000);
            ShowString := ShowString + '<[+' + IntToStr(TempInt) + ']/FCOLOR=$63CEFF>\';
          end else ShowString := ShowString + '\';

          if (Item.S.nAC > 0) or (Item.S.nAC2 > 0) or
            (item.UserItem.Value.btValue[tb_AC] > 0) or
            (item.UserItem.Value.btValue[tb_AC2] > 0) then
            ShowString := ShowString + '防御      ' + GetStrSpace(GetJPStr(Item.S.nAC, tb_AC) + '-' +
              GetJPStr(Item.S.nAC2, tb_AC2)) + GetJPStrEx(itValue[tb_AC2]) + '\';

          if (Item.S.nMAC > 0) or (Item.S.nMAC2 > 0) or
            (item.UserItem.Value.btValue[tb_MAC] > 0) or (item.UserItem.Value.btValue[tb_MAC2] > 0) then
            ShowString := ShowString + '魔御      ' + GetStrSpace(GetJPStr(Item.S.nMaC, tb_MAC) + '-' +
              GetJPStr(Item.S.nMAC2, tb_MAC2)) + GetJPStrEx(itValue[tb_MAC2]) + '\';

          if (Item.S.nDC > 0) or (Item.S.nDC2 > 0) or
            (item.UserItem.Value.btValue[tb_DC] > 0) or (item.UserItem.Value.btValue[tb_DC2] > 0) then
            ShowString := ShowString + '攻击      ' + GetStrSpace(GetJPStr(Item.S.nDC, tb_DC)
              + '-' + GetJPStr(Item.S.nDC2, tb_DC2)) + GetJPStrEx(itValue[tb_DC2]) + '\';


          if (Item.s.HitPoint > 0) or (Item.UserItem.Value.btValue[tb_Hit] > 0) then
            ShowString := ShowString + '<准确      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBTStr2(Item.S.HitPoint, tb_Hit)) + GetJPStrEx(itValue[tb_Hit]) + '\';

          if (Item.s.SpeedPoint > 0) or (Item.UserItem.Value.btValue[tb_Speed] > 0) then
            ShowString := ShowString + '<敏捷      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBTStr2(Item.S.SpeedPoint, tb_Speed)) + GetJPStrEx(itValue[tb_Speed]) + '\';


          if (Item.S.HP > 0) or (item.UserItem.Value.btValue[tb_HP] > 0) then
            ShowString := ShowString + '<生命值    /FCOLOR=' + ADDVALUECOLOR3 +
              '>'  + GetStrSpace(GetJPStr2(Item.S.HP, tb_HP)) + GetJPStrEx(itValue[tb_HP]) + '\';


          ShowString := ShowString + GetNeedStr(@Item);
          if CheckByteStatus(Item.UserItem.btBindMode2, Ib2_Unknown) then
            ShowString := ShowString + '<未开光/FCOLOR=' + ITEMNAMECOLOR + '>\';

          if (g_UseItems[U_HOUSE].S.Name <> '') and (g_UseItems[U_HOUSE].UserItem.btLevel >= Item.S.NeedLevel) then
            ShowString := ShowString + '<' + '需要坐骑等级 ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\'
          else ShowString := ShowString + '<' + '需要坐骑等级 ' + AddStr + IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
          

         { sMsg := '<' + '需要等级 ' + AddStr + IntToStr(Item.S.DuraMax) + '/FCOLOR=$0000FF>\';
        case Item.S.Shape of
          0: begin
              if (MyJob = 0) and (m_Abil.Level >= Item.S.DuraMax) then
                sMsg := '<' + '需要等级 ' + AddStr +  IntToStr(Item.S.DuraMax) + '/FCOLOR=$00FF00>\';
            end;   }
        end;
      tm_Weapon,
        tm_Dress,
        tm_Helmet,
        tm_Ring,
        tm_ArmRing,
        tm_Necklace,
        tm_Belt,
        tm_Boot,
        tm_Stone,
        tm_Light: begin

          if Item.UserItem.EffectValue.btUpgrade > 0 then sNeedStr := '(*)' + Item.S.name
          else sNeedStr := Item.S.name;
          TempStr := '';
          AddStr := '';

          {Item.UserItem.Value.StrengthenInfo.btStrengthenCount := 9;
          item.UserItem.Value.btValue[tb_DC2] := 3;
          item.UserItem.Value.btValue[tb_AntiMagic] := 1;
          Item.UserItem.Value.btFluteCount := 3;  }
          itValue := Item.UserItem.Value.btValue;
          if (Item.s.StdMode <> tm_House) and (Item.UserItem.Value.btWuXin in [1..5]) then begin
            {if g_nParam1 > 0 then
              Item.UserItem.Value.btValue[tb_StrengthenCount] := g_nParam1;  }
            //boArmST := GetStrengthenAbility(@Item.UserItem, @Item.UserItem.Value.btValue);
            boArmST := Item.UserItem.Value.StrengthenInfo.btStrengthenCount > 0;
            //boArmST := GetStrengthenValue(@Item.UserItem.Value.btValue, Item.s);
            //取镶嵌宝石属性
            {if Item.UserItem.Value.btFluteCount > 0 then begin
              for I := 0 to Item.UserItem.Value.btFluteCount - 1 do begin
                if (I in [0..MAXFLUTECOUNT - 1]) then begin
                  if Item.UserItem.Value.wFlute[i] > 0 then begin
                    Stditem := GetStdItem(Item.UserItem.Value.wFlute[i]);
                    if (Stditem.name <> '') and (Stditem.StdMode = tm_MakeStone) and (Stditem.Shape = 3) then begin
                      case Stditem.AniCount of
                        Itas_Ac: Inc(Item.UserItem.Value.btValue[tb_AC2], Stditem.Source);
                        Itas_Mac: Inc(Item.UserItem.Value.btValue[tb_MAC2], Stditem.Source);
                        Itas_Dc: Inc(Item.UserItem.Value.btValue[tb_DC2], Stditem.Source);
                        Itas_Mc: Inc(Item.UserItem.Value.btValue[tb_MC2], Stditem.Source);
                        Itas_Sc: Inc(Item.UserItem.Value.btValue[tb_SC2], Stditem.Source);
                        Itas_Hp: Inc(Item.UserItem.Value.btValue[tb_HP], Stditem.Source);
                        Itas_Mp: Inc(Item.UserItem.Value.btValue[tb_MP], Stditem.Source);
                      end;
                    end;

                  end;
                end else break;
              end;
            end;   }
            //GetStoneAbility(@Item.UserItem, Item.s);
            //取强化装备属性
            if boArmST then begin
              {if Item.s.StdMode = tm_Weapon then begin
                if Item.UserItem.Value.btValue[tb_StrengthenCount] > 3 then begin
                  Item.s.DuraMax := Item.s.DuraMax + 3000;
                end else
                  Item.s.DuraMax := Item.s.DuraMax + Item.UserItem.Value.btValue[tb_StrengthenCount] * 1000;
              end else begin
                if Item.UserItem.Value.btValue[tb_StrengthenCount] > 5 then begin
                  Item.s.DuraMax := Item.s.DuraMax + 5000;
                end else
                  Item.s.DuraMax := Item.s.DuraMax + Item.UserItem.Value.btValue[tb_StrengthenCount] * 1000;
              end;       }
              sNeedStr := GetStrengthenItemName(Item.S.name, Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
              TempStr := ' [+' + IntToStr(Item.UserItem.Value.StrengthenInfo.btStrengthenCount) + ']';
              {nInt := Item.UserItem.Value.StrengthenInfo.btStrengthenCount div 2;
              for TempInt := 0 to nInt - 1 do begin
                if (TempInt > 0) and (TempInt mod 3 = 0) then
                  AddStr := AddStr + '<x=10>';
                AddStr := AddStr + '<img=f.3,t.150,i.462-467><x=17>';

              end;
              if Item.UserItem.Value.StrengthenInfo.btStrengthenCount mod 2 <> 0 then
                AddStr := AddStr + '<img=f.3,t.150,i.468-473><x=17>'; }
              //AddStr := AddStr + '\';
            end;
            ShowString := '<' + sNeedStr + TempStr + '/FCOLOR=' + sNameColor + '>';

            if g_boUseWuXin and (Item.UserItem.Value.btWuXin in [1..5]) then
              ShowString := ShowString + ' <y=-2><img=f.3,i.' + IntToStr(767 + Item.UserItem.Value.btWuXin) + '><y=2>\'
            else
              ShowString := ShowString + '\';
              //IntToHex(GetWuXinColor(Item.UserItem.Value.btWuXin), 0) + '> ' + TempStr + '\';

            {ShowString := '<' + sNeedStr + '/FCOLOR=' + ITEMNAMECOLOR + '> <【' +
              GetWuXinName(Item.UserItem.Value.btWuXin) + '】/FCOLOR=$' +
              IntToHex(GetWuXinColor(Item.UserItem.Value.btWuXin), 0) + '> ' + TempStr + '\';   }
              //WuXinStr[Item.UserItem.Value.btValue[tb_WuXin]]

            ShowString := ShowString + ' \';
            //'<img=f.3,t.150,i.462-467><img=f.3,t.150,i.462-467><img=f.3,t.150,i.462-467>\ \';
          end else begin
            ShowString := '<' + sNeedStr + '/FCOLOR=' + sNameColor + '>\ \'
          end;

          ShowString := ShowString + '<Height>';
          ShowString := ShowString + '重量      ' + IntToStr(Item.S.Weight) + '\';
          if (mis_CompoundItemAdd in MoveItemState) then
            ShowString := ShowString + '合成等级  ' + IntToStr(Item.UserItem.ComLevel) + '\';
          ShowString := ShowString + '持久      ' + GetStrSpace(GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax));

          TempInt := Item.UserItem.DuraMax - Item.s.DuraMax;
          if TempInt > 500 then begin
            TempInt := Round(TempInt / 1000);
            ShowString := ShowString + '<[+' + IntToStr(TempInt) + ']/FCOLOR=$63CEFF>\';
          end else ShowString := ShowString + '\';

         { ShowString := ShowString + '攻击      45-535  [+15]\';
          ShowString := ShowString + '生命值    +200    [+200]\';
          ShowString := ShowString + '致命一击  +100%   [+10%]\';        }
          if (Item.S.nAC > 0) or (Item.S.nAC2 > 0) or
            (item.UserItem.Value.btValue[tb_AC] > 0) or
            (item.UserItem.Value.btValue[tb_AC2] > 0) then
            ShowString := ShowString + '防御      ' + GetStrSpace(GetJPStr(Item.S.nAC, tb_AC) + '-' +
              GetJPStr(Item.S.nAC2, tb_AC2)) + GetJPStrEx(itValue[tb_AC2]) + '\';

          if (Item.S.nMAC > 0) or (Item.S.nMAC2 > 0) or
            (item.UserItem.Value.btValue[tb_MAC] > 0) or (item.UserItem.Value.btValue[tb_MAC2] > 0) then
            ShowString := ShowString + '魔御      ' + GetStrSpace(GetJPStr(Item.S.nMaC, tb_MAC) + '-' +
              GetJPStr(Item.S.nMAC2, tb_MAC2)) + GetJPStrEx(itValue[tb_MAC2]) + '\';

          if (Item.S.nDC > 0) or (Item.S.nDC2 > 0) or
            (item.UserItem.Value.btValue[tb_DC] > 0) or (item.UserItem.Value.btValue[tb_DC2] > 0) then
            ShowString := ShowString + '攻击      ' + GetStrSpace(GetJPStr(Item.S.nDC, tb_DC)
              + '-' + GetJPStr(Item.S.nDC2, tb_DC2)) + GetJPStrEx(itValue[tb_DC2]) + '\';

          if (Item.S.nMC > 0) or (Item.S.nMC2 > 0) or
            (item.UserItem.Value.btValue[tb_MC] > 0) or (item.UserItem.Value.btValue[tb_MC2] > 0) then
            ShowString := ShowString + '魔法      ' + GetStrSpace(GetJPStr(Item.S.nMC, tb_MC)
              + '-' + GetJPStr(Item.S.nMC2, tb_MC2)) + GetJPStrEx(itValue[tb_MC2]) + '\';

          if (Item.S.nSC > 0) or (Item.S.nSC2 > 0) or
            (item.UserItem.Value.btValue[tb_SC] > 0) or (item.UserItem.Value.btValue[tb_SC2] > 0) then
            ShowString := ShowString + '道术      ' + GetStrSpace(GetJPStr(Item.S.nSC, tb_SC)
              + '-' + GetJPStr(Item.S.nSC2, tb_SC2)) + GetJPStrEx(itValue[tb_SC2]) + '\';

          {if (Item.s.Dunt > 0) or (Item.UserItem.Value.btValue[tb_Dunt] > 0) then
            ShowString := ShowString + '<致命一击: /FCOLOR=' + ADDVALUECOLOR2
              + '>' + GetJPBTStr5(Item.S.Dunt, tb_Dunt) + '\'; }

          if (Item.s.HitPoint > 0) or (Item.UserItem.Value.btValue[tb_Hit] > 0) then
            ShowString := ShowString + '<准确      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBTStr2(Item.S.HitPoint, tb_Hit)) + GetJPStrEx(itValue[tb_Hit]) + '\';

          if (Item.s.SpeedPoint > 0) or (Item.UserItem.Value.btValue[tb_Speed] > 0) then
            ShowString := ShowString + '<敏捷      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBTStr2(Item.S.SpeedPoint, tb_Speed)) + GetJPStrEx(itValue[tb_Speed]) + '\';

          if (Item.s.Strong > 0) or (Item.UserItem.Value.btValue[tb_Strong] > 0) then
            ShowString := ShowString + '<强度      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBTStr2(Item.S.Strong, tb_Strong)) + GetJPStrEx(itValue[tb_Strong]) + '\';

          TempInt := LoByte(Item.s.Luck) + Item.UserItem.Value.btValue[tb_Luck] - Item.UserItem.Value.btValue[tb_UnLuck];
          if TempInt > 0 then
            ShowString := ShowString + '<幸运      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBtStr6(TempInt, tb_Luck, tb_UnLuck)) + GetJPStrEx(itValue[tb_Luck] - itValue[tb_UnLuck]) + '\'
          else if TempInt < 0 then
            ShowString := ShowString + '<诅咒      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBtStr6(-TempInt, tb_Luck, tb_UnLuck)) + GetJPStrEx(-(itValue[tb_Luck] - itValue[tb_UnLuck])) + '\';

          if (Item.S.HP > 0) or (item.UserItem.Value.btValue[tb_HP] > 0) then
            ShowString := ShowString + '<生命值    /FCOLOR=' + ADDVALUECOLOR3 +
              '>'  + GetStrSpace(GetJPStr2(Item.S.HP, tb_HP)) + GetJPStrEx(itValue[tb_HP]) + '\';
          if (Item.S.MP > 0) or (item.UserItem.Value.btValue[tb_MP] > 0) then
            ShowString := ShowString + '<魔法值    /FCOLOR=' + ADDVALUECOLOR3 +
              '>' + GetStrSpace(GetJPStr2(Item.S.MP, tb_MP)) + GetJPStrEx(itValue[tb_MP]) + '\';

         { TempByte := Item.S.HitSpeed + Item.UserItem.Value.btValue[tb_HitSpeed];
          if (TempByte > 0) then begin
            ShowString := ShowString + '<攻击速度: /FCOLOR=' + ADDVALUECOLOR2
              + '>' + GetJPBTStr4(TempByte, tb_HitSpeed) + '\'
          end;    }

          if (Item.s.AntiMagic > 0) or (Item.UserItem.Value.btValue[tb_AntiMagic] > 0) then
            ShowString := ShowString + '<魔法躲避  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr3(Item.S.AntiMagic, tb_AntiMagic)) + GetJPStrEx2(itValue[tb_AntiMagic]) + '\';

          if (Item.s.PoisonMagic > 0) or (Item.UserItem.Value.btValue[tb_PoisonMagic] > 0) then
            ShowString := ShowString + '<毒物躲避  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr3(Item.S.PoisonMagic, tb_PoisonMagic)) + GetJPStrEx2(itValue[tb_PoisonMagic]) + '\';

          if (Item.s.HealthRecover > 0) or (Item.UserItem.Value.btValue[tb_HealthRecover] > 0) then
            ShowString := ShowString + '<体力恢复  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr3(Item.S.HealthRecover, tb_HealthRecover)) + GetJPStrEx2(itValue[tb_HealthRecover]) + '\';

          if (Item.s.SpellRecover > 0) or (Item.UserItem.Value.btValue[tb_SpellRecover] > 0) then
            ShowString := ShowString + '<魔法恢复  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr3(Item.S.SpellRecover, tb_SpellRecover)) + GetJPStrEx2(itValue[tb_SpellRecover]) + '\';

          if (Item.s.PoisonRecover > 0) or (Item.UserItem.Value.btValue[tb_PoisonRecover] > 0) then
            ShowString := ShowString + '<毒物恢复  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr3(Item.S.PoisonRecover, tb_PoisonRecover)) + GetJPStrEx2(itValue[tb_PoisonRecover]) + '\';

         { if (Item.s.StdMode <> tm_House) and (Item.UserItem.Value.btWuXin <> 0) and
            ((Item.s.AddWuXinAttack > 0) or (Item.s.DelWuXinAttack > 0) or
             (Item.UserItem.Value.btValue[tb_AddWuXinAttack] > 0) or
             (Item.UserItem.Value.btValue[tb_DelWuXinAttack] > 0)) then begin
            if (Item.s.DelWuXinAttack > 0) or (Item.UserItem.Value.btValue[tb_DelWuXinAttack] > 0) then begin
              if CheckWuXinConsistent(Item.UserItem.Value.btWuXin, MyWuXin) then
                ShowString := ShowString + '<五行防御  /FCOLOR=' + ADDVALUECOLOR3
                  + '>' + GetJPBTStr5(Item.s.DelWuXinAttack, tb_DelWuXinAttack) + '\';
            end;
            if (Item.s.AddWuXinAttack > 0) or (Item.UserItem.Value.btValue[tb_AddWuXinAttack] > 0) then begin
              if CheckWuXinConsistent(MyWuXin, Item.UserItem.Value.btWuXin) then
                ShowString := ShowString + '<五行伤害  /FCOLOR=' + ADDVALUECOLOR3
                  + '>' + GetJPBTStr5(Item.s.AddWuXinAttack, tb_AddWuXinAttack) + '\';
            end;
          end;   }

          if (Item.s.AddAttack > 0) or (Item.UserItem.Value.btValue[tb_AddAttack] > 0) then
            ShowString := ShowString + '<伤害加成  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr5(Item.S.AddAttack, tb_AddAttack)) + GetJPStrEx3(itValue[tb_AddAttack]) + '\';

          if (Item.s.DelDamage > 0) or (Item.UserItem.Value.btValue[tb_DelDamage] > 0) then
            ShowString := ShowString + '<伤害吸收  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr5(Item.S.DelDamage, tb_DelDamage)) + GetJPStrEx3(itValue[tb_DelDamage]) + '\';

          if (Item.s.Deadliness > 0) or (Item.UserItem.Value.btValue[tb_Deadliness] > 0) then
            ShowString := ShowString + '<致命一击  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr5(Item.S.Deadliness, tb_Deadliness)) + GetJPStrEx3(itValue[tb_Deadliness]) + '\';

          ShowString := ShowString + GetNeedStr(@Item);
          if sm_ArmingStrong in Item.s.StdModeEx then begin
            if CheckByteStatus(Item.UserItem.btBindMode2, Ib2_Unknown) then
              ShowString := ShowString + '<未开光/FCOLOR=' + ITEMNAMECOLOR + '>\';
          end;

          (*
          sNeedStr := '';
          if (itValue[tb_Hit] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_Hit]) + ' 准确' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_Speed] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_Speed]) + ' 敏捷' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_Strong] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_Strong]) + ' 强度' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          TempInt := itValue[tb_Luck] - itValue[tb_UnLuck];
          if TempInt > 0 then
            sNeedStr := sNeedStr + '<+' + IntToStr(TempInt) + ' 幸运' + '/FCOLOR=' + ADDVALUECOLOR + '>\'
          else if TempInt < 0 then
            sNeedStr := sNeedStr + '<+' + IntToStr(-TempInt) + ' 诅咒' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_HP] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_HP]) + ' 生命值' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_MP] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_MP]) + ' 魔法值' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          TempInt := Item.UserItem.DuraMax - Item.s.DuraMax;
          if TempInt > 500 then begin
            TempInt := Round(TempInt / 1000);
            sNeedStr := sNeedStr + '<+' + IntToStr(TempInt) + ' 最大持久' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          end;

          if (itValue[tb_AC] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_AC]) + ' 最小防御' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_AC2] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_AC2]) + ' 最大防御' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_mAC] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_mAC]) + ' 最小魔御' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_mAC2] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_mAC2]) + ' 最大魔御' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_DC] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_DC]) + ' 最小攻击' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_DC2] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_DC2]) + ' 最大攻击' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_MC] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_MC]) + ' 最小魔法' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_MC2] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_MC2]) + ' 最大魔法' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_SC] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_SC]) + ' 最小道术' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_SC2] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_SC2]) + ' 最大道术' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          {if (item.UserItem.Value.btValue[tb_DelWuXinAttack] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(item.UserItem.Value.btValue[tb_DelWuXinAttack])
              + '% 五行防御' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (item.UserItem.Value.btValue[tb_AddWuXinAttack] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(item.UserItem.Value.btValue[tb_AddWuXinAttack])
              + '% 五行伤害' + '/FCOLOR=' + ADDVALUECOLOR + '>\'; }



          {if (item.UserItem.Value.btValue[tb_HitSpeed] > 0) then
            if TempByte > 10 then
              sNeedStr := sNeedStr + '<+' + IntToStr(item.UserItem.Value.btValue[tb_HitSpeed] * 10)
                + '% 攻击速度' + '/FCOLOR=' + ADDVALUECOLOR + '>\'
            else
              sNeedStr := sNeedStr + '<-' + IntToStr(item.UserItem.Value.btValue[tb_HitSpeed] * 10)
                + '% 攻击速度' + '/FCOLOR=' + ADDVALUECOLOR + '>\';  }

          if (itValue[tb_AntiMagic] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_AntiMagic] * 10)
              + '% 魔法躲避' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_PoisonMagic] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_PoisonMagic] * 10)
              + '% 毒物躲避' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_HealthRecover] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_HealthRecover] * 10)
              + '% 体力恢复' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_SpellRecover] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_SpellRecover] * 10)
              + '% 魔法恢复' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_PoisonRecover] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_PoisonRecover] * 10)
              + '% 毒物恢复' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_AddAttack] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_AddAttack])
              + '% 伤害加成' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_DelDamage] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_DelDamage])
              + '% 伤害吸收' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_Deadliness] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_Deadliness])
              + '% 致命一击' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if sNeedStr <> '' then begin
            ShowString := ShowString + ' \<极品属性/FCOLOR=' + NOTDOWNCOLOR{NOTDOWNCOLOR} + '>\';
            ShowString := ShowString + sNeedStr;
          end;         *)

          if g_boUseWuXin and (Item.s.StdMode <> tm_House) and (Item.UserItem.Value.btWuXin <> 0) and
            ((Item.s.AddWuXinAttack > 0) or (Item.s.DelWuXinAttack > 0) or
             (Item.UserItem.Value.btValue[tb_AddWuXinAttack] > 0) or
             (Item.UserItem.Value.btValue[tb_DelWuXinAttack] > 0)) then begin
            ShowString := ShowString + ' \五行属性\';
            if (Item.s.DelWuXinAttack > 0) or (Item.UserItem.Value.btValue[tb_DelWuXinAttack] > 0) then begin
              if CheckWuXinConsistent(Item.UserItem.Value.btWuXin, MyWuXin) then
                ShowString := ShowString + '<角色属[' +
                  GetWuXinName(GetWuXinConsistent(Item.UserItem.Value.btWuXin)) + '] 五行防御 +' +
                  IntToStr(Item.s.DelWuXinAttack + Item.UserItem.Value.btValue[tb_DelWuXinAttack])  +
                  '%/FCOLOR=$FFFF63>\'
              else
                ShowString := ShowString + '<角色属[' +
                  GetWuXinName(GetWuXinConsistent(Item.UserItem.Value.btWuXin)) + '] 五行防御 +' +
                  IntToStr(Item.s.DelWuXinAttack + Item.UserItem.Value.btValue[tb_DelWuXinAttack])  +
                  '%/FCOLOR=' + HINTCOLOR2 + '>\';
            end;
            if (Item.s.AddWuXinAttack > 0) or (Item.UserItem.Value.btValue[tb_AddWuXinAttack] > 0) then begin
              if CheckWuXinConsistent(MyWuXin, Item.UserItem.Value.btWuXin) then
                ShowString := ShowString + '<角色属[' +
                  GetWuXinName(GetWuXinConsistentBack(Item.UserItem.Value.btWuXin)) + '] 五行伤害 +' +
                  IntToStr(Item.s.AddWuXinAttack + Item.UserItem.Value.btValue[tb_AddWuXinAttack])  +
                  '%/FCOLOR=$FFFF63>\'
              else
                ShowString := ShowString + '<角色属[' +
                  GetWuXinName(GetWuXinConsistentBack(Item.UserItem.Value.btWuXin)) + '] 五行伤害 +' +
                  IntToStr(Item.s.AddWuXinAttack + Item.UserItem.Value.btValue[tb_AddWuXinAttack])  +
                  '%/FCOLOR=' + HINTCOLOR2 + '>\';
            end;
          end;

          if Item.UserItem.Value.StrengthenInfo.btCanStrengthenCount > 2 then begin
            ShowString := ShowString + ' \强化属性 [' + Format('%d/%d',
              [Item.UserItem.Value.StrengthenInfo.btStrengthenCount,
              Item.UserItem.Value.StrengthenInfo.btCanStrengthenCount]) + ']\';

            for I := 1 to 6 do begin
              TempInt := I * 3;
              if Item.UserItem.Value.StrengthenInfo.btCanStrengthenCount >= TempInt then begin
                if TempInt < 10 then ShowString := ShowString + '<[+ ' + IntToStr(TempInt) + ']  '
                else ShowString := ShowString + '<[+' + IntToStr(TempInt) + ']  ';
                if Item.UserItem.Value.StrengthenInfo.btStrengthenCount >= TempInt then begin
                  ShowString := ShowString + GetStrengthenText(TempInt, Item.UserItem.Value.StrengthenInfo.btStrengthenInfo[(TempInt - 1) div 3]) + '/FCOLOR=$63CEFF>\';
                end
                else begin
                  if g_ShowStrengthenInfo then begin
                    ShowString := ShowString + GetStrengthenText(TempInt, Item.UserItem.Value.StrengthenInfo.btStrengthenInfo[(TempInt - 1) div 3]) + '/FCOLOR=' + HINTCOLOR2 + '>\';
                  end else begin
                    ShowString := ShowString + '未激活' + '/FCOLOR=' + HINTCOLOR2 + '>\';
                    break;
                  end;
                end;
              end else break;
            end;
          end;
          sNeedStr := '';
          TempInt := 0;
          if Item.UserItem.Value.btFluteCount > 0 then begin
            for I := Low(Item.UserItem.Value.wFlute) to High(Item.UserItem.Value.wFlute) do begin
              if I >= Item.UserItem.Value.btFluteCount then break;

              if Item.UserItem.Value.wFlute[I] > 0 then begin
                sNeedStr := sNeedStr + '<img=f.3,i.774><x=22><';
                Inc(TempInt);
                StdItem := GetStditem(Item.UserItem.Value.wFlute[I]);
                if (StdItem.Name <> '') and (tm_MakeStone = StdItem.StdMode) and (StdItem.Shape = 3) then begin
                  sNeedStr := sNeedStr + StdItem.Name + ' ';
                  case Stditem.Anicount of
                    1: sNeedStr := sNeedStr + ' 防御 +' + IntToStr(Stditem.Source);
                    2: sNeedStr := sNeedStr + ' 魔御 +' + IntToStr(Stditem.Source);
                    3: sNeedStr := sNeedStr + ' 攻击 +' + IntToStr(Stditem.Source);
                    4: sNeedStr := sNeedStr + ' 魔法 +' + IntToStr(Stditem.Source);
                    5: sNeedStr := sNeedStr + ' 道术 +' + IntToStr(Stditem.Source);
                    6: sNeedStr := sNeedStr + ' HP +' + IntToStr(Stditem.Source);
                    7: sNeedStr := sNeedStr + ' MP +' + IntToStr(Stditem.Source);
                  end;
                  sNeedStr := sNeedStr + '/FCOLOR=$FFFF63>\';
                end;
              end else begin
                sNeedStr := sNeedStr + '<img=f.3,i.773><x=22><';
                sNeedStr := sNeedStr + '未镶嵌宝石/FCOLOR=' + HINTCOLOR2 + '>\';
              end;
            end;
            ShowString := ShowString + ' \凹槽数量 [' + Format('%d/%d', [TempInt, Item.UserItem.Value.btFluteCount]) + ']\';
            ShowString := ShowString + sNeedStr;
          end;
        end;
    end;
    ShowString := ShowString + ' \';
    //if CheckByteStatus(Item.UserItem.btBindMode2, Ib2_Bind) then
      //ShowString := ShowString + '<已绑定' + '/FCOLOR=' + NOTDOWNCOLOR + '>\';
    sNeedStr := '';
    ArrCount := 0;     //sNeedStr := '<永不掉落' + '/FCOLOR=' + NOTDOWNCOLOR + '>\';
    if CheckItemBindMode(@Item.UserItem, bm_NoDown) then begin
      sNeedStr := AddBindStr(sNeedStr, '永不掉落', ArrCount);
    end;
    if sm_ArmingStrong in Item.s.StdModeEx then begin
      if CheckItemBindMode(@Item.UserItem, bm_NoMake) then begin
        {(Item.UserItem.Value.StrengthenInfo.btStrengthenCount >= Item.UserItem.Value.StrengthenInfo.btCanStrengthenCount) }
        sNeedStr := AddBindStr(sNeedStr, '不可强化', ArrCount);
      end;
    end;
    if CheckItemBindMode(@Item.UserItem, bm_NoDeal) then
      sNeedStr := AddBindStr(sNeedStr, '不可交易', ArrCount);
    if CheckItemBindMode(@Item.UserItem, bm_NoSell) or boBindGold then
      sNeedStr := AddBindStr(sNeedStr, '不可出售', ArrCount);
    if CheckItemBindMode(@Item.UserItem, bm_NoSave) then
      sNeedStr := AddBindStr(sNeedStr, '不可存仓', ArrCount);
    if CheckItemBindMode(@Item.UserItem, bm_NoRepair) then
      sNeedStr := AddBindStr(sNeedStr, '不可修理', ArrCount);
    if CheckItemBindMode(@Item.UserItem, bm_NoDrop) then
      sNeedStr := AddBindStr(sNeedStr, '不可丢弃', ArrCount)
    else
    if CheckItemBindMode(@Item.UserItem, bm_DropDestroy) then
      sNeedStr := AddBindStr(sNeedStr, '丢弃消失', ArrCount);

    sNeedStr := AddBindStr(sNeedStr, '', ArrCount);
    ShowString := ShowString + sNeedStr;
    
    sNeedStr := '';
    if not boBuy then begin
      sGoldStr := '';
      if not (CheckItemBindMode(@Item.UserItem, bm_NoSell)) then
      begin
        sGoldStr := '<卖给商店  ' + GetGoldStr(nSell);
        {if CheckByteStatus(Item.UserItem.btBindMode2, Ib2_BindGold) then
          sGoldStr := sGoldStr + ' ' + g_sBindGoldName
        else
          sGoldStr := sGoldStr + ' ' + g_sGoldName;  }
        sGoldStr := sGoldStr + ' ' + g_sGoldName;
        sGoldStr := sGoldStr + '/FCOLOR=' + SELLDEFCOLOR + '>\';
      end;
    end;
    if not (mis_MakeItem in MoveItemState) then begin
      if Item.UserItem.TermTime <> 0 then
        ShowString := ShowString + '<到期时间  ' + Formatdatetime('YYYY年M月D日 HH时', LongWordToDateTime(Item.UserItem.TermTime)) + '/FCOLOR=' + SELLDEFCOLOR + '>\';
      if (mis_Repair in MoveItemState) or (mis_SuperRepair in MoveItemState) then begin
        if ((sm_Arming in Item.s.StdModeEx) or (sm_HorseArm in Item.s.StdModeEx)) and not (CheckItemBindMode(@Item.UserItem, bm_NoRepair)) then
        begin
          TempInt := nRepair;
          if (mis_SuperRepair in MoveItemState) then
            TempInt := TempInt * 3;
          if TempInt > 0 then begin
            ShowString := ShowString + '<修理费用  ' + GetGoldStr(TempInt) +
              ' ' + g_sGoldName + '/FCOLOR=' + SELLDEFCOLOR + '>\';
            //sNeedStr := '<按住ALT+点击装备可快速修理/FCOLOR=$00FFFF>\';
          end else
            ShowString := ShowString + '<不需要修理/FCOLOR=' + SELLDEFCOLOR + '>\';
        end else
          ShowString := ShowString + '<不可以修理/FCOLOR=' + SELLDEFCOLOR + '>\';
      end else
      if (mis_CompoundItemAdd in MoveItemState) and FrmDlg4.CanCompoundItemAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<点击右键快速添加到合成窗口/FCOLOR=$00FFFF>\';
      end else
      if (mis_ArmAbilityMoveAdd in MoveItemState) and FrmDlg4.CanArmAbilityMoveAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<点击右键快速添加到属性转移窗口/FCOLOR=$00FFFF>\';
      end else
      if (mis_ArmStrengthenAdd in MoveItemState) and FrmDlg3.CanArmStrengthenAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<点击右键快速添加到强化窗口/FCOLOR=$00FFFF>\';
      end else
      if (mis_MakeItemAdd in MoveItemState) and FrmDlg3.CanMakeItemAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<点击右键快速添加到打造窗口/FCOLOR=$00FFFF>\';
      end else
      if (mis_ItemUnsealAdd in MoveItemState) and FrmDlg3.CanItemUnsealAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<点击右键快速添加到开光窗口/FCOLOR=$00FFFF>\';
      end else
      if (mis_ItemRemoveStoneAdd in MoveItemState) and FrmDlg4.CanItemRemoveStoneAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<点击右键快速添加到卸下宝石窗口/FCOLOR=$00FFFF>\';
      end else
      if (mis_Storage in MoveItemState) then begin
        if not (CheckItemBindMode(@Item.UserItem, bm_NoSave))
        then begin
          ShowString := ShowString + sGoldStr;
          sNeedStr := '<点击右键快速存入仓库/FCOLOR=$00FFFF>\';
        end else
          ShowString := ShowString + '<不可以存仓/FCOLOR=' + SELLDEFCOLOR + '>\';
      end else begin
        ShowString := ShowString + sGoldStr;
        if boBuy then begin
          sNeedStr := '<点击购买/FCOLOR=$00FFFF>\';
        end else
        if mis_StorageBack in MoveItemState then begin
          sNeedStr := '<点击取回到包裹/FCOLOR=$00FFFF>\';
        end else
        if (mis_MyDeal in MoveItemState) or (mis_AddBag in MoveItemState) or (mis_ArmStrengthen in MoveItemState) then begin
          sNeedStr := '<点击取回到包裹/FCOLOR=$00FFFF>\';
        end else
        if (mis_State in MoveItemState) then begin
          sNeedStr := '<单击右键快速取回到包裹/FCOLOR=$00FFFF>\';
        end else
        if (mis_Bag in MoveItemState) then begin
          if (sm_Arming in Item.s.StdModeEx) or (sm_HorseArm in Item.s.StdModeEx) or (Item.s.StdMode = tm_AddBag) or (Item.s.StdMode = tm_Cowry) or (Item.s.StdMode = tm_House) then
            sNeedStr := '<右键或双击装备该物品/FCOLOR=$00FFFF>\'
          else if (sm_Eat in Item.s.StdModeEx) then
            sNeedStr := '<右键或双击使用该物品/FCOLOR=$00FFFF>\';
        end else
        if (mis_bottom in MoveItemState) then begin
          sNeedStr := '<单击右键使用该物品/FCOLOR=$00FFFF>\';
        end;
      end;
    end;
{$IFDEF DEBUG}
    if g_boShowItemID then
      sNeedStr := sNeedStr + '<物品ID:' + IntToStr(Item.UserItem.MakeIndex) + '/FCOLOR=' + SELLDEFCOLOR + '>\';
{$ENDIF}
    //(mis_MakeItem in MoveItemState)
    TempStr := GetStditemDesc(Item.s.Idx + 1);
    {if (sNeedStr <> '') or (TempStr <> '') then begin
      ShowString := ShowString + ' \';
    end;     }
    if sNeedStr <> '' then begin
      ShowString := ShowString + sNeedStr;
    end;
    if TempStr <> '' then begin
      ShowString := ShowString + ' \';
      ShowString := ShowString + '<COLOR=' + HINTDEFCOLOR + '>' + TempStr + '<ENDCOLOR>\';
    end;
    {ShowString := ShowString + '<Line>';
    ShowString := ShowString + '<COLOR=' + HINTDEFCOLOR + '>测试提示，啊哦有在在要要<ENDCOLOR>\'; }

    //ShowItemMsg := ShowString;
  end;
  Result := AddShowString + ShowString;
  ShowString := '';
  //sNameColor: string;
  //SetItem: pTSetItems;
  if (Item.s.SetItemList <> nil) and (Item.s.SetItemList.Count > 0) then begin
    for I := 0 to Item.s.SetItemList.Count - 1 do begin
      SetItem := Item.s.SetItemList[I];
      ShowString := '<SetItem>\ \套装信息\';
      boOK := True;
      if MySex = 1 then begin
        if SetItem.Items[U_BUJUK] <> '' then begin
          if MyUseItems[U_DRESS].s.Name = SetItem.Items[U_BUJUK] then
            ShowString := ShowString + '<[服装]    ' + SetItem.Items[U_BUJUK] + '/FCOLOR=$63CEFF>\'
          else begin
            ShowString := ShowString + '<[服装]    ' + SetItem.Items[U_BUJUK] + '/FCOLOR=' + HINTCOLOR2 + '>\';
            boOK := False;
          end;
        end;
      end else begin
        if SetItem.Items[U_DRESS] <> '' then begin
          if MyUseItems[U_DRESS].s.Name = SetItem.Items[U_DRESS] then
            ShowString := ShowString + '<[服装]    ' + SetItem.Items[U_DRESS] + '/FCOLOR=$63CEFF>\'
          else begin
            ShowString := ShowString + '<[服装]    ' + SetItem.Items[U_DRESS] + '/FCOLOR=' + HINTCOLOR2 + '>\';
            boOK := False;
          end;
        end;
      end;
      if SetItem.Items[U_WEAPON] <> '' then begin
        if MyUseItems[U_WEAPON].s.Name = SetItem.Items[U_WEAPON] then
          ShowString := ShowString + '<[武器]    ' + SetItem.Items[U_WEAPON] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[武器]    ' + SetItem.Items[U_WEAPON] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      if SetItem.Items[U_HELMET] <> '' then begin
        if MyUseItems[U_HELMET].s.Name = SetItem.Items[U_HELMET] then
          ShowString := ShowString + '<[头盔]    ' + SetItem.Items[U_HELMET] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[头盔]    ' + SetItem.Items[U_HELMET] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      if SetItem.Items[U_NECKLACE] <> '' then begin
        if MyUseItems[U_NECKLACE].s.Name = SetItem.Items[U_NECKLACE] then
          ShowString := ShowString + '<[项链]    ' + SetItem.Items[U_NECKLACE] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[项链]    ' + SetItem.Items[U_NECKLACE] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      if SetItem.Items[U_RIGHTHAND] <> '' then begin
        if MyUseItems[U_RIGHTHAND].s.Name = SetItem.Items[U_RIGHTHAND] then
          ShowString := ShowString + '<[勋章]    ' + SetItem.Items[U_RIGHTHAND] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[勋章]    ' + SetItem.Items[U_RIGHTHAND] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      if (SetItem.Items[U_ARMRINGL] <> '') or (SetItem.Items[U_ARMRINGR] <> '') then begin
        if (SetItem.Items[U_ARMRINGL] <> '') and (MyUseItems[U_ARMRINGL].s.Name = SetItem.Items[U_ARMRINGL]) then begin
          ShowString := ShowString + '<[手镯]    ' + SetItem.Items[U_ARMRINGL] + '/FCOLOR=$63CEFF>\';
          if (SetItem.Items[U_ARMRINGR] <> '') then begin
            if (MyUseItems[U_ARMRINGR].s.Name = SetItem.Items[U_ARMRINGR]) then begin
              ShowString := ShowString + '<[手镯]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[手镯]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end else
        if (SetItem.Items[U_ARMRINGL] <> '') and (MyUseItems[U_ARMRINGR].s.Name = SetItem.Items[U_ARMRINGL]) then begin
          ShowString := ShowString + '<[手镯]    ' + SetItem.Items[U_ARMRINGL] + '/FCOLOR=$63CEFF>\';
          if (SetItem.Items[U_ARMRINGR] <> '') then begin
            if (MyUseItems[U_ARMRINGL].s.Name = SetItem.Items[U_ARMRINGR]) then begin
              ShowString := ShowString + '<[手镯]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[手镯]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end else begin
          if (SetItem.Items[U_ARMRINGL] <> '') then begin
            ShowString := ShowString + '<[手镯]    ' + SetItem.Items[U_ARMRINGL] + '/FCOLOR=' + HINTCOLOR2 + '>\';
            boOK := False;
          end;
          if (SetItem.Items[U_ARMRINGR] <> '') then begin
            if (MyUseItems[U_ARMRINGL].s.Name = SetItem.Items[U_ARMRINGR]) or (MyUseItems[U_ARMRINGR].s.Name = SetItem.Items[U_ARMRINGR]) then begin
              ShowString := ShowString + '<[手镯]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[手镯]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end;
      end;
      if (SetItem.Items[U_RINGL] <> '') or (SetItem.Items[U_RINGR] <> '') then begin
        if (SetItem.Items[U_RINGL] <> '') and (MyUseItems[U_RINGL].s.Name = SetItem.Items[U_RINGL]) then begin
          ShowString := ShowString + '<[戒指]    ' + SetItem.Items[U_RINGL] + '/FCOLOR=$63CEFF>\';
          if (SetItem.Items[U_RINGR] <> '') then begin
            if (MyUseItems[U_RINGR].s.Name = SetItem.Items[U_RINGR]) then begin
              ShowString := ShowString + '<[戒指]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[戒指]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end else
        if (SetItem.Items[U_RINGL] <> '') and (MyUseItems[U_RINGR].s.Name = SetItem.Items[U_RINGL]) then begin
          ShowString := ShowString + '<[戒指]    ' + SetItem.Items[U_RINGL] + '/FCOLOR=$63CEFF>\';
          if (SetItem.Items[U_RINGR] <> '') then begin
            if (MyUseItems[U_RINGL].s.Name = SetItem.Items[U_RINGR]) then begin
              ShowString := ShowString + '<[戒指]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[戒指]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end else begin
          if (SetItem.Items[U_RINGL] <> '') then begin
            ShowString := ShowString + '<[戒指]    ' + SetItem.Items[U_RINGL] + '/FCOLOR=' + HINTCOLOR2 + '>\';
            boOK := False;
          end;
          if (SetItem.Items[U_RINGR] <> '') then begin
            if (MyUseItems[U_RINGL].s.Name = SetItem.Items[U_RINGR]) or (MyUseItems[U_RINGR].s.Name = SetItem.Items[U_RINGR]) then begin
              ShowString := ShowString + '<[戒指]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[戒指]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end;
      end;
      if SetItem.Items[U_BELT] <> '' then begin
        if MyUseItems[U_BELT].s.Name = SetItem.Items[U_BELT] then
          ShowString := ShowString + '<[腰带]    ' + SetItem.Items[U_BELT] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[腰带]    ' + SetItem.Items[U_BELT] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      if SetItem.Items[U_BOOTS] <> '' then begin
        if MyUseItems[U_BOOTS].s.Name = SetItem.Items[U_BOOTS] then
          ShowString := ShowString + '<[靴子]    ' + SetItem.Items[U_BOOTS] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[靴子]    ' + SetItem.Items[U_BOOTS] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      ShowString := ShowString + ' \套装属性\';
      if boOK then sNameColor := ADDVALUECOLOR3//'$63CEFF'
      else sNameColor := HINTCOLOR2; 
      
      for k := Low(SetItem.Value) to High(SetItem.Value) do begin
        if SetItem.Value[k] > 0 then begin
          case K of
            0: ShowString := ShowString + '<防御      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            1: ShowString := ShowString + '<魔御      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            2: ShowString := ShowString + '<攻击      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            3: ShowString := ShowString + '<魔法      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            4: ShowString := ShowString + '<道术      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            5: ShowString := ShowString + '<准确      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            6: ShowString := ShowString + '<敏捷      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            7: ShowString := ShowString + '<生命值    +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            8: ShowString := ShowString + '<魔法值    +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            9: ShowString := ShowString + '<防御增加  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '倍/FCOLOR=' + sNameColor + '>\';
            10: ShowString := ShowString + '<魔御增加  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '倍/FCOLOR=' + sNameColor + '>\';
            11: ShowString := ShowString + '<攻击增加  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '倍/FCOLOR=' + sNameColor + '>\';
            12: ShowString := ShowString + '<魔法增加  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '倍/FCOLOR=' + sNameColor + '>\';
            13: ShowString := ShowString + '<道术增加  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '倍/FCOLOR=' + sNameColor + '>\';
            14: ShowString := ShowString + '<体力恢复  +' + IntToStr(SetItem.Value[k]) + '0%/FCOLOR=' + sNameColor + '>\';
            15: ShowString := ShowString + '<魔法恢复  +' + IntToStr(SetItem.Value[k]) + '0%/FCOLOR=' + sNameColor + '>\';
            16: ShowString := ShowString + '<中毒恢复  +' + IntToStr(SetItem.Value[k]) + '0%/FCOLOR=' + sNameColor + '>\';
            17: ShowString := ShowString + '<魔法躲避  +' + IntToStr(SetItem.Value[k]) + '0%/FCOLOR=' + sNameColor + '>\';
            18: ShowString := ShowString + '<毒物躲避  +' + IntToStr(SetItem.Value[k]) + '0%/FCOLOR=' + sNameColor + '>\';
            19: ShowString := ShowString + '<伤害加成  +' + IntToStr(SetItem.Value[k]) + '%/FCOLOR=' + sNameColor + '>\';
            20: ShowString := ShowString + '<伤害吸收  +' + IntToStr(SetItem.Value[k]) + '%/FCOLOR=' + sNameColor + '>\';
            21: ShowString := ShowString + '<致命一击  +' + IntToStr(SetItem.Value[k]) + '%/FCOLOR=' + sNameColor + '>\';
            22: ShowString := ShowString + '<经验增加  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '倍/FCOLOR=' + sNameColor + '>\';
            23: ShowString := ShowString + '<麻痹属性/FCOLOR=' + sNameColor + '>\';
            24: ShowString := ShowString + '<护身属性/FCOLOR=' + sNameColor + '>\';
            25: ShowString := ShowString + '<复活属性/FCOLOR=' + sNameColor + '>\';
          end;
        end;
      end;

      if ShowString <> '' then
        Result := Result + ShowString;
    end;

  end;
end;

function GetNeedStrEx(var sNeedStr: string; Item: pTNewClientItem): Boolean;
var
  m_Abil: pTAbility;
  MyJob: Byte;
  sMsg: string;
  sMsg1: string;
  sMsg2: string;
begin
  sMsg := '';
  m_Abil := @g_MySelf.m_Abil;
  MyJob := g_MySelf.m_btJob;
  Result := False;
  case Item.s.stdmode of
    tm_Book: begin
        sMsg := '需要等级 ' + IntToStr(Item.S.DuraMax);
        case Item.S.Shape of
          0: begin
              if (MyJob = 0) and (m_Abil.Level >= Item.S.DuraMax) then
                Result := True;
            end;
          1: begin
              if (MyJob = 1) and (m_Abil.Level >= Item.S.DuraMax) then
                Result := True;
            end;
          2: begin
              if (MyJob = 2) and (m_Abil.Level >= Item.S.DuraMax) then
                Result := True;
            end;
          99: begin
              if {(boHero) and}(m_Abil.Level >= Item.S.DuraMax) then
                Result := True;
            end;
        end;
      end;
    tm_Weapon,
      tm_Dress,
      tm_Helmet,
      tm_Ring,
      tm_ArmRing,
      tm_Necklace,
      tm_Belt,
      tm_Boot,
      tm_Stone,
      tm_Light,
      tm_House: begin
        case Item.s.Need of
          0: begin
              sMsg := '需要等级: ' + IntToStr(Item.S.NeedLevel);
              if m_Abil.Level >= Item.S.NeedLevel then
                Result := True;
            end;
          1: begin
              sMsg := '需要职业: ' + GetJobName(Item.S.NeedLevel);
              if MyJob = Item.S.NeedLevel then
                Result := True;
            end;
          10: begin
              sMsg1 := '需要等级: ' + IntToStr(HiWord(Item.S.NeedLevel));
              sMsg2 := '   需要职业: ' + GetJobName(LoWord(Item.S.NeedLevel));
              if (m_Abil.Level >= HiWord(Item.S.NeedLevel)) and (MyJob = LoWord(Item.S.NeedLevel)) then
                Result := True;
              sMsg := sMsg1 + sMsg2;
            end;
        end;
      end;
  end;
  sNeedStr := sMsg;
end;

function GetItemNeedStr(Item: pTNewClientItem): String;
var
  m_Abil: pTAbility;
  MyJob: Byte;
  sMsg: string;
begin
  sMsg := '';
  m_Abil := @g_MySelf.m_Abil;
  MyJob := g_MySelf.m_btJob;
  if (Item.s.Need > 0) or (Item.s.NeedLevel > 0) then begin
    case Item.s.Need of
      0: begin
          sMsg := '<' +  '使用等级: ' + IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
          if m_Abil.Level >= Item.S.NeedLevel then
            sMsg := '<' +  '使用等级: ' + IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
        end;
      1: begin
          sMsg := '<' +  '使用职业: ' + GetJobName(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
          if MyJob = Item.S.NeedLevel then
            sMsg := '<' +  '使用职业: ' + GetJobName(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
        end;
      2: begin
          sMsg := '<行会成员专用/FCOLOR=$0000FF>\';
          if g_MySelf.m_sGuildName <> '' then
            sMsg := '<行会成员专用/FCOLOR=$00FF00>\';
        end;
      3: begin
          sMsg := '<' +  '使用等级低于: ' + IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
          if m_Abil.Level < Item.S.NeedLevel then
            sMsg := '<' +  '使用等级低于: ' + IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
        end;
    end;
  end;
  Result := sMsg;
end;

function GetNeedStr(Item: pTNewClientItem; AddStr: string = ''): String;
var
  m_Abil: pTAbility;
  MyJob: Byte;
  sMsg: string;
  sMsg1: string;
  sMsg2: string;
begin
  sMsg := '';
  if g_MySelf = nil then Exit;
  m_Abil := @g_MySelf.m_Abil;
  MyJob := g_MySelf.m_btJob;
  case Item.s.stdmode of
    tm_Book: begin
        sMsg := '<' + '需要等级 ' + AddStr + IntToStr(Item.S.DuraMax) + '/FCOLOR=$0000FF>\';
        case Item.S.Shape of
          0: begin
              if (MyJob = 0) and (m_Abil.Level >= Item.S.DuraMax) then
                sMsg := '<' + '需要等级 ' + AddStr +  IntToStr(Item.S.DuraMax) + '/FCOLOR=$00FF00>\';
            end;
          1: begin
              if (MyJob = 1) and (m_Abil.Level >= Item.S.DuraMax) then
                sMsg := '<' + '需要等级 ' + AddStr +  IntToStr(Item.S.DuraMax) + '/FCOLOR=$00FF00>\';
            end;
          2: begin
              if (MyJob = 2) and (m_Abil.Level >= Item.S.DuraMax) then
                sMsg := '<' + '需要等级 ' + AddStr +  IntToStr(Item.S.DuraMax) + '/FCOLOR=$00FF00>\';
            end;
          99: begin
              if {(boHero) and}(m_Abil.Level >= Item.S.DuraMax) then
                sMsg := '<' + '需要等级 ' + AddStr +  IntToStr(Item.S.DuraMax) + '/FCOLOR=$00FF00>\';
            end;
        end;
      end;
    tm_Weapon,
      tm_Dress,
      tm_Helmet,
      tm_Ring,
      tm_ArmRing,
      tm_Necklace,
      tm_Belt,
      tm_Boot,
      tm_Stone,
      tm_Light,
      tm_House: begin
        case Item.s.Need of
          0: begin
              sMsg := '<' +  '需要等级  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
              if m_Abil.Level >= Item.S.NeedLevel then
                sMsg := '<' +  '需要等级  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          10: begin
              sMsg1 := '<' +  '需要等级  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '需要职业  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              if m_Abil.Level >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '需要等级  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if MyJob = LoWord(Item.S.NeedLevel) then
                sMsg2 := '<' +  '需要职业  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          1: begin
              sMsg := '<' +  '需要攻击  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.DC) >= Item.S.NeedLevel then
                sMsg := '<' +  '需要攻击  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          11: begin
              sMsg1 := '<' +  '需要攻击  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '需要职业  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.DC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '需要攻击  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if MyJob = LoWord(Item.S.NeedLevel) then
                sMsg2 := '<' +  '需要职业  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          2: begin
              sMsg := '<' +  '需要魔法  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.MC) >= Item.S.NeedLevel then
                sMsg := '<' +  '需要魔法  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          12: begin
              sMsg1 := '<' +  '需要魔法  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '需要职业  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.MC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '需要魔法  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if MyJob = LoWord(Item.S.NeedLevel) then
                sMsg2 := '<' +  '需要职业  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          3: begin
              sMsg := '<' +  '需要道术  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.SC) >= Item.S.NeedLevel then
                sMsg := '<' +  '需要道术  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          13: begin
              sMsg1 := '<' +  '需要道术  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '需要职业  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.SC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '需要道术  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if MyJob = LoWord(Item.S.NeedLevel) then
                sMsg2 := '<' +  '需要职业  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          4: begin
              sMsg := '<' +  '需要转生等级  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          40: begin
              sMsg1 := '<' +  '需要等级  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '需要转生等级  ' + AddStr +  IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if m_Abil.Level >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '需要等级  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          41: begin
              sMsg1 := '<' +  '需要攻击  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '需要转生等级  ' + AddStr +  IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if HiWord(m_Abil.DC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '需要攻击  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          42: begin
              sMsg1 := '<' +  '需要魔法  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '需要转生等级  ' + AddStr +  IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if HiWord(m_Abil.MC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '需要魔法  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          43: begin
              sMsg1 := '<' +  '需要道术  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '需要转生等级  ' + AddStr +  IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if HiWord(m_Abil.SC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '需要道术  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          44: begin
              sMsg1 := '<' +  '需要声望  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '需要转生等级  ' + AddStr +  IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if g_nCreditPoint >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '需要声望  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          5: begin
              sMsg := '<' +  '需要声望  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
              if g_nCreditPoint >= Item.S.NeedLevel then
                sMsg := '<' +  '需要声望  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          6: begin
              sMsg := '<行会成员专用装备/FCOLOR=$0000FF>\';
              if g_MySelf.m_sGuildName <> '' then
                sMsg := '<行会成员专用装备/FCOLOR=$00FF00>\';
            end;
          60: begin
              sMsg := '<行会掌门人专用装备/FCOLOR=$0000FF>\';
              if g_MySelf.m_sGuildName <> '' then
                sMsg := '<行会掌门人专用装备/FCOLOR=$00FF00>\';
            end;
          7: begin
              sMsg := '<沙巴克成员专用装备/FCOLOR=$0000FF>\';
              if g_MySelf.m_sGuildName <> '' then
                sMsg := '<沙巴克成员专用装备/FCOLOR=$00FF00>\';
            end;
          20, 70: begin
              sMsg := '<沙巴克城主专用装备/FCOLOR=$0000FF>\';
              if g_MySelf.m_sGuildName <> '' then
                sMsg := '<沙巴克城主专用装备/FCOLOR=$00FF00>\';
            end;
          8: begin
              sMsg := '<会员专用装备/FCOLOR=$00FF00>\';
            end;
          81: begin
              sMsg1 := '<' +  '需要会员等级 ≥ ' + IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg2 := '<' +  '需要会员类型 =  ' + IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          82: begin
              sMsg1 := '<' +  '需要会员等级 ≥ ' + IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg2 := '<' +  '需要会员类型 ≥ ' + IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
        end;
      end;
  end;
  Result := sMsg;
end;

function DlgShowText(DSurface: TDirectDrawSurface; X, Y: Integer; Points, DrawList: TList; Msg: string;
  nMaxHeight: Integer; DefaultColor: TColor): integer;
var
  lx, ly, sx, i: integer;
  str, data, fdata, cmdstr, cmdparam, sTemp: string;
  pcp: PTClickPoint;
  d: TDirectDrawSurface;
  boNewPoint: Boolean;

  function ColorText(sStr: string; DefColor: TColor; boDef, boLength: Boolean; var ClickColor: TColor): string;
  var
    sdata, sfdata, scmdstr, scmdparam, scmdcolor: string;
    ii, k: Integer;
    mfid, mx, my: Integer;
    sName, sparam, sMin, sMax: string;
    boMove, boBlend: Boolean;
    boTransparent: Boolean;
    dwTime: LongWord;
    nAlpha, nCount: Integer;
    Idx, nMin, nMax: Integer;
    Color: TColor;
    ShowHint: pTNewShowHint;
    backText: string;
    UserItem: TUserItem;
    Stditem: TStdItem;
    TempList: TStringList;
    DRect: TRect;
    boRect: Boolean;
  begin
    Color := DefColor;
    with DSurface do begin
      backText := '';
      sdata := sStr;
      sfdata := '';
      while (pos('{', sdata) > 0) and (pos('}', sdata) > 0) and (sdata <> '') do begin
        sfdata := '';
        if sdata[1] <> '{' then begin
          sdata := '{' + GetValidStr3(sdata, sfdata, ['{']);
        end;
        scmdparam := '';
        scmdstr := '';
        sdata := ArrestStringEx(sdata, '{', '}', scmdstr);
        if scmdstr <> '' then begin
          scmdparam := GetValidStr3(scmdstr, scmdstr, ['=']);
          scmdcolor := GetValidStr3(scmdparam, scmdparam, ['=']);
        end;
        if sfdata <> '' then begin
          if boLength then begin
            backText := backText + sfdata;
          end
          else begin
            TextOutEx(lx + sx, ly, sfdata, DefColor);
            sx := sx + g_DXCanvas.TextWidth(sfdata);
          end;
          sfdata := '';
        end;
        Color := DefColor;
        if CompareLStr(scmdparam, 'item', length('item')) then begin //new
          SafeFillChar(UserItem, SizeOf(UserItem), #0);
          nCount := 1;
          while True do begin
            if scmdstr = '' then Break;
            scmdstr := GetValidStr3(scmdstr, stemp, [',']);
            if stemp = '' then Break;
            sTemp := LowerCase(stemp);
            sparam := GetValidStr3(stemp, sName, ['.']);
            if (sName <> '') and (sparam <> '') then begin
              case sName[1] of
                'c': nCount := StrToIntDef(sParam, 1);
                'i': UserItem.wIndex := StrToIntDef(sparam, -1) + 1;
                'd': UserItem.TermTime := DateTimeToLongWord(IncDay(g_ServerDateTime, StrToIntDef(sparam, 1)));
                'b': begin
                    case sparam[1] of
                      '0': SetByteStatus(UserItem.btBindMode1, 0, True);
                      '1': SetByteStatus(UserItem.btBindMode1, 1, True);
                      '2': SetByteStatus(UserItem.btBindMode1, 2, True);
                      '3': SetByteStatus(UserItem.btBindMode1, 3, True);
                      '4': SetByteStatus(UserItem.btBindMode1, 4, True);
                      '5': SetByteStatus(UserItem.btBindMode1, 5, True);
                      '6': SetByteStatus(UserItem.btBindMode1, 6, True);
                      '7': SetByteStatus(UserItem.btBindMode1, 7, True);
                      '8': SetByteStatus(UserItem.btBindMode2, 0, True);
                      '9': SetByteStatus(UserItem.btBindMode2, 1, True);
                    end;
                  end;
                'w': begin
                    idx := StrToIntDef(sparam, -1);
                    if idx in [0..5] then 
                      UserItem.Value.btWuXin := idx;
                  end;
                'f': begin
                    idx := StrToIntDef(sparam, -1);
                    if idx in [0..3] then
                      UserItem.Value.btFluteCount := idx;
                  end;
                's': begin
                    idx := StrToIntDef(sparam, -1);
                    if idx in [0, 3, 6, 9, 12, 15, 18] then
                      UserItem.Value.StrengthenInfo.btCanStrengthenCount := idx;
                  end;
                't': begin
                    idx := StrToIntDef(sparam, -1);
                    if (length(sName) >= 2) and (idx >= 0) then begin
                      case sName[2] of
                        '0': begin
                            if idx in [0..(CanStrengthenMax[0] - 1)] then
                              UserItem.Value.StrengthenInfo.btStrengthenInfo[0] := idx;
                          end;
                        '1':begin
                            if idx in [0..(CanStrengthenMax[1] - 1)] then
                              UserItem.Value.StrengthenInfo.btStrengthenInfo[1] := idx;
                          end;
                        '2':begin
                            if idx in [0..(CanStrengthenMax[2] - 1)] then
                              UserItem.Value.StrengthenInfo.btStrengthenInfo[2] := idx;
                          end;
                        '3':begin
                            if idx in [0..(CanStrengthenMax[3] - 1)] then
                              UserItem.Value.StrengthenInfo.btStrengthenInfo[3] := idx;
                          end;
                        '4':begin
                            if idx in [0..(CanStrengthenMax[4] - 1)] then
                              UserItem.Value.StrengthenInfo.btStrengthenInfo[4] := idx;
                          end;
                        '5':begin
                            if idx in [0..(CanStrengthenMax[5] - 1)] then
                              UserItem.Value.StrengthenInfo.btStrengthenInfo[5] := idx;
                          end;
                      end;

                    end;
                  end;
                'v': begin
                    idx := StrToIntDef(sparam, -1);
                    if (length(sName) >= 2) and (idx >= 0) then begin
                      nMax := StrToIntDef(Copy(sName, 2, Length(sName) - 1), -1);
                      if nMax in [Low(UserItem.Value.btValue)..High(UserItem.Value.btValue)] then begin
                        UserItem.Value.btValue[nMax] := idx;
                      end;
                    end;
                  end;
              end;
            end;
          end;
          Stditem := GetStditem(UserItem.wIndex);
          if Stditem.Name <> '' then begin
            if (sm_Superposition in Stditem.StdModeEx) and (StdItem.DuraMax > 1) then UserItem.Dura := nCount
            else UserItem.Dura := StdItem.DuraMax;
            UserItem.DuraMax := StdItem.DuraMax;
            New(ShowHint);
            g_TempList.Clear;
            g_TempList.Add('671');
            SafeFillChar(ShowHint^, SizeOf(TNewShowHint), #0);
            ShowHint.Surfaces := g_WMain99Images;
            ShowHint.IndexList := g_TempList;
            ShowHint.nX := lx + sx;
            ShowHint.nY := ly;
            ShowHint.boTransparent := False;
            ShowHint.Alpha := 255;
            ShowHint.dwTime := 100;
            ShowHint.boBlend := False;
            ShowHint.boMove := False;
            DrawList.Add(ShowHint);
            g_TempList := TStringList.Create;
            TextOutEx(lx + sx + 4, ly + 28, 'x' + IntToStr(nCount), clWhite);
            nMin := Stditem.Looks div 10000;
            nMax := Stditem.Looks mod 10000;
            d := GetBagItemImg(Stditem.Looks);
            if (nMin >= 0) and (nMin <= ITEMCOUNT) and (d <> nil) then begin
              New(ShowHint);
              g_TempList.Clear;
              g_TempList.Add(IntToStr(nMax));
              SafeFillChar(ShowHint^, SizeOf(TNewShowHint), #0);
              ShowHint.Surfaces := g_WBagItems[nMin];
              ShowHint.IndexList := g_TempList;
              ShowHint.nX := lx + sx + (ITEMTABLEWIDTH div 2 - d.Width div 2);
              ShowHint.nY := ly + (ITEMTABLEHEIGHT div 2 - d.Height div 2);
              ShowHint.boTransparent := True;
              ShowHint.Alpha := 255;
              ShowHint.dwTime := 100;
              ShowHint.boBlend := False;
              ShowHint.boMove := False;
              DrawList.Add(ShowHint);
              g_TempList := TStringList.Create;

              if Stditem.Effect > 10 then begin
                New(ShowHint);
                g_TempList.Clear;
                for k := 0 to 19 do
                  g_TempList.Add(IntToStr((Stditem.Effect - 11) * 20 + k));
                SafeFillChar(ShowHint^, SizeOf(TNewShowHint), #0);
                ShowHint.Surfaces := g_WItemEffectImages;
                ShowHint.IndexList := g_TempList;
                ShowHint.nX := lx + sx + (ITEMTABLEWIDTH div 2 - d.Width div 2);
                ShowHint.nY := ly + (ITEMTABLEHEIGHT div 2 - d.Height div 2);
                ShowHint.boTransparent := True;
                ShowHint.Alpha := 255;
                ShowHint.dwTime := 100;
                ShowHint.boBlend := False;
                ShowHint.boMove := False;
                DrawList.Add(ShowHint);
                g_TempList := TStringList.Create;
              end;
            end;
            new(pcp);
            pcp.rc := Rect(lx + sx, ly, lx + sx + ITEMTABLEWIDTH, ly + ITEMTABLEHEIGHT);
            pcp.RStr := '';
            pcp.sstr := '';
            pcp.boNewPoint := False;
            pcp.boItem := True;
            pcp.Item.s := Stditem;
            pcp.Item.UserItem := UserItem;
            Points.Add(pcp);
          end;
        end else
        if CompareLStr(scmdparam, 'img', length('img')) then begin //new
          boTransparent := True;
          boMove := False;
          boBlend := False;
          mfid := -1;
          mx := 0;
          my := 0;
          dwTime := 80;
          nAlpha := 255;
          boRect := False;
          while True do begin
            if scmdstr = '' then Break;
            scmdstr := GetValidStr3(scmdstr, stemp, [',']);
            if stemp = '' then Break;
            sTemp := LowerCase(stemp);
            sparam := GetValidStr3(stemp, sName, ['.']);
            if (sName <> '') and (sparam <> '') then begin
              case sName[1] of
                'f': begin
                    mfid := StrToIntDef(sparam, -1);
                    if not (mfid in [Images_Begin..Images_End]) then
                      mfid := -1;
                  end;
                'i': begin
                    g_TempList.Clear;
                    if ExtractStrings(['+'], [], PChar(sparam), g_TempList) > 0 then begin
                      Idx := 0;
                      while True do begin
                        if Idx >= g_TempList.Count then
                          Break;
                        sTemp := g_TempList[Idx];
                        if pos('-', sTemp) > 0 then begin
                          sMax := GetValidStr3(stemp, sMin, ['-']);
                          nMin := StrToIntDef(sMin, 0);
                          nMax := StrToIntDef(sMax, 0);
                          if (nMin + 1000) < nMax then
                            nMax := nMin + 1000;
                          if nMin = 0 then
                            nMin := nMax;
                          if nMax = 0 then
                            nMax := nMin;
                          if nMin > nMax then
                            nMin := nMax;
                          g_TempList.Delete(Idx);
                          if nMin <> 0 then begin
                            for ii := nMin to nMax do begin
                              g_TempList.Insert(Idx, IntToStr(ii));
                              Inc(idx);
                            end;
                          end;

                        end
                        else
                          Inc(Idx);
                      end;
                    end
                    else
                      g_TempList.Add(sparam);
                  end;
                'x': mx := StrToIntDef(sparam, 0);
                'y': my := StrToIntDef(sparam, 0);
                'b': boBlend := (sparam = '1');
                'p': boTransparent := (sparam = '1');
                'm': boMove := (sparam = '1');
                't': dwTime := StrToIntDef(sparam, 0);
                'a': nAlpha := StrToIntDef(sparam, 255);
                'r': begin
                    TempList := TStringList.Create;
                    if ExtractStrings(['+'], [], PChar(sparam), TempList) > 3 then begin
                      boRect := True;
                      DRect.Left := StrToIntDef(TempList[0], 0);
                      DRect.Top := StrToIntDef(TempList[1], 0);
                      DRect.Right := StrToIntDef(TempList[2], 0);
                      DRect.Bottom := StrToIntDef(TempList[3], 0);
                    end;
                    TempList.Free;
                  end;
              end;
            end;
          end;
          if (mfid > -1) and (g_ClientImages[mfid] <> nil) and (g_TempList.Count > 0) then begin
            if mx = 0 then
              mx := lx + sx;
            if my = 0 then
              my := ly;
            New(ShowHint);
            SafeFillChar(ShowHint^, SizeOf(TNewShowHint), #0);
            ShowHint.Surfaces := g_ClientImages[mfid];
            ShowHint.IndexList := g_TempList;
            ShowHint.nX := mx;
            ShowHint.nY := mY;
            ShowHint.boTransparent := boTransparent;
            ShowHint.Alpha := nAlpha;
            ShowHint.dwTime := dwTime;
            ShowHint.boBlend := boBlend;
            ShowHint.boMove := boMove;
            ShowHint.boRect := boRect;
            ShowHint.Rect := DRect;
            DrawList.Add(ShowHint);
            g_TempList := TStringList.Create;
          end;
          sfdata := '';
          scmdparam := '';
          scmdstr := '';
          Continue;
        end
        else if CompareLStr(scmdparam, 'X', length('X')) then begin //new
          sx := sx + StrToIntDef(scmdstr, 0);
          sfdata := '';
          scmdparam := '';
          scmdstr := '';
          Continue;
        end
        else if CompareLStr(scmdparam, 'Y', length('Y')) then begin //new
          ly := ly + StrToIntDef(scmdstr, 0);
          sfdata := '';
          scmdparam := '';
          scmdstr := '';
          Continue;
        end
        else if CompareText(scmdparam, 'FCO') = 0 then begin
          g_TempList.Clear;
          if ExtractStrings([','], [], PChar(scmdcolor), g_TempList) > 0 then begin
            scmdcolor := g_TempList.Strings[0];
          end;
          Color := GetRGB(Lobyte(StrToIntDef(scmdcolor, 255)));
        end;
        if boDef then
          Color := DefColor;
        if boLength then begin
          backText := backText + scmdstr;
        end
        else begin
          TextOutEx(lx + sx, ly, scmdstr, Color);
          sx := sx + g_DXCanvas.TextWidth(scmdstr);
        end;
      end; //end while
      if sdata <> '' then begin
        if boLength then begin
          backText := backText + sdata;
        end
        else begin
          TextOutEx(x + sx, ly, sdata, DefColor);
          sx := sx + g_DXCanvas.TextWidth(sdata);
        end;
      end;
      Result := backText;
    end;
    ClickColor := Color;
  end;
var
  ClickColor: TColor;
begin
  with DSurface do begin
{$IF Var_Interface =  Var_Default}
    g_DXCanvas.Font.kerning := -1;
    Try
{$IFEND}
      for i := 0 to DrawList.count - 1 do begin
        if pTNewShowHint(DrawList[i]).IndexList <> nil then
          pTNewShowHint(DrawList[i]).IndexList.Free;
        Dispose(pTNewShowHint(DrawList[i]));
      end;
      DrawList.Clear;
      lx := x;
      ly := y;
      str := Msg;
      while TRUE do begin
        if str = '' then
          break;
        str := GetValidStr3(str, data, ['\']);
        if data <> '' then begin
          sx := 0;
          while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do begin
            fdata := '';
            if data[1] <> '<' then begin
              data := '<' + GetValidStr3(data, fdata, ['<']);
            end;
            data := ArrestStringEx(data, '<', '>', cmdstr);
            cmdparam := GetValidStr3(cmdstr, cmdstr, ['/']);
            if fdata <> '' then begin
              ColorText(fdata, DefaultColor, False, False, ClickColor);
              fdata := '';
            end;
            if Length(cmdstr) >= 1 then begin
              boNewPoint := False;
              if cmdstr[1] = '&' then begin
                boNewPoint := True;
                cmdstr := Copy(cmdstr, 2, Length(cmdstr) - 1);
              end;
              if (cmdparam <> '') then begin //new
                if boNewPoint then begin
                  new(pcp);
                  sTemp := ColorText(cmdstr, DefaultColor, False, True, ClickColor);
                  pcp.rc := Rect(lx + sx, ly + 1, lx + sx + DSurface.Width, ly + 20);
                  pcp.rstr := cmdparam;
                  pcp.sstr := sTemp;
                  pcp.boNewPoint := True;
                  pcp.boItem := False;
                  pcp.Color := ClickColor;
                  Points.Add(pcp);
                end else begin
                  new(pcp);
                  sTemp := ColorText(cmdstr, clYellow, False, True, ClickColor);
                  pcp.rc := Rect(lx + sx, ly, lx + sx + g_DXCanvas.TextWidth(sTemp), ly + 14);
                  pcp.RStr := cmdparam;
                  pcp.sstr := sTemp;
                  pcp.boNewPoint := False;
                  pcp.boItem := False;
                  pcp.Color := ClickColor;
                  Points.Add(pcp);
                  Line(lx + sx - 1, ly + g_DXCanvas.TextHeight(sTemp) {+ 1}, g_DXCanvas.TextWidth(sTemp) - 2, clYellow);
                end;
              end;
              if cmdparam = '' then begin
                ColorText(cmdstr, clRed, False, False, ClickColor);
              end
              else begin
                if boNewPoint then begin
                  d := g_WMain99Images.Images[621];
                  if d <> nil then begin
                    CopyTexture(lx + sx, ly + 1, d);
                  end;
                  Inc(ly, NEWPOINTOY);
                  Inc(sx, NEWPOINTOX);
                  ColorText(cmdstr, DefaultColor, False, False, ClickColor);
                  Inc(ly, 4);
                end else
                  ColorText(cmdstr, clYellow, False, False, ClickColor);
              end;
            end;
          end;
          if data <> '' then
            ColorText(data, DefaultColor, False, False, ClickColor);
        end;
        Inc(ly, 16);
        if ly >= nMaxHeight then
          break;
      end;
{$IF Var_Interface =  Var_Default}
    finally
      g_DXCanvas.Font.kerning := -2;
    end;
{$IFEND}
  end;
  Result := ly;
end;


function CCheck(code: Integer): Integer;
begin
  Result := code;
  if code < 0 then
    raise ECompressionError.Create('ZIP Error'); //!!
end;

function DCheck(code: Integer): Integer;
begin
  Result := code;
  if code < 0 then
    raise EDecompressionError.Create('ZIP Error');  //!!
end;

function ZIPCompress(const InBuf: Pointer; InBytes: Integer; Level: TZIPLevel; out OutBuf: PChar): Integer;
var
  strm: TZStreamRec;
  P: Pointer;
begin
  SafeFillChar(strm, sizeof(strm), 0);
  strm.zalloc := zlibAllocMem;
  strm.zfree := zlibFreeMem;
  Result := ((InBytes + (InBytes div 10) + 12) + 255) and not 255;
  GetMem(OutBuf, Result);
  try
    strm.next_in := InBuf;
    strm.avail_in := InBytes;
    strm.next_out := OutBuf;
    strm.avail_out := Result;
    CCheck(deflateInit_(strm, Level, zlib_version, sizeof(strm)));
    try
      while CCheck(deflate(strm, Z_FINISH)) <> Z_STREAM_END do
      begin
        P := OutBuf;
        Inc(Result, 256);
        ReallocMem(OutBuf, Result);
        strm.next_out := PChar(Integer(OutBuf) + (Integer(strm.next_out) - Integer(P)));
        strm.avail_out := 256;
      end;
    finally
      CCheck(deflateEnd(strm));
    end;
    ReallocMem(OutBuf, strm.total_out);
    Result := strm.total_out;
  except
    FreeMem(OutBuf);
    OutBuf := nil;
    //raise
  end;
end;

function ZIPDecompress(const InBuf: Pointer; InBytes: Integer; OutEstimate: Integer; out OutBuf: PChar): Integer;
var
  strm: TZStreamRec;
  P: Pointer;
  BufInc: Integer;
begin
  SafeFillChar(strm, sizeof(strm), 0);
  strm.zalloc := zlibAllocMem;
  strm.zfree := zlibFreeMem;
  BufInc := (InBytes + 255) and not 255;
  if OutEstimate = 0 then
    Result := BufInc
  else
    Result := OutEstimate;
  GetMem(OutBuf, Result);
  try
    strm.next_in := InBuf;
    strm.avail_in := InBytes;
    strm.next_out := OutBuf;
    strm.avail_out := Result;
    DCheck(inflateInit_(strm, zlib_version, sizeof(strm)));
    try
      while DCheck(inflate(strm, Z_FINISH)) <> Z_STREAM_END do
      begin
        P := OutBuf;
        Inc(Result, BufInc);
        ReallocMem(OutBuf, Result);
        strm.next_out := PChar(Integer(OutBuf) + (Integer(strm.next_out) - Integer(P)));
        strm.avail_out := BufInc;
      end;
    finally
      DCheck(inflateEnd(strm));
    end;
    ReallocMem(OutBuf, strm.total_out);
    Result := strm.total_out;
  except
    FreeMem(OutBuf);
    OutBuf := nil;
    //raise
  end;
end;

function GetSpellPoint(Magic: pTNewClientMagic): Integer;
begin
  Result := ROUND(Magic.Def.Magic.wSpell / (Magic.Def.Magic.btTrainLv + 1) * (Magic.Level + 1)) +
    Magic.Def.Magic.btDefSpell;
end;
   {

   nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) +
      LoWord(PlayObject.m_WAbil.MC),
      SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) +
        1);

function MPow(UserMagic: pTUserMagic): Integer;
begin
  Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
end;

function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
begin
  Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
    Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
end;}

function GetSpellPower(Magic: pTNewClientMagic): string;
var
  nMinPower, nMaxPower, nRate: Integer;
begin
  nMinPower := Round(Magic.Def.Magic.wPower / (Magic.Def.Magic.btTrainLv + 1) * (Magic.Level + 1)) +
    Magic.Def.Magic.btDefPower;
  nMaxPower := Round((Magic.Def.Magic.wPower + (Magic.Def.Magic.wMaxPower - Magic.Def.Magic.wPower)) /
    (Magic.Def.Magic.btTrainLv + 1) * (Magic.Level + 1)) +
    (Magic.Def.Magic.btDefPower + (Magic.Def.Magic.btDefMaxPower - Magic.Def.Magic.btDefPower));
  Result := IntToStr(nMinPower) + '-' + IntToStr(nMaxPower);
  if Magic.Def.Magic.btTrainLv = 9 then
  begin
    nRate := Round(Magic.Def.Magic.wPower / (Magic.Def.Magic.btTrainLv + 1) * (Magic.Level + 1));
    Result := IntToStr(Round(Magic.Def.Magic.btDefPower * (1+nRate/100))) + '-'
              + IntToStr(Round(Magic.Def.Magic.btDefMaxPower * (1+nRate/100)))
              + ' <[+' + IntToStr(nRate)+'%]/FCOLOR=$00FF00>';
  end;
  if Magic.Def.Magic.btTrainLv = 20 then
  begin
    if Magic.Def.Magic.btDefPower = 0 then
    begin
      nRate := ROUND(Magic.Def.Magic.btDefMaxPower * (Magic.Level));
      Result := IntToStr(Round(Magic.Def.Magic.wPower * (1+nRate/100))) + '-'
                + IntToStr(Round(Magic.Def.Magic.wMaxPower * (1+nRate/100)))
                + ' <[+' + IntToStr(nRate)+'%]/FCOLOR=$00FF00>';
    end
    else begin
      Result := '人物伤害 <+' + IntToStr(Max(0, Magic.Def.Magic.btDefMaxPower * (Magic.Level+1))) + '%/FCOLOR=$00FF00>';
    end;
  end;
end;

function ShowMagicInfo(PMagic: pTNewClientMagic): string;
  function GetMagicNeedStr(nMyLevel, nMagLevel: Integer): string;
  begin
    if nMyLevel >= nMagLevel then Result := '<' + IntToStr(nMagLevel) + '/FCOLOR=$00FF00>'
    else Result := '<' + IntToStr(nMagLevel) + '/FCOLOR=$0000FF>';
  end;
var
  ShowString: string;
  CMagic: TNewClientMagic;
  DMagic: TClientDefMagic;
  Magic: TMagic;
  nMagID, nLevel: Integer;
begin
  if g_MySelf <> nil then nLevel := g_MySelf.m_Abil.Level
  else nLevel := 0;
  CMagic := PMagic^;
  DMagic := CMagic.Def;
  Magic := DMagic.Magic;
  nMagID := Magic.wMagicId mod 1000;
  if CMagic.Level > Magic.btTrainLv then CMagic.Level := Magic.btTrainLv;
  ShowString := '<' + Magic.sMagicName + '/FCOLOR=' + ITEMNAMECOLOR + '>\ \';
  if nMagID = 100 then begin
      if Magic.nInterval > 0 then begin
        ShowString := ShowString + '连击使用间隔: ';
        ShowString := ShowString + IntToStr(Magic.nInterval div 1000) + '秒\';
      end;
      ShowString := ShowString + '<Line>';
      ShowString := ShowString + '<COLOR=' + HINTDEFCOLOR + '>';
      ShowString := ShowString + '连击释放快捷键';
      ShowString := ShowString + '<ENDCOLOR>\';
  end else begin
    if nMagID in [3, 4, 7, 64] then ShowString := ShowString + '<被动技能/FCOLOR=' + WUXINISMYCOLOR + '>\'
    else ShowString := ShowString + '<主动技能/FCOLOR=' + WUXINISMYCOLOR + '>\';
    ShowString := ShowString + '当前技能等级: ';
    if CMagic.boStudy then begin
      ShowString := ShowString + IntToStr(CMagic.Level) + '\';
      if (Magic.btTrainLv <=9) and (CMagic.Level < Magic.btTrainLv) then
        ShowString := ShowString + '当前技能修为: ' + IntToStr(CMagic.CurTrain) + '\';
    end else begin
      ShowString := ShowString + '未修练\';
    end;
    if Magic.nInterval > 0 then begin
      ShowString := ShowString + '技能使用间隔: ';
      ShowString := ShowString + IntToStr(Magic.nInterval div 1000) + '秒\';
    end;
    case nMagID of
      3,{基本剑术}
      4,{精神力战法}
      12, {刺杀剑术}
      64,
      7 {攻杀剑术}: begin
        end;
     (* 2,{治愈术}
      29 {群体治疗术}: begin
        if CMagic.boStudy then begin
          ShowString := ShowString + ' \<当前等级属性/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<消耗魔法: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
          ShowString := ShowString + '<治愈血量: /FCOLOR=' + ADDVALUECOLOR + '>' + GetSpellPower(@CMagic) +'\';
        end;
        if CMagic.Level < 3 then begin
          Inc(CMagic.Level);
          ShowString := ShowString + ' \<下一等级属性/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<消耗魔法: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
          ShowString := ShowString + '<治愈血量: /FCOLOR=' + ADDVALUECOLOR + '>' + GetSpellPower(@CMagic) +'\';
          Dec(CMagic.Level);
        end;
      end;  *)
      1,
      5,
      9,
      10, {疾光电影}
      11, {雷电术}
      23,
      24, {地狱雷光}
      33, {冰咆哮}
      36, {火焰冰}
      37,
      44,
      45, {灭天火}
      47,
      66,
      67,
      70,
      71,
      72,
      57, {流星火雨}
      114, {双龙破}
      115, {凤舞技}
      116, {惊雷爆}
      117, {冰天雪地}
      118, {虎啸决}
      119, {八卦掌}
      120, {三焰咒}
      121, {万剑归宗}
      13, {灵魂火符}
      53, {噬血术}
      22{火墙}: begin
        if CMagic.boStudy then begin
          ShowString := ShowString + ' \<当前等级属性/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<消耗魔法: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
          ShowString := ShowString + '<技能伤害: /FCOLOR=' + ADDVALUECOLOR + '>' + GetSpellPower(@CMagic) +'\';
        end;
        if CMagic.Level < Magic.btTrainLv then begin
          Inc(CMagic.Level);
          ShowString := ShowString + ' \<下一等级属性/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<消耗魔法: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
          ShowString := ShowString + '<技能伤害: /FCOLOR=' + ADDVALUECOLOR + '>' + GetSpellPower(@CMagic) +'\';
          Dec(CMagic.Level);
        end;
      end;
    else begin
        if CMagic.boStudy then begin
          ShowString := ShowString + ' \<当前等级属性/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<消耗魔法: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
        end;
        if CMagic.Level < Magic.btTrainLv then begin
          Inc(CMagic.Level);
          ShowString := ShowString + ' \<下一等级属性/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<消耗魔法: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
          Dec(CMagic.Level);
        end;
      end;
    end;

    if (Magic.btTrainLv <= 9) and (CMagic.Level < Magic.btTrainLv) then begin
      if CMagic.boStudy then begin
        ShowString := ShowString + ' \<升级技能要求/FCOLOR=' + ADDVALUECOLOR2 + '>\';
        ShowString := ShowString + '<需要人物等级: /FCOLOR=' + ADDVALUECOLOR + '>' +
          GetMagicNeedStr(nLevel, Magic.TrainLevel[CMagic.Level]) + '\';
        ShowString := ShowString + '<需要技能修为: /FCOLOR=' + ADDVALUECOLOR + '>' +
          GetMagicNeedStr(CMagic.CurTrain, Magic.MaxTrain[CMagic.Level]) + '\';
      end else begin
        ShowString := ShowString + ' \<学习技能要求/FCOLOR=' + ADDVALUECOLOR2 + '>\';
        ShowString := ShowString + '<需要人物等级: /FCOLOR=' + ADDVALUECOLOR + '>' +
          GetMagicNeedStr(nLevel, Magic.TrainLevel[CMagic.Level]) + '\';
      end;
    end;

    if DMagic.sDesc <> '' then begin
      ShowString := ShowString + ' \<Line>';
      ShowString := ShowString + '<COLOR=' + HINTDEFCOLOR + '>' + DMagic.sDesc + '<ENDCOLOR>\';
    end;
  end;
  Result := ShowString;
end;

function HorseItemToClientItem(HorseItem: pTHorseItem): TNewClientItem;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.S := GetStditem(HorseItem.wIndex);
  if Result.S.name <> '' then begin
    Result.UserItem := HorseItemToUserItem(HorseItem, @Result.S);
  end;
end;

function CheckItemBindMode(UserItem: pTUserItem; BindMode: TBindMode): Boolean;
var
  ptByte, ptByte2: PByte;
  BindType: Byte;
  I: Integer;
  StdItem: TStdItem;
begin
  Result := False;
  StdItem := GetStdItem(UserItem.wIndex);
  if StdItem.Name = '' then Exit;
  BindType := Ib_NoDeal;
  ptByte := @StdItem.Bind;
  ptByte2 := @UserItem.btBindMode1;
  case BindMode of
    bm_NoDeal: begin
        BindType := Ib_NoDeal;
        ptByte2 := @UserItem.btBindMode1;
      end;
    bm_NoSave: begin
        BindType := Ib_NoSave;
        ptByte2 := @UserItem.btBindMode1;
      end;
    bm_NoRepair: begin
        BindType := Ib_NoRepair;
        ptByte2 := @UserItem.btBindMode1;
      end;
    bm_NoDrop: begin
        BindType := Ib_NoDrop;
        ptByte2 := @UserItem.btBindMode1;
      end;
    bm_NoDown: begin
        BindType := Ib_NoDown;
        ptByte2 := @UserItem.btBindMode1;
      end;
    bm_NoMake: begin
        BindType := Ib_NoMake;
        ptByte2 := @UserItem.btBindMode1;
      end;
    bm_NoSell: begin
        BindType := Ib_NoSell;
        ptByte2 := @UserItem.btBindMode1;
      end;
    bm_DropDestroy: begin
        BindType := Ib_DropDestroy;
        ptByte2 := @UserItem.btBindMode1;
      end;
    bm_Unknown: begin
        BindType := Ib2_Unknown;
        ptByte2 := @UserItem.btBindMode2;
      end;
  end;
  if BindMode = bm_Unknown then begin
    Result := CheckByteStatus(ptByte2^, BindType);
  end else begin
    Result := CheckByteStatus(ptByte^, BindType) or CheckByteStatus(ptByte2^, BindType);
  end;
  if (not Result) and (StdItem.StdMode = tm_House) then begin
    for I := Low(UserItem.HorseItems) to High(UserItem.HorseItems) do begin
      if UserItem.HorseItems[I].wIndex > 0 then begin
        StdItem := GetStdItem(UserItem.HorseItems[I].wIndex);
        if StdItem.Name = '' then Continue;
        if BindMode = bm_Unknown then begin
          Result := CheckByteStatus(UserItem.HorseItems[I].btBindMode2, BindType);
        end else begin
          Result := CheckByteStatus(StdItem.Bind, BindType) or CheckByteStatus(UserItem.HorseItems[I].btBindMode1, BindType);
        end;
      end;
      if Result then break;
    end;
  end;
end;

function GetCompoundInfos(const sItemName: string): pTCompoundInfos;
var
  nIndex: Integer;
begin
  Result := nil;
  nIndex := g_CompoundInfoList.IndexOf(sItemName);
  if nIndex < 0 then
    exit;
  Result := pTCompoundInfos(g_CompoundInfoList.Objects[nIndex]);
end;

initialization
  begin
    g_TempList := TStringList.Create;
  end;

finalization
  begin
    g_TempList.Free;
  end;

end.






