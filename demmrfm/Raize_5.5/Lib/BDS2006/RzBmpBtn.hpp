// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzbmpbtn.pas' rev: 10.00

#ifndef RzbmpbtnHPP
#define RzbmpbtnHPP

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
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzbmpbtn
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TButtonBorder { bbNone, bbSingle, bbButton };
#pragma option pop

#pragma option push -b-
enum TBtnSize { bszNeither, bszButtonToBitmap, bszStretchToButton, bszTileToButton };
#pragma option pop

class DELPHICLASS TRzButtonBitmaps;
class PASCALIMPLEMENTATION TRzButtonBitmaps : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TBitmap* FUp;
	Graphics::TBitmap* FUpAndFocused;
	Graphics::TBitmap* FDisabled;
	Graphics::TBitmap* FDown;
	Graphics::TBitmap* FStayDown;
	Graphics::TBitmap* FHot;
	Graphics::TColor FTransparentColor;
	Classes::TNotifyEvent FOnChange;
	void __fastcall BitmapsChanged(System::TObject* Sender);
	
protected:
	virtual void __fastcall SetUp(Graphics::TBitmap* Value);
	virtual void __fastcall SetUpAndFocused(Graphics::TBitmap* Value);
	virtual void __fastcall SetDisabled(Graphics::TBitmap* Value);
	virtual void __fastcall SetDown(Graphics::TBitmap* Value);
	virtual void __fastcall SetStayDown(Graphics::TBitmap* Value);
	virtual void __fastcall SetHot(Graphics::TBitmap* Value);
	virtual void __fastcall SetTransparentColor(Graphics::TColor Value);
	
public:
	__fastcall TRzButtonBitmaps(void);
	__fastcall virtual ~TRzButtonBitmaps(void);
	
__published:
	__property Graphics::TBitmap* Disabled = {read=FDisabled, write=SetDisabled};
	__property Graphics::TBitmap* Down = {read=FDown, write=SetDown};
	__property Graphics::TBitmap* StayDown = {read=FStayDown, write=SetStayDown};
	__property Graphics::TBitmap* Hot = {read=FHot, write=SetHot};
	__property Graphics::TColor TransparentColor = {read=FTransparentColor, write=SetTransparentColor, nodefault};
	__property Graphics::TBitmap* Up = {read=FUp, write=SetUp};
	__property Graphics::TBitmap* UpAndFocused = {read=FUpAndFocused, write=SetUpAndFocused};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TRzBmpButton;
class PASCALIMPLEMENTATION TRzBmpButton : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	int FGroupIndex;
	TRzButtonBitmaps* FBitmaps;
	bool FDown;
	int FCaptionDownOffset;
	bool FDragging;
	bool FAllowAllUp;
	Buttons::TButtonLayout FLayout;
	int FSpacing;
	int FMargin;
	Buttons::TButtonStyle FButtonStyle;
	TButtonBorder FButtonBorder;
	TBtnSize FButtonSize;
	bool FShowFocus;
	bool FShowDownPattern;
	Graphics::TColor FColor;
	bool FWordWrap;
	bool IsFocused;
	Controls::TModalResult FModalResult;
	void __fastcall BitmapChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMButtonExtPressed(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	
protected:
	Buttons::TButtonState FState;
	bool FMouseOverButton;
	virtual void __fastcall Loaded(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Paint(void);
	void __fastcall UpdateExclusive(void);
	void __fastcall CalcLayout(Types::TRect &TextBounds, Types::TRect &PaintRect, Graphics::TBitmap* Bitmap);
	void __fastcall ClickButton(bool DoClick);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetAllowAllUp(bool Value);
	virtual void __fastcall SetButtonBorder(TButtonBorder Value);
	virtual void __fastcall SetButtonSize(TBtnSize Value);
	virtual void __fastcall SetButtonStyle(Buttons::TButtonStyle Value);
	HIDESBASE virtual void __fastcall SetColor(Graphics::TColor Value);
	virtual void __fastcall SetDown(bool Value);
	virtual void __fastcall SetCaptionDownOffset(int Value);
	virtual void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetLayout(Buttons::TButtonLayout Value);
	virtual void __fastcall SetMargin(int Value);
	virtual void __fastcall SetShowDownPattern(bool Value);
	virtual void __fastcall SetShowFocus(bool Value);
	virtual void __fastcall SetSpacing(int Value);
	virtual void __fastcall SetWordWrap(bool Value);
	
public:
	__fastcall virtual TRzBmpButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzBmpButton(void);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property int CaptionDownOffset = {read=FCaptionDownOffset, write=SetCaptionDownOffset, default=1};
	__property Controls::TModalResult ModalResult = {read=FModalResult, write=FModalResult, default=0};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property TRzButtonBitmaps* Bitmaps = {read=FBitmaps, write=FBitmaps};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property TButtonBorder ButtonBorder = {read=FButtonBorder, write=SetButtonBorder, default=0};
	__property bool ShowDownPattern = {read=FShowDownPattern, write=SetShowDownPattern, default=1};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property TBtnSize ButtonSize = {read=FButtonSize, write=SetButtonSize, default=1};
	__property Buttons::TButtonStyle ButtonStyle = {read=FButtonStyle, write=SetButtonStyle, default=0};
	__property Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property int Margin = {read=FMargin, write=SetMargin, default=-1};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	__property Action ;
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Caption ;
	__property Constraints ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property Height  = {default=30};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property Width  = {default=80};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
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
	/* TWinControl.CreateParented */ inline __fastcall TRzBmpButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word cm_BmpButtonPressed = 0x2420;

}	/* namespace Rzbmpbtn */
using namespace Rzbmpbtn;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzbmpbtn
