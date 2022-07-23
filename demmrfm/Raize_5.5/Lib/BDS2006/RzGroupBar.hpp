// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzgroupbar.pas' rev: 10.00

#ifndef RzgroupbarHPP
#define RzgroupbarHPP

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
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzspnedt.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzgroupbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS ERzGroupBarError;
class PASCALIMPLEMENTATION ERzGroupBarError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ERzGroupBarError(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ERzGroupBarError(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ERzGroupBarError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ERzGroupBarError(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ERzGroupBarError(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ERzGroupBarError(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ERzGroupBarError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ERzGroupBarError(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ERzGroupBarError(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzCaptionState { csNormal, csHot, csDown };
#pragma option pop

typedef void __fastcall (__closure *TRzCanOpenEvent)(System::TObject* Sender, bool &CanOpen);

typedef void __fastcall (__closure *TRzCanCloseEvent)(System::TObject* Sender, bool &CanClose);

#pragma option push -b-
enum TRzGroupBarStyle { gbsCategoryView, gbsTaskList, gbsOutlook };
#pragma option pop

#pragma option push -b-
enum TRzItemStyle { isSmall, isLarge };
#pragma option pop

#pragma option push -b-
enum TRzCaptionStyle { csSmall, csLarge };
#pragma option pop

#pragma option push -b-
enum TRzItemSelectionStyle { issImage, issCaption, issImageAndCaption };
#pragma option pop

typedef TMetaClass* TRzGroupClass;

class DELPHICLASS TRzGroupItemActionLink;
class DELPHICLASS TRzGroupItem;
struct TCMGroupItemMsg;
typedef TMetaClass* TRzGroupItemActionLinkClass;

class DELPHICLASS TRzGroup;
class PASCALIMPLEMENTATION TRzGroupItem : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	AnsiString FCaption;
	bool FCaptionChanged;
	Imglist::TImageIndex FDisabledIndex;
	bool FEnabled;
	Graphics::TColor FFontColor;
	Graphics::TFontStyles FFontStyle;
	AnsiString FHint;
	Imglist::TImageIndex FImageIndex;
	Byte FIndentLevel;
	bool FVisible;
	bool FSelected;
	int FTag;
	void *FData;
	Classes::TNotifyEvent FOnClick;
	TRzGroupItemActionLink* FActionLink;
	bool FClickingCaption;
	TRzCaptionState FCaptionState;
	#pragma pack(push,1)
	Types::TRect FHotCaptionRect;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TRect FHotImageRect;
	#pragma pack(pop)
	void __fastcall ActionChangeHandler(System::TObject* Sender);
	MESSAGE void __fastcall CMGroupItemSelected(TCMGroupItemMsg &Msg);
	
protected:
	virtual AnsiString __fastcall GetDisplayName();
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	bool __fastcall IsCaptionStored(void);
	bool __fastcall IsEnabledStored(void);
	bool __fastcall IsHintStored(void);
	bool __fastcall IsHelpContextStored(void);
	bool __fastcall IsImageIndexStored(void);
	bool __fastcall IsVisibleStored(void);
	bool __fastcall IsOnClickStored(void);
	virtual Classes::TBasicAction* __fastcall GetAction(void);
	virtual void __fastcall SetAction(Classes::TBasicAction* Value);
	DYNAMIC TMetaClass* __fastcall GetActionLinkClass(void);
	virtual void __fastcall SetCaption(const AnsiString Value);
	virtual void __fastcall SetDisabledIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetFontColor(Graphics::TColor Value);
	virtual void __fastcall SetFontStyle(Graphics::TFontStyles Value);
	virtual TRzGroup* __fastcall GetGroup(void);
	virtual void __fastcall SetImageIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetIndentLevel(Byte Value);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall SetSelected(bool Value);
	void __fastcall UpdateSelection(void);
	__property TRzGroupItemActionLink* ActionLink = {read=FActionLink, write=FActionLink};
	
public:
	__fastcall virtual TRzGroupItem(Classes::TCollection* Collection);
	__fastcall virtual ~TRzGroupItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall AssignTo(Classes::TPersistent* Dest);
	virtual void __fastcall InitiateAction(void);
	DYNAMIC void __fastcall Click(void);
	__property Types::TRect HotCaptionRect = {read=FHotCaptionRect, write=FHotCaptionRect};
	__property Types::TRect HotImageRect = {read=FHotImageRect, write=FHotImageRect};
	__property TRzCaptionState CaptionState = {read=FCaptionState, write=FCaptionState, nodefault};
	__property bool ClickingCaption = {read=FClickingCaption, write=FClickingCaption, nodefault};
	__property void * Data = {read=FData, write=FData};
	__property TRzGroup* Group = {read=GetGroup};
	
__published:
	__property Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property AnsiString Caption = {read=FCaption, write=SetCaption, stored=IsCaptionStored};
	__property Imglist::TImageIndex DisabledIndex = {read=FDisabledIndex, write=SetDisabledIndex, default=-1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, stored=IsEnabledStored, default=1};
	__property Graphics::TColor FontColor = {read=FFontColor, write=SetFontColor, default=536870911};
	__property Graphics::TFontStyles FontStyle = {read=FFontStyle, write=SetFontStyle, default=0};
	__property AnsiString Hint = {read=FHint, write=FHint, stored=IsHintStored};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, stored=IsImageIndexStored, default=-1};
	__property Byte IndentLevel = {read=FIndentLevel, write=SetIndentLevel, default=0};
	__property bool Selected = {read=FSelected, write=SetSelected, default=0};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick, stored=IsOnClickStored};
};


class PASCALIMPLEMENTATION TRzGroupItemActionLink : public Actnlist::TActionLink 
{
	typedef Actnlist::TActionLink inherited;
	
protected:
	TRzGroupItem* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall DoShowHint(AnsiString &HintStr);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsEnabledLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsVisibleLinked(void);
	virtual bool __fastcall IsOnExecuteLinked(void);
	virtual void __fastcall SetCaption(const AnsiString Value);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetHint(const AnsiString Value);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall SetOnExecute(Classes::TNotifyEvent Value);
public:
	#pragma option push -w-inl
	/* TBasicActionLink.Create */ inline __fastcall virtual TRzGroupItemActionLink(System::TObject* AClient) : Actnlist::TActionLink(AClient) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TRzGroupItemActionLink(void) { }
	#pragma option pop
	
};


struct TCMGroupItemMsg
{
	
public:
	unsigned Msg;
	int Unused;
	TRzGroupItem* Sender;
	int Result;
} ;

class DELPHICLASS TRzGroupItems;
class PASCALIMPLEMENTATION TRzGroupItems : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TRzGroupItem* operator[](int Index) { return Items[Index]; }
	
private:
	TRzGroup* FGroup;
	HIDESBASE TRzGroupItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TRzGroupItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TRzGroupItems(TRzGroup* Group);
	HIDESBASE TRzGroupItem* __fastcall Add(void);
	__property TRzGroupItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TRzGroup* Group = {read=FGroup};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TRzGroupItems(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TRzMouseOverItemEvent)(System::TObject* Sender, TRzGroupItem* Item);

typedef void __fastcall (__closure *TRzGroupItemPopupMenuEvent)(System::TObject* Sender, TRzGroupItem* Item);

class DELPHICLASS TRzGroupBar;
class DELPHICLASS TRzGroupTemplate;
class PASCALIMPLEMENTATION TRzGroupBar : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Graphics::TCanvas* FCanvas;
	Classes::TList* FGroups;
	bool FUpdatingLayout;
	int FUpdateLayoutCount;
	TRzGroupBarStyle FStyle;
	Controls::TBevelWidth FBevelWidth;
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
	Rzcommon::TRzGroupBarGradientPath FGradientPath;
	int FGroupBorderSize;
	bool FScrolling;
	int FScrollPosition;
	bool FExclusiveMode;
	bool FUniqueItemSelection;
	Imglist::TCustomImageList* FSmallImages;
	Imglist::TChangeLink* FSmallImagesChangeLink;
	Imglist::TCustomImageList* FLargeImages;
	Imglist::TChangeLink* FLargeImagesChangeLink;
	void __fastcall ImagesChange(System::TObject* Sender);
	MESSAGE void __fastcall CMGroupItemSelected(TCMGroupItemMsg &Msg);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Messages::TWMNCCalcSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Msg);
	MESSAGE void __fastcall WMThemeChanged(Messages::TMessage &Msg);
	MESSAGE void __fastcall UMResetScrollPosition(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall SetChildOrder(Classes::TComponent* Child, int Order);
	void __fastcall RepaintBorder(void);
	void __fastcall RepaintGroups(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	virtual Types::TRect __fastcall GetControlExtents();
	void __fastcall PositionGroups(void);
	int __fastcall GetTotalHeight(void);
	void __fastcall ScrollControls(int Delta);
	virtual void __fastcall UpdateScrollBar(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	HIDESBASE virtual void __fastcall SetBevelWidth(Controls::TBevelWidth Value);
	virtual void __fastcall SetBorderColor(Graphics::TColor Value);
	virtual void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderSides(Rzcommon::TSides Value);
	virtual void __fastcall SetBorderHighlight(Graphics::TColor Value);
	virtual void __fastcall SetBorderShadow(Graphics::TColor Value);
	virtual void __fastcall SetFlatColor(Graphics::TColor Value);
	virtual void __fastcall SetFlatColorAdjustment(int Value);
	virtual void __fastcall SetGradientColorStyle(Rzcommon::TRzGradientColorStyle Value);
	virtual void __fastcall SetGradientColorStart(Graphics::TColor Value);
	virtual void __fastcall SetGradientColorStop(Graphics::TColor Value);
	virtual void __fastcall SetGradientPath(Rzcommon::TRzGroupBarGradientPath Value);
	virtual void __fastcall SetGroupBorderSize(int Value);
	virtual TRzGroup* __fastcall GetGroup(int Index);
	virtual int __fastcall GetGroupCount(void);
	virtual void __fastcall SetExclusiveMode(bool Value);
	virtual void __fastcall SetLargeImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetSmallImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetScrollPosition(int Value);
	virtual void __fastcall SetStyle(TRzGroupBarStyle Value);
	virtual void __fastcall SetUniqueItemSelection(bool Value);
	virtual void __fastcall SetVisualStyle(Rzcommon::TRzVisualStyle Value);
	__property int TotalHeight = {read=GetTotalHeight, nodefault};
	
public:
	__fastcall virtual TRzGroupBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzGroupBar(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	void __fastcall ShowEntireGroup(TRzGroup* Group);
	void __fastcall ScrollInView(Controls::TControl* AControl);
	bool __fastcall IsScrollBarVisible(void);
	void __fastcall UpdateLayout(TRzGroup* Group = (TRzGroup*)(0x0));
	void __fastcall BeginUpdateLayout(void);
	void __fastcall EndUpdateLayout(void);
	virtual TMetaClass* __fastcall GroupClass(void);
	TRzGroup* __fastcall CreateGroupFromTemplate(TRzGroupTemplate* Template);
	void __fastcall AddGroup(TRzGroup* Group)/* overload */;
	TRzGroup* __fastcall AddGroup(TRzGroupTemplate* Template)/* overload */;
	void __fastcall InsertGroup(int Index, TRzGroup* Group)/* overload */;
	TRzGroup* __fastcall InsertGroup(int Index, TRzGroupTemplate* Template)/* overload */;
	void __fastcall RemoveGroup(TRzGroup* Group);
	void __fastcall CloseAllGroups(void);
	void __fastcall OpenAllGroups(void);
	__property int GroupCount = {read=GetGroupCount, nodefault};
	__property TRzGroup* Groups[int Index] = {read=GetGroup};
	__property int ScrollPosition = {read=FScrollPosition, write=SetScrollPosition, nodefault};
	__property DockManager ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool ExclusiveMode = {read=FExclusiveMode, write=SetExclusiveMode, default=0};
	__property Controls::TBevelWidth BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=1};
	__property Rzcommon::TFrameStyleEx BorderInner = {read=FBorderInner, write=SetBorderInner, default=0};
	__property Rzcommon::TFrameStyleEx BorderOuter = {read=FBorderOuter, write=SetBorderOuter, default=0};
	__property Rzcommon::TSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777201};
	__property Graphics::TColor BorderHighlight = {read=FBorderHighlight, write=SetBorderHighlight, default=-16777196};
	__property Graphics::TColor BorderShadow = {read=FBorderShadow, write=SetBorderShadow, default=-16777200};
	__property Rzcommon::TRzGradientColorStyle GradientColorStyle = {read=FGradientColorStyle, write=SetGradientColorStyle, default=0};
	__property Graphics::TColor GradientColorStart = {read=FGradientColorStart, write=SetGradientColorStart, default=16777215};
	__property Graphics::TColor GradientColorStop = {read=FGradientColorStop, write=SetGradientColorStop, default=-16777201};
	__property Rzcommon::TRzGroupBarGradientPath GradientPath = {read=FGradientPath, write=SetGradientPath, default=0};
	__property Graphics::TColor FlatColor = {read=FFlatColor, write=SetFlatColor, default=-16777200};
	__property int FlatColorAdjustment = {read=FFlatColorAdjustment, write=SetFlatColorAdjustment, default=30};
	__property Imglist::TCustomImageList* LargeImages = {read=FLargeImages, write=SetLargeImages};
	__property Imglist::TCustomImageList* SmallImages = {read=FSmallImages, write=SetSmallImages};
	__property TRzGroupBarStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int GroupBorderSize = {read=FGroupBorderSize, write=SetGroupBorderSize, nodefault};
	__property bool UniqueItemSelection = {read=FUniqueItemSelection, write=SetUniqueItemSelection, default=0};
	__property Rzcommon::TRzVisualStyle VisualStyle = {read=FVisualStyle, write=SetVisualStyle, default=2};
	__property Align  = {default=3};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=0};
	__property BiDiMode ;
	__property BorderWidth  = {default=0};
	__property Caption ;
	__property Color ;
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property Height ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Visible  = {default=1};
	__property Width  = {default=160};
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
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzGroupBar(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzGroupController;
#pragma option push -b-
enum TRzGroupProperty { gpAll, gpBorderColor, gpCaptionColor, gpCaptionColorStart, gpCaptionColorStop, gpCaptionFont, gpCaptionHeight, gpCaptionHotColor, gpColor, gpParentColor, gpDividerColor, gpDividerVisible, gpFont, gpParentFont, gpItemHeight, gpItemHotColor, gpItemIndent, gpItemStaticFont, gpSelectionColor, gpSelectionFontColor, gpSelectionShadowColor, gpSelectionFrameColor, gpShowItemSelection, gpItemSelectionStyle, gpIgnoreSelectedItemClick, gpHideAccelerators };
#pragma option pop

class PASCALIMPLEMENTATION TRzGroupController : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Classes::TList* FGroupList;
	int FUpdateCount;
	Rzcommon::TRzRegIniFile* FRegIniFile;
	Graphics::TColor FBorderColor;
	Graphics::TColor FCaptionColor;
	Graphics::TColor FCaptionColorStart;
	Graphics::TColor FCaptionColorStop;
	Graphics::TFont* FCaptionFont;
	bool FCaptionFontChanged;
	int FCaptionHeight;
	Graphics::TColor FCaptionHotColor;
	Graphics::TColor FColor;
	Graphics::TColor FDividerColor;
	bool FDividerVisible;
	AnsiString FDefaultFontName;
	int FDefaultFontSize;
	Graphics::TFont* FFont;
	bool FFontChanged;
	int FItemHeight;
	Graphics::TColor FItemHotColor;
	Byte FItemIndent;
	Graphics::TFont* FItemStaticFont;
	bool FItemStaticFontChanged;
	bool FParentColor;
	bool FParentFont;
	Graphics::TColor FSelectionColor;
	Graphics::TColor FSelectionFontColor;
	Graphics::TColor FSelectionShadowColor;
	Graphics::TColor FSelectionFrameColor;
	bool FShowItemSelection;
	TRzItemSelectionStyle FItemSelectionStyle;
	bool FIgnoreSelectedItemClick;
	bool FHideAccelerators;
	void __fastcall FontChangeHandler(System::TObject* Sender);
	void __fastcall CaptionFontChangeHandler(System::TObject* Sender);
	void __fastcall ItemStaticFontChangeHandler(System::TObject* Sender);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall UpdateGroupProperty(TRzGroup* G, TRzGroupProperty GroupProperty);
	virtual void __fastcall UpdateAllGroups(TRzGroupProperty GroupProperty);
	void __fastcall UpdateFonts(void);
	virtual void __fastcall SetBorderColor(Graphics::TColor Value);
	virtual void __fastcall SetCaptionColor(Graphics::TColor Value);
	virtual void __fastcall SetCaptionColorStart(Graphics::TColor Value);
	virtual void __fastcall SetCaptionColorStop(Graphics::TColor Value);
	virtual void __fastcall SetCaptionFont(Graphics::TFont* Value);
	virtual void __fastcall SetCaptionHeight(int Value);
	virtual void __fastcall SetCaptionHotColor(Graphics::TColor Value);
	bool __fastcall IsFontStored(void);
	virtual void __fastcall SetFont(Graphics::TFont* Value);
	virtual void __fastcall SetItemHotColor(Graphics::TColor Value);
	virtual void __fastcall SetItemStaticFont(Graphics::TFont* Value);
	bool __fastcall StoreColor(void);
	virtual void __fastcall SetColor(Graphics::TColor Value);
	virtual void __fastcall SetSelectionColor(Graphics::TColor Value);
	virtual void __fastcall SetSelectionFontColor(Graphics::TColor Value);
	virtual void __fastcall SetSelectionShadowColor(Graphics::TColor Value);
	virtual void __fastcall SetSelectionFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetHideAccelerators(bool Value);
	virtual void __fastcall SetShowItemSelection(bool Value);
	virtual void __fastcall SetItemSelectionStyle(TRzItemSelectionStyle Value);
	virtual void __fastcall SetIgnoreSelectedItemClick(bool Value);
	virtual void __fastcall SetItemHeight(int Value);
	virtual void __fastcall SetItemIndent(Byte Value);
	virtual void __fastcall SetDividerVisible(bool Value);
	virtual void __fastcall SetDividerColor(Graphics::TColor Value);
	virtual void __fastcall SetParentColor(bool Value);
	virtual void __fastcall SetParentFont(bool Value);
	virtual void __fastcall SetRegIniFile(Rzcommon::TRzRegIniFile* Value);
	
public:
	__fastcall virtual TRzGroupController(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzGroupController(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall UpdateGroups(void);
	void __fastcall SetDefaults(TRzGroupBarStyle Style);
	void __fastcall AddGroup(TRzGroup* G);
	void __fastcall RemoveGroup(TRzGroup* G);
	void __fastcall Load(const AnsiString Section);
	void __fastcall Save(const AnsiString Section);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777196};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=-16777202};
	__property Graphics::TColor CaptionColorStart = {read=FCaptionColorStart, write=SetCaptionColorStart, default=-16777211};
	__property Graphics::TColor CaptionColorStop = {read=FCaptionColorStop, write=SetCaptionColorStop, default=-16777201};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont, stored=FCaptionFontChanged};
	__property int CaptionHeight = {read=FCaptionHeight, write=SetCaptionHeight, default=20};
	__property Graphics::TColor CaptionHotColor = {read=FCaptionHotColor, write=SetCaptionHotColor, default=-16777190};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, stored=StoreColor, default=-16777201};
	__property Graphics::TColor DividerColor = {read=FDividerColor, write=SetDividerColor, default=-16777203};
	__property bool DividerVisible = {read=FDividerVisible, write=SetDividerVisible, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont, stored=IsFontStored};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, default=20};
	__property Graphics::TColor ItemHotColor = {read=FItemHotColor, write=SetItemHotColor, default=-16777190};
	__property Byte ItemIndent = {read=FItemIndent, write=SetItemIndent, default=20};
	__property Graphics::TFont* ItemStaticFont = {read=FItemStaticFont, write=SetItemStaticFont, stored=FItemStaticFontChanged};
	__property bool ParentColor = {read=FParentColor, write=SetParentColor, default=0};
	__property bool ParentFont = {read=FParentFont, write=SetParentFont, default=1};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=SetSelectionColor, default=-16777201};
	__property Graphics::TColor SelectionFontColor = {read=FSelectionFontColor, write=SetSelectionFontColor, default=-16777208};
	__property Graphics::TColor SelectionShadowColor = {read=FSelectionShadowColor, write=SetSelectionShadowColor, default=-16777200};
	__property Graphics::TColor SelectionFrameColor = {read=FSelectionFrameColor, write=SetSelectionFrameColor, default=-16777195};
	__property bool HideAccelerators = {read=FHideAccelerators, write=SetHideAccelerators, default=1};
	__property bool ShowItemSelection = {read=FShowItemSelection, write=SetShowItemSelection, default=0};
	__property TRzItemSelectionStyle ItemSelectionStyle = {read=FItemSelectionStyle, write=SetItemSelectionStyle, default=2};
	__property bool IgnoreSelectedItemClick = {read=FIgnoreSelectedItemClick, write=SetIgnoreSelectedItemClick, default=1};
	__property Rzcommon::TRzRegIniFile* RegIniFile = {read=FRegIniFile, write=SetRegIniFile};
};


class PASCALIMPLEMENTATION TRzGroup : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	TRzGroupBar* FGroupBar;
	TRzGroupController* FGroupController;
	int FOpenedHeight;
	bool FOpened;
	bool FCanClose;
	TRzGroupBarStyle FStyle;
	bool FColorDefault;
	Graphics::TColor FCaptionColor;
	Graphics::TColor FCaptionColorStart;
	Graphics::TColor FCaptionColorStop;
	bool FCaptionColorDefault;
	Graphics::TColor FCaptionHotColor;
	Imglist::TImageIndex FCaptionImageIndex;
	int FCaptionHeight;
	Graphics::TFont* FCaptionFont;
	bool FCaptionFontChanged;
	Graphics::TColor FItemHotColor;
	bool FFontChanged;
	Graphics::TFont* FItemStaticFont;
	bool FItemStaticFontChanged;
	bool FDividerVisible;
	Graphics::TColor FDividerColor;
	Graphics::TColor FBorderColor;
	bool FSpecial;
	Graphics::TColor FSelectionColor;
	Graphics::TColor FSelectionFontColor;
	Graphics::TColor FSelectionShadowColor;
	Graphics::TColor FSelectionFrameColor;
	bool FHideAccelerators;
	bool FShowItemSelection;
	TRzItemSelectionStyle FItemSelectionStyle;
	bool FIgnoreSelectedItemClick;
	TRzCaptionState FCaptionState;
	bool FClickingCaption;
	HICON FCaptionCursor;
	TRzGroupItems* FItems;
	TRzItemStyle FItemStyle;
	int FItemHeight;
	Byte FItemIndent;
	int FTopItem;
	int FActionClientCount;
	TRzCaptionStyle FCaptionStyle;
	int FItemIndex;
	TRzGroupItem* FOverItem;
	void *FData;
	Imglist::TCustomImageList* FSmallImages;
	Imglist::TChangeLink* FSmallImagesChangeLink;
	Imglist::TCustomImageList* FLargeImages;
	Imglist::TChangeLink* FLargeImagesChangeLink;
	Rzspnedt::TRzRapidFireButton* FScrollUpBtn;
	Rzspnedt::TRzRapidFireButton* FScrollDownBtn;
	TRzCanCloseEvent FOnCanClose;
	TRzCanOpenEvent FOnCanOpen;
	Classes::TNotifyEvent FOnClose;
	Classes::TNotifyEvent FOnOpen;
	TRzMouseOverItemEvent FOnMouseOverItem;
	Menus::TPopupMenu* FItemPopupMenu;
	TRzGroupItem* FPopupItem;
	TRzGroupItemPopupMenuEvent FOnItemPopupMenu;
	int __fastcall DrawCaptionImage(void);
	int __fastcall CaptionImageHeight(void);
	int __fastcall CaptionYOffset(void);
	int __fastcall HeaderHeight(void);
	void __fastcall ImagesChange(System::TObject* Sender);
	void __fastcall CaptionFontChangeHandler(System::TObject* Sender);
	void __fastcall ItemStaticFontChangeHandler(System::TObject* Sender);
	void __fastcall ScrollUpHandler(System::TObject* Sender);
	void __fastcall ScrollDownHandler(System::TObject* Sender);
	MESSAGE void __fastcall CMGroupItemSelected(TCMGroupItemMsg &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Msg);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall CreateScrollButtons(void);
	void __fastcall UpdateScrollBtnPositions(void);
	void __fastcall UpdateScrollBtnVisibility(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall UpdateGroupBarLayout(void);
	virtual int __fastcall CalcBaseXOffset(void);
	bool __fastcall SkipSeparator(int Index);
	virtual void __fastcall DrawItems(void);
	virtual void __fastcall DrawOpenCloseButton(bool Opened, int Left, int Top, Graphics::TColor FillColor, Graphics::TColor LineColor, Graphics::TColor ChevronColor);
	virtual void __fastcall DrawCategoryGroup(void);
	virtual void __fastcall DrawThemedCategoryGroup(void);
	virtual void __fastcall DrawOutlookGroup(void);
	virtual void __fastcall DrawTaskListGroup(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	int __fastcall ClosedHeight(void);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	Types::TRect __fastcall CaptionRect();
	Types::TPoint __fastcall CursorPosition();
	virtual void __fastcall ToggleState(void);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	DYNAMIC void __fastcall DoEndDrag(System::TObject* Target, int X, int Y);
	virtual void __fastcall ItemDestroyed(int Index);
	void __fastcall DisplayItemPopupMenu(int Index, int X, int Y);
	void __fastcall DrawOutOfBounds(void);
	void __fastcall InvalidateGroupBar(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DoContextPopup(const Types::TPoint &MousePos, bool &Handled);
	DYNAMIC void __fastcall MouseOverItem(TRzGroupItem* Item);
	virtual void __fastcall SetBorderColor(Graphics::TColor Value);
	virtual void __fastcall SetCanClose(bool Value);
	Graphics::TColor __fastcall DefaultCaptionColor(TRzGroupBarStyle Style);
	virtual void __fastcall SetCaptionColor(Graphics::TColor Value);
	virtual void __fastcall SetCaptionColorStart(Graphics::TColor Value);
	virtual void __fastcall SetCaptionColorStop(Graphics::TColor Value);
	bool __fastcall IsCaptionColorStored(void);
	virtual void __fastcall SetCaptionColorDefault(bool Value);
	bool __fastcall IsCaptionFontStored(void);
	virtual void __fastcall SetCaptionFont(Graphics::TFont* Value);
	virtual void __fastcall SetCaptionHeight(int Value);
	virtual void __fastcall SetCaptionHotColor(Graphics::TColor Value);
	virtual void __fastcall SetCaptionImageIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetCaptionStyle(const TRzCaptionStyle Value);
	virtual void __fastcall SetItemHotColor(Graphics::TColor Value);
	bool __fastcall IsItemStaticFontStored(void);
	virtual void __fastcall SetItemStaticFont(Graphics::TFont* Value);
	bool __fastcall StoreColor(void);
	virtual Graphics::TColor __fastcall GetColor(void);
	HIDESBASE virtual void __fastcall SetColor(Graphics::TColor Value);
	virtual void __fastcall SetColorDefault(bool Value);
	Graphics::TColor __fastcall DefaultColor(TRzGroupBarStyle Style);
	virtual void __fastcall SetSelectionColor(Graphics::TColor Value);
	virtual void __fastcall SetSelectionFontColor(Graphics::TColor Value);
	virtual void __fastcall SetSelectionShadowColor(Graphics::TColor Value);
	virtual void __fastcall SetSelectionFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetHideAccelerators(bool Value);
	virtual void __fastcall SetShowItemSelection(bool Value);
	virtual void __fastcall SetItemSelectionStyle(TRzItemSelectionStyle Value);
	virtual TRzGroupItem* __fastcall GetSelectedItem(void);
	virtual void __fastcall SetItems(TRzGroupItems* Value);
	virtual void __fastcall SetItemStyle(TRzItemStyle Value);
	virtual void __fastcall SetItemHeight(int Value);
	virtual void __fastcall SetItemIndent(Byte Value);
	virtual void __fastcall SetItemIndex(int Value);
	virtual void __fastcall SetOpened(bool Value);
	virtual void __fastcall SetOpenedHeight(int Value);
	virtual void __fastcall SetLargeImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetGroupBar(TRzGroupBar* Value);
	virtual int __fastcall GetGroupIndex(void);
	virtual void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetSmallImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetStyle(TRzGroupBarStyle Value);
	virtual void __fastcall SetDividerVisible(bool Value);
	virtual void __fastcall SetDividerColor(Graphics::TColor Value);
	virtual void __fastcall SetItemPopupMenu(Menus::TPopupMenu* Value);
	virtual void __fastcall SetSpecial(bool Value);
	virtual void __fastcall SetTopItem(int Value);
	bool __fastcall NotUsingGroupController(void);
	virtual void __fastcall SetGroupController(TRzGroupController* Value);
	__property TRzGroupBarStyle Style = {read=FStyle, write=SetStyle, default=0};
	
public:
	__fastcall virtual TRzGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzGroup(void);
	void __fastcall Open(void);
	void __fastcall Close(void);
	void __fastcall AddToGroup(TRzGroupTemplate* Template);
	Imglist::TCustomImageList* __fastcall SmallImageList(void);
	Imglist::TCustomImageList* __fastcall LargeImageList(void);
	Imglist::TCustomImageList* __fastcall CaptionImageList(void);
	virtual void __fastcall InitiateAction(void);
	void __fastcall ActionClientConnect(void);
	void __fastcall ActionClientDisconnect(void);
	void __fastcall AssignActionList(Actnlist::TCustomActionList* ActionList, const AnsiString Category = "");
	void __fastcall Reposition(void);
	int __fastcall CalculateHeight(int W);
	int __fastcall ItemAtPos(const Types::TPoint &P);
	int __fastcall ItemsVisible(void);
	__property void * Data = {read=FData, write=FData};
	__property TRzGroupBar* GroupBar = {read=FGroupBar, write=SetGroupBar};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, nodefault};
	__property TRzGroupItem* SelectedItem = {read=GetSelectedItem};
	__property TRzGroupItem* PopupItem = {read=FPopupItem};
	__property int TopItem = {read=FTopItem, write=SetTopItem, nodefault};
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, stored=NotUsingGroupController, default=-16777196};
	__property bool CanClose = {read=FCanClose, write=SetCanClose, default=1};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, stored=IsCaptionColorStored, nodefault};
	__property Graphics::TColor CaptionColorStart = {read=FCaptionColorStart, write=SetCaptionColorStart, default=-16777211};
	__property Graphics::TColor CaptionColorStop = {read=FCaptionColorStop, write=SetCaptionColorStop, default=-16777201};
	__property bool CaptionColorDefault = {read=FCaptionColorDefault, write=SetCaptionColorDefault, stored=NotUsingGroupController, default=1};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont, stored=IsCaptionFontStored};
	__property int CaptionHeight = {read=FCaptionHeight, write=SetCaptionHeight, stored=NotUsingGroupController, default=20};
	__property Graphics::TColor CaptionHotColor = {read=FCaptionHotColor, write=SetCaptionHotColor, stored=NotUsingGroupController, default=-16777190};
	__property Imglist::TImageIndex CaptionImageIndex = {read=FCaptionImageIndex, write=SetCaptionImageIndex, default=-1};
	__property TRzCaptionStyle CaptionStyle = {read=FCaptionStyle, write=SetCaptionStyle, default=0};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, stored=StoreColor, nodefault};
	__property bool ColorDefault = {read=FColorDefault, write=SetColorDefault, stored=NotUsingGroupController, default=1};
	__property TRzGroupController* GroupController = {read=FGroupController, write=SetGroupController};
	__property int GroupIndex = {read=GetGroupIndex, write=SetGroupIndex, stored=false, nodefault};
	__property TRzGroupItems* Items = {read=FItems, write=SetItems};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, stored=NotUsingGroupController, default=20};
	__property Graphics::TColor ItemHotColor = {read=FItemHotColor, write=SetItemHotColor, stored=NotUsingGroupController, default=-16777190};
	__property Graphics::TFont* ItemStaticFont = {read=FItemStaticFont, write=SetItemStaticFont, stored=IsItemStaticFontStored};
	__property Byte ItemIndent = {read=FItemIndent, write=SetItemIndent, stored=NotUsingGroupController, default=20};
	__property TRzItemStyle ItemStyle = {read=FItemStyle, write=SetItemStyle, stored=NotUsingGroupController, default=0};
	__property Menus::TPopupMenu* ItemPopupMenu = {read=FItemPopupMenu, write=SetItemPopupMenu};
	__property Imglist::TCustomImageList* LargeImages = {read=FLargeImages, write=SetLargeImages};
	__property bool Opened = {read=FOpened, write=SetOpened, nodefault};
	__property int OpenedHeight = {read=FOpenedHeight, write=SetOpenedHeight, default=50};
	__property Graphics::TColor DividerColor = {read=FDividerColor, write=SetDividerColor, stored=NotUsingGroupController, default=-16777203};
	__property bool DividerVisible = {read=FDividerVisible, write=SetDividerVisible, stored=NotUsingGroupController, nodefault};
	__property Imglist::TCustomImageList* SmallImages = {read=FSmallImages, write=SetSmallImages};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=SetSelectionColor, stored=NotUsingGroupController, default=-16777201};
	__property Graphics::TColor SelectionFontColor = {read=FSelectionFontColor, write=SetSelectionFontColor, default=-16777208};
	__property Graphics::TColor SelectionShadowColor = {read=FSelectionShadowColor, write=SetSelectionShadowColor, stored=NotUsingGroupController, default=-16777200};
	__property Graphics::TColor SelectionFrameColor = {read=FSelectionFrameColor, write=SetSelectionFrameColor, stored=NotUsingGroupController, default=-16777195};
	__property bool HideAccelerators = {read=FHideAccelerators, write=SetHideAccelerators, stored=NotUsingGroupController, default=1};
	__property bool ShowItemSelection = {read=FShowItemSelection, write=SetShowItemSelection, stored=NotUsingGroupController, default=0};
	__property TRzItemSelectionStyle ItemSelectionStyle = {read=FItemSelectionStyle, write=SetItemSelectionStyle, stored=NotUsingGroupController, default=2};
	__property bool IgnoreSelectedItemClick = {read=FIgnoreSelectedItemClick, write=FIgnoreSelectedItemClick, default=1};
	__property bool Special = {read=FSpecial, write=SetSpecial, stored=NotUsingGroupController, default=0};
	__property TRzCanCloseEvent OnCanClose = {read=FOnCanClose, write=FOnCanClose};
	__property TRzCanOpenEvent OnCanOpen = {read=FOnCanOpen, write=FOnCanOpen};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property Classes::TNotifyEvent OnOpen = {read=FOnOpen, write=FOnOpen};
	__property TRzMouseOverItemEvent OnMouseOverItem = {read=FOnMouseOverItem, write=FOnMouseOverItem};
	__property TRzGroupItemPopupMenuEvent OnItemPopupMenu = {read=FOnItemPopupMenu, write=FOnItemPopupMenu};
	__property BiDiMode ;
	__property Caption ;
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property Font ;
	__property Height  = {stored=false};
	__property Left  = {stored=false};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property Top  = {stored=false};
	__property Visible  = {default=1};
	__property Width  = {stored=false};
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
	/* TWinControl.CreateParented */ inline __fastcall TRzGroup(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzGroupTemplateItemActionLink;
class DELPHICLASS TRzGroupTemplateItem;
typedef TMetaClass* TRzGroupTemplateItemActionLinkClass;

class PASCALIMPLEMENTATION TRzGroupTemplateItem : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	AnsiString FCaption;
	bool FCaptionChanged;
	Imglist::TImageIndex FDisabledIndex;
	bool FEnabled;
	Graphics::TColor FFontColor;
	Graphics::TFontStyles FFontStyle;
	AnsiString FHint;
	Imglist::TImageIndex FImageIndex;
	Byte FIndentLevel;
	bool FVisible;
	int FTag;
	void *FData;
	Classes::TNotifyEvent FOnClick;
	TRzGroupTemplateItemActionLink* FActionLink;
	void __fastcall ActionChangeHandler(System::TObject* Sender);
	
protected:
	virtual AnsiString __fastcall GetDisplayName();
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	bool __fastcall IsCaptionStored(void);
	bool __fastcall IsEnabledStored(void);
	bool __fastcall IsHintStored(void);
	bool __fastcall IsHelpContextStored(void);
	bool __fastcall IsImageIndexStored(void);
	bool __fastcall IsVisibleStored(void);
	bool __fastcall IsOnClickStored(void);
	virtual Classes::TBasicAction* __fastcall GetAction(void);
	virtual void __fastcall SetAction(Classes::TBasicAction* Value);
	DYNAMIC TMetaClass* __fastcall GetActionLinkClass(void);
	virtual void __fastcall SetCaption(const AnsiString Value);
	virtual void __fastcall SetDisabledIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetFontColor(Graphics::TColor Value);
	virtual void __fastcall SetFontStyle(Graphics::TFontStyles Value);
	virtual TRzGroupTemplate* __fastcall GetTemplate(void);
	virtual void __fastcall SetImageIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetIndentLevel(Byte Value);
	virtual void __fastcall SetVisible(bool Value);
	__property TRzGroupTemplateItemActionLink* ActionLink = {read=FActionLink, write=FActionLink};
	
public:
	__fastcall virtual TRzGroupTemplateItem(Classes::TCollection* Collection);
	__fastcall virtual ~TRzGroupTemplateItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall AssignTo(Classes::TPersistent* Dest);
	virtual void __fastcall InitiateAction(void);
	__property void * Data = {read=FData, write=FData};
	__property TRzGroupTemplate* Template = {read=GetTemplate};
	
__published:
	__property Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property AnsiString Caption = {read=FCaption, write=SetCaption, stored=IsCaptionStored};
	__property Imglist::TImageIndex DisabledIndex = {read=FDisabledIndex, write=SetDisabledIndex, default=-1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, stored=IsEnabledStored, default=1};
	__property Graphics::TColor FontColor = {read=FFontColor, write=SetFontColor, default=536870911};
	__property Graphics::TFontStyles FontStyle = {read=FFontStyle, write=SetFontStyle, default=0};
	__property AnsiString Hint = {read=FHint, write=FHint, stored=IsHintStored};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, stored=IsImageIndexStored, default=-1};
	__property Byte IndentLevel = {read=FIndentLevel, write=SetIndentLevel, default=0};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick, stored=IsOnClickStored};
};


class PASCALIMPLEMENTATION TRzGroupTemplateItemActionLink : public Actnlist::TActionLink 
{
	typedef Actnlist::TActionLink inherited;
	
protected:
	TRzGroupTemplateItem* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsEnabledLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsVisibleLinked(void);
	virtual bool __fastcall IsOnExecuteLinked(void);
	virtual void __fastcall SetCaption(const AnsiString Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetHint(const AnsiString Value);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall SetOnExecute(Classes::TNotifyEvent Value);
public:
	#pragma option push -w-inl
	/* TBasicActionLink.Create */ inline __fastcall virtual TRzGroupTemplateItemActionLink(System::TObject* AClient) : Actnlist::TActionLink(AClient) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TRzGroupTemplateItemActionLink(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzGroupTemplateItems;
class PASCALIMPLEMENTATION TRzGroupTemplateItems : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TRzGroupTemplateItem* operator[](int Index) { return Items[Index]; }
	
private:
	TRzGroupTemplate* FTemplate;
	HIDESBASE TRzGroupTemplateItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TRzGroupTemplateItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TRzGroupTemplateItems(TRzGroupTemplate* Template);
	HIDESBASE TRzGroupTemplateItem* __fastcall Add(void);
	__property TRzGroupTemplateItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TRzGroupTemplate* Template = {read=FTemplate};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TRzGroupTemplateItems(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzGroupTemplatePreviewOptions;
class PASCALIMPLEMENTATION TRzGroupTemplatePreviewOptions : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TRzGroupTemplate* FTemplate;
	TRzItemStyle FItemStyle;
	Imglist::TCustomImageList* FSmallImages;
	Imglist::TChangeLink* FSmallImagesChangeLink;
	Imglist::TCustomImageList* FLargeImages;
	Imglist::TChangeLink* FLargeImagesChangeLink;
	
protected:
	void __fastcall SetLargeImages(Imglist::TCustomImageList* Value);
	void __fastcall SetSmallImages(Imglist::TCustomImageList* Value);
	
public:
	__fastcall TRzGroupTemplatePreviewOptions(TRzGroupTemplate* ATemplate);
	__fastcall virtual ~TRzGroupTemplatePreviewOptions(void);
	
__published:
	__property TRzItemStyle ItemStyle = {read=FItemStyle, write=FItemStyle, default=0};
	__property Imglist::TCustomImageList* LargeImages = {read=FLargeImages, write=SetLargeImages};
	__property Imglist::TCustomImageList* SmallImages = {read=FSmallImages, write=SetSmallImages};
};


class PASCALIMPLEMENTATION TRzGroupTemplate : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FCanClose;
	AnsiString FCaption;
	Imglist::TImageIndex FCaptionImageIndex;
	TRzCaptionStyle FCaptionStyle;
	bool FOpened;
	bool FSpecial;
	TRzGroupTemplateItems* FItems;
	Menus::TPopupMenu* FItemPopupMenu;
	Menus::TPopupMenu* FPopupMenu;
	TRzGroupItemPopupMenuEvent FOnItemPopupMenu;
	TRzGroupTemplatePreviewOptions* FPreviewOptions;
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetItems(TRzGroupTemplateItems* Value);
	virtual void __fastcall SetItemPopupMenu(Menus::TPopupMenu* Value);
	virtual void __fastcall SetPopupMenu(Menus::TPopupMenu* Value);
	void __fastcall SetPreviewOptions(TRzGroupTemplatePreviewOptions* Value);
	
public:
	__fastcall virtual TRzGroupTemplate(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzGroupTemplate(void);
	void __fastcall AssignActionList(Actnlist::TCustomActionList* ActionList, const AnsiString Category = "");
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool CanClose = {read=FCanClose, write=FCanClose, default=1};
	__property AnsiString Caption = {read=FCaption, write=FCaption};
	__property Imglist::TImageIndex CaptionImageIndex = {read=FCaptionImageIndex, write=FCaptionImageIndex, default=-1};
	__property TRzCaptionStyle CaptionStyle = {read=FCaptionStyle, write=FCaptionStyle, default=0};
	__property TRzGroupTemplateItems* Items = {read=FItems, write=SetItems};
	__property Menus::TPopupMenu* ItemPopupMenu = {read=FItemPopupMenu, write=SetItemPopupMenu};
	__property Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=SetPopupMenu};
	__property bool Opened = {read=FOpened, write=FOpened, default=1};
	__property TRzGroupTemplatePreviewOptions* PreviewOptions = {read=FPreviewOptions, write=SetPreviewOptions};
	__property bool Special = {read=FSpecial, write=FSpecial, default=0};
	__property TRzGroupItemPopupMenuEvent OnItemPopupMenu = {read=FOnItemPopupMenu, write=FOnItemPopupMenu};
};


//-- var, const, procedure ---------------------------------------------------
static const Word um_ResetScrollPosition = 0x2424;
extern PACKAGE System::ResourceString _sRzCannotLoadGroupController;
#define Rzgroupbar_sRzCannotLoadGroupController System::LoadResourceString(&Rzgroupbar::_sRzCannotLoadGroupController)
extern PACKAGE System::ResourceString _sRzCannotSaveGroupController;
#define Rzgroupbar_sRzCannotSaveGroupController System::LoadResourceString(&Rzgroupbar::_sRzCannotSaveGroupController)

}	/* namespace Rzgroupbar */
using namespace Rzgroupbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzgroupbar
