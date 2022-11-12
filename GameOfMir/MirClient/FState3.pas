unit FState3;

interface                                                                        
uses
  Windows, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs, MudUtil, MNShare, HGE,  
  MShare, HGEGUI, WIL, HGETextures, Grobal2, Grids, Share, WMFile;

const
  MakeMagicName: array[0..mm_MaxCount] of String[8] = ('打造武器', '打造盔甲', '打造头盔', '打造项链', '打造手镯', '打造戒指', '打造腰带', '打造靴子', '打造药品', '打造材料');


type


  pTGuildSocietyInfo = ^TGuildSocietyInfo;
  TGuildSocietyInfo = packed record
    sGuildName: string[20];
    sUserName: string[14];
    btLevel: Byte;
  end;

  pTSetupFiltrate = ^TSetupFiltrate;
  TSetupFiltrate = packed record
    boShow: Boolean;
    boPickUp: Boolean;
    boColor: Boolean;
    StdMode: TStdMode;
    wIdent: Word;
  end;

  TFrmDlg3 = class(TForm)
    DWndArmStrengthen: TDWindow;
    DArmStrengthenLevel: TDGrid;
    DArmStrengthenAss: TDGrid;
    DArmItem: TDButton;
    DArmOK: TDButton;
    DArmClose: TDButton;
    DArmClose2: TDButton;
    DWndMakeItem: TDWindow;
    DMakeItemItems: TDGrid;
    DMakeItemAss: TDGrid;
    DMakeItemArming: TDButton;
    DMakeItemOK: TDButton;
    DMakeItemClose: TDButton;
    DMakeItemClose2: TDButton;
    DMakeItemTreeView: TDTreeView;
    DMakeItemTreeViewUpDown: TDUpDown;
    DWndItemUnseal: TDWindow;
    DItemUnsealOK: TDButton;
    DItemUnsealClose2: TDButton;
    DItemUnsealArm: TDButton;
    DItemUnsealItems: TDGrid;
    DItemUnsealClose: TDButton;
    DGuildDlg: TDWindow;
    DGuildInfoDlg: TDWindow;
    DGuildLogDlg: TDWindow;
    DGuildAllyDlg: TDWindow;
    DGDClose: TDButton;
    DGDHome: TDButton;
    DGDInfo: TDButton;
    DGDAlly: TDButton;
    DGDAddMem: TDButton;
    DGDDelMem: TDButton;
    DGDEditGrade: TDButton;
    DGDEditRefMemberList: TDButton;
    DCheckBoxShowMember: TDCheckBox;
    DGDEditFind: TDButton;
    DEditFind: TDEdit;
    DGDUpLevel: TDButton;
    DGDSetMoney: TDButton;
    DGDGetMoney: TDButton;
    DMemoGuildNotice: TDMemo;
    DGuildNoticeUpDown: TDUpDown;
    DGDEditNotice: TDButton;
    DGDEditNoticeSave: TDButton;
    DGuildMemberDlg: TDWindow;
    DGuildMemberUpDown: TDUpDown;
    DGuildWarUpDown: TDUpDown;
    DGuildAllyUpDown: TDUpDown;
    DGDAllyAdd: TDButton;
    DGDBreakAlly: TDButton;
    DGDSortComboBox: TDComboBox;
    DGuildLogNotice: TDButton;
    DMemoGuildMember: TDMemo;
    DUpDownGuildMember: TDUpDown;
    DPopUpMemuGuild: TDPopUpMemu;
    DGameSetup: TDWindow;
    DGSClose: TDButton;
    DGSConfig: TDButton;
    DGSFunction: TDButton;
    DGSProtect: TDButton;
    DGSItems: TDButton;
    DGSMagics: TDButton;
    DGSSave: TDButton;
    DGSApp: TDButton;
    DGSClose2: TDButton;
    DGSDefault: TDButton;
    DDGSSetup: TDWindow;
//    DDGSWindow: TDCheckBox;
    DDGSVPN: TDCheckBox;
    DDGSZIP: TDCheckBox;
    DDGSBits: TDComboBox;
    DDGSXY: TDComboBox;
    DDGSDisplay: TDComboBox;
    DDGSMp3: TDButton;
    DDGSMusic: TDButton;
    DDFunction: TDWindow;
    DDFShowName: TDCheckBox;
    DDFDureHint: TDCheckBox;
    DDFShift: TDCheckBox;
    DDFMapHint: TDCheckBox;
    DDFExp: TDCheckBox;
    DDFCtrl: TDCheckBox;
    DDFDeal: TDCheckBox;
    DDFGroup: TDCheckBox;
    DDFFriend: TDCheckBox;
    DDFGuild: TDCheckBox;
    DDFAroundHum: TDCheckBox;
    DDFAllyHum: TDCheckBox;
    dchkDDFNewChangeMap: TDCheckBox;
    DDFMagicEnd: TDCheckBox;
    DDGSMp3Close: TDCheckBox;
    DDGSMusicClose: TDCheckBox;
    DEFExp: TDEdit;
    DDGProtect: TDWindow;
    DDPHP: TDCheckBox;
    DDPMP: TDCheckBox;
    DDPHP2: TDCheckBox;
    DDPMP2: TDCheckBox;
    DDPReel: TDCheckBox;
    DDPHPCount: TDEdit;
    DDPHPTime: TDEdit;
    DDPMPCount: TDEdit;
    DDPMPTime: TDEdit;
    DDPHP2Count: TDEdit;
    DDPHP2Time: TDEdit;
    DDPMP2Count: TDEdit;
    DDPMP2Time: TDEdit;
    DDPReelCount: TDEdit;
    DDPReelTime: TDEdit;
    DDPReelItem: TDComboBox;
    DDItems: TDWindow;
    DDItemUpDown: TDUpDown;
    DDItemsClass: TDComboBox;
    DDitemFind: TDEdit;
    DDPickupAllItem: TDCheckBox;
    DDMagic: TDWindow;
    DDMCX: TDCheckBox;
    DDMBY: TDCheckBox;
    DDMLH: TDCheckBox;
    DDMMFD: TDCheckBox;
    DDMYS: TDCheckBox;
    DDMAutoMagic: TDCheckBox;
    DDMTime: TDEdit;
    DDMMagicList: TDComboBox;
    DDFHPShow: TDCheckBox;
    DDFHideHelmet: TDCheckBox;
    dwndSaySetup: TDWindow;
    dbtnGSSay: TDButton;
    dchkSayWhisper: TDCheckBox;
    dchkSayCry: TDCheckBox;
    dchkSayGroup: TDCheckBox;
    dchkSayGuild: TDCheckBox;
    dchkSayHear: TDCheckBox;
    dwndMission: TDWindow;
    dbtnMissionClose: TDButton;
    dbtnMissionTrack: TDButton;
    dbtnMissionLogout: TDButton;
    dbtnMissionAccept: TDButton;
    dwndMissionInfo: TDWindow;
    DTrvwMission: TDTreeView;
    DUDwnTreeMission: TDUpDown;
    DUDwnMissionInfo: TDUpDown;
    dchkShowNameAll: TDCheckBox;
    dchkShowNameMon: TDCheckBox;
    dwndBox: TDWindow;
    dbtnBoxClose: TDButton;
    dbtnBoxItem10: TDButton;
    dbtnBoxItem11: TDButton;
    dbtnBoxItem9: TDButton;
    dbtnBoxItem1: TDButton;
    dbtnBoxItem2: TDButton;
    dbtnBoxItem3: TDButton;
    dbtnBoxItem8: TDButton;
    dbtnBoxItem0: TDButton;
    dbtnBoxItem4: TDButton;
    dbtnBoxItem7: TDButton;
    dbtnBoxItem6: TDButton;
    dbtnBoxItem5: TDButton;
    dbtnBoxGetItem: TDButton;
    dbtnBoxNext: TDButton;
    DMakeMagicxAutoMake: TDCheckBox;
    DWindowTop: TDWindow;
    DTopClose: TDButton;
    DTopButton0: TDButton;
    DTopButton1: TDButton;
    DTopButton2: TDButton;
    DTopButton3: TDButton;
    DTopButton4: TDButton;
    DTopButton5: TDButton;
    DTopButton6: TDButton;
    DTopButton7: TDButton;
    DTopButton8: TDButton;
    DTopButton9: TDButton;
    DTopButton10: TDButton;
    DTopButton11: TDButton;
    DTopButton12: TDButton;
    DTopButton13: TDButton;
    DTopFirst: TDButton;
    DTopUp: TDButton;
    DTopDown: TDButton;
    DTopLastly: TDButton;
    DTopMy: TDButton;
    DTopList1: TDWindow;
    DTopList2: TDWindow;
    DDMSnowWindLock: TDCheckBox;
    DDMCS: TDCheckBox;
    DDMLongIceHit: TDCheckBox;
    DDMFieryDragonLock: TDCheckBox;
    DDAPMagicList: TDComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DWndArmStrengthenVisible(Sender: TObject; boVisible: Boolean);
    procedure DWndArmStrengthenDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DArmClose2DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DArmClose2ClickSound(Sender: TObject; Clicksound: TClickSound);
    procedure DArmItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DArmCloseClick(Sender: TObject; X, Y: Integer);
    procedure DArmItemClick(Sender: TObject; X, Y: Integer);
    procedure DArmItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DArmStrengthenLevelGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DArmStrengthenLevelGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DArmStrengthenLevelGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DArmStrengthenAssGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DArmStrengthenAssGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DArmStrengthenAssGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DArmOKClick(Sender: TObject; X, Y: Integer);
    procedure DWndMakeItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWndMakeItemVisible(Sender: TObject; boVisible: Boolean);
    procedure DMakeItemTreeViewTreeViewSelect(Sender: TObject; DTreeNodes: pTDTreeNodes);
    procedure DMakeItemItemsGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DMakeItemArmingDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMakeItemItemsGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DMakeItemArmingMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DMakeItemAssGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DMakeItemAssGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DMakeItemAssGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DMakeItemItemsGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DMakeItemArmingClick(Sender: TObject; X, Y: Integer);
    procedure DMakeItemClose2Click(Sender: TObject; X, Y: Integer);
    procedure DMakeItemOKClick(Sender: TObject; X, Y: Integer);
    procedure DItemUnsealCloseClick(Sender: TObject; X, Y: Integer);
    procedure DWndItemUnsealDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWndItemUnsealVisible(Sender: TObject; boVisible: Boolean);
    procedure DItemUnsealArmClick(Sender: TObject; X, Y: Integer);
    procedure DItemUnsealArmDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DItemUnsealArmMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DItemUnsealItemsGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DItemUnsealItemsGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DItemUnsealItemsGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DItemUnsealOKClick(Sender: TObject; X, Y: Integer);
    procedure DGuildDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DGuildAllyDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DGDCloseClick(Sender: TObject; X, Y: Integer);
    procedure DGDHomeClick(Sender: TObject; X, Y: Integer);
    procedure DGDHomeDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DEditFindMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DGuildMemberDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DGuildLogNoticeDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DGuildDlgVisible(Sender: TObject; boVisible: Boolean);
    procedure DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
    procedure DGuildMemberDlgEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DGDSortComboBoxChange(Sender: TObject);
    procedure DGuildMemberDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGuildDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGuildMemberDlgClick(Sender: TObject; X, Y: Integer);
    procedure DGuildMemberDlgDblClick(Sender: TObject);
    procedure DGuildMemberDlgMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DPopUpMemuGuildPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
    procedure DGDDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DGDAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DEditFindChange(Sender: TObject);
    procedure DGDSetMoneyClick(Sender: TObject; X, Y: Integer);
    procedure DGDGetMoneyClick(Sender: TObject; X, Y: Integer);
    procedure DGuildAllyDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGuildAllyDlgClick(Sender: TObject; X, Y: Integer);
    procedure DGuildAllyDlgMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DGDAllyAddClick(Sender: TObject; X, Y: Integer);
    procedure DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
    procedure DGSConfigDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DGSConfigClick(Sender: TObject; X, Y: Integer);
    procedure DGameSetupDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DDGSSetupDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DDGSMp3DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DDGSMp3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DDItemsEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DGameSetupVisible(Sender: TObject; boVisible: Boolean);
    procedure DDItemsClassChange(Sender: TObject);
    procedure DGameSetupMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DDItemsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DDItemsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DGSDefaultClick(Sender: TObject; X, Y: Integer);
    procedure DGSAppClick(Sender: TObject; X, Y: Integer);
    procedure DGSSaveClick(Sender: TObject; X, Y: Integer);
    procedure DDitemFindChange(Sender: TObject);
    procedure DDMCXChange(Sender: TObject);
    procedure DMakeItemTreeViewTreeClearItem(Sender: TObject; DTreeNodes: pTDTreeNodes);
    procedure dwndMissionDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dwndMissionInfoDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTrvwMissionTreeViewSelect(Sender: TObject; DTreeNodes: pTDTreeNodes);
    procedure dwndMissionInfoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure dwndMissionMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure dwndMissionInfoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure dwndMissionInfoClick(Sender: TObject; X, Y: Integer);
    procedure dwndMissionVisible(Sender: TObject; boVisible: Boolean);
    procedure dbtnMissionAcceptClick(Sender: TObject; X, Y: Integer);
    procedure dbtnMissionTrackClick(Sender: TObject; X, Y: Integer);
    procedure dbtnMissionTrackMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DDPickupAllItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGDUpLevelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGuildInfoDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGDUpLevelClick(Sender: TObject; X, Y: Integer);
    procedure dchkShowNameAllChange(Sender: TObject);
    procedure dwndBoxDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dbtnBoxItem0DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dbtnBoxItem11MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure dbtnBoxNextClick(Sender: TObject; X, Y: Integer);
    procedure dbtnBoxGetItemClick(Sender: TObject; X, Y: Integer);
    procedure dbtnMissionLogoutClick(Sender: TObject; X, Y: Integer);
    procedure DWindowTopDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopButton0Click(Sender: TObject; X, Y: Integer);
    procedure DTopButton0DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopList1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWindowTopVisible(Sender: TObject; boVisible: Boolean);
    procedure DTopFirstClick(Sender: TObject; X, Y: Integer);
    procedure DTopList1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DWindowTopMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DTopList1Click(Sender: TObject; X, Y: Integer);
    procedure DGDAddMemDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DGDUpLevelDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DArmOKDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dbtnMissionTrackDirectPaint(Sender: TObject; dsurface: TDXTexture);
  private
    { Private declarations }
    FStrengthenHint: string;
    FStrengthenLevel: TArmStrengthenArr;
    FStrengthenAss: TArmStrengthenArr;
    FStrengthenItem: TMovingItem;
    FStrengthenUseItem: TUserItem;
    FStrengthenLock: Boolean;
    FStrengthenMoney: Integer;
    FStrengthenMaxRate: Integer;
    FStrengthenRate: Integer;
    FStrengthenDownLevelRate: Integer;
    FStrengthenBreakUpRate: Integer;
    FStrengthenShowTick: LongWord;
    FStrengthenShowSchedule: Boolean;
    FStrengthenSchedulePosition: Integer;
    FStrengthenLevelType: Byte;
    FStrengthenShowEffect: Boolean;
    FStrengthenShowEffectType: Byte;

    //    FMakeItemList: TList;
    FMakeGoods: TClientMakeGoods;
    FMakeItemHint: string;
    FMakeItemHint2: string;
    FMakeItemLevel: TArmStrengthenArr;
    FMakeItemAss: TArmStrengthenArr;
    FMakeItemItem: TMovingItem;
    FMakeItemUseItem: TUserItem;
    FMakeItemBackItem: TMovingItem;
    FMakeItemLock: Boolean;
    FMakeItemRate: Integer;
    FMakeItemShowTick: LongWord;
    FMakeItemShowSchedule: Boolean;
    FMakeItemSchedulePosition: Integer;
    FMakeItemShowEffect: Boolean;
    FMakeMagicIdx: Byte;
    FMakeAutoMake: Boolean;

    FUnsealItem: TMovingItem;
    FUnsealLevel: array[0..7] of TMovingItem;
    FUnsealLock: Boolean;
    FUnsealShowEffect: Boolean;
    FUnsealShowIndex: Integer;
    FUnSealShowTick: LongWord;
    GuildIndex: Integer;
    GuildNoticeIndex: Integer;
    GuildSaveNoticeTick: LongWord;
    GuildSaveMemberTick: LongWord;
    GuildRefMemberTick: LongWord;
    GuildMoveIndex: Integer;
    GuildSelectIndex: Integer;
    GuildOldFindIndex: Integer;
    GuildAllyMoveIndex: Integer;
    GuildAllySelectIndex: Integer;
    GuildWarMoveIndex: Integer;
    GuildWarSelectIndex: Integer;

    //游戏设置
    FSetupIndex: Integer;
    FItemShowList: TStringList;
    FItemShowAllList: TStringList;
    FItemMoveIndex: Integer;


    MDlgPoints: TList;
    MDlgDraws: TList;
    MDlgRefTime: LongWord;
    MerchantHeight: Integer;
    MDlgMove: TClickPoint;
    MDlgSelect: TClickPoint;
    FMissionLogoutTick: LongWord;
  public
    GuildMemberList: TQuickStringPointerList;
    GuildMemberStrs: TStringList;
    GuildOnLineMemberList: TQuickStringPointerList;
    GuildNoticeList: TStringList;
    GuildWarList: TList;
    GuildAllyList: TList;
    GuildMasterName: string;
    MDlgStr: string;
    MDlgChange: Boolean;
    ShowCanAccept: Boolean;
    boGuildLevelUp: Boolean;
    OpenBoxItems: array[0..11] of TClientOpenBoxInfo;
    OpenBoxGold: Integer;
    OpenBoxGameGold: Integer;
    OpenBoxIndex: Integer;
    OpenBoxSelectIndex: Integer;
    OpenBoxMove: Boolean;
    OpenBoxStop: Boolean;
    OpenBoxMoveTick: LongWord;
    OpenBoxMoveIndex: Integer;
    OpenGetItemIndex: Integer;
    OpenStopIndex: Integer;
    OpenCanStop: Boolean;
    OpenGetItem: Boolean;
    OpenBoxShowEffect: Boolean;
    OpenBoxEffectIdx: Integer;
    OpenBoxEffectTick: LongWord;
    FMakeMagicShow: Boolean;
    FTopIndex: Byte;
    FboTopSend: Boolean;
    FTopInfo: TClientTopInfo;
    FnMaxTopPage: Integer;
    FnMinTopPage: Integer;
    FTopMoveIndex: Integer;
    procedure Initialize;
    procedure InitializeEx();
    procedure ClearStrengthenInfo();
    procedure ClearStrengthenInfoEx();
    procedure RefStrengthenRateInfo();
    procedure RefMakeItemRateInfo();
    procedure ClientStrengthenItems(nID: Integer; sMsg: string);
    procedure ClientMakeItems(nID, nCount: Integer; sMsg: string);
    procedure ClearMakeItemInfo();
    procedure ClearUnSealInfo();
    procedure ClientUnSealItems(nID: Integer; sMsg: string);
    procedure ChangeGuildDlg(DlgIndex: Integer);
    procedure ClearGuildMemberInfo();
    procedure ClearGuildSocietyInfo;
    procedure AddGuildMember(btRank: Byte; nCount: Integer; sRankName, sUserName: string);
    procedure DelGuildMember(sUserName: string);
    procedure GuildChange(Msg: pTDefaultMessage; sBody: string);
    procedure ClearItemShowList;
    procedure SetButtonHight(Button: TDButton; nLeft: Integer);
    procedure ShowMissionDlg(ClientMissionInfo: pTClientMissionInfo; sMsg: string = '');
    procedure InitializeMissionTree;
    procedure OpenBox(nIndex, nSelectIndex: Integer);
    function CanArmStrengthenAdd(Item: pTNewClientItem): Boolean;
    procedure ArmStrengthenAdd(nItemIndex: Integer);
    function CanMakeItemAdd(Item: pTNewClientItem): Boolean;
    procedure MakeItemAdd(nItemIndex: Integer);
    function CanItemUnsealAdd(Item: pTNewClientItem): Boolean;
    procedure ItemUnsealAdd(nItemIndex: Integer);
    procedure ShowMakeWindow(nIdx: Byte);
    //procedure ClientMakeItemsList();

  end;

var
  FrmDlg3: TFrmDlg3;
  sXML4: string = 'T';
  sXML5: string = 'H';

implementation

uses
  SoundUtil, ClMain, DrawScrn, ClFunc, cliUtil, HUtil32, GameSetup, FState, EDcodeEx, HGEBase,
  FState2, Registry, Bass, IniFiles, ClientSetup;
{$R *.dfm}

const
  MDLGCLICKOX = 25;
  MDLGCHICKOY = 1;
  MDLGMOVEIMAGE = 622;
  MDLGCHICKIMAGE = 623;
{$IF Var_Interface = Var_Mir2}
  MDLGMAXWIDTH = 229;
  MDLGMAXHEIGHT = 1024;
  MERCHANTMAXHEIGHT = 213;
  MERCHANTMAXWIDTH = 229;
{$ELSE}
  MDLGMAXWIDTH = 242;
  MDLGMAXHEIGHT = 1024;
  MERCHANTMAXHEIGHT = 333;
  MERCHANTMAXWIDTH = 242;
{$IFEND}

procedure TFrmDlg3.GuildChange(Msg: pTDefaultMessage; sBody: string);
var
  MemberList: TQuickStringPointerList;
  I: integer;
  GuildMemberInfo: pTGuildMemberInfo;
begin
  if DCheckBoxShowMember.Checked then
    MemberList := GuildMemberList
  else
    MemberList := GuildOnLineMemberList;
  GuildMemberInfo := nil;
  for I := 0 to MemberList.Count - 1 do begin
    if CompareText(pTGuildMemberInfo(MemberList.Objects[i]).UserName, sBody) = 0 then begin
      GuildMemberInfo := pTGuildMemberInfo(MemberList.Objects[i]);
      break;
    end;
  end;
  case Msg.Series of
    1: begin
        if GuildMemberInfo <> nil then begin
          GuildMemberInfo.nTime := -1;
          DGDSortComboBoxChange(DGDSortComboBox);
        end;
      end;
    2: begin
        if GuildMemberInfo <> nil then begin
          GuildMemberInfo.nTime := 0;
          DGDSortComboBoxChange(DGDSortComboBox);
        end;
      end;
  end;
end;

procedure TFrmDlg3.AddGuildMember(btRank: Byte; nCount: Integer; sRankName, sUserName: string);
var
  GuildMemberInfo: pTGuildMemberInfo;
  I: Integer;
  str: string;
  boBegin, boEnd: Boolean;
begin
  New(GuildMemberInfo);
  GuildMemberInfo.UserName := sUserName;
  GuildMemberInfo.RankName := sRankName;
  GuildMemberInfo.btRank := btRank;
  GuildMemberInfo.nCount := nCount;
  GuildMemberInfo.nTime := -1;

  case DGDSortComboBox.ItemIndex of
    0: begin
        GuildMemberList.AddObject(Format('%.3d%3.d', [btRank, nCount]), TObject(GuildMemberInfo));
        GuildOnLineMemberList.AddObject(Format('%.3d%3.d', [btRank, nCount]), TObject(GuildMemberInfo));
      end;
    1: begin
        GuildMemberList.AddObject(sRankName, TObject(GuildMemberInfo));
        GuildOnLineMemberList.AddObject(sRankName, TObject(GuildMemberInfo));
      end;
    2: begin
        GuildMemberList.AddObject(sUserName, TObject(GuildMemberInfo));
        GuildOnLineMemberList.AddObject(sUserName, TObject(GuildMemberInfo));
      end;
    3: begin
        GuildMemberList.AddObject(Format('%.8d%.3d%3.d', [0, btRank, nCount]), TObject(GuildMemberInfo));
        GuildOnLineMemberList.AddObject(Format('%.8d%.3d%3.d', [0, btRank, nCount]), TObject(GuildMemberInfo));
      end;
  end;
  GuildMemberList.SortString(0, GuildMemberList.Count - 1);
  GuildOnLineMemberList.SortString(0, GuildOnLineMemberList.Count - 1);
  boBegin := False;
  boEnd := False;
  for I := 0 to GuildMemberStrs.Count - 1 do begin
    if not boBegin then begin
      str := '#' + IntToStr(btRank);
      if CompareLStr(GuildMemberStrs[I], str, length(str)) then begin
        boBegin := True;
      end;
    end
    else if not boEnd then begin
      str := GuildMemberStrs[I];
      if (str = ' ') or ((str <> '') and (str[1] = '#')) then begin
        GuildMemberStrs.Insert(I, sUserName);
        boEnd := True;
        break;
      end;
    end;
  end;
  if boBegin and (not boEnd) then
    GuildMemberStrs.Add(sUserName)
  else if not boBegin then begin
    GuildMemberStrs.Add(' ');
    GuildMemberStrs.Add('#' + IntToStr(btRank) + ' <' + sRankName + '>');
    GuildMemberStrs.Add(sUserName);
  end;

end;

function TFrmDlg3.CanItemUnsealAdd(Item: pTNewClientItem): Boolean;
begin
  Result := False;
  if FUnsealLock or g_boItemMoving then exit;
  Result := CheckItemBindMode(@Item.UserItem, bm_Unknown)
end;

procedure TFrmDlg3.ItemUnsealAdd(nItemIndex: Integer);
begin
  if FUnsealLock or g_boItemMoving then exit;
  if CheckItemBindMode(@g_ItemArr[nItemIndex].UserItem, bm_Unknown) then begin
    g_boItemMoving := True;
    g_MovingItem.Index2 := nItemIndex;
    g_MovingItem.Item := g_ItemArr[nItemIndex];
    g_MovingItem.ItemType := mtBagItem;
    DelItemBagByIdx(nItemIndex);
    ItemClickSound(g_ItemArr[nItemIndex].S);
    DItemUnsealArmClick(DItemUnsealArm, 0, 0);
  end;
end;

function TFrmDlg3.CanMakeItemAdd(Item: pTNewClientItem): Boolean;
var
  i: Integer;
begin
  Result := False;
  if FMakeItemLock  or g_boItemMoving then exit;
  for I := 1 to 5 do begin
    if (FMakeGoods.Item[I].s.Name <> '') and (FMakeGoods.Item[I].s.Idx = Item.s.Idx) then begin
      Result := True;
      Exit;
    end;
  end;
  if (tm_MakeStone = Item.s.StdMode) and (Item.s.Shape = 2) then
    Result := True;
end;

procedure TFrmDlg3.MakeItemAdd(nItemIndex: Integer);
var
  Item: pTNewClientItem;
  I: Integer;
begin
  if FMakeItemLock  or g_boItemMoving then exit;
  Item := @g_ItemArr[nItemIndex];
  for I := 1 to 5 do begin
    if (FMakeGoods.Item[I].s.Name <> '') and (FMakeGoods.Item[I].s.Idx = Item.s.Idx) and
      (FMakeItemLevel[i].Item.s.Name = '') then begin
      g_boItemMoving := True;
      g_MovingItem.Index2 := nItemIndex;
      g_MovingItem.Item := g_ItemArr[nItemIndex];
      g_MovingItem.ItemType := mtBagItem;
      DelItemBagByIdx(nItemIndex);
      ItemClickSound(g_ItemArr[nItemIndex].S);
      DMakeItemItemsGridSelect(DMakeItemItems, 0, 0, I - 1, 0, []);
      Exit;
    end;
  end;
  if (tm_MakeStone = Item.s.StdMode) and (Item.s.Shape = 2) then begin
    for I := 0 to 4 do begin
      if FMakeItemAss[i].Item.s.Name = '' then begin
        g_boItemMoving := True;
        g_MovingItem.Index2 := nItemIndex;
        g_MovingItem.Item := g_ItemArr[nItemIndex];
        g_MovingItem.ItemType := mtBagItem;
        DelItemBagByIdx(nItemIndex);
        ItemClickSound(g_ItemArr[nItemIndex].S);
        DMakeItemAssGridSelect(DMakeItemAss, 0, 0, I, 0, []);
        break;
      end;
    end;
  end;
end;

function TFrmDlg3.CanArmStrengthenAdd(Item: pTNewClientItem): Boolean;
begin
  Result := False;
  if FStrengthenLock or g_boItemMoving then exit;
  if sm_ArmingStrong in Item.s.StdModeEx then
    Result := True;
  if (tm_MakeStone = Item.s.StdMode) and (Item.s.Shape = 0) then
    Result := True;
  if (tm_MakeStone = Item.s.StdMode) and (Item.s.Shape in [1, 2]) then
    Result := True;
end;

procedure TFrmDlg3.ArmStrengthenAdd(nItemIndex: Integer);
var
  Item: pTNewClientItem;
  I: Integer;
begin
  if FStrengthenLock or g_boItemMoving or g_boItemMoving then exit;
  Item := @g_ItemArr[nItemIndex];
  if sm_ArmingStrong in Item.s.StdModeEx then begin
    g_boItemMoving := True;
    g_MovingItem.Index2 := nItemIndex;
    g_MovingItem.Item := g_ItemArr[nItemIndex];
    g_MovingItem.ItemType := mtBagItem;
    DelItemBagByIdx(nItemIndex);
    ItemClickSound(g_ItemArr[nItemIndex].S);
    DArmItemClick(DArmItem, 0, 0);
  end else
  if (tm_MakeStone = Item.s.StdMode) and (Item.s.Shape = 0) then begin
    for I := 0 to 4 do begin
      if FStrengthenLevel[i].Item.s.Name = '' then begin
        g_boItemMoving := True;
        g_MovingItem.Index2 := nItemIndex;
        g_MovingItem.Item := g_ItemArr[nItemIndex];
        g_MovingItem.ItemType := mtBagItem;
        DelItemBagByIdx(nItemIndex);
        ItemClickSound(g_ItemArr[nItemIndex].S);
        DArmStrengthenLevelGridSelect(DArmStrengthenLevel, 0, 0, I, 0, []);
        break;
      end;
    end;
  end else
  if (tm_MakeStone = Item.s.StdMode) and (Item.s.Shape in [1, 2]) then begin
    for I := 0 to 4 do begin
      if FStrengthenAss[i].Item.s.Name = '' then begin
        g_boItemMoving := True;
        g_MovingItem.Index2 := nItemIndex;
        g_MovingItem.Item := g_ItemArr[nItemIndex];
        g_MovingItem.ItemType := mtBagItem;
        DelItemBagByIdx(nItemIndex);
        ItemClickSound(g_ItemArr[nItemIndex].S);
        DArmStrengthenAssGridSelect(DArmStrengthenAss, 0, 0, I, 0, []);
        break;
      end;
    end;
  end;
end;

procedure TFrmDlg3.ChangeGuildDlg(DlgIndex: Integer);
begin
  case DlgIndex of
    0: begin
        DGuildLogDlg.Visible := True;
        DGuildInfoDlg.Visible := False;
        DGuildAllyDlg.Visible := False;
      end;
    1: begin
        DGuildLogDlg.Visible := False;
        DGuildInfoDlg.Visible := True;
        DGuildAllyDlg.Visible := False;
      end;
    2: begin
        DGuildLogDlg.Visible := False;
        DGuildInfoDlg.Visible := False;
        DGuildAllyDlg.Visible := True;
      end;
  end;
end;

procedure TFrmDlg3.ClearGuildMemberInfo;
var
  i: integer;
begin
  for I := 0 to GuildMemberList.Count - 1 do
    Dispose(pTGuildMemberInfo(GuildMemberList.Objects[i]));
  GuildMemberList.Clear;
  GuildMemberStrs.Clear;
  GuildOnLineMemberList.Clear;
end;

procedure TFrmDlg3.ClearGuildSocietyInfo;
var
  i: Integer;
begin
  for I := 0 to GuildWarList.Count - 1 do
    Dispose(pTGuildSocietyInfo(GuildWarList[i]));
  for I := 0 to GuildAllyList.Count - 1 do
    Dispose(pTGuildSocietyInfo(GuildAllyList[i]));
  GuildWarList.Clear;
  GuildAllyList.Clear;
end;

procedure TFrmDlg3.ClearItemShowList;
var
  i: integer;
begin
  for I := 0 to FItemShowAllList.Count - 1 do
    Dispose(pTSetupFiltrate(FItemShowAllList.Objects[I]));
  FItemShowAllList.Clear;
end;

procedure TFrmDlg3.ClearMakeItemInfo;
var
  i: integer;
begin
  FMakeItemLock := False;
  FMakeItemShowSchedule := False;
  FMakeItemSchedulePosition := 0;
  FMakeItemHint := '成功后得到物品';
  FMakeItemHint2 := '';
  FMakeItemRate := 0;
  FMakeItemShowEffect := False;
  FMakeItemShowTick := GetTickCount;
  SafeFillChar(FMakeItemUseItem, SizeOf(FMakeItemUseItem), #0);
  if FMakeItemItem.Item.s.Name <> '' then begin
    AddItemBag(FMakeItemItem.Item, FMakeItemItem.Index2);
  end;
  for I := Low(FMakeItemLevel) to High(FMakeItemLevel) do begin
    if FMakeItemLevel[I].Item.s.Name <> '' then
      AddItemBag(FMakeItemLevel[I].Item, FMakeItemLevel[I].Index2);
  end;
  for I := Low(FMakeItemAss) to High(FMakeItemAss) do begin
    if FMakeItemAss[I].Item.s.Name <> '' then
      AddItemBag(FMakeItemAss[I].Item, FMakeItemAss[I].Index2);
  end;
  SafeFillChar(FMakeItemItem, SizeOf(FMakeItemItem), #0);
  SafeFillChar(FMakeItemLevel, SizeOf(FMakeItemLevel), #0);
  SafeFillChar(FMakeItemAss, SizeOf(FMakeItemAss), #0);
  RefMakeItemRateInfo();
end;

procedure TFrmDlg3.ClearStrengthenInfo;
var
  i: integer;
begin
  FStrengthenLock := False;
  FStrengthenShowSchedule := False;
  FStrengthenSchedulePosition := 0;
  FStrengthenHint := '需要强化的装备';
  FStrengthenMoney := 0;
  FStrengthenMaxRate := 0;
  FStrengthenRate := 0;
  FStrengthenDownLevelRate := 0;
  FStrengthenBreakUpRate := 0;
  FStrengthenLevelType := 0;
  FStrengthenShowEffect := False;
  SafeFillChar(FStrengthenUseItem, SizeOf(FStrengthenUseItem), #0);
  if FStrengthenItem.Item.s.Name <> '' then begin
    AddItemBag(FStrengthenItem.Item, FStrengthenItem.Index2);
  end;
  for I := Low(FStrengthenLevel) to High(FStrengthenLevel) do begin
    if FStrengthenLevel[I].Item.s.Name <> '' then
      AddItemBag(FStrengthenLevel[I].Item, FStrengthenLevel[I].Index2);
  end;
  for I := Low(FStrengthenAss) to High(FStrengthenAss) do begin
    if FStrengthenAss[I].Item.s.Name <> '' then
      AddItemBag(FStrengthenAss[I].Item, FStrengthenAss[I].Index2);
  end;
  SafeFillChar(FStrengthenItem, SizeOf(FStrengthenItem), #0);
  SafeFillChar(FStrengthenLevel, SizeOf(FStrengthenLevel), #0);
  SafeFillChar(FStrengthenAss, SizeOf(FStrengthenAss), #0);
end;

procedure TFrmDlg3.RefMakeItemRateInfo;
var
  i: integer;
begin
  FMakeItemRate := 0;
  for I := Low(FMakeItemAss) to High(FMakeItemAss) do begin
    if (FMakeItemAss[I].Item.s.Name <> '') and (FMakeItemAss[I].Item.s.Shape = 2) then begin
      Inc(FMakeItemRate, FMakeItemAss[I].Item.s.Reserved);
    end;
  end;
  for I := Low(FMakeItemLevel) to High(FMakeItemLevel) do begin
    if (FMakeGoods.Item[i].s.Name <> '') and (FMakeGoods.Item[I].s.StdMode = tm_Ore) and (FMakeItemLevel[I].Item.s.Name = '') then begin
      FMakeItemRate := -1;
      break;
    end;
    if (FMakeItemLevel[I].Item.s.StdMode = tm_Ore) then begin
      if (FMakeItemLevel[I].Item.s.Name <> '') then begin
        Inc(FMakeItemRate, FMakeItemLevel[I].Item.UserItem.Dura div 1000);
      end;
    end;
  end;
  if FMakeMagicShow then begin
    Inc(FMakeItemRate, g_MakeMagic[FMakeMagicIdx] div g_btMakeMagicAddRate);
  end;
end;

procedure TFrmDlg3.RefStrengthenRateInfo;
var
  i: integer;
begin
  FStrengthenRate := 0;
  FStrengthenDownLevelRate := 0;
  FStrengthenBreakUpRate := 0;
  for I := Low(FStrengthenLevel) to High(FStrengthenLevel) do begin
    if FStrengthenLevel[I].Item.s.Name <> '' then begin
      Inc(FStrengthenRate, FStrengthenLevel[I].Item.s.Reserved);
      Inc(FStrengthenDownLevelRate, FStrengthenLevel[I].Item.s.AniCount);
      Inc(FStrengthenBreakUpRate, FStrengthenLevel[I].Item.s.Source);
    end;
  end;
  for I := Low(FStrengthenAss) to High(FStrengthenAss) do begin
    if FStrengthenAss[I].Item.s.Name <> '' then begin
      case FStrengthenAss[I].Item.s.Shape of
        1: FStrengthenBreakUpRate := 0;
        2: Inc(FStrengthenRate, FStrengthenAss[I].Item.s.Reserved);
      end;
    end;
  end;
  if FStrengthenRate > FStrengthenMaxRate then
    FStrengthenRate := FStrengthenMaxRate;
  if FStrengthenBreakUpRate > 100 then
    FStrengthenBreakUpRate := 100;
  if FStrengthenDownLevelRate > 100 then
    FStrengthenDownLevelRate := 100;

end;

procedure TFrmDlg3.SetButtonHight(Button: TDButton; nLeft: Integer);
var
  y: Integer;
begin
  with Button do begin
    Left := nLeft;
    if Button = DDGSMp3 then
      Y := 123
    else
      Y := 143;
    case nLeft of
      94..122: Inc(Y, 5);
      123..150: Inc(Y, 4);
      151..178: Inc(Y, 3);
      179..206: Inc(Y, 2);
      207..233: Inc(Y, 1);
    end;
    Top := Y;
  end;
end;

procedure TFrmDlg3.ShowMakeWindow(nIdx: Byte);
var
  i, ii: integer;
  PackMakeItem: pTPackMakeItem;
  sName, sItem: string;
  ClientMakeGoods: pTClientMakeGoods;
  DTreeNodes, DTreeNodes2: pTDTreeNodes;
  MakeItem: TMakeItem;
begin
  if nIdx in [Low(g_MakeMagicList)..High(g_MakeMagicList)] then begin
    DMakeItemTreeView.ClearItem;
    for II := 0 to g_MakeMagicList[nIdx].Count - 1 do begin
      PackMakeItem := g_MakeMagicList[nIdx][II];
      sName := PackMakeItem.sName;
      MakeItem := PackMakeItem.MakeItem;
      New(ClientMakeGoods);
      SafeFillChar(ClientMakeGoods^, SizeOf(TClientMakeGoods), #0);
      ClientMakeGoods.nID := MakeItem.wIdx;
      ClientMakeGoods.btLevel := PackMakeItem.btLevel;
      ClientMakeGoods.wLevel := PackMakeItem.wLevel;
      ClientMakeGoods.MakeItem := MakeItem;
      for I := 0 to 5 do begin
        ClientMakeGoods.Item[I].s := GetStditem(ClientMakeGoods.MakeItem.ItemArr[I].wIdent);
        ClientMakeGoods.Item[I].UserItem.wIndex := ClientMakeGoods.Item[I].s.Idx + 1;
        ClientMakeGoods.Item[I].UserItem.DuraMax := ClientMakeGoods.Item[I].s.DuraMax;
        //if ClientMakeGoods.MakeItem.ItemArr[I].wCount >  then
        if (sm_Superposition in ClientMakeGoods.Item[I].s.StdModeEx) and
          (ClientMakeGoods.Item[I].s.DuraMax > 1) then
          ClientMakeGoods.Item[I].UserItem.Dura := ClientMakeGoods.MakeItem.ItemArr[I].wCount
        else
          ClientMakeGoods.Item[I].UserItem.Dura := ClientMakeGoods.Item[I].s.DuraMax;
        if (I = 0) and (sm_ArmingStrong in ClientMakeGoods.Item[I].s.StdModeEx) then begin
          SetByteStatus(ClientMakeGoods.Item[I].UserItem.btBindMode2, Ib2_Unknown, True);
        end;

      end;
      DTreeNodes := nil;
      with FrmDlg3 do begin
        while True do begin
          if sName = '' then break;
          sName := GetValidStrCap(sName, sItem, [' ', #9]);
          if sItem = '' then break;
          if sItem[1] = '$' then begin
            DTreeNodes := DMakeItemTreeView.GetTreeNodes(DTreeNodes, Copy(sItem, 2, length(sItem) - 1), True);
          end
          else begin
            DTreeNodes2 := DMakeItemTreeView.NewTreeNodes(sitem);
            DTreeNodes2.Item := ClientMakeGoods;
            DTreeNodes.ItemList.Add(DTreeNodes2);
            ClientMakeGoods := nil;
            break;
          end;
        end;
      end;
      if ClientMakeGoods <> nil then
        Dispose(ClientMakeGoods);
    end;
    FMakeMagicShow := True;
    FMakeMagicIdx := nIdx;
    DMakeItemTreeView.RefHeight;
    DWndMakeItem.Visible := True;
  end;
end;

procedure TFrmDlg3.ShowMissionDlg(ClientMissionInfo: pTClientMissionInfo; sMsg: string);
var
  i: Integer;
begin
  if (ClientMissionInfo = nil) and (sMsg = '') then begin
    dwndMissionInfo.Surface.Clear;
    MDlgStr := '';
    exit;
  end;
  MDlgRefTime := 0;
  MDlgMove.rstr := '';
  MDlgSelect.rstr := '';
  if sMsg <> '' then MDlgStr := sMsg
  else MDlgStr := FormatShowText(ClientMissionInfo.ClientMission.sMissionHint, ClientMissionInfo);
  DUDwnMissionInfo.MaxPosition := 0;

  for i := 0 to MDlgPoints.count - 1 do
    Dispose(pTClickPoint(MDlgPoints[i]));
  for i := 0 to MDlgDraws.count - 1 do begin
    if pTNewShowHint(MDlgDraws[i]).IndexList <> nil then
      pTNewShowHint(MDlgDraws[i]).IndexList.Free;
    Dispose(pTNewShowHint(MDlgDraws[i]));
  end;

  MDlgPoints.Clear;
  MDlgDraws.Clear;
  dwndMissionInfo.Surface.Clear;

  MerchantHeight := DlgShowText(dwndMissionInfo.Surface, 0, 0, MDlgPoints, MDlgDraws, MDlgStr, MDLGMAXHEIGHT);
  if MerchantHeight > MerchantMaxHeight then begin
    DUDwnMissionInfo.MaxPosition := MerchantHeight - MerchantMaxHeight;
    DUDwnMissionInfo.Visible := True;
  end;
  MDlgChange := False;
end;

procedure TFrmDlg3.ClearStrengthenInfoEx;
begin
  FStrengthenMoney := 0;
  FStrengthenMaxRate := 0;
  FStrengthenRate := 0;
  FStrengthenDownLevelRate := 0;
  FStrengthenBreakUpRate := 0;
  SafeFillChar(FStrengthenUseItem, SizeOf(FStrengthenUseItem), #0);
  SafeFillChar(FStrengthenLevel, SizeOf(FStrengthenLevel), #0);
  SafeFillChar(FStrengthenAss, SizeOf(FStrengthenAss), #0);
end;

procedure TFrmDlg3.ClearUnSealInfo;
var
  i: integer;
begin
  FUnsealLock := False;
  FUnsealShowEffect := False;
  FUnsealShowTick := GetTickCount;
  FUnSealShowIndex := 0;
  if FUnsealItem.Item.s.Name <> '' then
    AddItemBag(FUnsealItem.Item, FUnsealItem.Index2);
  for I := Low(FUnsealLevel) to High(FUnsealLevel) do
    if FUnsealLevel[i].Item.s.Name <> '' then
      AddItemBag(FUnsealLevel[i].Item, FUnsealLevel[i].Index2);

  SafeFillChar(FUnsealItem, SizeOf(FUnsealItem), #0);
  SafeFillChar(FUnsealLevel, SizeOf(FUnsealLevel), #0);
end;

{
procedure TFrmDlg3.ClientMakeItemsList;
var
  i: integer;
begin
  for I := 0 to FMakeItemList.Count - 1 do
    Dispose(pTClientMakeGoods(FMakeItemList[i]));
  FMakeItemList.Clear;
  DMakeItemTreeView.ClearItem;
end;
        }

procedure TFrmDlg3.ClientMakeItems(nID, nCount: Integer; sMsg: string);
var
  i: Integer;
begin
  if FMakeitemShowSchedule then exit;
  FMakeitemLock := False;
  FMakeItemBackItem.Item.s.Name := '';
  case nID of
    2: FrmDlg.DMessageDlg('至少需要放置一块玄晶.', []);
    3: FrmDlg.DMessageDlg('当前装备不允许强化.', []);
    4: FrmDlg.DMessageDlg('未开光装备不允许强化.', []);
    5: FrmDlg.DMessageDlg('你身上的' + g_sGoldName + '或' + g_sBindGoldName + '不够支付.', []);
    6: FrmDlg.DMessageDlg('缺少打造物品所需要的材料.', []);
    7: FrmDlg.DMessageDlg('系统错误，无法完成打造.', []);
    12: FrmDlg.DMessageDlg('对不起，请至少在背包留有一个空格位置.', []);
    -8: begin
        FMakeItemLock := True;
        FMakeItemShowSchedule := True;
        FMakeItemSchedulePosition := 0;
        FMakeItemShowTick := GetTickCount;
        if sMsg = '' then begin
          FMakeItemShowEffect := False;
          for I := Low(FMakeItemLevel) to High(FMakeItemLevel) do begin
            if (FMakeItemLevel[I].Item.s.Name <> '') then begin
              if FMakeGoods.MakeItem.ItemArr[I].boNotGet then begin
                FMakeItemBackItem := FMakeItemLevel[I];
              end;
              if (sm_Superposition in FMakeItemLevel[I].Item.s.StdModeEx) and (FMakeItemLevel[I].Item.s.DuraMax > 1) and
                (FMakeItemLevel[I].Item.UserItem.Dura > (FMakeItemLevel[I].wCount * nCount)) then begin
                Dec(FMakeItemLevel[I].Item.UserItem.Dura, FMakeItemLevel[I].wCount * nCount);
              end else
                FMakeItemLevel[I].Item.s.Name := '';
            end;
          end;
          SafeFillChar(FMakeItemAss, SizeOf(FMakeItemAss), #0);
        end else begin
          FMakeItemShowEffect := True;
          FrmMain.DecodeItem(sMsg, @FMakeItemUseItem);
          for I := Low(FMakeItemLevel) to High(FMakeItemLevel) do begin
            if (FMakeItemLevel[I].Item.s.Name <> '') then begin
              if (sm_Superposition in FMakeItemLevel[I].Item.s.StdModeEx) and (FMakeItemLevel[I].Item.s.DuraMax > 1) and
                (FMakeItemLevel[I].Item.UserItem.Dura > (FMakeItemLevel[I].wCount * nCount)) then begin
                Dec(FMakeItemLevel[I].Item.UserItem.Dura, FMakeItemLevel[I].wCount * nCount);
              end else
                FMakeItemLevel[I].Item.s.Name := '';
            end;
          end;
          SafeFillChar(FMakeItemAss, SizeOf(FMakeItemAss), #0);
        end;
      end;
    8: begin //升级成功
        FMakeItemLock := True;
        FMakeItemShowSchedule := True;
        FMakeItemShowEffect := True;
        FMakeItemSchedulePosition := 0;
        FrmMain.DecodeItem(sMsg, @FMakeItemUseItem);
        FMakeItemShowTick := GetTickCount;
        for I := Low(FMakeItemLevel) to High(FMakeItemLevel) do begin
          if (FMakeItemLevel[I].Item.s.Name <> '') then begin
            if (sm_Superposition in FMakeItemLevel[I].Item.s.StdModeEx) and (FMakeItemLevel[I].Item.s.DuraMax > 1) and
              (FMakeItemLevel[I].Item.UserItem.Dura > FMakeItemLevel[I].wCount) then begin
              Dec(FMakeItemLevel[I].Item.UserItem.Dura, FMakeItemLevel[I].wCount);
            end else
              FMakeItemLevel[I].Item.s.Name := '';
          end;
        end;
        //SafeFillChar(FMakeItemLevel, SizeOf(FMakeItemLevel), #0);
        SafeFillChar(FMakeItemAss, SizeOf(FMakeItemAss), #0);
      end;
    9: begin //升级破碎

      end;
    10: begin //升级降级

      end;
    11: begin //装备无变化
        FMakeItemLock := True;
        FMakeItemShowSchedule := True;
        FMakeItemShowEffect := False;
        FMakeItemSchedulePosition := 0;
        //FrmMain.DecodeItem(sMsg, @FMakeItemUseItem);
        FMakeItemShowTick := GetTickCount;
        for I := Low(FMakeItemLevel) to High(FMakeItemLevel) do begin
          if (FMakeItemLevel[I].Item.s.Name <> '') then begin
            if FMakeGoods.MakeItem.ItemArr[I].boNotGet then begin
              FMakeItemBackItem := FMakeItemLevel[I];
            end;
            if (sm_Superposition in FMakeItemLevel[I].Item.s.StdModeEx) and (FMakeItemLevel[I].Item.s.DuraMax > 1) and
              (FMakeItemLevel[I].Item.UserItem.Dura > FMakeItemLevel[I].wCount) then begin
              Dec(FMakeItemLevel[I].Item.UserItem.Dura, FMakeItemLevel[I].wCount);
            end else
              FMakeItemLevel[I].Item.s.Name := '';
          end;
        end;
        //SafeFillChar(FMakeItemLevel, SizeOf(FMakeItemLevel), #0);
        SafeFillChar(FMakeItemAss, SizeOf(FMakeItemAss), #0);
      end;
  end;
end;

procedure TFrmDlg3.ClientStrengthenItems(nID: Integer; sMsg: string);
begin
  if FStrengthenShowSchedule then
    exit;
  FStrengthenLock := False;
  case nID of
    2: FrmDlg.DMessageDlg('至少需要放置一块玄晶.', []);
    3: FrmDlg.DMessageDlg('当前装备不允许强化.', []);
    4: FrmDlg.DMessageDlg('未开光装备不允许强化.', []);
    5: FrmDlg.DMessageDlg('你身上的' + g_sGoldName + '或' + g_sBindGoldName + '不够支付.', []);
    6: FrmDlg.DMessageDlg('至少需要放置一块玄晶.', []);
    8: begin //升级成功
        FStrengthenLock := True;
        FStrengthenShowSchedule := True;
        FStrengthenShowEffect := False;
        FStrengthenShowEffectType := 0;
        FStrengthenSchedulePosition := 0;
        FStrengthenLevelType := 1;
        FrmMain.DecodeItem(sMsg, @FStrengthenUseItem);
        FStrengthenShowTick := GetTickCount;
        SafeFillChar(FStrengthenLevel, SizeOf(FStrengthenLevel), #0);
        SafeFillChar(FStrengthenAss, SizeOf(FStrengthenAss), #0);
      end;
    9: begin //升级破碎
        FStrengthenLock := True;
        FStrengthenShowSchedule := True;
        FStrengthenShowEffect := False;
        FStrengthenShowEffectType := 0;
        FStrengthenSchedulePosition := 0;
        FStrengthenLevelType := 2;
        FStrengthenShowTick := GetTickCount;
        SafeFillChar(FStrengthenLevel, SizeOf(FStrengthenLevel), #0);
        SafeFillChar(FStrengthenAss, SizeOf(FStrengthenAss), #0);
      end;
    10: begin //升级降级
        FStrengthenLock := True;
        FStrengthenShowSchedule := True;
        FStrengthenShowEffect := False;
        FStrengthenShowEffectType := 0;
        FStrengthenSchedulePosition := 0;
        FStrengthenLevelType := 3;
        FrmMain.DecodeItem(sMsg, @FStrengthenUseItem);
        FStrengthenShowTick := GetTickCount;
        SafeFillChar(FStrengthenLevel, SizeOf(FStrengthenLevel), #0);
        SafeFillChar(FStrengthenAss, SizeOf(FStrengthenAss), #0);
      end;
    11: begin //装备无变化
        FStrengthenLock := True;
        FStrengthenShowSchedule := True;
        FStrengthenShowEffect := False;
        FStrengthenShowEffectType := 0;
        FStrengthenSchedulePosition := 0;
        FStrengthenLevelType := 4;
        FStrengthenShowTick := GetTickCount;
        SafeFillChar(FStrengthenLevel, SizeOf(FStrengthenLevel), #0);
        SafeFillChar(FStrengthenAss, SizeOf(FStrengthenAss), #0);
      end;
  end;
end;

procedure TFrmDlg3.ClientUnSealItems(nID: Integer; sMsg: string);
begin
  { FUnsealItem: TMovingItem;
     FUnsealLevel: array[0..7] of TMovingItem;
     FUnsealLock: Boolean;
     FUnsealShowEffect: Boolean;
     FUnsealShowIndex: Integer;
     FUnSealShowTick: LongWord;}
  if FUnsealShowEffect then
    exit;
  FUnsealLock := False;
  case nID of
    8: begin //升级成功
        FUnsealLock := True;
        FUnsealShowEffect := True;
        FUnsealShowIndex := 0;
        FUnSealShowTick := GetTickCount;
        FrmMain.DecodeItem(sMsg, @FUnsealItem.Item.UserItem);
        SafeFillChar(FUnsealLevel, SizeOf(FUnsealLevel), #0);
        PlaySoundEx(bmp_warpower_up);
      end;
  else begin
      FrmDlg.DMessageDlg('当前装备不需要再次开光.', []);
    end;
  end;
end;

procedure TFrmDlg3.DArmClose2ClickSound(Sender: TObject; Clicksound: TClickSound);
begin
  case Clicksound of
    csNorm: PlaySound(s_norm_button_click);
    csStone: PlaySound(s_rock_button_click);
    csGlass: PlaySound(s_glass_button_click);
  end;
end;

procedure TFrmDlg3.DArmClose2DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
{$IF Var_Interface = Var_Default}
  idx: integer;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end;
    end;
  end;
{$ELSE}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if Downed then begin
        inc(idx, 2)
      end
      else if MouseEntry = msIn then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
{$IFEND}
end;

procedure TFrmDlg3.DArmCloseClick(Sender: TObject; X, Y: Integer);
begin
  if FStrengthenLock then
    exit;
  DWndArmStrengthen.Visible := False;
end;

procedure TFrmDlg3.DArmItemClick(Sender: TObject; X, Y: Integer);
begin
  if FStrengthenLock then
    exit;
  if not g_boItemMoving then begin
    ClearStrengthenInfo;
  end
  else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
    if sm_ArmingStrong in g_MovingItem.Item.s.StdModeEx then begin
      if (not CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoMake)) and
        (g_MovingItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount <
        g_MovingItem.Item.UserItem.Value.StrengthenInfo.btCanStrengthenCount) then begin
        if not CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_Unknown) then begin
          ClearStrengthenInfo;
          FStrengthenItem := g_MovingItem;
          FStrengthenMoney := GetStrengthenMoney(g_MovingItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
          FStrengthenMaxRate := GetStrengthenMaxRate(g_MovingItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
          g_boItemMoving := False;
          g_MovingItem.Item.s.Name := '';
        end
        else begin
          FrmDlg.CancelItemMoving;
          FrmDlg.DMessageDlg('未开光装备不允许进行强化.', []);
        end;
      end
      else begin
        FrmDlg.CancelItemMoving;
        FrmDlg.DMessageDlg('该装备不可以进行强化.', []);
      end;
    end
    else begin
      FrmDlg.CancelItemMoving;
    end;
  end;
end;

procedure TFrmDlg3.DArmItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  //  boDraw: Boolean;
  pRect: TRect;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if FStrengthenItem.Item.s.Name <> '' then begin
      d := GetBagItemImg(FStrengthenItem.Item.S.looks);
      pRect.Left := ax;
      pRect.Top := ay;
      pRect.Right := ax + Width + 1;
      pRect.Bottom := ay + Height;
      if d <> nil then
        FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
          ax + (Width - d.Width) div 2,
          ay + (Height - d.Height) div 2,
          Width,
          Height,
          @FStrengthenItem.Item, False, [pmShowLevel], @pRect);
    end
    else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
      if (sm_ArmingStrong in g_MovingItem.Item.s.StdModeEx) then begin
        d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
        if d <> nil then
          DrawEffect(dsurface, SurfaceX(Left) - 12, SurfaceY(Top) - 11, d, ceGrayScale, True)
          //DrawBlend(dsurface, SurfaceX(Left) - 12, SurfaceY(Top) - 11, d, 1);
      end;
    end;
  end;
end;

procedure TFrmDlg3.DArmItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
begin
  with Sender as TDButton do begin
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX + 30;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    if FStrengthenItem.Item.s.Name <> '' then
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(FStrengthenItem.Item, [mis_ArmStrengthen], []),
        clwhite, False, Tag, True);
  end;
end;

procedure TFrmDlg3.DArmOKClick(Sender: TObject; X, Y: Integer);
var
  StrengthenItem: TStrengthenItem;
  i: Integer;
  boOne: Boolean;
begin
  if FStrengthenLock then
    exit;
  if FStrengthenRate > 0 then begin
    SafeFillChar(StrengthenItem, SizeOf(StrengthenItem), #0);
    boOne := False;
    for I := 0 to 4 do begin
      if FStrengthenLevel[I].Item.s.name <> '' then begin
        StrengthenItem.nLevelIdx[I] := FStrengthenLevel[I].Item.UserItem.MakeIndex;
        boOne := True;
      end;
    end;
    if not boOne then begin
      FrmDlg.DMessageDlg('至少需要放置一块玄晶.', []);
      exit;
    end;
    for I := 0 to 4 do begin
      if FStrengthenAss[I].Item.s.name <> '' then
        StrengthenItem.nAssIdx[I] := FStrengthenAss[I].Item.UserItem.MakeIndex;
    end;
    FStrengthenLock := True;
    FrmMain.SendClientSocket(CM_ITEMSTRENGTHEN, g_nCurMerchant,
      LoWord(FStrengthenItem.Item.UserItem.MakeIndex),
      HiWord(FStrengthenItem.Item.UserItem.MakeIndex), 0,
      EncodeBuffer(@StrengthenItem, SizeOf(StrengthenItem)));
  end
  else begin
    FrmDlg.DMessageDlg('至少需要放置一块玄晶.', []);
  end;
end;

procedure TFrmDlg3.DArmOKDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: Integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top); 
    if Downed then begin
      d := WLib.Images[FaceIndex + 1];
      Inc(ax);
      Inc(ay);
    end
    else
      d := WLib.Images[FaceIndex];
      
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

    with g_DXCanvas do begin
      TextOut(ax + (Width - TextWidth(Caption)) div 2, ay + (Height - TextHeight(Caption)) div 2 + 1, DFColor, Caption);
    end;
  end;
end;

procedure TFrmDlg3.DArmStrengthenAssGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FStrengthenAss)..High(FStrengthenAss)] then begin
      if FStrengthenAss[idx].Item.S.name <> '' then begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(FStrengthenAss[idx].Item, [mis_ArmStrengthen], []), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg3.DArmStrengthenAssGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FStrengthenAss)..High(FStrengthenAss)] then begin
      if FStrengthenAss[idx].Item.S.name <> '' then begin
        d := GetBagItemImg(FStrengthenAss[idx].Item.S.looks);
        if d <> nil then begin
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @FStrengthenAss[idx].Item);
        end;
      end
      else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
        if (tm_MakeStone = g_MovingItem.Item.s.StdMode) and (g_MovingItem.Item.s.Shape in [1, 2]) then begin
          d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
          if d <> nil then
            DrawEffect(dsurface, SurfaceX(Rect.Left) - 11, SurfaceY(Rect.Top) - 11, d, ceGrayScale, True)
            //DrawBlend(dsurface, SurfaceX(Rect.Left) - 11, SurfaceY(Rect.Top) - 11, d, 1);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DArmStrengthenAssGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  if FStrengthenLock then
    exit;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FStrengthenAss)..High(FStrengthenAss)] then begin
      if not g_boItemMoving then begin
        if FStrengthenAss[idx].Item.s.Name <> '' then begin
          AddItemBag(FStrengthenAss[idx].Item, FStrengthenAss[idx].Index2);
          SafeFillChar(FStrengthenAss[idx], SizeOf(FStrengthenAss[idx]), #0);
          RefStrengthenRateInfo();
        end;
      end
      else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
        if FStrengthenItem.Item.s.Name = '' then begin
          FrmDlg.CancelItemMoving;
          FrmDlg.DMessageDlg('请先放上要强化的装备.', []);
          exit;
        end;
        if (tm_MakeStone = g_MovingItem.Item.s.StdMode) and (g_MovingItem.Item.s.Shape in [1, 2]) then begin
          if FStrengthenAss[idx].Item.s.Name <> '' then begin
            AddItemBag(FStrengthenAss[idx].Item, FStrengthenAss[idx].Index2);
          end;
          FStrengthenAss[idx] := g_MovingItem;
          g_boItemMoving := False;
          g_MovingItem.Item.s.Name := '';
          RefStrengthenRateInfo();
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DArmStrengthenLevelGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FStrengthenLevel)..High(FStrengthenLevel)] then begin
      if FStrengthenLevel[idx].Item.S.name <> '' then begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(FStrengthenLevel[idx].Item, [mis_ArmStrengthen], []), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg3.DArmStrengthenLevelGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FStrengthenLevel)..High(FStrengthenLevel)] then begin
      if FStrengthenLevel[idx].Item.S.name <> '' then begin
        d := GetBagItemImg(FStrengthenLevel[idx].Item.S.looks);
        if d <> nil then begin
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @FStrengthenLevel[idx].Item);
        end;
      end
      else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
        if (tm_MakeStone = g_MovingItem.Item.s.StdMode) and (g_MovingItem.Item.s.Shape = 0) then begin
          d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
          if d <> nil then
            DrawEffect(dsurface, SurfaceX(Rect.Left) - 11, SurfaceY(Rect.Top) - 11, d, ceGrayScale, True);
            //DrawBlend(dsurface, SurfaceX(Rect.Left) - 11, SurfaceY(Rect.Top) - 11, d, 1);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DArmStrengthenLevelGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  if FStrengthenLock then
    exit;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FStrengthenLevel)..High(FStrengthenLevel)] then begin
      if not g_boItemMoving then begin
        if FStrengthenLevel[idx].Item.s.Name <> '' then begin
          AddItemBag(FStrengthenLevel[idx].Item, FStrengthenLevel[idx].Index2);
          SafeFillChar(FStrengthenLevel[idx], SizeOf(FStrengthenLevel[idx]), #0);
          RefStrengthenRateInfo();
        end;
      end
      else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
        if FStrengthenItem.Item.s.Name = '' then begin
          FrmDlg.CancelItemMoving;
          FrmDlg.DMessageDlg('请先放上要强化的装备.', []);
          exit;
        end;
        if (tm_MakeStone = g_MovingItem.Item.s.StdMode) and (g_MovingItem.Item.s.Shape = 0) then begin
          if not CheckItemArmStrengthenLevel(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount,
            g_MovingItem.Item.s.Need, g_MovingItem.Item.s.NeedLevel) then begin
            FrmDlg.CancelItemMoving;
            FrmDlg.DMessageDlg('不适用于强化当前装备.', []);
            exit;
          end;
          if FStrengthenLevel[idx].Item.s.Name <> '' then begin
            AddItemBag(FStrengthenLevel[idx].Item, FStrengthenLevel[idx].Index2);
          end;
          FStrengthenLevel[idx] := g_MovingItem;
          g_boItemMoving := False;
          g_MovingItem.Item.s.Name := '';
          RefStrengthenRateInfo();
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.dbtnBoxGetItemClick(Sender: TObject; X, Y: Integer);
begin
  if OpenGetItem or OpenBoxMove then exit;
  if dbtnBoxGetItem.Caption = '关闭轮盘' then begin
    if (OpenBoxIndex < 4) and (g_MySelf.m_nGold >= OpenBoxGold) and (g_MySelf.m_nGameGold >= OpenBoxGameGold) then begin
      if mrYes <> FrmDlg.DMessageDlg('您还有' + IntToStr(4 - OpenBoxIndex) + '次转动轮盘的机会，有机会获得更高级物品！\是否确定放弃这次机会？', [mbYes, mbNo]) then begin
        exit;
      end;
    end;
    dwndBox.Visible := False;
  end else begin
    if (OpenBoxIndex = 0) and (g_MySelf.m_nGold >= OpenBoxGold) and (g_MySelf.m_nGameGold >= OpenBoxGameGold)  then begin
      if mrYes <> FrmDlg.DMessageDlg('您还有4次转动轮盘的机会，有机会获得更高级物品！\是否确定领取目前奖励？', [mbYes, mbNo]) then begin
        exit;
      end;
    end;
    dbtnBoxGetItem.Enabled := False;
    OpenGetItem := True;
    OpenBoxShowEffect := False;
    FrmMain.SendClientMessage(CM_OPENBOX, 2, 0, 0, 0, '');
  end;
end;

procedure TFrmDlg3.dbtnBoxItem0DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  //rc: TRect;
  nCount: Integer;
  sStr: string;
begin
  with Sender as TDControl do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if Tag in [Low(OpenBoxItems)..High(OpenBoxItems)] then begin
      nCount := 0;
      case OpenBoxItems[Tag].ItemType of
        bit_Item: begin
            if OpenBoxItems[Tag].Item.S.Name <> '' then begin
              d := GetBagItemImg(OpenBoxItems[Tag].Item.S.looks);
              if d <> nil then begin
                FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
                  ax + (Width - d.Width) div 2,
                  ay + (Height - d.Height) div 2,
                  ax + Width,
                  ay + Height - 12,
                  @OpenBoxItems[Tag].Item, True);
              end;
            end;
          end;
        bit_Exp: begin
            d := g_WMain99Images.Images[673];
            if d <> nil then begin
              DSurface.Draw(ax + (Width - d.Width) div 2, ay + (Height - d.Height) div 2, d.ClientRect, d, False);
            end;
            nCount := OpenBoxItems[Tag].Item.UserItem.MakeIndex;
          end;
        bit_Gold, bit_BindGold: begin
            d := g_WMain99Images.Images[674];
            if d <> nil then begin
              DSurface.Draw(ax + (Width - d.Width) div 2, ay + (Height - d.Height) div 2, d.ClientRect, d, False);
            end;
            nCount := OpenBoxItems[Tag].Item.UserItem.MakeIndex;
          end;
        bit_GameGold: begin
            d := g_WMain99Images.Images[678];
            if d <> nil then begin
              DSurface.Draw(ax + (Width - d.Width) div 2, ay + (Height - d.Height) div 2, d.ClientRect, d, False);
            end;
            nCount := OpenBoxItems[Tag].Item.UserItem.MakeIndex;
          end;
      end;
      if nCount > 0 then begin
        if nCount > 9999 then begin
          sStr := IntToStr(nCount div 10000) + 'W';
          if nCount mod 10000 <> 0 then sStr := sStr + '+';
        end
        else sStr := IntToStr(nCount);
        with g_DXCanvas do begin
          TextOut(ax + Width - TextWidth(sStr), ay + (Height - 12), clWhite, sStr);
        end;
      end;
      if OpenBoxShowEffect and OpenGetItem then begin
        if OpenBoxEffectIdx < 10 then begin
          if (OpenBoxIndex + 8) = Tag then begin
            d := g_WMain99Images.Images[1990 + OpenBoxEffectIdx];
            if d <> nil then begin
              DSurface.Draw(ax - 23, ay - 24, d.ClientRect, d, fxAnti);
            end;
          end;
        end else begin
          if OpenGetItemIndex = Tag then begin
            d := g_WMain99Images.Images[1990 + OpenBoxEffectIdx];
            if d <> nil then begin
              DSurface.Draw(ax - 23, ay - 24, d.ClientRect, d, fxAnti);
            end;
          end;
        end;
      end else
      if (OpenBoxItems[Tag].ItemType <> bit_None) and (OpenBoxSelectIndex = Tag) then begin
        if ((GetTickCount - dwndBox.AppendTick) mod 300 > 150) and (not OpenBoxMove) then
          d := g_WMain99Images.Images[2113 + Tag * 2]
        else d := g_WMain99Images.Images[2112 + Tag * 2];
        if d <> nil then begin
          DSurface.Draw(ax - 13, ay - 14, d.ClientRect, d, fxAnti);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.dbtnBoxItem11MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
begin
  with Sender as TDButton do begin
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    if Tag in [Low(OpenBoxItems)..High(OpenBoxItems)] then begin
      case OpenBoxItems[Tag].ItemType of
        bit_Item: begin
            if OpenBoxItems[Tag].Item.S.Name <> '' then begin
              DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(OpenBoxItems[Tag].Item, [], []),
                clwhite, False, Tag, True);
            end;
          end;
        bit_Exp: begin
            DScreen.ShowHint(nHintX, nHintY, '经验值：' + IntToStr(OpenBoxItems[Tag].Item.UserItem.MakeIndex),
              clwhite, False, Tag);
          end;
        bit_Gold: begin
            DScreen.ShowHint(nHintX, nHintY, '金币：' + IntToStr(OpenBoxItems[Tag].Item.UserItem.MakeIndex),
              clwhite, False, Tag);
          end;
        bit_BindGold: begin
            DScreen.ShowHint(nHintX, nHintY, '绑定金币：' + IntToStr(OpenBoxItems[Tag].Item.UserItem.MakeIndex),
              clwhite, False, Tag);
          end;
        bit_GameGold: begin
            DScreen.ShowHint(nHintX, nHintY, g_sGameGoldName + '：' + IntToStr(OpenBoxItems[Tag].Item.UserItem.MakeIndex),
              clwhite, False, Tag);
          end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.OpenBox(nIndex, nSelectIndex: Integer);
begin
  dbtnBoxNext.Caption := '停止';
  OpenBoxMove := True;
  OpenBoxStop := False;
  OpenCanStop := False;
  OpenBoxIndex := nIndex;
  OpenBoxMoveTick := GetTickCount;
  OpenBoxMoveIndex := 0;
  OpenGetItemIndex := nSelectIndex;
  case OpenGetItemIndex of
    1: OpenStopIndex := 5;
    2: OpenStopIndex := 6;
    3: OpenStopIndex := 7;
    4: OpenStopIndex := 8;
    5: OpenStopIndex := 1;
    6: OpenStopIndex := 2;
    7: OpenStopIndex := 3;
    8: OpenStopIndex := 4;
  end;
end;

procedure TFrmDlg3.dbtnBoxNextClick(Sender: TObject; X, Y: Integer);
var
  sMsg: string;
  boNotGold: Boolean;
begin
  if not OpenBoxMove then begin
    if not OpenBoxStop then begin
      boNotGold := False;
      if (OpenBoxGold > 0) or (OpenBoxGameGold > 0) then begin
        sMsg := '启动轮盘需要支付以下几种费用，请确认是否支付？\';
        if (OpenBoxGold > 0) then begin
          sMsg := sMsg + g_sGoldName + '：' + IntToStr(OpenBoxGold);
          if g_MySelf.m_nGold >= OpenBoxGold then sMsg := sMsg + '\'
          else begin
            sMsg := sMsg + ' （您身上的' + g_sGoldName + '不足）\';
            boNotGold := True;
          end;
        end;
        if (OpenBoxGameGold > 0) then begin
          sMsg := sMsg + g_sGameGoldName + '：' + IntToStr(OpenBoxGameGold);
          if g_MySelf.m_nGameGold >= OpenBoxGold then sMsg := sMsg + '\'
          else begin
            sMsg := sMsg + ' （您身上的' + g_sGameGoldName + '不足）\';
            boNotGold := True;
          end;
        end;
        if boNotGold then begin
          FrmDlg.DMessageDlg(sMsg, []);
          exit;
        end else begin
          if mrYes <> FrmDlg.DMessageDlg(sMsg, [mbYes, mbNo]) then begin
            exit;
          end;
        end;
      end;
      OpenBoxStop := True;
      FrmMain.SendClientMessage(CM_OPENBOX, 1, 0, 0, 0, '');
    end;
  end else begin
    if not OpenBoxStop then begin
      dbtnBoxNext.Caption := '正在停止';
      OpenBoxStop := True;
      OpenCanStop := False;
    end;
  end;
end;

procedure TFrmDlg3.dbtnMissionAcceptClick(Sender: TObject; X, Y: Integer);
begin
  ShowCanAccept := True;
  MDlgChange := False;
  DTrvwMission.Select := nil;
  ShowMissionDlg(nil, GetCanMissionAccept);
end;

procedure TFrmDlg3.dbtnMissionLogoutClick(Sender: TObject; X, Y: Integer);
var
  ClientMissionInfo: pTClientMissionInfo;
begin
  if (GetTickCount - FMissionLogoutTick) < 2000 then exit;
  if DTrvwMission.Select <> nil then begin
    ClientMissionInfo := pTClientMissionInfo(DTrvwMission.Select.Item);
    if ClientMissionInfo <> nil then begin
      if ClientMissionInfo.ClientMission.wLogoutIdx > 0 then begin
        if mrYes = FrmDlg.DMessageDlg('是否确定注销任务[' + ClientMissionInfo.ClientMission.sMissionShowName + ']?', [mbYes, mbNo]) then begin
          FrmMain.SendClientMessage(CM_CLEARMISSION, ClientMissionInfo.ClientMission.wLogoutIdx, 0, 0, 0, '');
          FMissionLogoutTick := GetTickCount;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.dbtnMissionTrackClick(Sender: TObject; X, Y: Integer);
begin
  if (DTrvwMission.Select <> nil) and (DTrvwMission.Select.Item <> nil) then begin
    pTClientMissionInfo(DTrvwMission.Select.Item).MissionInfo.boTrack := not
      pTClientMissionInfo(DTrvwMission.Select.Item).MissionInfo.boTrack;
    FrmMain.SendClientMessage(CM_MISSIONSTATECHANGE, pTClientMissionInfo(DTrvwMission.Select.Item).MissionIdx, Integer(pTClientMissionInfo(DTrvwMission.Select.Item).MissionInfo.boTrack), 0, 0, '');
    FrmDlg2.m_boShowMissionChange := True;
  end;
end;

procedure TFrmDlg3.dbtnMissionTrackDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: Integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top); 
    if Downed then begin
      d := WLib.Images[FaceIndex + 1];
      Inc(ax);
      Inc(ay);
    end
    else
      d := WLib.Images[FaceIndex];
      
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

    with g_DXCanvas do begin
      TextOut(ax + (Width - TextWidth(Caption)) div 2, ay + (Height - TextHeight(Caption)) div 2 + 1, DFColor, Caption);
    end;
  end;
end;

procedure TFrmDlg3.dbtnMissionTrackMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left);
    y := SurfaceY(Top + (y - Top) + 30);
    ShowMsg := '';
    if Sender = dbtnMissionTrack then begin
      ShowMsg := '是否在屏幕右边显示任务未完成信息';
    end;
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, False, Integer(Sender));
  end;
end;

procedure TFrmDlg3.dchkShowNameAllChange(Sender: TObject);
begin
  if dchkShowNameAll.Checked then
    DDFShowName.Checked := True;
end;

procedure TFrmDlg3.DDGSMp3DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dsurface.Draw(ax, ay, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg3.DDGSMp3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if (not Downed) then exit;
    Dec(X, 9);
    if X < 94 then
      X := 94;
    if X > 234 then
      X := 234;
    SetButtonHight(TDButton(Sender), X);
  end;
end;

procedure TFrmDlg3.DDGSSetupDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay, nY: Integer;
  rc: TRect;
  d, dd: TDXTexture;
  I: Integer;
  SetupFiltrate: pTSetupFiltrate;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    with g_DXCanvas do begin
      if Sender = DDGSSetup then begin
        d := g_WMain99Images.Images[351];
        if d <> nil then begin
          rc := d.ClientRect;
          rc.Right := DDGSMp3.Left - 94 + 4;
          dsurface.Draw(ax + 98, ay + 124, rc, d, True);

          rc := d.ClientRect;
          rc.Right := DDGSMusic.Left - 94 + 4;
          dsurface.Draw(ax + 98, ay + 144, rc, d, True);
        end;

        TextOut(ax + 22, ay + 18, clYellow, '视频设置');
        TextOut(ax + 258, ay + 18, clYellow, '视频选项');
        TextOut(ax + 22, ay + 108, clYellow, '音量设置');
        TextOut(ax + 258, ay + 108, clYellow, '音频选项');

        TextOut(ax + 34, ay + 40, $C0C0C0, '显示器：');
        TextOut(ax + 34, ay + 60, $C0C0C0, '分辨率：');
        TextOut(ax + 34, ay + 80, $C0C0C0, '色  深：');

        if g_FScreenMode <> DDGSXY.ItemIndex then
          TextOut(ax + 134, ay + 80, $0000FF, '需要重新进入游戏后生效');

        TextOut(ax + 34, ay + 130, $C0C0C0, '背景音乐：');
        TextOut(ax + 34, ay + 150, $C0C0C0, '游戏音效：');
      end else
      if Sender = DDFunction then begin
        TextOut(ax + 22, ay + 18, clYellow, '基本设置');
        TextOut(ax + 166, ay + 18, clYellow, '游戏选项');
        TextOut(ax + 294, ay + 18, clYellow, '优化选项');
      end else
      if Sender = DDGProtect then begin
        TextOut(ax + 22, ay + 18, clYellow, '保护设置');

        TextOut(ax + 127, ay + 46, clSilver, 'HP');
        TextOut(ax + 127, ay + 70, clSilver, 'MP');
        TextOut(ax + 127, ay + 94, clSilver, 'HP');
        TextOut(ax + 127, ay + 118, clSilver, 'MP');
        TextOut(ax + 127, ay + 142, clSilver, 'HP');
        TextOut(ax + 235, ay + 46, clSilver, '秒');
        TextOut(ax + 235, ay + 70, clSilver, '秒');
        TextOut(ax + 235, ay + 94, clSilver, '秒');
        TextOut(ax + 235, ay + 118, clSilver, '秒');
        TextOut(ax + 235, ay + 142, clSilver, '秒    卷轴类型');
      end else
      if Sender = DDItems then begin
        TextOut(ax + 22, ay + 8, clYellow, '物品名称');
        TextOut(ax + 184, ay + 8, clYellow, '特殊显示');
        TextOut(ax + 260, ay + 8, clYellow, '自动捡取');
        TextOut(ax + 336, ay + 8, clYellow, '显示名称');

        TextOut(ax + DDitemFind.Left + 3, ay + DDitemFind.Top + 2, $808080, '[输入物品关键字查找]');
        d := g_WMain99Images.Images[151];
        dd := g_WMain99Images.Images[152];
        for I := DDItemUpDown.Position to DDItemUpDown.Position + 6 do begin
          if I >= FItemShowList.Count then break;
          SetupFiltrate := pTSetupFiltrate(FItemShowList.Objects[I]);
          nY := (I - DDItemUpDown.Position) * 16;
          if i = FItemMoveIndex then begin
            FillRect(ax + 21, ay + ny + 30, 364, 16, $A062625A);
          end;
          TextOut(ax + 22, ay + ny + 32, clSilver, FItemShowList[I]);
          if (d <> nil) and (dd <> nil) then begin
            if SetupFiltrate.boColor then DSurface.Draw(ax + 200, ay + ny + 30, dd.ClientRect, dd, True)
            else DSurface.Draw(ax + 200, ay + ny + 30, d.ClientRect, d, True);

            if SetupFiltrate.boPickUp then DSurface.Draw(ax + 275, ay + ny + 30, dd.ClientRect, dd, True)
            else DSurface.Draw(ax + 275, ay + ny + 30, d.ClientRect, d, True);

            if SetupFiltrate.boShow then DSurface.Draw(ax + 352, ay + ny + 30, dd.ClientRect, dd, True)
            else DSurface.Draw(ax + 352, ay + ny + 30, d.ClientRect, d, True);
          end;
        end;
        MoveTo(ax + 21, ay + 26);
        LineTo(ax + 384, ay + 26, $525552);
        MoveTo(ax + 21, ay + 144);
        LineTo(ax + 384, ay + 144, $525552);
      end else
      if Sender = DDMagic then begin
        TextOut(ax + 22, ay + 18, clYellow, '战士技能');
        TextOut(ax + 166, ay + 18, clYellow, '法师技能');
        TextOut(ax + 294, ay + 18, clYellow, '道士技能');
        TextOut(ax + 22, ay + 132, clYellow, '自动练功');
        TextOut(ax + 138, ay + 154, clSilver, '秒');
        TextOut(ax + 294, ay + 132, clYellow, '挂机技能');
      end else
      if Sender = dwndSaySetup then begin
        TextOut(ax + 22, ay + 18, clYellow, '过滤设置');
        //TextOut(ax + 166, ay + 18, clYellow, '游戏选项');
        //TextOut(ax + 294, ay + 18, clYellow, '优化选项');
      end;
    end;
  end;
end;

procedure TFrmDlg3.DDitemFindChange(Sender: TObject);
var
  sStr: string;
  I: Integer;
begin
  sStr := Trim(DDitemFind.Text);
  if sStr = '' then begin
    DDItemsClassChange(DDItemsClass);
  end else begin
    DDItemsClass.ItemIndex := 0;
    FItemShowList.Clear;
    for I := 0 to FItemShowAllList.Count - 1 do begin
      if AnsiContainsText(FItemShowAllList[I], sStr) then begin
        FItemShowList.AddObject(FItemShowAllList[I], FItemShowAllList.Objects[I]);
      end;
    end;
    DDItemUpDown.MaxPosition := FItemShowList.Count - 7;
    DDItemUpDown.Position := 0;
  end;
end;

procedure TFrmDlg3.DDItemsClassChange(Sender: TObject);
var
  SetupFiltrate: pTSetupFiltrate;
  I: Integer;
begin
  if Trim(DDitemFind.Text) <> '' then begin
    DDitemFindChange(DDitemFind);
    exit;
  end;
  FItemShowList.Clear;
  for I := 0 to FItemShowAllList.Count - 1 do begin
    SetupFiltrate := pTSetupFiltrate(FItemShowAllList.Objects[I]);
    case DDItemsClass.ItemIndex of
      1: if SetupFiltrate.StdMode <> tm_Drug then Continue;
      2: if not (SetupFiltrate.StdMode in [tm_Dress, tm_Belt, tm_Boot, tm_Helmet]) then Continue;
      3: if SetupFiltrate.StdMode <> tm_Weapon then Continue;
      4: if not (SetupFiltrate.StdMode in [tm_ArmRing, tm_Ring, tm_Necklace, tm_Light, tm_Stone]) then Continue;
      5: if not (SetupFiltrate.StdMode in [tm_MakePropSP, tm_MakeProp]) then Continue;
      6: if not (SetupFiltrate.StdMode in [tm_MakeStone, tm_ResetStone]) then Continue;
      7: if not (SetupFiltrate.StdMode in [tm_MissionSP, tm_Mission]) then Continue;
      8: if SetupFiltrate.StdMode in [tm_Drug, tm_Dress, tm_Belt, tm_Boot, tm_Helmet, tm_Weapon,
        tm_ArmRing, tm_Ring, tm_Necklace, tm_Light, tm_Stone, tm_MakePropSP, tm_MakeProp, tm_MakeStone,
        tm_ResetStone, tm_MissionSP, tm_Mission] then Continue;
    end;
    FItemShowList.AddObject(FItemShowAllList[I], TObject(SetupFiltrate));
  end;
  DDItemUpDown.MaxPosition := FItemShowList.Count - 7;
  DDItemUpDown.Position := 0;
end;

procedure TFrmDlg3.DDItemsEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay: Integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    with g_DXCanvas do begin
      if Sender = DDItems then begin
        if DDitemFind.Text = '' then
          TextOut(ax + DDitemFind.Left + 3, ay + DDitemFind.Top + 2, $808080, '[输入物品关键字查找]');
      end;
    end;
  end;
end;

procedure TFrmDlg3.DDItemsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  FItemMoveIndex := -1;
  with Sender as TDWindow do begin
    Dec(Y, Top);
    Dec(X, Left);
    if (X >= 21) and (Y >= 29) and (x <= 21 + 365) and (y <= 29 + 112) then begin
      FItemMoveIndex := (Y - 29) div 16 + DDItemUpDown.Position;
    end;
  end;  
end;

procedure TFrmDlg3.DDItemsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  SelectIndex: Integer;
  SetupFiltrate: pTSetupFiltrate;
begin
  with Sender as TDWindow do begin
    Dec(Y, Top);
    Dec(X, Left);
    if (X >= 21) and (Y >= 29) and (x <= 21 + 365) and (y <= 29 + 112) then begin
      SelectIndex := (Y - 29) div 16 + DDItemUpDown.Position;
      if (SelectIndex >= 0) and (SelectIndex < FItemShowList.Count) then begin
        SetupFiltrate := pTSetupFiltrate(FItemShowList.Objects[SelectIndex]);
        if (X >= 182) and (X <= 232) then begin
          SetupFiltrate.boColor := not SetupFiltrate.boColor;
        end else
        if (X >= 258) and (X <= 308) then begin
          SetupFiltrate.boPickUp := not SetupFiltrate.boPickUp;
        end else
        if (X >= 334) and (X <= 384) then begin
          SetupFiltrate.boShow := not SetupFiltrate.boShow;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DDMCXChange(Sender: TObject);
begin
  with Sender as TDCheckBox do begin
    if (Tag > 0) and (Tag < SKILL_MAX) and (g_MyMagicArry[Tag].boStudy) then begin
    end else
      Checked := False;
  end;
end;

procedure TFrmDlg3.DDPickupAllItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left + (X - Left - 20));
    y := SurfaceY(Top + (y - Top) + 30);
    ShowMsg := '';
    if Sender = DDMYS then begin
      ShowMsg := '使用治愈术是否锁定治愈目标';
    end else
    if Sender = DDFHideHelmet then begin
      ShowMsg := '在装备栏中隐藏头盔显示，好展示自己的个性发型';
    end else
    if Sender = DDFAllyHum then begin
      ShowMsg := '选中后，将隐藏显示周围联盟人物(人物名称为<蓝色/FCOLOR=$FF0000>的)，提高游戏运行速度\';
      ShowMsg := ShowMsg + '例如：在攻城时开启该项，可以快速分辨敌对人物';
    end else
    if Sender = DDFAroundHum then begin
      ShowMsg := '选中后，将隐藏显示周围人物，提高游戏运行速度\';
      ShowMsg := ShowMsg + '例如：在安全区开启该项，可以快速定位安全区内的NPC位置';
    end else
    if Sender = DDFCtrl then begin
      ShowMsg := '按住CTRL键是否全屏幕显示地面物品名称，不考虑过滤';
    end else
    if Sender = DDFHPShow then begin
      ShowMsg := '是否动画显示对目标或自己的伤害值多少';
    end else
    if Sender = DDPickupAllItem then begin
      ShowMsg := '选中后，将自动捡取所有物品，不考虑过滤\';
      ShowMsg := ShowMsg + '使用快捷键(数字键1左边按键)<（~）/FCOLOR=$FFFF>可以快速捡取脚下物品';
    end;
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, False, Integer(Sender));
  end;
end;

procedure TFrmDlg3.DEditFindChange(Sender: TObject);
begin
  GuildOldFindIndex := -1;
end;

procedure TFrmDlg3.DEditFindMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FrmDlg.DEditIDMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TFrmDlg3.DelGuildMember(sUserName: string);
var
  i: integer;
  GuildMemberInfo: pTGuildMemberInfo;
begin
  if sUserName = '' then
    exit;
  for i := 0 to GuildOnLineMemberList.Count - 1 do begin
    GuildMemberInfo := pTGuildMemberInfo(GuildOnLineMemberList.Objects[I]);
    if CompareText(GuildMemberInfo.UserName, sUserName) = 0 then begin
      GuildOnLineMemberList.Delete(I);
      break;
    end;
  end;
  for i := 0 to GuildMemberList.Count - 1 do begin
    GuildMemberInfo := pTGuildMemberInfo(GuildMemberList.Objects[I]);
    if CompareText(GuildMemberInfo.UserName, sUserName) = 0 then begin
      Dispose(GuildMemberInfo);
      GuildMemberList.Delete(I);
      break;
    end;
  end;
  for I := 0 to GuildMemberStrs.Count - 1 do begin
    if CompareText(GuildMemberStrs[I], sUserName) = 0 then begin
      GuildMemberStrs.Delete(I);
      break;
    end;
  end;
end;

procedure TFrmDlg3.DGameSetupDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      DrawWindow(DSurface, ax, ay, d);
    end;
{$IF Var_Interface = Var_Default}
    with g_DXCanvas do begin
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
    end;
{$IFEND}
  end;
end;

procedure TFrmDlg3.DGameSetupMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  FItemMoveIndex := -1;
end;

procedure TFrmDlg3.DGameSetupVisible(Sender: TObject; boVisible: Boolean);
var
  SetupFiltrate: pTSetupFiltrate;
  ClientStditem: pTClientStditem;
  I, nMagicID: Integer;
begin
  ClearItemShowList;
  if boVisible then begin
    //基本设置
    DDGSBits.ItemIndex := Integer(ClMain.HGE.System_GetState(HGE_SCREENBPP) = 32);
//    DDGSWindow.Checked := not g_boFullScreen;
    DDGSMp3Close.Checked := not g_boBGSound;
    DDGSMusicClose.Checked := not g_boSound;
    //DDGSMp3.Left := 94 + Round(g_btMP3Volume * 1.4);
    //DDGSMusic.Left := 94 + Round(g_btSoundVolume * 1.4);
    SetButtonHight(DDGSMp3, 94 + Round(g_btMP3Volume * 1.4));
    SetButtonHight(DDGSMusic, 94 + Round(g_btSoundVolume * 1.4));
    //选项设置
    DEFExp.Value := g_SetupInfo.nExpFiltrateCount;

    DDFShowName.Checked := g_SetupInfo.boShowName;
    dchkShowNameAll.Checked := g_SetupInfo.boShowNameAll;
    dchkShowNameMon.Checked := g_SetupInfo.boShowNameMon;
    DDFDureHint.Checked := g_SetupInfo.boDuraHint;
    DDFShift.Checked := g_SetupInfo.boExemptShift;
    DDFMapHint.Checked := g_SetupInfo.boShowMapHint;
    DDFExp.Checked := g_SetupInfo.boGetExpFiltrate;
    DDFCtrl.Checked := g_SetupInfo.boShowItemName;
    DDFHPShow.Checked := g_SetupInfo.boMoveHpShow;

    DDFAroundHum.Checked := g_SetupInfo.boHideAroundHum;
    DDFAllyHum.Checked := g_SetupInfo.boHideAllyHum;
    //DDFMagicBegin.Checked := g_SetupInfo.boHideMagicBegin;
    DDFMagicEnd.Checked := g_SetupInfo.boHideMagicEnd;
    DDFHideHelmet.Checked := CheckIntStatus(g_nGameSetupData, GSP_HIDEHELMET);
    dchkDDFNewChangeMap.Checked := not CheckIntStatus(g_nGameSetupData, GSP_OLDCHANGEMAP);

    DDFDeal.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTDEAL);
    DDFGroup.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTGROUP);
    DDFFriend.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTFRIENG);
    DDFGuild.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTGUILD);
    dchkSayHear.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR);
    dchkSayWhisper.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER);
    dchkSayCry.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYCRY);
    dchkSayGroup.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP);
    dchkSayGuild.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD);

    //保护设置
    DDPHP.Checked := g_SetupInfo.boHpProtect;
    DDPHPCount.Value := g_SetupInfo.nHpProtectCount;
    DDPHPTime.Value := g_SetupInfo.dwHpProtectTime;
    DDPMP.Checked := g_SetupInfo.boMpProtect;
    DDPMPCount.Value := g_SetupInfo.nMpProtectCount;
    DDPMPTime.Value := g_SetupInfo.dwMpProtectTime;

    DDPHP2.Checked := g_SetupInfo.boHpProtect2;
    DDPHP2Count.Value := g_SetupInfo.nHpProtectCount2;
    DDPHP2Time.Value := g_SetupInfo.dwHpProtectTime2;
    DDPMP2.Checked := g_SetupInfo.boMpProtect2;
    DDPMP2Count.Value := g_SetupInfo.nMpProtectCount2;
    DDPMP2Time.Value := g_SetupInfo.dwMpProtectTime2;

    DDPReel.Checked := g_SetupInfo.boHpProtect3;
    DDPReelCount.Value := g_SetupInfo.nHpProtectCount3;
    DDPReelTime.Value := g_SetupInfo.dwHpProtectTime3;
    DDPReelItem.ItemIndex := g_SetupInfo.btHpProtectIdx;

    //物品过滤
    DDPickupAllItem.Checked := g_SetupInfo.boAutoPickUpItem;
    for ClientStditem in g_StditemList do begin
      if ClientStditem.isShow then begin
        New(SetupFiltrate);
        SetupFiltrate.wIdent := ClientStditem.StdItem.Idx + 1;
        SetupFiltrate.StdMode := ClientStditem.StdItem.StdMode;
        SetupFiltrate.boShow := ClientStditem.Filtrate.boShow;
        SetupFiltrate.boPickUp := ClientStditem.Filtrate.boPickUp;
        SetupFiltrate.boColor := ClientStditem.Filtrate.boColor;
        FItemShowAllList.AddObject(ClientStditem.StdItem.Name, TObject(SetupFiltrate));
      end;
    end;
    DDItemsClassChange(DDItemsClass);

    //技能设置
    if g_MySelf = nil then exit;

    if (DDAPMagicList.ItemIndex >= 0) and (DDAPMagicList.ItemIndex < DDAPMagicList.Item.Count) then
      nMagicID := Integer(DDAPMagicList.Item.Objects[DDAPMagicList.ItemIndex])
    else
      nMagicID := -1;

    DDMMagicList.Item.Clear;
    DDMMagicList.ItemIndex := -1;
    DDAPMagicList.Item.Clear;
    DDAPMagicList.ItemIndex := -1;
    for I := Low(g_MyMagicArry) to High(g_MyMagicArry) do
    begin
      if g_MyMagicArry[I].boStudy then
      begin
        DDMMagicList.Item.AddObject(g_MyMagicArry[I].Def.Magic.sMagicName, TObject(g_MyMagicArry[I].Def.Magic.wMagicId));
        DDAPMagicList.Item.AddObject(g_MyMagicArry[I].Def.Magic.sMagicName, TObject(g_MyMagicArry[I].Def.Magic.wMagicId));
      end;
      if g_SetupInfo.nAutoMagicIndex = g_MyMagicArry[I].Def.Magic.wMagicId then
        DDMMagicList.ItemIndex := DDMMagicList.Item.Count - 1;
      if (nMagicID > 0) and (nMagicID < SKILL_MAX) and (nMagicID = g_MyMagicArry[I].Def.Magic.wMagicId) then
        DDAPMagicList.ItemIndex := DDAPMagicList.Item.Count - 1;
    end;

    DDMCX.Enabled := (g_MySelf.m_btJob = 0) and g_MyMagicArry[SKILL_ERGUM].boStudy;
    DDMBY.Enabled := (g_MySelf.m_btJob = 0) and g_MyMagicArry[SKILL_BANWOL].boStudy;
    DDMLH.Enabled := (g_MySelf.m_btJob = 0) and g_MyMagicArry[SKILL_FIRESWORD].boStudy;
    DDMLongIceHit.Enabled := (g_MySelf.m_btJob = 0) and g_MyMagicArry[SKILL_LONGICEHIT].boStudy;
    DDMCS.Checked := (g_MySelf.m_btJob = 0) and g_MyMagicArry[SKILL_ERGUM].boStudy;

    DDMMFD.Enabled := (g_MySelf.m_btJob = 1) and g_MyMagicArry[SKILL_SHIELD].boStudy;
    DDMSnowWindLock.Enabled := (g_MySelf.m_btJob = 1) and g_MyMagicArry[SKILL_SNOWWIND].boStudy;
    DDMFieryDragonLock.Enabled := (g_MySelf.m_btJob = 1) and g_MyMagicArry[SKILL_47].boStudy;

    DDMYS.Enabled := (g_MySelf.m_btJob = 2){ and g_MyMagicArry[SKILL_CLOAK].boStudy};

    DDMCX.Checked := g_SetupInfo.boAutoLongHit and (g_MySelf.m_btJob = 0) and g_MyMagicArry[SKILL_ERGUM].boStudy;
    DDMBY.Checked := g_SetupInfo.boAutoWideHit and (g_MySelf.m_btJob = 0) and g_MyMagicArry[SKILL_BANWOL].boStudy;
    DDMLH.Checked := g_SetupInfo.boAutoFireHit and (g_MySelf.m_btJob = 0) and g_MyMagicArry[SKILL_FIRESWORD].boStudy;
    DDMLongIceHit.Checked := g_SetupInfo.boAutoLongIceHit and (g_MySelf.m_btJob = 0) and g_MyMagicArry[SKILL_LongIceHit].boStudy;
    DDMCS.Checked := g_SetupInfo.boAutoLongWide and (g_MySelf.m_btJob = 0) and g_MyMagicArry[SKILL_ERGUM].boStudy;

    DDMMFD.Checked := g_SetupInfo.boAutoShield and (g_MySelf.m_btJob = 1) and g_MyMagicArry[SKILL_SHIELD].boStudy;
    DDMSnowWindLock.Checked := (not g_SetupInfo.boSnowWindLock) and (g_MySelf.m_btJob = 1) and g_MyMagicArry[SKILL_SNOWWIND].boStudy;
    DDMFieryDragonLock.Checked := (not g_SetupInfo.boFieryDragonLock) and (g_MySelf.m_btJob = 1) and g_MyMagicArry[SKILL_47].boStudy;

    DDMYS.Checked := g_SetupInfo.boAutoCloak and (g_MySelf.m_btJob = 2){ and g_MyMagicArry[SKILL_CLOAK].boStudy};

    DDMAutoMagic.Checked := g_SetupInfo.boAutoMagic;
    DDMTime.Value := g_SetupInfo.dwAutoMagicTick div 1000;

  end else begin
  
  end;
end;

procedure TFrmDlg3.DGDAddMemClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg.DMessageDlg('请输入想要邀请加入行会的人物名称：', [mbOk, mbAbort]);
  if FrmDlg.DlgEditText <> '' then
    frmMain.SendGuildAddMem(FrmDlg.DlgEditText);
end;

procedure TFrmDlg3.DGDAddMemDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex + 1];
      end
      else
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg3.DGDAllyAddClick(Sender: TObject; X, Y: Integer);
begin
  if mrOk = FrmDlg.DMessageDlg('　　　　对方联盟行会必需在 [允许联盟] 状态下。　　　　\' +
    '　　　　而且二个行会的掌门必须面对面。\' +
    '　　　　是否确认行会联盟？', [mbOk, mbCancel]) then
    frmMain.SendSay(g_Cmd_Auth);
end;

procedure TFrmDlg3.DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
var
  sGuildName: string;
  GuildSocietyInfo: pTGuildSocietyInfo;
begin
  if (GuildAllySelectIndex > -1) and (GuildAllySelectIndex < GuildAllyList.Count) then begin
    GuildSocietyInfo := GuildAllyList[GuildAllySelectIndex];
    sGuildName := GuildSocietyInfo.sGuildName;
    if FrmDlg.DMessageDlg('是否确定取消与[' + sGuildName + ']的联盟？', [mbOk, mbCancel]) = mrOk then begin
      frmMain.SendSay(g_Cmd_AuthCancel + ' ' + sGuildName);
    end;
  end
  else if FrmDlg.DMessageDlg('请输入您想取消结盟的行会的名称：', [mbOk, mbCancel, mbAbort]) = mrOk then begin
    if Trim(FrmDlg.DlgEditText) <> '' then
      frmMain.SendSay(g_Cmd_AuthCancel + ' ' + Trim(FrmDlg.DlgEditText));
  end;
end;

procedure TFrmDlg3.DGDCloseClick(Sender: TObject; X, Y: Integer);
var
  d: TDButton;
begin
  if Sender is TDButton then begin
    d := TDButton(Sender);
    if d.DParent <> nil then
      d.DParent.Visible := False;
  end;
end;

procedure TFrmDlg3.DGDDelMemClick(Sender: TObject; X, Y: Integer);
var
  MemberList: TQuickStringPointerList;
  GuildMemberInfo: pTGuildMemberInfo;
  UserName: string;
  i: integer;
begin
  if DCheckBoxShowMember.Checked then
    MemberList := GuildMemberList
  else
    MemberList := GuildOnLineMemberList;
  if (GuildSelectIndex > -1) and (GuildSelectIndex < MemberList.Count) then begin
    GuildMemberInfo := pTGuildMemberInfo(MemberList.Objects[GuildSelectIndex]);
    UserName := GuildMemberInfo.UserName;
  end
  else begin
    FrmDlg.DMessageDlg('请输入想要删除的人物名称：', [mbOk, mbAbort]);
    UserName := FrmDlg.DlgEditText;
  end;
  if UserName <> '' then begin
    if CompareText(UserName, g_MySelf.m_UserName) = 0 then begin
      FrmDlg.DMessageDlg('[提示信息] 你不能删除自己！', []);
      exit;
    end;
    for I := 0 to GuildMemberList.Count - 1 do begin
      GuildMemberInfo := pTGuildMemberInfo(MemberList.Objects[I]);
      if CompareText(GuildMemberInfo.UserName, UserName) = 0 then begin
        if mrYes = FrmDlg.DMessageDlg('是否确定删除行会成员[' + UserName + ']?', [mbYes, mbNo]) then begin
          frmMain.SendGuildDelMem(UserName);
        end;
        exit;
      end;
    end;
    FrmDlg.DMessageDlg('[提示信息] ' + UserName + ' 非本行会成员！', []);
  end;
end;

procedure TFrmDlg3.DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
var
  i: integer;
  data, str: string;
  MemberList: TQuickStringPointerList;
  GuildMemberInfo: pTGuildMemberInfo;
  FindIndex: Integer;
begin
  if Sender = DGDEditFind then begin
    if DEditFind.Text <> '' then begin
      GuildSelectIndex := -1;
      if DCheckBoxShowMember.Checked then
        MemberList := GuildMemberList
      else
        MemberList := GuildOnLineMemberList;
      str := Trim(DEditFind.Text);
      if (GuildOldFindIndex >= 0) and (GuildOldFindIndex < (MemberList.Count - 1)) then
        FindIndex := GuildOldFindIndex
      else
        FindIndex := 0;
      for i := FindIndex to MemberList.Count - 1 do begin
        GuildMemberInfo := pTGuildMemberInfo(MemberList.Objects[I]);
        if CompareLStr(GuildMemberInfo.UserName, str, Length(str)) then begin
          GuildOldFindIndex := I + 1;
          GuildSelectIndex := I;
          DGuildMemberUpDown.Position := i;
          break;
        end;
      end;
      if GuildSelectIndex = -1 then
        GuildOldFindIndex := -1;
    end;
  end
  else if Sender = DGDEditNotice then begin
    DMemoGuildNotice.ReadOnly := not DMemoGuildNotice.ReadOnly;
    if DMemoGuildNotice.ReadOnly then begin
      DMemoGuildNotice.Lines.Clear;
      for data in GuildNoticeList do
        DMemoGuildNotice.Lines.Add(data);
    end;
  end
  else if Sender = DGDEditNoticeSave then begin
    DMemoGuildNotice.ReadOnly := True;
    data := '';
    for i := 0 to DMemoGuildNotice.Lines.count - 1 do begin
      if DMemoGuildNotice.Lines[i] = '' then
        data := data + DMemoGuildNotice.Lines[i] + ' '#13
      else
        data := data + DMemoGuildNotice.Lines[i] + #13;
    end;
    frmMain.SendGuildUpdateNotice(data);
    GuildSaveNoticeTick := GetTickCount + 10000;
    Inc(g_GuildIndex[1]);
  end
  else if Sender = DGDEditGrade then begin
    DMemoGuildMember.Visible := not DMemoGuildMember.Visible;
    DMemoGuildMember.Lines.Clear;
    for i := 0 to GuildMemberStrs.Count - 1 do begin
      DMemoGuildMember.Lines.Add(GuildMemberStrs[i]);
    end;
    DMemoGuildMember.ItemIndex := -1;
  end
  else if Sender = DGDEditRefMemberList then begin
    if DMemoGuildMember.Visible then begin
      data := '';
      for i := 0 to DMemoGuildMember.Lines.count - 1 do begin
        str := Trim(DMemoGuildMember.Lines[i]);
        if (str <> '') then
          data := data + str + #13;
      end;
      frmMain.SendGuildUpdateGrade(data);
      GuildSaveMemberTick := GetTickCount + 10 * 1000;
      DGDEditNoticeClick(DGDEditGrade, 0, 0);
    end
    else begin
      frmMain.SendGuildMemberList(g_GuildMemberIndex);
      GuildRefMemberTick := GetTickCount + 60 * 1000;
    end;
  end;
end;

procedure TFrmDlg3.DGDGetMoneyClick(Sender: TObject; X, Y: Integer);
var
  DGold: Integer;
  valstr: string;
begin
  FrmDlg.DMessageDlg('请输入要发放的' + g_sGoldName + '数量, 不能低于100000', [mbOk, mbAbort]);
  GetValidStrVal(Trim(FrmDlg.DlgEditText), valstr, [' ']);
  DGold := StrToIntDef(valstr, 0);
  if (DGold <= g_ClientGuildInfo.nGuildMoney) and (DGold > 99999) then begin
    FrmMain.SendClientMessage(CM_GUILDGOLDCHANGE, DGold, 0, 0, 2, '');
  end;
end;

procedure TFrmDlg3.DGDHomeClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if GuildIndex <> Tag then begin
      GuildIndex := Tag;
      ChangeGuildDlg(GuildIndex);
      PlaySound(s_glass_button_click);
    end;
  end;
end;

procedure TFrmDlg3.DGDHomeDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
{$IF Var_Interface = Var_Default}
  idx: integer;
  FColor: TColor;
  nTop: Byte;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if GuildIndex = tag then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end;
    end;
  end;
{$ELSE}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := FaceIndex;
      FColor := DFMoveColor;
      nTop := 2;
      if GuildIndex <> tag then begin
        FColor := DFColor;
        nTop := 2;
        if MouseEntry = msIn then
          Inc(idx, 2)
        else
          Inc(idx, 1);
      end;
      d := WLib.Images[idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2,
          SurfaceY(Top) + (Height - TextHeight(Caption)) div 2 + nTop, FColor, Caption);
        //Release;
      end;
    end;
  end;
{$IFEND}

end;

procedure TFrmDlg3.DGDSetMoneyClick(Sender: TObject; X, Y: Integer);
var
  DGold: Integer;
  valstr: string;
begin
  FrmDlg.DMessageDlg('请输入要存入的' + g_sGoldName + '数量, 不能低于10000', [mbOk, mbAbort]);
  GetValidStrVal(Trim(FrmDlg.DlgEditText), valstr, [' ']);
  DGold := StrToIntDef(valstr, 0);
  if (DGold <= g_MySelf.m_nGold) and (DGold > 9999) then begin
    Frmmain.SendClientMessage(CM_GUILDGOLDCHANGE, DGold, 0, 0, 0, '');
  end;
end;

procedure TFrmDlg3.DGDSortComboBoxChange(Sender: TObject);
var
  i: integer;
  GuildMemberInfo: pTGuildMemberInfo;
  str: string;
begin
  case DGDSortComboBox.ItemIndex of
    0: begin
        GuildOnLineMemberList.Clear;
        for I := 0 to GuildMemberList.Count - 1 do begin
          GuildMemberInfo := pTGuildMemberInfo(GuildMemberList.Objects[I]);
          str := Format('%.3d%.3d', [GuildMemberInfo.btRank, GuildMemberInfo.nCount]);
          GuildMemberList[I] := str;
          if GuildMemberInfo.nTime = -1 then
            GuildOnLineMemberList.AddObject(str, TObject(GuildMemberInfo));
        end;
      end;
    1: begin
        GuildOnLineMemberList.Clear;
        for I := 0 to GuildMemberList.Count - 1 do begin
          GuildMemberInfo := pTGuildMemberInfo(GuildMemberList.Objects[I]);
          str := GuildMemberInfo.RankName;
          GuildMemberList[I] := str;
          if GuildMemberInfo.nTime = -1 then
            GuildOnLineMemberList.AddObject(str, TObject(GuildMemberInfo));
        end;
      end;
    2: begin
        GuildOnLineMemberList.Clear;
        for I := 0 to GuildMemberList.Count - 1 do begin
          GuildMemberInfo := pTGuildMemberInfo(GuildMemberList.Objects[I]);
          str := GuildMemberInfo.UserName;
          GuildMemberList[I] := str;
          if GuildMemberInfo.nTime = -1 then
            GuildOnLineMemberList.AddObject(str, TObject(GuildMemberInfo));
        end;
      end;
    3: begin
        GuildOnLineMemberList.Clear;
        for I := 0 to GuildMemberList.Count - 1 do begin
          GuildMemberInfo := pTGuildMemberInfo(GuildMemberList.Objects[I]);
          str := Format('%.8d%.3d%3.d', [GuildMemberInfo.nTime + 1, GuildMemberInfo.btRank, GuildMemberInfo.nCount]);
          GuildMemberList[I] := str;
          if GuildMemberInfo.nTime = -1 then
            GuildOnLineMemberList.AddObject(str, TObject(GuildMemberInfo));
        end;
      end;
  end;
  GuildMemberList.SortString(0, GuildMemberList.Count - 1);
  GuildOnLineMemberList.SortString(0, GuildOnLineMemberList.Count - 1);
end;

procedure TFrmDlg3.DGDUpLevelClick(Sender: TObject; X, Y: Integer);
begin
  if boGuildLevelUp then exit;
  boGuildLevelUp := True;
  FrmMain.SendClientMessage(CM_GUILDLEVELUP, 0, 0, 0, 0, '');
end;

procedure TFrmDlg3.DGDUpLevelDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if not Enabled then begin
        d := WLib.Images[FaceIndex + 2];
      end else
      if Downed then begin
        d := WLib.Images[FaceIndex + 1];
      end
      else
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg3.DGDUpLevelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
  nCount: Integer;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left + (X - Left - 20));
    y := SurfaceY(Top + (y - Top) + 30);
    ShowMsg := '';
    if Sender = DGDUpLevel then begin
      ShowMsg := '升级到下一级别需要：\';
      ShowMsg := ShowMsg + '　行会资金：' + IntToStr(g_ClientGuildInfo.nLevelGuildMoney) + '\';
      ShowMsg := ShowMsg + '　建 设 值：' + IntToStr(g_ClientGuildInfo.nLevelBuildPoint) + '\';
      ShowMsg := ShowMsg + '　繁 荣 值：' + IntToStr(g_ClientGuildInfo.nLevelFlourishingPoint) + '\';
      ShowMsg := ShowMsg + '　安 定 值：' + IntToStr(g_ClientGuildInfo.nLevelStabilityPoint) + '\';
      ShowMsg := ShowMsg + '　人 气 值：' + IntToStr(g_ClientGuildInfo.nLevelActivityPoint) + '\';
      ShowMsg := ShowMsg + '升级后行会奖励\';
      if g_ClientGuildInfo.btGuildLevel <= 9 then nCount := g_ClientGuildInfo.btGuildLevel + 1
      else nCount := Round((1 + (g_ClientGuildInfo.btGuildLevel - 9)) * (g_ClientGuildInfo.btGuildLevel - 9) / 2) + 10;
      ShowMsg := ShowMsg + '　杀怪经验增加：' + IntToStr(nCount) + '%\';
      ShowMsg := ShowMsg + '　杀怪伤害增加：' + IntToStr(nCount) + '%\';
      ShowMsg := ShowMsg + '　行会成员上限增加：5\';
    end else
    if Sender = DGDGetMoney then begin
      ShowMsg := '将指定的行会资金平均分放给在线的每一位行会成员';
    end else
    if Sender = DMakeMagicxAutoMake then begin
      ShowMsg := '将跟据放置的材料数量自动全部打造\最大不会超过打造后的物品可叠加数量';
    end;
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, False, Integer(Sender));
  end;
end;

procedure TFrmDlg3.DGSAppClick(Sender: TObject; X, Y: Integer);
var
  i: integer;
  SetupFiltrate: pTSetupFiltrate;
  ClientStditem: pTClientStditem;
begin
  //基本设置
//  if (DDGSWindow.Checked <> (not g_boFullScreen)) then begin
    if DDGSBits.ItemIndex = 1 then ClMain.HGE.System_SetState(HGE_SCREENBPP, 32)
    else ClMain.HGE.System_SetState(HGE_SCREENBPP, 16);
//    FrmMain.FullScreen(not DDGSWindow.Checked);
//  end;
//  DDGSWindow.Checked := not g_boFullScreen;
  g_btMP3Volume := Round((DDGSMp3.Left - 94) / 1.4);
  g_btSoundVolume := Round((DDGSMusic.Left - 94) / 1.4);
  g_boBGSound := not DDGSMp3Close.Checked;
  g_boSound := not DDGSMusicClose.Checked;
  g_Sound.Volume := g_btSoundVolume;

  if not g_boSound then SilenceSound;
  if g_boBGSound and (g_btMP3Volume > 0) then begin
    if g_boCanSound then begin
      if MusicHS >= BASS_ERROR_ENDED then begin
        if BASS_ChannelIsActive(MusicHS) <> BASS_ACTIVE_PLAYING then begin
          PlayMapMusic(True);
        end else
          BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
      end else
        PlayMapMusic(True);
    end;
  end
  else ClearBGM;

  ClientSetup.saveData();
  //选项设置
  g_SetupInfo.nExpFiltrateCount := DEFExp.Value;

  g_SetupInfo.boShowName := DDFShowName.Checked;
  g_SetupInfo.boShowNameAll := dchkShowNameAll.Checked;
  g_SetupInfo.boShowNameMon := dchkShowNameMon.Checked;
  g_SetupInfo.boDuraHint := DDFDureHint.Checked;
  g_SetupInfo.boExemptShift := DDFShift.Checked;
  g_SetupInfo.boShowMapHint := DDFMapHint.Checked;
  g_SetupInfo.boGetExpFiltrate := DDFExp.Checked;
  g_SetupInfo.boShowItemName := DDFCtrl.Checked;
  g_SetupInfo.boMoveHpShow := DDFHPShow.Checked;

  if g_boEasyNotShift then begin
    g_boShiftOpen := g_SetupInfo.boExemptShift;
    if g_boShiftOpen then DScreen.AddSysMsg('[自动Shift 开]', cllime)
    else DScreen.AddSysMsg('[自动Shift 关]', cllime);
  end else begin
    if not g_SetupInfo.boExemptShift then begin
      if g_boShiftOpen then
        DScreen.AddSysMsg('[自动Shift 关]', cllime);
      g_boShiftOpen := False;
    end;
  end;

  if g_FScreenMode <> DDGSXY.ItemIndex then
    DScreen.AddSysMsg('[分辨率的设置已经改变，重新进入游戏后生效]', cllime);
  g_SetupInfo.boHideAroundHum := DDFAroundHum.Checked;
  g_SetupInfo.boHideAllyHum := DDFAllyHum.Checked;
  //g_SetupInfo.boHideMagicBegin := DDFMagicBegin.Checked;
  g_SetupInfo.boHideMagicEnd := DDFMagicEnd.Checked;
  //g_SetupInfo.boShowHelmet := not DDFHideHelmet.Checked;
  SetIntStatus(g_nGameSetupData, GSP_HIDEHELMET, DDFHideHelmet.Checked);
  SetIntStatus(g_nGameSetupData, GSP_OLDCHANGEMAP, not dchkDDFNewChangeMap.Checked);

  {g_SetupInfo.boNotDeal := DDFDeal.Checked;
  g_SetupInfo.boNotGroup := DDFGroup.Checked;
  g_SetupInfo.boNotFriend := DDFFriend.Checked;
  g_SetupInfo.boNotGuild := DDFGuild.Checked;    }

  SetIntStatus(g_nGameSetupData, GSP_NOTDEAL, DDFDeal.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTGROUP, DDFGroup.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTFRIENG, DDFFriend.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTGUILD, DDFGuild.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR, dchkSayHear.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER, dchkSayWhisper.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYCRY, dchkSayCry.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP, dchkSayGroup.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD, dchkSayGuild.Checked);

  //保护设置
  g_SetupInfo.boHpProtect := DDPHP.Checked;
  g_SetupInfo.nHpProtectCount := DDPHPCount.Value;
  g_SetupInfo.dwHpProtectTime := DDPHPTime.Value;
  g_SetupInfo.boMpProtect := DDPMP.Checked;
  g_SetupInfo.nMpProtectCount := DDPMPCount.Value;
  g_SetupInfo.dwMpProtectTime := DDPMPTime.Value;

  g_SetupInfo.boHpProtect2 := DDPHP2.Checked;
  g_SetupInfo.nHpProtectCount2 := DDPHP2Count.Value;
  g_SetupInfo.dwHpProtectTime2 := DDPHP2Time.Value;
  g_SetupInfo.boMpProtect2 := DDPMP2.Checked;
  g_SetupInfo.nMpProtectCount2 := DDPMP2Count.Value;
  g_SetupInfo.dwMpProtectTime2 := DDPMP2Time.Value;

  g_SetupInfo.boHpProtect3 := DDPReel.Checked;
  g_SetupInfo.nHpProtectCount3 := DDPReelCount.Value;
  g_SetupInfo.dwHpProtectTime3 := DDPReelTime.Value;
  g_SetupInfo.btHpProtectIdx := DDPReelItem.ItemIndex;

  //技能设置
  g_SetupInfo.boAutoLongHit := DDMCX.Checked;
  g_SetupInfo.boAutoWideHit := DDMBY.Checked;
  g_SetupInfo.boAutoFireHit := DDMLH.Checked;
  g_SetupInfo.boAutoLongWide := DDMCS.Checked;
  g_SetupInfo.boAutoLongIceHit := DDMLongIceHit.Checked;
 // DDMCS

  g_SetupInfo.boAutoShield := DDMMFD.Checked;
  g_SetupInfo.boSnowWindLock := not DDMSnowWindLock.Checked;
  g_SetupInfo.boFieryDragonLock := not DDMFieryDragonLock.Checked;


  g_SetupInfo.boAutoCloak := DDMYS.Checked;

  g_SetupInfo.nAutoMagicIndex := -1;
  g_SetupInfo.boAutoMagic := DDMAutoMagic.Checked;
  g_SetupInfo.dwAutoMagicTick := DDMTime.Value * 1000;
  if (DDMMagicList.ItemIndex >= 0) and (DDMMagicList.ItemIndex < DDMMagicList.Item.Count) then
    g_SetupInfo.nAutoMagicIndex := Integer(DDMMagicList.Item.Objects[DDMMagicList.ItemIndex]);

  //物品过滤
  g_SetupInfo.boAutoPickUpItem := DDPickupAllItem.Checked;
  for I := 0 to FItemShowAllList.Count - 1 do begin
    SetupFiltrate := pTSetupFiltrate(FItemShowAllList.Objects[I]);
    ClientStditem := GetClientStditem(SetupFiltrate.wIdent);
    if ClientStditem <> nil then begin
      ClientStditem.Filtrate.boShow := SetupFiltrate.boShow;
      ClientStditem.Filtrate.boPickUp := SetupFiltrate.boPickUp;
      ClientStditem.Filtrate.boColor := SetupFiltrate.boColor;
      ClientStditem.Filtrate.boChange := True;
    end;
  end;

  {if GetTickCount > g_dwChangeGroupModeTick then begin
    g_dwChangeGroupModeTick := GetTickCount + 500; //timeout 5檬
    frmMain.SendGroupMode;
  end;  }
  g_nMiniMapOldX := -1;
  frmMain.SendGroupMode;
  SendGameSetupInfo;
end;

procedure TFrmDlg3.DGSConfigClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if FSetupIndex <> Tag then begin
      FSetupIndex := Tag;
      PlaySound(s_glass_button_click);
      case FSetupIndex of
        0: begin
            DDGSSetup.Visible := True;
            DDFunction.Visible := False;
            DDGProtect.Visible := False;
            DDItems.Visible := False;
            DDMagic.Visible := False;
            dwndSaySetup.Visible := False;
          end;
        1: begin
            DDGSSetup.Visible := False;
            DDFunction.Visible := True;
            DDGProtect.Visible := False;
            DDItems.Visible := False;
            DDMagic.Visible := False;
            dwndSaySetup.Visible := False;
          end;
        2: begin
            DDGSSetup.Visible := False;
            DDFunction.Visible := False;
            DDGProtect.Visible := True;
            DDItems.Visible := False;
            DDMagic.Visible := False;
            dwndSaySetup.Visible := False;
          end;
        3: begin
            DDItems.Visible := True;
            DDGSSetup.Visible := False;
            DDFunction.Visible := False;
            DDGProtect.Visible := False;
            DDMagic.Visible := False;
            dwndSaySetup.Visible := False;
          end;
        4: begin
            DDItems.Visible := False;
            DDGSSetup.Visible := False;
            DDFunction.Visible := False;
            DDGProtect.Visible := False;
            DDMagic.Visible := True;
            dwndSaySetup.Visible := False;
          end;
        5: begin
            DDItems.Visible := False;
            DDGSSetup.Visible := False;
            DDFunction.Visible := False;
            DDGProtect.Visible := False;
            DDMagic.Visible := False;
            dwndSaySetup.Visible := True;
          end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DGSConfigDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
{$IF Var_Interface = Var_Default}
  idx: integer;
  FColor: TColor;
  nTop: Byte;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if FSetupIndex <> tag then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        with g_DXCanvas do begin
          TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2, SurfaceY(Top) + (Height - TextHeight(Caption)) div 2, Caption, DFColor);
        end;
      end else begin
        d := WLib.Images[FaceIndex + 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top) - 2, d.ClientRect, d, True);
        with g_DXCanvas do begin
          TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2, SurfaceY(Top) + (Height - TextHeight(Caption)) div 2, Caption, clWhite);
        end;
      end;
    end;
  end;
{$ELSE}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := FaceIndex;
      FColor := DFMoveColor;
      nTop := 1;
      if FSetupIndex <> tag then begin
        FColor := DFColor;
        nTop := 1;
        if MouseEntry = msIn then
          Inc(idx, 2)
        else
          Inc(idx, 1);
      end;
      d := WLib.Images[idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      with g_DXCanvas do begin
        TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2,
          SurfaceY(Top) + (Height - TextHeight(Caption)) div 2 + nTop,
          Caption, FColor);
      end;
    end;
  end;
{$IFEND}

end;

procedure TFrmDlg3.DGSDefaultClick(Sender: TObject; X, Y: Integer);
var
  SetupFiltrate: pTSetupFiltrate;
  ClientStditem: pTClientStditem;
  ClientItemFiltrate: pTClientItemFiltrate;
  I: Integer;
begin
  if DDGSSetup.Visible then begin
    DDGSBits.ItemIndex := 0;
    DDGSXY.ItemIndex := 0;
//    DDGSWindow.Checked := True;
    DDGSMp3Close.Checked := False;
    DDGSMusicClose.Checked := False;
    SetButtonHight(DDGSMp3, 234);
    SetButtonHight(DDGSMusic, 234);
  end else
  if DDFunction.Visible then begin
    DEFExp.Value := 2000;

    DDFShowName.Checked := True;
    DDFDureHint.Checked := True;
    DDFShift.Checked := False;
    DDFMapHint.Checked := True;
    DDFExp.Checked := False;
    DDFCtrl.Checked := True;
    DDFHPShow.Checked := True;

    DDFAroundHum.Checked := False;
    DDFAllyHum.Checked := False;
    //DDFMagicBegin.Checked := False;
    dchkDDFNewChangeMap.Checked := False;
    DDFMagicEnd.Checked := False;
    DDFHideHelmet.Checked := False;

    DDFDeal.Checked := True;
    DDFGroup.Checked := True;
    DDFFriend.Checked := True;
    DDFGuild.Checked := True;
  end else
  if DDGProtect.Visible then begin
    DDPHP.Checked := False;
    DDPHPCount.Value := 0;
    DDPHPTime.Value := 4;
    DDPMP.Checked := False;
    DDPMPCount.Value := 0;
    DDPMPTime.Value := 4;

    DDPHP2.Checked := False;
    DDPHP2Count.Value := 0;
    DDPHP2Time.Value := 4;
    DDPMP2.Checked := False;
    DDPMP2Count.Value := 0;
    DDPMP2Time.Value := 4;

    DDPReel.Checked := False;
    DDPReelCount.Value := 0;
    DDPReelTime.Value := 4;
    DDPReelItem.ItemIndex := 0;
  end else
  if DDItems.Visible then begin
    if mrYes = FrmDlg.DMessageDlg('是否确定恢复物品过滤为默认设置？', [mbYes, mbNo]) then begin
      ClearItemShowList;
      for I := 0 to g_StditemList.Count - 1 do begin
        ClientStditem := g_StditemList[I];
        ClientItemFiltrate := pTClientItemFiltrate(g_StditemFiltrateList[I]);
        if ClientStditem.isShow then begin
          New(SetupFiltrate);
          SetupFiltrate.wIdent := ClientStditem.StdItem.Idx + 1;
          SetupFiltrate.StdMode := ClientStditem.StdItem.StdMode;
          SetupFiltrate.boShow := ClientItemFiltrate.boShow;
          SetupFiltrate.boPickUp := ClientItemFiltrate.boPickUp;
          SetupFiltrate.boColor := ClientItemFiltrate.boColor;
          FItemShowAllList.AddObject(ClientStditem.StdItem.Name, TObject(SetupFiltrate));
        end;
      end;
      DDItemsClassChange(DDItemsClass);
    end;
  end else
  if DDMagic.Visible then begin
    DDMAutoMagic.Checked := False;
    DDMTime.Value := 10;
  end;
end;

procedure TFrmDlg3.DGSSaveClick(Sender: TObject; X, Y: Integer);
begin
  DGSAppClick(DGSApp, X, Y);
  DGameSetup.Visible := False;
end;

procedure TFrmDlg3.DGuildAllyDlgClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDWindow do begin
    Dec(x, left);
    Dec(y, Top);
{$IF Var_Interface = Var_Mir2}
    if (X >= 6) and (Y >= 53) and (x <= 6 + 227) and (y <= 53 + 114) then begin 
      DGuildAllyDlg.WheelDControl := DGuildAllyUpDown;
      GuildAllySelectIndex := (Y - 53) div 16 + DGuildAllyUpDown.Position;
    end
    else if (X >= 6) and (Y >= 250) and (x <= 6 + 227) and (y <= 250 + 114) then begin
      DGuildAllyDlg.WheelDControl := DGuildWarUpDown;
      GuildWarSelectIndex := (Y - 250) div 16 + DGuildWarUpDown.Position;
    end;
{$ELSE}
    if (X >= 8) and (Y >= 47) and (x <= 8 + 258) and (y <= 47 + 144) then begin 
      DGuildAllyDlg.WheelDControl := DGuildAllyUpDown;
      GuildAllySelectIndex := (Y - 47) div 16 + DGuildAllyUpDown.Position;
    end
    else if (X >= 8) and (Y >= 278) and (x <= 8 + 258) and (y <= 278 + 128) then begin
      DGuildAllyDlg.WheelDControl := DGuildWarUpDown;
      GuildWarSelectIndex := (Y - 278) div 16 + DGuildWarUpDown.Position;
    end;  
{$IFEND}

  end;
end;

procedure TFrmDlg3.DGuildAllyDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, ny: integer;
  I: Integer;
  GuildSocietyInfo: pTGuildSocietyInfo;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      DrawWindow(DSurface, ax, ay, d);
    end;
{$IF Var_Interface = Var_Default}
    Dec(ax, Left);
    Dec(ay, Top);
{$IFEND}
    with g_DXCanvas do begin
      if Sender = DGuildLogDlg then begin
        if DMemoGuildNotice.ReadOnly then begin
          DGDEditNoticeSave.Visible := False;
{$IF Var_Interface = Var_Mir2}
          DGDEditNotice.SetImgIndex(g_WMain99Images, 1681);
{$ELSE}
          DGDEditNotice.Caption := '编辑';
{$IFEND}
          DMemoGuildNotice.DFColor := $00B5C79C;
        end
        else begin
          DGDEditNoticeSave.Visible := True;
          DGDEditNoticeSave.Enabled := GetTickCount > GuildSaveNoticeTick;
{$IF Var_Interface = Var_Mir2}
          DGDEditNotice.SetImgIndex(g_WMain99Images, 1683);
{$ELSE}
          DGDEditNotice.Caption := '取消';
{$IFEND}
          DMemoGuildNotice.DFColor := clWhite;
        end;
        DGDEditNotice.Enabled := (g_ClientGuildInfo.btMyRank = 1) and (GetTickCount > GuildSaveNoticeTick);
{$IF Var_Interface = Var_Mir2}
        DGDEditNotice.Visible := g_ClientGuildInfo.btMyRank = 1; 

{$IFEND}
      end
      else if Sender = DGuildInfoDlg then begin
        DGDUpLevel.Enabled := (g_ClientGuildInfo.btMyRank = 1) and (not boGuildLevelUp) and
          (g_ClientGuildInfo.nGuildMoney >= g_ClientGuildInfo.nLevelGuildMoney) and
          (g_ClientGuildInfo.nBuildPoint >= g_ClientGuildInfo.nLevelBuildPoint) and
          (g_ClientGuildInfo.nFlourishingPoint >= g_ClientGuildInfo.nLevelFlourishingPoint) and
          (g_ClientGuildInfo.nStabilityPoint >= g_ClientGuildInfo.nLevelStabilityPoint) and
          (g_ClientGuildInfo.nActivityPoint >= g_ClientGuildInfo.nLevelActivityPoint);
          
        DGDGetMoney.Enabled := (g_ClientGuildInfo.btMyRank = 1) and (g_ClientGuildInfo.nGuildMoney > 0);

{$IF Var_Interface = Var_Mir2}
        DGDUpLevel.Visible := (g_ClientGuildInfo.btMyRank = 1);
        DGDGetMoney.Visible := (g_ClientGuildInfo.btMyRank = 1);
        
        TextOut(ax + 78, ay + 47, clWhite, g_ClientGuildInfo.sGuildName);
        TextOut(ax + 78, ay + 63, clWhite, GuildMasterName);
        TextOut(ax + 78, ay + 79, clWhite, Format('%d/%d 在线(%d)', [GuildMemberList.Count, g_ClientGuildInfo.btMaxMeberCount, GuildOnLineMemberList.Count]));
        TextOut(ax + 78, ay + 100, clWhite, g_ClientGuildInfo.sCreateName);
        TextOut(ax + 78, ay + 116, clWhite, FormatDateTime('YYYY年MM月DD日', g_ClientGuildInfo.dwCreateTime));

        TextOut(ax + 78, ay + 177, clWhite, IntToStr(g_ClientGuildInfo.btGuildLevel));
        TextOut(ax + 78, ay + 196, clWhite, GetGoldStr(g_ClientGuildInfo.nGuildMoney));

        TextOut(ax + 66, ay + 215, clWhite, IntToStr(g_ClientGuildInfo.nBuildPoint));
        TextOut(ax + 66, ay + 231, clWhite, IntToStr(g_ClientGuildInfo.nFlourishingPoint));
        TextOut(ax + 66, ay + 247, clWhite, IntToStr(g_ClientGuildInfo.nStabilityPoint));
        TextOut(ax + 66, ay + 263, clWhite, IntToStr(g_ClientGuildInfo.nActivityPoint) + '/' + IntToStr(g_ClientGuildInfo.nMaxActivityPoint));

        TextOut(ax + 101, ay + 322, clWhite, IntToStr(g_ClientGuildInfo.btKickMonExp) + '%');
        TextOut(ax + 101, ay + 340, clWhite, IntToStr(g_ClientGuildInfo.btKickMonAttack) + '%');
{$ELSE}
        TextOut(ax + 90, ay + 103, clWhite, g_ClientGuildInfo.sGuildName);
        TextOut(ax + 90, ay + 123, clWhite, GuildMasterName);
        TextOut(ax + 90, ay + 143, clWhite, Format('%d/%d 在线(%d)',
          [GuildMemberList.Count, g_ClientGuildInfo.btMaxMeberCount, GuildOnLineMemberList.Count]));
        TextOut(ax + 90, ay + 173, clWhite, g_ClientGuildInfo.sCreateName);
        TextOut(ax + 90, ay + 192, clWhite, FormatDateTime('YYYY年MM月DD日', g_ClientGuildInfo.dwCreateTime));

        TextOut(ax + 90, ay + 249, clWhite, IntToStr(g_ClientGuildInfo.btGuildLevel));
        TextOut(ax + 90, ay + 284, clWhite, GetGoldStr(g_ClientGuildInfo.nGuildMoney));

        TextOut(ax + 77, ay + 315, clWhite, IntToStr(g_ClientGuildInfo.nBuildPoint));
        TextOut(ax + 77, ay + 335, clWhite, IntToStr(g_ClientGuildInfo.nFlourishingPoint));
        TextOut(ax + 77, ay + 355, clWhite, IntToStr(g_ClientGuildInfo.nStabilityPoint));
        TextOut(ax + 77, ay + 375, clWhite, IntToStr(g_ClientGuildInfo.nActivityPoint) + '/' + IntToStr(g_ClientGuildInfo.nMaxActivityPoint));

        TextOut(ax + 114, ay + 438, clWhite, IntToStr(g_ClientGuildInfo.btKickMonExp) + '%');
        TextOut(ax + 114, ay + 458, clWhite, IntToStr(g_ClientGuildInfo.btKickMonAttack) + '%');
{$IFEND}


      end
      else if Sender = DGuildAllyDlg then begin
        DGDAllyAdd.Visible := (g_ClientGuildInfo.btMyRank = 1);
        DGDBreakAlly.Visible := (g_ClientGuildInfo.btMyRank = 1);
{$IF Var_Interface = Var_Mir2}
         for i := DGuildAllyUpDown.Position to DGuildAllyUpDown.Position + 6 do begin
          if i >= GuildAllyList.Count then break;
          ny := (i - DGuildAllyUpDown.Position) * 16 + ay + 53;
          if i = GuildAllyMoveIndex then begin
            FillRect(ax + 6, ny - 2, 227, 16, $A062625A);
          end
          else if i = GuildAllySelectIndex then begin
            FillRect(ax + 6, ny - 2, 227, 16, $C862625A);
          end;
          GuildSocietyInfo := pTGuildSocietyInfo(GuildAllyList[i]);
          TextOut(ax + 11, ny, $00C5D2BD, GuildSocietyInfo.sGuildName);
          TextOut(ax + 108, ny, $00C5D2BD, GuildSocietyInfo.sUserName);
          TextOut(ax + 214, ny, $00C5D2BD, IntToStr(GuildSocietyInfo.btLevel));
        end;
        for i := DGuildWarUpDown.Position to DGuildWarUpDown.Position + 6 do begin
          if i >= GuildWarList.Count then
            break;
          ny := (i - DGuildWarUpDown.Position) * 16 + ay + 250;
          if i = GuildWarMoveIndex then begin
            FillRect(ax + 6 + Left, ny - 2, 227, 16, $A062625A);
          end
          else if i = GuildWarSelectIndex then begin
            FillRect(ax + 6 + Left, ny - 2, 227, 16, $C862625A);
          end;
          GuildSocietyInfo := pTGuildSocietyInfo(GuildWarList[i]);
          TextOut(ax + 11, ny, $00C5D2BD, GuildSocietyInfo.sGuildName);
          TextOut(ax + 108, ny, $00C5D2BD, GuildSocietyInfo.sUserName);
          TextOut(ax + 214, ny, $00C5D2BD, IntToStr(GuildSocietyInfo.btLevel));
        end;
{$ELSE}
         for i := DGuildAllyUpDown.Position to DGuildAllyUpDown.Position + 8 do begin
          if i >= GuildAllyList.Count then break;
          ny := (i - DGuildAllyUpDown.Position) * 16 + ay + Top + 49;
          if i = GuildAllyMoveIndex then begin
            FillRect(ax + 9 + Left, ny - 2, 256, 16, $A062625A);
          end
          else if i = GuildAllySelectIndex then begin
            FillRect(ax + 9 + Left, ny - 2, 256, 16, $C862625A);
          end;
          GuildSocietyInfo := pTGuildSocietyInfo(GuildAllyList[i]);
          TextOut(ax + Left + 18, ny, $00C5D2BD, GuildSocietyInfo.sGuildName);
          TextOut(ax + Left + 122, ny, $00C5D2BD, GuildSocietyInfo.sUserName);
          TextOut(ax + Left + 241, ny, $00C5D2BD, IntToStr(GuildSocietyInfo.btLevel));
        end;
        for i := DGuildWarUpDown.Position to DGuildWarUpDown.Position + 7 do begin
          if i >= GuildWarList.Count then
            break;
          ny := (i - DGuildWarUpDown.Position) * 16 + ay + Top + 280;
          if i = GuildWarMoveIndex then begin
            FillRect(ax + 9 + Left, ny - 2, 256, 16, $A062625A);
          end
          else if i = GuildWarSelectIndex then begin
            FillRect(ax + 9 + Left, ny - 2, 256, 16, $C862625A);
          end;
          GuildSocietyInfo := pTGuildSocietyInfo(GuildWarList[i]);
          TextOut(ax + Left + 18, ny, $00C5D2BD, GuildSocietyInfo.sGuildName);
          TextOut(ax + Left + 122, ny, $00C5D2BD, GuildSocietyInfo.sUserName);
          TextOut(ax + Left + 241, ny, $00C5D2BD, IntToStr(GuildSocietyInfo.btLevel));
        end;
{$IFEND}
      end;
    end;
  end;
end;

procedure TFrmDlg3.DGuildAllyDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  GuildAllyMoveIndex := -1;
  GuildWarMoveIndex := -1;
  with Sender as TDWindow do begin
    Dec(x, left);
    Dec(y, Top);
{$IF Var_Interface = Var_Mir2}
    if (X >= 6) and (Y >= 53) and (x <= 6 + 227) and (y <= 53 + 114) then begin
      GuildAllyMoveIndex := (Y - 53) div 16 + DGuildAllyUpDown.Position;
    end
    else if (X >= 6) and (Y >= 250) and (x <= 6 + 227) and (y <= 250 + 114) then begin
      GuildWarMoveIndex := (Y - 250) div 16 + DGuildWarUpDown.Position;
    end;
{$ELSE}
    if (X >= 8) and (Y >= 47) and (x <= 8 + 258) and (y <= 47 + 144) then begin 
      GuildAllyMoveIndex := (Y - 47) div 16 + DGuildAllyUpDown.Position;
    end
    else if (X >= 8) and (Y >= 278) and (x <= 8 + 258) and (y <= 278 + 128) then begin
      GuildWarMoveIndex := (Y - 278) div 16 + DGuildWarUpDown.Position;
    end;
{$IFEND}
  end;
end;

procedure TFrmDlg3.DGuildAllyDlgMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  SocietyList: TList;
  GuildSocietyInfo: pTGuildSocietyInfo;
  nIndex: Integer;
  boAlly: Boolean;
begin
  with Sender as TDWindow do begin
    Dec(x, left);
    Dec(y, Top);
{$IF Var_Interface = Var_Mir2}
    if (X >= 6) and (Y >= 53) and (x <= 6 + 227) and (y <= 53 + 114) then begin 
{$ELSE}
    if (X >= 8) and (Y >= 47) and (x <= 8 + 258) and (y <= 47 + 144) then begin  
{$IFEND}
      nIndex := GuildAllyMoveIndex;
      SocietyList := GuildAllyList;
      boAlly := True;
    end
{$IF Var_Interface = Var_Mir2}
    else if (X >= 6) and (Y >= 250) and (x <= 6 + 227) and (y <= 250 + 114) then begin
{$ELSE}
    else if (X >= 8) and (Y >= 278) and (x <= 8 + 258) and (y <= 278 + 128) then begin
{$IFEND}
      nIndex := GuildWarMoveIndex;
      SocietyList := GuildWarList;
      boAlly := False;
    end
    else
      exit;
    if (mbRight = Button) and (nIndex > -1) and (nIndex < SocietyList.Count) then begin
      DPopUpMemuGuild.Visible := False;
      DPopUpMemuGuild.Item.Clear;
      GuildSocietyInfo := pTGuildSocietyInfo(SocietyList[nIndex]);
      if boAlly then
        AppendData := Pointer(nIndex)
      else
        AppendData := Pointer(nIndex + 100000);
      DPopUpMemuGuild.Item.AddObject('行会: ' + GuildSocietyInfo.sGuildName, TObject(-1));
      DPopUpMemuGuild.Item.AddObject('-', nil);
      if boAlly then begin
        if (g_ClientGuildInfo.btMyRank = 1) then
          DPopUpMemuGuild.Item.AddObject('取消联盟', TObject(52))
        else
          DPopUpMemuGuild.Item.AddObject('取消联盟', nil);
      end;
      DPopUpMemuGuild.Item.AddObject('复制掌门名称', TObject(53));
      DPopUpMemuGuild.Item.AddObject('复制行会名称', TObject(54));
      DPopUpMemuGuild.RefSize;
      DPopUpMemuGuild.Popup(Sender, SurfaceX(X + left), SurfaceY(Y + Top), GuildSocietyInfo.sGuildName);
    end;
  end;
end;

procedure TFrmDlg3.DGuildDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      DrawWindow(DSurface, ax, ay, d);
    end;
{$IF Var_Interface = Var_Default}
    with g_DXCanvas do begin
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
    end;
{$IFEND}
    DGDAddMem.Visible := not DMemoGuildMember.Visible;
    DGDDelMem.Visible := not DMemoGuildMember.Visible;
    DGDEditFind.Enabled := (not DMemoGuildMember.Visible) and (DEditFind.Text <> '');
    DCheckBoxShowMember.Enabled := not DMemoGuildMember.Visible;
    if DMemoGuildMember.Visible then begin
{$IF Var_Interface = Var_Mir2}
      DGDEditGrade.SetImgIndex(g_WMain99Images, 1689);
      DGDEditRefMemberList.SetImgIndex(g_WMain99Images, 1687);
{$ELSE}
      DGDEditGrade.Caption := '取消编辑';
      DGDEditRefMemberList.Caption := '保存编辑';  
{$IFEND}

      DGDEditRefMemberList.Enabled := True;
    end
    else begin
{$IF Var_Interface = Var_Mir2}
      DGDEditGrade.SetImgIndex(g_WMain99Images, 1675);
      DGDEditRefMemberList.SetImgIndex(g_WMain99Images, 1673);

      DGDEditGrade.Visible := (g_ClientGuildInfo.btMyRank = 1);
      DGDAddMem.Visible := g_ClientGuildInfo.btMyRank in [1..3];
      DGDDelMem.Visible := g_ClientGuildInfo.btMyRank = 1;
{$ELSE}
      DGDEditGrade.Caption := '编辑封号';
      DGDEditRefMemberList.Caption := '刷新列表';

{$IFEND}
      DGDEditRefMemberList.Enabled := GetTickCount > GuildRefMemberTick;
      DGDEditGrade.Enabled := (g_ClientGuildInfo.btMyRank = 1) and (GetTickCount > GuildSaveMemberTick);
      DGDAddMem.Enabled := g_ClientGuildInfo.btMyRank in [1..3];
      DGDDelMem.Enabled := g_ClientGuildInfo.btMyRank = 1;
    end;
  end;
end;

procedure TFrmDlg3.DGuildDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  GuildMoveIndex := -1;
end;

procedure TFrmDlg3.DGuildDlgVisible(Sender: TObject; boVisible: Boolean);
begin
  if boVisible then begin
    DMemoGuildNotice.ReadOnly := True;
    DMemoGuildMember.Visible := False;
    DUpDownGuildMember.Visible := False;
    GuildMoveIndex := -1;
    GuildSelectIndex := -1;
  end;
end;

procedure TFrmDlg3.DGuildInfoDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
  nX, nY: Integer;
begin
  with Sender as TDControl do begin
    nX := SurfaceX(Left + (X - Left - 20));
    ny := SurfaceY(Top + (y - Top) + 30);
    x := x - Left;
    y := y - Top;
    ShowMsg := '';
    if (x >= 12) and (y >= 243) and (x <= 12 + 144) and (y <= 243 + 16) then begin
      ShowMsg := '可以通行使用道具来增加行会建设值\';
      ShowMsg := ShowMsg + '道具可以从商城购买或者杀怪获得\';
    end else
    if (x >= 12) and (y >= 263) and (x <= 12 + 144) and (y <= 263 + 16) then begin
      ShowMsg := '行会所有成员每消灭100只怪物增加1点繁荣值\';
    end else
    if (x >= 12) and (y >= 283) and (x <= 12 + 144) and (y <= 283 + 16) then begin
      ShowMsg := '行会所有成员每天上线可以增加1点安定值\';
      ShowMsg := ShowMsg + '<每个人物每天只能增加一次/FCOLOR=$FFFF>';
    end else
    if (x >= 12) and (y >= 303) and (x <= 12 + 144) and (y <= 303 + 16) then begin
      ShowMsg := '行会每1个小时减少3点人气值\';
      ShowMsg := ShowMsg + '行会成员每在线1个小时增加10点人气值\';
      ShowMsg := ShowMsg + '<当人气值为0时，系统将强制解散该行会/FCOLOR=$FFFF>';
    end else
    if (x >= 12) and (y >= 366) and (x <= 12 + 144) and (y <= 366 + 16) then begin
      ShowMsg := '杀怪可以额外获得的经验值奖励\';
      ShowMsg := ShowMsg + '可以通行提升行会等级来增加获得比例\';
    end else
    if (x >= 12) and (y >= 386) and (x <= 12 + 144) and (y <= 386 + 16) then begin
      ShowMsg := '杀怪可以额外获得的攻击力加成\';
      ShowMsg := ShowMsg + '可以通行提升行会等级来增加获得比例\';
      ShowMsg := ShowMsg + '<该加成对人物或人物下属无效/FCOLOR=$FFFF>\';
    end;
    if ShowMsg <> '' then
      DScreen.ShowHint(nX, nY, ShowMsg, clWhite, False, Integer(Sender));
  end;
end;

procedure TFrmDlg3.DGuildLogNoticeDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
  FColor: TColor;
  nTop: Byte;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := FaceIndex;
      FColor := DFMoveColor;
      nTop := 1;
      if GuildNoticeIndex <> tag then begin
        FColor := DFColor;
        nTop := 1;
        if MouseEntry = msIn then
          Inc(idx, 2)
        else
          Inc(idx, 1);
      end;
      d := WLib.Images[idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      with g_DXCanvas do begin
        TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2,
          SurfaceY(Top) + (Height - TextHeight(Caption)) div 2 + nTop,
          Caption, FColor);
      end;
    end;
  end;
end;

procedure TFrmDlg3.DGuildMemberDlgClick(Sender: TObject; X, Y: Integer);
begin
  GuildSelectIndex := -1;
  with Sender as TDWindow do begin
    Dec(Y, Top);
    if (Y >= 21) then begin
      GuildSelectIndex := (Y - 21) div 16 + DGuildMemberUpDown.Position;
    end;
  end;
end;

procedure TFrmDlg3.DGuildMemberDlgDblClick(Sender: TObject);
var
  MemberList: TQuickStringPointerList;
  GuildMemberInfo: pTGuildMemberInfo;
begin
  with Sender as TDWindow do begin
    if DCheckBoxShowMember.Checked then
      MemberList := GuildMemberList
    else
      MemberList := GuildOnLineMemberList;
    if (GuildSelectIndex > -1) and (GuildSelectIndex < MemberList.Count) then begin
      GuildMemberInfo := pTGuildMemberInfo(MemberList.Objects[GuildSelectIndex]);
      if GuildMemberInfo.nTime = -1 then
        PlayScene.SetEditChar(GuildMemberInfo.UserName);
    end;
  end;
end;

procedure TFrmDlg3.DGuildMemberDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay, nY, I: integer;
  str: string;
  MemberList: TQuickStringPointerList;
  GuildMemberInfo: pTGuildMemberInfo;
  FontColor: LongWord;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    with g_DXCanvas do begin
      if DCheckBoxShowMember.Checked then begin
        DGuildMemberUpDown.MaxPosition := GuildMemberList.Count - {$IF Var_Interface = Var_Default}20{$ELSE}17{$IFEND};
        MemberList := GuildMemberList;
      end
      else begin
        DGuildMemberUpDown.MaxPosition := GuildOnLineMemberList.Count - {$IF Var_Interface = Var_Default}20{$ELSE}17{$IFEND};
        MemberList := GuildOnLineMemberList;
      end;

      for i := DGuildMemberUpDown.Position to DGuildMemberUpDown.Position + {$IF Var_Interface = Var_Default}19{$ELSE}16{$IFEND} do begin
        if i >= MemberList.Count then break;
        nY := ay + 23 + (i - DGuildMemberUpDown.Position) * 16;
        if i = GuildMoveIndex then begin
          FillRect(ax + 1{ + Left}, ny - 2, Width {341}, 16, $A062625A);
        end
        else if i = GuildSelectIndex then begin
          FillRect(ax + 1{ + Left}, ny - 2, Width {341}, 16, $C862625A);
        end;
        GuildMemberInfo := pTGuildMemberInfo(MemberList.Objects[i]);
        if GuildMemberInfo.nTime = -1 then
          FontColor := $00C5D2BD
        else
          FontColor := $607275;
        TextOut(ax + 5, ny, FontColor, GetGuildJobName(GuildMemberInfo.btRank));
        TextOut(ax + {$IF Var_Interface = Var_Default}60{$ELSE}50{$IFEND}, ny, FontColor, GuildMemberInfo.RankName);
        TextOut(ax + {$IF Var_Interface = Var_Default}172{$ELSE}144{$IFEND}, ny, FontColor, GuildMemberInfo.UserName);
        if GuildMemberInfo.nTime = -1 then
          str := '在线'
        else if GuildMemberInfo.nTime = 0 then
          str := '今天'
        else if GuildMemberInfo.nTime = 1 then
          str := '昨天'
        else if GuildMemberInfo.nTime = 2 then
          str := '前天'
        else if GuildMemberInfo.nTime < 30 then
          str := IntToStr(GuildMemberInfo.nTime) + '天前'
        else if GuildMemberInfo.nTime < 60 then
          str := '上个月'
        else if GuildMemberInfo.nTime < 90 then
          str := '2个月前'
        else
          str := '很久以前';
        TextOut(ax + {$IF Var_Interface = Var_Default}293{$ELSE}266{$IFEND} - TextWidth(str) div 2, ny, FontColor, str);
      end;
    end;
  end;
end;

procedure TFrmDlg3.DGuildMemberDlgEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay: Integer;
begin
  if not DMemoGuildMember.Visible then
    exit;
  with Sender as TDWindow do begin
    {ax := SurfaceX(0);
    ay := SurfaceY(0); }
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    g_DXCanvas.FillRect(SurfaceX(Left), SurfaceY(Top), Width, 48, $FF000000);
    g_DXCanvas.MoveTo(SurfaceX(Left), SurfaceY(Top + 47));
    g_DXCanvas.LineTo(SurfaceX(Left + Width), SurfaceY(Top + 47), $FF7A7872);
    with g_DXCanvas do begin
      TextOut(ax + 4, ay + 4, $A6A49F, '行会编号说明：');
      TextOut(ax + 4, ay + 18, $A6A49F, '#1     掌门人专用(最多1人)');
      TextOut(ax + 4, ay + 32, $A6A49F, '#2,#3  副掌门人专用(最多2人) 副掌门拥有收人权限');
    end;
  end;
end;

procedure TFrmDlg3.DGuildMemberDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  GuildMoveIndex := -1;
  with Sender as TDWindow do begin
    Dec(Y, Top);
    if (Y >= 21) then begin
      GuildMoveIndex := (Y - 21) div 16 + DGuildMemberUpDown.Position;
    end;
  end;
end;

procedure TFrmDlg3.DGuildMemberDlgMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  MemberList: TQuickStringPointerList;
  GuildMemberInfo: pTGuildMemberInfo;
begin
  with Sender as TDWindow do begin
    if DCheckBoxShowMember.Checked then
      MemberList := GuildMemberList
    else
      MemberList := GuildOnLineMemberList;
    if (mbRight = Button) and (GuildMoveIndex > -1) and (GuildMoveIndex < MemberList.Count) then begin
      DPopUpMemuGuild.Visible := False;
      DPopUpMemuGuild.Item.Clear;
      GuildMemberInfo := pTGuildMemberInfo(MemberList.Objects[GuildMoveIndex]);
      AppendData := Pointer(GuildMoveIndex);
      DPopUpMemuGuild.Item.AddObject('名称: ' + GuildMemberInfo.UserName, TObject(-1));
      DPopUpMemuGuild.Item.AddObject('-', nil);
      if (g_ClientGuildInfo.btMyRank = 1) and (GuildMemberInfo.UserName <> g_MySelf.m_UserName) then begin
        DPopUpMemuGuild.Item.AddObject('逐出行会', TObject(2));
      end
      else
        DPopUpMemuGuild.Item.AddObject('逐出行会', nil);

      if (GuildMemberInfo.nTime = -1) then
        DPopUpMemuGuild.Item.AddObject('进行私聊', TObject(3))
      else
        DPopUpMemuGuild.Item.AddObject('进行私聊', nil);
      if InFriendList(GuildMemberInfo.UserName) then
        DPopUpMemuGuild.Item.AddObject('发送信件', TObject(8))
      else
        DPopUpMemuGuild.Item.AddObject('发送信件', nil);

      if (GuildMemberInfo.nTime = -1) and (not InFriendList(GuildMemberInfo.UserName)) and
        (GuildMemberInfo.UserName <> g_MySelf.m_UserName) then
        DPopUpMemuGuild.Item.AddObject('加为好友', TObject(4))
      else
        DPopUpMemuGuild.Item.AddObject('加为好友', nil);

      if (GuildMemberInfo.nTime = -1) and (not InGroupList(GuildMemberInfo.UserName)) then
        DPopUpMemuGuild.Item.AddObject('邀请组队', TObject(5))
      else
        DPopUpMemuGuild.Item.AddObject('邀请组队', nil);
      DPopUpMemuGuild.Item.AddObject('-', nil);
      DPopUpMemuGuild.Item.AddObject('复制人物名称', TObject(6));
      DPopUpMemuGuild.Item.AddObject('复制行会封号', TObject(7));
      DPopUpMemuGuild.RefSize;
      DPopUpMemuGuild.Popup(Sender, SurfaceX(X), SurfaceY(Y), GuildMemberInfo.UserName);
    end;
  end;
end;

procedure TFrmDlg3.DItemUnsealArmClick(Sender: TObject; X, Y: Integer);
begin
  if FUnsealLock then
    exit;
  if not g_boItemMoving then begin
    if FUnsealItem.Item.s.Name <> '' then
      AddItemBag(FUnsealItem.Item, FUnsealItem.Index2);
    SafeFillChar(FUnsealItem, SizeOf(FUnsealItem), #0);
  end
  else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
    if (sm_ArmingStrong in g_MovingItem.Item.s.StdModeEx) or (sm_HorseArm in g_MovingItem.Item.s.StdModeEx) then begin
      if CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_Unknown) then begin
        if FUnsealItem.Item.s.Name <> '' then
          AddItemBag(FUnsealItem.Item, FUnsealItem.Index2);
        FUnsealItem := g_MovingItem;
        g_boItemMoving := False;
        g_MovingItem.Item.s.Name := '';
      end;
    end
    else begin
      FrmDlg.CancelItemMoving;
    end;
  end;
end;

procedure TFrmDlg3.DItemUnsealArmDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, px, py: integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if FUnSealItem.Item.s.Name <> '' then begin
      d := GetBagItemImg(FUnSealItem.Item.S.looks);
      if d <> nil then
        FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
          ax + (Width - d.Width) div 2,
          ay + (Height - d.Height) div 2,
          Width,
          Height,
          @FUnSealItem.Item, False);
    end
    else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
      if (sm_ArmingStrong in g_MovingItem.Item.s.StdModeEx) and
        CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_Unknown) then begin
        d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
        if d <> nil then
          DrawBlend(dsurface, SurfaceX(Left) - 12, SurfaceY(Top) - 11, d, 1);
      end;
    end;
    if FUnsealShowEffect then begin
      if GetTickCount >= FUnSealShowTick then begin
        FUnSealShowTick := GetTickCount + 80;
        Inc(FUnsealShowIndex);
      end;
      d := g_WMain99Images.GetCachedImage(1188 + FUnsealShowIndex, px, py);
      if d <> nil then
{$IF Var_Interface = Var_Mir2}
        dsurface.Draw(ax - Left + (19 + px), ay - Top + (-81 + py), d.ClientRect, d, True);
{$ELSE}
        dsurface.Draw(ax + px - 113, ay + py - 113, d.ClientRect, d, True);
{$IFEND}


      if FUnsealShowIndex >= 29 then begin
        FUnsealLock := False;
        FUnsealShowEffect := False;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DItemUnsealArmMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
begin
  with Sender as TDButton do begin
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX + 30;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    if FUnsealItem.Item.s.Name <> '' then
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(FUnsealItem.Item, [mis_ArmStrengthen], []),
        clwhite, False, Tag, True);
  end;
end;

procedure TFrmDlg3.DItemUnsealCloseClick(Sender: TObject; X, Y: Integer);
begin
  if FUnSealLock then
    exit;
  DWndItemUnseal.Visible := False;
end;

procedure TFrmDlg3.DItemUnsealItemsGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FUnsealLevel)..High(FUnsealLevel)] then begin
      if FUnsealLevel[idx].Item.S.name <> '' then begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(FUnsealLevel[idx].Item, [mis_ArmStrengthen], []), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg3.DItemUnsealItemsGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FUnsealLevel)..High(FUnsealLevel)] then begin
      if FUnsealLevel[idx].Item.S.name <> '' then begin
        d := GetBagItemImg(FUnsealLevel[idx].Item.S.looks);
        if d <> nil then begin
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @FUnsealLevel[idx].Item);
        end;
      end; { else
      if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
        if (tm_MakeStone = g_MovingItem.Item.s.StdMode) and (g_MovingItem.Item.s.Shape in [1, 2]) then begin
          d := g_WMain3Images.Images[600 + (gettickcount - AppendTick) div 200 mod 2];
          if d <> nil then
            DrawBlend(dsurface, SurfaceX(Rect.Left) - 11, SurfaceY(Rect.Top) - 11, d, 1);
        end;
      end; }
    end;
  end;
end;

procedure TFrmDlg3.DItemUnsealItemsGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  if FUnsealLock then
    exit;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FUnsealLevel)..High(FUnsealLevel)] then begin
      if not g_boItemMoving then begin
        if FUnsealLevel[idx].Item.s.Name <> '' then begin
          AddItemBag(FUnsealLevel[idx].Item, FUnsealLevel[idx].Index2);
          SafeFillChar(FUnsealLevel[idx], SizeOf(FUnsealLevel[idx]), #0);
        end;
      end
      else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
        if (sm_ArmingStrong in g_MovingItem.Item.s.StdModeEx) or
          ((tm_MakeStone = g_MovingItem.Item.s.StdMode) and (g_MovingItem.Item.s.Shape = 2)) then begin
          if FUnsealLevel[idx].Item.s.Name <> '' then begin
            AddItemBag(FUnsealLevel[idx].Item, FUnsealLevel[idx].Index2);
          end;
          FUnsealLevel[idx] := g_MovingItem;
          g_boItemMoving := False;
          g_MovingItem.Item.s.Name := '';
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DItemUnsealOKClick(Sender: TObject; X, Y: Integer);
var
  sSendMsg: string;
  Item: TMovingItem;
begin
  if FUnsealLock then
    exit;
  if (FUnsealItem.Item.s.Name <> '') and
    CheckItemBindMode(@FUnsealItem.Item.UserItem, bm_Unknown) then begin
    sSendMsg := '';
    for Item in FUnsealLevel do begin
      if Item.Item.s.Name <> '' then
        sSendMsg := sSendMsg + IntToStr(Item.Item.UserItem.MakeIndex) + '/';
    end;
    FUnsealLock := True;
    FrmMain.SendClientSocket(CM_UNSEAL, g_nCurMerchant,
      LoWord(FUnsealItem.Item.UserItem.MakeIndex),
      HiWord(FUnsealItem.Item.UserItem.MakeIndex),
      0,
      EncodeString(sSendMsg));
  end;
end;

procedure TFrmDlg3.DMakeItemArmingClick(Sender: TObject; X, Y: Integer);
begin
  if FMakeItemItem.Item.s.Name <> '' then begin
    AddItemBag(FMakeItemItem.Item);
    SafeFillChar(FMakeItemItem, SizeOf(FMakeItemItem), #0);
  end;
end;

procedure TFrmDlg3.DMakeItemArmingDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if FMakeItemItem.Item.s.Name <> '' then begin
      d := GetBagItemImg(FMakeItemItem.Item.S.looks);
      if d <> nil then
        FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
          ax + (Width - d.Width) div 2,
          ay + (Height - d.Height) div 2,
          ax + Width,
          ay + Height - 12,
          @FMakeItemItem.Item, True);
    end
    else if FMakeGoods.Item[0].s.name <> '' then begin
      d := GetBagItemImg(FMakeGoods.Item[0].S.looks);
      if d <> nil then
        FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
          ax + (Width - d.Width) div 2,
          ay + (Height - d.Height) div 2,
          Width,
          Height,
          @FMakeGoods.Item[0], False, [pmGrayScale]);
    end;
  end;
end;

procedure TFrmDlg3.DMakeItemArmingMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
begin
  with Sender as TDButton do begin
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX + 30;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    if FMakeItemItem.Item.s.Name <> '' then begin
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(FMakeItemItem.Item, [mis_ArmStrengthen], []),
        clwhite, False, Tag, True);
    end
    else if FMakeGoods.Item[0].s.Name <> '' then begin
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(FMakeGoods.Item[0], [], []),
        clwhite, False, Tag, True);
    end;
  end;
end;

procedure TFrmDlg3.DMakeItemAssGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FMakeItemAss)..High(FMakeItemAss)] then begin
      if FMakeItemAss[idx].Item.S.name <> '' then begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(FMakeItemAss[idx].Item, [mis_ArmStrengthen], []), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg3.DMakeItemAssGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FMakeItemAss)..High(FMakeItemAss)] then begin
      if FMakeItemAss[idx].Item.S.name <> '' then begin
        d := GetBagItemImg(FMakeItemAss[idx].Item.S.looks);
        if d <> nil then begin
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @FMakeItemAss[idx].Item);
        end;
      end
      else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
        if (tm_MakeStone = g_MovingItem.Item.s.StdMode) and (g_MovingItem.Item.s.Shape = 2) then begin
          d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
          if d <> nil then
            DrawBlend(dsurface, SurfaceX(Rect.Left) - 11, SurfaceY(Rect.Top) - 11, d, 1);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DMakeItemAssGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  if FMakeItemLock or (FMakeGoods.Item[0].s.Name = '') then
    exit;
  if FMakeItemItem.Item.s.Name <> '' then begin
    AddItemBag(FMakeItemItem.Item);
    SafeFillChar(FMakeItemItem, SizeOf(FMakeItemItem), #0);
  end;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FMakeItemAss)..High(FMakeItemAss)] then begin
      if not g_boItemMoving then begin
        if FMakeItemAss[idx].Item.s.Name <> '' then begin
          AddItemBag(FMakeItemAss[idx].Item, FMakeItemAss[idx].Index2);
          SafeFillChar(FMakeItemAss[idx], SizeOf(FMakeItemAss[idx]), #0);
          RefMakeItemRateInfo();
        end;
      end
      else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
        if (tm_MakeStone = g_MovingItem.Item.s.StdMode) and (g_MovingItem.Item.s.Shape = 2) then begin
          if FMakeItemAss[idx].Item.s.Name <> '' then begin
            AddItemBag(FMakeItemAss[idx].Item, FMakeItemAss[idx].Index2);
          end;
          FMakeItemAss[idx] := g_MovingItem;
          g_boItemMoving := False;
          g_MovingItem.Item.s.Name := '';
          RefMakeItemRateInfo();
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DMakeItemClose2Click(Sender: TObject; X, Y: Integer);
begin
  if FMakeItemLock then
    exit;
  DWndMakeItem.Visible := False;
end;

procedure TFrmDlg3.DMakeItemItemsGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + 1;
    if idx in [Low(FMakeItemLevel)..High(FMakeItemLevel)] then begin
      if FMakeItemLevel[idx].Item.S.name <> '' then begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(FMakeItemLevel[idx].Item, [mis_ArmStrengthen], []), clwhite, False, idx, True);
      end
      else if FMakeGoods.Item[idx].s.Name <> '' then begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(FMakeGoods.Item[idx], [], []), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg3.DMakeItemItemsGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + 1;
    if idx in [Low(FMakeItemLevel)..High(FMakeItemLevel)] then begin
      if FMakeItemLevel[idx].Item.S.name <> '' then begin
        d := GetBagItemImg(FMakeItemLevel[idx].Item.S.looks);
        if d <> nil then begin
          FrmDlg.RefItemPaint(dsurface, d,
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @FMakeItemLevel[idx].Item);
        end;
      end
      else if FMakeGoods.Item[idx].s.Name <> '' then begin
        d := GetBagItemImg(FMakeGoods.Item[idx].S.looks);
        if d <> nil then begin
          FrmDlg.RefItemPaint(dsurface, d,
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @FMakeGoods.Item[idx], True, [pmGrayScale]);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DMakeItemItemsGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
//  MovingItem: TMovingItem;
begin
  if FMakeItemLock then exit;
  if FMakeItemItem.Item.s.Name <> '' then begin
    AddItemBag(FMakeItemItem.Item);
    SafeFillChar(FMakeItemItem, SizeOf(FMakeItemItem), #0);
  end;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + 1;
    if idx in [Low(FMakeItemLevel)..High(FMakeItemLevel)] then begin
      if not g_boItemMoving then begin
        if FMakeItemLevel[idx].Item.s.Name <> '' then begin
          AddItemBag(FMakeItemLevel[idx].Item, FMakeItemLevel[idx].Index2);
          SafeFillChar(FMakeItemLevel[idx], SizeOf(FMakeItemLevel[idx]), #0);
          RefMakeItemRateInfo();
        end;
      end
      else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
        if (FMakeGoods.Item[idx].s.Name <> '') and (g_MovingItem.Item.s.Idx = FMakeGoods.Item[idx].s.Idx) then begin
          if (sm_Superposition in g_MovingItem.Item.s.StdModeEx) and (g_MovingItem.Item.s.DuraMax > 1) then begin
            if g_MovingItem.Item.UserItem.Dura < FMakeGoods.MakeItem.ItemArr[idx].wCount then begin
              FrmDlg.CancelItemMoving;
              FrmDlg.DMessageDlg('当前物品数量不足.', []);
              exit;
            end;
            {if g_MovingItem.Item.UserItem.Dura > FMakeGoods.MakeItem.ItemArr[idx].wCount then begin

              MovingItem := g_MovingItem;
              g_boItemMoving := False;
              g_MovingItem.Item.s.Name := '';
              if mrYes =
                FrmDlg.DMessageDlg('当前物品数量大于所需要的数量，是否继续？\（系统不会自动返还多余的数量）\（建议按住Shift+点击物品，拆分后再放置）', [mbYes, mbNo]) then begin
                FMakeItemLevel[idx] := MovingItem;
              end
              else begin
                if FMakeItemLevel[idx].Item.s.Name <> '' then begin
                  AddItemBag(FMakeItemLevel[idx].Item, FMakeItemLevel[idx].Index2);
                end;
                g_MovingItem := MovingItem;
                g_boItemMoving := True;
                FrmDlg.CancelItemMoving;
              end;
              exit;
            end;    }
          end;
          if FMakeItemLevel[idx].Item.s.Name <> '' then begin
            AddItemBag(FMakeItemLevel[idx].Item, FMakeItemLevel[idx].Index2);
          end;
          FMakeItemLevel[idx] := g_MovingItem;
          FMakeItemLevel[idx].wCount := FMakeGoods.MakeItem.ItemArr[idx].wCount;
          g_boItemMoving := False;
          g_MovingItem.Item.s.Name := '';
          RefMakeItemRateInfo();
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DMakeItemOKClick(Sender: TObject; X, Y: Integer);
var
  i: Integer;
  StrengthenItem: TStrengthenItem;
begin
  if FMakeItemLock or (FMakeGoods.Item[0].s.name = '') then
    exit;
  if FMakeItemItem.Item.s.Name <> '' then begin
    AddItemBag(FMakeItemItem.Item);
    SafeFillChar(FMakeItemItem, SizeOf(FMakeItemItem), #0);
  end;
  for I := 1 to 5 do begin
    if (FMakeGoods.Item[I].s.Name <> '') then begin
      if FMakeItemLevel[I].Item.s.Name = '' then begin
        FrmDlg.DMessageDlg('打造所需要的材料不足.', []);
        exit;
      end;
    end;
  end;
  for I := 0 to 4 do begin
    if FMakeItemLevel[I + 1].Item.s.name <> '' then begin
      StrengthenItem.nLevelIdx[I] := FMakeItemLevel[I + 1].Item.UserItem.MakeIndex;
    end;
  end;
  for I := 0 to 4 do begin
    if FMakeItemAss[I].Item.s.name <> '' then
      StrengthenItem.nAssIdx[I] := FMakeItemAss[I].Item.UserItem.MakeIndex;
  end;
  FMakeItemLock := True;
  if FMakeMagicShow then
    FrmMain.SendClientSocket(CM_USERMAKEDRUGITEM, -1, FMakeMagicIdx, Integer(FMakeAutoMake and DMakeMagicxAutoMake.Checked), FMakeGoods.nID,
      EncodeBuffer(@StrengthenItem, SizeOf(StrengthenItem)))
  else
    FrmMain.SendClientSocket(CM_USERMAKEDRUGITEM, g_nCurMerchant, 0, Integer(FMakeAutoMake and DMakeMagicxAutoMake.Checked), FMakeGoods.nID,
      EncodeBuffer(@StrengthenItem, SizeOf(StrengthenItem)));
end;

procedure TFrmDlg3.DMakeItemTreeViewTreeClearItem(Sender: TObject; DTreeNodes: pTDTreeNodes);
begin
  if DTreeNodes.Item <> nil then begin
    Dispose(pTClientMakeGoods(DTreeNodes.Item));
    DTreeNodes.Item := nil;
  end;
end;

procedure TFrmDlg3.DMakeItemTreeViewTreeViewSelect(Sender: TObject; DTreeNodes: pTDTreeNodes);
var
  idx: Integer;
begin
  if DTreeNodes.Item <> nil then begin
    FMakeGoods := pTClientMakeGoods(DTreeNodes.Item)^;
    ClearMakeItemInfo;
    for idx := Low(FMakeItemLevel) to High(FMakeItemLevel) do begin
      if FMakeGoods.Item[idx].s.Name <> '' then begin
        if (sm_Superposition in FMakeGoods.Item[idx].s.StdModeEx) and (FMakeGoods.Item[idx].s.DuraMax > 1) then Continue;
        DMakeMagicxAutoMake.Visible := False;
        FMakeAutoMake := False;
        Exit;
      end;
    end;
    DMakeMagicxAutoMake.Visible := True;
    FMakeAutoMake := True;
  end;
end;

procedure TFrmDlg3.DPopUpMemuGuildPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
var
  MemberList: TStringList;
  GuildMemberInfo: pTGuildMemberInfo;
  nIndex: Integer;
  SocietyList: TList;
  //data, sGuildName: string;
begin
  with DControl do begin
    case Integer(TDPopUpMemu(Sender).Item.Objects[ItemIndex]) of
      2: begin
          if mrYes = FrmDlg.DMessageDlg('是否确定删除行会成员[' + UserName + ']?', [mbYes, mbNo]) then begin
            frmMain.SendGuildDelMem(UserName);
          end;
        end;
      3: begin
          PlayScene.SetEditChar(UserName);
        end;
      4: begin
          FrmMain.SendClientMessage(CM_FRIEND_CHENGE, 0, 0, 0, 0, UserName);
        end;
      5: begin
          FrmDlg.CreateGroup(UserName);
        end;
      6: CopyStrToClipboard(UserName);
      7: begin
          if DCheckBoxShowMember.Checked then
            MemberList := GuildMemberList
          else
            MemberList := GuildOnLineMemberList;
          nIndex := Integer(AppendData);
          if (nIndex > -1) and (nIndex < MemberList.Count) then begin
            GuildMemberInfo := pTGuildMemberInfo(MemberList.Objects[nIndex]);
            if GuildMemberInfo.UserName = UserName then begin
              CopyStrToClipboard(GuildMemberInfo.RankName);
            end;
          end;
        end;
      8: begin
          FrmDlg2.OpenNewMail(UserName);
        end;
      10: frmMain.SendSay(g_Cmd_AuthCancel + ' ' + UserName);
      52: begin
          if FrmDlg.DMessageDlg('是否确定取消与[' + UserName + ']的联盟？', [mbOk, mbCancel]) = mrOk then begin
            frmMain.SendSay(g_Cmd_AuthCancel + ' ' + UserName);
          end;
        end;
      53: begin
          nIndex := Integer(AppendData);
          if nIndex < 100000 then begin
            SocietyList := GuildAllyList;
          end
          else begin
            SocietyList := GuildWarList;
            Dec(nIndex, 100000);
          end;
          if (nIndex > -1) and (nIndex < SocietyList.Count) then
            CopyStrToClipboard(pTGuildSocietyInfo(SocietyList[nIndex]).sUserName);
        end;
      54: CopyStrToClipboard(UserName);
    end;
  end;
end;

procedure TFrmDlg3.DTopButton0Click(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if (not FboTopSend) and (FTopIndex <> Tag) then begin
      FTopIndex := Tag;
      PlaySound(s_norm_button_click);
      FnMaxTopPage := 0;
      FnMinTopPage := 0;
      FrmMain.SendClientMessage(CM_GETTOPINFO, FTopIndex, 0, 0, 0, '');
      FboTopSend := True;
    end;
  end;
end;

procedure TFrmDlg3.DTopButton0DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDirectDrawSurface;
{$IF Var_Interface = Var_Default}
  FColor: TColor;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if FTopIndex <> tag then begin
        d := WLib.Images[FaceIndex + 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top) + 2, d.ClientRect, d, True);
        with g_DXCanvas do begin
          TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2, SurfaceY(Top) + (Height - TextHeight(Caption)) div 2 + 1, Caption, DFColor);
        end;
      end else begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        with g_DXCanvas do begin
          TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2, SurfaceY(Top) + (Height - TextHeight(Caption)) div 2, Caption, clWhite);
        end;
      end;
    end;
  end;
{$ELSE}
  with Sender as TDButton do begin
    if (FTopIndex = Tag) then begin
      d := WLib.Images[FaceIndex + 3];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      FColor := DFEnabledColor;
    end
    else if Downed then begin
      d := WLib.Images[FaceIndex + 2];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      FColor := DFDownColor;
    end
    else if MouseEntry = msIn then begin
      d := WLib.Images[FaceIndex + 1];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      FColor := DFMoveColor;
    end
    else begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      FColor := DFColor;
    end;
    with g_DXCanvas do begin
      TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2,
        SurfaceY(Top) + (Height - TextHeight(Caption)) div 2, Caption, FColor);
    end;
  end;  
{$IFEND}

end;

procedure TFrmDlg3.DTopFirstClick(Sender: TObject; X, Y: Integer);
begin
  if FboTopSend then Exit;

  if Sender = DTopFirst then begin
    if FnMinTopPage > 0 then begin
      FrmMain.SendClientMessage(CM_GETTOPINFO, FTopIndex, 0, 0, 0, '');
      FboTopSend := True;
    end;
  end else
  if Sender = DTopUp then begin
    if FnMinTopPage > 0 then begin
      FrmMain.SendClientMessage(CM_GETTOPINFO, FTopIndex, FnMinTopPage - 1, 0, 0, '');
      FboTopSend := True;
    end;
  end else
  if Sender = DTopDown then begin
    if FnMinTopPage < (FnMaxTopPage - 1) then begin
      FrmMain.SendClientMessage(CM_GETTOPINFO, FTopIndex, FnMinTopPage + 1, 0, 0, '');
      FboTopSend := True;
    end;
  end else
  if Sender = DTopLastly then begin
    if FnMinTopPage < (FnMaxTopPage - 1) then begin
      FrmMain.SendClientMessage(CM_GETTOPINFO, FTopIndex, FnMaxTopPage - 1, 0, 0, '');
      FboTopSend := True;
    end;
  end else
  if Sender = DTopMy then begin
    FrmMain.SendClientMessage(CM_GETTOPINFO, FTopIndex, 0, 0, 1, '');
    FboTopSend := True;
  end;

end;

procedure TFrmDlg3.DTopList1Click(Sender: TObject; X, Y: Integer);
begin
  if FTopMoveIndex in [Low(FTopInfo)..High(FTopInfo)] then begin
    if FTopInfo[FTopMoveIndex].sChrName <> '' then begin
      PlaySound(s_glass_button_click);
      PlayScene.SetEditChar(FTopInfo[FTopMoveIndex].sChrName);
    end;
  end;
end;

procedure TFrmDlg3.DTopList1DirectPaint(Sender: TObject; dsurface: TDXTexture);
const
  JobName: array[0..2] of string[6] = ('战士', '魔法师', '道士');
  SexName: array[0..1] of string[2] = ('男', '女');
var
  ax, ay: integer;
  sTitle: string;
  I, n: Integer;
  d: TDXTexture;
  fColor: TColor;
begin
  if g_MySelf = nil then Exit;

  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    with g_DXCanvas do begin
      n := FTopMoveIndex;
      if Tag = 0 then begin
        if n >= 0 then begin
          if n < 10 then begin
            FillRect(ax + 1, ay + 4 + 16 * n, Width - 2, 16, $A062625A);
          end;
        end;
      end else begin
        Dec(n, 10);
        if (n >= 0) and (n < 10) then begin
          FillRect(ax + 1, ay + 4 + 16 * n, Width - 2, 16, $A062625A);
        end;
      end;
      for I := 0 to 9 do begin
        n := I + Tag * 10;
        if FTopInfo[n].sChrName = '' then break;
        fColor := clWhite;
        if FTopInfo[n].sChrName = g_MySelf.m_UserName then fColor := clYellow;
        
        if (FnMinTopPage = 0) and (n in [0..2]) then begin
          d := g_WMain99Images.Images[1454 + n];
          if d <> nil then DrawWindow(dsurface, ax + 11, ay + 6 + 16 * i, d)
          else TextOut(ax + 18 - TextWidth(IntToStr(n + 1)) div 2, ay + 6 + 16 * i, fColor, IntToStr(n + 1));
        end else
          TextOut(ax + 18 - TextWidth(IntToStr(n + FnMinTopPage * 20 + 1)) div 2, ay + 6 + 16 * i, fColor, IntToStr(n + FnMinTopPage * 20 + 1));

        TextOut(ax + 82 - TextWidth(FTopInfo[n].sChrName) div 2, ay + 6 + 16 * i, fColor, FTopInfo[n].sChrName);
        TextOut(ax + 150 - TextWidth(JobName[FTopInfo[n].btJob]) div 2, ay + 6 + 16 * i, fColor, JobName[FTopInfo[n].btJob]);
        sTitle := IntToStr(FTopInfo[n].dwCount);
        TextOut(ax + 208 - TextWidth(sTitle) div 2, ay + 6 + 16 * i, fColor, sTitle);
      end;
    end;
  end;
end;

procedure TFrmDlg3.DTopList1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  FTopMoveIndex := -1;
  with Sender as TDWindow do begin
    Dec(y, Top);
    FTopMoveIndex := (Y - 4) div 16;
    if Tag = 0 then begin
      if FTopMoveIndex > 9 then FTopMoveIndex := -1;
    end else begin
      Inc(FTopMoveIndex, 10);
    end;
  end;
end;

procedure TFrmDlg3.DTrvwMissionTreeViewSelect(Sender: TObject; DTreeNodes: pTDTreeNodes);
begin
  if DTreeNodes.Item <> nil then begin
    ShowMissionDlg(pTClientMissionInfo(DTreeNodes.Item));
    ShowCanAccept := False;
    MDlgChange := False;
  end;
end;

procedure TFrmDlg3.DWindowTopDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  sTitle: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);

    DTopFirst.Enabled := FnMinTopPage > 0;
    DTopUp.Enabled := FnMinTopPage > 0;
    DTopDown.Enabled := FnMinTopPage < (FnMaxTopPage - 1);
    DTopLastly.Enabled := FnMinTopPage < (FnMaxTopPage - 1);
    with g_DXCanvas do begin
      sTitle := IntToStr(FnMinTopPage + 1) + '/' + IntToStr(FnMaxTopPage);
{$IF Var_Interface = Var_Mir2}
      TextOut(ax + 197 - (TextWidth(sTitle) div 2), ay + 319, clWhite, sTitle);
{$ELSE}
      TextOut(ax + 206 - (TextWidth(sTitle) div 2), ay + 349, clWhite, sTitle);
{$IFEND}

      sTitle := '';
      case FTopIndex of
        0..3:sTitle := '等级';
        4: sTitle := '攻击';
        5: sTitle := '魔法';
        6: sTitle := '道术';
        7: sTitle := '金币';
        8: sTitle := '收徒数量';
        9: sTitle := '文采';
        10: sTitle := '完成次数';
        11: sTitle := '完成次数';
        12: sTitle := '声望';
        13: sTitle := 'PK值';
      end;
{$IF Var_Interface = Var_Mir2}
      TextOut(ax + 41, ay + 90, $33FFCC, '排名');
      TextOut(ax + 93, ay + 90, $33FFCC, '人物名称');
      TextOut(ax + 173, ay + 90, $33FFCC, '职业');
      TextOut(ax + 243 - TextWidth(sTitle) div 2, ay + 90, $33FFCC, sTitle);

      TextOut(ax + 41 + 251, ay + 90, $33FFCC, '排名');
      TextOut(ax + 93 + 251, ay + 90, $33FFCC, '人物名称');
      TextOut(ax + 173 + 251, ay + 90, $33FFCC, '职业');
      TextOut(ax + 243 + 251 - TextWidth(sTitle) div 2, ay + 90, $33FFCC, sTitle);
{$ELSE}
      TextOut(ax + 38, ay + 137, $33FFCC, '排名');
      TextOut(ax + 90, ay + 137, $33FFCC, '人物名称');
      TextOut(ax + 170, ay + 137, $33FFCC, '职业');
      TextOut(ax + 240 - TextWidth(sTitle) div 2, ay + 137, $33FFCC, sTitle);

      TextOut(ax + 39 + 257, ay + 137, $33FFCC, '排名');
      TextOut(ax + 90 + 257, ay + 137, $33FFCC, '人物名称');
      TextOut(ax + 170 + 257, ay + 137, $33FFCC, '职业');
      TextOut(ax + 240 + 257 - TextWidth(sTitle) div 2, ay + 137, $33FFCC, sTitle);  
{$IFEND}

    end;
  end;
end;

procedure TFrmDlg3.DWindowTopMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  FTopMoveIndex := -1;
end;

procedure TFrmDlg3.DWindowTopVisible(Sender: TObject; boVisible: Boolean);
begin
  if boVisible then begin
    FTopMoveIndex := -1;
    if not FboTopSend then begin
      FnMaxTopPage := 0;
      FnMinTopPage := 0;
      FrmMain.SendClientMessage(CM_GETTOPINFO, FTopIndex, 0, 0, 0, '');
      FboTopSend := True;
    end;
  end;
end;

procedure TFrmDlg3.DWndArmStrengthenDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  //rc: TRect;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
      TextOut(ax + 36, ay + 37, $A6A49F, '强化装备所需玄晶(至少放置一块玄晶)');
      TextOut(ax + 36, ay + 100, $A6A49F, '强化装备的辅助材料(可以不放)');
      TextOut(ax + 176, ay + 182, $A6A49F, FStrengthenHint);

      TextOut(ax + 29, ay + 234, $A6A49F, '强化费用：');
      TextOut(ax + 29 + 60, ay + 234, clWhite, IntToStr(FStrengthenMoney) + g_sGoldName + ' （优先使用' + g_sBindGoldName + '）');

      TextOut(ax + 29, ay + 260, $A6A49F, '成功机率：');
      TextOut(ax + 29 + 60, ay + 260, clWhite, IntToStr(FStrengthenRate) + '%/' + IntToStr(FStrengthenMaxRate) + '%');

      TextOut(ax + 162, ay + 260, $A6A49F, '降级机率：');
      TextOut(ax + 162 + 60, ay + 260, clWhite, IntToStr(FStrengthenDownLevelRate) + '%');
{$ELSE}
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
      TextOut(ax + 66, ay + 62, $A6A49F, '强化装备需要的玄晶材料(至少需要放置1块玄晶)');
      TextOut(ax + 66, ay + 132, $A6A49F, '强化装备的辅助材料(可以不放)');
      TextOut(ax + 222, ay + 222, $A6A49F, FStrengthenHint);

      TextOut(ax + 41, ay + 274, $A6A49F, '强化费用：');
      TextOut(ax + 41 + 60, ay + 274, clWhite, IntToStr(FStrengthenMoney) + g_sGoldName + ' （优先使用' + g_sBindGoldName + '）');

      TextOut(ax + 41, ay + 299, $A6A49F, '成功机率：');
      TextOut(ax + 41 + 60, ay + 299, clWhite, IntToStr(FStrengthenRate) + '%/' + IntToStr(FStrengthenMaxRate) + '%');

      TextOut(ax + 223, ay + 299, $A6A49F, '降级机率：');
      TextOut(ax + 223 + 60, ay + 299, clWhite, IntToStr(FStrengthenDownLevelRate) + '%');
{$IFEND}

    end;

    DArmOK.Enabled := (FStrengthenRate > 0) and (not FStrengthenLock);
    DArmClose.Enabled := (not FStrengthenLock);

    if FStrengthenShowEffect then begin
      if GetTickCount > FStrengthenShowTick then begin
        FStrengthenShowTick := GetTickCount + 150;
        Inc(FStrengthenSchedulePosition);
      end;
      if FStrengthenShowEffectType = 1 then begin
        d := g_WMain99Images.Images[919 + FStrengthenSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
        if FStrengthenSchedulePosition >= 10 then begin
          FStrengthenShowEffect := False;
        end;
      end
      else begin
        d := g_WMain99Images.Images[929 + FStrengthenSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
        if FStrengthenSchedulePosition >= 5 then begin
          FStrengthenShowEffect := False;
        end;
      end;
    end
    else if FStrengthenShowSchedule then begin
      if GetTickCount > FStrengthenShowTick then begin
        if FStrengthenSchedulePosition = 0 then
          PlaySoundEx(bmg_Repair);
        FStrengthenShowTick := GetTickCount + 100;
        Inc(FStrengthenSchedulePosition);
      end;
      FStrengthenHint := '正在进行强化...';
      //g_DXCanvas.TextOut(ax + 11, ay + 326, $A6A49F, '正在进行打造，已完成 ' + IntToStr(FStrengthenSchedulePosition) + '%');

      {d := g_WMain99Images.Images[491];
      if d <> nil then begin
        rc := d.ClientRect;
        rc.Right := Round(rc.Right / (100 / FStrengthenSchedulePosition));
        dsurface.Draw(ax + 12, ay + 342, rc, d, FALSE);
      end;   }

      if FStrengthenSchedulePosition < 6 then begin
        d := g_WMain99Images.Images[800 + FStrengthenSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
        d := g_WMain99Images.Images[810 + FStrengthenSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
        d := g_WMain99Images.Images[820 + FStrengthenSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
        d := g_WMain99Images.Images[830 + FStrengthenSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
        d := g_WMain99Images.Images[840 + FStrengthenSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
      end else
      if FStrengthenSchedulePosition = 6 then begin
        FStrengthenSchedulePosition := 92;
      end;

      if FStrengthenSchedulePosition in [92..100] then begin
        d := g_WMain99Images.Images[850 + FStrengthenSchedulePosition - 92];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
      end;

      if FStrengthenSchedulePosition >= 100 then begin
        FStrengthenShowSchedule := False;
        FStrengthenLock := False;
        case FStrengthenLevelType of
          1: begin //成功
              FStrengthenHint := '恭喜，强化成功';
              //FStrengthenHint := '正在进行强化...';
              FStrengthenItem.Item.UserItem := FStrengthenUseItem;
              FStrengthenShowEffect := True;
              FStrengthenShowEffectType := 1;
              FStrengthenShowTick := GetTickCount;
              FStrengthenSchedulePosition := 0;
              PlaySoundEx(bmg_ItemLevel_OK);
              ClearStrengthenInfoEx;
              FStrengthenMoney := GetStrengthenMoney(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
              FStrengthenMaxRate := GetStrengthenMaxRate(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
            end;
          2: begin //破碎
              FStrengthenHint := '装备破碎了';
              SafeFillChar(FStrengthenItem, SizeOf(FStrengthenItem), #0);
              FStrengthenShowEffect := True;
              FStrengthenShowEffectType := 2;
              FStrengthenShowTick := GetTickCount;
              FStrengthenSchedulePosition := 0;
              PlaySoundEx(bmg_ItemLevel_Fail);
              ClearStrengthenInfoEx;
            end;
          3: begin //降级
              FStrengthenHint := '等级降低了';
              FStrengthenItem.Item.UserItem := FStrengthenUseItem;
              ClearStrengthenInfoEx;
              FStrengthenMoney := GetStrengthenMoney(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
              FStrengthenMaxRate := GetStrengthenMaxRate(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
            end;
          4: begin //无变化
              FStrengthenHint := '没有发生变化';
              ClearStrengthenInfoEx;
              FStrengthenMoney := GetStrengthenMoney(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
              FStrengthenMaxRate := GetStrengthenMaxRate(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
            end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DWndArmStrengthenVisible(Sender: TObject; boVisible: Boolean);
begin
  ClearStrengthenInfo();
  FrmDlg.LastestClickTime := GetTickCount;
  FStrengthenHint := '需要强化的装备';
  if boVisible then begin
    FrmDlg.boOpenItemBag := FrmDlg.DItemBag.Visible;
    FrmDlg.DItemBag.Visible := True;
    FrmDlg.DMerchantDlg.Visible := False;
  end
  else begin
    FrmDlg.DItemBag.Visible := FrmDlg.boOpenItemBag;
  end;
end;

procedure TFrmDlg3.dwndBoxDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  //rc: TRect;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
{$IF Var_Interface = Var_Default}
    with g_DXCanvas do begin
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
    end;
{$IFEND}
    dbtnBoxGetItem.Enabled := (not OpenBoxStop) and (not OpenGetItem) and (not OpenBoxMove){ and ((OpenGetItemIndex = 0) and (OpenBoxIndex = 0) or
      (OpenGetItemIndex > 0) and (OpenBoxIndex > 0))};
    //dbtnBoxGetItem.Enabled := (not OpenGetItem) and (not OpenBoxMove) and (OpenGetItemIndex = 0);
    dbtnBoxNext.Enabled := (not OpenGetItem) and (not OpenBoxStop) and (((not OpenBoxMove) and (OpenGetItemIndex <= 0)) or (OpenBoxMove and (OpenBoxMoveIndex > 18) and
      (OpenGetItemIndex > 0)));
    if OpenBoxMove then begin
      if (GetTickCount > OpenBoxMoveTick) then begin
        Inc(OpenBoxSelectIndex);
        if (OpenBoxSelectIndex > 8) or (OpenBoxSelectIndex < 1) then OpenBoxSelectIndex := 1;
        inc(OpenBoxMoveIndex);
        if OpenBoxStop then begin
          if (OpenBoxSelectIndex = OpenStopIndex) then begin
            OpenBoxMoveIndex := 1;
            OpenCanStop := True;
          end;
          if OpenCanStop then begin
            if OpenBoxMoveIndex < 5 then OpenBoxMoveTick := GetTickCount + LongWord(OpenBoxMoveIndex * 100)
            else begin
              OpenBoxStop := False;
              OpenBoxMove := False;
              OpenCanStop := False;
              dbtnBoxNext.Caption := '请领取奖励';
              dbtnBoxGetItem.Caption := '领取奖励';
            end;
          end else  OpenBoxMoveTick := GetTickCount + 50
        end else begin
          if OpenBoxMoveIndex < 4 then OpenBoxMoveTick := GetTickCount + LongWord((5 - OpenBoxMoveIndex) * 100)
          else OpenBoxMoveTick := GetTickCount + 50
        end;
      end;
    end;
    if OpenGetItem and OpenBoxShowEffect then begin
      if GetTickCount > OpenBoxEffectTick then begin
        OpenBoxEffectTick := GetTickCount + 150;
        Inc(OpenBoxEffectIdx);
      end;
      if OpenBoxEffectIdx = 10 then begin
        if OpenBoxItems[OpenBoxIndex + 8].ItemType <> bit_None then begin
          OpenBoxItems[OpenGetItemIndex] := OpenBoxItems[OpenBoxIndex + 8];
          OpenBoxItems[OpenBoxIndex + 8].ItemType := bit_None;
        end;
      end;
      if OpenBoxEffectIdx > 19 then begin
        OpenBoxShowEffect := False;
        OpenGetItem := False;
        OpenGetItemIndex := 0;
        dbtnBoxNext.Caption := '继续转动轮盘';
        dbtnBoxGetItem.Caption := '关闭轮盘';
      end;
    end;
  end;
end;

procedure TFrmDlg3.DWndItemUnsealDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
{$IF Var_Interface = Var_Default}
    with g_DXCanvas do begin
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
    end;
{$IFEND}
    DItemUnsealClose2.Enabled := not FUnsealLock;
    DItemUnsealOK.Enabled := (FUnsealItem.Item.s.Name <> '') and (not FUnsealLock) and CheckItemBindMode(@FUnsealItem.Item.UserItem, bm_Unknown);
    {FUnsealLock := True;
    FUnsealShowEffect := True;
    FUnsealShowIndex := 0;
    FUnSealShowTick := GetTickCount; }
  end;
end;

procedure TFrmDlg3.DWndItemUnsealVisible(Sender: TObject; boVisible: Boolean);
begin
  {SafeFillChar(FMakeGoods, SizeOf(FMakeGoods), #0);
  ClearMakeItemInfo;   }
  ClearUnSealInfo();
  FrmDlg.LastestClickTime := GetTickCount;
  if boVisible then begin
    FrmDlg.boOpenItemBag := FrmDlg.DItemBag.Visible;
    FrmDlg.DItemBag.Visible := True;
    FrmDlg.DMerchantDlg.Visible := False;
  end
  else begin
    FrmDlg.DItemBag.Visible := FrmDlg.boOpenItemBag;
    //FrmDlg.DMerchantDlg.Visible := FrmDlg.MDlgVisible;
  end;
end;

procedure TFrmDlg3.DWndMakeItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  boMake: Boolean;
//  rc: TRect;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);

    if g_MySelf = nil then Exit;
    boMake := True;
    with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
      TextOut(ax + 190, ay + 37, $A6A49F, '打造物品所需要的材料');
      TextOut(ax + 190, ay + 100, $A6A49F, '打造物品的辅助材料(可以不放)');
      if FMakeMagicShow and (g_MySelf.m_Abil.Level < FMakeGoods.wLevel) then begin
        TextOut(ax + 330, ay + 174, clRed, '您的等级不够');
        TextOut(ax + 330, ay + 189, clRed, '需要人物等级：' + IntToStr(FMakeGoods.wLevel) + '级');
        boMake := False;
      end else
      if FMakeMagicShow and (g_MakeMagic[FMakeMagicIdx] < FMakeGoods.btLevel) then begin
        TextOut(ax + 330, ay + 174, clRed, '您的' + MakeMagicName[FMakeMagicIdx] + '等级不够');
        TextOut(ax + 330, ay + 189, clRed, '需要等级：' + IntToStr(FMakeGoods.btLevel) + '级');
        boMake := False;
      end else begin
        if FMakeItemHint2 <> '' then begin
          TextOut(ax + 330, ay + 181 - 7, $A6A49F, FMakeItemHint);
          TextOut(ax + 330, ay + 181 + 7, $A6A49F, FMakeItemHint2);
        end
        else begin
          TextOut(ax + 330, ay + 181, $A6A49F, FMakeItemHint{'打造成功后得到的物品'});
        end;

      end;

      TextOut(ax + 195, ay + 222, $A6A49F, '打造费用：'); //FMakeItemRate
      TextOut(ax + 195, ay + 248, $A6A49F, '成功机率：');

      if FMakeGoods.Item[0].s.name <> '' then begin
        TextOut(ax + 255, ay + 222, clWhite, IntToStr(FMakeGoods.MakeItem.nMoney) + g_sGoldName + ' （优先使用' + g_sBindGoldName + '）');
        if FMakeItemRate < 0 then
          TextOut(ax + 255, ay + 248, clWhite, '未知（需要先放置矿石）')
        else
          TextOut(ax + 255, ay + 248, clWhite,
            IntToStr(_MIN(FMakeGoods.MakeItem.btRate + FMakeItemRate, FMakeGoods.MakeItem.btMaxRate)) + '%/' +
            IntToStr(FMakeGoods.MakeItem.btMaxRate) + '%');


      end;
{$ELSE}
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
      TextOut(ax + 66 + 148, ay + 62, $A6A49F, '打造物品所需要的材料');
      TextOut(ax + 66 + 148, ay + 132, $A6A49F, '打造物品的辅助材料(可以不放)');
      if FMakeMagicShow and (g_MySelf.m_Abil.Level < FMakeGoods.wLevel) then begin
        TextOut(ax + 222 + 148, ay + 222 - 7, clRed, '您的等级不够');
        TextOut(ax + 222 + 148, ay + 222 + 7, clRed, '需要人物等级：' + IntToStr(FMakeGoods.wLevel) + '级');
        boMake := False;
      end else
      if FMakeMagicShow and (g_MakeMagic[FMakeMagicIdx] < FMakeGoods.btLevel) then begin
        TextOut(ax + 222 + 148, ay + 222 - 7, clRed, '您的' + MakeMagicName[FMakeMagicIdx] + '等级不够');
        TextOut(ax + 222 + 148, ay + 222 + 7, clRed, '需要等级：' + IntToStr(FMakeGoods.btLevel) + '级');
        boMake := False;
      end else begin
        if FMakeItemHint2 <> '' then begin
          TextOut(ax + 222 + 148, ay + 222 - 7, $A6A49F, FMakeItemHint);
          TextOut(ax + 222 + 148, ay + 222 + 7, $A6A49F, FMakeItemHint2);
        end
        else begin
          TextOut(ax + 222 + 148, ay + 222, $A6A49F, FMakeItemHint{'打造成功后得到的物品'});
        end;
      end;

      TextOut(ax + 41 + 148, ay + 274, $A6A49F, '打造费用：'); //FMakeItemRate
      TextOut(ax + 41 + 148, ay + 299, $A6A49F, '成功机率：');

      if FMakeGoods.Item[0].s.name <> '' then begin
        TextOut(ax + 41 + 60 + 148, ay + 274, clWhite, IntToStr(FMakeGoods.MakeItem.nMoney) +
          g_sGoldName + ' （优先使用' + g_sBindGoldName + '）');
        if FMakeItemRate < 0 then
          TextOut(ax + 41 + 60 + 148, ay + 299, clWhite, '未知（需要先放置矿石）')
        else
          TextOut(ax + 41 + 60 + 148, ay + 299, clWhite,
            IntToStr(_MIN(FMakeGoods.MakeItem.btRate + FMakeItemRate, FMakeGoods.MakeItem.btMaxRate)) + '%/' +
            IntToStr(FMakeGoods.MakeItem.btMaxRate) + '%');


      end;
{$IFEND}

    end;
    DMakeItemOK.Enabled := (not FMakeItemLock) and boMake;
    DMakeItemClose.Enabled := (not FMakeItemLock);
    DMakeItemTreeView.Enabled := (not FMakeItemLock);

    if FMakeItemShowSchedule then begin
      if GetTickCount > FMakeItemShowTick then begin
        if FMakeItemSchedulePosition = 0 then
          PlaySoundEx(bmg_Repair);
        FMakeItemShowTick := GetTickCount + 100;
        Inc(FMakeItemSchedulePosition);
      end;
      //FMakeItemHint := '正在进行打造，已完成 ' + IntToStr(FMakeItemSchedulePosition) + '%';
      FMakeItemHint := '正在进行打造...';
      FMakeItemHint2 := '';
      //g_DXCanvas.TextOut(ax + 11, ay + 326, $A6A49F, '正在进行打造，已完成 ' + IntToStr(FMakeItemSchedulePosition) + '%');

      {d := g_WMain99Images.Images[491];
      if d <> nil then begin
        rc := d.ClientRect;
        rc.Right := Round(rc.Right / (100 / FMakeItemSchedulePosition));
        dsurface.Draw(ax + 12 + 148, ay + 342, rc, d, FALSE);
      end;   }

      if FMakeItemSchedulePosition < 6 then begin
        d := g_WMain99Images.Images[860 + FMakeItemSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 179{$ELSE}75 + 148{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
        d := g_WMain99Images.Images[870 + FMakeItemSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 179{$ELSE}75 + 148{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
        d := g_WMain99Images.Images[880 + FMakeItemSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 179{$ELSE}75 + 148{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
        d := g_WMain99Images.Images[890 + FMakeItemSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 179{$ELSE}75 + 148{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
        d := g_WMain99Images.Images[900 + FMakeItemSchedulePosition];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 179{$ELSE}75 + 148{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
      end else
      if FMakeItemSchedulePosition = 6 then begin
        FMakeItemSchedulePosition := 93;
      end;

      if FMakeItemSchedulePosition in [93..100] then begin
        d := g_WMain99Images.Images[910 + FMakeItemSchedulePosition - 93];
        if d <> nil then
          DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 179{$ELSE}75 + 148{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
      end;

      if FMakeItemSchedulePosition >= 100 then begin
        FMakeItemShowSchedule := False;
        FMakeItemLock := False;
        if FMakeItemShowEffect then begin
          FMakeItemHint := '恭喜，打造成功';
          //SafeFillChar(FMakeItemItem, SizeOf(FMakeItemItem), #0);
          FMakeItemItem.Index2 := -1;
          FMakeItemItem.ItemType := mtBagItem;
          FMakeItemItem.Item.UserItem := FMakeItemUseItem;
          FMakeItemItem.Item.s := GetStditem(FMakeItemUseItem.wIndex);
          FMakeItemShowTick := GetTickCount;
          FMakeItemSchedulePosition := 0;
          PlaySoundEx(bmg_ItemLevel_OK);
        end
        else begin
          FMakeItemHint := '打造失败了.';

          SafeFillChar(FMakeItemItem, SizeOf(FMakeItemItem), #0);
          if FMakeItemBackItem.Item.s.name <> '' then begin
            FMakeItemItem := FMakeItemBackItem;
            FMakeItemBackItem.Item.s.name := '';
            FMakeItemHint2 := '系统退还：' + FMakeItemItem.Item.s.name;
          end
          else SafeFillChar(FMakeItemItem, SizeOf(FMakeItemItem), #0);
          FMakeItemShowTick := GetTickCount;
          FMakeItemSchedulePosition := 0;
          PlaySoundEx(bmg_ItemLevel_Fail);
          //ClearStrengthenInfoEx;
        end;
        {case FStrengthenLevelType of
          1: begin   //成功
            FStrengthenHint := '恭喜你，装备强化成功...';
            FStrengthenItem.Item.UserItem := FStrengthenUseItem;
            FStrengthenShowEffect := True;
            FStrengthenShowEffectType := 1;
            FStrengthenShowTick := GetTickCount;
            FStrengthenSchedulePosition := 0;
            PlaySoundEx(bmg_ItemLevel_OK);
            ClearStrengthenInfoEx;
            FStrengthenMoney := GetStrengthenMoney(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
            FStrengthenMaxRate := GetStrengthenMaxRate(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
          end;
          2: begin //破碎
            FStrengthenHint := '很遗憾，你的装备破碎了...';
            SafeFillChar(FStrengthenItem, SizeOf(FStrengthenItem), #0);
            FStrengthenShowEffect := True;
            FStrengthenShowEffectType := 2;
            FStrengthenShowTick := GetTickCount;
            FStrengthenSchedulePosition := 0;
            PlaySoundEx(bmg_ItemLevel_Fail);
            ClearStrengthenInfoEx;
          end;
          3: begin //降级
            FStrengthenHint := '很遗憾，你的装备强化等级被降低了...';
            FStrengthenItem.Item.UserItem := FStrengthenUseItem;
            ClearStrengthenInfoEx;
            FStrengthenMoney := GetStrengthenMoney(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
            FStrengthenMaxRate := GetStrengthenMaxRate(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
          end;
          4: begin //无变化
            FStrengthenHint := '你的装备没有发生变化...';
            ClearStrengthenInfoEx;
            FStrengthenMoney := GetStrengthenMoney(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
            FStrengthenMaxRate := GetStrengthenMaxRate(FStrengthenItem.Item.UserItem.Value.StrengthenInfo.btStrengthenCount);
          end;
        end; }
      end;
    end
    else if FMakeItemShowEffect then begin
      if GetTickCount > FMakeItemShowTick then begin
        FMakeItemShowTick := GetTickCount + 150;
        Inc(FMakeItemSchedulePosition);
      end;
      d := g_WMain99Images.Images[919 + FMakeItemSchedulePosition];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 179{$ELSE}75 + 148{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
      if FMakeItemSchedulePosition >= 10 then begin
        FMakeItemShowEffect := False;
      end;
    end;
  end;
end;

procedure TFrmDlg3.DWndMakeItemVisible(Sender: TObject; boVisible: Boolean);
begin
  SafeFillChar(FMakeGoods, SizeOf(FMakeGoods), #0);
  ClearMakeItemInfo;
  FrmDlg.LastestClickTime := GetTickCount;
  FMakeItemBackItem.Item.s.Name := '';
  FMakeAutoMake := False;
  if boVisible then begin
    FrmDlg.boOpenItemBag := FrmDlg.DItemBag.Visible;
    FrmDlg.DItemBag.Visible := True;
    FrmDlg.DMerchantDlg.Visible := False;
    FMakeItemHint := '成功后得到物品';
    FMakeItemHint2 := '';
    DMakeMagicxAutoMake.Visible := False;
  end
  else begin
    FrmDlg.DItemBag.Visible := FrmDlg.boOpenItemBag;
    DMakeItemTreeView.ClearItem;
    //FrmDlg.DMerchantDlg.Visible := FrmDlg.MDlgVisible;
  end;
end;

procedure TFrmDlg3.dwndMissionDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  str: string;
  ClientMissionInfo: pTClientMissionInfo;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
      str := '已接任务(' + IntToStr(g_MissionInfoList.Count) + '/' + IntToStr(High(TMissionInfos)) + ')';
      TextOut(ax + 81 - TextWidth(str) div 2, ay + 61, clWhite, str);
      
      if ShowCanAccept then TextOut(ax + 224, ay + 61, clWhite, '可接任务')
      else TextOut(ax + 224, ay + 61, clWhite, '任务说明');
{$ELSE}
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
      str := '已接任务(' + IntToStr(g_MissionInfoList.Count) + '/' + IntToStr(High(TMissionInfos)) + ')';
      TextOut(ax + 92 - TextWidth(str) div 2, ay + 45, $A5AE94, str);
      if ShowCanAccept then
        TextOut(ax + 282 - TextWidth('可接任务') div 2, ay + 45, $A5AE94, '可接任务')
      else
        TextOut(ax + 282 - TextWidth('任务说明') div 2, ay + 45, $A5AE94, '任务说明');  
{$IFEND}

    end;
{$IF Var_Interface = Var_Mir2}
    dbtnMissionAccept.Visible := not ShowCanAccept;
    dbtnMissionTrack.Visible := False;
    dbtnMissionLogout.Visible := False;
    dbtnMissionTrack.Caption := '跟踪任务';
    if DTrvwMission.Select <> nil then begin
      ClientMissionInfo := pTClientMissionInfo(DTrvwMission.Select.Item);
      if ClientMissionInfo <> nil then begin
        if ClientMissionInfo.ClientMission.wLogoutIdx > 0 then begin
          dbtnMissionLogout.Visible := True;
        end;
        if ClientMissionInfo.MissionInfo.boTrack then
          dbtnMissionTrack.Caption := '取消跟踪';
        dbtnMissionTrack.Visible := True;
      end;
    end;
{$ELSE}
    dbtnMissionAccept.Enabled := not ShowCanAccept;
    dbtnMissionTrack.Enabled := False;
    dbtnMissionLogout.Enabled := False;
    dbtnMissionTrack.Caption := '跟踪任务';
    if DTrvwMission.Select <> nil then begin
      ClientMissionInfo := pTClientMissionInfo(DTrvwMission.Select.Item);
      if ClientMissionInfo <> nil then begin
        if ClientMissionInfo.ClientMission.wLogoutIdx > 0 then begin
          dbtnMissionLogout.Enabled := True;
        end;
        if ClientMissionInfo.MissionInfo.boTrack then
          dbtnMissionTrack.Caption := '取消跟踪';
        dbtnMissionTrack.Enabled := True;
      end;
    end;  
{$IFEND}

  end;
end;

procedure TFrmDlg3.dwndMissionInfoClick(Sender: TObject; X, Y: Integer);
var
  L, T: Integer;
  rstr: string;
begin
  L := dwndMissionInfo.LocalX(dwndMissionInfo.Left);
  T := dwndMissionInfo.LocalY(dwndMissionInfo.Top);
  Y := Y + DUDwnMissionInfo.Position;
  with dwndMissionInfo do begin
    if (MDlgSelect.rstr <> '') and
      (X >= SurfaceX(L + MDlgSelect.Rc.Left)) and (X <= SurfaceX(L + MDlgSelect.Rc.Right)) and
      (Y >= SurfaceY(T + MDlgSelect.Rc.Top)) and (Y <= SurfaceY(T + MDlgSelect.Rc.Bottom)) then begin
      PlaySound(s_glass_button_click);
      rstr := MDlgSelect.rstr;
      ExecuteScript(rstr);
      MDlgSelect.rstr := '';
      exit;
    end;
  end;
  MDlgSelect.rstr := '';
end;

procedure TFrmDlg3.dwndMissionInfoDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, I, Index, px, py: integer;
  rc, dc: TRect;
  pShowHint: pTNewShowHint;
  dwTime: LongWord;
  nOldPosition: Integer;
  OldMDlgMove: TClickPoint;
  OldMDlgSelect: TClickPoint;
begin
  if MDlgStr = '' then exit;
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if MDlgChange and (not ShowCanAccept) then begin
      MDlgChange := False;
      OldMDlgMove := MDlgMove;
      OldMDlgSelect := MDlgSelect;
      nOldPosition := DUDwnMissionInfo.Position;
      if DTrvwMission.Select <> nil then begin
        ShowMissionDlg(pTClientMissionInfo(DTrvwMission.Select.Item));
        DUDwnMissionInfo.Position := nOldPosition;
        MDlgMove := OldMDlgMove;
        MDlgSelect := OldMDlgSelect;
      end;
    end;
    rc.Left := 0;
    rc.Top := DUDwnMissionInfo.Position;
    rc.Right := MERCHANTMAXWIDTH;
    rc.Bottom := DUDwnMissionInfo.Position + MerchantMaxHeight;
    dwTime := GetTickCount;
    for i := 0 to MDlgDraws.Count - 1 do begin
      pShowHint := MDlgDraws[i];
      if (pShowHint.Surfaces <> nil) and (pShowHint.IndexList <> nil) and (pShowHint.IndexList.Count > 0) then begin
        Index := dwTime div pShowHint.dwTime mod LongWord(pShowHint.IndexList.Count);
        d := pShowHint.Surfaces.GetCachedImage(StrToIntDef(pShowHint.IndexList[Index], -1), px, py);
        if d <> nil then begin
          if pShowHint.boMove then begin
            px := pShowHint.nX + px;
            py := pShowHint.ny + py - DUDwnMissionInfo.Position;
          end else begin
            px := pShowHint.nX;
            py := pShowHint.ny - DUDwnMissionInfo.Position;
          end;
          dc := d.ClientRect;
          if px >= rc.Right then
            Continue;
          if py >= MerchantMaxHeight then
            Continue;
          if px < 0 then begin
            dc.Left := -px;
            px := 0;
          end;
          if py < 0 then begin
            dc.Top := -py;
            py := 0;
          end;
          if (dc.Right - dc.Left + px) > rc.Right then
            dc.Right := rc.Right - px - dc.Left;
          if (dc.Bottom - dc.Top + py) > MerchantMaxHeight then
            dc.Bottom := MerchantMaxHeight - py - dc.Top;
          if (dc.Right - dc.Left) <= 0 then
            Continue;
          if (dc.Bottom - dc.Top) <= 0 then
            Continue;
          if pShowHint.boBlend then DrawBlendR(DSurface, ax + px, ay + py, dc, d, Integer(pShowHint.boTransparent))
          else DSurface.Draw(ax + px, ay + py, dc, d, pShowHint.boTransparent);
        end;
      end;
    end;
    DSurface.Draw(ax, ay, rc, Surface, TRUE);
{$IF Var_Interface = Var_Default}
    g_DXCanvas.Font.kerning := -1;
    Try
{$IFEND}
      if (MDlgSelect.rstr <> '') and (dwndMissionInfo.Downed) and (not MDlgSelect.boItem) then begin
        dc := MDlgSelect.rc;
        dc.Left := ax + dc.Left;
        dc.Right := ax + dc.Right;
        dc.Top := dc.Top - DUDwnMissionInfo.Position;
        dc.Bottom := dc.Bottom - DUDwnMissionInfo.Position;
        if (dc.Bottom > 0) and (dc.Top < rc.Bottom) then begin
          dc.Top := dc.Top + ay;
          dc.Bottom := dc.Bottom + ay;
          if MDlgMove.boNewPoint then begin
            dc.Top := dc.Top - 2;
            dc.Bottom := dc.Bottom + 3;
            g_DXCanvas.FillRect(dc.Left + MDLGCLICKOX, dc.Top, dc.Right - dc.Left - 20, dc.Bottom - dc.Top, $B4635C63);
            g_DXCanvas.TextOut(dc.Left + NEWPOINTOX + 1, dc.Top + 2 + NEWPOINTOY, MDlgMove.sstr, MDlgMove.Color);
            d := g_WMain99Images.Images[MDLGCHICKIMAGE];
            if d <> nil then begin
              g_DXCanvas.Draw(dc.Left, dc.Top + 2, d.ClientRect, d, True);
            end;
          end else begin
            //g_DXCanvas.TextOut(dc.Left + 1, dc.Top + 1, MDlgSelect.sstr, clLime);
           { g_DXCanvas.MoveTo(dc.Left - 1, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1);
            g_DXCanvas.LineTo(dc.Right - 3, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1, clBlack);
            g_DXCanvas.TextOut(dc.Left + 1, dc.Top + 1, MDlgSelect.sstr, clLime);
            g_DXCanvas.MoveTo(dc.Left, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 2);
            g_DXCanvas.LineTo(dc.Right - 2, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 2, clLime);  }
            g_DXCanvas.MoveTo(dc.Left - 1, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1);
            g_DXCanvas.LineTo(dc.Right - 3, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1, clBlack);
            g_DXCanvas.TextOut(dc.Left + 1, dc.Top + 1, MDlgSelect.sstr, clLime);
            g_DXCanvas.MoveTo(dc.Left + 1, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 2);
            g_DXCanvas.LineTo(dc.Right, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 2, clLime);
          end;
        end;
      end else
      if (MDlgMove.rstr <> '') and (not dwndMissionInfo.Downed) and (not MDlgMove.boItem) then begin
        dc := MDlgMove.rc;
        dc.Left := ax + dc.Left;
        dc.Right := ax + dc.Right;
        dc.Top := dc.Top - DUDwnMissionInfo.Position;
        dc.Bottom := dc.Bottom - DUDwnMissionInfo.Position;
        if (dc.Bottom > 0) and (dc.Top < rc.Bottom) then begin
          dc.Top := dc.Top + ay;
          dc.Bottom := dc.Bottom + ay;
          if MDlgMove.boNewPoint then begin
            dc.Top := dc.Top - 2;
            dc.Bottom := dc.Bottom + 3;
            g_DXCanvas.FillRect(dc.Left + MDLGCLICKOX, dc.Top, dc.Right - dc.Left - 20, dc.Bottom - dc.Top, $B4939594);
            g_DXCanvas.TextOut(dc.Left + NEWPOINTOX, dc.Top + 1 + NEWPOINTOY, MDlgMove.sstr, MDlgMove.Color);
            d := g_WMain99Images.Images[MDLGMOVEIMAGE];
            if d <> nil then begin
              g_DXCanvas.Draw(dc.Left, dc.Top + 2, d.ClientRect, d, True);
            end;
          end else begin
            {g_DXCanvas.TextOut(dc.Left, dc.Top, MDlgMove.sstr, clAqua);
            g_DXCanvas.MoveTo(dc.Left - 1, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1);
            g_DXCanvas.LineTo(dc.Right - 3, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1, clAqua); }
            g_DXCanvas.TextOut(dc.Left, dc.Top, MDlgMove.sstr, clAqua);
            g_DXCanvas.MoveTo(dc.Left, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1);
            g_DXCanvas.LineTo(dc.Right - 1, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1, clAqua);

          end;
        end;
      end;
{$IF Var_Interface = Var_Default}
    Finally
      g_DXCanvas.Font.kerning := -2;
    End;
{$IFEND}
  end;
end;

procedure TFrmDlg3.dwndMissionInfoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, L, T: Integer;
  p: pTClickPoint;
begin
  MDlgSelect.rstr := '';
  L := dwndMissionInfo.LocalX(dwndMissionInfo.Left);
  T := dwndMissionInfo.LocalY(dwndMissionInfo.Top);
  Y := Y + DUDwnMissionInfo.Position;
  with dwndMissionInfo do begin
    for i := 0 to MDlgPoints.count - 1 do begin
      p := pTClickPoint(MDlgPoints[i]);
      if (not p.boItem) and (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
        (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
        MDlgSelect := p^;
        exit;
      end;
    end;
  end;
end;

procedure TFrmDlg3.dwndMissionInfoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  i, L, T, nY: Integer;
  p: pTClickPoint;
begin
  MDlgMove.rstr := '';
  if dwndMissionInfo.Downed then exit;
  MDlgSelect.rstr := '';
  L := dwndMissionInfo.LocalX(dwndMissionInfo.Left);
  T := dwndMissionInfo.LocalY(dwndMissionInfo.Top);
  nY := Y;
  Y := Y + DUDwnMissionInfo.Position;
  with dwndMissionInfo do begin
    for i := 0 to MDlgPoints.count - 1 do begin
      p := pTClickPoint(MDlgPoints[i]);
      if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
        (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
        if p.boItem then begin
          DScreen.ShowHint(SurfaceX(X), SurfaceY(nY),
            ShowItemInfo(p.Item, [], []), clwhite, SurfaceY(nY) > 350, p.Item.s.Idx, True);
        end else begin
          MDlgMove := p^;
        end;
        break;
      end;
    end;
  end;
end;

procedure TFrmDlg3.dwndMissionMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  MDlgMove.rstr := '';
  if dwndMissionInfo.Downed then exit;
  MDlgSelect.rstr := '';
end;

procedure TFrmDlg3.dwndMissionVisible(Sender: TObject; boVisible: Boolean);
begin
  MDlgChange := True;
  if boVisible then begin
    if g_MissionInfoList.Count <= 0 then
      dbtnMissionAcceptClick(dbtnMissionAccept, 0, 0);
  end;
end;

procedure TFrmDlg3.FormCreate(Sender: TObject);
begin
  //FMakeItemList := TList.Create;
  GuildMemberList := TQuickStringPointerList.Create;
  GuildMemberStrs := TStringList.Create;
  GuildOnLineMemberList := TQuickStringPointerList.Create;
  GuildNoticeList := TStringList.Create;
  GuildWarList := TList.Create;
  GuildAllyList := TList.Create;
  FItemShowList := TStringList.Create;
  FItemShowAllList := TStringList.Create;
  FMissionLogoutTick := GetTickCount;
  FboTopSend := False;
  MDlgPoints := TList.Create;
  MDlgDraws := TList.Create;
  //g_OperateHintList.Assign(DDMMagicList.Item);
  DDMMagicList.Item.Clear;
  DDAPMagicList.Item.Clear;
  FTopIndex := 0;
  FillChar(FTopInfo, SizeOf(FTopInfo), #0);
end;

procedure TFrmDlg3.FormDestroy(Sender: TObject);
begin
  ClearGuildMemberInfo;
  ClearItemShowList;
  GuildMemberList.Free;
  GuildMemberStrs.Free;
  GuildOnLineMemberList.Free;
  GuildNoticeList.Free;
  GuildWarList.Free;
  GuildAllyList.Free;
  FItemShowList.Free;
  FItemShowAllList.Free;
  MDlgPoints.Free;
  MDlgDraws.Free;
  //ClientMakeItemsList();
  //FMakeItemList.Free;
end;

procedure TFrmDlg3.Initialize;
var
  d: TDirectDrawSurface;
  i: Integer;
  dcon: TDControl;
begin
  ClearStrengthenInfo;

  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TDWindow) or (Components[i] is TDPopUpMemu) then begin
      dcon := TDControl(Components[i]);
      if dcon.DParent = nil then begin
        dcon.DParent := FrmDlg.DBackground;
        FrmDlg.DBackground.AddChild(dcon);
      end;
    end;
  end;

  GuildIndex := 0;
  FSetupIndex := 0;
  GuildNoticeIndex := 0;
  GuildAllyMoveIndex := -1;
  GuildAllySelectIndex := -1;
  GuildWarMoveIndex := -1;
  GuildWarSelectIndex := -1;
  GuildSaveNoticeTick := GetTickCount;
  GuildSaveMemberTick := GetTickCount;
  GuildRefMemberTick := GetTickCount;
  GuildMasterName := '';

  //装备强化
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1704];
  if d <> nil then begin
    DWndArmStrengthen.SetImgIndex(g_WMain99Images, 1704);
    DWndArmStrengthen.Left := 0;
    DWndArmStrengthen.Top := 60;
  end;
  DArmClose2.SetImgIndex(g_WMain99Images, 1850);
  DArmClose2.Left := DWndArmStrengthen.Width - 44;  //- 20 - 24
  DArmClose2.Top := 8 + 4;
  DArmClose2.Visible := False;

  DArmStrengthenLevel.Top := 57;
  DArmStrengthenLevel.Left := 39;
  DArmStrengthenLevel.Width := 214;
  DArmStrengthenLevel.Height := 31;
  DArmStrengthenLevel.Coloffset := 11;
  DArmStrengthenLevel.ColWidth := 34;
  DArmStrengthenLevel.RowHeight := 31;

  DArmStrengthenAss.Top := 120;
  DArmStrengthenAss.Left := 39;
  DArmStrengthenAss.Width := 214;
  DArmStrengthenAss.Height := 31;
  DArmStrengthenAss.Coloffset := 11;
  DArmStrengthenAss.ColWidth := 34;
  DArmStrengthenAss.RowHeight := 31;

  DArmOK.SetImgIndex(g_WMain99Images, 1650);
  DArmOK.Left := 56;
  DArmOK.Top := 287;
  DArmOK.DFColor := $ADD6EF;

  DArmClose.SetImgIndex(g_WMain99Images, 1650);
  DArmClose.Left := 156;
  DArmClose.Top := 287;
  DArmClose.DFColor := $ADD6EF;
  DArmClose.OnDirectPaint := DArmOKDirectPaint;

  DArmItem.Top := 172;
  DArmItem.Left := 129;
  DArmItem.Width := 34;
  DArmItem.Height := 31;
{$ELSE}
  d := g_WMain99Images.Images[481];
  if d <> nil then begin
    DWndArmStrengthen.SetImgIndex(g_WMain99Images, 481);
    DWndArmStrengthen.Left := 0;
    DWndArmStrengthen.Top := 60;
  end;
  DArmClose2.SetImgIndex(g_WMain99Images, 133);
  DArmClose2.Left := DWndArmStrengthen.Width - 20;
  DArmClose2.Top := 8 + 4;

  DArmStrengthenLevel.Top := 81;
  DArmStrengthenLevel.Left := 69;
  DArmStrengthenLevel.Width := 254;
  DArmStrengthenLevel.Height := 38;

  DArmStrengthenAss.Top := 150;
  DArmStrengthenAss.Left := 69;
  DArmStrengthenAss.Width := 254;
  DArmStrengthenAss.Height := 38;

  DArmOK.SetImgIndex(g_WMain99Images, 330);
  DArmOK.Left := 96;
  DArmOK.Top := 331;
  DArmOK.OnDirectPaint := nil;

  DArmClose.SetImgIndex(g_WMain99Images, 330);
  DArmClose.Left := 227;
  DArmClose.Top := 331;

  DArmItem.Top := 210;
  DArmItem.Left := 178;
  DArmItem.Width := 36;
  DArmItem.Height := 36;  
{$IFEND}


  //打造物品
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1707];
  if d <> nil then begin
    DWndMakeItem.SetImgIndex(g_WMain99Images, 1707);
    DWndMakeItem.Left := 0;
    DWndMakeItem.Top := 60;
  end;
  DMakeItemClose2.SetImgIndex(g_WMain99Images, 133);
  DMakeItemClose2.Left := DWndMakeItem.Width - 20;
  DMakeItemClose2.Top := 8 + 4;
  DMakeItemClose2.Visible := False;

  DMakeItemItems.Top := 57;
  DMakeItemItems.Left := 193;
  DMakeItemItems.Width := 214;
  DMakeItemItems.Height := 31;
  DMakeItemItems.ColWidth := 34;
  DMakeItemItems.Coloffset := 11;
  DMakeItemItems.RowHeight := 31;

  DMakeItemAss.Top := 120;
  DMakeItemAss.Left := 193;
  DMakeItemAss.Width := 214;
  DMakeItemAss.Height := 31;
  DMakeItemAss.ColWidth := 34;
  DMakeItemAss.Coloffset := 11;
  DMakeItemAss.RowHeight := 31;

  DMakeItemOK.SetImgIndex(g_WMain99Images, 1650);
  DMakeItemOK.Left := 210;
  DMakeItemOK.Top := 287;
  DMakeItemOK.OnDirectPaint := dbtnMissionTrackDirectPaint;
  DMakeItemOK.DFColor := $ADD6EF;

  DMakeItemClose.SetImgIndex(g_WMain99Images, 1650);
  DMakeItemClose.Left := 310;
  DMakeItemClose.Top := 287;
  DMakeItemClose.OnDirectPaint := dbtnMissionTrackDirectPaint;
  DMakeItemClose.DFColor := $ADD6EF;

  DMakeItemArming.Top := 172;
  DMakeItemArming.Left := 283;
  DMakeItemArming.Width := 34;
  DMakeItemArming.Height := 31;

  DMakeItemTreeView.WLib := g_WMain99Images;
  DMakeItemTreeView.Left := 14;
  DMakeItemTreeView.Top := 65;
  DMakeItemTreeView.Width := 120;
  DMakeItemTreeView.Height := 284;
  DMakeItemTreeView.ImageOpenIndex := 402;
  DMakeItemTreeView.ImageCloseIndex := 408;

  DMakeItemTreeViewUpDown.SetImgIndex(g_WMain99Images, 120);
  DMakeItemTreeViewUpDown.Top := 63;
  DMakeItemTreeViewUpDown.Left := 136;
  DMakeItemTreeViewUpDown.Height := 289;

  DMakeItemTreeViewUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DMakeItemTreeViewUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DMakeItemTreeViewUpDown.MoveButton.SetImgIndex(g_WMain99Images, 315);

  DMakeItemTreeView.WLib := g_WMain99Images;
  DMakeItemTreeView.Left := 26;
  DMakeItemTreeView.Top := 50;
  DMakeItemTreeView.Width := 126;
  DMakeItemTreeView.Height := 263;
  DMakeItemTreeView.ImageOpenIndex := 402;
  DMakeItemTreeView.ImageCloseIndex := 408;

  DMakeItemTreeViewUpDown.SetImgIndex(g_WMain99Images, 120);
  DMakeItemTreeViewUpDown.Top := 48;
  DMakeItemTreeViewUpDown.Left := 153;
  DMakeItemTreeViewUpDown.Height := 267;
  DMakeItemTreeViewUpDown.Offset := 1;
  DMakeItemTreeViewUpDown.Normal := True;

  DMakeItemTreeViewUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DMakeItemTreeViewUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DMakeItemTreeViewUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DMakeMagicxAutoMake.SetImgIndex(g_WMain99Images, 151);
  DMakeMagicxAutoMake.Left := 200;
  DMakeMagicxAutoMake.Top := 179;
{$ELSE}
  d := g_WMain99Images.Images[487];
  if d <> nil then begin
    DWndMakeItem.SetImgIndex(g_WMain99Images, 487);
    DWndMakeItem.Left := 0;
    DWndMakeItem.Top := 60;
  end;
  DMakeItemClose2.SetImgIndex(g_WMain99Images, 133);
  DMakeItemClose2.Left := DWndMakeItem.Width - 20;
  DMakeItemClose2.Top := 8 + 4;

  DMakeItemItems.Top := 81;
  DMakeItemItems.Left := 69 + 148;
  DMakeItemItems.Width := 254;
  DMakeItemItems.Height := 38;

  DMakeItemAss.Top := 150;
  DMakeItemAss.Left := 69 + 148;
  DMakeItemAss.Width := 254;
  DMakeItemAss.Height := 38;

  DMakeItemOK.SetImgIndex(g_WMain99Images, 330);
  DMakeItemOK.Left := 244{66 + 148};
  DMakeItemOK.Top := 331;

  DMakeItemClose.SetImgIndex(g_WMain99Images, 330);
  DMakeItemClose.Left := 375{327 + 148};
  DMakeItemClose.Top := 331;

  DMakeItemArming.Top := 210;
  DMakeItemArming.Left := 178 + 148;
  DMakeItemArming.Width := 36;
  DMakeItemArming.Height := 36;

  DMakeItemTreeView.WLib := g_WMain99Images;
  DMakeItemTreeView.Left := 14;
  DMakeItemTreeView.Top := 65;
  DMakeItemTreeView.Width := 120;
  DMakeItemTreeView.Height := 284;
  DMakeItemTreeView.ImageOpenIndex := 402;
  DMakeItemTreeView.ImageCloseIndex := 408;

  DMakeItemTreeViewUpDown.SetImgIndex(g_WMain99Images, 120);
  DMakeItemTreeViewUpDown.Top := 63;
  DMakeItemTreeViewUpDown.Left := 136;
  DMakeItemTreeViewUpDown.Height := 289;

  DMakeItemTreeViewUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DMakeItemTreeViewUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DMakeItemTreeViewUpDown.MoveButton.SetImgIndex(g_WMain99Images, 315);

  DMakeMagicxAutoMake.SetImgIndex(g_WMain99Images, 151);
  DMakeMagicxAutoMake.Left := 165;
  DMakeMagicxAutoMake.Top := 332;  
{$IFEND}


  //装备开光
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1705];
  if d <> nil then begin
    DWndItemUnseal.SetImgIndex(g_WMain99Images, 1705);
    DWndItemUnseal.Left := 0;
    DWndItemUnseal.Top := 60;
  end;
  DItemUnsealClose.SetImgIndex(g_WMain99Images, 1850);
  DItemUnsealClose.Left := 262;
  DItemUnsealClose.Top := 24;

  DItemUnsealArm.Top := 36;
  DItemUnsealArm.Left := 130;
  DItemUnsealArm.Width := 33;
  DItemUnsealArm.Height := 31;

  DItemUnsealItems.Top := 182;
  DItemUnsealItems.Left := 50;
  DItemUnsealItems.Width := 192;
  DItemUnsealItems.Height := 77;
  DItemUnsealItems.ColCount := 4;
  DItemUnsealItems.ColWidth := 33;
  DItemUnsealItems.Coloffset := 20;
  DItemUnsealItems.Rowoffset := 15;
  DItemUnsealItems.RowHeight := 31;

  DItemUnsealOK.SetImgIndex(g_WMain99Images, 1710);
  DItemUnsealOK.Left := 111;
  DItemUnsealOK.Top := 271;
  DItemUnsealOK.OnDirectPaint := DArmClose2DirectPaint;
  DItemUnsealClose2.SetImgIndex(g_WMain99Images, 147);
  DItemUnsealClose2.Left := 176;
  DItemUnsealClose2.Top := 311;
  DItemUnsealClose2.Visible := False;
{$ELSE}
  d := g_WMain99Images.Images[474];
  if d <> nil then begin
    DWndItemUnseal.SetImgIndex(g_WMain99Images, 474);
    DWndItemUnseal.Left := 0;
    DWndItemUnseal.Top := 90;
  end;
  DItemUnsealClose.SetImgIndex(g_WMain99Images, 133);
  DItemUnsealClose.Left := DWndItemUnseal.Width - 20;
  DItemUnsealClose.Top := 8 + 4;

  DItemUnsealArm.Top := 62;
  DItemUnsealArm.Left := 135;
  DItemUnsealArm.Width := 36;
  DItemUnsealArm.Height := 36;

  DItemUnsealItems.Top := 211;
  DItemUnsealItems.Left := 60;
  DItemUnsealItems.Width := 186;
  DItemUnsealItems.Height := 79;

  DItemUnsealOK.SetImgIndex(g_WMain99Images, 147);
  DItemUnsealOK.Left := 79;
  DItemUnsealOK.Top := 311;
  DItemUnsealClose2.SetImgIndex(g_WMain99Images, 147);
  DItemUnsealClose2.Left := 176;
  DItemUnsealClose2.Top := 311;
{$IFEND}


  //行会管理界面
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1662];
  if d <> nil then begin
    DGuildDlg.SetImgIndex(g_WMain99Images, 1662);
    DGuildDlg.Left := g_FScreenXOrigin - d.Width div 2;
    DGuildDlg.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  DGDClose.SetImgIndex(g_WMain99Images, 1850);
  DGDClose.Left := 622;
  DGDClose.Top := 6;

  d := g_WMain99Images.Images[1663];
  if d <> nil then begin
    DGuildLogDlg.SetImgIndex(g_WMain99Images, 1663);
    DGuildLogDlg.Left := 48;
    DGuildLogDlg.Top := 36;
  end;
  d := g_WMain99Images.Images[1664];
  if d <> nil then begin
    DGuildInfoDlg.SetImgIndex(g_WMain99Images, 1664);
    DGuildInfoDlg.Left := 48;
    DGuildInfoDlg.Top := 36;
  end;
  d := g_WMain99Images.Images[1665];
  if d <> nil then begin
    DGuildAllyDlg.SetImgIndex(g_WMain99Images, 1665);
    DGuildAllyDlg.Left := 48;
    DGuildAllyDlg.Top := 36;
  end;

  DGDHome.SetImgIndex(g_WMain99Images, 1669);
  DGDHome.Left := 4;
  DGDHome.Top := 7;
  DGDInfo.SetImgIndex(g_WMain99Images, 1670);
  DGDInfo.Left := 4;
  DGDInfo.Top := 105;
  DGDAlly.SetImgIndex(g_WMain99Images, 1668);
  DGDAlly.Left := 4;
  DGDAlly.Top := 203;

  DGDEditGrade.SetImgIndex(g_WMain99Images, 1675);
  DGDEditGrade.Left := 381;
  DGDEditGrade.Top := 364;
  DGDEditGrade.OnDirectPaint := DGDAddMemDirectPaint;
  DGDEditRefMemberList.SetImgIndex(g_WMain99Images, 1673);
  DGDEditRefMemberList.Left := 312;
  DGDEditRefMemberList.Top := 364;
  DGDEditRefMemberList.OnDirectPaint := DGDAddMemDirectPaint;
  DGDAddMem.SetImgIndex(g_WMain99Images, 1677);
  DGDAddMem.Left := 312;
  DGDAddMem.Top := 384;
  DGDDelMem.SetImgIndex(g_WMain99Images, 1679);
  DGDDelMem.Left := 381;
  DGDDelMem.Top := 384;
  DGDDelMem.OnDirectPaint := DGDAddMemDirectPaint;

  DCheckBoxShowMember.SetImgIndex(g_WMain99Images, 151);
  DCheckBoxShowMember.Left := 479;
  DCheckBoxShowMember.Top := 364;

  DGDEditFind.SetImgIndex(g_WMain99Images, 1671);
  DGDEditFind.Left := 583;
  DGDEditFind.Top := 384;
  DGDEditFind.OnDirectPaint := DGDAddMemDirectPaint;

  DEditFind.Left := 480;
  DEditFind.Top := 384;
  DEditFind.Width := 96;
  DEditFind.Height := 16;

  DGDSortComboBox.SetImgIndex(g_WMain99Images, 2153);
  DGDSortComboBox.left := 513;
  DGDSortComboBox.top := 44;
  DGDSortComboBox.Height := 16;
  DGDSortComboBox.width := 109;
{$ELSE}
  d := g_WMain99Images.Images[222];
  if d <> nil then begin
    DGuildDlg.SetImgIndex(g_WMain99Images, 222);
    DGuildDlg.Left := g_FScreenXOrigin - d.Width div 2;
    DGuildDlg.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  DGDClose.SetImgIndex(g_WMain99Images, 133);
  DGDClose.Left := DGuildDlg.Width - 20;
  DGDClose.Top := 8 + 4;

  d := g_WMain99Images.Images[223];
  if d <> nil then begin
    DGuildLogDlg.SetImgIndex(g_WMain99Images, 223);
    DGuildLogDlg.Left := 14;
    DGuildLogDlg.Top := 70;
  end;
  d := g_WMain99Images.Images[224];
  if d <> nil then begin
    DGuildInfoDlg.SetImgIndex(g_WMain99Images, 224);
    DGuildInfoDlg.Left := 14;
    DGuildInfoDlg.Top := 70;
  end;
  d := g_WMain99Images.Images[225];
  if d <> nil then begin
    DGuildAllyDlg.SetImgIndex(g_WMain99Images, 225);
    DGuildAllyDlg.Left := 14;
    DGuildAllyDlg.Top := 70;
  end;

  DGDHome.SetImgIndex(g_WMain99Images, 216);
  DGDHome.Left := 14;
  DGDHome.Top := 37;
  DGDInfo.SetImgIndex(g_WMain99Images, 216);
  DGDInfo.Left := 99;
  DGDInfo.Top := 37;
  DGDAlly.SetImgIndex(g_WMain99Images, 216);
  DGDAlly.Left := 184;
  DGDAlly.Top := 37;

  DGDEditGrade.SetImgIndex(g_WMain99Images, 330);
  DGDEditGrade.Left := 391;
  DGDEditGrade.Top := 443;
  DGDEditRefMemberList.SetImgIndex(g_WMain99Images, 330);
  DGDEditRefMemberList.Left := 314;
  DGDEditRefMemberList.Top := 443;
  DGDAddMem.SetImgIndex(g_WMain99Images, 330);
  DGDAddMem.Left := 314;
  DGDAddMem.Top := 467;
  DGDAddMem.OnDirectPaint := nil;
  DGDDelMem.SetImgIndex(g_WMain99Images, 330);
  DGDDelMem.Left := 391;
  DGDDelMem.Top := 467;

  DCheckBoxShowMember.SetImgIndex(g_WMain99Images, 151);
  DCheckBoxShowMember.Left := 508;
  DCheckBoxShowMember.Top := 445;

  DGDEditFind.SetImgIndex(g_WMain99Images, 147);
  DGDEditFind.Left := 608;
  DGDEditFind.Top := 467;

  DEditFind.Left := 508;
  DEditFind.Top := 469;
  DEditFind.Width := 93;
  DEditFind.Height := 16;

  DGDSortComboBox.SetImgIndex(g_WMain99Images, 309);
  DGDSortComboBox.left := 512;
  DGDSortComboBox.top := 72;
  DGDSortComboBox.Height := 16;
  DGDSortComboBox.width := 143;  
{$IFEND}


  //行会公告
{$IF Var_Interface = Var_Mir2}
  DMemoGuildNotice.Top := 33;
  DMemoGuildNotice.Left := 6;
  DMemoGuildNotice.Width := 243;
  DMemoGuildNotice.Height := 308;

  DGuildLogNotice.SetImgIndex(g_WMain99Images, 219);
  DGuildLogNotice.Top := 6;
  DGuildLogNotice.Left := 20;
  DGuildLogNotice.Visible := False;

  DGuildNoticeUpDown.SetImgIndex(g_WMain99Images, 120);
  DGuildNoticeUpDown.Top := DMemoGuildNotice.Top {+ 1};
  DGuildNoticeUpDown.Left := DMemoGuildNotice.Left + DMemoGuildNotice.Width - DUpDownGuildMember.Width + 1;
  DGuildNoticeUpDown.Height := DMemoGuildNotice.Height {- 1};
  DGuildNoticeUpDown.Offset := 1;
  DGuildNoticeUpDown.Normal := True;

  DGuildNoticeUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DGuildNoticeUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DGuildNoticeUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DGDEditNoticeSave.SetImgIndex(g_WMain99Images, 1685);
  DGDEditNoticeSave.Left := 55;
  DGDEditNoticeSave.Top := 348;
  DGDEditNoticeSave.OnDirectPaint := DGDAddMemDirectPaint;
  DGDEditNotice.SetImgIndex(g_WMain99Images, 1681);
  DGDEditNotice.Left := 6;
  DGDEditNotice.Top := 348;
  DGDEditNotice.OnDirectPaint := DGDAddMemDirectPaint;
{$ELSE}
  DMemoGuildNotice.Top := 113 - 70;
  DMemoGuildNotice.Left := 35 - 14;
  DMemoGuildNotice.Width := 234 + 15;
  DMemoGuildNotice.Height := 336;

  DGuildLogNotice.SetImgIndex(g_WMain99Images, 219);
  DGuildLogNotice.Top := 6;
  DGuildLogNotice.Left := 20;

  DGuildNoticeUpDown.SetImgIndex(g_WMain99Images, 120);
  DGuildNoticeUpDown.Top := 107 - 70;
  DGuildNoticeUpDown.Left := 276 - 14;
  DGuildNoticeUpDown.Height := 339;

  DGuildNoticeUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DGuildNoticeUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DGuildNoticeUpDown.MoveButton.SetImgIndex(g_WMain99Images, 315);

  DGDEditNoticeSave.SetImgIndex(g_WMain99Images, 147);
  DGDEditNoticeSave.Left := 84 - 14;
  DGDEditNoticeSave.Top := 452 - 70;
  DGDEditNotice.SetImgIndex(g_WMain99Images, 147);
  DGDEditNotice.Left := 26 - 14;
  DGDEditNotice.Top := 452 - 70;  
{$IFEND}


  //行会信息
{$IF Var_Interface = Var_Mir2}
  DGDUpLevel.SetImgIndex(g_WMain99Images, 1695);
  DGDUpLevel.Left := 103;
  DGDUpLevel.Top := 176;
  DGDSetMoney.SetImgIndex(g_WMain99Images, 1698);
  DGDSetMoney.Left := 161;
  DGDSetMoney.Top := 195;
  DGDSetMoney.OnDirectPaint := DGDAddMemDirectPaint;
  DGDGetMoney.SetImgIndex(g_WMain99Images, 1700);
  DGDGetMoney.Left := 204;
  DGDGetMoney.Top := 195;
  DGDGetMoney.OnDirectPaint := DGDUpLevelDirectPaint;
{$ELSE}
  DGDUpLevel.SetImgIndex(g_WMain99Images, 147);
  DGDUpLevel.Left := 122 - 14;
  DGDUpLevel.Top := 245 - 70;
  DGDUpLevel.OnDirectPaint := nil;
  DGDSetMoney.SetImgIndex(g_WMain99Images, 147);
  DGDSetMoney.Left := 182 - 14;
  DGDSetMoney.Top := 280 - 70;
  DGDGetMoney.SetImgIndex(g_WMain99Images, 147);
  DGDGetMoney.Left := 240 - 14;
  DGDGetMoney.Top := 280 - 70;
{$IFEND}


  //行会交际
{$IF Var_Interface = Var_Mir2}
  DGuildAllyUpDown.SetImgIndex(g_WMain99Images, 120);
  DGuildAllyUpDown.Top := 53;
  DGuildAllyUpDown.Left := 234;
  DGuildAllyUpDown.Height := 114;
  DGuildAllyUpDown.Offset := 1;
  DGuildAllyUpDown.Normal := True;
  DGuildAllyUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DGuildAllyUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DGuildAllyUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DGuildWarUpDown.SetImgIndex(g_WMain99Images, 120);
  DGuildWarUpDown.Top := 250;
  DGuildWarUpDown.Left := 234;
  DGuildWarUpDown.Height := 114;
  DGuildWarUpDown.Offset := 1;
  DGuildWarUpDown.Normal := True;
  DGuildWarUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DGuildWarUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DGuildWarUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DGDAllyAdd.SetImgIndex(g_WMain99Images, 1691);
  DGDAllyAdd.Left := 5;
  DGDAllyAdd.Top := 174;
  DGDAllyAdd.OnDirectPaint := DGDAddMemDirectPaint;
  DGDBreakAlly.SetImgIndex(g_WMain99Images, 1693);
  DGDBreakAlly.Left := 76;
  DGDBreakAlly.Top := 174;
  DGDBreakAlly.OnDirectPaint := DGDAddMemDirectPaint;
{$ELSE}
  DGuildAllyUpDown.SetImgIndex(g_WMain99Images, 120);
  DGuildAllyUpDown.Top := 47;
  DGuildAllyUpDown.Left := 267;
  DGuildAllyUpDown.Height := 144;
  DGuildAllyUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DGuildAllyUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DGuildAllyUpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DGuildWarUpDown.SetImgIndex(g_WMain99Images, 120);
  DGuildWarUpDown.Top := 278;
  DGuildWarUpDown.Left := 267;
  DGuildWarUpDown.Height := 128;
  DGuildWarUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DGuildWarUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DGuildWarUpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DGDAllyAdd.SetImgIndex(g_WMain99Images, 330);
  DGDAllyAdd.Left := 6;
  DGDAllyAdd.Top := 195;
  DGDBreakAlly.SetImgIndex(g_WMain99Images, 330);
  DGDBreakAlly.Left := 83;
  DGDBreakAlly.Top := 195;
{$IFEND}


  //行会成员
{$IF Var_Interface = Var_Mir2}
  DGuildMemberDlg.Left := 313;
  DGuildMemberDlg.Top := 69;
  DGuildMemberDlg.Width := 309;
  DGuildMemberDlg.Height := 290;

  DGuildMemberUpDown.SetImgIndex(g_WMain99Images, 120);
  DGuildMemberUpDown.Top := 89 - DGuildMemberDlg.Top;
  DGuildMemberUpDown.Left := 607 - DGuildMemberDlg.Left;
  DGuildMemberUpDown.Height := 270;
  DGuildMemberUpDown.Offset := 1;
  DGuildMemberUpDown.Normal := True;

  DGuildMemberUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DGuildMemberUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DGuildMemberUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DMemoGuildMember.Top := 48;
  DMemoGuildMember.Left := 314 - DGuildMemberDlg.Left;
  DMemoGuildMember.Width := 308;
  DMemoGuildMember.Height := 290 - 48;

  DUpDownGuildMember.SetImgIndex(g_WMain99Images, 120);
  DUpDownGuildMember.Top := DMemoGuildMember.Top {+ 1};
  DUpDownGuildMember.Left := DMemoGuildMember.Left + DMemoGuildMember.Width - DUpDownGuildMember.Width + 1;
  DUpDownGuildMember.Height := DMemoGuildMember.Height {- 1};
  DUpDownGuildMember.Offset := 1;
  DUpDownGuildMember.Normal := True;

  DUpDownGuildMember.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DUpDownGuildMember.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DUpDownGuildMember.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DPopUpMemuGuild.SetImgIndex(g_WMain99Images, 276);
{$ELSE}
  DGuildMemberDlg.Left := 316;
  DGuildMemberDlg.Top := 95;
  DGuildMemberDlg.Width := 342;
  DGuildMemberDlg.Height := 341;

  DGuildMemberUpDown.SetImgIndex(g_WMain99Images, 120);
  DGuildMemberUpDown.Top := 116 - DGuildMemberDlg.Top;
  DGuildMemberUpDown.Left := 643 - DGuildMemberDlg.Left;
  DGuildMemberUpDown.Height := 320;

  DGuildMemberUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DGuildMemberUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DGuildMemberUpDown.MoveButton.SetImgIndex(g_WMain99Images, 315);

  DMemoGuildMember.Top := 143 - DGuildMemberDlg.Top;
  DMemoGuildMember.Left := 317 - DGuildMemberDlg.Left;
  DMemoGuildMember.Width := 341;
  DMemoGuildMember.Height := 292;

  DUpDownGuildMember.SetImgIndex(g_WMain99Images, 120);
  DUpDownGuildMember.Top := DMemoGuildMember.Top {+ 1};
  DUpDownGuildMember.Left := DMemoGuildMember.Left + DMemoGuildMember.Width - DUpDownGuildMember.Width + 1;
  DUpDownGuildMember.Height := DMemoGuildMember.Height {- 1};

  DUpDownGuildMember.UpButton.SetImgIndex(g_WMain99Images, 108);
  DUpDownGuildMember.DownButton.SetImgIndex(g_WMain99Images, 111);
  DUpDownGuildMember.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DPopUpMemuGuild.SetImgIndex(g_WMain99Images, 276);
{$IFEND}


  //游戏设置
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1740];
  if d <> nil then begin
    DGameSetup.SetImgIndex(g_WMain99Images, 1740);
    DGameSetup.Left := g_FScreenXOrigin - d.Width div 2;
    DGameSetup.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  DGSClose.SetImgIndex(g_WMain99Images, 1850);
  DGSClose.Left := 459;
  DGSClose.Top := 0;

  DGSConfig.SetImgIndex(g_WMain99Images, 2060);
  DGSConfig.Top := 14;
  DGSConfig.Left := 10 + 48 * DGSConfig.Tag;

  DGSFunction.SetImgIndex(g_WMain99Images, 2060);
  DGSFunction.Top := 14;
  DGSFunction.Left := 10 + 48 * DGSFunction.Tag;
  DGSProtect.SetImgIndex(g_WMain99Images, 2060);
  DGSProtect.Top := 14;
  DGSProtect.Left := 10 + 48 * DGSProtect.Tag;
  DGSItems.SetImgIndex(g_WMain99Images, 2060);
  DGSItems.Top := 14;
  DGSItems.Left := 10 + 48 * DGSItems.Tag;
  DGSMagics.SetImgIndex(g_WMain99Images, 2060);
  DGSMagics.Top := 14;
  DGSMagics.Left := 10 + 48 * DGSMagics.Tag;
  dbtnGSSay.SetImgIndex(g_WMain99Images, 2060);
  dbtnGSSay.Top := 14;
  dbtnGSSay.Left := 10 + 48 * dbtnGSSay.Tag;
  dbtnGSSay.Visible := False;

  DGSClose2.SetImgIndex(g_WMain99Images, 330);
  DGSClose2.Left := 11;
  DGSClose2.Top := 251;

  DGSDefault.SetImgIndex(g_WMain99Images, 1650);
  DGSDefault.Left := 182;
  DGSDefault.Top := 223;
  DGSDefault.OnDirectPaint := dbtnMissionTrackDirectPaint;
  DGSDefault.DFColor := $ADD6EF;
  DGSSave.SetImgIndex(g_WMain99Images, 1650);
  DGSSave.Left := 282;
  DGSSave.Top := 223;
  DGSSave.OnDirectPaint := dbtnMissionTrackDirectPaint;
  DGSSave.DFColor := $ADD6EF;
  DGSApp.SetImgIndex(g_WMain99Images, 1650);
  DGSApp.Left := 369;
  DGSApp.Top := 223;
  DGSApp.OnDirectPaint := dbtnMissionTrackDirectPaint;
  DGSApp.DFColor := $ADD6EF;
{$ELSE}
  d := g_WMain99Images.Images[570];
  if d <> nil then begin
    DGameSetup.SetImgIndex(g_WMain99Images, 570);
    DGameSetup.Left := g_FScreenXOrigin - d.Width div 2;
    DGameSetup.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  DGSClose.SetImgIndex(g_WMain99Images, 133);
  DGSClose.Left := DGameSetup.Width - 20;
  DGSClose.Top := 8 + 4;

  DGSConfig.SetImgIndex(g_WMain99Images, 219);
  DGSConfig.Top := 39;
  DGSConfig.Left := 14 + 53 * DGSConfig.Tag;
  ;
  DGSFunction.SetImgIndex(g_WMain99Images, 219);
  DGSFunction.Top := 39;
  DGSFunction.Left := 14 + 53 * DGSFunction.Tag;
  DGSProtect.SetImgIndex(g_WMain99Images, 219);
  DGSProtect.Top := 39;
  DGSProtect.Left := 14 + 53 * DGSProtect.Tag;
  DGSItems.SetImgIndex(g_WMain99Images, 219);
  DGSItems.Top := 39;
  DGSItems.Left := 14 + 53 * DGSItems.Tag;
  DGSMagics.SetImgIndex(g_WMain99Images, 219);
  DGSMagics.Top := 39;
  DGSMagics.Left := 14 + 53 * DGSMagics.Tag;
  dbtnGSSay.SetImgIndex(g_WMain99Images, 219);
  dbtnGSSay.Top := 39;
  dbtnGSSay.Left := 14 + 53 * dbtnGSSay.Tag;

  DGSClose2.SetImgIndex(g_WMain99Images, 330);
  DGSClose2.Left := 11;
  DGSClose2.Top := 251;
  DGSDefault.SetImgIndex(g_WMain99Images, 330);
  DGSDefault.Left := 188;
  DGSDefault.Top := 251;
  DGSSave.SetImgIndex(g_WMain99Images, 330);
  DGSSave.Left := 283;
  DGSSave.Top := 251;
  DGSApp.SetImgIndex(g_WMain99Images, 330);
  DGSApp.Left := 362;
  DGSApp.Top := 251;  
{$IFEND}


  //设置窗口
{$IF Var_Interface = Var_Mir2}
  DDGSSetup.Width := 428;
  DDGSSetup.Height := 178;
  DDGSSetup.Left := 15;
  DDGSSetup.Top := 37;
{$ELSE}
  DDGSSetup.Width := 428;
  DDGSSetup.Height := 178;
  DDGSSetup.Left := 9;
  DDGSSetup.Top := 65; 
{$IFEND}


//  DDGSWindow.SetImgIndex(g_WMain99Images, 151);
//  DDGSWindow.Left := 268;
//  DDGSWindow.Top := 38;
  DDGSVPN.SetImgIndex(g_WMain99Images, 151);
  DDGSVPN.Left := 268;
  DDGSVPN.Top := 58;
  DDGSZIP.SetImgIndex(g_WMain99Images, 151);
  DDGSZIP.Left := 268;
  DDGSZIP.Top := 78;

  DDGSDisplay.SetImgIndex(g_WMain99Images, 309);
  DDGSDisplay.ImageWidth := DDGSDisplay.Width;
  DDGSDisplay.left := 85;
  DDGSDisplay.top := 37;
  DDGSDisplay.Height := 16;
  DDGSDisplay.width := 148;
  DDGSDisplay.UpDown.SetImgIndex(g_WMain99Images, 120);
  DDGSDisplay.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DDGSDisplay.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DDGSDisplay.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);
  DDGSXY.SetImgIndex(g_WMain99Images, 309);
  DDGSXY.ItemIndex := g_FScreenMode;
  DDGSXY.left := 85;
  DDGSXY.top := 57;
  DDGSXY.Height := 16;
  DDGSXY.width := 108;
  DDGSXY.UpDown.SetImgIndex(g_WMain99Images, 120);
  DDGSXY.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DDGSXY.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DDGSXY.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);
  DDGSBits.SetImgIndex(g_WMain99Images, 309);
  DDGSBits.left := 85;
  DDGSBits.top := 77;
  DDGSBits.Height := 16;
  DDGSBits.width := 46;
  DDGSBits.UpDown.SetImgIndex(g_WMain99Images, 120);
  DDGSBits.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DDGSBits.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DDGSBits.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DDGSMp3.SetImgIndex(g_WMain99Images, 349);
  DDGSMp3.top := 123;
  DDGSMp3.left := 234;
  DDGSMusic.SetImgIndex(g_WMain99Images, 349);
  DDGSMusic.top := 143;
  DDGSMusic.left := 234;

  DDGSMp3Close.SetImgIndex(g_WMain99Images, 151);
  DDGSMp3Close.Left := 268;
  DDGSMp3Close.Top := 126;
  DDGSMusicClose.SetImgIndex(g_WMain99Images, 151);
  DDGSMusicClose.Left := 268;
  DDGSMusicClose.Top := 146;


  //功能设置
{$IF Var_Interface = Var_Mir2}
  DDFunction.Width := 428;
  DDFunction.Height := 178;
  DDFunction.Left := 15;
  DDFunction.Top := 37;
{$ELSE}
  DDFunction.Width := 428;
  DDFunction.Height := 178;
  DDFunction.Left := 9;
  DDFunction.Top := 65;
{$IFEND}


  DDFShowName.SetImgIndex(g_WMain99Images, 151);
  DDFShowName.Left := 30;
  DDFShowName.Top := 38;
  dchkShowNameAll.SetImgIndex(g_WMain99Images, 151);
  dchkShowNameAll.Left := 102;
  dchkShowNameAll.Top := 38;
  dchkShowNameMon.SetImgIndex(g_WMain99Images, 151);
  dchkShowNameMon.Left := 102;
  dchkShowNameMon.Top := 56;
  DDFDureHint.SetImgIndex(g_WMain99Images, 151);
  DDFDureHint.Left := 30;
  DDFDureHint.Top := 56;
  DDFShift.SetImgIndex(g_WMain99Images, 151);
  DDFShift.Left := 30;
  DDFShift.Top := 74;
  DDFMapHint.SetImgIndex(g_WMain99Images, 151);
  DDFMapHint.Left := 30;
  DDFMapHint.Top := 92;
  DDFHPShow.SetImgIndex(g_WMain99Images, 151);
  DDFHPShow.Left := 30;
  DDFHPShow.Top := 110;
  DDFExp.SetImgIndex(g_WMain99Images, 151);
  DDFExp.Left := 30;
  DDFExp.Top := 128;
  DDFCtrl.SetImgIndex(g_WMain99Images, 151);
  DDFCtrl.Left := 30;
  DDFCtrl.Top := 146;

  DDFDeal.SetImgIndex(g_WMain99Images, 151);
  DDFDeal.Left := 177;
  DDFDeal.Top := 38;
  DDFGroup.SetImgIndex(g_WMain99Images, 151);
  DDFGroup.Left := 177;
  DDFGroup.Top := 56;
  DDFFriend.SetImgIndex(g_WMain99Images, 151);
  DDFFriend.Left := 177;
  DDFFriend.Top := 74;
  DDFGuild.SetImgIndex(g_WMain99Images, 151);
  DDFGuild.Left := 177;
  DDFGuild.Top := 92;

  DDFAroundHum.SetImgIndex(g_WMain99Images, 151);
  DDFAroundHum.Left := 305;
  DDFAroundHum.Top := 38;
  DDFAllyHum.SetImgIndex(g_WMain99Images, 151);
  DDFAllyHum.Left := 305;
  DDFAllyHum.Top := 56;
  DDFHideHelmet.SetImgIndex(g_WMain99Images, 151);
  DDFHideHelmet.Left := 305;
  DDFHideHelmet.Top := 74;
  dchkDDFNewChangeMap.SetImgIndex(g_WMain99Images, 151);
  dchkDDFNewChangeMap.Left := 305;
  dchkDDFNewChangeMap.Top := 92;
  DDFMagicEnd.SetImgIndex(g_WMain99Images, 151);
  DDFMagicEnd.Left := 305;
  DDFMagicEnd.Top := 110;

  DEFExp.Left := 127;
  DEFExp.Top := 127;
  DEFExp.Width := 36;
  DEFExp.Height := 16;

  //保护设置
{$IF Var_Interface = Var_Mir2}
  DDGProtect.Width := 428;
  DDGProtect.Height := 178;
  DDGProtect.Left := 15;
  DDGProtect.Top := 37;
{$ELSE}
  DDGProtect.Width := 428;
  DDGProtect.Height := 178;
  DDGProtect.Left := 9;
  DDGProtect.Top := 65;
{$IFEND}

  
  DDPHP.SetImgIndex(g_WMain99Images, 151);
  DDPHP.Left := 33;
  DDPHP.Top := 44;
  DDPMP.SetImgIndex(g_WMain99Images, 151);
  DDPMP.Left := 33;
  DDPMP.Top := 68;
  DDPHP2.SetImgIndex(g_WMain99Images, 151);
  DDPHP2.Left := 33;
  DDPHP2.Top := 92;
  DDPMP2.SetImgIndex(g_WMain99Images, 151);
  DDPMP2.Left := 33;
  DDPMP2.Top := 116;
  DDPReel.SetImgIndex(g_WMain99Images, 151);
  DDPReel.Left := 33;
  DDPReel.Top := 140;

  DDPReelItem.SetImgIndex(g_WMain99Images, 309);
  DDPReelItem.left := 323;
  DDPReelItem.top := 139;
  DDPReelItem.Height := 16;
  DDPReelItem.width := 96;

  DDPReelItem.UpDown.SetImgIndex(g_WMain99Images, 120);
  DDPReelItem.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DDPReelItem.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DDPReelItem.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DDPHPCount.Left := 141;
  DDPHPCount.Top := 43;
  DDPHPCount.Width := 46;
  DDPHPCount.Height := 16;
  DDPHPTime.Left := 193;
  DDPHPTime.Top := 43;
  DDPHPTime.Width := 38;
  DDPHPTime.Height := 16;
  DDPMPCount.Left := 141;
  DDPMPCount.Top := 67;
  DDPMPCount.Width := 46;
  DDPMPCount.Height := 16;
  DDPMPTime.Left := 193;
  DDPMPTime.Top := 67;
  DDPMPTime.Width := 38;
  DDPMPTime.Height := 16;
  DDPHP2Count.Left := 141;
  DDPHP2Count.Top := 91;
  DDPHP2Count.Width := 46;
  DDPHP2Count.Height := 16;
  DDPHP2Time.Left := 193;
  DDPHP2Time.Top := 91;
  DDPHP2Time.Width := 38;
  DDPHP2Time.Height := 16;
  DDPMP2Count.Left := 141;
  DDPMP2Count.Top := 115;
  DDPMP2Count.Width := 46;
  DDPMP2Count.Height := 16;
  DDPMP2Time.Left := 193;
  DDPMP2Time.Top := 115;
  DDPMP2Time.Width := 38;
  DDPMP2Time.Height := 16;
  DDPReelCount.Left := 141;
  DDPReelCount.Top := 139;
  DDPReelCount.Width := 46;
  DDPReelCount.Height := 16;
  DDPReelTime.Left := 193;
  DDPReelTime.Top := 139;
  DDPReelTime.Width := 38;
  DDPReelTime.Height := 16;

  //物品设置
{$IF Var_Interface = Var_Mir2}
  DDItems.Width := 428;
  DDItems.Height := 178;
  DDItems.Left := 15;
  DDItems.Top := 37;
{$ELSE}
  DDItems.Width := 428;
  DDItems.Height := 178;
  DDItems.Left := 9;
  DDItems.Top := 65;
{$IFEND}


  DDItemUpDown.SetImgIndex(g_WMain99Images, 120);
  DDItemUpDown.Top := 0;
  DDItemUpDown.Left := 413;
  DDItemUpDown.Height := DDItems.Height;

  DDItemUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DDItemUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DDItemUpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DDItemsClass.SetImgIndex(g_WMain99Images, 309);
  DDItemsClass.left := 21;
  DDItemsClass.top := 153;
  DDItemsClass.Height := 16;
  DDItemsClass.width := 70;

  DDItemsClass.UpDown.SetImgIndex(g_WMain99Images, 120);
  DDItemsClass.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DDItemsClass.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DDItemsClass.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DDitemFind.Width := 126;
  DDitemFind.Height := 16;
  DDitemFind.Left := 100;
  DDitemFind.Top := 153;

  DDPickupAllItem.SetImgIndex(g_WMain99Images, 151);
  DDPickupAllItem.Left := 266;
  DDPickupAllItem.Top := 154;

  //技能设置
{$IF Var_Interface = Var_Mir2}
  DDMagic.Width := 428;
  DDMagic.Height := 178;
  DDMagic.Left := 15;
  DDMagic.Top := 37;
{$ELSE}
  DDMagic.Width := 428;
  DDMagic.Height := 178;
  DDMagic.Left := 9;
  DDMagic.Top := 65;
{$IFEND}

  DDMCX.SetImgIndex(g_WMain99Images, 151);
  DDMCX.Left := 33;
  DDMCX.Top := 38;
  DDMBY.SetImgIndex(g_WMain99Images, 151);
  DDMBY.Left := 33;
  DDMBY.Top := 56;
  DDMLH.SetImgIndex(g_WMain99Images, 151);
  DDMLH.Left := 33;
  DDMLH.Top := 74;
  DDMLongIceHit.SetImgIndex(g_WMain99Images, 151);
  DDMLongIceHit.Left := 33;
  DDMLongIceHit.Top := 92;
  DDMCS.SetImgIndex(g_WMain99Images, 151);
  DDMCS.Left := 33;
  DDMCS.Top := 110;



  DDMMFD.SetImgIndex(g_WMain99Images, 151);
  DDMMFD.Left := 177;
  DDMMFD.Top := 38;

  DDMSnowWindLock.SetImgIndex(g_WMain99Images, 151);
  DDMSnowWindLock.Left := 177;
  DDMSnowWindLock.Top := 56;
  DDMFieryDragonLock.SetImgIndex(g_WMain99Images, 151);
  DDMFieryDragonLock.Left := 177;
  DDMFieryDragonLock.Top := 74;



  DDMYS.SetImgIndex(g_WMain99Images, 151);
  DDMYS.Left := 305;
  DDMYS.Top := 38;

  DDMAutoMagic.SetImgIndex(g_WMain99Images, 151);
  DDMAutoMagic.Left := 33;
  DDMAutoMagic.Top := 152;

  DDMTime.Width := 30;
  DDMTime.Height := 16;
  DDMTime.Left := 105;
  DDMTime.Top := 152;

  DDMMagicList.SetImgIndex(g_WMain99Images, 309);
  DDMMagicList.left := 152;
  DDMMagicList.top := 152;
  DDMMagicList.Height := 16;
  DDMMagicList.width := 104;

  DDMMagicList.UpDown.SetImgIndex(g_WMain99Images, 120);
  DDMMagicList.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DDMMagicList.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DDMMagicList.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DDAPMagicList.SetImgIndex(g_WMain99Images, 309);
  DDAPMagicList.left := 305;
  DDAPMagicList.top := 152;
  DDAPMagicList.Height := 16;
  DDAPMagicList.width := 104;

  DDAPMagicList.UpDown.SetImgIndex(g_WMain99Images, 120);
  DDAPMagicList.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DDAPMagicList.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DDAPMagicList.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  //聊天设置
{$IF Var_Interface = Var_Mir2}
  dwndSaySetup.Width := 428;
  dwndSaySetup.Height := 178;
  dwndSaySetup.Left := 15;
  dwndSaySetup.Top := 37;
{$ELSE}
  dwndSaySetup.Width := 428;
  dwndSaySetup.Height := 178;
  dwndSaySetup.Left := 9;
  dwndSaySetup.Top := 65;
{$IFEND}

  dchkSayHear.SetImgIndex(g_WMain99Images, 151);
  dchkSayHear.Left := 33;
  dchkSayHear.Top := 38;
  dchkSayWhisper.SetImgIndex(g_WMain99Images, 151);
  dchkSayWhisper.Left := 33;
  dchkSayWhisper.Top := 56;
  dchkSayCry.SetImgIndex(g_WMain99Images, 151);
  dchkSayCry.Left := 33;
  dchkSayCry.Top := 74;
  dchkSayGroup.SetImgIndex(g_WMain99Images, 151);
  dchkSayGroup.Left := 33;
  dchkSayGroup.Top := 92;
  dchkSayGuild.SetImgIndex(g_WMain99Images, 151);
  dchkSayGuild.Left := 33;
  dchkSayGuild.Top := 110;

  //任务窗口
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1716];
  if d <> nil then begin
    dwndMission.SetImgIndex(g_WMain99Images, 1716);
    dwndMission.Left := g_FScreenWidth - d.Width;
    dwndMission.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  dbtnMissionClose.SetImgIndex(g_WMain99Images, 1850);
  dbtnMissionClose.Left := 454;
  dbtnMissionClose.Top := 5;

  dbtnMissionTrack.SetImgIndex(g_WMain99Images, 1650);
  dbtnMissionTrack.Left := 22;
  dbtnMissionTrack.Top := 315;
  dbtnMissionTrack.OnDirectPaint := dbtnMissionTrackDirectPaint;
  dbtnMissionTrack.DFColor := $ADD6EF;
  dbtnMissionLogout.SetImgIndex(g_WMain99Images, 1650);
  dbtnMissionLogout.Left := 108;
  dbtnMissionLogout.Top := 315;
  dbtnMissionLogout.OnDirectPaint := dbtnMissionTrackDirectPaint;
  dbtnMissionLogout.DFColor := $ADD6EF;
  dbtnMissionAccept.SetImgIndex(g_WMain99Images, 1654);
  dbtnMissionAccept.Left := 349;
  dbtnMissionAccept.Top := 315;
  dbtnMissionAccept.OnDirectPaint := dbtnMissionTrackDirectPaint;
  dbtnMissionAccept.DFColor := $ADD6EF;
  
  dwndMissionInfo.Left := 204;
  dwndMissionInfo.Top := 86;
  dwndMissionInfo.Width := 229;
  dwndMissionInfo.Height := 213;

  DTrvwMission.WLib := g_WMain99Images;
  DTrvwMission.Left := 30;
  DTrvwMission.Top := 82;
  DTrvwMission.Width := 136;
  DTrvwMission.Height := 219;
  DTrvwMission.ImageOpenIndex := 402;
  DTrvwMission.ImageCloseIndex := 408;

  DUDwnTreeMission.SetImgIndex(g_WMain99Images, 120);
  DUDwnTreeMission.Top := 80;
  DUDwnTreeMission.Left := 167;
  DUDwnTreeMission.Height := 223;
  DUDwnTreeMission.Offset := 1;
  DUDwnTreeMission.Normal := True;

  DUDwnTreeMission.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DUDwnTreeMission.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DUDwnTreeMission.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DUDwnMissionInfo.SetImgIndex(g_WMain99Images, 120);
  DUDwnMissionInfo.Top := 80;
  DUDwnMissionInfo.Left := 434;
  DUDwnMissionInfo.Height := 223;
  DUDwnMissionInfo.Offset := 1;
  DUDwnMissionInfo.Normal := True;

  DUDwnMissionInfo.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DUDwnMissionInfo.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DUDwnMissionInfo.MoveButton.SetImgIndex(g_WMain99Images, 2144);
{$ELSE}
  d := g_WMain99Images.Images[666];
  if d <> nil then begin
    dwndMission.SetImgIndex(g_WMain99Images, 666);
    dwndMission.Left := g_FScreenWidth - d.Width;
    dwndMission.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  dbtnMissionClose.SetImgIndex(g_WMain99Images, 133);
  dbtnMissionClose.Left := dwndMission.Width - 20;
  dbtnMissionClose.Top := 8 + 4;

  dbtnMissionTrack.SetImgIndex(g_WMain99Images, 330);
  dbtnMissionTrack.Left := 17;
  dbtnMissionTrack.Top := 431;
  dbtnMissionTrack.OnDirectPaint := nil;
  dbtnMissionLogout.SetImgIndex(g_WMain99Images, 330);
  dbtnMissionLogout.Left := 97;
  dbtnMissionLogout.Top := 431;

  dbtnMissionAccept.SetImgIndex(g_WMain99Images, 156);
  dbtnMissionAccept.Left := 196;
  dbtnMissionAccept.Top := 431;

  dwndMissionInfo.Left := 211;
  dwndMissionInfo.Top := 78;
  dwndMissionInfo.Width := 242;
  dwndMissionInfo.Height := 333;

  DTrvwMission.WLib := g_WMain99Images;
  DTrvwMission.Left := 22;
  DTrvwMission.Top := 78;
  DTrvwMission.Width := 142;
  DTrvwMission.Height := 333;
  DTrvwMission.ImageOpenIndex := 402;
  DTrvwMission.ImageCloseIndex := 408;

  DUDwnTreeMission.SetImgIndex(g_WMain99Images, 120);
  DUDwnTreeMission.Top := 65;
  DUDwnTreeMission.Left := 178;
  DUDwnTreeMission.Height := 359;

  DUDwnTreeMission.UpButton.SetImgIndex(g_WMain99Images, 108);
  DUDwnTreeMission.DownButton.SetImgIndex(g_WMain99Images, 111);
  DUDwnTreeMission.MoveButton.SetImgIndex(g_WMain99Images, 315);

  DUDwnMissionInfo.SetImgIndex(g_WMain99Images, 120);
  DUDwnMissionInfo.Top := 65;
  DUDwnMissionInfo.Left := 467;
  DUDwnMissionInfo.Height := 359;

  DUDwnMissionInfo.UpButton.SetImgIndex(g_WMain99Images, 108);
  DUDwnMissionInfo.DownButton.SetImgIndex(g_WMain99Images, 111);
  DUDwnMissionInfo.MoveButton.SetImgIndex(g_WMain99Images, 315);  
{$IFEND}


  //宝箱窗口
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[2235];
  if d <> nil then begin
    dwndBox.SetImgIndex(g_WMain99Images, 2235);
    dwndBox.Left := g_FScreenXOrigin - d.Width div 2;
    dwndBox.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  dbtnBoxClose.SetImgIndex(g_WMain99Images, 1850);
  dbtnBoxClose.Left := dwndBox.Width - 21;
  dbtnBoxClose.Top := 33;
  //dbtnBoxClose.Visible := True;

  dbtnBoxItem0.Width := 34;
  dbtnBoxItem0.Height := 31;
  dbtnBoxItem0.Left := 87 - 1;
  dbtnBoxItem0.Top := 173 + 1;
  dbtnBoxItem1.Width := 34;
  dbtnBoxItem1.Height := 31;
  dbtnBoxItem1.Left := 39 - 1;
  dbtnBoxItem1.Top := 130 + 1;
  dbtnBoxItem2.Width := 34;
  dbtnBoxItem2.Height := 31;
  dbtnBoxItem2.Left := 87 - 1;
  dbtnBoxItem2.Top := 130 + 1;
  dbtnBoxItem3.Width := 34;
  dbtnBoxItem3.Height := 31;
  dbtnBoxItem3.Left := 135 - 1;
  dbtnBoxItem3.Top := 130 + 1;
  dbtnBoxItem4.Width := 34;
  dbtnBoxItem4.Height := 31;
  dbtnBoxItem4.Left := 135 - 1;
  dbtnBoxItem4.Top := 173 + 1;
  dbtnBoxItem5.Width := 34;
  dbtnBoxItem5.Height := 31;
  dbtnBoxItem5.Left := 135 - 1;
  dbtnBoxItem5.Top := 216 + 1;
  dbtnBoxItem6.Width := 34;
  dbtnBoxItem6.Height := 31;
  dbtnBoxItem6.Left := 87 - 1;
  dbtnBoxItem6.Top := 216 + 1;
  dbtnBoxItem7.Width := 34;
  dbtnBoxItem7.Height := 31;
  dbtnBoxItem7.Left := 39 - 1;
  dbtnBoxItem7.Top := 216 + 1;
  dbtnBoxItem8.Width := 34;
  dbtnBoxItem8.Height := 31;
  dbtnBoxItem8.Left := 39 - 1;
  dbtnBoxItem8.Top := 173 + 1;

  dbtnBoxItem9.Width := 34;
  dbtnBoxItem9.Height := 31;
  dbtnBoxItem9.Left := 135 - 1;
  dbtnBoxItem9.Top := 61 + 4;
  dbtnBoxItem10.Width := 34;
  dbtnBoxItem10.Height := 31;
  dbtnBoxItem10.Left := 87 - 1;
  dbtnBoxItem10.Top := 61 + 4;
  dbtnBoxItem11.Width := 34;
  dbtnBoxItem11.Height := 31;
  dbtnBoxItem11.Left := 39 - 1;
  dbtnBoxItem11.Top := 61 + 4;

  dbtnBoxNext.SetImgIndex(g_WMain99Images, 1650);
  dbtnBoxNext.Left := 64;
  dbtnBoxNext.Top := 268;
  dbtnBoxNext.OnDirectPaint := FrmDlg2.DEMailReadDirectPaint;

  dbtnBoxGetItem.SetImgIndex(g_WMain99Images, 1650);
  dbtnBoxGetItem.Left := 64;
  dbtnBoxGetItem.Top := 299;
  dbtnBoxGetItem.OnDirectPaint := FrmDlg2.DEMailReadDirectPaint;
{$ELSE}
  d := g_WMain99Images.Images[672];
  if d <> nil then begin
    dwndBox.SetImgIndex(g_WMain99Images, 672);
    dwndBox.Left := g_FScreenXOrigin - d.Width div 2;
    dwndBox.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  dbtnBoxClose.SetImgIndex(g_WMain99Images, 133);
  dbtnBoxClose.Left := dwndBox.Width - 20;
  dbtnBoxClose.Top := 8 + 4;

  dbtnBoxItem0.Width := 34;
  dbtnBoxItem0.Height := 31;
  dbtnBoxItem0.Left := 87;
  dbtnBoxItem0.Top := 173;
  dbtnBoxItem1.Width := 34;
  dbtnBoxItem1.Height := 31;
  dbtnBoxItem1.Left := 39;
  dbtnBoxItem1.Top := 130;
  dbtnBoxItem2.Width := 34;
  dbtnBoxItem2.Height := 31;
  dbtnBoxItem2.Left := 87;
  dbtnBoxItem2.Top := 130;
  dbtnBoxItem3.Width := 34;
  dbtnBoxItem3.Height := 31;
  dbtnBoxItem3.Left := 135;
  dbtnBoxItem3.Top := 130;
  dbtnBoxItem4.Width := 34;
  dbtnBoxItem4.Height := 31;
  dbtnBoxItem4.Left := 135;
  dbtnBoxItem4.Top := 173;
  dbtnBoxItem5.Width := 34;
  dbtnBoxItem5.Height := 31;
  dbtnBoxItem5.Left := 135;
  dbtnBoxItem5.Top := 216;
  dbtnBoxItem6.Width := 34;
  dbtnBoxItem6.Height := 31;
  dbtnBoxItem6.Left := 87;
  dbtnBoxItem6.Top := 216;
  dbtnBoxItem7.Width := 34;
  dbtnBoxItem7.Height := 31;
  dbtnBoxItem7.Left := 39;
  dbtnBoxItem7.Top := 216;
  dbtnBoxItem8.Width := 34;
  dbtnBoxItem8.Height := 31;
  dbtnBoxItem8.Left := 39;
  dbtnBoxItem8.Top := 173;

  dbtnBoxItem9.Width := 34;
  dbtnBoxItem9.Height := 31;
  dbtnBoxItem9.Left := 135;
  dbtnBoxItem9.Top := 61;
  dbtnBoxItem10.Width := 34;
  dbtnBoxItem10.Height := 31;
  dbtnBoxItem10.Left := 87;
  dbtnBoxItem10.Top := 61;
  dbtnBoxItem11.Width := 34;
  dbtnBoxItem11.Height := 31;
  dbtnBoxItem11.Left := 39;
  dbtnBoxItem11.Top := 61;

  dbtnBoxNext.SetImgIndex(g_WMain99Images, 156);
  dbtnBoxNext.Left := 51;
  dbtnBoxNext.Top := 273;
  dbtnBoxGetItem.SetImgIndex(g_WMain99Images, 156);
  dbtnBoxGetItem.Left := 51;
  dbtnBoxGetItem.Top := 298;
{$IFEND}

  //排行榜
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1764];
  if d <> nil then begin
    DWindowTop.SetImgIndex(g_WMain99Images, 1764);
    DWindowTop.Left := g_FScreenXOrigin - d.Width div 2;
    DWindowTop.Top := 0;
  end;

  DTopClose.SetImgIndex(g_WMain99Images, 1850);
  DTopClose.Left := 543;
  DTopClose.Top := 33;

  DTopButton0.SetImgIndex(g_WMain99Images, 1765);
  DTopButton0.Left := 30;
  DTopButton0.Top := 61;
  DTopButton1.SetImgIndex(g_WMain99Images, 1765);
  DTopButton1.Left := 102;
  DTopButton1.Top := 61;
  DTopButton2.SetImgIndex(g_WMain99Images, 1765);
  DTopButton2.Left := 174;
  DTopButton2.Top := 61;
  DTopButton3.SetImgIndex(g_WMain99Images, 1765);
  DTopButton3.Left := 246;
  DTopButton3.Top := 61;
  DTopButton4.SetImgIndex(g_WMain99Images, 1765);
  DTopButton4.Left := 318;
  DTopButton4.Top := 61;
  DTopButton5.SetImgIndex(g_WMain99Images, 1765);
  DTopButton5.Left := 390;
  DTopButton5.Top := 61;
  DTopButton6.SetImgIndex(g_WMain99Images, 1765);
  DTopButton6.Left := 462;
  DTopButton6.Top := 61;

  DTopButton7.SetImgIndex(g_WMain99Images, 1767);
  DTopButton7.Left := 30;
  DTopButton7.Top := 279;
  DTopButton8.SetImgIndex(g_WMain99Images, 1767);
  DTopButton8.Left := 102;
  DTopButton8.Top := 279;
  DTopButton9.SetImgIndex(g_WMain99Images, 1767);
  DTopButton9.Left := 174;
  DTopButton9.Top := 279;
  DTopButton10.SetImgIndex(g_WMain99Images, 1767);
  DTopButton10.Left := 246;
  DTopButton10.Top := 279;
  DTopButton11.SetImgIndex(g_WMain99Images, 1767);
  DTopButton11.Left := 318;
  DTopButton11.Top := 279;
  DTopButton12.SetImgIndex(g_WMain99Images, 1767);
  DTopButton12.Left := 390;
  DTopButton12.Top := 279;
  DTopButton13.SetImgIndex(g_WMain99Images, 1767);
  DTopButton13.Left := 462;
  DTopButton13.Top := 279;

  DTopFirst.SetImgIndex(g_WMain99Images, 1652);
  DTopFirst.Left := 23;
  DTopFirst.Top := 312;
  DTopFirst.DFColor := $ADD6EF;
  DTopFirst.OnDirectPaint := DArmOKDirectPaint;
  DTopLastly.SetImgIndex(g_WMain99Images, 1652);
  DTopLastly.Left := 315;
  DTopLastly.Top := 312;
  DTopLastly.DFColor := $ADD6EF;
  DTopLastly.OnDirectPaint := DArmOKDirectPaint;

  DTopUp.SetImgIndex(g_WMain99Images, 1650);
  DTopUp.Left := 85;
  DTopUp.Top := 312;
  DTopUp.DFColor := $ADD6EF;
  DTopUp.OnDirectPaint := DArmOKDirectPaint;
  DTopDown.SetImgIndex(g_WMain99Images, 1650);
  DTopDown.Left := 227;
  DTopDown.Top := 312;
  DTopDown.DFColor := $ADD6EF;
  DTopDown.OnDirectPaint := DArmOKDirectPaint;

  DTopMy.SetImgIndex(g_WMain99Images, 1650);
  DTopMy.Left := 461;
  DTopMy.Top := 312;
  DTopMy.DFColor := $ADD6EF;
  DTopMy.OnDirectPaint := DArmOKDirectPaint;

  DTopList1.Left := 35;
  DTopList1.Top := 106;
  DTopList1.Width := 243;
  DTopList1.Height := 168;

  DTopList2.Left := 286;
  DTopList2.Top := 106;
  DTopList2.Width := 243;
  DTopList2.Height := 168;
{$ELSE}
  d := g_WMain99Images.Images[1449];
  if d <> nil then begin
    DWindowTop.SetImgIndex(g_WMain99Images, 1449);
    DWindowTop.Left := g_FScreenXOrigin - d.Width div 2;
    DWindowTop.Top := g_FScreenYOrigin - d.Height div 2;
  end;

  DTopClose.SetImgIndex(g_WMain99Images, 143);
  DTopClose.Left := 541;
  DTopClose.Top := 24;

  DTopButton0.SetImgIndex(g_WMain99Images, 198);
  DTopButton0.Left := 18;
  DTopButton0.Top := 52;
  DTopButton1.SetImgIndex(g_WMain99Images, 198);
  DTopButton1.Left := 94;
  DTopButton1.Top := 52;
  DTopButton2.SetImgIndex(g_WMain99Images, 198);
  DTopButton2.Left := 170;
  DTopButton2.Top := 52;
  DTopButton3.SetImgIndex(g_WMain99Images, 198);
  DTopButton3.Left := 246;
  DTopButton3.Top := 52;
  DTopButton4.SetImgIndex(g_WMain99Images, 198);
  DTopButton4.Left := 322;
  DTopButton4.Top := 52;
  DTopButton5.SetImgIndex(g_WMain99Images, 198);
  DTopButton5.Left := 398;
  DTopButton5.Top := 52;
  DTopButton6.SetImgIndex(g_WMain99Images, 198);
  DTopButton6.Left := 474;
  DTopButton6.Top := 52;

  DTopButton7.SetImgIndex(g_WMain99Images, 198);
  DTopButton7.Left := 18;
  DTopButton7.Top := 81;
  DTopButton8.SetImgIndex(g_WMain99Images, 198);
  DTopButton8.Left := 94;
  DTopButton8.Top := 81;
  DTopButton9.SetImgIndex(g_WMain99Images, 198);
  DTopButton9.Left := 170;
  DTopButton9.Top := 81;
  DTopButton10.SetImgIndex(g_WMain99Images, 198);
  DTopButton10.Left := 246;
  DTopButton10.Top := 81;
  DTopButton11.SetImgIndex(g_WMain99Images, 198);
  DTopButton11.Left := 322;
  DTopButton11.Top := 81;
  DTopButton12.SetImgIndex(g_WMain99Images, 198);
  DTopButton12.Left := 398;
  DTopButton12.Top := 81;
  DTopButton13.SetImgIndex(g_WMain99Images, 198);
  DTopButton13.Left := 474;
  DTopButton13.Top := 81;

  DTopFirst.SetImgIndex(g_WMain99Images, 204);
  DTopFirst.Left := 45;
  DTopFirst.Top := 342;
  DTopLastly.SetImgIndex(g_WMain99Images, 204);
  DTopLastly.Left := 314;
  DTopLastly.Top := 342;

  DTopUp.SetImgIndex(g_WMain99Images, 198);
  DTopUp.Left := 104;
  DTopUp.Top := 342;
  DTopDown.SetImgIndex(g_WMain99Images, 198);
  DTopDown.Left := 235;
  DTopDown.Top := 342;

  DTopMy.SetImgIndex(g_WMain99Images, 198);
  DTopMy.Left := 446;
  DTopMy.Top := 342;

  DTopList1.Left := 32;
  DTopList1.Top := 153;
  DTopList1.Width := 243;
  DTopList1.Height := 168;

  DTopList2.Left := 289;
  DTopList2.Top := 153;
  DTopList2.Width := 243;
  DTopList2.Height := 168;  
{$IFEND}

end;

procedure TFrmDlg3.InitializeEx();
begin
  DMakeItemTreeView.CreateSurface(nil);
  DTrvwMission.CreateSurface(nil);
  dwndMissionInfo.CreateSurface(nil, False);
  dwndMissionInfo.Surface.Size := Point(MDLGMAXWIDTH, MDLGMAXHEIGHT);
  dwndMissionInfo.Surface.PatternSize := Point(MDLGMAXWIDTH, MDLGMAXHEIGHT);
  dwndMissionInfo.Surface.Active := True;
end;

procedure TFrmDlg3.InitializeMissionTree;
var
  DTreeNodes: pTDTreeNodes;
begin
  DTrvwMission.ClearItem;
  DTreeNodes := DTrvwMission.GetTreeNodes(nil, '主线任务', True);
  if DTreeNodes <> nil then begin
    DTreeNodes.boMaster := True;
    DTreeNodes.boOpen := True;
  end;
  DTreeNodes := DTrvwMission.GetTreeNodes(nil, '支线任务', True);
  if DTreeNodes <> nil then begin
    DTreeNodes.boMaster := True;
    DTreeNodes.boOpen := True;
  end;
  DTreeNodes := DTrvwMission.GetTreeNodes(nil, '随机任务', True);
  if DTreeNodes <> nil then begin
    DTreeNodes.boMaster := True;
    DTreeNodes.boOpen := True;
  end;
  DTreeNodes := DTrvwMission.GetTreeNodes(nil, '循环任务', True);
  if DTreeNodes <> nil then begin
    DTreeNodes.boMaster := True;
    DTreeNodes.boOpen := True;
  end;
  DTrvwMission.RefHeight;
end;

end.





