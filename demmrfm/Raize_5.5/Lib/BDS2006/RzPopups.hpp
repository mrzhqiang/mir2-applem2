// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzpopups.pas' rev: 10.00

#ifndef RzpopupsHPP
#define RzpopupsHPP

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
#include <Menus.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzpanel.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzpopups
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzCalendarColors;
class DELPHICLASS TRzCalendar;
#pragma option push -b-
enum TRzFirstDayOfWeek { fdowMonday, fdowTuesday, fdowWednesday, fdowThursday, fdowFriday, fdowSaturday, fdowSunday, fdowLocale };
#pragma option pop

#pragma option push -b-
enum TRzCalendarElement { ceYear, ceMonth, ceArrows, ceWeekNumbers, ceDaysOfWeek, ceFillDays, ceTodayButton, ceClearButton };
#pragma option pop

typedef Set<TRzCalendarElement, ceYear, ceClearButton>  TRzCalendarElements;

#pragma option push -b-
enum TRzCalendarArea { caYear, caMonth, caLeftArrow, caRightArrow, caWeekNumbers, caDays, caDaysOfWeek, caFillDays, caTodayButton, caClearButton };
#pragma option pop

typedef void __fastcall (__closure *TRzGetBoldDaysEvent)(System::TObject* Sender, Word Year, Word Month, unsigned &Bitmask);

typedef void __fastcall (__closure *TRzGetDayFormatEvent)(System::TObject* Sender, System::TDateTime DayDate, Word Year, Word Month, Word Day, Graphics::TColor &DayColor, Graphics::TColor &DayFontColor, Graphics::TFontStyles &DayFontStyle);

typedef void __fastcall (__closure *TRzGetWeekNumberEvent)(System::TObject* Sender, System::TDateTime WeekDate, int &WeekNumber);

typedef void __fastcall (__closure *TRzViewDateChangeEvent)(System::TObject* Sender, System::TDateTime ViewDate);

typedef void __fastcall (__closure *TRzCalendarTodayEvent)(System::TObject* Sender, bool &AllowChange);

typedef void __fastcall (__closure *TRzCalendarClearEvent)(System::TObject* Sender, bool &AllowClear);

typedef Types::TRect TRzCalendarAreas[10];

class PASCALIMPLEMENTATION TRzCalendar : public Rzpanel::TRzCustomPanel 
{
	typedef Rzpanel::TRzCustomPanel inherited;
	
private:
	Byte FFirstDay;
	TRzFirstDayOfWeek FFirstDayOfWeek;
	TRzCalendarElements FElements;
	TRzCalendarArea FPressedArea;
	TRzCalendarArea FOverArea;
	bool FShowDays;
	bool FIsPopup;
	#pragma pack(push,1)
	Types::TRect FMouseOverRect;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint FCharSize;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint FCellSize;
	#pragma pack(pop)
	System::TDateTime FDate;
	System::TDateTime FMinDate;
	System::TDateTime FMaxDate;
	Extctrls::TTimer* FTodayTimer;
	System::TDateTime FToday;
	System::TDateTime FViewDate;
	System::TDateTime FFirstDateInGrid;
	bool FForceUpdate;
	bool FClearClicked;
	bool FIgnoreClick;
	Graphics::TColor FButtonColor;
	Graphics::TColor FButtonFontColor;
	AnsiString FCaptionClearBtn;
	int FClearBtnWidth;
	AnsiString FCaptionTodayBtn;
	int FTodayBtnWidth;
	TRzCalendarColors* FCalendarColors;
	int FCounter;
	Menus::TPopupMenu* FMonthPopupMenu;
	Controls::TWinControl* FYearSpinner;
	bool FYearSpinnerVisible;
	bool FThemeAware;
	Classes::TNotifyEvent FOnChange;
	TRzGetBoldDaysEvent FOnGetBoldDays;
	TRzGetDayFormatEvent FOnGetDayFormat;
	TRzGetWeekNumberEvent FOnGetWeekNumber;
	TRzViewDateChangeEvent FOnViewDateChange;
	TRzCalendarTodayEvent FOnToday;
	TRzCalendarClearEvent FOnClear;
	bool __fastcall StoreMinDate(void);
	bool __fastcall StoreMaxDate(void);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	MESSAGE void __fastcall WMTimer(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	void __fastcall TodayTimerExpired(System::TObject* Sender);
	
protected:
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall CreateWnd(void);
	bool __fastcall ShowFocus(void);
	virtual void __fastcall Paint(void);
	int __fastcall GetMaxShortDayNameLength(void);
	void __fastcall CalcAreas(Types::TRect * Areas);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	void __fastcall AdjustForFont(void);
	void __fastcall CalcFontSize(void);
	virtual void __fastcall ConstrainedResize(int &MinWidth, int &MinHeight, int &MaxWidth, int &MaxHeight);
	virtual void __fastcall SetDate(System::TDateTime Value);
	int __fastcall DateInRange(System::TDateTime Value);
	bool __fastcall ViewMonthInRange(System::TDateTime Value);
	void __fastcall SetRange(TDate MinValue, TDate MaxValue);
	void __fastcall CreateMonthPopupMenu(void);
	void __fastcall DisplayMonthPopupMenu(int X, int Y);
	void __fastcall MonthPopupClickHandler(System::TObject* Sender);
	void __fastcall HideYearSpinner(void);
	void __fastcall ShowYearSpinner(void);
	void __fastcall YearSpinnerDecrementHandler(System::TObject* Sender, int Amount);
	void __fastcall YearSpinnerIncrementHandler(System::TObject* Sender, int Amount);
	void __fastcall UpdateHighlight(int X, int Y);
	System::TDateTime __fastcall InternalHitTest(const Types::TRect &R, const Types::TPoint &P);
	void __fastcall StartTimer(void);
	void __fastcall TimerExpired(void);
	void __fastcall StopTimer(void);
	HIDESBASEDYNAMIC void __fastcall Changed(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall GetBoldDays(Word Year, Word Month, unsigned &Bitmask);
	DYNAMIC bool __fastcall GetDayFormat(System::TDateTime DayDate, Word Year, Word Month, Word Day, Graphics::TColor &DayColor, Graphics::TColor &DayFontColor, Graphics::TFontStyles &DayFontStyle);
	DYNAMIC void __fastcall ViewDateChange(System::TDateTime ViewDate);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC bool __fastcall CanClear(void);
	DYNAMIC bool __fastcall CanGoToToday(void);
	virtual void __fastcall SetButtonColor(Graphics::TColor Value);
	virtual void __fastcall SetButtonFontColor(Graphics::TColor Value);
	virtual void __fastcall SetCalendarColors(TRzCalendarColors* Value);
	virtual void __fastcall SetCaptionClearBtn(const AnsiString Value);
	virtual void __fastcall SetCaptionTodayBtn(const AnsiString Value);
	virtual void __fastcall SetDateProperty(System::TDateTime Value);
	virtual void __fastcall SetMinDate(System::TDateTime Value);
	virtual void __fastcall SetMaxDate(System::TDateTime Value);
	virtual void __fastcall SetFirstDayOfWeek(TRzFirstDayOfWeek Value);
	virtual void __fastcall SetElements(TRzCalendarElements Value);
	virtual void __fastcall SetOverArea(TRzCalendarArea Value);
	virtual void __fastcall SetPressedArea(TRzCalendarArea Value);
	virtual void __fastcall SetShowDays(bool Value);
	virtual void __fastcall SetViewDate(System::TDateTime Value);
	virtual void __fastcall SetThemeAware(bool Value);
	
public:
	__fastcall virtual TRzCalendar(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCalendar(void);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	unsigned __fastcall DaysToBitmask(Byte * Days, const int Days_Size);
	System::TDateTime __fastcall HitTest(int X, int Y);
	bool __fastcall IsClear(void);
	void __fastcall Clear(void);
	void __fastcall Today(void);
	__property System::TDateTime ViewDate = {read=FViewDate, write=SetViewDate};
	__property bool IsPopup = {write=FIsPopup, nodefault};
	__property bool ClearClicked = {read=FClearClicked, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Graphics::TColor ButtonColor = {read=FButtonColor, write=SetButtonColor, default=-16777201};
	__property Graphics::TColor ButtonFontColor = {read=FButtonFontColor, write=SetButtonFontColor, default=-16777208};
	__property TRzCalendarColors* CalendarColors = {read=FCalendarColors, write=SetCalendarColors};
	__property AnsiString CaptionClearBtn = {read=FCaptionClearBtn, write=SetCaptionClearBtn};
	__property AnsiString CaptionTodayBtn = {read=FCaptionTodayBtn, write=SetCaptionTodayBtn};
	__property System::TDateTime Date = {read=FDate, write=SetDateProperty};
	__property System::TDateTime MinDate = {read=FMinDate, write=SetMinDate, stored=StoreMinDate};
	__property System::TDateTime MaxDate = {read=FMaxDate, write=SetMaxDate, stored=StoreMaxDate};
	__property TRzFirstDayOfWeek FirstDayOfWeek = {read=FFirstDayOfWeek, write=SetFirstDayOfWeek, default=7};
	__property TRzCalendarElements Elements = {read=FElements, write=SetElements, default=247};
	__property bool ShowDays = {read=FShowDays, write=SetShowDays, default=1};
	__property bool ThemeAware = {read=FThemeAware, write=SetThemeAware, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TRzGetBoldDaysEvent OnGetBoldDays = {read=FOnGetBoldDays, write=FOnGetBoldDays};
	__property TRzGetDayFormatEvent OnGetDayFormat = {read=FOnGetDayFormat, write=FOnGetDayFormat};
	__property TRzGetWeekNumberEvent OnGetWeekNumber = {read=FOnGetWeekNumber, write=FOnGetWeekNumber};
	__property TRzViewDateChangeEvent OnViewDateChange = {read=FOnViewDateChange, write=FOnViewDateChange};
	__property TRzCalendarTodayEvent OnToday = {read=FOnToday, write=FOnToday};
	__property TRzCalendarClearEvent OnClear = {read=FOnClear, write=FOnClear};
	__property Align  = {default=0};
	__property Alignment  = {default=2};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=1};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=8};
	__property BorderSides  = {default=15};
	__property BorderColor  = {default=-16777201};
	__property BorderHighlight  = {default=-16777196};
	__property BorderShadow  = {default=-16777200};
	__property BorderWidth  = {default=0};
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
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
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
	/* TWinControl.CreateParented */ inline __fastcall TRzCalendar(HWND ParentWindow) : Rzpanel::TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzCalendarColors : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FDays;
	Graphics::TColor FFillDays;
	Graphics::TColor FDaysOfWeek;
	Graphics::TColor FLines;
	Graphics::TColor FSelectedDateBack;
	Graphics::TColor FSelectedDateFore;
	Graphics::TColor FTodaysDateFrame;
	TRzCalendar* FCalendar;
	
protected:
	virtual Graphics::TColor __fastcall GetColor(int Index);
	virtual void __fastcall SetColor(int Index, Graphics::TColor Value);
	
public:
	__fastcall TRzCalendarColors(TRzCalendar* ACalendar);
	__fastcall virtual ~TRzCalendarColors(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TRzCalendar* Calendar = {read=FCalendar};
	__property Graphics::TColor Colors[int Index] = {read=GetColor, write=SetColor};
	
__published:
	__property Graphics::TColor Days = {read=GetColor, write=SetColor, index=0, default=-16777208};
	__property Graphics::TColor FillDays = {read=GetColor, write=SetColor, index=1, default=-16777200};
	__property Graphics::TColor DaysOfWeek = {read=GetColor, write=SetColor, index=2, default=-16777208};
	__property Graphics::TColor Lines = {read=GetColor, write=SetColor, index=3, default=-16777200};
	__property Graphics::TColor SelectedDateBack = {read=GetColor, write=SetColor, index=4, default=-16777203};
	__property Graphics::TColor SelectedDateFore = {read=GetColor, write=SetColor, index=5, default=-16777202};
	__property Graphics::TColor TodaysDateFrame = {read=GetColor, write=SetColor, index=6, default=128};
};


typedef void __fastcall (__closure *TRzInvalidDateEvent)(System::TObject* Sender, bool &KeepFocused, bool &KeepInvalidText, System::TDateTime &NewDate);

typedef void __fastcall (__closure *TRzInvalidTimeEvent)(System::TObject* Sender, bool &KeepFocused, bool &KeepInvalidText, System::TDateTime &NewTime);

class DELPHICLASS ERzCalendarError;
class PASCALIMPLEMENTATION ERzCalendarError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ERzCalendarError(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ERzCalendarError(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ERzCalendarError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ERzCalendarError(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ERzCalendarError(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ERzCalendarError(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ERzCalendarError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ERzCalendarError(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ERzCalendarError(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzClockFaceColors;
class DELPHICLASS TRzTimePicker;
class PASCALIMPLEMENTATION TRzTimePicker : public Rzpanel::TRzCustomPanel 
{
	typedef Rzpanel::TRzCustomPanel inherited;
	
private:
	TTime FTime;
	bool FTimeIsPM;
	bool FRestrictMinutes;
	int FRestrictMinutesBy;
	bool FForceUpdate;
	bool FIsPopup;
	#pragma pack(push,1)
	Types::TRect FTimeRect;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TRect FClockRect;
	#pragma pack(pop)
	int FRadius;
	#pragma pack(push,1)
	Types::TPoint FClockCenter;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TRect FAMRect;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TRect FPMRect;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TRect FSetRect;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint FCharSize;
	#pragma pack(pop)
	bool FMouseOverAM;
	bool FMouseOverPM;
	bool FMouseOverSet;
	bool FMouseOverClock;
	bool FPressingLeft;
	bool FPressingRight;
	AnsiString FFormat;
	AnsiString FCaptionAM;
	AnsiString FCaptionPM;
	AnsiString FCaptionSet;
	Graphics::TColor FButtonColor;
	Graphics::TColor FButtonFontColor;
	TRzClockFaceColors* FClockFaceColors;
	bool FShowSetButton;
	bool FShowTime;
	bool FShowHowToUseHint;
	AnsiString FHowToUseMsg;
	Controls::THintWindow* FHintWnd;
	Extctrls::TTimer* FTimer;
	int FLastMinute;
	bool FThemeAware;
	Classes::TNotifyEvent FOnChange;
	Classes::TNotifyEvent FOnSetBtnClick;
	Classes::TNotifyEvent FOnSetTime;
	void __fastcall CheckHintWindowHandler(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall DrawClock(const Types::TRect &Bounds, const Types::TPoint &CenterPoint, int Radius);
	void __fastcall CalcRects(void);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	void __fastcall AdjustForFont(void);
	void __fastcall CalcFontSize(void);
	virtual void __fastcall ConstrainedResize(int &MinWidth, int &MinHeight, int &MaxWidth, int &MaxHeight);
	Extended __fastcall NormalizedArcTan(const Extended Y, const Extended X);
	int __fastcall GetHourFromXY(int X, int Y);
	int __fastcall GetMinuteFromXY(int X, int Y, bool Restrict);
	Types::TRect __fastcall CalcHintRect(int MaxWidth, const AnsiString HintStr, Controls::THintWindow* HintWnd);
	void __fastcall DoHint(int X, int Y);
	void __fastcall ReleaseHintWindow(void);
	void __fastcall ChangeToAM(void);
	void __fastcall ChangeToPM(void);
	HIDESBASEDYNAMIC void __fastcall Changed(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall SetBtnClick(void);
	virtual void __fastcall SetButtonColor(Graphics::TColor Value);
	virtual void __fastcall SetButtonFontColor(Graphics::TColor Value);
	virtual void __fastcall SetCaptionAM(const AnsiString Value);
	virtual void __fastcall SetCaptionPM(const AnsiString Value);
	virtual void __fastcall SetCaptionSet(const AnsiString Value);
	virtual void __fastcall SetClockFaceColors(TRzClockFaceColors* Value);
	virtual void __fastcall SetFormat(const AnsiString Value);
	void __fastcall SetHour(int Value);
	void __fastcall SetMinutes(int Value);
	virtual void __fastcall SetTime(TTime Value);
	virtual void __fastcall SetShowSetButton(bool Value);
	virtual void __fastcall SetShowTime(bool Value);
	virtual void __fastcall SetThemeAware(bool Value);
	
public:
	__fastcall virtual TRzTimePicker(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzTimePicker(void);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	void __fastcall AdjustHour(__int64 DeltaHours);
	void __fastcall AdjustMinute(__int64 DeltaMinutes);
	bool __fastcall IsClear(void);
	void __fastcall Clear(void);
	__property bool IsPopup = {write=FIsPopup, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Graphics::TColor ButtonColor = {read=FButtonColor, write=SetButtonColor, default=-16777201};
	__property Graphics::TColor ButtonFontColor = {read=FButtonFontColor, write=SetButtonFontColor, default=-16777208};
	__property AnsiString CaptionAM = {read=FCaptionAM, write=SetCaptionAM};
	__property AnsiString CaptionPM = {read=FCaptionPM, write=SetCaptionPM};
	__property AnsiString CaptionSet = {read=FCaptionSet, write=SetCaptionSet};
	__property TRzClockFaceColors* ClockFaceColors = {read=FClockFaceColors, write=SetClockFaceColors};
	__property AnsiString Format = {read=FFormat, write=SetFormat};
	__property AnsiString HowToUseMsg = {read=FHowToUseMsg, write=FHowToUseMsg};
	__property int RestrictMinutesBy = {read=FRestrictMinutesBy, write=FRestrictMinutesBy, default=5};
	__property bool RestrictMinutes = {read=FRestrictMinutes, write=FRestrictMinutes, default=0};
	__property bool ShowHowToUseHint = {read=FShowHowToUseHint, write=FShowHowToUseHint, default=1};
	__property bool ShowSetButton = {read=FShowSetButton, write=SetShowSetButton, default=0};
	__property bool ShowTime = {read=FShowTime, write=SetShowTime, default=1};
	__property TTime Time = {read=FTime, write=SetTime};
	__property bool ThemeAware = {read=FThemeAware, write=SetThemeAware, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnSetBtnClick = {read=FOnSetBtnClick, write=FOnSetBtnClick};
	__property Classes::TNotifyEvent OnSetTime = {read=FOnSetTime, write=FOnSetTime};
	__property Align  = {default=0};
	__property Alignment  = {default=2};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=1};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=4};
	__property BorderSides  = {default=15};
	__property BorderColor  = {default=-16777201};
	__property BorderHighlight  = {default=-16777196};
	__property BorderShadow  = {default=-16777200};
	__property BorderWidth  = {default=0};
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
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
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
	/* TWinControl.CreateParented */ inline __fastcall TRzTimePicker(HWND ParentWindow) : Rzpanel::TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzClockFaceColors : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FFace;
	Graphics::TColor FHands;
	Graphics::TColor FNumbers;
	Graphics::TColor FHourTicks;
	Graphics::TColor FMinuteTicks;
	TRzTimePicker* FTimePicker;
	
protected:
	virtual Graphics::TColor __fastcall GetColor(int Index);
	virtual void __fastcall SetColor(int Index, Graphics::TColor Value);
	
public:
	__fastcall TRzClockFaceColors(TRzTimePicker* ATimePicker);
	__fastcall virtual ~TRzClockFaceColors(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TRzTimePicker* TimePicker = {read=FTimePicker};
	__property Graphics::TColor Colors[int Index] = {read=GetColor, write=SetColor};
	
__published:
	__property Graphics::TColor Face = {read=GetColor, write=SetColor, index=0, default=-16777201};
	__property Graphics::TColor Hands = {read=GetColor, write=SetColor, index=1, default=-16777208};
	__property Graphics::TColor Numbers = {read=GetColor, write=SetColor, index=2, default=-16777208};
	__property Graphics::TColor HourTicks = {read=GetColor, write=SetColor, index=3, default=-16777200};
	__property Graphics::TColor MinuteTicks = {read=GetColor, write=SetColor, index=4, default=-16777208};
};


class DELPHICLASS TRzCalculatorColors;
class DELPHICLASS TRzCalculator;
#pragma option push -b-
enum TRzCalculatorArea { ccBtn0, ccBtn1, ccBtn2, ccBtn3, ccBtn4, ccBtn5, ccBtn6, ccBtn7, ccBtn8, ccBtn9, ccDecimal, ccAdd, ccSubtract, ccMultiply, ccDivide, ccClear, ccEqual, ccSet, ccValue };
#pragma option pop

#pragma option push -b-
enum TRzCalculatorOperation { calcNone, calcAdd, calcSubtract, calcMultiply, calcDivide };
#pragma option pop

typedef Types::TRect TRzCalculatorAreas[19];

#pragma option push -b-
enum TRzCalculatorUpdateDisplay { udNumber, udResult };
#pragma option pop

class PASCALIMPLEMENTATION TRzCalculator : public Rzpanel::TRzCustomPanel 
{
	typedef Rzpanel::TRzCustomPanel inherited;
	
private:
	TRzCalculatorArea FPressedArea;
	TRzCalculatorArea FOverArea;
	bool FIsPopup;
	#pragma pack(push,1)
	Types::TRect FMouseOverRect;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint FCharSize;
	#pragma pack(pop)
	Extended FNumber;
	int FDecimalPlaces;
	TRzCalculatorOperation FCurrentOperation;
	Extended FResult;
	bool FFirstDigit;
	bool FFirstNumber;
	bool FShowResult;
	bool FErrorOccurred;
	bool FBoldButtons;
	TRzCalculatorColors* FCalculatorColors;
	bool FThemeAware;
	Classes::TNotifyEvent FOnChange;
	Classes::TNotifyEvent FOnSetBtnClick;
	int __fastcall GetIntResult(void);
	void __fastcall SetIntResult(int Value);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	
protected:
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall DrawDisplayBox(const Types::TRect &Bounds, Graphics::TColor FrameColor);
	Graphics::TColor __fastcall GetButtonColor(TRzCalculatorArea Area);
	Graphics::TColor __fastcall GetButtonFontColor(TRzCalculatorArea Area);
	virtual void __fastcall DrawCalcButton(const Types::TRect &Bounds, TRzCalculatorArea Area);
	virtual void __fastcall Paint(void);
	void __fastcall CalcAreas(Types::TRect * Areas);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	void __fastcall AdjustForFont(void);
	void __fastcall CalcFontSize(void);
	virtual void __fastcall ConstrainedResize(int &MinWidth, int &MinHeight, int &MaxWidth, int &MaxHeight);
	void __fastcall PrepareForUserInput(void);
	void __fastcall PrepareForOperator(void);
	void __fastcall UpdateDisplay(TRzCalculatorUpdateDisplay Update);
	void __fastcall ShowError(void);
	void __fastcall AppendDigit(int N);
	void __fastcall DecimalPressed(void);
	void __fastcall OperationPressed(TRzCalculatorOperation Operation);
	void __fastcall EqualPressed(void);
	void __fastcall CalculateNewResult(void);
	virtual void __fastcall SetResult(Extended Value);
	HIDESBASEDYNAMIC void __fastcall Changed(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall SetBtnClick(void);
	virtual void __fastcall SetBoldButtons(bool Value);
	virtual void __fastcall SetCalculatorColors(TRzCalculatorColors* Value);
	virtual void __fastcall SetOverArea(TRzCalculatorArea Value);
	virtual void __fastcall SetPressedArea(TRzCalculatorArea Value);
	virtual void __fastcall SetThemeAware(bool Value);
	
public:
	__fastcall virtual TRzCalculator(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCalculator(void);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	TRzCalculatorArea __fastcall HitTest(int X, int Y);
	void __fastcall Clear(void);
	__property bool IsPopup = {write=FIsPopup, nodefault};
	__property int IntResult = {read=GetIntResult, write=SetIntResult, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool BoldButtons = {read=FBoldButtons, write=SetBoldButtons, default=0};
	__property TRzCalculatorColors* CalculatorColors = {read=FCalculatorColors, write=SetCalculatorColors};
	__property Extended Result = {read=FResult, write=SetResult};
	__property bool ThemeAware = {read=FThemeAware, write=SetThemeAware, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnSetBtnClick = {read=FOnSetBtnClick, write=FOnSetBtnClick};
	__property Align  = {default=0};
	__property Alignment  = {default=2};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=1};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=8};
	__property BorderSides  = {default=15};
	__property BorderColor  = {default=-16777201};
	__property BorderHighlight  = {default=-16777196};
	__property BorderShadow  = {default=-16777200};
	__property BorderWidth  = {default=0};
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
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
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
	/* TWinControl.CreateParented */ inline __fastcall TRzCalculator(HWND ParentWindow) : Rzpanel::TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzCalculatorColors : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FNumberFont;
	Graphics::TColor FNumberBtns;
	Graphics::TColor FOperatorFont;
	Graphics::TColor FOperatorBtns;
	Graphics::TColor FCommandFont;
	Graphics::TColor FCommandBtns;
	Graphics::TColor FDisplayFont;
	Graphics::TColor FDisplay;
	TRzCalculator* FCalculator;
	
protected:
	virtual Graphics::TColor __fastcall GetColor(int Index);
	virtual void __fastcall SetColor(int Index, Graphics::TColor Value);
	
public:
	__fastcall TRzCalculatorColors(TRzCalculator* ACalculator);
	__fastcall virtual ~TRzCalculatorColors(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TRzCalculator* Calculator = {read=FCalculator};
	__property Graphics::TColor Colors[int Index] = {read=GetColor, write=SetColor};
	
__published:
	__property Graphics::TColor NumberFont = {read=GetColor, write=SetColor, index=0, default=-16777208};
	__property Graphics::TColor NumberBtns = {read=GetColor, write=SetColor, index=1, default=-16777201};
	__property Graphics::TColor OperatorFont = {read=GetColor, write=SetColor, index=2, default=-16777208};
	__property Graphics::TColor OperatorBtns = {read=GetColor, write=SetColor, index=3, default=-16777201};
	__property Graphics::TColor CommandFont = {read=GetColor, write=SetColor, index=4, default=-16777208};
	__property Graphics::TColor CommandBtns = {read=GetColor, write=SetColor, index=5, default=-16777201};
	__property Graphics::TColor DisplayFont = {read=GetColor, write=SetColor, index=6, default=-16777208};
	__property Graphics::TColor Display = {read=GetColor, write=SetColor, index=7, default=-16777211};
};


class DELPHICLASS TRzCustomPopup;
class PASCALIMPLEMENTATION TRzCustomPopup : public Rzpanel::TRzCustomPanel 
{
	typedef Rzpanel::TRzCustomPanel inherited;
	
private:
	Controls::TControl* FPopupControl;
	
protected:
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TRzCustomPopup(Classes::TComponent* AOwner);
	__property Controls::TControl* PopupControl = {read=FPopupControl};
	
__published:
	__property BevelWidth  = {default=1};
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=6};
	__property BorderColor  = {default=-16777201};
	__property BorderHighlight  = {default=-16777196};
	__property BorderShadow  = {default=-16777200};
	__property BorderWidth  = {default=0};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=0};
public:
	#pragma option push -w-inl
	/* TRzCustomPanel.Destroy */ inline __fastcall virtual ~TRzCustomPopup(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomPopup(HWND ParentWindow) : Rzpanel::TRzCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzPopupPanel;
class PASCALIMPLEMENTATION TRzPopupPanel : public TRzCustomPopup 
{
	typedef TRzCustomPopup inherited;
	
private:
	Controls::TWinControl* FPopup;
	Classes::TNotifyEvent FOnClose;
	Classes::TNotifyEvent FOnPopup;
	
protected:
	virtual void __fastcall DestroyWnd(void);
	DYNAMIC void __fastcall DoClose(void);
	DYNAMIC void __fastcall DoPopup(void);
	bool __fastcall GetActive(void);
	
public:
	__fastcall virtual TRzPopupPanel(Classes::TComponent* AOwner);
	void __fastcall Close(System::TObject* Sender = (System::TObject*)(0x0));
	bool __fastcall Popup(Controls::TControl* PopupControl)/* overload */;
	bool __fastcall Popup(Controls::TControl* PopupControl, int X, int Y)/* overload */;
	__property bool Active = {read=GetActive, nodefault};
	
__published:
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property Classes::TNotifyEvent OnPopup = {read=FOnPopup, write=FOnPopup};
	__property Alignment  = {default=1};
	__property AutoSize  = {default=1};
	__property BiDiMode ;
	__property ParentBiDiMode  = {default=1};
	__property Color  = {default=-16777201};
	__property Ctl3D ;
	__property Enabled  = {default=1};
	__property Font ;
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property OnContextPopup ;
public:
	#pragma option push -w-inl
	/* TRzCustomPanel.Destroy */ inline __fastcall virtual ~TRzPopupPanel(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzPopupPanel(HWND ParentWindow) : TRzCustomPopup(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _sRzHowToSelectTime;
#define Rzpopups_sRzHowToSelectTime System::LoadResourceString(&Rzpopups::_sRzHowToSelectTime)
extern PACKAGE System::ResourceString _sRzCaptionAM;
#define Rzpopups_sRzCaptionAM System::LoadResourceString(&Rzpopups::_sRzCaptionAM)
extern PACKAGE System::ResourceString _sRzCaptionPM;
#define Rzpopups_sRzCaptionPM System::LoadResourceString(&Rzpopups::_sRzCaptionPM)
extern PACKAGE System::ResourceString _sRzCaptionSet;
#define Rzpopups_sRzCaptionSet System::LoadResourceString(&Rzpopups::_sRzCaptionSet)
extern PACKAGE System::ResourceString _sRzCaptionClearBtn;
#define Rzpopups_sRzCaptionClearBtn System::LoadResourceString(&Rzpopups::_sRzCaptionClearBtn)
extern PACKAGE System::ResourceString _sRzCaptionTodayBtn;
#define Rzpopups_sRzCaptionTodayBtn System::LoadResourceString(&Rzpopups::_sRzCaptionTodayBtn)
extern PACKAGE System::ResourceString _sRzDateMax;
#define Rzpopups_sRzDateMax System::LoadResourceString(&Rzpopups::_sRzDateMax)
extern PACKAGE System::ResourceString _sRzDateMin;
#define Rzpopups_sRzDateMin System::LoadResourceString(&Rzpopups::_sRzDateMin)
extern PACKAGE System::ResourceString _sRzDateRange;
#define Rzpopups_sRzDateRange System::LoadResourceString(&Rzpopups::_sRzDateRange)
extern PACKAGE bool __fastcall StrToDateEx(const AnsiString S, System::TDateTime &DateTime);
extern PACKAGE bool __fastcall StrToTimeEx(const AnsiString S, System::TDateTime &DateTime);

}	/* namespace Rzpopups */
using namespace Rzpopups;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzpopups
