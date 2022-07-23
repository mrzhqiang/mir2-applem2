// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzlabeleditor.pas' rev: 10.00

#ifndef RzlabeleditorHPP
#define RzlabeleditorHPP

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
#include <Menus.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Rzlabel.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Rztrkbar.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Designmenus.hpp>	// Pascal unit
#include <Rzdesigneditors.hpp>	// Pascal unit
#include <Rzcmbobx.hpp>	// Pascal unit
#include <Tabs.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rzradgrp.hpp>	// Pascal unit
#include <Rztabs.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzlabeleditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzLabelEditor;
class PASCALIMPLEMENTATION TRzLabelEditor : public Rzdesigneditors::TRzComponentEditor 
{
	typedef Rzdesigneditors::TRzComponentEditor inherited;
	
protected:
	Rzlabel::TRzLabel* __fastcall LabelControl(void);
	virtual int __fastcall AlignMenuIndex(void);
	virtual void __fastcall PrepareMenuItem(int Index, const Menus::TMenuItem* Item);
	void __fastcall TextStyleMenuHandler(System::TObject* Sender);
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TRzLabelEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Rzdesigneditors::TRzComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzLabelEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzLabelEditDlg;
class PASCALIMPLEMENTATION TRzLabelEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Rzpanel::TRzGroupBox* grpPreview;
	Rzlabel::TRzLabel* lblPreview;
	Rzbutton::TRzButton* btnOK;
	Rzbutton::TRzButton* btnCancel;
	Rzlabel::TRzLabel* Label1;
	Rzedit::TRzMemo* edtCaption;
	Rztabs::TRzPageControl* pgcFormat;
	Rztabs::TRzTabSheet* tabTextStyle;
	Rztabs::TRzTabSheet* tabOptions;
	Rzlabel::TRzLabel* Label2;
	Rzlabel::TRzLabel* Label3;
	Rzlabel::TRzLabel* Label6;
	Rztrkbar::TRzTrackBar* trkPointSize;
	Rzpanel::TRzGroupBox* grpFontStyle;
	Rzradchk::TRzCheckBox* chkBold;
	Rzradchk::TRzCheckBox* chkItalic;
	Rzradchk::TRzCheckBox* chkStrikeout;
	Rzradchk::TRzCheckBox* chkUnderline;
	Rzcmbobx::TRzFontComboBox* cbxFonts;
	Rzradgrp::TRzRadioGroup* grpTextStyle;
	Rzpanel::TRzGroupBox* grpShadow;
	Rzlabel::TRzLabel* Label4;
	Rzlabel::TRzLabel* Label5;
	Rzlabel::TRzLabel* Label7;
	Rzlabel::TRzLabel* LblShadowDepth;
	Rztrkbar::TRzTrackBar* trkShadow;
	Rzpanel::TRzGroupBox* grpRotation;
	Rzlabel::TRzLabel* lblAngle;
	Buttons::TSpeedButton* btnNone;
	Buttons::TSpeedButton* btnFlat;
	Buttons::TSpeedButton* btnCurve;
	Rztrkbar::TRzTrackBar* trkAngle;
	Rzradchk::TRzCheckBox* chk15Degrees;
	Rzradchk::TRzRadioButton* optUpperLeft;
	Rzradchk::TRzRadioButton* optUpperCenter;
	Rzradchk::TRzRadioButton* optUpperRight;
	Rzradchk::TRzRadioButton* optLeftCenter;
	Rzradchk::TRzRadioButton* optCenter;
	Rzradchk::TRzRadioButton* optRightCenter;
	Rzradchk::TRzRadioButton* optLowerLeft;
	Rzradchk::TRzRadioButton* optLowerCenter;
	Rzradchk::TRzRadioButton* optLowerRight;
	Rzcommon::TRzRegIniFile* RzRegIniFile1;
	Rzedit::TRzColorEdit* edtFontColor;
	Rzedit::TRzColorEdit* edtHighlightColor;
	Rzedit::TRzColorEdit* edtShadowColor;
	Rzcommon::TRzCustomColors* RzCustomColors1;
	Rzradchk::TRzCheckBox* chkLightStyle;
	void __fastcall edtCaptionChange(System::TObject* Sender);
	void __fastcall grpTextStyleClick(System::TObject* Sender);
	void __fastcall trkPointSizeDrawTick(Rztrkbar::TRzTrackBar* TrackBar, Graphics::TCanvas* Canvas, const Types::TPoint &Location, int Index);
	void __fastcall trkPointSizeChange(System::TObject* Sender);
	void __fastcall trkShadowChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cbxFontsChange(System::TObject* Sender);
	void __fastcall chkBoldClick(System::TObject* Sender);
	void __fastcall chkItalicClick(System::TObject* Sender);
	void __fastcall chkStrikeoutClick(System::TObject* Sender);
	void __fastcall chkUnderlineClick(System::TObject* Sender);
	void __fastcall trkAngleDrawTick(Rztrkbar::TRzTrackBar* TrackBar, Graphics::TCanvas* Canvas, const Types::TPoint &Location, int Index);
	void __fastcall chk15DegreesClick(System::TObject* Sender);
	void __fastcall trkAngleChange(System::TObject* Sender);
	void __fastcall btnRotationClick(System::TObject* Sender);
	void __fastcall optCenterPointClick(System::TObject* Sender);
	void __fastcall chkLightStyleClick(System::TObject* Sender);
	void __fastcall pgcFormatChanging(System::TObject* Sender, int NewIndex, bool &AllowChange);
	void __fastcall edtFontColorChange(System::TObject* Sender);
	void __fastcall edtHighlightColorChange(System::TObject* Sender);
	void __fastcall edtShadowColorChange(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	
private:
	bool FUpdatingControls;
	bool FNoAngleUpdate;
	
public:
	void __fastcall UpdateControls(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TRzLabelEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRzLabelEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRzLabelEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzLabelEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzlabeleditor */
using namespace Rzlabeleditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzlabeleditor
