// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzprgres.pas' rev: 10.00

#ifndef RzprgresHPP
#define RzprgresHPP

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
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzprgres
{
//-- type declarations -------------------------------------------------------
typedef Shortint TSegmentRange;

typedef int TUnsignedLongint;

typedef void __fastcall (__closure *TProgressChangeEvent)(System::TObject* Sender, int Percent);

class DELPHICLASS TRzCustomProgressBar;
class PASCALIMPLEMENTATION TRzCustomProgressBar : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Graphics::TColor FBackColor;
	Graphics::TColor FBackColorStop;
	Graphics::TColor FBarColor;
	Graphics::TColor FBarColorStop;
	Rzcommon::TBarStyle FBarStyle;
	Controls::TBevelWidth FBevelWidth;
	Graphics::TColor FBorderColor;
	Rzcommon::TFrameStyleEx FBorderInner;
	Rzcommon::TFrameStyleEx FBorderOuter;
	Controls::TBorderWidth FBorderWidth;
	Graphics::TColor FFlatColor;
	int FFlatColorAdjustment;
	Rzcommon::TGradientDirection FGradientDirection;
	Byte FInteriorOffset;
	TSegmentRange FNumSegments;
	Rzcommon::TOrientation FOrientation;
	TUnsignedLongint FPartsComplete;
	Word FPercent;
	bool FShowPercent;
	bool FShowParts;
	TUnsignedLongint FTotalParts;
	bool FThemeAware;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	TProgressChangeEvent FOnChange;
	HIDESBASE MESSAGE void __fastcall CMHitTest(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CustomFramingChanged(void);
	DYNAMIC void __fastcall PercentChanged(void);
	virtual void __fastcall SetBackColor(Graphics::TColor Value);
	void __fastcall SetBackColorStop(Graphics::TColor Value);
	virtual void __fastcall SetBarColor(Graphics::TColor Value);
	void __fastcall SetBarColorStop(Graphics::TColor Value);
	virtual void __fastcall SetBarStyle(Rzcommon::TBarStyle Value);
	virtual void __fastcall SetBevelWidth(Controls::TBevelWidth Value);
	virtual void __fastcall SetBorderColor(Graphics::TColor Value);
	virtual void __fastcall SetBorderInner(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderOuter(Rzcommon::TFrameStyleEx Value);
	virtual void __fastcall SetBorderWidth(Controls::TBorderWidth Value);
	virtual void __fastcall SetFlatColor(Graphics::TColor Value);
	virtual void __fastcall SetFlatColorAdjustment(int Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	void __fastcall SetGradientDirection(Rzcommon::TGradientDirection Value);
	virtual void __fastcall SetInteriorOffset(Byte Value);
	virtual void __fastcall SetNumSegments(TSegmentRange Value);
	virtual void __fastcall SetOrientation(Rzcommon::TOrientation Value);
	virtual void __fastcall SetPartsComplete(TUnsignedLongint Value);
	virtual void __fastcall SetPercent(Word Value);
	virtual void __fastcall SetShowPercent(bool Value);
	virtual void __fastcall SetShowParts(bool Value);
	virtual void __fastcall SetTotalParts(TUnsignedLongint Value);
	virtual void __fastcall SetThemeAware(bool Value);
	__property Graphics::TColor BackColor = {read=FBackColor, write=SetBackColor, default=16777215};
	__property Graphics::TColor BackColorStop = {read=FBackColorStop, write=SetBackColorStop, default=-16777201};
	__property Graphics::TColor BarColor = {read=FBarColor, write=SetBarColor, default=-16777203};
	__property Graphics::TColor BarColorStop = {read=FBarColorStop, write=SetBarColorStop, default=-16777190};
	__property Rzcommon::TBarStyle BarStyle = {read=FBarStyle, write=SetBarStyle, default=0};
	__property Controls::TBevelWidth BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=1};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777201};
	__property Rzcommon::TFrameStyleEx BorderInner = {read=FBorderInner, write=SetBorderInner, default=0};
	__property Rzcommon::TFrameStyleEx BorderOuter = {read=FBorderOuter, write=SetBorderOuter, default=4};
	__property Controls::TBorderWidth BorderWidth = {read=FBorderWidth, write=SetBorderWidth, nodefault};
	__property Graphics::TColor FlatColor = {read=FFlatColor, write=SetFlatColor, default=-16777200};
	__property int FlatColorAdjustment = {read=FFlatColorAdjustment, write=SetFlatColorAdjustment, default=30};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Rzcommon::TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=3};
	__property Byte InteriorOffset = {read=FInteriorOffset, write=SetInteriorOffset, nodefault};
	__property TSegmentRange NumSegments = {read=FNumSegments, write=SetNumSegments, default=20};
	__property Rzcommon::TOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property TUnsignedLongint PartsComplete = {read=FPartsComplete, write=SetPartsComplete, nodefault};
	__property Word Percent = {read=FPercent, write=SetPercent, nodefault};
	__property bool ShowPercent = {read=FShowPercent, write=SetShowPercent, default=1};
	__property bool ShowParts = {read=FShowParts, write=SetShowParts, default=0};
	__property TUnsignedLongint TotalParts = {read=FTotalParts, write=SetTotalParts, nodefault};
	__property bool ThemeAware = {read=FThemeAware, write=SetThemeAware, default=1};
	__property TProgressChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall virtual TRzCustomProgressBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomProgressBar(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	bool __fastcall UseThemes(void);
	__property Align  = {default=0};
	__property Font ;
	__property Height  = {default=24};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property Visible  = {default=1};
	__property Width  = {default=200};
	__property OnClick ;
	__property OnDblClick ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
private:
	void *__IRzCustomFramingNotification;	/* Rzcommon::IRzCustomFramingNotification */
	
public:
	operator IRzCustomFramingNotification*(void) { return (IRzCustomFramingNotification*)&__IRzCustomFramingNotification; }
	
};


class DELPHICLASS TRzProgressBar;
class PASCALIMPLEMENTATION TRzProgressBar : public TRzCustomProgressBar 
{
	typedef TRzCustomProgressBar inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	
public:
	void __fastcall IncPartsByOne(void);
	void __fastcall IncParts(TUnsignedLongint N);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property BackColor  = {default=16777215};
	__property BackColorStop  = {default=-16777201};
	__property BarColor  = {default=-16777203};
	__property BarColorStop  = {default=-16777190};
	__property BarStyle  = {default=0};
	__property BevelWidth  = {default=1};
	__property BorderColor  = {default=-16777201};
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=4};
	__property BorderWidth ;
	__property Constraints ;
	__property DragKind  = {default=0};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=30};
	__property Font ;
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property GradientDirection  = {default=3};
	__property Height  = {default=24};
	__property InteriorOffset ;
	__property NumSegments  = {default=20};
	__property Orientation  = {default=0};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PartsComplete ;
	__property Percent ;
	__property PopupMenu ;
	__property ShowHint ;
	__property ShowParts  = {default=0};
	__property ShowPercent  = {default=1};
	__property ThemeAware  = {default=1};
	__property TotalParts ;
	__property Visible  = {default=1};
	__property Width  = {default=200};
	__property OnChange ;
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnEndDock ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
public:
	#pragma option push -w-inl
	/* TRzCustomProgressBar.Create */ inline __fastcall virtual TRzProgressBar(Classes::TComponent* AOwner) : TRzCustomProgressBar(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomProgressBar.Destroy */ inline __fastcall virtual ~TRzProgressBar(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzprgres */
using namespace Rzprgres;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzprgres
