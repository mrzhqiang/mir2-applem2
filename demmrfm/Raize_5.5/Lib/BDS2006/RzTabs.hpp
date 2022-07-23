// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rztabs.pas' rev: 10.00

#ifndef RztabsHPP
#define RztabsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzgrafx.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rztabs
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS ERzTabControlError;
class PASCALIMPLEMENTATION ERzTabControlError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ERzTabControlError(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ERzTabControlError(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ERzTabControlError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ERzTabControlError(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ERzTabControlError(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ERzTabControlError(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ERzTabControlError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ERzTabControlError(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ERzTabControlError(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzTabScrollerBtn { sbDownLeft, sbUpRight };
#pragma option pop

class DELPHICLASS TRzTabScroller;
class DELPHICLASS TRzCustomTabControl;
class DELPHICLASS TRzTabDataList;
class DELPHICLASS TRzTabData;
class PASCALIMPLEMENTATION TRzTabDataList : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
public:
	TRzTabData* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TList* FTabList;
	
protected:
	virtual int __fastcall GetCount(void);
	virtual TRzTabData* __fastcall GetItem(int Index);
	virtual void __fastcall SetItem(int Index, TRzTabData* Value);
	
public:
	__fastcall TRzTabDataList(void);
	__fastcall virtual ~TRzTabDataList(void);
	int __fastcall Add(TRzTabData* Item);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Clear(void);
	void __fastcall Delete(int Index);
	TRzTabData* __fastcall First(void);
	int __fastcall IndexOf(TRzTabData* Item);
	void __fastcall Insert(int Index, TRzTabData* Item);
	TRzTabData* __fastcall Last(void);
	void __fastcall Move(int CurIndex, int NewIndex);
	int __fastcall Remove(TRzTabData* Item);
	__property int Count = {read=GetCount, nodefault};
	__property TRzTabData* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};


class DELPHICLASS TRzTabRegionCache;
class PASCALIMPLEMENTATION TRzTabRegionCache : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TList* FCache;
	int FCapacity;
	int __fastcall GetCount(void);
	void __fastcall SetCapacity(int Value);
	
public:
	__fastcall TRzTabRegionCache(void);
	__fastcall virtual ~TRzTabRegionCache(void);
	void __fastcall Add(const Types::TRect &ARect, HRGN ARegion);
	void __fastcall Clear(void);
	HRGN __fastcall Find(const Types::TRect &ARect);
	__property int Capacity = {read=FCapacity, write=SetCapacity, default=1};
	__property int Count = {read=GetCount, nodefault};
};


class DELPHICLASS TRzTabControlCloseButton;
class PASCALIMPLEMENTATION TRzTabControlCloseButton : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Graphics::TColor FFrameColor;
	TRzCustomTabControl* FTabControl;
	bool FPressed;
	bool FDown;
	bool FMouseOverButton;
	Classes::TNotifyEvent FOnClose;
	void __fastcall UpdateTracking(void);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall DoClose(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	
public:
	__fastcall virtual TRzTabControlCloseButton(Classes::TComponent* AOwner);
	
__published:
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777200};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TRzTabControlCloseButton(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzTabControlCloseButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzActiveTabCloseButton;
class PASCALIMPLEMENTATION TRzActiveTabCloseButton : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Graphics::TColor FFrameColor;
	TRzCustomTabControl* FTabControl;
	bool FPressed;
	bool FDown;
	bool FMouseOverButton;
	Classes::TNotifyEvent FOnClose;
	void __fastcall UpdateTracking(void);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall DoClose(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	
public:
	__fastcall virtual TRzActiveTabCloseButton(Classes::TComponent* AOwner);
	
__published:
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777200};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
public:
	#pragma option push -w-inl
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TRzActiveTabCloseButton(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzTabMenuButton;
class PASCALIMPLEMENTATION TRzTabMenuButton : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Graphics::TColor FFrameColor;
	TRzCustomTabControl* FTabControl;
	Menus::TPopupMenu* FMenu;
	bool FPressed;
	bool FDown;
	bool FMouseOverButton;
	Classes::TNotifyEvent FOnDisplayMenu;
	void __fastcall TabSelectedHandler(System::TObject* Sender);
	void __fastcall UpdateTracking(void);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall DisplayMenu(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	
public:
	__fastcall virtual TRzTabMenuButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzTabMenuButton(void);
	
__published:
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777200};
	__property Classes::TNotifyEvent OnDisplayMenu = {read=FOnDisplayMenu, write=FOnDisplayMenu};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzTabMenuButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzImagePosition { ipLeft, ipTop, ipRight, ipBottom, ipBack, ipStretch };
#pragma option pop

#pragma option push -b-
enum TRzHorizontalAlignment { haLeft, haCenter, haRight };
#pragma option pop

#pragma option push -b-
enum TRzVerticalAlignment { vaTop, vaCenter, vaBottom };
#pragma option pop

#pragma option push -b-
enum TRzTabHotTrackColorSource { htcsTabColor, htcsHotTrackColorProp };
#pragma option pop

#pragma option push -b-
enum TRzTabHotTrackStyle { htsTab, htsText, htsTabBar };
#pragma option pop

#pragma option push -b-
enum TRzTabOrientation { toTop, toLeft, toBottom, toRight };
#pragma option pop

#pragma option push -b-
enum TRzTabSequence { tsStandard, tsReverse };
#pragma option pop

#pragma option push -b-
enum TRzTabStyle { tsSingleSlant, tsDoubleSlant, tsCutCorner, tsRoundCorners, tsBackSlant, tsSquareCorners };
#pragma option pop

class DELPHICLASS TRzTabColors;
class PASCALIMPLEMENTATION TRzTabColors : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TRzCustomTabControl* FTabControl;
	Graphics::TColor FHighlightBar;
	Graphics::TColor FShadow;
	Graphics::TColor FUnselected;
	
protected:
	virtual void __fastcall SetHighlightBar(Graphics::TColor Value);
	virtual void __fastcall SetShadow(Graphics::TColor Value);
	virtual void __fastcall SetUnselected(Graphics::TColor Value);
	
public:
	__fastcall TRzTabColors(TRzCustomTabControl* TabControl);
	
__published:
	__property Graphics::TColor HighlightBar = {read=FHighlightBar, write=SetHighlightBar, default=-16777203};
	__property Graphics::TColor Shadow = {read=FShadow, write=SetShadow, default=-16777201};
	__property Graphics::TColor Unselected = {read=FUnselected, write=SetUnselected, default=-16777211};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRzTabColors(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzTextColors;
class PASCALIMPLEMENTATION TRzTextColors : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TRzCustomTabControl* FTabControl;
	Graphics::TColor FDisabled;
	Graphics::TColor FSelected;
	Graphics::TColor FUnselected;
	
protected:
	virtual void __fastcall SetDisabled(Graphics::TColor Value);
	virtual void __fastcall SetSelected(Graphics::TColor Value);
	virtual void __fastcall SetUnselected(Graphics::TColor Value);
	
public:
	__fastcall TRzTextColors(TRzCustomTabControl* TabControl);
	
__published:
	__property Graphics::TColor Disabled = {read=FDisabled, write=SetDisabled, default=-16777199};
	__property Graphics::TColor Selected = {read=FSelected, write=SetSelected, default=-16777198};
	__property Graphics::TColor Unselected = {read=FUnselected, write=SetUnselected, default=-16777198};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRzTextColors(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TRzTabChangingEvent)(System::TObject* Sender, int NewIndex, bool &AllowChange);

typedef void __fastcall (__closure *TRzTabCloseEvent)(System::TObject* Sender, bool &AllowClose);

#pragma option push -b-
enum TRzTextStyle { tsHotTrack, tsSelected, tsUnselected, tsDisabled };
#pragma option pop

typedef void __fastcall (__closure *TRzGetTextColorEvent)(System::TObject* Sender, int ATabIndex, TRzTextStyle AStyle, Graphics::TColor &AColor, bool &Handled);

typedef void __fastcall (__closure *TRzPaintBackgroundEvent)(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool &Handled);

typedef void __fastcall (__closure *TRzPaintCardBackgroundEvent)(System::TObject* Sender, Graphics::TCanvas* ACanvas, int ARow, const Types::TRect &ARect, bool &Handled);

typedef void __fastcall (__closure *TRzPaintTabBackgroundEvent)(System::TObject* Sender, Graphics::TCanvas* ACanvas, int ATabIndex, const Types::TRect &ARect, bool &Handled);

typedef void __fastcall (__closure *TRzTabOrderChangeEvent)(System::TObject* Sender, int OldIndex, int NewIndex);

typedef void __fastcall (__closure *TRzTabDraggingEvent)(System::TObject* Sender, int TabIndex, bool &AllowDrag);

typedef Types::TPoint TRzTabRegionPts[20];

class PASCALIMPLEMENTATION TRzCustomTabControl : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Graphics::TBitmap* FBuffer;
	bool FCalcNeeded;
	Classes::TStringList* FCalcTextExtentLines;
	bool FChangingDone;
	Classes::TList* FCommands;
	bool FDoneTabIndexDefault;
	Classes::TStringList* FDrawTabTextLines;
	int FFirstInView;
	int FFixedDimension;
	Graphics::TColor FFocusRectBrushColor;
	Classes::TList* FHFonts;
	#pragma pack(push,1)
	Types::TPoint FHitTest;
	#pragma pack(pop)
	int FHotTrackIndex;
	AnsiString FOriginalHint;
	#pragma pack(push,1)
	Types::TRect FPrevDisplayRect;
	#pragma pack(pop)
	int FRowExtent;
	TRzTabScroller* FScroller;
	bool FScrollerNeeded;
	TRzTabDataList* FTabDataList;
	TRzTabRegionCache* FTabRegionCache;
	int FTabRegionCacheSize;
	TRzTabControlCloseButton* FCloseButton;
	bool FShowCloseButton;
	TRzActiveTabCloseButton* FActiveTabCloseButton;
	bool FShowCloseButtonOnActiveTab;
	TRzTabMenuButton* FMenuButton;
	bool FShowMenuButton;
	bool FSortTabMenu;
	Graphics::TFont* FTextFont;
	unsigned FTimerHandle;
	Extctrls::TTimer* FScrollTimer;
	Word FInitialDelay;
	Word FDelay;
	bool FAlignTabs;
	Graphics::TColor FBackgroundColor;
	bool FBoldCurrentTab;
	Graphics::TColor FButtonColor;
	bool FShowCard;
	bool FShowCardFrame;
	bool FShowFullFrame;
	bool FUseColoredTabs;
	int FCutCornerSize;
	Graphics::TColor FFlatColor;
	int FFlatColorAdjustment;
	TRzImagePosition FImagePosition;
	TRzHorizontalAlignment FImageAlignment;
	int FImageMargin;
	TRzVerticalAlignment FImageAlignmentVertical;
	Graphics::TColor FHotTrackColor;
	TRzTabHotTrackColorSource FHotTrackColorSource;
	Rzcommon::TRzHotTrackColorType FHotTrackColorType;
	bool FHotTrack;
	TRzTabHotTrackStyle FHotTrackStyle;
	bool FHotTracking;
	Imglist::TCustomImageList* FImages;
	Imglist::TChangeLink* FImagesChangeLink;
	int FMargin;
	bool FMultiLine;
	bool FParentBackgroundColor;
	int FRowIndent;
	int FRowOverlap;
	Graphics::TColor FScrollBtnArrowColor;
	Graphics::TColor FScrollBtnFaceColor;
	Rzcommon::TOrientation FTextOrientation;
	int FTabHeight;
	bool FTabHints;
	int FTabIndex;
	int FTabIndexDefault;
	TRzTabOrientation FTabOrientation;
	TRzTabSequence FTabSequence;
	TRzTabStyle FTabStyle;
	int FTabWidth;
	int FTabOverlap;
	bool FSoftCorners;
	int FRawDragTabIndex;
	TRzTabColors* FTabColors;
	TRzTextColors* FTextColors;
	TRzHorizontalAlignment FTextAlignment;
	TRzVerticalAlignment FTextAlignmentVertical;
	bool FShowShadow;
	bool FUseGradients;
	bool FTransparent;
	bool FShowFocusRect;
	bool FAllowTabDragging;
	#pragma pack(push,1)
	Types::TRect FLastDragOverRect;
	#pragma pack(pop)
	int FLastMoveTabIndex;
	bool FMoveTabIndicatorVisible;
	Graphics::TColor FDragIndicatorColor;
	Classes::TNotifyEvent FOnAlignControls;
	Classes::TNotifyEvent FOnPageChange;
	Classes::TNotifyEvent FOnChange;
	TRzTabChangingEvent FOnChanging;
	TRzTabCloseEvent FOnClose;
	TRzGetTextColorEvent FOnGetTextColor;
	TRzPaintBackgroundEvent FOnPaintBackground;
	TRzPaintCardBackgroundEvent FOnPaintCardBackground;
	TRzPaintTabBackgroundEvent FOnPaintTabBackground;
	Classes::TNotifyEvent FOnTabClick;
	TRzTabOrderChangeEvent FOnTabOrderChange;
	TRzTabDraggingEvent FOnTabDragging;
	Classes::TNotifyEvent FOnScrolledTabs;
	void __fastcall AddCommand(const int Command);
	void __fastcall AddCommandPt(const int Command, const Types::TPoint &APoint);
	void __fastcall AlignScroller(void);
	void __fastcall AlignCloseButton(void);
	void __fastcall AlignMenuButton(void);
	void __fastcall BringTabToFrontRow(TRzTabData* TabData);
	void __fastcall CalcCardDrawCommands(int ARow);
	tagSIZE __fastcall CalcDefaultTabFaceExtent(Graphics::TFont* AFont);
	tagSIZE __fastcall CalcImageExtent(Imglist::TImageIndex AImageIndex);
	Types::TRect __fastcall CalcMappedCardRect(int ARow);
	Types::TRect __fastcall CalcMappedTabRect(int ATabIndex, TRzTabData* TabData);
	void __fastcall CalcMappedTabRegionPts(int ATabIndex, Types::TPoint * Pts, int &NumPts);
	Types::TPoint __fastcall CalcMapPoint(const Types::TPoint &RawPt);
	Types::TRect __fastcall CalcMapRect(const Types::TRect &RawRect);
	void __fastcall CalcMetrics(void);
	void __fastcall CalcScrollerNeeded(void);
	tagSIZE __fastcall CalcTabExtentFromTabFaceExtent(const tagSIZE &TabFaceExtent);
	Types::TRect __fastcall CalcTabFaceRect(const Types::TRect &ARect);
	HRGN __fastcall CalcTabRegion(int ATabIndex, const Types::TRect &ARect);
	void __fastcall CalcTabRegionPts(int ATabIndex, Types::TPoint * Pts, int &NumPts);
	tagSIZE __fastcall CalcTextExtent(const AnsiString S, bool Horizontal);
	void __fastcall CalcTabDrawCommands(int ATabIndex);
	Types::TRect __fastcall CalcTabRect(int ATabIndex, TRzTabData* TabData);
	Types::TRect __fastcall CalcWholeRect();
	void __fastcall CancelHotTrackTimer(void);
	bool __fastcall CanSelectTab(int ATabIndex);
	void __fastcall CheckCalcNeeded(void);
	void __fastcall CreateScroller(void);
	void __fastcall CreateCloseButton(void);
	void __fastcall CreateActiveTabCloseButton(void);
	void __fastcall CreateMenuButton(void);
	void __fastcall DeselectFont(void);
	void __fastcall DoRealign(void);
	void __fastcall DoTextOut(const Types::TRect &ARect, int X, int Y, const AnsiString AString, Graphics::TCanvas* ACanvas, bool Horizontal, Graphics::TColor AColor);
	void __fastcall ProcessCommands(void);
	void __fastcall DrawTabBackground(int ATabIndex, const Types::TRect &ARect);
	void __fastcall DrawTabFace(int ATabIndex, const Types::TRect &ARect);
	void __fastcall DrawTabs(void);
	void __fastcall DrawControlButtons(void);
	Types::TRect __fastcall GetDisplayRect();
	int __fastcall GetExtraTopMargin(void);
	int __fastcall GetFirstVisible(void);
	int __fastcall GetIndexHeight(void);
	Types::TRect __fastcall GetIndexRect();
	int __fastcall GetIndexWidth(void);
	int __fastcall GetInitialTabOffset(void);
	int __fastcall GetLastVisible(void);
	int __fastcall GetScrollerWidth(void);
	int __fastcall GetScrollerHeight(void);
	int __fastcall GetCloseButtonWidth(void);
	int __fastcall GetCloseButtonHeight(void);
	int __fastcall GetMenuButtonWidth(void);
	int __fastcall GetMenuButtonHeight(void);
	int __fastcall GetTabOffset(int ATabHeight);
	bool __fastcall IsBackgroundColorStored(void);
	void __fastcall ParseTextLines(const AnsiString S, Classes::TStrings* Lines);
	HFONT __fastcall PopHFont(void);
	void __fastcall PushHFont(HFONT Value);
	void __fastcall ScrollTabs(bool Next);
	void __fastcall SelectFont(void);
	void __fastcall StopHotTracking(void);
	void __fastcall ReadFixedDimension(Classes::TReader* Reader);
	void __fastcall WriteFixedDimension(Classes::TWriter* Writer);
	void __fastcall ImagesChange(System::TObject* Sender);
	void __fastcall ScrollUpRightClickHandler(System::TObject* Sender);
	void __fastcall ScrollDownLeftClickHandler(System::TObject* Sender);
	void __fastcall CloseButtonClickHandler(System::TObject* Sender);
	void __fastcall ScrollTimerExpired(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Msg);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	virtual void __fastcall Changing(int NewIndex, bool &Allowed);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	TRzTabDataList* __fastcall GetTabDataList(void);
	virtual void __fastcall GetTextColor(int ATabIndex, TRzTextStyle AStyle, Graphics::TColor &AColor, bool &Handled);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	virtual void __fastcall Rebuild(void);
	virtual void __fastcall TabClick(void);
	bool __fastcall ShowAccel(void);
	bool __fastcall ShowFocus(void);
	bool __fastcall TabInView(TRzTabData* TabData);
	HIDESBASE virtual void __fastcall InvalidateControl(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintBackground(Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool &Handled);
	virtual void __fastcall PaintCardBackground(Graphics::TCanvas* ACanvas, int ARow, const Types::TRect &ARect, bool &Handled);
	virtual void __fastcall PaintTabBackground(Graphics::TCanvas* ACanvas, int ATabIndex, const Types::TRect &ARect, bool &Handled);
	virtual void __fastcall DrawMoveTabIndicator(const Types::TRect &R);
	virtual void __fastcall DestroyActiveTab(void);
	virtual void __fastcall ActiveTabMoved(int Index);
	virtual bool __fastcall UpdatingTabs(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	DYNAMIC void __fastcall TabOrderChange(int OldIndex, int NewIndex);
	DYNAMIC bool __fastcall CanDragTab(int TabIndex);
	DYNAMIC void __fastcall PageChange(void);
	DYNAMIC bool __fastcall CanClose(void);
	virtual void __fastcall SetAlignTabs(bool Value);
	virtual void __fastcall SetBackgroundColor(Graphics::TColor Value);
	virtual void __fastcall SetBoldCurrentTab(bool Value);
	virtual void __fastcall SetButtonColor(Graphics::TColor Value);
	virtual void __fastcall SetCalcNeeded(bool Value);
	virtual void __fastcall SetShowCard(bool Value);
	virtual void __fastcall SetShowCardFrame(bool Value);
	virtual void __fastcall SetShowFullFrame(bool Value);
	virtual void __fastcall SetShowCloseButton(bool Value);
	virtual void __fastcall SetShowCloseButtonOnActiveTab(bool Value);
	virtual void __fastcall SetShowMenuButton(bool Value);
	virtual void __fastcall SetUseColoredTabs(bool Value);
	virtual void __fastcall SetCutCornerSize(int Value);
	virtual void __fastcall SetFlatColor(Graphics::TColor Value);
	virtual void __fastcall SetFlatColorAdjustment(int Value);
	virtual void __fastcall SetImagePosition(TRzImagePosition Value);
	virtual void __fastcall SetImageAlignment(TRzHorizontalAlignment Value);
	virtual void __fastcall SetImageMargin(int Value);
	virtual void __fastcall SetImageAlignmentVertical(TRzVerticalAlignment Value);
	virtual void __fastcall SetHotTrack(bool Value);
	virtual void __fastcall SetHotTrackColor(Graphics::TColor Value);
	virtual void __fastcall SetHotTrackColorSource(TRzTabHotTrackColorSource Value);
	virtual void __fastcall SetHotTrackColorType(Rzcommon::TRzHotTrackColorType Value);
	virtual void __fastcall SetHotTrackStyle(TRzTabHotTrackStyle Value);
	virtual void __fastcall SetImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetMargin(int Value);
	virtual void __fastcall SetMultiLine(bool Value);
	virtual void __fastcall SetParentBackgroundColor(bool Value);
	virtual void __fastcall SetRowExtent(int Value);
	virtual void __fastcall SetRowIndent(int Value);
	virtual void __fastcall SetRowOverlap(int Value);
	virtual void __fastcall SetShowFocusRect(bool Value);
	virtual void __fastcall SetShowShadow(bool Value);
	virtual void __fastcall SetSoftCorners(bool Value);
	virtual void __fastcall SetTabOverlap(int Value);
	virtual void __fastcall SetTextOrientation(Rzcommon::TOrientation Value);
	virtual void __fastcall SetTabColors(TRzTabColors* Value);
	virtual void __fastcall SetTabHeight(int Value);
	virtual void __fastcall SetTabHints(bool Value);
	virtual void __fastcall SetTabIndex(int Value);
	virtual void __fastcall SetTabOrientation(TRzTabOrientation Value);
	virtual void __fastcall SetTabRegionCacheSize(int Value);
	virtual void __fastcall SetTabSequence(TRzTabSequence Value);
	virtual void __fastcall SetTabStyle(TRzTabStyle Value);
	virtual void __fastcall SetTabWidth(int Value);
	virtual void __fastcall SetTextColors(TRzTextColors* Value);
	virtual void __fastcall SetTextAlignment(TRzHorizontalAlignment Value);
	virtual void __fastcall SetTextAlignmentVertical(TRzVerticalAlignment Value);
	virtual void __fastcall SetUseGradients(bool Value);
	virtual void __fastcall SetTransparent(bool Value);
	__property bool AlignTabs = {read=FAlignTabs, write=SetAlignTabs, default=0};
	__property bool AllowTabDragging = {read=FAllowTabDragging, write=FAllowTabDragging, default=0};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=SetBackgroundColor, stored=IsBackgroundColorStored, nodefault};
	__property bool BoldCurrentTab = {read=FBoldCurrentTab, write=SetBoldCurrentTab, default=0};
	__property Graphics::TColor ButtonColor = {read=FButtonColor, write=SetButtonColor, default=-16777201};
	__property int CutCornerSize = {read=FCutCornerSize, write=SetCutCornerSize, default=6};
	__property Types::TRect DisplayRect = {read=GetDisplayRect};
	__property Graphics::TColor DragIndicatorColor = {read=FDragIndicatorColor, write=FDragIndicatorColor, default=5263440};
	__property Graphics::TColor FlatColor = {read=FFlatColor, write=SetFlatColor, default=-16777200};
	__property int FlatColorAdjustment = {read=FFlatColorAdjustment, write=SetFlatColorAdjustment, default=0};
	__property TRzHorizontalAlignment ImageAlignment = {read=FImageAlignment, write=SetImageAlignment, default=1};
	__property int ImageMargin = {read=FImageMargin, write=SetImageMargin, default=2};
	__property TRzImagePosition ImagePosition = {read=FImagePosition, write=SetImagePosition, default=0};
	__property TRzVerticalAlignment ImageAlignmentVertical = {read=FImageAlignmentVertical, write=SetImageAlignmentVertical, default=1};
	__property bool HotTrack = {read=FHotTrack, write=SetHotTrack, default=1};
	__property Graphics::TColor HotTrackColor = {read=FHotTrackColor, write=SetHotTrackColor, default=1350640};
	__property TRzTabHotTrackColorSource HotTrackColorSource = {read=FHotTrackColorSource, write=SetHotTrackColorSource, default=0};
	__property Rzcommon::TRzHotTrackColorType HotTrackColorType = {read=FHotTrackColorType, write=SetHotTrackColorType, default=1};
	__property TRzTabHotTrackStyle HotTrackStyle = {read=FHotTrackStyle, write=SetHotTrackStyle, default=0};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property int Margin = {read=FMargin, write=SetMargin, default=0};
	__property bool MultiLine = {read=FMultiLine, write=SetMultiLine, default=0};
	__property bool ParentBackgroundColor = {read=FParentBackgroundColor, write=SetParentBackgroundColor, default=1};
	__property int RowIndent = {read=FRowIndent, write=SetRowIndent, default=5};
	__property int RowOverlap = {read=FRowOverlap, write=SetRowOverlap, default=5};
	__property TRzTabScroller* Scroller = {read=FScroller, stored=false};
	__property TRzTabControlCloseButton* CloseButton = {read=FCloseButton, stored=false};
	__property TRzActiveTabCloseButton* ActiveTabCloseButton = {read=FActiveTabCloseButton, stored=false};
	__property TRzTabMenuButton* MenuButton = {read=FMenuButton, stored=false};
	__property bool ShowCard = {read=FShowCard, write=SetShowCard, default=1};
	__property bool ShowCardFrame = {read=FShowCardFrame, write=SetShowCardFrame, default=1};
	__property bool ShowCloseButton = {read=FShowCloseButton, write=SetShowCloseButton, default=0};
	__property bool ShowCloseButtonOnActiveTab = {read=FShowCloseButtonOnActiveTab, write=SetShowCloseButtonOnActiveTab, default=0};
	__property bool ShowMenuButton = {read=FShowMenuButton, write=SetShowMenuButton, default=0};
	__property bool SortTabMenu = {read=FSortTabMenu, write=FSortTabMenu, default=1};
	__property bool ShowFocusRect = {read=FShowFocusRect, write=SetShowFocusRect, default=1};
	__property bool ShowFullFrame = {read=FShowFullFrame, write=SetShowFullFrame, default=1};
	__property bool ShowShadow = {read=FShowShadow, write=SetShowShadow, default=1};
	__property bool SoftCorners = {read=FSoftCorners, write=SetSoftCorners, default=0};
	__property int TabOverlap = {read=FTabOverlap, write=SetTabOverlap, default=-1};
	__property Rzcommon::TOrientation TextOrientation = {read=FTextOrientation, write=SetTextOrientation, default=0};
	__property TRzTabColors* TabColors = {read=FTabColors, write=SetTabColors};
	__property int TabHeight = {read=FTabHeight, write=SetTabHeight, default=0};
	__property bool TabHints = {read=FTabHints, write=SetTabHints, default=0};
	__property int TabIndex = {read=FTabIndex, write=SetTabIndex, default=-1};
	__property int TabIndexDefault = {read=FTabIndexDefault, write=FTabIndexDefault, default=0};
	__property TRzTabOrientation TabOrientation = {read=FTabOrientation, write=SetTabOrientation, default=0};
	__property int TabRegionCacheSize = {read=FTabRegionCacheSize, write=SetTabRegionCacheSize, default=1};
	__property TRzTabSequence TabSequence = {read=FTabSequence, write=SetTabSequence, default=0};
	__property TRzTabStyle TabStyle = {read=FTabStyle, write=SetTabStyle, default=0};
	__property int TabWidth = {read=FTabWidth, write=SetTabWidth, default=0};
	__property TRzTextColors* TextColors = {read=FTextColors, write=SetTextColors};
	__property TRzHorizontalAlignment TextAlignment = {read=FTextAlignment, write=SetTextAlignment, default=1};
	__property TRzVerticalAlignment TextAlignmentVertical = {read=FTextAlignmentVertical, write=SetTextAlignmentVertical, default=1};
	__property bool UseColoredTabs = {read=FUseColoredTabs, write=SetUseColoredTabs, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool UseGradients = {read=FUseGradients, write=SetUseGradients, default=1};
	__property Classes::TNotifyEvent OnAlignControls = {read=FOnAlignControls, write=FOnAlignControls};
	__property Classes::TNotifyEvent OnPageChange = {read=FOnPageChange, write=FOnPageChange};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TRzTabChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TRzTabCloseEvent OnClose = {read=FOnClose, write=FOnClose};
	__property TRzGetTextColorEvent OnGetTextColor = {read=FOnGetTextColor, write=FOnGetTextColor};
	__property TRzPaintBackgroundEvent OnPaintBackground = {read=FOnPaintBackground, write=FOnPaintBackground};
	__property TRzPaintCardBackgroundEvent OnPaintCardBackground = {read=FOnPaintCardBackground, write=FOnPaintCardBackground};
	__property TRzPaintTabBackgroundEvent OnPaintTabBackground = {read=FOnPaintTabBackground, write=FOnPaintTabBackground};
	__property Classes::TNotifyEvent OnTabClick = {read=FOnTabClick, write=FOnTabClick};
	__property TRzTabDraggingEvent OnTabDragging = {read=FOnTabDragging, write=FOnTabDragging};
	__property TRzTabOrderChangeEvent OnTabOrderChange = {read=FOnTabOrderChange, write=FOnTabOrderChange};
	__property Classes::TNotifyEvent OnScrolledTabs = {read=FOnScrolledTabs, write=FOnScrolledTabs};
	
public:
	__fastcall virtual TRzCustomTabControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomTabControl(void);
	virtual void __fastcall Change(void);
	void __fastcall CloseActiveTab(void);
	virtual void __fastcall HideAllTabs(void);
	virtual void __fastcall ShowAllTabs(void);
	int __fastcall GetExtentOfAllTabs(void);
	int __fastcall TabAtPos(int X, int Y);
	bool __fastcall TabIndexInView(int Index);
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	__property TabStop  = {default=1};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomTabControl(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzTabScroller : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Graphics::TColor FFrameColor;
	Rzcommon::TOrientation FOrientation;
	TRzCustomTabControl* FTabControl;
	bool FPressed;
	bool FDown;
	bool FMouseOverButton;
	TRzTabScrollerBtn FOver;
	TRzTabScrollerBtn FCurrent;
	Extctrls::TTimer* FRepeatTimer;
	Word FInitialDelay;
	Word FDelay;
	Classes::TNotifyEvent FOnUpRightClick;
	Classes::TNotifyEvent FOnDownLeftClick;
	void __fastcall UpdateTracking(void);
	void __fastcall RepeatTimerExpired(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DownLeftClick(void);
	DYNAMIC void __fastcall UpRightClick(void);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetOrientation(Rzcommon::TOrientation Value);
	
public:
	__fastcall virtual TRzTabScroller(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzTabScroller(void);
	
__published:
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777200};
	__property Rzcommon::TOrientation Orientation = {read=FOrientation, write=SetOrientation, stored=false, nodefault};
	__property Classes::TNotifyEvent OnUpRightClick = {read=FOnUpRightClick, write=FOnUpRightClick};
	__property Classes::TNotifyEvent OnDownLeftClick = {read=FOnDownLeftClick, write=FOnDownLeftClick};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzTabScroller(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzTextExtentCache;
class PASCALIMPLEMENTATION TRzTextExtentCache : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TStringList* FCache;
	
public:
	__fastcall TRzTextExtentCache(void);
	__fastcall virtual ~TRzTextExtentCache(void);
	void __fastcall Add(const AnsiString AString, const tagSIZE &Extent);
	void __fastcall Clear(void);
	bool __fastcall Find(const AnsiString AString, tagSIZE &Extent);
};


class PASCALIMPLEMENTATION TRzTabData : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FCaption;
	Graphics::TColor FColor;
	Imglist::TImageIndex FDisabledIndex;
	bool FEnabled;
	AnsiString FHint;
	Imglist::TImageIndex FImageIndex;
	#pragma pack(push,1)
	Types::TRect FRawRect;
	#pragma pack(pop)
	bool FVisible;
	int FRow;
	
public:
	__fastcall TRzTabData(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property AnsiString Caption = {read=FCaption, write=FCaption};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=-16777201};
	__property Imglist::TImageIndex DisabledIndex = {read=FDisabledIndex, write=FDisabledIndex, default=-1};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property AnsiString Hint = {read=FHint, write=FHint};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=FImageIndex, default=-1};
	__property Types::TRect RawRect = {read=FRawRect, write=FRawRect};
	__property int Row = {read=FRow, write=FRow, default=0};
	__property bool Visible = {read=FVisible, write=FVisible, default=1};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRzTabData(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzTabSheet;
class DELPHICLASS TRzPageControl;
class PASCALIMPLEMENTATION TRzPageControl : public TRzCustomTabControl 
{
	typedef TRzCustomTabControl inherited;
	
private:
	TRzTabSheet* FActivePage;
	TRzTabSheet* FActivePageDefault;
	TRzTabSheet* FNewDockSheet;
	TRzTabSheet* FUndockingPage;
	bool FDblClickUndocks;
	Classes::TList* FPages;
	bool FSaveResources;
	bool FInitActivePage;
	void __fastcall ChangeActivePage(TRzTabSheet* Page);
	void __fastcall InsertPage(TRzTabSheet* Page);
	void __fastcall RemovePage(TRzTabSheet* Page);
	Controls::TControl* __fastcall GetDockClientFromMousePos(const Types::TPoint &MousePos);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMDockClient(Controls::TCMDockClient &Msg);
	MESSAGE void __fastcall CMDockNotification(Controls::TCMDockNotification &Msg);
	HIDESBASE MESSAGE void __fastcall CMUnDockClient(Controls::TCMUnDockClient &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	
protected:
	virtual void __fastcall Changing(int NewIndex, bool &Allowed);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DestroyActiveTab(void);
	virtual void __fastcall ActiveTabMoved(int Index);
	virtual void __fastcall PaintCardBackground(Graphics::TCanvas* ACanvas, int ARow, const Types::TRect &ARect, bool &Handled);
	virtual void __fastcall Rebuild(void);
	DYNAMIC void __fastcall SetChildOrder(Classes::TComponent* Child, int Order);
	virtual void __fastcall ShowControl(Controls::TControl* AControl);
	DYNAMIC void __fastcall DoAddDockClient(Controls::TControl* Client, const Types::TRect &ARect);
	DYNAMIC void __fastcall DockOver(Controls::TDragDockObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	DYNAMIC void __fastcall DoRemoveDockClient(Controls::TControl* Client);
	TRzTabSheet* __fastcall GetPageFromDockClient(Controls::TControl* Client);
	DYNAMIC void __fastcall GetSiteInfo(Controls::TControl* Client, Types::TRect &InfluenceRect, const Types::TPoint &MousePos, bool &CanDock);
	virtual TRzTabSheet* __fastcall GetPage(int Index);
	virtual int __fastcall GetPageCount(void);
	virtual void __fastcall SetActivePage(TRzTabSheet* Page);
	virtual int __fastcall GetActivePageIndex(void);
	virtual void __fastcall SetActivePageIndex(int Value);
	virtual void __fastcall SetUseColoredTabs(bool Value);
	virtual void __fastcall SetSaveResources(bool Value);
	
public:
	__fastcall virtual TRzPageControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzPageControl(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	DYNAMIC void __fastcall PageChange(void);
	virtual void __fastcall Change(void);
	TRzTabSheet* __fastcall FindNextPage(TRzTabSheet* CurPage, bool GoForward, bool CheckTabVisible);
	TRzTabSheet* __fastcall PageForTab(int ATabIndex);
	void __fastcall SelectNextPage(bool GoForward);
	virtual void __fastcall HideAllTabs(void);
	virtual void __fastcall ShowAllTabs(void);
	void __fastcall MakeControlVisible(Controls::TControl* AControl);
	__property int PageCount = {read=GetPageCount, nodefault};
	__property TRzTabSheet* Pages[int Index] = {read=GetPage};
	__property int ActivePageIndex = {read=GetActivePageIndex, write=SetActivePageIndex, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property TRzTabSheet* ActivePage = {read=FActivePage, write=SetActivePage};
	__property TRzTabSheet* ActivePageDefault = {read=FActivePageDefault, write=FActivePageDefault};
	__property bool SaveResources = {read=FSaveResources, write=SetSaveResources, default=0};
	__property bool DblClickUndocks = {read=FDblClickUndocks, write=FDblClickUndocks, default=1};
	__property Align  = {default=0};
	__property AlignTabs  = {default=0};
	__property AllowTabDragging  = {default=0};
	__property Anchors  = {default=3};
	__property BackgroundColor ;
	__property BoldCurrentTab  = {default=0};
	__property ButtonColor  = {default=-16777201};
	__property Color  = {default=-16777201};
	__property UseColoredTabs  = {default=0};
	__property Constraints ;
	__property CutCornerSize  = {default=6};
	__property DockSite  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragIndicatorColor  = {default=5263440};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=0};
	__property ImageAlignment  = {default=1};
	__property ImageMargin  = {default=2};
	__property ImagePosition  = {default=0};
	__property ImageAlignmentVertical  = {default=1};
	__property HelpContext  = {default=0};
	__property Hint ;
	__property HotTrack  = {default=1};
	__property HotTrackColor  = {default=1350640};
	__property HotTrackColorSource  = {default=0};
	__property HotTrackColorType  = {default=1};
	__property HotTrackStyle  = {default=0};
	__property Images ;
	__property Margin  = {default=0};
	__property MultiLine  = {default=0};
	__property ParentBackgroundColor  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property RowIndent  = {default=5};
	__property RowOverlap  = {default=5};
	__property ShowCardFrame  = {default=1};
	__property ShowCloseButton  = {default=0};
	__property ShowCloseButtonOnActiveTab  = {default=0};
	__property ShowMenuButton  = {default=0};
	__property SortTabMenu  = {default=1};
	__property ShowFocusRect  = {default=1};
	__property ShowFullFrame  = {default=1};
	__property ShowHint ;
	__property ShowShadow  = {default=1};
	__property SoftCorners  = {default=0};
	__property TabOverlap  = {default=-1};
	__property TextOrientation  = {default=0};
	__property TabColors ;
	__property TabHeight  = {default=0};
	__property TabHints  = {default=0};
	__property TabIndex  = {default=-1};
	__property TabOrder  = {default=-1};
	__property TabOrientation  = {default=0};
	__property TabSequence  = {default=0};
	__property TabStop  = {default=1};
	__property TabStyle  = {default=0};
	__property TabWidth  = {default=0};
	__property TextColors ;
	__property TextAlignment  = {default=1};
	__property TextAlignmentVertical  = {default=1};
	__property Transparent  = {default=0};
	__property UseGradients  = {default=1};
	__property Visible  = {default=1};
	__property OnChange ;
	__property OnChanging ;
	__property OnClick ;
	__property OnClose ;
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
	__property OnGetTextColor ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnAlignControls ;
	__property OnPageChange ;
	__property OnPaintBackground ;
	__property OnPaintCardBackground ;
	__property OnPaintTabBackground ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnTabClick ;
	__property OnTabDragging ;
	__property OnTabOrderChange ;
	__property OnScrolledTabs ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzPageControl(HWND ParentWindow) : TRzCustomTabControl(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzTabSheet : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Imglist::TImageIndex FDisabledIndex;
	Imglist::TImageIndex FImageIndex;
	TRzPageControl* FPageControl;
	bool FTabEnabled;
	bool FTabVisible;
	TRzPaintBackgroundEvent FOnPaintBackground;
	Classes::TNotifyEvent FOnHide;
	Classes::TNotifyEvent FOnShow;
	void *FData;
	void __fastcall AssignToTabData(Classes::TPersistent* Dest);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall InternalSetVisible(bool Value);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall AssignTo(Classes::TPersistent* Dest);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall DestroyHandle(void);
	virtual void __fastcall Paint(void);
	void __fastcall PaintBackground(Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool &Handled);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	DYNAMIC void __fastcall DoHide(void);
	DYNAMIC void __fastcall DoShow(void);
	virtual Graphics::TColor __fastcall GetColor(void);
	HIDESBASE virtual void __fastcall SetColor(Graphics::TColor Value);
	virtual void __fastcall SetDisabledIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetImageIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetPageControl(TRzPageControl* APageControl);
	virtual int __fastcall GetPageIndex(void);
	virtual void __fastcall SetPageIndex(int Value);
	virtual void __fastcall SetTabEnabled(bool Value);
	virtual int __fastcall GetTabIndex(void);
	virtual void __fastcall SetTabVisible(bool Value);
	virtual bool __fastcall GetVisible(void);
	HIDESBASE virtual void __fastcall SetVisible(bool Value);
	
public:
	__fastcall virtual TRzTabSheet(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzTabSheet(void);
	__property void * Data = {read=FData, write=FData};
	__property TRzPageControl* PageControl = {read=FPageControl, write=SetPageControl};
	__property int TabIndex = {read=GetTabIndex, nodefault};
	__property bool Visible = {read=GetVisible, write=SetVisible, nodefault};
	
__published:
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, default=-16777201};
	__property Imglist::TImageIndex DisabledIndex = {read=FDisabledIndex, write=SetDisabledIndex, default=-1};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property int PageIndex = {read=GetPageIndex, write=SetPageIndex, stored=false, nodefault};
	__property bool TabEnabled = {read=FTabEnabled, write=SetTabEnabled, default=1};
	__property bool TabVisible = {read=FTabVisible, write=SetTabVisible, default=1};
	__property TRzPaintBackgroundEvent OnPaintBackground = {read=FOnPaintBackground, write=FOnPaintBackground};
	__property Classes::TNotifyEvent OnHide = {read=FOnHide, write=FOnHide};
	__property Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property Caption ;
	__property Constraints ;
	__property Enabled  = {default=1};
	__property Font ;
	__property Height  = {stored=false};
	__property Left  = {stored=false};
	__property Padding ;
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property Top  = {stored=false};
	__property Width  = {stored=false};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzTabSheet(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzTabCollectionItem;
class DELPHICLASS TRzCollectionTabControl;
class PASCALIMPLEMENTATION TRzTabCollectionItem : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	AnsiString FCaption;
	Graphics::TColor FColor;
	Imglist::TImageIndex FDisabledIndex;
	bool FEnabled;
	AnsiString FHint;
	Imglist::TImageIndex FImageIndex;
	bool FVisible;
	int FTag;
	void *FData;
	void __fastcall AssignToTabData(Classes::TPersistent* Dest);
	
protected:
	virtual AnsiString __fastcall GetDisplayName();
	virtual void __fastcall AssignTo(Classes::TPersistent* Dest);
	virtual void __fastcall SetCaption(const AnsiString Value);
	virtual void __fastcall SetColor(Graphics::TColor Value);
	virtual void __fastcall SetDisabledIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetHint(const AnsiString Value);
	virtual void __fastcall SetImageIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetVisible(bool Value);
	TRzCollectionTabControl* __fastcall GetTabControl(void);
	
public:
	__fastcall virtual TRzTabCollectionItem(Classes::TCollection* Collection);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property void * Data = {read=FData, write=FData};
	__property TRzCollectionTabControl* TabControl = {read=GetTabControl};
	
__published:
	__property AnsiString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property Imglist::TImageIndex DisabledIndex = {read=FDisabledIndex, write=SetDisabledIndex, default=-1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property AnsiString Hint = {read=FHint, write=SetHint};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
public:
	#pragma option push -w-inl
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TRzTabCollectionItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzTabCollection;
class PASCALIMPLEMENTATION TRzTabCollection : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TRzTabCollectionItem* operator[](int Index) { return Items[Index]; }
	
private:
	TRzCollectionTabControl* FTabControl;
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	HIDESBASE virtual TRzTabCollectionItem* __fastcall GetItem(int Index);
	HIDESBASE virtual void __fastcall SetItem(int Index, TRzTabCollectionItem* Value);
	
public:
	__fastcall TRzTabCollection(TRzCollectionTabControl* TabControl);
	HIDESBASE TRzTabCollectionItem* __fastcall Add(void);
	HIDESBASE TRzTabCollectionItem* __fastcall Insert(int Index);
	HIDESBASE void __fastcall Delete(int Index);
	void __fastcall Move(int CurIndex, int NewIndex);
	HIDESBASE void __fastcall Clear(void);
	__property TRzTabCollectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TRzCollectionTabControl* TabControl = {read=FTabControl};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TRzTabCollection(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzCollectionTabControl : public TRzCustomTabControl 
{
	typedef TRzCustomTabControl inherited;
	
private:
	TRzTabCollection* FTabCollection;
	TRzTabCollection* __fastcall GetTabCollection(void);
	void __fastcall SetTabCollection(TRzTabCollection* Value);
	
protected:
	virtual void __fastcall Rebuild(void);
	virtual void __fastcall DestroyActiveTab(void);
	virtual void __fastcall ActiveTabMoved(int Index);
	virtual bool __fastcall UpdatingTabs(void);
	
public:
	__fastcall virtual TRzCollectionTabControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCollectionTabControl(void);
	virtual void __fastcall HideAllTabs(void);
	virtual void __fastcall ShowAllTabs(void);
	__property TabIndex  = {default=-1};
	__property TRzTabCollection* Tabs = {read=GetTabCollection, write=SetTabCollection};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCollectionTabControl(HWND ParentWindow) : TRzCustomTabControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzTabControl;
class PASCALIMPLEMENTATION TRzTabControl : public TRzCollectionTabControl 
{
	typedef TRzCollectionTabControl inherited;
	
public:
	__property DisplayRect ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Align  = {default=0};
	__property AlignTabs  = {default=0};
	__property AllowTabDragging  = {default=0};
	__property Anchors  = {default=3};
	__property BackgroundColor ;
	__property BoldCurrentTab  = {default=0};
	__property ButtonColor  = {default=-16777201};
	__property Color  = {default=-16777201};
	__property UseColoredTabs  = {default=0};
	__property Constraints ;
	__property CutCornerSize  = {default=6};
	__property DragIndicatorColor  = {default=5263440};
	__property Enabled  = {default=1};
	__property Font ;
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=0};
	__property ImageAlignment  = {default=1};
	__property ImageMargin  = {default=2};
	__property ImagePosition  = {default=0};
	__property ImageAlignmentVertical  = {default=1};
	__property HelpContext  = {default=0};
	__property Hint ;
	__property HotTrack  = {default=1};
	__property HotTrackColor  = {default=1350640};
	__property HotTrackColorSource  = {default=0};
	__property HotTrackColorType  = {default=1};
	__property HotTrackStyle  = {default=0};
	__property Images ;
	__property Margin  = {default=0};
	__property MultiLine  = {default=0};
	__property Padding ;
	__property ParentBackgroundColor  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property RowIndent  = {default=5};
	__property RowOverlap  = {default=5};
	__property ShowCard  = {default=1};
	__property ShowCardFrame  = {default=1};
	__property ShowCloseButton  = {default=0};
	__property ShowCloseButtonOnActiveTab  = {default=0};
	__property ShowMenuButton  = {default=0};
	__property SortTabMenu  = {default=1};
	__property ShowFocusRect  = {default=1};
	__property ShowFullFrame  = {default=1};
	__property ShowHint ;
	__property ShowShadow  = {default=1};
	__property SoftCorners  = {default=0};
	__property TabOverlap  = {default=-1};
	__property TextOrientation  = {default=0};
	__property TabColors ;
	__property TabHeight  = {default=0};
	__property TabHints  = {default=0};
	__property TabIndex  = {default=-1};
	__property TabIndexDefault  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabOrientation  = {default=0};
	__property Tabs ;
	__property TabSequence  = {default=0};
	__property TabStop  = {default=1};
	__property TabStyle  = {default=0};
	__property TabWidth  = {default=0};
	__property TextColors ;
	__property TextAlignment  = {default=1};
	__property TextAlignmentVertical  = {default=1};
	__property Transparent  = {default=0};
	__property UseGradients  = {default=1};
	__property Visible  = {default=1};
	__property OnChange ;
	__property OnChanging ;
	__property OnClick ;
	__property OnClose ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetTextColor ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnPaintBackground ;
	__property OnPaintCardBackground ;
	__property OnPaintTabBackground ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnTabClick ;
	__property OnTabDragging ;
	__property OnTabOrderChange ;
	__property OnScrolledTabs ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TRzCollectionTabControl.Create */ inline __fastcall virtual TRzTabControl(Classes::TComponent* AOwner) : TRzCollectionTabControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCollectionTabControl.Destroy */ inline __fastcall virtual ~TRzTabControl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzTabControl(HWND ParentWindow) : TRzCollectionTabControl(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint MaxTabRegionPts = 0x14;
static const Shortint OptimumTabRegionCacheSize = 0x1;
static const int DefaultDragIndicatorColor = 0x505050;

}	/* namespace Rztabs */
using namespace Rztabs;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rztabs
