// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rztoolbareditor.pas' rev: 10.00

#ifndef RztoolbareditorHPP
#define RztoolbareditorHPP

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
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Designmenus.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Rzspnedt.hpp>	// Pascal unit
#include <Rzborder.hpp>	// Pascal unit
#include <Rzradgrp.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzdesigneditors.hpp>	// Pascal unit
#include <Rzlstbox.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rztoolbareditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzToolbarEditor;
class PASCALIMPLEMENTATION TRzToolbarEditor : public Rzdesigneditors::TRzComponentEditor 
{
	typedef Rzdesigneditors::TRzComponentEditor inherited;
	
protected:
	Rzpanel::TRzToolbar* __fastcall Toolbar(void);
	virtual bool __fastcall GetCompRefData(int Index, TMetaClass* &CompRefClass, AnsiString &CompRefPropName, Classes::TNotifyEvent &CompRefMenuHandler);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall LayoutMenuHandler(System::TObject* Sender);
	void __fastcall SettingsMenuHandler(System::TObject* Sender);
	void __fastcall VisualStyleMenuHandler(System::TObject* Sender);
	void __fastcall GradientColorStyleMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzToolbarEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzToolbarEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzToolbarEditDlg;
class PASCALIMPLEMENTATION TRzToolbarEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Menus::TPopupMenu* MnuStock;
	Menus::TMenuItem* MnuEditStockHint;
	Rzpanel::TRzGroupBox* GrpControls;
	Rzlstbox::TRzListBox* LstOrder;
	Extctrls::TTimer* Timer1;
	Rzpanel::TRzPanel* RzPanel1;
	Rzbutton::TRzToolbarButton* BtnMoveUp;
	Rzbutton::TRzToolbarButton* BtnMoveDown;
	Rzbutton::TRzToolbarButton* BtnDeleteControl;
	Buttons::TSpeedButton* BtnChangePrefix;
	Rzpanel::TRzGroupBox* GrpStockImages;
	Buttons::TSpeedButton* BtnSpacer;
	Buttons::TSpeedButton* BtnGrooveSpacer;
	Rzborder::TRzBorder* RzBorder1;
	Rzpanel::TRzGroupBox* GrpCustomImages;
	Forms::TScrollBox* SbxCustom;
	Menus::TPopupMenu* MnuCustomImages;
	Menus::TMenuItem* AddCustomImage1;
	Extdlgs::TOpenPictureDialog* DlgOpenPicture;
	Rzlabel::TRzLabel* LblNoImageListMsg;
	Rzlabel::TRzLabel* LblNoImageListTitle;
	Rzbutton::TRzToolbarButton* BtnNew;
	Rzbutton::TRzToolbarButton* BtnOpen;
	Rzbutton::TRzToolbarButton* BtnSave;
	Rzbutton::TRzToolbarButton* BtnFolderClosed;
	Rzbutton::TRzToolbarButton* BtnFolderSelect;
	Rzbutton::TRzToolbarButton* BtnCut;
	Rzbutton::TRzToolbarButton* BtnCopy;
	Rzbutton::TRzToolbarButton* BtnPaste;
	Rzbutton::TRzToolbarButton* BtnUndo;
	Rzbutton::TRzToolbarButton* BtnRedo;
	Rzbutton::TRzToolbarButton* BtnSearchFind;
	Rzbutton::TRzToolbarButton* BtnSearchReplace;
	Rzbutton::TRzToolbarButton* BtnSearchFindNext;
	Rzbutton::TRzToolbarButton* BtnFormatBold;
	Rzbutton::TRzToolbarButton* BtnFormatItalics;
	Rzbutton::TRzToolbarButton* BtnFormatUnderline;
	Rzbutton::TRzToolbarButton* BtnFormatFont;
	Rzbutton::TRzToolbarButton* BtnFormatLeft;
	Rzbutton::TRzToolbarButton* BtnFormatCenter;
	Rzbutton::TRzToolbarButton* BtnFormatRight;
	Rzbutton::TRzToolbarButton* BtnFormatJustify;
	Rzbutton::TRzToolbarButton* BtnFormatBullets;
	Rzbutton::TRzToolbarButton* BtnFolderUp;
	Rzbutton::TRzToolbarButton* BtnFolderNew;
	Rzbutton::TRzToolbarButton* BtnHelp;
	Rzbutton::TRzToolbarButton* BtnFolderOpen;
	Rzbutton::TRzToolbarButton* BtnSearchJumpToLine;
	Rzbutton::TRzToolbarButton* BtnDBPrevious;
	Rzbutton::TRzToolbarButton* BtnDBNext;
	Rzbutton::TRzToolbarButton* BtnDBLast;
	Rzbutton::TRzToolbarButton* BtnDBEdit;
	Rzbutton::TRzToolbarButton* BtnDBPost;
	Rzbutton::TRzToolbarButton* BtnDBCancel;
	Rzbutton::TRzToolbarButton* BtnDBRefresh;
	Rzbutton::TRzToolbarButton* BtnOK;
	Rzbutton::TRzToolbarButton* BtnCancel;
	Rzbutton::TRzToolbarButton* BtnSignalError;
	Rzbutton::TRzToolbarButton* BtnHelpBook;
	Rzbutton::TRzToolbarButton* BtnHelpContext;
	Rzbutton::TRzToolbarButton* BtnEmail;
	Rzbutton::TRzToolbarButton* BtnAttach;
	Rzbutton::TRzToolbarButton* BtnWindowCascade;
	Rzbutton::TRzToolbarButton* BtnWindowHorzTile;
	Rzbutton::TRzToolbarButton* BtnWindowVertTile;
	Rzbutton::TRzToolbarButton* BtnWindowTile;
	Rzbutton::TRzToolbarButton* BtnViewZoom;
	Rzbutton::TRzToolbarButton* BtnViewZoomOut;
	Rzbutton::TRzToolbarButton* BtnViewZoomIn;
	Rzbutton::TRzToolbarButton* BtnToolsCursor;
	Rzbutton::TRzToolbarButton* BtnRecycle;
	Rzbutton::TRzToolbarButton* BtnRecycleXP;
	Rzbutton::TRzToolbarButton* BtnClear;
	Rzbutton::TRzToolbarButton* BtnToolsImage;
	Rzbutton::TRzToolbarButton* BtnPrint;
	Rzbutton::TRzToolbarButton* BtnPrintPreview;
	Rzbutton::TRzToolbarButton* BtnCalendarDate;
	Rzbutton::TRzToolbarButton* BtnProperties;
	Rzbutton::TRzToolbarButton* BtnExecute;
	Rzbutton::TRzToolbarButton* BtnToolsRuler;
	Rzbutton::TRzToolbarButton* BtnToolsHammer;
	Rzbutton::TRzToolbarButton* BtnExit;
	Rzbutton::TRzToolbarButton* BtnSignalFinish;
	Rzbutton::TRzToolbarButton* BtnArrowLeft;
	Rzbutton::TRzToolbarButton* BtnArrowUp;
	Rzbutton::TRzToolbarButton* BtnArrowRight;
	Rzbutton::TRzToolbarButton* BtnArrowDown;
	Rzbutton::TRzToolbarButton* BtnMoveLeft;
	Rzbutton::TRzToolbarButton* BtnMoveAllLeft;
	Rzbutton::TRzToolbarButton* BtnMoveRight;
	Rzbutton::TRzToolbarButton* BtnMoveAllRight;
	Rzbutton::TRzToolbarButton* BtnCalendarMonth;
	Rzbutton::TRzToolbarButton* BtnMove;
	Rzbutton::TRzToolbarButton* BtnCopyAll;
	Rzbutton::TRzToolbarButton* BtnSaveAll;
	Rzbutton::TRzToolbarButton* BtnNotebook;
	Rzbutton::TRzToolbarButton* BtnNote;
	Rzbutton::TRzToolbarButton* BtnNotePage;
	Rzbutton::TRzToolbarButton* BtnImport;
	Rzbutton::TRzToolbarButton* BtnExport;
	Rzbutton::TRzToolbarButton* BtnToolsPencil;
	Rzbutton::TRzToolbarButton* BtnToolsPen;
	Rzbutton::TRzToolbarButton* BtnToolsKey;
	Rzbutton::TRzToolbarButton* BtnDBFirst;
	Rzbutton::TRzToolbarButton* BtnPreviewNext;
	Rzbutton::TRzToolbarButton* BtnPreviewPrev;
	Rzbutton::TRzToolbarButton* BtnAlign;
	Rzbutton::TRzToolbarButton* BtnAlignLeft;
	Rzbutton::TRzToolbarButton* BtnAlignTop;
	Rzbutton::TRzToolbarButton* BtnAlignRight;
	Rzbutton::TRzToolbarButton* BtnAlignBottom;
	Rzbutton::TRzToolbarButton* BtnAlignClient;
	Rzbutton::TRzToolbarButton* BtnFileDelete;
	Rzbutton::TRzToolbarButton* BtnAlignNone;
	Rzbutton::TRzToolbarButton* BtnNetWeb;
	Rzbutton::TRzToolbarButton* BtnNetNews;
	Rzbutton::TRzToolbarButton* BtnOrderBackOne;
	Rzbutton::TRzToolbarButton* BtnOrderFrontOne;
	Rzbutton::TRzToolbarButton* BtnOrderToBack;
	Rzbutton::TRzToolbarButton* BtnOrderToFront;
	Rzbutton::TRzToolbarButton* BtnMediaSkipBackward;
	Rzbutton::TRzToolbarButton* BtnMediaRewind;
	Rzbutton::TRzToolbarButton* BtnMediaStop;
	Rzbutton::TRzToolbarButton* BtnMediaPause;
	Rzbutton::TRzToolbarButton* BtnMediaPlay;
	Rzbutton::TRzToolbarButton* BtnMediaFastForward;
	Rzbutton::TRzToolbarButton* BtnMediaSkipForward;
	Rzbutton::TRzToolbarButton* BtnMediaRecord;
	Rzbutton::TRzToolbarButton* BtnSelectAll;
	Rzbutton::TRzToolbarButton* BtnToolsPlug;
	Rzbutton::TRzToolbarButton* BtnOptions;
	Rzbutton::TRzToolbarButton* BtnToolsSpeaker;
	Rzbutton::TRzToolbarButton* BtnToolsPin;
	Rzbutton::TRzToolbarButton* BtnViewIcons;
	Rzbutton::TRzToolbarButton* BtnCalendarWeek;
	Rzbutton::TRzToolbarButton* BtnSignalRed;
	Rzbutton::TRzToolbarButton* BtnSignalOrange;
	Rzbutton::TRzToolbarButton* BtnSignalGreen;
	Rzbutton::TRzToolbarButton* BtnSignalLtBlue;
	Rzbutton::TRzToolbarButton* BtnSignalYellow;
	Rzbutton::TRzToolbarButton* BtnSignalReminder;
	Rzbutton::TRzToolbarButton* BtnSignalWarning;
	Rzbutton::TRzToolbarButton* BtnSignalBlue;
	Rzbutton::TRzToolbarButton* BtnFormatWordWrap;
	Rzbutton::TRzToolbarButton* BtnSignalGray;
	Rzbutton::TRzToolbarButton* BtnFormatTabs;
	Rzbutton::TRzToolbarButton* BtnSignalInfo;
	Rzbutton::TRzToolbarButton* BtnSignalViolet;
	Rzbutton::TRzToolbarButton* BtnViewList;
	Rzbutton::TRzToolbarButton* BtnViewDetails;
	Rzbutton::TRzToolbarButton* BtnDBInsert;
	Rzbutton::TRzToolbarButton* BtnDBDelete;
	Rzpanel::TRzPanel* PnlStyle;
	Rzpanel::TRzPanel* PnlClose;
	Rzpanel::TRzGroupBox* GrpStyle;
	Rzbutton::TRzToolbarButton* BtnNoCaptionsStyle;
	Rzbutton::TRzToolbarButton* BtnCaptionsBottomStyle;
	Rzbutton::TRzToolbarButton* BtnCaptionsRightStyle;
	Rzradchk::TRzCheckBox* ChkAddDisabled;
	Rzbutton::TRzButton* BtnDone;
	Menus::TPopupMenu* MnuCustom;
	Menus::TMenuItem* MnuAdd;
	Menus::TMenuItem* MnuSep1;
	Menus::TMenuItem* MnuEditCustomHint;
	Menus::TMenuItem* MnuDelete;
	Menus::TPopupMenu* MnuControls;
	Menus::TMenuItem* MnuDeleteControl;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ToolbarButtonClick(System::TObject* Sender);
	void __fastcall BtnSpacerClick(System::TObject* Sender);
	void __fastcall MnuAddClick(System::TObject* Sender);
	void __fastcall MnuDeleteClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall MnuEditStockHintClick(System::TObject* Sender);
	void __fastcall BtnMoveDownClick(System::TObject* Sender);
	void __fastcall BtnMoveUpClick(System::TObject* Sender);
	void __fastcall LstOrderClick(System::TObject* Sender);
	void __fastcall LstOrderDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall LstOrderDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall LstOrderDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall LstOrderEndDrag(System::TObject* Sender, System::TObject* Target, int X, int Y);
	void __fastcall LstOrderMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall BtnDeleteControlClick(System::TObject* Sender);
	void __fastcall BtnChangePrefixClick(System::TObject* Sender);
	void __fastcall ButtonStyleClick(System::TObject* Sender);
	void __fastcall MnuEditCustomHintClick(System::TObject* Sender);
	void __fastcall SbxCustomResize(System::TObject* Sender);
	void __fastcall MnuPrefixClick(System::TObject* Sender);
	void __fastcall MnuSuffixClick(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	
private:
	bool FUsePrefix;
	AnsiString FPrefix;
	int OldIdx;
	int NewIdx;
	bool GoingUp;
	Classes::TStringList* FCustomImages;
	void __fastcall RearrangeCustomButtons(void);
	Rzbutton::TRzToolbarButton* __fastcall CreateCustomButton(const AnsiString S);
	AnsiString __fastcall GetFileNameFromString(const AnsiString S);
	AnsiString __fastcall GetHintFromString(const AnsiString S);
	void __fastcall EnableMoveButtons(int Idx);
	Rzbutton::TRzToolButton* __fastcall CreateNewButton(const AnsiString Hint);
	void __fastcall AddImageToImageList(Rzbutton::TRzToolButton* Btn, Graphics::TBitmap* Glyph);
	
public:
	Rzbutton::TRzToolbarButton* SelectedBtn;
	Classes::TComponent* CompOwner;
	Rzpanel::TRzToolbar* Toolbar;
	void __fastcall UpdateControls(void);
	void __fastcall Reposition(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzToolbarEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzToolbarEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzToolbarEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzToolbarEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rztoolbareditor */
using namespace Rztoolbareditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rztoolbareditor
