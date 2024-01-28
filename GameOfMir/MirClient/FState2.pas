unit FState2;

interface

uses
  Windows, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MShare, MNShare, HGEGUI, WIL, HGETextures, Grobal2, Grids, Share, JPEG, WMFile;

type

  TMissionClickType = (mct_None, mct_Button, mct_Click);

  pTMissionClick = ^TMissionClick;
  TMissionClick = packed record
    nX, nY, nWidth, nHeight: Integer;
    ClickType: TMissionClickType;
    ClientMissionInfo: pTClientMissionInfo;
    sText: string;
    sParam: string;
  end;

  TFrmDlg2 = class(TForm)
    DWndHint: TDWindow;
    DWndGroup: TDWindow;
    DGroupClose: TDButton;
    DWndGroupMember: TDWindow;
    DGroupMember7: TDWindow;
    DGroupMember4: TDWindow;
    DGroupMember1: TDWindow;
    DGroupMember2: TDWindow;
    DGroupMember3: TDWindow;
    DGroupMember6: TDWindow;
    DGroupMember5: TDWindow;
    DPopUpMemuGroup: TDPopUpMemu;
    DShopWin: TDWindow;
    DBotList1: TDButton;
    DBotList2: TDButton;
    DBotList3: TDButton;
    DBotList4: TDButton;
    DBotList5: TDButton;
    DBotList6: TDButton;
    DBotShopClose: TDButton;
    DBotBuy: TDButton;
    DButFront: TDButton;
    DButNext: TDButton;
    DButFront2: TDButton;
    DButNext2: TDButton;
    DShopGrid: TDGrid;
    DWinEmail: TDWindow;
    DWinFriend: TDWindow;
    DFriWin: TDWindow;
    DFriFriend: TDButton;
    DFriBlack: TDButton;
    DFriSay: TDButton;
    DFriClose: TDButton;
    DFriAddMem: TDButton;
    DFriDelMem: TDButton;
    DMatrixCardWnd: TDWindow;
    DCardNo1: TDEdit;
    DCardNo2: TDEdit;
    DCardOK: TDButton;
    DCardClose: TDButton;
    DCardNo3: TDEdit;
    DFriendUpDown: TDUpDown;
    DEMailDel: TDButton;
    DEMailDelAll: TDButton;
    DEMailRead: TDButton;
    DEMailNew: TDButton;
    DEMailClose: TDButton;
    DUpDownEMail: TDUpDown;
    DWndEMailRead: TDWindow;
    DEMailReadClose: TDButton;
    DEMailReadBack: TDButton;
    DEMailReadDel: TDButton;
    DMemoEMailRead: TDMemo;
    DEMailReadUpDown: TDUpDown;
    DWndEMailNew: TDWindow;
    DEmailNewMemo: TDMemo;
    DEMailNewAdd: TDButton;
    DEMailNewClose: TDButton;
    DEMailNewClose2: TDButton;
    DEmailNewUpDown: TDUpDown;
    DEMailNewEdit: TDEdit;
    DEMailNameComboBox: TDComboBox;
    DPopUpFriend: TDPopUpMemu;
    DWinUpLoad: TDWindow;
    DUpLoadOk: TDButton;
    DUpLoadExit: TDButton;
    DUpLoadTop: TDButton;
    DUpLoadDown: TDButton;
    DUpLoadLeft: TDButton;
    DUpLoadRight: TDButton;
    DUpLoadImage: TDWindow;
    DUpDownUpLoad: TDUpDown;
    DUpLoadClose: TDButton;
    DUpLoadFileList: TDWindow;
    DWndUserShop: TDWindow;
    DUserShopSellGrid: TDGrid;
    DUserShopBuyGrid: TDGrid;
    DUserShopMemo: TDMemo;
    DUpDownUserShop: TDUpDown;
    DUserSellShopClear: TDButton;
    DUserShopOpen: TDButton;
    DUserShopClose: TDButton;
    DUserShopClose2: TDButton;
    DShopGameGold: TDButton;
    DShopGamePoint: TDButton;
    DShopGetGamePoint: TDButton;
    DUserBuyShopClear: TDButton;
    DReadUserShop: TDWindow;
    DReadShopSellGrid: TDGrid;
    DReadShopBuyGrid: TDGrid;
    DReadShopClose: TDButton;
    DReadShopMemo: TDMemo;
    DReadShopUpDown: TDUpDown;
    DReadShopEdit: TDEdit;
    DStorageDlg: TDWindow;
    DStorage1: TDButton;
    DStorage2: TDButton;
    DStorage3: TDButton;
    DStorage4: TDButton;
    DStorage5: TDButton;
    DStorageGetGold: TDButton;
    DStorageSaveGold: TDButton;
    DStorageClose: TDButton;
    DStorageGrid: TDGrid;
    DWndDeath: TDWindow;
    dbtnAcceptCure: TDButton;
    dbtnAtOnceCure: TDButton;
    dbtnBackCure: TDButton;
    DWndBar: TDWindow;
    DEditShopCount: TDEdit;
    DBuyAdd: TDButton;
    DBuyDel: TDButton;
    DEMailGrid: TDGrid;
    DEMailNewItem: TDButton;
    DEMailReadItem: TDButton;
    DEMailReadGold: TDButton;
    DEditEMailNewGold: TDEdit;
    DWndWeb: TDWindow;
    dBtWebClose: TDButton;
    dwndSysSetup: TDWindow;
    dbtnGameSetup: TDButton;
    dbtnSelectChr: TDButton;
    dbtnExitGame: TDButton;
    DShopGold: TDButton;
    DShopGrid2: TDGrid;
    IconButtonLayout: TDWindow;
    IconButtonAccordion: TDButton;
    IconButtonList: TDWindow;
    IconButton1: TDButton;
    IconButton2: TDButton;
    IconButton3: TDButton;
    IconButton4: TDButton;
    IconButton5: TDButton;
    IconButton6: TDButton;
    IconButton7: TDButton;
    procedure DLoginOkSound(Sender: TObject; Clicksound: TClickSound);
    procedure DWndHintInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DWndHintDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DGroupCloseClick(Sender: TObject; X, Y: Integer);
    procedure DGroupCloseDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DGroupMember1DirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DWndGroupMemberInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DGroupMember1InRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DWndGroupMemberDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DGroupMember1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DShopWinDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotShopCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotList1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotList1Click(Sender: TObject; X, Y: Integer);
    procedure DShopGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DButFrontClick(Sender: TObject; X, Y: Integer);
    procedure DShopGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DShopGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DShopWinMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DBotBuyClick(Sender: TObject; X, Y: Integer);
    procedure DWinEmailDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotShopCloseClick(Sender: TObject; X, Y: Integer);
    procedure DFriFriendDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DFriFriendClick(Sender: TObject; X, Y: Integer);
    procedure DMatrixCardWndDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DCardCloseClick(Sender: TObject; X, Y: Integer);
    procedure DCardOKClick(Sender: TObject; X, Y: Integer);
    procedure DFriAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DFriDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DFriWinDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DFriFriendMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DFriWinMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DWinFriendDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DEMailListClick(Sender: TObject; X, Y: Integer);
    procedure DEMailReadClick(Sender: TObject; X, Y: Integer);
    procedure DWndEMailReadDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWndEMailNewVisible(Sender: TObject; boVisible: Boolean);
    procedure DEMailNewClick(Sender: TObject; X, Y: Integer);
    procedure DEMailReadBackClick(Sender: TObject; X, Y: Integer);
    procedure DEMailReadDelClick(Sender: TObject; X, Y: Integer);
    procedure DEMailDelClick(Sender: TObject; X, Y: Integer);
    procedure DEMailDelAllClick(Sender: TObject; X, Y: Integer);
    procedure DEMailNewAddClick(Sender: TObject; X, Y: Integer);
    procedure DPopUpMemuGroupPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
    procedure DCardNo1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DFriWinDblClick(Sender: TObject);
    procedure DFriWinMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DPopUpFriendPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
    procedure DGroupMember7MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DFriWinMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DWinUpLoadDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWinUpLoadVisible(Sender: TObject; boVisible: Boolean);
    procedure DUpLoadFileListDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUpLoadFileListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DWinUpLoadMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DUpLoadFileListDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DUpLoadImageDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUpLoadTopMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DUpLoadOkClick(Sender: TObject; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure DWndUserShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWndUserShopVisible(Sender: TObject; boVisible: Boolean);
    procedure DUserShopSellGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DUserShopSellGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DShopGameGoldDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DShopGameGoldClick(Sender: TObject; X, Y: Integer);
    procedure DShopGetGamePointClick(Sender: TObject; X, Y: Integer);
    procedure DUserShopSellGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DUserSellShopClearClick(Sender: TObject; X, Y: Integer);
    procedure DUserShopBuyGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DUserShopBuyGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DUserShopBuyGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DUserShopOpenClick(Sender: TObject; X, Y: Integer);
    procedure DReadUserShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DReadUserShopVisible(Sender: TObject; boVisible: Boolean);
    procedure DReadShopSellGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DReadShopSellGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DReadShopBuyGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DReadShopBuyGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DReadShopSellGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DReadShopBuyGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DStorageDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStorage1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStorageDlgVisible(Sender: TObject; boVisible: Boolean);
    procedure DStorage1Click(Sender: TObject; X, Y: Integer);
    procedure DStorageGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DStorageGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DStorageGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DStorageGetGoldClick(Sender: TObject; X, Y: Integer);
    procedure DStorage1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DReadShopEditKeyPress(Sender: TObject; var Key: Char);
    procedure DWndDeathDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWndBarDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dbtnAcceptCureClick(Sender: TObject; X, Y: Integer);
    procedure DBuyAddDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBuyAddClick(Sender: TObject; X, Y: Integer);
    procedure DEMailGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
    procedure DEMailGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DEMailNewItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DEMailNewItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DEMailNewItemClick(Sender: TObject; X, Y: Integer);
    procedure DEditEMailNewGoldChange(Sender: TObject);
    procedure DEMailGridDblClick(Sender: TObject);
    procedure DEMailReadGoldClick(Sender: TObject; X, Y: Integer);
    procedure DEMailReadItemClick(Sender: TObject; X, Y: Integer);
    procedure DWndWebDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWndWebVisible(Sender: TObject; boVisible: Boolean);
    procedure dwndSysSetupDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dbtnGameSetupClick(Sender: TObject; X, Y: Integer);
    procedure dbtnGameSetupMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DWndHintMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DWndHintClick(Sender: TObject; X, Y: Integer);
    procedure DWndHintLeave(Sender: TObject);
    procedure DWndWebInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
    procedure dbtnSelectChrDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DEMailReadDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotBuyDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DShopGrid2GridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
    procedure DShopGrid2GridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DShopGrid2GridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure dBtWebCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUpLoadExitDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUpLoadTopDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure IconButtonAccordionClicked(Sender: TObject; X, Y: Integer);
    procedure IconButtonAccordionDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure IconButtonClicked(Sender: TObject; X, Y: Integer);
    procedure IconButtonDirectPaint(Sender: TObject; dsurface: TDXTexture);
  private
    m_SelectMissionClick: pTMissionClick;
  public
    m_SysMsgTime: LongWord;
    m_boChangeGroup: Boolean;
    ShopIndex: Byte;
    ShopPage: Integer;
    ShopMaxPage: Integer;
    ShopSelectIdx: Integer;
    ShopMoneyType: Byte;
    ShopSelectIndex: Integer;
    FriendIndex: Integer;
    FriendSelect: Integer;
    FriendMove: Integer;
    EMailSelect: Integer;
    EMailMove: Integer;
    CardID: array[0..2] of Word;
    ReadEMailInfo: TEMailInfo;
    HDInfoMove: Integer;
    HDInfoFileName: string;
    HDInfoSurface: TDXImageTexture;
//    HDInfoDIB: TBitmap;
    HDInfoLeft, HDInfoTop: Integer;
//    HDSaveDib: TDIB;
    HDSaveJpeg: TJPEGImage;

    StorageIdx: Byte;
    UserShopID: Integer;
    BarTitle: String;
    BarTime: LongWord;
    BarTick: LongWord;
    BarCmd: Integer;
    BarParam1: Integer;
    BarParam2: Integer;
    EMailNewItem: TMovingItem;
    EMailSelectTick: LongWord;

    FsUrl: string;
    m_boCanShowMissionHint: Boolean;
    m_boShowMissionChange: Boolean;
    m_MissionClickList: TList;
    procedure Initialize;
    procedure InitializeEx();
    //procedure SetEditChar(sMsg: string);
    procedure OpenReadMail(EMailInfo: pTEMailInfo);
    procedure OpenNewMail(UserName: string);
    function GetShopSellItems(cu: TNewClientItem): Boolean;
    procedure ClearShopSellItems();
    procedure RefShopSellItems();
    function GetShopBuyItemsGold(boPoint: Boolean): Integer;
    procedure AddShopMsg(smsg: string);
    procedure OpenWeb(sUrl: string; nWidth, nHeight: Integer);
    procedure AutoStorage(nItemIndex: Integer);
  end;

var
  FrmDlg2: TFrmDlg2;
  s1: string[20] = 'ezEixdj';

implementation
uses
  SoundUtil, ClMain, DrawScrn, ClFunc, Actor, HUtil32, GameSetup, FState, IntroScn, EDcodeEx, HGEBase,
  DateUtils, FWeb, FState3, LShare;
{$R *.dfm}

{ TFrmDlg2 }

const
{$IF Var_Interface = Var_Mir2}
  FRIENDCOUNT = 10;
{$ELSE}
  FRIENDCOUNT = 17;
{$IFEND}


procedure TFrmDlg2.Initialize;
var
  d: TDXTexture;
  i: Integer;
  dcon: TDControl;
begin
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TDWindow) or (Components[i] is TDPopUpMemu) then begin
      dcon := TDControl(Components[i]);
      if dcon.DParent = nil then begin
        dcon.DParent := FrmDlg.DBackground;
        FrmDlg.DBackground.AddChild(dcon);
      end;
    end;
  end;
  m_SysMsgTime := GetTickCount;
  m_boChangeGroup := False;
  FriendIndex := 0;
  ShopMoneyType := 1;
  m_SelectMissionClick := nil;
  EMailNewItem.Item.s.Name := '';
  EMailSelectTick := GetTickCount;
  //提示框
  DWndHint.Height := MISSIONHINTHEIGHT;
  DWndHint.Left := g_FScreenWidth + MISSIONHINTX;
  DWndHint.Width := MISSIONHINTWIDTH;
  DWndHint.Top := MISSIONHINTY;
  FriendSelect := -1;
  FriendMove := -1;
  EMailSelect := -1;
  EMailMove := -1;
  // 图标按钮布局
  IconButtonLayout.Left := 24;
  IconButtonLayout.Top := 24;
  d := g_WMain99Images.Images[160];
  if d <> nil then begin
    // 收起图标按钮
    IconButtonAccordion.SetImgIndex(g_WMain99Images, 160);
    IconButtonAccordion.Left := 0;
    IconButtonAccordion.Top := 0;
  end;
  // 图标按钮列表
  IconButtonList.Left := IconButtonAccordion.Left + IconButtonAccordion.Width + 8;
  IconButtonList.Top := 0;
  // 图标1
  d := g_WUIAserverImages.Images[3];
  if d <> nil then begin
    IconButton1.SetImgIndex(g_WUIAserverImages, 3);
    IconButton1.Left := 0;
    IconButton1.Top := 0;
    IconButton1.OnDirectPaint := IconButtonDirectPaint;
  end;
  // 图标2
  d := g_WUIAserverImages.Images[9];
  if d <> nil then begin
    IconButton2.SetImgIndex(g_WUIAserverImages, 9);
    IconButton2.Left := IconButton1.Left + IconButton1.Width + 8;
    IconButton2.Top := 0;
    IconButton2.OnDirectPaint := IconButtonDirectPaint;
  end;
  // 图标3
  d := g_WUIAserverImages.Images[15];
  if d <> nil then begin
    IconButton3.SetImgIndex(g_WUIAserverImages, 15);
    IconButton3.Left := IconButton2.Left + IconButton2.Width + 8;
    IconButton3.Top := 0;
    IconButton3.OnDirectPaint := IconButtonDirectPaint;
  end;
  // 图标4
  d := g_WUIAserverImages.Images[21];
  if d <> nil then begin
    IconButton4.SetImgIndex(g_WUIAserverImages, 21);
    IconButton4.Left := IconButton3.Left + IconButton3.Width + 8;
    IconButton4.Top := 0;
    IconButton4.OnDirectPaint := IconButtonDirectPaint;
  end;
  // 图标5
  d := g_WUIAserverImages.Images[27];
  if d <> nil then begin
    IconButton5.SetImgIndex(g_WUIAserverImages, 27);
    IconButton5.Left := IconButton4.Left + IconButton4.Width + 8;
    IconButton5.Top := 0;
    IconButton5.OnDirectPaint := IconButtonDirectPaint;
  end;
  // 图标6
  d := g_WUIAserverImages.Images[33];
  if d <> nil then begin
    IconButton6.SetImgIndex(g_WUIAserverImages, 33);
    IconButton6.Left := IconButton5.Left + IconButton5.Width + 8;
    IconButton6.Top := 0;
    IconButton6.OnDirectPaint := IconButtonDirectPaint;
  end;
  // 图标7
  d := g_WUIAserverImages.Images[39];
  if d <> nil then begin
    IconButton7.SetImgIndex(g_WUIAserverImages, 39);
    IconButton7.Left := IconButton6.Left + IconButton6.Width + 8;
    IconButton7.Top := 0;
    IconButton7.OnDirectPaint := IconButtonDirectPaint;
  end;
  IconButtonList.Width := IconButton7.Left + IconButton7.Width + 8;
  IconButtonList.Height := 64;
  //队伍信息
  d := g_WMain99Images.Images[170];
  if d <> nil then begin
    DWndGroup.SetImgIndex(g_WMain99Images, 170);
    DWndGroup.Left := 0;
    DWndGroup.Top := 100;
  end;
  DPopUpMemuGroup.SetImgIndex(g_WMain99Images, 276);
  DPopUpFriend.SetImgIndex(g_WMain99Images, 276);
  // 收起队伍信息按钮
  DGroupClose.SetImgIndex(g_WMain99Images, 306);
  DGroupClose.Left := 60;
  DGroupClose.Top := 1;
  // 队员1
  DGroupMember1.SetImgIndex(g_WMain99Images, 180);
  DGroupMember1.Left := 0;
  DGroupMember1.Top := 0;
  // 队员2
  DGroupMember2.SetImgIndex(g_WMain99Images, 180);
  DGroupMember2.Left := 0;
  DGroupMember2.Top := 50;
  // 队员3
  DGroupMember3.SetImgIndex(g_WMain99Images, 180);
  DGroupMember3.Left := 0;
  DGroupMember3.Top := 100;
  // 队员4
  DGroupMember4.SetImgIndex(g_WMain99Images, 180);
  DGroupMember4.Left := 0;
  DGroupMember4.Top := 150;
  // 队员5
  DGroupMember5.SetImgIndex(g_WMain99Images, 180);
  DGroupMember5.Left := 0;
  DGroupMember5.Top := 200;
  // 队员6
  DGroupMember6.SetImgIndex(g_WMain99Images, 180);
  DGroupMember6.Left := 0;
  DGroupMember6.Top := 250;
  // 队员7
  DGroupMember7.SetImgIndex(g_WMain99Images, 180);
  DGroupMember7.Left := 0;
  DGroupMember7.Top := 300;
  // 队伍成员
  DWndGroupMember.SetImgIndex(g_WMain99Images, 170);
  DWndGroupMember.Left := 0;
  DWndGroupMember.Top := 22;
  DWndGroupMember.Width := 150;
  DWndGroupMember.Height := 350;
  //商铺列表
{$IF Var_Interface = Var_Mir2}
  DShopWin.SetImgIndex(g_WMain99Images, 1746);
  DShopWin.Left := 0;
  DShopWin.Top := 0;

  DBotShopClose.SetImgIndex(g_WMain99Images, 1850);
  DBotShopClose.Left := 606;
  DBotShopClose.Top := 5;

  DShopGameGold.SetImgIndex(g_WMain99Images, 1747);
  DShopGameGold.Left := 9;
  DShopGameGold.Top := 9;

  DShopGamePoint.SetImgIndex(g_WMain99Images, 193);
  DShopGamePoint.Left := 110;
  DShopGamePoint.Top := 19;
  DShopGamePoint.Visible := False;
  
  DShopGold.SetImgIndex(g_WMain99Images, 193);
  DShopGold.Left := 185;
  DShopGold.Top := 19;
  DShopGold.Visible := False;

  DBotList1.SetImgIndex(g_WMain99Images, 2063);
  DBotList1.Left := 242;
  DBotList1.Top := 46;
  DBotList1.Visible := False;
  DBotList2.SetImgIndex(g_WMain99Images, 2071);
  DBotList2.Left := 409;
  DBotList2.Top := 14;
  DBotList3.SetImgIndex(g_WMain99Images, 2068);
  DBotList3.Left := 235;
  DBotList3.Top := 14;
  DBotList4.SetImgIndex(g_WMain99Images, 2069);
  DBotList4.Left := 293;
  DBotList4.Top := 14;
  DBotList5.SetImgIndex(g_WMain99Images, 2067);
  DBotList5.Left := 177;
  DBotList5.Top := 14;
  DBotList6.SetImgIndex(g_WMain99Images, 2070);
  DBotList6.Left := 351;
  DBotList6.Top := 14;

  with DEditShopCount do begin
    Height := 16;
    Width := 90;
    Left := 30;
    Top := 199;
    Visible := True;
  end;

  DBuyAdd.SetImgIndex(g_WMain99Images, 1851);
  DBuyAdd.Left := 122;
  DBuyAdd.Top := 199;
  DBuyAdd.OnDirectPaint := DBotShopCloseDirectPaint;
  DBuyDel.SetImgIndex(g_WMain99Images, 1852);
  DBuyDel.Left := 137;
  DBuyDel.Top := 199;
  DBuyDel.OnDirectPaint := DBotShopCloseDirectPaint;

  DBotBuy.SetImgIndex(g_WMain99Images, 1751);
  DBotBuy.Left := 52;
  DBotBuy.Top := 353;

  DShopGetGamePoint.SetImgIndex(g_WMain99Images, 198);
  DShopGetGamePoint.Left := 31;
  DShopGetGamePoint.Top := 545;
  DShopGetGamePoint.Caption := '对换' + g_sGameGoldName;
  DShopGetGamePoint.Visible := False;

  DButFront.SetImgIndex(g_WMain99Images, 204);
  DButFront.Left := 538;
  DButFront.Top := 84;
  DButFront.Visible := False;
  DButNext.SetImgIndex(g_WMain99Images, 204);
  DButNext.Left := 651;
  DButNext.Top := 84;
  DButNext.Visible := False;
  DButFront2.SetImgIndex(g_WMain99Images, 1854);
  DButFront2.Left := 197;
  DButFront2.Top := 349;
  DButFront2.OnDirectPaint := DBotShopCloseDirectPaint;
  DButNext2.SetImgIndex(g_WMain99Images, 1853);
  DButNext2.Left := 287;
  DButNext2.Top := 349;
  DButNext2.OnDirectPaint := DBotShopCloseDirectPaint;

  DShopGrid.Top := 60;
  DShopGrid.left := 180;
  DShopGrid.Width := 329;
  DShopGrid.Height := 266;
  DShopGrid.ColWidth := 158;
  DShopGrid.Coloffset := 13;
  DShopGrid.ColCount := 2;
  DShopGrid.RowHeight := 50;
  DShopGrid.Rowoffset := 4;
  DShopGrid.RowCount := 5;

  DShopGrid2.Top := 67;
  DShopGrid2.left := 518;
  DShopGrid2.Width := 88;
  DShopGrid2.Height := 318;
  DShopGrid2.Visible := True;
{$ELSE}
  d := g_WMain99Images.Images[192];
  if d <> nil then begin
    DShopWin.SetImgIndex(g_WMain99Images, 192);
    DShopWin.Left := g_FScreenXOrigin - d.Width div 2;
    DShopWin.Top := g_FScreenYOrigin - d.Height div 2;
  end;

  DBotShopClose.SetImgIndex(g_WMain99Images, 143);
  DBotShopClose.Left := 777;
  DBotShopClose.Top := 24;

  DShopGameGold.SetImgIndex(g_WMain99Images, 193);
  DShopGameGold.Left := 33;
  DShopGameGold.Top := 19;
  DShopGameGold.Caption := g_sGamePointName + '区';

  DShopGamePoint.SetImgIndex(g_WMain99Images, 193);
  DShopGamePoint.Left := 110;
  DShopGamePoint.Top := 19;
  DShopGamePoint.Caption :=  g_sGameGoldName + '区';
  
  DShopGold.SetImgIndex(g_WMain99Images, 193);
  DShopGold.Left := 185;
  DShopGold.Top := 19;
  DShopGold.Caption :=  g_sGoldName + '区';

  DBotList1.SetImgIndex(g_WMain99Images, 210);
  DBotList1.Left := 242;
  DBotList1.Top := 46;
  DBotList2.SetImgIndex(g_WMain99Images, 210);
  DBotList2.Left := 242 + 80 * 1;
  DBotList2.Top := 46;
  DBotList3.SetImgIndex(g_WMain99Images, 210);
  DBotList3.Left := 242 + 80 * 2;
  DBotList3.Top := 46;
  DBotList4.SetImgIndex(g_WMain99Images, 210);
  DBotList4.Left := 242 + 80 * 3;
  DBotList4.Top := 46;
  DBotList5.SetImgIndex(g_WMain99Images, 210);
  DBotList5.Left := 242 + 80 * 4;
  DBotList5.Top := 46;
  DBotList6.SetImgIndex(g_WMain99Images, 210);
  DBotList6.Left := 242 + 80 * 5;
  DBotList6.Top := 46;

  with DEditShopCount do begin
    Height := 16;
    Width := 80;
    Left := 36;
    Top := 327;
    Visible := True;
  end;

  DBuyAdd.SetImgIndex(g_WMain99Images, 21);
  DBuyAdd.Left := 129;
  DBuyAdd.Top := 329;
  DBuyDel.SetImgIndex(g_WMain99Images, 22);
  DBuyDel.Left := 145;
  DBuyDel.Top := 329;

  DBotBuy.SetImgIndex(g_WMain99Images, 198);
  DBotBuy.Left := 59;
  DBotBuy.Top := 451;
  DBotBuy.OnDirectPaint := nil;

  DShopGetGamePoint.SetImgIndex(g_WMain99Images, 198);
  DShopGetGamePoint.Left := 31;
  DShopGetGamePoint.Top := 545;
  DShopGetGamePoint.Caption := '对换' + g_sGameGoldName;



  DButFront.SetImgIndex(g_WMain99Images, 204);
  DButFront.Left := 538;
  DButFront.Top := 84;
  DButNext.SetImgIndex(g_WMain99Images, 204);
  DButNext.Left := 651;
  DButNext.Top := 84;
  DButFront2.SetImgIndex(g_WMain99Images, 204);
  DButFront2.Left := 538;
  DButFront2.Top := 551;
  DButNext2.SetImgIndex(g_WMain99Images, 204);
  DButNext2.Left := 651;
  DButNext2.Top := 551;

  DShopGrid.Top := 115;
  DShopGrid.left := 189;
  DShopGrid.Width := 588;
  DShopGrid.Height := 430;  
{$IFEND}

  //收件箱
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1644];
  if d <> nil then begin
    DWinEmail.SetImgIndex(g_WMain99Images, 1644);
    DWinEmail.Left := g_FScreenWidth - d.Width;
    DWinEmail.Top := g_FScreenHeight - d.Height - 200;
  end;
  DEMailClose.SetImgIndex(g_WMain99Images, 1850);
  DEMailClose.Left := 294;
  DEMailClose.Top := 0;

  DEMailRead.SetImgIndex(g_WMain99Images, 1652);
  DEMailRead.Left := 16;
  DEMailRead.Top := 313;
  DEMailNew.SetImgIndex(g_WMain99Images, 1652);
  DEMailNew.Left := 78;
  DEMailNew.Top := 313;
  DEMailNew.OnDirectPaint := DEMailReadDirectPaint;
  DEMailDel.SetImgIndex(g_WMain99Images, 1652);
  DEMailDel.Left := 140;
  DEMailDel.Top := 313;
  DEMailDel.OnDirectPaint := DEMailReadDirectPaint;
  DEMailDelAll.SetImgIndex(g_WMain99Images, 1650);
  DEMailDelAll.Left := 202;
  DEMailDelAll.Top := 313;
  DEMailDelAll.OnDirectPaint := DEMailReadDirectPaint;

  DEMailGrid.Left := 19;
  DEMailGrid.Top := 69;
  DEMailGrid.Width := 245;
  DEMailGrid.Height := 232;
  DEMailGrid.Rowoffset := 3;
  {DUpDownEMail.SetImgIndex(g_WMain99Images, 120);
  DUpDownEMail.Top := 61;
  DUpDownEMail.Left := 265;
  DUpDownEMail.Height := 256;

  DUpDownEMail.UpButton.SetImgIndex(g_WMain99Images, 108);
  DUpDownEMail.DownButton.SetImgIndex(g_WMain99Images, 111);
  DUpDownEMail.MoveButton.SetImgIndex(g_WMain99Images, 114);   }

  DUpDownEMail.SetImgIndex(g_WMain99Images, 120);
  DUpDownEMail.Top := 67;
  DUpDownEMail.Left := 267;
  DUpDownEMail.Height := 236;
  DUpDownEMail.Offset := 1;
  DUpDownEMail.Normal := True;

  DUpDownEMail.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DUpDownEMail.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DUpDownEMail.MoveButton.SetImgIndex(g_WMain99Images, 2144); //114
{$ELSE}
  d := g_WMain99Images.Images[554];
  if d <> nil then begin
    DWinEmail.SetImgIndex(g_WMain99Images, 554);
    DWinEmail.Left := 507;
    DWinEmail.Top := 150;
  end;
  DEMailClose.SetImgIndex(g_WMain99Images, 133);
  DEMailClose.Left := DWinEmail.Width - 18;
  DEMailClose.Top := 8 + 4;

  DEMailRead.SetImgIndex(g_WMain99Images, 147);
  DEMailRead.Left := 15;
  DEMailRead.Top := 324;
  DEMailRead.OnDirectPaint := nil;
  DEMailNew.SetImgIndex(g_WMain99Images, 147);
  DEMailNew.Left := 74;
  DEMailNew.Top := 324;
  DEMailDel.SetImgIndex(g_WMain99Images, 147);
  DEMailDel.Left := 133;
  DEMailDel.Top := 324;
  DEMailDelAll.SetImgIndex(g_WMain99Images, 330);
  DEMailDelAll.Left := 202;
  DEMailDelAll.Top := 324;

  DEMailGrid.Left := 13;
  DEMailGrid.Top := 65;
  DEMailGrid.Width := 248;
  DEMailGrid.Height := 246;

  DUpDownEMail.SetImgIndex(g_WMain99Images, 120);
  DUpDownEMail.Top := 61;
  DUpDownEMail.Left := 265;
  DUpDownEMail.Height := 256;

  DUpDownEMail.UpButton.SetImgIndex(g_WMain99Images, 108);
  DUpDownEMail.DownButton.SetImgIndex(g_WMain99Images, 111);
  DUpDownEMail.MoveButton.SetImgIndex(g_WMain99Images, 114);  
{$IFEND}

  //问读信件
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1647];
  if d <> nil then begin
    DWndEMailRead.SetImgIndex(g_WMain99Images, 1647);
    DWndEMailRead.Left := DWinEmail.Left - d.Width - 1;
    DWndEMailRead.Top := DWinEmail.Top;
  end;
  DEMailReadClose.SetImgIndex(g_WMain99Images, 1850);
  DEMailReadClose.Left := 267;
  DEMailReadClose.Top := 0;

  DEMailReadBack.SetImgIndex(g_WMain99Images, 1650);
  DEMailReadBack.Left := 41;
  DEMailReadBack.Top := 339;
  DEMailReadBack.OnDirectPaint := DEMailReadDirectPaint;
  DEMailReadDel.SetImgIndex(g_WMain99Images, 1650);
  DEMailReadDel.Left := 151;
  DEMailReadDel.Top := 339;
  DEMailReadDel.OnDirectPaint := DEMailReadDirectPaint;

  DEMailReadItem.Top := 275;
  DEMailReadItem.Left := 25;
  DEMailReadItem.Width := 36;
  DEMailReadItem.Height := 34;
  DEMailReadGold.SetImgIndex(g_WMain99Images, 1652);
  DEMailReadGold.Left := 197;
  DEMailReadGold.Top := 243;
  DEMailReadGold.OnDirectPaint := DEMailReadDirectPaint;

  DMemoEMailRead.Top := 96;
  DMemoEMailRead.Left := 19;
  DMemoEMailRead.Width := 237;
  DMemoEMailRead.Height := 127;

  DEMailReadUpDown.SetImgIndex(g_WMain99Images, 120);
  DEMailReadUpDown.Top := DMemoEMailRead.Top;
  DEMailReadUpDown.Left := DMemoEMailRead.Left + DMemoEMailRead.Width - DEMailReadUpDown.Width;
  DEMailReadUpDown.Height := DMemoEMailRead.Height;
  DEMailReadUpDown.Offset := 1;
  DEMailReadUpDown.Normal := True;

  DEMailReadUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DEMailReadUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DEMailReadUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144); //114
{$ELSE}
  d := g_WMain99Images.Images[556];
  if d <> nil then begin
    DWndEMailRead.SetImgIndex(g_WMain99Images, 556);
    DWndEMailRead.Left := 23;
    DWndEMailRead.Top := 84;
  end;
  DEMailReadClose.SetImgIndex(g_WMain99Images, 133);
  DEMailReadClose.Left := DWndEMailRead.Width - 18;
  DEMailReadClose.Top := 8 + 4;

  DEMailReadBack.SetImgIndex(g_WMain99Images, 330);
  DEMailReadBack.Left := 35;
  DEMailReadBack.Top := 391;
  DEMailReadDel.SetImgIndex(g_WMain99Images, 330);
  DEMailReadDel.Left := 135;
  DEMailReadDel.Top := 391;

  DEMailReadItem.Top := 322;
  DEMailReadItem.Left := 21;
  DEMailReadItem.Width := 36;
  DEMailReadItem.Height := 36;
  DEMailReadGold.SetImgIndex(g_WMain99Images, 147);
  DEMailReadGold.Left := 174;
  DEMailReadGold.Top := 295;

  DMemoEMailRead.Top := 96;
  DMemoEMailRead.Left := 22;
  DMemoEMailRead.Width := 200;
  DMemoEMailRead.Height := 176;

  DEMailReadUpDown.SetImgIndex(g_WMain99Images, 120);
  DEMailReadUpDown.Top := DMemoEMailRead.Top;
  DEMailReadUpDown.Left := DMemoEMailRead.Left + DMemoEMailRead.Width - DEMailReadUpDown.Width;
  DEMailReadUpDown.Height := DMemoEMailRead.Height;

  DEMailReadUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DEMailReadUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DEMailReadUpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);  
{$IFEND}

  //写新信件
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1648];
  if d <> nil then begin
    DWndEMailNew.SetImgIndex(g_WMain99Images, 1648);
    DWndEMailNew.Left := DWinEmail.Left - d.Width - 1;
    DWndEMailNew.Top := DWinEmail.Top;
  end;
  DEMailNewClose2.SetImgIndex(g_WMain99Images, 1850);
  DEMailNewClose2.Left := 267;
  DEMailNewClose2.Top := 0;

  DEMailNewAdd.SetImgIndex(g_WMain99Images, 1650);
  DEMailNewAdd.Left := 41;
  DEMailNewAdd.Top := 339;
  DEMailNewAdd.OnDirectPaint := DEMailReadDirectPaint;
  DEMailNewClose.SetImgIndex(g_WMain99Images, 1650);
  DEMailNewClose.Left := 151;
  DEMailNewClose.Top := 339;
  DEMailNewClose.OnDirectPaint := DEMailReadDirectPaint;
  
  DEMailNewItem.Top := 275;
  DEMailNewItem.Left := 25;
  DEMailNewItem.Width := 36;
  DEMailNewItem.Height := 34;

  DEditEMailNewGold.Top := 247;
  DEditEMailNewGold.Left := 64;
  DEditEMailNewGold.Width := 185;
  DEditEMailNewGold.Height := 19;

  DEmailNewMemo.Top := 96;
  DEmailNewMemo.Left := 19;
  DEmailNewMemo.Width := 237;
  DEmailNewMemo.Height := 127;

  DEmailNewUpDown.SetImgIndex(g_WMain99Images, 120);
  DEmailNewUpDown.Top := DEmailNewMemo.Top;
  DEmailNewUpDown.Left := DEmailNewMemo.Left + DEmailNewMemo.Width - DEmailNewUpDown.Width;
  DEmailNewUpDown.Height := DEmailNewMemo.Height;
  DEmailNewUpDown.Offset := 1;
  DEmailNewUpDown.Normal := True;

  DEmailNewUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DEmailNewUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DEmailNewUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144); //114

  DEMailNewEdit.Left := 82;
  DEMailNewEdit.Top := 48;
  DEMailNewEdit.Width := 172;
  DEMailNewEdit.Height := 16;

  

  DEMailNameComboBox.SetImgIndex(g_WMain99Images, 2153);
  DEMailNameComboBox.left := 70;
  DEMailNameComboBox.top := 72;
  DEMailNameComboBox.Height := 16;
  DEMailNameComboBox.width := 184;

  DEMailNameComboBox.UpDown.SetImgIndex(g_WMain99Images, 120);
  DEMailNameComboBox.UpDown.UpButton.SetImgIndex(g_WMain99Images, 1613);
  DEMailNameComboBox.UpDown.DownButton.SetImgIndex(g_WMain99Images, 1616);
  DEMailNameComboBox.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 1610);
  DEMailNameComboBox.UpDown.Offset := 1;
  DEMailNameComboBox.UpDown.Normal := True;

{$ELSE}
  d := g_WMain99Images.Images[555];
  if d <> nil then begin
    DWndEMailNew.SetImgIndex(g_WMain99Images, 555);
    DWndEMailNew.Left := 265;
    DWndEMailNew.Top := 84;
  end;
  DEMailNewClose2.SetImgIndex(g_WMain99Images, 133);
  DEMailNewClose2.Left := DWndEMailNew.Width - 18;
  DEMailNewClose2.Top := 8 + 4;

  DEMailNewAdd.SetImgIndex(g_WMain99Images, 330);
  DEMailNewAdd.Left := 35;
  DEMailNewAdd.Top := 393;
  DEMailNewClose.SetImgIndex(g_WMain99Images, 330);
  DEMailNewClose.Left := 135;
  DEMailNewClose.Top := 393;

  DEMailNewItem.Top := 322;
  DEMailNewItem.Left := 21;
  DEMailNewItem.Width := 36;
  DEMailNewItem.Height := 36;

  DEditEMailNewGold.Top := 297;
  DEditEMailNewGold.Left := 57;
  DEditEMailNewGold.Width := 166;
  DEditEMailNewGold.Height := 16;


  DEmailNewMemo.Top := 96;
  DEmailNewMemo.Left := 22;
  DEmailNewMemo.Width := 200;
  DEmailNewMemo.Height := 176;

  DEmailNewUpDown.SetImgIndex(g_WMain99Images, 120);
  DEmailNewUpDown.Top := 90;
  DEmailNewUpDown.Left := 212;
  DEmailNewUpDown.Height := 183;

  DEmailNewUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DEmailNewUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DEmailNewUpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DEMailNewEdit.Left := 80;
  DEMailNewEdit.Top := 39;
  DEMailNewEdit.Width := 140;
  DEMailNewEdit.Height := 16;

  DEMailNameComboBox.SetImgIndex(g_WMain99Images, 309);
  DEMailNameComboBox.left := 68;
  DEMailNameComboBox.top := 65;
  DEMailNameComboBox.Height := 16;
  DEMailNameComboBox.width := 156;

  DEMailNameComboBox.UpDown.SetImgIndex(g_WMain99Images, 120);
  DEMailNameComboBox.UpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DEMailNameComboBox.UpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DEMailNameComboBox.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);
{$IFEND}

  //好友系统
{$IF Var_Interface = Var_Mir2}
    d := g_WMain99Images.Images[1638];
  if d <> nil then begin
    DWinFriend.SetImgIndex(g_WMain99Images, 1638);
    DWinFriend.Left := 160;
    DWinFriend.Top := g_FScreenHeight - d.Height - 199;
  end;
  DFriClose.SetImgIndex(g_WMain99Images, 1850);
  DFriClose.Left := 169;
  DFriClose.Top := 0;

  DFriFriend.SetImgIndex(g_WMain99Images, 1639);
  DFriFriend.Left := 17;
  DFriFriend.Top := 19;
  DFriBlack.SetImgIndex(g_WMain99Images, 1640);
  DFriBlack.Left := 63;
  DFriBlack.Top := 19;
  DFriSay.SetImgIndex(g_WMain99Images, 1641);
  DFriSay.Left := 109;
  DFriSay.Top := 19;

  DFriWin.Top := 46;
  DFriWin.left := 25;
  DFriWin.Width := 100;
  DFriWin.Height := 176;

  DFriendUpDown.SetImgIndex(g_WMain99Images, 120);
  DFriendUpDown.Top := 43;
  DFriendUpDown.Left := 134;
  DFriendUpDown.Height := 188;
  DFriendUpDown.Offset := 1;
  DFriendUpDown.Normal := True;

  DFriendUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DFriendUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DFriendUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144); //114

  DFriAddMem.SetImgIndex(g_WMain99Images, 1642);
  DFriAddMem.Left := 28;
  DFriAddMem.Top := 240;
  DFriAddMem.OnDirectPaint := DBotShopCloseDirectPaint;
  DFriDelMem.SetImgIndex(g_WMain99Images, 1643);
  DFriDelMem.Left := 88;
  DFriDelMem.Top := 240;
  DFriDelMem.OnDirectPaint := DBotShopCloseDirectPaint;
{$ELSE}
  d := g_WMain99Images.Images[354];
  if d <> nil then begin
    DWinFriend.SetImgIndex(g_WMain99Images, 354);
    DWinFriend.Left := g_FScreenWidth - d.Width;
    DWinFriend.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  DFriClose.SetImgIndex(g_WMain99Images, 133);
  DFriClose.Left := DWinFriend.Width - 20;
  DFriClose.Top := 8 + 4;

  DFriFriend.SetImgIndex(g_WMain99Images, 219);
  DFriFriend.Left := 13;
  DFriFriend.Top := 36 + 4;
  DFriBlack.SetImgIndex(g_WMain99Images, 219);
  DFriBlack.Left := 65;
  DFriBlack.Top := 36 + 4;
  DFriSay.SetImgIndex(g_WMain99Images, 219);
  DFriSay.Left := 117;
  DFriSay.Top := 36 + 4;

  DFriWin.Top := 88 + 4;
  DFriWin.left := 21;
  DFriWin.Width := 122;
  DFriWin.Height := 272;

  DFriendUpDown.SetImgIndex(g_WMain99Images, 120);
  DFriendUpDown.Top := 81 + 4;
  DFriendUpDown.Left := 148;
  DFriendUpDown.Height := 287;

  DFriendUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DFriendUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DFriendUpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);

  DFriAddMem.SetImgIndex(g_WMain99Images, 147);
  DFriAddMem.Left := 27;
  DFriAddMem.Top := 382 + 4;
  DFriDelMem.SetImgIndex(g_WMain99Images, 147);
  DFriDelMem.Left := 101;
  DFriDelMem.Top := 382 + 4;  
{$IFEND}

  //密保卡
  d := g_WMain99Images.Images[366];
  if d <> nil then begin
    DMatrixCardWnd.SetImgIndex(g_WMain99Images, 366);
    DMatrixCardWnd.Left := g_FScreenXOrigin - d.Width div 2;
    DMatrixCardWnd.Top := g_FScreenYOrigin - d.Height div 2;
  end;

  DCardOK.SetImgIndex(g_WMain99Images, 24);
  DCardOK.Left := 46;
  DCardOK.Top := 141;
  DCardClose.SetImgIndex(g_WMain99Images, 24);
  DCardClose.Left := 168;
  DCardClose.Top := 141;

  //上传照片
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1758];
  if d <> nil then begin
    DWinUpLoad.SetImgIndex(g_WMain99Images, 1758);
    DWinUpLoad.Left := g_FScreenXOrigin - d.Width div 2;
    DWinUpLoad.Top := g_FScreenYOrigin - d.Height div 2;
  end;

  DUpLoadClose.SetImgIndex(g_WMain99Images, 1850);
  DUpLoadClose.Left := 392;
  DUpLoadClose.Top := 22;

  DUpLoadTop.SetImgIndex(g_WMain99Images, 414);
  DUpLoadTop.Left := 103;
  DUpLoadTop.Top := 59;
  DUpLoadDown.SetImgIndex(g_WMain99Images, 420);
  DUpLoadDown.Left := 103;
  DUpLoadDown.Top := 227;
  DUpLoadLeft.SetImgIndex(g_WMain99Images, 417);
  DUpLoadLeft.Left := 20;
  DUpLoadLeft.Top := 152;
  DUpLoadRight.SetImgIndex(g_WMain99Images, 423);
  DUpLoadRight.Left := 166;
  DUpLoadRight.Top := 152;

  DUpLoadOk.SetImgIndex(g_WMain99Images, 1759);
  DUpLoadOk.Left := 239;
  DUpLoadOk.Top := 247;
  DUpLoadOK.OnDirectPaint := DBotBuyDirectPaint;
  DUpLoadExit.SetImgIndex(g_WMain99Images, 1762);
  DUpLoadExit.Left := 323;
  DUpLoadExit.Top := 247;

  DUpLoadImage.Top := 101;
  DUpLoadImage.Left := 62;
  DUpLoadImage.Width := 100;
  DUpLoadImage.Height := 120;

  DUpLoadFileList.Top := 60;
  DUpLoadFileList.Left := 222;
  DUpLoadFileList.Width := 167;
  DUpLoadFileList.Height := 180;

  DUpDownUpLoad.SetImgIndex(g_WMain99Images, 120);
  DUpDownUpLoad.Top := 59;
  DUpDownUpLoad.Left := 389;
  DUpDownUpLoad.Height := 182;
  DUpDownUpLoad.Offset := 1;
  DUpDownUpLoad.Normal := True;

  DUpDownUpLoad.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DUpDownUpLoad.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DUpDownUpLoad.MoveButton.SetImgIndex(g_WMain99Images, 2144);
{$ELSE}
  d := g_WMain99Images.Images[258];
  if d <> nil then begin
    DWinUpLoad.SetImgIndex(g_WMain99Images, 258);
    DWinUpLoad.Left := g_FScreenXOrigin - d.Width div 2;
    DWinUpLoad.Top := 60;
  end;

  DUpLoadClose.SetImgIndex(g_WMain99Images, 133);
  DUpLoadClose.Left := DWinUpLoad.Width - 20;
  DUpLoadClose.Top := 8 + 4;

  DUpLoadTop.SetImgIndex(g_WMain99Images, 414);
  DUpLoadTop.Left := 108;
  DUpLoadTop.Top := 71;
  DUpLoadDown.SetImgIndex(g_WMain99Images, 420);
  DUpLoadDown.Left := 108;
  DUpLoadDown.Top := 242;
  DUpLoadLeft.SetImgIndex(g_WMain99Images, 417);
  DUpLoadLeft.Left := 25;
  DUpLoadLeft.Top := 165;
  DUpLoadRight.SetImgIndex(g_WMain99Images, 423);
  DUpLoadRight.Left := 176;
  DUpLoadRight.Top := 165;

  DUpLoadOk.SetImgIndex(g_WMain99Images, 330);
  DUpLoadOk.Left := 250;
  DUpLoadOk.Top := 260;
  DUpLoadExit.SetImgIndex(g_WMain99Images, 330);
  DUpLoadExit.Left := 336;
  DUpLoadExit.Top := 260;
  DUpLoadExit.OnDirectPaint := nil;

  DUpLoadImage.Top := 115;
  DUpLoadImage.Left := 69;
  DUpLoadImage.Width := 100;
  DUpLoadImage.Height := 120;

  DUpLoadFileList.Top := 71;
  DUpLoadFileList.Left := 236;
  DUpLoadFileList.Width := 167;
  DUpLoadFileList.Height := 180;

  DUpDownUpLoad.SetImgIndex(g_WMain99Images, 120);
  DUpDownUpLoad.Top := 71;
  DUpDownUpLoad.Left := 403;
  DUpDownUpLoad.Height := 180;

  DUpDownUpLoad.UpButton.SetImgIndex(g_WMain99Images, 108);
  DUpDownUpLoad.DownButton.SetImgIndex(g_WMain99Images, 111);
  DUpDownUpLoad.MoveButton.SetImgIndex(g_WMain99Images, 114);  
{$IFEND}

  //摆摊界面
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1722];
  if d <> nil then begin
    DWndUserShop.SetImgIndex(g_WMain99Images, 1722);
    DWndUserShop.Left := g_FScreenWidth - d.Width;
    DWndUserShop.Top := g_FScreenYOrigin - d.Height div 2;
  end;

  DUserShopSellGrid.Top := 57;
  DUserShopSellGrid.Left := 28;
  DUserShopSellGrid.Width := 147;
  DUserShopSellGrid.Height := 111;
  DUserShopSellGrid.ColWidth := 33;
  DUserShopSellGrid.RowHeight := 31;
  DUserShopSellGrid.Coloffset := 5;
  DUserShopSellGrid.Rowoffset := 9;

  DUserShopBuyGrid.Top := 57;
  DUserShopBuyGrid.Left := 196;
  DUserShopBuyGrid.Width := 147;
  DUserShopBuyGrid.Height := 111;
  DUserShopBuyGrid.ColWidth := 33;
  DUserShopBuyGrid.RowHeight := 31;
  DUserShopBuyGrid.Coloffset := 5;
  DUserShopBuyGrid.Rowoffset := 9;

  DUserShopClose2.SetImgIndex(g_WMain99Images, 1850);
  DUserShopClose2.Left := 369;
  DUserShopClose2.Top := 2;

  DUserSellShopClear.SetImgIndex(g_WMain99Images, 1650);
  DUserSellShopClear.Left := 190;
  DUserSellShopClear.Top := 177;
  DUserSellShopClear.OnDirectPaint := DEMailReadDirectPaint;
  DUserBuyShopClear.SetImgIndex(g_WMain99Images, 1650);
  DUserBuyShopClear.Left := 269;
  DUserBuyShopClear.Top := 177;
  DUserBuyShopClear.OnDirectPaint := DEMailReadDirectPaint;
  DUserShopClose.SetImgIndex(g_WMain99Images, 1650);
  DUserShopClose.Left := 269;
  DUserShopClose.Top := 202;
  DUserShopClose.OnDirectPaint := DEMailReadDirectPaint;
  DUserShopOpen.SetImgIndex(g_WMain99Images, 1650);
  DUserShopOpen.Left := 190;
  DUserShopOpen.Top := 202;
  DUserShopOpen.OnDirectPaint := DEMailReadDirectPaint;


  DUserShopMemo.Top := 258;
  DUserShopMemo.Left := 23;
  DUserShopMemo.Width := 326;
  DUserShopMemo.Height := 92;

  DUpDownUserShop.SetImgIndex(g_WMain99Images, 120);
  DUpDownUserShop.Top := DUserShopMemo.Top;
  DUpDownUserShop.Left := DUserShopMemo.Left + DUserShopMemo.Width - DUpDownUserShop.Width;
  DUpDownUserShop.Height := DUserShopMemo.Height;
  DUpDownUserShop.Offset := 1;
  DUpDownUserShop.Normal := True;

  DUpDownUserShop.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DUpDownUserShop.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DUpDownUserShop.MoveButton.SetImgIndex(g_WMain99Images, 2144);
{$ELSE}
  d := g_WMain99Images.Images[432];
  if d <> nil then begin
    DWndUserShop.SetImgIndex(g_WMain99Images, 432);
    DWndUserShop.Left := 0;
    DWndUserShop.Top := 64;
  end;

  DUserShopSellGrid.Top := 73;
  DUserShopSellGrid.Left := 28;
  DUserShopSellGrid.Width := 139;
  DUserShopSellGrid.Height := 104;

  DUserShopBuyGrid.Top := 73;
  DUserShopBuyGrid.Left := 203;
  DUserShopBuyGrid.Width := 139;
  DUserShopBuyGrid.Height := 104;

  DUserShopClose2.SetImgIndex(g_WMain99Images, 133);
  DUserShopClose2.Left := DWndUserShop.Width - 20;
  DUserShopClose2.Top := 8 + 4;

  DUserSellShopClear.SetImgIndex(g_WMain99Images, 330);
  DUserSellShopClear.Left := 191;
  DUserSellShopClear.Top := 194;
  DUserBuyShopClear.SetImgIndex(g_WMain99Images, 330);
  DUserBuyShopClear.Left := 283;
  DUserBuyShopClear.Top := 194;
  DUserShopClose.SetImgIndex(g_WMain99Images, 330);
  DUserShopClose.Left := 283;
  DUserShopClose.Top := 217;
  DUserShopOpen.SetImgIndex(g_WMain99Images, 330);
  DUserShopOpen.Left := 191;
  DUserShopOpen.Top := 217;


  DUserShopMemo.Top := 265;
  DUserShopMemo.Left := 24;
  DUserShopMemo.Width := 322;
  DUserShopMemo.Height := 85;

  DUpDownUserShop.SetImgIndex(g_WMain99Images, 120);
  DUpDownUserShop.Top := DUserShopMemo.Top;
  DUpDownUserShop.Left := DUserShopMemo.Left + DUserShopMemo.Width - DUpDownUserShop.Width;
  DUpDownUserShop.Height := DUserShopMemo.Height;

  DUpDownUserShop.UpButton.SetImgIndex(g_WMain99Images, 108);
  DUpDownUserShop.DownButton.SetImgIndex(g_WMain99Images, 111);
  DUpDownUserShop.MoveButton.SetImgIndex(g_WMain99Images, 114);
{$IFEND}

  //摆摊界面(查看)
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1723];
  if d <> nil then begin
    DReadUserShop.SetImgIndex(g_WMain99Images, 1723);
    DReadUserShop.Left := g_FScreenXOrigin - d.Width div 2;
    DReadUserShop.Top := g_FScreenYOrigin - d.Height div 2;
  end;

  DReadShopClose.SetImgIndex(g_WMain99Images, 1850);
  DReadShopClose.Left := 369;
  DReadShopClose.Top := 2;

  DReadShopSellGrid.Top := 57;
  DReadShopSellGrid.Left := 28;
  DReadShopSellGrid.Width := 147;
  DReadShopSellGrid.Height := 111;
  DReadShopSellGrid.ColWidth := 33;
  DReadShopSellGrid.RowHeight := 31;
  DReadShopSellGrid.Coloffset := 5;
  DReadShopSellGrid.Rowoffset := 9;

  DReadShopBuyGrid.Top := 57;
  DReadShopBuyGrid.Left := 196;
  DReadShopBuyGrid.Width := 147;
  DReadShopBuyGrid.Height := 111;
  DReadShopBuyGrid.ColWidth := 33;
  DReadShopBuyGrid.RowHeight := 31;
  DReadShopBuyGrid.Coloffset := 5;
  DReadShopBuyGrid.Rowoffset := 9;

  DReadShopEdit.Top := 337;
  DReadShopEdit.Left := 66;
  DReadShopEdit.Width := 275;
  DReadShopEdit.Height := 16;

  DReadShopMemo.Top := 205;
  DReadShopMemo.Left := 23;
  DReadShopMemo.Width := 326;
  DReadShopMemo.Height := 92;

  DReadShopUpDown.SetImgIndex(g_WMain99Images, 120);
  DReadShopUpDown.Top := DReadShopMemo.Top;
  DReadShopUpDown.Left := DReadShopMemo.Left + DReadShopMemo.Width - DReadShopUpDown.Width;
  DReadShopUpDown.Height := DReadShopMemo.Height;
  DReadShopUpDown.Offset := 1;
  DReadShopUpDown.Normal := True;

  DReadShopUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DReadShopUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DReadShopUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);
{$ELSE}
  d := g_WMain99Images.Images[433];
  if d <> nil then begin
    DReadUserShop.SetImgIndex(g_WMain99Images, 433);
    DReadUserShop.Left := 20;
    DReadUserShop.Top := 64;
  end;

  DReadShopClose.SetImgIndex(g_WMain99Images, 133);
  DReadShopClose.Left := DReadUserShop.Width - 20;
  DReadShopClose.Top := 8 + 4;

  DReadShopSellGrid.Top := 73;
  DReadShopSellGrid.Left := 28;
  DReadShopSellGrid.Width := 139;
  DReadShopSellGrid.Height := 104;

  DReadShopBuyGrid.Top := 73;
  DReadShopBuyGrid.Left := 203;
  DReadShopBuyGrid.Width := 139;
  DReadShopBuyGrid.Height := 104;

  DReadShopEdit.Top := 310;
  DReadShopEdit.Left := 57;
  DReadShopEdit.Width := 288;
  DReadShopEdit.Height := 18;

  DReadShopMemo.Top := 219;
  DReadShopMemo.Left := 24;
  DReadShopMemo.Width := 322;
  DReadShopMemo.Height := 85;

  DReadShopUpDown.SetImgIndex(g_WMain99Images, 120);
  DReadShopUpDown.Top := DReadShopMemo.Top;
  DReadShopUpDown.Left := DReadShopMemo.Left + DReadShopMemo.Width - DReadShopUpDown.Width;
  DReadShopUpDown.Height := DReadShopMemo.Height;

  DReadShopUpDown.UpButton.SetImgIndex(g_WMain99Images, 108);
  DReadShopUpDown.DownButton.SetImgIndex(g_WMain99Images, 111);
  DReadShopUpDown.MoveButton.SetImgIndex(g_WMain99Images, 114);
{$IFEND}

  //仓库列表
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1728];
  if d <> nil then begin
    DStorageDlg.SetImgIndex(g_WMain99Images, 1728);
    DStorageDlg.Left := 0;
    DStorageDlg.Top := 74;
  end;
  DStorageClose.SetImgIndex(g_WMain99Images, 1850);
  DStorageClose.Left := 302;
  DStorageClose.Top := 0;

  DStorageGetGold.SetImgIndex(g_WMain99Images, 1652);
  DStorageGetGold.Left := 173;
  DStorageGetGold.Top := 289;
  DStorageGetGold.OnDirectPaint := DEMailReadDirectPaint;
  DStorageSaveGold.SetImgIndex(g_WMain99Images, 1652);
  DStorageSaveGold.Left := 234;
  DStorageSaveGold.Top := 289;
  DStorageSaveGold.OnDirectPaint := DEMailReadDirectPaint;

  DStorage1.SetImgIndex(g_WMain99Images, 1729);
  DStorage1.Left := 22;
  DStorage1.Top := 20;
  DStorage2.SetImgIndex(g_WMain99Images, 1730);
  DStorage2.Left := 80;
  DStorage2.Top := 20;
  DStorage3.SetImgIndex(g_WMain99Images, 1731);
  DStorage3.Left := 138;
  DStorage3.Top := 20; 
  
  DStorage4.SetImgIndex(g_WMain99Images, 219);
  DStorage4.Left := 175;
  DStorage4.Top := 38;
  DStorage5.SetImgIndex(g_WMain99Images, 219);
  DStorage5.Left := 229;
  DStorage5.Top := 38;

  DStorageGrid.Left := 27;
  DStorageGrid.Top := 50;
  DStorageGrid.Width := 249;
  DStorageGrid.Height := 222;
  DStorageGrid.ColWidth := 33;
  DStorageGrid.RowHeight := 30;
  DStorageGrid.Coloffset := 3;
  DStorageGrid.Rowoffset := 2;
{$ELSE}
  d := g_WMain99Images.Images[336];
  if d <> nil then begin
    DStorageDlg.SetImgIndex(g_WMain99Images, 336);
    DStorageDlg.Left := 0;
    DStorageDlg.Top := 74;
  end;
  DStorageClose.SetImgIndex(g_WMain99Images, 133);
  DStorageClose.Left := DStorageDlg.Width - 20;
  DStorageClose.Top := 8 + 4;

  DStorageGetGold.SetImgIndex(g_WMain99Images, 147);
  DStorageGetGold.Left := 174;
  DStorageGetGold.Top := 333;
  DStorageSaveGold.SetImgIndex(g_WMain99Images, 147);
  DStorageSaveGold.Left := 229;
  DStorageSaveGold.Top := 333;

  DStorage1.SetImgIndex(g_WMain99Images, 219);
  DStorage1.Left := 13;
  DStorage1.Top := 38;
  DStorage2.SetImgIndex(g_WMain99Images, 219);
  DStorage2.Left := 67;
  DStorage2.Top := 38;
  DStorage3.SetImgIndex(g_WMain99Images, 219);
  DStorage3.Left := 121;
  DStorage3.Top := 38;
  DStorage4.SetImgIndex(g_WMain99Images, 219);
  DStorage4.Left := 175;
  DStorage4.Top := 38;
  DStorage5.SetImgIndex(g_WMain99Images, 219);
  DStorage5.Left := 229;
  DStorage5.Top := 38;

  DStorageGrid.Left := 23;
  DStorageGrid.Top := 72;
  DStorageGrid.Width := 244;
  DStorageGrid.Height := 244;  
{$IFEND}

  //死亡窗口
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1713];
  if d <> nil then begin
    DWndDeath.SetImgIndex(g_WMain99Images, 1713);
    DWndDeath.Left := g_FScreenXOrigin - d.Width div 2;
    DWndDeath.Top := g_FScreenYOrigin - d.Height div 2;
  end;
  dbtnAcceptCure.SetImgIndex(g_WMain99Images, 1650);
  dbtnAcceptCure.Left := 17;
  dbtnAcceptCure.Top := 21;
  dbtnAcceptCure.OnDirectPaint := DEMailReadDirectPaint;


  dbtnAtOnceCure.SetImgIndex(g_WMain99Images, 1650);
  dbtnAtOnceCure.Left := 17;
  dbtnAtOnceCure.Top := 55;
  dbtnAtOnceCure.OnDirectPaint := DEMailReadDirectPaint;
  dbtnBackCure.SetImgIndex(g_WMain99Images, 1650);
  dbtnBackCure.Left := 17;
  dbtnBackCure.Top := 81;
  dbtnBackCure.OnDirectPaint := DEMailReadDirectPaint;
{$ELSE}
  d := g_WMain99Images.Images[232];
  if d <> nil then begin
    DWndDeath.SetImgIndex(g_WMain99Images, 232);
    DWndDeath.Left := (g_FScreenWidth- d.Width) div 2 - 5;
    DWndDeath.Top := g_FScreenHeight div 2 + g_FScreenYOrigin div 2 - d.Height div 2 - 10;
  end;
  dbtnAcceptCure.SetImgIndex(g_WMain99Images, 330);
  dbtnAcceptCure.Left := 21;
  dbtnAcceptCure.Top := 21;

  dbtnAtOnceCure.SetImgIndex(g_WMain99Images, 330);
  dbtnAtOnceCure.Left := 21;
  dbtnAtOnceCure.Top := 55;
  dbtnBackCure.SetImgIndex(g_WMain99Images, 330);
  dbtnBackCure.Left := 21;
  dbtnBackCure.Top := 81;  
{$IFEND}

  //进度条窗口
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1627];
  if d <> nil then begin
    DWndBar.SetImgIndex(g_WMain99Images, 1627);
    DWndBar.Left := g_FScreenXOrigin - d.Width div 2 - 5;
    DWndBar.Top := g_FScreenHeight - d.Height - 205;
  end;
{$ELSE}
  d := g_WMain99Images.Images[230];
  if d <> nil then begin
    DWndBar.SetImgIndex(g_WMain99Images, 230);
    DWndBar.Left := g_FScreenXOrigin - d.Width div 2 - 5;
    DWndBar.Top := g_FScreenHeight div 2 + g_FScreenYOrigin div 2 - d.Height div 2 - 10;
  end;
{$IFEND}

  //浏览窗口
  {d := g_WMain99Images.Images[576];
  if d <> nil then begin
    DWndWeb.SetImgIndex(g_WMain99Images, 576);

  end;   }
  DWndWeb.Left := 0;
  DWndWeb.Top := 0;
  DWndWeb.Width := g_FScreenWidth;
  DWndWeb.Height := g_FScreenHeight;
  dBtWebClose.SetImgIndex(g_WMain99Images, 143);
  dBtWebClose.Left := g_FScreenWidth - dBtWebClose.Width;
  dBtWebClose.Top := 0;

  {dbtnSelectChr.SetImgIndex(g_WMain99Images, 330);
  dbtnSelectChr.Left := 27;
  dbtnSelectChr.Top := 156;
  dbtnExitGame.SetImgIndex(g_WMain99Images, 330);
  dbtnExitGame.Left := 27;
  dbtnExitGame.Top := 182;   }

  //系统选项
  d := g_WMain99Images.Images[232];
  if d <> nil then begin
    dwndSysSetup.SetImgIndex(g_WMain99Images, 232);
    dwndSysSetup.Left := 675;
    dwndSysSetup.Top := 433;
  end;
  dbtnGameSetup.SetImgIndex(g_WMain99Images, 330);
  dbtnGameSetup.Left := 21;
  dbtnGameSetup.Top := 21;
{$IF Var_Interface = Var_Mir2}
  dbtnSelectChr.SetImgIndex(g_WMain99Images, 1855);
  dbtnSelectChr.Left := FrmDlg.DBottom.Width - 266;
  dbtnSelectChr.Top := 104;
  if dbtnSelectChr.DParent <> nil then dbtnSelectChr.DParent.DelChild(dbtnSelectChr);
  dbtnSelectChr.DParent := FrmDlg.DBottom;
  FrmDlg.DBottom.AddChild(dbtnSelectChr);
  dbtnSelectChr.OnMouseMove := FrmDlg.DMyStateMouseMove;
  dbtnExitGame.SetImgIndex(g_WMain99Images, 1857);
  dbtnExitGame.Left := FrmDlg.DBottom.Width - 236;
  dbtnExitGame.Top := 104;
  if dbtnExitGame.DParent <> nil then dbtnExitGame.DParent.DelChild(dbtnExitGame);
  dbtnExitGame.DParent := FrmDlg.DBottom;
  FrmDlg.DBottom.AddChild(dbtnExitGame);
  dbtnExitGame.OnDirectPaint := dbtnSelectChrDirectPaint;
  dbtnExitGame.OnMouseMove := FrmDlg.DMyStateMouseMove;
{$ELSE}
  dbtnSelectChr.SetImgIndex(g_WMain99Images, 330);
  dbtnSelectChr.Left := 21;
  dbtnSelectChr.Top := 56;
  dbtnSelectChr.OnDirectPaint := nil;
  dbtnExitGame.SetImgIndex(g_WMain99Images, 330);
  dbtnExitGame.Left := 21;
  dbtnExitGame.Top := 82;
{$IFEND}

