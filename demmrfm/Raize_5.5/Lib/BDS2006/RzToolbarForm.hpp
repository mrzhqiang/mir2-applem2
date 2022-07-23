// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rztoolbarform.pas' rev: 10.00

#ifndef RztoolbarformHPP
#define RztoolbarformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Rzspnedt.hpp>	// Pascal unit
#include <Rzborder.hpp>	// Pascal unit
#include <Rzradgrp.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzlstbox.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit
#include <Rzcmbobx.hpp>	// Pascal unit
#include <Rzchklst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rztoolbarform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzFrmCustomizeToolbar;
class PASCALIMPLEMENTATION TRzFrmCustomizeToolbar : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzbutton::TRzButton* BtnClose;
	Rzchklst::TRzCheckList* LstControls;
	Extctrls::TTimer* Timer1;
	Buttons::TSpeedButton* BtnSpacer;
	Buttons::TSpeedButton* BtnGrooveSpacer;
	Rzlabel::TRzLabel* LblHint;
	Rzlabel::TRzLabel* LblTextOptions;
	Rzcmbobx::TRzComboBox* CbxTextOptions;
	Rzbutton::TRzButton* BtnMoveUp;
	Rzbutton::TRzButton* BtnMoveDown;
	void __fastcall BtnMoveDownClick(System::TObject* Sender);
	void __fastcall BtnMoveUpClick(System::TObject* Sender);
	void __fastcall LstControlsClick(System::TObject* Sender);
	void __fastcall LstControlsDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall LstControlsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall ListBoxDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall LstControlsEndDrag(System::TObject* Sender, System::TObject* Target, int X, int Y);
	void __fastcall LstControlsMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall CbxTextOptionsClick(System::TObject* Sender);
	void __fastcall LstControlsChange(System::TObject* Sender, int Index, Stdctrls::TCheckBoxState NewState);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	int OldIdx;
	int NewIdx;
	bool GoingUp;
	void __fastcall EnableMoveButtons(int Idx);
	
public:
	Rzbutton::TRzToolbarButton* SelectedBtn;
	Classes::TComponent* CompOwner;
	Rzpanel::TRzToolbar* Toolbar;
	void __fastcall UpdateControls(Rzpanel::TRzCustomizeCaptions* CustomizeCaptions, bool ShowTextOptions);
	void __fastcall Reposition(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzFrmCustomizeToolbar(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzFrmCustomizeToolbar(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzFrmCustomizeToolbar(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzFrmCustomizeToolbar(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rztoolbarform */
using namespace Rztoolbarform;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rztoolbarform
