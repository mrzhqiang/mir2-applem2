// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzradchk.pas' rev: 10.00

#ifndef RzradchkHPP
#define RzradchkHPP

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
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzradchk
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzCheckedActionLink;
class DELPHICLASS TRzCustomGlyphButton;
class PASCALIMPLEMENTATION TRzCustomGlyphButton : public Rzbutton::TRzCustomButton 
{
	typedef Rzbutton::TRzCustomButton inherited;
	
private:
	Classes::TAlignment FAlignment;
	bool FAutoSize;
	bool FWordWrap;
	Graphics::TColor FFrameColor;
	int FNumGlyphs;
	Graphics::TBitmap* FCustomGlyphs;
	Imglist::TCustomImageList* FCustomGlyphImages;
	Imglist::TChangeLink* FCustomGlyphImagesChangeLink;
	bool FUseCustomGlyphs;
	Graphics::TColor FTransparentColor;
	Graphics::TColor FWinMaskColor;
	Graphics::TColor FFillColor;
	Graphics::TColor FFocusColor;
	Graphics::TColor FDisabledColor;
	bool FReadOnly;
	bool FReadOnlyColorOnFocus;
	Graphics::TColor FReadOnlyColor;
	int FGlyphWidth;
	int FGlyphHeight;
	int FThemedGlyphWidth;
	int FThemedGlyphHeight;
	bool FTabOnEnter;
	Rzcommon::TRzButtonHotTrackStyle FHotTrackStyle;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	bool __fastcall IsCheckedStored(void);
	void __fastcall CustomGlyphsChanged(System::TObject* Sender);
	void __fastcall CustomGlyphImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	
protected:
	bool FClicksDisabled;
	Graphics::TBitmap* FBackgroundBmp;
	bool FUpdateBg;
	bool FUsingMouse;
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall AdjustBounds(void);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	DYNAMIC TMetaClass* __fastcall GetActionLinkClass(void);
	virtual void __fastcall CustomFramingChanged(void);
	virtual void __fastcall SelectGlyph(Graphics::TBitmap* Glyph) = 0 ;
	virtual void __fastcall UpdateDisplay(void);
	virtual void __fastcall RepaintDisplay(void);
	virtual Types::TRect __fastcall GetHotTrackRect();
	virtual void __fastcall BlendButtonFrame(Graphics::TBitmap* Glyph);
	virtual void __fastcall DrawGlyph(Graphics::TCanvas* ACanvas);
	void __fastcall UpdateBackground(void);
	void __fastcall UpdateUseCustomGlyphs(void);
	virtual void __fastcall PaintBackground(unsigned int DC);
	#pragma option push -w-inl
	inline void __fastcall PaintBackground(HDC DC) {TRzCustomGlyphButton::PaintBackground((unsigned int)DC);}
	#pragma option pop
	virtual void __fastcall Paint(void);
	virtual void __fastcall ExtractGlyph(int Index, Graphics::TBitmap* Bitmap, Graphics::TBitmap* Source, int W, int H);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetAlignment(Classes::TLeftRight Value);
	virtual void __fastcall SetAutoSize(bool Value);
	virtual bool __fastcall GetChecked(void);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetCustomGlyphs(Graphics::TBitmap* Value);
	virtual void __fastcall SetCustomGlyphImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetFillColor(Graphics::TColor Value);
	virtual void __fastcall SetFocusColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetUseCustomGlyphs(bool Value);
	virtual void __fastcall SetDisabledColor(Graphics::TColor Value);
	virtual void __fastcall SetReadOnly(bool Value);
	virtual void __fastcall SetReadOnlyColor(Graphics::TColor Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual void __fastcall SetTransparentColor(Graphics::TColor Value);
	virtual void __fastcall SetWinMaskColor(Graphics::TColor Value);
	virtual void __fastcall SetWordWrap(bool Value);
	__property Classes::TLeftRight Alignment = {read=FAlignment, write=SetAlignment, default=1};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property bool Checked = {read=GetChecked, write=SetChecked, stored=IsCheckedStored, default=0};
	__property Graphics::TBitmap* CustomGlyphs = {read=FCustomGlyphs, write=SetCustomGlyphs};
	__property Imglist::TCustomImageList* CustomGlyphImages = {read=FCustomGlyphImages, write=SetCustomGlyphImages};
	__property Graphics::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, default=-16777201};
	__property Graphics::TColor FillColor = {read=FFillColor, write=SetFillColor, default=-16777211};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=-16777211};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777200};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Rzcommon::TRzButtonHotTrackStyle HotTrackStyle = {read=FHotTrackStyle, write=FHotTrackStyle, default=0};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property bool ReadOnlyColorOnFocus = {read=FReadOnlyColorOnFocus, write=FReadOnlyColorOnFocus, default=0};
	__property Graphics::TColor ReadOnlyColor = {read=FReadOnlyColor, write=SetReadOnlyColor, default=-16777192};
	__property bool TabOnEnter = {read=FTabOnEnter, write=FTabOnEnter, default=0};
	__property Graphics::TColor TransparentColor = {read=FTransparentColor, write=SetTransparentColor, default=32896};
	__property bool UseCustomGlyphs = {read=FUseCustomGlyphs, write=SetUseCustomGlyphs, default=0};
	__property Graphics::TColor WinMaskColor = {read=FWinMaskColor, write=SetWinMaskColor, default=65280};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	
public:
	__fastcall virtual TRzCustomGlyphButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomGlyphButton(void);
	DYNAMIC Classes::TAlignment __fastcall GetControlsAlignment(void);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomGlyphButton(HWND ParentWindow) : Rzbutton::TRzCustomButton(ParentWindow) { }
	#pragma option pop
	
private:
	void *__IRzCustomFramingNotification;	/* Rzcommon::IRzCustomFramingNotification */
	
public:
	operator IRzCustomFramingNotification*(void) { return (IRzCustomFramingNotification*)&__IRzCustomFramingNotification; }
	
};


class PASCALIMPLEMENTATION TRzCheckedActionLink : public Controls::TWinControlActionLink 
{
	typedef Controls::TWinControlActionLink inherited;
	
protected:
	TRzCustomGlyphButton* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual void __fastcall SetChecked(bool Value);
public:
	#pragma option push -w-inl
	/* TBasicActionLink.Create */ inline __fastcall virtual TRzCheckedActionLink(System::TObject* AClient) : Controls::TWinControlActionLink(AClient) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TRzCheckedActionLink(void) { }
	#pragma option pop
	
};


typedef TMetaClass* TRzCheckedActionLinkClass;

class DELPHICLASS TRzRadioButton;
class PASCALIMPLEMENTATION TRzRadioButton : public TRzCustomGlyphButton 
{
	typedef TRzCustomGlyphButton inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FChecked;
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Msg);
	MESSAGE void __fastcall BMGetCheck(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall ChangeState(void);
	virtual void __fastcall SelectGlyph(Graphics::TBitmap* Glyph);
	virtual void __fastcall BlendButtonFrame(Graphics::TBitmap* Glyph);
	virtual bool __fastcall GetChecked(void);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetReadOnly(bool Value);
	
public:
	__fastcall virtual TRzRadioButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzRadioButton(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Action ;
	__property Align  = {default=0};
	__property Alignment  = {default=1};
	__property AlignmentVertical  = {default=0};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=1};
	__property BiDiMode ;
	__property Caption ;
	__property Checked  = {default=0};
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property CustomGlyphs ;
	__property CustomGlyphImages ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FillColor  = {default=-16777211};
	__property FocusColor  = {default=-16777211};
	__property FrameColor  = {default=-16777200};
	__property Font ;
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property Height ;
	__property HelpContext  = {default=0};
	__property HighlightColor  = {default=-16777203};
	__property Hint ;
	__property HotTrack  = {default=0};
	__property HotTrackColor  = {default=1350640};
	__property HotTrackColorType  = {default=1};
	__property HotTrackStyle  = {default=0};
	__property LightTextStyle  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property ReadOnlyColor  = {default=-16777192};
	__property ReadOnlyColorOnFocus  = {default=0};
	__property TextHighlightColor  = {default=-16777196};
	__property TextShadowColor  = {default=-16777200};
	__property TextShadowDepth  = {default=2};
	__property ShowHint ;
	__property TabOnEnter  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property TextStyle  = {default=0};
	__property ThemeAware  = {default=1};
	__property Transparent  = {default=0};
	__property TransparentColor  = {default=32896};
	__property UseCustomGlyphs  = {default=0};
	__property Visible  = {default=1};
	__property Width ;
	__property WinMaskColor  = {default=65280};
	__property WordWrap  = {default=0};
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
	/* TWinControl.CreateParented */ inline __fastcall TRzRadioButton(HWND ParentWindow) : TRzCustomGlyphButton(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzCustomCheckBox;
class PASCALIMPLEMENTATION TRzCustomCheckBox : public TRzCustomGlyphButton 
{
	typedef TRzCustomGlyphButton inherited;
	
private:
	bool FAllowGrayed;
	Stdctrls::TCheckBoxState FState;
	bool FKeyToggle;
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall BMGetCheck(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall ChangeState(void);
	virtual void __fastcall SelectGlyph(Graphics::TBitmap* Glyph);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	virtual bool __fastcall GetChecked(void);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetState(Stdctrls::TCheckBoxState Value);
	__property bool AllowGrayed = {read=FAllowGrayed, write=FAllowGrayed, default=0};
	__property Stdctrls::TCheckBoxState State = {read=FState, write=SetState, nodefault};
	
public:
	__fastcall virtual TRzCustomCheckBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomCheckBox(void);
	void __fastcall InitState(Stdctrls::TCheckBoxState Value);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomCheckBox(HWND ParentWindow) : TRzCustomGlyphButton(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzCheckBox;
class PASCALIMPLEMENTATION TRzCheckBox : public TRzCustomCheckBox 
{
	typedef TRzCustomCheckBox inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Action ;
	__property Align  = {default=0};
	__property Alignment  = {default=1};
	__property AlignmentVertical  = {default=0};
	__property AllowGrayed  = {default=0};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=1};
	__property BiDiMode ;
	__property Caption ;
	__property Checked  = {default=0};
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property CustomGlyphs ;
	__property CustomGlyphImages ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FillColor  = {default=-16777211};
	__property FocusColor  = {default=-16777211};
	__property FrameColor  = {default=-16777200};
	__property Font ;
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property Height ;
	__property HelpContext  = {default=0};
	__property HighlightColor  = {default=-16777203};
	__property Hint ;
	__property HotTrack  = {default=0};
	__property HotTrackColor  = {default=1350640};
	__property HotTrackColorType  = {default=1};
	__property HotTrackStyle  = {default=0};
	__property LightTextStyle  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property ReadOnlyColor  = {default=-16777192};
	__property ReadOnlyColorOnFocus  = {default=0};
	__property TextHighlightColor  = {default=-16777196};
	__property TextShadowColor  = {default=-16777200};
	__property TextShadowDepth  = {default=2};
	__property ShowHint ;
	__property State ;
	__property TabOnEnter  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property TextStyle  = {default=0};
	__property ThemeAware  = {default=1};
	__property Transparent  = {default=0};
	__property TransparentColor  = {default=32896};
	__property UseCustomGlyphs  = {default=0};
	__property Visible  = {default=1};
	__property Width ;
	__property WinMaskColor  = {default=65280};
	__property WordWrap  = {default=0};
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
	/* TRzCustomCheckBox.Create */ inline __fastcall virtual TRzCheckBox(Classes::TComponent* AOwner) : TRzCustomCheckBox(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomCheckBox.Destroy */ inline __fastcall virtual ~TRzCheckBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCheckBox(HWND ParentWindow) : TRzCustomCheckBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint DefaultGlyphWidth = 0xd;
static const Shortint DefaultGlyphHeight = 0xd;
static const Shortint DefaultNumGlyphs_RadioButton = 0x6;
static const Shortint DefaultNumGlyphs_CheckBox = 0x9;

}	/* namespace Rzradchk */
using namespace Rzradchk;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzradchk
