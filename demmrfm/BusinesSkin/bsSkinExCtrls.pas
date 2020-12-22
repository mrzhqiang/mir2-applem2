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

unit bsSkinExCtrls;

{$P+,S-,W-,R-}                             
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Menus, StdCtrls, ExtCtrls, bsSkinData, bsUtils, bsSkinCtrls,
  bsEffects, ImgList, bsSkinBoxCtrls, bsPngImageList, bsSkinHint,
  bsSkinMenus;

type
  TbsSkinAnimateGauge = class(TbsSkinCustomControl)
  protected
    FImitation: Boolean;
    FCountFrames: Integer;
    FAnimationFrame: Integer;
    FAnimationPauseTimer: TTimer;
    FAnimationTimer: TTimer;
    FAnimationPause: Integer;
    FProgressText: String;
    FShowProgressText: Boolean;
    procedure OnAnimationPauseTimer(Sender: TObject);
    procedure OnAnimationTimer(Sender: TObject);
    procedure SetShowProgressText(Value: Boolean);
    procedure SetProgressText(Value: String);
    procedure GetSkinData; override;
    procedure CreateImage(B: TBitMap);
    procedure DrawProgressText(C: TCanvas);
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    function GetAnimationFrameRect: TRect;
    procedure CalcSize(var W, H: Integer); override;
    function CalcProgressRect: TRect;
    procedure StartInternalAnimation;
    procedure StopInternalAnimation;
  public
    ProgressRect, ProgressArea: TRect;
    NewProgressArea: TRect;
    BeginOffset, EndOffset: Integer;
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor: TColor;
    ProgressTransparent: Boolean;
    ProgressTransparentColor: TColor;
    ProgressStretch: Boolean;
    AnimationBeginOffset,
    AnimationEndOffset: Integer; 
    //
    AnimationSkinRect: TRect;
    AnimationCountFrames: Integer;
    AnimationTimerInterval: Integer;
    //
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartAnimation;
    procedure StopAnimation;
    procedure SetAnimationPause(Value: Integer);
    procedure ChangeSkinData; override;
  published
    property ProgressText: String read FProgressText write SetProgressText;
    property ShowProgressText: Boolean read FShowProgressText write SetShowProgressText;
    property AnimationPause: Integer
      read  FAnimationPause write SetAnimationPause;
    property Align;
    property Enabled;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property PopupMenu;
    property ShowHint;
  end;

  TbsSkinLinkImage = class(TImage)
  private
    FURL: String;
  protected
    procedure Click; override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property URL: string read FURL write FURL;
  end;

  TbsSkinLinkLabel = class(TCustomLabel)
  protected
    FGlowEffect: Boolean;
    FGlowSize: Integer;
    FMouseIn: Boolean;
    FIndex: Integer;
    FSD: TbsSkinData;
    FSkinDataName: String;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FDefaultActiveFontColor: TColor;
     FURL: String;
    FUseUnderLine: Boolean;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSkinData(Value: TbsSkinData);
    procedure SetDefaultFont(Value: TFont);
    property Transparent;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure GetSkinData;
    procedure DoDrawText(var Rect: TRect; Flags: Longint); override;
    procedure SetUseUnderLine(Value: Boolean);
  public
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor: TColor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData;
    procedure Click; override;
  published
    property GlowEffect: Boolean read FGlowEffect write FGlowEffect;
    property GlowSize: Integer read FGlowSize write FGlowSize;
    property UseUnderLine: Boolean read FUseUnderLine write SetUseUnderLine;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property DefaultActiveFontColor: TColor
      read FDefaultActiveFontColor write FDefaultActiveFontColor;
    property URL: String read FURL write FURL;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property Font;
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Layout;
    property Visible;
    property WordWrap;
    property OnClick;
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

 TbsSkinXFormButton = class(TbsSkinButton)
 private
   FDefImage: TBitMap;
   FDefActiveImage: TBitMap;
   FDefDownImage: TBitMap;
   FDefMask: TBitMap;
   FDefActiveFontColor: TColor;
   FDefDownFontColor: TColor;
   procedure SetDefImage(Value: TBitMap);
   procedure SetDefActiveImage(Value: TBitMap);
   procedure SetDefDownImage(Value: TBitMap);
   procedure SetDefMask(Value: TBitMap);
 protected
    procedure SetControlRegion; override;
    procedure DrawDefaultButton(C: TCanvas);
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure Loaded; override;
 public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   procedure ChangeSkinData; override;
   procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
 published
   property DefImage: TBitMap read FDefImage write SetDefImage;
   property DefActiveImage: TBitMap read FDefActiveImage write SetDefActiveImage;
   property DefDownImage: TBitMap read FDefDownImage write SetDefDownImage;
   property DefMask: TBitMap read FDefMask write SetDefMask;
   property DefActiveFontColor: TColor
    read FDefActiveFontColor write FDefActiveFontColor;
   property DefDownFontColor: TColor
    read FDefDownFontColor write FDefDownFontColor;
 end;

  TbsSkinShadowLabel = class(TbsGraphicSkinControl)
  private
    FDoubleBuffered: Boolean;
    FFocusControl: TWinControl;
    FAlignment: TAlignment;
    FAutoSize: Boolean;
    FLayout: TTextLayout;
    FWordWrap: Boolean;
    FShowAccelChar: Boolean;
    FUseSkinColor: Boolean;
    FShadowColor: TColor;
    FShadowSize: Integer;
    FShadowOffset: Integer;
    procedure SetShadowColor(Value: TColor);
    procedure SetShadowSize(Value: Integer);
    procedure SetShadowOffset(Value: Integer);
    procedure SetDoubleBuffered(Value: Boolean);
    procedure SetAlignment(Value: TAlignment);
    procedure SetFocusControl(Value: TWinControl);
    procedure SetShowAccelChar(Value: Boolean);
    procedure SetLayout(Value: TTextLayout);
    procedure SetWordWrap(Value: Boolean);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure AdjustBounds; dynamic;
    procedure DoDrawText(Cnvs: TCanvas; var Rect: TRect; Flags: Longint); dynamic;
    function GetLabelText: string; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
     Operation: TOperation); override;
    procedure Paint; override;
    procedure SetAutoSize(Value: Boolean);
    procedure WMMOVE(var Msg: TWMMOVE); message WM_MOVE;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ChangeSkinData; override;
  published
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property Layout: TTextLayout read FLayout write SetLayout default tlTop;
    property Alignment: TAlignment read FAlignment write SetAlignment
      default taLeftJustify;
    property FocusControl: TWinControl read FFocusControl write SetFocusControl;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default True;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property DoubleBuffered: Boolean read
      FDoubleBuffered write SetDoubleBuffered;
    property ShadowSize: Integer read FShadowSize write SetShadowSize;
    property ShadowOffset: Integer read FShadowOffset write SetShadowOffset;
    property ShadowColor: TColor read FShadowColor write SetShadowColor;
    property Caption;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
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

  TbsSkinVistaGlowLabel = class(TbsGraphicSkinControl)
  private
    FDoubleBuffered: Boolean;
    FFocusControl: TWinControl;
    FAlignment: TAlignment;
    FAutoSize: Boolean;
    FLayout: TTextLayout;
    FWordWrap: Boolean;
    FShowAccelChar: Boolean;
    FGlowColor: TColor;
    FGlowSize: Integer;
    procedure SetGlowColor(Value: TColor);
    procedure SetDoubleBuffered(Value: Boolean);
    procedure SetAlignment(Value: TAlignment);
    procedure SetFocusControl(Value: TWinControl);
    procedure SetShowAccelChar(Value: Boolean);
    procedure SetLayout(Value: TTextLayout);
    procedure SetWordWrap(Value: Boolean);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure AdjustBounds; dynamic;
    procedure DoDrawText(Cnvs: TCanvas; var Rect: TRect; Flags: Longint); dynamic;
    function GetLabelText: string; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
     Operation: TOperation); override;
    procedure Paint; override;
    procedure SetAutoSize(Value: Boolean);
    procedure WMMOVE(var Msg: TWMMOVE); message WM_MOVE;
    procedure ChangeSkinData; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property Layout: TTextLayout read FLayout write SetLayout default tlTop;
    property Alignment: TAlignment read FAlignment write SetAlignment
      default taLeftJustify;
    property FocusControl: TWinControl read FFocusControl write SetFocusControl;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default True;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property DoubleBuffered: Boolean read
      FDoubleBuffered write SetDoubleBuffered;
    property GlowColor: TColor read FGlowColor write SetGlowColor;
    property Caption;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
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


  TbsSkinButtonEx = class(TbsSkinButton)
  protected
    FTitleAlignment: TAlignment;
    FTitle: String;
    FGlowEffect: Boolean;
    FGlowSize: Integer;
    procedure SetTitle(Value: String);
    procedure SetTitleAlignment(Value: TAlignment);
    procedure CreateButtonImage(B: TBitMap; R: TRect;
      ADown, AMouseIn: Boolean); override;
    procedure CreateControlDefaultImage(B: TBitMap); override;  
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Title: String read FTitle write SetTitle;
    property TitleAlignment: TAlignment read FTitleAlignment write SetTitleAlignment;
    property GlowEffect: Boolean read FGlowEffect write FGlowEffect;
    property GlowSize: Integer read FGlowSize write FGlowSize;
  end;

  TbsSkinOfficeItem = class(TCollectionItem)
  private
    FImageIndex: TImageIndex;
    FTitle: String;
    FCaption: String;
    FEnabled: Boolean;
    FData: Pointer;
    FHeader: Boolean;
    FOnClick: TNotifyEvent;
    FChecked: Boolean;
  protected
    procedure SetImageIndex(const Value: TImageIndex); virtual;
    procedure SetTitle(const Value: String); virtual;
    procedure SetCaption(const Value: String); virtual;
    procedure SetData(const Value: Pointer); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
    procedure SetHeader(Value: Boolean); virtual;
    procedure SetChecked(Value: Boolean); virtual;
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
    property Checked: Boolean  read FChecked write SetChecked;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TbsSkinOfficeListBox = class;

  TbsSkinOfficeItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsSkinOfficeItem;
    procedure SetItem(Index: Integer; Value:  TbsSkinOfficeItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    OfficeListBox: TbsSkinOfficeListBox;
    constructor Create(AListBox: TbsSkinOfficeListBox);
    property Items[Index: Integer]: TbsSkinOfficeItem read GetItem write SetItem; default;
    function Add: TbsSkinOfficeItem;
    function Insert(Index: Integer): TbsSkinOfficeItem;
    procedure Delete(Index: Integer);
    procedure Clear;
  end;

  TbsDrawSkinOfficeItemEvent = procedure(Cnvs: TCanvas; Index: Integer;
    TextRct: TRect) of object;

  TbsSkinOfficeListBox = class(TbsSkinCustomControl)
  protected
    FCheckOffset: Integer;
    FShowCheckBoxes: Boolean;
    FInUpdateItems: Boolean;
    FOnDrawItem: TbsDrawSkinOfficeItemEvent;
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
    FItems: TbsSkinOfficeItems;
    FImages: TCustomImageList;
    FShowItemTitles: Boolean;
    FItemHeight: Integer;
    FHeaderHeight: Integer;
    FOldHeight: Integer;
    ScrollBar: TbsSkinScrollBar;
    FItemIndex: Integer;
    FOnItemClick: TNotifyEvent;
    FOnItemCheckClick: TNotifyEvent;
    FHeaderLeftAlignment: Boolean;
    FItemSkinDataName: String;
    FHeaderSkinDataName: String;
    procedure SkinDrawCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
    procedure SetShowCheckBoxes(Value: Boolean);
    procedure SetShowLines(Value: Boolean);
    procedure SetItemIndex(Value: Integer);
    procedure SetItemActive(Value: Integer);
    procedure SetItemHeight(Value: Integer);
    procedure SetHeaderHeight(Value: Integer);
    procedure SetHeaderLeftAlignment(Value: Boolean);
    procedure SetItems(Value: TbsSkinOfficeItems);
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

    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;

    procedure WndProc(var Message: TMessage); override;

    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure FindUp;
    procedure FindDown;
    procedure FindPageUp;
    procedure FindPageDown;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function CalcHeight(AItemCount: Integer): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ScrollToItem(Index: Integer);
    procedure Scroll(AScrollOffset: Integer);
    procedure GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
    procedure ChangeSkinData; override;
    procedure BeginUpdateItems;
    procedure EndUpdateItems;
  published
    property ShowCheckBoxes: Boolean
      read FShowCheckBoxes write SetShowCheckBoxes;
    property HeaderLeftAlignment: Boolean
     read FHeaderLeftAlignment write SetHeaderLeftAlignment;
    property HeaderSkinDataName: String
     read FHeaderSkinDataName write FHeaderSkinDataName;
    property ItemSkinDataName: String
      read FItemSkinDataName write FItemSkinDataName;
    property Items:  TbsSkinOfficeItems read FItems write SetItems;
    property Images: TCustomImageList read FImages write SetImages;
    property ShowItemTitles: Boolean
      read FShowItemTitles write SetShowItemTitles;
    property ItemHeight: Integer
      read FItemHeight write SetItemHeight;
    property HeaderHeight: Integer
      read FHeaderHeight write SetHeaderHeight;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property ShowLines: Boolean read FShowLines write SetShowLines;
    property MouseMoveChangeIndex: Boolean
      read FMouseMoveChangeIndex write FMouseMoveChangeIndex; 
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
    property OnDrawItem: TbsDrawSkinOfficeItemEvent
      read FOnDrawItem write FOnDrawItem;
    property OnItemClick: TNotifyEvent
      read FOnItemClick write FOnItemClick;
    property OnItemCheckClick: TNotifyEvent
      read FOnItemCheckClick write FOnItemCheckClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
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

  TbsPopupOfficeListBox = class(TbsSkinOfficeListBox)
  private
    FOldAlphaBlend: Boolean;
    FOldAlphaBlendValue: Byte;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Hide;
    procedure Show(Origin: TPoint);
  end;

  TbsSkinCustomOfficeComboBox = class(TbsSkinCustomControl)
  protected
    FOnDrawItem: TbsDrawSkinOfficeItemEvent;
    FShowItemTitle: Boolean;
    FShowItemImage: Boolean;
    FShowItemText: Boolean;
    FDropDownCount: Integer;
    FDropDown: Boolean;
    FToolButtonStyle: Boolean;
    FDefaultColor: TColor;
    FUseSkinSize: Boolean;
    WasInLB: Boolean;
    TimerMode: Integer;
    FListBoxWidth: Integer;
    FListBoxHeight: Integer;
    FHideSelection: Boolean;
    FLastTime: Cardinal;

    FAlphaBlend: Boolean;
    FAlphaBlendAnimation: Boolean;
    FAlphaBlendValue: Byte;

    FOnChange: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnCloseUp: TNotifyEvent;
    FOnDropDown: TNotifyEvent;

    FMouseIn: Boolean;
    FOldItemIndex: Integer;
    FLBDown: Boolean;
    //
    FListBox: TbsPopupOfficeListBox;
    FListBoxWindowProc: TWndMethod;
    //
    CBItem: TbsCBItem;
    Button: TbsCBButtonX;

    procedure SetShowItemTitle(Value: Boolean);
    procedure SetShowItemImage(Value: Boolean);
    procedure SetShowItemText(Value: Boolean);

    procedure ListBoxWindowProcHook(var Message: TMessage);

    procedure DrawMenuMarker(C: TCanvas; R: TRect; AActive, ADown: Boolean;
     ButtonData: TbsDataSkinButtonControl);

    procedure ProcessListBox;
    procedure StartTimer;
    procedure StopTimer;

    function GetListBoxHeaderLeftAlignment: Boolean;
    procedure SetListBoxHeaderLeftAlignment(Value: Boolean);

    function GetImages: TCustomImageList;
    procedure SetImages(Value: TCustomImageList);

    function GetListBoxDefaultFont: TFont;
    procedure SetListBoxDefaultFont(Value: TFont);

    function GetListBoxUseSkinFont: Boolean;
    procedure SetListBoxUseSkinFont(Value: Boolean);

    procedure CheckButtonClick(Sender: TObject);

    procedure DrawDefaultItem(Cnvs: TCanvas);
    procedure DrawSkinItem(Cnvs: TCanvas);
    procedure DrawResizeSkinItem(Cnvs: TCanvas);

    function GetItemIndex: Integer;
    procedure SetItemIndex(Value: Integer);

    procedure SetItems(Value: TbsSkinOfficeItems);
    function GetItems: TbsSkinOfficeItems;

    procedure SetDropDownCount(Value: Integer);
    procedure DrawButton(C: TCanvas);
    procedure DrawResizeButton(C: TCanvas);
    procedure CalcRects;
    procedure WMTimer(var Message: TWMTimer); message WM_Timer; 
    procedure WMSETFOCUS(var Message: TMessage); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    procedure GetSkinData; override;
    procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;

    procedure DefaultFontChange; override;
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;

    procedure CreateControlDefaultImage2(B: TBitMap);
    procedure CreateControlSkinImage2(B: TBitMap);
    procedure CreateControlToolSkinImage(B: TBitMap; AText: String);
    procedure CreateControlToolDefaultImage(B: TBitMap; AText: String);

    procedure Change; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CalcSize(var W, H: Integer); override;
    procedure SetControlRegion; override;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure SetDefaultColor(Value: TColor);
    function GetDisabledFontColor: TColor;
    procedure SetToolButtonStyle(Value: Boolean);

    procedure EditUp1(AChange: Boolean);
    procedure EditDown1(AChange: Boolean);
    procedure EditPageUp1(AChange: Boolean);
    procedure EditPageDown1(AChange: Boolean);
    //
    function GetListBoxSkinDataName: String;
    procedure SetListBoxSkinDataName(Value: String);
    function GetListBoxShowLines: Boolean;
    procedure SetListBoxShowLines(Value: Boolean);
    function GetListBoxItemHeight: Integer;
    procedure SetListBoxItemHeight(Value: Integer);
    function GetListBoxHeaderHeight: Integer;
    procedure SetListBoxHeaderHeight(Value: Integer);
    function GetListBoxShowItemTitles: Boolean;
    procedure SetListBoxShowItemTitles(Value: Boolean);
    //
  public
    ActiveSkinRect: TRect;
    ActiveFontColor: TColor;
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    SItemRect, FocusItemRect, ActiveItemRect: TRect;
    ItemLeftOffset, ItemRightOffset: Integer;
    ItemTextRect: TRect;
    FontColor, FocusFontColor: TColor;
    ButtonRect,
    ActiveButtonRect,
    DownButtonRect, UnEnabledButtonRect: TRect;
    ListBoxName: String;
    ItemStretchEffect, FocusItemStretchEffect: Boolean;
    ShowFocus: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginUpdateItems;
    procedure EndUpdateItems;
    procedure PaintSkinTo(C: TCanvas; X, Y: Integer; AText: String);
    procedure ChangeSkinData; override;
    procedure CloseUp(Value: Boolean);
    procedure DropDown; virtual;
    function IsPopupVisible: Boolean;
    function CanCancelDropDown: Boolean;
    procedure Invalidate; override;
    property ToolButtonStyle: Boolean
      read FToolButtonStyle write SetToolButtonStyle;
    property HideSelection: Boolean
      read FHideSelection write FHideSelection;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property Images: TCustomImageList read GetImages write SetImages;
    //
    property ShowItemTitle: Boolean read FShowItemTitle write SetShowItemTitle;
    property ShowItemImage: Boolean read FShowItemImage write SetShowItemImage;
    property ShowItemText: Boolean read FShowItemText write SetShowItemText;
    //
    property ListBoxHeaderLeftAlignment: Boolean
     read GetListBoxHeaderLeftAlignment
     write SetListBoxHeaderLeftAlignment;
    property ListBoxWidth: Integer read FListBoxWidth write FListBoxWidth;
    property ListBoxHeight: Integer read FListBoxHeight write FListBoxHeight;
    property ListBoxDefaultFont: TFont
      read GetListBoxDefaultFont write SetListBoxDefaultFont;
    property ListBoxUseSkinFont: Boolean
      read GetListBoxUseSkinFont write SetListBoxUseSkinFont;
    property ListBoxShowItemTitles: Boolean
      read GetListBoxShowItemTitles write SetListBoxShowItemTitles;
    property ListBoxSkinDataName: String read
      GetListBoxSkinDataName write SetListBoxSkinDataName;
    property ListBoxShowLines: Boolean
      read GetListBoxShowLines write SetListBoxShowLines;
    property ListBoxItemHeight: Integer
      read GetListBoxItemHeight write SetListBoxItemHeight;
    property ListBoxHeaderHeight: Integer
      read GetListBoxHeaderHeight write SetListBoxHeaderHeight;
    //
    property Enabled;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    //
    property DefaultColor: TColor read FDefaultColor write SetDefaultColor;
    property Align;
    property Items: TbsSkinOfficeItems read GetItems write SetItems;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property DropDownCount: Integer read FDropDownCount write SetDropDownCount;
    property OnDrawItem: TbsDrawSkinOfficeItemEvent
      read FOnDrawItem write FOnDrawItem;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnEnter;
    property OnExit;
  published
    property UseSkinSize: Boolean read FUseSkinSize write FUseSkinSize;
  end;

  TbsSkinOfficeComboBox = class(TbsSkinCustomOfficeComboBox)
  published
    property ToolButtonStyle;
    property AlphaBlend;
    property AlphaBlendValue;
    property AlphaBlendAnimation;
    property ListBoxHeaderLeftAlignment;
    property ListBoxDefaultFont;
    property ListBoxUseSkinFont;
    property ListBoxWidth;
    property ListBoxHeight;
    property ListBoxShowItemTitles;
    property ListBoxSkinDataName;
    property ListBoxShowLines;
    property ListBoxItemHeight;
    property ListBoxHeaderHeight;

    property HideSelection;
    property Images;

    property Enabled;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    //
    property ShowItemTitle;
    property ShowItemImage;
    property ShowItemText;
    //
    property DefaultColor;
    property Align;
    property Items;
    property ItemIndex;
    property DropDownCount;
    property Font;
    property OnDrawItem;
    property OnChange;
    property OnClick;
    property OnCloseUp;
    property OnDropDown;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnEnter;
    property OnExit;
  end;

  // ===========================================================================

  TbsSkinLinkBarItem = class(TCollectionItem)
  private
    FImageIndex: TImageIndex;
    FActiveImageIndex: TImageIndex;
    FUseCustomGlowColor: Boolean;
    FCustomGlowColor: TColor;
    FCaption: String;
    FEnabled: Boolean;
    FHeader: Boolean;
    FOnClick: TNotifyEvent;
  protected
    procedure SetImageIndex(const Value: TImageIndex); virtual;
    procedure SetActiveImageIndex(const Value: TImageIndex); virtual;
    procedure SetCaption(const Value: String); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
    procedure SetHeader(Value: Boolean); virtual;
  public
    ItemRect: TRect;
    IsVisible: Boolean;
    Active: Boolean;
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Header: Boolean read FHeader write SetHeader;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Caption: String read FCaption write SetCaption;
    property ImageIndex: TImageIndex read FImageIndex
      write SetImageIndex default -1;
    property ActiveImageIndex: TImageIndex read FActiveImageIndex
      write SetActiveImageIndex default -1;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property UseCustomGlowColor: Boolean
      read FUseCustomGlowColor write FUseCustomGlowColor;
    property CustomGlowColor: TColor
      read FCustomGlowColor write FCustomGlowColor;
  end;

  TbsSkinLinkBar = class;

  TbsSkinLinkBarItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsSkinLinkBarItem;
    procedure SetItem(Index: Integer; Value:  TbsSkinLinkBarItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    LinkBar: TbsSkinLinkBar;
    constructor Create(AListBox: TbsSkinLinkBar);
    property Items[Index: Integer]: TbsSkinLinkBarItem read GetItem write SetItem; default;
    function Add: TbsSkinLinkBarItem;
    function Insert(Index: Integer): TbsSkinLinkBarItem;
    procedure Delete(Index: Integer);
    procedure Clear;
  end;

  TbsSkinLinkBar = class(TbsSkinCustomControl)
  protected
    FHeaderLeftAlignment: Boolean;
    FHeaderSkinDataName: String;
    FHeaderBold: Boolean;
    FGlowEffect: Boolean;
    FGlowSize: Integer;
    FShowTextUnderLine: Boolean;
    FHoldSelectedItem: Boolean;
    FShowBlurMarker: Boolean;
    FSpacing: Integer;
    FDisabledFontColor: TColor;
    FShowLines: Boolean;
    FClicksDisabled: Boolean;
    FMouseDown: Boolean;
    FMouseActive: Integer;
    FMax: Integer;
    FRealMax: Integer;
    FItemsRect: TRect;
    FScrollOffset: Integer;
    FItems: TbsSkinLinkBarItems;
    FImages: TCustomImageList;
    FShowItemTitles: Boolean;
    FItemHeight: Integer;
    FHeaderHeight: Integer;
    FOldHeight: Integer;
    ScrollBar: TbsSkinScrollBar;
    FItemIndex: Integer;
    FOnItemClick: TNotifyEvent;
    //
    FSkinActiveFontColor: TColor;
    FSkinFontColor: TColor;
    //
    procedure SetHoldSelectedItem(Value: Boolean);
    procedure GetSkinData; override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetShowLines(Value: Boolean);
    procedure SetItemIndex(Value: Integer);
    procedure SetItemActive(Value: Integer);
    procedure SetItemHeight(Value: Integer);
    procedure SetHeaderHeight(Value: Integer);
    procedure SetHeaderLeftAlignment(Value: Boolean);
    procedure SetItems(Value: TbsSkinLinkBarItems);
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

    procedure WndProc(var Message: TMessage); override;

    function CalcHeight(AItemCount: Integer): Integer;
    procedure SetSpacing(Value: Integer);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ScrollToItem(Index: Integer);
    procedure Scroll(AScrollOffset: Integer);
    procedure GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
    procedure ChangeSkinData; override;

  published
    property HeaderLeftAlignment: Boolean
      read FHeaderLeftAlignment write SetHeaderLeftAlignment;
    property HeaderSkinDataName: String
      read FHeaderSkinDataName write FHeaderSkinDataName;
    property HeaderBold: Boolean
     read FHeaderBold write FHeaderBold;
    property GlowEffect: Boolean read FGlowEffect write FGlowEffect;
    property GlowSize: Integer read FGlowSize write FGlowSize;
    property ShowTextUnderLine: Boolean
      read FShowTextUnderLine write FShowTextUnderLine;
    property HoldSelectedItem: Boolean
      read FHoldSelectedItem write SetHoldSelectedItem;
      
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property ShowBlurMarker: Boolean
      read FShowBlurMarker write FShowBlurMarker;
    property Spacing: Integer
     read FSpacing write SetSpacing;
    property Items:  TbsSkinLinkBarItems read FItems write SetItems;
    property Images: TCustomImageList read FImages write SetImages;
    property ShowItemTitles: Boolean
      read FShowItemTitles write SetShowItemTitles;
    property ItemHeight: Integer
      read FItemHeight write SetItemHeight;
    property HeaderHeight: Integer
      read FHeaderHeight write SetHeaderHeight;
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


  // TbsSkinToolBarEx ==========================================================
  TbsSkinToolBarExItem = class(TCollectionItem)
  private
    FHint: String;
    FImageIndex: TImageIndex;
    FActiveImageIndex: TImageIndex;
    FEnabled: Boolean;
    FOnClick: TNotifyEvent;
    FUseCustomGlowColor: Boolean;
    FCustomGlowColor: TColor;
  protected
    procedure SetImageIndex(const Value: TImageIndex); virtual;
    procedure SetActiveImageIndex(const Value: TImageIndex); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
  public
    ItemRect: TRect;
    IsVisible: Boolean;
    Active: Boolean;
    Down: Boolean;
    FReflectionBitmap: TbsBitmap;
    FReflectionActiveBitmap: TbsBitmap;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure InitReflectionBitmaps;
  published
    property UseCustomGlowColor: Boolean
      read FUseCustomGlowColor write FUseCustomGlowColor;
    property CustomGlowColor: TColor
      read FCustomGlowColor write FCustomGlowColor;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Hint: String read FHint write FHint;
    property ImageIndex: TImageIndex read FImageIndex
      write SetImageIndex default -1;
    property ActiveImageIndex: TImageIndex read FActiveImageIndex
      write SetActiveImageIndex default -1;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TbsSkinToolBarEx = class;

  TbsSkinToolBarExItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsSkinToolBarExItem;
    procedure SetItem(Index: Integer; Value:  TbsSkinToolBarExItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    ToolBarEx: TbsSkinToolBarEx;
    constructor Create(AListBox: TbsSkinToolBarEx);
    property Items[Index: Integer]: TbsSkinToolBarExItem read GetItem write SetItem; default;
    function Add: TbsSkinToolBarExItem;
    function Insert(Index: Integer): TbsSkinToolBarExItem;
    procedure Delete(Index: Integer);
    procedure Clear;
  end;

  TbsMenuExPosition = (bsmpAuto, bsmpTop, bsmpBottom);

  TbsSkinToolBarEx = class(TbsSkinCustomControl)
  protected
    Buttons: array [0..1] of TbsControlButton;
    //
    FMenuExPosition: TbsMenuExPosition;
    //
    FSkinActiveArrowColor: TColor;
    FSkinArrowColor: TColor;
    //
    FOnChange: TNotifyEvent;
    FItemIndex: Integer;
    FHoldSelectedItem: Boolean;
    FScrollIndex, FScrollMax: Integer;
    FShowBorder: Boolean;
    FCursorColor: TColor;
    FAutoSize: Boolean;
    FSkinHint: TbsSkinHint;
    FShowActiveCursor: Boolean;
    FItemSpacing: Integer;
    FItems: TbsSkinToolBarExItems;
    FImages: TbsPngImageList;
    FArrowImages: TbsPngImageList;
    FShowItemHints: Boolean;
    FShowHandPointCursor: Boolean;
    FShowGlow: Boolean;
    function GetVisibleCount: Integer;
    procedure DrawButtons(Cnvs: TCanvas);
    procedure CheckScroll;
    function ItemAtPos(X, Y: Integer): Integer;
    procedure SetShowBorder(Value: Boolean);
    procedure SetAutoSize(Value: Boolean);
    procedure SetItemSpacing(Value: Integer);
    procedure SetItems(Value: TbsSkinToolBarExItems);
    procedure SetImages(Value: TbsPngImageList);
    procedure SetArrowImages(Value: TbsPngImageList);
    //
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    //
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure DrawItem(Cnvs: TCanvas; Index: Integer);
    procedure CalcItemRects;
    procedure Loaded; override;
    procedure TestActive(X, Y: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
     procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure AdjustBounds;
    procedure GetSkinData; override;
    procedure SetItemIndex(Value: Integer);
    procedure SetShowGlow(Value: Boolean);
  public
    MouseInItem, OldMouseInItem: Integer;
    procedure DecScroll;
    procedure IncScroll;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdatedSelected;
    procedure BeginUpdateItems;
    procedure EndUpdateItems;
  published
    property MenuExPosition: TbsMenuExPosition
      read FMenuExPosition write FMenuExPosition;
    property ShowGlow: Boolean read
      FShowGlow write SetShowGlow; 
    property HoldSelectedItem: Boolean
      read FHoldSelectedItem write FHoldSelectedItem;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property SkinHint: TbsSkinHint read FSkinHint write FSkinHint;
    property ShowBorder: Boolean
      read FShowBorder write SetShowBorder;
    property ShowHandPointCursor: Boolean
      read FShowHandPointCursor write FShowHandPointCursor;
    property ShowActiveCursor: Boolean
      read FShowActiveCursor write FShowActiveCursor;
    property ItemSpacing: Integer read FItemSpacing write SetItemSpacing;
    property ShowItemHints: Boolean read FShowItemHints write FShowItemHints;
    property Images: TbsPngImageList read FImages write SetImages;
    property ArrowImages: TbsPngImageList read FArrowImages write SetArrowImages;
    property Items:  TbsSkinToolBarExItems read FItems write SetItems;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property PopupMenu;
    property Visible;
    property OnClick;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
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

  TbsSkinMenuEx = class;

  TbsSkinMenuExItem = class(TCollectionItem)
  private
    FImageIndex: TImageIndex;
    FActiveImageIndex: TImageIndex;
    FHint: String;
    FUseCustomGlowColor: Boolean;
    FCustomGlowColor: TColor;
    FOnClick: TNotifyEvent;
  protected
    procedure SetImageIndex(const Value: TImageIndex); virtual;
    procedure SetActiveImageIndex(const Value: TImageIndex); virtual;
  public
    ItemRect: TRect;
    FColor: TColor;
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property UseCustomGlowColor: Boolean
      read FUseCustomGlowColor write FUseCustomGlowColor;
    property CustomGlowColor: TColor
      read FCustomGlowColor write FCustomGlowColor;
    property Hint: String read FHint write FHint;
    property ImageIndex: TImageIndex read FImageIndex
      write SetImageIndex default -1;
    property ActiveImageIndex: TImageIndex read FActiveImageIndex
      write SetActiveImageIndex default -1;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TbsSkinMenuExItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsSkinMenuExItem;
    procedure SetItem(Index: Integer; Value:  TbsSkinMenuExItem);
  protected
    function GetOwner: TPersistent; override;
  public
    MenuEx: TbsSkinMenuEx;
    constructor Create(AMenuEx: TbsSkinMenuEx);
    property Items[Index: Integer]:  TbsSkinMenuExItem read GetItem write SetItem; default;
  end;

  TbsSkinMenuExPopupWindow = class(TCustomControl)
  private
    FSkinSupport: Boolean;
    OldAppMessage: TMessageEvent;
    MenuEx: TbsSkinMenuEx;
    FRgn: HRGN;
    NewLTPoint, NewRTPoint,
    NewLBPoint, NewRBPoint: TPoint;
    NewItemsRect: TRect;
    WindowPicture, MaskPicture: TBitMap;
    MouseInItem, OldMouseInItem: Integer;
    FDown: Boolean;
    FItemDown: Boolean;
    procedure AssignItemRects;
    procedure CreateMenu;
    procedure HookApp;
    procedure UnHookApp;
    procedure NewAppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure SetMenuWindowRegion;
    procedure DrawItems(ActiveIndex, SelectedIndex: Integer; C: TCanvas);
    function GetItemRect(Index: Integer): TRect;
    function GetItemFromPoint(P: TPoint): Integer;
    procedure TestActive(X, Y: Integer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure WMEraseBkGrnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure WndProc(var Message: TMessage); override;
    procedure ProcessKey(KeyCode: Integer);
    procedure FindLeft;
    procedure FindRight;
    procedure FindUp;
    procedure FindDown;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Show(PopupRect: TRect);
    procedure Hide(AProcessEvents: Boolean);
    procedure Paint; override;
 end;

  TbsSkinMenuEx = class(TComponent)
  private
    FShowActiveCursor: Boolean;
    FShowGlow: Boolean;
    FImages: TbsPngImageList;
    FItems: TbsSkinMenuExItems;
    FItemIndex: Integer;
    FColumnsCount: Integer;
    FOnItemClick: TNotifyEvent;
    FSkinData: TbsSkinData;
    FPopupWindow: TbsSkinMenuExPopupWindow;
    FOldItemIndex: Integer;
    FOnChange: TNotifyEvent;
    FAlphaBlend: Boolean;
    FAlphaBlendAnimation: Boolean;
    FAlphaBlendValue: Byte;
    FOnInternalChange: TNotifyEvent;
    FOnMenuClose: TNotifyEvent;
    FOnMenuPopup: TNotifyEvent;
    FOnInternalMenuClose: TNotifyEvent;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FSkinHint: TbsSkinHint;
    FShowHints: Boolean;
    procedure SetDefaultFont(Value: TFont);
    procedure SetItems(Value: TbsSkinMenuExItems);
    procedure SetImages(Value: TbsPngImageList);
    procedure SetColumnsCount(Value: Integer);
    procedure SetSkinData(Value: TbsSkinData);
    function GetSelectedItem: TbsSkinMenuExItem;
  protected
    ToolBarEx: TbsSkinToolBarEx;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ProcessEvents(ACanProcess: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Popup(AToolBarEx: TbsSkinToolBarEx); overload;
    procedure Popup(X, Y: Integer); overload;
    procedure Hide;
    property SelectedItem: TbsSkinMenuExItem read GetSelectedItem;
    property OnInternalChange: TNotifyEvent read FOnInternalChange write FOnInternalChange;
    property OnInternalMenuClose: TNotifyEvent read FOnInternalMenuClose write FOnInternalMenuClose;
    property ItemIndex: Integer read FItemIndex write FItemIndex;
  published
    property ShowActiveCursor: Boolean read
      FShowActiveCursor write FShowActiveCursor;
    property ShowGlow: Boolean read FShowGlow write FShowGlow;
    property Images: TbsPngImageList read FImages write SetImages;
    property SkinHint: TbsSkinHint read FSkinHint write FSkinHint;
    property ShowHints: Boolean read FShowHints write FShowHints;
    property Items: TbsSkinMenuExItems read FItems write SetItems;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property ColumnsCount: Integer read FColumnsCount write SetColumnsCount;
    property SkinData: TbsSkinData read FSkinData write SetSkinData;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnMenuPopup: TNotifyEvent read FOnMenuPopup write FOnMenuPopup;
    property OnMenuClose: TNotifyEvent read FOnMenuClose write FOnMenuClose;
  end;   

  // TbsSkinHorzListBox

  TbsSkinHorzListBox = class;
  
  TbsSkinHorzItem = class(TCollectionItem)
  private
    FImageIndex: TImageIndex;
    FCaption: String;
    FEnabled: Boolean;
    FData: Pointer;
    FOnClick: TNotifyEvent;
  protected
    procedure SetImageIndex(const Value: TImageIndex); virtual;
    procedure SetCaption(const Value: String); virtual;
    procedure SetData(const Value: Pointer); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
  public
    ItemRect: TRect;
    IsVisible: Boolean;
    Active: Boolean;
    constructor Create(Collection: TCollection); override;
    property Data: Pointer read FData write SetData;
    procedure Assign(Source: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Caption: String read FCaption write SetCaption;
    property ImageIndex: TImageIndex read FImageIndex
      write SetImageIndex default -1;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TbsSkinHorzItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsSkinHorzItem;
    procedure SetItem(Index: Integer; Value:  TbsSkinHorzItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    HorzListBox: TbsSkinHorzListBox;
    constructor Create(AListBox: TbsSkinHorzListBox);
    property Items[Index: Integer]: TbsSkinHorzItem read GetItem write SetItem; default;
    function Add: TbsSkinHorzItem;
    function Insert(Index: Integer): TbsSkinHorzItem;
    procedure Delete(Index: Integer);
    procedure Clear;
  end;

  TbsSkinHorzListBox = class(TbsSkinCustomControl)
  protected
    FInUpdateItems: Boolean;
    FOnDrawItem: TbsDrawSkinOfficeItemEvent;
    FShowGlow: Boolean;
    FItemLayout: TbsButtonLayout;
    FItemMargin: Integer;
    FItemSpacing: Integer;
    FMouseMoveChangeIndex: Boolean;
    FDisabledFontColor: TColor;
    FClicksDisabled: Boolean;
    FMouseDown: Boolean;
    FMouseActive: Integer;
    FMax: Integer;
    FRealMax: Integer;
    FItemsRect: TRect;
    FScrollOffset: Integer;
    FItems: TbsSkinHorzItems;
    FImages: TCustomImageList;
    FShowItemTitles: Boolean;
    FItemWidth: Integer;
    FOldWidth: Integer;
    ScrollBar: TbsSkinScrollBar;
    FItemIndex: Integer;
    FOnItemClick: TNotifyEvent;
    procedure SetShowGlow(Value: Boolean);
    procedure SetItemLayout(Value: TbsButtonLayout);
    procedure SetItemMargin(Value: Integer);
    procedure SetItemSpacing(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetItemActive(Value: Integer);
    procedure SetItemWidth(Value: Integer);
    procedure SetItems(Value: TbsSkinHorzItems);
    procedure SetImages(Value: TCustomImageList);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetShowItemTitles(Value: Boolean);  public

    procedure DrawItem(Index: Integer; Cnvs: TCanvas);

    procedure SkinDrawItem(Index: Integer; Cnvs: TCanvas);
    procedure DefaultDrawItem(Index: Integer; Cnvs: TCanvas);

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

    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;

    procedure WndProc(var Message: TMessage); override;

    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure FindUp;
    procedure FindDown;
    procedure FindPageUp;
    procedure FindPageDown;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function CalcWidth(AItemCount: Integer): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ScrollToItem(Index: Integer);
    procedure Scroll(AScrollOffset: Integer);
    procedure GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
    procedure ChangeSkinData; override;
    procedure BeginUpdateItems;
    procedure EndUpdateItems;
  published
    property ShowGlow: Boolean read FShowGlow write SetShowGlow;
    property ItemLayout: TbsButtonLayout read FItemLayout write SetItemLayout;
    property ItemMargin: Integer read FItemMargin write SetItemMargin;
    property ItemSpacing: Integer read FItemSpacing write SetItemSpacing;
    property Items:  TbsSkinHorzItems read FItems write SetItems;
    property Images: TCustomImageList read FImages write SetImages;
    property ShowItemTitles: Boolean
      read FShowItemTitles write SetShowItemTitles;
    property ItemWidth: Integer
      read FItemWidth write SetItemWidth;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property MouseMoveChangeIndex: Boolean
      read FMouseMoveChangeIndex write FMouseMoveChangeIndex; 
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
    property OnDrawItem: TbsDrawSkinOfficeItemEvent
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
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TbsSkinDividerType = (bstdtVerticalLine, bstdtHorizontalLine);

  TbsSkinDivider = class(TbsGraphicSkinControl)
  private
    FDividerType: TbsSkinDividerType;
    procedure SetDividerType(Value: TbsSkinDividerType);
  protected
    procedure GetSkinData; override;
    procedure DrawLineV;
    procedure DrawLineH;
  public
    DarkColor: TColor;
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
  published
    property DividerType: TbsSkinDividerType
      read FDividerType write SetDividerType;
    property Align;
  end;

 TbsSkinGraphicButton = class(TbsSkinMenuSpeedButton)
 protected
   FGraphicMenu: TbsSkinImagesMenu;
   FGraphicImages: TCustomImageList;

   procedure InitImages; virtual;
   procedure InitItems; virtual;

   function GetMenuDefaultFont: TFont;
   procedure SetMenuDefaultFont(Value: TFont);
   function GetMenuUseSkinFont: Boolean;
   procedure SetMenuUseSkinFont(Value: Boolean);
   function GetMenuAlphaBlend: Boolean;
   procedure SetMenuAlphaBlend(Value: Boolean);
   function GetMenuAlphaBlendAnimation: Boolean;
   procedure SetMenuAlphaBlendAnimation(Value: Boolean);
   function GetMenuAlphaBlendValue: Integer;
   procedure SetMenuAlphaBlendValue(Value: Integer);

   function GetMenuShowHints: Boolean;
   procedure SetMenuShowHints(Value: Boolean);

   function GetMenuSkinHint: TbsSkinHint;
   procedure SetMenuSkinHint(Value: TbsSkinHint);

   function GetGraphicMenuItems: TbsImagesMenuItems;
   function GetSelectedItem: TbsImagesMenuItem;

   function GetItemIndex: Integer;
   procedure SetItemIndex(Value: Integer);

   procedure Loaded; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SelectedItem: TbsImagesMenuItem read GetSelectedItem;
  published
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property MenuSkinHint: TbsSkinHint read GetMenuSkinHint write SetMenuSkinHint;
    property MenuShowHints: Boolean read GetMenuShowHints write SetMenuShowHints;
    property GraphicItems: TbsImagesMenuItems read GetGraphicMenuItems;
    property MenuUseSkinFont: Boolean read GetMenuUseSkinFont write SetMenuUseSkinFont;
    property MenuDefaultFont: TFont read GetMenuDefaultFont write SetMenuDefaultFont;
    property MenuAlphaBlend: Boolean read GetMenuAlphaBlend write SetMenuAlphaBlend;
    property MenuAlphaBlendValue: Integer read GetMenuAlphaBlendValue write SetMenuAlphaBlendValue;
    property MenuAlphaBlendAnimation: Boolean read GetMenuAlphaBlendAnimation write SetMenuAlphaBlendAnimation;
  end;

 TbsSkinGradientStyleButton = class(TbsSkinGraphicButton)
 protected
   procedure InitImages; override;
   procedure InitItems; override;
 end;

 TbsSkinBrushStyleButton = class(TbsSkinGraphicButton)
 protected
   procedure InitImages; override;
   procedure InitItems; override;
 end;

 TbsSkinPenStyleButton = class(TbsSkinGraphicButton)
 protected
   procedure InitImages; override;
   procedure InitItems; override;
 end;

 TbsSkinPenWidthButton = class(TbsSkinGraphicButton)
 protected
   procedure InitImages; override;
   procedure InitItems; override;
 end;

 TbsSkinShadowStyleButton = class(TbsSkinGraphicButton)
 protected
   procedure InitImages; override;
   procedure InitItems; override;
 end;


// TbsSkinOfficeGallery ========================================================
                      
  TbsSkinGalleryButton = class(TbsSkinButton)
  protected
    procedure GetSkinData; override;
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure CreateButtonImage(B: TBitMap; R: TRect;
      ADown, AMouseIn: Boolean); override;
  end;

  TbsSkinOfficeGallery = class;

  TbsSkinOfficeGalleryItem = class(TCollectionItem)
  private
    FImageIndex: TImageIndex;
    FCaption: String;
    FData: Pointer;
    FOnClick: TNotifyEvent;
  protected
    procedure SetImageIndex(const Value: TImageIndex); virtual;
    procedure SetCaption(const Value: String); virtual;
    procedure SetData(const Value: Pointer); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
  public
    ItemRect: TRect;
    IsVisible: Boolean;
    Active: Boolean;
    MouseIn: Boolean;
    //
    PopupItemRect: TRect;
    PopupIsVisible: Boolean;
    PopupActive: Boolean;
    PopupMouseIn: Boolean;
    //
    constructor Create(Collection: TCollection); override;
    property Data: Pointer read FData write SetData;
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: String read FCaption write SetCaption;
    property ImageIndex: TImageIndex read FImageIndex
      write SetImageIndex default -1;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TbsSkinOfficeGalleryItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsSkinOfficeGalleryItem;
    procedure SetItem(Index: Integer; Value:  TbsSkinOfficeGalleryItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    OfficeGallery: TbsSkinOfficeGallery;
    constructor Create(AOfficeGallery: TbsSkinOfficeGallery);
    property Items[Index: Integer]: TbsSkinOfficeGalleryItem read GetItem write SetItem; default;
    function Add: TbsSkinOfficeGalleryItem;
    function Insert(Index: Integer): TbsSkinOfficeGalleryItem;
    procedure Delete(Index: Integer);
    procedure Clear;
  end;

  TbsSkinPopupOfficeGallery = class;

  TbsSkinOfficeGallery = class(TbsSkinCustomControl)
  protected
    FPopupGallery: TbsSkinPopupOfficeGallery;
    FPopupMaxRowCount: Integer;
    FMouseInItem, FOldMouseInItem: Integer;
    FStartIndex: Integer;
    FOnDrawItem: TbsDrawSkinOfficeItemEvent;
    FItemLayout: TbsButtonLayout;
    FItemMargin: Integer;
    FItemSpacing: Integer;
    FClicksDisabled: Boolean;
    FMouseDown: Boolean;
    FMouseActive: Integer;
    //
    FItemsRect: TRect;
    RowCount, ColCount, ItemsInPage: Integer;
    //
    FItems: TbsSkinOfficeGalleryItems;
    FImages: TCustomImageList;
    FItemWidth: Integer;
    FItemHeight: Integer;
    FOldWidth: Integer;
    UpDown: TbsSkinUpDown;
    DownButton: TbsSkinGalleryButton;
    FItemIndex: Integer;
    FOnItemClick: TNotifyEvent;
    procedure TestActive(MouseInIndex: Integer);
    procedure SetItemLayout(Value: TbsButtonLayout);
    procedure SetItemMargin(Value: Integer);
    procedure SetItemSpacing(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetItemActive(Value: Integer);
    procedure SetItemWidth(Value: Integer);
    procedure SetItemHeight(Value: Integer);
    procedure SetItems(Value: TbsSkinOfficeGalleryItems);
    procedure SetImages(Value: TCustomImageList);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;

    procedure DrawItem(Index: Integer; Cnvs: TCanvas);

    procedure SkinDrawItem(Index: Integer; Cnvs: TCanvas);
    procedure DefaultDrawItem(Index: Integer; Cnvs: TCanvas);

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure CalcItemRects;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure ShowUpDown;
    procedure HideUpDown;
    procedure UpdateScrollInfo;
    procedure AdjustButtons;
    procedure OnUpButtonClick(Sender: TObject);
    procedure OnDownButtonClick(Sender: TObject);
    procedure OnButtonClick(Sender: TObject);
    procedure Loaded; override;
    function ItemAtPos(X, Y: Integer): Integer;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;

    procedure WndProc(var Message: TMessage); override;

    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure FindUp;
    procedure FindDown;
    procedure FindLeft;
    procedure FindRight;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure ShowPopupGallery;
    procedure HidePopupGallery;

    procedure BeginUpdateItems;
    procedure EndUpdateItems;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ScrollToItem(Index: Integer);
    procedure Scroll(AScrollOffset: Integer);
    procedure GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
    procedure ChangeSkinData; override;
  published
    property PopupMaxRowCount: Integer
      read FPopupMaxRowCount write FPopupMaxRowCount;
    property ItemLayout: TbsButtonLayout read FItemLayout write SetItemLayout;
    property ItemMargin: Integer read FItemMargin write SetItemMargin;
    property ItemSpacing: Integer read FItemSpacing write SetItemSpacing;
    property Items:  TbsSkinOfficeGalleryItems read FItems write SetItems;
    property Images: TCustomImageList read FImages write SetImages;
    property ItemWidth: Integer
      read FItemWidth write SetItemWidth;
    property ItemHeight: Integer
      read FItemHeight write SetItemHeight;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
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
    property OnDrawItem: TbsDrawSkinOfficeItemEvent
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
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TbsSkinPopupOfficeGallery = class(TbsSkinCustomControl)
  protected
    FInUpdateItems: Boolean;
    FScrollOffset: Integer;
    FGallery: TbsSkinOfficeGallery;
    FMouseInItem, FOldMouseInItem: Integer;
    FStartIndex: Integer;
    FMouseDown: Boolean;
    FMouseActive: Integer;
    FMax: Integer;
    FRealMax: Integer;
    //
    FItemsRect: TRect;
    RowCount, ColCount, ItemsInPage: Integer;
    //
    FOldWidth: Integer;
    ScrollBar: TbsSkinScrollBar;
    FItemIndex: Integer;
    //
    procedure TestActive(MouseInIndex: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetItemActive(Value: Integer);
    procedure DrawItem(Index: Integer; Cnvs: TCanvas);
    procedure SkinDrawItem(Index: Integer; Cnvs: TCanvas);
    procedure DefaultDrawItem(Index: Integer; Cnvs: TCanvas);

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure CalcItemRects;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure ShowScrollBar;
    procedure HideScrollBar;
    procedure UpdateScrollInfo;
    procedure AdjustScrollBar;
    procedure OnSBChange(Sender: TObject);
    function ItemAtPos(X, Y: Integer): Integer;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;

    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;

    procedure WndProc(var Message: TMessage); override;

    procedure FindUp;
    procedure FindDown;
    procedure FindLeft;
    procedure FindRight;
    procedure FindPageUp;
    procedure FindPageDown;
    
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function GetItems: TbsSkinOfficeGalleryItems;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ScrollToItem(Index: Integer);
    procedure Scroll(AScrollOffset: Integer);
    procedure GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
    procedure ChangeSkinData; override;
    procedure Hide;
    procedure Show(Origin: TPoint);
  published
    property Items:  TbsSkinOfficeGalleryItems read GetItems;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
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

  // TbsSkinOfficeGridView =====================================================

  TbsSkinOfficeGridViewItem = class(TCollectionItem)
  private
    FImageIndex: TImageIndex;
    FCaption: String;
    FEnabled: Boolean;
    FData: Pointer;
    FHeader: Boolean;
    FOnClick: TNotifyEvent;
  protected
    procedure SetImageIndex(const Value: TImageIndex); virtual;
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
    property Caption: String read FCaption write SetCaption;
    property ImageIndex: TImageIndex read FImageIndex
      write SetImageIndex default -1;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TbsSkinOfficeGridView = class;

  TbsSkinOfficeGridViewItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsSkinOfficeGridViewItem;
    procedure SetItem(Index: Integer; Value:  TbsSkinOfficeGridViewItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    GridView: TbsSkinOfficeGridView;
    constructor Create(AGridView: TbsSkinOfficeGridView);
    property Items[Index: Integer]: TbsSkinOfficeGridViewItem read GetItem write SetItem; default;
    function Add: TbsSkinOfficeGridViewItem;
    function Insert(Index: Integer): TbsSkinOfficeGridViewItem;
    procedure Delete(Index: Integer);
    procedure Clear;
  end;

  TbsSkinOfficeGridView = class(TbsSkinCustomControl)
  protected
    FUseInRibbonAppMenu: Boolean;
    FMouseMoveChangeIndex: Boolean;
    FItemLayout: TbsButtonLayout;
    FItemMargin: Integer;
    FItemSpacing: Integer;
    RowCount, ColCount: Integer;
    FInUpdateItems: Boolean;
    FOnDrawItem: TbsDrawSkinOfficeItemEvent;
    FDisabledFontColor: TColor;
    FClicksDisabled: Boolean;
    FMouseDown: Boolean;
    FMouseActive: Integer;
    FMax: Integer;
    FRealMax: Integer;
    FItemsRect: TRect;
    FScrollOffset: Integer;
    FItems: TbsSkinOfficeGridViewItems;
    FImages: TCustomImageList;
    FItemHeight: Integer;
    FItemWidth: Integer;
    FHeaderHeight: Integer;
    FOldHeight: Integer;
    ScrollBar: TbsSkinScrollBar;
    FItemIndex: Integer;
    FOnItemClick: TNotifyEvent;
    FHeaderLeftAlignment: Boolean;
    FItemSkinDataName: String;
    FHeaderSkinDataName: String;
    procedure SetItemLayout(Value: TbsButtonLayout);
    procedure SetItemMargin(Value: Integer);
    procedure SetItemSpacing(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetItemActive(Value: Integer);
    procedure SetItemHeight(Value: Integer);
    procedure SetItemWidth(Value: Integer);
    procedure SetHeaderHeight(Value: Integer);
    procedure SetHeaderLeftAlignment(Value: Boolean);
    procedure SetItems(Value: TbsSkinOfficeGridViewItems);
    procedure SetImages(Value: TCustomImageList);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;

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

    procedure WMSETFOCUS(var Message: TWMSETFOCUS); message WM_SETFOCUS;
    procedure WMKILLFOCUS(var Message: TWMKILLFOCUS); message WM_KILLFOCUS;

    procedure WndProc(var Message: TMessage); override;

    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure FindUp;
    procedure FindDown;
    procedure FindLeft;
    procedure FindRight;
    procedure FindPageUp;
    procedure FindPageDown;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function CalcHeight(AItemCount: Integer): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ScrollToItem(Index: Integer);
    procedure Scroll(AScrollOffset: Integer);
    procedure GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
    procedure ChangeSkinData; override;
    procedure BeginUpdateItems;
    procedure EndUpdateItems;
  published
    property UseInRibbonAppMenu: Boolean
     read FUseInRibbonAppMenu write FUseInRibbonAppMenu;
    property ItemLayout: TbsButtonLayout read FItemLayout write SetItemLayout;
    property ItemMargin: Integer read FItemMargin write SetItemMargin;
    property ItemSpacing: Integer read FItemSpacing write SetItemSpacing;
    property HeaderLeftAlignment: Boolean
     read FHeaderLeftAlignment write SetHeaderLeftAlignment;
    property HeaderSkinDataName: String
     read FHeaderSkinDataName write FHeaderSkinDataName;
    property ItemSkinDataName: String
      read FItemSkinDataName write FItemSkinDataName;
    property Items:  TbsSkinOfficeGridViewItems read FItems write SetItems;
    property Images: TCustomImageList read FImages write SetImages;
    property ItemHeight: Integer
      read FItemHeight write SetItemHeight;
    property ItemWidth: Integer
      read FItemWidth write SetItemWidth;
    property HeaderHeight: Integer
      read FHeaderHeight write SetHeaderHeight;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property MouseMoveChangeIndex: Boolean
      read FMouseMoveChangeIndex write FMouseMoveChangeIndex;  
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
    property OnDrawItem: TbsDrawSkinOfficeItemEvent
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
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;
      
implementation

   Uses ShellAPI, ComCtrls;

const
  DEF_GAUGE_FRAMES = 10;
  WS_EX_LAYERED = $80000;
  CS_DROPSHADOW_ = $20000;

// TbsSkinAnimateGauge

constructor TbsSkinAnimateGauge.Create;
begin
  inherited;
  Width := 100;
  Height := 20;
  BeginOffset := 0;
  EndOffset := 0;
  FProgressText := '';
  FShowProgressText := False;
  FSkinDataName := 'gauge';
  FAnimationPause := 1000;
  FAnimationPauseTimer := nil;
  FAnimationTimer := nil;
  FAnimationFrame := 0;
  FCountFrames := 0;
  FImitation := False;
end;

destructor TbsSkinAnimateGauge.Destroy;
begin
  if FAnimationPauseTimer <> nil then FAnimationPauseTimer.Free;
  if FAnimationTimer <> nil then FAnimationTimer.Free;
  inherited;
end;

procedure TbsSkinAnimateGauge.OnAnimationPauseTimer(Sender: TObject);
begin
  StartInternalAnimation;
end;

procedure TbsSkinAnimateGauge.OnAnimationTimer(Sender: TObject);
begin
  Inc(FAnimationFrame);
  if FAnimationFrame > FCountFrames
  then
    StopInternalAnimation;
  RePaint;
end;

procedure TbsSkinAnimateGauge.SetAnimationPause;
begin
  if Value >= 0
  then
    FAnimationPause := Value;
end;

procedure TbsSkinAnimateGauge.StartInternalAnimation;
begin
  if FAnimationPauseTimer <> nil then FAnimationPauseTimer.Enabled := False;
  FAnimationFrame := 0;
  FAnimationTimer.Enabled := True;
  RePaint;
end;

procedure TbsSkinAnimateGauge.StopInternalAnimation;
begin
  if FAnimationPauseTimer <> nil then FAnimationPauseTimer.Enabled := True;
  FAnimationTimer.Enabled := False;
  FAnimationFrame := 0;
  RePaint;
end;

procedure TbsSkinAnimateGauge.StartAnimation;
begin
  if (FIndex = -1) or ((FIndex <> -1) and
     IsNullRect(Self.AnimationSkinRect))
  then
    begin
      FImitation := True;
      FCountFrames := DEF_GAUGE_FRAMES + 5;
    end
  else
    begin
      FImitation := False;
      if AnimationCountFrames = 1
      then
        FCountFrames :=  (RectWidth(NewProgressArea) + RectWidth(AnimationSkinRect) * 2)
         div (RectWidth(AnimationSkinRect) div 3)
      else
        FCountFrames := AnimationCountFrames;
    end;

  if FAnimationPauseTimer <> nil then FAnimationPauseTimer.Free;
  if FAnimationTimer <> nil then FAnimationTimer.Free;

  FAnimationPauseTimer := TTimer.Create(Self);
  FAnimationPauseTimer.Enabled := False;
  FAnimationPauseTimer.OnTimer := OnAnimationPauseTimer;
  FAnimationPauseTimer.Interval := FAnimationPause;
  FAnimationPauseTimer.Enabled := True;

  FAnimationTimer := TTimer.Create(Self);
  FAnimationTimer.Enabled := False;
  FAnimationTimer.OnTimer := OnAnimationTimer;
  if FImitation
  then
    FAnimationTimer.Interval := 40
  else
    FAnimationTimer.Interval := Self.AnimationTimerInterval;
  StartInternalAnimation;
end;

procedure TbsSkinAnimateGauge.StopAnimation;
begin
  FAnimationFrame := 0;

  if FAnimationTimer = nil then  Exit;


  if FAnimationPauseTimer <> nil
  then
    begin
      FAnimationPauseTimer.Enabled := False;
      FAnimationPauseTimer.Free;
      FAnimationPauseTimer := nil;

    end;

  if FAnimationTimer <> nil
  then
    begin
      FAnimationTimer.Enabled := False;
      FAnimationTimer.Free;
      FAnimationTimer := nil;
    end;
  RePaint;  
end;


procedure TbsSkinAnimateGauge.WMEraseBkgnd;
begin
  if not FromWMPaint
  then
    PaintWindow(Msg.DC);
end;

procedure TbsSkinAnimateGauge.DrawProgressText;
var
  S: String;
  TX, TY: Integer;
  F: TLogFont;
begin
  if (FIndex = -1)
  then
    C.Font.Assign(FDefaultFont)
  else
  if (FIndex <> -1) and not FUseSkinFont
  then
    begin
      C.Font.Assign(FDefaultFont);
      C.Font.Color := FontColor;
    end
  else
    with C do
    begin
      Font.Name := FontName;
      Font.Height := FontHeight;
      Font.Style := FontStyle;
      Font.Color := FontColor;
    end;

   if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
   then
     C.Font.Charset := SkinData.ResourceStrData.CharSet
   else
     C.Font.CharSet := FDefaultFont.Charset;

  S := '';
  if FShowProgressText then S := S + FProgressText;
  if S = '' then Exit;
  with C do
  begin
    TX := Width div 2 - TextWidth(S) div 2;
    TY := Height div 2 - TextHeight(S) div 2;
    Brush.Style := bsClear;
    TextOut(TX, TY, S);
  end;
end;

procedure TbsSkinAnimateGauge.SetShowProgressText;
begin
  FShowProgressText := Value;
  RePaint;
end;

procedure TbsSkinAnimateGauge.SetProgressText;
begin
  FProgressText := Value;
  RePaint;
end;

procedure TbsSkinAnimateGauge.CalcSize;
var
  Offset: Integer;
  W1, H1: Integer;
begin
  inherited;
  if ResizeMode > 0
  then
    begin
      Offset := W - RectWidth(SkinRect);
      NewProgressArea := ProgressArea;
      Inc(NewProgressArea.Right, Offset);
     end
  else
    NewProgressArea := ProgressArea;

  if (FIndex <> -1) and not IsNullRect(AnimationSkinRect) and
     (Self.AnimationCountFrames = 1)
   then
     begin
       FCountFrames :=  (RectWidth(NewProgressArea) + RectWidth(AnimationSkinRect) * 2)
       div (RectWidth(AnimationSkinRect) div 3);
       if (FAnimationTimer <> nil) and FAnimationTimer.Enabled
       then
         if FAnimationFrame > FCountFrames then  FAnimationFrame := 1;
     end;
end;

function TbsSkinAnimateGauge.GetAnimationFrameRect;
var
  fs: Integer;
begin
  if RectWidth(AnimationSkinRect) > RectWidth(AnimationSkinRect)
  then
    begin
      fs := RectWidth(AnimationSkinRect) div AnimationCountFrames;
      Result := Rect(AnimationSkinRect.Left + (FAnimationFrame - 1) * fs,
                 AnimationSkinRect.Top,
                 AnimationSkinRect.Left + FAnimationFrame * fs,
                 AnimationSkinRect.Bottom);
    end
  else
    begin
      fs := RectHeight(AnimationSkinRect) div AnimationCountFrames;
      Result := Rect(AnimationSkinRect.Left,
                     AnimationSkinRect.Top + (FAnimationFrame - 1) * fs,
                     AnimationSkinRect.Right,
                     AnimationSkinRect.Top + FAnimationFrame * fs);
    end;
end;

function TbsSkinAnimateGauge.CalcProgressRect: TRect;
var
  R: TRect;
  FrameWidth: Integer;
begin
  R.Top := NewProgressArea.Top;
  R.Bottom := R.Top + RectHeight(ProgressRect);
  FrameWidth := Width div DEF_GAUGE_FRAMES;
  R.Left := NewProgressArea.Left + (FAnimationFrame - 1) * FrameWidth - 3 * FrameWidth;
  R.Right := R.Left + FrameWidth;
  Result := R;
end;

procedure TbsSkinAnimateGauge.CreateControlSkinImage;
var
  Buffer: TBitMap;
  R, R1: TRect;
  X, Y: Integer;
  XStep: Integer;
begin
  inherited;
  if (FAnimationTimer = nil) or (FCountFrames = 0) or (FAnimationFrame = 0)
  then
    begin
      if ShowProgressText then DrawProgressText(B.Canvas);
      Exit;
    end;
  if FImitation
  then
    begin
      R := CalcProgressRect;
      R.Left := R.Left - RectWidth(R) div 2;
      R.Right := R.Right + RectWidth(R) div 2;
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(R);
      Buffer.Height := RectHeight(R);
      CreateHSkinImage(BeginOffset, EndOffset, Buffer, Picture, ProgressRect,
                  Buffer.Width, Buffer.Height, ProgressStretch);
      if ProgressTransparent
      then
        begin
          Buffer.Transparent := True;
          Buffer.TransparentMode := tmFixed;
          Buffer.TransparentColor := ProgressTransparentColor;
        end;
      IntersectClipRect(B.Canvas.Handle,
        NewProgressArea.Left, NewProgressArea.Top,
        NewProgressArea.Right, NewProgressArea.Bottom);
      B.Canvas.Draw(R.Left, R.Top, Buffer);
      if ShowProgressText then DrawProgressText(B.Canvas);
      Buffer.Free;
    end
  else
  if not FImitation and (AnimationCountFrames > 1)
  then
    begin
      R := NewProgressArea;
      R1 := GetAnimationFrameRect;
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(R);
      Buffer.Height := RectHeight(R);
      CreateHSkinImage(AnimationBeginOffset,
        AnimationEndOffset, Buffer, Picture, R1,
          Buffer.Width, Buffer.Height, True);
      IntersectClipRect(B.Canvas.Handle,
        NewProgressArea.Left, NewProgressArea.Top,
        NewProgressArea.Right, NewProgressArea.Bottom);
      B.Canvas.Draw(R.Left, R.Top, Buffer);
      if ShowProgressText then DrawProgressText(B.Canvas);
      Buffer.Free;
    end
  else
  if not FImitation and (AnimationCountFrames = 1)
  then
    begin
      FCountFrames :=  (RectWidth(NewProgressArea) + RectWidth(AnimationSkinRect) * 2)
         div (RectWidth(AnimationSkinRect) div 3);
      if FAnimationFrame > FCountFrames then  FAnimationFrame := 1;
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(AnimationSkinRect);
      Buffer.Height := RectHeight(AnimationSkinRect);
      Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height), Picture.Canvas,
       AnimationSkinRect);
      XStep := RectWidth(AnimationSkinRect) div 3;
      X := NewProgressArea.Left +  XStep * (FAnimationFrame - 1) -
        RectWidth(AnimationSkinRect);
      Y := NewProgressArea.Top;
      IntersectClipRect(B.Canvas.Handle,
        NewProgressArea.Left, NewProgressArea.Top,
        NewProgressArea.Right, NewProgressArea.Bottom);
      B.Canvas.Draw(X, Y, Buffer);
      if ShowProgressText then DrawProgressText(B.Canvas);
      Buffer.Free;
    end;
end;

procedure TbsSkinAnimateGauge.CreateImage;
begin
  CreateSkinControlImage(B, Picture, SkinRect);
end;

procedure TbsSkinAnimateGauge.CreateControlDefaultImage(B: TBitMap);
var
  R, PR: TRect;
  V: Integer;
begin
  R := ClientRect;
  B.Canvas.Brush.Color := clWindow;
  B.Canvas.FillRect(R);
  Frame3D(B.Canvas, R, clbtnShadow, clbtnShadow, 1);
  DrawProgressText(B.Canvas);
end;

procedure TbsSkinAnimateGauge.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinGaugeControl
    then
      with TbsDataSkinGaugeControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.ProgressRect := ProgressRect;
        Self.ProgressArea := ProgressArea;
        Self.BeginOffset := BeginOffset;
        Self.EndOffset := EndOffset;
        Self.FontName := FontName;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.FontColor := FontColor;
        Self.ProgressTransparent := ProgressTransparent;
        Self.ProgressTransparentColor := ProgressTransparentColor;
        Self.ProgressStretch := ProgressStretch;
        Self.AnimationSkinRect := AnimationSkinRect;
        Self.AnimationCountFrames := AnimationCountFrames;
        Self.AnimationTimerInterval := AnimationTimerInterval;
        Self.AnimationBeginOffset := AnimationBeginOffset;
        Self.AnimationEndOffset := AnimationEndOffset;
      end;
end;

procedure TbsSkinAnimateGauge.ChangeSkinData;
var
  FAnimation: Boolean;
begin
  FAnimation := FAnimationTimer <> nil;
  if FAnimation then StopAnimation;
  inherited;
  if FAnimation then StartAnimation;
end;



constructor TbsSkinLinkImage.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Cursor := crHandPoint;
end;

procedure TbsSkinLinkImage.Click;
begin
  inherited Click;
  if FURL <> ''
  then
    ShellExecute(0, 'open', PChar(FURL), nil, nil, SW_SHOWNORMAL);
end;

constructor TbsSkinLinkLabel.Create;
begin
  inherited;
  FGlowEffect := False;
  FGlowSize := 7;
  FUseUnderLine := True;
  FIndex := -1;
  Transparent := True;
  FSD := nil;
  FSkinDataName := 'stdlabel';
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := 'Arial';
    Height := 14;
    Style := [fsUnderLine];
  end;
  Font.Assign(FDefaultFont);
  Cursor := crHandPoint;
  FUseSkinFont := True;
  FDefaultActiveFontColor := clBlue;
  FURL := '';
end;

destructor TbsSkinLinkLabel.Destroy;
begin
  FDefaultFont.Free;
  inherited;
end;

procedure TbsSkinLinkLabel.SetUseUnderLine;
begin
  if FUseUnderLine <> Value
  then
    begin
      FUseUnderLine := Value;
      RePaint;
    end;
end;

procedure TbsSkinLinkLabel.DoDrawText(var Rect: TRect; Flags: Longint);
var
  Text: string;
  GlowColor: TColor;
  R: TRect;
begin
  GetSkinData;

  Text := GetLabelText;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);

  R := Rect;
  if FGlowEffect
  then
    OffsetRect(R, 0, FGlowSize);

  if FIndex <> -1
  then
    with Canvas.Font do
    begin
      if FUseSkinFont
      then
        begin
          Name := FontName;
          Style := FontStyle;
          Height := FontHeight;
          if FUseUnderLine
          then
            Style := Style + [fsUnderLine]
          else
            Style := Style - [fsUnderLine];
        end
      else
        begin
          Canvas.Font := Self.Font;
          if FUseUnderLine
          then
            Style := Style + [fsUnderLine]
          else
            Style := Style - [fsUnderLine];
        end;  
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Charset := SkinData.ResourceStrData.CharSet
      else
        CharSet := FDefaultFont.Charset;
      if FMouseIn and not FGlowEffect
      then
        Color := ActiveFontColor
      else
        Color := FontColor;
    end
  else
    begin
      if FUseSkinFont
      then
        Canvas.Font := DefaultFont
      else
        Canvas.Font := Self.Font;

      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
      else
        Canvas.Font.CharSet := FDefaultFont.Charset;

      if FMouseIn then Canvas.Font.Color := FDefaultActiveFontColor;
      Canvas.Font.Style := Canvas.Font.Style + [fsUnderLine];
    end;

  if FIndex <> -1
  then
    begin
      GlowColor := ActiveFontColor;
    end
  else
    begin
      GlowColor := FDefaultActiveFontColor;
    end;

  if not Enabled then
  begin
    OffsetRect(Rect, 1, 1);
    if FIndex <> -1
    then
      Canvas.Font.Color := FSD.SkinColors.cBtnHighLight
    else
      Canvas.Font.Color := clBtnHighlight;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), R, Flags);
    OffsetRect(Rect, -1, -1);
    if FIndex <> -1
    then
      Canvas.Font.Color := FSD.SkinColors.cBtnShadow
    else
      Canvas.Font.Color := clBtnShadow;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), R, Flags);
  end
  else
    begin
      if FUseUnderLine
      then
        Canvas.Font.Style := Canvas.Font.Style + [fsUnderLine]
      else
        Canvas.Font.Style := Canvas.Font.Style - [fsUnderLine];
      if FMouseIn and FGlowEffect
      then
        DrawEffectText2(Canvas, R, Text, Flags, 0, GlowColor, FGlowSize)
      else
        DrawText(Canvas.Handle, PChar(Text), Length(Text), R, Flags);
    end;
end;

procedure TbsSkinLinkLabel.Click;
begin
  inherited;
  if FURL <> ''
  then
    ShellExecute(0, 'open', PChar(FURL), nil, nil, SW_SHOWNORMAL);
end;

procedure TbsSkinLinkLabel.CMMouseEnter;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := True;
  RePaint;
end;

procedure TbsSkinLinkLabel.CMMouseLeave;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := False;
  RePaint;
end;

procedure TbsSkinLinkLabel.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSkinLinkLabel.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinLinkLabel.GetSkinData;
begin
  if (FSD = nil) or FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  if (FIndex <> -1)
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinStdLabelControl
    then
      with TbsDataSkinStdLabelControl(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.ActiveFontColor := ActiveFontColor;
      end
end;

procedure TbsSkinLinkLabel.ChangeSkinData;
begin
  GetSkinData;
  RePaint;
end;

procedure TbsSkinLinkLabel.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then ChangeSkinData;
end;


constructor TbsSkinXFormButton.Create(AOwner: TComponent);
begin
  inherited;
  FDefImage := TBitMap.Create;
  FDefActiveImage := TBitMap.Create;
  FDefDownImage := TBitMap.Create;
  FDefMask := TBitMap.Create;
  CanFocused := False;
  FDefActiveFontColor := 0;
  FDefDownFontColor := 0;
end;

destructor TbsSkinXFormButton.Destroy;
begin
  FDefImage.Free;
  FDefActiveImage.Free;
  FDefDownImage.Free;
  FDefMask.Free;
  inherited;
end;

procedure TbsSkinXFormButton.SetControlRegion;
var
  TempRgn: HRGN;
begin
  if (FIndex = -1) and (FDefImage <> nil) and not FDefImage.Empty
  then
    begin
      TempRgn := FRgn;
      
      if FDefMask.Empty and (FRgn <> 0)
      then
        begin
          SetWindowRgn(Handle, 0, True);
        end
      else
        begin
          CreateSkinSimplyRegion(FRgn, FDefMask);
          SetWindowRgn(Handle, FRgn, True);
        end;

      if TempRgn <> 0 then DeleteObject(TempRgn);
    end
  else
    inherited;
end;

procedure TbsSkinXFormButton.SetBounds;
begin
  inherited;
  if (FIndex = -1) and (FDefImage <> nil) and not FDefImage.Empty
  then
    begin
      if Width <> FDefImage.Width then Width := FDefImage.Width;
      if Height <> FDefImage.Height then Height := FDefImage.Height;
    end;
end;

procedure TbsSkinXFormButton.DrawDefaultButton;
var
  IsDown: Boolean;
  R: TRect;
begin
  with C do
  begin
    R := ClientRect;
    Font.Assign(FDefaultFont);
    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Font.Charset := SkinData.ResourceStrData.CharSet
    else
      Font.Charset := FDefaultFont.CharSet;

    IsDown := FDown and (((FMouseIn or (IsFocused and not FMouseDown)) and
             (GroupIndex = 0)) or (GroupIndex  <> 0));
    if IsDown and not FDefDownImage.Empty
    then
      Draw(0, 0, FDefDownImage)
    else
    if (FMouseIn or IsFocused) and not FDefActiveImage.Empty
    then
      Draw(0, 0, FDefActiveImage)
    else
      Draw(0, 0, FDefImage);
    if IsDown
    then
      Font.Color := FDefDownFontColor
    else
    if FMouseIn or IsFocused
    then
      Font.Color := FDefActiveFontColor;
    DrawGlyphAndText(C, ClientRect, FMargin, FSpacing, FLayout,
     Caption, FGlyph, FNumGlyphs, GetGlyphNum(FDown, FMouseIn), False, False, 0);
  end;
end;

procedure TbsSkinXFormButton.CreateControlDefaultImage;
begin
  if (FIndex = -1) and not FDefImage.Empty
  then
    DrawDefaultButton(B.Canvas)
  else
    inherited;
end;

procedure TbsSkinXFormButton.ChangeSkinData;
begin
  GetSkinData;
  if (FIndex = -1) and not FDefImage.Empty
  then
    begin
      Width := FDefImage.Width;
      Height := FDEfImage.Width;
      SetControlRegion;
      RePaint;
    end
  else
    inherited;  
end;

procedure TbsSkinXFormButton.SetDefImage(Value: TBitMap);
begin
  FDefImage.Assign(Value);
  if not FDefImage.Empty
  then
    begin
      DefaultHeight := FDefImage.Height;
      DefaultWidth := FDefImage.Width;
    end;
end;

procedure TbsSkinXFormButton.SetDefActiveImage(Value: TBitMap);
begin
  FDefActiveImage.Assign(Value);
end;

procedure TbsSkinXFormButton.SetDefDownImage(Value: TBitMap);
begin
  FDefDownImage.Assign(Value);
end;

procedure TbsSkinXFormButton.SetDefMask(Value: TBitMap);
begin
  FDefMask.Assign(Value);
  if not FDefImage.Empty
  then
    SetControlRegion;
end;

procedure TbsSkinXFormButton.Loaded;
begin
  inherited;
  if (FIndex = -1) and (FDefMask <> nil) and not FDefMask.Empty
  then
    SetControlRegion;
end;

constructor TbsSkinShadowLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque] + [csReplicatable];
  Width := 65;
  Height := 17;
  FAutoSize := True;
  FShowAccelChar := True;
  FDoubleBuffered := False;
  FShadowColor := clBlack;
  FShadowOffset := 0;
  FShadowSize := 2;
end;


procedure TbsSkinShadowLabel.SetShadowColor(Value: TColor);
begin
  if Value <> FShadowColor
  then
    begin
      FShadowColor := Value;
      RePaint;
    end;
end;

procedure TbsSkinShadowLabel.SetShadowSize(Value: Integer);
begin
  if (Value <> FShadowSize) and (Value > 0) and (Value < 11)
  then
    begin
      FShadowSize := Value;
      RePaint;
    end;
end;

procedure TbsSkinShadowLabel.SetShadowOffset(Value: Integer);
begin
  if (Value <> FShadowOffset) and (Value >= 0) and (Value < 101)
  then
    begin
      FShadowOffset := Value;
      RePaint;
    end;
end;

procedure TbsSkinShadowLabel.SetDoubleBuffered;
begin
  if Value <> FDoubleBuffered
  then
    begin
      FDoubleBuffered := Value;
      if FDoubleBuffered
      then ControlStyle := ControlStyle + [csOpaque]
      else ControlStyle := ControlStyle - [csOpaque];
    end;
end;

function TbsSkinShadowLabel.GetLabelText: string;
begin
  Result := Caption;
end;

procedure TbsSkinShadowLabel.WMMOVE;
begin
  inherited;
  if FDoubleBuffered then RePaint;
end;

procedure TbsSkinShadowLabel.DoDrawText(Cnvs: TCanvas; var Rect: TRect; Flags: Longint);
var
  Text: string;
begin
  Text := GetLabelText;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  Windows.DrawText(Cnvs.Handle, PChar(Text), Length(Text), Rect, Flags);
end;

procedure TbsSkinShadowLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Text: string;
  Flags: Longint;
  R: TRect;
  FBuffer: TbsBitmap;
begin
  //
  Canvas.Font := Self.Font;
  //
  Text := GetLabelText;
  R := Rect(FShadowSize - FShadowOffset, FShadowSize - FShadowOffset,
            Width - FShadowSize - FShadowOffset, Height - FShadowSize - FShadowOffset);
  if R.Left < 0 then R.Left := 0;
  if R.Top < 0 then R.Top := 0;
  Flags := DT_EXPANDTABS or WordWraps[FWordWrap] or Alignments[FAlignment];
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  if FDoubleBuffered
  then
    begin
      FBuffer := TbsBitmap.Create;
      FBuffer.SetSize(Width, Height);
      GetParentImage(Self, FBuffer.Canvas);
      FBuffer.Canvas.Font := Self.Font;
      DrawEffectText(FBuffer.Canvas, R, Text, Flags, FShadowOffset, FShadowColor, FShadowSize);
      FBuffer.Draw(Canvas.Handle, 0, 0);
      FBuffer.Free;
    end
  else
    DrawEffectText(Canvas, R, Text, Flags, FShadowOffset, FShadowColor, FShadowSize);
end;

procedure TbsSkinShadowLabel.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TbsSkinShadowLabel.AdjustBounds;
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X: Integer;
  Rect: TRect;
  AAlignment: TAlignment;
begin
  if not (csReading in ComponentState) and FAutoSize then
  begin
    Canvas.Font := Self.Font;
    Rect := ClientRect;
    DC := GetDC(0);
    Canvas.Handle := DC;
    DoDrawText(Canvas, Rect, (DT_EXPANDTABS or DT_CALCRECT) or WordWraps[FWordWrap]);
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    X := Left;
    AAlignment := FAlignment;
    if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
    if AAlignment = taRightJustify then Inc(X, Width - Rect.Right);
    Rect.Right := Rect.Right + FShadowOffset + FShadowSize * 2 + 8;
    Rect.Bottom := Rect.Bottom + FShadowOffset + FShadowSize * 2 + 8;
    SetBounds(X, Top, Rect.Right, Rect.Bottom);
  end;
end;

procedure TbsSkinShadowLabel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RePaint;
  end;
end;

procedure TbsSkinShadowLabel.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
  end;
end;

procedure TbsSkinShadowLabel.SetFocusControl(Value: TWinControl);
begin
  FFocusControl := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TbsSkinShadowLabel.SetShowAccelChar(Value: Boolean);
begin
  if FShowAccelChar <> Value then
  begin
    FShowAccelChar := Value;
    RePaint;
  end;
end;

procedure TbsSkinShadowLabel.SetLayout(Value: TTextLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    RePaint;
  end;
end;

procedure TbsSkinShadowLabel.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    AdjustBounds;
    RePaint;
  end;
end;

procedure TbsSkinShadowLabel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
end;

procedure TbsSkinShadowLabel.CMTextChanged(var Message: TMessage);
begin
  AdjustBounds;
  RePaint;
end;

procedure TbsSkinShadowLabel.CMFontChanged(var Message: TMessage);
begin
  AdjustBounds;
  RePaint;
end;

procedure TbsSkinShadowLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if (FFocusControl <> nil) and Enabled and ShowAccelChar and
    IsAccel(Message.CharCode, Caption) then
    with FFocusControl do
      if CanFocus then
      begin
        SetFocus;
        Message.Result := 1;
      end;
end;

procedure TbsSkinShadowLabel.ChangeSkinData;
begin
  inherited;
  if (FSD <> nil) and (not FSD.Empty)
  then
    begin
      Font.Color := FSD.SkinColors.cBtnText;
      ShadowColor := Darker(FSD.SkinColors.cBtnFace, 80);
      RePaint;
    end;
end;

constructor TbsSkinButtonEx.Create(AOwner: TComponent); 
begin
  inherited;
  FTitle := 'Title';
  Width := 100;
  Height := 50;
  FTitleAlignment := taLeftJustify;
  FSkinDataName := 'resizebutton';
  FGlowEffect := False;
  FGlowSize := 3;
end;

procedure TbsSkinButtonEx.SetTitle(Value: String);
begin
  if FTitle <> Value
  then
    begin
      FTitle := Value;
      RePaint;
    end;  
end;

procedure TbsSkinButtonEx.SetTitleAlignment(Value: TAlignment);
begin
  if FTitleAlignment <> Value
  then
    begin
      FTitleAlignment := Value;
      RePaint;
   end;
end;

procedure TbsSkinButtonEx.CreateButtonImage;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  S: String;
  FDrawDefault: Boolean;
  NewClRect2: TRect;
  TR: TRect;
begin
 if (not FUseSkinSize) and (ResizeMode <> 1)
  then
    begin
      CreateStrechButtonImage(B, R, ADown, AMouseIn);
      Exit;
    end;
  CreateSkinControlImage(B, Picture, R);
  if not FUseSkinFont
  then
    B.Canvas.Font.Assign(FDefaultFont)
  else
    with B.Canvas.Font do
    begin
      Name := FontName;
      Height := FontHeight;
      Style := FontStyle;
    end;

  with B.Canvas.Font do
  begin

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Charset := SkinData.ResourceStrData.CharSet
    else
      CharSet := FDefaultFont.Charset;

    if Enabled and not FUseSkinFontColor
    then
      begin
        Color := FDefaultFont.Color;
      end
    else
    if not Enabled
    then
      Color := DisabledFontColor
    else
    if ADown and AMouseIn
    then
      Color := DownFontColor
    else
      if AMouseIn
      then Color := ActiveFontColor
      else Color := FontColor;
  end;

  if ShowFocus and Focused
  then
    begin
      B.Canvas.Brush.Style := bsSolid;
      B.Canvas.Brush.Color := FSD.SkinColors.cBtnFace;
      B.Canvas.DrawFocusRect(NewClRect);
      B.Canvas.Brush.Style := bsClear;
    end;

  FDrawDefault := True;

  NewClRect2 := NewClRect;
  if FTitle <> ''
  then
    begin
      B.Canvas.Font.Style := B.Canvas.Font.Style + [fsBold];
      TR := NewClRect;
      if FTitleAlignment = taLeftJustify
      then
        begin
          Inc(TR.Top, 2);
          Inc(TR.Left, 2);
        end
      else
      if FTitleAlignment = taRightJustify
      then
        begin
          Inc(TR.Top, 2);
          Dec(TR.Right, 2);
        end;
      TR.Bottom := TR.Top + B.Canvas.TextHeight(FTitle);
      B.Canvas.Brush.Style := bsClear;
      DrawText(B.Canvas.Handle, PChar(FTitle), Length(FTitle), TR,
        DT_EXPANDTABS or Alignments[FTitleAlignment]);
      Inc(NewClRect2.Top, B.Canvas.TextHeight(FTitle));
      B.Canvas.Font.Style := B.Canvas.Font.Style - [fsBold];
    end;

  if Assigned(FOnPaint)
  then
    FOnPaint(Self, B.Canvas, NewClRect2, ADown, AMouseIn, FDrawDefault);

  if FDrawDefault then
  
  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        S := FSkinImagesMenu.SelectedItem.Caption
      else
        S := Caption;
      if FGlowEffect and AMouseIn
      then
       DrawImageAndTextGlow2(B.Canvas, NewClRect2, FMargin, FSpacing, FLayout,
         S, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
          False, Enabled, False, 0,
          FSD.SkinColors.cHighLight,
          FGlowSize)
      else
        DrawImageAndText2(B.Canvas, NewClRect2, FMargin, FSpacing, FLayout,
         S, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
          False, Enabled, False, 0);
    end
  else
  if (FImageList <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FImageList.Count)
  then
    begin
      if FGlowEffect and AMouseIn
      then
        DrawImageAndTextGlow2(B.Canvas, NewClRect2, FMargin, FSpacing, FLayout,
         Caption, FImageIndex, FImageList,
         False, Enabled, False, 0,
         FSD.SkinColors.cHighLight,
         FGlowSize)
      else
      DrawImageAndText2(B.Canvas, NewClRect2, FMargin, FSpacing, FLayout,
        Caption, FImageIndex, FImageList,
        False, Enabled, False, 0);
    end
  else
    begin
      if FGlowEffect and AMouseIn
      then
        DrawGlyphAndTextGlow2(B.Canvas,
         NewClRect2, FMargin, FSpacing, FLayout,
         Caption, FGlyph, FNumGlyphs, GetGlyphNum(ADown, AMouseIn), False, False, 0,
         FSD.SkinColors.cHighLight,
         FGlowSize)
      else
      DrawGlyphAndText2(B.Canvas,
       NewClRect2, FMargin, FSpacing, FLayout,
        Caption, FGlyph, FNumGlyphs, GetGlyphNum(ADown, AMouseIn), False, False, 0);
    end;

end;


procedure TbsSkinButtonEx.CreateControlDefaultImage;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  R, TR: TRect;
  IsDown: Boolean;
  S: String;
  FDrawDefault: Boolean;
  ClientRect2: TRect;
begin
  IsDown := False;
  R := ClientRect;
  if FDown and (((FMouseIn or (IsFocused and not FMouseDown)) and
     (GroupIndex = 0)) or (GroupIndex  <> 0))
  then
    begin
      Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
      B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
      B.Canvas.FillRect(R);
      IsDown := True;
    end
  else
    if FMouseIn or IsFocused
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

  B.Canvas.Font.Assign(FDefaultFont);
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    B.Canvas.Font.Charset := SkinData.ResourceStrData.CharSet;
    
  if not Enabled then B.Canvas.Font.Color := clBtnShadow;

  FDrawDefault := True;

  ClientRect2 := ClientRect;

  if FTitle <> ''
  then
    begin
      B.Canvas.Font.Style := B.Canvas.Font.Style + [fsBold];
      TR := ClientRect;
      if FTitleAlignment = taLeftJustify
      then
        begin
          Inc(TR.Top, 2);
          Inc(TR.Left, 2);
        end
      else
      if FTitleAlignment = taRightJustify
      then
        begin
          Inc(TR.Top, 2);
          Dec(TR.Right, 2);
        end;
      if FDown and FMouseIn
      then
        begin
          Inc(TR.Top);
          Inc(TR.Left);
        end;
      TR.Bottom := TR.Top + B.Canvas.TextHeight(FTitle);
      B.Canvas.Brush.Style := bsClear;
      DrawText(B.Canvas.Handle, PChar(FTitle), Length(FTitle), TR,
        DT_EXPANDTABS or Alignments[FTitleAlignment]);
      Inc(ClientRect2.Top, B.Canvas.TextHeight(FTitle));
      B.Canvas.Font.Style := B.Canvas.Font.Style - [fsBold];
    end;

  if Assigned(FOnPaint)
  then
    FOnPaint(Self, B.Canvas, ClientRect2, FDown, FMouseIn, FDrawDefault);

  if FDrawDefault then

  if (FSkinImagesMenu <> nil) and (FSkinImagesMenu.SelectedItem <> nil) and
      FUseImagesMenuImage
  then
    begin
      if FUseImagesMenuCaption
      then
        S := FSkinImagesMenu.SelectedItem.Caption
      else
        S := Caption;
      DrawImageAndText2(B.Canvas, ClientRect2, FMargin, FSpacing, FLayout,
        S, FSkinImagesMenu.SelectedItem.ImageIndex, FSkinImagesMenu.Images,
        False, Enabled, False, 0);
    end
  else
  if (FImageList <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FImageList.Count)
  then
    begin
      DrawImageAndText2(B.Canvas, ClientRect2, FMargin, FSpacing, FLayout,
        Caption, FImageIndex, FImageList,
        False, Enabled, False, 0);
    end
  else
    DrawGlyphAndText2(B.Canvas,
    ClientRect2, FMargin, FSpacing, FLayout,
    Caption, FGlyph, FNumGlyphs, GetGlyphNum(FDown, FMouseIn), False, False, 0);
end;


// TbsSkinComboBoxEx ==========================================================

constructor TbsSkinOfficeItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FHeader := False;
  FImageIndex := -1;
  FCaption := '';
  FTitle := '';
  FEnabled := True;
  FChecked := False;
  if TbsSkinOfficeItems(Collection).OfficeListBox.ItemIndex = Self.Index
  then
    Active := True
  else
    Active := False;
end;

procedure TbsSkinOfficeItem.Assign(Source: TPersistent);
begin
  if Source is TbsSkinOfficeItem then
  begin
    FImageIndex := TbsSkinOfficeItem(Source).ImageIndex;
    FCaption := TbsSkinOfficeItem(Source).Caption;
    FTitle := TbsSkinOfficeItem(Source).Title;
    FEnabled := TbsSkinOfficeItem(Source).Enabled;
    FChecked := TbsSkinOfficeItem(Source).Checked;
    FHeader := TbsSkinOfficeItem(Source).Header;
  end
  else
    inherited Assign(Source);
end;

procedure TbsSkinOfficeItem.SetChecked;
begin
  FChecked := Value;
  Changed(False);
end;

procedure TbsSkinOfficeItem.SetImageIndex(const Value: TImageIndex);
begin
  FImageIndex := Value;
  Changed(False);
end;

procedure TbsSkinOfficeItem.SetCaption(const Value: String);
begin
  FCaption := Value;
  Changed(False);
end;

procedure TbsSkinOfficeItem.SetHeader(Value: Boolean);
begin
  FHeader := Value;
  Changed(False);
end;

procedure TbsSkinOfficeItem.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  Changed(False);
end;

procedure TbsSkinOfficeItem.SetTitle(const Value: String);
begin
  FTitle := Value;
  Changed(False);
end;

procedure TbsSkinOfficeItem.SetData(const Value: Pointer);
begin
  FData := Value;
end;

constructor TbsSkinOfficeItems.Create;
begin
  inherited Create(TbsSkinOfficeItem);
  OfficeListBox := AListBox;
end;

function TbsSkinOfficeItems.GetOwner: TPersistent;
begin
  Result := OfficeListBox;
end;

procedure  TbsSkinOfficeItems.Update(Item: TCollectionItem);
begin
  OfficeListBox.Repaint;
  OfficeListBox.UpdateScrollInfo;
end; 

function TbsSkinOfficeItems.GetItem(Index: Integer):  TbsSkinOfficeItem;
begin
  Result := TbsSkinOfficeItem(inherited GetItem(Index));
end;

procedure TbsSkinOfficeItems.SetItem(Index: Integer; Value:  TbsSkinOfficeItem);
begin
  inherited SetItem(Index, Value);
  OfficeListBox.RePaint;
end;

function TbsSkinOfficeItems.Add: TbsSkinOfficeItem;
begin
  Result := TbsSkinOfficeItem(inherited Add);
  OfficeListBox.RePaint;
end;

function TbsSkinOfficeItems.Insert(Index: Integer): TbsSkinOfficeItem;
begin
  Result := TbsSkinOfficeItem(inherited Insert(Index));
  OfficeListBox.RePaint;
end;

procedure TbsSkinOfficeItems.Delete(Index: Integer);
begin
  inherited Delete(Index);
  OfficeListBox.RePaint;
end;

procedure TbsSkinOfficeItems.Clear;
begin
  inherited Clear;
  OfficeListBox.RePaint;
end;

constructor TbsSkinOfficeListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csAcceptsControls];
  FCheckOffset := 0;
  FShowCheckBoxes := False;
  FInUpdateItems := False;
  FClicksDisabled := False;
  FHeaderLeftAlignment := False;
  FMouseMoveChangeIndex := False;
  FMouseDown := False;
  FShowLines := False;
  FMouseActive := -1;
  ScrollBar := nil;
  FScrollOffset := 0;
  FItems := TbsSkinOfficeItems.Create(Self);
  FImages := nil;
  Width := 150;
  Height := 150;
  FItemHeight := 30;
  FHeaderHeight := 20;
  FItemSkinDataName := 'listbox';
  FSkinDataName := 'listbox';
  FHeaderSkinDataName := 'menuheader';
  FShowItemTitles := True;
  FMax := 0;
  FRealMax := 0;
  FOldHeight := -1;
  FItemIndex := -1;
  FDisabledFontColor := clGray;
end;

destructor TbsSkinOfficeListBox.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TbsSkinOfficeListBox.BeginUpdateItems;
begin
  FInUpdateItems := True;
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
end;

procedure TbsSkinOfficeListBox.SkinDrawCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

procedure TbsSkinOfficeListBox.SetShowCheckBoxes;
begin
  if FShowCheckBoxes <> Value
  then
    begin
      FShowCheckBoxes := Value;
      RePaint;
    end;
end;

procedure TbsSkinOfficeListBox.EndUpdateItems;
begin
  FInUpdateItems := False;
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinOfficeListBox.SetHeaderLeftAlignment(Value: Boolean);
begin
  if FHeaderLeftAlignment <> Value
  then
    begin
      FHeaderLeftAlignment := Value;
      RePaint;
    end;
end;

function TbsSkinOfficeListBox.CalcHeight;
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

procedure TbsSkinOfficeListBox.SetShowLines;
begin
  if FShowLines <> Value
  then
    begin
      FShowLines := Value;
      RePaint;
    end;
end;

procedure TbsSkinOfficeListBox.ChangeSkinData;
var
  CIndex: Integer;
begin
  inherited;
  //
  if SkinData <> nil
  then
    CIndex := SkinData.GetControlIndex('edit');
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

procedure TbsSkinOfficeListBox.SetItemHeight(Value: Integer);
begin
  if FItemHeight <> Value
  then
    begin
      FItemHeight := Value;
      RePaint;
    end;
end;

procedure TbsSkinOfficeListBox.SetHeaderHeight(Value: Integer);
begin
  if FHeaderHeight <> Value
  then
    begin
      FHeaderHeight := Value;
      RePaint;
    end;
end;

procedure TbsSkinOfficeListBox.SetItems(Value: TbsSkinOfficeItems);
begin
  FItems.Assign(Value);
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinOfficeListBox.SetImages(Value: TCustomImageList);
begin
  FImages := Value;
end;

procedure TbsSkinOfficeListBox.Notification(AComponent: TComponent;
            Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then
   FImages := nil;
end;

procedure TbsSkinOfficeListBox.SetShowItemTitles(Value: Boolean);
begin
  if FShowItemTitles <> Value
  then
    begin
      FShowItemTitles := Value;
      RePaint;
    end;
end;

procedure TbsSkinOfficeListBox.DrawItem;
var
  Buffer: TBitMap;
  R: TRect;
begin
  if FIndex <> -1
  then
    SkinDrawItem(Index, Cnvs)
  else
    DefaultDrawItem(Index, Cnvs);
end;

procedure TbsSkinOfficeListBox.CreateControlDefaultImage(B: TBitMap);
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

procedure TbsSkinOfficeListBox.CreateControlSkinImage(B: TBitMap);
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

procedure TbsSkinOfficeListBox.CalcItemRects;
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
    with TbsSkinOfficeItem(FItems[I]) do
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

procedure TbsSkinOfficeListBox.Scroll(AScrollOffset: Integer);
begin
  FScrollOffset := AScrollOffset;
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinOfficeListBox.GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
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

procedure TbsSkinOfficeListBox.WMSize(var Msg: TWMSize);
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

procedure TbsSkinOfficeListBox.ScrollToItem(Index: Integer);
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

procedure TbsSkinOfficeListBox.ShowScrollbar;
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

procedure TbsSkinOfficeListBox.HideScrollBar;
begin
  if ScrollBar = nil then Exit;
  ScrollBar.Visible := False;
  ScrollBar.Free;
  ScrollBar := nil;
  RePaint;
end;

procedure TbsSkinOfficeListBox.UpdateScrollInfo;
var
  SMin, SMax, SPage, SPos: Integer;
begin
  //
  if not HandleAllocated then Exit;
  //
  if FInUpdateItems then Exit;
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

procedure TbsSkinOfficeListBox.AdjustScrollBar;
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

procedure TbsSkinOfficeListBox.SBChange(Sender: TObject);
begin
  Scroll(ScrollBar.Position);
end;

procedure TbsSkinOfficeListBox.SkinDrawItem(Index: Integer; Cnvs: TCanvas);
var
  ListBoxData: TbsDataSkinListBox;
  CheckListBoxData: TbsDataSkinCheckListBox;
  CIndex, TX, TY: Integer;
  R, R1, CR: TRect;
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

  CIndex := SkinData.GetControlIndex(FItemSkinDataName);
  if CIndex = -1 then Exit;
  R := FItems[Index].ItemRect;
  InflateRect(R, -2, -2);
  ListBoxData := TbsDataSkinListBox(SkinData.CtrlList[CIndex]);
  Cnvs.Brush.Style := bsClear;
  //
  if FShowCheckBoxes
  then
    begin
      CIndex := SkinData.GetControlIndex('checklistbox');
      if CIndex <> -1
      then
        begin
          CheckListBoxData := TbsDataSkinCheckListBox(SkinData.CtrlList[CIndex])
        end
      else
        CheckListBoxData := nil;
    end;
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
    begin
      if (FSkinDataName = 'listbox') or
         (FSkinDataName = 'memo') or
         (FSkinDataName = 'menupagepanel')
      then
        Cnvs.Font.Color := ListBoxData.FontColor
      else
        Cnvs.Font.Color := FSD.SkinColors.cBtnText;
    end
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
       if FShowCheckBoxes and (CheckListBoxData <> nil)
       then
         begin
           CR := Rect(R.Left, R.Top,
             R.Left + RectWidth(CheckListBoxData.CheckImageRect), R.Bottom);
           CR.Top := CR.Top + RectHeight(CR) div 2 -
            RectHeight(CheckListBoxData.CheckImageRect) div 2;
           if Checked
           then
             SkinDrawCheckImage(CR.Left, CR.Top, Picture.Canvas, CheckListBoxData.CheckImageRect, Cnvs)
           else
             SkinDrawCheckImage(CR.Left, CR.Top, Picture.Canvas, CheckListBoxData.UnCheckImageRect, Cnvs);
           Inc(R.Left, RectWidth(CheckListBoxData.CheckImageRect) + 5);
           FCheckOffset := RectWidth(CheckListBoxData.CheckImageRect) + 5;
         end
      else
        if FShowCheckBoxes and (CheckListBoxData = nil)
        then
         begin
           CR := Rect(R.Left, R.Top,
             R.Left + 12, R.Bottom);
           CR.Top := CR.Top + RectHeight(CR) div 2 - 10 div 2;
           C := Cnvs.Pen.Color;
           if Checked
           then
             DrawCheckImage(Cnvs, CR.Left + 2, CR.Top, FSD.SkinColors.cWindowText);
           Cnvs.Pen.Color := C;
           Inc(R.Left, 14);
           FCheckOffset := 14;
         end;
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

       if FShowCheckBoxes and (CheckListBoxData <> nil)
       then
         begin
           CR := Rect(R.Left, R.Top,
             R.Left + RectWidth(CheckListBoxData.CheckImageRect), R.Bottom);
           CR.Top := CR.Top + RectHeight(CR) div 2 -
            RectHeight(CheckListBoxData.CheckImageRect) div 2;
           if Checked
           then
             SkinDrawCheckImage(CR.Left, CR.Top, Picture.Canvas, CheckListBoxData.CheckImageRect, Buffer.Canvas)
           else
             SkinDrawCheckImage(CR.Left, CR.Top, Picture.Canvas, CheckListBoxData.UnCheckImageRect, Buffer.Canvas);
           Inc(R.Left, RectWidth(CheckListBoxData.CheckImageRect) + 5);
           FCheckOffset := RectWidth(CheckListBoxData.CheckImageRect) + 5;
         end
       else
        if FShowCheckBoxes and (CheckListBoxData = nil)
        then
         begin
           CR := Rect(R.Left, R.Top,
             R.Left + 12, R.Bottom);
           CR.Top := CR.Top + RectHeight(CR) div 2 - 10 div 2;
           if Checked
           then
             DrawCheckImage(Buffer.Canvas, CR.Left + 2, CR.Top, ListBoxData.ActiveFontColor);
           Inc(R.Left, 14);
           FCheckOffset := 14;
         end;

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

procedure TbsSkinOfficeListBox.DefaultDrawItem(Index: Integer; Cnvs: TCanvas);
var
  R, R1, CR: TRect;
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
      if FHeaderLeftAlignment
      then
        DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), R,
          DT_LEFT or DT_VCENTER or DT_SINGLELINE)
      else
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

       if FShowCheckBoxes
        then
         begin
           Inc(R.Left, 14);
           FCheckOffset := 14;
         end;

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

       if FShowCheckBoxes
       then
        begin
          R := FItems[Index].ItemRect;
          CR := Rect(R.Left, R.Top,
            R.Left + 12, R.Bottom);
          CR.Top := CR.Top + RectHeight(CR) div 2 - 10 div 2;
          C := Cnvs.Pen.Color;
          if Checked
          then
            DrawCheckImage(Cnvs, CR.Left + 2, CR.Top, FC);
          Cnvs.Pen.Color := C;
        end;

    end;
  if FItems[Index].Active and Focused
  then
    Cnvs.DrawFocusRect(FItems[Index].ItemRect);
  RestoreDC(Cnvs.Handle, SaveIndex);   
end;

procedure TbsSkinOfficeListBox.SkinDrawHeaderItem(Index: Integer; Cnvs: TCanvas);
var
  Buffer: TBitMap;
  CIndex: Integer;
  LData: TbsDataSkinLabelControl;
  R, TR: TRect;
  CPicture: TBitMap;
begin
  CIndex := SkinData.GetControlIndex(FHeaderSkinDataName);
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
  TR := Rect(1, 1, Buffer.Width - 1, Buffer.Height - 1);

  if FHeaderLeftAlignment then TR.Left := LData.ClRect.Left;

  with Buffer.Canvas, LData do
  begin
    Font.Name := FontName;
    Font.Color := FontColor;
    Font.Height := FontHeight;
    Font.Style := FontStyle;
    Brush.Style := bsClear;
  end;
  with FItems[Index] do
    if FHeaderLeftAlignment
    then
      DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR,
       DT_LEFT or DT_VCENTER or DT_SINGLELINE)
    else
      DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR,
       DT_CENTER or DT_VCENTER or DT_SINGLELINE);

  Cnvs.Draw(R.Left, R.Top, Buffer);
  Buffer.Free;
end;


procedure TbsSkinOfficeListBox.SetItemIndex(Value: Integer);
var
  I: Integer;
  IsFind: Boolean;
begin
  if Value < 0
  then
    begin
      FItemIndex := Value;
      RePaint;
    end
  else
    begin
      FItemIndex := Value;
      IsFind := False;
      for I := 0 to FItems.Count - 1 do
        with FItems[I] do
        begin
          if I = FItemIndex
          then
            begin
              Active := True;
              IsFind := True;
            end
          else
             Active := False;
        end;
      RePaint;
      ScrollToItem(FItemIndex);
      if IsFind and not (csDesigning in ComponentState) and not (csLoading in ComponentState)
      then
      begin
        if Assigned(FItems[FItemIndex].OnClick) then
          FItems[FItemIndex].OnClick(Self);
        if Assigned(FOnItemClick) then
          FOnItemClick(Self);
      end;    
    end;
end;

procedure TbsSkinOfficeListBox.Loaded;
begin
  inherited;
end;

function TbsSkinOfficeListBox.ItemAtPos(X, Y: Integer): Integer;
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


procedure TbsSkinOfficeListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
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

procedure TbsSkinOfficeListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var
  I: Integer;
  P: TPoint;
begin
  inherited;
  FMouseDown := False;
  I := ItemAtPos(X, Y);
  if (I <> -1) and not (FItems[I].Header) and (Button = mbLeft) then ItemIndex := I;
  if FShowCheckBoxes and (I <> -1) and (I = ItemIndex)
  then
    begin
      P.X := FItems[I].ItemRect.Left;
      if X < P.X + FCheckOffset
      then
        begin
          Items[I].Checked := not Items[I].Checked;
          if Assigned(FOnItemCheckClick) then FOnItemCheckClick(Self);
        end;
    end;
end;

procedure TbsSkinOfficeListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
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

procedure TbsSkinOfficeListBox.SetItemActive(Value: Integer);
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

procedure TbsSkinOfficeListBox.WMMOUSEWHEEL(var Message: TMessage);
begin
  inherited;
  if ScrollBar = nil then Exit;
  if Message.WParam < 0
  then
    ScrollBar.Position :=  ScrollBar.Position + ScrollBar.SmallChange
  else
    ScrollBar.Position :=  ScrollBar.Position - ScrollBar.SmallChange;

end;

procedure TbsSkinOfficeListBox.WMSETFOCUS(var Message: TWMSETFOCUS);
begin
  inherited;
  RePaint;
end;

procedure TbsSkinOfficeListBox.WMKILLFOCUS(var Message: TWMKILLFOCUS); 
begin
  inherited;
  RePaint;
end;

procedure TbsSkinOfficeListBox.WndProc(var Message: TMessage);
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

procedure TbsSkinOfficeListBox.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
end;

procedure TbsSkinOfficeListBox.FindUp;
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

procedure TbsSkinOfficeListBox.FindDown;
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

procedure TbsSkinOfficeListBox.FindPageUp;
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


procedure TbsSkinOfficeListBox.FindPageDown;
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

procedure TbsSkinOfficeListBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if FShowCheckBoxes and (Key = 32) and (ItemIndex <> -1)
  then
    begin
      Items[ItemIndex].Checked := not Items[ItemIndex].Checked;
      if Assigned(FOnItemCheckClick) then FOnItemCheckClick(Self);
    end;
end;


procedure TbsSkinOfficeListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
 inherited KeyDown(Key, Shift);
 case Key of
   VK_NEXT:  FindPageDown;
   VK_PRIOR: FindPageUp;
   VK_UP, VK_LEFT: FindUp;
   VK_DOWN, VK_RIGHT: FindDown;
 end;
end;


constructor TbsPopupOfficeListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable,
    csAcceptsControls];
  Visible := False;
  FOldAlphaBlend := False;
  FOldAlphaBlendValue := 0;
end;

procedure TbsPopupOfficeListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := WS_POPUP or WS_CLIPCHILDREN;
    ExStyle := WS_EX_TOOLWINDOW;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    if CheckWXP then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW_;
  end;
end;

procedure TbsPopupOfficeListBox.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TbsPopupOfficeListBox.Hide;
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  Visible := False;
end;

procedure TbsPopupOfficeListBox.Show(Origin: TPoint);
var
  PLB: TbsSkinOfficeComboBox;
  I: Integer;
  TickCount: DWORD;
  AnimationStep: Integer;
begin
  PLB := nil;
  //
  if CheckW2KWXP and (Owner is TbsSkinCustomOfficeComboBox)
  then
    begin
      PLB := TbsSkinOfficeComboBox(Owner);
      if PLB.AlphaBlend and not FOldAlphaBlend
      then
        begin
          SetWindowLong(Handle, GWL_EXSTYLE,
                        GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
        end
      else
      if not PLB.AlphaBlend and FOldAlphaBlend
      then
        begin
         SetWindowLong(Handle, GWL_EXSTYLE,
            GetWindowLong(Handle, GWL_EXSTYLE) and (not WS_EX_LAYERED));
        end;
      FOldAlphaBlend := PLB.AlphaBlend;
      if (FOldAlphaBlendValue <> PLB.AlphaBlendValue) and PLB.AlphaBlend
      then
        begin
          if PLB.AlphaBlendAnimation
          then
            begin
              SetAlphaBlendTransparent(Handle, 0);
              FOldAlphaBlendValue := 0;
            end
          else
            begin
              SetAlphaBlendTransparent(Handle, PLB.AlphaBlendValue);
              FOldAlphaBlendValue := PLB.AlphaBlendValue;
             end;
        end;
    end;
  //
  SetWindowPos(Handle, HWND_TOP, Origin.X, Origin.Y, 0, 0,
    SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE);
  Visible := True;
  if CheckW2KWXP and (PLB <> nil) and PLB.AlphaBlendAnimation and PLB.AlphaBlend
  then
    begin
      Application.ProcessMessages;
      PLB.FLBDown := False;
      I := 0;
      TickCount := 0;
      AnimationStep := PLB.AlphaBlendValue div 15;
      if AnimationStep = 0 then AnimationStep := 1;
      repeat
        if (GetTickCount - TickCount > 5)
        then
          begin
            TickCount := GetTickCount;
            Inc(i, AnimationStep);
            if i > PLB.AlphaBlendValue then i := PLB.AlphaBlendValue;
            SetAlphaBlendTransparent(Handle, i);
          end;
      until i >= PLB.FAlphaBlendValue;
    end;
end;

// combobox

constructor TbsSkinCustomOfficeComboBox.Create;
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csReplicatable, csOpaque, csDoubleClicks, csAcceptsControls];
  FListBox := TbsPopupOfficeListBox.Create(Self);
  FShowItemTitle := True;
  FShowItemImage := True;
  FShowItemText := True;
  FDropDown := False;
  FToolButtonStyle := False;
  TabStop := True;
  //
  FUseSkinSize := True;
  FLBDown := False;
  WasInLB := False;
  TimerMode := 0;
  FHideSelection := True;
  FDefaultColor := clWindow;
  FAlphaBlendAnimation := False;
  FAlphaBlend := False;
  Font.Name := 'Arial';
  Font.Color := clWindowText;
  Font.Style := [];
  Font.Height := 14;
  Width := 120;
  Height := 41;
  //
  FListBoxWindowProc := FlistBox.WindowProc;
  FlistBox.WindowProc := ListBoxWindowProcHook;
  FListBox.Visible := False;
  FlistBox.MouseMoveChangeIndex := True;
  if not (csDesigning in ComponentState)
  then
    FlistBox.Parent := Self;
  FLBDown := False;
  //
  CalcRects;
  FSkinDataName := 'combobox';
  FUseSkinSize := False;
  FLastTime := 0;
  FListBoxWidth := 0;
  FListBoxHeight := 0;
  FDropDownCount := 7;
end;

procedure TbsSkinCustomOfficeComboBox.BeginUpdateItems;
begin
  FListBox.BeginUpdateItems;
end;

procedure TbsSkinCustomOfficeComboBox.EndUpdateItems;
begin
  FListBox.EndUpdateItems;
end;

procedure TbsSkinCustomOfficeComboBox.ListBoxWindowProcHook(var Message: TMessage);
var
  FOld: Boolean;
begin
  FOld := True;
  case Message.Msg of
     WM_LBUTTONDOWN:
       begin
         FOLd := False;
         FLBDown := True;
         WasInLB := True;
         SetCapture(Self.Handle);
       end;
     WM_LBUTTONUP,
     WM_RBUTTONDOWN, WM_RBUTTONUP,
     WM_MBUTTONDOWN, WM_MBUTTONUP:
       begin
         FOLd := False;
       end;
     WM_MOUSEACTIVATE:
      begin
        Message.Result := MA_NOACTIVATE;
      end;
  end;
  if FOld then FListBoxWindowProc(Message);
end;

procedure TbsSkinCustomOfficeComboBox.DrawMenuMarker;
var
  Buffer: TBitMap;
  SR: TRect;
  X, Y: Integer;
begin
  with ButtonData do
  begin
    if ADown and not IsNullRect(MenuMarkerDownRect)
     then SR := MenuMarkerDownRect else
      if AActive and not IsNullRect(MenuMarkerActiveRect)
      then SR := MenuMarkerActiveRect else SR := MenuMarkerRect;

    if ADown and IsNullRect(MenuMarkerDownRect) and
        not IsNullRect(MenuMarkerActiveRect)
    then SR := MenuMarkerActiveRect;
    
  end;

  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(SR);
  Buffer.Height := RectHeight(SR);

  Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
    Picture.Canvas, SR);

  Buffer.Transparent := True;
  Buffer.TransparentMode := tmFixed;
  Buffer.TransparentColor := ButtonData.MenuMarkerTransparentColor;

  X := R.Left + RectWidth(R) div 2 - RectWidth(SR) div 2;
  Y := R.Top + RectHeight(R) div 2 - RectHeight(SR) div 2;

  C.Draw(X, Y, Buffer);

  Buffer.Free;
end;


procedure TbsSkinCustomOfficeComboBox.SetToolButtonStyle;
begin
  if FToolButtonStyle <> Value
  then
    begin
      FToolButtonStyle := Value;
      if FToolButtonStyle
      then
        begin
          UseSkinSize := False;
        end;
      RePaint;
    end;
end;

procedure TbsSkinCustomOfficeComboBox.SetDefaultColor(Value: TColor);
begin
  FDefaultColor := Value;
  if FIndex = -1 then Invalidate;
end;

procedure TbsSkinCustomOfficeComboBox.PaintSkinTo(C: TCanvas; X, Y: Integer; AText: String);
var
  B: TBitMap;
  R: TRect;
  S: String;
begin
  B := TBitmap.Create;
  B.Width := Width;
  B.Height := Height;
  GetSkinData;
  S := Self.Text;
  Text := AText;

  if FToolButtonStyle
  then
    begin
      if FIndex <> -1
      then
        CreateControlToolSkinImage(B, AText)
      else
        Self.CreateControlToolDefaultImage(B, AText);
    end
  else
  if Findex = -1
  then
    begin
      CreateControlDefaultImage2(B);
      with B.Canvas.Font do
      begin
        Name := Self.DefaultFont.Name;
        Style := Self.DefaultFont.Style;
        Color := Self.DefaultFont.Color;
        Height := Self.DefaultFont.Height;
      end;
    end
  else
    begin
      CreateControlSkinImage2(B);
      with B.Canvas.Font do
      begin
        Style := FontStyle;
        Color := FontColor;
        Height := FontHeight;
        Name := FontName;
      end;
    end;
  // draw item area

  if not FToolButtonStyle
  then
    begin
      B.Canvas.Brush.Style := bsClear;
      BSDrawText2(B.Canvas, AText, CBItem.R);
    end;
  C.Draw(X, Y, B);
  B.Free;
  Text := S;  
end;


procedure TbsSkinCustomOfficeComboBox.SetControlRegion;
begin
  if FUseSkinSize then inherited;
end;

procedure TbsSkinCustomOfficeComboBox.WMEraseBkgnd;
var
  SaveIndex: Integer;
begin
  if not FromWMPaint
  then
    begin
      PaintWindow(Msg.DC);
    end;
end;

procedure TbsSkinCustomOfficeComboBox.CalcSize(var W, H: Integer);
var
  XO, YO: Integer;
begin
  if FUseSkinSize
  then
    inherited
  else
    begin
      XO := W - RectWidth(SkinRect);
      YO := H - RectHeight(SkinRect);
      NewLTPoint := LTPt;
      NewRTPoint := Point(RTPt.X + XO, RTPt.Y );
      NewClRect := ClRect;
      Inc(NewClRect.Right, XO);
    end;
end;

procedure TbsSkinCustomOfficeComboBox.KeyPress;
begin
  inherited;
end;

destructor TbsSkinCustomOfficeComboBox.Destroy;
begin
  FlistBox.Free;
  FlistBox := nil;
  inherited;
end;

procedure TbsSkinCustomOfficeComboBox.CMEnabledChanged;
begin
  inherited;
  RePaint;
end;

function TbsSkinCustomOfficeComboBox.GetListBoxUseSkinFont: Boolean;
begin
  Result := FListBox.UseSkinFont;
end;

function TbsSkinCustomOfficeComboBox.GetListBoxHeaderLeftAlignment: Boolean;
begin
  Result := FListBox.HeaderLeftAlignment;
end;

procedure TbsSkinCustomOfficeComboBox.SetListBoxHeaderLeftAlignment(Value: Boolean);
begin
  FListBox.HeaderLeftAlignment := Value;
end;

procedure TbsSkinCustomOfficeComboBox.SetListBoxUseSkinFont(Value: Boolean);
begin
  FListBox.UseSkinFont := Value;
end;

procedure TbsSkinCustomOfficeComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;

function TbsSkinCustomOfficeComboBox.GetImages: TCustomImageList;
begin
  if FListBox <> nil
  then
    Result := FListBox.Images
   else
    Result := nil;
end;

procedure TbsSkinCustomOfficeComboBox.CMCancelMode;
begin
  inherited;
  if (Message.Sender = nil) or (
     (Message.Sender <> Self) and
     (Message.Sender <> Self.FListBox) and
     (Message.Sender <> Self.FListBox.ScrollBar))
  then
    CloseUp(False);
end;

procedure TbsSkinCustomOfficeComboBox.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TbsSkinCustomOfficeComboBox.GetListBoxDefaultFont;
begin
  Result := FListBox.DefaultFont;
end;

procedure TbsSkinCustomOfficeComboBox.SetListBoxDefaultFont;
begin
  FListBox.DefaultFont.Assign(Value);
end;

procedure TbsSkinCustomOfficeComboBox.DefaultFontChange;
begin
  Font.Assign(FDefaultFont);
end;

procedure TbsSkinCustomOfficeComboBox.CheckButtonClick;
begin
  CloseUp(True);
end;

procedure TbsSkinCustomOfficeComboBox.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  case Msg.CharCode of
    VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT:  Msg.Result := 1;
  end;
end;

procedure TbsSkinCustomOfficeComboBox.KeyDown;
var
  I: Integer;
begin
  inherited KeyDown(Key, Shift);
  case Key of
    VK_UP, VK_LEFT:
      if ssAlt in Shift
      then
        begin
          if FListBox.Visible then CloseUp(False);
        end
      else
        EditUp1(True);
    VK_DOWN, VK_RIGHT:
      if ssAlt in Shift
      then
        begin
          if not FListBox.Visible then DropDown;
        end
      else
        EditDown1(True);

    VK_NEXT: EditPageDown1(True);
    VK_PRIOR: EditPageUp1(True);
    VK_ESCAPE: if FListBox.Visible then CloseUp(False);
    VK_RETURN: if FListBox.Visible then CloseUp(True);
  end;
end;


procedure TbsSkinCustomOfficeComboBox.WMMOUSEWHEEL;
begin
  inherited;
  if Message.WParam > 0
  then
    EditUp1(not FListBox.Visible)
  else
    EditDown1(not FListBox.Visible);
end;

procedure TbsSkinCustomOfficeComboBox.WMSETFOCUS;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinCustomOfficeComboBox.WMKILLFOCUS;
begin
  inherited;
  if FListBox.Visible  then CloseUp(False);
  RePaint;
end;

procedure TbsSkinCustomOfficeComboBox.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinComboBox
    then
      with TbsDataSkinComboBox(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.ActiveSkinRect := ActiveSkinRect;
        Self.ActiveFontColor := ActiveFontColor;
        Self.SItemRect := SItemRect;
        Self.ActiveItemRect := ActiveItemRect;
        Self.FocusItemRect := FocusItemRect;
        if isNullRect(FocusItemRect)
        then
          Self.FocusItemRect := SItemRect;
        Self.ItemLeftOffset := ItemLeftOffset;
        Self.ItemRightOffset := ItemRightOffset;
        Self.ItemTextRect := ItemTextRect;

        Self.FontName := FontName;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.FontColor := FontColor;
        Self.FocusFontColor := FocusFontColor;

        Self.ButtonRect := ButtonRect;
        Self.ActiveButtonRect := ActiveButtonRect;
        Self.DownButtonRect := DownButtonRect;
        Self.UnEnabledButtonRect := UnEnabledButtonRect;
        Self.ListBoxName := ListBoxName;
        Self.ItemStretchEffect := ItemStretchEffect;
        Self.FocusItemStretchEffect := FocusItemStretchEffect;
        Self.ShowFocus := ShowFocus;
      end;
end;

procedure TbsSkinCustomOfficeComboBox.Invalidate;
begin
  inherited;
end;


function TbsSkinCustomOfficeComboBox.GetItemIndex;
begin
  Result := FListBox.ItemIndex;
end;

procedure TbsSkinCustomOfficeComboBox.SetItemIndex;
begin
  FListBox.ItemIndex := Value;
  FOldItemIndex := FListBox.ItemIndex;
  RePaint;
  if not (csDesigning in ComponentState) and
     not (csLoading in ComponentState)
  then
    begin
      if Assigned(FOnClick) then FOnClick(Self);
      Change;
    end;
end;

function TbsSkinCustomOfficeComboBox.IsPopupVisible: Boolean;
begin
  Result := FListBox.Visible;
end;

function TbsSkinCustomOfficeComboBox.CanCancelDropDown;
begin
  Result := FListBox.Visible and not FMouseIn;
end;

procedure TbsSkinCustomOfficeComboBox.StartTimer;
begin
  KillTimer(Handle, 1);
  SetTimer(Handle, 1, 25, nil);
end;

procedure TbsSkinCustomOfficeComboBox.StopTimer;
begin
  KillTimer(Handle, 1);
  TimerMode := 0;
end;

procedure TbsSkinCustomOfficeComboBox.WMTimer;
begin
  inherited;
  case TimerMode of
    1: FListBox.FindUp;
    2: FListBox.FindDown;
  end;
end;

procedure TbsSkinCustomOfficeComboBox.ProcessListBox;
var
  R: TRect;
  P: TPoint;
  LBP: TPoint;
begin
  GetCursorPos(P);
  P := FListBox.ScreenToClient(P);
  if (P.Y < 0) and (FListBox.ScrollBar <> nil) and WasInLB
  then
    begin
      if (TimerMode <> 1)
      then
        begin
          TimerMode := 1;
          StartTimer;
        end;
    end
  else
  if (P.Y > FListBox.Height) and (FListBox.ScrollBar <> nil) and WasInLB
  then
    begin
      if (TimerMode <> 2)
      then
        begin
          TimerMode := 2;
          StartTimer;
        end
    end
  else
    if (P.Y >= 0) and (P.Y <= FListBox.Height)
    then
      begin
        if TimerMode <> 0 then StopTimer;
        FListBox.MouseMove([], P.X, P.Y);
        WasInLB := True;
        if not FLBDown
        then
          begin
            FLBDown := True;
            WasInLB := False;
          end;  
      end;
end;

procedure TbsSkinCustomOfficeComboBox.CMMouseEnter;
begin
  inherited;
  FMouseIn := True;
  //
  if ((FIndex <> -1) and not IsNullRect(ActiveSkinRect)) or FToolButtonStyle
  then
    Invalidate;
end;

procedure TbsSkinCustomOfficeComboBox.CMMouseLeave;
begin
  inherited;
  FMouseIn := False;
  if Button.MouseIn
  then
    begin
      Button.MouseIn := False;
      RePaint;
    end;
  //
 if ((FIndex <> -1) and not IsNullRect(ActiveSkinRect)) or FToolButtonStyle
 then
   Invalidate;
end;

procedure TbsSkinCustomOfficeComboBox.SetDropDownCount(Value: Integer);
begin
  if Value >= 0
  then
    FDropDownCount := Value;
end;

procedure TbsSkinCustomOfficeComboBox.SetItems;
begin
  FListBox.Items.Assign(Value);
end;

function TbsSkinCustomOfficeComboBox.GetItems;
begin
  Result := FListBox.Items;
end;

procedure TbsSkinCustomOfficeComboBox.MouseDown;
begin
  inherited;
  if not Focused then SetFocus;
  if Button <> mbLeft then Exit;
  if Self.Button.MouseIn or
     PtInRect(CBItem.R, Point(X, Y)) or
     FToolButtonStyle
  then
    begin
      Self.Button.Down := True;
      RePaint;
      if FListBox.Visible then CloseUp(False)
      else
        begin
          WasInLB := False;
          FLBDown := True;
          DropDown;
        end;
    end
  else
    if FListBox.Visible then CloseUp(False);
end;

procedure TbsSkinCustomOfficeComboBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
var
  P: TPoint;
begin
  if FLBDown and WasInLB
  then
    begin
      ReleaseCapture;
      FLBDown := False;
      GetCursorPos(P);
      if WindowFromPoint(P) = FListBox.Handle
      then
        CloseUp(True)
      else
        CloseUp(False);
    end
  else
     FLBDown := False;
  inherited;
  if Self.Button.Down
  then
    begin
      Self.Button.Down := False;
      RePaint;
    end;
end;

procedure TbsSkinCustomOfficeComboBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if FListBox.Visible then ProcessListBox;
  if PtInRect(Button.R, Point(X, Y)) and not Button.MouseIn
  then
    begin
      Button.MouseIn := True;
      RePaint;
    end
  else
  if not PtInRect(Button.R, Point(X, Y)) and Button.MouseIn
  then
    begin
      Button.MouseIn := False;
      RePaint;
    end
end;

procedure TbsSkinCustomOfficeComboBox.CloseUp;
begin
  if TimerMode <> 0 then StopTimer;
  if not FListBox.Visible then Exit;
  FListBox.Hide;
  if (FListBox.ItemIndex >= 0) and
     (FListBox.ItemIndex < FListBox.Items.Count) and Value
  then
    begin
       RePaint;
       if Assigned(FOnClick) then FOnClick(Self);
       Change;
     end
  else
    FListBox.ItemIndex := FOldItemIndex;
  FDropDown := False;  
  RePaint;
  if Value
  then
    if Assigned(FOnCloseUp) then FOnCloseUp(Self);
end;

procedure TbsSkinCustomOfficeComboBox.DropDown;
function GetForm(AControl : TControl) : TForm;
  var
    temp : TControl;
  begin
    result := nil;
    temp := AControl;
    repeat
      if assigned(temp) then
      begin
        if temp is TForm then
        break;
      end;
      temp := temp.Parent;
    until temp = nil;
  end;

var
  P: TPoint;
  WorkArea: TRect;
begin
  if Items.Count = 0 then Exit;
  WasInLB := False;
  if TimerMode <> 0 then StopTimer;
  if Assigned(FOnDropDown) then FOnDropDown(Self);

  if FListBoxWidth = 0
  then
    FListBox.Width := Width
  else
    FListBox.Width := FListBoxWidth;

  //

  FListBox.OnDrawItem := Self.OnDrawItem;

  // P := Point(Left, Top + Height);
  P := Point(Left + Width - FListBox.Width, Top + Height);
  P := Parent.ClientToScreen (P);

  WorkArea := GetMonitorWorkArea(Handle, True);

  if P.Y + FListBox.Height > WorkArea.Bottom
  then
    P.Y := P.Y - Height - FListBox.Height;

  FOldItemIndex := FListBox.ItemIndex;

  if (FListBox.ItemIndex = 0) and (FListBox.Items.Count > 1)
  then
    begin
      FListBox.ItemIndex := 1;
      FListBox.ItemIndex := 0;
    end;
  FDropDown := True;
  if Self.FToolButtonStyle then  RePaint;
  FListBox.SkinData := SkinData;
   if FListBoxHeight > 0
  then
    FListBox.Height := FListBoxHeight
  else
  if FDropDownCount > 0
  then
    begin
      FListBox.Height := FListBox.CalcHeight(FDropDownCount); 
    end;
  FListBox.Show(P);
end;

procedure TbsSkinCustomOfficeComboBox.WMSIZE;
begin
  inherited;
  CalcRects;
end;

procedure TbsSkinCustomOfficeComboBox.DrawResizeButton;
var
  Buffer, Buffer2: TBitMap;
  CIndex: Integer;
  ButtonData: TbsDataSkinButtonControl;
  BtnSkinPicture: TBitMap;
  BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint: TPoint;
  SR, BtnCLRect: TRect;
  BSR, ABSR, DBSR: TRect;
  XO, YO: Integer;
  ArrowColor: TColor;
  X, Y: Integer;
begin
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(Button.R);
  Buffer.Height := RectHeight(Button.R);
  //
  CIndex := SkinData.GetControlIndex('combobutton');
  if CIndex = -1
  then
    CIndex := SkinData.GetControlIndex('editbutton');
  if CIndex = -1 then CIndex := SkinData.GetControlIndex('resizebutton');
  if CIndex = -1
  then
    begin
      Buffer.Free;
      Exit;
    end
  else
    ButtonData := TbsDataSkinButtonControl(SkinData.CtrlList[CIndex]);
  //
  with ButtonData do
  begin
    XO := RectWidth(Button.R) - RectWidth(SkinRect);
    YO := RectHeight(Button.R) - RectHeight(SkinRect);
    BtnLTPoint := LTPoint;
    BtnRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
    BtnLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
    BtnRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
    BtnClRect := Rect(CLRect.Left, ClRect.Top,
      CLRect.Right + XO, ClRect.Bottom + YO);
    BtnSkinPicture := TBitMap(SkinData.FActivePictures.Items[ButtonData.PictureIndex]);

    BSR := SkinRect;
    ABSR := ActiveSkinRect;
    DBSR := DownSkinRect;
    if IsNullRect(ABSR) then ABSR := BSR;
    if IsNullRect(DBSR) then DBSR := ABSR;
    //
    if Button.Down and Button.MouseIn
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, DBSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        ArrowColor := DownFontColor;
      end
    else
    if Button.MouseIn
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, ABSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        ArrowColor := ActiveFontColor;
      end
    else
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, BSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        ArrowColor := FontColor;
      end;
   end;
  //
  if not IsNullRect(ButtonData.MenuMarkerRect)
  then
    with ButtonData do
    begin
      if Button.Down and Button.MouseIn and not IsNullRect(MenuMarkerDownRect)
      then SR := MenuMarkerDownRect else
        if Button.MouseIn and not IsNullRect(MenuMarkerActiveRect)
          then SR := MenuMarkerActiveRect else SR := MenuMarkerRect;

      Buffer2 := TBitMap.Create;
      Buffer2.Width := RectWidth(SR);
      Buffer2.Height := RectHeight(SR);

      Buffer2.Canvas.CopyRect(Rect(0, 0, Buffer2.Width, Buffer2.Height),
       Picture.Canvas, SR);

      Buffer2.Transparent := True;
      Buffer2.TransparentMode := tmFixed;
      Buffer2.TransparentColor := MenuMarkerTransparentColor;

      X := RectWidth(Button.R) div 2 - RectWidth(SR) div 2;
      Y := RectHeight(Button.R) div 2 - RectHeight(SR) div 2;
      if Button.Down and Button.MouseIn then Y := Y + 1;
      Buffer.Canvas.Draw(X, Y, Buffer2);
      Buffer2.Free;
    end
  else
  if Enabled
  then
    begin
      if Button.Down and Button.MouseIn
      then
        DrawArrowImage(Buffer.Canvas, Rect(0, 2, Buffer.Width, Buffer.Height), ArrowColor, 4)
      else
        DrawArrowImage(Buffer.Canvas, Rect(0, 0, Buffer.Width, Buffer.Height), ArrowColor, 4);
    end;
  //
  C.Draw(Button.R.Left, Button.R.Top, Buffer);
  Buffer.Free;
end;

procedure TbsSkinCustomOfficeComboBox.DrawButton;
var
  ArrowColor: TColor;
  R1: TRect;
begin
  if FIndex = -1
  then
    with Button do
    begin
      R1 := R;
      if Down and MouseIn
      then
        begin
          Frame3D(C, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          C.Brush.Color := BS_XP_BTNDOWNCOLOR;
          C.FillRect(R1);
        end
      else
        if MouseIn
        then
          begin
            Frame3D(C, R1, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
            C.Brush.Color := BS_XP_BTNACTIVECOLOR;
            C.FillRect(R1);
          end
        else
          begin
            Frame3D(C, R1, clBtnShadow, clBtnShadow, 1);
            C.Brush.Color := clBtnFace;
            C.FillRect(R1);
          end;
      if Enabled
      then
        ArrowColor := clBlack
      else
        ArrowColor := clBtnShadow;
      DrawArrowImage(C, R, ArrowColor, 4);
    end
  else
    with Button do
    begin
      R1 := NullRect;
      if not Enabled and not IsNullRect(UnEnabledButtonRect)
      then
        R1 := UnEnabledButtonRect
      else
      if Down and MouseIn
      then R1 := DownButtonRect
      else if MouseIn then R1 := ActiveButtonRect;
      if not IsNullRect(R1)
      then
        C.CopyRect(R, Picture.Canvas, R1);
    end;
end;

procedure TbsSkinCustomOfficeComboBox.DrawDefaultItem;
var
  Buffer: TBitMap;
  R, R1, TR: TRect;
  Index, IIndex, IX, IY: Integer;
begin
  if RectWidth(CBItem.R) <=0 then Exit;
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(CBItem.R);
  Buffer.Height := RectHeight(CBItem.R);
  R := Rect(0, 0, Buffer.Width, Buffer.Height);
  with Buffer.Canvas do
  begin
    Font.Name := Self.Font.Name;
    Font.Style := Self.Font.Style;
    Font.Height := Self.Font.Height;
    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Font.Charset := SkinData.ResourceStrData.CharSet
    else
      Font.Charset := FDefaultFont.Charset;
    if Focused
    then
      begin
        Brush.Color := clHighLight;
        Font.Color := clHighLightText;
      end
    else
      begin
        Brush.Color := FDefaultColor;
        Font.Color := FDefaultFont.Color;
      end;
    FillRect(R);
  end;

  if FListBox.Visible
  then Index := FOldItemIndex
  else Index := FListBox.ItemIndex;

  CBItem.State := [];

  if Focused then CBItem.State := [odFocused];

  R1 := Rect(R.Left + 2, R.Top, R.Right - 2, R.Bottom);
  if (Index > -1) and (Index < FListBox.Items.Count)
  then
    begin
      if Assigned(FOnDrawItem)
      then
        begin
          Buffer.Canvas.Brush.Style := bsClear;
          FOnDrawItem(Buffer.Canvas, Index, R1);
        end
      else
      begin
       if FShowItemText and FShowItemTitle and (Items[Index].Title <> '')
        then
          begin
            Buffer.Canvas.Font.Style := Buffer.Canvas.Font.Style + [fsBold];
            TR := R1;
            TR.Bottom := TR.Top + Buffer.Canvas.TextHeight(Items[Index].Title);
            DrawText(Buffer.Canvas.Handle, PChar(Items[Index].Title),
              Length(Items[Index].Title), TR, DT_LEFT);
            Buffer.Canvas.Font.Style := Buffer.Canvas.Font.Style - [fsBold];
            R1.Top := TR.Bottom - 2;
          end;
        if FShowItemText and not FShowItemImage
        then
          BSDrawText2(Buffer.Canvas, Items[Index].Caption, R1)
        else
        if FShowItemImage
        then
          begin
            if FShowItemText
            then
              DrawImageAndText2(Buffer.Canvas, R1, 0, 2, blGlyphLeft,
               Items[Index].Caption, Items[Index].ImageIndex, Images,
               False, Enabled, False, 0)
            else
               DrawImageAndText2(Buffer.Canvas, R1, 0, 2, blGlyphLeft,
               '', Items[Index].ImageIndex, Images, False, Enabled, False, 0)
          end;
       end;   
    end;
  if Focused then DrawFocusRect(Buffer.Canvas.Handle, R);
  Cnvs.Draw(CBItem.R.Left, CBItem.R.Top, Buffer);
  Buffer.Free;
end;

procedure TbsSkinCustomOfficeComboBox.DrawResizeSkinItem(Cnvs: TCanvas);
var
  Buffer: TBitMap;
  R, R2, TR: TRect;
  W, H: Integer;
  Index, IIndex, IX, IY: Integer;
  Offset: Integer;
begin
  W := RectWidth(CBItem.R);
  if W <= 0 then Exit;
  H := RectHeight(SItemRect);
  if H = 0 then H := RectHeight(FocusItemRect);
  if H = 0 then H := RectWidth(CBItem.R);
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(CBItem.R);
  Buffer.Height := RectHeight(CBItem.R);
  if Focused
  then
    begin
      if not IsNullRect(FocusItemRect)
      then
        begin
          R2 := ItemTextRect;
          InflateRect(R2, -1, -1);
          
          if RectWidth(SItemRect) > RectWidth(FocusItemRect)
          then
            Dec(R2.Right, RectWidth(SItemRect) - RectWidth(FocusItemRect));

          if RectHeight(SItemRect) > RectHeight(FocusItemRect)
          then
            Dec(R2.Top, RectHeight(SItemRect) - RectHeight(FocusItemRect));

          CreateStretchImage(Buffer, Picture, FocusItemRect, R2, True);
        end
      else
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height), Cnvs, CBItem.R);
    end
  else
    begin
      if not IsNullRect(ActiveItemRect) and not IsNullRect(ActiveSkinRect) and
         FMouseIn
      then
        begin
           R2 := ItemTextRect;
          if RectWidth(SItemRect) > RectWidth(ActiveItemRect)
          then
            Dec(R2.Right, RectWidth(SItemRect) - RectWidth(ActiveItemRect));

          if RectHeight(SItemRect) > RectHeight(ActiveItemRect)
          then
            Dec(R2.Top, RectHeight(SItemRect) - RectHeight(ActiveItemRect));

          CreateStretchImage(Buffer, Picture, ActiveItemRect, R2, True)
        end
      else
      if not IsNullRect(SItemRect)
      then
        CreateStretchImage(Buffer, Picture, SItemRect, ItemTextRect, True)
      else
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height), Cnvs, CBItem.R);
    end;

  R := ItemTextRect;
  if not IsNullRect(SItemRect)
  then
    Inc(R.Right, W - RectWidth(SItemRect))
  else
    Inc(R.Right, W - RectWidth(ClRect));
  Inc(ItemTextRect.Bottom, Height - RectHeight(SkinRect));
  Inc(R.Bottom, Height - RectHeight(SkinRect));
  with Buffer.Canvas do
  begin
    if FUseSkinFont
    then
      begin
        Font.Name := FontName;
        Font.Style := FontStyle;
        Font.Height := FontHeight;
      end
    else
      Font.Assign(FDefaultFont);

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Font.Charset := SkinData.ResourceStrData.CharSet
    else
      Font.CharSet := FDefaultFont.CharSet;

    if Focused
    then
      Font.Color := FocusFontColor
    else
      if FMouseIn and not IsNullRect(ActiveSkinRect)
      then
        Font.Color := ActiveFontColor
      else
        Font.Color := FontColor;
    Brush.Style := bsClear;
  end;

  if FListBox.Visible
  then Index := FOldItemIndex
  else Index := FListBox.ItemIndex;

  if (Index > -1) and (Index < FListBox.Items.Count)
  then
      begin
       if Focused and ShowFocus
       then
        begin
          Buffer.Canvas.Brush.Style := bsSolid;
          Buffer.Canvas.Brush.Color := FSD.SkinColors.cBtnFace;
          Buffer.Canvas.DrawFocusRect(Rect(0, 0, Buffer.Width, Buffer.Height));
          Buffer.Canvas.Brush.Style := bsClear;
        end;
        Inc(R.Left, 1);
       if Assigned(FOnDrawItem)
       then
        begin
          Buffer.Canvas.Brush.Style := bsClear;
          FOnDrawItem(Buffer.Canvas, Index, R);
        end
      else
        begin
        if FShowItemText and FShowItemTitle and (Items[Index].Title <> '')
        then
          begin
            Buffer.Canvas.Font.Style := Buffer.Canvas.Font.Style + [fsBold];
            TR := R;
            TR.Bottom := TR.Top + Buffer.Canvas.TextHeight(Items[Index].Title);
            DrawText(Buffer.Canvas.Handle, PChar(Items[Index].Title),
              Length(Items[Index].Title), TR, DT_LEFT);
            Buffer.Canvas.Font.Style := Buffer.Canvas.Font.Style - [fsBold];
            R.Top := TR.Bottom - 2;
          end;

        if FShowItemText and not FShowItemImage
        then
          BSDrawText2(Buffer.Canvas, Items[Index].Caption, R)
        else
        if FShowItemImage
        then
          begin
            if FShowItemText
            then
              DrawImageAndText2(Buffer.Canvas, R, 0, 2, blGlyphLeft,
               Items[Index].Caption, Items[Index].ImageIndex, Images,
               False, Enabled, False, 0)
            else
               DrawImageAndText2(Buffer.Canvas, R, 0, 2, blGlyphLeft,
               '', Items[Index].ImageIndex, Images, False, Enabled, False, 0)
          end;

        end;  
      end;
  Cnvs.Draw(CBItem.R.Left, CBItem.R.Top, Buffer);
  Buffer.Free;
end;


function TbsSkinCustomOfficeComboBox.GetDisabledFontColor: TColor;
var
  i: Integer;
begin
  i := -1;
  if FIndex <> -1 then i := SkinData.GetControlIndex('edit');
  if i = -1
  then
    Result := clGrayText
  else
    Result := TbsDataSkinEditControl(SkinData.CtrlList[i]).DisabledFontColor;
end;

procedure TbsSkinCustomOfficeComboBox.DrawSkinItem;
var
  Buffer: TBitMap;
  R, R2: TRect;
  W, H: Integer;
  Index, IIndex, IX, IY: Integer;
begin
  W := RectWidth(CBItem.R);
  if W <= 0 then Exit;
  H := RectHeight(SItemRect);
  if H = 0 then H := RectHeight(FocusItemRect);
  if H = 0 then H := RectWidth(CBItem.R);
  Buffer := TBitMap.Create;
  if Focused
  then
    begin
      if not IsNullRect(FocusItemRect)
      then
        CreateHSkinImage(ItemLeftOffset, ItemRightOffset, Buffer, Picture,
          FocusItemRect, W, H, FocusItemStretchEffect)
      else
        begin
          Buffer.Width := W;
          BUffer.Height := H;
          Buffer.Canvas.CopyRect(Rect(0, 0, W, H), Cnvs, CBItem.R);
        end;
    end
  else
    begin
      if not IsNullRect(ActiveItemRect) and not IsNullRect(ActiveSkinRect) and
         FMouseIn
      then
        begin
          CreateHSkinImage(ItemLeftOffset, ItemRightOffset, Buffer, Picture,
            ActiveItemRect, W, H, ItemStretchEffect)
        end
      else
      if not IsNullRect(SItemRect)
      then
        CreateHSkinImage(ItemLeftOffset, ItemRightOffset, Buffer, Picture,
          SItemRect, W, H, ItemStretchEffect)
      else
        begin
          Buffer.Width := W;
          BUffer.Height := H;
          Buffer.Canvas.CopyRect(Rect(0, 0, W, H), Cnvs, CBItem.R);
        end;
    end;

  R := ItemTextRect;
  
  if not IsNullRect(SItemRect)
  then
    Inc(R.Right, W - RectWidth(SItemRect))
  else
    Inc(R.Right, W - RectWidth(ClRect));

  with Buffer.Canvas do
  begin
    if FUseSkinFont
    then
      begin
        Font.Name := FontName;
        Font.Style := FontStyle;
        Font.Height := FontHeight;
      end
    else
      Font.Assign(FDefaultFont);

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Font.Charset := SkinData.ResourceStrData.CharSet
    else
      Font.CharSet := FDefaultFont.CharSet;

    if Focused
    then
      Font.Color := FocusFontColor
    else
      if FMouseIn and not IsNullRect(ActiveSkinRect)
      then
        Font.Color := ActiveFontColor
      else
        Font.Color := FontColor;
    if not Enabled then Font.Color := GetDisabledFontColor;
    Brush.Style := bsClear;
  end;

  if FListBox.Visible
  then Index := FOldItemIndex
  else Index := FListBox.ItemIndex;

  if (Index > -1) and (Index < FListBox.Items.Count)
  then
      begin

       if Assigned(FOnDrawItem)
       then
        begin
          Buffer.Canvas.Brush.Style := bsClear;
          FOnDrawItem(Buffer.Canvas, Index, R);
        end
       else
        begin
        if FShowItemText and not FShowItemImage
        then
          BSDrawText2(Buffer.Canvas, FListBox.Items[Index].Caption, R)
        else
        if FShowItemImage
        then
          begin
            if FShowItemText
            then
              DrawImageAndText2(Buffer.Canvas, R, 0, 2, blGlyphLeft,
               Items[Index].Caption, Items[Index].ImageIndex, Images,
               False, Enabled, False, 0)
            else
               DrawImageAndText2(Buffer.Canvas, R, 0, 2, blGlyphLeft,
               '', Items[Index].ImageIndex, Images, False, Enabled, False, 0)
          end;
        end;  
      end;
  Cnvs.Draw(CBItem.R.Left, CBItem.R.Top, Buffer);
  Buffer.Free;
end;

procedure TbsSkinCustomOfficeComboBox.CalcRects;
const
  ButtonW = 17;
var
  OX, OY: Integer;
begin
  if (FIndex = -1) or FToolButtonStyle
  then
    begin
      Button.R := Rect(Width - ButtonW - 2, 2, Width - 2, Height - 2);
      CBItem.R := Rect(2, 2, Button.R.Left - 1 , Height -  2);
    end
  else
    begin
      OX := Width - RectWidth(SkinRect);
      Button.R := ButtonRect;
      if ButtonRect.Left >= RectWidth(SkinRect) - RTPt.X
      then
        OffsetRect(Button.R, OX, 0);
      CBItem.R := ClRect;
      Inc(CBItem.R.Right, OX);
      if not UseSkinSize
      then
        begin
          OY := Height - RectHeight(SkinRect);
          Inc(CBItem.R.Bottom, OY);
          Inc(Button.R.Bottom, OY);
        end;
    end;
end;

procedure TbsSkinCustomOfficeComboBox.ChangeSkinData;
var
  W, H: Integer;
begin
  inherited;
  CalcRects;

  RePaint;

  if FIndex = -1
  then
    begin
      FListBox.SkinDataName := '';
    end  
  else
    FListBox.SkinDataName := ListBoxSkinDataName;
  FListBox.SkinData := SkinData;
  //
  CalcRects;
end;


procedure TbsSkinCustomOfficeComboBox.CreateControlDefaultImage2;
var
  R: TRect;
begin
  CalcRects;
  with B.Canvas do
  begin
    Brush.Color := clBtnFace;
    R := ClientRect;
    FillRect(R);
  end;
  Frame3D(B.Canvas, R, clbtnShadow, clbtnShadow, 1);
  with B.Canvas do
  begin
    InflateRect(R, -1, -1);
    Brush.Color := FDefaultColor;
    FillRect(R);
  end;
  DrawButton(B.Canvas);
end;


procedure TbsSkinCustomOfficeComboBox.CreateControlDefaultImage;
var
  R: TRect;
begin
  CalcRects;
  if FToolButtonStyle
  then
    begin
      CreateControlToolDefaultImage(B, '');
      Exit;
    end;
  with B.Canvas do
  begin
    Brush.Color := clBtnFace;
    R := ClientRect;
    FillRect(R);
  end;
  Frame3D(B.Canvas, R, clbtnShadow, clbtnShadow, 1);
  with B.Canvas do
  begin
    InflateRect(R, -1, -1);
    Brush.Color := FDefaultColor;
    FillRect(R);
  end;
  DrawButton(B.Canvas);
  DrawDefaultItem(B.Canvas);
end;

procedure TbsSkinCustomOfficeComboBox.CreateControlToolDefaultImage(B: TBitMap; AText: String);
var
  XO, YO: Integer;
  R, TR: TRect;
  IX, IY, Index, IIndex: Integer;
  S: String;
begin

  R := Rect(0, 0, Width, Height);
  //
  if FDropDown
  then
    begin
      Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
      B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
      B.Canvas.FillRect(R);
    end
  else
  if FMouseIn or Focused
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
  // draw item

  R := Rect(2, 2, Width - 17, Height - 2);

  with B.Canvas do
  begin
    Font.Assign(FDefaultFont);
    Brush.Style := bsClear;
    if FListBox.Visible
    then Index := FOldItemIndex
    else Index := FListBox.ItemIndex;
    if (Index > -1) and (Index < FListBox.Items.Count)
    then
      begin
        if AText <> ''
        then
          S := AText
        else
          S := FListBox.Items[Index].Caption;
        if FShowItemText and FShowItemTitle and (Items[Index].Title <> '')
        then
          begin
            B.Canvas.Font.Style := B.Canvas.Font.Style + [fsBold];
            TR := R;
            TR.Bottom := TR.Top + B.Canvas.TextHeight(Items[Index].Title);
            DrawText(B.Canvas.Handle, PChar(Items[Index].Title),
              Length(Items[Index].Title), TR, DT_LEFT);
            B.Canvas.Font.Style := B.Canvas.Font.Style - [fsBold];
            R.Top := TR.Bottom - 2;
          end;
        if FShowItemText and not FShowItemImage
        then
          BSDrawText2(B.Canvas, S, R)
        else
        if FShowItemImage
        then
          begin
            if FShowItemText
            then
              DrawImageAndText2(B.Canvas, R, 0, 2, blGlyphLeft,
               S, Items[Index].ImageIndex, Images,
               False, Enabled, False, 0)
            else
               DrawImageAndText2(B.Canvas, R, 0, 2, blGlyphLeft,
               '', Items[Index].ImageIndex, Images, False, Enabled, False, 0)
          end;
       end;
  end;

  R := Rect(Width - 15, 0, Width, Height);

  DrawTrackArrowImage(B.Canvas, R, B.Canvas.Font.Color);
end;


procedure TbsSkinCustomOfficeComboBox.CreateControlToolSkinImage(B: TBitMap; AText: String);
var
  ButtonData: TbsDataSkinButtonControl;
  BtnSkinPicture: TBitMap;
  BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint: TPoint;
  BtnCLRect: TRect;
  XO, YO: Integer;
  SR: TRect;
  CIndex: Integer;
  R, TR: TRect;
  IX, IY, Index, IIndex: Integer;
  S: String;
begin
  GetSkindata;
  if FIndex = -1 then Exit;

  CIndex := SkinData.GetControlIndex('resizetoolbutton');
  if CIndex = -1
  then
    begin
      CIndex := SkinData.GetControlIndex('resizebutton');
      if CIndex = -1 then Exit else
        ButtonData := TbsDataSkinButtonControl(SkinData.CtrlList[CIndex]);
    end
  else
    ButtonData := TbsDataSkinButtonControl(SkinData.CtrlList[CIndex]);

  R := Rect(0, 0, Width, Height);

  with ButtonData do
  begin
    //
    if FDropDown then SR := DownSkinRect else
      if (FMouseIn or Focused) then SR := ActiveSkinRect else SR := SkinRect;
    if IsNullRect(SR) then SR := SkinRect;
    //

    XO := RectWidth(R) - RectWidth(SkinRect);
    YO := RectHeight(R) - RectHeight(SkinRect);
    BtnLTPoint := LTPoint;
    BtnRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
    BtnLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
    BtnRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
    BtnClRect := Rect(CLRect.Left, ClRect.Top,
      CLRect.Right + XO, ClRect.Bottom + YO);
    BtnSkinPicture := TBitMap(SkinData.FActivePictures.Items[ButtonData.PictureIndex]);
    if IsNullRect(SR) then SR := ActiveSkinRect;
    CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        B, BtnSkinPicture, SR, B.Width, B.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);

    // draw item
    R := Rect(3, 2, Width - 17, Height - 2);
    with B.Canvas do
    begin
      if FUseSkinFont
      then
       begin
          Font.Name := FontName;
          Font.Style := FontStyle;
          Font.Height := FontHeight;
        end
      else
        Font.Assign(FDefaultFont);
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet
      else
        Font.CharSet := FDefaultFont.CharSet;

      if FDropDown then Font.Color := DownFontColor else
       if (FMouseIn or Focused) then Font.Color := ActiveFontColor else
         if not Enabled then Font.Color := DisabledFontColor else
           Font.Color := FontColor;
      Brush.Style := bsClear;
      if FListBox.Visible
      then Index := FOldItemIndex
      else Index := FListBox.ItemIndex;
      if (Index > -1) and (Index < FListBox.Items.Count)
      then
        begin
          if AText <> ''
          then
            S := AText
          else
            S := FListBox.Items[Index].Caption;

        if FShowItemText and FShowItemTitle and (Items[Index].Title <> '')
        then
          begin
            B.Canvas.Font.Style := B.Canvas.Font.Style + [fsBold];
            TR := R;
            TR.Bottom := TR.Top + B.Canvas.TextHeight(Items[Index].Title);
            DrawText(B.Canvas.Handle, PChar(Items[Index].Title),
              Length(Items[Index].Title), TR, DT_LEFT);
            B.Canvas.Font.Style := B.Canvas.Font.Style - [fsBold];
            R.Top := TR.Bottom - 2;
          end;
        if FShowItemText and not FShowItemImage
        then
          BSDrawText2(B.Canvas, S, R)
        else
        if FShowItemImage
        then
          begin
            if FShowItemText
            then
              DrawImageAndText2(B.Canvas, R, 0, 2, blGlyphLeft,
               S, Items[Index].ImageIndex, Images,
               False, Enabled, False, 0)
            else
               DrawImageAndText2(B.Canvas, R, 0, 2, blGlyphLeft,
               '', Items[Index].ImageIndex, Images, False, Enabled, False, 0)
          end;
        end;
    end;

    //

    R := Rect(Width - 15, 0, Width, Height);

   if not IsNullRect(MenuMarkerRect)
   then
     begin
       DrawMenuMarker(B.Canvas, R, FMouseIn, FDropDown, ButtonData);
     end
   else
   if FDropDown
   then
     DrawTrackArrowImage(B.Canvas, R, DownFontColor)
   else
     DrawTrackArrowImage(B.Canvas, R, B.Canvas.Font.Color);
  end;
end;


procedure TbsSkinCustomOfficeComboBox.CreateControlSkinImage2;
begin
  CalcRects;
  if FUseSkinSize
  then
    begin
      if not IsNullRect(ActiveSkinRect) and (FMouseIn or Focused)
      then
        CreateHSkinImage(LTPt.X, RectWidth(ActiveSkinRect) - RTPt.X,
          B, Picture, ActiveSkinRect, Width, RectHeight(ActiveSkinRect), StretchEffect)
      else
        inherited CreateControlSkinImage(B);
    end
  else
    begin
      if not IsNullRect(ActiveSkinRect) and (FMouseIn or Focused)
      then
        CreateStretchImage(B, Picture, SkinRect, ClRect, True)
      else
        CreateStretchImage(B, Picture, SkinRect, ClRect, True);
    end;

  if (FUseSkinSize) or (FIndex = -1)
  then
    DrawButton(B.Canvas)
  else
    DrawResizeButton(B.Canvas);
end;


procedure TbsSkinCustomOfficeComboBox.CreateControlSkinImage;
begin
  CalcRects;
  if FToolButtonStyle
  then
    begin
      Self.CreateControlToolSkinImage(B, '');
    end
  else
  if FUseSkinSize
  then
    begin
      if not IsNullRect(ActiveSkinRect) and (FMouseIn or Focused)
      then
        CreateHSkinImage(LTPt.X, RectWidth(ActiveSkinRect) - RTPt.X,
          B, Picture, ActiveSkinRect, Width, RectHeight(ActiveSkinRect), StretchEffect)
      else
        inherited;
    end
  else
    begin
      if not IsNullRect(ActiveSkinRect) and (FMouseIn or Focused)
      then
        CreateStretchImage(B, Picture, ActiveSkinRect, ClRect, True)
      else
        CreateStretchImage(B, Picture, SkinRect, ClRect, True);
    end;


  if not FToolButtonStyle
  then
    begin
      if (FUseSkinSize) or (FIndex = -1)
      then
        DrawButton(B.Canvas)
      else
        DrawResizeButton(B.Canvas);
      
        if FUseSkinSize
        then
          DrawSkinItem(B.Canvas)
        else
          DrawResizeSkinItem(B.Canvas);
    end;
end;

procedure TbsSkinCustomOfficeComboBox.EditPageUp1;
begin
  FListBox.FindPageUp;
  if AChange then ItemIndex := FListBox.ItemIndex;
end;

procedure TbsSkinCustomOfficeComboBox.EditPageDown1(AChange: Boolean);
begin
  FListBox.FindPageDown;
  if AChange then ItemIndex := FListBox.ItemIndex;
end;

procedure TbsSkinCustomOfficeComboBox.EditUp1;
begin
  FListBox.FindUp;
  if AChange then ItemIndex := FListBox.ItemIndex;
end;

procedure TbsSkinCustomOfficeComboBox.EditDown1;
begin
  FListBox.FindDown;
  if AChange then ItemIndex := FListBox.ItemIndex;
end;

procedure TbsSkinCustomOfficeComboBox.SetImages(Value: TCustomImageList);
begin
  FListBox.Images := Value;
end;


function TbsSkinCustomOfficeComboBox.GetListBoxShowItemTitles: Boolean;
begin
  Result := FListBox.ShowItemTitles;
end;

procedure TbsSkinCustomOfficeComboBox.SetListBoxShowItemTitles(Value: Boolean);
begin
  FListBox.ShowItemTitles := Value;
end;

function TbsSkinCustomOfficeComboBox.GetListBoxSkinDataName: String;
begin
  Result := FListBox.SkinDataName;
end;

procedure TbsSkinCustomOfficeComboBox.SetListBoxSkinDataName(Value: String);
begin
  FListBox.SkinDataName := Value;
end;

function TbsSkinCustomOfficeComboBox.GetListBoxShowLines: Boolean;
begin
  Result := FListBox.ShowLines;
end;

procedure TbsSkinCustomOfficeComboBox.SetListBoxShowLines(Value: Boolean);
begin
  FListBox.ShowLines := Value;
end;

function TbsSkinCustomOfficeComboBox.GetListBoxItemHeight: Integer;
begin
  Result := FlistBox.ItemHeight;
end;

procedure TbsSkinCustomOfficeComboBox.SetListBoxItemHeight(Value: Integer);
begin
  FlistBox.ItemHeight := Value;
end;

function TbsSkinCustomOfficeComboBox.GetListBoxHeaderHeight: Integer;
begin
  Result := FListBox.HeaderHeight;
end;

procedure TbsSkinCustomOfficeComboBox.SetListBoxHeaderHeight(Value: Integer);
begin
  FListBox.HeaderHeight := Value;
end;

procedure TbsSkinCustomOfficeComboBox.SetShowItemTitle(Value: Boolean);
begin
  if FShowItemTitle <> Value
  then
    begin
      FShowItemTitle := Value;
      RePaint;
    end;  
end;

procedure TbsSkinCustomOfficeComboBox.SetShowItemImage(Value: Boolean);
begin
  if FShowItemImage <> Value
  then
    begin
      FShowItemImage := Value;
      RePaint;
    end;  
end;

procedure TbsSkinCustomOfficeComboBox.SetShowItemText(Value: Boolean);
begin
  if FShowItemText <> Value
  then
    begin
      FShowItemText := Value;
      RePaint
    end;  
end;

// TbSkinLinkBar ===============================================================

constructor TbsSkinLinkBarItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FHeader := False;
  FImageIndex := -1;
  FActiveImageIndex := -1;
  FCaption := '';
  FEnabled := True;
  if TbsSkinLinkBarItems(Collection).LinkBar.ItemIndex = Self.Index
  then
    Active := True
  else
    Active := False;
  FUseCustomGlowColor := False;
  FCustomGlowColor := clAqua;  
end;

procedure TbsSkinLinkBarItem.Assign(Source: TPersistent);
begin
  if Source is TbsSkinLinkBarItem then
  begin
    FImageIndex := TbsSkinLinkBarItem(Source).ImageIndex;
    FActiveImageIndex := TbsSkinLinkBarItem(Source).ActiveImageIndex;
    FCaption := TbsSkinLinkBarItem(Source).Caption;
    FEnabled := TbsSkinLinkBarItem(Source).Enabled;
    FHeader := TbsSkinLinkBarItem(Source).Header;
    FUseCustomGlowColor := TbsSkinLinkBarItem(Source).UseCustomGlowColor;
    FCustomGlowColor := TbsSkinLinkBarItem(Source).CustomGlowColor;
  end
  else
    inherited Assign(Source);
end;

procedure TbsSkinLinkBarItem.SetImageIndex(const Value: TImageIndex);
begin
  FImageIndex := Value;
  Changed(False);
end;

procedure TbsSkinLinkBarItem.SetActiveImageIndex(const Value: TImageIndex);
begin
  FActiveImageIndex := Value;
  Changed(False);
end;

procedure TbsSkinLinkBarItem.SetCaption(const Value: String);
begin
  FCaption := Value;
  Changed(False);
end;

procedure TbsSkinLinkBarItem.SetHeader(Value: Boolean);
begin
  FHeader := Value;
  Changed(False);
end;

procedure TbsSkinLinkBarItem.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  Changed(False);
end;

constructor TbsSkinLinkBarItems.Create;
begin
  inherited Create(TbsSkinLinkBarItem);
  LinkBar := AListBox;
end;

function TbsSkinLinkBarItems.GetOwner: TPersistent;
begin
  Result := LinkBar;
end;

procedure  TbsSkinLinkBarItems.Update(Item: TCollectionItem);
begin
  LinkBar.Repaint;
  LinkBar.UpdateScrollInfo;
end; 

function TbsSkinLinkBarItems.GetItem(Index: Integer):  TbsSkinLinkBarItem;
begin
  Result := TbsSkinLinkBarItem(inherited GetItem(Index));
end;

procedure TbsSkinLinkBarItems.SetItem(Index: Integer; Value:  TbsSkinLinkBarItem);
begin
  inherited SetItem(Index, Value);
  LinkBar.RePaint;
end;

function TbsSkinLinkBarItems.Add: TbsSkinLinkBarItem;
begin
  Result := TbsSkinLinkBarItem(inherited Add);
  LinkBar.RePaint;
end;

function TbsSkinLinkBarItems.Insert(Index: Integer): TbsSkinLinkBarItem;
begin
  Result := TbsSkinLinkBarItem(inherited Insert(Index));
  LinkBar.RePaint;
end;

procedure TbsSkinLinkBarItems.Delete(Index: Integer);
begin
  inherited Delete(Index);
  LinkBar.RePaint;
end;

procedure TbsSkinLinkBarItems.Clear;
begin
  inherited Clear;
  LinkBar.RePaint;
end;

constructor TbsSkinLinkBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csAcceptsControls];
  FHeaderSkinDataName := 'menuheader';
  FHeaderLeftAlignment := False;
  FGlowEffect := False;
  FHeaderBold := True;
  FGlowSize := 10;
  FShowTextUnderLine := True;
  FHoldSelectedItem := False;
  FShowBlurMarker := False;
  FClicksDisabled := False;
  FSpacing := 5;
  FMouseDown := False;
  FShowLines := False;
  FMouseActive := -1;
  ScrollBar := nil;
  FScrollOffset := 0;
  FItems := TbsSkinLinkBarItems.Create(Self);
  FImages := nil;
  Width := 150;
  Height := 150;
  FItemHeight := 30;
  FHeaderHeight := 20;
  FSkinDataName := 'listbox';
  FShowItemTitles := True;
  FMax := 0;
  FRealMax := 0;
  FOldHeight := -1;
  FItemIndex := -1;
  FDisabledFontColor := clGray;
end;

procedure TbsSkinLinkBar.SetHeaderLeftAlignment(Value: Boolean);
begin
  if FHeaderLeftAlignment <> Value
  then
    begin
      FHeaderLeftAlignment := Value;
      RePaint;
    end;
end;

procedure TbsSkinLinkBar.GetSkinData;
var
  CIndex: Integer;
begin
  inherited;
  if (FSD = nil) or FSD.Empty
  then
    CIndex := -1
  else
    CIndex := FSD.GetControlIndex('stdlabel');
  if CIndex <> -1
  then
    begin
      FSkinFontColor := TbsDataSkinStdLabelControl(FSD.CtrlList.Items[CIndex]).FontColor;
      FSkinActiveFontColor := TbsDataSkinStdLabelControl(FSD.CtrlList.Items[CIndex]).ActiveFontColor;
    end
  else
  if (FSD <> nil) and not FSD.Empty
  then
    begin
      FSkinFontColor := FSD.SkinColors.cBtnText;
      FSkinActiveFontColor := FSD.SkinColors.cBtnHighLight;
    end;
end;

destructor TbsSkinLinkBar.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TbsSkinLinkBar.SetHoldSelectedItem(Value: Boolean);
begin
  FHoldSelectedItem := Value;
  if not FHoldSelectedItem then FItemIndex := -1;
end;

procedure TbsSkinLinkBar.SetSpacing;
begin
  if FSpacing <> Value
  then
    begin
      FSpacing := Value;
      RePaint;
    end;
end;

function TbsSkinLinkBar.CalcHeight;
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

procedure TbsSkinLinkBar.SetShowLines;
begin
  if FShowLines <> Value
  then
    begin
      FShowLines := Value;
      RePaint;
    end;
end;

procedure TbsSkinLinkBar.ChangeSkinData;
var
  CIndex: Integer;
begin
  inherited;
  //
  if SkinData <> nil
  then
    CIndex := SkinData.GetControlIndex('edit');
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

procedure TbsSkinLinkBar.SetItemHeight(Value: Integer);
begin
  if FItemHeight <> Value
  then
    begin
      FItemHeight := Value;
      RePaint;
    end;
end;

procedure TbsSkinLinkBar.SetHeaderHeight(Value: Integer);
begin
  if FHeaderHeight <> Value
  then
    begin
      FHeaderHeight := Value;
      RePaint;
    end;
end;

procedure TbsSkinLinkBar.SetItems(Value: TbsSkinLinkBarItems);
begin
  FItems.Assign(Value);
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinLinkBar.SetImages(Value: TCustomImageList);
begin
  FImages := Value;
end;

procedure TbsSkinLinkBar.Notification(AComponent: TComponent;
            Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then
   FImages := nil;
end;

procedure TbsSkinLinkBar.SetShowItemTitles(Value: Boolean);
begin
  if FShowItemTitles <> Value
  then
    begin
      FShowItemTitles := Value;
      RePaint;
    end;
end;

procedure TbsSkinLinkBar.DrawItem;
var
  Buffer: TBitMap;
  R: TRect;
begin
  if FIndex <> -1
  then
    SkinDrawItem(Index, Cnvs)
  else
    DefaultDrawItem(Index, Cnvs);
end;

procedure TbsSkinLinkBar.CreateControlDefaultImage(B: TBitMap);
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

procedure TbsSkinLinkBar.CreateControlSkinImage(B: TBitMap);
var
  I, SaveIndex: Integer;
  R: TRect;
  C: TColor;
begin
  inherited;
  CalcItemRects;
  SaveIndex := SaveDC(B.Canvas.Handle);
  IntersectClipRect(B.Canvas.Handle,
    FItemsRect.Left, FItemsRect.Top, FItemsRect.Right, FItemsRect.Bottom);
  for I := 0 to FItems.Count - 1 do
   if FItems[I].IsVisible then DrawItem(I, B.Canvas);

  if FShowBlurMarker
  then
  if FItemIndex <> -1
  then
    with FItems[FItemIndex] do
    begin
      R := ItemRect;
      Inc(R.Left, 5);
      Dec(R.Right, 5);
      R.Top := R.Bottom - 10;
      R.Bottom := R.Top + 10;
      C := FSD.SkinColors.cHighLight;
      DrawBlurMarker(B.Canvas, R, C);
    end;

  RestoreDC(B.Canvas.Handle, SaveIndex);
end;

procedure TbsSkinLinkBar.CalcItemRects;
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
    with TbsSkinLinkBarItem(FItems[I]) do
    begin
      if not Header then H := ItemHeight else H := HeaderHeight;
      if FGlowEffect and not Header then X := FItemsRect.Left + FGlowSize - 5
      else X := FItemsRect.Left;
      if X < FItemsRect.Left then X := FItemsRect.Left;
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

procedure TbsSkinLinkBar.Scroll(AScrollOffset: Integer);
begin
  FScrollOffset := AScrollOffset;
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinLinkBar.GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
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

procedure TbsSkinLinkBar.CMMouseLeave;
begin
  inherited;
  SetItemActive(-1);
  FMouseActive := -1;
  Cursor := crDefault;
end;

procedure TbsSkinLinkBar.WMSize(var Msg: TWMSize);
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

procedure TbsSkinLinkBar.ScrollToItem(Index: Integer);
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

procedure TbsSkinLinkBar.ShowScrollbar;
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

procedure TbsSkinLinkBar.HideScrollBar;
begin
  if ScrollBar = nil then Exit;
  ScrollBar.Visible := False;
  ScrollBar.Free;
  ScrollBar := nil;
  RePaint;
end;

procedure TbsSkinLinkBar.UpdateScrollInfo;
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

procedure TbsSkinLinkBar.AdjustScrollBar;
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

procedure TbsSkinLinkBar.SBChange(Sender: TObject);
begin
  Scroll(ScrollBar.Position);
end;

procedure TbsSkinLinkBar.SkinDrawItem(Index: Integer; Cnvs: TCanvas);
var
  ListBoxData: TbsDataSkinListBox;
  CIndex, TX, TY: Integer;
  R, R1: TRect;
  Buffer: TBitMap;
  C: TColor;
  IIndex: Integer;
  FGlowColor: TColor;
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
    begin
      if (SkinDataName = 'listbox') or
         (SkinDataName = 'memo')
      then
        Cnvs.Font.Color := ListBoxData.FontColor
      else
        Cnvs.Font.Color := FSkinFontColor;
    end   
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

  if (FItems[Index].Active) or (FHoldSelectedItem and (FItemIndex = Index))
  then
    begin
      if FShowTextUnderLine
      then
        Cnvs.Font.Style := Cnvs.Font.Style + [fsUnderline];
      if not FGlowEffect
      then
        if (SkinDataName = 'listbox') or (SkinDataName = 'memo')
        then
          Cnvs.Font.Color := SkinData.SkinColors.cHighLight
        else
          Cnvs.Font.Color := FSkinActiveFontColor;
      IIndex := FItems[Index].ActiveImageIndex;
      if IIndex = -1 then IIndex := FItems[Index].ImageIndex;
    end
  else
    begin
      Cnvs.Font.Style := Cnvs.Font.Style - [fsUnderline];
      IIndex := FItems[Index].ImageIndex;
    end;  

   if FItems[Index].UseCustomGlowColor
   then
     FGlowColor := FItems[Index].CustomGlowColor
   else
     FGlowColor := FSkinActiveFontColor;

  //
    with FItems[Index] do
    begin
       if (FImages <> nil) and (IIndex >= 0) and
           (IIndex < FImages.Count)
        then
         begin
            if FGlowEffect and
            (FItems[Index].Active) or (FHoldSelectedItem and (FItemIndex = Index))
            then
              DrawImageAndTextGlow2(Cnvs, R, 0, FSpacing, blGlyphLeft,
               Caption, IIndex, FImages, False, Enabled, False, 0,
               FGlowColor, FGlowSize)
            else
              DrawImageAndText2(Cnvs, R, 0, FSpacing, blGlyphLeft,
               Caption, IIndex, FImages, False, Enabled, False, 0);
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
           if FGlowEffect and
             (FItems[Index].Active) or (FHoldSelectedItem and (FItemIndex = Index))
           then
             DrawEffectText2(Cnvs, R, Caption, DT_EXPANDTABS or DT_WORDBREAK or DT_LEFT,
               0, FGlowColor, FGlowSize);
           DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), R,
             DT_EXPANDTABS or DT_WORDBREAK or DT_LEFT);
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
    end;
end;

procedure TbsSkinLinkBar.DefaultDrawItem(Index: Integer; Cnvs: TCanvas);
var
  R, R1: TRect;
  C, FC: TColor;
  TX, TY: Integer;
  IIndex: Integer;
  FGlowColor: TColor;
begin
  if FItems[Index].UseCustomGlowColor
  then
    FGlowColor := FItems[Index].CustomGlowColor
  else
    FGlowColor := clAqua;
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
      C := clWindow;
      if FGlowEffect
      then
        FC := clWindowText
      else
        FC := clHighLight;
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
  if FHeaderBold and  FItems[Index].Header then Cnvs.Font.Style :=  Cnvs.Font.Style + [fsBold];
  //
  if (FItems[Index].Active or (FHoldSelectedItem and (ItemIndex = Index))) and not FItems[Index].Header
  then
    begin
      if Self.ShowTextUnderLine
      then
        Cnvs.Font.Style := Cnvs.Font.Style + [fsUnderline];
      IIndex := FItems[Index].ActiveImageIndex;
      if IIndex = -1 then IIndex := FItems[Index].ImageIndex;
    end
  else
    begin
      Cnvs.Font.Style := Cnvs.Font.Style - [fsUnderline];
      IIndex := FItems[Index].ImageIndex;
    end;
  //
  R := FItems[Index].ItemRect;
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
      if FHeaderLeftAlignment
      then
        DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), R,
          DT_LEFT or DT_VCENTER or DT_SINGLELINE)
      else
        DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), R,
          DT_CENTER or DT_VCENTER or DT_SINGLELINE);
    end
  else
    with FItems[Index] do
    begin
       if (FImages <> nil) and (IIndex >= 0) and
           (IIndex < FImages.Count)
        then
         begin
           if FGlowEffect and
            (FItems[Index].Active) or (FHoldSelectedItem and (FItemIndex = Index))
            then
              DrawImageAndTextGlow2(Cnvs, R, 0, FSpacing, blGlyphLeft,
              Caption, IIndex, FImages,
               False, Enabled, False, 0, FGlowColor, FGlowSize)
           else
             DrawImageAndText2(Cnvs, R, 0, FSpacing, blGlyphLeft,
              Caption, IIndex, FImages,
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
           if FGlowEffect and
             (FItems[Index].Active) or (FHoldSelectedItem and (FItemIndex = Index))
           then
             DrawEffectText2(Cnvs, R, Caption, DT_EXPANDTABS or DT_WORDBREAK or DT_LEFT,
               0, FGlowColor, FGlowSize);

           DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), R,
             DT_WORDBREAK or DT_LEFT);
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
end;

procedure TbsSkinLinkBar.SkinDrawHeaderItem(Index: Integer; Cnvs: TCanvas);
var
  Buffer: TBitMap;
  CIndex: Integer;
  LData: TbsDataSkinLabelControl;
  R, TR: TRect;
  CPicture: TBitMap;
begin
  CIndex := SkinData.GetControlIndex(FHeaderSkinDataName);
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
  TR := Rect(1, 1, Buffer.Width - 1, Buffer.Height - 1);
  if FHeaderLeftAlignment then TR.Left := LData.ClRect.Left;
  with Buffer.Canvas, LData do
  begin
    Font.Name := FontName;
    Font.Color := FontColor;
    Font.Height := FontHeight;
    Font.Style := FontStyle;
    if FHeaderBold then  Font.Style :=  Font.Style + [fsBold];
    Brush.Style := bsClear;
  end;
  with FItems[Index] do
   if FHeaderLeftAlignment
   then
     DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR,
      DT_LEFT or DT_VCENTER or DT_SINGLELINE)
   else
     DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR,
      DT_CENTER or DT_VCENTER or DT_SINGLELINE);
  Cnvs.Draw(R.Left, R.Top, Buffer);
  Buffer.Free;
end;


procedure TbsSkinLinkBar.SetItemIndex(Value: Integer);
var
  I: Integer;
  IsFind: Boolean;
begin
  if (csDesigning in ComponentState) and not FHoldSelectedItem
  then
    begin
      FItemIndex := -1;
      Exit;
    end;

  FItemIndex := Value;

  if FItemIndex < 0
  then
    begin
      FItemIndex := -1;
      RePaint;
      Exit;
    end;

    if (FItemIndex >= 0) and (FItemIndex < FItems.Count) and not
       (csDesigning in ComponentState)
    then
     begin
      IsFind := False;
      for I := 0 to FItems.Count - 1 do
        with FItems[I] do
        begin
          if I = FItemIndex
          then
            begin
              Active := True;
              IsFind := True;
            end
          else
             Active := False;
        end;
      RePaint;
      ScrollToItem(FItemIndex);
      if IsFind then
      begin
        if Assigned(FItems[FItemIndex].OnClick) then
          FItems[FItemIndex].OnClick(Self);
        if Assigned(FOnItemClick) then
          FOnItemClick(Self);
      end;    
    end;
end;

procedure TbsSkinLinkBar.Loaded;
begin
  inherited;
end;

function TbsSkinLinkBar.ItemAtPos(X, Y: Integer): Integer;
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

procedure TbsSkinLinkBar.MouseDown(Button: TMouseButton; Shift: TShiftState;
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
      if FHoldSelectedItem
      then
        begin
          ItemIndex := I;
        end;
      FMouseDown := True;
      FMouseActive := I;
    end;
end;

procedure TbsSkinLinkBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  FMouseDown := False;
  I := ItemAtPos(X, Y);
  if (I <> -1) and not (FItems[I].Header) and (Button = mbLeft) and
     not FHoldSelectedItem
  then
    ItemIndex := I;
end;

procedure TbsSkinLinkBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  I := ItemAtPos(X, Y);
  if (I <> -1)and FItems[I].Header then I := -1;
  if (I <> -1) and (I <> FMouseActive)
  then
    begin
      SetItemActive(I);
      FMouseActive := I;
      Cursor := crHandPoint;
    end
  else
  if (I = -1) and (I <> FMouseActive)
  then
    begin
      SetItemActive(-1);
      Cursor := crDefault;
      FMouseActive := -1;
    end;
end;

procedure TbsSkinLinkBar.SetItemActive(Value: Integer);
var
  I: Integer;
begin

  if not FHoldSelectedItem then FItemIndex := Value;

  if not FHoldSelectedItem and (FItemIndex = -1)
  then
    begin
      for I := 0 to FItems.Count - 1 do FItems[I].Active := False;
      RePaint;
      Exit;
    end;

  for I := 0 to FItems.Count - 1 do
  with FItems[I] do
   if I = Value then Active := True else Active := False;
  RePaint;
end;

procedure TbsSkinLinkBar.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
end;

// TbsSkinVistaGlowLabel========================================================

constructor TbsSkinVistaGlowLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque] + [csReplicatable];
  Width := 65;
  Height := 17;
  FAutoSize := True;
  FShowAccelChar := True;
  FDoubleBuffered := False;
  FGlowColor := clWhite;
  FGlowSize := 10;
end;

procedure TbsSkinVistaGlowLabel.SetGlowColor(Value: TColor);
begin
  if Value <> FGlowColor
  then
    begin
      FGlowColor := Value;
      RePaint;
    end;
end;

procedure TbsSkinVistaGlowLabel.SetDoubleBuffered;
begin
  if Value <> FDoubleBuffered
  then
    begin
      FDoubleBuffered := Value;
      if FDoubleBuffered
      then ControlStyle := ControlStyle + [csOpaque]
      else ControlStyle := ControlStyle - [csOpaque];
    end;
end;

function TbsSkinVistaGlowLabel.GetLabelText: string;
begin
  Result := Caption;
end;

procedure TbsSkinVistaGlowLabel.WMMOVE;
begin
  inherited;
  if FDoubleBuffered then RePaint;
end;

procedure TbsSkinVistaGlowLabel.DoDrawText(Cnvs: TCanvas; var Rect: TRect; Flags: Longint);
var
  Text: string;
begin
  Text := GetLabelText;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  Windows.DrawText(Cnvs.Handle, PChar(Text), Length(Text), Rect, Flags);
end;

procedure TbsSkinVistaGlowLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Text: string;
  Flags: Longint;
  R: TRect;
  FBuffer: TbsBitmap;
begin
  //
  Canvas.Font := Self.Font;
  //
  Text := GetLabelText;
  R := Rect(FGlowSize, FGlowSize,
            Width - FGlowSize, Height - FGlowSize);
  if R.Left < 0 then R.Left := 0;
  if R.Top < 0 then R.Top := 0;
  Flags := DT_EXPANDTABS or WordWraps[FWordWrap] or Alignments[FAlignment];
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  if FDoubleBuffered
  then
    begin
      FBuffer := TbsBitmap.Create;
      FBuffer.SetSize(Width, Height);
      GetParentImage(Self, FBuffer.Canvas);
      FBuffer.Canvas.Font := Self.Font;
      DrawVistaEffectText(FBuffer.Canvas, R, Text, Flags, FGlowColor);
      FBuffer.Draw(Canvas.Handle, 0, 0);
      FBuffer.Free;
    end
  else
    DrawVistaEffectText(Canvas, R, Text, Flags, FGlowColor);
end;

procedure TbsSkinVistaGlowLabel.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TbsSkinVistaGlowLabel.AdjustBounds;
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X: Integer;
  Rect: TRect;
  AAlignment: TAlignment;
begin
  if not (csReading in ComponentState) and FAutoSize then
  begin
    Canvas.Font := Self.Font;
    Rect := ClientRect;
    DC := GetDC(0);
    Canvas.Handle := DC;
    DoDrawText(Canvas, Rect, (DT_EXPANDTABS or DT_CALCRECT) or WordWraps[FWordWrap]);
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    X := Left;
    AAlignment := FAlignment;
    if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
    if AAlignment = taRightJustify then Inc(X, Width - Rect.Right);
    Rect.Right := Rect.Right + FGlowSize * 2 + 8;
    Rect.Bottom := Rect.Bottom + FGlowSize * 2 + 8;
    SetBounds(X, Top, Rect.Right, Rect.Bottom);
  end;
end;

procedure TbsSkinVistaGlowLabel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RePaint;
  end;
end;

procedure TbsSkinVistaGlowLabel.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
  end;
end;

procedure TbsSkinVistaGlowLabel.SetFocusControl(Value: TWinControl);
begin
  FFocusControl := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TbsSkinVistaGlowLabel.SetShowAccelChar(Value: Boolean);
begin
  if FShowAccelChar <> Value then
  begin
    FShowAccelChar := Value;
    RePaint;
  end;
end;

procedure TbsSkinVistaGlowLabel.SetLayout(Value: TTextLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    RePaint;
  end;
end;

procedure TbsSkinVistaGlowLabel.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    AdjustBounds;
    RePaint;
  end;
end;

procedure TbsSkinVistaGlowLabel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
end;

procedure TbsSkinVistaGlowLabel.CMTextChanged(var Message: TMessage);
begin
  AdjustBounds;
  RePaint;
end;

procedure TbsSkinVistaGlowLabel.CMFontChanged(var Message: TMessage);
begin
  AdjustBounds;
  RePaint;
end;

procedure TbsSkinVistaGlowLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if (FFocusControl <> nil) and Enabled and ShowAccelChar and
    IsAccel(Message.CharCode, Caption) then
    with FFocusControl do
      if CanFocus then
      begin
        SetFocus;
        Message.Result := 1;
      end;
end;

procedure TbsSkinVistaGlowLabel.ChangeSkinData;
begin
  inherited;
  if (FSD <> nil) and (not FSD.Empty)
  then
    begin
      GlowColor := FSD.SkinColors.cHighLight;
      RePaint;
    end;
end;


// TbsSkinToolBarEx ============================================================

constructor TbsSkinToolBarExItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FHint := '';
  FImageIndex := -1;
  FActiveImageIndex := -1;
  FEnabled := True;
  IsVisible := True;
  Active := False;
  FUseCustomGlowColor := False;
  FCustomGlowColor := clAqua;
  FReflectionBitmap := TbsBitmap.Create;
  FReflectionActiveBitmap := TbsBitmap.Create;
end;

destructor TbsSkinToolBarExItem.Destroy;
begin
  FReflectionBitmap.Free;
  FReflectionActiveBitmap.Free;
  inherited;
end;

procedure TbsSkinToolBarExItem.InitReflectionBitmaps;
var
  IL: TbsPngImageList;
begin
  FReflectionBitmap.SetSize(0, 0);
  FReflectionActiveBitmap.SetSize(0, 0);
  if (Collection <> nil) and (TbsSkinToolBarExItems(Collection).ToolBarEx <> nil)
     and
     (TbsSkinToolBarExItems(Collection).ToolBarEx.FImages <> nil)
  then
    begin
      IL := TbsSkinToolBarExItems(Collection).ToolBarEx.FImages;
      if (FImageIndex >= 0) and (FImageIndex < IL.Count)
      then
        with TbsPngImageList(IL) do
        begin
          MakeCopyFromPng(FReflectionBitmap,
          PngImages.Items[Self.FImageIndex].PngImage);
          if FEnabled
          then
            FReflectionBitmap.Reflection
          else
            FReflectionBitmap.Reflection2;
        end;
      if (FActiveImageIndex >= 0) and (FActiveImageIndex < IL.Count)
      then
        with TbsPngImageList(IL) do
        begin
          MakeCopyFromPng(FReflectionActiveBitmap,
          PngImages.Items[Self.FActiveImageIndex].PngImage);
          FReflectionActiveBitmap.Reflection;
        end;
   end;
end;

procedure TbsSkinToolBarExItem.Assign(Source: TPersistent);
begin
  if Source is TbsSkinToolBarExItem then
  begin
    FImageIndex := TbsSkinToolBarExItem(Source).ImageIndex;
    FActiveImageIndex := TbsSkinToolBarExItem(Source).ActiveImageIndex;
    FEnabled := TbsSkinToolBarExItem(Source).Enabled;
    FHint := TbsSkinToolBarExItem(Source).Hint;
    FUseCustomGlowColor := TbsSkinToolBarExItem(Source).UseCustomGlowColor;
    FCustomGlowColor := TbsSkinToolBarExItem(Source).CustomGlowColor;
   end
 else
   inherited Assign(Source);
end;

procedure TbsSkinToolBarExItem.SetImageIndex(const Value: TImageIndex);
begin
  FImageIndex := Value;
  InitReflectionBitmaps;
  Changed(False);
end;

procedure TbsSkinToolBarExItem.SetActiveImageIndex(const Value: TImageIndex);
begin
  FActiveImageIndex := Value;
  InitReflectionBitmaps;
  Changed(False);
end;

procedure TbsSkinToolBarExItem.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  InitReflectionBitmaps;
  Changed(False);
end;

constructor TbsSkinToolBarExItems.Create;
begin
  inherited Create(TbsSkinToolBarExItem);
  ToolBarEx := AListBox;
end;

function TbsSkinToolBarExItems.GetOwner: TPersistent;
begin
  Result := ToolBarEx;
end;

procedure  TbsSkinToolBarExItems.Update(Item: TCollectionItem);
begin
  ToolBarEx.Repaint;
end; 

function TbsSkinToolBarExItems.GetItem(Index: Integer):  TbsSkinToolBarExItem;
begin
  Result := TbsSkinToolBarExItem(inherited GetItem(Index));
end;

procedure TbsSkinToolBarExItems.SetItem(Index: Integer; Value:  TbsSkinToolBarExItem);
begin
  inherited SetItem(Index, Value);
  ToolBarEx.RePaint;
end;

function TbsSkinToolBarExItems.Add: TbsSkinToolBarExItem;
begin
  Result := TbsSkinToolBarExItem(inherited Add);
  ToolBarEx.RePaint;
end;

function TbsSkinToolBarExItems.Insert(Index: Integer): TbsSkinToolBarExItem;
begin
  Result := TbsSkinToolBarExItem(inherited Insert(Index));
  ToolBarEx.RePaint;
end;

procedure TbsSkinToolBarExItems.Delete(Index: Integer);
begin
  inherited Delete(Index);
  ToolBarEx.RePaint;
end;

procedure TbsSkinToolBarExItems.Clear;
begin
  inherited Clear;
  ToolBarEx.RePaint;
end;

constructor TbsSkinToolBarEx.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csAcceptsControls];
  FMenuExPosition := bsmpAuto;
  FShowGlow := True;
  FItemIndex := -1;
  FHoldSelectedItem := False;
  FShowBorder := True;
  FAutoSize := False;
  FShowHandPointCursor := False;
  FSkinHint := nil;
  FShowItemHints := False;
  FItemSpacing := 10;
  FItems := TbsSkinToolBarExItems.Create(Self);
  Height := 50;
  Width := 300;
  FImages := nil;
  FArrowImages := nil;
  FSkinDataName := 'resizetoolpanel';
  FShowActiveCursor := True;
  MouseInItem := -1;
  OldMouseInItem := -1;
  FScrollIndex := 0;
  FScrollMax := 0;

  Buttons[0].MouseIn := False;
  Buttons[1].MouseIn := False;

end;

destructor TbsSkinToolBarEx.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TbsSkinToolBarEx.BeginUpdateItems;
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
end;

procedure TbsSkinToolBarEx.EndUpdateItems;
begin
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  Repaint;
end;

procedure TbsSkinToolBarEx.UpdatedSelected;
begin
  TestActive(-1, -1);
end;

procedure TbsSkinToolBarEx.SetShowGlow;
begin
  if Value <> FShowGlow
  then
    begin
       FShowGlow := Value;
       if FHoldSelectedItem then RePaint;
    end;
end;

procedure TbsSkinToolBarEx.SetItemIndex;
var
  OldValue: Integer;
begin
  OldValue := FItemIndex;
  FItemIndex := Value;
  if (OldValue <> FItemIndex) then RePaint;
  if (FItemIndex >= 0) and (FItemIndex < FItems.Count) and
     not (csDesigning in ComponentState) and
     not (csLoading in ComponentState)
  then
    begin
      if Assigned(FItems[FItemIndex].OnClick)
      then
        FItems[FItemIndex].OnClick(Self);
        if (OldValue <> FItemIndex) and Assigned(FOnChange)
        then
          FOnChange(Self);
     end;
end;

procedure TbsSkinToolBarEx.SetShowBorder(Value: Boolean);
begin
  if Value <> FShowBorder
  then
    begin
      FShowBorder := Value;
      RePaint;
    end;
end;

procedure TbsSkinToolBarEx.AdjustBounds;
begin
  if FImages = nil
  then
    Exit
  else
    Height := 10 + FImages.Height + FImages.Height div 2 + 2;
end;

procedure TbsSkinToolBarEx.SetAutoSize;
begin
  FAutoSize := Value;
  if FAutoSize then AdjustBounds;
end;

procedure TbsSkinToolBarEx.Loaded; 
var
  i: Integer;
begin
  inherited;
  for i := 0 to FItems.Count - 1 do FItems[I].InitReflectionBitmaps;
end;

procedure TbsSkinToolBarEx.SetItemSpacing;
begin
  if (Value >= 0) and (Value <> FItemSpacing)
  then
    begin
      FItemSpacing := Value;
      RePaint;
    end;
end;

function TbsSkinToolBarEx.GetVisibleCount: Integer;
var
  i, j: Integer;

begin
  j := 0;
  for i := 0 to FItems.Count - 1 do
    if FItems[i].IsVisible then Inc(j);
  Result := j;
  if Result = 0 then Result := 1;
end;

procedure TbsSkinToolBarEx.CalcItemRects;
var
  i, X, Y, Count: Integer;
begin
  if FImages = nil then Exit;
  Count := GetVisibleCount;
  X := Count * FImages.Width + (FItemSpacing * (Count - 1));
  X := Width div 2 - X div 2;
  if X < 2 then X := 2;
  Y := 10;
  for i := 0 to FItems.Count - 1 do
  with FItems[i] do
  if IsVisible then
  begin
    ItemRect := Rect(X, Y, X + FImages.Width, Y + FImages.Height);
    X := X + FImages.Width + FItemSpacing;
  end;
  if FArrowImages = nil
  then
    begin
      Buttons[0].R := Rect(2, Y + FImages.Height, 9, Height);
      Buttons[1].R := Rect(Width - 9, Y + FImages.Height, Width - 2, Height);
    end
  else
    begin
      Buttons[0].R := Rect(2, Y + FImages.Height, 2 + FArrowImages.PngWidth, Height);
      Buttons[1].R := Rect(Width - 2 - FArrowImages.PngWidth, Y + FImages.Height, Width - 2, Height);
    end;
end;

procedure TbsSkinToolBarEx.DrawItem;
var
  C: TColor;
  R: TRect;
  B: TbsBitMap;
  i, j: Integer;
begin
  if (FItems[Index].Active or ((Index = ItemIndex) and FHoldSelectedItem)) and
      FShowGlow
  then
    begin
      i := -1;

      if (FItems[Index].ActiveImageIndex >= 0) and
         (FItems[Index].ActiveImageIndex < FImages.Count)
      then
        i := FItems[Index].ActiveImageIndex
      else
      if (FItems[Index].ImageIndex >= 0) and
         (FItems[Index].ImageIndex < FImages.Count)
      then
        i := FItems[Index].ImageIndex;

      if i = -1 then Exit;  

      B := TbsBitMap.Create;
      B.SetSize(Images.Width + 20, Images.Height + 20);

      MakeBlurBlank(B, FImages.PngImages.Items[i].PngImage, 10);
      //

      Blur(B, 10);

      if (FIndex <> -1) and not FSD.Empty
      then
        begin
          if FItems[Index].UseCustomGlowColor
          then
            C := FItems[Index].CustomGlowColor
          else
            C := FSD.SkinColors.cHighLight
        end  
      else
        C := clAqua;

      for i := 0 to B.Width - 1 do
        for j := 0 to B.Height - 1 do
          begin
            PbsColorRec(B.PixelPtr[i, j]).Color := FromRGB(C) and
            not $FF000000 or (PbsColorRec(B.PixelPtr[i, j]).R shl 24);
          end;
      //
      B.Draw(Cnvs, FItems[Index].ItemRect.Left - 10,
        FItems[Index].ItemRect.Top - 10);
      B.Reflection3;
      B.Draw(Cnvs, FItems[Index].ItemRect.Left - 10,
        FItems[Index].ItemRect.Bottom - 10);
      B.Free;
    end;
  //
  if (FItems[Index].Active or ((Index = ItemIndex) and FHoldSelectedItem))
      and (FItems[Index].ActiveImageIndex >= 0) and
     (FItems[Index].ActiveImageIndex < FImages.Count)
  then
    begin
      FImages.Draw(Cnvs, FItems[Index].ItemRect.Left, FItems[Index].ItemRect.Top,
        FItems[Index].FActiveImageIndex, True);
      if not FItems[Index].FReflectionActiveBitmap.Empty
      then
        FItems[Index].FReflectionActiveBitmap.Draw(Cnvs, FItems[Index].ItemRect.Left,
        FItems[Index].ItemRect.Bottom);
    end
  else
  if (FItems[Index].ImageIndex >= 0) and (FItems[Index].ImageIndex < FImages.Count)
  then
    begin
      FImages.Draw(Cnvs, FItems[Index].ItemRect.Left, FItems[Index].ItemRect.Top,
        FItems[Index].FImageIndex, FItems[Index].Enabled);
      if not FItems[Index].FReflectionBitmap.Empty
      then
        begin
          FItems[Index].FReflectionBitmap.Draw(Cnvs, FItems[Index].ItemRect.Left,
              FItems[Index].ItemRect.Bottom)
        end;    
    end;

  if ((FItems[Index].Active and not FHoldSelectedItem) or
      (Index = ItemIndex) and FHoldSelectedItem)
     and FShowActiveCursor
  then
    begin
      if FItems[Index].UseCustomGlowColor
      then
        C:= FItems[Index].CustomGlowColor
      else
      if (FIndex <> -1) and not FSD.Empty
      then
        C := FSD.SkinColors.cHighLight
      else
        C := clAqua;

      R := FItems[Index].ItemRect;
      R.Top := Height - 20;
      R.Bottom := Height;
      DrawBlurMarker(Cnvs, R, C);
    end;

end;

procedure TbsSkinToolBarEx.Notification(AComponent: TComponent;
            Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FImages) then FImages := nil;
  if (Operation = opRemove) and (AComponent = FArrowImages) then FArrowImages := nil;
  if (Operation = opRemove) and (AComponent = FSkinHint) then FSkinHint := nil;
end;


procedure TbsSkinToolBarEx.SetItems(Value: TbsSkinToolBarExItems);
begin
  FItems.Assign(Value);
  RePaint;
end;

procedure TbsSkinToolBarEx.SetImages(Value: TbsPngImageList);
begin
  FImages := Value;
end;

procedure TbsSkinToolBarEx.SetArrowImages(Value: TbsPngImageList);
begin
  if FArrowImages <> Value
  then
    begin
      FArrowImages := Value;
      RePaint;
    end;  
end;


procedure TbsSkinToolBarEx.CreateControlDefaultImage(B: TBitMap);
var
  i: Integer;
begin
  inherited;
  if FShowBorder then
  Frm3D(B.Canvas, Rect(0, 0, Width, Height), clBtnShadow, clBtnShadow);
  if FImages = nil then Exit;
  CheckScroll;
  CalcItemRects;

  if FItems.Count > 0
  then
    for i := 0 to FItems.Count - 1 do
      if FItems[I].IsVisible then DrawItem(B.Canvas, I);

  if FScrollMax <> 0
  then
    DrawButtons(B.Canvas);
    
end;

procedure TbsSkinToolBarEx.CreateControlSkinImage(B: TBitMap);
var
  i: Integer;
begin
  if FShowBorder
  then
    inherited
  else
    CreateSkinBG(ClRect, Rect(0, 0, Width, Height),
      B, Picture, SkinRect, Width, Height, StretchEffect, StretchType);
  if FImages = nil then Exit;
  CheckScroll;
  CalcItemRects;

  if FItems.Count > 0
  then
    for i := 0 to FItems.Count - 1 do
      if FItems[I].IsVisible then DrawItem(B.Canvas, I);

  if FScrollMax <> 0
  then
    DrawButtons(B.Canvas);
    
end;

function TbsSkinToolBarEx.ItemAtPos(X, Y: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count - 1 do
    if PtInRect(FItems[I].ItemRect, Point(X, Y)) and (FItems[I].Enabled) and
       (FItems[I].IsVisible)
    then
      begin
        Result := I;
        Break;
      end;  
end;

procedure TbsSkinToolBarEx.TestActive(X, Y: Integer);
var
  P: TPoint;
  R: TRect;
begin
  MouseInItem := ItemAtPos(X, Y);
  if (FSkinHint <> nil) and (MouseInItem = -1) and FShowItemHints
  then
    FSkinHint.HideHint;
  if (MouseInItem <> OldMouseInItem)
  then
    begin
      if OldMouseInItem <> -1 then FItems[OldMouseInItem].Active := False;
      OldMouseInItem := MouseInItem;
      if MouseInItem <> -1 then FItems[MouseInItem].Active := True;
      RePaint;
      if FShowHandPointCursor
      then
        begin
          if MouseInItem <> -1
          then
            Cursor := crHandPoint
          else
            Cursor := crDefault;
        end;
      if FShowItemHints and (MouseInItem <> -1) and (FSkinHint <> nil)
      then
        begin
          FSkinHint.HideHint;
          with FItems[MouseInItem] do
          begin
            if Hint <> ''
            then
              begin
                P := ClientToScreen(Point(0, 0));
                P.X := P.X + FItems[MouseInItem].ItemRect.Left;
                R := Rect(P.X, P.Y, P.X + RectWidth(FItems[MouseInItem].ItemRect),
                P.Y + Self.Height);
                FSkinHint.ActivateHint3(R, Hint, Align = alBottom);
              end;
          end;
        end;
    end;
end;

procedure TbsSkinToolBarEx.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  if FShowItemHints and (FSkinHint <> nil) then FSkinHint.HideHint;
  if FHoldSelectedItem and (Button = mbLeft)
  then
    begin
      I := ItemAtPos(X, Y);
      if I <> -1 then ItemIndex := I;
    end;
end;

procedure TbsSkinToolBarEx.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  inherited;
  TestActive(X, Y);
  //
  if FScrollMax <> 0
  then
    for i := 0 to 1 do
    begin
      if PtInRect(Buttons[i].R, Point(X, Y))
      then
        begin
          if not Buttons[i].MouseIn
          then
             begin
              Buttons[i].MouseIn := True;
              RePaint;
            end;
         end
       else
       if Buttons[i].MouseIn
       then
         begin
           Buttons[i].MouseIn := False;
           RePaint;
         end;
    end;
end;

procedure TbsSkinToolBarEx.CMMouseLeave;
begin
  inherited;
  TestActive(-1, -1);
  if ((Buttons[0].MouseIn) or (Buttons[1].MouseIn)) and (FScrollMax <> 0)
  then
    begin
      Buttons[0].MouseIn := False;
      Buttons[1].MouseIn := False;
      RePaint;
    end;
end;

procedure TbsSkinToolBarEx.CMMouseEnter;
begin
  inherited;
end;

procedure TbsSkinToolBarEx.MouseUp(Button: TMouseButton; Shift: TShiftState;
           X, Y: Integer); 
var
  I: Integer;
begin
  inherited;
  if Button = mbLeft
  then
    begin
      I := ItemAtPos(X, Y);
      if (I <> -1) and not FHoldSelectedItem
      then
        begin
          ItemIndex := I;
        end
      else
      if FScrollMax <> 0
      then
        begin
          if PtInRect(Buttons[0].R, Point(X, Y))
          then
            DecScroll
          else
          if PtInRect(Buttons[1].R, Point(X, Y))
          then
            IncScroll;
        end;
    end;
end;

procedure TbsSkinToolBarEx.CheckScroll;
var
  i, j, X, Y: Integer;
  W, Count: Integer;
begin
  if FImages = nil then Exit;

  Count := 0;

  X := 2;
  
  for i := 0 to FItems.Count - 1 do
  begin
    if X + FImages.Width <= Width - 2
    then
      Inc(Count);
    X := X + FImages.Width + FItemSpacing;
  end;

  if FItems.Count > Count
  then
    FScrollMax := FItems.Count - Count           
  else
    begin
      FScrollMax := 0;
      FScrollIndex := 0;
      Buttons[0].MouseIn := False;
      Buttons[1].MouseIn := False;
    end;

  if FScrollIndex <> 0
  then
    begin
      if FScrollIndex + Count > FItems.Count
      then
        Dec(FScrollIndex, FScrollIndex + Count - FItems.Count);
      if FScrollIndex < 0 then FScrollIndex := 0;
    end;

  if Count = 0
  then
    begin
      for i := 0 to FItems.Count - 1 do
        FItems[i].IsVisible := False;
    end
  else
  for i := 0 to FItems.Count - 1 do
    if FScrollMax <> 0
    then
      FItems[i].IsVisible := (i >= FScrollIndex) and (i < FScrollIndex + Count)
    else
      FItems[i].IsVisible := True;
end;

procedure TbsSkinToolBarEx.DecScroll;
begin
  if FScrollMax <> 0
  then
    begin
      Dec(FScrollIndex);
      if FScrollIndex < 0 then FScrollIndex := 0;
    end
  else
    FScrollIndex := 0;
  RePaint;
end;

procedure TbsSkinToolBarEx.IncScroll;
begin
 if FScrollMax <> 0
  then
    begin
      Inc(FScrollIndex);
      if FScrollIndex > FScrollMax then FScrollIndex := FScrollMax;
    end
  else
    FScrollIndex := 0;
  RePaint;
end;

procedure TbsSkinToolBarEx.GetSkinData;
var
  CIndex: Integer;
begin
  inherited;
  if (FSD = nil) or FSD.Empty
  then
    CIndex := -1
  else
    CIndex := FSD.GetControlIndex('stdlabel');
  if CIndex <> -1
  then
    begin
      FSkinArrowColor := TbsDataSkinStdLabelControl(FSD.CtrlList.Items[CIndex]).FontColor;
      FSkinActiveArrowColor := TbsDataSkinStdLabelControl(FSD.CtrlList.Items[CIndex]).ActiveFontColor;
    end
  else
  if (FSD <> nil) and not FSD.Empty
  then
    begin
      FSkinArrowColor := FSD.SkinColors.cBtnText;
      FSkinActiveArrowColor := FSD.SkinColors.cBtnHighLight;
    end;
end;

procedure TbsSkinToolBarEx.DrawButtons;
var
  R: TRect;
  C: TColor;
  i, j, y: Integer;
begin
  if (FArrowImages <> nil) and (FArrowImages.Count >= 2)
  then
    begin
      for i := 0 to 1 do
      begin
        R := Buttons[i].R;
        if Buttons[i].MouseIn
        then
          begin
            j := i + 2;
            if j > FArrowImages.Count - 1 then j := i;
          end
        else
          j := i;
        y := R.Top + RectHeight(R) div 2 - FArrowImages.PngHeight div 2;
        FArrowImages.Draw(Cnvs, R.Left + 2, y, j, True);
      end;
    end
  else
  if FIndex <> -1
  then
    begin
      for i := 0 to 1 do
      begin
        R := Buttons[i].R;
        if Buttons[i].MouseIn
        then
          C := Self.FSkinActiveArrowColor
        else
          C := FSkinArrowColor;
        DrawArrowImage(Cnvs, R, C, i + 1);
      end;   
    end
  else
    begin
      for i := 0 to 1 do
      begin
        R := Buttons[i].R;
        if Buttons[i].MouseIn
        then
          C := clBtnText
        else
          C := clBtnHighLight;
         DrawArrowImage(Cnvs, R, C, i + 1);
      end;
    end;  
end;

// TbsSkinMenuEx ===============================================================

constructor TbsSkinMenuExItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImageIndex := -1;
  FActiveImageIndex := -1;
  FHint := '';
  FUseCustomGlowColor := False;
  FCustomGlowColor := clAqua;
end;

procedure TbsSkinMenuExItem.Assign(Source: TPersistent);
begin
  if Source is TbsSkinMenuExItem then
  begin
    FImageIndex := TbsSkinMenuExItem(Source).ImageIndex;
    FActiveImageIndex := TbsSkinMenuExItem(Source).ActiveImageIndex;
    FUseCustomGlowColor := TbsSkinMenuExItem(Source).FUseCustomGlowColor;
    FCustomGlowColor := TbsSkinMenuExItem(Source).FCustomGlowColor;
    FHint := TbsSkinMenuExItem(Source).Hint;
  end
  else
    inherited Assign(Source);
end;

procedure TbsSkinMenuExItem.SetImageIndex(const Value: TImageIndex);
begin
  FImageIndex := Value;
end;

procedure TbsSkinMenuExItem.SetActiveImageIndex(const Value: TImageIndex);
begin
  FActiveImageIndex := Value;
end;

constructor TbsSkinMenuExItems.Create;
begin
  inherited Create(TbsSkinMenuExItem);
  MenuEx := AMenuEx;
end;

function TbsSkinMenuExItems.GetOwner: TPersistent;
begin
  Result := MenuEx;
end;

function TbsSkinMenuExItems.GetItem(Index: Integer):  TbsSkinMenuExItem;
begin
  Result := TbsSkinMenuExItem(inherited GetItem(Index));
end;

procedure TbsSkinMenuExItems.SetItem(Index: Integer; Value:  TbsSkinMenuExItem);
begin
  inherited SetItem(Index, Value);
end;

constructor TbsSkinMenuEx.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TbsSkinMenuExItems.Create(Self);
  FShowGlow := True;
  FShowActiveCursor := True;
  FShowHints := True;
  FItemIndex := -1;
  FColumnsCount := 1;
  FSkinHint := nil;
  FOnItemClick := nil;
  FSkinData := nil;
  FPopupWindow := nil;
  FAlphaBlend := False;
  FAlphaBlendValue := 200;
  FAlphaBlendAnimation := False;
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := 'Arial';
    Style := [];
    Height := 14;
  end;
  FUseSkinFont := True;
  ToolBarEx := nil;
end;

function TbsSkinMenuEx.GetSelectedItem;
begin
  if (ItemIndex >=0) and (ItemIndex < FItems.Count)
  then
    Result := FItems[ItemIndex]
  else
    Result := nil;
end;

procedure TbsSkinMenuEx.SetSkinData;
begin
  FSkinData := Value;
end;

destructor TbsSkinMenuEx.Destroy;
begin
  if FPopupWindow <> nil then FPopupWindow.Free;
  FDefaultFont.Free;
  FItems.Free;
  inherited Destroy;
end;

procedure TbsSkinMenuEx.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;


procedure TbsSkinMenuEx.SetColumnsCount(Value: Integer);
begin
  if (Value > 0) and (Value < 51)
  then
    FColumnsCount := Value;
end;

procedure TbsSkinMenuEx.SetItems(Value: TbsSkinMenuExItems);
begin
  FItems.Assign(Value);
end;

procedure TbsSkinMenuEx.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
  if (Operation = opRemove) and (AComponent = SkinData) then
    SkinData := nil;
  if (Operation = opRemove) and (AComponent = FSkinHint) then
    FSkinHint := nil;
end;

procedure TbsSkinMenuEx.SetImages;
begin
  FImages := Value;
end;

procedure TbsSkinMenuEx.Popup(AToolBarEx: TbsSkinToolBarEx);
begin
  ToolBarEx := AToolBarEx;
  Popup(0, 0);
end;

procedure TbsSkinMenuEx.Popup(X, Y: Integer);
begin
  if FPopupWindow <> nil then FPopupWindow.Hide(False);

  if Assigned(FOnMenuPopup) then FOnMenuPopup(Self);

  if (FImages = nil) or (FImages.Count = 0) then Exit;
  FOldItemIndex := ItemIndex;
  FPopupWindow := TbsSkinMenuExPopupWindow.Create(Self);
  FPopupWindow.Show(Rect(X, Y, X, Y));
end;

procedure TbsSkinMenuEx.ProcessEvents;
begin
  if FPopupWindow = nil then Exit;
  FPopupWindow.Free;
  FPopupWindow := nil;
  if ToolBarEx <> nil then ToolBarEx.UpdatedSelected;
  ToolBarEx := nil;

  if Assigned(FOnInternalMenuClose)
  then
    FOnInternalMenuClose(Self);

  if Assigned(FOnMenuClose)
  then
    FOnMenuClose(Self);

  if ACanProcess and (ItemIndex <> -1)
  then
   begin
      if Assigned(FItems[ItemIndex].OnClick)
      then
        FItems[ItemIndex].OnClick(Self);
      if Assigned(FOnItemClick) then FOnItemClick(Self);

      if (FOldItemIndex <> ItemIndex) and
         Assigned(FOnInternalChange) then FOnInternalChange(Self);

      if (FOldItemIndex <> ItemIndex) and
         Assigned(FOnChange) then FOnChange(Self);
    end;
end;

procedure TbsSkinMenuEx.Hide;
begin
  if FPopupWindow <> nil then FPopupWindow.Hide(False);
  if ToolBarEx <> nil then ToolBarEx.UpdatedSelected;
end;

constructor TbsSkinMenuExPopupWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Visible := False;
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable];
  MenuEx := TbsSkinMenuEx(AOwner);
  FRgn := 0;
  WindowPicture := nil;
  MaskPicture := nil;
  FSkinSupport := False;
  MouseInItem := -1;
  OldMouseInItem := -1;
  FDown := False;
  FItemDown := False;
end;

destructor TbsSkinMenuExPopupWindow.Destroy;
begin
  inherited Destroy;
  if FRgn <> 0 then DeleteObject(FRgn);
end;

procedure TbsSkinMenuExPopupWindow.FindUp;
var
  I: Integer;
begin
  if Self.MouseInItem = -1 then
  begin
    MouseInItem := MenuEx.Items.Count  - 1;
    RePaint;
    Exit;
  end;
  for I := MouseInItem - 1 downto 0 do
   begin
   if  (MenuEx.Items[I].ItemRect.Top <
        MenuEx.Items[MouseInItem].ItemRect.Top) and
       (MenuEx.Items[I].ItemRect.Left =
        MenuEx.Items[MouseInItem].ItemRect.Left)
    then
      begin
        MouseInItem := I;
        RePaint;
        Break;
      end;
  end;
end;

procedure TbsSkinMenuExPopupWindow.FindDown;
var
  I: Integer;
begin
  if Self.MouseInItem = -1 then
  begin
    MouseInItem := 0;
    RePaint;
    Exit;
  end;

  for I := MouseInItem + 1 to MenuEx.Items.Count - 1 do
  begin
    if (MenuEx.Items[I].ItemRect.Top >
       MenuEx.Items[MouseInItem].ItemRect.Top) and
       (MenuEx.Items[I].ItemRect.Left =
        MenuEx.Items[MouseInItem].ItemRect.Left) 
     then
      begin
        MouseInItem := I;
        RePaint;
        Break;
      end;
  end;
end;

procedure TbsSkinMenuExPopupWindow.FindRight;
var
  I: Integer;
begin
  if Self.MouseInItem = -1 then
  begin
    MouseInItem := 0;
    RePaint;
    Exit;
  end
  else
  if MouseInItem = MenuEx.Items.Count  - 1
  then
    begin
      MouseInItem := 0;
      RePaint;
      Exit;
    end;
  for I := MouseInItem + 1 to MenuEx.Items.Count - 1 do
  begin
    MouseInItem := I;
    RePaint;
    Break;
  end;
end;

procedure TbsSkinMenuExPopupWindow.FindLeft;
var
  I: Integer;
begin
  if Self.MouseInItem = -1 then
  begin
    MouseInItem := MenuEx.Items.Count  - 1;
    RePaint;
    Exit;
  end
  else
  if (MouseInItem = 0)
  then
    begin
      MouseInItem := MenuEx.Items.Count  - 1;
      RePaint;
      Exit;
    end;
  for I := MouseInItem - 1 downto 0 do
  begin
    MouseInItem := I;
    RePaint;
    Break;
  end;
end;


procedure TbsSkinMenuExPopupWindow.ProcessKey(KeyCode: Integer);
begin
  case KeyCode of
   VK_ESCAPE: Self.Hide(False);
   VK_RETURN, VK_SPACE:
    begin
      if MouseInItem <> -1
      then
        MenuEx.ItemIndex := MouseInItem;
      Self.Hide(True);
    end;
    VK_RIGHT: FindRight;
    VK_LEFT: FindLeft;
    VK_UP: FindUp;
    VK_DOWN: FindDown;
  end;
end;

procedure TbsSkinMenuExPopupWindow.WMEraseBkGrnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

function TbsSkinMenuExPopupWindow.GetItemFromPoint;
var
  I: Integer;
  R: TRect;
begin
  Result := -1;
  for I := 0 to MenuEx.Items.Count - 1 do
  begin
    R := GetItemRect(I);
    if PointInRect(R, P)
    then
      begin
        Result := i;
        Break;
      end;
  end;
end;

procedure TbsSkinMenuExPopupWindow.AssignItemRects;
var
  I, W, X, Y,StartX, StartY: Integer;
  ItemWidth, ItemHeight: Integer;
  R: TRect;
begin
  ItemWidth := MenuEx.FImages.Width + 10;
  ItemHeight := MenuEx.FImages.Height + 10;
  W := ItemWidth * MenuEx.ColumnsCount;
  if FSkinSupport
  then
    begin
      StartX := MenuEx.SkinData.PopupWindow.ItemsRect.Left + 10;
      StartY := MenuEx.SkinData.PopupWindow.ItemsRect.Top + 10;
    end
  else
    begin
      StartX := 10;
      StartY := 10;
    end;
  X := StartX;
  Y := StartY;
  for I := 0 to MenuEx.Items.Count - 1 do
  with MenuEx.Items[I] do
  begin
    ItemRect := Rect(X, Y, X + ItemWidth, Y + ItemHeight);
    X := X + ItemWidth;
    if X + ItemWidth > StartX + W
    then
       begin
         X := StartX;
         Inc(Y, ItemHeight + 1);
       end;
  end;
end;


function TbsSkinMenuExPopupWindow.GetItemRect(Index: Integer): TRect;
begin
  Result := MenuEx.Items[Index].ItemRect;
end;

procedure TbsSkinMenuExPopupWindow.TestActive(X, Y: Integer);
begin
  MouseInItem := GetItemFromPoint(Point(X, Y));
  if (MenuEx.SkinHint <> nil) and
     (MouseInItem = -1)
  then
    MenuEx.SkinHint.HideHint;
  if (MouseInItem <> OldMouseInItem)
  then
    begin
      OldMouseInItem := MouseInItem;
      RePaint;
      if MenuEx.ShowHints and (MouseInItem <> -1) and (MenuEx.SkinHint <> nil)
      then
        begin
          MenuEx.SkinHint.HideHint;
          with MenuEx.Items[MouseInItem] do
          begin
            if Hint <> '' then MenuEx.SkinHint.ActivateHint2(Hint);
           end;
        end;
    end;
end;

procedure TbsSkinMenuExPopupWindow.Show(PopupRect: TRect);

procedure CorrectMenuPos(var X, Y: Integer);
var
  WorkArea: TRect;
  P: TPoint;
begin
  if MenuEx.ToolBarEx <> nil
  then
    with MenuEx do
    begin
      P := ToolBarEx.ClientToScreen(Point(ToolBarEx.Width div 2, ToolBarEx.Height));
      X := P.X - Self.Width div 2;
      if ToolBarEx.MenuExPosition = bsmpAuto
      then
        begin
          if ToolBarEx.Align = alBottom
          then
            Y := P.Y - ToolBarEx.Height - Height
           else
             Y := P.Y;
         end
      else
        case ToolBarEx.MenuExPosition of
          bsmpTop: Y := P.Y - ToolBarEx.Height - Height;
          bsmpBottom: Y := P.Y;
        end;
    end;

  if (Screen.ActiveCustomForm <> nil)
  then
    begin
      WorkArea := GetMonitorWorkArea(Screen.ActiveCustomForm.Handle, True);
    end
  else
  if (Application.MainForm <> nil) and (Application.MainForm.Visible)
  then
    WorkArea := GetMonitorWorkArea(Application.MainForm.Handle, True)
  else
    WorkArea := GetMonitorWorkArea(TForm(MenuEx.Owner).Handle, True);
  if Y + Height > WorkArea.Bottom
  then
    begin
      if MenuEx.ToolBarEx <> nil
      then
        Y := P.Y - MenuEx.ToolBarEx.Height - Height
      else
        Y := Y - Height - RectHeight(PopupRect);
    end;
  if X + Width > WorkArea.Right
  then
    X := X - ((X + Width) - WorkArea.Right);
  if X < WorkArea.Left then X := WorkArea.Left;
  if Y < WorkArea.Top
  then
    begin
      if MenuEx.ToolBarEx <> nil
      then
        Y := P.Y
      else
        Y := WorkArea.Top;
    end;
end;

const
  WS_EX_LAYERED = $80000;

var
  ShowX, ShowY: Integer;
  I: Integer;
  TickCount: DWORD;
  AnimationStep: Integer;
begin
  CreateMenu;
  ShowX := PopupRect.Left;
  ShowY := PopupRect.Bottom;
  CorrectMenuPos(ShowX, ShowY);

  if CheckW2KWXP and MenuEx.AlphaBlend
  then
    begin
      SetWindowLong(Handle, GWL_EXSTYLE,
                    GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
      if MenuEx.AlphaBlendAnimation
      then
        SetAlphaBlendTransparent(Handle, 0)
      else
        SetAlphaBlendTransparent(Handle, MenuEx.AlphaBlendValue);
    end;

  SetWindowPos(Handle, HWND_TOPMOST, ShowX, ShowY, 0, 0,
               SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE);


  Visible := True;

  if MenuEx.AlphaBlendAnimation and MenuEx.AlphaBlend and CheckW2KWXP
  then
    begin
      Application.ProcessMessages;
      I := 0;
      TickCount := 0;
       AnimationStep := MenuEx.AlphaBlendValue div 15;
      if AnimationStep = 0 then AnimationStep := 1;
      repeat
        if (GetTickCount - TickCount > 5)
        then
          begin
            TickCount := GetTickCount;
            Inc(i, AnimationStep);
            if i > MenuEx.AlphaBlendValue then i := MenuEx.AlphaBlendValue;
            SetAlphaBlendTransparent(Handle, i);
          end;  
      until i >= MenuEx.AlphaBlendValue;
    end;

  HookApp;

  SetCapture(Handle);
end;

procedure TbsSkinMenuExPopupWindow.Hide;
begin
  if MenuEx.ShowHints and (MenuEx.SkinHint <> nil)
  then
    MenuEx.SkinHint.HideHint;
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  Visible := False;
  UnHookApp;
  if GetCapture = Handle then ReleaseCapture;
  MenuEx.ProcessEvents(AProcessEvents);
end;

procedure TbsSkinMenuExPopupWindow.DrawItems(ActiveIndex, SelectedIndex: Integer; C: TCanvas);
var
  I, J: Integer;
  R: TRect;
  IX, IY: Integer;
  IsActive, IsDown: Boolean;
  B: TbsBitmap;
  GC: TColor;
begin
  for I := 0 to MenuEx.Items.Count - 1 do
  begin
    R := GetItemRect(I);
    IX := R.Left + 5;
    IY := R.Top + 5;
    if (MenuEx.Items[I].ImageIndex >= 0) and
       (MenuEx.Items[I].ImageIndex < MenuEx.Images.Count) and (I <> ActiveIndex)
    then
      begin
        MenuEx.Images.Draw(C, IX, IY, MenuEx.Items[I].ImageIndex, True);
      end;
  end;
  //
  if (ActiveIndex >= 0) and (ActiveIndex < MenuEx.Items.Count)
  then
    begin
      R := GetItemRect(ActiveIndex);
      IX := R.Left + 5;
      IY := R.Top + 5;
      // draw glow effect
      if MenuEx.ShowGlow
      then
        begin
          B := TbsBitMap.Create;
          B.SetSize(MenuEx.FImages.Width + 20, MenuEx.Images.Height + 20);
          MakeBlurBlank(B, MenuEx.FImages.PngImages.Items[MenuEx.FItems[ActiveIndex].ImageIndex].PngImage, 10);
          Blur(B, 10);
          //
          if Self.FSkinSupport
          then
            begin
              if MenuEx.FItems[ActiveIndex].UseCustomGlowColor
              then
                GC := MenuEx.FItems[ActiveIndex].CustomGlowColor
              else
                GC := MenuEx.SkinData.SkinColors.cHighLight
            end
          else
            GC := clAqua;
          //
          for I := 0 to B.Width - 1 do
          for J := 0 to B.Height - 1 do
          begin
            PbsColorRec(B.PixelPtr[i, j]).Color := FromRGB(GC) and
            not $FF000000 or (PbsColorRec(B.PixelPtr[i, j]).R shl 24);
          end;
          //
          B.Draw(C, IX - 10, IY - 10);
          B.Free;  
        end;
      //
      if (MenuEx.Items[ActiveIndex].ActiveImageIndex >= 0) and
         (MenuEx.Items[ActiveIndex].ActiveImageIndex < MenuEx.Images.Count)
      then
        MenuEx.Images.Draw(C, IX, IY, MenuEx.Items[ActiveIndex].ActiveImageIndex, True)
      else
      if (MenuEx.Items[ActiveIndex].ImageIndex >= 0) and
         (MenuEx.Items[ActiveIndex].ImageIndex < MenuEx.Images.Count)
      then
        MenuEx.Images.Draw(C, IX, IY, MenuEx.Items[ActiveIndex].ImageIndex, True);
      //
      if MenuEx.ShowActiveCursor
      then
        begin
          if  MenuEx.Items[ActiveIndex].UseCustomGlowColor
          then
            GC := MenuEx.Items[ActiveIndex].CustomGlowColor
          else
          if Self.FSkinSupport
          then
            GC := MenuEx.SkinData.SkinColors.cHighLight
          else
            GC := clAqua;
          R := MenuEx.Items[ActiveIndex].ItemRect;
          R.Top := R.Bottom - 5;
          R.Bottom := R.Top + 10;
          DrawBlurMarker(C, R, GC);
        end;  
      //
    end;
end;

procedure TbsSkinMenuExPopupWindow.Paint;
var
  Buffer: TBitMap;
  SelectedIndex: Integer;
begin
  FSkinSupport := (MenuEx.SkinData <> nil) and (not MenuEx.SkinData.Empty) and
                  (MenuEx.SkinData.PopupWindow.WindowPictureIndex <> -1);


  SelectedIndex := MenuEx.ItemIndex;

  Buffer := TBitMap.Create;
  Buffer.Width := Width;
  Buffer.Height := Height;
  if FSkinSupport
  then
    with MenuEx.SkinData.PopupWindow do
    begin
      CreateSkinImageBS(LTPoint, RTPoint, LBPoint, RBPoint,
      ItemsRect, NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint,
      NewItemsRect, Buffer, WindowPicture,
      Rect(0, 0, WindowPicture.Width, WindowPicture.Height),
      Width, Height, True, LeftStretch, TopStretch,
      RightStretch, BottomStretch, StretchEffect, StretchType);
      DrawItems(MouseInItem, SelectedIndex, Buffer.Canvas);
    end
  else
    with Buffer.Canvas do
    begin
      Pen.Color := clBtnShadow;
      Brush.Color := clWindow;
      Rectangle(0, 0, Buffer.Width, Buffer.Height);
      DrawItems(MouseInItem, SelectedIndex, Buffer.Canvas);
    end;
  Canvas.Draw(0, 0, Buffer);
  Buffer.Free;
end;

procedure TbsSkinMenuExPopupWindow.CreateMenu;
var
  ItemsWidth, ItemsHeight: Integer;
  ItemsR: TRect;
begin

  FSkinSupport := (MenuEx.SkinData <> nil) and (not MenuEx.SkinData.Empty) and
                  (MenuEx.SkinData.PopupWindow.WindowPictureIndex <> -1);

  AssignItemRects;

  ItemsWidth := (MenuEx.Images.Width + 10) * MenuEx.ColumnsCount;

  ItemsR := Rect(MenuEx.Items[0].ItemRect.Left,
                 MenuEx.Items[0].ItemRect.Top,
                 MenuEx.Items[0].ItemRect.Left + ItemsWidth,
                 MenuEx.Items[MenuEx.Items.Count - 1].ItemRect.Bottom);


  ItemsHeight := RectHeight(ItemsR);

  if (MenuEx.SkinData <> nil) and (not MenuEx.SkinData.Empty) and
     (MenuEx.SkinData.PopupWindow.WindowPictureIndex <> -1)
  then
    with MenuEx.SkinData.PopupWindow do
    begin
      if (WindowPictureIndex <> - 1) and
         (WindowPictureIndex < MenuEx.SkinData.FActivePictures.Count)
      then
        WindowPicture := MenuEx.SkinData.FActivePictures.Items[WindowPictureIndex];

      if (MaskPictureIndex <> - 1) and
           (MaskPictureIndex < MenuEx.SkinData.FActivePictures.Count)
      then
        MaskPicture := MenuEx.SkinData.FActivePictures.Items[MaskPictureIndex]
      else
        MaskPicture := nil;

      Self.Width := ItemsWidth + (WindowPicture.Width - RectWidth(ItemsRect)) + 20;
      Self.Height := ItemsHeight + (WindowPicture.Height - RectHeight(ItemsRect)) + 20;

      NewLTPoint := LTPoint;
      NewRTPoint := Point(Width - (WindowPicture.Width - RTPoint.X), RTPoint.Y);
      NewLBPoint := Point(LBPoint.X, Height - (WindowPicture.Height - LBPoint.Y));
      NewRBPoint := Point(Width - (WindowPicture.Width - RBPoint.X),
                          Height - (WindowPicture.Height - RBPoint.Y));

      NewItemsRect := Rect(ItemsRect.Left, ItemsRect.Top,
                           Width - (WindowPicture.Width - ItemsRect.Right),
                           Height - (WindowPicture.Height - ItemsRect.Bottom));

      if MaskPicture <> nil then SetMenuWindowRegion;
    end
  else
    begin
      Self.Width := ItemsWidth + 20;
      Self.Height := ItemsHeight + 20;
    end;
end;

procedure TbsSkinMenuExPopupWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    ExStyle := WS_EX_TOOLWINDOW;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    if CheckWXP then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW_ ;
  end;
end;

procedure TbsSkinMenuExPopupWindow.CMMouseLeave(var Message: TMessage);
begin
  if MenuEx.ShowHints and (MenuEx.SkinHint <> nil)
  then
    MenuEx.SkinHint.HideHint;
  MouseInItem := -1;
  OldMouseInItem := -1;
  RePaint;
end;

procedure TbsSkinMenuExPopupWindow.CMMouseEnter(var Message: TMessage);
begin

end;

procedure TbsSkinMenuExPopupWindow.MouseDown(Button: TMouseButton; Shift: TShiftState;
   X, Y: Integer);
begin
  inherited;
  if MenuEx.ShowHints and (MenuEx.SkinHint <> nil)
  then
    MenuEx.SkinHint.HideHint;
  FDown := True;
  if GetItemFromPoint(Point(X, Y)) <> -1
    then FItemDown := True else FItemDown := False;
  RePaint;
end;

procedure TbsSkinMenuExPopupWindow.MouseUp(Button: TMouseButton; Shift: TShiftState;
   X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  if not FDown
  then
    begin
      if GetCapture = Handle then ReleaseCapture;
      SetCapture(Handle);
    end
  else
    begin
      I := GetItemFromPoint(Point(X, Y));
      if I <> -1 then MenuEx.ItemIndex := I;
      if I <> -1 then Hide(I <> -1)
      else
        begin
          if GetCapture = Handle then ReleaseCapture;
          SetCapture(Handle);
        end;
    end;
end;

procedure TbsSkinMenuExPopupWindow.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TestActive(X, Y);
end;

procedure TbsSkinMenuExPopupWindow.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TbsSkinMenuExPopupWindow.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  case Message.Msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
     begin
       if Windows.WindowFromPoint(Mouse.CursorPos) <> Self.Handle
       then
         Hide(False);
     end;
  end;
end;

procedure TbsSkinMenuExPopupWindow.HookApp;
begin
  OldAppMessage := Application.OnMessage;
  Application.OnMessage := NewAppMessage;
end;

procedure TbsSkinMenuExPopupWindow.UnHookApp;
begin
  Application.OnMessage := OldAppMessage;
end;

procedure TbsSkinMenuExPopupWindow.NewAppMessage;
begin
  if (Msg.message = WM_KEYDOWN)
  then
    begin
      ProcessKey(Msg.wParam);
      Msg.message := 0;
    end
  else
  case Msg.message of
     WM_MOUSEACTIVATE, WM_ACTIVATE,
     WM_RBUTTONDOWN, WM_MBUTTONDOWN,
     WM_NCLBUTTONDOWN, WM_NCMBUTTONDOWN, WM_NCRBUTTONDOWN,
     WM_KILLFOCUS, WM_MOVE, WM_SIZE, WM_CANCELMODE, WM_PARENTNOTIFY,
     WM_SYSKEYDOWN, WM_SYSCHAR:
      begin
        Hide(False);
      end;
  end;
end;

procedure TbsSkinMenuExPopupWindow.SetMenuWindowRegion;
var
  TempRgn: HRgn;
begin
  TempRgn := FRgn;
  with MenuEx.FSkinData.PopupWindow do
  CreateSkinRegion
    (FRgn, LTPoint, RTPoint, LBPoint, RBPoint, ItemsRect,
     NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewItemsRect,
     MaskPicture, Width, Height);
  SetWindowRgn(Handle, FRgn, True);
  if TempRgn <> 0 then DeleteObject(TempRgn);
end;

// TbsSkinHorzListBox

constructor TbsSkinHorzItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImageIndex := -1;
  FCaption := '';
  FEnabled := True;
  if TbsSkinHorzItems(Collection).HorzListBox.ItemIndex = Self.Index
  then
    Active := True
  else
    Active := False;
end;

procedure TbsSkinHorzItem.Assign(Source: TPersistent);
begin
  if Source is TbsSkinHorzItem then
  begin
    FImageIndex := TbsSkinHorzItem(Source).ImageIndex;
    FCaption := TbsSkinHorzItem(Source).Caption;
    FEnabled := TbsSkinHorzItem(Source).Enabled;
  end
  else
    inherited Assign(Source);
end;

procedure TbsSkinHorzItem.SetImageIndex(const Value: TImageIndex);
begin
  FImageIndex := Value;
  Changed(False);
end;

procedure TbsSkinHorzItem.SetCaption(const Value: String);
begin
  FCaption := Value;
  Changed(False);
end;

procedure TbsSkinHorzItem.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  Changed(False);
end;

procedure TbsSkinHorzItem.SetData(const Value: Pointer);
begin
  FData := Value;
end;

constructor TbsSkinHorzItems.Create;
begin
  inherited Create(TbsSkinHorzItem);
  HorzListBox := AListBox;
end;

function TbsSkinHorzItems.GetOwner: TPersistent;
begin
  Result := HorzListBox;
end;

procedure  TbsSkinHorzItems.Update(Item: TCollectionItem);
begin
  HorzListBox.Repaint;
  HorzListBox.UpdateScrollInfo;
end; 

function TbsSkinHorzItems.GetItem(Index: Integer):  TbsSkinHorzItem;
begin
  Result := TbsSkinHorzItem(inherited GetItem(Index));
end;

procedure TbsSkinHorzItems.SetItem(Index: Integer; Value:  TbsSkinHorzItem);
begin
  inherited SetItem(Index, Value);
  HorzListBox.RePaint;
end;

function TbsSkinHorzItems.Add: TbsSkinHorzItem;
begin
  Result := TbsSkinHorzItem(inherited Add);
  HorzListBox.RePaint;
end;

function TbsSkinHorzItems.Insert(Index: Integer): TbsSkinHorzItem;
begin
  Result := TbsSkinHorzItem(inherited Insert(Index));
  HorzListBox.RePaint;
end;

procedure TbsSkinHorzItems.Delete(Index: Integer);
begin
  inherited Delete(Index);
  HorzListBox.RePaint;
end;

procedure TbsSkinHorzItems.Clear;
begin
  inherited Clear;
  HorzListBox.RePaint;
end;

constructor TbsSkinHorzListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csAcceptsControls];
  FInUpdateItems := False;
  FShowGlow := False;
  FItemMargin := -1;
  FItemSpacing := 1;
  FItemLayout := blGlyphTop;
  FClicksDisabled := False;
  FMouseMoveChangeIndex := False;
  FMouseDown := False;
  FMouseActive := -1;
  ScrollBar := nil;
  FScrollOffset := 0;
  FItems := TbsSkinHorzItems.Create(Self);
  FImages := nil;
  Width := 250;
  Height := 100;
  FItemWidth := 70;
  FSkinDataName := 'listbox';
  FShowItemTitles := True;
  FMax := 0;
  FRealMax := 0;
  FOldWidth := -1;
  FItemIndex := -1;
  FDisabledFontColor := clGray;
end;

destructor TbsSkinHorzListBox.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TbsSkinHorzListBox.Loaded;
begin
  inherited;
  if FItemIndex <> -1 then ScrollToItem(FItemIndex);
end;

procedure TbsSkinHorzListBox.BeginUpdateItems;
begin
  FInUpdateItems := True;
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
end;

procedure TbsSkinHorzListBox.EndUpdateItems;
begin
  FInUpdateItems := False;
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  RePaint;
  UpdateScrollInfo;
end;


procedure TbsSkinHorzListBox.SetShowGlow;
begin
  if FShowGlow <> Value
  then
    begin
      FShowGlow := Value;
      RePaint;
    end;
end;

procedure TbsSkinHorzListBox.SetItemLayout(Value: TbsButtonLayout);
begin
  FItemLayout := Value;
  Invalidate;
end;

procedure TbsSkinHorzListBox.SetItemMargin(Value: Integer);
begin
  FItemMargin := Value;
  Invalidate;
end;


procedure TbsSkinHorzListBox.SetItemSpacing(Value: Integer);
begin
  FItemSpacing := Value;
  Invalidate;
end;

function TbsSkinHorzListBox.CalcWidth;
var
  W: Integer;
begin
  if AItemCount > FItems.Count then AItemCount := FItems.Count;
  W := AItemCount * ItemWidth;
  if FIndex = -1
  then
    begin
      W := W + 5;
    end
  else
    begin
      W := W + Width - RectWidth(RealClientRect) + 1;
    end;
  Result := W;
end;

procedure TbsSkinHorzListBox.ChangeSkinData;
var
  CIndex: Integer;
begin
  inherited;
  //
  if SkinData <> nil
  then
    CIndex := SkinData.GetControlIndex('edit');
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

procedure TbsSkinHorzListBox.SetItemWidth(Value: Integer);
begin
  if FItemWidth <> Value
  then
    begin
      FItemWidth := Value;
      RePaint;
    end;
end;

procedure TbsSkinHorzListBox.SetItems(Value: TbsSkinHorzItems);
begin
  FItems.Assign(Value);
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinHorzListBox.SetImages(Value: TCustomImageList);
begin
  FImages := Value;
end;

procedure TbsSkinHorzListBox.Notification(AComponent: TComponent;
            Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then
   FImages := nil;
end;

procedure TbsSkinHorzListBox.SetShowItemTitles(Value: Boolean);
begin
  if FShowItemTitles <> Value
  then
    begin
      FShowItemTitles := Value;
      RePaint;
    end;
end;

procedure TbsSkinHorzListBox.DrawItem;
var
  Buffer: TBitMap;
  R: TRect;
begin
  if FIndex <> -1
  then
    SkinDrawItem(Index, Cnvs)
  else
    DefaultDrawItem(Index, Cnvs);
end;

procedure TbsSkinHorzListBox.CreateControlDefaultImage(B: TBitMap);
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

procedure TbsSkinHorzListBox.CreateControlSkinImage(B: TBitMap);
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

procedure TbsSkinHorzListBox.CalcItemRects;
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
  if ScrollBar <> nil then Dec(FItemsRect.Bottom, ScrollBar.Height);  
  X := FItemsRect.Left;
  Y := FItemsRect.Top;
  H:= RectHeight(FItemsRect);
  for I := 0 to FItems.Count - 1 do
    with TbsSkinHorzItem(FItems[I]) do
    begin
      W := ItemWidth;
      ItemRect := Rect(X, Y, X + W, Y + H);
      OffsetRect(ItemRect, - FScrollOffset, 0);
      IsVisible := RectToRect(ItemRect, FItemsRect);
      if not IsVisible and (ItemRect.Left <= FItemsRect.Left) and
        (ItemRect.Right >= FItemsRect.Right)
      then
        IsVisible := True;
      if IsVisible then FRealMax := ItemRect.Right;
      X := X + W;
    end;
  FMax := X;
end;

procedure TbsSkinHorzListBox.Scroll(AScrollOffset: Integer);
begin
  FScrollOffset := AScrollOffset;
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinHorzListBox.GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
begin
  CalcItemRects;
  AMin := 0;
  AMax := FMax - FItemsRect.Left;
  APage := RectWidth(FItemsRect);
  if AMax <= APage
  then
    begin
      APage := 0;
      AMax := 0;
    end;  
  APosition := FScrollOffset;
end;

procedure TbsSkinHorzListBox.WMSize(var Msg: TWMSize);
begin
  inherited;
  if (FOldWidth <> Height) and (FOldWidth <> -1)
  then
    begin
      CalcItemRects;
      if (FRealMax <= FItemsRect.Right) and (FScrollOffset > 0)
      then
        begin
          FScrollOffset := FScrollOffset - (FItemsRect.Right - FRealMax);
          if FScrollOffset < 0 then FScrollOffset := 0;
          CalcItemRects;
          Invalidate;
        end;
    end;
  AdjustScrollBar;
  UpdateScrollInfo;
  FOldWidth := Width;
end;

procedure TbsSkinHorzListBox.ScrollToItem(Index: Integer);
var
  R, R1: TRect;
begin
  if FItems.Count = 0 then Exit;
  CalcItemRects;
  R1 := FItems[Index].ItemRect;
  R := R1;
  OffsetRect(R, FScrollOffset, 0);
  if (R1.Left <= FItemsRect.Left)
  then
    begin
      FScrollOffset := R.Left - FItemsRect.Left;
      CalcItemRects;
      Invalidate;
    end
  else
  if R1.Right >= FItemsRect.Right
  then
    begin
      FScrollOffset := R.Left;
      FScrollOffset := FScrollOffset - RectWidth(FItemsRect) + RectWidth(R) -
        Width + FItemsRect.Right + 1;
      CalcItemRects;
      Invalidate;
    end;
  UpdateScrollInfo;  
end;

procedure TbsSkinHorzListBox.ShowScrollbar;
begin
  if ScrollBar = nil
  then
    begin
      ScrollBar := TbsSkinScrollBar.Create(Self);
      ScrollBar.Visible := False;
      ScrollBar.Parent := Self;
      ScrollBar.DefaultHeight := 19;
      ScrollBar.DefaultWidth := 0;
      ScrollBar.SmallChange := ItemWidth;
      ScrollBar.LargeChange := ItemWidth;
      ScrollBar.SkinDataName := 'hscrollbar';
      ScrollBar.Kind := sbHorizontal;
      ScrollBar.SkinData := Self.SkinData;
      ScrollBar.OnChange := SBChange;
      AdjustScrollBar;
      ScrollBar.Visible := True;
      RePaint;
    end;
end;

procedure TbsSkinHorzListBox.HideScrollBar;
begin
  if ScrollBar = nil then Exit;
  ScrollBar.Visible := False;
  ScrollBar.Free;
  ScrollBar := nil;
  RePaint;
end;

procedure TbsSkinHorzListBox.UpdateScrollInfo;
var
  SMin, SMax, SPage, SPos: Integer;
begin
  //
  if not HandleAllocated then Exit;
  //
  if FInUpdateItems then Exit;
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

procedure TbsSkinHorzListBox.AdjustScrollBar;
var
  R: TRect;
begin
  if ScrollBar = nil then Exit;
  if FIndex = -1
  then
    R := Rect(2, 2, Width - 2, Height - 2)
  else
    R := RealClientRect;
  Dec(R.Bottom, ScrollBar.Height);
  ScrollBar.SetBounds(R.Left, R.Bottom, RectWidth(R), ScrollBar.Height);
end;

procedure TbsSkinHorzListBox.SBChange(Sender: TObject);
begin
  Scroll(ScrollBar.Position);
end;

procedure TbsSkinHorzListBox.SkinDrawItem(Index: Integer; Cnvs: TCanvas);
var
  ListBoxData: TbsDataSkinListBox;
  CIndex, TX, TY: Integer;
  R, R1: TRect;
  Buffer: TBitMap;
  C: TColor;
  SaveIndex: Integer;
begin
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
    begin
      if (FSkinDataName = 'listbox') or
         (FSkinDataName = 'memo') or
         (FSkinDataName = 'menupagepanel')
      then
        Cnvs.Font.Color := ListBoxData.FontColor
      else
        Cnvs.Font.Color := FSD.SkinColors.cBtnText;
    end
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
      //
     if Assigned(FOnDrawItem)
      then
        begin
          Cnvs.Brush.Style := bsClear;
          FOnDrawItem(Cnvs, Index, R);
        end
      else
        DrawImageAndText(Cnvs, R, FItemMargin, FItemSpacing, FItemLayout,
          Caption, FImageIndex, FImages,
          False, Enabled, False, 0);
      //
      RestoreDC(Cnvs.Handle, SaveIndex);
    end
  else  
  if FShowGlow
  then
    begin
      SaveIndex := SaveDC(Cnvs.Handle);
      IntersectClipRect(Cnvs.Handle, FItems[Index].ItemRect.Left, FItems[Index].ItemRect.Top,
        FItems[Index].ItemRect.Right, FItems[Index].ItemRect.Bottom);
      //
      if Assigned(FOnDrawItem)
      then
        begin
          Cnvs.Brush.Style := bsClear;
          FOnDrawItem(Cnvs, Index, R);
        end
      else
      DrawImageAndTextGlow(Cnvs, R, FItemMargin, FItemSpacing, FItemLayout,
        FItems[Index].Caption, FItems[Index].FImageIndex, FImages,
        False, Enabled, False, 0, SkinData.SkinColors.cHighLight, 7);
      //
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

       //
       if Assigned(FOnDrawItem)
      then
        begin
          Buffer.Canvas.Brush.Style := bsClear;
          FOnDrawItem(Buffer.Canvas, Index, R);
        end
      else
        DrawImageAndText(Buffer.Canvas, R, FItemMargin, FItemSpacing, FItemLayout,
          Caption, FImageIndex, FImages,
          False, Enabled, False, 0);
       //
       Cnvs.Draw(FItems[Index].ItemRect.Left,
         FItems[Index].ItemRect.Top, Buffer);
      Buffer.Free;
    end;
end;

procedure TbsSkinHorzListBox.DefaultDrawItem(Index: Integer; Cnvs: TCanvas);
var
  R, R1: TRect;
  C, FC: TColor;
  TX, TY: Integer;
  SaveIndex: Integer;
begin
  if (FItems[Index].Active) and not FShowGlow
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
  if Assigned(FOnDrawItem)
  then
    begin
      Cnvs.Brush.Style := bsClear;
      FOnDrawItem(Cnvs, Index, R);
    end
  else
  with FItems[Index] do
  begin
    if FShowGlow and FItems[Index].Active
    then
      DrawImageAndTextGlow(Cnvs, R, FItemMargin, FItemSpacing, FItemLayout,
        Caption, FImageIndex, FImages,
        False, Enabled, False, 0, clAqua, 7)
    else
      DrawImageAndText(Cnvs, R, FItemMargin, FItemSpacing, FItemLayout,
        Caption, FImageIndex, FImages,
        False, Enabled, False, 0);
  end;
  if FItems[Index].Active and Focused
  then
    Cnvs.DrawFocusRect(FItems[Index].ItemRect);
  RestoreDC(Cnvs.Handle, SaveIndex);
end;

procedure TbsSkinHorzListBox.SetItemIndex(Value: Integer);
var
  I: Integer;
  IsFind: Boolean;
begin
  if Value < 0
  then
    begin
      FItemIndex := Value;
      RePaint;
    end
  else
    begin
      FItemIndex := Value;
      IsFind := False;
      for I := 0 to FItems.Count - 1 do
        with FItems[I] do
        begin
          if I = FItemIndex
          then
            begin
              Active := True;
              IsFind := True;
            end
          else
             Active := False;
        end;
      RePaint;
      ScrollToItem(FItemIndex);
      if IsFind and not (csDesigning in ComponentState) and not (csLoading in ComponentState)
      then
      begin
        if Assigned(FItems[FItemIndex].OnClick) then
          FItems[FItemIndex].OnClick(Self);
        if Assigned(FOnItemClick) then
          FOnItemClick(Self);
      end;    
    end;
end;

function TbsSkinHorzListBox.ItemAtPos(X, Y: Integer): Integer;
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


procedure TbsSkinHorzListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  I := ItemAtPos(X, Y);
  if (I <> -1) and (Button = mbLeft)
  then
    begin
      SetItemActive(I);
      FMouseDown := True;
      FMouseActive := I;
    end;
end;

procedure TbsSkinHorzListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  FMouseDown := False;
  I := ItemAtPos(X, Y);
  if (I <> -1) and  (Button = mbLeft) then ItemIndex := I;
end;

procedure TbsSkinHorzListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  I := ItemAtPos(X, Y);
  if (I <> -1) and (FMouseDown or FMouseMoveChangeIndex)
   and (I <> FMouseActive)
  then
    begin
      SetItemActive(I);
      FMouseActive := I;
    end;
end;

procedure TbsSkinHorzListBox.SetItemActive(Value: Integer);
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

procedure TbsSkinHorzListBox.WMMOUSEWHEEL(var Message: TMessage);
begin
  inherited;
  if ScrollBar = nil then Exit;
  if Message.WParam < 0
  then
    ScrollBar.Position :=  ScrollBar.Position + ScrollBar.SmallChange
  else
    ScrollBar.Position :=  ScrollBar.Position - ScrollBar.SmallChange;

end;

procedure TbsSkinHorzListBox.WMSETFOCUS(var Message: TWMSETFOCUS);
begin
  inherited;
  RePaint;
end;

procedure TbsSkinHorzListBox.WMKILLFOCUS(var Message: TWMKILLFOCUS);
begin
  inherited;
  RePaint;
end;

procedure TbsSkinHorzListBox.WndProc(var Message: TMessage);
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

procedure TbsSkinHorzListBox.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
end;

procedure TbsSkinHorzListBox.FindUp;
var
  I, Start: Integer;
begin
  if ItemIndex <= -1 then Exit;
  Start := FItemIndex - 1;
  if Start < 0 then Exit;
  for I := Start downto 0 do
  begin
    if FItems[I].Enabled
    then
      begin
        ItemIndex := I;
        Exit;
      end;  
  end;
end;

procedure TbsSkinHorzListBox.FindDown;
var
  I, Start: Integer;
begin
  if ItemIndex <= -1 then Start := 0 else Start := FItemIndex + 1;
  if Start > FItems.Count - 1 then Exit;
  for I := Start to FItems.Count - 1 do
  begin
    if FItems[I].Enabled
    then
      begin
        ItemIndex := I;
        Exit;
      end;
  end;
end;

procedure TbsSkinHorzListBox.FindPageUp;
var
  I, J, Start: Integer;
  PageCount: Integer;
begin
  if ItemIndex <= -1 then Exit;
  Start := FItemIndex - 1;
  if Start < 0 then Exit;
  PageCount := RectWidth(FItemsRect) div FItemWidth;
  if PageCount = 0 then PageCount := 1;
  PageCount := Start - PageCount;
  if PageCount < 0 then PageCount := 0;
  J := -1;
  for I := Start downto PageCount do
  begin
    if FItems[I].Enabled
    then
      begin
        J := I;
      end;
  end;
  if J <> -1 then ItemIndex := J;
end;


procedure TbsSkinHorzListBox.FindPageDown;
var
  I, J, Start: Integer;
  PageCount: Integer;
begin
  if ItemIndex <= -1 then Start := 0 else Start := FItemIndex + 1;
  if Start > FItems.Count - 1 then Exit;
  PageCount := RectWidth(FItemsRect) div FItemWidth;
  if PageCount = 0 then PageCount := 1;
  PageCount := Start + PageCount;
  if PageCount > FItems.Count - 1 then PageCount := FItems.Count - 1;
  J := -1;
  for I := Start to PageCount do
  begin
    if FItems[I].Enabled
    then
      begin
        J := I;
      end;
  end;
  if J <> -1 then ItemIndex := J;
end;

procedure TbsSkinHorzListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
 inherited KeyDown(Key, Shift);
 case Key of
   VK_NEXT:  FindPageDown;
   VK_PRIOR: FindPageUp;
   VK_UP, VK_LEFT: FindUp;
   VK_DOWN, VK_RIGHT: FindDown;
 end;
end;


constructor TbsSkinDivider.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csOpaque];
  FSkinDataName := 'bevel';
  FDividerType := bstdtVerticalLine;
  Width := 25;
  Height := 50;
end;

procedure TbsSkinDivider.SetDividerType(Value: TbsSkinDividerType);
begin
  FDividerType := Value;
  Invalidate;
end;

procedure TbsSkinDivider.DrawLineH;
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

procedure TbsSkinDivider.DrawLineV;
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

procedure TbsSkinDivider.GetSkinData;
begin
  inherited;
  if FIndex = -1
  then
    begin
      if (FSD <> nil) and not FSD.Empty
      then
        begin
          DarkColor := FSD.SkinColors.cBtnShadow;
        end
      else
        begin
          DarkColor := clBtnShadow;
        end;  
    end
  else
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinBevel
    then
      with TbsDataSkinBevel(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.DarkColor := DarkColor;
      end;
end;

procedure TbsSkinDivider.Paint;
begin
  GetSkinData;
  case FDividerType of
    bstdtVerticalLine: DrawLineV;
    bstdtHorizontalLine: DrawLineH;
  end;
end;


// Graphic controls

constructor TbsSkinGraphicButton.Create(AOwner: TComponent);
begin
  inherited;
  Width := 65;
  FGraphicImages := TCustomImageList.Create(Self);
  FGraphicMenu := TbsSkinImagesMenu.Create(Self);
  FGraphicMenu.Images := FGraphicImages;
  SkinImagesMenu := FGraphicMenu;
  FUseImagesMenuImage := True;
  InitImages;
  InitItems;
end;

destructor TbsSkinGraphicButton.Destroy;
begin
  FGraphicImages.Clear;
  FGraphicImages.Free;
  FGraphicMenu.Free;
  inherited;
end;

procedure TbsSkinGraphicButton.Loaded;
begin
  inherited;
  SkinImagesMenu := FGraphicMenu;
  FGraphicMenu.Skindata := Self.SkinData;
end;

function TbsSkinGraphicButton.GetItemIndex: Integer;
begin
  Result := FGraphicMenu.ItemIndex;
end;

procedure TbsSkinGraphicButton.SetItemIndex(Value: Integer);
begin
  FGraphicMenu.ItemIndex := Value;
  RePaint;
end;

function TbsSkinGraphicButton.GetSelectedItem;
begin
  Result := FGraphicMenu.SelectedItem;
end;

function TbsSkinGraphicButton.GetMenuShowHints: Boolean;
begin
  Result := FGraphicMenu.ShowHints;
end;

procedure TbsSkinGraphicButton.SetMenuShowHints(Value: Boolean);
begin
  FGraphicMenu.ShowHints := Value;
end;

function TbsSkinGraphicButton.GetMenuSkinHint: TbsSkinHint;
begin
  Result := FGraphicMenu.SkinHint;
end;

procedure TbsSkinGraphicButton.SetMenuSkinHint(Value: TbsSkinHint);
begin
  FGraphicMenu.SkinHint := Value;
end;

procedure TbsSkinGraphicButton.InitImages;
begin
end;

procedure TbsSkinGraphicButton.InitItems;
begin
end;

function TbsSkinGraphicButton.GetGraphicMenuItems: TbsImagesMenuItems;
begin
  Result := FGraphicMenu.ImagesItems;
end;

function TbsSkinGraphicButton.GetMenuDefaultFont: TFont;
begin
  Result := FGraphicMenu.DefaultFont;
end;

procedure TbsSkinGraphicButton.SetMenuDefaultFont(Value: TFont);
begin
  FGraphicMenu.DefaultFont.Assign(Value);
end;

function TbsSkinGraphicButton.GetMenuUseSkinFont: Boolean;
begin
  Result := FGraphicMenu.UseSkinFont;
end;

procedure TbsSkinGraphicButton.SetMenuUseSkinFont(Value: Boolean);
begin
  FGraphicMenu.UseSkinFont := Value;
end;

function TbsSkinGraphicButton.GetMenuAlphaBlend: Boolean;
begin
   Result := FGraphicMenu.AlphaBlend;
end;

procedure TbsSkinGraphicButton.SetMenuAlphaBlend(Value: Boolean);
begin
  FGraphicMenu.AlphaBlend := Value;
end;

function TbsSkinGraphicButton.GetMenuAlphaBlendAnimation: Boolean;
begin
  Result := FGraphicMenu.AlphaBlendAnimation;
end;

procedure TbsSkinGraphicButton.SetMenuAlphaBlendAnimation(Value: Boolean);
begin
  FGraphicMenu.AlphaBlendAnimation := Value;
end;

function TbsSkinGraphicButton.GetMenuAlphaBlendValue: Integer;
begin
  Result := FGraphicMenu.AlphaBlendValue;
end;

procedure TbsSkinGraphicButton.SetMenuAlphaBlendValue(Value: Integer);
begin
  FGraphicMenu.AlphaBlendValue := Value;
end;

procedure TbsSkinGradientStyleButton.InitImages;
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.LoadFromResourceName(HInstance, 'BS_GRAD_HORZ_IN');
  FGraphicImages.Width := B.Width;
  FGraphicImages.Height := B.Height;
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_GRAD_HORZ_OUT');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_GRAD_HORZ_INOUT');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_GRAD_VERT_IN');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_GRAD_VERT_OUT');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_GRAD_VERT_INOUT');
  FGraphicImages.Add(B, nil);
  B.Free;
end;

procedure TbsSkinGradientStyleButton.InitItems;
var
 Item: TbsImagesMenuItem;
begin
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 0;
    Hint := 'HorizotalIn';
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 1;
    Hint := 'HorizotalOut';
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 2;
    Hint := 'HorizotalInOut';
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 3;
    Hint := 'VerticalIn';
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 4;
    Hint := 'VerticalOut';
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 5;
    Hint := 'VerticalInOut';
  end;
  FGraphicMenu.ColumnsCount := 2;
  FGraphicMenu.ItemIndex := 0;
end;


procedure TbsSkinBrushStyleButton.InitImages;
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_CLEAR');
  FGraphicImages.Width := B.Width;
  FGraphicImages.Height := B.Height;
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_SOLID');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_CROSS');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_DCROSS');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_FD');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_BD');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_H');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_BRUSH_V');
  FGraphicImages.Add(B, nil);
  B.Free;
end;

procedure TbsSkinBrushStyleButton.InitItems;
var
 Item: TbsImagesMenuItem;
begin
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 0;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 1;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 2;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 3;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 4;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 5;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 6;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 7;
  end;
  FGraphicMenu.ColumnsCount := 2;
  FGraphicMenu.ItemIndex := 0;
end;


procedure TbsSkinPenStyleButton.InitImages;
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.LoadFromResourceName(HInstance, 'BS_PEN_SOLID');
  FGraphicImages.Width := B.Width;
  FGraphicImages.Height := B.Height;
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN_DASH');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN_DASHDOT');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN_DOT');
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN_DASHDOTDOT');
  FGraphicImages.Add(B, nil);
  B.Free;
end;

procedure TbsSkinPenStyleButton.InitItems;
var
 Item: TbsImagesMenuItem;
begin
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 0;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 1;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 2;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 3;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 4;
  end;
  FGraphicMenu.ColumnsCount := 1;
  FGraphicMenu.ItemIndex := 0;
end;


procedure TbsSkinPenWidthButton.InitImages;
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.LoadFromResourceName(HInstance, 'BS_PEN1');
  FGraphicImages.Width := B.Width;
  FGraphicImages.Height := B.Height;
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN2');
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN3');
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN4');
  FGraphicImages.Add(B, nil);
  FGraphicImages.Add(B, nil);
  B.LoadFromResourceName(HInstance, 'BS_PEN6');
  FGraphicImages.Add(B, nil);
  B.Free;
end;

procedure TbsSkinPenWidthButton.InitItems;
var
 Item: TbsImagesMenuItem;
begin
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 0;
    Button := True;
    Caption := '1/4 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 1;
    Button := True;
    Caption := '1/2 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 2;
    Button := True;
    Caption := '3/4 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 3;
    Button := True;
    Caption := '1 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 4;
    Button := True;
    Caption := '1 1/4 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 5;
    Button := True;
    Caption := '1 1/2 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 6;
    Button := True;
    Caption := '1 3/4 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 7;
    Button := True;
    Caption := '2 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 8;
    Button := True;
    Caption := '2 1/2 pt'
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 9;
    Button := True;
    Caption := '3 pt'
  end;
    Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 10;
    Button := True;
    Caption := '4 pt'
  end;
    Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    ImageIndex := 11;
    Button := True;
    Caption := '6 pt'
  end;
  FGraphicMenu.ColumnsCount := 2;
  FGraphicMenu.ItemIndex := 0;
end;

procedure TbsSkinShadowStyleButton.InitImages;
var
  B: TBitMap;
begin
  FGraphicImages.Width := 20;
  FGraphicImages.Height := 20;
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW1', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW2', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW3', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW4', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW5', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW6', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW7', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW8', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW9', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW10', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW11', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW12', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW13', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW14', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW15', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW16', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW17', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW18', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW19', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW20', clWhite);
  FGraphicImages.ResInstLoad(HInstance, rtBitmap, 'BS_SHADOW21', clWhite);
end;

procedure TbsSkinShadowStyleButton.InitItems;
var
 Item: TbsImagesMenuItem;
 i: Integer;
begin
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    Button := True;
    Caption := 'No shadow';
  end;
  for i := 0 to 19 do
  begin
    Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
    Item.ImageIndex := i;
  end;
  Item := TbsImagesMenuItem(FGraphicMenu.ImagesItems.Add);
  with Item do
  begin
    Button := True;
    Caption := 'More settings';
    ImageIndex := 20;
  end;
  FGraphicMenu.ColumnsCount := 4;
  FGraphicMenu.ItemIndex := 0;
end;


// TbsSkinOfficeGallery ========================================================

procedure TbsSkinGalleryButton.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    begin
      MaskPicture := nil; 
      GlowLayerPictureIndex := -1;
      Morphing := False;
    end;
end;

procedure TbsSkinGalleryButton.CreateControlDefaultImage(B: TBitMap);
begin
  inherited;
  DrawDownArrowImage(B.Canvas, Rect(0, 0, Width, Height), B.Canvas.Font.Color);
end;

procedure TbsSkinGalleryButton.CreateControlSkinImage(B: TBitMap);
begin
  inherited;
end;

procedure  TbsSkinGalleryButton.CreateButtonImage(B: TBitMap; R: TRect;
      ADown, AMouseIn: Boolean);
begin
  inherited;
  DrawDownArrowImage(B.Canvas, Rect(0, 0, Width, Height), B.Canvas.Font.Color);
end;

constructor TbsSkinOfficeGalleryItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImageIndex := -1;
  FCaption := '';
  MouseIn := False;
  PopupMouseIn := False;
  if TbsSkinOfficeGalleryItems(Collection).OfficeGallery.ItemIndex = Self.Index
  then
    begin
      Active := True;
      PopupActive := True;
    end
  else
    begin
      Active := False;
      PopupActive := False;
    end;
end;

procedure TbsSkinOfficeGalleryItem.Assign(Source: TPersistent);
begin
  if Source is TbsSkinOfficeGalleryItem then
  begin
    FImageIndex := TbsSkinOfficeGalleryItem(Source).ImageIndex;
    FCaption := TbsSkinOfficeGalleryItem(Source).Caption;
  end
  else
    inherited Assign(Source);
end;

procedure TbsSkinOfficeGalleryItem.SetImageIndex(const Value: TImageIndex);
begin
  FImageIndex := Value;
  Changed(False);
end;

procedure TbsSkinOfficeGalleryItem.SetCaption(const Value: String);
begin
  FCaption := Value;
  Changed(False);
end;

procedure TbsSkinOfficeGalleryItem.SetEnabled(Value: Boolean);
begin
  Changed(False);
end;

procedure TbsSkinOfficeGalleryItem.SetData(const Value: Pointer);
begin
  FData := Value;
end;

constructor TbsSkinOfficeGalleryItems.Create;
begin
  inherited Create(TbsSkinOfficeGalleryItem);
  OfficeGallery := AOfficeGallery;
end;

function TbsSkinOfficeGalleryItems.GetOwner: TPersistent;
begin
  Result := OfficeGallery;
end;

procedure  TbsSkinOfficeGalleryItems.Update(Item: TCollectionItem);
begin
  OfficeGallery.Repaint;
  OfficeGallery.UpdateScrollInfo;
end; 

function TbsSkinOfficeGalleryItems.GetItem(Index: Integer):  TbsSkinOfficeGalleryItem;
begin
  Result := TbsSkinOfficeGalleryItem(inherited GetItem(Index));
end;

procedure TbsSkinOfficeGalleryItems.SetItem(Index: Integer; Value:  TbsSkinOfficeGalleryItem);
begin
  inherited SetItem(Index, Value);
  OfficeGallery.RePaint;
end;

function TbsSkinOfficeGalleryItems.Add: TbsSkinOfficeGalleryItem;
begin
  Result := TbsSkinOfficeGalleryItem(inherited Add);
  OfficeGallery.RePaint;
end;

function TbsSkinOfficeGalleryItems.Insert(Index: Integer): TbsSkinOfficeGalleryItem;
begin
  Result := TbsSkinOfficeGalleryItem(inherited Insert(Index));
  OfficeGallery.RePaint;
end;

procedure TbsSkinOfficeGalleryItems.Delete(Index: Integer);
begin
  inherited Delete(Index);
  OfficeGallery.RePaint;
end;

procedure TbsSkinOfficeGalleryItems.Clear;
begin
  inherited Clear;
  OfficeGallery.RePaint;
end;

constructor TbsSkinOfficeGallery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csAcceptsControls];
  FPopupGallery := TbsSkinPopupOfficeGallery.Create(Self);
  FPopupGallery.Visible := False;
  if not (csDesigning in ComponentState)
  then
    FPopupGallery.Parent := Self;
  ItemsInPage := 0;
  FPopupMaxRowCount := 3;
  FMouseInItem := -1;
  FOldMouseInItem := -1;
  FStartIndex := 0;
  FItemMargin := -1;
  FItemSpacing := 1;
  FItemLayout := blGlyphTop;
  FClicksDisabled := False;
  FMouseDown := False;
  FMouseActive := -1;
  UpDown := nil;
  DownButton := nil;
  FItems := TbsSkinOfficeGalleryItems.Create(Self);
  FImages := nil;
  Width := 250;
  Height := 100;
  FItemWidth := 45;
  FItemHeight := 45;
  FSkinDataName := 'listbox';
  FOldWidth := -1;
  FItemIndex := -1;
  ShowUpDown;
end;

destructor TbsSkinOfficeGallery.Destroy;
begin
  FItems.Free;
  HideUpdown;
  FPopupGallery.Free;
  inherited Destroy;
end;

procedure TbsSkinOfficeGallery.BeginUpdateItems;
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
end;

procedure TbsSkinOfficeGallery.EndUpdateItems;
begin
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  CalcItemRects;
  RePaint;
end;

procedure TbsSkinOfficeGallery.CMCancelMode;
begin
  inherited;
  if FPopupGallery.Visible
  then
    if (Message.Sender = nil) or (
       (Message.Sender <> Self) and
       (Message.Sender <> Self.FPopupGallery) and
       (Message.Sender <> Self.FPopupGallery.ScrollBar))
    then
      HidePopupGallery;
end;

procedure TbsSkinOfficeGallery.ShowPopupGallery;
var
  P: TPoint;
  RCount: Integer;
begin
  P.X := 0;
  P.Y := 0;
  P := ClientToScreen(P);
  FPopupGallery.FScrollOffset := 0;
  FPopupGallery.FSkinDataName := Self.SkinDataName;
  FPopupGallery.SkinData := SkinData;
  FPopupGallery.Width := Self.Width - 15 + FPopupGallery.ScrollBar.Width;
  RCount := Items.Count div ColCount;
  if RCount > FPopupMaxRowCount then RCount := FPopupMaxRowCount;
  FPopupGallery.Height := RCount * ItemHeight + Height - RectHeight(FItemsRect);
  if FPopupGallery.Height < Height then FPopupGallery.Height := Height;
  FPopupGallery.CalcItemRects;
  FPopupGallery.ItemIndex := ItemIndex;
  FPopupGallery.Show(P);
end;

procedure TbsSkinOfficeGallery.HidePopupGallery;
begin
  FPopupGallery.Hide;
end;

procedure TbsSkinOfficeGallery.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  TestActive(-1);
end;

procedure TbsSkinOfficeGallery.CMMouseEnter(var Message: TMessage);
begin
  inherited;
end;

procedure TbsSkinOfficeGallery.OnUpButtonClick(Sender: TObject);
var
  I: Integer;
begin
  CalcItemRects;
  if not Focused then SetFocus;
  I := FStartIndex - ItemsInPage;
  if I < 0 then I := 0;
  if I <> FStartIndex
  then
    begin
      FStartIndex := I;
      CalcItemRects;
      RePaint;
    end;
end;

procedure TbsSkinOfficeGallery.OnDownButtonClick(Sender: TObject);
var
  I: Integer;
begin
  CalcItemRects;
  if not Focused then SetFocus;
  if FStartIndex + ItemsInPage - 1 >= FItems.Count - 1 then Exit;
  I := FStartIndex + ItemsInPage;
  if I > FItems.Count - 1 then I := FItems.Count - 1;
  if I <> FStartIndex
  then
    begin
      FStartIndex := I;
      CalcItemRects;
      RePaint;
    end;
end;

procedure TbsSkinOfficeGallery.OnButtonClick(Sender: TObject);
begin
  if not Focused then SetFocus;
  ShowPopupGallery;
end;

procedure TbsSkinOfficeGallery.SetItemLayout(Value: TbsButtonLayout);
begin
  FItemLayout := Value;
  Invalidate;
end;

procedure TbsSkinOfficeGallery.SetItemMargin(Value: Integer);
begin
  FItemMargin := Value;
  Invalidate;
end;


procedure TbsSkinOfficeGallery.SetItemSpacing(Value: Integer);
begin
  FItemSpacing := Value;
  Invalidate;
end;

procedure TbsSkinOfficeGallery.ChangeSkinData;
begin
  inherited;
  if UpDown <> nil
  then
    begin
      UpDown.SkinData := SkinData;
      if DownButton <> nil then DownButton.SkinData := SkinData;
      AdjustButtons;
    end;
  CalcItemRects;
  RePaint;
end;

procedure TbsSkinOfficeGallery.SetItemWidth(Value: Integer);
begin
  if FItemWidth <> Value
  then
    begin
      FItemWidth := Value;
      RePaint;
    end;
end;

procedure TbsSkinOfficeGallery.SetItemHeight(Value: Integer);
begin
  if FItemHeight <> Value
  then
    begin
      FItemHeight := Value;
      RePaint;
    end;
end;

procedure TbsSkinOfficeGallery.SetItems(Value: TbsSkinOfficeGalleryItems);
begin
  FItems.Assign(Value);
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinOfficeGallery.SetImages(Value: TCustomImageList);
begin
  FImages := Value;
end;

procedure TbsSkinOfficeGallery.Notification(AComponent: TComponent;
            Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then
   FImages := nil;
end;

procedure TbsSkinOfficeGallery.DrawItem;
var
  Buffer: TBitMap;
  R: TRect;
begin
  if FIndex <> -1
  then
    SkinDrawItem(Index, Cnvs)
  else
    DefaultDrawItem(Index, Cnvs);
end;

procedure TbsSkinOfficeGallery.CreateControlDefaultImage(B: TBitMap);
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

procedure TbsSkinOfficeGallery.CreateControlSkinImage(B: TBitMap);
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

procedure TbsSkinOfficeGallery.CalcItemRects;
var
  I, J, K: Integer;
  X, Y, W, H: Integer;
begin
  if FItems.Count = 0
  then
    begin
      ItemsInPage := 0;
      RowCount := 1;
      ColCount := 1;
      UpDown.Enabled := False;
      DownButton.Enabled := UpDown.Enabled;
      if FIndex <> -1
      then
        FItemsRect := RealClientRect
      else
        FItemsRect := Rect(2, 2, Width - 2, Height - 2);
      Dec(FItemsRect.Right, 15);
      Exit;
    end;
  //    
  if FIndex <> -1
  then
    FItemsRect := RealClientRect
  else
    FItemsRect := Rect(2, 2, Width - 2, Height - 2);
  Dec(FItemsRect.Right, 15);
  //
  RowCount := RectHeight(FItemsRect) div FItemHeight;
  ColCount := RectWidth(FItemsRect) div FItemWidth;
  if RowCount = 0 then RowCount := 1;
  if ColCount = 0 then ColCount := 1;
  ItemsInPage := RowCount * ColCount;
  //
  for I := 0 to FItems.Count - 1 do
    TbsSkinOfficeGalleryItem(FItems[I]).IsVisible := (I >= FStartIndex)
     and (I <= FStartIndex + ItemsInPage - 1);
  //
  Y := FItemsRect.Top;
  k := FStartIndex;
  for I := 1 to RowCount do
  begin
    X := FItemsRect.Left;
    for J := 1 to ColCount do
    begin
      if k < FItems.Count then
      begin
        FItems[k].ItemRect := Rect(X, Y, X + FItemWidth, Y + FItemHeight);
        X := X + FItemWidth;
      end;
      Inc(k);
    end;
    Y := Y + FItemHeight;
  end;
  UpDown.Enabled := FItems.Count > ItemsInPage;
  DownButton.Enabled := UpDown.Enabled;
end;

procedure TbsSkinOfficeGallery.Scroll(AScrollOffset: Integer);
begin
end;

procedure TbsSkinOfficeGallery.GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
begin
end;

procedure TbsSkinOfficeGallery.WMSize(var Msg: TWMSize);
var
  OldItemsInPage: Integer;
  I: Integer;
begin
  inherited;
  OldItemsInPage := ItemsInPage;
  CalcItemRects;
  if (OldItemsInPage < ItemsInPage) and (FItems.Count <> 0)
  then
    begin
      I := FStartIndex - (ItemsInPage - OldItemsInPage);
      if I < 0 then I := 0;
      if I > FItems.Count - 1 then I := FItems.Count - 1;
      FStartIndex := I;
      CalcItemRects;
      RePaint;
    end;
  AdjustButtons;
end;

procedure TbsSkinOfficeGallery.ScrollToItem(Index: Integer);
var
  I: Integer;
begin
  if FItems.Count = 0 then Exit;
  if ItemsInPage = 0 then Exit;
  if Index = -1 then Exit;
  if Index < FStartIndex
  then
    begin
      I := FStartIndex;
      repeat
        I := I - ItemsInPage;
      until (I <= 0) or ((Index >= I) and (Index <= I + ItemsInPage - 1));
      if I >= 0
      then
        begin
         FStartIndex := I;
         CalcItemRects;
         RePaint;
       end;
    end
  else
  if Index > FStartIndex + ItemsInPage  - 1
  then
    begin
      I := FStartIndex;
      repeat
        I := I + ItemsInPage;
      until (I >= FItems.Count) or ((Index >= I) and (Index <= I + ItemsInPage - 1));
      if I <= FItems.Count - 1
      then
        begin
          FStartIndex := I;
          CalcItemRects;
          RePaint;
       end;
    end;
end;

procedure TbsSkinOfficeGallery.ShowUpDown;
begin
  if UpDown = nil
  then
    begin
      UpDown := TbsSkinUpDown.Create(Self);
      UpDown.Visible := False;
      UpDown.Parent := Self;
      UpDown.DefaultHeight := 0;
      UpDown.DefaultWidth := 15;
      UpDown.Orientation := udVertical;
      UpDown.OnUpButtonClick := OnUpButtonClick;
      UpDown.OnDownButtonClick := OnDownButtonClick;
      UpDown.UseSkinSize := False;
      AdjustButtons;
      UpDown.Visible := True;
    end;
  if DownButton = nil
  then
    begin
      DownButton := TbsSkinGalleryButton.Create(Self);
      DownButton.Visible := False;
      DownButton.Parent := Self;
      DownButton.CanFocused := False;
      DownButton.SkinDataName := 'resizebutton';
      DownButton.DefaultWidth := 15;
      DownButton.Caption := '';
      DownButton.OnClick := OnButtonClick;
      AdjustButtons;
      DownButton.Visible := True;
    end;

end;

procedure TbsSkinOfficeGallery.HideUpDown;
begin
  DownButton.Free;
  UpDown.Free;
  UpDown := nil;
  DownButton := nil;
end;

procedure TbsSkinOfficeGallery.UpdateScrollInfo;
begin
end;

procedure TbsSkinOfficeGallery.AdjustButtons;
var
  R: TRect;
begin                     
  if UpDown = nil then Exit;
  if FIndex = -1
  then
    R := Rect(2, 2, Width - 2, Height - 2)
  else
    R := RealClientRect;
  Dec(R.Bottom, 20);
  R.Left := R.Right - UpDown.Width;
  UpDown.SetBounds(R.Left, R.Top, RectWidth(R), RectHeight(R));
  if DownButton <> nil
  then
    DownButton.SetBounds(UpDown.Left, UpDown.Top + UpDown.Height,
     UpDown.Width, 20);
end;

procedure TbsSkinOfficeGallery.SkinDrawItem(Index: Integer; Cnvs: TCanvas);
var
  ListBoxData: TbsDataSkinListBox;
  CIndex, TX, TY: Integer;
  R, R1: TRect;
  Buffer: TBitMap;
  C: TColor;
  SaveIndex: Integer;
  B: TbsBitmap;
begin
  CIndex := SkinData.GetControlIndex('listbox');
  if CIndex = -1 then Exit;
  R := FItems[Index].ItemRect;
  InflateRect(R, -2, -2);
  ListBoxData := TbsDataSkinListBox(SkinData.CtrlList[CIndex]);
  Cnvs.Brush.Style := bsClear;
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

  if (FSkinDataName = 'listbox') or
     (FSkinDataName = 'memo') or
     (FSkinDataName = 'menupagepanel')
  then
    Cnvs.Font.Color := ListBoxData.FontColor
  else
    Cnvs.Font.Color := FSD.SkinColors.cBtnText;

  with Cnvs.Font do
  begin
    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Charset := SkinData.ResourceStrData.CharSet
    else
      CharSet := FDefaultFont.Charset;
  end;
  //
  if not FItems[Index].Active and not (FItems[Index].MouseIn)
  then
    with FItems[Index] do
    begin
      SaveIndex := SaveDC(Cnvs.Handle);
      IntersectClipRect(Cnvs.Handle, FItems[Index].ItemRect.Left, FItems[Index].ItemRect.Top,
        FItems[Index].ItemRect.Right, FItems[Index].ItemRect.Bottom);
      //
     if Assigned(FOnDrawItem)
      then
        begin
          Cnvs.Brush.Style := bsClear;
          FOnDrawItem(Cnvs, Index, R);
        end
      else
        DrawImageAndText(Cnvs, R, FItemMargin, FItemSpacing, FItemLayout,
          Caption, FImageIndex, FImages,
          False, Enabled, False, 0);
      //
      RestoreDC(Cnvs.Handle, SaveIndex);
    end
  else  
  if (FItems[Index].MouseIn) and not  FItems[Index].Active
  then
    begin
      with FItems[Index] do
      begin
        Buffer := TBitMap.Create;
        R := FItems[Index].ItemRect;
        Buffer.Width := RectWidth(R);
        Buffer.Height := RectHeight(R);
        with ListBoxData do
        if Focused
        then
          CreateStretchImage(Buffer, Picture, FocusItemRect, ItemTextRect, True)
        else
          CreateStretchImage(Buffer, Picture, ActiveItemRect, ItemTextRect, True);
        B := TbsBitMap.Create;
        B.Assign(Buffer);
        B.AlphaBlend := True;
        B.SetAlpha(150);
        B.Draw(Cnvs, FItems[Index].ItemRect.Left, FItems[Index].ItemRect.Top);
        B.Free;
        Buffer.Free;
        //
        SaveIndex := SaveDC(Cnvs.Handle);
        IntersectClipRect(Cnvs.Handle, FItems[Index].ItemRect.Left, FItems[Index].ItemRect.Top,
          FItems[Index].ItemRect.Right, FItems[Index].ItemRect.Bottom);
        //
        if Assigned(FOnDrawItem)
        then
          begin
            Cnvs.Brush.Style := bsClear;
            FOnDrawItem(Cnvs, Index, R);
          end
        else
          DrawImageAndText(Cnvs, R, FItemMargin, FItemSpacing, FItemLayout,
            Caption, FImageIndex, FImages,
            False, Enabled, False, 0);
       //
       RestoreDC(Cnvs.Handle, SaveIndex);
      end;
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

       //
       if Assigned(FOnDrawItem)
      then
        begin
          Buffer.Canvas.Brush.Style := bsClear;
          FOnDrawItem(Buffer.Canvas, Index, R);
        end
      else
        DrawImageAndText(Buffer.Canvas, R, FItemMargin, FItemSpacing, FItemLayout,
          Caption, FImageIndex, FImages,
          False, Enabled, False, 0);
       //
       Cnvs.Draw(FItems[Index].ItemRect.Left,
         FItems[Index].ItemRect.Top, Buffer);
      Buffer.Free;
    end;
end;

procedure TbsSkinOfficeGallery.DefaultDrawItem(Index: Integer; Cnvs: TCanvas);
var
  R, R1: TRect;
  C, FC: TColor;
  TX, TY: Integer;
  SaveIndex: Integer;
begin
  if (FItems[Index].Active) 
  then
    begin
      C := clHighLight;
      FC := clHighLightText;
     end
  else
    begin
      C := clWindow;
      FC := clWindowText
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
  if Assigned(FOnDrawItem)
  then
    begin
      Cnvs.Brush.Style := bsClear;
      FOnDrawItem(Cnvs, Index, R);
    end
  else
  with FItems[Index] do
  begin
    DrawImageAndText(Cnvs, R, FItemMargin, FItemSpacing, FItemLayout,
      Caption, FImageIndex, FImages,
        False, Enabled, False, 0);
  end;
  if FItems[Index].Active and Focused
  then
    Cnvs.DrawFocusRect(FItems[Index].ItemRect);
  RestoreDC(Cnvs.Handle, SaveIndex);
end;

procedure TbsSkinOfficeGallery.SetItemIndex(Value: Integer);
var
  I: Integer;
  IsFind: Boolean;
begin
  if Value < 0
  then
    begin
      FItemIndex := Value;
      RePaint;
    end
  else
    begin
      FItemIndex := Value;
      IsFind := False;
      for I := 0 to FItems.Count - 1 do
        with FItems[I] do
        begin
          if I = FItemIndex
          then
            begin
              Active := True;
              IsFind := True;
            end
          else
             Active := False;
        end;
      RePaint;
      ScrollToItem(FItemIndex);
      if IsFind and not (csDesigning in ComponentState) and not (csLoading in ComponentState)
      then
      begin
        if Assigned(FItems[FItemIndex].OnClick) then
          FItems[FItemIndex].OnClick(Self);
        if Assigned(FOnItemClick) then
          FOnItemClick(Self);
      end;    
    end;
end;

procedure TbsSkinOfficeGallery.Loaded;
begin
  inherited;
  if FItemIndex <> -1 then ScrollToItem(FItemIndex);
end;

function TbsSkinOfficeGallery.ItemAtPos(X, Y: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count - 1 do
    if PtInRect(FItems[I].ItemRect, Point(X, Y)) and (FItems[I].IsVisible)
    then
      begin
        Result := I;
        Break;
      end;  
end;


procedure TbsSkinOfficeGallery.MouseDown(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  I := ItemAtPos(X, Y);
  if (I <> -1) and (Button = mbLeft)
  then
    begin
      SetItemActive(I);
      FMouseDown := True;
      FMouseActive := I;
    end;
end;

procedure TbsSkinOfficeGallery.MouseUp(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  FMouseDown := False;
  I := ItemAtPos(X, Y);
  if (I <> -1) and  (Button = mbLeft) then ItemIndex := I;
end;

procedure TbsSkinOfficeGallery.TestActive(MouseInIndex: Integer);
begin
  if (MouseInIndex = -1) and (FOldMouseInItem <> -1)
  then
    begin
      FItems[FOldMouseInItem].MouseIn := False;
      FOldMouseInItem := -1;
      FMouseInItem := -1;
      RePaint;
    end
  else
  if (MouseInIndex <> -1) and (MouseInIndex <> FMouseInItem)
  then
    begin
      FMouseInItem := MouseInIndex;
      if FOldMouseInItem <> - 1 then FItems[FOldMouseInItem].MouseIn := False;
      FItems[FMouseInItem].MouseIn := True;
      FOldMouseInItem := FMouseInItem;
      RePaint;
    end;
end;

procedure TbsSkinOfficeGallery.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  I := ItemAtPos(X, Y);
  TestActive(I);
  if (I <> -1) and FMouseDown and (I <> FMouseActive)
  then
    begin
      SetItemActive(I);
      FMouseActive := I;
    end;
end;

procedure TbsSkinOfficeGallery.SetItemActive(Value: Integer);
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

procedure TbsSkinOfficeGallery.WMMOUSEWHEEL(var Message: TMessage);
begin
  inherited;
  if FPopupGallery.Visible
  then
    begin
      SendMessage(FPopupGallery.Handle, WM_MOUSEWHEEL, Message.WParam, Message.LParam)
    end
  else
    if Message.WParam > 0
    then OnUpButtonClick(Self)
    else OnDownButtonClick(Self);
end;

procedure TbsSkinOfficeGallery.WMSETFOCUS(var Message: TWMSETFOCUS);
begin
  inherited;
  RePaint;
end;

procedure TbsSkinOfficeGallery.WMKILLFOCUS(var Message: TWMKILLFOCUS);
begin
  inherited;
  if FPopupGallery.Visible then HidePopupGallery;
  RePaint;
end;

procedure TbsSkinOfficeGallery.WndProc(var Message: TMessage);
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

procedure TbsSkinOfficeGallery.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
end;

procedure TbsSkinOfficeGallery.FindLeft;
var
  I: Integer;
begin
  if ItemIndex <= -1 then Exit;
  I := FItemIndex - 1;
  if (ItemIndex < FStartIndex) or (ItemIndex > FStartIndex + ItemsInPage - 1)
  then
    begin
      I := FStartIndex + ItemsInPage - 1;
      if I > FItems.Count - 1 then I := FItems.Count - 1;
    end;
  if I >= 0 then ItemIndex := I;
end;

procedure TbsSkinOfficeGallery.FindRight;
var
  I, Start: Integer;
begin
  if ItemIndex <= -1 then I := 0 else I := FItemIndex + 1;
  if (ItemIndex < FStartIndex) or (ItemIndex > FStartIndex + ItemsInPage - 1) then I := FStartIndex;
  if I <= FItems.Count - 1 then ItemIndex := I;
end;

procedure TbsSkinOfficeGallery.FindDown;
var
  i: Integer;
begin
  i := ItemIndex;
  i := ItemIndex + ColCount;
  if (ItemIndex < FStartIndex) or (ItemIndex > FStartIndex + ItemsInPage - 1) then I := FStartIndex;
  if i > FItems.Count - 1 then i := FItems.Count - 1;
  if i <> ItemIndex then ItemIndex := i;
end;

procedure TbsSkinOfficeGallery.FindUp;
var
  i: Integer;
begin
  i := ItemIndex;
  i := ItemIndex - ColCount;
  if (ItemIndex < FStartIndex) or (ItemIndex > FStartIndex + ItemsInPage - 1)
  then
    begin
      I := FStartIndex + ItemsInPage - 1;
      if I > FItems.Count - 1 then I := FItems.Count - 1;
    end;  
  if i < 0 then i := 0;
  if i <> ItemIndex then ItemIndex := i;
end;

procedure TbsSkinOfficeGallery.KeyDown(var Key: Word; Shift: TShiftState);
begin
 inherited KeyDown(Key, Shift);
 if FPopupGallery.Visible
 then
   begin
     FPopupGallery.KeyDown(Key, Shift);
   end
  else
    case Key of
      VK_NEXT: OnDownButtonClick(Self);
      VK_PRIOR: OnUpButtonClick(Self);
      VK_UP: FindUp;
      VK_LEFT: FindLeft;
      VK_DOWN: if (ssAlt in Shift) then ShowPopupGallery else FindDown;
      VK_RIGHT: if (ssAlt in Shift) then ShowPopupGallery else FindRight;
    end;
end;

// TbsSkinPopupOfficeGallery ===================================================

constructor TbsSkinPopupOfficeGallery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable,
    csAcceptsControls];
  Visible := False;
  FInUpdateItems := False;
  FScrollOffset := 0;
  FGallery := TbsSkinOfficeGallery(AOwner);
  FMouseInItem := -1;
  FOldMouseInItem := -1;
  FStartIndex := 0;
  FMouseDown := False;
  FMouseActive := -1;
  ScrollBar := nil;
  Width := 250;
  Height := 100;
  FSkinDataName := 'listbox';
  FMax := 0;
  FRealMax := 0;
  FOldWidth := -1;
  FItemIndex := -1;
  ShowScrollBar;
end;

destructor TbsSkinPopupOfficeGallery.Destroy;
begin
  HideScrollBar;
  inherited Destroy;
end;

procedure TbsSkinPopupOfficeGallery.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := WS_POPUP or WS_CLIPCHILDREN;
    ExStyle := WS_EX_TOOLWINDOW;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    if CheckWXP then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW_;
  end;
end;

procedure TbsSkinPopupOfficeGallery.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TbsSkinPopupOfficeGallery.Hide;
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  Visible := False;
end;

procedure TbsSkinPopupOfficeGallery.Show(Origin: TPoint);
begin
  SetWindowPos(Handle, HWND_TOP, Origin.X, Origin.Y, 0, 0,
    SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE);
  UpdateScrollInfo;
  Visible := True;
end;

function TbsSkinPopupOfficeGallery.GetItems;
begin
  Result := FGallery.Items;
end;

procedure TbsSkinPopupOfficeGallery.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  TestActive(-1);
end;

procedure TbsSkinPopupOfficeGallery.CMMouseEnter(var Message: TMessage);
begin
  inherited;
end;

procedure TbsSkinPopupOfficeGallery.OnSBChange(Sender: TObject);
begin
  Scroll(ScrollBar.Position);
end;

procedure TbsSkinPopupOfficeGallery.ChangeSkinData;
var
  CIndex: Integer;
begin
  inherited;
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

procedure TbsSkinPopupOfficeGallery.DrawItem;
var
  Buffer: TBitMap;
  R: TRect;
begin
  if FIndex <> -1
  then
    SkinDrawItem(Index, Cnvs)
  else
    DefaultDrawItem(Index, Cnvs);
end;

procedure TbsSkinPopupOfficeGallery.CreateControlDefaultImage(B: TBitMap);
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
  for I := 0 to Items.Count - 1 do
   if Items[I].PopupIsVisible then DrawItem(I, B.Canvas);
  RestoreDC(B.Canvas.Handle, SaveIndex);
end;

procedure TbsSkinPopupOfficeGallery.CreateControlSkinImage(B: TBitMap);
var
  I, SaveIndex: Integer;
begin
  inherited;
  CalcItemRects;
  SaveIndex := SaveDC(B.Canvas.Handle);
  IntersectClipRect(B.Canvas.Handle,
    FItemsRect.Left, FItemsRect.Top, FItemsRect.Right, FItemsRect.Bottom);
  for I := 0 to Items.Count - 1 do
   if Items[I].PopupIsVisible then DrawItem(I, B.Canvas);
  RestoreDC(B.Canvas.Handle, SaveIndex);
end;

procedure TbsSkinPopupOfficeGallery.CalcItemRects;
var
  I, J, Col: Integer;
  X, Y, W, H: Integer;
begin
  if FIndex <> -1
  then
    FItemsRect := RealClientRect
  else
    FItemsRect := Rect(2, 2, Width - 2, Height - 2);
  if ScrollBar.Visible then Dec(FItemsRect.Right, ScrollBar.Width);
  //
  RowCount := RectHeight(FItemsRect) div FGallery.ItemHeight;
  ColCount := RectWidth(FItemsRect) div FGallery.ItemWidth;
  if (Items.Count div ColCount) = (Items.Count / ColCount)
  then
    RowCount := Items.Count div ColCount;
  //  
  if RowCount = 0 then RowCount := 1;
  if ColCount = 0 then ColCount := 1;
  ItemsInPage := RowCount * ColCount;
  //
  FRealMax := 0;
  Y := FItemsRect.Top;
  X := FItemsRect.Left;
  Col := 0;
  for i := 0 to Items.Count - 1 do
  begin
    if Col = ColCount
    then
      begin
        X := FItemsRect.Left;
        Y := Y + FGallery.ItemHeight;
        Col := 0;
      end;
    //
    Items[i].PopupItemRect := Rect(X, Y, X + FGallery.ItemWidth, Y + FGallery.ItemHeight);
    //
    OffsetRect(Items[i].PopupItemRect, 0, - FScrollOffset);
    Items[i].PopupIsVisible := RectToRect(Items[i].PopupItemRect, FItemsRect);
    if not Items[i].PopupIsVisible and (Items[i].PopupItemRect.Top <= FItemsRect.Top) and
       (Items[i].PopupItemRect.Bottom >= FItemsRect.Bottom)
    then
      Items[i].PopupIsVisible := True;
    if Items[i].PopupIsVisible then FRealMax := Items[i].PopupItemRect.Bottom;
    //
    X := X + FGallery.ItemWidth;
    Inc(Col);
  end;
  FMax := Y + FGallery.ItemHeight;
end;

procedure TbsSkinPopupOfficeGallery.Scroll(AScrollOffset: Integer);
begin
  FScrollOffset := AScrollOffset;
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinPopupOfficeGallery.GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
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

procedure TbsSkinPopupOfficeGallery.WMSize(var Msg: TWMSize);
begin
  inherited;
  AdjustScrollBar;
  UpdateScrollInfo;
end;

procedure TbsSkinPopupOfficeGallery.ScrollToItem(Index: Integer);
var
  R, R1: TRect;
begin
  CalcItemRects;
  R1 := Items[Index].PopupItemRect;
  R := R1;
  OffsetRect(R, 0, FScrollOffset);
  if (R1.Top <= FItemsRect.Top)
  then
    begin
      if Index = 0
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

procedure TbsSkinPopupOfficeGallery.ShowScrollBar;
begin
  if ScrollBar = nil
  then
    begin
      ScrollBar := TbsSkinScrollBar.Create(Self);
      ScrollBar.Visible := False;
      ScrollBar.Parent := Self;
      ScrollBar.DefaultHeight := 0;
      ScrollBar.DefaultWidth := 17;
      ScrollBar.SkinDataName := 'vscrollbar';
      ScrollBar.Kind := sbVertical;
      ScrollBar.OnChange := OnSBChange;
      AdjustScrollBar;
      ScrollBar.Visible := True;
    end;
end;

procedure TbsSkinPopupOfficeGallery.HideScrollBar;
begin
  ScrollBar.Free;
  ScrollBar := nil;
end;

procedure TbsSkinPopupOfficeGallery.UpdateScrollInfo;
var
  SMin, SMax, SPage, SPos: Integer;
begin
  //
  if not HandleAllocated then Exit;
  //
  if FInUpdateItems then Exit;
  GetScrollInfo(SMin, SMax, SPage, SPos);
  if SMax <> 0
  then
    begin
      if not ScrollBar.Visible then ScrollBar.Visible := True;
      ScrollBar.SetRange(SMin, SMax, SPos, SPage);
      ScrollBar.SmallChange := FGallery.FItemHeight;
      ScrollBar.LargeChange := SPage;
    end
  else
  if (SMax = 0) and (ScrollBar <> nil)
  then
    begin
      if ScrollBar.Visible then ScrollBar.Visible := False;
    end;
end;

procedure TbsSkinPopupOfficeGallery.AdjustScrollBar;
var
  R: TRect;
begin                     
  if ScrollBar = nil then Exit;
  if FIndex = -1
  then
    R := Rect(2, 2, Width - 2, Height - 2)
  else
    R := RealClientRect;
  R.Left := R.Right - ScrollBar.Width;
  ScrollBar.SetBounds(R.Left, R.Top, RectWidth(R), RectHeight(R));
end;

procedure TbsSkinPopupOfficeGallery.SkinDrawItem(Index: Integer; Cnvs: TCanvas);
var
  ListBoxData: TbsDataSkinListBox;
  CIndex, TX, TY: Integer;
  R, R1: TRect;
  Buffer: TBitMap;
  C: TColor;
  SaveIndex: Integer;
  B: TbsBitmap;
begin
  CIndex := SkinData.GetControlIndex('listbox');
  if CIndex = -1 then Exit;
  R := Items[Index].PopupItemRect;
  InflateRect(R, -2, -2);
  ListBoxData := TbsDataSkinListBox(SkinData.CtrlList[CIndex]);
  Cnvs.Brush.Style := bsClear;
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

  if (FSkinDataName = 'listbox') or
     (FSkinDataName = 'memo') or
     (FSkinDataName = 'menupagepanel')
  then
    Cnvs.Font.Color := ListBoxData.FontColor
  else
    Cnvs.Font.Color := FSD.SkinColors.cBtnText;

  with Cnvs.Font do
  begin
    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Charset := SkinData.ResourceStrData.CharSet
    else
      CharSet := FDefaultFont.Charset;
  end;
  //
  if not Items[Index].PopupActive and not (Items[Index].PopupMouseIn)
  then
    with Items[Index] do
    begin
      SaveIndex := SaveDC(Cnvs.Handle);
      IntersectClipRect(Cnvs.Handle, Items[Index].PopupItemRect.Left, Items[Index].PopupItemRect.Top,
        Items[Index].PopupItemRect.Right, Items[Index].PopupItemRect.Bottom);
      //
     if Assigned(FGallery.FOnDrawItem)
      then
        begin
          Cnvs.Brush.Style := bsClear;
          FGallery.FOnDrawItem(Cnvs, Index, R);
        end
      else
        DrawImageAndText(Cnvs, R, FGallery.FItemMargin, FGallery.FItemSpacing, FGallery.FItemLayout,
          Caption, FImageIndex, Self.FGallery.FImages,
          False, Enabled, False, 0);
      //
      RestoreDC(Cnvs.Handle, SaveIndex);
    end
  else  
  if (Items[Index].PopupMouseIn) and not Items[Index].PopupActive
  then
    begin
      with Items[Index] do
      begin
        Buffer := TBitMap.Create;
        R := Items[Index].PopupItemRect;
        Buffer.Width := RectWidth(R);
        Buffer.Height := RectHeight(R);
        //
        with ListBoxData do
        if Focused
        then
          CreateStretchImage(Buffer, Picture, FocusItemRect, ItemTextRect, True)
        else
          CreateStretchImage(Buffer, Picture, ActiveItemRect, ItemTextRect, True);
        B := TbsBitMap.Create;
        B.Assign(Buffer);
        B.AlphaBlend := True;
        B.SetAlpha(150);
        B.Draw(Cnvs, Items[Index].PopupItemRect.Left, Items[Index].PopupItemRect.Top);
        B.Free;
        Buffer.Free;
        //
        SaveIndex := SaveDC(Cnvs.Handle);
        IntersectClipRect(Cnvs.Handle, Items[Index].PopupItemRect.Left, Items[Index].PopupItemRect.Top,
          Items[Index].PopupItemRect.Right, Items[Index].PopupItemRect.Bottom);
        //
        if Assigned(FGallery.FOnDrawItem)
        then
          begin
            Cnvs.Brush.Style := bsClear;
            FGallery.FOnDrawItem(Cnvs, Index, R);
          end
        else
          DrawImageAndText(Cnvs, R, FGallery.FItemMargin, FGallery.ItemSpacing, FGallery.FItemLayout,
            Caption, FImageIndex, Self.FGallery.FImages,
            False, Enabled, False, 0);
       //
       RestoreDC(Cnvs.Handle, SaveIndex);
      end;
    end
  else
    with Items[Index] do
    begin
      Buffer := TBitMap.Create;
      R := Items[Index].PopupItemRect;
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

       //
       if Assigned(FGallery.FOnDrawItem)
      then
        begin
          Buffer.Canvas.Brush.Style := bsClear;
          FGallery.FOnDrawItem(Buffer.Canvas, Index, R);
        end
      else
        DrawImageAndText(Buffer.Canvas, R, FGallery.FItemMargin, FGallery.FItemSpacing, FGallery.FItemLayout,
          Caption, FImageIndex, Self.FGallery.FImages,
          False, Enabled, False, 0);
       //
       Cnvs.Draw(Items[Index].PopupItemRect.Left,
         Items[Index].PopupItemRect.Top, Buffer);
      Buffer.Free;
    end;
end;

procedure TbsSkinPopupOfficeGallery.DefaultDrawItem(Index: Integer; Cnvs: TCanvas);
var
  R, R1: TRect;
  C, FC: TColor;
  TX, TY: Integer;
  SaveIndex: Integer;
begin
  if (Items[Index].Active)
  then
    begin
      C := clHighLight;
      FC := clHighLightText;
     end
  else
    begin
      C := clWindow;
      FC := clWindowText
    end;
  //
  Cnvs.Font := FDefaultFont;
  Cnvs.Font.Color := FC;
  //
  R := Items[Index].PopupItemRect;
  SaveIndex := SaveDC(Cnvs.Handle);
  IntersectClipRect(Cnvs.Handle, R.Left, R.Top, R.Right, R.Bottom);
  //
  Cnvs.Brush.Color := C;
  Cnvs.Brush.Style := bsSolid;
  Cnvs.FillRect(R);
  Cnvs.Brush.Style := bsClear;
  //
  InflateRect(R, -2, -2);
  if Assigned(FGallery.FOnDrawItem)
  then
    begin
      Cnvs.Brush.Style := bsClear;
      FGallery.FOnDrawItem(Cnvs, Index, R);
    end
  else
  with Items[Index] do
  begin
    DrawImageAndText(Cnvs, R, FGallery.FItemMargin, FGallery.FItemSpacing, FGallery.FItemLayout,
      Caption, FImageIndex, Self.FGallery.FImages,
        False, Enabled, False, 0);
  end;
  RestoreDC(Cnvs.Handle, SaveIndex);
end;

procedure TbsSkinPopupOfficeGallery.SetItemIndex(Value: Integer);
var
  I: Integer;
  IsFind: Boolean;
begin
  if Value < 0
  then
    begin
      FItemIndex := Value;
      RePaint;
    end
  else
    begin
      FItemIndex := Value;
      IsFind := False;
      for I := 0 to Items.Count - 1 do
        with Items[I] do
        begin
          if I = FItemIndex
          then
            begin
              PopupActive := True;
              IsFind := True;
            end
          else
            PopupActive := False;
        end;
      RePaint;
      ScrollToItem(FItemIndex);
    end;
end;

function TbsSkinPopupOfficeGallery.ItemAtPos(X, Y: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Items.Count - 1 do
    if PtInRect(Items[I].PopupItemRect, Point(X, Y)) and (Items[I].PopupIsVisible)
    then
      begin
        Result := I;
        Break;
      end;  
end;


procedure TbsSkinPopupOfficeGallery.MouseDown(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  I := ItemAtPos(X, Y);
  if (I <> -1) and (Button = mbLeft)
  then
    begin
      SetItemActive(I);
      FMouseDown := True;
      FMouseActive := I;
    end;
end;

procedure TbsSkinPopupOfficeGallery.MouseUp(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  FMouseDown := False;
  I := ItemAtPos(X, Y);
  if (I <> -1) and  (Button = mbLeft)
  then
    begin
      ItemIndex := I;
      Hide;
      if FGallery.ItemIndex <> ItemIndex then FGallery.ItemIndex := ItemIndex;
    end;
end;

procedure TbsSkinPopupOfficeGallery.TestActive(MouseInIndex: Integer);
begin
  if (MouseInIndex = -1) and (FOldMouseInItem <> -1)
  then
    begin
      Items[FOldMouseInItem].PopupMouseIn := False;
      FOldMouseInItem := -1;
      FMouseInItem := -1;
      RePaint;
    end
  else
  if (MouseInIndex <> -1) and (MouseInIndex <> FMouseInItem)
  then
    begin
      FMouseInItem := MouseInIndex;
      if FOldMouseInItem <> - 1 then Items[FOldMouseInItem].PopupMouseIn := False;
      Items[FMouseInItem].PopupMouseIn := True;
      FOldMouseInItem := FMouseInItem;
      RePaint;
    end;
end;

procedure TbsSkinPopupOfficeGallery.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  I := ItemAtPos(X, Y);
  TestActive(I);
  if (I <> -1) and FMouseDown and (I <> FMouseActive)
  then
    begin
      SetItemActive(I);
      FMouseActive := I;
    end;
end;

procedure TbsSkinPopupOfficeGallery.SetItemActive(Value: Integer);
var
  I: Integer;
begin
  FItemIndex := Value;
  for I := 0 to Items.Count - 1 do
  with Items[I] do
   if I = Value then PopupActive := True else PopupActive := False;
  RePaint;
  ScrollToItem(Value);
end;

procedure TbsSkinPopupOfficeGallery.FindPageUp;
begin
  if ScrollBar.Visible
  then
    ScrollBar.Position := ScrollBar.Position - ScrollBar.SmallChange;
end;

procedure TbsSkinPopupOfficeGallery.FindPageDown;
begin
  if ScrollBar.Visible
  then
    ScrollBar.Position := ScrollBar.Position + ScrollBar.SmallChange
end;

procedure TbsSkinPopupOfficeGallery.WMMOUSEWHEEL(var Message: TMessage);
begin
  inherited;
  if ScrollBar.Visible
  then
    begin
      if Message.WParam > 0
      then
        ScrollBar.Position := ScrollBar.Position - ScrollBar.SmallChange
      else
        ScrollBar.Position := ScrollBar.Position + ScrollBar.SmallChange;
    end;
end;

procedure TbsSkinPopupOfficeGallery.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
end;

procedure TbsSkinPopupOfficeGallery.FindLeft;
var
  I: Integer;
begin
  if ItemIndex <= -1 then Exit;
  I := FItemIndex - 1;
  if I >= 0 then ItemIndex := I;
end;

procedure TbsSkinPopupOfficeGallery.FindRight;
var
  I, Start: Integer;
begin
  if ItemIndex <= -1 then I := 0 else I := FItemIndex + 1;
  if I <= Items.Count - 1 then ItemIndex := I;
end;

procedure TbsSkinPopupOfficeGallery.FindDown;
var
  i: Integer;
begin
  i := ItemIndex;
  i := ItemIndex + ColCount;
  if i > Items.Count - 1 then i := Items.Count - 1;
  if i <> ItemIndex then ItemIndex := i;
end;

procedure TbsSkinPopupOfficeGallery.FindUp;
var
  i: Integer;
begin
  i := ItemIndex;
  i := ItemIndex - ColCount;
  if i < 0 then i := 0;
  if i <> ItemIndex then ItemIndex := i;
end;

procedure TbsSkinPopupOfficeGallery.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  case Key of
    VK_NEXT: FindPageDown;
    VK_PRIOR: FindPageUp;
    VK_UP: FindUp;
    VK_LEFT: FindLeft;
    VK_DOWN: FindDown;
    VK_RIGHT: FindRight;
    VK_RETURN, VK_SPACE:
      begin
        Hide;
        if FGallery.ItemIndex <> ItemIndex
        then
          FGallery.ItemIndex := ItemIndex;
      end;
    VK_ESCAPE:  Hide;
  end;
end;

// TbsSkinOfficeGridView =======================================================

constructor TbsSkinOfficeGridViewItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FHeader := False;
  FImageIndex := -1;
  FCaption := '';
  FEnabled := True;
  if TbsSkinOfficeGridViewItems(Collection).GridView.ItemIndex = Self.Index
  then
    Active := True
  else
    Active := False;
end;

procedure TbsSkinOfficeGridViewItem.Assign(Source: TPersistent);
begin
  if Source is TbsSkinOfficeGridViewItem then
  begin
    FImageIndex := TbsSkinOfficeGridViewItem(Source).ImageIndex;
    FCaption := TbsSkinOfficeGridViewItem(Source).Caption;
    FEnabled := TbsSkinOfficeGridViewItem(Source).Enabled;
    FHeader := TbsSkinOfficeGridViewItem(Source).Header;
  end
  else
    inherited Assign(Source);
end;


procedure TbsSkinOfficeGridViewItem.SetImageIndex(const Value: TImageIndex);
begin
  FImageIndex := Value;
  Changed(False);
end;

procedure TbsSkinOfficeGridViewItem.SetCaption(const Value: String);
begin
  FCaption := Value;
  Changed(False);
end;

procedure TbsSkinOfficeGridViewItem.SetHeader(Value: Boolean);
begin
  FHeader := Value;
  Changed(False);
end;

procedure TbsSkinOfficeGridViewItem.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  Changed(False);
end;

procedure TbsSkinOfficeGridViewItem.SetData(const Value: Pointer);
begin
  FData := Value;
end;

constructor TbsSkinOfficeGridViewItems.Create;
begin
  inherited Create(TbsSkinOfficeGridViewItem);
  GridView := AGridView;
end;

function TbsSkinOfficeGridViewItems.GetOwner: TPersistent;
begin
  Result := GridView;
end;

procedure  TbsSkinOfficeGridViewItems.Update(Item: TCollectionItem);
begin
  GridView.Repaint;
  GridView.UpdateScrollInfo;
end; 

function TbsSkinOfficeGridViewItems.GetItem(Index: Integer):  TbsSkinOfficeGridViewItem;
begin
  Result := TbsSkinOfficeGridViewItem(inherited GetItem(Index));
end;

procedure TbsSkinOfficeGridViewItems.SetItem(Index: Integer; Value:  TbsSkinOfficeGridViewItem);
begin
  inherited SetItem(Index, Value);
  GridView.RePaint;
end;

function TbsSkinOfficeGridViewItems.Add: TbsSkinOfficeGridViewItem;
begin
  Result := TbsSkinOfficeGridViewItem(inherited Add);
  GridView.RePaint;
end;

function TbsSkinOfficeGridViewItems.Insert(Index: Integer): TbsSkinOfficeGridViewItem;
begin
  Result := TbsSkinOfficeGridViewItem(inherited Insert(Index));
  GridView.RePaint;
end;

procedure TbsSkinOfficeGridViewItems.Delete(Index: Integer);
begin
  inherited Delete(Index);
  GridView.RePaint;
end;

procedure TbsSkinOfficeGridViewItems.Clear;
begin
  inherited Clear;
  GridView.RePaint;
end;

constructor TbsSkinOfficeGridView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csAcceptsControls];
  FUseInRibbonAppMenu := False;
  FMouseMoveChangeIndex := False;
  RowCount := 1;
  ColCount := 1;
  FInUpdateItems := False;
  FClicksDisabled := False;
  FHeaderLeftAlignment := False;
  FMouseDown := False;
  FMouseActive := -1;
  ScrollBar := nil;
  FScrollOffset := 0;
  FItems := TbsSkinOfficeGridViewItems.Create(Self);
  FItemMargin := -1;
  FItemSpacing := 1;
  FItemLayout := blGlyphTop;
  FImages := nil;
  Width := 150;
  Height := 150;
  FItemHeight := 30;
  FItemWidth := 30;
  FHeaderHeight := 20;
  FItemSkinDataName := 'listbox';
  FSkinDataName := 'listbox';
  FHeaderSkinDataName := 'menuheader';
  FMax := 0;
  FRealMax := 0;
  FOldHeight := -1;
  FItemIndex := -1;
  FDisabledFontColor := clGray;
end;

destructor TbsSkinOfficeGridView.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TbsSkinOfficeGridView.SetItemLayout(Value: TbsButtonLayout);
begin
  FItemLayout := Value;
  RePaint;
end;

procedure TbsSkinOfficeGridView.SetItemMargin(Value: Integer);
begin
  FItemMargin := Value;
  RePaint;
end;

procedure TbsSkinOfficeGridView.SetItemSpacing(Value: Integer);
begin
  FItemSpacing := Value;
  RePaint;
end;

procedure TbsSkinOfficeGridView.BeginUpdateItems;
begin
  FInUpdateItems := True;
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
end;

procedure TbsSkinOfficeGridView.EndUpdateItems;
begin
  FInUpdateItems := False;
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinOfficeGridView.SetHeaderLeftAlignment(Value: Boolean);
begin
  if FHeaderLeftAlignment <> Value
  then
    begin
      FHeaderLeftAlignment := Value;
      RePaint;
    end;
end;

function TbsSkinOfficeGridView.CalcHeight;
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

procedure TbsSkinOfficeGridView.ChangeSkinData;
var
  CIndex: Integer;
begin
  inherited;
  //
  if SkinData <> nil
  then
    CIndex := SkinData.GetControlIndex('edit');
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

procedure TbsSkinOfficeGridView.SetItemHeight(Value: Integer);
begin
  if FItemHeight <> Value
  then
    begin
      FItemHeight := Value;
      RePaint;
    end;
end;

procedure TbsSkinOfficeGridView.SetItemWidth(Value: Integer);
begin
  if FItemWidth <> Value
  then
    begin
      FItemWidth := Value;
      RePaint;
    end;
end;

procedure TbsSkinOfficeGridView.SetHeaderHeight(Value: Integer);
begin
  if FHeaderHeight <> Value
  then
    begin
      FHeaderHeight := Value;
      RePaint;
    end;
end;

procedure TbsSkinOfficeGridView.SetItems(Value: TbsSkinOfficeGridViewItems);
begin
  FItems.Assign(Value);
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinOfficeGridView.SetImages(Value: TCustomImageList);
begin
  FImages := Value;
end;

procedure TbsSkinOfficeGridView.Notification(AComponent: TComponent;
            Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then
   FImages := nil;
end;

procedure TbsSkinOfficeGridView.DrawItem;
var
  Buffer: TBitMap;
  R: TRect;
begin
  if FIndex <> -1
  then
    SkinDrawItem(Index, Cnvs)
  else
    DefaultDrawItem(Index, Cnvs);
end;

procedure TbsSkinOfficeGridView.CreateControlDefaultImage(B: TBitMap);
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

procedure TbsSkinOfficeGridView.CreateControlSkinImage(B: TBitMap);
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

procedure TbsSkinOfficeGridView.CalcItemRects;
var
  I, J, Col: Integer;
  X, Y, W, H: Integer;
begin
  if FIndex <> -1
  then
    FItemsRect := RealClientRect
  else
    FItemsRect := Rect(2, 2, Width - 2, Height - 2);
  if ScrollBar <> nil then Dec(FItemsRect.Right, ScrollBar.Width);  
  //
  RowCount := RectHeight(FItemsRect) div ItemHeight;
  ColCount := RectWidth(FItemsRect) div ItemWidth;
  if RowCount = 0 then RowCount := 1;
  if ColCount = 0 then ColCount := 1;
  //
  FRealMax := 0;
  Y := FItemsRect.Top;
  X := FItemsRect.Left;
  Col := 0;
  for i := 0 to Items.Count - 1 do
  begin
    if Items[i].Header
    then
      begin
        X := FItemsRect.Left;
        if i <> 0 then Y := Y + ItemHeight;
        Items[i].ItemRect := Rect(X, Y, X + RectWidth(FItemsRect), Y + HeaderHeight);
        Y := Y + HeaderHeight;
        Col := 0;
      end
    else
    if Col = ColCount
    then
      begin
        X := FItemsRect.Left;
        Y := Y + ItemHeight;
        Col := 0
      end;
    //
    if not Items[i].Header
    then
      Items[i].ItemRect := Rect(X, Y, X + ItemWidth, Y + ItemHeight);
    //
    OffsetRect(Items[i].ItemRect, 0, - FScrollOffset);
    Items[i].IsVisible := RectToRect(Items[i].ItemRect, FItemsRect);
    if not Items[i].IsVisible and (Items[i].ItemRect.Top <= FItemsRect.Top) and
       (Items[i].ItemRect.Bottom >= FItemsRect.Bottom)
    then
      Items[i].IsVisible := True;
    if Items[i].IsVisible then FRealMax := Items[i].ItemRect.Bottom;
    //
    if not Items[i].Header
    then
      begin
        X := X + ItemWidth;
        Inc(Col);
      end;
  end;
  FMax := Y + ItemHeight;
end;


procedure TbsSkinOfficeGridView.Scroll(AScrollOffset: Integer);
begin
  FScrollOffset := AScrollOffset;
  RePaint;
  UpdateScrollInfo;
end;

procedure TbsSkinOfficeGridView.GetScrollInfo(var AMin, AMax, APage, APosition: Integer);
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

procedure TbsSkinOfficeGridView.WMSize(var Msg: TWMSize);
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

procedure TbsSkinOfficeGridView.ScrollToItem(Index: Integer);
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

procedure TbsSkinOfficeGridView.ShowScrollbar;
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

procedure TbsSkinOfficeGridView.HideScrollBar;
begin
  if ScrollBar = nil then Exit;
  ScrollBar.Visible := False;
  ScrollBar.Free;
  ScrollBar := nil;
  RePaint;
end;

procedure TbsSkinOfficeGridView.UpdateScrollInfo;
var
  SMin, SMax, SPage, SPos: Integer;
begin
  //
  if not HandleAllocated then Exit;
  //
  if FInUpdateItems then Exit;
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

procedure TbsSkinOfficeGridView.AdjustScrollBar;
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

procedure TbsSkinOfficeGridView.SBChange(Sender: TObject);
begin
  Scroll(ScrollBar.Position);
end;

procedure TbsSkinOfficeGridView.SkinDrawItem(Index: Integer; Cnvs: TCanvas);
var
  ListBoxData: TbsDataSkinListBox;
  CheckListBoxData: TbsDataSkinCheckListBox;
  CIndex, TX, TY: Integer;
  R, R1, CR: TRect;
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

  CIndex := SkinData.GetControlIndex(FItemSkinDataName);
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
    begin
      if (FSkinDataName = 'listbox') or
         (FSkinDataName = 'memo') or
         (FSkinDataName = 'menupagepanel')
      then
        Cnvs.Font.Color := ListBoxData.FontColor
      else
        Cnvs.Font.Color := FSD.SkinColors.cBtnText;
    end
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
          DrawImageAndText(Cnvs, R, FItemMargin, FItemSpacing, FItemLayout,
             Caption, FImageIndex, FImages, False, Enabled, False, 0);
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
         DrawImageAndText(Buffer.Canvas, R, FItemMargin, FItemSpacing, FItemLayout,
          Caption, FImageIndex, FImages, False, Enabled, False, 0);
        end;

      Cnvs.Draw(FItems[Index].ItemRect.Left,
        FItems[Index].ItemRect.Top, Buffer);
        
      Buffer.Free;
    end;
end;

procedure TbsSkinOfficeGridView.DefaultDrawItem(Index: Integer; Cnvs: TCanvas);
var
  R, R1, CR: TRect;
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
      if FHeaderLeftAlignment
      then
        DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), R,
          DT_LEFT or DT_VCENTER or DT_SINGLELINE)
      else
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
         DrawImageAndText(Cnvs, R, FItemMargin, FItemSpacing, FItemLayout,
             Caption, FImageIndex, FImages, False, Enabled, False, 0);
        end;
    end;
  if FItems[Index].Active and Focused
  then
    Cnvs.DrawFocusRect(FItems[Index].ItemRect);
  RestoreDC(Cnvs.Handle, SaveIndex);   
end;



procedure TbsSkinOfficeGridView.SkinDrawHeaderItem(Index: Integer; Cnvs: TCanvas);
var
  Buffer: TBitMap;
  CIndex: Integer;
  LData: TbsDataSkinLabelControl;
  R, TR: TRect;
  CPicture: TBitMap;
begin
  CIndex := SkinData.GetControlIndex(FHeaderSkinDataName);
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
  TR := Rect(1, 1, Buffer.Width - 1, Buffer.Height - 1);

  if FHeaderLeftAlignment then TR.Left := LData.ClRect.Left;

  with Buffer.Canvas, LData do
  begin
    Font.Name := FontName;
    Font.Color := FontColor;
    Font.Height := FontHeight;
    Font.Style := FontStyle;
    Brush.Style := bsClear;
  end;
  with FItems[Index] do
    if FHeaderLeftAlignment
    then
      DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR,
       DT_LEFT or DT_VCENTER or DT_SINGLELINE)
    else
      DrawText(Buffer.Canvas.Handle, PChar(Caption), Length(Caption), TR,
       DT_CENTER or DT_VCENTER or DT_SINGLELINE);

  Cnvs.Draw(R.Left, R.Top, Buffer);
  Buffer.Free;
end;


procedure TbsSkinOfficeGridView.SetItemIndex(Value: Integer);
var
  I: Integer;
  IsFind: Boolean;
begin
  if Value < 0
  then
    begin
      FItemIndex := Value;
      RePaint;
    end
  else
    begin
      FItemIndex := Value;
      IsFind := False;
      for I := 0 to FItems.Count - 1 do
        with FItems[I] do
        begin
          if I = FItemIndex
          then
            begin
              Active := True;
              IsFind := True;
            end
          else
             Active := False;
        end;
      RePaint;
      ScrollToItem(FItemIndex);
      if IsFind and not (csDesigning in ComponentState) and not FUseInRibbonAppMenu
         and not (csLoading in ComponentState)
      then
      begin
        if Assigned(FItems[FItemIndex].OnClick) then
          FItems[FItemIndex].OnClick(Self);
        if Assigned(FOnItemClick) then
          FOnItemClick(Self);
      end;    
    end;
end;

procedure TbsSkinOfficeGridView.Loaded;
begin
  inherited;
end;

function TbsSkinOfficeGridView.ItemAtPos(X, Y: Integer): Integer;
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


procedure TbsSkinOfficeGridView.MouseDown(Button: TMouseButton; Shift: TShiftState;
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

procedure TbsSkinOfficeGridView.MouseUp(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
var
  I: Integer;
  P: TPoint;
begin
  inherited;
  FMouseDown := False;
  I := ItemAtPos(X, Y);
  if (I <> -1) and not (FItems[I].Header) and (Button = mbLeft)
  then
    begin
      ItemIndex := I;
      if FUseInRibbonAppMenu
      then
        begin
          if Assigned(FItems[FItemIndex].OnClick) then
            FItems[FItemIndex].OnClick(Self);
          if Assigned(FOnItemClick) then
            FOnItemClick(Self);
        end;
    end;  
end;

procedure TbsSkinOfficeGridView.MouseMove(Shift: TShiftState; X, Y: Integer);
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

procedure TbsSkinOfficeGridView.SetItemActive(Value: Integer);
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

procedure TbsSkinOfficeGridView.WMMOUSEWHEEL(var Message: TMessage);
begin
  inherited;
  if ScrollBar = nil then Exit;
  if Message.WParam < 0
  then
    ScrollBar.Position :=  ScrollBar.Position + ScrollBar.SmallChange
  else
    ScrollBar.Position :=  ScrollBar.Position - ScrollBar.SmallChange;

end;

procedure TbsSkinOfficeGridView.WMSETFOCUS(var Message: TWMSETFOCUS);
begin
  inherited;
  RePaint;
end;

procedure TbsSkinOfficeGridView.WMKILLFOCUS(var Message: TWMKILLFOCUS); 
begin
  inherited;
  RePaint;
end;

procedure TbsSkinOfficeGridView.WndProc(var Message: TMessage);
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

procedure TbsSkinOfficeGridView.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  if FUseInRibbonAppMenu
  then
    Msg.Result := DLGC_WANTARROWS or DLGC_WANTTAB
  else
    Msg.Result := DLGC_WANTARROWS;
end;

procedure TbsSkinOfficeGridView.FindUp;
var
  I, Start: Integer;
begin
  if ItemIndex <= -1 then Exit;
  Start := FItemIndex - ColCount;
  if Start < 0 then Start := 0;
  //
  for I := FItemIndex downto Start do
    if FItems[I].Header
    then
      begin
        Start := I;
        Break;
      end;
  //
  for I := Start downto 0 do
  begin
    if (not FItems[I].Header) and FItems[I].Enabled and (ItemIndex <> I)
    then
      begin
        ItemIndex := I;
        Exit;
      end;  
  end;
end;

procedure TbsSkinOfficeGridView.FindDown;
var
  I, Start: Integer;
begin
  if ItemIndex <= -1 then Start := 0 else Start := FItemIndex + ColCount;
  if Start > FItems.Count - 1 then Start := FItems.Count - 1;
  //
  for I := FItemIndex to Start do
    if FItems[I].Header
    then
      begin
        Start := I;
        Break;
      end;
  //
  for I := Start to FItems.Count - 1 do
  begin
    if (not FItems[I].Header) and FItems[I].Enabled and (ItemIndex <> I)
    then
      begin
        ItemIndex := I;
        Exit;
      end;
  end;
end;

procedure TbsSkinOfficeGridView.FindLeft;
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

procedure TbsSkinOfficeGridView.FindRight;
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

procedure TbsSkinOfficeGridView.FindPageUp;
var
  I, J, Start: Integer;
  PageCount: Integer;
  FindHeader: Boolean;
begin
  if ItemIndex <= -1 then Exit;
  Start := FItemIndex - 1;
  if Start < 0 then Exit;
  PageCount := (RectHeight(FItemsRect) div FItemHeight) * ColCount;
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


procedure TbsSkinOfficeGridView.FindPageDown;
var
  I, J, Start: Integer;
  PageCount: Integer;
  FindHeader: Boolean;
begin
  if ItemIndex <= -1 then Start := 0 else Start := FItemIndex + 1;
  if Start > FItems.Count - 1 then Exit;
  PageCount := (RectHeight(FItemsRect) div FItemHeight) * ColCount;
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

procedure TbsSkinOfficeGridView.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;


procedure TbsSkinOfficeGridView.KeyDown(var Key: Word; Shift: TShiftState);
begin
 inherited KeyDown(Key, Shift);
 case Key of
   VK_NEXT:  FindPageDown;
   VK_PRIOR: FindPageUp;
   VK_LEFT: FindLeft;
   VK_UP: FindUp;
   VK_DOWN: FindDown;
   VK_RIGHT: FindRight;
   VK_RETURN, VK_SPACE:
   if (FItemIndex <> -1) and FUseInRibbonAppMenu
   then
     begin
       if Assigned(FItems[FItemIndex].OnClick) then
          FItems[FItemIndex].OnClick(Self);
        if Assigned(FOnItemClick) then
          FOnItemClick(Self);
      end;
 end;
end;

end.
