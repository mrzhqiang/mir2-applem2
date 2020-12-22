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

unit bsSkinTabs;

{$P+,S-,W-,R-}
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, StdCtrls,
     CommCtrl, ComCtrls, ExtCtrls, bsSkinData, bsSkinBoxCtrls, bsUtils, bsSkinCtrls,
     ImgList;
type

  TbsSkinCustomTabSheet = class(TTabSheet)
  private
    FWallPaper: TBitMap;
  protected
    ButtonRect: TRect;
    ButtonMouseIn, ButtonMouseDown:Boolean;
    procedure CheckControlsBackground;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetWallPaper(Value: TBitmap);
    procedure CMSENCPaint(var Message: TMessage); message CM_SENCPAINT;
  public
    procedure PaintBG(DC: HDC);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property WallPaper: TBitMap read FWallPaper write SetWallPaper;
  end;

  TbsSkinTabSheet = class(TbsSkinCustomTabSheet)
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  end;


  TbsDrawSkinTabEvent = procedure(TabIndex: Integer; const Rct: TRect; Active,
    MouseIn: Boolean; Cnvs: TCanvas) of object;

  TbsCloseEvent = procedure(Sender: TObject; var CanClose: Boolean) of object;

  TbsSkinPageControl = class(TPageControl)
  private
    FMouseWheelSupport: Boolean;
    FTabExtendedDraw: Boolean;
    FTabMargin: Integer;
    FTabSpacing: Integer;
    FTabLayout: TbsButtonLayout;
    FTextInHorizontal: Boolean;
    //
    FHideTabs: Boolean;
    FHideBorder: Boolean;
    FOLdTabPosition: TTabPosition;
    FOldMultiLine: Boolean;
    FOldTabHeight: Integer;
    FCloseSize: Integer;
    FOnClose: TbsCloseEvent;
    FOnAfterClose: TNotifyEvent;
    FFreeOnClose: Boolean;
    FIsVistaOS: Boolean;
    FShowCloseButtons: Boolean;
    FTabsBGTransparent: Boolean;
    FActiveTab, FOldActiveTab: Integer;
    FActiveTabIndex, FOldActiveTabIndex: Integer;
    FOnDrawSkinTab: TbsDrawSkinTabEvent;
    //
    FImages: TCustomImageList;
    FTempImages: TCustomImageList;
    FTabsInCenter: Boolean;
    FTabsOffset: Integer;
    FButtonTabSkinDataName: String;
    
    procedure SetTabsInCenter(Value: Boolean);
    procedure SetTabsOffset(Value: Integer);

    function GetCloseSize: Integer;
    procedure SetImages(value: TCustomImageList);
    procedure DrawButton(Buffer: TBitmap; Active, MouseIn: Boolean);
    procedure DrawCloseButton(Cnvs: TCanvas; R: TRect;  I, W, H: Integer);
    procedure SetTabExtendedDraw(Value: Boolean);
    procedure SetTabLayout(Value : TbsButtonLayout);
    procedure SetTabMargin(Value: Integer);
    procedure SetTabSpacing(Value: Integer);
    procedure SetTextInHorizontal(Value: Boolean);
    //
    procedure SetShowCloseButtons(Value: Boolean);
    function GetPosition: Integer;
    function  GetInVisibleItemCount: Integer;
    procedure OnUpDownChange(Sender: TObject);
    procedure DrawTabs(Cnvs: TCanvas);
    procedure DrawTab(TI: Integer; const Rct: TRect; Active, MouseIn: Boolean; Cnvs: TCanvas);
    function GetItemRect(index: integer): TRect;
    procedure SetItemSize(AWidth, AHeight: integer);
    procedure CheckScroll;
    procedure ShowSkinUpDown;
    procedure HideSkinUpDown;
    procedure TestActive(X, Y: Integer);
    procedure SetTabsBGTransparent(Value: Boolean);
    procedure DrawEmptyBackGround(DC: HDC);
    procedure CMSENCPaint(var Message: TMessage); message CM_SENCPAINT;
    function CheckVisibleTabs: Boolean;
    function GetActiveTabRect: TRect;
  protected
    //
    FSD: TbsSkinData;
    FSkinDataName: String;
    FIndex: Integer;
    FSkinUpDown: TbsSkinUpDown;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FDefaultItemHeight: Integer;
    CloseButtonRect, ClosebuttonActiveRect, CloseButtonDownRect: TRect;
    ButtonTransparent: Boolean;
    ButtonTransparentColor: TColor;
    function GetItemOffset: Integer;
    procedure SetDefaultItemHeight(Value: Integer);
    procedure SetDefaultFont(Value: TFont);
    procedure Change; override;
    procedure Change2;
    procedure GetSkinData;
    //
    procedure FindNextPage;
    procedure FindPriorPage;
    procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
    //
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSkinData(Value: TbsSkinData);
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMHSCROLL(var Msg: TWMEraseBkGnd); message WM_HSCROLL;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure PaintDefaultWindow(Cnvs: TCanvas);
    procedure PaintSkinWindow(Cnvs: TCanvas);
    procedure PaintWindow(DC: HDC); override;
    procedure WndProc(var Message:TMessage); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMCHECKPARENTBG(var Msg: TWMEraseBkgnd); message WM_CHECKPARENTBG;
    procedure WMCHANGE(var Message: TMessage); message TCM_SETCURSEL;
    procedure DoClose;
  public
    //
    Picture: TBitMap;
    SkinRect, ClRect, TabRect,
    ActiveTabRect, FocusTabRect, MouseInTabRect: TRect;
    TabsBGRect: TRect;
    LTPoint, RTPoint, LBPoint, RBPoint: TPoint;
    TabLeftOffset, TabRightOffset: Integer;
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, FocusFontColor, MouseInFontColor: TColor;
    UpDown: String;
    BGPictureIndex: Integer;
    TabStretchEffect: Boolean;
    ShowFocus: Boolean;
    FocusOffsetX, FocusOffsetY: Integer;
    StretchEffect, LeftStretch, TopStretch, RightStretch, BottomStretch: Boolean;
    StretchType: TbsStretchType;
    TabLeftBottomActiveRect, TabLeftBottomFocusRect: TRect;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData;
    procedure Loaded; override;
    procedure UpDateTabs;
    procedure HideTabs;
    procedure ShowTabs;
    procedure HideBorderAndTabs;
    procedure ShowBorderAndTabs;
  published
    property MouseWheelSupport: Boolean
      read FMouseWheelSupport write FMouseWheelSupport;
    property TabExtededDraw: Boolean
     read FTabExtendedDraw write SetTabExtendedDraw;
    property ButtonTabSkinDataName: String
      read FButtonTabSkinDataName write FButtonTabSkinDataName; 
    property TabsOffset: Integer read FTabsOffset write SetTabsOffset;  
    property TabMargin: Integer read FTabMargin write SetTabMargin default -1;
    property TabSpacing: Integer read FTabSpacing write SetTabSpacing default 2;
    property TabLayout: TbsButtonLayout read FTabLayout write SetTabLayout default blGlyphLeft;
    property TextInHorizontal: Boolean read FTextInHorizontal write SetTextInHorizontal;
    property TabsInCenter: Boolean read FTabsInCenter write SetTabsInCenter;
    property FreeOnClose: Boolean read FFreeOnClose write FFreeOnClose;
    property ShowCloseButtons: Boolean read FShowCloseButtons write SetShowCloseButtons;
    property Images: TCustomImageList read FImages write SetImages;
    property TabsBGTransparent: Boolean read FTabsBGTransparent write SetTabsBGTransparent;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property DefaultItemHeight: Integer read FDefaultItemHeight write SetDefaultItemHeight;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property Color;
    property ActivePage;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HotTrack;
    // property Images;
    property OwnerDraw;
    property ParentBiDiMode;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RaggedRight;
    property ScrollOpposite;
    property ShowHint;
    property TabHeight;
    property TabOrder;
    property TabPosition;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnClose: TbsCloseEvent read FOnClose write FOnClose;
    property OnAfterClose: TNotifyEvent read FOnAfterClose write FOnAfterClose;
    property OnChange;
    property OnDrawSkinTab: TbsDrawSkinTabEvent
      read FOnDrawSkinTab write FOnDrawSkinTab; 
    property OnChanging;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawTab;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TbsRectArray = array of TRect;
  TbsBolArray = array of Boolean;

  TbsCloseEvent2 = procedure(Index: Integer; var CanClose: Boolean) of object;

  TbsSkinTabControl = class(TTabControl)
  private
    FTabExtendedDraw: Boolean;
    FTabMargin: Integer;
    FTabSpacing: Integer;
    FTabLayout: TbsButtonLayout;
    FTextInHorizontal: Boolean;
    FOnClose: TbsCloseEvent2;
    FOnAfterClose: TNotifyEvent;
    TabButtonMouseDown: TbsBolArray;
    TabButtonMouseIn: TbsBolArray;
    TabButtonR: TbsRectArray;
    FCloseSize: Integer;
    FShowCloseButtons: Boolean;
    FTabsBGTransparent: Boolean;
    FOnDrawSkinTab: TbsDrawSkinTabEvent;
    FromWMPaint: Boolean;
    FOldTop, FOldBottom: Integer;
    FActiveTab, FOldActiveTab: Integer;
    //
    FImages: TCustomImageList;
    FTempImages: TCustomImageList;
    //
    procedure SetTabExtendedDraw(Value: Boolean);
    procedure SetTabLayout(Value : TbsButtonLayout);
    procedure SetTabMargin(Value: Integer);
    procedure SetTabSpacing(Value: Integer);
    procedure SetTextInHorizontal(Value: Boolean);
    procedure DrawCloseButton(Cnvs: TCanvas; R: TRect;  I, W, H: Integer);
    procedure SetShowCloseButtons(Value: Boolean);
    function GetPosition: Integer;
    function  GetInVisibleItemCount: Integer;
    procedure OnUpDownChange(Sender: TObject);
    procedure DrawTabs(Cnvs: TCanvas);
    procedure DrawTab(TI: Integer; const Rct: TRect; Active, MouseIn: Boolean; Cnvs: TCanvas);
    function GetItemRect(index: integer): TRect;
    procedure SetItemSize(AWidth, AHeight: integer);
    procedure CheckScroll;
    procedure ShowSkinUpDown;
    procedure HideSkinUpDown;
    procedure TestActive(X, Y: Integer);
    procedure SetTabsBGTransparent(Value: Boolean);
    procedure SetImages(value: TCustomImageList);
  protected
    //
    FSD: TbsSkinData;
    FSkinDataName: String;
    FIndex: Integer;
    FSkinUpDown: TbsSkinUpDown;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FDefaultItemHeight: Integer;

    function GetCloseSize: Integer;
    procedure SetDefaultItemHeight(Value: Integer);
    procedure SetDefaultFont(Value: TFont);
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure GetSkinData;
    //
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSkinData(Value: TbsSkinData);
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMHSCROLL(var Msg: TWMEraseBkGnd); message WM_HSCROLL;
    procedure PaintDefaultWindow(Cnvs: TCanvas);
    procedure PaintSkinWindow(Cnvs: TCanvas);
    procedure PaintWindow(DC: HDC); override;
    procedure WndProc(var Message:TMessage); override;
    procedure Change; override;
    procedure Change2;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMCHECKPARENTBG(var Msg: TWMEraseBkgnd); message WM_CHECKPARENTBG;
    procedure CheckControlsBackground;
    function GetActiveTabRect: TRect;
    procedure DoClose;
  public

    Picture: TBitMap;
    SkinRect, ClRect, TabRect,
    ActiveTabRect, FocusTabRect, MouseInTabRect: TRect;
    TabsBGRect: TRect;
    LTPoint, RTPoint, LBPoint, RBPoint: TPoint;
    TabLeftOffset, TabRightOffset: Integer;
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, FocusFontColor, MouseInFontColor: TColor;
    UpDown: String;
    BGPictureIndex: Integer;
    TabStretchEffect: Boolean;
    StretchEffect, LeftStretch, TopStretch, RightStretch, BottomStretch: Boolean;
    ShowFocus: Boolean;
    FocusOffsetX, FocusOffsetY: Integer;
    StretchType: TbsStretchType;
    CloseButtonRect, ClosebuttonActiveRect, CloseButtonDownRect: TRect;
    ButtonTransparent: Boolean;
    ButtonTransparentColor: TColor;
    TabLeftBottomActiveRect, TabLeftBottomFocusRect: TRect;
    //
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData;
    procedure Loaded; override;
    procedure UpDateTabs;
    //
    procedure PaintBG(DC: HDC);
    //
  published
    property TabExtededDraw: Boolean
      read FTabExtendedDraw write SetTabExtendedDraw;
    property TabMargin: Integer read FTabMargin write SetTabMargin default -1;
    property TabSpacing: Integer read FTabSpacing write SetTabSpacing default 2;
    property TabLayout: TbsButtonLayout read FTabLayout write SetTabLayout default blGlyphLeft;
    property TextInHorizontal: Boolean read FTextInHorizontal write SetTextInHorizontal;
    property Images: TCustomImageList read FImages write SetImages;
    property ShowCloseButtons: Boolean read FShowCloseButtons write SetShowCloseButtons;
    property TabsBGTransparent: Boolean read FTabsBGTransparent write SetTabsBGTransparent;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property DefaultItemHeight: Integer read FDefaultItemHeight write SetDefaultItemHeight;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property Color;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HotTrack;
    property OwnerDraw;
    property ParentBiDiMode;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RaggedRight;
    property ScrollOpposite;
    property ShowHint;
    property TabHeight;
    property TabOrder;
    property TabPosition;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnClose: TbsCloseEvent2 read FOnClose write FOnClose;
    property OnAfterClose: TNotifyEvent read FOnAfterClose write FOnAfterClose;
    property OnDrawSkinTab: TbsDrawSkinTabEvent
      read FOnDrawSkinTab write FOnDrawSkinTab;
    property OnChange;
    property OnChanging;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawTab;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

implementation

uses Consts, ComStrs, BusinessSkinForm, bsEffects;

const
  CLOSE_SIZE = 14;

procedure DrawRotate90_1(Cnvs: TCanvas; B: TBitMap; X, Y: Integer);
var
  B1, B2: TbsEffectBmp;
begin
  B1 := TbsEffectBmp.CreateFromhWnd(B.Handle);
  B2 := TbsEffectBmp.Create(B1.Height, B1.Width);
  B1.Rotate90_1(B2);
  B2.Draw(Cnvs.Handle, X, Y);
  B1.Free;
  B2.Free;
end;


procedure DrawRotate90_1_H(B: TBitMap);
var
  B1, B2: TbsEffectBmp;
  w, h: Integer;
begin
  w := B.Width;
  h := B.Height;
  B1 := TbsEffectBmp.CreateFromhWnd(B.Handle);
  B2 := TbsEffectBmp.Create(B1.Height, B1.Width);
  B1.Rotate90_1(B2);
  B.Width := h;
  B.Height := w;
  B2.Draw(B.Canvas.Handle, 0, 0);
  B1.Free;
  B2.Free;
end;

procedure DrawFlipVert(B: TBitMap);
var
  B1, B2: TbsEffectBmp;
begin
  B1 := TbsEffectBmp.CreateFromhWnd(B.Handle);
  B2 := TbsEffectBmp.Create(B1.Width, B1.Height);
  B1.FlipVert(B2);
  B2.Draw(B.Canvas.Handle, 0, 0);
  B1.Free;
  B2.Free;
end;

procedure DrawRotate90_2(Cnvs: TCanvas; B: TBitMap; X, Y: Integer);
var
  B1, B2: TbsEffectBmp;
begin
  B1 := TbsEffectBmp.CreateFromhWnd(B.Handle);
  B2 := TbsEffectBmp.Create(B1.Height, B1.Width);
  B1.Rotate90_2(B2);
  B2.Draw(Cnvs.Handle, X, Y);
  B1.Free;
  B2.Free;
end;

procedure DrawRotate90_2_H(B: TBitMap);
var
  B1, B2: TbsEffectBmp;
  w, h: Integer;
begin
  w := B.Width;
  h := B.Height;
  B1 := TbsEffectBmp.CreateFromhWnd(B.Handle);
  B2 := TbsEffectBmp.Create(B1.Height, B1.Width);
  B1.Rotate90_2(B2);
  B.Width := h;
  B.Height := w;
  B2.Draw(B.Canvas.Handle, 0, 0);
  B1.Free;
  B2.Free;
end;

procedure DrawTabGlyphAndText(Cnvs: TCanvas; W, H: Integer; S: String;
                              IM: TCustomImageList; IMIndex: Integer;
                              AEnabled: Boolean; TopOffset: Integer);

var
  R, TR: TRect;
  GX, GY, GW, GH, TW, TH: Integer;
begin
  R := Rect(0, 0, 0, 0);
  DrawText(Cnvs.Handle, PChar(S), Length(S), R, DT_CALCRECT);
  TW := RectWidth(R) + 2;
  if S = '' then TW := 0;
  TH := RectHeight(R);
  GW := IM.Width;
  GH := IM.Height;
  GX := (W) div 2 - (GW + TW + 2) div 2;
  GY := H div 2 - GH div 2 + TopOffset;
  TR.Left := GX + GW + 2;
  TR.Top := H div 2 - TH div 2 + TopOffset;
  TR.Right := TR.Left + TW;
  TR.Bottom := TR.Top + TH;
  DrawText(Cnvs.Handle, PChar(S), Length(S), TR, DT_CENTER);
  IM.Draw(Cnvs, GX, GY, IMIndex, AEnabled);
end;

constructor TbsSkinCustomTabSheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible];
  Visible := False;
  FWallPaper := TBitMap.Create;
  ButtonMouseIn := False;
  ButtonMouseDown := False;
end;

procedure TbsSkinCustomTabSheet.CMSENCPaint(var Message: TMessage);
begin
  Message.Result := SE_RESULT;
end;

procedure TbsSkinCustomTabSheet.CheckControlsBackground;
var
  i: Integer;
begin
  for i := 0 to ControlCount - 1 do
  begin
    if Controls[i] is TWinControl
    then
      SendMessage(TWinControl(Controls[i]).Handle, WM_CHECKPARENTBG, 0, 0);
  end;
end;

procedure TbsSkinCustomTabSheet.SetWallPaper(Value: TBitmap);
begin
  FWallPaper.Assign(Value);
  if (csDesigning in ComponentState) then RePaint;
end;


procedure TbsSkinCustomTabSheet.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
    with Params.WindowClass do
      Style := Style and not (CS_HREDRAW or CS_VREDRAW);
end;

destructor TbsSkinCustomTabSheet.Destroy;
begin
  PageControl := nil;
  FWallPaper.Free;
  inherited Destroy;
end;

procedure TbsSkinCustomTabSheet.WMEraseBkGnd;
begin
  PaintBG(Msg.DC);
end;

procedure TbsSkinCustomTabSheet.WMSize;
var
  PC: TbsSkinPageControl;
begin
  inherited;
  RePaint;
  PC := TbsSkinPageControl(Parent);
  if (PC <> nil) and (PC.SkinData <>  nil) and
  (not PC.SkinData.Empty) and (PC.StretchEffect)
  then
    CheckControlsBackground;
end;

procedure TbsSkinCustomTabSheet.PaintBG;
var
  C: TCanvas;
  TabSheetBG, Buffer2: TBitMap;
  PC: TbsSkinPageControl;
  X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
begin
  if (Width <= 0) or (Height <=0) then Exit;
  PC := TbsSkinPageControl(Parent);
  if PC = nil then Exit;
  PC.GetSkinData;
  C := TCanvas.Create;
  C.Handle := DC;

  if not FWallPaper.Empty
  then
    begin
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div FWallPaper.Width;
          YCnt := Height div FWallPaper.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          C.Draw(X * FWallPaper.Width, Y * FWallPaper.Height, FWallPaper);
        end;
      C.Free;
      Exit;
    end;

  if (PC.FSD <> nil) and (not PC.FSD.Empty) and
     (PC.FIndex <> -1) and (PC.BGPictureIndex <> -1)
  then
    begin
      TabSheetBG := TBitMap(PC.FSD.FActivePictures.Items[PC.BGPictureIndex]);

      if PC.StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case PC.StretchType of
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

  if PC.FIndex <> -1
  then
    with PC do
    begin
      TabSheetBG := TBitMap.Create;
      TabSheetBG.Width := RectWidth(ClRect);
      TabSheetBG.Height := RectHeight(ClRect);
      TabSheetBG.Canvas.CopyRect(Rect(0, 0, TabSheetBG.Width, TabSheetBG.Height),
        PC.Picture.Canvas,
          Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
               SkinRect.Left + ClRect.Right,
               SkinRect.Top + ClRect.Bottom));

     if PC.StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case PC.StretchType of
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
    FillRect(Rect(0, 0, w1, h1));
  end;
  C.Free;
end;


{TTabSheetes}
constructor TbsSkinTabSheet.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

destructor TbsSkinTabSheet.Destroy;
begin
  inherited Destroy;
end;

procedure TbsSkinTabSheet.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

{ TbsSkinPageControl }

constructor TbsSkinPageControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //
  FButtonTabSkinDataName := 'resizetoolbutton';
  FMouseWheelSupport := False;
  FHideTabs := False;
  FHideBorder := False;
  FTabsInCenter := False;
  FTabsOffset := 0;
  FOldTabHeight := -1;
  FFreeOnClose := False;
  FIsVistaOS := IsVistaOS;
  FImages := nil;
  FTempImages := TCustomImageList.Create(self);
  FTempImages.Width := 1;
  FTempImages.Height := 1;
  inherited Images := FTempImages;
  //
  FTabExtendedDraw := False;
  FTabMargin := -1;
  FTabSpacing := 1;
  FTabLayout := blGlyphLeft;
  FTextInHorizontal := False;
  //
  FTabsBGTransparent := False;
  Ctl3D := False;
  FIndex := -1;
  Picture := nil;
  Font.Name := 'Arial';
  Font.Style := [];
  Font.Color := clBtnText;
  Font.Height := 14;
  FSkinUpDown := nil;
  FSkinDataName := 'tab';
  FDefaultFont := TFont.Create;
  FDefaultFont.Name := 'Arial';
  FDefaultFont.Style := [];
  FDefaultFont.Color := clBtnText;
  FDefaultFont.Height := 14;
  FDefaultItemHeight := 20;
  FActiveTab := -1;
  FOldActiveTab := -1;
  FActiveTabIndex := -1;
  FOldActiveTabIndex := -1;
  FUseSkinFont := True;
  FCloseSize := CLOSE_SIZE;
end;

destructor TbsSkinPageControl.Destroy;
begin
  FTempImages.Free;
  FDefaultFont.Free;
  inherited Destroy;
end;

procedure TbsSkinPageControl.WMCHANGE(var Message: TMessage); 
begin
  inherited;
  if not (csLoading in ComponentState) then  Invalidate;
end;


procedure TbsSkinPageControl.WMMOUSEWHEEL(var Message: TMessage); 
var
  I: Integer;
begin
  inherited;
  if FMouseWheelSupport and Focused
  then
    if Message.WParam < 0 then FindNextPage else FindPriorPage;
end;

procedure TbsSkinPageControl.FindNextPage;
var
  i, j, k: Integer;
begin
  j := -1;
  for i := 0 to PageCount - 1 do
    if Pages[i] = ActivePage
  then
    begin
      j := i;
      Break;
    end;
  if (j = -1) or (j = PageCount - 1) then Exit;
  k := -1;
  for i := j + 1 to PageCount - 1 do
  begin
    if Pages[i].TabVisible
    then
      begin
        k := i;
        Break;
      end;
  end;
 if k <> -1 then ActivePage := Pages[k];
end;

procedure TbsSkinPageControl.FindPriorPage;
var
  i, j, k: Integer;
begin
  j := -1;
  for i := 0 to PageCount - 1 do
    if Pages[i] = ActivePage
  then
    begin
      j := i;
      Break;
    end;
  if (j = -1) or (j = 0) then Exit;
  k := -1;
  for i := j - 1 downto 0 do
  begin
    if Pages[i].TabVisible
    then
      begin
        k := i;
        Break;
      end;
  end;
 if k <> -1 then ActivePage := Pages[k];
end;


procedure TbsSkinPageControl.SetTextInHorizontal;
begin
  FTextInHorizontal := Value;
  Invalidate;
end;

procedure TbsSkinPageControl.SetTabExtendedDraw;
begin
  FTabExtendedDraw := Value;
  Invalidate;
end;

procedure TbsSkinPageControl.SetTabLayout;
begin
  if FTabLayout <> Value
  then
    begin
      FTabLayout := Value;
      RePaint;
    end;
end;

procedure TbsSkinPageControl.SetTabSpacing;
begin
  if Value <> FTabSpacing
  then
    begin
      FTabSpacing := Value;
      RePaint;
    end;
end;

procedure TbsSkinPageControl.SetTabMargin;
begin
  if (Value <> FTabMargin) and (Value >= -1)
  then
    begin
      FTabMargin := Value;
      RePaint;
    end;
end;

function TbsSkinPageControl.GetItemOffset: Integer;
var
  W, i: Integer;
begin
  if FTabsOffset > 0
  then
    begin
      Result := FTabsOffset;
      Exit;
    end;
  if TabWidth = 0
  then
    begin
      Result := 0;
      Exit;
    end;
  W := 0;
  for i := 0 to PageCount - 1 do
  begin
    if Pages[i].TabVisible then W := W + TabWidth;
  end;
  Result := Width div 2 - W div 2;
  if Result < 0 then Result := 0;
end;

procedure TbsSkinPageControl.SetTabsInCenter;
begin
  if TabWidth = 0
  then
     begin
       FTabsInCenter := False;
       Exit;
     end;
  FTabsInCenter := Value;
  if FTabsInCenter and (TabPosition <> tpTop)
  then
    TabPosition := tpTop;
  if FTabsInCenter and MultiLine
  then
    MultiLine := False;
  if FTabsInCenter then FTabsBGTransparent := FTabsInCenter;
  Invalidate;  
end;

procedure TbsSkinPageControl.SetTabsOffset;
begin
  FTabsOffset := Value;
  if (FTabsOffset > 0) and (TabPosition <> tpTop)
  then
    TabPosition := tpTop;
  if (FTabsOffset > 0) and MultiLine
  then
    MultiLine := False;
  if (FTabsOffset > 0) then FTabsBGTransparent := (FTabsOffset > 0);
  Invalidate;
end;

procedure TbsSkinPageControl.CMSENCPaint(var Message: TMessage);
begin
  Message.Result := SE_RESULT;
end;

procedure TbsSkinPageControl.HideBorderAndTabs;
begin
  if  TabPosition <> tpTop
  then
    TabPosition := tpTop;
  FHideTabs := True;
  FHideBorder := True;
  if FSkinUpDown <> nil then HideSkinUpdown;
  Realign;
end;

procedure TbsSkinPageControl.ShowBorderAndTabs;
begin
  FHideBorder := False;
  FHideTabs := False;
  ShowTabs;
  Realign;
end;

procedure TbsSkinPageControl.HideTabs;

function CanHide: Boolean;
var
  i: Integer;
begin
  Result := False;
  if PageCount = 0
  then
    Result := False
  else
    begin
      for i := 0 to PageCount - 1 do
      begin
        if Pages[i].TabVisible
        then
          begin
            Result := True;
            Break;
          end;
      end;
    end;
end;

begin
  if (FOldTabHeight = -1) and CanHide
  then
    begin
      FHideTabs := True;
      FOldTabPosition := TabPosition;
      FOldMultiLine := Multiline;
      if (TabPosition = tpLeft) or (TabPosition = tpRight)
      then
        TabPosition := tpTop;
      if MultiLine = True then MultiLine := False;
      FOldTabHeight := TabHeight;
      TabHeight := 1;
      if FSkinUpDown <> nil then HideSkinUpDown;
    end;
end;

procedure TbsSkinPageControl.ShowTabs;
begin
  if FOldTabHeight <> -1
  then
    begin
      TabPosition := FOldTabPosition;
      MultiLine := FOldMultiline;
      FHideTabs := False;
      TabHeight := FOldTabHeight;
      if (TabHeight <= 0) and (FIndex <> -1)
      then
        SetItemSize(TabWidth, RectHeight(TabRect));
      FOldTabHeight := -1;
      if not MultiLine then CheckScroll;
    end;
end;

function TbsSkinPageControl.GetCloseSize;
begin
  if (FIndex <> -1) and not IsNullRect(CloseButtonRect)
  then
    Result := RectWidth(CloseButtonRect)
  else
    Result := CLOSE_SIZE;
end;

procedure TbsSkinPageControl.DoClose;
var
  I: TTabSheet;
  CanClose: Boolean;
  P: TPoint;
begin
  I := ActivePage;
  CanClose := True;
  if Assigned(FOnClose) then FOnClose(I, CanClose);
  if CanClose
  then
    begin
      I.TabVisible := False;
      if FFreeOnClose then I.Free;
      if Assigned(FOnAfterClose) then FOnAfterClose(Self);
    end;
  if CanClose = False
  then
    begin
      GetCursorPos(P);
      if Windows.WindowFromPoint(P) <> Self.Handle
      then
        begin
          TbsSkinCustomTabSheet(I).ButtonMouseIn := False;
          TbsSkinCustomTabSheet(I).ButtonMouseDown := False;
          DrawTabs(Canvas);
        end;
    end;     
end;

procedure TbsSkinPageControl.DrawButton(Buffer: TBitmap; Active, MouseIn: Boolean);
var
  CIndex: Integer;
  BtnSkinPicture: TBitMap;
  BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint: TPoint;
  BtnCLRect: TRect;
  BSR, ABSR, DBSR, R1: TRect;
  CIX, CIY, X, Y, XO, YO: Integer;
  ButtonData: TbsDataSkinButtonControl;
  ButtonR: TRect;
begin
  ButtonData := nil;
  CIndex := FSD.GetControlIndex(FButtonTabSkinDataName);
  if CIndex <> -1
  then
    ButtonData := TbsDataSkinButtonControl(FSD.CtrlList[CIndex]);
  if ButtonData = nil then Exit;
  //
  ButtonR := Rect(0, 0, Buffer.Width, Buffer.Height);
  //
  with ButtonData do
  begin
    XO := RectWidth(ButtonR) - RectWidth(SkinRect);
    YO := RectHeight(ButtonR) - RectHeight(SkinRect);
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
    if Active
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, DBSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        Buffer.Canvas.Font.Color := DownFontColor;
      end
    else
    if MouseIn
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, ABSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        Buffer.Canvas.Font.Color := ActiveFontColor;
      end
    else
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, BSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        Buffer.Canvas.Font.Color := FontColor;
      end;
   end;
end;

procedure TbsSkinPageControl.DrawCloseButton(Cnvs: TCanvas; R: TRect;
          I, W, H: Integer);
var
  Buffer: TBitMap;
  CIndex: Integer;
  BtnSkinPicture: TBitMap;
  BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint: TPoint;
  BtnCLRect: TRect;
  BSR, ABSR, DBSR, R1: TRect;
  CIX, CIY, X, Y, XO, YO: Integer;
  ButtonData: TbsDataSkinButtonControl;
  ButtonR, R2: TRect;
begin
  if FIndex = -1
  then
    begin
      X := R.Left;
      Y := R.Top + RectHeight(R) div 2 - CLOSE_SIZE div 2;
      ButtonR := Rect(X, Y, X + CLOSE_SIZE, Y + CLOSE_SIZE);
      CIX := ButtonR.Left + 2;
      CIY := ButtonR.Top + 2;
      if TbsSkinCustomTabSheet(Self.Pages[I]).ButtonMouseDown and
         TbsSkinCustomTabSheet(Self.Pages[I]).ButtonMouseIn
      then
        DrawCloseImage(Cnvs, CIX, CIY, clWhite)
      else
      if TbsSkinCustomTabSheet(Self.Pages[I]).ButtonMouseIn
      then
        begin
          DrawCloseImage(Cnvs, CIX, CIY, clWhite)
        end
      else
        begin
          DrawCloseImage(Cnvs, CIX, CIY, clBlack);
        end;
      //
      TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect := ButtonR;
      if (TabPosition = tpLeft) and not FTextInHorizontal
      then
        begin
          R1 := TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect;
          R2 := Rect(R1.Top, W - R1.Right, R1.Bottom, W - R1.Left);
          TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect := R2;
        end
      else
      if (TabPosition = tpRight) and not FTextInHorizontal
      then
        begin
          R1 := TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect;
          R2 := Rect(H - R1.Bottom, R1.Left, H - R1.Top, R1.Right);
          TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect := R2;
        end;
      Exit;
    end;

  if not IsNullRect(CloseButtonRect)
  then
    begin
      if TbsSkinCustomTabSheet(Self.Pages[I]).ButtonMouseDown and
         TbsSkinCustomTabSheet(Self.Pages[I]).ButtonMouseIn
      then
        R1 := CloseButtonDownRect
      else
      if TbsSkinCustomTabSheet(Self.Pages[I]).ButtonMouseIn
      then
        R1 := CloseButtonActiveRect
      else
        R1 := CloseButtonRect;
      X := R.Left;
      Y := R.Top + RectHeight(R) div 2 - RectHeight(R1) div 2;
      ButtonR := Rect(X, Y, X + RectWidth(R1), Y + RectHeight(R1));
      if ButtonTransparent
      then
        begin
          Buffer := TBitMap.Create;
          Buffer.Width := RectWidth(R1);
          Buffer.Height := RectHeight(R1);
          Buffer.Transparent := True;
          Buffer.TransparentMode := tmFixed;
          Buffer.TransparentColor := ButtonTransparentColor;
          Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
            Picture.Canvas, R1);
          Cnvs.Draw(ButtonR.Left, ButtonR.Top, Buffer);
          Buffer.Free;
        end
      else
        Cnvs.CopyRect(ButtonR, Picture.Canvas, R1);

      //
      TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect := ButtonR;
      if (TabPosition = tpLeft) and not FTextInHorizontal
      then
        begin
          R1 := TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect;
          R2 := Rect(R1.Top, W - R1.Right, R1.Bottom, W - R1.Left);
          TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect := R2;
        end
      else
      if (TabPosition = tpRight) and not FTextInHorizontal
      then
        begin
          R1 := TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect;
          R2 := Rect(H - R1.Bottom, R1.Left, H - R1.Top, R1.Right);
          TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect := R2;
        end;
      Exit;
    end;
  ButtonData := nil;
  CIndex := FSD.GetControlIndex('resizetoolbutton');
  if CIndex <> -1
  then
    ButtonData := TbsDataSkinButtonControl(FSD.CtrlList[CIndex]);
  if ButtonData = nil then Exit;
  //
  ButtonR := Rect(0, 0, FCloseSize, FCloseSize);
  //
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(ButtonR);
  Buffer.Height := RectHeight(ButtonR);
  //
  with ButtonData do
  begin
    XO := RectWidth(ButtonR) - RectWidth(SkinRect);
    YO := RectHeight(ButtonR) - RectHeight(SkinRect);
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
    if TbsSkinCustomTabSheet(Self.Pages[I]).ButtonMouseDown and
       TbsSkinCustomTabSheet(Self.Pages[I]).ButtonMouseIn
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, DBSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        Buffer.Canvas.Font.Color := DownFontColor;
      end
    else
    if TbsSkinCustomTabSheet(Self.Pages[I]).ButtonMouseIn
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, ABSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        Buffer.Canvas.Font.Color := ActiveFontColor;
      end
    else
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, BSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        Buffer.Canvas.Font.Color := FontColor;
      end;
   end;

  CIX := Buffer.Width div 2 - 5;
  CIY := Buffer.Height div 2 - 5;

  DrawCloseImage(Buffer.Canvas, CIX, CIY, Buffer.Canvas.Font.Color);

  X := R.Left;
  Y := R.Top + RectHeight(R) div 2 - Buffer.Height div 2;

  TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect := Rect(X, Y,
  X + Buffer.Width, Y + Buffer.Height);

  if (TabPosition = tpLeft) and not FTextInHorizontal
  then
    begin
      R1 := TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect;
      R2 := Rect(R1.Top, W - R1.Right, R1.Bottom, W - R1.Left);
      TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect := R2;
    end
  else
  if (TabPosition = tpRight) and not FTextInHorizontal
  then
    begin
      R1 := TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect;
      R2 := Rect(H - R1.Bottom, R1.Left, H - R1.Top, R1.Right);
      TbsSkinCustomTabSheet(Self.Pages[I]).ButtonRect := R2;
    end;

  Cnvs.Draw(X, Y, Buffer);
  Buffer.Free;
end;


procedure TbsSkinPageControl.SetShowCloseButtons(Value: Boolean);
begin
  if FShowCloseButtons <> Value
  then
    begin
      FShowCloseButtons := Value;
      if FShowCloseButtons
      then
        begin
          if TabPosition in [tpTop, tpBottom]
          then
            FTempImages.Width := FTempImages.Width + FCloseSize
          else
            FTempImages.Height := FTempImages.Height + FCloseSize
        end
      else
        begin
          if TabPosition in [tpTop, tpBottom]
          then
            FTempImages.Width := FTempImages.Width - FCloseSize
          else
            FTempImages.Height := FTempImages.Height - FCloseSize;
        end;
    end;
  Invalidate;
end;

procedure TbsSkinPageControl.SetImages(value: TCustomImageList);
begin
  if FImages <> nil then
  begin
    if TabPosition in [tpTop, tpBottom] then
      FTempImages.Width := FTempImages.Width - FImages.Width
    else
      FTempImages.Height := FTempImages.Height - FImages.Height;
  end;

  FImages := Value;

  if FImages <> nil then
  begin
    if TabPosition in [tpTop, tpBottom] then
      FTempImages.Width := FTempImages.Width + FImages.Width
    else // tpLeft, tpRight
      FTempImages.Height := FTempImages.Height + FImages.Height;
  end;

  Invalidate;
end;

procedure TbsSkinPageControl.WMCHECKPARENTBG;
begin
  if TabsBGTransparent then RePaint;
end;

procedure TbsSkinPageControl.DrawEmptyBackGround(DC: HDC);
var
  C: TCanvas;
  TabSheetBG, Buffer2: TBitMap;
  X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
begin
  if (Width <= 0) or (Height <=0) then Exit;

  C := TCanvas.Create;
  C.Handle := DC;

  if BGPictureIndex <> -1
  then
    begin
      TabSheetBG := TBitMap(FSD.FActivePictures.Items[BGPictureIndex]);

      if StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case StretchType of
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
    end
 else
   begin
     w1 := Width;
     h1 := Height;
     TabSheetBG := TBitMap.Create;
     TabSheetBG.Width := RectWidth(ClRect);
     TabSheetBG.Height := RectHeight(ClRect);
     TabSheetBG.Canvas.CopyRect(Rect(0, 0, TabSheetBG.Width, TabSheetBG.Height),
       Picture.Canvas,
        Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
             SkinRect.Left + ClRect.Right,
             SkinRect.Top + ClRect.Bottom));

      if StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case StretchType of
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
   end;
  C.Free;
end;


procedure TbsSkinPageControl.SetTabsBGTransparent(Value: Boolean);
begin
  if FTabsBGTransparent <> Value
  then
    begin
      FTabsBGTransparent := Value;
      Invalidate;
    end;
end;

procedure TbsSkinPageControl.UpDateTabs;
begin
  if FIndex <> -1
  then
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, RectHeight(TabRect))
      else
        SetItemSize(TabWidth, TabHeight);
    end
  else
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
    end;
  if MultiLine and (FSkinUpDown <> nil)
  then
    HideSkinUpDown;
  ReAlign;
end;

procedure TbsSkinPageControl.CMMouseLeave;
begin
  inherited;

  if FHideTabs then Exit;

  TestActive(-1, -1);

  if (FOldActiveTabIndex <> - 1) and (FOldActiveTabIndex <> TabIndex) and
     (FOldActiveTabIndex < PageCount)
  then
    begin
      FOldActiveTabIndex := -1;
      FOldActiveTab := -1;
      DrawTabs(Canvas);
    end;

  if (FActiveTabIndex <> - 1) and (FActiveTabIndex <> TabIndex) and
     (FActiveTabIndex < PageCount)
  then
    begin
      FActiveTabIndex := -1;
      FActiveTab := -1;
      DrawTabs(Canvas);
    end;
end;

procedure TbsSkinPageControl.MouseUp(Button: TMouseButton; Shift: TShiftState;
              X, Y: Integer); 
var
  R, BR: TRect;
begin
  inherited;

  if FHideTabs then Exit;

  if (Button = mbLeft) and not (csDesigning in ComponentState) and not (FTabsInCenter  or (FTabsOffset > 0))
  then
    TestActive(X, Y);

  if (FActiveTabIndex <> -1) and FShowCloseButtons and (Button = mbLeft)
  then
    with TbsSkinCustomTabSheet(Pages[FActiveTab]) do
    begin
      R := GetItemRect(FActiveTabIndex);
      BR := ButtonRect;
      if FTabsInCenter or (FTabsOffset > 0)
      then
        OffsetRect(BR, R.Left - GetItemOffset, R.Top)
      else
        OffsetRect(BR, R.Left, R.Top);
      if PtInRect(BR, Point(X, Y))
      then
        begin
          ButtonMouseIn := True;
          ButtonMouseDown := False;
          DrawTabs(Canvas);
          DoClose;
        end
      else
      if not PtInRect(BR, Point(X, Y))
      then
        begin
          ButtonMouseIn := False;
          ButtonMouseDown := False;
        end;
    end;
    
end;

procedure TbsSkinPageControl.MouseDown;
var
  R, BR: TRect;
begin
  inherited;

  if FHideTabs then Exit;

  if (Button = mbLeft) and not (csDesigning in ComponentState) and not (FTabsInCenter or  (FTabsOffset > 0))
  then
    TestActive(X, Y);

  if (FActiveTabIndex <> -1) and FShowCloseButtons and (Button = mbLeft)
  then
    with TbsSkinCustomTabSheet(Pages[FActiveTab]) do
    begin
      R := GetItemRect(FActiveTabIndex);
      BR := ButtonRect;
      if FTabsInCenter or (FTabsOffset > 0)
      then
        OffsetRect(BR, R.Left - GetItemOffset, R.Top)
      else
        OffsetRect(BR, R.Left, R.Top);
      if PtInRect(BR, Point(X, Y))
      then
        begin
          ButtonMouseIn := True;
          ButtonMouseDown := True;
          DrawTabs(Canvas); 
        end
      else
      if not PtInRect(BR, Point(X, Y))
      then
        begin
          ButtonMouseIn := False;
          ButtonMouseDown := False;
        end;
    end;
end;

procedure TbsSkinPageControl.MouseMove;
begin
 inherited;

 if FHideTabs then Exit;

 if  not (csDesigning in ComponentState)
 then
   TestActive(X, Y);
   
end;

procedure TbsSkinPageControl.SetDefaultItemHeight;
begin
  FDefaultItemHeight := Value;
  if FIndex = -1
  then
    begin
      SetItemSize(TabWidth, FDefaultItemHeight);
      Change2;
      ReAlign;
    end;
end;


procedure TbsSkinPageControl.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSkinPageControl.OnUpDownChange(Sender: TObject);
begin
  FSkinUpDown.Max := GetInVisibleItemCount;
  SendMessage(Handle, WM_HSCROLL,
    MakeWParam(SB_THUMBPOSITION, FSkinUpDown.Position), 0);
end;

function TbsSkinPageControl.GetPosition: Integer;
var
  i, j, k: Integer;
  R: TRect;
begin
  j := 0;
  k := -1;
  for i := 0 to PageCount - 1 do
  if Pages[i].TabVisible then
  begin
    inc(k);
    R := GetItemRect(k);
    if R.Right <= 0 then inc(j);
  end;
  Result := j;
end;

function TbsSkinPageControl.GetInVisibleItemCount;
var
  i, j, k: Integer;
  R: TRect;
  Limit: Integer;
begin
  Limit := Width - 3;
  j := 0;
  k := -1;
  for i := 0 to PageCount - 1 do
  if Pages[i].TabVisible
  then
  begin
    inc(k);
    R := GetItemRect(k);
    if (R.Right > Limit) or (R.Right <= 0)
    then inc(j);
  end;
  Result := j;
end;

procedure TbsSkinPageControl.CheckScroll;
var
  Wnd: HWND;
  InVCount: Integer;
begin
  Wnd := FindWindowEx(Handle, 0, 'msctls_updown32', nil);
  if Wnd <> 0 then DestroyWindow(Wnd);
  InVCount := GetInVisibleItemCount;
  if ((InVCount = 0) or MultiLine) and (FSkinUpDown <> nil)
  then
    HideSkinUpDown
  else
  if (InVCount > 0) and (FSkinUpDown = nil)
  then
    ShowSkinUpDown;
  if FSkinUpDown <> nil
  then
    begin
      FSkinUpDown.Max := InVCount;
      FSkinUpDown.Left := Width - FSkinUpDown.Width;
      if TabPosition = tpTop
      then
        begin
          if FIndex = -1
          then
            FSkinUpDown.Top := 0
          else
            FSkinUpDown.Top := DisplayRect.Top - FSkinUpDown.Height - ClRect.Top;
          if FSkinUpDown.Top < 0 then FSkinUpDown.Top := 0;
        end
      else
        begin
          if FIndex = -1
          then
            FSkinUpDown.Top := Height - FSkinUpDown.Height
          else
            FSkinUpDown.Top := DisplayRect.Bottom + (RectHeight(SkinRect) - ClRect.Bottom);
          if FSkinUpDown.Top > Height - FSkinUpDown.Height
          then
            FSkinUpDown.Top := Height - FSkinUpDown.Height;
        end;  
    end;
end;

procedure TbsSkinPageControl.ShowSkinUpDown;
begin
  if FHideTabs then Exit;
  FSkinUpDown := TbsSkinUpDown.Create(Self);
  FSkinUpDown.Parent := Self;
  FSkinUpDown.Width := FDefaultItemHeight * 2;
  FSkinUpDown.Height := FDefaultItemHeight;
  FSkinUpDown.Min := 0;
  FSkinUpDown.Max := GetInVisibleItemCount;
  FSkinUpDown.Position := GetPosition;
  FSkinUpDown.Increment := 1;
  FSkinUpDown.OnChange := OnUpDownChange;
  FSkinUpDown.Left := Width - FSkinUpDown.Width;
  FSkinUpDown.SkinDataName := UpDown;
  FSkinUpDown.SkinData := SkinData;
  if TabPosition = tpTop
  then
    begin
      if FIndex = -1
      then
        FSkinUpDown.Top := 0
      else
        FSkinUpDown.Top := DisplayRect.Top - FSkinUpDown.Height - ClRect.Top;
      if FSkinUpDown.Top < 0 then FSkinUpDown.Top := 0;
    end
  else
    begin
      if FIndex = -1
      then
        FSkinUpDown.Top := Height - FSkinUpDown.Height
      else
        FSkinUpDown.Top := DisplayRect.Bottom + (RectHeight(SkinRect) - ClRect.Bottom);
      if FSkinUpDown.Top > Height - FSkinUpDown.Height
      then
        FSkinUpDown.Top := Height - FSkinUpDown.Height;
    end;
  FSkinUpDown.Visible := True;
end;

procedure TbsSkinPageControl.HideSkinUpDown;
begin
  FSkinUpDown.Free;
  FSkinUpDown := nil;
end;

procedure TbsSkinPageControl.WMHSCROLL;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinPageControl.WMSize;
begin
  GetSkinData;
  inherited;
end;

procedure TbsSkinPageControl.Change;
begin
  if FSkinUpDown <> nil
  then FSkinUpDown.Position := GetPosition;
  inherited;
  Invalidate;
  if ActivePage <> nil then ActivePage.Invalidate;
end;

procedure TbsSkinPageControl.Change2;
begin
  if FSkinUpDown <> nil
  then FSkinUpDown.Position := GetPosition;
  Invalidate;
end;

procedure TbsSkinPageControl.GetSkinData;
begin
  BGPictureIndex := -1;
  if FSD = nil
  then
    begin
      FIndex := -1;
      Exit;
    end;
  if FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  //
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinTabControl
    then
      with TbsDataSkinTabControl(FSD.CtrlList.Items[FIndex]) do
      begin
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          Picture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          Picture := nil;
        Self.SkinRect := SkinRect;
        Self.ClRect := ClRect;
        Self.TabRect := TabRect;
        if IsNullRect(ActiveTabRect)
        then
          Self.ActiveTabRect := TabRect
        else
          Self.ActiveTabRect := ActiveTabRect;
        if IsNullRect(FocusTabRect)
        then
          Self.FocusTabRect := ActiveTabRect
        else
          Self.FocusTabRect := FocusTabRect;
        //
        Self.TabsBGRect := TabsBGRect;
        Self.LTPoint := LTPoint;
        Self.RTPoint := RTPoint;
        Self.LBPoint := LBPoint;
        Self.RBPoint := RBPoint;
        Self.TabLeftOffset := TabLeftOffset;
        Self.TabRightOffset := TabRightOffset;
        //
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.ActiveFontColor := ActiveFontColor;
        Self.FocusFontColor := FocusFontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.UpDown := UpDown;
        Self.BGPictureIndex := BGPictureIndex;
        Self.MouseInTabRect := MouseInTabRect;
        Self.MouseInFontColor := MouseInFontColor;
        Self.TabStretchEffect := TabStretchEffect;
        Self.ShowFocus := ShowFocus;
        Self.FocusOffsetX := FocusOffsetX;
        Self.FocusOffsetY := FocusOffsetY;
        Self.LeftStretch := LeftStretch;
        Self.TopStretch := TopStretch;
        Self.RightStretch := RightStretch;
        Self.BottomStretch := BottomStretch;
        Self.StretchEffect := StretchEffect;
        Self.StretchType := StretchType;
        //
        Self.CloseButtonRect := CloseButtonRect;
        Self.ClosebuttonActiveRect := ClosebuttonActiveRect;
        Self.CloseButtonDownRect := CloseButtonDownRect;
        if IsNullRect(ClosebuttonActiveRect)
          then ClosebuttonActiveRect:= CloseButtonRect;
        if IsNullRect(CloseButtonDownRect)
          then ClosebuttonDownRect:= CloseButtonActiveRect;
        //
       Self.ButtonTransparent := ButtonTransparent;
       Self.ButtonTransparentColor := ButtonTransparentColor;
       Self.TabLeftBottomActiveRect := TabLeftBottomActiveRect;
       Self.TabLeftBottomFocusRect := TabLeftBottomFocusRect;
       if IsNullRect(Self.TabLeftBottomFocusRect)
       then
         Self.TabLeftBottomFocusRect := Self.TabLeftBottomActiveRect;
      end;
end;

procedure TbsSkinPageControl.ChangeSkinData;
begin
  GetSkinData;
  //
  if FShowCloseButtons
  then
    begin
      if TabPosition in [tpTop, tpBottom]
      then
        FTempImages.Width := FTempImages.Width - FCloseSize
      else
        FTempImages.Height := FTempImages.Height - FCloseSize;
      FCloseSize := GetCloseSize;
      if TabPosition in [tpTop, tpBottom]
      then
        FTempImages.Width := FTempImages.Width + FCloseSize
      else
        FTempImages.Height := FTempImages.Height + FCloseSize;
    end;
  //
  if FIndex <> -1
  then
    begin
      if FUseSkinFont
      then
        begin
          Font.Name := FontName;
          Font.Height := FontHeight;
          Font.Style := FontStyle;
        end
      else
        Font.Assign(FDefaultFont);

      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet
       else
        Font.CharSet := DefaultFont.CharSet;

      Font.Color := FontColor;
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, RectHeight(TabRect))
      else
        SetItemSize(TabWidth, TabHeight);
    end
  else
    begin
      Font.Assign(FDefaultFont);
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet;

      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
    end;
  //
  Change2;
  ReAlign;
  //
  if FSkinUpDown <> nil
  then
    begin
      HideSkinUpDown;
      CheckScroll;
    end;
  //
  if ActivePage <> nil then ActivePage.RePaint;
end;

procedure TbsSkinPageControl.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then
  if not FSD.Empty and not (csDesigning in ComponentState)
  then
    ChangeSkinData;
end;

procedure TbsSkinPageControl.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FImages) then FImages := nil;
end;

procedure TbsSkinPageControl.PaintDefaultWindow;
var
  R: TRect;
begin
  with Cnvs do
  begin
    Brush.Color := clBtnFace;
    FillRect(ClientRect);
    R := Self.DisplayRect;
    if not FHideBorder then
    begin
      InflateRect(R, 1, 1);
      Frame3D(Cnvs, R, clBtnShadow, clBtnShadow, 1);
    end;
  end;
end;

function TbsSkinPageControl.GetActiveTabRect: TRect;
var
  IR: TRect;
  YO: Integer;
begin
  IR := NullRect;
  YO := RectHeight(ActiveTabRect) - RectHeight(TabRect);
  if (TabIndex <> -1) and (TabIndex >= 0) and (TabIndex < PageCount) and
     (PageCount > 0) and (CheckVisibleTabs) and (ActivePage <> nil)
  then
    begin
      IR := GetItemRect(TabIndex);
      case TabPosition of
        tpTop: Inc(IR.Bottom, YO);
        tpLeft: Inc(IR.Right, YO);
        tpRight: Dec(IR.Left, YO);
        tpBottom: Dec(IR.Top, YO);
      end;
    end;
  Result := IR;
end;

procedure TbsSkinPageControl.PaintSkinWindow;
var
  TOff, LOff, Roff, BOff, SaveIndex: Integer;
  NewClRect, DR, R: TRect;
  TBGOffX, TBGOffY, X, Y, XCnt, YCnt, w, h, rw, rh, XO, YO: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  LB, RB, TB, BB, ClB: TBitMap;
  R1, R2, IR: TRect;
begin
  if FHideBorder then Exit;
  GetSkinData;
  TOff := ClRect.Top;
  LOff := ClRect.Left;
  ROff := RectWidth(SkinRect) - ClRect.Right;
  BOff := RectHeight(SkinRect) - ClRect.Bottom;
  //
  DR := Self.DisplayRect;
  //
  R := Rect(DR.Left - LOff, DR.Top - TOff, DR.Right + ROff, DR.Bottom + BOff);
  XO := RectWidth(R) - RectWidth(SkinRect);
  YO := RectHeight(R) - RectHeight(SkinRect);
  NewLTPoint := LTPoint;
  NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
  NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
  NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
  NewCLRect := Rect(ClRect.Left, ClRect.Top, ClRect.Right + XO, ClRect.Bottom + YO);
  // Draw frame around displayrect
  LB := TBitMap.Create;
  TB := TBitMap.Create;
  RB := TBitMap.Create;
  BB := TBitMap.Create;
  CreateSkinBorderImages(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
     NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewClRect,
     LB, TB, RB, BB, Picture, SkinRect, RectWidth(R), RectHeight(R),
     LeftStretch, TopStretch, RightStretch, BottomStretch);
  //
  SaveIndex := -1;
  IR := GetActiveTabRect;
  if not IsNullRect(IR) and not FHideTabs and (Style = tsTabs)
  then
    begin
      SaveIndex := SaveDC(Cnvs.Handle);
      ExcludeClipRect(Cnvs.Handle, IR.Left, IR.Top, IR.Right, IR.Bottom)
    end;
  //
  Cnvs.Draw(R.Left, R.Top, TB);
  Cnvs.Draw(R.Left, R.Top + TB.Height, LB);
  Cnvs.Draw(R.Left + RectWidth(R) - RB.Width, R.Top + TB.Height, RB);
  Cnvs.Draw(R.Left, R.Top + RectHeight(R) - BB.Height, BB);
  if SaveIndex <> -1 then RestoreDC(Cnvs.Handle, SaveIndex);
  LB.Free;
  TB.Free;
  RB.Free;
  BB.Free;
end;


procedure TbsSkinPageControl.Loaded;
begin
  inherited Loaded;
  if FIndex = -1
  then
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
      Change2;
      ReAlign;
    end;
end;

procedure TbsSkinPageControl.WMPaint(var Msg: TWMPaint);
begin
  if PageCount = 0
  then
    begin
      PaintHandler(Msg);
    end
  else
    inherited;
end;

function TbsSkinPageControl.CheckVisibleTabs: Boolean;
var
  i: Integer;
begin
  Result := False;
  if PageCount = 0
  then
    Result := False
  else
    begin
      for i := 0 to PageCount - 1 do
      begin
        if Pages[i].TabVisible
        then
          begin
            Result := True;
            Break;
          end;
      end;
    end;
end;

procedure TbsSkinPageControl.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
  if (PageCount = 0) or (not CheckVisibleTabs)
  then
    begin
      GetSkinData;
      if FIndex = -1
      then
        inherited
      else
        DrawEmptyBackGround(Msg.DC);
    end
  else
    begin
      Msg.Result := 1;
    end;
end;


procedure TbsSkinPageControl.WndProc(var Message:TMessage);
var
  TOff, LOff, Roff, BOff: Integer;
begin
  if (Message.Msg = WM_SETFOCUS) and (FTabsInCenter  or (FTabsOffset > 0))
  then
    begin
      inherited WndProc(Message);
      Invalidate;
    end
  else
  if (Message.Msg = WM_KILLFOCUS) and (FTabsInCenter  or (FTabsOffset > 0))
  then
    begin
      inherited WndProc(Message);
      Invalidate;
    end
  else
  if (Message.Msg = WM_LButtonDblClk) and (FTabsInCenter  or (FTabsOffset > 0))
  then
    begin
      TWMLButtonDblClk(Message).Pos.X := TWMLButtonDblClk(Message).Pos.X - GetItemOffset;
      inherited WndProc(Message);
    end
  else
  if (Message.Msg = WM_LButtonUp) and (FTabsInCenter  or (FTabsOffset > 0)) 
  then
    begin
      TWMLButtonUp(Message).Pos.X := TWMLButtonUp(Message).Pos.X - GetItemOffset;
      inherited WndProc(Message);
    end
  else
  if (Message.Msg = WM_LButtonDown) and (FTabsInCenter  or (FTabsOffset > 0)) 
  then
    begin
      TWMLButtonDown(Message).Pos.X := TWMLButtonDown(Message).Pos.X - GetItemOffset;
      inherited WndProc(Message);
    end
  else
  if (Message.Msg = WM_NCHITTEST) and (FTabsInCenter  or (FTabsOffset > 0)) 
  then
    begin
      TWMNCHITTEST(Message).Pos.X := TWMNCHITTEST(Message).Pos.X - GetItemOffset;
      inherited WndProc(Message);
    end
  else
  if Message.Msg = TCM_ADJUSTRECT
  then
    begin
      inherited WndProc(Message);
      if FHideBorder
      then
        begin
          PRect(Message.LParam)^.Left := 0;
          PRect(Message.LParam)^.Top := -2;
          PRect(Message.LParam)^.Right := Width;
          PRect(Message.LParam)^.Bottom := Height;
        end
      else
      if FIndex <> -1
      then
        begin
          TOff := ClRect.Top;
          LOff := ClRect.Left;
          ROff := RectWidth(SkinRect) - ClRect.Right;
          BOff := RectHeight(SkinRect) - ClRect.Bottom;
        end;
      if not FHideBorder then 
      case TabPosition of
        tpLeft:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left + LOff - 4;
               PRect(Message.LParam)^.Right := ClientWidth - ROff;
               {$IFNDEF VER130}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
               {$ELSE}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               {$ENDIF}
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
               if FHideTabs then PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 1;
             end
           else
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 3;
               PRect(Message.LParam)^.Right := ClientWidth - 1;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
               if FHideTabs then PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 1;
             end;
        tpRight:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := LOff;
               PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - ROff + 4;
               {$IFNDEF VER130}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
               {$ELSE}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               {$ENDIF}
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
               if FHideTabs then PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right + 1;
             end
           else
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 3;
               PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right + 3;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
               if FHideTabs then PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right + 1;
             end;
        tpTop:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := LOff;
               PRect(Message.LParam)^.Right := ClientWidth - ROff;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
               if FHideTabs then PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 1;
             end
           else
             begin
               PRect(Message.LParam)^.Left := 1;
               PRect(Message.LParam)^.Right := ClientWidth - 1;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
               if FHideTabs then PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 1;
             end;
        tpBottom:
          if FIndex <> -1
          then
            begin
              PRect(Message.LParam)^.Left := LOff;
              PRect(Message.LParam)^.Right := ClientWidth - ROff;
              {$IFNDEF VER130}
              PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
              {$ELSE}
              PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
              {$ENDIF}
              PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 4 - BOff;
              if FHideTabs then PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 1;
            end
          else
            begin
              PRect(Message.LParam)^.Left := 1;
              PRect(Message.LParam)^.Right := ClientWidth - 1;
              PRect(Message.LParam)^.Top := 1;
              PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 3;
            end;

      end;
    end
  else
    if Message.Msg = TCM_GETITEMRECT
    then
      begin
        inherited WndProc(Message);
        if Style = tsTabs
        then
          case TabPosition of
            tpLeft:
                begin
                  PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                  PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                end;
            tpRight:
                begin
                  PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left + 2;
                  PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right + 2;
                end;

            tpTop:
                begin
                  if not MultiLine
                  then
                    begin
                      PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                      PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                    end;
                  PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 2;
                  PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom - 2;
                  if (FTabsInCenter  or (FTabsOffset > 0))
                  then
                    OffsetRect(PRect(Message.LParam)^, GetItemOffset, 0);
                end;
            tpBottom:
                begin
                  if not MultiLine
                  then
                    begin
                      PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                      PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                    end;
                  PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top + 2;
                  PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 2;
                end;
          end;
      end
  else
  inherited WndProc(Message);
  if (Message.Msg = WM_SIZE) and (not MultiLine) and
     not (csDesigning in ComponentState)
  then
    begin
      CheckScroll;
    end;
end;

function TbsSkinPageControl.GetItemRect(index: integer): TRect;
var
  R: TRect;
begin
  SendMessage(Handle, TCM_GETITEMRECT, index, Integer(@R));
  Result := R;
end;

procedure TbsSkinPageControl.SetItemSize;
begin
  SendMessage(Handle, TCM_SETITEMSIZE, 0, MakeLParam(AWidth, AHeight));
end;

procedure TbsSkinPageControl.PaintWindow(DC: HDC);
var
  SaveIndex: Integer;
begin
  if (Width <= 0) or (Height <=0) then Exit;
  GetSkinData;
  SaveIndex := SaveDC(DC);
  try
    Canvas.Handle := DC;
    if FIndex = -1
    then
      PaintDefaultWindow(Canvas)
    else
      PaintSkinWindow(Canvas);
    DrawTabs(Canvas);
    Canvas.Handle := 0;
  finally
    RestoreDC(DC, SaveIndex);
  end;
end;

procedure TbsSkinPageControl.TestActive(X, Y: Integer);
var
  i, j, k: Integer;
  R: TRect;
  BR: TRect;
begin
  if FHideTabs then Exit;

  FOldActiveTab := FActiveTab;
  FOldActiveTabIndex := FActiveTabIndex;
  FActiveTab := -1;
  FActiveTabIndex := -1;
  k := -1;
  j := -1;
  for i := 0 to PageCount - 1 do
  if Pages[i].TabVisible then
  begin
    Inc(k);
    R := GetItemRect(k);
    if PtInRect(R, Point(X, Y))
    then
      begin
        j := k;
        Break;
      end;
  end;

  FActiveTab := i;
  FActiveTabIndex := j;

  if (FOldActiveTabIndex <> FActiveTabIndex)
  then
    begin
      if (FOldActiveTabIndex <> - 1) and (FOldActiveTabIndex <> TabIndex) and
         (FOldActiveTabIndex < PageCount)
      then
        begin
          R := GetItemRect(FOldActiveTabIndex);
          TbsSkinCustomTabSheet(Pages[FOldActiveTab]).ButtonMouseIn := False;
          TbsSkinCustomTabSheet(Pages[FOldActiveTab]).ButtonMouseDown := False;
          DrawTabs(Canvas);
        end;
      if (FActiveTabIndex <> -1) and (FActiveTabIndex <> TabIndex) and
         (FActiveTabIndex < PageCount)
      then
        begin
          R := GetItemRect(FActiveTabIndex);
          DrawTabs(Canvas);
        end;
    end;

  if (FActiveTabIndex <> -1) and FShowCloseButtons
  then
    with TbsSkinCustomTabSheet(Pages[FActiveTab]) do
    begin
      R := GetItemRect(FActiveTabIndex);
      BR := ButtonRect;
      OffsetRect(BR, R.Left, R.Top);
      if PtInRect(BR, Point(X, Y)) and not ButtonMouseIn
      then
        begin
          ButtonMouseIn := True;
          DrawTabs(Canvas);
        end
      else
      if not PtInRect(BR, Point(X, Y)) and ButtonMouseIn
      then
        begin
         ButtonMouseIn := False;
         ButtonMouseDown := False;
         DrawTabs(Canvas);  
       end;
    end;
end;

procedure TbsSkinPageControl.DrawTabs;
var
  i, j: integer;
  IR: TRect;
  w, h, XCnt, YCnt, X, Y, TOff, LOff, Roff, BOff, YO: Integer;
  Rct, R, DR: TRect;
  Buffer, Buffer2: TBitMap;
  ATabIndex, SaveIndex: Integer;
begin
  if FHideTabs
  then
    begin
      Exit;
    end;
  //
  if (PageCount = 0) then Exit;
  
  if FIndex = -1
  then
    begin
      j := -1;
      for i := 0 to PageCount-1 do
      if Pages[i].TabVisible then
      begin
        inc(j);
        R := GetItemRect(j);
        DrawTab(i, R, (j = TabIndex), j = FActiveTabIndex, Cnvs);
      end;
      Exit;
    end;
  //
  GetSkinData;
  TOff := ClRect.Top;
  LOff := ClRect.Left;
  ROff := RectWidth(SkinRect) - ClRect.Right;
  BOff := RectHeight(SkinRect) - ClRect.Bottom;
  DR := Self.DisplayRect;
  R := Rect(DR.Left - LOff, DR.Top - TOff, DR.Right + ROff, DR.Bottom + BOff);
  Buffer := TBitMap.Create;
  case TabPosition of
    tpTop:
      begin
        Buffer.Width := Width;
        Buffer.Height := R.Top;
      end;
    tpBottom:
      begin
        Buffer.Width := Width;
        Buffer.Height := Height - R.Bottom;
      end;
    tpRight:
      begin
        Buffer.Width := Width - R.Right;
        Buffer.Height := Height;
      end;
    tpLeft:
      begin
        Buffer.Width := R.Left;
        Buffer.Height := Height;
      end;
  end;
  // draw tabsbg
  if IsNullRect(TabsBGRect)
  then
    begin
      TabsBGRect := ClRect;
      OffsetRect(TabsBGRect, SkinRect.Left, SkinRect.Top);
    end;
  w := RectWidth(TabsBGRect);
  h := RectHeight(TabsBGRect);
  XCnt := Buffer.Width div w;
  YCnt := Buffer.Height div h;
  if not TabsBGTransparent
  then
    begin
      Buffer2 := TBitMap.Create;
      Buffer2.Width := w;
      Buffer2.Height := h;
      Buffer2.Canvas.CopyRect(Rect(0, 0, w, h), Picture.Canvas, TabsBGRect);
      for X := 0 to XCnt do
      for Y := 0 to YCnt do
      begin
       Buffer.Canvas.Draw(X * w, Y * h, Buffer2);
      end;
      Buffer2.Free;
    end
  else
    begin
      case TabPosition of
        tpTop:
          Rct := Rect(0, 0, Width, R.Top);
        tpBottom:
          Rct := Rect(0, R.Bottom, Width, Height);
        tpRight:
          Rct := Rect(R.Right, 0, Width, Height);
        tpLeft:
          Rct := Rect(0, 0, R.Left, R.Bottom);
      end;
      GetParentImageRect(Self, Rct, Buffer.Canvas);
    end;
  //
  j := -1;
  ATabIndex := 0;
  for i := 0 to PageCount-1 do
  if Pages[I].TabVisible then
  begin
    inc(j);
    IR := GetItemRect(j);
    case TabPosition of
    tpTop:
      begin
      end;
    tpBottom:
      begin
        OffsetRect(IR, 0, -R.Bottom);
      end;
    tpRight:
      begin
        OffsetRect(IR, - R.Right, 0);
      end;
    tpLeft:
      begin
                            
      end;
     end;
    if j <> TabIndex then
    DrawTab(i, IR, (j = TabIndex), j = FActiveTabIndex, Buffer.Canvas);
    if j = TabIndex then ATabIndex := i;
  end;

  SaveIndex := -1;
  IR := GetActiveTabRect;
  if not IsNullRect(IR) and not FHideTabs
  then
    begin
      SaveIndex := SaveDC(Cnvs.Handle);
      ExcludeClipRect(Cnvs.Handle, IR.Left, IR.Top, IR.Right, IR.Bottom);
    end;

 case TabPosition of
    tpTop:
      begin
        Cnvs.Draw(0, 0, Buffer);
      end;
    tpBottom:
      begin
        Cnvs.Draw(0, Height - Buffer.Height, Buffer);
      end;
    tpRight:
      begin
        Cnvs.Draw(Width - Buffer.Width, 0, Buffer);
      end;
    tpLeft:
      begin
        Cnvs.Draw(0, 0, Buffer);
      end;
  end;

  Buffer.Free;

  if SaveIndex <> -1 then RestoreDC(Cnvs.Handle, SaveIndex);

  if (ATabIndex <> -1) and (TabIndex <> -1) and (TabIndex >= 0) and (TabIndex < PageCount)
  then
    begin
      IR := GetItemRect(TabIndex);
      if (FIndex <> -1) and (RectHeight(TabRect) <> RectHeight(ActiveTabRect))
      then
        begin
          YO := RectHeight(ActiveTabRect) - RectHeight(TabRect);
          if Style <> tsTabs then YO := 0;
          if (TabPosition = tpBottom) then OffsetRect(IR, 0, -YO) else
          if (TabPosition = tpRight) then OffsetRect(IR, -YO, 0);
        end;
      DrawTab(ATabIndex, IR, True, TabIndex = FActiveTabIndex, Cnvs);
    end;
end;

procedure TbsSkinPageControl.DrawTab;
var
  R, R1, DR, DRClRect, R2, TR1, TR2: TRect;
  S: String;
  TB: TBitMap;
  DrawGlyph: Boolean;
  fx, W, H: Integer;
  CloseOffset: Integer;
  fx2: Integer;
  FC: TColor;
begin
  if FHideTabs then Exit;
  if TI > PageCount - 1 then Exit;
  DrawGlyph := (Images <> nil) and (Pages[TI].ImageIndex >= 0) and
    (Pages[TI].ImageIndex < Images.Count);
  S := Pages[TI].Caption;
  if (TabPosition = tpTop) or (TabPosition = tpBottom)
  then
    begin
      W := RectWidth(Rct);
      H := RectHeight(Rct);
    end
  else
    begin
      H := RectWidth(Rct);
      W := RectHeight(Rct);
    end;
  if (W <= 0) or (H <= 0) then Exit;
  TB := TBitMap.Create;
  TB.Width := W;
  TB.Height := H;
  R := Rect(0, 0, W, H);
  if FIndex <> -1
  then
    begin
      if Style <> tsTabs
      then
        begin
          DrawButton(TB, Active, MouseIn);
          FC := TB.Canvas.Font.Color;
        end
      else
      if TabHeight <= 0
      then
        begin
          if MouseIn and not Active and not IsNullRect(MouseInTabRect)
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             TB, Picture, MouseInTabRect, W, H, TabStretchEffect)
          else
            if Active and Focused
          then
           CreateHSkinImage(TabLeftOffset, TabRightOffset,
            TB, Picture, FocusTabRect, W, H, TabStretchEffect)
          else
          if Active
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
              TB, Picture, ActiveTabRect, W, H, TabStretchEffect)
          else
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             TB, Picture, TabRect, W, H, TabStretchEffect);

         if Active and (Rct.Left = 0) and not IsNullRect(TabLeftBottomActiveRect) and
            not Multiline and ((TabPosition = tpTop) or (TabPosition = tpBottom))
         then
           begin
             if Focused
             then TR1 := TabLeftBottomFocusRect
             else TR1 := TabLeftBottomActiveRect;
             TR2 := Rect(0, TB.Height - RectHeight(TR1),
                         RectWidth(TR1), TB.Height);
             TB.Canvas.CopyRect(TR2, Picture.Canvas, TR1);
           end;
           
       end
     else
       begin
         if MouseIn and not Active and not IsNullRect(MouseInTabRect)
          then
            DR := MouseInTabRect
          else
            if Active and Focused
          then
            DR := FocusTabRect
          else
          if Active
          then
            DR := ActiveTabRect
          else
            DR := TabRect;

         fx := RectHeight(TabRect) div 4;

         TB.Width := W;
         TB.Height := H;

         if (RectHeight(TabRect) < RectHeight(ActiveTabRect)) and Active
         then
           TB.Height := TB.Height + (RectHeight(ActiveTabRect) - RectHeight(TabRect))
         else
         if (RectHeight(TabRect) < RectHeight(FocusTabRect)) and
            Active and Focused
         then
           TB.Height := TB.Height + (RectHeight(FocusTabRect) - RectHeight(TabRect));

         DRClRect := Rect(TabLeftOffset, fx,
          RectWidth(DR) - TabRightOffset,  RectHeight(DR) - fx);

         CreateStretchImage(TB, Picture, DR, DRClRect, True);

         if Active and (Rct.Left = 0) and not IsNullRect(TabLeftBottomActiveRect) and
            not Multiline and ((TabPosition = tpTop) or (TabPosition = tpBottom))
         then
           begin
             if Focused
             then TR1 := TabLeftBottomFocusRect
             else TR1 := TabLeftBottomActiveRect;
             TR2 := Rect(0, TB.Height - RectHeight(TR1),
                         RectWidth(TR1), TB.Height);
             TB.Canvas.CopyRect(TR2, Picture.Canvas, TR1);
           end;

       end;

      if TabPosition = tpBottom then DrawFlipVert(TB);

      with TB.Canvas do
      begin
        Brush.Style := bsClear;
        if FUseSkinFont
        then
          begin
            Font.Name := FontName;
            Font.Style := FontStyle;
            Font.Height := FontHeight;
          end
        else
           Font.Assign(Self.Font);
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.Charset := SkinData.ResourceStrData.CharSet
        else
          Font.CharSet := Self.Font.CharSet;
        if Style <> tsTabs
        then
          Font.Color := FC
        else
        if MouseIn and not Active
        then
          Font.Color := MouseInFontColor
        else
        if Active and Focused
        then
          Font.Color := FocusFontColor
        else
          if Active
          then Font.Color := ActiveFontColor
          else Font.Color := FontColor;
      end;
    end
  else
    begin
      TB.Width := W;
      TB.Height := H;
      if MouseIn and not Active
      then
        begin
          TB.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          TB.Canvas.FillRect(R);
        end
      else
      if Active and Focused
      then
        begin
          Frame3D(TB.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          TB.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          TB.Canvas.FillRect(R);
        end
      else
      if Active
      then
        begin
          Frame3D(TB.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          TB.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          TB.Canvas.FillRect(R);
        end
      else
        begin
          TB.Canvas.Brush.Color := clBtnFace;
          TB.Canvas.FillRect(R);
        end;
      with TB.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Assign(Self.Font);
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.Charset := SkinData.ResourceStrData.CharSet;
      end;
    end;
  //
  if (TabPosition = tpLeft) and FTextInHorizontal
  then
    begin
      DrawRotate90_1_H(TB);
      R := Rect(0, 0, TB.Width, TB.Height);
    end
  else
  if (TabPosition = tpRight) and FTextInHorizontal
  then
    begin
      DrawRotate90_2_H(TB);
      R := Rect(0, 0, TB.Width, TB.Height);
    end;
  //
  if (FIndex <> -1) and ShowFocus and Focused and Active
  then
    begin
      R1 := R;
      InflateRect(R1, -FocusOffsetX, -FocusOffsetY);
      TB.Canvas.Brush.Style := bsSolid;
      TB.Canvas.Brush.Color := FSD.SkinColors.cBtnFace;
      DrawSkinFocusRect(TB.Canvas, R1);
      TB.Canvas.Brush.Style := bsClear;
    end;
  //
  fx2 := 0;
  if (FIndex <> -1) and (RectHeight(TabRect) <> RectHeight(ActiveTabRect)) and
     not Active
  then
    begin
      if (TabPosition = tpTop) or (TabPosition = tpLeft)
      then
        begin
          R.Top := R.Top + 2;
          if DrawGlyph then fx2 := 2;
        end
      else
        begin
          R.Top := R.Top - 2;
          if DrawGlyph then fx2 := - 2;
        end;
    end;
  //
  if FShowCloseButtons then CloseOffset := FCloseSize + 2  else CloseOffset := 0;
  if Assigned(Self.FOnDrawSkinTab)
  then
    begin
      FOnDrawSkinTab(TI, Rect(0, 0, TB.Width, TB.Height), Active, MouseIn, TB.Canvas);
    end
  else
  if DrawGlyph or FTabExtendedDraw
  then
    begin
      R2 := R;
      R2.Right := R2.Right - CloseOffset;
      if not FTabExtendedDraw
      then
        DrawTabGlyphAndText(TB.Canvas, TB.Width - CloseOffset, TB.Height, S,
                            Images, Pages[TI].ImageIndex, Pages[TI].Enabled, fx2)
      else
        DrawImageAndText(TB.Canvas, R2,
         FTabMargin, FTabSpacing, FTabLayout, S,  Pages[TI].ImageIndex, Images, False,  Pages[TI].Enabled,
          False, 0);

      if CloseOffset <> 0
      then
        if FIndex <> -1 then R.Right := R.Right - CloseOffset - 3 else
          R.Right := R.Right - CloseOffset;
     end
  else
    begin
      if CloseOffset <> 0
      then
        if FIndex <> -1 then R.Right := R.Right - CloseOffset - 3 else
          R.Right := R.Right - CloseOffset;
      DrawText(TB.Canvas.Handle, PChar(S), Length(S), R, DT_CENTER or DT_SINGLELINE or DT_VCENTER);
    end;

  if FShowCloseButtons
  then
    begin
      if not MouseIn
      then
        begin
          TbsSkinCustomTabSheet(Pages[TI]).ButtonMouseIn := False;
        end;
      DrawCloseButton(TB.Canvas, Rect(R.Right, R.Top + fx2, TB.Width, R.Bottom), TI,
       TB.Width, TB.Height);
    end;

  if (TabPosition = tpLeft) and not FTextInHorizontal
  then
    DrawRotate90_1(Cnvs, TB, Rct.Left, Rct.Top)
  else
  if (TabPosition = tpRight) and not FTextInHorizontal
  then
    DrawRotate90_2(Cnvs, TB, Rct.Left, Rct.Top)
  else
    Cnvs.Draw(Rct.Left, Rct.Top, TB);
  TB.Free;
end;


{ TbsSkinTabControl }

constructor TbsSkinTabControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //
  FImages := nil;
  FTempImages := TCustomImageList.Create(self);
  FTempImages.Width := 1;
  FTempImages.Height := 1;
  inherited Images := FTempImages;
  //
  FTabExtendedDraw := False;
  FTabMargin := -1;
  FTabSpacing := 1;
  FTabLayout := blGlyphLeft;
  FTextInHorizontal := False;
  //
  FTabsBGTransparent := False;
  FromWMPaint := False;
  Ctl3D := False;
  FIndex := -1;
  Picture := nil;
  Font.Name := 'Arial';
  Font.Style := [];
  Font.Color := clBtnText;
  Font.Height := 14;
  FOldTop := 0;
  FOldBottom := 0;
  FSkinUpDown := nil;
  FSkinDataName := 'tab';
  FDefaultFont := TFont.Create;
  FDefaultFont.Name := 'Arial';
  FDefaultFont.Style := [];
  FDefaultFont.Color := clBtnText;
  FDefaultFont.Height := 14;
  FDefaultItemHeight := 20;
  FUseSkinFont := True;
  TabStretchEffect := False;
  StretchEffect := False;
  FCloseSize := CLOSE_SIZE;
end;


procedure TbsSkinTabControl.SetTextInHorizontal;
begin
  FTextInHorizontal := Value;
  Invalidate;
end;

procedure TbsSkinTabControl.SetTabExtendedDraw;
begin
  FTabExtendedDraw := Value;
  Invalidate;
end;

procedure TbsSkinTabControl.SetTabLayout;
begin
  if FTabLayout <> Value
  then
    begin
      FTabLayout := Value;
      RePaint;
    end;
end;

procedure TbsSkinTabControl.SetTabSpacing;
begin
  if Value <> FTabSpacing
  then
    begin
      FTabSpacing := Value;
      RePaint;
    end;
end;

procedure TbsSkinTabControl.SetTabMargin;
begin
  if (Value <> FTabMargin) and (Value >= -1)
  then
    begin
      FTabMargin := Value;
      RePaint;
    end;
end;

procedure TbsSkinTabControl.DoClose;
var
  I: Integer;
  CanClose: Boolean;
  P: TPoint;
begin
  I := TabIndex;
  if I = -1 then Exit;
  CanClose := True;
  if Assigned(FOnClose) then FOnClose(I, CanClose);
  if CanClose
  then
    begin
      Tabs.Delete(I);
      Invalidate;
      if Assigned(FOnAfterClose) then FOnAfterClose(Self);
    end;
  if CanClose = False
  then
    begin
      GetCursorPos(P);
      if Windows.WindowFromPoint(P) <> Self.Handle
      then
        begin
          TabButtonMouseIn[I] := False;
          TabButtonMouseDown[I] := False;
          DrawTabs(Canvas);
        end;
    end;     
end;

procedure TbsSkinTabControl.SetShowCloseButtons(Value: Boolean);
var
  I: Integer;
begin
  if Value
  then
    begin
      SetLength(TabButtonMouseDown, 255);
      SetLength(TabButtonMouseIn, 255);
      SetLength(TabButtonR, 255);
      for I := 0 to 254 do TabButtonMouseIn[I] := False;
      for I := 0 to 254 do TabButtonMouseDown[I] := False;
      for I := 0 to 254 do TabButtonR[I] := Rect(0, 0, 0, 0);
    end
  else
    begin
      SetLength(TabButtonMouseDown, 0);
      SetLength(TabButtonMouseIn, 0);
      SetLength(TabButtonR, 0);
    end;

  if FShowCloseButtons <> Value
  then
    begin
      FShowCloseButtons := Value;
      if FShowCloseButtons
      then
        begin
          if TabPosition in [tpTop, tpBottom]
          then
            FTempImages.Width := FTempImages.Width + FCloseSize
          else
            FTempImages.Height := FTempImages.Height + FCloseSize
        end
      else
        begin

          if TabPosition in [tpTop, tpBottom]
          then
            FTempImages.Width := FTempImages.Width - FCloseSize
          else
            FTempImages.Height := FTempImages.Height - FCloseSize;
        end;
    end;
  Invalidate;
end;

procedure TbsSkinTabControl.SetImages(value: TCustomImageList);
begin
  if FImages <> nil then
  begin
    if TabPosition in [tpTop, tpBottom] then
      FTempImages.Width := FTempImages.Width - FImages.Width
    else
      FTempImages.Height := FTempImages.Height - FImages.Height;
  end;

  FImages := Value;

  if FImages <> nil then
  begin
    if TabPosition in [tpTop, tpBottom] then
      FTempImages.Width := FTempImages.Width + FImages.Width
    else // tpLeft, tpRight
      FTempImages.Height := FTempImages.Height + FImages.Height;
  end;

  Invalidate;
end;

function TbsSkinTabControl.GetCloseSize;
begin
  if (FIndex <> -1) and not IsNullRect(CloseButtonRect)
  then
    Result := RectWidth(CloseButtonRect)
  else
    Result := CLOSE_SIZE;
end;


function TbsSkinTabControl.GetActiveTabRect: TRect;
var
  IR: TRect;
  YO: Integer;
begin
  IR := NullRect;
  YO := RectHeight(ActiveTabRect) - RectHeight(TabRect);
  if (TabIndex <> -1) and (TabIndex >= 0) and (Tabs.Count > 0)
  then
    begin
      IR := GetItemRect(TabIndex);
      case TabPosition of
        tpTop: Inc(IR.Bottom, YO);
        tpLeft: Inc(IR.Right, YO);
        tpRight: Dec(IR.Left, YO);
        tpBottom: Dec(IR.Top, YO);
      end;
    end;
  Result := IR;
end;

procedure TbsSkinTabControl.WMCHECKPARENTBG;
begin
  if TabsBGTransparent then RePaint;
end;

procedure TbsSkinTabControl.WMSize;
begin
  inherited;
  if StretchEffect and (FIndex <> -1)
  then
    begin
      CheckControlsBackground;
    end;
end;

procedure TbsSkinTabControl.CheckControlsBackground;
var
  i: Integer;
begin
  for i := 0 to ControlCount - 1 do
  begin
    if Controls[i] is TWinControl
    then
      SendMessage(TWinControl(Controls[i]).Handle, WM_CHECKPARENTBG, 0, 0);
  end;
end;

procedure TbsSkinTabControl.SetTabsBGTransparent(Value: Boolean);
begin
  if FTabsBGTransparent <> Value
  then
    begin
      FTabsBGTransparent := Value;
      Invalidate;
    end;
end;

procedure TbsSkinTabControl.MouseMove;
begin
 inherited;
 if not (csDesigning in ComponentState)
 then
   TestActive(X, Y);
end;

procedure TbsSkinTabControl.MouseUp;
var
  R, BR: TRect;
begin
  inherited;

  if (Button = mbLeft) and not (csDesigning in ComponentState)
  then
    TestActive(X, Y);

  if (FActiveTab <> -1) and FShowCloseButtons and (Button = mbLeft)
  then
    begin
      R := GetItemRect(FActiveTab);
      BR := TabButtonR[FActiveTab];
      OffsetRect(BR, R.Left, R.Top);
      if PtInRect(BR, Point(X, Y))
      then
        begin
          TabButtonMouseIn[FActiveTab] := True;
          TabButtonMouseDown[FActiveTab] := False;
          DrawTabs(Canvas);
          DoClose;
        end
      else
      if not PtInRect(BR, Point(X, Y))
      then
        begin
          TabButtonMouseIn[FActiveTab] := False;
          TabButtonMouseDown[FActiveTab] := False;
        end;
    end;
end;

procedure TbsSkinTabControl.MouseDown;
var
  R, BR: TRect;
begin
  inherited;
  if (Button = mbLeft) and not (csDesigning in ComponentState)
  then
    TestActive(X, Y);

  if (FActiveTab <> -1) and FShowCloseButtons and (Button = mbLeft)
  then
    begin
      R := GetItemRect(FActiveTab);
      BR := TabButtonR[FActiveTab];
      OffsetRect(BR, R.Left, R.Top);
      if PtInRect(BR, Point(X, Y))
      then
        begin
          TabButtonMouseIn[FActiveTab] := True;
          TabButtonMouseDown[FActiveTab] := True;
          DrawTabs(Canvas);
        end
      else
      if not PtInRect(BR, Point(X, Y))
      then
        begin
          TabButtonMouseIn[FActiveTab] := False;
          TabButtonMouseDown[FActiveTab] := False;
        end;
    end;
end;

procedure TbsSkinTabControl.CMMouseLeave;
begin
  inherited;

  TestActive(-1, -1);

  if (FOldActiveTab <> - 1) and (FOldActiveTab <> TabIndex) and
     (FOldActiveTab < Self.Tabs.Count)
  then
    begin
      if FShowCloseButtons
      then
        begin
          TabButtonMouseIn[FOldActiveTab] := False;
          TabButtonMouseDown[FOldActiveTab] := False;
        end;
      DrawTabs(Canvas);
      FOldActiveTab := -1;
    end;

  if (FActiveTab <> - 1) and (FActiveTab <> TabIndex) and
     (FActiveTab < Self.Tabs.Count)
  then
    begin
      if FShowCloseButtons
      then
        begin
          TabButtonMouseIn[FActiveTab] := False;
          TabButtonMouseDown[FActiveTab] := False;
        end;  
      DrawTabs(Canvas);
      FActiveTab := -1;
    end;
end;

procedure TbsSkinTabControl.TestActive(X, Y: Integer);
var
  i, j: Integer;
  R, BR: TRect;
begin
  FOldActiveTab := FActiveTab;
  j := -1;
  for i := 0 to Tabs.Count-1 do
  begin
    R := GetItemRect(i);
    if PtInRect(R, Point(X, Y))
    then
      begin
        j := i;
        Break;
      end;
  end;

  FActiveTab := j;

  if (FOldActiveTab <> FActiveTab)
  then
    begin
      if (FOldActiveTab <> - 1) and (FOldActiveTab <> TabIndex) and
         (FOldActiveTab < Self.Tabs.Count)
      then
        begin
          DrawTabs(Canvas);
        end;
      if (FActiveTab <> -1) and (FActiveTab <> TabIndex) and
         (FActiveTab < Self.Tabs.Count)
      then
        begin
          DrawTabs(Canvas);
        end;
    end;

  if (FActiveTab <> -1) and FShowCloseButtons
  then
    begin
      R := GetItemRect(FActiveTab);
      BR := TabButtonR[FActiveTab];
      OffsetRect(BR, R.Left, R.Top);
      if PtInRect(BR, Point(X, Y)) and not TabButtonMouseIn[FActiveTab]
      then
        begin
          TabButtonMouseIn[FActiveTab] := True;
          DrawTabs(Canvas);
        end
      else
      if not PtInRect(BR, Point(X, Y)) and TabButtonMouseIn[FActiveTab]
      then
        begin
         TabButtonMouseIn[FActiveTab] := False;
         TabButtonMouseDown[FActiveTab] := False;
         DrawTabs(Canvas);
       end;
    end;

end;

procedure TbsSkinTabControl.SetDefaultItemHeight;
begin
  FDefaultItemHeight := Value;
  if FIndex = -1
  then
    begin
      SetitemSize(TabWidth, FDefaultItemHeight);
      Change2;
      ReAlign;
    end;
end;


procedure TbsSkinTabControl.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSkinTabControl.OnUpDownChange(Sender: TObject);
begin
  FSkinUpDown.Max := GetInVisibleItemCount;
  SendMessage(Handle, WM_HSCROLL,
    MakeWParam(SB_THUMBPOSITION, FSkinUpDown.Position), 0);
end;

function TbsSkinTabControl.GetPosition: Integer;
var
  i, j: Integer;
  R: TRect;
begin
  j := 0;
  for i := 0 to Tabs.Count - 1 do
  begin
    R := GetItemRect(i);
    if R.Right <= 0 then inc(j);
  end;
  Result := j;
end;

function TbsSkinTabControl.GetInVisibleItemCount;
var
  i, j: Integer;
  R: TRect;
  Limit: Integer;
begin
  if FSkinUpDown = nil
  then
    Limit := Width - 3
  else
    Limit := Width - FSkinUpDown.Width - 3;
  j := 0;
  for i := 0 to Tabs.Count - 1 do
  begin
    R := GetItemRect(i);
    if (R.Right > Limit) or (R.Right <= 0)
    then inc(j);
  end;
  Result := j;
end;

procedure TbsSkinTabControl.CheckScroll;
var
  Wnd: HWND;
  InVCount: Integer;
begin
  Wnd := FindWindowEx(Handle, 0, 'msctls_updown32', nil);
  if Wnd <> 0 then DestroyWindow(Wnd);
  InVCount := GetInVisibleItemCount;
  if (InVCount = 0) and (FSkinUpDown <> nil)
  then
    HideSkinUpDown
  else
  if (InVCount > 0) and (FSkinUpDown = nil)
  then
    ShowSkinUpDown;
  if FSkinUpDown <> nil
  then
    begin
      FSkinUpDown.Max := InVCount;
      FSkinUpDown.Left := Width - FSkinUpDown.Width;
      if TabPosition = tpTop
      then
        begin
          if FIndex = -1
          then
            FSkinUpDown.Top := 0
          else
            FSkinUpDown.Top := DisplayRect.Top - FSkinUpDown.Height - ClRect.Top;
          if FSkinUpDown.Top < 0 then FSkinUpDown.Top := 0;
        end
      else
        begin
          if FIndex = -1
          then
            FSkinUpDown.Top := Height - FSkinUpDown.Height
          else
            FSkinUpDown.Top := DisplayRect.Bottom + (RectHeight(SkinRect) - ClRect.Bottom);
          if FSkinUpDown.Top > Height - FSkinUpDown.Height
          then
            FSkinUpDown.Top := Height - FSkinUpDown.Height;
        end;
    end;
end;

procedure TbsSkinTabControl.ShowSkinUpDown;
begin
  FSkinUpDown := TbsSkinUpDown.Create(Self);
  FSkinUpDown.Parent := Self;
  FSkinUpDown.Width := 36;
  FSkinUpDown.Height := 18;
  FSkinUpDown.Min := 0;
  FSkinUpDown.Max := GetInVisibleItemCount;
  FSkinUpDown.Position := GetPosition;
  FSkinUpDown.Increment := 1;
  FSkinUpDown.OnChange := OnUpDownChange;
  FSkinUpDown.Left := Width - FSkinUpDown.Width;
  FSkinUpDown.SkinDataName := UpDown;
  FSkinUpDown.SkinData := SkinData;
  //
  if TabPosition = tpTop
  then
    begin
      if FIndex = -1
      then
        FSkinUpDown.Top := 0
       else
        FSkinUpDown.Top := DisplayRect.Top - FSkinUpDown.Height - ClRect.Top;
      if FSkinUpDown.Top < 0 then FSkinUpDown.Top := 0;
    end
  else
    begin
      if FIndex = -1
      then
        FSkinUpDown.Top := Height - FSkinUpDown.Height
      else
        FSkinUpDown.Top := DisplayRect.Bottom + (RectHeight(SkinRect) - ClRect.Bottom);
      if FSkinUpDown.Top > Height - FSkinUpDown.Height
      then
       FSkinUpDown.Top := Height - FSkinUpDown.Height;
    end;
  //
  FSkinUpDown.Visible := True;
end;

procedure TbsSkinTabControl.HideSkinUpDown;
begin
  FSkinUpDown.Free;
  FSkinUpDown := nil;
end;

procedure TbsSkinTabControl.WMPaint;
begin
  FromWMPaint := True;
  if ControlCount = 0
  then
    PaintHandler(Msg)
  else
    inherited;
  FromWMPaint := False;
end;

procedure TbsSkinTabControl.WMHSCROLL;
begin
  inherited;
  RePaint;
end;


destructor TbsSkinTabControl.Destroy;
begin
  FTempImages.Free;
  FDefaultFont.Free;
  inherited Destroy;
end;

procedure TbsSkinTabControl.Change;
begin
  if FSkinUpDown <> nil
  then FSkinUpDown.Position := GetPosition;
  inherited;
  Invalidate;
end;

procedure TbsSkinTabControl.Change2;
begin
  if FSkinUpDown <> nil
  then FSkinUpDown.Position := GetPosition;
  Invalidate;
end;

procedure TbsSkinTabControl.GetSkinData;
begin
  BGPictureIndex := -1;
  if FSD = nil
  then
    begin
      FIndex := -1;
      Exit;
    end;
  if FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  //
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinTabControl
    then
      with TbsDataSkinTabControl(FSD.CtrlList.Items[FIndex]) do
      begin
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          Picture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          Picture := nil;
        Self.SkinRect := SkinRect;
        Self.ClRect := ClRect;
        Self.TabRect := TabRect;
        if IsNullRect(ActiveTabRect)
        then
          Self.ActiveTabRect := TabRect
        else
          Self.ActiveTabRect := ActiveTabRect;
        if IsNullRect(FocusTabRect)
        then
          Self.FocusTabRect := ActiveTabRect
        else
          Self.FocusTabRect := FocusTabRect;
        //
        Self.TabsBGRect := TabsBGRect; 
        Self.LTPoint := LTPoint;
        Self.RTPoint := RTPoint;
        Self.LBPoint := LBPoint;
        Self.RBPoint := RBPoint;
        Self.TabLeftOffset := TabLeftOffset;
        Self.TabRightOffset := TabRightOffset;
        //
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.ActiveFontColor := ActiveFontColor;
        Self.FocusFontColor := FocusFontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.UpDown := UpDown;
        Self.BGPictureIndex := BGPictureIndex;
        Self.MouseInFontColor := MouseInFontColor;
        Self.MouseInTabRect := MouseInTabRect;
        Self.TabStretchEffect := TabStretchEffect;
        Self.LeftStretch := LeftStretch;
        Self.TopStretch := TopStretch;
        Self.RightStretch := RightStretch;
        Self.BottomStretch := BottomStretch;
        Self.ShowFocus := ShowFocus;
        Self.FocusOffsetX := FocusOffsetX;
        Self.FocusOffsetY := FocusOffsetY;
        Self.StretchEffect := StretchEffect;
        Self.StretchType := StretchType;
         //
        Self.CloseButtonRect := CloseButtonRect;
        Self.ClosebuttonActiveRect := ClosebuttonActiveRect;
        Self.CloseButtonDownRect := CloseButtonDownRect;
        if IsNullRect(ClosebuttonActiveRect)
          then ClosebuttonActiveRect:= CloseButtonRect;
        if IsNullRect(CloseButtonDownRect)
          then ClosebuttonDownRect:= CloseButtonActiveRect;
        //
        Self.ButtonTransparent := ButtonTransparent;
        Self.ButtonTransparentColor := ButtonTransparentColor;
        Self.TabLeftBottomActiveRect := TabLeftBottomActiveRect;
        Self.TabLeftBottomFocusRect := TabLeftBottomFocusRect;
        if IsNullRect(Self.TabLeftBottomFocusRect)
        then
          Self.TabLeftBottomFocusRect := Self.TabLeftBottomActiveRect;
      end;
end;

procedure TbsSkinTabControl.ChangeSkinData;
begin
  GetSkinData;
  //
  if FShowCloseButtons
  then
    begin
      if TabPosition in [tpTop, tpBottom]
      then
        FTempImages.Width := FTempImages.Width - FCloseSize
      else
        FTempImages.Height := FTempImages.Height - FCloseSize;
      FCloseSize := GetCloseSize;
      if TabPosition in [tpTop, tpBottom]
      then
        FTempImages.Width := FTempImages.Width + FCloseSize
      else
        FTempImages.Height := FTempImages.Height + FCloseSize;
    end;
  //
  if FIndex <> -1
  then
    begin
      Font.Color := FontColor;
      if FUseSkinFont
      then
        begin
          Font.Name := FontName;
          Font.Height := FontHeight;
          Font.Style := FontStyle;
        end
      else
        Font.Assign(FDefaultFont);

      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet
      else
        Font.CharSet := DefaultFont.CharSet;

      if TabHeight <= 0
      then
        SetItemSize(TabWidth, RectHeight(TabRect))
      else
        SetItemSize(TabWidth, TabHeight);
    end
  else
    begin
      Font.Assign(FDefaultFont);
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet;
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
    end;
  //
  Change2;
  ReAlign;
  RePaint;
  if FSkinUpDown <> nil
  then
    begin
      HideSkinUpDown;
      CheckScroll;
    end;
end;

procedure TbsSkinTabControl.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then
  if not FSD.Empty and not (csDesigning in ComponentState)
  then
    ChangeSkinData;
end;

procedure TbsSkinTabControl.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinTabControl.PaintDefaultWindow;
var
  R: TRect;
begin
  with Cnvs do
  begin
    Brush.Color := clBtnFace;
    FillRect(ClientRect);
    R := Self.DisplayRect;
    InflateRect(R, 1, 1);
    Frame3D(Cnvs, R, clBtnShadow, clBtnShadow, 1);
  end;
end;

procedure TbsSkinTabControl.PaintSkinWindow;
var
  TOff, LOff, Roff, BOff: Integer;
  NewClRect, DR, R, IR: TRect;
  TBGOffX, TBGOffY, X, Y, XCnt, YCnt, w, h, rw, rh, XO, YO, w1, h1: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  B, LB, RB, TB, BB, ClB, Buffer, Buffer2: TBitMap;
  SaveIndex: Integer;
begin
  GetSkinData;
  TOff := ClRect.Top;
  LOff := ClRect.Left;
  ROff := RectWidth(SkinRect) - ClRect.Right;
  BOff := RectHeight(SkinRect) - ClRect.Bottom;
  DR := Self.DisplayRect;
  R := Rect(DR.Left - LOff, DR.Top - TOff, DR.Right + ROff, DR.Bottom + BOff);
  XO := RectWidth(R) - RectWidth(SkinRect);
  YO := RectHeight(R) - RectHeight(SkinRect);
  NewLTPoint := LTPoint;
  NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
  NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
  NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
  NewCLRect := Rect(ClRect.Left, ClRect.Top, ClRect.Right + XO, ClRect.Bottom + YO);
  // DrawBG
  if BGPictureIndex <> -1
  then
    begin
      B := TBitMap(FSD.FActivePictures.Items[BGPictureIndex]);
      if StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case StretchType of
            bsstFull:
              begin
                Cnvs.StretchDraw(Rect(0, 0, Width, Height), B);
              end;
            bsstVert:
              begin
                Buffer2 := TBitMap.Create;
                Buffer2.Width := Width;
                Buffer2.Height := B.Height;
                Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), B);
                YCnt := Height div Buffer2.Height;
                for Y := 0 to YCnt do
                  Cnvs.Draw(0, Y * Buffer2.Height, Buffer2);
                Buffer2.Free;
              end;
           bsstHorz:
             begin
               Buffer2 := TBitMap.Create;
               Buffer2.Width := B.Width;
               Buffer2.Height := Height;
               Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), B);
               XCnt := Width div Buffer2.Width;
               for X := 0 to XCnt do
                 Cnvs.Draw(X * Buffer2.Width, 0, Buffer2);
               Buffer2.Free;
             end;
          end;
        end
      else
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div B.Width;
          YCnt := Height div B.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          Cnvs.Draw(X * B.Width, Y * B.Height, B);
        end;
      Exit;
    end;
  w := RectWidth(ClRect);
  h := RectHeight(ClRect);
  w1 := Width;
  h1 := Height;
  XCnt := w1 div w;
  YCnt := h1 div h;
  Clb := TBitMap.Create;
  Clb.Width := w;
  Clb.Height := h;
  Clb.Canvas.CopyRect(Rect(0, 0, w, h), Picture.Canvas,
  Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
       SkinRect.Left + ClRect.Right,
      SkinRect.Top + ClRect.Bottom));

  SaveIndex := SaveDC(Cnvs.Handle);
  IntersectClipRect(Cnvs.Handle, DR.Left, DR.Top, DR.Right, DR.Bottom);
  //
  if StretchEffect and (Width > 0) and (Height > 0)
   then
     begin
       case StretchType of
         bsstFull:
           begin
             Cnvs.StretchDraw(Rect(0, 0, Width, Height), Clb);
           end;
         bsstVert:
            begin
              Buffer2 := TBitMap.Create;
              Buffer2.Width := Width;
              Buffer2.Height := Clb.Height;
              Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), Clb);
              YCnt := Height div Buffer2.Height;
              for Y := 0 to YCnt do
                Cnvs.Draw(0, Y * Buffer2.Height, Buffer2);
              Buffer2.Free;
           end;
         bsstHorz:
           begin
             Buffer2 := TBitMap.Create;
             Buffer2.Width := Clb.Width;
             Buffer2.Height := Height;
             Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), Clb);
             XCnt := Width div Buffer2.Width;
             for X := 0 to XCnt do
               Cnvs.Draw(X * Buffer2.Width, 0, Buffer2);
             Buffer2.Free;
          end;
        end;
      end
  else
    begin
      for X := 0 to XCnt do
      for Y := 0 to YCnt do
      begin
        Cnvs.Draw(X * w, Y * h, Clb);
      end;
    end;
  //
  RestoreDC(Cnvs.Handle, SaveIndex);
  Clb.Free;
  // Draw frame around displayrect
  LB := TBitMap.Create;
  TB := TBitMap.Create;
  RB := TBitMap.Create;
  BB := TBitMap.Create;
  CreateSkinBorderImages(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
     NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewClRect,
     LB, TB, RB, BB, Picture, SkinRect, RectWidth(R), RectHeight(R),
     LeftStretch, TopStretch, RightStretch, BottomStretch);
   //
  SaveIndex := -1;
  IR := GetActiveTabRect;
  if not IsNullRect(IR)
  then
    begin
      SaveIndex := SaveDC(Cnvs.Handle);
      ExcludeClipRect(Cnvs.Handle, IR.Left, IR.Top, IR.Right, IR.Bottom)
    end;
  //
  Cnvs.Draw(R.Left, R.Top, TB);
  Cnvs.Draw(R.Left, R.Top + TB.Height, LB);
  Cnvs.Draw(R.Left + RectWidth(R) - RB.Width, R.Top + TB.Height, RB);
  Cnvs.Draw(R.Left, R.Top + RectHeight(R) - BB.Height, BB);
  //
  if SaveIndex <> -1 then RestoreDC(Cnvs.Handle, SaveIndex);
  //
  LB.Free;
  TB.Free;
  RB.Free;
  BB.Free;
end;

procedure TbsSkinTabControl.Loaded;
begin
  inherited Loaded;
  if FIndex = -1
  then
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
      Change2;
      ReAlign;
    end;
end;

procedure TbsSkinTabControl.PaintBG;
var
  C: TCanvas;
  TabSheetBG, Buffer2: TBitMap;
  X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
  R: TRect;
begin

  if (Width <= 0) or (Height <=0) then Exit;

  GetSkinData;
  C := TCanvas.Create;
  C.Handle := DC;

  if (FSD <> nil) and (not FSD.Empty) and
     (FIndex <> -1) and (BGPictureIndex <> -1)
  then
    begin
      TabSheetBG := TBitMap(FSD.FActivePictures.Items[BGPictureIndex]);
      if StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case StretchType of
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

  if FIndex <> -1
  then
    begin
      TabSheetBG := TBitMap.Create;
      TabSheetBG.Width := RectWidth(ClRect);
      TabSheetBG.Height := RectHeight(ClRect);
      TabSheetBG.Canvas.CopyRect(Rect(0, 0, TabSheetBG.Width, TabSheetBG.Height),
        Picture.Canvas,
          Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
               SkinRect.Left + ClRect.Right,
               SkinRect.Top + ClRect.Bottom));
      w := RectWidth(ClRect);
      h := RectHeight(ClRect);
      if StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case StretchType of
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
        begin
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
    FillRect(Rect(0, 0, w1, h1));
  end;
  C.Free;
end;

procedure TbsSkinTabControl.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
  if not FromWMPaint then PaintBG(Msg.DC);
end;

procedure TbsSkinTabControl.WndProc(var Message:TMessage);
var
  TOff, LOff, Roff, BOff: Integer;
begin
  if Message.Msg = TCM_ADJUSTRECT
  then
    begin
      inherited WndProc(Message);
      TOff := 0;
      LOff := 0;
      ROff := 0;
      BOff := 0;
      if (FIndex <> -1) and (BGPictureIndex = -1)
      then
        begin
          TOff := ClRect.Top;
          LOff := ClRect.Left;
          ROff := RectWidth(SkinRect) - ClRect.Right;
          BOff := RectHeight(SkinRect) - ClRect.Bottom;
        end;
      case TabPosition of
        tpLeft:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left + LOff - 4;
               PRect(Message.LParam)^.Right := ClientWidth - ROff;
               {$IFNDEF VER130}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
               {$ELSE}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               {$ENDIF}
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
             end
           else
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 3;
               PRect(Message.LParam)^.Right := ClientWidth - 1;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
             end;
        tpRight:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := LOff;
               PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - ROff + 4;
               {$IFNDEF VER130}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
               {$ELSE}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               {$ENDIF}
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
             end
           else
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 3;
               PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right + 3;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
             end;
        tpTop:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := LOff;
               PRect(Message.LParam)^.Right := ClientWidth - ROff;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
             end
           else
             begin
               PRect(Message.LParam)^.Left := 1;
               PRect(Message.LParam)^.Right := ClientWidth - 1;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
             end;
        tpBottom:
          if FIndex <> -1
          then
            begin
              PRect(Message.LParam)^.Left := LOff;
              PRect(Message.LParam)^.Right := ClientWidth - ROff;
              {$IFNDEF VER130}
              PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
              {$ELSE}
              PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
              {$ENDIF}
              PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 4 - BOff;
            end
          else
            begin
              PRect(Message.LParam)^.Left := 1;
              PRect(Message.LParam)^.Right := ClientWidth - 1;
              PRect(Message.LParam)^.Top := 1;
              PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 3;
            end;

      end;
    end
  else
    if Message.Msg = TCM_GETITEMRECT
    then
      begin
        inherited WndProc(Message);
        if Style = tsTabs
        then
          case TabPosition of
            tpLeft:
                begin
                  PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                  PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                end;
            tpRight:
                begin
                  PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left + 2;
                  PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right + 2;
                end;

            tpTop:
                begin
                  if not MultiLine
                  then
                    begin
                      PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                      PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                    end;
                  PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 2;
                  PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom - 2;
                end;
            tpBottom:
                begin
                  if not MultiLine
                  then
                    begin
                      PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                      PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                    end;
                  PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top + 2;
                  PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 2;
                end;
          end;
      end
  else
  inherited WndProc(Message);
  if (Message.Msg = WM_SIZE) and (not MultiLine)
  then
    begin
      CheckScroll;
    end;
end;

function TbsSkinTabControl.GetItemRect(index: integer): TRect;
var
  R: TRect;
begin
  SendMessage(Handle, TCM_GETITEMRECT, index, Integer(@R));
  Result := R;
end;

procedure TbsSkinTabControl.SetItemSize;
begin
  SendMessage(Handle, TCM_SETITEMSIZE, 0, MakeLParam(AWidth, AHeight));
end;

procedure TbsSkinTabControl.PaintWindow(DC: HDC);
var
  SaveIndex: Integer;
  C: TCanvas;
begin
  GetSkinData;
  try
    C := TCanvas.Create;
    C.Handle := DC;
    if FIndex = -1
    then
     PaintDefaultWindow(C)
   else
     PaintSkinWindow(C);
    DrawTabs(C);
    C.Free;
  finally
  end;
end;

procedure TbsSkinTabControl.DrawCloseButton(Cnvs: TCanvas; R: TRect;
          I, W, H: Integer);
var
  Buffer: TBitMap;
  CIndex: Integer;
  BtnSkinPicture: TBitMap;
  BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint: TPoint;
  BtnCLRect: TRect;
  BSR, ABSR, DBSR, R1: TRect;
  CIX, CIY, X, Y, XO, YO: Integer;
  ButtonData: TbsDataSkinButtonControl;
  ButtonR, R2: TRect;
begin
  if FIndex = -1
  then
    begin
      X := R.Left;
      Y := R.Top + RectHeight(R) div 2 - CLOSE_SIZE div 2;
      ButtonR := Rect(X, Y, X + CLOSE_SIZE, Y + CLOSE_SIZE);
      CIX := ButtonR.Left + 2;
      CIY := ButtonR.Top + 2;
      if TabButtonMouseDown[I] and TabButtonMouseIn[I]
      then
        DrawCloseImage(Cnvs, CIX, CIY, clWhite)
      else
      if TabButtonMouseIn[I]
      then
        begin
          DrawCloseImage(Cnvs, CIX, CIY, clWhite)
        end
      else
        begin
          DrawCloseImage(Cnvs, CIX, CIY, clBlack);
        end;
      //
      TabButtonR[I] := ButtonR;
      if (TabPosition = tpLeft) and not FTextInHorizontal
      then
        begin
          R1 := TabButtonR[I];
          R2 := Rect(R1.Top, W - R1.Right, R1.Bottom, W - R1.Left);
          TabButtonR[I] := R2;
        end
      else
      if (TabPosition = tpRight) and not FTextInHorizontal
      then
        begin
          R1 := TabButtonR[I];
          R2 := Rect(H - R1.Bottom, R1.Left, H - R1.Top, R1.Right);
          TabButtonR[I] := R2;
        end;
      Exit;
    end;

  if not IsNullRect(CloseButtonRect)
  then
    begin
      if TabButtonMouseDown[I] and
         TabButtonMouseIn[I]
      then
        R1 := CloseButtonDownRect
      else
      if TabButtonMouseIn[I]
      then
        R1 := CloseButtonActiveRect
      else
        R1 := CloseButtonRect;
      X := R.Left;
      Y := R.Top + RectHeight(R) div 2 - RectHeight(R1) div 2;
      ButtonR := Rect(X, Y, X + RectWidth(R1), Y + RectHeight(R1));
      if ButtonTransparent
      then
        begin
          Buffer := TBitMap.Create;
          Buffer.Width := RectWidth(R1);
          Buffer.Height := RectHeight(R1);
          Buffer.Transparent := True;
          Buffer.TransparentMode := tmFixed;
          Buffer.TransparentColor := ButtonTransparentColor;
          Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
            Picture.Canvas, R1);
          Cnvs.Draw(ButtonR.Left, ButtonR.Top, Buffer);
          Buffer.Free;
        end
      else
        Cnvs.CopyRect(ButtonR, Picture.Canvas, R1);

      //
      TabButtonR[I] := ButtonR;
      if (TabPosition = tpLeft) and  not FTextInHorizontal
      then
        begin
          R1 := TabButtonR[I];
          R2 := Rect(R1.Top, W - R1.Right, R1.Bottom, W - R1.Left);
          TabButtonR[I] := R2;
        end
      else
      if (TabPosition = tpRight)  and  not FTextInHorizontal
      then
        begin
          R1 := TabButtonR[I];
          R2 := Rect(H - R1.Bottom, R1.Left, H - R1.Top, R1.Right);
          TabButtonR[I] := R2;
        end;
      Exit;
    end;
  ButtonData := nil;
  CIndex := FSD.GetControlIndex('resizetoolbutton');
  if CIndex <> -1
  then
    ButtonData := TbsDataSkinButtonControl(FSD.CtrlList[CIndex]);
  if ButtonData = nil then Exit;
  //
  ButtonR := Rect(0, 0, FCloseSize, FCloseSize);
  //
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(ButtonR);
  Buffer.Height := RectHeight(ButtonR);
  //
  with ButtonData do
  begin
    XO := RectWidth(ButtonR) - RectWidth(SkinRect);
    YO := RectHeight(ButtonR) - RectHeight(SkinRect);
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
    if TabButtonMouseDown[I] and TabButtonMouseIn[I]
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, DBSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        Buffer.Canvas.Font.Color := DownFontColor;
      end
    else
    if TabButtonMouseIn[I]
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, ABSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        Buffer.Canvas.Font.Color := ActiveFontColor;
      end
    else
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, BSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        Buffer.Canvas.Font.Color := FontColor;
      end;
   end;

  CIX := Buffer.Width div 2 - 5;
  CIY := Buffer.Height div 2 - 5;

  DrawCloseImage(Buffer.Canvas, CIX, CIY, Buffer.Canvas.Font.Color);

  X := R.Left;
  Y := R.Top + RectHeight(R) div 2 - Buffer.Height div 2;

  TabButtonR[I] := Rect(X, Y,
  X + Buffer.Width, Y + Buffer.Height);

  if (TabPosition = tpLeft)  and  not FTextInHorizontal
  then
    begin
      R1 := TabButtonR[I];
      R2 := Rect(R1.Top, W - R1.Right, R1.Bottom, W - R1.Left);
      TabButtonR[I] := R2;
    end
  else
  if (TabPosition = tpRight)  and  not FTextInHorizontal
  then
    begin
      R1 := TabButtonR[I];
      R2 := Rect(H - R1.Bottom, R1.Left, H - R1.Top, R1.Right);
      TabButtonR[I] := R2;
    end;

  Cnvs.Draw(X, Y, Buffer);
  Buffer.Free;
end;

procedure TbsSkinTabControl.DrawTabs;
var
  i, j: integer;
  IR: TRect;
  w, h, XCnt, YCnt, X, Y, TOff, LOff, Roff, BOff, YO: Integer;
  Rct, R, DR: TRect;
  Buffer, Buffer2: TBitMap;
  SaveIndex: Integer;
begin
  //
  if Tabs.Count = 0 then Exit;
  if FIndex = -1
  then
    begin
      for i := 0 to Tabs.Count-1 do
      begin
        R := GetItemRect(i);
        DrawTab(i, R, i = TabIndex, i = FActiveTab, Cnvs);
      end;
      Exit;
    end;
  //
  GetSkinData;
  TOff := ClRect.Top;
  LOff := ClRect.Left;
  ROff := RectWidth(SkinRect) - ClRect.Right;
  BOff := RectHeight(SkinRect) - ClRect.Bottom;
  Self.GetClientRect;
  //
  DR := ClientRect;
  SendMessage(Handle, TCM_ADJUSTRECT, 0, Integer(@DR));
  Inc(DR.Top, 2);
  //
//  DR := Self.GetDisplayRect;
  R := Rect(DR.Left - LOff, DR.Top - TOff, DR.Right + ROff, DR.Bottom + BOff);
  Buffer := TBitMap.Create;
  case TabPosition of
    tpTop:
      begin
        Buffer.Width := Width;
        Buffer.Height := R.Top;
      end;
    tpBottom:
      begin
        Buffer.Width := Width;
        Buffer.Height := Height - R.Bottom;
      end;
    tpRight:
      begin
        Buffer.Width := Width - R.Right;
        Buffer.Height := Height;
      end;
    tpLeft:
      begin
        Buffer.Width := R.Left;
        Buffer.Height := Height;
      end;
  end;
  // draw tabsbg
  if IsNullRect(TabsBGRect)
  then
    begin
      TabsBGRect := ClRect;
      OffsetRect(TabsBGRect, SkinRect.Left, SkinRect.Top);
    end;
  w := RectWidth(TabsBGRect);
  h := RectHeight(TabsBGRect);
  XCnt := Buffer.Width div w;
  YCnt := Buffer.Height div h;
  if not TabsBGTransparent
  then
    begin
      Buffer2 := TBitMap.Create;
      Buffer2.Width := w;
      Buffer2.Height := h;
      Buffer2.Canvas.CopyRect(Rect(0, 0, w, h), Picture.Canvas, TabsBGRect);
      for X := 0 to XCnt do
      for Y := 0 to YCnt do
      begin
       Buffer.Canvas.Draw(X * w, Y * h, Buffer2);
      end;
      Buffer2.Free;
    end
  else
    begin
      case TabPosition of
        tpTop:
          Rct := Rect(0, 0, Width, R.Top);
        tpBottom:
          Rct := Rect(0, R.Bottom, Width, Height);
        tpRight:
          Rct := Rect(R.Right, 0, Width, Height);
        tpLeft:
          Rct := Rect(0, 0, R.Left, R.Bottom);
      end;
      GetParentImageRect(Self, Rct, Buffer.Canvas);
    end;
  //
  j := -1;
  for i := 0 to Tabs.Count - 1 do
  begin
    IR := GetItemRect(i);
    case TabPosition of
    tpTop:
      begin
      end;
    tpBottom:
      begin
        OffsetRect(IR, 0, -R.Bottom);
      end;
    tpRight:
      begin
        OffsetRect(IR, - R.Right, 0);
      end;
    tpLeft:
      begin

      end;
  end;
   if i <> TabIndex
   then
     DrawTab(i, IR, i = TabIndex, i = FActiveTab, Buffer.Canvas);
  end;

  SaveIndex := -1;
  IR := GetActiveTabRect;
  if not IsNullRect(IR)
  then
    begin
      SaveIndex := SaveDC(Cnvs.Handle);
      ExcludeClipRect(Cnvs.Handle, IR.Left, IR.Top, IR.Right, IR.Bottom);
    end;


 case TabPosition of
    tpTop:
      begin
        Cnvs.Draw(0, 0, Buffer);
      end;
    tpBottom:
      begin
        Cnvs.Draw(0, Height - Buffer.Height, Buffer);
      end;
    tpRight:
      begin
        Cnvs.Draw(Width - Buffer.Width, 0, Buffer);
      end;
    tpLeft:
      begin
        Cnvs.Draw(0, 0, Buffer);
      end;
  end;

  Buffer.Free;

  if SaveIndex <> -1 then RestoreDC(Cnvs.Handle, SaveIndex);

  if (TabIndex <> -1) and (TabIndex >= 0) and (TabIndex < Tabs.Count)
  then
    begin
      IR := GetItemRect(TabIndex);
      if (FIndex <> -1) and (RectHeight(TabRect) <> RectHeight(ActiveTabRect))
      then
        begin
          YO := RectHeight(ActiveTabRect) - RectHeight(TabRect);
          if (TabPosition = tpBottom) then OffsetRect(IR, 0, -YO) else
          if (TabPosition = tpRight) then OffsetRect(IR, -YO, 0);
        end;
      DrawTab(TabIndex, IR, True, TabIndex = FActiveTab, Cnvs);
    end;
end;

procedure TbsSkinTabControl.UpDateTabs;
begin
  if FIndex <> -1
  then
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, RectHeight(TabRect))
      else
        SetItemSize(TabWidth, TabHeight);
    end
  else
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
    end;
  if MultiLine and (FSkinUpDown <> nil)
  then
    HideSkinUpDown;
  ReAlign;
end;

procedure TbsSkinTabControl.DrawTab;
var
  R, R1, DR, DRClRect, R2, TR1, TR2: TRect;
  S: String;
  TB: TBitMap;
  DrawGlyph: Boolean;
  fx, W, H: Integer;
  fx2, CloseOffset: Integer;
begin
  if TI > Tabs.Count - 1 then Exit;
  DrawGlyph := (Images <> nil) and (TI < Images.Count);
  S := Tabs[TI];
  if (TabPosition = tpTop) or (TabPosition = tpBottom)
  then
    begin
      W := RectWidth(Rct);
      H := RectHeight(Rct);
    end
  else
    begin
      H := RectWidth(Rct);
      W := RectHeight(Rct);
    end;
  if (W <= 0) or (H <= 0) then Exit;   
  R := Rect(0, 0, W, H);
  TB := TBitMap.Create;
  TB.Width := W;
  TB.Height := H;
  if FIndex <> -1
  then
    begin
      if TabHeight <= 0
      then
        begin
          if MouseIn and not Active and not IsNullRect(MouseInTabRect)
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             TB, Picture, MouseInTabRect, W, H, TabStretchEffect)
          else
            if Active and Focused
          then
           CreateHSkinImage(TabLeftOffset, TabRightOffset,
            TB, Picture, FocusTabRect, W, H, TabStretchEffect)
          else
          if Active
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
              TB, Picture, ActiveTabRect, W, H, TabStretchEffect)
          else
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             TB, Picture, TabRect, W, H, TabStretchEffect);

         if Active and (Rct.Left = 0) and not IsNullRect(TabLeftBottomActiveRect) and
            not Multiline and ((TabPosition = tpTop) or (TabPosition = tpBottom))
         then
           begin
             if Focused
             then TR1 := TabLeftBottomFocusRect
             else TR1 := TabLeftBottomActiveRect;
             TR2 := Rect(0, TB.Height - RectHeight(TR1),
                         RectWidth(TR1), TB.Height);
             TB.Canvas.CopyRect(TR2, Picture.Canvas, TR1);
           end;
    
       end
     else
       begin
         if MouseIn and not Active and not IsNullRect(MouseInTabRect)
          then
            DR := MouseInTabRect
          else
            if Active and Focused
          then
            DR := FocusTabRect
          else
          if Active
          then
            DR := ActiveTabRect
          else
            DR := TabRect;

         fx := RectHeight(TabRect) div 4;

         TB.Width := W;
         TB.Height := H;

         if (RectHeight(TabRect) < RectHeight(ActiveTabRect)) and Active
         then
           TB.Height := TB.Height + (RectHeight(ActiveTabRect) - RectHeight(TabRect))
         else
         if (RectHeight(TabRect) < RectHeight(FocusTabRect)) and
            Active and Focused
         then
           TB.Height := TB.Height + (RectHeight(FocusTabRect) - RectHeight(TabRect));

         DRClRect := Rect(TabLeftOffset, fx,
          RectWidth(DR) - TabRightOffset,  RectHeight(DR) - fx);
         CreateStretchImage(TB, Picture, DR, DRClRect, True);

         if Active and (Rct.Left = 0) and not IsNullRect(TabLeftBottomActiveRect) and
            not Multiline and ((TabPosition = tpTop) or (TabPosition = tpBottom))
         then
           begin
             if Focused
             then TR1 := TabLeftBottomFocusRect
             else TR1 := TabLeftBottomActiveRect;
             TR2 := Rect(0, TB.Height - RectHeight(TR1),
                         RectWidth(TR1), TB.Height);
             TB.Canvas.CopyRect(TR2, Picture.Canvas, TR1);
           end;

       end;

      if TabPosition = tpBottom then DrawFlipVert(TB);

      with TB.Canvas do
      begin
        Brush.Style := bsClear;
        if FUseSkinFont
        then
          begin
            Font.Name := FontName;
            Font.Style := FontStyle;
            Font.Height := FontHeight;
          end
        else
           Font.Assign(Self.Font);
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.Charset := SkinData.ResourceStrData.CharSet
        else
          Font.CharSet := Self.Font.CharSet;
        if MouseIn and not Active
        then
          Font.Color := MouseInFontColor
        else
        if Active and Focused
        then
          Font.Color := FocusFontColor
        else
          if Active
          then Font.Color := ActiveFontColor
          else Font.Color := FontColor;
      end;
    end
  else
    begin
      TB.Width := W;
      TB.Height := H;
      if MouseIn and not Active
      then
        begin
          TB.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          TB.Canvas.FillRect(R);
        end
      else
      if Active and Focused
      then
        begin
          Frame3D(TB.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          TB.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          TB.Canvas.FillRect(R);
        end
      else
      if Active
      then
        begin
          Frame3D(TB.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          TB.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          TB.Canvas.FillRect(R);
        end
      else
        begin
          TB.Canvas.Brush.Color := clBtnFace;
          TB.Canvas.FillRect(R);
        end;
      with TB.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Assign(Self.Font);
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.Charset := SkinData.ResourceStrData.CharSet
      end;
    end;

  //
  if (TabPosition = tpLeft) and FTextInHorizontal
  then
    begin
      DrawRotate90_1_H(TB);
      R := Rect(0, 0, TB.Width, TB.Height);
    end
  else
  if (TabPosition = tpRight) and FTextInHorizontal
  then
    begin
      DrawRotate90_2_H(TB);
      R := Rect(0, 0, TB.Width, TB.Height);
    end;
  //
  if (FIndex <> -1) and ShowFocus and Focused and Active
  then
    begin
      R1 := R;
      InflateRect(R1, -FocusOffsetX, -FocusOffsetY);
      TB.Canvas.Brush.Style := bsSolid;
      TB.Canvas.Brush.Color := FSD.SkinColors.cBtnFace;
      DrawSkinFocusRect(TB.Canvas, R1);
      TB.Canvas.Brush.Style := bsClear;
    end;
  //
  fx2 := 0;
  if (FIndex <> -1) and (RectHeight(TabRect) <> RectHeight(ActiveTabRect)) and
     not Active
  then
    begin
      if (TabPosition = tpTop) or (TabPosition = tpLeft)
      then
        begin
          R.Top := R.Top + 1;
          if DrawGlyph then fx2 := 2;
        end
      else
        begin
          R.Top := R.Top - 1;
          if DrawGlyph then fx2 := - 2;
        end;
    end;
  if FShowCloseButtons then CloseOffset := FCloseSize + 2  else CloseOffset := 0;
  //
  if Assigned(Self.FOnDrawSkinTab)
  then
    begin
      FOnDrawSkinTab(TI, Rect(0, 0, TB.Width, TB.Height), Active, MouseIn, TB.Canvas);
    end
  else
  if DrawGlyph or FTabExtendedDraw
  then
    begin
      R2 := R;
      R2.Right := R2.Right - CloseOffset;
      if not FTabExtendedDraw
      then
        DrawTabGlyphAndText(TB.Canvas, TB.Width - CloseOffset, TB.Height, S,
                            Images, TI, True, fx2)
      else
        DrawImageAndText(TB.Canvas, R2,
           FTabMargin, FTabSpacing, FTabLayout, S, TI, Images, False,  True, False, 0);
      if CloseOffset <> 0
      then
        if FIndex <> -1 then R.Right := R.Right - CloseOffset - 3 else
          R.Right := R.Right - CloseOffset;
     end
  else
    begin
      if CloseOffset <> 0
      then
        if FIndex <> -1 then R.Right := R.Right - CloseOffset - 3 else
          R.Right := R.Right - CloseOffset;
      DrawText(TB.Canvas.Handle, PChar(S), Length(S), R, DT_CENTER or DT_SINGLELINE or DT_VCENTER);
    end;

  if FShowCloseButtons
  then
    begin
      if not MouseIn
      then
        begin
          TabButtonMouseIn[TI] := False;
        end;
      DrawCloseButton(TB.Canvas, Rect(R.Right, R.Top + fx2, TB.Width, R.Bottom), TI,
       TB.Width, TB.Height);
    end;

  if (TabPosition = tpLeft) and not FTextInHorizontal
  then
    DrawRotate90_1(Cnvs, TB, Rct.Left, Rct.Top)
  else
  if (TabPosition = tpRight) and not FTextInHorizontal
  then
    DrawRotate90_2(Cnvs, TB, Rct.Left, Rct.Top)
  else
    Cnvs.Draw(Rct.Left, Rct.Top, TB);
  TB.Free;
end;


end.