end;

procedure TFrmDlg2.InitializeEx();
begin
  IconButtonList.CreateSurface(nil);
  DWndGroupMember.CreateSurface(nil);
  DWndHint.CreateSurface(nil);
end;

procedure TFrmDlg2.OpenNewMail(UserName: string);
var
  i: integer;
begin
  if EMailNewItem.Item.s.name <> '' then
    AddItemBag(EMailNewItem.Item, EMailNewItem.Index2);
  DEMailNewEdit.Text := '';
  DEmailNewMemo.Lines.Clear;
  DEMailNameComboBox.Item.Clear;
  DEMailNameComboBox.Item.Add('请选择好友');
  DEditEMailNewGold.Value := 0;
  for i := 0 to g_FriendList.Count - 1 do
    DEMailNameComboBox.Item.Add(g_FriendList[i]);
  DEMailNameComboBox.ItemIndex := 0;
  //DEMailNameComboBox.Text := '';
  if UserName <> '' then begin
    for I := 0 to DEMailNameComboBox.Item.Count - 1 do begin
      if CompareText(DEMailNameComboBox.Item[i], UserName) = 0 then begin
        //DEMailNameComboBox.Text := UserName;
        DEMailNameComboBox.ItemIndex := I;
        break;
      end;
    end;
  end;
  DWndEMailNew.Visible := True;
end;

procedure TFrmDlg2.OpenReadMail(EMailInfo: pTEMailInfo);
var
  str: string;
begin
  ReadEMailInfo := EMailInfo^;
  DMemoEMailRead.Lines.Clear;
  while True do begin
    if ReadEMailInfo.sText = '' then
      break;
    ReadEMailInfo.sText := GetValidStr3(ReadEMailInfo.sText, str, [#13]);
    DMemoEMailRead.Lines.Add(str);
  end;
  DWndEMailRead.Visible := True;
end;

procedure TFrmDlg2.OpenWeb(sUrl: string; nWidth, nHeight: Integer);
begin
  FsUrl := sUrl;
  //DScreen.AddSysMsg(FsUrl, clWhite);
  DWndWeb.Width := _MIN(nWidth, g_FScreenWidth);
  DWndWeb.Height := _MIN(nHeight, g_FScreenHeight);
  DWndWeb.Left := g_FScreenXOrigin - nWidth div 2;
  DWndWeb.Top := g_FScreenYOrigin - nHeight div 2;
  dBtWebClose.Left := nWidth - dBtWebClose.Width;
  FrmWeb.Left := DWndWeb.Left + 4;
  FrmWeb.Top := DWndWeb.Top + 38;
  FrmWeb.ClientWidth := nWidth - 8;
  FrmWeb.ClientHeight := nHeight - 52;
  if sUrl <> '' then
    DWndWeb.Visible := True;
end;

procedure TFrmDlg2.RefShopSellItems;
var
  i: integer;
begin
  for I := Low(g_MyShopSellItems) to High(g_MyShopSellItems) do begin
    if g_MyShopSellItems[i].ShopItem.Item.s.Name <> '' then begin
      if not GetItemBag(g_MyShopSellItems[i].ShopItem.Item, g_MyShopSellItems[i].ShopItem.Index2) then
        g_MyShopSellItems[i].ShopItem.Item.s.Name := '';
    end;
  end;
end;

procedure TFrmDlg2.DBotBuyClick(Sender: TObject; X, Y: Integer);
var
  ShopItem: pTShopItem;
  //nIdx: Integer;
begin
  if (g_ShopBuyItem <> nil) or (not (ShopSelectIndex in [0..5])) then exit;
  if ShopMoneyType = 2 then begin
    if (ShopSelectIdx >= 0) and (ShopSelectIdx < g_ShopGoldList[ShopSelectIndex].Count) then begin
      ShopItem := g_ShopGoldList[ShopSelectIndex][ShopSelectIdx];
      if FrmDlg.DMessageDlg(Format('是否确定购买物品 %s ？', [ShopItem.CLientItem.s.Name]), [mbYes, mbNo]) = mrYes
      then begin
        if DEditShopCount.Value > 0 then begin
          g_ShopBuyItem := ShopItem;
          FrmMain.SendShopBuyItem(DEditShopCount.Value, ShopItem.nIndex, ShopItem.CLientItem.s.Idx + 1, ShopMoneyType);
        end else
          FrmDlg.DMessageDlg('[失败]：购买数量必需大于0。', [mbYes]);
      end;
    end;
  end else begin
    if (ShopSelectIdx >= 0) and (ShopSelectIdx < g_ShopList[ShopSelectIndex].Count) then begin
      ShopItem := g_ShopList[ShopSelectIndex][ShopSelectIdx];
      //if FrmDlg.DMessageDlg(Format('是否确定购买物品 %s %d %d？', [ShopItem.CLientItem.s.Name, ShopItem.CLientItem.UserItem.EffectValue.btEffect, ShopItem.CLientItem.s.Effect]), [mbYes, mbNo]) = mrYes
      if FrmDlg.DMessageDlg(Format('是否确定购买物品 %s ？', [ShopItem.CLientItem.s.Name]), [mbYes, mbNo]) = mrYes
      then begin
        if DEditShopCount.Value > 0 then begin
          g_ShopBuyItem := ShopItem;
          FrmMain.SendShopBuyItem(DEditShopCount.Value, ShopItem.nIndex, ShopItem.CLientItem.s.Idx + 1, ShopMoneyType);

        end else
          FrmDlg.DMessageDlg('[失败]：购买数量必需大于0。', [mbYes]);
      end;
    end;
  end;
end;

procedure TFrmDlg2.DBotBuyDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: Integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if WLib <> nil then begin
      if not Enabled then begin
        d := WLib.Images[FaceIndex + 2];
      end else
      if Downed then begin
        d := WLib.Images[FaceIndex + 1];
      end else begin
        d := WLib.Images[FaceIndex];
      end;
      if d <> nil then
        dsurface.Draw(ax, ay, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg2.DBotList1Click(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if ShopIndex <> Tag then begin
      ShopIndex := Tag;
      ShopPage := 0;
      ShopSelectIdx := -1;
      ShopSelectIndex := -1;
      PlaySound(s_glass_button_click);
      //FrmMain.SendShopList(ShopIndex, g_ShopLoading[ShopIndex]);
    end;
  end;
end;

procedure TFrmDlg2.DBotList1DirectPaint(Sender: TObject; dsurface: TDXTexture);
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
      if ShopIndex = tag then begin
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
      if ShopIndex <> tag then begin
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

procedure TFrmDlg2.DBotShopCloseClick(Sender: TObject; X, Y: Integer);
var
  d: TDButton;
begin
  if Sender is TDButton then begin
    d := TDButton(Sender);
    if d.DParent <> nil then
      d.DParent.Visible := False;
  end;
end;

procedure TFrmDlg2.DBotShopCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
{$IF Var_Interface =  Var_Default}
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

procedure TFrmDlg2.dbtnAcceptCureClick(Sender: TObject; X, Y: Integer);
var
  i: Integer;
begin
  if Sender = dbtnAcceptCure then
    FrmMain.SendClientMessage(CM_ALIVE, 1, 0, 0, 0, '');

  if Sender = dbtnAtOnceCure then begin
    for i := Low(g_ItemArr) to High(g_ItemArr) do begin
      if (g_ItemArr[i].s.Name <> '') and (g_ItemArr[i].s.StdMode = tm_Revive) then begin
        FrmMain.SendClientMessage(CM_ALIVE, 2, 0, 0, 0, '');
        exit;
      end;
    end;
    FrmDlg.DMessageDlg('你包裹里没有还魂丹，无法使用原地复活功能.', []);
  end;

  if Sender = dbtnBackCure then
    FrmMain.SendClientMessage(CM_ALIVE, 3, 0, 0, 0, '');

  
end;

procedure TFrmDlg2.dbtnGameSetupClick(Sender: TObject; X, Y: Integer);
begin
  dwndSysSetup.Visible := False;
  if Sender = dbtnGameSetup then
    FrmDlg3.DGameSetup.Visible := not FrmDlg3.DGameSetup.Visible;

  if Sender = dbtnSelectChr then
    frmMain.AppLogout;

  if Sender = dbtnExitGame then
    frmMain.AppExit;
  
end;

procedure TFrmDlg2.dbtnGameSetupMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left + (X - Left - 20));
    y := SurfaceY(Top + (y - Top) + 30);
    ShowMsg := '';
    if Sender = dbtnGameSetup then begin
      ShowMsg := '快捷键<（F12）/FCOLOR=$FFFF>';
    end
    else if Sender = dbtnSelectChr then begin
      ShowMsg := '快捷键<（ALT + X）/FCOLOR=$FFFF>';
    end
    else if Sender = dbtnExitGame then begin
      ShowMsg := '快捷键<（ALT + Q）/FCOLOR=$FFFF>';
    end;
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, False, Integer(Sender));
  end;
end;

procedure TFrmDlg2.dbtnSelectChrDirectPaint(Sender: TObject; dsurface: TDXTexture);
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

procedure TFrmDlg2.dBtWebCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
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

procedure TFrmDlg2.DButFrontClick(Sender: TObject; X, Y: Integer);
begin
  if (Sender = DButFront) or (Sender = DButFront2) then begin
    if ShopPage > 0 then
      Dec(ShopPage);
  end
  else if (Sender = DButNext) or (Sender = DButNext2) then begin
    if ShopPage < ShopMaxPage then
      Inc(ShopPage);
  end;
end;

procedure TFrmDlg2.DBuyAddClick(Sender: TObject; X, Y: Integer);
var
  nCount: integer;
begin
  nCount := StrToIntDef(DEditShopCount.Text, 0);
  if Sender = DBuyAdd then
    inc(nCount)
  else begin
    if nCount > 0 then
      Dec(nCount);
  end;
  DEditShopCount.Text := intToStr(nCount);
end;

procedure TFrmDlg2.DBuyAddDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure TFrmDlg2.AddShopMsg(smsg: string);
begin
  DUserShopMemo.Lines.Add(smsg);
  if DUserShopMemo.Lines.Count > 200 then begin
    DUserShopMemo.Lines.Delete(0);
  end;
end;

procedure TFrmDlg2.ClearShopSellItems;
var
  i: integer;
begin
  for i := Low(g_MyShopSellItems) to High(g_MyShopSellItems) do begin
    if g_MyShopSellItems[i].ShopItem.Item.s.Name <> '' then
      AdditemBag(g_MyShopSellItems[i].ShopItem.Item, g_MyShopSellItems[i].ShopItem.Index2);
  end;
end;

procedure TFrmDlg2.IconButtonAccordionClicked(Sender: TObject; X, Y: Integer);
begin
  IconButtonList.Visible := not IconButtonList.Visible;
end;

procedure TFrmDlg2.IconButtonAccordionDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  texture: TDXTexture;
  id: Integer;
begin
  with Sender as TDButton do
  begin
    if IconButtonList.Visible then
      id := 0
    else
      id := 4;
    if Downed then
      id := id + 2
    else if MouseEntry = msIn then
      id := id + 1;
    // FaceIndex = 160
    texture := WLib.Images[FaceIndex + id];
    if texture <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), texture.ClientRect(), texture, True);
  end;
end;

procedure TFrmDlg2.IconButtonClicked(Sender: TObject; X, Y: Integer);
begin
  if Sender = IconButton1 then
    FrmMain.SendCustomIconClick(0);
  if Sender = IconButton2 then
    FrmMain.SendCustomIconClick(1);
  if Sender = IconButton3 then
    FrmMain.SendCustomIconClick(2);
  if Sender = IconButton4 then
    FrmMain.SendCustomIconClick(3);
  if Sender = IconButton5 then
    FrmMain.SendCustomIconClick(4);
  if Sender = IconButton6 then
    FrmMain.SendCustomIconClick(5);
  if Sender = IconButton7 then
    FrmMain.SendCustomIconClick(6);
end;

procedure TFrmDlg2.IconButtonDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  texture: TDXTexture;
  id: Integer;
begin
  with Sender as TDButton do
  begin
    id := 0;
    if Downed then
      id := 2
    else if MouseEntry = msIn then
      id := 1;
    texture := WLib.Images[FaceIndex + id];
    if texture <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), texture.ClientRect(), texture, True);
  end;
end;

procedure TFrmDlg2.DCardCloseClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.CSocket.Active := False;
  DScreen.ChangeScene(stSelServer);
end;

procedure TFrmDlg2.DCardNo1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FrmDlg.DEditIDMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TFrmDlg2.DCardOKClick(Sender: TObject; X, Y: Integer);
begin
  LoginScene.CardOK;
end;

procedure TFrmDlg2.DEditEMailNewGoldChange(Sender: TObject);
begin
  if g_MySelf = nil then exit;
  DEditEMailNewGold.OnChange := nil;
  Try
    if DEditEMailNewGold.Value > g_MySelf.m_nGold then
    DEditEMailNewGold.Value := g_MySelf.m_nGold;
  Finally
    DEditEMailNewGold.OnChange := DEditEMailNewGoldChange;
  End;
end;

procedure TFrmDlg2.DEMailDelAllClick(Sender: TObject; X, Y: Integer);
begin
  if g_EMailList.Count > 0 then
    if mrYes = FrmDlg.DMessageDlg('是否确认删除所有信件，删除后无法恢复？', [mbYes, mbNo]) then begin
      ClearEMailInfo();
      FrmMain.SendClientMessage(CM_EMAIL, 0, 0, 0, 3);
    end;
end;

procedure TFrmDlg2.DEMailDelClick(Sender: TObject; X, Y: Integer);
var
  EMailInfo: pTEMailInfo;
begin
  if (EMailSelect >= 0) and (EMailSelect < g_EMailList.Count) then begin
    if mrYes = FrmDlg.DMessageDlg('是否确认删除信件，删除后无法恢复？', [mbYes, mbNo]) then begin
      EMailInfo := pTEMailInfo(g_EMailList.Objects[EMailSelect]);
      FrmMain.SendClientMessage(CM_EMAIL, EMailInfo.ClientEMail.nIdx, 0, 0, 1);
      Dispose(EMailInfo);
      g_EMailList.Delete(EMailSelect);
      EMailSelect := -1;
    end;
  end;
end;

procedure TFrmDlg2.DEMailGridDblClick(Sender: TObject);
begin
  DEMailReadClick(DEMailRead, 0, 0);
end;

procedure TFrmDlg2.DEMailGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  idx: integer;
  d: TDXTexture;
  ax, ay, px, py: integer;
  str: string;
  EMailInfo: pTEMailInfo;
begin
  with Sender as TDGrid do begin
    ax := SurfaceX(Rect.Left);
    ay := SurfaceY(Rect.Top);
    idx := ACol + ARow * ColCount + DUpDownEMail.Position;
    if (idx >= 0) and (Idx < g_EMailList.Count) then begin
      d := g_WMain99Images.Images[{$IF Var_Interface =  Var_Default}552{$ELSE}1645{$IFEND} + Integer(EMailSelect = idx)];
      if d <> nil then
        DSurface.Draw(ax, ay, d.ClientRect, d, True);

      EMailInfo := pTEMailInfo(g_EMailList.Objects[idx]);
      d := g_WMain99Images.GetCachedImage(557 + Integer(not EMailInfo.ClientEMail.boRead), px, py);
      if d <> nil then
        DSurface.Draw(ax + px{$IF Var_Interface = Var_Mir2} - 2{$IFEND}, ay + py, d.ClientRect, d, True);

      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        TextOut(ax + 53{$IF Var_Interface = Var_Mir2} - 3{$IFEND}, ay + 9, $B6C2A4, '标题：');
        TextOut(ax + 53{$IF Var_Interface = Var_Mir2} - 3{$IFEND}, ay + 26, $B6C2A4, '来自：');
        str := IntToStr(EMailInfo.ClientEMail.btTime) + '天';
        TextOut(ax + 242 - TextWidth(str), ay + 18, $B6C2A4, str);

        if EMailInfo.ClientEMail.boSystem then begin
          TextOut(ax + 88{$IF Var_Interface = Var_Mir2} - 3{$IFEND}, ay + 9, clRed, EMailInfo.ClientEMail.sTitle);
          TextOut(ax + 88{$IF Var_Interface = Var_Mir2} - 3{$IFEND}, ay + 26, clRed, '[系统]');
        end
        else begin
          TextOut(ax + 88{$IF Var_Interface = Var_Mir2} - 3{$IFEND}, ay + 9, clWhite, EMailInfo.ClientEMail.sTitle);
          TextOut(ax + 88{$IF Var_Interface = Var_Mir2} - 3{$IFEND}, ay + 26, clWhite, EMailInfo.ClientEMail.sSendName + '[玩家]');
        end;
        //Release;
      end;
    end;

    {d := g_WMain99Images.GetCachedImage(558, px, py);
    if d <> nil then
      DSurface.Draw(ax + px, ay + py, d.ClientRect, d, True);

    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      TextOut(ax + 53, ay + 9, $B6C2A4, '标题：');
      TextOut(ax + 53, ay + 26, $B6C2A4, '来自：');
      str := '0天';
      TextOut(ax + 242 - TextWidth(str), ay + 18, $B6C2A4, str);

      TextOut(ax + 88, ay + 9, clYellow, '一二三四五六七八九十');
      TextOut(ax + 88, ay + 26, clWhite, '来自三四五六七[玩家]');
      //Release;
    end; }
  end;
end;

procedure TFrmDlg2.DEMailGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + DUpDownEMail.Position;
    if EMailSelect <> idx then begin
      EMailSelect := idx;
      PlaySound(s_glass_button_click);
    end;
  end;
end;

procedure TFrmDlg2.DEMailListClick(Sender: TObject; X, Y: Integer);
begin
  EMailSelect := -1;
  with Sender as TDWindow do begin
    EMailSelect := (Y - Top) div 16 + DUpDownEMail.Position;
  end;
end;

procedure TFrmDlg2.DEMailNewAddClick(Sender: TObject; X, Y: Integer);
var
  nGold: Integer;
begin
  if g_SendEMailItem.Item.s.name <> '' then begin
    FrmDlg.DMessageDlg('你还有未处理信件信息，请稍候再发送！', []);
    exit;
  end;
  
  if Trim(DEMailNewEdit.Text) = '' then begin
    FrmDlg.DMessageDlg('信件标题不能为空！', []);
    exit;
  end;
  if (DEMailNameComboBox.ItemIndex <= 0) or (DEMailNameComboBox.ItemIndex >= DEMailNameComboBox.Item.Count) then begin
    FrmDlg.DMessageDlg('收件人不能为空！', []);
    exit;
  end;
  if Trim(DEmailNewMemo.GetText) = '' then begin
    FrmDlg.DMessageDlg('信件内容不能为空！', []);
    exit;
  end;
  nGold := GetEMailGold(DEditEMailNewGold.Value, EMailNewItem.Item.s.Name <> '');

  if g_MySelf.m_nGold < (nGold + DEditEMailNewGold.Value) then begin
    FrmDlg.DMessageDlg('你的' + g_sGoldName + '不够支付本次发送费用！', []);
    exit;
  end;
  if EMailNewItem.Item.s.Name = '' then
    EMailNewItem.Item.UserItem.MakeIndex := 0;
  g_SendEMailItem := EMailNewItem;
  EMailNewItem.Item.s.Name := '';
  FrmMain.SendClientSocket(CM_EMAIL, EMailNewItem.Item.UserItem.MakeIndex,
    LoWord(DEditEMailNewGold.Value), HiWord(DEditEMailNewGold.Value), 2,
    EncodeString(DEMailNameComboBox.Item[DEMailNameComboBox.ItemIndex]) + '/' +
    EncodeString(Trim(DEMailNewEdit.Text)) + '/' +
    EncodeString(DEmailNewMemo.GetText)
    );
  DWndEMailNew.Visible := False;
end;

procedure TFrmDlg2.DEMailNewClick(Sender: TObject; X, Y: Integer);
begin
  OpenNewMail('');
end;

procedure TFrmDlg2.DEMailNewItemClick(Sender: TObject; X, Y: Integer);
begin
  if not g_boItemMoving then begin
    if EMailNewItem.Item.s.name <> '' then
      AddItemBag(EMailNewItem.Item, EMailNewItem.Index2);
    EMailNewItem.Item.s.name := '';
  end else
  if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
    if g_nAreaStateValue <> OT_SAFEAREA then begin
      FrmDlg.CancelItemMoving;
      FrmDlg.DMessageDlg('发送物品只能在安全区进行.', []);
      exit;
    end;
    if (not CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoDeal)) then
    begin
      if EMailNewItem.Item.s.name <> '' then
        AddItemBag(EMailNewItem.Item, EMailNewItem.Index2);
      EMailNewItem := g_MovingItem;
      g_boItemMoving := False;
      g_MovingItem.Item.s.Name := '';
    end else begin
      FrmDlg.CancelItemMoving;
      FrmDlg.DMessageDlg('该物品不允许进行交易！', []);
    end;
  end;
end;

procedure TFrmDlg2.DEMailNewItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if Sender = DEmailNewItem then begin
      if EMailNewItem.Item.s.Name <> '' then begin
        d := GetBagItemImg(EMailNewItem.Item.S.looks);
        if d <> nil then
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
            ax + (Width - d.Width) div 2,
            ay + (Height - d.Height) div 2,
            Width,
            Height,
            @EMailNewItem.Item);
      end;
    end else begin
      if ReadEMailInfo.Item.s.Name <> '' then begin
        d := GetBagItemImg(ReadEMailInfo.Item.S.looks);
        if d <> nil then
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
            ax + (Width - d.Width) div 2,
            ay + (Height - d.Height) div 2,
            Width,
            Height,
            @ReadEMailInfo.Item);
      end;
    end;
  end;
end;

procedure TFrmDlg2.DEMailNewItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
begin
  with Sender as TDButton do begin
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    if Sender = DEmailNewItem then begin
      if EMailNewItem.Item.s.Name <> '' then
        DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(EMailNewItem.Item, [mis_EMailItem], []),
          clwhite, False, EMailNewItem.Item.UserItem.MakeIndex, True);
    end else begin
      if ReadEMailInfo.Item.s.Name <> '' then
        DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(ReadEMailInfo.Item, [mis_EMailReadItem], []),
          clwhite, False, ReadEMailInfo.Item.UserItem.MakeIndex, True);
    end;
  end;
end;

procedure TFrmDlg2.DEMailReadBackClick(Sender: TObject; X, Y: Integer);
begin
  DWndEMailRead.Visible := False;
  OpenNewMail(ReadEMailInfo.ClientEMail.sSendName);
end;

procedure TFrmDlg2.DEMailReadClick(Sender: TObject; X, Y: Integer);
var
  EMailInfo: pTEMailInfo;
begin
  if (GetTickCount - EMailSelectTick) < 5000 then exit;
  if (EMailSelect >= 0) and (EMailSelect < g_EMailList.Count) then begin
    EMailInfo := pTEMailInfo(g_EMailList.Objects[EMailSelect]);
    if EMailInfo.sText <> '' then begin
      OpenReadMail(EMailInfo);
    end
    else begin
      EMailSelectTick := GetTickCount;
      FrmMain.SendClientMessage(CM_EMAIL, EMailInfo.ClientEMail.nIdx, 0, 0, 0);
    end;
  end;
end;

procedure TFrmDlg2.DEMailReadDelClick(Sender: TObject; X, Y: Integer);
begin
  if mrYes = FrmDlg.DMessageDlg('是否确认删除信件，删除后无法恢复？', [mbYes, mbNo]) then begin
    DeleteEMailByIndex(ReadEMailInfo.ClientEMail.nIdx);
    FrmMain.SendClientMessage(CM_EMAIL, ReadEMailInfo.ClientEMail.nIdx, 0, 0, 1);
    DWndEMailRead.Visible := False;
  end;
end;

procedure TFrmDlg2.DEMailReadDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, n1C: Integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    n1C := 0;
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex + 1];
        Inc(n1C);
      end else begin
        d := WLib.Images[FaceIndex];
      end;
      if d <> nil then
        dsurface.Draw(ax, ay, d.ClientRect, d, True);
      with g_DXCanvas do begin
        TextOut(ax + Width div 2 - TextWidth(Caption) div 2 + n1C, ay + 7 + n1C, $ADD6EF, Caption);
      end;
    end;
  end;
end;

procedure TFrmDlg2.DEMailReadGoldClick(Sender: TObject; X, Y: Integer);
begin
  if ((GetTickCount - EMailSelectTick) < 5000) or (ReadEMailInfo.nGold <= 0) then exit;
  EMailSelectTick := GetTickCount;
  FrmMain.SendClientMessage(CM_EMAIL, ReadEMailInfo.ClientEMail.nIdx, 0, 0, 4);
end;

procedure TFrmDlg2.DEMailReadItemClick(Sender: TObject; X, Y: Integer);
begin
  if ((GetTickCount - EMailSelectTick) < 5000) or (ReadEMailInfo.Item.s.name = '') then exit;
  if g_nAreaStateValue <> OT_SAFEAREA then begin
    FrmDlg.DMessageDlg('取回信件物品只能在安全区进行.', []);
    exit;
  end;
  EMailSelectTick := GetTickCount;
  FrmMain.SendClientMessage(CM_EMAIL, ReadEMailInfo.ClientEMail.nIdx, 0, 0, 5);
end;

procedure TFrmDlg2.DFriAddMemClick(Sender: TObject; X, Y: Integer);
begin
  case FriendIndex of
    0: begin
        FrmDlg.DMessageDlg('请输入想要增加的好友名称', [mbOk, mbAbort], 14);
        if Trim(FrmDlg.DlgEditText) <> '' then
          FrmMain.SendClientMessage(CM_FRIEND_CHENGE, 0, 0, 0, 0, Trim(FrmDlg.DlgEditText));
      end;
    1: begin
        FrmDlg.DMessageDlg('请输入要增加到禁言名单的人物名称', [mbOk, mbAbort], 14);
        if Trim(FrmDlg.DlgEditText) <> '' then begin
          if g_MyBlacklist.IndexOf(Trim(FrmDlg.DlgEditText)) = -1 then begin
            g_MyBlacklist.Add(Trim(FrmDlg.DlgEditText))
          end;
        end;
      end;
  end;
end;

procedure TFrmDlg2.DFriDelMemClick(Sender: TObject; X, Y: Integer);
var
  idx: integer;
begin
  case FriendIndex of
    0: begin
        if (FriendSelect > -1) and (FriendSelect < g_FriendList.Count) then begin
          if mrYes = FrmDlg.DMessageDlg('是否确认删除好友[' + g_FriendList[FriendSelect] + ']', [mbYes, mbNo])
            then begin
            FrmMain.SendClientMessage(CM_FRIEND_CHENGE, 0, 0, 0, 1, g_FriendList[FriendSelect]);
            g_FriendList.Delete(FriendSelect);
          end;
        end
        else begin
          FrmDlg.DMessageDlg('请输入想要删除的好友名称', [mbOk, mbAbort]);
          if Trim(FrmDlg.DlgEditText) <> '' then begin
            idx := g_FriendList.IndexOf(Trim(FrmDlg.DlgEditText));
            if Idx <> -1 then begin
              FrmMain.SendClientMessage(CM_FRIEND_CHENGE, 0, 0, 0, 1, Trim(FrmDlg.DlgEditText));
              g_FriendList.Delete(idx);
            end;
          end;
        end;
      end;
    1: begin
        if (FriendSelect > -1) and (FriendSelect < g_MyBlacklist.Count) then begin
          g_MyBlacklist.Delete(FriendSelect);
        end
        else begin
          FrmDlg.DMessageDlg('请输入要删除的人物名称', [mbOk, mbAbort]);
          if Trim(FrmDlg.DlgEditText) <> '' then begin
            idx := g_MyBlacklist.IndexOf(Trim(FrmDlg.DlgEditText));
            if idx <> -1 then begin
              g_MyBlacklist.Delete(idx);
            end;
          end;
        end;
      end;
  end;
end;

procedure TFrmDlg2.DFriFriendClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if FriendIndex <> Tag then begin
      FriendIndex := Tag;
      FriendSelect := -1;
      FriendMove := -1;
      DFriendUpDown.Position := 0;
      PlaySound(s_glass_button_click);
    end;
  end;
end;

procedure TFrmDlg2.DFriFriendDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
{$IF Var_Interface =  Var_Default}
  FColor: TColor;
  nTop: Byte;
{$IFEND}
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := FaceIndex;
{$IF Var_Interface =  Var_Default}
      FColor := DFMoveColor;
      nTop := 1;
{$IFEND}
      if FriendIndex <> tag then begin
{$IF Var_Interface =  Var_Default}
        FColor := DFColor;
        nTop := 1;
        if MouseEntry = msIn then
          Inc(idx, 2)
        else
          Inc(idx, 1);
{$ELSE}
        idx := -1;
{$IFEND}
      end;
      d := WLib.Images[idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
{$IF Var_Interface =  Var_Default}
      with g_DXCanvas do begin
        TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2,
                SurfaceY(Top) + (Height - TextHeight(Caption)) div 2 + nTop,
                Caption, FColor);
      end;
{$IFEND}

    end;
  end;
end;

procedure TFrmDlg2.DFriFriendMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nHintX, nHintY: Integer;
  smsg: string;
begin
  with Sender as TDButton do begin
    sMsg := '';
    if Sender = DFriBlack then begin
      sMsg := '加入到禁言名单的名称，将自动过滤其发言';
    end
    else if Sender = DFriSay then begin
      sMsg := '与你私聊过的名称，或者你私聊过的名称\都将自动加入到该列表，方便管理';
    end
    else if (Sender = DUpLoadTop) or
      (Sender = DUpLoadLeft) or
      (Sender = DUpLoadDown) or
      (Sender = DUpLoadRight) then begin
      sMsg := '改变图像显示位置\按住 <Ctrl/FCOLOR=$FFFF> 可以快速移动';
      if (Downed) and ((GetTickCount - AppendTick) > 100) then begin
        AppendTick := GetTickCount;
        DUpLoadTopMouseDown(Sender, mbMiddle, Shift, X, Y);
      end;

    end;
    if sMsg <> '' then begin
      nHintX := SurfaceX(Left);
      nHintY := SurfaceY(Top);
      DScreen.ShowHint(nHintX, nHintY, smsg, clWhite, True, Integer(Sender));
    end;
  end;
end;

procedure TFrmDlg2.DFriWinDblClick(Sender: TObject);
begin
  case FriendIndex of
    0: begin
        if (FriendSelect > -1) and (FriendSelect < g_FriendList.Count) then begin
          PlayScene.SetEditChar(g_FriendList[FriendSelect]);
        end;
      end;
    2: begin
        if (FriendSelect > -1) and (FriendSelect < g_MyWhisperList.Count) then begin
          PlayScene.SetEditChar(g_MyWhisperList[FriendSelect]);
        end;
      end;
  end;
end;

procedure TFrmDlg2.DFriWinDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay, I: integer;
  //str: string;
  ShowList: TStringList;
  FontColor: TColor;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    with g_DXCanvas do begin
      ShowList := nil;
      FontColor := $00C5D2BD;
      case FriendIndex of
        0: begin
            ShowList := g_FriendList;
          end;
        1: begin
            ShowList := g_MyBlacklist;
          end;
        2: begin
            ShowList := g_MyWhisperList;
          end;
      end;
      if ShowList <> nil then begin
        for I := DFriendUpDown.Position to DFriendUpDown.Position + FRIENDCOUNT do begin
          if I >= ShowList.Count then
            break;
          if i = FriendMove then begin
            FillRect(ax, ay + (I - DFriendUpDown.Position) * 16, Width, 16, $A062625A);
          end
          else if i = FriendSelect then begin
            FillRect(ax, ay + (I - DFriendUpDown.Position) * 16, Width, 16, $C862625A);
          end;
          if FriendIndex = 0 then begin
            if Integer(ShowList.Objects[i]) = 1 then
              FontColor := $00C5D2BD
            else
              FontColor := $607275;
          end;
          TextOut(ax + 4, ay + (I - DFriendUpDown.Position) * 16 + 2, ShowList[i], FontColor);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DFriWinMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FriendSelect := -1;
  with Sender as TDWindow do begin
    FriendSelect := (Y - Top) div 16 + DFriendUpDown.Position;
  end;
end;

procedure TFrmDlg2.DFriWinMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  FriendMove := -1;
  with Sender as TDWindow do begin
    FriendMove := (Y - Top) div 16 + DFriendUpDown.Position;
  end;
end;

procedure TFrmDlg2.DFriWinMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  UserName: string;
  nLogin: Integer;
begin
  with Sender as TDControl do begin
    if (mbRight = Button) and (FriendIndex = 0) and (FriendSelect > -1) and
      (FriendSelect < g_FriendList.Count) then begin
      UserName := g_FriendList[FriendSelect];
      nLogin := Integer(g_FriendList.Objects[FriendSelect]);
      DPopUpFriend.Visible := False;
      DPopUpFriend.Item.Clear;
      DPopUpFriend.Item.AddObject('名称: ' + UserName, TObject(-1));
      DPopUpFriend.Item.AddObject('-', nil);
      if nLogin = 1 then
        DPopUpFriend.Item.AddObject('进行私聊', TObject(1))
      else
        DPopUpFriend.Item.AddObject('进行私聊', nil);
      DPopUpFriend.Item.AddObject('删除好友', TObject(2));
      DPopUpFriend.Item.AddObject('发送信件', TObject(3));
      if nLogin = 1 then
        DPopUpFriend.Item.AddObject('邀请组队', TObject(4))
      else
        DPopUpFriend.Item.AddObject('邀请组队', nil);
      if nLogin = 1 then
        DPopUpFriend.Item.AddObject('邀请加入行会', TObject(5))
      else
        DPopUpFriend.Item.AddObject('邀请加入行会', nil);
      DPopUpFriend.Item.AddObject('-', nil);
      DPopUpFriend.Item.AddObject('复制人物名称', TObject(6));
      DPopUpFriend.RefSize;
      DPopUpFriend.Popup(Sender, SurfaceX(X), SurfaceY(Y), UserName);
    end;
  end;
end;

procedure TFrmDlg2.DGroupCloseClick(Sender: TObject; X, Y: Integer);
begin
  DWndGroupMember.Visible := not DWndGroupMember.Visible;
end;

procedure TFrmDlg2.DGroupCloseDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
begin
  with Sender as TDButton do begin
    if DWndGroupMember.Visible then
      idx := 0
    else
      idx := 4;
    if Downed then begin
      inc(idx, 2)
    end
    else if MouseEntry = msIn then begin
      Inc(idx, 1)
    end;
    // FaceIndex = 306
    d := WLib.Images[FaceIndex + idx];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg2.DGroupMember1DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  rect: TRect;
  i, n: Integer;
  GroupMember: pTGroupMember;
  Window: TDWindow;
  r: Real;
begin
  if Sender = DGroupMember1 then begin
    n := 0;
    for i := 0 to g_GroupMembers.Count - 1 do begin
      GroupMember := g_GroupMembers[i];
      if GroupMember.ClientGroup.UserID = g_MySelf.m_nRecogId then
        Continue;
      //      Window := DGroupMember1;
      case n of
        0: Window := DGroupMember1;
        1: Window := DGroupMember2;
        2: Window := DGroupMember3;
        3: Window := DGroupMember4;
        4: Window := DGroupMember5;
        5: Window := DGroupMember6;
        6: Window := DGroupMember7;
      else
        Exit;
        Window := DGroupMember1;
      end;
      with Window do begin
        AppendData := GroupMember;
        d := WLib.Images[171 + GroupMember.ClientGroup.btJob + GroupMember.ClientGroup.btSex * 3];
        if d <> nil then begin
          if GroupMember.isScreen <> nil then begin
            dsurface.Draw(SurfaceX(Left + 9), SurfaceY(Top + 10), d.ClientRect, d, TRUE);
          end
          else begin
            g_DXCanvas.Draw(SurfaceX(Left + 9), SurfaceY(Top + 10), d.ClientRect, d, True, clRed4);
          end;
        end;

        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

        d := WLib.Images[177];
        if d <> nil then begin
          rect := d.ClientRect;
          if GroupMember.ClientGroup.HP > 0 then
          begin
            if (GroupMember.ClientGroup.HP > GroupMember.ClientGroup.MaxHP) then
              r := 1
            else
              r := GroupMember.ClientGroup.MaxHP / GroupMember.ClientGroup.HP;
          end
          else
            r := 0;
          if r > 0 then
            rect.Right := Round(rect.Right / r)
          else
            rect.Right := 0;
          //dsurface.Draw(667, g_FScreenHeight - 77, rc, d, FALSE);
          dsurface.Draw(SurfaceX(Left + 51), SurfaceY(Top + 21), rect, d, TRUE);
        end;

        d := WLib.Images[178];
        if d <> nil then begin
          rect := d.ClientRect;
          if GroupMember.ClientGroup.MP > 0 then
          begin
            if (GroupMember.ClientGroup.MP > GroupMember.ClientGroup.MaxMP) then
              r := 1
            else
              r := GroupMember.ClientGroup.MaxMP / GroupMember.ClientGroup.MP;
          end
          else
            r := 0;
          if r > 0 then
            rect.Right := Round(rect.Right / r)
          else
            rect.Right := 0;
          dsurface.Draw(SurfaceX(Left + 51), SurfaceY(Top + 29), rect, d, TRUE);
        end;
      end;
      Inc(n);
    end;
  end;
end;

procedure TFrmDlg2.DGroupMember1InRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    if (x > 16) and (x < 48) and (y > 9) and (y < 42) then begin
      IsRealArea := True;
    end
    else begin
      if WLib <> nil then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          if d.Pixels[x, y] <= 0 then
            IsRealArea := FALSE;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DGroupMember1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nHintX, nHintY: Integer;
  smsg: string;
  GroupMember: pTGroupMember;
