// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzdbedit.pas' rev: 10.00

#ifndef RzdbeditHPP
#define RzdbeditHPP

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
#include <Rzcommon.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Rzedit.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Rzpopups.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbcgrids.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzdbedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzPaintEdit;
class DELPHICLASS TRzDBEdit;
class PASCALIMPLEMENTATION TRzDBEdit : public Rzedit::TRzCustomEdit 
{
	typedef Rzedit::TRzCustomEdit inherited;
	
private:
	bool FFocused;
	TRzPaintEdit* FPaintControl;
	Dbctrls::TFieldDataLink* FDataLink;
	Classes::TAlignment FAlignment;
	void __fastcall ActiveChangeHandler(System::TObject* Sender);
	void __fastcall DataChangeHandler(System::TObject* Sender);
	void __fastcall EditingChangeHandler(System::TObject* Sender);
	void __fastcall UpdateDataHandler(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMClear(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMUndo(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Msg);
	
protected:
	bool FOverControl;
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall RepaintFrame(void);
	virtual AnsiString __fastcall GetRightJustifiedText();
	virtual void __fastcall AdjustEditRect(void);
	virtual Types::TRect __fastcall GetEditRect();
	void __fastcall ResetMaxLength(void);
	virtual bool __fastcall EditCanModify(void);
	virtual void __fastcall Reset(void);
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataChanged(void);
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall UpdateData(void);
	virtual AnsiString __fastcall GetDisplayString();
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual AnsiString __fastcall GetDataField();
	virtual void __fastcall SetDataField(const AnsiString Value);
	virtual Db::TDataSource* __fastcall GetDataSource(void);
	virtual void __fastcall SetDataSource(Db::TDataSource* Value);
	virtual Db::TField* __fastcall GetField(void);
	virtual void __fastcall SetFocused(bool Value);
	virtual bool __fastcall ReadOnlyValue(void);
	HIDESBASE bool __fastcall GetReadOnly(void);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	virtual void __fastcall SetFrameVisible(bool Value);
	__property Dbctrls::TFieldDataLink* DataLink = {read=FDataLink};
	
public:
	__fastcall virtual TRzDBEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDBEdit(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Db::TField* Field = {read=GetField};
	__property Text ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Align  = {default=0};
	__property Alignment  = {default=0};
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
	__property MaxLength  = {default=0};
	__property OEMConvert  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PasswordChar  = {default=0};
	__property PopupMenu ;
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
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBEdit(HWND ParentWindow) : Rzedit::TRzCustomEdit(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzPaintEdit : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	TRzDBEdit* FEditControl;
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TRzPaintEdit(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TRzPaintEdit(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzPaintEdit(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBNumericEdit;
class PASCALIMPLEMENTATION TRzDBNumericEdit : public TRzDBEdit 
{
	typedef TRzDBEdit inherited;
	
private:
	bool FAllowBlank;
	bool FAllowScientificNotation;
	Extended FBlankValue;
	bool FCheckRange;
	bool FIntegersOnly;
	Extended FMin;
	Extended FMax;
	AnsiString FDisplayFormat;
	Extended FFieldValue;
	bool FModified;
	bool FCalculatorBoldButtons;
	Rzpopups::TRzCalculatorColors* FCalculatorColors;
	bool FDecimalPressed;
	Rzedit::TRzRangeErrorEvent FOnRangeError;
	bool __fastcall GetCalculatorVisible(void);
	void __fastcall SetCalculatorVisible(bool Value);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual bool __fastcall IsValidChar(char Key);
	virtual AnsiString __fastcall FormatText(const Extended Value);
	virtual Extended __fastcall EvaluateText(void);
	virtual void __fastcall DisplayCalculator(void);
	virtual AnsiString __fastcall GetDisplayString();
	virtual void __fastcall DataChanged(void);
	virtual void __fastcall UpdateData(void);
	DYNAMIC void __fastcall CloseUp(void);
	DYNAMIC void __fastcall DropDown(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall RangeError(Extended EnteredValue, Extended AdjustedValue, bool &AutoCorrect);
	virtual void __fastcall SetIntegersOnly(bool Value);
	virtual void __fastcall SetMin(const Extended Value);
	virtual void __fastcall SetMax(const Extended Value);
	virtual __int64 __fastcall GetIntValue(void);
	virtual void __fastcall SetIntValue(__int64 Value);
	virtual Extended __fastcall GetValue(void);
	virtual Extended __fastcall CheckValue(const Extended Value, bool &KeepFocusOnEdit);
	virtual void __fastcall SetValue(const Extended Value);
	virtual void __fastcall SetDisplayFormat(AnsiString FormatString);
	virtual void __fastcall SetCalculatorColors(Rzpopups::TRzCalculatorColors* Value);
	
public:
	__fastcall virtual TRzDBNumericEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDBNumericEdit(void);
	__property __int64 IntValue = {read=GetIntValue, write=SetIntValue};
	__property bool Modified = {read=FModified, nodefault};
	
__published:
	__property bool AllowBlank = {read=FAllowBlank, write=FAllowBlank, default=1};
	__property bool AllowScientificNotation = {read=FAllowScientificNotation, write=FAllowScientificNotation, default=1};
	__property Extended BlankValue = {read=FBlankValue, write=FBlankValue};
	__property bool CalculatorVisible = {read=GetCalculatorVisible, write=SetCalculatorVisible, default=0};
	__property bool CalculatorBoldButtons = {read=FCalculatorBoldButtons, write=FCalculatorBoldButtons, default=0};
	__property Rzpopups::TRzCalculatorColors* CalculatorColors = {read=FCalculatorColors, write=SetCalculatorColors};
	__property bool CheckRange = {read=FCheckRange, write=FCheckRange, default=0};
	__property bool IntegersOnly = {read=FIntegersOnly, write=SetIntegersOnly, default=1};
	__property Extended Max = {read=FMax, write=SetMax};
	__property Extended Min = {read=FMin, write=SetMin};
	__property AnsiString DisplayFormat = {read=FDisplayFormat, write=SetDisplayFormat};
	__property Extended Value = {read=GetValue, write=SetValue};
	__property Rzedit::TRzRangeErrorEvent OnRangeError = {read=FOnRangeError, write=FOnRangeError};
	__property Alignment  = {default=1};
	__property FlatButtonColor  = {default=-16777201};
	__property FlatButtons  = {default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBNumericEdit(HWND ParentWindow) : TRzDBEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBExpandEdit;
class PASCALIMPLEMENTATION TRzDBExpandEdit : public TRzDBEdit 
{
	typedef TRzDBEdit inherited;
	
private:
	int FExpandedWidth;
	bool FExpanded;
	int FOrigWidth;
	Rzcommon::TExpandOnType FExpandOn;
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Messages::TWMMouse &Msg);
	
protected:
	virtual void __fastcall SetExpandedWidth(int Value);
	virtual void __fastcall SetExpandOn(Rzcommon::TExpandOnType Value);
	
public:
	__fastcall virtual TRzDBExpandEdit(Classes::TComponent* AOwner);
	
__published:
	__property int ExpandedWidth = {read=FExpandedWidth, write=SetExpandedWidth, nodefault};
	__property Rzcommon::TExpandOnType ExpandOn = {read=FExpandOn, write=SetExpandOn, default=2};
public:
	#pragma option push -w-inl
	/* TRzDBEdit.Destroy */ inline __fastcall virtual ~TRzDBExpandEdit(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBExpandEdit(HWND ParentWindow) : TRzDBEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBDateTimeEdit;
class PASCALIMPLEMENTATION TRzDBDateTimeEdit : public TRzDBEdit 
{
	typedef TRzDBEdit inherited;
	
private:
	Rzedit::TRzDTEditType FEditType;
	System::TDateTime FLastDateTime;
	System::TDateTime FDateTime;
	System::TDateTime FMinDate;
	System::TDateTime FMaxDate;
	AnsiString FFormat;
	bool FUpdating;
	bool FTimeHasBeenSet;
	bool FSettingTime;
	bool FTimePicked;
	bool FDateHasBeenSet;
	bool FSettingDate;
	bool FDatePicked;
	bool FValidating;
	Rzpopups::TRzCalendarElements FCalendarElements;
	Rzpopups::TRzCalendarColors* FCalendarColors;
	AnsiString FCaptionClearBtn;
	AnsiString FCaptionTodayBtn;
	Rzpopups::TRzFirstDayOfWeek FFirstDayOfWeek;
	Rzpopups::TRzClockFaceColors* FClockFaceColors;
	AnsiString FCaptionAM;
	AnsiString FCaptionPM;
	AnsiString FCaptionSet;
	bool FRestrictMinutes;
	bool FShowHowToUseHint;
	AnsiString FHowToUseMsg;
	Graphics::TColor FPopupButtonColor;
	Graphics::TColor FPopupButtonFontColor;
	Rzpopups::TRzGetBoldDaysEvent FOnGetBoldDays;
	Rzpopups::TRzGetDayFormatEvent FOnGetDayFormat;
	Rzedit::TRzDateTimeChangeEvent FOnDateTimeChange;
	Rzpopups::TRzGetWeekNumberEvent FOnGetWeekNumber;
	Rzpopups::TRzViewDateChangeEvent FOnViewDateChange;
	Rzpopups::TRzInvalidDateEvent FOnInvalidDate;
	Rzpopups::TRzInvalidTimeEvent FOnInvalidTime;
	bool __fastcall StoreMinDate(void);
	bool __fastcall StoreMaxDate(void);
	void __fastcall CheckDateTimeChange(void);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	
protected:
	bool __fastcall CanEditData(void);
	void __fastcall SetDateTime(void);
	void __fastcall UpdateText(void);
	int __fastcall DateInRange(System::TDateTime Value);
	void __fastcall SetRange(TDate MinValue, TDate MaxValue);
	virtual void __fastcall DisplayCalendar(void);
	virtual void __fastcall DisplayTimePicker(void);
	virtual void __fastcall DataChanged(void);
	virtual void __fastcall UpdateData(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall CloseUp(void);
	DYNAMIC void __fastcall DropDown(void);
	DYNAMIC void __fastcall DateTimeChange(void);
	DYNAMIC void __fastcall InvalidDate(bool &KeepFocused, bool &KeepInvalidText, System::TDateTime &NewDate);
	DYNAMIC void __fastcall InvalidTime(bool &KeepFocused, bool &KeepInvalidText, System::TDateTime &NewTime);
	virtual TDate __fastcall GetDate(void);
	virtual void __fastcall SetDate(TDate Value);
	virtual bool __fastcall IsDate(void);
	virtual void __fastcall SetMinDate(System::TDateTime Value);
	virtual void __fastcall SetMaxDate(System::TDateTime Value);
	virtual void __fastcall SetEditType(Rzedit::TRzDTEditType Value);
	virtual void __fastcall SetFormat(const AnsiString Value);
	virtual TTime __fastcall GetTime(void);
	virtual void __fastcall SetTime(TTime Value);
	virtual bool __fastcall IsTime(void);
	virtual void __fastcall SetClockFaceColors(Rzpopups::TRzClockFaceColors* Value);
	virtual void __fastcall SetCalendarColors(Rzpopups::TRzCalendarColors* Value);
	
public:
	__fastcall virtual TRzDBDateTimeEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDBDateTimeEdit(void);
	virtual void __fastcall Clear(void);
	unsigned __fastcall DaysToBitmask(Byte * Days, const int Days_Size);
	void __fastcall AdjustYear(int DeltaYears);
	void __fastcall AdjustMonth(int DeltaMonths);
	void __fastcall AdjustDay(int DeltaDays);
	void __fastcall AdjustHour(__int64 DeltaHours);
	void __fastcall AdjustMinute(__int64 DeltaMinutes);
	bool __fastcall ReformatDateTime(void);
	
__published:
	__property Rzpopups::TRzCalendarColors* CalendarColors = {read=FCalendarColors, write=SetCalendarColors};
	__property Rzpopups::TRzCalendarElements CalendarElements = {read=FCalendarElements, write=FCalendarElements, default=247};
	__property AnsiString CaptionTodayBtn = {read=FCaptionTodayBtn, write=FCaptionTodayBtn};
	__property AnsiString CaptionClearBtn = {read=FCaptionClearBtn, write=FCaptionClearBtn};
	__property AnsiString CaptionAM = {read=FCaptionAM, write=FCaptionAM};
	__property AnsiString CaptionPM = {read=FCaptionPM, write=FCaptionPM};
	__property AnsiString CaptionSet = {read=FCaptionSet, write=FCaptionSet};
	__property Rzpopups::TRzClockFaceColors* ClockFaceColors = {read=FClockFaceColors, write=SetClockFaceColors};
	__property TDate Date = {read=GetDate, write=SetDate, stored=IsDate};
	__property System::TDateTime MinDate = {read=FMinDate, write=SetMinDate, stored=StoreMinDate};
	__property System::TDateTime MaxDate = {read=FMaxDate, write=SetMaxDate, stored=StoreMaxDate};
	__property Rzpopups::TRzFirstDayOfWeek FirstDayOfWeek = {read=FFirstDayOfWeek, write=FFirstDayOfWeek, default=7};
	__property AnsiString HowToUseMsg = {read=FHowToUseMsg, write=FHowToUseMsg};
	__property bool RestrictMinutes = {read=FRestrictMinutes, write=FRestrictMinutes, default=0};
	__property bool ShowHowToUseHint = {read=FShowHowToUseHint, write=FShowHowToUseHint, default=1};
	__property TTime Time = {read=GetTime, write=SetTime, stored=IsTime};
	__property Rzedit::TRzDTEditType EditType = {read=FEditType, write=SetEditType, nodefault};
	__property AnsiString Format = {read=FFormat, write=SetFormat};
	__property Graphics::TColor PopupButtonColor = {read=FPopupButtonColor, write=FPopupButtonColor, default=-16777201};
	__property Graphics::TColor PopupButtonFontColor = {read=FPopupButtonFontColor, write=FPopupButtonFontColor, default=-16777208};
	__property Rzpopups::TRzGetBoldDaysEvent OnGetBoldDays = {read=FOnGetBoldDays, write=FOnGetBoldDays};
	__property Rzpopups::TRzGetDayFormatEvent OnGetDayFormat = {read=FOnGetDayFormat, write=FOnGetDayFormat};
	__property Rzedit::TRzDateTimeChangeEvent OnDateTimeChange = {read=FOnDateTimeChange, write=FOnDateTimeChange};
	__property Rzpopups::TRzGetWeekNumberEvent OnGetWeekNumber = {read=FOnGetWeekNumber, write=FOnGetWeekNumber};
	__property Rzpopups::TRzViewDateChangeEvent OnViewDateChange = {read=FOnViewDateChange, write=FOnViewDateChange};
	__property Rzpopups::TRzInvalidDateEvent OnInvalidDate = {read=FOnInvalidDate, write=FOnInvalidDate};
	__property Rzpopups::TRzInvalidTimeEvent OnInvalidTime = {read=FOnInvalidTime, write=FOnInvalidTime};
	__property Align  = {default=0};
	__property Alignment  = {default=0};
	__property Anchors  = {default=3};
	__property AutoSelect  = {default=1};
	__property AutoSize  = {default=1};
	__property BeepOnInvalidKey  = {default=1};
	__property BorderStyle  = {default=1};
	__property BiDiMode ;
	__property CharCase  = {default=0};
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property DropButtonVisible  = {default=1};
	__property Enabled  = {default=1};
	__property FlatButtonColor  = {default=-16777201};
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
	__property MaxLength  = {default=0};
	__property OEMConvert  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
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
	__property Visible  = {default=1};
	__property OnChange ;
	__property OnClick ;
	__property OnCloseUp ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDropDown ;
	__property OnEndDock ;
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
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBDateTimeEdit(HWND ParentWindow) : TRzDBEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzPaintMemo;
class DELPHICLASS TRzDBMemo;
class PASCALIMPLEMENTATION TRzDBMemo : public Dbctrls::TDBMemo 
{
	typedef Dbctrls::TDBMemo inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FUpdatingColor;
	Graphics::TColor FDisabledColor;
	Graphics::TColor FReadOnlyColor;
	bool FReadOnlyColorOnFocus;
	Graphics::TColor FFocusColor;
	Graphics::TColor FNormalColor;
	Graphics::TColor FFrameColor;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	Graphics::TColor FFrameHotColor;
	bool FFrameHotTrack;
	Rzcommon::TFrameStyleEx FFrameHotStyle;
	Rzcommon::TSides FFrameSides;
	Rzcommon::TFrameStyleEx FFrameStyle;
	bool FFrameVisible;
	Rzcommon::TFramingPreference FFramingPreference;
	bool FTabOnEnter;
	TRzPaintMemo* FPaintControl;
	Rzedit::TLineColChangeEvent FOnLineColChange;
	Rzedit::TClipboardChangeEvent FOnClipboardChange;
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameFocusStyleProp(Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	
protected:
	Graphics::TCanvas* FCanvas;
	bool FOverControl;
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall UpdateColors(void);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	virtual void __fastcall RepaintFrame(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall LineColChange(void);
	DYNAMIC void __fastcall ClipboardChange(void);
	DYNAMIC bool __fastcall DoMouseWheel(Classes::TShiftState Shift, int WheelDelta, const Types::TPoint &MousePos);
	virtual int __fastcall GetColumn(void);
	virtual void __fastcall SetColumn(int Value);
	virtual int __fastcall GetLine(void);
	virtual void __fastcall SetLine(int Value);
	bool __fastcall StoreColor(void);
	bool __fastcall StoreFocusColor(void);
	bool __fastcall StoreDisabledColor(void);
	bool __fastcall StoreReadOnlyColor(void);
	bool __fastcall StoreReadOnlyColorOnFocus(void);
	bool __fastcall StoreParentColor(void);
	bool __fastcall StoreFlatButtonColor(void);
	bool __fastcall StoreFlatButtons(void);
	bool __fastcall StoreFrameColor(void);
	bool __fastcall StoreFrameHotColor(void);
	bool __fastcall StoreFrameHotTrack(void);
	bool __fastcall StoreFrameHotStyle(void);
	bool __fastcall StoreFrameSides(void);
	bool __fastcall StoreFrameStyle(void);
	bool __fastcall StoreFrameVisible(void);
	bool __fastcall StoreFramingPreference(void);
	virtual void __fastcall SetDisabledColor(Graphics::TColor Value);
	virtual void __fastcall SetFocusColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetFrameHotColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameHotTrack(bool Value);
	virtual void __fastcall SetFrameHotStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameSides(Rzcommon::TSides Value);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameVisible(bool Value);
	virtual void __fastcall SetFramingPreference(Rzcommon::TFramingPreference Value);
	HIDESBASE bool __fastcall GetReadOnly(void);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	virtual void __fastcall SetReadOnlyColor(Graphics::TColor Value);
	__property Graphics::TCanvas* Canvas = {read=FCanvas};
	
public:
	__fastcall virtual TRzDBMemo(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDBMemo(void);
	virtual bool __fastcall UseThemes(void);
	void __fastcall JumpTo(int ALine, int ACol);
	__property int Column = {read=GetColumn, write=SetColumn, nodefault};
	__property int Line = {read=GetLine, write=SetLine, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Color  = {stored=StoreColor, default=-16777211};
	__property Graphics::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, stored=StoreDisabledColor, default=-16777201};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, stored=StoreFocusColor, default=-16777211};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, stored=StoreFrameColor, default=-16777200};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Graphics::TColor FrameHotColor = {read=FFrameHotColor, write=SetFrameHotColor, stored=StoreFrameHotColor, default=-16777200};
	__property Rzcommon::TFrameStyle FrameHotStyle = {read=FFrameHotStyle, write=SetFrameHotStyle, stored=StoreFrameHotStyle, default=10};
	__property bool FrameHotTrack = {read=FFrameHotTrack, write=SetFrameHotTrack, stored=StoreFrameHotTrack, default=0};
	__property Rzcommon::TSides FrameSides = {read=FFrameSides, write=SetFrameSides, stored=StoreFrameSides, default=15};
	__property Rzcommon::TFrameStyle FrameStyle = {read=FFrameStyle, write=SetFrameStyle, stored=StoreFrameStyle, default=1};
	__property bool FrameVisible = {read=FFrameVisible, write=SetFrameVisible, stored=StoreFrameVisible, default=0};
	__property Rzcommon::TFramingPreference FramingPreference = {read=FFramingPreference, write=SetFramingPreference, stored=StoreFramingPreference, default=1};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Graphics::TColor ReadOnlyColor = {read=FReadOnlyColor, write=SetReadOnlyColor, stored=StoreReadOnlyColor, default=-16777192};
	__property bool ReadOnlyColorOnFocus = {read=FReadOnlyColorOnFocus, write=FReadOnlyColorOnFocus, stored=StoreReadOnlyColorOnFocus, default=0};
	__property bool TabOnEnter = {read=FTabOnEnter, write=FTabOnEnter, default=0};
	__property Rzedit::TLineColChangeEvent OnLineColChange = {read=FOnLineColChange, write=FOnLineColChange};
	__property Rzedit::TClipboardChangeEvent OnClipboardChange = {read=FOnClipboardChange, write=FOnClipboardChange};
	__property OnMouseWheel ;
	__property OnMouseWheelUp ;
	__property OnMouseWheelDown ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBMemo(HWND ParentWindow) : Dbctrls::TDBMemo(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzPaintMemo : public TRzPaintEdit 
{
	typedef TRzPaintEdit inherited;
	
private:
	TRzDBMemo* FEditControl;
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TRzPaintMemo(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TRzPaintMemo(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzPaintMemo(HWND ParentWindow) : TRzPaintEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDBRichEdit;
class PASCALIMPLEMENTATION TRzDBRichEdit : public Dbctrls::TDBRichEdit 
{
	typedef Dbctrls::TDBRichEdit inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FUpdatingColor;
	Graphics::TColor FDisabledColor;
	Graphics::TColor FReadOnlyColor;
	bool FReadOnlyColorOnFocus;
	Graphics::TColor FFocusColor;
	Graphics::TColor FNormalColor;
	Graphics::TColor FFrameColor;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	Graphics::TColor FFrameHotColor;
	bool FFrameHotTrack;
	Rzcommon::TFrameStyleEx FFrameHotStyle;
	Rzcommon::TSides FFrameSides;
	Rzcommon::TFrameStyleEx FFrameStyle;
	bool FFrameVisible;
	Rzcommon::TFramingPreference FFramingPreference;
	bool FTabOnEnter;
	Rzedit::TLineColChangeEvent FOnLineColChange;
	Rzedit::TClipboardChangeEvent FOnClipboardChange;
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameFocusStyleProp(Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	
protected:
	Graphics::TCanvas* FCanvas;
	bool FOverControl;
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall UpdateColors(void);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	virtual void __fastcall RepaintFrame(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall SelectionChange(void);
	DYNAMIC void __fastcall LineColChange(void);
	DYNAMIC void __fastcall ClipboardChange(void);
	DYNAMIC bool __fastcall DoMouseWheel(Classes::TShiftState Shift, int WheelDelta, const Types::TPoint &MousePos);
	virtual int __fastcall GetColumn(void);
	virtual void __fastcall SetColumn(int Value);
	virtual int __fastcall GetLine(void);
	virtual void __fastcall SetLine(int Value);
	bool __fastcall StoreColor(void);
	bool __fastcall StoreFocusColor(void);
	bool __fastcall StoreDisabledColor(void);
	bool __fastcall StoreReadOnlyColor(void);
	bool __fastcall StoreReadOnlyColorOnFocus(void);
	bool __fastcall StoreParentColor(void);
	bool __fastcall StoreFlatButtonColor(void);
	bool __fastcall StoreFlatButtons(void);
	bool __fastcall StoreFrameColor(void);
	bool __fastcall StoreFrameHotColor(void);
	bool __fastcall StoreFrameHotTrack(void);
	bool __fastcall StoreFrameHotStyle(void);
	bool __fastcall StoreFrameSides(void);
	bool __fastcall StoreFrameStyle(void);
	bool __fastcall StoreFrameVisible(void);
	bool __fastcall StoreFramingPreference(void);
	virtual void __fastcall SetDisabledColor(Graphics::TColor Value);
	virtual void __fastcall SetFocusColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetFrameHotColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameHotTrack(bool Value);
	virtual void __fastcall SetFrameHotStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameSides(Rzcommon::TSides Value);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameVisible(bool Value);
	virtual void __fastcall SetFramingPreference(Rzcommon::TFramingPreference Value);
	HIDESBASE bool __fastcall GetReadOnly(void);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	virtual void __fastcall SetReadOnlyColor(Graphics::TColor Value);
	__property Graphics::TCanvas* Canvas = {read=FCanvas};
	
public:
	__fastcall virtual TRzDBRichEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDBRichEdit(void);
	virtual bool __fastcall UseThemes(void);
	void __fastcall JumpTo(int ALine, int ACol);
	AnsiString __fastcall GetRtfData();
	__property int Column = {read=GetColumn, write=SetColumn, nodefault};
	__property int Line = {read=GetLine, write=SetLine, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Color  = {stored=StoreColor, default=-16777211};
	__property Graphics::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, stored=StoreDisabledColor, default=-16777201};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, stored=StoreFocusColor, default=-16777211};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, stored=StoreFrameColor, default=-16777200};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Graphics::TColor FrameHotColor = {read=FFrameHotColor, write=SetFrameHotColor, stored=StoreFrameHotColor, default=-16777200};
	__property Rzcommon::TFrameStyle FrameHotStyle = {read=FFrameHotStyle, write=SetFrameHotStyle, stored=StoreFrameHotStyle, default=10};
	__property bool FrameHotTrack = {read=FFrameHotTrack, write=SetFrameHotTrack, stored=StoreFrameHotTrack, default=0};
	__property Rzcommon::TSides FrameSides = {read=FFrameSides, write=SetFrameSides, stored=StoreFrameSides, default=15};
	__property Rzcommon::TFrameStyle FrameStyle = {read=FFrameStyle, write=SetFrameStyle, stored=StoreFrameStyle, default=1};
	__property bool FrameVisible = {read=FFrameVisible, write=SetFrameVisible, stored=StoreFrameVisible, default=0};
	__property Rzcommon::TFramingPreference FramingPreference = {read=FFramingPreference, write=SetFramingPreference, stored=StoreFramingPreference, default=1};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Graphics::TColor ReadOnlyColor = {read=FReadOnlyColor, write=SetReadOnlyColor, stored=StoreReadOnlyColor, default=-16777192};
	__property bool ReadOnlyColorOnFocus = {read=FReadOnlyColorOnFocus, write=FReadOnlyColorOnFocus, stored=StoreReadOnlyColorOnFocus, default=0};
	__property bool TabOnEnter = {read=FTabOnEnter, write=FTabOnEnter, default=0};
	__property Rzedit::TLineColChangeEvent OnLineColChange = {read=FOnLineColChange, write=FOnLineColChange};
	__property Rzedit::TClipboardChangeEvent OnClipboardChange = {read=FOnClipboardChange, write=FOnClipboardChange};
	__property OnMouseWheel ;
	__property OnMouseWheelUp ;
	__property OnMouseWheelDown ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBRichEdit(HWND ParentWindow) : Dbctrls::TDBRichEdit(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzdbedit */
using namespace Rzdbedit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzdbedit
