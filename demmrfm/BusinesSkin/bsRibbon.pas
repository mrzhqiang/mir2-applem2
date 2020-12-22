{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       BusinessSkinForm                                            }
{       Version 9.45                                                }
{                                                                   }
{       Copyright (c) 2000-2011 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}


unit bsribbon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls,
  bsSkinCtrls, bsUtils, bsSkinData, ImgList, bsSkinMenus, bsSkinHint;

type

  TbsRibbon = class;
  TbsAppMenu = class;
  TbsAppMenuItem = class;
  TbsAppMenuPage = class;


  TbsRibbonPage = class;

  TbsAppButton = class(TbsSkinMenuButton)
  protected
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure TrackMenu; override;
    function CanMenuTrack(X, Y: Integer): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;  
  public
    Ribbon: TbsRibbon;
    constructor Create(AOwner: TComponent); override;
  end;

  TbsRibbonTab = class(TCollectionItem)
  protected
    FPage: TbsRibbonPage;
    FVisible: Boolean;
    procedure SetPage(const Value: TbsRibbonPage);
    procedure SetVisible(Value: Boolean);
  public
    Active: Boolean;
    ItemRect: TRect;
    Width: Integer;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Page: TbsRibbonPage read FPage write SetPage;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  TbsRibbonTabs = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsRibbonTab;
    procedure SetItem(Index: Integer; Value:  TbsRibbonTab);
  protected
    Ribbon: TbsRibbon;
    DestroyPage: TbsRibbonPage;
    function GetOwner: TPersistent; override;
    procedure CreatePageForItem(AItem: TbsRibbonTab);
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(ARibbon: TbsRibbon);
    property Items[Index: Integer]: TbsRibbonTab read GetItem write SetItem; default;
    function Add: TbsRibbonTab;
    function Insert(Index: Integer): TbsRibbonTab;
    procedure Delete(Index: Integer);
    procedure Clear;
  end;

  TbsRibbonButtonItem = class(TCollectionItem)
  private
    FImageIndex: Integer;
    FHint: String;
    FEnabled: Boolean;
    FVisible: Boolean;
    FOnClick: TNotifyEvent;
    FPopupMenu: TbsSkinPopupMenu;
  protected
    procedure SetImageIndex(const Value: Integer); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
    procedure SetVisible(Value: Boolean); virtual;
  public
    ItemRect: TRect;
    Active: Boolean;
    Down: Boolean;
    Code: Integer;
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    property PopupMenu: TbsSkinPopupMenu
      read FPopupMenu write FPopupMenu;
  published
    property ImageIndex: Integer read FImageIndex
      write SetImageIndex default -1;
    property Hint: String read FHint write FHint;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Visible: Boolean read FVisible write SetVisible;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TbsRibbonButtonItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsRibbonButtonItem;
    procedure SetItem(Index: Integer; Value:  TbsRibbonButtonItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    Ribbon: TbsRibbon;
    constructor Create(ARibbon: TbsRibbon);
    property Items[Index: Integer]: TbsRibbonButtonItem read GetItem write SetItem; default;
    function Add: TbsRibbonButtonItem;
    function Insert(Index: Integer): TbsRibbonButtonItem;
    procedure Delete(Index: Integer);
    procedure Clear;
  end;

  TbsRibbonGroup = class(TbsSkinCustomControl)
  private
    FOnDialogButtonClick: TNotifyEvent;
    FShowDialogButton: Boolean;
    BRect: TRect;
    BActive, BDown: Boolean;
    FMouseIn: Boolean;
    FSkinRect: TRect;

    procedure TestActive(X, Y: Integer);
    procedure UpDateButton;
    procedure SetShowDialogButton(Value: Boolean);
  protected
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure GetSkinData; override;

    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;

    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;

    procedure AdjustClientRect(var Rect: TRect); override;

  public
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    ButtonRect, ButtonActiveRect, ButtonDownRect: TRect;
    ButtonTransparent: Boolean;
    ButtonTransparentColor: TColor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
  published
    property Align;
    property Caption;
    property ShowDialogButton: Boolean read FShowDialogButton write SetShowDialogButton;
    property OnDialogButtonClick: TNotifyEvent
      read FOnDialogButtonClick write FOnDialogButtonClick;
  end;

  TbsRibbon = class(TbsSkinControl)
  private
    FOnChangePage: TNotifyEvent;
    FOnMenuClose: TNotifyEvent;
    FInAppHook: Boolean;
    FAppMenu: TbsAppMenu;
    FMDIButtons: TbsRibbonButtonItems;
    FButtons: TbsRibbonButtonItems;
    FButtonsImageList: TCustomImageList;
    FButtonsShowHint: Boolean;
    //
    FSkinHint: TbsSkinHint;
    FShowDivider: Boolean;
    FUseSkinFont: Boolean;
    FTabs: TbsRibbonTabs;
    FTabIndex: Integer;
    WMEraseReady: Boolean;
    FLeftOffset, FRightOffset: Integer;
    FOldTabActive, FTabActive: Integer;
    FActiveButton, FOldActiveButton: Integer;
    FMDIActiveButton, FMDIOldActiveButton: Integer;
    FAppButtonWidth: Integer;
    FAppButton: TbsAppButton;
    //
    FAppButtonImageList: TCustomImageList;
    FAppButtonImageIndex: Integer;
    FAppButtonPopupMenu: TbsSkinPopupMenu;
    //
    FMouseCaptureButton: Integer;
    FMouseCaptureMDIButton: Integer;
    FPopupButton: Integer;
    //
    procedure GetMDIButtonsSize(var w, h: Integer);
    procedure SetAppButtonImageList(Value: TCustomImageList);
    procedure SetAppButtonImageIndex(Value: Integer);
    procedure SetAppButtonPopupMenu(Value: TbsSkinPopupMenu);
    //
    procedure SetButtons(Value: TbsRibbonButtonItems);
    procedure ShowAppButton;
    function RibbonTopHeight: Integer;
    procedure SetTabs(AValue: TbsRibbonTabs);
    function GetTabIndex: Integer;
    procedure SetTabIndex(const Value: Integer);
    procedure SetActivePage(const Value: TbsRibbonPage);
    function GetActivePage: TbsRibbonPage;
    function GetPageIndex(Value: TbsRibbonPage): Integer;
    function GetPageBoundsRect: TRect;
    procedure SetAppButtonWidth(Value: Integer);
    function AnyTabVisible: Boolean;
    function TabFromPoint(P: TPoint): Integer;
    procedure MDICloseClick(Sender: TObject);
    procedure MDIMinClick(Sender: TObject);
    procedure MDIRestoreClick(Sender: TObject);
    procedure SetAppMenu(Value: TbsAppMenu);
  protected
    FStopCheckTabIndex: Boolean;
    //
    OldAppMessage: TMessageEvent;
    procedure HookApp;
    procedure UnHookApp;
    procedure NewAppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure HideTrackMenu(Sender: TObject);
    //
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;
    procedure WMCloseSkinMenu(var Message: TMessage); message WM_CLOSESKINMENU;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure FindNextPage;
    procedure FindPriorPage(AppButtonSupport: Boolean);
    procedure FindFirst;
    procedure FindLast;
    procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure TestActive(X, Y: Integer);
    procedure Loaded; override;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure GetSkinData; override;
    procedure PaintRibbon(C: TCanvas);
    procedure PaintBG(C: TCanvas; R: TRect);
    procedure CalcItemRects(C: TCanvas);
    procedure DrawTab(C: TCanvas; Index: Integer);
    procedure DrawDefTab(C: TCanvas; Index: Integer);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetSkinData(Value: TbsSkinData); override;
    function GetAppButton: TbsAppButton;
    procedure DrawButton(Cnvs: TCanvas; Index: Integer);
    procedure DrawMDIButton(Cnvs: TCanvas; Index: Integer);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    //
    procedure ShowMDIButtons;
    procedure HideMDIButtons;
    //
    procedure TrackMenu(APopupRect: TRect; APopupMenu: TbsSkinPopupMenu);
  public
    FData: TbsDataSkinTabControl;
    FDataPicture: TBitMap;
    BSF: TComponent;
    procedure ShowAppMenu;
    procedure HideAppMenu(Item: TbsAppMenuItem);
    procedure MDIChildMaximize;
    procedure MDIChildRestore;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure ChangeSkinData; override;
    property AppButton: TbsAppButton read GetAppButton;
  published
    property Constraints;
    property Align;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Font;
    property Tabs: TbsRibbonTabs read FTabs write SetTabs;
    property TabIndex: Integer read GetTabIndex write SetTabIndex;
    property ActivePage: TbsRibbonPage read GetActivePage write SetActivePage;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property AppButtonWidth: Integer read FAppButtonWidth write SetAppButtonWidth;
    property AppButtonImageList: TCustomImageList
      read FAppButtonImageList write SetAppButtonImageList;
    property AppButtonImageIndex: Integer
      read FAppButtonImageIndex write SetAppButtonImageIndex;
    property AppButtonPopupMenu: TbsSkinPopupMenu
      read FAppButtonPopupMenu write SetAppButtonPopupMenu;
    property Buttons: TbsRibbonButtonItems read FButtons write SetButtons;
    property ButtonsImageList: TCustomImageList read
      FButtonsImageList write FButtonsImageList;
    property ButtonsShowHint: Boolean
      read FButtonsShowHint write FButtonsShowHint;
    property SkinHint: TbsSkinHint
      read FSkinHint write FSkinHint;
    property AppMenu: TbsAppMenu read FAppMenu write SetAppMenu;
    property OnMenuClose: TNotifyEvent
      read FOnMenuClose write FOnMenuClose;
    property OnChangePage: TNotifyEvent read FOnChangePage write FOnChangePage;
    property OnClick;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TbsRibbonCustomPage = class(TCustomControl)
  private
    FCanScroll: Boolean;
    FHotScroll: Boolean;
    TimerMode: Integer;
    SMax, SPosition, SPage, SOldPosition: Integer;
    FHSizeOffset: Integer;
    FScrollOffset: Integer;
    FScrollTimerInterval: Integer;
    Buttons: array[0..1] of TbsControlButton;
    PanelData: TbsDataSkinPanelControl;
    ButtonData: TbsDataSkinButtonControl;
    FMouseIn: Boolean;
    procedure SetScrollOffset(Value: Integer);
    procedure SetScrollTimerInterval(Value: Integer);
    procedure DrawButton(Cnvs: TCanvas; i: Integer);
    procedure SetPosition(const Value: integer);
  protected
    function CheckActivation: Boolean;
    procedure WMSETCURSOR(var Message: TWMSetCursor); message WM_SetCursor;
    procedure WMDESTROY(var Message: TMessage); message WM_DESTROY;
    procedure WMTimer(var Message: TWMTimer); message WM_Timer;
    procedure WMNCCALCSIZE(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPAINT(var Message: TMessage); message WM_NCPAINT;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure CMMouseEnter;
    procedure CMMouseLeave;
    procedure WndProc(var Message: TMessage); override;
    procedure SetButtonsVisible(AVisible: Boolean);
    procedure ButtonClick(I: Integer);
    procedure ButtonDown(I: Integer);
    procedure ButtonUp(I: Integer);
    procedure GetHRange;
    procedure HScrollControls(AOffset: Integer);
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure StartTimer;
    procedure StopTimer;
    procedure CMBENCPaint(var Message: TMessage); message CM_BENCPAINT;
    procedure CMSENCPaint(var Message: TMessage); message CM_SENCPAINT;
  public
    Ribbon: TbsRibbon;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure UpDateSize;
    procedure GetScrollInfo;
    property Position: integer read SPosition write SetPosition;
  published
    property HotScroll: Boolean read FHotScroll write FHotScroll;
    property Align;
    property ScrollOffset: Integer read FScrollOffset write SetScrollOffset;
    property ScrollTimerInterval: Integer
    read FScrollTimerInterval write SetScrollTimerInterval;
    property CanScroll: Boolean read FCanScroll write FCanScroll;
  end;

  TbsRibbonPage = class(TbsRibbonCustomPage)
  protected
    FCaption: String;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure SetCaption(Value: String);
    procedure PaintBG(DC: HDC);
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    procedure Paint; override;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
  published
    property Caption: String read FCaption write SetCaption;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TbsAppMenuItem = class(TCollectionItem)
  protected
    FOnClick: TNotifyEvent;
    FPage: TbsAppMenuPage;
    FVisible: Boolean;
    FEnabled: Boolean;
    FImageIndex: Integer;
    FCaption: String;
    procedure SetPage(const Value: TbsAppMenuPage);
    procedure SetCaption(Value: String);
    procedure SetEnabled(Value: Boolean);
    procedure SetImageIndex(Value: Integer);
    procedure SetVisible(Value: Boolean);
  public
    Active: Boolean;
    ItemRect: TRect;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Page: TbsAppMenuPage read FPage write SetPage;
    property Visible: Boolean read FVisible write SetVisible;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Caption: String read FCaption write SetCaption;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TbsAppMenuItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsAppMenuItem;
    procedure SetItem(Index: Integer; Value:  TbsAppMenuItem);
  protected
    AppMenu: TbsAppMenu;
    DestroyPage: TbsAppMenuPage;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AAppMenu: TbsAppMenu);
    property Items[Index: Integer]: TbsAppMenuItem read GetItem write SetItem; default;
  end;

  TbsAppMenu = class(TbsSkinControl)
  private
    FScrollOffset: Integer;
    ScrollBar: TbsSkinScrollBar;
    FOldHeight: Integer;
    //
    FMouseIn: Boolean;
    FUseSkinFont: Boolean;
    FItemIndex: Integer;
    FSkinHint: TbsSkinHint;
    FItems: TbsAppMenuItems;
    FLeftOffset, FRightOffset: Integer;
    FOldItemActive, FItemActive: Integer;
    FActivePage: TbsAppMenuPage;
    FItemWidth: Integer;
    FItemImageList: TCustomImageList;
    FItemPageImageList: TCustomImageList;
    FData: TbsDataSkinAppMenu;
    FDataPicture: TBitmap;
    FDataBGPicture: TBitmap;
    FOnChangePage: TNotifyEvent;
    FOnShowMenu: TNotifyEvent;
    FOnHideMenu: TNotifyEvent;
    //
    function GetPageRect: TRect;
    procedure SetItems(AValue: TbsAppMenuItems);
    procedure SetActivePage(const Value: TbsAppMenuPage);
    function GetPageIndex(Value: TbsAppMenuPage): Integer;
    function GetPageBoundsRect: TRect;
    function ItemFromPoint(P: TPoint): Integer;
    procedure SetItemIndex(Value: Integer);
    procedure SetItemWidth(Value: Integer);
    procedure SetItemImageList(Value: TCustomImageList);
    procedure SetItemPageImageList(Value: TCustomImageList);
  protected
    FStopCheckItemIndex: Boolean;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure GetSkinData; override;
    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMMOUSEWHEEL(var Message: TWMMOUSEWHEEL); message WM_MOUSEWHEEL;
    procedure TestActive(X, Y: Integer);
    procedure Loaded; override;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure PaintAppMenu(C: TCanvas);
    procedure CalcItemRects;
    procedure DrawItem(C: TCanvas; Index: Integer);
    procedure DrawDefItem(C: TCanvas; Index: Integer);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetSkinData(Value: TbsSkinData); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    function GetGripRect: TRect;
    function CanShowGripper: Boolean;
    procedure GetScrollInfo(var AMin, AMax, APage: Integer);
    //
    procedure ShowScrollbar;
    procedure HideScrollBar;
    procedure AdjustScrollBar;
    procedure SBChange(Sender: TObject);
    procedure Scroll(AScrollOffset: Integer);
    procedure ScrollToItem(Index: Integer);
  public
    Ribbon: TbsRibbon;
    procedure FindNextItem;
    procedure FindPriorItem;
    procedure FindFirstItem;
    procedure FindLastItem;
    procedure UpdateScrollInfo;
    //
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure ChangeSkinData; override;
    procedure CreatePage;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
  published
    property Align;
    property Font;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property ItemWidth: Integer read FItemWidth write SetItemWidth;
    property Items: TbsAppMenuItems read FItems write SetItems;
    property ActivePage: TbsAppMenuPage read FActivePage write SetActivePage;
    property SkinHint: TbsSkinHint
      read FSkinHint write FSkinHint;
    property ItemImageList: TCustomImageList
      read FItemImageList write SetItemImageList;
    property ItemPageImageList: TCustomImageList
      read FItemPageImageList write SetItemPageImageList;
    property OnChangePage: TNotifyEvent read FOnChangePage write FOnChangePage;
    property OnShowMenu: TNotifyEvent read FOnShowMenu write FOnShowMenu;
    property OnHideMenu: TNotifyEvent read FOnHideMenu write FOnHideMenu;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TbsAppMenuCustomPage = class(TCustomControl)
  private
    FMouseIn: Boolean;
    FCanScroll: Boolean;
    FHotScroll: Boolean;
    TimerMode: Integer;
    SMax, SPosition, SPage, SOldPosition: Integer;
    FVSizeOffset: Integer;
    FScrollOffset: Integer;
    FScrollTimerInterval: Integer;
    Buttons: array[0..1] of TbsControlButton;
    PanelData: TbsDataSkinPanelControl;
    ButtonData: TbsDataSkinButtonControl;
    procedure SetScrollOffset(Value: Integer);
    procedure SetScrollTimerInterval(Value: Integer);
    procedure DrawButton(Cnvs: TCanvas; i: Integer);
    procedure SetPosition(const Value: integer);
    function CheckActivation: Boolean;
  protected
    FStopScroll: Boolean;
    procedure WMSETCURSOR(var Message: TWMSetCursor); message WM_SetCursor;
    procedure WMTimer(var Message: TWMTimer); message WM_Timer;
    procedure WMNCCALCSIZE(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPAINT(var Message: TMessage); message WM_NCPAINT;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure CMMouseEnter;
    procedure CMMouseLeave;
    procedure WndProc(var Message: TMessage); override;
    procedure SetButtonsVisible(AVisible: Boolean);
    procedure ButtonClick(I: Integer);
    procedure ButtonDown(I: Integer);
    procedure ButtonUp(I: Integer);
    procedure GetVRange;
    procedure VScrollControls(AOffset: Integer);
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure StartTimer;
    procedure StopTimer;
    procedure CMBENCPaint(var Message: TMessage); message CM_BENCPAINT;
    procedure CMSENCPaint(var Message: TMessage); message CM_SENCPAINT;
    procedure WMDESTROY(var Message: TMessage); message WM_DESTROY;
  public
    AppMenu: TbsAppMenu;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure UpDateSize;
    procedure GetScrollInfo;
    property Position: integer read SPosition write SetPosition;
  published
    property HotScroll: Boolean read FHotScroll write FHotScroll;
    property Align;
    property ScrollOffset: Integer read FScrollOffset write SetScrollOffset;
    property ScrollTimerInterval: Integer
    read FScrollTimerInterval write SetScrollTimerInterval;
    property CanScroll: Boolean read FCanScroll write FCanScroll;
  end;

  TbsAppMenuPage = class(TbsAppMenuCustomPage)
  private
    FDefaultWidth: Integer;
    FFirstActiveControl: TWinControl;
    procedure SetDefaultWidth(Value: Integer); 
  protected
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure PaintBG(DC: HDC);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    procedure Paint; override;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
  published
    property DefaultWidth: Integer read FDefaultWidth write SetDefaultWidth;
    property FirstActiveControl: TWinControl
      read FFirstActiveControl write FFirstActiveControl;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TbsRibbonDividerType = (bsdtVerticalLine, bsdtHorizontalLine,
    bsdtVerticalDashLine, bsdtHorizontalDashLine);

  TbsRibbonDivider = class(TbsGraphicSkinControl)
  private
    FDividerType: TbsRibbonDividerType;
    procedure SetDividerType(Value: TbsRibbonDividerType);
  protected
    procedure GetSkinData; override;
    procedure DrawLineV;
    procedure DrawLineH;
    procedure DrawDashLineV;
    procedure DrawDashLineH;
  public
    LightColor: TColor;
    DarkColor: TColor;
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
  published
    property DividerType: TbsRibbonDividerType
      read FDividerType write SetDividerType;
    property Align;  
  end;

  TbsAppMenuPageItem = class(TCollectionItem)
  private
    FImageIndex: TImageIndex;
    FTitle: String;
    FCaption: String;
    FEnabled: Boolean;
    FData: Pointer;
    FHeader: Boolean;
    FOnClick: TNotifyEvent;
  protected
    procedure SetImageIndex(const Value: TImageIndex); virtual;
    procedure SetTitle(const Value: String); virtual;
    procedure SetCaption(const Value: String); virtual;
    procedure SetData(const Value: Pointer); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
    procedure SetHeader(Value: Boolean); virtual;
  public
    ItemRect: TRect;
    IsVisible: Boolean;
    Active: Boolean;
    constructor Create(Collection: TCollection); override;
    property Data: Pointer read FData write SetData;
    procedure Assign(Source: TPersistent); override;
  published
    property Header: Boolean read FHeader write SetHeader;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Title: String read FTitle write SetTitle;
    property Caption: String read FCaption write SetCaption;
    property ImageIndex: TImageIndex read FImageIndex
      write SetImageIndex default -1;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;  
  end;

  TbsAppMenuPageListBox = class;

  TbsAppMenuPageItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsAppMenuPageItem;
    procedure SetItem(Index: Integer; Value:  TbsAppMenuPageItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    OfficeListBox: TbsAppMenuPageListBox;
    constructor Create(AListBox: TbsAppMenuPageListBox);
    property Items[Index: Integer]: TbsAppMenuPageItem read GetItem write SetItem; default;
    function Add: TbsAppMenuPageItem;
    function Insert(Index: Integer): TbsAppMenuPageItem;
    procedure Delete(Index: Integer);
    procedure Clear;
  end;

  TbsDrawAppPageItemEvent = procedure(Cnvs: TCanvas; Index: Integer;
    TextRct: TRect) of object;

  TbsAppMenuPageListBox = class(TbsSkinCustomControl)
  protected
    FOnDrawItem: TbsDrawAppPageItemEvent;
    FMouseMoveChangeIndex: Boolean;
    FDisabledFontColor: TColor;
    FShowLines: Boolean;
    FClicksDisabled: Boolean;
    FMouseDown: Boolean;
    FMouseActive: Integer;
    FMax: Integer;
    FRealMax: Integer;
    FItemsRect: TRect;
    FScrollOffset: Integer;
    FItems: TbsAppMenuPageItems;
    FImages: TCustomImageList;
    FShowItemTitles: Boolean;
    FItemHeight: Integer;
    FHeaderHeight: Integer;
    FOldHeight: Integer;
    ScrollBar: TbsSkinScrollBar;
    FItemIndex: Integer;
    FOnItemClick: TNotifyEvent;
    FAppMenu: TbsAppMenu;
    procedure SetShowLines(Value: Boolean);
    procedure SetItemIndex(Value: Integer);
    procedure SetItemActive(Value: Integer);
    procedure SetItemHeight(Value: Integer);
    procedure SetHeaderHeight(Value: Integer);
    procedure SetItems(Value: TbsAppMenuPageItems);
    procedure SetImages(Value: TCustomImageList);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetShowItemTitles(Value: Boolean);  public

    procedure DrawItem(Index: Integer; Cnvs: TCanvas);

    procedure SkinDrawItem(Index: Integer; Cnvs: TCanvas);
    procedure DefaultDrawItem(Index: Integer; Cnvs: TCanvas);
    procedure SkinDrawHeaderItem(Index: Integer; Cnvs: TCanvas);

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure CalcItemRects;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure ShowScrollbar;
    procedure HideScrollBar;
    procedure UpdateScrollInfo;
    procedure AdjustScrollBar;
    procedure SBChange(Sender: TObject);
    procedure Loaded; override;
    function ItemAtPos(X, Y: Integer): Integer;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;

    procedure WndProc(var Message: TMessage); override;

    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure FindUp;
    procedure FindDown;
    procedure FindPageUp;
    procedure FindPageDown;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function CalcHeight(AItemCount: Integer): Integer;

    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ScrollToItem(Index: Integer);
    procedure Scroll(AScrollOffset: Integer);
    procedure GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
    procedure ChangeSkinData; override;
  published
    property AppMenu: TbsAppMenu read FAppMenu write FAppMenu;
    property Items:  TbsAppMenuPageItems read FItems write SetItems;
    property Images: TCustomImageList read FImages write SetImages;
    property ShowItemTitles: Boolean
      read FShowItemTitles write SetShowItemTitles;
    property ItemHeight: Integer
      read FItemHeight write SetItemHeight;
    property HeaderHeight: Integer
      read FHeaderHeight write SetHeaderHeight;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property ShowLines: Boolean read FShowLines write SetShowLines;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property TabStop;
    property Font;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnDrawItem: TbsDrawAppPageItemEvent
      read FOnDrawItem write FOnDrawItem;
    property OnItemClick: TNotifyEvent
      read FOnItemClick write FOnItemClick;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation
  Uses BusinessSkinForm, bsSkinBoxCtrls, bsEffects;
   
const
  StdRibbonTopHeight = 24;
  StdRibbonGroupCapHeight = 17;
  StdRibbonTabTextOffset = 15;
  StdRibbonScrollButtonSize = 12;

  StdAppMenuItemWidth = 100;
  StdAppMenuItemHeight = 35;
  StdAppMenuItemHeightSmall = 28;
  StdAppMenuScrollButtonSize = 12;

  HTBUTTON1 = HTOBJECT + 100;
  HTBUTTON2 = HTOBJECT + 101;


constructor TbsRibbonTab.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  
  if (TbsRibbonTabs(Collection).Ribbon <> nil) and
     (csDesigning in  TbsRibbonTabs(Collection).Ribbon.ComponentState) and
      not (csLoading in  TbsRibbonTabs(Collection).Ribbon.ComponentState)
  then
    TbsRibbonTabs(Collection).CreatePageForItem(Self);

  FVisible := True;
end;

destructor TbsRibbonTab.Destroy;
begin
  if (TbsRibbonTabs(Collection).Ribbon <> nil)
     and (csDesigning in  TbsRibbonTabs(Collection).Ribbon.ComponentState)
     and not (csLoading in  TbsRibbonTabs(Collection).Ribbon.ComponentState)
     and (FPage <> nil)
     and not (csDestroying in TbsRibbonTabs(Collection).Ribbon.ComponentState)
  then
    TbsRibbonTabs(Collection).DestroyPage := FPage;
  inherited;
end;

procedure TbsRibbonTab.SetVisible;
var
  i: Integer;
  B: Boolean;
begin
  if FVisible = Value then Exit;
  // xxx

  //
  FVisible := Value;

  if TbsRibbonTabs(Collection).Ribbon = nil then Exit;

  if (FPage <> nil) and not FVisible and FPage.Visible
  then
    FPage.Visible := False;
    
  if not FVisible and (TbsRibbonTabs(Collection).Ribbon.TabIndex = Index)
  then
    with TbsRibbonTabs(Collection) do
    begin
      B := False;
      if Index + 1 < Ribbon.Tabs.Count then
      for i := Index + 1 to Ribbon.Tabs.Count - 1 do
      begin
        if Ribbon.Tabs[i].Visible
        then
          begin
            Ribbon.TabIndex := i;
            B := True;
            Break;
          end;
       end;
      if not B and (Index - 1 >= 0)
      then
        for i := Index - 1 downto 0 do
        begin
        if Ribbon.Tabs[i].Visible
        then
          begin
            B := True;
            Ribbon.TabIndex := i;
            Break;
          end;
       end;
      if not B then TbsRibbonTabs(Collection).Ribbon.Invalidate; 
    end
  else
    TbsRibbonTabs(Collection).Ribbon.Invalidate;
end;

procedure TbsRibbonTab.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TbsRibbonTab
  then
    begin
      FPage := TbsRibbonTab(Source).Page;
    end
end;


procedure TbsRibbonTab.SetPage(const Value: TbsRibbonPage);
begin
  if FPage <> Value then
  begin
    FPage := Value;
    if (FPage <> nil) and (FPage.Ribbon <> nil) then
      FPage.Ribbon.TabIndex := Index;
  end;
end;

constructor TbsRibbonTabs.Create;
begin
  inherited Create(TbsRibbonTab);
  Ribbon := ARibbon;
  DestroyPage := nil;
end;

function TbsRibbonTabs.GetOwner: TPersistent;
begin
  Result := Ribbon;
end;

procedure TbsRibbonTabs.Update(Item: TCollectionItem);
begin
  inherited;
  if Ribbon = nil then Exit;
  if (DestroyPage <> nil) and
     (csDesigning in  Ribbon.ComponentState) and
     not (csLoading in  Ribbon.ComponentState) and
     not (csDestroying in Ribbon.ComponentState)
  then
    begin
      FreeAndNil(DestroyPage);
      GetParentForm(Ribbon).Designer.Modified;
    end;
end;

function TbsRibbonTabs.GetItem(Index: Integer):  TbsRibbonTab;
begin
  Result := TbsRibbonTab(inherited GetItem(Index));
end;

procedure TbsRibbonTabs.SetItem(Index: Integer; Value:  TbsRibbonTab);
begin
  inherited SetItem(Index, Value);
end;

function TbsRibbonTabs.Add: TbsRibbonTab;
begin
  Result := TbsRibbonTab(inherited Add);
  if (Ribbon <> nil)
     and not (csDesigning in Ribbon.ComponentState)
     and not (csLoading in Ribbon.ComponentState)
  then
    CreatePageForItem(Result);
end;

function TbsRibbonTabs.Insert(Index: Integer): TbsRibbonTab;
begin
  Result := TbsRibbonTab(inherited Insert(Index));
  if (Ribbon <> nil)
     and not (csDesigning in Ribbon.ComponentState)
     and not (csLoading in Ribbon.ComponentState)
  then
    CreatePageForItem(Result);
end;

procedure TbsRibbonTabs.Delete(Index: Integer);
begin
   if (Ribbon <> nil)
      and not (csDesigning in Ribbon.ComponentState)
      and not (csLoading in Ribbon.ComponentState)
      and (Items[Index].FPage <> nil)
  then
    FreeAndNil(Items[Index].FPage);
    
  inherited Delete(Index);
end;

procedure TbsRibbonTabs.Clear;
begin
  inherited Clear;
end;

procedure TbsRibbonTabs.CreatePageForItem(AItem: TbsRibbonTab);
var
  LPage: TbsRibbonPage;
  R: TRect;
  function GetUniqueName(const Name: string; const AComponent: TComponent): string;
  var
    LIdx: Integer;
  begin
    LIdx := 1;
    Result := Format(Name, [LIdx]);
    if AComponent <> nil then
    begin
      while AComponent.FindComponent(Result) <> nil do
      begin
        Inc(LIdx);
        Result := Format(Name, [LIdx]);
      end;
    end;
  end;

begin
  if Ribbon = nil then Exit;
  LPage := TbsRibbonPage.Create(GetParentForm(Ribbon));
  LPage.Parent := Ribbon;
  LPage.Ribbon := Ribbon;
  R := Ribbon.GetPageBoundsRect;
  LPage.SetBounds(R.Left, R.Top, R.Right, R.Bottom);
  LPage.Name := GetUniqueName('bsRibbonPage%d', GetParentForm(Ribbon));
  AItem.FPage := LPage;
  LPage.Caption := LPage.Name;
  Ribbon.FStopCheckTabIndex := True;
  Ribbon.TabIndex := AItem.Index;
  Ribbon.FStopCheckTabIndex := False;
  Ribbon.Invalidate;
end;

constructor TbsRibbonPage.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible];
  Anchors := [akTop, akRight, akLeft, akBottom];
  FCaption := '';
end;

procedure TbsRibbonPage.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
    with Params.WindowClass do
      Style := Style and not (CS_HREDRAW or CS_VREDRAW);
end;


destructor TbsRibbonPage.Destroy;
var
  i, j: Integer;
  B: Boolean;
begin
  if (Ribbon <> nil) and (csDesigning in  Ribbon.ComponentState) and
     not (csLoading in Ribbon.ComponentState) and not
     (csDestroying in Ribbon.ComponentState)
  then
    begin
      j := Ribbon.GetPageIndex(Self);
      if j <> -1
      then
        begin
          Ribbon.Tabs[j].Page := nil;
          Ribbon.Tabs.Delete(j);
          if Ribbon.TabIndex = j
          then
            begin
              B := False;
              if j < Ribbon.Tabs.Count then
              for i := j to Ribbon.Tabs.Count - 1 do
              begin
                if (i >= 0) and (i < Ribbon.Tabs.Count) then
                if Ribbon.Tabs[i].Visible
                then
                  begin
                    Ribbon.TabIndex := i;
                    B := True;
                    Break;
                  end;
              end;
              if not B and (j >= 0)
              then
                for i := j downto 0 do
                begin
                  if (i >= 0) and (i < Ribbon.Tabs.Count) then
                  if Ribbon.Tabs[i].Visible
                  then
                    begin
                      Ribbon.TabIndex := i;
                      Break;
                    end;
                end;
            end;
          Ribbon.Invalidate;  
        end
      else
        begin
          if Ribbon.TabIndex > Ribbon.Tabs.Count - 1
          then
            Ribbon.TabIndex := Ribbon.Tabs.Count - 1
          else
            Ribbon.TabIndex := Ribbon.TabIndex;
          Ribbon.Invalidate;  
        end;
    end;
  inherited;
end;


procedure TbsRibbonPage.WMSIZE(var Message: TWMSIZE);
begin
  inherited;
  Invalidate;
end;

procedure TbsRibbonPage.SetCaption;
begin
  FCaption := Value;
  if Ribbon <> nil then Ribbon.Invalidate;
end;

procedure TbsRibbonPage.PaintBG;
var
  C: TCanvas;
  TabSheetBG, Buffer2: TBitMap;
  X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
begin

  if Ribbon = nil then Exit;

  if (Width <= 0) or (Height <=0) then Exit;

  Ribbon.GetSkinData;

  C := TCanvas.Create;
  C.Handle := DC;

  if (Ribbon.FIndex <> -1) and (Ribbon.FData.BGPictureIndex <> -1)
  then
    begin
      TabSheetBG := TBitMap(Ribbon.FSD.FActivePictures.Items[Ribbon.FData.BGPictureIndex]);

      if Ribbon.FData.StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case Ribbon.FData.StretchType of
            bsstFull:
              begin
                C.StretchDraw(Rect(0, 0, Width, Height), TabSheetBG);
              end;
            bsstVert:
              begin
                Buffer2 := TBitMap.Create;
                Buffer2.Width := Width;
                Buffer2.Height := TabSheetBG.Height;
                Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
                YCnt := Height div Buffer2.Height;
                for Y := 0 to YCnt do
                  C.Draw(0, Y * Buffer2.Height, Buffer2);
                Buffer2.Free;
              end;
           bsstHorz:
             begin
               Buffer2 := TBitMap.Create;
               Buffer2.Width := TabSheetBG.Width;
               Buffer2.Height := Height;
               Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
               XCnt := Width div Buffer2.Width;
               for X := 0 to XCnt do
                 C.Draw(X * Buffer2.Width, 0, Buffer2);
               Buffer2.Free;
             end;
          end;
        end
      else
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div TabSheetBG.Width;
          YCnt := Height div TabSheetBG.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          C.Draw(X * TabSheetBG.Width, Y * TabSheetBG.Height, TabSheetBG);
        end;
      C.Free;
      Exit;
    end;

  w1 := Width;
  h1 := Height;

  if (Ribbon.FIndex <> -1) and (Ribbon.FData <> nil) and (Ribbon.FDataPicture <> nil)
  then
    with Ribbon, FData do
    begin
      TabSheetBG := TBitMap.Create;
      TabSheetBG.Width := RectWidth(ClRect);
      TabSheetBG.Height := RectHeight(ClRect);
      TabSheetBG.Canvas.CopyRect(Rect(0, 0, TabSheetBG.Width, TabSheetBG.Height),
         FDataPicture.Canvas,
          Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
               SkinRect.Left + ClRect.Right,
               SkinRect.Top + ClRect.Bottom));

     if StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case StretchType of
            bsstFull:
              begin
                C.StretchDraw(Rect(0, 0, Self.Width, Self.Height), TabSheetBG);
              end;
            bsstVert:
              begin
                Buffer2 := TBitMap.Create;
                Buffer2.Width := Self.Width;
                Buffer2.Height := TabSheetBG.Height;
                Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
                YCnt := Self.Height div Buffer2.Height;
                for Y := 0 to YCnt do
                  C.Draw(0, Y * Buffer2.Height, Buffer2);
                Buffer2.Free;
              end;
           bsstHorz:
             begin
               Buffer2 := TBitMap.Create;
               Buffer2.Width := TabSheetBG.Width;
               Buffer2.Height := Self.Height;
               Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
               XCnt := Self.Width div Buffer2.Width;
               for X := 0 to XCnt do
                 C.Draw(X * Buffer2.Width, 0, Buffer2);
               Buffer2.Free;
             end;
          end;
        end
      else
        begin
          w := RectWidth(ClRect);
          h := RectHeight(ClRect);
          XCnt := w1 div w;
          YCnt := h1 div h;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          C.Draw(X * w, Y * h, TabSheetBG);
        end;
      TabSheetBG.Free;
    end
  else
  with C do
  begin
    Brush.Color := clbtnface;
    FillRect(Rect(0, 0, Width, Height));
  end;
  C.Free;
end;

procedure TbsRibbonPage.Paint;
begin

end;

procedure TbsRibbonPage.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  R: TRect;
begin
  if (Parent <> nil) and (Ribbon <> nil)
  then
    begin
      R := Ribbon.GetPageBoundsRect;
      inherited SetBounds(R.Left, R.Top, R.Right, R.Bottom);
    end
  else
    inherited;
end;

procedure TbsRibbonPage.WMEraseBkgnd;
begin
  if Msg.DC <> 0 then PaintBG(Msg.DC);
end;

constructor TbsRibbon.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls];
  BSF := nil;
  FAppMenu := nil;
  FInAppHook := False;
  FStopCheckTabIndex := False;
  FAppButton := nil;
  FAppButtonWidth := 54;
  ShowAppButton;
  //
  FButtons := TbsRibbonButtonItems.Create(Self);
  FButtonsImageList := nil;
  FButtonsShowHint := False;
  //
  FMDIButtons := TbsRibbonButtonItems.Create(Self);
  //
  FMouseCaptureButton := -1;
  FMouseCaptureMDIButton := -1;
  FShowDivider := False;
  FUseSkinFont := True;
  FLeftOffset := FAppButtonWidth + 6;
  FRightOffset := 5;
  FTabs := TbsRibbonTabs.Create(Self);
  WMEraseReady := False;
  FData := nil;
  FTabIndex := -1;
  Height := 115;
  Align := alTop;
  FSkinDataName := 'officetab';
  FOldTabActive := -1;
  FTabActive := -1;
  FAppButtonImageList := nil;
  FSkinHint := nil;
  FAppButtonImageIndex := 0;
  FActiveButton := -1;
  FOldActiveButton := -1;
  FMDIActiveButton := -1;
  FMDIOldActiveButton := -1;
  FPopupButton := -1;
  FAppButtonPopupMenu := nil;
end;

destructor TbsRibbon.Destroy;
begin
  FTabs.Free;
  FButtons.Free;
  FMDIButtons.Free;
  inherited;
end;

procedure TbsRibbon.TrackMenu(APopupRect: TRect; APopupMenu: TbsSkinPopupMenu);
var
  R: TRect;
  P: TPoint;
begin
  P := Point(APopupRect.Left, APopupRect.Top);
  P := ClientToScreen(P);
  R := Rect(P.X, P.Y, P.X + RectWidth(ApopupRect), P.Y + RectHeight(APopupRect) + 1);
  APopupMenu.PopupFromRect2(Self, R, False);
end;

procedure TbsRibbon.HideTrackMenu(Sender: TObject);
begin
  if Assigned(FOnMenuClose) then FOnMenuClose(Self); 
end;

procedure TbsRibbon.NewAppMessage;
var
  MsgNew: TMessage;
begin
  MsgNew.WParam := Msg.WParam;
  MsgNew.LParam := Msg.LParam;
  MsgNew.Msg := Msg.message;
  case Msg.message of
    WM_KEYDOWN:
      begin
        if (TWMKEYDOWN(MsgNew).CharCode = VK_ESCAPE) and
           (FAppMenu <> nil) and FAppMenu.Visible and
           (BSF <> nil) and TbsBusinessSkinForm(BSF).FForm.Active
        then
          begin
            HideAppMenu(nil);
            Msg.message := 0;
            Handled := True;
          end;
      end;
  end;
end;

procedure TbsRibbon.HookApp;
begin 
  if (csDesigning in ComponentState) then Exit;
  if not FInAppHook
  then
    begin
      OldAppMessage := Application.OnMessage;
      Application.OnMessage := NewAppMessage;
      FInAppHook := True;
    end;
end;

procedure TbsRibbon.UnHookApp;
begin
  if (csDesigning in ComponentState) then Exit;
  if FInAppHook
  then
    begin
      FInAppHook := False;
      Application.OnMessage := OldAppMessage;
    end;
end;

procedure TbsRibbon.SetAppMenu;
begin
  FAppMenu := Value;
  if AppMenu <> nil
  then
    begin
      FAppMenu.Visible := False;
      if (csDesigning in ComponentState)
      then
        begin
          AppMenu.Anchors := [];
          AppMenu.Width := 100;
          AppMenu.Height := 100;
          AppMenu.Left := - AppMenu.Width - 10;
          AppMenu.Top := 0;
        end;  
    end;
end;

procedure TbsRibbon.ShowAppMenu;
var
  F: TCustomForm;
begin
  if not (csDesigning in ComponentState)
  then
    if Assigned(AppMenu.FOnShowMenu) then AppMenu.FOnShowMenu(Self);

  HookApp;

  F := GetParentForm(Self);

  if AppMenu.Parent <> F then AppMenu.Parent := F;

  AppMenu.SetBounds(0, Top + FAppButton.Top + FAppButton.Height,
    F.ClientWidth, F.ClientHeight - Top + FAppButton.Top - FAppButton.Height);

  AppMenu.Anchors := [akTop, akLeft, akRight, akBottom];

  if AppMenu.ActivePage <> nil
  then
    AppMenu.ItemIndex := AppMenu.GetPageIndex(AppMenu.ActivePage)
  else
    AppMenu.ItemIndex := 0;

  AppMenu.Visible := True;
  
  AppMenu.BringToFront;

  if not (csDesigning in ComponentState)
  then
    AppMenu.SetFocus;

  if not (AppMenu.Items[AppMenu.ItemIndex].Visible) or
     not (AppMenu.Items[AppMenu.ItemIndex].Enabled)
  then
    AppMenu.FindNextItem;
    
  if AppMenu.ActivePage <> nil
  then
    with AppMenu.ActivePage do
    begin
      FStopScroll := False;
      SetBounds(Left, Top, Width, Height);
      if CanScroll then GetScrollInfo;
    end;

  Invalidate;
end;

procedure TbsRibbon.HideAppMenu(Item: TbsAppMenuItem);
begin
  UnHookApp;
  AppMenu.Anchors := [];
  AppMenu.Visible := False;
  if (csDesigning in ComponentState)
  then
    begin
      AppMenu.Width := 100;
      AppMenu.Height := 100;
      AppMenu.Left := - AppMenu.Width - 10;
      AppMenu.Top := 0;
    end;
  Invalidate;
  AppButton.FMenuTracked := False;
  AppButton.FDownState := False;
  AppButton.Down := False;
  //
  Application.ProcessMessages;
  //
  if Item <> nil
  then
    begin
      if Assigned(Item.OnClick) then Item.OnClick(Self);
    end;
  if Assigned(FOnMenuClose) then FOnMenuClose(Self);
  if not (csDesigning in ComponentState)
  then
    if Assigned(AppMenu.FOnHideMenu) then AppMenu.FOnHideMenu(Self);
end;

procedure TbsRibbon.MDICloseClick(Sender: TObject);
var
  BSF: TbsBusinessSkinForm;
begin
  BSF := GetMDIChildBusinessSkinFormComponent;
  if BSF <> nil
  then
    begin
      BSF.FForm.Close;
    end;
end;

procedure TbsRibbon.MDIMinClick(Sender: TObject);
var
  BSF: TbsBusinessSkinForm;
begin
  BSF := GetMDIChildBusinessSkinFormComponent;
  if BSF <> nil
  then
    begin
      BSF.WindowState := wsMinimized;
    end;
end;

procedure TbsRibbon.MDIRestoreClick(Sender: TObject);
var
  BSF: TbsBusinessSkinForm;
begin
  BSF := GetMDIChildBusinessSkinFormComponent;
  if BSF <> nil
  then
    begin
      BSF.WindowState := wsNormal;
    end;
end;

procedure TbsRibbon.MDIChildRestore;
var
  BSF: TbsBusinessSkinForm;
begin
  BSF := GetMDIChildBusinessSkinFormComponent;
  if (BSF = nil) and (FMDIButtons.Count > 0)
  then
    begin
      HideMDIButtons;
    end;
end;

procedure TbsRibbon.MDIChildMaximize;
begin
  if FMDIButtons.Count = 0 then ShowMDIButtons;
end;


procedure TbsRibbon.ShowMDIButtons;
begin
  if FMDIButtons.Count > 0 then Exit;
  FMDIButtons.Clear;
  FMDIButtons.Add;
  FMDIBUttons[0].Code := 1;
  FMDIBUttons[0].OnClick := MDICloseClick;
  FMDIButtons.Add;
  FMDIBUttons[1].Code := 2;
  FMDIBUttons[1].OnClick := MDIRestoreClick;
  FMDIButtons.Add;
  FMDIBUttons[2].Code := 3;
  FMDIBUttons[2].OnClick := MDIMinClick;
  Invalidate;
end;

procedure TbsRibbon.HideMDIButtons;
begin
  FMDIButtons.Clear;
  Invalidate;
end;

function TbsRibbon.TabFromPoint;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Tabs.Count -1 do
    if Tabs[i].Visible and PtInRect(Tabs[i].ItemRect, P)
    then
      begin
        Result := i;
        Break;
      end;
end;

procedure TbsRibbon.CMDesignHitTest;
var
  P: TPoint;
begin
  inherited;
  P := SmallPointToPoint(Message.Pos);
  if (Message.Keys = MK_LBUTTON) and (TabFromPoint(P) <> -1)
  then
    begin
      TabIndex := TabFromPoint(P);
      GetParentForm(Self).Designer.Modified;
    end;
end;

procedure TbsRibbon.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
    with Params.WindowClass do
      Style := Style and not (CS_HREDRAW or CS_VREDRAW);
end;

function TbsRibbon.AnyTabVisible: Boolean;
var
  i: Integer;
begin
  Result := False;
  if Tabs.Count = 0 then Exit;
  for i := 0 to Tabs.Count - 1 do
    if Tabs[i].Visible
    then
      begin
        Result := True;
        Break;
      end;
end;

procedure TbsRibbon.SetButtons;
begin
  FButtons.Assign(Value);
  Invalidate;
end;

function TbsRibbon.GetAppButton: TbsAppButton;
begin
  Result := FAppButton;
end;

procedure TbsRibbon.Notification(AComponent: TComponent;
      Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FAppButtonPopupMenu)
  then
    begin
      FAppButtonPopupMenu := nil;
      if FAppButton <> nil then FAppButton.SkinPopupMenu := nil; 
    end;
  if (Operation = opRemove) and (AComponent = FAppButtonImageList)
  then
    begin
      FAppButtonImageList := nil;
      if FAppButton <> nil then FAppButton.ImageList := nil;
    end;
  if (Operation = opRemove) and (AComponent = FButtonsImageList)
  then
    begin
      FButtonsImageList := nil;
    end;
  if (Operation = opRemove) and (AComponent = FSkinHint)
  then
    begin
      FSkinHint := nil;
    end;
  if (Operation = opRemove) and (AComponent = FAppMenu)
  then
    begin
      FAppMenu := nil;
    end;
end;

procedure TbsRibbon.SetSkinData(Value: TbsSkinData); 
begin
  inherited;
  if FAppButton <> nil then FAppButton.SkinData := SkinData;
end;

procedure TbsRibbon.SetAppButtonImageList;
begin
  FAppButtonImageList := Value;
  if FAppButton <> nil
  then
    begin
      FAppButton.FImageList := FAppButtonImageList;
      Invalidate;
    end;  
end;

procedure TbsRibbon.SetAppButtonImageIndex;
begin
  FAppButtonImageIndex := Value;
  if FAppButtonImageIndex < 0 then FAppButtonImageIndex := 0;
  if FAppButton <> nil
  then
    begin
      FAppButton.FImageIndex := FAppButtonImageIndex;
      FAppButton.Invalidate;
    end;
end;

procedure TbsRibbon.SetAppButtonPopupMenu;
begin
   FAppButtonPopupMenu := Value;
  if FAppButton <> nil then FAppButton.SkinPopupMenu := FAppButtonPopupMenu;
end;


procedure TbsRibbon.SetAppButtonWidth(Value: Integer);
begin
  if (FAppButtonWidth <> Value) and (Value > 34)
  then
    begin
      FAppButtonWidth := Value;
      if FAppButton <> nil then FAppButton.Width := FAppButtonWidth;
      FLeftOffset := FAppButtonWidth + 6;
      Invalidate;
    end;
end;

procedure TbsRibbon.ChangeSkinData; 
begin
  inherited;
  if ActivePage <> nil
  then
    begin
      ActivePage.SetBounds(ActivePage.Left, ActivePage.Top,
      ActivePage.Width, ActivePage.Height);
      FAppButton.Left := 3;
      FAppButton.Top := 1;
    end;
end;

procedure TbsRibbon.ShowAppButton;
begin
  if FAppButton <> nil then FAppButton.Free;
  FAppButton := TbsAppButton.Create(Self);
  FAppButton.CanFocused := True;
  FAppButton.TabStop := False;
  FAppButton.Ribbon := Self;
  FAppButton.SetBounds(3, 1, FAppButtonWidth, StdRibbonTopHeight);
  FAppButton.Parent := Self;
  FAppButton.SkinDataName := 'officemenubutton';
  FAppButton.OnHideTrackMenu := HideTrackMenu;
  FLeftOffset := FAppButtonWidth + 6;
end;


procedure TbsRibbon.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_NEXT)
  then
    FindLast
  else
  if (Key = VK_PRIOR)
  then
   FindFirst
  else
  if (Key = VK_LEFT) or (KEY = VK_UP)
  then
    FindPriorPage(True)
  else
  if (Key = VK_RIGHT)or (KEY = VK_DOWN)
  then
    FindNextPage;
end;

procedure TbsRibbon.FindLast;
var
  i, k: Integer;
begin
  k := -1;
  for i := Tabs.Count - 1 downto 0 do
  begin
    if Tabs[i].Visible
    then
      begin
        k := i;
        Break;
      end;
  end;
  if k <> -1 then TabIndex := k;
end;

procedure TbsRibbon.FindFirst;
var
  i, k: Integer;
begin
  k := -1;
  for i := 0 to Tabs.Count - 1 do
  begin
    if Tabs[i].Visible
    then
      begin
        k := i;
        Break;
      end;
  end;
  if k <> -1 then TabIndex := k;
end;

procedure TbsRibbon.FindNextPage;
var
  i, j, k: Integer;
begin
  j := TabIndex;
  if (j = -1) or (j = Tabs.Count - 1) then Exit;
  k := -1;
  for i := j + 1 to Tabs.Count - 1 do
  begin
    if Tabs[i].Visible
    then
      begin
        k := i;
        Break;
      end;
  end;
  if k <> -1 then TabIndex := k;
end;

procedure TbsRibbon.FindPriorPage;
var
  i, j, k: Integer;
begin
  j := TabIndex;
  if (j = 0) and AppButtonSupport
  then
    begin
      if FAppButton <> nil then FAppButton.SetFocus;
    end;
  if (j = -1) or (j = 0) then Exit;
  k := -1;
  for i := j - 1 downto 0 do
  begin
    if Tabs[i].Visible
    then
      begin
        k := i;
        Break;
      end;
  end;
  if k <> -1 then TabIndex := k;
end;

procedure TbsRibbon.WMGetDlgCode;
begin
  Msg.Result := DLGC_WANTARROWS;
end;

procedure TbsRibbon.WMSETFOCUS(var Message: TWMSETFOCUS);
begin
  inherited;
  Invalidate;
end;

procedure TbsRibbon.WMKILLFOCUS(var Message: TWMKILLFOCUS); 
begin
  inherited;
  Invalidate;
end;

procedure TbsRibbon.WMMOUSEWHEEL(var Message: TMessage);
begin
  inherited;
  if Focused
  then 
    if Message.WParam < 0 then FindNextPage else FindPriorPage(False);
end;

procedure TbsRibbon.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TestActive(X, Y);
end;

procedure TbsRibbon.MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer);
var
  i: Integer;
begin
  inherited;

  FMouseCaptureMDIButton := -1;
  FMouseCaptureButton := -1;

  if Button <> mbLeft then Exit;

  TestActive(X, Y);

  if not ((FAppMenu <> nil) and FAppMenu.Visible)
  then
    begin
      if FTabActive <> TabIndex then TabIndex := FTabActive;
      if (FTabActive <> -1) and not Focused then SetFocus;
    end;  

  if (FMDIActiveButton <> -1) and ( FMDIButtons.Count > 0)
  then
    begin
      for i := 0 to FMDIButtons.Count - 1 do
      begin
        if i = FMDIActiveButton
        then
          begin
            FMDIButtons[i].Down := True;
            FMouseCaptureMDIButton := i;
          end
        else
          begin
            FMDIButtons[i].Down := False;
            FMDIButtons[i].Active := False;
          end;
      end;
      Invalidate;
    end;


  if (FActiveButton <> -1) and ( Buttons.Count > 0)
  then
    begin
      for i := 0 to Buttons.Count - 1 do
      begin
        if i = FActiveButton
        then
          begin
            Buttons[i].Down := True;
            FMouseCaptureButton := i;
            if Buttons[i].PopupMenu <> nil
            then
              begin
                FPopupButton := i;
                TrackMenu(Buttons[i].ItemRect, Buttons[i].PopupMenu);
              end;
          end
        else
          begin
            Buttons[i].Down := False;
            Buttons[i].Active := False;
          end;
      end;
      Invalidate;
    end;

  if (FButtonsShowHint) and (FSkinHint <> nil) then FSkinHint.HideHint;

end;

procedure TbsRibbon.WMCloseSkinMenu(var Message: TMessage);
begin
  if (FPopupButton <> -1) and (FPopupButton >= 0) and
     (FPopupButton < Buttons.Count)
  then
    begin
      Buttons[FPopupButton].Down := False;
      FPopupButton := -1;
      RePaint;
    end;
end;

procedure TbsRibbon.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: integer;
  WasDown: Boolean;
begin
  inherited;

  if Button <> mbLeft then Exit;

  TestActive(X, Y);

  if (FMDIActiveButton <> -1) and (FMDIButtons.Count > 0)
  then
    begin
      WasDown := FMDIButtons[FMDIActiveButton].Down;
      for i := 0 to FMDIButtons.Count - 1 do
        FMDIButtons[i].Down := False;
      Invalidate;
      if Assigned(FMDIButtons[FMDIActiveButton].OnClick) and WasDown
      then
        FMDIButtons[FMDIActiveButton].OnClick(Self);
    end
  else
  if (FMDIButtons.Count > 0) and (FMouseCaptureMDIButton <> -1) and (FMouseCaptureMDIButton >= 0) and
     (FMouseCaptureMDIButton < FMDIButtons.Count)
  then
    begin
      FMDIButtons[FMouseCaptureMDIButton].Down := False;
      FMDIButtons[FMouseCaptureMDIButton].Active := False;
    end;

  if (FActiveButton <> -1) and (Buttons.Count > 0)
  then
    begin
      WasDown := Buttons[FActiveButton].Down;
      for i := 0 to Buttons.Count - 1 do
        if i <> FPopupButton then Buttons[i].Down := False;
      Invalidate;
      if Assigned(Buttons[FActiveButton].OnClick) and WasDown
      then
        Buttons[FActiveButton].OnClick(Self);
    end
  else
  if (FMouseCaptureButton <> -1) and (FMouseCaptureButton >= 0) and
     (FMouseCaptureButton < Buttons.Count)
  then
    begin
      Buttons[FMouseCaptureButton].Down := False;
      Buttons[FMouseCaptureButton].Active := False;
    end;

  FMouseCaptureMDIButton := -1;
  FMouseCaptureButton := -1;
end;

procedure TbsRibbon.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  TestActive(-1, -1);
end;

procedure TbsRibbon.TestActive(X, Y: Integer);
var
  i: Integer;
  B, CanDraw: Boolean;
begin
  if Tabs.Count = 0 then Exit;
  FOldTabActive:= FTabActive;
  FTabActive := -1;
  for i := 0 to Tabs.Count - 1 do
  begin
    if Tabs[i].Visible and PtInRect(Tabs[i].ItemRect, Point(X, Y))
    then
      begin
        FTabActive := i;
        Break;
      end;
  end;
  if (FTabActive <> FOldTabActive)
  then
    begin
      if (FOldTabActive <> - 1)
      then
        Tabs[FOldTabActive].Active := False;
      if (FTabActive <> - 1)
      then
        Tabs[FTabActive].Active := True;
      Invalidate;
    end;

  // mdi buttons

  if FMDIButtons.Count > 0 then begin

  FMDIOldActiveButton := FMDIActiveButton;
  i := -1;
  repeat
    Inc(i);
    with FMDIButtons[i] do
    begin
      B := PtInRect(ItemRect, Point(X, Y));
    end;
  until B or (i = FMDIButtons.Count - 1);
  if B then FMDIActiveButton := i else FMDIActiveButton := -1;
  CanDraw := False;
  for i := 0 to FMDIButtons.Count - 1 do
  begin
    if i = FMDIActiveButton
    then
      begin
        if not FMDIButtons[i].Active then CanDraw := True;
        FMDIButtons[i].Active := True;
      end
    else
      begin
        if FMDIButtons[i].Active then CanDraw := True;
        FMDIButtons[i].Active := False;
      end;  
  end;

  if (FMDIOldActiveButton <> FMDIActiveButton) or CanDraw
  then
    Invalidate;

  end;

  // buttons

  if Buttons.Count > 0 then begin

  FOldActiveButton := FActiveButton;
  i := -1;
  B := False;
  repeat
    Inc(i);
    with Buttons[i] do
    begin
      if Enabled and Visible then B := PtInRect(ItemRect, Point(X, Y));
    end;
  until B or (i = Buttons.Count - 1);
  if B then FActiveButton := i else FActiveButton := -1;
  CanDraw := False;
  for i := 0 to Buttons.Count - 1 do
  begin
    if i = FActiveButton
    then
      begin
        if not Buttons[i].Active then CanDraw := True;
        Buttons[i].Active := True;
      end
    else
      begin
        if Buttons[i].Active then CanDraw := True;
        Buttons[i].Active := False;
      end;  
  end;

  if (FOldActiveButton <> FActiveButton) or CanDraw
  then
    Invalidate;

  if (FOldActiveButton <> FActiveButton) and (FActiveButton <> -1)
     and (FSkinHint <> nil) and ButtonsShowHint and
     (Buttons[FActiveButton].Hint <> '')
  then
    SkinHint.ActivateHint2(Buttons[FActiveButton].Hint);

  if CanDraw and ButtonsShowHint and (FActiveButton = -1)
  then
    FSkinHint.HideHint;

  end;  
end;

procedure TbsRibbon.GetMDIButtonsSize(var w, h: Integer);
begin
  if (FIndex <> -1) and (FData <> nil)
  then
    begin
      w := RectWidth(FData.MDICloseRect);
      h := RectHeight(FData.MDICloseRect);
    end
  else
    begin
      w := 22;
      h := 22;
    end;  
end;

procedure TbsRibbon.CalcItemRects;
var
  i: Integer;
  R: TRect;
  w, h, w1, X, Y: Integer;
  kf: Double;
begin
  if (Buttons.Count > 0) and (ButtonsImageList <>  nil)
  then
    begin
      w := ButtonsImageList.Width + 6;
      h := RibbonTopHeight - 2;
      X := Width - 2;
      for i := Buttons.Count - 1 downto 0 do
      if Buttons[i].Visible then 
      begin
        Buttons[i].ItemRect := Rect(X - w, 1, X, h + 1);
        Dec(X, w);
      end;
      FRightOffset := Width - X + 2;
    end
  else
    FRightOffset := 5;

  if FMDIButtons.Count > 0
  then
    begin
      GetMDIButtonsSize(w, h);
      X := Width - FRightOffset;
      for i :=  0 to FMDIButtons.Count - 1 do
      begin
        FMDIButtons[i].ItemRect := Rect(X - w, 1, X, h + 1);
        Dec(X, w);
      end;
      FRightOffset := Width - X + 2;
    end;

  w := Width - FLeftOffset - FRightOffset;
  w1 := 0;
  for i := 0 to Tabs.Count - 1 do
  if Tabs[i].Visible then
  begin
    R := Rect(0, 0, 0, 0);
    DrawText(C.Handle, PChar(Tabs[i].Page.Caption), Length(Tabs[i].Page.Caption), R,
      DT_CALCRECT or DT_LEFT);
    R.Right := R.Right + StdRibbonTabTextOffset * 2;
    Tabs[i].Width := R.Right;
    w1 := w1 + Tabs[i].Width;
  end;
  FShowDivider := w1 > w;
  if FShowDivider
  then
    begin
      for i := 0 to Tabs.Count - 1 do
      if Tabs[i].Visible then
      begin
        kf := Tabs[i].Width / w1;
        Tabs[i].Width := Trunc(w * kf);
        if Tabs[i].Width < StdRibbonTabTextOffset
        then Tabs[i].Width := StdRibbonTabTextOffset;
      end;
    end;
  X := FLeftOffset;
  Y := 1;
  for i := 0 to Tabs.Count - 1 do
  if Tabs[i].Visible then
  begin
    if FIndex = -1
    then
      Tabs[i].ItemRect := Rect(X, Y, X + Tabs[i].Width, Y + StdRibbonTopHeight - 1)
    else
      Tabs[i].ItemRect := Rect(X, Y, X + Tabs[i].Width, Y + RectHeight(FData.TabRect));
    X := X + RectWidth(Tabs[i].ItemRect); 
  end;
end;  

function TbsRibbon.RibbonTopHeight: Integer;
begin
  if (FIndex <> -1) and (FData <> nil)
  then
    Result := RectHeight(FData.TabRect) + 1
  else
    Result := StdRibbonTopHeight;
end;

procedure TbsRibbon.GetSkinData;
begin
  inherited;
  if FIndex = -1
  then
    begin
      FData := nil;
      FDataPicture := nil;
    end  
  else
    begin
      FData := TbsDataSkinTabControl(FSD.CtrlList[FIndex]);
      FDataPicture := TBitMap(SkinData.FActivePictures.Items[FData.PictureIndex]);
    end;
end;

procedure TbsRibbon.SetTabs(AValue: TbsRibbonTabs);
begin
  FTabs.Assign(AValue);
  Invalidate;
end;

function TbsRibbon.GetTabIndex: Integer;
begin
  Result := FTabIndex;
end;

procedure TbsRibbon.SetTabIndex(const Value: Integer);
var
  LPage: TbsRibbonPage;
  LPrevTabIndex: Integer;
begin

  if ((Tabs.Count = 0) or not AnyTabVisible) and not FStopCheckTabIndex
  then
    begin
      FTabIndex := -1;
      Invalidate;
      Exit;
    end;  

  if (Value < 0) or (Value > Tabs.Count - 1) then Exit;

  if not Tabs[Value].FVisible then Tabs[Value].FVisible := True;

  if (FTabIndex <> Value)
  then
    begin
      LPrevTabIndex := FTabIndex;
      FTabIndex := Value;
      if (FTabIndex > -1) and (FTabs[FTabIndex].Page <> nil)
      then
        begin
          LPage := FTabs[FTabIndex].Page;
          LPage.Parent := Self;
          LPage.Visible := True;
          LPage.BringToFront;
        end;

      if (LPrevTabIndex > -1) and (FTabs.Count > LPrevTabIndex) and
         (FTabs[LPrevTabIndex].Page <> nil) and
         (FTabs[LPrevTabIndex].Page <> nil)
      then
        FTabs[LPrevTabIndex].Page.Visible := False;
      if Assigned(FOnChangePage) then FOnChangePage(Self);
    end
  else
    begin
      if Tabs[Value].FPage <> nil
      then
        if not Tabs[Value].FPage.Visible then Tabs[Value].FPage.Visible := True;
    end;  
    
  Invalidate;
end;

function TbsRibbon.GetActivePage: TbsRibbonPage;
begin
  if (TabIndex > -1) and (TabIndex < FTabs.Count)
  then
    begin
      if FTabs[TabIndex] <> nil
      then
        Result := FTabs[TabIndex].Page
      else
        Result := nil;
    end
  else
    Result := nil;
end;

procedure TbsRibbon.SetActivePage(const Value: TbsRibbonPage);
var
  i: Integer;
begin
  if Value <> nil
  then
    if AnyTabVisible then
    begin
      i := GetPageIndex(Value);
      if (i <> -1) and not (Tabs[i].FVisible) then Tabs[i].FVisible := True; 
      TabIndex := i;
    end;  
end;

function TbsRibbon.GetPageIndex(Value: TbsRibbonPage): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Tabs.Count - 1 do
    if Tabs[i].Page = Value
    then
       begin
         Result := i;
         Break;
       end;
end;

procedure TbsRibbon.Loaded;
var
  i: Integer;
begin
  inherited;
  if Tabs.Count > 0 then
    for i := 0 to Tabs.Count - 1 do
    begin
      if Tabs[i].Page <> nil
      then
        begin
          Tabs[i].Page.Ribbon := Self;
          if i <> TabIndex then Tabs[i].Page.Visible := False;
        end;
    end;
  if FAppMenu <> nil then FAppMenu.Ribbon := Self;  
end;

function TbsRibbon.GetPageBoundsRect: TRect;
begin
  GetSkinData;
  if (FIndex = -1) or (FData = nil)
  then
    begin
      Result.Left := 1;
      Result.Top := RibbonTopHeight + 2;
      Result.Right := Self.Width - 2;
      Result.Bottom := Self.Height - RibbonTopHeight - 5;
    end
  else
    with FData do
    begin
      Result.Left := ClRect.Left;
      Result.Top := ClRect.Top + RibbonTopHeight;
      Result.Right := Self.Width - RectWidth(SkinRect) + RectWidth(ClRect);
      Result.Bottom := Height - RectHeight(SkinRect) +
        RectHeight(ClRect) - RibbonTopHeight;
    end;  
end;

procedure TbsRibbon.WMSIZE(var Message: TWMSIZE); 
begin
  inherited;
  Invalidate;
end;

procedure TbsRibbon.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
var
  C: TCanvas;
begin
  C := TCanvas.Create;
  C.Handle := Msg.DC;
  PaintRibbon(C);
  C.Handle := 0;
  C.Free;
  WMEraseReady := True;
end;

procedure TbsRibbon.Paint;
begin
  if WMEraseReady
  then
    WMEraseReady := False
  else
    PaintRibbon(Canvas);
end;

procedure TbsRibbon.PaintRibbon(C: TCanvas);
var
  i, TOff, LOff, ROff, BOff, XO, YO: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  NewClRect, R, DR, R1: TRect;
  LB, RB, TB, BB, MainTop, BGB: TBitMap;
begin
  GetSkinData;
  if (FIndex = -1) or (FData = nil) or (FDataPicture = nil)
  then
    begin
      C.Brush.Style := bsSolid;
      C.Brush.Color := clBtnShadow;
      C.FillRect(Rect(0, RibbonTopHeight + 2, Width, Height));
      MainTop := TBitMap.Create;
      MainTop.Width := Width;
      MainTop.Height := RibbonTopHeight + 2;
      with MainTop.Canvas do
      begin
        Brush.Style := bsSolid;
        Brush.Color := clBtnShadow;
        FillRect(Rect(0, 0, MainTop.Width, MainTop.Height));
      end;
      if Tabs.Count = 0
      then
        begin
          R := GetPageBoundsRect;
          DR := Rect(R.Left, R.Top, R.Left + R.Right, R.Top + R.Bottom);
          C.Brush.Color := clBtnFace;
          C.FillRect(DR);
        end;
      //
      MainTop.Canvas.Font.Assign(Font);
      CalcItemRects(MainTop.Canvas);

      if AnyTabVisible
      then
        begin
          for i := 0 to Tabs.Count - 1 do
            if Tabs[i].Visible then DrawDefTab(MainTop.Canvas, i);

        end;

      if (Buttons.Count > 0) and (ButtonsImageList <> nil)
      then
        begin
          for i := 0 to Buttons.Count - 1 do
            if Buttons[i].Visible then DrawButton(MainTop.Canvas, i);
        end;

      if (FMDIButtons.Count > 0)
      then
        begin
          for i := 0 to FMDIButtons.Count - 1 do
            DrawMDIButton(MainTop.Canvas, i);
        end;

      C.Draw(0, 0, MainTop);  
      MainTop.Free;
      //
    end
  else
    with FData do
    begin
      TOff := ClRect.Top;
      LOff := ClRect.Left;
      ROff := RectWidth(SkinRect) - ClRect.Right;
      BOff := RectHeight(SkinRect) - ClRect.Bottom;
      //
      R := GetPageBoundsRect;
      DR := Rect(R.Left, R.Top, R.Left + R.Right, R.Top + R.Bottom);
      R := Rect(DR.Left - LOff, DR.Top - TOff, DR.Right + ROff, DR.Bottom + BOff);
      XO := RectWidth(R) - RectWidth(SkinRect);
      YO := RectHeight(R) - RectHeight(SkinRect);
      //
      NewLTPoint := LTPoint;
      NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
      NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
      NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
      NewCLRect := Rect(ClRect.Left, ClRect.Top, ClRect.Right + XO, ClRect.Bottom + YO);
      LB := TBitMap.Create;
      TB := TBitMap.Create;
      RB := TBitMap.Create;
      BB := TBitMap.Create;
      CreateSkinBorderImages(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
        NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewClRect,
       LB, TB, RB, BB, FDataPicture, SkinRect, RectWidth(R), RectHeight(R),
       LeftStretch, TopStretch, RightStretch, BottomStretch);
      //
      MainTop := TBitMap.Create;
      MainTop.Width := Width;
      MainTop.Height := RibbonTopHeight + TB.Height;
      MainTop.Canvas.Draw(0, MainTop.Height - TB.Height, TB);
      R1 := Rect(0, 0, MainTop.Width, MainTop.Height - TB.Height);
      if not IsNullRect(FData.TabsBGRect)
      then
        begin
          BGB := TBitmap.Create;
          BGB.Width := RectWidth(FData.TabsBGRect);
          BGB.Height := RectHeight(FData.TabsBGRect);
          BGB.Canvas.CopyRect(Rect(0, 0, BGB.Width, BGB.Height),
           FDataPicture.Canvas, FData.TabsBGRect);
          MainTop.Canvas.StretchDraw(R1, BGB); 
          BGB.Free;
        end
      else
        with MainTop.Canvas do
        begin
          Brush.Color := FSD.SkinColors.cBtnShadow;
          FillRect(R1);
        end;
      // Draw Objects
      if FUseSkinFont
      then
        with MainTop.Canvas.Font do
        begin
          Name := FData.FontName;
          Style := FData.FontStyle;
          Height := FData.FontHeight;
        end
      else
        MainTop.Canvas.Font.Assign(Font);

      CalcItemRects(MainTop.Canvas);

      if AnyTabVisible
      then
        begin
          for i := 0 to Tabs.Count - 1 do
            if Tabs[i].Visible then DrawTab(MainTop.Canvas, i);
        end;
             
      if (Buttons.Count > 0) and (ButtonsImageList <> nil)
      then
        begin
          for i := 0 to Buttons.Count - 1 do
           if Buttons[i].Visible then DrawButton(MainTop.Canvas, i);
        end;

       if (FMDIButtons.Count > 0)
      then
        begin
          for i := 0 to FMDIButtons.Count - 1 do
            DrawMDIButton(MainTop.Canvas, i);
        end;

  
      //
      C.Draw(R.Left, R.Top + TB.Height, LB);
      C.Draw(R.Left + RectWidth(R) - RB.Width, R.Top + TB.Height, RB);
      C.Draw(R.Left, R.Top + RectHeight(R) - BB.Height, BB);
      C.Draw(0, 0, MainTop);
      if (Tabs.Count = 0) or (not AnyTabVisible) then PaintBG(C, DR);
      //
      MainTop.Free;
      LB.Free;
      TB.Free;
      RB.Free;
      BB.Free;
    end;
end;

procedure TbsRibbon.PaintBG(C: TCanvas; R: TRect);
var
  TabSheetBG, Buffer2: TBitMap;
  SaveIndex, X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
begin
  if (Width <= 0) or (Height <=0) then Exit;

  SaveIndex := SaveDC(C.Handle);
  IntersectClipRect(C.Handle, R.Left, R.Top, R.Right, R.Bottom);

  GetSkinData;

  if FData.BGPictureIndex <> -1
  then
    begin
      TabSheetBG := TBitMap(FSD.FActivePictures.Items[FData.BGPictureIndex]);
      if FData.StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case FData.StretchType of
            bsstFull:
              begin
                C.StretchDraw(R, TabSheetBG);
              end;
            bsstVert:
              begin
                Buffer2 := TBitMap.Create;
                Buffer2.Width := RectWidth(R);
                Buffer2.Height := TabSheetBG.Height;
                Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
                YCnt := RectHeight(R) div Buffer2.Height;
                for Y := 0 to YCnt do
                  C.Draw(R.Left, R.Top + Y * Buffer2.Height, Buffer2);
                Buffer2.Free;
              end;
           bsstHorz:
             begin
               Buffer2 := TBitMap.Create;
               Buffer2.Width := TabSheetBG.Width;
               Buffer2.Height := RectHeight(R);
               Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
               XCnt := RectWidth(R) div Buffer2.Width;
               for X := 0 to XCnt do
                 C.Draw(R.Left  + X * Buffer2.Width, R.Top, Buffer2);
               Buffer2.Free;
             end;
          end;
        end
      else
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := RectWidth(R) div TabSheetBG.Width;
          YCnt := RectHeight(R) div TabSheetBG.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          C.Draw(R.Left + X * TabSheetBG.Width, R.Top + Y * TabSheetBG.Height, TabSheetBG);
        end;
      C.Free;
      Exit;
    end;

  w1 := RectWidth(R);
  h1 := RectHeight(R);

  with FData do
  begin
    TabSheetBG := TBitMap.Create;
    TabSheetBG.Width := RectWidth(ClRect);
    TabSheetBG.Height := RectHeight(ClRect);
    TabSheetBG.Canvas.CopyRect(Rect(0, 0, TabSheetBG.Width, TabSheetBG.Height),
         FDataPicture.Canvas,
          Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
               SkinRect.Left + ClRect.Right,
               SkinRect.Top + ClRect.Bottom));

     if StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case StretchType of
            bsstFull:
              begin
                C.StretchDraw(R, TabSheetBG);
              end;
            bsstVert:
              begin
                Buffer2 := TBitMap.Create;
                Buffer2.Width := RectWidth(R);
                Buffer2.Height := TabSheetBG.Height;
                Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
                YCnt := RectHeight(R) div Buffer2.Height;
                for Y := 0 to YCnt do
                  C.Draw(R.Left, R.Top + Y * Buffer2.Height, Buffer2);
                Buffer2.Free;
              end;
           bsstHorz:
             begin
               Buffer2 := TBitMap.Create;
               Buffer2.Width := TabSheetBG.Width;
               Buffer2.Height := RectHeight(R);
               Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
               XCnt := RectWidth(R) div Buffer2.Width;
               for X := 0 to XCnt do
                 C.Draw(R.Left + X * Buffer2.Width, R.Top, Buffer2);
               Buffer2.Free;
             end;
          end;
        end
      else
        begin
          w := RectWidth(ClRect);
          h := RectHeight(ClRect);
          XCnt := w1 div w;
          YCnt := h1 div h;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          C.Draw(R.Left + X * w, R.Top + Y * h, TabSheetBG);
        end;
    TabSheetBG.Free;
  end;

  RestoreDC(C.Handle, SaveIndex);
end;

procedure TbsRibbon.DrawDefTab(C: TCanvas; Index: Integer);
var
  Buffer: TBitmap;
  R: TRect;
begin
  if (Index = TabIndex)
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(Tabs[Index].ItemRect);
      Buffer.Height := RectHeight(Tabs[Index].ItemRect) + 2;
      Buffer.Canvas.Brush.Color := clBtnFace;
      Buffer.Canvas.FillRect(Rect(0, 0, Buffer.Width, Buffer.Height));
      Buffer.Canvas.Font.Assign(C.Font);
      Buffer.Canvas.Font.Color := clBtnText;
      Buffer.Canvas.Brush.Style := bsClear;
      R := Rect(0, 0, 0, 0);
      DrawText(Buffer.Canvas.Handle, PChar(Tabs[Index].Page.Caption),
        Length(Tabs[Index].Page.Caption), R,
         DT_CALCRECT or DT_LEFT);
      if RectWidth(R) > RectWidth(Tabs[Index].ItemRect) - 6
      then
        BSDrawText(Buffer.Canvas,
          Tabs[Index].Page.Caption, Rect(3, 0, Buffer.Width - 3, Buffer.Height - 1))
      else
        BSDrawText4(Buffer.Canvas,
          Tabs[Index].Page.Caption, Rect(3, 0, Buffer.Width - 3, Buffer.Height - 1));
      C.Draw(Tabs[Index].ItemRect.Left, Tabs[Index].ItemRect.Top,
        Buffer);
      Buffer.Free;
    end
  else
    begin
      C.Brush.Style := bsClear;
      C.Font.Color := clBtnHighLight;
      R := Rect(0, 0, 0, 0);
      DrawText(C.Handle, PChar(Tabs[Index].Page.Caption),
        Length(Tabs[Index].Page.Caption), R,
         DT_CALCRECT or DT_LEFT);
      if RectWidth(R) > RectWidth(Tabs[Index].ItemRect) - 6
      then
        BSDrawText(C, Tabs[Index].Page.Caption,
          Rect(Tabs[Index].ItemRect.Left + 3,
               Tabs[Index].ItemRect.Top,
               Tabs[Index].ItemRect.Right - 3,
               Tabs[Index].ItemRect.Bottom))
      else
        BSDrawText4(C, Tabs[Index].Page.Caption,
          Rect(Tabs[Index].ItemRect.Left + 3,
               Tabs[Index].ItemRect.Top,
               Tabs[Index].ItemRect.Right - 3,
               Tabs[Index].ItemRect.Bottom));
      if FShowDivider
      then
        begin
          C.Pen.Color := cl3DdkShadow;
          C.MoveTo(Tabs[Index].ItemRect.Right, Tabs[Index].ItemRect.Top);
          C.LineTo(Tabs[Index].ItemRect.Right, Tabs[Index].ItemRect.Bottom + 1);
        end;
    end;
end;

procedure TbsRibbon.DrawTab(C: TCanvas; Index: Integer);
var
  Buffer, DevBuffer: TBitmap;
  R: TRect;
begin
  if (Index = TabIndex) and Focused and not IsNullRect(FData.FocusTabRect) and
    not ((AppMenu <> nil) and AppMenu.Visible)
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(Tabs[Index].ItemRect);
      Buffer.Height := RectHeight(FData.FocusTabRect);
      with FData do
        CreateHSkinImage(TabLeftOffset, TabRightOffset,
          Buffer, FDataPicture, FocusTabRect,
           Buffer.Width, Buffer.Height, TabStretchEffect);
      Buffer.Canvas.Font.Assign(C.Font);
      Buffer.Canvas.Font.Color := FData.FocusFontColor;
      Buffer.Canvas.Brush.Style := bsClear;
      R := Rect(0, 0, 0, 0);
      DrawText(Buffer.Canvas.Handle, PChar(Tabs[Index].Page.Caption),
        Length(Tabs[Index].Page.Caption), R,
         DT_CALCRECT or DT_LEFT);
      if RectWidth(R) > RectWidth(Tabs[Index].ItemRect) - 6
      then
        BSDrawText(Buffer.Canvas,
          Tabs[Index].Page.Caption, Rect(3, 0, Buffer.Width - 3, Buffer.Height - 1))
      else
        BSDrawText4(Buffer.Canvas,
          Tabs[Index].Page.Caption, Rect(3, 0, Buffer.Width - 3, Buffer.Height - 1));
      C.Draw(Tabs[Index].ItemRect.Left, Tabs[Index].ItemRect.Top,
        Buffer);
      Buffer.Free;
    end
  else
  if (Index = TabIndex) and not IsNullRect(FData.ActiveTabRect) and
     not ((AppMenu <> nil) and AppMenu.Visible)
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(Tabs[Index].ItemRect);
      Buffer.Height := RectHeight(FData.ActiveTabRect);
      with FData do
        CreateHSkinImage(TabLeftOffset, TabRightOffset,
          Buffer, FDataPicture, ActiveTabRect,
           Buffer.Width, Buffer.Height, TabStretchEffect);
      Buffer.Canvas.Brush.Style := bsClear;
      Buffer.Canvas.Font.Assign(C.Font);
      Buffer.Canvas.Font.Color := FData.ActiveFontColor;
      R := Rect(0, 0, 0, 0);
      DrawText(Buffer.Canvas.Handle, PChar(Tabs[Index].Page.Caption),
        Length(Tabs[Index].Page.Caption), R,
         DT_CALCRECT or DT_LEFT);
      if RectWidth(R) > RectWidth(Tabs[Index].ItemRect) - 6
      then
        BSDrawText(Buffer.Canvas,
          Tabs[Index].Page.Caption, Rect(3, 0, Buffer.Width - 3, Buffer.Height - 1))
      else
        BSDrawText4(Buffer.Canvas,
          Tabs[Index].Page.Caption, Rect(3, 0, Buffer.Width - 3, Buffer.Height - 1));
      C.Draw(Tabs[Index].ItemRect.Left, Tabs[Index].ItemRect.Top,
        Buffer);
      Buffer.Free;
    end
  else
  if (Tabs[Index].Active) and not IsNullRect(FData.MouseInTabRect)
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(Tabs[Index].ItemRect);
      Buffer.Height := RectHeight(FData.MouseInTabRect);
      with FData do
        CreateHSkinImage(TabLeftOffset, TabRightOffset,
          Buffer, FDataPicture, MouseInTabRect,
           Buffer.Width, Buffer.Height, TabStretchEffect);
      Buffer.Canvas.Brush.Style := bsClear;
      Buffer.Canvas.Font.Assign(C.Font);
      Buffer.Canvas.Font.Color := FData.MouseInFontColor;
      R := Rect(0, 0, 0, 0);
      DrawText(Buffer.Canvas.Handle, PChar(Tabs[Index].Page.Caption),
        Length(Tabs[Index].Page.Caption), R,
         DT_CALCRECT or DT_LEFT);
      if RectWidth(R) > RectWidth(Tabs[Index].ItemRect) - 6
      then
        BSDrawText(Buffer.Canvas,
          Tabs[Index].Page.Caption, Rect(3, 0, Buffer.Width - 3, Buffer.Height))
      else
        BSDrawText4(Buffer.Canvas,
          Tabs[Index].Page.Caption, Rect(3, 0, Buffer.Width - 3, Buffer.Height));
      C.Draw(Tabs[Index].ItemRect.Left, Tabs[Index].ItemRect.Top,
        Buffer);
      Buffer.Free;
    end
  else
    begin
      C.Brush.Style := bsClear;
      if Tabs[Index].Active
      then
        C.Font.Color := FData.MouseInFontColor
      else
        C.Font.Color := FData.FontColor;
      R := Rect(0, 0, 0, 0);
      DrawText(C.Handle, PChar(Tabs[Index].Page.Caption),
        Length(Tabs[Index].Page.Caption), R,
         DT_CALCRECT or DT_LEFT);
      if RectWidth(R) > RectWidth(Tabs[Index].ItemRect) - 6
      then
        BSDrawText(C, Tabs[Index].Page.Caption,
          Rect(Tabs[Index].ItemRect.Left + 3,
               Tabs[Index].ItemRect.Top,
               Tabs[Index].ItemRect.Right - 3,
               Tabs[Index].ItemRect.Bottom))
      else
        BSDrawText4(C, Tabs[Index].Page.Caption,
          Rect(Tabs[Index].ItemRect.Left + 3,
               Tabs[Index].ItemRect.Top,
               Tabs[Index].ItemRect.Right - 3,
               Tabs[Index].ItemRect.Bottom));
      if FShowDivider
      then
        begin
          if IsNullRect(FData.DividerRect)
          then
            begin
              C.Pen.Color := FSD.SkinColors.cBtnShadow;
              C.MoveTo(Tabs[Index].ItemRect.Right, Tabs[Index].ItemRect.Top);
              C.LineTo(Tabs[Index].ItemRect.Right, Tabs[Index].ItemRect.Bottom);
            end
          else
            begin
              DevBuffer := TBitMap.Create;
              DevBuffer.Width := RectWidth(FData.DividerRect);
              DevBuffer.Height := RectHeight(FData.DividerRect);
              DevBuffer.Canvas.CopyRect(Rect(0, 0, DevBuffer.Width, DevBuffer.Height),
                FDataPicture.Canvas, FData.DividerRect);
              if FData.DividerTransparent
              then
                begin
                  DevBuffer.Transparent := True;
                  DevBuffer.TransparentMode := tmFixed;
                  DevBuffer.TransparentColor := FData.DividerTransparentColor;
                end;
              C.Draw(Tabs[Index].ItemRect.Right - DevBuffer.Width,
                     Tabs[Index].ItemRect.Bottom - DevBuffer.Height,
                DevBuffer);
              DevBuffer.Free;
            end;
        end;
    end;
end;

procedure TbsRibbon.DrawMDIButton(Cnvs: TCanvas; Index: Integer);
var
  R1, R2, R3, R: TRect;
  Buffer: TBitMap;
  IC: TColor;
  IX, IY: Integer;
begin
  if (FIndex = -1) or (FData = nil)
  then
    begin
      if FMDIButtons[Index].Active or FMDIButtons[Index].Down
      then
        IC := clBtnHighLight
      else
        IC := clBtnText;
      IX := FMDIButtons[Index].ItemRect.Left +
        RectWidth(FMDIButtons[Index].ItemRect) div 2  - 5;
      IY := FMDIButtons[Index].ItemRect.Top +
        RectHeight(FMDIButtons[Index].ItemRect) div 2  - 4;
      case FMDIButtons[Index].Code of
        1:
          begin
            DrawCloseImage(Cnvs, IX, IY, IC);
          end;
        2:
          begin
            DrawRestoreImage(Cnvs, IX, IY, IC);
          end;
        3:
          begin
            DrawMinimizeImage(Cnvs, IX, IY, IC);
          end;
      end;
    end
  else
    begin
      case FMDIButtons[Index].Code of
        1:
          begin
            R1 := FData.MDICloseRect;
            R2 := FData.MDICloseActiveRect;
            R3 := FData.MDICloseDownRect;
          end;
        2:
          begin
            R1 := FData.MDIRestoreRect;
            R2 := FData.MDIRestoreActiveRect;
            R3 := FData.MDIRestoreDownRect;
          end;
        3:
          begin
            R1 := FData.MDIMinRect;
            R2 := FData.MDIMinActiveRect;
            R3 := FData.MDIMinDownRect;
          end;
      end;
      if IsNullRect(R2) then R2 := R1;
      if IsNullRect(R3) then R3 := R2;
      if FMDIButtons[Index].Active and FMDIButtons[Index].Down
      then
        R := R3
      else
      if FMDIButtons[Index].Active
      then
        R := R2
      else
        R := R1;
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(R);
      Buffer.Height := RectHeight(R);
      Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
        Self.FDataPicture.Canvas, R);
      if FData.MDIButtonsTransparent
      then
        begin
          Buffer.Transparent := True;
          Buffer.TransparentMode := tmFixed;
          Buffer.TransparentColor := FData.MDIButtonsTransparentColor;
        end;
      Cnvs.Draw(FMDIButtons[Index].ItemRect.Left,
                FMDIButtons[Index].ItemRect.Top,
                Buffer);
      Buffer.Free;
    end;  
end;

procedure TbsRibbon.DrawButton(Cnvs: TCanvas; Index: Integer);

procedure DrawButtonImage(R: TRect; ADown: Boolean);
var
  CIndex: Integer;
  Picture: TBitmap;
  Buffer: TBitMap;
  ButtonData: TbsDataSkinButtonControl;
begin
  CIndex := FSD.GetControlIndex('officeribbonbutton');
  if CIndex = -1 then CIndex := FSD.GetControlIndex('resizetoolbutton');
  if CIndex = -1 then Exit;
  ButtonData := TbsDataSkinButtonControl(FSD.CtrlList[CIndex]);
  Picture := TBitMap(FSD.FActivePictures.Items[ButtonData.PictureIndex]);
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(R);
  Buffer.Height := RectWidth(R);
  with ButtonData do
  if ADown
  then
    CreateStretchImage(Buffer, Picture, DownSkinRect, ClRect, True)
  else
    CreateStretchImage(Buffer, Picture, ActiveSkinRect, ClRect, True);
  Cnvs.Draw(R.Left, R.Top, Buffer);
  Buffer.Free;
end;

procedure DrawButtonDefImage(R: TRect; ADown: Boolean);
var
  Buffer: TBitMap;
  C: TColor;
begin
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(R);
  Buffer.Height := RectWidth(R);
  if ADown
  then
    C := cl3DdkShadow
  else
    C := clBtnFace;
  Buffer.Canvas.Brush.Color := C;
  Buffer.Canvas.FillRect(Rect(0, 0, Buffer.Width, Buffer.Height));
  Cnvs.Draw(R.Left, R.Top, Buffer);
  Buffer.Free;
end;

var
  X, Y: Integer;
begin
  if FIndex = -1
  then
    begin
      with Buttons[Index] do
      if Visible
      then
        begin
          if Active and Down
          then DrawButtonDefImage(ItemRect, True)
          else if Active then DrawButtonDefImage(ItemRect, False);
          X := ItemRect.Left + RectWidth(ItemRect) div 2 - ButtonsImageList.Width div 2;
          Y := ItemRect.Top + RectHeight(ItemRect) div 2 - ButtonsImageList.Height div 2 + 1;
          if (ImageIndex < ButtonsImageList.Count) and (ImageIndex >= 0)
          then
             ButtonsImageList.Draw(Cnvs, X, Y, ImageIndex, Enabled);
        end;
    end
  else
  with Buttons[Index] do
  if Visible
  then
    begin
      if (Active and Down) or (FPopupButton = Index)
      then DrawButtonImage(ItemRect, True)
      else if Active then DrawButtonImage(ItemRect, False);
      X := ItemRect.Left + RectWidth(ItemRect) div 2 - ButtonsImageList.Width div 2;
      Y := ItemRect.Top + RectHeight(ItemRect) div 2 - ButtonsImageList.Height div 2 + 1;
      if (ImageIndex < ButtonsImageList.Count) and (ImageIndex >= 0)
      then
        ButtonsImageList.Draw(Cnvs, X, Y, ImageIndex, Enabled);
    end;
end;

constructor TbsRibbonButtonItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FPopupMenu := nil;
  ItemRect := NullRect;
  FImageIndex := -1;
  FHint := '';
  FEnabled := True;
  FVisible := True;
  Active := False;
  Down := False;
end;

procedure TbsRibbonButtonItem.Assign(Source: TPersistent);
begin
  if Source is TbsRibbonButtonItem then
  begin
    FImageIndex := TbsRibbonButtonItem(Source).ImageIndex;
    FHint := TbsRibbonButtonItem(Source).Hint;
    FEnabled := TbsRibbonButtonItem(Source).Enabled;
    FVisible := TbsRibbonButtonItem(Source).Visible;
  end
  else
    inherited Assign(Source);
end;

procedure TbsRibbonButtonItem.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
  Changed(False);
end;

procedure TbsRibbonButtonItem.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  Changed(False);
end;

procedure TbsRibbonButtonItem.SetVisible(Value: Boolean);
begin
  FVisible := Value;
  Changed(False);
end;

constructor TbsRibbonButtonItems.Create;
begin
  inherited Create(TbsRibbonButtonItem);
  Ribbon := ARibbon;
end;

function TbsRibbonButtonItems.GetOwner: TPersistent;
begin
  Result := Ribbon;
end;

procedure TbsRibbonButtonItems.Update(Item: TCollectionItem);
begin
  if Ribbon = nil then Exit;
  if not (csLoading in Ribbon.ComponentState)
  then
    Ribbon.Invalidate;
end;

function TbsRibbonButtonItems.GetItem(Index: Integer):  TbsRibbonButtonItem;
begin
  Result := TbsRibbonButtonItem(inherited GetItem(Index));
end;

procedure TbsRibbonButtonItems.SetItem(Index: Integer; Value:  TbsRibbonButtonItem);
begin
  inherited SetItem(Index, Value);
end;

function TbsRibbonButtonItems.Add: TbsRibbonButtonItem;
begin
  Result := TbsRibbonButtonItem(inherited Add);
end;

function TbsRibbonButtonItems.Insert(Index: Integer): TbsRibbonButtonItem;
begin
  Result := TbsRibbonButtonItem(inherited Insert(Index));
end;

procedure TbsRibbonButtonItems.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

procedure TbsRibbonButtonItems.Clear;
begin
  inherited Clear;
end;

constructor TbsRibbonGroup.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csOpaque, csDoubleClicks, csReplicatable];
  FForceBackground := False;
  FSkinDataName := 'officegroup';
  FShowDialogButton := False;
  Width := 120;
  Height := 100;
  FMouseIn := False;
end;

destructor TbsRibbonGroup.Destroy;
begin
  inherited;
end;

procedure TbsRibbonGroup.AdjustClientRect(var Rect: TRect); 
begin
  Rect.Left := 2;
  Rect.Top := 2;
  Rect.Right := Width - 2;
  Rect.Bottom := Height - StdRibbonGroupCapHeight - 2;
  inherited AdjustClientRect(Rect);
end;

procedure TbsRibbonGroup.CMTextChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TbsRibbonGroup.SetShowDialogButton;
begin
  if FShowDialogButton <> Value
  then
    begin
      FShowDialogButton := Value;
      Invalidate;
    end;  
end;

procedure TbsRibbonGroup.GetSkinData; 
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinPanelControl
    then
      with TbsDataSkinPanelControl(FSD.CtrlList.Items[FIndex]) do
      begin
        FSkinRect := SkinRect;
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.ButtonRect := ButtonRect;
        Self.ButtonActiveRect := ButtonActiveRect;
        Self.ButtonDownRect := ButtonDownRect;
        Self.ButtonTransparent := ButtonTransparent;
        Self.ButtonTransparentColor := ButtonTransparentColor;
      end;
end;

procedure TbsRibbonGroup.CreateControlDefaultImage(B: TBitMap);
var
  R: TRect;
  CaptionRect: TRect;
  w, h: Integer;
begin
  inherited;
  with B.Canvas do
  begin
    Pen.Color := clBtnShadow;
    Brush.Color := Darker(clBtnFace, 10);
    R := Rect(1, Height - StdRibbonGroupCapHeight, Width - 1, Height - 1);
    FillRect(R);
    MoveTo(Width - 1, Height - 1);
    LineTo(Width - 1, 0);
    // draw caption
    CaptionRect := Rect(2, Height - StdRibbonGroupCapHeight,
      Width - 2, Height - 1);
    Font.Assign(Self.DefaultFont);
    Font.Color := clBtnText;
    BSDrawText4(B.Canvas, Caption, CaptionRect);
    h :=  StdRibbonGroupCapHeight - 4;
    w := h;
    BRect.Left := CaptionRect.Right - w - 2;
    BRect.Top := CaptionRect.Top + 2;
    BRect.Right := BRect.Left + w;
    BRect.Bottom := BRect.Top + h;
    //
    if FShowDialogButton
    then
      begin
        if BActive or BDown
        then
          DrawRibbonArrowImage(B.Canvas, BRect, clBtnHighLight)
        else
          DrawRibbonArrowImage(B.Canvas, BRect, clBtnShadow);
      end;
    //
  end;
end;

procedure TbsRibbonGroup.CreateControlSkinImage(B: TBitMap);
var
  CaptionRect: TRect;
  w, h, ro, bo: Integer;
  Buffer: TBitMap;
  R: TRect;
begin
 inherited;

  CaptionRect := Rect(2, Height - StdRibbonGroupCapHeight,
     Width - 2, Height - 1);
  if not FUseSkinFont
  then
    begin
      Font.Assign(Self.DefaultFont);
      B.Canvas.Font.Color := FontColor;
      Brush.Style := bsClear;
    end
  else
    with B.Canvas do
    begin
      Font.Name := FontName;
      Font.Color := FontColor;
      Font.Style := FontStyle;
      Brush.Style := bsClear;
    end;
  BSDrawText4(B.Canvas, Caption, CaptionRect);
  if FShowDialogButton and not IsNullRect(ButtonRect)
  then
    begin
      w := RectWidth(ButtonRect);
      h := RectHeight(ButtonRect);
      ro := RectWidth(SkinRect) - ClRect.Right;
      bo := RectHeight(SkinRect) - ClRect.Bottom; 
      BRect.Left := Width - ro - w;
      BRect.Top := Height - bo - h;
      BRect.Right := BRect.Left + w;
      BRect.Bottom := BRect.Top + h;
      //
      Buffer := TBitMap.Create;
      Buffer.Width := w;
      Buffer.Height := h;
      if BActive and BDown and not IsNullRect(ButtonDownRect)
      then
        R := ButtonDownRect
      else
      if BActive and not IsNullRect(ButtonActiveRect)
      then
        R := ButtonActiveRect
      else
        R := ButtonRect;

      Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
        Picture.Canvas, R);

      if ButtonTransparent
      then
        begin
          Buffer.Transparent := True;
          Buffer.TransparentMode := tmFixed;
          Buffer.TransparentColor := ButtonTransparentColor;
        end;
        
      B.Canvas.Draw(BRect.Left, BRect.Top, Buffer);
      Buffer.Free;
      //
    end;
end;

procedure TbsRibbonGroup.Paint; 
begin
  inherited;
end;

procedure TbsRibbonGroup.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if FShowDialogButton then TestActive(X, Y);
end;

procedure TbsRibbonGroup.MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer);
begin
  inherited;

  if FShowDialogButton and (Button = mbLeft)
  then
    begin
      TestActive(X, Y);
      if BActive
      then
        begin
          BDown := True;
          UpdateButton;
        end;
    end;
end;

procedure TbsRibbonGroup.MouseUp(Button: TMouseButton; Shift: TShiftState;
                       X, Y: Integer);
begin
  inherited;
  if FShowDialogButton and (Button = mbLeft)
  then
    begin
      TestActive(X, Y);
      if BActive
      then
        begin
          BDown := False;
          UpdateButton;
          if Assigned(FOnDialogButtonClick) then FOnDialogButtonClick(Self);
        end;
    end;    
end;

procedure TbsRibbonGroup.CMMouseEnter;
begin
  inherited;
end;

procedure TbsRibbonGroup.CMMouseLeave;
begin
  inherited;
  if FShowDialogButton then TestActive(-1, -1);
end;

procedure TbsRibbonGroup.TestActive(X, Y: Integer);
var
  B: Boolean;
begin
  B := BActive;
  BActive := PtInRect(BRect, Point(X, Y));
  if B <> BActive then UpDateButton;
end;

procedure TbsRibbonGroup.UpDateButton;
begin
  InvalidateRect(Handle, @BRect, False);
end;


// =============================================================================
constructor TbsRibbonCustomPage.Create;
begin
  inherited;
  FMouseIn := False;
  Ribbon := nil;
  PanelData := nil;
  ButtonData := nil;
  FCanScroll := True;
  FHotScroll := False;
  TimerMode := 0;
  FScrollOffset := 0;
  FScrollTimerInterval := 50;
  Width := 150;
  Height := 30;
  Buttons[0].Visible := False;
  Buttons[1].Visible := False;
  FHSizeOffset := 0;
  SMax := 0;
  SPosition := 0;
  SOldPosition := 0;
  SPage := 0;
end;

function TbsRibbonCustomPage.CheckActivation;
begin
  Result := FCanScroll and (Buttons[0].Visible or Buttons[1].Visible);
end;

procedure TbsRibbonCustomPage.CMSENCPaint(var Message: TMessage);
var
  C: TCanvas;
begin
  if (Message.wParam <> 0) and (Buttons[0].Visible or Buttons[1].Visible)
  then
    begin
      C := TControlCanvas.Create;
      C.Handle := Message.wParam;
      if Buttons[0].Visible then DrawButton(C, 0);
      if Buttons[1].Visible then DrawButton(C, 1);
      C.Handle := 0;
      C.Free;
      Message.Result := SE_RESULT;
    end
  else
    Message.Result := 0;
end;

procedure TbsRibbonCustomPage.CMBENCPAINT;
var
  C: TCanvas;
begin
  if (Message.LParam = BE_ID)
  then
    begin
      if (Message.wParam <> 0) and (Buttons[0].Visible or Buttons[1].Visible)
      then
        begin
          C := TControlCanvas.Create;
          C.Handle := Message.wParam;
          if Buttons[0].Visible then DrawButton(C, 0);
          if Buttons[1].Visible then DrawButton(C, 1);
          C.Handle := 0;
          C.Free;
        end;
      Message.Result := BE_ID;
    end
  else
    inherited;
end;

procedure TbsRibbonCustomPage.WMSETCURSOR(var Message: TWMSetCursor);
begin
  if FCanScroll
  then
    if (Message.HitTest = HTBUTTON1) or
       (Message.HitTest = HTBUTTON2)
    then
      begin
        Message.HitTest :=  HTCLIENT;
      end;
  inherited;
end;

procedure TbsRibbonCustomPage.SetPosition(const Value: integer);
begin
  if Value <> SPosition
  then
    begin
      SPosition := Value;
      GetScrollInfo;
    end;
end;

destructor TbsRibbonCustomPage.Destroy;
begin
  inherited;
end;

procedure TbsRibbonCustomPage.UpDateSize;
begin
  SetBounds(Left, Top, Width, Height);
end;

procedure TbsRibbonCustomPage.StartTimer;
begin
  KillTimer(Handle, 1);
  SetTimer(Handle, 1, Self.ScrollTimerInterval, nil);
end;

procedure TbsRibbonCustomPage.StopTimer;
begin
  KillTimer(Handle, 1);
  TimerMode := 0;
end;

procedure TbsRibbonCustomPage.WMDESTROY(var Message: TMessage);
begin
  KillTimer(Handle, 1);
  KillTimer(Handle, 2);
  FMouseIn := False;
  inherited;
end;

procedure TbsRibbonCustomPage.WMTimer;
var
  P: TPoint;
begin
  inherited;

  if Message.TimerID = 1
  then
    begin
      case TimerMode of
        1: ButtonClick(0);
        2: ButtonClick(1);
      end;
    end;

  if Message.TimerID = 2
  then
    begin
      GetCursorPos(P);
      if WindowFromPoint(P) <> Handle
      then
        begin
          KillTimer(Handle, 2);
          CMMouseLeave;
        end;
   end;

end;

procedure TbsRibbonCustomPage.AdjustClientRect(var Rect: TRect);
var
  RLeft, RTop, VMax, HMax: Integer;
begin
  if FCanScroll
  then
    begin
      RTop := 0;
      RLeft := - SPosition;
      HMax := Max(SMax, ClientWidth);
      VMax := ClientHeight;
      Rect := Bounds(RLeft, RTop,  HMax, VMax);
    end;  
  inherited AdjustClientRect(Rect);
end;

procedure TbsRibbonCustomPage.HScrollControls(AOffset: Integer);
begin
  ScrollBy(-AOffset, 0);
  if (Ribbon <> nil) and (Ribbon.FData <> nil) and
    Ribbon.FData.StretchEffect then Invalidate;
end;

procedure TbsRibbonCustomPage.SetBounds;
var
  OldWidth: Integer;
begin
  OldWidth := Width;
  inherited;
  if (OldWidth <> Width)
  then
    begin
      if (OldWidth < Width) and (OldWidth <> 0)
      then FHSizeOffset := Width - OldWidth
      else FHSizeOffset := 0;
    end
  else
    FHSizeOffset := 0;
  if FCanScroll then GetScrollInfo;
end;

procedure TbsRibbonCustomPage.GetHRange;
var
  i, FMax, W, MaxRight: Integer;
begin
  MaxRight := 0;
  if ControlCount > 0
  then
  for i := 0 to ControlCount - 1 do
  with Controls[i] do
  begin
   if Visible
   then
     if Left + Width > MaxRight then MaxRight := left + Width;
  end;
  if MaxRight = 0
  then
    begin
      if Buttons[1].Visible then SetButtonsVisible(False);
      Exit;
    end;
  W := ClientWidth;
  FMax := MaxRight + SPosition;
  if (FMax > W)
  then
    begin
      if not Buttons[1].Visible then  SetButtonsVisible(True);
      if (SPosition > 0) and (MaxRight < W) and (FHSizeOffset > 0)
      then
        begin
          if FHSizeOffset > SPosition then FHSizeOffset := SPosition;
          SMax := FMax - 1;
          SPosition := SPosition - FHSizeOffset;
          SPage := W;
          HScrollControls(-FHSizeOffset);
          SOldPosition := SPosition;
        end
     else
       begin
         if (FHSizeOffset = 0) and ((FMax - 1) < SMax) and (SPosition > 0) and
            (MaxRight < W)
         then
           begin
             SMax := FMax - 1;
             SPosition := SPosition - (W - MaxRight);
             SPage := W;
             HScrollControls(MaxRight - W);
             FHSizeOffset := 0;
             SOldPosition := SPosition;
           end
         else
           begin
             SMax := FMax - 1;
             SPage := W;
           end;
          FHSizeOffset := 0;
          SOldPosition := SPosition;
        end;
    end
  else
    begin
      if SPosition > 0 then HScrollControls(-SPosition);
      FHSizeOffset := 0;
      SMax := 0;
      SPosition := 0;
      SPage := 0;
      if Buttons[1].Visible then SetButtonsVisible(False);
   end;
end;

procedure TbsRibbonCustomPage.GetScrollInfo;
begin
  if FCanScroll then GetHRange;
end;

procedure TbsRibbonCustomPage.SetButtonsVisible;
var
  F: TCustomForm;
  C: TWinControl;
begin
  if Buttons[0].Visible <> AVisible
  then
    begin
      Buttons[0].Visible := AVisible;
      Buttons[1].Visible := AVisible;
      if not (Parent is TbsSkinCoolBar)
      then
        begin
          //
          C := nil;
          F := GetParentForm(Self);
          if F <> nil then C := F.ActiveControl;
          if (C <> nil) and C.Focused and (C.Parent <> nil)
          then
            begin
              if not ((C.Parent = Self) or (C.Parent.Parent = Self))
              then
                C := nil;
            end
          else
            C := nil;
          //    
          FMouseIn := False;
          ReCreateWnd;
          HandleNeeded;
          //
          if (C <> nil) and C.Visible and not C.Focused and C.CanFocus then C.SetFocus;
          //
        end;
    end;
end;

procedure TbsRibbonCustomPage.ButtonDown(I: Integer);
begin
  case I of
    0:
      begin
        TimerMode := 1;
        StartTimer;
      end;
    1:
      begin
        TimerMode := 2;
        StartTimer;
      end;
  end;
end;

procedure TbsRibbonCustomPage.ButtonUp(I: Integer);
begin
  case I of
    0:
      begin
        StopTimer;
        TimerMode := 0;
        ButtonClick(0);
      end;
    1:
      begin
        StopTimer;
        TimerMode := 0;
        ButtonClick(1);
      end;
  end;
end;

procedure TbsRibbonCustomPage.ButtonClick;
var
  SOffset: Integer;
begin
  if FScrollOffset = 0
  then
    SOffset := ClientWidth
  else
    SOffset := FScrollOffset;

  case I of
    0:
        begin
          SPosition := SPosition - SOffset;
          if SPosition < 0 then SPosition := 0;
          if (SPosition - SOldPosition <> 0)
          then
            begin
              HScrollControls(SPosition - SOldPosition);
              GetHRange;
            end
          else
            StopTimer;
        end;

    1:
        begin
          SPosition := SPosition + SOffset;
          if SPosition > SMax - SPage + 1 then SPosition := SMax - SPage + 1;
          if (SPosition - SOldPosition <> 0)
          then
            begin
              HScrollControls(SPosition - SOldPosition);
              GetHRange;
            end
          else
            StopTimer;
        end;
   end;
end;

procedure TbsRibbonCustomPage.CMMouseEnter;
begin
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := True;
  if CheckActivation
  then
    begin
      KillTimer(Handle, 2);
      SetTimer(Handle, 2, 100, nil);
    end;
end;

procedure TbsRibbonCustomPage.CMMOUSELEAVE;
var
  P: TPoint;
begin
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := False;
  if  FCanScroll then begin
  GetCursorPos(P);
  if WindowFromPoint(P) <> Handle
  then
    if Buttons[0].MouseIn and Buttons[0].Visible
    then
      begin
        if TimerMode <> 0 then StopTimer;
        Buttons[0].MouseIn := False;
        SendMessage(Handle, WM_NCPAINT, 0, 0);
      end
    else
      if Buttons[1].MouseIn and Buttons[1].Visible
      then
        begin
          if TimerMode <> 0 then StopTimer;
          Buttons[1].MouseIn := False;
          SendMessage(Handle, WM_NCPAINT, 0, 0);
        end;
   end;
end;

procedure TbsRibbonCustomPage.WndProc;
var
  B: Boolean;
  P: TPoint;
begin
  B := True;

  if FCanScroll then

  case Message.Msg of
    WM_WINDOWPOSCHANGING:
      if Self.HandleAllocated and (Align = alNone)
      then
        GetScrollInfo;
    WM_NCHITTEST:
      if not (csDesigning in ComponentState) then
      begin
        //
        if not FMouseIn then CMMouseEnter;
        //
        P.X := LoWord(Message.lParam);
        P.Y := HiWord(Message.lParam);
        P := ScreenToClient(P);
        if (P.X < 0) and Buttons[0].Visible
        then
          begin
            Message.Result := HTBUTTON1;
            B := False;
          end
        else
        if (P.X > ClientWidth) and Buttons[1].Visible
        then
          begin
            Message.Result := HTBUTTON2;
            B := False;
          end;
      end;


    WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK:
       begin
         if Message.wParam = HTBUTTON1
         then
           begin
             Buttons[0].Down := True;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonDown(0);
           end
         else
         if  Message.wParam = HTBUTTON2
         then
           begin
             Buttons[1].Down := True;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonDown(1);
           end;

       end;

    WM_NCLBUTTONUP:
       begin
         if  Message.wParam = HTBUTTON1
         then
           begin
             Buttons[0].Down := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonUp(0);
           end
         else
         if Message.wParam = HTBUTTON2
         then
           begin
             Buttons[1].Down := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonUp(1);
           end;
       end;

     WM_NCMOUSEMOVE:
       begin
         if (Message.wParam = HTBUTTON1) and (not Buttons[0].MouseIn)
         then
           begin
             Buttons[0].MouseIn := True;
             Buttons[1].MouseIn := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             if FHotScroll
             then
               begin
                 TimerMode := 1;
                 StartTimer;
               end;
           end
         else
         if (Message.wParam = HTBUTTON2) and (not Buttons[1].MouseIn)
         then
           begin
             Buttons[1].MouseIn := True;
             Buttons[0].MouseIn := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             if FHotScroll
             then
               begin
                 TimerMode := 2;
                 StartTimer;
               end;
           end;
       end;

     WM_MOUSEMOVE:
      begin
        if Buttons[0].MouseIn and Buttons[0].Visible
        then
          begin
            if TimerMode <> 0 then StopTimer;
            Buttons[0].MouseIn := False;
            SendMessage(Handle, WM_NCPAINT, 0, 0);
          end
        else
        if Buttons[1].MouseIn and Buttons[1].Visible
        then
          begin
            if TimerMode <> 0 then StopTimer;
            Buttons[1].MouseIn := False;
            SendMessage(Handle, WM_NCPAINT, 0, 0);
          end;
      end;
      
  end;

  if B then inherited;
end;

procedure TbsRibbonCustomPage.Paint;
begin
end;

procedure TbsRibbonCustomPage.SetScrollOffset;
begin
  if Value >= 0 then FScrollOffset := Value;
end;

procedure TbsRibbonCustomPage.WMNCCALCSIZE;
begin
  with TWMNCCALCSIZE(Message).CalcSize_Params^.rgrc[0] do
  begin
    if Buttons[0].Visible then Inc(Left, StdRibbonScrollButtonSize);
    if Buttons[1].Visible then Dec(Right, StdRibbonScrollButtonSize);
  end;
end;

procedure TbsRibbonCustomPage.WMNCPaint;
var
  Cnvs: TCanvas;
  DC: HDC;
begin
  if FCanScroll then
  if Buttons[0].Visible or Buttons[1].Visible
  then
    begin
      DC := GetWindowDC(Handle);
      Cnvs := TCanvas.Create;
      Cnvs.Handle := DC;
      if Buttons[0].Visible then DrawButton(Cnvs, 0);
      if Buttons[1].Visible then DrawButton(Cnvs, 1);
      Cnvs.Handle := 0;
      ReleaseDC(Handle, DC);
      Cnvs.Free;
    end;
end;

procedure TbsRibbonCustomPage.WMSIZE;
begin
  inherited;
  if FCanScroll and Buttons[0].Visible
  then
    begin
      Buttons[0].R := Rect(0, 0, StdRibbonScrollButtonSize, Height);
      Buttons[1].R := Rect(Width - StdRibbonScrollButtonSize, 0, Width, Height);
      SendMessage(Handle, WM_NCPAINT, 0, 0);
    end;
end;

procedure TbsRibbonCustomPage.SetScrollTimerInterval;
begin
  if Value > 0 then FScrollTimerInterval := Value;
end;

procedure TbsRibbonCustomPage.DrawButton;
var
  B: TBitMap;
  R, NewCLRect: TRect;
  FSkinPicture: TBitMap;
  NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  XO, YO, CIndex: Integer;
  C: TColor;
  ButtonData: TbsDataSkinButtonControl;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(Buttons[i].R);
  B.Height := RectHeight(Buttons[i].R);
  R := Rect(0, 0, B.Width, B.Height);
  //
  if (Ribbon <> nil) and (Ribbon.FIndex <> -1)
  then
    CIndex := Ribbon.FSD.GetControlIndex('resizetoolbutton')
  else
    CIndex := -1;
  if CIndex = -1
  then
    begin
      ButtonData := nil;
      FSkinPicture := nil;
    end  
  else
    begin
      ButtonData := TbsDataSkinButtonControl(Ribbon.FSD.CtrlList[CIndex]);
      FSkinPicture := TBitMap(Ribbon.FSD.FActivePictures.Items[ButtonData.PictureIndex]);
    end;
  if (ButtonData = nil) or (FSkinPicture = nil)
  then
    begin
      C := clBtnText;
      if ((Buttons[I].Down and Buttons[I].MouseIn)) or
          (Buttons[I].MouseIn and HotScroll)
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          B.Canvas.FillRect(R);
        end
      else
      if Buttons[I].MouseIn
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          B.Canvas.FillRect(R);
        end
      else
        begin
          Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
          B.Canvas.Brush.Color := clBtnFace;
          B.Canvas.FillRect(R);
        end;
    end
  else
    with ButtonData, Buttons[I] do
    begin
      //
      XO := RectWidth(R) - RectWidth(SkinRect);
      YO := RectHeight(R) - RectHeight(SkinRect);
      NewLTPoint := LTPoint;
      NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
      NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
      NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
      NewClRect := Rect(CLRect.Left, ClRect.Top,
        CLRect.Right + XO, ClRect.Bottom + YO);
      //
      if (Down and not IsNullRect(DownSkinRect) and MouseIn) or
         (MouseIn and HotScroll and not IsNullRect(DownSkinRect))
      then
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, DownSkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect, StretchType);
          C := DownFontColor;
        end
      else
      if MouseIn and not IsNullRect(ActiveSkinRect)
      then
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, ActiveSkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect, StretchType);
          C := ActiveFontColor;
        end
      else
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, SkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect, StretchType);
          C := FontColor;
        end;
   end;
  //
  case I of
    0: DrawArrowImage(B.Canvas, R, C, 1);
    1: DrawArrowImage(B.Canvas, R, C, 2);
  end;
  //
  Cnvs.Draw(Buttons[I].R.Left, Buttons[I].R.Top, B);
  B.Free;
end;

constructor TbsAppButton.Create(AOwner: TComponent);
begin
  inherited;
  Ribbon := nil;
end;

procedure TbsAppButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
   if (Ribbon <> nil) and (Ribbon.AppMenu <> nil) and (Ribbon.AppMenu.Visible) and
      (Button = mbLeft)
  then
    begin
      Ribbon.HideAppMenu(nil);
    end
  else
  inherited;
end;

function TbsAppButton.CanMenuTrack;
begin
  if (Ribbon <> nil) and (Ribbon.AppMenu <> nil)
  then
    Result := True
  else
    Result := inherited CanMenuTrack(X, Y);
end;


procedure TbsAppButton.TrackMenu;
begin
  if (Ribbon <> nil) and (Ribbon.AppMenu <> nil)
  then
    begin
      FDownState := True;
      Ribbon.ShowAppMenu;
    end
  else
    inherited;
end;

procedure TbsAppButton.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
end;

procedure TbsAppButton.WMKeyUp(var Message: TWMKeyUp);
begin
  inherited;
  if TWMKeyUp(Message).CharCode = VK_RETURN
  then
    begin
      DropDown;
    end
end;

procedure TbsAppButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_DOWN) or (Key = VK_SPACE)
  then
    begin
      DropDown;
    end
  else
  if (Key = VK_LEFT) or (Key = VK_RIGHT) or (KEY = VK_UP)
  then
    if Ribbon <> nil then Ribbon.SetFocus;
end;


// Application Menu

constructor TbsAppMenuItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Active := False;
  FEnabled := True;
  FVisible := True;
  FPage := nil;
  FCaption := 'TbsAppMenuItem' + IntToStr(Index);
  FImageIndex := -1;
end;

destructor TbsAppMenuItem.Destroy;
begin
  inherited;
end;

procedure TbsAppMenuItem.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TbsAppMenuItem
  then
    begin
      FPage := TbsAppMenuItem(Source).Page;
      FCaption := TbsAppMenuItem(Source).Caption;
      FImageIndex := TbsAppMenuItem(Source).ImageIndex;
      FVisible := TbsAppMenuItem(Source).Visible;
      FEnabled := TbsAppMenuItem(Source).Enabled;
    end
end;

procedure TbsAppMenuItem.SetCaption(Value: String);
begin
  if FCaption <> Value
  then
    begin
      FCaption := Value;
      Changed(False);
    end;
end;

procedure TbsAppMenuItem.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value
  then
    begin
      FEnabled := Value;
      Changed(False);
    end;
end;


procedure TbsAppMenuItem.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value
  then
    begin
      FImageIndex := Value;
      Changed(False);
    end;
end;


procedure TbsAppMenuItem.SetVisible(Value: Boolean);
begin
  if FVisible <> Value
  then
    begin
      FVisible := Value;
      Changed(False);
    end;
end;


procedure TbsAppMenuItem.SetPage(const Value: TbsAppMenuPage);
begin
  if FPage <> Value then
  begin
    FPage := Value;
    if (FPage <> nil) and (FPage.AppMenu <> nil) then
      FPage.AppMenu.ActivePage := FPage;
  end;
end;

constructor TbsAppMenuItems.Create;
begin
  inherited Create(TbsAppMenuItem);
  AppMenu := AAppMenu;
  DestroyPage := nil;
end;

function TbsAppMenuItems.GetOwner: TPersistent;
begin
  Result := AppMenu;
end;

procedure TbsAppMenuItems.Update(Item: TCollectionItem);
begin
  inherited;
  if (csDesigning in AppMenu.ComponentState) or AppMenu.Visible
  then
    AppMenu.UpdateScrollInfo;
  AppMenu.Invalidate;
end;

function TbsAppMenuItems.GetItem(Index: Integer):  TbsAppMenuItem;
begin
  Result := TbsAppMenuItem(inherited GetItem(Index));
end;

procedure TbsAppMenuItems.SetItem(Index: Integer; Value:  TbsAppMenuItem);
begin
  inherited SetItem(Index, Value);
end;

constructor TbsAppMenuPage.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible];
  FDefaultWidth := 0;
  FFirstActiveControl := nil;
end;

procedure  TbsAppMenuPage.Notification(AComponent: TComponent;
      Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FFirstActiveControl)
  then
    FFirstActiveControl := nil;
end;

procedure TbsAppMenuPage.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
    with Params.WindowClass do
      Style := Style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TbsAppMenuPage.SetDefaultWidth;
begin
  if FDefaultWidth <> Value
  then
    begin
      FDefaultWidth := Value;
      Width := Value;
    end;   
end;

destructor TbsAppMenuPage.Destroy;
var
  i: Integer;
begin
  if (AppMenu <> nil) and (csDesigning in  AppMenu.ComponentState) and
     not (csLoading in AppMenu.ComponentState) and not
     (csDestroying in AppMenu.ComponentState)
  then
    begin
      i := AppMenu.GetPageIndex(Self);
      AppMenu.Items[i].FPage := nil;
      AppMenu.Invalidate;
    end;
  inherited;
end;

procedure TbsAppMenuPage.WMSIZE(var Message: TWMSIZE);
begin
  inherited;
  Invalidate;
end;

procedure TbsAppMenuPage.PaintBG;
var
  C: TCanvas;
  FData: TbsDataSkinAppMenu;
  Buffer2, PageBG, FDataPicture: TBitMap;
  XCnt, YCnt, X, Y, w, h, w1, h1: Integer;
begin
  C := TCanvas.Create;
  C.Handle := DC;
  if AppMenu <> nil
  then
    begin
      AppMenu.GetSkinData;
      FData := AppMenu.FData;
      FDataPicture := AppMenu.FDataPicture;
    end
  else
    begin
      FData := nil;
      FDataPicture := nil;
    end;  
  if FData <> nil
  then
    with FData do
    begin
      w1 := Width;
      h1 := Height;

      PageBG := TBitMap.Create;
      PageBG.Width := RectWidth(ClRect);
      PageBG.Height := RectHeight(ClRect);
      PageBG.Canvas.CopyRect(Rect(0, 0, PageBG.Width, PageBG.Height),
         FDataPicture.Canvas,
          Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
               SkinRect.Left + ClRect.Right,
               SkinRect.Top + ClRect.Bottom));

     if StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case StretchType of
            bsstFull:
              begin
                C.StretchDraw(Rect(0, 0, Width, Height), PageBG);
              end;
            bsstVert:
              begin
                Buffer2 := TBitMap.Create;
                Buffer2.Width := Width;
                Buffer2.Height := PageBG.Height;
                Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), PageBG);
                YCnt := Height div Buffer2.Height;
                for Y := 0 to YCnt do
                  C.Draw(0, Y * Buffer2.Height, Buffer2);
                Buffer2.Free;
              end;
           bsstHorz:
             begin
               Buffer2 := TBitMap.Create;
               Buffer2.Width := PageBG.Width;
               Buffer2.Height := Height;
               Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), PageBG);
               XCnt := Width div Buffer2.Width;
               for X := 0 to XCnt do
                 C.Draw(X * Buffer2.Width, 0, Buffer2);
               Buffer2.Free;
             end;
          end;
        end
      else
        begin
          w := RectWidth(ClRect);
          h := RectHeight(ClRect);
          XCnt := w1 div w;
          YCnt := h1 div h;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          C.Draw(X * w, Y * h, PageBG);
        end;

      PageBG.Free;

    end
  else
    begin
      with C do
      begin
        Brush.Color := clWindow;
        FillRect(Rect(0, 0, Width, Height));
      end;
    end;
  C.Free;
end;

procedure TbsAppMenuPage.Paint;
begin

end;

procedure TbsAppMenuPage.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  R: TRect;
begin
  if (Parent <> nil) and (AppMenu <> nil)
  then
    begin
      R := AppMenu.GetPageBoundsRect;
      if AWidth > R.Right
      then
        AWidth := R.Right
      else
      if FDefaultWidth = 0
      then
         AWidth := R.Right
       else
      if (FDefaultWidth > 0) and (FDefaultWidth > R.Right)
      then
         AWidth := R.Right
       else
        AWidth := FDefaultWidth;
      //
      if AWidth < 100 then AWidth := 100;
      if R.Bottom < 100 then R.Bottom := 100;
      inherited SetBounds(R.Left, R.Top, AWidth, R.Bottom);
    end
  else
    inherited;
end;

procedure TbsAppMenuPage.WMEraseBkgnd;
begin
  if Msg.DC <> 0 then PaintBG(Msg.DC);
end;


// =============================================================================
constructor TbsAppMenuCustomPage.Create;
begin
  inherited;
  FMouseIn := False;
  FStopScroll := True;
  AppMenu := nil;
  PanelData := nil;
  ButtonData := nil;
  FCanScroll := False;
  FHotScroll := False;
  TimerMode := 0;
  FScrollOffset := 0;
  FScrollTimerInterval := 50;
  Width := 150;
  Height := 30;
  Buttons[0].Visible := False;
  Buttons[1].Visible := False;
  FVSizeOffset := 0;
  SMax := 0;
  SPosition := 0;
  SOldPosition := 0;
  SPage := 0;
end;

function TbsAppMenuCustomPage.CheckActivation;
begin
  Result := FCanScroll and (Buttons[0].Visible or Buttons[1].Visible);
end;

procedure TbsAppMenuCustomPage.CMSENCPaint(var Message: TMessage);
var
  C: TCanvas;
begin
  if (Message.wParam <> 0) and (Buttons[0].Visible or Buttons[1].Visible)
  then
    begin
      C := TControlCanvas.Create;
      C.Handle := Message.wParam;
      if Buttons[0].Visible then DrawButton(C, 0);
      if Buttons[1].Visible then DrawButton(C, 1);
      C.Handle := 0;
      C.Free;
      Message.Result := SE_RESULT;
    end
  else
    Message.Result := 0;
end;

procedure TbsAppMenuCustomPage.CMBENCPAINT;
var
  C: TCanvas;
begin
  if (Message.LParam = BE_ID)
  then
    begin
      if (Message.wParam <> 0) and (Buttons[0].Visible or Buttons[1].Visible)
      then
        begin
          C := TControlCanvas.Create;
          C.Handle := Message.wParam;
          if Buttons[0].Visible then DrawButton(C, 0);
          if Buttons[1].Visible then DrawButton(C, 1);
          C.Handle := 0;
          C.Free;
        end;
      Message.Result := BE_ID;
    end
  else
    inherited;
end;

procedure TbsAppMenuCustomPage.WMDESTROY(var Message: TMessage);
begin
  KillTimer(Handle, 1);
  KillTimer(Handle, 2);
  FMouseIn := False;
  inherited;
end;

procedure TbsAppMenuCustomPage.WMSETCURSOR(var Message: TWMSetCursor);
begin
  if FCanScroll
  then
    if (Message.HitTest = HTBUTTON1) or
       (Message.HitTest = HTBUTTON2)
    then
      begin
        Message.HitTest :=  HTCLIENT;
      end;
  inherited;
end;

procedure TbsAppMenuCustomPage.SetPosition(const Value: integer);
begin
  if Value <> SPosition
  then
    begin
      SPosition := Value;
      GetScrollInfo;
    end;
end;

destructor TbsAppMenuCustomPage.Destroy;
begin
  inherited;
end;

procedure TbsAppMenuCustomPage.UpDateSize;
begin
  SetBounds(Left, Top, Width, Height);
end;

procedure TbsAppMenuCustomPage.StartTimer;
begin
  KillTimer(Handle, 1);
  SetTimer(Handle, 1, Self.ScrollTimerInterval, nil);
end;

procedure TbsAppMenuCustomPage.StopTimer;
begin
  KillTimer(Handle, 1);
  TimerMode := 0;
end;

procedure TbsAppMenuCustomPage.WMTimer;
var
  P: TPoint;
begin
  inherited;

  if Message.TimerID = 1
  then
    begin
      case TimerMode of
        1: ButtonClick(0);
        2: ButtonClick(1);
      end;
    end;

  if Message.TimerID = 2
  then
    begin
      GetCursorPos(P);
      if WindowFromPoint(P) <> Handle
      then
        begin
          KillTimer(Handle, 2);
          CMMouseLeave;
        end;
   end;

end;

procedure TbsAppMenuCustomPage.AdjustClientRect(var Rect: TRect);
var
  RLeft, RTop, VMax, HMax: Integer;
begin
  if FCanScroll
  then
    begin
      RLeft := 0;
      RTop := - SPosition;
      VMax := Max(SMax, ClientHeight);
      HMax := ClientWidth;
      Rect := Bounds(RLeft, RTop,  HMax, VMax);
    end;
  inherited AdjustClientRect(Rect);
end;

procedure TbsAppMenuCustomPage.VScrollControls(AOffset: Integer);
begin
  ScrollBy(0, -AOffset);
end;

procedure TbsAppMenuCustomPage.SetBounds;
var
  OldHeight: Integer;
begin
  OldHeight := Height;
  inherited;
   if (OldHeight <> Height)
  then
    begin
      if (OldHeight < Height) and (OldHeight <> 0)
      then FVSizeOffset := Height - OldHeight
      else FVSizeOffset := 0;
    end
  else
    FVSizeOffset := 0;

  if FCanScroll then GetScrollInfo;
end;

procedure TbsAppMenuCustomPage.GetVRange;
var
  i, MaxBottom, H: Integer;
  FMax: Integer;
begin
  MaxBottom := 0;
  if ControlCount > 0
  then
    for i := 0 to ControlCount - 1 do
    with Controls[i] do
    begin
      if Visible
      then
        if Top + Height > MaxBottom then MaxBottom := Top + Height;
    end;
  if MaxBottom = 0
  then
    begin
      if Buttons[1].Visible then SetButtonsVisible(False);
      Exit;
    end;
  H := ClientHeight;
  FMax := MaxBottom + SPosition;
  if FMax > H
  then
    begin
      if not Buttons[1].Visible then SetButtonsVisible(True);

      if (SPosition > 0) and (MaxBottom < H) and (FVSizeOffset > 0)
      then
        begin
          if FVSizeOffset > SPosition then FVSizeOffset := SPosition;
          SMax := FMax - 1;
          SPosition := SPosition - FVSizeOffset;
          SPage := H;
          VScrollControls(- FVSizeOffset);
          FVSizeOffset := 0;
          SOldPosition := SPosition;
        end
      else
        begin
          if (FVSizeOffset = 0) and ((FMax - 1) < SMax) and (SPosition > 0) and
             (MaxBottom < H)
            then
              begin
                SMax := FMax - 1;
                SPosition := SPosition - (H - MaxBottom);
                SPage := H;
                VScrollControls(MaxBottom - H);
                FVSizeOffset := 0;
                SOldPosition := SPosition;
              end
            else
              begin
                SMax := FMax - 1;
                SPage := H;
              end;
          FVSizeOffset := 0;
          SOldPosition := SPosition;
        end;
    end
   else
     begin
       if SPosition > 0 then VScrollControls(-SPosition);
       FVSizeOffset := 0;
       SOldPosition := 0;
       SMax := 0;
       SPage := 0;
       SPosition := 0;
       if Buttons[1].Visible then SetButtonsVisible(False);
     end;
end;

procedure TbsAppMenuCustomPage.GetScrollInfo;
begin
  if FStopScroll then Exit;
  if FCanScroll then GetVRange;
end;

procedure TbsAppMenuCustomPage.SetButtonsVisible;
var
  F: TCustomForm;
  C: TWinControl;
begin
  if Buttons[0].Visible <> AVisible
  then
    begin
      Buttons[0].Visible := AVisible;
      Buttons[1].Visible := AVisible;
      if not (Parent is TbsSkinCoolBar)
      then
        begin
          //
          C := nil;
          F := GetParentForm(Self);
          if F <> nil then C := F.ActiveControl;
          if (C <> nil) and C.Focused and (C.Parent <> nil)
          then
            begin
              if not ((C.Parent = Self) or (C.Parent.Parent = Self))
              then
                C := nil;
            end
          else
            C := nil;
          //
          FMouseIn := False;
          ReCreateWnd;
          HandleNeeded;
          //
          if (C <> nil) and C.Visible and not C.Focused and C.CanFocus then C.SetFocus;
          //
        end;
    end;
end;

procedure TbsAppMenuCustomPage.ButtonDown(I: Integer);
begin
  case I of
    0:
      begin
        TimerMode := 1;
        StartTimer;
      end;
    1:
      begin
        TimerMode := 2;
        StartTimer;
      end;
  end;
end;

procedure TbsAppMenuCustomPage.ButtonUp(I: Integer);
begin
  case I of
    0:
      begin
        StopTimer;
        TimerMode := 0;
        ButtonClick(0);
      end;
    1:
      begin
        StopTimer;
        TimerMode := 0;
        ButtonClick(1);
      end;
  end;
end;

procedure TbsAppMenuCustomPage.ButtonClick;
var
  SOffset: Integer;
begin
  if FScrollOffset = 0
  then
    SOffset := ClientWidth
  else
    SOffset := FScrollOffset;

  case I of
    0:
        begin
          SPosition := SPosition - SOffset;
          if SPosition < 0 then SPosition := 0;
          if (SPosition - SOldPosition <> 0)
          then
            begin
              VScrollControls(SPosition - SOldPosition);
              GetVRange;
            end
          else
            StopTimer;
        end;

    1:
        begin
          SPosition := SPosition + SOffset;
          if SPosition > SMax - SPage + 1 then SPosition := SMax - SPage + 1;
          if (SPosition - SOldPosition <> 0)
          then
            begin
              VScrollControls(SPosition - SOldPosition);
              GetVRange;
            end
          else
            StopTimer;
        end;
   end;
end;

procedure TbsAppMenuCustomPage.CMMouseEnter;
begin
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := True;
  if CheckActivation
  then
    begin
      KillTimer(Handle, 2);
      SetTimer(Handle, 2, 100, nil);
    end;
end;

procedure TbsAppMenuCustomPage.CMMOUSELEAVE;
var
  P: TPoint;
begin
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := False;
  if  FCanScroll then begin
  GetCursorPos(P);
  if WindowFromPoint(P) <> Handle
  then
    if Buttons[0].MouseIn and Buttons[0].Visible
    then
      begin
        if TimerMode <> 0 then StopTimer;
        Buttons[0].MouseIn := False;
        SendMessage(Handle, WM_NCPAINT, 0, 0);
      end
    else
      if Buttons[1].MouseIn and Buttons[1].Visible
      then
        begin
          if TimerMode <> 0 then StopTimer;
          Buttons[1].MouseIn := False;
          SendMessage(Handle, WM_NCPAINT, 0, 0);
        end;
   end;
end;

procedure TbsAppMenuCustomPage.WndProc;
var
  B: Boolean;
  P: TPoint;
begin
  B := True;

  if FCanScroll then
  
  case Message.Msg of
   WM_WINDOWPOSCHANGING:
      if Self.HandleAllocated and (Align = alNone)
      then
        GetScrollInfo;

    WM_NCHITTEST:
      if not (csDesigning in ComponentState) then
      begin
        //
        if not FMouseIn then CMMouseEnter;
        //
        P.X := LoWord(Message.lParam);
        P.Y := HiWord(Message.lParam);
        P := ScreenToClient(P);
        if (P.Y < 0) and Buttons[0].Visible
        then
          begin
            Message.Result := HTBUTTON1;
            B := False;
          end
        else
        if (P.Y > ClientHeight) and Buttons[1].Visible
        then
          begin
            Message.Result := HTBUTTON2;
            B := False;
          end;
      end;

    WM_NCLBUTTONDOWN, WM_NCLBUTTONDBLCLK:
       begin
         if Message.wParam = HTBUTTON1
         then
           begin
             Buttons[0].Down := True;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonDown(0);
           end
         else
         if Message.wParam = HTBUTTON2
         then
           begin
             Buttons[1].Down := True;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonDown(1);
           end;

       end;

    WM_NCLBUTTONUP:
       begin
         if Message.wParam = HTBUTTON1
         then
           begin
             Buttons[0].Down := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonUp(0);
           end
         else
         if Message.wParam = HTBUTTON2
         then
           begin
             Buttons[1].Down := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             ButtonUp(1);
           end;
       end;

     WM_NCMOUSEMOVE:
       begin
         if (Message.wParam = HTBUTTON1) and (not Buttons[0].MouseIn)
         then
           begin
             Buttons[0].MouseIn := True;
             Buttons[1].MouseIn := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             if FHotScroll
             then
               begin
                 TimerMode := 1;
                 StartTimer;
               end;
           end
         else
         if (Message.wParam = HTBUTTON2) and (not Buttons[1].MouseIn)
         then
           begin
             Buttons[1].MouseIn := True;
             Buttons[0].MouseIn := False;
             SendMessage(Handle, WM_NCPAINT, 0, 0);
             if FHotScroll
             then
               begin
                 TimerMode := 2;
                 StartTimer;
               end;
           end;
       end;

    WM_MOUSEMOVE:
      begin
        if Buttons[0].MouseIn and Buttons[0].Visible
        then
          begin
            if TimerMode <> 0 then StopTimer;
            Buttons[0].MouseIn := False;
            SendMessage(Handle, WM_NCPAINT, 0, 0);
          end
        else
        if Buttons[1].MouseIn and Buttons[1].Visible
        then
          begin
            if TimerMode <> 0 then StopTimer;
            Buttons[1].MouseIn := False;
            SendMessage(Handle, WM_NCPAINT, 0, 0);
          end;
      end;
  end;

  if B then inherited;
end;

procedure TbsAppMenuCustomPage.Paint;
begin
end;

procedure TbsAppMenuCustomPage.SetScrollOffset;
begin
  if Value >= 0 then FScrollOffset := Value;
end;

procedure TbsAppMenuCustomPage.WMNCCALCSIZE;
begin
  with TWMNCCALCSIZE(Message).CalcSize_Params^.rgrc[0] do
  begin
    if Buttons[0].Visible then Inc(Top, StdAppMenuScrollButtonSize);
    if Buttons[1].Visible then Dec(Bottom, StdAppMenuScrollButtonSize);
  end;
end;

procedure TbsAppMenuCustomPage.WMNCPaint;
var
  Cnvs: TCanvas;
  DC: HDC;
begin
  if FCanScroll then
  if Buttons[0].Visible or Buttons[1].Visible
  then
    begin
      DC := GetWindowDC(Handle);
      Cnvs := TCanvas.Create;
      Cnvs.Handle := DC;
      if Buttons[0].Visible then DrawButton(Cnvs, 0);
      if Buttons[1].Visible then DrawButton(Cnvs, 1);
      Cnvs.Handle := 0;
      ReleaseDC(Handle, DC);
      Cnvs.Free;
    end;
end;

procedure TbsAppMenuCustomPage.WMSIZE;
begin
  inherited;
  if AppMenu = nil then Exit;
  if FCanScroll and Buttons[0].Visible
  then
    begin
      Buttons[0].R := Rect(0, 0, Width, StdAppMenuScrollButtonSize);
      Buttons[1].R := Rect(0, Height - StdAppMenuScrollButtonSize, Width, Height);
      SendMessage(Handle, WM_NCPAINT, 0, 0);
    end;
end;

procedure TbsAppMenuCustomPage.SetScrollTimerInterval;
begin
  if Value > 0 then FScrollTimerInterval := Value;
end;

procedure TbsAppMenuCustomPage.DrawButton;
var
  B: TBitMap;
  R, NewCLRect: TRect;
  FSkinPicture: TBitMap;
  NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  XO, YO, CIndex: Integer;
  C: TColor;
  ButtonData: TbsDataSkinButtonControl;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(Buttons[i].R);
  B.Height := RectHeight(Buttons[i].R);
  R := Rect(0, 0, B.Width, B.Height);
  //
  if (AppMenu <> nil) and (AppMenu.FIndex <> -1)
  then
    CIndex := AppMenu.FSD.GetControlIndex('resizetoolbutton')
  else
    CIndex := -1;
  if CIndex = -1
  then
    begin
      ButtonData := nil;
      FSkinPicture := nil;
    end
  else
    begin
      ButtonData := TbsDataSkinButtonControl(AppMenu.FSD.CtrlList[CIndex]);
      FSkinPicture := TBitMap(AppMenu.FSD.FActivePictures.Items[ButtonData.PictureIndex]);
    end;
  if (ButtonData = nil) or (FSkinPicture = nil)
  then
    begin
      C := clBtnText;
      if ((Buttons[I].Down and Buttons[I].MouseIn)) or
          (Buttons[I].MouseIn and HotScroll)
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          B.Canvas.FillRect(R);
        end
      else
      if Buttons[I].MouseIn
      then
        begin
          Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          B.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          B.Canvas.FillRect(R);
        end
      else
        begin
          Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
          B.Canvas.Brush.Color := clBtnFace;
          B.Canvas.FillRect(R);
        end;
    end
  else
    with ButtonData, Buttons[I] do
    begin
      //
      XO := RectWidth(R) - RectWidth(SkinRect);
      YO := RectHeight(R) - RectHeight(SkinRect);
      NewLTPoint := LTPoint;
      NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
      NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
      NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
      NewClRect := Rect(CLRect.Left, ClRect.Top,
        CLRect.Right + XO, ClRect.Bottom + YO);
      //
      if (Down and not IsNullRect(DownSkinRect) and MouseIn) or
         (MouseIn and HotScroll and not IsNullRect(DownSkinRect))
      then
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, DownSkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect, StretchType);
          C := DownFontColor;
        end
      else
      if MouseIn and not IsNullRect(ActiveSkinRect)
      then
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, ActiveSkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect, StretchType);
          C := ActiveFontColor;
        end
      else
        begin
          CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          B, FSkinPicture, SkinRect, B.Width, B.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect, StretchType);
          C := FontColor;
        end;
   end;
  //
  case I of
    0: DrawArrowImage(B.Canvas, R, C, 3);
    1: DrawArrowImage(B.Canvas, R, C, 4);
  end;
  //
  Cnvs.Draw(Buttons[I].R.Left, Buttons[I].R.Top, B);
  B.Free;
end;

// Application Menu

constructor TbsAppMenu.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible];
  FStopCheckItemIndex := False;
  FMouseIn := False;
  ScrollBar := nil;
  FScrollOffset := 0;
  Ribbon := nil;
  FData := nil;
  FUseSkinFont := True;
  //
  FItemIndex := -1;
  FLeftOffset := 6;
  FRightOffset := 5;
  FItems := TbsAppMenuItems.Create(Self);
  FItemWidth := StdAppMenuItemWidth;
  Width := 250;
  Height := 200;
  Align := alNone;
  FSkinDataName := 'appmenu';
  FOldItemActive := -1;
  FItemActive := -1;
  FSkinHint := nil;
  FOldHeight := -1;
end;

destructor TbsAppMenu.Destroy;
begin
  FItems.Free;
  if ScrollBar <> nil then ScrollBar.Free;
  inherited;
end;

procedure TbsAppMenu.ShowScrollbar;
begin
  if ScrollBar = nil
  then
    begin
      ScrollBar := TbsSkinScrollBar.Create(Self);
      ScrollBar.Visible := False;
      ScrollBar.Parent := Self;
      ScrollBar.DefaultHeight := 0;
      ScrollBar.DefaultWidth := 19;
      ScrollBar.SmallChange := StdAppMenuItemHeightSmall;
      ScrollBar.LargeChange := StdAppMenuItemHeightSmall;
      ScrollBar.SkinDataName := 'vscrollbar';
      ScrollBar.Kind := sbVertical;
      ScrollBar.SkinData := Self.SkinData;
      ScrollBar.OnChange := SBChange;
      AdjustScrollBar;
      ScrollBar.Visible := True;
      RePaint;
    end;
end;

procedure TbsAppMenu.ScrollToItem(Index: Integer);
var
  R: TRect;
  VOff: Integer;
begin
  if Index = -1 then Exit;
  R := Items[Index].ItemRect;
  if R.Top < 0
  then
    VOff := R.Top - FScrollOffset
  else
    VOff := R.Bottom - FScrollOffset;
  //
  if (ScrollBar <> nil) and (ScrollBar.Visible) and
     ((R.Top < 0) or (R.Bottom > Self.Height))
  then
    begin
      if Index = Items.Count -1
      then
        ScrollBar.Position := ScrollBar.Max
      else
        ScrollBar.Position := ScrollBar.Position + VOff;
    end
  else
  if (ScrollBar <> nil) and (ScrollBar.Visible) and
     (Index = Items.Count -1) and (ScrollBar.Position <> ScrollBar.Max)
  then
    begin
      ScrollBar.Position := ScrollBar.Max;
    end
  else
  if (ScrollBar <> nil) and (ScrollBar.Visible) and
     (Index = 0) and (ScrollBar.Position <> ScrollBar.Min)
  then
    begin
      ScrollBar.Position := ScrollBar.Min;
    end;

  if Items[Index].Page <> nil
  then
    begin
      R := Items[Index].ItemRect;
      if R.Top < 30
      then
        begin
          VOff := 30 - R.Top;
          ScrollBar.Position := ScrollBar.Position - VOff;
        end
      else
      if R.Bottom > Height - 30
      then
        begin
          VOff := R.Bottom - (Height - 30);
          ScrollBar.Position := ScrollBar.Position + VOff;
        end;
    end;
end;

procedure TbsAppMenu.Scroll(AScrollOffset: Integer);
begin
  FScrollOffset := AScrollOffset;
  RePaint;
end;

procedure TbsAppMenu.SBChange(Sender: TObject);
begin
  Scroll(ScrollBar.Position);
end;

procedure TbsAppMenu.HideScrollBar;
begin
  if ScrollBar = nil then Exit;
  ScrollBar.Visible := False;
  ScrollBar.Free;
  ScrollBar := nil;
  RePaint;
end;

procedure TbsAppMenu.AdjustScrollBar;
var
  R: TRect;
begin
  if ScrollBar = nil then Exit;
  R := Rect(0, 0, Width, Height);
  if CanShowGripper then Dec(R.Bottom, 20);
  Dec(R.Right, ScrollBar.Width);
  ScrollBar.SetBounds(R.Right, R.Top, ScrollBar.Width, RectHeight(R));
end;

function TbsAppMenu.CanShowGripper;
var
  FBSF: TbsBusinessSkinForm;
begin
  Result := False;
  if (Ribbon <> nil) and (Ribbon.BSF <> nil)
  then
    FBSF := TbsBusinessSkinForm(Ribbon.BSF)
  else
    FBSF := nil;
  if FBSF <> nil then
  Result := (FBSF.WindowState <> wsMaximized) and (FBSF.FForm.BorderStyle <> bsSingle) and
   not FBSF.RollUpState;
end;


function TbsAppMenu.GetGripRect: TRect;
begin
  Result := Rect(Width - 10, Height - 10, Width, Height);
end;

procedure TbsAppMenu.WMNCHitTest(var Message: TWMNCHitTest); 
var
  R: TRect;
  P: TPoint;
begin
  R := GetGripRect;
  P := ScreenToClient(SmallPointToPoint(TWMNCHitTest(Message).Pos));
  if PointInRect(R, P) and CanShowGripper
  then
    Message.Result := HTBOTTOMRIGHT
  else
    inherited;  
end;

procedure TbsAppMenu.SetItemImageList(Value: TCustomImageList);
begin
  FItemImageList := Value;
  Invalidate;
end;

procedure TbsAppMenu.SetItemPageImageList(Value: TCustomImageList);
begin
  FItemPageImageList := Value;
  Invalidate;
end;

procedure TbsAppMenu.SetItemWidth;
begin
  FItemWidth := Value;
  if FItemWidth < StdAppMenuItemWidth
  then
    FItemWidth := StdAppMenuItemWidth;
  if ActivePage <> nil
  then
    begin
      ActivePage.SetBounds(ActivePage.Left, ActivePage.Top,
        ActivePage.Width, ActivePage.Height);
    end;
  Invalidate;
end;

procedure TbsAppMenu.SetItemIndex;
begin
  FItemIndex := Value;
  if (ItemIndex >= 0) and (FItemIndex < Items.Count)
  then
    begin
      if (Items[FItemIndex].Page <> nil) and (ActivePage <> Items[FItemIndex].Page)
      then
        ActivePage := Items[FItemIndex].Page;
    end;
  if ScrollBar <> nil then ScrollToItem(FItemIndex);
  Invalidate;
end;

function TbsAppMenu.ItemFromPoint;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Items.Count -1 do
    if Items[i].Visible and PtInRect(Items[i].ItemRect, P)
    then
      begin
        Result := i;
        Break;
      end;
end;

procedure TbsAppMenu.CMDesignHitTest;
var
  P: TPoint;
  I: Integer;
begin
  inherited;
  P := SmallPointToPoint(Message.Pos);
  if (Message.Keys = MK_LBUTTON) and (ItemFromPoint(P) <> -1)
  then
    begin
      I := ItemFromPoint(P);
      if Items[I].Page <> nil then ActivePage := Items[I].Page;
      GetParentForm(Self).Designer.Modified;
    end;
end;


procedure TbsAppMenu.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
    with Params.WindowClass do
      Style := Style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TbsAppMenu.Notification(AComponent: TComponent;
      Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FSkinHint)
  then
    begin
      FSkinHint := nil;
    end;
  if (Operation = opRemove) and (AComponent = FActivePage)
  then
    begin
      FActivePage := nil;
    end;
  if (Operation = opRemove) and (AComponent = FItemImageList)
  then
    begin
      FItemImageList := nil;
    end;
   if (Operation = opRemove) and (AComponent = FItemPageImageList)
  then
    begin
      FItemPageImageList := nil;
    end;
end;

procedure TbsAppMenu.SetSkinData(Value: TbsSkinData); 
begin
  inherited;
end;

procedure TbsAppMenu.ChangeSkinData;
begin
  inherited;
end;

procedure TbsAppMenu.FindNextItem;
var
  i, j, k: Integer;
begin
  j := ItemIndex;
  if (j = -1) or (j = Items.Count - 1) then Exit;
  k := -1;
  for i := j + 1 to Items.Count - 1 do
  begin
    if Items[i].Visible and Items[i].Enabled
    then
      begin
        k := i;
        Break;
      end;
  end;
  if k <> -1 then ItemIndex := k;
end;

procedure TbsAppMenu.FindPriorItem;
var
  i, j, k: Integer;
begin
  j := ItemIndex;
  if (j = -1) or (j = 0) then Exit;
  k := -1;
  for i := j - 1 downto 0 do
  begin
    if Items[i].Visible and Items[i].Enabled
    then
      begin
        k := i;
        Break;
      end;
  end;
  if k <> -1 then ItemIndex := k;
end;

procedure TbsAppMenu.FindFirstItem;
var
  i, k: Integer;
begin
  k := -1;
  for i := 0 to Items.Count - 1 do
  begin
    if Items[i].Visible and Items[i].Enabled
    then
      begin
        k := i;
        Break;
      end;
  end;
  if k <> -1 then ItemIndex := k;
end;

procedure TbsAppMenu.FindLastItem;
var
  i, k: Integer;
begin
  k := -1;
  for i := Items.Count - 1 downto 0 do
  begin
    if Items[i].Visible and Items[i].Enabled
    then
      begin
        k := i;
        Break;
      end;
  end;
  if k <> -1 then ItemIndex := k;
end;

procedure TbsAppMenu.WMMOUSEWHEEL(var Message: TWMMOUSEWHEEL);
var
  WH: HWND;
  P: TPoint;
begin
  if Focused
  then
    begin
      P := Point(Message.XPos, Message.YPos);
      WH := WindowFromPoint(P);
      if WH = Handle
      then
        if Message.WheelDelta < 0 then FindNextItem else FindPriorItem
      else
        begin
          if (ActivePage <> nil) and (ActivePage.FirstActiveControl <> nil) and
             (WH = ActivePage.FirstActiveControl.Handle) and
             (ActivePage.FirstActiveControl is TbsAppMenuPageListBox)
          then
            with TbsAppMenuPageListBox(ActivePage.FirstActiveControl) do
            begin
              if ScrollBar <> nil
              then
                if Message.WheelDelta < 0 then FindDown else FindUp;
            end;
        end;
    end;  
end;

procedure TbsAppMenu.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) or (Key = VK_SPACE) or (Key = VK_TAB)
  then
    begin
      if (ItemIndex <> -1) and (Items[ItemIndex].Page = nil) and (Ribbon <> nil)
      then
        begin
          if Key = VK_TAB
          then
            FindNextItem
          else
            Ribbon.HideAppMenu(Items[ItemIndex])
        end  
      else
      if (ItemIndex <> -1) and (Items[ItemIndex].Page <> nil)
      then
        begin
          if (Items[ItemIndex].Page.FirstActiveControl <> nil) and
             (Items[ItemIndex].Page.FirstActiveControl.Parent = Items[ItemIndex].Page) and
             (Items[ItemIndex].Page.FirstActiveControl.Visible) and
             (Items[ItemIndex].Page.FirstActiveControl.Enabled)
          then
            Items[ItemIndex].Page.FirstActiveControl.SetFocus
          else
          if Key = VK_TAB
          then
            FindNextItem;
        end;
    end
  else
  if (Key = VK_NEXT)
  then
    FindLastItem
  else
  if (Key = VK_PRIOR)
  then
   FindFirstItem
  else
  if (Key = VK_LEFT) or (Key = VK_UP)
  then
    FindPriorItem
  else
  if (Key = VK_RIGHT) or (Key = VK_DOWN)
  then
    FindNextItem;
end;

procedure TbsAppMenu.WMGetDlgCode;
begin
  Msg.Result := DLGC_WANTARROWS or DLGC_WANTTAB;
end;

procedure TbsAppMenu.WMSETFOCUS;
begin
  inherited;
  Invalidate;
end;

procedure TbsAppMenu.WMKILLFOCUS;
begin
  inherited;
  Invalidate;
end;

procedure TbsAppMenu.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TestActive(X, Y);
end;

procedure TbsAppMenu.MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer);
begin
  inherited;
  if Button <> mbLeft then Exit;
  TestActive(X, Y);
  if FItemActive <> ItemIndex then ItemIndex := FItemActive;
  if not Focused then SetFocus;
end;

procedure TbsAppMenu.MouseUp(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer);
begin
  inherited;
  if Button <> mbLeft then Exit;
  TestActive(X, Y);
  if (ItemIndex <> -1) and (Items[ItemIndex].Page = nil) and (Ribbon <> nil) and
     (ItemIndex = FItemActive)

  then
    begin
      Ribbon.HideAppMenu(Items[ItemIndex]);
    end;
end;

procedure TbsAppMenu.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  TestActive(-1, -1);
end;

procedure TbsAppMenu.TestActive(X, Y: Integer);
var
  i: Integer;
begin
  if Items.Count = 0 then Exit;
  FOldItemActive:= FItemActive;
  FItemActive := -1;
  for i := 0 to Items.Count - 1 do
  begin
    if Items[i].Visible and Items[i].Enabled and PtInRect(Items[i].ItemRect, Point(X, Y))
    then
      begin
        FItemActive := i;
        Break;
      end;
  end;
  if (FItemActive <> FOldItemActive)
  then
    begin
      if (FOldItemActive <> - 1)
      then
        Items[FOldItemActive].Active := False;
      if (FItemActive <> - 1)
      then
        Items[FItemActive].Active := True;
      Invalidate;
    end;
end;

procedure TbsAppMenu.GetScrollInfo(var AMin, AMax, APage: Integer);
var
  i: Integer;
  Y: Integer;
  First: Boolean;
  h1, h2: Integer;
  WasPage: Boolean;
begin
  // calc item areas height
  WasPage := False;
  if (FIndex <> -1) and (FData <> nil)
  then
    begin
      h1 := RectHeight(FData.PageItemRect);
      h2 := RectHeight(FData.ItemRect);
    end
  else
    begin
      h1 := StdAppMenuItemHeight;
      h2 := StdAppMenuItemHeightSmall;
    end;
  Y := 7;
  First := True;
  for i := 0 to Items.Count - 1 do
    if Items[i].Visible then
    begin
      if First
      then
        begin
          if Items[i].Page <> nil then Y := 30;
          First := False;
        end
      else
        if (Items[i].Page <> nil) and not WasPage
       then
          Y := Y + 8;
     if Items[i].Page <> nil
     then
       Y := Y + h1 + 8
     else
       Y := Y + h2;
    WasPage := Items[i].Page <> nil;
  end;
  //
  if (Items.Count <> 0) and (Items[Items.Count - 1].Page <> nil)
  then
    Y := Y + 25;
  //
  AMax := Y + 1;
  AMin := 0;
  APage := Height;
end;

procedure TbsAppMenu.CalcItemRects;
var
  i: Integer;
  X, Y: Integer;
  First: Boolean;
  h1, h2: Integer;
  WasPage: Boolean;
begin
  WasPage := False;

  if (FIndex <> -1) and (FData <> nil)
  then
    begin
      h1 := RectHeight(FData.PageItemRect);
      h2 := RectHeight(FData.ItemRect);
    end
  else
    begin
      h1 := StdAppMenuItemHeight;
      h2 := StdAppMenuItemHeightSmall;
    end;

  X := 0;
  Y := 7 - FScrollOffset;
  First := True;

  for i := 0 to Items.Count - 1 do
  if Items[i].Visible then
  begin
    if First
    then
      begin
        if (Items[i].Page <> nil) then Y := 30 - FScrollOffset;
        First := False;
      end
    else
      if (Items[i].Page <> nil) and not WasPage
      then
        Y := Y + 8;

    if Items[i].Page <> nil
    then
      begin
        Items[i].ItemRect := Rect(X, Y, X + FItemWidth, Y + h1);
        Y := Y + h1 + 8;
      end
    else
      begin
        Items[i].ItemRect := Rect(X + 8, Y, X + FItemWidth - 8, Y + h2);
        Y := Y + h2;
      end;
    WasPage := Items[i].Page <> nil;
  end;
end;  

procedure TbsAppMenu.GetSkinData;
begin
  inherited;
  if FIndex = -1
  then
    FData := nil
  else
    begin
      FData := TbsDataSkinAppMenu(FSD.CtrlList[FIndex]);
      FDataPicture := TBitMap(SkinData.FActivePictures.Items[FData.PictureIndex]);
      if FData.BGPictureIndex <> -1
      then
        FDataBGPicture := TBitMap(SkinData.FActivePictures.Items[FData.BGPictureIndex])
      else
        FDataBGPicture := nil;
    end;
end;

procedure TbsAppMenu.SetItems(AValue: TbsAppMenuItems);
begin
  FItems.Assign(AValue);
  Invalidate;
end;

procedure TbsAppMenu.SetActivePage(const Value: TbsAppMenuPage);
var
  OldActivePage: TbsAppMenuPage;
begin
  OldActivePage := FActivePage;
  FActivePage := Value;
  if OldActivePage <> nil
  then
    begin
      OldActivePage.Visible := False;
      OldActivePage.FStopScroll := True;
    end;  
  if (Value <> nil) and not (csLoading in ComponentState)
  then
    begin
      with FActivePage do
      begin
        //
        Visible := False;
        Parent := Self;
        SetBounds(Left, Top, Width, Height);
        Visible := True;
        BringToFront;
        //
        if Self.Visible
        then FActivePage.FStopScroll := False
        else FActivePage.FStopScroll := True;
        if CanScroll then GetScrollInfo;
      end;  
      //
      if (OldActivePage <> FActivePage) and Assigned(FOnChangePage) and
        not (csLoading in ComponentState)
      then FOnChangePage(Self);
    end;

  Invalidate;
end;

function TbsAppMenu.GetPageIndex(Value: TbsAppMenuPage): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Items.Count - 1 do
    if Items[i].Page = Value
    then
       begin
         Result := i;
         Break;
       end;
end;

procedure TbsAppMenu.Loaded;
var
  i: Integer;
begin
  inherited;
  if Items.Count > 0 then
    for i := 0 to Items.Count - 1 do
    if Items[i].Page <> nil then
    begin
      Items[i].Page.AppMenu := Self;
      if Items[i].Page = FActivePage
      then
        Items[i].Page.Visible := True
      else
        Items[i].Page.Visible := False;
    end;
end;

function TbsAppMenu.GetPageBoundsRect: TRect;
var
  LOff: Integer;
begin
  GetSkinData;
  if FData <> nil then LOFf := FData.PageOffset else LOff := 0;
  Result.Left := FItemWidth + LOff;
  Result.Top := 25;
  Result.Right := Self.Width - 25 - FItemWidth - LOff;
  Result.Bottom := Self.Height - 25 * 2;
end;

procedure TbsAppMenu.UpdateScrollInfo;
var
  FMin, FMax, FPage: Integer;
begin
  GetScrollInfo(FMin, FMax, FPage);
  if (FMax > FPage) and (ScrollBar = nil)
  then
    ShowScrollBar
  else
    if (FMax <= FPage) and (ScrollBar <> nil)
    then
      HideScrollBar;
  if ScrollBar <> nil
  then
     begin
       ScrollBar.SetRange(FMin, FMax, FScrollOffset, FPage);
       ScrollBar.LargeChange := FPage;
     end;
end;

procedure TbsAppMenu.WMSIZE(var Message: TWMSIZE);
var
  FMin, FMax, FPage: Integer;
begin
  inherited;
  if ActivePage <> nil
  then
    with ActivePage do
      SetBounds(Left, Top, Width, Height);
  //
  if (FOldHeight <> Height) and (FOldHeight <> -1)
  then
    begin
      GetScrollInfo(FMin, FMax, FPage);
      if FScrollOffset > 0
      then
        FScrollOffset := FScrollOffset - (Height - FOldHeight);
      if FScrollOffset < 0 then FScrollOffset := 0;
      if (FMax > FPage) and (ScrollBar = nil)
      then
        ShowScrollBar
      else
      if (FMax <= FPage) and (ScrollBar <> nil)
      then
        HideScrollBar;
      if ScrollBar <> nil
      then
        begin
          ScrollBar.SetRange(FMin, FMax, FScrollOffset, FPage);
          ScrollBar.LargeChange := FPage;
        end;
    end;    
  //
  if ScrollBar <> nil then AdjustScrollBar;
  Invalidate;
  FOldHeight := Height;
end;

procedure TbsAppMenu.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  Msg.Result := 1;
end;

procedure TbsAppMenu.Paint;
begin
  PaintAppMenu(Canvas);
end;

function TbsAppMenu.GetPageRect: TRect;
begin
  if ActivePage = nil
  then
    Result := Rect(0, 0, 0, 0)
  else
    Result := Rect(ActivePage.Left, ActivePage.Top,
      ActivePage.Left + ActivePage.Width, ActivePage.Top + ActivePage.Height);
end;

procedure TbsAppMenu.PaintAppMenu(C: TCanvas);
var
  i: Integer;
  Buffer, TopBuffer: TBitMap;
  X, Y, XCnt, YCnt, XO, YO: Integer;
  TOff, LOff, ROff, BOff: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  LB, RB, TB, BB, GripperBuffer: TBitMap;
  NewClRect, R: TRect;
begin
  if not ((Width > 0) and (Height > 0)) then Exit;
  GetSkinData;
  if (FIndex <> -1) and (FData <> nil)
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := Width;
      Buffer.Height := Height;
      // draw bg
      if FDataBGPicture <> nil
      then
        if FData.BGStretchEffect
        then
          Buffer.Canvas.StretchDraw(Rect(0, 0, Buffer.Width, Buffer.Height),
            FDataBGPicture)
        else
          begin
            XCnt := Buffer.Width div FDataBGPicture.Width;
            YCnt := Buffer.Height div FDataBGPicture.Height;
            for X := 0 to XCnt do
            for Y := 0 to YCnt do
              Buffer.Canvas.Draw(X * FDataBGPicture.Width,
                                 Y * FDataBGPicture.Height,
                                 FDataBGPicture);
          end;
      // area around page
      R := GetPageRect;
      if not IsNullRect(R) then
      begin

      with FData do
      begin
        TOff := ClRect.Top;
        LOff := ClRect.Left;
        ROff := RectWidth(SkinRect) - ClRect.Right;
        BOff := RectHeight(SkinRect) - ClRect.Bottom;
        R := Rect(R.Left - LOff, R.Top - TOff, R.Right + ROff, R.Bottom + BOff);
        XO := RectWidth(R) - RectWidth(SkinRect);
        YO := RectHeight(R) - RectHeight(SkinRect);
        NewLTPoint := LTPoint;
        NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
        NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
        NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
        NewCLRect := Rect(ClRect.Left, ClRect.Top, ClRect.Right + XO, ClRect.Bottom + YO);
      end;
      LB := TBitMap.Create;
      TB := TBitMap.Create;
      RB := TBitMap.Create;
      BB := TBitMap.Create;
      with FData do
        CreateSkinBorderImages(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
          NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewClRect,
           LB, TB, RB, BB, FDataPicture, SkinRect, RectWidth(R), RectHeight(R),
             LeftStretch, TopStretch, RightStretch, BottomStretch);
      Buffer.Canvas.Draw(R.Left, R.Top, TB);
      Buffer.Canvas.Draw(R.Left, R.Top + TB.Height, LB);
      Buffer.Canvas.Draw(R.Left + RectWidth(R) - RB.Width, R.Top + TB.Height, RB);
      Buffer.Canvas.Draw(R.Left, R.Top + RectHeight(R) - BB.Height, BB);
      
      LB.Free;
      TB.Free;
      RB.Free;
      BB.Free;

      end;
      //
      CalcItemRects;
      for i := 0 to Items.Count - 1 do
        if Items[i].Visible then DrawItem(Buffer.Canvas, i);
      //
      if not IsNullRect(FData.TopLineRect)
      then
        begin
          TopBuffer := TBitMap.Create;
          TopBuffer.Width := Width;
          TopBuffer.Height := RectHeight(FData.TopLineRect);
          with FData do
            CreateHSkinImage(TopLineOffset1, TopLineOffset2,
              TopBuffer, FDataPicture, TopLineRect, TopBuffer.Width, TopBuffer.Height, True);
          Buffer.Canvas.Draw(0, 0, TopBuffer);
          TopBuffer.Free;
        end;
       // 
      if CanShowGripper
      then
        with FData do
        begin
          GripperBuffer := TBitMap.Create;
          GripperBuffer.Width := RectWidth(GripperRect);
          GripperBuffer.Height := RectHeight(GripperRect);
          GripperBuffer.Canvas.CopyRect(
             Rect(0, 0, GripperBuffer.Width, GripperBuffer.Height),
            FDataPicture.Canvas, GripperRect);
          X := Buffer.Width - GripperBuffer.Width;
          Y := Buffer.Height - GripperBuffer.Height;
          GripperBuffer.Transparent := True;
          GripperBuffer.TransparentMode := tmFixed;
          GripperBuffer.TransparentColor := GripperTransparentColor;
          Buffer.Canvas.Draw(X, Y, GripperBuffer);
          GripperBuffer.Free;
        end;
      //
      C.Draw(0, 0, Buffer);
      Buffer.Free;
    end
  else
    begin
      C.Brush.Style := bsSolid;
      C.Brush.Color := clBtnShadow;
      C.FillRect(Rect(0, 0, Width, Height));
      CalcItemRects;
      for i := 0 to Items.Count - 1 do
        if Items[i].Visible then DrawDefItem(C, i);
    end;    
end;

procedure TbsAppMenu.DrawItem(C: TCanvas; Index: Integer);

function CheckBottomPosition: Boolean;
begin
  Result := True;
  if (ActivePage <> nil) and
     (Items[Index].ItemRect.Bottom > ActivePage.Top + ActivePage.Height - 5)
  then
    Result := False;
end;

var
  Buffer: TBitmap;
  R: TRect;
  IL: TCustomImageList;
  h: Integer;
begin
  if (
     (((Items[Index].ItemRect.Top >= 30) and CheckBottomPosition) and (Items[Index].Page <> nil)) or
     (Items[Index].Page = nil)
     )
     and
     ((Items[Index].Active) or
     ((Items[Index].Page = ActivePage) and (ActivePage <> nil)) or
     (ItemIndex = Index) and Items[Index].Enabled)
  then
    begin
      Buffer := TBitMap.Create;
      if Items[Index].Page <> nil
      then
        begin
          h := RectHeight(FData.PageItemRect);
          if (Items[Index].Page = ActivePage) and (ActivePage <> nil)
          then
            begin
              Buffer.Width := RectWidth(Items[Index].ItemRect);
              Buffer.Height := RectHeight(FData.PageItemActiveRect);
              with FData do
                CreateHSkinImage(PageItemOffset1, PageItemOffset2,
                  Buffer, FDataPicture, PageItemActiveRect, Buffer.Width, Buffer.Height, True);
            end
          else
            begin
              Buffer.Width := RectWidth(Items[Index].ItemRect);
              Buffer.Height := RectHeight(Items[Index].ItemRect);
              with FData do
                CreateHSkinImage(PageItemOffset1, PageItemOffset2,
                  Buffer, FDataPicture, PageItemRect, Buffer.Width, Buffer.Height, True);
            end;
          R := Rect(0, 0, Buffer.Width, h);
          if Items[Index].Page <> nil then Inc(R.Left, 20) else Inc(R.Left, 10);
          with Buffer.Canvas, FData do
          begin
            if FUseSkinFont
            then
              begin
                Font.Name := FontName;
                Font.Style := FontStyle;
              end
            else
              Font.Assign(Self.Font);
            Font.Color := ActiveFontPageColor;
            Font.Height := FontPageHeight;
            Brush.Style := bsClear;
          end;
          IL := FItemImageList;
          if (Items[Index].ImageIndex <> -1) and (IL <> nil) and
          (Items[Index].ImageIndex >=0) and (Items[Index].ImageIndex < IL.Count)
          then
            DrawImageAndText(Buffer.Canvas, R, 0, 5, blGlyphLeft,
                Items[Index].Caption, Items[Index].ImageIndex, IL,
               False, Items[Index].Enabled, False, 0)
          else
            BSDrawText5(Buffer.Canvas,
              Items[Index].Caption, R);
              C.Draw(Items[Index].ItemRect.Left, Items[Index].ItemRect.Top,
              Buffer);
        end
      else
        begin
          Buffer.Width := RectWidth(Items[Index].ItemRect);
          Buffer.Height := RectHeight(Items[Index].ItemRect);
          with FData do
            CreateHSkinImage(ItemOffset1, ItemOffset2, Buffer, FDataPicture, ItemRect, Buffer.Width, Buffer.Height, True);
          with Buffer.Canvas, FData do
          begin
            if FUseSkinFont
            then
              begin
                Font.Name := FontName;
                Font.Style := FontStyle;
              end
            else
              Font.Assign(Self.Font);
            Font.Color := ActiveFontColor;
            Font.Height := FontHeight;
            Brush.Style := bsClear;
          end;
          R := Rect(0, 0, Buffer.Width, Buffer.Height);
          if Items[Index].Page <> nil then Inc(R.Left, 20) else Inc(R.Left, 10);
          IL := FItemImageList;
          if (Items[Index].ImageIndex <> -1) and (IL <> nil) and
          (Items[Index].ImageIndex >=0) and (Items[Index].ImageIndex < IL.Count)
          then
            DrawImageAndText(Buffer.Canvas, R, 0, 5, blGlyphLeft,
                Items[Index].Caption, Items[Index].ImageIndex, IL,
               False, Items[Index].Enabled, False, 0)
          else
            BSDrawText5(Buffer.Canvas,
              Items[Index].Caption, R);
              C.Draw(Items[Index].ItemRect.Left, Items[Index].ItemRect.Top,
              Buffer);
      end;
      C.Draw(Items[Index].ItemRect.Left, Items[Index].ItemRect.Top, Buffer);
      Buffer.Free;
    end
  else
    with FData do
    begin
      if FUseSkinFont
      then
         begin
           C.Font.Name := FontName;
           C.Font.Style := FontStyle;
         end
      else
        C.Font.Assign(Self.Font);
      C.Brush.Style := bsClear;
      if Items[Index].Page <> nil
      then
        begin
          C.Font.Color := FontPageColor;
          C.Font.Height := FontPageHeight;
        end
      else
        begin
         C.Font.Color := FontColor;
         C.Font.Height := FontHeight;
        end;
      if not Items[Index].Enabled then C.Font.Color := DisabledFontColor;  
      R := Items[Index].ItemRect;
      if Items[Index].Page <> nil then Inc(R.Left, 20) else Inc(R.Left, 10);
      if Items[Index].Page <> nil
      then
        IL := FItemPageImageList
      else
        IL := FItemImageList;
      if (Items[Index].ImageIndex <> -1) and (IL <> nil) and
         (Items[Index].ImageIndex >=0) and (Items[Index].ImageIndex < IL.Count)
      then
        begin
          DrawImageAndText(C, R, 0, 5, blGlyphLeft,
             Items[Index].Caption, Items[Index].ImageIndex, IL,
             False, Items[Index].Enabled, False, 0);
        end
      else
        BSDrawText5(C, Items[Index].Caption, R);
    end;
end;

procedure TbsAppMenu.DrawDefItem(C: TCanvas; Index: Integer);
var
  Buffer: TBitmap;
  R: TRect;
  IL: TCustomImageList;
begin
  if (Items[Index].Active) or
  ((Items[Index].Page = ActivePage) and (ActivePage <> nil))
  or ((ItemIndex = Index) and not (csDesigning in ComponentState))
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(Items[Index].ItemRect);
      Buffer.Height := RectHeight(Items[Index].ItemRect) + 2;
      Buffer.Canvas.Brush.Color := clBtnFace;
      Buffer.Canvas.FillRect(Rect(0, 0, Buffer.Width, Buffer.Height));
      Buffer.Canvas.Font.Assign(C.Font);
      Buffer.Canvas.Font.Color := clBtnText;
      Buffer.Canvas.Brush.Style := bsClear;
      if Items[Index].Page = nil
      then
        Frm3d(Buffer.Canvas, Rect(0, 0, Buffer.Width, Buffer.Height),
           cl3dDkShadow, cl3dDkShadow);
      R := Rect(0, 0, Buffer.Width, Buffer.Height);
      if Items[Index].Page <> nil then Inc(R.Left, 20) else Inc(R.Left, 10);
      if Items[Index].Page <> nil
      then
        IL := FItemPageImageList
      else
        IL := FItemImageList;
      if (Items[Index].ImageIndex <> -1) and (IL <> nil) and
         (Items[Index].ImageIndex >=0) and (Items[Index].ImageIndex < IL.Count)
      then
        begin
          DrawImageAndText(Buffer.Canvas, R, 0, 5, blGlyphLeft,
             Items[Index].Caption, Items[Index].ImageIndex, IL,
             False, Items[Index].Enabled, False, 0);
        end
      else
        BSDrawText5(Buffer.Canvas,
            Items[Index].Caption, R);
      R := Rect(Buffer.Width - 5, 0, Buffer.Width, Buffer.Height);
      if Items[Index].Page = ActivePage
      then
        DrawArrowImage2(Buffer.Canvas, R, clWindow, 1);
      C.Draw(Items[Index].ItemRect.Left, Items[Index].ItemRect.Top,
         Buffer);
      Buffer.Free;
    end
  else
    begin
      C.Brush.Style := bsClear;
      C.Font.Color := clBtnHighLight;
      R := Items[Index].ItemRect;
      if Items[Index].Page <> nil then Inc(R.Left, 20) else Inc(R.Left, 10);
      if Items[Index].Page <> nil
      then
        IL := FItemPageImageList
      else
        IL := FItemImageList;
      if not Items[Index].Enabled then C.Font.Color := cl3ddkShadow;    
      if (Items[Index].ImageIndex <> -1) and (IL <> nil) and
         (Items[Index].ImageIndex >=0) and (Items[Index].ImageIndex < IL.Count)
      then
        begin
          DrawImageAndText(C, R, 0, 5, blGlyphLeft,
             Items[Index].Caption, Items[Index].ImageIndex, IL,
             False, Items[Index].Enabled, False, 0);
        end
      else
        BSDrawText5(C, Items[Index].Caption, R);
    end;
end;

procedure TbsAppMenu.CreatePage;

  function GetUniqueName(const Name: string; const AComponent: TComponent): string;
  var
    LIdx: Integer;
  begin
    LIdx := 1;
    Result := Format(Name, [LIdx]);
    if AComponent <> nil then
    begin
      while AComponent.FindComponent(Result) <> nil do
      begin
        Inc(LIdx);
        Result := Format(Name, [LIdx]);
      end;
    end;
  end;

var
  LPage: TbsAppMenuPage;
  R: TRect;
begin
  LPage := TbsAppMenuPage.Create(GetParentForm(Self));
  LPage.Parent := Self;
  LPage.AppMenu := Self;
  R := GetPageBoundsRect;
  LPage.SetBounds(R.Left, R.Top, R.Right, R.Bottom);
  LPage.Name := GetUniqueName('bsAppMenuPage%d', GetParentForm(Self));
  ActivePage := LPage;
  Invalidate;
end;

constructor TbsRibbonDivider.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csOpaque];
  FSkinDataName := 'officegroupdivider';
  FDividerType := bsdtVerticalLine;
  Width := 100;
  Height := 50;
end;

procedure TbsRibbonDivider.SetDividerType(Value: TbsRibbonDividerType);
begin
  FDividerType := Value;
  Invalidate;
end;

procedure TbsRibbonDivider.DrawLineH;
var
  B: TbsBitMap;
  i, h, Step, A: Integer;
  DstP: PbsColor;
begin
  if Width <= 0 then Exit;
  B := TbsBitMap.Create;
  B.SetSize(Width, 1);
  with B.Canvas do
  begin
    Pen.Color := DarkColor;
    MoveTo(0, 0);
    LineTo(B.Width, 0);
  end;
  //
  B.CheckingAlphaBlend;
  for i := 0 to B.Width - 1 do
  begin
    DstP := B.PixelPtr[i, 0];
    TbsColorRec(DstP^).A := 255;
  end;
  h := B.Width div 3;
  Step := Round (255 / h);
  A := 0;
  for i := 0 to h do
  begin
    if A > 255 then A := 255;
    DstP := B.PixelPtr[i, 0];
    TbsColorRec(DstP^).A := A;
    Inc(A, Step);
  end;
  A := 0;
  for i := B.Width - 1 downto B.Width - 1 - h do
  begin
    if A > 255 then A := 255;
    DstP := B.PixelPtr[i, 0];
    TbsColorRec(DstP^).A := A;
    Inc(A, Step);
  end;
  //
  B.AlphaBlend := True;
  B.Draw(Canvas, 0, Height div 2);
  B.Free;
end;

procedure TbsRibbonDivider.DrawLineV;
var
  B: TbsBitMap;
  i, h, Step, A: Integer;
  DstP: PbsColor;
begin
  if Height <= 0 then Exit;
  B := TbsBitMap.Create;
  B.SetSize(1, Height);
  with B.Canvas do
  begin
    Pen.Color := DarkColor;
    MoveTo(0, 0);
    LineTo(0, B.Height);
  end;
  //
  B.CheckingAlphaBlend;
  for i := 0 to B.Height - 1 do
  begin
    DstP := B.PixelPtr[0, i];
    TbsColorRec(DstP^).A := 255;
  end;
  h := B.Height div 3;
  Step := Round (255 / h);
  A := 0;
  for i := 0 to h do
  begin
    if A > 255 then A := 255;
    DstP := B.PixelPtr[0, i];
    TbsColorRec(DstP^).A := A;
    Inc(A, Step);
  end;
  A := 0;
  for i := B.Height - 1 downto B.Height - 1 - h do
  begin
    if A > 255 then A := 255;
    DstP := B.PixelPtr[0, i];
    TbsColorRec(DstP^).A := A;
    Inc(A, Step);
  end;
  //
  B.AlphaBlend := True;
  B.Draw(Canvas, Width div 2, 0);
  B.Free;
end;

procedure TbsRibbonDivider.DrawDashLineH;
var
  X, Y, W, Count, I: Integer;
begin
  W := 3;
  Count := (Width - 6) div (W * 2);
  X := 3;
  Y := Height div 2 - 1;
  for I := 1 to Count do
  with Canvas do
  begin
    Canvas.Pen.Color := DarkColor;
    MoveTo(X, Y); LineTo(X + W, Y);
    Canvas.Pen.Color := LightColor;
    MoveTo(X, Y + 1); LineTo(X + W, Y + 1);
    Inc(X, W * 2);
  end;
end;

procedure TbsRibbonDivider.DrawDashLineV;
var
  X, Y, W, Count, I: Integer;
begin
  W := 3;
  Count := (Height - 6) div (W * 2);
  X := Width div 2 - 1;
  Y := 3;
  for I := 1 to Count do
  with Canvas do
  begin
    Canvas.Pen.Color := DarkColor;
    MoveTo(X, Y); LineTo(X, Y + W);
    Canvas.Pen.Color := LightColor;
    MoveTo(X + 1, Y); LineTo(X + 1, Y + W);
    Inc(Y, W * 2);
  end;
end;

procedure TbsRibbonDivider.GetSkinData;
begin
  inherited;
  if FIndex = -1
  then
    begin
      if (FSD <> nil) and not FSD.Empty
      then
        begin
          LightColor := FSD.SkinColors.cBtnHighLight;
          DarkColor := FSD.SkinColors.cBtnShadow;
        end
      else
        begin
          LightColor := clBtnHighLight;
          DarkColor := clBtnShadow;
        end;  
    end
  else
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinBevel
    then
      with TbsDataSkinBevel(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.DarkColor := DarkColor;
        Self.LightColor := LightColor;
      end;
end;

procedure TbsRibbonDivider.Paint;
begin
  GetSkinData;
  case FDividerType of
    bsdtVerticalLine: DrawLineV;
    bsdtHorizontalLine: DrawLineH;
    bsdtVerticalDashLine: DrawDashLineV;
    bsdtHorizontalDashLine: DrawDashLineH;
  end;
end;

//

constructor TbsAppMenuPageItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FHeader := False;
  FImageIndex := -1;
  FCaption := '';
  FTitle := '';
  FEnabled := True;
  if TbsAppMenuPageItems(Collection).OfficeListBox.ItemIndex = Self.Index
  then
    Active := True
  else
    Active := False;
end;

procedure TbsAppMenuPageItem.Assign(Source: TPersistent);
begin
  if Source is TbsAppMenuPageItem then
  begin
    FImageIndex := TbsAppMenuPageItem(Source).ImageIndex;
    FCaption := TbsAppMenuPageItem(Source).Caption;
    FTitle := TbsAppMenuPageItem(Source).Title;
    FEnabled := TbsAppMenuPageItem(Source).Enabled;
    FHeader := TbsAppMenuPageItem(Source).Header;
  end
  else
    inherited Assign(Source);
end;

procedure TbsAppMenuPageItem.SetImageIndex(const Value: TImageIndex);
begin
  FImageIndex := Value;
  Changed(False);
end;

procedure TbsAppMenuPageItem.SetCaption(const Value: String);
begin
  FCaption := Value;
  Changed(False);
end;

procedure TbsAppMenuPageItem.SetHeader(Value: Boolean);
begin
  FHeader := Value;
  Changed(False);
end;

procedure TbsAppMenuPageItem.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  Changed(False);
end;

procedure TbsAppMenuPageItem.SetTitle(const Value: String);
begin
  FTitle := Value;
  Changed(False);
end;

procedure TbsAppMenuPageItem.SetData(const Value: Pointer);
begin
  FData := Value;
end;

constructor TbsAppMenuPageItems.Create;
begin
  inherited Create(TbsAppMenuPageItem);
  OfficeListBox := AListBox;
end;

function TbsAppMenuPageItems.GetOwner: TPersistent;
begin
  Result := OfficeListBox;
end;

procedure  TbsAppMenuPageItems.Update(Item: TCollectionItem);
begin
  OfficeListBox.Repaint;
  OfficeListBox.UpdateScrollInfo;
end; 

function TbsAppMenuPageItems.GetItem(Index: Integer):  TbsAppMenuPageItem;
begin
  Result := TbsAppMenuPageItem(inherited GetItem(Index));
end;

procedure TbsAppMenuPageItems.SetItem(Index: Integer; Value:  TbsAppMenuPageItem);
begin
  inherited SetItem(Index, Value);
  OfficeListBox.RePaint;
end;

function TbsAppMenuPageItems.Add: TbsAppMenuPageItem;
begin
  Result := TbsAppMenuPageItem(inherited Add);
  OfficeListBox.RePaint;
end;

function TbsAppMenuPageItems.Insert(Index: Integer): TbsAppMenuPageItem;
begin
  Result := TbsAppMenuPageItem(inherited Insert(Index));
  OfficeListBox.RePaint;
end;

procedure TbsAppMenuPageItems.Delete(Index: Integer);
begin
  inherited Delete(Index);
  OfficeListBox.RePaint;
end;

procedure TbsAppMenuPageItems.Clear;
begin
  inherited Clear;
  OfficeListBox.RePaint;
end;

constructor TbsAppMenuPageListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csAcceptsControls];
  FAppMenu := nil;
  FClicksDisabled := False;
  FMouseMoveChangeIndex := True;
  FMouseDown := False;
  FShowLines := False;
  FMouseActive := -1;
  ScrollBar := nil;
  FScrollOffset := 0;
  FItems := TbsAppMenuPageItems.Create(Self);
  FImages := nil;
  Width := 150;
  Height := 150;
  FItemHeight := 30;
  FHeaderHeight := 20;
  FSkinDataName := 'menupagepanel';
  FShowItemTitles := True;
  FMax := 0;
  FRealMax := 0;
  FOldHeight := -1;
  FItemIndex := -1;
  FDisabledFontColor := clGray;
  TabStop := True;
end;

destructor TbsAppMenuPageListBox.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TbsAppMenuPageListBox.CalcHeight;
var
  H: Integer;
begin
  if AItemCount > FItems.Count then AItemCount := FItems.Count;
  H := AItemCount * ItemHeight;
  if FIndex = -1
  then
    begin
      H := H + 5;
    end
  else
    begin
      H := H + Height - RectHeight(RealClientRect) + 1;
    end;
  Result := H;  
end;

procedure TbsAppMenuPageListBox.SetShowLines;
begin
  if FShowLines <> Value
  then
    begin
      FShowLines := Value;
      RePaint;
    end;
end;

procedure TbsAppMenuPageListBox.ChangeSkinData;
var
  CIndex: Integer;
begin
  inherited;
  //
  if SkinData <> nil
  then
    CIndex := SkinData.GetControlIndex('edit')
  else
    CIndex := -1;  
  if CIndex = -1
  then
    FDisabledFontColor := SkinData.SkinColors.cBtnShadow
  else
    FDisabledFontColor := TbsDataSkinEditControl(SkinData.CtrlList[CIndex]).DisabledFontColor;
  //
  if ScrollBar <> nil
  then
    begin
      ScrollBar.SkinData := SkinData;
      AdjustScrollBar;
    end;
  CalcItemRects;
  RePaint;
end;

procedure TbsAppMenuPageListBox.SetItemHeight(Value: Integer);
begin
  if FItemHeight <> Value
  then
    begin
      FItemHeight := Value;
      RePaint;
    end;
end;

procedure TbsAppMenuPageListBox.SetHeaderHeight(Value: Integer);
begin
  if FHeaderHeight <> Value
  then
    begin
      FHeaderHeight := Value;
      RePaint;
    end;
end;

procedure TbsAppMenuPageListBox.SetItems(Value: TbsAppMenuPageItems);
begin
  FItems.Assign(Value);
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsAppMenuPageListBox.SetImages(Value: TCustomImageList);
begin
  FImages := Value;
end;

procedure TbsAppMenuPageListBox.Notification(AComponent: TComponent;
            Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then
   FImages := nil;
  if (Operation = opRemove) and (AComponent = FAppMenu) then
   FAppMenu := nil;
end;

procedure TbsAppMenuPageListBox.SetShowItemTitles(Value: Boolean);
begin
  if FShowItemTitles <> Value
  then
    begin
      FShowItemTitles := Value;
      RePaint;
    end;
end;

procedure TbsAppMenuPageListBox.DrawItem;
begin
  if FIndex <> -1
  then
    SkinDrawItem(Index, Cnvs)
  else
    DefaultDrawItem(Index, Cnvs);
end;

procedure TbsAppMenuPageListBox.CreateControlDefaultImage(B: TBitMap);
var
  I, SaveIndex: Integer;
  R: TRect;
begin
  //
  R := Rect(0, 0, Width, Height);
  Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
  InflateRect(R, -1, -1);
  with B.Canvas do
  begin
    Brush.Color := clWindow;
    FillRect(R);
  end;
  //
  CalcItemRects;
  SaveIndex := SaveDC(B.Canvas.Handle);
  IntersectClipRect(B.Canvas.Handle,
    FItemsRect.Left, FItemsRect.Top, FItemsRect.Right, FItemsRect.Bottom);
  for I := 0 to FItems.Count - 1 do
   if FItems[I].IsVisible then DrawItem(I, B.Canvas);
  RestoreDC(B.Canvas.Handle, SaveIndex);
end;

procedure TbsAppMenuPageListBox.CreateControlSkinImage(B: TBitMap);
var
  I, SaveIndex: Integer;
begin
  inherited;
  CalcItemRects;
  SaveIndex := SaveDC(B.Canvas.Handle);
  IntersectClipRect(B.Canvas.Handle,
    FItemsRect.Left, FItemsRect.Top, FItemsRect.Right, FItemsRect.Bottom);
  for I := 0 to FItems.Count - 1 do
   if FItems[I].IsVisible then DrawItem(I, B.Canvas);
  RestoreDC(B.Canvas.Handle, SaveIndex);
end;

procedure TbsAppMenuPageListBox.CalcItemRects;
var
  I: Integer;
  X, Y, W, H: Integer;
begin
  FRealMax := 0;
  if FIndex <> -1
  then
    FItemsRect := RealClientRect
  else
    FItemsRect := Rect(2, 2, Width - 2, Height - 2);
  if ScrollBar <> nil then Dec(FItemsRect.Right, ScrollBar.Width);  
  X := FItemsRect.Left;
  Y := FItemsRect.Top;
  W := RectWidth(FItemsRect);
  for I := 0 to FItems.Count - 1 do
    with TbsAppMenuPageItem(FItems[I]) do
    begin
      if not Header then H := ItemHeight else H := HeaderHeight;
      ItemRect := Rect(X, Y, X + W, Y + H);
      OffsetRect(ItemRect, 0, - FScrollOffset);
      IsVisible := RectToRect(ItemRect, FItemsRect);
      if not IsVisible and (ItemRect.Top <= FItemsRect.Top) and
        (ItemRect.Bottom >= FItemsRect.Bottom)
      then
        IsVisible := True;
      if IsVisible then FRealMax := ItemRect.Bottom;
      Y := Y + H;
    end;
  FMax := Y;
end;

procedure TbsAppMenuPageListBox.Scroll(AScrollOffset: Integer);
begin
  FScrollOffset := AScrollOffset;
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsAppMenuPageListBox.GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
begin
  CalcItemRects;
  AMin := 0;
  AMax := FMax - FItemsRect.Top;
  APage := RectHeight(FItemsRect);
  if AMax <= APage
  then
    begin
      APage := 0;
      AMax := 0;
    end;  
  APosition := FScrollOffset;
end;

procedure TbsAppMenuPageListBox.WMSize(var Msg: TWMSize);
begin
  inherited;
  if (FOldHeight <> Height) and (FOldHeight <> -1)
  then
    begin
      CalcItemRects;
      if (FRealMax <= FItemsRect.Bottom) and (FScrollOffset > 0)
      then
        begin
          FScrollOffset := FScrollOffset - (FItemsRect.Bottom - FRealMax);
          if FScrollOffset < 0 then FScrollOffset := 0;
          CalcItemRects;
          Invalidate;
        end;
    end;
  AdjustScrollBar;
  UpdateScrollInfo;
  FOldHeight := Height;
end;

procedure TbsAppMenuPageListBox.ScrollToItem(Index: Integer);
var
  R, R1: TRect;
begin
  CalcItemRects;
  R1 := FItems[Index].ItemRect;
  R := R1;
  OffsetRect(R, 0, FScrollOffset);
  if (R1.Top <= FItemsRect.Top)
  then
    begin
      if (Index = 1) and FItems[Index - 1].Header
      then
        FScrollOffset := 0
      else
        FScrollOffset := R.Top - FItemsRect.Top;
      CalcItemRects;
      Invalidate;
    end
  else
  if R1.Bottom >= FItemsRect.Bottom
  then
    begin
      FScrollOffset := R.Top;
      FScrollOffset := FScrollOffset - RectHeight(FItemsRect) + RectHeight(R) -
        Height + FItemsRect.Bottom + 1;
      CalcItemRects;
      Invalidate;
    end;
  UpdateScrollInfo;  
end;

procedure TbsAppMenuPageListBox.ShowScrollbar;
begin
  if ScrollBar = nil
  then
    begin
      ScrollBar := TbsSkinScrollBar.Create(Self);
      ScrollBar.Visible := False;
      ScrollBar.Parent := Self;
      ScrollBar.DefaultHeight := 0;
      ScrollBar.DefaultWidth := 19;
      ScrollBar.SmallChange := ItemHeight;
      ScrollBar.LargeChange := ItemHeight;
      ScrollBar.SkinDataName := 'vscrollbar';
      ScrollBar.Kind := sbVertical;
      ScrollBar.SkinData := Self.SkinData;
      ScrollBar.OnChange := SBChange;
      AdjustScrollBar;
      ScrollBar.Visible := True;
      RePaint;
    end;
end;

procedure TbsAppMenuPageListBox.HideScrollBar;
begin
  if ScrollBar = nil then Exit;
  ScrollBar.Visible := False;
  ScrollBar.Free;
  ScrollBar := nil;
  RePaint;
end;

procedure TbsAppMenuPageListBox.UpdateScrollInfo;
var
  SMin, SMax, SPage, SPos: Integer;
begin
  //
  if not HandleAllocated then Exit;
  //
  GetScrollInfo(SMin, SMax, SPage, SPos);
  if SMax <> 0
  then
    begin
      if ScrollBar = nil then ShowScrollBar;
      ScrollBar.SetRange(SMin, SMax, SPos, SPage);
      ScrollBar.LargeChange := SPage;
    end
  else
  if (SMax = 0) and (ScrollBar <> nil)
  then
    begin
      HideScrollBar;
    end;
end;

procedure TbsAppMenuPageListBox.AdjustScrollBar;
var
  R: TRect;
begin
  if ScrollBar = nil then Exit;
  if FIndex = -1
  then
    R := Rect(2, 2, Width - 2, Height - 2)
  else
    R := RealClientRect;
  Dec(R.Right, ScrollBar.Width);
  ScrollBar.SetBounds(R.Right, R.Top, ScrollBar.Width,
   RectHeight(R));
end;

procedure TbsAppMenuPageListBox.SBChange(Sender: TObject);
begin
  Scroll(ScrollBar.Position);
end;

procedure TbsAppMenuPageListBox.SkinDrawItem(Index: Integer; Cnvs: TCanvas);
var
  ListBoxData: TbsDataSkinListBox;
  CIndex, TX, TY: Integer;
  R, R1: TRect;
  Buffer: TBitMap;
  C: TColor;
  SaveIndex: Integer;
begin
  if  FItems[Index].Header
  then
    begin
      SkinDrawHeaderItem(Index, Cnvs);
      Exit;
    end;  

  CIndex := SkinData.GetControlIndex('listbox');
  if CIndex = -1 then Exit;
  R := FItems[Index].ItemRect;
  InflateRect(R, -2, -2);
  ListBoxData := TbsDataSkinListBox(SkinData.CtrlList[CIndex]);
  Cnvs.Brush.Style := bsClear;
  //
  if (FDisabledFontColor = ListBoxData.FontColor) and
     (FDisabledFontColor = clBlack)
  then
    FDisabledFontColor := clGray;   
  //
  if not FUseSkinFont
  then
    Cnvs.Font.Assign(FDefaultFont)
  else
    with Cnvs.Font, ListBoxData do
    begin
      Name := FontName;
      Height := FontHeight;
      Style := FontStyle;
    end;

  if FItems[Index].Enabled
  then
    Cnvs.Font.Color := ListBoxData.FontColor
  else
    Cnvs.Font.Color := FDisabledFontColor;


  with Cnvs.Font do
  begin
    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Charset := SkinData.ResourceStrData.CharSet
    else
      CharSet := FDefaultFont.Charset;
  end;
  //
  if (not FItems[Index].Active) or (not FItems[Index].Enabled)
  then
    with FItems[Index] do
    begin
      SaveIndex := SaveDC(Cnvs.Handle);
      IntersectClipRect(Cnvs.Handle, FItems[Index].ItemRect.Left, FItems[Index].ItemRect.Top,
        FItems[Index].ItemRect.Right, FItems[Index].ItemRect.Bottom);

    if Assigned(FOnDrawItem)
    then
      begin
        Cnvs.Brush.Style := bsClear;
        FOnDrawItem(Cnvs, Index, R);
      end
    else
     begin
      if (Title <> '') and FShowItemTitles
      then
        begin
          R1 := R;
          Cnvs.Font.Style := Cnvs.Font.Style + [fsBold];
          R1.Bottom := R1.Top + Cnvs.TextHeight(Title);
          Cnvs.Brush.Style := bsClear;
          DrawText(Cnvs.Handle, PChar(Title), Length(FTitle), R1, DT_LEFT);
          Cnvs.Font.Style := Cnvs.Font.Style - [fsBold];
          R.Top := R1.Bottom;
        end;
        if (FImages <> nil) and (ImageIndex >= 0) and
           (ImageIndex < FImages.Count)
        then
         begin
           DrawImageAndText2(Cnvs, R, 0, 2, blGlyphLeft,
             Caption, FImageIndex, FImages,
             False, Enabled, False, 0);
         end
       else
         begin
           Cnvs.Brush.Style := bsClear;
           if FShowItemTitles
           then
             Inc(R.Left, 10);
           R1 := Rect(0, 0, RectWidth(R), RectHeight(R));
           DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), R1,
             DT_LEFT or DT_CALCRECT or DT_WORDBREAK);
           TX := R.Left;
           TY := R.Top + RectHeight(R) div 2 - RectHeight(R1) div 2;
           if TY < R.Top then TY := R.Top;
           R := Rect(TX, TY, TX + RectWidth(R1), TY + RectHeight(R1));
           DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), R,
             DT_EXPANDTABS or DT_WORDBREAK or DT_LEFT);
         end;
      end;   
      if FShowLines
      then
        begin
          C := Cnvs.Pen.Color;
          Cnvs.Pen.Color := SkinData.SkinColors.cBtnShadow;
          Cnvs.MoveTo(FItems[Index].ItemRect.Left, FItems[Index].ItemRect.Bottom - 1);
          Cnvs.LineTo(FItems[Index].ItemRect.Right, FItems[Index].ItemRect.Bottom - 1);
          Cnvs.Pen.Color := C;
        end;
      RestoreDC(Cnvs.Handle, SaveIndex);
    end
  else
    with FItems[Index] do
    begin
      Buffer := TBitMap.Create;
      R := FItems[Index].ItemRect;
      Buffer.Width := RectWidth(R);
      Buffer.Height := RectHeight(R);
      //
      with ListBoxData do
      if Focused
      then
        CreateStretchImage(Buffer, Picture, FocusItemRect, ItemTextRect, True)
      else
        CreateStretchImage(Buffer, Picture, ActiveItemRect, ItemTextRect, True);
      //
     if not FUseSkinFont
     then
       Buffer.Canvas.Font.Assign(FDefaultFont)
     else
       with Buffer.Canvas.Font, ListBoxData do
       begin
         Name := FontName;
         Height := FontHeight;
         Style := FontStyle;
       end;

       if Focused
       then
         Buffer.Canvas.Font.Color := ListBoxData.FocusFontColor
       else
         Buffer.Canvas.Font.Color := ListBoxData.ActiveFontColor;

       with Buffer.Canvas.Font do
       begin
         if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
         then
           Charset := SkinData.ResourceStrData.CharSet
         else
           CharSet := FDefaultFont.Charset;
        end;

       R := Rect(2, 2, Buffer.Width - 2, Buffer.Height - 2);

      if Assigned(FOnDrawItem)
      then
        begin
          Buffer.Canvas.Brush.Style := bsClear;
          FOnDrawItem(Buffer.Canvas, Index, R);
        end
      else
      begin

      if (Title <> '') and FShowItemTitles
      then
        begin
          R1 := R;
          Buffer.Canvas.Font.Style := Cnvs.Font.Style + [fsBold];
          R1.Bottom := R1.Top + Buffer.Canvas.TextHeight(Title);
          Buffer.Canvas.Brush.Style := bsClear;
          DrawText(Buffer.Canvas.Handle, PChar(Title), Length(FTitle), R1, DT_LEFT);
          Buffer.Canvas.Font.Style := Cnvs.Font.Style - [fsBold];
          R.Top := R1.Bottom;
        end;
        if (FImages <> nil) and (ImageIndex >= 0) and
           (ImageIndex < FImages.Count)
        then
         begin
           DrawImageAndText2(Buffer.Canvas, R, 0, 2, blGlyphLeft,
             Caption, FImageIndex, FImages,
             False, Enabled, False, 0);
         end
       else
         begin
           Buffer.Canvas.Brush.Style := bsClear;
           if FShowItemTitles
           then
             Inc(R.Left, 10);
           R1 := Rect(0, 0, RectWidth(R), RectHeight(R));
           DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), R1,
             DT_LEFT or DT_CALCRECT or DT_WORDBREAK);
           TX := R.Left;
           TY := R.Top + RectHeight(R) div 2 - RectHeight(R1) div 2;
           if TY < R.Top then TY := R.Top;
           R := Rect(TX, TY, TX + RectWidth(R1), TY + RectHeight(R1));
           DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), R,
             DT_EXPANDTABS or DT_WORDBREAK or DT_LEFT);
         end;
        end;
      Cnvs.Draw(FItems[Index].ItemRect.Left,
        FItems[Index].ItemRect.Top, Buffer);
      Buffer.Free;
    end;
end;

procedure TbsAppMenuPageListBox.DefaultDrawItem(Index: Integer; Cnvs: TCanvas);
var
  R, R1: TRect;
  C, FC: TColor;
  TX, TY: Integer;
  SaveIndex: Integer;
begin
  if FItems[Index].Header
  then
    begin
      C := clBtnShadow;
      FC := clBtnHighLight;
    end
  else
  if FItems[Index].Active
  then
    begin
      C := clHighLight;
      FC := clHighLightText;
     end
  else
    begin
      C := clWindow;
      if FItems[Index].Enabled
      then
        FC := clWindowText
      else
        FC := clGray;  
    end;
  //
  Cnvs.Font := FDefaultFont;
  Cnvs.Font.Color := FC;
  //
  R := FItems[Index].ItemRect;
  SaveIndex := SaveDC(Cnvs.Handle);
  IntersectClipRect(Cnvs.Handle, R.Left, R.Top, R.Right, R.Bottom);
  //
  Cnvs.Brush.Color := C;
  Cnvs.Brush.Style := bsSolid;
  Cnvs.FillRect(R);
  Cnvs.Brush.Style := bsClear;
  //
  InflateRect(R, -2, -2);
  if FItems[Index].Header
  then
    with FItems[Index] do
    begin
      DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), R,
        DT_CENTER or DT_VCENTER or DT_SINGLELINE);
    end
  else
    with FItems[Index] do
    begin
      if Assigned(FOnDrawItem)
      then
        begin
          Cnvs.Brush.Style := bsClear;
          FOnDrawItem(Cnvs, Index, FItems[Index].ItemRect);
        end
      else
      begin
      if (Title <> '') and FShowItemTitles
      then
        begin
          R1 := R;
          Cnvs.Font.Style := Cnvs.Font.Style + [fsBold];
          R1.Bottom := R1.Top + Cnvs.TextHeight(Title);
          DrawText(Cnvs.Handle, PChar(Title), Length(FTitle), R1, DT_LEFT);
          Cnvs.Font.Style := Cnvs.Font.Style - [fsBold];
          R.Top := R1.Bottom;
        end;
        if (FImages <> nil) and (ImageIndex >= 0) and
           (ImageIndex < FImages.Count)
        then
         begin
           DrawImageAndText2(Cnvs, R, 0, 2, blGlyphLeft,
             Caption, FImageIndex, FImages,
             False, Enabled, False, 0);
         end
       else
         begin
           if FShowItemTitles
           then
             Inc(R.Left, 10);
           R1 := Rect(0, 0, RectWidth(R), RectHeight(R));
           DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), R1,
             DT_LEFT or DT_CALCRECT or DT_WORDBREAK);
           TX := R.Left;
           TY := R.Top + RectHeight(R) div 2 - RectHeight(R1) div 2;
           if TY < R.Top then TY := R.Top;
           R := Rect(TX, TY, TX + RectWidth(R1), TY + RectHeight(R1));
           DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), R,
             DT_WORDBREAK or DT_LEFT);
         end;
      end;   
      if FShowLines
      then
        begin
          C := Cnvs.Pen.Color;
          Cnvs.Pen.Color := clBtnFace;
          Cnvs.MoveTo(FItems[Index].ItemRect.Left, FItems[Index].ItemRect.Bottom - 1);
          Cnvs.LineTo(FItems[Index].ItemRect.Right, FItems[Index].ItemRect.Bottom - 1);
          Cnvs.Pen.Color := C;
        end;
    end;
  if FItems[Index].Active and Focused
  then
    Cnvs.DrawFocusRect(FItems[Index].ItemRect);
  RestoreDC(Cnvs.Handle, SaveIndex);   
end;

procedure TbsAppMenuPageListBox.SkinDrawHeaderItem(Index: Integer; Cnvs: TCanvas);
var
  Buffer: TBitMap;
  CIndex: Integer;
  LData: TbsDataSkinLabelControl;
  R, TR: TRect;
  CPicture: TBitMap;
begin
  CIndex := SkinData.GetControlIndex('menuheader');
  if CIndex = -1
  then
    CIndex := SkinData.GetControlIndex('label');
  if CIndex = -1 then Exit;
  R := FItems[Index].ItemRect;
  LData := TbsDataSkinLabelControl(SkinData.CtrlList[CIndex]);
  CPicture := TBitMap(FSD.FActivePictures.Items[LData.PictureIndex]);
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(R);
  Buffer.Height := RectHeight(R);
  with LData do
  begin
    CreateStretchImage(Buffer, CPicture, SkinRect, ClRect, True);
  end;
  TR := Rect(5, 1, Buffer.Width - 1, Buffer.Height - 1);
  with Buffer.Canvas, LData do
  begin
    Font.Name := FontName;
    Font.Color := FontColor;
    Font.Height := FontHeight;
    Font.Style := FontStyle;
    Brush.Style := bsClear;
  end;
  with FItems[Index] do
    DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR,
      DT_LEFT or DT_VCENTER or DT_SINGLELINE);
  Cnvs.Draw(R.Left, R.Top, Buffer);
  Buffer.Free;
end;


procedure TbsAppMenuPageListBox.SetItemIndex(Value: Integer);
var
  I: Integer;
begin
  if Value < 0
  then
    begin
      FItemIndex := Value;
      for I := 0 to FItems.Count - 1 do
        with FItems[I] do Active := False;
      RePaint;
    end
  else
    begin
      FItemIndex := Value;
      for I := 0 to FItems.Count - 1 do
        with FItems[I] do
        begin
          if I = FItemIndex
          then
            begin
              Active := True;
            end
          else
             Active := False;
        end;
      RePaint;
      ScrollToItem(FItemIndex);
    end;
end;

procedure TbsAppMenuPageListBox.Loaded;
begin
  inherited;
end;

function TbsAppMenuPageListBox.ItemAtPos(X, Y: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count - 1 do
    if PtInRect(FItems[I].ItemRect, Point(X, Y)) and (FItems[I].Enabled)
    then
      begin
        Result := I;
        Break;
      end;  
end;


procedure TbsAppMenuPageListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  I := ItemAtPos(X, Y);
  if (I <> -1) and not (FItems[I].Header) and (Button = mbLeft)
  then
    begin
      SetItemActive(I);
      FMouseDown := True;
      FMouseActive := I;
    end;
end;

procedure TbsAppMenuPageListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  FMouseDown := False;
  I := ItemAtPos(X, Y);
  if (I <> -1) and not (FItems[I].Header) and (Button = mbLeft) then ItemIndex := I;
  if (I <> -1) and not (csDesigning in ComponentState) and  (not FItems[I].Header) and (Button = mbLeft)
  then
    begin
      if (FAppMenu <> nil) and (FAppMenu.Ribbon <> nil)
      then
        FAppMenu.Ribbon.HideAppMenu(nil);
      if Assigned(FOnItemClick) then FOnItemClick(Self);
      if Assigned(FItems[ItemIndex].OnClick)
      then
        FItems[ItemIndex].OnClick(Self);
    end;
end;

procedure TbsAppMenuPageListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  I := ItemAtPos(X, Y);
  if (I <> -1) and not (FItems[I].Header) and (FMouseDown or FMouseMoveChangeIndex)
   and (I <> FMouseActive)
  then
    begin
      SetItemActive(I);
      FMouseActive := I;
    end;
end;

procedure TbsAppMenuPageListBox.SetItemActive(Value: Integer);
var
  I: Integer;
begin
  FItemIndex := Value;
  for I := 0 to FItems.Count - 1 do
  with FItems[I] do
   if I = Value then Active := True else Active := False;
  RePaint;
  ScrollToItem(Value);
end;

type
  TbsHookScrollBar = class(TbsSkinScrollBar);

procedure TbsAppMenuPageListBox.WMMOUSEWHEEL(var Message: TMessage);
begin
  inherited;
  if ScrollBar = nil then Exit;
  if Message.WParam < 0
  then
    ScrollBar.Position :=  ScrollBar.Position + ScrollBar.SmallChange
  else
    ScrollBar.Position :=  ScrollBar.Position - ScrollBar.SmallChange;

end;

procedure TbsAppMenuPageListBox.WMSETFOCUS(var Message: TWMSETFOCUS);
begin
  inherited;
   if FItemIndex =-1 then FindDown;
   RePaint;
end;

procedure TbsAppMenuPageListBox.WMKILLFOCUS(var Message: TWMKILLFOCUS);
begin
  inherited;
  RePaint;
end;

procedure TbsAppMenuPageListBox.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      if not (csDesigning in ComponentState) and not Focused then
      begin
        FClicksDisabled := True;
        Windows.SetFocus(Handle);
        FClicksDisabled := False;
        if not Focused then Exit;
      end;
    CN_COMMAND:
      if FClicksDisabled then Exit;
  end;
  inherited WndProc(Message);
end;

procedure TbsAppMenuPageListBox.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  if FAppMenu <> nil
  then
    Msg.Result := DLGC_WANTARROWS or DLGC_WANTTAB
  else
    Msg.Result := DLGC_WANTARROWS;
end;

procedure TbsAppMenuPageListBox.FindUp;
var
  I, Start: Integer;
begin
  if ItemIndex <= -1 then Exit;
  Start := FItemIndex - 1;
  if Start < 0 then Exit;
  for I := Start downto 0 do
  begin
    if (not FItems[I].Header) and FItems[I].Enabled
    then
      begin
        ItemIndex := I;
        Exit;
      end;  
  end;
end;

procedure TbsAppMenuPageListBox.FindDown;
var
  I, Start: Integer;
begin
  if ItemIndex <= -1 then Start := 0 else Start := FItemIndex + 1;
  if Start > FItems.Count - 1 then Exit;
  for I := Start to FItems.Count - 1 do
  begin
    if (not FItems[I].Header) and FItems[I].Enabled
    then
      begin
        ItemIndex := I;
        Exit;
      end;
  end;
end;

procedure TbsAppMenuPageListBox.FindPageUp;
var
  I, J, Start: Integer;
  PageCount: Integer;
  FindHeader: Boolean;
begin
  if ItemIndex <= -1 then Exit;
  Start := FItemIndex - 1;
  if Start < 0 then Exit;
  PageCount := RectHeight(FItemsRect) div FItemHeight;
  if PageCount = 0 then PageCount := 1;
  PageCount := Start - PageCount;
  if PageCount < 0 then PageCount := 0;
  FindHeader := False;
  J := -1;
  for I := Start downto PageCount do
  begin
    if not FItems[I].Header and FindHeader and FItems[I].Enabled
    then
      begin
        ItemIndex := I;
        Exit;
      end
    else
    if FItems[I].Header
    then
      begin
        FindHeader := True;
        Continue;
      end
    else
    if not FItems[I].Header and FItems[I].Enabled
    then
      begin
        J := I;
      end;
  end;
  if J <> -1 then ItemIndex := J;
end;


procedure TbsAppMenuPageListBox.FindPageDown;
var
  I, J, Start: Integer;
  PageCount: Integer;
  FindHeader: Boolean;
begin
  if ItemIndex <= -1 then Start := 0 else Start := FItemIndex + 1;
  if Start > FItems.Count - 1 then Exit;
  PageCount := RectHeight(FItemsRect) div FItemHeight;
  if PageCount = 0 then PageCount := 1;
  PageCount := Start + PageCount;
  if PageCount > FItems.Count - 1 then PageCount := FItems.Count - 1;
  FindHeader := False;
  J := -1;
  for I := Start to PageCount do
  begin
    if not FItems[I].Header and FindHeader  and FItems[I].Enabled
    then
      begin
        ItemIndex := I;
        Exit;
      end
    else
    if FItems[I].Header
    then
      begin
        FindHeader := True;
        Continue;
      end
    else
    if not FItems[I].Header  and FItems[I].Enabled
    then
      begin
        J := I;
      end;
  end;
  if J <> -1 then ItemIndex := J;
end;

procedure TbsAppMenuPageListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
 inherited KeyDown(Key, Shift);
 if (Key = VK_TAB) and (FAppMenu <> nil)
 then
   begin
     FAppMenu.SetFocus;
   end
 else
 if (Key = VK_LEFT) and (FAppMenu <> nil)
 then
   begin
     FAppMenu.SetFocus;
   end
 else
 if (Key = VK_RETURN) and (ItemIndex <> -1)
 then
   begin
     if not FItems[ItemIndex].Header  
     then
       begin
         if (FAppMenu <> nil) and (FAppMenu.Ribbon <> nil)
         then
           FAppMenu.Ribbon.HideAppMenu(nil);
         if Assigned(FOnItemClick) then FOnItemClick(Self);
         if Assigned(FItems[ItemIndex].OnClick)
         then
           FItems[ItemIndex].OnClick(Self);
       end;
   end
 else
 if (Key = VK_NEXT)
  then
    FindPageDown
  else
  if (Key = VK_PRIOR)
  then
    FindPageUp
  else
  if (Key = VK_UP) or (Key = VK_LEFT)
  then
    FindUp
  else
  if (Key = VK_DOWN) or (Key = VK_RIGHT)
  then
    FindDown;
end;


end.