begin
  with Sender as TDWindow do begin
    {if Sender = DBotAutoSys then
        sMsg := '自动喊话开关'; }
    if DPopUpMemuGroup.Visible and (TObject(DPopUpMemuGroup.AppendData) = Sender) then
      Exit;
    if AppendData <> nil then begin                   
      GroupMember := AppendData;
      sMsg := '';
      sMsg := sMsg + '名称: <' + GroupMember.ClientGroup.UserName + ' /FCOLOR=' + IntToStr(GetRGB(255)) + '>\';
      sMsg := sMsg + '等级: ' + IntToStr(GroupMember.ClientGroup.Level) + ' 级\';
      if (g_SetupInfo.boUnitHpMp) then
        sMsg := sMsg + 'H P: ' + IntUnit(GroupMember.ClientGroup.HP) + '/' + IntUnit(GroupMember.ClientGroup.MaxHP) + '\'
      else
        sMsg := sMsg + Format('H P: %d/%d\', [GroupMember.ClientGroup.HP, GroupMember.ClientGroup.MaxHP]);
      if (g_SetupInfo.boUnitHpMp) then
        sMsg := sMsg + 'M P: ' + IntUnit(GroupMember.ClientGroup.MP) + '/' + IntUnit(GroupMember.ClientGroup.MaxMP) + '\'
      else
        sMsg := sMsg + Format('M P: %d/%d\', [GroupMember.ClientGroup.MP, GroupMember.ClientGroup.MaxMP]);
      if g_boUseWuXin then begin
        sMsg := sMsg + '五行: <' + GetWuXinName(GroupMember.ClientGroup.WuXin) + ' /FCOLOR=' + IntToStr(GetWuXinColor(GroupMember.ClientGroup.WuXin)) + '>\'
      end;
      {if GroupMember.isScreen <> nil then
        sMsg := sMsg + '位置: 你的附近\'
      else }
      if (GroupMember.ClientGroup.mapName <> '') and (GroupMember.ClientGroup.cX > 0) and (GroupMember.ClientGroup.cY > 0) then
        sMsg := sMsg + '位置: ' + GroupMember.ClientGroup.mapName + '(' + IntToStr(GroupMember.ClientGroup.cX) + ',' + IntToStr(GroupMember.ClientGroup.cY) + ')\'
      else
        sMsg := sMsg + '位置: 未知地点\';
      nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + LocalX(X - Left);
      nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + LocalY(Y - Top) + 30;
      DScreen.ShowHint(nHintX, nHintY, smsg, clWhite, False, Integer(Sender));
    end;
  end;
end;

procedure TFrmDlg2.DGroupMember7MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  UserName: string;
begin
  with (Sender as TDControl) do begin
    if (mbRight = Button) then begin
      if AppendData = nil then
        exit;
      UserName := pTGroupMember(AppendData).ClientGroup.UserName;
      DPopUpMemuGroup.Visible := False;
      DPopUpMemuGroup.Item.Clear;
      DPopUpMemuGroup.Item.AddObject('名称: ' + UserName, TObject(-1));
      DPopUpMemuGroup.Item.AddObject('-', nil);
      if (g_GroupMembers.Count > 0) and
        (pTGroupMember(g_GroupMembers[0]).ClientGroup.UserName = g_MySelf.m_UserName) then begin
        DPopUpMemuGroup.Item.AddObject('踢出队伍', TObject(1));
      end
      else
        DPopUpMemuGroup.Item.AddObject('踢出队伍', nil);
      DPopUpMemuGroup.Item.AddObject('进行私聊', TObject(2));
      if (not InFriendList(UserName)) and
        (UserName <> g_MySelf.m_UserName) then
        DPopUpMemuGroup.Item.AddObject('加为好友', TObject(3))
      else
        DPopUpMemuGroup.Item.AddObject('加为好友', nil);

      if InFriendList(UserName) then
        DPopUpMemuGroup.Item.AddObject('发送信件', TObject(4))
      else
        DPopUpMemuGroup.Item.AddObject('发送信件', nil);

      DPopUpMemuGroup.Item.AddObject('邀请加入行会', TObject(5));
      DPopUpMemuGroup.Item.AddObject('-', nil);
      DPopUpMemuGroup.Item.AddObject('复制人物名称', TObject(6));
      DPopUpMemuGroup.RefSize;
      DPopUpMemuGroup.Popup(Sender, SurfaceX(X), SurfaceY(Y), UserName);
    end;
  end;
end;

procedure TFrmDlg2.DLoginOkSound(Sender: TObject; Clicksound: TClickSound);
begin
  case Clicksound of
    csNorm: PlaySound(s_norm_button_click);
    csStone: PlaySound(s_rock_button_click);
    csGlass: PlaySound(s_glass_button_click);
  end;
end;

procedure TFrmDlg2.DMatrixCardWndDirectPaint(Sender: TObject; dsurface: TDXTexture);
  function GetCardStr(CardID: integer): string;
  const
    CardRowStr: array[0..9] of Char = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J');
  begin
    Result := '';
    if (CardID > 0) and (CardID < 80) then begin
      Result := CardRowStr[CardID div 8];
      Result := Result + IntToStr(CardID mod 8 + 1);
    end;

  end;
var
  d: TDXTexture;
  ax, ay: integer;
  str: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      Str := GetCardStr(CardID[0]) + ', ';
      Str := Str + GetCardStr(CardID[1]) + ', ';
      Str := Str + GetCardStr(CardID[2]) + '';
      TextOut(ax + 146, ay + 53, Str, clWhite);
      //BoldTextOut(dsurface, ax + 146, ay + 53, clWhite, $8, Str);
      //Release;
    end;
  end;
end;

procedure TFrmDlg2.DPopUpFriendPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
var
  i: integer;
begin
  with DControl do begin
    case Integer(TDPopUpMemu(Sender).Item.Objects[ItemIndex]) of
      1: PlayScene.SetEditChar(UserName);
      2: begin
          if mrYes = FrmDlg.DMessageDlg('是否确认删除好友[' + UserName + ']', [mbYes, mbNo]) then begin
            FrmMain.SendClientMessage(CM_FRIEND_CHENGE, 0, 0, 0, 1, UserName);
            for i := 0 to g_FriendList.Count - 1 do begin
              if g_FriendList[i] = UserName then begin
                g_FriendList.Delete(i);
                break;
              end;
            end;
          end;
        end;
      3: OpenNewMail(UserName);
      4: FrmDlg.CreateGroup(UserName);
      5: frmMain.SendGuildAddMem(UserName);
      6: CopyStrToClipboard(UserName);
    end;
  end;
end;

procedure TFrmDlg2.DPopUpMemuGroupPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
begin
  with DControl do begin
    case Integer(TDPopUpMemu(Sender).Item.Objects[ItemIndex]) of
      1: frmMain.SendDelGroupMember(UserName);
      2: PlayScene.SetEditChar(UserName);
      3: FrmMain.SendClientMessage(CM_FRIEND_CHENGE, 0, 0, 0, 0, UserName);
      4: OpenNewMail(UserName);
      5: frmMain.SendGuildAddMem(UserName);
      6: CopyStrToClipboard(UserName);
    end;
  end;
end;

procedure TFrmDlg2.DReadShopBuyGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyReadShopBuyItems)..High(g_MyReadShopBuyItems)] then begin
      if g_MyReadShopBuyItems[idx].ShopItem.Item.s.Name <> '' then begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(g_MyReadShopBuyItems[idx].ShopItem.Item, [mis_ShopBuy, mis_ReadShop],
          [g_MyReadShopBuyItems[idx].nMoney, Integer(g_MyReadShopBuyItems[idx].boGamePoint)]),
          clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg2.DReadShopBuyGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyReadShopBuyItems)..High(g_MyReadShopBuyItems)] then begin
      if g_MyReadShopBuyItems[idx].ShopItem.Item.S.name <> '' then begin
        d := GetBagItemImg(g_MyReadShopBuyItems[idx].ShopItem.Item.S.looks);
        if d <> nil then begin
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
              SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
              SurfaceX(Rect.Right),
              SurfaceY(Rect.Bottom) - 12,
              @g_MyReadShopBuyItems[idx].ShopItem.Item, True);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DReadShopBuyGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  nMoney: Int64;
  ShowMsg: string;
  temp: TMovingItem;
begin
  if (g_MySelf = nil) or (g_MyShopItem.Item.s.Name <> '') then exit;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyReadShopBuyItems)..High(g_MyReadShopBuyItems)] then begin
      if g_MyReadShopBuyItems[idx].ShopItem.Item.s.Name <> '' then begin
        if not g_boItemMoving then begin
          ShowMsg := '请将要出售给店家的物品从背包拖放到对应的物品上';
          FrmDlg.DMessageDlg(ShowMsg, [mbYes, mbNo])
        end else
        if (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
          if CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoDeal) then begin
            FrmDlg.CancelItemMoving;
            FrmDlg.DMessageDlg('该物品不允许摆摊交易！', [mbYes]);
            exit;
          end;
          temp := g_MyReadShopBuyItems[idx].ShopItem;
          if temp.Item.s.StdMode = g_MovingItem.Item.s.StdMode then begin
            ShowMsg := '确认出售信息\';
            ShowMsg := ShowMsg + '物品名称: ' + temp.Item.s.Name + '\';
            if (sm_Superposition in temp.Item.s.StdModeEx) and (temp.Item.s.DuraMax > 1) then begin
              if g_MovingItem.Item.UserItem.Dura > temp.Item.UserItem.Dura then begin
                ShowMsg := ShowMsg + '出售数量: ' + IntToStr(temp.Item.UserItem.Dura) + '\';
                nMoney := Int64(temp.Item.UserItem.Dura) * Int64(g_MyReadShopBuyItems[idx].nMoney);
              end else begin
                ShowMsg := ShowMsg + '出售数量: ' + IntToStr(g_MovingItem.Item.UserItem.Dura) + '\';
                nMoney := Int64(g_MovingItem.Item.UserItem.Dura) * Int64(g_MyReadShopBuyItems[idx].nMoney);
              end;
            end else begin
              ShowMsg := ShowMsg + '出售数量: 1\';
              nMoney := Int64(g_MyReadShopBuyItems[idx].nMoney);
            end;
            ShowMsg := ShowMsg + '获得总额: ' + IntToStr(nMoney);
            if g_MyReadShopBuyItems[idx].boGamePoint then ShowMsg := ShowMsg + ' ' + g_sGameGoldName + '\ \'
            else ShowMsg := ShowMsg + ' ' + g_sGoldName + '\ \';
            ShowMsg := ShowMsg + '是否确认出售该物品给店家？';
            temp := g_MovingItem;
            ClearMovingItem();
            if mrYes = FrmDlg.DMessageDlg(ShowMsg, [mbYes, mbNo]) then begin
              g_MyShopItem := temp;
              FrmMain.SendClientSocket(CM_BUYUSERSHOP, g_nMyReadShopDlgID, g_nMyReadShopDlgX, g_nMyReadShopDlgY,
                idx, EncodeBuffer(@temp.Item.UserItem.MakeIndex, SizeOf(Integer)));
            end else
              Additembag(temp.Item, temp.Index2);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DReadShopEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    if Trim(DReadShopEdit.Text) <> '' then begin
      if GetTickCount > DReadShopEdit.AppendTick then begin
        DReadShopMemo.Lines.Add(FormatDateTime('[DD HH:MM:SS] ', Now) +
          g_MySelf.m_UserName + ': ' + Trim(DReadShopEdit.Text));
        FrmMain.SendClientMessage(CM_USERSHOPSAY, g_nMyReadShopDlgID, g_nMyReadShopDlgX, g_nMyReadShopDlgY, 0,
          Trim(DReadShopEdit.Text));
        DReadShopEdit.Text := '';
      end else begin
        DReadShopMemo.Lines.Add(FormatDateTime('[DD HH:MM:SS] ', Now) + '你留言速度过快,请稍后再试.');
      end;
      DReadShopEdit.AppendTick := GetTickCount + 3000;
    end;

    Key := #0;
  end;
  if Key = #27 then begin
    DReadShopEdit.Text := '';
    Key := #0;
  end;
end;

procedure TFrmDlg2.DReadShopSellGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyReadShopSellItems)..High(g_MyReadShopSellItems)] then begin
      if g_MyReadShopSellItems[idx].ShopItem.Item.s.Name <> '' then begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(g_MyReadShopSellItems[idx].ShopItem.Item, [mis_ShopSell, mis_ReadShop],
          [g_MyReadShopSellItems[idx].nMoney, Integer(g_MyReadShopSellItems[idx].boGamePoint)]),
          clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg2.DReadShopSellGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
  pRect: TRect;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyReadShopSellItems)..High(g_MyReadShopSellItems)] then begin
      if g_MyReadShopSellItems[idx].ShopItem.Item.S.name <> '' then begin
        d := GetBagItemImg(g_MyReadShopSellItems[idx].ShopItem.Item.S.looks);
        if d <> nil then begin
          pRect.Left := SurfaceX(Rect.Left);
          pRect.Top := SurfaceY(Rect.Top);
          pRect.Right := SurfaceX(Rect.Right + 1);
          pRect.Bottom := SurfaceY(Rect.Bottom);
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
              SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
              SurfaceX(Rect.Right),
              SurfaceY(Rect.Bottom) - 12,
              @g_MyReadShopSellItems[idx].ShopItem.Item, True, [pmShowLevel], @pRect);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DReadShopSellGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  nMoney: Integer;
  valstr, ShowMsg: string;
  temp: TMovingItem;
begin
  if (g_MySelf = nil) or (g_MyShopItem.Item.s.Name <> '') then exit;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyReadShopSellItems)..High(g_MyReadShopSellItems)] then begin
      if g_MyReadShopSellItems[idx].ShopItem.Item.s.Name <> '' then begin
        FrmDlg.CancelItemMoving;
        temp := g_MyReadShopSellItems[idx].ShopItem;
        ShowMsg := '确认购买信息                           \ \';
        ShowMsg := ShowMsg + '物品名称: ' + GetStrengthenItemNameByInfo(@temp.Item.UserItem, @temp.Item.s) + '\';
        if (sm_Superposition in temp.Item.s.StdModeEx) and (temp.Item.s.DuraMax > 1) then begin
          FrmDlg.DMessageDlg('请输入购买数量(1~' + IntToStr(_MIN(60000, temp.Item.UserItem.Dura)) + ').', [mbYes, mbAbort], 10, deInteger);
          GetValidStrVal(FrmDlg.DlgEditText, valstr, [' ']);
          nMoney := StrToIntDef(valstr, 0);
          if (nMoney > 0) and (nMoney <= _MIN(60000, temp.Item.UserItem.Dura)) then begin
            ShowMsg := ShowMsg + '购买数量: ' + valstr + '\';
            ShowMsg := ShowMsg + '价格总额: ' + IntToStr(Int64(nMoney) * Int64(g_MyReadShopSellItems[idx].nMoney));
          end else
            exit;
        end else begin
          nMoney := 1;
          ShowMsg := ShowMsg + '购买数量: 1\';
          ShowMsg := ShowMsg + '价格总额: ' + IntToStr(g_MyReadShopSellItems[idx].nMoney);
        end;
        if g_MyReadShopSellItems[idx].boGamePoint then ShowMsg := ShowMsg + ' ' + g_sGameGoldName + '\ \'
        else ShowMsg := ShowMsg + ' ' + g_sGoldName + '\ \';

        ShowMsg := ShowMsg + '是否确认购买该物品？';
        if mrYes = FrmDlg.DMessageDlg(ShowMsg, [mbYes, mbNo]) then begin
          g_MyShopItem := temp;
          FrmMain.SendClientSocket(CM_BUYUSERSHOP, g_nMyReadShopDlgID, g_nMyReadShopDlgX, g_nMyReadShopDlgY,
            nMoney + MAXSHOPITEMS, EncodeBuffer(@temp.Item.UserItem.MakeIndex, SizeOf(Integer)));
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DReadUserShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
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
      TextOut(ax + Width div 2 - TextWidth(g_MyReadTitle) div 2, ay + 12, g_MyReadTitle, $B1D2B7);
      //Release;
    end;
{$IFEND}
  end;
end;

procedure TFrmDlg2.DReadUserShopVisible(Sender: TObject; boVisible: Boolean);
begin
  DReadShopMemo.Lines.Clear;
  if not boVisible then begin
    g_nMyReadShopDlgX := -1;
    if FrmDlg.DitemBag.Visible and not FrmDlg.boOpenItemBag then
      FrmDlg.OpenItemBag;
  end else begin
    FrmDlg.DItemBag.Visible := True;
  end;
end;

procedure TFrmDlg2.DShopGameGoldClick(Sender: TObject; X, Y: Integer);
begin
{$IF Var_Interface = Var_Mir2}
 if ShopMoneyType = 1 then ShopMoneyType := 2
 else ShopMoneyType := 1;
{$ELSE}
  with Sender as TDButton do begin
    ShopMoneyType := Tag;
  end;  
{$IFEND}

end;

procedure TFrmDlg2.DShopGameGoldDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
{$IF Var_Interface = Var_Default}
  idx: integer;
  FColor: TColor;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if ShopMoneyType = 1 then begin
        d := WLib.Images[FaceIndex + 1];
      end else begin
        d := WLib.Images[FaceIndex];
      end;
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
{$ELSE}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := FaceIndex;
      FColor := DFDownColor;
      if ShopMoneyType <> tag then begin
        if MouseEntry = msIn then begin
          FColor := DFMoveColor;
          Inc(idx, 2);
        end else begin
          FColor := DFColor;
          Inc(idx, 1);
        end;
      end;
      d := WLib.Images[idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2,
          SurfaceY(Top) + (Height - TextHeight(Caption)) div 2, Caption, FColor);
        //Release;
      end;
    end;
  end;  
{$IFEND}

end;

procedure TFrmDlg2.DShopGetGamePointClick(Sender: TObject; X, Y: Integer);
var
  nCount: Integer;
  valstr: string;
begin
  if mrYes = FrmDlg.DMessageDlg('请输入对换数量. 1' + g_sGamePointName + ' = 1' + g_sGameGoldName,
    [mbYes, mbNo, mbAbort], 10, deInteger) then begin
    GetValidStrVal(FrmDlg.DlgEditText, valstr, [' ']);
    nCount := StrToIntDef(valstr, 0);
    if (nCount > 0)then begin
      if (g_MySelf.m_nGamePoint >= nCount) then
        FrmMain.SendShopGetPoint(nCount)
      else
        FrmDlg.DMessageDlg('你的' + g_sGameGoldName + '数量不够本次支付。', [mbOk]);
    end;
  end;
end;

procedure TFrmDlg2.DShopGrid2GridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  ShopItem: pTShopItem;
  p: TPoint;
