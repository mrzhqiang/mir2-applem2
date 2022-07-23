// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzbuttoneditor.pas' rev: 10.00

#ifndef RzbuttoneditorHPP
#define RzbuttoneditorHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Designmenus.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzspnedt.hpp>	// Pascal unit
#include <Rzdesigneditors.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Rzradgrp.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzbuttoneditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzButtonEditor;
class PASCALIMPLEMENTATION TRzButtonEditor : public Rzdesigneditors::TRzDefaultEditor 
{
	typedef Rzdesigneditors::TRzDefaultEditor inherited;
	
protected:
	Rzbutton::TRzButton* __fastcall Button(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzButtonEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzButtonEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzButtonEditDlg;
class PASCALIMPLEMENTATION TRzButtonEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzpanel::TRzGroupBox* GrpPreview;
	Rzbutton::TRzButton* BtnPreview;
	Rzbutton::TRzButton* BtnOK;
	Rzbutton::TRzButton* BtnCancel;
	Rzradgrp::TRzRadioGroup* GrpModalResult;
	Rzpanel::TRzGroupBox* GrpSize;
	Rzradchk::TRzRadioButton* OptStandardSize;
	Rzradchk::TRzRadioButton* OptLargeSize;
	Rzradchk::TRzRadioButton* OptCustomSize;
	Rzlabel::TRzLabel* LblWidth;
	Rzlabel::TRzLabel* LblHeight;
	Rzpanel::TRzGroupBox* GrpSpecial;
	Rzbutton::TRzButton* BtnOKTemplate;
	Rzbutton::TRzButton* BtnCancelTemplate;
	Rzbutton::TRzButton* BtnHelpTemplate;
	Rzpanel::TRzGroupBox* GrpKeyboard;
	Rzradchk::TRzCheckBox* ChkDefault;
	Rzradchk::TRzCheckBox* ChkCancel;
	Rzpanel::TRzGroupBox* GrpCaption;
	Rzedit::TRzEdit* EdtCaption;
	Rzlabel::TRzLabel* Label1;
	Rzlabel::TRzLabel* Label4;
	Rzlabel::TRzLabel* Label5;
	Rzbutton::TRzButton* BtnYesTemplate;
	Rzbutton::TRzButton* BtnNoTemplate;
	Rzradchk::TRzCheckBox* ChkEnabled;
	Rzspnedt::TRzSpinEdit* SpnWidth;
	Rzspnedt::TRzSpinEdit* SpnHeight;
	Rzspnedt::TRzSpinEdit* SpnModalResult;
	void __fastcall EdtCaptionChange(System::TObject* Sender);
	void __fastcall ChkDefaultClick(System::TObject* Sender);
	void __fastcall ChkCancelClick(System::TObject* Sender);
	void __fastcall ButtonSizeClick(System::TObject* Sender);
	void __fastcall ChkEnabledClick(System::TObject* Sender);
	void __fastcall GrpModalResultClick(System::TObject* Sender);
	void __fastcall BtnOKTemplateClick(System::TObject* Sender);
	void __fastcall BtnCancelTemplateClick(System::TObject* Sender);
	void __fastcall BtnHelpTemplateClick(System::TObject* Sender);
	void __fastcall BtnYesTemplateClick(System::TObject* Sender);
	void __fastcall BtnNoTemplateClick(System::TObject* Sender);
	void __fastcall SpnWidthChange(System::TObject* Sender);
	void __fastcall SpnHeightChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	void __fastcall EnableWidthHeight(bool Enable);
	void __fastcall UpdateWidthHeight(void);
	
public:
	void __fastcall UpdateControls(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzButtonEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzButtonEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzButtonEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzButtonEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzbuttoneditor */
using namespace Rzbuttoneditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzbuttoneditor
