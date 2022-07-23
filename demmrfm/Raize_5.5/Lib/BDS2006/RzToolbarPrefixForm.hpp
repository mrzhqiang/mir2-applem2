// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rztoolbarprefixform.pas' rev: 10.00

#ifndef RztoolbarprefixformHPP
#define RztoolbarprefixformHPP

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
#include <Rzbutton.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rztoolbarprefixform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzFrmPrefixSuffix;
class PASCALIMPLEMENTATION TRzFrmPrefixSuffix : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzlabel::TRzLabel* LblPrefix;
	Rzradchk::TRzRadioButton* OptPrefix;
	Rzradchk::TRzRadioButton* OptSuffix;
	Rzedit::TRzEdit* EdtPrefix;
	Rzbutton::TRzButton* BtnOK;
	Rzbutton::TRzButton* BtnCancel;
	void __fastcall OptPrefixClick(System::TObject* Sender);
	void __fastcall OptSuffixClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzFrmPrefixSuffix(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzFrmPrefixSuffix(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzFrmPrefixSuffix(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzFrmPrefixSuffix(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rztoolbarprefixform */
using namespace Rztoolbarprefixform;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rztoolbarprefixform
