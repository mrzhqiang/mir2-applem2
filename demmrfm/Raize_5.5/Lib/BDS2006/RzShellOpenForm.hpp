// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzshellopenform.pas' rev: 10.00

#ifndef RzshellopenformHPP
#define RzshellopenformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzlistvw.hpp>	// Pascal unit
#include <Rztreevw.hpp>	// Pascal unit
#include <Rzcmbobx.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rzsplit.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Rzshellctrls.hpp>	// Pascal unit
#include <Rzshellutils.hpp>	// Pascal unit
#include <Rzshelldialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzshellopenform
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TRzShellOpenSaveForm_LIS { lisEdit, lisList };
#pragma option pop

class DELPHICLASS TRzShellOpenSaveForm;
class PASCALIMPLEMENTATION TRzShellOpenSaveForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzshellctrls::TRzShellCombo* ShellCombo;
	Rzbutton::TRzToolButton* btnUpOneLevel;
	Rzbutton::TRzToolButton* btnList;
	Rzbutton::TRzToolButton* btnDetails;
	Rzbutton::TRzToolButton* btnCreateNewFolder;
	Extctrls::TPanel* PnlEdits;
	Stdctrls::TLabel* lblFileName;
	Stdctrls::TLabel* lblFilesOfType;
	Rzcmbobx::TRzComboBox* cbxFileTypes;
	Rzedit::TRzEdit* edtFileName;
	Rzbutton::TRzBitBtn* btnOpen;
	Rzbutton::TRzBitBtn* btnCancel;
	Rzcmbobx::TRzComboBox* cbxFileName;
	Rzradchk::TRzCheckBox* chkReadOnly;
	Rzbutton::TRzToolButton* btnShowTree;
	Rzbutton::TRzBitBtn* btnHelp;
	Menus::TPopupMenu* LvPopup;
	Menus::TMenuItem* View1Mitm;
	Menus::TMenuItem* N1;
	Menus::TMenuItem* New1Mitm;
	Menus::TMenuItem* N2;
	Menus::TMenuItem* Properties1Mitm;
	Menus::TMenuItem* Folder1Mitm;
	Menus::TMenuItem* LargeIcons1Mitm;
	Menus::TMenuItem* Smallicons1MItm;
	Menus::TMenuItem* List1Mitm;
	Menus::TMenuItem* Details1Mitm;
	Menus::TMenuItem* Paste1Mitm;
	Menus::TMenuItem* N3;
	Rzbutton::TRzToolButton* btnShowDesktop;
	Rzsplit::TRzSplitter* RzSplitter1;
	Rzshellctrls::TRzShellTree* ShellTree;
	Rzshellctrls::TRzShellList* ShellList;
	Controls::TImageList* imlPlaces;
	Extctrls::TPanel* PnlJumps;
	Rzbutton::TRzToolButton* btnPlace0;
	Rzbutton::TRzToolButton* btnPlace1;
	Rzbutton::TRzToolButton* btnPlace2;
	Rzbutton::TRzToolButton* btnPlace3;
	Rzbutton::TRzToolButton* btnPlace4;
	Stdctrls::TLabel* lblLookIn;
	Extctrls::TPanel* PnlWork;
	Controls::TImageList* imlToolbar;
	void __fastcall ViewBtnClick(System::TObject* Sender);
	void __fastcall ShellListChange(System::TObject* Sender, Comctrls::TListItem* Item, Comctrls::TItemChange Change);
	void __fastcall btnUpOneLevelClick(System::TObject* Sender);
	void __fastcall btnShowTreeClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall ShellTreeChange(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall cbxFileTypesSelEndOk(System::TObject* Sender);
	void __fastcall btnCreateNewFolderClick(System::TObject* Sender);
	void __fastcall edtFileNameChange(System::TObject* Sender);
	void __fastcall Paste1MitmClick(System::TObject* Sender);
	void __fastcall Properties1MitmClick(System::TObject* Sender);
	void __fastcall btnHelpClick(System::TObject* Sender);
	void __fastcall chkReadOnlyClick(System::TObject* Sender);
	void __fastcall ShellListFolderChanged(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall btnShowDesktopClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnPlaceClick(System::TObject* Sender);
	
private:
	Contnrs::TObjectList* FPlacesList;
	bool __fastcall FormHelp(Word Command, int Data, bool &CallHelp);
	void __fastcall ListDblClickOpen(System::TObject* Sender, bool &Handled);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TWMGetMinMaxInfo &Msg);
	void __fastcall InitCustomPlaces(void);
	void __fastcall JumpToPlace(int Num);
	void __fastcall UpdateCurrentPlace(void);
	
protected:
	AnsiString FDefaultExt;
	Rzshelldialogs::TRzOpenSaveOptions FOptions;
	Classes::TStrings* FFiles;
	AnsiString FFilter;
	AnsiString FInitialDir;
	Classes::TNotifyEvent FOnTypeChanged;
	Classes::TNotifyEvent FOnFolderChanged;
	Classes::TNotifyEvent FOnSelectionChanged;
	Classes::TNotifyEvent FOnFormShow;
	Classes::TNotifyEvent FOnFormClose;
	Forms::THelpEvent FOnFormHelp;
	DYNAMIC void __fastcall DoOnFormClose(void);
	DYNAMIC void __fastcall DoOnFolderChanged(void);
	DYNAMIC void __fastcall DoOnSelectionChanged(void);
	DYNAMIC void __fastcall DoOnFormShow(void);
	DYNAMIC void __fastcall DoOnTypeChanged(void);
	AnsiString __fastcall GetFilename();
	Classes::TStrings* __fastcall GetFiles(void);
	int __fastcall GetFilterIndex(void);
	int __fastcall GetFormSplitterPos(void);
	Rzshellctrls::TRzShAddItemEvent __fastcall GetOnAddListItem();
	Rzshellctrls::TRzShAddItemEvent __fastcall GetOnAddTreeItem();
	Rzshellctrls::TRzShAddItemEvent __fastcall GetOnAddComboItem();
	void __fastcall SetFilename(const AnsiString Value);
	void __fastcall SetFilter(const AnsiString Value);
	void __fastcall SetFilterIndex(int Value);
	void __fastcall SetFormSplitterPos(int Value);
	void __fastcall SetInitialDir(const AnsiString Value);
	void __fastcall SetOptions(Rzshelldialogs::TRzOpenSaveOptions Value);
	void __fastcall SetOnAddListItem(Rzshellctrls::TRzShAddItemEvent Value);
	void __fastcall SetOnAddTreeItem(Rzshellctrls::TRzShAddItemEvent Value);
	void __fastcall SetOnAddComboItem(Rzshellctrls::TRzShAddItemEvent Value);
	AnsiString FUserFilter;
	bool FExecuting;
	Classes::TStrings* FSelections;
	TRzShellOpenSaveForm_LIS FLastInputState;
	HWND FHGripWindow;
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall DoTranslation(void);
	void __fastcall ApplyUserFilter(AnsiString Filter);
	void __fastcall GetSelectedFiles(Classes::TStrings* s);
	void __fastcall ShowTree(bool Show);
	DYNAMIC void __fastcall DoHide(void);
	DYNAMIC void __fastcall DoShow(void);
	
public:
	__fastcall virtual TRzShellOpenSaveForm(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzShellOpenSaveForm(void);
	bool __fastcall ParseInputstring(const AnsiString ins);
	void __fastcall InitFraming(Graphics::TColor FrameColor, Rzcommon::TFrameStyle FrameStyle, bool FrameVisible, Rzcommon::TFramingPreference FramingPreference);
	void __fastcall InitHotTracking(Graphics::TColor ButtonColor, bool HotTrack, Graphics::TColor HighlightColor, Graphics::TColor HotTrackColor, Rzcommon::TRzHotTrackColorType HotTrackColorType);
	void __fastcall InitShowButtonGlyphs(bool ShowButtonGlyphs);
	void __fastcall InitToolButtons(Rzcommon::TRzGradientColorStyle ToolBtnGradientColorStyle, Graphics::TColor ToolBtnSelectionColorStart, Graphics::TColor ToolBtnSelectionColorStop, Graphics::TColor ToolBtnSelectionFrameColor, Rzcommon::TRzVisualStyle ToolBtnVisualStyle);
	__property AnsiString DefaultExt = {read=FDefaultExt, write=FDefaultExt};
	__property bool Executing = {read=FExecuting, nodefault};
	__property Rzshelldialogs::TRzOpenSaveOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property AnsiString FileName = {read=GetFilename, write=SetFilename};
	__property Classes::TStrings* Files = {read=GetFiles};
	__property AnsiString Filter = {read=FFilter, write=SetFilter};
	__property int FilterIndex = {read=GetFilterIndex, write=SetFilterIndex, default=1};
	__property int FormSplitterPos = {read=GetFormSplitterPos, write=SetFormSplitterPos, default=-1};
	__property HelpContext  = {default=0};
	__property AnsiString InitialDir = {read=FInitialDir, write=SetInitialDir};
	__property Rzshellctrls::TRzShAddItemEvent OnAddListItem = {read=GetOnAddListItem, write=SetOnAddListItem};
	__property Rzshellctrls::TRzShAddItemEvent OnAddTreeItem = {read=GetOnAddTreeItem, write=SetOnAddTreeItem};
	__property Rzshellctrls::TRzShAddItemEvent OnAddComboItem = {read=GetOnAddComboItem, write=SetOnAddComboItem};
	__property OnHelp ;
	__property Forms::THelpEvent OnFormHelp = {read=FOnFormHelp, write=FOnFormHelp};
	__property Classes::TNotifyEvent OnFormClose = {read=FOnFormClose, write=FOnFormClose};
	__property Classes::TNotifyEvent OnFormShow = {read=FOnFormShow, write=FOnFormShow};
	__property Classes::TNotifyEvent OnFolderChanged = {read=FOnFolderChanged, write=FOnFolderChanged};
	__property Classes::TNotifyEvent OnSelectionChanged = {read=FOnSelectionChanged, write=FOnSelectionChanged};
	__property Classes::TNotifyEvent OnTypeChanged = {read=FOnTypeChanged, write=FOnTypeChanged};
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzShellOpenSaveForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzShellOpenSaveForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzshellopenform */
using namespace Rzshellopenform;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzshellopenform
