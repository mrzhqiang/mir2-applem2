// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzlabel.pas' rev: 10.00

#ifndef RzlabelHPP
#define RzlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzlabel
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TRotation { roNone, roFlat, roCurve };
#pragma option pop

#pragma option push -b-
enum TCenterPoint { cpUpperLeft, cpUpperCenter, cpUpperRight, cpLeftCenter, cpCenter, cpRightCenter, cpLowerLeft, cpLowerCenter, cpLowerRight };
#pragma option pop

#pragma option push -b-
enum TRzCondenseCaption { ccNone, ccAtEnd, ccWithinPath };
#pragma option pop

class DELPHICLASS TRzLabel;
class PASCALIMPLEMENTATION TRzLabel : public Stdctrls::TLabel 
{
	typedef Stdctrls::TLabel inherited;
	
private:
	int FAngle;
	Graphics::TColor FBlinkColor;
	Rzcommon::TBlinkState FBlinkState;
	bool FBlinking;
	int FBevelWidth;
	Rzcommon::TFrameStyleEx FBorderInner;
	Rzcommon::TFrameStyleEx FBorderOuter;
	Rzcommon::TSides FBorderSides;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderHighlight;
	Graphics::TColor FBorderShadow;
	int FBorderWidth;
	Graphics::TColor FFlatColor;
	int FFlatColorAdjustment;
	Graphics::TColor FFontColor;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	TCenterPoint FCenterPoint;
	Graphics::TColor FOrigColor;
	bool FInitColor;
	bool FFlyByEnabled;
	Graphics::TColor FFlyByColor;
	bool FLightTextStyle;
	Rzcommon::TTextStyle FTextStyle;
	TRotation FRotation;
	Graphics::TColor FHighlightColor;
	Graphics::TColor FShadowColor;
	int FShadowDepth;
	int FTextMargin;
	TRzCondenseCaption FCondenseCaption;
	MESSAGE void __fastcall CMGetBlinking(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMBlink(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Graphics::TColor FCurrentColor;
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CustomFramingChanged(void);
	virtual void __fastcall Blink(Rzcommon::TBlinkState State);
	virtual AnsiString __fastcall GetLabelText();
	virtual void __fastcall AdjustForBorders(Types::TRect &R);
	DYNAMIC void __fastcall AdjustBounds(void);
	Types::TPoint __fastcall CalcCenterPoint();
	Types::TPoint __fastcall CalcRadius();
	virtual void __fastcall FixClientRect(Types::TRect &Rect, bool ShrinkByBorder);
	void __fastcall DrawArcText(void);
	void __fastcall AdjustForLayout(unsigned Flags, Types::TRect &R);
	void __fastcall Draw3DText(void);
	virtual void __fastcall SetAngle(int Value);
	virtual void __fastcall SetBlinking(bool Value);
	virtual void __fastcall SetBlinkColor(Graphics::TColor Value);
	virtual Word __fastcall GetBlinkIntervalOff(void);
	virtual void __fastcall SetBlinkIntervalOff(Word Value);
	virtual Word __fastcall GetBlinkIntervalOn(void);
	virtual void __fastcall SetBlinkIntervalOn(Word Value);
	virtual void __fastcall SetBevelWidth(int Value);
	virtual void __fastcall SetBorderColor(Graphics::TColor Value);
	virtual void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderSides(Rzcommon::TSides Value);
	virtual void __fastcall SetBorderHighlight(Graphics::TColor Value);
	virtual void __fastcall SetBorderShadow(Graphics::TColor Value);
	virtual void __fastcall SetBorderWidth(int Value);
	virtual void __fastcall SetCondenseCaption(TRzCondenseCaption Value);
	virtual void __fastcall SetFlatColor(Graphics::TColor Value);
	virtual void __fastcall SetFlatColorAdjustment(int Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetCenterPoint(TCenterPoint Value);
	virtual void __fastcall SetFlyByColor(Graphics::TColor Value);
	virtual void __fastcall SetFlyByEnabled(bool Value);
	virtual Stdctrls::TTextLayout __fastcall GetLayout(void);
	HIDESBASE virtual void __fastcall SetLayout(Stdctrls::TTextLayout Value);
	virtual void __fastcall SetLightTextStyle(bool Value);
	virtual void __fastcall SetRotation(TRotation Value);
	virtual void __fastcall SetTextMargin(int Value);
	virtual void __fastcall SetTextStyle(Rzcommon::TTextStyle Value);
	virtual void __fastcall SetHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetShadowColor(Graphics::TColor Value);
	virtual void __fastcall SetShadowDepth(int Value);
	
public:
	__fastcall virtual TRzLabel(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzLabel(void);
	__property Rzcommon::TBlinkState BlinkState = {read=FBlinkState, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property int Angle = {read=FAngle, write=SetAngle, default=0};
	__property bool Blinking = {read=FBlinking, write=SetBlinking, default=0};
	__property Graphics::TColor BlinkColor = {read=FBlinkColor, write=SetBlinkColor, default=-16777203};
	__property Word BlinkIntervalOff = {read=GetBlinkIntervalOff, write=SetBlinkIntervalOff, default=500};
	__property Word BlinkIntervalOn = {read=GetBlinkIntervalOn, write=SetBlinkIntervalOn, default=500};
	__property int BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=1};
	__property Rzcommon::TFrameStyleEx BorderInner = {read=FBorderInner, write=SetBorderInner, default=0};
	__property Rzcommon::TFrameStyleEx BorderOuter = {read=FBorderOuter, write=SetBorderOuter, default=0};
	__property Rzcommon::TSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777201};
	__property Graphics::TColor BorderHighlight = {read=FBorderHighlight, write=SetBorderHighlight, default=-16777196};
	__property Graphics::TColor BorderShadow = {read=FBorderShadow, write=SetBorderShadow, default=-16777200};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property TRzCondenseCaption CondenseCaption = {read=FCondenseCaption, write=SetCondenseCaption, default=0};
	__property Graphics::TColor FlatColor = {read=FFlatColor, write=SetFlatColor, default=-16777200};
	__property int FlatColorAdjustment = {read=FFlatColorAdjustment, write=SetFlatColorAdjustment, default=30};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property TCenterPoint CenterPoint = {read=FCenterPoint, write=SetCenterPoint, default=4};
	__property Graphics::TColor FlyByColor = {read=FFlyByColor, write=SetFlyByColor, default=-16777203};
	__property bool FlyByEnabled = {read=FFlyByEnabled, write=SetFlyByEnabled, default=0};
	__property Stdctrls::TTextLayout Layout = {read=GetLayout, write=SetLayout, default=0};
	__property bool LightTextStyle = {read=FLightTextStyle, write=SetLightTextStyle, default=0};
	__property TRotation Rotation = {read=FRotation, write=SetRotation, default=0};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=SetHighlightColor, default=-16777196};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-16777200};
	__property int ShadowDepth = {read=FShadowDepth, write=SetShadowDepth, default=2};
	__property int TextMargin = {read=FTextMargin, write=SetTextMargin, default=0};
	__property Rzcommon::TTextStyle TextStyle = {read=FTextStyle, write=SetTextStyle, default=0};
	__property Color  = {default=-16777201};
private:
	void *__IRzCustomFramingNotification;	/* Rzcommon::IRzCustomFramingNotification */
	
public:
	operator IRzCustomFramingNotification*(void) { return (IRzCustomFramingNotification*)&__IRzCustomFramingNotification; }
	
};


class DELPHICLASS TRzURLLabel;
class PASCALIMPLEMENTATION TRzURLLabel : public TRzLabel 
{
	typedef TRzLabel inherited;
	
private:
	AnsiString FURL;
	bool FVisited;
	Graphics::TColor FUnvisitedColor;
	Graphics::TColor FVisitedColor;
	
protected:
	virtual void __fastcall UpdateFontColor(void);
	virtual void __fastcall SetVisited(bool Value);
	virtual void __fastcall SetUnvisitedColor(Graphics::TColor Value);
	virtual void __fastcall SetVisitedColor(Graphics::TColor Value);
	
public:
	__fastcall virtual TRzURLLabel(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property AnsiString URL = {read=FURL, write=FURL};
	__property Graphics::TColor UnvisitedColor = {read=FUnvisitedColor, write=SetUnvisitedColor, default=-16777203};
	__property bool Visited = {read=FVisited, write=SetVisited, default=0};
	__property Graphics::TColor VisitedColor = {read=FVisitedColor, write=SetVisitedColor, default=8388736};
	__property Cursor  = {default=26000};
	__property TextStyle  = {default=0};
public:
	#pragma option push -w-inl
	/* TRzLabel.Destroy */ inline __fastcall virtual ~TRzURLLabel(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word crRzHandPoint = 0x6590;
extern PACKAGE Word CondenseCaptionFlags[3];

}	/* namespace Rzlabel */
using namespace Rzlabel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzlabel
