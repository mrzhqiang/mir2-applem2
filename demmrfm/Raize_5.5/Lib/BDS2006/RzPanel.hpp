// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzpanel.pas' rev: 10.00

#ifndef RzpanelHPP
#define RzpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Rzgrafx.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzpanel
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzPanelDockManager;
class DELPHICLASS TRzCustomPanel;
#pragma option push -b-
enum TRzGridStyle { gsDots, gsDottedLines, gsSolidLines };
#pragma option pop

class PASCALIMPLEMENTATION TRzCustomPanel : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	bool FInAlignControls;
	Rzcommon::TAlignmentVertical FAlignmentVertical;
	Rzcommon::TFrameStyleEx FBorderInner;
	Rzcommon::TFrameStyleEx FBorderOuter;
	Rzcommon::TSides FBorderSides;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderHighlight;
	Graphics::TColor FBorderShadow;
	Graphics::TColor FFlatColor;
	int FFlatColorAdjustment;
	bool FPaintClientArea;
	Rzcommon::TRzVisualStyle FVisualStyle;
	Rzcommon::TRzGradientColorStyle FGradientColorStyle;
	Graphics::TColor FGradientColorStart;
	Graphics::TColor FGradientColorStop;
	Rzcommon::TGradientDirection FGradientDirection;
	Graphics::TColor FGridColor;
	TRzGridStyle FGridStyle;
	Word FGridXSize;
	Word FGridYSize;
	bool FShowGrid;
	bool FTransparent;
	int FTextMargin;
	int FTextMarginVertical;
	bool FWordWrap;
	bool FShowDockClientCaptions;
	Classes::TStringList* FEnabledList;
	Classes::TNotifyEvent FOnPaint;
	void __fastcall ReadOldUseGradientsProp(Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	MESSAGE void __fastcall WMThemeChanged(Messages::TMessage &Msg);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Types::TPoint __fastcall CursorPosition();
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	virtual void __fastcall FixClientRect(Types::TRect &Rect, bool ShrinkByBorder);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	virtual Types::TRect __fastcall GetClientRect();
	virtual Types::TRect __fastcall GetControlRect();
	virtual Types::TPoint __fastcall InvalidateMarginSize();
	virtual void __fastcall EnableChildControls(bool Enabled);
	virtual void __fastcall GetGradientColors(Graphics::TColor &StartColor, Graphics::TColor &StopColor);
	virtual void __fastcall GetGradientFrameColor(Graphics::TColor &FrameColor, int &FrameColorAdjustment);
	virtual void __fastcall DrawCaption(const Types::TRect &Rect);
	virtual void __fastcall DrawGrid(const Types::TRect &Rect);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CustomFramingChanged(void);
	DYNAMIC Controls::_di_IDockManager __fastcall CreateDockManager();
	virtual void __fastcall SetAlignmentVertical(Rzcommon::TAlignmentVertical Value);
	virtual void __fastcall SetBorderColor(Graphics::TColor Value);
	virtual void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderSides(Rzcommon::TSides Value);
	virtual void __fastcall SetBorderHighlight(Graphics::TColor Value);
	virtual void __fastcall SetBorderShadow(Graphics::TColor Value);
	virtual void __fastcall SetFlatColor(Graphics::TColor Value);
	virtual void __fastcall SetFlatColorAdjustment(int Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetGradientColorStyle(Rzcommon::TRzGradientColorStyle Value);
	virtual void __fastcall SetGradientColorStart(Graphics::TColor Value);
	virtual void __fastcall SetGradientColorStop(Graphics::TColor Value);
	virtual void __fastcall SetGradientDirection(Rzcommon::TGradientDirection Value);
	virtual void __fastcall SetGridColor(Graphics::TColor Value);
	virtual void __fastcall SetGridStyle(TRzGridStyle Value);
	virtual void __fastcall SetGridXSize(Word Value);
	virtual void __fastcall SetGridYSize(Word Value);
	virtual void __fastcall SetPaintClientArea(bool Value);
	virtual void __fastcall SetShowGrid(bool Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual void __fastcall SetTextMargin(int Value);
	virtual void __fastcall SetTextMarginVertical(int Value);
	virtual void __fastcall SetWordWrap(bool Value);
	virtual void __fastcall SetVisualStyle(Rzcommon::TRzVisualStyle Value);
	__property Rzcommon::TAlignmentVertical AlignmentVertical = {read=FAlignmentVertical, write=SetAlignmentVertical, default=1};
	__property Rzcommon::TFrameStyleEx BorderInner = {read=FBorderInner, write=SetBorderInner, default=0};
	__property Rzcommon::TFrameStyleEx BorderOuter = {read=FBorderOuter, write=SetBorderOuter, default=6};
	__property Rzcommon::TSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777201};
	__property Graphics::TColor BorderHighlight = {read=FBorderHighlight, write=SetBorderHighlight, default=-16777196};
	__property Graphics::TColor BorderShadow = {read=FBorderShadow, write=SetBorderShadow, default=-16777200};
	__property Graphics::TColor FlatColor = {read=FFlatColor, write=SetFlatColor, default=-16777200};
	__property int FlatColorAdjustment = {read=FFlatColorAdjustment, write=SetFlatColorAdjustment, default=30};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Rzcommon::TRzGradientColorStyle GradientColorStyle = {read=FGradientColorStyle, write=SetGradientColorStyle, default=0};
	__property Graphics::TColor GradientColorStart = {read=FGradientColorStart, write=SetGradientColorStart, default=16777215};
	__property Graphics::TColor GradientColorStop = {read=FGradientColorStop, write=SetGradientColorStop, default=-16777201};
	__property Rzcommon::TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=2};
	__property Graphics::TColor GridColor = {read=FGridColor, write=SetGridColor, default=-16777200};
	__property TRzGridStyle GridStyle = {read=FGridStyle, write=SetGridStyle, default=0};
	__property Word GridXSize = {read=FGridXSize, write=SetGridXSize, default=8};
	__property Word GridYSize = {read=FGridYSize, write=SetGridYSize, default=8};
	__property bool PaintClientArea = {read=FPaintClientArea, write=SetPaintClientArea, default=1};
	__property int TextMargin = {read=FTextMargin, write=SetTextMargin, default=0};
	__property int TextMarginVertical = {read=FTextMarginVertical, write=SetTextMarginVertical, default=0};
	__property bool ShowGrid = {read=FShowGrid, write=SetShowGrid, default=0};
	__property bool ShowDockClientCaptions = {read=FShowDockClientCaptions, write=FShowDockClientCaptions, default=1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Rzcommon::TRzVisualStyle VisualStyle = {read=FVisualStyle, write=SetVisualStyle, default=1};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
	__property Classes::TNotifyEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	
public:
	__fastcall virtual TRzCustomPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomPanel(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall SetGridSize(int XSize, int YSize);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
private:
	void *__IRzCustomFramingNotification;	/* Rzcommon::IRzCustomFramingNotification */
	
public:
	operator IRzCustomFramingNotification*(void) { return (IRzCustomFramingNotification*)&__IRzCustomFramingNotification; }
	
};


class PASCALIMPLEMENTATION TRzPanelDockManager : public Controls::TDockTree 
{
	typedef Controls::TDockTree inherited;
	
private:
	TRzCustomPanel* FPanel;
	Classes::TWndMethod FOldWndProc;
	void __fastcall WindowProcHook(Messages::TMessage &Msg);
	
protected:
	Graphics::TFont* FFont;
	Graphics::TFont* FCloseFont;
	int FGrabberSize;
	virtual void __fastcall AdjustDockRect(Controls::TControl* Control, Types::TRect &ARect);
	void __fastcall DrawVertTitle(Graphics::TCanvas* Canvas, const AnsiString Caption, const Types::TRect &Bounds);
	virtual void __fastcall PaintDockFrame(Graphics::TCanvas* Canvas, Controls::TControl* Control, const Types::TRect &ARect);
	
public:
	__fastcall virtual TRzPanelDockManager(Controls::TWinControl* DockSite);
	__fastcall virtual ~TRzPanelDockManager(void);
	virtual void __fastcall PaintSite(HDC DC);
};


class DELPHICLASS TRzPanel;
class PASCALIMPLEMENTATION TRzPanel : public TRzCustomPanel 
{
	typedef TRzCustomPanel inherited;
	
public:
	__property Canvas ;
	__property DockManager ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Align  = {default=0};
	__property Alignment  = {default=2};
	__property AlignmentVertical  = {default=1};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=0};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=6};
	__property BorderSides  = {default=15};
	__property BorderColor  = {default=-16777201};
	__property BorderHighlight  = {default=-16777196};
	__property BorderShadow  = {default=-16777200};
	__property BorderWidth  = {default=0};
	__property Caption ;
	__property Color  = {default=-16777201};
	__property Constraints ;
	__property Ctl3D ;
	__property DockSite  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=30};
	__property Font ;
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property FullRepaint  = {default=1};
	__property GradientColorStyle  = {default=0};
	__property GradientColorStart  = {default=16777215};
	__property GradientColorStop  = {default=-16777201};
	__property GradientDirection  = {default=2};
	__property GridColor  = {default=-16777200};
	__property GridStyle  = {default=0};
	__property GridXSize  = {default=8};
	__property GridYSize  = {default=8};
	__property Locked  = {default=0};
	__property PaintClientArea  = {default=1};
	__property TextMargin  = {default=0};
	__property TextMarginVertical  = {default=0};
	__property Padding ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowDockClientCaptions  = {default=1};
	__property ShowGrid  = {default=0};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Transparent  = {default=0};
	__property UseDockManager  = {default=1};
	__property Visible  = {default=1};
	__property VisualStyle  = {default=1};
	__property WordWrap  = {default=1};
	__property OnCanResize ;
	__property OnClick ;
	__property OnConstrainedResize ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetSiteInfo ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnPaint ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TRzCustomPanel.Create */ inline __fastcall virtual TRzPanel(Classes::TComponent* AOwner) : TRzCustomPanel(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomPanel.Destroy */ inline __fastcall virtual ~TRzPanel(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzPanel(HWND ParentWindow) : TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzGroupBoxStyle { gsStandard, gsCustom, gsTopLine, gsFlat, gsBanner, gsUnderline };
#pragma option pop

class DELPHICLASS TRzCustomGroupBox;
class PASCALIMPLEMENTATION TRzCustomGroupBox : public TRzCustomPanel 
{
	typedef TRzCustomPanel inherited;
	
private:
	TRzGroupBoxStyle FGroupStyle;
	int FBannerHeight;
	Graphics::TFont* FCaptionFont;
	bool FCaptionFontChanged;
	#pragma pack(push,1)
	Types::TRect FCaptionRect;
	#pragma pack(pop)
	bool FEnableControlsOnCheck;
	bool FShowCheckBox;
	int FCheckBoxSize;
	bool FDragging;
	bool FMouseOverCheckBox;
	bool FKeyToggle;
	bool FShowDownVersion;
	Classes::TNotifyEvent FOnCheckBoxClick;
	bool FChecked;
	void __fastcall CaptionFontChangeHandler(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CustomFramingChanged(void);
	virtual void __fastcall Paint(void);
	void __fastcall DrawThemedCheckBox(void);
	void __fastcall DrawNonThemedCheckBox(void);
	Types::TRect __fastcall AdjustCaptionRectForCheckBox();
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	bool __fastcall ShowAccel(void);
	bool __fastcall ShowFocus(void);
	virtual void __fastcall ChangeState(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall CheckBoxClick(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall SetBannerHeight(int Value);
	virtual void __fastcall SetGroupBoxStyle(TRzGroupBoxStyle Value);
	bool __fastcall IsCaptionFontStored(void);
	virtual void __fastcall SetCaptionFont(Graphics::TFont* Value);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetEnableControlsOnCheck(bool Value);
	virtual void __fastcall SetShowCheckBox(bool Value);
	__property bool Checked = {read=FChecked, write=SetChecked, default=1};
	__property bool EnableControlsOnCheck = {read=FEnableControlsOnCheck, write=SetEnableControlsOnCheck, default=1};
	__property bool ShowCheckBox = {read=FShowCheckBox, write=SetShowCheckBox, default=0};
	__property Classes::TNotifyEvent OnCheckBoxClick = {read=FOnCheckBoxClick, write=FOnCheckBoxClick};
	__property Alignment  = {default=0};
	__property AlignmentVertical  = {default=0};
	__property BorderOuter  = {default=0};
	__property BorderInner  = {default=0};
	__property Height  = {default=105};
	
public:
	__fastcall virtual TRzCustomGroupBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomGroupBox(void);
	__property int BannerHeight = {read=FBannerHeight, write=SetBannerHeight, default=0};
	__property TRzGroupBoxStyle GroupStyle = {read=FGroupStyle, write=SetGroupBoxStyle, default=3};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont, stored=IsCaptionFontStored};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomGroupBox(HWND ParentWindow) : TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzGroupBox;
class PASCALIMPLEMENTATION TRzGroupBox : public TRzCustomGroupBox 
{
	typedef TRzCustomGroupBox inherited;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Align  = {default=0};
	__property Alignment  = {default=0};
	__property Anchors  = {default=3};
	__property BannerHeight  = {default=0};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderColor  = {default=-16777201};
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=0};
	__property BorderSides  = {default=15};
	__property BorderWidth  = {default=0};
	__property Caption ;
	__property CaptionFont ;
	__property Checked  = {default=1};
	__property Color  = {default=-16777201};
	__property Constraints ;
	__property Ctl3D ;
	__property DockSite  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property EnableControlsOnCheck  = {default=1};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=30};
	__property Font ;
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property GradientColorStyle  = {default=0};
	__property GradientColorStart  = {default=16777215};
	__property GradientColorStop  = {default=-16777201};
	__property GradientDirection  = {default=2};
	__property GroupStyle  = {default=3};
	__property Height  = {default=105};
	__property Padding ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowCheckBox  = {default=0};
	__property ShowDockClientCaptions  = {default=1};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Transparent  = {default=0};
	__property Visible  = {default=1};
	__property VisualStyle  = {default=1};
	__property OnCheckBoxClick ;
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetSiteInfo ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnPaint ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TRzCustomGroupBox.Create */ inline __fastcall virtual TRzGroupBox(Classes::TComponent* AOwner) : TRzCustomGroupBox(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomGroupBox.Destroy */ inline __fastcall virtual ~TRzGroupBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzGroupBox(HWND ParentWindow) : TRzCustomGroupBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzSpacer;
class PASCALIMPLEMENTATION TRzSpacer : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FGrooved;
	Rzcommon::TOrientation FOrientation;
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetGrooved(bool Value);
	virtual void __fastcall SetOrientation(Rzcommon::TOrientation Value);
	
public:
	__fastcall virtual TRzSpacer(Classes::TComponent* AOwner);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool Grooved = {read=FGrooved, write=SetGrooved, default=0};
	__property Rzcommon::TOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Constraints ;
	__property Height  = {default=25};
	__property Width  = {default=8};
	__property Visible  = {default=1};
public:
	#pragma option push -w-inl
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TRzSpacer(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzToolbarControl;
class PASCALIMPLEMENTATION TRzToolbarControl : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	Controls::TControl* FControl;
	AnsiString FControlName;
	virtual void __fastcall AssignElements(TRzToolbarControl* Control);
	
public:
	__property Controls::TControl* Control = {read=FControl};
	__property AnsiString ControlName = {read=FControlName};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TRzToolbarControl(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzToolbarControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzToolbarControlList;
class DELPHICLASS TRzToolbar;
#pragma option push -b-
enum TRzToolbarTextOptions { ttoNoTextLabels, ttoShowTextLabels, ttoSelectiveTextOnRight, ttoCustom };
#pragma option pop

class DELPHICLASS TRzToolbarPopupButton;
class PASCALIMPLEMENTATION TRzToolbarPopupButton : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Graphics::TColor FFrameColor;
	TRzToolbar* FToolbar;
	Menus::TPopupMenu* FMenu;
	Rzbutton::TRzToolButton* FSelectedButton;
	bool FPressed;
	bool FDown;
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	
protected:
	virtual void __fastcall DrawBackground(const Types::TRect &Bounds, bool Down);
	virtual void __fastcall DrawChevron(const Types::TRect &Bounds);
	virtual void __fastcall Paint(void);
	void __fastcall DisplayButtons(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	
public:
	__fastcall virtual TRzToolbarPopupButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzToolbarPopupButton(void);
	
__published:
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777200};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzToolbarPopupButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzCustomizeCaptions;
class PASCALIMPLEMENTATION TRzCustomizeCaptions : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FStoreCaptions;
	AnsiString FTitle;
	AnsiString FHint;
	AnsiString FClose;
	AnsiString FMoveUp;
	AnsiString FMoveDown;
	AnsiString FTextOptions;
	AnsiString FNoTextLabels;
	AnsiString FShowTextLabels;
	AnsiString FSelectiveTextOnRight;
	
protected:
	AnsiString __fastcall GetCaption(int Index);
	void __fastcall SetCaption(int Index, const AnsiString Value);
	
public:
	__fastcall TRzCustomizeCaptions(void);
	
__published:
	__property AnsiString Title = {read=GetCaption, write=SetCaption, stored=FStoreCaptions, index=1};
	__property AnsiString Hint = {read=GetCaption, write=SetCaption, stored=FStoreCaptions, index=2};
	__property AnsiString Close = {read=GetCaption, write=SetCaption, stored=FStoreCaptions, index=3};
	__property AnsiString MoveUp = {read=GetCaption, write=SetCaption, stored=FStoreCaptions, index=4};
	__property AnsiString MoveDown = {read=GetCaption, write=SetCaption, stored=FStoreCaptions, index=5};
	__property AnsiString TextOptions = {read=GetCaption, write=SetCaption, stored=FStoreCaptions, index=6};
	__property AnsiString NoTextLabels = {read=GetCaption, write=SetCaption, stored=FStoreCaptions, index=7};
	__property AnsiString ShowTextLabels = {read=GetCaption, write=SetCaption, stored=FStoreCaptions, index=8};
	__property AnsiString SelectiveTextOnRight = {read=GetCaption, write=SetCaption, stored=FStoreCaptions, index=9};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRzCustomizeCaptions(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzToolbar : public TRzCustomPanel 
{
	typedef TRzCustomPanel inherited;
	
private:
	bool FAutoResize;
	bool FAutoStyle;
	Graphics::TBitmap* FBackground;
	Imglist::TCustomImageList* FImages;
	Imglist::TChangeLink* FImagesChangeLink;
	Rzcommon::TOrientation FOrientation;
	int FRowHeight;
	bool FShowDivider;
	bool FShowButtonCaptions;
	Buttons::TButtonLayout FButtonLayout;
	int FButtonWidth;
	int FButtonHeight;
	TRzToolbarTextOptions FTextOptions;
	bool FUpdatingTextOptions;
	bool FWrapControls;
	TRzToolbarPopupButton* FToolbarPopupButton;
	bool FShowToolbarPopupButton;
	TRzCustomizeCaptions* FCustomizeCaptions;
	Rzcommon::TRzRegIniFile* FRegIniFile;
	Classes::TNotifyEvent FOnVisibleChanged;
	void __fastcall BackgroundChangedHandler(System::TObject* Sender);
	void __fastcall ImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Msg);
	
protected:
	TRzToolbarControlList* FToolbarControls;
	int FMargin;
	int FTopMargin;
	int FCalculatedRowHeight;
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall DrawCaption(const Types::TRect &Rect);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall CreateToolbarPopupButton(void);
	void __fastcall AlignToolbarPopupButton(void);
	void __fastcall SetShowToolbarPopupButton(bool Value);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	virtual int __fastcall CalculateRowHeight(int Row);
	virtual Types::TPoint __fastcall InvalidateMarginSize();
	virtual void __fastcall PositionControl(int Index, int Row, int &Offset);
	virtual TRzToolbarControlList* __fastcall CreateToolbarControlList(void);
	virtual void __fastcall AdjustStyle(Controls::TAlign Value);
	DYNAMIC void __fastcall VisibleChanged(void);
	virtual Controls::TAlign __fastcall GetAlign(void);
	HIDESBASE virtual void __fastcall SetAlign(Controls::TAlign Value);
	virtual void __fastcall SetAutoResize(bool Value);
	virtual void __fastcall SetBackground(Graphics::TBitmap* Value);
	virtual void __fastcall SetImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetMargin(int Value);
	virtual void __fastcall SetTopMargin(int Value);
	virtual void __fastcall SetOrientation(Rzcommon::TOrientation Value);
	virtual void __fastcall SetRowHeight(int Value);
	virtual void __fastcall SetShowButtonCaptions(bool Value);
	virtual void __fastcall SetButtonLayout(Buttons::TButtonLayout Value);
	virtual void __fastcall SetButtonWidth(int Value);
	virtual void __fastcall SetButtonHeight(int Value);
	virtual void __fastcall SetShowDivider(bool Value);
	virtual void __fastcall SetTextOptions(TRzToolbarTextOptions Value);
	virtual void __fastcall SetWrapControls(bool Value);
	virtual void __fastcall SetCustomizeCaptions(TRzCustomizeCaptions* Value);
	virtual void __fastcall SetRegIniFile(Rzcommon::TRzRegIniFile* Value);
	virtual void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderSides(Rzcommon::TSides Value);
	virtual void __fastcall CheckAutoResize(bool &Value);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall SetBiDiMode(Classes::TBiDiMode Value);
	virtual void __fastcall SetGradientColorStyle(Rzcommon::TRzGradientColorStyle Value);
	virtual void __fastcall SetVisualStyle(Rzcommon::TRzVisualStyle Value);
	
public:
	__fastcall virtual TRzToolbar(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzToolbar(void);
	virtual void __fastcall PositionControls(void);
	virtual void __fastcall UpdateButtonSize(int NewWidth, int NewHeight, bool ShowCaptions);
	void __fastcall Customize(bool ShowTextOptions = true);
	void __fastcall RestoreLayout(void);
	void __fastcall SaveLayout(void);
	__property TRzToolbarControlList* ToolbarControls = {read=FToolbarControls};
	__property Canvas ;
	__property DockManager ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Controls::TAlign Align = {read=GetAlign, write=SetAlign, default=1};
	__property bool AutoResize = {read=FAutoResize, write=SetAutoResize, default=1};
	__property bool AutoStyle = {read=FAutoStyle, write=FAutoStyle, default=1};
	__property Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property TRzCustomizeCaptions* CustomizeCaptions = {read=FCustomizeCaptions, write=SetCustomizeCaptions};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property int Margin = {read=FMargin, write=SetMargin, default=4};
	__property int TopMargin = {read=FTopMargin, write=SetTopMargin, default=2};
	__property Rzcommon::TOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property int RowHeight = {read=FRowHeight, write=SetRowHeight, default=25};
	__property Buttons::TButtonLayout ButtonLayout = {read=FButtonLayout, write=SetButtonLayout, default=0};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, default=25};
	__property int ButtonHeight = {read=FButtonHeight, write=SetButtonHeight, default=25};
	__property Rzcommon::TRzRegIniFile* RegIniFile = {read=FRegIniFile, write=SetRegIniFile};
	__property bool ShowButtonCaptions = {read=FShowButtonCaptions, write=SetShowButtonCaptions, default=0};
	__property bool ShowDivider = {read=FShowDivider, write=SetShowDivider, default=1};
	__property TRzToolbarTextOptions TextOptions = {read=FTextOptions, write=SetTextOptions, default=0};
	__property bool WrapControls = {read=FWrapControls, write=SetWrapControls, default=1};
	__property Classes::TNotifyEvent OnVisibleChanged = {read=FOnVisibleChanged, write=FOnVisibleChanged};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=0};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderColor  = {default=-16777201};
	__property BorderInner ;
	__property BorderOuter ;
	__property BorderSides ;
	__property BorderWidth ;
	__property Caption ;
	__property Color  = {default=-16777201};
	__property Constraints ;
	__property Ctl3D ;
	__property DockSite  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=30};
	__property Font ;
	__property FullRepaint  = {default=0};
	__property GradientColorStyle  = {default=0};
	__property GradientColorStart  = {default=16777215};
	__property GradientColorStop  = {default=-16777201};
	__property GradientDirection  = {default=2};
	__property Height  = {default=32};
	__property Locked  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowDockClientCaptions  = {default=0};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Transparent  = {default=0};
	__property UseDockManager  = {default=1};
	__property Visible  = {default=1};
	__property VisualStyle  = {default=1};
	__property Width  = {default=32};
	__property OnCanResize ;
	__property OnClick ;
	__property OnConstrainedResize ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetSiteInfo ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnPaint ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzToolbar(HWND ParentWindow) : TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzToolbarControlList : public Classes::TList 
{
	typedef Classes::TList inherited;
	
public:
	TRzToolbarControl* operator[](int Index) { return Items[Index]; }
	
protected:
	TRzToolbar* FToolbar;
	int FIndexOfLastControlRead;
	TRzToolbarControlList* FTempControlList;
	HIDESBASE TRzToolbarControl* __fastcall Get(int Index);
	HIDESBASE void __fastcall Put(int Index, TRzToolbarControl* Value);
	void __fastcall ControlsAreLoaded(Classes::TComponent* OwnerComp);
	virtual void __fastcall ReadControl(Classes::TReader* Reader);
	virtual void __fastcall WriteControl(int Index, Classes::TWriter* Writer);
	virtual TRzToolbarControl* __fastcall CreateToolBarControl(void);
	
public:
	__fastcall TRzToolbarControlList(TRzToolbar* AToolbar);
	__fastcall virtual ~TRzToolbarControlList(void);
	void __fastcall ReadControls(Classes::TReader* Reader);
	void __fastcall WriteControls(Classes::TWriter* Writer);
	HIDESBASE int __fastcall IndexOf(Controls::TControl* Control);
	int __fastcall IndexOfName(const AnsiString ControlName);
	int __fastcall AddControl(Controls::TControl* Control);
	int __fastcall AddControlName(const AnsiString ControlName);
	int __fastcall RemoveControl(Controls::TControl* Control);
	int __fastcall RemoveControlName(const AnsiString ControlName);
	__property TRzToolbarControl* Items[int Index] = {read=Get, write=Put/*, default*/};
	__property TRzToolbar* Toolbar = {read=FToolbar};
};


class DELPHICLASS TRzStatusBar;
class PASCALIMPLEMENTATION TRzStatusBar : public TRzCustomPanel 
{
	typedef TRzCustomPanel inherited;
	
private:
	bool FAutoStyle;
	Graphics::TCanvas* FSizeGripCanvas;
	bool FSimpleStatus;
	AnsiString FSimpleCaption;
	Rzcommon::TFrameStyleEx FSimpleFrameStyle;
	bool FSizeGripValid;
	bool FShowSizeGrip;
	bool FAutoScalePanes;
	bool FFirst;
	int FDelta;
	int FLastWidth;
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	DYNAMIC void __fastcall Resize(void);
	virtual Types::TRect __fastcall GetClientRect();
	void __fastcall PaintSizeGrip(const Types::TRect &R);
	virtual void __fastcall DrawSimpleStatusBorder(const Types::TRect &R);
	virtual void __fastcall GetGradientColors(Graphics::TColor &StartColor, Graphics::TColor &StopColor);
	virtual void __fastcall Paint(void);
	void __fastcall ValidateSizeGrip(void);
	Types::TRect __fastcall SizeGripRect();
	virtual void __fastcall AdjustStyle(void);
	virtual void __fastcall SetShowSizeGrip(bool Value);
	virtual void __fastcall SetSimpleCaption(AnsiString Value);
	virtual void __fastcall SetSimpleStatus(bool Value);
	virtual void __fastcall SetSimpleFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderSides(Rzcommon::TSides Value);
	
public:
	__fastcall virtual TRzStatusBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzStatusBar(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AutoScalePanes = {read=FAutoScalePanes, write=FAutoScalePanes, default=0};
	__property bool AutoStyle = {read=FAutoStyle, write=FAutoStyle, default=1};
	__property bool ShowSizeGrip = {read=FShowSizeGrip, write=SetShowSizeGrip, default=1};
	__property AnsiString SimpleCaption = {read=FSimpleCaption, write=SetSimpleCaption};
	__property Rzcommon::TFrameStyle SimpleFrameStyle = {read=FSimpleFrameStyle, write=SetSimpleFrameStyle, default=1};
	__property bool SimpleStatus = {read=FSimpleStatus, write=SetSimpleStatus, default=0};
	__property Align  = {default=2};
	__property Anchors  = {default=3};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderColor  = {default=-16777201};
	__property BorderInner ;
	__property BorderOuter ;
	__property BorderSides ;
	__property BorderWidth ;
	__property Color  = {default=-16777201};
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=30};
	__property Font ;
	__property FullRepaint  = {default=1};
	__property GradientColorStyle  = {default=0};
	__property GradientColorStart  = {default=16777215};
	__property GradientColorStop  = {default=-16777201};
	__property GradientDirection  = {default=2};
	__property Height ;
	__property Locked  = {default=0};
	__property Padding ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Visible  = {default=1};
	__property VisualStyle  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnPaint ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzStatusBar(HWND ParentWindow) : TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzFlowPanel;
class PASCALIMPLEMENTATION TRzFlowPanel : public Extctrls::TCustomFlowPanel 
{
	typedef Extctrls::TCustomFlowPanel inherited;
	
private:
	bool FInAlignControls;
	Rzcommon::TFrameStyleEx FBorderInner;
	Rzcommon::TFrameStyleEx FBorderOuter;
	Rzcommon::TSides FBorderSides;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderHighlight;
	Graphics::TColor FBorderShadow;
	Graphics::TColor FFlatColor;
	int FFlatColorAdjustment;
	Rzcommon::TRzVisualStyle FVisualStyle;
	Rzcommon::TRzGradientColorStyle FGradientColorStyle;
	Graphics::TColor FGradientColorStart;
	Graphics::TColor FGradientColorStop;
	Rzcommon::TGradientDirection FGradientDirection;
	bool FTransparent;
	Classes::TStringList* FEnabledList;
	Classes::TNotifyEvent FOnPaint;
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	MESSAGE void __fastcall WMThemeChanged(Messages::TMessage &Msg);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FThemeAware;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Types::TPoint __fastcall CursorPosition();
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	virtual void __fastcall FixClientRect(Types::TRect &Rect, bool ShrinkByBorder);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	virtual Types::TRect __fastcall GetControlRect();
	virtual void __fastcall GetGradientColors(Graphics::TColor &StartColor, Graphics::TColor &StopColor);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CustomFramingChanged(void);
	virtual void __fastcall SetBorderColor(Graphics::TColor Value);
	virtual void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderSides(Rzcommon::TSides Value);
	virtual void __fastcall SetBorderHighlight(Graphics::TColor Value);
	virtual void __fastcall SetBorderShadow(Graphics::TColor Value);
	virtual void __fastcall SetFlatColor(Graphics::TColor Value);
	virtual void __fastcall SetFlatColorAdjustment(int Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetGradientColorStyle(Rzcommon::TRzGradientColorStyle Value);
	virtual void __fastcall SetGradientColorStart(Graphics::TColor Value);
	virtual void __fastcall SetGradientColorStop(Graphics::TColor Value);
	virtual void __fastcall SetGradientDirection(Rzcommon::TGradientDirection Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual void __fastcall SetVisualStyle(Rzcommon::TRzVisualStyle Value);
	
public:
	__fastcall virtual TRzFlowPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzFlowPanel(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property Canvas ;
	__property DockManager ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Rzcommon::TFrameStyleEx BorderInner = {read=FBorderInner, write=SetBorderInner, default=0};
	__property Rzcommon::TFrameStyleEx BorderOuter = {read=FBorderOuter, write=SetBorderOuter, default=6};
	__property Rzcommon::TSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777201};
	__property Graphics::TColor BorderHighlight = {read=FBorderHighlight, write=SetBorderHighlight, default=-16777196};
	__property Graphics::TColor BorderShadow = {read=FBorderShadow, write=SetBorderShadow, default=-16777200};
	__property Graphics::TColor FlatColor = {read=FFlatColor, write=SetFlatColor, default=-16777200};
	__property int FlatColorAdjustment = {read=FFlatColorAdjustment, write=SetFlatColorAdjustment, default=30};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Rzcommon::TRzGradientColorStyle GradientColorStyle = {read=FGradientColorStyle, write=SetGradientColorStyle, default=0};
	__property Graphics::TColor GradientColorStart = {read=FGradientColorStart, write=SetGradientColorStart, default=16777215};
	__property Graphics::TColor GradientColorStop = {read=FGradientColorStop, write=SetGradientColorStop, default=-16777201};
	__property Rzcommon::TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=2};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Rzcommon::TRzVisualStyle VisualStyle = {read=FVisualStyle, write=SetVisualStyle, default=1};
	__property Classes::TNotifyEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=0};
	__property AutoWrap  = {default=1};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderWidth  = {default=0};
	__property Color  = {default=-16777201};
	__property Constraints ;
	__property Ctl3D ;
	__property DockSite  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FlowStyle  = {default=0};
	__property Font ;
	__property FullRepaint  = {default=1};
	__property Locked  = {default=0};
	__property Padding ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Visible  = {default=1};
	__property OnCanResize ;
	__property OnClick ;
	__property OnConstrainedResize ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzFlowPanel(HWND ParentWindow) : Extctrls::TCustomFlowPanel(ParentWindow) { }
	#pragma option pop
	
private:
	void *__IRzCustomFramingNotification;	/* Rzcommon::IRzCustomFramingNotification */
	
public:
	operator IRzCustomFramingNotification*(void) { return (IRzCustomFramingNotification*)&__IRzCustomFramingNotification; }
	
};


class DELPHICLASS TRzGridPanel;
class PASCALIMPLEMENTATION TRzGridPanel : public Extctrls::TCustomGridPanel 
{
	typedef Extctrls::TCustomGridPanel inherited;
	
private:
	bool FInAlignControls;
	Rzcommon::TFrameStyleEx FBorderInner;
	Rzcommon::TFrameStyleEx FBorderOuter;
	Rzcommon::TSides FBorderSides;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderHighlight;
	Graphics::TColor FBorderShadow;
	Graphics::TColor FFlatColor;
	int FFlatColorAdjustment;
	Rzcommon::TRzVisualStyle FVisualStyle;
	Rzcommon::TRzGradientColorStyle FGradientColorStyle;
	Graphics::TColor FGradientColorStart;
	Graphics::TColor FGradientColorStop;
	Rzcommon::TGradientDirection FGradientDirection;
	bool FTransparent;
	Classes::TStringList* FEnabledList;
	Classes::TNotifyEvent FOnPaint;
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	MESSAGE void __fastcall WMThemeChanged(Messages::TMessage &Msg);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Types::TPoint __fastcall CursorPosition();
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	virtual void __fastcall FixClientRect(Types::TRect &Rect, bool ShrinkByBorder);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	virtual Types::TRect __fastcall GetControlRect();
	virtual void __fastcall GetGradientColors(Graphics::TColor &StartColor, Graphics::TColor &StopColor);
	void __fastcall DrawGridLines(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CustomFramingChanged(void);
	virtual void __fastcall SetBorderColor(Graphics::TColor Value);
	virtual void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderSides(Rzcommon::TSides Value);
	virtual void __fastcall SetBorderHighlight(Graphics::TColor Value);
	virtual void __fastcall SetBorderShadow(Graphics::TColor Value);
	virtual void __fastcall SetFlatColor(Graphics::TColor Value);
	virtual void __fastcall SetFlatColorAdjustment(int Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetGradientColorStyle(Rzcommon::TRzGradientColorStyle Value);
	virtual void __fastcall SetGradientColorStart(Graphics::TColor Value);
	virtual void __fastcall SetGradientColorStop(Graphics::TColor Value);
	virtual void __fastcall SetGradientDirection(Rzcommon::TGradientDirection Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual void __fastcall SetVisualStyle(Rzcommon::TRzVisualStyle Value);
	
public:
	__fastcall virtual TRzGridPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzGridPanel(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property Canvas ;
	__property DockManager ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Rzcommon::TFrameStyleEx BorderInner = {read=FBorderInner, write=SetBorderInner, default=0};
	__property Rzcommon::TFrameStyleEx BorderOuter = {read=FBorderOuter, write=SetBorderOuter, default=6};
	__property Rzcommon::TSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777201};
	__property Graphics::TColor BorderHighlight = {read=FBorderHighlight, write=SetBorderHighlight, default=-16777196};
	__property Graphics::TColor BorderShadow = {read=FBorderShadow, write=SetBorderShadow, default=-16777200};
	__property Graphics::TColor FlatColor = {read=FFlatColor, write=SetFlatColor, default=-16777200};
	__property int FlatColorAdjustment = {read=FFlatColorAdjustment, write=SetFlatColorAdjustment, default=30};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Rzcommon::TRzGradientColorStyle GradientColorStyle = {read=FGradientColorStyle, write=SetGradientColorStyle, default=0};
	__property Graphics::TColor GradientColorStart = {read=FGradientColorStart, write=SetGradientColorStart, default=16777215};
	__property Graphics::TColor GradientColorStop = {read=FGradientColorStop, write=SetGradientColorStop, default=-16777201};
	__property Rzcommon::TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=2};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Rzcommon::TRzVisualStyle VisualStyle = {read=FVisualStyle, write=SetVisualStyle, default=1};
	__property Classes::TNotifyEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=0};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderWidth  = {default=0};
	__property Color  = {default=-16777201};
	__property ColumnCollection ;
	__property Constraints ;
	__property ControlCollection ;
	__property Ctl3D ;
	__property DockSite  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property ExpandStyle  = {default=0};
	__property Font ;
	__property FullRepaint  = {default=1};
	__property Locked  = {default=0};
	__property Padding ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property RowCollection ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Visible  = {default=1};
	__property OnCanResize ;
	__property OnClick ;
	__property OnConstrainedResize ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzGridPanel(HWND ParentWindow) : Extctrls::TCustomGridPanel(ParentWindow) { }
	#pragma option pop
	
private:
	void *__IRzCustomFramingNotification;	/* Rzcommon::IRzCustomFramingNotification */
	
public:
	operator IRzCustomFramingNotification*(void) { return (IRzCustomFramingNotification*)&__IRzCustomFramingNotification; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzpanel */
using namespace Rzpanel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzpanel
