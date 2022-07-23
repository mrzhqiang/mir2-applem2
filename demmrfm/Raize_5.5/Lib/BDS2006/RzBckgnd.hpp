// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzbckgnd.pas' rev: 10.00

#ifndef RzbckgndHPP
#define RzbckgndHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Rzgrafx.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzbckgnd
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TImageStyle { isCenter, isClip, isFill, isStretch, isTiled };
#pragma option pop

class DELPHICLASS TRzCustomBackground;
class PASCALIMPLEMENTATION TRzCustomBackground : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	bool FActive;
	bool FMDIActive;
	Rzcommon::TFrameStyleEx FFrameStyle;
	Graphics::TColor FFrameColor;
	Graphics::TColor FColorStart;
	Graphics::TColor FColorStartDisp;
	Byte FStartRed;
	Byte FStartGreen;
	Byte FStartBlue;
	Graphics::TColor FColorStop;
	Graphics::TColor FColorStopDisp;
	Byte FStopRed;
	Byte FStopGreen;
	Byte FStopBlue;
	Rzcommon::TGradientDirection FGradientDirection;
	Rzgrafx::TSmoothFactor FGradientSmoothFactor;
	bool FShowGradient;
	Graphics::TPicture* FImage;
	bool FShowImage;
	TImageStyle FImageStyle;
	Graphics::TPicture* FTexture;
	bool FShowTexture;
	void *FClientInstance;
	HWND FClientHandle;
	void *FDefClientProc;
	void __fastcall EraseMDIClientBkgrnd(Messages::TMessage &Msg);
	void __fastcall SubClassMDIClient(Forms::TForm* AOwner);
	void __fastcall TextureChangeHandler(System::TObject* Sender);
	void __fastcall ImageChangeHandler(System::TObject* Sender);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall InvalidateBackground(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintGradient(Graphics::TCanvas* ACanvas);
	virtual void __fastcall PaintImage(Graphics::TCanvas* ACanvas, Graphics::TPicture* Picture);
	virtual void __fastcall PaintTexture(Graphics::TCanvas* ACanvas, Graphics::TPicture* Picture);
	virtual void __fastcall SetActive(bool Value);
	virtual Controls::TAlign __fastcall GetAlign(void);
	HIDESBASE virtual void __fastcall SetAlign(Controls::TAlign Value);
	virtual void __fastcall SetColorStart(Graphics::TColor Value);
	virtual void __fastcall SetColorStop(Graphics::TColor Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetGradientDirection(Rzcommon::TGradientDirection Value);
	virtual void __fastcall SetGradientSmoothFactor(Rzgrafx::TSmoothFactor Value);
	virtual void __fastcall SetImage(Graphics::TPicture* Value);
	virtual void __fastcall SetImageStyle(TImageStyle Value);
	virtual void __fastcall SetShowGradient(bool Value);
	virtual void __fastcall SetShowImage(bool Value);
	virtual void __fastcall SetShowTexture(bool Value);
	virtual void __fastcall SetTexture(Graphics::TPicture* Value);
	virtual bool __fastcall GetVisible(void);
	HIDESBASE virtual void __fastcall SetVisible(bool Value);
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property Controls::TAlign Align = {read=GetAlign, write=SetAlign, nodefault};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777200};
	__property Rzcommon::TFrameStyle FrameStyle = {read=FFrameStyle, write=SetFrameStyle, default=0};
	__property Graphics::TColor GradientColorStart = {read=FColorStartDisp, write=SetColorStart, default=-16777190};
	__property Graphics::TColor GradientColorStop = {read=FColorStopDisp, write=SetColorStop, default=-16777214};
	__property Rzcommon::TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=2};
	__property Rzgrafx::TSmoothFactor GradientSmoothFactor = {read=FGradientSmoothFactor, write=SetGradientSmoothFactor, default=1};
	__property Graphics::TPicture* Image = {read=FImage, write=SetImage};
	__property TImageStyle ImageStyle = {read=FImageStyle, write=SetImageStyle, stored=true, nodefault};
	__property bool ShowGradient = {read=FShowGradient, write=SetShowGradient, stored=true, nodefault};
	__property bool ShowImage = {read=FShowImage, write=SetShowImage, stored=true, nodefault};
	__property bool ShowTexture = {read=FShowTexture, write=SetShowTexture, stored=true, nodefault};
	__property Graphics::TPicture* Texture = {read=FTexture, write=SetTexture, stored=true};
	__property bool Visible = {read=GetVisible, write=SetVisible, default=1};
	
public:
	__fastcall virtual TRzCustomBackground(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomBackground(void);
};


class DELPHICLASS TRzBackground;
class PASCALIMPLEMENTATION TRzBackground : public TRzCustomBackground 
{
	typedef TRzCustomBackground inherited;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Active ;
	__property Align ;
	__property Anchors  = {default=3};
	__property Constraints ;
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FrameColor  = {default=-16777200};
	__property FrameStyle  = {default=0};
	__property GradientColorStart  = {default=-16777190};
	__property GradientColorStop  = {default=-16777214};
	__property GradientDirection  = {default=2};
	__property GradientSmoothFactor  = {default=1};
	__property Image ;
	__property ImageStyle ;
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowGradient ;
	__property ShowHint ;
	__property ShowImage ;
	__property ShowTexture ;
	__property Texture ;
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
public:
	#pragma option push -w-inl
	/* TRzCustomBackground.Create */ inline __fastcall virtual TRzBackground(Classes::TComponent* AOwner) : TRzCustomBackground(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomBackground.Destroy */ inline __fastcall virtual ~TRzBackground(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzHighlightLocation { hlCenter, hlUpperLeft, hlLowerRight };
#pragma option pop

class DELPHICLASS TRzSeparator;
class PASCALIMPLEMENTATION TRzSeparator : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Graphics::TColor FHighlightColor;
	TRzHighlightLocation FHighlightLocation;
	Rzcommon::TOrientation FOrientation;
	bool FShowGradient;
	Rzcommon::TGradientDirection FGradientDirection;
	Graphics::TColor FStartColor;
	Graphics::TColor FStopColor;
	bool FSetInitialSizeRequired;
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Paint(void);
	void __fastcall UpdateGradientDetails(void);
	virtual void __fastcall SetHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetHighlightLocation(TRzHighlightLocation Value);
	virtual void __fastcall SetShowGradient(bool Value);
	virtual void __fastcall SetOrientation(Rzcommon::TOrientation Value);
	
public:
	__fastcall virtual TRzSeparator(Classes::TComponent* AOwner);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=SetHighlightColor, default=-16777203};
	__property TRzHighlightLocation HighlightLocation = {read=FHighlightLocation, write=SetHighlightLocation, default=0};
	__property Rzcommon::TOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property bool ShowGradient = {read=FShowGradient, write=SetShowGradient, stored=true, nodefault};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Color  = {stored=true, default=-16777211};
	__property Constraints ;
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Height  = {default=2};
	__property ParentColor  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property Visible  = {default=1};
	__property Width  = {default=200};
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
public:
	#pragma option push -w-inl
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TRzSeparator(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzbckgnd */
using namespace Rzbckgnd;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzbckgnd
