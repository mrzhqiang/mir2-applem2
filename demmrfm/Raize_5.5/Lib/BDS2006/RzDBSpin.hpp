// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzdbspin.pas' rev: 10.00

#ifndef RzdbspinHPP
#define RzdbspinHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzdbedit.hpp>	// Pascal unit
#include <Rzspnedt.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzdbspin
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzDBSpinEdit;
class PASCALIMPLEMENTATION TRzDBSpinEdit : public Rzdbedit::TRzDBEdit 
{
	typedef Rzdbedit::TRzDBEdit inherited;
	
private:
	bool FAllowKeyEdit;
	bool FAllowBlank;
	Extended FBlankValue;
	Rzspnedt::TRzSpinButtons* FButtons;
	int FButtonWidth;
	bool FCheckRange;
	Byte FDecimals;
	Extended FIncrement;
	bool FIntegersOnly;
	Extended FMin;
	Extended FMax;
	Extended FPageSize;
	Graphics::TColor FFlatButtonColor;
	bool FInternalUpdate;
	Rzspnedt::TSpinChangingEvent FOnChanging;
	Rzspnedt::TSpinButtonEvent FOnButtonClick;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	bool __fastcall CanEditData(void);
	bool __fastcall IsCustomDownGlyph(void);
	bool __fastcall IsCustomUpGlyph(void);
	virtual void __fastcall ReadOnlyChanged(void);
	virtual void __fastcall ResizeButtons(void);
	virtual void __fastcall AdjustEditRect(void);
	virtual Types::TRect __fastcall GetEditRect();
	virtual void __fastcall SetEditRect(void);
	AnsiString __fastcall CleanUpText();
	virtual bool __fastcall IsValidChar(char Key);
	virtual void __fastcall UpRightClickHandler(System::TObject* Sender);
	virtual void __fastcall DownLeftClickHandler(System::TObject* Sender);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC bool __fastcall CanChange(Extended NewValue);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall DoButtonClick(Rzspnedt::TSpinButtonType S);
	virtual void __fastcall IncValue(const Extended Amount);
	virtual void __fastcall DecValue(const Extended Amount);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetButtonWidth(int Value);
	virtual void __fastcall SetDecimals(Byte Value);
	virtual void __fastcall SetIntegersOnly(bool Value);
	virtual Rzbutton::TRzControlButton* __fastcall GetButton(int Index);
	virtual Graphics::TBitmap* __fastcall GetButtonUpGlyph(void);
	virtual void __fastcall SetButtonUpGlyph(Graphics::TBitmap* Value);
	virtual Buttons::TNumGlyphs __fastcall GetButtonUpNumGlyphs(void);
	virtual void __fastcall SetButtonUpNumGlyphs(Buttons::TNumGlyphs Value);
	virtual Graphics::TBitmap* __fastcall GetButtonDownGlyph(void);
	virtual void __fastcall SetButtonDownGlyph(Graphics::TBitmap* Value);
	virtual Buttons::TNumGlyphs __fastcall GetButtonDownNumGlyphs(void);
	virtual void __fastcall SetButtonDownNumGlyphs(Buttons::TNumGlyphs Value);
	virtual Rzspnedt::TSpinDirection __fastcall GetDirection(void);
	virtual void __fastcall SetDirection(Rzspnedt::TSpinDirection Value);
	virtual void __fastcall SetFlatButtons(bool Value);
	virtual Rzcommon::TOrientation __fastcall GetOrientation(void);
	virtual void __fastcall SetOrientation(Rzcommon::TOrientation Value);
	virtual void __fastcall SetCheckRange(bool Value);
	virtual void __fastcall SetMin(const Extended Value);
	virtual void __fastcall SetMax(const Extended Value);
	virtual __int64 __fastcall GetIntValue(void);
	virtual void __fastcall SetIntValue(__int64 Value);
	virtual Extended __fastcall GetValue(void);
	virtual Extended __fastcall CheckValue(const Extended Value);
	virtual void __fastcall SetValue(const Extended Value);
	bool __fastcall StoreIncrement(void);
	bool __fastcall StorePageSize(void);
	
public:
	__fastcall virtual TRzDBSpinEdit(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__property Rzspnedt::TRzSpinButtons* Buttons = {read=FButtons};
	__property Rzbutton::TRzControlButton* DownLeftButton = {read=GetButton, index=1};
	__property Rzbutton::TRzControlButton* UpRightButton = {read=GetButton, index=2};
	__property __int64 IntValue = {read=GetIntValue, write=SetIntValue};
	
__published:
	__property bool AllowBlank = {read=FAllowBlank, write=FAllowBlank, default=1};
	__property Extended BlankValue = {read=FBlankValue, write=FBlankValue};
	__property bool AllowKeyEdit = {read=FAllowKeyEdit, write=FAllowKeyEdit, default=0};
	__property Graphics::TBitmap* ButtonDownGlyph = {read=GetButtonDownGlyph, write=SetButtonDownGlyph, stored=IsCustomDownGlyph};
	__property Buttons::TNumGlyphs ButtonDownNumGlyphs = {read=GetButtonDownNumGlyphs, write=SetButtonDownNumGlyphs, stored=IsCustomDownGlyph, nodefault};
	__property Graphics::TBitmap* ButtonUpGlyph = {read=GetButtonUpGlyph, write=SetButtonUpGlyph, stored=IsCustomUpGlyph};
	__property Buttons::TNumGlyphs ButtonUpNumGlyphs = {read=GetButtonUpNumGlyphs, write=SetButtonUpNumGlyphs, stored=IsCustomUpGlyph, nodefault};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, default=17};
	__property bool CheckRange = {read=FCheckRange, write=SetCheckRange, default=0};
	__property Byte Decimals = {read=FDecimals, write=SetDecimals, default=0};
	__property Rzspnedt::TSpinDirection Direction = {read=GetDirection, write=SetDirection, default=0};
	__property Graphics::TColor FlatButtonColor = {read=FFlatButtonColor, write=FFlatButtonColor, default=-16777201};
	__property Extended Increment = {read=FIncrement, write=FIncrement, stored=StoreIncrement};
	__property bool IntegersOnly = {read=FIntegersOnly, write=SetIntegersOnly, default=1};
	__property Extended Max = {read=FMax, write=SetMax, stored=true};
	__property Extended Min = {read=FMin, write=SetMin, stored=true};
	__property Rzcommon::TOrientation Orientation = {read=GetOrientation, write=SetOrientation, default=1};
	__property Extended PageSize = {read=FPageSize, write=FPageSize, stored=StorePageSize};
	__property Extended Value = {read=GetValue, write=SetValue};
	__property Rzspnedt::TSpinChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property Rzspnedt::TSpinButtonEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property Enabled  = {default=1};
	__property FlatButtons  = {default=0};
	__property ReadOnlyColor  = {default=-16777192};
	__property ReadOnlyColorOnFocus  = {default=0};
	__property OnMouseWheel ;
	__property OnMouseWheelUp ;
	__property OnMouseWheelDown ;
public:
	#pragma option push -w-inl
	/* TRzDBEdit.Destroy */ inline __fastcall virtual ~TRzDBSpinEdit(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBSpinEdit(HWND ParentWindow) : Rzdbedit::TRzDBEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBSpinner;
class PASCALIMPLEMENTATION TRzDBSpinner : public Rzspnedt::TRzSpinner 
{
	typedef Rzspnedt::TRzSpinner inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	Rzspnedt::TRzSpinner* FPaintControl;
	bool FBeepOnInvalidKey;
	void __fastcall DataChangeHandler(System::TObject* Sender);
	void __fastcall UpdateDataHandler(System::TObject* Sender);
	void __fastcall ActiveChangeHandler(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall CheckFieldType(const AnsiString Value);
	virtual void __fastcall DecValue(int Amount);
	virtual void __fastcall IncValue(int Amount);
	virtual void __fastcall DataChange(void);
	virtual void __fastcall UpdateData(void);
	virtual void __fastcall ActiveChange(void);
	void __fastcall InvalidKeyPressed(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual Db::TField* __fastcall GetField(void);
	virtual AnsiString __fastcall GetDataField();
	virtual void __fastcall SetDataField(const AnsiString Value);
	virtual Db::TDataSource* __fastcall GetDataSource(void);
	virtual void __fastcall SetDataSource(Db::TDataSource* Value);
	virtual bool __fastcall GetReadOnly(void);
	virtual void __fastcall SetReadOnly(bool Value);
	__property Db::TField* Field = {read=GetField};
	__property Dbctrls::TFieldDataLink* DataLink = {read=FDataLink};
	
public:
	__fastcall virtual TRzDBSpinner(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDBSpinner(void);
	
__published:
	__property bool BeepOnInvalidKey = {read=FBeepOnInvalidKey, write=FBeepOnInvalidKey, default=1};
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBSpinner(HWND ParentWindow) : Rzspnedt::TRzSpinner(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _sRzInvalidFieldType;
#define Rzdbspin_sRzInvalidFieldType System::LoadResourceString(&Rzdbspin::_sRzInvalidFieldType)

}	/* namespace Rzdbspin */
using namespace Rzdbspin;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzdbspin
