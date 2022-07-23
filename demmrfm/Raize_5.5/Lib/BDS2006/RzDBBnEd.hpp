// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzdbbned.pas' rev: 10.00

#ifndef RzdbbnedHPP
#define RzdbbnedHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Rzbtnedt.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzdbedit.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzdbbned
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzDBButtonEdit;
class PASCALIMPLEMENTATION TRzDBButtonEdit : public Rzdbedit::TRzDBEdit 
{
	typedef Rzdbedit::TRzDBEdit inherited;
	
private:
	bool FInternalUpdate;
	bool FAllowKeyEdit;
	Rzbtnedt::TRzButtonPair* FButtons;
	Graphics::TColor FFlatButtonColor;
	Rzbtnedt::TButtonKind FAltBtnKind;
	Rzbtnedt::TButtonKind FButtonKind;
	Classes::TShortCut FAltBtnShortCut;
	Classes::TShortCut FButtonShortCut;
	bool FShortCutPressed;
	bool FHideButtonsOnReadOnly;
	Classes::TNotifyEvent FOnAltBtnClick;
	Classes::TNotifyEvent FOnButtonClick;
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
	bool __fastcall IsCustomAltBtnGlyph(void);
	bool __fastcall IsCustomButtonGlyph(void);
	virtual void __fastcall ReadButtonShortCutText(Classes::TReader* Reader);
	virtual void __fastcall ReadAltBtnShortCutText(Classes::TReader* Reader);
	virtual void __fastcall WriteShortCutText(Classes::TWriter* Writer);
	virtual void __fastcall ReadOnlyChanged(void);
	virtual void __fastcall ResizeButtons(void);
	virtual void __fastcall AdjustEditRect(void);
	virtual Types::TRect __fastcall GetEditRect();
	virtual void __fastcall SetEditRect(void);
	virtual void __fastcall AltBtnClickHandler(System::TObject* Sender);
	virtual void __fastcall ButtonClickHandler(System::TObject* Sender);
	DYNAMIC void __fastcall AltBtnClick(void);
	DYNAMIC void __fastcall ButtonClick(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameVisible(bool Value);
	virtual void __fastcall SetFlatButtons(bool Value);
	virtual void __fastcall SetHideButtonsOnReadOnly(bool Value);
	virtual Rzbutton::TRzControlButton* __fastcall GetButton(int Index);
	virtual Graphics::TBitmap* __fastcall GetAltBtnGlyph(void);
	virtual void __fastcall SetAltBtnGlyph(Graphics::TBitmap* Value);
	virtual Graphics::TBitmap* __fastcall GetButtonGlyph(void);
	virtual void __fastcall SetButtonGlyph(Graphics::TBitmap* Value);
	virtual Buttons::TNumGlyphs __fastcall GetButtonNumGlyphs(int Index);
	virtual void __fastcall SetButtonNumGlyphs(int Index, Buttons::TNumGlyphs Value);
	virtual AnsiString __fastcall GetButtonHint(int Index);
	virtual void __fastcall SetButtonHint(int Index, const AnsiString Value);
	virtual Rzbtnedt::TButtonKind __fastcall GetButtonKind(int Index);
	virtual void __fastcall SetButtonKind(int Index, Rzbtnedt::TButtonKind Value);
	virtual Classes::TShortCut __fastcall GetButtonShortCut(int Index);
	virtual void __fastcall SetButtonShortCut(int Index, Classes::TShortCut Value);
	virtual bool __fastcall GetButtonVisible(int Index);
	virtual void __fastcall SetButtonVisible(int Index, bool Value);
	virtual int __fastcall GetButtonWidth(int Index);
	virtual void __fastcall SetButtonWidth(int Index, int Value);
	
public:
	__fastcall virtual TRzDBButtonEdit(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__property Rzbtnedt::TRzButtonPair* Buttons = {read=FButtons};
	__property Rzbutton::TRzControlButton* AltBtn = {read=GetButton, index=1};
	__property Rzbutton::TRzControlButton* Button = {read=GetButton, index=2};
	
__published:
	__property bool AllowKeyEdit = {read=FAllowKeyEdit, write=FAllowKeyEdit, default=1};
	__property Graphics::TBitmap* AltBtnGlyph = {read=GetAltBtnGlyph, write=SetAltBtnGlyph, stored=IsCustomAltBtnGlyph};
	__property Graphics::TBitmap* ButtonGlyph = {read=GetButtonGlyph, write=SetButtonGlyph, stored=IsCustomButtonGlyph};
	__property Buttons::TNumGlyphs AltBtnNumGlyphs = {read=GetButtonNumGlyphs, write=SetButtonNumGlyphs, index=1, default=2};
	__property Buttons::TNumGlyphs ButtonNumGlyphs = {read=GetButtonNumGlyphs, write=SetButtonNumGlyphs, index=2, default=2};
	__property AnsiString AltBtnHint = {read=GetButtonHint, write=SetButtonHint, index=1};
	__property AnsiString ButtonHint = {read=GetButtonHint, write=SetButtonHint, index=2};
	__property Rzbtnedt::TButtonKind AltBtnKind = {read=GetButtonKind, write=SetButtonKind, index=1, default=1};
	__property Rzbtnedt::TButtonKind ButtonKind = {read=GetButtonKind, write=SetButtonKind, index=2, default=1};
	__property Classes::TShortCut AltBtnShortCut = {read=GetButtonShortCut, write=SetButtonShortCut, index=1, default=0};
	__property Classes::TShortCut ButtonShortCut = {read=GetButtonShortCut, write=SetButtonShortCut, index=2, default=115};
	__property bool AltBtnVisible = {read=GetButtonVisible, write=SetButtonVisible, index=1, default=0};
	__property bool ButtonVisible = {read=GetButtonVisible, write=SetButtonVisible, index=2, default=1};
	__property int AltBtnWidth = {read=GetButtonWidth, write=SetButtonWidth, index=1, default=17};
	__property int ButtonWidth = {read=GetButtonWidth, write=SetButtonWidth, index=2, default=17};
	__property Graphics::TColor FlatButtonColor = {read=FFlatButtonColor, write=FFlatButtonColor, default=-16777201};
	__property bool HideButtonsOnReadOnly = {read=FHideButtonsOnReadOnly, write=SetHideButtonsOnReadOnly, default=1};
	__property Classes::TNotifyEvent OnAltBtnClick = {read=FOnAltBtnClick, write=FOnAltBtnClick};
	__property Classes::TNotifyEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property Enabled  = {default=1};
	__property FlatButtons  = {default=0};
public:
	#pragma option push -w-inl
	/* TRzDBEdit.Destroy */ inline __fastcall virtual ~TRzDBButtonEdit(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBButtonEdit(HWND ParentWindow) : Rzdbedit::TRzDBEdit(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzdbbned */
using namespace Rzdbbned;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzdbbned
