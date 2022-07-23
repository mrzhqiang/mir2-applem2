// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzdbdesigneditors.pas' rev: 10.00

#ifndef RzdbdesigneditorsHPP
#define RzdbdesigneditorsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Dbreg.hpp>	// Pascal unit
#include <Rzdesigneditors.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Rzdbedit.hpp>	// Pascal unit
#include <Rzdblist.hpp>	// Pascal unit
#include <Rzdbcmbo.hpp>	// Pascal unit
#include <Rzdbchk.hpp>	// Pascal unit
#include <Rzdblbl.hpp>	// Pascal unit
#include <Rzdbbned.hpp>	// Pascal unit
#include <Rzdbstat.hpp>	// Pascal unit
#include <Rzdbnav.hpp>	// Pascal unit
#include <Rzdbspin.hpp>	// Pascal unit
#include <Rzdbrgrp.hpp>	// Pascal unit
#include <Rzdbgrid.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzdbdesigneditors
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzDBControlEditor;
class PASCALIMPLEMENTATION TRzDBControlEditor : public Rzdesigneditors::TRzDefaultEditor 
{
	typedef Rzdesigneditors::TRzDefaultEditor inherited;
	
protected:
	virtual int __fastcall DataSourceMenuIndex(void);
	virtual int __fastcall DataFieldMenuIndex(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall DataSourceMenuHandler(System::TObject* Sender);
	void __fastcall DataFieldMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBControlEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBControlEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBListBoxEditor;
class PASCALIMPLEMENTATION TRzDBListBoxEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	Rzdblist::TRzDBListBox* __fastcall ListBox(void);
	virtual int __fastcall AlignMenuIndex(void);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBListBoxEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBListBoxEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBLookupComboBoxEditor;
class PASCALIMPLEMENTATION TRzDBLookupComboBoxEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	virtual int __fastcall ListSourceMenuIndex(void);
	virtual int __fastcall KeyFieldMenuIndex(void);
	virtual int __fastcall ListFieldMenuIndex(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall ListSourceMenuHandler(System::TObject* Sender);
	void __fastcall KeyFieldMenuHandler(System::TObject* Sender);
	void __fastcall ListFieldMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBLookupComboBoxEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBLookupComboBoxEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBMemoEditor;
class PASCALIMPLEMENTATION TRzDBMemoEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	virtual bool __fastcall GetWordWrap(void);
	virtual void __fastcall SetWordWrap(bool Value);
	virtual int __fastcall AlignMenuIndex(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, nodefault};
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBMemoEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBMemoEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBRichEditEditor;
class PASCALIMPLEMENTATION TRzDBRichEditEditor : public TRzDBMemoEditor 
{
	typedef TRzDBMemoEditor inherited;
	
protected:
	virtual bool __fastcall GetWordWrap(void);
	virtual void __fastcall SetWordWrap(bool Value);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBRichEditEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBMemoEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBRichEditEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBDateTimeEditEditor;
class PASCALIMPLEMENTATION TRzDBDateTimeEditEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	Rzdbedit::TRzDBDateTimeEdit* __fastcall DateTimeEdit(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall ElementsMenuHandler(System::TObject* Sender);
	void __fastcall FirstDayOfWeekMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBDateTimeEditEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBDateTimeEditEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBStatusPaneEditor;
class PASCALIMPLEMENTATION TRzDBStatusPaneEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	virtual int __fastcall FlatStyleMenuIndex(void);
	virtual int __fastcall AutoSizeMenuIndex(void);
	virtual int __fastcall AlignmentMenuIndex(void);
	virtual int __fastcall BlinkingMenuIndex(void);
	virtual int __fastcall AlignMenuIndex(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall AlignmentMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBStatusPaneEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBStatusPaneEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBStateStatusEditor;
class PASCALIMPLEMENTATION TRzDBStateStatusEditor : public TRzDBStatusPaneEditor 
{
	typedef TRzDBStatusPaneEditor inherited;
	
protected:
	Rzdbstat::TRzDBStateStatus* __fastcall StateStatus(void);
	virtual int __fastcall DataFieldMenuIndex(void);
	virtual int __fastcall FlatStyleMenuIndex(void);
	virtual int __fastcall AutoSizeMenuIndex(void);
	virtual int __fastcall AlignmentMenuIndex(void);
	virtual int __fastcall BlinkingMenuIndex(void);
	virtual int __fastcall AlignMenuIndex(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall GlyphAlignmentMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBStateStatusEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBStatusPaneEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBStateStatusEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBLabelEditor;
class PASCALIMPLEMENTATION TRzDBLabelEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	Rzdblbl::TRzDBLabel* __fastcall LabelControl(void);
	virtual int __fastcall AlignMenuIndex(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall TextStyleMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBLabelEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBLabelEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBProgressBarEditor;
class PASCALIMPLEMENTATION TRzDBProgressBarEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	virtual int __fastcall BaseFieldMenuIndex(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall BaseFieldMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBProgressBarEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBProgressBarEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBButtonEditEditor;
class PASCALIMPLEMENTATION TRzDBButtonEditEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	Rzdbbned::TRzDBButtonEdit* __fastcall ButtonEdit(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall ButtonKindMenuHandler(System::TObject* Sender);
	void __fastcall AltBtnKindMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBButtonEditEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBButtonEditEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBNumericEditEditor;
class PASCALIMPLEMENTATION TRzDBNumericEditEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	Rzdbedit::TRzDBNumericEdit* __fastcall NumericEdit(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBNumericEditEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBNumericEditEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBSpinEditEditor;
class PASCALIMPLEMENTATION TRzDBSpinEditEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	Rzdbspin::TRzDBSpinEdit* __fastcall SpinEdit(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall DirectionMenuHandler(System::TObject* Sender);
	void __fastcall OrientationMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBSpinEditEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBSpinEditEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBSpinnerEditor;
class PASCALIMPLEMENTATION TRzDBSpinnerEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	Rzdbspin::TRzDBSpinner* __fastcall Spinner(void);
	virtual bool __fastcall GetCompRefData(int Index, TMetaClass* &CompRefClass, AnsiString &CompRefPropName, Classes::TNotifyEvent &CompRefMenuHandler);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBSpinnerEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBSpinnerEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBNavigatorEditor;
class PASCALIMPLEMENTATION TRzDBNavigatorEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	Rzdbnav::TRzDBNavigator* __fastcall Navigator(void);
	virtual int __fastcall DataFieldMenuIndex(void);
	virtual bool __fastcall GetCompRefData(int Index, TMetaClass* &CompRefClass, AnsiString &CompRefPropName, Classes::TNotifyEvent &CompRefMenuHandler);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBNavigatorEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBNavigatorEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBCheckBoxEditor;
class PASCALIMPLEMENTATION TRzDBCheckBoxEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	Rzdbchk::TRzDBCheckBox* __fastcall CheckBox(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBCheckBoxEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBCheckBoxEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBCheckBoxGroupEditor;
class PASCALIMPLEMENTATION TRzDBCheckBoxGroupEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	Rzdbrgrp::TRzDBCheckBoxGroup* __fastcall GroupBox(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall GroupStyleMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBCheckBoxGroupEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBCheckBoxGroupEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBGridEditor;
class PASCALIMPLEMENTATION TRzDBGridEditor : public TRzDBControlEditor 
{
	typedef TRzDBControlEditor inherited;
	
protected:
	Rzdbgrid::TRzDBGrid* __fastcall Grid(void);
	virtual int __fastcall DataFieldMenuIndex(void);
	virtual int __fastcall AlignMenuIndex(void);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzDBGridEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzDBControlEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzDBGridEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzSearchFieldProperty;
class PASCALIMPLEMENTATION TRzSearchFieldProperty : public Dbreg::TDBStringProperty 
{
	typedef Dbreg::TDBStringProperty inherited;
	
public:
	virtual void __fastcall GetValueList(Classes::TStrings* List);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzSearchFieldProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Dbreg::TDBStringProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzSearchFieldProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBDateTimeFormatProperty;
class PASCALIMPLEMENTATION TRzDBDateTimeFormatProperty : public Rzdesigneditors::TRzDateTimeFormatProperty 
{
	typedef Rzdesigneditors::TRzDateTimeFormatProperty inherited;
	
protected:
	virtual Rzdesigneditors::TRzDateTimeFormatFilter __fastcall FormatFilter(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzDBDateTimeFormatProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Rzdesigneditors::TRzDateTimeFormatProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzDBDateTimeFormatProperty(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzdbdesigneditors */
using namespace Rzdbdesigneditors;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzdbdesigneditors
