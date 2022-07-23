// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzgrids.pas' rev: 10.00

#ifndef RzgridsHPP
#define RzgridsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzgrids
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzStringGrid;
class PASCALIMPLEMENTATION TRzStringGrid : public Grids::TStringGrid 
{
	typedef Grids::TStringGrid inherited;
	
private:
	Graphics::TColor FLineColor;
	Graphics::TColor FFixedLineColor;
	bool FUpdatingColor;
	Graphics::TColor FDisabledColor;
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
	Rzcommon::TRzAboutInfo FAboutInfo;
	Graphics::TCanvas* FCanvas;
	bool FOverControl;
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Grids::TInplaceEdit* __fastcall CreateEditor(void);
	virtual void __fastcall UpdateColors(void);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	virtual void __fastcall RepaintFrame(void);
	HIDESBASE bool __fastcall IsActiveControl(void);
	virtual void __fastcall Paint(void);
	HIDESBASE void __fastcall GridRectToScreenRect(const Grids::TGridRect &GridRect, Types::TRect &ScreenRect, bool IncludeLine);
	virtual Grids::TGridRect __fastcall GetFocusSelection();
	bool __fastcall StoreColor(void);
	bool __fastcall StoreFocusColor(void);
	bool __fastcall StoreDisabledColor(void);
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
	virtual void __fastcall SetFixedLineColor(Graphics::TColor Value);
	virtual void __fastcall SetLineColor(Graphics::TColor Value);
	
public:
	__fastcall virtual TRzStringGrid(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzStringGrid(void);
	virtual bool __fastcall UseThemes(void);
	
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
	__property Graphics::TColor FixedLineColor = {read=FFixedLineColor, write=SetFixedLineColor, default=-16777200};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=-16777201};
	__property DefaultColWidth  = {default=60};
	__property DefaultRowHeight  = {default=18};
	__property Height  = {default=125};
	__property Width  = {default=325};
	__property OnResize ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzStringGrid(HWND ParentWindow) : Grids::TStringGrid(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzgrids */
using namespace Rzgrids;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzgrids
