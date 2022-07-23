// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzabouteditor.pas' rev: 10.00

#ifndef RzabouteditorHPP
#define RzabouteditorHPP

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
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rzborder.hpp>	// Pascal unit
#include <Rzstatus.hpp>	// Pascal unit
#include <Rzbckgnd.hpp>	// Pascal unit
#include <Rzbmpbtn.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzabouteditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzAboutBoxProperty;
class PASCALIMPLEMENTATION TRzAboutBoxProperty : public Designeditors::TPropertyEditor 
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzAboutBoxProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzAboutBoxProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzAboutEditDlg;
class PASCALIMPLEMENTATION TRzAboutEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzlabel::TRzLabel* lblTrial1;
	Rzlabel::TRzLabel* lblComponentName;
	Stdctrls::TLabel* lblCopyright;
	Rzlabel::TRzLabel* lblDescription;
	Rzlabel::TRzURLLabel* urlRaizeWebsite;
	Rzlabel::TRzLabel* lblVersion;
	Extctrls::TImage* imgCompBmp;
	Rzlabel::TRzLabel* lblInfo;
	Rzlabel::TRzURLLabel* urlEmail;
	Rzlabel::TRzLabel* lblNewsgroups;
	Rzlabel::TRzURLLabel* urlNewsgroup;
	Stdctrls::TLabel* lblPlasmatech;
	Extctrls::TImage* imgBackground;
	Rzlabel::TRzLabel* lblEmailSupport;
	Rzlabel::TRzLabel* lblTechSupport;
	Extctrls::TImage* imgClose;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall imgCloseClick(System::TObject* Sender);
	void __fastcall imgBackgroundMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
private:
	AnsiString __fastcall FindDescription(AnsiString CompName);
	
public:
	void __fastcall SetComponentName(AnsiString Value);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzAboutEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzAboutEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzAboutEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzAboutEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _sCopyrightDate;
#define Rzabouteditor_sCopyrightDate System::LoadResourceString(&Rzabouteditor::_sCopyrightDate)
extern PACKAGE System::ResourceString _sCompanyName;
#define Rzabouteditor_sCompanyName System::LoadResourceString(&Rzabouteditor::_sCompanyName)
extern PACKAGE System::ResourceString _sProductVersion;
#define Rzabouteditor_sProductVersion System::LoadResourceString(&Rzabouteditor::_sProductVersion)
extern PACKAGE System::ResourceString _sProductName;
#define Rzabouteditor_sProductName System::LoadResourceString(&Rzabouteditor::_sProductName)

}	/* namespace Rzabouteditor */
using namespace Rzabouteditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzabouteditor
