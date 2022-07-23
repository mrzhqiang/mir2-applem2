// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzshellfolderform.pas' rev: 10.00

#ifndef RzshellfolderformHPP
#define RzshellfolderformHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Shlobj.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rztreevw.hpp>	// Pascal unit
#include <Rzshellintf.hpp>	// Pascal unit
#include <Rzshellctrls.hpp>	// Pascal unit
#include <Rzshelldialogs.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzshellfolderform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzSelectFolderForm;
class PASCALIMPLEMENTATION TRzSelectFolderForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzshellctrls::TRzShellTree* ShellTree;
	Extctrls::TPanel* ButtonPanel;
	Rzbutton::TRzBitBtn* btnOk;
	Rzbutton::TRzBitBtn* btnCancel;
	Rzpanel::TRzStatusBar* RzStatusBar1;
	Rzbutton::TRzToolButton* btnNewFolder;
	Rzbutton::TRzToolButton* btnDeleteFolder;
	Controls::TImageList* ImageList1;
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall ShellTreeChange(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CreateBtnClick(System::TObject* Sender);
	void __fastcall DeleteBtnClick(System::TObject* Sender);
	
private:
	AnsiString __fastcall GetSelectedPathname();
	AnsiString __fastcall GetStatus();
	bool __fastcall GetOkEnabled(void);
	void __fastcall SetSelectedPathname(const AnsiString Value);
	void __fastcall SetStatus(const AnsiString Value);
	void __fastcall SetOkEnabled(bool Value);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TWMGetMinMaxInfo &Msg);
	
protected:
	bool FExecuting;
	Rzshelldialogs::TRzSelectFolderDialogOptions FOptions;
	Classes::TNotifyEvent FOnFormShow;
	Classes::TNotifyEvent FOnFormClose;
	Rzshelldialogs::TRzFolderBrowseSelChangeEvent FOnSelChange;
	Rzshellctrls::TRzShAddItemEvent FOnAddItem;
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall DoShow(void);
	DYNAMIC void __fastcall DoHide(void);
	DYNAMIC void __fastcall DoTranslation(void);
	virtual void __fastcall SetOptions(Rzshelldialogs::TRzSelectFolderDialogOptions Value);
	
public:
	__fastcall virtual TRzSelectFolderForm(Classes::TComponent* AOwner);
	void __fastcall InitFraming(Graphics::TColor FrameColor, Rzcommon::TFrameStyle FrameStyle, bool FrameVisible, Rzcommon::TFramingPreference FramingPreference);
	void __fastcall InitHotTracking(Graphics::TColor ButtonColor, bool HotTrack, Graphics::TColor HighlightColor, Graphics::TColor HotTrackColor, Rzcommon::TRzHotTrackColorType HotTrackColorType);
	void __fastcall InitShowButtonGlyphs(bool ShowButtonGlyphs);
	void __fastcall InitToolButtons(Rzcommon::TRzGradientColorStyle ToolBtnGradientColorStyle, Graphics::TColor ToolBtnSelectionColorStart, Graphics::TColor ToolBtnSelectionColorStop, Graphics::TColor ToolBtnSelectionFrameColor, Rzcommon::TRzVisualStyle ToolBtnVisualStyle);
	__property bool Executing = {read=FExecuting, nodefault};
	__property AnsiString SelectedPathname = {read=GetSelectedPathname, write=SetSelectedPathname};
	__property AnsiString Status = {read=GetStatus, write=SetStatus};
	__property bool OkEnabled = {read=GetOkEnabled, write=SetOkEnabled, nodefault};
	__property Rzshelldialogs::TRzSelectFolderDialogOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property Rzshellctrls::TRzShAddItemEvent OnAddItem = {read=FOnAddItem, write=FOnAddItem};
	__property Classes::TNotifyEvent OnFormClose = {read=FOnFormClose, write=FOnFormClose};
	__property Classes::TNotifyEvent OnFormShow = {read=FOnFormShow, write=FOnFormShow};
	__property Rzshelldialogs::TRzFolderBrowseSelChangeEvent OnSelChange = {read=FOnSelChange, write=FOnSelChange};
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzSelectFolderForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzSelectFolderForm(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzSelectFolderForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzshellfolderform */
using namespace Rzshellfolderform;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzshellfolderform
