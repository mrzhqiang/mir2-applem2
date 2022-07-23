// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzlstbox.pas' rev: 10.00

#ifndef RzlstboxHPP
#define RzlstboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzintlst.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzcmbobx.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzlstbox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzCustomListBox;
class PASCALIMPLEMENTATION TRzCustomListBox : public Stdctrls::TCustomListBox 
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	bool FUpdatingColor;
	Graphics::TColor FDisabledColor;
	Graphics::TColor FFocusColor;
	Graphics::TColor FNormalColor;
	Graphics::TColor FFrameColor;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	Graphics::TColor FFrameHotColor;
	bool FFrameHotTrack;
	Rzcommon::TFrameStyleEx FFrameHotStyle;
	Rzcommon::TSides FFrameSides;
	Rzcommon::TFrameStyleEx FFrameStyle;
	bool FFrameVisible;
	Rzcommon::TFramingPreference FFramingPreference;
	bool FIncrementalSearch;
	bool FBeepOnInvalidKey;
	Word FHorzExtent;
	bool FHorzScrollBar;
	AnsiString FSearchString;
	Extctrls::TTimer* FTimer;
	int FKeyCount;
	bool FTabOnEnter;
	int FOwnerDrawIndent;
	bool FShowItemHints;
	Controls::THintWindow* FHintWnd;
	bool FUseGradients;
	Graphics::TColor FGroupColor;
	bool FGroupColorFromTheme;
	Graphics::TFont* FGroupFont;
	bool FGroupFontChanged;
	AnsiString FGroupPrefix;
	bool FShowGroups;
	Stdctrls::TDrawItemEvent FOnDrawItem;
	Classes::TNotifyEvent FOnMatch;
	Classes::TNotifyEvent FOnDeleteItems;
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameFocusStyleProp(Classes::TReader* Reader);
	void __fastcall SearchTimerExpired(System::TObject* Sender);
	void __fastcall GroupFontChangeHandler(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Msg);
	
protected:
	Graphics::TCanvas* FCanvas;
	bool FOverControl;
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall Resize(void);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	Types::TRect __fastcall CalcHintRect(int MaxWidth, const AnsiString HintStr, Controls::THintWindow* HintWnd);
	void __fastcall DoHint(int X, int Y);
	void __fastcall ReleaseHintWindow(void);
	virtual void __fastcall UpdateColors(void);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	virtual void __fastcall RepaintFrame(void);
	bool __fastcall ShowFocus(void);
	virtual int __fastcall OwnerDrawItemIndent(void);
	virtual void __fastcall UpdateItemHeight(void);
	virtual AnsiString __fastcall HorzExtentPrefix();
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	virtual void __fastcall GroupFontChanged(void);
	void __fastcall InvalidKeyPressed(void);
	virtual int __fastcall FindClosest(const AnsiString S);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall DrawListItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall DrawGroup(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall Match(void);
	DYNAMIC void __fastcall DoDeleteItems(void);
	bool __fastcall StoreColor(void);
	bool __fastcall StoreFocusColor(void);
	bool __fastcall StoreDisabledColor(void);
	bool __fastcall StoreParentColor(void);
	bool __fastcall StoreFlatButtonColor(void);
	bool __fastcall StoreFlatButtons(void);
	bool __fastcall StoreFrameColor(void);
	bool __fastcall StoreFrameHotColor(void);
	bool __fastcall StoreFrameHotTrack(void);
	bool __fastcall StoreFrameHotStyle(void);
	bool __fastcall StoreFrameSides(void);
	bool __fastcall StoreFrameStyle(void);
	bool __fastcall StoreFrameVisible(void);
	bool __fastcall StoreFramingPreference(void);
	virtual void __fastcall SetDisabledColor(Graphics::TColor Value);
	virtual void __fastcall SetFocusColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetFrameHotColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameHotTrack(bool Value);
	virtual void __fastcall SetFrameHotStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameSides(Rzcommon::TSides Value);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameVisible(bool Value);
	virtual void __fastcall SetFramingPreference(Rzcommon::TFramingPreference Value);
	virtual void __fastcall SetHorzExtent(Word Value);
	virtual void __fastcall SetHorzScrollBar(bool Value);
	virtual void __fastcall SetOwnerDrawIndent(int Value);
	virtual Classes::TStrings* __fastcall GetItems(void);
	bool __fastcall StoreGroupPrefix(void);
	virtual void __fastcall SetGroupPrefix(const AnsiString Value);
	virtual void __fastcall SetGroupColor(Graphics::TColor Value);
	virtual void __fastcall SetGroupColorFromTheme(bool Value);
	virtual void __fastcall SetGroupFont(Graphics::TFont* Value);
	virtual void __fastcall SetUseGradients(bool Value);
	virtual bool __fastcall GetItemIsGroup(int Index);
	virtual void __fastcall SetShowGroups(bool Value);
	__property Color  = {stored=StoreColor, default=-16777211};
	__property bool ShowItemHints = {read=FShowItemHints, write=FShowItemHints, default=1};
	__property Graphics::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, stored=StoreDisabledColor, default=-16777201};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, stored=StoreFocusColor, default=-16777211};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, stored=StoreFrameColor, default=-16777200};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Graphics::TColor FrameHotColor = {read=FFrameHotColor, write=SetFrameHotColor, stored=StoreFrameHotColor, default=-16777200};
	__property Rzcommon::TFrameStyle FrameHotStyle = {read=FFrameHotStyle, write=SetFrameHotStyle, stored=StoreFrameHotStyle, default=10};
	__property bool FrameHotTrack = {read=FFrameHotTrack, write=SetFrameHotTrack, stored=StoreFrameHotTrack, default=0};
	__property Rzcommon::TSides FrameSides = {read=FFrameSides, write=SetFrameSides, stored=StoreFrameSides, default=15};
	__property Rzcommon::TFrameStyle FrameStyle = {read=FFrameStyle, write=SetFrameStyle, stored=StoreFrameStyle, default=1};
	__property bool FrameVisible = {read=FFrameVisible, write=SetFrameVisible, stored=StoreFrameVisible, default=0};
	__property Rzcommon::TFramingPreference FramingPreference = {read=FFramingPreference, write=SetFramingPreference, stored=StoreFramingPreference, default=1};
	__property Graphics::TColor GroupColor = {read=FGroupColor, write=SetGroupColor, default=-16777197};
	__property bool GroupColorFromTheme = {read=FGroupColorFromTheme, write=SetGroupColorFromTheme, default=1};
	__property Graphics::TFont* GroupFont = {read=FGroupFont, write=SetGroupFont, stored=FGroupFontChanged};
	__property AnsiString GroupPrefix = {read=FGroupPrefix, write=SetGroupPrefix, stored=StoreGroupPrefix};
	__property bool HorzScrollBar = {read=FHorzScrollBar, write=SetHorzScrollBar, default=0};
	__property bool IncrementalSearch = {read=FIncrementalSearch, write=FIncrementalSearch, default=1};
	__property int OwnerDrawIndent = {read=FOwnerDrawIndent, write=SetOwnerDrawIndent, default=0};
	__property bool ShowGroups = {read=FShowGroups, write=SetShowGroups, default=0};
	__property bool TabOnEnter = {read=FTabOnEnter, write=FTabOnEnter, default=0};
	__property bool UseGradients = {read=FUseGradients, write=SetUseGradients, default=1};
	__property Stdctrls::TDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property Classes::TNotifyEvent OnMatch = {read=FOnMatch, write=FOnMatch};
	__property Classes::TNotifyEvent OnDeleteItems = {read=FOnDeleteItems, write=FOnDeleteItems};
	
public:
	__fastcall virtual TRzCustomListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomListBox(void);
	virtual bool __fastcall UseThemes(void);
	virtual void __fastcall AdjustHorzExtent(void);
	virtual void __fastcall DefaultDrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	int __fastcall Add(const AnsiString S);
	int __fastcall AddObject(const AnsiString S, System::TObject* AObject);
	void __fastcall ClearSearchString(void);
	void __fastcall Delete(int Index);
	int __fastcall IndexOf(const AnsiString S);
	HIDESBASE void __fastcall Insert(int Index, const AnsiString S);
	void __fastcall InsertObject(int Index, const AnsiString S, System::TObject* AObject);
	AnsiString __fastcall SelectedItem();
	bool __fastcall FindItem(const AnsiString S);
	virtual void __fastcall SelectAll(void);
	void __fastcall UnselectAll(void);
	void __fastcall DeleteSelectedItems(void);
	int __fastcall AddGroup(const AnsiString S);
	AnsiString __fastcall ItemCaption(int Index);
	virtual bool __fastcall ItemInsideGroup(int Index);
	virtual int __fastcall ItemGroupIndex(int Index);
	virtual int __fastcall GroupIndexOfItem(int Index);
	int __fastcall ItemsInGroup(int GroupIndex);
	int __fastcall ItemIndexOfGroup(int GroupIndex);
	int __fastcall AddItemToGroup(int GroupIndex, const AnsiString S);
	int __fastcall InsertItemIntoGroup(int GroupIndex, int Index, const AnsiString S);
	void __fastcall ItemToGroup(int Index);
	void __fastcall GroupToItem(int Index);
	__property bool ItemIsGroup[int Index] = {read=GetItemIsGroup};
	__property bool BeepOnInvalidKey = {read=FBeepOnInvalidKey, write=FBeepOnInvalidKey, default=1};
	__property AnsiString SearchString = {read=FSearchString};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomListBox(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzListBox;
class PASCALIMPLEMENTATION TRzListBox : public TRzCustomListBox 
{
	typedef TRzCustomListBox inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property BeepOnInvalidKey  = {default=1};
	__property BiDiMode ;
	__property BorderStyle  = {default=1};
	__property Color  = {default=-16777211};
	__property Columns  = {default=0};
	__property Constraints ;
	__property Ctl3D ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property ExtendedSelect  = {default=1};
	__property Font ;
	__property FocusColor  = {default=-16777211};
	__property FrameColor  = {default=-16777200};
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property FrameHotColor  = {default=-16777200};
	__property FrameHotTrack  = {default=0};
	__property FrameHotStyle  = {default=10};
	__property FrameSides  = {default=15};
	__property FrameStyle  = {default=1};
	__property FrameVisible  = {default=0};
	__property FramingPreference  = {default=1};
	__property GroupColor  = {default=-16777197};
	__property GroupColorFromTheme  = {default=1};
	__property GroupFont ;
	__property GroupPrefix ;
	__property HorzScrollBar  = {default=0};
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property IncrementalSearch  = {default=1};
	__property IntegralHeight  = {default=0};
	__property ItemHeight ;
	__property Items ;
	__property MultiSelect  = {default=0};
	__property OwnerDrawIndent  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowGroups  = {default=0};
	__property ShowHint ;
	__property ShowItemHints  = {default=1};
	__property Sorted  = {default=0};
	__property Style  = {default=0};
	__property TabOnEnter  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property TabWidth  = {default=0};
	__property UseGradients  = {default=1};
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnData ;
	__property OnDataFind ;
	__property OnDataObject ;
	__property OnDblClick ;
	__property OnDeleteItems ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawItem ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMatch ;
	__property OnMeasureItem ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseWheel ;
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TRzCustomListBox.Create */ inline __fastcall virtual TRzListBox(Classes::TComponent* AOwner) : TRzCustomListBox(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomListBox.Destroy */ inline __fastcall virtual ~TRzListBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzListBox(HWND ParentWindow) : TRzCustomListBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS EHeaderError;
class PASCALIMPLEMENTATION EHeaderError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall EHeaderError(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EHeaderError(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EHeaderError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EHeaderError(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EHeaderError(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EHeaderError(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EHeaderError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EHeaderError(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EHeaderError(void) { }
	#pragma option pop
	
};


typedef int TRzTabArray[1000];

class DELPHICLASS TRzTabStopList;
class DELPHICLASS TRzCustomTabbedListBox;
#pragma option push -b-
enum TRzTabStopsMode { tsmManual, tsmAutomatic };
#pragma option pop

class PASCALIMPLEMENTATION TRzCustomTabbedListBox : public TRzCustomListBox 
{
	typedef TRzCustomListBox inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	TRzTabStopList* FTabStops;
	TRzTabStopsMode FTabStopsMode;
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	
protected:
	int FDialogUnits;
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DrawGroup(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual int __fastcall InitialTabStopOffset(void);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	virtual void __fastcall GroupFontChanged(void);
	bool __fastcall StoreTabStops(void);
	virtual void __fastcall SetTabStops(TRzTabStopList* Value);
	virtual void __fastcall SetTabStopsMode(TRzTabStopsMode Value);
	virtual void __fastcall GetTabArray(int &TabCount, int * TabArray);
	virtual AnsiString __fastcall GetCellText(int ACol, int ARow);
	virtual void __fastcall SetCellText(int ACol, int ARow, const AnsiString Value);
	
public:
	__fastcall virtual TRzCustomTabbedListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomTabbedListBox(void);
	void __fastcall UpdateTabStops(void);
	virtual void __fastcall AdjustTabStops(void);
	virtual void __fastcall AdjustHorzExtent(void);
	virtual void __fastcall DefaultDrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall UpdateFromHeader(Controls::TControl* Header);
	__property AnsiString Cells[int ACol][int ARow] = {read=GetCellText, write=SetCellText};
	__property int DialogUnits = {read=FDialogUnits, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property TRzTabStopList* TabStops = {read=FTabStops, write=SetTabStops, stored=StoreTabStops};
	__property TRzTabStopsMode TabStopsMode = {read=FTabStopsMode, write=SetTabStopsMode, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomTabbedListBox(HWND ParentWindow) : TRzCustomListBox(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzTabStopList : public Rzintlst::TRzIntegerList 
{
	typedef Rzintlst::TRzIntegerList inherited;
	
private:
	TRzCustomTabbedListBox* FListBox;
	
protected:
	virtual void __fastcall SetItem(int Index, int Value);
	
public:
	__fastcall TRzTabStopList(void);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Insert(int Index, int Value);
	virtual int __fastcall Add(int Value);
public:
	#pragma option push -w-inl
	/* TRzIntegerList.Destroy */ inline __fastcall virtual ~TRzTabStopList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzTabbedListBox;
class PASCALIMPLEMENTATION TRzTabbedListBox : public TRzCustomTabbedListBox 
{
	typedef TRzCustomTabbedListBox inherited;
	
__published:
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property BeepOnInvalidKey  = {default=1};
	__property BiDiMode ;
	__property BorderStyle  = {default=1};
	__property Color  = {default=-16777211};
	__property Columns  = {default=0};
	__property Constraints ;
	__property Ctl3D ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property ShowItemHints  = {default=0};
	__property ExtendedSelect  = {default=1};
	__property Font ;
	__property FocusColor  = {default=-16777211};
	__property FrameColor  = {default=-16777200};
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property FrameHotColor  = {default=-16777200};
	__property FrameHotTrack  = {default=0};
	__property FrameHotStyle  = {default=10};
	__property FrameSides  = {default=15};
	__property FrameStyle  = {default=1};
	__property FrameVisible  = {default=0};
	__property FramingPreference  = {default=1};
	__property GroupColor  = {default=-16777197};
	__property GroupColorFromTheme  = {default=1};
	__property GroupFont ;
	__property GroupPrefix ;
	__property HorzScrollBar  = {default=0};
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property IncrementalSearch  = {default=1};
	__property IntegralHeight  = {default=0};
	__property ItemHeight ;
	__property Items ;
	__property MultiSelect  = {default=0};
	__property OwnerDrawIndent  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowGroups  = {default=0};
	__property ShowHint ;
	__property Sorted  = {default=0};
	__property Style  = {default=0};
	__property TabOnEnter  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property UseGradients  = {default=1};
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnData ;
	__property OnDataFind ;
	__property OnDataObject ;
	__property OnDblClick ;
	__property OnDeleteItems ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawItem ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMatch ;
	__property OnMeasureItem ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseWheel ;
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TRzCustomTabbedListBox.Create */ inline __fastcall virtual TRzTabbedListBox(Classes::TComponent* AOwner) : TRzCustomTabbedListBox(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomTabbedListBox.Destroy */ inline __fastcall virtual ~TRzTabbedListBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzTabbedListBox(HWND ParentWindow) : TRzCustomTabbedListBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzPopupEdit;
class DELPHICLASS TRzEditListBox;
typedef void __fastcall (__closure *TRzSizeEditRectEvent)(System::TObject* Sender, int Index, Types::TRect &EditRect);

typedef void __fastcall (__closure *TRzShowingEditorEvent)(System::TObject* Sender, int Index, bool &AllowShow);

typedef void __fastcall (__closure *TRzItemChangedEvent)(System::TObject* Sender, int Index);

class PASCALIMPLEMENTATION TRzEditListBox : public TRzListBox 
{
	typedef TRzListBox inherited;
	
private:
	bool FJustGotFocus;
	bool FAllowEdit;
	TRzPopupEdit* FPopupEdit;
	bool FPopupVisible;
	Graphics::TColor FEditColor;
	Graphics::TColor FEditFontColor;
	int FCurrIdx;
	int FEditorIdx;
	bool FDoubleClicked;
	Extctrls::TTimer* FTimer;
	bool FShowEditorOnNextClick;
	bool FAllowDeleteByKbd;
	TRzSizeEditRectEvent FOnSizeEditRect;
	TRzShowingEditorEvent FOnShowingEditor;
	Classes::TNotifyEvent FOnHidingEditor;
	TRzItemChangedEvent FOnItemChanged;
	virtual void __fastcall TimerExpired(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMLButtonDblClick(Messages::TWMMouse &Msg);
	
protected:
	DYNAMIC void __fastcall SizeEditRect(int Index, Types::TRect &EditRect);
	DYNAMIC bool __fastcall DoShowingEditor(int Index);
	DYNAMIC void __fastcall DoHidingEditor(void);
	DYNAMIC void __fastcall ItemChanged(int Index);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TRzEditListBox(Classes::TComponent* AOwner);
	virtual void __fastcall HideEditor(bool SaveChanges);
	virtual void __fastcall ShowEditor(void);
	__property TRzPopupEdit* PopupEdit = {read=FPopupEdit};
	
__published:
	__property bool AllowEdit = {read=FAllowEdit, write=FAllowEdit, default=1};
	__property bool AllowDeleteByKbd = {read=FAllowDeleteByKbd, write=FAllowDeleteByKbd, default=0};
	__property Graphics::TColor EditColor = {read=FEditColor, write=FEditColor, default=-16777211};
	__property Graphics::TColor EditFontColor = {read=FEditFontColor, write=FEditFontColor, default=-16777208};
	__property bool PopupVisible = {read=FPopupVisible, nodefault};
	__property TRzSizeEditRectEvent OnSizeEditRect = {read=FOnSizeEditRect, write=FOnSizeEditRect};
	__property TRzShowingEditorEvent OnShowingEditor = {read=FOnShowingEditor, write=FOnShowingEditor};
	__property Classes::TNotifyEvent OnHidingEditor = {read=FOnHidingEditor, write=FOnHidingEditor};
	__property TRzItemChangedEvent OnItemChanged = {read=FOnItemChanged, write=FOnItemChanged};
public:
	#pragma option push -w-inl
	/* TRzCustomListBox.Destroy */ inline __fastcall virtual ~TRzEditListBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzEditListBox(HWND ParentWindow) : TRzListBox(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzPopupEdit : public Stdctrls::TCustomEdit 
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	TRzEditListBox* FList;
	MESSAGE void __fastcall CMCancelMode(Controls::TCMCancelMode &Msg);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CNKeyDown(Messages::TWMKey &Msg);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall KeyPress(char &Key);
	
public:
	__fastcall virtual TRzPopupEdit(Classes::TComponent* AOwner);
	__property Font ;
	__property Color  = {default=-16777211};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzPopupEdit(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TRzPopupEdit(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzModifierKey { mkShift, mkNone };
#pragma option pop

typedef void __fastcall (__closure *TRzMoveItemEvent)(System::TObject* Sender, int OldIndex, int NewIndex);

class DELPHICLASS TRzRankListBox;
class PASCALIMPLEMENTATION TRzRankListBox : public TRzListBox 
{
	typedef TRzListBox inherited;
	
private:
	TRzModifierKey FModifierKey;
	bool FMoveOnDrag;
	bool FMoving;
	int FOldIndex;
	HICON FOldCursor;
	int FColumns;
	Controls::TCursor FDragCursor;
	Controls::TDragMode FDragMode;
	bool FExtendedSelect;
	bool FMultiSelect;
	bool FSorted;
	TRzMoveItemEvent FOnMoveItem;
	void __fastcall SetMoveOnDrag(bool Value);
	
protected:
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MoveItem(int OldIndex, int NewIndex);
	
public:
	__fastcall virtual TRzRankListBox(Classes::TComponent* AOwner);
	
__published:
	__property int Columns = {read=FColumns, default=0};
	__property Controls::TCursor DragCursor = {read=FDragCursor, default=-12};
	__property Controls::TDragMode DragMode = {read=FDragMode, default=0};
	__property bool ExtendedSelect = {read=FExtendedSelect, default=0};
	__property bool MultiSelect = {read=FMultiSelect, default=0};
	__property bool Sorted = {read=FSorted, default=0};
	__property TRzModifierKey ModifierKey = {read=FModifierKey, write=FModifierKey, default=0};
	__property bool MoveOnDrag = {read=FMoveOnDrag, write=SetMoveOnDrag, default=1};
	__property TRzMoveItemEvent OnMoveItem = {read=FOnMoveItem, write=FOnMoveItem};
public:
	#pragma option push -w-inl
	/* TRzCustomListBox.Destroy */ inline __fastcall virtual ~TRzRankListBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzRankListBox(HWND ParentWindow) : TRzListBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzFontListBox;
class PASCALIMPLEMENTATION TRzFontListBox : public TRzCustomListBox 
{
	typedef TRzCustomListBox inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	AnsiString FSaveFontName;
	Graphics::TFont* FFont;
	Rzcmbobx::TRzFontDevice FFontDevice;
	Rzcmbobx::TRzFontType FFontType;
	int FFontSize;
	Graphics::TFontStyles FFontStyle;
	bool FShowSymbolFonts;
	Rzcmbobx::TRzShowStyle FShowStyle;
	Graphics::TBitmap* FTrueTypeBmp;
	Graphics::TBitmap* FFixedPitchBmp;
	Graphics::TBitmap* FTrueTypeFixedBmp;
	Graphics::TBitmap* FPrinterBmp;
	Graphics::TBitmap* FDeviceBmp;
	bool FPreviewVisible;
	Rzcmbobx::TRzPreviewFontPanel* FPreviewPanel;
	int FPreviewFontSize;
	int FPreviewWidth;
	int FPreviewHeight;
	Stdctrls::TCustomEdit* FPreviewEdit;
	AnsiString FPreviewText;
	int FMRUCount;
	bool FMaintainMRUFonts;
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMCancelMode(Controls::TCMCancelMode &Msg);
	MESSAGE void __fastcall CMHidePreviewPanel(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall LoadFonts(void);
	virtual void __fastcall LoadBitmaps(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall UpdatePreviewText(void);
	virtual void __fastcall HidePreviewPanel(void);
	virtual void __fastcall ShowPreviewPanel(void);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetFontDevice(Rzcmbobx::TRzFontDevice Value);
	virtual void __fastcall SetFontType(Rzcmbobx::TRzFontType Value);
	virtual Graphics::TFont* __fastcall GetSelectedFont(void);
	virtual void __fastcall SetSelectedFont(Graphics::TFont* Value);
	virtual AnsiString __fastcall GetFontName();
	virtual void __fastcall SetFontName(const AnsiString Value);
	virtual void __fastcall SetPreviewEdit(Stdctrls::TCustomEdit* Value);
	virtual void __fastcall SetShowSymbolFonts(bool Value);
	virtual void __fastcall SetShowStyle(Rzcmbobx::TRzShowStyle Value);
	
public:
	__fastcall virtual TRzFontListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzFontListBox(void);
	void __fastcall AddFontToMRUList(void);
	__property Graphics::TFont* SelectedFont = {read=GetSelectedFont, write=SetSelectedFont};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Rzcmbobx::TRzFontDevice FontDevice = {read=FFontDevice, write=SetFontDevice, default=0};
	__property AnsiString FontName = {read=GetFontName, write=SetFontName};
	__property int FontSize = {read=FFontSize, write=FFontSize, default=8};
	__property Graphics::TFontStyles FontStyle = {read=FFontStyle, write=FFontStyle, default=0};
	__property Rzcmbobx::TRzFontType FontType = {read=FFontType, write=SetFontType, default=0};
	__property bool MaintainMRUFonts = {read=FMaintainMRUFonts, write=FMaintainMRUFonts, default=0};
	__property Stdctrls::TCustomEdit* PreviewEdit = {read=FPreviewEdit, write=FPreviewEdit};
	__property int PreviewFontSize = {read=FPreviewFontSize, write=FPreviewFontSize, default=36};
	__property int PreviewHeight = {read=FPreviewHeight, write=FPreviewHeight, default=65};
	__property AnsiString PreviewText = {read=FPreviewText, write=FPreviewText};
	__property int PreviewWidth = {read=FPreviewWidth, write=FPreviewWidth, default=260};
	__property bool ShowSymbolFonts = {read=FShowSymbolFonts, write=SetShowSymbolFonts, default=1};
	__property Rzcmbobx::TRzShowStyle ShowStyle = {read=FShowStyle, write=SetShowStyle, default=0};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property BeepOnInvalidKey  = {default=1};
	__property BiDiMode ;
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property Ctl3D ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property FocusColor  = {default=-16777211};
	__property FrameColor  = {default=-16777200};
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property FrameHotColor  = {default=-16777200};
	__property FrameHotTrack  = {default=0};
	__property FrameHotStyle  = {default=10};
	__property FrameSides  = {default=15};
	__property FrameStyle  = {default=1};
	__property FrameVisible  = {default=0};
	__property FramingPreference  = {default=1};
	__property ItemHeight ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property Sorted  = {default=1};
	__property TabOnEnter  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseWheel ;
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzFontListBox(HWND ParentWindow) : TRzCustomListBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word MaxTabs = 0x3e8;
#define strDefaultGroupPrefix "//"

}	/* namespace Rzlstbox */
using namespace Rzlstbox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzlstbox
