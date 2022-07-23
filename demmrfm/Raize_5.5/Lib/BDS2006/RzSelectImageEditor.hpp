// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzselectimageeditor.pas' rev: 10.00

#ifndef RzselectimageeditorHPP
#define RzselectimageeditorHPP

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
#include <Designmenus.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Vcleditors.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzdesigneditors.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit
#include <Rzlstbox.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Rzstatus.hpp>	// Pascal unit
#include <Rzspnedt.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzselectimageeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzCustomImageIndexProperty;
class PASCALIMPLEMENTATION TRzCustomImageIndexProperty : public Designeditors::TIntegerProperty 
{
	typedef Designeditors::TIntegerProperty inherited;
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void) = 0 ;
	virtual int __fastcall GetImageHeight(Imglist::TCustomImageList* Images, Graphics::TCanvas* ACanvas);
	virtual int __fastcall GetImageWidth(Imglist::TCustomImageList* Images, Graphics::TCanvas* ACanvas);
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(Classes::TGetStrProc Proc);
	virtual void __fastcall Edit(void);
	void __fastcall ListMeasureHeight(const AnsiString Value, Graphics::TCanvas* ACanvas, int &AHeight);
	void __fastcall ListMeasureWidth(const AnsiString Value, Graphics::TCanvas* ACanvas, int &AWidth);
	void __fastcall ListDrawValue(const AnsiString Value, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool ASelected);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzCustomImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TIntegerProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzCustomImageIndexProperty(void) { }
	#pragma option pop
	
private:
	void *__ICustomPropertyListDrawing;	/* Vcleditors::ICustomPropertyListDrawing */
	
public:
	operator ICustomPropertyListDrawing*(void) { return (ICustomPropertyListDrawing*)&__ICustomPropertyListDrawing; }
	
};


class DELPHICLASS TRzImageIndexProperty;
class PASCALIMPLEMENTATION TRzImageIndexProperty : public TRzCustomImageIndexProperty 
{
	typedef TRzCustomImageIndexProperty inherited;
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TRzCustomImageIndexProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzImageIndexProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzToolButtonImageIndexProperty;
class PASCALIMPLEMENTATION TRzToolButtonImageIndexProperty : public TRzCustomImageIndexProperty 
{
	typedef TRzCustomImageIndexProperty inherited;
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzToolButtonImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TRzCustomImageIndexProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzToolButtonImageIndexProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzTabSheetImageIndexProperty;
class PASCALIMPLEMENTATION TRzTabSheetImageIndexProperty : public TRzCustomImageIndexProperty 
{
	typedef TRzCustomImageIndexProperty inherited;
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzTabSheetImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TRzCustomImageIndexProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzTabSheetImageIndexProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzGroupCaptionImageIndexProperty;
class PASCALIMPLEMENTATION TRzGroupCaptionImageIndexProperty : public TRzCustomImageIndexProperty 
{
	typedef TRzCustomImageIndexProperty inherited;
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzGroupCaptionImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TRzCustomImageIndexProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzGroupCaptionImageIndexProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzGroupItemImageIndexProperty;
class PASCALIMPLEMENTATION TRzGroupItemImageIndexProperty : public TRzCustomImageIndexProperty 
{
	typedef TRzCustomImageIndexProperty inherited;
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzGroupItemImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TRzCustomImageIndexProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzGroupItemImageIndexProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzPathItemImageIndexProperty;
class PASCALIMPLEMENTATION TRzPathItemImageIndexProperty : public TRzCustomImageIndexProperty 
{
	typedef TRzCustomImageIndexProperty inherited;
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzPathItemImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TRzCustomImageIndexProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzPathItemImageIndexProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzGroupTemplateCaptionImageIndexProperty;
class PASCALIMPLEMENTATION TRzGroupTemplateCaptionImageIndexProperty : public TRzCustomImageIndexProperty 
{
	typedef TRzCustomImageIndexProperty inherited;
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzGroupTemplateCaptionImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TRzCustomImageIndexProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzGroupTemplateCaptionImageIndexProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzGroupTemplateItemImageIndexProperty;
class PASCALIMPLEMENTATION TRzGroupTemplateItemImageIndexProperty : public TRzCustomImageIndexProperty 
{
	typedef TRzCustomImageIndexProperty inherited;
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzGroupTemplateItemImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TRzCustomImageIndexProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzGroupTemplateItemImageIndexProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzAnimatorImageIndexProperty;
class PASCALIMPLEMENTATION TRzAnimatorImageIndexProperty : public TRzCustomImageIndexProperty 
{
	typedef TRzCustomImageIndexProperty inherited;
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzAnimatorImageIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TRzCustomImageIndexProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzAnimatorImageIndexProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzTrayIconIndexProperty;
class PASCALIMPLEMENTATION TRzTrayIconIndexProperty : public TRzCustomImageIndexProperty 
{
	typedef TRzCustomImageIndexProperty inherited;
	
protected:
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TRzTrayIconIndexProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : TRzCustomImageIndexProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TRzTrayIconIndexProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzToolButtonEditor;
class PASCALIMPLEMENTATION TRzToolButtonEditor : public Rzdesigneditors::TRzDefaultEditor 
{
	typedef Rzdesigneditors::TRzDefaultEditor inherited;
	
protected:
	Rzbutton::TRzToolButton* __fastcall ToolButton(void);
	virtual bool __fastcall GetCompRefData(int Index, TMetaClass* &CompRefClass, AnsiString &CompRefPropName, Classes::TNotifyEvent &CompRefMenuHandler);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall LayoutMenuHandler(System::TObject* Sender);
	void __fastcall DropDownMenuMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzToolButtonEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzToolButtonEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzBitBtnEditor;
class PASCALIMPLEMENTATION TRzBitBtnEditor : public Rzdesigneditors::TRzDefaultEditor 
{
	typedef Rzdesigneditors::TRzDefaultEditor inherited;
	
protected:
	Rzbutton::TRzBitBtn* __fastcall BitBtn(void);
	virtual bool __fastcall GetCompRefData(int Index, TMetaClass* &CompRefClass, AnsiString &CompRefPropName, Classes::TNotifyEvent &CompRefMenuHandler);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzBitBtnEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzBitBtnEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzMenuButtonEditor;
class PASCALIMPLEMENTATION TRzMenuButtonEditor : public TRzBitBtnEditor 
{
	typedef TRzBitBtnEditor inherited;
	
protected:
	virtual bool __fastcall GetCompRefData(int Index, TMetaClass* &CompRefClass, AnsiString &CompRefPropName, Classes::TNotifyEvent &CompRefMenuHandler);
	void __fastcall DropDownMenuMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzMenuButtonEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TRzBitBtnEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzMenuButtonEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzRapidFireButtonEditor;
class PASCALIMPLEMENTATION TRzRapidFireButtonEditor : public Rzdesigneditors::TRzDefaultEditor 
{
	typedef Rzdesigneditors::TRzDefaultEditor inherited;
	
protected:
	Rzspnedt::TRzRapidFireButton* __fastcall Button(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall ScrollStyleMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzRapidFireButtonEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzRapidFireButtonEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzSelectImageEditor;
class PASCALIMPLEMENTATION TRzSelectImageEditor : public Rzdesigneditors::TRzDefaultEditor 
{
	typedef Rzdesigneditors::TRzDefaultEditor inherited;
	
protected:
	virtual bool __fastcall GetCompRefData(int Index, TMetaClass* &CompRefClass, AnsiString &CompRefPropName, Classes::TNotifyEvent &CompRefMenuHandler);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzSelectImageEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzDefaultEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzSelectImageEditor(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzTextChangeType { tctNone, tctCaption, tctHint };
#pragma option pop

class DELPHICLASS TRzSelectImageEditDlg;
class PASCALIMPLEMENTATION TRzSelectImageEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzbutton::TRzButton* BtnDone;
	Rzpanel::TRzGroupBox* GrpCustomImages;
	Rzpanel::TRzGroupBox* GrpStockImages;
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
	Menus::TPopupMenu* MnuStock;
	Menus::TMenuItem* MnuEditStockHint;
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
	Rzbutton::TRzToolbarButton* BtnClearImage;
	Extctrls::TImage* ImgGroove;
	Extctrls::TImage* ImgSpacer;
	Rzbutton::TRzToolbarButton* BtnDBFirst;
	Rzradchk::TRzCheckBox* ChkSetHint;
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
	Rzradchk::TRzCheckBox* ChkAddDisabled;
	Rzpanel::TRzGroupBox* GrpImageList;
	Rzlstbox::TRzListBox* LstImageList;
	Forms::TScrollBox* SbxCustom;
	Menus::TPopupMenu* MnuCustomImages;
	Menus::TMenuItem* AddCustomImage1;
	Extdlgs::TOpenPictureDialog* DlgOpenPicture;
	Rzlabel::TRzLabel* LblNoImageListTitle;
	Rzlabel::TRzLabel* LblNoImageListMsg;
	Rzbutton::TRzToolbarButton* BtnViewList;
	Rzbutton::TRzToolbarButton* BtnViewDetails;
	Rzbutton::TRzToolbarButton* BtnDBInsert;
	Rzbutton::TRzToolbarButton* BtnDBDelete;
	Menus::TPopupMenu* MnuCustom;
	Menus::TMenuItem* MnuAdd;
	Menus::TMenuItem* MnuSep1;
	Menus::TMenuItem* MnuEditCustomHint;
	Menus::TMenuItem* MnuDelete;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ToolbarButtonClick(System::TObject* Sender);
	void __fastcall MnuAddClick(System::TObject* Sender);
	void __fastcall MnuDeleteClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall MnuEditStockHintClick(System::TObject* Sender);
	void __fastcall MnuEditCustomHintClick(System::TObject* Sender);
	void __fastcall SbxCustomResize(System::TObject* Sender);
	void __fastcall LstImageListDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall LstImageListClick(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	
private:
	Classes::TPersistent* FObject;
	Imglist::TCustomImageList* FImageList;
	bool FHasImageListProp;
	bool FHasGlyphProp;
	bool FIsToolButton;
	Classes::TStringList* FCustomImages;
	void __fastcall RearrangeCustomButtons(void);
	Rzbutton::TRzToolbarButton* __fastcall CreateCustomButton(const AnsiString S);
	AnsiString __fastcall GetFileNameFromString(const AnsiString S);
	AnsiString __fastcall GetHintFromString(const AnsiString S);
	void __fastcall AddImageToImgList(Imglist::TCustomImageList* ImageList, Graphics::TBitmap* Glyph);
	void __fastcall HandleTextChange(System::TObject* Sender);
	int __fastcall GetObjectImageIndex(void);
	void __fastcall SetObjectImageIndex(int Value);
	void __fastcall SetObjectDisabledIndex(int Value);
	void __fastcall SetObjectCaption(const AnsiString Value);
	void __fastcall SetObjectHint(const AnsiString Value);
	void __fastcall SetObjectGlyph(Graphics::TBitmap* Glyph);
	void __fastcall SetObjectNumGlyphs(int Value);
	
public:
	TRzCustomImageIndexProperty* FPropertyEditor;
	bool FEditingProperty;
	Rzbutton::TRzToolbarButton* SelectedBtn;
	Classes::TComponent* CompOwner;
	TRzTextChangeType TextChangeType;
	void __fastcall Reposition(void);
	void __fastcall UpdateControls(void);
	void __fastcall SetPropertyEditor(TRzCustomImageIndexProperty* PropEditor);
	void __fastcall SetObject(Classes::TPersistent* Value, bool EditingProperty);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzSelectImageEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzSelectImageEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzSelectImageEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzSelectImageEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzselectimageeditor */
using namespace Rzselectimageeditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzselectimageeditor
