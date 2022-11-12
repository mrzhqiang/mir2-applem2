unit FState;
                                                                                                                
interface

uses
  Windows, SysUtils, StrUtils, Classes, Messages, Graphics, Controls, Forms, Dialogs, HGEBase, DES, HGE, 
  HGEGUI, HGETextures, Grids, Grobal2, ClFunc, HUtil32, FindMapPath,
  SoundUtil, IntroScn, MShare, DateUtils, DirectXGraphics, MudUtil, RSA;

type
  //THintBack = (hbConnect, hbLogin);
  TItemPaintMode = set of (pmNone, pmShowLevel, pmGrayScale, pmBlend);
  TSpotDlgMode = (dmSell, dmRepair);

  pTDiceInfo = ^TDiceInfo;
  TDiceInfo = record
    nDicePoint: Integer; //0x66C
    nPlayPoint: Integer; //0x670 当前骰子点数
    nX: Integer; //0x674
    nY: Integer; //0x678
    n67C: Integer; //0x67C
    n680: Integer; //0x680
    dwPlayTick: LongWord; //0x684
  end;

  TFrmDlg = class(TForm)
    DBackground: TDWindow;
    DWinSelServer: TDWindow;
    DWndHint: TDWindow;
    DBTHintClose: TDButton;
    DLogIn: TDWindow;
    DLoginClose: TDButton;
    DLoginOk: TDButton;
    DLoginChgPw: TDButton;
    DLoginNew: TDButton;
    DEditID: TDEdit;
    DEditPass: TDEdit;
    DLoginHome: TDButton;
    DLoginExit: TDButton;
    DNewAccount: TDWindow;
    DNewAccountOk: TDButton;
    DNewAccountCancel: TDButton;
    DEditNewId: TDEdit;
    DEditNewPasswd: TDEdit;
    DEditConfirm: TDEdit;
    DEditYourName: TDEdit;
    DEditBirthDay: TDEdit;
    DEditQuiz1: TDEdit;
    DEditAnswer1: TDEdit;
    DEditQuiz2: TDEdit;
    DEditAnswer2: TDEdit;
    DEditEMail: TDEdit;
    DEditPhone: TDEdit;
    DEditMobPhone: TDEdit;
    DEditRecommendation: TDEdit;
    DChgPw: TDWindow;
    DChgpwOk: TDButton;
    DChgpwCancel: TDButton;
    DEditChgId: TDEdit;
    DEditChgCurrentpw: TDEdit;
    DEditChgNewPw: TDEdit;
    DEditChgRepeat: TDEdit;
    DMsgDlg: TDWindow;
    DMsgDlgOk: TDButton;
    DMsgDlgCancel: TDButton;
    DSelectChr: TDWindow;
    DscSelect1: TDButton;
    DscSelect2: TDButton;
    DscSelect3: TDButton;
    DscStart: TDButton;
    DscNewChr: TDButton;
    DscEraseChr: TDButton;
    DscCredits: TDButton;
    DscExit: TDButton;
    DCreateChr: TDWindow;
    DccWarrior: TDButton;
    DccWizzard: TDButton;
    DccMonk: TDButton;
    DccJ: TDButton;
    DccM: TDButton;
    DccS: TDButton;
    DccH: TDButton;
    DccT: TDButton;
    DccMale: TDButton;
    DccFemale: TDButton;
    DccClose: TDButton;
    DccOk: TDButton;
    DRenewChr: TDWindow;
    DEditChrName: TDEdit;
    DButRenewChr: TDButton;
    DButRenewClose: TDButton;
    DBottom: TDWindow;
    DMyState: TDButton;
    DMyBag: TDButton;
    DMyMagic: TDButton;
    DOption: TDButton;
    DBotTrade: TDButton;
    DBotGuild: TDButton;
    DBotGroup: TDButton;
    DBotFriend: TDButton;
    DBotSort: TDButton;
    DTop: TDWindow;
    DTopHelp: TDButton;
    DTopGM: TDButton;
    DOpenMinmap: TDButton;
    DMiniMapDlg: TDWindow;
    DMinMap128: TDWindow;
    DTopShop: TDButton;
    DMiniMapMax: TDButton;
    DMaxMiniMap: TDWindow;
    DMaxMinimapClose: TDButton;
    DMaxMap792: TDWindow;
    DBottom2: TDWindow;
    DItemBag: TDWindow;
    DItemGrid: TDGrid;
    DGold: TDButton;
    DCloseBag: TDButton;
    DEditDlgEdit: TDEdit;
    DWndSay: TDWindow;
    DBTEdit: TDButton;
    DBTSayLock: TDButton;
    DBTSayMove: TDButton;
    DSayUpDown: TDUpDown;
    DEditChat: TDImageEdit;
    DBTFace: TDButton;
    DBTOption: TDButton;
    DWndFace: TDWindow;
    DWudItemShow: TDWindow;
    DBTItemShowClose: TDButton;
    DUserState: TDWindow;
    DCloseUserState: TDButton;
    DMerchantDlg: TDWindow;
    DMDlgUpDonw: TDUpDown;
    DMerchantDlgClose: TDButton;
    DMenuDlg: TDWindow;
    DMenuUpDonw: TDUpDown;
    DWndBuy: TDWindow;
    DBuyOK: TDButton;
    DBuyClose: TDButton;
    DBuyAdd: TDButton;
    DBuyDel: TDButton;
    DBuyEdit: TDEdit;
    DDealDlg: TDWindow;
    DDRGrid: TDGrid;
    DDGrid: TDGrid;
    DDGold: TDButton;
    DDealOk: TDButton;
    DDealClose: TDButton;
    DDealLock: TDButton;
    DDRDealLock: TDCheckBox;
    DDRDealOk: TDCheckBox;
    DGroupDlg: TDWindow;
    DGrpCreate: TDButton;
    DGrpAddMem: TDButton;
    DGrpDelMem: TDButton;
    DGroupExit: TDButton;
    DCBGroupItemDef: TDCheckBox;
    DCBGroupItemRam: TDCheckBox;
    DGrpAllowGroup: TDCheckBox;
    DGrpCheckGroup: TDCheckBox;
    DGrpDlgClose: TDButton;
    DGroupUpDown: TDUpDown;
    DGrpMemberList: TDWindow;
    DGrpUserList: TDWindow;
    DTopEMail: TDButton;
    DBTCheck1: TDButton;
    DBTCheck2: TDButton;
    DBTCheck3: TDButton;
    DBTCheck4: TDButton;
    DBTCheck5: TDButton;
    DBTCheck6: TDButton;
    DBTCheck7: TDButton;
    DBTCheck8: TDButton;
    DBTCheck9: TDButton;
    DBTCheck10: TDButton;
    DPopUpEdits: TDPopUpMemu;
    DPopUpSayList: TDPopUpMemu;
    DPopUpPlay: TDPopUpMemu;
    DStateWin: TDWindow;
    DStateWinItem: TDWindow;
    DSWWeapon: TDButton;
    DCloseState: TDButton;
    DSWDress: TDButton;
    DSWArmRingR: TDButton;
    DSWRingR: TDButton;
    DSWBelt: TDButton;
    DSWBujuk: TDButton;
    DSWHouse: TDButton;
    DSWCharm: TDButton;
    DSWCowry: TDButton;
    DSWArmRingL: TDButton;
    DSWLight: TDButton;
    DSWNecklace: TDButton;
    DSWHelmet: TDButton;
    DSWBoots: TDButton;
    DSWRingL: TDButton;
    DStateWinAbil: TDWindow;
    DStateBTItem: TDButton;
    DStateBTAbil: TDButton;
    DStateBTMagic: TDButton;
    DStateBTInfo: TDButton;
    DStateAbilOk: TDButton;
    DStateAbilExit: TDButton;
    DStateWinMagic: TDWindow;
    DStateWinInfo: TDWindow;
    DStateGrid: TDGrid;
    DStateAbilAdd3: TDButton;
    DStateAbilDel3: TDButton;
    DStateAbilAdd1: TDButton;
    DStateAbilDel1: TDButton;
    DStateAbilAdd2: TDButton;
    DStateAbilDel2: TDButton;
    DStateAbilAdd4: TDButton;
    DStateAbilDel4: TDButton;
    DStateAbilAdd5: TDButton;
    DStateAbilDel5: TDButton;
    DStateAbilAdd6: TDButton;
    DStateAbilDel6: TDButton;
    DStateInfoName: TDEdit;
    DStateInfoAge: TDEdit;
    DStateInfoAM: TDCheckBox;
    DStateInfoPM: TDCheckBox;
    DStateInfoNight: TDCheckBox;
    DStateInfoMidNight: TDCheckBox;
    DStateInfoFriend: TDCheckBox;
    DStateInfoExit: TDButton;
    DStateInfoSave: TDButton;
    DStateInfoRefPic: TDButton;
    DStateInfoUpLoadPic: TDButton;
    DStateInfoMemo: TDMemo;
    DStateInfoArea: TDComboBox;
    DStateInfoCity: TDComboBox;
    DStateInfoProvince: TDComboBox;
    DStateInfoSex: TDComboBox;
    DUserStateItem: TDWindow;
    DWeaponUS1: TDButton;
    DDressUS1: TDButton;
    DArmringRUS1: TDButton;
    DRingRUS1: TDButton;
    DBeltUS1: TDButton;
    DCharmUS1: TDButton;
    DBujukUS1: TDButton;
    DHouseUS1: TDButton;
    DCowryUS1: TDButton;
    DBootsUS1: TDButton;
    DRingLUS1: TDButton;
    DArmringLUS1: TDButton;
    DLightUS1: TDButton;
    DNecklaceUS1: TDButton;
    DHelmetUS1: TDButton;
    DUserStateInfo: TDWindow;
    DUserStateInfoName: TDEdit;
    DUserStateInfoAge: TDEdit;
    DUserStateInfoMemo: TDMemo;
    DUserStateInfoRefPic: TDButton;
    DUserStateInforeport: TDButton;
    DUserStateInfoFriend: TDCheckBox;
    DUserStateInfoMidNight: TDCheckBox;
    DUserStateInfoNight: TDCheckBox;
    DUserStateInfoPM: TDCheckBox;
    DUserStateInfoAM: TDCheckBox;
    DUserStateBTItem: TDButton;
    DUserStateBTInfo: TDButton;
    DUserStateInfoSex: TDEdit;
    DUserStateInfoArea: TDEdit;
    DUserStateInfoProvince: TDEdit;
    DUserStateInfoCity: TDEdit;
    DItemAddBag1: TDButton;
    DItemAddBag2: TDButton;
    DItemAddBag3: TDButton;
    DItemAppendBag1: TDWindow;
    DItemAppendBag2: TDWindow;
    DItemAppendBag3: TDWindow;
    DItemGrid1: TDGrid;
    DItemGrid2: TDGrid;
    DItemGrid3: TDGrid;
    DItemBagRef: TDButton;
    DItemBagShop: TDButton;
    DBTTakeHorse: TDButton;
    DBTAttackMode: TDButton;
    DWndAttackModeList: TDWindow;
    DBTAttackModeAll: TDButton;
    DBTAttackModePeace: TDButton;
    DBTAttackModeDear: TDButton;
    DBTAttackModeMaster: TDButton;
    DBTAttackModeGroup: TDButton;
    DBTAttackModeGuild: TDButton;
    DBTAttackModePK: TDButton;
    DMenuShop: TDButton;
    DMenuReturn: TDButton;
    DMenuRepairAll: TDButton;
    DMenuSuperRepairAll: TDButton;
    DMenuRepair: TDButton;
    DMenuSuperRepair: TDButton;
    DMenuBuy: TDButton;
    DMenuSell: TDButton;
    DMenuClose: TDButton;
    DMenuGrid: TDGrid;
    DMagicFront: TDButton;
    DMagicNext: TDButton;
    DUserKeyGrid1: TDGrid;
    DUserKeyGrid2: TDGrid;
    DMagicBase: TDButton;
    DMagicCbo: TDButton;
    DMagicCBOSetup: TDButton;
    DStateWinMagicCbo: TDWindow;
    DStateWinMagicCboClose: TDButton;
    DStateWinMagicCboOK: TDButton;
    DStateWinMagicCboExit: TDButton;
    DStateWinMagicCboICO: TDButton;
    DStateWinMagicCboGrid: TDGrid;
    DBtnSayAll: TDButton;
    DBtnSayWhisper: TDButton;
    DBtnSayCry: TDButton;
    DBtnSayGroup: TDButton;
    DBtnSayGuild: TDButton;
    DBtnSaySys: TDButton;
    DBtnSayHear: TDButton;
    DBtnSayCustom: TDButton;
    dchkSayLock: TDCheckBox;
    dwndSayMode: TDWindow;
    dbtnSayModeHear: TDButton;
    dbtnSayModeWhisper: TDButton;
    dbtnSayModeCry: TDButton;
    dbtnSayModeGroup: TDButton;
    dbtnSayModeGuild: TDButton;
    dbtnSayModeWorld: TDButton;
    dwndWhisperName: TDWindow;
    dbtnSelServer1: TDButton;
    dbtnSelServer2: TDButton;
    dbtnSelServer3: TDButton;
    dbtnSelServer4: TDButton;
    dbtnSelServer5: TDButton;
    dbtnSelServer6: TDButton;
    dbtnSelServer7: TDButton;
    dbtnSelServer8: TDButton;
    dbtnSelServerClose: TDButton;
    dbtnLoginLostPw: TDButton;
    DMagicSub: TDButton;
    DMakeMagicAdd1: TDButton;
    DMakeMagicAdd2: TDButton;
    DMakeMagicAdd3: TDButton;
    DMakeMagicAdd4: TDButton;
    DMakeMagicAdd5: TDButton;
    DMakeMagicAdd6: TDButton;
    DMakeMagicAdd7: TDButton;
    DMakeMagicAdd8: TDButton;
    DMakeMagicAdd9: TDButton;
    DMakeMagicAdd10: TDButton;
    RState: TRSA;
    DButtonTop: TDButton;
    DCreateChr2: TDWindow;
    DEditChrName2: TDEdit;
    DccOk2: TDButton;
    DccClose2: TDButton;
    DccManWarrior: TDButton;
    DccManWizzard: TDButton;
    DccManMonk: TDButton;
    DccWoManWarrior: TDButton;
    DccWoManWizzard: TDButton;
    DccWoManMonk: TDButton;
    DTopStatusEXP: TDButton;
    DTopStatusPOW: TDButton;
    DTopStatusSC: TDButton;
    DTopStatusAC: TDButton;
    DTopStatusDC: TDButton;
    DTopStatusHIDEMODE: TDButton;
    DTopStatusSTONE: TDButton;
    DTopStatusMC: TDButton;
    DTopStatusMP: TDButton;
    DTopStatusMAC: TDButton;
    DTopStatusHP: TDButton;
    DTopStatusDAMAGEARMOR: TDButton;
    DTopStatusDECHEALTH: TDButton;
    DTopStatusCOBWEB: TDButton;
    DStateBTHorse: TDButton;
    DStateWinHorse: TDWindow;
    DHorseRein: TDButton;
    DHorseBell: TDButton;
    DHorseSaddle: TDButton;
    DHorseDecoration: TDButton;
    DHorseNail: TDButton;
    DUserStateBTHorse: TDButton;
    DUserStateHorse: TDWindow;
    DUSHorseRein: TDButton;
    DUSHorseBell: TDButton;
    DUSHorseSaddle: TDButton;
    DUSHorseDecoration: TDButton;
    DUSHorseNail: TDButton;
    DNewAccountClose: TDButton;
    DBotMiniMap: TDButton;
    DBotAddAbil: TDButton;
    DBotMusic: TDButton;
    DMiniMap: TDWindow;
    DBotWndSay: TDWindow;
    DCloseSayHear: TDButton;
    DCloseSayWhisper: TDButton;
    DCloseSayCry: TDButton;
    DCloseSayGuild: TDButton;
    DCloseSayGroup: TDButton;
    DStateBTState: TDButton;
    DStateWinState: TDWindow;
    DOpenCompoundItem: TDButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DWinSelServerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DWinSelServerClick(Sender: TObject; X, Y: Integer);
    procedure dbtnSelServer1ClickSound(Sender: TObject;
      Clicksound: TClickSound);
    procedure DWinSelServerDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DWinSelServerExitClick(Sender: TObject; X, Y: Integer);
    procedure DWndHintDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure dbtnSelServer1Click(Sender: TObject; X, Y: Integer);
    procedure DBTHintCloseClick(Sender: TObject; X, Y: Integer);
    procedure DLogInDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DLoginHomeDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DLoginCloseClick(Sender: TObject; X, Y: Integer);
    procedure DNewAccountDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DWndHintVisible(Sender: TObject; boVisible: Boolean);
    procedure DWndHintKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DMsgDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMsgDlgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DscSelect1Click(Sender: TObject; X, Y: Integer);
    procedure DCreateChrDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DccWarriorDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DRenewChrDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DRenewChrClick(Sender: TObject; X, Y: Integer);
    procedure DMyStateDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DBottomDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopGMMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DccWarriorMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMyStateMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DTopMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DOpenMinmapDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DOpenMinmapClick(Sender: TObject; X, Y: Integer);
    procedure DMiniMapDlgDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMinMap128DirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMinMap128MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMinMap128MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMinMap128MouseEntry(Sender: TObject; MouseEntry: TMouseEntry);
    procedure DMaxMinimapCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMiniMapMaxClick(Sender: TObject; X, Y: Integer);
    procedure DMiniMapDlgInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DMaxMiniMapDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMaxMap792DirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMaxMap792MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMaxMap792MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBottom2EndDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DBottom2DirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMyStateClick(Sender: TObject; X, Y: Integer);
    procedure DItemBagDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
    procedure DItemGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DItemGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DItemGridDblClick(Sender: TObject);
    procedure DGoldClick(Sender: TObject; X, Y: Integer);
    procedure DBackgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBackgroundBackgroundClick(Sender: TObject);
    procedure DMsgDlgInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DWndSayDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBTSayMoveMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DEditChatChange(Sender: TObject);
    procedure DBTEditDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBTFaceClick(Sender: TObject; X, Y: Integer);
    procedure DBTOptionClick(Sender: TObject; X, Y: Integer);
    procedure DEditChatClick(Sender: TObject; X, Y: Integer);
    procedure DEditChatCheckItem(Sender: TObject; ItemIndex: Integer; var ItemName: string);
    procedure DBTEditClick(Sender: TObject; X, Y: Integer);
    procedure DWndFaceDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWndFaceClick(Sender: TObject; X, Y: Integer);
    procedure DWndFaceMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DEditChatDrawEditImage(Sender: TObject; ImageSurface: TDXTexture; Rect: TRect;
      ImageIndex: Integer);
    procedure DBTSayLockClick(Sender: TObject; X, Y: Integer);
    procedure DBTSayLockDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWudItemShowDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWudItemShowVisible(Sender: TObject; boVisible: Boolean);
    procedure DTopShopClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DSWWeaponDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DStateWinItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DUserStateDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWeaponUS1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DMerchantDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMerchantDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DMerchantDlgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DMerchantDlgClick(Sender: TObject; X, Y: Integer);
    procedure DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DWndBuyDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBuyOKClick(Sender: TObject; X, Y: Integer);
    procedure DBuyAddClick(Sender: TObject; X, Y: Integer);
    procedure DBuyEditChange(Sender: TObject);
    procedure DWndBuyVisible(Sender: TObject; boVisible: Boolean);
    procedure DDealDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DDRGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DDGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DDGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DDGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DDGoldClick(Sender: TObject; X, Y: Integer);
    procedure DDealCloseClick(Sender: TObject; X, Y: Integer);
    procedure DDealOkClick(Sender: TObject; X, Y: Integer);
    procedure DDealLockClick(Sender: TObject; X, Y: Integer);
    procedure DGroupDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DCBGroupItemDefClick(Sender: TObject; X, Y: Integer);
    procedure DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
    procedure DGrpCheckGroupClick(Sender: TObject; X, Y: Integer);
    procedure DGrpMemberListDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DGroupDlgVisible(Sender: TObject; boVisible: Boolean);
    procedure DGrpCreateClick(Sender: TObject; X, Y: Integer);
    procedure DGrpAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DGrpDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DGroupExitClick(Sender: TObject; X, Y: Integer);
    procedure DGrpUserListDblClick(Sender: TObject);
    procedure DGrpMemberListDblClick(Sender: TObject);
    procedure DBotGuildClick(Sender: TObject; X, Y: Integer);
    procedure DBuyEditKeyPress(Sender: TObject; var Key: Char);
    procedure DBTCheck1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotSortClick(Sender: TObject; X, Y: Integer);
    procedure DBTCheck1Click(Sender: TObject; X, Y: Integer);
    procedure DTopEMailClick(Sender: TObject; X, Y: Integer);
    procedure DTopEMailDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DPopUpEditsPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
    procedure DEditIDMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DWndSayMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DWndSayMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DPopUpSayListPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
    procedure DGrpUserListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGrpMemberListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGroupDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGrpMemberListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DGrpMemberListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DGrpUserListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DGrpUserListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DPopUpPlayPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
    procedure DSWWeaponMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DStateWinItemMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DItemBagMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DStateWinDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateBTItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateBTItemClick(Sender: TObject; X, Y: Integer);
    procedure DStateGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DStateAbilAdd3DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateAbilExitClick(Sender: TObject; X, Y: Integer);
    procedure DStateAbilAdd1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DStateAbilAdd1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DStateInfoNameChange(Sender: TObject);
    procedure DStateInfoExitClick(Sender: TObject; X, Y: Integer);
    procedure DStateInfoSaveClick(Sender: TObject; X, Y: Integer);
    procedure DStateInfoRefPicClick(Sender: TObject; X, Y: Integer);
    procedure DUserStateItemClick(Sender: TObject; X, Y: Integer);
    procedure DUserStateItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DUserStateItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUserStateBTItemClick(Sender: TObject; X, Y: Integer);
    procedure DUserStateBTInfoDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUserStateVisible(Sender: TObject; boVisible: Boolean);
    procedure DItemAddBag1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DItemAddBag1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DItemAddBag1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DItemBagRefClick(Sender: TObject; X, Y: Integer);
    procedure DItemBagShopClick(Sender: TObject; X, Y: Integer);
    procedure DBTAttackModeDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWndAttackModeListDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBTAttackModeClick(Sender: TObject; X, Y: Integer);
    procedure DBTAttackModeGuildClick(Sender: TObject; X, Y: Integer);
    procedure DBTTakeHorseClick(Sender: TObject; X, Y: Integer);
    procedure DBTTakeHorseDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DItemBagMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DMenuDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMenuDlgVisible(Sender: TObject; boVisible: Boolean);
    procedure DMenuShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMenuShopClick(Sender: TObject; X, Y: Integer);
    procedure DMenuGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DMenuSellClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinVisible(Sender: TObject; boVisible: Boolean);
    procedure DItemBagVisible(Sender: TObject; boVisible: Boolean);
    procedure DMenuGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DMenuGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DBuyAddDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMagicFrontClick(Sender: TObject; X, Y: Integer);
    procedure DStateGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DUserKeyGrid1GridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DUserKeyGrid1GridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DWudItemShowMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DBottomEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMagicBaseDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMagicBaseClick(Sender: TObject; X, Y: Integer);
    procedure DMagicCBOSetupClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinMagicVisible(Sender: TObject; boVisible: Boolean);
    procedure DStateWinMagicCboICODirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateWinMagicCboICOInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
    procedure DStateWinMagicCboGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DStateWinMagicCboDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateWinMagicCboICOClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinMagicCboGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DStateWinMagicCboOKClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinMagicCboVisible(Sender: TObject; boVisible: Boolean);
    procedure DStateWinMagicCboICOMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DStateWinMagicCboGridGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DWndSayInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
    procedure DBtnSayAllDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBtnSayAllClick(Sender: TObject; X, Y: Integer);
    procedure dchkSayLockChange(Sender: TObject);
    procedure dwndSayModeDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dbtnSayModeHearDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dbtnSayModeHearClick(Sender: TObject; X, Y: Integer);
    procedure DEditChatKeyPress(Sender: TObject; var Key: Char);
    procedure DEditChatVisible(Sender: TObject; boVisible: Boolean);
    procedure dwndWhisperNameDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dwndWhisperNameVisible(Sender: TObject; boVisible: Boolean);
    procedure DEditChatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DWndSayEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUserKeyGrid1GridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DUserKeyGrid2DblClick(Sender: TObject);
    procedure DBottom2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DStateGridGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DWinSelServerVisible(Sender: TObject; boVisible: Boolean);
    procedure DLoginNewClick(Sender: TObject; X, Y: Integer);
    procedure DTopHelpClick(Sender: TObject; X, Y: Integer);
    procedure DLoginHomeClick(Sender: TObject; X, Y: Integer);
    procedure DLoginChgPwClick(Sender: TObject; X, Y: Integer);
    procedure dbtnLoginLostPwClick(Sender: TObject; X, Y: Integer);
    procedure DTopGMClick(Sender: TObject; X, Y: Integer);
    procedure DMakeMagicAdd1Click(Sender: TObject; X, Y: Integer);
    procedure DButtonTopClick(Sender: TObject; X, Y: Integer);
    procedure DTopShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DccManWarriorDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopStatusEXPDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopStatusEXPMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DUSHorseReinDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUSHorseReinMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure dbtnSelServer1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DCreateChrVisible(Sender: TObject; boVisible: Boolean);
    procedure DButRenewChrDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBTHintCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopHelpDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotAddAbilDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotMiniMapClick(Sender: TObject; X, Y: Integer);
    procedure DMiniMapDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMiniMapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DMiniMapMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DMiniMapMouseEntry(Sender: TObject; MouseEntry: TMouseEntry);
    procedure DBottomMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DBotWndSayDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotWndSayInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
    procedure DBotWndSayMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DBotWndSayMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DCloseSayHearDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DCloseSayHearClick(Sender: TObject; X, Y: Integer);
    procedure DCloseSayHearMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DBTItemShowCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateInfoRefPicDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMagicFrontDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMDlgUpDonwPositionChange(Sender: TObject);
    procedure DMDlgUpDonwEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DOpenCompoundItemClick(Sender: TObject; X, Y: Integer);
    procedure DOpenCompoundItemDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DItemBagRefDirectPaint(Sender: TObject; dsurface: TDXTexture);
  private
    FCompoundItemBtnTick: LongWord;
    FCompoundItemBtnIndex: Integer;
{$IF Var_Interface = Var_Mir2}
    FMagicCboKeyIndex: Byte;
{$IFEND}
    procedure DSayMoveSize(Y: Integer);
  public
    //    SelServerIndex: Integer;
    //    MoveServerIndex: Integer;
        //WndHintBack: THintBack;
    m_nDiceCount: Integer;
    m_boPlayDice: Boolean;
    m_Dice: array[0..9] of TDiceInfo;

    HintBack: TSceneType;
    boHintFocus: Boolean;
    sHintStr: string;
    DlgEditText: string;
    DlgChecked: Boolean;
    YesResult: TModalResult;
    NoResult: TModalResult;
    msglx, msgly: Integer;
    //    ViewDlgEdit: Boolean;
    MsgText: string;
    btWuXin: Byte;
    btJob: Byte;
    btSex: Byte;
    btAniIndex: Integer;
    dwStartTime: LongWord;
    RenewChrIdx: Integer;
    m_dwBlinkTime: LongWord;
    m_boViewBlink: Boolean;
    TempList: TList;
    boMaxMinimapShow: Boolean;
    m_nMouseIdx: Integer;
    m_dwDblClick: LongWord;
    m_boRING: Boolean;
    m_boARMRING: Boolean;
    //m_MsgList: TStringList;
    //m_DMsgSurface: TDXTexture;
    BoGuildChat: Boolean;
    BoMakeDrugMenu: Boolean;
    //boShowDlg: Boolean;
    nShowDlgCount: Integer;
    FaceSelectindex: Integer;
    pClickName: pTClickName;
    nClickNameIndex: Integer;
    pClickItem: pTClickItem;
    nClickItemIndex: Integer;
    pClickIndex: Integer;
    HintDrawList: TList;
    boSelectGuildRankName: Boolean;
    boSelectGuildName: Boolean;
    //    boSelectUserName: Boolean;
    //    nUserNameLen: integer;
    nGuildNameLen: Integer;
    nGuildRankNameLen: Integer;
    nUS1UserNameLen: integer;
    nUS1GuildNameLen: Integer;
    nUS1GuildRankNameLen: Integer;
    UserState1: TClientStateInfo;
    MerchantName: string;
    MDlgStr: string;
    MDlgPoints: TList;
    //    MDlgNewPoints: TList;
    MDlgDraws: TList;
    MDlgRefTime: LongWord;
    RequireAddPoints: Boolean;
    MerchantHeight: Integer;
    //    SelectMenuStr: string;
        //    MoveMenuStr: string;
    MDlgMove: TClickPoint;
    MDlgSelect: TClickPoint;
    //    MDlgNewMoveRect: TRect;
    //    MDlgNewSelectRect: TRect;
    LastestClickTime: LongWord;
    SpotDlgMode: TSpotDlgMode;
    BuyGoods: TClientGoods;
    //    BuyIndex: Integer;
    GroupListIndex: Integer;
    GroupListMoveIndex: Integer;
    UserListIndex: Integer;
    UserListMoveIndex: Integer;
    RefGroupList: TStringList;
    GuildIndex: Integer;
    GuildName: string;
    StatePage: Integer;
    UserStatePage: Integer;
    boCheckShow: Boolean;
    boNewEMail: Boolean;
    SayDlgDown: Boolean;
    StateAbilIndex: Integer;
    AddressList: TStringList;
    TempAddressList: TStringList;
    NakedCount: Integer;
    NakedBackCount: Integer;
    NakedAbil: TNakedAbil;

    TempRealityInfo: TUserRealityInfo;
    MyHDInfoSurface: TDXImageTexture;
    UserHDInfoSurface: TDXImageTexture;
    //    MyHDDIB: TBitmap;
    //    UserHDDIB: TBitmap;
    boSuperRepair: Boolean;
    MDlgVisible: Boolean;
    boOpenItemBag: Boolean;
    boOpenStatus: Boolean;
    NpcBindGold: Boolean;
    NpcGoodsIdx: Byte;
    NpcGoodsList: TList;
    NpcGoodItems: array of TClientGoods;
    NpcReturnItemList: TList;
    NpcReturn: Boolean;
    MagicList1: TQuickStringList;
    MagicList2: TQuickStringList;
    MagicPage: Byte;
    MagicMaxPage: Byte;
    // 普通技能、连击技能的切换索引
    DMagicIndex: Byte;
    CboMagicList: TCboMagicListInfo;

    FShowItemEffectTick: LongWord;
    FShowItemEffectIndex: Integer;
    FSayNameIndex: Integer;
    FHelpTick: LongWord;
    NAHelps: TStringList;
    procedure RefMenuSellBtns;
    procedure ClearReturnItemList();
    procedure ClearGoodsList();
    procedure RefGoodItems();
    procedure Initialize;
    procedure InitializeEx();
    function DMessageDlg(msgstr: string; DlgButtons: TMsgDlgButtons; MsgLen: Integer = 70; EClass:
      TDEditClass = deNone; defmsg: string = ''): TModalResult;
    function DModalMessageDlg(nShowCount: Integer; msgstr: string; DlgButtons: TMsgDlgButtons; MsgLen: Integer = 70; EClass:
      TDEditClass = deNone; defmsg: string = ''): TModalResult;
    procedure DModalDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DModalDlgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DModalDlgChange(Sender: TObject);
    procedure OpenItemBag;
    procedure OpenMyStatus;
    procedure OpenUserState(UserState: PTClientStateInfo);
    procedure RefItemPaint(dsurface, d: TDXTexture; X, Y, ax, ay: Integer; NewClientItem: pTNewClientItem;
      boCount: Boolean = True; PaintMode: TItemPaintMode = [pmNone]; pRect: PRect = nil);
    //procedure DealItemReturnBag(mitem: TNewClientItem);
    procedure DealZeroGold;
    procedure DropMovingItem;
    procedure DrawZoomDlg(DModalWindow: TDModalWindow);
    procedure CancelItemMoving;
    procedure OpenSayItemShow(mitem: TNewClientItem);
    procedure ShowMDlg(nResID, nWidth, nHeight: Integer; mname, msgstr: string);
    procedure CloseMDlg;
    function GetBuyCount(nQueryCount: Integer; ClientGoods: TClientGoods; boBindGold: Boolean): Integer;
    function GetBuyGoodsIndex(ClientGoods: TClientGoods): Integer;
    procedure OpenDealDlg;
    procedure CloseDealDlg;
    procedure SetGroupWnd();
    procedure CreateGroup(sChrName: string);
    procedure OpenPlayPopupMemu(AC: TObject; nX, nY: Integer);
    procedure PageChanged;
    procedure UserPageChanged;
    procedure LoadAddressList();
    procedure ClearAddressList();
    procedure RefNakedWindow();
    procedure RefRealityInfo();
    procedure RefPhotoSurface(FileName: string; var HDInfoSurface: TDXImageTexture);
    procedure RefAddBagWindow();
    procedure RefJobMagic(btJob: Byte);
    function UserKeyInfoIsValid(nIdx: Byte; var nIndex: Integer): Boolean;
    procedure RefCheckButtonXY();
    procedure RefStatusInfoForm();
    procedure SetMiniMapSize(flag: Byte);
  end;

var
  FrmDlg: TFrmDlg;
  sXML3: string = '2.';
  sXML6: string = 'P';

implementation

{$R *.dfm}

uses
  ClMain, Share, Actor, GameSetup, FState2, WMFile, cliUtil, Clipbrd, EDcodeEx, Jpeg, FState3, wil,
  MNSHare, LShare, ShellAPI, MD5Unit, FState4, FWeb, Registry, Bass, IniFiles, ClientSetup;

const
  MDLGCLICKOX = 25;
  MDLGCHICKOY = 1;
  MDLGMOVEIMAGE = 622;
  MDLGCHICKIMAGE = 623;


const
  DMsgDefMaxLen = 180;
  DMsgDefLeft = 40;
  DMsgDefWidth = 260;
  DMsgDefTop = 28;
  DMsgDefHeigth = 102;

const
{$IF Var_Interface = Var_Mir2}
  DEFMERCHANTMAXHEIGHT = 140;
  DEFMERCHANTMAXWIDTH = 354;
  DEFMDLGMAXWIDTH = 354;
  MDLGMAXHEIGHT = 1024;
{$ELSE}
  DEFMERCHANTMAXHEIGHT = 306;
  DEFMERCHANTMAXWIDTH = 242;
  DEFMDLGMAXWIDTH = 242;
  MDLGMAXHEIGHT = 1024;
{$IFEND}

var
  g_MERCHANTMAXHEIGHT: Integer = DEFMERCHANTMAXHEIGHT;
  g_MERCHANTMAXWIDTH: Integer = DEFMERCHANTMAXWIDTH;

procedure TFrmDlg.CancelItemMoving;
var
  idx, n: Integer;
begin
  if g_boItemMoving then begin
    idx := g_MovingItem.Index2;
    if g_MovingItem.ItemType = mtStateItem then begin
      n := -(idx + 1);
      if n in [0..MAXUSEITEMS - 1] then begin
        g_UseItems[n] := g_MovingItem.Item;
      end else
      if n in [16..20] then begin
        if g_UseItems[U_HOUSE].S.Name <> '' then begin
          g_UseItems[U_HOUSE].UserItem.HorseItems[n - 16] := UserItemToHorseItem(@g_MovingItem.Item.UserItem);
        end;
      end;
    end
    else if g_MovingItem.ItemType = mtBagItem then begin
      AddItemBag(g_MovingItem.Item, idx);
    end;
    ArrangeItembag;
    ClearMovingItem();
  end;
end;

procedure TFrmDlg.DBackgroundBackgroundClick(Sender: TObject);
var
  dropgold: Integer;
  valstr: string;
begin
  if g_boItemMoving then begin
    DBackground.WantReturn := True;
    if (g_MovingItem.ItemType = mtBagGold) and (g_MovingItem.Item.S.name = g_sGoldName) {'金币'} then begin
      g_boItemMoving := FALSE;
      g_MovingItem.Item.S.name := '';
      if mrYes = DMessageDlg('你想丢弃多少数量' + g_sGoldName + '?', [mbYes, mbNo, mbAbort], 10, deInteger) then begin
        GetValidStrVal(DlgEditText, valstr, [' ']);
        dropgold := StrToIntDef(valstr, 0);
        if dropgold > 0 then
          frmMain.SendDropGold(dropgold);
      end;
    end
    else if (g_MovingItem.ItemType = mtBagItem) then begin
      {if DDealDlg.Visible then begin
        if mrYes = DMessageDlg('是否确定丢弃[' + g_MovingItem.Item.S.name + ']?', [mbYes, mbNo]) then
          DropMovingItem;
      end else       }
      DropMovingItem;
    end
    else if (g_MovingItem.ItemType = mtStateMagic) or (g_MovingItem.ItemType = mtBottom) then begin
      g_boItemMoving := FALSE;
    end;
  end;
end;

procedure TFrmDlg.DBackgroundMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if g_boItemMoving then begin
    DBackground.WantReturn := True;
  end;
end;

procedure TFrmDlg.DBotAddAbilDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if (g_nNakedCount = 0) and (g_nNakedBackCount = 0) then begin
      Visible := False;
      Exit;
    end;
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex + 1];
      end
      else begin
        if (((GetTickCount - AppendTick) mod 400) > 200) then begin
          d := WLib.Images[FaceIndex + 2];
        end else
          d := WLib.Images[FaceIndex];
      end;
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBotGuildClick(Sender: TObject; X, Y: Integer);
begin
  if FrmDlg3.DGuildDlg.Visible then begin
    FrmDlg3.DGuildDlg.Visible := FALSE;
  end
  else if GetTickCount > g_dwQueryMsgTick then begin
    g_dwQueryMsgTick := GetTickCount + 3000;
    //frmMain.SendGuildMemberList(g_GuildMemberIndex);
    frmMain.SendGuildDlg(g_GuildNoticeIndex);
  end;
end;

procedure TFrmDlg.DBotMiniMapClick(Sender: TObject; X, Y: Integer);
var
  d: TDXTexture;
begin
{  if GetTickCount < TDControl(Sender).AppendTick then begin
    Exit;
  end;
  TDControl(Sender).AppendTick := GetTickCount + 1000;  }
  if not DMiniMap.Visible then begin
    if g_nMiniMapIndex > 10000 then
      d := g_WUIBImages.Images[g_nMiniMapIndex - 10000]
    else if g_nMiniMapIndex >= 1000 then
      d := g_WMyMMapImages.Images[g_nMiniMapIndex - 1000]
    else
      d := g_WMMapImages.Images[g_nMiniMapIndex];
    if d = nil then begin
      DScreen.AddSysMsg('没有可用地图.', $32F4);
      Exit;
    end;
    g_nViewMinMapLv := 1;
    SetMiniMapSize(1);
  end
  else begin
    if g_nViewMinMapLv >= 2 then begin
      g_nViewMinMapLv := 0;
      SetMiniMapSize(0);
    end
    else begin
      Inc(g_nViewMinMapLv);
      SetMiniMapSize(2);
    end;
  end;
end;

procedure TFrmDlg.DMagicBaseClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if DMagicIndex <> Tag then begin
      DMagicIndex := Tag;
      PlaySound(s_glass_button_click);
      if Tag <> 1 then
        DStateWinMagicCbo.Visible := False;
    end;
  end;
end;

procedure TFrmDlg.DMagicBaseDirectPaint(Sender: TObject; dsurface: TDXTexture);
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
      if DMagicIndex <> tag then begin
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
    if WLib <> nil then begin
      idx := FaceIndex;
      FColor := DFMoveColor;
      nTop := 2;
      if DMagicIndex <> tag then begin
        FColor := DFColor;
        nTop := 4;
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
          SurfaceY(Top) + (Height - TextHeight(Caption)) div 2 + nTop, Caption, FColor);
      end;
    end;
  end;
{$IFEND}
end;

procedure TFrmDlg.DMagicCBOSetupClick(Sender: TObject; X, Y: Integer);
begin
  DStateWinMagicCbo.Visible := not DStateWinMagicCbo.Visible;
end;

procedure TFrmDlg.DBotSortClick(Sender: TObject; X, Y: Integer);
{var
  ClientCheckMsg: pTClientCheckMsg;  }
{var
  GroupMember: pTGroupMember;
  i: Integer;    }
begin
  FrmDlg3.dwndMission.Visible := not FrmDlg3.dwndMission.Visible;
  //  GMManageShow;
    {for I := 0 to 6 do begin
      New(GroupMember);
      GroupMember.isScreen := nil;
      GroupMember.ClientGroup.UserName := '测试号' + inttostr(i);
      GroupMember.ClientGroup.UserID := 1234;
      GroupMember.ClientGroup.WuXin := Random(5) + 1;
      GroupMember.ClientGroup.Level := Random(255);
      GroupMember.ClientGroup.HP := 255;
      GroupMember.ClientGroup.MP := 255;
      GroupMember.ClientGroup.Maxhp := 300;
      GroupMember.ClientGroup.MaxMP := 255;
      GroupMember.ClientGroup.btSex := Random(2);
      GroupMember.ClientGroup.btJob := Random(3);
      g_GroupMembers.Add(GroupMember);
    end;
    FrmDlg2.m_boChangeGroup := True;  }
    {New(ClientCheckMsg);
    ClientCheckMsg.str := '[测试人物] 想请你一起组队,是否同意?';
    ClientCheckMsg.EndTime := GetTickCount + 10 * 1000;
    ClientCheckMsg.MsgIndex := 0;
    ClientCheckMsg.MsgType := Random(2);
    g_QuestMsgList.Add(ClientCheckMsg);    }
    //FrmDlg2.DWndMakeItem.Visible := not FrmDlg2.DWndMakeItem.Visible;
    //DMessageDlg('该功能尚未正式开放！敬请期待！', []);
end;

procedure TFrmDlg.DBottom2DirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);

    {with dsurface.Canvas do begin
      SetBkMode(Handle, TRANSPARENT);
      BoldTextOutEx(dsurface, ax + 24, ay + 48, clYellow, clBlack, '当前登录游戏区：');
      BoldTextOutEx(dsurface, ax + 124, ay + 48, clWhite, clBlack, g_sServerName);
      Release;
    end; }
  end;
end;

procedure TFrmDlg.DBottom2EndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[29];
    if d <> nil then
      DSurface.Draw(SurfaceX(Left) + 68, SurfaceY(Top) + 10, d.ClientRect, d, True);
    
    //boCheckShow := (GetTickCount - DBottom2.AppendTick) mod 600 > 300;
  end;
end;

procedure TFrmDlg.DBottom2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDWindow do begin
    x := x - left;
    y := y - top;
  end;
  if Sender = DBottom2 then begin
    with DUserKeyGrid2 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DUserKeyGrid2DblClick(DUserKeyGrid2);
      end;
    end;
  end
  else if Sender = DBottom then begin
    with DUserKeyGrid1 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DUserKeyGrid2DblClick(DUserKeyGrid1);
      end else
      if (x >= 208) and (y >= 230) and (X <= 208 + g_FScreenWidth - 436) and (y <= 230 + 16) then begin
        if not DEditChat.Visible then begin
          DEditChat.Visible := True;
          DEditChat.SetFocus;
          case g_SayMode of
            usm_Hear: DEditChat.Text := '';
            usm_Whisper: DEditChat.Text := '/';
            usm_Cry: DEditChat.Text := '!';
            usm_Group: DEditChat.Text := '!!';
            usm_Guild: DEditChat.Text := '!~';
            usm_World: DEditChat.Text := g_Cmd_AllMsg + ' ';
          end;
        end
        else
          DEditChat.SetFocus;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBottomDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
{$IF Var_Interface = Var_Mir2}
const
  AttackModeName: array[0..6] of string[8] = ('全体攻击', '和平攻击', '夫妻攻击', '师徒攻击', '编组攻击', '行会攻击', '红名攻击');
{$IFEND}
var
  d: TDXTexture;
  ax, ay: integer;
{$IF Var_Interface = Var_Mir2}
  rc: TRect;
  r: Extended;
  sStr: string;
  I: Integer;
{$IFEND}
begin
  // 底部状态栏
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);

{$IF Var_Interface = Var_Mir2}
    // 每两秒钟提示一次未读信件
    if GetTickCount > AppendTick then begin
      AppendTick := GetTickCount + 2000;
      boNewEMail := False;
      for I := 0 to g_EMailList.Count - 1 do begin
        if not pTEMailInfo(g_EMailList.Objects[i]).ClientEMail.boRead then begin
          boNewEMail := True;
          break;
        end;
      end;
    end;
    // 底部物品栏 1、2、3、4、5、6 格子编号
    d := g_WMain99Images.Images[1822];
    if d <> nil then
        dsurface.Draw( 283, ay + 79, d.ClientRect, d, True);
    d := g_WMain99Images.Images[1823];
    if d <> nil then
        dsurface.Draw(326, ay + 79, d.ClientRect, d, True);
    d := g_WMain99Images.Images[1824];
    if d <> nil then
        dsurface.Draw(370, ay + 79, d.ClientRect, d, True);
    d := g_WMain99Images.Images[1825];
    if d <> nil then
        dsurface.Draw(414, ay + 79, d.ClientRect, d, True);
    d := g_WMain99Images.Images[1826];
    if d <> nil then
        dsurface.Draw(457, ay + 79, d.ClientRect, d, True);
    d := g_WMain99Images.Images[1827];
    if d <> nil then
        dsurface.Draw(502, ay + 79, d.ClientRect, d, True);
    // 服务器时间
    d := nil;
    case HourOf(g_ServerDateTime) of
      0..6: d := g_WMain99Images.Images[1862]; //早上
      7..11: d := g_WMain99Images.Images[1859]; //白天
      12..18: d := g_WMain99Images.Images[1860]; //傍晚
      19..23: d := g_WMain99Images.Images[1861]; //晚上
    end;
    if d <> nil then
      dsurface.Draw(g_FScreenWidth - 52, ay + 79, d.ClientRect, d, FALSE);

    if g_MySelf <> nil then begin
      // 左侧 HP MP 状态球
      if (g_MySelf.m_Abil.MaxHP > 0) and (g_MySelf.m_Abil.MaxMP > 0) then begin
        if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level < 28) then begin //武士
          d := g_WMain99Images.Images[1864];
          if d <> nil then begin
            rc := d.ClientRect;
            rc.Right := d.ClientRect.Right - 2;
            dsurface.Draw(38, ay + 90, rc, d, FALSE);
          end;
          d := g_WMain99Images.Images[1865];
          if d <> nil then begin
            rc := d.ClientRect;
            rc.Right := d.ClientRect.Right - 2;
            rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP * (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
            dsurface.Draw(38, ay + 90 + rc.Top, rc, d, FALSE);
          end;
        end else begin
          d := g_WMain99Images.Images[1863];
          if d <> nil then begin
            //HP 图形
            rc := d.ClientRect;
            rc.Right := d.ClientRect.Right div 2 - 1;
            rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP * (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
            dsurface.Draw(40, ay + 91 + rc.Top, rc, d, FALSE);
            //MP 图形
            rc := d.ClientRect;
            rc.Left := d.ClientRect.Right div 2 + 1;
            rc.Right := d.ClientRect.Right - 1;
            rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxMP * (g_MySelf.m_Abil.MaxMP - g_MySelf.m_Abil.MP));
            dsurface.Draw(40 + rc.Left, ay + 91 + rc.Top, rc, d, FALSE);
          end;
        end;
      end;
      if (g_MySelf.m_Abil.MaxExp > 0) then begin
        d := g_WMain99Images.Images[1866];
        if d <> nil then begin
          //经验条
          rc := d.ClientRect;
          if g_MySelf.m_Abil.Exp > 0 then
            r := g_MySelf.m_Abil.MaxExp / g_MySelf.m_Abil.Exp
          else
            r := 0;
          if r > 0 then
            rc.Right := Round(rc.Right / r)
          else
            rc.Right := 0;
          rc.Right := _MIN(rc.Right, d.Width);
          dsurface.Draw(g_FScreenWidth - 134, g_FScreenHeight - 73, rc, d, FALSE);
          //背包重量条
          rc := d.ClientRect;
          if g_nDander > 0 then begin
            rc.Right := _MIN(Round(rc.Right / (10000 / g_nDander)), rc.Right);
            rc.Right := _MIN(rc.Right, d.Width);
            dsurface.Draw(g_FScreenWidth - 134, g_FScreenHeight - 40, rc, d, FALSE);
          end;
        end;
      end;
    end;

    // 左上角，区域标识
    d := nil;
    case g_nAreaStateValue of
      OT_SAFEAREA: d := g_WMain99Images.Images[1868];
      OT_SAFEPK: d := g_WMain99Images.Images[1867];
      OT_FREEPKAREA: d := g_WMain99Images.Images[1867];
    end;
    if d <> nil then
      dsurface.Draw(0, 0, d.ClientRect, d, False);
    //
    with g_DXCanvas do begin
      if DBTAttackMode.Tag in [Low(AttackModeName)..High(AttackModeName)] then
        TextOut(g_FScreenWidth - 152, ay + 113, clWhite, AttackModeName[DBTAttackMode.Tag]);

      TextOut(g_FScreenWidth - 128, ay + 230, clWhite, FormatDateTime('HH:MM:SS', g_ServerDateTime));
      // todo 单位化 HP MP 显示
      sStr := IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP); 
      TextOut(ax + 56 - TextWidth(sStr) div 2, ay + 214, clWhite, sStr);
      sStr := IntToStr(g_MySelf.m_Abil.MP) + '/' + IntToStr(g_MySelf.m_Abil.MaxMP); 
      TextOut(ax + 118 - TextWidth(sStr) div 2, ay + 214, clWhite, sStr);
      sStr := IntToStr(g_MySelf.m_Abil.Level); 
      TextOut(g_FScreenWidth - 121 - TextWidth(sStr) div 2, ay + 146, clWhite, sStr);
      TextOut(8, g_FScreenHeight - 16, clWhite, g_sMapTitle + ' ' + IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY));
    end;
{$IFEND}
  end;
end;

procedure TFrmDlg.DBottomEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay: integer;
{$IF Var_Interface =  Var_Default}
  d: TDXTexture;
{$IFEND}

begin
{$IF Var_Interface =  Var_Default}
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[28];
    if d <> nil then
      DSurface.Draw(ax + 70, ay + 10, d.ClientRect, d, True);

  end;
{$IFEND}
{$IF Var_Interface = Var_Mir2}

  if dwndWhisperName.Visible then begin
    with DEditChat do begin
      ax := SurfaceX(Left + Width);
      ay := SurfaceY(Top);
      with g_DXCanvas do begin
        TextOut(ax - TextWidth('[上下方向键选择，空格或回车键确定选择]'), ay + 2, $808080,
          '[上下方向键选择，空格或回车键确定选择]');
      end;
    end;
  end;
  
{$IFEND}
  DBtCheck1.Visible := g_QuestMsgList.Count > 0;
  DBtCheck2.Visible := g_QuestMsgList.Count > 1;
  DBtCheck3.Visible := g_QuestMsgList.Count > 2;
  DBtCheck4.Visible := g_QuestMsgList.Count > 3;
  DBtCheck5.Visible := g_QuestMsgList.Count > 4;
  DBtCheck6.Visible := g_QuestMsgList.Count > 5;
  DBtCheck7.Visible := g_QuestMsgList.Count > 6;
  DBtCheck8.Visible := g_QuestMsgList.Count > 7;
  DBtCheck9.Visible := g_QuestMsgList.Count > 8;
  DBtCheck10.Visible := g_QuestMsgList.Count > 9;
end;

procedure TFrmDlg.DBottomMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
{$IF Var_Interface = Var_Mir2}
var
  ShowMsg: string;
  nLeft: Integer;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
  pClickName := nil;
  pClickItem := nil;
  nClickNameIndex := 0;
  nClickItemIndex := 0;
  if g_MySelf = nil then Exit;
  Dec(Y, DBottom.Top);
  Dec(X, DBottom.Left);
  ShowMsg := '';
  nLeft := g_FScreenWidth - 160;
  if (x >= nLeft) and (x <= nLeft + 105) and (y >= 172) and (y <= 172 + 26) then begin
    x := nLeft;
    Y := 192;
    ShowMsg := '经验值：' + IntToStr(g_MySelf.m_Abil.Exp) + '/' + IntToStr(g_MySelf.m_Abil.MaxExp);
  end else
  if (x >= nLeft) and (x <= nLeft + 105) and (y >= 205) and (y <= 205 + 26) then begin
    x := nLeft;
    Y := 228;
    ShowMsg := '成长点：' + IntToStr(g_nDander) + '/10000';
  end;
  if ShowMsg <> '' then
    DScreen.ShowHint(DBottom.SurfaceX(DBottom.Left + X), DBottom.SurfaceY(DBottom.Top + Y), ShowMsg, clWhite, False, Integer(Sender));
{$IFEND}
end;

procedure TFrmDlg.DBotWndSayDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  i, ii: integer;
  sx, sy: integer;
  d: TDXTexture;
  nCount: integer;
  pMessage: pTSayMessage;
  SayImage: pTSayImage;
  nx, ny, ax, ay, nLeft: Integer;
  py: smallint;
  sStr: string;
  ClickName: pTClickName;
  ClickItem: pTClickItem;
begin
  with Sender as TDWindow do begin
    //g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR or $50000000);
    //g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR or $50FFFFFF);
    //DrawAlphaOfColor(dsurface, SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR, 60);
    //DrawAlphaEx(dsurface, SurfaceX(Left), SurfaceX(Top), DScreen.m_HintBGSurface, 0, 0, Width, Height, 1, 60);
    sx := SurfaceX(Left);
    sy := SurfaceY(Top);
    nCount := Height div SAYLISTHEIGHT;
    with DScreen do begin
      DSayUpDown.MaxPosition := _MAX(0, m_SayTransferList.count - nCount);
      for i := DSayUpDown.Position to (DSayUpDown.Position + nCount - 1) do begin
        if i > m_SayTransferList.count - 1 then break;
        pMessage := m_SayTransferList[i];
        ClickName := nil;
        ClickItem := nil;
        if (pClickName <> nil) and (nClickNameIndex > 0) and (pMessage.ClickList <> nil) and
          (pMessage.ClickList.Count > 0) then begin
          for ii := 0 to pMessage.ClickList.Count - 1 do begin
            if pTClickName(pMessage.ClickList[ii]).Index = nClickNameIndex then begin
              ClickName := pMessage.ClickList[ii];
              break;
            end;
          end;
        end
        else if (pClickItem <> nil) and (nClickItemIndex > 0) and (pMessage.ItemList <> nil) and
          (pMessage.ItemList.Count > 0) then begin
          for ii := 0 to pMessage.ItemList.Count - 1 do begin
            if pTClickItem(pMessage.ItemList[ii]).Index = nClickItemIndex then begin
              ClickItem := pMessage.ItemList[ii];
              break;
            end;
          end;
        end;
        ax := sx;
        ay := sy + (i - DSayUpDown.Position) * SAYLISTHEIGHT;
        dsurface.Draw(ax, ay, pMessage.SaySurface.ClientRect, pMessage.SaySurface, True);
        if (pMessage.ImageList <> nil) and (pMessage.ImageList.Count > 0) then begin
          for ii := 0 to pMessage.ImageList.Count - 1 do begin
            SayImage := pMessage.ImageList[ii];
            if (SayImage.nIndex <= High(g_FaceIndexInfo)) then begin
              d := g_WFaceImages.GetCachedImage(g_FaceIndexInfo[SayImage.nIndex].ImageIndex, nx, ny);
              if d <> nil then begin
                dsurface.Draw(ax + SayImage.nLeft, ay + (SAYLISTHEIGHT - d.Height) div 2 - 1, d.ClientRect, d, True);
                py := ny;
                if (GetTickCount - g_FaceIndexInfo[SayImage.nIndex].dwShowTime) > LongWord(nx) then begin
                  g_FaceIndexInfo[SayImage.nIndex].ImageIndex := g_FaceIndexInfo[SayImage.nIndex].ImageIndex + py;
                  g_FaceIndexInfo[SayImage.nIndex].dwShowTime := GetTickCount;
                end;
              end;
            end;
          end;
        end;
        if (i = pClickIndex) then begin
          sStr := '';
          nLeft := 0;
          if pClickName <> nil then begin
            sStr := pClickName.sStr;
            nLeft := pClickName.nLeft;
          end
          else if pClickItem <> nil then begin
            sStr := pClickItem.sStr;
            nLeft := pClickItem.nLeft;
          end;
          if sStr <> '' then begin
            with g_DXCanvas do begin
              //SetBkMode(Handle, TRANSPARENT);
              if SayDlgDown then
                TextOut(ax + nLeft + 1, ay + 3, clWhite, sstr)
              else
                TextOut(ax + nLeft, ay + 2, clWhite, sstr);
              //Release;
            end;
          end;
        end
        else begin
          sStr := '';
          nLeft := 0;
          if ClickName <> nil then begin
            sStr := ClickName.sStr;
            nLeft := ClickName.nLeft;
          end
          else if ClickItem <> nil then begin
            sStr := ClickItem.sStr;
            nLeft := ClickItem.nLeft;
          end;
          if sStr <> '' then begin
            with g_DXCanvas do begin
              //SetBkMode(Handle, TRANSPARENT);
              if SayDlgDown then
                TextOut(ax + nLeft + 1, ay + 3, clWhite, sstr)
              else
                TextOut(ax + nLeft, ay + 2, clWhite, sstr);
              //Release;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBotWndSayInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
var
  ii, nX, nY: integer;
  pMessage: pTSayMessage;
  ClickName: pTClickName;
  ClickItem: pTClickItem;
begin
  IsRealArea := True;
  with Sender as TDWindow do begin
    pClickName := nil;
    pClickItem := nil;
    nClickNameIndex := 0;
    nClickItemIndex := 0;
    nX := X;
    nY := Y;
    pClickIndex := DSayUpDown.Position + nY div SAYLISTHEIGHT;
    with DScreen do begin
      if (pClickIndex >= 0) and (pClickIndex < m_SayTransferList.count) then begin
        pMessage := m_SayTransferList[pClickIndex];
        if (pMessage.ClickList <> nil) and (pMessage.ClickList.Count > 0) then begin
          for ii := 0 to pMessage.ClickList.Count - 1 do begin
            ClickName := pMessage.ClickList[ii];
            if (nX >= ClickName.nLeft) and (nX <= ClickName.nRight) then begin
              pClickName := ClickName;
              nClickNameIndex := ClickName.Index;
              IsRealArea := True;
              break;
            end;
          end;
        end;
        if (pClickName = nil) and (pMessage.ItemList <> nil) and (pMessage.ItemList.Count > 0) then begin
          for ii := 0 to pMessage.ItemList.Count - 1 do begin
            ClickItem := pMessage.ItemList[ii];
            if (nX >= ClickItem.nLeft) and (nX <= ClickItem.nRight) then begin
              pClickItem := ClickItem;
              nClickItemIndex := ClickItem.Index;
              IsRealArea := True;
              break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBotWndSayMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SayDlgDown := True;
end;

procedure TFrmDlg.DBotWndSayMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  SayDlgDown := False;
  if mbRight = Button then begin
    if pClickName <> nil then begin
      with Sender as TDControl do begin
        DPopUpSayList.Visible := False;
        DPopUpSayList.Item.Clear;
        DPopUpSayList.Item.AddObject('名称: ' + pClickName.sStr, TObject(-1));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('进行私聊', TObject(1));
        if (not InFriendList(pClickName.sStr)) and
          (pClickName.sStr <> g_MySelf.m_UserName) then
          DPopUpSayList.Item.AddObject('加为好友', TObject(2))
        else
          DPopUpSayList.Item.AddObject('加为好友', nil);

        if (not InBlacklist(pClickName.sStr)) then
          DPopUpSayList.Item.AddObject('屏蔽发言', TObject(7))
        else
          DPopUpSayList.Item.AddObject('解除屏蔽', TObject(8));

        if InFriendList(pClickName.sStr) then
          DPopUpSayList.Item.AddObject('发送信件', TObject(3))
        else
          DPopUpSayList.Item.AddObject('发送信件', nil);

        DPopUpSayList.Item.AddObject('邀请组队', TObject(4));
        DPopUpSayList.Item.AddObject('邀请加入行会', TObject(5));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('复制人物名称', TObject(6));
        DPopUpSayList.RefSize;
        DPopUpSayList.Popup(Sender, SurfaceX(X), SurfaceY(Y), pClickName.sStr);
      end;
    end;
  end
  else begin
    if pClickName <> nil then begin
      PlayScene.SetEditChar(pClickName.sStr);
    end
    else if pClickItem <> nil then begin
      if pClickItem.pc.s.name <> '' then begin
        OpenSayItemShow(pClickItem.pc);
      end
      else if pClickItem.ItemIndex < 0 then begin
        for I := Low(g_ItemArr) to High(g_ItemArr) do begin
          if (g_ItemArr[i].s.Name <> '') and (g_ItemArr[i].UserItem.MakeIndex = (-pClickItem.ItemIndex)) then begin
            OpenSayItemShow(g_ItemArr[i]);
            pClickItem.pc := g_ItemArr[i];
            break;
          end;
        end;
      end
      else begin
        if GetTickCount > DWndSay.AppendTick then begin
          DWndSay.AppendTick := GetTickCount + 500;
          FrmMain.SendGetSayItem(pClickItem.nIndex, pClickItem.ItemIndex); //去服务器取回装备属性
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBTAttackModeClick(Sender: TObject; X, Y: Integer);
begin
  DWndAttackModeList.TopShow;
end;

procedure TFrmDlg.DBTAttackModeDirectPaint(Sender: TObject; dsurface: TDXTexture);
{$IF Var_Interface =  Var_Default}
const
  AttackModeName: array[0..6] of string[8] = ('全体攻击', '和平攻击', '夫妻攻击', '师徒攻击', '编组攻击', '行会攻击', '红名攻击');
  AttackModeNameColor: array[0..6] of Integer = ($FFFFFF, $FFFF00, $B6FF, $A5D3DE, $FF9900, $8CFF94, $2450FF);
var
  d: TDXTexture;
  ax, ay: integer;
{$IFEND}
begin
{$IF Var_Interface =  Var_Default}
  with Sender as TDButton do begin
    if not (Tag in [0..6]) then
      exit;
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if MouseEntry = msIn then
      d := WLib.Images[FaceIndex + 1]
    else
      d := WLib.Images[FaceIndex];

    if d <> nil then begin
      DrawWindow(dsurface, ax, ay, d);

      d := WLib.Images[498 + Tag];
      if d <> nil then
        dsurface.Draw(ax + 5, ay + 5, d.ClientRect, d, True);

      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        TextOut(ax + 30, ay + 5, AttackModeNameColor[Tag], AttackModeName[Tag]);
        //Release;
      end;
    end;
  end;
{$IFEND}
end;

procedure TFrmDlg.DBTAttackModeGuildClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    DBTAttackMode.Tag := Tag;
    frmMain.SendSay('@AttackMode ' + IntToStr(Tag));
  end;
  DWndAttackModeList.Visible := False;
end;

procedure TFrmDlg.DBTCheck1Click(Sender: TObject; X, Y: Integer);
var
  ClientCheckMsg: pTClientCheckMsg;
  str: string;
  nid: integer;
begin
  with Sender as TDButton do begin
    if (Tag >= 0) and (Tag < g_QuestMsgList.Count) then begin
      Downed := False;
      ClientCheckMsg := g_QuestMsgList[Tag];
      if ClientCheckMsg.MsgType = tmc_Naked then begin
        StatePage := 1;
        DStateWin.Visible := True;
        PageChanged;
      end
      else begin
        str := ClientCheckMsg.str;
        nid := ClientCheckMsg.MsgIndex;
        Dispose(ClientCheckMsg);
        g_QuestMsgList.Delete(Tag);
        Visible := False;
        FrmDlg.RefCheckButtonXY;
        if mrYes = DMessageDlg(str, [mbYes, mbNo]) then
          frmMain.SendCheckMsgDlgSelect(nid, 1)
        else
          frmMain.SendCheckMsgDlgSelect(nid, 0);
      end;
    end
    else begin
      Visible := False;
      exit;
    end;
  end;
end;

procedure TFrmDlg.DBTCheck1DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
  ClientCheckMsg: pTClientCheckMsg;
begin
  with Sender as TDButton do begin
    if (Tag >= 0) and (Tag < g_QuestMsgList.Count) then begin
      ClientCheckMsg := g_QuestMsgList[Tag];
      if (ClientCheckMsg.MsgType = tmc_Naked) and ((g_nNakedCount = 0) and (g_nNakedBackCount = 0)) and (ClientCheckMsg = g_ClientCheckMsg) then begin
        Dispose(ClientCheckMsg);
        g_QuestMsgList.Delete(Tag);
        g_ClientCheckMsg := nil;
        Visible := False;
        FrmDlg.RefCheckButtonXY;
        exit;
      end
      else if (ClientCheckMsg.MsgType <> tmc_Naked) and (GetTickCount > ClientCheckMsg.EndTime) then begin
        Dispose(ClientCheckMsg);
        g_QuestMsgList.Delete(Tag);
        Visible := False;
        FrmDlg.RefCheckButtonXY;
        exit;
      end;
      idx := 0;
      case ClientCheckMsg.MsgType of
        tmc_Group: idx := 0;
        tmc_Friend: idx := 3;
        tmc_Guild: idx := 6;
        tmc_Naked: idx := 9;
        tmc_Deal: idx := 12;
        //CHECK_FRIEND : idx := 3;
      end;
    end
    else begin
      Visible := False;
      exit;
    end;
    //idx := 0;
    if WLib <> nil then begin
      {if Downed then begin
        inc(idx, 2)
      end
      else if (MouseEntry = msIn) or }
      if (((GetTickCount - ClientCheckMsg.ShowTime) mod 400) > 200) then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBTEditClick(Sender: TObject; X, Y: Integer);
begin
  if not DEditChat.Visible then begin
    DEditChat.Visible := True;
    DEditChat.SetFocus;
    case g_SayMode of
      usm_Hear: DEditChat.Text := '';
      usm_Whisper: DEditChat.Text := '/';
      usm_Cry: DEditChat.Text := '!';
      usm_Group: DEditChat.Text := '!!';
      usm_Guild: DEditChat.Text := '!~';
      usm_World: DEditChat.Text := g_Cmd_AllMsg + ' ';
    end;
  end
  else
    DEditChat.SetFocus;
end;

procedure TFrmDlg.DBTEditDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if DEditChat.Visible then
      d := WLib.Images[130]
    else
      d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
  end;
end;

procedure TFrmDlg.DBTFaceClick(Sender: TObject; X, Y: Integer);
begin
  DWndFace.TopShow;
end;

procedure TFrmDlg.DBTHintCloseClick(Sender: TObject; X, Y: Integer);
begin
  if HintBack = stClose then begin
    FrmMain.Close;
  end
  else begin
    if HintBack = stSelServer then
      FrmMain.CSocket.Active := False;
    DScreen.ChangeScene(HintBack);
  end;
end;

procedure TFrmDlg.DBTHintCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
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

procedure TFrmDlg.DBTItemShowCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
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
end;

procedure TFrmDlg.dbtnLoginLostPwClick(Sender: TObject; X, Y: Integer);
begin
  if g_WebInfo.g_LostPassUrl <> '' then begin
    SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
    ShellExecute(Handle, 'Open', @g_WebInfo.g_LostPassUrl[1], '', '', SW_SHOW);
  end;
end;

procedure TFrmDlg.DBtnSayAllClick(Sender: TObject; X, Y: Integer);
var
  UserSayType: TUserSayType;
begin
  with Sender as TDButton do begin
    UserSayType := TUserSayType(Integer(AppendData));
    if g_SayShowType <> UserSayType then begin
      PlaySound(s_glass_button_click);
      g_SayShowType := UserSayType;
      g_SayEffectIndex[UserSayType] := False;
      case UserSayType of
        us_All: DScreen.ChangeTransferMsg([us_Hear, us_Whisper, us_Cry, us_Group, us_Guild, us_Sys]);
        us_Hear,
          us_Whisper,
          us_Cry,
          us_Group,
          us_Guild,
          us_Sys: DScreen.ChangeTransferMsg([UserSayType]);
        us_Custom: DScreen.ChangeTransferMsg(g_SayShowCustom);
      end;
    end;
  end;
end;

procedure TFrmDlg.DBtnSayAllDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
  UserSayType: TUserSayType;
begin
  with Sender as TDButton do begin
    UserSayType := TUserSayType(Integer(AppendData));
    if WLib <> nil then begin
      idx := 1;
      if g_SayShowType = UserSayType then begin
        idx := 0;
        g_SayEffectIndex[UserSayType] := False;
      end
      else if g_SayEffectIndex[UserSayType] then begin
        if ((GetTickCount - AppendTick) div 200 mod 2 = 0) then begin
          idx := 0;
        end;
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.dbtnSayModeHearClick(Sender: TObject; X, Y: Integer);
{var
  SayMode: TUserSayMode; }
begin
  //  SayMode := g_SayMode;
  with Sender as TDButton do begin
    g_SayMode := TUserSayMode(Tag);
    DEditChat.Visible := True;
    DEditChat.SetFocus;
    case g_SayMode of
      usm_Hear: DEditChat.Text := '';
      usm_Whisper: DEditChat.Text := '/';
      usm_Cry: DEditChat.Text := '!';
      usm_Group: DEditChat.Text := '!!';
      usm_Guild: DEditChat.Text := '!~';
      usm_World: DEditChat.Text := g_Cmd_AllMsg + ' ';
    end;
  end;
  dwndSayMode.Visible := False;
end;

procedure TFrmDlg.dbtnSayModeHearDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if MouseEntry = msIn then
      d := WLib.Images[FaceIndex + 1]
    else
      d := WLib.Images[FaceIndex];

    if d <> nil then begin
      dsurface.Draw(ax, ay, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBTOptionClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg3.DGameSetup.Visible := not FrmDlg3.DGameSetup.Visible;
  FrmDlg3.DGSConfigClick(FrmDlg3.dbtnGSSay, 0, 0);
end;

procedure TFrmDlg.DBTSayLockClick(Sender: TObject; X, Y: Integer);
begin
  dwndSayMode.TopShow;
end;

procedure TFrmDlg.DBTSayLockDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex + Integer(g_SayMode)];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBTSayMoveMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  ShowMsg: string;
  ay: Integer;
begin
  with Sender as TDControl do begin
    ay := y;
    X := SurfaceX(Left);
    y := SurfaceY(Top);
    ShowMsg := '';
    if Sender = DBTAttackMode then begin
      ShowMsg := '改变攻击模式<（' + GetHookKeyStr(@g_CustomKey[DK_CHANGEATTACKMODE]) + '）/FCOLOR=$FFFF>';
    end
    else if Sender = DBTSayMove then begin
      ShowMsg := '按住上,下拖动,可改变聊天框大小';
      DSayMoveSize(SurfaceY(ay));
    end
    else if Sender = DBTFace then begin
      ShowMsg := '动态表情';
    end
    else if Sender = DBTOption then begin
      ShowMsg := '聊天框过滤设置';
    end
    else if Sender = dchkSayLock then begin
      ShowMsg := '是否自动滚屏';
      {if g_SayUpDownLock then
        ShowMsg := '点击自动滚屏'
      else
        ShowMsg := '点击锁定聊天框';}
    end
    else if Sender = DBTTakeHorse then begin
      if g_MySelf.m_btHorse = 0 then
        ShowMsg := '快速上马\<（' + GetHookKeyStr(@g_CustomKey[DK_ONHORSE]) + '）/FCOLOR=$FFFF>'
      else
        ShowMsg := '快速下马\<（' + GetHookKeyStr(@g_CustomKey[DK_ONHORSE]) + '）/FCOLOR=$FFFF>';
    end;
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, True, Integer(Sender));
  end;
end;

procedure TFrmDlg.DBTTakeHorseClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if GetTickCount < AppendTick then
      exit;
    AppendTick := GetTickCount + 2000;
    if g_MySelf.m_btHorse = 0 then begin
      frmMain.SendSay(g_Cmd_TakeOnHorse);
    end
    else begin
      frmMain.SendSay(g_Cmd_TakeOffHorse);
    end;
  end;

end;

procedure TFrmDlg.DBTTakeHorseDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
  if g_MySelf = nil then
    exit;
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if g_MySelf.m_btHorse = 0 then
        idx := 0
      else
        idx := 3;
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
end;

procedure TFrmDlg.DStateBTItemClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if StatePage <> Tag then begin
      StatePage := Tag;
      PageChanged;
      PlaySound(s_glass_button_click);
    end;
  end;
end;

procedure TFrmDlg.DStateBTItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
{$IF Var_Interface = Var_Default}
  idx: integer;
  FColor: TColor;
{$IFEND}
  nTop: Byte;
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      nTop := 0;
      if StatePage = tag then begin
        d := WLib.Images[FaceIndex];
      end else begin
        d := WLib.Images[FaceIndex + 1];
        nTop := 2;
      end;

      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top) + nTop, d.ClientRect, d, True);
    end;
  end;
{$ELSE}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := FaceIndex;
      FColor := DFMoveColor;
      nTop := 0;
      if StatePage <> tag then begin
        FColor := DFColor;
        //Top := 2;
        if MouseEntry = msIn then
          Inc(idx, 2)
        else
          Inc(idx, 1);
      end;
      d := WLib.Images[idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top - 1), d.ClientRect, d, True, False, True);
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2,
          SurfaceY(Top) + (Height - TextHeight(Caption)) div 2 + nTop - 1, FColor, Caption);
        //Release;
      end;
    end;
  end;  
{$IFEND}

end;

procedure TFrmDlg.DStateGridGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
//{$IF Var_Interface = Var_Default}
var
  idx, nMagID: Integer;
  MagicList: TStringList;
//{$IFEND}
begin
//{$IF Var_Interface = Var_Default}
  case DMagicIndex of
    0: MagicList := MagicList1;
    1: MagicList := MagicList2;
  else
    exit;
  end;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + MagicPage * 5;
    if (Idx >= 0) and (idx < MagicList.Count) then begin
      nMagID := Integer(MagicList.Objects[idx]);
      if (nMagID > 0) and (nMagID < SKILL_MAX) then begin
        if not g_MyMagicArry[nMagID].boStudy then begin
          g_MyMagicArry[nMagID].Level := 0;
          g_MyMagicArry[nMagID].CurTrain := 0;
          g_MyMagicArry[nMagID].dwInterval := 0;
          g_MyMagicArry[nMagID].boUse := False;
          g_MyMagicArry[nMagID].Def := GetMagicInfo(nMagID);
        end;
        DScreen.ShowHint(SurfaceX(Left + x), SurfaceY(Top + (y - Top) + 30),
          ShowMagicInfo(@g_MyMagicArry[nMagID]), clwhite, False, idx, True);
      end;
    end;
  end;
//{$IFEND}
end;

procedure TFrmDlg.DStateGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  idx, nMagID: Integer;
{$IF Var_Interface = Var_Default}
  nLook: Integer;
{$IFEND}
  Magic: TClientDefMagic;
  d: TDXTexture;
  MagicList: TStringList;
{$IF Var_Interface = Var_Mir2}
  sStr: string;
  nMaxTrain: Integer;
  rc: TRect;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
  case DMagicIndex of
    0: MagicList := MagicList1;
    1: MagicList := MagicList2;
  else
    exit;
  end;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + MagicPage * 5;
    if (Idx >= 0) and (idx < MagicList.Count) then begin
      nMagID := Integer(MagicList.Objects[idx]);
      Magic := GetMagicInfo(nMagID);
      if Magic.Magic.sMagicName <> '' then begin
        if Magic.Magic.wMagicIcon > 30000 then
          d := g_WMagIconImages.Images[Magic.Magic.wMagicIcon - 30000]
        else if Magic.Magic.wMagicIcon > 20000 then
          d := g_WDefMagIcon2Images.Images[Magic.Magic.wMagicIcon - 20000]
        else if Magic.Magic.wMagicIcon > 10000 then
          d := g_WDefMagIconImages.Images[Magic.Magic.wMagicIcon - 10000]
        else
          d := GetDefMagicIcon(@Magic);
        if g_MyMagicArry[nMagID].Level in [Low(Magic.Magic.MaxTrain)..High(Magic.Magic.MaxTrain)] then
          nMaxTrain := Magic.Magic.MaxTrain[g_MyMagicArry[nMagID].Level]
        else
          nMaxTrain := Magic.Magic.MaxTrain[High(Magic.Magic.MaxTrain)];
        
        if d <> nil then begin
          dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2), SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, False);

        end;
        d := g_WMain99Images.Images[1807];
        if d <> nil then
          dsurface.Draw(SurfaceX(Rect.Left + 44), SurfaceY(Rect.Top + 20), d.ClientRect, d, False);

        d := g_WMain99Images.Images[1808];
        if d <> nil then begin
          rc := d.ClientRect;
          // 九重技能才有熟练度的进度条
          if (Magic.Magic.btTrainLv <= 9) and (g_MyMagicArry[nMagID].Level < Magic.Magic.btTrainLv) then
            rc.Right := _MIN(Round(rc.Right / (nMaxTrain / g_MyMagicArry[nMagID].CurTrain)), rc.Right);
          dsurface.Draw(SurfaceX(Rect.Left + 46), SurfaceY(Rect.Top + 22), rc, d, FALSE);
        end;

        if g_MyMagicArry[nMagID].btKey > 0 then begin
          d := g_WMain99Images.Images[2095 + g_MyMagicArry[nMagID].btKey];
          if d <> nil then
            dsurface.Draw(SurfaceX(Rect.Left + 183), SurfaceY(Rect.Top + 3), d.ClientRect, d, True);
        end;

        with g_DXCanvas do begin
          TextOut(SurfaceX(Rect.Left + 43), SurfaceY(Rect.Top + 3), $8CC6EF, Magic.Magic.sMagicName);

          if not (Magic.Magic.btTrainLv = 9) then
          begin
            if (Magic.Magic.btTrainLv <= 3) then
            begin
              if (g_MyMagicArry[nMagID].Level < Magic.Magic.btTrainLv) then
              begin
                sStr := IntToStr(g_MyMagicArry[nMagID].CurTrain) + '/' + IntToStr(nMaxTrain);
                TextOut(SurfaceX(Rect.Left + 96 - (TextWidth(sStr) div 2)), SurfaceY(Rect.Top + 19), clWhite, sStr);
                TextOut(SurfaceX(Rect.Left + 155), SurfaceY(Rect.Top + 19), clWhite, 'Lv.' + IntToStr(g_MyMagicArry[nMagID].Level));
              end
              else begin
                //sStr := '-';
                //TextOut(SurfaceX(Rect.Left + 96 - (TextWidth(sStr) div 2)), SurfaceY(Rect.Top + 19), clWhite, sStr);
                TextOut(SurfaceX(Rect.Left + 155), SurfaceY(Rect.Top + 19), clWhite, 'Lv.Max');
              end;
            end
            else begin
              if (g_MyMagicArry[nMagID].Level < Magic.Magic.btTrainLv) then
              begin
//                sStr := IntToStr(g_MyMagicArry[nMagID].CurTrain) + '/' + IntToStr(nMaxTrain);
//                TextOut(SurfaceX(Rect.Left + 96 - (TextWidth(sStr) div 2)), SurfaceY(Rect.Top + 19), clWhite, sStr);
                TextOut(SurfaceX(Rect.Left + 155), SurfaceY(Rect.Top + 19), clWhite, 'Lv.' + IntToStr(g_MyMagicArry[nMagID].Level));
              end
              else begin
                //sStr := '-';
                //TextOut(SurfaceX(Rect.Left + 96 - (TextWidth(sStr) div 2)), SurfaceY(Rect.Top + 19), clWhite, sStr);
                TextOut(SurfaceX(Rect.Left + 155), SurfaceY(Rect.Top + 19), clWhite, 'Lv.Max');
              end;
            end;
          end
          else begin
            if (g_MyMagicArry[nMagID].Level < High(Magic.Magic.MaxTrain)) then
            begin
              sStr := IntToStr(g_MyMagicArry[nMagID].CurTrain) + '/' + IntToStr(nMaxTrain);
              TextOut(SurfaceX(Rect.Left + 96 - (TextWidth(sStr) div 2)), SurfaceY(Rect.Top + 19), clWhite, sStr);
              TextOut(SurfaceX(Rect.Left + 155), SurfaceY(Rect.Top + 19), clWhite, '第' + IntToStr(g_MyMagicArry[nMagID].Level) + '重');
            end
            else begin
              TextOut(SurfaceX(Rect.Left + 155), SurfaceY(Rect.Top + 19), clWhite, '满重');
            end;
          end;
        end;
      end;
    end;
  end;
{$ELSE}
  if DMagicIndex = 2 then begin
    with Sender as TDGrid do begin
      idx := ACol + ARow * ColCount;
      nLook := 132 + idx * 2 + 1;

      if (g_MakeMagic[idx] > 0) then
        Dec(nLook);

      d := g_WMagIconImages.Images[nLook];
      if d <> nil then begin
        dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
          SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, False);
      end;
      with g_DXCanvas do begin
        if (g_MakeMagic[idx] > 0) then begin
          TextOut(SurfaceX(Rect.Left + 46), SurfaceY(Rect.Top + 4), $6BF7FF, MakeMagicName[idx]);
          TextOut(SurfaceX(Rect.Left + 46), SurfaceY(Rect.Top + 23), $6BF7FF, '等级: ' + IntToStr(g_MakeMagic[idx]) + '/' +
            IntToStr(g_btMakeMagicMaxLevel));
        end
        else begin
          TextOut(SurfaceX(Rect.Left + 46), SurfaceY(Rect.Top + 4), $CCCCCC, MakeMagicName[idx]);
          TextOut(SurfaceX(Rect.Left + 46), SurfaceY(Rect.Top + 23), $CCCCCC, '未激活');
        end;
      end;
    end;
  end
  else begin
    case DMagicIndex of
      0: MagicList := MagicList1;
      1: MagicList := MagicList2;
    else
      exit;
    end;
    with Sender as TDGrid do begin
      idx := ACol + ARow * ColCount + MagicPage * 10;
      if (Idx >= 0) and (idx < MagicList.Count) then begin
        nMagID := Integer(MagicList.Objects[idx]);
        Magic := GetMagicInfo(nMagID);
        if Magic.Magic.sMagicName <> '' then begin
          d := g_WMagIconImages.Images[Magic.Magic.wMagicIcon];
          if d <> nil then begin
            if g_MyMagicArry[nMagID].boStudy then begin
              dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
                SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, False);
            end
            else begin
              DrawEffect(dsurface,
                SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
                SurfaceY(Rect.Top + (RowHeight - d.Height) div 2),
                d, ceGrayScale, False);
              {DrawBlend(dsurface,
                SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
                SurfaceY(Rect.Top + (RowHeight - d.Height) div 2),
                d, 0);  }
            end;
          end;

          with g_DXCanvas do begin
            //SetBkMode(Handle, TRANSPARENT);

            {if nMagID = SKILL_cbo then begin
              TextOut(SurfaceX(Rect.Left + 46), SurfaceY(Rect.Top + 23), $CCCCCC, '单击设置');
            end else begin }
            if g_MyMagicArry[nMagID].boStudy then begin
              TextOut(SurfaceX(Rect.Left + 46), SurfaceY(Rect.Top + 4), $6BF7FF, Magic.Magic.sMagicName);
              TextOut(SurfaceX(Rect.Left + 46), SurfaceY(Rect.Top + 23), $6BF7FF, '等级： ' + IntToStr(g_MyMagicArry[nMagID].Level));
            end
            else begin
              TextOut(SurfaceX(Rect.Left + 46), SurfaceY(Rect.Top + 4), $CCCCCC, Magic.Magic.sMagicName);
              TextOut(SurfaceX(Rect.Left + 46), SurfaceY(Rect.Top + 23), $CCCCCC, '未修练');
            end;
            // end;
             //Release;
          end;
        end;
      end;
    end;
  end;  
{$IFEND}

end;

procedure TFrmDlg.DStateGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
{$IF Var_Interface = Var_Mir2}
  procedure ClearUserKeyType(nIdx: Integer);
  var
    i: integer;
  begin
    for i := Low(CboMagicList.MagicList) to High(CboMagicList.MagicList) do begin
      if CboMagicList.MagicList[i] = nIdx then begin
        CboMagicList.MagicList[i] := 0;
      end;
    end;
  end;
{$IFEND}

var
  idx, nMagID: Integer;
  MagicList: TStringList;
begin
{$IF Var_Interface = Var_Mir2}
  case DMagicIndex of
    0: MagicList := MagicList1;
    1: MagicList := MagicList2;
  else exit;
  end;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + MagicPage * 5;
    if (Idx >= 0) and (idx < MagicList.Count) then begin
      nMagID := Integer(MagicList.Objects[idx]);
      if (g_MyMagicArry[nMagID].boStudy) and (not (nMagID in [3, 4, 7, 64])) then
      begin
        if DStateWinMagicCbo.Visible and (FMagicCboKeyIndex in [Low(CboMagicList.MagicList)..High(CboMagicList.MagicList)]) then
        begin
          ClearUserKeyType(nMagID);
          CboMagicList.MagicList[FMagicCboKeyIndex] := nMagID;
        end
        else
        begin
          FrmDlg4.FMagicKeyIndex := g_MyMagicArry[nMagID].btKey;
          FrmDlg4.FMagidID := nMagID;
          FrmDlg4.DWndMagicKey.ShowModal;
        end;
      end;
    end;
  end;
{$ELSE}
  if DMagicIndex = 2 then begin
    with Sender as TDGrid do begin
      idx := ACol + ARow * ColCount;
      if (g_MakeMagic[idx] > 0) then begin
        FrmDlg3.ShowMakeWindow(idx);
      end;
    end;
  end
  else begin
    case DMagicIndex of
      0: MagicList := MagicList1;
      1: MagicList := MagicList2;
    else
      exit;
    end;
    with Sender as TDGrid do begin
      idx := ACol + ARow * ColCount + MagicPage * 10;
      if g_boItemMoving then begin
        if g_MovingItem.ItemType = mtStateMagic then begin
          g_boItemMoving := False;
        end;
      end
      else begin
        if (Idx >= 0) and (idx < MagicList.Count) then begin
          nMagID := Integer(MagicList.Objects[idx]);
          if (g_MyMagicArry[nMagID].boStudy) and (not (nMagID in [3, 4, 7, 64])) then begin
            if g_MyMagicArry[nMagID].boStudy then begin
              g_boItemMoving := True;
              g_MovingItem.Index2 := MakeLong(nMagID, g_MyMagicArry[nMagID].Def.Magic.wMagicIcon);
              g_MovingItem.ItemType := mtStateMagic;
            end;
          end;
        end;
      end;
    end;
  end;  
{$IFEND}

end;

procedure TFrmDlg.DStateInfoExitClick(Sender: TObject; X, Y: Integer);
begin
  RefRealityInfo();
end;

procedure TFrmDlg.DStateInfoNameChange(Sender: TObject);
var
  i: integer;
  StrList: TStringList;
begin
{$IF Var_Interface = Var_Mir2}
  DStateInfoSave.Visible := True;
  DStateInfoExit.Visible := True;
{$IFEND}
  DStateInfoSave.Enabled := True;
  DStateInfoExit.Enabled := True;
  if Sender = DStateInfoProvince then begin
    TempAddressList := nil;
    DStateInfoCity.Item.Clear;
    DStateInfoArea.Item.Clear;
    if (DStateInfoProvince.ItemIndex >= 0) and (DStateInfoProvince.ItemIndex < AddressList.Count) then begin
      TempRealityInfo.btProvince := DStateInfoProvince.ItemIndex;
      if AddressList.Objects[DStateInfoProvince.ItemIndex] <> nil then begin
        TempAddressList := TStringList(AddressList.Objects[DStateInfoProvince.ItemIndex]);
        for I := 0 to TempAddressList.Count - 1 do
          DStateInfoCity.Item.AddObject(TempAddressList[i], TempAddressList.Objects[i]);
        DStateInfoCity.ItemIndex := 1;
        DStateInfoNameChange(DStateInfoCity);
      end;
    end;
  end
  else if Sender = DStateInfoCity then begin
    DStateInfoArea.Item.Clear;
    if TempAddressList = nil then
      exit;
    if (DStateInfoCity.ItemIndex >= 0) and (DStateInfoCity.ItemIndex < TempAddressList.Count) then begin
      TempRealityInfo.btCity := DStateInfoCity.ItemIndex;
      if TempAddressList.Objects[DStateInfoCity.ItemIndex] <> nil then begin
        StrList := TStringList(TempAddressList.Objects[DStateInfoCity.ItemIndex]);
        for I := 0 to StrList.Count - 1 do
          DStateInfoArea.Item.Add(StrList[i]);
        DStateInfoArea.ItemIndex := 1;
        DStateInfoNameChange(DStateInfoArea);
      end;
    end;
  end
  else if Sender = DStateInfoArea then begin
    if (DStateInfoArea.ItemIndex >= 0) then begin
      TempRealityInfo.btArea := DStateInfoArea.ItemIndex;
    end;
  end
  else if Sender = DStateInfoSex then begin
    if (DStateInfoSex.ItemIndex >= 0) then begin
      TempRealityInfo.btSex := DStateInfoSex.ItemIndex;
    end;
  end
  else if Sender = DStateInfoMemo then begin
    TempRealityInfo.sIdiograph := DStateInfoMemo.GetText;
  end
  else if Sender = DStateInfoName then begin
    TempRealityInfo.sUserName := DStateInfoName.Text;
  end
  else if Sender = DStateInfoAM then begin
    SetByteStatus(TempRealityInfo.btOnlineTime, 0, DStateInfoAM.Checked);
  end
  else if Sender = DStateInfoPM then begin
    SetByteStatus(TempRealityInfo.btOnlineTime, 1, DStateInfoPM.Checked);
  end
  else if Sender = DStateInfoNight then begin
    SetByteStatus(TempRealityInfo.btOnlineTime, 2, DStateInfoNight.Checked);
  end
  else if Sender = DStateInfoMidNight then begin
    SetByteStatus(TempRealityInfo.btOnlineTime, 3, DStateInfoMidNight.Checked);
  end
  else if Sender = DStateInfoFriend then begin
    TempRealityInfo.boFriendSee := DStateInfoFriend.Checked;
  end
  else if Sender = DStateInfoAge then begin
    TempRealityInfo.btOld := StrToIntDef(DStateInfoAge.Text, 0);
  end;
end;

procedure TFrmDlg.DStateInfoRefPicClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if (GetTickCount - AppendTick) < 2000 then
      exit;
    AppendTick := GetTickCount;
    if Sender = DStateInfoUpLoadPic then begin
      FrmMain.SendClientSocket(CM_SAVEUSERPHOTO, 0, 0, 0, 0, '');
      DStateInfoUpLoadPic.Enabled := False;
    end
    else if Sender = DStateInfoRefPic then begin
      FrmMain.SendClientSocket(CM_SAVEUSERPHOTO, 0, 0, 0, 2, '');
    end
    else if Sender = DUserStateInfoRefPic then begin
      FrmMain.SendClientSocket(CM_SAVEUSERPHOTO, 0, 0, 0, 3, '');
    end;
  end;
end;

procedure TFrmDlg.DStateInfoRefPicDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if not Enabled then begin
        inc(idx, 2)
      end
      else if Downed then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DStateInfoSaveClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.SendClientMessage(CM_REALITYINFO,
    Integer(TempRealityInfo.boFriendSee),
    MakeWord(TempRealityInfo.btOld, TempRealityInfo.btSex),
    MakeWord(TempRealityInfo.btProvince, TempRealityInfo.btCity),
    MakeWord(TempRealityInfo.btArea, TempRealityInfo.btOnlineTime),
    TempRealityInfo.sUserName + '/' + TempRealityInfo.sIdiograph);
  g_UserRealityInfo := TempRealityInfo;
  RefRealityInfo();
end;

procedure TFrmDlg.DStateAbilAdd1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left);
    y := SurfaceY(Top);
    ShowMsg := '按住 <Ctrl/FCOLOR=$FFFF> 可使用快速加点功能\';
    if (Sender = DStateAbilAdd1) or (Sender = DStateAbilDel1) then begin
      ShowMsg := ShowMsg + '每 <' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedAcCount) +
        '/FCOLOR=$FFFF> 点体质可增加1点物防';
    end
    else if (Sender = DStateAbilAdd2) or (Sender = DStateAbilDel2) then begin
      ShowMsg := ShowMsg + '每 <' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedMAcCount) +
        '/FCOLOR=$FFFF> 点身法可增加1点魔防';
    end
    else if (Sender = DStateAbilAdd3) or (Sender = DStateAbilDel3) then begin
      ShowMsg := ShowMsg + '每 <' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedDcCount) +
        '/FCOLOR=$FFFF> 点力量可增加1点攻击';
    end
    else if (Sender = DStateAbilAdd4) or (Sender = DStateAbilDel4) then begin
      ShowMsg := ShowMsg + '每 <' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedMcCount) +
        '/FCOLOR=$FFFF> 点智力可增加1点魔法';
    end
    else if (Sender = DStateAbilAdd5) or (Sender = DStateAbilDel5) then begin
      ShowMsg := ShowMsg + '每 <' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedScCount) +
        '/FCOLOR=$FFFF> 点精神可增加1点道术';
    end
    else if (Sender = DStateAbilAdd6) or (Sender = DStateAbilDel6) then begin
      ShowMsg := ShowMsg + '每 <' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedHPCount) +
        '/FCOLOR=$FFFF> 点体力可增加1点生命值上限';
    end;
    DScreen.ShowHint(x, y, ShowMsg, clWhite, True, Integer(Sender));
  end;
end;

procedure TFrmDlg.DStateAbilAdd1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  boAdd: Boolean;
  nIndex: Integer;
  pNaked, pBackNaked: PWord;
  nCount: Integer;
begin
  with Sender as TDButton do begin
    if g_nNakedBackCount > 0 then begin
      nCount := 1;
      if ssCtrl in Shift then
        nCount := 10;

      if Tag > 9 then begin
        boAdd := True;
        nIndex := Tag - 10;
      end
      else begin
        boAdd := False;
        nIndex := Tag;
      end;
      if (nIndex < 0) or (nIndex > 6) then
        exit;
      pNaked := PWord(@NakedAbil);
      pBackNaked := PWord(@g_ClientNakedInfo.NakedAbil);
      Inc(pNaked, nIndex);
      Inc(pBackNaked, nIndex);
      if boAdd then begin
        if NakedBackCount <= 0 then
          exit;
        if nCount > NakedBackCount then
          nCount := NakedBackCount;
        if nCount > (pBackNaked^ - pNaked^) then
          nCount := (pBackNaked^ - pNaked^);
        if nCount > 0 then begin
          Inc(pNaked^, nCount);
          Dec(NakedBackCount, nCount);
        end;
      end
      else if pNaked^ > 0 then begin
        if nCount > pNaked^ then
          nCount := pNaked^;
        Dec(pNaked^, nCount);
        Inc(NakedBackCount, nCount);
      end;
{$IF Var_Interface = Var_Mir2}
      DStateAbilOk.Visible := (NakedBackCount <> g_nNakedBackCount);
      DStateAbilExit.Visible := (NakedBackCount <> g_nNakedBackCount);
{$IFEND}
      DStateAbilOk.Enabled := (NakedBackCount <> g_nNakedBackCount);
      DStateAbilExit.Enabled := (NakedBackCount <> g_nNakedBackCount);
      DStateAbilAdd1.Enabled := NakedAbil.nAc > 0;
      DStateAbilAdd2.Enabled := NakedAbil.nMAc > 0;
      DStateAbilAdd3.Enabled := NakedAbil.nDc > 0;
      DStateAbilAdd4.Enabled := NakedAbil.nMc > 0;
      DStateAbilAdd5.Enabled := NakedAbil.nSc > 0;
      DStateAbilAdd6.Enabled := NakedAbil.nHP > 0;
      DStateAbilDel1.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nAc > NakedAbil.nAc);
      DStateAbilDel2.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nMAc > NakedAbil.nMAc);
      DStateAbilDel3.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nDc > NakedAbil.nDc);
      DStateAbilDel4.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nMc > NakedAbil.nMc);
      DStateAbilDel5.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nSc > NakedAbil.nSc);
      DStateAbilDel6.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nHP > NakedAbil.nHP);
    end
    else begin
      nCount := 1;
      if ssCtrl in Shift then
        nCount := 10;

      if Tag > 9 then begin
        boAdd := False;
        nIndex := Tag - 10;
      end
      else begin
        boAdd := True;
        nIndex := Tag;
      end;
      if (nIndex < 0) or (nIndex > 6) then
        exit;
      pNaked := PWord(@NakedAbil);
      Inc(pNaked, nIndex);
      if boAdd then begin
        if NakedCount <= 0 then
          exit;
        if nCount > NakedCount then
          nCount := NakedCount;
        Inc(pNaked^, nCount);
        Dec(NakedCount, nCount);
      end
      else if pNaked^ > 0 then begin
        if nCount > pNaked^ then
          nCount := pNaked^;
        Dec(pNaked^, nCount);
        Inc(NakedCount, nCount);
      end;
{$IF Var_Interface = Var_Mir2}
      DStateAbilOk.Visible := (NakedCount <> g_nNakedCount);
      DStateAbilExit.Visible := (NakedCount <> g_nNakedCount);
{$IFEND}
      DStateAbilOk.Enabled := (NakedCount <> g_nNakedCount);
      DStateAbilExit.Enabled := (NakedCount <> g_nNakedCount);
      DStateAbilAdd1.Enabled := NakedCount > 0;
      DStateAbilAdd2.Enabled := NakedCount > 0;
      DStateAbilAdd3.Enabled := NakedCount > 0;
      DStateAbilAdd4.Enabled := NakedCount > 0;
      DStateAbilAdd5.Enabled := NakedCount > 0;
      DStateAbilAdd6.Enabled := NakedCount > 0;
      DStateAbilDel1.Enabled := NakedAbil.nAc > 0;
      DStateAbilDel2.Enabled := NakedAbil.nMAc > 0;
      DStateAbilDel3.Enabled := NakedAbil.nDc > 0;
      DStateAbilDel4.Enabled := NakedAbil.nMc > 0;
      DStateAbilDel5.Enabled := NakedAbil.nSc > 0;
      DStateAbilDel6.Enabled := NakedAbil.nHP > 0;
    end;
  end;
end;

procedure TFrmDlg.DStateAbilAdd3DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if not Enabled then begin
        inc(idx, 3);
      end
      else if Downed then begin
        inc(idx, 2);
      end
      else if MouseEntry = msIn then begin
        Inc(idx, 1);
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DStateAbilExitClick(Sender: TObject; X, Y: Integer);
begin // NakedAbil
  if Sender = DStateAbilExit then
    RefNakedWindow();
  if Sender = DStateAbilOK then begin
    FrmMain.SendClientSocket(CM_NAKEDABILITYCHANGE, 0, 0, 0, 0, EncodeBuffer(@NakedAbil, SizeOf(NakedAbil)));
{$IF Var_Interface = Var_Mir2}
    DStateAbilOk.Visible := False;
    DStateAbilExit.Visible := False;
{$IFEND}
    DStateAbilOk.Enabled := False;
    DStateAbilExit.Enabled := False;
    DStateAbilAdd1.Enabled := False;
    DStateAbilAdd2.Enabled := False;
    DStateAbilAdd3.Enabled := False;
    DStateAbilAdd4.Enabled := False;
    DStateAbilAdd5.Enabled := False;
    DStateAbilAdd6.Enabled := False;
    DStateAbilDel1.Enabled := False;
    DStateAbilDel2.Enabled := False;
    DStateAbilDel3.Enabled := False;
    DStateAbilDel4.Enabled := False;
    DStateAbilDel5.Enabled := False;
    DStateAbilDel6.Enabled := False;
  end;
end;

procedure TFrmDlg.DMenuDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
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
      //SetBkMode(Handle, TRANSPARENT);
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
      //Release;
    end;
{$IFEND}
  end;
end;

procedure TFrmDlg.DMenuDlgVisible(Sender: TObject; boVisible: Boolean);
begin
  NpcGoodsIdx := 0;
  g_CursorMode := cr_None;
  FrmMain.Cursor := crMyNone;
  LastestClickTime := GetTickCount;
  if boVisible then begin
    g_SellDlgItemSellWait.Item.s.name := '';
    DItemBag.Visible := True;
    DMerchantDlg.Visible := False;
  end
  else begin
    DStateWin.Visible := boOpenStatus;
    DItemBag.Visible := boOpenItemBag;
    //DMerchantDlg.Visible := MDlgVisible;
    DWndBuy.Visible := False;
    ClearGoodsList;
  end;
end;

procedure TFrmDlg.DMenuGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  cu: pTNewClientItem;
  nPic: Integer;
begin
  with Sender as TDGrid do begin
    if NpcGoodsIdx = 0 then begin
      idx := ACol + ARow * ColCount + DMenuUpDonw.Position * {$IF Var_Interface = Var_Default}5{$ELSE}4{$IFEND};
      if (Length(NpcGoodItems) > 0) and (idx in [Low(NpcGoodItems)..High(NpcGoodItems)]) then begin
        if NpcGoodItems[idx].ClientItem.s.Name <> '' then begin
          DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
            ShowItemInfo(NpcGoodItems[idx].ClientItem, [mis_buy], [NpcGoodItems[idx].nItemPic, Integer(NpcBindGold)]),
            clwhite, False, idx, True);
        end;
      end;
    end
    else begin
      idx := ACol + ARow * ColCount;
      if (idx >= 0) and (idx < NpcReturnItemList.Count) then begin
        cu := NpcReturnItemList[idx];
        nPic := GetUserItemPrice(@cu.UserItem, @cu.s) div 2 * 3;
        DScreen.ShowHint(SurfaceX(Left + (x - left)), SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(cu^, [mis_buy], [nPic, 0]), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DMenuGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
  cu: pTNewClientItem;
begin
  with Sender as TDGrid do begin
    if NpcGoodsIdx = 0 then begin  //商店物品
      idx := ACol + ARow * ColCount + DMenuUpDonw.Position * {$IF Var_Interface = Var_Default}5{$ELSE}4{$IFEND};
      if (Length(NpcGoodItems) > 0) and (idx in [Low(NpcGoodItems)..High(NpcGoodItems)]) then begin
        if NpcGoodItems[idx].ClientItem.S.name <> '' then begin
          d := GetBagItemImg(NpcGoodItems[idx].ClientItem.S.looks);
          if d <> nil then begin
            RefItemPaint(dsurface, d,
              SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2),
              SurfaceX(Rect.Right),
              SurfaceY(Rect.Bottom) - 12,
              @NpcGoodItems[idx].ClientItem, False);
          end;
        end;
      end;
    end
    else begin  //回购物品
      idx := ACol + ARow * ColCount;
      if (idx >= 0) and (idx < NpcReturnItemList.Count) then begin
        cu := NpcReturnItemList[idx];
        if cu.S.name <> '' then begin
          d := GetBagItemImg(cu.S.looks);
          if d <> nil then begin
            RefItemPaint(dsurface, d,
              SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
              SurfaceX(Rect.Right),
              SurfaceY(Rect.Bottom) - 12,
              cu, False);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMenuGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  nCount: Integer;
begin
  if g_SellDlgItemSellWait.Item.s.name <> '' then
    exit;
  with Sender as TDGrid do begin
    if g_boItemMoving then begin
      if (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
        if CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoSell) then begin
          AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
          ClearMovingItem();
          DMessageDlg('该物品不允许出售.', [mbYes]);
          exit;
        end;
        ItemClickSound(g_MovingItem.Item.S);
        g_SellDlgItemSellWait := g_MovingItem;
        frmMain.SendSellItem(g_nCurMerchant, g_SellDlgItemSellWait.Item.UserItem.MakeIndex);
        ClearMovingItem();
      end;
    end
    else begin
      if NpcGoodsIdx = 0 then begin
        idx := ACol + ARow * ColCount + DMenuUpDonw.Position * {$IF Var_Interface = Var_Default}5{$ELSE}4{$IFEND};
        if (Length(NpcGoodItems) > 0) and (idx in [Low(NpcGoodItems)..High(NpcGoodItems)]) then begin
          if NpcGoodItems[idx].ClientItem.s.name <> '' then begin
            if g_CursorMode = cr_Buy then begin
              if (sm_Superposition in NpcGoodItems[idx].ClientItem.s.StdModeEx) and (NpcGoodItems[idx].ClientItem.s.DuraMax > 1) then begin
                nCount := NpcGoodItems[idx].ClientItem.s.DuraMax;
              end
              else
                nCount := 1;
              nCount := GetBuyCount(nCount, NpcGoodItems[idx], NpcBindGold);
              idx := GetBuyGoodsIndex(NpcGoodItems[idx]);
              if (nCount > 0) and (idx >= 0) and (idx < 60000) then begin
                frmMain.SendBuyItem(g_nCurMerchant, idx, nCount, NpcBindGold);
                g_SellDlgItemSellWait.Item.S.name := NpcGoodItems[idx].ClientItem.s.name;
              end
              else begin
                if NpcBindGold then
                  DMessageDlg('你的绑定金币不够或者背包空间不足.', [mbYes])
                else
                  DMessageDlg('你的金币不够或者背包空间不足.', [mbYes]);
              end;
            end
            else begin
              BuyGoods := NpcGoodItems[idx];
              DBuyEdit.Text := '1';
              DBuyEditChange(DBuyEdit);
              DWndBuy.Visible := True;
              DBuyEdit.SetFocus;
            end;
          end;
        end;
      end
      else begin
        idx := ACol + ARow * ColCount;
        if (idx >= 0) and (idx < NpcReturnItemList.Count) then begin
          g_SellDlgItemSellWait.Item := pTNewClientItem(NpcReturnItemList[idx])^;
          g_SellDlgItemSellWait.Index2 := idx;
          FrmMain.SendClientMessage(CM_USERBUYRETURNITEM, g_nCurMerchant,
            LoWord(g_SellDlgItemSellWait.Item.UserItem.MakeIndex),
            HiWord(g_SellDlgItemSellWait.Item.UserItem.MakeIndex), idx);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.RefMenuSellBtns();
{
const
  CDMenuBtnPos: array [0 .. 5] of TSmallPoint = (//
    (X: 15; Y: 224),
    (X: 15; Y: 252),
    (X: 79; Y: 224),
    (X: 79; Y: 252),
    (X: 142; Y: 224),
    (X: 142; Y: 252)
  );
}
begin
  DMenuBuy.Visible := (g_nCurMerFlag or 1 = g_nCurMerFlag);
  DMenuSell.Visible := (g_nCurMerFlag or 2 = g_nCurMerFlag);
  DMenuRepair.Visible := (g_nCurMerFlag or 4 = g_nCurMerFlag);
  DMenuSuperRepair.Visible := (g_nCurMerFlag or 8 = g_nCurMerFlag);
  DMenuRepairAll.Visible := (g_nCurMerFlag or 4 = g_nCurMerFlag);
  DMenuSuperRepairAll.Visible := (g_nCurMerFlag or 8 = g_nCurMerFlag);
end;


procedure TFrmDlg.DMenuSellClick(Sender: TObject; X, Y: Integer);
var
  nMoney: Integer;
  i: integer;
  ShowStr: string;
  Item: TNewClientItem;
begin
  if Sender = DMenuBuy then begin
    if (g_nCurMerFlag or 1 <> g_nCurMerFlag) then
      exit; 
    g_CursorMode := cr_Buy;
    FrmMain.Cursor := crMyBuy;
    DMenuShopClick(DMenuShop, 0, 0);
  end
  else if Sender = DMenuSell then begin
    if (g_nCurMerFlag or 2 <> g_nCurMerFlag) then
      exit; 
    g_CursorMode := cr_Sell;
    FrmMain.Cursor := crMySell;
    DMenuShopClick(DMenuReturn, 0, 0);
  end
  else if Sender = DMenuRepair then begin
    if (g_nCurMerFlag or 4 <> g_nCurMerFlag) then
      exit; 
    if not DStateWin.Visible then begin
      StatePage := 0;
      PageChanged;
      DStateWin.Visible := True;
    end;
    boSuperRepair := False;
    g_CursorMode := cr_Repair;
    FrmMain.Cursor := crMyRepair;
    exit;
  end
  else if Sender = DMenuSuperRepair then begin
    if (g_nCurMerFlag or 8 <> g_nCurMerFlag) then
      exit; 
    if not DStateWin.Visible then begin
      StatePage := 0;
      PageChanged;
      DStateWin.Visible := True;
    end;
    boSuperRepair := True;
    g_CursorMode := cr_Repair;
    FrmMain.Cursor := crMyRepair;
    exit;
  end
  else if (Sender = DMenuRepairAll) or (Sender = DMenuSuperRepairAll) then begin
    if (Sender = DMenuRepairAll) and (g_nCurMerFlag or 4 <> g_nCurMerFlag) then
      exit; 
    if (Sender = DMenuSuperRepairAll) and (g_nCurMerFlag or 8 <> g_nCurMerFlag) then
      exit; 
    nMoney := 0;
    for I := Low(g_UseItems) to High(g_UseItems) do begin
      if g_UseItems[i].s.name <> '' then begin
        if (sm_Arming in g_UseItems[i].s.StdModeEx) and
          (not (CheckItemBindMode(@g_UseItems[i].UserItem, bm_NoRepair))) and
          (g_UseItems[i].UserItem.Dura < g_UseItems[i].UserItem.DuraMax) then begin
          nMoney := nMoney + GetRepairItemPrice(@g_UseItems[i].UserItem, @g_UseItems[i].s);
        end;
      end;
    end;
    if g_UseItems[U_House].S.name <> '' then begin
      for I := Low(g_UseItems[U_House].UserItem.HorseItems) to High(g_UseItems[U_House].UserItem.HorseItems) do begin
        if g_UseItems[U_House].UserItem.HorseItems[I].wIndex > 0 then begin
          Item := HorseItemToClientItem(@g_UseItems[U_House].UserItem.HorseItems[I]);
          if (Item.S.name <> '') and (not (CheckItemBindMode(@Item.UserItem, bm_NoRepair))) and
            (Item.UserItem.Dura < Item.s.DuraMax) then begin
            nMoney := nMoney + GetRepairItemPrice(@Item.UserItem, @Item.s);
          end;
        end;
      end;
    end;
    if Sender = DMenuSuperRepairAll then
      nMoney := nMoney * 3;
    if nMoney > 0 then begin
      ShowStr := '修理装备总费用为: ' + GetGoldStr(nMoney) + ' ' + g_sGoldName + '。';
      if g_MySelf.m_nGold < nMoney then
        ShowStr := ShowStr + '\你身上的金币不够，可能无法对所有装备进行修理，是否继续修理？'
      else
        ShowStr := ShowStr + '是否确认修理？';
      if mrYes = FrmDlg.DMessageDlg(ShowStr, [mbYes, mbNo]) then begin
        frmMain.SendRepairItem(g_nCurMerchant, 0, MakeWord(Integer(Sender = DMenuSuperRepairAll), 0));
      end;
    end
    else
      DMessageDlg('身上没有装备需要修理.', []);
  end;
  if DStateWin.Visible then
    DStateWin.Visible := boOpenStatus;
end;

procedure TFrmDlg.DMenuShopClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if Tag in [0, 1] then begin
      if NpcGoodsIdx <> Tag then begin
        if Tag = 0 then begin
          if High(NpcGoodItems) > 0 then
            DMenuUpDonw.MaxPosition := High(NpcGoodItems) div {$IF Var_Interface = Var_Default}5 - 5{$ELSE}4 - 4{$IFEND}
          else
            DMenuUpDonw.MaxPosition := 0;
        end
        else
          DMenuUpDonw.MaxPosition := 0;
        NpcGoodsIdx := Tag;
        PlaySound(s_glass_button_click);
        DWndBuy.Visible := False;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMenuShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
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
    if NpcGoodsIdx = tag then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
{$ELSE}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := FaceIndex;
      FColor := DFMoveColor;
      nTop := 1;
      if NpcGoodsIdx <> tag then begin
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
        //SetBkMode(Handle, TRANSPARENT);
        TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2,
          SurfaceY(Top) + (Height - TextHeight(Caption)) div 2 + nTop, FColor, Caption);
        //Release;
      end;
    end;
  end;
{$IFEND}

end;

procedure TFrmDlg.DUSHorseReinDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
//  where: integer;
  //boDraw: Boolean;
//  nInt: Integer;
//  showstr: string;
  pRect: TRect;
  Item: TNewClientItem;
begin
  with Sender as TDButton do begin
    FillChar(Item, SizeOf(Item), #0);
    if (Tag in [Low(UserState1.UseItems)..High(UserState1.UseItems)]) then begin
      Item := UserState1.UseItems[Tag];
    end else
    if Tag in [16..20] then begin
      if UserState1.UseItems[U_HOUSE].S.Name <> '' then begin
        Item := HorseItemToClientItem(@UserState1.UseItems[U_HOUSE].UserItem.HorseItems[Tag - 16]);
      end;
    end;
    if Item.S.name <> '' then begin
      d := GetBagItemImg(Item.S.looks);
      if d <> nil then begin
        pRect.Left := SurfaceX(Left - 1);
        pRect.Top := SurfaceY(Top - 1);
        pRect.Right := SurfaceX(Left + Width + 1);
        pRect.Bottom := SurfaceY(Top + Height + 1);
        RefItemPaint(dsurface, d, //人物背包栏
          SurfaceX(Left + (Width - d.Width) div 2),
          SurfaceY(Top + (Height - d.Height) div 2),
          1,
          1,
          @Item, False, [pmShowLevel], @pRect);
      end;
    end;
  end;
end;

procedure TFrmDlg.DUSHorseReinMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  sel: Integer;
  //MoveItemState: TMoveItemState;
  Item: TNewClientItem;
begin
  with Sender as TDControl do begin
    if DParent = nil then exit;
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX + 30;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    sel := Tag;
    FillChar(Item, SizeOf(Item), #0);
    if (sel in [Low(UserState1.UseItems)..High(UserState1.UseItems)]) then begin
      Item := UserState1.UseItems[sel];
    end else
    if sel in [16..20] then begin
      if UserState1.UseItems[U_HOUSE].S.Name <> '' then begin
        Item := HorseItemToClientItem(@UserState1.UseItems[U_HOUSE].UserItem.HorseItems[sel - 16]);
      end;
    end;
    if Item.s.Name <> '' then begin
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(Item, [], []), clwhite, False, Integer(Sender), True);
    end;
    //end;
  end;
end;

procedure TFrmDlg.DButRenewChrDirectPaint(Sender: TObject; dsurface: TDXTexture);
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

procedure TFrmDlg.DButtonTopClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg3.DwindowTop.Visible := not FrmDlg3.DwindowTop.Visible;
end;

procedure TFrmDlg.DBuyAddClick(Sender: TObject; X, Y: Integer);
var
  nCount: integer;
begin
  nCount := StrToIntDef(DBuyEdit.Text, 0);
  if Sender = DBuyAdd then
    inc(nCount)
  else begin
    if nCount > 0 then
      Dec(nCount);
  end;
  DBuyEdit.Text := intToStr(nCount);
  DBuyEditChange(DBuyEdit);
end;

procedure TFrmDlg.DBuyAddDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, False);
      end;
    end;
  end;
end;

function TFrmDlg.GetBuyGoodsIndex(ClientGoods: TClientGoods): Integer;
var
  i: integer;
begin
  Result := 65535;
  for I := 0 to NpcGoodsList.Count - 1 do begin
    if pTClientGoods(NpcGoodsList[i]).ClientItem.s.Idx =
      ClientGoods.ClientItem.s.Idx then begin
      Result := I;
      break;
    end;
  end;
end;

function TFrmDlg.GetBuyCount(nQueryCount: Integer; ClientGoods: TClientGoods; boBindGold: Boolean): Integer;
var
  pGold: pInteger;
  BagCount: Integer;
begin
  Result := nQueryCount;
  if g_MySelf = nil then
    exit;
  if boBindGold then
    pGold := @g_nBindGold
  else
    pGold := @g_MySelf.m_nGold;
  if (ClientGoods.nItemPic * Result) > pGold^ then begin
    Result := pGold^ div ClientGoods.nItemPic;
  end;
  BagCount := _MIN(10, GetBagResidualCount());
  if Result > 0 then begin
    if (sm_Superposition in ClientGoods.ClientItem.s.StdModeEx) and (ClientGoods.ClientItem.s.DuraMax > 1) then begin
      if BagCount > 0 then begin
        if Result > ClientGoods.ClientItem.s.DuraMax then
          Result := ClientGoods.ClientItem.s.DuraMax
      end
      else
        Result := 0;
    end
    else if Result > BagCount then
      Result := BagCount;
  end;
end;

procedure TFrmDlg.DBuyEditChange(Sender: TObject);
begin
  DBuyEdit.OnChange := nil;
  try
    {nCount := StrToIntDef(DBuyEdit.Text, 0);
    {if (BuyGoods.nItemPic * nCount) > g_MySelf.m_nGold then begin
      nCount := g_MySelf.m_nGold div BuyGoods.nItemPic;
    end;
    BagCount := GetBagResidualCount();
    if nCount > 0 then begin
      if sm_Superposition in BuyGoods.ClientItem.s.StdModeEx then begin
        if BagCount > 0 then begin
          if nCount > BuyGoods.ClientItem.s.DuraMax then
            nCount := BuyGoods.ClientItem.s.DuraMax
        end
        else
          nCount := 0;
      end
      else if nCount > BagCount then
        nCount := BagCount;
    end;     }
    DBuyEdit.Text := IntToStr(GetBuyCount(StrToIntDef(DBuyEdit.Text, 0), BuyGoods, NpcBindGold));
  finally
    DBuyEdit.OnChange := DBuyEditChange;
  end;

end;

procedure TFrmDlg.DBuyEditKeyPress(Sender: TObject; var Key: Char);
begin
  if byte(Key) = 13 then begin
    DBuyOKClick(DBuyOk, 0, 0);
    Key := #0;
  end;
  if byte(Key) = 27 then begin
    DWndBuy.Visible := FALSE;
    Key := #0;
  end;
end;

procedure TFrmDlg.DBuyOKClick(Sender: TObject; X, Y: Integer);
var
  nCount: integer;
  idx: integer;
begin
  if g_SellDlgItemSellWait.Item.S.name <> '' then
    exit;
  nCount := StrToIntDef(DBuyEdit.Text, 0);
  idx := GetBuyGoodsIndex(buyGoods);
  if (Length(NpcGoodItems) > 0) and (nCount > 0) and (idx >= 0) and (idx < 60000) then begin
    frmMain.SendBuyItem(g_nCurMerchant, idx, nCount, NpcBindGold);
    g_SellDlgItemSellWait.Item.S.name := NpcGoodItems[idx].ClientItem.s.name;
  end;
  DWndBuy.Visible := False;
end;

procedure TFrmDlg.DCBGroupItemDefClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DCBGroupItemDef then begin
    DCBGroupItemDef.Checked := True;
    DCBGroupItemRam.Checked := False;
  end
  else if Sender = DCBGroupItemRam then begin
    DCBGroupItemRam.Checked := True;
    DCBGroupItemDef.Checked := False;
  end;
  g_GroupItemMode := DCBGroupItemRam.Checked;
end;

procedure TFrmDlg.DccManWarriorDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  Idx: Integer;
begin
  with Sender as TDButton do begin
    Idx := btJob * 10 + btSex;
    if Idx = Tag then d := WLib.Images[FaceIndex]
    else d := WLib.Images[FaceIndex + 1];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DccWarriorDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
{$IF Var_Interface = Var_Mir2}
    if (Tag = btJob) or ((Tag - 10) = btSex) then begin
      d := WLib.Images[FaceIndex - 5];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left) - 1, SurfaceY(Top) - 1, d.ClientRect, d, True);
    end else
    if Downed then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
{$ELSE}
    if Tag = btJob then begin
      d := WLib.Images[FaceIndex + 1];
    end
    else if (Tag - 10) = btSex then begin
      d := WLib.Images[FaceIndex + 1];
    end
    else if (Tag - 20) = btWuXin then begin
      d := WLib.Images[FaceIndex + 1];
    end
    else
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2,
        SurfaceY(Top) + (Height - TextHeight(Caption)) div 2, DFColor, Caption);
      //Release;
    end;
{$IFEND}
  end;
end;

procedure TFrmDlg.DccWarriorMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
{$IF Var_Interface =  Var_Default}
var
  ShowMsg: string;
{$IFEND}
begin
  //X := DCreateChr.SurfaceX(DCreateChr.Left);
  //y := DCreateChr.SurfaceY(DCreateChr.Top);
{$IF Var_Interface =  Var_Default}
  with Sender as TDControl do begin
    X := SurfaceX(Left + Width + 2);
    y := SurfaceY(Top + 1);
    ShowMsg := '';
    if (Sender = DccWarrior) or (Sender = DccManWarrior) or (Sender = DccWoManWarrior) then begin
      ShowMsg := '战  士\';
      ShowMsg := ShowMsg + '以强有力的体格为基础,特殊之处在\';
      ShowMsg := ShowMsg + '于用剑法及刀法等技术.对打猎、战\';
      ShowMsg := ShowMsg + '斗比较适用.体力强的战士能带许多\';
      ShowMsg := ShowMsg + '东西,既便穿戴沉重的武器及铠甲也\';
      ShowMsg := ShowMsg + '可以自由活动.但战士所戴的铠甲对\';
      ShowMsg := ShowMsg + '魔法的防御能力相对较低.';
      if (Sender = DccManWarrior) or (Sender = DccWoManWarrior) then begin
        X := DccManWarrior.SurfaceX(DccManWarrior.Left + 1);
        y := DccManWarrior.SurfaceY(DccManWarrior.Top + DccManWarrior.Height + 1);
        ShowMsg := '战  士\';
        ShowMsg := ShowMsg + '以强有力的体格为基础,特殊之处在于用剑法及刀法等技\';
        ShowMsg := ShowMsg + '术.对打猎、战斗比较适用.体力强的战士能带许多东西,\';
        ShowMsg := ShowMsg + '既便穿戴沉重的武器及铠甲也可以自由活动.但战士所戴\';
        ShowMsg := ShowMsg + '的铠甲对魔法的防御能力相对较低.\';
      end;
    end;
    //SelectChrScene.SelChrNewJob(0);
    if (Sender = DccWizzard) or (Sender = DccManWizzard) or (Sender = DccWoManWizzard) then begin
      ShowMsg := '魔法师\';
      ShowMsg := ShowMsg + '以长时间锻炼的内功为基础,能发挥\';
      ShowMsg := ShowMsg + '强大的攻击型魔法.魔法攻击力卓越,\';
      ShowMsg := ShowMsg + '但体力较弱.对体力上直接受到攻击\';
      ShowMsg := ShowMsg + '的防御能力较低,另外,发挥高水平\';
      ShowMsg := ShowMsg + '的魔法时需要较长时间,此时可能受\';
      ShowMsg := ShowMsg + '到对方的快速攻击.魔法师的魔法比\';
      ShowMsg := ShowMsg + '任何攻击能力都强大,能有效的威胁\';
      ShowMsg := ShowMsg + '对方.';
      if (Sender = DccManWizzard) or (Sender = DccWoManWizzard) then begin
        X := DccManWizzard.SurfaceX(DccManWizzard.Left + 1);
        y := DccManWizzard.SurfaceY(DccManWizzard.Top + DccManWizzard.Height + 1);
        ShowMsg := '魔法师\';
        ShowMsg := ShowMsg + '以长时间锻炼的内功为基础,能发挥强大的攻击型魔法.\';
        ShowMsg := ShowMsg + '魔法攻击力卓越,但体力较弱.对体力上直接受到攻击的\';
        ShowMsg := ShowMsg + '防御能力较低,另外,发挥高水平的魔法时需要较长时间,\';
        ShowMsg := ShowMsg + '此时可能受到对方的快速攻击.魔法师的魔法比任何攻\';
        ShowMsg := ShowMsg + '击能力都强大,能有效的威胁对方.\';
      end;
    end;

    //SelectChrScene.SelChrNewJob(1);
    if (Sender = DccMonk) or (Sender = DccManMonk) or (Sender = DccWoManMonk) then begin
      ShowMsg := '道  士\';
      ShowMsg := ShowMsg + '以强大的精神力作为基础,可以使用\';
      ShowMsg := ShowMsg + '治疗术帮助别人.对自然很熟悉,在\';
      ShowMsg := ShowMsg + '用毒方面的能力最强.博学多知,能\';
      ShowMsg := ShowMsg + '使用剑术和魔法,所以每时每刻都能\';
      ShowMsg := ShowMsg + '发挥多样的法术,随机应变性强.\';
      if (Sender = DccManMonk) or (Sender = DccWoManMonk) then begin
        X := DccManMonk.SurfaceX(DccManMonk.Left + 1);
        y := DccManMonk.SurfaceY(DccManMonk.Top + DccManMonk.Height + 1);
        ShowMsg := '道  士\';
        ShowMsg := ShowMsg + '以强大的精神力作为基础,可以使用治疗术帮助别人.对自\';
        ShowMsg := ShowMsg + '然很熟悉,在用毒方面的能力最强.博学多知,能使用剑术\';
        ShowMsg := ShowMsg + '和魔法,所以每时每刻都能发挥多样的法术,随机应变性强.\';
      end;
    end;

    if Sender = DccJ then begin
      ShowMsg := '金\';
      ShowMsg := ShowMsg + '相生: 金生水、土生金    相克: 金克木、火克金\';
      ShowMsg := ShowMsg + '详细五行说明\';
      ShowMsg := ShowMsg + '进入游戏后请查看帮助\';
      X := SurfaceX(Left + 1);
      y := SurfaceY(Top + Height + 2);
    end;
    if Sender = DccM then begin
      ShowMsg := '木\';
      ShowMsg := ShowMsg + '相生: 木生火、水生木    相克: 木克土、金克木\';
      ShowMsg := ShowMsg + '详细五行说明\';
      ShowMsg := ShowMsg + '进入游戏后请查看帮助\';
      X := SurfaceX(Left + 1);
      y := SurfaceY(Top + Height + 2);
    end;
    if Sender = DccS then begin
      ShowMsg := '水\';
      ShowMsg := ShowMsg + '相生: 水生木、金生水    相克: 水克火、土克水\';
      ShowMsg := ShowMsg + '详细五行说明\';
      ShowMsg := ShowMsg + '进入游戏后请查看帮助\';
      X := SurfaceX(Left + 1);
      y := SurfaceY(Top + Height + 2);
    end;
    if Sender = DccH then begin
      ShowMsg := '火\';
      ShowMsg := ShowMsg + '相生: 火生土、木生火    相克: 火克金、水克火\';
      ShowMsg := ShowMsg + '详细五行说明\';
      ShowMsg := ShowMsg + '进入游戏后请查看帮助\';
      X := SurfaceX(Left + 1);
      y := SurfaceY(Top + Height + 2);
    end;
    if Sender = DccT then begin
      ShowMsg := '土\';
      ShowMsg := ShowMsg + '相生: 土生金、火生土    相克: 土克水、木克土\';
      ShowMsg := ShowMsg + '详细五行说明\';
      ShowMsg := ShowMsg + '进入游戏后请查看帮助\';
      X := SurfaceX(Left + 1);
      y := SurfaceY(Top + Height + 2);
    end;
    DScreen.ShowHint(x, y, ShowMsg, clWhite, False, Integer(Sender));
  end;
{$IFEND}
end;

procedure TFrmDlg.dchkSayLockChange(Sender: TObject);
begin
  g_SayUpDownLock := not dchkSayLock.Checked;
end;

procedure TFrmDlg.DCloseSayHearClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount < TDButton(Sender).AppendTick then Exit;
  TDButton(Sender).AppendTick := GetTickCount + 200;
  if Sender = DCloseSayHear then begin
    SetIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR, not CheckIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR));
    frmMain.SendGroupMode;
  end else
  if Sender = DCloseSayWhisper then begin
    SetIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER, not CheckIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER));
    frmMain.SendGroupMode;
  end else
  if Sender = DCloseSayCry then begin
    SetIntStatus(g_nGameSetupData, GSP_NOTSAYCRY, not CheckIntStatus(g_nGameSetupData, GSP_NOTSAYCRY));
    frmMain.SendGroupMode;
  end else
  if Sender = DCloseSayGuild then begin
    SetIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD, not CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD));
    frmMain.SendGroupMode;
  end else
  if Sender = DCloseSayGroup then begin
    SetIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP, not CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP));
    frmMain.SendGroupMode;
  end;
end;

procedure TFrmDlg.DCloseSayHearDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  boClick: Boolean;
begin
  boClick := False;
  if Sender = DCloseSayHear then begin
    boClick := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR);
  end else
  if Sender = DCloseSayWhisper then begin
    boClick := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER);
  end else
  if Sender = DCloseSayCry then begin
    boClick := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYCRY);
  end else
  if Sender = DCloseSayGuild then begin
    boClick := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD);
  end else
  if Sender = DCloseSayGroup then begin
    boClick := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP);
  end;
  with Sender as TDButton do begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex + Integer(boClick)];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;

  {
  dchkSayHear.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR);
    dchkSayWhisper.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER);
    dchkSayCry.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYCRY);
    dchkSayGroup.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP);
    dchkSayGuild.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD);


  SetIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR, dchkSayHear.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER, dchkSayWhisper.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYCRY, dchkSayCry.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP, dchkSayGroup.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD, dchkSayGuild.Checked); }
end;

procedure TFrmDlg.DCloseSayHearMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left + Width);
    y := SurfaceY(Top);
    ShowMsg := '';
    if Sender = DCloseSayHear then begin
      ShowMsg := '拒绝附近聊天';
    end else
    if Sender = DCloseSayWhisper then begin
      ShowMsg := '拒绝私聊';
    end else
    if Sender = DCloseSayCry then begin
      ShowMsg := '拒绝喊话';
    end else
    if Sender = DCloseSayGuild then begin
      ShowMsg := '拒绝行会聊天';
    end else
    if Sender = DCloseSayGroup then begin
      ShowMsg := '拒绝队伍聊天';
    end;
  end;
  if ShowMsg <> '' then
    DScreen.ShowHint(x, y, ShowMsg, clWhite, False, Integer(Sender));
end;

procedure TFrmDlg.DCreateChrDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
{$IF Var_Interface =  Var_Default}
  fx, fy, img: Integer;
{$IFEND}
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
{$IF Var_Interface =  Var_Default}
    with g_DXCanvas do begin
      img := 20 + btjob * 60 + btsex * 180 + btAniIndex;
      d := g_WChrSelImages.GetCachedImage(img, fx, fy);
      if d <> nil then
        dsurface.Draw(ax + fx + 145, ay + fy + 245, d.ClientRect, d, True);
      d := g_WChrSelImages.GetCachedImage(img + 20, fx, fy);
      if d <> nil then
        DrawBlend(DSurface, ax + fx + 145, ay + fy + 245, D, 1);
      //dsurface.Draw(ax + fx + 145, ay + fy + 245, d.ClientRect, d, $FFFFFFFF, fxAdd);

      if GetTickCount - dwStartTime > 200 then begin
        dwStartTime := GetTickCount;
        btAniIndex := btAniIndex + 1;
        if btAniIndex > 15 then
          btAniIndex := 0;
      end;
      TextOut(SurfaceX(Left) + 36, SurfaceY(Top) + 54, clSilver, '职业: ' + GetJobName(btjob));
      //TextOut(SurfaceX(Left) + 36, SurfaceY(Top) + 68, clSilver, '五行: ' + GetWuXinName(btWuXin + 1));
    end;
{$IFEND}
  end;
end;

procedure TFrmDlg.DCreateChrVisible(Sender: TObject; boVisible: Boolean);
begin
{$IF Var_Interface = Var_Mir2}
  if boVisible then begin
    SelectChrScene.SelChrNewJob(btJob);
    SelectChrScene.SelChrNewm_btSex(btSex);
  end;
{$IFEND}
end;

procedure TFrmDlg.DDealCloseClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwDealActionTick then begin
    CloseDealDlg;
    frmMain.SendCancelDeal;
  end;
end;

procedure TFrmDlg.DDealDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
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

    with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
      TextOut(ax + 95, ay + 30, g_sDealWho, clWhite);
      TextOut(ax + 28, ay + 129, g_sGoldName + ': ' + GetGoldStr(g_nDealRemoteGold), clWhite);
      TextOut(ax + 28, ay + 249, g_sGoldName + ': ' + GetGoldStr(g_nDealGold), clWhite);
{$ELSE}
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
      TextOut((ax + 158) - TextWidth(g_sDealWho) div 2, ay + 47 + 4, g_sDealWho, clWhite);
      TextOut(ax + 28, ay + 150 + 4, g_sGoldName + ': ' + GetGoldStr(g_nDealRemoteGold), clWhite);
      TextOut(ax + 28, ay + 273 + 4, g_sGoldName + ': ' + GetGoldStr(g_nDealGold), clWhite);
{$IFEND}

    end;
  end;
end;

procedure TFrmDlg.DDealLockClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwDealActionTick then begin
    frmMain.SendDealLock;
    g_dwDealActionTick := GetTickCount + 1000;
    g_boDealLock := True;
    DDealOk.Enabled := DDRDealLock.Checked;
    DDealLock.Enabled := False;
  end;
end;

procedure TFrmDlg.DDealOkClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwDealActionTick then begin
    frmMain.SendDealEnd;
    g_dwDealActionTick := GetTickCount + 4000;
    g_boDealEnd := True;
    DDealOk.Enabled := False;
    DDealLock.Enabled := False;
  end;
end;

procedure TFrmDlg.DDGoldClick(Sender: TObject; X, Y: Integer);
var
  DGold: Integer;
  valstr: string;
begin
  if g_MySelf = nil then
    Exit;
  if (not g_boDealEnd) and (not g_boDealLock) and (GetTickCount > g_dwDealActionTick) then begin
    if not g_boItemMoving then begin
      if g_nDealGold > 0 then begin
        PlaySound(s_money);
        g_boItemMoving := True;
        g_MovingItem.Index2 := -97; //背券 芒俊辑狼 捣
        g_MovingItem.ItemType := mtDealGold;
        g_MovingItem.Item.S.name := g_sGoldName {'金币'};
      end;
    end
    else begin
      if (g_MovingItem.ItemType = mtDealGold) or (g_MovingItem.ItemType = mtBagGold) then begin
        if (g_MovingItem.ItemType = mtBagGold) and (g_MovingItem.Item.S.name = g_sGoldName) then begin
          g_boItemMoving := FALSE;
          g_MovingItem.Item.S.name := '';
          DMessageDlg('请输入要放入的' + g_sGoldName + '数量：', [mbOk, mbAbort]);
          GetValidStrVal(DlgEditText, valstr, [' ']);
          DGold := StrToIntDef(valstr, 0);
          if (DGold <= (g_nDealGold + g_MySelf.m_nGold)) and (DGold > 0) then begin
            frmMain.SendChangeDealGold(DGold);
            g_dwDealActionTick := GetTickCount + 4000;
          end;
        end;
        g_boItemMoving := FALSE;
        g_MovingItem.Item.S.name := '';
      end;
    end;
  end;
end;

procedure TFrmDlg.DDGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * DDGrid.ColCount;
    if idx in [0..MAXDEALITEMCOUNT - 1] then begin
      if g_DealItems[idx].s.Name <> '' then begin
        with DDGrid do
          DScreen.ShowHint(SurfaceX(Left + (x - left)), SurfaceY(Top + (y - Top) + 30),
            ShowItemInfo(g_DealItems[idx], [mis_MyDeal], []), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DDGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  idx: Integer;
  d: TDXTexture;
  pRect: TRect;
begin
  idx := ACol + ARow * DDGrid.ColCount;
  if idx in [0..MAXDEALITEMCOUNT - 1] then begin
    if g_DealItems[idx].S.name <> '' then begin
      d := GetBagItemImg(g_DealItems[idx].S.looks);
      if d <> nil then
        with DDGrid do begin //交易窗口
          pRect.Left := SurfaceX(Rect.Left);
          pRect.Top := SurfaceY(Rect.Top);
          pRect.Right := SurfaceX(Rect.Right + 1);
          pRect.Bottom := SurfaceY(Rect.Bottom);
          RefItemPaint(dsurface, d,
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @g_DealItems[idx], True, [pmShowLevel], @pRect);
        end;
    end;
  end;
end;

procedure TFrmDlg.DDGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  if (not g_boDealEnd) and (not g_boDealLock) and (GetTickCount > g_dwDealActionTick) then begin
    if not g_boItemMoving then begin
      idx := ACol + ARow * DDGrid.ColCount;
      if idx in [0..MAXDEALITEMCOUNT - 1] then
        if g_DealItems[idx].S.name <> '' then begin
          if (not g_boDealEnd) and (not g_boDealLock) and (g_DealDlgItem.Item.s.Name = '') then begin
            g_DealDlgItem.Index2 := idx;
            g_DealDlgItem.Item := g_DealItems[idx];
            frmMain.SendDelDealItem(g_DealItems[idx]);
            g_DealItems[idx].S.name := '';
            ItemClickSound(g_DealDlgItem.Item.S);
            g_dwDealActionTick := GetTickCount + 4000;
          end;
        end;
    end
    else begin
      if g_MovingItem.ItemType = mtDealGold then
        g_boItemMoving := False
      else if g_MovingItem.ItemType = mtBagGold then
        DDGoldClick(Self, 0, 0)
      else if (g_MovingItem.ItemType = mtBagItem) and (not g_boDealEnd) and (not g_boDealLock) and
        (g_DealDlgItem.Item.s.Name = '') then begin
        ItemClickSound(g_MovingItem.Item.S);
        if CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoDeal) then begin
          AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
          ClearMovingItem();
          DMessageDlg('该物品不允许进行交易！', [mbOk]);
          exit;
        end;
        g_DealDlgItem := g_MovingItem;
        frmMain.SendAddDealItem(g_DealDlgItem.Item);
        g_dwDealActionTick := GetTickCount + 4000;

        ClearMovingItem();
      end;
    end;
    ArrangeItembag;
  end;
end;

procedure TFrmDlg.DDRGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDgrid do begin
    idx := ACol + ARow * DDRGrid.ColCount;
    if idx in [0..MAXDEALITEMCOUNT - 1] then begin
      if g_DealRemoteItems[idx].s.Name <> '' then begin
        with DDRGrid do
          DScreen.ShowHint(SurfaceX(Left + (x - left)), SurfaceY(Top + (y - Top) + 30),
            ShowItemInfo(g_DealRemoteItems[idx], [], []), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  idx: Integer;
  d: TDXTexture;
  pRect: TRect;
begin
  idx := ACol + ARow * DDRGrid.ColCount;
  if idx in [0..MAXDEALITEMCOUNT - 1] then begin
    if g_DealRemoteItems[idx].S.name <> '' then begin
      d := GetBagItemImg(g_DealRemoteItems[idx].S.looks);
      if d <> nil then
        with DDRGrid do begin //交易窗口
          pRect.Left := SurfaceX(Rect.Left);
          pRect.Top := SurfaceY(Rect.Top);
          pRect.Right := SurfaceX(Rect.Right + 1);
          pRect.Bottom := SurfaceY(Rect.Bottom);
          RefItemPaint(dsurface, d,
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @g_DealRemoteItems[idx], True, [pmShowLevel], @pRect);
        end;
    end;
  end;
end;
{
procedure TFrmDlg.DealItemReturnBag(mitem: TNewClientItem);
begin
 if not g_boDealEnd then begin
   g_DealDlgItem := mitem;
   frmMain.SendDelDealItem(g_DealDlgItem);
   g_dwDealActionTick := GetTickCount + 4000;
 end;
end; }

procedure TFrmDlg.DealZeroGold;
begin
  if not g_boDealEnd and (g_nDealGold > 0) then begin
    g_dwDealActionTick := GetTickCount + 4000;
    frmMain.SendChangeDealGold(0);
  end;
end;

procedure TFrmDlg.DEditChatChange(Sender: TObject);
var
  Text: string;
begin
  Text := DEditChat.Text;
  g_SayMode := usm_Hear;
  if Text <> '' then begin
    case Text[1] of
      '/': g_SayMode := usm_Whisper;
      '!': begin
          g_SayMode := usm_Cry;
          if length(Text) > 1 then begin
            if Text[2] = '!' then
              g_SayMode := usm_Group
            else if Text[2] = '~' then
              g_SayMode := usm_Guild;
          end;
        end;
      '@': begin
          if CompareLStr(Text, g_Cmd_AllMsg + ' ', Length(g_Cmd_AllMsg + ' ')) then
            g_SayMode := usm_World;
        end;
    end;
  end;
  if (Text = '/') and (g_MyWhisperList.Count > 0) then
    dwndWhisperName.Visible := True
  else
    dwndWhisperName.Visible := False;
end;

procedure TFrmDlg.DEditChatCheckItem(Sender: TObject; ItemIndex: Integer; var ItemName: string);
var
  i: Integer;
begin
  ItemName := '';
  if ItemIndex <= 0 then
    exit;
  for I := Low(g_ItemArr) to High(g_ItemArr) do begin
    if g_ItemArr[i].UserItem.MakeIndex = ItemIndex then begin
      ItemName := g_ItemArr[i].s.Name;
      Break;
    end;
  end;
end;

procedure TFrmDlg.DEditChatClick(Sender: TObject; X, Y: Integer);
var
  nBack: Byte;
begin
  nBack := 255;
  if g_boItemMoving then begin
    if g_MovingItem.ItemType = mtBagItem then begin
      nBack := DEditChat.AddItemToList(g_MovingItem.Item.s.Name,
        IntToStr(g_MovingItem.Item.UserItem.MakeIndex));
    end;
    CancelItemMoving;
    case nBack of
      2: DMessageDlg('[错误]：聊天框允许发送的长度不够！！', []);
      3: DMessageDlg('[错误]：已经存在相同的装备于聊天框中！！', []);
      4: DMessageDlg('[错误]：已超过每次发送的最大数量限制！！', []);
      255: DMessageDlg('[错误]：该装备无法增加，只能使用背包中的物品！！', []);
    end;
  end;
end;

procedure TFrmDlg.DEditChatDrawEditImage(Sender: TObject; ImageSurface: TDXTexture; Rect: TRect;
  ImageIndex: Integer);
var
  d: TDXTexture;
  ax, ay, nx, ny: integer;
  py: smallint;
begin
  with Sender as TDControl do begin
    if ImageIndex in [Low(g_FaceIndexInfo)..High(g_FaceIndexInfo)] then begin
      d := g_WFaceImages.GetCachedImage(g_FaceIndexInfo[ImageIndex].ImageIndex, nx, ny);
      if d <> nil then begin
        ax := Rect.Left;
        ay := Rect.Top + ((Rect.Bottom - Rect.Top) - d.Height) div 2;
        ImageSurface.Draw(ax, ay, d.ClientRect, d, True);
        py := ny;
        if (GetTickCount - g_FaceIndexInfo[ImageIndex].dwShowTime) > LongWord(nx) then begin
          g_FaceIndexInfo[ImageIndex].ImageIndex := g_FaceIndexInfo[ImageIndex].ImageIndex + py;
          g_FaceIndexInfo[ImageIndex].dwShowTime := GetTickCount;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DEditChatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if dwndWhisperName.Visible then begin
    if Key = VK_UP then begin
      Inc(FSayNameIndex);
      if FSayNameIndex >= g_MyWhisperList.Count then
        FSayNameIndex := g_MyWhisperList.Count - 1;
      if FSayNameIndex > 7 then
        FSayNameIndex := 7;
      Key := 0;
    end
    else if Key = VK_DOWN then begin
      Dec(FSayNameIndex);
      if FSayNameIndex < 0 then
        FSayNameIndex := 0;
      Key := 0;
    end;
  end;
end;

procedure TFrmDlg.DEditChatKeyPress(Sender: TObject; var Key: Char);
  procedure SelectChatName;
  begin
    if (FSayNameIndex >= 0) and (FSayNameIndex < g_MyWhisperList.Count) then begin
      DEditChat.Text := '/' + g_MyWhisperList[FSayNameIndex] + ' ';
    end;
  end;
var
  SayMode: TUserSayMode;
begin
  SayMode := g_SayMode;
  DEditChat.OnKeyPress := nil;
  try
    if Key = #32 then begin
      if dwndWhisperName.Visible then begin
        SelectChatName;
        Key := #0;
      end;
    end
    else if Key = #13 then begin
      if dwndWhisperName.Visible then begin
        SelectChatName;
        Key := #0;
      end
      else begin
        if (g_SayMode = usm_World) and ((g_UseItems[U_CIMELIA].s.Name = '') or (g_UseItems[U_CIMELIA].s.StdMode <> tm_Cowry) or
          (g_UseItems[U_CIMELIA].s.Shape <> 0) or (g_UseItems[U_CIMELIA].UserItem.Dura <= 0)) then begin
          FrmDlg.DMessageDlg('必需装备[千里传音]才能使用千里传音喊话功能！', []);
          FrmDlg.DEditChat.SetFocus;
          Key := #0;
          exit;
        end;
        frmMain.SendSay(FrmDlg.DEditChat.Text);
        FrmDlg.DEditChat.Text := '';
        FrmDlg.DEditChat.Visible := FALSE;
        Key := #0;
      end;
    end
    else if Key = #27 then begin
      FrmDlg.DEditChat.Text := '';
      FrmDlg.DEditChat.Visible := FALSE;
      Key := #0;
    end;
  finally
    DEditChat.OnKeyPress := DEditChatKeyPress;
    g_SayMode := SayMode;
  end;
end;

procedure TFrmDlg.DEditChatVisible(Sender: TObject; boVisible: Boolean);
begin
  if not boVisible then begin
  end;
end;

procedure TFrmDlg.DEditIDMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Clipboard: TClipboard;
begin
  with Sender as TDControl do begin
    if (mbRight = Button) and (Enabled) then begin
      Clipboard := TClipboard.Create;
      try
        DPopUpEdits.Visible := False;
        DPopUpEdits.Item.Clear;
        //DPopUpEdits.Item.AddObject('撤消     Ctrl+Z', nil);
        //DPopUpEdits.Item.AddObject('-', nil);
        if Selected and (not ReadOnly) then
          DPopUpEdits.Item.AddObject('剪切     Ctrl+X', TObject(1))
        else
          DPopUpEdits.Item.AddObject('剪切     Ctrl+X', nil);

        if Selected then
          DPopUpEdits.Item.AddObject('复制     Ctrl+C', TObject(2))
        else
          DPopUpEdits.Item.AddObject('复制     Ctrl+C', nil);

        if (Clipboard.AsText <> '') and (not ReadOnly) then
          DPopUpEdits.Item.AddObject('粘贴     Ctrl+V', TObject(3))
        else
          DPopUpEdits.Item.AddObject('粘贴     Ctrl+V', nil);

        if Selected and (not ReadOnly) then
          DPopUpEdits.Item.AddObject('删除     Delete', TObject(4))
        else
          DPopUpEdits.Item.AddObject('删除     Delete', nil);
        DPopUpEdits.Item.AddObject('-', nil);

        DPopUpEdits.Item.AddObject('全选     Ctrl+A', TObject(5));
        DPopUpEdits.RefSize;
        DPopUpEdits.Popup(Sender, SurfaceX(X), SurfaceY(Y), '');
      finally
        Clipboard.Free;
      end;
    end;
  end;
end;

procedure TFrmDlg.DPopUpEditsPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
var
  Key: Word;
begin
  with DControl do begin
    case Integer(TDPopUpMemu(Sender).Item.Objects[ItemIndex]) of
      1: begin
          Key := Word('X');
          KeyDown(Key, [ssCtrl]);
        end;
      2: begin
          Key := Word('C');
          KeyDown(Key, [ssCtrl]);
        end;
      3: begin
          Key := Word('V');
          KeyDown(Key, [ssCtrl]);
        end;
      4: begin
          Key := VK_DELETE;
          KeyDown(Key, []);
        end;
      5: begin
          Key := Word('A');
          KeyDown(Key, [ssCtrl]);
        end;
    end;
  end;
end;
{
procedure TFrmDlg.DelStorageItem(itemserverindex: Integer);
var
 i: Integer;
 pg: PTClientGoods;
begin
 for i := 0 to MenuList.count - 1 do begin
   pg := PTClientGoods(MenuList[i]);
   if (pg.ClientItem.UserItem.MakeIndex = itemserverindex) then begin
     Dispose(pg);
     MenuList.Delete(i);
     DMenuUpDonw.MaxPosition := MenuList.Count - 4;
     if i < g_SaveItemList.count then
       g_SaveItemList.Delete(i);
     if menuindex > MenuList.count - 1 then
       menuindex := MenuList.count - 1;
     break;
   end;
 end;
end;       }

procedure TFrmDlg.DGoldClick(Sender: TObject; X, Y: Integer);
begin
  if g_MySelf = nil then
    Exit;
  if not g_boItemMoving then begin
    if g_MySelf.m_nGold > 0 then begin
      PlaySound(s_money);
      g_boItemMoving := True;
      g_MovingItem.Index2 := -98;
      g_MovingItem.Item.S.name := g_sGoldName {'金币'};
      g_MovingItem.ItemType := mtBagGold;
    end;
  end
  else begin
    if (g_MovingItem.ItemType = mtDealGold) or (g_MovingItem.ItemType = mtBagGold) then begin
      g_boItemMoving := FALSE;
      g_MovingItem.Item.S.name := '';
      if g_MovingItem.ItemType = mtDealGold then
        DealZeroGold;
    end;
  end;
end;

procedure TFrmDlg.DGroupDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
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
{$IF Var_Interface =  Var_Default}
    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
      //Release;
    end;
{$IFEND}
    DGrpAllowGroup.Checked := not CheckIntStatus(g_nGameSetupData, GSP_NOTGROUP);
    DGrpCheckGroup.Checked := CheckIntStatus(g_nGameSetupData, GSP_GROUPCHECK);
    DCBGroupItemRam.Checked := g_GroupItemMode;
    DCBGroupItemDef.Checked := not g_GroupItemMode;
  end;
end;

procedure TFrmDlg.DGroupDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  UserListMoveIndex := -1;
  GroupListMoveIndex := -1;
end;

procedure TFrmDlg.DGroupDlgVisible(Sender: TObject; boVisible: Boolean);
begin
  GroupListIndex := -1;
  UserListIndex := -1;
  UserListMoveIndex := -1;
  GroupListMoveIndex := -1;
end;

procedure TFrmDlg.DGroupExitClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.count > 0) then begin
    who := g_MySelf.m_UserName;
    if who <> '' then begin
      g_dwChangeGroupModeTick := GetTickCount + 2000; //timeout 5檬
      frmMain.SendDelGroupMember(who);
    end;
  end;
end;

procedure TFrmDlg.DGrpAddMemClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  if (GetTickCount > g_dwChangeGroupModeTick) {and (g_GroupMembers.count > 0)} then begin
    DMessageDlg('请输入你要添加的人物名称...', [mbOk, mbAbort]);
    who := Trim(DlgEditText);
    if who <> '' then begin
      g_dwChangeGroupModeTick := GetTickCount + 2000; //timeout 5檬
      CreateGroup(who);
    end;
  end;
end;

procedure TFrmDlg.DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwChangeGroupModeTick then begin
    //g_boAllowGroup := not g_boAllowGroup;
    SetIntStatus(g_nGameSetupData, GSP_NOTGROUP, not CheckIntStatus(g_nGameSetupData, GSP_NOTGROUP));
    g_dwChangeGroupModeTick := GetTickCount + 2000; //timeout 5檬
    frmMain.SendGroupMode;
  end;
end;

procedure TFrmDlg.DGrpCheckGroupClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > g_dwChangeGroupModeTick then begin
    //g_boCheckGroup := not g_boCheckGroup;
    SetIntStatus(g_nGameSetupData, GSP_GROUPCHECK, not CheckIntStatus(g_nGameSetupData, GSP_GROUPCHECK));
    g_dwChangeGroupModeTick := GetTickCount + 2000; //timeout 5檬
    frmMain.SendGroupMode;
  end;
end;

procedure TFrmDlg.DGrpCreateClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  if (GetTickCount > g_dwChangeGroupModeTick) then begin
    if (UserListIndex < RefGroupList.count) and (UserListIndex >= 0) then begin
      who := RefGroupList[UserListIndex];
      if who <> '' then begin
        g_dwChangeGroupModeTick := GetTickCount + 2000; //timeout 5檬
        CreateGroup(who);
      end;
    end
    else
      DMessageDlg('请在附近玩家列表当中，选择你要邀请的对像....', [mbOk]);
  end;
end;

procedure TFrmDlg.DGrpDelMemClick(Sender: TObject; X, Y: Integer);
var
  who: string;
  GroupMember: pTGroupMember;
begin
  if (GetTickCount > g_dwChangeGroupModeTick) then begin
    if (GroupListIndex < g_GroupMembers.count) and (GroupListIndex >= 0) then begin
      GroupMember := g_GroupMembers[GroupListIndex];
      who := GroupMember.ClientGroup.UserName;
      if who <> '' then begin
        g_dwChangeGroupModeTick := GetTickCount + 2000; //timeout 5檬
        frmMain.SendDelGroupMember(who);
      end;
    end;
  end;
end;

procedure TFrmDlg.DGrpMemberListDblClick(Sender: TObject);
var
  who: string;
  GroupMember: pTGroupMember;
begin
  who := '';
  if (GroupListIndex < g_GroupMembers.count) and (GroupListIndex >= 0) then begin
    GroupMember := g_GroupMembers[GroupListIndex];
    who := GroupMember.ClientGroup.UserName;
  end;
  if who <> '' then begin
    PlayScene.SetEditChar(who);
  end;
end;

procedure TFrmDlg.DGrpMemberListDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  i, ax, ay: integer;
  GroupMember: pTGroupMember;
  Actor: TActor;
  nX, nY: Integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      if Sender = DGrpMemberList then begin
        if g_GroupMembers.count > 1 then begin
          GroupMember := g_GroupMembers[0];

          if 0 = GroupListMoveIndex then begin
            FillRect(ax + 4, ay + 3, {$IF Var_Interface = Var_Default}250{$ELSE}230{$IFEND}, 14, $A062625A);
          end
          else if 0 = GroupListIndex then begin
            FillRect(ax + 4, ay + 3, {$IF Var_Interface = Var_Default}250{$ELSE}230{$IFEND}, 14, $C862625A);
          end;
{$IF Var_Interface = Var_Mir2}
            TextOut(ax + 6, ay + 4, $6090C0, GroupMember.ClientGroup.UserName + '(队长)');  
{$ELSE}
          if g_boUseWuXin then
            TextOut(ax + 6, ay + 4, $6090C0, GroupMember.ClientGroup.UserName + '(队长)(' + GetWuXinName(GroupMember.ClientGroup.WuXin) + ')')
          else
            TextOut(ax + 6, ay + 4, $6090C0, GroupMember.ClientGroup.UserName + '(队长)');  
{$IFEND}


          for i := 1 to g_GroupMembers.count - 1 do begin
            GroupMember := g_GroupMembers[i];
            nX := ax + 6 + ((i - 1) mod 2) * {$IF Var_Interface = Var_Default}125{$ELSE}116{$IFEND};
            nY := ay + 21 + (i - 1) div 2 * 14;
            if i = GroupListMoveIndex then begin
              FillRect(nx - 2, ny - 1, {$IF Var_Interface = Var_Default}125{$ELSE}116{$IFEND}, 14, $A062625A);
            end
            else if i = GroupListIndex then begin
              FillRect(nx - 2, ny - 1, {$IF Var_Interface = Var_Default}125{$ELSE}116{$IFEND}, 14, $C862625A);
            end;
{$IF Var_Interface = Var_Mir2}
              TextOut(nX, ny, $B6C0A9, GroupMember.ClientGroup.UserName);
{$ELSE}
            if g_boUseWuXin then
              TextOut(nX, ny, $B6C0A9, GroupMember.ClientGroup.UserName + '(' + GetWuXinName(GroupMember.ClientGroup.WuXin) + ')')
            else
              TextOut(nX, ny, $B6C0A9, GroupMember.ClientGroup.UserName);
{$IFEND}
          end;
        end;
      end
      else if Sender = DGrpUserList then begin
        if (GetTickCount - AppendTick) > 1000 then begin
          AppendTick := GetTickCount;
          RefGroupList.Clear;
          with PlayScene do begin
            for i := 0 to m_ActorList.Count - 1 do begin
              Actor := m_ActorList[i];
              if (Actor.m_btRace = 0) and (Actor.m_Group = nil) and (Actor <> g_MySelf) then begin
                RefGroupList.AddObject(Actor.m_UserName, TObject(Actor));
              end;
            end;
            if RefGroupList.Count > {$IF Var_Interface = Var_Default}9{$ELSE}8{$IFEND} then begin
              DGroupUpDown.MaxPosition := RefGroupList.Count - {$IF Var_Interface = Var_Default}9{$ELSE}8{$IFEND};
            end
            else begin
              DGroupUpDown.MaxPosition := 0;
              DGroupUpDown.Position := 0;
            end;
          end;
        end;
        if RefGroupList.count > 0 then begin
          for i := DGroupUpDown.Position to DGroupUpDown.Position + {$IF Var_Interface = Var_Default}8{$ELSE}7{$IFEND} do begin
            if i >= RefGroupList.count then
              Break;
            {if i = UserListIndex then
              nFColor := clYellow
            else
              nFColor := $B6C0A9;   }
            if i = UserListMoveIndex then begin
              FillRect(ax + 2, ay + 2 + (i - DGroupUpDown.Position) * 14, {$IF Var_Interface = Var_Default}250{$ELSE}218{$IFEND}, 14, $A062625A);
            end
            else if i = UserListIndex then begin
              FillRect(ax + 2, ay + 2 + (i - DGroupUpDown.Position) * 14, {$IF Var_Interface = Var_Default}250{$ELSE}218{$IFEND}, 14, $C862625A);
            end;
{$IF Var_Interface = Var_Mir2}
            TextOut(ax + 36 - Left, ay + 3 + (i - DGroupUpDown.Position) * 14, $B6C0A9, RefGroupList[i]);
{$ELSE}
            TextOut(ax + 6, ay + 3 + (i - DGroupUpDown.Position) * 14, $B6C0A9, RefGroupList[i]);
{$IFEND}

            actor := TActor(RefGroupList.Objects[i]);
            if Actor <> nil then begin
{$IF Var_Interface = Var_Mir2}
              TextOut(ax + 141 - Left, ay + 3 + (i - DGroupUpDown.Position) * 14, $B6C0A9, Actor.m_sGuildName)
{$ELSE}
              if g_boUseWuXin then
                TextOut(ax + 132 - 19, ay + 3 + (i - DGroupUpDown.Position) * 14, $B6C0A9, GetWuXinName(Actor.m_btWuXin))
              else
                TextOut(ax + 132 - 19, ay + 3 + (i - DGroupUpDown.Position) * 14, $B6C0A9, '无');

              TextOut(ax + 166 - 19, ay + 3 + (i - DGroupUpDown.Position) * 14, $B6C0A9, Actor.m_sGuildName)
{$IFEND}
;
            end;
          end;
        end;
      end;
      //Release;
    end;
  end;
end;

procedure TFrmDlg.DGrpMemberListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  x := x - DGrpMemberList.Left;
  y := y - DGrpMemberList.Top;
  GroupListIndex := -1;
  if (X >= 6) and (x <= 258) and (y >= 4) and (y <= 17) then begin
    GroupListIndex := 0;
  end
  else if (X >= 6) and (x <= 250) and (y >= 18) and (y <= 65) then begin
    GroupListIndex := (y - 18) div 16 * 2 + (X - 6) div 125 + 1;
  end;
end;

procedure TFrmDlg.DGrpMemberListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  x := x - DGrpMemberList.Left;
  y := y - DGrpMemberList.Top;
  GroupListMoveIndex := -1;
  if (X >= 6) and (x <= 258) and (y >= 4) and (y <= 17) then begin
    GroupListMoveIndex := 0;
  end
  else if (X >= 6) and (x <= 250) and (y >= 18) and (y <= 65) then begin
    GroupListMoveIndex := (y - 18) div 16 * 2 + (X - 6) div 125 + 1;
  end;
end;

procedure TFrmDlg.DGrpMemberListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  UserName: string;
begin
  with (Sender as TDControl) do begin
    if (mbRight = Button) then begin
      if (GroupListIndex >= 0) and (GroupListIndex < g_GroupMembers.Count) then begin
        UserName := pTGroupMember(g_GroupMembers[GroupListIndex]).ClientGroup.UserName;
        FrmDlg2.DPopUpMemuGroup.Visible := False;
        FrmDlg2.DPopUpMemuGroup.Item.Clear;
        FrmDlg2.DPopUpMemuGroup.Item.AddObject('名称: ' + UserName, TObject(-1));
        FrmDlg2.DPopUpMemuGroup.Item.AddObject('-', nil);
        if (g_GroupMembers.Count > 0) and
          (pTGroupMember(g_GroupMembers[0]).ClientGroup.UserName = g_MySelf.m_UserName) then begin
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('踢出队伍', TObject(1));
        end
        else
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('踢出队伍', nil);
        FrmDlg2.DPopUpMemuGroup.Item.AddObject('进行私聊', TObject(2));
        if (not InFriendList(UserName)) and
          (UserName <> g_MySelf.m_UserName) then
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('加为好友', TObject(3))
        else
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('加为好友', nil);

        if InFriendList(UserName) then
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('发送信件', TObject(4))
        else
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('发送信件', nil);

        FrmDlg2.DPopUpMemuGroup.Item.AddObject('邀请加入行会', TObject(5));
        FrmDlg2.DPopUpMemuGroup.Item.AddObject('-', nil);
        FrmDlg2.DPopUpMemuGroup.Item.AddObject('复制人物名称', TObject(6));
        FrmDlg2.DPopUpMemuGroup.RefSize;
        FrmDlg2.DPopUpMemuGroup.Popup(Sender, SurfaceX(X), SurfaceY(Y), UserName);
      end;
    end;
  end;
end;

procedure TFrmDlg.DGrpUserListDblClick(Sender: TObject);
var
  who: string;
begin
  who := '';
  if (UserListIndex < RefGroupList.count) and (UserListIndex >= 0) then begin
    who := RefGroupList[UserListIndex];
  end;
  if who <> '' then begin
    PlayScene.SetEditChar(who);
  end;
end;

procedure TFrmDlg.DGrpUserListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  x := x - DGrpUserList.Left;
  y := y - DGrpUserList.Top;
  UserListIndex := -1;
  if (X > 6) and (x < 250) and (y > 3) and (y < 128) then begin
    UserListIndex := (y - 3) div 14 + DGroupUpDown.Position;
  end;
end;

procedure TFrmDlg.DGrpUserListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  x := x - DGrpUserList.Left;
  y := y - DGrpUserList.Top;
  UserListMoveIndex := -1;
  if (X > 6) and (x < 250) and (y > 3) and (y < 128) then begin
    UserListMoveIndex := (y - 3) div 14 + DGroupUpDown.Position;
  end;
end;

procedure TFrmDlg.DGrpUserListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  UserName: string;
begin
  with Sender as TDControl do begin
    if mbRight = Button then begin
      if (UserListIndex < RefGroupList.count) and (UserListIndex >= 0) then begin
        UserName := RefGroupList[UserListIndex];
        DPopUpSayList.Visible := False;
        DPopUpSayList.Item.Clear;
        DPopUpSayList.Item.AddObject('名称: ' + UserName, TObject(-1));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('进行私聊', TObject(1));
        if (not InFriendList(UserName)) and
          (UserName <> g_MySelf.m_UserName) then
          DPopUpSayList.Item.AddObject('加为好友', TObject(2))
        else
          DPopUpSayList.Item.AddObject('加为好友', nil);

        if (not InBlacklist(UserName)) then
          DPopUpSayList.Item.AddObject('屏蔽发言', TObject(7))
        else
          DPopUpSayList.Item.AddObject('解除屏蔽', TObject(8));

        if InFriendList(UserName) then
          DPopUpSayList.Item.AddObject('发送信件', TObject(3))
        else
          DPopUpSayList.Item.AddObject('发送信件', nil);

        DPopUpSayList.Item.AddObject('邀请组队', TObject(4));
        DPopUpSayList.Item.AddObject('邀请加入行会', TObject(5));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('复制人物名称', TObject(6));
        DPopUpSayList.RefSize;
        DPopUpSayList.Popup(Sender, SurfaceX(X), SurfaceY(Y), UserName);
      end;
    end;
  end
end;

procedure TFrmDlg.DPopUpSayListPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
var
  Idx: integer;
begin
  with DControl do begin
    case Integer(TDPopUpMemu(Sender).Item.Objects[ItemIndex]) of
      1: PlayScene.SetEditChar(UserName);
      2: FrmMain.SendClientMessage(CM_FRIEND_CHENGE, 0, 0, 0, 0, UserName);
      3: FrmDlg2.OpenNewMail(UserName);
      4: CreateGroup(UserName);
      5: frmMain.SendGuildAddMem(UserName);
      6: CopyStrToClipboard(UserName);
      7: begin
          if g_MyBlacklist.IndexOf(UserName) = -1 then begin
            g_MyBlacklist.Add(UserName)
          end;
        end;
      8: begin
          Idx := g_MyBlacklist.IndexOf(UserName);
          if Idx <> -1 then
            g_MyBlacklist.Delete(idx);
        end;
    end;
  end;
end;

procedure TFrmDlg.DItemAddBag1DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if Tag in [Low(g_AddBagItems)..High(g_AddBagItems)] then begin
      if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') and
        (g_MovingItem.Item.s.StdMode = tm_AddBag) then begin
        if (g_AddBagItems[Tag].s.Name = '') then begin
          d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
          if d <> nil then
            DrawBlend(dsurface, ax - 12 - 1, ay - 14 + 1, d, 1);
        end;
      end;
      if g_AddBagItems[Tag].s.name <> '' then begin
        d := GetBagItemImg(g_AddBagItems[Tag].S.looks);
        if d <> nil then
          RefItemPaint(dsurface, d, //人物背包栏
            ax + (Width - d.Width) div 2,
            ay + (Height - d.Height) div 2,
            Width,
            Height,
            @g_AddBagItems[Tag], False);
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemAddBag1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
begin
  with Sender as TDButton do begin
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    if Tag in [Low(g_AddBagItems)..High(g_AddBagItems)] then begin
      if g_AddBagItems[Tag].s.Name <> '' then begin
        DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(g_AddBagItems[Tag], [mis_AddBag], []), clwhite, False, Tag, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemAddBag1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if Button = mbLeft then begin
      if g_MoveAddBagItem.Item.s.Name = '' then begin
        if Tag in [Low(g_AddBagItems)..High(g_AddBagItems)] then begin
          if not g_boItemMoving then begin
            if (g_AddBagItems[Tag].s.Name <> '') and (g_MoveAddBagItem.Item.s.Name = '') then begin
              g_MoveAddBagItem.Index2 := Tag;
              g_MoveAddBagItem.Item := g_AddBagItems[Tag];
              g_MoveAddBagItem.ItemType := mtBagItem;
              g_AddBagItems[Tag].S.name := '';
              ItemClickSound(g_AddBagItems[Tag].S);
              frmMain.SendTakeOffAddBagItem(Tag);
              ArrangeItembag;
            end;
          end
          else begin
            if (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.StdMode = tm_AddBag) and
              (g_MovingItem.Item.s.Name <> '') and (g_MoveAddBagItem.Item.s.Name = '') and
              (g_AddBagItems[Tag].s.Name = '') then begin
              g_MoveAddBagItem := g_MovingItem;
              frmMain.SendTakeOnAddBagItem(Tag, g_MovingItem.Item.UserItem.MakeIndex);
              ClearMovingItem();
              ArrangeItembag;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemBagDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
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
    if Sender = DItemBag then begin
{$IF Var_Interface = Var_Mir2}
      d := g_WMain99Images.Images[1869];
      if d <> nil then
        dsurface.Draw(ax + 11, ay + 230, d.ClientRect, d, False);
{$IFEND}
      with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
        TextOut(ax + 75, ay + 233, GetGoldStr(g_MySelf.m_nGold), clWhite);
        TextOut(ax + 136, ay + 257, GetGoldStr(g_nBindGold), clWhite);
        TextOut(ax + 136, ay + 278, GetGoldStr(g_MySelf.m_nGameGold), $CCFF);
{$ELSE}
        TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
        TextOut(ax + 17, ay + 417, g_sGoldName + ': ' + GetGoldStr(g_MySelf.m_nGold), clWhite);
        TextOut(ax + 17, ay + 438, g_sBindGoldName + ': ' + GetGoldStr(g_nBindGold), clWhite);
        TextOut(ax + 17, ay + 459, g_sGameGoldName + ': ' + GetGoldStr(g_MySelf.m_nGameGold), $CCFF);
        TextOut(ax + 17, ay + 480, g_sGamePointName + ': ' + GetGoldStr(g_MySelf.m_nGamePoint), $CCFF);  
{$IFEND}

      end;
      DItemBagRef.Enabled := GetTickCount > g_BagCheckTick;

    end;
  end;
end;

procedure TFrmDlg.DItemBagMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDWindow do begin
    x := x - left;
    y := y - top;
  end;
  if Sender = DItemBag then begin
    with DItemGrid do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DItemGridDblClick(DItemGrid);
      end;
    end;
  end
  else if Sender = DItemAppendBag1 then begin
    with DItemGrid1 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DItemGridDblClick(DItemGrid1);
      end;
    end;
  end
  else if Sender = DItemAppendBag2 then begin
    with DItemGrid2 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DItemGridDblClick(DItemGrid2);
      end;
    end;
  end
  else if Sender = DItemAppendBag3 then begin
    with DItemGrid3 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DItemGridDblClick(DItemGrid3);
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemBagMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDWindow do begin
    ShowMsg := '';
    x := x - Left;
    y := y - Top;
    if (x >= 42) and (y >= 436) and (x <= 42 + 180) and (y <= 436 + 15) then begin
      y := SurfaceY(Top + 436);
      ShowMsg := g_sBindGoldName + '为服务器特定基本虚似货币,\';
      ShowMsg := ShowMsg + '该货币只能用于购买或者使用在特定场合，无法交易.\';
      ShowMsg := ShowMsg + '使用该货币购买的物品不能再出售给NPC.\';
    end
    else if (x >= 42) and (y >= 457) and (x <= 42 + 180) and (y <= 457 + 15) then begin
      y := SurfaceY(Top + 457);
      ShowMsg := g_sGameGoldName + '为服务器特殊虚似货币,\';
      ShowMsg := ShowMsg + '该货币可以用于商铺购买道具和特定场合使用.\';
      ShowMsg := ShowMsg + '可以在商铺中使用' + g_sGamePointName + '对换' + g_sGameGoldName + ',\';
      ShowMsg := ShowMsg + '也可以通过玩家间的交易或服务器特定场合获得.\';
    end
    else if (x >= 42) and (y >= 478) and (x <= 42 + 180) and (y <= 478 + 15) then begin
      y := SurfaceY(Top + 478);
      ShowMsg := g_sGamePointName + '为服务器特殊虚似货币,\';
      ShowMsg := ShowMsg + '该货币只可以用于商铺购买道具和对换' + g_sGameGoldName + '.\';
      ShowMsg := ShowMsg + '该货币可以在所有服务器中通用.\';

    end;
    X := SurfaceX(Left + 42);
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, True, Integer(Sender));
  end;
end;

procedure TFrmDlg.DItemBagRefClick(Sender: TObject; X, Y: Integer);
begin
  g_BagCheckTick := GetTickCount + 60 * 1000;
  frmMain.SendQueryBagItems;
end;

procedure TFrmDlg.DItemBagRefDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if not Enabled then
        d := WLib.Images[FaceIndex + 1]
      else if Downed then
        d := WLib.Images[FaceIndex]
      else
        d := nil;
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DItemBagShopClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg2.DWndUserShop.Visible := not FrmDlg2.DWndUserShop.Visible;
end;

procedure TFrmDlg.DItemBagVisible(Sender: TObject; boVisible: Boolean);
begin
  if not boVisible then
    boOpenItemBag := False;
end;

procedure TFrmDlg.DItemGridDblClick(Sender: TObject);
var
  idx: Integer;
  where: Integer;

  procedure TakeOnAddBag(boMoving: Boolean);
  var
    Item: pTNewClientItem;
    nIdx: Integer;
    i: integer;
    ItemIndex: Integer;
  begin
    nIdx := -1;
    if boMoving then begin
      Item := @g_MovingItem.Item;
      ItemIndex := g_MovingItem.Index2;
    end
    else begin
      Item := @g_ItemArr[idx];
      ItemIndex := idx;
    end;
    if (g_MoveAddBagItem.Item.s.Name = '') then begin
      for I := Low(g_AddBagItems) to High(g_AddBagItems) do begin
        if g_AddBagItems[i].s.Name = '' then begin
          nIdx := I;
          break;
        end;
      end;
      if nIdx > -1 then begin
        ItemClickSound(Item.s);
        g_MoveAddBagItem.Index2 := ItemIndex;
        g_MoveAddBagItem.Item := Item^;
        g_MoveAddBagItem.ItemType := mtBagItem;
        Item.s.Name := '';
        frmMain.SendTakeOnAddBagItem(nIdx, item.UserItem.MakeIndex);
        g_boItemMoving := FALSE;
      end;
    end;
  end;
begin
  m_dwDblClick := GetTickCount;
  //idx := DItemGrid.Col + DItemGrid.row * DItemGrid.ColCount;
  idx := m_nMouseIdx;
  if idx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
    if (not g_boItemMoving) and (g_ItemArr[idx].S.name <> '') then begin
      {SafeFillChar(keyvalue, sizeof(TKeyBoardState), #0);
      GetKeyboardState(keyvalue);
      if keyvalue[VK_CONTROL] = $80 then begin
        cu := g_ItemArr[idx];
        DelItemBagByIdx(idx);
        AddItemBag(cu);
      end
      else
      if not (CheckByteStatus(Item.s.Bind, Ib_NoSave) or CheckByteStatus(Item.UserItem.btBindMode1, Ib_NoSave))
        then begin
      }
      if FrmDlg4.DWndCompound.Visible{ and FrmDlg4.CanCompoundItemAdd(@g_ItemArr[idx])} then begin
        FrmDlg4.CompoundItemAdd(idx);
        exit;
      end
      else if FrmDlg4.DWndArmAbilityMove.Visible{ and FrmDlg4.CanArmAbilityMoveAdd(@g_ItemArr[idx])} then begin
        FrmDlg4.ArmAbilityMoveAdd(idx);
        exit;
      end
      else if FrmDlg3.DWndArmStrengthen.Visible and FrmDlg3.CanArmStrengthenAdd(@g_ItemArr[idx]) then begin
        FrmDlg3.ArmStrengthenAdd(idx);
        exit;
      end
      else if FrmDlg3.DWndMakeItem.Visible and FrmDlg3.CanMakeItemAdd(@g_ItemArr[idx]) then begin
        FrmDlg3.MakeItemAdd(idx);
        exit;
      end
      else if FrmDlg3.DWndItemUnseal.Visible and FrmDlg3.CanItemUnsealAdd(@g_ItemArr[idx]) then begin
        FrmDlg3.ItemUnsealAdd(idx);
        exit;
      end
      else if FrmDlg4.DWndItemRemove.Visible and FrmDlg4.CanItemRemoveStoneAdd(@g_ItemArr[idx]) then begin
        FrmDlg4.ItemRemoveStoneAdd(idx);
        exit;
      end
      else if FrmDlg2.DStorageDlg.Visible and (not (CheckItemBindMode(@g_ItemArr[idx].UserItem, bm_NoSave))) then begin
        FrmDlg2.AutoStorage(idx);
        exit;
      end
      else if ((tm_MakeStone = g_ItemArr[idx].S.StdMode) and (g_ItemArr[idx].S.Shape = 3)) or
        (tm_ResetStone = g_ItemArr[idx].S.StdMode) then begin
        if (g_SendSelectItem.s.name = '') then begin
          g_Selectitem := g_ItemArr[idx];
          g_CursorMode := cr_SelItem;
          FrmMain.Cursor := crMySelItem;
        end;
        Exit;
      end
      else if (tm_MakeStone = g_ItemArr[idx].S.StdMode) and (g_ItemArr[idx].S.Shape = 9) then begin
        if (g_SendRemoveStoneItem.s.name = '') then begin
          if FrmDlg4.DWndItemRemove.Visible then begin
            g_RemoveStoneItem := g_ItemArr[idx];
            g_CursorMode := cr_Srepair;
            FrmMain.Cursor := crSrepair;
          end
          else
            FrmDlg.DMessageDlg('请先打开卸下装备宝石窗口再使用.', []);
        end;
        Exit;
      end
      else if (tm_AddBag = g_ItemArr[idx].S.StdMode) then begin
        TakeOnAddBag(False);
        Exit;
      end
      else if (sm_Eat in g_ItemArr[idx].S.StdModeEx) then begin
        frmMain.EatItem(idx);
        Exit;
      end
      else if g_WaitingUseItem.Item.s.name = '' then begin
        where := GetTakeOnPosition(g_ItemArr[idx].S.StdMode);
        if where in [0..MAXUSEITEMS - 1] then begin
          if where = U_RINGL then begin
            if m_boRING then
              Inc(where);
            m_boRING := not m_boRING;
          end
          else if where = U_ARMRINGL then begin
            if m_boARMRING then
              Inc(where);
            m_boARMRING := not m_boARMRING;
          end;
          ItemClickSound(g_ItemArr[idx].S);
          g_WaitingUseItem.Item := g_ItemArr[idx];
          g_WaitingUseItem.Index2 := where;
          g_WaitingUseItem.ItemType := mtBagItem;
          FrmMain.SendTakeOnItem(where, g_ItemArr[idx].UserItem.MakeIndex, g_ItemArr[idx].S.Name);
          DelItemBagByIdx(idx);
        end else
        if (where in [16..20]) then begin
          ItemClickSound(g_ItemArr[idx].S);
          g_WaitingUseItem.Item := g_ItemArr[idx];
          g_WaitingUseItem.Index2 := where;
          g_WaitingUseItem.ItemType := mtBagItem;
          FrmMain.SendTakeOnItem(where, g_ItemArr[idx].UserItem.MakeIndex, g_ItemArr[idx].S.Name);
          DelItemBagByIdx(idx);
        end;
      end;
    end
    else begin
      if g_boItemMoving and (g_MovingItem.Item.S.name <> '') and (g_MovingItem.ItemType = mtBagItem) then begin
        if (tm_AddBag = g_MovingItem.Item.S.StdMode) then begin
          TakeOnAddBag(True);
        end
        else if (sm_Eat in g_MovingItem.Item.S.StdModeEx) then begin
          frmMain.EatItem(-1);
        end
        else begin
          if g_WaitingUseItem.Item.s.name = '' then begin
            where := GetTakeOnPosition(g_MovingItem.Item.S.StdMode);
            if where in [0..MAXUSEITEMS - 1] then begin
              if where = U_RINGL then begin
                if m_boRING then
                  Inc(where);
                m_boRING := not m_boRING;
              end
              else if where = U_ARMRINGL then begin
                if m_boARMRING then
                  Inc(where);
                m_boARMRING := not m_boARMRING;
              end;
              ItemClickSound(g_MovingItem.Item.S);
              g_WaitingUseItem.Item := g_MovingItem.Item;
              g_WaitingUseItem.Index2 := where;
              g_WaitingUseItem.ItemType := mtBagItem;
              g_boItemMoving := False;
              FrmMain.SendTakeOnItem(where, g_MovingItem.Item.UserItem.MakeIndex, g_MovingItem.Item.S.Name);
              g_MovingItem.Item.S.Name := '';
            end else
            if (where in [16..20]) then begin
              ItemClickSound(g_MovingItem.Item.S);
              g_WaitingUseItem.Item := g_MovingItem.Item;
              g_WaitingUseItem.Index2 := where;
              g_WaitingUseItem.ItemType := mtBagItem;
              g_boItemMoving := False;
              FrmMain.SendTakeOnItem(where, g_MovingItem.Item.UserItem.MakeIndex, g_MovingItem.Item.S.Name);
              g_MovingItem.Item.S.Name := '';
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  MoveItemState: TMoveItemState;
begin
  m_nMouseIdx := -1;
  with Sender as TDGrid do begin
    if ssRight in Shift then begin
      if g_boItemMoving then
        DItemGridGridSelect(Sender, X, Y, ACol, ARow, Shift);
    end
    else begin
      idx := ACol + ARow * ColCount + g_AddBagInfo[Tag].nStateCount;
      if idx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
        m_nMouseIdx := idx;
        if g_ItemArr[idx].s.Name <> '' then begin
          MoveItemState := [mis_Bag];
          case g_CursorMode of
            cr_Sell: MoveItemState := MoveItemState + [mis_Sell];
            cr_Repair: begin
                if boSuperRepair then
                  MoveItemState := MoveItemState + [mis_SuperRepair]
                else
                  MoveItemState := MoveItemState + [mis_Repair];
              end;
          end;
          if FrmDlg2.DStorageDlg.Visible then
            MoveItemState := MoveItemState + [mis_Storage];
          if FrmDlg4.DWndCompound.Visible then
            MoveItemState := MoveItemState + [mis_CompoundItemAdd];
          if FrmDlg4.DWndArmAbilityMove.Visible then
            MoveItemState := MoveItemState + [mis_ArmAbilityMoveAdd];
          if FrmDlg3.DWndArmStrengthen.Visible then
            MoveItemState := MoveItemState + [mis_ArmStrengthenAdd];
          if FrmDlg3.DWndMakeItem.Visible then
            MoveItemState := MoveItemState + [mis_MakeItemAdd];
          if FrmDlg3.DWndItemUnseal.Visible then
            MoveItemState := MoveItemState + [mis_ItemUnsealAdd];
          if FrmDlg4.DWndItemRemove.Visible then
            MoveItemState := MoveItemState + [mis_ItemRemoveStoneAdd];

          DScreen.ShowHint(SurfaceX(Left + (x - left)), SurfaceY(Top + (y - Top) + 30),
            ShowItemInfo(g_ItemArr[idx], MoveItemState, []), clwhite, False, idx, True);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
var
  idx, nInt: Integer;
  d: TDXTexture;
  boShowCount: Boolean;
  showstr: string;
  pRect: TRect;
  SysTick: LongWord;
begin
  with Sender as TDgrid do begin
    idx := ACol + ARow * ColCount + g_AddBagInfo[Tag].nStateCount;
    if idx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
      if g_ItemArr[idx].S.name <> '' then begin
        d := GetBagItemImg(g_ItemArr[idx].S.looks);
        if d <> nil then begin
          boShowCount := True;
          if (g_CursorMode = cr_Repair) then begin
            boShowCount := False;
          end;
          pRect.Left := SurfaceX(Rect.Left);
          pRect.Top := SurfaceY(Rect.Top);
          pRect.Right := SurfaceX(Rect.Right + 1);
          pRect.Bottom := SurfaceY(Rect.Bottom);
          RefItemPaint(dsurface, d, //人物背包栏
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @g_ItemArr[idx], boShowCount, [pmShowLevel], @pRect);
          if (not boShowCount) and ((sm_Arming in g_ItemArr[idx].s.StdModeEx) or (sm_HorseArm in g_ItemArr[idx].s.StdModeEx)) and
            (not (CheckItemBindMode(@g_ItemArr[idx].UserItem, bm_NoRepair))) and
            (g_ItemArr[idx].UserItem.Dura < g_ItemArr[idx].UserItem.DuraMax) then begin
            nInt := Round(g_ItemArr[idx].UserItem.Dura / g_ItemArr[idx].UserItem.DuraMax * 100);
            with g_DXCanvas do begin
              //SetBkMode(Handle, TRANSPARENT);
              showstr := IntToStr(nInt) + '%';
              if nInt <= 30 then
                TextOut(SurfaceX(Rect.Right) - TextWidth(showstr), SurfaceY(Rect.Bottom) - 12, clRed, showstr)
              else
                TextOut(SurfaceX(Rect.Right) - TextWidth(showstr), SurfaceY(Rect.Bottom) - 12, clwhite, showstr);
              //Release;
            end;
          end;
          SysTick := GetTickCount;
          if (SysTick < FShowItemEffectTick) and (g_ItemArr[idx].UserItem.MakeIndex = FShowItemEffectIndex) then begin
            d := g_WMain99Images.Images[1990 + (FShowItemEffectTick - SysTick) div 150];
            if d <> nil then begin
              DrawBlend(dsurface, SurfaceX(Rect.Left) - 23, SurfaceY(Rect.Top) - 23, d, 1);
            end;
          end;

          {if (not boDraw) and (g_UseItems[Tag].s.StdModeEx = sm_Arming) then begin
            if CheckWuXinConsistent(g_MySelf.m_btWuXin, g_UseItems[Tag].UserItem.Value.btValue[tb_wuxin]) or
              CheckWuXinRestraint(g_MySelf.m_btWuXin, g_UseItems[Tag].UserItem.Value.btValue[tb_wuxin]) then begin
              d := g_WMain2Images.Images[260 + (GetTickCount - AppendTick) div 150 mod 6];
              if d <> nil then begin
                DrawBlend(dsurface, SurfaceX(Left) - 21, SurfaceY(Top) - 23, d, 1);
              end;
            end;
          end; }
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  temp: TNewClientItem;
  nCount: Integer;
begin
  with Sender as TDGrid do begin
    if (GetTickCount - m_dwDblClick) < 500 then
      Exit;
    idx := ACol + ARow * ColCount + g_AddBagInfo[Tag].nStateCount;
    if idx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
      if (DMenuDlg.Visible) and ((g_CursorMode = cr_Sell) or (g_CursorMode = cr_Repair)) then begin
        if g_SellDlgItemSellWait.Item.s.name <> '' then
          exit;

        if g_CursorMode = cr_Sell then begin
          if CheckItemBindMode(@g_ItemArr[idx].UserItem, bm_NoSell) then
            exit;
          ItemClickSound(g_ItemArr[idx].S);
          g_SellDlgItemSellWait.Index2 := idx;
          g_SellDlgItemSellWait.Item := g_ItemArr[idx];
          g_SellDlgItemSellWait.ItemType := mtBagItem;
          frmMain.SendSellItem(g_nCurMerchant, g_SellDlgItemSellWait.Item.UserItem.MakeIndex);
          DelItemBagByIdx(idx);
        end
        else if g_CursorMode = cr_Repair then begin
          if ((sm_Arming in g_ItemArr[idx].s.StdModeEx) or (sm_HorseArm in g_ItemArr[idx].s.StdModeEx)) and
            (not (CheckItemBindMode(@g_ItemArr[idx].UserItem, bm_NoRepair))) and
            (g_ItemArr[idx].UserItem.Dura < g_ItemArr[idx].UserItem.DuraMax) then begin
            ItemClickSound(g_ItemArr[idx].S);
            g_SellDlgItemSellWait.Index2 := idx;
            g_SellDlgItemSellWait.Item := g_ItemArr[idx];
            g_SellDlgItemSellWait.ItemType := mtBagItem;
            DelItemBagByIdx(idx);
            frmMain.SendRepairItem(g_nCurMerchant, g_SellDlgItemSellWait.Item.UserItem.MakeIndex,
              MakeWord(Integer(boSuperRepair), 255));
          end;
        end;
        exit;
      end;
      if not g_boItemMoving then begin
        if g_ItemArr[idx].S.name <> '' then begin
          if g_CursorMode = cr_SelItem then begin
            g_CursorMode := cr_None;
            FrmMain.Cursor := crMyNone;
            if (g_Selectitem.s.name <> '') and (g_SendSelectItem.s.name = '') then begin
              if (tm_MakeStone = g_Selectitem.S.StdMode) and (g_Selectitem.S.Shape = 3) then begin
                if sm_ArmingStrong in g_ItemArr[idx].S.StdModeEx then begin
                  if (g_ItemArr[idx].UserItem.Value.btFluteCount > 0) and (GetFluteCount(@g_ItemArr[idx].UserItem) > 0) then begin
                    if g_ItemArr[idx].UserItem.Value.StrengthenInfo.btStrengthenCount >= g_Selectitem.s.Need then begin
                      g_SendSelectItem := g_Selectitem;
                      FrmMain.SendClientSocket(CM_BAGUSEITEM, g_ItemArr[idx].UserItem.MakeIndex,
                        LoWord(g_Selectitem.UserItem.MakeIndex), HiWord(g_Selectitem.UserItem.MakeIndex), 0, '');
                    end
                    else
                      DMessageDlg('宝石属性与装备等级不符合！', [mbOK]);
                  end
                  else
                    DMessageDlg('该装备没有多余可镶嵌宝石的位置！', [mbOK]);
                end;
              end
              else if (tm_ResetStone = g_Selectitem.S.StdMode) then begin
                if sm_ArmingStrong in g_ItemArr[idx].S.StdModeEx then begin
                  if not CheckItemBindMode(@g_ItemArr[idx].UserItem, bm_Unknown) then begin
                    g_SendSelectItem := g_Selectitem;
                    FrmMain.SendClientSocket(CM_BAGUSEITEM, g_ItemArr[idx].UserItem.MakeIndex,
                      LoWord(g_Selectitem.UserItem.MakeIndex), HiWord(g_Selectitem.UserItem.MakeIndex), 0, '');
                  end
                  else
                    DMessageDlg('未开光装备无法使用该功能！', [mbOK]);
                end;
              end;
            end;
          end
          else if (ssShift in Shift) then begin
            //拆分叠加物品
            if (g_UniteUseItem.Item.s.Name = '') and
              (sm_Superposition in g_ItemArr[idx].s.StdModeEx) and
              (g_ItemArr[idx].UserItem.Dura > 0) and (g_ItemArr[idx].UserItem.DuraMax > 1) then begin
              if mrYes = DMessageDlg('输入要拆分的数量', [mbYes, mbNo, mbAbort], 10, deInteger) then begin
                nCount := StrToIntDef(DlgEditText, -1);
                if (nCount > 0) and (nCount <= (g_ItemArr[idx].UserItem.Dura - 1)) then begin
                  g_UniteUseItem.Index2 := idx;
                  g_UniteUseItem.Item := g_ItemArr[idx];
                  g_UniteUseItem.ItemType := mtBagItem;
                  FrmMain.SendClientMessage(CM_CHANGEITEMDURA, g_ItemArr[idx].UserItem.MakeIndex, nCount, 0, 0, '');
                end;
              end;
            end;

          end
          else if ssCtrl in Shift then begin
            if not DEditChat.Visible then begin
              DBTEditClick(DBTEdit, 0, 0);
            end;
            DEditChat.AddItemToList(g_ItemArr[idx].S.name, IntToStr(g_ItemArr[idx].UserItem.MakeIndex));
            //DEditChat.AddImageToList(IntToStr(FaceSelectindex));
            //DWndFace.Visible := False;
          end
          else begin
            g_boItemMoving := True;
            g_MovingItem.Index2 := idx;
            g_MovingItem.Item := g_ItemArr[idx];
            g_MovingItem.ItemType := mtBagItem;
            DelItemBagByIdx(idx);
            ItemClickSound(g_ItemArr[idx].S);
          end;
        end;
      end
      else begin
        if g_CursorMode = cr_SelItem then begin
          g_CursorMode := cr_None;
          FrmMain.Cursor := crMyNone;
        end;
        if g_MovingItem.ItemType <> mtBagGold then begin
          if g_MovingItem.ItemType = mtStateItem then begin
            if (g_WaitingUseItem.Item.S.name <> '') or (g_MovingItem.Item.s.Name = '') then
              Exit;
            g_WaitingUseItem.Index2 := g_MovingItem.Index2;
            g_WaitingUseItem.Item := g_MovingItem.Item;
            g_WaitingUseItem.ItemType := mtBagItem;
            ItemClickSound(g_WaitingUseItem.Item.S);
            frmMain.SendTakeOffItem(-(g_MovingItem.Index2 + 1), g_WaitingUseItem.Item.UserItem.MakeIndex, g_WaitingUseItem.Item.S.name);
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := False;
          end
          else if g_MovingItem.ItemType = mtDealGold then
            DGoldClick(Self, 0, 0)
          else if g_MovingItem.ItemType = mtBagItem then begin
            //合并叠加物品
            if (g_ItemArr[idx].S.name <> '') and
              (g_ItemArr[idx].UserItem.MakeIndex <> g_MovingItem.Item.UserItem.MakeIndex) and
              (sm_Superposition in g_MovingItem.Item.s.StdModeEx) and
              (g_MovingItem.Item.s.StdMode = g_ItemArr[idx].S.StdMode) and
              (g_ItemArr[idx].UserItem.Dura < g_ItemArr[idx].UserItem.DuraMax) then begin
              if (g_ItemArr[idx].UserItem.btBindMode1 = g_MovingItem.Item.UserItem.btbindmode1) and
                (g_ItemArr[idx].UserItem.btBindMode2 = g_MovingItem.Item.UserItem.btbindmode2) then begin
                if (g_UniteUseItem.Item.s.Name = '') then begin
                  FrmMain.SendClientMessage(CM_CHANGEITEMDURA, g_ItemArr[idx].UserItem.MakeIndex,
                    LoWord(g_MovingItem.Item.UserItem.MakeIndex), HiWord(g_MovingItem.Item.UserItem.MakeIndex), 1, '');
                  g_UniteUseItem := g_MovingItem;
                  ClearMovingItem();
                end;
              end
              else begin
                AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
                ClearMovingItem();
                DMessageDlg('无法叠加该物品\准备叠加的物品属性不一样.', []);
                exit;
              end;
            end
            else begin
              if g_ItemArr[idx].S.name <> '' then begin
                temp := g_ItemArr[idx];
                DelItemBagByIdx(idx);
                AddItemBag(g_MovingItem.Item, idx);
                g_MovingItem.Index2 := idx;
                g_MovingItem.Item := temp
              end
              else begin
                AddItemBag(g_MovingItem.Item, idx);
                ClearMovingItem();
              end;
            end;
          end;
        end
        else begin
          ClearMovingItem();
        end;
      end;
    end;
    ArrangeItembag;
  end;
end;

procedure TFrmDlg.DLoginChgPwClick(Sender: TObject; X, Y: Integer);
begin
  if g_boSQLReg then begin
    if g_WebInfo.g_ChangePassUrl <> '' then begin
      SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
      ShellExecute(Handle, 'Open', @g_WebInfo.g_ChangePassUrl[1], '', '', SW_SHOW);
    end;
  end
  else
    LoginScene.ChgPwClick;
end;

procedure TFrmDlg.DLoginCloseClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.CSocket.Active := False;
  DScreen.ChangeScene(stSelServer);
end;

procedure TFrmDlg.DLogInDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
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
{$IF Var_Interface =  Var_Default}
    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      TextOut(ax + 24, ay + 48, clYellow, '当前登录游戏区：');
      TextOut(ax + 124, ay + 48, clWhite, g_sServerName);
      //Release;
    end;
{$IFEND}
  end;
end;

procedure TFrmDlg.DLoginHomeClick(Sender: TObject; X, Y: Integer);
begin
  SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  ShellExecute(Handle, 'Open', 'http://www.mir2k.com/', '', '', SW_SHOW);
end;

procedure TFrmDlg.DLoginHomeDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  FColor: TColor;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if not Enabled then begin
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
        //SetBkMode(Handle, TRANSPARENT);
        TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2,
          SurfaceY(Top) + (Height - TextHeight(Caption)) div 2, FColor, Caption);
        //Release;
      end;
    end;
  end;
end;

procedure TFrmDlg.DLoginNewClick(Sender: TObject; X, Y: Integer);
begin
  if g_boSQLReg then begin
    if g_WebInfo.g_RegUrl <> '' then begin
      SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
      ShellExecute(Handle, 'Open', @g_WebInfo.g_RegUrl[1], '', '', SW_SHOW);
    end;
  end
  else begin
    LoginScene.NewClick;
  end;
end;

procedure TFrmDlg.DMagicFrontClick(Sender: TObject; X, Y: Integer);
begin
  if (Sender = DMagicFront) then begin
    if MagicPage > 0 then
      Dec(MagicPage);
  end
  else if (Sender = DMagicNext) then begin
    if MagicPage < MagicMaxPage then
      Inc(MagicPage);
  end;
end;

procedure TFrmDlg.DMagicFrontDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
begin
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
end;

procedure TFrmDlg.DMakeMagicAdd1Click(Sender: TObject; X, Y: Integer);
begin
  if g_boSendMakeMagicAdd then
    Exit;
  with Sender as TDButton do begin
    if g_MakeMagic[Tag] < g_btMakeMagicMaxLevel then begin
      g_boSendMakeMagicAdd := True;
      FrmMain.SendClientMessage(CM_MAKEMAGIC, Tag, 0, 0, 0);
    end;
  end;
end;

procedure TFrmDlg.DMaxMap792DirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  mx, my, i: integer;
  rc, dc: TRect;
  actor: TActor;
  cX, cY: integer;
  btColor: Byte;
  boMove: Boolean;
  ax, ay: integer;
  MapDesc: pTMapDesc;
  nWidth, nHeight: Integer;
begin
  with Sender as TDWindow do begin
    if g_MySelf = nil then
      exit;
    if GetTickCount > m_dwBlinkTime + 300 then begin
      m_dwBlinkTime := GetTickCount;
      m_boViewBlink := not m_boViewBlink;
    end;
    if g_nMiniMapIndex > 10000 then
      d := g_WUIBImages.Images[g_nMiniMapIndex - 10000]
    else if g_nMiniMapIndex >= 1000 then
      d := g_WMyMMapImages.Images[g_nMiniMapIndex - 1000]
    else
      d := g_WMMapImages.Images[g_nMiniMapIndex];
    //d := g_WMMapImages.Images[g_nMiniMapIndex];
    if d = nil then begin
      DMaxMiniMap.Visible := False;
      exit;
    end;
    cx := -1;
    cy := 0;

    ax := SurfaceX(Left);
    ay := SurfaceY(Top);

    nWidth := _MIN(d.ClientRect.Right, Width);
    nHeight := _MIN(d.ClientRect.Bottom, Height);

    dc.Left := ax + (Width - nWidth) div 2;
    dc.Top := ay + (Height - nHeight) div 2;
    dc.Right := dc.Left + nWidth;
    dc.Bottom := dc.Top + nHeight;
    rc.Left := 0;
    rc.Top := 0;
    rc.Right := d.ClientRect.Right;
    rc.Bottom := d.ClientRect.Bottom;
    DSurface.StretchDraw(dc, rc, d, True);

    if (g_nMiniMapMaxX >= dc.Left) and (g_nMiniMapMaxX <= dc.Right) and
      (g_nMiniMapMaxY >= dc.Top) and (g_nMiniMapMaxY <= dc.Bottom) then begin
      cX := (g_nMiniMapMaxX - dc.Left) * 32 * rc.Right div nWidth div 48;
      cy := (g_nMiniMapMaxY - dc.Top) * rc.Bottom div nHeight;
    end;

    if cx > -1 then begin
      g_nMiniMapMaxMosX := cX;
      g_nMiniMapMaxMosY := cY;
    end
    else begin
      g_nMiniMapMaxMosX := g_MySelf.m_nCurrX;
      g_nMiniMapMaxMosY := g_MySelf.m_nCurrY;
    end;
    with g_DXCanvas do begin
      if (g_MapDesc <> nil) and g_SetupInfo.boShowMapHint then begin
        //SetBkMode(Handle, TRANSPARENT);
        for i := 0 to g_MapDesc.MaxList.Count - 1 do begin
          MapDesc := g_MapDesc.MaxList[i];
          if MapDesc.nColor > 0 then begin
            mx := dc.Left + Trunc((MapDesc.nX * 48) * (nWidth / rc.Right)) div 32;
            my := dc.Top + Trunc(MapDesc.nY * (nHeight / rc.Bottom));
            TextOut(mx - TextWidth(MapDesc.sName) div 2, my, MapDesc.nColor, MapDesc.sName);
          end;
        end;
        //Release;
      end;
      if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
        //SetBkMode(Handle, TRANSPARENT);
        //Pen.Color := clRed;
        boMove := False;
        mx := -1;
        my := -1;
        for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do begin
          mx := dc.Left + Trunc((g_nMiniMapPath[i].X * 48) * (nWidth / rc.Right)) div 32;
          my := dc.Top + Trunc(g_nMiniMapPath[i].Y * (nHeight / rc.Bottom));
          if boMove then
            LineTo(mx, my, clRed)
          else
            MoveTo(mx, my);
          boMove := True;
        end;
        //Release;
        d := g_WMain99Images.Images[71];
        if d <> nil then
          DSurface.Draw(mx - 2, my + 2 - d.Height, d.ClientRect, d, True);
      end;
    end;
    TempList.Clear;
    for I := 0 to PlayScene.m_ActorList.Count - 1 do begin
      actor := TActor(PlayScene.m_ActorList.Items[I]);
      if (actor <> nil) and
        (actor <> g_MySelf) and
        (not actor.m_boDeath) and
        (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 20) and
        (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 20) then begin
        mx := dc.Left + Trunc((actor.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
        my := dc.Top + Trunc(actor.m_nCurrY * (nHeight / rc.Bottom));
        if (actor.m_Group <> nil) or (actor.m_btRace = 50) then begin
          TempList.Add(actor);
          Continue;
        end;
        if ((Actor.m_btRace <> RCC_USERHUMAN) and
          (Actor.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD])) then begin
          btColor := 65 {129};
        end
        else begin
          case actor.m_btRace of //
            0: btColor := 66;
          else
            btColor := 67;
          end;
        end;
        d := g_WMain99Images.Images[btColor];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
            d.ClientRect, d, True);
      end;
    end;

    if TempList.Count > 0 then
      for I := 0 to TempList.Count - 1 do begin
        actor := TActor(TempList.Items[I]);
        mx := dc.Left + Trunc((actor.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
        my := dc.Top + Trunc(actor.m_nCurrY * (nHeight / rc.Bottom));
        case actor.m_btRace of //
          50: btColor := 68;
        else
          btColor := 69;
        end;
        d := g_WMain99Images.Images[btColor];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
            d.ClientRect, d, True);
      end;

    if not m_boViewBlink then begin
      mx := dc.Left + Trunc((g_MySelf.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
      my := dc.Top + Trunc(g_MySelf.m_nCurrY * (nHeight / rc.Bottom));
      d := g_WMain99Images.Images[70];
      if d <> nil then
        dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
          d.ClientRect, d, True);
    end;
    if cx > -1 then begin
      mx := dc.Left + Trunc((cX * 48) * (nWidth / rc.Right)) div 32;
      my := dc.Top + Trunc(cY * (nHeight / rc.Bottom)) + 2;
      d := g_WMain99Images.Images[71];
      if d <> nil then
        DSurface.Draw(mx, my - d.Height, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DMaxMap792MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then begin
    g_boAutoMoveing := False;
    FrmMain.SendSay(g_Cmd_UserMove + ' ' + IntToStr(g_nMiniMapMaxMosX) + ' ' + IntToStr(g_nMiniMapMaxMosY) + ' TOPHINT');
  end else begin
    g_nMiniMapPath := FindPath(g_nMiniMapMaxMosX, g_nMiniMapMaxMosY);
    if High(g_nMiniMapPath) > 2 then begin
      g_boAutoMoveing := False;
      g_nMiniMapMoseX := g_nMiniMapMaxMosX;
      g_nMiniMapMoseY := g_nMiniMapMaxMosY;
      DScreen.AddSysMsg(Format('[单击屏幕停止移动]',
        [g_nMiniMapMaxMosX, g_nMiniMapMaxMosY]), clWhite);
      {DScreen.AddChatBoardString(Format('自动移动(%d,%d)，点击屏幕停止移动！',
        [g_nMiniMapMaxMosX, g_nMiniMapMaxMosY]), GetRGB(180), clWhite);    }
      g_boAutoMoveing := True;
      g_boNpcMoveing := False;
    end
    else begin
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      DScreen.AddSysMsg('[无法到达目的地]', clWhite);
      //DScreen.AddChatBoardString('自动移动失败，无法到达终点！', GetRGB(56), clWhite);
    end;
  end;
end;

procedure TFrmDlg.DMaxMap792MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowStr: string;
begin
  g_nMiniMapMaxX := DMaxMap792.SurfaceX(x);
  g_nMiniMapMaxY := DMaxMap792.SurfaceY(Y);
  ShowStr := '左键单击自动寻路\';
  ShowStr := ShowStr + '右键单击自动传送\(<自动传送需要配戴传送装备/FCOLOR=$FFFF>)';
  DScreen.ShowHint(DMaxMap792.SurfaceX(DMaxMap792.Left + x), DMaxMap792.SurfaceY(DMaxMap792.Top) + Y, ShowStr, clWhite, False, x);
end;

procedure TFrmDlg.DMaxMinimapCloseClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if DParent <> nil then
      DParent.Visible := False;
  end;
end;

procedure TFrmDlg.DMaxMiniMapDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, False);

    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      //Font.Color := clWhite;
      TextOut(ax + 162 - TextWidth(g_sMapTitle) div 2, ay + 14, g_sMapTitle, clWhite);
      if (g_nMiniMapMaxMosX <> g_MySelf.m_nCurrX) or (g_nMiniMapMaxMosY <> g_MySelf.m_nCurrY) then begin
        TextOut(ax + 315, ay + 14, IntToStr(g_MySelf.m_nCurrX) + ',' +
          IntToStr(g_MySelf.m_nCurrY) + '  ->  ' + IntToStr(g_nMiniMapMaxMosX)
          + ',' + IntToStr(g_nMiniMapMaxMosY), clWhite);
      end
      else begin
        TextOut(ax + 315, ay + 14, IntToStr(g_MySelf.m_nCurrX) + ',' +
          IntToStr(g_MySelf.m_nCurrY) + '  ->  0,0', clWhite);
      end;
      if g_nMiniMapMoseX <> -1 then begin
        TextOut(ax + 520, ay + 14, IntToStr(g_nMiniMapMoseX)
          + ',' + IntToStr(g_nMiniMapMoseY) + '  正在移动，剩余 ' +
          IntToStr(High(g_nMiniMapPath)) + ' 步', clWhite);
      end
      else begin
        TextOut(ax + 520, ay + 14, '0,0  尚未设置目的地，点击地图设置', clWhite);
      end;
      //Release;
    end;
  end;
end;

procedure TFrmDlg.DMDlgUpDonwEndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  if not g_boShowRollBarHint then
    exit;
  if TDUpDown(Sender).MoveShow and Assigned(TDUpDown(Sender).MoveButton) then
  begin
    with TDUpDown(Sender).MoveButton as TDButton do begin
      d := g_WMain99Images.Images[182];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left + Width div 2), SurfaceY(Top + Height div 2), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DMDlgUpDonwPositionChange(Sender: TObject);
begin
  g_boShowRollBarHint := False;
end;

procedure TFrmDlg.DMerchantDlgClick(Sender: TObject; X, Y: Integer);
var
  L, T: Integer;
begin
  if GetTickCount < LastestClickTime then
    Exit;
{$IF Var_Interface = Var_Mir2}
  L := DMerchantDlg.Left + 20;
  T := DMerchantDlg.Top + 18;
  if ((X - DMerchantDlg.Left - 20) < g_MERCHANTMAXWIDTH) and ((Y - DMerchantDlg.Top - 18) < g_MERCHANTMAXHEIGHT) then begin
{$ELSE}
  L := DMerchantDlg.Left + 20;
  T := DMerchantDlg.Top + 20;
  if ((X - DMerchantDlg.Left - 20) < g_MERCHANTMAXWIDTH) and ((Y - DMerchantDlg.Top - 20) < g_MERCHANTMAXHEIGHT) then begin
{$IFEND}
    Y := Y + DMDlgUpDonw.Position;
    with DMerchantDlg do begin
      if (MDlgSelect.rstr <> '') and
        (X >= SurfaceX(L + MDlgSelect.Rc.Left)) and (X <= SurfaceX(L + MDlgSelect.Rc.Right)) and
        (Y >= SurfaceY(T + MDlgSelect.Rc.Top)) and (Y <= SurfaceY(T + MDlgSelect.Rc.Bottom)) then begin
        PlaySound(s_glass_button_click);
        LastestClickTime := GetTickCount + 5000;
        //DScreen.AddSysMsg(MDlgSelect.rstr, clWhite);
        frmMain.SendMerchantDlgSelect(g_nCurMerchant, MDlgSelect.rstr);
        MDlgSelect.rstr := '';
        exit;
      end;
    end;
  end;
  MDlgSelect.rstr := '';
end;

procedure TFrmDlg.DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  CloseMDlg;
end;

procedure TFrmDlg.DMerchantDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, I, Index, px, py: integer;
  rc, dc: TRect;
  pShowHint: pTNewShowHint;
  dwTime: LongWord;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      DrawWindow(dsurface, ax, ay, d);
      rc.Left := 0;
      rc.Top := DMDlgUpDonw.Position;
      rc.Right := g_MERCHANTMAXWIDTH;
      rc.Bottom := DMDlgUpDonw.Position + g_MerchantMaxHeight;
{$IF Var_Interface = Var_Mir2}
      Inc(ax, 20);
      Inc(ay, 18);
{$ELSE}
      Inc(ax, 20);
      Inc(ay, 20);
{$IFEND}


      dwTime := GetTickCount;
      for i := 0 to MDlgDraws.Count - 1 do begin
        pShowHint := MDlgDraws[i];
        if (pShowHint.Surfaces <> nil) and (pShowHint.IndexList <> nil) and (pShowHint.IndexList.Count > 0) then begin
          Index := dwTime div pShowHint.dwTime mod LongWord(pShowHint.IndexList.Count);
          d := pShowHint.Surfaces.GetCachedImage(StrToIntDef(pShowHint.IndexList[Index], -1), px, py);
          if d <> nil then begin
            if pShowHint.boMove then begin
              px := pShowHint.nX + px;
              py := pShowHint.ny + py - DMDlgUpDonw.Position;
            end
            else begin
              px := pShowHint.nX;
              py := pShowHint.ny - DMDlgUpDonw.Position;
            end;
            if pShowHint.boRect then
              dc := pShowHint.Rect
            else
              dc := d.ClientRect;
            if px >= rc.Right then
              Continue;
            if py >= g_MerchantMaxHeight then
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
            if (dc.Bottom - dc.Top + py) > g_MerchantMaxHeight then
              dc.Bottom := g_MerchantMaxHeight - py - dc.Top;
            if (dc.Right - dc.Left) <= 0 then
              Continue;
            if (dc.Bottom - dc.Top) <= 0 then
              Continue;
            if pShowHint.boBlend then
              DrawBlendR(DSurface, ax + px, ay + py, dc, d, Integer(pShowHint.boTransparent))
            else
              DSurface.Draw(ax + px, ay + py, dc, d, pShowHint.boTransparent);
          end;
        end;

      end;
      DSurface.Draw(ax, ay, rc, Surface, TRUE);
{$IF Var_Interface =  Var_Default}
      g_DXCanvas.Font.kerning := -1;
      try
{$IFEND}
        if (MDlgSelect.rstr <> '') and (DMerchantDlg.Downed) and (not MDlgSelect.boItem) then begin
          dc := MDlgSelect.rc;
          dc.Left := ax + dc.Left;
          dc.Right := ax + dc.Right;
          dc.Top := dc.Top - DMDlgUpDonw.Position;
          dc.Bottom := dc.Bottom - DMDlgUpDonw.Position;
          if (dc.Bottom > 0) and (dc.Top < rc.Bottom) then begin
            dc.Top := dc.Top + ay;
            dc.Bottom := dc.Bottom + ay;
            if MDlgMove.boNewPoint then begin
              dc.Top := dc.Top - 2;
              dc.Bottom := dc.Bottom + 3;
              g_DXCanvas.FillRect(dc.Left + MDLGCLICKOX, dc.Top, dc.Right - dc.Left - 20,
                dc.Bottom - dc.Top, $B4635C63);
              g_DXCanvas.TextOut(dc.Left + NEWPOINTOX + 1, dc.Top + 2 + NEWPOINTOY, MDlgMove.sstr, MDlgMove.Color);
              d := g_WMain99Images.Images[MDLGCHICKIMAGE];
              if d <> nil then begin
                g_DXCanvas.Draw(dc.Left, dc.Top + 2, d.ClientRect, d, True);
              end;
            end
            else begin
              g_DXCanvas.MoveTo(dc.Left - 1, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1);
              g_DXCanvas.LineTo(dc.Right - 3, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1, clBlack);
              g_DXCanvas.TextOut(dc.Left + 1, dc.Top + 1, MDlgSelect.sstr, clLime);
              g_DXCanvas.MoveTo(dc.Left + 1, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 2);
              g_DXCanvas.LineTo(dc.Right, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 2, clLime);
            end;
          end;
        end
        else if (MDlgMove.rstr <> '') and (not DMerchantDlg.Downed) and (not MDlgMove.boItem) then begin
          dc := MDlgMove.rc;
          dc.Left := ax + dc.Left;
          dc.Right := ax + dc.Right;
          dc.Top := dc.Top - DMDlgUpDonw.Position;
          dc.Bottom := dc.Bottom - DMDlgUpDonw.Position;
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
            end
            else begin
              g_DXCanvas.TextOut(dc.Left, dc.Top, MDlgMove.sstr, clAqua);
              g_DXCanvas.MoveTo(dc.Left, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1);
              g_DXCanvas.LineTo(dc.Right - 1, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1, clAqua);

            end;
          end;
        end;
{$IF Var_Interface =  Var_Default}
      finally
        g_DXCanvas.Font.kerning := -2;
      end;
{$IFEND}
    end;
  end;
end;

procedure TFrmDlg.DMerchantDlgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, L, T: Integer;
  p: pTClickPoint;
begin
  MDlgRefTime := 0;
  if GetTickCount < LastestClickTime then
    Exit;
  MDlgSelect.rstr := '';
{$IF Var_Interface = Var_Mir2}
  L := DMerchantDlg.Left + 20;
  T := DMerchantDlg.Top + 18;
  if ((X - DMerchantDlg.Left - 20) < g_MERCHANTMAXWIDTH) and ((Y - DMerchantDlg.Top - 18) < g_MERCHANTMAXHEIGHT) then begin
{$ELSE}
  L := DMerchantDlg.Left + 20;
  T := DMerchantDlg.Top + 20;
  if ((X - DMerchantDlg.Left - 20) < g_MERCHANTMAXWIDTH) and ((Y - DMerchantDlg.Top - 20) < g_MERCHANTMAXHEIGHT) then begin
{$IFEND}

    Y := Y + DMDlgUpDonw.Position;
    with DMerchantDlg do begin
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
end;

procedure TFrmDlg.DMerchantDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  i, L, T, nY: Integer;
  p: pTClickPoint;
begin
  MDlgMove.rstr := '';
  if DMerchantDlg.Downed then
    exit;
  MDlgSelect.rstr := '';
{$IF Var_Interface = Var_Mir2}
  L := DMerchantDlg.Left + 20;
  T := DMerchantDlg.Top + 18;
  if ((X - DMerchantDlg.Left - 20) < g_MERCHANTMAXWIDTH) and ((Y - DMerchantDlg.Top - 18) < g_MERCHANTMAXHEIGHT) then begin
{$ELSE}
  L := DMerchantDlg.Left + 20;
  T := DMerchantDlg.Top + 20;
  if ((X - DMerchantDlg.Left - 20) < g_MERCHANTMAXWIDTH) and ((Y - DMerchantDlg.Top - 20) < g_MERCHANTMAXHEIGHT) then begin  
{$IFEND}

    nY := y;
    Y := Y + DMDlgUpDonw.Position;
    with DMerchantDlg do begin
      for i := 0 to MDlgPoints.count - 1 do begin
        p := pTClickPoint(MDlgPoints[i]);
        if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
          (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
          if p.boItem then begin
            if SurfaceY(nY) > 320 then
              DScreen.ShowHint(SurfaceX(X), SurfaceY(nY),
                ShowItemInfo(p.Item, [], []), clwhite, True, p.Item.s.Idx, True)
            else
              DScreen.ShowHint(SurfaceX(X) + 30, SurfaceY(nY + 30),
                ShowItemInfo(p.Item, [], []), clwhite, False, p.Item.s.Idx, True);
          end
          else begin
            MDlgMove := p^;
          end;
          break;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DModalDlgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  MDWindow: TDModalWindow;
begin
  MDWindow := nil;
  if Sender is TDModalWindow then begin
    MDWindow := TDModalWindow(Sender);
  end
  else if (Sender is TDEdit) and (TDEdit(Sender).DParent is TDModalWindow) then begin
    MDWindow := TDModalWindow(TDEdit(Sender).DParent);
  end;

  if MDWindow <> nil then
    with MDWindow do begin
      if Key = 13 then begin
        DialogResult := YesResult;
        Visible := FALSE;
        Key := 0;
      end;
      if Key = 27 then begin
        DialogResult := NoResult;
        Visible := FALSE;
        Key := 0;
      end;
    end;
end;

procedure TFrmDlg.DModalDlgChange(Sender: TObject);
begin
  with Sender as TDCheckBox do begin
    if Tag = 0 then begin
      Checked := True;
      if TObject(AppendData) is TDCheckBox then
        TDCheckBox(AppendData).Checked := False;
      DlgChecked := False;
    end
    else begin
      Checked := True;
      if TObject(AppendData) is TDCheckBox then
        TDCheckBox(AppendData).Checked := False;
      DlgChecked := True;
    end;
  end;
end;

procedure TFrmDlg.DModalDlgOkClick(Sender: TObject; X, Y: Integer);
begin
  if (Sender is TDButton) and (TDButton(Sender).DParent <> nil) then begin
    with TDButton(Sender).DParent as TDModalWindow do begin
      if TDButton(Sender).Tag = 1 then
        DialogResult := YesResult;
      if TDButton(Sender).Tag = 0 then
        DialogResult := NoResult;
      Visible := FALSE;
    end;
  end;
end;

function TFrmDlg.DModalMessageDlg(nShowCount: Integer; msgstr: string; DlgButtons: TMsgDlgButtons; MsgLen: Integer = 70; EClass:
  TDEditClass = deNone; defmsg: string = ''): TModalResult;
var
  lx, ly: integer;
  d: TDXTexture;
  str, data: string;
  nLen: integer;
  nHeight, nWidth: integer;
  i: integer;
  DMsgMaxLen: Integer;
  DMsgLeft: Integer;
  DMsgTop: Integer;
  ModalWindow: TDModalWindow;
  DEdit: TDEdit;
  DOKButton, DNoButton: TDButton;
  CheckBoxYes, CheckBoxNo: TDCheckBox;

  procedure ShowDice();
  var
    I: Integer;
    bo05: Boolean;
  begin
    if m_nDiceCount = 1 then begin
      if m_Dice[0].n67C < 20 then begin
        if GetTickCount - m_Dice[0].dwPlayTick > 100 then begin
          if m_Dice[0].n67C div 5 = 4 then begin
            m_Dice[0].nPlayPoint := Random(6) + 1;
          end
          else begin
            m_Dice[0].nPlayPoint := m_Dice[0].n67C div 5 + 8;
          end;
          m_Dice[0].dwPlayTick := GetTickCount();
          Inc(m_Dice[0].n67C);
        end;
        exit;
      end; //00491461
      m_Dice[0].nPlayPoint := m_Dice[0].nDicePoint;
      if GetTickCount - m_Dice[0].dwPlayTick > 1500 then begin
        ModalWindow.Visible := False;
      end;
      exit;
    end; //004914AD

    bo05 := True;
    for I := 0 to m_nDiceCount - 1 do begin
      if m_Dice[I].n67C < m_Dice[I].n680 then begin
        if GetTickCount - m_Dice[I].dwPlayTick > 100 then begin
          if m_Dice[I].n67C div 5 = 4 then begin
            m_Dice[I].nPlayPoint := Random(6) + 1;
          end
          else begin
            m_Dice[I].nPlayPoint := m_Dice[I].n67C div 5 + 8;
          end;
          m_Dice[I].dwPlayTick := GetTickCount();
          Inc(m_Dice[I].n67C);
        end;
        bo05 := False;
      end
      else begin //004915E4
        m_Dice[I].nPlayPoint := m_Dice[I].nDicePoint;
        if GetTickCount - m_Dice[I].dwPlayTick < 2000 then begin
          bo05 := False;
        end;
      end;
    end; //for
    if bo05 then begin
      ModalWindow.Visible := False;
    end;

  end;
begin
  //  Result := mrCancel;
  Result := mrCancel;
  if (msgstr = '') and (not (mbHelp in DlgButtons)) then
    exit;

  ModalWindow := TDModalWindow.Create(Self);
  ModalWindow.Parent := Self;
  d := g_WMain99Images.Images[30];
  if d <> nil then begin
    ModalWindow.SetImgIndex(g_WMain99Images, 30);
    ModalWindow.Left := g_FScreenXOrigin - d.Width div 2;
    ModalWindow.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  DEdit := nil;
  DOKButton := nil;
  DNoButton := nil;
  CheckBoxYes := nil;
  CheckBoxNo := nil;
  try
    ModalWindow.YesResult := mrOk;
    ModalWindow.NoResult := mrCancel;

    //    lx := 148;
    //    ly := 78;
    ModalWindow.KeyFocus := True;
    ModalWindow.Visible := False;
    //ModalWindow.DParent := DBackground;
    ModalWindow.OnInRealArea := DMsgDlgInRealArea;
    ModalWindow.OnDirectPaint := DMsgDlgDirectPaint;
    ModalWindow.OnKeyDown := DModalDlgKeyDown;
    DMsgMaxLen := 0;
    DMsgTop := DMsgDefTop;
    ModalWindow.Floating := True; //允许鼠标移动
    ModalWindow.MsgList.Clear;
    DMsgLeft := 0;
    if (mbAbort in DlgButtons) then begin
      ModalWindow.KeyFocus := False;
      DEdit := TDEdit.Create(Self);
      DEdit.Parent := Self;
      DEdit.DParent := ModalWindow;
      ModalWindow.DControls.Add(Pointer(DEdit));
      DEdit.OnKeyDown := DModalDlgKeyDown;
      DEdit.OnMouseUp := DEditIDMouseUp;
      DEdit.EditClass := EClass;

      DEdit.Left := 36;
      DEdit.Top := 43;
      DEdit.Width := 257;
      DEdit.Height := 16;
      DEdit.MaxLength := MsgLen;
      DEdit.Visible := False;
      DEdit.Visible := True;
      DEdit.Text := defmsg;
      ModalWindow.MsgList.Add(msgstr);
      nWidth := 328;
      nHeight := 116;
      DMsgLeft := 32;
      DMsgTop := 20;
      if mbIgnore in DlgButtons then
        DEdit.PasswordChar := '*'
      else
        DEdit.PasswordChar := #0;
    end
    else if (mbHelp in DlgButtons) then begin
      nWidth := 188;
      nHeight := 105;
      ModalWindow.Floating := False;
      for I := 0 to m_nDiceCount - 1 do begin
        m_Dice[I].n67C := 0;
        m_Dice[I].n680 := Random(m_nDiceCount + 2) * 5;
        m_Dice[I].nPlayPoint := 1;
        m_Dice[I].dwPlayTick := GetTickCount();
        m_Dice[I].nX := ((nWidth div 2 + 6) - ((m_nDiceCount * 32 + m_nDiceCount) div 2)) + (I * 32 + I);
        m_Dice[I].nY := nHeight div 2 - 14;
      end;
    end
    else begin
      str := msgstr;
      while True do begin
        if str = '' then
          break;
        str := GetValidStr3(str, data, ['\']);
        if data <> '' then begin
          nLen := Canvas.TextWidth(data);
          if nLen > DMsgMaxLen then
            DMsgMaxLen := nLen;
          ModalWindow.MsgList.Add(data);
        end;
      end;
      nHeight := DMsgDefHeigth + (ModalWindow.MsgList.Count - 1) * 14;
      if DMsgMaxLen > DMsgDefMaxLen then begin
        DMsgLeft := DMsgDefLeft;
        nWidth := DMsgDefWidth + (DMsgMaxLen - DMsgDefMaxLen);
      end
      else begin
        nWidth := DMsgDefWidth;
        DMsgLeft := (DMsgDefWidth - DMsgMaxLen) div 2;
      end;
    end;
    ModalWindow.Left := g_FScreenXOrigin - nWidth div 2;
    ModalWindow.Top := g_FScreenYOrigin - nHeight div 2;
    ModalWindow.Width := nWidth;
    ModalWindow.Height := nHeight;
    ModalWindow.CreateSurface(nil);
    {ModalWindow.Surface := TDXTexture.Create(FrmMain.DXDraw.DDraw);
    ModalWindow.Surface.SystemMemory := True;
    ModalWindow.Surface.SetSize(nWidth, nHeight);
    ModalWindow.Surface.Canvas.Font.Name := DEF_FONT_NAME;
    ModalWindow.Surface.Canvas.Font.Size := DEF_FONT_SIZE;    }

    DrawZoomDlg(ModalWindow);
    if (mbAbort in DlgButtons) then begin
      d := g_WMain99Images.Images[272];
      if d <> nil then
        ModalWindow.Surface.CopyTexture(32, 41, d);
    end;
    for i := 0 to ModalWindow.MsgList.Count - 1 do
      ModalWindow.Surface.TextOutEx(DMsgLeft, DMsgTop + i * 14, ModalWindow.MsgList[i], $C8FCF8);
    //ModalWindow.MsgLeft := DMsgLeft;
    //ModalWindow.MsgTop := DMsgTop;
    //with ModalWindow.Surface.Canvas do begin
      {SetBkMode(Handle, TRANSPARENT);
      for i := 0 to ModalWindow.MsgList.Count - 1 do
        BoldTextOutEx(ModalWindow.Surface, DMsgLeft, DMsgTop + i * 14, $C8FCF8, $F0, ModalWindow.MsgList[i]);
      Release; }
    //end;

    lx := nWidth div 2 + 7;
    ly := nHeight - 44;
{$IF Var_Interface = Var_Mir2}
    Inc(lx, 12);
{$IFEND}
    if mbRetry in DlgButtons then begin
      //      lx := lx - 56;
      if mbYes in DlgButtons then
        ModalWindow.YesResult := mrYes
      else
        ModalWindow.YesResult := mrOk;
      DOKButton := TDButton.Create(Self);
      DOKButton.Parent := Self;
      DOKButton.DParent := ModalWindow;
      ModalWindow.DControls.Add(Pointer(DOKButton));
      DOKButton.Tag := 1;
      DOKButton.Caption := '确定';
      DOKButton.OnClickSound := dbtnSelServer1ClickSound;
      DOKButton.OnClick := DModalDlgOkClick;
{$IF Var_Interface = Var_Mir2}
      DOKButton.SetImgIndex(g_WMain99Images, 1650);
      DOKButton.OnDirectPaint := DBTHintCloseDirectPaint;
      DOKButton.DFColor := $ADD6EF;
{$ELSE}
      DOKButton.SetImgIndex(g_WMain99Images, 24);
{$IFEND}

      DOKButton.Left := DEdit.Left + DEDit.Width - DOKButton.Width;
      DOKButton.Top := ly;
      DOKButton.Visible := True;

      CheckBoxYes := TDCheckBox.Create(Self);
      CheckBoxYes.Parent := Self;
      CheckBoxYes.DParent := ModalWindow;
      CheckBoxYes.OnChange := DModalDlgChange;
      CheckBoxYes.Checked := not DlgChecked;
      ModalWindow.DControls.Add(Pointer(CheckBoxYes));
      CheckBoxYes.OffsetLeft := 4;
      CheckBoxYes.OffsetTop := 1;
      CheckBoxYes.Tag := 0;
      CheckBoxYes.Caption := g_sGoldName;
      CheckBoxYes.SetImgIndex(g_WMain99Images, 151);

      CheckBoxYes.Left := DEdit.Left;
      CheckBoxYes.Top := DEdit.Top + DEdit.Height + 8;
      CheckBoxYes.Visible := True;

      CheckBoxNo := TDCheckBox.Create(Self);
      CheckBoxNo.Parent := Self;
      CheckBoxNo.DParent := ModalWindow;
      CheckBoxNo.OnChange := DModalDlgChange;
      CheckBoxNo.Checked := DlgChecked;
      ModalWindow.DControls.Add(Pointer(CheckBoxNo));
      CheckBoxNo.OffsetLeft := 4;
      CheckBoxNo.OffsetTop := 1;
      CheckBoxNo.Tag := 1;
      CheckBoxNo.Caption := g_sGameGoldName;
      CheckBoxNo.SetImgIndex(g_WMain99Images, 151);

      CheckBoxNo.Left := DEdit.Left;
      CheckBoxNo.Top := CheckBoxYes.Top + CheckBoxYes.Height + 4;
      CheckBoxNo.Visible := True;

      CheckBoxNo.AppendData := CheckBoxYes;
      CheckBoxYes.AppendData := CheckBoxNo;

    end
    else begin
      if (mbCancel in DlgButtons) or (mbNo in DlgButtons) then begin
        if mbCancel in DlgButtons then
          ModalWindow.NoResult := mrCancel
        else
          ModalWindow.NoResult := mrNo;
        DNoButton := TDButton.Create(Self);
        DNoButton.Parent := Self;
        DNOButton.DParent := ModalWindow;
        ModalWindow.DControls.Add(Pointer(DNoButton));
        DNoButton.Tag := 0;
        DNoButton.Caption := '取消';
        DNoButton.OnClickSound := dbtnSelServer1ClickSound;
        DNoButton.OnClick := DModalDlgOkClick;
{$IF Var_Interface = Var_Mir2}
        DNoButton.SetImgIndex(g_WMain99Images, 1650);
        DNoButton.OnDirectPaint := DBTHintCloseDirectPaint;
        DNoButton.DFColor := $ADD6EF;
{$ELSE}
        DNoButton.SetImgIndex(g_WMain99Images, 24);
{$IFEND}
        DNoButton.Left := lx;
        DNoButton.Top := ly;
        DNoButton.Visible := True;
        lx := lx - 114 + 56;
      end;
      if (mbYes in DlgButtons) or (mbOk in DlgButtons) or (DlgButtons = []) then begin
        lx := lx - 56;
        if mbYes in DlgButtons then
          ModalWindow.YesResult := mrYes
        else
          ModalWindow.YesResult := mrOk;
        DOKButton := TDButton.Create(Self);
        DOKButton.Parent := Self;
        DOKButton.DParent := ModalWindow;
        ModalWindow.DControls.Add(Pointer(DOKButton));
        DOKButton.Tag := 1;
        DOKButton.Caption := '确定';
        DOKButton.OnClickSound := dbtnSelServer1ClickSound;
        DOKButton.OnClick := DModalDlgOkClick;
{$IF Var_Interface = Var_Mir2}
        DOKButton.SetImgIndex(g_WMain99Images, 1650);
        DOKButton.OnDirectPaint := DBTHintCloseDirectPaint;
        DOKButton.DFColor := $ADD6EF;
{$ELSE}
        DOKButton.SetImgIndex(g_WMain99Images, 24);
{$IFEND}
        DOKButton.Left := lx;
        DOKButton.Top := ly;
        DOKButton.Visible := True;
      end;
    end;
    ReleaseDCapture;
    ModalWindow.ModalShow;
    if DEdit <> nil then
      DEdit.SetFocus
    else
      ModalWindow.SetFocus;
    frmMain.TimerRun.Enabled := False;
    while True do begin
      if not ModalWindow.Visible then
        break;
      if (mbHelp in DlgButtons) then begin
        ShowDice();
      end;
      if nShowDlgCount = nShowCount then
        frmMain.AppOnIdle();
      Application.ProcessMessages;
      if Application.Terminated then
        Exit;
      Sleep(40);
    end;
    if DEdit <> nil then
      DlgEditText := DEdit.Text;
    Result := ModalWindow.DialogResult;
  finally
    ModalWindow.ModalClose;
    if DEdit <> nil then
      g_DControlFreeList.Add(DEdit);
    if DOKButton <> nil then
      g_DControlFreeList.Add(DOKButton);
    if DNoButton <> nil then
      g_DControlFreeList.Add(DNoButton);
    if CheckBoxYes <> nil then
      g_DControlFreeList.Add(CheckBoxYes);
    if CheckBoxNo <> nil then
      g_DControlFreeList.Add(CheckBoxNo);
    g_DControlFreeList.Add(ModalWindow);
  end;
end;

function TFrmDlg.DMessageDlg(msgstr: string; DlgButtons: TMsgDlgButtons; MsgLen: Integer; EClass: TDEditClass;
  defmsg: string): TModalResult;
var
  lx, ly: integer;
  d: TDXTexture;
begin
  if g_ConnectionStep = cnsPlay then begin
    Inc(nShowDlgCount);
    try
      Result := DModalMessageDlg(nShowDlgCount, msgstr, DlgButtons, MsgLen, EClass, defMsg);
    finally
      Dec(nShowDlgCount);
      if nShowDlgCount <= 0 then begin
        nShowDlgCount := 0;
        frmMain.TimerRun.Enabled := True;
      end;
    end;
    exit;
  end;
  Result := mrCancel;
  if msgstr = '' then
    exit;
  YesResult := mrOk;
  NoResult := mrCancel;
  lx := 148;
  ly := 78;
  DMsgDlg.KeyFocus := True;

  DMsgDlg.Floating := False; //允许鼠标移动
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1620];
  if d <> nil then begin
    DMsgDlg.SetImgIndex(g_WMain99Images, 1620);
    DMsgDlg.Left := g_FScreenXOrigin - d.Width div 2;
    DMsgDlg.Top := g_FScreenYOrigin - d.Height div 2;
    DMsgDlgOk.SetImgIndex(g_WMain99Images, 1650);
    DMsgDlgCancel.SetImgIndex(g_WMain99Images, 1650);
    DMsgDlgOk.OnDirectPaint := DBTHintCloseDirectPaint;
    DMsgDlgCancel.OnDirectPaint := DBTHintCloseDirectPaint;
    DMsgDlgOk.DFColor := $ADD6EF;
    DMsgDlgCancel.DFColor := $ADD6EF;

    msglx := 36;
    msgly := 33;
    lx := 156;
    ly := 62;
  end;
{$ELSE}
  d := g_WMain99Images.Images[30];
  if d <> nil then begin
    DMsgDlg.SetImgIndex(g_WMain99Images, 30);
    DMsgDlg.Left := (BASE_WIDTH - d.Width) div 2;
    DMsgDlg.Top := (BASE_HEIGHT - d.Height) div 2;
    msglx := 36;
    msgly := 44;
    lx := 148;
    ly := 78;
  end;
{$IFEND}


  MsgText := msgstr;
  //ViewDlgEdit := FALSE; //编辑框不可见
  DMsgDlgOk.Visible := FALSE;
  DMsgDlgCancel.Visible := FALSE;
  if mbCancel in DlgButtons then begin
    NoResult := mrCancel;
    DMsgDlgCancel.Left := lx;
    DMsgDlgCancel.Top := ly;
    DMsgDlgCancel.Visible := True;
    lx := lx - 114 + 56;
  end
  else if mbNo in DlgButtons then begin
    NoResult := mrNo;
    DMsgDlgCancel.Left := lx;
    DMsgDlgCancel.Top := ly;
    DMsgDlgCancel.Visible := True;
    lx := lx - 114 + 56;
  end;
  if mbYes in DlgButtons then begin
    lx := lx - 56;
    YesResult := mrYes;
    DMsgDlgOk.Left := lx;
    DMsgDlgOk.Top := ly;
    DMsgDlgOk.Visible := True;
  end
  else if (mbOk in DlgButtons) or (DlgButtons = []) then begin
    lx := lx - 56;
    YesResult := mrOk;
    DMsgDlgOk.Left := lx;
    DMsgDlgOk.Top := ly;
    DMsgDlgOk.Visible := True;
  end;
  DMsgDlg.ShowModal;
  if DEditDlgEdit.Visible then
    DEditDlgEdit.SetFocus;

  frmMain.TimerRun.Enabled := False;
  //Result := YesResult;
  //boShowDlg := True;
  while True do begin
    if not DMsgDlg.Visible then
      break;

    frmMain.AppOnIdle();
    Application.ProcessMessages;
    if Application.Terminated then
      Exit;
    //if not boShowDlg then break;
    Sleep(40);
  end;
  frmMain.TimerRun.Enabled := True;
  DlgEditText := DEditDlgEdit.Text;
  DEditDlgEdit.Visible := False;
  Result := DMsgDlg.DialogResult;
  if DEditChat.Visible then
    DEditChat.SetFocus;
  DMsgDlg.Visible := False;
end;

procedure TFrmDlg.DMiniMapDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  mx, my, i, nLen: integer;
  rc, dc: TRect;
  actor: TActor;
  cX, cY: integer;
  btColor: Byte;
  boMove: Boolean;
  ax, ay: integer;
  MapDesc: pTMapDesc;
  str: string;
  nWidth, nHeight: Integer;
begin
  with Sender as TDWindow do begin
    if g_MySelf = nil then
      exit;

    if GetTickCount > m_dwBlinkTime + 300 then begin
      m_dwBlinkTime := GetTickCount;
      m_boViewBlink := not m_boViewBlink;
    end;
    //g_MapDesc
    if g_nMiniMapIndex > 10000 then
      d := g_WUIBImages.Images[g_nMiniMapIndex - 10000]
    else if g_nMiniMapIndex >= 1000 then
      d := g_WMyMMapImages.Images[g_nMiniMapIndex - 1000]
    else
      d := g_WMMapImages.Images[g_nMiniMapIndex];
    if d = nil then begin
      Visible := False;
      exit;
    end;

    if g_nViewMinMapLv = 2 then begin
      cx := -1;
      cy := 0;

      ax := SurfaceX(Left);
      ay := SurfaceY(Top);

      nWidth := _MIN(d.ClientRect.Right, Width);
      nHeight := _MIN(d.ClientRect.Bottom, Height);

      dc.Left := ax + (Width - nWidth) div 2;
      dc.Top := ay + (Height - nHeight) div 2;
      dc.Right := dc.Left + nWidth;
      dc.Bottom := dc.Top + nHeight;
      rc.Left := 0;
      rc.Top := 0;
      rc.Right := d.ClientRect.Right;
      rc.Bottom := d.ClientRect.Bottom;
      if g_boViewMiniMapMark then begin
        DSurface.StretchDraw(dc, rc, d, $80FFFFFF, fxBlend);
      end
      else begin
        g_DXCanvas.FillRect(ax, ay, ax + Width, ay + Height, $FF000000);
        DSurface.StretchDraw(dc, rc, d, False);
      end;

      if (g_nMiniMapMaxX >= dc.Left) and (g_nMiniMapMaxX <= dc.Right) and
        (g_nMiniMapMaxY >= dc.Top) and (g_nMiniMapMaxY <= dc.Bottom) then begin
        cX := (g_nMiniMapMaxX - dc.Left) * 32 * rc.Right div nWidth div 48;
        cy := (g_nMiniMapMaxY - dc.Top) * rc.Bottom div nHeight;
      end;

      if cx > -1 then begin
        g_nMiniMapMaxMosX := cX;
        g_nMiniMapMaxMosY := cY;
      end
      else begin
        g_nMiniMapMaxMosX := g_MySelf.m_nCurrX;
        g_nMiniMapMaxMosY := g_MySelf.m_nCurrY;
      end;

      if (g_nMiniMapOldX = -1)  then begin
        g_nMiniMapOldX := g_MySelf.m_nCurrX;
        g_nMiniMapOldY := g_MySelf.m_nCurrY;
        Surface.Clear;
        with Surface do begin
          if (g_MapDesc <> nil) and g_SetupInfo.boShowMapHint then begin
            for i := 0 to g_MapDesc.MaxList.Count - 1 do begin
              MapDesc := g_MapDesc.MaxList[i];
              if MapDesc.nColor > 0 then begin
                mx := Trunc((MapDesc.nX * 48) * (nWidth / rc.Right)) div 32;
                my := Trunc(MapDesc.nY * (nHeight / rc.Bottom));
                TextOutEx(mx - g_DXCanvas.TextWidth(MapDesc.sName) div 2, my, MapDesc.sName, MapDesc.nColor, $8);
              end;
            end;
          end;
        end;
      end;
      DSurface.Draw(ax, ay, Surface.ClientRect, Surface, True);
      if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
        boMove := False;
        mx := -1;
        my := -1;
        for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do begin
          mx := dc.Left + Trunc((g_nMiniMapPath[i].X * 48) * (nWidth / rc.Right)) div 32;
          my := dc.Top + Trunc(g_nMiniMapPath[i].Y * (nHeight / rc.Bottom));
          if boMove then
            g_DXCanvas.LineTo(mx, my, clRed)
          else
            g_DXCanvas.MoveTo(mx, my);
          boMove := True;
        end;
        d := g_WMain99Images.Images[71];
        if d <> nil then
          DSurface.Draw(mx - 2, my + 2 - d.Height, d.ClientRect, d, True);
      end;

      TempList.Clear;
      for I := 0 to PlayScene.m_ActorList.Count - 1 do begin
        actor := TActor(PlayScene.m_ActorList.Items[I]);
        if (actor <> nil) and
          (actor <> g_MySelf) and
          (not actor.m_boDeath) and
          (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 20) and
          (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 20) then begin
          mx := dc.Left + Trunc((actor.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
          my := dc.Top + Trunc(actor.m_nCurrY * (nHeight / rc.Bottom));
          if (actor.m_Group <> nil) or (actor.m_btRace = 50) then begin
            TempList.Add(actor);
            Continue;
          end;
          if ((Actor.m_btRace <> RCC_USERHUMAN) and
            (Actor.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD])) then begin
            btColor := 65 {129};
          end
          else begin
            case actor.m_btRace of //
              0: btColor := 66;
            else
              btColor := 67;
            end;
          end;
          d := g_WMain99Images.Images[btColor];
          if d <> nil then
            dsurface.Draw(mx - d.Width div 2, my - d.Height div 2, d.ClientRect, d, True);
        end;
      end;

      if TempList.Count > 0 then
        for I := 0 to TempList.Count - 1 do begin
          actor := TActor(TempList.Items[I]);
          mx := dc.Left + Trunc((actor.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
          my := dc.Top + Trunc(actor.m_nCurrY * (nHeight / rc.Bottom));
          case actor.m_btRace of //
            50: btColor := 68;
          else
            btColor := 69;
          end;
          d := g_WMain99Images.Images[btColor];
          if d <> nil then
            dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
              d.ClientRect, d, True);
        end;

      if not m_boViewBlink then begin
        mx := dc.Left + Trunc((g_MySelf.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
        my := dc.Top + Trunc(g_MySelf.m_nCurrY * (nHeight / rc.Bottom));
        d := g_WMain99Images.Images[70];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
            d.ClientRect, d, True);
      end;
      if cx > -1 then begin
        str := IntToStr(cx) + ',' + IntToStr(cy);
        g_DXCanvas.TextOut(ax + 96 - g_DXCanvas.TextWidth(str) div 2, ay + 146, $8CEFF7, str);
        
        mx := dc.Left + Trunc((cX * 48) * (nWidth / rc.Right)) div 32;
        my := dc.Top + Trunc(cY * (nHeight / rc.Bottom)) + 2;

        d := g_WMain99Images.Images[71];
        if d <> nil then
          DSurface.Draw(mx, my - d.Height, d.ClientRect, d, True);
      end;

    end else begin
      cx := -1;
      cy := 0;

      ax := SurfaceX(Left);
      ay := SurfaceY(Top);

      mx := (g_MySelf.m_nCurrX * 48) div 32;
      my := (g_MySelf.m_nCurrY * 32) div 32;
      rc.Left := _MAX(0, mx - 64);
      rc.Top := _MAX(0, my - 64);
      if d = nil then begin
        rc.Right := rc.Left + Width;
        rc.Bottom := rc.Top + Height;
      end
      else begin
        rc.Right := _MIN(d.ClientRect.Right, rc.Left + Width);
        rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + Height);

      end;

      if g_nMiniMapX >= 0 then begin
        cX := (g_nMiniMapX + rc.Left - ax) * 32 div 48;
        cy := (g_nMiniMapY + rc.Top - ay) * 32 div 32;
      end;

      if cx > -1 then begin
        g_nMiniMapMosX := cX;
        g_nMiniMapMosY := cY;
      end
      else begin
        g_nMiniMapMosX := g_MySelf.m_nCurrX;
        g_nMiniMapMosY := g_MySelf.m_nCurrY;
      end;
      if g_boViewMiniMapMark then DSurface.Draw(ax, ay, rc, d, $80FFFFFF, fxBlend)
      else begin
        g_DXCanvas.FillRect(ax, ay, ax + Width, ay + Height, $FF000000);
        DSurface.Draw(ax, ay, rc, d, FALSE);
      end;


      if (g_nMiniMapOldX <> g_MySelf.m_nCurrX) or (g_nMiniMapOldY <> g_MySelf.m_nCurrY) then begin
        g_nMiniMapOldX := g_MySelf.m_nCurrX;
        g_nMiniMapOldY := g_MySelf.m_nCurrY;
        Surface.Clear;
        //if d <> nil then
          //Surface.Draw(0, 0, rc, d, FALSE);
        with Surface do begin
          if (g_MapDesc <> nil) and g_SetupInfo.boShowMapHint then begin
            //SetBkMode(Handle, TRANSPARENT);
            for i := 0 to g_MapDesc.MinList.Count - 1 do begin
              MapDesc := g_MapDesc.MinList[i];
              if MapDesc.nColor > 0 then begin
                mx := (MapDesc.nX * 48) div 32 - rc.Left + 2;
                my := (MapDesc.nY * 32) div 32 - rc.Top - 2;
                nLen := g_DXCanvas.TextWidth(MapDesc.sName) div 2;
                mx := mx - nLen;
                if ((mx + nLen * 2) > 0) and ((my + 14) > 0) and (mx < Width) and (my < Height) then
                  TextOutEx(mx, my, MapDesc.sName, MapDesc.nColor, $8);
              end;
            end;
            //Release;
          end;
          if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
            mx := (g_nMiniMapPath[High(g_nMiniMapPath)].X * 48) div 32 - rc.Left + 2;
            my := (g_nMiniMapPath[High(g_nMiniMapPath)].Y * 32) div 32 - rc.Top - 2;

            d := g_WMain99Images.Images[71];
            if d <> nil then
              Surface.CopyTexture(mx - 2, my + 2 - d.Height, d);
          end;
        end;
      end;
      DSurface.Draw(ax, ay, Surface.ClientRect, Surface, True);
      if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
        //SetBkMode(Handle, TRANSPARENT);
        //Pen.Color := clRed;
        boMove := False;
        for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do begin
          mx := (g_nMiniMapPath[i].X * 48) div 32 - rc.Left + 2;
          my := (g_nMiniMapPath[i].Y * 32) div 32 - rc.Top - 2;
          if (mx < 0) or (my < 0) or (mx > Surface.Width) or (my > Surface.Height) then
            Continue;
          if boMove then
            g_DXCanvas.LineTo(ax + mx, ay + my, clRed)
          else
            g_DXCanvas.MoveTo(ax + mx, ay + my);
          boMove := True;
        end;
        //Release;
        //d := g_WMain99Images.Images[71];
        //if d <> nil then
          //Surface.CopyTexture(mx - 2, my + 2 - d.Height, d);
          //Surface.Draw(mx - 2, my + 2 - d.Height, d.ClientRect, d, True);
      end;
      TempList.Clear;
      for I := 0 to PlayScene.m_ActorList.Count - 1 do begin
        actor := TActor(PlayScene.m_ActorList.Items[I]);
        if (actor <> nil) and
          (actor <> g_MySelf) and
          (not actor.m_boDeath) and
          (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 20) and
          (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 20) then begin
          mx := ax + (actor.m_nCurrX * 48) div 32 - rc.Left + 2;
          my := ay + (actor.m_nCurrY * 32) div 32 - rc.Top - 2;
          if (actor.m_Group <> nil) or (actor.m_btRace = 50) then begin
            TempList.Add(actor);
            Continue;
          end;
          if ((Actor.m_btRace <> RCC_USERHUMAN) and (Actor.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD])) then begin
            btColor := 65 {129};
          end
          else begin
            case actor.m_btRace of //
              0: btColor := 66;
            else
              btColor := 67;
            end;
          end;
          d := g_WMain99Images.Images[btColor];
          if d <> nil then
            dsurface.Draw(mx - d.Width div 2, my - d.Height div 2, d.ClientRect, d, True);
        end;
      end;

      if TempList.Count > 0 then
        for I := 0 to TempList.Count - 1 do begin
          actor := TActor(TempList.Items[I]);
          mx := ax + (actor.m_nCurrX * 48) div 32 - rc.Left + 2;
          my := ay + (actor.m_nCurrY * 32) div 32 - rc.Top - 2;
          case actor.m_btRace of //
            50: btColor := 68;
          else
            btColor := 69;
          end;
          d := g_WMain99Images.Images[btColor];
          if d <> nil then
            dsurface.Draw(mx - d.Width div 2, my - d.Height div 2, d.ClientRect, d, True);
        end;

      if not m_boViewBlink then begin
        mx := ax + (g_MySelf.m_nCurrX * 48) div 32 - rc.Left + 2;
        my := ay + (g_MySelf.m_nCurrY * 32) div 32 - rc.Top - 2;
        //dsurface.Pixels[mx + 2, my - 2] := clRed;
        d := g_WMain99Images.Images[70];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2, d.ClientRect, d, True);
      end;

      if cx > -1 then begin
        str := IntToStr(cx) + ',' + IntToStr(cy);
        g_DXCanvas.TextOut(ax + 64 - g_DXCanvas.TextWidth(str) div 2, ay + 114, $8CEFF7, str);
        mx := ax + (cX * 48) div 32 - rc.Left;
        my := ay + (cY * 32) div 32 - rc.Top;
        d := g_WMain99Images.Images[71];
        if d <> nil then
          DSurface.Draw(mx, my - d.Height, d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DMiniMapDlgDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d, dd: TDXTexture;
  rc: TRect;
  ax, ay: integer;
  str: string;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      boMaxMinimapShow := True;
      g_boMiniMapShow := not g_boMiniMapClose;
      //if not g_boMiniMapClose then begin
      if g_nMiniMapIndex < 0 then begin
        boMaxMinimapShow := False;
      end
      else begin
        if g_nMiniMapIndex > 10000 then
          dd := g_WUIBImages.Images[g_nMiniMapIndex - 10000]
        else if g_nMiniMapIndex >= 1000 then
          dd := g_WMyMMapImages.Images[g_nMiniMapIndex - 1000]
        else
          dd := g_WMMapImages.Images[g_nMiniMapIndex];
        //dd := g_WMMapImages.Images[g_nMiniMapIndex];
        if dd = nil then
          boMaxMinimapShow := False;
      end;
      //end;

      ax := 58;
      if g_boMiniMapShow then begin
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        ay := 134;
        DMinMap128.Visible := True;
      end
      else begin
        rc := d.ClientRect;
        rc.Top := 133;
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), rc, d, True);
        ay := 1;
        DMinMap128.Visible := False;
      end;
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        //Font.Color := clWhite;
        str := IntToStr(g_MySelf.m_nCurrX);
        TextOut(SurfaceX(Left) + ax - TextWidth(str) div 2, SurfaceY(Top) + ay, str, clWhite);
        str := IntToStr(g_MySelf.m_nCurrY);
        TextOut(SurfaceX(Left) + ax + 54 - TextWidth(str) div 2, SurfaceY(Top) + ay, str, clWhite);
        //Release;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMiniMapDlgInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
        if g_boMiniMapShow then begin
          if d.Pixels[x, y] <= 0 then
            IsRealArea := FALSE;
        end
        else begin
          if d.Pixels[x, y + 133] <= 0 then
            IsRealArea := FALSE;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMiniMapMaxClick(Sender: TObject; X, Y: Integer);
begin
  if boMaxMinimapShow then
    DMaxMiniMap.Visible := not DMaxMiniMap.Visible
  else
    DScreen.AddSysMsg('没有可用地图.', $32F4);
end;

procedure TFrmDlg.DMiniMapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  nX, nY: Integer;
begin
  if (Button = mbRight) or (Button = mbMiddle) then begin
    if g_nViewMinMapLv = 2 then begin
      nX := g_nMiniMapMaxMosX;
      nY := g_nMiniMapMaxMosY; 
    end else begin
      nX := g_nMiniMapMosX;
      nY := g_nMiniMapMosY; 
    end;
    if Button = mbMiddle then begin
      g_boAutoMoveing := False;
      FrmMain.SendSay(g_Cmd_UserMove + ' ' + IntToStr(nX) + ' ' + IntToStr(nY) + ' TOPHINT');
    end else begin
      g_nMiniMapOldX := -1;
      g_nMiniMapPath := FindPath(nX, nY);
      if High(g_nMiniMapPath) > 2 then begin
        g_boAutoMoveing := False;
        g_nMiniMapMoseX := nX;
        g_nMiniMapMoseY := nY;
        DScreen.AddSysMsg('[单击屏幕停止移动]', clWhite);
        g_boAutoMoveing := True;
        g_boNpcMoveing := False;
      end
      else begin
        g_nMiniMapMoseX := -1;
        g_nMiniMapMoseY := -1;
        DScreen.AddSysMsg('[无法到达目的地]', clWhite);
      end;
    end;
  end else
    g_boViewMiniMapMark := not g_boViewMiniMapMark;
end;

procedure TFrmDlg.DMiniMapMouseEntry(Sender: TObject; MouseEntry: TMouseEntry);
begin
  if MouseEntry = msOut then begin
    g_nMiniMapX := -1;
    g_nMiniMapMaxX := -1;
  end;
end;

procedure TFrmDlg.DMiniMapMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowStr: string;
begin
  if g_nViewMinMapLv = 2 then begin
    g_nMiniMapMaxX := DMiniMap.SurfaceX(x);
    g_nMiniMapMaxY := DMiniMap.SurfaceY(Y);
  end else begin
    g_nMiniMapX := DMiniMap.SurfaceX(x);
    g_nMiniMapY := DMiniMap.SurfaceY(y);
  end;
  ShowStr := '右键单击自动寻路\';
  ShowStr := ShowStr + '中键单击自动传送\(<自动传送需要配戴传送装备/FCOLOR=$FFFF>)';
  DScreen.ShowHint(DMiniMap.SurfaceX(DMiniMap.Left), DMiniMap.SurfaceY(DMiniMap.Top) + DMiniMap.Height, ShowStr, clWhite, False, x);
end;

procedure TFrmDlg.DMinMap128DirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  mx, my, i, nLen: integer;
  rc: TRect;
  actor: TActor;
  cX, cY: integer;
  btColor: Byte;
  boMove: Boolean;
  ax, ay: integer;
  MapDesc: pTMapDesc;
  str: string;
begin
  with Sender as TDWindow do begin
    if g_MySelf = nil then
      exit;

    if GetTickCount > m_dwBlinkTime + 300 then begin
      m_dwBlinkTime := GetTickCount;
      m_boViewBlink := not m_boViewBlink;
    end;
    //g_MapDesc
    if g_nMiniMapIndex > 10000 then
      d := g_WUIBImages.Images[g_nMiniMapIndex - 10000]
    else if g_nMiniMapIndex >= 1000 then
      d := g_WMyMMapImages.Images[g_nMiniMapIndex - 1000]
    else
      d := g_WMMapImages.Images[g_nMiniMapIndex];
    {if d = nil then begin
      //Visible := False;
      exit;
    end; }
    cx := -1;
    cy := 0;

    ax := SurfaceX(Left);
    ay := SurfaceY(Top);

    mx := (g_MySelf.m_nCurrX * 48) div 32;
    my := (g_MySelf.m_nCurrY * 32) div 32;
    rc.Left := _MAX(0, mx - 64);
    rc.Top := _MAX(0, my - 64);
    if d = nil then begin
      rc.Right := rc.Left + Width;
      rc.Bottom := rc.Top + Height;
    end
    else begin
      rc.Right := _MIN(d.ClientRect.Right, rc.Left + Width);
      rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + Height);

    end;

    if g_nMiniMapX >= 0 then begin
      cX := (g_nMiniMapX + rc.Left - ax) * 32 div 48;
      cy := (g_nMiniMapY + rc.Top - ay) * 32 div 32;
    end;

    if cx > -1 then begin
      g_nMiniMapMosX := cX;
      g_nMiniMapMosY := cY;
    end
    else begin
      g_nMiniMapMosX := g_MySelf.m_nCurrX;
      g_nMiniMapMosY := g_MySelf.m_nCurrY;
    end;
    if d <> nil then
      DSurface.Draw(ax, ay, rc, d, FALSE);
    if (g_nMiniMapOldX <> g_MySelf.m_nCurrX) or (g_nMiniMapOldY <> g_MySelf.m_nCurrY) then begin
      g_nMiniMapOldX := g_MySelf.m_nCurrX;
      g_nMiniMapOldY := g_MySelf.m_nCurrY;
      Surface.Clear;
      //if d <> nil then
        //Surface.Draw(0, 0, rc, d, FALSE);
      with Surface do begin
        if (g_MapDesc <> nil) and g_SetupInfo.boShowMapHint then begin
          //SetBkMode(Handle, TRANSPARENT);
          for i := 0 to g_MapDesc.MinList.Count - 1 do begin
            MapDesc := g_MapDesc.MinList[i];
            if MapDesc.nColor > 0 then begin
              mx := (MapDesc.nX * 48) div 32 - rc.Left + 2;
              my := (MapDesc.nY * 32) div 32 - rc.Top - 2;
              nLen := g_DXCanvas.TextWidth(MapDesc.sName) div 2;
              mx := mx - nLen;
              if ((mx + nLen * 2) > 0) and ((my + 14) > 0) and (mx < Width) and (my < Height) then
                TextOutEx(mx, my, MapDesc.sName, MapDesc.nColor, $8);
            end;
          end;
          //Release;
        end;
        if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
          mx := (g_nMiniMapPath[High(g_nMiniMapPath)].X * 48) div 32 - rc.Left + 2;
          my := (g_nMiniMapPath[High(g_nMiniMapPath)].Y * 32) div 32 - rc.Top - 2;

          d := g_WMain99Images.Images[71];
          if d <> nil then
            Surface.CopyTexture(mx - 2, my + 2 - d.Height, d);
        end;
      end;
    end;
    DSurface.Draw(ax, ay, Surface.ClientRect, Surface, True);
    if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
      //SetBkMode(Handle, TRANSPARENT);
      //Pen.Color := clRed;
      boMove := False;
      for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do begin
        mx := (g_nMiniMapPath[i].X * 48) div 32 - rc.Left + 2;
        my := (g_nMiniMapPath[i].Y * 32) div 32 - rc.Top - 2;
        if (mx < 0) or (my < 0) or (mx > Surface.Width) or (my > Surface.Height) then
          Continue;
        if boMove then
          g_DXCanvas.LineTo(ax + mx, ay + my, clRed)
        else
          g_DXCanvas.MoveTo(ax + mx, ay + my);
        boMove := True;
      end;
      //Release;
      //d := g_WMain99Images.Images[71];
      //if d <> nil then
        //Surface.CopyTexture(mx - 2, my + 2 - d.Height, d);
        //Surface.Draw(mx - 2, my + 2 - d.Height, d.ClientRect, d, True);
    end;
    TempList.Clear;
    for I := 0 to PlayScene.m_ActorList.Count - 1 do begin
      actor := TActor(PlayScene.m_ActorList.Items[I]);
      if (actor <> nil) and
        (actor <> g_MySelf) and
        (not actor.m_boDeath) and
        (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 20) and
        (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 20) then begin
        mx := ax + (actor.m_nCurrX * 48) div 32 - rc.Left + 2;
        my := ay + (actor.m_nCurrY * 32) div 32 - rc.Top - 2;
        if (actor.m_Group <> nil) or (actor.m_btRace = 50) then begin
          TempList.Add(actor);
          Continue;
        end;
        if ((Actor.m_btRace <> RCC_USERHUMAN) and
          (Actor.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD])) then begin
          btColor := 65 {129};
        end
        else begin
          case actor.m_btRace of //
            0: btColor := 66;
          else
            btColor := 67;
          end;
        end;
        d := g_WMain99Images.Images[btColor];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2, d.ClientRect, d, True);
      end;
    end;

    if TempList.Count > 0 then
      for I := 0 to TempList.Count - 1 do begin
        actor := TActor(TempList.Items[I]);
        mx := ax + (actor.m_nCurrX * 48) div 32 - rc.Left + 2;
        my := ay + (actor.m_nCurrY * 32) div 32 - rc.Top - 2;
        case actor.m_btRace of //
          50: btColor := 68;
        else
          btColor := 69;
        end;
        d := g_WMain99Images.Images[btColor];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
            d.ClientRect, d, True);
      end;

    if not m_boViewBlink then begin
      mx := ax + (g_MySelf.m_nCurrX * 48) div 32 - rc.Left + 2;
      my := ay + (g_MySelf.m_nCurrY * 32) div 32 - rc.Top - 2;
      //dsurface.Pixels[mx + 2, my - 2] := clRed;
      d := g_WMain99Images.Images[70];
      if d <> nil then
        dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
          d.ClientRect, d, True);
    end;

    if cx > -1 then begin
      str := IntToStr(cx) + ',' + IntToStr(cy);
      //SetBkMode(DSurface.Canvas.Handle, TRANSPARENT);
      g_DXCanvas.TextOut(ax + 64 - g_DXCanvas.TextWidth(str) div 2, ay + 114, $8CEFF7, str);
      //DSurface.Canvas.Release;
      mx := ax + (cX * 48) div 32 - rc.Left;
      my := ay + (cY * 32) div 32 - rc.Top;
      d := g_WMain99Images.Images[71];
      if d <> nil then
        DSurface.Draw(mx, my - d.Height, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DMinMap128MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then begin
    g_boAutoMoveing := False;
    FrmMain.SendSay(g_Cmd_UserMove + ' ' + IntToStr(g_nMiniMapMosX) + ' ' + IntToStr(g_nMiniMapMosY) + ' TOPHINT');
  end else begin
    g_nMiniMapOldX := -1;
    g_nMiniMapPath := FindPath(g_nMiniMapMosX, g_nMiniMapMosY);
    if High(g_nMiniMapPath) > 2 then begin
      g_boAutoMoveing := False;
      g_nMiniMapMoseX := g_nMiniMapMosX;
      g_nMiniMapMoseY := g_nMiniMapMosY;
      DScreen.AddSysMsg('[单击屏幕停止移动]', clWhite);
      {DScreen.AddChatBoardString(Format('自动移动(%d,%d)，点击屏幕停止移动！',
        [g_nMiniMapMosX, g_nMiniMapMosY]), GetRGB(180), clWhite);   }
      g_boAutoMoveing := True;
      g_boNpcMoveing := False;
    end
    else begin
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      DScreen.AddSysMsg('[无法到达目的地]', clWhite);
      //DScreen.AddChatBoardString('自动移动失败，无法到达终点！', GetRGB(56), clWhite);
    end;
  end;
end;

procedure TFrmDlg.DMinMap128MouseEntry(Sender: TObject;
  MouseEntry: TMouseEntry);
begin
  if MouseEntry = msOut then
    g_nMiniMapX := -1;
end;

procedure TFrmDlg.DMinMap128MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowStr: string;
begin
  g_nMiniMapX := DMinMap128.SurfaceX(x);
  g_nMiniMapY := DMinMap128.SurfaceY(DMinMap128.Top) + Y;
  y := y + 30;
  ShowStr := '左键单击自动寻路\';
  ShowStr := ShowStr + '右键单击自动传送\(<自动传送需要配戴传送装备/FCOLOR=$FFFF>)';
  DScreen.ShowHint(DMinMap128.SurfaceX(x), DMinMap128.SurfaceY(DMinMap128.Top) + Y, ShowStr, clWhite, False, x);
end;

procedure TFrmDlg.DMsgDlgDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, ly, I, nX, nY: integer;
  str, str1, str2, str3: string;
  MaxLen, MaxLen2: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if g_ConnectionStep = cnsPlay then begin
      if Sender is TDModalWindow then begin
        with TDModalWindow(Sender) do begin
          g_DXCanvas.FillRect(ax + 2, ay + 2, Width - 4, Height - 4, {$IF Var_Interface =  Var_Default}$C8080808{$ELSE}$FF101018{$IFEND});
          for I := 0 to 3 do begin
            if DlgInfo[I].WMImages = nil then Continue;
            d := DlgInfo[I].WMImages.Images[DlgInfo[I].Index];
            if d <> nil then begin
              g_DXCanvas.StretchDraw(Rect(DlgInfo[I].Rect.Left + ax, DlgInfo[I].Rect.Top + ay,
                DlgInfo[I].Rect.Right + ax, DlgInfo[I].Rect.Bottom + ay),
                d.ClientRect, d, True);
            end;
          end;
          for I := 4 to 7 do begin
            if DlgInfo[I].WMImages = nil then Continue;
            d := DlgInfo[I].WMImages.Images[DlgInfo[I].Index];
            if d <> nil then begin
{$IF Var_Interface = Var_Mir2}
              if I = 5 then
                g_DXCanvas.Draw(d, DlgInfo[I].Rect.Left + ax, DlgInfo[I].Rect.Top + ay, fxBlend, $FFFFFFFF, False, True)
              else
{$IFEND}
                g_DXCanvas.Draw(DlgInfo[I].Rect.Left + ax, DlgInfo[I].Rect.Top + ay, d.ClientRect, d, True);
            end;
          end;
          g_DXCanvas.Draw(ax, ay, Surface.ClientRect, Surface, True);
          //if Surface <> nil then
            //DrawWindow(dsurface, ax, ay, Surface);
        end;
        if m_nDiceCount > 0 then begin
          for I := 0 to m_nDiceCount - 1 do begin
            d := GetBagItemImg(m_Dice[I].nPlayPoint + 376 - 1, nX, nY);
            if d <> nil then begin
              dsurface.Draw(SurfaceX(Left) + m_Dice[I].nX + nX - 14, SurfaceY(Top) + m_Dice[I].nY + nY + 38, d.ClientRect, d, TRUE);
            end;
          end;
        end;
      end;
    end
    else begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        DrawWindow(dsurface, ax, ay, d);

      ly := msgly;
      str := MsgText;
      str := GetValidStr3(str, str1, ['\']);
      str := GetValidStr3(str, str2, ['\']);
      str := GetValidStr3(str, str3, ['\']);
{$IF Var_Interface = Var_Mir2}
      if str3 <> '' then
        ly := ly - 14
      else if str2 <> '' then
        ly := ly - 7;
{$ELSE}
      if str3 <> '' then
        ly := ly - 18
      else if str2 <> '' then
        ly := ly - 8;
{$IFEND}
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        MaxLen := TextWidth(str1);
        MaxLen2 := TextWidth(str2);
        if MaxLen < MaxLen2 then
          MaxLen := MaxLen2;
        MaxLen2 := TextWidth(str3);
        if MaxLen < MaxLen2 then
          MaxLen := MaxLen2;
        MaxLen := MaxLen div 2;
{$IF Var_Interface = Var_Mir2}
        if Str1 <> '' then
          TextOut(ax + (136 - MaxLen), ay + ly, clWhite, str1);
        Inc(ly, 14);
        if Str2 <> '' then
          TextOut(ax + (136 - MaxLen), ay + ly, clWhite, str2);
        Inc(ly, 14);
        if Str3 <> '' then
          TextOut(ax + (136 - MaxLen), ay + ly, clWhite, str3);
{$ELSE}
        if Str1 <> '' then
          TextOut(ax + (140 - MaxLen), ay + ly, $ADE7CE, str1);
        Inc(ly, 16);
        if Str2 <> '' then
          TextOut(ax + (140 - MaxLen), ay + ly, $ADE7CE, str2);
        Inc(ly, 16);
        if Str3 <> '' then
          TextOut(ax + (140 - MaxLen), ay + ly, $ADE7CE, str3);
{$IFEND}

        //Release;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMsgDlgInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
begin
  IsRealArea := True;
end;

procedure TFrmDlg.DMsgDlgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if m_nDiceCount = 0 then begin
    if Key = 13 then begin
      DMsgDlg.DialogResult := YesResult;
      DMsgDlg.Visible := FALSE;
    end;
    if Key = 27 then begin
      DMsgDlg.DialogResult := NoResult;
      DMsgDlg.Visible := FALSE;
    end;
  end;
end;

procedure TFrmDlg.DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DMsgDlgOk then
    DMsgDlg.DialogResult := YesResult;
  if Sender = DMsgDlgCancel then
    DMsgDlg.DialogResult := NoResult;
  DMsgDlg.Visible := FALSE;
end;

procedure TFrmDlg.DMyStateClick(Sender: TObject; X, Y: Integer);
var
  ini: TIniFile;
begin

  if Sender = DOption then begin
{$IF Var_Interface =  Var_Default}
    FrmDlg2.dwndSysSetup.Left := 675;
    FrmDlg2.dwndSysSetup.Top := 433;
    FrmDlg2.dwndSysSetup.TopShow;
{$ELSE}
    FrmDlg3.DGameSetup.Visible := not FrmDlg3.DGameSetup.Visible;
{$IFEND}
  end;

  if Sender = DBotAddAbil then begin
    StatePage := 1;
    DStateWin.Visible := True;
    PageChanged;
  end;

  if Sender = DBotMusic then begin
    if g_boBGSound or g_boSound then begin
      g_boSound := False;
      g_boBGSound := False;
      SilenceSound;
      ClearBGM;
      DScreen.AddSysMsg('[游戏声音 关闭]', clWhite);
    end else begin
      g_boSound := True;
      g_boBGSound := True;
      if g_boCanSound then begin
        if MusicHS >= BASS_ERROR_ENDED then begin
          if BASS_ChannelIsActive(MusicHS) <> BASS_ACTIVE_PLAYING then begin
            PlayMapMusic(True);
          end else
            BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
        end else
          PlayMapMusic(True);
      end;
      DScreen.AddSysMsg('[游戏声音 打开]', clWhite);
    end;
    
    ClientSetup.saveData();
  end;

  //FrmDlg3.DGameSetup.Visible := not FrmDlg3.DGameSetup.Visible;
  if Sender = DMyBag then
    OpenItemBag;
  if Sender = DMyState then begin
    StatePage := 0;
    OpenMyStatus;
  end
  else if Sender = DMyMagic then begin
    StatePage := 2;
    OpenMyStatus;
  end
  else if Sender = DBotFriend then
    FrmDlg2.DWinFriend.Visible := not FrmDlg2.DWinFriend.Visible;
  if Sender = DBotGroup then
    DGroupDlg.Visible := not DGroupDlg.Visible;
  if Sender = DBotTrade then begin
    g_CursorMode := cr_Deal;
    FrmMain.Cursor := crMyDeal;
    {if GetTickCount > g_dwQueryMsgTick then begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      frmMain.SendDealTry;
    end;   }
  end;

end;

procedure TFrmDlg.DMyStateDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
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

procedure TFrmDlg.DMyStateMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDControl do begin
{$IF Var_Interface = Var_Mir2}
    X := SurfaceX(Left);
    y := SurfaceY(Top) - 2;
    ShowMsg := '';
    if Sender = DMyState then begin
      ShowMsg := '人物装备/状态<（' + GetHookKeyStr(@g_CustomKey[DK_OPENMYSTATUS0]) + ' 或 C）/FCOLOR=$FFFF>';
      X := x - 60;
      Y := Y - 8;
    end
    else if Sender = DMyBag then begin
      ShowMsg := '背包物品<（' + GetHookKeyStr(@g_CustomKey[DK_OPENITEMBAG]) + ' 或 B）/FCOLOR=$FFFF>';
      X := x - 53;
      Y := Y - 8;
    end
    else if Sender = DMyMagic then begin
      ShowMsg := '技能信息<（' + GetHookKeyStr(@g_CustomKey[DK_OPENMYSTATUS3]) + ' 或 S）/FCOLOR=$FFFF>';
      X := x - 52;
      Y := Y - 8;
    end
    else if Sender = DBotTrade then begin
      ShowMsg := '交易按扭<（D）/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DBotGuild then begin
      ShowMsg := '行会按扭<（W）/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DBotGroup then begin
      ShowMsg := '队伍按扭<（G）/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DBotFriend then begin
      ShowMsg := '人际关系<（F）/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DBotSort then begin
      ShowMsg := '任务记录<（Q）/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DOption then begin
      ShowMsg := '游戏设置<（F12）/FCOLOR=$FFFF>';
      X := x - 36;
    end
    else if Sender = DButtonTop then begin
      ShowMsg := '排行榜';
      X := x - 11;
    end
    else if Sender = FrmDlg2.dbtnSelectChr then begin
      ShowMsg := '切换人物<（ALT + X）/FCOLOR=$FFFF>';
      X := x - 46;
    end
    else if Sender = FrmDlg2.dbtnExitGame then begin
      ShowMsg := '离开游戏<（ALT + Q）/FCOLOR=$FFFF>';
      X := x - 46;
    end
    else if Sender = DTopShop then begin
      ShowMsg := '游戏商铺';
    end
    else if Sender = DTopHelp then begin
      ShowMsg := '游戏帮助<（H）/FCOLOR=$FFFF>';
      X := x - 25;
    end
    else if Sender = DTopEMail then begin
      ShowMsg := '信件系统<（E）/FCOLOR=$FFFF>';
      X := x - 25;
    end
    else if Sender = DBTTakeHorse then begin
      if g_MySelf.m_btHorse = 0 then
        ShowMsg := '快速上马<（' + GetHookKeyStr(@g_CustomKey[DK_ONHORSE]) + '）/FCOLOR=$FFFF>'
      else
        ShowMsg := '快速下马<（' + GetHookKeyStr(@g_CustomKey[DK_ONHORSE]) + '）/FCOLOR=$FFFF>';
      X := x - 44;
    end
    else if Sender = DBotAddAbil then begin
      ShowMsg := '属性点';
      X := x - 8;
    end
    else if Sender = DBotMusic then begin
      ShowMsg := '游戏声音';
      X := x - 20;
      Y := Y - 8;
    end
    else if Sender = DBotMiniMap then begin
      ShowMsg := '小地图';
      X := x - 8;
    end
    else if Sender = DBTFace then begin
      ShowMsg := '动态表情';
      X := x - 17;
    end;



{$ELSE}
    X := SurfaceX(Left);
    y := g_FScreenHeight - DBottom.Height;
    ShowMsg := '';
    if Sender = DMyState then begin
      ShowMsg := '人物装备/状态<（' + GetHookKeyStr(@g_CustomKey[DK_OPENMYSTATUS0]) + ' 或 C）/FCOLOR=$FFFF>';
      X := x - 48;
    end
    else if Sender = DMyBag then begin
      ShowMsg := '背包物品<（' + GetHookKeyStr(@g_CustomKey[DK_OPENITEMBAG]) + ' 或 B）/FCOLOR=$FFFF>';
      X := x - 42;
    end
    else if Sender = DMyMagic then begin
      ShowMsg := '技能信息<（' + GetHookKeyStr(@g_CustomKey[DK_OPENMYSTATUS3]) + ' 或 S）/FCOLOR=$FFFF>';
      X := x - 42;
    end
    else if Sender = DBotTrade then begin
      ShowMsg := '交易按扭<（D）/FCOLOR=$FFFF>';
      X := x - 24;
    end
    else if Sender = DBotGuild then begin
      ShowMsg := '行会按扭<（W）/FCOLOR=$FFFF>';
      X := x - 24;
    end
    else if Sender = DBotGroup then begin
      ShowMsg := '队伍按扭<（G）/FCOLOR=$FFFF>';
      X := x - 24;
    end
    else if Sender = DBotFriend then begin
      ShowMsg := '人际关系<（F）/FCOLOR=$FFFF>';
      X := x - 24;
    end
    else if Sender = DBotSort then begin
      ShowMsg := '任务记录<（Q）/FCOLOR=$FFFF>';
      X := x - 16;
    end
    else if Sender = DOption then begin
      ShowMsg := '系统选项<（ESC）/FCOLOR=$FFFF>';
      X := x - 24;
    end;
{$IFEND}
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, True, Integer(Sender));
  end;
end;

procedure TFrmDlg.DNewAccountDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
{$IF Var_Interface = Var_Mir2}
  I: Integer;
{$IFEND}
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
{$IF Var_Interface = Var_Mir2}
    if Sender = DNewAccount then begin
      with g_DXCanvas do begin
        for i := 0 to NAHelps.Count - 1 do begin
          TextOut(ax + 392, ay + 124 + i * 14, clSilver, NAHelps[i]);
        end;
      end;
    end;
{$IFEND}
  end;
end;

procedure TFrmDlg.DOpenMinmapClick(Sender: TObject; X, Y: Integer);
begin
  g_boMiniMapClose := not g_boMiniMapClose;
end;

procedure TFrmDlg.DOpenMinmapDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  Idx: Integer;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      Idx := FaceIndex;
      if not g_boMiniMapClose then begin
        if MouseEntry = msIn then
          Inc(Idx);
      end
      else begin
        if MouseEntry = msIn then
          Inc(Idx, 3)
        else
          Inc(Idx, 2)
      end;
      d := WLib.Images[Idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DrawZoomDlg(DModalWindow: TDModalWindow);
var
  d: TDXTexture;
{$IF Var_Interface =  Var_Default}
  dc: TRect;
{$IFEND}
begin
  with DModalWindow do begin
    SafeFillChar(DlgInfo, SizeOf(DlgInfo), #0);
{$IF Var_Interface = Var_Mir2}
    d := g_WMain99Images.Images[2161];
    if d <> nil then begin
      DlgInfo[0].WMImages := g_WMain99Images;
      DlgInfo[0].Index := 2161;
      DlgInfo[0].Rect.Left := 0;
      DlgInfo[0].Rect.Top := 0;
      DlgInfo[0].Rect.Bottom := d.Height;
      DlgInfo[0].Rect.Right := Width;
    end;
    d := g_WMain99Images.Images[2181];
    if d <> nil then begin
      DlgInfo[1].WMImages := g_WMain99Images;
      DlgInfo[1].Index := 2181;
      DlgInfo[1].Rect.Left := 0;
      DlgInfo[1].Rect.Top := Height - d.Height;
      DlgInfo[1].Rect.Bottom := Height;
      DlgInfo[1].Rect.Right := Width;
    end;
    d := g_WMain99Images.Images[2170];
    if d <> nil then begin
      DlgInfo[2].WMImages := g_WMain99Images;
      DlgInfo[2].Index := 2170;
      DlgInfo[2].Rect.Left := 0;
      DlgInfo[2].Rect.Top := 0;
      DlgInfo[2].Rect.Bottom := Height;
      DlgInfo[2].Rect.Right := d.Width;
    end;
    d := g_WMain99Images.Images[2172];
    if d <> nil then begin
      DlgInfo[3].WMImages := g_WMain99Images;
      DlgInfo[3].Index := 2172;
      DlgInfo[3].Rect.Left := Width - d.Width;
      DlgInfo[3].Rect.Top := 0;
      DlgInfo[3].Rect.Bottom := Height;
      DlgInfo[3].Rect.Right := Width;
    end;

    d := g_WMain99Images.Images[2160];
    if d <> nil then begin
      DlgInfo[4].WMImages := g_WMain99Images;
      DlgInfo[4].Index := 2160;
      DlgInfo[4].Rect.Left := 0;
      DlgInfo[4].Rect.Top := 0;
    end;
    d := g_WMain99Images.Images[2182];
    if d <> nil then begin
      DlgInfo[5].WMImages := g_WMain99Images;
      DlgInfo[5].Index := 2182;
      DlgInfo[5].Rect.Left := Width - d.Width;
      DlgInfo[5].Rect.Top := 0;
    end;
    d := g_WMain99Images.Images[2180];
    if d <> nil then begin
      DlgInfo[6].WMImages := g_WMain99Images;
      DlgInfo[6].Index := 2180;
      DlgInfo[6].Rect.Left := 0;
      DlgInfo[6].Rect.Top := Height - d.Height;
    end;
    d := g_WMain99Images.Images[2182];
    if d <> nil then begin
      DlgInfo[7].WMImages := g_WMain99Images;
      DlgInfo[7].Index := 2182;
      DlgInfo[7].Rect.Left := Width - d.Width;
      DlgInfo[7].Rect.Top := Height - d.Height;
    end;
{$ELSE}
    d := g_WMain99Images.Images[268];
    if d <> nil then begin
      DlgInfo[0].WMImages := g_WMain99Images;
      DlgInfo[0].Index := 268;
      DlgInfo[0].Rect.Left := 2;
      DlgInfo[0].Rect.Top := 0;
      DlgInfo[0].Rect.Bottom := d.Height;
      DlgInfo[0].Rect.Right := Width - 4;
    end;
    d := g_WMain99Images.Images[269];
    if d <> nil then begin
      DlgInfo[1].WMImages := g_WMain99Images;
      DlgInfo[1].Index := 269;
      DlgInfo[1].Rect.Left := 2;
      DlgInfo[1].Rect.Top := Height - d.Height;
      DlgInfo[1].Rect.Bottom := Height;
      DlgInfo[1].Rect.Right := Width - 4;
    end;
    d := g_WMain99Images.Images[270];
    if d <> nil then begin
      DlgInfo[2].WMImages := g_WMain99Images;
      DlgInfo[2].Index := 270;
      DlgInfo[2].Rect.Left := 0;
      DlgInfo[2].Rect.Top := 2;
      DlgInfo[2].Rect.Bottom := Height - 4;
      DlgInfo[2].Rect.Right := d.Width;
    end;
    d := g_WMain99Images.Images[271];
    if d <> nil then begin
      DlgInfo[3].WMImages := g_WMain99Images;
      DlgInfo[3].Index := 271;
      DlgInfo[3].Rect.Left := Width - d.Width;
      DlgInfo[3].Rect.Top := 2;
      DlgInfo[3].Rect.Bottom := Height - 4;
      DlgInfo[3].Rect.Right := Width;
    end;
    dc.Top := 0;
    dc.Left := 0;
    dc.Right := 11;
    dc.Bottom := 11;
    d := g_WMain99Images.Images[264];
    if d <> nil then begin
      DlgInfo[4].WMImages := g_WMain99Images;
      DlgInfo[4].Index := 264;
      DlgInfo[4].Rect.Left := 0;
      DlgInfo[4].Rect.Top := 0;
    end;
    d := g_WMain99Images.Images[266];
    if d <> nil then begin
      DlgInfo[5].WMImages := g_WMain99Images;
      DlgInfo[5].Index := 266;
      DlgInfo[5].Rect.Left := Width - dc.Right;
      DlgInfo[5].Rect.Top := 0;
    end;
    d := g_WMain99Images.Images[265];
    if d <> nil then begin
      DlgInfo[6].WMImages := g_WMain99Images;
      DlgInfo[6].Index := 265;
      DlgInfo[6].Rect.Left := 0;
      DlgInfo[6].Rect.Top := Height - dc.Bottom;
    end;
    d := g_WMain99Images.Images[267];
    if d <> nil then begin
      DlgInfo[7].WMImages := g_WMain99Images;
      DlgInfo[7].Index := 267;
      DlgInfo[7].Rect.Left := Width - dc.Right;
      DlgInfo[7].Rect.Top := Height - dc.Bottom;
    end;
{$IFEND}

  end;
end;

procedure TFrmDlg.DRenewChrClick(Sender: TObject; X, Y: Integer);
var
  lx, ly, idx: integer;
begin
  lx := DRenewChr.LocalX(X) - DRenewChr.Left;
  ly := DRenewChr.LocalY(Y) - DRenewChr.Top;
{$IF Var_Interface = Var_Mir2}
  if (lx >= 24) and (lX <= 244) and (lY >= 124) and (lY <= (208 + 124)) then begin
    idx := (lY - 124) div 16;
    if idx in [Low(SelectChrScene.RenewChr)..high(SelectChrScene.RenewChr)] then begin
      if SelectChrScene.RenewChr[idx].Name <> '' then begin
        PlaySound(s_glass_button_click);
        RenewChrIdx := idx + 1;
      end;
      exit;
    end;
  end;
{$ELSE}
  if (lx >= 25) and (lX <= 245) and (lY >= 75) and (lY <= 347) then begin
    idx := (lY - 75) div 16;
    if idx in [Low(SelectChrScene.RenewChr)..high(SelectChrScene.RenewChr)] then begin
      if SelectChrScene.RenewChr[idx].Name <> '' then begin
        PlaySound(s_glass_button_click);
        RenewChrIdx := idx + 1;
      end;
      exit;
    end;
  end;
{$IFEND}

  RenewChrIdx := 0;
end;

procedure TFrmDlg.DRenewChrDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  sMan: string;
  I: integer;
  FontColor: TColor;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    with SelectChrScene do begin
{$IF Var_Interface = Var_Mir2}
      for I := Low(RenewChr) to _MIN(high(RenewChr), 12) do begin
        if RenewChr[I].Name <> '' then begin
          with g_DXCanvas do begin
            //SetBkMode(Handle, TRANSPARENT);
            if I = RenewChrIdx - 1 then FontColor := $82FF
            else FontColor := clWhite;
            TextOut(ax + 26, ay + 126 + I * 16, RenewChr[I].Name, FontColor);
            sMan := IntToStr(RenewChr[I].Level);
            TextOut(ax + 136 - TextWidth(sMan) div 2, ay + 126 + I * 16, sMan, FontColor);
            sMan := GetJobName(RenewChr[I].Job);
            TextOut(ax + 181 - TextWidth(sMan) div 2, ay + 126 + I * 16, sMan, FontColor);
            TextOut(ax + 218, ay + 126 + I * 16, GetsexName(RenewChr[I].Sex), FontColor);
          end;
        end;
      end;
{$ELSE}
      for I := Low(RenewChr) to high(RenewChr) do begin
        if RenewChr[I].Name <> '' then begin
          with g_DXCanvas do begin
            //SetBkMode(Handle, TRANSPARENT);
            if I = RenewChrIdx - 1 then
              FontColor := $82FF
            else
              FontColor := $B5C79C;
            TextOut(ax + 25, ay + 75 + I * 16, RenewChr[I].Name, FontColor);
            TextOut(ax + 122, ay + 75 + I * 16, GetsexName(RenewChr[I].Sex), FontColor);
            sMan := GetJobName(RenewChr[I].Job);
            TextOut(ax + 166 - TextWidth(sMan) div 2, ay + 75 + I * 16, sMan, FontColor);
            sMan := IntToStr(RenewChr[I].Level);
            TextOut(ax + 205 - TextWidth(sMan) div 2, ay + 75 + I * 16, sMan, FontColor);
            if g_boCreateHumIsNew then
              sMan := GetWuXinname(RenewChr[I].WuXin)
            else
              sMan := '无';
            TextOut(ax + 255 - TextWidth(sMan) div 2, ay + 75 + I * 16, sMan, FontColor);
            //Release;
          end;
        end;
      end;
{$IFEND}

    end;
  end;
end;

procedure TFrmDlg.DropMovingItem;
begin
  if g_boItemMoving then begin
    if (g_MovingItem.ItemType = mtBagitem) and (g_MovingItem.Item.S.name <> '') then begin
      if CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoDrop) then begin
        AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
        g_MovingItem.Item.S.name := '';
        g_boItemMoving := False;
        DMessageDlg('该物品不允许丢弃！', []);
        exit;
      end;
      if CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_DropDestroy) then begin
        g_boItemMoving := False;
        if mrNo = DMessageDlg('该物品丢弃后直接消失\是否确定丢弃[' + g_MovingItem.Item.S.name + ']？', [mbYes, mbNo]) then begin
          AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
          g_MovingItem.Item.S.name := '';
        end
        else begin
          frmMain.SendDropItem(g_MovingItem.Item.S.name, g_MovingItem.Item.UserItem.MakeIndex);
          AddDropItem(g_MovingItem.Item);
          ClearMovingItem();
        end;
        exit;
      end;
      g_boItemMoving := False;
      if (g_boCancelDropItemHint and (not DDealDlg.Visible)) or (mrYes = DMessageDlg('是否确定丢弃[' + g_MovingItem.Item.S.name + ']？', [mbYes, mbNo])) then begin
        frmMain.SendDropItem(g_MovingItem.Item.S.name, g_MovingItem.Item.UserItem.MakeIndex);
        AddDropItem(g_MovingItem.Item);
      end
      else begin
        AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
      end;
    end;
    ClearMovingItem();
  end;
end;

procedure TFrmDlg.DSayMoveSize(Y: Integer);
var
  nCount: Integer;
begin
  if not DBTSayMove.Downed then
    exit;
  nCount := (g_FScreenHeight - Y - DBottom.Height - 39 + 13) div SAYLISTHEIGHT;
  if nCount < 3 then
    nCount := 3;
  if nCount > 29 then
    nCount := 29;

  DWndSay.Height := 2 + nCount * SAYLISTHEIGHT;
  DWndSay.Top := g_FScreenHeight - DWndSay.Height - DBottom.Height - 39;

  DBtnSayAll.Top := DWndSay.Height + 1;
  DBtnSayHear.Top := DWndSay.Height + 1;
  DBtnSayWhisper.Top := DWndSay.Height + 1;
  DBtnSayCry.Top := DWndSay.Height + 1;
  DBtnSayGroup.Top := DWndSay.Height + 1;
  DBtnSayGuild.Top := DWndSay.Height + 1;
  DBtnSaySys.Top := DWndSay.Height + 1;
  DBtnSayCustom.Top := DWndSay.Height + 1;
  dchkSayLock.Top := DWndSay.Height + 2;

  DBTSayLock.Top := DWndSay.Height + 19;
  DBTEdit.Top := DBTSayLock.Top;
  DSayUpDown.Height := DWndSay.Height - 15 + 18;
  DEditChat.Top := DBTEdit.Top + (DBTEdit.Height - 16) div 2;
  DBTFace.Top := DBTEdit.Top;
  DBTOption.Top := DBTEdit.Top;
  DBTTakeHorse.Top := DBTEdit.Top;
end;

procedure TFrmDlg.DscSelect1Click(Sender: TObject; X, Y: Integer);
begin
{$IF Var_Interface = Var_Mir2}
  if Sender = DscExit then
    FrmMain.Close;
{$ELSE}
  if Sender = DscExit then
    SelectChrScene.SelChrExitClick;
{$IFEND}

  if Sender = DscStart then
    SelectChrScene.SelChrStartClick;

  if (Sender = DccOk) or (Sender = DccOk2) then
    SelectChrScene.SelChrNewOk;
  if Sender = DccClose then
    SelectChrScene.SelChrNewClose;

  if Sender = DButRenewChr then
    SelectChrScene.SelRenewChr;
  if Sender = DButRenewClose then
    SelectChrScene.ChangeSelectChrState(scSelectChr);

  if Sender = DscSelect1 then
    SelectChrScene.SelChrSelect1Click;
  if Sender = DscSelect2 then
    SelectChrScene.SelChrSelect2Click;
  if Sender = DscSelect3 then
    SelectChrScene.SelChrSelect3Click;

  if Sender = DscNewChr then
    SelectChrScene.SelChrNewChrClick;
  if Sender = DscEraseChr then
    SelectChrScene.SelChrEraseChrClick;
  if Sender = DscCredits then
    SelectChrScene.SelChrCreditsClick;

  if (Sender = DccClose) or (Sender = DccClose2) then
    SelectChrScene.SelChrNewClose;

{$IF Var_Interface = Var_Mir2}
  if Sender = DccWarrior then begin
    btjob := 0;
    SelectChrScene.SelChrNewJob(0);
  end;
  if Sender = DccWizzard then begin
    btJob := 1;
    SelectChrScene.SelChrNewJob(1);
  end;
  if Sender = DccMonk then begin
    btJob := 2;
    SelectChrScene.SelChrNewJob(2);
  end;
  //if Sender = DccReserved then btJob := Random(3);
  if Sender = DccMale then begin
    btSex := 0;
    SelectChrScene.SelChrNewm_btSex(0);
  end;

  if Sender = DccFemale then begin
    btSex := 1;
    SelectChrScene.SelChrNewm_btSex(1);
  end;
{$ELSE}
  if Sender = DccWarrior then
    btjob := 0;
  if Sender = DccWizzard then
    btJob := 1;
  if Sender = DccMonk then
    btJob := 2;
  //if Sender = DccReserved then btJob := Random(3);
  if Sender = DccMale then
    btSex := 0;
  if Sender = DccFemale then
    btSex := 1;
{$IFEND}


  if Sender = DccJ then
    btWuXin := 0;
  if Sender = DccM then
    btWuXin := 1;
  if Sender = DccS then
    btWuXin := 2;
  if Sender = DccH then
    btWuXin := 3;
  if Sender = DccT then
    btWuXin := 4;

  if Sender = DccManWarrior then begin
    btjob := 0;
    btSex := 0;
  end;
  if Sender = DccManWizzard then begin
    btjob := 1;
    btSex := 0;
  end;
  if Sender = DccManMonk then begin
    btjob := 2;
    btSex := 0;
  end;
  if Sender = DccWoManWarrior then begin
    btjob := 0;
    btSex := 1;
  end;
  if Sender = DccWoManWizzard then begin
    btjob := 1;
    btSex := 1;
  end;
  if Sender = DccWoManMonk then begin
    btjob := 2;
    btSex := 1;
  end;
end;

procedure TFrmDlg.DStateWinDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  if g_MySelf = nil then
    exit;

  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      DrawWindow(DSurface, ax, ay, d);
      //Surface.Fill(0);
      //Surface.Draw(0, 0, d.ClientRect, d, True);

{$IF Var_Interface = Var_Mir2}
      d := WLib.Images[1776 + StatePage];
      if d <> nil then
        DrawWindow(DSurface, ax + 16, ay + 90, d);
{$ELSE}
      d := WLib.Images[246 + StatePage];
      if d <> nil then
        DrawWindow(DSurface, ax + 8, ay + 37, d);  
{$IFEND}

      //Surface.Draw(8, 37, d.ClientRect, d, True);
      //DrawWindow(DSurface, ax, ay, Surface);
    end;
    with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
      TextOut(ax + Width div 2 - TextWidth(g_MySelf.m_UserName) div 2, ay + 17 + 28, $B1D2B7, g_MySelf.m_UserName);
{$ELSE}
      TextOut(ax + Width div 2 - TextWidth(g_MySelf.m_UserName) div 2, ay + 12{ + 28}, $B1D2B7, g_MySelf.m_UserName);
{$IFEND}

    end;
  end;
end;

procedure TFrmDlg.DStateWinItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
const
  nWidth = 100;
  nHeight = 120;
var
  d: TDXTexture;
  ax, ay, bbx, bby, idx: integer;
  Rect: TRect;
  NakedAddAbil: TNakedAddAbil;
  TempNakedAbil: TNakedAbil;
  FontColor: TColor;
  MagicList: TStringList;
  boShow: Boolean;
  AddAbility: TAddAbility;
  I: Integer;
  StdItem: TStdItem;
  str: string;
begin
  if g_MySelf = nil then
    exit;

  with Sender as TDWindow do begin
    ax := SurfaceX(Left) - Left;
    ay := SurfaceY(Top) - Top;
    if Sender = DStateWinState then begin
{$IF Var_Interface = Var_Mir2}
      with g_DXCanvas do begin
        FontColor := clWhite;
        Inc(ax, Left);
        Inc(ay, Top);
        TextOut(ax + 100, ay + 10, GetJobName(g_MySelf.m_btJob), FontColor); //职业
        TextOut(ax + 100, ay + 26, IntToStr(g_MySelf.m_Abil.Level), FontColor); //人物等级
        TextOut(ax + 100, ay + 42, IntToStr(g_MySelf.m_Abil.Exp), FontColor); //经验
        TextOut(ax + 100, ay + 58, IntToStr(g_MySelf.m_Abil.MaxExp), FontColor); //经验

        if g_MySelf.m_Abil.WearWeight > g_MySelf.m_Abil.MaxWearWeight then FontColor := clRed;
        TextOut(ax + 27, ay + 90, '负重', $C5C2C5);
        TextOut(ax + 100, ay + 90, IntToStr(g_MySelf.m_Abil.WearWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWearWeight), FontColor); //负重

        FontColor := clWhite;
        if g_MySelf.m_Abil.HandWeight > g_MySelf.m_Abil.MaxHandWeight then FontColor := clRed;
        TextOut(ax + 27, ay + 90 + 1 * 16, '腕力', $C5C2C5);
        TextOut(ax + 100, ay + 90 + 1 * 16, IntToStr(g_MySelf.m_Abil.HandWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxHandWeight), FontColor); //腕力

        FontColor := clWhite;
        if g_nPkPoint >= 200 then FontColor := clRed
        else if g_nPkPoint >= 100 then FontColor := clyellow;
        TextOut(ax + 27, ay + 90 + 2 * 16, 'PK值', $C5C2C5);
        TextOut(ax + 100, ay + 90 + 2 * 16, IntToStr(g_nPkPoint), FontColor);

        FontColor := clWhite;
        TextOut(ax + 27, ay + 90 + 3 * 16, '声望', $C5C2C5);
        TextOut(ax + 100, ay + 90 + 3 * 16, IntToStr(g_nCreditPoint), FontColor);

        TextOut(ax + 27, ay + 90 + 4 * 16, '文采', $C5C2C5);
        TextOut(ax + 100, ay + 90 + 4 * 16, IntToStr(g_nLiterary), FontColor);

        TextOut(ax + 27, ay + 90 + 5 * 16, '修练', $C5C2C5);
        TextOut(ax + 100, ay + 90 + 5 * 16, IntToStr(g_nGameGird), FontColor);
      end;
{$IFEND}
    end else
    if Sender = DStateWinItem then begin
{$IF Var_Interface = Var_Mir2}
      d := g_WMain99Images.Images[236 + Integer(g_MySelf.m_btSex = 1)];
      if d <> nil then
        dsurface.Draw(ax + 99 + 1, ay + 117 + 29, d.ClientRect, d, True);

      bbx := left + 37;
      bby := Top + 55;
{$ELSE}
      d := g_WMain99Images.Images[236 + Integer(g_MySelf.m_btSex = 1)];
      if d <> nil then
        dsurface.Draw(ax + 245 - 146, ay + 145 - 28, d.ClientRect, d, True);

      bbx := left + 44;
      bby := Top + 89 - 10;
{$IFEND}
      if g_UseItems[U_DRESS].S.name <> '' then begin
        idx := g_UseItems[U_DRESS].S.looks;
        if idx >= 0 then begin
          d := GetStateItemImgXY(idx, ax, ay);
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);

          if g_UseItems[U_DRESS].S.AniCount = 29 then begin
            d := GetStateItemImgXY(2425, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_DRESS].S.AniCount = 30 then begin
            d := GetStateItemImgXY(2426, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_DRESS].S.AniCount = 33 then begin
            d := GetStateItemImgXY(2541, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_DRESS].S.AniCount = 34 then begin
            d := GetStateItemImgXY(2543, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_DRESS].S.AniCount = 42 then begin
            d := GetStateItemImgXY(2600 + Integer((GetTickCount - AppendTick) div 200 mod 20), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end;
        end;
      end;

      idx := HUMHAIRANFRAME * (g_MySelf.m_btHair + 1) - 1;
      if idx > 0 then begin
        d := g_WHairImgImages.GetCachedImage(idx, ax, ay);
        if d <> nil then
          dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
      end;

      if g_UseItems[U_WEAPON].S.name <> '' then begin
        idx := g_UseItems[U_WEAPON].S.looks;
        if idx >= 0 then begin
          d := GetStateItemImgXY(idx, ax, ay);
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);

          if g_UseItems[U_WEAPON].S.AniCount = 21 then begin
            d := g_WMain99Images.GetCachedImage(1438, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_WEAPON].S.AniCount = 23 then begin
            d := GetStateItemImgXY(1890 + Integer((GetTickCount - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_WEAPON].S.AniCount = 31 then begin
            d := GetStateItemImgXY(2427, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_WEAPON].S.AniCount = 35 then begin
            d := GetStateItemImgXY(2530 + Integer((GetTickCount - AppendTick) div 200 mod 8), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_WEAPON].S.AniCount = 37 then begin
            d := GetStateItemImgXY(2550 + Integer((GetTickCount - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_WEAPON].S.AniCount = 39 then begin
            d := GetStateItemImgXY(2560 + Integer((GetTickCount - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end;
        end;

      end;
      if not CheckIntStatus(g_nGameSetupData, GSP_HIDEHELMET) then begin
        if g_UseItems[U_HELMET].S.name <> '' then begin
          idx := g_UseItems[U_HELMET].S.looks;
          if idx >= 0 then begin
            d := GetStateItemImgXY(idx, ax, ay);
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
          end;
        end;
      end;
      //      bbx := Left  + 233;
      //      bby := Top  + 3;
            {idx := (GetTickCount - AppendTick) div 150 mod 10;
            d := g_WMain99Images.GetCachedImage(534 + (g_MySelf.m_btWuXinLevel div 10 * 20) + idx, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);  }

      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
{$IF Var_Interface = Var_Mir2}
        if (MouseEntry = msin) and (boSelectGuildName) then
          FontColor := clSilver
        else
          FontColor := clWhite;

        TextOut(SurfaceX(Left) + 2, SurfaceY(Top) + 2, g_MySelf.m_sGuildName, FontColor);
        nGuildNameLen := TextWidth(g_MySelf.m_sGuildName);
        if (MouseEntry = msin) and (boSelectGuildRankName) then
          FontColor := clSilver
        else
          FontColor := clWhite;
        TextOut(SurfaceX(Left) + 2, SurfaceY(Top) + 16, g_MySelf.m_sGuildRankName, FontColor);
        nGuildRankNameLen := TextWidth(g_MySelf.m_sGuildRankName);
{$ELSE}
        if (MouseEntry = msin) and (boSelectGuildName) then
          FontColor := clSilver
        else
          FontColor := clWhite;

        TextOut(SurfaceX(50), SurfaceY(45), g_MySelf.m_sGuildName, FontColor);
        nGuildNameLen := TextWidth(g_MySelf.m_sGuildName);
        if (MouseEntry = msin) and (boSelectGuildRankName) then
          FontColor := clSilver
        else
          FontColor := clWhite;
        TextOut(SurfaceX(50), SurfaceY(60), g_MySelf.m_sGuildRankName, FontColor);
        nGuildRankNameLen := TextWidth(g_MySelf.m_sGuildRankName);
{$IFEND}

{$IF Var_Interface = Var_Default}
        FontColor := clWhite;
        TextOut(SurfaceX(52), SurfaceY(326), IntToStr(g_MySelf.m_Abil.Level), FontColor); //人物等级
        TextOut(SurfaceX(52), SurfaceY(341),
          IntToStr(Loword(g_MySelf.m_Abil.AC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.AC)), FontColor);
        TextOut(SurfaceX(52), SurfaceY(356),
          IntToStr(Loword(g_MySelf.m_Abil.MAC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.MAC)), FontColor);

        TextOut(SurfaceX(181), SurfaceY(326),
          IntToStr(Loword(g_MySelf.m_Abil.DC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.DC)), FontColor);
        TextOut(SurfaceX(181), SurfaceY(341),
          IntToStr(Loword(g_MySelf.m_Abil.MC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.MC)), FontColor);
        TextOut(SurfaceX(181), SurfaceY(356),
          IntToStr(Loword(g_MySelf.m_Abil.SC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.SC)), FontColor);
{$IFEND}
        //Release;
      end;
    end
    else if Sender = DStateWinAbil then begin
{$IF Var_Interface = Var_Mir2}
      SafeFillChar(TempNakedAbil, SizeOf(TempNakedAbil), #0);
      if g_nNakedBackCount > 0 then begin
        TempNakedAbil.nAc := g_ClientNakedInfo.NakedAbil.nAc - NakedAbil.nAC;
        TempNakedAbil.nMAc := g_ClientNakedInfo.NakedAbil.nMAc - NakedAbil.nMAc;
        TempNakedAbil.nDc := g_ClientNakedInfo.NakedAbil.nDc - NakedAbil.nDc;
        TempNakedAbil.nMc := g_ClientNakedInfo.NakedAbil.nMc - NakedAbil.nMc;
        TempNakedAbil.nSc := g_ClientNakedInfo.NakedAbil.nSc - NakedAbil.nSc;
        TempNakedAbil.nHP := g_ClientNakedInfo.NakedAbil.nHP - NakedAbil.nHP;
      end
      else begin
        TempNakedAbil.nAc := g_ClientNakedInfo.NakedAbil.nAc + NakedAbil.nAC;
        TempNakedAbil.nMAc := g_ClientNakedInfo.NakedAbil.nMAc + NakedAbil.nMAc;
        TempNakedAbil.nDc := g_ClientNakedInfo.NakedAbil.nDc + NakedAbil.nDc;
        TempNakedAbil.nMc := g_ClientNakedInfo.NakedAbil.nMc + NakedAbil.nMc;
        TempNakedAbil.nSc := g_ClientNakedInfo.NakedAbil.nSc + NakedAbil.nSc;
        TempNakedAbil.nHP := g_ClientNakedInfo.NakedAbil.nHP + NakedAbil.nHP;
      end;
      GetNakedAbilitys(@NakedAddAbil, @TempNakedAbil, @g_ClientNakedInfo.NakedAddInfo);
      with g_DXCanvas do begin
        FontColor := clWhite;

        TextOut(ax + 67, ay + 101,
          IntToStr(Loword(g_MySelf.m_Abil.AC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.AC)), FontColor);
        TextOut(ax + 67, ay + 117,
          IntToStr(Loword(g_MySelf.m_Abil.MAC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.MAC)), FontColor);

        TextOut(ax + 67, ay + 133,
          IntToStr(Loword(g_MySelf.m_Abil.DC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.DC)), FontColor);
        TextOut(ax + 67, ay + 149,
          IntToStr(Loword(g_MySelf.m_Abil.MC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.MC)), FontColor);
        TextOut(ax + 67, ay + 165,
          IntToStr(Loword(g_MySelf.m_Abil.SC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.SC)), FontColor);

        TextOut(ax + 67, ay + 181, IntToStr(g_nMyHitPoint), FontColor); //准确
        TextOut(ax + 67, ay + 197, IntToStr(g_nMySpeedPoint), FontColor); //敏捷

        TextOut(ax + 222, ay + 101, '+' + IntToStr(g_nMyAddAttack) + '%', FontColor); //攻击加成
        TextOut(ax + 222, ay + 101 + 1 * 14, '+' + IntToStr(g_nMyDelDamage) + '%', FontColor); //伤害吸收
        TextOut(ax + 222, ay + 101 + 2 * 14, '+' + IntToStr(g_nDeadliness) + '%', FontColor); //致命一击

        TextOut(ax + 222, ay + 101 + 3 * 14, '+' + IntToStr(g_nMyAntiMagic * 10) + '%', FontColor); //魔法躲避
        TextOut(ax + 222, ay + 101 + 4 * 14, '+' + IntToStr(g_nMyAntiPoison * 10) + '%', FontColor); //毒物躲避
        TextOut(ax + 222, ay + 101 + 5 * 14, '+' + IntToStr(g_nMyPoisonRecover * 10) + '%', FontColor); //中毒恢复
        TextOut(ax + 222, ay + 101 + 6 * 14, '+' + IntToStr(g_nMyHealthRecover * 10) + '%', FontColor); //体力恢复
        TextOut(ax + 222, ay + 101 + 7 * 14, '+' + IntToStr(g_nMySpellRecover * 10) + '%', FontColor); //魔法恢复

        if NakedBackCount > 0 then
          TextOut(ax + 110, ay + 230, IntToStr(NakedCount + (g_nNakedBackCount - NakedBackCount)) + '/' + IntToStr(NakedBackCount), FontColor)
        else
          TextOut(ax + 110, ay + 230, IntToStr(NakedCount + (g_nNakedBackCount - NakedBackCount)), FontColor); //分配点数

        if g_nNakedBackCount > 0 then begin
          TextOut(ax + 72, ay + 249, IntToStr(g_ClientNakedInfo.NakedAbil.nAc - NakedAbil.nAc), FontColor); //体质
          TextOut(ax + 72, ay + 265, IntToStr(g_ClientNakedInfo.NakedAbil.nMAc - NakedAbil.nMac), FontColor); //身法
          TextOut(ax + 72, ay + 281, IntToStr(g_ClientNakedInfo.NakedAbil.nDc - NakedAbil.nDC), FontColor); //力量
          TextOut(ax + 72, ay + 297, IntToStr(g_ClientNakedInfo.NakedAbil.nMc - NakedAbil.nMC), FontColor); //智力
          TextOut(ax + 72, ay + 313, IntToStr(g_ClientNakedInfo.NakedAbil.nSc - NakedAbil.nSC), FontColor); //精神
          TextOut(ax + 72, ay + 329, IntToStr(g_ClientNakedInfo.NakedAbil.nHP - NakedAbil.nHP), FontColor); //体力

        end
        else begin
          TextOut(ax + 72, ay + 249, IntToStr(g_ClientNakedInfo.NakedAbil.nAc + NakedAbil.nAc), FontColor); //体质
          TextOut(ax + 72, ay + 265, IntToStr(g_ClientNakedInfo.NakedAbil.nMAc + NakedAbil.nMac), FontColor); //身法
          TextOut(ax + 72, ay + 281, IntToStr(g_ClientNakedInfo.NakedAbil.nDc + NakedAbil.nDC), FontColor); //力量
          TextOut(ax + 72, ay + 297, IntToStr(g_ClientNakedInfo.NakedAbil.nMc + NakedAbil.nMC), FontColor); //智力
          TextOut(ax + 72, ay + 313, IntToStr(g_ClientNakedInfo.NakedAbil.nSc + NakedAbil.nSC), FontColor); //精神
          TextOut(ax + 72, ay + 329, IntToStr(g_ClientNakedInfo.NakedAbil.nHP + NakedAbil.nHP), FontColor); //体力

        end;
        TextOut(ax + 202, ay + 249,
          IntToStr({Loword(g_MySelf.m_Abil.AC) + }NakedAddAbil.nAc { + g_ClientNakedAddAbil.nAc}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.AC) + }NakedAddAbil.nAc2 { + g_ClientNakedAddAbil.nAc2}), FontColor); //物防
        TextOut(ax + 202, ay + 265,
          IntToStr({Loword(g_MySelf.m_Abil.MAC) + }NakedAddAbil.nMac { + g_ClientNakedAddAbil.nMac}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.MAC) + }NakedAddAbil.nMac2 { + g_ClientNakedAddAbil.nMac2}), FontColor);
        TextOut(ax + 202, ay + 281,
          IntToStr({Loword(g_MySelf.m_Abil.DC) + }NakedAddAbil.nDc { + g_ClientNakedAddAbil.nDC}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.DC) + }NakedAddAbil.nDC2 { + g_ClientNakedAddAbil.nDC2}), FontColor);
        TextOut(ax + 202, ay + 297,
          IntToStr({Loword(g_MySelf.m_Abil.MC) +}NakedAddAbil.nMC { + g_ClientNakedAddAbil.nMC}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.MC) +}NakedAddAbil.nMc2 { + g_ClientNakedAddAbil.nMc2}), FontColor);
        TextOut(ax + 202, ay + 313,
          IntToStr({Loword(g_MySelf.m_Abil.SC) +}NakedAddAbil.nSC { + g_ClientNakedAddAbil.nSc}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.SC) +}NakedAddAbil.nSC2 {+ g_ClientNakedAddAbil.nSC2}), FontColor);
        TextOut(ax + 202, ay + 329, IntToStr({g_MySelf.m_Abil.MaxHP + }NakedAddAbil.nHP {+ g_ClientNakedAddAbil.nHP}), FontColor);
      end;
{$ELSE}
      SafeFillChar(TempNakedAbil, SizeOf(TempNakedAbil), #0);
      if g_nNakedBackCount > 0 then begin
        TempNakedAbil.nAc := g_ClientNakedInfo.NakedAbil.nAc - NakedAbil.nAC;
        TempNakedAbil.nMAc := g_ClientNakedInfo.NakedAbil.nMAc - NakedAbil.nMAc;
        TempNakedAbil.nDc := g_ClientNakedInfo.NakedAbil.nDc - NakedAbil.nDc;
        TempNakedAbil.nMc := g_ClientNakedInfo.NakedAbil.nMc - NakedAbil.nMc;
        TempNakedAbil.nSc := g_ClientNakedInfo.NakedAbil.nSc - NakedAbil.nSc;
        TempNakedAbil.nHP := g_ClientNakedInfo.NakedAbil.nHP - NakedAbil.nHP;
      end
      else begin
        TempNakedAbil.nAc := g_ClientNakedInfo.NakedAbil.nAc + NakedAbil.nAC;
        TempNakedAbil.nMAc := g_ClientNakedInfo.NakedAbil.nMAc + NakedAbil.nMAc;
        TempNakedAbil.nDc := g_ClientNakedInfo.NakedAbil.nDc + NakedAbil.nDc;
        TempNakedAbil.nMc := g_ClientNakedInfo.NakedAbil.nMc + NakedAbil.nMc;
        TempNakedAbil.nSc := g_ClientNakedInfo.NakedAbil.nSc + NakedAbil.nSc;
        TempNakedAbil.nHP := g_ClientNakedInfo.NakedAbil.nHP + NakedAbil.nHP;
      end;
      GetNakedAbilitys(@NakedAddAbil, @TempNakedAbil, @g_ClientNakedInfo.NakedAddInfo);
      with g_DXCanvas do begin
        if g_boUseWuXin then begin
          FontColor := GetWuXinColor(g_MySelf.m_btWuXin);
          TextOut(ax + 49, ay + 45, GetWuxinName(g_MySelf.m_btWuXin), FontColor); //五行属性
        end else begin
          FontColor := clWhite;
          TextOut(ax + 49, ay + 45, '无效', FontColor); //五行属性
        end;
        FontColor := clWhite;
        TextOut(ax + 49, ay + 63, IntToStr(g_nGameDiamond), FontColor); //贡献值
        if g_nPkPoint >= 200 then
          FontColor := clRed
        else if g_nPkPoint >= 100 then
          FontColor := clyellow;
        TextOut(ax + 49, ay + 81, IntToStr(g_nPkPoint), FontColor); //PK值

        //FontColor := clyellow;

        FontColor := clWhite;

        TextOut(ax + 49, ay + 99, IntToStr(g_nCreditPoint), FontColor); //声望值

        //TextOut(ax + 66, ay + 99, IntToStr(g_nGameGird), FontColor);  //灵符

        TextOut(ax + 137, ay + 45, IntToStr(g_nMyHitPoint), FontColor); //准确
        TextOut(ax + 137, ay + 63, IntToStr(g_nMySpeedPoint), FontColor); //敏捷

        if g_MySelf.m_Abil.WearWeight > g_MySelf.m_Abil.MaxWearWeight then
          FontColor := clRed;
        TextOut(ax + 137, ay + 81,
          IntToStr(g_MySelf.m_Abil.WearWeight) + '/'
          + IntToStr(g_MySelf.m_Abil.MaxWearWeight), FontColor); //负重

        if g_MySelf.m_Abil.HandWeight > g_MySelf.m_Abil.MaxHandWeight then
          FontColor := clRed
        else
          FontColor := clWhite;
        TextOut(ax + 137, ay + 99,
          IntToStr(g_MySelf.m_Abil.HandWeight) + '/'
          + IntToStr(g_MySelf.m_Abil.MaxHandWeight), FontColor); //腕力

        FontColor := clWhite;
        TextOut(ax + 225, ay + 45, IntToStr(g_nLiterary), FontColor); //文采
        TextOut(ax + 225, ay + 63, IntToStr(g_nGameGird), FontColor); //修练

        //Font.Color := GetWuXinColor(g_MySelf.m_btWuXin);
        //TextOut(ax + 66 + 141, ay + 45, GetWuxinName(g_MySelf.m_btWuXin)); //五行属性
        //Font.Color := clWhite;
        {TextOut(ax + 66 + 141, ay + 61, IntToStr(g_MySelf.m_btWuXinLevel)); //五行等级
        TextOut(ax + 66 + 141, ay + 77,
          IntToStr(g_MySelf.m_dwWuXinExp div 60000) + '/' +
          IntToStr(g_MySelf.m_dwWuXinMaxExp div 60000)); //五行经验   }
        if g_boUseWuXin then begin
          TextOut(ax + 66 + 10, ay + 134, '+' + IntToStr(g_nMyAddWuXinAttack) + '%', FontColor); //五行攻击
          TextOut(ax + 66 + 10, ay + 152, '+' + IntToStr(g_nMyDelWuXInAttack) + '%', FontColor); //五行防御
        end else begin
          TextOut(ax + 66 + 10, ay + 134, '无效', FontColor); //五行攻击
          TextOut(ax + 66 + 10, ay + 152, '无效', FontColor); //五行防御
        end;

        TextOut(ax + 66 + 10, ay + 170, '+' + IntToStr(g_nMyAddAttack) + '%', FontColor); //攻击加成
        TextOut(ax + 66 + 10, ay + 188, '+' + IntToStr(g_nMyDelDamage) + '%', FontColor); //伤害吸收
        TextOut(ax + 66 + 10, ay + 206, '+' + IntToStr(g_nDeadliness) + '%', FontColor); //致命一击

        TextOut(ax + 66 + 141, ay + 134, '+' + IntToStr(g_nMyAntiMagic * 10) + '%', FontColor); //魔法躲避
        TextOut(ax + 66 + 141, ay + 152, '+' + IntToStr(g_nMyAntiPoison * 10) + '%', FontColor); //毒物躲避
        TextOut(ax + 66 + 141, ay + 170, '+' + IntToStr(g_nMyPoisonRecover * 10) + '%', FontColor); //中毒恢复
        TextOut(ax + 66 + 141, ay + 188, '+' + IntToStr(g_nMyHealthRecover * 10) + '%', FontColor); //体力恢复
        TextOut(ax + 66 + 141, ay + 206, '+' + IntToStr(g_nMySpellRecover * 10) + '%', FontColor); //魔法恢复

        if NakedBackCount > 0 then
          TextOut(ax + 101, ay + 242, IntToStr(NakedCount + (g_nNakedBackCount - NakedBackCount)) + '/' + IntToStr(NakedBackCount), FontColor)
        else
          TextOut(ax + 101, ay + 242, IntToStr(NakedCount + (g_nNakedBackCount - NakedBackCount)), FontColor); //分配点数

        if g_nNakedBackCount > 0 then begin
          TextOut(ax + 66, ay + 265, IntToStr(g_ClientNakedInfo.NakedAbil.nAc - NakedAbil.nAc), FontColor); //体质
          TextOut(ax + 66, ay + 283, IntToStr(g_ClientNakedInfo.NakedAbil.nMAc - NakedAbil.nMac), FontColor); //身法
          TextOut(ax + 66, ay + 301, IntToStr(g_ClientNakedInfo.NakedAbil.nDc - NakedAbil.nDC), FontColor); //力量
          TextOut(ax + 66, ay + 319, IntToStr(g_ClientNakedInfo.NakedAbil.nMc - NakedAbil.nMC), FontColor); //智力
          TextOut(ax + 66, ay + 337, IntToStr(g_ClientNakedInfo.NakedAbil.nSc - NakedAbil.nSC), FontColor); //精神
          TextOut(ax + 66, ay + 355, IntToStr(g_ClientNakedInfo.NakedAbil.nHP - NakedAbil.nHP), FontColor); //体力

        end
        else begin
          TextOut(ax + 66, ay + 265, IntToStr(g_ClientNakedInfo.NakedAbil.nAc + NakedAbil.nAc), FontColor); //体质
          TextOut(ax + 66, ay + 283, IntToStr(g_ClientNakedInfo.NakedAbil.nMAc + NakedAbil.nMac), FontColor); //身法
          TextOut(ax + 66, ay + 301, IntToStr(g_ClientNakedInfo.NakedAbil.nDc + NakedAbil.nDC), FontColor); //力量
          TextOut(ax + 66, ay + 319, IntToStr(g_ClientNakedInfo.NakedAbil.nMc + NakedAbil.nMC), FontColor); //智力
          TextOut(ax + 66, ay + 337, IntToStr(g_ClientNakedInfo.NakedAbil.nSc + NakedAbil.nSC), FontColor); //精神
          TextOut(ax + 66, ay + 355, IntToStr(g_ClientNakedInfo.NakedAbil.nHP + NakedAbil.nHP), FontColor); //体力

        end;
        TextOut(ax + 197, ay + 265,
          IntToStr({Loword(g_MySelf.m_Abil.AC) + }NakedAddAbil.nAc { + g_ClientNakedAddAbil.nAc}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.AC) + }NakedAddAbil.nAc2 { + g_ClientNakedAddAbil.nAc2}), FontColor); //物防
        TextOut(ax + 197, ay + 283,
          IntToStr({Loword(g_MySelf.m_Abil.MAC) + }NakedAddAbil.nMac { + g_ClientNakedAddAbil.nMac}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.MAC) + }NakedAddAbil.nMac2 { + g_ClientNakedAddAbil.nMac2}), FontColor);
        TextOut(ax + 197, ay + 301,
          IntToStr({Loword(g_MySelf.m_Abil.DC) + }NakedAddAbil.nDc { + g_ClientNakedAddAbil.nDC}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.DC) + }NakedAddAbil.nDC2 { + g_ClientNakedAddAbil.nDC2}), FontColor);
        TextOut(ax + 197, ay + 319,
          IntToStr({Loword(g_MySelf.m_Abil.MC) +}NakedAddAbil.nMC { + g_ClientNakedAddAbil.nMC}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.MC) +}NakedAddAbil.nMc2 { + g_ClientNakedAddAbil.nMc2}), FontColor);
        TextOut(ax + 197, ay + 337,
          IntToStr({Loword(g_MySelf.m_Abil.SC) +}NakedAddAbil.nSC { + g_ClientNakedAddAbil.nSc}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.SC) +}NakedAddAbil.nSC2 {+ g_ClientNakedAddAbil.nSC2}), FontColor);
        TextOut(ax + 197, ay + 355, IntToStr({g_MySelf.m_Abil.MaxHP + }NakedAddAbil.nHP {+ g_ClientNakedAddAbil.nHP}), FontColor);

        TextOut(ax + 16, ay + 45, $99FFFF, '五行:'); //五行名称
        TextOut(ax + 16, ay + 63, $99FFFF, g_sGameDiamondName + ':'); //灵符名称
        TextOut(ax + 16, ay + 206, $99FFFF, '致命一击:');

        TextOut(ax + 192, ay + 45, $99FFFF, '文采:'); //五行名称
        TextOut(ax + 192, ay + 63, $99FFFF, '修练:'); //灵符名称
        //Release;
      end;  
{$IFEND}

    end
    else if Sender = DStateWinInfo then begin
      if MyHDInfoSurface <> nil then begin
        DStateInfoRefPic.Enabled := False;
        Rect.Left := 0;

{$IF Var_Interface = Var_Mir2}
        ax := ax + Left + 16;
        aY := aY + Top + 7;
{$ELSE}
        ax := ax + 28;
        aY := aY + 74;  
{$IFEND}
        
        if MyHDInfoSurface.Width < nWidth then begin
          ax := ax + (nWidth - MyHDInfoSurface.Width) div 2;
          Rect.Right := MyHDInfoSurface.Width;
        end
        else begin
          Rect.Right := nWidth;
        end;
        Rect.Top := 0;
        if MyHDInfoSurface.Height < nHeight then begin
          aY := aY + (nHeight - MyHDInfoSurface.Height) div 2;
          Rect.Bottom := MyHDInfoSurface.Height;
        end
        else begin
          Rect.Bottom := nHeight;
        end;
        dsurface.Draw(aX, aY, Rect, MyHDInfoSurface, False);
      end
      else begin
        d := g_WMain99Images.Images[252 + Integer(g_UserRealityInfo.sPhotoID <> '')];
        if d <> nil then
{$IF Var_Interface = Var_Mir2}
          dsurface.Draw(ax + Left + 16, ay + Top + 7, d.ClientRect, d, True);
{$ELSE}
          dsurface.Draw(ax + 28, ay + 74, d.ClientRect, d, True);  
{$IFEND}

        if g_UserRealityInfo.sPhotoID <> '' then
          DStateInfoRefPic.Enabled := True
        else
          DStateInfoRefPic.Enabled := False;
      end;
    end
    else if Sender = DStateWinMagic then begin
{$IF Var_Interface = Var_Mir2}
      DMagicCBOSetup.Visible := DMagicIndex = 1;
      DMagicCBOSetup.Enabled := not DStateWinMagicCbo.Visible;
      DMagicSub.Visible := False;
      DMakeMagicAdd1.Visible := False;
      DMakeMagicAdd2.Visible := False;
      DMakeMagicAdd3.Visible := False;
      DMakeMagicAdd4.Visible := False;
      DMakeMagicAdd5.Visible := False;
      DMakeMagicAdd6.Visible := False;
      DMakeMagicAdd7.Visible := False;
      DMakeMagicAdd8.Visible := False;
      DMakeMagicAdd9.Visible := False;
      DMakeMagicAdd10.Visible := False;
      case DMagicIndex of
        0: MagicList := MagicList1;
        1: MagicList := MagicList2;
      else exit;
      end;
      MagicMaxPage := MagicList.Count div 5;
      if MagicList.Count > (MagicMaxPage * 5) then
        Inc(MagicMaxPage);
      Dec(MagicMaxPage);
      if MagicPage > MagicMaxPage then
        MagicPage := MagicMaxPage;
      DMagicFront.Enabled := True;
      DMagicNext.Enabled := True;
      if MagicMaxPage = 0 then begin
        DMagicFront.Enabled := False;
        DMagicNext.Enabled := False;
      end
      else if MagicPage = 0 then begin
        DMagicFront.Enabled := False;
      end
      else if MagicPage = MagicMaxPage then begin
        DMagicNext.Enabled := False;
      end;
{$ELSE}
      DMagicCBOSetup.Visible := DMagicIndex = 1;
      DMagicCBOSetup.Enabled := not DStateWinMagicCbo.Visible;
      boShow := (DMagicIndex = 2) and (g_nMakeMagicPoint >= g_btMakeMagicUsePoint) and (not g_boSendMakeMagicAdd);
      DMakeMagicAdd1.Visible := boShow and (g_MakeMagic[0] < g_btMakeMagicMaxLevel) and (g_MakeMagic[0] > 0);
      DMakeMagicAdd2.Visible := boShow and (g_MakeMagic[1] < g_btMakeMagicMaxLevel) and (g_MakeMagic[1] > 0);
      DMakeMagicAdd3.Visible := boShow and (g_MakeMagic[2] < g_btMakeMagicMaxLevel) and (g_MakeMagic[2] > 0);
      DMakeMagicAdd4.Visible := boShow and (g_MakeMagic[3] < g_btMakeMagicMaxLevel) and (g_MakeMagic[3] > 0);
      DMakeMagicAdd5.Visible := boShow and (g_MakeMagic[4] < g_btMakeMagicMaxLevel) and (g_MakeMagic[4] > 0);
      DMakeMagicAdd6.Visible := boShow and (g_MakeMagic[5] < g_btMakeMagicMaxLevel) and (g_MakeMagic[5] > 0);
      DMakeMagicAdd7.Visible := boShow and (g_MakeMagic[6] < g_btMakeMagicMaxLevel) and (g_MakeMagic[6] > 0);
      DMakeMagicAdd8.Visible := boShow and (g_MakeMagic[7] < g_btMakeMagicMaxLevel) and (g_MakeMagic[7] > 0);
      DMakeMagicAdd9.Visible := boShow and (g_MakeMagic[8] < g_btMakeMagicMaxLevel) and (g_MakeMagic[8] > 0);
      DMakeMagicAdd10.Visible := boShow and (g_MakeMagic[9] < g_btMakeMagicMaxLevel) and (g_MakeMagic[9] > 0);

      case DMagicIndex of
        0: MagicList := MagicList1;
        1: MagicList := MagicList2;
      else begin
          DMagicFront.Enabled := False;
          DMagicNext.Enabled := False;
          g_DXCanvas.TextOut(ax + 87, ay + 353, $B5EBEF, '1/1');
          g_DXCanvas.TextOut(ax + 87 + 90, ay + 353, $B5EBEF, '剩余技能点：' + IntToStr(g_nMakeMagicPoint));
          exit;
        end;
      end;
      MagicMaxPage := MagicList.Count div 10;
      if MagicList.Count > (MagicMaxPage * 10) then
        Inc(MagicMaxPage);
      Dec(MagicMaxPage);
      if MagicPage > MagicMaxPage then
        MagicPage := MagicMaxPage;
      DMagicFront.Enabled := True;
      DMagicNext.Enabled := True;
      if MagicMaxPage = 0 then begin
        DMagicFront.Enabled := False;
        DMagicNext.Enabled := False;
      end
      else if MagicPage = 0 then begin
        DMagicFront.Enabled := False;
      end
      else if MagicPage = MagicMaxPage then begin
        DMagicNext.Enabled := False;
      end;
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        TextOut(ax + 87, ay + 353, $B5EBEF, IntToStr(MagicPage + 1) + '/' + IntToStr(MagicMaxPage + 1));
        //Release;
      end;  
{$IFEND}

    end else
    if Sender = DStateWinHorse then begin
{$IF Var_Interface = Var_Mir2}
      with g_DXCanvas do begin
        if g_UseItems[U_HOUSE].S.name <> '' then begin
          GetHorseLevelAbility(@g_UseItems[U_HOUSE].UserItem, @g_UseItems[U_HOUSE].S, AddAbility);
          for I := Low(g_UseItems[U_HOUSE].UserItem.HorseItems) to High(g_UseItems[U_HOUSE].UserItem.HorseItems) do begin
            if g_UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex > 0 then begin
              StdItem := GetStditem(g_UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex);
              if StdItem.Name <> '' then
                GetHorseAddAbility(@g_UseItems[U_HOUSE].UserItem, @StdItem, I, AddAbility);
            end;
          end;

          d := g_WMain99Images.Images[1775];
          if d <> nil then begin
            Rect := d.ClientRect;
            Rect.Right := _MIN(Round(Rect.Right / (g_UseItems[U_HOUSE].UserItem.dwMaxExp / g_UseItems[U_HOUSE].UserItem.dwExp)), rect.Right);
            dsurface.Draw(ax + 68, ay + 129, Rect, d, True);
          end;

          d := g_WMain99Images.Images[1774];
          if d <> nil then begin
            Rect := d.ClientRect;
            if g_MySelf.m_btHorse <> 0 then
              Rect.Right := _MIN(Round(Rect.Right / (g_MySelf.m_Abil.MaxHP / g_MySelf.m_Abil.HP)), rect.Right)
            else
              Rect.Right := _MIN(Round(Rect.Right / (AddAbility.HP / g_UseItems[U_HOUSE].UserItem.wHP)), rect.Right);
            dsurface.Draw(ax + 68, ay + 115, Rect, d, True);
          end;

          TextOut(ax + 66, ay + 97, $FFFFFF, IntToStr(g_UseItems[U_HOUSE].UserItem.btLevel));

          if g_UseItems[U_HOUSE].UserItem.btAliveTime > 0 then begin
            TextOut(ax + 132, ay + 97, $C0C0C0, '已死亡 ' + IntToStr(g_UseItems[U_HOUSE].UserItem.btAliveTime) + '分钟后自动复活');
          end else begin
            TextOut(ax + 132, ay + 97, $00FF00, '正常');
          end;


          if g_MySelf.m_btHorse <> 0 then str := IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP)
          else str := IntToStr(g_UseItems[U_HOUSE].UserItem.wHP) + '/' + IntToStr(AddAbility.HP);
          TextOut(ax + 153 - TextWidth(str) div 2, ay + 112, $FFFFFF, str);

          
          str := IntToStr(g_UseItems[U_HOUSE].UserItem.dwExp) + '/' + IntToStr(g_UseItems[U_HOUSE].UserItem.dwMaxExp);
          TextOut(ax + 153 - TextWidth(str) div 2, ay + 126, $FFFFFF, str);



          TextOut(ax + 88, ay + 300, $FFFFFF, IntToStr(AddAbility.AC) + '-' + IntToStr(AddAbility.AC2));
          TextOut(ax + 88, ay + 314, $FFFFFF, IntToStr(AddAbility.MAC) + '-' + IntToStr(AddAbility.MAC2));
          TextOut(ax + 88, ay + 328, $FFFFFF, IntToStr(AddAbility.DC) + '-' + IntToStr(AddAbility.DC2));
          TextOut(ax + 206, ay + 300, $FFFFFF, IntToStr(AddAbility.wHitPoint));
          TextOut(ax + 206, ay + 314, $FFFFFF, IntToStr(AddAbility.wSpeedPoint));

          d := g_WRideImages.GetCachedImage(RIDEFRAME * (g_UseItems[U_HOUSE].S.Shape - 1) + 80 + Integer((GetTickCount - AppendTick) div 120 mod 8), bbx, bby);
          if d <> nil then
            dsurface.Draw(aX + bbx + 130, aY + bby + 205, d.ClientRect, d, True);
        end;
      end;
{$ELSE}
      with g_DXCanvas do begin
        if g_UseItems[U_HOUSE].S.name <> '' then begin
          GetHorseLevelAbility(@g_UseItems[U_HOUSE].UserItem, @g_UseItems[U_HOUSE].S, AddAbility);
          for I := Low(g_UseItems[U_HOUSE].UserItem.HorseItems) to High(g_UseItems[U_HOUSE].UserItem.HorseItems) do begin
            if g_UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex > 0 then begin
              StdItem := GetStditem(g_UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex);
              if StdItem.Name <> '' then
                GetHorseAddAbility(@g_UseItems[U_HOUSE].UserItem, @StdItem, I, AddAbility);
            end;
          end;

          d := g_WMain99Images.Images[1520];
          if d <> nil then begin
            Rect := d.ClientRect;
            Rect.Right := _MIN(Round(Rect.Right / (g_UseItems[U_HOUSE].UserItem.dwMaxExp / g_UseItems[U_HOUSE].UserItem.dwExp)), rect.Right);
            dsurface.Draw(ax + 56, ay + 109, Rect, d, True);
          end;

          d := g_WMain99Images.Images[1521];
          if d <> nil then begin
            Rect := d.ClientRect;
            if g_MySelf.m_btHorse <> 0 then
              Rect.Right := _MIN(Round(Rect.Right / (g_MySelf.m_Abil.MaxHP / g_MySelf.m_Abil.HP)), rect.Right)
            else
              Rect.Right := _MIN(Round(Rect.Right / (AddAbility.HP / g_UseItems[U_HOUSE].UserItem.wHP)), rect.Right);
            dsurface.Draw(ax + 56, ay + 91, Rect, d, True);
          end;

          ArrestStringEx(g_UseItems[U_HOUSE].S.Name, '(', ')', str);
          TextOut(ax + 142 - TextWidth(str) div 2, ay + 51, $FFFFFF, str);

          TextOut(ax + 21, ay + 72, $B5EBEF, '等级：');
          TextOut(ax + 56, ay + 72, $FFFFFF, IntToStr(g_UseItems[U_HOUSE].UserItem.btLevel));
          TextOut(ax + 84, ay + 72, $B5EBEF, '状态：');
          if g_UseItems[U_HOUSE].UserItem.btAliveTime > 0 then begin
            TextOut(ax + 120, ay + 72, $C0C0C0, '已死亡 ' + IntToStr(g_UseItems[U_HOUSE].UserItem.btAliveTime) + '分钟后自动复活');
          end else begin
            TextOut(ax + 120, ay + 72, $00FF00, '正常');
          end;
          TextOut(ax + 21, ay + 90, $B5EBEF, '生命：');
          if g_MySelf.m_btHorse <> 0 then
            str := IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP)
          else
            str := IntToStr(g_UseItems[U_HOUSE].UserItem.wHP) + '/' + IntToStr(AddAbility.HP);

          TextOut(ax + 165 - TextWidth(str) div 2, ay + 90, $FFFFFF, str);
          TextOut(ax + 21, ay + 108, $B5EBEF, '经验：');
          str := IntToStr(g_UseItems[U_HOUSE].UserItem.dwExp) + '/' + IntToStr(g_UseItems[U_HOUSE].UserItem.dwMaxExp);
          TextOut(ax + 165 - TextWidth(str) div 2, ay + 108, $FFFFFF, str);
          TextOut(ax + 21, ay + 319, $B5EBEF, '坐骑防御：');
          TextOut(ax + 81, ay + 319, $FFFFFF, IntToStr(AddAbility.AC) + '-' + IntToStr(AddAbility.AC2));
          TextOut(ax + 21, ay + 337, $B5EBEF, '坐骑魔御：');
          TextOut(ax + 81, ay + 337, $FFFFFF, IntToStr(AddAbility.MAC) + '-' + IntToStr(AddAbility.MAC2));
          TextOut(ax + 21, ay + 355, $B5EBEF, '坐骑攻击：');
          TextOut(ax + 81, ay + 355, $FFFFFF, IntToStr(AddAbility.DC) + '-' + IntToStr(AddAbility.DC2));

          TextOut(ax + 143, ay + 319, $B5EBEF, '坐骑准确：');
          TextOut(ax + 203, ay + 319, $FFFFFF, IntToStr(AddAbility.wHitPoint));
          //TextOut(ax + 143, ay + 319, $B5EBEF, '坐骑生命：');
          //TextOut(ax + 203, ay + 319, $FFFFFF, IntToStr(g_UseItems[U_HOUSE].UserItem.wHP) + '/' + IntToStr(AddAbility.HP));
          TextOut(ax + 143, ay + 337, $B5EBEF, '坐骑敏捷：');
          TextOut(ax + 203, ay + 337, $FFFFFF, IntToStr(AddAbility.wSpeedPoint));
          //TextOut(ax + 143, ay + 355, $B5EBEF, '坐骑敏捷：');
          //TextOut(ax + 203, ay + 355, $FFFFFF, IntToStr(AddAbility.wSpeedPoint));

          d := g_WRideImages.GetCachedImage(RIDEFRAME * (g_UseItems[U_HOUSE].S.Shape - 1) + 80 + Integer((GetTickCount - AppendTick) div 120 mod 8), bbx, bby);
          if d <> nil then
            dsurface.Draw(aX + bbx + 130, aY + bby + 200, d.ClientRect, d, True);
         
        end else begin
          TextOut(ax + 21, ay + 72, $B5EBEF, '等级：');
          TextOut(ax + 114, ay + 72, $B5EBEF, '剩余时间：');
          TextOut(ax + 21, ay + 90, $B5EBEF, '经验：');
          TextOut(ax + 21, ay + 108, $B5EBEF, '饥饿：');
          TextOut(ax + 21, ay + 319, $B5EBEF, '坐骑防御：');
          TextOut(ax + 21, ay + 337, $B5EBEF, '坐骑魔御：');
          TextOut(ax + 21, ay + 355, $B5EBEF, '坐骑准确：');
          TextOut(ax + 143, ay + 319, $B5EBEF, '坐骑生命：');
          TextOut(ax + 143, ay + 337, $B5EBEF, '坐骑攻击：');
          TextOut(ax + 143, ay + 355, $B5EBEF, '坐骑敏捷：');
        end;
      end;  
{$IFEND}

    end;
  end;
end;

procedure TFrmDlg.DStateWinItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  StateAbilIndex := -1;
  if Sender = DStateWinItem then begin
{$IF Var_Interface = Var_Mir2}
    boSelectGuildName := False;
    boSelectGuildRankName := False;
    if (x >= 74) and (x <= 74 + 48) and (y >= 137) and (y <= 137 + 98) then begin
      DSWWeaponMouseMove(DSWWeapon, Shift, X - DStateWinItem.Left, Y - DStateWinItem.Top);
    end
    else if (x >= 123) and (x <= 123 + 48) and (y >= 170) and (y <= 170 + 120) then begin
      DSWWeaponMouseMove(DSWDress, Shift, X - DStateWinItem.Left, Y - DStateWinItem.Top);
    end
    else if (x >= 123) and (x <= 123 + 48) and (y >= 137) and (y <= 137 + 32) then begin
      DSWWeaponMouseMove(DSWHelmet, Shift, X - DStateWinItem.Left, Y - DStateWinItem.Top);
    end
    else if (x >= 16) and (x <= 16 + nGuildNameLen) and (y >= 90) and (y <= 104) then begin
      boSelectGuildName := True;
    end
    else if (x >= 16) and (x <= 16 + nGuildRankNameLen) and (y >= 105) and (y <= 119) then begin
      boSelectGuildRankName := True;
    end;
{$ELSE}
    boSelectGuildName := False;
    boSelectGuildRankName := False;
    if (x >= 80) and (x <= 80 + 34) and (y >= 121 - 10) and (y <= 121 + 98 - 10) then begin
      DSWWeaponMouseMove(DSWWeapon, Shift, X - DStateWinItem.Left, Y - DStateWinItem.Top);
    end
    else if (x >= 114) and (x <= 114 + 67) and (y >= 146 - 10) and (y <= 146 + 125 - 10) then begin
      DSWWeaponMouseMove(DSWDress, Shift, X - DStateWinItem.Left, Y - DStateWinItem.Top);
    end
    else if (x >= 129) and (x <= 129 + 29) and (y >= 121 - 10) and (y <= 121 + 25 - 10) then begin
      DSWWeaponMouseMove(DSWHelmet, Shift, X - DStateWinItem.Left, Y - DStateWinItem.Top);
    end
    else if (x >= 50) and (x <= 50 + nGuildNameLen) and (y >= 45) and (y <= 59) then begin
      boSelectGuildName := True;
    end
    else if (x >= 50) and (x <= 50 + nGuildRankNameLen) and (y >= 60) and (y <= 74) then begin
      boSelectGuildRankName := True;
    end;  
{$IFEND}

  end;
end;

procedure TFrmDlg.DStateWinItemMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{$IF Var_Interface = Var_Mir2}
  if (x >= 74) and (x <= 74 + 48) and (y >= 137) and (y <= 137 + 98) then begin
    DSWWeaponMouseUp(DSWWeapon, Button, Shift, X, Y);
  end
  else if (x >= 123) and (x <= 123 + 48) and (y >= 170) and (y <= 170 + 120) then begin
    DSWWeaponMouseUp(DSWDress, Button, Shift, X, Y);
  end
  else if (x >= 123) and (x <= 123 + 48) and (y >= 137) and (y <= 137 + 32) then begin
    DSWWeaponMouseUp(DSWHelmet, Button, Shift, X, Y);
  end;
  if boSelectGuildName then begin
    PlayScene.SetEditChar(g_MySelf.m_sGuildName);
  end
  else if boSelectGuildRankName then begin
    PlayScene.SetEditChar(g_MySelf.m_sGuildRankName);
  end;
{$ELSE}
  if (x >= 80) and (x <= 80 + 34) and (y >= 121 - 10) and (y <= 121 + 98 - 10) then begin
    DSWWeaponMouseUp(DSWWeapon, Button, Shift, X, Y);
  end
  else if (x >= 114) and (x <= 114 + 67) and (y >= 146 - 10) and (y <= 146 + 125 - 10) then begin
    DSWWeaponMouseUp(DSWDress, Button, Shift, X, Y);
  end
  else if (x >= 129) and (x <= 129 + 29) and (y >= 121 - 10) and (y <= 121 + 25 - 10) then begin
    DSWWeaponMouseUp(DSWHelmet, Button, Shift, X, Y);
  end;
  if boSelectGuildName then begin
    PlayScene.SetEditChar(g_MySelf.m_sGuildName);
  end
  else if boSelectGuildRankName then begin
    PlayScene.SetEditChar(g_MySelf.m_sGuildRankName);
  end;  
{$IFEND}

end;

procedure TFrmDlg.DStateWinMagicCboDirectPaint(Sender: TObject; dsurface: TDXTexture);
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
  end;
end;

procedure TFrmDlg.DStateWinMagicCboGridGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
{$IF Var_Interface = Var_Mir2}
  idx: Integer;
  ShowMsg: string;
{$ELSE}
  ShowMsg: string;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDGrid do begin
    idx := ACol + ARow;
    if (Idx in [Low(CboMagicList.MagicList)..High(CboMagicList.MagicList)]) then
    begin
      if idx = FMagicCboKeyIndex then
        ShowMsg := '正在进行这招的设置，直接点击可以取消\' + '点击连击面版上的技能可以设置到该位置\'
      else
        ShowMsg := '点击可以开始这招的设置\';
      ShowMsg := ShowMsg + '要正常释放连技,至少需要设定<两个/FCOLOR=$FFFF>连击技能\';
      DScreen.ShowHint(SurfaceX(Left + (x - left)), SurfaceY(Top + (y - Top) + 30),
        ShowMsg, clWhite, False, Integer(Sender));
    end;
  end;
{$ELSE}
  with Sender as TDGrid do begin
    ShowMsg := '请将<连击技能/FCOLOR=$FFFF>拖放至该处\';
    ShowMsg := ShowMsg + '技能放置顺序可以随意排列\';
    ShowMsg := ShowMsg + '要正常释放连技,至少需要设定<两个/FCOLOR=$FFFF>连击技能\';
    DScreen.ShowHint(SurfaceX(Left + (x - left)), SurfaceY(Top + (y - Top) + 30),
      ShowMsg, clWhite, False, Integer(Sender));
  end;
{$IFEND}
end;

procedure TFrmDlg.DStateWinMagicCboGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState; dsurface: TDXTexture);
var
  idx, nMagID: Integer;
  Magic: TClientDefMagic;
  d: TDXTexture;
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDGrid do
  begin
    idx := ACol + ARow;
    if (Idx in [Low(CboMagicList.MagicList)..High(CboMagicList.MagicList)]) and (idx = FMagicCboKeyIndex) then
    begin
      d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
      if d <> nil then
        DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2), SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d, 1);
    end;
  end;
{$IFEND}
  with Sender as TDGrid do begin
    idx := ACol + ARow;
    if (Idx in [Low(CboMagicList.MagicList)..High(CboMagicList.MagicList)]) then begin
      nMagID := CboMagicList.MagicList[Idx];
      if nMagID = 0 then
        exit;
      Magic := GetMagicInfo(nMagID);
      if Magic.Magic.sMagicName <> '' then begin
{$IF Var_Interface = Var_Mir2}
        if Magic.Magic.wMagicIcon > 30000 then
          d := g_WMagIconImages.Images[Magic.Magic.wMagicIcon - 30000]
        else if Magic.Magic.wMagicIcon > 20000 then
          d := g_WDefMagIcon2Images.Images[Magic.Magic.wMagicIcon - 20000]
        else if Magic.Magic.wMagicIcon > 10000 then
          d := g_WDefMagIconImages.Images[Magic.Magic.wMagicIcon - 10000]
        else
          d := GetDefMagicIcon(@Magic);
{$ELSE}
        d := g_WMagIconImages.Images[Magic.Magic.wMagicIcon];
{$IFEND}
        if d <> nil then begin
          if g_MyMagicArry[nMagID].boStudy then begin
            dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, False);
          end
          else
            CboMagicList.MagicList[Idx] := 0;
        end;
      end
      else
        CboMagicList.MagicList[Idx] := 0;
    end;
  end;  
end;

procedure TFrmDlg.DStateWinMagicCboGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
  procedure ClearUserKeyType(nIdx: Integer);
  var
    i: integer;
  begin
    for i := Low(CboMagicList.MagicList) to High(CboMagicList.MagicList) do begin
      if CboMagicList.MagicList[i] = nIdx then begin
        CboMagicList.MagicList[i] := 0;
      end;
    end;
  end;

  function CheckMagic(nMagID: Integer; out nIndex: Integer): Boolean;
  begin
    Result := False;
    if (nMagID > 0) and (nMagID < SKILL_MAX) then begin
      if g_MyMagicArry[nMagID].boStudy then begin
        Result := True;
        nIndex := g_MyMagicArry[nMagID].Def.Magic.wMagicIcon;
      end;
    end;
  end;
var
  idx: Integer;
{$IF Var_Interface = Var_Default}
  OldIdx, nIndex: Integer;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDGrid do
  begin
    idx := ACol + ARow;
    if (Idx in [Low(CboMagicList.MagicList)..High(CboMagicList.MagicList)]) then
    begin
      if (idx = FMagicCboKeyIndex) then
        CboMagicList.MagicList[Idx] := 0
      else
        FMagicCboKeyIndex := idx;
    end;
  end;
{$ELSE}
  with Sender as TDGrid do begin
    idx := ACol + ARow;
    if (Idx in [Low(CboMagicList.MagicList)..High(CboMagicList.MagicList)]) then begin
      if g_boItemMoving then begin
        OldIdx := CboMagicList.MagicList[Idx];
        if (g_MovingItem.ItemType = mtStateMagic) and (LoWord(g_MovingItem.Index2) in [SKILL_110..SKILL_121]) then begin
          ClearUserKeyType(LoWord(g_MovingItem.Index2));
          CboMagicList.MagicList[idx] := LoWord(g_MovingItem.Index2);
          g_boItemMoving := False;
        end
        else if (g_MovingItem.ItemType = mtBottom) and (LoWord(g_MovingItem.Index2) = UKTYPE_MAGIC) and
          (HiWord(g_MovingItem.Index2) in [SKILL_110..SKILL_121]) then begin
          ClearUserKeyType(HiWord(g_MovingItem.Index2));
          CboMagicList.MagicList[idx] := HiWord(g_MovingItem.Index2);
          g_boItemMoving := False;
        end;
        if (not g_boItemMoving) and CheckMagic(OldIdx, nIndex) then begin
          g_boItemMoving := True;
          g_MovingItem.ItemType := mtStateMagic;
          g_MovingItem.Index2 := MakeLong(OldIdx, nIndex);
        end;
      end
      else begin
        if CheckMagic(CboMagicList.MagicList[Idx], nIndex) then begin
          g_boItemMoving := True;
          g_MovingItem.ItemType := mtStateMagic;
          g_MovingItem.Index2 := MakeLong(CboMagicList.MagicList[Idx], nIndex);
          CboMagicList.MagicList[Idx] := 0;
        end;
      end;
    end;
  end;  
{$IFEND}

end;

procedure TFrmDlg.DStateWinMagicCboICOClick(Sender: TObject; X, Y: Integer);
begin
{$IF Var_Interface = Var_Mir2}
  FrmDlg4.FMagicKeyIndex := g_MyMagicArry[SKILL_CBO].btKey;
  FrmDlg4.FMagidID := SKILL_CBO;
  FrmDlg4.DWndMagicKey.ShowModal;
{$ELSE}
  if g_boItemMoving then begin
    if g_MovingItem.ItemType = mtStateMagic then begin
      g_boItemMoving := False;
    end;
  end
  else begin
    if (g_MyMagicArry[SKILL_CBO].boStudy) then begin
      if g_MyMagicArry[SKILL_CBO].boStudy then begin
        g_boItemMoving := True;
        g_MovingItem.Index2 := MakeLong(SKILL_CBO, g_MyMagicArry[SKILL_CBO].Def.Magic.wMagicIcon);
        g_MovingItem.ItemType := mtStateMagic;
      end;
    end;
  end;  
{$IFEND}
end;

procedure TFrmDlg.DStateWinMagicCboICODirectPaint(Sender: TObject; dsurface: TDXTexture);
var
{$IF Var_Interface = Var_Default}
  Magic: TClientDefMagic;
{$IFEND}
  d: TDXTexture;
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDButton do begin
    if g_MyMagicArry[SKILL_CBO].btKey = 0 then begin
      d := g_WMain99Images.Images[1870];
      if d <> nil then begin
        dsurface.Draw(SurfaceX(Left + 2), SurfaceY(Top + 2), d.ClientRect, d, True);
      end;
    end
    else begin
      d := g_WMain99Images.Images[2095 + g_MyMagicArry[SKILL_CBO].btKey];
      if d <> nil then begin
        dsurface.Draw(SurfaceX(Left + 6), SurfaceY(Top + 3), d.ClientRect, d, True);
      end;
    end;
  end;
{$ELSE}
  with Sender as TDButton do begin
    Magic := GetMagicInfo(SKILL_CBO); //连击技能ID
    if Magic.Magic.sMagicName <> '' then begin
      d := g_WMagIconImages.Images[Magic.Magic.wMagicIcon];
      if d <> nil then begin
        dsurface.Draw(SurfaceX(Left + 1), SurfaceY(Top + 1), d.ClientRect, d, False);
      end;
    end;
  end;
{$IFEND}

end;

procedure TFrmDlg.DStateWinMagicCboICOInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
begin
  IsRealArea := True;
end;

procedure TFrmDlg.DStateWinMagicCboICOMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
{$IF Var_Interface = Var_Default}
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  ShowMsg: string;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
{$ELSE}
  with Sender as TDButton do begin
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    ShowMsg := '释放连击快捷图标\';
    ShowMsg := ShowMsg + '可以将该图标拖放至底部快捷键栏中\';
    ShowMsg := ShowMsg + '要正常释放连技,至少需要设定<两个/FCOLOR=$FFFF>连击技能\';
    DScreen.ShowHint(nHintX, nHintY, ShowMsg, clWhite, False, Integer(Sender));
    {if Tag in [Low(g_AddBagItems)..High(g_AddBagItems)] then begin
      if g_AddBagItems[Tag].s.Name <> '' then begin
        DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(g_AddBagItems[Tag], [mis_AddBag], []), clwhite, False, Tag, True);
      end;
    end;  }
  end;  
{$IFEND}

end;

procedure TFrmDlg.DStateWinMagicCboOKClick(Sender: TObject; X, Y: Integer);
var
  i, ii: integer;
begin
  for I := Low(CboMagicList.MagicList) to High(CboMagicList.MagicList) do begin
    if CboMagicList.MagicList[i] = 0 then
      for ii := I + 1 to High(CboMagicList.MagicList) do begin
        if CboMagicList.MagicList[ii] > 0 then begin
          CboMagicList.MagicList[i] := CboMagicList.MagicList[ii];
          CboMagicList.MagicList[ii] := 0;
          break;
        end;
      end;
  end;
  if (CboMagicList.MagicList[0] > 0) and (CboMagicList.MagicList[1] > 0) then begin
    FrmMain.SendClientMessage(CM_CBOMAGIC, CboMagicList.nMagicList, 0, 0, 0, '');
    DStateWinMagicCbo.Visible := False;
  end
  else
    DMessageDlg('至少需要设置两个连击技能！', [mbOK]);
end;

procedure TFrmDlg.DStateWinMagicCboVisible(Sender: TObject; boVisible: Boolean);
begin
{$IF Var_Interface = Var_Mir2}
  FMagicCboKeyIndex := 0;
{$IFEND}
  CboMagicList := g_CboMagicList;
end;

procedure TFrmDlg.DStateWinMagicVisible(Sender: TObject; boVisible: Boolean);
begin
  if not boVisible then
    DStateWinMagicCbo.Visible := False;
end;

procedure TFrmDlg.DStateWinVisible(Sender: TObject; boVisible: Boolean);
begin
  if not boVisible then
    boOpenStatus := False;
end;

procedure TFrmDlg.DSWWeaponDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  where: integer;
  //boDraw: Boolean;
  nInt: Integer;
  showstr: string;
  pRect: TRect;
  Item: TNewClientItem;
begin
  with Sender as TDButton do begin
    FillChar(Item, SizeOf(Item), #0);
    if (Tag in [Low(g_UseItems)..High(g_UseItems)]) then begin
      Item := g_UseItems[Tag];
      if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
        where := GetTakeOnPosition(g_MovingItem.Item.S.StdMode);
        if where in [0..MAXUSEITEMS - 1] then begin
          if (Tag = where) or ((where = U_RINGL) and (Sender = DSWRingR)) or
            ((where = U_ARMRINGL) and (Sender = DSWArmRingR)) then begin
            d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(Left) - 12, SurfaceY(Top) - 14, d, 1);
            //            boDraw := True;
          end;
        end;
      end;
    end else
    if Tag in [16..20] then begin
      if g_UseItems[U_HOUSE].S.Name <> '' then begin
        Item := HorseItemToClientItem(@g_UseItems[U_HOUSE].UserItem.HorseItems[Tag - 16]);
      end;
      if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
        where := GetHorseTakeOnPosition(g_MovingItem.Item.S.StdMode);
        if where in [Low(g_UseItems[U_HOUSE].UserItem.HorseItems)..High(g_UseItems[U_HOUSE].UserItem.HorseItems)] then begin
          if ((Tag - 16) = where) then begin
            d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(Left) - 12, SurfaceY(Top) - 14, d, 1);
            //            boDraw := True;
          end;
        end;
      end;
    end;
    if Item.S.name <> '' then begin
      d := GetBagItemImg(Item.S.looks);
      if d <> nil then begin
        pRect.Left := SurfaceX(Left - 1);
        pRect.Top := SurfaceY(Top - 1);
        pRect.Right := SurfaceX(Left + Width + 1);
        pRect.Bottom := SurfaceY(Top + Height + 1);
        RefItemPaint(dsurface, d, //人物背包栏
          SurfaceX(Left + (Width - d.Width) div 2),
          SurfaceY(Top + (Height - d.Height) div 2),
          1,
          1,
          @Item, False, [pmShowLevel], @pRect);
        if ((sm_Arming in Item.s.StdModeEx) or (sm_HorseArm in Item.s.StdModeEx)) and (Item.UserItem.Dura < Item.UserItem.DuraMax) then begin
          nInt := Round(Item.UserItem.Dura / Item.UserItem.DuraMax * 100);
          if (nInt <= 50) or (g_CursorMode = cr_Repair) then begin
            with g_DXCanvas do begin
              showstr := IntToStr(nInt) + '%';
              if nInt <= 30 then TextOut(SurfaceX(Left + Width - 2) - TextWidth(showstr), SurfaceY(Top + Height) - 12, clRed, showstr)
              else TextOut(SurfaceX(Left + Width - 2) - TextWidth(showstr), SurfaceY(Top + Height) - 12, clwhite, showstr);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  sel: Integer;
  MoveItemState: TMoveItemState;
  Item: TNewClientItem;
begin
  with Sender as TDControl do begin
    if DParent = nil then exit;
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX + 30;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    sel := Tag;
    FillChar(Item, SizeOf(Item), #0);
    if (sel in [Low(g_UseItems)..High(g_UseItems)]) then begin
      Item := g_UseItems[sel];
    end else
    if sel in [16..20] then begin
      if g_UseItems[U_HOUSE].S.Name <> '' then begin
        Item := HorseItemToClientItem(@g_UseItems[U_HOUSE].UserItem.HorseItems[sel - 16]);
      end;
    end;
    if Item.s.Name <> '' then begin
      MoveItemState := [mis_State];
      case g_CursorMode of
        cr_Repair: begin
            if boSuperRepair then
              MoveItemState := MoveItemState + [mis_SuperRepair]
            else
              MoveItemState := MoveItemState + [mis_Repair];
          end;
      end;
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(Item, MoveItemState, []), clwhite, False, Integer(Sender), True);
    end;
    //end;
  end;
end;

procedure TFrmDlg.DSWWeaponMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  where, sel: Integer;
  Item: TNewClientItem;
begin
  if g_MySelf = nil then Exit;
  sel := (Sender as TDButton).Tag;

  FillChar(Item, SizeOf(Item), #0);
  if (sel in [Low(g_UseItems)..High(g_UseItems)]) then begin
    Item := g_UseItems[sel];
  end else
  if sel in [16..20] then begin
    if g_UseItems[U_HOUSE].S.Name <> '' then begin
      Item := HorseItemToClientItem(@g_UseItems[U_HOUSE].UserItem.HorseItems[sel - 16]);
    end;
  end;

  if (DMenuDlg.Visible) and (g_CursorMode = cr_Repair) then begin
    if Item.S.Name <> '' then begin
      if (g_SellDlgItemSellWait.Item.S.name = '') and ((sm_Arming in Item.s.StdModeEx) or (sm_HorseArm in Item.s.StdModeEx)) and
        (not (CheckItemBindMode(@Item.UserItem, bm_NoRepair))) and
        (Item.UserItem.Dura < Item.UserItem.DuraMax) then begin
        ItemClickSound(Item.S);
        g_SellDlgItemSellWait.Index2 := -(sel + 1);
        g_SellDlgItemSellWait.Item := Item;
        g_SellDlgItemSellWait.ItemType := mtStateItem;
        if (sel in [Low(g_UseItems)..High(g_UseItems)]) then begin
          g_UseItems[sel].S.name := '';
        end else
        if sel in [16..20] then begin
          if g_UseItems[U_HOUSE].S.Name <> '' then begin
            g_UseItems[U_HOUSE].UserItem.HorseItems[sel - 16].wIndex := 0;
          end;
        end;
        frmMain.SendRepairItem(g_nCurMerchant, g_SellDlgItemSellWait.Item.UserItem.MakeIndex, MakeWord(Integer(boSuperRepair), sel));
      end;
    end;
    exit;
  end;
  if g_boItemMoving then begin
    if Button = mbRight then exit;
    if g_MovingItem.ItemType = mtBagItem then begin
      if (g_MovingItem.Item.S.name = '') or (g_WaitingUseItem.Item.S.name <> '') then Exit;
      where := (Sender as TDButton).Tag;
      if (g_MovingItem.ItemType = mtBagItem) and (where in [0..20{MAXUSEITEMS - 1}]) then begin
        ItemClickSound(g_MovingItem.Item.S);
        g_WaitingUseItem := g_MovingItem;
        g_WaitingUseItem.Index2 := where;
        frmMain.SendTakeOnItem(where, g_MovingItem.Item.UserItem.MakeIndex, g_MovingItem.Item.S.name);
        ClearMovingItem();
      end;
    end
    else if g_MovingItem.ItemType = mtStateItem then begin
      where := -(g_MovingItem.Index2 + 1);
      if where in [0..MAXUSEITEMS - 1] then begin
        g_UseItems[where] := g_MovingItem.Item;
      end else
      if where in [16..20] then begin
        g_UseItems[U_HOUSE].UserItem.HorseItems[where - 16] := UserItemToHorseItem(@g_MovingItem.Item.UserItem);
      end;
      ClearMovingItem();
    end;
  end
  else if Button = mbRight then begin
    if (g_WaitingUseItem.Item.S.name <> '') then Exit;
    if Item.S.name <> '' then begin
      g_WaitingUseItem.Index2 := -(sel + 1);
      g_WaitingUseItem.Item := Item;
      g_WaitingUseItem.ItemType := mtBagItem;
      ItemClickSound(g_WaitingUseItem.Item.S);
      frmMain.SendTakeOffItem(sel, g_WaitingUseItem.Item.UserItem.MakeIndex, g_WaitingUseItem.Item.S.name);
      //g_UseItems[sel].S.name := '';
      if (sel in [Low(g_UseItems)..High(g_UseItems)]) then begin
        g_UseItems[sel].S.name := '';
      end else
      if sel in [16..20] then begin
        if g_UseItems[U_HOUSE].S.Name <> '' then begin
          g_UseItems[U_HOUSE].UserItem.HorseItems[sel - 16].wIndex := 0;
        end;
      end;
    end;
  end
  else begin
    if Item.S.name <> '' then begin
      g_boItemMoving := True;
      g_MovingItem.Index2 := -(sel + 1);
      g_MovingItem.Item := Item;
      g_MovingItem.ItemType := mtStateItem;
      //g_UseItems[sel].S.name := '';
      if (sel in [Low(g_UseItems)..High(g_UseItems)]) then begin
        g_UseItems[sel].S.name := '';
      end else
      if sel in [16..20] then begin
        if g_UseItems[U_HOUSE].S.Name <> '' then begin
          g_UseItems[U_HOUSE].UserItem.HorseItems[sel - 16].wIndex := 0;
        end;
      end;
      ItemClickSound(g_MovingItem.Item.S);
    end;
  end;
end;

procedure TFrmDlg.DTopDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  str: string;
  rc: TRect;
  i: integer;
  FontColor: TColor;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);
    if g_MySelf = nil then
      exit;

    if GetTickCount > AppendTick then begin
      AppendTick := GetTickCount + 2000;
      boNewEMail := False;
      for I := 0 to g_EMailList.Count - 1 do begin
        if not pTEMailInfo(g_EMailList.Objects[i]).ClientEMail.boRead then begin
          boNewEMail := True;
          break;
        end;
      end;
    end;

    d := WLib.Images[48 + g_MySelf.m_btJob + g_MySelf.m_btSex * 3];
    if d <> nil then
      dsurface.Draw(ax + 38, ay + 4, d.ClientRect, d, True);
    //HP
    d := g_WMain99Images.Images[3];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := _MIN(Round(rc.Right / (g_MySelf.m_Abil.MaxHP / g_MySelf.m_Abil.HP)), rc.Right);
      dsurface.Draw(ax + 252, ay + 14, rc, d, FALSE);
    end;
    //Mp
    d := g_WMain99Images.Images[4];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := _MIN(Round(rc.Right / (g_MySelf.m_Abil.MaxMP / g_MySelf.m_Abil.MP)), rc.Right);
      dsurface.Draw(ax + 86, ay + 14, rc, d, FALSE);
    end;
    //怒气值
    d := g_WMain99Images.Images[5];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := _MIN(Round(rc.Right / (10000 / g_nDander)), rc.Right);
      dsurface.Draw(ax + 468, ay + 14, rc, d, FALSE);
    end;
    //经验
    d := g_WMain99Images.Images[10];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := _MIN(Round(rc.Right / (g_MySelf.m_Abil.MaxExp / g_MySelf.m_Abil.Exp)), rc.Right);
      dsurface.Draw(ax + 99, ay + 2, rc, d, FALSE);
    end;

    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      FontColor := clWhite;
      str := IntToStr(g_MySelf.m_Abil.Level);
      TextOut(ax + 56 - TextWidth(str) div 2, ay + 43, str, FontColor);
      TextOut(ax + 728 - TextWidth(g_sMapTitle) div 2, ay + 4, g_sMapTitle, FontColor);

      str := IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP);
      TextOut(ax + 352 - TextWidth(str) div 2, ay + 15, clWhite, str);

      str := IntToStr(g_MySelf.m_Abil.MP) + '/' + IntToStr(g_MySelf.m_Abil.MaxMP);
      TextOut(ax + 161 - TextWidth(str) div 2, ay + 13, clWhite, str);

      str := IntToStr(g_nDander) + '/10000';
      TextOut(ax + 543 - TextWidth(str) div 2, ay + 13, clWhite, str);

      str := Format('%.2f', [g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp * 100]) + ' %';
      TextOut(ax + 352 - TextWidth(str) div 2, ay - 1, clWhite, str);
      case g_nAreaStateValue of
        OT_SAFEAREA: begin
            FontColor := clLime;
            str := '安全区';
          end;
        OT_SAFEPK: begin
            FontColor := clYellow;
            str := '竟技区';
          end;
        OT_FREEPKAREA: begin
            FontColor := clFuchsia;
            str := '攻城区';
          end;
      else
        FontColor := clRed;
        str := '危险区';
      end;
      TextOut(ax + 630, ay + 4, str, FontColor);
      //Release;
    end;
  end;
end;

procedure TFrmDlg.DTopEMailClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg2.DWinEmail.Visible := not FrmDlg2.DWinEmail.Visible;
end;

procedure TFrmDlg.DTopEMailDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if Downed then begin
        inc(idx, 2)
      end
      else if (MouseEntry = msIn) or (boNewEMail and ((GetTickCount - AppendTick) mod 600 > 300)) then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DTopGMClick(Sender: TObject; X, Y: Integer);
begin
  if g_WebInfo.g_GMUrl <> '' then begin
    FrmWEB.wb.UISettings.EnableScrollBars := False;
    FrmDLg2.OpenWeb(g_WebInfo.g_GMUrl + '?Name=' + FrmMain.CharName +
      '&ServerName=' + g_sServerMiniName +
      '&Key=' + GetMD5Text(HTTPEncode(FrmMain.CharName + g_sServerMiniName + IntToStr(HourOf(g_ServerDateTime)))) +
      '&t=' + IntToStr(GetTickCount), 508, 579);
    //FrmDLg2.OpenWeb(g_WebInfo.g_GMUrl, 508, 579);
  end;
  {FrmDLg2.OpenWeb('http://www.mir2k.com/advise/?Name=' + FrmMain.CharName +
    '&ServerName=' + g_sServerMiniName +
    '&Key=' + GetMD5Text(HTTPEncode(FrmMain.CharName+g_sServerMiniName+IntToStr(HourOf(g_ServerDateTime)))) +
    '&t=' + IntToStr(GetTickCount), 508, 579);  }
end;

procedure TFrmDlg.DTopGMMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left);
    y := SurfaceY(Top + (y - Top) + 30);
    ShowMsg := '';
    if Sender = DTopGM then begin
      ShowMsg := '联系管理员';
    end
    else if Sender = DTopHelp then begin
      ShowMsg := '游戏帮助<（H）/FCOLOR=$FFFF>';
    end
    else if Sender = DTopEMail then begin
      ShowMsg := '信件系统<（E）/FCOLOR=$FFFF>';
    end
    else if Sender = DItemBagRef then begin
      ShowMsg := '刷新背包物品';
    end
    else if Sender = DOpenMinmap then begin
      if g_boMiniMapClose then
        ShowMsg := '展开小地图'
      else
        ShowMsg := '收起小地图';
    end
    else if Sender = DTopShop then begin
      ShowMsg := '游戏商城';
    end
    else if Sender = DButtonTop then begin
      ShowMsg := '排行榜';
    end
    else if Sender = DMiniMapMax then begin
      ShowMsg := '全景地图<（' + GetHookKeyStr(@g_CustomKey[DK_CHANGEMINMAP]) + ' 或 M）/FCOLOR=$FFFF>';
    end
    else if Sender = DDRDealLock then begin
      if not DDRDealLock.Checked then
        ShowMsg := '（<未锁定/FCOLOR=$FF>）\'
      else
        ShowMsg := '（<已锁定/FCOLOR=$FFFF>）\';
      ShowMsg := '对方是否已锁定交易物品' + ShowMsg;
      ShowMsg := ShowMsg + '锁定后不允许 增加/减少 交易物品\';
      ShowMsg := ShowMsg + '<只有双方都锁定后才能完成交易！/FCOLOR=$FFFF>';
    end
    else if Sender = DDRDealOK then begin
      ShowMsg := '对方是否已经确认交易';
      if not DDRDealOK.Checked then
        ShowMsg := ShowMsg + '（<未确认/FCOLOR=$FF>）\'
      else
        ShowMsg := ShowMsg + '（<已确认/FCOLOR=$FFFF>）\'
    end
    else if Sender = DDealOK then begin
      ShowMsg := '<只有双方都锁定后才能完成交易！/FCOLOR=$FFFF>';
    end
    else if Sender = DDealLock then begin
      ShowMsg := '锁定后不允许 增加/减少 交易物品\';
      ShowMsg := ShowMsg + '<只有双方都锁定后才能完成交易！/FCOLOR=$FFFF>';
    end
    else if Sender = DGrpCheckGroup then begin
      ShowMsg := '开启后任何人想邀请你组队，都必需先经过你的同意\';
      ShowMsg := ShowMsg + '邀请组队确认提示将出现在<小地图下方/FCOLOR=$FFFF>！';
    end
    else if Sender = DCBGroupItemDef then begin
      ShowMsg := '以常规方式分配队友捡取的物品\';
      ShowMsg := ShowMsg + '谁捡的物品就由谁获得。';
    end
    else if Sender = DCBGroupItemRam then begin
      ShowMsg := '当队友与自己在同一屏幕范围内时\';
      ShowMsg := ShowMsg + '队友或自己捡取物品，物品将随机分配给自己或队友。\';
      ShowMsg := ShowMsg + '捡取金币时，由同一屏幕范围内队友共同平分。';
    end
    else if Sender = DMenuReturn then begin
      ShowMsg := '回购是系统为防止玩家因失误出售了不该出售的物品.\';
      ShowMsg := ShowMsg + '玩家可以随时从回购系统购回出售过的物品.\';
      ShowMsg := ShowMsg + '回购系统可以为玩家临时保存30件物品和永久保存最后出售的4件物品\';
    end;
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, False, Integer(Sender));
  end;
end;

procedure TFrmDlg.DTopHelpClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount > FHelpTick then begin
    FHelpTick := GetTickCount + 2000;
    frmMain.SendSay(g_Cmd_MemberFunctionEx);
  end;
end;

procedure TFrmDlg.DTopHelpDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
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
end;

procedure TFrmDlg.DTopMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDWindow do begin
    ShowMsg := '';
    if (x >= 38) and (x <= 38 + 34) and (y >= 4) and (y <= 4 + 36) then begin
      ShowMsg := '职业: ' + GetJobName(g_MySelf.m_btJob);
    end
    else if (x >= 38) and (x <= 38 + 34) and (y >= 40) and (y <= 40 + 18) then begin
      ShowMsg := '等级: ' + intToStr(g_MySelf.m_Abil.Level);
    end
    else if (x >= 97) and (x <= 97 + 510) and (y >= 0) and (y <= 0 + 10) then begin
      ShowMsg := '当前经验: ' + GetGoldStr(g_MySelf.m_Abil.Exp) + '\';
      ShowMsg := ShowMsg + '升级经验: ' + GetGoldStr(g_MySelf.m_Abil.MaxExp);
    end
    else if (x >= 84) and (x <= 84 + 154) and (y >= 10) and (y <= 10 + 16) then begin
      ShowMsg := '人物当前魔法值（MP）';
    end
    else if (x >= 248) and (x <= 248 + 208) and (y >= 10) and (y <= 10 + 21) then begin
      ShowMsg := '人物当前生命值（HP）';
    end
    else if (x >= 465) and (x <= 465 + 155) and (y >= 10) and (y <= 10 + 21) then begin
      ShowMsg := '人物当前自然成长点数\';
      ShowMsg := ShowMsg + ' ．角色建立后，首次登陆开始累积自然成长点数\';
      ShowMsg := ShowMsg + ' ．自然成长点数无论在线与否都进行累积\';
      ShowMsg := ShowMsg + ' ．每小时积累自然成长点数10点\';
      ShowMsg := ShowMsg + ' ．自然成长最多累计10000点，超过后不再累积成长点数\';
      ShowMsg := ShowMsg + ' ．玩家可以通过道具<（聚灵珠）/FColor=$00FFFF>将自然成长值转换成经验\';
    end
    else if (x >= 671) and (x <= 671 + 113) and (y >= 0) and (y <= 0 + 19) then begin
      ShowMsg := '人物当前所在地图';
    end
    else if (x >= 624) and (x <= 624 + 47) and (y >= 0) and (y <= 0 + 19) then begin
      ShowMsg := '[<安全区/FColor=$00FF00>]: 该区域无法攻击人物和宝宝\';
      ShowMsg := ShowMsg +
        '[<竟技区/FColor=$00FFFF>]: 该区域死亡不掉落任何物品，杀人不计算PK值\';
      ShowMsg := ShowMsg +
        '[<攻城区/FColor=$FF00FF>]: 该区域死亡有机率掉落物品，杀人不计算PK值\';
      ShowMsg := ShowMsg + '[<危险区/FColor=$0000FF>]: 该区域死亡有机率掉落物品，杀人计算PK值\';
    end;
    if ShowMsg <> '' then begin
      y := y + 30;
      DScreen.ShowHint(x, y, ShowMsg, clWhite, False, x);
    end;
  end;
end;

procedure TFrmDlg.DTopShopClick(Sender: TObject; X, Y: Integer);
begin
  //FrmDlg2.DShopWin.Visible := True;
{$IF Var_Interface = Var_Mir2}
  FrmDlg2.ShopIndex := 4;
  FrmDlg2.ShopPage := 0;
  FrmDlg2.ShopSelectIdx := -1;
  FrmDlg2.ShopSelectIndex := -1;
  FrmDlg2.DShopWin.Visible := not FrmDlg2.DShopWin.Visible;
  if FrmDlg2.DShopWin.Visible then
    FrmMain.SendShopList(0, g_ShopLoading[0]);
{$ELSE}
  FrmDlg2.ShopIndex := 0;
  FrmDlg2.ShopPage := 0;
  FrmDlg2.ShopSelectIdx := -1;
  FrmDlg2.ShopSelectIndex := -1;
  FrmDlg2.DShopWin.Visible := not FrmDlg2.DShopWin.Visible;
  if FrmDlg2.DShopWin.Visible then
    FrmMain.SendShopList(0, g_ShopLoading[0]);  
{$IFEND}

end;

procedure TFrmDlg.DTopShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
{$IF Var_Interface =  Var_Default}
  Rect: TRect;
{$IFEND}
begin
  with Sender as TDButton do begin
{$IF Var_Interface = Var_Mir2}
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end else begin
        idx := (gettickcount - AppendTick) div 200 mod 50;
        if idx in [0..3] then begin
          d := g_WMain99Images.Images[2130 + idx];
          if d <> nil then begin
            dsurface.Draw(SurfaceX(Left) - 5, SurfaceY(Top) - 2, d.ClientRect, d, True);
          end;
        end;
      end;
    end;
{$ELSE}
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

      if idx = 0 then begin
        idx := (gettickcount - AppendTick) div 200 mod 50;
        if idx in [0..11] then begin
          d := g_WMain99Images.Images[1872 + idx];
          Rect.Left := SurfaceX(Left) - 24 + 8;
          Rect.Top := SurfaceY(Top) - 26 + 10;
          Rect.Right := Rect.Left + 62;
          Rect.Bottom := Rect.Top + 64;
          if d <> nil then begin
            dsurface.StretchDraw(Rect, d.ClientRect, d, fxAnti);
          end;
          //dsurface.Draw(SurfaceX(Left) - 24, SurfaceY(Top) - 26, d.ClientRect, d, True, fxAnti);
        end;

      end;
    end;
{$IFEND}
  end;
end;

procedure TFrmDlg.DTopStatusEXPDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  StatusInfo: pTStatusInfo;
  dwColor: LongWord;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      StatusInfo := pTStatusInfo(AppendData);
      if (StatusInfo <> nil) and (StatusInfo.dwTime < 10000) then begin
        Inc(AppendTick);
        if AppendTick > 50 then AppendTick := 0;
        if AppendTick > 25 then dwColor := (50 - AppendTick) * 10 and $FF shl 24 or $00FFFFFF
        else dwColor := (AppendTick * 10) and $FF shl 24 or $00FFFFFF;
        dsurface.Draw(ax, ay, d.ClientRect, d, dwColor, fxBlend);
      end else begin
        AppendTick := 26;
        dsurface.Draw(ax, ay, d.ClientRect, d, $FFFFFFFF, fxBlend);
      end;
    end;
  end;

end;

procedure TFrmDlg.DTopStatusEXPMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
  StatusInfo: pTStatusInfo;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left);
    y := SurfaceY(Top + (y - Top) + 30);
    StatusInfo := pTStatusInfo(AppendData);
    if StatusInfo = nil then Exit;
    ShowMsg := '';
    case Tag of
      STATUS_EXP: begin
          ShowMsg := '当前经验倍数：<' + Format('%.2f', [StatusInfo.nPower / 100]) + '/FCOLOR=$FFFF>倍\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_POW: begin
          ShowMsg := '当前伤害倍数：<' + Format('%.2f', [StatusInfo.nPower / 100]) + '/FCOLOR=$FFFF>倍\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_SC: begin
          if StatusInfo.nPower < 0 then
            ShowMsg := '道术减少：<' + IntToStr(-StatusInfo.nPower) + '/FCOLOR=$FF>点\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒'
          else
            ShowMsg := '道术增加：<' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF>点\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_AC: begin
          ShowMsg := '防御增加：<' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF>点\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_DC: begin
          if StatusInfo.nPower < 0 then
            ShowMsg := '攻击减少：<' + IntToStr(-StatusInfo.nPower) + '/FCOLOR=$FF>点\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒'
          else
            ShowMsg := '攻击增加：<' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF>点\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_HIDEMODE: begin
          ShowMsg := '您当前处于<隐身状态/FCOLOR=$FFFF>\状态解除剩余时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_STONE: begin
          ShowMsg := '您当前处于<麻痹状态/FCOLOR=$FFFF>\状态解除剩余时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_MC: begin
          if StatusInfo.nPower < 0 then
            ShowMsg := '魔法减少：<' + IntToStr(-StatusInfo.nPower) + '/FCOLOR=$FF>点\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒'
          else
            ShowMsg := '魔法增加：<' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF>点\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_MP: begin
          ShowMsg := '魔法值增加：<' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF>点\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_MAC: begin
          ShowMsg := '魔御增加：<' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF>点\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_HP: begin
          ShowMsg := '生命值增加：<' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF>点\剩余有效时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_DAMAGEARMOR: begin
          ShowMsg := '您中毒了（<红毒/FCOLOR=$FF>）\受到攻击时将额外多承担<' + IntToStr(StatusInfo.nPower * 10 - 100) + '%伤害/FCOLOR=$FFFF>\装备消耗持久也将多消耗<' + IntToStr(StatusInfo.nPower * 10 - 100) + '%/FCOLOR=$FFFF>\状态解除剩余时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_DECHEALTH: begin
          ShowMsg := '您中毒了（<绿毒/FCOLOR=$FF00>）\每<' + Format('%.1f', [HiWord(StatusInfo.nPower) / 1000]) + '秒/FCOLOR=$FFFF>减少<' + IntToStr(LoWord(StatusInfo.nPower)) + 'HP/FCOLOR=$FFFF>值\状态解除剩余时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';
        end;
      STATUS_COBWEB: begin
          ShowMsg := '您被蜘蛛网住了\状态解除剩余时间：<' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>秒';  
        end;
    end;
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, False, Integer(Sender));
  end;
end;

procedure TFrmDlg.DUserKeyGrid1GridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx, nMagID: Integer;
  Item: TNewClientItem;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + Tag * 12;
    if idx in [Low(g_UserKeySetup)..High(g_UserKeySetup)] then begin
      m_nMouseIdx := idx;
      if g_UserKeySetup[idx].btType = UKTYPE_ITEM then begin
        Item.s := GetStdItem(g_UserKeySetup[idx].wIndex);
        if Item.s.name <> '' then begin
          SafeFillChar(Item.UserItem, SizeOf(Item.UserItem), #0);
          Item.UserItem.wIndex := Item.s.Idx + 1;
          Item.UserItem.Dura := 1;
          if Item.s.StdMode2 = 2 then
            Item.UserItem.Dura := g_UserKeyIndex[idx];

          Item.UserItem.DuraMax := Item.s.DuraMax;
          DScreen.ShowHint(SurfaceX(X), SurfaceY(Y),
            ShowItemInfo(Item, [mis_bottom], []), clwhite, True, idx, True);
        end;
      end
      else if g_UserKeySetup[idx].btType = UKTYPE_MAGIC then begin
        nMagID := g_UserKeySetup[idx].wIndex;
        if (nMagID > 0) and (nMagID < SKILL_MAX) then begin
          if g_MyMagicArry[nMagID].boStudy then begin
            DScreen.ShowHint(SurfaceX(X), SurfaceY(Y),
              ShowMagicInfo(@g_MyMagicArry[nMagID]), clwhite, True, idx, True);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DUserKeyGrid1GridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  idx, nMagID, ax, ay: Integer;
  d: TDXTexture;
  NewClientItem: TNewClientItem;
  showstr: string;
  PaintMode: TItemPaintMode;
  boUse: Boolean;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + Tag * 12;
    if idx in [Low(g_UserKeySetup)..High(g_UserKeySetup)] then begin
      if g_UserKeySetup[idx].btType = UKTYPE_ITEM then begin
        nMagID := GetStditemLook(g_UserKeySetup[idx].wIndex);
        d := GetBagItemImg(nMagID);
        if d <> nil then begin
          PaintMode := [];
          if g_UserKeyIndex[idx] <= 0 then
            PaintMode := [pmBlend];

          NewClientItem.s := GetStdItem(g_UserKeySetup[idx].wIndex);
          RefItemPaint(dsurface, d, //人物背包栏
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @NewClientItem, False, PaintMode);
          with g_DXCanvas do begin
            //SetBkMode(Handle, TRANSPARENT);
            showstr := IntToStr(g_UserKeyIndex[idx]);
            //Font.Color := clWhite;
            TextOut(SurfaceX(Rect.Right - 2) - TextWidth(showstr), SurfaceY(Rect.Bottom) - 12, showstr, clWhite);
            //BoldTextOutEx(dsurface, SurfaceX(Rect.Right) - TextWidth(showstr), SurfaceY(Rect.Bottom) - 12, clwhite, clBlack, showstr);
            //Release;
          end;
        end;

      end
      else if g_UserKeySetup[idx].btType = UKTYPE_MAGIC then begin
        nMagID := g_UserKeySetup[idx].wIndex;
        if (nMagID > 0) and (nMagID < SKILL_MAX) then begin
          if g_MyMagicArry[nMagID].boStudy then begin
            d := g_WMagIconImages.Images[g_MyMagicArry[nMagID].Def.Magic.wMagicIcon];
            if d <> nil then begin
 
              boUse := ((GetTickCount - g_dwLatestSpellTick) < g_dwMagicDelayTime);
              if g_MyMagicArry[nMagID].boNotUse then begin
                dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
                  SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, $80808080, fxBlend);
              end
              else if g_MyMagicArry[nMagID].dwInterval > GetTickCount then begin
                dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
                  SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, $60808080, fxBlend);
                g_DXCanvas.DrawSquareSchedule(
                  100 - Round(100 / (g_MyMagicArry[nMagID].Def.Magic.nInterval / (g_MyMagicArry[nMagID].dwInterval - GetTickCount))),
                  SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
                  SurfaceY(Rect.Top + (RowHeight - d.Height) div 2),
                  d.ClientRect, d,
                  $FFFFFFFF, fxNone);
              end
              else begin
                dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
                  SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, False);

                if g_MyMagicArry[nMagID].boUse and not boUse and not g_boLatestSpell then begin
                  if (g_MyMagicArry[nMagID].btEffIdx < 9) then begin
                    if (GetTickCount > g_MyMagicArry[nMagID].dwTime) then begin
                      g_MyMagicArry[nMagID].dwTime := GetTickCount + 80;
                      Inc(g_MyMagicArry[nMagID].btEffIdx);
                    end;
                    d := g_WMain99Images.GetCachedImage(FLASHBASE + g_MyMagicArry[nMagID].btEffIdx, ax, ay);
                    if d <> nil then begin
                      dsurface.Draw(SurfaceX(Rect.Left + ax - 5),
                        SurfaceY(Rect.Top + ay - 12), d.ClientRect, d, fxAnti);
                    end;
                  end
                  else
                    g_MyMagicArry[nMagID].boUse := False;
                end;
              end;

              if g_boLatestSpell then begin
                g_DXCanvas.FillSquareSchedule(
                  0,
                  SurfaceX(Rect.Left + 2), SurfaceY(Rect.Top + 2), SurfaceX(Rect.Right - 2), SurfaceY(Rect.Bottom - 2),
                  $800000FF, fxBlend);
              end
              else if boUse then begin
                g_DXCanvas.FillSquareSchedule(
                  Round(100 / (g_dwMagicDelayTime / (GetTickCount - g_dwLatestSpellTick))),
                  SurfaceX(Rect.Left + 2), SurfaceY(Rect.Top + 2), SurfaceX(Rect.Right - 2), SurfaceY(Rect.Bottom - 2),
                  $800000FF, fxBlend);
              end; // else
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DUserKeyGrid1GridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
  procedure ClearUserKeyType(btType: Byte; nIdx: Integer);
  var
    i: integer;
  begin
    for i := Low(g_UserKeySetup) to High(g_UserKeySetup) do begin
      if (g_UserKeySetup[i].btType = btType) and (g_UserKeySetup[i].wIndex = nIdx) then begin
        g_UserKeySetup[i].btType := 0;
        g_UserKeySetup[i].wIndex := 0;
      end;
    end;
  end;
var
  idx, nIndex: Integer;
  OldIdx: Integer;
  OldType: Byte;
  boValid: Boolean;
  boSend: Boolean;
  Item: TNewClientItem;
begin
  if (GetTickCount - m_dwDblClick) < 500 then
    Exit;
  boSend := False;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + Tag * 12;
    if idx in [Low(g_UserKeySetup)..High(g_UserKeySetup)] then begin
      if g_boItemMoving then begin
        OldIdx := -1;
        OldType := 0;
        boValid := UserKeyInfoIsValid(idx, nIndex);
        if boValid then begin
          OldType := g_UserKeySetup[idx].btType;
          OldIdx := g_UserKeySetup[idx].wIndex;
        end;
        if g_MovingItem.ItemType = mtStateMagic then begin
          ClearUserKeyType(UKTYPE_MAGIC, LoWord(g_MovingItem.Index2));
          g_UserKeySetup[idx].btType := UKTYPE_MAGIC;
          g_UserKeySetup[idx].wIndex := LoWord(g_MovingItem.Index2);
          g_boItemMoving := False;
          boSend := True;
        end
        else if g_MovingItem.ItemType = mtBagItem then begin
          if (g_MovingItem.Item.s.Name <> '') and IsUserKeyItem(@g_MovingItem.item.s) then begin
            ClearUserKeyType(UKTYPE_ITEM, g_MovingItem.item.s.Idx + 1);
            g_UserKeySetup[idx].btType := UKTYPE_ITEM;
            g_UserKeySetup[idx].wIndex := g_MovingItem.item.s.Idx + 1;
            AdditemBag(g_MovingItem.item, g_MovingItem.Index2);
            RefUserKeyItemInfo(@g_MovingItem.item);
            ClearMovingItem();

            boSend := True;
          end;
        end
        else if g_MovingItem.ItemType = mtBottom then begin
          g_UserKeySetup[idx].btType := LoWord(g_MovingItem.Index2);
          g_UserKeySetup[idx].wIndex := HiWord(g_MovingItem.Index2);
          if g_UserKeySetup[idx].btType = UKTYPE_ITEM then begin
            Item.s := GetStdItem(g_UserKeySetup[idx].wIndex);
            Item.UserItem.wIndex := g_UserKeySetup[idx].wIndex;
            RefUserKeyItemInfo(@Item);
          end;
          g_boItemMoving := False;
          boSend := True;
        end;
        if boValid and (OldType > 0) and (not g_boItemMoving) and
          ((g_UserKeySetup[idx].btType <> OldType) or (g_UserKeySetup[idx].wIndex <> OldIdx)) then begin
          g_boItemMoving := True;
          g_MovingItem.ItemType := mtBottom;
          g_MovingItem.Item.s := GetStdItem(OldIdx);
          g_MovingItem.Item.s.Looks := nIndex;
          g_MovingItem.Index2 := MakeLong(OldType, OldIdx);
          boSend := True;
        end;
      end
      else begin
        if UserKeyInfoIsValid(idx, nIndex) then begin
          g_boItemMoving := True;
          g_MovingItem.ItemType := mtBottom;
          g_MovingItem.Item.s := GetStdItem(g_UserKeySetup[idx].wIndex);
          g_MovingItem.Item.s.Looks := nIndex;
          g_MovingItem.Index2 := MakeLong(g_UserKeySetup[Idx].btType, g_UserKeySetup[idx].wIndex);
          g_UserKeySetup[idx].btType := 0;
          g_UserKeySetup[idx].wIndex := 0;
          boSend := True;
        end;
      end;
      if boSend then
        FrmMain.SendClientSocket(CM_USERKEYSETUP, 0, 0, 0, 0, EncodeBuffer(@g_UserKeySetup, SizeOf(g_UserKeySetup)));
    end;
  end;
end;

procedure TFrmDlg.DUserKeyGrid2DblClick(Sender: TObject);
var
  idx, nItemID: Integer;
begin
  if g_boItemMoving and (g_MovingItem.Item.S.name <> '') and (g_MovingItem.ItemType = mtBottom) and (sm_Eat in g_MovingItem.Item.S.StdModeEx) then
  begin
    //DScreen.AddSysMsg('[' + GetStditem(g_UserKeySetup[idx].wIndex).Name + ' 已经用完]', clYellow);
    frmMain.EatItem(-1);
    exit;
  end;
  m_dwDblClick := GetTickCount;
  with Sender as TDGrid do begin
    idx := m_nMouseIdx;
    if idx in [Low(g_UserKeySetup)..High(g_UserKeySetup)] then begin
      if g_UserKeySetup[idx].btType = UKTYPE_ITEM then begin
        nItemID := GetBagItemIdx(g_UserKeySetup[idx].wIndex);
        if nItemID <> -1 then
          FrmMain.EatItem(nItemID)
        else
          DScreen.AddSysMsg('[' + GetStditem(g_UserKeySetup[idx].wIndex).Name + ' 已经用完]', clYellow);
      end;
    end;
  end;
end;

function TFrmDlg.UserKeyInfoIsValid(nIdx: Byte; var nIndex: Integer): Boolean;
var
  nMagID: Integer;
begin
  Result := False;
  if g_UserKeySetup[nIdx].btType = UKTYPE_ITEM then begin
    nMagID := GetStditemLook(g_UserKeySetup[nIdx].wIndex);
    if nMagID > 0 then begin
      nIndex := nMagID;
      Result := True;
    end;
  end
  else if g_UserKeySetup[nIdx].btType = UKTYPE_MAGIC then begin
    nMagID := g_UserKeySetup[nIdx].wIndex;
    if (nMagID > 0) and (nMagID < SKILL_MAX) then begin
      if g_MyMagicArry[nMagID].boStudy then begin
        Result := True;
        nIndex := g_MyMagicArry[nMagID].Def.Magic.wMagicIcon;
      end;
    end;
  end;
end;

procedure TFrmDlg.DUserStateBTInfoDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
{$IF Var_Interface = Var_Default}
  idx: integer;
  FColor: TColor;
{$IFEND}
  nTop: Byte;
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      nTop := 0;
      if UserStatePage = tag then begin
        d := WLib.Images[FaceIndex];
      end else begin
        d := WLib.Images[FaceIndex + 1];
        nTop := 2;
      end;

      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top) + nTop, d.ClientRect, d, True);
    end;
  end;
{$ELSE}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := FaceIndex;
      FColor := DFMoveColor;
      nTop := 0;
      if UserStatePage <> tag then begin
        FColor := DFColor;
        //Top := 2;
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

procedure TFrmDlg.DUserStateBTItemClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if UserStatePage <> Tag then begin
      UserStatePage := Tag;
      UserPageChanged;
      PlaySound(s_glass_button_click);
    end;
  end;
end;

procedure TFrmDlg.DUserStateDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
{$IF Var_Interface = Var_Default}
  str: string;
{$IFEND}
begin
  if g_MySelf = nil then
    exit;

  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      DrawWindow(DSurface, ax, ay, d);
{$IF Var_Interface = Var_Mir2}
      d := WLib.Images[1776 + UserStatePage];
      if d <> nil then
        DrawWindow(DSurface, ax + 16, ay + 90, d);
{$ELSE}
      d := WLib.Images[246 + UserStatePage];
      if d <> nil then
        DrawWindow(DSurface, ax + 8, ay + 37, d);  
{$IFEND}

    end;
    with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
        TextOut(ax + Width div 2 - TextWidth(UserState1.UserName) div 2, ay + 17, $B1D2B7, UserState1.UserName);
{$ELSE}
      if g_boUseWuXin then begin
        str := UserState1.UserName + '【' + GetWuXinName(UserState1.btWuXin) + '】';
        ax := ax + Width div 2 - TextWidth(str) div 2;
        TextOut(ax, ay + 12, $B1D2B7, UserState1.UserName + '【');
        TextOut(ax + TextWidth(UserState1.UserName + '【'), ay + 12, GetWuXinColor(UserState1.btWuXin), GetWuXinName(UserState1.btWuXin));
        TextOut(ax + TextWidth(UserState1.UserName + '【' + GetWuXinName(UserState1.btWuXin)), ay + 12, $B1D2B7, '】');
      end else begin
        str := UserState1.UserName;
        ax := ax + Width div 2 - TextWidth(str) div 2;
        TextOut(ax, ay + 12, $B1D2B7, UserState1.UserName);
      end;  
{$IFEND}


    end;
  end;
end;

procedure TFrmDlg.DUserStateItemClick(Sender: TObject; X, Y: Integer);
begin
  if boSelectGuildName then begin
    PlayScene.SetEditChar(UserState1.GuildName);
  end
  else if boSelectGuildRankName then begin
    PlayScene.SetEditChar(UserState1.GuildRankName);
  end;
end;

procedure TFrmDlg.DUserStateItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
const
  nWidth = 100;
  nHeight = 120;
var
  d: TDXTexture;
  ax, ay, bbx, bby, idx: integer;
  Rect: TRect;
  FontColor: TColor;
  AddAbility: TAddAbility;
  I: Integer;
  StdItem: TStdItem;
  str: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left) - Left;
    ay := SurfaceY(Top) - Top;
    if Sender = DUserStateItem then begin
{$IF Var_Interface = Var_Mir2}
      d := g_WMain99Images.Images[236 + Integer((DRESSfeature(UserState1.Feature) mod 2) = 1)];
      if d <> nil then
        dsurface.Draw(ax + 99 + 1, ay + 117 + 29, d.ClientRect, d, True);

      bbx := left + 37;
      bby := Top + 55;
{$ELSE}
      d := g_WMain99Images.Images[236 + Integer((DRESSfeature(UserState1.Feature) mod 2) = 1)];
      if d <> nil then
        dsurface.Draw(ax + 245 - 146, ay + 145 - 28, d.ClientRect, d, True);

      bbx := left + 44;
      bby := Top + 89 - 10;
{$IFEND}
      if UserState1.UseItems[U_DRESS].S.name <> '' then begin
        idx := UserState1.UseItems[U_DRESS].S.looks;
        if idx >= 0 then begin
          d := GetStateItemImgXY(idx, ax, ay);
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);

          if UserState1.UseItems[U_DRESS].S.AniCount = 29 then begin
            d := GetStateItemImgXY(2425, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_DRESS].S.AniCount = 30 then begin
            d := GetStateItemImgXY(2426, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_DRESS].S.AniCount = 33 then begin
            d := GetStateItemImgXY(2541, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_DRESS].S.AniCount = 34 then begin
            d := GetStateItemImgXY(2543, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end;
        end;
      end;

      idx := HUMHAIRANFRAME * (HAIRfeature(UserState1.Feature) + 1) - 1;
      if idx > 0 then begin
        d := g_WHairImgImages.GetCachedImage(idx, ax, ay);
        if d <> nil then
          dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
      end;

      if UserState1.UseItems[U_WEAPON].S.name <> '' then begin
        idx := UserState1.UseItems[U_WEAPON].S.looks;
        if idx >= 0 then begin
          d := GetStateItemImgXY(idx, ax, ay);
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);

          if UserState1.UseItems[U_WEAPON].S.AniCount = 21 then begin
            d := g_WMain99Images.GetCachedImage(1438, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_WEAPON].S.AniCount = 23 then begin
            d := GetStateItemImgXY(1890 + Integer((GetTickCount - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_WEAPON].S.AniCount = 31 then begin
            d := GetStateItemImgXY(2427, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_WEAPON].S.AniCount = 35 then begin
            d := GetStateItemImgXY(2530 + Integer((GetTickCount - AppendTick) div 200 mod 8), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_WEAPON].S.AniCount = 37 then begin
            d := GetStateItemImgXY(2550 + Integer((GetTickCount - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_WEAPON].S.AniCount = 39 then begin
            d := GetStateItemImgXY(2560 + Integer((GetTickCount - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end;
        end;
      end;
      if not UserState1.boHideHelmet then begin
        if UserState1.UseItems[U_HELMET].S.name <> '' then begin
          idx := UserState1.UseItems[U_HELMET].S.looks;
          if idx >= 0 then begin
            d := GetStateItemImgXY(idx, ax, ay);
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
          end;
        end;
      end;
      //      bbx := Left  + 233;
      //      bby := Top  + 3;
            {idx := (GetTickCount - AppendTick) div 150 mod 10;
            d := g_WMain99Images.GetCachedImage(534 + (UserState1.btWuXinLevel * 20) + idx, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);  }

      with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
        if (MouseEntry = msin) and (boSelectGuildName) then
          FontColor := clSilver
        else
          FontColor := clWhite;
        TextOut(SurfaceX(Left) + 2, SurfaceY(Top) + 2, UserState1.GuildName, FontColor);
        nUS1GuildNameLen := TextWidth(UserState1.GuildName);
        if (MouseEntry = msin) and (boSelectGuildRankName) then
          FontColor := clSilver
        else
          FontColor := clWhite;
        TextOut(SurfaceX(Left) + 2, SurfaceY(Top) + 16, UserState1.GuildRankName, FontColor);
        nUS1GuildRankNameLen := TextWidth(UserState1.GuildRankName);
{$ELSE}
        if (MouseEntry = msin) and (boSelectGuildName) then
          FontColor := clSilver
        else
          FontColor := clWhite;
        TextOut(SurfaceX(50), SurfaceY(45), UserState1.GuildName, FontColor);
        nUS1GuildNameLen := TextWidth(UserState1.GuildName);
        if (MouseEntry = msin) and (boSelectGuildRankName) then
          FontColor := clSilver
        else
          FontColor := clWhite;
        TextOut(SurfaceX(50), SurfaceY(60), UserState1.GuildRankName, FontColor);
        nUS1GuildRankNameLen := TextWidth(UserState1.GuildRankName);
{$IFEND}
      end;
    end
    else if Sender = DUserStateInfo then begin
      if UserHDInfoSurface <> nil then begin
        DUserStateInfoRefPic.Enabled := False;
        DUserStateInforeport.Enabled := True;
        Rect.Left := 0;
{$IF Var_Interface = Var_Mir2}
        ax := ax + Left + 16;
        aY := aY + Top + 7; 
{$ELSE}
        ax := ax + 28;
        aY := aY + 74; 
{$IFEND}
        if UserHDInfoSurface.Width < nWidth then begin
          ax := ax + (nWidth - UserHDInfoSurface.Width) div 2;
          Rect.Right := UserHDInfoSurface.Width;
        end
        else begin
          Rect.Right := nWidth;
        end;
        Rect.Top := 0;
        if UserHDInfoSurface.Height < nHeight then begin
          aY := aY + (nHeight - UserHDInfoSurface.Height) div 2;
          Rect.Bottom := UserHDInfoSurface.Height;
        end
        else begin
          Rect.Bottom := nHeight;
        end;
        dsurface.Draw(aX, aY, Rect, UserHDInfoSurface, False);
      end
      else begin
        DUserStateInforeport.Enabled := False;
        d := g_WMain99Images.Images[252 + Integer(UserState1.RealityInfo.sPhotoID <> '')];
        if d <> nil then
{$IF Var_Interface = Var_Mir2}
          dsurface.Draw(ax + Left + 16, ay + Top + 7, d.ClientRect, d, True);
{$ELSE}
          dsurface.Draw(ax + 28, ay + 74, d.ClientRect, d, True);  
{$IFEND}
        if Length(UserState1.RealityInfo.sPhotoID) = (SizeOf(UserState1.RealityInfo.sPhotoID) - 1) then
          DUserStateInfoRefPic.Enabled := True
        else
          DUserStateInfoRefPic.Enabled := False;
      end;
    end else
    if Sender = DUserStateHorse then begin
{$IF Var_Interface = Var_Mir2}
      with g_DXCanvas do begin
        if UserState1.UseItems[U_HOUSE].S.name <> '' then begin
          GetHorseLevelAbility(@UserState1.UseItems[U_HOUSE].UserItem, @UserState1.UseItems[U_HOUSE].S, AddAbility);
          for I := Low(UserState1.UseItems[U_HOUSE].UserItem.HorseItems) to High(UserState1.UseItems[U_HOUSE].UserItem.HorseItems) do begin
            if UserState1.UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex > 0 then begin
              StdItem := GetStditem(UserState1.UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex);
              if StdItem.Name <> '' then
                GetHorseAddAbility(@UserState1.UseItems[U_HOUSE].UserItem, @StdItem, I, AddAbility);
            end;
          end;

          d := g_WMain99Images.Images[1775];
          if d <> nil then begin
            Rect := d.ClientRect;
            Rect.Right := _MIN(Round(Rect.Right / (UserState1.UseItems[U_HOUSE].UserItem.dwMaxExp / UserState1.UseItems[U_HOUSE].UserItem.dwExp)), rect.Right);
            dsurface.Draw(ax + 68, ay + 129, Rect, d, True);
          end;

          d := g_WMain99Images.Images[1774];
          if d <> nil then begin
            Rect := d.ClientRect;
            Rect.Right := _MIN(Round(Rect.Right / (AddAbility.HP / UserState1.UseItems[U_HOUSE].UserItem.wHP)), rect.Right);
            dsurface.Draw(ax + 68, ay + 115, Rect, d, True);
          end;

          TextOut(ax + 66, ay + 97, $FFFFFF, IntToStr(UserState1.UseItems[U_HOUSE].UserItem.btLevel));

          if UserState1.UseItems[U_HOUSE].UserItem.btAliveTime > 0 then begin
            TextOut(ax + 132, ay + 97, $C0C0C0, '已死亡 ' + IntToStr(UserState1.UseItems[U_HOUSE].UserItem.btAliveTime) + '分钟后自动复活');
          end else begin
            TextOut(ax + 132, ay + 97, $00FF00, '正常');
          end;

          str := IntToStr(UserState1.UseItems[U_HOUSE].UserItem.wHP) + '/' + IntToStr(AddAbility.HP);
          TextOut(ax + 153 - TextWidth(str) div 2, ay + 112, $FFFFFF, str);

          
          str := IntToStr(UserState1.UseItems[U_HOUSE].UserItem.dwExp) + '/' + IntToStr(UserState1.UseItems[U_HOUSE].UserItem.dwMaxExp);
          TextOut(ax + 153 - TextWidth(str) div 2, ay + 126, $FFFFFF, str);



          TextOut(ax + 88, ay + 300, $FFFFFF, IntToStr(AddAbility.AC) + '-' + IntToStr(AddAbility.AC2));
          TextOut(ax + 88, ay + 314, $FFFFFF, IntToStr(AddAbility.MAC) + '-' + IntToStr(AddAbility.MAC2));
          TextOut(ax + 88, ay + 328, $FFFFFF, IntToStr(AddAbility.DC) + '-' + IntToStr(AddAbility.DC2));
          TextOut(ax + 206, ay + 300, $FFFFFF, IntToStr(AddAbility.wHitPoint));
          TextOut(ax + 206, ay + 314, $FFFFFF, IntToStr(AddAbility.wSpeedPoint));

          d := g_WRideImages.GetCachedImage(RIDEFRAME * (UserState1.UseItems[U_HOUSE].S.Shape - 1) + 80 + Integer((GetTickCount - AppendTick) div 120 mod 8), bbx, bby);
          if d <> nil then
            dsurface.Draw(aX + bbx + 130, aY + bby + 205, d.ClientRect, d, True);
        end;
      end;
{$ELSE}
      with g_DXCanvas do begin
        if UserState1.UseItems[U_HOUSE].S.name <> '' then begin
          GetHorseLevelAbility(@UserState1.UseItems[U_HOUSE].UserItem, @UserState1.UseItems[U_HOUSE].S, AddAbility);
          for I := Low(UserState1.UseItems[U_HOUSE].UserItem.HorseItems) to High(UserState1.UseItems[U_HOUSE].UserItem.HorseItems) do begin
            if UserState1.UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex > 0 then begin
              StdItem := GetStditem(UserState1.UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex);
              if StdItem.Name <> '' then
                GetHorseAddAbility(@UserState1.UseItems[U_HOUSE].UserItem, @StdItem, I, AddAbility);
            end;
          end;

          d := g_WMain99Images.Images[1520];
          if d <> nil then begin
            Rect := d.ClientRect;
            Rect.Right := _MIN(Round(Rect.Right / (UserState1.UseItems[U_HOUSE].UserItem.dwMaxExp / UserState1.UseItems[U_HOUSE].UserItem.dwExp)), rect.Right);
            dsurface.Draw(ax + 56, ay + 109, Rect, d, True);
          end;

          d := g_WMain99Images.Images[1521];
          if d <> nil then begin
            Rect := d.ClientRect;
            Rect.Right := _MIN(Round(Rect.Right / (AddAbility.HP / UserState1.UseItems[U_HOUSE].UserItem.wHP)), rect.Right);
            dsurface.Draw(ax + 56, ay + 91, Rect, d, True);
          end;

          ArrestStringEx(UserState1.UseItems[U_HOUSE].S.Name, '(', ')', str);
          TextOut(ax + 142 - TextWidth(str) div 2, ay + 51, $FFFFFF, str);

          TextOut(ax + 21, ay + 72, $B5EBEF, '等级：');
          TextOut(ax + 56, ay + 72, $FFFFFF, IntToStr(UserState1.UseItems[U_HOUSE].UserItem.btLevel));
          TextOut(ax + 84, ay + 72, $B5EBEF, '状态：');
          if UserState1.UseItems[U_HOUSE].UserItem.btAliveTime > 0 then begin
            TextOut(ax + 120, ay + 72, $C0C0C0, '已死亡 ' + IntToStr(UserState1.UseItems[U_HOUSE].UserItem.btAliveTime) + '分钟后自动复活');
          end else begin
            TextOut(ax + 120, ay + 72, $00FF00, '正常');
          end;
          TextOut(ax + 21, ay + 90, $B5EBEF, '生命：');
          str := IntToStr(UserState1.UseItems[U_HOUSE].UserItem.wHP) + '/' + IntToStr(AddAbility.HP);

          TextOut(ax + 165 - TextWidth(str) div 2, ay + 90, $FFFFFF, str);
          TextOut(ax + 21, ay + 108, $B5EBEF, '经验：');
          str := IntToStr(UserState1.UseItems[U_HOUSE].UserItem.dwExp) + '/' + IntToStr(UserState1.UseItems[U_HOUSE].UserItem.dwMaxExp);
          TextOut(ax + 165 - TextWidth(str) div 2, ay + 108, $FFFFFF, str);
          TextOut(ax + 21, ay + 319, $B5EBEF, '坐骑防御：');
          TextOut(ax + 81, ay + 319, $FFFFFF, IntToStr(AddAbility.AC) + '-' + IntToStr(AddAbility.AC2));
          TextOut(ax + 21, ay + 337, $B5EBEF, '坐骑魔御：');
          TextOut(ax + 81, ay + 337, $FFFFFF, IntToStr(AddAbility.MAC) + '-' + IntToStr(AddAbility.MAC2));
          TextOut(ax + 21, ay + 355, $B5EBEF, '坐骑攻击：');
          TextOut(ax + 81, ay + 355, $FFFFFF, IntToStr(AddAbility.DC) + '-' + IntToStr(AddAbility.DC2));

          TextOut(ax + 143, ay + 319, $B5EBEF, '坐骑准确：');
          TextOut(ax + 203, ay + 319, $FFFFFF, IntToStr(AddAbility.wHitPoint));
          //TextOut(ax + 143, ay + 319, $B5EBEF, '坐骑生命：');
          //TextOut(ax + 203, ay + 319, $FFFFFF, IntToStr(UserState1.UseItems[U_HOUSE].UserItem.wHP) + '/' + IntToStr(AddAbility.HP));
          TextOut(ax + 143, ay + 337, $B5EBEF, '坐骑敏捷：');
          TextOut(ax + 203, ay + 337, $FFFFFF, IntToStr(AddAbility.wSpeedPoint));
          //TextOut(ax + 143, ay + 355, $B5EBEF, '坐骑敏捷：');
          //TextOut(ax + 203, ay + 355, $FFFFFF, IntToStr(AddAbility.wSpeedPoint));

          d := g_WRideImages.GetCachedImage(RIDEFRAME * (UserState1.UseItems[U_HOUSE].S.Shape - 1) + 80 + Integer((GetTickCount - AppendTick) div 120 mod 8), bbx, bby);
          if d <> nil then
            dsurface.Draw(aX + bbx + 130, aY + bby + 200, d.ClientRect, d, True);
         
        end else begin
          TextOut(ax + 21, ay + 72, $B5EBEF, '等级：');
          TextOut(ax + 114, ay + 72, $B5EBEF, '剩余时间：');
          TextOut(ax + 21, ay + 90, $B5EBEF, '经验：');
          TextOut(ax + 21, ay + 108, $B5EBEF, '饥饿：');
          TextOut(ax + 21, ay + 319, $B5EBEF, '坐骑防御：');
          TextOut(ax + 21, ay + 337, $B5EBEF, '坐骑魔御：');
          TextOut(ax + 21, ay + 355, $B5EBEF, '坐骑准确：');
          TextOut(ax + 143, ay + 319, $B5EBEF, '坐骑生命：');
          TextOut(ax + 143, ay + 337, $B5EBEF, '坐骑攻击：');
          TextOut(ax + 143, ay + 355, $B5EBEF, '坐骑敏捷：');
        end;
      end;  
{$IFEND}
    end;
  end;
end;

procedure TFrmDlg.DUserStateItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  StateAbilIndex := -1;
{$IF Var_Interface = Var_Mir2}
  if Sender = DUserStateItem then begin
    boSelectGuildName := False;
    boSelectGuildRankName := False;
    if (x >= 74) and (x <= 74 + 48) and (y >= 137) and (y <= 137 + 98) then begin
      DWeaponUS1MouseMove(DWeaponUS1, Shift, X - DUserStateItem.Left, Y - DUserStateItem.Top);
    end
    else if (x >= 123) and (x <= 123 + 48) and (y >= 170) and (y <= 170 + 120) then begin
      DWeaponUS1MouseMove(DDressUS1, Shift, X - DUserStateItem.Left, Y - DUserStateItem.Top);
    end
    else if (x >= 123) and (x <= 123 + 48) and (y >= 137) and (y <= 137 + 32) then begin
      DWeaponUS1MouseMove(DHelmetUS1, Shift, X - DUserStateItem.Left, Y - DUserStateItem.Top);
    end
    else if (x >= 16) and (x <= 16 + nUS1GuildNameLen) and (y >= 90) and (y <= 104) then begin  
      boSelectGuildName := True;
    end
    else if (x >= 16) and (x <= 16 + nUS1GuildRankNameLen) and (y >= 105) and (y <= 119) then begin
      boSelectGuildRankName := True;
    end;
  end;
{$ELSE}
  if Sender = DUserStateItem then begin
    boSelectGuildName := False;
    boSelectGuildRankName := False;
    if (x >= 80) and (x <= 80 + 34) and (y >= 121 - 10) and (y <= 121 + 98 - 10) then begin
      DWeaponUS1MouseMove(DWeaponUS1, Shift, X - DUserStateItem.Left, Y - DUserStateItem.Top);
    end
    else if (x >= 114) and (x <= 114 + 67) and (y >= 146 - 10) and (y <= 146 + 125 - 10) then begin
      DWeaponUS1MouseMove(DDressUS1, Shift, X - DUserStateItem.Left, Y - DUserStateItem.Top);
    end
    else if (x >= 129) and (x <= 129 + 29) and (y >= 121 - 10) and (y <= 121 + 25 - 10) then begin
      DWeaponUS1MouseMove(DHelmetUS1, Shift, X - DUserStateItem.Left, Y - DUserStateItem.Top);
    end
      {else if (x >= 226) and (x <= 226 + 42) and (y >= 45) and (y <= 45 + 42) then begin
        DWeaponUS1MouseMove(Sender, Shift, X, Y);
      end }
    else if (x >= 50) and (x <= 50 + nUS1GuildNameLen) and (y >= 45) and (y <= 59) then begin
      boSelectGuildName := True;
    end
    else if (x >= 50) and (x <= 50 + nUS1GuildRankNameLen) and (y >= 60) and (y <= 74) then begin
      boSelectGuildRankName := True;
    end;
  end;  
{$IFEND}

end;

procedure TFrmDlg.DUserStateVisible(Sender: TObject; boVisible: Boolean);
begin
  if not boVisible then begin
    //if FrmDlg.UserHDDIB <> nil then FrmDlg.UserHDDIB.Free;
    //FrmDlg.UserHDDIB := nil;
    if FrmDlg.UserHDInfoSurface <> nil then
      FrmDlg.UserHDInfoSurface.Free;
    FrmDlg.UserHDInfoSurface := nil;
  end;
end;

procedure TFrmDlg.DWeaponUS1DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  pRect: TRect;
begin
  with Sender as TDButton do begin
    if (Tag in [Low(UserState1.UseItems)..High(UserState1.UseItems)]) then begin
      if UserState1.UseItems[Tag].S.name <> '' then begin
        {if (sm_Arming in UserState1.UseItems[Tag].s.StdModeEx) then begin
          if CheckWuXinConsistent(UserState1.btWuXin, UserState1.UseItems[Tag].UserItem.Value.btWuXin) or
            CheckWuXinRestraint(UserState1.btWuXin, UserState1.UseItems[Tag].UserItem.Value.btWuXin) then begin
            d := g_WMain2Images.Images[260 + (GetTickCount - AppendTick) div 150 mod 6];
            if d <> nil then begin
              DrawBlend(dsurface, SurfaceX(Left) - 21, SurfaceY(Top) - 23, d, 1);
            end;
          end;
        end;  }
        d := GetBagItemImg(UserState1.UseItems[Tag].S.looks);
        if d <> nil then begin
          pRect.Left := SurfaceX(Left - 1);
          pRect.Top := SurfaceY(Top - 1);
          pRect.Right := SurfaceX(Left + Width + 1);
          pRect.Bottom := SurfaceY(Top + Height + 1);
          RefItemPaint(dsurface, d, //人物背包栏
            SurfaceX(Left + (Width - d.Width) div 2),
            SurfaceY(Top + (Height - d.Height) div 2),
            1,
            1,
            @UserState1.UseItems[Tag], False, [pmShowLevel], @pRect);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  sel: Integer;
  //  str: string;
begin
  with Sender as TDControl do begin
    if DParent = nil then
      exit;
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX + 30;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    sel := Tag;
    if (sel in [Low(UserState1.UseItems)..High(UserState1.UseItems)]) then begin
      if UserState1.UseItems[sel].s.Name <> '' then begin
        DScreen.ShowHint(nHintX,
          nHintY, ShowItemInfo(UserState1.UseItems[sel], [], [UserState1.btWuXin, Integer((DRESSfeature(UserState1.Feature) mod 2) = 1), Integer(@UserState1.UseItems[0])]), clwhite,
          False, Integer(Sender), True);
      end;

    end;
    //end;
  end;
end;

procedure TFrmDlg.DWndAttackModeListDirectPaint(Sender: TObject; dsurface: TDXTexture);
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
  end;
end;

procedure TFrmDlg.DWinSelServerClick(Sender: TObject; X, Y: Integer);
begin

  {if (SelServerIndex <> MoveServerIndex) and (MoveServerIndex <> -1) then begin
    SelServerIndex := MoveServerIndex;
    PlaySound(s_glass_button_click);
  end; }

end;

procedure TFrmDlg.DWinSelServerDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  //  ServerInfo: pTServerInfo;
  //  i: integer;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);

      
{$IF Var_Interface =  Var_Default}
    d := WLib.Images[365];
    if d <> nil then begin
      dsurface.Draw(ax + (width - d.width) div 2, ay + 9, d.ClientRect, d, True);
    end;
{$IFEND}
    {for i := 0 to g_ServerList.Count - 1 do begin
      if MoveServerIndex = i then
        d := WLib.Images[20]
      else if SelServerIndex = i then
        d := WLib.Images[19]
      else
        d := WLib.Images[18];
      if d <> nil then begin
        dsurface.Draw(ax + 29 + i mod 4 * 179, ay + 64 + i div 4 * 40, d.ClientRect, d, True);
      end;
    end;     }

    {with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      for i := 0 to g_ServerList.Count - 1 do begin
        ServerInfo := g_ServerList[i];
        TextOut(ax + 54 + i mod 4 * 179, ay + 71 + i div 4 * 40, clWhite, ServerInfo.ShowName);
      end;
      //Release;
    end; }
  end;
end;

procedure TFrmDlg.DWinSelServerExitClick(Sender: TObject; X, Y: Integer);
begin
  if (Sender = DLoginExit) or (Sender = dbtnSelServerClose) then
    FrmMain.Close;
  if Sender = DLoginOk then
    LoginScene.OkClick;
  //if Sender = DLoginNew then
    //LoginScene.NewClick;
  //if Sender = DLoginChgPw then
    //LoginScene.ChgPwClick;

  if Sender = DNewAccountOk then
    LoginScene.NewAccountOk;
  if (Sender = DNewAccountCancel) or (Sender = DNewAccountClose) then
    LoginScene.NewAccountClose;
  if Sender = DChgpwOk then
    LoginScene.ChgpwOk;
  if Sender = DChgpwCancel then
    LoginScene.ChgpwCancel;
end;

procedure TFrmDlg.DWinSelServerMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
{var
  acol, arow: integer; }
begin
  {  x := x - DWinSelServer.Left;
    y := y - DWinSelServer.Top;
    MoveServerIndex := -1;
    if (x >= 29) and (x <= 731) and (y >= 64) and (y <= 370) then begin
      x := x - 29;
      y := y - 64;
      acol := x div (164 + 15);
      arow := y div (25 + 15);
      if (X - (164 + 15) * (acol) - 164 <= 0) and
        (Y - (25 + 15) * (arow) - 25 <= 0) then begin
        acol := acol + arow * 4;
        if (acol < g_ServerList.Count) and (acol >= 0) then
          MoveServerIndex := acol;
      end;
    end;  }
end;

procedure TFrmDlg.DWinSelServerVisible(Sender: TObject; boVisible: Boolean);
begin
  if boVisible then begin
    FrmMain.FCheckLogin := False;
    FrmMain.Caption := g_sLogoText;
    dbtnSelServer1.Caption := g_ServerInfo[0].sName;
    dbtnSelServer2.Caption := g_ServerInfo[1].sName;
    dbtnSelServer3.Caption := g_ServerInfo[2].sName;
    dbtnSelServer4.Caption := g_ServerInfo[3].sName;
    dbtnSelServer5.Caption := g_ServerInfo[4].sName;
    dbtnSelServer6.Caption := g_ServerInfo[5].sName;
    dbtnSelServer7.Caption := g_ServerInfo[6].sName;
    dbtnSelServer8.Caption := g_ServerInfo[7].sName;

    dbtnSelServer1.Visible := g_ServerInfoCount > 0;
    dbtnSelServer2.Visible := g_ServerInfoCount > 1;
    dbtnSelServer3.Visible := g_ServerInfoCount > 2;
    dbtnSelServer4.Visible := g_ServerInfoCount > 3;
    dbtnSelServer5.Visible := g_ServerInfoCount > 4;
    dbtnSelServer6.Visible := g_ServerInfoCount > 5;
    dbtnSelServer7.Visible := g_ServerInfoCount > 6;
    dbtnSelServer8.Visible := g_ServerInfoCount > 7;
  end;
end;

procedure TFrmDlg.dbtnSelServer1Click(Sender: TObject; X, Y: Integer);
var
  sAddr, sPort, sAddrs, sPorts{$IF Var_Free = 1}, sPassword{$IFEND}: string;
  nPort, K: Integer;
begin
  with Sender as TDButton do begin
    if (Tag in [Low(g_ServerInfo)..High(g_ServerInfo)]) then begin
      HintBack := stSelServer;
      sHintStr := '正在连接服务器。。。';
      DBTHintClose.Caption := '取消';
      boHintFocus := False;
{$IF Public_Ver <> Public_Test}
      g_sServerMiniName := g_ServerInfo[Tag].sName;
      g_sServerName := g_ServerInfo[Tag].sName;
{$ELSE}
      g_sServerMiniName := '本地测试';
      g_sServerName := '本地测试';
{$IFEND}
      FrmMain.Caption := g_sLogoText + ' - ' + g_sServerName;
      g_ConnectionStep := cnsLogin;
      {g_LoginAddr := g_ServerInfo[Tag].sAddrs;
      g_LoginPort := g_ServerInfo[Tag].wPort;
      with FrmMain.CSocket do begin
        Active := FALSE;
        Host := g_LoginAddr;
        Port := g_LoginPort;
        Active := True;
      end;          }
      DScreen.ChangeScene(stHint);
{$IFDEF RELEASE}
  {$IF Public_Ver <> Public_Release}
      sAddrs := g_ServerInfo[Tag].sAddrs;
      sPorts := g_ServerInfo[Tag].sPort;
  {$ELSE}
    {$IF Var_Free = 1}
      sPassword := 'http://www.361m2.com';
      sPassword := sPassword + '361免费版登录器';
      sPassword := sPassword + '361免费版登录器';
      sPassword := GetMD5TextOf16(sPassword);
      sAddrs := DecryStrHex(g_ServerInfo[Tag].sAddrs, sPassword);
      sPorts := DecryStrHex(g_ServerInfo[Tag].sPort, sPassword);
    {$ELSE}
      sAddrs := g_ServerInfo[Tag].sAddrs;
      sPorts := g_ServerInfo[Tag].sPort;
      //sAddrs := DecryStrHex(RState.DecryptStr(AnsiReplaceText(g_ServerInfo[Tag].sAddrs, '-', '=')), g_DESKey);
      //sPorts := DecryStrHex(RState.DecryptStr(AnsiReplaceText(g_ServerInfo[Tag].sPort, '-', '=')), g_DESKey);
    {$IFEND}
  {$IFEND}
{$ELSE}
      sAddrs := g_ServerInfo[Tag].sAddrs;
      sPorts := g_ServerInfo[Tag].sPort;
{$ENDIF}
      K := 0;
      Inc(FrmMain.FLoginConnIndex);
      FrmMain.FCheckLogin := True;
      FrmMain.FCheckCount := 0;
      while True do begin
        if k > 9 then
          break;
        sAddrs := GetValidStr3(sAddrs, sAddr, [',']);
        sPorts := GetValidStr3(sPorts, sPort, [',']);
        nPort := StrToIntDef(sPort, -1);
        if (sAddr <> '') and (nPort > 0) and (nPort < 65535) then begin
          FrmMain.FLoginConnInfos[K].sAddrs := sAddr;
          FrmMain.FLoginConnInfos[K].wPort := nPort;
          g_LoginAddr := sAddr;
          g_LoginPort := nPort;
          Inc(K);
          Inc(FrmMain.FCheckCount);
          FrmMain.CreateClientSocket(sAddr, nPort, MakeLong(FrmMain.FLoginConnIndex, K - 1));
        end
        else
          Break;
      end;
    end;
  end;
end;

procedure TFrmDlg.dbtnSelServer1ClickSound(Sender: TObject; Clicksound: TClickSound);
begin
{$IF Var_Interface = Var_Mir2}
  case Clicksound of
    csNorm: PlaySound(s_norm_button_click);
    csStone: PlaySound(s_glass_button_click);
    csGlass: PlaySound(s_rock_button_click);
  end;
{$ELSE}
  case Clicksound of
    csNorm: PlaySound(s_norm_button_click);
    csStone: PlaySound(s_rock_button_click);
    csGlass: PlaySound(s_glass_button_click);
  end;
{$IFEND}

end;

procedure TFrmDlg.dbtnSelServer1DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex + 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        with g_DXCanvas do begin
          TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2 + 1, SurfaceY(Top) + (Height - TextHeight(Caption)) div 2 + 1, Caption, $88ECF0);
        end;
      end else begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        with g_DXCanvas do begin
          TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2, SurfaceY(Top) + (Height - TextHeight(Caption)) div 2, Caption, $88ECF0);
        end;
      end;

    end;
  end;
end;

procedure TFrmDlg.DWndBuyDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  nCount: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);

    with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
      nCount := StrToIntDef(DBuyEdit.Text, 0);
      TextOut(ax + 78 - TextWidth(BuyGoods.ClientItem.s.Name) div 2, ay + 45, clYellow, BuyGoods.ClientItem.s.Name);
      TextOut(ax + 55, ay + 95, clWhite, IntToStr(nCount * BuyGoods.nItemPic) + ' 金币');
{$ELSE}
      nCount := StrToIntDef(DBuyEdit.Text, 0);
      TextOut(ax + 104 - TextWidth(BuyGoods.ClientItem.s.Name) div 2, ay + 29,
        clYellow, BuyGoods.ClientItem.s.Name);
      TextOut(ax + 46, ay + 75, clWhite, IntToStr(nCount * BuyGoods.nItemPic) + ' 金币');  
{$IFEND}

    end;
  end;
end;

procedure TFrmDlg.DWndBuyVisible(Sender: TObject; boVisible: Boolean);
begin
  if (not boVisible) and DEditChat.Visible then
    DEditChat.SetFocus;

end;

procedure TFrmDlg.DWndFaceClick(Sender: TObject; X, Y: Integer);
begin
  if (FaceSelectindex > -1) and (FaceSelectindex <= High(g_FaceIndexList)) then begin
    if not DEditChat.Visible then begin
      DBTEditClick(DBTEdit, 0, 0);
    end;
    DEditChat.AddImageToList(IntToStr(FaceSelectindex));
    DWndFace.Visible := False;
  end;
end;

procedure TFrmDlg.DWndFaceDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  i, nx, ny, ax, ay: Integer;
  py: smallint;
  //defRect, dRect: TRect;
begin
  with Sender as TDWindow do begin
    g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR or $64000000);
    //DrawAlphaOfColor(dsurface, SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR, 100);
    {DrawAlphaEx(dsurface, SurfaceX(Left), SurfaceX(Top), DScreen.m_HintBGSurface,
      0, 0, Width, Height, 1, 100);   }
    for i := Low(g_FaceIndexInfo) to High(g_FaceIndexInfo) do begin
      ax := left + (i) mod FACESHOWCOUNT * 24 + 4;
      ay := Top + +(i) div FACESHOWCOUNT * 24 + 4;
      d := g_WFaceImages.GetCachedImage(g_FaceIndexInfo[i].ImageIndex, nx, ny);
      if d <> nil then begin
        dsurface.Draw(ax, ay, d.ClientRect, d, True);
        py := ny;
        if (GetTickCount - g_FaceIndexInfo[i].dwShowTime) > LongWord(nx) then begin
          g_FaceIndexInfo[i].ImageIndex := g_FaceIndexInfo[i].ImageIndex + py;
          g_FaceIndexInfo[i].dwShowTime := GetTickCount;
        end;
      end;
      if FaceSelectindex = i then begin
        with g_DXCanvas do begin
          RoundRect(ax - 2, ay - 2, ax + 24, ay + 24, clSilver);
          //SetBkMode(Handle, TRANSPARENT);
          {Brush.Style := bsClear;
          Pen.Color := clSilver;
          Pen.Style := psAlternate;
          RoundRect(ax - 2, ay - 2, ax + 24, ay + 24, 0, 0); }
          //Release;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DWndFaceMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  FaceSelectindex := (X - DWndFace.Left) div 24 + (y - DWndFace.Top) div 24 * FACESHOWCOUNT;
  with Sender as TDWindow do begin
    if FaceSelectindex in [Low(g_FaceIndexInfo)..High(g_FaceIndexInfo)] then begin
      ShowMsg := g_FaceTextList1[FaceSelectindex];
      DScreen.ShowHint(x + 10, y + 30, ShowMsg, clWhite, False, FaceSelectindex);
    end;
  end;
end;

procedure TFrmDlg.DWndHintDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  idx, len: integer;
  str: WideString;
  str1, str2, str3: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        DrawWindow(dsurface, ax, ay, d);
      if sHintStr = '' then
        exit;
      str := sHintStr;
      len := length(str);
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        idx := Integer((GetTickCount - AppendTick) div 200 mod LongWord(len)) { + 1};
        str1 := Copy(str, 1, idx);
        str2 := Copy(str, idx + 1, 1);
        str3 := Copy(str, idx + 2, len);
{$IF Var_Interface = Var_Mir2}
        ay := ay + 33;
        ax := ax + 136 - TextWidth(str) div 2;
{$ELSE}
        ay := ay + 48;
        ax := ax + 138 - TextWidth(str) div 2;
{$IFEND}
        TextOut(ax, ay, clWhite{ $ADE7CE}, str1);
        ax := ax + TextWidth(str1);
        TextOut(ax, ay, $7BFFFF, str2);
        ax := ax + TextWidth(str2);
        TextOut(ax, ay, clWhite{ $ADE7CE}, str3);
        //Release;
      end;
    end;
  end;
end;

procedure TFrmDlg.DWndHintKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) or (Key = 27) then begin
    if boHintFocus then
      DBTHintCloseClick(DBTHintClose, 0, 0);
  end;
end;

procedure TFrmDlg.DWndHintVisible(Sender: TObject; boVisible: Boolean);
begin
  if boVisible then
    DWndHint.SetFocus;
end;

procedure TFrmDlg.DWndSayDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  i, ii: integer;
  sx, sy: integer;
  d: TDXTexture;
  nCount: integer;
  pMessage: pTSayMessage;
  SayImage: pTSayImage;
  nx, ny, ax, ay, nLeft: Integer;
  py: smallint;
  sStr: string;
  ClickName: pTClickName;
  ClickItem: pTClickItem;
begin
  with Sender as TDWindow do begin
    g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR or $50000000);
    //g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR or $50FFFFFF);
    //DrawAlphaOfColor(dsurface, SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR, 60);
    //DrawAlphaEx(dsurface, SurfaceX(Left), SurfaceX(Top), DScreen.m_HintBGSurface, 0, 0, Width, Height, 1, 60);
    sx := SurfaceX(Left) + 16;
    sy := SurfaceX(Top) + (SAYLISTHEIGHT - 12) div 2;
    nCount := Height div SAYLISTHEIGHT;
    with DScreen do begin
      DSayUpDown.MaxPosition := _MAX(0, m_SayTransferList.count - nCount);
      for i := DSayUpDown.Position to (DSayUpDown.Position + nCount - 1) do begin
        if i > m_SayTransferList.count - 1 then
          break;
        pMessage := m_SayTransferList[i];
        ClickName := nil;
        ClickItem := nil;
        if (pClickName <> nil) and (nClickNameIndex > 0) and (pMessage.ClickList <> nil) and
          (pMessage.ClickList.Count > 0) then begin
          for ii := 0 to pMessage.ClickList.Count - 1 do begin
            if pTClickName(pMessage.ClickList[ii]).Index = nClickNameIndex then begin
              ClickName := pMessage.ClickList[ii];
              break;
            end;
          end;
        end
        else if (pClickItem <> nil) and (nClickItemIndex > 0) and (pMessage.ItemList <> nil) and
          (pMessage.ItemList.Count > 0) then begin
          for ii := 0 to pMessage.ItemList.Count - 1 do begin
            if pTClickItem(pMessage.ItemList[ii]).Index = nClickItemIndex then begin
              ClickItem := pMessage.ItemList[ii];
              break;
            end;
          end;
        end;
        ax := sx;
        ay := sy + (i - DSayUpDown.Position) * SAYLISTHEIGHT;
        dsurface.Draw(ax, ay, pMessage.SaySurface.ClientRect, pMessage.SaySurface, True);
        if (pMessage.ImageList <> nil) and (pMessage.ImageList.Count > 0) then begin
          for ii := 0 to pMessage.ImageList.Count - 1 do begin
            SayImage := pMessage.ImageList[ii];
            if (SayImage.nIndex <= High(g_FaceIndexInfo)) then begin
              d := g_WFaceImages.GetCachedImage(g_FaceIndexInfo[SayImage.nIndex].ImageIndex, nx, ny);
              if d <> nil then begin
                dsurface.Draw(ax + SayImage.nLeft, ay + (SAYLISTHEIGHT - d.Height) div 2 - 1, d.ClientRect, d, True);
                py := ny;
                if (GetTickCount - g_FaceIndexInfo[SayImage.nIndex].dwShowTime) > LongWord(nx) then begin
                  g_FaceIndexInfo[SayImage.nIndex].ImageIndex := g_FaceIndexInfo[SayImage.nIndex].ImageIndex + py;
                  g_FaceIndexInfo[SayImage.nIndex].dwShowTime := GetTickCount;
                end;
              end;
            end;
          end;
        end;
        if (i = pClickIndex) then begin
          sStr := '';
          nLeft := 0;
          if pClickName <> nil then begin
            sStr := pClickName.sStr;
            nLeft := pClickName.nLeft;
          end
          else if pClickItem <> nil then begin
            sStr := pClickItem.sStr;
            nLeft := pClickItem.nLeft;
          end;
          if sStr <> '' then begin
            with g_DXCanvas do begin
              //SetBkMode(Handle, TRANSPARENT);
              if SayDlgDown then
                TextOut(ax + nLeft + 1, ay + 3, clWhite, sstr)
              else
                TextOut(ax + nLeft, ay + 2, clWhite, sstr);
              //Release;
            end;
          end;
        end
        else begin
          sStr := '';
          nLeft := 0;
          if ClickName <> nil then begin
            sStr := ClickName.sStr;
            nLeft := ClickName.nLeft;
          end
          else if ClickItem <> nil then begin
            sStr := ClickItem.sStr;
            nLeft := ClickItem.nLeft;
          end;
          if sStr <> '' then begin
            with g_DXCanvas do begin
              //SetBkMode(Handle, TRANSPARENT);
              if SayDlgDown then
                TextOut(ax + nLeft + 1, ay + 3, clWhite, sstr)
              else
                TextOut(ax + nLeft, ay + 2, clWhite, sstr);
              //Release;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DWndSayEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay: Integer;
begin
  if dwndWhisperName.Visible then begin
    with DEditChat do begin
      ax := SurfaceX(Left + Width);
      ay := SurfaceY(Top);
      with g_DXCanvas do begin
        TextOut(ax - TextWidth('[上下方向键选择，空格或回车键确定选择]'), ay + 2, $808080,
          '[上下方向键选择，空格或回车键确定选择]');
      end;
    end;
  end;
end;

procedure TFrmDlg.DWndSayInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
var
  ii, nX, nY: integer;
  pMessage: pTSayMessage;
  ClickName: pTClickName;
  ClickItem: pTClickItem;
begin
  IsRealArea := False;
  with Sender as TDWindow do begin
    pClickName := nil;
    pClickItem := nil;
    nClickNameIndex := 0;
    nClickItemIndex := 0;
    nX := X - 16;
    nY := Y;
    pClickIndex := DSayUpDown.Position + nY div SAYLISTHEIGHT;
    with DScreen do begin
      if (pClickIndex >= 0) and (pClickIndex < m_SayTransferList.count) then begin
        pMessage := m_SayTransferList[pClickIndex];
        if (pMessage.ClickList <> nil) and (pMessage.ClickList.Count > 0) then begin
          for ii := 0 to pMessage.ClickList.Count - 1 do begin
            ClickName := pMessage.ClickList[ii];
            if (nX >= ClickName.nLeft) and (nX <= ClickName.nRight) then begin
              pClickName := ClickName;
              nClickNameIndex := ClickName.Index;
              IsRealArea := True;
              break;
            end;
          end;
        end;
        if (pClickName = nil) and (pMessage.ItemList <> nil) and (pMessage.ItemList.Count > 0) then begin
          for ii := 0 to pMessage.ItemList.Count - 1 do begin
            ClickItem := pMessage.ItemList[ii];
            if (nX >= ClickItem.nLeft) and (nX <= ClickItem.nRight) then begin
              pClickItem := ClickItem;
              nClickItemIndex := ClickItem.Index;
              IsRealArea := True;
              break;
            end;
          end;
        end;
      end;
    end;
  end;

end;

procedure TFrmDlg.dwndSayModeDirectPaint(Sender: TObject; dsurface: TDXTexture);
begin
  //
end;

procedure TFrmDlg.DWndSayMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SayDlgDown := True;
end;

procedure TFrmDlg.DWndSayMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  SayDlgDown := False;
  if mbRight = Button then begin
    if pClickName <> nil then begin
      with Sender as TDControl do begin
        DPopUpSayList.Visible := False;
        DPopUpSayList.Item.Clear;
        DPopUpSayList.Item.AddObject('名称: ' + pClickName.sStr, TObject(-1));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('进行私聊', TObject(1));
        if (not InFriendList(pClickName.sStr)) and
          (pClickName.sStr <> g_MySelf.m_UserName) then
          DPopUpSayList.Item.AddObject('加为好友', TObject(2))
        else
          DPopUpSayList.Item.AddObject('加为好友', nil);

        if (not InBlacklist(pClickName.sStr)) then
          DPopUpSayList.Item.AddObject('屏蔽发言', TObject(7))
        else
          DPopUpSayList.Item.AddObject('解除屏蔽', TObject(8));

        if InFriendList(pClickName.sStr) then
          DPopUpSayList.Item.AddObject('发送信件', TObject(3))
        else
          DPopUpSayList.Item.AddObject('发送信件', nil);

        DPopUpSayList.Item.AddObject('邀请组队', TObject(4));
        DPopUpSayList.Item.AddObject('邀请加入行会', TObject(5));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('复制人物名称', TObject(6));
        DPopUpSayList.RefSize;
        DPopUpSayList.Popup(Sender, SurfaceX(X), SurfaceY(Y), pClickName.sStr);
      end;
    end;
  end
  else begin
    if pClickName <> nil then begin
      PlayScene.SetEditChar(pClickName.sStr);
    end
    else if pClickItem <> nil then begin
      if pClickItem.pc.s.name <> '' then begin
        OpenSayItemShow(pClickItem.pc);
      end
      else if pClickItem.ItemIndex < 0 then begin
        for I := Low(g_ItemArr) to High(g_ItemArr) do begin
          if (g_ItemArr[i].s.Name <> '') and (g_ItemArr[i].UserItem.MakeIndex = (-pClickItem.ItemIndex)) then begin
            OpenSayItemShow(g_ItemArr[i]);
            pClickItem.pc := g_ItemArr[i];
            break;
          end;
        end;
      end
      else begin
        if GetTickCount > DWndSay.AppendTick then begin
          DWndSay.AppendTick := GetTickCount + 500;
          FrmMain.SendGetSayItem(pClickItem.nIndex, pClickItem.ItemIndex); //去服务器取回装备属性
        end;
      end;
    end;
  end;

end;

procedure TFrmDlg.dwndWhisperNameDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay, nY: Integer;
  I: Integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    g_DXCanvas.FillRect(ax, ay, Width, Height, $C8000000);
    g_DXCanvas.RoundRect(ax + 1, ay + 1, ax + Width - 1, ay + Height - 1, $FF737D73);
    with g_DXCanvas do begin
      for I := 0 to g_MyWhisperList.Count - 1 do begin
        if I > 7 then
          Break;
        nY := (ay + Height) - (I * 18) - 15;
        if I = FSayNameIndex then
          g_DXCanvas.FillRect(ax + 2, nY - 3, Width - 4, 17, $A062625A);
        TextOut(ax + 5, nY, '/' + g_MyWhisperList[i], $FFDEDBDE);
      end;
    end;
  end;
end;

procedure TFrmDlg.dwndWhisperNameVisible(Sender: TObject; boVisible: Boolean);
begin
  FSayNameIndex := 0;
end;

procedure TFrmDlg.DWudItemShowDirectPaint(Sender: TObject; dsurface: TDXTexture);
begin
  with DWudItemShow do begin
    DScreen.DrawHintEx(DSurface, Surface, SurfaceX(Left), SurfaceX(Top), Width, Height, HintDrawList);
  end;
end;

procedure TFrmDlg.DWudItemShowMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDWindow do begin
    if (Left + Width) > g_FScreenWidth then
      Left := g_FScreenWidth - Width;
    if (Top + Height) > g_FScreenHeight then
      Top := g_FScreenHeight - Height;
    if Left < 0 then
      Left := 0;
    if Top < 0 then
      Top := 0;
  end;
end;

procedure TFrmDlg.DWudItemShowVisible(Sender: TObject; boVisible: Boolean);
var
  i: integer;
begin
  if not boVisible then begin
    //DWudItemShow.SetSurface(nil, nil);    更新
    for i := 0 to HintDrawList.Count - 1 do begin
      if pTNewShowHint(HintDrawList[i]).IndexList <> nil then
        pTNewShowHint(HintDrawList[i]).IndexList.Free;
      Dispose(pTNewShowHint(HintDrawList[i]));
    end;
    HintDrawList.Clear;
  end;
end;

procedure TFrmDlg.FormCreate(Sender: TObject);
begin
  //SelServerIndex := -1;
 // MoveServerIndex := -1;
  FHelpTick := 0;
  btAniIndex := 0;
  m_nDiceCount := 0;
  dwStartTime := GetTickCount;
  btJob := Random(3);
  btSex := Random(1);
  m_dwBlinkTime := GetTickCount;
  m_boViewBlink := False;
  TempList := TList.Create;
  m_dwDblClick := GetTickCount;
  boOpenItemBag := False;
  boOpenStatus := False;
  //m_MsgList := TStringList.Create;
  Font.Name := DEF_FONT_NAME;
  Font.Size := DEF_FONT_SIZE;
  //m_DMsgSurface := nil;
  BoGuildChat := False;
  MyHDInfoSurface := nil;
  UserHDInfoSurface := nil;
  NAHelps := TStringList.Create;
  //MyHDDIB := nil;
  //UserHDDIB := nil;
  //boShowDlg := False;
  HintDrawList := TList.Create;
  MDlgPoints := TList.Create;
  //MDlgNewPoints := TList.Create;
  MDlgDraws := TList.Create;
  //MenuList := TList.Create;
  RefGroupList := TStringList.Create;
  AddressList := TStringList.Create;
  LoadAddressList();
  NpcGoodsList := TList.Create;
  NpcReturnItemList := TList.Create;
  NpcGoodItems := nil;
  MagicList1 := TQuickStringList.Create;
  MagicList2 := TQuickStringList.Create;
  sHintStr := '';
end;

procedure TFrmDlg.FormDestroy(Sender: TObject);
begin
  ClearGoodsList;
  TempList.Free;
  HintDrawList.Free;
  MDlgPoints.Free;
  MDlgDraws.Free;
  RefGroupList.Free;

  MagicList1.Free;
  MagicList2.Free;
  NpcGoodsList.Free;
  NpcReturnItemList.Free;
  NAHelps.Free;
  NpcGoodItems := nil;
  ClearAddressList();
  AddressList.Free;
  if MyHDInfoSurface <> nil then
    MyHDInfoSurface.Free;
  if UserHDInfoSurface <> nil then
    UserHDInfoSurface.Free;

  MyHDInfoSurface := nil;
  UserHDInfoSurface := nil;
  {if MyHDDIB <> nil then MyHDDIB.Free;
  MyHDDIB := nil;
  if UserHDDIB <> nil then UserHDDIB.Free;
  UserHDDIB := nil;  }
end;

// 窗口初始化
procedure TFrmDlg.Initialize;
var
  d: TDXTexture;
  i, nX, nY: integer;
begin
  // 清理所有内容
  g_DWinMan.ClearAll;
  // 设置背景位置和大小
  DBackground.Left := 0;
  DBackground.Top := 0;
  DBackground.Width := g_FScreenWidth;
  DBackground.Height := g_FScreenHeight;
  DBackground.Background := True;

  g_DWinMan.AddDControl(DBackground, True);

{$IF Var_Interface = Var_Mir2}
  // 创建人物界面
  if DCreateChr.DParent <> nil then DCreateChr.DParent.DelChild(DCreateChr);
  DCreateChr.DParent := DBackground;
  DBackground.AddChild(DCreateChr);
  // 恢复人物界面
  if DRenewChr.DParent <> nil then DRenewChr.DParent.DelChild(DRenewChr);
  DRenewChr.DParent := DBackground;
  DBackground.AddChild(DRenewChr);
{$ELSE}
  // 选择人物界面
  if DSelectChr.DParent <> nil then DSelectChr.DParent.DelChild(DSelectChr);
  DCreateChr.DParent := DSelectChr;
  DSelectChr.AddChild(DCreateChr);
  // 恢复人物界面
  if DRenewChr.DParent <> nil then DRenewChr.DParent.DelChild(DRenewChr);
  DRenewChr.DParent := DSelectChr;
  DSelectChr.AddChild(DRenewChr);
{$IFEND}

  //SELLDEFCOLOR := IntToStr(GetRGB(67)); //售价默认颜色 $847CCF  67
  SELLDEFCOLOR := '$8C9CCE';
  HINTDEFCOLOR := IntToStr(GetRGB(103)); //提示默认颜色 $65D16A
  NOTDOWNCOLOR := IntToStr(GetRGB(128)); //不可交易颜色 $99C5E2  128/131
  ADDVALUECOLOR := IntToStr(GetRGB(156)); //普通属性颜色 $FF7979   156/155
  //ADDVALUECOLOR2 := IntToStr(GetRGB(20)); //特殊属性颜色 $DA65C0  20/156
  ADDVALUECOLOR2 := '$63CEFF';
  ADDVALUECOLOR3 := '$FF66FF';
  ITEMNAMECOLOR := IntToStr(GetRGB(149)); //物品名称
  SUITITEMCOLOR := IntToStr(GetRGB(203)); //套装未激活     198
  SUITITEMCOLOR2 := IntToStr(GetRGB(145)); //套装已激活     204

  for I := Low(g_FaceIndexInfo) to High(g_FaceIndexInfo) do begin
    g_FaceIndexInfo[i].ImageIndex := g_FaceIndexList[i];
    g_FaceIndexInfo[i].dwShowTime := GetTickCount;
  end;

  nShowDlgCount := 0;
  DMagicIndex := 0;
  FShowItemEffectTick := GetTickCount;
  FShowItemEffectIndex := 0;
  // 新建帐号窗口
  LoginScene.Initialize;
  // 选择服务器界面
{$IF Var_Interface = Var_Mir2}
  // 300*419
  d := g_WMain99Images.Images[1890];
  if d <> nil then begin
    DWinSelServer.SetImgIndex(g_WMain99Images, 1890);
{$ELSE}
  d := g_WMain99Images.Images[360];
  if d <> nil then begin
    DWinSelServer.SetImgIndex(g_WMain99Images, 360);
{$IFEND}
    // 选择服务器界面的位置居中
    DWinSelServer.Left := g_FScreenXOrigin - d.Width div 2;
    DWinSelServer.Top := g_FScreenYOrigin - d.Height div 2;
  end;
// 选择服务器的关闭按钮
{$IF Var_Interface = Var_Mir2}
  // 16*23
  dbtnSelServerClose.SetImgIndex(g_WMain99Images, 1850);
  dbtnSelServerClose.Left := 250;
  dbtnSelServerClose.Top := 30;
{$ELSE}
  dbtnSelServerClose.SetImgIndex(g_WMain99Images, 143);
  dbtnSelServerClose.Left := 213;
  dbtnSelServerClose.Top := 0;
{$IFEND}

// 选择服务器列表按钮
{$IF Var_Interface = Var_Mir2}
  // 168*41
  dbtnSelServer7.SetImgIndex(g_WMain99Images, 2134);
  dbtnSelServer7.Left := 65;
  dbtnSelServer7.Top := 74;
  dbtnSelServer7.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer5.SetImgIndex(g_WMain99Images, 2134);
  dbtnSelServer5.Left := 65;
  dbtnSelServer5.Top := 116;
  dbtnSelServer5.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer3.SetImgIndex(g_WMain99Images, 2134);
  dbtnSelServer3.Left := 65;
  dbtnSelServer3.Top := 158;
  dbtnSelServer3.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer1.SetImgIndex(g_WMain99Images, 2134);
  dbtnSelServer1.Left := 65;
  dbtnSelServer1.Top := 200;
  dbtnSelServer1.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer2.SetImgIndex(g_WMain99Images, 2134);
  dbtnSelServer2.Left := 65;
  dbtnSelServer2.Top := 242;
  dbtnSelServer2.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer4.SetImgIndex(g_WMain99Images, 2134);
  dbtnSelServer4.Left := 65;
  dbtnSelServer4.Top := 284;
  dbtnSelServer4.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer6.SetImgIndex(g_WMain99Images, 2134);
  dbtnSelServer6.Left := 65;
  dbtnSelServer6.Top := 326;
  dbtnSelServer6.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer8.SetImgIndex(g_WMain99Images, 2134);
  dbtnSelServer8.Left := 65;
  dbtnSelServer8.Top := 368;
  dbtnSelServer8.OnDirectPaint := dbtnSelServer1DirectPaint;
{$ELSE}
  dbtnSelServer1.SetImgIndex(g_WMain99Images, 361);
  dbtnSelServer1.Left := 25;
  dbtnSelServer1.Top := 135;
  dbtnSelServer2.SetImgIndex(g_WMain99Images, 361);
  dbtnSelServer2.Left := 25;
  dbtnSelServer2.Top := 165;
  dbtnSelServer3.SetImgIndex(g_WMain99Images, 361);
  dbtnSelServer3.Left := 25;
  dbtnSelServer3.Top := 105;
  dbtnSelServer4.SetImgIndex(g_WMain99Images, 361);
  dbtnSelServer4.Left := 25;
  dbtnSelServer4.Top := 195;
  dbtnSelServer5.SetImgIndex(g_WMain99Images, 361);
  dbtnSelServer5.Left := 25;
  dbtnSelServer5.Top := 75;
  dbtnSelServer6.SetImgIndex(g_WMain99Images, 361);
  dbtnSelServer6.Left := 25;
  dbtnSelServer6.Top := 225;
  dbtnSelServer7.SetImgIndex(g_WMain99Images, 361);
  dbtnSelServer7.Left := 25;
  dbtnSelServer7.Top := 45;
  dbtnSelServer8.SetImgIndex(g_WMain99Images, 361);
  dbtnSelServer8.Left := 25;
  dbtnSelServer8.Top := 255;
  dbtnSelServer1.OnDirectPaint := nil;
  dbtnSelServer2.OnDirectPaint := nil;
  dbtnSelServer3.OnDirectPaint := nil;
  dbtnSelServer4.OnDirectPaint := nil;
  dbtnSelServer5.OnDirectPaint := nil;
  dbtnSelServer6.OnDirectPaint := nil;
  dbtnSelServer7.OnDirectPaint := nil;
  dbtnSelServer8.OnDirectPaint := nil;
{$IFEND}

  //提示界面
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1620];
  if d <> nil then begin
    DWndHint.SetImgIndex(g_WMain99Images, 1620);
    DWndHint.Left := g_FScreenXOrigin - d.Width div 2;
    DWndHint.Top := g_FScreenYOrigin - d.Height div 2;
  end;

  DBTHintClose.SetImgIndex(g_WMain99Images, 1650);
  DBTHintClose.Left := (DWndHint.Width - DBTHintClose.Width) div 2;
  DBTHintClose.Top := 62;
  DBTHintClose.DFColor := $ADD6EF;

{$ELSE}
  d := g_WMain99Images.Images[30];
  if d <> nil then begin
    DWndHint.SetImgIndex(g_WMain99Images, 30);
    DWndHint.Left := (BASE_WIDTH - d.Width) div 2;
    DWndHint.Top := (BASE_HEIGHT - d.Height) div 2;
  end;

  DBTHintClose.SetImgIndex(g_WMain99Images, 24);
  DBTHintClose.Left := 92;
  DBTHintClose.Top := 78;
  DBTHintClose.OnDirectPaint := nil;
{$IFEND}

  //登录界面

{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1891];
  if d <> nil then begin
    DLogin.SetImgIndex(g_WMain99Images, 1891);
    DLogin.Left := g_FScreenXOrigin - d.Width div 2;
    DLogin.Top := g_FScreenYOrigin - d.Height div 2;
  end;

  DLoginOk.SetImgIndex(g_WMain99Images, 1892);
  DLoginOk.Left := 169;
  DLoginOk.Top := 163;
  DLoginOk.OnDirectPaint := DMyStateDirectPaint;

  DLoginClose.SetImgIndex(g_WMain99Images, 24);
  DLoginClose.Left := 168;
  DLoginClose.Top := 170;
  DLoginClose.Visible := False;

  DLoginHome.SetImgIndex(g_WMain99Images, 18);
  DLoginHome.Left := 370;
  DLoginHome.Top := 189;
  DLoginHome.Visible := False;

  if g_boSQLReg then begin
    DLoginNew.SetImgIndex(g_WMain99Images, 1893);
    DLoginNew.Left := 25;
    DLoginNew.Top := 207;
    DLoginNew.OnDirectPaint := DMyStateDirectPaint;
    DLoginChgPw.SetImgIndex(g_WMain99Images, 1894);
    DLoginChgPw.Left := 130;
    DLoginChgPw.Top := 207;
    DLoginChgPw.OnDirectPaint := DMyStateDirectPaint;
    dbtnLoginLostPw.SetImgIndex(g_WMain99Images, 18);
    dbtnLoginLostPw.Left := 370;
    dbtnLoginLostPw.Top := 283;
    dbtnLoginLostPw.Visible := False;
  end
  else begin
    DLoginNew.SetImgIndex(g_WMain99Images, 1893);
    DLoginNew.Left := 25;
    DLoginNew.Top := 207;
    DLoginNew.OnDirectPaint := DMyStateDirectPaint;
    DLoginChgPw.SetImgIndex(g_WMain99Images, 1894);
    DLoginChgPw.Left := 130;
    DLoginChgPw.Top := 207;
    DLoginChgPw.OnDirectPaint := DMyStateDirectPaint;
    dbtnLoginLostPw.Visible := False;
    //DEditID.MaxLength := 10;
{$IFDEF DEBUG}
    DEditID.Text := 'z12355';
    DEditPass.Text := '12355';
{$ENDIF}
    DEditPass.MaxLength := 15;
    DLoginNew.Caption := '注册账号';
  end;

  DLoginExit.SetImgIndex(g_WMain99Images, 1850);
  DLoginExit.Left := 252;
  DLoginExit.Top := 28;
  DLoginExit.OnDirectPaint := DMyStateDirectPaint;
{$ELSE}
  d := g_WMain99Images.Images[31];
  if d <> nil then begin
    DLogin.SetImgIndex(g_WMain99Images, 31);
    DLogin.Left := (BASE_WIDTH - d.Width) div 2;
    DLogin.Top := (BASE_HEIGHT - d.Height) div 2;
  end;
  DLoginOk.SetImgIndex(g_WMain99Images, 24);
  DLoginOk.Left := 46;
  DLoginOk.Top := 170;
  DLoginOk.OnDirectPaint := nil;
  DLoginClose.SetImgIndex(g_WMain99Images, 24);
  DLoginClose.Left := 168;
  DLoginClose.Top := 170;

  DLoginHome.SetImgIndex(g_WMain99Images, 18);
  DLoginHome.Left := 370;
  DLoginHome.Top := 189;

  if g_boSQLReg then begin
    DLoginNew.SetImgIndex(g_WMain99Images, 18);
    DLoginNew.Left := 370;
    DLoginNew.Top := 226;
    DLoginNew.OnDirectPaint := DLoginHomeDirectPaint;
    DLoginChgPw.SetImgIndex(g_WMain99Images, 18);
    DLoginChgPw.Left := 370;
    DLoginChgPw.Top := 254;
    DLoginChgPw.OnDirectPaint := DLoginHomeDirectPaint;
    dbtnLoginLostPw.SetImgIndex(g_WMain99Images, 18);
    dbtnLoginLostPw.Left := 370;
    dbtnLoginLostPw.Top := 283;
  end
  else begin
    DLoginNew.SetImgIndex(g_WMain99Images, 18);
    DLoginNew.Left := 370;
    DLoginNew.Top := 254;
    DLoginNew.OnDirectPaint := DLoginHomeDirectPaint;
    DLoginChgPw.SetImgIndex(g_WMain99Images, 18);
    DLoginChgPw.Left := 370;
    DLoginChgPw.Top := 283;
    DLoginChgPw.OnDirectPaint := DLoginHomeDirectPaint;
    dbtnLoginLostPw.Visible := False;
    //DEditID.MaxLength := 10;
    DEditPass.MaxLength := 15;
    DLoginNew.Caption := '注册账号';
  end;

  DLoginExit.SetImgIndex(g_WMain99Images, 18);
  DLoginExit.Left := 370;
  DLoginExit.Top := 320;
  DLoginExit.OnDirectPaint := DLoginHomeDirectPaint;
{$IFEND}


  //创建账号窗口
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1895];
  if d <> nil then begin
    DNewAccount.SetImgIndex(g_WMain99Images, 1895);
    DNewAccount.Left := g_FScreenXOrigin - d.Width div 2;
    DNewAccount.Top := g_FScreenYOrigin - d.Height div 2;
  end;

  DNewAccountOk.SetImgIndex(g_WMain99Images, 1892);
  DNewAccountOk.Left := 158;
  DNewAccountOk.Top := 416;
  DNewAccountOk.OnDirectPaint := DMyStateDirectPaint;
  DNewAccountCancel.SetImgIndex(g_WMain99Images, 1896);
  DNewAccountCancel.Left := 446;
  DNewAccountCancel.Top := 419;
  DNewAccountCancel.OnDirectPaint := DMyStateDirectPaint;
  DNewAccountClose.SetImgIndex(g_WMain99Images, 1850);
  DNewAccountClose.Left := 587;
  DNewAccountClose.Top := 33;

{$ELSE}
  d := g_WMain99Images.Images[32];
  if d <> nil then begin
    DNewAccount.SetImgIndex(g_WMain99Images, 32);
    DNewAccount.Left := (BASE_WIDTH - d.Width) div 2;
    DNewAccount.Top := (BASE_HEIGHT - d.Height) div 2;
  end;

  DNewAccountOk.SetImgIndex(g_WMain99Images, 13);
  DNewAccountOk.Left := 104;
  DNewAccountOk.Top := 453;
  DNewAccountCancel.SetImgIndex(g_WMain99Images, 13);
  DNewAccountCancel.Left := 358;
  DNewAccountCancel.Top := 453;
  DNewAccountClose.Visible := False;
{$IFEND}

  //修改密码窗口
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1897];
  if d <> nil then begin
    DChgPw.SetImgIndex(g_WMain99Images, 1897);
    DChgPw.Left := g_FScreenXOrigin - d.Width div 2;
    DChgPw.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  DChgpwOk.SetImgIndex(g_WMain99Images, 1898);
  DChgpwOk.Left := 181;
  DChgpwOk.Top := 253;
  DChgpwOk.OnDirectPaint := DMyStateDirectPaint;
  DChgpwCancel.SetImgIndex(g_WMain99Images, 1896);
  DChgpwCancel.Left := 276;
  DChgpwCancel.Top := 252;
  DChgpwCancel.OnDirectPaint := DMyStateDirectPaint;
{$ELSE}
  d := g_WMain99Images.Images[33];
  if d <> nil then begin
    DChgPw.SetImgIndex(g_WMain99Images, 33);
    DChgPw.Left := (BASE_WIDTH - d.Width) div 2;
    DChgPw.Top := (BASE_HEIGHT - d.Height) div 2;
  end;
  DChgpwOk.SetImgIndex(g_WMain99Images, 24);
  DChgpwOk.Left := 44;
  DChgpwOk.Top := 230;
  DChgpwOk.OnDirectPaint := nil;
  DChgpwCancel.SetImgIndex(g_WMain99Images, 24);
  DChgpwCancel.Left := 170;
  DChgpwCancel.Top := 230;
  DChgpwCancel.OnDirectPaint := nil;
{$IFEND}
  //消息框窗口
  d := g_WMain99Images.Images[30];
  if d <> nil then begin
    DMsgDlg.SetImgIndex(g_WMain99Images, 30);
    DMsgDlg.Left := g_FScreenXOrigin - d.Width div 2;
    DMsgDlg.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  DMsgDlgOk.SetImgIndex(g_WMain99Images, 24);
  DMsgDlgCancel.SetImgIndex(g_WMain99Images, 24);

  //选择角色窗口
{$IF Var_Interface = Var_Mir2}
  // 窗口位置：居中，适配旧分辨率
  DSelectChr.Left := g_FScreenXOrigin - OLD_SCREEN_WIDTH div 2;
  DSelectChr.Top := g_FScreenYOrigin - OLD_SCREEN_HEIGHT div 2;
  DSelectChr.Width := OLD_SCREEN_WIDTH;
  DSelectChr.Height := OLD_SCREEN_HEIGHT;

  // 以下按钮必须以客户端的中间点为坐标原点，
  DscStart.SetImgIndex(g_WMain99Images, 1899);
  // 开始按钮，X 轴居中，Y 轴
  DscStart.Left := g_FScreenXOrigin - DscStart.Width div 2;
  DscStart.Top := g_FScreenYOrigin + 160;
  DscStart.OnDirectPaint := DMyStateDirectPaint;
  DscNewChr.SetImgIndex(g_WMain99Images, 1900);
  DscNewChr.Left := g_FScreenXOrigin - DscNewChr.Width div 2;
  DscNewChr.Top := g_FScreenYOrigin + 190;
  DscNewChr.OnDirectPaint := DMyStateDirectPaint;
  DscEraseChr.SetImgIndex(g_WMain99Images, 1901);
  DscEraseChr.Left := g_FScreenXOrigin - DscEraseChr.Width div 2;
  DscEraseChr.Top := g_FScreenYOrigin + 205;
  DscEraseChr.OnDirectPaint := DMyStateDirectPaint;
  DscCredits.SetImgIndex(g_WMain99Images, 2136);
  DscCredits.Left := g_FScreenXOrigin - DscCredits.Width div 2;
  DscCredits.Top := g_FScreenYOrigin + 225;
  DscCredits.OnDirectPaint := DMyStateDirectPaint;
  DscExit.SetImgIndex(g_WMain99Images, 1902);
  DscExit.Left := g_FScreenXOrigin - DscExit.Width div 2;
  DscExit.Top := g_FScreenYOrigin + 245;
  DscExit.OnDirectPaint := DMyStateDirectPaint;

  DscSelect1.SetImgIndex(g_WMain99Images, 1903);
  DscSelect1.Left := g_FScreenXOrigin - 270;
  DscSelect1.Top := g_FScreenYOrigin + 150;
  DscSelect1.OnDirectPaint := DMyStateDirectPaint;

  DscSelect2.SetImgIndex(g_WMain99Images, 1904);
  DscSelect2.Left := g_FScreenXOrigin + 285;
  DscSelect2.Top := g_FScreenYOrigin + 150;
  DscSelect2.OnDirectPaint := DMyStateDirectPaint;

  DscSelect3.Left := g_FScreenXOrigin + 285 + 1;
  DscSelect3.Top := g_FScreenYOrigin + 150 + 1;
  DscSelect3.Width := 1;
  DscSelect3.Height := 1;
  DscSelect3.Visible := False;
{$ELSE}
  DSelectChr.Left := 0;
  DSelectChr.Top := 0;
  DSelectChr.Width := BASE_WIDTH;
  DSelectChr.Height := BASE_HEIGHT;

  DscStart.SetImgIndex(g_WMain99Images, 13);
  DscStart.Left := 314 {385};
  DscStart.Top := 456 {456};
  DscNewChr.SetImgIndex(g_WMain99Images, 13);
  DscNewChr.Left := 41 {348};
  DscNewChr.Top := 505 {486};
  DscEraseChr.SetImgIndex(g_WMain99Images, 13);
  DscEraseChr.Left := 223 {347};
  DscEraseChr.Top := 505 {506};
  DscCredits.SetImgIndex(g_WMain99Images, 13);
  DscCredits.Left := 405 {362};
  DscCredits.Top := 505 {527};
  DscExit.SetImgIndex(g_WMain99Images, 13);
  DscExit.Left := 587 {379};
  DscExit.Top := 505 {547};

  DscSelect1.Left := 16;
  DscSelect1.Top := 87;
  DscSelect1.Width := 242;
  DscSelect1.Height := 351;

  DscSelect2.Left := 279;
  DscSelect2.Top := 87;
  DscSelect2.Width := 242;
  DscSelect2.Height := 351;

  DscSelect3.Left := 542;
  DscSelect3.Top := 87;
  DscSelect3.Width := 242;
  DscSelect3.Height := 351;
{$IFEND}

  //创建角色窗口
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1905];
  if d <> nil then begin
    DCreateChr.SetImgIndex(g_WMain99Images, 1905);
    DCreateChr.Left := g_FScreenXOrigin - d.Width div 2;
    DCreateChr.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  DccWarrior.SetImgIndex(g_WMain99Images, 1911);
  DccWizzard.SetImgIndex(g_WMain99Images, 1912);
  DccMonk.SetImgIndex(g_WMain99Images, 1913);
  DccMale.SetImgIndex(g_WMain99Images, 1914);
  DccFemale.SetImgIndex(g_WMain99Images, 1915);

  DccJ.Visible := False;
  DccM.Visible := False;
  DccS.Visible := False;
  DccH.Visible := False;
  DccT.Visible := False;

  DccOk.SetImgIndex(g_WMain99Images, 1892);
  DccClose.SetImgIndex(g_WMain99Images, 1850);

  DccWarrior.Left := 48;
  DccWarrior.Top := 157;
  DccWizzard.Left := 93;
  DccWizzard.Top := 157;
  DccMonk.Left := 138;
  DccMonk.Top := 157;

  DccMale.Left := 93;
  DccMale.Top := 231;
  DccFemale.Left := 138;
  DccFemale.Top := 231;

  DccOk.Left := 101;
  DccOk.Top := 359;
  DccOk.OnDirectPaint := DMyStateDirectPaint;
  DccClose.Left := 247;
  DccClose.Top := 30;
  DccClose.OnDirectPaint := DMyStateDirectPaint;
{$ELSE}
  d := g_WMain99Images.Images[1480];
  if d <> nil then begin
    DCreateChr2.SetImgIndex(g_WMain99Images, 1480);
    DCreateChr2.Left := (BASE_WIDTH - d.Width) div 2;
    DCreateChr2.Top := (BASE_HEIGHT - d.Height) div 2;
  end;

  DccOk2.SetImgIndex(g_WMain99Images, 24);
  DccClose2.SetImgIndex(g_WMain99Images, 24);
  DccOk2.Left := 349;
  DccOk2.Top := 356;
  DccClose2.Left := 481;
  DccClose2.Top := 356;

  DccManWarrior.SetImgIndex(g_WMain99Images, 1481);
  DccManWizzard.SetImgIndex(g_WMain99Images, 1483);
  DccManMonk.SetImgIndex(g_WMain99Images, 1485);
  DccWoManWarrior.SetImgIndex(g_WMain99Images, 1487);
  DccWoManWizzard.SetImgIndex(g_WMain99Images, 1489);
  DccWoManMonk.SetImgIndex(g_WMain99Images, 1491);

  DccManWarrior.Left := 307;
  DccManWarrior.Top := 156;
  DccManWizzard.Left := 307;
  DccManWizzard.Top := 220;
  DccManMonk.Left := 307;
  DccManMonk.Top := 284;
  DccWoManWarrior.Left := 465;
  DccWoManWarrior.Top := 156;
  DccWoManWizzard.Left := 465;
  DccWoManWizzard.Top := 220;
  DccWoManMonk.Left := 465;
  DccWoManMonk.Top := 284;


  //创建角色窗口
  d := g_WMain99Images.Images[34];
  if d <> nil then begin
    DCreateChr.SetImgIndex(g_WMain99Images, 34);
    DCreateChr.Left := (BASE_WIDTH - d.Width) div 2;
    DCreateChr.Top := (BASE_HEIGHT - d.Height) div 2;
  end;
  DccWarrior.SetImgIndex(g_WMain99Images, 42);
  DccWizzard.SetImgIndex(g_WMain99Images, 42);
  DccMonk.SetImgIndex(g_WMain99Images, 42);
  DccMale.SetImgIndex(g_WMain99Images, 42);
  DccFemale.SetImgIndex(g_WMain99Images, 42);

  DccJ.SetImgIndex(g_WMain99Images, 36);
  DccM.SetImgIndex(g_WMain99Images, 36);
  DccS.SetImgIndex(g_WMain99Images, 36);
  DccH.SetImgIndex(g_WMain99Images, 36);
  DccT.SetImgIndex(g_WMain99Images, 36);

  DccOk.SetImgIndex(g_WMain99Images, 24);
  DccClose.SetImgIndex(g_WMain99Images, 24);

  DccWarrior.Left := 326;
  DccWarrior.Top := 162;
  DccWizzard.Left := 326;
  DccWizzard.Top := 195;
  DccMonk.Left := 326;
  DccMonk.Top := 228;

  DccMale.Left := 500;
  DccMale.Top := 178;
  DccFemale.Left := 500;
  DccFemale.Top := 211;

  DccJ.Left := 313;
  DccJ.Top := 322;
  DccM.Left := 374;
  DccM.Top := 322;
  DccS.Left := 435;
  DccS.Top := 322;
  DccH.Left := 496;
  DccH.Top := 322;
  DccT.Left := 557;
  DccT.Top := 322;
  DccOk.Left := 346;
  DccOk.Top := 392;
  DccClose.Left := 484;
  DccClose.Top := 392;
{$IFEND}

  //恢复角色窗口
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[2137];
  if d <> nil then begin
    DRenewChr.SetImgIndex(g_WMain99Images, 2137);
    DRenewChr.Left := g_FScreenXOrigin - d.Width div 2;
    DRenewChr.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  DButRenewClose.SetImgIndex(g_WMain99Images, 1850);
  DButRenewClose.Left := 247;
  DButRenewClose.Top := 30;
  DButRenewClose.OnDirectPaint := DMyStateDirectPaint;
  DButRenewChr.SetImgIndex(g_WMain99Images, 2138);
  DButRenewChr.Left := 96;
  DButRenewChr.Top := 362;
  
{$ELSE}
  d := g_WMain99Images.Images[35];
  if d <> nil then begin
    DRenewChr.SetImgIndex(g_WMain99Images, 35);
    DRenewChr.Left := (BASE_WIDTH - d.Width) div 2;
    DRenewChr.Top := (BASE_HEIGHT - d.Height) div 2;
  end;
  DButRenewClose.SetImgIndex(g_WMain99Images, 24);
  DButRenewClose.Left := 166;
  DButRenewClose.Top := 373;
  DButRenewChr.SetImgIndex(g_WMain99Images, 24);
  DButRenewChr.Left := 43;
  DButRenewChr.Top := 373;
  DButRenewChr.OnDirectPaint := nil;
{$IFEND}

  //底部状态栏
{$IF Var_Interface = Var_Mir2}
  if g_FScreenWidth = LARGE_SCREEN_WIDTH then
    i := 1614
  else
    i := 1615;

  d := g_WMain99Images.Images[i];
  if d <> nil then begin
    DBottom.SetImgIndex(g_WMain99Images, i);
    DBottom.Left :=  g_FScreenXOrigin - d.Width div 2;
    DBottom.Top := g_FScreenHeight - d.Height;
  end;

  if g_FScreenWidth = LARGE_SCREEN_WIDTH then
    DUserKeyGrid1.Left := -127 + g_FScreenXOrigin
  else
    DUserKeyGrid1.Left := -115 + g_FScreenXOrigin;
  DUserKeyGrid1.Top := 59;
  DUserKeyGrid1.Width := 252;
  DUserKeyGrid1.Height := 30;
  DUserKeyGrid1.ColWidth := 32;
  DUserKeyGrid1.RowHeight := 30;
  DUserKeyGrid1.ColCount := 6;
  DUserKeyGrid1.ColOffset := 12;

  DUserKeyGrid2.Left := 65;
  DUserKeyGrid2.Top := 7;
  DUserKeyGrid2.Width := 332;
  DUserKeyGrid2.Height := 38;

  d := g_WMain99Images.Images[11];
  if d <> nil then begin
    DBottom2.SetImgIndex(g_WMain99Images, 11);
    DBottom2.Left := 390;
    DBottom2.Top := -d.Height;
  end;

  DBTAttackMode.SetImgIndex(g_WMain99Images, 493);
  DBTAttackMode.Top := 32;
  DBTAttackMode.Left := 510;

  DWndAttackModeList.SetImgIndex(g_WMain99Images, 492);
  DWndAttackModeList.Top := 54;
  DWndAttackModeList.Left := 508;

  DBTAttackModeAll.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeAll.Top := 3;
  DBTAttackModeAll.Left := 2;
  DBTAttackModePeace.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModePeace.Top := 3 + 1 * 24;
  DBTAttackModePeace.Left := 2;
  DBTAttackModeDear.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeDear.Top := 3 + 2 * 24;
  DBTAttackModeDear.Left := 2;
  DBTAttackModeMaster.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeMaster.Top := 3 + 3 * 24;
  DBTAttackModeMaster.Left := 2;
  DBTAttackModeGroup.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeGroup.Top := 3 + 4 * 24;
  DBTAttackModeGroup.Left := 2;
  DBTAttackModeGuild.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeGuild.Top := 3 + 5 * 24;
  DBTAttackModeGuild.Left := 2;
  DBTAttackModePK.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModePK.Top := 3 + 6 * 24;
  DBTAttackModePK.Left := 2;


  {
  DBTCheck2.SetImgIndex(g_WMain99Images, 378);
  DBTCheck2.Left := -348;
  DBTCheck2.Top := -348;
  DBTCheck3.SetImgIndex(g_WMain99Images, 378);
  DBTCheck3.Left := -348;
  DBTCheck3.Top := -348;
  DBTCheck4.SetImgIndex(g_WMain99Images, 378);
  DBTCheck4.Left := -348;
  DBTCheck4.Top := -348;
  DBTCheck5.SetImgIndex(g_WMain99Images, 378);
  DBTCheck5.Left := -348;
  DBTCheck5.Top := -348;
  DBTCheck6.SetImgIndex(g_WMain99Images, 378);
  DBTCheck6.Left := -348;
  DBTCheck6.Top := -348;
  DBTCheck7.SetImgIndex(g_WMain99Images, 378);
  DBTCheck7.Left := -348;
  DBTCheck7.Top := -348;
  DBTCheck8.SetImgIndex(g_WMain99Images, 378);
  DBTCheck8.Left := -348;
  DBTCheck8.Top := -348;
  DBTCheck9.SetImgIndex(g_WMain99Images, 378);
  DBTCheck9.Left := -348;
  DBTCheck9.Top := -348;
  DBTCheck10.SetImgIndex(g_WMain99Images, 378);
  DBTCheck10.Left := -348;
  DBTCheck10.Top := -348;  }

  DMyState.SetImgIndex(g_WMain99Images, 1916);
  DMyState.Left := g_FScreenWidth - 157;
  DMyState.Top := 61;
  DMyState.ClickCount := csStone;
  // fixme 补丁位置不对导致鼠标移动和点击不到对应的按钮
  DMyBag.SetImgIndex(g_WMain99Images, 1917);
  DMyBag.Left := g_FScreenWidth - 118;
  DMyBag.Top := 41;
  DMyBag.ClickCount := csStone;
  DMyMagic.SetImgIndex(g_WMain99Images, 1918);
  DMyMagic.Left := g_FScreenWidth - 78;
  DMyMagic.Top := 21;
  DMyMagic.ClickCount := csStone;
  DBotMusic.SetImgIndex(g_WMain99Images, 1919);
  DBotMusic.Left := g_FScreenWidth - 36;
  DBotMusic.Top := 11;
  DBotMusic.Visible := True;



  DBotMiniMap.SetImgIndex(g_WMain99Images, 1922);
  DBotMiniMap.Left := 209;
  DBotMiniMap.Top := 104;
  DBotMiniMap.Visible := True;
  DBotTrade.SetImgIndex(g_WMain99Images, 1924);
  DBotTrade.Left := 209 + 30 * 1;
  DBotTrade.Top := 104;
  DBotTrade.OnDirectPaint := DButRenewChrDirectPaint;
  DBotGuild.SetImgIndex(g_WMain99Images, 1926);
  DBotGuild.Left := 209 + 30 * 2;
  DBotGuild.Top := 104;
  DBotGuild.OnDirectPaint := DButRenewChrDirectPaint;
  DBotGroup.SetImgIndex(g_WMain99Images, 1920);
  DBotGroup.Left := 209 + 30 * 3;
  DBotGroup.Top := 104;
  DBotGroup.OnDirectPaint := DButRenewChrDirectPaint;
  DBotFriend.SetImgIndex(g_WMain99Images, 2140);
  DBotFriend.Left := 209 + 30 * 4;
  DBotFriend.Top := 104;
  DBotFriend.OnDirectPaint := DButRenewChrDirectPaint;
  DBotSort.SetImgIndex(g_WMain99Images, 1931);
  DBotSort.Left := 209 + 30 * 5;
  DBotSort.Top := 104;
  DBotSort.OnDirectPaint := DButRenewChrDirectPaint;
  DOption.SetImgIndex(g_WMain99Images, 2040);
  DOption.Left := 209 + 30 * 8;
  DOption.Top := 104;
  DOption.OnDirectPaint := DButRenewChrDirectPaint;
  DButtonTop.SetImgIndex(g_WMain99Images, 2142);
  DButtonTop.Left := 209 + 30 * 6;
  DButtonTop.Top := 104;
  if DButtonTop.DParent <> nil then DButtonTop.DParent.DelChild(DButtonTop);
  DButtonTop.DParent := DBottom;
  DButtonTop.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DButtonTop);
  DButtonTop.OnDirectPaint := DButRenewChrDirectPaint;
  DBottom2.Visible := False;

  DBTTakeHorse.SetImgIndex(g_WMain99Images, 1632);
  DBTTakeHorse.Left := 209 + 30 * 7;
  DBTTakeHorse.Top := 104;
  if DBTTakeHorse.DParent <> nil then DBTTakeHorse.DParent.DelChild(DBTTakeHorse);
  DBTTakeHorse.DParent := DBottom;
  DBTTakeHorse.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DBTTakeHorse);
  DBTTakeHorse.OnDirectPaint := DButRenewChrDirectPaint;

  DBotAddAbil.SetImgIndex(g_WMain99Images, 1928);
  DBotAddAbil.Left := 209 + 30 * 9;
  DBotAddAbil.Top := 104;
  DBotAddAbil.Visible := True;


  DTopShop.SetImgIndex(g_WMain99Images, 2220);
  DTopShop.Left := g_FScreenWidth - 46;
  DTopShop.Top := 204;
  if DTopShop.DParent <> nil then DTopShop.DParent.DelChild(DTopShop);
  DTopShop.DParent := DBottom;
  DTopShop.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DTopShop);

  DTopHelp.SetImgIndex(g_WMain99Images, 2042);
  DTopHelp.Left := g_FScreenWidth - 199;
  DTopHelp.Top := 59;
  if DTopHelp.DParent <> nil then DTopHelp.DParent.DelChild(DTopHelp);
  DTopHelp.DParent := DBottom;
  DTopHelp.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DTopHelp);

  DTopEMail.SetImgIndex(g_WMain99Images, 2045);
  DTopEMail.Left := 170;
  DTopEMail.Top := 60;
  if DTopEMail.DParent <> nil then DTopEMail.DParent.DelChild(DTopEMail);
  DTopEMail.DParent := DBottom;
  DTopEMail.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DTopEMail);

  DBTFace.SetImgIndex(g_WMain99Images, 1634);
  DBTFace.Left := g_FScreenWidth - 228;
  DBTFace.Top := 229;
  if DBTFace.DParent <> nil then DBTFace.DParent.DelChild(DBTFace);
  DBTFace.DParent := DBottom;
  DBTFace.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DBTFace);
  DBTFace.OnDirectPaint := DButRenewChrDirectPaint;

  if DEditChat.DParent <> nil then DEditChat.DParent.DelChild(DEditChat);
  DEditChat.DParent := DBottom;
  DBottom.AddChild(DEditChat);

  if DSayUpDown.DParent <> nil then DSayUpDown.DParent.DelChild(DSayUpDown);
  DSayUpDown.DParent := DBottom;
  DBottom.AddChild(DSayUpDown);

  DSayUpDown.SetImgIndex(g_WMain99Images, 2202);
  DSayUpDown.Top := 118;
  DSayUpDown.Left := g_FScreenWidth - 203;
  DSayUpDown.Height := 112;

  DSayUpDown.UpButton.SetImgIndex(g_WMain99Images, 2203);
  DSayUpDown.DownButton.SetImgIndex(g_WMain99Images, 2206);
  DSayUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2209);

  DEditChat.Left := 208;
  DEditChat.Top := 230;
  DEditChat.Height := 16;
  DEditChat.Width := g_FScreenWidth - 436;
//  if g_FScreenWidth = BASE_WIDTH then
    DEditChat.MaxLength := 70;
//  else
//    DEditChat.MaxLength := 96;
  DEditChat.boTransparent := False;

  DBotWndSay.Left := 209;
  DBotWndSay.Top := 118;
  DBotWndSay.Width := g_FScreenWidth - 414;
  DBotWndSay.Height := 112;
  DBotWndSay.Visible := True;

  DCloseSayHear.SetImgIndex(g_WMain99Images, 2221);
  DCloseSayHear.Left := 176;
  DCloseSayHear.Top := 122;
  DCloseSayHear.Visible := True;

  DCloseSayWhisper.SetImgIndex(g_WMain99Images, 2223);
  DCloseSayWhisper.Left := 176;
  DCloseSayWhisper.Top := 142;
  DCloseSayWhisper.Visible := True;

  DCloseSayCry.SetImgIndex(g_WMain99Images, 2225);
  DCloseSayCry.Left := 176;
  DCloseSayCry.Top := 162;
  DCloseSayCry.Visible := True;

  DCloseSayGuild.SetImgIndex(g_WMain99Images, 2227);
  DCloseSayGuild.Left := 176;
  DCloseSayGuild.Top := 182;
  DCloseSayGuild.Visible := True;
  
  DCloseSayGroup.SetImgIndex(g_WMain99Images, 2229);
  DCloseSayGroup.Left := 176;
  DCloseSayGroup.Top := 202;
  DCloseSayGroup.Visible := True;
{$ELSE}
  d := g_WMain99Images.Images[40];
  if d <> nil then begin
    DBottom.SetImgIndex(g_WMain99Images, 40);
    DBottom.Left := g_FScreenXOrigin - d.Width div 2;
    DBottom.Top := g_FScreenHeight - d.Height;
  end;

  DUserKeyGrid1.Left := 66;
  DUserKeyGrid1.Top := 7;
  DUserKeyGrid1.Width := 500;
  DUserKeyGrid1.Height := 38;

  DUserKeyGrid2.Left := 65;
  DUserKeyGrid2.Top := 7;
  DUserKeyGrid2.Width := 332;
  DUserKeyGrid2.Height := 38;

  d := g_WMain99Images.Images[41];
  if d <> nil then begin
    DBottom2.SetImgIndex(g_WMain99Images, 41);
    DBottom2.Left := 441;
    DBottom2.Top := -d.Height;
  end;

  DBTAttackMode.SetImgIndex(g_WMain99Images, 493);
  DBTAttackMode.Top := 32;
  DBTAttackMode.Left := 510;

  DWndAttackModeList.SetImgIndex(g_WMain99Images, 492);
  DWndAttackModeList.Top := 54;
  DWndAttackModeList.Left := g_FScreenWidth div 2 + 108;

  DBTAttackModeAll.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeAll.Top := 3;
  DBTAttackModeAll.Left := 2;
  DBTAttackModePeace.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModePeace.Top := 3 + 1 * 24;
  DBTAttackModePeace.Left := 2;
  DBTAttackModeDear.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeDear.Top := 3 + 2 * 24;
  DBTAttackModeDear.Left := 2;
  DBTAttackModeMaster.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeMaster.Top := 3 + 3 * 24;
  DBTAttackModeMaster.Left := 2;
  DBTAttackModeGroup.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeGroup.Top := 3 + 4 * 24;
  DBTAttackModeGroup.Left := 2;
  DBTAttackModeGuild.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeGuild.Top := 3 + 5 * 24;
  DBTAttackModeGuild.Left := 2;
  DBTAttackModePK.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModePK.Top := 3 + 6 * 24;
  DBTAttackModePK.Left := 2;

  DMyState.SetImgIndex(g_WMain99Images, 75);
  DMyState.Left := 592;
  DMyState.Top := 9;
  DMyBag.SetImgIndex(g_WMain99Images, 78);
  DMyBag.Left := 620;
  DMyBag.Top := 9;
  DMyMagic.SetImgIndex(g_WMain99Images, 81);
  DMyMagic.Left := 648;
  DMyMagic.Top := 9;
  DBotTrade.SetImgIndex(g_WMain99Images, 84);
  DBotTrade.Left := 676;
  DBotTrade.Top := 9;
  DBotGuild.SetImgIndex(g_WMain99Images, 87);
  DBotGuild.Left := 704;
  DBotGuild.Top := 9;
  DBotGroup.SetImgIndex(g_WMain99Images, 90);
  DBotGroup.Left := 732;
  DBotGroup.Top := 9;
  DBotFriend.SetImgIndex(g_WMain99Images, 93);
  DBotFriend.Left := 760;
  DBotFriend.Top := 9;
  DBotSort.SetImgIndex(g_WMain99Images, 96);
  DBotSort.Left := 788;
  DBotSort.Top := 9;
  DOption.SetImgIndex(g_WMain99Images, 99);
  DOption.Left := 816;
  DOption.Top := 9;
{$IFEND}

  DBTCheck1.SetImgIndex(g_WMain99Images, 378);
  DBTCheck1.Left := 380;
  DBTCheck1.Top := -(DBottom.Top - 162){$IF Var_Interface = Var_Mir2} - 61{$IFEND};
  DBTCheck2.SetImgIndex(g_WMain99Images, 379);
  DBTCheck2.Left := 380;
  DBTCheck2.Top := -(DBottom.Top - 162){$IF Var_Interface = Var_Mir2} - 61{$IFEND};
  DBTCheck3.SetImgIndex(g_WMain99Images, 381);
  DBTCheck3.Left := 380;
  DBTCheck3.Top := -(DBottom.Top - 162){$IF Var_Interface = Var_Mir2} - 61{$IFEND};
  DBTCheck4.SetImgIndex(g_WMain99Images, 382);
  DBTCheck4.Left := 380;
  DBTCheck4.Top := -(DBottom.Top - 162){$IF Var_Interface = Var_Mir2} - 61{$IFEND};
  DBTCheck5.SetImgIndex(g_WMain99Images, 384);
  DBTCheck5.Left := 380;
  DBTCheck5.Top := -(DBottom.Top - 162){$IF Var_Interface = Var_Mir2} - 61{$IFEND};
  DBTCheck6.SetImgIndex(g_WMain99Images, 385);
  DBTCheck6.Left := 380;
  DBTCheck6.Top := -(DBottom.Top - 162){$IF Var_Interface = Var_Mir2} - 61{$IFEND};
  DBTCheck7.SetImgIndex(g_WMain99Images, 387);
  DBTCheck7.Left := 380;
  DBTCheck7.Top := -(DBottom.Top - 162){$IF Var_Interface = Var_Mir2} - 61{$IFEND};
  DBTCheck8.SetImgIndex(g_WMain99Images, 388);
  DBTCheck8.Left := 380;
  DBTCheck8.Top := -(DBottom.Top - 162){$IF Var_Interface = Var_Mir2} - 61{$IFEND};
  DBTCheck9.SetImgIndex(g_WMain99Images, 390);
  DBTCheck9.Left := 380;
  DBTCheck9.Top := -(DBottom.Top - 162){$IF Var_Interface = Var_Mir2} - 61{$IFEND};
  DBTCheck10.SetImgIndex(g_WMain99Images, 391);
  DBTCheck10.Left := 380;
  DBTCheck10.Top := -(DBottom.Top - 162){$IF Var_Interface = Var_Mir2} - 61{$IFEND};

  dwndWhisperName.Left := 15;
  dwndWhisperName.Top := 391;
  dwndWhisperName.Height := 144;
  dwndWhisperName.Width := 120;

  //顶部状态栏
  d := g_WMain99Images.Images[2];
  if d <> nil then begin
    DTop.SetImgIndex(g_WMain99Images, 2);
    DTop.Left := g_FScreenXOrigin - d.Width div 2;
    DTop.Top := 0;
  end;

  DTopGM.SetImgIndex(g_WMain99Images, 54);
  DTopGM.Left := 8;
  DTopGM.Top := 2;
{$IF Var_Interface =  Var_Default}
  DTopHelp.SetImgIndex(g_WMain99Images, 57);
  DTopHelp.Left := 8;
  DTopHelp.Top := 18;
  DTopHelp.OnDirectPaint := DMyStateDirectPaint;
  DTopEMail.SetImgIndex(g_WMain99Images, 318);
  DTopEMail.Left := 8;
  DTopEMail.Top := 39;
  DTopShop.SetImgIndex(g_WMain99Images, 72);
  DTopShop.Left := 622;
  DTopShop.Top := 21;
  DButtonTop.SetImgIndex(g_WMain99Images, 1450);
  DButtonTop.Left := 622;
  DButtonTop.Top := 53;
{$IFEND}
  DOpenMinmap.SetImgIndex(g_WMain99Images, 61);
  DOpenMinmap.Left := 783;
  DOpenMinmap.Top := 1;

  DTopStatusEXP.SetImgIndex(g_WMain99Images, 1500);
  DTopStatusEXP.AppendData := @g_StatusInfoArr[STATUS_EXP];
  g_StatusInfoArr[STATUS_EXP].Button := DTopStatusEXP; 
  DTopStatusPOW.SetImgIndex(g_WMain99Images, 1501);
  DTopStatusPOW.AppendData := @g_StatusInfoArr[STATUS_POW];
  g_StatusInfoArr[STATUS_POW].Button := DTopStatusPOW;
  DTopStatusSC.SetImgIndex(g_WMain99Images, 1502);
  DTopStatusSC.AppendData := @g_StatusInfoArr[STATUS_SC];
  g_StatusInfoArr[STATUS_SC].Button := DTopStatusSC;
  DTopStatusAC.SetImgIndex(g_WMain99Images, 1503);
  DTopStatusAC.AppendData := @g_StatusInfoArr[STATUS_AC];
  g_StatusInfoArr[STATUS_AC].Button := DTopStatusAC;
  DTopStatusDC.SetImgIndex(g_WMain99Images, 1504);
  DTopStatusDC.AppendData := @g_StatusInfoArr[STATUS_DC];
  g_StatusInfoArr[STATUS_DC].Button := DTopStatusDC;
  DTopStatusHIDEMODE.SetImgIndex(g_WMain99Images, 1505);
  DTopStatusHIDEMODE.AppendData := @g_StatusInfoArr[STATUS_HIDEMODE];
  g_StatusInfoArr[STATUS_HIDEMODE].Button := DTopStatusHIDEMODE;
  DTopStatusSTONE.SetImgIndex(g_WMain99Images, 1506);
  DTopStatusSTONE.AppendData := @g_StatusInfoArr[STATUS_STONE];
  g_StatusInfoArr[STATUS_STONE].Button := DTopStatusSTONE;
  DTopStatusMC.SetImgIndex(g_WMain99Images, 1507);
  DTopStatusMC.AppendData := @g_StatusInfoArr[STATUS_MC];
  g_StatusInfoArr[STATUS_MC].Button := DTopStatusMC;
  DTopStatusMP.SetImgIndex(g_WMain99Images, 1508);
  DTopStatusMP.AppendData := @g_StatusInfoArr[STATUS_MP];
  g_StatusInfoArr[STATUS_MP].Button := DTopStatusMP;
  DTopStatusMAC.SetImgIndex(g_WMain99Images, 1509);
  DTopStatusMAC.AppendData := @g_StatusInfoArr[STATUS_MAC];
  g_StatusInfoArr[STATUS_MAC].Button := DTopStatusMAC;
  DTopStatusHP.SetImgIndex(g_WMain99Images, 1510);
  DTopStatusHP.AppendData := @g_StatusInfoArr[STATUS_HP];
  g_StatusInfoArr[STATUS_HP].Button := DTopStatusHP;
  DTopStatusDAMAGEARMOR.SetImgIndex(g_WMain99Images, 1511);
  DTopStatusDAMAGEARMOR.AppendData := @g_StatusInfoArr[STATUS_DAMAGEARMOR];
  g_StatusInfoArr[STATUS_DAMAGEARMOR].Button := DTopStatusDAMAGEARMOR;
  DTopStatusDECHEALTH.SetImgIndex(g_WMain99Images, 1512);
  DTopStatusDECHEALTH.AppendData := @g_StatusInfoArr[STATUS_DECHEALTH];
  g_StatusInfoArr[STATUS_DECHEALTH].Button := DTopStatusDECHEALTH;
  DTopStatusCOBWEB.SetImgIndex(g_WMain99Images, 1513);
  DTopStatusCOBWEB.AppendData := @g_StatusInfoArr[STATUS_COBWEB];
  g_StatusInfoArr[STATUS_COBWEB].Button := DTopStatusCOBWEB; 

  //小地图窗口
  d := g_WMain99Images.Images[60];
  if d <> nil then begin
    DMiniMapDlg.SetImgIndex(g_WMain99Images, 60);
    DMiniMapDlg.Left := 654;
    DMiniMapDlg.Top := 21;
  end;
  DMinMap128.Left := 10;
  DMinMap128.Top := 3;
  DMinMap128.Width := 128;
  DMinMap128.Height := 128;

  DMiniMapMax.SetImgIndex(g_WMain99Images, 139);
  DMiniMapMax.Left := 105;
  DMiniMapMax.Top := 106;

  //全景地图窗口
  d := g_WMain99Images.Images[142];
  if d <> nil then begin
    DMaxMiniMap.SetImgIndex(g_WMain99Images, 142);
    DMaxMiniMap.Left := g_FScreenXOrigin - d.Width div 2;
    DMaxMiniMap.Top := g_FScreenYOrigin - d.Height div 2;
  end;

  DMaxMinimapClose.SetImgIndex(g_WMain99Images, 143);
  DMaxMinimapClose.Left := 776;
  DMaxMinimapClose.Top := 1;

  DMaxMap792.Left := 4;
  DMaxMap792.Top := 37;
  DMaxMap792.Width := 792;
  DMaxMap792.Height := 536;

  //物品包裹栏
{$IF Var_Interface = Var_Mir2}
  DItemBag.SetImgIndex(g_WMain99Images, 1623);
  DItemBag.Left := 0;
  DItemBag.Top := 0;

  DItemBagShop.SetImgIndex(g_WMain99Images, 2231);
  DItemBagShop.Top := 218;
  DItemBagShop.Left := 214;
  DItemBagShop.OnDirectPaint := DBTHintCloseDirectPaint;
  DItemBagShop.DFColor := $ADD6EF;
  DItemBagShop.Caption := '摆摊界面';

  DItemBagRef.SetImgIndex(g_WMain99Images, 1624);
  DItemBagRef.Top := 271;
  DItemBagRef.Left := 270;
  //DItemBagRef.Visible := False;

  DItemAppendBag1.SetImgIndex(g_WMain99Images, 369);
  DItemAppendBag1.Top := 29;
  DItemAppendBag1.Visible := False;
  DItemAppendBag2.SetImgIndex(g_WMain99Images, 369);
  DItemAppendBag2.Top := 118;
  DItemAppendBag2.Visible := False;
  DItemAppendBag3.SetImgIndex(g_WMain99Images, 369);
  DItemAppendBag3.Top := 207;
  DItemAppendBag3.Visible := False;

  DItemGrid1.Top := 10;
  DItemGrid1.Left := 10;
  DItemGrid1.Height := 69;
  DItemGrid1.Visible := False;
  DItemGrid2.Top := 10;
  DItemGrid2.Left := 10;
  DItemGrid2.Height := 69;
  DItemGrid2.Visible := False;
  DItemGrid3.Top := 10;
  DItemGrid3.Left := 10;
  DItemGrid3.Height := 69;
  DItemGrid3.Visible := False;

  DItemGrid.Left := 23;
  DItemGrid.Top := 22;
  DItemGrid.Width := 285;
  DItemGrid.Height := 190;
  DItemGrid.ColCount := 8;
  DItemGrid.ColWidth := 33;
  DItemGrid.ColOffset := 3;
  DItemGrid.RowCount := 6;
  DItemGrid.RowHeight := 30;
  DItemGrid.RowOffset := 2;

  DGold.Left := 7;
  DGold.Top := 219;
  DGold.Width := 44;
  DGold.Height := 44;

  DItemAddBag1.Left := 24;
  DItemAddBag1.Top := 368;
  DItemAddBag1.Width := 34;
  DItemAddBag1.Height := 34;
  DItemAddBag2.Left := 80;
  DItemAddBag2.Top := 368;
  DItemAddBag2.Width := 34;
  DItemAddBag2.Height := 34;
  DItemAddBag3.Left := 136;
  DItemAddBag3.Top := 368;
  DItemAddBag3.Width := 34;
  DItemAddBag3.Height := 34;
  DItemAddBag1.Visible := False;
  DItemAddBag2.Visible := False;
  DItemAddBag3.Visible := False;

  DCloseBag.SetImgIndex(g_WMain99Images, 1850);
  DCloseBag.Left := 331;
  DCloseBag.Top := 38;

  DOpenCompoundItem.SetImgIndex(g_WMain99Images, 1813);
  DOpenCompoundItem.Left := 293;
  DOpenCompoundItem.Top := 223;
{$ELSE}
  DItemBag.SetImgIndex(g_WMain99Images, 132);
  DItemBag.Left := g_FScreenWidth - DItemBag.Width;
  DItemBag.Top := 0;

  DItemBagShop.Caption := '开始摆摊';
  DItemBagShop.SetImgIndex(g_WMain99Images, 330);
  DItemBagShop.Top := 478 + 21;
  DItemBagShop.Left := 7;

  DOpenCompoundItem.SetImgIndex(g_WMain99Images, 147);
  DOpenCompoundItem.Top := 478 + 21;
  DOpenCompoundItem.Left := 81;
  DOpenCompoundItem.OnDirectPaint := nil;

  DItemBagRef.Caption := '刷新';
  DItemBagRef.SetImgIndex(g_WMain99Images, 147);
  DItemBagRef.Top := 478 + 21;
  DItemBagRef.Left := 135;
  DItemBagRef.OnDirectPaint := nil;

  DItemAppendBag1.SetImgIndex(g_WMain99Images, 369);
  DItemAppendBag1.Top := 29;
  DItemAppendBag2.SetImgIndex(g_WMain99Images, 369);
  DItemAppendBag2.Top := 118;
  DItemAppendBag3.SetImgIndex(g_WMain99Images, 369);
  DItemAppendBag3.Top := 207;

  DItemGrid1.Top := 10;
  DItemGrid1.Left := 10;
  DItemGrid1.Height := 69;
  DItemGrid2.Top := 10;
  DItemGrid2.Left := 10;
  DItemGrid2.Height := 69;
  DItemGrid3.Top := 10;
  DItemGrid3.Left := 10;
  DItemGrid3.Height := 69;

  DItemGrid.Left := 10;
  DItemGrid.Top := 35 + 4;
  DItemGrid.Width := 174;
  DItemGrid.Height := 314;

  DGold.Left := 7;
  DGold.Top := 413;
  DGold.Width := 180;
  DGold.Height := 19;

  DItemAddBag1.Left := 24;
  DItemAddBag1.Top := 368;
  DItemAddBag1.Width := 34;
  DItemAddBag1.Height := 34;
  DItemAddBag2.Left := 80;
  DItemAddBag2.Top := 368;
  DItemAddBag2.Width := 34;
  DItemAddBag2.Height := 34;
  DItemAddBag3.Left := 136;
  DItemAddBag3.Top := 368;
  DItemAddBag3.Width := 34;
  DItemAddBag3.Height := 34;

  DCloseBag.SetImgIndex(g_WMain99Images, 133);
  DCloseBag.Left := 174;
  DCloseBag.Top := 8 + 4;  
{$IFEND}


  //聊天框
  DWndSay.Left := 0;
  DWndSay.Height := 2 + SAYLISTHEIGHT * 7;
  DWndSay.Top := g_FScreenHeight - DWndSay.Height - DBottom.Height - 39;

  DWndSay.Width := DEFSAYLISTWIDTH + 16;

  DBtnSayAll.SetImgIndex(g_WMain99Images, 594);
  DBtnSayAll.Left := 16;
  DBtnSayAll.Top := DWndSay.Height + 1;
  DBtnSayAll.AppendData := Pointer(Integer(us_All));
  DBtnSayHear.SetImgIndex(g_WMain99Images, 596);
  DBtnSayHear.Left := DBtnSayAll.Left + DBtnSayAll.Width;
  DBtnSayHear.Top := DWndSay.Height + 1;
  DBtnSayHear.AppendData := Pointer(Integer(us_Hear));
  DBtnSayWhisper.SetImgIndex(g_WMain99Images, 598);
  DBtnSayWhisper.Left := DBtnSayHear.Left + DBtnSayHear.Width;
  DBtnSayWhisper.Top := DWndSay.Height + 1;
  DBtnSayWhisper.AppendData := Pointer(Integer(us_Whisper));
  DBtnSayCry.SetImgIndex(g_WMain99Images, 600);
  DBtnSayCry.Left := DBtnSayWhisper.Left + DBtnSayWhisper.Width;
  DBtnSayCry.Top := DWndSay.Height + 1;
  DBtnSayCry.AppendData := Pointer(Integer(us_Cry));
  DBtnSayGroup.SetImgIndex(g_WMain99Images, 602);
  DBtnSayGroup.Left := DBtnSayCry.Left + DBtnSayCry.Width;
  DBtnSayGroup.Top := DWndSay.Height + 1;
  DBtnSayGroup.AppendData := Pointer(Integer(us_Group));
  DBtnSayGuild.SetImgIndex(g_WMain99Images, 604);
  DBtnSayGuild.Left := DBtnSayGroup.Left + DBtnSayGroup.Width;
  DBtnSayGuild.Top := DWndSay.Height + 1;
  DBtnSayGuild.AppendData := Pointer(Integer(us_Guild));
  DBtnSaySys.SetImgIndex(g_WMain99Images, 606);
  DBtnSaySys.Left := DBtnSayGuild.Left + DBtnSayGuild.Width;
  DBtnSaySys.Top := DWndSay.Height + 1;
  DBtnSaySys.AppendData := Pointer(Integer(us_Sys));
  DBtnSayCustom.SetImgIndex(g_WMain99Images, 608);
  DBtnSayCustom.Left := DBtnSaySys.Left + DBtnSaySys.Width;
  DBtnSayCustom.Top := DWndSay.Height + 1;
  DBtnSayCustom.AppendData := Pointer(Integer(us_Custom));

  dchkSayLock.SetImgIndex(g_WMain99Images, 151);
  dchkSayLock.Left := DBtnSaySys.Left + DBtnSaySys.Width;
  dchkSayLock.Top := DWndSay.Height + 2;

  DBTSayLock.SetImgIndex(g_WMain99Images, 582);
  DBTSayLock.Left := -1;
  DBTSayLock.Top := DWndSay.Height + 19;

  dwndSayMode.Left := DBTSayLock.Left;
  dwndSayMode.Top := 415;
  dwndSayMode.Height := 10;
  dwndSayMode.Width := 10;

  dbtnSayModeWorld.SetImgIndex(g_WMain99Images, 656);
  dbtnSayModeWorld.Left := 0;
  dbtnSayModeWorld.Top := 0;
  dbtnSayModeGuild.SetImgIndex(g_WMain99Images, 654);
  dbtnSayModeGuild.Left := 0;
  dbtnSayModeGuild.Top := dbtnSayModeWorld.Top + dbtnSayModeWorld.Height;
  dbtnSayModeGroup.SetImgIndex(g_WMain99Images, 652);
  dbtnSayModeGroup.Left := 0;
  dbtnSayModeGroup.Top := dbtnSayModeGuild.Top + dbtnSayModeGuild.Height;
  dbtnSayModeCry.SetImgIndex(g_WMain99Images, 650);
  dbtnSayModeCry.Left := 0;
  dbtnSayModeCry.Top := dbtnSayModeGroup.Top + dbtnSayModeGroup.Height;
  dbtnSayModeWhisper.SetImgIndex(g_WMain99Images, 658);
  dbtnSayModeWhisper.Left := 0;
  dbtnSayModeWhisper.Top := dbtnSayModeCry.Top + dbtnSayModeCry.Height;
  dbtnSayModeHear.SetImgIndex(g_WMain99Images, 648);
  dbtnSayModeHear.Left := 0;
  dbtnSayModeHear.Top := dbtnSayModeWhisper.Top + dbtnSayModeWhisper.Height;

  DBTEdit.SetImgIndex(g_WMain99Images, 102);
  DBTEdit.Left := DBTSayLock.Width - 1;
  DBTEdit.Top := DBTSayLock.Top;

  DBTSayMove.SetImgIndex(g_WMain99Images, 117);
  DBTSayMove.Left := 0;
  DBTSayMove.Top := 0;

{$IF Var_Interface =  Var_Default}
  DSayUpDown.SetImgIndex(g_WMain99Images, 120);
  DSayUpDown.Top := 15;
  DSayUpDown.Left := 0;
  DSayUpDown.Height := DWndSay.Height - 15 + 18;

  DSayUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DSayUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DSayUpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DEditChat.Left := DBTEdit.Left + 2;
  DEditChat.Top := DBTEdit.Top + (DBTEdit.Height - 16) div 2;
  DEditChat.Height := 16;
  DEditChat.Width := DBTEdit.Width - 4;

  DBTFace.SetImgIndex(g_WMain99Images, 103);
  DBTFace.Top := DBTEdit.Top;
  DBTFace.Left := DBTEdit.Left + DBTEdit.Width;
{$IFEND}

  DBTOption.SetImgIndex(g_WMain99Images, 127);
  DBTOption.Top := DBTEdit.Top;
  DBTOption.Left := DBTFace.Left + DBTFace.Width - 1;
{$IF Var_Interface =  Var_Default}
  DBTTakeHorse.SetImgIndex(g_WMain99Images, 324);
  DBTTakeHorse.Top := DBTEdit.Top;
  DBTTakeHorse.Left := DBTOption.Left + DBTOption.Width - 1;
{$IF Var_Free = 1}
  DBTTakeHorse.Visible := False;
{$IFEND}
{$IFEND}
  //DPopUpSayList.SetImgIndex(g_WMain99Images, 276);
                        
  dwndWhisperName.Left := DEditChat.SurfaceX(DEditChat.Left);
  dwndWhisperName.Height := 144;
  dwndWhisperName.Top := DEditChat.SurfaceY(DEditChat.Top) - dwndWhisperName.Height;
  dwndWhisperName.Width := 120;

  //表情窗口
{$IF Var_Interface = Var_Mir2}
  DWndFace.Width := FACESHOWCOUNT * 24 + 8;
  DWndFace.Left := g_FScreenWidth - DWndFace.Width - 205;
  DWndFace.Height := 8 + ((High(g_FaceIndexList) + 1) div FACESHOWCOUNT + 1) * 24;
  DWndFace.Top := DBTFace.SurfaceY(DBTFace.Top) - DWndFace.Height;

{$ELSE}
  DWndFace.Left := DBTFace.Left;
  DWndFace.Height := 8 + ((High(g_FaceIndexList) + 1) div FACESHOWCOUNT + 1) * 24;
  DWndFace.Top := DBTFace.SurfaceY(DBTFace.Top) - DWndFace.Height - 30;
  DWndFace.Width := FACESHOWCOUNT * 24 + 8;
{$IFEND}
  //显示装备窗口

  DBTItemShowClose.SetImgIndex(g_WMain99Images, 294);
  DBTItemShowClose.Top := 4;
  DBTItemShowClose.Left := 0;

  //人物状态窗口
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1770]; //惑怕  370
  if d <> nil then begin
    DStateWin.SetImgIndex(g_WMain99Images, 1770);
    DStateWin.Left := g_FScreenWidth - d.Width;
    DStateWin.Top := 0;
  end;
  DCloseState.SetImgIndex(g_WMain99Images, 1850);
  DCloseState.Top := 34;
  DCloseState.Left := 259;

  DStateWinItem.Left := 16;
  DStateWinItem.Top := 90;
  DStateWinItem.Width := 259;
  DStateWinItem.Height := 255;
  DStateWinAbil.Left := 16;
  DStateWinAbil.Top := 90;
  DStateWinAbil.Width := 259;
  DStateWinAbil.Height := 255;
  DStateWinMagic.Left := 16;
  DStateWinMagic.Top := 90;
  DStateWinMagic.Width := 259;
  DStateWinMagic.Height := 255;
  DStateWinInfo.Left := 16;
  DStateWinInfo.Top := 90;
  DStateWinInfo.Width := 259;
  DStateWinInfo.Height := 255;
  DStateWinHorse.Left := 16;
  DStateWinHorse.Top := 90;
  DStateWinHorse.Width := 259;
  DStateWinHorse.Height := 255;
  DStateWinState.Left := 16;
  DStateWinState.Top := 90;
  DStateWinState.Width := 259;
  DStateWinState.Height := 255;

  DStateBTItem.SetImgIndex(g_WMain99Images, 1782);
  DStateBTItem.Top := 63;
  DStateBTItem.Left := 16;
  DStateBTState.SetImgIndex(g_WMain99Images, 1784);
  DStateBTState.Top := 63;
  DStateBTState.Left := 58;
  DStateBTState.Visible := True;
  DStateBTAbil.SetImgIndex(g_WMain99Images, 1786);
  DStateBTAbil.Top := 63;
  DStateBTAbil.Left := 102;
  DStateBTMagic.SetImgIndex(g_WMain99Images, 1788);
  DStateBTMagic.Top := 63;
  DStateBTMagic.Left := 145;
{$IF Var_Free = 1}
  DStateBTHorse.Visible := False;
  DStateBTInfo.SetImgIndex(g_WMain99Images, 1792);
  DStateBTInfo.Top := 63;
  DStateBTInfo.Left := 188;
{$ELSE}
  DStateBTHorse.SetImgIndex(g_WMain99Images, 1790);
  DStateBTHorse.Top := 63;
  DStateBTHorse.Left := 188;
  DStateBTInfo.SetImgIndex(g_WMain99Images, 1792);
  DStateBTInfo.Top := 63;
  DStateBTInfo.Left := 231;
{$IFEND}

{$ELSE}
  d := g_WMain99Images.Images[235]; //惑怕  370
  if d <> nil then begin
    DStateWin.SetImgIndex(g_WMain99Images, 235);
    DStateWin.Left := 0;
    DStateWin.Top := 19;
  end;
  DCloseState.SetImgIndex(g_WMain99Images, 133);
  DCloseState.Top := 8 + 4;
  DCloseState.Left := DStateWin.Width - DCloseState.Width - 4;
  DStateWinItem.Left := 8;
  DStateWinItem.Top := 37;
  DStateWinItem.Width := 268;
  DStateWinItem.Height := 338;
  DStateWinAbil.Left := 8;
  DStateWinAbil.Top := 37;
  DStateWinAbil.Width := 268;
  DStateWinAbil.Height := 338;
  DStateWinMagic.Left := 8;
  DStateWinMagic.Top := 37;
  DStateWinMagic.Width := 268;
  DStateWinMagic.Height := 338;
  DStateWinInfo.Left := 8;
  DStateWinInfo.Top := 37;
  DStateWinInfo.Width := 268;
  DStateWinInfo.Height := 338;
  DStateWinHorse.Left := 8;
  DStateWinHorse.Top := 37;
  DStateWinHorse.Width := 268;
  DStateWinHorse.Height := 338;

  DStateWinState.Left := 8;
  DStateWinState.Top := 37;
  DStateWinState.Width := 268;
  DStateWinState.Height := 338;


  DStateBTItem.SetImgIndex(g_WMain99Images, 219);
  DStateBTItem.Top := 377;
  DStateBTItem.Left := 14;
  DStateBTAbil.SetImgIndex(g_WMain99Images, 219);
  DStateBTAbil.Top := 377;
  DStateBTAbil.Left := 66;
  DStateBTMagic.SetImgIndex(g_WMain99Images, 219);
  DStateBTMagic.Top := 377;
  DStateBTMagic.Left := 118;
{$IF Var_Free = 1}
  DStateBTHorse.Visible := False;
  DStateBTInfo.SetImgIndex(g_WMain99Images, 219);
  DStateBTInfo.Top := 377;
  DStateBTInfo.Left := 170;
{$ELSE}
  DStateBTHorse.SetImgIndex(g_WMain99Images, 219);
  DStateBTHorse.Top := 377;
  DStateBTHorse.Left := 170;
  DStateBTInfo.SetImgIndex(g_WMain99Images, 219);
  DStateBTInfo.Top := 377;
  DStateBTInfo.Left := 222;
{$IFEND}
{$IFEND}


  //人物装备
  //nx := 157;
  //ny := 160;
{$IF Var_Interface = Var_Mir2}
  nx := 5;
  ny := 64;
  DSWWeapon.Left := nx;
  DSWWeapon.Top := ny;
  DSWWeapon.Width := 34;
  DSWWeapon.Height := 30;
  DSWDress.Left := nx;
  DSWDress.Top := ny + 1 * 39;
  DSWDress.Width := 34;
  DSWDress.Height := 30;
  DSWArmRingR.Left := nx;
  DSWArmRingR.Top := ny + 2 * 39;
  DSWArmRingR.Width := 34;
  DSWArmRingR.Height := 30;
  DSWRingR.Left := nx;
  DSWRingR.Top := ny + 3 * 39;
  DSWRingR.Width := 34;
  DSWRingR.Height := 30;
  DSWBelt.Left := nx;
  DSWBelt.Top := ny + 4 * 39;
  DSWBelt.Width := 34;
  DSWBelt.Height := 30;

  //nx := 372;
  //ny := 125;
  nx := 220;
  ny := 25;
  DSWHelmet.Left := nx;
  DSWHelmet.Top := ny;
  DSWHelmet.Width := 34;
  DSWHelmet.Height := 30;
  DSWNecklace.Left := nx;
  DSWNecklace.Top := ny + 1 * 39;
  DSWNecklace.Width := 34;
  DSWNecklace.Height := 30;
  DSWLight.Left := nx;
  DSWLight.Top := ny + 2 * 39;
  DSWLight.Width := 34;
  DSWLight.Height := 30;
  DSWArmRingL.Left := nx;
  DSWArmRingL.Top := ny + 3 * 39;
  DSWArmRingL.Width := 34;
  DSWArmRingL.Height := 30;
  DSWRingL.Left := nx;
  DSWRingL.Top := ny + 4 * 39;
  DSWRingL.Width := 34;
  DSWRingL.Height := 30;
  DSWBoots.Left := nx;
  DSWBoots.Top := ny + 5 * 39;
  DSWBoots.Width := 34;
  DSWBoots.Height := 30;

  //nx := 200;
  //ny := 300;
  nx := 48;
  ny := 220;
  DSWBujuk.Left := nx;
  DSWBujuk.Top := ny;
  DSWBujuk.Width := 34;
  DSWBujuk.Height := 30;
  DSWHouse.Left := nx + 1 * 43;
  DSWHouse.Top := ny;
  DSWHouse.Width := 34;
  DSWHouse.Height := 30;
  DSWCharm.Left := nx + 2 * 43;
  DSWCharm.Top := ny;
  DSWCharm.Width := 34;
  DSWCharm.Height := 30;
  DSWCowry.Left := nx + 3 * 43;
  DSWCowry.Top := ny;
  DSWCowry.Width := 34;
  DSWCowry.Height := 30;
{$ELSE}
  nx := 9;
  ny := 101;
  DSWWeapon.Left := nx;
  DSWWeapon.Top := ny;
  DSWWeapon.Width := 36;
  DSWWeapon.Height := 32;
  DSWDress.Left := nx;
  DSWDress.Top := ny + 1 * 35;
  DSWDress.Width := 36;
  DSWDress.Height := 32;
  DSWArmRingR.Left := nx;
  DSWArmRingR.Top := ny + 2 * 35;
  DSWArmRingR.Width := 36;
  DSWArmRingR.Height := 32;
  DSWRingR.Left := nx;
  DSWRingR.Top := ny + 3 * 35;
  DSWRingR.Width := 36;
  DSWRingR.Height := 32;
  DSWBelt.Left := nx;
  DSWBelt.Top := ny + 4 * 35;
  DSWBelt.Width := 36;
  DSWBelt.Height := 32;

  //nx := 372;
  //ny := 125;
  nx := 224;
  ny := 66;
  DSWHelmet.Left := nx;
  DSWHelmet.Top := ny;
  DSWHelmet.Width := 36;
  DSWHelmet.Height := 32;
  DSWNecklace.Left := nx;
  DSWNecklace.Top := ny + 1 * 35;
  DSWNecklace.Width := 36;
  DSWNecklace.Height := 32;
  DSWLight.Left := nx;
  DSWLight.Top := ny + 2 * 35;
  DSWLight.Width := 36;
  DSWLight.Height := 32;
  DSWArmRingL.Left := nx;
  DSWArmRingL.Top := ny + 3 * 35;
  DSWArmRingL.Width := 36;
  DSWArmRingL.Height := 32;
  DSWRingL.Left := nx;
  DSWRingL.Top := ny + 4 * 35;
  DSWRingL.Width := 36;
  DSWRingL.Height := 32;
  DSWBoots.Left := nx;
  DSWBoots.Top := ny + 5 * 35;
  DSWBoots.Width := 36;
  DSWBoots.Height := 32;

  //nx := 200;
  //ny := 300;
  nx := 52;
  ny := 241;
  DSWBujuk.Left := nx;
  DSWBujuk.Top := ny;
  DSWBujuk.Width := 36;
  DSWBujuk.Height := 32;
  DSWHouse.Left := nx + 1 * 43;
  DSWHouse.Top := ny;
  DSWHouse.Width := 36;
  DSWHouse.Height := 32;
  DSWCharm.Left := nx + 2 * 43;
  DSWCharm.Top := ny;
  DSWCharm.Width := 36;
  DSWCharm.Height := 32;
  DSWCowry.Left := nx + 3 * 43;
  DSWCowry.Top := ny;
  DSWCowry.Width := 36;
  DSWCowry.Height := 32;  
{$IFEND}


  //人物属性
{$IF Var_Interface = Var_Mir2}
  DStateAbilOk.SetImgIndex(g_WMain99Images, 1685);
  DStateAbilOk.Top := 137;
  DStateAbilOk.Left := 137;
  DStateAbilOK.OnDirectPaint := DButRenewChrDirectPaint;

  DStateAbilExit.SetImgIndex(g_WMain99Images, 1683);
  DStateAbilExit.Top := 137;
  DStateAbilExit.Left := 184;
  DStateAbilExit.OnDirectPaint := DButRenewChrDirectPaint;

  DStateAbilAdd1.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd1.Top := 157;
  DStateAbilAdd1.Left := 94;
  DStateAbilAdd2.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd2.Top := 157 + 1 * 16;
  DStateAbilAdd2.Left := 94;
  DStateAbilAdd3.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd3.Top := 157 + 2 * 16;
  DStateAbilAdd3.Left := 94;
  DStateAbilAdd4.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd4.Top := 157 + 3 * 16;
  DStateAbilAdd4.Left := 94;
  DStateAbilAdd5.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd5.Top := 157 + 4 * 16;
  DStateAbilAdd5.Left := 94;
  DStateAbilAdd6.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd6.Top := 157 + 5 * 16;
  DStateAbilAdd6.Left := 94;

  DStateAbilDel1.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel1.Top := 157;
  DStateAbilDel1.Left := 108;
  DStateAbilDel2.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel2.Top := 157 + 1 * 16;
  DStateAbilDel2.Left := 108;
  DStateAbilDel3.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel3.Top := 157 + 2 * 16;
  DStateAbilDel3.Left := 108;
  DStateAbilDel4.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel4.Top := 157 + 3 * 16;
  DStateAbilDel4.Left := 108;
  DStateAbilDel5.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel5.Top := 157 + 4 * 16;
  DStateAbilDel5.Left := 108;
  DStateAbilDel6.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel6.Top := 157 + 5 * 16;
  DStateAbilDel6.Left := 108;
{$ELSE}
  DStateAbilOk.SetImgIndex(g_WMain99Images, 147);
  DStateAbilOk.Top := 238 - 37;
  DStateAbilOk.Left := 145 - 8;

  DStateAbilExit.SetImgIndex(g_WMain99Images, 147);
  DStateAbilExit.Top := 238 - 37;
  DStateAbilExit.Left := 210 - 8;

  DStateAbilAdd1.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd1.Top := 264 - 37;
  DStateAbilAdd1.Left := 102 - 7;
  DStateAbilAdd2.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd2.Top := 264 - 37 + 1 * 18;
  DStateAbilAdd2.Left := 102 - 7;
  DStateAbilAdd3.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd3.Top := 264 - 37 + 2 * 18;
  DStateAbilAdd3.Left := 102 - 7;
  DStateAbilAdd4.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd4.Top := 264 - 37 + 3 * 18;
  DStateAbilAdd4.Left := 102 - 7;
  DStateAbilAdd5.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd5.Top := 264 - 37 + 4 * 18;
  DStateAbilAdd5.Left := 102 - 7;
  DStateAbilAdd6.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd6.Top := 264 - 37 + 5 * 18;
  DStateAbilAdd6.Left := 102 - 7;

  DStateAbilDel1.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel1.Top := 264 - 37;
  DStateAbilDel1.Left := 117 - 7;
  DStateAbilDel2.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel2.Top := 264 - 37 + 1 * 18;
  DStateAbilDel2.Left := 117 - 7;
  DStateAbilDel3.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel3.Top := 264 - 37 + 2 * 18;
  DStateAbilDel3.Left := 117 - 7;
  DStateAbilDel4.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel4.Top := 264 - 37 + 3 * 18;
  DStateAbilDel4.Left := 117 - 7;
  DStateAbilDel5.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel5.Top := 264 - 37 + 4 * 18;
  DStateAbilDel5.Left := 117 - 7;
  DStateAbilDel6.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel6.Top := 264 - 37 + 5 * 18;
  DStateAbilDel6.Left := 117 - 7;  
{$IFEND}


  //人物技能
{$IF Var_Interface = Var_Mir2}
  DStateGrid.Top := 40;
  DStateGrid.Left := 21;
  DStateGrid.Width := 31;
  DStateGrid.Height := 196;
  DStateGrid.ColWidth := 31;
  DStateGrid.Coloffset := 0;
  DStateGrid.ColCount := 1;
  DStateGrid.RowHeight := 32;
  DStateGrid.RowCount := 5;
  DStateGrid.Rowoffset := 9;

  DMagicFront.SetImgIndex(g_WMain99Images, 2196);
  DMagicFront.Top := 102;
  DMagicFront.Left := 238;
  DMagicNext.SetImgIndex(g_WMain99Images, 2199);
  DMagicNext.Top := 154;
  DMagicNext.Left := 238;
  DMagicCBOSetup.SetImgIndex(g_WMain99Images, 1805);
  DMagicCBOSetup.Top := 8;
  DMagicCBOSetup.Left := 169;
  DMagicCBOSetup.OnDirectPaint := DButRenewChrDirectPaint;

  DMagicBase.SetImgIndex(g_WMain99Images, 1765);
  DMagicBase.Top := 8;
  DMagicBase.Left := 9;
  DMagicCbo.SetImgIndex(g_WMain99Images, 1765);
  DMagicCbo.Top := 8;
  DMagicCbo.Left := 81;
  DMagicSub.SetImgIndex(g_WMain99Images, 1765);
  DMagicSub.Top := 44 - 37;
  DMagicSub.Left := 185 - 8;
  DMagicSub.Visible := False;

  DMakeMagicAdd1.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd1.Top := 77; //128,
  DMakeMagicAdd1.Left := 46; // 163
  DMakeMagicAdd3.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd3.Top := 77 + 51; //128,
  DMakeMagicAdd3.Left := 46; // 163
  DMakeMagicAdd5.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd5.Top := 77 + 51 * 2; //128,
  DMakeMagicAdd5.Left := 46; // 163
  DMakeMagicAdd7.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd7.Top := 77 + 51 * 3; //128,
  DMakeMagicAdd7.Left := 46; // 163
  DMakeMagicAdd9.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd9.Top := 77 + 51 * 4; //128,
  DMakeMagicAdd9.Left := 46; // 163

  DMakeMagicAdd2.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd2.Top := 77; //128,
  DMakeMagicAdd2.Left := 163; // 163
  DMakeMagicAdd4.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd4.Top := 77 + 51; //128,
  DMakeMagicAdd4.Left := 163; // 163
  DMakeMagicAdd6.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd6.Top := 77 + 51 * 2; //128,
  DMakeMagicAdd6.Left := 163; // 163
  DMakeMagicAdd8.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd8.Top := 77 + 51 * 3; //128,
  DMakeMagicAdd8.Left := 163; // 163
  DMakeMagicAdd10.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd10.Top := 77 + 51 * 4; //128,
  DMakeMagicAdd10.Left := 163; // 163
{$ELSE}
  DStateGrid.Top := 89 - 37;
  DStateGrid.Left := 29 - 8;
  DStateGrid.Width := 155;
  DStateGrid.Height := 242;

  DMagicFront.SetImgIndex(g_WMain99Images, 147);
  DMagicFront.Top := 349 - 37;
  DMagicFront.Left := 23 - 8;
  DMagicFront.OnDirectPaint := nil;
  DMagicNext.SetImgIndex(g_WMain99Images, 147);
  DMagicNext.Top := 349 - 37;
  DMagicNext.Left := 117 - 8;
  DMagicNext.OnDirectPaint := nil;
  DMagicCBOSetup.SetImgIndex(g_WMain99Images, 330);
  DMagicCBOSetup.Top := 312;
  DMagicCBOSetup.Left := 190;

  DMagicBase.SetImgIndex(g_WMain99Images, 210);
  DMagicBase.Top := 44 - 37;
  DMagicBase.Left := 25 - 8;
  DMagicCbo.SetImgIndex(g_WMain99Images, 210);
  DMagicCbo.Top := 44 - 37;
  DMagicCbo.Left := 105 - 8;
  DMagicSub.SetImgIndex(g_WMain99Images, 210);
  DMagicSub.Top := 44 - 37;
  DMagicSub.Left := 185 - 8;

  DMakeMagicAdd1.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd1.Top := 77; //128,
  DMakeMagicAdd1.Left := 46; // 163
  DMakeMagicAdd3.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd3.Top := 77 + 51; //128,
  DMakeMagicAdd3.Left := 46; // 163
  DMakeMagicAdd5.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd5.Top := 77 + 51 * 2; //128,
  DMakeMagicAdd5.Left := 46; // 163
  DMakeMagicAdd7.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd7.Top := 77 + 51 * 3; //128,
  DMakeMagicAdd7.Left := 46; // 163
  DMakeMagicAdd9.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd9.Top := 77 + 51 * 4; //128,
  DMakeMagicAdd9.Left := 46; // 163

  DMakeMagicAdd2.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd2.Top := 77; //128,
  DMakeMagicAdd2.Left := 163; // 163
  DMakeMagicAdd4.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd4.Top := 77 + 51; //128,
  DMakeMagicAdd4.Left := 163; // 163
  DMakeMagicAdd6.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd6.Top := 77 + 51 * 2; //128,
  DMakeMagicAdd6.Left := 163; // 163
  DMakeMagicAdd8.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd8.Top := 77 + 51 * 3; //128,
  DMakeMagicAdd8.Left := 163; // 163
  DMakeMagicAdd10.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd10.Top := 77 + 51 * 4; //128,
  DMakeMagicAdd10.Left := 163; // 163  
{$IFEND}


  //连击设置
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1771]; //惑怕  370
  if d <> nil then begin
    DStateWinMagicCbo.SetImgIndex(g_WMain99Images, 1771);
    DStateWinMagicCbo.Left := DStateWinMagicCbo.LocalX(DStateWin.Left);
    DStateWinMagicCbo.Top := DStateWinMagicCbo.LocalY(DStateWin.Top + DStateWin.Height);
    {DStateWinMagicCbo.Left := (DStateWinMagic.Width - d.Width) div 2;
    DStateWinMagicCbo.Top := 0;}
    //
  end;

  DStateWinMagicCboClose.SetImgIndex(g_WMain99Images, 1850);
  DStateWinMagicCboClose.Top := 15;
  DStateWinMagicCboClose.Left := 292;

  DStateWinMagicCboICO.Top := 46;
  DStateWinMagicCboICO.Left := 33;
  DStateWinMagicCboICO.Width := 31;
  DStateWinMagicCboICO.Height := 32;

  DStateWinMagicCboGrid.Top := 46;
  DStateWinMagicCboGrid.Left := 102;
  DStateWinMagicCboGrid.Width := 166;
  DStateWinMagicCboGrid.Height := 32;
  DStateWinMagicCboGrid.ColWidth := 31;
  DStateWinMagicCboGrid.ColOffset := 14;

  DStateWinMagicCboOK.SetImgIndex(g_WMain99Images, 1685);
  DStateWinMagicCboOK.Top := 114;
  DStateWinMagicCboOK.Left := 176;
  DStateWinMagicCboOK.OnDirectPaint := DButRenewChrDirectPaint;
  DStateWinMagicCboExit.SetImgIndex(g_WMain99Images, 1683);
  DStateWinMagicCboExit.Top := 114;
  DStateWinMagicCboExit.Left := 233;
  DStateWinMagicCboExit.OnDirectPaint := DButRenewChrDirectPaint;
{$ELSE}
  d := g_WMain99Images.Images[335]; //惑怕  370
  if d <> nil then begin
    DStateWinMagicCbo.SetImgIndex(g_WMain99Images, 335);
    DStateWinMagicCbo.Left := 276;
    DStateWinMagicCbo.Top := -37;
  end;

  DStateWinMagicCboClose.SetImgIndex(g_WMain99Images, 133);
  DStateWinMagicCboClose.Top := 8 + 4;
  DStateWinMagicCboClose.Left := DStateWinMagicCbo.Width - DStateWinMagicCboClose.Width - 4;

  DStateWinMagicCboICO.Top := 54;
  DStateWinMagicCboICO.Left := 21;
  DStateWinMagicCboICO.Width := 38;
  DStateWinMagicCboICO.Height := 38;

  DStateWinMagicCboGrid.Top := 54;
  DStateWinMagicCboGrid.Left := 102;
  DStateWinMagicCboGrid.Width := 182;
  DStateWinMagicCboGrid.Height := 38;

  DStateWinMagicCboOK.SetImgIndex(g_WMain99Images, 147);
  DStateWinMagicCboOK.Top := 140;
  DStateWinMagicCboOK.Left := 74;
  DStateWinMagicCboExit.SetImgIndex(g_WMain99Images, 147);
  DStateWinMagicCboExit.Top := 140;
  DStateWinMagicCboExit.Left := 182;  
{$IFEND}


  //个人信息
{$IF Var_Interface = Var_Mir2}
  DStateInfoName.Top := 7;
  DStateInfoName.Left := 156;
  DStateInfoName.Width := 63;
  DStateInfoName.Height := 16;
  DStateInfoAge.Top := 28;
  DStateInfoAge.Left := 156;
  DStateInfoAge.Width := 63;
  DStateInfoAge.Height := 16;

  DStateInfoSex.SetImgIndex(g_WMain99Images, 2153);
  DStateInfoSex.Top := 49;
  DStateInfoSex.Left := 156;
  DStateInfoSex.Width := 63;
  DStateInfoSex.Height := 16;
  DStateInfoSex.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoSex.UpDown.Offset := 1;
  DStateInfoSex.UpDown.Normal := True;
  DStateInfoSex.UpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DStateInfoSex.UpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DStateInfoSex.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DStateInfoProvince.SetImgIndex(g_WMain99Images, 2153);
  DStateInfoProvince.ImageWidth := DStateInfoProvince.Width;
  DStateInfoProvince.Top := 70;
  DStateInfoProvince.Left := 156;
  DStateInfoProvince.Width := 96;
  DStateInfoProvince.Height := 16;
  DStateInfoProvince.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoProvince.UpDown.Offset := 1;
  DStateInfoProvince.UpDown.Normal := True;
  DStateInfoProvince.UpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DStateInfoProvince.UpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DStateInfoProvince.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DStateInfoCity.SetImgIndex(g_WMain99Images, 2153);
  DStateInfoCity.ImageWidth := DStateInfoCity.Width;
  DStateInfoCity.Top := 91;
  DStateInfoCity.Left := 156;
  DStateInfoCity.Width := 96;
  DStateInfoCity.Height := 16;
  DStateInfoCity.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoCity.UpDown.Offset := 1;
  DStateInfoCity.UpDown.Normal := True;
  DStateInfoCity.UpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DStateInfoCity.UpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DStateInfoCity.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DStateInfoArea.SetImgIndex(g_WMain99Images, 2153);
  DStateInfoArea.ImageWidth := DStateInfoArea.Width;
  DStateInfoArea.Top := 112;
  DStateInfoArea.Left := 156;
  DStateInfoArea.Width := 96;
  DStateInfoArea.Height := 16;
  DStateInfoArea.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoArea.UpDown.Offset := 1;
  DStateInfoArea.UpDown.Normal := True;
  DStateInfoArea.UpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DStateInfoArea.UpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DStateInfoArea.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DStateInfoAM.SetImgIndex(g_WMain99Images, 151);
  DStateInfoAM.Left := 175 - 20;
  DStateInfoAM.Top := 202 - 69;
  DStateInfoPM.SetImgIndex(g_WMain99Images, 151);
  DStateInfoPM.Left := 222 - 20;
  DStateInfoPM.Top := 202 - 69;
  DStateInfoNight.SetImgIndex(g_WMain99Images, 151);
  DStateInfoNight.Left := 175 - 20;
  DStateInfoNight.Top := 222 - 70;
  DStateInfoMidNight.SetImgIndex(g_WMain99Images, 151);
  DStateInfoMidNight.Left := 222 - 20;
  DStateInfoMidNight.Top := 222 - 70;
  
  DStateInfoFriend.SetImgIndex(g_WMain99Images, 151);
  DStateInfoFriend.Left := 14;
  DStateInfoFriend.Top := 235;

  DStateInfoRefPic.SetImgIndex(g_WMain99Images, 1794);
  DStateInfoRefPic.Left := 34;
  DStateInfoRefPic.Top := 132;
  DStateInfoUpLoadPic.SetImgIndex(g_WMain99Images, 1797);
  DStateInfoUpLoadPic.Left := 34;
  DStateInfoUpLoadPic.Top := 150;
  DStateInfoUpLoadPic.OnDirectPaint := DStateInfoRefPicDirectPaint;

  DStateInfoSave.SetImgIndex(g_WMain99Images, 1803);
  DStateInfoSave.Left := 163;
  DStateInfoSave.Top := 235;
  DStateInfoSave.OnDirectPaint := DButRenewChrDirectPaint;
  DStateInfoExit.SetImgIndex(g_WMain99Images, 1683);
  DStateInfoExit.Left := 209;
  DStateInfoExit.Top := 235;
  DStateInfoExit.OnDirectPaint := DButRenewChrDirectPaint;

  DStateInfoMemo.Left := 16;
  DStateInfoMemo.Top := 172;
  DStateInfoMemo.Width := 228;
  DStateInfoMemo.Height := 58;
{$ELSE}
  DStateInfoName.Top := 75 - 37;
  DStateInfoName.Left := 175 - 8;
  DStateInfoName.Width := 62;
  DStateInfoName.Height := 16;
  DStateInfoAge.Top := 96 - 37;
  DStateInfoAge.Left := 175 - 8;
  DStateInfoAge.Width := 62;
  DStateInfoAge.Height := 16;

  DStateInfoSex.SetImgIndex(g_WMain99Images, 309);
  DStateInfoSex.Top := 117 - 37;
  DStateInfoSex.Left := 175 - 8;
  DStateInfoSex.Width := 62;
  DStateInfoSex.Height := 16;
  DStateInfoSex.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoSex.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DStateInfoSex.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DStateInfoSex.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);
  DStateInfoProvince.SetImgIndex(g_WMain99Images, 309);
  DStateInfoProvince.ImageWidth := DStateInfoProvince.Width;
  DStateInfoProvince.Top := 138 - 37;
  DStateInfoProvince.Left := 175 - 8;
  DStateInfoProvince.Width := 87;
  DStateInfoProvince.Height := 16;
  DStateInfoProvince.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoProvince.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DStateInfoProvince.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DStateInfoProvince.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);
  DStateInfoCity.SetImgIndex(g_WMain99Images, 309);
  DStateInfoCity.ImageWidth := DStateInfoCity.Width;
  DStateInfoCity.Top := 159 - 37;
  DStateInfoCity.Left := 175 - 8;
  DStateInfoCity.Width := 87;
  DStateInfoCity.Height := 16;
  DStateInfoCity.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoCity.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DStateInfoCity.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DStateInfoCity.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);
  DStateInfoArea.SetImgIndex(g_WMain99Images, 309);
  DStateInfoArea.ImageWidth := DStateInfoArea.Width;
  DStateInfoArea.Top := 180 - 37;
  DStateInfoArea.Left := 175 - 8;
  DStateInfoArea.Width := 87;
  DStateInfoArea.Height := 16;
  DStateInfoArea.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoArea.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DStateInfoArea.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DStateInfoArea.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DStateInfoAM.SetImgIndex(g_WMain99Images, 151);
  DStateInfoAM.Left := 175 - 8;
  DStateInfoAM.Top := 202 - 37;
  DStateInfoPM.SetImgIndex(g_WMain99Images, 151);
  DStateInfoPM.Left := 222 - 8;
  DStateInfoPM.Top := 202 - 37;
  DStateInfoNight.SetImgIndex(g_WMain99Images, 151);
  DStateInfoNight.Left := 175 - 8;
  DStateInfoNight.Top := 222 - 37;
  DStateInfoMidNight.SetImgIndex(g_WMain99Images, 151);
  DStateInfoMidNight.Left := 222 - 8;
  DStateInfoMidNight.Top := 222 - 37;
  DStateInfoFriend.SetImgIndex(g_WMain99Images, 151);
  DStateInfoFriend.Left := 30 - 8;
  DStateInfoFriend.Top := 351 - 37;

  DStateInfoRefPic.SetImgIndex(g_WMain99Images, 330);
  DStateInfoRefPic.Left := 42 - 8;
  DStateInfoRefPic.Top := 200 - 37;
  DStateInfoRefPic.OnDirectPaint := nil;
  DStateInfoUpLoadPic.SetImgIndex(g_WMain99Images, 330);
  DStateInfoUpLoadPic.Left := 42 - 8;
  DStateInfoUpLoadPic.Top := 221 - 37;
  DStateInfoSave.SetImgIndex(g_WMain99Images, 147);
  DStateInfoSave.Left := 151 - 8;
  DStateInfoSave.Top := 349 - 37;
  DStateInfoExit.SetImgIndex(g_WMain99Images, 147);
  DStateInfoExit.Left := 214 - 8;
  DStateInfoExit.Top := 349 - 37;

  DStateInfoMemo.Left := 33 - 8;
  DStateInfoMemo.Top := 277 - 37;
  DStateInfoMemo.Width := 234;
  DStateInfoMemo.Height := 58;  
{$IFEND}


  //坐骑信息
{$IF Var_Interface = Var_Mir2}
  DHorseRein.Left := 22;
  DHorseRein.Top := 170;
  DHorseRein.Width := 34;
  DHorseRein.Height := 30;
  DHorseBell.Left := 67;
  DHorseBell.Top := 170;
  DHorseBell.Width := 34;
  DHorseBell.Height := 30;
  DHorseSaddle.Left := 112;
  DHorseSaddle.Top := 170;
  DHorseSaddle.Width := 34;
  DHorseSaddle.Height := 30;
  DHorseDecoration.Left := 157;
  DHorseDecoration.Top := 170;
  DHorseDecoration.Width := 34;
  DHorseDecoration.Height := 30;
  DHorseNail.Left := 202;
  DHorseNail.Top := 170;
  DHorseNail.Width := 34;
  DHorseNail.Height := 30;
{$ELSE}
  DHorseRein.Left := 20;
  DHorseRein.Top := 227;
  DHorseRein.Width := 36;
  DHorseRein.Height := 32;
  DHorseBell.Left := 69;
  DHorseBell.Top := 227;
  DHorseBell.Width := 36;
  DHorseBell.Height := 32;
  DHorseSaddle.Left := 117;
  DHorseSaddle.Top := 227;
  DHorseSaddle.Width := 36;
  DHorseSaddle.Height := 32;
  DHorseDecoration.Left := 165;
  DHorseDecoration.Top := 227;
  DHorseDecoration.Width := 36;
  DHorseDecoration.Height := 32;
  DHorseNail.Left := 214;
  DHorseNail.Top := 227;
  DHorseNail.Width := 36;
  DHorseNail.Height := 32;  
{$IFEND}


  //人物状态窗口(查看别人信息)
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1770]; //惑怕  370
  if d <> nil then begin
    DUserState.SetImgIndex(g_WMain99Images, 1770);
    DUserState.Left := 357;
    DUserState.Top := 53;
  end;

  DCloseUserState.SetImgIndex(g_WMain99Images, 1850);
  DCloseUserState.Top := 34;
  DCloseUserState.Left := 259;

  DUserStateItem.Left := 16;
  DUserStateItem.Top := 90;
  DUserStateItem.Width := 259;
  DUserStateItem.Height := 255;
  DUserStateInfo.Left := 16;
  DUserStateInfo.Top := 90;
  DUserStateInfo.Width := 259;
  DUserStateInfo.Height := 255;
  DUserStateHorse.Left := 16;
  DUserStateHorse.Top := 90;
  DUserStateHorse.Width := 259;
  DUserStateHorse.Height := 255;

  DUserStateBTItem.SetImgIndex(g_WMain99Images, 1782);
  DUserStateBTItem.Top := 63;
  DUserStateBTItem.Left := 16;
{$IF Var_Free = 1}
  DUserStateBTHorse.Visible := False;
  DUserStateBTInfo.SetImgIndex(g_WMain99Images, 1792);
  DUserStateBTInfo.Top := 63;
  DUserStateBTInfo.Left := 58;
{$ELSE}
  DUserStateBTHorse.SetImgIndex(g_WMain99Images, 1790);
  DUserStateBTHorse.Top := 63;
  DUserStateBTHorse.Left := 58;
  DUserStateBTInfo.SetImgIndex(g_WMain99Images, 1792);
  DUserStateBTInfo.Top := 63;
  DUserStateBTInfo.Left := 102;
{$IFEND}

{$ELSE}
  d := g_WMain99Images.Images[235]; //惑怕  370
  if d <> nil then begin
    DUserState.SetImgIndex(g_WMain99Images, 235);
    DUserState.Left := 357;
    DUserState.Top := 53;
  end;
  DCloseUserState.SetImgIndex(g_WMain99Images, 133);
  DCloseUserState.Top := 8 + 4;
  DCloseUserState.Left := DUserState.Width - DCloseUserState.Width - 4;
  DUserStateItem.Left := 8;
  DUserStateItem.Top := 37;
  DUserStateItem.Width := 268;
  DUserStateItem.Height := 338;
  DUserStateInfo.Left := 8;
  DUserStateInfo.Top := 37;
  DUserStateInfo.Width := 268;
  DUserStateInfo.Height := 338;
  DUserStateHorse.Left := 8;
  DUserStateHorse.Top := 37;
  DUserStateHorse.Width := 268;
  DUserStateHorse.Height := 338;



  DUserStateBTItem.SetImgIndex(g_WMain99Images, 240);
  DUserStateBTItem.Top := 377;
  DUserStateBTItem.Left := 16;
{$IF Var_Free = 1}
  DUserStateBTHorse.Visible := False;
  DUserStateBTInfo.SetImgIndex(g_WMain99Images, 240);
  DUserStateBTInfo.Top := 377;
  DUserStateBTInfo.Left := 79;
{$ELSE}
  DUserStateBTHorse.SetImgIndex(g_WMain99Images, 240);
  DUserStateBTHorse.Top := 377;
  DUserStateBTHorse.Left := 79;
  DUserStateBTInfo.SetImgIndex(g_WMain99Images, 240);
  DUserStateBTInfo.Top := 377;
  DUserStateBTInfo.Left := 142;
{$IFEND}  
{$IFEND}

{$IF Var_Interface = Var_Mir2}
  DUSHorseRein.Left := 22;
  DUSHorseRein.Top := 170;
  DUSHorseRein.Width := 34;
  DUSHorseRein.Height := 30;
  DUSHorseBell.Left := 67;
  DUSHorseBell.Top := 170;
  DUSHorseBell.Width := 34;
  DUSHorseBell.Height := 30;
  DUSHorseSaddle.Left := 112;
  DUSHorseSaddle.Top := 170;
  DUSHorseSaddle.Width := 34;
  DUSHorseSaddle.Height := 30;
  DUSHorseDecoration.Left := 157;
  DUSHorseDecoration.Top := 170;
  DUSHorseDecoration.Width := 34;
  DUSHorseDecoration.Height := 30;
  DUSHorseNail.Left := 202;
  DUSHorseNail.Top := 170;
  DUSHorseNail.Width := 34;
  DUSHorseNail.Height := 30;
{$ELSE}
  DUSHorseRein.Left := 20;
  DUSHorseRein.Top := 227;
  DUSHorseRein.Width := 36;
  DUSHorseRein.Height := 32;
  DUSHorseBell.Left := 69;
  DUSHorseBell.Top := 227;
  DUSHorseBell.Width := 36;
  DUSHorseBell.Height := 32;
  DUSHorseSaddle.Left := 117;
  DUSHorseSaddle.Top := 227;
  DUSHorseSaddle.Width := 36;
  DUSHorseSaddle.Height := 32;
  DUSHorseDecoration.Left := 165;
  DUSHorseDecoration.Top := 227;
  DUSHorseDecoration.Width := 36;
  DUSHorseDecoration.Height := 32;
  DUSHorseNail.Left := 214;
  DUSHorseNail.Top := 227;
  DUSHorseNail.Width := 36;
  DUSHorseNail.Height := 32;  
{$IFEND}




  //人物装备

{$IF Var_Interface = Var_Mir2}
  nx := 5;
  ny := 64;
  DWeaponUS1.Left := nx;
  DWeaponUS1.Top := ny;
  DWeaponUS1.Width := 34;
  DWeaponUS1.Height := 30;
  DDressUS1.Left := nx;
  DDressUS1.Top := ny + 1 * 39;
  DDressUS1.Width := 34;
  DDressUS1.Height := 30;
  DArmRingRUS1.Left := nx;
  DArmRingRUS1.Top := ny + 2 * 39;
  DArmRingRUS1.Width := 34;
  DArmRingRUS1.Height := 30;
  DRingRUS1.Left := nx;
  DRingRUS1.Top := ny + 3 * 39;
  DRingRUS1.Width := 34;
  DRingRUS1.Height := 30;
  DBeltUS1.Left := nx;
  DBeltUS1.Top := ny + 4 * 39;
  DBeltUS1.Width := 34;
  DBeltUS1.Height := 30;

  //nx := 372;
  //ny := 125;
  nx := 220;
  ny := 25;
  DHelmetUS1.Left := nx;
  DHelmetUS1.Top := ny;
  DHelmetUS1.Width := 34;
  DHelmetUS1.Height := 30;
  DNecklaceUS1.Left := nx;
  DNecklaceUS1.Top := ny + 1 * 39;
  DNecklaceUS1.Width := 34;
  DNecklaceUS1.Height := 30;
  DLightUS1.Left := nx;
  DLightUS1.Top := ny + 2 * 39;
  DLightUS1.Width := 34;
  DLightUS1.Height := 30;
  DArmRingLUS1.Left := nx;
  DArmRingLUS1.Top := ny + 3 * 39;
  DArmRingLUS1.Width := 34;
  DArmRingLUS1.Height := 30;
  DRingLUS1.Left := nx;
  DRingLUS1.Top := ny + 4 * 39;
  DRingLUS1.Width := 34;
  DRingLUS1.Height := 30;
  DBootsUS1.Left := nx;
  DBootsUS1.Top := ny + 5 * 39;
  DBootsUS1.Width := 34;
  DBootsUS1.Height := 30;

  //nx := 200;
  //ny := 300;
  nx := 48;
  ny := 220;
  DBujukUS1.Left := nx;
  DBujukUS1.Top := ny;
  DBujukUS1.Width := 34;
  DBujukUS1.Height := 30;
  DHouseUS1.Left := nx + 1 * 43;
  DHouseUS1.Top := ny;
  DHouseUS1.Width := 34;
  DHouseUS1.Height := 30;
  DCharmUS1.Left := nx + 2 * 43;
  DCharmUS1.Top := ny;
  DCharmUS1.Width := 34;
  DCharmUS1.Height := 30;
  DCowryUS1.Left := nx + 3 * 43;
  DCowryUS1.Top := ny;
  DCowryUS1.Width := 34;
  DCowryUS1.Height := 30;
{$ELSE}
  nx := 9;
  ny := 101;
  DWeaponUS1.Left := nx;
  DWeaponUS1.Top := ny;
  DWeaponUS1.Width := 36;
  DWeaponUS1.Height := 32;
  DDressUS1.Left := nx;
  DDressUS1.Top := ny + 1 * 35;
  DDressUS1.Width := 36;
  DDressUS1.Height := 32;
  DArmRingRUS1.Left := nx;
  DArmRingRUS1.Top := ny + 2 * 35;
  DArmRingRUS1.Width := 36;
  DArmRingRUS1.Height := 32;
  DRingRUS1.Left := nx;
  DRingRUS1.Top := ny + 3 * 35;
  DRingRUS1.Width := 36;
  DRingRUS1.Height := 32;
  DBeltUS1.Left := nx;
  DBeltUS1.Top := ny + 4 * 35;
  DBeltUS1.Width := 36;
  DBeltUS1.Height := 32;

  //nx := 372;
  //ny := 125;
  nx := 224;
  ny := 66;
  DHelmetUS1.Left := nx;
  DHelmetUS1.Top := ny;
  DHelmetUS1.Width := 36;
  DHelmetUS1.Height := 32;
  DNecklaceUS1.Left := nx;
  DNecklaceUS1.Top := ny + 1 * 35;
  DNecklaceUS1.Width := 36;
  DNecklaceUS1.Height := 32;
  DLightUS1.Left := nx;
  DLightUS1.Top := ny + 2 * 35;
  DLightUS1.Width := 36;
  DLightUS1.Height := 32;
  DArmRingLUS1.Left := nx;
  DArmRingLUS1.Top := ny + 3 * 35;
  DArmRingLUS1.Width := 36;
  DArmRingLUS1.Height := 32;
  DRingLUS1.Left := nx;
  DRingLUS1.Top := ny + 4 * 35;
  DRingLUS1.Width := 36;
  DRingLUS1.Height := 32;
  DBootsUS1.Left := nx;
  DBootsUS1.Top := ny + 5 * 35;
  DBootsUS1.Width := 36;
  DBootsUS1.Height := 32;

  //nx := 200;
  //ny := 300;
  nx := 52;
  ny := 241;
  DBujukUS1.Left := nx;
  DBujukUS1.Top := ny;
  DBujukUS1.Width := 36;
  DBujukUS1.Height := 32;
  DHouseUS1.Left := nx + 1 * 43;
  DHouseUS1.Top := ny;
  DHouseUS1.Width := 36;
  DHouseUS1.Height := 32;
  DCharmUS1.Left := nx + 2 * 43;
  DCharmUS1.Top := ny;
  DCharmUS1.Width := 36;
  DCharmUS1.Height := 32;
  DCowryUS1.Left := nx + 3 * 43;
  DCowryUS1.Top := ny;
  DCowryUS1.Width := 36;
  DCowryUS1.Height := 32;  
{$IFEND}


  //个人信息
{$IF Var_Interface = Var_Mir2}
  DUserStateInfoName.Top := 7;
  DUserStateInfoName.Left := 156;
  DUserStateInfoName.Width := 63;
  DUserStateInfoName.Height := 16;
  DUserStateInfoAge.Top := 28;
  DUserStateInfoAge.Left := 156;
  DUserStateInfoAge.Width := 63;
  DUserStateInfoAge.Height := 16;


  DUserStateInfoSex.Top := 49;
  DUserStateInfoSex.Left := 156;
  DUserStateInfoSex.Width := 63;
  DUserStateInfoSex.Height := 16;



  DUserStateInfoProvince.Top := 70;
  DUserStateInfoProvince.Left := 156;
  DUserStateInfoProvince.Width := 96;
  DUserStateInfoProvince.Height := 16;

  DUserStateInfoCity.Top := 91;
  DUserStateInfoCity.Left := 156;
  DUserStateInfoCity.Width := 96;
  DUserStateInfoCity.Height := 16;

  DUserStateInfoArea.Top := 112;
  DUserStateInfoArea.Left := 156;
  DUserStateInfoArea.Width := 96;
  DUserStateInfoArea.Height := 16;


  DUserStateInfoAM.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoAM.Left := 175 - 20;
  DUserStateInfoAM.Top := 202 - 69;
  DUserStateInfoPM.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoPM.Left := 222 - 20;
  DUserStateInfoPM.Top := 202 - 69;
  DUserStateInfoNight.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoNight.Left := 175 - 20;
  DUserStateInfoNight.Top := 222 - 70;
  DUserStateInfoMidNight.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoMidNight.Left := 222 - 20;
  DUserStateInfoMidNight.Top := 222 - 70;
  
  DUserStateInfoFriend.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoFriend.Left := 14;
  DUserStateInfoFriend.Top := 235;

  DUserStateInfoRefPic.SetImgIndex(g_WMain99Images, 1794);
  DUserStateInfoRefPic.Left := 34;
  DUserStateInfoRefPic.Top := 132;
  DUserStateInfoRefPic.OnDirectPaint := DStateInfoRefPicDirectPaint;
  DUserStateInforeport.SetImgIndex(g_WMain99Images, 1800);
  DUserStateInforeport.Left := 34;
  DUserStateInforeport.Top := 150;
  DUserStateInforeport.OnDirectPaint := DStateInfoRefPicDirectPaint;

  DUserStateInfoMemo.Left := 16;
  DUserStateInfoMemo.Top := 172;
  DUserStateInfoMemo.Width := 228;
  DUserStateInfoMemo.Height := 58;
{$ELSE}
   DUserStateInfoName.Top := 75 - 37;
  DUserStateInfoName.Left := 175 - 8;
  DUserStateInfoName.Width := 62;
  DUserStateInfoName.Height := 16;
  DUserStateInfoAge.Top := 96 - 37;
  DUserStateInfoAge.Left := 175 - 8;
  DUserStateInfoAge.Width := 62;
  DUserStateInfoAge.Height := 16;

  DUserStateInfoSex.Top := 117 - 37;
  DUserStateInfoSex.Left := 175 - 8;
  DUserStateInfoSex.Width := 62;
  DUserStateInfoSex.Height := 16;

  DUserStateInfoProvince.Top := 138 - 37;
  DUserStateInfoProvince.Left := 175 - 8;
  DUserStateInfoProvince.Width := 87;
  DUserStateInfoProvince.Height := 16;

  DUserStateInfoCity.Top := 159 - 37;
  DUserStateInfoCity.Left := 175 - 8;
  DUserStateInfoCity.Width := 87;
  DUserStateInfoCity.Height := 16;

  DUserStateInfoArea.Top := 180 - 37;
  DUserStateInfoArea.Left := 175 - 8;
  DUserStateInfoArea.Width := 87;
  DUserStateInfoArea.Height := 16;

  DUserStateInfoAM.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoAM.Left := 175 - 8;
  DUserStateInfoAM.Top := 202 - 37;
  DUserStateInfoPM.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoPM.Left := 222 - 8;
  DUserStateInfoPM.Top := 202 - 37;
  DUserStateInfoNight.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoNight.Left := 175 - 8;
  DUserStateInfoNight.Top := 222 - 37;
  DUserStateInfoMidNight.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoMidNight.Left := 222 - 8;
  DUserStateInfoMidNight.Top := 222 - 37;
  DUserStateInfoFriend.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoFriend.Left := 30 - 8;
  DUserStateInfoFriend.Top := 351 - 37;

  DUserStateInfoRefPic.SetImgIndex(g_WMain99Images, 330);
  DUserStateInfoRefPic.Left := 42 - 8;
  DUserStateInfoRefPic.Top := 200 - 37;
  DUserStateInforeport.SetImgIndex(g_WMain99Images, 330);
  DUserStateInforeport.Left := 42 - 8;
  DUserStateInforeport.Top := 221 - 37;

  DUserStateInfoMemo.Left := 33 - 8;
  DUserStateInfoMemo.Top := 277 - 37;
  DUserStateInfoMemo.Width := 234;
  DUserStateInfoMemo.Height := 58; 
{$IFEND}


  {d := g_WMain99Images.Images[238]; //惑怕  370
  if d <> nil then begin
    DUserState1.SetImgIndex(g_WMain99Images, 238);
    DUserState1.Left := 50;
    DUserState1.Top := 74;
  end;

  DCloseUS1.SetImgIndex(g_WMain99Images, 133);
  DCloseUS1.Top := 8;
  DCloseUS1.Left := DUserState1.Width - DCloseUS1.Width - 4;

  nx := 17;
  ny := 160;
  DWeaponUS1.Left := nx;
  DWeaponUS1.Top := ny;
  DWeaponUS1.Width := 36;
  DWeaponUS1.Height := 32;
  DDressUS1.Left := nx;
  DDressUS1.Top := ny + 1 * 35;
  DDressUS1.Width := 36;
  DDressUS1.Height := 32;
  DArmRingRUS1.Left := nx;
  DArmRingRUS1.Top := ny + 2 * 35;
  DArmRingRUS1.Width := 36;
  DArmRingRUS1.Height := 32;
  DRingRUS1.Left := nx;
  DRingRUS1.Top := ny + 3 * 35;
  DRingRUS1.Width := 36;
  DRingRUS1.Height := 32;
  DBeltUS1.Left := nx;
  DBeltUS1.Top := ny + 4 * 35;
  DBeltUS1.Width := 36;
  DBeltUS1.Height := 32;

  nx := 232;
  ny := 125;
  DHelmetUS1.Left := nx;
  DHelmetUS1.Top := ny;
  DHelmetUS1.Width := 36;
  DHelmetUS1.Height := 32;
  DNecklaceUS1.Left := nx;
  DNecklaceUS1.Top := ny + 1 * 35;
  DNecklaceUS1.Width := 36;
  DNecklaceUS1.Height := 32;
  DLightUS1.Left := nx;
  DLightUS1.Top := ny + 2 * 35;
  DLightUS1.Width := 36;
  DLightUS1.Height := 32;
  DArmRingLUS1.Left := nx;
  DArmRingLUS1.Top := ny + 3 * 35;
  DArmRingLUS1.Width := 36;
  DArmRingLUS1.Height := 32;
  DRingLUS1.Left := nx;
  DRingLUS1.Top := ny + 4 * 35;
  DRingLUS1.Width := 36;
  DRingLUS1.Height := 32;
  DBootsUS1.Left := nx;
  DBootsUS1.Top := ny + 5 * 35;
  DBootsUS1.Width := 36;
  DBootsUS1.Height := 32;

  nx := 60;
  ny := 300;
  DBujukUS1.Left := nx;
  DBujukUS1.Top := ny;
  DBujukUS1.Width := 36;
  DBujukUS1.Height := 32;
  DHouseUS1.Left := nx + 1 * 43;
  DHouseUS1.Top := ny;
  DHouseUS1.Width := 36;
  DHouseUS1.Height := 32;
  DCharmUS1.Left := nx + 2 * 43;
  DCharmUS1.Top := ny;
  DCharmUS1.Width := 36;
  DCharmUS1.Height := 32;
  DCowryUS1.Left := nx + 3 * 43;
  DCowryUS1.Top := ny;
  DCowryUS1.Width := 36;
  DCowryUS1.Height := 32;    }

  //商人对话框
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1933];
  if d <> nil then begin
    DMerchantDlg.SetImgIndex(g_WMain99Images, 1933);
    DMerchantDlg.Left := 0;
    DMerchantDlg.Top := 0;
  end;

  DMerchantDlgClose.SetImgIndex(g_WMain99Images, 1850);
  DMerchantDlgClose.Left := 399;
  DMerchantDlgClose.Top := 1;

  DMDlgUpDonw.SetImgIndex(g_WMain99Images, 120);
  DMDlgUpDonw.Top := 8;
  DMDlgUpDonw.Left := 377;
  DMDlgUpDonw.Height := 158;
  DMDlgUpDonw.Offset := 1;
  DMDlgUpDonw.Normal := True;

  DMDlgUpDonw.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DMDlgUpDonw.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DMDlgUpDonw.MoveButton.SetImgIndex(g_WMain99Images, 2144); //114
{$ELSE}
  d := g_WMain99Images.Images[136];
  if d <> nil then begin
    DMerchantDlg.Left := 0;
    DMerchantDlg.Top := 74;
    DMerchantDlg.SetImgIndex(g_WMain99Images, 136);
  end;

  DMerchantDlgClose.SetImgIndex(g_WMain99Images, 133);
  DMerchantDlgClose.Left := 275;
  DMerchantDlgClose.Top := 9;

  DMDlgUpDonw.SetImgIndex(g_WMain99Images, 120);
  DMDlgUpDonw.Top := 24;
  DMDlgUpDonw.Left := 275;
  DMDlgUpDonw.Height := 311;

  DMDlgUpDonw.UpButton.SetImgIndex(g_WMain99Images, 108);
  DMDlgUpDonw.DownButton.SetImgIndex(g_WMain99Images, 111);
  DMDlgUpDonw.MoveButton.SetImgIndex(g_WMain99Images, 315); //114
{$IFEND}


  //菜单对话框
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1736];
  if d <> nil then begin
    DMenuDlg.SetImgIndex(g_WMain99Images, 1736);
    DMenuDlg.Left := 32;
    DMenuDlg.Top := 74;
  end;
  DMenuClose.SetImgIndex(g_WMain99Images, 1850);
  DMenuClose.Left := 210;
  DMenuClose.Top := 0;

  DMenuGrid.Top := 50;
  DMenuGrid.Left := 27;
  DMenuGrid.Width := 141;
  DMenuGrid.Height := 158;
  DMenuGrid.ColWidth := 33;
  DMenuGrid.Coloffset := 3;
  DMenuGrid.ColCount := 4;
  DMenuGrid.RowHeight := 30;
  DMenuGrid.Rowoffset := 2;
  DMenuGrid.RowCount := 5;

  DMenuUpDonw.SetImgIndex(g_WMain99Images, 120);
  DMenuUpDonw.Top := 44;
  DMenuUpDonw.Left := 175;
  DMenuUpDonw.Height := 170;
  DMenuUpDonw.Offset := 1;
  DMenuUpDonw.Normal := True;

  DMenuUpDonw.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DMenuUpDonw.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DMenuUpDonw.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DMenuShop.SetImgIndex(g_WMain99Images, 1735);
  DMenuShop.Left := 22;
  DMenuShop.Top := 20;
  DMenuReturn.SetImgIndex(g_WMain99Images, 1734);
  DMenuReturn.Left := 80;
  DMenuReturn.Top := 20;

  DMenuBuy.SetImgIndex(g_WMain99Images, 1652);
  DMenuBuy.Left := 15;
  DMenuBuy.Top := 224;
  DMenuBuy.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuBuy.DFColor := $ADD6EF;
  DMenuSell.SetImgIndex(g_WMain99Images, 1652);
  DMenuSell.Left := 15;
  DMenuSell.Top := 252;
  DMenuSell.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuSell.DFColor := $ADD6EF;

  DMenuRepair.SetImgIndex(g_WMain99Images, 1652);
  DMenuRepair.Left := 79;
  DMenuRepair.Top := 224;
  DMenuRepair.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuRepair.DFColor := $ADD6EF;
  DMenuRepairAll.SetImgIndex(g_WMain99Images, 1652);
  DMenuRepairAll.Left := 79;
  DMenuRepairAll.Top := 252;
  DMenuRepairAll.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuRepairAll.DFColor := $ADD6EF;

  DMenuSuperRepair.SetImgIndex(g_WMain99Images, 1652);
  DMenuSuperRepair.Left := 142;
  DMenuSuperRepair.Top := 224;
  DMenuSuperRepair.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuSuperRepair.DFColor := $ADD6EF;
  DMenuSuperRepairAll.SetImgIndex(g_WMain99Images, 1652);
  DMenuSuperRepairAll.Left := 142;
  DMenuSuperRepairAll.Top := 252;
  DMenuSuperRepairAll.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuSuperRepairAll.DFColor := $ADD6EF;
{$ELSE}
  d := g_WMain99Images.Images[337];
  if d <> nil then begin
    DMenuDlg.SetImgIndex(g_WMain99Images, 337);
    DMenuDlg.Left := 32;
    DMenuDlg.Top := 74;
  end;
  DMenuClose.SetImgIndex(g_WMain99Images, 133);
  DMenuClose.Left := DMenuDlg.Width - 20;
  DMenuClose.Top := 8 + 4;

  DMenuGrid.Top := 72;
  DMenuGrid.Left := 23;
  DMenuGrid.Width := 174;
  DMenuGrid.Height := 209;

  DMenuUpDonw.SetImgIndex(g_WMain99Images, 120);
  DMenuUpDonw.Top := 64;
  DMenuUpDonw.Left := 209;
  DMenuUpDonw.Height := 225;

  DMenuUpDonw.UpButton.SetImgIndex(g_WMain99Images, 108);
  DMenuUpDonw.DownButton.SetImgIndex(g_WMain99Images, 111);
  DMenuUpDonw.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DMenuShop.SetImgIndex(g_WMain99Images, 219);
  DMenuShop.Left := 21;
  DMenuShop.Top := 38;
  DMenuReturn.SetImgIndex(g_WMain99Images, 219);
  DMenuReturn.Left := 75;
  DMenuReturn.Top := 38;

  DMenuBuy.SetImgIndex(g_WMain99Images, 147);
  DMenuBuy.Left := 19;
  DMenuBuy.Top := 297;
  DMenuSell.SetImgIndex(g_WMain99Images, 147);
  DMenuSell.Left := 19;
  DMenuSell.Top := 318;

  DMenuRepair.SetImgIndex(g_WMain99Images, 147);
  DMenuRepair.Left := 120;
  DMenuRepair.Top := 297;
  DMenuRepairAll.SetImgIndex(g_WMain99Images, 147);
  DMenuRepairAll.Left := 120;
  DMenuRepairAll.Top := 318;

  DMenuSuperRepair.SetImgIndex(g_WMain99Images, 147);
  DMenuSuperRepair.Left := 175;
  DMenuSuperRepair.Top := 297;
  DMenuSuperRepairAll.SetImgIndex(g_WMain99Images, 147);
  DMenuSuperRepairAll.Left := 175;
  DMenuSuperRepairAll.Top := 318;
{$IFEND}


  //购买数量
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1737];
  if d <> nil then begin
    DWndBuy.SetImgIndex(g_WMain99Images, 1737);
    DWndBuy.Left := 308;
    DWndBuy.Top := 101;
  end;

  DBuyOK.SetImgIndex(g_WMain99Images, 1652);
  DBuyOK.Left := 19;
  DBuyOK.Top := 117;
  DBuyOK.OnDirectPaint := DBTHintCloseDirectPaint;
  DBuyOK.DFColor := $ADD6EF;
  DBuyClose.SetImgIndex(g_WMain99Images, 1652);
  DBuyClose.Left := 83;
  DBuyClose.Top := 117;
  DBuyClose.OnDirectPaint := DBTHintCloseDirectPaint;
  DBuyClose.DFColor := $ADD6EF;
  DBuyAdd.SetImgIndex(g_WMain99Images, 1851);
  DBuyAdd.Left := 106;
  DBuyAdd.Top := 67;
  DBuyDel.SetImgIndex(g_WMain99Images, 1852);
  DBuyDel.Left := 122;
  DBuyDel.Top := 67;

  DBuyEdit.Left := 52;
  DBuyEdit.Top := 68;
  DBuyEdit.Width := 52;
  DBuyEdit.Height := 16; 
{$ELSE}
  d := g_WMain99Images.Images[23];
  if d <> nil then begin
    DWndBuy.SetImgIndex(g_WMain99Images, 23);
    DWndBuy.Left := 308;
    DWndBuy.Top := 101;
  end;

  DBuyOK.SetImgIndex(g_WMain99Images, 147);
  DBuyOK.Left := 42;
  DBuyOK.Top := 95;
  DBuyClose.SetImgIndex(g_WMain99Images, 147);
  DBuyClose.Left := 114;
  DBuyClose.Top := 95;
  DBuyAdd.SetImgIndex(g_WMain99Images, 21);
  DBuyAdd.Left := 163;
  DBuyAdd.Top := 52;
  DBuyDel.SetImgIndex(g_WMain99Images, 22);
  DBuyDel.Left := 181;
  DBuyDel.Top := 52;

  DBuyEdit.Left := 44;
  DBuyEdit.Top := 50;
  DBuyEdit.Width := 116;
  DBuyEdit.Height := 16;  
{$IFEND}


  //交易窗口
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1714];
  if d <> nil then begin
    DDealDlg.SetImgIndex(g_WMain99Images, 1714);
    DDealDlg.Left := g_FScreenXOrigin - d.Width div 2;
    DDealDlg.Top := 60;
  end;
  DDealClose.SetImgIndex(g_WMain99Images, 1850);
  DDealClose.Left := 268;
  DDealClose.Top := 0;

  DDGold.Left := 26;
  DDGold.Top := 245;
  DDGold.Width := 116;
  DDGold.Height := 19;

  DDGrid.Left := 28;
  DDGrid.Top := 174;
  DDGrid.Width := 213;
  DDGrid.Height := 62;
  DDGrid.ColWidth := 33;
  DDGrid.RowHeight := 30;
  DDGrid.ColOffset := 3;
  DDGrid.RowOffset := 2;

  DDealOk.SetImgIndex(g_WMain99Images, 1652);
  DDealOk.Left := 160;
  DDealOk.Top := 281;
  DDealOk.OnDirectPaint := DBTHintCloseDirectPaint;
  DDealOk.DFColor := $ADD6EF;
  DDealLock.SetImgIndex(g_WMain99Images, 1652);
  DDealLock.Left := 57;
  DDealLock.Top := 281;
  DDealLock.OnDirectPaint := DBTHintCloseDirectPaint;
  DDealLock.DFColor := $ADD6EF;

  DDRGrid.Left := 23;
  DDRGrid.Top := 71 + 4;
  DDRGrid.Width := 209;
  DDRGrid.Height := 69;

  DDRGrid.Left := 28;
  DDRGrid.Top := 54;
  DDRGrid.Width := 213;
  DDRGrid.Height := 62;
  DDRGrid.ColWidth := 33;
  DDRGrid.RowHeight := 30;
  DDRGrid.ColOffset := 3;
  DDRGrid.RowOffset := 2;

  DDRDealOk.SetImgIndex(g_WMain99Images, 151);
  DDRDealOk.Left := 153;
  DDRDealOk.Top := 128;
  DDRDealLock.SetImgIndex(g_WMain99Images, 151);
  DDRDealLock.Left := 204;
  DDRDealLock.Top := 128;
{$ELSE}
  d := g_WMain99Images.Images[146];
  if d <> nil then begin
    DDealDlg.SetImgIndex(g_WMain99Images, 146);
    DDealDlg.Left := g_FScreenXOrigin - d.Width div 2;
    DDealDlg.Top := 72;
  end;
  DDealClose.SetImgIndex(g_WMain99Images, 133);
  DDealClose.Left := 234;
  DDealClose.Top := 8 + 4;

  DDGold.Left := 24;
  DDGold.Top := 271 + 4;
  DDGold.Width := 102;
  DDGold.Height := 17;

  DDGrid.Left := 23;
  DDGrid.Top := 194 + 4;
  DDGrid.Width := 209;
  DDGrid.Height := 69;

  DDealOk.SetImgIndex(g_WMain99Images, 147);
  DDealOk.Left := 60;
  DDealOk.Top := 307 + 4;
  DDealLock.SetImgIndex(g_WMain99Images, 147);
  DDealLock.Left := 148;
  DDealLock.Top := 307 + 4;

  {DDRGold.Left := 23;
  DDRGold.Top := 148;
  DDRGold.Width := 102;
  DDRGold.Height := 17;    }

  DDRGrid.Left := 23;
  DDRGrid.Top := 71 + 4;
  DDRGrid.Width := 209;
  DDRGrid.Height := 69;

  DDRDealOk.SetImgIndex(g_WMain99Images, 151);
  DDRDealOk.Left := 193;
  DDRDealOk.Top := 149 + 4;
  DDRDealLock.SetImgIndex(g_WMain99Images, 151);
  DDRDealLock.Left := 140;
  DDRDealLock.Top := 149 + 4;  
{$IFEND}


  //队伍窗口
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1656];
  if d <> nil then begin
    DGroupDlg.SetImgIndex(g_WMain99Images, 1656);
    DGroupDlg.Left := g_FScreenXOrigin - d.Width div 2;
    DGroupDlg.Top := g_FScreenHeight - d.Height - 199;
  end;

  DGrpDlgClose.SetImgIndex(g_WMain99Images, 1850);
  DGrpDlgClose.Left := 272;
  DGrpDlgClose.Top := 0;

  DGrpAllowGroup.SetImgIndex(g_WMain99Images, 151);
  DGrpAllowGroup.Left := 25;
  DGrpAllowGroup.Top := 31;
  DGrpCheckGroup.SetImgIndex(g_WMain99Images, 151);
  DGrpCheckGroup.Left := 25;
  DGrpCheckGroup.Top := 49;

  DCBGroupItemDef.SetImgIndex(g_WMain99Images, 153);
  DCBGroupItemDef.Left := 151;
  DCBGroupItemDef.Top := 33;
  DCBGroupItemRam.SetImgIndex(g_WMain99Images, 153);
  DCBGroupItemRam.Left := 151;
  DCBGroupItemRam.Top := 51;

  DGrpCreate.SetImgIndex(g_WMain99Images, 1652);
  DGrpCreate.Left := 62;
  DGrpCreate.Top := 329;
  DGrpCreate.DFColor := $ADD6EF;
  DGrpCreate.OnDirectPaint := DBTHintCloseDirectPaint;
  DGrpAddMem.SetImgIndex(g_WMain99Images, 1652);
  DGrpAddMem.Left := 168;
  DGrpAddMem.Top := 329;
  DGrpAddMem.DFColor := $ADD6EF;
  DGrpAddMem.OnDirectPaint := DBTHintCloseDirectPaint;
  DGrpDelMem.SetImgIndex(g_WMain99Images, 1652);
  DGrpDelMem.Left := 140;
  DGrpDelMem.Top := 161;
  DGrpDelMem.DFColor := $ADD6EF;
  DGrpDelMem.OnDirectPaint := DBTHintCloseDirectPaint;
  DGroupExit.SetImgIndex(g_WMain99Images, 1652);
  DGroupExit.Left := 205;
  DGroupExit.Top := 161;
  DGroupExit.DFColor := $ADD6EF;
  DGroupExit.OnDirectPaint := DBTHintCloseDirectPaint;

  DGroupUpDown.SetImgIndex(g_WMain99Images, 120);
  DGroupUpDown.Top := 210;
  DGroupUpDown.Left := 243;
  DGroupUpDown.Height := 114;
  DGroupUpDown.Offset := 1;
  DGroupUpDown.Normal := True;

  DGroupUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DGroupUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DGroupUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DGrpMemberList.Left := 20;
  DGrpMemberList.Top := 93;
  DGrpMemberList.Width := 238;
  DGrpMemberList.Height := 65;

  DGrpUserList.Left := 20;
  DGrpUserList.Top := 210;
  DGrpUserList.Width := 222;
  DGrpUserList.Height := 114;
{$ELSE}
  d := g_WMain99Images.Images[168];
  if d <> nil then begin
    DGroupDlg.SetImgIndex(g_WMain99Images, 168);
    DGroupDlg.Left := g_FScreenXOrigin - d.Width div 2;
    DGroupDlg.Top := 70;
  end;

  DGrpDlgClose.SetImgIndex(g_WMain99Images, 133);
  DGrpDlgClose.Left := 290;
  DGrpDlgClose.Top := 8 + 4;

  DGrpAllowGroup.SetImgIndex(g_WMain99Images, 151);
  DGrpAllowGroup.Left := 36;
  DGrpAllowGroup.Top := 63 + 4;
  DGrpCheckGroup.SetImgIndex(g_WMain99Images, 151);
  DGrpCheckGroup.Left := 36;
  DGrpCheckGroup.Top := 82 + 4;

  DCBGroupItemDef.SetImgIndex(g_WMain99Images, 153);
  DCBGroupItemDef.Left := 182;
  DCBGroupItemDef.Top := 65 + 4;
  DCBGroupItemRam.SetImgIndex(g_WMain99Images, 153);
  DCBGroupItemRam.Left := 182;
  DCBGroupItemRam.Top := 84 + 4;

  DGrpCreate.SetImgIndex(g_WMain99Images, 147);
  DGrpCreate.Left := 81;
  DGrpCreate.Top := 379 + 4;
  DGrpAddMem.SetImgIndex(g_WMain99Images, 147);
  DGrpAddMem.Left := 183;
  DGrpAddMem.Top := 379 + 4;
  DGrpDelMem.SetImgIndex(g_WMain99Images, 147);
  DGrpDelMem.Left := 170;
  DGrpDelMem.Top := 202 + 4;
  DGroupExit.SetImgIndex(g_WMain99Images, 147);
  DGroupExit.Left := 234;
  DGroupExit.Top := 202 + 4;

  DGroupUpDown.SetImgIndex(g_WMain99Images, 120);
  DGroupUpDown.Top := 245 + 4;
  DGroupUpDown.Left := 276;
  DGroupUpDown.Height := 130;

  DGroupUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DGroupUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DGroupUpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DGrpMemberList.Left := 26;
  DGrpMemberList.Top := 125 + 4;
  DGrpMemberList.Width := 258;
  DGrpMemberList.Height := 65;

  DGrpUserList.Left := 19;
  DGrpUserList.Top := 245 + 4;
  DGrpUserList.Width := 256;
  DGrpUserList.Height := 130;
{$IFEND}


  //弹出框
  DPopUpEdits.SetImgIndex(g_WMain99Images, 276);
  DPopUpSayList.SetImgIndex(g_WMain99Images, 276);
  DPopUpPlay.SetImgIndex(g_WMain99Images, 276);
end;

procedure TFrmDlg.InitializeEx();
{var
  i: integer;   }
begin
  DEditChat.CreateSurface(nil);
  DMinMap128.CreateSurface(nil);
  DMerchantDlg.CreateSurface(nil, False);

  DMiniMap.Left := 0;
  DMiniMap.Top := 0;
  DMiniMap.Width := 192;
  DMiniMap.Height := 160;
  DMiniMap.CreateSurface(nil);

  DMerchantDlg.Surface.Size := Point(DEFMDLGMAXWIDTH, MDLGMAXHEIGHT);
  DMerchantDlg.Surface.PatternSize := Point(DEFMDLGMAXWIDTH, MDLGMAXHEIGHT);
  DMerchantDlg.Surface.Active := True;

  DWudItemShow.Width := 400;
  DWudItemShow.Height := 600;
  DWudItemShow.CreateSurface(nil);
  {
    DMinMap128.SetSurface(DDraw, nil);
    DBottom.SetSurface(DDraw, nil);    MDLGMAXWIDTH = 242;
    MDLGMAXHEIGHT = 1024;
    DBottom2.SetSurface(DDraw, nil);
    DEditChat.SetSurface(DDraw, nil);
    DMerchantDlg.SetSurface(DDraw, nil);
    DGuildDlg.SetSurface(DDraw, nil);
    DStateWin.SetSurface(DDraw, nil);
    DUserState.SetSurface(DDraw, nil);
    DEditChat.RefEditSurfce();
    with DBottom.Surface.Canvas do begin
      SetBkMode(Handle, TRANSPARENT);
      for i := 49 to 57 do
        BoldTextOutEx(DBottom.Surface, 18 + (i - 49) * 42, 9, clWhite, $8, Char(i));
      BoldTextOutEx(DBottom.Surface, 18 + 9 * 42, 9, clWhite, $8, '0');
      BoldTextOutEx(DBottom.Surface, 18 + 10 * 42, 9, clWhite, $8, '-');
      BoldTextOutEx(DBottom.Surface, 18 + 11 * 42, 9, clWhite, $8, '=');
      Release;
    end;
    with DBottom2.Surface.Canvas do begin
      SetBkMode(Handle, TRANSPARENT);
      for i := 1 to 8 do
        BoldTextOutEx(DBottom2.Surface, 27 + i * 42, 9, clWhite, $8, 'F' + IntToStr(i));
      Release;
    end;   }
end;

procedure TFrmDlg.LoadAddressList;
var
  i, ii: integer;
  sStr, sTemp: string;
  StringList, StringList2, StringList3: TStringList;
begin
  StringList := nil;
  AddressList.AddObject(' ', nil);
  try
    for i := 0 to DStateInfoCity.Item.Count - 1 do begin
      sStr := DStateInfoCity.Item[i];
      if sStr <> '' then begin
        sStr := ArrestStringEx(sStr, '"', '"', sTemp);
        if (sTemp <> '') and (Length(sTemp) >= 5) then begin
          if StringList = nil then begin
            StringList := TStringList.Create;
          end;
          StringList3 := TStringList.Create;
          StringList3.Add('　');
          while True do begin
            if sStr = '' then
              break;
            sStr := ArrestStringEx(sStr, '"', '"', sTemp);
            if sTemp = '' then
              break;
            {if length(stemp) > 10 then begin
              CopyStrToClipboard(stemp);
              showmessage(stemp);
            end; }
            StringList3.Add(sTemp);
          end;
          StringList.AddObject('　', TObject(StringList3));
        end
        else if (sTemp <> '') and (Length(sTemp) < 5) then begin
          StringList2 := TStringList.Create;
          StringList2.AddObject('　', nil);
          while True do begin
            if (sStr = '') then
              break;
            sStr := ArrestStringEx(sStr, '"', '"', sTemp);
            if sTemp = '' then
              break;
            {if length(stemp) > 10 then begin
              CopyStrToClipboard(stemp);
              showmessage(stemp);
            end;    }
            if (StringList <> nil) and (StringList.Count > 0) then begin
              StringList2.AddObject(sTemp, StringList.Objects[0]);
              StringList.Delete(0);
            end
            else
              StringList2.AddObject(sTemp, nil);
          end;
          if (StringList <> nil) then begin
            if StringList.Count > 0 then begin
              for ii := 0 to StringList.Count - 1 do begin
                TStringList(StringList.Objects[ii]).Free;
              end;
            end;
            StringList.Free;
            StringList := nil;
          end;
          AddressList.AddObject('　', TObject(StringList2));
        end;
      end;
    end;
    DStateInfoCity.Item.Clear;
    DStateInfoArea.Item.Clear;
  except

  end;
end;

procedure TFrmDlg.ClearAddressList;
var
  I, II: Integer;
  String1: TStringList;
begin
  for i := 0 to AddressList.Count - 1 do begin
    if AddressList.Objects[i] <> nil then begin
      String1 := TStringList(AddressList.Objects[i]);
      for ii := 0 to String1.Count - 1 do begin
        if String1.Objects[ii] <> nil then begin
          TStringList(String1.Objects[ii]).Free;
        end;
      end;
      String1.Free;
    end;
  end;
end;

procedure TFrmDlg.OpenDealDlg;
begin
{$IF Var_Interface = Var_Mir2}
  DItemBag.Left := 0;
  DItemBag.Top := 0;
{$ELSE}
  DItemBag.Left := g_FScreenWidth - DItemBag.Width;
  DItemBag.Top := 0;
{$IFEND}

  DItemBag.Visible := True;
  DDealDlg.Visible := True;
  g_boDealEnd := False;
  g_boDealLock := False;
  DDRDealLock.Checked := False;
  DDRDealOk.Checked := False;
  DDealOk.Enabled := False;
  DDealLock.Enabled := True;

  g_nDealGold := 0;
  g_nDealRemoteGold := 0;

  SafeFillChar(g_DealItems, sizeof(g_DealItems), #0);
  SafeFillChar(g_DealRemoteItems, sizeof(g_DealRemoteItems), #0);

  ArrangeItembag;
  DScreen.AddSysMsg('与 [<CO$FFFF>' + g_sDealWho + '<CE>] 交易开始.', clYellow);
end;

procedure TFrmDlg.CloseDealDlg;
begin
  DDealDlg.Visible := FALSE;
  ArrangeItembag;
end;

procedure TFrmDlg.OpenItemBag;
begin
  DItemBag.Visible := not DItemBag.Visible;
  if DItemBag.Visible then
    ArrangeItembag;
  boOpenItemBag := DItemBag.Visible;
end;

procedure TFrmDlg.OpenMyStatus;
begin
  DStateWin.Visible := not DStateWin.Visible;
  PageChanged;
  boOpenStatus := DStateWin.Visible;
end;

procedure TFrmDlg.DPopUpPlayPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
var
  Idx: integer;
  Actor: TActor;
begin
  with DControl do begin
    Actor := PlayScene.FindActor(UserName);
    if (Actor <> nil) and (Actor.m_btRace = 0) and (not Actor.m_boDeath) then begin
      case Integer(TDPopUpMemu(Sender).Item.Objects[ItemIndex]) of
        1: ;
        2: FrmMain.SendClientMessage(CM_QUERYUSERSTATE, Actor.m_nRecogId, Actor.m_nCurrX, Actor.m_nCurrY, 0);
        3: PlayScene.SetEditChar(UserName);
        4: FrmMain.SendClientMessage(CM_FRIEND_CHENGE, 0, 0, 0, 0, UserName);
        5: begin
            if g_MyBlacklist.IndexOf(UserName) = -1 then begin
              g_MyBlacklist.Add(UserName)
            end;
          end;
        6: begin
            Idx := g_MyBlacklist.IndexOf(UserName);
            if Idx <> -1 then
              g_MyBlacklist.Delete(idx);
          end;
        7: FrmDlg2.OpenNewMail(UserName);
        8: CreateGroup(UserName);
        9: frmMain.SendGuildAddMem(UserName);
        10: CopyStrToClipboard(UserName);
        11: CopyStrToClipboard(Actor.m_sGuildName);
        12: CopyStrToClipboard(Actor.m_sGuildRankName);
        13: ;
      end;
    end;
  end;
end;

procedure TFrmDlg.OpenPlayPopupMemu(AC: TObject; nX, nY: Integer);
var
  Actor: TActor;
begin
  Actor := TActor(AC);
  with DPopUpPlay do begin
    Visible := False;
    m_boClose := True;
    Item.Clear;
    Item.AddObject('名称: ' + Actor.m_UserName, TObject(-1));
    Item.AddObject('-', nil);
    Item.AddObject('举报外挂', TObject(1));
    Item.AddObject('查看信息', TObject(2));
    Item.AddObject('进行私聊', TObject(3));
    Item.AddObject('进行切磋', TObject(13));
    if (not InFriendList(Actor.m_UserName)) and
      (Actor.m_UserName <> g_MySelf.m_UserName) then
      Item.AddObject('加为好友', TObject(4))
    else
      Item.AddObject('加为好友', nil);

    if (not InBlacklist(Actor.m_UserName)) then
      Item.AddObject('屏蔽发言', TObject(5))
    else
      Item.AddObject('解除屏蔽', TObject(6));

    if InFriendList(Actor.m_UserName) then
      Item.AddObject('发送信件', TObject(7))
    else
      Item.AddObject('发送信件', nil);
    Item.AddObject('邀请组队', TObject(8));
    Item.AddObject('邀请加入行会', TObject(9));
    Item.AddObject('-', nil);
    Item.AddObject('复制人物名称', TObject(10));
    if Actor.m_sGuildName <> '' then
      Item.AddObject('复制行会名称', TObject(11))
    else
      Item.AddObject('复制行会名称', nil);

    if Actor.m_sGuildRankName <> '' then
      Item.AddObject('复制行会封号', TObject(12))
    else
      Item.AddObject('复制行会封号', nil);

    RefSize;
    Popup(DBackground, nX, nY, Actor.m_UserName);
  end;
end;

procedure TFrmDlg.OpenSayItemShow(mitem: TNewClientItem);
var
  Point: TPoint;
begin
  with DWudItemShow do begin
    Visible := False;
    Point := DScreen.ShowHint(0, 0, ShowItemInfo(mitem, [], []), clwhite, False, mitem.UserItem.MakeIndex, True,
      Surface, HintDrawList);
    DScreen.ClearHint(True);
    Width := Point.X;
    Height := Point.Y;
    Left := g_FScreenXOrigin - Width div 2;
    Top := g_FScreenYOrigin - Height div 2;
    DBTItemShowClose.Left := Width - 14;
    Visible := True;
  end;
end;

procedure TFrmDlg.OpenUserState(UserState: PTClientStateInfo);
var
  str: string;
  TempStr: string;
  StrList: TStringList;
begin
  UserState1 := UserState^;
  DUserStateInfoName.Text := UserState1.RealityInfo.sUserName;
  if UserState1.RealityInfo.btOld > 0 then
    DUserStateInfoAge.Text := IntToStr(UserState1.RealityInfo.btOld)
  else
    DUserStateInfoAge.Text := '';
  if UserState1.RealityInfo.btSex = 1 then
    DUserStateInfoSex.Text := '男'
  else
    DUserStateInfoSex.Text := '女';

  DUserStateInfoProvince.Text := '';
  DUserStateInfoCity.Text := '';
  DUserStateInfoArea.Text := '';
  if (UserState1.RealityInfo.btProvince > 0) and
    (UserState1.RealityInfo.btProvince < DStateInfoProvince.Item.Count) and
    (UserState1.RealityInfo.btProvince < AddressList.Count) then begin
    if AddressList.Objects[UserState1.RealityInfo.btProvince] <> nil then begin
      DUserStateInfoProvince.Text := DStateInfoProvince.Item[UserState1.RealityInfo.btProvince];
      StrList := TStringList(AddressList.Objects[UserState1.RealityInfo.btProvince]);
      if (UserState1.RealityInfo.btCity > 0) and (UserState1.RealityInfo.btCity < StrList.Count) then begin
        DUserStateInfoCity.Text := StrList[UserState1.RealityInfo.btCity];
        StrList := TStringList(StrList.Objects[UserState1.RealityInfo.btCity]);
        if (StrList <> nil) and
          (UserState1.RealityInfo.btArea > 0) and (UserState1.RealityInfo.btArea < StrList.Count) then begin
          DUserStateInfoArea.Text := StrList[UserState1.RealityInfo.btArea];
        end;
      end;
    end;
  end;
  DUserStateInfoAM.Checked := CheckByteStatus(UserState1.RealityInfo.btOnlineTime, 0);
  DUserStateInfoPM.Checked := CheckByteStatus(UserState1.RealityInfo.btOnlineTime, 1);
  DUserStateInfoNight.Checked := CheckByteStatus(UserState1.RealityInfo.btOnlineTime, 2);
  DUserStateInfoMidNight.Checked := CheckByteStatus(UserState1.RealityInfo.btOnlineTime, 3);
  DUserStateInfoFriend.Checked := UserState1.RealityInfo.boFriendSee;
  DUserStateInfoMemo.Lines.Clear;
  DUserStateInfoRefPic.Enabled := UserState1.RealityInfo.sPhotoID <> '';
  TempStr := UserState1.RealityInfo.sIdiograph;
  DUserStateInfoMemo.ReadOnly := False;
  while True do begin
    if TempStr = '' then
      break;
    TempStr := GetValidStr3(TempStr, str, [#13]);
    DUserStateInfoMemo.Lines.Add(str);
  end;
  DUserStateInfoMemo.ReadOnly := True;
  UserStatePage := 0;
  UserPageChanged;
  DUserState.Visible := True;
end;

procedure TFrmDlg.PageChanged;
begin
  DStateWinItem.Visible := StatePage = 0;
  DStateWinAbil.Visible := StatePage = 1;
  DStateWinMagic.Visible := StatePage = 2;
  DStateWinInfo.Visible := StatePage = 3;
  DStateWinHorse.Visible := StatePage = 4;
  DStateWinState.Visible := StatePage = 5;
end;

procedure TFrmDlg.UserPageChanged;
begin
  DUserStateItem.Visible := UserStatePage = 0;
  DUserStateInfo.Visible := UserStatePage = 3;
  DUserStateHorse.Visible := UserStatePage = 4;
end;

procedure TFrmDlg.RefAddBagWindow;
var
  i: integer;
  nStateCount: Integer;
  nHeight: Integer;

  procedure RefAddBagWin(nCount: Integer; DWindow: TDWindow; Grid: TDGrid);
  begin
    case nCount of
      6: begin
          DWindow.SetImgIndex(g_WMain99Images, 369);
          DWindow.Left := -DWindow.Width;
          DWindow.Top := nHeight;
          Grid.Width := 104;
          Grid.Height := 69;
          Grid.ColCount := 3;
          Grid.RowCount := 2;
          Inc(nHeight, 89);
        end;
      12: begin
          DWindow.SetImgIndex(g_WMain99Images, 370);
          DWindow.Left := -DWindow.Width + 1;
          DWindow.Top := nHeight;
          Grid.Width := 139;
          Grid.Height := 104;
          Grid.ColCount := 4;
          Grid.RowCount := 3;
          Inc(nHeight, 124);
        end;
      20: begin
          DWindow.SetImgIndex(g_WMain99Images, 371);
          DWindow.Left := -DWindow.Width;
          DWindow.Top := nHeight;
          Grid.Width := 174;
          Grid.Height := 139;
          Grid.ColCount := 5;
          Grid.RowCount := 4;
          Inc(nHeight, 159);
        end
    else
      DWindow.Visible := False;
    end;
  end;
begin
  SafeFillChar(g_AddBagInfo, SizeOf(g_AddBagInfo), #0);
  g_AddBagInfo[0].nStateCount := 0;
  g_AddBagInfo[0].nItemCount := 44;
  nStateCount := 45;
  nHeight := 29;
  for I := Low(g_AddBagItems) to High(g_AddBagItems) do begin
    case i of
      0: begin
          if g_AddBagItems[i].s.Name <> '' then begin
            g_AddBagInfo[i + 1].nItemCount := GetAppendBagCount(g_AddBagItems[i].s.Shape);
            g_AddBagInfo[i + 1].nStateCount := nStateCount;
            Inc(nStateCount, g_AddBagInfo[i + 1].nItemCount);
            RefAddBagWin(g_AddBagInfo[i + 1].nItemCount, DItemAppendBag1, DItemGrid1);
            DItemAppendBag1.Visible := True;
          end
          else begin
            DItemAppendBag1.Visible := False;
          end;
        end;
      1: begin
          if g_AddBagItems[i].s.Name <> '' then begin
            g_AddBagInfo[i + 1].nItemCount := GetAppendBagCount(g_AddBagItems[i].s.Shape);
            g_AddBagInfo[i + 1].nStateCount := nStateCount;
            Inc(nStateCount, g_AddBagInfo[i + 1].nItemCount);
            RefAddBagWin(g_AddBagInfo[i + 1].nItemCount, DItemAppendBag2, DItemGrid2);
            DItemAppendBag2.Visible := True;
          end
          else begin
            DItemAppendBag2.Visible := False;
          end;
        end;
      2: begin
          if g_AddBagItems[i].s.Name <> '' then begin
            g_AddBagInfo[i + 1].nItemCount := GetAppendBagCount(g_AddBagItems[i].s.Shape);
            g_AddBagInfo[i + 1].nStateCount := nStateCount;
            Inc(nStateCount, g_AddBagInfo[i + 1].nItemCount);
            RefAddBagWin(g_AddBagInfo[i + 1].nItemCount, DItemAppendBag3, DItemGrid3);
            DItemAppendBag3.Visible := True;
          end
          else begin
            DItemAppendBag3.Visible := False;
          end;
        end;
    end;
  end;
end;

procedure TFrmDlg.RefCheckButtonXY;
var
  i: Integer;
begin
  //g_FScreenWidth
  i := g_QuestMsgList.Count * 32;
  if g_QuestMsgList.Count > 0 then
    Inc(i, 2 * (g_QuestMsgList.Count - 1));
  DBTCheck1.Left := g_FScreenXOrigin - i div 2 - DBottom.Left - 9;
  DBTCheck2.Left := DBTCheck1.Left + 32 + 2;
  DBTCheck3.Left := DBTCheck2.Left + 32 + 2;
  DBTCheck4.Left := DBTCheck3.Left + 32 + 2;
  DBTCheck5.Left := DBTCheck4.Left + 32 + 2;
  DBTCheck6.Left := DBTCheck5.Left + 32 + 2;
  DBTCheck7.Left := DBTCheck6.Left + 32 + 2;
  DBTCheck8.Left := DBTCheck7.Left + 32 + 2;
  DBTCheck9.Left := DBTCheck8.Left + 32 + 2;
  DBTCheck10.Left := DBTCheck9.Left + 32 + 2;
end;

procedure TFrmDlg.ClearGoodsList;
var
  i: integer;
begin
  for I := 0 to NpcGoodsList.Count - 1 do begin
    Dispose(PTClientGoods(NpcGoodsList[i]));
  end;
  NpcGoodsList.Clear;
  NpcGoodItems := nil;
end;

procedure TFrmDlg.ClearReturnItemList();
var
  i: integer;
begin
  for I := 0 to NpcReturnItemList.Count - 1 do begin
    Dispose(PTNewClientItem(NpcReturnItemList[i]));
  end;
  NpcReturnItemList.Clear;
end;

procedure TFrmDlg.RefGoodItems;
var
  i: integer;
  btIdx: Byte;
begin
  DMenuUpDonw.MaxPosition := 0;
  if NpcGoodsList.Count > 0 then
  begin
    btIdx := 0;
    for I := 0 to NpcGoodsList.Count - 1 do begin
      if PTClientGoods(NpcGoodsList[i]).btIdx > btIdx then
        btIdx := PTClientGoods(NpcGoodsList[i]).btIdx;
    end;
    SetLength(NpcGoodItems, btIdx + 1);
    SafeFillChar(NpcGoodItems[0], SizeOf(TClientGoods) * (btIdx + 1), #0);
    for I := 0 to NpcGoodsList.Count - 1 do begin
      NpcGoodItems[PTClientGoods(NpcGoodsList[i]).btIdx] := PTClientGoods(NpcGoodsList[i])^;
    end;
    DMenuUpDonw.MaxPosition := High(NpcGoodItems) div {$IF Var_Interface = Var_Default}5 - 5{$ELSE}4 - 4{$IFEND};
  end
  else
    SetLength(NpcGoodItems, 0);
end;

procedure TFrmDlg.RefItemPaint(dsurface, d: TDXTexture; X, Y, ax, ay: Integer; NewClientItem: pTNewClientItem;
  boCount: Boolean; PaintMode: TItemPaintMode; pRect: PRect);
var
  showstr: string;
  dd: TDXTexture;
  idx: integer;
  btEffect: Byte;
begin
  if NewClientItem.s.Effect > 10 then begin
    idx := (GetTickCount - g_dwDefTime) div 100 mod 20;
    dd := g_WItemEffectImages.Images[(NewClientItem.s.Effect - 11) * 20 + idx];
    if dd <> nil then
      d := dd;
  end;
  if pmBlend in PaintMode then begin
    DrawBlend(dsurface, x, y, d, 0);
  end
  else if pmGrayScale in PaintMode then begin
    DrawEffect(dsurface, x, y, d, ceGrayScale, False)
      //DrawBlend(dsurface, x, y, d, 0)
  end
  else
    dsurface.Draw(x, y, d.ClientRect, d, True);
  if (pmShowLevel in PaintMode) and (pRect <> nil) then begin
    btEffect := NewClientItem.UserItem.EffectValue.btEffect;
    if (btEffect = 0) and (NewClientItem.s.Effect in [1..9]) then
      btEffect := NewClientItem.s.Effect;
    //if btEffect > 0 then
    //begin
    if (btEffect in [1..9]) then begin
      if btEffect in [1..4] then begin
        case btEffect of
          1: begin
              idx := (GetTickCount - g_dwDefTime) div 150 mod 6;
              idx := 260 + idx;
            end;
          2: begin
              idx := (GetTickCount - g_dwDefTime) div 150 mod 10;
              idx := 230 + idx;
            end;
          3: begin
              idx := (GetTickCount - g_dwDefTime) div 150 mod 10;
              idx := 240 + idx;
            end;
          4: begin
              idx := (GetTickCount - g_dwDefTime) div 150 mod 8;
              idx := 250 + idx;
            end;
          else
            idx := 0;
        end;
        if idx > 0 then begin
          dd := g_WMain2Images.Images[idx];
          if dd <> nil then
            dsurface.Draw(pRect^.Left - 22, pRect^.Top - 22, dd.ClientRect, dd, True, fxAnti);
        end;
      end else begin
        idx := (GetTickCount - g_dwDefTime) div 150 mod 10;
        if btEffect = 9 then begin
          idx := 970 + idx;
        end
        else if btEffect = 8 then begin
          idx := 960 + idx;
        end
        else if btEffect = 7 then begin
          idx := 980 + idx;
        end
        else if btEffect = 6 then begin
          idx := 1000 + idx;
        end
        else if btEffect = 5 then begin
          idx := 990 + idx;
        end
        else
          idx := 0;
        if idx > 0 then begin
          dd := g_WMain99Images.Images[idx];
          if dd <> nil then
            dsurface.StretchDraw(pRect^, dd.ClientRect, dd, True);
        end;
      end;
    end else begin
      //DScreen.AddSysMsg(format('%s: %d', [NewClientItem.s.Name, NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount]), clWhite);
      //DebugOutStr(format('%s: %d %d', [NewClientItem.s.Name, NewClientItem.UserItem.EffectValue.btEffect, NewClientItem.s.Effect]));
      idx := (GetTickCount - g_dwDefTime) div 150 mod 10;
      if NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount >= 15 then begin
        idx := 970 + idx;
      end
      else if NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount >= 12 then begin
        idx := 960 + idx;
      end
      else if NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount >= 9 then begin
        idx := 980 + idx;
      end
      else if NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount >= 6 then begin
        idx := 1000 + idx;
      end
      else if NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount >= 3 then begin
        idx := 990 + idx;
      end
      else
        idx := 0;
      if idx > 0 then begin
        dd := g_WMain99Images.Images[idx];
        if dd <> nil then
          dsurface.StretchDraw(pRect^, dd.ClientRect, dd, True);
      end;
    end;
    //end;
  end;
  if boCount and (sm_Superposition in NewClientItem.s.StdModeEx) and (NewClientItem.s.DuraMax > 1) then begin
    if NewClientItem.UserItem.Dura > 1 then
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        showstr := IntToStr(NewClientItem.UserItem.Dura);
        TextOut(ax - TextWidth(showstr), ay, clwhite, showstr);
        //Release;
      end;
  end;
end;

procedure TFrmDlg.RefJobMagic(btJob: Byte);
{$IF Var_Interface = Var_Default}
var
  i: Integer;
{$IFEND}
begin
{$IF Var_Interface = Var_Default}
  MagicList1.Clear;
  MagicList2.Clear;
  case btJob of
    0: begin
        for I := Low(g_MagicArry) to High(g_MagicArry) do begin
          if (g_MagicArry[I].Magic.btJob <> 0) and (g_MagicArry[I].Magic.btJob <> 99) then Continue;
          if g_MagicArry[I].isShow then begin
//            if g_MagicArry[I].Magic.wMagicId in [110..121] then
//              MagicList2.AddObject(' ', TObject(g_MagicArry[I].Magic.wMagicId))
//            else
              MagicList1.AddString(Format('%.5d', [g_MagicArry[I].Magic.TrainLevel[0]]), TObject(g_MagicArry[I].Magic.wMagicId), True);

          end;
        end;
      end;
    1: begin
        for I := Low(g_MagicArry) to High(g_MagicArry) do begin
          if (g_MagicArry[I].Magic.btJob <> 1) and (g_MagicArry[I].Magic.btJob <> 99) then
            Continue;
          if g_MagicArry[I].isShow then begin
//            if g_MagicArry[I].Magic.wMagicId in [110..121] then
//              MagicList2.AddObject(' ', TObject(g_MagicArry[I].Magic.wMagicId))
//            else
              MagicList1.AddString(Format('%.5d', [g_MagicArry[I].Magic.TrainLevel[0]]), TObject(g_MagicArry[I].Magic.wMagicId), True);
          end;
        end;
      end;
    2: begin
        for I := Low(g_MagicArry) to High(g_MagicArry) do begin
          if (g_MagicArry[I].Magic.btJob <> 2) and (g_MagicArry[I].Magic.btJob <> 99) then Continue;
          if g_MagicArry[I].isShow then begin
//            if g_MagicArry[I].Magic.wMagicId in [110..121] then
//              MagicList2.AddObject(' ', TObject(g_MagicArry[I].Magic.wMagicId))
//            else
              MagicList1.AddString(Format('%.5d', [g_MagicArry[I].Magic.TrainLevel[0]]), TObject(g_MagicArry[I].Magic.wMagicId), True);
          end;
        end;
      end;
  end;
{$IFEND}
end;

procedure TFrmDlg.RefNakedWindow;
begin
  NakedCount := g_nNakedCount;
  NakedBackCount := g_nNakedBackCount;
  SafeFillChar(NakedAbil, SizeOf(NakedAbil), #0);
{$IF Var_Interface = Var_Mir2}
  DStateAbilOk.Visible := False;
  DStateAbilExit.Visible := False;
{$IFEND}
  DStateAbilOk.Enabled := False;
  DStateAbilExit.Enabled := False;
  if NakedBackCount > 0 then begin
    DStateAbilAdd1.Enabled := False;
    DStateAbilAdd2.Enabled := False;
    DStateAbilAdd3.Enabled := False;
    DStateAbilAdd4.Enabled := False;
    DStateAbilAdd5.Enabled := False;
    DStateAbilAdd6.Enabled := False;
    DStateAbilDel1.Enabled := (g_ClientNakedInfo.NakedAbil.nAc > 0);
    DStateAbilDel2.Enabled := (g_ClientNakedInfo.NakedAbil.nMAc > 0);
    DStateAbilDel3.Enabled := (g_ClientNakedInfo.NakedAbil.nDc > 0);
    DStateAbilDel4.Enabled := (g_ClientNakedInfo.NakedAbil.nMc > 0);
    DStateAbilDel5.Enabled := (g_ClientNakedInfo.NakedAbil.nSc > 0);
    DStateAbilDel6.Enabled := (g_ClientNakedInfo.NakedAbil.nHP > 0);
  end
  else begin
    DStateAbilAdd1.Enabled := g_nNakedCount > 0;
    DStateAbilAdd2.Enabled := g_nNakedCount > 0;
    DStateAbilAdd3.Enabled := g_nNakedCount > 0;
    DStateAbilAdd4.Enabled := g_nNakedCount > 0;
    DStateAbilAdd5.Enabled := g_nNakedCount > 0;
    DStateAbilAdd6.Enabled := g_nNakedCount > 0;
    DStateAbilDel1.Enabled := False;
    DStateAbilDel2.Enabled := False;
    DStateAbilDel3.Enabled := False;
    DStateAbilDel4.Enabled := False;
    DStateAbilDel5.Enabled := False;
    DStateAbilDel6.Enabled := False;
  end;
end;

procedure TFrmDlg.RefPhotoSurface(FileName: string; var HDInfoSurface: TDXImageTexture);
var
  Jpeg: TJPEGImage;
  Bmp: TBitmap;
  ReadBuffer, WriteBuffer: PChar;
  Access: TDXAccessInfo;
  y: Integer;
begin
  Jpeg := TJpegImage.Create;
  Bmp := TBitmap.Create;
  try
    Jpeg.LoadFromFile(FileName);
    Bmp.Assign(Jpeg);
    Bmp.PixelFormat := pf32bit;
    if HDInfoSurface <> nil then
      HDInfoSurface.Free;
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
        finally
          HDInfoSurface.Unlock;
        end;
      end;
    end;
  finally
    Jpeg.Free;
    Bmp.Free;
  end;
end;

procedure TFrmDlg.RefRealityInfo();
var
  str: string;
  TempStr: string;
begin
  TempRealityInfo := g_UserRealityInfo;
  DStateInfoName.Text := g_UserRealityInfo.sUserName;
  if g_UserRealityInfo.btOld > 0 then
    DStateInfoAge.Text := IntToStr(g_UserRealityInfo.btOld)
  else
    DStateInfoAge.Text := '';
  DStateInfoSex.ItemIndex := g_UserRealityInfo.btSex;
  DStateInfoProvince.ItemIndex := g_UserRealityInfo.btProvince;
  DStateInfoNameChange(DStateInfoProvince);
  DStateInfoCity.ItemIndex := g_UserRealityInfo.btCity;
  DStateInfoNameChange(DStateInfoCity);
  DStateInfoArea.ItemIndex := g_UserRealityInfo.btArea;
  DStateInfoNameChange(DStateInfoArea);
  DStateInfoAM.Checked := CheckByteStatus(g_UserRealityInfo.btOnlineTime, 0);
  DStateInfoPM.Checked := CheckByteStatus(g_UserRealityInfo.btOnlineTime, 1);
  DStateInfoNight.Checked := CheckByteStatus(g_UserRealityInfo.btOnlineTime, 2);
  DStateInfoMidNight.Checked := CheckByteStatus(g_UserRealityInfo.btOnlineTime, 3);
  DStateInfoFriend.Checked := g_UserRealityInfo.boFriendSee;
  DStateInfoMemo.Lines.Clear;
  DStateInfoRefPic.Enabled := g_UserRealityInfo.sPhotoID <> '';
  TempStr := TempRealityInfo.sIdiograph;
  while True do begin
    if TempStr = '' then
      break;
    TempStr := GetValidStr3(TempStr, str, [#13]);
    DStateInfoMemo.Lines.Add(str);
  end;
{$IF Var_Interface = Var_Mir2}
  DStateInfoSave.Visible := False;
  DStateInfoExit.Visible := False;
{$IFEND}
  DStateInfoSave.Enabled := False;
  DStateInfoExit.Enabled := False;
end;

procedure TFrmDlg.RefStatusInfoForm;
var
  I: Integer;
  StatusInfo: pTStatusInfo;
begin
  for I := 0 to g_StatusInfoList.Count - 1 do begin
    StatusInfo := @g_StatusInfoArr[Integer(g_StatusInfoList[I])];
    with StatusInfo.Button as TDButton do begin
      if I > 6 then begin
        Top := 83;
        Left := 592 - ((I - 7) * 25);
      end else begin
        Top := 57;
        Left := 592 - (I * 25);
      end;
    end;
  end;
end;

procedure TFrmDlg.SetGroupWnd;
var
  boGroup: Boolean;
  GroupMember: pTGroupMember;
begin
  if g_MySelf = nil then
    exit;
  DCBGroupItemRam.Checked := g_GroupItemMode;
  DCBGroupItemDef.Checked := not g_GroupItemMode;
  if g_GroupMembers.Count <= 0 then begin
    DCBGroupItemRam.Enabled := True;
    DCBGroupItemDef.Enabled := True;
    DGrpDelMem.Visible := False;
    DGroupExit.Visible := False;
    DGrpCreate.Visible := True;
    DGrpAddMem.Visible := True;
    FrmDlg2.DWndGroup.Visible := False;
  end
  else begin
    DCBGroupItemRam.Enabled := False;
    DCBGroupItemDef.Enabled := False;
    GroupMember := g_GroupMembers.Items[0];
    boGroup := (GroupMember.ClientGroup.UserID = g_MySelf.m_nRecogId);
    DGrpCreate.Visible := boGroup;
    DGrpAddMem.Visible := boGroup;
    DGrpDelMem.Visible := boGroup;
    DGroupExit.Visible := True;
{$IF Var_Interface =  Var_Default}
    FrmDlg2.DWndGroup.Visible := True;
    FrmDlg2.DWndGroupMember.Visible := True;
    FrmDlg2.DGroupMember1.Visible := g_GroupMembers.Count > 1;
    FrmDlg2.DGroupMember2.Visible := g_GroupMembers.Count > 2;
    FrmDlg2.DGroupMember3.Visible := g_GroupMembers.Count > 3;
    FrmDlg2.DGroupMember4.Visible := g_GroupMembers.Count > 4;
    FrmDlg2.DGroupMember5.Visible := g_GroupMembers.Count > 5;
    FrmDlg2.DGroupMember6.Visible := g_GroupMembers.Count > 6;
    FrmDlg2.DGroupMember7.Visible := g_GroupMembers.Count > 7;
{$IFEND}
  end;
end;

procedure TFrmDlg.SetMiniMapSize(flag: Byte);
begin
  g_nMiniMapOldX := -1;
  case flag of
    0: DMiniMap.Visible := False;
    1:
      begin
        DMiniMap.Visible := True;
        DMiniMap.Left := g_FScreenWidth - 128;
        DMiniMap.Top := 0;
        DMiniMap.Width := 128;
        DMiniMap.Height := 128;
        //DMiniMap.CreateSurface(nil);
      end;
    2:
      begin
        DMiniMap.Visible := True;
        DMiniMap.Left := g_FScreenWidth - 192;
        DMiniMap.Top := 0;
        DMiniMap.Width := 192;
        DMiniMap.Height := 160;
        //DMiniMap.CreateSurface(nil);
      end;
    3:
      begin
        {g_nMiniMaxShow := True;
        DMiniMap.Left := 0;
        DMiniMap.Top := 0;
        DMiniMap.Width := 800;
        DMiniMap.Height := 600;   }
      end;
  end;
end;

procedure TFrmDlg.ShowMDlg(nResID, nWidth, nHeight: Integer; mname, msgstr: string);
var
  i: Integer;
  d: TDXTexture;
begin
  if (nResID >= 0) and (nWidth > 0) and (nHeight > 0) then
  begin
    d := g_WMain99Images.Images[nResID];
    if d <> nil then begin
{$IF Var_Interface = Var_Mir2}
      DMerchantDlgClose.Left := d.Width - 17;
      DMDlgUpDonw.Left := d.Width - 39;
{$ELSE}
      DMerchantDlgClose.Left := d.Width - 25;
      DMDlgUpDonw.Left := d.Width - 25;
{$IFEND}
    end;
    DMerchantDlg.SetImgIndex(g_WMain99Images, nResID);
    g_MerchantMaxWidth := nWidth;
    g_MerchantMaxHeight := nHeight;
    DMerchantDlg.Surface.Size := Point(nWidth, MDLGMAXHEIGHT);
    DMerchantDlg.Surface.PatternSize := Point(nWidth, MDLGMAXHEIGHT);
  end
  else
  begin
{$IF Var_Interface = Var_Mir2}
    DMerchantDlg.SetImgIndex(g_WMain99Images, 1933);
    DMerchantDlgClose.Left := 399;
    DMDlgUpDonw.Left := 377;
{$ELSE}
    DMerchantDlg.SetImgIndex(g_WMain99Images, 136);
    DMerchantDlgClose.Left := 275;
    DMDlgUpDonw.Left := 275;
{$IFEND}
    DMerchantDlg.Surface.Size := Point(DEFMDLGMAXWIDTH, MDLGMAXHEIGHT);
    DMerchantDlg.Surface.PatternSize := Point(DEFMDLGMAXWIDTH, MDLGMAXHEIGHT);
    g_MerchantMaxWidth := DefMerchantMaxWidth;
    g_MerchantMaxHeight := DefMerchantMaxHeight;
  end;
  MerchantName := mname;
  MDlgRefTime := 0;
  MDlgMove.rstr := '';
  MDlgSelect.rstr := '';
  //MDlgNewMoveRect.Top := -10000;
  //MDlgNewSelectRect.Top := -10000;
  MDlgStr := FormatShowText(msgstr, nil);
  DMDlgUpDonw.MaxPosition := 0;
  DMDlgUpDonw.Visible := False;
{$IF Var_Interface = Var_Mir2}
  DItemBag.Left := 475;
  DItemBag.Top := 0;
  DMDlgUpDonw.Height := 158;
{$ELSE}
  DMDlgUpDonw.Height := 311;
{$IFEND}

  DItemBag.Left := g_FScreenWidth - DItemBag.Width;
  DItemBag.Top := 0;
  //MerchantMaxHeight := 306;
  for i := 0 to MDlgPoints.count - 1 do
    Dispose(pTClickPoint(MDlgPoints[i]));
  for i := 0 to MDlgDraws.count - 1 do begin
    if pTNewShowHint(MDlgDraws[i]).IndexList <> nil then
      pTNewShowHint(MDlgDraws[i]).IndexList.Free;
    Dispose(pTNewShowHint(MDlgDraws[i]));
  end;

  MDlgPoints.Clear;
  //MDlgNewPoints.Clear;
  MDlgDraws.Clear;
  LastestClickTime := GetTickCount;
  DMerchantDlg.Surface.Clear;
  MerchantHeight := DlgShowText(DMerchantDlg.Surface, 0, 0, MDlgPoints, MDlgDraws, MDlgStr, MDLGMAXHEIGHT);
  if MerchantHeight > g_MerchantMaxHeight then begin
    DMDlgUpDonw.MaxPosition := MerchantHeight - g_MerchantMaxHeight;
    DMDlgUpDonw.Visible := True;
  end;
  MDlgRefTime := GetTickCount + 300;
  DMerchantDlg.Visible := True;
  MDlgVisible := True;
  DMenuDlg.Visible := False;
  DWndBuy.Visible := False;
  DMenuDlg.Visible := False;
  FrmDlg3.DWndArmStrengthen.Visible := False;
  FrmDlg3.DWndMakeItem.Visible := False;
  FrmDlg2.DStorageDlg.Visible := False;
  FrmDlg3.DWndItemUnseal.Visible := False;
  FrmDlg4.DWndItemRemove.Visible := False;
  LastestClickTime := GetTickCount + 200;
end;

procedure TFrmDlg.CloseMDlg;
var
  i: Integer;
begin
  MDlgVisible := False;
  MDlgStr := '';
  DMerchantDlg.Visible := FALSE;
  for i := 0 to MDlgPoints.count - 1 do
    Dispose(pTClickPoint(MDlgPoints[i]));

  for i := 0 to MDlgDraws.count - 1 do begin
    if pTNewShowHint(MDlgDraws[i]).IndexList <> nil then
      pTNewShowHint(MDlgDraws[i]).IndexList.Free;
    Dispose(pTNewShowHint(MDlgDraws[i]));
  end;
  MDlgPoints.Clear;
  MDlgDraws.Clear;
  //皋春芒档 摧澜
{$IF Var_Interface = Var_Mir2}
  DItemBag.Left := 0;
  DItemBag.Top := 0;
{$ELSE}
  DItemBag.Left := g_FScreenWidth - DItemBag.Width;
  DItemBag.Top := 0;  
{$IFEND}

  DMenuDlg.Visible := FALSE;
  DWndBuy.Visible := False;
  FrmDlg3.DWndArmStrengthen.Visible := False;
  FrmDlg3.DWndMakeItem.Visible := False;
  FrmDlg2.DStorageDlg.Visible := False;
  FrmDlg3.DWndItemUnseal.Visible := False;
  FrmDlg4.DWndItemRemove.Visible := False;
  DMenuDlg.Visible := False;
  if DitemBag.Visible and not boOpenItemBag then
    OpenItemBag;
  if DStateWin.Visible and not boOpenStatus then
    OpenMyStatus;
end;

procedure TFrmDlg.CreateGroup(sChrName: string);
begin
  g_dwChangeGroupModeTick := GetTickCount + 2000;
  if g_GroupMembers.count = 0 then
    frmMain.SendCreateGroup(Integer(g_GroupItemMode), sChrName)
  else
    frmMain.SendAddGroupMember(sChrName);
end;

procedure TFrmDlg.DOpenCompoundItemClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg4.DWndCompound.Visible := not FrmDlg4.DWndCompound.Visible;
end;

procedure TFrmDlg.DOpenCompoundItemDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  i: Integer;
  d: TDXTexture;
begin
  with Sender as TDButton do
  begin
    if GetTickCount() >= FCompoundItemBtnTick + 150 then
    begin
      FCompoundItemBtnTick := GetTickCount();
      Inc(FCompoundItemBtnIndex);
      if FCompoundItemBtnIndex >= 6 then
        FCompoundItemBtnIndex := 0;
    end;
    if Downed then
      i := 6
    else if MouseEntry = msIn then
      i := 7
    else
      i := FCompoundItemBtnIndex;
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex + i];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

end.



