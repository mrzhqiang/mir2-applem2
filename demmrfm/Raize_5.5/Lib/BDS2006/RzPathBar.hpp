// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzpathbar.pas' rev: 10.00

#ifndef RzpathbarHPP
#define RzpathbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rzgroupbar.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzpathbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzPathItemActionLink;
class DELPHICLASS TRzPathItem;
typedef TMetaClass* TRzPathItemActionLinkClass;

class DELPHICLASS TRzPathBar;
class PASCALIMPLEMENTATION TRzPathItem : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	AnsiString FCaption;
	bool FCaptionChanged;
	Graphics::TColor FHighlightColor;
	AnsiString FHint;
	Imglist::TImageIndex FImageIndex;
	AnsiString FLinkInfo;
	System::TObject* FLinkObject;
	int FTag;
	Classes::TNotifyEvent FOnClick;
	TRzPathItemActionLink* FActionLink;
	bool FClickingCaption;
	Rzgroupbar::TRzCaptionState FCaptionState;
	#pragma pack(push,1)
	Types::TRect FHotRect;
	#pragma pack(pop)
	void __fastcall ActionChangeHandler(System::TObject* Sender);
	
protected:
	virtual AnsiString __fastcall GetDisplayName();
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	bool __fastcall IsCaptionStored(void);
	bool __fastcall IsHintStored(void);
	bool __fastcall IsHelpContextStored(void);
	bool __fastcall IsImageIndexStored(void);
	bool __fastcall IsOnClickStored(void);
	virtual Classes::TBasicAction* __fastcall GetAction(void);
	virtual void __fastcall SetAction(Classes::TBasicAction* Value);
	DYNAMIC TMetaClass* __fastcall GetActionLinkClass(void);
	virtual void __fastcall SetCaption(const AnsiString Value);
	virtual void __fastcall SetHighlightColor(Graphics::TColor Value);
	virtual TRzPathBar* __fastcall GetPathBar(void);
	virtual void __fastcall SetImageIndex(Imglist::TImageIndex Value);
	__property TRzPathItemActionLink* ActionLink = {read=FActionLink, write=FActionLink};
	
public:
	__fastcall virtual TRzPathItem(Classes::TCollection* Collection);
	__fastcall virtual ~TRzPathItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall AssignTo(Classes::TPersistent* Dest);
	virtual void __fastcall InitiateAction(void);
	DYNAMIC void __fastcall Click(void);
	__property Types::TRect HotRect = {read=FHotRect, write=FHotRect};
	__property Rzgroupbar::TRzCaptionState CaptionState = {read=FCaptionState, write=FCaptionState, nodefault};
	__property bool ClickingCaption = {read=FClickingCaption, write=FClickingCaption, nodefault};
	__property System::TObject* LinkObject = {read=FLinkObject, write=FLinkObject};
	__property TRzPathBar* PathBar = {read=GetPathBar};
	
__published:
	__property Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property AnsiString Caption = {read=FCaption, write=SetCaption, stored=IsCaptionStored};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=SetHighlightColor, default=536870911};
	__property AnsiString Hint = {read=FHint, write=FHint, stored=IsHintStored};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, stored=IsImageIndexStored, default=-1};
	__property AnsiString LinkInfo = {read=FLinkInfo, write=FLinkInfo};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick, stored=IsOnClickStored};
};


class PASCALIMPLEMENTATION TRzPathItemActionLink : public Actnlist::TActionLink 
{
	typedef Actnlist::TActionLink inherited;
	
protected:
	TRzPathItem* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall DoShowHint(AnsiString &HintStr);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsOnExecuteLinked(void);
	virtual void __fastcall SetCaption(const AnsiString Value);
	virtual void __fastcall SetHint(const AnsiString Value);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetOnExecute(Classes::TNotifyEvent Value);
public:
	#pragma option push -w-inl
	/* TBasicActionLink.Create */ inline __fastcall virtual TRzPathItemActionLink(System::TObject* AClient) : Actnlist::TActionLink(AClient) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TRzPathItemActionLink(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzPathItems;
class PASCALIMPLEMENTATION TRzPathItems : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TRzPathItem* operator[](int Index) { return Items[Index]; }
	
private:
	TRzPathBar* FPathBar;
	HIDESBASE TRzPathItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TRzPathItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TRzPathItems(TRzPathBar* PathBar);
	HIDESBASE TRzPathItem* __fastcall Add(void);
	__property TRzPathItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TRzPathBar* PathBar = {read=FPathBar};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TRzPathItems(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TRzMouseOverPathItemEvent)(System::TObject* Sender, TRzPathItem* Item);

typedef void __fastcall (__closure *TRzPathItemPopupMenuEvent)(System::TObject* Sender, TRzPathItem* Item);

#pragma option push -b-
enum TRzItemHotStyle { ihsBox, ihsUnderline };
#pragma option pop

class PASCALIMPLEMENTATION TRzPathBar : public Rzpanel::TRzCustomPanel 
{
	typedef Rzpanel::TRzCustomPanel inherited;
	
private:
	Graphics::TColor FItemHotColor;
	Graphics::TColor FItemDownColor;
	Graphics::TColor FHighlightColor;
	bool FBoldLastItem;
	TRzItemHotStyle FItemHotStyle;
	Rzgroupbar::TRzCaptionState FCaptionState;
	HICON FItemCursor;
	TRzPathItems* FItems;
	int FActionClientCount;
	Imglist::TCustomImageList* FImages;
	Imglist::TChangeLink* FImagesChangeLink;
	AnsiString FSeparator;
	Graphics::TFont* FSeparatorFont;
	TRzMouseOverPathItemEvent FOnMouseOverItem;
	Menus::TPopupMenu* FItemPopupMenu;
	TRzPathItem* FPopupItem;
	TRzPathItemPopupMenuEvent FOnItemPopupMenu;
	void __fastcall ImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall DrawItems(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall UpdateDownColors(void);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	DYNAMIC void __fastcall DoEndDrag(System::TObject* Target, int X, int Y);
	void __fastcall DisplayItemPopupMenu(int Index, int X, int Y);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DoContextPopup(const Types::TPoint &MousePos, bool &Handled);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseOverItem(TRzPathItem* Item);
	virtual void __fastcall SetBoldLastItem(bool Value);
	virtual void __fastcall SetItemHotColor(Graphics::TColor Value);
	virtual void __fastcall SetHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetItemHotStyle(TRzItemHotStyle Value);
	virtual void __fastcall SetItems(TRzPathItems* Value);
	virtual void __fastcall SetImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetSeparator(const AnsiString Value);
	virtual void __fastcall SetSeparatorFont(Graphics::TFont* Value);
	virtual void __fastcall SetItemPopupMenu(Menus::TPopupMenu* Value);
	
public:
	__fastcall virtual TRzPathBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzPathBar(void);
	virtual void __fastcall InitiateAction(void);
	void __fastcall ActionClientConnect(void);
	void __fastcall ActionClientDisconnect(void);
	void __fastcall AssignActionList(Actnlist::TCustomActionList* ActionList, const AnsiString Category = "");
	int __fastcall ItemAtPos(const Types::TPoint &P);
	__property TRzPathItem* PopupItem = {read=FPopupItem};
	__property Canvas ;
	__property DockManager ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool BoldLastItem = {read=FBoldLastItem, write=SetBoldLastItem, default=1};
	__property TRzPathItems* Items = {read=FItems, write=SetItems};
	__property Graphics::TColor ItemHotColor = {read=FItemHotColor, write=SetItemHotColor, default=-16777190};
	__property Menus::TPopupMenu* ItemPopupMenu = {read=FItemPopupMenu, write=SetItemPopupMenu};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=SetHighlightColor, default=-16777203};
	__property TRzItemHotStyle ItemHotStyle = {read=FItemHotStyle, write=SetItemHotStyle, default=0};
	__property AnsiString Separator = {read=FSeparator, write=SetSeparator};
	__property Graphics::TFont* SeparatorFont = {read=FSeparatorFont, write=SetSeparatorFont};
	__property TRzMouseOverPathItemEvent OnMouseOverItem = {read=FOnMouseOverItem, write=FOnMouseOverItem};
	__property TRzPathItemPopupMenuEvent OnItemPopupMenu = {read=FOnItemPopupMenu, write=FOnItemPopupMenu};
	__property Align  = {default=1};
	__property Alignment  = {default=2};
	__property AlignmentVertical  = {default=1};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=0};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=0};
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
	__property Height  = {default=24};
	__property Locked  = {default=0};
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
	/* TWinControl.CreateParented */ inline __fastcall TRzPathBar(HWND ParentWindow) : Rzpanel::TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzpathbar */
using namespace Rzpathbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzpathbar
