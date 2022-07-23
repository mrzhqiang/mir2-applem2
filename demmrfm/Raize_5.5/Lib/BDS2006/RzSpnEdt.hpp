// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzspnedt.pas' rev: 10.00

#ifndef RzspnedtHPP
#define RzspnedtHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzspnedt
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TRzRapidFireStyle { rfFocusRect, rfAllowTimer };
#pragma option pop

typedef Set<TRzRapidFireStyle, rfFocusRect, rfAllowTimer>  TRzRapidFireStyles;

class DELPHICLASS TRzRapidFireButton;
class PASCALIMPLEMENTATION TRzRapidFireButton : public Buttons::TSpeedButton 
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Extctrls::TTimer* FRepeatTimer;
	Word FInitialDelay;
	Word FDelay;
	TRzRapidFireStyles FStyle;
	Rzcommon::TRzScrollStyle FScrollStyle;
	void __fastcall TimerExpired(System::TObject* Sender);
	
protected:
	virtual void __fastcall Paint(void);
	void __fastcall AssignArrowGlyph(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetScrollStyle(Rzcommon::TRzScrollStyle Value);
	
public:
	__fastcall virtual TRzRapidFireButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzRapidFireButton(void);
	__property TRzRapidFireStyles Style = {read=FStyle, write=FStyle, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Word Delay = {read=FDelay, write=FDelay, default=100};
	__property Word InitialDelay = {read=FInitialDelay, write=FInitialDelay, default=400};
	__property Rzcommon::TRzScrollStyle ScrollStyle = {read=FScrollStyle, write=SetScrollStyle, default=0};
};


#pragma option push -b-
enum TSpinDirection { sdUpDown, sdLeftRight };
#pragma option pop

#pragma option push -b-
enum TSpinButtonType { sbUp, sbDown };
#pragma option pop

typedef void __fastcall (__closure *TSpinChangingEvent)(System::TObject* Sender, Extended NewValue, bool &AllowChange);

typedef void __fastcall (__closure *TSpinButtonEvent)(System::TObject* Sender, TSpinButtonType Button);

class DELPHICLASS TRzSpinButtons;
class PASCALIMPLEMENTATION TRzSpinButtons : public Controls::TWinControl 
{
	typedef Controls::TWinControl inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	TSpinDirection FDirection;
	Rzcommon::TOrientation FOrientation;
	Rzbutton::TRzControlButton* FUpRightButton;
	Rzbutton::TRzControlButton* FDownLeftButton;
	Rzbutton::TRzControlButton* FFocusedButton;
	Controls::TWinControl* FFocusControl;
	bool FFlat;
	Classes::TNotifyEvent FOnUpRightClick;
	Classes::TNotifyEvent FOnDownLeftClick;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	
protected:
	bool FCustomUpRightGlyph;
	bool FCustomDownLeftGlyph;
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Rzbutton::TRzControlButton* __fastcall CreateButton(void);
	virtual void __fastcall BtnClickHandler(System::TObject* Sender);
	virtual void __fastcall BtnMouseDownHandler(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall BtnGlyphChangeHandler(System::TObject* Sender);
	virtual void __fastcall AdjustDimensions(int &W, int &H);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall UpRightClick(void);
	DYNAMIC void __fastcall DownLeftClick(void);
	virtual void __fastcall SetDirection(TSpinDirection Value);
	virtual bool __fastcall GetAllEnabled(void);
	virtual void __fastcall SetAllEnabled(bool Value);
	virtual Graphics::TColor __fastcall GetColor(void);
	HIDESBASE virtual void __fastcall SetColor(Graphics::TColor Value);
	virtual void __fastcall SetFlat(bool Value);
	virtual void __fastcall SetOrientation(Rzcommon::TOrientation Value);
	Word __fastcall GetInitialDelay(void);
	void __fastcall SetInitialDelay(Word Value);
	Word __fastcall GetDelay(void);
	void __fastcall SetDelay(Word Value);
	virtual Graphics::TBitmap* __fastcall GetUpRightGlyph(void);
	virtual void __fastcall SetUpRightGlyph(Graphics::TBitmap* Value);
	virtual Graphics::TBitmap* __fastcall GetDownLeftGlyph(void);
	virtual void __fastcall SetDownLeftGlyph(Graphics::TBitmap* Value);
	virtual Buttons::TNumGlyphs __fastcall GetUpRightNumGlyphs(void);
	virtual void __fastcall SetUpRightNumGlyphs(Buttons::TNumGlyphs Value);
	virtual Buttons::TNumGlyphs __fastcall GetDownLeftNumGlyphs(void);
	virtual void __fastcall SetDownLeftNumGlyphs(Buttons::TNumGlyphs Value);
	
public:
	__fastcall virtual TRzSpinButtons(Classes::TComponent* AOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property Rzbutton::TRzControlButton* UpRightButton = {read=FUpRightButton};
	__property Rzbutton::TRzControlButton* DownLeftButton = {read=FDownLeftButton};
	__property bool CustomUpRightGlyph = {read=FCustomUpRightGlyph, nodefault};
	__property bool CustomDownLeftGlyph = {read=FCustomDownLeftGlyph, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, default=-16777201};
	__property Word Delay = {read=GetDelay, write=SetDelay, default=100};
	__property TSpinDirection Direction = {read=FDirection, write=SetDirection, default=0};
	__property bool Enabled = {read=GetAllEnabled, write=SetAllEnabled, default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
	__property Graphics::TBitmap* GlyphUpRight = {read=GetUpRightGlyph, write=SetUpRightGlyph, stored=FCustomUpRightGlyph};
	__property Graphics::TBitmap* GlyphDownLeft = {read=GetDownLeftGlyph, write=SetDownLeftGlyph, stored=FCustomDownLeftGlyph};
	__property Word InitialDelay = {read=GetInitialDelay, write=SetInitialDelay, default=400};
	__property Buttons::TNumGlyphs NumGlyphsUpRight = {read=GetUpRightNumGlyphs, write=SetUpRightNumGlyphs, stored=FCustomUpRightGlyph, default=2};
	__property Buttons::TNumGlyphs NumGlyphsDownLeft = {read=GetDownLeftNumGlyphs, write=SetDownLeftNumGlyphs, stored=FCustomDownLeftGlyph, default=2};
	__property Rzcommon::TOrientation Orientation = {read=FOrientation, write=SetOrientation, default=1};
	__property Classes::TNotifyEvent OnDownLeftClick = {read=FOnDownLeftClick, write=FOnDownLeftClick};
	__property Classes::TNotifyEvent OnUpRightClick = {read=FOnUpRightClick, write=FOnUpRightClick};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property ParentColor  = {default=1};
	__property ParentCtl3D  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Visible  = {default=1};
	__property OnContextPopup ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzSpinButtons(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TRzSpinButtons(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzSpinEdit;
class PASCALIMPLEMENTATION TRzSpinEdit : public Rzedit::TRzCustomEdit 
{
	typedef Rzedit::TRzCustomEdit inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FAllowKeyEdit;
	bool FAllowBlank;
	Extended FBlankValue;
	TRzSpinButtons* FButtons;
	int FButtonWidth;
	bool FCheckRange;
	Byte FDecimals;
	Extended FIncrement;
	bool FIntegersOnly;
	Extended FMin;
	Extended FMax;
	Extended FPageSize;
	Graphics::TColor FFlatButtonColor;
	TSpinChangingEvent FOnChanging;
	TSpinButtonEvent FOnButtonClick;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	bool __fastcall IsCustomDownGlyph(void);
	bool __fastcall IsCustomUpGlyph(void);
	virtual void __fastcall ReadOnlyChanged(void);
	virtual void __fastcall ResizeButtons(void);
	virtual Types::TRect __fastcall GetEditRect();
	virtual void __fastcall SetEditRect(void);
	virtual bool __fastcall IsValidChar(char Key);
	virtual void __fastcall UpRightClickHandler(System::TObject* Sender);
	virtual void __fastcall DownLeftClickHandler(System::TObject* Sender);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC bool __fastcall CanChange(Extended NewValue);
	DYNAMIC void __fastcall DoButtonClick(TSpinButtonType S);
	virtual void __fastcall IncValue(const Extended Amount);
	virtual void __fastcall DecValue(const Extended Amount);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetButtonWidth(int Value);
	virtual void __fastcall SetDecimals(Byte Value);
	virtual void __fastcall SetIntegersOnly(bool Value);
	virtual Rzbutton::TRzControlButton* __fastcall GetButton(int Index);
	virtual Graphics::TBitmap* __fastcall GetButtonUpGlyph(void);
	virtual void __fastcall SetButtonUpGlyph(Graphics::TBitmap* Value);
	virtual Buttons::TNumGlyphs __fastcall GetButtonUpNumGlyphs(void);
	virtual void __fastcall SetButtonUpNumGlyphs(Buttons::TNumGlyphs Value);
	virtual Graphics::TBitmap* __fastcall GetButtonDownGlyph(void);
	virtual void __fastcall SetButtonDownGlyph(Graphics::TBitmap* Value);
	virtual Buttons::TNumGlyphs __fastcall GetButtonDownNumGlyphs(void);
	virtual void __fastcall SetButtonDownNumGlyphs(Buttons::TNumGlyphs Value);
	virtual TSpinDirection __fastcall GetDirection(void);
	virtual void __fastcall SetDirection(TSpinDirection Value);
	virtual void __fastcall SetFlatButtons(bool Value);
	virtual Rzcommon::TOrientation __fastcall GetOrientation(void);
	virtual void __fastcall SetOrientation(Rzcommon::TOrientation Value);
	virtual void __fastcall SetCheckRange(bool Value);
	virtual void __fastcall SetMin(const Extended Value);
	virtual void __fastcall SetMax(const Extended Value);
	virtual __int64 __fastcall GetIntValue(void);
	virtual void __fastcall SetIntValue(__int64 Value);
	virtual Extended __fastcall GetValue(void);
	virtual Extended __fastcall CheckValue(const Extended Value);
	virtual void __fastcall SetValue(const Extended Value);
	bool __fastcall StoreIncrement(void);
	bool __fastcall StorePageSize(void);
	
public:
	__fastcall virtual TRzSpinEdit(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__property TRzSpinButtons* Buttons = {read=FButtons};
	__property Rzbutton::TRzControlButton* DownLeftButton = {read=GetButton, index=1};
	__property Rzbutton::TRzControlButton* UpRightButton = {read=GetButton, index=2};
	__property __int64 IntValue = {read=GetIntValue, write=SetIntValue};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AllowBlank = {read=FAllowBlank, write=FAllowBlank, default=0};
	__property Extended BlankValue = {read=FBlankValue, write=FBlankValue};
	__property bool AllowKeyEdit = {read=FAllowKeyEdit, write=FAllowKeyEdit, default=0};
	__property Graphics::TBitmap* ButtonDownGlyph = {read=GetButtonDownGlyph, write=SetButtonDownGlyph, stored=IsCustomDownGlyph};
	__property Buttons::TNumGlyphs ButtonDownNumGlyphs = {read=GetButtonDownNumGlyphs, write=SetButtonDownNumGlyphs, stored=IsCustomDownGlyph, nodefault};
	__property Graphics::TBitmap* ButtonUpGlyph = {read=GetButtonUpGlyph, write=SetButtonUpGlyph, stored=IsCustomUpGlyph};
	__property Buttons::TNumGlyphs ButtonUpNumGlyphs = {read=GetButtonUpNumGlyphs, write=SetButtonUpNumGlyphs, stored=IsCustomUpGlyph, nodefault};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, default=17};
	__property bool CheckRange = {read=FCheckRange, write=SetCheckRange, default=0};
	__property Byte Decimals = {read=FDecimals, write=SetDecimals, default=0};
	__property TSpinDirection Direction = {read=GetDirection, write=SetDirection, default=0};
	__property Graphics::TColor FlatButtonColor = {read=FFlatButtonColor, write=FFlatButtonColor, default=-16777201};
	__property Extended Increment = {read=FIncrement, write=FIncrement, stored=StoreIncrement};
	__property bool IntegersOnly = {read=FIntegersOnly, write=SetIntegersOnly, default=1};
	__property Extended Max = {read=FMax, write=SetMax, stored=true};
	__property Extended Min = {read=FMin, write=SetMin, stored=true};
	__property Rzcommon::TOrientation Orientation = {read=GetOrientation, write=SetOrientation, default=1};
	__property Extended PageSize = {read=FPageSize, write=FPageSize, stored=StorePageSize};
	__property Extended Value = {read=GetValue, write=SetValue};
	__property TSpinChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TSpinButtonEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property Align  = {default=0};
	__property Alignment  = {default=1};
	__property Anchors  = {default=3};
	__property AutoSelect  = {default=1};
	__property AutoSize  = {default=1};
	__property BeepOnInvalidKey  = {default=1};
	__property BiDiMode ;
	__property CharCase  = {default=0};
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property Ctl3D ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FlatButtons  = {default=0};
	__property Font ;
	__property FocusColor  = {default=-16777211};
	__property FrameColor  = {default=-16777200};
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property FrameHotColor  = {default=-16777200};
	__property FrameHotTrack  = {default=0};
	__property FrameHotStyle  = {default=10};
	__property FrameSides  = {default=15};
	__property FrameStyle  = {default=1};
	__property FrameVisible  = {default=0};
	__property FramingPreference  = {default=1};
	__property HideSelection  = {default=1};
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property OEMConvert  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PasswordChar  = {default=0};
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property ReadOnlyColor  = {default=-16777192};
	__property ReadOnlyColorOnFocus  = {default=0};
	__property ShowHint ;
	__property TabOnEnter  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property TextHint ;
	__property TextHintVisibleOnFocus  = {default=0};
	__property Visible  = {default=1};
	__property OnChange ;
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseWheel ;
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TRzCustomEdit.Destroy */ inline __fastcall virtual ~TRzSpinEdit(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzSpinEdit(HWND ParentWindow) : Rzedit::TRzCustomEdit(ParentWindow) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzSpinnerArea { saValue, saMinusButton, saPlusButton };
#pragma option pop

typedef void __fastcall (__closure *TRzSpinnerEvent)(System::TObject* Sender, int NewValue, bool &AllowChange);

typedef void __fastcall (__closure *TRzSpinnerIncDecEvent)(System::TObject* Sender, int Amount);

class DELPHICLASS TRzSpinner;
class PASCALIMPLEMENTATION TRzSpinner : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	int FValue;
	int FMin;
	int FMax;
	int FIncrement;
	int FPageSize;
	bool FCheckRange;
	bool FTabOnEnter;
	bool FShowHexValue;
	AnsiString FHexValuePrefix;
	Graphics::TColor FFrameColor;
	Graphics::TColor FButtonColor;
	int FButtonWidth;
	bool FShowFocusRect;
	bool FMinusBtnDown;
	bool FPlusBtnDown;
	TRzSpinnerArea FLastHotTrackArea;
	bool FOverPlusButton;
	bool FOverMinusButton;
	bool FThemeAware;
	Extctrls::TTimer* FRepeatTimer;
	Word FInitialDelay;
	Word FDelay;
	Graphics::TBitmap* FGlyphBitmap;
	Imglist::TCustomImageList* FImages;
	Imglist::TImageIndex FImageIndexes[2];
	Imglist::TChangeLink* FImagesChangeLink;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	Classes::TNotifyEvent FOnChange;
	TRzSpinnerEvent FOnChanging;
	TRzSpinnerIncDecEvent FOnIncrement;
	TRzSpinnerIncDecEvent FOnDecrement;
	void __fastcall TimerExpired(System::TObject* Sender);
	void __fastcall ImagesChange(System::TObject* Sender);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Paint(void);
	virtual void __fastcall DrawFrame(void);
	virtual void __fastcall DrawValue(void);
	virtual void __fastcall DrawButton(TRzSpinnerArea Area, bool Down, const Types::TRect &Bounds);
	bool __fastcall UseCustomImages(TRzSpinnerArea Area);
	void __fastcall CalcCenterOffsets(const Types::TRect &Bounds, int &L, int &T);
	void __fastcall CheckMinSize(void);
	void __fastcall CheckHotTracking(const Types::TPoint &P);
	virtual void __fastcall CustomFramingChanged(void);
	virtual void __fastcall DecValue(int Amount);
	virtual void __fastcall IncValue(int Amount);
	bool __fastcall ShowFocus(void);
	Types::TPoint __fastcall CursorPosition();
	TRzSpinnerArea __fastcall HitTest(const Types::TPoint &P)/* overload */;
	TRzSpinnerArea __fastcall HitTest(int X, int Y)/* overload */;
	DYNAMIC void __fastcall Change(void);
	DYNAMIC bool __fastcall CanChange(int NewValue);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual void __fastcall SetButtonColor(Graphics::TColor Value);
	virtual void __fastcall SetButtonWidth(int Value);
	virtual void __fastcall SetCheckRange(bool Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetImages(Imglist::TCustomImageList* Value);
	virtual Imglist::TImageIndex __fastcall GetImageIndex(int PropIndex);
	virtual void __fastcall SetImageIndex(int PropIndex, Imglist::TImageIndex Value);
	virtual void __fastcall SetMax(int Value);
	virtual void __fastcall SetMin(int Value);
	virtual int __fastcall CheckValue(int Value);
	virtual void __fastcall SetValue(int Value);
	virtual void __fastcall SetShowHexValue(bool Value);
	virtual void __fastcall SetHexValuePrefix(const AnsiString Value);
	bool __fastcall StoreHexValuePrefix(void);
	virtual void __fastcall SetThemeAware(bool Value);
	
public:
	__fastcall virtual TRzSpinner(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzSpinner(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Graphics::TColor ButtonColor = {read=FButtonColor, write=SetButtonColor, default=-16777201};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, default=18};
	__property bool CheckRange = {read=FCheckRange, write=SetCheckRange, default=0};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777200};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Graphics::TBitmap* GlyphMinus = {read=FGlyphBitmap, stored=false};
	__property Graphics::TBitmap* GlyphPlus = {read=FGlyphBitmap, stored=false};
	__property AnsiString HexValuePrefix = {read=FHexValuePrefix, write=SetHexValuePrefix, stored=StoreHexValuePrefix};
	__property int Increment = {read=FIncrement, write=FIncrement, default=1};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Imglist::TImageIndex ImageIndexMinus = {read=GetImageIndex, write=SetImageIndex, index=1, default=-1};
	__property Imglist::TImageIndex ImageIndexPlus = {read=GetImageIndex, write=SetImageIndex, index=2, default=-1};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int PageSize = {read=FPageSize, write=FPageSize, default=10};
	__property bool ShowHexValue = {read=FShowHexValue, write=SetShowHexValue, default=0};
	__property bool ShowFocusRect = {read=FShowFocusRect, write=FShowFocusRect, default=1};
	__property bool TabOnEnter = {read=FTabOnEnter, write=FTabOnEnter, default=0};
	__property bool ThemeAware = {read=FThemeAware, write=SetThemeAware, default=1};
	__property int Value = {read=FValue, write=SetValue, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TRzSpinnerEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TRzSpinnerIncDecEvent OnIncrement = {read=FOnIncrement, write=FOnIncrement};
	__property TRzSpinnerIncDecEvent OnDecrement = {read=FOnDecrement, write=FOnDecrement};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property Height  = {default=21};
	__property HelpContext  = {default=0};
	__property Hint ;
	__property ParentColor  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property Width  = {default=85};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzSpinner(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
private:
	void *__IRzCustomFramingNotification;	/* Rzcommon::IRzCustomFramingNotification */
	
public:
	operator IRzCustomFramingNotification*(void) { return (IRzCustomFramingNotification*)&__IRzCustomFramingNotification; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzspnedt */
using namespace Rzspnedt;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzspnedt
