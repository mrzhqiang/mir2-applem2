// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzpaneleditor.pas' rev: 10.00

#ifndef RzpaneleditorHPP
#define RzpaneleditorHPP

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
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Designmenus.hpp>	// Pascal unit
#include <Rzdesigneditors.hpp>	// Pascal unit
#include <Rzcmbobx.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rztrkbar.hpp>	// Pascal unit
#include <Rzradgrp.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzpaneleditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzPanelEditor;
class PASCALIMPLEMENTATION TRzPanelEditor : public Rzdesigneditors::TRzComponentEditor 
{
	typedef Rzdesigneditors::TRzComponentEditor inherited;
	
protected:
	Rzpanel::TRzPanel* __fastcall Panel(void);
	virtual int __fastcall AlignMenuIndex(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall VisualStyleMenuHandler(System::TObject* Sender);
	void __fastcall GradientColorStyleMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzPanelEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzPanelEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzPanelEditDlg;
class PASCALIMPLEMENTATION TRzPanelEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzpanel::TRzGroupBox* GrpColors;
	Rzpanel::TRzGroupBox* GrpWidth;
	Rztrkbar::TRzTrackBar* TrkWidth;
	Rzpanel::TRzGroupBox* GrpPreview;
	Rzlabel::TRzLabel* Label1;
	Rzpanel::TRzGroupBox* GrpBorderStyle;
	Rzbutton::TRzButton* BtnOK;
	Rzbutton::TRzButton* BtnCancel;
	Rzpanel::TRzPanel* PnlPreview;
	Rzlabel::TRzLabel* Label2;
	Rzlabel::TRzLabel* Label3;
	Rzradchk::TRzRadioButton* OptBorderWidth;
	Rzradchk::TRzRadioButton* OptBevelWidth;
	Rzlabel::TRzLabel* LblOuter;
	Rzcmbobx::TRzComboBox* CbxOuter;
	Rzlabel::TRzLabel* LblInner;
	Rzcmbobx::TRzComboBox* CbxInner;
	Rzlabel::TRzLabel* Label4;
	Rzpanel::TRzGroupBox* GrpCaption;
	Rzedit::TRzEdit* EdtCaption;
	Rzradgrp::TRzRadioGroup* GrpAlignment;
	Rzcommon::TRzRegIniFile* RzRegIniFile1;
	Rzedit::TRzColorEdit* EdtPanelColor;
	Rzedit::TRzColorEdit* EdtBorderColor;
	Rzedit::TRzColorEdit* EdtBorderHighlight;
	Rzedit::TRzColorEdit* EdtBorderShadow;
	Rzcommon::TRzCustomColors* RzCustomColors1;
	void __fastcall TrkWidthDrawTick(Rztrkbar::TRzTrackBar* TrackBar, Graphics::TCanvas* Canvas, const Types::TPoint &Location, int Index);
	void __fastcall ChkBorderClick(System::TObject* Sender);
	void __fastcall CbxOuterChange(System::TObject* Sender);
	void __fastcall CbxInnerChange(System::TObject* Sender);
	void __fastcall TrkWidthChange(System::TObject* Sender);
	void __fastcall OptBorderWidthClick(System::TObject* Sender);
	void __fastcall GrpAlignmentClick(System::TObject* Sender);
	void __fastcall EdtCaptionChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall EdtPanelColorChange(System::TObject* Sender);
	void __fastcall EdtBorderColorChange(System::TObject* Sender);
	void __fastcall EdtBorderHighlightChange(System::TObject* Sender);
	void __fastcall EdtBorderShadowChange(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	
public:
	void __fastcall UpdateControls(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzPanelEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzPanelEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzPanelEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzPanelEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzpaneleditor */
using namespace Rzpaneleditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzpaneleditor
