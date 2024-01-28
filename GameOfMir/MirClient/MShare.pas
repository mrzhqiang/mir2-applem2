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
    '����', 'Ʋ��', '��ɫ', '����', '����', '����', '����', '����', '˯��', '���',
    '����', '��ŭ', '��Ƥ', '����', '΢Ц', '�ѹ�', '��', 'ץ��', '����', '͵Ц',
    '�ɰ�', '����', '����', '����', '��', '����', '����', '��Ц', '���', '�ܶ�',
    '����', '����', '��...', '��', '��ĥ', '�ô�', '�ټ�', '���', '��', '����',
    '����', 'ǿ', '��', '����', 'ʤ��'

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
  g_sGoldName: string = '���';
  g_sGameGoldName: string = 'Ԫ��';
  g_sGamePointName: string = '���';
  g_sWarriorName: string = 'սʿ'; //ְҵ����
  g_sWizardName: string = 'ħ��ʦ'; //ְҵ����
  g_sTaoistName: string = '��ʿ'; //ְҵ����
  g_sUnKnowName: string = '';
  g_sBindGoldName: string = '�󶨽��';
  g_sGameDiamondName: string = '����';

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

  g_sWuXinJ: string = '��';
  g_sWuXinM: string = 'ľ';
  g_sWuXinS: string = 'ˮ';
  g_sWuXinH: string = '��';
  g_sWuXinT: string = '��';

  g_sMainParam1: string; //��ȡ���ò���
  g_sMainParam2: string; //��ȡ���ò���
  g_sMainParam3: string; //��ȡ���ò���
  g_sMainParam4: string; //��ȡ���ò���
  g_sMainParam5: string; //��ȡ���ò���
  g_sMainParam6: string; //��ȡ���ò���

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
  g_sServerName: string; //��������ʾ����
  g_sServerMiniName: string; //����������
  g_sServerAddr: string = '127.0.0.1';
  g_nServerPort: Integer = 7000;
  g_sSelChrAddr: string;
  g_nSelChrPort: Integer;
  g_sRunServerAddr: string;
  g_nRunServerPort: Integer;
  g_StditemList: TList;
  g_StditemFiltrateList: TList;


  g_boSendLogin: Boolean; //�Ƿ��͵�¼��Ϣ
  g_boServerConnected: Boolean;
  g_SoftClosed: Boolean; //С����Ϸ
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

  g_CloseAllSys: Boolean; //�ܾ����й�����Ϣ
  g_CloseCrcSys: Boolean; //�ܾ����к�����Ϣ
  g_CloseMySys: Boolean; //�ܾ�����˽����Ϣ
  g_CloseGuildSys: Boolean; //�ܾ������л���Ϣ
  g_AutoSysMsg: Boolean; //�Զ�����
  g_AutoMsg: string[90]; //�Զ���������
  g_AutoMsgTick: LongWord;
  g_AutoMsgTime: LongWord = 10000;

  MAKEITEMCOLOR: string = '$FFFFFF';
  SELLDEFCOLOR: string = '$847CCF'; //�ۼ�Ĭ����ɫ $847CCF
  HINTDEFCOLOR: string = '$FFFFFF'; //��ʾĬ����ɫ $65D16A
  NOTDOWNCOLOR: string = '$99C5E2'; //���ɽ�����ɫ $99C5E2  128/131
  ADDVALUECOLOR: string = '$FF7979'; //��ͨ������ɫ $FF7979   156/155
  ADDVALUECOLOR2: string = '$DA65C0'; //����������ɫ $DA65C0  20/156
  ADDVALUECOLOR3: string = '$DA65C0'; //����������ɫ $DA65C0  20/156
  ITEMNAMECOLOR: string = '$00FFFF';
  SUITITEMCOLOR: string;
  SUITITEMCOLOR2: string;
  WUXINCOLOR: string = '$CF8170';
  WUNXINENABLECOLOR: string = '$828282';
  WUXINISMYCOLOR: string = '$53BD8E';
  HINTCOLOR1: string = '$BE8276';
  HINTCOLOR2: string = '$848385';
  //��װ 145  �ۼ� 67/68

//  g_boFullScreen: Boolean = False;

  //g_ImgMixSurface: TDirectDrawSurface = nil;
  //g_MiniMapSurface: TDirectDrawSurface = nil;

  g_boFirstTime: Boolean;
  g_boInitialize: Boolean;
  g_nInitializePer: Integer;
  //  g_boChangeWin: Boolean;
  g_sMapTitle: string;
  g_nMapMusic: Integer;

  //g_ServerList: TList;

  g_GroupMembers: TList; //���Ա�б�
  g_CustomIcons: TList; //�Զ���ͼ���б�
  g_GroupItemMode: Boolean = False; //��Ʒ����ģʽ
  g_SaveItemList: TList;
  g_MenuItemList: TList;
  g_DropedItemList: TList; //������Ʒ�б�
  g_ChangeFaceReadyList: TList; //
  g_FreeActorList: TList; //�ͷŽ�ɫ�б�
  g_FreeItemList: TList; //�ͷŵ�����Ʒ�б�
  g_SoundList: TStringList; //�����б�

  g_GuildIndex: array[0..4] of Word;
  g_ClientGuildInfo: TClientGuildInfo;
//  g_nBonusPoint: Integer;
 // g_nSaveBonusPoint: Integer;
//  g_BonusTick: TNakedAbility;
//  g_BonusAbil: TNakedAbility;
//  g_NakedAbil: TNakedAbility;
//  g_BonusAbilChg: TNakedAbility;

//  g_sGuildName: string; //�л�����
 // g_sGuildRankName: string; //ְλ����
  g_dwClickNpcTick: LongWord = 0;

  g_boLatestSpell: Boolean;

  g_dwLastAttackTick: LongWord;
  //��󹥻�ʱ��(������������ħ������)
  g_dwLastMoveTick: LongWord; //����ƶ�ʱ��
  g_dwLatestStruckTick: LongWord; //�������ʱ��
  g_dwLatestSpellTick: LongWord; //���ħ������ʱ��
  //g_dwLatestFireHitTick: LongWord; //����л𹥻�ʱ��
  g_dwLatestRushRushTick: LongWord; //����ƶ�ʱ��
  g_dwLatestHitTick: LongWord;
  //���������ʱ��(�������ƹ���״̬�����˳���Ϸ)
  g_dwLatestMagicTick: LongWord;
  //����ħ��ʱ��(�������ƹ���״̬�����˳���Ϸ)

  g_dwMagicDelayTime: LongWord;
  g_dwMagicPKDelayTime: LongWord;

  g_nMouseCurrX: Integer; //������ڵ�ͼλ������X
  g_nMouseCurrY: Integer; //������ڵ�ͼλ������Y
  g_nMouseX: Integer; //���������Ļλ������X
  g_nMouseY: Integer; //���������Ļλ������Y

  g_nTargetX: Integer; //Ŀ������
  g_nTargetY: Integer; //Ŀ������
  g_TargetCret: TActor;
  g_FocusCret: TActor;
  g_MagicTarget: TActor;
  g_MagicLockTarget: TActor;
  g_NPCTarget: TNPCActor;

{$IFDEF DEBUG}
  g_boShowItemID: Boolean = False;
{$ENDIF}
  g_boAttackSlow: Boolean; //��������ʱ����������.
  g_boMoveSlow: Boolean; //���ز���ʱ��������
  g_nMoveSlowLevel: Integer;
  g_boMapMoving: Boolean; //�� �̵���, Ǯ�������� �̵� �ȵ�
  g_boMapMovingWait: Boolean;
  g_boMapInitialize: Boolean;
  //g_boMapOldChange: Boolean;
  g_btMapinitializePos: Byte;
  g_boMapApoise: Boolean;
  g_boCheckBadMapMode: Boolean;
  //�Ƿ���ʾ��ؼ���ͼ��Ϣ(���ڵ���)
  g_boCheckSpeedHackDisplay: Boolean; //�Ƿ���ʾ�����ٶ�����
  g_boShowGreenHint: Boolean = False;
  g_boShowWhiteHint: Boolean;
  g_boViewMiniMapMark: Boolean = False; //�Ƿ���ʾС��ͼ
  g_nViewMinMapLv: Integer = 1;
  //Jacky С��ͼ��ʾģʽ(0Ϊ����ʾ��1Ϊ͸����ʾ��2Ϊ������ʾ)
  g_nMiniMapIndex: Integer; //С��ͼ��
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

  //NPC ���
  g_nCurMerchant, g_nCurMerFlag: Integer; //�ֱٿ� �޴��� ���� ����
  g_nMDlgX: Integer;
  g_nMDlgY: Integer; //�޴��� ���� ��
  g_dwChangeGroupModeTick: LongWord;
  g_dwDealActionTick: LongWord;
  g_dwQueryMsgTick: LongWord;
  g_nDupSelection: Integer;

//  g_boAllowGroup: Boolean;
  //g_boCheckGroup: Boolean;

  //������Ϣ���
  g_nMySpeedPoint: Integer; //����
  g_nMyHitPoint: Integer; //׼ȷ
  g_nMyAntiPoison: Integer; //ħ�����
  g_nMyPoisonRecover: Integer; //�ж��ָ�
  g_nMyHealthRecover: Integer; //�����ָ�
  g_nMySpellRecover: Integer; //ħ���ָ�
  g_nMyAntiMagic: Integer; //ħ�����
  g_nMyAddAttack: Byte;
  g_nMyDelDamage: Byte;
  g_nMyAddWuXinAttack: Byte;
  g_nMyDelWuXInAttack: Byte;
  g_nMyHungryState: Integer; //����״̬
  g_wAvailIDDay: Word;
  g_wAvailIDHour: Word;
  g_wAvailIPDay: Word;
  g_wAvailIPHour: Word;
  g_nDeadliness: Integer;

  //g_MagicList: TList; //�����б�
  g_MagicArry: array[0..SKILL_MAX] of TClientDefMagic;  //ϵͳ���ܱ�
  g_MyMagicArry: array[0..SKILL_MAX] of TNewClientMagic; //�û����ܱ�
  g_nLastMagicIdx: Integer = -1;     //���ʹ�õļ���ID
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
  g_MyDrawActor: THumActor; //δ��
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

  //�������
  g_ToolMenuHook: HHOOK;
  g_nLastHookKey: Integer;
  g_dwLastHookKeyTime: LongWord;

  g_WgHintList: TStringList;

  g_nCaptureSerial: Integer; //ץͼ�ļ������
  g_nSendCount: Integer; //���Ͳ�������
  g_nReceiveCount: Integer; //�ӸĲ���״̬����
  g_nTestSendCount: Integer;
  g_nTestReceiveCount: Integer;
  g_nSpellCount: Integer; //ʹ��ħ������
  g_nSpellFailCount: Integer; //ʹ��ħ��ʧ�ܼ���
  g_nFireCount: Integer; //
  g_nDebugCount: Integer;
  g_nDebugCount1: Integer;
  g_nDebugCount2: Integer;

  //�������
  //g_SellDlgItem: TMovingItem;
  g_SellDlgItemSellWait: TMovingItem;
  g_DealDlgItem: TMovingItem;
  //g_boQueryPrice: Boolean;
  //g_dwQueryPriceTime: LongWord;
  //g_sSellPriceStr: string;

  //�������
  g_DealItems: array[0..MAXDEALITEMCOUNT - 1] of TNewClientItem;
  g_DealRemoteItems: array[0..MAXDEALITEMCOUNT - 1] of TNewClientItem;
  g_nDealGold: Integer;
  g_nDealRemoteGold: Integer;
  g_boDealEnd: Boolean;
  g_boDealLock: Boolean;
  g_sDealWho: string; //���׶Է�����

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
  g_nMyReadShopDlgY: Integer; //�޴��� ���� ��
  //g_MouseItem: TClientItem;
  //g_MouseStateItem: TClientItem;
  //g_MouseUserStateItem: TClientItem; //���� ���콺�� ����Ű�� �ִ� ������

  g_boItemMoving: Boolean; //�����ƶ���Ʒ
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

  //g_boViewFog: Boolean = False; //�Ƿ���ʾ�ڰ�
  //g_boForceNotViewFog: Boolean = True; //������
  //g_nDayBright: Integer;
  g_nAreaStateValue: Integer; //��ʾ��ǰ���ڵ�ͼ״̬(��������)

  //g_boNoDarkness: Boolean;
  //g_nRunReadyCount: Integer; //���ܾ�������������ǰ�����߼�������


  g_dwEatTime: LongWord = 0; //timeout...
  g_dwEatTick: LongWord = 0; //ʹ��ҩƷʱ����
  g_dwDizzyDelayStart: LongWord;
  g_dwDizzyDelayTime: LongWord;

  g_boDoFadeOut: Boolean;
  g_boDoFadeIn: Boolean;
  g_nFadeIndex: Integer;
  g_boDoFastFadeOut: Boolean;
  g_nDander: Word;

  g_boAutoDig: Boolean; //�Զ�����
  g_boSelectMyself: Boolean; //����Ƿ�ָ���Լ�

  //��Ϸ�ٶȼ����ر���
  g_dwFirstServerTime: LongWord;
  g_dwFirstClientTime: LongWord;
  //ServerTimeGap: int64;
  g_nTimeFakeDetectCount: Integer;
  g_dwSHGetTime: LongWord;
  g_dwSHTimerTime: LongWord;
  g_nSHFakeCount: Integer;

  //�������ٶ��쳣�������������4������ʾ�ٶȲ��ȶ�

  //g_nDelMoveTime: LongWord;
  g_dwLatestClientTime2: LongWord;
  g_dwFirstClientTimerTime: LongWord; //timer �ð�
  g_dwLatestClientTimerTime: LongWord;
  g_dwFirstClientGetTime: LongWord; //gettickcount �ð�
  g_dwLatestClientGetTime: LongWord;
  g_nTimeFakeDetectSum: Integer;
  g_nTimeFakeDetectTimer: Integer;

  g_dwLastestClientGetTime: LongWord;

  //��ҹ��ܱ�����ʼ
  g_DeathColorEffect: TColorEffect = ceGrayScale;

  g_boCanStartRun: Boolean = True; //�Ƿ�����������

  g_MagicLockActor: TActor;
  g_boNextTimePowerHit: Boolean;
  g_boCanLongHit: Boolean;
  g_boCanWideHit: Boolean;
  g_boCanCrsHit: Boolean;
  g_boCanTwnHit: Boolean; //�ػ�����ն
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
function ShowItemInfo(Item: TNewClientItem; MoveItemState: TMoveItemState; btNum: array of Integer; showSource: Boolean = True): string;
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
  //WuXinStr: array[1..5] of string = ('[��]', '[ľ]', '[ˮ]', '[��]', '[��]');

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

//ȡ�·�ͼ��

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

//ȡ����ͼ��

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

//ȡNPCͼ��

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

//ȡ��ͼͼ��

function GetObjs(nUnit, nIdx: Integer): TDirectDrawSurface;
begin
  Result := nil;
  if (nUnit >= 0) and (nUnit <= OBJECTSCOUNT) then begin
    Result := g_WObjects[nUnit].Images[nIdx];
  end;
end;

//ȡ��ͼͼ��

function GetObjsEx(nUnit, nIdx: Integer; var px, py: Integer): TDirectDrawSurface;
begin
  Result := nil;
  if (nUnit >= 0) and (nUnit <= OBJECTSCOUNT) then begin
    Result := g_WObjects[nUnit].GetCachedImage(nIdx, px, py);
  end;
end;

//ȡ����ͼ��

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

//ȡ��ְҵ����
//0 ��ʿ
//1 ħ��ʦ
//2 ��ʿ

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
    Result := '��'
  else
    Result := 'Ů';
end;

function GetGuildJobName(rank: Integer): string;
begin
  case rank of
    1: Result := '����';
    2..3: Result := '������';
    4..20: Result := '����';
    21..40: Result := '����';
    41..60: Result := '����';
    61..80: Result := '����';
  else
    Result := '��Ӣ';
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
      DScreen.AddSysMsg('[���С���Ѿ���ɢ��]', clYellow)
    else
      DScreen.AddSysMsg('[���Ѿ��˳�С��]', clYellow);
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

  P: PLongint; //4   ���ֽڵĳ�����ָ��
begin
  P := PLongint(A); //   ȡ��   A   �ĵ�ַ
  if P = nil then
    Exit;
  len := PLongint(PChar(P) - 4)^; //   �����ĳ���   ��ƫ����   -4
  if index >= len then //Ҫɾ����λ�ó�����Χ���˳�
    Exit;
  MaxDelete := len - index; //   ���ɾ��������
  Count := Min(Count, MaxDelete); //   ȡ��һ����Сֵ
  if Count = 0 then //   ��Ҫ��ɾ��
    Exit;
  Dec(len, Count); //   �ƶ���Ҫɾ����λ��
  MoveMemory(PChar(P) + index * elSize, PChar(P) + (index + Count) * elSize, (len - index) * elSize); //�ƶ��ڴ�
  Dec(P); //�Ƴ�   �����鳤�ȡ�λ��
  Dec(P); //�Ƴ������ü�����   λ��
  //�����ٷ�������ڴ�,len   �µĳ���.   Sizeof(Longint)   *   2   =   2*Dec(P)
  ReallocMem(P, len * elSize + Sizeof(Longint) * 2);
  Inc(P); //   ָ�����鳤��
  P^ := len; //   new   length
  Inc(P); //   ָ������Ԫ�أ���ʼ��λ��
  PLongint(A) := P;
end;
 {
function GetItemShowName(Item: TNewClientItem): string;
begin
  Result := Item.s.Name;
  if sm_Arming2 in Item.s.StdModeEx then begin
    if (Item.UserItem.Value.btValue[tb_WuXin] in [1..5]) then
      Result := Item.s.Name + ' ��' + GetWuXinName(Item.UserItem.Value.btValue[tb_WuXin]) + '��'
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
    Result := 1;    //ͼ���С���ϸ�
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
        //��ͼ��ת����JPEGѹ������ת��ΪBMP,��֪��ΪʲôҪ����������,��Ȼ�ᱨ JPEG error #42 �Ĵ���,������~~
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
    Result := 0;     //��ͼ���ļ�
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
        HDInfo.sShowName := '����';
        HDInfo.boChange := False;
        HDInfo.sName := '����';
        HDInfo.sPlace := CheckFilePath(sStr);
        HDInfo.nImageID := GetHDInfoImage(HIT_Desktop);
        HDInfo.nLevel := 1;
        g_MasterHDInfoList.Add(HDInfo);
      end;
      sStr := Reg.ReadString('Personal');
      if sStr <> '' then begin
        New(HDInfo);
        HDInfo.HDInfoType := HIT_Personal;
        HDInfo.sShowName := '�ҵ��ĵ�';
        HDInfo.boChange := False;
        HDInfo.sName := '�ҵ��ĵ�';
        HDInfo.sPlace := CheckFilePath(sStr);
        HDInfo.nImageID := GetHDInfoImage(HIT_Personal);
        HDInfo.nLevel := 1;
        g_MasterHDInfoList.Add(HDInfo);
      end;
      sStr := Reg.ReadString('My Pictures');
      if sStr <> '' then begin
        New(HDInfo);
        HDInfo.HDInfoType := HIT_Pictures;
        HDInfo.sShowName := '�ҵ�ͼƬ';
        HDInfo.boChange := False;
        HDInfo.sName := '�ҵ�ͼƬ';
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
        then sStr := '���ش���'
        else sStr := StrPas(Volname);    //CheckFileNameLen
        if sStr = '' then sStr := '���ش���';
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

//20091104�޸�
function ShowItemInfo(Item: TNewClientItem; MoveItemState: TMoveItemState; btNum: array of Integer; showSource: Boolean = True): string;
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
    //sNeedStr := '<��������' + '/FCOLOR=' + NOTDOWNCOLOR + '>\';
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
        Result := sStr + '��' + sAddStr;
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
  HorseItemNames: array[0..4] of String[4] = ('����', '����', '��', 'װ��', '�Ŷ�');
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
      sGoldStr := '<���򵥼�: ' + GetGoldStr(btNum[0]) + ' ';
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
      AddShowString := '<���۵���: ' + GetGoldStr(btNum[0]) + ' ';
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
      AddShowString := '<�չ�����: ' + GetGoldStr(btNum[0]) + ' ';
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
              ShowString := ShowString + '<�����ͼ��' + Item.UserItem.Value.sMapDesc + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              ShowString := ShowString + '<�������꣺' + IntToStr(Item.UserItem.Value.wCurrX) + ',' +
                IntToStr(Item.UserItem.Value.wCurrY) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
            end else begin
              ShowString := ShowString + '<��δʹ��/FCOLOR=' + ADDVALUECOLOR2 + '>\';
            end;
            ShowString := ShowString + GetItemNeedStr(@Item);
          end else
          if Item.s.Shape = 14 then begin
            ShowString := ShowString + ' \�Ի���Ȼ�ɳ��㣺' + IntToStr(Item.s.DuraMax) + ' ��\';
            ShowString := ShowString + '��þ���ֵ��' + IntToStr(Item.s.Source * Item.s.Reserved) + '\';
            ShowString := ShowString + GetItemNeedStr(@Item);
          end else
          if Item.s.Shape = 15 then begin
            ShowString := ShowString + ' \�����лὨ��ֵ��' + IntToStr(Item.s.Source) + ' ��\';

            ShowString := ShowString + GetItemNeedStr(@Item);
          end else
          if Item.s.Shape = 17 then begin
            ShowString := ShowString + ' \��þ���ֵ��' + IntToStr(Item.s.Source * 1000) + '\';
            ShowString := ShowString + GetItemNeedStr(@Item);
          end else
          if Item.s.Shape = 18 then begin
            ShowString := ShowString + ' \��ԭ���Ե㣺' + IntToStr(Item.s.DuraMax) + '\';
            ShowString := ShowString + GetItemNeedStr(@Item);
          end else begin
            sNeedStr := GetItemNeedStr(@Item);
            if sNeedStr <> '' then
              ShowString := ShowString + ' \' + sNeedStr;
          end;
        end;
      tm_Drug: begin //ҩƷ
          ShowString := ShowString + ' \';
          if Item.S.nAC > 0 then
            ShowString := ShowString + '�ָ�HP ' + IntToStr(Item.S.nAC) + ' ��\';
          if Item.S.nMAC > 0 then
            ShowString := ShowString + '�ָ�MP ' + IntToStr(Item.S.nMAC) + ' ��\';
          ShowString := ShowString + GetItemNeedStr(@Item);
        end;
      tm_Restrict: begin //�����Ʒ
          if Item.S.StdMode = tm_Restrict then begin
            if Item.S.Shape = 9 then begin
              ShowString := ShowString + ' \�޸�װ���־� ' +
                IntToStr(Round(Item.UserItem.dura / 100)) + ' ��\'
            end
            else begin
              if mis_bottom in MoveItemState then begin
                ShowString := ShowString + ' \ʣ�� ' + IntToStr(Item.UserItem.Dura) + ' ��\';
              end else
                ShowString := ShowString + ' \ʣ�� ' + GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' ��\';
            end;
          end;
          ShowString := ShowString + GetItemNeedStr(@Item);
        end;
      tm_Rock: begin //��Ѫʯ��
          ShowString := ShowString + ' \���� ' + IntToStr(Item.S.Weight) + '\';
          case Item.S.Shape of
            0: ShowString := ShowString + 'ʣ�� ' +
              GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' ��\';
            1: ShowString := ShowString + '�ָ�HP ' +
              GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' ��\';
            2: ShowString := ShowString + '�ָ�MP ' +
              GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' ��\';
            3: ShowString := ShowString + '�ָ�HP��MP ' +
              GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' ��\';
          end;
        end;
      tm_Book: {// ������} begin
          case Item.S.Shape of
            0: begin
                ShowString := ShowString + ' \��ʿ�ؼ�\';
              end;
            1: begin
                ShowString := ShowString + ' \��ʦ�ؼ�\';
              end;
            2: begin
                ShowString := ShowString + ' \��ʿ�ؼ�\';
              end;
            3: begin
                ShowString := ShowString + ' \�ϻ��ؼ�\';
              end;
          end;
          ShowString := ShowString + GetNeedStr(@Item);
        end;
      tm_Amulet: {����} begin
          ShowString := ShowString + ' \���� ' + IntToStr(Item.S.Weight) + '\';
          case Item.S.Shape of
            5: ShowString := ShowString + 'ʣ�� ' +
              GetDura1Str(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' ��\';
            1, 2: ShowString := ShowString + 'ʣ�� ' +
              GetDura1Str(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' ��\';
          end;
        end;
      tm_Cowry: begin
          ShowString := ShowString + ' \���� ' + IntToStr(Item.S.Weight) + '\';
          if Item.s.Shape = 0 then begin
            ShowString := ShowString + 'ʣ�� ' + GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax) + ' ��\';
          end;
        end;
      tm_Ore: begin
          ShowString := ShowString + ' \���� ' + IntToStr(Round(Item.UserItem.Dura / 1000)) + '\';
        end;
      tm_Open: begin
          sNeedStr := GetItemNeedStr(@Item);
          if sNeedStr <> '' then
            ShowString := ShowString + ' \' + sNeedStr;
        end;
      tm_MakeStone: begin

          //ShowString := ShowString + '����: ' + IntToStr(Item.S.Weight) + '\ \';
          case Item.s.Shape of
            0: begin
              ShowString := ShowString + ' \';
              ShowString := ShowString + '<ǿ������/FCOLOR=' + NOTDOWNCOLOR + '>\';
              ShowString := ShowString + '<ǿ���ɹ�����: +' + IntToStr(Item.s.Reserved) +
                  '%/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              ShowString := ShowString + '<ǿ���ɹ����װ���ȼ�: +1/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              if item.s.AniCount > 0 then
                ShowString := ShowString + '<ǿ��ʧ�ܽ���װ��ǿ���ȼ�����: +' + IntToStr(item.s.AniCount) +
                  '%/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              if item.s.Source > 0 then
                ShowString := ShowString + '<ǿ��ʧ��װ���������: +' + IntToStr(item.s.Source) +
                  '%/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              ShowString := ShowString + ' \';
              ShowString := ShowString + '<ǿ��ʹ��Ҫ��/FCOLOR=' + NOTDOWNCOLOR + '>\';
              if Item.s.Need > 0 then
                ShowString := ShowString + '<װ��ǿ���ȼ����ڻ����: +' + IntToStr(Item.s.Need) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              ShowString := ShowString + '<װ��ǿ���ȼ�С�ڻ����: +' + IntToStr(Item.s.NeedLevel) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
            end;
            2, 4: begin
              ShowString := ShowString + ' \';
              ShowString := ShowString + '<��ʯ����/FCOLOR=' + NOTDOWNCOLOR + '>\';
              ShowString := ShowString + '<��߳ɹ�����: +' + IntToStr(Item.s.Reserved) + '%/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              //ShowString := ShowString + '<������ǿ��װ����������Ʒ��װ������ʱʹ��/FCOLOR=' + ADDVALUECOLOR2 + '>\';
            end;
            1: begin
              //ShowString := ShowString + '<ǿ��װ��ʱʹ�ã�����װ����������/FCOLOR=' + WUXINISMYCOLOR + '>\';
            end;
            3: begin
              ShowString := ShowString + ' \';
              ShowString := ShowString + '<��ʯ����/FCOLOR=' + NOTDOWNCOLOR + '>\';
              case Item.s.AniCount of
                1: ShowString := ShowString + '<����  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                2: ShowString := ShowString + '<ħ��  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                3: ShowString := ShowString + '<����  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                4: ShowString := ShowString + '<ħ��  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                5: ShowString := ShowString + '<����  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                6: ShowString := ShowString + '<����ֵ  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
                7: ShowString := ShowString + '<ħ��ֵ  +' + IntToStr(Item.s.Source) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\';
              end;
              ShowString := ShowString + ' \<��ǶҪ��/FCOLOR=' + NOTDOWNCOLOR + '>\';
              if Item.s.Need > 0 then
                ShowString := ShowString + '<װ��ǿ���ȼ����ڻ����: +' + IntToStr(Item.s.Need) + '/FCOLOR=' + ADDVALUECOLOR2 + '>\'
              else
                ShowString := ShowString + '<�������κ��а��۵�װ��/FCOLOR=' + ADDVALUECOLOR2 + '>\';
            end;
            9: begin
            
            end;
          end;
        end;
      {tm_ResetStone: begin
        ShowString := ShowString + ' \<COLOR=$00FFFF>';
        ShowString := ShowString + 'ӵ��Ů�������������������ˢ��װ����Ʒ���Ե�\';
        ShowString := ShowString + 'ʹ�÷���\';
        ShowString := ShowString + '�Ҽ������ñ�ʯ��Ȼ�������������װ��';
        ShowString := ShowString + '<ENDCOLOR>\'
      end;   }
      tm_House: begin
          ShowString := '<' + Item.S.name + '/FCOLOR=' + sNameColor + '>\';

          ShowString := ShowString + '<Height>';
          ShowString := ShowString + '����        ' + IntToStr(Item.S.Weight) + '\';

          GetHorseLevelAbility(@Item.UserItem, @Item.S, AddAbility);
          for I := Low(Item.UserItem.HorseItems) to High(Item.UserItem.HorseItems) do begin
            if Item.UserItem.HorseItems[I].wIndex > 0 then begin
              StdItem := GetStditem(Item.UserItem.HorseItems[I].wIndex);
              if StdItem.Name <> '' then
                GetHorseAddAbility(@Item.UserItem, @StdItem, I, AddAbility);
            end;
          end;

          ShowString := ShowString + '����ȼ�    ' + IntToStr(Item.UserItem.btLevel) + '\';
          if Item.UserItem.btAliveTime > 0 then ShowString := ShowString + '����״̬    <������ ' + IntToStr(Item.UserItem.btAliveTime) + '���Ӻ��Զ�����/FCOLOR=$C0C0C0>\'
          else ShowString := ShowString + '����״̬    <����/FCOLOR=$00FF00>\';
          ShowString := ShowString + '���ﾭ��    ' + IntToStr(Item.UserItem.dwExp) + '/' + IntToStr(Item.UserItem.dwMaxExp) + '\';

          ShowString := ShowString + ' \';
          if (AddAbility.AC > 0) or (AddAbility.AC2 > 0) then
            ShowString := ShowString + '�������    ' + GetStrSpace(IntToStr(AddAbility.AC) + '-' + IntToStr(AddAbility.AC2)) + '\';

          if (AddAbility.MAC > 0) or (AddAbility.MAC2 > 0) then
            ShowString := ShowString + '����ħ��    ' + GetStrSpace(IntToStr(AddAbility.MAC) + '-' + IntToStr(AddAbility.MAC2)) + '\';

          if (AddAbility.DC > 0) or (AddAbility.DC2 > 0) then
            ShowString := ShowString + '���﹥��    ' + GetStrSpace(IntToStr(AddAbility.DC) + '-' + IntToStr(AddAbility.DC2)) + '\';


          if (AddAbility.wHitPoint > 0) then
            ShowString := ShowString + '<����׼ȷ    /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(IntToStr(AddAbility.wHitPoint)) + '\';

          if (Item.s.SpeedPoint > 0) or (Item.UserItem.Value.btValue[tb_Speed] > 0) then
            ShowString := ShowString + '<��������    /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(IntToStr(AddAbility.wSpeedPoint)) + '\';


          if (AddAbility.HP > 0) then
            ShowString := ShowString + '<��������ֵ  /FCOLOR=' + ADDVALUECOLOR3 + '>'  + GetStrSpace(IntToStr(AddAbility.HP)) + '\';

          ShowString := ShowString + GetNeedStr(@Item, '  ');


          ShowString := ShowString + ' \����װ��\';

          for I := Low(Item.UserItem.HorseItems) to High(Item.UserItem.HorseItems) do begin
            ShowString := ShowString + '<  [' + HorseItemNames[I] + ']  ';
            if Item.UserItem.HorseItems[I].wIndex > 0 then begin
              ShowString := ShowString + '  ' + GetStditem(Item.UserItem.HorseItems[I].wIndex).Name + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '  δװ��' + '/FCOLOR=' + HINTCOLOR2 + '>\';
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
          ShowString := '<' + sNeedStr + ' (����ר��װ��)/FCOLOR=' + sNameColor + '>\ \';


          ShowString := ShowString + '<Height>';
          ShowString := ShowString + '����      ' + IntToStr(Item.S.Weight) + '\';
          ShowString := ShowString + '�־�      ' + GetStrSpace(GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax));
          
          TempInt := Item.UserItem.DuraMax - Item.s.DuraMax;
          if TempInt > 500 then begin
            TempInt := Round(TempInt / 1000);
            ShowString := ShowString + '<[+' + IntToStr(TempInt) + ']/FCOLOR=$63CEFF>\';
          end else ShowString := ShowString + '\';

          if (Item.S.nAC > 0) or (Item.S.nAC2 > 0) or
            (item.UserItem.Value.btValue[tb_AC] > 0) or
            (item.UserItem.Value.btValue[tb_AC2] > 0) then
            ShowString := ShowString + '����      ' + GetStrSpace(GetJPStr(Item.S.nAC, tb_AC) + '-' +
              GetJPStr(Item.S.nAC2, tb_AC2)) + GetJPStrEx(itValue[tb_AC2]) + '\';

          if (Item.S.nMAC > 0) or (Item.S.nMAC2 > 0) or
            (item.UserItem.Value.btValue[tb_MAC] > 0) or (item.UserItem.Value.btValue[tb_MAC2] > 0) then
            ShowString := ShowString + 'ħ��      ' + GetStrSpace(GetJPStr(Item.S.nMaC, tb_MAC) + '-' +
              GetJPStr(Item.S.nMAC2, tb_MAC2)) + GetJPStrEx(itValue[tb_MAC2]) + '\';

          if (Item.S.nDC > 0) or (Item.S.nDC2 > 0) or
            (item.UserItem.Value.btValue[tb_DC] > 0) or (item.UserItem.Value.btValue[tb_DC2] > 0) then
            ShowString := ShowString + '����      ' + GetStrSpace(GetJPStr(Item.S.nDC, tb_DC)
              + '-' + GetJPStr(Item.S.nDC2, tb_DC2)) + GetJPStrEx(itValue[tb_DC2]) + '\';


          if (Item.s.HitPoint > 0) or (Item.UserItem.Value.btValue[tb_Hit] > 0) then
            ShowString := ShowString + '<׼ȷ      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBTStr2(Item.S.HitPoint, tb_Hit)) + GetJPStrEx(itValue[tb_Hit]) + '\';

          if (Item.s.SpeedPoint > 0) or (Item.UserItem.Value.btValue[tb_Speed] > 0) then
            ShowString := ShowString + '<����      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBTStr2(Item.S.SpeedPoint, tb_Speed)) + GetJPStrEx(itValue[tb_Speed]) + '\';


          if (Item.S.HP > 0) or (item.UserItem.Value.btValue[tb_HP] > 0) then
            ShowString := ShowString + '<����ֵ    /FCOLOR=' + ADDVALUECOLOR3 +
              '>'  + GetStrSpace(GetJPStr2(Item.S.HP, tb_HP)) + GetJPStrEx(itValue[tb_HP]) + '\';


          ShowString := ShowString + GetNeedStr(@Item);
          if CheckByteStatus(Item.UserItem.btBindMode2, Ib2_Unknown) then
            ShowString := ShowString + '<δ����/FCOLOR=' + ITEMNAMECOLOR + '>\';

          if (g_UseItems[U_HOUSE].S.Name <> '') and (g_UseItems[U_HOUSE].UserItem.btLevel >= Item.S.NeedLevel) then
            ShowString := ShowString + '<' + '��Ҫ����ȼ� ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\'
          else ShowString := ShowString + '<' + '��Ҫ����ȼ� ' + AddStr + IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
          

         { sMsg := '<' + '��Ҫ�ȼ� ' + AddStr + IntToStr(Item.S.DuraMax) + '/FCOLOR=$0000FF>\';
        case Item.S.Shape of
          0: begin
              if (MyJob = 0) and (m_Abil.Level >= Item.S.DuraMax) then
                sMsg := '<' + '��Ҫ�ȼ� ' + AddStr +  IntToStr(Item.S.DuraMax) + '/FCOLOR=$00FF00>\';
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
            //ȡ��Ƕ��ʯ����
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
            //ȡǿ��װ������
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

            {ShowString := '<' + sNeedStr + '/FCOLOR=' + ITEMNAMECOLOR + '> <��' +
              GetWuXinName(Item.UserItem.Value.btWuXin) + '��/FCOLOR=$' +
              IntToHex(GetWuXinColor(Item.UserItem.Value.btWuXin), 0) + '> ' + TempStr + '\';   }
              //WuXinStr[Item.UserItem.Value.btValue[tb_WuXin]]

            ShowString := ShowString + ' \';
            //'<img=f.3,t.150,i.462-467><img=f.3,t.150,i.462-467><img=f.3,t.150,i.462-467>\ \';
          end else begin
            ShowString := '<' + sNeedStr + '/FCOLOR=' + sNameColor + '>\ \'
          end;

          ShowString := ShowString + '<Height>';
          ShowString := ShowString + '����      ' + IntToStr(Item.S.Weight) + '\';
          if (mis_CompoundItemAdd in MoveItemState) then
            ShowString := ShowString + '�ϳɵȼ�  ' + IntToStr(Item.UserItem.ComLevel) + '\';
          ShowString := ShowString + '�־�      ' + GetStrSpace(GetDuraStr(Item.UserItem.Dura, Item.UserItem.DuraMax));

          TempInt := Item.UserItem.DuraMax - Item.s.DuraMax;
          if TempInt > 500 then begin
            TempInt := Round(TempInt / 1000);
            ShowString := ShowString + '<[+' + IntToStr(TempInt) + ']/FCOLOR=$63CEFF>\';
          end else ShowString := ShowString + '\';

         { ShowString := ShowString + '����      45-535  [+15]\';
          ShowString := ShowString + '����ֵ    +200    [+200]\';
          ShowString := ShowString + '����һ��  +100%   [+10%]\';        }
          if (Item.S.nAC > 0) or (Item.S.nAC2 > 0) or
            (item.UserItem.Value.btValue[tb_AC] > 0) or
            (item.UserItem.Value.btValue[tb_AC2] > 0) then
            ShowString := ShowString + '����      ' + GetStrSpace(GetJPStr(Item.S.nAC, tb_AC) + '-' +
              GetJPStr(Item.S.nAC2, tb_AC2)) + GetJPStrEx(itValue[tb_AC2]) + '\';

          if (Item.S.nMAC > 0) or (Item.S.nMAC2 > 0) or
            (item.UserItem.Value.btValue[tb_MAC] > 0) or (item.UserItem.Value.btValue[tb_MAC2] > 0) then
            ShowString := ShowString + 'ħ��      ' + GetStrSpace(GetJPStr(Item.S.nMaC, tb_MAC) + '-' +
              GetJPStr(Item.S.nMAC2, tb_MAC2)) + GetJPStrEx(itValue[tb_MAC2]) + '\';

          if (Item.S.nDC > 0) or (Item.S.nDC2 > 0) or
            (item.UserItem.Value.btValue[tb_DC] > 0) or (item.UserItem.Value.btValue[tb_DC2] > 0) then
            ShowString := ShowString + '����      ' + GetStrSpace(GetJPStr(Item.S.nDC, tb_DC)
              + '-' + GetJPStr(Item.S.nDC2, tb_DC2)) + GetJPStrEx(itValue[tb_DC2]) + '\';

          if (Item.S.nMC > 0) or (Item.S.nMC2 > 0) or
            (item.UserItem.Value.btValue[tb_MC] > 0) or (item.UserItem.Value.btValue[tb_MC2] > 0) then
            ShowString := ShowString + 'ħ��      ' + GetStrSpace(GetJPStr(Item.S.nMC, tb_MC)
              + '-' + GetJPStr(Item.S.nMC2, tb_MC2)) + GetJPStrEx(itValue[tb_MC2]) + '\';

          if (Item.S.nSC > 0) or (Item.S.nSC2 > 0) or
            (item.UserItem.Value.btValue[tb_SC] > 0) or (item.UserItem.Value.btValue[tb_SC2] > 0) then
            ShowString := ShowString + '����      ' + GetStrSpace(GetJPStr(Item.S.nSC, tb_SC)
              + '-' + GetJPStr(Item.S.nSC2, tb_SC2)) + GetJPStrEx(itValue[tb_SC2]) + '\';

          {if (Item.s.Dunt > 0) or (Item.UserItem.Value.btValue[tb_Dunt] > 0) then
            ShowString := ShowString + '<����һ��: /FCOLOR=' + ADDVALUECOLOR2
              + '>' + GetJPBTStr5(Item.S.Dunt, tb_Dunt) + '\'; }

          if (Item.s.HitPoint > 0) or (Item.UserItem.Value.btValue[tb_Hit] > 0) then
            ShowString := ShowString + '<׼ȷ      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBTStr2(Item.S.HitPoint, tb_Hit)) + GetJPStrEx(itValue[tb_Hit]) + '\';

          if (Item.s.SpeedPoint > 0) or (Item.UserItem.Value.btValue[tb_Speed] > 0) then
            ShowString := ShowString + '<����      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBTStr2(Item.S.SpeedPoint, tb_Speed)) + GetJPStrEx(itValue[tb_Speed]) + '\';

          if (Item.s.Strong > 0) or (Item.UserItem.Value.btValue[tb_Strong] > 0) then
            ShowString := ShowString + '<ǿ��      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBTStr2(Item.S.Strong, tb_Strong)) + GetJPStrEx(itValue[tb_Strong]) + '\';

          TempInt := LoByte(Item.s.Luck) + Item.UserItem.Value.btValue[tb_Luck] - Item.UserItem.Value.btValue[tb_UnLuck];
          if TempInt > 0 then
            ShowString := ShowString + '<����      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBtStr6(TempInt, tb_Luck, tb_UnLuck)) + GetJPStrEx(itValue[tb_Luck] - itValue[tb_UnLuck]) + '\'
          else if TempInt < 0 then
            ShowString := ShowString + '<����      /FCOLOR=' + ADDVALUECOLOR3 + '>' + GetStrSpace(GetJPBtStr6(-TempInt, tb_Luck, tb_UnLuck)) + GetJPStrEx(-(itValue[tb_Luck] - itValue[tb_UnLuck])) + '\';

          if (Item.S.HP > 0) or (item.UserItem.Value.btValue[tb_HP] > 0) then
            ShowString := ShowString + '<����ֵ    /FCOLOR=' + ADDVALUECOLOR3 +
              '>'  + GetStrSpace(GetJPStr2(Item.S.HP, tb_HP)) + GetJPStrEx(itValue[tb_HP]) + '\';
          if (Item.S.MP > 0) or (item.UserItem.Value.btValue[tb_MP] > 0) then
            ShowString := ShowString + '<ħ��ֵ    /FCOLOR=' + ADDVALUECOLOR3 +
              '>' + GetStrSpace(GetJPStr2(Item.S.MP, tb_MP)) + GetJPStrEx(itValue[tb_MP]) + '\';

         { TempByte := Item.S.HitSpeed + Item.UserItem.Value.btValue[tb_HitSpeed];
          if (TempByte > 0) then begin
            ShowString := ShowString + '<�����ٶ�: /FCOLOR=' + ADDVALUECOLOR2
              + '>' + GetJPBTStr4(TempByte, tb_HitSpeed) + '\'
          end;    }

          if (Item.s.AntiMagic > 0) or (Item.UserItem.Value.btValue[tb_AntiMagic] > 0) then
            ShowString := ShowString + '<ħ�����  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr3(Item.S.AntiMagic, tb_AntiMagic)) + GetJPStrEx2(itValue[tb_AntiMagic]) + '\';

          if (Item.s.PoisonMagic > 0) or (Item.UserItem.Value.btValue[tb_PoisonMagic] > 0) then
            ShowString := ShowString + '<������  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr3(Item.S.PoisonMagic, tb_PoisonMagic)) + GetJPStrEx2(itValue[tb_PoisonMagic]) + '\';

          if (Item.s.HealthRecover > 0) or (Item.UserItem.Value.btValue[tb_HealthRecover] > 0) then
            ShowString := ShowString + '<�����ָ�  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr3(Item.S.HealthRecover, tb_HealthRecover)) + GetJPStrEx2(itValue[tb_HealthRecover]) + '\';

          if (Item.s.SpellRecover > 0) or (Item.UserItem.Value.btValue[tb_SpellRecover] > 0) then
            ShowString := ShowString + '<ħ���ָ�  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr3(Item.S.SpellRecover, tb_SpellRecover)) + GetJPStrEx2(itValue[tb_SpellRecover]) + '\';

          if (Item.s.PoisonRecover > 0) or (Item.UserItem.Value.btValue[tb_PoisonRecover] > 0) then
            ShowString := ShowString + '<����ָ�  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr3(Item.S.PoisonRecover, tb_PoisonRecover)) + GetJPStrEx2(itValue[tb_PoisonRecover]) + '\';

         { if (Item.s.StdMode <> tm_House) and (Item.UserItem.Value.btWuXin <> 0) and
            ((Item.s.AddWuXinAttack > 0) or (Item.s.DelWuXinAttack > 0) or
             (Item.UserItem.Value.btValue[tb_AddWuXinAttack] > 0) or
             (Item.UserItem.Value.btValue[tb_DelWuXinAttack] > 0)) then begin
            if (Item.s.DelWuXinAttack > 0) or (Item.UserItem.Value.btValue[tb_DelWuXinAttack] > 0) then begin
              if CheckWuXinConsistent(Item.UserItem.Value.btWuXin, MyWuXin) then
                ShowString := ShowString + '<���з���  /FCOLOR=' + ADDVALUECOLOR3
                  + '>' + GetJPBTStr5(Item.s.DelWuXinAttack, tb_DelWuXinAttack) + '\';
            end;
            if (Item.s.AddWuXinAttack > 0) or (Item.UserItem.Value.btValue[tb_AddWuXinAttack] > 0) then begin
              if CheckWuXinConsistent(MyWuXin, Item.UserItem.Value.btWuXin) then
                ShowString := ShowString + '<�����˺�  /FCOLOR=' + ADDVALUECOLOR3
                  + '>' + GetJPBTStr5(Item.s.AddWuXinAttack, tb_AddWuXinAttack) + '\';
            end;
          end;   }

          if (Item.s.AddAttack > 0) or (Item.UserItem.Value.btValue[tb_AddAttack] > 0) then
            ShowString := ShowString + '<�˺��ӳ�  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr5(Item.S.AddAttack, tb_AddAttack)) + GetJPStrEx3(itValue[tb_AddAttack]) + '\';

          if (Item.s.DelDamage > 0) or (Item.UserItem.Value.btValue[tb_DelDamage] > 0) then
            ShowString := ShowString + '<�˺�����  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr5(Item.S.DelDamage, tb_DelDamage)) + GetJPStrEx3(itValue[tb_DelDamage]) + '\';

          if (Item.s.Deadliness > 0) or (Item.UserItem.Value.btValue[tb_Deadliness] > 0) then
            ShowString := ShowString + '<����һ��  /FCOLOR=' + ADDVALUECOLOR3
              + '>' + GetStrSpace(GetJPBTStr5(Item.S.Deadliness, tb_Deadliness)) + GetJPStrEx3(itValue[tb_Deadliness]) + '\';

          ShowString := ShowString + GetNeedStr(@Item);
          if sm_ArmingStrong in Item.s.StdModeEx then begin
            if CheckByteStatus(Item.UserItem.btBindMode2, Ib2_Unknown) then
              ShowString := ShowString + '<δ����/FCOLOR=' + ITEMNAMECOLOR + '>\';
          end;

          (*
          sNeedStr := '';
          if (itValue[tb_Hit] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_Hit]) + ' ׼ȷ' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_Speed] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_Speed]) + ' ����' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_Strong] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_Strong]) + ' ǿ��' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          TempInt := itValue[tb_Luck] - itValue[tb_UnLuck];
          if TempInt > 0 then
            sNeedStr := sNeedStr + '<+' + IntToStr(TempInt) + ' ����' + '/FCOLOR=' + ADDVALUECOLOR + '>\'
          else if TempInt < 0 then
            sNeedStr := sNeedStr + '<+' + IntToStr(-TempInt) + ' ����' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_HP] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_HP]) + ' ����ֵ' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_MP] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_MP]) + ' ħ��ֵ' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          TempInt := Item.UserItem.DuraMax - Item.s.DuraMax;
          if TempInt > 500 then begin
            TempInt := Round(TempInt / 1000);
            sNeedStr := sNeedStr + '<+' + IntToStr(TempInt) + ' ���־�' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          end;

          if (itValue[tb_AC] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_AC]) + ' ��С����' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_AC2] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_AC2]) + ' ������' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_mAC] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_mAC]) + ' ��Сħ��' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_mAC2] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_mAC2]) + ' ���ħ��' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_DC] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_DC]) + ' ��С����' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_DC2] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_DC2]) + ' ��󹥻�' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_MC] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_MC]) + ' ��Сħ��' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_MC2] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_MC2]) + ' ���ħ��' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_SC] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_SC]) + ' ��С����' + '/FCOLOR=' + ADDVALUECOLOR + '>\';
          if (itValue[tb_SC2] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_SC2]) + ' ������' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          {if (item.UserItem.Value.btValue[tb_DelWuXinAttack] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(item.UserItem.Value.btValue[tb_DelWuXinAttack])
              + '% ���з���' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (item.UserItem.Value.btValue[tb_AddWuXinAttack] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(item.UserItem.Value.btValue[tb_AddWuXinAttack])
              + '% �����˺�' + '/FCOLOR=' + ADDVALUECOLOR + '>\'; }



          {if (item.UserItem.Value.btValue[tb_HitSpeed] > 0) then
            if TempByte > 10 then
              sNeedStr := sNeedStr + '<+' + IntToStr(item.UserItem.Value.btValue[tb_HitSpeed] * 10)
                + '% �����ٶ�' + '/FCOLOR=' + ADDVALUECOLOR + '>\'
            else
              sNeedStr := sNeedStr + '<-' + IntToStr(item.UserItem.Value.btValue[tb_HitSpeed] * 10)
                + '% �����ٶ�' + '/FCOLOR=' + ADDVALUECOLOR + '>\';  }

          if (itValue[tb_AntiMagic] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_AntiMagic] * 10)
              + '% ħ�����' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_PoisonMagic] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_PoisonMagic] * 10)
              + '% ������' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_HealthRecover] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_HealthRecover] * 10)
              + '% �����ָ�' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_SpellRecover] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_SpellRecover] * 10)
              + '% ħ���ָ�' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_PoisonRecover] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_PoisonRecover] * 10)
              + '% ����ָ�' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_AddAttack] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_AddAttack])
              + '% �˺��ӳ�' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_DelDamage] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_DelDamage])
              + '% �˺�����' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if (itValue[tb_Deadliness] > 0) then
            sNeedStr := sNeedStr + '<+' + IntToStr(itValue[tb_Deadliness])
              + '% ����һ��' + '/FCOLOR=' + ADDVALUECOLOR + '>\';

          if sNeedStr <> '' then begin
            ShowString := ShowString + ' \<��Ʒ����/FCOLOR=' + NOTDOWNCOLOR{NOTDOWNCOLOR} + '>\';
            ShowString := ShowString + sNeedStr;
          end;         *)

          if g_boUseWuXin and (Item.s.StdMode <> tm_House) and (Item.UserItem.Value.btWuXin <> 0) and
            ((Item.s.AddWuXinAttack > 0) or (Item.s.DelWuXinAttack > 0) or
             (Item.UserItem.Value.btValue[tb_AddWuXinAttack] > 0) or
             (Item.UserItem.Value.btValue[tb_DelWuXinAttack] > 0)) then begin
            ShowString := ShowString + ' \��������\';
            if (Item.s.DelWuXinAttack > 0) or (Item.UserItem.Value.btValue[tb_DelWuXinAttack] > 0) then begin
              if CheckWuXinConsistent(Item.UserItem.Value.btWuXin, MyWuXin) then
                ShowString := ShowString + '<��ɫ��[' +
                  GetWuXinName(GetWuXinConsistent(Item.UserItem.Value.btWuXin)) + '] ���з��� +' +
                  IntToStr(Item.s.DelWuXinAttack + Item.UserItem.Value.btValue[tb_DelWuXinAttack])  +
                  '%/FCOLOR=$FFFF63>\'
              else
                ShowString := ShowString + '<��ɫ��[' +
                  GetWuXinName(GetWuXinConsistent(Item.UserItem.Value.btWuXin)) + '] ���з��� +' +
                  IntToStr(Item.s.DelWuXinAttack + Item.UserItem.Value.btValue[tb_DelWuXinAttack])  +
                  '%/FCOLOR=' + HINTCOLOR2 + '>\';
            end;
            if (Item.s.AddWuXinAttack > 0) or (Item.UserItem.Value.btValue[tb_AddWuXinAttack] > 0) then begin
              if CheckWuXinConsistent(MyWuXin, Item.UserItem.Value.btWuXin) then
                ShowString := ShowString + '<��ɫ��[' +
                  GetWuXinName(GetWuXinConsistentBack(Item.UserItem.Value.btWuXin)) + '] �����˺� +' +
                  IntToStr(Item.s.AddWuXinAttack + Item.UserItem.Value.btValue[tb_AddWuXinAttack])  +
                  '%/FCOLOR=$FFFF63>\'
              else
                ShowString := ShowString + '<��ɫ��[' +
                  GetWuXinName(GetWuXinConsistentBack(Item.UserItem.Value.btWuXin)) + '] �����˺� +' +
                  IntToStr(Item.s.AddWuXinAttack + Item.UserItem.Value.btValue[tb_AddWuXinAttack])  +
                  '%/FCOLOR=' + HINTCOLOR2 + '>\';
            end;
          end;

          if Item.UserItem.Value.StrengthenInfo.btCanStrengthenCount > 2 then begin
            ShowString := ShowString + ' \ǿ������ [' + Format('%d/%d',
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
                    ShowString := ShowString + 'δ����' + '/FCOLOR=' + HINTCOLOR2 + '>\';
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
                    1: sNeedStr := sNeedStr + ' ���� +' + IntToStr(Stditem.Source);
                    2: sNeedStr := sNeedStr + ' ħ�� +' + IntToStr(Stditem.Source);
                    3: sNeedStr := sNeedStr + ' ���� +' + IntToStr(Stditem.Source);
                    4: sNeedStr := sNeedStr + ' ħ�� +' + IntToStr(Stditem.Source);
                    5: sNeedStr := sNeedStr + ' ���� +' + IntToStr(Stditem.Source);
                    6: sNeedStr := sNeedStr + ' HP +' + IntToStr(Stditem.Source);
                    7: sNeedStr := sNeedStr + ' MP +' + IntToStr(Stditem.Source);
                  end;
                  sNeedStr := sNeedStr + '/FCOLOR=$FFFF63>\';
                end;
              end else begin
                sNeedStr := sNeedStr + '<img=f.3,i.773><x=22><';
                sNeedStr := sNeedStr + 'δ��Ƕ��ʯ/FCOLOR=' + HINTCOLOR2 + '>\';
              end;
            end;
            ShowString := ShowString + ' \�������� [' + Format('%d/%d', [TempInt, Item.UserItem.Value.btFluteCount]) + ']\';
            ShowString := ShowString + sNeedStr;
          end;
        end;
    end;
    ShowString := ShowString + ' \';
    //if CheckByteStatus(Item.UserItem.btBindMode2, Ib2_Bind) then
      //ShowString := ShowString + '<�Ѱ�' + '/FCOLOR=' + NOTDOWNCOLOR + '>\';
    sNeedStr := '';
    ArrCount := 0;     //sNeedStr := '<��������' + '/FCOLOR=' + NOTDOWNCOLOR + '>\';
    if CheckItemBindMode(@Item.UserItem, bm_NoDown) then begin
      sNeedStr := AddBindStr(sNeedStr, '��������', ArrCount);
    end;
    if sm_ArmingStrong in Item.s.StdModeEx then begin
      if CheckItemBindMode(@Item.UserItem, bm_NoMake) then begin
        {(Item.UserItem.Value.StrengthenInfo.btStrengthenCount >= Item.UserItem.Value.StrengthenInfo.btCanStrengthenCount) }
        sNeedStr := AddBindStr(sNeedStr, '����ǿ��', ArrCount);
      end;
    end;
    if CheckItemBindMode(@Item.UserItem, bm_NoDeal) then
      sNeedStr := AddBindStr(sNeedStr, '���ɽ���', ArrCount);
    if CheckItemBindMode(@Item.UserItem, bm_NoSell) or boBindGold then
      sNeedStr := AddBindStr(sNeedStr, '���ɳ���', ArrCount);
    if CheckItemBindMode(@Item.UserItem, bm_NoSave) then
      sNeedStr := AddBindStr(sNeedStr, '���ɴ��', ArrCount);
    if CheckItemBindMode(@Item.UserItem, bm_NoRepair) then
      sNeedStr := AddBindStr(sNeedStr, '��������', ArrCount);
    if CheckItemBindMode(@Item.UserItem, bm_NoDrop) then
      sNeedStr := AddBindStr(sNeedStr, '���ɶ���', ArrCount)
    else
    if CheckItemBindMode(@Item.UserItem, bm_DropDestroy) then
      sNeedStr := AddBindStr(sNeedStr, '������ʧ', ArrCount);

    sNeedStr := AddBindStr(sNeedStr, '', ArrCount);
    ShowString := ShowString + sNeedStr;

    // ����NPC�������̹��򣬲���ʾ��Ʒ��Դ
    if showSource and (not boBuy) then begin
      ShowString := ShowString + '<[��Ʒ��Դ]/FCOLOR='+ADDVALUECOLOR+'>\';
      if Item.UserItem.GetTime <> '' then
        ShowString := ShowString + '<ʱ�䣺' + Item.UserItem.GetTime + '/FCOLOR=$00FFFF>\'
      else
        ShowString := ShowString + '<ʱ�䣺δ֪/FCOLOR=$00FFFF>\';
      if Item.UserItem.GetMap <> '' then
        ShowString := ShowString + '<�ص㣺' + Item.UserItem.GetMap + '/FCOLOR=$00FFFF>\'
      else
        ShowString := ShowString + '<�ص㣺δ֪/FCOLOR=$00FFFF>\';
      if Item.UserItem.GetName <> '' then
        ShowString := ShowString + '<���' + Item.UserItem.GetName + '/FCOLOR=$00FFFF>\'
      else
        ShowString := ShowString + '<���δ֪/FCOLOR=$00FFFF>\';
      if Item.UserItem.GetMode <> '' then
        ShowString := ShowString + '<�¼���' + Item.UserItem.GetMode + '/FCOLOR=$00FFFF>\'
      else
        ShowString := ShowString + '<�¼���δ֪/FCOLOR=$00FFFF>\';
    end;

    sNeedStr := '';
    if not boBuy then begin
      sGoldStr := '';
      if not (CheckItemBindMode(@Item.UserItem, bm_NoSell)) then
      begin
        sGoldStr := '<�����̵�  ' + GetGoldStr(nSell);
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
        ShowString := ShowString + '<����ʱ��  ' + Formatdatetime('YYYY��M��D�� HHʱ', LongWordToDateTime(Item.UserItem.TermTime)) + '/FCOLOR=' + SELLDEFCOLOR + '>\';
      if (mis_Repair in MoveItemState) or (mis_SuperRepair in MoveItemState) then begin
        if ((sm_Arming in Item.s.StdModeEx) or (sm_HorseArm in Item.s.StdModeEx)) and not (CheckItemBindMode(@Item.UserItem, bm_NoRepair)) then
        begin
          TempInt := nRepair;
          if (mis_SuperRepair in MoveItemState) then
            TempInt := TempInt * 3;
          if TempInt > 0 then begin
            ShowString := ShowString + '<�������  ' + GetGoldStr(TempInt) +
              ' ' + g_sGoldName + '/FCOLOR=' + SELLDEFCOLOR + '>\';
            //sNeedStr := '<��סALT+���װ���ɿ�������/FCOLOR=$00FFFF>\';
          end else
            ShowString := ShowString + '<����Ҫ����/FCOLOR=' + SELLDEFCOLOR + '>\';
        end else
          ShowString := ShowString + '<����������/FCOLOR=' + SELLDEFCOLOR + '>\';
      end else
      if (mis_CompoundItemAdd in MoveItemState) and FrmDlg4.CanCompoundItemAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<����Ҽ�������ӵ��ϳɴ���/FCOLOR=$00FFFF>\';
      end else
      if (mis_ArmAbilityMoveAdd in MoveItemState) and FrmDlg4.CanArmAbilityMoveAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<����Ҽ�������ӵ�����ת�ƴ���/FCOLOR=$00FFFF>\';
      end else
      if (mis_ArmStrengthenAdd in MoveItemState) and FrmDlg3.CanArmStrengthenAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<����Ҽ�������ӵ�ǿ������/FCOLOR=$00FFFF>\';
      end else
      if (mis_MakeItemAdd in MoveItemState) and FrmDlg3.CanMakeItemAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<����Ҽ�������ӵ����촰��/FCOLOR=$00FFFF>\';
      end else
      if (mis_ItemUnsealAdd in MoveItemState) and FrmDlg3.CanItemUnsealAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<����Ҽ�������ӵ����ⴰ��/FCOLOR=$00FFFF>\';
      end else
      if (mis_ItemRemoveStoneAdd in MoveItemState) and FrmDlg4.CanItemRemoveStoneAdd(@Item) then begin
        ShowString := ShowString + sGoldStr;
        sNeedStr := '<����Ҽ�������ӵ�ж�±�ʯ����/FCOLOR=$00FFFF>\';
      end else
      if (mis_Storage in MoveItemState) then begin
        if not (CheckItemBindMode(@Item.UserItem, bm_NoSave))
        then begin
          ShowString := ShowString + sGoldStr;
          sNeedStr := '<����Ҽ����ٴ���ֿ�/FCOLOR=$00FFFF>\';
        end else
          ShowString := ShowString + '<�����Դ��/FCOLOR=' + SELLDEFCOLOR + '>\';
      end else begin
        ShowString := ShowString + sGoldStr;
        if boBuy then begin
          sNeedStr := '<�������/FCOLOR=$00FFFF>\';
        end else
        if mis_StorageBack in MoveItemState then begin
          sNeedStr := '<���ȡ�ص�����/FCOLOR=$00FFFF>\';
        end else
        if (mis_MyDeal in MoveItemState) or (mis_AddBag in MoveItemState) or (mis_ArmStrengthen in MoveItemState) then begin
          sNeedStr := '<���ȡ�ص�����/FCOLOR=$00FFFF>\';
        end else
        if (mis_State in MoveItemState) then begin
          sNeedStr := '<�����Ҽ�����ȡ�ص�����/FCOLOR=$00FFFF>\';
        end else
        if (mis_Bag in MoveItemState) then begin
          if (sm_Arming in Item.s.StdModeEx) or (sm_HorseArm in Item.s.StdModeEx) or (Item.s.StdMode = tm_AddBag) or (Item.s.StdMode = tm_Cowry) or (Item.s.StdMode = tm_House) then
            sNeedStr := '<�Ҽ���˫��װ������Ʒ/FCOLOR=$00FFFF>\'
          else if (sm_Eat in Item.s.StdModeEx) then
            sNeedStr := '<�Ҽ���˫��ʹ�ø���Ʒ/FCOLOR=$00FFFF>\';
        end else
        if (mis_bottom in MoveItemState) then begin
          sNeedStr := '<�����Ҽ�ʹ�ø���Ʒ/FCOLOR=$00FFFF>\';
        end;
      end;
    end;
{$IFDEF DEBUG}
    if g_boShowItemID then
      sNeedStr := sNeedStr + '<��ƷID:' + IntToStr(Item.UserItem.MakeIndex) + '/FCOLOR=' + SELLDEFCOLOR + '>\';
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
    ShowString := ShowString + '<COLOR=' + HINTDEFCOLOR + '>������ʾ����Ŷ������ҪҪ<ENDCOLOR>\'; }

    //ShowItemMsg := ShowString;
  end;
  Result := AddShowString + ShowString;
  ShowString := '';
  //sNameColor: string;
  //SetItem: pTSetItems;
  if (Item.s.SetItemList <> nil) and (Item.s.SetItemList.Count > 0) then begin
    for I := 0 to Item.s.SetItemList.Count - 1 do begin
      SetItem := Item.s.SetItemList[I];
      ShowString := '<SetItem>\ \��װ��Ϣ\';
      boOK := True;
      if MySex = 1 then begin
        if SetItem.Items[U_BUJUK] <> '' then begin
          if MyUseItems[U_DRESS].s.Name = SetItem.Items[U_BUJUK] then
            ShowString := ShowString + '<[��װ]    ' + SetItem.Items[U_BUJUK] + '/FCOLOR=$63CEFF>\'
          else begin
            ShowString := ShowString + '<[��װ]    ' + SetItem.Items[U_BUJUK] + '/FCOLOR=' + HINTCOLOR2 + '>\';
            boOK := False;
          end;
        end;
      end else begin
        if SetItem.Items[U_DRESS] <> '' then begin
          if MyUseItems[U_DRESS].s.Name = SetItem.Items[U_DRESS] then
            ShowString := ShowString + '<[��װ]    ' + SetItem.Items[U_DRESS] + '/FCOLOR=$63CEFF>\'
          else begin
            ShowString := ShowString + '<[��װ]    ' + SetItem.Items[U_DRESS] + '/FCOLOR=' + HINTCOLOR2 + '>\';
            boOK := False;
          end;
        end;
      end;
      if SetItem.Items[U_WEAPON] <> '' then begin
        if MyUseItems[U_WEAPON].s.Name = SetItem.Items[U_WEAPON] then
          ShowString := ShowString + '<[����]    ' + SetItem.Items[U_WEAPON] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[����]    ' + SetItem.Items[U_WEAPON] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      if SetItem.Items[U_HELMET] <> '' then begin
        if MyUseItems[U_HELMET].s.Name = SetItem.Items[U_HELMET] then
          ShowString := ShowString + '<[ͷ��]    ' + SetItem.Items[U_HELMET] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[ͷ��]    ' + SetItem.Items[U_HELMET] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      if SetItem.Items[U_NECKLACE] <> '' then begin
        if MyUseItems[U_NECKLACE].s.Name = SetItem.Items[U_NECKLACE] then
          ShowString := ShowString + '<[����]    ' + SetItem.Items[U_NECKLACE] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[����]    ' + SetItem.Items[U_NECKLACE] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      if SetItem.Items[U_RIGHTHAND] <> '' then begin
        if MyUseItems[U_RIGHTHAND].s.Name = SetItem.Items[U_RIGHTHAND] then
          ShowString := ShowString + '<[ѫ��]    ' + SetItem.Items[U_RIGHTHAND] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[ѫ��]    ' + SetItem.Items[U_RIGHTHAND] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      if (SetItem.Items[U_ARMRINGL] <> '') or (SetItem.Items[U_ARMRINGR] <> '') then begin
        if (SetItem.Items[U_ARMRINGL] <> '') and (MyUseItems[U_ARMRINGL].s.Name = SetItem.Items[U_ARMRINGL]) then begin
          ShowString := ShowString + '<[����]    ' + SetItem.Items[U_ARMRINGL] + '/FCOLOR=$63CEFF>\';
          if (SetItem.Items[U_ARMRINGR] <> '') then begin
            if (MyUseItems[U_ARMRINGR].s.Name = SetItem.Items[U_ARMRINGR]) then begin
              ShowString := ShowString + '<[����]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[����]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end else
        if (SetItem.Items[U_ARMRINGL] <> '') and (MyUseItems[U_ARMRINGR].s.Name = SetItem.Items[U_ARMRINGL]) then begin
          ShowString := ShowString + '<[����]    ' + SetItem.Items[U_ARMRINGL] + '/FCOLOR=$63CEFF>\';
          if (SetItem.Items[U_ARMRINGR] <> '') then begin
            if (MyUseItems[U_ARMRINGL].s.Name = SetItem.Items[U_ARMRINGR]) then begin
              ShowString := ShowString + '<[����]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[����]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end else begin
          if (SetItem.Items[U_ARMRINGL] <> '') then begin
            ShowString := ShowString + '<[����]    ' + SetItem.Items[U_ARMRINGL] + '/FCOLOR=' + HINTCOLOR2 + '>\';
            boOK := False;
          end;
          if (SetItem.Items[U_ARMRINGR] <> '') then begin
            if (MyUseItems[U_ARMRINGL].s.Name = SetItem.Items[U_ARMRINGR]) or (MyUseItems[U_ARMRINGR].s.Name = SetItem.Items[U_ARMRINGR]) then begin
              ShowString := ShowString + '<[����]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[����]    ' + SetItem.Items[U_ARMRINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end;
      end;
      if (SetItem.Items[U_RINGL] <> '') or (SetItem.Items[U_RINGR] <> '') then begin
        if (SetItem.Items[U_RINGL] <> '') and (MyUseItems[U_RINGL].s.Name = SetItem.Items[U_RINGL]) then begin
          ShowString := ShowString + '<[��ָ]    ' + SetItem.Items[U_RINGL] + '/FCOLOR=$63CEFF>\';
          if (SetItem.Items[U_RINGR] <> '') then begin
            if (MyUseItems[U_RINGR].s.Name = SetItem.Items[U_RINGR]) then begin
              ShowString := ShowString + '<[��ָ]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[��ָ]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end else
        if (SetItem.Items[U_RINGL] <> '') and (MyUseItems[U_RINGR].s.Name = SetItem.Items[U_RINGL]) then begin
          ShowString := ShowString + '<[��ָ]    ' + SetItem.Items[U_RINGL] + '/FCOLOR=$63CEFF>\';
          if (SetItem.Items[U_RINGR] <> '') then begin
            if (MyUseItems[U_RINGL].s.Name = SetItem.Items[U_RINGR]) then begin
              ShowString := ShowString + '<[��ָ]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[��ָ]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end else begin
          if (SetItem.Items[U_RINGL] <> '') then begin
            ShowString := ShowString + '<[��ָ]    ' + SetItem.Items[U_RINGL] + '/FCOLOR=' + HINTCOLOR2 + '>\';
            boOK := False;
          end;
          if (SetItem.Items[U_RINGR] <> '') then begin
            if (MyUseItems[U_RINGL].s.Name = SetItem.Items[U_RINGR]) or (MyUseItems[U_RINGR].s.Name = SetItem.Items[U_RINGR]) then begin
              ShowString := ShowString + '<[��ָ]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=$63CEFF>\';
            end else begin
              ShowString := ShowString + '<[��ָ]    ' + SetItem.Items[U_RINGR] + '/FCOLOR=' + HINTCOLOR2 + '>\';
              boOK := False;
            end;
          end;
        end;
      end;
      if SetItem.Items[U_BELT] <> '' then begin
        if MyUseItems[U_BELT].s.Name = SetItem.Items[U_BELT] then
          ShowString := ShowString + '<[����]    ' + SetItem.Items[U_BELT] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[����]    ' + SetItem.Items[U_BELT] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      if SetItem.Items[U_BOOTS] <> '' then begin
        if MyUseItems[U_BOOTS].s.Name = SetItem.Items[U_BOOTS] then
          ShowString := ShowString + '<[ѥ��]    ' + SetItem.Items[U_BOOTS] + '/FCOLOR=$63CEFF>\'
        else begin
          ShowString := ShowString + '<[ѥ��]    ' + SetItem.Items[U_BOOTS] + '/FCOLOR=' + HINTCOLOR2 + '>\';
          boOK := False;
        end;
      end;
      ShowString := ShowString + ' \��װ����\';
      if boOK then sNameColor := ADDVALUECOLOR3//'$63CEFF'
      else sNameColor := HINTCOLOR2; 
      
      for k := Low(SetItem.Value) to High(SetItem.Value) do begin
        if SetItem.Value[k] > 0 then begin
          case K of
            0: ShowString := ShowString + '<����      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            1: ShowString := ShowString + '<ħ��      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            2: ShowString := ShowString + '<����      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            3: ShowString := ShowString + '<ħ��      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            4: ShowString := ShowString + '<����      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            5: ShowString := ShowString + '<׼ȷ      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            6: ShowString := ShowString + '<����      +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            7: ShowString := ShowString + '<����ֵ    +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            8: ShowString := ShowString + '<ħ��ֵ    +' + IntToStr(SetItem.Value[k]) + '/FCOLOR=' + sNameColor + '>\';
            9: ShowString := ShowString + '<��������  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '��/FCOLOR=' + sNameColor + '>\';
            10: ShowString := ShowString + '<ħ������  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '��/FCOLOR=' + sNameColor + '>\';
            11: ShowString := ShowString + '<��������  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '��/FCOLOR=' + sNameColor + '>\';
            12: ShowString := ShowString + '<ħ������  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '��/FCOLOR=' + sNameColor + '>\';
            13: ShowString := ShowString + '<��������  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '��/FCOLOR=' + sNameColor + '>\';
            14: ShowString := ShowString + '<�����ָ�  +' + IntToStr(SetItem.Value[k]) + '0%/FCOLOR=' + sNameColor + '>\';
            15: ShowString := ShowString + '<ħ���ָ�  +' + IntToStr(SetItem.Value[k]) + '0%/FCOLOR=' + sNameColor + '>\';
            16: ShowString := ShowString + '<�ж��ָ�  +' + IntToStr(SetItem.Value[k]) + '0%/FCOLOR=' + sNameColor + '>\';
            17: ShowString := ShowString + '<ħ�����  +' + IntToStr(SetItem.Value[k]) + '0%/FCOLOR=' + sNameColor + '>\';
            18: ShowString := ShowString + '<������  +' + IntToStr(SetItem.Value[k]) + '0%/FCOLOR=' + sNameColor + '>\';
            19: ShowString := ShowString + '<�˺��ӳ�  +' + IntToStr(SetItem.Value[k]) + '%/FCOLOR=' + sNameColor + '>\';
            20: ShowString := ShowString + '<�˺�����  +' + IntToStr(SetItem.Value[k]) + '%/FCOLOR=' + sNameColor + '>\';
            21: ShowString := ShowString + '<����һ��  +' + IntToStr(SetItem.Value[k]) + '%/FCOLOR=' + sNameColor + '>\';
            22: ShowString := ShowString + '<��������  ' + Format('%.1f', [SetItem.Value[K] / 10]) + '��/FCOLOR=' + sNameColor + '>\';
            23: ShowString := ShowString + '<�������/FCOLOR=' + sNameColor + '>\';
            24: ShowString := ShowString + '<��������/FCOLOR=' + sNameColor + '>\';
            25: ShowString := ShowString + '<��������/FCOLOR=' + sNameColor + '>\';
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
        sMsg := '��Ҫ�ȼ� ' + IntToStr(Item.S.DuraMax);
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
              sMsg := '��Ҫ�ȼ�: ' + IntToStr(Item.S.NeedLevel);
              if m_Abil.Level >= Item.S.NeedLevel then
                Result := True;
            end;
          1: begin
              sMsg := '��Ҫְҵ: ' + GetJobName(Item.S.NeedLevel);
              if MyJob = Item.S.NeedLevel then
                Result := True;
            end;
          10: begin
              sMsg1 := '��Ҫ�ȼ�: ' + IntToStr(HiWord(Item.S.NeedLevel));
              sMsg2 := '   ��Ҫְҵ: ' + GetJobName(LoWord(Item.S.NeedLevel));
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
          sMsg := '<' +  'ʹ�õȼ�: ' + IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
          if m_Abil.Level >= Item.S.NeedLevel then
            sMsg := '<' +  'ʹ�õȼ�: ' + IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
        end;
      1: begin
          sMsg := '<' +  'ʹ��ְҵ: ' + GetJobName(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
          if MyJob = Item.S.NeedLevel then
            sMsg := '<' +  'ʹ��ְҵ: ' + GetJobName(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
        end;
      2: begin
          sMsg := '<�л��Աר��/FCOLOR=$0000FF>\';
          if g_MySelf.m_sGuildName <> '' then
            sMsg := '<�л��Աר��/FCOLOR=$00FF00>\';
        end;
      3: begin
          sMsg := '<' +  'ʹ�õȼ�����: ' + IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
          if m_Abil.Level < Item.S.NeedLevel then
            sMsg := '<' +  'ʹ�õȼ�����: ' + IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
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
        sMsg := '<' + '��Ҫ�ȼ� ' + AddStr + IntToStr(Item.S.DuraMax) + '/FCOLOR=$0000FF>\';
        case Item.S.Shape of
          0: begin
              if (MyJob = 0) and (m_Abil.Level >= Item.S.DuraMax) then
                sMsg := '<' + '��Ҫ�ȼ� ' + AddStr +  IntToStr(Item.S.DuraMax) + '/FCOLOR=$00FF00>\';
            end;
          1: begin
              if (MyJob = 1) and (m_Abil.Level >= Item.S.DuraMax) then
                sMsg := '<' + '��Ҫ�ȼ� ' + AddStr +  IntToStr(Item.S.DuraMax) + '/FCOLOR=$00FF00>\';
            end;
          2: begin
              if (MyJob = 2) and (m_Abil.Level >= Item.S.DuraMax) then
                sMsg := '<' + '��Ҫ�ȼ� ' + AddStr +  IntToStr(Item.S.DuraMax) + '/FCOLOR=$00FF00>\';
            end;
          99: begin
              if {(boHero) and}(m_Abil.Level >= Item.S.DuraMax) then
                sMsg := '<' + '��Ҫ�ȼ� ' + AddStr +  IntToStr(Item.S.DuraMax) + '/FCOLOR=$00FF00>\';
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
              sMsg := '<' +  '��Ҫ�ȼ�  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
              if m_Abil.Level >= Item.S.NeedLevel then
                sMsg := '<' +  '��Ҫ�ȼ�  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          10: begin
              sMsg1 := '<' +  '��Ҫ�ȼ�  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '��Ҫְҵ  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              if m_Abil.Level >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '��Ҫ�ȼ�  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if MyJob = LoWord(Item.S.NeedLevel) then
                sMsg2 := '<' +  '��Ҫְҵ  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          1: begin
              sMsg := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.DC) >= Item.S.NeedLevel then
                sMsg := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          11: begin
              sMsg1 := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '��Ҫְҵ  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.DC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if MyJob = LoWord(Item.S.NeedLevel) then
                sMsg2 := '<' +  '��Ҫְҵ  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          2: begin
              sMsg := '<' +  '��Ҫħ��  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.MC) >= Item.S.NeedLevel then
                sMsg := '<' +  '��Ҫħ��  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          12: begin
              sMsg1 := '<' +  '��Ҫħ��  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '��Ҫְҵ  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.MC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '��Ҫħ��  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if MyJob = LoWord(Item.S.NeedLevel) then
                sMsg2 := '<' +  '��Ҫְҵ  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          3: begin
              sMsg := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.SC) >= Item.S.NeedLevel then
                sMsg := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          13: begin
              sMsg1 := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '��Ҫְҵ  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              if HiWord(m_Abil.SC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if MyJob = LoWord(Item.S.NeedLevel) then
                sMsg2 := '<' +  '��Ҫְҵ  ' + AddStr +  GetJobName(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          4: begin
              sMsg := '<' +  '��Ҫת���ȼ�  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          40: begin
              sMsg1 := '<' +  '��Ҫ�ȼ�  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '��Ҫת���ȼ�  ' + AddStr +  IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if m_Abil.Level >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '��Ҫ�ȼ�  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          41: begin
              sMsg1 := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '��Ҫת���ȼ�  ' + AddStr +  IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if HiWord(m_Abil.DC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          42: begin
              sMsg1 := '<' +  '��Ҫħ��  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '��Ҫת���ȼ�  ' + AddStr +  IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if HiWord(m_Abil.MC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '��Ҫħ��  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          43: begin
              sMsg1 := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '��Ҫת���ȼ�  ' + AddStr +  IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if HiWord(m_Abil.SC) >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          44: begin
              sMsg1 := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$0000FF>\';
              sMsg2 := '<' +  '��Ҫת���ȼ�  ' + AddStr +  IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              if g_nCreditPoint >= HiWord(Item.S.NeedLevel) then
                sMsg1 := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          5: begin
              sMsg := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$0000FF>\';
              if g_nCreditPoint >= Item.S.NeedLevel then
                sMsg := '<' +  '��Ҫ����  ' + AddStr +  IntToStr(Item.S.NeedLevel) + '/FCOLOR=$00FF00>\';
            end;
          6: begin
              sMsg := '<�л��Աר��װ��/FCOLOR=$0000FF>\';
              if g_MySelf.m_sGuildName <> '' then
                sMsg := '<�л��Աר��װ��/FCOLOR=$00FF00>\';
            end;
          60: begin
              sMsg := '<�л�������ר��װ��/FCOLOR=$0000FF>\';
              if g_MySelf.m_sGuildName <> '' then
                sMsg := '<�л�������ר��װ��/FCOLOR=$00FF00>\';
            end;
          7: begin
              sMsg := '<ɳ�Ϳ˳�Աר��װ��/FCOLOR=$0000FF>\';
              if g_MySelf.m_sGuildName <> '' then
                sMsg := '<ɳ�Ϳ˳�Աר��װ��/FCOLOR=$00FF00>\';
            end;
          20, 70: begin
              sMsg := '<ɳ�Ϳ˳���ר��װ��/FCOLOR=$0000FF>\';
              if g_MySelf.m_sGuildName <> '' then
                sMsg := '<ɳ�Ϳ˳���ר��װ��/FCOLOR=$00FF00>\';
            end;
          8: begin
              sMsg := '<��Աר��װ��/FCOLOR=$00FF00>\';
            end;
          81: begin
              sMsg1 := '<' +  '��Ҫ��Ա�ȼ� �� ' + IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg2 := '<' +  '��Ҫ��Ա���� =  ' + IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg := sMsg1 + sMsg2;
            end;
          82: begin
              sMsg1 := '<' +  '��Ҫ��Ա�ȼ� �� ' + IntToStr(HiWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
              sMsg2 := '<' +  '��Ҫ��Ա���� �� ' + IntToStr(LoWord(Item.S.NeedLevel)) + '/FCOLOR=$00FF00>\';
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
                  Line(lx + sx - 1, ly + g_DXCanvas.TextHeight(sTemp) + 1, g_DXCanvas.TextWidth(sTemp) - 2, clYellow);
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
      Result := '�����˺� <+' + IntToStr(Max(0, Magic.Def.Magic.btDefMaxPower * (Magic.Level+1))) + '%/FCOLOR=$00FF00>';
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
        ShowString := ShowString + '����ʹ�ü��: ';
        ShowString := ShowString + IntToStr(Magic.nInterval div 1000) + '��\';
      end;
      ShowString := ShowString + '<Line>';
      ShowString := ShowString + '<COLOR=' + HINTDEFCOLOR + '>';
      ShowString := ShowString + '�����ͷſ�ݼ�';
      ShowString := ShowString + '<ENDCOLOR>\';
  end else begin
    if nMagID in [3, 4, 7, 64] then ShowString := ShowString + '<��������/FCOLOR=' + WUXINISMYCOLOR + '>\'
    else ShowString := ShowString + '<��������/FCOLOR=' + WUXINISMYCOLOR + '>\';
    ShowString := ShowString + '��ǰ���ܵȼ�: ';
    if CMagic.boStudy then begin
      ShowString := ShowString + IntToStr(CMagic.Level) + '\';
      if (Magic.btTrainLv <= 9) and (CMagic.Level < Magic.btTrainLv) then
        ShowString := ShowString + '��ǰ������Ϊ: ' + IntToStr(CMagic.CurTrain) + '\';
    end else begin
      ShowString := ShowString + 'δ����\';
    end;
    if Magic.nInterval > 0 then begin
      ShowString := ShowString + '����ʹ�ü��: ';
      ShowString := ShowString + IntToStr(Magic.nInterval div 1000) + '��\';
    end;
    {if nMagId in [Grobal2.SKILL_FIREBALL2] then
    begin
      ShowString := ShowString + '<���ܼ���/FCOLOR=' + WUXINISMYCOLOR + '>\';
      ShowString := ShowString + IntToStr(Round((CMagic.Level + 1) * 3 + 1)) + '%\';
    end;
    if nMagId in [Grobal2.SKILL_FIREWIND] then
    begin
      ShowString := ShowString + '<���ܼ���/FCOLOR=' + WUXINISMYCOLOR + '>\';
      ShowString := ShowString + IntToStr(Round((20 + CMagic.Level * 10 + 1))) + '% �� 5*[�ȼ���]% ����\';
    end;
    if nMagId in [Grobal2.SKILL_LIGHTENING] then
    begin
      ShowString := ShowString + '<���ܼ���/FCOLOR=' + WUXINISMYCOLOR + '>\';
      ShowString := ShowString + IntToStr(Round(CMagic.Level * 5 + 1)) + '% �� [�ȼ���]% ����\';
    end;
    if nMagId in [Grobal2.SKILL_TAMMING] then
    begin
      ShowString := ShowString + '<���ܼ���/FCOLOR=' + WUXINISMYCOLOR + '>\';
      ShowString := ShowString + IntToStr(Round((CMagic.Level + 1) * 25)) + '% ���ʴ���\';
      ShowString := ShowString + '1. 50% * 10% �������\';
      ShowString := ShowString + '2. 50% * 90% ���ﶨ�� '+IntToStr(Round((CMagic.Level * 5 + 10)))+' ��\';
      ShowString := ShowString + '3. 50% * (��������ʱ 33% * ��ؼ���)���ɹ��ٻ�\';
      ShowString := ShowString + '4. �����������ɱ����\';
    end;
    if nMagId in [Grobal2.SKILL_SPACEMOVE] then
    begin
      ShowString := ShowString + '<���ܼ���/FCOLOR=' + WUXINISMYCOLOR + '>\';
      ShowString := ShowString + IntToStr(Round((CMagic.Level * 2 + 4) * 100 div 11)) + '%\';
    end;
    if nMagId in [Grobal2.SKILL_KILLUNDEAD] then
    begin
      ShowString := ShowString + '<���ܼ���/FCOLOR=' + WUXINISMYCOLOR + '>\';
      ShowString := ShowString + IntToStr(Round(CMagic.Level * 30 + 1)) + '% ����\';
    end;
    if nMagId in [Grobal2.SKILL_44] then
    begin
      ShowString := ShowString + '<���ܼ���/FCOLOR=' + WUXINISMYCOLOR + '>\';
      ShowString := ShowString + IntToStr(Round(CMagic.Level * 5)) + '% �� [�ȼ���]% ����\';
    end;
    if nMagId in [Grobal2.SKILL_45] then
    begin
      ShowString := ShowString + '<���ܼ���/FCOLOR=' + WUXINISMYCOLOR + '>\';
      ShowString := ShowString + IntToStr(Round(CMagic.Level * 10)) + '% ����\';
    end;}
    case nMagID of
      3,{��������}
      4,{������ս��}
      12, {��ɱ����}
      64,
      7 {��ɱ����}: begin
        end;
     (* 2,{������}
      29 {Ⱥ��������}: begin
        if CMagic.boStudy then begin
          ShowString := ShowString + ' \<��ǰ�ȼ�����/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<����ħ��: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
          ShowString := ShowString + '<����Ѫ��: /FCOLOR=' + ADDVALUECOLOR + '>' + GetSpellPower(@CMagic) +'\';
        end;
        if CMagic.Level < 3 then begin
          Inc(CMagic.Level);
          ShowString := ShowString + ' \<��һ�ȼ�����/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<����ħ��: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
          ShowString := ShowString + '<����Ѫ��: /FCOLOR=' + ADDVALUECOLOR + '>' + GetSpellPower(@CMagic) +'\';
          Dec(CMagic.Level);
        end;
      end;  *)
      1,
      5,
      9,
      10, {�����Ӱ}
      11, {�׵���}
      23,
      24, {�����׹�}
      33, {������}
      36, {�����}
      37,
      44,
      45, {�����}
      47,
      66,
      67,
      70,
      71,
      72,
      57, {���ǻ���}
      114, {˫����}
      115, {���輼}
      116, {���ױ�}
      117, {����ѩ��}
      118, {��Х��}
      119, {������}
      120, {������}
      121, {�򽣹���}
      13, {�����}
      53, {��Ѫ��}
      22{��ǽ}: begin
        if CMagic.boStudy then begin
          ShowString := ShowString + ' \<��ǰ�ȼ�����/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<����ħ��: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
          ShowString := ShowString + '<�����˺�: /FCOLOR=' + ADDVALUECOLOR + '>' + GetSpellPower(@CMagic) +'\';
        end;
        if CMagic.Level < Magic.btTrainLv then begin
          Inc(CMagic.Level);
          ShowString := ShowString + ' \<��һ�ȼ�����/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<����ħ��: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
          ShowString := ShowString + '<�����˺�: /FCOLOR=' + ADDVALUECOLOR + '>' + GetSpellPower(@CMagic) +'\';
          Dec(CMagic.Level);
        end;
      end;
    else begin
        if CMagic.boStudy then begin
          ShowString := ShowString + ' \<��ǰ�ȼ�����/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<����ħ��: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
        end;
        if CMagic.Level < Magic.btTrainLv then begin
          Inc(CMagic.Level);
          ShowString := ShowString + ' \<��һ�ȼ�����/FCOLOR=' + ADDVALUECOLOR2 + '>\';
          ShowString := ShowString + '<����ħ��: /FCOLOR=' + ADDVALUECOLOR + '>' + IntToStr(GetSpellPoint(@CMagic)) + '\';
          Dec(CMagic.Level);
        end;
      end;
    end;

    if (Magic.btTrainLv <= 9) and (CMagic.Level < Magic.btTrainLv) then begin
      if CMagic.boStudy then begin
        ShowString := ShowString + ' \<��������Ҫ��/FCOLOR=' + ADDVALUECOLOR2 + '>\';
        ShowString := ShowString + '<��Ҫ����ȼ�: /FCOLOR=' + ADDVALUECOLOR + '>' +
          GetMagicNeedStr(nLevel, Magic.TrainLevel[CMagic.Level]) + '\';
        ShowString := ShowString + '<��Ҫ������Ϊ: /FCOLOR=' + ADDVALUECOLOR + '>' +
          GetMagicNeedStr(CMagic.CurTrain, Magic.MaxTrain[CMagic.Level]) + '\';
      end else begin
        ShowString := ShowString + ' \<ѧϰ����Ҫ��/FCOLOR=' + ADDVALUECOLOR2 + '>\';
        ShowString := ShowString + '<��Ҫ����ȼ�: /FCOLOR=' + ADDVALUECOLOR + '>' +
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