begin
  with Sender as TDGrid do begin
    idx := ARow;
    if ShopMoneyType = 2 then begin
      if idx < g_ShopGoldList[0].Count then begin
        ShopItem := g_ShopGoldList[0][idx];
        GetCursorPos(p);
        p.X := p.X - FrmMain.m_Point.X;
        p.Y := p.Y - FrmMain.m_Point.Y;
        if ShopItem.ClientShopItem.wTime > 0 then
          ShopItem.CLientItem.UserItem.TermTime := DateTimeToLongWord(IncDay(g_ShopDateTime, ShopItem.ClientShopItem.wTime));
        DScreen.ShowHint(p.X, p.Y + 30, ShowItemInfo(ShopItem.CLientItem, [], [], False), clwhite, False, idx, True);
      end;
    end else begin
      if idx < g_ShopList[0].Count then begin
        ShopItem := g_ShopList[0][idx];
        GetCursorPos(p);
        p.X := p.X - FrmMain.m_Point.X;
        p.Y := p.Y - FrmMain.m_Point.Y;
        if ShopItem.ClientShopItem.wTime > 0 then
          ShopItem.CLientItem.UserItem.TermTime := DateTimeToLongWord(IncDay(g_ShopDateTime, ShopItem.ClientShopItem.wTime));
        DScreen.ShowHint(p.X, p.Y + 30, ShowItemInfo(ShopItem.CLientItem, [], [], False), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg2.DShopGrid2GridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
var
  idx: integer;
  ShopItem: pTShopItem;
  d: TDXTexture;
  ax, ay: integer;
  ShopList: TList;
  nFColor: TColor;
begin
  with Sender as TDGrid do begin
    ax := SurfaceX(Rect.Left);
    ay := SurfaceY(Rect.Top);
    idx := ARow;
    if ShopMoneyType = 2 then ShopList := g_ShopGoldList[0]
    else ShopList := g_ShopList[0];

    if idx < ShopList.Count then begin
      ShopItem := ShopList[idx];
      if (ShopSelectIdx = Idx) and (ShopSelectIndex = 0) then nFColor := clRed
      else nFColor := clWhite;
      
      if ShopItem.CLientItem.S.name <> '' then begin
        d := GetBagItemImg(ShopItem.CLientItem.S.looks);
        if d <> nil then
          FrmDlg.RefItemPaint(dsurface, d,
            ax + 38 + (41 - d.Width) div 2,
            ay + 0 + (30 - d.Height) div 2,
            1,
            1,
            @ShopItem.CLientItem, False);
      end;

      with g_DXCanvas do begin
        if ShopItem.ClientShopItem.wTime > 0 then
          TextOut(ax + 1, ay + 33, ShopItem.CLientItem.s.Name + '(' + IntToStr(ShopItem.ClientShopItem.wTime) + '天)', clLime)
        else
          TextOut(ax + 1, ay + 33, ShopItem.CLientItem.s.Name, clLime);

        if ShopMoneyType = 2 then begin
          TextOut(ax + 1, ay + 46, '价格：' + IntToStr(GetShopAgio(ShopItem.ClientShopItem.nGoldPrict, ShopItem.ClientShopItem.btAgio)) + ' ' + g_sGoldName, nFColor);
        end else
        if ShopMoneyType = 0 then begin
          TextOut(ax + 1, ay + 46, '价格：' + IntToStr(GetShopAgio(ShopItem.ClientShopItem.nPrict, ShopItem.ClientShopItem.btAgio)) + ' ' + g_sGamePointName, nFColor);
        end else begin
          TextOut(ax + 1, ay + 46, '价格：' + IntToStr(GetShopAgio(ShopItem.ClientShopItem.nPrict, ShopItem.ClientShopItem.btAgio)) + ' ' + g_sGameGoldName, nFColor);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DShopGrid2GridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
begin
  ShopSelectIdx := ARow;
  ShopSelectIndex := 0;
  if ShopMoneyType = 2 then begin
    if ShopSelectIdx < g_ShopGoldList[0].Count then begin
      PlaySound(s_glass_button_click);
      DEditShopCount.Value := 1;
    end;
  end else begin
    if ShopSelectIdx < g_ShopList[0].Count then begin
      PlaySound(s_glass_button_click);
      DEditShopCount.Value := 1;
    end;
  end;
end;

procedure TFrmDlg2.DShopGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  ShopItem: pTShopItem;
  p: TPoint;
begin
  with Sender as TDGrid do begin
    idx := ShopPage * (DShopGrid.ColCount * DShopGrid.RowCount) + ACol + ARow * ColCount;
    if ShopMoneyType = 2 then begin
      if idx < g_ShopGoldList[ShopIndex].Count then begin
        ShopItem := g_ShopGoldList[ShopIndex][idx];
        GetCursorPos(p);
        p.X := p.X - FrmMain.m_Point.X;
        p.Y := p.Y - FrmMain.m_Point.Y;
        if ShopItem.ClientShopItem.wTime > 0 then
          ShopItem.CLientItem.UserItem.TermTime := DateTimeToLongWord(IncDay(g_ShopDateTime, ShopItem.ClientShopItem.wTime));
        DScreen.ShowHint(p.X, p.Y + 30, ShowItemInfo(ShopItem.CLientItem, [], [], False), clwhite, False, idx, True);
      end;
    end else begin
      if idx < g_ShopList[ShopIndex].Count then begin
        ShopItem := g_ShopList[ShopIndex][idx];
        GetCursorPos(p);
        p.X := p.X - FrmMain.m_Point.X;
        p.Y := p.Y - FrmMain.m_Point.Y;
        if ShopItem.ClientShopItem.wTime > 0 then
          ShopItem.CLientItem.UserItem.TermTime := DateTimeToLongWord(IncDay(g_ShopDateTime, ShopItem.ClientShopItem.wTime));
        DScreen.ShowHint(p.X, p.Y + 30, ShowItemInfo(ShopItem.CLientItem, [], [], False), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg2.DShopGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  idx: integer;
  ShopItem: pTShopItem;
  d: TDXTexture;
  ax, ay: integer;
{$IF Var_Interface = Var_Default}
  str: string;
{$IFEND}
  ShopList: TList;
{$IF Var_Interface = Var_Mir2}
  nFColor: TColor;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDGrid do begin
    ax := SurfaceX(Rect.Left);
    ay := SurfaceY(Rect.Top);
    idx := ShopPage * (DShopGrid.ColCount * DShopGrid.RowCount) + ACol + ARow * ColCount;
    if ShopMoneyType = 2 then ShopList := g_ShopGoldList[ShopIndex]
    else ShopList := g_ShopList[ShopIndex];

    if idx < ShopList.Count then begin
      ShopItem := ShopList[idx];
      if (ShopSelectIdx = Idx) and (ShopSelectIndex <> 0) then nFColor := clRed
      else nFColor := clWhite;
      
      if ShopItem.CLientItem.S.name <> '' then begin
        d := GetBagItemImg(ShopItem.CLientItem.S.looks);
        if d <> nil then
          FrmDlg.RefItemPaint(dsurface, d,
            ax + 4 + (35 - d.Width) div 2,
            ay + 8 + (35 - d.Height) div 2,
            1,
            1,
            @ShopItem.CLientItem, False);
      end;

      with g_DXCanvas do begin
        if ShopItem.ClientShopItem.wTime > 0 then
          TextOut(ax + 47, ay + 2, ShopItem.CLientItem.s.Name + '(' + IntToStr(ShopItem.ClientShopItem.wTime) + '天)', clLime)
        else
          TextOut(ax + 47, ay + 2, ShopItem.CLientItem.s.Name, clLime);
        if ShopMoneyType = 2 then begin
          TextOut(ax + 47, ay + 20, '价格：' + IntToStr(GetShopAgio(ShopItem.ClientShopItem.nGoldPrict, ShopItem.ClientShopItem.btAgio)) + ' ' + g_sGoldName, nFColor);
        end else
        if ShopMoneyType = 0 then begin
          TextOut(ax + 47, ay + 20, '价格：' + IntToStr(GetShopAgio(ShopItem.ClientShopItem.nPrict, ShopItem.ClientShopItem.btAgio)) + ' ' + g_sGamePointName, nFColor);
        end else begin
          TextOut(ax + 47, ay + 20, '价格：' + IntToStr(GetShopAgio(ShopItem.ClientShopItem.nPrict, ShopItem.ClientShopItem.btAgio)) + ' ' + g_sGameGoldName, nFColor);
        end;
        if ShopItem.ClientShopItem.nCount > -1 then begin
          if ShopItem.ClientShopItem.nCount > 0 then
            TextOut(ax + 47, ay + 35, '剩余：' + IntToStr(ShopItem.ClientShopItem.nCount) + ' 件', nFColor)
          else
            TextOut(ax + 47, ay + 35, '剩余：已售完', clRed);
        end
        else
          TextOut(ax + 47, ay + 35, '剩余：∞', nFColor);
      end;
    end;
  end;
{$ELSE}
  with Sender as TDGrid do begin
    ax := SurfaceX(Rect.Left);
    ay := SurfaceY(Rect.Top);
    idx := ShopPage * (DShopGrid.ColCount * DShopGrid.RowCount) + ACol + ARow * ColCount;
    if ShopMoneyType = 2 then ShopList := g_ShopGoldList[ShopIndex]
    else ShopList := g_ShopList[ShopIndex];

    if idx < ShopList.Count then begin
      ShopItem := ShopList[idx];
      d := g_WMain99Images.Images[190 + Integer(ShopSelectIdx = Idx)];
      if d <> nil then
        DSurface.Draw(ax, ay, d.ClientRect, d, True);

      if ShopItem.CLientItem.S.name <> '' then begin
        d := GetBagItemImg(ShopItem.CLientItem.S.looks);
        if d <> nil then
          FrmDlg.RefItemPaint(dsurface, d,
            ax + 12 + (40 - d.Width) div 2,
            ay + 30 + (40 - d.Height) div 2,
            1,
            1,
            @ShopItem.CLientItem, False);
      end;
      if ShopItem.ClientShopItem.btAgio > 0 then begin
        d := g_WMain99Images.Images[541 - ShopItem.ClientShopItem.btAgio];
        if d <> nil then
          DSurface.Draw(ax + 147, ay + 50, d.ClientRect, d, True);
      end;
      with g_DXCanvas do begin
        if ShopItem.ClientShopItem.wTime > 0 then
          TextOut(ax + 12, ay + 12, ShopItem.CLientItem.s.Name + '（' + IntToStr(ShopItem.ClientShopItem.wTime) + '天）', $63BEDE)
        else
          TextOut(ax + 12, ay + 12, ShopItem.CLientItem.s.Name, $63BEDE);
        if ShopMoneyType = 2 then begin
          str := IntToStr(ShopItem.ClientShopItem.nGoldPrict) + ' ' + g_sGoldName;
          TextOut(ax + 98, ay + 30, str, $B6FF);
          TextOut(ax + 98, ay + 45,
            IntToStr(GetShopAgio(ShopItem.ClientShopItem.nGoldPrict, ShopItem.ClientShopItem.btAgio)) + ' ' +
            g_sGoldName, $B6FF);
        end else
        if ShopMoneyType = 0 then begin
          str := IntToStr(ShopItem.ClientShopItem.nPrict) + ' ' + g_sGamePointName;
          TextOut(ax + 98, ay + 30, str, $B6FF);
          TextOut(ax + 98, ay + 45,
            IntToStr(GetShopAgio(ShopItem.ClientShopItem.nPrict, ShopItem.ClientShopItem.btAgio)) + ' ' +
            g_sGamePointName, $B6FF);
        end else begin
          str := IntToStr(ShopItem.ClientShopItem.nPrict) + ' ' + g_sGameGoldName;
          TextOut(ax + 98, ay + 30, str, $B6FF);
          TextOut(ax + 98, ay + 45,
            IntToStr(GetShopAgio(ShopItem.ClientShopItem.nPrict, ShopItem.ClientShopItem.btAgio)) + ' ' +
            g_sGameGoldName, $B6FF);
        end;
        if ShopItem.ClientShopItem.nCount > -1 then begin
          if ShopItem.ClientShopItem.nCount > 0 then
            TextOut(ax + 98, ay + 60, IntToStr(ShopItem.ClientShopItem.nCount) + ' 件', $B6FF)
          else
            TextOut(ax + 98, ay + 60, '已售完', clRed);
        end
        else
          TextOut(ax + 98, ay + 60, '∞', $AD9E63);

        if ShopItem.ClientShopItem.btAgio > 0 then begin
          g_DXCanvas.MoveTo(ax + 98, ay + 30 + 6);
          g_DXCanvas.LineTo(ax + 98 + g_DXCanvas.TextWidth(str), ay + 30 + 6, $B6FF);
        end;

        {TextOut(ax + 62, ay + 30, '价格：', $AD9E63);
        TextOut(ax + 62, ay + 45, '获赠积分：', $AD9E63);
        TextOut(ax + 62, ay + 60, '有效期限：', $AD9E63);    }
        //Release;
      end;
    end;
  end;
{$IFEND}
end;

procedure TFrmDlg2.DShopGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
begin
  ShopSelectIdx := ShopPage * (DShopGrid.ColCount * DShopGrid.RowCount) + ACol + ARow * DShopGrid.ColCount;
  ShopSelectIndex := ShopIndex;
  if ShopMoneyType = 2 then begin
    if ShopSelectIdx < g_ShopGoldList[ShopIndex].Count then begin
      PlaySound(s_glass_button_click);
      DEditShopCount.Value := 1;
    end;
  end else begin
    if ShopSelectIdx < g_ShopList[ShopIndex].Count then begin
      PlaySound(s_glass_button_click);
      DEditShopCount.Value := 1;
    end;
  end;
end;

procedure TFrmDlg2.DShopWinDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  ShopItem: pTShopItem;
{$IF Var_Interface = Var_Default}
  n: Integer;
  str, sHint: string;
{$IFEND}
  nPic: Int64;
  ShopList: TList;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);

    if ShopIndex in [0..5] then begin
      if ShopMoneyType = 2 then ShopList := g_ShopGoldList[ShopIndex]
      else ShopList := g_ShopList[ShopIndex];

      ShopMaxPage := ShopList.Count div (DShopGrid.ColCount * DShopGrid.RowCount);
      if ShopList.Count > (ShopMaxPage * (DShopGrid.ColCount * DShopGrid.RowCount)) then
        Inc(ShopMaxPage);
      Dec(ShopMaxPage);
      if ShopMaxPage < 0 then
        ShopMaxPage := 0;
      if ShopPage > ShopMaxPage then
        ShopPage := ShopMaxPage;
      if ShopPage < 0 then
        ShopPage := 0;
      DButFront.Enabled := True;
      DButNext.Enabled := True;
      DButFront2.Enabled := True;
      DButNext2.Enabled := True;
      if ShopMaxPage = 0 then begin
        DButFront.Enabled := False;
        DButNext.Enabled := False;
        DButFront2.Enabled := False;
        DButNext2.Enabled := False;
      end
      else if ShopPage = 0 then begin
        DButFront.Enabled := False;
        DButFront2.Enabled := False;
      end
      else if ShopPage = ShopMaxPage then begin
        DButNext.Enabled := False;
        DButNext2.Enabled := False;
      end;
{$IF Var_Interface = Var_Mir2}
      ShopItem := nil;
      DShopGetGamePoint.Enabled := g_MySelf.m_nGamePoint > 0;
      if (ShopSelectIndex in [0..5]) and (ShopSelectIdx >= 0) then begin
        if ShopMoneyType = 2 then begin
          if ShopSelectIdx < g_ShopGoldList[ShopSelectIndex].Count then begin
            ShopItem := g_ShopGoldList[ShopSelectIndex][ShopSelectIdx]
          end else
            ShopSelectIdx := -1;
        end else begin
          if ShopSelectIdx < g_ShopList[ShopSelectIndex].Count then begin
            ShopItem := g_ShopList[ShopSelectIndex][ShopSelectIdx]
          end else
            ShopSelectIdx := -1;
        end;
      end
      else
        ShopSelectIdx := -1;
{$ELSE}
      ShopItem := nil;
      DShopGetGamePoint.Enabled := g_MySelf.m_nGamePoint > 0;
      if (ShopSelectIdx >= 0) and (ShopSelectIdx < ShopList.Count) then begin
        ShopItem := ShopList[ShopSelectIdx];
      end
      else
        ShopSelectIdx := -1;  
{$IFEND}

      DBotBuy.Enabled := False;
      if ShopItem <> nil then begin
        d := GetBagItemImg(ShopItem.CLientItem.S.looks);
        if d <> nil then
{$IF Var_Interface = Var_Mir2}
          FrmDlg.RefItemPaint(dsurface, d,
            ax + 73 + (33 - d.Width) div 2,
            ay + 83 + (30 - d.Height) div 2,
            1,
            1,
            @ShopItem.CLientItem, False);
{$ELSE}
          FrmDlg.RefItemPaint(dsurface, d,
            ax + 78 + (34 - d.Width) div 2,
            ay + 116 + (32 - d.Height) div 2,
            1,
            1,
            @ShopItem.CLientItem, False);
{$IFEND}


      end;
      with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
        TextOut(ax + 244, ay + 354, IntToStr(ShopPage + 1) + '/' + IntToStr(ShopMaxPage + 1), clWhite);

        //TextOut(ax + 34, ay + 504, g_sGameGoldName + ': ' + GetGoldStr(g_MySelf.m_nGameGold), $84AEBD);
        //TextOut(ax + 34, ay + 525, g_sGamePointName +': ' + GetGoldStr(g_MySelf.m_nGamePoint), $84AEBD);
        TextOut(ax + 68, ay + 306, GetGoldStr(g_MySelf.m_nGold), clWhite);
        TextOut(ax + 68, ay + 330, GetGoldStr(g_MySelf.m_nGameGold), clWhite);

        DEditShopCount.Enabled := (ShopItem <> nil);
        DBuyAdd.Enabled := DEditShopCount.Enabled;
        DBuyDel.Enabled := DEditShopCount.Enabled;
        if ShopItem <> nil then begin
          if (sm_Superposition in ShopItem.CLientItem.s.StdModeEx) and (ShopItem.CLientItem.s.DuraMax > 1) then begin
            if DEditShopCount.Value > ShopItem.CLientItem.s.DuraMax then
              DEditShopCount.Value := ShopItem.CLientItem.s.DuraMax;
          end else begin
            if DEditShopCount.Value > 10 then
              DEditShopCount.Value := 10;
          end;
          if DEditShopCount.Value <= 0 then
            DEditShopCount.Value := 1;

          if ShopItem.ClientShopItem.nCount <> -1 then
            DEditShopCount.Value := _MIN(DEditShopCount.Value, ShopItem.ClientShopItem.nCount);

          if ShopItem.ClientShopItem.wTime > 0 then
            TextOut(ax + 34, ay + 159, ShopItem.CLientItem.s.Name + '(' + IntToStr(ShopItem.ClientShopItem.wTime) + '天)', clLime)
          else
            TextOut(ax + 34, ay + 159, ShopItem.CLientItem.s.Name, clLime);

          //TextOut(ax + 40, ay + 329, ShopItem.CLientItem.s.Name, $84AEBD);
          nPic := Int64(GetShopAgio(ShopItem.ClientShopItem.nPrict, ShopItem.ClientShopItem.btAgio)) * Int64(DEditShopCount.Value);
          if ShopMoneyType = 2 then begin
            nPic := Int64(GetShopAgio(ShopItem.ClientShopItem.nGoldPrict, ShopItem.ClientShopItem.btAgio)) * Int64(DEditShopCount.Value);
            TextOut(ax + 34, ay + 245, IntToStr(nPic) + ' ' + g_sGoldName, clWhite);
          end else
          if ShopMoneyType = 0 then begin
            TextOut(ax + 34, ay + 245, IntToStr(nPic) + ' ' + g_sGamePointName, clWhite);
          end else begin
            TextOut(ax + 34, ay + 245, IntToStr(nPic) + ' ' + g_sGameGoldName, clWhite);
          end;

          if DEditShopCount.Value > 0 then begin
            if ShopMoneyType = 2 then begin
              if g_MySelf.m_nGold >= nPic then
                DBotBuy.Enabled := True;
            end else
            if ShopMoneyType = 0 then begin
              if g_MySelf.m_nGamePoint >= nPic then
                DBotBuy.Enabled := True;
            end else begin
              if g_MySelf.m_nGameGold >= nPic then
                DBotBuy.Enabled := True;
            end;
          end;
        end;
{$ELSE}
        //SetBkMode(Handle, TRANSPARENT);
        TextOut(ax + 212, ay + 91, '(在上角可以选择使用' + g_sGameGoldName + '或点卷消费)', $63C3DE);
        TextOut(ax + 613, ay + 91, IntToStr(ShopPage + 1) + '/' + IntToStr(ShopMaxPage + 1), $B5EBEF);
        TextOut(ax + 613, ay + 559, IntToStr(ShopPage + 1) + '/' + IntToStr(ShopMaxPage + 1), $B5EBEF);

        //TextOut(ax + 34, ay + 504, g_sGameGoldName + ': ' + GetGoldStr(g_MySelf.m_nGameGold), $84AEBD);
        //TextOut(ax + 34, ay + 525, g_sGamePointName +': ' + GetGoldStr(g_MySelf.m_nGamePoint), $84AEBD);
        TextOut(ax + 68, ay + 504, GetGoldStr(g_MySelf.m_nGameGold), $84AEBD);
        TextOut(ax + 68, ay + 525, GetGoldStr(g_MySelf.m_nGamePoint), $84AEBD);
        DEditShopCount.Enabled := (ShopItem <> nil);
        DBuyAdd.Enabled := DEditShopCount.Enabled;
        DBuyDel.Enabled := DEditShopCount.Enabled;
        if ShopItem <> nil then begin
          if (sm_Superposition in ShopItem.CLientItem.s.StdModeEx) and (ShopItem.CLientItem.s.DuraMax > 1) then begin
            if DEditShopCount.Value > ShopItem.CLientItem.s.DuraMax then
              DEditShopCount.Value := ShopItem.CLientItem.s.DuraMax;
          end else begin
            if DEditShopCount.Value > 10 then
              DEditShopCount.Value := 10;
          end;
          if DEditShopCount.Value <= 0 then
            DEditShopCount.Value := 1;

          if ShopItem.ClientShopItem.nCount <> -1 then
            DEditShopCount.Value := _MIN(DEditShopCount.Value, ShopItem.ClientShopItem.nCount);

          if ShopItem.ClientShopItem.wTime > 0 then
            TextOut(ax + 40, ay + 281, ShopItem.CLientItem.s.Name + '（' + IntToStr(ShopItem.ClientShopItem.wTime) + '天）', $84AEBD)
          else
            TextOut(ax + 40, ay + 281, ShopItem.CLientItem.s.Name, $84AEBD);

          //TextOut(ax + 40, ay + 329, ShopItem.CLientItem.s.Name, $84AEBD);
          nPic := Int64(GetShopAgio(ShopItem.ClientShopItem.nPrict, ShopItem.ClientShopItem.btAgio)) * Int64(DEditShopCount.Value);
          if ShopMoneyType = 2 then begin
            nPic := Int64(GetShopAgio(ShopItem.ClientShopItem.nGoldPrict, ShopItem.ClientShopItem.btAgio)) * Int64(DEditShopCount.Value);
            TextOut(ax + 40, ay + 377, IntToStr(nPic) + ' ' + g_sGoldName, $84AEBD);
            TextOut(ax + 40, ay + 425, '0 ' + g_sGameDiamondName, $84AEBD);
          end else
          if ShopMoneyType = 0 then begin

            TextOut(ax + 40, ay + 377, IntToStr(nPic) + ' ' + g_sGamePointName, $84AEBD);
            TextOut(ax + 40, ay + 425, IntToStr(nPic) + ' ' + g_sGameDiamondName, $84AEBD);
          end else begin
            TextOut(ax + 40, ay + 377, IntToStr(nPic) + ' ' + g_sGameGoldName, $84AEBD);
            TextOut(ax + 40, ay + 425, '0 ' + g_sGameDiamondName, $84AEBD);
          end;
          {if ShopItem.ClientShopItem.wTime = 0 then
            TextOut(ax + 40, ay + 425, '永久', $84AEBD)
          else
            TextOut(ax + 40, ay + 425, IntToStr(ShopItem.ClientShopItem.wTime) + ' 天', $84AEBD);  }
          if DEditShopCount.Value > 0 then begin
            if ShopMoneyType = 2 then begin
              if g_MySelf.m_nGold >= nPic then
                DBotBuy.Enabled := True;
            end else
            if ShopMoneyType = 0 then begin
              if g_MySelf.m_nGamePoint >= nPic then
                DBotBuy.Enabled := True;
            end else begin
              if g_MySelf.m_nGameGold >= nPic then
                DBotBuy.Enabled := True;
            end;
          end;

          if ShopItem.sHint <> '' then begin
            n := 0;
            str := ShopItem.sHint;
            while TRUE do begin
              if str = '' then
                break;
              str := GetValidStr3(str, sHint, ['|']);
              if sHint = '' then
                break;
              TextOut(ax + 36, ay + 162 + n * 14, sHint, clWhite);
              inc(n);
            end;
          end;
        end;

{$IFEND}
      end;
    end;
  end;
end;

procedure TFrmDlg2.DShopWinMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShopItem: pTShopItem;
{$IF Var_Interface = Var_Default}
  ShopList: TList;
{$IFEND}
begin
  with Sender as TDWindow do begin
    X := X - Left;
    Y := Y - Top;
    if (x >= 73) and (y >= 83) and (X <= 73 + 33) and (y <= 83 + 30) then begin
{$IF Var_Interface = Var_Mir2}
      ShopItem := nil;
      if (ShopSelectIndex in [0..5]) and (ShopSelectIdx >= 0) then begin
        if ShopMoneyType = 2 then begin
          if ShopSelectIdx < g_ShopGoldList[ShopSelectIndex].Count then begin
            ShopItem := g_ShopGoldList[ShopSelectIndex][ShopSelectIdx]
          end;
        end else begin
          if ShopSelectIdx < g_ShopList[ShopSelectIndex].Count then begin
            ShopItem := g_ShopList[ShopSelectIndex][ShopSelectIdx]
          end;
        end;
      end;
      if ShopItem <> nil then
        DScreen.ShowHint(SurfaceX(Left + X) + 30, SurfaceY(Top + Y) + 30, ShowItemInfo(ShopItem.CLientItem, [], [], False),
          clwhite, False, Integer(Sender), True);
{$ELSE}
      if ShopMoneyType = 2 then ShopList := g_ShopGoldList[ShopIndex]
      else ShopList := g_ShopList[ShopIndex];
      if (ShopSelectIdx >= 0) and (ShopSelectIdx < ShopList.Count) then begin
        ShopItem := ShopList[ShopSelectIdx];
        DScreen.ShowHint(SurfaceX(Left + X) + 30, SurfaceY(Top + Y) + 30, ShowItemInfo(ShopItem.CLientItem, [], []),
          clwhite, False, Integer(Sender), True);
      end
{$IFEND}
    end;
  end;
end;

procedure TFrmDlg2.DStorage1Click(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if Tag in [Low(g_boStorageRead)..High(g_boStorageRead)] then begin
      if StorageIdx <> Tag then begin
        if (GetTickCount > DStorageDlg.AppendTick) or g_boStorageRead[Tag] then begin
          StorageIdx := Tag;
          PlaySound(s_glass_button_click);
          if not g_boStorageRead[Tag] then begin
            DStorageDlg.AppendTick := GetTickCount + 10 * 1000;
            FrmMain.SendClientMessage(CM_GETBACKSTORAGE, g_nCurMerchant, Tag, 0, 0, '');
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DStorage1DirectPaint(Sender: TObject; dsurface: TDXTexture);
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
      if StorageIdx = tag then begin
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
      nTop := 1;
      if StorageIdx <> tag then begin
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

procedure TFrmDlg2.DStorage1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nHintX, nHintY: Integer;
  smsg: string;
begin
  with Sender as TDButton do begin
    if Tag in [1..4] then begin
      if g_boStorageOpen[Tag] then begin
        sMsg := '到期时间: ' + FormatDateTime('YYYY年MM月DD日 HH时', g_dwStorageTime[Tag])
      end else
        sMsg := '尚未开启使用';
      nHintX := SurfaceX(Left);
      nHintY := SurfaceY(Top);
      DScreen.ShowHint(nHintX, nHintY, smsg, clWhite, True, Integer(Sender));
    end;
  end;
end;

procedure TFrmDlg2.DStorageDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
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
      TextOut(ax + 20, ay + 297, '仓库' + g_sGoldName + ': ' + GetGoldStr(g_nStorageGold), clWhite);
{$ELSE}
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
      TextOut(ax + 22, ay + 336, '仓库' + g_sGoldName + ': ' + GetGoldStr(g_nStorageGold), clWhite);
{$IFEND}

    end;
    if g_MySelf = nil then exit;
    
    DStorageGetGold.Enabled := g_nStorageGold > 0;
    DStorageSaveGold.Enabled := g_MySelf.m_nGold > 0;
  end;
end;

procedure TFrmDlg2.DStorageDlgVisible(Sender: TObject; boVisible: Boolean);
begin
  StorageIdx := 255;
  FrmDlg.LastestClickTime := GetTickCount;
  if boVisible then begin
    g_SellDlgItemSellWait.Item.s.name := '';
    FrmDlg.DItemBag.Visible := True;
    FrmDlg.DMerchantDlg.Visible := False;
    DStorageDlg.AppendTick := 0;
    DStorage1Click(DStorage1, 0, 0);
  end else begin
    FrmDlg.DItemBag.Visible := FrmDlg.boOpenItemBag;
    //FrmDlg.DMerchantDlg.Visible := FrmDlg.MDlgVisible;
  end;
end;

procedure TFrmDlg2.DStorageGetGoldClick(Sender: TObject; X, Y: Integer);
var
  nMoney: Integer;
begin
  if Sender = DStorageGetGold then begin
    if mrYes = FrmDlg.DMessageDlg('请输入取出金额(1~' + IntToStr(g_nStorageGold) + ').',
      [mbYes, mbNo, mbAbort], 10, deInteger) then
    begin
      nMoney := StrToIntDef(Trim(FrmDlg.DlgEditText), 0);
      if (nMoney > 0) and (nMoney <= g_nStorageGold) then
        FrmMain.SendClientMessage(CM_STORAGEGOLDCHANGE, nMoney, 0, 0, 1, '');
    end;
  end else
  if Sender = DStorageSaveGold then begin
    if mrYes = FrmDlg.DMessageDlg('请输入存入金额(1~' + IntToStr(g_MySelf.m_nGold) + ').',
      [mbYes, mbNo, mbAbort], 10, deInteger) then
    begin
      nMoney := StrToIntDef(Trim(FrmDlg.DlgEditText), 0);
      if (nMoney > 0) and (nMoney <= g_MySelf.m_nGold) then
        FrmMain.SendClientMessage(CM_STORAGEGOLDCHANGE, nMoney, 0, 0, 2, '');
    end;
  end;
end;

procedure TFrmDlg2.DStorageGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_StorageArr[StorageIdx])..High(g_StorageArr[StorageIdx])] then begin
      if g_StorageArr[StorageIdx][idx].s.Name <> '' then begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(g_StorageArr[StorageIdx][idx], [mis_StorageBack], []), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg2.DStorageGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
  pRect: TRect;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_StorageArr[StorageIdx])..High(g_StorageArr[StorageIdx])] then begin
      if g_StorageArr[StorageIdx][idx].S.name <> '' then begin
        d := GetBagItemImg(g_StorageArr[StorageIdx][idx].S.looks);
        if d <> nil then begin
          pRect.Left := SurfaceX(Rect.Left);
          pRect.Top := SurfaceY(Rect.Top);
          pRect.Right := SurfaceX(Rect.Right + 1);
          pRect.Bottom := SurfaceY(Rect.Bottom);
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
              SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
              SurfaceX(Rect.Right),
              SurfaceY(Rect.Bottom) - 12,
              @g_StorageArr[StorageIdx][idx], True, [pmShowLevel], @pRect);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.AutoStorage(nItemIndex: Integer);
var
  i: integer;
begin
  if (g_SellDlgItemSellWait.Item.s.name <> '') or g_boItemMoving then exit;
  if (g_ItemArr[nItemIndex].S.name <> '') and (not (CheckItemBindMode(@g_ItemArr[nItemIndex].UserItem, bm_NoSave))) then begin
    if g_boStorageOpen[StorageIdx] then begin
      for i := Low(g_StorageArr[StorageIdx]) to High(g_StorageArr[StorageIdx]) do begin
        if (g_StorageArr[StorageIdx][i].s.Name = '') then begin
          g_boItemMoving := True;
          g_MovingItem.Index2 := nItemIndex;
          g_MovingItem.Item := g_ItemArr[nItemIndex];
          g_MovingItem.ItemType := mtBagItem;
          DelItemBagByIdx(nItemIndex);
          ItemClickSound(g_ItemArr[nItemIndex].S);
          DStorageGridGridSelect(DStorageGrid, 0, 0, i, 0, []);
          exit;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DStorageGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  i: integer;
begin
  if (g_MySelf = nil) or (not g_boStorageOpen[StorageIdx]) then exit;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_StorageArr[StorageIdx])..High(g_StorageArr[StorageIdx])] then begin
      if not g_boItemMoving then begin
        if (g_SellDlgItemSellWait.Item.s.name = '') and (g_StorageArr[StorageIdx][idx].s.Name <> '') then begin
          for I := 0 to g_StorageArrList[StorageIdx].Count - 1 do begin
            if g_StorageArrList[StorageIdx][i] = @g_StorageArr[StorageIdx][idx] then begin
              g_SellDlgItemSellWait.Item := g_StorageArr[StorageIdx][idx];
              g_SellDlgItemSellWait.Index2 := MakeLong(StorageIdx, idx);
              g_SellDlgItemSellWait.ItemType := mtBagItem;
              frmMain.SendTakeBackStorageItem(g_nCurMerchant, g_StorageArr[StorageIdx][idx].UserItem.MakeIndex,
                                               MakeLong(StorageIdx, I));
              g_StorageArr[StorageIdx][idx].s.Name := '';
              g_StorageArrList[StorageIdx].Delete(I);
              break;
            end;
          end;
        end;
      end else
      if (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') and
         (g_StorageArr[StorageIdx][idx].s.Name = '') and
         (g_SellDlgItemSellWait.Item.s.name = '') then begin
        if CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoSave) then begin
          FrmDlg.CancelItemMoving;
          FrmDlg.DMessageDlg('该物品不允许存入仓库.', [mbYes]);
          exit;
        end;
        g_SellDlgItemSellWait := g_MovingItem;
        frmMain.SendStorageItem(g_nCurMerchant, g_MovingItem.Item.UserItem.MakeIndex, MakeLong(StorageIdx, Idx));
        ClearMovingItem();
      end;
    end;
  end;
end;

procedure TFrmDlg2.DUpLoadExitDirectPaint(Sender: TObject; dsurface: TDXTexture);
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

procedure TFrmDlg2.DUpLoadFileListDblClick(Sender: TObject);
var
  HDInfo, HDInfo32: pTHDInfo;
  HDInfo28: THDInfo;
  FileAttrs: Integer;
  sr: TSearchRec;
  sName: string;
  FileList: TList;
  i: integer;
label
  FindList;
begin
  if (HDInfoMove >= 0) and (HDInfoMove < g_MasterHDInfoList.Count) then begin
    HDInfo := g_MasterHDInfoList[HDInfoMove];
    HDInfo28 := HDInfo^;
    case HDInfo28.HDInfoType of
      HIT_Prior: begin
          HDInfoFileName := '';
          if HDInfo28.nLevel <= 2 then begin
            ClearMasterHDInfo(g_MasterHDInfoList);
            LoadMasterHDInfo();
            DUpDownUpLoad.Position := 0;
            DUpDownUpLoad.MaxPosition := g_MasterHDInfoList.Count - 10;
          end
          else begin
            HDInfo28.nLevel := HDInfo28.nLevel - 2;
            for I := Length(HDInfo28.sPlace) - 1 downto 1 do begin
              if HDInfo28.sPlace[i] = '\' then begin
                HDInfo28.sPlace := Copy(HDInfo28.sPlace, 1, I);
                break;
              end;
            end;

            goto FindList;
          end;
        end;
      HIT_Desktop,
        HIT_Pictures,
        HIT_Personal,
        HIT_Folder,
        HIT_HD: begin
          FindList:
          HDInfoFileName := '';
          ClearMasterHDInfo(g_MasterHDInfoList);
          FileList := TList.Create;
          FileAttrs := faReadOnly;
          FileAttrs := FileAttrs + faHidden;
          FileAttrs := FileAttrs + faDirectory;
          FileAttrs := FileAttrs + faArchive;
          FileAttrs := FileAttrs + faAnyFile;
          if FindFirst(HDInfo28.sPlace + '*.*', FileAttrs, sr) = 0 then begin
            repeat
              if (Sr.Attr and faDirectory) = faDirectory then begin
                if sr.Name[1] <> '.' then begin
                  New(HDInfo32);
                  HDInfo32.nLevel := HDInfo28.nLevel + 1;
                  HDInfo32.sName := sr.Name;
                  HDInfo32.sShowName := CheckFileNameLen(HDInfo32.sName, HDInfo32.boChange);
                  HDInfo32.sPlace := CheckFilePath(HDInfo28.sPlace + HDInfo32.sName);
                  HDInfo32.HDInfoType := HIT_Folder;
                  HDInfo32.nImageID := GetHDInfoImage(HDInfo32.HDInfoType);
                  g_MasterHDInfoList.Add(HDInfo32);
                end;
              end
              else {if (sr.Attr and faAnyFile) = faArchive then} begin
                sName := UpperCase(RightStr(sr.Name, 4));
                if (sName = '.BMP') or (sName = '.JPG') or (sName = '.GIF') or (sName = '.JPEG') then begin
                  New(HDInfo32);
                  HDInfo32.nLevel := HDInfo28.nLevel + 1;
                  HDInfo32.sName := sr.Name;
                  HDInfo32.sShowName := CheckFileNameLen(HDInfo32.sName, HDInfo32.boChange);
                  HDInfo32.sPlace := HDInfo28.sPlace + HDInfo32.sName;
                  HDInfo32.HDInfoType := HIT_IMAGE;
                  HDInfo32.nImageID := GetHDInfoImage(HDInfo32.HDInfoType);
                  FileList.Add(HDInfo32);
                end;
              end;
            until FindNext(sr) <> 0;
            FindClose(sr);
          end;
          New(HDInfo32);
          HDInfo32.nLevel := HDInfo28.nLevel + 1;
          HDInfo32.sName := '返回上一级';
          HDInfo32.sShowName := CheckFileNameLen(HDInfo32.sName, HDInfo32.boChange);
          HDInfo32.sPlace := HDInfo28.sPlace;
          HDInfo32.HDInfoType := HIT_Prior;
          HDInfo32.nImageID := GetHDInfoImage(HDInfo32.HDInfoType);
          g_MasterHDInfoList.Insert(0, HDInfo32);
          if FileList.Count > 0 then
            for i := 0 to FileList.Count - 1 do
              g_MasterHDInfoList.Add(FileList[i]);

          DUpDownUpLoad.Position := 0;
          DUpDownUpLoad.MaxPosition := g_MasterHDInfoList.Count - 10;
          FileList.Free;
        end;
      HIT_IMAGE: begin
          if HDInfo28.sPlace <> HDInfoFileName then begin
            HDInfoFileName := HDInfo28.sPlace;
            HDInfoLeft := 0;
            HDInfoTop := 0;
            if HDInfoSurface <> nil then begin
              HDInfoSurface.Free;
              HDInfoSurface := nil;
            end;
            //更新
            case LoadImageFileToSurface(HDInfoFileName, HDInfoSurface) of
              0:
                FrmDlg.DMessageDlg('加载图像文件失败\请确认是否为有效的图像文件\或者不支持该类型', []);
              1:
                FrmDlg.DMessageDlg('加载图像文件失败\图像大小不能超过 800 * 600\且大小必需大于 10 * 10', []);
              2:
                FrmDlg.DMessageDlg('加载图像文件失败\系统错误[创建纹理失败]！', []) ;
            end;
          end;
        end;
    end;
  end;

end;

procedure TFrmDlg2.DUpLoadFileListDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, nY: integer;
  i: Integer;
  HDInfo: pTHDInfo;
  nWidth: Integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    for i := DUpDownUpLoad.Position to DUpDownUpLoad.Position + 9 do begin
      if i >= g_MasterHDInfoList.Count then
        break;
      nY := ay + (I - DUpDownUpLoad.Position) * 18;
      HDInfo := g_MasterHDInfoList[i];
      d := g_WMain99Images.Images[HDInfo.nImageID];
      if d <> nil then
        DrawWindow(dsurface, ax + 3, nY + (18 - d.Height) div 2, d);
    end;
    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      for i := DUpDownUpLoad.Position to DUpDownUpLoad.Position + 9 do begin
        if i >= g_MasterHDInfoList.Count then
          break;
        HDInfo := g_MasterHDInfoList[i];
        nY := ay + (I - DUpDownUpLoad.Position) * 18;
        if i = HDInfoMove then begin
          nWidth := TextWidth(HDInfo.sShowName) + 4;
          FillRect(ax + 21, ny + 1, nWidth, 16, $A062625A);
        end;

        TextOut(ax + 23, nY + 3, HDInfo.sShowName, $00C5D2BD);
      end;
      //Release;
    end;
  end;
end;

procedure TFrmDlg2.DUpLoadFileListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  HDInfo: pTHDInfo;
  nHintX, nHintY, nLocalX, nLocalY: Integer;
begin
  HDInfoMove := -1;
  with Sender as TDWindow do begin
    HDInfoMove := (Y - Top) div 18 + DUpDownUpLoad.Position;
    if (HDInfoMove >= 0) and (HDInfoMove < g_MasterHDInfoList.Count) then begin
      HDInfo := g_MasterHDInfoList[HDInfoMove];
      if HDInfo.boChange then begin
        with Sender as TDWindow do begin
          nLocalX := LocalX(X - Left);
          nLocalY := LocalY(Y - Top);
          nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX;
          nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
          DScreen.ShowHint(nHintX, nHintY, HDInfo.sName, clWhite, False, Integer(HDInfo));
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DUpLoadImageDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay: integer;
  Rect: TRect;
begin
  if HDInfoSurface = nil then
    exit;
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if HDInfoLeft < 0 then
      HDInfoLeft := 0;
    if HDInfoTop < 0 then
      HDInfoTop := 0;

    if HDInfoSurface.Width < Width then begin
      ax := ax + (Width - HDInfoSurface.Width) div 2;
      Rect.Left := 0;
      Rect.Right := HDInfoSurface.Width;
    end
    else begin
      if (HDInfoLeft + Width) > HDInfoSurface.Width then
        HDInfoLeft := HDInfoSurface.Width - Width;
      Rect.Left := HDInfoLeft;
      Rect.Right := HDInfoLeft + Width;
    end;
    if HDInfoSurface.Height < Height then begin
      aY := aY + (Height - HDInfoSurface.Height) div 2;
      Rect.Top := 0;
      Rect.Bottom := HDInfoSurface.Height;
    end
    else begin
      if (HDInfoTop + Height) > HDInfoSurface.Height then
        HDInfoTop := HDInfoSurface.Height - Height;
      Rect.Top := HDInfoTop;
      Rect.Bottom := HDInfoTop + Height;
    end;

    if HDInfoSurface <> nil then
      dsurface.Draw(ax, ay, Rect, HDInfoSurface, False);
  end;
end;

procedure TFrmDlg2.DUpLoadOkClick(Sender: TObject; X, Y: Integer);
var
  Rect: TRect;
  Bmp: TBitmap;
  Stream: TMemoryStream;
  Access: TDXAccessInfo;
  ReadBuffer, WriteBuffer: PChar;
  nCompressionQuality: Integer;
  boSave: Boolean;
begin
  with DUpLoadImage do begin
    if (HDInfoSurface <> nil) and (HDSaveJpeg = nil) then begin
      if HDInfoLeft < 0 then HDInfoLeft := 0;
      if HDInfoTop < 0 then HDInfoTop := 0;

      if HDInfoSurface.Width < Width then begin
        Rect.Left := 0;
        Rect.Right := HDInfoSurface.Width;
      end
      else begin
        if (HDInfoLeft + Width) > HDInfoSurface.Width then
          HDInfoLeft := HDInfoSurface.Width - Width;
        Rect.Left := HDInfoLeft;
        Rect.Right := HDInfoLeft + Width;
      end;
      if HDInfoSurface.Height < Height then begin
        Rect.Top := 0;
        Rect.Bottom := HDInfoSurface.Height;
      end
      else begin
        if (HDInfoTop + Height) > HDInfoSurface.Height then
          HDInfoTop := HDInfoSurface.Height - Height;
        Rect.Top := HDInfoTop;
        Rect.Bottom := HDInfoTop + Height;
      end;
      Bmp := TBitmap.Create;
      HDSaveJpeg := TJPEGImage.Create;
      Stream := TMemoryStream.Create;
      try
        Bmp.PixelFormat := pf32bit;
        Bmp.Width := Rect.Right - Rect.Left;
        Bmp.Height := Rect.Bottom - Rect.Top;
        if HDInfoSurface.Lock(lfWriteOnly, Access) then begin
          try
            for Y := 0 to Bmp.Height - 1 do begin
              ReadBuffer := Bmp.ScanLine[y];
              WriteBuffer := Pointer(Integer(Access.Bits) + (Y + Rect.Top) * Access.Pitch + Rect.Left * 4);
              Move(WriteBuffer^, ReadBuffer^, Bmp.Width * 4);
            end;
          finally
            HDInfoSurface.Unlock;
          end;
        end;
        nCompressionQuality := 90;
        boSave := False;
        while nCompressionQuality > 0 do begin
          HDSaveJpeg.Assign(bmp);
          HDSaveJpeg.CompressionQuality := nCompressionQuality;
          HDSaveJpeg.Compress;
          HDSaveJpeg.SaveToStream(Stream);
          if Stream.Size <= MAXPHOTODATASIZE then begin
            boSave := True;
            break;
          end;
          Dec(nCompressionQuality, 10);
          Stream.Free;
          Stream := TMemoryStream.Create;
          HDSaveJpeg.Free;
          HDSaveJpeg := TJPEGImage.Create;
        end;
        if not boSave then begin
          FrmDlg.DMessageDlg('上传失败，压缩图像文件错误，图像大小超过规定！', []) ;
          HDSaveJpeg.Free;
          HDSaveJpeg := nil;
          exit;
        end;
        //HDSaveJpeg.SaveToFile('d:\temp.jpg');
        DUpLoadOk.Caption := '正在上传';
        if Stream.Size > 0 then begin
          FrmMain.SendClientSocket(CM_SAVEUSERPHOTO, Stream.Size, 0, 0, 1, EncodeBuffer(Stream.Memory, Stream.Size));
        end else begin
          HDSaveJpeg.Free;
          HDSaveJpeg := nil;
        end;  
      finally
        Bmp.Free;
        Stream.Free;
      end;
    end;
  end; 
end;

procedure TFrmDlg2.DUpLoadTopDirectPaint(Sender: TObject; dsurface: TDXTexture);
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

procedure TFrmDlg2.DUpLoadTopMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDButton do begin
    AppendTick := GetTickCount;
    if Sender = DUpLoadTop then begin
      if ssCtrl in Shift then
        Inc(HDInfoTop, 20)
      else
        Inc(HDInfoTop);
    end
    else if Sender = DUpLoadDown then begin
      if ssCtrl in Shift then
        Dec(HDInfoTop, 20)
      else
        Dec(HDInfoTop);
    end
    else if Sender = DUpLoadLeft then begin
      if ssCtrl in Shift then
        Inc(HDInfoLeft, 20)
      else
        Inc(HDInfoLeft);
    end
    else if Sender = DUpLoadRight then begin
      if ssCtrl in Shift then
        Dec(HDInfoLeft, 20)
      else
        Dec(HDInfoLeft);
    end;
    if Button <> mbMiddle then
      PlaySound(s_glass_button_click);
  end;
end;

procedure TFrmDlg2.DUserSellShopClearClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DUserSellShopClear then begin
    ClearShopSellItems;
    SafeFillChar(g_MyShopSellItems, SizeOf(g_MyShopSellItems), #0);
  end else
  if Sender = DUserBuyShopClear then begin
    SafeFillChar(g_MyShopBuyItems, SizeOf(g_MyShopBuyItems), #0);
  end;
end;

procedure TFrmDlg2.DUserShopBuyGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyShopBuyItems)..High(g_MyShopBuyItems)] then begin
      if g_MyShopBuyItems[idx].ShopItem.Item.s.Name <> '' then begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(g_MyShopBuyItems[idx].ShopItem.Item, [mis_ShopBuy],
          [g_MyShopBuyItems[idx].nMoney, Integer(g_MyShopBuyItems[idx].boGamePoint)]),
          clwhite, False, idx, True);
      end else begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          '单击输入要收购的物品名称\或者从背包中选择已有的物品拖入到这里进行收购！', clwhite, False, idx);
      end;
    end;
  end;
end;

procedure TFrmDlg2.DUserShopBuyGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyShopBuyItems)..High(g_MyShopBuyItems)] then begin
      if g_MyShopBuyItems[idx].ShopItem.Item.S.name <> '' then begin
        d := GetBagItemImg(g_MyShopBuyItems[idx].ShopItem.Item.S.looks);
        if d <> nil then begin
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
              SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
              SurfaceX(Rect.Right),
              SurfaceY(Rect.Bottom) - 12,
              @g_MyShopBuyItems[idx].ShopItem.Item, True);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DUserShopBuyGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  nMoney: Integer;
  valstr: string;
  temp: TMovingItem;
  cu: TMyShopItem;
  nGold: Int64;
  pGold: pInteger;
  StdItem:  TStdItem;
begin
  if (g_MySelf = nil) or (g_MySelf.m_boShop) then exit;

  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyShopBuyItems)..High(g_MyShopBuyItems)] then begin
      temp.Item.s.Name := '';
      if not g_boItemMoving then begin
        if g_MyShopBuyItems[idx].ShopItem.Item.s.Name = '' then begin
          FrmDlg.DMessageDlg('请输入你要收购的物品名称.', [mbYes, mbAbort], 20, deNone);
          GetValidStrVal(FrmDlg.DlgEditText, valstr, [' ']);
          if valstr <> '' then begin
            StdItem := GetStditemByName(valstr);
            if StdItem.Name <> '' then begin
              temp.Item.s := StdItem;
            end else begin
              FrmDlg.DMessageDlg('物品[' + valstr + ']不存在！', [mbYes]);
              Exit;
            end;
          end;
        end else begin
          SafeFillChar(g_MyShopBuyItems[idx], SizeOf(g_MyShopBuyItems[idx]), #0);
          Exit;
        end;
      end else begin
        if (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') and (g_MyShopBuyItems[idx].ShopItem.Item.s.Name = '') then begin
          temp := g_MovingItem;
          FrmDlg.DlgChecked := False;
          FrmDlg.CancelItemMoving;
        end;
      end;

      if (temp.Item.s.Name <> '') and (g_MyShopBuyItems[idx].ShopItem.Item.s.Name = '') then begin
        if mrYes = FrmDlg.DMessageDlg('请输入物品单价(1~50000000).', [mbYes, mbRetry, mbAbort], 10, deInteger)
        then begin
          GetValidStrVal(FrmDlg.DlgEditText, valstr, [' ']);
          nMoney := StrToIntDef(valstr, 0);
          if (nMoney > 0) and (nMoney <= 50000000) then begin
            cu.ShopItem := temp;
            cu.nMoney := nMoney;
            cu.boGamePoint := FrmDlg.DlgChecked;
            SafeFillChar(cu.ShopItem.Item.UserItem, SizeOf(cu.ShopItem.Item.UserItem), #0);
            cu.ShopItem.Item.UserItem.DuraMax := cu.ShopItem.Item.s.DuraMax;
            if (sm_Superposition in cu.ShopItem.Item.s.StdModeEx) and (cu.ShopItem.Item.s.DuraMax > 1) then begin
              FrmDlg.DMessageDlg('请输入收购数量(1~' + IntToStr(cu.ShopItem.Item.s.DuraMax) + ').', [mbYes, mbAbort], 10, deInteger);
              GetValidStrVal(FrmDlg.DlgEditText, valstr, [' ']);
              nMoney := StrToIntDef(valstr, 0);
              if (nMoney > 0) and (nMoney <= cu.ShopItem.Item.s.DuraMax) then begin
                cu.ShopItem.Item.UserItem.Dura := nMoney;
                nGold := Int64(GetShopBuyItemsGold(cu.boGamePoint)) + Int64(cu.nMoney) * Int64(nMoney);
                if cu.boGamePoint then pGold := @g_MySelf.m_nGameGold
                else pGold := @g_MySelf.m_nGold;
                if nGold > pGold^ then begin
                  if cu.boGamePoint then
                    FrmDlg.DMessageDlg('你身上的' + g_sGameGoldName + '不够.', [mbYes])
                  else
                    FrmDlg.DMessageDlg('你身上的' + g_sGoldName + '不够.', [mbYes]);
                  exit;
                end;
              end else begin
                FrmDlg.DMessageDlg('该物品最多只允许设定收购数量为：' + IntToStr(cu.ShopItem.Item.s.DuraMax) + '.', [mbYes]);
                exit;
              end;
            end else begin
              nGold := Int64(GetShopBuyItemsGold(cu.boGamePoint)) + Int64(cu.nMoney);
              if cu.boGamePoint then pGold := @g_MySelf.m_nGameGold
              else pGold := @g_MySelf.m_nGold;
              if nGold > pGold^ then begin
                if cu.boGamePoint then
                  FrmDlg.DMessageDlg('你身上的' + g_sGameGoldName + '不够.', [mbYes])
                else
                  FrmDlg.DMessageDlg('你身上的' + g_sGoldName + '不够.', [mbYes]);
                exit;
              end;
              cu.ShopItem.Item.UserItem.Dura := cu.ShopItem.Item.s.DuraMax;
            end;
            g_MyShopBuyItems[idx] := cu;
            exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DUserShopOpenClick(Sender: TObject; X, Y: Integer);
var
  i, nCount: integer;
  sSendMsg: string;
  ServerMyShopItem: TServerMyShopItem;
begin
  if g_MySelf = nil then exit;
  if not g_MySelf.m_boShop then begin
    if g_MySelf.m_btHorse <> 0 then begin
      FrmDlg.DMessageDlg('请先下马,骑马状态下无法摆摊!', [mbYes]);
      exit;
    end;
    if Int64(GetShopBuyItemsGold(True)) > g_MySelf.m_nGameGold then begin
      FrmDlg.DMessageDlg('你身上的' + g_sGameGoldName + '不够，无法完成收购.', [mbYes]);
      exit;
    end;
    if Int64(GetShopBuyItemsGold(False)) > g_MySelf.m_nGold then begin
      FrmDlg.DMessageDlg('你身上的' + g_sGoldName + '不够，无法完成收购.', [mbYes]);
      exit;
    end;
    sSendMsg := '';
    for I := Low(g_MyShopSellItems) to High(g_MyShopSellItems) do begin
      if g_MyShopSellItems[i].ShopItem.Item.s.Name <> '' then begin
        ServerMyShopItem.btIdx := i;
        ServerMyShopItem.boBuy := False;
        ServerMyShopItem.nMoney := g_MyShopSellItems[i].nMoney;
        ServerMyShopItem.boGameGold := g_MyShopSellItems[i].boGamePoint;
        ServerMyShopItem.nItemIndex := g_MyShopSellItems[i].ShopItem.Item.UserItem.MakeIndex;
        sSendMsg := sSendMsg + EncodeBuffer(@ServerMyShopItem, SizeOf(ServerMyShopItem)) + '/';
      end;
    end;
    nCount := 0;
    for I := Low(g_MyShopBuyItems) to High(g_MyShopBuyItems) do begin
      if g_MyShopBuyItems[i].ShopItem.Item.s.Name <> '' then begin
        ServerMyShopItem.btIdx := i;
        ServerMyShopItem.boBuy := True;
        ServerMyShopItem.nMoney := g_MyShopBuyItems[i].nMoney;
        ServerMyShopItem.boGameGold := g_MyShopBuyItems[i].boGamePoint;
        ServerMyShopItem.nItemIndex := MakeLong(g_MyShopBuyItems[i].ShopItem.Item.s.Idx + 1,
          _MAX(g_MyShopBuyItems[i].ShopItem.Item.UserItem.Dura, 1));
        sSendMsg := sSendMsg + EncodeBuffer(@ServerMyShopItem, SizeOf(ServerMyShopItem)) + '/';
        Inc(nCount);
      end;
    end;
    if nCount > GetBagResidualCount then begin
      FrmDlg.DMessageDlg('背包剩余空间不足以存放收购的物品，请选清理背包空间.', []);
      Exit;
    end;
    if sSendMsg <> '' then begin
      if mrYes = FrmDlg.DMessageDlg('请输入摊位招牌(1~24个字符).', [mbYes, mbAbort], 24, deStandard, g_MyShopTitle)
      then begin
        if Trim(FrmDlg.DlgEditText) <> '' then begin
          g_MyShopTitle := Trim(FrmDlg.DlgEditText);
          FrmMain.SendClientSocket(CM_USERSHOPCHANGE, 0, 0, 0, 0, EncodeString(g_MyShopTitle) + '/' + sSendMsg);
          DUserShopOpen.Enabled := False;
        end;
      end;
    end;
  end else begin
    FrmMain.SendClientSocket(CM_USERSHOPCHANGE, 0, 0, 0, 0, '');
    DUserShopOpen.Enabled := False;
  end;
end;

procedure TFrmDlg2.DUserShopSellGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyShopSellItems)..High(g_MyShopSellItems)] then begin
      if g_MyShopSellItems[idx].ShopItem.Item.s.Name <> '' then begin
        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(g_MyShopSellItems[idx].ShopItem.Item, [mis_ShopSell],
          [g_MyShopSellItems[idx].nMoney, Integer(g_MyShopSellItems[idx].boGamePoint)]),
          clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg2.DUserShopSellGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
  pRect: TRect;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyShopSellItems)..High(g_MyShopSellItems)] then begin
      if g_MyShopSellItems[idx].ShopItem.Item.S.name <> '' then begin
        d := GetBagItemImg(g_MyShopSellItems[idx].ShopItem.Item.S.looks);
        if d <> nil then begin
          pRect.Left := SurfaceX(Rect.Left);
          pRect.Top := SurfaceY(Rect.Top);
          pRect.Right := SurfaceX(Rect.Right + 1);
          pRect.Bottom := SurfaceY(Rect.Bottom);
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
              SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
              SurfaceX(Rect.Right),
              SurfaceY(Rect.Bottom) - 12,
              @g_MyShopSellItems[idx].ShopItem.Item, True, [pmShowLevel], @pRect);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DUserShopSellGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  nMoney: Integer;
  valstr: string;
  temp: TMovingItem;
  cu: TMyShopItem;
begin
  if (g_MySelf = nil) or (g_MySelf.m_boShop) then exit;

  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(g_MyShopSellItems)..High(g_MyShopSellItems)] then begin
      if not g_boItemMoving then begin
        if g_MyShopSellItems[idx].ShopItem.Item.s.Name <> '' then
          AddItemBag(g_MyShopSellItems[idx].ShopItem.Item, g_MyShopSellItems[idx].ShopItem.Index2);
        SafeFillChar(g_MyShopSellItems[idx], SizeOf(g_MyShopSellItems[idx]), #0);
      end else
      if (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') and
         (g_MyShopSellItems[idx].ShopItem.Item.s.Name = '') then begin
        if CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoDeal) then begin
          FrmDlg.CancelItemMoving;
          FrmDlg.DMessageDlg('该物品不允许摆摊交易！', [mbYes]);
          exit;
        end;
        FrmDlg.DlgChecked := False;
        temp := g_MovingItem;
        ClearMovingItem();
        if mrYes = FrmDlg.DMessageDlg('请输入物品单价(1~50000000).', [mbYes, mbRetry, mbAbort], 10, deInteger)
        then begin
          GetValidStrVal(FrmDlg.DlgEditText, valstr, [' ']);
          nMoney := StrToIntDef(valstr, 0);
          if (nMoney > 0) and (nMoney <= 50000000) then begin
            cu.ShopItem := temp;
            cu.nMoney := nMoney;
            cu.boGamePoint := FrmDlg.DlgChecked;
            AddSellItemToMyShop(cu, idx);
            exit;
          end;
        end;
        AddItemBag(temp.Item, temp.Index2);
      end;
    end;
  end;
end;

procedure TFrmDlg2.DWinEmailDirectPaint(Sender: TObject; dsurface: TDXTexture);
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
      TextOut(ax + 23, ay + 43, $B6C2A4, '类别');
      TextOut(ax + 113, ay + 43, $B6C2A4, '信件信息');
      TextOut(ax + 232, ay + 43, $B6C2A4, '时间');
      //Release;
    end;
{$IFEND}
    DEMailRead.Enabled := (EMailSelect >= 0) and (EMailSelect < g_EMailList.Count);
    DEMailDel.Enabled := DEMailRead.Enabled;
    DEMailDelAll.Enabled := (g_EMailList.Count > 0);
  end;
end;

procedure TFrmDlg2.DWinFriendDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  str: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
{$IF Var_Interface =  Var_Default}
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
{$IFEND}
      str := '';
      case FriendIndex of
        0: begin
            str := '好友列表';
            DFriendUpDown.MaxPosition := g_FriendList.Count - FRIENDCOUNT;
            DFriAddMem.Visible := True;
            DFriDelMem.Visible := True;
            DFriDelMem.Enabled := (FriendSelect <> -1);
          end;
        1: begin
            str := '禁言列表';
            DFriAddMem.Visible := True;
            DFriendUpDown.MaxPosition := g_MyBlacklist.Count - FRIENDCOUNT;
            DFriDelMem.Visible := True;
            DFriDelMem.Enabled := (FriendSelect <> -1);
          end;
        2: begin
            str := '密友列表';
            DFriAddMem.Visible := False;
            DFriDelMem.Visible := False;
            DFriendUpDown.MaxPosition := g_MyWhisperList.Count - FRIENDCOUNT;
          end;
      end;
{$IF Var_Interface =  Var_Default}
      TextOut(ax + 89 - TextWidth(Str) div 2, ay + 66 + 4, str, clWhite);
{$IFEND}
      //Release;
    end;
  end;
end;

procedure TFrmDlg2.DWinUpLoadDirectPaint(Sender: TObject; dsurface: TDXTexture);
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
    DUpLoadOk.Enabled := (HDInfoSurface <> nil) and (HDSaveJpeg = nil);
{$IF Var_Interface = Var_Default}
    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
    end;
{$IFEND}
  end;
end;

procedure TFrmDlg2.DWinUpLoadMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  HDInfoMove := -1;
end;

procedure TFrmDlg2.DWinUpLoadVisible(Sender: TObject; boVisible: Boolean);
begin
  DUpDownUpLoad.Position := 0;
  if boVisible then begin
    LoadMasterHDInfo();
    DUpLoadOk.Enabled := True;
    DUpLoadOk.Caption := '确认上传';
  end
  else begin
    ClearMasterHDInfo(g_MasterHDInfoList);
    HDInfoFileName := '';
    if HDInfoSurface <> nil then begin
      HDInfoSurface.Free;
      HDInfoSurface := nil;
    end;
    {if HDInfoDIB <> nil then begin
      HDInfoDIB.Free;
      HDInfoDIB := nil;
    end; }
  end;
  DUpDownUpLoad.MaxPosition := g_MasterHDInfoList.Count - 10;
end;

procedure TFrmDlg2.DWndBarDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  rc: TRect;
  nBarCount: Integer;
begin
  if GetTickCount > (BarTick + BarTime) then begin
    DWndBar.Visible := False;
    FrmMain.SendClientMessage(BarCmd, BarParam1, BarParam2, 0, 0, '');
    exit;
  end;

  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);

    //nBarCount := GetTickCount - BarTick;
    nBarCount := Round((GetTickCount - BarTick) / BarTime * 100);
{$IF Var_Interface = Var_Mir2}
    d := g_WMain99Images.Images[1626];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := Round(rc.Right / (BarTime / (GetTickCount - BarTick)));
      dsurface.Draw(ax + 18, ay + 36, rc, d, True);
    end;
    with g_DXCanvas do begin
      TextOut(ax + 17, ay + 17, clWhite, BarTitle);
      TextOut(ax + 84, ay + 32, IntToStr(nBarCount) + '%', clWhite);
    end;
{$ELSE}
    d := g_WMain99Images.Images[231];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := Round(rc.Right / (BarTime / (GetTickCount - BarTick)));
      dsurface.Draw(ax + 17, ay + 29, rc, d, True);
    end;
    with g_DXCanvas do begin
      TextOut(ax + 16, ay + 12, clWhite, BarTitle);
      TextOut(ax + 84, ay + 28, IntToStr(nBarCount) + '%', clWhite);
    end;
{$IFEND}

  end;
end;

procedure TFrmDlg2.DWndDeathDirectPaint(Sender: TObject; dsurface: TDXTexture);
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
{$IF Var_Interface = Var_Mir2}
    if dbtnAcceptCure.Visible <> g_boDoctorAlive then begin
      dbtnAcceptCure.Enabled := g_boDoctorAlive;
      dbtnAcceptCure.Visible := g_boDoctorAlive;
      if dbtnAcceptCure.Visible then begin
        dbtnAtOnceCure.Top := 55;
        dbtnBackCure.Top := 81;
      end else begin
        dbtnAtOnceCure.Top := 30;
        dbtnBackCure.Top := 69;
      end;
    end;
{$ELSE}
    dbtnAcceptCure.Enabled := g_boDoctorAlive;
{$IFEND}

   { with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
      TextOut(ax + 42, ay + 336, GetGoldStr(g_nStorageGold), clWhite);
    end;
    if g_MySelf = nil then exit;

    DStorageGetGold.Enabled := g_nStorageGold > 0;
    DStorageSaveGold.Enabled := g_MySelf.m_nGold > 0;  }
  end;
end;

procedure TFrmDlg2.DWndEMailNewVisible(Sender: TObject; boVisible: Boolean);
begin
  if boVisible then
    DEMailNewEdit.SetFocus;
  if EMailNewItem.Item.s.name <> '' then
    AddItemBag(EMailNewItem.Item, EMailNewItem.Index2);
  EMailNewItem.Item.s.name := '';
end;

procedure TFrmDlg2.DWndEMailReadDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  nGold: Integer;
  str: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
      TextOut(ax + 22, ay + 50, $B6C2A4, '信件标题：');
      TextOut(ax + 23, ay + 231, clWhite, '附件信息');
      TextOut(ax + 71, ay + 294, $468DD1, '只能在安全区操作');
      
      if Sender = DWndEMailRead then begin
        DEMailReadGold.Enabled := ReadEMailInfo.nGold > 0;
        TextOut(ax + 71, ay + 277, $B6C2A4, '左键单击获取物品');
        TextOut(ax + 22, ay + 74, $B6C2A4, '发信人：');
        TextOut(ax + 28, ay + 251, $B6C2A4, g_sGoldName + '：' + GetGoldStr(ReadEMailInfo.nGold));
        if ReadEMailInfo.ClientEMail.boSystem then begin
          TextOut(ax + 82, ay + 50, clRed, ReadEMailInfo.ClientEMail.sTitle);
          TextOut(ax + 70, ay + 74, clRed, '[系统]');
        end else begin
          TextOut(ax + 82, ay + 50, clWhite, ReadEMailInfo.ClientEMail.sTitle);
          TextOut(ax + 70, ay + 74, clWhite, ReadEMailInfo.ClientEMail.sSendName + '[玩家]');
        end;
        if (ReadEMailInfo.nGold = 0) and (ReadEMailInfo.Item.s.Name = '') then begin
          if (not ReadEMailInfo.ClientEMail.boSystem) or
            (ReadEMailInfo.ClientEMail.boRead and (ReadEMailInfo.ClientEMail.btTime >= 3)) or
            (ReadEMailInfo.ClientEMail.btTime >= 30) then
          begin
            str :=  '友情提示：邮件将在下次维护时删除';
          end else
          if not ReadEMailInfo.ClientEMail.boRead then begin
            str := '友情提示：邮件将在' + IntToStr(30 - ReadEMailInfo.ClientEMail.btTime) + '天后维护时删除'
          end else
          if ReadEMailInfo.ClientEMail.boRead then begin
            str := '友情提示：邮件将在' + IntToStr(3 - ReadEMailInfo.ClientEMail.btTime) + '天后维护时删除';
          end;
        end else begin
          str := '友情提示：邮件将在' + IntToStr(30 - ReadEMailInfo.ClientEMail.btTime) + '天后维护时删除'
        end;
        TextOut(ax + 22, ay + 317, $468DD1, str);
      end
      else if Sender = DWndEMailNew then begin
        TextOut(ax + 71, ay + 277, $B6C2A4, '将要发送的物品放到格子里');
        TextOut(ax + 22, ay + 74, $B6C2A4, '收信人：');
        TextOut(ax + 28, ay + 251, $B6C2A4, g_sGoldName + '：');
        nGold := GetEMailGold(DEditEMailNewGold.Value, EMailNewItem.Item.s.Name <> '');
        TextOut(ax + 22, ay + 317, $B6C2A4, '发送资费：' + GetGoldStr(nGold));
      end;
{$ELSE}
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
      TextOut(ax + 21, ay + 42, $B6C2A4, '信件标题：');
      TextOut(ax + 15, ay + 277, clWhite, '附件信息');
      TextOut(ax + 71, ay + 343, $468DD1, '只能在安全区操作');
      
      if Sender = DWndEMailRead then begin
        DEMailReadGold.Enabled := ReadEMailInfo.nGold > 0;
        TextOut(ax + 71, ay + 326, $B6C2A4, '左键单击获取物品');
        TextOut(ax + 21, ay + 68, $B6C2A4, '发信人：');
        TextOut(ax + 22, ay + 299, $B6C2A4, g_sGoldName + '：' + GetGoldStr(ReadEMailInfo.nGold));
        if ReadEMailInfo.ClientEMail.boSystem then begin
          TextOut(ax + 81, ay + 42, clRed, ReadEMailInfo.ClientEMail.sTitle);
          TextOut(ax + 69, ay + 68, clRed, '[系统]');
        end else begin
          TextOut(ax + 81, ay + 42, clWhite, ReadEMailInfo.ClientEMail.sTitle);
          TextOut(ax + 69, ay + 68, clWhite, ReadEMailInfo.ClientEMail.sSendName + '[玩家]');
        end;
        if (ReadEMailInfo.nGold = 0) and (ReadEMailInfo.Item.s.Name = '') then begin
          if (not ReadEMailInfo.ClientEMail.boSystem) or
            (ReadEMailInfo.ClientEMail.boRead and (ReadEMailInfo.ClientEMail.btTime >= 3)) or
            (ReadEMailInfo.ClientEMail.btTime >= 30) then
          begin
            str :=  '友情提示：邮件将在下次维护时删除';
          end else
          if not ReadEMailInfo.ClientEMail.boRead then begin
            str := '友情提示：邮件将在' + IntToStr(30 - ReadEMailInfo.ClientEMail.btTime) + '天后维护时删除'
          end else
          if ReadEMailInfo.ClientEMail.boRead then begin
            str := '友情提示：邮件将在' + IntToStr(3 - ReadEMailInfo.ClientEMail.btTime) + '天后维护时删除';
          end;
        end else begin
          str := '友情提示：邮件将在' + IntToStr(30 - ReadEMailInfo.ClientEMail.btTime) + '天后维护时删除'
        end;
        TextOut(ax + 16, ay + 369, $468DD1, str);
      end
      else if Sender = DWndEMailNew then begin
        TextOut(ax + 71, ay + 326, $B6C2A4, '将要发送的物品放到格子里');
        TextOut(ax + 21, ay + 68, $B6C2A4, '收信人：');
        TextOut(ax + 22, ay + 299, $B6C2A4, g_sGoldName + '：');
        nGold := GetEMailGold(DEditEMailNewGold.Value, EMailNewItem.Item.s.Name <> '');
        TextOut(ax + 13, ay + 373, $B6C2A4, '发送资费：' + GetGoldStr(nGold));
      end;
{$IFEND}
    end;
  end;
end;

procedure TFrmDlg2.DWndGroupMemberDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  i, n: Integer;
  GroupMember: pTGroupMember;
begin
  with DWndGroupMember do begin
    if Surface = nil then exit;
    if m_boChangeGroup then begin
      Surface.Clear;
      n := 0;
      for i := 0 to g_GroupMembers.Count - 1 do begin
        GroupMember := g_GroupMembers[i];
        if GroupMember.ClientGroup.UserID = g_MySelf.m_nRecogId then Continue;
        Surface.TextOutEx(52, 4 + n * 50, GroupMember.ClientGroup.UserName, clWhite);
        Inc(n);
      end;
      m_boChangeGroup := False;
    end;
    dsurface.Draw(SurfaceX(Left), SurfaceY(Top), Surface.ClientRect, Surface, TRUE);
  end;
end;

procedure TFrmDlg2.DWndGroupMemberInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
begin
  IsRealArea := False;
end;
procedure TFrmDlg2.DWndHintClick(Sender: TObject; X, Y: Integer);
var
  ClientMissionInfo: pTClientMissionInfo;
begin
  if m_SelectMissionClick <> nil then begin
    if m_SelectMissionClick.ClickType = mct_Button then begin
      if m_SelectMissionClick.ClientMissionInfo = nil then begin
        g_boCanDrawMissionInfo := not g_boCanDrawMissionInfo;
        m_boShowMissionChange := True;
        Exit;
      end else begin
        for ClientMissionInfo in g_MissionInfoList do begin
          if ClientMissionInfo = m_SelectMissionClick.ClientMissionInfo then begin
            ClientMissionInfo.boPinch := not ClientMissionInfo.boPinch;
            m_boShowMissionChange := True;
            Exit;
          end;
        end;
      end;
    end else
    if m_SelectMissionClick.ClickType = mct_Click then begin
      ExecuteScript(m_SelectMissionClick.sParam);
    end;
  end;
end;

procedure TFrmDlg2.DWndHintDirectPaint(Sender: TObject; DSurface: TDXTexture);
var
  ax, ay: integer;
  boDrawHeader: Boolean;
  boDrawTopHeader: Boolean;

  procedure DrawText(Surface: TDXTexture; ClientMissionInfo: pTClientMissionInfo; nY: Integer; sText: string);
  var
    nX, nPos: Integer;
    s10, s34: string;
    MissionClick: pTMissionClick;
  begin
    sText := FormatShowText(sText, ClientMissionInfo);
    nX := 36;
    with Surface do begin
      while True do begin
        if sText = '' then break;
        nPos := Pos('<', sText);
        if nPos > 0 then begin
          s10 := Copy(sText, 1, nPos - 1);
          if s10 <> '' then begin
            Surface.TextOutEx(nX, nY, s10, $CCCCCC);
            Inc(nX, g_DXCanvas.TextWidth(s10));
          end;
          sText := ArrestStringEx(sText, '<', '>', s10);
          if s10 <> '' then begin
            s34 := GetValidStr3(s10, s10, ['/']);
            if s34 <> '' then begin
              New(MissionClick);
              MissionClick.nX := nX;
              MissionClick.nY := nY;
              MissionClick.nWidth := g_DXCanvas.TextWidth(s10);
              MissionClick.nHeight := 14;
              MissionClick.ClickType := mct_Click;
              MissionClick.ClientMissionInfo := nil;
              MissionClick.sText := s10;
              MissionClick.sParam := s34;
              m_MissionClickList.Add(MissionClick);
              Surface.LineTo(nX, nY + g_DXCanvas.TextHeight(s10), MissionClick.nWidth, $FFFFFF00);
            end;
            Surface.TextOutEx(nX, nY, s10, clYellow);
            Inc(nX, g_DXCanvas.TextWidth(s10));
          end;
        end else begin
          Surface.TextOutEx(nX, nY, sText, $CCCCCC);
          break;
        end;
      end;
    end;
  end;

  function CanDrawName(Surface: TDXTexture; ClientMissionInfo: pTClientMissionInfo; nY: Integer; sText: string): Integer;
  var
    d: TDXTexture;
    MissionClick: pTMissionClick;
    sShowName: string;
    nHour, nMin: Integer;
  begin
    Result := nY;
    if not boDrawTopHeader then begin
      boDrawTopHeader := True;
      Inc(Result, 1);
      if not g_boCanDrawMissionInfo then d := g_WMain99Images.Images[640]
      else d := g_WMain99Images.Images[647];
      if d <> nil then begin
        New(MissionClick);
        MissionClick.nX := 0;
        MissionClick.nY := Result;
        MissionClick.nWidth := d.Width;
        MissionClick.nHeight := d.Height;
        MissionClick.ClickType := mct_Button;
        MissionClick.ClientMissionInfo := nil;
        MissionClick.sText := '';
        m_MissionClickList.Add(MissionClick);
        Surface.CopyTexture(0, Result, d);
      end;
      Inc(Result, 1);
      if not g_boCanDrawMissionInfo then sShowName := '展开任务提示'
      else sShowName := '收起任务提示';
      Surface.TextOutEx(18, Result, sShowName, $CCCC99);
      Inc(Result, 14);
    end;
    if not g_boCanDrawMissionInfo then Exit;
    if not boDrawHeader then begin
      boDrawHeader := True;
      Inc(Result, 1);
      if ClientMissionInfo.boPinch then d := g_WMain99Images.Images[640]
      else d := g_WMain99Images.Images[647];
      if d <> nil then begin
        New(MissionClick);
        MissionClick.nX := 18;
        MissionClick.nY := Result;
        MissionClick.nWidth := d.Width;
        MissionClick.nHeight := d.Height;
        MissionClick.ClickType := mct_Button;
        MissionClick.ClientMissionInfo := ClientMissionInfo;
        MissionClick.sText := '';
        m_MissionClickList.Add(MissionClick);
        Surface.CopyTexture(18, Result, d);
      end;
      Inc(Result, 1);
      sShowName := ClientMissionInfo.ClientMission.sMissionShowName;
      if ClientMissionInfo.MissionInfo.wTime > 0 then begin
        nHour := ClientMissionInfo.MissionInfo.wTime div 60;
        nMin := ClientMissionInfo.MissionInfo.wTime mod 60;
        if nHour > 0 then sShowName := Format('%s(剩余时间: %d小时%d分钟)', [sShowName, nHour, nMin])
        else sShowName := Format('%s(剩余时间: %d分钟)', [sShowName, nMin]);
      end;
      Surface.TextOutEx(36, Result, sShowName, $66CCFF);
      Inc(Result, 14);
    end;
    if not ClientMissionInfo.boPinch and (sText <> '') then begin
      DrawText(Surface, ClientMissionInfo, Result, sText);
      Inc(Result, 14);
    end;
  end;

  function CanScript(ClientMissionInfo: pTClientMissionInfo; Script: pTMissionScript): Boolean;
  var
    ClientMission: pTClientMission;
    MissionInfo: pTMissionInfo;
  begin
    Result := False;
    ClientMission := ClientMissionInfo.ClientMission;
    MissionInfo := @ClientMissionInfo.MissionInfo;
    if CompareText(Script.sParam1, 'CHECKFLAG') = 0 then begin
      Result := GetMissionFlagStatusEx(Script.sParam2, Script.nParam2) = Script.nParam3;
    end else
    if CompareText(Script.sParam1, 'ITEMCOUNTCOMPLETE') = 0 then begin
      if Script.nParam2 = 1 then begin
        if CompareText(Script.sParam3, 'TRUE') = 0 then begin
          Result := ClientMissionInfo.nItemCount1 >= ClientMission.CompleteItem[0].wItemCount;
        end else
          Result := ClientMissionInfo.nItemCount1 < ClientMission.CompleteItem[0].wItemCount;
      end else
      if Script.nParam2 = 2 then begin
        if CompareText(Script.sParam3, 'TRUE') = 0 then begin
          Result := ClientMissionInfo.nItemCount2 >= ClientMission.CompleteItem[1].wItemCount;
        end else
          Result := ClientMissionInfo.nItemCount2 < ClientMission.CompleteItem[1].wItemCount;
      end else begin
        if CompareText(Script.sParam3, 'TRUE') = 0 then begin
          Result := ClientMissionInfo.nItemCount3 >= ClientMission.CompleteItem[2].wItemCount;
        end else
          Result := ClientMissionInfo.nItemCount3 < ClientMission.CompleteItem[2].wItemCount;
      end;
    end else
    if CompareText(Script.sParam1, 'KILLMONCOMPLETE') = 0 then begin
      if Script.nParam2 = 1 then begin
        if CompareText(Script.sParam3, 'TRUE') = 0 then begin
          Result := MissionInfo.btKillCount1 >= ClientMission.btKillCount1;
        end else
          Result := MissionInfo.btKillCount1 < ClientMission.btKillCount1;
      end else begin
        if CompareText(Script.sParam3, 'TRUE') = 0 then begin
          Result := MissionInfo.btKillCount2 >= ClientMission.btKillCount2;
        end else
          Result := MissionInfo.btKillCount2 < ClientMission.btKillCount2;
      end;
    end;
  end;

  procedure RefMissionHint(Surface: TDXTexture);
  var
    ClientMissionInfo: pTClientMissionInfo;
    ClientMission: pTClientMission;
    Script: pTMissionScript;
    boCanEndIf: Boolean;
    nY: Integer;
    I: Integer;
  begin
    Surface.Clear;
    nY := 1;
    for I := 0 to m_MissionClickList.Count - 1 do begin
      Dispose(pTMissionClick(m_MissionClickList[I]));
    end;
    m_MissionClickList.Clear;
    for ClientMissionInfo in g_MissionInfoList do begin
      if not ClientMissionInfo.MissionInfo.boTrack then Continue;
      if boDrawTopHeader and not g_boCanDrawMissionInfo then break;
      
      ClientMission := ClientMissionInfo.ClientMission;
      boDrawHeader := False;
      boCanEndIf := False;
      if (ClientMission <> nil) and (ClientMission.ScriptList <> nil) then begin
        for Script in ClientMission.ScriptList do begin
          if boCanEndIf then begin
            if Script.sCMDCode = MCC_ENDIF then begin
              boCanEndIf := False;
              Continue;
            end;
          end else begin
            if Script.sCMDCode = MCC_IF then begin
              if not CanScript(ClientMissionInfo, Script) then
                boCanEndIf := True;
            end else
            if Script.sCMDCode = MCC_WRITE then begin
              nY := CanDrawName(Surface, ClientMissionInfo, nY, Script.sAllParam);
            end;
          end;
        end;
      end;
    end;
    m_boShowMissionChange := False;
    if nY > 1 then m_boCanShowMissionHint := True
    else m_boCanShowMissionHint := False;
  end;
begin
  with Sender as TDWindow do begin
    if Surface = nil then exit;
    if m_boShowMissionChange then
      RefMissionHint(DWndHint.Surface);
    if m_boCanShowMissionHint then begin
      ax := SurfaceX(Left);
      ay := SurfaceY(Top);
      DSurface.Draw(ax, ay, Surface.ClientRect, Surface, True);
      boDrawTopHeader := False;
      if m_SelectMissionClick <> nil then begin
        if m_SelectMissionClick.ClickType = mct_Click then begin
          if Downed then begin
            g_DXCanvas.TextOut(aX + m_SelectMissionClick.nX + 1,
              aY + m_SelectMissionClick.nY + 1, m_SelectMissionClick.sText, clLime);
          end else begin
            g_DXCanvas.TextOut(aX + m_SelectMissionClick.nX,
              aY + m_SelectMissionClick.nY, m_SelectMissionClick.sText, clAqua);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg2.DWndHintInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
var
  MissionClick: pTMissionClick;
begin
  m_SelectMissionClick := nil;
  if m_boCanShowMissionHint then begin
    for MissionClick in m_MissionClickList do begin
      if (X >= MissionClick.nX) and (Y >= MissionClick.nY) and
        (X <= (MissionClick.nX + MissionClick.nWidth)) and (Y <= (MissionClick.nY + MissionClick.nHeight)) then begin
        IsRealArea := True;
        m_SelectMissionClick := MissionClick;
        Exit;
      end;
    end;
    IsRealArea := False;
  end else
    IsRealArea := False;
end;

procedure TFrmDlg2.DWndHintLeave(Sender: TObject);
begin
  m_SelectMissionClick := nil;
end;

procedure TFrmDlg2.DWndHintMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if m_SelectMissionClick <> nil then begin
    if m_SelectMissionClick.ClickType = mct_Button then begin
      y := y + 30;
      if m_SelectMissionClick.ClientMissionInfo = nil then
        DScreen.ShowHint(x, y, '展开/收起 所有任务提示', clWhite, False, Integer(m_SelectMissionClick))
      else
        DScreen.ShowHint(x, y, '展开/收起 任务提示', clWhite, False, Integer(m_SelectMissionClick));
    end;
  end;
end;

procedure TFrmDlg2.dwndSysSetupDirectPaint(Sender: TObject; dsurface: TDXTexture);
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

    dbtnAcceptCure.Enabled := g_boDoctorAlive;
  end;
end;

procedure TFrmDlg2.DWndUserShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  if g_MySelf = nil then exit;

  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    with g_DXCanvas do begin
{$IF Var_Interface = Var_Mir2}
      TextOut(ax + 26, ay + 184, '摊位' + g_sGoldName + ':', $A5AE94);
      TextOut(ax + 26, ay + 209, '摊位' + g_sGameGoldName + ':', $A5AE94);
      TextOut(ax + 84, ay + 184, GetGoldStr(g_MyShopGold), $A5AE94);
      TextOut(ax + 84, ay + 209, GetGoldStr(g_MyShopGameGold), $A5AE94);
{$ELSE}
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
      TextOut(ax + 42 - 20, ay + 198, '摊位' + g_sGoldName + ':', $A5AE94);
      TextOut(ax + 42 - 20, ay + 221, '摊位' + g_sGameGoldName + ':', $A5AE94);
      TextOut(ax + 98 - 20, ay + 198, GetGoldStr(g_MyShopGold), $A5AE94);
      TextOut(ax + 98 - 20, ay + 221, GetGoldStr(g_MyShopGameGold), $A5AE94);  
{$IFEND}

    end;
    DUserSellShopClear.Enabled := not g_MySelf.m_boShop;
    DUserBuyShopClear.Enabled := not g_MySelf.m_boShop;
  end;
end;

procedure TFrmDlg2.DWndUserShopVisible(Sender: TObject; boVisible: Boolean);
begin
  if boVisible then begin
    FrmDlg.DItemBagShop.Caption := {$IF Var_Interface = Var_Default}'停止摆摊'{$ELSE}'摆摊界面'{$IFEND};
    if (g_MySelf <> nil) and (not g_MySelf.m_boShop) then
      RefShopSellItems;
  end else begin
    FrmDlg.DItemBagShop.Caption := {$IF Var_Interface = Var_Default}'开始摆摊'{$ELSE}'摆摊界面'{$IFEND};
    if (g_MySelf <> nil) and (not g_MySelf.m_boShop) then
      ClearShopSellItems;
  end;
  if g_MySelf.m_boShop then
    DUserShopOpen.Caption := '停止摆摊'
  else begin
    DUserShopOpen.Caption := '开始摆摊';
    g_MyShopGold := 0;
    g_MyShopGameGold := 0;
    DUserShopMemo.Lines.Clear;
  end;
end;

procedure TFrmDlg2.DWndWebDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  rc: TRect;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := g_WMain99Images.Images[579];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Left := ax;
      rc.Top := ay;
      rc.Right := rc.Left + d.Width;
      rc.Bottom := rc.Top + Height;
      g_DXCanvas.StretchDraw(rc, d.ClientRect, d, False);
    end;
    d := g_WMain99Images.Images[580];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Left := ax + (Width - 4);
      rc.Top := ay;
      rc.Right := rc.Left + d.Width;
      rc.Bottom := rc.Top + Height;
      g_DXCanvas.StretchDraw(rc, d.ClientRect, d, False);
    end;
    d := g_WMain99Images.Images[577];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := Width;
      dsurface.Draw(ax, ay, rc, d, FALSE);
      rc := d.ClientRect;
      rc.Left := rc.Right - 40;
      dsurface.Draw(ax + (Width - 40), ay, rc, d, FALSE);
    end;
    d := g_WMain99Images.Images[578];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := Width;
      dsurface.Draw(ax, ay + (Height - d.Height), rc, d, FALSE);

      rc := d.ClientRect;
      rc.Left := rc.Right - 40;
      dsurface.Draw(ax + (Width - 40), ay + (Height - d.Height), rc, d, FALSE);
    end;
    if FrmWeb.Visible then begin
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        TextOut(ax + 33, ay + 14, $B1D2B7, FrmWeb.m_sTitle);
        //TextOut(ax + 22, ay + 336, '仓库' + g_sGoldName + ': ' + GetGoldStr(g_nStorageGold), clWhite);
      end;
    end;
    if not FrmWeb.Visible then
      FrmWeb.ShowWeb(FsUrl);
      //FrmWeb.ShowWeb('http://pay.pay.kingsoft.com/fillweb/jxsjgame.jsp');
  end;
end;

procedure TFrmDlg2.DWndWebInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
begin
  IsRealArea := True;
end;

procedure TFrmDlg2.DWndWebVisible(Sender: TObject; boVisible: Boolean);
begin
  if not boVisible then begin
    FrmWeb.Hide;
    Windows.SetFocus(FrmMain.Handle);
    g_TopDWindow := nil;
  end else begin
    g_TopDWindow := DWndWeb;
  end;
  g_CanTab := not boVisible;
end;

procedure TFrmDlg2.FormCreate(Sender: TObject);
begin
  HDInfoFileName := '';
  HDInfoSurface := nil;
  //HDInfoDIB := nil;
  HDSaveJpeg := nil;
  m_boCanShowMissionHint := False;
  m_boShowMissionChange := False;
  m_MissionClickList := TList.Create;
end;

procedure TFrmDlg2.FormDestroy(Sender: TObject);
begin
  if HDInfoSurface <> nil then begin
    HDInfoSurface.Free;
    HDInfoSurface := nil;
  end;
  {if HDInfoDIB <> nil then begin
    HDInfoDIB.Free;
    HDInfoDIB := nil;
  end;  }
  if HDSaveJpeg <> nil then begin
    HDSaveJpeg.Free;
    HDSaveJpeg := nil;
  end;
  m_MissionClickList.Free;
end;

function TFrmDlg2.GetShopBuyItemsGold(boPoint: Boolean): Integer;
var
  i: integer;
begin
  Result := 0;
  for I := Low(g_MyShopBuyItems) to High(g_MyShopBuyItems) do begin
    if g_MyShopBuyItems[i].ShopItem.Item.s.Name <> '' then begin
      if (sm_Superposition in g_MyShopBuyItems[i].ShopItem.Item.s.StdModeEx) and (g_MyShopBuyItems[i].ShopItem.Item.s.DuraMax > 1) then begin
        if (boPoint and g_MyShopBuyItems[i].boGamePoint) or ((not boPoint) and (not g_MyShopBuyItems[i].boGamePoint))
        then
          Inc(Result, g_MyShopBuyItems[i].nMoney * g_MyShopBuyItems[i].ShopItem.Item.UserItem.Dura);
      end else begin
        if (boPoint and g_MyShopBuyItems[i].boGamePoint) or ((not boPoint) and (not g_MyShopBuyItems[i].boGamePoint))
        then
          Inc(Result, g_MyShopBuyItems[i].nMoney);
      end;
    end;
  end;
end;

function TFrmDlg2.GetShopSellItems(cu: TNewClientItem): Boolean;
var
  i: integer;
begin
  Result := False;
  if DWndUserShop.Visible then begin
    for i := Low(g_MyShopSellItems) to High(g_MyShopSellItems) do begin
      if (g_MyShopSellItems[i].ShopItem.Item.UserItem.MakeIndex = cu.UserItem.MakeIndex) and
        (g_MyShopSellItems[i].ShopItem.Item.UserItem.wIndex = cu.UserItem.wIndex) then begin
        Result := True;
        break;
      end;
    end;
  end;
end;

end.






