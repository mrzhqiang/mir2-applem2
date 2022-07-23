// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzdbnav.pas' rev: 10.00

#ifndef RzdbnavHPP
#define RzdbnavHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzdbnav
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzDBNavigatorImageIndexes;
class DELPHICLASS TRzDBNavigator;
class DELPHICLASS TRzNavigatorDataLink;
class PASCALIMPLEMENTATION TRzNavigatorDataLink : public Db::TDataLink 
{
	typedef Db::TDataLink inherited;
	
private:
	TRzDBNavigator* FNavigator;
	
protected:
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TRzNavigatorDataLink(TRzDBNavigator* Navigator);
	__fastcall virtual ~TRzNavigatorDataLink(void);
};


#pragma option push -b-
enum TRzNavigatorButton { nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh };
#pragma option pop

typedef Set<TRzNavigatorButton, nbFirst, nbRefresh>  TRzNavigatorButtons;

typedef void __fastcall (__closure *TRzNavigatorButtonClickEvent)(System::TObject* Sender, TRzNavigatorButton Button);

#pragma option push -b-
enum TRzNavigatorEnablementStyle { nesTraditional, nesNoBrowseOnEdit };
#pragma option pop

class DELPHICLASS TRzNavigatorToolButton;
class PASCALIMPLEMENTATION TRzDBNavigator : public Rzpanel::TRzCustomPanel 
{
	typedef Rzpanel::TRzCustomPanel inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	TRzNavigatorDataLink* FDataLink;
	TRzNavigatorButtons FVisibleButtons;
	Classes::TStrings* FHints;
	Classes::TStrings* FDefHints;
	int ButtonWidth;
	#pragma pack(push,1)
	Types::TPoint MinBtnSize;
	#pragma pack(pop)
	TRzNavigatorButtonClickEvent FOnNavClick;
	TRzNavigatorButtonClickEvent FBeforeAction;
	TRzNavigatorButton FocusedButton;
	bool FConfirmDelete;
	bool FFlat;
	TRzNavigatorEnablementStyle FEnablementStyle;
	Imglist::TCustomImageList* FInternalImages;
	TRzDBNavigatorImageIndexes* FImageIndexes;
	Imglist::TCustomImageList* FImages;
	Imglist::TChangeLink* FImagesChangeLink;
	void __fastcall BtnMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ClickHandler(System::TObject* Sender);
	void __fastcall HintsChanged(System::TObject* Sender);
	void __fastcall ImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanging(Messages::TWMWindowPosMsg &Msg);
	
protected:
	TRzNavigatorToolButton* Buttons[10];
	void __fastcall InitImageLists(void);
	void __fastcall InitButtons(void);
	void __fastcall InitHints(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DataChanged(void);
	virtual void __fastcall EditingChanged(void);
	void __fastcall ActiveChanged(void);
	void __fastcall UpdateImages(TRzNavigatorButton NavBtn);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	void __fastcall CalcMinSize(int &W, int &H);
	virtual Rzcommon::TRzGradientColorStyle __fastcall GetButtonGradientColorStyle(void);
	virtual void __fastcall SetButtonGradientColorStyle(Rzcommon::TRzGradientColorStyle Value);
	virtual Graphics::TColor __fastcall GetButtonSelectionColorStart(void);
	virtual void __fastcall SetButtonSelectionColorStart(Graphics::TColor Value);
	virtual Graphics::TColor __fastcall GetButtonSelectionColorStop(void);
	virtual void __fastcall SetButtonSelectionColorStop(Graphics::TColor Value);
	virtual Graphics::TColor __fastcall GetButtonSelectionFrameColor(void);
	virtual void __fastcall SetButtonSelectionFrameColor(Graphics::TColor Value);
	virtual Rzcommon::TRzVisualStyle __fastcall GetButtonVisualStyle(void);
	virtual void __fastcall SetButtonVisualStyle(Rzcommon::TRzVisualStyle Value);
	virtual Db::TDataSource* __fastcall GetDataSource(void);
	virtual void __fastcall SetDataSource(Db::TDataSource* Value);
	virtual void __fastcall SetFlat(bool Value);
	virtual Classes::TStrings* __fastcall GetHints(void);
	virtual void __fastcall SetHints(Classes::TStrings* Value);
	virtual void __fastcall SetImageIndexes(TRzDBNavigatorImageIndexes* Value);
	virtual void __fastcall SetImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetSize(int &W, int &H);
	HIDESBASE virtual void __fastcall SetVisible(TRzNavigatorButtons Value);
	
public:
	__fastcall virtual TRzDBNavigator(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDBNavigator(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual void __fastcall BtnClick(TRzNavigatorButton NavBtn);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Rzcommon::TRzGradientColorStyle ButtonGradientColorStyle = {read=GetButtonGradientColorStyle, write=SetButtonGradientColorStyle, default=0};
	__property Graphics::TColor ButtonSelectionColorStart = {read=GetButtonSelectionColorStart, write=SetButtonSelectionColorStart, default=-16777201};
	__property Graphics::TColor ButtonSelectionColorStop = {read=GetButtonSelectionColorStop, write=SetButtonSelectionColorStop, default=-16777200};
	__property Graphics::TColor ButtonSelectionFrameColor = {read=GetButtonSelectionFrameColor, write=SetButtonSelectionFrameColor, default=-16777195};
	__property Rzcommon::TRzVisualStyle ButtonVisualStyle = {read=GetButtonVisualStyle, write=SetButtonVisualStyle, default=1};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ConfirmDelete = {read=FConfirmDelete, write=FConfirmDelete, default=1};
	__property TRzNavigatorEnablementStyle EnablementStyle = {read=FEnablementStyle, write=FEnablementStyle, default=0};
	__property TRzNavigatorButtons VisibleButtons = {read=FVisibleButtons, write=SetVisible, default=1023};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property Classes::TStrings* Hints = {read=GetHints, write=SetHints};
	__property TRzDBNavigatorImageIndexes* ImageIndexes = {read=FImageIndexes, write=SetImageIndexes};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property TRzNavigatorButtonClickEvent BeforeAction = {read=FBeforeAction, write=FBeforeAction};
	__property TRzNavigatorButtonClickEvent OnClick = {read=FOnNavClick, write=FOnNavClick};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=6};
	__property BorderSides  = {default=15};
	__property BorderColor  = {default=-16777201};
	__property BorderHighlight  = {default=-16777196};
	__property BorderShadow  = {default=-16777200};
	__property BorderWidth  = {default=0};
	__property Color  = {default=-16777201};
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=30};
	__property FullRepaint  = {default=1};
	__property GradientColorStyle  = {default=0};
	__property GradientColorStart  = {default=16777215};
	__property GradientColorStop  = {default=-16777201};
	__property GradientDirection  = {default=2};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Transparent  = {default=0};
	__property Visible  = {default=1};
	__property VisualStyle  = {default=1};
	__property OnCanResize ;
	__property OnConstrainedResize ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnPaint ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBNavigator(HWND ParentWindow) : Rzpanel::TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzDBNavigatorImageIndexes : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TRzDBNavigator* FNavigator;
	Imglist::TImageIndex FFirst;
	Imglist::TImageIndex FFirstDisabled;
	Imglist::TImageIndex FPrevious;
	Imglist::TImageIndex FPreviousDisabled;
	Imglist::TImageIndex FNext;
	Imglist::TImageIndex FNextDisabled;
	Imglist::TImageIndex FLast;
	Imglist::TImageIndex FLastDisabled;
	Imglist::TImageIndex FInsert;
	Imglist::TImageIndex FInsertDisabled;
	Imglist::TImageIndex FDelete;
	Imglist::TImageIndex FDeleteDisabled;
	Imglist::TImageIndex FEdit;
	Imglist::TImageIndex FEditDisabled;
	Imglist::TImageIndex FPost;
	Imglist::TImageIndex FPostDisabled;
	Imglist::TImageIndex FCancel;
	Imglist::TImageIndex FCancelDisabled;
	Imglist::TImageIndex FRefresh;
	Imglist::TImageIndex FRefreshDisabled;
	
protected:
	virtual Imglist::TImageIndex __fastcall GetImageIndex(int Index);
	virtual void __fastcall SetImageIndex(int Index, Imglist::TImageIndex Value);
	
public:
	__fastcall TRzDBNavigatorImageIndexes(TRzDBNavigator* Navigator);
	__property TRzDBNavigator* Navigator = {read=FNavigator};
	
__published:
	__property Imglist::TImageIndex First = {read=GetImageIndex, write=SetImageIndex, index=0, default=-1};
	__property Imglist::TImageIndex FirstDisabled = {read=GetImageIndex, write=SetImageIndex, index=1, default=-1};
	__property Imglist::TImageIndex Previous = {read=GetImageIndex, write=SetImageIndex, index=2, default=-1};
	__property Imglist::TImageIndex PreviousDisabled = {read=GetImageIndex, write=SetImageIndex, index=3, default=-1};
	__property Imglist::TImageIndex Next = {read=GetImageIndex, write=SetImageIndex, index=4, default=-1};
	__property Imglist::TImageIndex NextDisabled = {read=GetImageIndex, write=SetImageIndex, index=5, default=-1};
	__property Imglist::TImageIndex Last = {read=GetImageIndex, write=SetImageIndex, index=6, default=-1};
	__property Imglist::TImageIndex LastDisabled = {read=GetImageIndex, write=SetImageIndex, index=7, default=-1};
	__property Imglist::TImageIndex Insert = {read=GetImageIndex, write=SetImageIndex, index=8, default=-1};
	__property Imglist::TImageIndex InsertDisabled = {read=GetImageIndex, write=SetImageIndex, index=9, default=-1};
	__property Imglist::TImageIndex Delete = {read=GetImageIndex, write=SetImageIndex, index=10, default=-1};
	__property Imglist::TImageIndex DeleteDisabled = {read=GetImageIndex, write=SetImageIndex, index=11, default=-1};
	__property Imglist::TImageIndex Edit = {read=GetImageIndex, write=SetImageIndex, index=12, default=-1};
	__property Imglist::TImageIndex EditDisabled = {read=GetImageIndex, write=SetImageIndex, index=13, default=-1};
	__property Imglist::TImageIndex Post = {read=GetImageIndex, write=SetImageIndex, index=14, default=-1};
	__property Imglist::TImageIndex PostDisabled = {read=GetImageIndex, write=SetImageIndex, index=15, default=-1};
	__property Imglist::TImageIndex Cancel = {read=GetImageIndex, write=SetImageIndex, index=16, default=-1};
	__property Imglist::TImageIndex CancelDisabled = {read=GetImageIndex, write=SetImageIndex, index=17, default=-1};
	__property Imglist::TImageIndex Refresh = {read=GetImageIndex, write=SetImageIndex, index=18, default=-1};
	__property Imglist::TImageIndex RefreshDisabled = {read=GetImageIndex, write=SetImageIndex, index=19, default=-1};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRzDBNavigatorImageIndexes(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum RzDBNav__2 { nbsAllowTimer, nbsFocusRect };
#pragma option pop

typedef Set<RzDBNav__2, nbsAllowTimer, nbsFocusRect>  TRzNavigatorButtonStyle;

class PASCALIMPLEMENTATION TRzNavigatorToolButton : public Rzbutton::TRzToolButton 
{
	typedef Rzbutton::TRzToolButton inherited;
	
private:
	TRzNavigatorButton FNavBtn;
	TRzNavigatorButtonStyle FNavStyle;
	Extctrls::TTimer* FRepeatTimer;
	void __fastcall TimerExpired(System::TObject* Sender);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual ~TRzNavigatorToolButton(void);
	__property TRzNavigatorButtonStyle NavStyle = {read=FNavStyle, write=FNavStyle, nodefault};
	__property TRzNavigatorButton NavBtn = {read=FNavBtn, write=FNavBtn, nodefault};
public:
	#pragma option push -w-inl
	/* TRzToolButton.Create */ inline __fastcall virtual TRzNavigatorToolButton(Classes::TComponent* AOwner) : Rzbutton::TRzToolButton(AOwner) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _SRzFirstRecord;
#define Rzdbnav_SRzFirstRecord System::LoadResourceString(&Rzdbnav::_SRzFirstRecord)
extern PACKAGE System::ResourceString _SRzPriorRecord;
#define Rzdbnav_SRzPriorRecord System::LoadResourceString(&Rzdbnav::_SRzPriorRecord)
extern PACKAGE System::ResourceString _SRzNextRecord;
#define Rzdbnav_SRzNextRecord System::LoadResourceString(&Rzdbnav::_SRzNextRecord)
extern PACKAGE System::ResourceString _SRzLastRecord;
#define Rzdbnav_SRzLastRecord System::LoadResourceString(&Rzdbnav::_SRzLastRecord)
extern PACKAGE System::ResourceString _SRzInsertRecord;
#define Rzdbnav_SRzInsertRecord System::LoadResourceString(&Rzdbnav::_SRzInsertRecord)
extern PACKAGE System::ResourceString _SRzDeleteRecord;
#define Rzdbnav_SRzDeleteRecord System::LoadResourceString(&Rzdbnav::_SRzDeleteRecord)
extern PACKAGE System::ResourceString _SRzEditRecord;
#define Rzdbnav_SRzEditRecord System::LoadResourceString(&Rzdbnav::_SRzEditRecord)
extern PACKAGE System::ResourceString _SRzPostEdit;
#define Rzdbnav_SRzPostEdit System::LoadResourceString(&Rzdbnav::_SRzPostEdit)
extern PACKAGE System::ResourceString _SRzCancelEdit;
#define Rzdbnav_SRzCancelEdit System::LoadResourceString(&Rzdbnav::_SRzCancelEdit)
extern PACKAGE System::ResourceString _SRzRefreshRecord;
#define Rzdbnav_SRzRefreshRecord System::LoadResourceString(&Rzdbnav::_SRzRefreshRecord)
extern PACKAGE System::ResourceString _SRzDeleteRecordQuestion;
#define Rzdbnav_SRzDeleteRecordQuestion System::LoadResourceString(&Rzdbnav::_SRzDeleteRecordQuestion)

}	/* namespace Rzdbnav */
using namespace Rzdbnav;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzdbnav
