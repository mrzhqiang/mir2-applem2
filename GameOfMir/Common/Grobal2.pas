unit Grobal2;

interface
uses
  Windows, SysUtils, Classes, JSocket, DateUtils;
const
  Public_Test = 0;
  Public_Release = 1;
  Public_Free = 2;

  Public_Ver = Public_Free;

  Var_Free = 0;

  // 剑侠界面
  Var_Default = 0;
  // 盛大界面
  Var_Mir2 = 1;

  Var_Interface = Var_Mir2;

  CLIENT_VERSION_NUMBER = 20201212;
  CLIENT_VERSION_MARK = $1FFFFFF;

  CLIENT_VERSIONEX_MIR2 = $2000000;
  CLIENT_VERSIONEX_TEST = $4000000;
  CLIENT_VERSIONEX_FREE = $8000000;
  CLIENT_VERSIONEX_DEBUG = $10000000;

  {
  $1FFFFFF
  $2000000
$4000000
$8000000
$10000000
$20000000
$40000000
$80000000  }
  

  g_sProgram = '程序制作: mrzhqiang';
  g_sWebSite = '兰达尔引擎，永久免费';

  // 某种匹配符？
  GROBAL2VER = CLIENT_VERSION_NUMBER;
  //最大用户连接数
  GATEMAXSESSION = 1000;
  //用户索引最大记录数,如果已创建人物数量大于这个值,整体系统可能会出错
  PLAYOBJECTINDEXCOUNT = 1000000;

  CanStrengthenArr: array[0..6] of Byte = (0, 3, 6, 9, 12, 15, 18);
  CanStrengthenMax: array[0..5] of Byte = (16, 20, 21, 15, 24, 6);

  MAXPATHLEN = 255;
  DIRPATHLEN = 80;
  MapNameLen = 16;
  ActorNameLen = 14;
  GuildNameLen = 14;
  DEFBLOCKSIZE = 16;
  BUFFERSIZE = 30000; //数据最长不超过20000
  DATABUFFERSIZE = 20000;

  DATA_BUFSIZE = 8192;
  GROUPMAX = 11;
  BAGGOLD = 5000000;
  BODYLUCKUNIT = 10;
  MAX_STATUS_ATTRIBUTE = 12;
  MAXDEALITEMCOUNT = 12;
  MAXPULLULATION = 10000 * 60; //最大自然成长点
  //MINPULLULATION = 10; //最小自然成长点
  MIDPULLULATION = 60;

  MAXTAXISCOUNT = 100;

  SQLDISPOSETEXT = '连接失败';

{$IF Var_Interface = Var_Mir2}
  DEFSAYLISTWIDTH = 386;
{$ELSE}
  DEFSAYLISTWIDTH = 279;
{$IFEND}

  SAYLISTHEIGHT = 16; //聊天框高度
  FACESHOWCOUNT = 10; //表情列表每行显示数量
  SAYFACEWIDTH = 20; //聊天框表情宽度

  {ALLHUM = 'AllHum.DB';
  WARRHUM = 'WarrHum.DB';
  WIZARDHUM = 'WizardHum.DB';
  TAOSHUM = 'TaosHum.DB';
  ALLHERO = 'AllHero.DB';
  WARRHERO = 'WarrHero.DB';
  WIZARDHERO = 'WizardHero.DB';
  TAOSHERO = 'TaosHero.DB';
  MASTERALL = 'Master.DB';  }

  sSTRING_GOLDNAME = '金币';
  sSTRING_BINDGOLDNAME = '绑定金币';
  sSTRING_GAMEPOINT = '点卷';
  sSTRING_GAMEGOLD = '元宝';
  sSTRING_GAMEDIAMOND = '积分';
  sSTRING_CREDITPOINT = '声望';
  sSTRING_CUSTOMVARIABLE = '人物变量';

  LOG_PLAYDIE = 0; //人物死亡
  LOG_GOLDCHANGED = 1; //金币改变
  LOG_BINDGOLDCHANGED = 2; //绑金改变
  LOG_GAMEPOINTCHANGED = 3; //点卷改变
  LOG_GAMEGOLDCHANGED = 4; //元宝改变
  LOG_GAMEDIAMONDCHANGED = 5; //积分改变
  LOG_ITEMDURACHANGE = 6; //叠加改变
  LOG_ADDITEM = 7; //增加物品
  LOG_DELITEM = 8; //减少物品
  LOG_STORAGE = 9; //仓库存取
  LOG_ITEMLEVEL = 10; //强化改变
  LOG_UPDATEITEM = 11; //调整装备
  LOG_CREDITPOINT = 12; //声望改变
  LOG_CUSTOMVARIABLE = 13; //'人物变量'
  //LOG_EMAIL = 11; //邮件信息

  INT_ADD = 0;
  INT_DEL = 1;
  INT_SET = 2;

  NEWMAPMODE = 0;
  OLDMAPMODE = 1;
  CHANGEMAPMODE = OLDMAPMODE;

  MAXINTCOUNT = 2000000000;
  MAXWORDCOUNT = High(Word);
  MAXBYTECOUNT = High(Byte);

  CHECK_GROUP = 0;
  CHECK_FRIEND = 1;

  UKTYPE_ITEM = 1;
  UKTYPE_MAGIC = 2;

  GSP_NOTDEAL = 0;          //拒绝交易
  GSP_NOTGROUP = 1;         //拒绝组队
  GSP_NOTGUILD = 2;         //拒绝加入行会
  GSP_NOTFRIENG = 3;        //拒绝加为好友
  GSP_NOTSAYHEAR = 4;       //拒绝白字说话
  GSP_NOTSAYWHISPER = 5;    //拒绝私聊
  GSP_NOTSAYCRY = 6;        //拒绝喊话
  GSP_NOTSAYGROUP = 7;      //拒绝队伍聊天
  GSP_NOTSAYGUILD = 8;      //拒绝行会聊天
  GSP_GROUPCHECK = 9;       //组队需要验证
  GPS_GROUPRECALL = 10;     //天地合一
  GSP_GUILDRECALL = 11;     //行会合一
  GSP_HIDEHELMET = 12;      //隐藏头盔显示
  GSP_OLDCHANGEMAP = 13;    //旧的切换地图模式

  DR_UP = 0;//正北
  DR_UPRIGHT = 1;//东北向
  DR_RIGHT = 2; //东
  DR_DOWNRIGHT = 3;//东南向
  DR_DOWN = 4;//南
  DR_DOWNLEFT = 5;//西南向
  DR_LEFT = 6;//西
  DR_UPLEFT = 7;//西北向

  U_DRESS = 0; //衣服
  U_WEAPON = 1; //武器
  U_HELMET = 2;//头盔
  U_NECKLACE = 3;//项链
  U_RIGHTHAND = 4;//右手
  U_ARMRINGL = 5;//左手手镯,符
  U_ARMRINGR = 6;//右手手镯
  U_RINGL = 7;  //左戒指
  U_RINGR = 8;//右戒指
  U_BUJUK = 9; //物品
  U_BELT = 10; //腰带
  U_BOOTS = 11; //鞋
  U_CHARM = 12; //宝石
  U_HOUSE = 13;
  U_CIMELIA = 14;
  U_REIN = 16;
  U_BELL = 17;
  U_SADDLE = 18;
  U_DECORATION = 19;
  U_NAIL = 20;

  HU_REIN = 0;
  HU_BELL = 1;
  HU_SADDLE = 2;
  HU_DECORATION = 3;
  HU_NAIL = 4;

  MAGICEX_AMYOUNSUL = 101;
  MAGICEX_AMYOUNSULGROUP = 102;
  //U_VIP = 15;

  POISON_DECHEALTH = 0; //中毒类型 - 绿毒
  POISON_DAMAGEARMOR = 1; //中毒类型 - 红毒
  //POISON_LOCKSPELL = 2;
  //POISON_DONTMOVE = 4;
  POISON_STONE = 5; //麻痹
  POISON_COBWEB = 6; //蛛网
  STATE_BUBBLEDEFENCEUPEX = 7; //金刚护盾
  STATE_TRANSPARENT = 8; //隐身
  STATE_DEFENCEUP = 9; //加防(神圣战甲术)
  STATE_MAGDEFENCEUP = 10; //加魔(幽灵盾)
  STATE_BUBBLEDEFENCEUP = 11; //魔法盾

  STATUS_EXP = 0; //经验倍数
  STATUS_POW = 1; //伤害倍数
  STATUS_SC  = 2; //道术
  STATUS_AC  = 3; //防御
  STATUS_DC  = 4; //攻击
  STATUS_HIDEMODE = 5; //隐身
  STATUS_STONE = 6; //麻痹
  STATUS_MC = 7; //魔法
  STATUS_MP = 8; //魔法值
  STATUS_MAC = 9; //魔御
  STATUS_HP = 10; //生命值
  STATUS_DAMAGEARMOR = 11; //红毒
  STATUS_DECHEALTH = 12; //绿毒
  STATUS_COBWEB = 13; //蛛网

  STATUS_COUNT = 14;

  USERMODE_PLAYGAME = 1;
  USERMODE_LOGIN = 2;
  USERMODE_LOGOFF = 3;
  USERMODE_NOTICE = 4;

  RUNGATEMAX = 20;

  RUNGATECODE = $AA55AA55;

  OS_MOVINGOBJECT = 1;
  OS_ITEMOBJECT = 2;
  OS_EVENTOBJECT = 3;
  OS_GATEOBJECT = 4;
  OS_SWITCHOBJECT = 5;
  OS_MAPEVENT = 6;
  OS_DOOR = 7;
  OS_ROON = 8;

  OS_DROPITEM = 11;
  OS_PICKUPITEM = 12;
  OS_HEAVYHIT = 13;
  OS_WALK = 14;
  OS_RUN = 15;
  OS_HORSERUN = 16;
  OS_SAFEAREA = 20;
  OS_SAFEPK = 21;
  OS_SAFEMILIEU = 22;

  OT_NONE = 0;
  OT_SAFEAREA = 1;
  OT_SAFEPK = 2;
  OT_HAZARD = 3;
  OT_FREEPKAREA = 4;

  RC_PLAYOBJECT = 0;
  RC_PLAYMOSTER = 150; //人形怪物
  RC_HEROOBJECT = 66;
  RC_GUARD = 11;//大刀守卫
  RC_BOX = 30;
  RC_PEACENPC = 15;
  RC_ANIMAL = 50;
  RC_CAMION = 31;
  RC_MONSTER = 80;
  RC_NPC = 10;//NPC
  RC_ARCHERGUARD = 112;//NPC 弓箭手

  RCC_USERHUMAN = 0;
  RCC_GUARD = 12;
  RCC_MERCHANT = 50;
  RCC_OPENBOX = 25;

  ISM_WHISPER = 1234;

  LA_UNDEAD = 1;

  STATE_STONE_MODE = 1;

  STATE_OPENHEATH = 1;
  POISON_68 = 68;

  ET_DIGOUTZOMBI = 1;
  ET_PILESTONES = 3;
  ET_HOLYCURTAIN = 4;
  ET_FIRE = 5;
  ET_SCULPEICE = 6;
  ET_SHOP = 7;
  ET_INCHP = 8;
  ET_MACHINERY = 9;
  ET_RANDOMGATE = 10;

  MISSTAG_FLAGLIST = 1;
  MISSTAG_ARITHMOMETERLIST = 2;
  MISSTAG_MISSIONLIST = 3;
  MISSTAG_FLAGCHANGE = 4;
  MISSTAG_ADDMISSION = 5;
  MISSTAG_DELMISSION = 6;
  MISSTAG_UPDATEMISSION = 7;
  MISSTAG_CHANGEKILLMONCOUNT = 8;
  MISSTAG_ARITHMOMETERCHANGE = 9;
  MISSTAG_UPDATEMISSIONTIME = 10;

  UNITX = 48;
  UNITY = 32;
  HALFX = 24;
  HALFY = 16;
  MAXSHOPITEMS = 12;
  MAXBAGITEMS = 105;
  MAXMAGIC = 30;
  MAXUSEITEMS = 16;
  MAXSTORAGEITEMS = 49;
  MAXRETURNITEMS = 4;
  MAXAPPENDBAGITEMS = 3;
  MAXFLUTECOUNT = 3;
  LOGICALMAPUNIT = 30;
  MAXFRIENDS = 30;
  MAXRETURNITEMSCOUNT = 30;
  MAXEMAILCOUNT = 20;
  MAXPHOTODATASIZE = 4000;
  MAXITEMSSETUPCOUNT = 1000;
//  MAXMAKEMAGICCOUNT = 10;

  MISSIONVAR_NAKED = 1;
  MISSIONVAR_SKILL = 2;
  MISSIONVAR_MAKEITEM = 3;
  MISSIONVAR_UNSEAL = 4;
  MISSIONVAR_MAKEMAGIC_0 = 5;
  MISSIONVAR_MAKEMAGIC_1 = 6;
  MISSIONVAR_MAKEMAGIC_2 = 7;
  MISSIONVAR_MAKEMAGIC_3 = 8;
  MISSIONVAR_MAKEMAGIC_4 = 9;
  MISSIONVAR_MAKEMAGIC_5 = 10;
  MISSIONVAR_MAKEMAGIC_6 = 11;
  MISSIONVAR_MAKEMAGIC_7 = 12;
  MISSIONVAR_MAKEMAGIC_8 = 13;
  MISSIONVAR_MAKEMAGIC_9 = 14;

  mm_Weapon = 0;
  mm_Dress = 1;
  mm_Helmet = 2;
  mm_Necklace = 3;
  mm_ArmRing = 4;
  mm_Ring = 5;
  mm_Belt = 6;
  mm_Boot = 7;
  mm_Leechdom = 8;
  mm_Material = 9;
  mm_MaxCount = mm_Material;

  wx_Aurum = 1;
  wx_Wood = 2;
  wx_Water = 3;
  wx_Fire = 4;
  wx_Dust = 5;

  APE_CHECK = 1;
  APE_PLIST = 2;
  APE_MLIST = 3;
  APE_DOWN = 4;
  APE_UPDOWN = 5;
  APE_DEL = 6;
  APE_EX = 7;
  APE_CLOSE = 8;
  APE_GLIST = 9;
  APE_CLIENTCHECK = 10;

  SKILL_FIREBALL = 1;
  SKILL_HEALLING = 2;
  SKILL_ONESWORD = 3;
  SKILL_ILKWANG = 4;
  SKILL_FIREBALL2 = 5;
  SKILL_AMYOUNSUL = 6;
  SKILL_YEDO = 7;
  SKILL_FIREWIND = 8;
  SKILL_FIRE = 9;
  SKILL_SHOOTLIGHTEN = 10;
  SKILL_LIGHTENING = 11;
  SKILL_ERGUM = 12;
  SKILL_FIRECHARM = 13;
  SKILL_HANGMAJINBUB = 14;
  SKILL_DEJIWONHO = 15;
  SKILL_HOLYSHIELD = 16;
  SKILL_SKELLETON = 17;
  SKILL_CLOAK = 18;
  SKILL_BIGCLOAK = 19;
  SKILL_TAMMING = 20;
  SKILL_SPACEMOVE = 21;
  SKILL_EARTHFIRE = 22;
  SKILL_FIREBOOM = 23;
  SKILL_LIGHTFLOWER = 24;
  SKILL_BANWOL = 25;
  SKILL_FIRESWORD = 26;
  SKILL_MOOTEBO = 27;
  SKILL_SHOWHP = 28;
  SKILL_BIGHEALLING = 29;
  SKILL_SINSU = 30;
  SKILL_SHIELD = 31;
  SKILL_KILLUNDEAD = 32;
  SKILL_SNOWWIND = 33;
  SKILL_UNAMYOUNSUL = 34;
  SKILL_WINDTEBO = 35;
  SKILL_MABE = 36;
  SKILL_GROUPLIGHTENING = 37;
  SKILL_GROUPAMYOUNSUL = 38;
  SKILL_GROUPDEDING = 39;
  SKILL_40 = 40;
  SKILL_41 = 41;
  SKILL_42 = 42;
  SKILL_LONGICEHIT = 43; //开天斩
  SKILL_44 = 44;
  SKILL_45 = 45;
  SKILL_46 = 46;
  SKILL_47 = 47;
  SKILL_48 = 48;
  SKILL_49 = 49;
  SKILL_50 = 50;
  SKILL_51 = 51;
  SKILL_52 = 52;
  SKILL_53 = 53;

  SKILL_54 = 54;
  SKILL_55 = 55;
  SKILL_56 = 56;
  SKILL_57 = 57;
  SKILL_58 = 58;
  SKILL_59 = 59;

  SKILL_60 = 60;
  SKILL_61 = 61;
  SKILL_62 = 62;
  SKILL_63 = 63;
  SKILL_GODSHIELD = 64;
  SKILL_65 = 65;
  SKILL_66 = 66;
  SKILL_67 = 67;

  SKILL_70 = 70;
  SKILL_71 = 71;
  SKILL_72 = 72;

  SKILL_CBO = 100; //连击

  SKILL_110 = 110;
  SKILL_111 = 111;
  SKILL_112 = 112;
  SKILL_113 = 113;
  SKILL_114 = 114;
  SKILL_115 = 115;
  SKILL_116 = 116;
  SKILL_117 = 117;
  SKILL_118 = 118;
  SKILL_119 = 119;
  SKILL_120 = 120;
  SKILL_121 = 121;
  SKILL_122 = 122;
  SKILL_123 = 123;
  SKILL_124 = 124;

  SKILL_MAX = 2000;


  GMM_UPDATEITEM = 1;

  SM_CLOSESESSION = 5000;
  SM_RUSH = 5001;//跑动中改变方向
  SM_RUSHKUNG = 5002;//野蛮冲撞
  SM_FIREHIT = 5003;//烈火
  SM_BACKSTEP = 5004;//后退,野蛮效果? //半兽统领公箭手攻击玩家的后退

  SM_TURN = 5005;//转向
  SM_WALK = 5006;//走
  SM_SITDOWN = 5007;
  SM_RUN = 5008;//跑
  SM_HIT = 5009;//砍
  SM_HEAVYHIT = 5010;
  SM_BIGHIT = 5011;
  SM_SPELL = 5012;//使用魔法
  SM_POWERHIT = 5013;//攻杀
  SM_LONGHIT = 5014;//刺杀
  SM_DIGUP = 5015;//挖是一"起"一"坐",这里是挖动作的"起"
  SM_DIGDOWN = 5016;//挖动作的"坐"
  SM_FLYAXE = 5017;//飞斧,半兽统领的攻击方式?
  SM_LIGHTING = 5018;//免蜡开关
  SM_WIDEHIT = 5019;//半月

  SM_CRSHIT = 5020;//抱月刀
  SM_TWINHIT = 5021;//开天斩重击

  SM_ALIVE = 5022;//复活??复活戒指
  SM_MOVEFAIL = 5023;//移动失败,走动或跑动
  SM_HIDE = 5024;//隐身?
  SM_DISAPPEAR = 5025;//地上物品消失
  SM_STRUCK = 5026; //受攻击
  SM_DEATH = 5027;//正常死亡
  SM_SKELETON = 5028;//尸体
  SM_NOWDEATH = 5029;//秒杀?
  SM_ACTION_MIN = 5030;
  SM_ACTION_MAX = 5031;
  SM_ACTION2_MIN = 5032;
  SM_ACTION2_MAX = 5033;
  SM_HEAR = 5034;//有人回你的话
  SM_FEATURECHANGED = 5035;
  SM_USERNAME = 5036;
  SM_WINEXP = 5037;//获得经验
  SM_LEVELUP = 5038;//升级,左上角出现墨绿的升级字样
  SM_DAYCHANGING = 5039;//传奇界面右下角的太阳星星月亮
  SM_LOGON = 5040;//logon
  SM_NEWMAP = 5041;//新地图??
  SM_ABILITY = 5042;//打开属性对话框,F11
  SM_HEALTHSPELLCHANGED = 5043;//治愈术使你的体力增加
  SM_MAPDESCRIPTION = 5044;//地图描述,行会战地图?攻城区域?安全区域?
  SM_SPELL2 = 5045;
//对话消息
  SM_SYSMESSAGE = 5046;//系统消息,盛大一般红字,私服蓝字
  SM_GROUPMESSAGE = 5047;//组内聊天!!
  SM_CRY = 5048;//喊话
  SM_WHISPER = 5049;//私聊
  SM_GUILDMESSAGE = 5050;//行会聊天!~
  SM_ADDITEM = 5051;
  SM_BAGITEMS = 5052;
  SM_DELITEM = 5053;
  SM_UPDATEITEM = 5054;
  SM_UPDATEITEMEX = 5055;
  SM_ADDMAGIC = 5056;
  SM_SENDMYMAGIC = 5057;
  SM_DELMAGIC = 5058;
 //服务器端发送的命令 SM:server msg,服务端向客户端发送的消息

//登录、新帐号、新角色、查询角色等
  SM_CERTIFICATION_FAIL = 5059;
  SM_ID_NOTFOUND = 5060;
  SM_PASSWD_FAIL = 5061;//验证失败,"服务器验证失败,需要重新登录"??
  SM_NEWID_SUCCESS = 5062;//创建新账号成功
  SM_NEWID_FAIL = 5063;//创建新账号失败
  SM_CHGPASSWD_SUCCESS = 5064;//修改密码成功
  SM_CHGPASSWD_FAIL = 5065; //修改密码失败
  SM_GETBACKPASSWD_SUCCESS = 5066; //密码找回成功
  SM_GETBACKPASSWD_FAIL = 5067;//密码找回失败
  SM_DELHUM = 5068;
  SM_RENEWHUM = 5069;
  SM_QUERYCHR = 5070;//返回角色信息到客户端
  SM_NEWCHR_SUCCESS = 5071; //新建角色成功
  SM_NEWCHR_FAIL = 5072;//新建角色失败
  SM_DELCHR_SUCCESS = 5073;//删除角色成功
  SM_DELCHR_FAIL = 5074;//删除角色失败
  SM_STARTPLAY = 5075;//开始进入游戏世界(点了健康游戏忠告后进入游戏画面)
  SM_STARTFAIL = 5076;//开始失败,玩传奇深有体会,有时选择角色,点健康游戏忠告后黑屏
  SM_QUERYCHR_FAIL = 5077;//返回角色信息到客户端失败
  SM_OUTOFCONNECTION = 5078;//超过最大连接数,强迫用户下线
  SM_PASSOK_SELECTSERVER = 5079;//密码验证完成且密码正确,开始选服
  SM_SELECTSERVER_OK = 5080;//选服成功
  SM_NEEDUPDATE_ACCOUNT = 5081;//需要更新,注册后的ID会发生什么变化?私服中的普通ID经过充值??或者由普通ID变为会员ID,GM?
  SM_UPDATEID_SUCCESS = 5082; //更新成功
  SM_UPDATEID_FAIL = 5083;//更新失败
  SM_DROPITEM_SUCCESS = 5084;
  SM_DROPITEM_FAIL = 5085;
  SM_ITEMSHOW = 5086;
  SM_ITEMHIDE = 5087;
  SM_OPENDOOR_OK = 5088;//通过过门点成功
  SM_OPENDOOR_LOCK = 5089;//发现过门口是封锁的,以前盛大秘密通道去赤月的门要5分钟开一次
  SM_CLOSEDOOR = 5090;//用户过门,门自行关闭
  SM_TAKEON_OK = 5091;
  SM_TAKEON_FAIL = 5092;
  SM_TAKEOFF_OK = 5093;
  SM_TAKEOFF_FAIL = 5094;
  SM_SENDUSEITEMS = 5095;
  SM_WEIGHTCHANGED = 5096;
  SM_CHANGEMAP = 5098;//地图改变,进入新地图
  SM_EAT_OK = 5099;
  SM_EAT_FAIL = 5100;
  SM_BUTCH = 5101;//野蛮?
  SM_MAGICFIRE = 5102;//地狱火,火墙??
  SM_MAGICFIRE_FAIL = 5103;
  SM_MAGIC_LVEXP = 5104;
  SM_BAG_DURACHANGE = 5105;
  SM_DURACHANGE = 5106;
  SM_MERCHANTSAY = 5107;
  SM_MERCHANTDLGCLOSE = 5108;
  SM_SENDGOODSLIST = 5109;
  SM_GETRETURNITEMS = 5110;
  SM_MAPAPOISE = 5111;
  SM_USERSELLITEM_OK = 5112;
  SM_USERSELLITEM_FAIL = 5113;
  SM_BUYITEM_SUCCESS = 5114;
  SM_BUYITEM_FAIL = 5115;
  SM_SENDDETAILGOODSLIST = 5116;
  SM_GOLDCHANGED = 5117;
  SM_ITEMSTRENGTHEN = 5118;
  SM_USERKEYSETUP = 5119;
  SM_CHANGENAMECOLOR = 5120;//名字颜色改变,白名,灰名,红名,黄名
  SM_CHARSTATUSCHANGED = 5121;
  SM_SENDNOTICE = 5122;//发送健康游戏忠告(公告)
  SM_GROUPMODECHANGED = 5123;//组队模式改变
  SM_CREATEGROUP_OK = 5124;
  SM_CREATEGROUP_FAIL = 5125;
  SM_GROUPADDMEM_OK = 5126;
  SM_GROUPDELMEM_OK = 5127;
  SM_GROUPADDMEM_FAIL = 5128;
  SM_GROUPDELMEM_FAIL = 5129;
  SM_GROUPCANCEL = 5130;
  SM_GROUPMEMBERS = 5131;
  SM_USERSHOPSAY = 5132;
  SM_USERREPAIRITEM_OK = 5133;
  SM_USERREPAIRITEM_FAIL = 5134;
  SM_OPENARMSTRENGTHENDLG = 5135;
  SM_DEALMENU = 5136;
  SM_DEALTRY_FAIL = 5137;
  SM_DEALADDITEM_OK = 5138;
  SM_DEALADDITEM_FAIL = 5139;
  SM_DEALDELITEM_OK = 5140;
  SM_DEALDELITEM_FAIL = 5141;
  SM_DEALCANCEL = 5142;
  SM_DEALREMOTEADDITEM = 5143;
  SM_DEALREMOTEDELITEM = 5144;
  SM_DEALCHGGOLD_OK = 5145;
  SM_DEALCHGGOLD_FAIL = 5146;
  SM_DEALREMOTECHGGOLD = 5147;
  SM_DEALSUCCESS = 5148;
  SM_STORAGEGOLDCHANGE = 5149;
  SM_STORAGE_OK = 5150;
  SM_STORAGE_FAIL = 5152;
  SM_SAVEITEMLIST = 5153;
  SM_TAKEBACKSTORAGEITEM_OK = 5154;
  SM_TAKEBACKSTORAGEITEM_FAIL = 5155;
  SM_BUYRETURNITEM_OK = 5151;
  SM_BUYRETURNITEM_FAIL = 5156;
  SM_AREASTATE = 5157; //周围状态
  SM_MYSTATUS = 5158;//我的状态,最近一次下线状态,如是否被毒,挂了就强制回城
  SM_DELITEMS = 5159;
  SM_READMINIMAP_OK = 5160;
  SM_READMINIMAP_FAIL = 5161;
  SM_SENDUSERMAKEDRUGITEMLIST = 5162;
  SM_MAKEDRUG = 5163;
  SM_GOLDPOINTCHANGED = 5164;
  SM_GUILDCHANGE = 5165;
  SM_SENDUSERSTATE = 5166;
  SM_SUBABILITY = 5167;//打开输助属性对话框
  SM_OPENGUILDDLG = 5168;
  SM_OPENGUILDDLG_FAIL = 5169;
  SM_SENDGUILDMEMBERLIST = 5170;
  SM_GUILDADDMEMBER_OK = 5171;
  SM_GUILDADDMEMBER_FAIL = 5172;
  SM_GUILDDELMEMBER_OK = 5173;
  SM_GUILDDELMEMBER_FAIL = 5174;
  SM_GUILDRANKUPDATE_FAIL = 5175;
  SM_BUILDGUILD_OK = 5176;
  SM_BUILDGUILD_FAIL = 5177;
  SM_DONATE_OK = 5178;
  SM_DONATE_FAIL = 5179;
  SM_MENU_OK = 5180;
  SM_GUILDMAKEALLY_OK = 5181;
  SM_GUILDMAKEALLY_FAIL = 5182;
  SM_GUILDBREAKALLY_OK = 5183;
  SM_GUILDBREAKALLY_FAIL = 5184;
  SM_DLGMSG = 5185;
  SM_SPACEMOVE_HIDE = 5186;//道士走一下隐身
  SM_SPACEMOVE_SHOW = 5187;//道士走一下由隐身变为现身
  SM_RECONNECT = 5188;//与服务器重连
  SM_GHOST = 5189;//尸体清除,虹魔教主死的效果?
  SM_SHOWEVENT = 5190;//显示事件
  SM_HIDEEVENT = 5191;//隐藏事件
  SM_SPACEMOVE_HIDE2 = 5192;
  SM_SPACEMOVE_SHOW2 = 5193;
  SM_ADJUST_BONUS = 5195;
  SM_GETSHOPLIST = 5228;
  SM_CLIENTBUYITEM = 5229;
  SM_TAXISLIST = 5230;
  SM_TAXISLIST_FAIL = 5231;
  SM_OPENHEALTH = 5232;
  SM_CLOSEHEALTH = 5233;
  SM_BREAKWEAPON = 5234;//武器破碎
  SM_INSTANCEHEALGUAGE = 5235;//实时治愈
  SM_CHANGEFACE = 5236;//变脸,发型改变?
  SM_VERSION_FAIL = 5237;//客户端版本验证失败
  SM_ITEMUPDATE = 5238;
  SM_MONSTERSAY = 5239;
  SM_EXCHGTAKEON_OK = 5240;
  SM_EXCHGTAKEON_FAIL = 5241;
  SM_TEST = 5242;
  SM_THROW = 5243;
  SM_40 = 5244;
  SM_41 = 5245;
  SM_42 = 5246;
  SM_43 = 5247;
  SM_HORSERUN = 5248;
  SM_716 = 5249;
  SM_PASSWORD = 5250;
  SM_PLAYDICE = 5251;
  SM_PASSWORDSTATUS = 5252;
  SM_GAMEGOLDNAME = 5253;
  SM_SERVERCONFIG = 5254;
  SM_GETREGINFO = 5255;
  SM_NEEDPASSWORD = 5256;
  SM_SHOWEFFECT = 5257;
  SM_HINTMSG = 5258;
  SM_GROUPINFO1 = 5259;
  SM_GROUPINFO2 = 5260;
  SM_BAG_DURACHANGE2 = 5261;
  SM_CHECKMSG = 5262;
  SM_GROUPADDITEM = 5263;
  SM_MAKEITEM = 5264;
  SM_USERSHOPCHANGE = 5265;
  SM_GAMEGOLDNAME2 = 5266;
  SM_GETSAYITEM = 5267;
  SM_CHECKMATRIXCARD = 5268;
  SM_FRIEND_LOGIN = 5269;
  SM_EMAIL = 5270;
  SM_CHANGEITEMDURA_OK = 5271;
  SM_CHANGEITEMDURA_FAIL = 5272;
  SM_NAKEDABILITY = 5273;
  SM_REALITYINFO = 5274;
  SM_UPLOADUSERPHOTO = 5275;
  SM_UPLOADUSERPHOTO_FAIL = 5276;
  SM_TAKEOFFADDBAG_OK = 5277;
  SM_TAKEOFFADDBAG_FAIL = 5278;
  SM_TAKEONADDBAG_OK = 5279;
  SM_TAKEONADDBAG_FAIL = 5280;
  SM_SENDADDBAGITEMS = 5281;
  SM_GUILDGOLDCHANGE_FAIL = 5282;
  SM_USERSHOPGOLDCHANGE = 5283;
  SM_USEROPENSHOP = 5284;
  SM_BUYUSERSHOP = 5097;
  SM_GETUSERSHOPLIST = 5285;
  SM_USERSHOPITEMCHANGE = 5286;
  SM_STORAGEINFO = 5287;
  SM_GETBACKPASSWORD = 5288;
  SM_110 = 5289;
  SM_111 = 5290;
  SM_112 = 5291;
  SM_113 = 5292;
  SM_122 = 5293;
  SM_56 = 5294;
  SM_RUSHCBO = 5295;
  SM_LEAP = 5296;
  SM_SHOWBAR = 5297;
  SM_UNSEAL = 5298;
  SM_UNSEAL_OK = 5299;
  SM_BAGUSEITEM = 5300;
  SM_CLIENTBUYSHOPITEM = 5301;
  SM_GAMESETUPINFO = 5302;
  SM_BUGLE = 5303;
  SM_UPDATEUSERITEM = 5304;
  SM_MAGICFIRE_CBO = 5305;
  SM_DOCTORALIVE = 5306;
  SM_MISSIONINFO = 5307;
  SM_AUTOMOVE = 5308;
  SM_SERVERTIME = 5309;
  SM_APPEND = 5310;
  SM_APPENDCHECK_OK = 5311;
  SM_APPENDCHECK_FAIL = 5312;
  SM_APPENDPLIST = 5313;
  SM_APPENDMLIST = 5314;
  SM_APPENDDATA = 5315;
  SM_APPENDUPDATA = 5316;
  SM_APPENDDEL = 5317;
  SM_APPENDEX = 5318;
  SM_APPENDCLOSE = 5319;
  SM_APPENDGLIST = 5320;
  SM_APPENDOBJECTCLOSE = 5321;
  SM_SENDINFO = 5322;
  SM_FBTIME = 5323;
  SM_OPENBOX = 5324;
  SM_OPENBOXINFO = 5325;
  SM_CLOSEBAR = 5326;
  SM_TAKEON_AUTO = 5327;
  SM_CHANGEMAP_OLD = 5328;
  SM_CHANGEEFFIGYSTATE = 5329;
  SM_GETUSERSHOPLIST_OFFLINE = 5330;
  SM_CLIENTDATAFILE = 5331;
  SM_MAKEMAGIC = 5332;
  SM_MAKEDRUG_AUTO = 5333;
  SM_SPACEMOVE_SHOW3 = 5334;
  SM_SPACEMOVE_HIDE3 = 5335;
  SM_HIT_2 = 5336;
  SM_HIT_3 = 5337;
  SM_HIT_4 = 5338;
  SM_HIT_5 = 5339;
  SM_MONMAGIC = 5340;
  SM_GETTOPINFO = 5341;
  SM_GAMEGOLDNAME3 = 5342;
  SM_TOPMSG = 5343;
  SM_REMOVESTONE = 5344;
  SM_REMOVESTONE_BACK = 5345;
  SM_AD_FRAME = 5346;
  SM_AD_EXIT = 5347;
  SM_OPENURL = 5348;
  SM_FILTERINFO = 5349;
  SM_CENTERMSG = 5350;
  SM_STATUSMODE = 5351;
  SM_LONGICEHIT_L = 5352;
  SM_LONGICEHIT_S = 5353;
  SM_MAGICMOVE = 5354;
  SM_MAGICFIR = 5355;
  SM_SETITEMS = 5356;
  SM_HINTDATA = 5357;
  SM_REFICONINFO = 5358;
  SM_REFHUMLOOK = 5359;
  SM_CLEARCENTERMSG = 5360;
  SM_OPENARMABILITYMOVEDLG = 5361;
  SM_ITEMABILITYMOVE = 5362;
  SM_COMPOUNDINFOS = 5363;
  SM_COMPOUNDITEM = 5364;
  SM_ABILITYMOVESET = 5365;

  //移动指定
  CM_TURN = 1;
  CM_WALK = 2;
  CM_SITDOWN = 3;
  CM_RUN = 4;
  CM_HORSERUN = 5;
  CM_LEAP = 6;
  //移动指定

  //攻击指令 要保持指令连续
  TM_HITSTATE = 7;
  CM_HIT = 7;
  CM_HEAVYHIT = 8;
  CM_BIGHIT = 9;
  CM_POWERHIT = 10;
  CM_LONGHIT = 11;
  CM_WIDEHIT = 12;
  CM_FIREHIT = 13;
  CM_CRSHIT = 14;
  CM_TWNHIT = 15;
  CM_TWINHIT = 16;
  CM_110 = 17;
  CM_111 = 18;
  CM_112 = 19;
  CM_113 = 20;
  CM_122 = 21;
  CM_56 = 22;
  TM_HITSTOP = 22;
  //攻击指令

  //以上项不要更改

  CM_BUTCH = 23;
  CM_SPELL = 24; //施魔法
  CM_QUERYUSERNAME = 25;//进入游戏,服务器返回角色名到客户端
  CM_DROPITEM = 26;//从包裹里扔出物品到地图,此时人物如果在安全区可能会提示安全区不允许扔东西
  CM_PICKUP = 27;//捡东西
  CM_TAKEONITEM = 28;//装配装备到身上的装备位置
  CM_TAKEOFFITEM = 29;//从身上某个装备位置取下某个装备
  CM_EAT = 30;//吃药
  CM_USERKEYSETUP = 31;
  CM_1005 = 32;
//与商店NPC交易相关
  CM_CLICKNPC = 33;//用户点击了某个NPC进行交互
  CM_MERCHANTDLGSELECT = 34;//商品选择,大类
  CM_ITEMSTRENGTHEN = 35;
  CM_USERSELLITEM = 36;//用户卖东西
  CM_USERBUYITEM = 37;//用户买入东西
  CM_DROPGOLD = 38;//用户放下金钱到地上
  CM_LOGINNOTICEOK = 39;//健康游戏忠告点了确实,进入游戏
  CM_GROUPMODE = 40;//关组还是开组
  CM_CREATEGROUP = 41;//新建组队
  CM_ADDGROUPMEMBER = 42;//组内添人
  CM_DELGROUPMEMBER = 43;//组内删人
  CM_USERREPAIRITEM = 44;//用户修理东西
  CM_MAPAPOISE = 45;
  CM_DEALTRY = 46; //开始交易,交易开始
  CM_DEALADDITEM = 47;//加东东到交易物品栏上
  CM_DEALDELITEM = 48;//从交易物品栏上撤回东东???好像不允许哦
  CM_DEALCANCEL = 49;//取消交易
  CM_DEALCHGGOLD = 50;//本来交易栏上金钱为0,,如有金钱交易,交易双方都会有这个消息
  CM_DEALEND = 51;//交易成功,完成交易
  CM_USERSTORAGEITEM = 52; //用户寄存东西
  CM_USERTAKEBACKSTORAGEITEM = 53;//用户向保管员取回东西
  CM_WANTMINIMAP = 54; //用户点击了"小地图"按钮
  CM_USERMAKEDRUGITEM = 55;//用户制造毒药(其它物品)
  CM_OPENGUILDDLG = 56;//用户点击了"行会"按钮
  CM_GUILDHOME = 57;//点击"行会主页"
  CM_GUILDMEMBERLIST = 58;//点击"成员列表"
  CM_GUILDADDMEMBER = 59; //增加成员
  CM_GUILDDELMEMBER = 60;//踢人出行会
  CM_GUILDUPDATENOTICE = 61;//修改行会公告
  CM_GUILDUPDATERANKINFO = 62;//更新联盟信息(取消或建立联盟)
  CM_STORAGEGOLDCHANGE = 63;
  CM_SPEEDHACKUSER = 64;//用户加速作弊检测
  CM_SHOPGETLIST = 65;
  CM_SHOPBUYITEMBACK = 66;
  CM_SHOPGETGAMEPOINT = 67;
  CM_APPEND = 68;
  CM_CLICKUSERSHOP = 69;
  CM_BUYUSERSHOP = 70;
  CM_QUERYCHR = 71;
  CM_THROW = 72;
  CM_SAY = 73;//角色发言
  CM_40HIT = 74;
  CM_41HIT = 75;
  CM_42HIT = 76;
  CM_43HIT = 77;
  CM_QUERYUSERSTATE = 78;//查询用户状态(用户登录进去,实际上是客户端向服务器索取查询最近一次,退出服务器前的状态的过程,
                         //服务器自动把用户最近一次下线以让游戏继续的一些信息返回到客户端)
  CM_QUERYBAGITEMS = 79;//查询包裹物品
  CM_QUERYUSERSET = 80;
  CM_OPENDOOR = 81;//开门,人物走到地图的某个过门点时
  CM_SOFTCLOSE = 82;//退出传奇(游戏程序,可能是游戏中大退,也可能时选人时退出)
  CM_GUILDALLY = 83;
  CM_GUILDBREAKALLY = 84;
  CM_UPDATESERVER = 85;
  CM_IDPASSWORD = 86;
  CM_ADDNEWUSER = 87;
  CM_CHANGEPASSWORD = 88;
  CM_UPDATEUSER = 89;
  CM_GMUPDATESERVER = 90;
  CM_POWERBLOCK = 91;
  CM_CHECKMSG = 92;
  CM_MAKEITEM = 93;
  CM_GETSAYITEM = 94;
  CM_CHECKMATRIXCARD = 95;
  CM_FRIEND_CHENGE = 96;
  CM_EMAIL = 97;
  CM_CHANGEITEMDURA = 98;
  CM_NAKEDABILITYCHANGE = 99;
  CM_REALITYINFO = 100;
  CM_SAVEUSERPHOTO = 101;
  CM_TAKEONOFFADDBAG = 102;
  CM_GUILDGOLDCHANGE = 103;
  CM_USERSHOPCHANGE = 104;
  CM_GETBACKSTORAGE = 105;
  CM_GETBACKSTORAGEPASS = 106;
  CM_QUERYRETURNITEMS = 107;
  CM_USERBUYRETURNITEM = 108;
  CM_USERSHOPSAY = 109;
  CM_NEWCHR = 110;
  CM_DELCHR = 111;
  CM_SELCHR = 112;
  CM_SELECTSERVER = 113;
  CM_VIEWDELHUM = 114;
  CM_RENEWHUM = 115;
  CM_GETBACKPASSWORD = 116;
  CM_ALIVE = 117;
  CM_CBOMAGIC = 118;
  CM_UNSEAL = 119;
  CM_BAGUSEITEM = 120;
  CM_GAMESETUPINFO = 121;
  CM_APPENDCLIENT = 122;
  CM_GUILDLEVELUP = 123;
  CM_OPENBOX = 124;
  CM_CLICKBOX = 125;
  CM_CLEARMISSION = 126;
  CM_LOGINNOTICEOK_EX = 127;
  CM_GUAGEBAR = 128;
  CM_MAKEMAGIC = 129;
  CM_GETTOPINFO = 130;
  CM_MISSIONSTATECHANGE = 131;
  CM_REMOVESTONE = 132;
  CM_SPEEDCLOSE = 133;
  CM_CENTERMSG_CLICK = 134;
  CM_LONGICEHIT = 135;
  CM_SETMAGICKEY = 136;
  CM_ITEMABILITYMOVE = 137;
  CM_COMPOUNDITEM = 138;

  RG_MINMSGINDEX = 1;
  RG_MAXMSGINDEX = 150;

  RM_TURN = 1 + RG_MAXMSGINDEX;
  RM_WALK = 2 + RG_MAXMSGINDEX;
  RM_RUN = 3 + RG_MAXMSGINDEX;
  RM_HIT = 4 + RG_MAXMSGINDEX;
  RM_SPELL = 5 + RG_MAXMSGINDEX;
  RM_PUSH = 6 + RG_MAXMSGINDEX;
  RM_RUSH = 7 + RG_MAXMSGINDEX;
  RM_STRUCK = 8 + RG_MAXMSGINDEX;
  RM_DEATH = 9 + RG_MAXMSGINDEX;
  RM_DISAPPEAR = 10 + RG_MAXMSGINDEX;
  RM_MAGSTRUCK = 11 + RG_MAXMSGINDEX;
  RM_MAGSTRUCK_MINE = 12 + RG_MAXMSGINDEX;
  RM_STRUCK_MAG = 13 + RG_MAXMSGINDEX;
  RM_10101 = 14 + RG_MAXMSGINDEX;
  RM_10155 = 15 + RG_MAXMSGINDEX;
  RM_HEAR = 16 + RG_MAXMSGINDEX;
  RM_DELAYPUSHED = 17 + RG_MAXMSGINDEX;
  RM_CRY = 18 + RG_MAXMSGINDEX;
  RM_POISON = 19 + RG_MAXMSGINDEX;
  RM_TRANSPARENT = 20 + RG_MAXMSGINDEX;
  RM_USERNAME = 21 + RG_MAXMSGINDEX;
  RM_LEVELUP = 22 + RG_MAXMSGINDEX;
  RM_CHANGENAMECOLOR = 23 + RG_MAXMSGINDEX;
  RM_LOGON = 24 + RG_MAXMSGINDEX;
  RM_HEALTHSPELLCHANGED = 25 + RG_MAXMSGINDEX;
  RM_SYSMESSAGE = 26 + RG_MAXMSGINDEX;
  RM_GROUPMESSAGE = 27 + RG_MAXMSGINDEX;
  RM_GUILDMESSAGE = 28 + RG_MAXMSGINDEX;
  RM_ITEMSHOW = 29 + RG_MAXMSGINDEX;
  RM_ITEMHIDE = 30 + RG_MAXMSGINDEX;
  RM_DOOROPEN = 31 + RG_MAXMSGINDEX;
  RM_DOORCLOSE = 32 + RG_MAXMSGINDEX;
  RM_FEATURECHANGED = 33 + RG_MAXMSGINDEX;
  RM_CHANGEMAP = 34 + RG_MAXMSGINDEX;
  RM_BUTCH = 35 + RG_MAXMSGINDEX;
  RM_MAGICFIRE = 36 + RG_MAXMSGINDEX;
  RM_SKELETON = 37 + RG_MAXMSGINDEX;
  RM_CHARSTATUSCHANGED = 38 + RG_MAXMSGINDEX;
  RM_DIGUP = 39 + RG_MAXMSGINDEX;
  RM_DIGDOWN = 40 + RG_MAXMSGINDEX;
  RM_FLYAXE = 41 + RG_MAXMSGINDEX;
  RM_LIGHTING = 42 + RG_MAXMSGINDEX;
  RM_SPACEMOVE_SHOW = 43 + RG_MAXMSGINDEX;
  RM_RECONNECTION = 44 + RG_MAXMSGINDEX;
  RM_SPACEMOVE_SHOW2 = 45 + RG_MAXMSGINDEX;
  RM_OPENHEALTH = 46 + RG_MAXMSGINDEX;
  RM_CLOSEHEALTH = 47 + RG_MAXMSGINDEX;
  RM_DOOPENHEALTH = 48 + RG_MAXMSGINDEX;
  RM_CHANGEFACE = 49 + RG_MAXMSGINDEX;
  RM_MONMOVE = 50 + RG_MAXMSGINDEX;
  RM_10205 = 51 + RG_MAXMSGINDEX;
  RM_ALIVE = 52 + RG_MAXMSGINDEX;
  RM_SENDDELITEMLIST = 53 + RG_MAXMSGINDEX;
  RM_LEAP = 54 + RG_MAXMSGINDEX;
  RM_USERBIGSTORAGEITEM = 55 + RG_MAXMSGINDEX;
  RM_USERBIGGETBACKITEM = 56 + RG_MAXMSGINDEX;
  RM_SPACEMOVE_FIRE2 = 57 + RG_MAXMSGINDEX;
  RM_SPACEMOVE_FIRE = 58 + RG_MAXMSGINDEX;
  RM_PLAYDICE = 59 + RG_MAXMSGINDEX;
  RM_GAMEGOLDCHANGED = 60 + RG_MAXMSGINDEX;
  RM_HORSERUN = 61 + RG_MAXMSGINDEX;
  RM_MOVEFAIL = 62 + RG_MAXMSGINDEX;
  RM_RUSHKUNG = 63 + RG_MAXMSGINDEX;
  RM_SHOPGETGAMEPOINT = 64 + RG_MAXMSGINDEX;
  RM_MAGICFIREFAIL = 65 + RG_MAXMSGINDEX;
  RM_BREAKWEAPON = 66 + RG_MAXMSGINDEX;
  RM_SHOWEFFECT = 67 + RG_MAXMSGINDEX;
  RM_ZEN_BEE = 68 + RG_MAXMSGINDEX;
  RM_MAGHEALING = 69 + RG_MAXMSGINDEX;
  RM_DELAYMAGIC = 70 + RG_MAXMSGINDEX;
  RM_CREATENEWGUILD = 71 + RG_MAXMSGINDEX;
  RM_SHOPGAMEGOLDCHANGE = 72 + RG_MAXMSGINDEX;
  RM_SHOPGETPOINT = 73 + RG_MAXMSGINDEX;
  RM_USEROPENSHOP = 74 + RG_MAXMSGINDEX;
  RM_DEFMESSAGE = 75 + RG_MAXMSGINDEX;
  RM_DEFSOCKET = 76 + RG_MAXMSGINDEX;
  RM_RUSHCBO = 77 + RG_MAXMSGINDEX;
  RM_BUGLE = 78 + RG_MAXMSGINDEX;
  RM_DELAYMAGIC2 = 79 + RG_MAXMSGINDEX;
  RM_RANDOMMOVE = 80 + RG_MAXMSGINDEX;
  RM_OFFLINESHOP = 81 + RG_MAXMSGINDEX;
  RM_SPACEMOVE_SHOW3 = 82 + RG_MAXMSGINDEX;
  RM_SPACEMOVE_FIRE3 = 83 + RG_MAXMSGINDEX;
  RM_MONMAGIC = 84 + RG_MAXMSGINDEX;
  RM_GETLARGESSGOLD = 85 + RG_MAXMSGINDEX;
  RM_MAGICMOVE = 86  + RG_MAXMSGINDEX;
  RM_MAKEPOISON = 87 + RG_MAXMSGINDEX;
  RM_MAGICFIR = 88  + RG_MAXMSGINDEX;
  RM_REFICONINFO = 89 + RG_MAXMSGINDEX;

  MAXCLIENTSERVERCOUNT = 91 + RG_MAXMSGINDEX;

  EFFECT_DEADLINESS = 10; //爆击
  EFFECT_VAMPIRE = 11; //吸血
  EFFECT_MISSION_ACCEPT = 12; //接受任务
  EFFECT_MISSION_NEXT = 13; //步骤完成
  EFFECT_MISSION_COMPLETE = 14; //任务完成
  EFFECT_DARE_WIN = 15; //挑战赢了
  EFFECT_DARE_LOSS = 16; //挑战输了
  EFFECT_BEACON_1 = 17;   //暂留
  EFFECT_BEACON_2 = 18;   //宝宝升级
  EFFECT_BEACON_3 = 19;   //双倍经验
  EFFECT_BEACON_4 = 20;   //一心一意
  EFFECT_BEACON_5 = 21;   //心心相印
  EFFECT_BEACON_6 = 22;   //飞火流星
  EFFECT_BEACON_7 = 23;   //浪漫星雨
  EFFECT_BEACON_8 = 24;   //绮梦幻想
  EFFECT_BEACON_9 = 25;   //长空火舞
  EFFECT_BEACON_10 = 26;   //如雾似梦
  EFFECT_LEVELUP = 27; //人物升级
  EFFECT_SHIELD = 28; //护体神盾

  {Effect_75 = 75;
  Effect_76 = 76;
  Effect_77 = 77;
  Effect_78 = 78;
  Effect_79 = 79;
  Effect_80 = 80;
  Effect_81 = 81;
  Effect_82 = 82;
  Effect_83 = 83;
  Effect_84 = 84;
  Effect_85 = 85;
  Effect_86 = 86;
  Effect_87 = 87;
  Effect_88 = 88;
  Effect_89 = 89;
  Effect_100 = 100;
  Effect_THUNDER = 110;
  Effect_LAVA = 111; }


 { tn_AC2 = 0;
  tn_MAC2 = 1;
  tn_DC2 = 2;
  tn_MC2 = 3;
  tn_SC2 = 4;
  tn_AC = 5;
  tn_MAC = 6;
  tn_DC = 7;
  tn_MC = 8;
  tn_SC = 9;
  tn_HP = 10;
  tn_MP = 11;
  //tn_Need = 12;
  //tn_NeedLevel = 13;
  tn_unknown2 = 12;
  tn_Count = 13;   }

  tb_AC2 = 0;
  tb_MAC2 = 1;
  tb_DC2 = 2;
  tb_MC2 = 3;
  tb_SC2 = 4;
  tb_AC = 5;
  tb_MAC = 6;
  tb_DC = 7;
  tb_MC = 8;
  tb_SC = 9;
  tb_HP = 10;
  tb_MP = 11;
  tb_Hit = 12;         //准确
  tb_Speed = 13;       //敏捷
  tb_Strong = 14;     //武器强度
  tb_AntiMagic = 15;    //魔法躲避
  tb_PoisonMagic = 16;   //毒特躲避
  tb_HealthRecover = 17;  //体力恢复
  tb_SpellRecover = 18;   //魔法恢复
  tb_PoisonRecover = 19;  //毒物恢复
  tb_Luck = 20;         //幸运
  tb_UnLuck = 21;       //诅咒
  tb_AddAttack = 22;     //伤害加成
  tb_DelDamage = 23;     //伤害吸收
  tb_AddWuXinAttack = 24;    //五行攻击
  tb_DelWuXinAttack = 25;    //五行防御
  tb_Deadliness = 26; //致命一击
  //tb_CompoundLV = 27;  //合成等级
  //tb_ItemNameColor = 28;  //装备名称颜色
  //tb_unknown1 = 29;      //沙巴克炼武器
  tb_Count = 27;
  //tb_HitSpeed = 20;   //攻击速度

  {Is_Lock = 0;    tb_WuXin = 22;         //五行属性
  Is_UnKnow = 1;  tb_StrengthenCount = 28;   //强化数量
  Is_Shine = 2;
            
   }

  Ib_NoDeal = 0;    //不可交易
  Ib_NoSave = 1;    //不可存仓
  Ib_NoRepair = 2;  //不可修理
  Ib_NoDrop = 3;    //不可丢弃
  Ib_NoDown = 4;    //永不掉落
  Ib_NoMake = 5; //不可强化
  Ib_NoSell = 6; //不可卖给商店
  Ib_DropDestroy = 7;  //丢弃消失

  Ib2_Unknown = 0; //未开光
  //Ib2_Bind = 1; //是否已绑定
  //  Ib2_BindGold = 1;   //绑定金币购买

  II_Publicity = 31; //公开
  II_Show = 30;
  II_PickUp = 29;
  II_Color = 28;
  II_Hint = 27;

  

  Itas_Ac = 1;      //宝石加防御
  Itas_Mac = 2;     //宝石加魔御
  Itas_Dc = 3;      //宝石加攻击
  Itas_Mc = 4;      //宝石加魔法
  Itas_Sc = 5;      //宝石加道术
  Itas_Hp = 6;      //宝石加生命
  Itas_Mp = 7;      //宝石加魔法值

  RULE_MAKE = 0; //打造物品提示
  RULE_DOWNHINT = 1; //掉落提示
  RULE_BOX = 2; //宝箱提示
  RULE_NOTAKEOFF = 3; //宝箱提示
  RULE_COUNT = 4;// 总数量

  M2SETUP_SHOWSTRENGTHENINFO = 0;
  M2SETUP_SHOWCBOFORM = 1;
  M2SETUP_SHOWMAKEMAGICFORM = 2;
  M2SETUP_SHOWWARLONGWIDE = 3;
  M2SETUP_NOTSHIFTKEY = 4;
  M2SETUP_CANCELDROPITEMHINT = 5;
type

  TOnActionType = (AT_Walk, AT_Pushed, AT_Hit, AT_Spell, AT_ChangeMap, AT_Struck);

  TOnActionTypeArr = set of TOnActionType;

  TStdMode = (tm_Drug, tm_Restrict, tm_Reel, tm_Book, tm_Weapon, tm_Rock,
    tm_Cowry, tm_AddBag, tm_House, tm_Dress, tm_Helmet, tm_Necklace, tm_Ring, tm_ArmRing, tm_Amulet, tm_Belt,
    tm_Boot, tm_Stone, tm_Light, tm_Open, tm_Flesh, tm_Ore, tm_Dice,
    tm_Mission, tm_MissionSP, tm_MakeStone, tm_MakeProp, tm_MakePropSP, tm_unknown, tm_ResetStone,
    tm_Prop, tm_PropSP, tm_Revive, tm_Rein, tm_Bell, tm_Saddle, tm_Decoration, tm_Nail);

  TStdModeEx = set of (sm_Arming, sm_ArmingStrong, sm_Superposition, sm_Eat, sm_Mission, sm_HorseArm);

  TMagicMode = set of (mm_Attack, mm_Passiveness, mm_Warr, mm_MagLock, mm_Open);

  TBindMode = (bm_NoDeal, bm_NoSave, bm_NoRepair, bm_NoDrop, bm_NoDown, bm_NoMake, bm_NoSell, bm_DropDestroy, bm_Unknown);

  TBindModeArr = set of TBindMode;

  //TStditemMode = set of TStdMode;

  TMonStatus = (s_KillHuman, s_UnderFire, s_Die, s_MonGen);
  TMsgColor = (c_Red, c_Green, c_Blue, c_White);
  TMsgType = (t_Notice{公告}, t_Hint{暗示}, t_System{系统}, t_Say, t_Mon, t_GM, t_Cust, t_Castle, t_Cudt);

  TDefaultMessage = packed record
    Recog: Integer;//识别码
    Ident: Word;
    Param: Word;
    tag: Word;
    Series: Word;
  end;
  pTDefaultMessage = ^TDefaultMessage;

  TSplitDateTime = packed record
    case Integer of
      1: (
        DateTime: TDateTime;
      );
      2:(
        nInt: Integer;
        wWord: Word;
        wWord2: Word;
      );
  end;

  TOSObject = packed record
    btType: Byte;
    CellObj: TObject;
    dwAddTime: LongWord;
    boObjectDisPose: Boolean;
  end;
  pTOSObject = ^TOSObject;

  TSendMessage = packed record
    wIdent: Word;
    wParam: Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    BaseObject: TObject;
    dwAddTime: LongWord;
    dwDeliveryTime: LongWord;
    boLateDelivery: Boolean;
    Buff: PChar;
  end;
  pTSendMessage = ^TSendMessage;

  TProcessMessage = record
    wIdent: Word;
    wParam: Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    BaseObject: TObject;
    boLateDelivery: Boolean;
    dwDeliveryTime: LongWord;
    sMsg: string;
  end;
  pTProcessMessage = ^TProcessMessage;

  TLoadHuman = packed record
    sAccount: string[20];
    sChrName: string[ActorNameLen];
    sUserAddr: string[15];
    nSessionID: Integer;

  end;

  TShortMessage = packed record
    Ident: Word;
    wMsg: Word;
  end;

  TMessageBodyW = packed record
    Param1: Word;
    Param2: Word;
    Tag1: Word;
    Tag2: Word;
  end;

  TMessageBodyWL = packed record
    lParam1: Integer;
    lParam2: Integer;
    lTag1: Integer;
    lTag2: Integer;
  end;

  TMessageItemWL = packed record
    lParam1: Integer;
    lParam2: Integer;
    lParam3: Integer;
    lParam4: Integer;
    lParam5: Integer;
  end;

  TStrengthenItem = packed record
    nLevelIdx: array[0..4] of Integer;
    nAssIdx: array[0..4] of Integer;
  end;

  TClientGuildInfo = packed record
    btMyRank: Byte;
    sGuildName: string[ActorNameLen];
    btMaxMeberCount: Byte;
    sCreateName: string[ActorNameLen];
    dwCreateTime: TDateTime;
    btGuildLevel: Byte;
    nGuildMoney: Integer;
    nBuildPoint: Integer; //建筑度
    nFlourishingPoint: Integer; //繁荣度
    nStabilityPoint: Integer; //安定度
    nActivityPoint: Integer; //人气度
    nLevelGuildMoney: Integer;
    nLevelBuildPoint: Integer; //建筑度
    nLevelFlourishingPoint: Integer; //繁荣度
    nLevelStabilityPoint: Integer; //安定度
    nLevelActivityPoint: Word; //人气度
    btKickMonExp: Byte;
    btKickMonAttack: Byte;
    nMaxActivityPoint: Word;
  end;

  TCharDesc = packed record
    feature: Integer;
    Status: Integer;
    btStrengthenIdx: Byte;
    btWuXin: Byte;
  end;

  TSessInfo = packed record//全局会话
    sAccount: string[16];
    sIPaddr: string[15];
    nSessionID: Integer;
    nPayMent: Integer;
    nPayMode: Integer;
    nUserCDKey: Integer;
    nGameGold: Integer;
    nCheckEMail: Integer;
    nSessionStatus: Integer;
    dwStartTick: LongWord;
    dwActiveTick: LongWord;
    nRefCount: Integer;
  end;
  pTSessInfo = ^TSessInfo;

  TQuestInfo = packed record
    wFlag: Word;
    btValue: Byte;
    nRandRage: Integer;
  end;
  pTQuestInfo = ^TQuestInfo;



  pTMakeItemInfo = ^TMakeItemInfo;
  TMakeItemInfo = packed record
    wIdent: Word;
    wCount: Word;
    boNotGet: Boolean;
  end;
  
  pTMakeItem = ^TMakeItem;
  TMakeItem = packed record
    wIdx: Word;
    ItemArr: array[0..5] of TMakeItemInfo;
    nMoney: Integer;
    btRate: Byte;
    btMaxRate: Byte;
  end;

  pTPackMakeItem = ^TPackMakeItem;
  TPackMakeItem = packed record
    btIdx: Byte;
    btLevel: Byte;
    wLevel: Word;
    sName: string[255];
    MakeItem: TMakeItem;
  end;

  pTMakeGoods = ^TMakeGoods;
  TMakeGoods = packed record //0x1C
    sName: String;
    MakeItem: TMakeItem;
    btLevel: Byte;
    wLevel: Word;
  end;


  {TScript = packed record
    boQuest: Boolean;
    QuestInfo: array[0..9] of TQuestInfo;
    nQuest: Integer;
    RecordList: TList;
  end;
  pTScript = ^TScript;   }

  {TMonItem = record
    n00: Integer;
    n04: Integer;
    sMonName: string;
    n18: Integer;
  end;
  pTMonItem = ^TMonItem;  }

  pTTopInfo = ^TTopInfo;
  TTopInfo = packed record
    sChrName: string[ActorNameLen];
    btJob: Byte;
    bySex: Byte;
    dwCount: LongWord;
  end;

  pTTopHeader = ^TTopHeader;
  TTopHeader = packed record
    btType: Byte;
    wCount: Word;
  end;

  TClientTopInfo = array[0..19] of TTopInfo;

  TItemName = record
    nItemIndex: Integer;
    nMakeIndex: Integer;
    sItemName: string;
  end;
  pTItemName = ^TItemName;

  TVarType = (vNone, vInteger, vString);

  TDynamicVar = record
    sName: string;
    VarType: TVarType;
    nInternet: Integer;
    sString: string;
  end;
  pTDynamicVar = ^TDynamicVar;

  TRecallMigic = record
    nHumLevel: Integer;
    sMonName: string;
    nCount: Integer;
    nLevel: Integer;
  end;

  TMakeMagicConfine = record
    nHumLevel: Integer;
    nMagicLevel: Integer;
  end;

  TLiteraryConfine = record
    nLiteraryCount: Integer;
    nExpRate: Integer;
  end;

  TMonSayMsg = record
    nRate: Integer;
    sSayMsg: string;
    State: TMonStatus;
    Color: TMsgColor;
  end;
  pTMonSayMsg = ^TMonSayMsg;

  TMonDrop = record
    sItemName: string;
    nDropCount: Integer;
    nNoDropCount: Integer;
    nCountLimit: Integer;
  end;
  pTMonDrop = ^TMonDrop;

  TGameCmd = packed record
    sCmd: string[25];
    nPermissionMin: Integer;
    nPermissionMax: Integer;
  end;
  pTGameCmd = ^TGameCmd;

  pTGameItemUpgradeRate = ^TGameItemUpgradeRate;
  TGameItemUpgradeRate = packed record
    nACMaxLimit: Integer;
    nACAddValueRate: Integer;
    nACAddRate: Integer;
    nMACMaxLimit: Integer;
    nMACAddValueRate: Integer;
    nMACAddRate: Integer;
    nDCMaxLimit: Integer;
    nDCAddValueRate: Integer;
    nDCAddRate: Integer;
    nMCMaxLimit: Integer;
    nMCAddValueRate: Integer;
    nMCAddRate: Integer;
    nSCMaxLimit: Integer;
    nSCAddValueRate: Integer;
    nSCAddRate: Integer;
    nCCMaxLimit: Integer;
    nCCAddValueRate: Integer;
    nCCAddRate: Integer;
  end;

  TCheckMsgClass = (tmc_Group, tmc_Friend, tmc_Guild, tmc_Naked, tmc_Deal);

  pTCheckMsg = ^TCheckMsg;
  TCheckMsg = packed record
    tClass: TCheckMsgClass;
    AllPurpose: Pointer;
    AddTime: LongWord;
  end;

  TIPaddr = record
    dIPaddr: string[15];
    sIPaddr: string[15];
  end;
  pTIPAddr = ^TIPaddr;

  TSrvNetInfo = record
    sIPaddr: string[15];
    nPort: Integer;
  end;
  pTSrvNetInfo = ^TSrvNetInfo;

  Taxis = packed record
    sName: string[14];
    sHeroName: string[14];
    nLevel: Integer;
    nExp: LongWord;
    nMaster: Integer;
  end;
  pTaxis = ^Taxis;

  TTaxisSelf = packed record
    sName: string[14];
    nLevel: Word;
  end;
  TTaxisHero = packed record
    sMasterName: string[14];
    sName: string[14];
    nLevel: Word;
  end;

  THumList = array[0..MAXTAXISCOUNT - 1] of TTaxisSelf;
  pTHumList = ^THumList;
  THeroList = array[0..MAXTAXISCOUNT - 1] of TTaxisHero;
  pTHeroList = ^THeroList;

  TClientTaxisSelf = array[0..9] of TTaxisSelf;
  TClientTaxisHero = array[0..9] of TTaxisHero;

  THumSort = packed record
    nMaxIdx: Integer;
    List: THumList;
  end;
  pTHumSort = ^THumSort;
  THeroSort = packed record
    nMaxIdx: Integer;
    List: THeroList;
  end;
  pTHeroSort = ^THeroSort;

  pTItemRule = ^TItemRule;
  TItemRule = packed record
    case Integer of
      1:(
        Rule: array[0..RULE_COUNT - 1] of Boolean; //打造物品提示
      );
      2:(
        nCheck: Integer; //用于检测是否有赋值
      );
  end;

  pTMonDropLimitInfo = ^TMonDropLimitInfo;
  TMonDropLimitInfo = packed record
    sItemName: string[14];
    nMaxCount: Integer;
    nMinCount: Integer;
    dwTime: LongWord;
  end;

  pTStdItemLimit = ^TStdItemLimit;
  TStdItemLimit = packed record
    MonDropLimit: pTMonDropLimitInfo;
  end;

  TCompoundInfo = record
    Value1: array [0 .. 6] of LongWord;
    Value2: array [0 .. 5] of Word;
    Rate: array [0 .. 13] of Byte;
    Value: Word;
  end;
  pTCompoundInfo = ^TCompoundInfo;

  TCompoundInfos = array [1 .. 4] of TCompoundInfo;
  pTCompoundInfos = ^TCompoundInfos;

  TCompoundSet = record
    Color: array [1 .. 4] of Byte;
    Gold, GameGold: array [1 .. 4] of Integer;
    DropRate: array [1 .. 4] of Byte;
    ValueLimit: Integer;
  end;

  TAbilityMoveSet = record
    BaseRate: Integer;
    Gold: Integer;
  end;

  TStdItem = packed record
    Idx: Word;
    // 物品名字，一般来说应该有一个前缀，位于人物的物品数据库中
    // 但这里为了方便开发，暂时增加了名字长度
    Name: string[24];
    StdMode2: Byte;
    StdMode: TStdMode;
    StdModeEx: TStdModeEx;
    Shape: Byte;//装配外观
    Weight: Byte;//重量
    AniCount: Byte;
    Source: Word;//源动力
    Reserved: Word; //保留
    Looks: Word;//外观，即Items.WIL中的图片索引
    Effect: Word;
    DuraMax: Word;//最大持久
    nAC: Word;
    nAC2: Word;
    nMAC: Word;
    nMAC2: Word;
    nDC: Word;
    nDC2: Word;
    nMC: Word;
    nMC2: Word;
    nSC: Word;
    nSC2: Word;
    HP: Word;
    MP: Word;
    AddAttack: Byte;
    DelDamage: Byte;
    HitPoint: Byte;
    SpeedPoint: Byte;
    Strong: Byte;
    Luck: Integer;
    HitSpeed: Byte;
    AntiMagic: Byte;
    PoisonMagic: Byte;
    HealthRecover: Byte;
    SpellRecover: Byte;
    PoisonRecover: Byte;
    AddWuXinAttack: Byte;
    DelWuXinAttack: Byte;
    Deadliness: Byte;
    Bind: Byte;
    Need: Integer;
    NeedLevel: Integer;
    Price: Integer;
    NeedIdentify: Byte;
    ExpRate: Byte;
    HPorMPRate: Byte;
    AC2Rate: Byte;
    MAC2Rate: Byte;
    Rule: pTItemRule;
    Color: Byte;
    SetItemList: TList;
  end;
  pTStdItem = ^TStdItem;

  TMonInfo = packed record
    sName: string[14];//怪物名
    btRace: Byte;//种族
    btRaceImg: Byte;//种族图像
    wAppr: Word;//形像代码
    wLevel: Word;
    btLifeAttrib: Byte;//不死系
    boUndead: Boolean;
    boNotInSafe: Boolean;
    wCoolEye: Word;//视线范围
    dwExp: LongWord;
    wMP: Word;
    wHP: Word;
    wAC: Word;
    wMAC: Word;
    wDC: Word;
    wMaxDC: Word;
    wMC: Word;
    wSC: Word;
    wSpeed: Word;
    wHitPoint: Word;//命中率
    nWalkSpeed: Integer;//行走速度
    wWalkStep: Word;//行走步伐
    wWalkWait: Word;//行走等待
    wAttackSpeed: Word;//攻击速度
    btColor: Byte;
    ItemList: TList;
    MapQuestList: TList;
  end;
  pTMonInfo = ^TMonInfo;


  pTMagic = ^TMagic;
  TMagic = packed record
    // 技能序号，每个 ID 对应一种技能，比如：火球术的 ID 是 1
    wMagicId: Word;
    // 技能名字
    sMagicName: string[24];
    // 技能效果类型
    btEffectType: Word;
    // 技能效果
    btEffect: Word;
    // 技能图标
    wMagicIcon: Word;
    // 指定职业
    btJob: Byte;
    // 延迟时间
    dwDelayTime: LongWord;
    // 间隔时间
    nInterval: LongWord;
    // 技能帧
    nSpellFrame: Word;
    // 满级时的技能消耗
    wSpell: Word;
    // 定义基础技能消耗
    btDefSpell: Word;
    // 最小伤害数值
    wPower: Word;
    // 最大伤害数值
    wMaxPower: Word;
    // 定义最小伤害（或伤害类型）
    btDefPower: Word;
    // 定义最大伤害（或伤害数值）
    btDefMaxPower: Word;
    // 技能最高等级
    btTrainLv: Byte;
    // 升级需要人物等级
    TrainLevel: array[0..9] of Byte;
    // 升级需要熟练度
    MaxTrain: array[0..9] of Integer;
    // 技能模式：
    // mm_Attack，攻击技能；
    // mm_Passiveness，被动技能：
    // mm_Warr，战士技能：
    // mm_MagLock，锁定技能：
    // mm_Open，开放技能；
    MagicMode: TMagicMode;
  end;


  pTClientGroup = ^TClientGroup;
  TClientGroup = packed record
    UserName: string[ActorNameLen];
    UserID: Integer;

    WuXin: Byte;
    //WuXinLevel: byte;
    Level: Word;
    HP, MP, MaxHP, MaxMP: Word;
    btJob, btSex: Byte;
  end;

  pTClientEMailHeader = ^TClientEMailHeader;
  TClientEMailHeader = packed record
    nIdx: Integer;
    sTitle: string[20];
    sSendName: string[ActorNameLen];
    boRead: Boolean;
    boSystem: Boolean;
    btTime: Byte;
  end;

  pTGroupMember = ^TGroupMember;
  TGroupMember = packed record
    ClientGroup: TClientGroup;
    isScreen: TObject;
  end;

  {客户端技能}
  TClientMagic = packed record
    btMagID: Word;
    Level: Byte;
    btKey: Byte;
    CurTrain: Integer;
    dwInterval: LongWord;
  end;
  PTClientMagic = ^TClientMagic;

  {用户技能}
  TUserMagic = packed record
    MagicInfo: pTMagic;
    wMagIdx: Word;//技能ID
    btLevel: Byte;//等级
    nTranPoint: Integer;//当前修练值
    dwInterval: LongWord;
    btKey: Byte;//技能快捷键
  end;
  pTUserMagic = ^TUserMagic;

  TMinMap = record
    sName: string;
    nID: Integer;
  end;
  pTMinMap = ^TMinMap;

  TMapRoute = record
    sSMapNO: string;
    nDMapX: Integer;
    nSMapY: Integer;
    sDMapNO: string;
    nSMapX: Integer;
    nDMapY: Integer;
  end;
  pTMapRoute = ^TMapRoute;

  TMapInfo = record
    sName: string;
    sMapNO: string;
    nL: Integer;
    nServerIndex: Integer;
    nNEEDONOFFFlag: Integer;
    boNEEDONOFFFlag: Boolean;
    sShowName: string;
    sReConnectMap: string;
    boSAFE: Boolean;
    boDARK: Boolean;
    boFIGHT: Boolean;
    boFIGHT3: Boolean;
    boDAY: Boolean;
    boQUIZ: Boolean;
    boNORECONNECT: Boolean;
    boNEEDHOLE: Boolean;
    boNORECALL: Boolean;
    boNORANDOMMOVE: Boolean;
    boNODRUG: Boolean;
    boMINE: Boolean;
    boNOPOSITIONMOVE: Boolean;
  end;
  pTMapInfo = ^TMapInfo;

  TUnbindInfo = packed record
    nUnbindCode: Integer;
    sItemName: string[14];
  end;
  pTUnbindInfo = ^TUnbindInfo;

  TQuestDiaryInfo = packed record
    QDDinfoList: TList;
  end;
  pTQuestDiaryInfo = ^TQuestDiaryInfo;

  TAdminInfo = packed record//管理员表
    nLv: Integer;
    sChrName: string[ActorNameLen];
    sIPaddr: string[15];
  end;
  pTAdminInfo = ^TAdminInfo;

  THumMagic = packed record//人物技能
    wMagIdx: Word;//技能ID
    btLevel: Byte;//等级
    nTranPoint: LongWord;//当前修练值
    nInterval: LongWord;
  end;
  pTHumMagic = ^THumMagic;

  {TNakedAbility = packed record
    DC: Word;
    MC: Word;
    SC: Word;
    AC: Word;
    MAC: Word;
    HP: Word;
    MP: Word;
    Hit: Word;
    Speed: Word;
    X2: Word;
  end;
  pTNakedAbility = ^TNakedAbility; }
  //SendNeakedAbility;
  pTServerNakedAddInfo = ^TServerNakedAddInfo;
  TServerNakedAddInfo = packed record
    nNakedLevelUpAddCount: Byte;
    nNakedAcCount: Byte;
    nNakedAcMaxCount: Byte;
    nNakedMacCount: Byte;
    nNakedMacMaxCount: Byte;
    nNakedDcCount: Byte;
    nNakedDcMaxCount: Byte;
    nNakedMcCount: Byte;
    nNakedMcMaxCount: Byte;
    nNakedScCount: Byte;
    nNakedScMaxCount: Byte;
    nNakedHPCount: Byte;
  end;

  pTNakedAbil = ^TNakedAbil;
  TNakedAbil = packed record
    nAc: Word;
    nMac: Word;
    nDC: Word;
    nMC: Word;
    nSC: Word;
    nHP: Word;
  end;

  pTClientNakedInfo = ^TClientNakedInfo;
  TClientNakedInfo = packed record
    NakedAbil: TNakedAbil;
    NakedAddInfo: TServerNakedAddInfo;
  end;

  pTNakedAddAbil = ^TNakedAddAbil;
  TNakedAddAbil = packed record
    nAc: Word;
    nAc2: Word;
    nMac: Word;
    nMac2: Word;
    nDC: Word;
    nDC2: Word;
    nMC: Word;
    nMC2: Word;
    nSC: Word;
    nSC2: Word;
    nHP: Word;
  end;

  pTUserRealityInfo = ^TUserRealityInfo;
  TUserRealityInfo = packed record
    sUserName: string[8];
    btOld: Byte;
    btSex: Byte;
    btProvince: Byte;
    btCity: Byte;
    btArea: Byte;
    btOnlineTime: Byte;
    sIdiograph: string[120];
    boFriendSee: Boolean;
    sPhotoID: string[16];
  end;

  TAbility = packed record
    Level: Word;
    AC: Integer; //防御
    MAC: Integer; //魔防
    DC: Integer; //攻击力
    MC: Integer; //魔法
    SC: Integer; //道术
    HP: Word;
    MP: Word;
    MaxHP: Word;
    MaxMP: Word;
    Exp: Int64;
    MaxExp: Int64;
    Weight: Word;
    MaxWeight: Word; // 背包
    WearWeight: Word;
    MaxWearWeight: Word; //负重
    HandWeight: Word;
    MaxHandWeight: Word; //腕力
  end;
  pTAbility = ^TAbility;

  {TOAbility = packed record
    Level: Word;
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    HP: Word;
    MP: Word;
    MaxHP: Word;
    MaxMP: Word;
    btReserved1: Byte;
    btReserved2: Byte;
    btReserved3: Byte;
    btReserved4: Byte;
    Exp: LongWord;
    MaxExp: LongWord;
    Weight: Word;
    MaxWeight: Word;
    WearWeight: Byte;
    MaxWearWeight: Byte;
    HandWeight: Byte;
    MaxHandWeight: Byte;
  end;
  pTOAbility = ^TOAbility;  }

  TClientAppendSubAbility = packed record
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
  end;

  TAddAbility = packed record
    HP: Word;
    MP: Word;
    AC: Word;
    AC2: Word;
    MAC: Word;
    MAC2: Word;
    DC: Word;
    DC2: Word;
    MC: Word;
    MC2: Word;
    SC: Word;
    SC2: Word;

    wAddAttack: Byte;
    wDelDamage: Byte;
    wAddWuXinAttack: Byte;
    wDelWuXinAttack: Byte;
    wHitPoint: Word;
    wSpeedPoint: Word;
    wAntiMagic: Word;
    wAntiPoison: Word;
    wPoisonRecover: Word;
    wHealthRecover: Word;
    wSpellRecover: Word;
    btLuck: Integer;//诅咒
    nHitSpeed: Integer;
    btWeaponStrong: Byte;//强度
    btDeadliness: Byte;
    btExpRate: Byte;
    btHPorMPRate: Byte;
    btAC2Rate: Byte;
    btMAC2Rate: Byte;
  end;
  pTAddAbility = ^TAddAbility;

  TWAbility = packed record
    dwExp: LongWord; //怪物经验值
    wHP: Word;
    wMP: Word;
    wMaxHP: Word;
    wMaxMP: Word;
  end;

  TMerchantInfo = packed record
    sScript: string[14];
    sMapName: string[14];
    nX: Integer;
    nY: Integer;
    sNPCName: string[40];
    nFace: Integer;
    nBody: Integer;
    boCastle: Boolean;
  end;
  pTMerchantInfo = ^TMerchantInfo;

  TSocketBuff = packed record
    Buffer: PChar;
    nLen: Integer;
  end;
  pTSocketBuff = ^TSocketBuff;

  TSendBuff = packed record
    nLen: Integer;
    Buffer: array[0..DATA_BUFSIZE - 1] of char;
  end;
  pTSendBuff = ^TSendBuff;

  pTStrengthenInfo = ^TStrengthenInfo;
  TStrengthenInfo = packed record
    btCanStrengthenCount: Byte; //可强化次数
    btStrengthenCount: Byte; //已强化次数
    btStrengthenInfo: array[0..5] of Byte;
  end;

  pTUserItemValueArray = ^TUserItemValueArray;
  TUserItemValueArray = array[0..tb_Count - 1] of Byte;

  TUserItemValue = packed record
    case Integer of
      1: (
        btWuXin: Byte; //五行属性
        btFluteCount: Byte; //凹槽数量
        wFlute: array[0..MAXFLUTECOUNT - 1] of Word; //凹槽宝石信息
        btValue: TUserItemValueArray;    //物品附加属性
        StrengthenInfo: TStrengthenInfo;
      );
      2: (
        boBind: Boolean;
        sMapDesc: string[14];
        sMapName: string[20];
        wCurrX: Word;
        wCurrY: Word;
      );
  end;

   //tb_WuXin = 22;         //五行属性
  //Is_UnKnow = 1;  tb_StrengthenCount = 28;   //强化数量

  {pTOldUserItem = ^TOldUserItem;
  TOldUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word;
    Dura: Word;
    DuraMax: Word;
    btBindMode1: Byte;
    btBindMode2: Byte;
    TermTime: TDateTime;
    Value: TUserItemValue;
  end;   }

  TUserItemEffectValue = packed record
    btColor: Byte;
    btEffect: Byte;
    btUpgrade: Byte;
    btReserved: Byte;
    btReserved2: Byte;
  end;

  pTHorseItem = ^THorseItem;
  THorseItem = packed record
    MakeIndex: Integer;
    wIndex: Word;
    Dura: Word;
    btBindMode1: Byte;
    btBindMode2: Byte;
    TermTime: LongWord;
    btAC, btMAC, btDC, btHP: Byte;
  end;


  TOldUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btBindMode1: Byte;
    btBindMode2: Byte;
    TermTime: TDateTime;
    EffectValue: TUserItemEffectValue;
    Value: TUserItemValue;
  end;

  TMakeItemUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word;
    btBindMode1: Byte;
    btBindMode2: Byte;
    TermTime: LongWord;
    Dura: Word;
    DuraMax: Word;
    EffectValue: TUserItemEffectValue;
    Value: TUserItemValue;
    ComLevel: Byte;
  end;

  pTUserItem = ^TUserItem;
  TUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word;
    btBindMode1: Byte;
    btBindMode2: Byte;
    TermTime: LongWord;
    case Integer of
      1:(
        Dura: Word;
        DuraMax: Word;
        EffectValue: TUserItemEffectValue;
        Value: TUserItemValue;
        ComLevel: Byte; //合成等级
        temp1: array[0..48] of Byte;
      );
      2:(
        dwExp: LongWord;
        HorseItems: array[0..4] of THorseItem;
        wHP: Word;
        btLevel: Byte;
        dwMaxExp: LongWord;
        btAliveTime: Byte;
      );
  end;


  pTUserShopSellItem = ^TUserShopSellItem;
  TUserShopSellItem = packed record
    btIdx: Byte;
    nMoney: Integer;
    boGameGold: Boolean;
    UserItem: pTUserItem;
  end;

  pTUserShopBuyItem = ^TUserShopBuyItem;
  TUserShopBuyItem = packed record
    btIdx: Byte;
    nMoney: Integer;
    boGameGold: Boolean;
    wIdent: Word;
    wCount: Word;
  end;

  TBoxItemType = (bit_None, bit_Item, bit_Exp, bit_Gold, bit_BindGold, bit_GameGold);

  TBoxGoldInfo = packed record
    btRate: Byte;
    nGold: Integer;
    nGameGold: Integer;
  end;
  
  pTBoxItemInfo = ^TBoxItemInfo;
  TBoxItemInfo = packed record
    ItemType: TBoxItemType;
    Item: TUserItem;
  end;
  TBoxItemInfoArr = array[0..3] of TBoxGoldInfo;

  TClientBoxInfo = packed record
    Peculiar: array[0..2] of TBoxItemInfo;
    Normal: array[0..8] of TBoxItemInfo;
  end;

  pTBoxInfo = ^TBoxInfo;
  TBoxInfo = packed record
    GoldInfo: TBoxItemInfoArr;
    ItemList: array[0..4] of TList;
  end;

  pTServerMyShopItem = ^TServerMyShopItem;
  TServerMyShopItem = packed record
    btIdx: Byte;
    boBuy: Boolean;
    nMoney: Integer;
    boGameGold: Boolean;
    nItemIndex: Integer;
  end;

  TClientMyShopSellItem = packed record
    btIdx: Byte;
    nMoney: Integer;
    boGameGold: Boolean;
    UserItem: TUserItem;
  end;

  TClientMyShopBuyItem = packed record
    btIdx: Byte;
    nMoney: Integer;
    boGameGold: Boolean;
    wIdent: Word;
    wCount: Word;
  end;

  

  TNewClientItem = packed record
    s: TStdItem;
    UserItem: TUserItem;
  end;
  pTNewClientItem = ^TNewClientItem;

  pTClientUserItems = ^TClientUserItems;
  TClientUserItems = array[0..MAXUSEITEMS - 1] of TNewClientItem;

  pTClientItemFiltrate = ^TClientItemFiltrate;
  TClientItemFiltrate = packed record
    boShow: Boolean;
    boPickUp: Boolean;
    boColor: Boolean;
    boHint: Boolean;
    boChange: Boolean;
  end;


  pTClientStditem = ^TClientStditem;
  TClientStditem = packed record
    StdItem: TStdItem;
    Filtrate: TClientItemFiltrate;
    isShow: Boolean;
    sDesc: string[255];
  end;

  pTClientDefMagic = ^TClientDefMagic;
  TClientDefMagic = packed record
    Magic: TMagic;
    isShow: Boolean;
    sDesc: string[255];
  end;

  TClientGoods = packed record
    btIdx: Byte;
    nItemPic, nStock: Integer;
    ClientItem: TNewClientItem;
  end;
  PTClientGoods = ^TClientGoods;

  TUserGoods = packed record
    btIdx: Byte;
    nItemIdx: Word;
    nItemPic, nStock: Integer;
  end;
  PTUserGoods = ^TUserGoods;

  TClientShopItem = packed record
    btIdx: Byte;
    wIdent: Word;
    nPrict: Integer;
    nGoldPrict: Integer;
    wTime: Word;
//    nIntegral: Integer;
    btStatus: Byte;
    btAgio: Byte;
    nCount: Smallint;
    nSellCount: Word;
//    boGameGoldBuy: Boolean;
  end;

  TClientDateTime = packed record
    case Integer of
      1:(
        DateTime: TDateTime;
      );
      2:(
        nInteger: Integer;
        wWord1: Word;
        wWord2: Word;
      );
      3:(
        nInteger1: Integer;
        nInteger2: Integer;
      );
  end;

  TMonItemInfo = record//怪物爆物品类(MonItems目录下,怪名.txt)
    SelPoint: Integer;//出现点数
    MaxPoint: Integer;//总点数
    ItemIdent: Word;//物品名称
    boGold: Boolean;
    Count: Integer;//物品数量
    boRandom: Boolean;
    List: TList;
  end;
  pTMonItemInfo = ^TMonItemInfo;

  TMonsterInfo = record
    Name: string;
    ItemList: TList;
  end;
  PTMonsterInfo = ^TMonsterInfo;

  TMapItem = record //地图物品
    Name: string;//名称
    Looks: Word; //外观
    AniCount: Byte;
    Reserved: Byte;
    Count: Integer;//数量
    OfBaseObject: TObject;//物品谁可以捡起
    DropBaseObject: TObject;//谁掉落的
    dwCanPickUpTick: LongWord;
    UserItem: TUserItem;
    btIdx: Integer;
  end;
  PTMapItem = ^TMapItem;

  TVisibleMapItem = record//可见的地图物品
    wIdent: Word;
    nParam1: Integer;
    Buff: PChar;
    MapItem: PTMapItem;
    nVisibleFlag: Integer;
    nX: Integer;
    nY: Integer;
    sName: string;
    wLooks: Word;
  end;
  pTVisibleMapItem = ^TVisibleMapItem;

  TVisibleBaseObject = packed record
    BaseObject: TObject;
    nVisibleFlag: Integer;
    boAddCount: Boolean;
  end;
  pTVisibleBaseObject = ^TVisibleBaseObject;

 { THumanRcd = packed record
    sUserID: string[16];
    sCharName: string[14];
    btJob: Byte;
    btGender: Byte;
    btLevel: Byte;
    btHair: Byte;
    sMapName: string[16];
    btAttackMode: Byte;
    btIsAdmin: Byte;
    nX: Integer;
    nY: Integer;
    nGold: Integer;
    dwExp: LongWord;
  end;
  pTHumanRcd = ^THumanRcd;   }

  TObjectFeature = packed record
    btGender: Byte;
    btWear: Byte;
    btHair: Byte;
    btWeapon: Byte;
  end;
  pTObjectFeature = ^TObjectFeature;

  {TStatusInfo = packed record
    nStatus: Integer;
    dwStatusTime: LongWord;
    sm218: SmallInt;
    dwTime220: LongWord;
  end;    }

  TMsgHeader = packed record
    dwCode: LongWord;
    nSocket: Integer;
    wGSocketIdx: Word;
    wIdent: Word;
    wUserListIndex: Integer;
    nLength: Integer;
  end;
  pTMsgHeader = ^TMsgHeader;

  TDBMsgHeader = packed record
    dwHead: LongWord;
    dwCode: Word;
    DefMsg: TDefaultMessage;
    dwCheckCode: Word;
    nLength: Integer;
  end;
  pTDBMsgHeader = ^TDBMsgHeader;

  TCboMagicListInfo = packed record
    case Integer of
      1:(
        MagicList: array[0..3] of Byte;
      );
      2:(
        nMagicList: Integer;
      );
  end;

  TUserInfo = packed record
    bo00: Boolean;
    bo01: Boolean;
    bo02: Boolean;
    bo03: Boolean;
    n04: Integer;
    n08: Integer;
    bo0C: Boolean;
    bo0D: Boolean;
    bo0E: Boolean;
    bo0F: Boolean;
    n10: Integer;
    n14: Integer;
    n18: Integer;
    sStr: string[20];
    nSocket: Integer;
    nGateIndex: Integer;
    n3C: Integer;
    n40: Integer;
    n44: Integer;
    List48: TList;
    Cert: TObject;
    dwTime50: LongWord;
    bo54: Boolean;
  end;
  pTUserInfo = ^TUserInfo;

  TGlobaSessionInfo = record
    sAccount: string;//登录账号
    sIPaddr: string;//IP地址
    nSessionID: Integer;//会话ID
    nUserCDKey: Integer;
    nGameGold: Integer;
    //n24: Integer;
    //bo28: Boolean;
    boLoadRcd: Boolean;//是否读取
    boStartPlay: Boolean;//是否开始游戏
    dwAddTick: LongWord;//加入列表的时间
    dAddDate: TDateTime;//加入列表的日期
  end;
  pTGlobaSessionInfo = ^TGlobaSessionInfo;

  TClientStateInfo = packed record
    feature: Integer;
    UserName: string[ActorNameLen];
    NameColor: Integer;
    btWuXin: Byte;
    //btWuXinLevel: Byte;
    btJob: Byte;
    boHideHelmet: Boolean;
    GuildName: string[ActorNameLen];
    GuildRankName: string[16];
    UseItems: TClientUserItems;
    RealityInfo: TUserRealityInfo;
  end;
  pTClientStateInfo = ^TClientStateInfo;

  {TClienGuildMemberInfo = packed record
    UserName: string[ActorNameLen];
    nLevel: Word;
    btJob,
      btSex,
      btWuXin: Byte;
    //btWuXinLevel: Byte;
    LoginTime: Word;
  end;
  pTClienGuildMemberInfo = ^TClienGuildMemberInfo;   }

  TUserStateInfo = packed record
    feature: Integer;
    UserName: string[ActorNameLen];
    NameColor: Byte;
    btWuXin: Byte;
    //    btWuXinLevel: Byte;
    btJob: Byte;
    GuildName: string[ActorNameLen];
    GuildRankName: string[16];
    boHideHelmet: Boolean;
    //    UseItems: array[0..MAXUSEITEMS - 1] of TUserItem;
  end;
  pTUserStateInfo = ^TUserStateInfo;

  TItemCount = Integer;

  TBindItem = packed record//解包物品类
    sUnbindItemName: string[ActorNameLen];//解包物品名称
    nStdMode: Integer;//物品分类
    nShape: Integer;//装配外观
    btItemType: Byte;//分类
  end;
  pTBindItem = ^TBindItem;

  TIDRecordHeader = packed record
    boDeleted: Boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    UpdateDate: TDateTime;
    sAccount: string[16];
  end;

  TRecordHeader = packed record
    boDeleted: Boolean; //是否删除
    nSelectID: Byte;   //ID
    dwCreateDate: TDateTime;//最后登录时间
    dwUpdateDate: TDateTime;
    sName: string[ActorNameLen];//角色名称
  end;
  pTRecordHeader = ^TRecordHeader;

  THumFriend = packed record
    sChrName: string[ActorNameLen];
    nChrIdx: Integer;
  end;

  pTStorageItem = ^TStorageItem;
  TStorageItem = packed record
    idx: Byte;
    UserItem: TUserItem;
  end;

  {pTDefStorageItem = ^TDefStorageItem;
  TDefStorageItem = packed record
    idx: Byte;
    UserItem: TDefUserItem;
  end;    }

  {pTOldStorageItem = ^TOldStorageItem;
  TOldStorageItem = packed record
    idx: Byte;
    UserItem: TOldUserItem;
  end;  }

  TUserKeyInfo = packed record
    btType: Byte;
    wIndex: Word;
  end;



  pTUserOptionSetup = ^TUserOptionSetup;
  TUserOptionSetup = packed record
    nOptionSetup: LongWord; //32项设置
    nExpFiltrateCount: Word; //过滤最低数量
    nHpProtectCount: Word;
    dwHpProtectTime: Byte;
    nMpProtectCount: Word;
    dwMpProtectTime: Byte;
    nHpProtectCount2: Word;
    dwHpProtectTime2: Byte;
    nMpProtectCount2: Word;
    dwMpProtectTime2: Byte;
    nHpProtectCount3: Word;
    dwHpProtectTime3: Byte;
    btHpProtectIdx: Byte;
  end;

  pTMissionInfo = ^TMissionInfo;
  TMissionInfo = packed record
    sMissionName: String[MapNameLen];
    btKillCount1: Byte;
    btKillCount2: Byte;
    boTrack: Boolean;
    wTime: Word;
  end;
 
  TUserItemsSetup = array[0..MAXITEMSSETUPCOUNT - 1] of Word;

  TQuestFlag = array[0..99] of Byte;
  TMissionFlag = array[0..99] of Byte;
  TStatusTime = array[0..MAX_STATUS_ATTRIBUTE - 1] of Word;
  TUserKeySetup = array[0..19] of TUserKeyInfo;
  TMagicConcatenation = array[0..3] of Byte;

  TMissionInfos = array[1..20] of TMissionInfo;

  TMissionArithmometer = array[0..19] of Byte;
  TMissionIndex = array[0..99] of Byte;
  //MapNameLen



  THumMagics = array[0..MAXMAGIC - 1] of THumMagic;

  THumanUseItems = array[0..MAXUSEITEMS - 1] of TUserItem;
  THumanReturnItems = array[0..MAXRETURNITEMS - 1] of TUserItem;
  THumanAppendBagItems = array[0..MAXAPPENDBAGITEMS - 1] of TUserItem;
  TBagItems = array[0..MAXBAGITEMS - 1] of TUserItem;//包裹物品
  TStorageItems = array[0..MAXSTORAGEITEMS - 1] of TStorageItem;

 { TOldHumanUseItems = array[Low(THumanUseItems)..High(THumanUseItems)] of TUserItem;
  TOldHumanReturnItems = array[Low(THumanReturnItems)..High(THumanReturnItems)] of TUserItem;
  TOldHumanAppendBagItems = array[Low(THumanAppendBagItems)..High(THumanAppendBagItems)] of TUserItem;
  TOldBagItems = array[Low(TBagItems)..High(TBagItems)] of TUserItem;
  TOldStorageItems = array[Low(TStorageItems)..High(TStorageItems)] of TStorageItem;
              }
  TMakeMagic = array[0..mm_MaxCount] of byte;

  THumCustomVariable = array[0..19] of Integer;
  THumMasterName = array[0..6] of string[ActorNameLen];
  THumanFriends = array[0..MAXFRIENDS - 1] of THumFriend;

  pTPlayUseItems = ^THumItems;
  THumItems = THumanUseItems;

  pTHumanUseItems = ^THumanUseItems;
  pTBagItems = ^TBagItems;
  pTStorageItems = ^TStorageItems;
  pTHumMagics = ^THumMagics;


  {TDBEMailHeaderInfo = packed record
    boDelete: Boolean;
    boRead: Boolean;
    dCreateTime: TDateTime;
    nReadIndex: Integer;
  end;

  pTDBEMailInfo = ^TDBEMailInfo;
  TDBEMailInfo = packed record
    Header: TDBEMailHeaderInfo;
    boSystem: Boolean;
    sReadName: string[ActorNameLen];
    sSendName: string[ActorNameLen];
    sTitle: string[22];
    TextLen: Word;
    Text: array[0..400] of char;
  end;   }

  //THumanEMailInfo = array[0..MAXEMAILCOUNT - 1] of TDBEMailInfo;

  pTHumData = ^THumData;
  { 人物数据 }
  THumData = packed record
    // 记录索引
    nIdx: Integer;
    // 人物名字——目测
    sChrName: string[ActorNameLen];
    // 当前地图名字
    sCurMap: string[MapNameLen];
    // 当前X坐标
    wCurX: Word;
    // 当前Y坐标
    wCurY: Word;
    // 方向
    btDir: Byte;
    // 发型
    btHair: Byte;
    // 性别
    btSex: Byte;
    // 职业：范围0 -- 255
    btJob: Byte;
    // 金币
    nGold: Integer;
    // 绑定金币
    nBindGold: Integer;
    // 角色能力
    Abil: TAbility;
    // 裸体能力？
    NakedAbil: TNakedAbil;
    // 裸体数量？
    nNakedAbilCount: Word;
    // 时间状态列表
    wStatusTimeArr: TStatusTime;
    // 家地图名字
    sHomeMap: string[MapNameLen];
    wHomeX: Word;
    wHomeY: Word;
    // 死亡地图名字
    sDieMap: string[MapNameLen];
    wDieX: Word;
    wDieY: Word;

    sDearName: string[ActorNameLen];//别名(配偶)
    MasterName: THumMasterName;//师傅名字
    boMaster: Boolean;//是否有徒弟

    LoginTime: TDateTime;
    LoginAddr: string[15];

    btCreditPoint: Integer;//声望点

    sStoragePwd: string[12]; //
    nStorageGold: Integer;
    boStorageLock: Boolean;
    btStorageErrorCount: Byte;
    StorageLockTime: TDateTime;
    btReLevel: Byte;//转生等级

    nGameGold: Integer; // 游戏
    nGamePoint: Integer;
    nGameDiamond: Integer;//金刚石 20071226
    nGameGird: Integer;//灵符 20071226
    nPKPoint: Integer;//PK点数
    nPullulation: Integer;     //自然成长点

    btAttatckMode: Byte;//攻击模式
    nIncHealth: byte; ////增加健康数
    nIncSpell: byte; //增加攻击点
    nIncHealing: byte; //增加治愈点
    btFightZoneDieCount: Byte;//在行会占争地图中死亡次数
    sAccount: string[16]; //
    sGuildName: string[ActorNameLen];
    wContribution: Word;//贡献值

    dBodyLuck: Double; //
    wGuildRcallTime: Word;
    wGroupRcallTime: Word; //队传送时间

    nAllowSetup: LongWord;
    boAddStabilityPoint: Boolean;

    btMasterCount: Word; //
    btWuXin: Byte;
    boChangeName: Boolean; //
    nExpRate: Integer;//经验倍数
    nExpTime: LongWord;//经验倍数时间
    dwUpLoadPhotoTime: TDateTime;
    UserRealityInfo: TUserRealityInfo; //用户真实信息
    UserKeySetup: TUserKeySetup;
    QuestFlag: TQuestFlag;//脚本变量
    MissionFlag: TMissionFlag;
    MissionInfo: TMissionInfos;
    MissionArithmometer: TMissionArithmometer;
    MissionIndex: TMissionIndex;

    ReturnItems: THumanReturnItems; //回购物品        4
    AppendBagItems: THumanAppendBagItems; //额外背包   3
    HumItems: THumanUseItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TBagItems;  //包裹装备

    HumMagics: THumMagics;//魔法
    CboMagicListInfo: TCboMagicListInfo;
    
    StorageItems: TStorageItems;//仓库物品

    StorageOpen2: Boolean;
    StorageTime2: TDateTime;
    StorageItems2: TStorageItems;            //49

    StorageOpen3: Boolean;
    StorageTime3: TDateTime;
    StorageItems3: TStorageItems;            //49

    {StorageOpen4: Boolean;
    StorageTime4: TDateTime;
    StorageItems4: TStorageItems;
    StorageOpen5: Boolean;
    StorageTime5: TDateTime;
    StorageItems5: TStorageItems;  }
    UserOptionSetup: TUserOptionSetup;
    wNakedBackCount: Word;
    nItemsSetupCount: Word;
    UserItemsSetup: TUserItemsSetup;
    FriendList: THumanFriends;
    nPhotoSize: Word;
    pPhotoData: array[0..MAXPHOTODATASIZE] of byte;
    MakeMagic: TMakeMagic;
    MakeMagicPoint: Word;
    //EMailInfo: THumanEMailInfo;
    CustomVariable: THumCustomVariable;
    nReserve: array[0..4025] of byte; //
  end;

  THumDataInfo = packed record
    Header: TRecordHeader;
    Data: THumData;
  end;
  pTHumDataInfo = ^THumDataInfo;

  TDBHumDataInfo = packed record
    sAccount: string[20];
    HumDataInfo: THumDataInfo;
    UserName: string[ActorNameLen];
  end;

  pTSetItems = ^TSetItems;
  TSetItems = packed record
    sHint: string[50];
    Items: array[Low(THumanUseItems)..High(THumanUseItems)] of string[14];
    Value: array[0..30] of Word;
    HideValue: Boolean;
  end;

  TSaveRcd = packed record
    sAccount: string[20];
    sChrName: string[ActorNameLen];
    nSessionID: Integer;
    nDBIndex: Integer;
    boGhost: Boolean;
    boPhotoChange: Boolean;
    nReTryCount: Integer;
    dwSaveTick: LongWord;
    //PlayObject: TObject;
    HumanRcd: THumDataInfo;
  end;
  pTSaveRcd = ^TSaveRcd;

  TLoadDBInfo = packed record
    sAccount: string[20];//账号
    sCharName: string[ActorNameLen];//角色名称
    sIPaddr: string[15];//IP地址
    nSessionID: Integer;
    nAccountID: Integer;
    nChrIndex: Integer;
    nGameGold: Integer;
    nCheckEMail: Integer;
    nIDIndex: Integer;
    nSoftVersionDate: Integer;//客户端版本号
    nSocket: Integer;//端口
    nGSocketIdx: Integer;
    nGateIdx: Integer;
    dwNewUserTick: LongWord;
    nReLoadCount: Integer;
  end;
  pTLoadDBInfo = ^TLoadDBInfo;

  TLoadDBSInfo = record
    PlayObject: TObject;
    LoadTime: LongWord;
    LoadMsg: string;
  end;
  pTLoadDBSInfo = ^TLoadDBSInfo;

  TUserOpenInfo = packed record
    sAccount: string[20];
    sChrName: string[ActorNameLen];
    LoadUser: TLoadDBInfo;
    HumanRcd: THumDataInfo;
  end;
  pTUserOpenInfo = ^TUserOpenInfo;

  TLoadUser = packed record
    sAccount: string[20];
    sChrName: string[ActorNameLen];
    sIPaddr: string[15];
    nSessionID: Integer;
    nSocket: Integer;
    nGateIdx: Integer;
    nGSocketIdx: Integer;
    nPayMent: Integer;
    nPayMode: Integer;
    dwNewUserTick: LongWord;
    nSoftVersionDate: Integer;
  end;
  pTLoadUser = ^TLoadUser;

  TDoorStatus = packed record
    bo01: Boolean;
    boOpened: Boolean;
    dwOpenTick: LongWord;
    nRefCount: Integer;
    n04: Integer;
  end;
  pTDoorStatus = ^TDoorStatus;

  TDoorInfo = packed record
    nX: Integer;
    nY: Integer;
    n08: Integer;
    Status: pTDoorStatus;
  end;
  pTDoorInfo = ^TDoorInfo;

  TSlaveInfo = packed record
    sSalveName: string;
    btSalveLevel: Byte;
    btSlaveExpLevel: Byte;
    dwRoyaltySec: LongWord;
    nKillCount: Integer;
    nHP: Integer;
    nMP: Integer;
  end;
  pTSlaveInfo = ^TSlaveInfo;

  {TSwitchDataInfo = record
    sChrName: string[ActorNameLen];
    sMAP: string[MapNameLen];
    wX: Word;
    wY: Word;
    Abil: TAbility;
    nCode: Integer;
    boC70: Boolean;
    boBanShout: Boolean;
    boHearWhisper: Boolean;
    boBanGuildChat: Boolean;
    boAdminMode: Boolean;
    boObMode: Boolean;
    BlockWhisperArr: array[0..5] of string;
    SlaveArr: array[0..10] of TSlaveInfo;
    StatusValue: array[0..5] of Word;
    StatusTimeOut: array[0..5] of LongWord;
  end;
  pTSwitchDataInfo = ^TSwitchDataInfo;  }

 { TSendDBSInfo = record
    PlayObject: TObject;
    nIdent: Integer;
    nRecog: Integer;
    sMsg: string;
  end;
  pTSendDBSInfo = ^TSendDBSInfo; }

  TGateInfo = record
    Socket: TCustomWinSocket;
    boUsed: Boolean;
    sAddr: string[15];
    GateIndex: Integer;
    nPort: Integer;
    n520: Integer;
    UserList: TList;
    nUserCount: Integer;//连接人数
    Buffer: PChar;
    nBuffLen: Integer;
    BufferList: TList;
    boSendKeepAlive: Boolean;
    dwSendKeepTick: LongWord;
    nSendChecked: Integer;
    nSendBlockCount: Integer;
    dwTime544: LongWord;
    nSendMsgCount: Integer;
    nSendRemainCount: Integer;
    dwSendTick: LongWord;
    nSendMsgBytes: Integer;
    nSendBytesCount: Integer;
    nSendedMsgCount: Integer;
    nSendCount: Integer;
    dwSendCheckTick: LongWord;
  end;
  pTGateInfo = ^TGateInfo;

  TStartPoint = packed record//安全区回城点 增加光环效果
    m_sMapName: string[MapNameLen];
    m_nCurrX: Integer;//座标X(4字节)
    m_nCurrY: Integer;//座标Y(4字节)
    //m_boNotAllowSay: Boolean;
    m_nRange: Integer;
//    m_nType: Integer;
    m_nPkSize: Integer;
//    m_nPkType: Integer;
    //m_btShape: Byte;
  end;
  pTStartPoint = ^TStartPoint;

  TMapStartPoint = packed record
    nSafeX: Word;
    nSafeY: Word;
    nPKSize: Integer;
  end;
  pTMapStartPoint = ^TMapStartPoint;

  TQuestUnitStatus = packed record
    nQuestUnit: Integer;
    boOpen: Boolean;
  end;
  pTQuestUnitStatus = ^TQuestUnitStatus;

  TMapCondition = packed record
    nHumStatus: Integer;//人的状态
    sItemName: string[14];//物品
    boNeedGroup: Boolean;//是否需要组队
  end;
  pTMapCondition = ^TMapCondition;

  TStartScript = packed record
    nLable: Integer;
    sLable: string[100];
  end;

  pTMapEvent = ^TMapEvent;
  TMapEvent = packed record
    nFlag: Integer;
    btValue: Byte;
    btEventObject: Byte;
    sItemName: string[14];
    boGroup: Boolean;
    nRate: Integer;
//    boEvent: Boolean;
    sEvent: string[40];
    nEvent: Integer;
    Envir: TObject;
    Rate: Word;
    nX: Word;
    nY: Word;
  end;

  TSendUserData = record
    nSocketIndx: Integer;
    nSocketHandle: Integer;
    sMsg: string;
  end;
  pTSendUserData = ^TSendUserData;

  TCheckVersion = record
  end;
  pTCheckVersion = ^TCheckVersion;

  TRecordDeletedHeader = packed record
    boDeleted: Boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    LastLoginDate: TDateTime;
    n14: Integer;
    nNextDeletedIdx: Integer;

  end;

  TUserEntry = packed record
    sAccount: string[16];//账号
    sPassword: string[20];//密码
    sUserName: string[12];//用户名称
    sSSNo: string[18];//身份证
    sPhone: string[14];//电话
    sQuiz: string[20];//问题1
    sAnswer: string[20];//答案1
    sEMail: string[30];//邮箱
  end;

  TUserEntryAdd = packed record
    sQuiz2: string[20];//问题2
    sAnswer2: string[20];//答案2
    sBirthDay: string[10];//生日
    sMobilePhone: string[14];//移动电话
    sMemo: string[20];//备注一
    sMemo2: string[20];//备注二
  end;

  TAccountDBRecord = packed record
    Header: TIDRecordHeader;
    UserEntry: TUserEntry;
    UserEntryAdd: TUserEntryAdd;
    nErrorCount: Integer;
    dwActionTick: LongWord;
    n: array[0..38] of Byte;
  end;

  TMapFlag = record//地图参数
    boSAFE: Boolean;
    boDARK: Boolean;
    boFIGHT: Boolean;
    boFIGHT3: Boolean;
    boDAY: Boolean;
    boQUIZ: Boolean;
    boNORECONNECT: Boolean;
    boMUSIC: Boolean;
    boEXPRATE: Boolean;
    boPKWINLEVEL: Boolean;
    boPKWINEXP: Boolean;
    boPKLOSTLEVEL: Boolean;
    boPKLOSTEXP: Boolean;
    boDECHP: Boolean;
    boINCHP: Boolean;
    boDECGAMEGOLD: Boolean;
    boDECGAMEPOINT: Boolean;//自动减游戏点
    boINCGAMEGOLD: Boolean;
    boINCGAMEPOINT: Boolean;//自动加游戏点
    boRUNHUMAN: Boolean;
    boRUNMON: Boolean;
    boNEEDHOLE: Boolean;
    boNORECALL: Boolean;
    boNOGUILDRECALL: Boolean;
    boNODEARRECALL: Boolean;
    boNOMASTERRECALL: Boolean;
    boNORANDOMMOVE: Boolean;
    boNODRUG: Boolean;
    boMINE: Boolean;
    boNOPOSITIONMOVE: Boolean;
    boNoManNoMon: Boolean;//智能刷怪,有人才重新刷怪
    boShop: Boolean;
    boOffLine: Boolean;
    boNotReAlive: Boolean;
    boNotStone: Boolean;
    boNotHorse: Boolean;
    boNoDeal: Boolean;
    boNOTHROWITEM: Boolean;


    nL: Integer;
    nNEEDSETONFlag: Integer;
    nNeedONOFF: Integer;
    nMUSICID: Integer;
    nPKWINLEVEL: Integer;
    nExpRate: Integer;
    nPKWINEXP: Integer;
    nPKLOSTLEVEL: Integer;
    nPKLOSTEXP: Integer;
    nDECHPPOINT: Integer;
    nDECHPTIME: Integer;
    nINCHPPOINT: Integer;
    nINCHPTIME: Integer;
    nDECGAMEGOLD: Integer;
    nDECGAMEGOLDTIME: Integer;
    nDECGAMEPOINT: Integer;
    nDECGAMEPOINTTIME: Integer;
    nINCGAMEGOLD: Integer;
    nINCGAMEGOLDTIME: Integer;
    nINCGAMEPOINT: Integer;
    nINCGAMEPOINTTIME: Integer;
    sReConnectMap: string;
    nReConnectX: Integer;
    nReConnectY: Integer;

    boUnAllowStdItems: Boolean;
    sUnAllowStdItemsText: string;//地图禁用物品
    boUnAllowMagic: Boolean;
    sUnAllowMagicText: string;//不允许魔法
    boAutoMakeMonster: Boolean;
    boNOFIREMAGIC: Boolean;
    boDieTime: Boolean;
    dwDieTime: LongWord;
    sFlag: string;
    sHitMonLabel: string;
  end;
  pTMapFlag = ^TMapFlag;

  TChrMsg = record
    Ident: Integer;
    X: Integer;
    Y: Integer;
    dir: Integer;
    State: Integer;
    feature: Integer;
    saying: string;
    sound: Integer;
  end;
  pTChrMsg = ^TChrMsg;

  TRegInfo = record
    sKey: string;
    sServerName: string;
    sRegSrvIP: string[15];
    nRegPort: Integer;
  end;
  TRenewChrInfo = record
    ID: Integer;
    Name: string[16];
    Job: Byte;
    Level: Word;
    Sex: Byte;
    WuXin: Byte;
    //WuXinLevel: Byte;
  end;

  TUserCharacterInfo = record
    ID: Integer;
    Name: string[16];
    Job: Byte;
    Sex: Byte;
    WuXin: Byte;
    Level: Word;
    LoginTime: TDateTime;
  end;

  TNewCharDesc = packed record
    Feature: Integer;
    Status: Integer;
    m_btSex: byte;
    m_btJob: byte;
    Not1: Word;
    Not2: Integer;
  end;

  TClientConf = packed record
    boRUNHUMAN: Boolean;
    boRUNMON: Boolean;
    boRunNpc: Boolean;
    boRunGuard: Boolean;
    boWarDisHumRun: Boolean;
    SafeAreaLimited: Boolean;

    boParalyCanRun: Boolean;
    boParalyCanWalk: Boolean;
    boParalyCanHit: Boolean;//麻痹能攻击
    boParalyCanSpell: Boolean;
    boShowMoveHPNumber: Boolean;
  end;

  pTPowerBlock = ^TPowerBlock;
  TPowerBlock = array[0..100 - 1] of Word;

  TIconInfo = record
    wIndex, wStart: Word;
    wFrameTime: Word;
    btFrame: Byte;
    bo01: Byte;
    nX, nY: SmallInt;
  end;

  TIconInfos = array [0 .. 6] of TIconInfo;

  TIconInfoShow = record
    dwCurrentFrame: LongWord;
    dwFrameTick: LongWord;
  end;

  TIconInfoShows = array [Low(TIconInfos) .. High(TIconInfos)] of TIconInfoShow;

function APPRfeature(cfeature: Integer): Word;
function RACEfeature(cfeature: Integer): Byte;
function HAIRfeature(cfeature: Integer): Byte;
function DRESSfeature(cfeature: Integer): Byte;
function WEAPONfeature(cfeature: Integer): Byte;
function Horsefeature(cfeature: Integer): Byte;
function Effectfeature(cfeature: Integer): Byte;
function MakeHumanFeature(btRaceImg, btDress, btWeapon, btHair: Byte): Integer;
function MakeMonsterFeature(btRaceImg, btWeapon: Byte; wAppr: Word): Integer;
function GetItemType(StdMode: Byte): TStdMode;
function GetItemTypeEx(StdMode: TStdMode): TStdModeEx;
function GetMagicType(nMagID: Byte): TMagicMode;
//function CheckDuraItem(smode: TStdMode): Boolean;
function GetTakeOnPosition(smode: TStdMode): integer;
function GetHorseTakeOnPosition(smode: TStdMode): integer;
function CheckWuXinRestraint(A, B: Byte): Boolean;
function CheckWuXinConsistent(A, B: Byte): Boolean;
function GetWuXinRestraint(A: Byte): Byte;
function GetWuXinConsistent(A: Byte): Byte;
function GetWuXinConsistentBack(A: Byte): Byte;
//function CheckIsEquip(smode: TStdMode): Boolean;
procedure GetNakedAbilitys(NakedAddAbil: pTNakedAddAbil; NakedAbil: pTNakedAbil; NakedAddInfo: pTServerNakedAddInfo);
function GetAppendBagCount(Shape: Byte): Byte;
function GetUserItemPrice(UserItem: pTUserItem; StdItem: pTStdItem): Integer;
function GetRepairItemPrice(UserItem: pTUserItem; StdItem: pTStdItem): Integer;
function GetStrengthenAbility(UserItem: pTUserItem; var StdItem: TStdItem): Boolean;{ overload; }
//function GetStrengthenAbility(UserItem: pTUserItem; ItValue: pTUserItemValueArray): Boolean; overload;
function RandomInitializeStrengthenInfo(Item: pTUserItem): Boolean;
function ItemCanDrop(Item: pTUserItem; nRate: Integer): Boolean;
function GetStrengthenItemName(sName: string; nLevel: Byte): string;
function GetStrengthenItemNameByInfo(UserItem: pTUserItem; StdItem: pTStdItem): string;
function CheckItemArmStrengthenLevel(nItemLevel, nMinLevel, nMaxLevel: Integer): Boolean;
function GetHitInterval(nLevel, nHitSpeed: Integer): Integer;

function GetStrengthenMoney(nLevel: Integer): Integer;
function GetStrengthenMaxRate(nLevel: Integer): Integer;
function GetSpellPoint(UserMagic: pTUserMagic): Integer;
function GetFluteCount(UserItem: pTUserItem): Integer;
procedure GetHorseLevelAbility(UserItem: pTUserItem; StdItem: pTStdItem; var AddAbility: TAddAbility);
procedure GetHorseAddAbility(UserItem: pTUserItem; StdItem: pTStdItem; nIndex: Byte; var AddAbility: TAddAbility);
function LongWordToDateTime(dwTime: LongWord): TDateTime;
function DateTimeToLongWord(DateTime: TDateTime): LongWord;
function HorseItemToUserItem(HorseItem: pTHorseItem; StdItem: pTStdItem): TUserItem;
function UserItemToHorseItem(UserItem: pTUserItem): THorseItem;

var
  RSADECODESTRING1: string = '_<mEnp\';

implementation
uses
  Hutil32;


function GetFluteCount(UserItem: pTUserItem): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to UserItem.Value.btFluteCount - 1 do begin
    if (I in [0..MAXFLUTECOUNT - 1]) then begin
      if UserItem.Value.wFlute[i] = 0 then begin
        Inc(Result);
      end;
    end;
  end;
end;

    // 获取当前技能的法力消耗
function GetSpellPoint(UserMagic: pTUserMagic): Integer;
begin
  // 定义的基础消耗 + 满级消耗 * 当前等级与最大等级比例值
  Result := ROUND(UserMagic.MagicInfo.wSpell / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) +
    UserMagic.MagicInfo.btDefSpell;
end;

function GetStrengthenMoney(nLevel: Integer): Integer;
begin
  Result := (nLevel + 1) * 2000;
end;

function GetStrengthenMaxRate(nLevel: Integer): Integer;
begin
  Result := 100 - nLevel * 2;
end;

function GetHitInterval(nLevel, nHitSpeed: Integer): Integer;
begin
  Result := _MIN(370, (nLevel * 14));
  //Result := _MIN(800, Result + nHitSpeed * 60);
end;

function CheckItemArmStrengthenLevel(nItemLevel, nMinLevel, nMaxLevel: Integer): Boolean;
begin
  Result := True;
  if (nMaxLevel > 0) then
  begin
    if (nMaxLevel = nMinLevel) then
    begin
      if nItemLevel <> nMaxLevel then
        Result := False;
    end
    else if (nItemLevel < nMinLevel) or (nItemLevel > nMaxLevel) then
      Result := False;
  end;
end;

function GetRepairItemPrice(UserItem: pTUserItem; StdItem: pTStdItem): Integer;
var
  nPrice: integer;
begin
  nPrice := GetUserItemPrice(UserItem, StdItem);
  if nPrice > 0 then
  begin
    if UserItem.DuraMax > 0 then
    begin
      nPrice := ROUND(nPrice div 3 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
    end
    else
    begin
      nPrice := nPrice;
    end;
  end;
  Result := nPrice;
end;

function GetUserItemPrice(UserItem: pTUserItem; StdItem: pTStdItem): Integer;
var
  n10: Integer;
  n20: real;
  nC: Integer;
  n14: Integer;
begin
  if StdItem = nil then
  begin
    Result := -1;
    exit;
  end;
  n10 := StdItem.Price;
  if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then
  begin
    n10 := n10 * UserItem.Dura;
  end
  else if (StdItem <> nil) {and (StdItem.StdMode2 > 4) } and (StdItem.DuraMax > 0) and (UserItem.DuraMax > 0) then
  begin
    if StdItem.StdMode = tm_Flesh then
    begin //肉
      if UserItem.Dura <= UserItem.DuraMax then
      begin
        n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
        n10 := _MAX(2, ROUND(n10 - n20));
      end
      else
      begin
        n10 := n10 + ROUND(n10 / UserItem.DuraMax * 2.0 * (UserItem.Dura - UserItem.DuraMax));
        //修复肉的价格如果当前持久大于最大持久UserItem.DuraMax -UserItem.Dura
        //成了负数价格会比正常的减少
        //n10 := n10 + ROUND(n10 / UserItem.DuraMax * 2.0 * (UserItem.DuraMax - UserItem.Dura));
      end;
    end;
    if (StdItem.StdMode = tm_Ore) then
    begin
      if UserItem.DuraMax < 10000 then
        UserItem.DuraMax := 10000;
      if UserItem.Dura <= UserItem.DuraMax then
      begin
        n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
        n10 := _MAX(2, ROUND(n10 - n20));
      end
      else
      begin
        n10 := n10 + ROUND(n10 / UserItem.DuraMax * 1.3 * (UserItem.Dura - UserItem.DuraMax));
        //修复矿的价格如果当前持久大于最大持久UserItem.DuraMax -UserItem.Dura
        //成了负数价格会比正常的减少
        //n10 := n10 + ROUND(n10 / UserItem.DuraMax * 1.3 * (UserItem.DuraMax - UserItem.Dura));
      end;
    end;
    if (sm_Arming in StdItem.StdModeEx) or (sm_HorseArm in StdItem.StdModeEx) then
    begin
      n14 := 0;
      {nC := 0;
      while (True) do
      begin
        Inc(n14, UserItem.Value.nValue[nC]);
        Inc(nC);
        if nC >= tn_Count then
          break;
      end;   }
      nC := 0;
      while (True) do
      begin
        Inc(n14, UserItem.Value.btValue[nC]);
        Inc(nC);
        if nC >= tb_Count then
          break;
      end;
      if n14 > 0 then
      begin
        n10 := n10 + (n10 div 8 * n14);
      end;
      n10 := ROUND(n10 / StdItem.DuraMax * UserItem.DuraMax);
      n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
      n10 := _MAX(2, ROUND(n10 - n20));
    end;
  end;
  Result := n10;
end;

function GetAppendBagCount(Shape: Byte): Byte;
begin
  case Shape of
    0: Result := 6;
    1: Result := 12;
    2: Result := 20;
  else
    Result := 0;
  end;
end;

procedure GetNakedAbilitys(NakedAddAbil: pTNakedAddAbil; NakedAbil: pTNakedAbil; NakedAddInfo: pTServerNakedAddInfo);
begin
  SafeFillChar(NakedAddAbil^, SizeOf(TNakedAddAbil), #0);
  if NakedAbil.nAc > 0 then
  begin
    NakedAddAbil.nAc := NakedAbil.nAc div NakedAddInfo.nNakedAcMaxCount;
    NakedAddAbil.nAc2 := NakedAbil.nAc div NakedAddInfo.nNakedAcCount - NakedAddAbil.nAc;
  end;
  if NakedAbil.nMAc > 0 then
  begin
    NakedAddAbil.nMAc := NakedAbil.nMAc div NakedAddInfo.nNakedMAcMaxCount;
    NakedAddAbil.nMAc2 := NakedAbil.nMAc div NakedAddInfo.nNakedMAcCount - NakedAddAbil.nMAc;
  end;
  if NakedAbil.nDc > 0 then
  begin
    NakedAddAbil.nDc := NakedAbil.nDc div NakedAddInfo.nNakedDcMaxCount;
    NakedAddAbil.nDc2 := NakedAbil.nDc div NakedAddInfo.nNakedDcCount - NakedAddAbil.nDc;
  end;
  if NakedAbil.nMc > 0 then
  begin
    NakedAddAbil.nMc := NakedAbil.nMc div NakedAddInfo.nNakedMcMaxCount;
    NakedAddAbil.nMc2 := NakedAbil.nMc div NakedAddInfo.nNakedMcCount - NakedAddAbil.nMc;
  end;
  if NakedAbil.nSc > 0 then
  begin
    NakedAddAbil.nSc := NakedAbil.nSc div NakedAddInfo.nNakedScMaxCount;
    NakedAddAbil.nSc2 := NakedAbil.nSc div NakedAddInfo.nNakedScCount - NakedAddAbil.nSc;
  end;
  if NakedAbil.nHP > 0 then
    NakedAddAbil.nHP := NakedAbil.nHP div NakedAddInfo.nNakedHPCount;
end;
{
function CheckIsEquip(smode: TStdMode): Boolean;
begin
  Result := False;
  case smode of
    tm_Weapon,
      tm_Dress,
      tm_Helmet,
      tm_Necklace,
      tm_Ring,
      tm_ArmRing,
      tm_Light,
      tm_Boot,
      tm_Stone,
      tm_Belt: Result := True;
  end;
end;    }

function GetWuXinConsistent(A: Byte): Byte;
begin
  Result := 0;
  case A of
    1: Result := 3;
    2: Result := 4;
    3: Result := 2;
    4: Result := 5;
    5: Result := 1;
  end;
end;

function GetWuXinConsistentBack(A: Byte): Byte;
begin
  Result := 0;
  case A of
    1: Result := 5;
    2: Result := 3;
    3: Result := 1;
    4: Result := 2;
    5: Result := 4;
  end;
end;

function CheckWuXinConsistent(A, B: Byte): Boolean;
begin
  Result := False;
  case A of
    1: if B = 3 then
        Result := True;
    2: if B = 4 then
        Result := True;
    3: if B = 2 then
        Result := True;
    4: if B = 5 then
        Result := True;
    5: if B = 1 then
        Result := True;
  end;
end;

function GetWuXinRestraint(A: Byte): Byte;
begin
  Result := 0;
  case A of
    1: Result := 2;
    2: Result := 5;
    3: Result := 4;
    4: Result := 1;
    5: Result := 3;
  end;
end;

function CheckWuXinRestraint(A, B: Byte): Boolean;
begin
  Result := False;
  case A of
    1: if B = 2 then Result := True;
    2: if B = 5 then Result := True;
    3: if B = 4 then Result := True;
    4: if B = 1 then Result := True;
    5: if B = 3 then Result := True;
  end;
end;

function GetTakeOnPosition(smode: TStdMode): integer;
begin
  Result := -1;
  case smode of
    tm_Weapon: Result := U_WEAPON;
    tm_Dress: Result := U_DRESS;
    tm_Helmet: Result := U_HELMET;
    tm_Necklace: Result := U_NECKLACE;
    tm_Ring: Result := U_RINGL;
    tm_ArmRing: Result := U_ARMRINGL;
    tm_Light: Result := U_RIGHTHAND;
    tm_Amulet: Result := U_BUJUK;
    tm_Boot: Result := U_BOOTS;
    tm_Stone, tm_Rock: Result := U_CHARM;
    tm_Belt: Result := U_BELT;
    tm_Cowry: Result := U_CIMELIA;
    //tm_Vip: Result := U_VIP;
    tm_House: Result := U_HOUSE;
    tm_Rein: Result := U_Rein;
    tm_Bell: Result := U_Bell;
    tm_Saddle: Result := U_Saddle;
    tm_Decoration: Result := U_Decoration;
    tm_Nail: Result := U_Nail;
  end;
end;

function GetHorseTakeOnPosition(smode: TStdMode): integer;
begin
  Result := -1;
  case smode of
    tm_Rein: Result := HU_Rein;
    tm_Bell: Result := HU_Bell;
    tm_Saddle: Result := HU_Saddle;
    tm_Decoration: Result := HU_Decoration;
    tm_Nail: Result := HU_Nail;
  end;
end;
{
function CheckDuraItem(smode: TStdMode): Boolean;
begin
  Result := False;
  //Dec(StdIndex);
  case smode of
    tm_Weapon,
    tm_Dress,
    tm_Helmet,
    tm_Necklace,
    tm_Ring,
    tm_ArmRing,
    tm_Light,
    tm_Boot,
    tm_Stone,
    tm_Belt: Result := True;
  end;
end;      }

function GetMagicType(nMagID: Byte): TMagicMode;
begin
  Result := [];
  case nMagID of
    1: Result := [mm_Attack, mm_MagLock]; //火球术
    2: Result := [mm_Attack]; //治俞术
    3: Result := [mm_Passiveness]; //基本剑术
    4: Result := [mm_Passiveness]; //精神力战法
    5: Result := [mm_Attack, mm_MagLock]; //大火球
    6: Result := [mm_Attack, mm_MagLock]; //施毒术
    7: Result := [mm_Passiveness]; //攻杀剑术
    8: Result := []; //抗拒火环
    9: Result := [mm_Attack]; //地狱火
    10: Result := [mm_Attack]; //疾光电影
    11: Result := [mm_Attack, mm_MagLock]; //雷电术
    12: Result := [mm_Warr, mm_Open]; //刺杀剑术
    13: Result := [mm_Attack, mm_MagLock]; //灵魂火符
    14: Result := [mm_Attack]; //幽灵盾
    15: Result := [mm_Attack]; //神圣战甲术
    16: Result := [mm_Attack]; //困魔咒
    17: Result := []; //召唤骷髅
    18: Result := []; //隐身术
    19: Result := [mm_Attack]; //集体隐身术
    20: Result := [mm_Attack, mm_MagLock]; //诱惑之光
    21: Result := []; //瞬息移动
    22: Result := [mm_Attack]; //火墙
    23: Result := [mm_Attack]; //爆裂火焰
    24: Result := []; //地狱雷光
    25: Result := [mm_Warr, mm_Open]; //半月弯刀
    26: Result := [mm_Warr]; //烈火剑法
    27: Result := [mm_Warr]; //野蛮冲撞
    28: Result := [mm_Attack]; //心灵启示
    29: Result := [mm_Attack]; //群体治疗术
    30: Result := []; //召唤神兽
    31: Result := []; //魔法盾
    32: Result := [mm_Attack, mm_MagLock]; //圣言术
    33: Result := [mm_Attack]; //冰咆哮
    34: Result := [mm_Attack]; //解毒术
    35: Result := []; //狮子吼
    36: Result := [mm_Attack, mm_MagLock]; //火焰冰
    37: Result := [mm_Attack]; //群体雷电术
    38: Result := [mm_Attack]; //群体施毒术
    39: Result := [mm_Attack, mm_MagLock]; //彻地钉
    42: Result := []; //纵横剑术
    43: Result := [mm_Warr]; //开天斩
    44: Result := [mm_Attack, mm_MagLock]; //寒冰掌
    45: Result := [mm_Attack, mm_MagLock]; //灭天火
    47: Result := [mm_Attack]; //火龙气焰
    48: Result := []; //气功波
    50: Result := []; //无极真气
    52: Result := [mm_Attack]; //诅咒术
    53: Result := [mm_Attack, mm_MagLock]; //噬血术
    55: Result := [mm_Attack]; //擒龙手
    56: Result := [mm_Warr]; //逐日剑法
    57: Result := [mm_Attack]; //流星火雨
    58: Result := []; //金刚护盾
    60: Result := [mm_Attack]; //复活术
    62: Result := []; //医疗阵
    63: Result := []; //移形换位
    64: Result := [mm_Passiveness]; //护体神盾
    65: Result := []; //召唤月灵
    66: Result := [mm_Attack]; //冰霜雪雨
    67: Result := [mm_Attack, mm_MagLock]; //裂神符
    70: Result := [mm_Attack]; //十步一杀
    71: Result := [mm_Attack]; //冰霜群雨
    72: Result := [mm_Attack]; //死亡之眼
    100: Result := [mm_Warr];
    110: Result := [mm_Warr]; //三绝杀
    111: Result := [mm_Warr]; //追心刺
    112: Result := [mm_Warr]; //断岳斩
    113: Result := [mm_Warr]; //横扫千军
    114: Result := [mm_Attack, mm_MagLock]; //双龙破
    115: Result := [mm_Attack, mm_MagLock]; //凤舞技
    116: Result := [mm_Attack, mm_MagLock]; //惊雷爆
    117: Result := [mm_Attack]; //冰天雪地
    118: Result := [mm_Attack, mm_MagLock]; //虎啸决
    119: Result := [mm_Attack, mm_MagLock]; //八卦掌
    120: Result := [mm_Attack, mm_MagLock]; //三焰咒
    121: Result := [mm_Attack]; //万剑归宗
    122: Result := [mm_Warr]; //穿刺剑法
    123: Result := []; //怒气爆发
    124: Result := []; //倚天辟地
  end;

  //TMagicMode = set of (mm_Attack, mm_Passiveness, mm_Time, mm_Warr);
end;

function GetItemTypeEx(StdMode: TStdMode): TStdModeEx;
begin
  Result := [];
  case StdMode of
    tm_Weapon: Result := [sm_Arming, sm_ArmingStrong];
    tm_Dress: Result := [sm_Arming, sm_ArmingStrong];
    tm_Helmet: Result := [sm_Arming, sm_ArmingStrong];
    tm_Necklace: Result := [sm_Arming, sm_ArmingStrong];
    tm_Ring: Result := [sm_Arming, sm_ArmingStrong];
    tm_ArmRing: Result := [sm_Arming, sm_ArmingStrong];
    tm_Belt: Result := [sm_Arming, sm_ArmingStrong];
    tm_Boot: Result := [sm_Arming, sm_ArmingStrong];
    tm_Stone: Result := [sm_Arming];
    tm_House: Result := [];
    tm_Rein: Result := [sm_HorseArm];
    tm_Bell: Result := [sm_HorseArm];
    tm_Saddle: Result := [sm_HorseArm];
    tm_Decoration: Result := [sm_HorseArm];
    tm_Nail: Result := [sm_HorseArm];
    tm_Light: Result := [sm_Arming];
    tm_Drug: Result := [sm_Superposition, sm_Eat];
    tm_MissionSP: Result := [sm_Superposition, sm_Mission];
    tm_Mission: Result := [sm_Mission];
    tm_PropSP: Result := [sm_Superposition];
    tm_MakePropSP: Result := [sm_Superposition];
    tm_ResetStone: Result := [sm_Superposition];
    tm_Restrict: Result := [sm_Eat];
    tm_Reel: Result := [sm_Eat];
    tm_Book: Result := [sm_Eat];
    tm_Open: Result := [sm_Eat];
  end;
  //sm_Arming, sm_Superposition, sm_unknown
  //TStdModeEx = set of (sm_Arming, sm_Arming2, sm_Superposition, sm_Eat);
end;

function GetItemType(StdMode: Byte): TStdMode;
begin
  case StdMode of
    0: Result := tm_Drug;
    2: Result := tm_Restrict;
    3: Result := tm_Reel;
    4: Result := tm_Book;
    5, 6, 9: Result := tm_Weapon;
    7: Result := tm_Rock;
    8: Result := tm_Cowry;
    //
    10, 11: Result := tm_Dress;
    13: Result := tm_AddBag;
    15: Result := tm_Helmet;
    19, 20, 21: Result := tm_Necklace;
    22, 23: Result := tm_Ring;
    24, 26: Result := tm_ArmRing;
    25: Result := tm_Amulet;
    27: Result := tm_Belt;
    28: Result := tm_Boot;
    29: Result := tm_Stone;
    30: Result := tm_Light;
    31: Result := tm_Open;
    
    32, 33: Result := tm_House;
    34: Result := tm_Rein;
    35: Result := tm_Bell;
    36: Result := tm_Saddle;
    37: Result := tm_Decoration;
    38: Result := tm_Nail;

    40: Result := tm_Flesh;
    41: Result := tm_Revive; //还魂丹
    42: Result := tm_MakePropSP;
    43: Result := tm_Ore;
    44: Result := tm_MakeProp;

    45: Result := tm_Dice;
    46: Result := tm_MakeStone;
    47: Result := tm_ResetStone;
    48: Result := tm_PropSP;
    49: Result := tm_Prop;

    51: Result := tm_MissionSP;
    52: Result := tm_Mission;
  else
    Result := tm_unknown;
  end;
end;

function WEAPONfeature(cfeature: Integer): Byte;
begin
  Result := Hibyte(cfeature);
end;

function DRESSfeature(cfeature: Integer): Byte;
begin
  Result := Hibyte(Hiword(cfeature));
end;

function APPRfeature(cfeature: Integer): Word;
begin
  Result := Hiword(cfeature);
end;

function HAIRfeature(cfeature: Integer): Byte;
begin
  Result := Hiword(cfeature);
end;

function RACEfeature(cfeature: Integer): Byte;
begin
  Result := cfeature;
end;

function Horsefeature(cfeature: Integer): Byte;
begin
  Result := Lobyte(Loword(cfeature));
end;

function Effectfeature(cfeature: Integer): Byte;
begin
  Result := Hibyte(Loword(cfeature));
end;

function MakeHumanFeature(btRaceImg, btDress, btWeapon, btHair: Byte): Integer;
begin
  Result := MakeLong(MakeWord(btRaceImg, btWeapon), MakeWord(btHair, btDress));
end;

function MakeMonsterFeature(btRaceImg, btWeapon: Byte; wAppr: Word): Integer;
begin
  Result := MakeLong(MakeWord(btRaceImg, btWeapon), wAppr);
end;

function GetStrengthenItemName(sName: string; nLevel: Byte): string;
begin
  Result := sName;
  {case nLevel of
    1..5: Result := '粗糙的' + sName;
    6..10: Result := '精制的' + sName;
    11..15: Result := '无暇的' + sName;
    16..20: Result := '完美的' + sName;
    21: Result := '卓越的' + sName;
  end;  }
end;

function GetStrengthenItemNameByInfo(UserItem: pTUserItem; StdItem: pTStdItem): string;
begin
  {if sm_ArmingStrong in StdItem.StdModeEx then
    Result := GetStrengthenItemName(StdItem.Name, UserItem.Value.btValue[tb_StrengthenCount])
  else}
  Result := StdItem.Name;
end;


function RandomInitializeStrengthenInfo(Item: pTUserItem): Boolean;
begin
  Item.Value.StrengthenInfo.btCanStrengthenCount := CanStrengthenArr[Random(5{6}) + 1];
  Item.Value.StrengthenInfo.btStrengthenInfo[0] := Random(CanStrengthenMax[0]);
  Item.Value.StrengthenInfo.btStrengthenInfo[1] := Random(CanStrengthenMax[1]);
  Item.Value.StrengthenInfo.btStrengthenInfo[2] := Random(CanStrengthenMax[2]);
  Item.Value.StrengthenInfo.btStrengthenInfo[3] := Random(CanStrengthenMax[3]);
  Item.Value.StrengthenInfo.btStrengthenInfo[4] := Random(CanStrengthenMax[4]);
  Item.Value.StrengthenInfo.btStrengthenInfo[5] := Random(CanStrengthenMax[5]);
  Result := True;
end;

function ItemCanDrop(Item: pTUserItem; nRate: Integer): Boolean;
begin
  Result := False;
  if Item.Value.StrengthenInfo.btStrengthenCount = 18 then begin
    if Item.Value.StrengthenInfo.btStrengthenInfo[5] = 6 then  //永不掉落
      exit;
    nRate := nRate + nRate * Round((Item.Value.StrengthenInfo.btStrengthenInfo[5] + 4) / 10);
  end;
  Result := Random(nRate) = 0;
end;
(*
function GetStrengthenAbility(UserItem: pTUserItem; ItValue: pTUserItemValueArray): Boolean; overload;
var
  nIndex, nLevel: Byte;
begin
  Result := False;
  nIndex := UserItem.Value.StrengthenInfo.btStrengthenCount;
  if (nIndex = 0) then
    exit;
  Result := True;
  if nIndex >= 15 then begin
    nLevel := UserItem.Value.StrengthenInfo.btStrengthenInfo[4];
    case nLevel of
      0..2: Inc(ItValue[tb_Deadliness], nLevel + 1);
      3..23: begin
        Inc(ItValue[tb_DC2], nLevel + 7);
        Inc(ItValue[tb_SC2], nLevel + 7);
        Inc(ItValue[tb_MC2], nLevel + 7);
      end;
    end;
  end;
  if nIndex >= 12 then begin
    nLevel := UserItem.Value.StrengthenInfo.btStrengthenInfo[3];
    case nLevel of
      0..2: Inc(ItValue[tb_AddAttack], nLevel + 1);
      //3..11: Inc(StdItem.HPorMPRate, nLevel - 1);
      12..14: Inc(ItValue[tb_DelDamage], nLevel - 11);
    end;
  end;
  if nIndex >= 9 then begin
    nLevel := UserItem.Value.StrengthenInfo.btStrengthenInfo[2];
    case nLevel of
      //0..2:   Inc(StdItem.AC2Rate, nLevel + 1);
      //3..5:   Inc(StdItem.MAC2Rate, nLevel - 2);
      6..10:  Inc(ItValue[tb_DC2], nLevel - 5);
      11..15: Inc(ItValue[tb_SC2], nLevel - 10);
      16..20: Inc(ItValue[tb_MC2], nLevel - 15);
    end;
  end;
  if nIndex >= 6 then begin
    nLevel := UserItem.Value.StrengthenInfo.btStrengthenInfo[1];
    case nLevel of
      0..4: Inc(ItValue[tb_DelWuXinAttack], nLevel + 1);
      //5..14: Inc(StdItem.ExpRate, nLevel - 4);
      15..19: Inc(ItValue[tb_AddWuXinAttack], nLevel - 14);
    end;
  end;
  if nIndex >= 3 then begin
    nLevel := UserItem.Value.StrengthenInfo.btStrengthenInfo[0];
    case nLevel of
      0..2: Inc(ItValue[tb_Hit], nLevel + 1);
      3..7: Inc(ItValue[tb_HP], (nLevel - 2) * 10);
      8..12: Inc(ItValue[tb_MP], (nLevel - 7) * 10);
      13..15: Inc(ItValue[tb_Speed], nLevel - 12);
    end;
  end;
end;    *)

function GetStrengthenAbility(UserItem: pTUserItem; var StdItem: TStdItem): Boolean;
var
  nIndex, nLevel: Byte;
begin
  Result := False;
  nIndex := UserItem.Value.StrengthenInfo.btStrengthenCount;
  if (nIndex = 0) then exit;
  Result := True;
  if nIndex >= 15 then begin
    nLevel := UserItem.Value.StrengthenInfo.btStrengthenInfo[4];
    case nLevel of
      0..2: Inc(StdItem.Deadliness, nLevel + 1);
      3..23: begin
        Inc(StdItem.nDC2, nLevel + 7);
        Inc(StdItem.nSC2, nLevel + 7);
        Inc(StdItem.nMC2, nLevel + 7);
      end;
    end;
  end;
  if nIndex >= 12 then begin
    nLevel := UserItem.Value.StrengthenInfo.btStrengthenInfo[3];
    case nLevel of
      0..2: Inc(StdItem.AddAttack, nLevel + 1);
      3..11: Inc(StdItem.HPorMPRate, nLevel - 1);
      12..14: Inc(StdItem.DelDamage, nLevel - 11);
    end;
  end;
  if nIndex >= 9 then begin
    nLevel := UserItem.Value.StrengthenInfo.btStrengthenInfo[2];
    case nLevel of
      0..2:   Inc(StdItem.AC2Rate, nLevel + 1);
      3..5:   Inc(StdItem.MAC2Rate, nLevel - 2);
      6..10:  Inc(StdItem.nDC2, nLevel - 5);
      11..15: Inc(StdItem.nSC2, nLevel - 10);
      16..20: Inc(StdItem.nMC2, nLevel - 15);
    end;
  end;
  if nIndex >= 6 then begin
    nLevel := UserItem.Value.StrengthenInfo.btStrengthenInfo[1];
    case nLevel of
      0..4: Inc(StdItem.DelWuXinAttack, nLevel + 1);
      5..14: Inc(StdItem.ExpRate, nLevel - 4);
      15..19: Inc(StdItem.AddWuXinAttack, nLevel - 14);
    end;
  end;
  if nIndex >= 3 then begin
    nLevel := UserItem.Value.StrengthenInfo.btStrengthenInfo[0];
    case nLevel of
      0..2: Inc(StdItem.HitPoint, nLevel + 1);
      3..7: Inc(StdItem.HP, (nLevel - 2) * 10);
      8..12: Inc(StdItem.MP, (nLevel - 7) * 10);
      13..15: Inc(StdItem.SpeedPoint, nLevel - 12);
    end;
  end;
end;

procedure GetHorseLevelAbility(UserItem: pTUserItem; StdItem: pTStdItem; var AddAbility: TAddAbility);
begin
  FillChar(AddAbility, SizeOf(AddAbility), #0);
  if StdItem.StdMode = tm_House then begin
    AddAbility.HP := _MIN(High(Word), 14 + ROUND(((UserItem.btLevel / 4 + 4 + UserItem.btLevel / 20) * UserItem.btLevel)));
    AddAbility.AC :=  UserItem.btLevel div 7 div 2;
    AddAbility.AC2 := UserItem.btLevel div 7;
    AddAbility.MAC := ROUND(UserItem.btLevel / 6) div 2;
    AddAbility.MAC2 := ROUND(UserItem.btLevel / 6) + 1;
    AddAbility.DC := _MAX((UserItem.btLevel div 5) - 1, 1);
    AddAbility.DC2 := _MAX(1, (UserItem.btLevel div 5));
    AddAbility.wHitPoint := 12;
    AddAbility.wSpeedPoint := 12;
  end;
end;

procedure GetHorseAddAbility(UserItem: pTUserItem; StdItem: pTStdItem; nIndex: Byte; var AddAbility: TAddAbility);
begin
  if nIndex in [Low(UserItem.HorseItems)..High(UserItem.HorseItems)] then begin
    AddAbility.HP := _MIN(High(Word), AddAbility.HP + StdItem.HP + UserItem.HorseItems[nIndex].btHP);
    AddAbility.AC :=  _MIN(High(Word), AddAbility.AC + StdItem.nAC);
    AddAbility.AC2 := _MIN(High(Word), AddAbility.AC2 + StdItem.nAC2 + UserItem.HorseItems[nIndex].btAC);
    AddAbility.MAC :=  _MIN(High(Word), AddAbility.MAC + StdItem.nMAC);
    AddAbility.MAC2 := _MIN(High(Word), AddAbility.MAC2 + StdItem.nMAC2 + UserItem.HorseItems[nIndex].btMAC);
    AddAbility.DC :=  _MIN(High(Word), AddAbility.DC + StdItem.nDC);
    AddAbility.DC2 := _MIN(High(Word), AddAbility.DC2 + StdItem.nDC2 + UserItem.HorseItems[nIndex].btDC);
    AddAbility.wHitPoint := _MIN(High(Word), AddAbility.wHitPoint + StdItem.HitPoint);
    AddAbility.wSpeedPoint := _MIN(High(Word), AddAbility.wHitPoint + StdItem.SpeedPoint);
  end;
end;

function LongWordToDateTime(dwTime: LongWord): TDateTime;
var
  wYear, wMonth, wDay, wHour, wMinute: Word;
begin
  if dwTime > 0 then begin
    wMinute := dwTime and $3F;
    wHour := (dwTime shr 6) and $1F;
    wDay := (dwTime shr 11) and $1F;
    wMonth := (dwTime shr 16) and $F;
    wYear := (dwTime shr 20) and $FFF;
    Try
      Result := EncodeDateTime(wYear, wMonth, wDay, wHour, wMinute, 0, 0);
    Except
      Result := 0;
    End;
  end else
    Result := 0;
end;

function DateTimeToLongWord(DateTime: TDateTime): LongWord;
var
  wYear, wMonth, wDay, wHour, wMinute: Word;
begin
  if DateTime > 0 then begin
    wYear := YearOf(DateTime) and $FFF;
    wMonth := MonthOf(DateTime) and $F;
    wDay := DayOf(DateTime) and $1F;
    wHour := HourOf(DateTime) and $1F;
    wMinute := MinuteOf(DateTime) and $3F;
    Result := wMinute or (wHour shl 6) or (wDay shl 11) or (wMonth shl 16) or (wYear shl 20);
  end else
    Result := 0;
end;

function UserItemToHorseItem(UserItem: pTUserItem): THorseItem;
begin
  FillChar(Result, SizeOf(THorseItem), #0);
  Result.wIndex := UserItem.wIndex;
  Result.MakeIndex := UserItem.MakeIndex;
  Result.Dura := UserItem.Dura;
  Result.btBindMode1 := UserItem.btBindMode1;
  Result.btBindMode2 := UserItem.btBindMode2;
  Result.TermTime := UserItem.TermTime;
  Result.btAC := UserItem.Value.btValue[tb_AC2];
  Result.btMAC := UserItem.Value.btValue[tb_MAC2];
  Result.btDC := UserItem.Value.btValue[tb_DC2];
  Result.btHP := UserItem.Value.btValue[tb_HP];
end;

function HorseItemToUserItem(HorseItem: pTHorseItem; StdItem: pTStdItem): TUserItem;
begin
  FillChar(Result, SizeOf(TUserItem), #0);
  Result.MakeIndex := HorseItem.MakeIndex;
  Result.wIndex := HorseItem.wIndex;
  Result.Dura := HorseItem.Dura;
  Result.DuraMax := StdItem.DuraMax;
  Result.btBindMode1 := HorseItem.btBindMode1;
  Result.btBindMode2 := HorseItem.btBindMode2;
  Result.TermTime := HorseItem.TermTime;
  Result.Value.btValue[tb_AC2] := HorseItem.btAC;
  Result.Value.btValue[tb_MAC2] := HorseItem.btMAC;
  Result.Value.btValue[tb_DC2] := HorseItem.btDC;
  Result.Value.btValue[tb_HP] := HorseItem.btHP;
end;

end.

