// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzstringlisteditor.pas' rev: 10.00

#ifndef RzstringlisteditorHPP
#define RzstringlisteditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Rzprgres.hpp>	// Pascal unit
#include <Rzspnedt.hpp>	// Pascal unit
#include <Rzborder.hpp>	// Pascal unit
#include <Rzstatus.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzstringlisteditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzStringListProperty;
class PASCALIMPLEMENTATION TRzStringListProperty : public Designeditors::TPropertyEditor 
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
	virtual void __fastcall Edit(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzStringListProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzStringListProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzStringListEditDlg;
class PASCALIMPLEMENTATION TRzStringListEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Menus::TPopupMenu* mnuEdit;
	Menus::TMenuItem* mnuUndo;
	Menus::TMenuItem* mnuCut;
	Menus::TMenuItem* mnuCopy;
	Menus::TMenuItem* mnuPaste;
	Menus::TMenuItem* mnuSep1;
	Menus::TMenuItem* mnuOpen;
	Menus::TMenuItem* mnuSave;
	Menus::TMenuItem* mnuSep2;
	Menus::TMenuItem* mnuIndent;
	Dialogs::TFontDialog* dlgFont;
	Menus::TMenuItem* mnuUnindent;
	Menus::TMenuItem* mnuPrint;
	Menus::TMenuItem* mnuSep3;
	Dialogs::TPrintDialog* dlgPrint;
	Rzpanel::TRzPanel* pnlButtons;
	Rzpanel::TRzPanel* RzPanel2;
	Rzbutton::TRzButton* btnOk;
	Rzbutton::TRzButton* btnCancel;
	Rzpanel::TRzPanel* pnlWorkSpace;
	Rzedit::TRzMemo* edtStrings;
	Rzbutton::TRzButton* btnCodeEditor;
	Menus::TMenuItem* mnuSelectAll;
	Controls::TImageList* ImageList1;
	Rzpanel::TRzToolbar* RzToolbar1;
	Rzbutton::TRzToolButton* btnUnindent;
	Rzbutton::TRzToolButton* btnIndent;
	Rzpanel::TRzSpacer* RzSpacer1;
	Rzbutton::TRzToolButton* btnOpen;
	Rzbutton::TRzToolButton* btnSave;
	Rzpanel::TRzSpacer* RzSpacer2;
	Rzbutton::TRzToolButton* btnPrint;
	Rzpanel::TRzSpacer* RzSpacer3;
	Rzbutton::TRzToolButton* btnCut;
	Rzbutton::TRzToolButton* btnCopy;
	Rzbutton::TRzToolButton* btnPaste;
	Rzbutton::TRzToolButton* btnUndo;
	Rzpanel::TRzSpacer* RzSpacer4;
	Rzbutton::TRzToolButton* btnFont;
	Rzpanel::TRzSpacer* RzSpacer5;
	Rzbutton::TRzToolButton* btnTabSize;
	Rzpanel::TRzSpacer* RzSpacer6;
	Rzspnedt::TRzSpinEdit* spnTabSize;
	Rzpanel::TRzSpacer* RzSpacer7;
	Rzbutton::TRzToolButton* btnSetTabSize;
	Rzbutton::TRzToolButton* btnCancelTabSize;
	Dialogs::TOpenDialog* dlgOpen;
	Dialogs::TSaveDialog* dlgSave;
	Rzbutton::TRzToolButton* btnSelectAll;
	Rzpanel::TRzSpacer* RzSpacer8;
	Rzpanel::TRzStatusBar* RzStatusBar1;
	Rzstatus::TRzFieldStatus* stsLine;
	Rzstatus::TRzFieldStatus* stsColumn;
	Rzstatus::TRzStatusPane* stsLineCount;
	Rzstatus::TRzProgressStatus* pbrPrint;
	void __fastcall mnuSelectAllClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall btnFontClick(System::TObject* Sender);
	void __fastcall btnUndoClick(System::TObject* Sender);
	void __fastcall btnCutClick(System::TObject* Sender);
	void __fastcall btnCopyClick(System::TObject* Sender);
	void __fastcall btnPasteClick(System::TObject* Sender);
	void __fastcall btnOpenClick(System::TObject* Sender);
	void __fastcall btnSaveClick(System::TObject* Sender);
	void __fastcall btnIndentClick(System::TObject* Sender);
	void __fastcall edtStringsChange(System::TObject* Sender);
	void __fastcall edtStringsKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall edtStringsKeyUp(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall edtStringsClick(System::TObject* Sender);
	void __fastcall edtStringsMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall btnTabSizeClick(System::TObject* Sender);
	void __fastcall btnUnindentClick(System::TObject* Sender);
	void __fastcall btnSetTabSizeClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall btnPrintClick(System::TObject* Sender);
	void __fastcall btnCodeEditorClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall btnSelectAllClick(System::TObject* Sender);
	
private:
	AnsiString SingleLine;
	AnsiString MultipleLines;
	Registry::TRegIniFile* DelphiIni;
	int FTabSize;
	int FCurLine;
	int FCurCol;
	AnsiString FPropName;
	bool FModified;
	int __fastcall EndOfLine(int LineNum);
	void __fastcall IndentLine(int LineNum);
	bool __fastcall UnindentLine(int LineNum);
	void __fastcall IndentLines(bool Indent);
	void __fastcall SetTabSize(void);
	void __fastcall EnableButtons(bool Enable);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TWMGetMinMaxInfo &Msg);
	
public:
	__property AnsiString PropName = {read=FPropName, write=FPropName};
	void __fastcall UpdateLineColStatus(void);
	void __fastcall UpdateClipboardStatus(void);
	void __fastcall UpdateButtonStatus(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzStringListEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzStringListEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzStringListEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzStringListEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzstringlisteditor */
using namespace Rzstringlisteditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzstringlisteditor
