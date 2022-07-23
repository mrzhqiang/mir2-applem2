// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzsplit.pas' rev: 10.00

#ifndef RzsplitHPP
#define RzsplitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzsplit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzSplitterPane;
class DELPHICLASS TRzSplitter;
class DELPHICLASS TRzPaneData;
#pragma option push -b-
enum TSelectedPane { spUpperLeft, spLowerRight };
#pragma option pop

#pragma option push -b-
enum TFixedPane { fpUpperLeft, fpLowerRight };
#pragma option pop

#pragma option push -b-
enum TSplitterStyle { ssStandard, ssGroove, ssBump, ssGroupBar };
#pragma option pop

#pragma option push -b-
enum THotSpotDirection { hsdMin, hsdMax, hsdBoth };
#pragma option pop

class PASCALIMPLEMENTATION TRzSplitter : public Rzpanel::TRzCustomPanel 
{
	typedef Rzpanel::TRzCustomPanel inherited;
	
private:
	Rzcommon::TOrientation FOrientation;
	TRzPaneData* FPaneData[2];
	TRzSplitterPane* FPanes[2];
	Classes::TStringList* FPanesControlList[2];
	TSelectedPane FSelectedPane;
	int FPosition;
	int FMarginMin;
	int FMarginMax;
	bool FUsePercent;
	int FPercent;
	int FPercentMin;
	int FPercentMax;
	TFixedPane FFixedPane;
	int FFixedSize;
	bool FResizing;
	Word FSplitterWidth;
	TSplitterStyle FSplitterStyle;
	bool FRealTimeDrag;
	bool FLockBar;
	#pragma pack(push,1)
	Types::TRect FBarRect;
	#pragma pack(pop)
	int FOrigPos;
	HICON FHorzCursor;
	HICON FHorzCursorHotSpot;
	HICON FVertCursor;
	HICON FVertCursorHotSpot;
	bool FSliding;
	int FCenterOffset;
	int FManualPosition;
	int FLastPos;
	Graphics::TBrush* FBrush;
	HBRUSH FPrevBrush;
	HDC FMaskDC;
	bool FOutsideHotSpot;
	bool FHotSpotVisible;
	Graphics::TColor FHotSpotHighlight;
	Graphics::TColor FHotSpotColor;
	Graphics::TColor FHotSpotDotColor;
	Graphics::TColor FHotSpotFrameColor;
	#pragma pack(push,1)
	Types::TRect FHotSpotRect;
	#pragma pack(pop)
	THotSpotDirection FHotSpotDirection;
	bool FHotSpotClosed;
	bool FHotSpotClosedToMin;
	bool FHotSpotClosedToMax;
	bool FHotSpotting;
	int FHotSpotPosition;
	bool FHotSpotIgnoreMargins;
	int FHotSpotSizePercent;
	bool FRefreshHotSpot;
	int FGradientColorAdjustment;
	Rzcommon::TRzGroupBarGradientPath FGradientPath;
	Classes::TNotifyEvent FOnChange;
	Rzcommon::TPositionChangingEvent FOnChanging;
	Classes::TNotifyEvent FOnHotSpotClick;
	Controls::TGetSiteInfoEvent FOnULGetSiteInfo;
	Controls::TDockOverEvent FOnULDockOver;
	Controls::TDockDropEvent FOnULDockDrop;
	Controls::TUnDockEvent FOnULUnDock;
	Controls::TGetSiteInfoEvent FOnLRGetSiteInfo;
	Controls::TDockOverEvent FOnLRDockOver;
	Controls::TDockDropEvent FOnLRDockDrop;
	Controls::TUnDockEvent FOnLRUnDock;
	void __fastcall ReadBarSize(Classes::TReader* Reader);
	void __fastcall WriteBarSize(Classes::TWriter* Writer);
	void __fastcall ReadHotSpotClosed(Classes::TReader* Reader);
	void __fastcall WriteHotSpotClosed(Classes::TWriter* Writer);
	void __fastcall ReadHotSpotClosedToMin(Classes::TReader* Reader);
	void __fastcall WriteHotSpotClosedToMin(Classes::TWriter* Writer);
	void __fastcall ReadHotSpotClosedToMax(Classes::TReader* Reader);
	void __fastcall WriteHotSpotClosedToMax(Classes::TWriter* Writer);
	void __fastcall ReadHotSpotPosition(Classes::TReader* Reader);
	void __fastcall WriteHotSpotPosition(Classes::TWriter* Writer);
	void __fastcall ReadULControls(Classes::TReader* Reader);
	void __fastcall WriteULControls(Classes::TWriter* Writer);
	void __fastcall ReadLRControls(Classes::TReader* Reader);
	void __fastcall WriteLRControls(Classes::TWriter* Writer);
	void __fastcall AllocateMaskDC(void);
	void __fastcall ReleaseMaskDC(void);
	void __fastcall ULGetSiteInfoHandler(System::TObject* Sender, Controls::TControl* DockClient, Types::TRect &InfluenceRect, const Types::TPoint &MousePos, bool &CanDock);
	void __fastcall ULDockOverHandler(System::TObject* Sender, Controls::TDragDockObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall ULDockDropHandler(System::TObject* Sender, Controls::TDragDockObject* Source, int X, int Y);
	void __fastcall ULUnDockHandler(System::TObject* Sender, Controls::TControl* Client, Controls::TWinControl* NewTarget, bool &Allow);
	void __fastcall LRGetSiteInfoHandler(System::TObject* Sender, Controls::TControl* DockClient, Types::TRect &InfluenceRect, const Types::TPoint &MousePos, bool &CanDock);
	void __fastcall LRDockOverHandler(System::TObject* Sender, Controls::TDragDockObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall LRDockDropHandler(System::TObject* Sender, Controls::TDragDockObject* Source, int X, int Y);
	void __fastcall LRUnDockHandler(System::TObject* Sender, Controls::TControl* Client, Controls::TWinControl* NewTarget, bool &Allow);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMShowWindow(Messages::TWMShowWindow &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual Types::TRect __fastcall GetClientRect();
	virtual void __fastcall ShowControl(Controls::TControl* AControl);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall UpdateFixedSize(void);
	virtual int __fastcall GetBorderOffset(void);
	virtual void __fastcall DrawMask(int NewPos);
	virtual void __fastcall UpdateHotSpotRect(void);
	virtual void __fastcall UpdateHotSpotHighlight(void);
	virtual void __fastcall DrawHotSpot(bool Highlight, const Types::TPoint &P);
	virtual void __fastcall DrawSplitterBar(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CheckPosition(int &Value);
	virtual void __fastcall UpdateManualPosition(int P);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC bool __fastcall CanChange(int NewPos);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall HotSpotClick(void);
	virtual void __fastcall SetOrientation(Rzcommon::TOrientation Value);
	virtual void __fastcall SetSelectedPane(TSelectedPane Value);
	virtual TRzSplitterPane* __fastcall GetSelectedPaneControl(void);
	virtual void __fastcall SetFixedPane(TFixedPane Value);
	virtual TRzPaneData* __fastcall GetPaneData(int Index);
	virtual void __fastcall SetPaneData(int Index, TRzPaneData* Value);
	virtual void __fastcall SetPosition(int Value);
	virtual void __fastcall SetLockedPosition(int Value);
	virtual void __fastcall SetMarginMax(int Value);
	virtual void __fastcall SetMarginMin(int Value);
	virtual bool __fastcall GetParentColor(void);
	HIDESBASE virtual void __fastcall SetParentColor(bool Value);
	virtual void __fastcall SetPercent(int Value);
	virtual void __fastcall SetUsePercent(bool Value);
	virtual void __fastcall SetPercentMax(int Value);
	virtual void __fastcall SetPercentMin(int Value);
	virtual void __fastcall SetSplitterStyle(TSplitterStyle Value);
	virtual void __fastcall SetSplitterWidth(Word Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual void __fastcall SetGradientColorAdjustment(int Value);
	virtual void __fastcall SetGradientPath(Rzcommon::TRzGroupBarGradientPath Value);
	Controls::TBorderWidth __fastcall GetBorderWidth(void);
	HIDESBASE void __fastcall SetBorderWidth(Controls::TBorderWidth Value);
	virtual void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderSides(Rzcommon::TSides Value);
	virtual void __fastcall SetHotSpotVisible(bool Value);
	void __fastcall SetHotSpotColor(Graphics::TColor Value);
	void __fastcall SetHotSpotDotColor(Graphics::TColor Value);
	void __fastcall SetHotSpotFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetHotSpotHighlight(Graphics::TColor Value);
	virtual void __fastcall SetHotSpotDirection(THotSpotDirection Value);
	virtual void __fastcall SetHotSpotSizePercent(int Value);
	
public:
	__fastcall virtual TRzSplitter(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzSplitter(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	virtual void __fastcall ResizePanes(void);
	virtual void __fastcall ResetHotSpot(void);
	void __fastcall RestoreHotSpot(void);
	void __fastcall CloseHotSpot(void)/* overload */;
	void __fastcall CloseHotSpot(bool ToMin)/* overload */;
	__property bool HotSpotClosed = {read=FHotSpotClosed, nodefault};
	__property bool HotSpotClosedToMin = {read=FHotSpotClosedToMin, nodefault};
	__property bool HotSpotClosedToMax = {read=FHotSpotClosedToMax, nodefault};
	__property int HotSpotPosition = {read=FHotSpotPosition, nodefault};
	__property Types::TRect HotSpotRect = {read=FHotSpotRect};
	__property int LockedPosition = {read=FPosition, write=SetLockedPosition, nodefault};
	__property TRzSplitterPane* SelectedPaneControl = {read=GetSelectedPaneControl};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Controls::TBorderWidth BorderWidth = {read=GetBorderWidth, write=SetBorderWidth, default=0};
	__property int GradientColorAdjustment = {read=FGradientColorAdjustment, write=SetGradientColorAdjustment, default=30};
	__property TFixedPane FixedPane = {read=FFixedPane, write=SetFixedPane, default=0};
	__property Rzcommon::TRzGroupBarGradientPath GradientPath = {read=FGradientPath, write=SetGradientPath, default=0};
	__property bool LockBar = {read=FLockBar, write=FLockBar, default=0};
	__property int MarginMax = {read=FMarginMax, write=SetMarginMax, default=0};
	__property int MarginMin = {read=FMarginMin, write=SetMarginMin, default=0};
	__property Rzcommon::TOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property bool ParentColor = {read=GetParentColor, write=SetParentColor, default=0};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property int Percent = {read=FPercent, write=SetPercent, default=50};
	__property int PercentMax = {read=FPercentMax, write=SetPercentMax, default=100};
	__property int PercentMin = {read=FPercentMin, write=SetPercentMin, default=0};
	__property bool UsePercent = {read=FUsePercent, write=SetUsePercent, default=0};
	__property bool RealTimeDrag = {read=FRealTimeDrag, write=FRealTimeDrag, default=0};
	__property TRzPaneData* UpperLeft = {read=GetPaneData, write=SetPaneData, stored=true, index=1};
	__property TRzPaneData* LowerRight = {read=GetPaneData, write=SetPaneData, stored=true, index=2};
	__property bool HotSpotVisible = {read=FHotSpotVisible, write=SetHotSpotVisible, default=0};
	__property Graphics::TColor HotSpotColor = {read=FHotSpotColor, write=SetHotSpotColor, default=-16777201};
	__property Graphics::TColor HotSpotDotColor = {read=FHotSpotDotColor, write=SetHotSpotDotColor, default=-16777203};
	__property Graphics::TColor HotSpotFrameColor = {read=FHotSpotFrameColor, write=SetHotSpotFrameColor, default=-16777200};
	__property Graphics::TColor HotSpotHighlight = {read=FHotSpotHighlight, write=SetHotSpotHighlight, default=-16777211};
	__property bool HotSpotIgnoreMargins = {read=FHotSpotIgnoreMargins, write=FHotSpotIgnoreMargins, default=1};
	__property THotSpotDirection HotSpotDirection = {read=FHotSpotDirection, write=SetHotSpotDirection, default=0};
	__property int HotSpotSizePercent = {read=FHotSpotSizePercent, write=SetHotSpotSizePercent, default=40};
	__property TSelectedPane SelectedPane = {read=FSelectedPane, write=SetSelectedPane, stored=false, nodefault};
	__property TSplitterStyle SplitterStyle = {read=FSplitterStyle, write=SetSplitterStyle, default=0};
	__property Word SplitterWidth = {read=FSplitterWidth, write=SetSplitterWidth, stored=true, default=4};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Rzcommon::TPositionChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property Classes::TNotifyEvent OnHotSpotClick = {read=FOnHotSpotClick, write=FOnHotSpotClick};
	__property Controls::TGetSiteInfoEvent OnULGetSiteInfo = {read=FOnULGetSiteInfo, write=FOnULGetSiteInfo};
	__property Controls::TDockOverEvent OnULDockOver = {read=FOnULDockOver, write=FOnULDockOver};
	__property Controls::TDockDropEvent OnULDockDrop = {read=FOnULDockDrop, write=FOnULDockDrop};
	__property Controls::TUnDockEvent OnULUnDock = {read=FOnULUnDock, write=FOnULUnDock};
	__property Controls::TGetSiteInfoEvent OnLRGetSiteInfo = {read=FOnLRGetSiteInfo, write=FOnLRGetSiteInfo};
	__property Controls::TDockOverEvent OnLRDockOver = {read=FOnLRDockOver, write=FOnLRDockOver};
	__property Controls::TDockDropEvent OnLRDockDrop = {read=FOnLRDockDrop, write=FOnLRDockDrop};
	__property Controls::TUnDockEvent OnLRUnDock = {read=FOnLRUnDock, write=FOnLRUnDock};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property BevelWidth  = {default=1};
	__property BorderColor  = {default=-16777201};
	__property BorderHighlight  = {default=-16777196};
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=0};
	__property BorderShadow  = {default=-16777200};
	__property BorderSides  = {default=15};
	__property Color  = {default=-16777201};
	__property Constraints ;
	__property Enabled  = {default=1};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=30};
	__property FullRepaint  = {default=1};
	__property GradientColorStyle  = {default=0};
	__property GradientColorStart  = {default=16777215};
	__property GradientColorStop  = {default=-16777201};
	__property GradientDirection  = {default=2};
	__property Height  = {default=100};
	__property Locked  = {default=0};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Transparent  = {default=0};
	__property Visible  = {default=1};
	__property VisualStyle  = {default=1};
	__property Width  = {default=200};
	__property OnCanResize ;
	__property OnConstrainedResize ;
	__property OnContextPopup ;
	__property OnEnter ;
	__property OnExit ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzSplitter(HWND ParentWindow) : Rzpanel::TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzSplitterPane : public Rzpanel::TRzCustomPanel 
{
	typedef Rzpanel::TRzCustomPanel inherited;
	
private:
	TRzSplitter* FSplitter;
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	bool __fastcall GetVisible(void);
	HIDESBASE void __fastcall SetVisible(bool Value);
	
public:
	__fastcall virtual TRzSplitterPane(Classes::TComponent* AOwner);
	
__published:
	__property bool Visible = {read=GetVisible, write=SetVisible, default=1};
	__property Color  = {default=-16777201};
	__property BorderColor  = {default=-16777201};
	__property BorderOuter  = {default=0};
	__property BorderInner  = {default=0};
	__property BorderWidth  = {default=0};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=30};
	__property TabStop  = {default=0};
	__property ShowDockClientCaptions  = {default=1};
	__property Padding ;
	__property OnContextPopup ;
public:
	#pragma option push -w-inl
	/* TRzCustomPanel.Destroy */ inline __fastcall virtual ~TRzSplitterPane(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzSplitterPane(HWND ParentWindow) : Rzpanel::TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzPaneData : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TRzSplitterPane* FPane;
	
protected:
	Graphics::TColor __fastcall GetBorderColor(void);
	void __fastcall SetBorderColor(Graphics::TColor Value);
	Rzcommon::TFrameStyleEx __fastcall GetBorderInner(void);
	void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	Rzcommon::TFrameStyleEx __fastcall GetBorderOuter(void);
	void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	Controls::TBorderWidth __fastcall GetBorderWidth(void);
	void __fastcall SetBorderWidth(Controls::TBorderWidth Value);
	Graphics::TColor __fastcall GetColor(void);
	void __fastcall SetColor(Graphics::TColor Value);
	bool __fastcall GetDockSite(void);
	void __fastcall SetDockSite(bool Value);
	Graphics::TColor __fastcall GetFlatColor(void);
	void __fastcall SetFlatColor(Graphics::TColor Value);
	int __fastcall GetFlatColorAdjustment(void);
	void __fastcall SetFlatColorAdjustment(int Value);
	bool __fastcall GetShowDockClientCaptions(void);
	void __fastcall SetShowDockClientCaptions(bool Value);
	bool __fastcall GetVisible(void);
	void __fastcall SetVisible(bool Value);
	Controls::TPadding* __fastcall GetPadding(void);
	void __fastcall SetPadding(Controls::TPadding* Value);
	
public:
	__property TRzSplitterPane* Pane = {read=FPane};
	
__published:
	__property Graphics::TColor BorderColor = {read=GetBorderColor, write=SetBorderColor, default=-16777201};
	__property Rzcommon::TFrameStyleEx BorderInner = {read=GetBorderInner, write=SetBorderInner, default=0};
	__property Rzcommon::TFrameStyleEx BorderOuter = {read=GetBorderOuter, write=SetBorderOuter, default=0};
	__property Controls::TBorderWidth BorderWidth = {read=GetBorderWidth, write=SetBorderWidth, default=0};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, default=-16777201};
	__property Graphics::TColor FlatColor = {read=GetFlatColor, write=SetFlatColor, default=-16777200};
	__property int FlatColorAdjustment = {read=GetFlatColorAdjustment, write=SetFlatColorAdjustment, default=30};
	__property bool DockSite = {read=GetDockSite, write=SetDockSite, default=0};
	__property bool ShowDockClientCaptions = {read=GetShowDockClientCaptions, write=SetShowDockClientCaptions, default=1};
	__property bool Visible = {read=GetVisible, write=SetVisible, default=1};
	__property Controls::TPadding* Padding = {read=GetPadding, write=SetPadding};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRzPaneData(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TRzPaneData(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


#pragma option push -b-
enum THotSpotPosition { hspOpen, hspClosed };
#pragma option pop

class DELPHICLASS TRzSizePanelDockManager;
class DELPHICLASS TRzCustomSizePanel;
typedef int TSizeBarWidth;

class PASCALIMPLEMENTATION TRzCustomSizePanel : public Rzpanel::TRzCustomPanel 
{
	typedef Rzpanel::TRzCustomPanel inherited;
	
private:
	int FMarginMin;
	int FMarginMax;
	int FMarginOffset;
	HICON FHorzCursor;
	HICON FHorzCursorHotSpot;
	HICON FVertCursor;
	HICON FVertCursorHotSpot;
	bool FLockBar;
	TSizeBarWidth FSizeBarWidth;
	TSplitterStyle FSizeBarStyle;
	bool FResizing;
	bool FOutsideHotSpot;
	bool FHotSpotVisible;
	Graphics::TColor FHotSpotHighlight;
	Graphics::TColor FHotSpotColor;
	Graphics::TColor FHotSpotDotColor;
	Graphics::TColor FHotSpotFrameColor;
	#pragma pack(push,1)
	Types::TRect FHotSpotRect;
	#pragma pack(pop)
	bool FHotSpotClosed;
	bool FHotSpotting;
	int FHotSpotPosition;
	Rzcommon::TSide FSide;
	Classes::TNotifyEvent FOnHotSpotClick;
	bool FHotSpotIgnoreMargins;
	int FHotSpotSizePercent;
	bool FRefreshHotSpot;
	bool FRealTimeDrag;
	int FOrigPos;
	int FOrigWidth;
	int FOrigHeight;
	int FCenterOffset;
	int FLastPos;
	Graphics::TBrush* FBrush;
	HBRUSH FPrevBrush;
	HDC FMaskDC;
	int FGradientColorAdjustment;
	Rzcommon::TRzGroupBarGradientPath FGradientPath;
	void __fastcall ReadHotSpotClosed(Classes::TReader* Reader);
	void __fastcall WriteHotSpotClosed(Classes::TWriter* Writer);
	void __fastcall ReadHotSpotPosition(Classes::TReader* Reader);
	void __fastcall WriteHotSpotPosition(Classes::TWriter* Writer);
	void __fastcall AllocateMaskDC(void);
	void __fastcall ReleaseMaskDC(void);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall FixClientRect(Types::TRect &Rect, bool ShrinkByBorder);
	virtual Types::TRect __fastcall GetClientRect();
	virtual Types::TRect __fastcall GetControlRect();
	virtual void __fastcall DrawMask(int NewPos);
	virtual void __fastcall UpdateHotSpotRect(const Types::TRect &BarRect);
	virtual void __fastcall UpdateHotSpotHighlight(void);
	virtual void __fastcall DrawHotSpot(bool Highlight);
	virtual void __fastcall DrawSizeBar(void);
	virtual void __fastcall Paint(void);
	virtual Types::TRect __fastcall GetParentWorkingRect();
	virtual void __fastcall CheckPosition(int &Value);
	virtual bool __fastcall HotSpotTopBottom(void);
	DYNAMIC Controls::_di_IDockManager __fastcall CreateDockManager();
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall HotSpotClick(void);
	virtual Controls::TAlign __fastcall GetAlign(void);
	HIDESBASE virtual void __fastcall SetAlign(Controls::TAlign Value);
	virtual void __fastcall SetSizeBarWidth(TSizeBarWidth Value);
	virtual void __fastcall SetSizeBarStyle(TSplitterStyle Value);
	virtual Types::TRect __fastcall GetSizeBarRect();
	virtual int __fastcall GetMarginExtent(void);
	virtual void __fastcall SetMarginMax(int Value);
	virtual void __fastcall SetMarginMin(int Value);
	virtual void __fastcall SetHotSpotVisible(bool Value);
	void __fastcall SetHotSpotColor(Graphics::TColor Value);
	void __fastcall SetHotSpotDotColor(Graphics::TColor Value);
	void __fastcall SetHotSpotFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetHotSpotHighlight(Graphics::TColor Value);
	virtual void __fastcall SetHotSpotSizePercent(int Value);
	virtual void __fastcall SetSide(Rzcommon::TSide Value);
	virtual void __fastcall SetGradientColorAdjustment(int Value);
	virtual void __fastcall SetGradientPath(Rzcommon::TRzGroupBarGradientPath Value);
	__property Controls::TAlign Align = {read=GetAlign, write=SetAlign, default=3};
	__property BorderOuter  = {default=0};
	__property int GradientColorAdjustment = {read=FGradientColorAdjustment, write=SetGradientColorAdjustment, default=30};
	__property Rzcommon::TRzGroupBarGradientPath GradientPath = {read=FGradientPath, write=SetGradientPath, default=0};
	__property TSizeBarWidth SizeBarWidth = {read=FSizeBarWidth, write=SetSizeBarWidth, default=4};
	__property TSplitterStyle SizeBarStyle = {read=FSizeBarStyle, write=SetSizeBarStyle, default=0};
	__property int MarginMin = {read=FMarginMin, write=SetMarginMin, default=0};
	__property int MarginMax = {read=FMarginMax, write=SetMarginMax, default=0};
	__property bool LockBar = {read=FLockBar, write=FLockBar, default=0};
	__property bool HotSpotClosed = {read=FHotSpotClosed, nodefault};
	__property int HotSpotPosition = {read=FHotSpotPosition, nodefault};
	__property Types::TRect HotSpotRect = {read=FHotSpotRect};
	__property bool HotSpotVisible = {read=FHotSpotVisible, write=SetHotSpotVisible, default=0};
	__property Graphics::TColor HotSpotColor = {read=FHotSpotColor, write=SetHotSpotColor, default=-16777201};
	__property Graphics::TColor HotSpotDotColor = {read=FHotSpotDotColor, write=SetHotSpotDotColor, default=-16777203};
	__property Graphics::TColor HotSpotFrameColor = {read=FHotSpotFrameColor, write=SetHotSpotFrameColor, default=-16777200};
	__property Graphics::TColor HotSpotHighlight = {read=FHotSpotHighlight, write=SetHotSpotHighlight, default=-16777211};
	__property bool HotSpotIgnoreMargins = {read=FHotSpotIgnoreMargins, write=FHotSpotIgnoreMargins, default=0};
	__property int HotSpotSizePercent = {read=FHotSpotSizePercent, write=SetHotSpotSizePercent, default=40};
	__property Rzcommon::TSide Side = {read=FSide, write=SetSide, default=0};
	__property bool RealTimeDrag = {read=FRealTimeDrag, write=FRealTimeDrag, default=0};
	__property Classes::TNotifyEvent OnHotSpotClick = {read=FOnHotSpotClick, write=FOnHotSpotClick};
	
public:
	__fastcall virtual TRzCustomSizePanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomSizePanel(void);
	virtual void __fastcall ResetHotSpot(void);
	void __fastcall RestoreHotSpot(void);
	void __fastcall CloseHotSpot(void);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomSizePanel(HWND ParentWindow) : Rzpanel::TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzSizePanelDockManager : public Rzpanel::TRzPanelDockManager 
{
	typedef Rzpanel::TRzPanelDockManager inherited;
	
private:
	TRzCustomSizePanel* FSizePanel;
	
protected:
	virtual void __fastcall PositionDockRect(Controls::TControl* Client, Controls::TControl* DropCtl, Controls::TAlign DropAlign, Types::TRect &DockRect);
	virtual void __fastcall PaintDockFrame(Graphics::TCanvas* Canvas, Controls::TControl* Control, const Types::TRect &ARect);
	
public:
	__fastcall virtual TRzSizePanelDockManager(Controls::TWinControl* DockSite);
	virtual void __fastcall PaintSite(HDC DC);
public:
	#pragma option push -w-inl
	/* TRzPanelDockManager.Destroy */ inline __fastcall virtual ~TRzSizePanelDockManager(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzSizePanel;
class PASCALIMPLEMENTATION TRzSizePanel : public TRzCustomSizePanel 
{
	typedef TRzCustomSizePanel inherited;
	
public:
	__property HotSpotClosed ;
	__property HotSpotPosition ;
	__property HotSpotRect ;
	__property DockManager ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Align  = {default=3};
	__property Alignment  = {default=2};
	__property AlignmentVertical  = {default=1};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=0};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderColor  = {default=-16777201};
	__property BorderHighlight  = {default=-16777196};
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=0};
	__property BorderShadow  = {default=-16777200};
	__property BorderSides  = {default=15};
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
	__property FullRepaint  = {default=1};
	__property GradientColorAdjustment  = {default=30};
	__property GradientColorStyle  = {default=0};
	__property GradientColorStart  = {default=16777215};
	__property GradientColorStop  = {default=-16777201};
	__property GradientDirection  = {default=2};
	__property GradientPath  = {default=0};
	__property HotSpotColor  = {default=-16777201};
	__property HotSpotDotColor  = {default=-16777203};
	__property HotSpotFrameColor  = {default=-16777200};
	__property HotSpotHighlight  = {default=-16777211};
	__property HotSpotIgnoreMargins  = {default=0};
	__property HotSpotSizePercent  = {default=40};
	__property HotSpotVisible  = {default=0};
	__property Side  = {default=0};
	__property LockBar  = {default=0};
	__property Locked  = {default=0};
	__property MarginMax  = {default=0};
	__property MarginMin  = {default=0};
	__property Padding ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property RealTimeDrag  = {default=0};
	__property ShowDockClientCaptions  = {default=1};
	__property ShowHint ;
	__property SizeBarStyle  = {default=0};
	__property SizeBarWidth  = {default=4};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property UseDockManager  = {default=1};
	__property Visible  = {default=1};
	__property VisualStyle  = {default=1};
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
	__property OnHotSpotClick ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TRzCustomSizePanel.Create */ inline __fastcall virtual TRzSizePanel(Classes::TComponent* AOwner) : TRzCustomSizePanel(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomSizePanel.Destroy */ inline __fastcall virtual ~TRzSizePanel(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzSizePanel(HWND ParentWindow) : TRzCustomSizePanel(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzsplit */
using namespace Rzsplit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzsplit
