// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzchecklistitemform.pas' rev: 10.00

#ifndef RzchecklistitemformHPP
#define RzchecklistitemformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzchecklistitemform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzCheckItemEditDlg;
class PASCALIMPLEMENTATION TRzCheckItemEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzlabel::TRzLabel* Label1;
	Rzbutton::TRzButton* btnOK;
	Rzbutton::TRzButton* btnCancel;
	Rzedit::TRzMemo* edtItem;
	Rzradchk::TRzRadioButton* optItem;
	Rzradchk::TRzRadioButton* optGroup;
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	void __fastcall SetItem(const AnsiString Item);
	AnsiString __fastcall GetItem();
	
public:
	__property AnsiString Item = {read=GetItem, write=SetItem};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzCheckItemEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzCheckItemEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzCheckItemEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCheckItemEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzchecklistitemform */
using namespace Rzchecklistitemform;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzchecklistitemform
