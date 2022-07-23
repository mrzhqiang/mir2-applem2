// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzbtnedt.pas' rev: 10.00

#ifndef RzbtnedtHPP
#define RzbtnedtHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzbtnedt
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TButtonKind { bkCustom, bkLookup, bkDropDown, bkCalendar, bkAccept, bkReject, bkFolder, bkFind, bkSearch };
#pragma option pop

class DELPHICLASS TRzButtonPair;
class PASCALIMPLEMENTATION TRzButtonPair : public Controls::TWinControl 
{
	typedef Controls::TWinControl inherited;
	
private:
	Rzbutton::TRzControlButton* FAltBtn;
	Rzbutton::TRzControlButton* FButton;
	Controls::TWinControl* FFocusControl;
	bool FFlat;
	Classes::TNotifyEvent FOnAltBtnClick;
	Classes::TNotifyEvent FOnButtonClick;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Rzbutton::TRzControlButton* __fastcall CreateButton(void);
	virtual void __fastcall BtnClickHandler(System::TObject* Sender);
	virtual void __fastcall BtnMouseDownHandler(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall RepositionButtons(void);
	DYNAMIC void __fastcall AltBtnClick(void);
	DYNAMIC void __fastcall ButtonClick(void);
	virtual bool __fastcall GetAllEnabled(void);
	virtual void __fastcall SetAllEnabled(bool Value);
	virtual Graphics::TColor __fastcall GetColor(void);
	HIDESBASE virtual void __fastcall SetColor(Graphics::TColor Value);
	virtual void __fastcall SetFlat(bool Value);
	
public:
	__fastcall virtual TRzButtonPair(Classes::TComponent* AOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property Rzbutton::TRzControlButton* AltBtn = {read=FAltBtn};
	__property Rzbutton::TRzControlButton* Button = {read=FButton};
	
__published:
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, default=-16777201};
	__property bool Enabled = {read=GetAllEnabled, write=SetAllEnabled, default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
	__property Classes::TNotifyEvent OnAltBtnClick = {read=FOnAltBtnClick, write=FOnAltBtnClick};
	__property Classes::TNotifyEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property ParentColor  = {default=1};
	__property ParentCtl3D  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Visible  = {default=1};
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzButtonPair(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TRzButtonPair(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzCustomButtonEdit;
class PASCALIMPLEMENTATION TRzCustomButtonEdit : public Rzedit::TRzEdit 
{
	typedef Rzedit::TRzEdit inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FAllowKeyEdit;
	TRzButtonPair* FButtons;
	Graphics::TColor FFlatButtonColor;
	TButtonKind FAltBtnKind;
	TButtonKind FButtonKind;
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
	virtual Types::TRect __fastcall GetEditRect();
	virtual void __fastcall SetEditRect(void);
	virtual void __fastcall AltBtnClickHandler(System::TObject* Sender);
	virtual void __fastcall ButtonClickHandler(System::TObject* Sender);
	DYNAMIC void __fastcall AltBtnClick(void);
	DYNAMIC void __fastcall ButtonClick(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall SetAlignment(Classes::TAlignment Value);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
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
	virtual TButtonKind __fastcall GetButtonKind(int Index);
	virtual void __fastcall SetButtonKind(int Index, TButtonKind Value);
	virtual Classes::TShortCut __fastcall GetButtonShortCut(int Index);
	virtual void __fastcall SetButtonShortCut(int Index, Classes::TShortCut Value);
	virtual bool __fastcall GetButtonVisible(int Index);
	virtual void __fastcall SetButtonVisible(int Index, bool Value);
	virtual int __fastcall GetButtonWidth(int Index);
	virtual void __fastcall SetButtonWidth(int Index, int Value);
	
public:
	__fastcall virtual TRzCustomButtonEdit(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__property TRzButtonPair* Buttons = {read=FButtons};
	__property Rzbutton::TRzControlButton* AltBtn = {read=GetButton, index=1};
	__property Rzbutton::TRzControlButton* Button = {read=GetButton, index=2};
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AllowKeyEdit = {read=FAllowKeyEdit, write=FAllowKeyEdit, default=1};
	__property Graphics::TBitmap* AltBtnGlyph = {read=GetAltBtnGlyph, write=SetAltBtnGlyph, stored=IsCustomAltBtnGlyph};
	__property Graphics::TBitmap* ButtonGlyph = {read=GetButtonGlyph, write=SetButtonGlyph, stored=IsCustomButtonGlyph};
	__property Buttons::TNumGlyphs AltBtnNumGlyphs = {read=GetButtonNumGlyphs, write=SetButtonNumGlyphs, index=1, default=2};
	__property Buttons::TNumGlyphs ButtonNumGlyphs = {read=GetButtonNumGlyphs, write=SetButtonNumGlyphs, index=2, default=2};
	__property AnsiString AltBtnHint = {read=GetButtonHint, write=SetButtonHint, index=1};
	__property AnsiString ButtonHint = {read=GetButtonHint, write=SetButtonHint, index=2};
	__property TButtonKind AltBtnKind = {read=GetButtonKind, write=SetButtonKind, index=1, default=1};
	__property TButtonKind ButtonKind = {read=GetButtonKind, write=SetButtonKind, index=2, default=1};
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
	__property Alignment  = {default=0};
	__property Enabled  = {default=1};
public:
	#pragma option push -w-inl
	/* TRzCustomEdit.Destroy */ inline __fastcall virtual ~TRzCustomButtonEdit(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomButtonEdit(HWND ParentWindow) : Rzedit::TRzEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzButtonEdit;
class PASCALIMPLEMENTATION TRzButtonEdit : public TRzCustomButtonEdit 
{
	typedef TRzCustomButtonEdit inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Alignment  = {default=0};
	__property AllowKeyEdit  = {default=1};
	__property AltBtnGlyph ;
	__property ButtonGlyph ;
	__property AltBtnNumGlyphs  = {index=1, default=2};
	__property ButtonNumGlyphs  = {index=2, default=2};
	__property AltBtnHint ;
	__property ButtonHint ;
	__property AltBtnKind  = {index=1, default=1};
	__property ButtonKind  = {index=2, default=1};
	__property AltBtnShortCut  = {index=1, default=0};
	__property ButtonShortCut  = {index=2, default=115};
	__property AltBtnVisible  = {index=1, default=0};
	__property ButtonVisible  = {index=2, default=1};
	__property AltBtnWidth  = {index=1, default=17};
	__property ButtonWidth  = {index=2, default=17};
	__property BeepOnInvalidKey  = {default=1};
	__property Enabled  = {default=1};
	__property FlatButtons  = {default=0};
	__property FlatButtonColor  = {default=-16777201};
	__property HideButtonsOnReadOnly  = {default=1};
	__property OnAltBtnClick ;
	__property OnButtonClick ;
public:
	#pragma option push -w-inl
	/* TRzCustomButtonEdit.Create */ inline __fastcall virtual TRzButtonEdit(Classes::TComponent* AOwner) : TRzCustomButtonEdit(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TRzCustomEdit.Destroy */ inline __fastcall virtual ~TRzButtonEdit(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzButtonEdit(HWND ParentWindow) : TRzCustomButtonEdit(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word um_PopupListKeyDown = 0xbd00;
static const Word um_PopupListKeyUP = 0xbd01;
extern PACKAGE Graphics::TBitmap* __fastcall GetBtnEdtGlyph(TButtonKind Kind);

}	/* namespace Rzbtnedt */
using namespace Rzbtnedt;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzbtnedt
