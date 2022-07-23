// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzline.pas' rev: 10.00

#ifndef RzlineHPP
#define RzlineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzline
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TRzLineSlope { lsDown, lsUp };
#pragma option pop

#pragma option push -b-
enum TRzShowArrows { saNone, saStart, saEnd, saBoth };
#pragma option pop

class DELPHICLASS TRzLine;
class PASCALIMPLEMENTATION TRzLine : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	int FBorderWidth;
	#pragma pack(push,1)
	Types::TPoint FStartPoint;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint FEndPoint;
	#pragma pack(pop)
	Graphics::TColor FLineColor;
	TRzLineSlope FLineSlope;
	Graphics::TPenStyle FLineStyle;
	int FLineWidth;
	int FArrowLength;
	TRzShowArrows FShowArrows;
	HIDESBASE MESSAGE void __fastcall CMHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	void __fastcall UpdateSize(void);
	DYNAMIC void __fastcall Resize(void);
	int __fastcall GetYFromX(int X, const Types::TPoint &Offset);
	bool __fastcall PointOnLine(const Types::TPoint &P);
	void __fastcall SetEndPoints(void);
	virtual void __fastcall SetArrowLength(int Value);
	virtual void __fastcall SetLineColor(Graphics::TColor Value);
	virtual void __fastcall SetLineSlope(TRzLineSlope Value);
	virtual void __fastcall SetLineStyle(Graphics::TPenStyle Value);
	virtual void __fastcall SetLineWidth(int Value);
	virtual void __fastcall SetShowArrows(TRzShowArrows Value);
	
public:
	__fastcall virtual TRzLine(Classes::TComponent* AOwner);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property int ArrowLength = {read=FArrowLength, write=SetArrowLength, default=10};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=-16777208};
	__property TRzLineSlope LineSlope = {read=FLineSlope, write=SetLineSlope, default=0};
	__property Graphics::TPenStyle LineStyle = {read=FLineStyle, write=SetLineStyle, default=0};
	__property int LineWidth = {read=FLineWidth, write=SetLineWidth, default=1};
	__property TRzShowArrows ShowArrows = {read=FShowArrows, write=SetShowArrows, default=0};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Caption ;
	__property Constraints ;
	__property DragKind  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property Font ;
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TRzLine(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzline */
using namespace Rzline;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzline
