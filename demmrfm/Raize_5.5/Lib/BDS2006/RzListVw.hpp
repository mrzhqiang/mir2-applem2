// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzlistvw.pas' rev: 10.00

#ifndef RzlistvwHPP
#define RzlistvwHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzlistvw
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TRzLVCheckStateChanging)(System::TObject* Sender, Comctrls::TListItem* Item, bool ToBeChecked, bool &AllowChange);

typedef void __fastcall (__closure *TRzLVOnItemContextMenuEvent)(System::TObject* Sender, Comctrls::TListItem* Item, Types::TPoint &Pos, Menus::TPopupMenu* &Menu);

typedef void __fastcall (__closure *TRzLVDrawHeaderEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int Index, const Types::TRect &Rect);

#pragma option push -b-
enum TRzLVSortDirection { sdAscending, sdDescending };
#pragma option pop

#pragma option push -b-
enum TRzLVHeaderSortDisplayMode { hsdmNone, hsdmLeftAlign, hsdmRightOfText, hsdmRightAlign };
#pragma option pop

class DELPHICLASS TRzCustomListView;
class PASCALIMPLEMENTATION TRzCustomListView : public Comctrls::TCustomListView 
{
	typedef Comctrls::TCustomListView inherited;
	
private:
	bool FAlphaSortAll;
	int FLastIndex;
	bool FFillLastColumn;
	bool FEditOnRowClick;
	bool FEditingCaption;
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
	TRzLVCheckStateChanging FOnCheckStateChanging;
	Comctrls::TLVNotifyEvent FOnCheckStateChange;
	TRzLVOnItemContextMenuEvent FOnItemContextMenu;
	bool FMenuAlreadyHandled;
	bool FDragStarted;
	Graphics::TCanvas* FHeaderCanvas;
	int FHeaderSortColumn;
	TRzLVSortDirection FHeaderSortDirection;
	TRzLVHeaderSortDisplayMode FHeaderSortDisplayMode;
	bool FHeaderDefaultDrawing;
	TRzLVDrawHeaderEvent FOnDrawHeader;
	int FSetHeaderODStyleSem;
	HWND FInternalHeaderHandle;
	void *FHeaderInstance;
	void *FDefHeaderProc;
	bool FRightClicked;
	bool FMouseInNonClient;
	Controls::THintWindow* FHintWnd;
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameFocusStyleProp(Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMNotify(Messages::TWMNotify &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &Msg);
	HIDESBASE void __fastcall HeaderWndProc(Messages::TMessage &Msg);
	HWND __fastcall GetHeaderHandle(void);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Msg);
	MESSAGE void __fastcall AMInitStage2(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMDrawItem(Messages::TWMDrawItem &Msg);
	HIDESBASE MESSAGE void __fastcall WMParentNotify(Messages::TWMParentNotify &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Messages::TWMMouse &Msg);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FLoading;
	Controls::TControlCanvas* FCanvas;
	bool FOverControl;
	int FOverHeaderSection;
	bool FHeaderSectionDown;
	bool FSettingFrameController;
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual bool __fastcall IsCustomDrawn(Comctrls::TCustomDrawTarget Target, Comctrls::TCustomDrawStage Stage);
	virtual bool __fastcall CustomDrawItem(Comctrls::TListItem* Item, Comctrls::TCustomDrawState State, Comctrls::TCustomDrawStage Stage);
	virtual void __fastcall UpdateColors(void);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	virtual void __fastcall RepaintFrame(void);
	virtual void __fastcall ResizeLastColumn(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall DrawHeader(int AIndex, const Types::TRect &ARect);
	void __fastcall DrawHeaderSortGlyphs(int Index, const Types::TRect &Rect);
	void __fastcall DefaultDrawHeader(int Index, const Types::TRect &Rect);
	void __fastcall SetHeaderODStyle(void);
	virtual void __fastcall SetParent(Controls::TWinControl* Value);
	Types::TRect __fastcall CalcHintRect(int MaxWidth, const AnsiString HintStr, Controls::THintWindow* HintWnd);
	void __fastcall DoHint(int X, int Y);
	void __fastcall ReleaseHintWindow(void);
	DYNAMIC void __fastcall DoDrawHeader(int Index, const Types::TRect &Rect);
	DYNAMIC void __fastcall ColClick(Comctrls::TListColumn* Column);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall CheckStateChange(Comctrls::TListItem* Item);
	DYNAMIC bool __fastcall CanCheckStateChange(Comctrls::TListItem* Item, bool ToBeChecked);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC void __fastcall DoPreItemContextMenu(const Types::TPoint &pt);
	DYNAMIC void __fastcall DoItemContextMenu(const Types::TPoint &p);
	DYNAMIC void __fastcall ItemContextMenu(Comctrls::TListItem* Item, Types::TPoint &Pos, Menus::TPopupMenu* &Menu);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState ShiftState);
	virtual void __fastcall SetFillLastColumn(bool Value);
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
	virtual void __fastcall SetViewStyle(Comctrls::TViewStyle AValue);
	void __fastcall SetHeaderSortColumn(int Value);
	void __fastcall SetHeaderSortDirection(TRzLVSortDirection Value);
	void __fastcall SetHeaderSortDisplayMode(TRzLVHeaderSortDisplayMode Value);
	void __fastcall SetHeaderDefaultDrawing(bool Value);
	__property bool AlphaSortAll = {read=FAlphaSortAll, write=FAlphaSortAll, default=0};
	__property Color  = {stored=StoreColor, default=-16777211};
	__property bool Enabled = {read=GetEnabled, write=SetEnabled, default=1};
	__property bool EditOnRowClick = {read=FEditOnRowClick, write=FEditOnRowClick, default=0};
	__property bool FillLastColumn = {read=FFillLastColumn, write=SetFillLastColumn, default=1};
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
	__property Graphics::TCanvas* HeaderCanvas = {read=FHeaderCanvas};
	__property HWND HeaderHandle = {read=GetHeaderHandle, nodefault};
	__property bool HeaderDefaultDrawing = {read=FHeaderDefaultDrawing, write=SetHeaderDefaultDrawing, default=1};
	__property TRzLVHeaderSortDisplayMode HeaderSortDisplayMode = {read=FHeaderSortDisplayMode, write=SetHeaderSortDisplayMode, default=2};
	__property int HeaderSortColumn = {read=FHeaderSortColumn, write=SetHeaderSortColumn, default=-1};
	__property TRzLVSortDirection HeaderSortDirection = {read=FHeaderSortDirection, write=SetHeaderSortDirection, default=0};
	__property TRzLVCheckStateChanging OnCheckStateChanging = {read=FOnCheckStateChanging, write=FOnCheckStateChanging};
	__property Comctrls::TLVNotifyEvent OnCheckStateChange = {read=FOnCheckStateChange, write=FOnCheckStateChange};
	__property TRzLVOnItemContextMenuEvent OnItemContextMenu = {read=FOnItemContextMenu, write=FOnItemContextMenu};
	__property TRzLVDrawHeaderEvent OnDrawHeader = {read=FOnDrawHeader, write=FOnDrawHeader};
	__property OnMouseWheel ;
	__property OnMouseWheelUp ;
	__property OnMouseWheelDown ;
	
public:
	__fastcall virtual TRzCustomListView(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomListView(void);
	void __fastcall ResetHeaderHandle(void);
	virtual bool __fastcall UseThemes(void);
	bool __fastcall EditSelectedCaption(void);
	bool __fastcall EditItemCaption(Comctrls::TListItem* Item);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall SortByColumn(int Index, TRzLVSortDirection Direction = (TRzLVSortDirection)(0x0));
	void __fastcall SetTopIndex(int Index);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomListView(HWND ParentWindow) : Comctrls::TCustomListView(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzListView;
class PASCALIMPLEMENTATION TRzListView : public TRzCustomListView 
{
	typedef TRzCustomListView inherited;
	
public:
	__property HeaderCanvas ;
	__property HeaderHandle ;
	__property HeaderSortColumn  = {default=-1};
	__property HeaderSortDirection  = {default=0};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Action ;
	__property Align  = {default=0};
	__property AllocBy  = {default=0};
	__property AlphaSortAll  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property BorderStyle  = {default=1};
	__property Checkboxes  = {default=0};
	__property Color  = {default=-16777211};
	__property Columns ;
	__property ColumnClick  = {default=1};
	__property Constraints ;
	__property Ctl3D ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property EditOnRowClick  = {default=0};
	__property Enabled  = {default=1};
	__property FillLastColumn  = {default=1};
	__property FlatScrollBars  = {default=0};
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
	__property FullDrag  = {default=0};
	__property GridLines  = {default=0};
	__property HeaderDefaultDrawing  = {default=1};
	__property HeaderSortDisplayMode  = {default=2};
	__property HideSelection  = {default=1};
	__property HotTrack  = {default=0};
	__property HotTrackStyles  = {default=0};
	__property HoverTime  = {default=-1};
	__property IconOptions ;
	__property Items ;
	__property LargeImages ;
	__property MultiSelect  = {default=0};
	__property OwnerData  = {default=0};
	__property OwnerDraw  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property RowSelect  = {default=0};
	__property ShowHint ;
	__property ShowColumnHeaders  = {default=1};
	__property ShowWorkAreas  = {default=0};
	__property SmallImages ;
	__property SortType  = {default=0};
	__property StateImages ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property ViewStyle  = {default=0};
	__property Visible  = {default=1};
	__property OnAdvancedCustomDraw ;
	__property OnAdvancedCustomDrawItem ;
	__property OnAdvancedCustomDrawSubItem ;
	__property OnChange ;
	__property OnChanging ;
	__property OnCheckStateChanging ;
	__property OnCheckStateChange ;
	__property OnClick ;
	__property OnColumnClick ;
	__property OnColumnDragged ;
	__property OnColumnRightClick ;
	__property OnContextPopup ;
	__property OnGetSubItemImage ;
	__property OnInfoTip ;
	__property OnCompare ;
	__property OnCustomDraw ;
	__property OnCustomDrawItem ;
	__property OnCustomDrawSubItem ;
	__property OnData ;
	__property OnDataFind ;
	__property OnDataHint ;
	__property OnDataStateChange ;
	__property OnDblClick ;
	__property OnDeletion ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawHeader ;
	__property OnDrawItem ;
	__property OnEdited ;
	__property OnEditing ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetImageIndex ;
	__property OnInsert ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseWheel ;
	__property OnMouseWheelUp ;
	__property OnMouseWheelDown ;
	__property OnItemContextMenu ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnSelectItem ;
public:
	#pragma option push -w-inl
	/* TRzCustomListView.Create */ inline __fastcall virtual TRzListView(Classes::TComponent* AOwner) : TRzCustomListView(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomListView.Destroy */ inline __fastcall virtual ~TRzListView(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzListView(HWND ParentWindow) : TRzCustomListView(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall DrawDownArrow(Graphics::TCanvas* Canvas, const Types::TRect &Rect, Graphics::TColor BackgroundColor, Graphics::TColor ArrowColor);
extern PACKAGE void __fastcall DrawUpArrow(Graphics::TCanvas* Canvas, const Types::TRect &Rect, Graphics::TColor BackgroundColor, Graphics::TColor ArrowColor);
extern PACKAGE int __stdcall RzCustomSortDescendingProc(int Item1, int Item2, int ColIndex);
extern PACKAGE int __stdcall RzCustomSortProc(int Item1, int Item2, int ColIndex);

}	/* namespace Rzlistvw */
using namespace Rzlistvw;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzlistvw
