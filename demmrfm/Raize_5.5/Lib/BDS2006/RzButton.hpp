// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzbutton.pas' rev: 10.00

#ifndef RzbuttonHPP
#define RzbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Consts.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzbutton
{
//-- type declarations -------------------------------------------------------
typedef AnsiString RzButton__1[11];

class DELPHICLASS TRzCustomButton;
class PASCALIMPLEMENTATION TRzCustomButton : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	Rzcommon::TAlignmentVertical FAlignmentVertical;
	Graphics::TColor FHotTrackColor;
	Rzcommon::TRzHotTrackColorType FHotTrackColorType;
	Graphics::TColor FHighlightColor;
	bool FLightTextStyle;
	Rzcommon::TTextStyle FTextStyle;
	Graphics::TColor FTextHighlightColor;
	Graphics::TColor FTextShadowColor;
	int FTextShadowDepth;
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FDragging;
	bool FHotTrack;
	bool FMouseOverButton;
	bool FShowDownVersion;
	bool FTransparent;
	bool FThemeAware;
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall PaintBackground(unsigned int DC);
	#pragma option push -w-inl
	inline void __fastcall PaintBackground(HDC DC) {TRzCustomButton::PaintBackground((unsigned int)DC);}
	#pragma option pop
	virtual void __fastcall UpdateDisplay(void);
	virtual void __fastcall RepaintDisplay(void);
	virtual Types::TRect __fastcall GetHotTrackRect();
	HIDESBASE void __fastcall RemoveFocus(bool Removing);
	bool __fastcall ShowAccel(void);
	bool __fastcall ShowFocus(void);
	virtual bool __fastcall UseThemes(void);
	virtual void __fastcall Draw3DText(Graphics::TCanvas* Canvas, const Types::TRect &R, unsigned Flags);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall ChangeState(void) = 0 ;
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetAlignmentVertical(Rzcommon::TAlignmentVertical Value);
	virtual void __fastcall SetHotTrack(bool Value);
	virtual void __fastcall SetHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetLightTextStyle(bool Value);
	virtual void __fastcall SetTextStyle(Rzcommon::TTextStyle Value);
	virtual void __fastcall SetTextHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetTextShadowColor(Graphics::TColor Value);
	virtual void __fastcall SetTextShadowDepth(int Value);
	virtual void __fastcall SetThemeAware(bool Value);
	virtual void __fastcall SetTransparent(bool Value);
	__property Rzcommon::TAlignmentVertical AlignmentVertical = {read=FAlignmentVertical, write=SetAlignmentVertical, default=1};
	__property bool HotTrack = {read=FHotTrack, write=SetHotTrack, default=0};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=SetHighlightColor, default=-16777203};
	__property Graphics::TColor HotTrackColor = {read=FHotTrackColor, write=FHotTrackColor, default=1350640};
	__property Rzcommon::TRzHotTrackColorType HotTrackColorType = {read=FHotTrackColorType, write=FHotTrackColorType, default=1};
	__property Graphics::TColor TextHighlightColor = {read=FTextHighlightColor, write=SetTextHighlightColor, default=-16777196};
	__property bool LightTextStyle = {read=FLightTextStyle, write=SetLightTextStyle, default=0};
	__property Graphics::TColor TextShadowColor = {read=FTextShadowColor, write=SetTextShadowColor, default=-16777200};
	__property int TextShadowDepth = {read=FTextShadowDepth, write=SetTextShadowDepth, default=2};
	__property Rzcommon::TTextStyle TextStyle = {read=FTextStyle, write=SetTextStyle, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool ThemeAware = {read=FThemeAware, write=SetThemeAware, default=1};
	
public:
	__fastcall virtual TRzCustomButton(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TRzCustomButton(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzButton;
class PASCALIMPLEMENTATION TRzButton : public TRzCustomButton 
{
	typedef TRzCustomButton inherited;
	
private:
	Classes::TAlignment FAlignment;
	bool FClicking;
	bool FDefault;
	bool FCancel;
	bool FActive;
	Controls::TModalResult FModalResult;
	bool FKeyToggle;
	bool FAllowAllUp;
	bool FDown;
	int FGroupIndex;
	bool FShowDownPattern;
	bool FShowFocusRect;
	bool FDropDownOnEnter;
	Graphics::TColor FFrameColor;
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Msg);
	MESSAGE void __fastcall CMRzButtonPressed(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TMessage &Msg);
	
protected:
	Buttons::TButtonState FState;
	bool FKeyWasPressed;
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall PaintBackground(unsigned int DC);
	#pragma option push -w-inl
	inline void __fastcall PaintBackground(HDC DC) {TRzButton::PaintBackground((unsigned int)DC);}
	#pragma option pop
	virtual void __fastcall UpdateDisplay(void);
	virtual void __fastcall ChangeState(void);
	virtual Types::TRect __fastcall GetCaptionRect();
	virtual void __fastcall DrawButtonContent(void);
	virtual void __fastcall CreateBrushPattern(Graphics::TBitmap* PatternBmp);
	virtual void __fastcall Paint(void);
	void __fastcall UpdateExclusive(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall SetAlignment(Classes::TAlignment Value);
	virtual void __fastcall SetDefault(bool Value);
	virtual void __fastcall SetAllowAllUp(bool Value);
	virtual void __fastcall SetDown(bool Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetHotTrack(bool Value);
	virtual void __fastcall SetShowDownPattern(bool Value);
	virtual void __fastcall SetShowFocusRect(bool Value);
	
public:
	__fastcall virtual TRzButton(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property bool Cancel = {read=FCancel, write=FCancel, default=0};
	__property bool Default = {read=FDefault, write=SetDefault, default=0};
	__property bool DropDownOnEnter = {read=FDropDownOnEnter, write=FDropDownOnEnter, default=1};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777195};
	__property Controls::TModalResult ModalResult = {read=FModalResult, write=FModalResult, default=0};
	__property bool ShowDownPattern = {read=FShowDownPattern, write=SetShowDownPattern, default=1};
	__property bool ShowFocusRect = {read=FShowFocusRect, write=SetShowFocusRect, default=1};
	__property Action ;
	__property Align  = {default=0};
	__property AlignmentVertical  = {default=1};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Caption ;
	__property Color  = {default=-16777201};
	__property Constraints ;
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property DragCursor  = {default=-12};
	__property Enabled  = {default=1};
	__property Font ;
	__property HelpContext  = {default=0};
	__property Height  = {default=25};
	__property HighlightColor  = {default=-16777203};
	__property Hint ;
	__property HotTrack  = {default=0};
	__property HotTrackColor  = {default=1350640};
	__property HotTrackColorType  = {default=1};
	__property LightTextStyle  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property TextHighlightColor  = {default=-16777196};
	__property TextShadowColor  = {default=-16777200};
	__property TextShadowDepth  = {default=2};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property TextStyle  = {default=0};
	__property ThemeAware  = {default=1};
	__property Visible  = {default=1};
	__property Width  = {default=75};
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
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TRzButton(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzButton(HWND ParentWindow) : TRzCustomButton(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzBitBtn;
class PASCALIMPLEMENTATION TRzBitBtn : public TRzButton 
{
	typedef TRzButton inherited;
	
private:
	Graphics::TBitmap* FGlyph;
	Buttons::TBitBtnKind FKind;
	Buttons::TButtonLayout FLayout;
	int FMargin;
	Buttons::TNumGlyphs FNumGlyphs;
	int FSpacing;
	bool FModifiedGlyph;
	Imglist::TImageIndex FImageIndex;
	Imglist::TImageIndex FDisabledIndex;
	Imglist::TCustomImageList* FImages;
	Imglist::TChangeLink* FImagesChangeLink;
	void __fastcall GlyphChangedHandler(System::TObject* Sender);
	void __fastcall ImagesChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual Types::TPoint __fastcall GetImageSize();
	virtual Types::TRect __fastcall GetCaptionRect();
	virtual Types::TRect __fastcall GetGlyphRect();
	virtual void __fastcall DrawImage(const Types::TRect &R);
	virtual void __fastcall DrawGlyph(const Types::TRect &R);
	virtual void __fastcall DrawButtonContent(void);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	bool __fastcall IsCustom(void);
	bool __fastcall IsCustomCaption(void);
	virtual void __fastcall SetGlyph(Graphics::TBitmap* Value);
	virtual Buttons::TBitBtnKind __fastcall GetKind(void);
	virtual void __fastcall SetKind(Buttons::TBitBtnKind Value);
	virtual void __fastcall SetLayout(Buttons::TButtonLayout Value);
	virtual void __fastcall SetMargin(int Value);
	virtual void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	virtual void __fastcall SetSpacing(int Value);
	virtual void __fastcall SetImageIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetDisabledIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetImages(Imglist::TCustomImageList* Value);
	
public:
	__fastcall virtual TRzBitBtn(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzBitBtn(void);
	
__published:
	__property Cancel  = {stored=IsCustom, default=0};
	__property Caption  = {stored=IsCustomCaption};
	__property Default  = {stored=IsCustom, default=0};
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph, stored=IsCustom};
	__property Imglist::TImageIndex DisabledIndex = {read=FDisabledIndex, write=SetDisabledIndex, default=-1};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Buttons::TBitBtnKind Kind = {read=GetKind, write=SetKind, default=0};
	__property Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property int Margin = {read=FMargin, write=SetMargin, default=2};
	__property ModalResult  = {stored=IsCustom, default=0};
	__property Buttons::TNumGlyphs NumGlyphs = {read=FNumGlyphs, write=SetNumGlyphs, stored=IsCustom, default=1};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzBitBtn(HWND ParentWindow) : TRzButton(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzMenuButton;
class PASCALIMPLEMENTATION TRzMenuButton : public TRzBitBtn 
{
	typedef TRzBitBtn inherited;
	
private:
	bool FDropped;
	Menus::TPopupMenu* FDropDownMenu;
	unsigned FDropTime;
	bool FSkipNextClick;
	bool FShowArrow;
	Classes::TNotifyEvent FOnDropDown;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	
protected:
	virtual Types::TRect __fastcall GetCaptionRect();
	virtual Types::TRect __fastcall GetGlyphRect();
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DoDropDown(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DropDown(void);
	void __fastcall SetDropDownMenu(Menus::TPopupMenu* Value);
	virtual void __fastcall SetShowArrow(bool Value);
	
public:
	__fastcall virtual TRzMenuButton(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Menus::TPopupMenu* DropDownMenu = {read=FDropDownMenu, write=SetDropDownMenu};
	__property bool ShowArrow = {read=FShowArrow, write=SetShowArrow, default=1};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property Width  = {default=110};
public:
	#pragma option push -w-inl
	/* TRzBitBtn.Destroy */ inline __fastcall virtual ~TRzMenuButton(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzMenuButton(HWND ParentWindow) : TRzBitBtn(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzToolbarButtonActionLink;
class PASCALIMPLEMENTATION TRzToolbarButtonActionLink : public Buttons::TSpeedButtonActionLink 
{
	typedef Buttons::TSpeedButtonActionLink inherited;
	
protected:
	virtual bool __fastcall IsCaptionLinked(void);
public:
	#pragma option push -w-inl
	/* TSpeedButtonActionLink.Create */ inline __fastcall virtual TRzToolbarButtonActionLink(System::TObject* AClient) : Buttons::TSpeedButtonActionLink(AClient) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TRzToolbarButtonActionLink(void) { }
	#pragma option pop
	
};


typedef TMetaClass* TRzToolbarButtonActionLinkClass;

class DELPHICLASS TRzToolbarButton;
class PASCALIMPLEMENTATION TRzToolbarButton : public Buttons::TSpeedButton 
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FChangingGlyph;
	Graphics::TBitmap* FHotGlyph;
	Buttons::TNumGlyphs FHotNumGlyphs;
	bool FUseHotGlyph;
	Graphics::TBitmap* FStdGlyph;
	Buttons::TNumGlyphs FStdNumGlyphs;
	bool FIgnoreActionCaption;
	AnsiString FSaveCaption;
	bool FShowCaption;
	void __fastcall ReadSaveCaption(Classes::TReader* Reader);
	void __fastcall WriteSaveCaption(Classes::TWriter* Writer);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	void __fastcall HotGlyphChangedHandler(System::TObject* Sender);
	
protected:
	bool FMouseOverControl;
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	DYNAMIC TMetaClass* __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetHotNumGlyphs(Buttons::TNumGlyphs Value);
	virtual void __fastcall SetHotGlyph(Graphics::TBitmap* Value);
	virtual AnsiString __fastcall GetCaption();
	virtual void __fastcall SetCaption(const AnsiString Value);
	virtual void __fastcall SetShowCaption(bool Value);
	
public:
	__fastcall virtual TRzToolbarButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzToolbarButton(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Graphics::TBitmap* HotGlyph = {read=FHotGlyph, write=SetHotGlyph};
	__property Buttons::TNumGlyphs HotNumGlyphs = {read=FHotNumGlyphs, write=SetHotNumGlyphs, default=1};
	__property bool IgnoreActionCaption = {read=FIgnoreActionCaption, write=FIgnoreActionCaption, default=0};
	__property AnsiString Caption = {read=GetCaption, write=SetCaption};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property bool UseHotGlyph = {read=FUseHotGlyph, write=FUseHotGlyph, default=0};
	__property Flat  = {default=1};
};


class DELPHICLASS TRzMenuToolbarButton;
class PASCALIMPLEMENTATION TRzMenuToolbarButton : public TRzToolbarButton 
{
	typedef TRzToolbarButton inherited;
	
private:
	bool FDropped;
	Menus::TPopupMenu* FDropDownMenu;
	unsigned FDropTime;
	bool FSkipNextClick;
	bool FShowArrow;
	Classes::TNotifyEvent FOnDropDown;
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DropDown(void);
	void __fastcall SetDropDownMenu(Menus::TPopupMenu* Value);
	void __fastcall SetShowArrow(bool Value);
	
public:
	__fastcall virtual TRzMenuToolbarButton(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall DoDropDown(void);
	
__published:
	__property Menus::TPopupMenu* DropDownMenu = {read=FDropDownMenu, write=SetDropDownMenu};
	__property bool ShowArrow = {read=FShowArrow, write=SetShowArrow, default=1};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property DragMode  = {default=0};
	__property Margin  = {default=2};
	__property Width  = {default=40};
public:
	#pragma option push -w-inl
	/* TRzToolbarButton.Destroy */ inline __fastcall virtual ~TRzMenuToolbarButton(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzToolButtonActionLink;
class DELPHICLASS TRzToolButton;
#pragma option push -b-
enum TRzToolStyle { tsButton, tsDropDown };
#pragma option pop

#pragma option push -b-
enum TRzToolButtonState { tbsUp, tbsDisabled, tbsDown, tbsExclusive, tbsDropDown };
#pragma option pop

class PASCALIMPLEMENTATION TRzToolButton : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FAllowAllUp;
	bool FDown;
	bool FDragging;
	bool FFlat;
	int FGroupIndex;
	Imglist::TImageIndex FImageIndex;
	Imglist::TImageIndex FDownIndex;
	Imglist::TImageIndex FDisabledIndex;
	Imglist::TImageIndex FHotIndex;
	Imglist::TCustomImageList* FImages;
	Imglist::TChangeLink* FImagesChangeLink;
	Buttons::TButtonLayout FLayout;
	bool FMouseOverButton;
	Menus::TPopupMenu* FDropDownMenu;
	unsigned FDropTime;
	bool FTreatAsNormal;
	TRzToolStyle FToolStyle;
	bool FShowCaption;
	bool FTransparent;
	bool FInDoDropDown;
	Classes::TAlignment FAlignment;
	Rzcommon::TRzVisualStyle FVisualStyle;
	Rzcommon::TRzGradientColorStyle FGradientColorStyle;
	Graphics::TColor FSelectionColorStart;
	Graphics::TColor FSelectionColorStop;
	Graphics::TColor FSelectionFrameColor;
	bool FUseToolbarButtonLayout;
	bool FUseToolbarButtonSize;
	bool FUseToolbarShowCaption;
	bool FUseToolbarVisualStyle;
	Classes::TNotifyEvent FOnDropDown;
	bool __fastcall IsCheckedStored(void);
	bool __fastcall IsImageIndexStored(void);
	void __fastcall UpdateExclusive(void);
	void __fastcall UpdateTracking(void);
	void __fastcall ReadOldGradientColorStartProp(Classes::TReader* Reader);
	void __fastcall ReadOldGradientColorStopProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameColorProp(Classes::TReader* Reader);
	void __fastcall ReadOldUseGradientsProp(Classes::TReader* Reader);
	void __fastcall ImagesChange(System::TObject* Sender);
	MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMButtonPressed(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMToolbarShowCaptionChanged(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMToolbarButtonLayoutChanged(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMToolbarButtonSizeChanged(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMToolbarVisualStyleChanged(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	
protected:
	TRzToolButtonState FState;
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall PickupToolbarStyles(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DrawBtnBorder(Types::TRect &R);
	virtual void __fastcall DrawImage(const Types::TRect &R);
	virtual void __fastcall DrawArrow(void);
	virtual void __fastcall DrawCaption(const Types::TRect &R);
	virtual void __fastcall Paint(void);
	virtual void __fastcall DoDropDown(void);
	virtual Types::TPoint __fastcall GetImageSize();
	virtual void __fastcall GetImageAndCaptionRects(Types::TRect &ImageRect, Types::TRect &CaptionRect);
	void __fastcall CheckMinSize(void);
	Types::TPoint __fastcall CursorPosition();
	bool __fastcall HotTrackingStyle(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	DYNAMIC TMetaClass* __fastcall GetActionLinkClass(void);
	virtual void __fastcall AssignTo(Classes::TPersistent* Dest);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DropDown(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetAllowAllUp(bool Value);
	virtual void __fastcall SetAlignment(Classes::TAlignment Value);
	virtual void __fastcall SetGradientColorStyle(Rzcommon::TRzGradientColorStyle Value);
	virtual void __fastcall SetSelectionColorStart(Graphics::TColor Value);
	virtual void __fastcall SetSelectionColorStop(Graphics::TColor Value);
	virtual void __fastcall SetSelectionFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetDown(bool Value);
	virtual void __fastcall SetDropDownMenu(Menus::TPopupMenu* Value);
	virtual void __fastcall SetFlat(bool Value);
	virtual void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetHotIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetImageIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetDownIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetDisabledIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetImages(Imglist::TCustomImageList* Value);
	bool __fastcall IsLayoutStored(void);
	virtual void __fastcall SetUseToolbarButtonLayout(bool Value);
	virtual void __fastcall SetLayout(Buttons::TButtonLayout Value);
	virtual void __fastcall SetParent(Controls::TWinControl* Value);
	bool __fastcall IsSizeStored(void);
	virtual void __fastcall SetUseToolbarButtonSize(bool Value);
	virtual int __fastcall GetWidth(void);
	HIDESBASE virtual void __fastcall SetWidth(int Value);
	virtual int __fastcall GetHeight(void);
	HIDESBASE virtual void __fastcall SetHeight(int Value);
	bool __fastcall IsShowCaptionStored(void);
	virtual void __fastcall SetUseToolbarShowCaption(bool Value);
	virtual void __fastcall SetShowCaption(bool Value);
	virtual void __fastcall SetToolStyle(TRzToolStyle Value);
	virtual void __fastcall SetTransparent(bool Value);
	bool __fastcall IsVisualStyleStored(void);
	virtual void __fastcall SetUseToolbarVisualStyle(bool Value);
	virtual void __fastcall SetVisualStyle(Rzcommon::TRzVisualStyle Value);
	
public:
	__fastcall virtual TRzToolButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzToolButton(void);
	Imglist::TCustomImageList* __fastcall ImageList(void);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property Imglist::TImageIndex DisabledIndex = {read=FDisabledIndex, write=SetDisabledIndex, default=-1};
	__property Rzcommon::TRzGradientColorStyle GradientColorStyle = {read=FGradientColorStyle, write=SetGradientColorStyle, stored=IsVisualStyleStored, nodefault};
	__property Graphics::TColor SelectionColorStart = {read=FSelectionColorStart, write=SetSelectionColorStart, default=-16777201};
	__property Graphics::TColor SelectionColorStop = {read=FSelectionColorStop, write=SetSelectionColorStop, default=-16777200};
	__property Graphics::TColor SelectionFrameColor = {read=FSelectionFrameColor, write=SetSelectionFrameColor, default=-16777195};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, stored=IsCheckedStored, default=0};
	__property Imglist::TImageIndex DownIndex = {read=FDownIndex, write=SetDownIndex, default=-1};
	__property Menus::TPopupMenu* DropDownMenu = {read=FDropDownMenu, write=SetDropDownMenu};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property int Height = {read=GetHeight, write=SetHeight, stored=IsSizeStored, default=25};
	__property Imglist::TImageIndex HotIndex = {read=FHotIndex, write=SetHotIndex, default=-1};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, stored=IsImageIndexStored, default=-1};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, stored=IsShowCaptionStored, nodefault};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property bool UseToolbarButtonLayout = {read=FUseToolbarButtonLayout, write=SetUseToolbarButtonLayout, default=1};
	__property bool UseToolbarButtonSize = {read=FUseToolbarButtonSize, write=SetUseToolbarButtonSize, default=1};
	__property bool UseToolbarShowCaption = {read=FUseToolbarShowCaption, write=SetUseToolbarShowCaption, default=1};
	__property bool UseToolbarVisualStyle = {read=FUseToolbarVisualStyle, write=SetUseToolbarVisualStyle, default=1};
	__property TRzToolStyle ToolStyle = {read=FToolStyle, write=SetToolStyle, default=0};
	__property Rzcommon::TRzVisualStyle VisualStyle = {read=FVisualStyle, write=SetVisualStyle, stored=IsVisualStyleStored, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, stored=IsSizeStored, default=25};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property Action ;
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Caption ;
	__property Color  = {default=-16777201};
	__property Constraints ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property Hint ;
	__property ParentBiDiMode  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
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
	__property OnStartDock ;
	__property OnStartDrag ;
};


class PASCALIMPLEMENTATION TRzToolButtonActionLink : public Controls::TControlActionLink 
{
	typedef Controls::TControlActionLink inherited;
	
protected:
	TRzToolButton* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetImageIndex(int Value);
public:
	#pragma option push -w-inl
	/* TBasicActionLink.Create */ inline __fastcall virtual TRzToolButtonActionLink(System::TObject* AClient) : Controls::TControlActionLink(AClient) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TRzToolButtonActionLink(void) { }
	#pragma option pop
	
};


typedef TMetaClass* TRzToolButtonActionLinkClass;

#pragma option push -b-
enum TRzControlButtonStyle { cbsNone, cbsLeft, cbsUp, cbsRight, cbsDown, cbsDropDown };
#pragma option pop

class DELPHICLASS TRzControlButton;
class PASCALIMPLEMENTATION TRzControlButton : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	bool FDown;
	bool FDragging;
	bool FFlat;
	bool FMouseOverButton;
	Graphics::TBitmap* FGlyph;
	Buttons::TNumGlyphs FNumGlyphs;
	bool FRepeatClicks;
	Extctrls::TTimer* FRepeatTimer;
	Word FInitialDelay;
	Word FDelay;
	TRzControlButtonStyle FStyle;
	void __fastcall UpdateTracking(void);
	void __fastcall GlyphChangedHandler(System::TObject* Sender);
	void __fastcall TimerExpired(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall DrawBtnFace(Types::TRect &R);
	virtual void __fastcall DrawSpinButton(Types::TRect &R);
	virtual void __fastcall DrawDropDownButton(Types::TRect &R);
	virtual void __fastcall DrawGlyph(const Types::TRect &R);
	virtual void __fastcall Paint(void);
	virtual Types::TPoint __fastcall GetImageSize();
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	Types::TPoint __fastcall CursorPosition();
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetFlat(bool Value);
	virtual void __fastcall SetGlyph(Graphics::TBitmap* Value);
	virtual void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	virtual void __fastcall SetStyle(TRzControlButtonStyle Value);
	
public:
	__fastcall virtual TRzControlButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzControlButton(void);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property Buttons::TNumGlyphs NumGlyphs = {read=FNumGlyphs, write=SetNumGlyphs, default=1};
	__property Word Delay = {read=FDelay, write=FDelay, default=100};
	__property Word InitialDelay = {read=FInitialDelay, write=FInitialDelay, default=400};
	__property bool RepeatClicks = {read=FRepeatClicks, write=FRepeatClicks, default=0};
	__property TRzControlButtonStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Action ;
	__property Caption ;
	__property Color  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Hint ;
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
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
	__property OnStartDock ;
	__property OnStartDrag ;
};


typedef Shortint TRzBevelWidth;

#pragma option push -b-
enum TRzCaptionPosition { cpCentered, cpXY };
#pragma option pop

class DELPHICLASS TRzShapeButton;
class PASCALIMPLEMENTATION TRzShapeButton : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FAutoSize;
	TRzBevelWidth FBevelWidth;
	Graphics::TColor FBevelHighlightColor;
	Graphics::TColor FBevelShadowColor;
	Graphics::TBitmap* FBitmap;
	Graphics::TBitmap* FBitmapUp;
	Graphics::TBitmap* FBitmapDown;
	Forms::TFormBorderStyle FBorderStyle;
	Graphics::TColor FBorderColor;
	bool FDragging;
	Graphics::TBitmap* FHitTestMask;
	bool FPrevCursorSaved;
	Controls::TCursor FPrevCursor;
	bool FPrevShowHintSaved;
	bool FPrevShowHint;
	bool FPrevParentShowHint;
	bool FPreciseClick;
	bool FPreciseShowHint;
	TRzCaptionPosition FCaptionPosition;
	int FCaptionX;
	int FCaptionY;
	void __fastcall AdjustBounds(void);
	void __fastcall AdjustButtonSize(int &W, int &H);
	Graphics::TColor __fastcall BevelColor(const Buttons::TButtonState AState, const bool TopLeft);
	void __fastcall BitmapChanged(System::TObject* Sender);
	void __fastcall Create3DBitmap(Graphics::TBitmap* Source, const Buttons::TButtonState AState, Graphics::TBitmap* Target);
	void __fastcall InitPalette(unsigned int DC);
	#pragma option push -w-inl
	inline void __fastcall InitPalette(HDC DC) {TRzShapeButton::InitPalette((unsigned int)DC);}
	#pragma option pop
	MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMHitTest(Messages::TWMNCHitTest &Msg);
	
protected:
	Buttons::TButtonState FState;
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall DrawButtonText(Graphics::TCanvas* Canvas, const AnsiString Caption, const Types::TRect &TextBounds, Buttons::TButtonState State);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual Types::TRect __fastcall GetCaptionRect(Graphics::TCanvas* Canvas, const AnsiString Caption);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall ReadBitmapUpData(Classes::TStream* Stream);
	virtual void __fastcall WriteBitmapUpData(Classes::TStream* Stream);
	virtual void __fastcall ReadBitmapDownData(Classes::TStream* Stream);
	virtual void __fastcall WriteBitmapDownData(Classes::TStream* Stream);
	virtual void __fastcall SetAutoSize(bool Value);
	virtual void __fastcall SetBevelHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetBevelShadowColor(Graphics::TColor Value);
	virtual void __fastcall SetBevelWidth(TRzBevelWidth Value);
	virtual void __fastcall SetBitmap(Graphics::TBitmap* Value);
	virtual void __fastcall SetBitmapDown(Graphics::TBitmap* Value);
	virtual void __fastcall SetBitmapUp(Graphics::TBitmap* Value);
	virtual void __fastcall SetBorderColor(Graphics::TColor Value);
	virtual void __fastcall SetBorderStyle(Forms::TBorderStyle Value);
	virtual void __fastcall SetCaptionPosition(TRzCaptionPosition Value);
	virtual void __fastcall SetCaptionX(int Value);
	virtual void __fastcall SetCaptionY(int Value);
	
public:
	__fastcall virtual TRzShapeButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzShapeButton(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall Invalidate(void);
	virtual bool __fastcall PtInMask(const int X, const int Y);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual void __fastcall SetCaptionXY(const int X, const int Y);
	__property Graphics::TBitmap* BitmapUp = {read=FBitmapUp};
	__property Graphics::TBitmap* BitmapDown = {read=FBitmapDown};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property Graphics::TColor BevelHighlightColor = {read=FBevelHighlightColor, write=SetBevelHighlightColor, default=-16777196};
	__property Graphics::TColor BevelShadowColor = {read=FBevelShadowColor, write=SetBevelShadowColor, default=-16777200};
	__property TRzBevelWidth BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=2};
	__property Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777195};
	__property bool PreciseClick = {read=FPreciseClick, write=FPreciseClick, default=1};
	__property bool PreciseShowHint = {read=FPreciseShowHint, write=FPreciseShowHint, default=1};
	__property TRzCaptionPosition CaptionPosition = {read=FCaptionPosition, write=SetCaptionPosition, default=0};
	__property int CaptionX = {read=FCaptionX, write=SetCaptionX, default=0};
	__property int CaptionY = {read=FCaptionY, write=SetCaptionY, default=0};
	__property Anchors  = {default=3};
	__property Caption ;
	__property Constraints ;
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property ShowHint ;
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDrag ;
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString BitBtnCaptions[11];
static const Word cm_RzButtonPressed = 0x2421;
extern PACKAGE Graphics::TBitmap* __fastcall GetBitBtnGlyph(Buttons::TBitBtnKind Kind);

}	/* namespace Rzbutton */
using namespace Rzbutton;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzbutton
