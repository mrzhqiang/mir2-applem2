// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzgrafx.pas' rev: 10.00

#ifndef RzgrafxHPP
#define RzgrafxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzgrafx
{
//-- type declarations -------------------------------------------------------
typedef Shortint TSmoothFactor;

struct TDWordColor
{
	
public:
	Word ColorFract;
	Byte Color;
	Byte Pad;
} ;

struct TDWordWord
{
	
public:
	Word FractPart;
	Word WordPart;
} ;

#pragma option push -b-
enum TTrapBevelStyle { bsNone, bsLowered, bsRaised };
#pragma option pop

#pragma option push -b-
enum TTrapDirect { tdLargeToSmall, tdSmallToLarge };
#pragma option pop

#pragma option push -b-
enum TTrapShape { tsLeft, tsCenter, tsRight };
#pragma option pop

struct TTrap
{
	
public:
	#pragma pack(push,1)
	Types::TPoint UpperLeft;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint UpperRight;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint LowerRight;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint LowerLeft;
	#pragma pack(pop)
} ;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall DrawFullTransparentBitmap(Graphics::TCanvas* Canvas, Graphics::TBitmap* OrigBitmap, const Types::TRect &Rect, const Types::TRect &Src, Graphics::TColor TransparentColor);
extern PACKAGE void __fastcall DrawTransparentBitmap(Graphics::TCanvas* Canvas, Graphics::TBitmap* OrigBitmap, const Types::TRect &Rect, const Types::TRect &Src, Graphics::TColor TransparentColor);
extern PACKAGE void __fastcall TileTransparentBitmap(Graphics::TCanvas* Canvas, Graphics::TBitmap* Bitmap, const Types::TRect &Rect, Graphics::TColor TransparentColor);
extern PACKAGE void __fastcall StretchTransparentBitmap(Graphics::TCanvas* Canvas, Graphics::TBitmap* Bitmap, const Types::TRect &Rect, Graphics::TColor TransparentColor);
extern PACKAGE void __fastcall FlipBitmap(Graphics::TBitmap* Bitmap);
extern PACKAGE void __fastcall TileBitmap(Graphics::TCanvas* Canvas, Graphics::TBitmap* Bitmap, const Types::TRect &Rect);
extern PACKAGE void __fastcall TileRealizedBitmap(Graphics::TCanvas* Canvas, Graphics::TBitmap* Bitmap, const Types::TRect &Rect);
extern PACKAGE void __fastcall CenterBitmap(Graphics::TCanvas* Canvas, Graphics::TBitmap* Bitmap, const Types::TRect &Rect);
extern PACKAGE void __fastcall StretchBitmap(Graphics::TCanvas* Canvas, Graphics::TBitmap* Bitmap, const Types::TRect &Rect);
extern PACKAGE void __fastcall BitFillBlit(HDC DC, int X0, int Y0, int W0, int H0, int W, int H, unsigned ROP);
extern PACKAGE void __fastcall BoxBitMirrorBlit(HDC DC, int X0, int Y0, int W0, int H0, unsigned ROP);
extern PACKAGE void __fastcall PaintGradient(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Rzcommon::TGradientDirection GradDir, Graphics::TColor ColorStart, Graphics::TColor ColorStop, TSmoothFactor SmoothFactor = (TSmoothFactor)(0x1));
extern PACKAGE void __fastcall FillGrad(HDC DC, int AX, int AY, int L, Graphics::TColor ColorStart, Graphics::TColor ColorStop, TSmoothFactor SmoothFactor = (TSmoothFactor)(0x1));
extern PACKAGE void __fastcall FillGradRect(HDC DC, int AX, int AY, int AX0, int AY0, Graphics::TColor ColorStart, Graphics::TColor ColorStop, TSmoothFactor SmoothFactor = (TSmoothFactor)(0x1));
extern PACKAGE void __fastcall FillGradDiag(HDC DC, int AW, int AH, Graphics::TColor ColorStart, Graphics::TColor ColorStop, TSmoothFactor SmoothFactor = (TSmoothFactor)(0x1));
extern PACKAGE void __fastcall DrawTrapezoidBorder(Graphics::TCanvas* Canvas, const TTrap &Trap, TTrapBevelStyle Style, int BevelWidth);
extern PACKAGE void __fastcall SetTrapezoid(TTrap &Trap, const Types::TRect &Rect, int TrapMin, TTrapShape TrapShape, Rzcommon::TDirection Direct, TTrapDirect TrapDirect);
extern PACKAGE TTrap __fastcall AdjustTrapezoid(TTrap &Trap, const Types::TRect &Rect, Rzcommon::TDirection Direct);
extern PACKAGE Types::TPoint __fastcall Intersect(const Types::TPoint &Pt1, const Types::TPoint &Pt2, const Types::TPoint &Pt3, Rzcommon::TDirection Direct);
extern PACKAGE void __fastcall InflateTrapezoid(TTrap &Trap, int Amount);
extern PACKAGE void __fastcall DrawParentImage(Controls::TControl* Control, Graphics::TCanvas* Dest, bool InvalidateParent = false)/* overload */;
extern PACKAGE void __fastcall DrawParentImage(Controls::TControl* Control, HDC DC, bool InvalidateParent = false)/* overload */;

}	/* namespace Rzgrafx */
using namespace Rzgrafx;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzgrafx
