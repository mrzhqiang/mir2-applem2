// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzsplittereditor.pas' rev: 10.00

#ifndef RzsplittereditorHPP
#define RzsplittereditorHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Designmenus.hpp>	// Pascal unit
#include <Treeintf.hpp>	// Pascal unit
#include <Vclsprigs.hpp>	// Pascal unit
#include <Rztrkbar.hpp>	// Pascal unit
#include <Rzdesigneditors.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rzsplit.hpp>	// Pascal unit
#include <Rzcmbobx.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Rzradgrp.hpp>	// Pascal unit
#include <Rztabs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzsplittereditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzSplitterEditor;
class PASCALIMPLEMENTATION TRzSplitterEditor : public Rzdesigneditors::TRzComponentEditor 
{
	typedef Rzdesigneditors::TRzComponentEditor inherited;
	
protected:
	Rzsplit::TRzSplitter* __fastcall Splitter(void);
	virtual int __fastcall AlignMenuIndex(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzSplitterEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzSplitterEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzSplitterPaneSprig;
class PASCALIMPLEMENTATION TRzSplitterPaneSprig : public Vclsprigs::TWinControlSprig 
{
	typedef Vclsprigs::TWinControlSprig inherited;
	
private:
	bool FUpperLeft;
	
public:
	__fastcall virtual TRzSplitterPaneSprig(Classes::TPersistent* AItem)/* overload */;
	virtual AnsiString __fastcall Caption();
	virtual bool __fastcall Hidden(void);
	virtual bool __fastcall DragOver(Treeintf::TSprig* AItem);
	virtual bool __fastcall DragDrop(Treeintf::TSprig* AItem);
	virtual bool __fastcall PaletteOver(TMetaClass* ASprigClass, TMetaClass* AClass);
public:
	#pragma option push -w-inl
	/* TSprig.Destroy */ inline __fastcall virtual ~TRzSplitterPaneSprig(void) { }
	#pragma option pop
	
};


typedef TMetaClass* TRzSplitterPaneSprigClass;

class DELPHICLASS TRzSplitterSprig;
class PASCALIMPLEMENTATION TRzSplitterSprig : public Vclsprigs::TWinControlSprig 
{
	typedef Vclsprigs::TWinControlSprig inherited;
	
public:
	__fastcall virtual TRzSplitterSprig(Classes::TPersistent* AItem)/* overload */;
	virtual void __fastcall FigureChildren(void);
public:
	#pragma option push -w-inl
	/* TSprig.Destroy */ inline __fastcall virtual ~TRzSplitterSprig(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzSplitterEditDlg;
class PASCALIMPLEMENTATION TRzSplitterEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzbutton::TRzButton* BtnOK;
	Rzbutton::TRzButton* BtnCancel;
	Rzpanel::TRzGroupBox* GrpPreview;
	Rzsplit::TRzSplitter* SplPreview;
	Rzradgrp::TRzRadioGroup* GrpOrientation;
	Rzradchk::TRzCheckBox* ChkRealTime;
	Extctrls::TPaintBox* PbxUpperLeft;
	Rzradchk::TRzCheckBox* ChkUsePercent;
	Rzradgrp::TRzRadioGroup* GrpFixedPane;
	Rzradchk::TRzCheckBox* ChkShowHotSpot;
	Rztabs::TRzTabControl* TbcRegions;
	Rzradchk::TRzCheckBox* ChkVisible;
	Rzpanel::TRzGroupBox* GrpBorder;
	Rzlabel::TRzLabel* LblOuter;
	Rzlabel::TRzLabel* LblInner;
	Rzcmbobx::TRzComboBox* CbxOuter;
	Rzcmbobx::TRzComboBox* CbxInner;
	Rzcmbobx::TRzComboBox* CbxBarStyle;
	Rzpanel::TRzGroupBox* GrpWidth;
	Rztrkbar::TRzTrackBar* TrkWidth;
	Extctrls::TPaintBox* PbxLowerRight;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FrameStyleChange(System::TObject* Sender);
	void __fastcall GrpOrientationClick(System::TObject* Sender);
	void __fastcall TrkWidthChange(System::TObject* Sender);
	void __fastcall ChkRealTimeClick(System::TObject* Sender);
	void __fastcall PbxUpperLeftPaint(System::TObject* Sender);
	void __fastcall PbxLowerRightPaint(System::TObject* Sender);
	void __fastcall PbxUpperLeftClick(System::TObject* Sender);
	void __fastcall PbxLowerRightClick(System::TObject* Sender);
	void __fastcall ChkVisibleClick(System::TObject* Sender);
	void __fastcall TrkWidthDrawTick(Rztrkbar::TRzTrackBar* TrackBar, Graphics::TCanvas* Canvas, const Types::TPoint &Location, int Index);
	void __fastcall CbxBarStyleChange(System::TObject* Sender);
	void __fastcall ChkUsePercentClick(System::TObject* Sender);
	void __fastcall GrpFixedPaneClick(System::TObject* Sender);
	void __fastcall ChkShowHotSpotClick(System::TObject* Sender);
	void __fastcall TbcRegionsChanging(System::TObject* Sender, int NewIndex, bool &AllowChange);
	
private:
	int FRegion;
	void __fastcall SetRegionSettings(void);
	
public:
	void __fastcall UpdateControls(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzSplitterEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzSplitterEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzSplitterEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzSplitterEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzsplittereditor */
using namespace Rzsplittereditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzsplittereditor
