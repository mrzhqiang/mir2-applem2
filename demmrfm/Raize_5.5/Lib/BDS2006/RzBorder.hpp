// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzborder.pas' rev: 10.00

#ifndef RzborderHPP
#define RzborderHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Rzgrafx.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzborder
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzBorder;
class PASCALIMPLEMENTATION TRzBorder : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Controls::TBevelWidth FBevelWidth;
	Rzcommon::TFrameStyleEx FBorderInner;
	Rzcommon::TFrameStyleEx FBorderOuter;
	Controls::TBorderWidth FBorderWidth;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderHighlight;
	Graphics::TColor FBorderShadow;
	Rzcommon::TSides FBorderSides;
	Graphics::TColor FFlatColor;
	int FFlatColorAdjustment;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Types::TRect __fastcall GetClientRect();
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	virtual Graphics::TColor __fastcall InteriorColor(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CustomFramingChanged(void);
	virtual void __fastcall SetBevelWidth(Controls::TBevelWidth Value);
	virtual void __fastcall SetBorderColor(Graphics::TColor Value);
	virtual void __fastcall SetBorderHighlight(Graphics::TColor Value);
	virtual void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderShadow(Graphics::TColor Value);
	virtual void __fastcall SetBorderSides(Rzcommon::TSides Value);
	virtual void __fastcall SetBorderWidth(Controls::TBorderWidth Value);
	virtual void __fastcall SetFlatColor(Graphics::TColor Value);
	virtual void __fastcall SetFlatColorAdjustment(int Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	
public:
	__fastcall virtual TRzBorder(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzBorder(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Controls::TBevelWidth BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=1};
	__property Controls::TBorderWidth BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777201};
	__property Graphics::TColor BorderHighlight = {read=FBorderHighlight, write=SetBorderHighlight, default=-16777196};
	__property Graphics::TColor BorderShadow = {read=FBorderShadow, write=SetBorderShadow, default=-16777200};
	__property Rzcommon::TFrameStyleEx BorderInner = {read=FBorderInner, write=SetBorderInner, default=0};
	__property Rzcommon::TFrameStyleEx BorderOuter = {read=FBorderOuter, write=SetBorderOuter, default=2};
	__property Rzcommon::TSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Graphics::TColor FlatColor = {read=FFlatColor, write=SetFlatColor, default=-16777200};
	__property int FlatColorAdjustment = {read=FFlatColorAdjustment, write=SetFlatColorAdjustment, default=30};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Constraints ;
	__property DragKind  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property ParentShowHint  = {default=1};
	__property ShowHint ;
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
private:
	void *__IRzCustomFramingNotification;	/* Rzcommon::IRzCustomFramingNotification */
	
public:
	operator IRzCustomFramingNotification*(void) { return (IRzCustomFramingNotification*)&__IRzCustomFramingNotification; }
	
};


class DELPHICLASS TRzLEDDisplay;
class PASCALIMPLEMENTATION TRzLEDDisplay : public TRzBorder 
{
	typedef TRzBorder inherited;
	
private:
	Classes::TAlignment FAlignment;
	AnsiString FCaption;
	int FDotSize;
	int FDotGap;
	Graphics::TColor FBackColor;
	Graphics::TColor FSegOnColor;
	Graphics::TColor FSegOffColor;
	Rzcommon::TRzScrollType FScrollType;
	bool FScrolling;
	int FSteps;
	Word FScrollDelay;
	Extctrls::TTimer* FTimer;
	int FCurrentStep;
	Rzcommon::TRzScrollDisplayEvent FOnScrollDisplay;
	Classes::TNotifyEvent FOnScrollComplete;
	void __fastcall TimerEventHandler(System::TObject* Sender);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall UpdateDotDimensions(void);
	void __fastcall UpdateSteps(void);
	virtual Graphics::TColor __fastcall InteriorColor(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall DrawCell(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, char Symbol);
	Graphics::TColor __fastcall DotColor(char Symbol, int Col, int Row);
	DYNAMIC void __fastcall ScrollDisplay(int CurrentStep, int TotalSteps);
	DYNAMIC void __fastcall ScrollComplete(void);
	void __fastcall SetAlignment(Classes::TAlignment Value);
	virtual void __fastcall SetBevelWidth(Controls::TBevelWidth Value);
	virtual void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderSides(Rzcommon::TSides Value);
	virtual void __fastcall SetBorderWidth(Controls::TBorderWidth Value);
	virtual void __fastcall SetBackColor(Graphics::TColor Value);
	virtual void __fastcall SetSegOnColor(Graphics::TColor Value);
	virtual void __fastcall SetSegOffColor(Graphics::TColor Value);
	virtual void __fastcall SetCaption(const AnsiString Value);
	void __fastcall SetScrollType(Rzcommon::TRzScrollType Value);
	virtual void __fastcall SetScrolling(bool Value);
	void __fastcall SetScrollDelay(Word Value);
	
public:
	__fastcall virtual TRzLEDDisplay(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzLEDDisplay(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property AnsiString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor BackColor = {read=FBackColor, write=SetBackColor, default=0};
	__property Graphics::TColor SegOnColor = {read=FSegOnColor, write=SetSegOnColor, default=65280};
	__property Graphics::TColor SegOffColor = {read=FSegOffColor, write=SetSegOffColor, default=13056};
	__property Rzcommon::TRzScrollType ScrollType = {read=FScrollType, write=SetScrollType, default=1};
	__property bool Scrolling = {read=FScrolling, write=SetScrolling, default=0};
	__property Word ScrollDelay = {read=FScrollDelay, write=SetScrollDelay, default=100};
	__property Rzcommon::TRzScrollDisplayEvent OnScrollDisplay = {read=FOnScrollDisplay, write=FOnScrollDisplay};
	__property Classes::TNotifyEvent OnScrollComplete = {read=FOnScrollComplete, write=FOnScrollComplete};
	__property Align  = {default=0};
	__property BorderOuter  = {default=8};
	__property Enabled  = {default=1};
	__property Height  = {default=30};
	__property ShowHint ;
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property Visible  = {default=1};
	__property Width  = {default=100};
	__property OnClick ;
	__property OnDblClick ;
};


typedef DynamicArray<AnsiString >  RzBorder__4;

class DELPHICLASS TRzProgressDisplay;
class PASCALIMPLEMENTATION TRzProgressDisplay : public TRzBorder 
{
	typedef TRzBorder inherited;
	
private:
	DynamicArray<AnsiString >  FLines;
	int FNextLine;
	int FTopLine;
	bool FFirstPage;
	int FFontHeight;
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	
protected:
	AnsiString __fastcall GetLines();
	void __fastcall CopyLines(AnsiString * A, const int A_Size);
	virtual Graphics::TColor __fastcall InteriorColor(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall UpdateNumberOfLines(void);
	
public:
	__fastcall virtual TRzProgressDisplay(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzProgressDisplay(void);
	void __fastcall AddStep(const AnsiString Step);
	void __fastcall Clear(void);
	
__published:
	__property BorderOuter  = {default=8};
	__property Color  = {default=-16777211};
	__property Font ;
	__property Height  = {default=50};
	__property ParentColor  = {default=1};
	__property ParentFont  = {default=1};
	__property Width  = {default=200};
};


#pragma option push -b-
enum TRzMeterType { mtNormal, mtBar3D, mtLED };
#pragma option pop

#pragma option push -b-
enum TRzMeterShape { msRectangular, msTrapezoidal };
#pragma option pop

class DELPHICLASS TRzMeter;
class PASCALIMPLEMENTATION TRzMeter : public TRzBorder 
{
	typedef TRzBorder inherited;
	
private:
	int FMin;
	int FMax;
	int FValue;
	Byte FBWidth;
	Graphics::TColor FBarColor;
	Graphics::TColor FBackColor;
	TRzMeterType FMeterType;
	TRzMeterShape FMeterShape;
	Rzgrafx::TTrapDirect FTrapDirect;
	Rzgrafx::TTrapShape FTrapShape;
	int FTrapMin;
	Rzcommon::TDirection FDirection;
	Graphics::TBitmap* FBitmap;
	Graphics::TBrushStyle FBrushStyle;
	bool FShowPercent;
	Byte FSegSpacing;
	Graphics::TColor FSegOffColor;
	Rzcommon::TPositiveByte FSegCount[3];
	Graphics::TColor FSegColor[3];
	void __fastcall BitmapChangedHandler(System::TObject* Sender);
	
protected:
	virtual Graphics::TColor __fastcall InteriorColor(void);
	virtual void __fastcall Paint(void);
	void __fastcall DrawStandardBar(Graphics::TCanvas* Canvas, const Types::TRect &Bounds);
	void __fastcall DrawLEDBar(Graphics::TCanvas* Canvas, const Types::TRect &Bounds);
	virtual void __fastcall SetMin(int Value);
	virtual void __fastcall SetMax(int Value);
	virtual void __fastcall SetValue(int Value);
	virtual void __fastcall SetBarColor(Graphics::TColor Value);
	virtual void __fastcall SetBackColor(Graphics::TColor Value);
	virtual void __fastcall SetMeterType(TRzMeterType Value);
	virtual void __fastcall SetMeterShape(TRzMeterShape Value);
	virtual void __fastcall SetTrapDirect(Rzgrafx::TTrapDirect Value);
	virtual void __fastcall SetTrapShape(Rzgrafx::TTrapShape Value);
	virtual void __fastcall SetTrapMin(int Value);
	virtual void __fastcall SetDirection(Rzcommon::TDirection Value);
	virtual void __fastcall SetBitmap(Graphics::TBitmap* Value);
	virtual void __fastcall SetBrush(Graphics::TBrushStyle Value);
	virtual void __fastcall SetShowPercent(bool Value);
	virtual int __fastcall GetPercent(void);
	virtual void __fastcall SetSegSpacing(Byte Value);
	virtual void __fastcall SetSegOffColor(Graphics::TColor Value);
	virtual Rzcommon::TPositiveByte __fastcall GetSegCount(int Index);
	virtual void __fastcall SetSegCount(int Index, Rzcommon::TPositiveByte Value);
	virtual Graphics::TColor __fastcall GetSegColor(int Index);
	virtual void __fastcall SetSegColor(int Index, Graphics::TColor Value);
	
public:
	__fastcall virtual TRzMeter(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzMeter(void);
	void __fastcall AddValue(int Number);
	__property int Percent = {read=GetPercent, nodefault};
	
__published:
	__property Rzcommon::TDirection Direction = {read=FDirection, write=SetDirection, default=3};
	__property Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property Graphics::TBrushStyle BrushStyle = {read=FBrushStyle, write=SetBrush, nodefault};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property int Value = {read=FValue, write=SetValue, default=0};
	__property Graphics::TColor BackColor = {read=FBackColor, write=SetBackColor, default=0};
	__property Graphics::TColor BarColor = {read=FBarColor, write=SetBarColor, default=255};
	__property TRzMeterType MeterType = {read=FMeterType, write=SetMeterType, default=2};
	__property TRzMeterShape MeterShape = {read=FMeterShape, write=SetMeterShape, default=0};
	__property bool ShowPercent = {read=FShowPercent, write=SetShowPercent, default=1};
	__property Byte SegSpacing = {read=FSegSpacing, write=SetSegSpacing, default=2};
	__property Graphics::TColor SegOffColor = {read=FSegOffColor, write=SetSegOffColor, default=0};
	__property Rzcommon::TPositiveByte Seg1Count = {read=GetSegCount, write=SetSegCount, index=0, default=5};
	__property Graphics::TColor Seg1Color = {read=GetSegColor, write=SetSegColor, index=0, default=32768};
	__property Rzcommon::TPositiveByte Seg2Count = {read=GetSegCount, write=SetSegCount, index=1, default=3};
	__property Graphics::TColor Seg2Color = {read=GetSegColor, write=SetSegColor, index=1, default=65535};
	__property Rzcommon::TPositiveByte Seg3Count = {read=GetSegCount, write=SetSegCount, index=2, default=2};
	__property Graphics::TColor Seg3Color = {read=GetSegColor, write=SetSegColor, index=2, default=255};
	__property Rzgrafx::TTrapDirect TrapezoidDir = {read=FTrapDirect, write=SetTrapDirect, default=0};
	__property int TrapezoidMin = {read=FTrapMin, write=SetTrapMin, default=6};
	__property Rzgrafx::TTrapShape TrapezoidShape = {read=FTrapShape, write=SetTrapShape, default=1};
	__property Align  = {default=0};
	__property BorderOuter  = {default=8};
	__property Color  = {default=-16777211};
	__property Font ;
	__property Height  = {default=30};
	__property ParentColor  = {default=1};
	__property ParentFont  = {default=1};
	__property ShowHint ;
	__property ParentShowHint  = {default=1};
	__property Width  = {default=150};
	__property OnClick ;
	__property OnDblClick ;
};


class DELPHICLASS TRzColorPicker;
class PASCALIMPLEMENTATION TRzColorPicker : public Rzpanel::TRzCustomPanel 
{
	typedef Rzpanel::TRzCustomPanel inherited;
	
private:
	Graphics::TColor FCustomColor;
	Graphics::TColor FDefaultColor;
	Dialogs::TColorDialogOptions FColorDlgOptions;
	Rzcommon::TRzCustomColors* FCustomColors;
	AnsiString FCustomColorCaption;
	AnsiString FNoColorCaption;
	AnsiString FDefaultColorCaption;
	bool FShowCustomColor;
	bool FShowNoColor;
	bool FShowDefaultColor;
	bool FShowSystemColors;
	int FSelColorIndex;
	int FHighlightColorIndex;
	Graphics::TColor FThemeBorderColor;
	Classes::TNotifyEvent FOnChange;
	bool FShowColorHints;
	Controls::THintWindow* FHintWnd;
	Graphics::TColor FButtonColor;
	Graphics::TColor FButtonFontColor;
	bool FIsPopup;
	int __fastcall Margin(void);
	HIDESBASE void __fastcall UpdateBounds(void);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	int __fastcall HitTest(int X, int Y);
	Types::TRect __fastcall GetCellRect(int Index);
	Types::TRect __fastcall CalcHintRect(int MaxWidth, const AnsiString HintStr, Controls::THintWindow* HintWnd);
	void __fastcall DoHint(int X, int Y);
	void __fastcall ReleaseHintWindow(void);
	virtual void __fastcall PickCustomColor(void);
	DYNAMIC void __fastcall ColorChanged(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall SetButtonColor(Graphics::TColor Value);
	virtual void __fastcall SetButtonFontColor(Graphics::TColor Value);
	virtual void __fastcall SetCustomColorCaption(const AnsiString Value);
	virtual void __fastcall SetCustomColor(Graphics::TColor Value);
	virtual void __fastcall SetCustomColors(Rzcommon::TRzCustomColors* Value);
	virtual void __fastcall SetDefaultColor(Graphics::TColor Value);
	virtual void __fastcall SetNoColorCaption(const AnsiString Value);
	virtual void __fastcall SetDefaultColorCaption(const AnsiString Value);
	virtual void __fastcall SetShowCustomColor(bool Value);
	virtual void __fastcall SetShowNoColor(bool Value);
	virtual void __fastcall SetShowDefaultColor(bool Value);
	virtual void __fastcall SetShowSystemColors(bool Value);
	virtual void __fastcall SetSelColorIndex(int Value);
	virtual void __fastcall SetHighlightColorIndex(int Value);
	virtual Graphics::TColor __fastcall GetSelectedColor(void);
	virtual void __fastcall SetSelectedColor(Graphics::TColor Value);
	
public:
	__fastcall virtual TRzColorPicker(Classes::TComponent* AOwner);
	__property bool IsPopup = {write=FIsPopup, nodefault};
	__property int SelColorIndex = {read=FSelColorIndex, write=SetSelColorIndex, nodefault};
	
__published:
	__property Graphics::TColor ButtonColor = {read=FButtonColor, write=SetButtonColor, default=-16777201};
	__property Graphics::TColor ButtonFontColor = {read=FButtonFontColor, write=SetButtonFontColor, default=-16777208};
	__property AnsiString CustomColorCaption = {read=FCustomColorCaption, write=SetCustomColorCaption};
	__property Graphics::TColor CustomColor = {read=FCustomColor, write=SetCustomColor, default=16777215};
	__property Rzcommon::TRzCustomColors* CustomColors = {read=FCustomColors, write=SetCustomColors};
	__property Dialogs::TColorDialogOptions ColorDlgOptions = {read=FColorDlgOptions, write=FColorDlgOptions, default=1};
	__property Graphics::TColor DefaultColor = {read=FDefaultColor, write=SetDefaultColor, default=-16777203};
	__property AnsiString DefaultColorCaption = {read=FDefaultColorCaption, write=SetDefaultColorCaption};
	__property bool ShowColorHints = {read=FShowColorHints, write=FShowColorHints, default=1};
	__property AnsiString NoColorCaption = {read=FNoColorCaption, write=SetNoColorCaption};
	__property Graphics::TColor SelectedColor = {read=GetSelectedColor, write=SetSelectedColor, default=536870911};
	__property bool ShowNoColor = {read=FShowNoColor, write=SetShowNoColor, default=0};
	__property bool ShowCustomColor = {read=FShowCustomColor, write=SetShowCustomColor, default=0};
	__property bool ShowDefaultColor = {read=FShowDefaultColor, write=SetShowDefaultColor, default=0};
	__property bool ShowSystemColors = {read=FShowSystemColors, write=SetShowSystemColors, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=1};
	__property BevelWidth  = {default=1};
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=8};
	__property BorderSides  = {default=15};
	__property BorderColor  = {default=-16777211};
	__property BorderHighlight  = {default=-16777196};
	__property BorderShadow  = {default=-16777200};
	__property BorderWidth  = {default=2};
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=0};
	__property Font ;
	__property FrameController ;
	__property FrameControllerNotifications  = {default=65535};
	__property Hint ;
	__property ParentColor  = {default=0};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEndDock ;
	__property OnEnter ;
	__property OnExit ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
public:
	#pragma option push -w-inl
	/* TRzCustomPanel.Destroy */ inline __fastcall virtual ~TRzColorPicker(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzColorPicker(HWND ParentWindow) : Rzpanel::TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _sRzColorBlack;
#define Rzborder_sRzColorBlack System::LoadResourceString(&Rzborder::_sRzColorBlack)
extern PACKAGE System::ResourceString _sRzColorBrown;
#define Rzborder_sRzColorBrown System::LoadResourceString(&Rzborder::_sRzColorBrown)
extern PACKAGE System::ResourceString _sRzColorOliveGreen;
#define Rzborder_sRzColorOliveGreen System::LoadResourceString(&Rzborder::_sRzColorOliveGreen)
extern PACKAGE System::ResourceString _sRzColorDarkGreen;
#define Rzborder_sRzColorDarkGreen System::LoadResourceString(&Rzborder::_sRzColorDarkGreen)
extern PACKAGE System::ResourceString _sRzColorDarkTeal;
#define Rzborder_sRzColorDarkTeal System::LoadResourceString(&Rzborder::_sRzColorDarkTeal)
extern PACKAGE System::ResourceString _sRzColorDarkBlue;
#define Rzborder_sRzColorDarkBlue System::LoadResourceString(&Rzborder::_sRzColorDarkBlue)
extern PACKAGE System::ResourceString _sRzColorIndigo;
#define Rzborder_sRzColorIndigo System::LoadResourceString(&Rzborder::_sRzColorIndigo)
extern PACKAGE System::ResourceString _sRzColorGray80;
#define Rzborder_sRzColorGray80 System::LoadResourceString(&Rzborder::_sRzColorGray80)
extern PACKAGE System::ResourceString _sRzColorDarkRed;
#define Rzborder_sRzColorDarkRed System::LoadResourceString(&Rzborder::_sRzColorDarkRed)
extern PACKAGE System::ResourceString _sRzColorOrange;
#define Rzborder_sRzColorOrange System::LoadResourceString(&Rzborder::_sRzColorOrange)
extern PACKAGE System::ResourceString _sRzColorDarkYellow;
#define Rzborder_sRzColorDarkYellow System::LoadResourceString(&Rzborder::_sRzColorDarkYellow)
extern PACKAGE System::ResourceString _sRzColorGreen;
#define Rzborder_sRzColorGreen System::LoadResourceString(&Rzborder::_sRzColorGreen)
extern PACKAGE System::ResourceString _sRzColorTeal;
#define Rzborder_sRzColorTeal System::LoadResourceString(&Rzborder::_sRzColorTeal)
extern PACKAGE System::ResourceString _sRzColorBlue;
#define Rzborder_sRzColorBlue System::LoadResourceString(&Rzborder::_sRzColorBlue)
extern PACKAGE System::ResourceString _sRzColorBlueGray;
#define Rzborder_sRzColorBlueGray System::LoadResourceString(&Rzborder::_sRzColorBlueGray)
extern PACKAGE System::ResourceString _sRzColorGray50;
#define Rzborder_sRzColorGray50 System::LoadResourceString(&Rzborder::_sRzColorGray50)
extern PACKAGE System::ResourceString _sRzColorRed;
#define Rzborder_sRzColorRed System::LoadResourceString(&Rzborder::_sRzColorRed)
extern PACKAGE System::ResourceString _sRzColorLightOrange;
#define Rzborder_sRzColorLightOrange System::LoadResourceString(&Rzborder::_sRzColorLightOrange)
extern PACKAGE System::ResourceString _sRzColorLime;
#define Rzborder_sRzColorLime System::LoadResourceString(&Rzborder::_sRzColorLime)
extern PACKAGE System::ResourceString _sRzColorSeaGreen;
#define Rzborder_sRzColorSeaGreen System::LoadResourceString(&Rzborder::_sRzColorSeaGreen)
extern PACKAGE System::ResourceString _sRzColorAqua;
#define Rzborder_sRzColorAqua System::LoadResourceString(&Rzborder::_sRzColorAqua)
extern PACKAGE System::ResourceString _sRzColorLightBlue;
#define Rzborder_sRzColorLightBlue System::LoadResourceString(&Rzborder::_sRzColorLightBlue)
extern PACKAGE System::ResourceString _sRzColorViolet;
#define Rzborder_sRzColorViolet System::LoadResourceString(&Rzborder::_sRzColorViolet)
extern PACKAGE System::ResourceString _sRzColorGray40;
#define Rzborder_sRzColorGray40 System::LoadResourceString(&Rzborder::_sRzColorGray40)
extern PACKAGE System::ResourceString _sRzColorPink;
#define Rzborder_sRzColorPink System::LoadResourceString(&Rzborder::_sRzColorPink)
extern PACKAGE System::ResourceString _sRzColorGold;
#define Rzborder_sRzColorGold System::LoadResourceString(&Rzborder::_sRzColorGold)
extern PACKAGE System::ResourceString _sRzColorYellow;
#define Rzborder_sRzColorYellow System::LoadResourceString(&Rzborder::_sRzColorYellow)
extern PACKAGE System::ResourceString _sRzColorBrightGreen;
#define Rzborder_sRzColorBrightGreen System::LoadResourceString(&Rzborder::_sRzColorBrightGreen)
extern PACKAGE System::ResourceString _sRzColorTurquoise;
#define Rzborder_sRzColorTurquoise System::LoadResourceString(&Rzborder::_sRzColorTurquoise)
extern PACKAGE System::ResourceString _sRzColorSkyBlue;
#define Rzborder_sRzColorSkyBlue System::LoadResourceString(&Rzborder::_sRzColorSkyBlue)
extern PACKAGE System::ResourceString _sRzColorPlum;
#define Rzborder_sRzColorPlum System::LoadResourceString(&Rzborder::_sRzColorPlum)
extern PACKAGE System::ResourceString _sRzColorGray25;
#define Rzborder_sRzColorGray25 System::LoadResourceString(&Rzborder::_sRzColorGray25)
extern PACKAGE System::ResourceString _sRzColorRose;
#define Rzborder_sRzColorRose System::LoadResourceString(&Rzborder::_sRzColorRose)
extern PACKAGE System::ResourceString _sRzColorTan;
#define Rzborder_sRzColorTan System::LoadResourceString(&Rzborder::_sRzColorTan)
extern PACKAGE System::ResourceString _sRzColorLightYellow;
#define Rzborder_sRzColorLightYellow System::LoadResourceString(&Rzborder::_sRzColorLightYellow)
extern PACKAGE System::ResourceString _sRzColorLightGreen;
#define Rzborder_sRzColorLightGreen System::LoadResourceString(&Rzborder::_sRzColorLightGreen)
extern PACKAGE System::ResourceString _sRzColorLightTurquoise;
#define Rzborder_sRzColorLightTurquoise System::LoadResourceString(&Rzborder::_sRzColorLightTurquoise)
extern PACKAGE System::ResourceString _sRzColorPaleBlue;
#define Rzborder_sRzColorPaleBlue System::LoadResourceString(&Rzborder::_sRzColorPaleBlue)
extern PACKAGE System::ResourceString _sRzColorLavender;
#define Rzborder_sRzColorLavender System::LoadResourceString(&Rzborder::_sRzColorLavender)
extern PACKAGE System::ResourceString _sRzColorWhite;
#define Rzborder_sRzColorWhite System::LoadResourceString(&Rzborder::_sRzColorWhite)
extern PACKAGE System::ResourceString _sRzColorScrollBar;
#define Rzborder_sRzColorScrollBar System::LoadResourceString(&Rzborder::_sRzColorScrollBar)
extern PACKAGE System::ResourceString _sRzColorBackground;
#define Rzborder_sRzColorBackground System::LoadResourceString(&Rzborder::_sRzColorBackground)
extern PACKAGE System::ResourceString _sRzColorActiveCaption;
#define Rzborder_sRzColorActiveCaption System::LoadResourceString(&Rzborder::_sRzColorActiveCaption)
extern PACKAGE System::ResourceString _sRzColorInactiveCaption;
#define Rzborder_sRzColorInactiveCaption System::LoadResourceString(&Rzborder::_sRzColorInactiveCaption)
extern PACKAGE System::ResourceString _sRzColorMenu;
#define Rzborder_sRzColorMenu System::LoadResourceString(&Rzborder::_sRzColorMenu)
extern PACKAGE System::ResourceString _sRzColorWindow;
#define Rzborder_sRzColorWindow System::LoadResourceString(&Rzborder::_sRzColorWindow)
extern PACKAGE System::ResourceString _sRzColorWindowFrame;
#define Rzborder_sRzColorWindowFrame System::LoadResourceString(&Rzborder::_sRzColorWindowFrame)
extern PACKAGE System::ResourceString _sRzColorMenuText;
#define Rzborder_sRzColorMenuText System::LoadResourceString(&Rzborder::_sRzColorMenuText)
extern PACKAGE System::ResourceString _sRzColorWindowText;
#define Rzborder_sRzColorWindowText System::LoadResourceString(&Rzborder::_sRzColorWindowText)
extern PACKAGE System::ResourceString _sRzColorCaptionText;
#define Rzborder_sRzColorCaptionText System::LoadResourceString(&Rzborder::_sRzColorCaptionText)
extern PACKAGE System::ResourceString _sRzColorActiveBorder;
#define Rzborder_sRzColorActiveBorder System::LoadResourceString(&Rzborder::_sRzColorActiveBorder)
extern PACKAGE System::ResourceString _sRzColorInactiveBorder;
#define Rzborder_sRzColorInactiveBorder System::LoadResourceString(&Rzborder::_sRzColorInactiveBorder)
extern PACKAGE System::ResourceString _sRzColorAppWorkSpace;
#define Rzborder_sRzColorAppWorkSpace System::LoadResourceString(&Rzborder::_sRzColorAppWorkSpace)
extern PACKAGE System::ResourceString _sRzColorHighlight;
#define Rzborder_sRzColorHighlight System::LoadResourceString(&Rzborder::_sRzColorHighlight)
extern PACKAGE System::ResourceString _sRzColorHighlightText;
#define Rzborder_sRzColorHighlightText System::LoadResourceString(&Rzborder::_sRzColorHighlightText)
extern PACKAGE System::ResourceString _sRzColorBtnFace;
#define Rzborder_sRzColorBtnFace System::LoadResourceString(&Rzborder::_sRzColorBtnFace)
extern PACKAGE System::ResourceString _sRzColorBtnShadow;
#define Rzborder_sRzColorBtnShadow System::LoadResourceString(&Rzborder::_sRzColorBtnShadow)
extern PACKAGE System::ResourceString _sRzColorGrayText;
#define Rzborder_sRzColorGrayText System::LoadResourceString(&Rzborder::_sRzColorGrayText)
extern PACKAGE System::ResourceString _sRzColorBtnText;
#define Rzborder_sRzColorBtnText System::LoadResourceString(&Rzborder::_sRzColorBtnText)
extern PACKAGE System::ResourceString _sRzColorInactiveCaptionText;
#define Rzborder_sRzColorInactiveCaptionText System::LoadResourceString(&Rzborder::_sRzColorInactiveCaptionText)
extern PACKAGE System::ResourceString _sRzColorBtnHighlight;
#define Rzborder_sRzColorBtnHighlight System::LoadResourceString(&Rzborder::_sRzColorBtnHighlight)
extern PACKAGE System::ResourceString _sRzColor3DDkShadow;
#define Rzborder_sRzColor3DDkShadow System::LoadResourceString(&Rzborder::_sRzColor3DDkShadow)
extern PACKAGE System::ResourceString _sRzColor3DLight;
#define Rzborder_sRzColor3DLight System::LoadResourceString(&Rzborder::_sRzColor3DLight)
extern PACKAGE System::ResourceString _sRzColorInfoText;
#define Rzborder_sRzColorInfoText System::LoadResourceString(&Rzborder::_sRzColorInfoText)
extern PACKAGE System::ResourceString _sRzColorInfoBk;
#define Rzborder_sRzColorInfoBk System::LoadResourceString(&Rzborder::_sRzColorInfoBk)
extern PACKAGE System::ResourceString _sRzColorHotLight;
#define Rzborder_sRzColorHotLight System::LoadResourceString(&Rzborder::_sRzColorHotLight)
extern PACKAGE System::ResourceString _sRzColorGradientActiveCaption;
#define Rzborder_sRzColorGradientActiveCaption System::LoadResourceString(&Rzborder::_sRzColorGradientActiveCaption)
extern PACKAGE System::ResourceString _sRzColorGradientInactiveCaption;
#define Rzborder_sRzColorGradientInactiveCaption System::LoadResourceString(&Rzborder::_sRzColorGradientInactiveCaption)
extern PACKAGE System::ResourceString _sRzColorMenuHighlight;
#define Rzborder_sRzColorMenuHighlight System::LoadResourceString(&Rzborder::_sRzColorMenuHighlight)
extern PACKAGE System::ResourceString _sRzColorMenuBar;
#define Rzborder_sRzColorMenuBar System::LoadResourceString(&Rzborder::_sRzColorMenuBar)
extern PACKAGE System::ResourceString _sRzDefaultColorCaption;
#define Rzborder_sRzDefaultColorCaption System::LoadResourceString(&Rzborder::_sRzDefaultColorCaption)
extern PACKAGE System::ResourceString _sRzNoColorCaption;
#define Rzborder_sRzNoColorCaption System::LoadResourceString(&Rzborder::_sRzNoColorCaption)
extern PACKAGE System::ResourceString _sRzCustomColorCaption;
#define Rzborder_sRzCustomColorCaption System::LoadResourceString(&Rzborder::_sRzCustomColorCaption)

}	/* namespace Rzborder */
using namespace Rzborder;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzborder
