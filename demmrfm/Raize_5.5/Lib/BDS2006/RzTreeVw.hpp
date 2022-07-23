// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rztreevw.pas' rev: 10.00

#ifndef RztreevwHPP
#define RztreevwHPP

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
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rztreevw
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TRzTvOnNodeContextMenuEvent)(System::TObject* aSender, Comctrls::TTreeNode* aNode, Types::TPoint &aPos, Menus::TPopupMenu* &aMenu);

class DELPHICLASS TRzCustomTreeView;
class PASCALIMPLEMENTATION TRzCustomTreeView : public Comctrls::TCustomTreeView 
{
	typedef Comctrls::TCustomTreeView inherited;
	
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
	bool FAutoSelect;
	Graphics::TPen* FSelectionPen;
	int FItemHeight;
	Comctrls::TTreeNode* FRClickNode;
	TRzTvOnNodeContextMenuEvent FOnNodeContextMenu;
	bool FMenuAlreadyHandled;
	char FPathDelimiter;
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameFocusStyleProp(Classes::TReader* Reader);
	void __fastcall PenChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Messages::TMessage &Msg);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Controls::TControlCanvas* FCanvas;
	bool FOverControl;
	bool FRecreating;
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall UpdateItemHeight(void);
	virtual void __fastcall UpdateColors(void);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	virtual void __fastcall RepaintFrame(void);
	DYNAMIC void __fastcall Collapse(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Expand(Comctrls::TTreeNode* Node);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC void __fastcall DoPreNodeContextMenu(void);
	DYNAMIC void __fastcall DoNodeContextMenu(Comctrls::TTreeNode* Node, const Types::TPoint &P);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState ShiftState);
	DYNAMIC void __fastcall NodeContextMenu(Comctrls::TTreeNode* Node, Types::TPoint &Pos, Menus::TPopupMenu* &Menu);
	HIDESBASE Comctrls::TTreeNode* __fastcall GetSelected(void);
	HIDESBASE void __fastcall SetSelected(Comctrls::TTreeNode* Value);
	virtual void __fastcall LoadTreeFromList(Classes::TStrings* List);
	virtual void __fastcall SaveTreeToList(Classes::TStrings* List);
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
	virtual bool __fastcall GetAutoExpand(void);
	HIDESBASE virtual void __fastcall SetAutoExpand(bool Value);
	virtual void __fastcall SetAutoSelect(bool Value);
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
	virtual void __fastcall SetItemHeight(int Value);
	virtual void __fastcall SetSelectionPen(Graphics::TPen* Value);
	__property bool AutoExpand = {read=GetAutoExpand, write=SetAutoExpand, default=0};
	__property bool AutoSelect = {read=FAutoSelect, write=SetAutoSelect, default=0};
	__property Color  = {stored=StoreColor, default=-16777211};
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
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, default=0};
	__property char PathDelimiter = {read=FPathDelimiter, write=FPathDelimiter, default=92};
	__property Graphics::TPen* SelectionPen = {read=FSelectionPen, write=SetSelectionPen};
	__property ParentColor  = {default=0};
	__property TabStop  = {default=1};
	__property OnMouseWheel ;
	__property OnMouseWheelUp ;
	__property OnMouseWheelDown ;
	__property TRzTvOnNodeContextMenuEvent OnNodeContextMenu = {read=FOnNodeContextMenu, write=FOnNodeContextMenu};
	
public:
	__fastcall virtual TRzCustomTreeView(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomTreeView(void);
	virtual bool __fastcall UseThemes(void);
	Comctrls::TTreeNode* __fastcall NodeFromPath(AnsiString Path);
	AnsiString __fastcall PathFromNode(Comctrls::TTreeNode* Node);
	void __fastcall SelectByPath(const AnsiString Path);
	void __fastcall UpdateStateIndexDisplay(Comctrls::TTreeNode* Node);
	HIDESBASE void __fastcall FullCollapse(void);
	HIDESBASE void __fastcall FullExpand(void);
	HIDESBASE void __fastcall LoadFromFile(const AnsiString FileName);
	HIDESBASE void __fastcall LoadFromStream(Classes::TStream* Stream);
	HIDESBASE void __fastcall SaveToFile(const AnsiString FileName);
	HIDESBASE void __fastcall SaveToStream(Classes::TStream* Stream);
	void __fastcall InvalidateNode(Comctrls::TTreeNode* Node, bool TextOnly, bool EraseBkgnd);
	__property Comctrls::TTreeNode* Selected = {read=GetSelected, write=SetSelected};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomTreeView(HWND ParentWindow) : Comctrls::TCustomTreeView(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzTreeView;
class PASCALIMPLEMENTATION TRzTreeView : public TRzCustomTreeView 
{
	typedef TRzCustomTreeView inherited;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property SelectionPen ;
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property AutoExpand  = {default=0};
	__property AutoSelect  = {default=0};
	__property BiDiMode ;
	__property BorderStyle  = {default=1};
	__property BorderWidth  = {default=0};
	__property ChangeDelay  = {default=0};
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
	__property HideSelection  = {default=1};
	__property HotTrack  = {default=0};
	__property Images ;
	__property Indent ;
	__property ItemHeight  = {default=0};
	__property MultiSelect  = {default=0};
	__property MultiSelectStyle  = {default=1};
	__property PathDelimiter  = {default=92};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property RightClickSelect  = {default=0};
	__property RowSelect  = {default=0};
	__property ShowButtons  = {default=1};
	__property ShowHint ;
	__property ShowLines  = {default=1};
	__property ShowRoot  = {default=1};
	__property SortType  = {default=0};
	__property StateImages ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property ToolTips  = {default=1};
	__property Visible  = {default=1};
	__property OnAddition ;
	__property OnAdvancedCustomDraw ;
	__property OnAdvancedCustomDrawItem ;
	__property OnCancelEdit ;
	__property OnChange ;
	__property OnChanging ;
	__property OnClick ;
	__property OnCollapsed ;
	__property OnCollapsing ;
	__property OnCompare ;
	__property OnContextPopup ;
	__property OnCreateNodeClass ;
	__property OnCustomDraw ;
	__property OnCustomDrawItem ;
	__property OnDblClick ;
	__property OnDeletion ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEdited ;
	__property OnEditing ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnExpanded ;
	__property OnExpanding ;
	__property OnGetImageIndex ;
	__property OnGetSelectedIndex ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnNodeContextMenu ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseWheel ;
	__property OnMouseWheelUp ;
	__property OnMouseWheelDown ;
	__property Items ;
public:
	#pragma option push -w-inl
	/* TRzCustomTreeView.Create */ inline __fastcall virtual TRzTreeView(Classes::TComponent* AOwner) : TRzCustomTreeView(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomTreeView.Destroy */ inline __fastcall virtual ~TRzTreeView(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzTreeView(HWND ParentWindow) : TRzCustomTreeView(ParentWindow) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzCheckState { csUnknown, csUnchecked, csChecked, csPartiallyChecked };
#pragma option pop

typedef void __fastcall (__closure *TRzCheckTreeChangingEvent)(System::TObject* Sender, Comctrls::TTreeNode* Node, TRzCheckState NewState, bool &AllowChange);

typedef void __fastcall (__closure *TRzCheckTreeChangeEvent)(System::TObject* Sender, Comctrls::TTreeNode* Node, TRzCheckState NewState);

typedef void __fastcall (__closure *TRzCheckTreeCascadeCompleteEvent)(System::TObject* Sender, Comctrls::TTreeNode* Node);

class DELPHICLASS TRzCheckTree;
class PASCALIMPLEMENTATION TRzCheckTree : public TRzCustomTreeView 
{
	typedef TRzCustomTreeView inherited;
	
private:
	int FSelectedItem;
	int FBmpWidth;
	int FImageWidth;
	bool FChangingState;
	bool FSuspendCascades;
	Controls::TImageList* FCheckImages;
	bool FCascadeChecks;
	bool FSilentStateChanges;
	Graphics::TColor FHighlightColor;
	TRzCheckTreeChangingEvent FOnStateChanging;
	TRzCheckTreeChangeEvent FOnStateChange;
	Classes::TNotifyEvent FOnUpdateChildren;
	TRzCheckTreeCascadeCompleteEvent FOnCascadeComplete;
	TRzCheckState __fastcall GetItemState(int AbsoluteIndex);
	void __fastcall SetItemState(int AbsoluteIndex, TRzCheckState Value);
	void __fastcall SetNodeCheckState(Comctrls::TTreeNode* Node, TRzCheckState NewState);
	void __fastcall RecurseChildren(Comctrls::TTreeNode* Node, bool NodeChecked);
	void __fastcall SetAllChildren(Comctrls::TTreeNode* Node, TRzCheckState NewState);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall UpdateItemHeight(void);
	virtual void __fastcall UpdateImageWidth(void);
	virtual void __fastcall InitStateImages(void);
	virtual void __fastcall UpdateParents(Comctrls::TTreeNode* Node, bool NodeChecked);
	virtual void __fastcall UpdateChildren(Comctrls::TTreeNode* Node, bool NodeChecked);
	DYNAMIC void __fastcall CascadeComplete(Comctrls::TTreeNode* Node);
	virtual void __fastcall LoadTreeFromList(Classes::TStrings* List);
	virtual void __fastcall SaveTreeToList(Classes::TStrings* List);
	DYNAMIC bool __fastcall CanChangeState(Comctrls::TTreeNode* Node, TRzCheckState NewState);
	DYNAMIC void __fastcall StateChange(Comctrls::TTreeNode* Node, TRzCheckState NewState);
	DYNAMIC void __fastcall Delete(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	Imglist::TCustomImageList* __fastcall GetImages(void);
	HIDESBASE void __fastcall SetImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	void __fastcall SetHighlightColor(Graphics::TColor Value);
	
public:
	__fastcall virtual TRzCheckTree(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCheckTree(void);
	void __fastcall ToggleCheckState(Comctrls::TTreeNode* Node);
	void __fastcall ChangeNodeCheckState(Comctrls::TTreeNode* Node, TRzCheckState NewState);
	void __fastcall ForceCheckState(Comctrls::TTreeNode* Node, TRzCheckState NewState);
	void __fastcall SetAllNodes(TRzCheckState NewState);
	void __fastcall UpdateCascadingStates(Comctrls::TTreeNode* Node);
	void __fastcall UpdateChildrenCascadingStates(Comctrls::TTreeNode* ParentNode);
	void __fastcall UpdateStateFromChildren(Comctrls::TTreeNode* ParentNode, Comctrls::TTreeNode* DeletedNode);
	__property TRzCheckState ItemState[int Index] = {read=GetItemState, write=SetItemState};
	__property bool SilentCheckChanges = {read=FSilentStateChanges, write=FSilentStateChanges, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool CascadeChecks = {read=FCascadeChecks, write=FCascadeChecks, default=1};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=SetHighlightColor, default=-16777203};
	__property Imglist::TCustomImageList* Images = {read=GetImages, write=SetImages};
	__property TRzCheckTreeCascadeCompleteEvent OnCascadeComplete = {read=FOnCascadeComplete, write=FOnCascadeComplete};
	__property TRzCheckTreeChangingEvent OnStateChanging = {read=FOnStateChanging, write=FOnStateChanging};
	__property TRzCheckTreeChangeEvent OnStateChange = {read=FOnStateChange, write=FOnStateChange};
	__property Classes::TNotifyEvent OnUpdateChildren = {read=FOnUpdateChildren, write=FOnUpdateChildren};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property AutoExpand  = {default=0};
	__property AutoSelect  = {default=0};
	__property BiDiMode ;
	__property BorderStyle  = {default=1};
	__property BorderWidth  = {default=0};
	__property ChangeDelay  = {default=0};
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
	__property HideSelection  = {default=1};
	__property HotTrack  = {default=0};
	__property Indent ;
	__property ItemHeight  = {default=0};
	__property MultiSelect  = {default=0};
	__property MultiSelectStyle  = {default=1};
	__property PathDelimiter  = {default=92};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=1};
	__property RightClickSelect  = {default=0};
	__property RowSelect  = {default=0};
	__property SelectionPen ;
	__property ShowButtons  = {default=1};
	__property ShowHint ;
	__property ShowLines  = {default=1};
	__property ShowRoot  = {default=1};
	__property SortType  = {default=0};
	__property StateImages ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property OnAddition ;
	__property OnAdvancedCustomDraw ;
	__property OnAdvancedCustomDrawItem ;
	__property OnCancelEdit ;
	__property OnChange ;
	__property OnChanging ;
	__property OnClick ;
	__property OnCollapsed ;
	__property OnCollapsing ;
	__property OnCompare ;
	__property OnContextPopup ;
	__property OnCreateNodeClass ;
	__property OnCustomDraw ;
	__property OnCustomDrawItem ;
	__property OnDblClick ;
	__property OnDeletion ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEdited ;
	__property OnEditing ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnExpanded ;
	__property OnExpanding ;
	__property OnGetImageIndex ;
	__property OnGetSelectedIndex ;
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
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnNodeContextMenu ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property Items ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCheckTree(HWND ParentWindow) : TRzCustomTreeView(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#define RESOURCE_CHECKS "RZTREEVW_CHECKS"
static const Shortint STATE_UNCHECKED = 0x1;
static const Shortint STATE_CHECKED = 0x2;
static const Shortint STATE_PARTCHECKED = 0x3;

}	/* namespace Rztreevw */
using namespace Rztreevw;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rztreevw
