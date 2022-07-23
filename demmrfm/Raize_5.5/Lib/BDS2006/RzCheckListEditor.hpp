// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzchecklisteditor.pas' rev: 10.00

#ifndef RzchecklisteditorHPP
#define RzchecklisteditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Rzchklst.hpp>	// Pascal unit
#include <Rzdesigneditors.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Designmenus.hpp>	// Pascal unit
#include <Rzlstbox.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rzshelldialogs.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rzspnedt.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzchecklisteditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzCheckListProperty;
class PASCALIMPLEMENTATION TRzCheckListProperty : public Designeditors::TPropertyEditor 
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
	virtual void __fastcall Edit(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzCheckListProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzCheckListProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzCheckListEditor;
class PASCALIMPLEMENTATION TRzCheckListEditor : public Rzdesigneditors::TRzDefaultEditor 
{
	typedef Rzdesigneditors::TRzDefaultEditor inherited;
	
protected:
	Rzchklst::TRzCheckList* __fastcall CheckList(void);
	virtual int __fastcall AlignMenuIndex(void);
	virtual bool __fastcall GetCompRefData(int Index, TMetaClass* &CompRefClass, AnsiString &CompRefPropName, Classes::TNotifyEvent &CompRefMenuHandler);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzCheckListEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzCheckListEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzCheckListEditDlg;
class PASCALIMPLEMENTATION TRzCheckListEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzpanel::TRzGroupBox* grpPreview;
	Rzchklst::TRzCheckList* lstPreview;
	Rzbutton::TRzButton* btnAdd;
	Rzbutton::TRzButton* btnEdit;
	Rzbutton::TRzButton* btnDelete;
	Rzbutton::TRzButton* btnMoveUp;
	Rzbutton::TRzButton* btnMoveDown;
	Dialogs::TOpenDialog* dlgOpen;
	Dialogs::TSaveDialog* dlgSave;
	Rzbutton::TRzButton* btnOK;
	Rzbutton::TRzButton* btnCancel;
	Rzpanel::TRzPanel* RzPanel1;
	Rzlabel::TRzLabel* lblImageIndex;
	Rzlabel::TRzLabel* lblDisabledIndex;
	Rzradchk::TRzCheckBox* chkItemEnabled;
	Rzradchk::TRzRadioButton* optItem;
	Rzradchk::TRzRadioButton* optGroup;
	Rzpanel::TRzToolbar* RzToolbar1;
	Controls::TImageList* ImageList1;
	Rzbutton::TRzButton* btnLoad;
	Rzbutton::TRzButton* btnSave;
	Rzbutton::TRzButton* btnClear;
	Rzpanel::TRzSpacer* RzSpacer1;
	Rzpanel::TRzSpacer* RzSpacer2;
	Rzradchk::TRzCheckBox* chkAllowGrayed;
	Rzspnedt::TRzSpinEdit* spnImageIndex;
	Rzspnedt::TRzSpinEdit* spnDisabledIndex;
	Rzpanel::TRzSpacer* RzSpacer3;
	void __fastcall lstPreviewClick(System::TObject* Sender);
	void __fastcall chkItemEnabledClick(System::TObject* Sender);
	void __fastcall chkAllowGrayedClick(System::TObject* Sender);
	void __fastcall btnEditClick(System::TObject* Sender);
	void __fastcall btnAddClick(System::TObject* Sender);
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall btnMoveUpClick(System::TObject* Sender);
	void __fastcall btnMoveDownClick(System::TObject* Sender);
	void __fastcall btnLoadClick(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall btnSaveClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall optItemClick(System::TObject* Sender);
	void __fastcall optGroupClick(System::TObject* Sender);
	void __fastcall spnImageIndexChange(System::TObject* Sender);
	void __fastcall spnDisabledIndexChange(System::TObject* Sender);
	
private:
	void __fastcall EnableButtons(bool Enable);
	void __fastcall EnableMoveButtons(int Idx);
	void __fastcall EnableItemControls(void);
	
public:
	void __fastcall UpdateControls(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzCheckListEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzCheckListEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzCheckListEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCheckListEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzchecklisteditor */
using namespace Rzchecklisteditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzchecklisteditor
