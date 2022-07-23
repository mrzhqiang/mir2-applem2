// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzdtp.pas' rev: 10.00

#ifndef RzdtpHPP
#define RzdtpHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzdtp
{
//-- type declarations -------------------------------------------------------
typedef Shortint TRzDTPDropRange;

class DELPHICLASS TRzMonthCalColors;
class DELPHICLASS TRzDateTimePicker;
class PASCALIMPLEMENTATION TRzDateTimePicker : public Comctrls::TDateTimePicker 
{
	typedef Comctrls::TDateTimePicker inherited;
	
private:
	bool FFlatButtons;
	Graphics::TColor FFlatButtonColor;
	bool FUpdatingColor;
	Graphics::TColor FDisabledColor;
	Graphics::TColor FFocusColor;
	Graphics::TColor FNormalColor;
	Graphics::TColor FFrameColor;
	Rzcommon::TRzFrameController* FFrameController;
	Graphics::TColor FFrameHotColor;
	bool FFrameHotTrack;
	Rzcommon::TFrameStyleEx FFrameHotStyle;
	Rzcommon::TSides FFrameSides;
	Rzcommon::TFrameStyleEx FFrameStyle;
	bool FFrameVisible;
	Rzcommon::TFramingPreference FFramingPreference;
	bool FShowToday;
	bool FShowTodayCircle;
	bool FShowWeekNumbers;
	TRzDTPDropRange FDropColumns;
	TRzDTPDropRange FDropRows;
	AnsiString FFormat;
	TRzMonthCalColors* FInternalCalColors;
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
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Msg);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Graphics::TCanvas* FCanvas;
	bool FInControl;
	bool FOverControl;
	AnsiString FSaveFormat;
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall UpdateColors(void);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	virtual void __fastcall RepaintFrame(void);
	virtual Types::TRect __fastcall GetEditRect();
	virtual AnsiString __fastcall GetRightJustifiedText();
	HIDESBASE void __fastcall SetCalColors(TRzMonthCalColors* Value);
	virtual void __fastcall SetFlatButtons(bool Value);
	virtual void __fastcall SetFlatButtonColor(Graphics::TColor Value);
	HIDESBASE virtual void __fastcall SetFormat(const AnsiString Value);
	bool __fastcall StoreColor(void);
	bool __fastcall StoreFocusColor(void);
	bool __fastcall NotUsingController(void);
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
	__property Graphics::TCanvas* Canvas = {read=FCanvas};
	
public:
	__fastcall virtual TRzDateTimePicker(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDateTimePicker(void);
	virtual bool __fastcall UseThemes(void);
	HIDESBASE void __fastcall PaintTo(HDC DC, int X, int Y);
	bool __fastcall UpdateCalColors(int ColorIndex, Graphics::TColor ColorValue);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property TRzMonthCalColors* CalColors = {read=FInternalCalColors, write=SetCalColors};
	__property Color  = {stored=StoreColor, default=-16777211};
	__property TRzDTPDropRange DropColumns = {read=FDropColumns, write=FDropColumns, default=1};
	__property TRzDTPDropRange DropRows = {read=FDropRows, write=FDropRows, default=1};
	__property Graphics::TColor FlatButtonColor = {read=FFlatButtonColor, write=SetFlatButtonColor, stored=NotUsingController, default=-16777201};
	__property bool FlatButtons = {read=FFlatButtons, write=SetFlatButtons, stored=NotUsingController, default=0};
	__property AnsiString Format = {read=FFormat, write=SetFormat};
	__property Graphics::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, stored=NotUsingController, default=-16777201};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, stored=StoreFocusColor, default=-16777211};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, stored=NotUsingController, default=-16777200};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Graphics::TColor FrameHotColor = {read=FFrameHotColor, write=SetFrameHotColor, stored=NotUsingController, default=-16777200};
	__property Rzcommon::TFrameStyle FrameHotStyle = {read=FFrameHotStyle, write=SetFrameHotStyle, stored=NotUsingController, default=10};
	__property bool FrameHotTrack = {read=FFrameHotTrack, write=SetFrameHotTrack, stored=NotUsingController, default=0};
	__property Rzcommon::TSides FrameSides = {read=FFrameSides, write=SetFrameSides, stored=NotUsingController, default=15};
	__property Rzcommon::TFrameStyle FrameStyle = {read=FFrameStyle, write=SetFrameStyle, stored=NotUsingController, default=1};
	__property bool FrameVisible = {read=FFrameVisible, write=SetFrameVisible, stored=NotUsingController, default=0};
	__property Rzcommon::TFramingPreference FramingPreference = {read=FFramingPreference, write=SetFramingPreference, default=1};
	__property bool ShowToday = {read=FShowToday, write=FShowToday, default=0};
	__property bool ShowTodayCircle = {read=FShowTodayCircle, write=FShowTodayCircle, default=0};
	__property bool ShowWeekNumbers = {read=FShowWeekNumbers, write=FShowWeekNumbers, default=0};
	__property FirstDayOfWeek  = {default=7};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDateTimePicker(HWND ParentWindow) : Comctrls::TDateTimePicker(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzMonthCalColors : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TRzDateTimePicker* Owner;
	Graphics::TColor FBackColor;
	Graphics::TColor FTextColor;
	Graphics::TColor FTitleBackColor;
	Graphics::TColor FTitleTextColor;
	Graphics::TColor FMonthBackColor;
	Graphics::TColor FTrailingTextColor;
	
public:
	__fastcall TRzMonthCalColors(TRzDateTimePicker* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall SetColor(int Index, Graphics::TColor Value);
	void __fastcall SetAllColors(void);
	
__published:
	__property Graphics::TColor BackColor = {read=FBackColor, write=SetColor, index=0, default=-16777211};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetColor, index=1, default=-16777208};
	__property Graphics::TColor TitleBackColor = {read=FTitleBackColor, write=SetColor, index=2, default=-16777214};
	__property Graphics::TColor TitleTextColor = {read=FTitleTextColor, write=SetColor, index=3, default=-16777207};
	__property Graphics::TColor MonthBackColor = {read=FMonthBackColor, write=SetColor, index=4, default=-16777211};
	__property Graphics::TColor TrailingTextColor = {read=FTrailingTextColor, write=SetColor, index=5, default=8421504};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRzMonthCalColors(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzdtp */
using namespace Rzdtp;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzdtp
