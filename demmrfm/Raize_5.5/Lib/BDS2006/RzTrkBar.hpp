// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rztrkbar.pas' rev: 10.00

#ifndef RztrkbarHPP
#define RztrkbarHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rztrkbar
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TBitmapType { btThumb, btHot, btDisabled, btMask };
#pragma option pop

#pragma option push -b-
enum TThumbStyle { tsBox, tsCustom, tsMixer, tsPointer, tsFlat, tsXPPointer, tsXPBox };
#pragma option pop

#pragma option push -b-
enum TTickStyle { tkStandard, tkOwnerDraw };
#pragma option pop

#pragma option push -b-
enum TPointerType { ptStandard, ptWin95 };
#pragma option pop

class DELPHICLASS TRzTrackBar;
typedef void __fastcall (__closure *TDrawTickEvent)(TRzTrackBar* TrackBar, Graphics::TCanvas* Canvas, const Types::TPoint &Location, int Index);

typedef void __fastcall (__closure *TRzDrawTrackEvent)(TRzTrackBar* TrackBar, Graphics::TCanvas* Canvas, const Types::TRect &Bounds);

class PASCALIMPLEMENTATION TRzTrackBar : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	int FBorderWidth;
	int FMax;
	int FMin;
	Rzcommon::TOrientation FOrientation;
	Word FPageSize;
	int FPosition;
	TTickStyle FTickStyle;
	Graphics::TColor FTickColor;
	Rzcommon::TPositiveInteger FTickStep;
	Graphics::TColor FHighlightColor;
	Graphics::TColor FHotTrackColor;
	Rzcommon::TRzHotTrackColorType FHotTrackColorType;
	bool FShowTicks;
	bool FSliding;
	bool FPaging;
	bool FPagingDirInc;
	Extctrls::TTimer* FRepeatTimer;
	int FLastX;
	int FLastY;
	bool FTabOnEnter;
	int FThumbCenterOffsetX;
	int FThumbCenterOffsetY;
	int FThumbHeight;
	#pragma pack(push,1)
	Types::TRect FThumbRct;
	#pragma pack(pop)
	TThumbStyle FThumbStyle;
	int FThumbWidth;
	int FHalfWidth;
	TPointerType FPointerType;
	Graphics::TColor FTrackColor;
	Word FTrackOffset;
	#pragma pack(push,1)
	Types::TRect FTrackRct;
	#pragma pack(pop)
	Rzcommon::TFrameStyleEx FTrackFrame;
	Graphics::TColor FTrackFrameColor;
	Word FTrackWidth;
	bool FShowFocusRect;
	Graphics::TBitmap* FThumbBmp;
	Graphics::TBitmap* FHotThumbBmp;
	Graphics::TBitmap* FMaskBmp;
	Graphics::TBitmap* FDisabledBmp;
	Graphics::TBitmap* FBackgroundBmp;
	bool FUpdateBg;
	Graphics::TBitmap* FCustomThumb;
	bool FUseHotThumb;
	bool FTransparent;
	bool FThemeAware;
	HICON FHorzCursor;
	HICON FVertCursor;
	Classes::TNotifyEvent FOnChange;
	Rzcommon::TPositionChangingEvent FOnChanging;
	TRzDrawTrackEvent FOnDrawTrack;
	TDrawTickEvent FOnDrawTick;
	void __fastcall TimerExpired(System::TObject* Sender);
	void __fastcall CustomThumbChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	virtual void __fastcall CreateWnd(void);
	void __fastcall LoadThumbBitmaps(void);
	bool __fastcall ShowFocus(void);
	Types::TPoint __fastcall CursorPosition();
	virtual void __fastcall DrawTrack(Graphics::TCanvas* ACanvas);
	virtual void __fastcall DrawTicks(Graphics::TCanvas* ACanvas);
	virtual void __fastcall DrawThumb(Graphics::TCanvas* ACanvas);
	virtual void __fastcall Paint(void);
	void __fastcall UpdateBackground(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC bool __fastcall CanChange(int NewPos);
	virtual bool __fastcall CanInternalChange(int NewPos);
	DYNAMIC void __fastcall DoDrawTrack(Graphics::TCanvas* Canvas, const Types::TRect &Bounds);
	DYNAMIC void __fastcall DrawTick(Graphics::TCanvas* Canvas, const Types::TPoint &Location, int Index);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetCustomThumb(Graphics::TBitmap* Value);
	virtual void __fastcall SetHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetHotTrackColor(Graphics::TColor Value);
	virtual void __fastcall SetHotTrackColorType(Rzcommon::TRzHotTrackColorType Value);
	virtual void __fastcall SetMax(int Value);
	virtual void __fastcall SetMin(int Value);
	virtual void __fastcall SetOrientation(Rzcommon::TOrientation Value);
	virtual void __fastcall SetPointerType(TPointerType Value);
	virtual void __fastcall SetPosition(int Value);
	virtual void __fastcall SetShowTicks(bool Value);
	virtual void __fastcall SetThumbStyle(TThumbStyle Value);
	virtual void __fastcall SetTickColor(Graphics::TColor Value);
	virtual void __fastcall SetTickStep(Rzcommon::TPositiveInteger Value);
	virtual void __fastcall SetTickStyle(TTickStyle Value);
	virtual void __fastcall SetTrackColor(Graphics::TColor Value);
	virtual void __fastcall SetTrackOffset(Word Value);
	virtual void __fastcall SetTrackFrame(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetTrackFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetTrackWidth(Word Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual void __fastcall SetThemeAware(bool Value);
	
public:
	__fastcall virtual TRzTrackBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzTrackBar(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Graphics::TBitmap* CustomThumb = {read=FCustomThumb, write=SetCustomThumb};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=SetHighlightColor, default=-16777203};
	__property Graphics::TColor HotTrackColor = {read=FHotTrackColor, write=SetHotTrackColor, default=1350640};
	__property Rzcommon::TRzHotTrackColorType HotTrackColorType = {read=FHotTrackColorType, write=SetHotTrackColorType, default=1};
	__property int Max = {read=FMax, write=SetMax, default=10};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property Rzcommon::TOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property Word PageSize = {read=FPageSize, write=FPageSize, default=1};
	__property TPointerType PointerType = {read=FPointerType, write=SetPointerType, default=0};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property bool ShowFocusRect = {read=FShowFocusRect, write=FShowFocusRect, default=1};
	__property bool ShowTicks = {read=FShowTicks, write=SetShowTicks, default=1};
	__property bool TabOnEnter = {read=FTabOnEnter, write=FTabOnEnter, default=0};
	__property TThumbStyle ThumbStyle = {read=FThumbStyle, write=SetThumbStyle, default=3};
	__property Graphics::TColor TickColor = {read=FTickColor, write=SetTickColor, default=-16777200};
	__property Rzcommon::TPositiveInteger TickStep = {read=FTickStep, write=SetTickStep, default=1};
	__property TTickStyle TickStyle = {read=FTickStyle, write=SetTickStyle, default=0};
	__property Graphics::TColor TrackColor = {read=FTrackColor, write=SetTrackColor, default=-16777194};
	__property Word TrackOffset = {read=FTrackOffset, write=SetTrackOffset, default=20};
	__property Rzcommon::TFrameStyle TrackFrame = {read=FTrackFrame, write=SetTrackFrame, default=8};
	__property Graphics::TColor TrackFrameColor = {read=FTrackFrameColor, write=SetTrackFrameColor, default=-16777200};
	__property Word TrackWidth = {read=FTrackWidth, write=SetTrackWidth, default=8};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool ThemeAware = {read=FThemeAware, write=SetThemeAware, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Rzcommon::TPositionChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TRzDrawTrackEvent OnDrawTrack = {read=FOnDrawTrack, write=FOnDrawTrack};
	__property TDrawTickEvent OnDrawTick = {read=FOnDrawTick, write=FOnDrawTick};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Height  = {default=35};
	__property HelpContext  = {default=0};
	__property Hint ;
	__property ParentColor  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property Width  = {default=200};
	__property OnClick ;
	__property OnContextPopup ;
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
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzTrackBar(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rztrkbar */
using namespace Rztrkbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rztrkbar
