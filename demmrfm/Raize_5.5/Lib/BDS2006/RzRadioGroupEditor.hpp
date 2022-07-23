// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzradiogroupeditor.pas' rev: 10.00

#ifndef RzradiogroupeditorHPP
#define RzradiogroupeditorHPP

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
#include <Rzradgrp.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rztrkbar.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzradiogroupeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzRadioGroupEditor;
class PASCALIMPLEMENTATION TRzRadioGroupEditor : public Rzdesigneditors::TRzDefaultEditor 
{
	typedef Rzdesigneditors::TRzDefaultEditor inherited;
	
protected:
	virtual Rzradgrp::TRzRadioGroup* __fastcall RadioGroup(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall ItemsMenuHandler(System::TObject* Sender);
	void __fastcall GroupStyleMenuHandler(System::TObject* Sender);
	void __fastcall VisualStyleMenuHandler(System::TObject* Sender);
	void __fastcall GradientColorStyleMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzRadioGroupEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzRadioGroupEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzRadioGroupEditDlg;
class PASCALIMPLEMENTATION TRzRadioGroupEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzpanel::TRzPanel* PnlButtons;
	Rzpanel::TRzPanel* PnlOptions;
	Rzedit::TRzEdit* EdtCaption;
	Rzlabel::TRzLabel* Label1;
	Rzedit::TRzMemo* EdtItems;
	Rzlabel::TRzLabel* Label2;
	Rzbutton::TRzButton* BtnLoad;
	Rzlabel::TRzLabel* Label3;
	Rzbutton::TRzButton* BtnClear;
	Dialogs::TOpenDialog* DlgOpen;
	Rztrkbar::TRzTrackBar* TrkColumns;
	Rzpanel::TRzPanel* PnlPreview;
	Rzradgrp::TRzRadioGroup* GrpPreview;
	Rzpanel::TRzPanel* RzPanel1;
	Rzbutton::TRzButton* BtnOk;
	Rzbutton::TRzButton* BtnCancel;
	void __fastcall EdtCaptionChange(System::TObject* Sender);
	void __fastcall TrkColumnsChange(System::TObject* Sender);
	void __fastcall EdtItemsChange(System::TObject* Sender);
	void __fastcall BtnLoadClick(System::TObject* Sender);
	void __fastcall BtnClearClick(System::TObject* Sender);
	void __fastcall TrkColumnsDrawTick(Rztrkbar::TRzTrackBar* TrackBar, Graphics::TCanvas* Canvas, const Types::TPoint &Location, int Index);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	bool FUpdating;
	
public:
	void __fastcall UpdateControls(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzRadioGroupEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzRadioGroupEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzRadioGroupEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzRadioGroupEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzradiogroupeditor */
using namespace Rzradiogroupeditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzradiogroupeditor
