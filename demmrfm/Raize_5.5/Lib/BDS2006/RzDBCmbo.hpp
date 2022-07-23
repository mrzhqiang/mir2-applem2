// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzdbcmbo.pas' rev: 10.00

#ifndef RzdbcmboHPP
#define RzdbcmboHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzcmbobx.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Vdbconsts.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzdbcmbo
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzPaintComboBox;
class DELPHICLASS TRzDBComboBox;
class PASCALIMPLEMENTATION TRzDBComboBox : public Rzcmbobx::TRzCustomComboBox 
{
	typedef Rzcmbobx::TRzCustomComboBox inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Dbctrls::TFieldDataLink* FDataLink;
	TRzPaintComboBox* FPaintControl;
	AnsiString FValue;
	Classes::TStrings* FValues;
	bool FInSetValue;
	bool FInDataChange;
	bool FForceSetValue;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	void __fastcall ValuesChangedHandler(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall ComboWndProc(Messages::TMessage &Msg, unsigned int ComboWnd, void * ComboProc);
	#pragma option push -w-inl
	inline void __fastcall ComboWndProc(Messages::TMessage &Msg, HWND ComboWnd, void * ComboProc) {TRzDBComboBox::ComboWndProc( Msg, (unsigned int)ComboWnd, ComboProc);}
	#pragma option pop
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual AnsiString __fastcall GetComboText();
	virtual void __fastcall SetComboText(const AnsiString Value);
	virtual AnsiString __fastcall GetDataField();
	virtual void __fastcall SetDataField(const AnsiString Value);
	virtual Db::TDataSource* __fastcall GetDataSource(void);
	virtual void __fastcall SetDataSource(Db::TDataSource* Value);
	virtual void __fastcall SetEditReadOnly(void);
	virtual Db::TField* __fastcall GetField(void);
	virtual void __fastcall SetItems(const Classes::TStrings* Value);
	virtual bool __fastcall GetReadOnly(void);
	virtual void __fastcall SetReadOnly(bool Value);
	virtual void __fastcall SetStyle(Stdctrls::TComboBoxStyle Value);
	virtual AnsiString __fastcall GetItemValue(int Index);
	virtual AnsiString __fastcall GetValue();
	virtual void __fastcall SetValue(const AnsiString Value);
	virtual void __fastcall SetValues(Classes::TStrings* Value);
	
public:
	__fastcall virtual TRzDBComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDBComboBox(void);
	void __fastcall ClearItemsValues(void);
	void __fastcall AddItemValue(const AnsiString Item, const AnsiString Value);
	void __fastcall InsertItemValue(int Index, const AnsiString Item, const AnsiString Value);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Db::TField* Field = {read=GetField};
	__property AnsiString Value = {read=GetValue, write=SetValue};
	__property Text ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Style  = {default=0};
	__property Align  = {default=0};
	__property AllowEdit  = {default=1};
	__property Anchors  = {default=3};
	__property AutoComplete  = {default=1};
	__property AutoDropDown  = {default=0};
	__property BeepOnInvalidKey  = {default=1};
	__property BiDiMode ;
	__property CharCase  = {default=0};
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property Ctl3D ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property DropDownCount  = {default=8};
	__property DropDownWidth  = {default=0};
	__property Enabled  = {default=1};
	__property FlatButtonColor  = {default=-16777201};
	__property FlatButtons  = {default=0};
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
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property ItemHeight ;
	__property KeepSearchCase  = {default=0};
	__property MaxLength  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnlyColor  = {default=-16777192};
	__property ReadOnlyColorOnFocus  = {default=0};
	__property ShowHint ;
	__property Sorted  = {default=0};
	__property TabOnEnter  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property TextHint ;
	__property Visible  = {default=1};
	__property OnChange ;
	__property OnClick ;
	__property OnCloseUp ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawItem ;
	__property OnDropDown ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMatch ;
	__property OnMeasureItem ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseWheel ;
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnNotInList ;
	__property OnSelect ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property Items  = {write=SetItems};
	__property Classes::TStrings* Values = {read=FValues, write=SetValues};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBComboBox(HWND ParentWindow) : Rzcmbobx::TRzCustomComboBox(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzPaintComboBox : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	TRzDBComboBox* FComboBox;
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TRzPaintComboBox(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TRzPaintComboBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzPaintComboBox(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBLookupComboBox;
class PASCALIMPLEMENTATION TRzDBLookupComboBox : public Dbctrls::TDBLookupComboBox 
{
	typedef Dbctrls::TDBLookupComboBox inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FAllowNull;
	bool FAutoDropDown;
	Classes::TAlignment FTextAlignment;
	int FButtonWidth;
	Graphics::TCanvas* FCanvas;
	Graphics::TColor FFlatButtonColor;
	bool FFlatButtons;
	bool FUpdatingColor;
	Graphics::TColor FDisabledColor;
	Graphics::TColor FReadOnlyColor;
	bool FReadOnlyColorOnFocus;
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
	bool FTabOnEnter;
	bool FSelectOnTab;
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameFocusStyleProp(Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Msg);
	
protected:
	bool FInControl;
	bool FOverControl;
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall KeyValueChanged(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Types::TRect __fastcall GetClientRect();
	virtual int __fastcall GetBorderSize(void);
	virtual void __fastcall UpdateColors(void);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall SetFlatButtonColor(Graphics::TColor Value);
	virtual void __fastcall SetFlatButtons(bool Value);
	bool __fastcall StoreColor(void);
	bool __fastcall StoreFocusColor(void);
	bool __fastcall StoreDisabledColor(void);
	bool __fastcall StoreReadOnlyColor(void);
	bool __fastcall StoreReadOnlyColorOnFocus(void);
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
	HIDESBASE bool __fastcall GetReadOnly(void);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	virtual void __fastcall SetReadOnlyColor(Graphics::TColor Value);
	
public:
	__fastcall virtual TRzDBLookupComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDBLookupComboBox(void);
	virtual bool __fastcall UseThemes(void);
	AnsiString __fastcall GetListValue();
	AnsiString __fastcall GetKeyValue();
	void __fastcall InitKeyValue(void);
	void __fastcall ClearKeyValue(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AllowNull = {read=FAllowNull, write=FAllowNull, default=0};
	__property bool AutoDropDown = {read=FAutoDropDown, write=FAutoDropDown, default=0};
	__property Color  = {stored=StoreColor, default=-16777211};
	__property Graphics::TColor FlatButtonColor = {read=FFlatButtonColor, write=SetFlatButtonColor, stored=StoreFlatButtonColor, default=-16777201};
	__property bool FlatButtons = {read=FFlatButtons, write=SetFlatButtons, stored=StoreFlatButtons, default=0};
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
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Graphics::TColor ReadOnlyColor = {read=FReadOnlyColor, write=SetReadOnlyColor, stored=StoreReadOnlyColor, default=-16777192};
	__property bool ReadOnlyColorOnFocus = {read=FReadOnlyColorOnFocus, write=FReadOnlyColorOnFocus, stored=StoreReadOnlyColorOnFocus, default=0};
	__property bool SelectOnTab = {read=FSelectOnTab, write=FSelectOnTab, default=0};
	__property bool TabOnEnter = {read=FTabOnEnter, write=FTabOnEnter, default=0};
	__property Align  = {default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBLookupComboBox(HWND ParentWindow) : Dbctrls::TDBLookupComboBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzdbcmbo */
using namespace Rzdbcmbo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzdbcmbo
