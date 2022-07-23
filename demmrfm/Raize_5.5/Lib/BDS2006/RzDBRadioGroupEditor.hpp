// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzdbradiogroupeditor.pas' rev: 10.00

#ifndef RzdbradiogroupeditorHPP
#define RzdbradiogroupeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Designmenus.hpp>	// Pascal unit
#include <Rzdesigneditors.hpp>	// Pascal unit
#include <Rzdbdesigneditors.hpp>	// Pascal unit
#include <Rzradgrp.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rztrkbar.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Rzdbrgrp.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzgrids.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzdbradiogroupeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzDBRadioGroupEditor;
class PASCALIMPLEMENTATION TRzDBRadioGroupEditor : public Rzdbdesigneditors::TRzDBControlEditor 
{
	typedef Rzdbdesigneditors::TRzDBControlEditor inherited;
	
protected:
	Rzdbrgrp::TRzDBRadioGroup* __fastcall RadioGroup(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall GroupStyleMenuHandler(System::TObject* Sender);
	void __fastcall VisualStyleMenuHandler(System::TObject* Sender);
	void __fastcall GradientColorStyleMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBRadioGroupEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdbdesigneditors::TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBRadioGroupEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBRadioGroupEditDlg;
class PASCALIMPLEMENTATION TRzDBRadioGroupEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzpanel::TRzPanel* pnlButtons;
	Rzpanel::TRzPanel* PnlOptions;
	Rzbutton::TRzButton* btnLoad;
	Rzbutton::TRzButton* btnClear;
	Dialogs::TOpenDialog* dlgOpen;
	Rzpanel::TRzPanel* pnlPreview;
	Rzdbrgrp::TRzDBRadioGroup* grpPreview;
	Rzpanel::TRzPanel* RzPanel1;
	Rzbutton::TRzButton* btnOk;
	Rzbutton::TRzButton* btnCancel;
	Rzgrids::TRzStringGrid* grdItemsValues;
	Rzlabel::TRzLabel* Label1;
	Rzedit::TRzEdit* edtCaption;
	Rzlabel::TRzLabel* Label2;
	Rztrkbar::TRzTrackBar* trkColumns;
	void __fastcall edtCaptionChange(System::TObject* Sender);
	void __fastcall trkColumnsChange(System::TObject* Sender);
	void __fastcall btnLoadClick(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall trkColumnsDrawTick(Rztrkbar::TRzTrackBar* TrackBar, Graphics::TCanvas* Canvas, const Types::TPoint &Location, int Index);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall grdItemsValuesResize(System::TObject* Sender);
	void __fastcall grdItemsValuesClick(System::TObject* Sender);
	void __fastcall btnOkClick(System::TObject* Sender);
	
private:
	bool FUpdating;
	void __fastcall ResetGrid(void);
	
public:
	void __fastcall UpdateControls(void);
	void __fastcall UpdateGroup(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzDBRadioGroupEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzDBRadioGroupEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzDBRadioGroupEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBRadioGroupEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzdbradiogroupeditor */
using namespace Rzdbradiogroupeditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzdbradiogroupeditor
