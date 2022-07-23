// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzbhints.pas' rev: 10.00

#ifndef RzbhintsHPP
#define RzbhintsHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzgrafx.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzbhints
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TRzHintCorner { hcLowerRight, hcLowerLeft, hcUpperLeft, hcUpperRight, hcNone };
#pragma option pop

typedef void __fastcall (__closure *TSetHintWinSizeEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int &Width, int &Height, AnsiString Hint, TRzHintCorner Corner);

typedef void __fastcall (__closure *TSetHintRectEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, Types::TRect &Rect, AnsiString Hint, TRzHintCorner Corner);

class DELPHICLASS TRzBalloonBitmaps;
typedef TRzBalloonBitmaps* *PRzBalloonBitmaps;

class PASCALIMPLEMENTATION TRzBalloonBitmaps : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TBitmap* FLowerRight;
	Graphics::TBitmap* FLowerLeft;
	Graphics::TBitmap* FUpperLeft;
	Graphics::TBitmap* FUpperRight;
	Graphics::TColor FTransparentColor;
	Classes::TNotifyEvent FOnChange;
	
protected:
	virtual void __fastcall SetLowerRight(Graphics::TBitmap* Value);
	virtual void __fastcall SetLowerLeft(Graphics::TBitmap* Value);
	virtual void __fastcall SetUpperLeft(Graphics::TBitmap* Value);
	virtual void __fastcall SetUpperRight(Graphics::TBitmap* Value);
	
public:
	__fastcall TRzBalloonBitmaps(void);
	__fastcall virtual ~TRzBalloonBitmaps(void);
	
__published:
	__property Graphics::TBitmap* LowerRight = {read=FLowerRight, write=SetLowerRight};
	__property Graphics::TBitmap* LowerLeft = {read=FLowerLeft, write=SetLowerLeft};
	__property Graphics::TBitmap* UpperLeft = {read=FUpperLeft, write=SetUpperLeft};
	__property Graphics::TBitmap* UpperRight = {read=FUpperRight, write=SetUpperRight};
	__property Graphics::TColor TransparentColor = {read=FTransparentColor, write=FTransparentColor, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TRzCustomHintWindow;
class DELPHICLASS TRzBalloonHints;
class PASCALIMPLEMENTATION TRzBalloonHints : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	TRzCustomHintWindow* FHintWindow;
	TMetaClass* FOrigHintWindowClass;
	TRzBalloonBitmaps* FBitmaps;
	int FCaptionWidth;
	Graphics::TColor FColor;
	Graphics::TColor FFrameColor;
	Graphics::TFont* FFont;
	Classes::TAlignment FAlignment;
	TRzHintCorner FCorner;
	bool FShowBalloon;
	int FHintPause;
	int FHintShortPause;
	int FCenterThreshold;
	TSetHintWinSizeEvent FOnSetHintWinSize;
	TSetHintRectEvent FOnSetHintRect;
	Forms::TShowHintEvent FOnShowHint;
	void __fastcall FontChanged(System::TObject* Sender);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall SetFont(Graphics::TFont* Value);
	virtual void __fastcall SetCenterThreshold(int Value);
	virtual void __fastcall SetColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetCaptionWidth(int Value);
	virtual void __fastcall SetAlignment(Classes::TAlignment Value);
	virtual void __fastcall SetCorner(TRzHintCorner Value);
	virtual void __fastcall SetShowBalloon(bool Value);
	virtual void __fastcall SetOnSetHintWinSize(TSetHintWinSizeEvent Value);
	virtual void __fastcall SetOnSetHintRect(TSetHintRectEvent Value);
	virtual int __fastcall GetHintPause(void);
	virtual void __fastcall SetHintPause(int Value);
	virtual int __fastcall GetHintShortPause(void);
	virtual void __fastcall SetHintShortPause(int Value);
	
public:
	__fastcall virtual TRzBalloonHints(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzBalloonHints(void);
	void __fastcall MakeConnection(TRzCustomHintWindow* HintWindow);
	void __fastcall BreakConnection(TRzCustomHintWindow* HintWindow);
	__property TRzCustomHintWindow* HintWindow = {read=FHintWindow};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property TRzBalloonBitmaps* Bitmaps = {read=FBitmaps, write=FBitmaps};
	__property int CaptionWidth = {read=FCaptionWidth, write=SetCaptionWidth, default=100};
	__property int CenterThreshold = {read=FCenterThreshold, write=SetCenterThreshold, default=80};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777192};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777193};
	__property TRzHintCorner Corner = {read=FCorner, write=SetCorner, default=3};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int HintPause = {read=GetHintPause, write=SetHintPause, default=500};
	__property int HintShortPause = {read=GetHintShortPause, write=SetHintShortPause, default=0};
	__property bool ShowBalloon = {read=FShowBalloon, write=SetShowBalloon, default=1};
	__property TSetHintWinSizeEvent OnSetHintWinSize = {read=FOnSetHintWinSize, write=SetOnSetHintWinSize};
	__property TSetHintRectEvent OnSetHintRect = {read=FOnSetHintRect, write=SetOnSetHintRect};
	__property Forms::TShowHintEvent OnShowHint = {read=FOnShowHint, write=FOnShowHint};
};


class PASCALIMPLEMENTATION TRzCustomHintWindow : public Controls::THintWindow 
{
	typedef Controls::THintWindow inherited;
	
private:
	bool FHintActive;
	Forms::TApplication* FApplication;
	TRzBalloonHints* FBalloonHints;
	TRzBalloonBitmaps* *FBitmaps;
	AnsiString FCaption;
	int FCaptionWidth;
	Graphics::TColor FColor;
	Graphics::TColor FFrameColor;
	Forms::THintInfo FHintInfo;
	Graphics::TFont* FFont;
	Classes::TAlignment FAlignment;
	TRzHintCorner FCorner;
	bool FShowBalloon;
	int FCenterThreshold;
	TRzHintCorner FDrawCorner;
	#pragma pack(push,1)
	Types::TRect FHintRect;
	#pragma pack(pop)
	TSetHintWinSizeEvent FOnSetHintWinSize;
	TSetHintRectEvent FOnSetHintRect;
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Messages::TWMNCCalcSize &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall NCPaint(HDC DC);
	HRGN __fastcall GetHintRegion(void);
	void __fastcall AdjustBoundsForPointer(Types::TRect &Bounds, bool Shrink);
	void __fastcall DrawHintText(Graphics::TCanvas* Canvas, const Types::TRect &Bounds);
	void __fastcall GetPointerCoordinates(const Types::TRect &Bounds, const Types::TRect &HintRect, Types::TPoint &Pt1, Types::TPoint &Pt2, Types::TPoint &Pt3, Types::TRect &FillLineRect);
	void __fastcall DrawHint(Graphics::TCanvas* Canvas, const Types::TRect &Bounds);
	void __fastcall DrawBitmapBalloon(Graphics::TCanvas* Canvas);
	virtual void __fastcall WndProc(Messages::TMessage &msg);
	HIDESBASE void __fastcall SetColor(Graphics::TColor Value);
	HIDESBASE void __fastcall SetFont(Graphics::TFont* Value);
	
public:
	__fastcall virtual TRzCustomHintWindow(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomHintWindow(void);
	virtual void __fastcall ActivateHint(const Types::TRect &Rect, const AnsiString AHint);
	void __fastcall DoShowHint(AnsiString &HintStr, bool &CanShow, Forms::THintInfo &HintInfo);
	void __fastcall BitmapChanged(System::TObject* Sender);
	__property PRzBalloonBitmaps Bitmaps = {read=FBitmaps, write=FBitmaps};
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property int CaptionWidth = {read=FCaptionWidth, write=FCaptionWidth, nodefault};
	__property AnsiString Caption = {read=FCaption, write=FCaption};
	__property int CenterThreshold = {read=FCenterThreshold, write=FCenterThreshold, default=80};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=FFrameColor, nodefault};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=FAlignment, nodefault};
	__property TRzHintCorner Corner = {read=FCorner, write=FCorner, nodefault};
	__property bool ShowBalloon = {read=FShowBalloon, write=FShowBalloon, nodefault};
	__property TSetHintWinSizeEvent OnSetHintWinSize = {read=FOnSetHintWinSize, write=FOnSetHintWinSize};
	__property TSetHintRectEvent OnSetHintRect = {read=FOnSetHintRect, write=FOnSetHintRect};
	__property Canvas ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomHintWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint MinWindowWidth = 0x37;
static const Shortint MouseAdj = 0x2;

}	/* namespace Rzbhints */
using namespace Rzbhints;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzbhints
