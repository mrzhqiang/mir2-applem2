// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzcolornameseditor.pas' rev: 10.00

#ifndef RzcolornameseditorHPP
#define RzcolornameseditorHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Rzcmbobx.hpp>	// Pascal unit
#include <Rzdesigneditors.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Designmenus.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzcolornameseditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzColorNamesProperty;
class PASCALIMPLEMENTATION TRzColorNamesProperty : public Designeditors::TClassProperty 
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
	virtual void __fastcall Edit(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzColorNamesProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzColorNamesProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzColorNamesEditor;
class PASCALIMPLEMENTATION TRzColorNamesEditor : public Rzdesigneditors::TRzDefaultEditor 
{
	typedef Rzdesigneditors::TRzDefaultEditor inherited;
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzColorNamesEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzColorNamesEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzColorNamesEditDlg;
class PASCALIMPLEMENTATION TRzColorNamesEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzbutton::TRzButton* BtnOK;
	Rzbutton::TRzButton* BtnCancel;
	Rzbutton::TRzButton* BtnLoad;
	Rzbutton::TRzButton* BtnSave;
	Dialogs::TOpenDialog* DlgOpen;
	Dialogs::TSaveDialog* DlgSave;
	Rzpanel::TRzPanel* RzPanel1;
	Grids::TStringGrid* GrdColors;
	void __fastcall GrdColorsDrawCell(System::TObject* Sender, int Col, int Row, const Types::TRect &Rect, Grids::TGridDrawState State);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall GrdColorsSelectCell(System::TObject* Sender, int Col, int Row, bool &CanSelect);
	void __fastcall BtnLoadClick(System::TObject* Sender);
	void __fastcall BtnSaveClick(System::TObject* Sender);
	void __fastcall GrdColorsSetEditText(System::TObject* Sender, int ACol, int ARow, const AnsiString Value);
	
private:
	Rzcmbobx::TRzColorNames* FColorNames;
	void __fastcall SetColorNames(Rzcmbobx::TRzColorNames* Value);
	
public:
	__property Rzcmbobx::TRzColorNames* ColorNames = {read=FColorNames, write=SetColorNames};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzColorNamesEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzColorNamesEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzColorNamesEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzColorNamesEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzcolornameseditor */
using namespace Rzcolornameseditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzcolornameseditor
