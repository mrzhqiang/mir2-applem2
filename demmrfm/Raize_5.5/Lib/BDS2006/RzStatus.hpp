// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzstatus.pas' rev: 10.00

#ifndef RzstatusHPP
#define RzstatusHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Rzprgres.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzstatus
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzCustomStatusPane;
class PASCALIMPLEMENTATION TRzCustomStatusPane : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Classes::TAlignment FAlignment;
	bool FAutoSize;
	bool FAutoHint;
	int FDefaultWidth;
	Graphics::TColor FBlinkColor;
	Rzcommon::TBlinkState FBlinkState;
	bool FBlinking;
	Graphics::TColor FFontColor;
	Controls::TBorderWidth FBorderWidth;
	AnsiString FCaption;
	int FCaptionOffset;
	bool FParentFillColor;
	Graphics::TColor FFillColor;
	Graphics::TColor FFlatColor;
	int FFlatColorAdjustment;
	Rzcommon::TFrameStyleEx FFrameStyle;
	Rzcommon::TRzFrameController* FFrameController;
	Rzcommon::TRzFrameControllerNotifications FFrameControllerNotifications;
	bool FTransparent;
	MESSAGE void __fastcall CMGetBlinking(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMBlink(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMHitTest(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	
protected:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Graphics::TColor FCurrentColor;
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall AdjustBounds(void);
	virtual int __fastcall GetMinWidth(void);
	virtual Types::TRect __fastcall GetCaptionRect();
	virtual void __fastcall DrawCaption(const AnsiString CaptionStr);
	virtual void __fastcall DrawStatusBorder(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CustomFramingChanged(void);
	virtual void __fastcall Blink(Rzcommon::TBlinkState State);
	virtual void __fastcall SetAlignment(Classes::TAlignment Value);
	virtual void __fastcall SetAutoSize(bool Value);
	virtual void __fastcall SetDefaultWidth(int Value);
	virtual void __fastcall SetBlinking(bool Value);
	virtual void __fastcall SetBlinkColor(Graphics::TColor Value);
	virtual Word __fastcall GetBlinkIntervalOff(void);
	virtual void __fastcall SetBlinkIntervalOff(Word Value);
	virtual Word __fastcall GetBlinkIntervalOn(void);
	virtual void __fastcall SetBlinkIntervalOn(Word Value);
	virtual void __fastcall SetBorderWidth(Controls::TBorderWidth Value);
	virtual void __fastcall SetCaption(AnsiString Value);
	virtual void __fastcall SetCaptionOffset(int Value);
	bool __fastcall IsFillColorStored(void);
	virtual void __fastcall SetFillColor(Graphics::TColor Value);
	virtual void __fastcall SetParentFillColor(bool Value);
	virtual void __fastcall SetFlatColor(Graphics::TColor Value);
	virtual void __fastcall SetFlatColorAdjustment(int Value);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual bool __fastcall UnderSizeGrip(const Types::TRect &R);
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property bool AutoHint = {read=FAutoHint, write=FAutoHint, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=0};
	__property bool Blinking = {read=FBlinking, write=SetBlinking, default=0};
	__property Graphics::TColor BlinkColor = {read=FBlinkColor, write=SetBlinkColor, default=-16777203};
	__property Rzcommon::TBlinkState BlinkState = {read=FBlinkState, nodefault};
	__property Word BlinkIntervalOff = {read=GetBlinkIntervalOff, write=SetBlinkIntervalOff, default=500};
	__property Word BlinkIntervalOn = {read=GetBlinkIntervalOn, write=SetBlinkIntervalOn, default=500};
	__property int CaptionOffset = {read=FCaptionOffset, write=SetCaptionOffset, default=2};
	__property AnsiString Caption = {read=FCaption, write=SetCaption};
	__property int DefaultWidth = {read=FDefaultWidth, write=SetDefaultWidth, default=40};
	
public:
	__fastcall virtual TRzCustomStatusPane(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomStatusPane(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	bool __fastcall UseThemes(void);
	__property Canvas ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Controls::TBorderWidth BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=1};
	__property Graphics::TColor FillColor = {read=FFillColor, write=SetFillColor, stored=IsFillColorStored, default=-16777201};
	__property Graphics::TColor FlatColor = {read=FFlatColor, write=SetFlatColor, default=-16777200};
	__property int FlatColorAdjustment = {read=FFlatColorAdjustment, write=SetFlatColorAdjustment, default=30};
	__property Rzcommon::TFrameStyle FrameStyle = {read=FFrameStyle, write=SetFrameStyle, default=1};
	__property Rzcommon::TRzFrameControllerNotifications FrameControllerNotifications = {read=FFrameControllerNotifications, write=FFrameControllerNotifications, default=65535};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property bool ParentFillColor = {read=FParentFillColor, write=SetParentFillColor, default=1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property Height  = {default=20};
	__property ParentColor  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property Visible  = {default=1};
	__property Width  = {default=100};
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
	__property OnStartDock ;
	__property OnStartDrag ;
private:
	void *__IRzCustomFramingNotification;	/* Rzcommon::IRzCustomFramingNotification */
	
public:
	operator IRzCustomFramingNotification*(void) { return (IRzCustomFramingNotification*)&__IRzCustomFramingNotification; }
	
};


class DELPHICLASS TRzStatusPane;
class PASCALIMPLEMENTATION TRzStatusPane : public TRzCustomStatusPane 
{
	typedef TRzCustomStatusPane inherited;
	
__published:
	__property Alignment  = {default=0};
	__property AutoHint  = {default=0};
	__property AutoSize  = {default=0};
	__property Blinking  = {default=0};
	__property BlinkColor  = {default=-16777203};
	__property BlinkIntervalOff  = {default=500};
	__property BlinkIntervalOn  = {default=500};
	__property Caption ;
	__property CaptionOffset  = {default=2};
	__property DefaultWidth  = {default=40};
public:
	#pragma option push -w-inl
	/* TRzCustomStatusPane.Create */ inline __fastcall virtual TRzStatusPane(Classes::TComponent* AOwner) : TRzCustomStatusPane(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomStatusPane.Destroy */ inline __fastcall virtual ~TRzStatusPane(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TGlyphAlignment { gaLeft, gaRight };
#pragma option pop

class DELPHICLASS TRzCustomGlyphStatus;
class PASCALIMPLEMENTATION TRzCustomGlyphStatus : public TRzCustomStatusPane 
{
	typedef TRzCustomStatusPane inherited;
	
private:
	Graphics::TBitmap* FGlyph;
	TGlyphAlignment FGlyphAlignment;
	int FGlyphOffset;
	Buttons::TNumGlyphs FNumGlyphs;
	bool FShowGlyph;
	Imglist::TImageIndex FImageIndex;
	Imglist::TImageIndex FDisabledIndex;
	Imglist::TCustomImageList* FImages;
	Imglist::TChangeLink* FImagesChangeLink;
	void __fastcall GlyphChangedHandler(System::TObject* Sender);
	void __fastcall ImagesChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Types::TRect __fastcall GetCaptionRect();
	virtual int __fastcall GetMinWidth(void);
	Types::TPoint __fastcall GetImageSize();
	virtual void __fastcall Paint(void);
	virtual void __fastcall DrawGlyph(const Types::TRect &R);
	virtual void __fastcall DrawImage(const Types::TRect &R);
	virtual void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	virtual void __fastcall SetGlyph(Graphics::TBitmap* Value);
	virtual void __fastcall SetGlyphAlignment(TGlyphAlignment Value);
	virtual void __fastcall SetGlyphOffset(int Value);
	virtual void __fastcall SetShowGlyph(bool Value);
	virtual void __fastcall SetImageIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetDisabledIndex(Imglist::TImageIndex Value);
	virtual void __fastcall SetImages(Imglist::TCustomImageList* Value);
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property TGlyphAlignment GlyphAlignment = {read=FGlyphAlignment, write=SetGlyphAlignment, default=0};
	__property int GlyphOffset = {read=FGlyphOffset, write=SetGlyphOffset, default=2};
	__property Buttons::TNumGlyphs NumGlyphs = {read=FNumGlyphs, write=SetNumGlyphs, default=1};
	__property bool ShowGlyph = {read=FShowGlyph, write=SetShowGlyph, default=1};
	__property Imglist::TImageIndex DisabledIndex = {read=FDisabledIndex, write=SetDisabledIndex, default=-1};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	
public:
	__fastcall virtual TRzCustomGlyphStatus(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomGlyphStatus(void);
};


class DELPHICLASS TRzGlyphStatus;
class PASCALIMPLEMENTATION TRzGlyphStatus : public TRzCustomGlyphStatus 
{
	typedef TRzCustomGlyphStatus inherited;
	
__published:
	__property Alignment  = {default=0};
	__property AutoHint  = {default=0};
	__property AutoSize  = {default=0};
	__property Blinking  = {default=0};
	__property BlinkColor  = {default=-16777203};
	__property BlinkIntervalOff  = {default=500};
	__property BlinkIntervalOn  = {default=500};
	__property Caption ;
	__property CaptionOffset  = {default=2};
	__property DefaultWidth  = {default=40};
	__property Glyph ;
	__property GlyphAlignment  = {default=0};
	__property GlyphOffset  = {default=2};
	__property ImageIndex  = {default=-1};
	__property DisabledIndex  = {default=-1};
	__property Images ;
	__property NumGlyphs  = {default=1};
	__property ShowGlyph  = {default=1};
public:
	#pragma option push -w-inl
	/* TRzCustomGlyphStatus.Create */ inline __fastcall virtual TRzGlyphStatus(Classes::TComponent* AOwner) : TRzCustomGlyphStatus(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomGlyphStatus.Destroy */ inline __fastcall virtual ~TRzGlyphStatus(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzPollingStatus;
class PASCALIMPLEMENTATION TRzPollingStatus : public TRzCustomStatusPane 
{
	typedef TRzCustomStatusPane inherited;
	
private:
	Classes::TNotifyEvent FOnTimerExpired;
	
protected:
	DYNAMIC void __fastcall TimerExpired(void);
	virtual bool __fastcall GetActive(void);
	virtual void __fastcall SetActive(bool Value);
	virtual Word __fastcall GetInterval(void);
	virtual void __fastcall SetInterval(Word Value);
	
public:
	__fastcall virtual TRzPollingStatus(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzPollingStatus(void);
	
__published:
	__property bool Active = {read=GetActive, write=SetActive, default=1};
	__property Word Interval = {read=GetInterval, write=SetInterval, default=500};
	__property Classes::TNotifyEvent OnTimerExpired = {read=FOnTimerExpired, write=FOnTimerExpired};
};


typedef void __fastcall (__closure *TRzGetDateTimeEvent)(System::TObject* Sender, System::TDateTime &DateTime);

class DELPHICLASS TRzClockStatus;
class PASCALIMPLEMENTATION TRzClockStatus : public TRzPollingStatus 
{
	typedef TRzPollingStatus inherited;
	
private:
	AnsiString FFormat;
	AnsiString FDateTimeStr;
	TRzGetDateTimeEvent FOnGetDateTime;
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall TimerExpired(void);
	virtual Types::TRect __fastcall GetCaptionRect();
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetCurrentDateTimeStr(void);
	void __fastcall SetFormat(AnsiString Value);
	
public:
	__fastcall virtual TRzClockStatus(Classes::TComponent* AOwner);
	
__published:
	__property AnsiString Format = {read=FFormat, write=SetFormat};
	__property TRzGetDateTimeEvent OnGetDateTime = {read=FOnGetDateTime, write=FOnGetDateTime};
	__property Alignment  = {default=0};
	__property AutoSize  = {default=0};
	__property Blinking  = {default=0};
	__property BlinkColor  = {default=-16777203};
	__property BlinkIntervalOff  = {default=500};
	__property BlinkIntervalOn  = {default=500};
	__property CaptionOffset  = {default=2};
	__property DefaultWidth  = {default=40};
	__property Width  = {default=150};
public:
	#pragma option push -w-inl
	/* TRzPollingStatus.Destroy */ inline __fastcall virtual ~TRzClockStatus(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzToggleKey { tkCapsLock, tkNumLock, tkScrollLock, tkInsert };
#pragma option pop

#pragma option push -b-
enum TRzToggleState { tsOn, tsOff };
#pragma option pop

#pragma option push -b-
enum TRzInsertState { isInsert, isOverwrite };
#pragma option pop

#pragma option push -b-
enum TRzKeyOffAppearance { koaBlank, koaDimmed };
#pragma option pop

class DELPHICLASS TRzKeyStrings;
class DELPHICLASS TRzKeyStatus;
class PASCALIMPLEMENTATION TRzKeyStatus : public TRzPollingStatus 
{
	typedef TRzPollingStatus inherited;
	
private:
	TRzToggleKey FKey;
	TRzKeyStrings* FKeyStrings;
	bool FStoreKeyStrings;
	TRzToggleState FState;
	TRzInsertState FInitInsertState;
	TRzInsertState FCurrentInsertState;
	bool FInitInsertKeyState;
	TRzKeyOffAppearance FKeyOffAppearance;
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall TimerExpired(void);
	virtual void __fastcall Paint(void);
	AnsiString __fastcall GetKeyString(TRzToggleKey Key);
	void __fastcall KeyStringChanged(void);
	virtual void __fastcall SetKey(TRzToggleKey Value);
	virtual void __fastcall SetKeyOffAppearance(TRzKeyOffAppearance Value);
	virtual void __fastcall SetKeyStrings(TRzKeyStrings* Value);
	virtual void __fastcall SetState(TRzToggleState Value);
	virtual void __fastcall SetInitInsertState(TRzInsertState Value);
	virtual void __fastcall SetCurrentInsertState(TRzInsertState Value);
	TRzInsertState __fastcall GetInsertState(void);
	void __fastcall SetInsertState(TRzInsertState Value);
	
public:
	__fastcall virtual TRzKeyStatus(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzKeyStatus(void);
	__property TRzToggleState State = {read=FState, nodefault};
	
__published:
	__property TRzToggleKey Key = {read=FKey, write=SetKey, default=0};
	__property TRzKeyOffAppearance KeyOffAppearance = {read=FKeyOffAppearance, write=SetKeyOffAppearance, default=0};
	__property TRzKeyStrings* KeyStrings = {read=FKeyStrings, write=SetKeyStrings, stored=FStoreKeyStrings};
	__property TRzInsertState InsertState = {read=GetInsertState, write=SetInsertState, default=0};
	__property Alignment  = {default=0};
	__property AutoSize  = {default=0};
	__property Blinking  = {default=0};
	__property BlinkColor  = {default=-16777203};
	__property BlinkIntervalOff  = {default=500};
	__property BlinkIntervalOn  = {default=500};
	__property DefaultWidth  = {default=40};
	__property Width  = {default=45};
};


class PASCALIMPLEMENTATION TRzKeyStrings : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TRzKeyStatus* FKeyStatus;
	AnsiString FCapsLock;
	AnsiString FNumLock;
	AnsiString FScrollLock;
	AnsiString FInsert;
	AnsiString FOverwrite;
	
protected:
	void __fastcall SetKeyString(int Index, const AnsiString Value);
	
public:
	__fastcall TRzKeyStrings(void);
	
__published:
	__property AnsiString CapsLock = {read=FCapsLock, write=SetKeyString, index=0};
	__property AnsiString NumLock = {read=FNumLock, write=SetKeyString, index=1};
	__property AnsiString ScrollLock = {read=FScrollLock, write=SetKeyString, index=2};
	__property AnsiString Insert = {read=FInsert, write=SetKeyString, index=3};
	__property AnsiString Overwrite = {read=FOverwrite, write=SetKeyString, index=4};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRzKeyStrings(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TResourceType { rtSystem, rtMemory };
#pragma option pop

#pragma option push -b-
enum TDisplayStyle { dsBar, dsText };
#pragma option pop

class DELPHICLASS TRzResourceStrings;
class DELPHICLASS TRzResourceStatus;
class PASCALIMPLEMENTATION TRzResourceStatus : public TRzPollingStatus 
{
	typedef TRzPollingStatus inherited;
	
private:
	TRzResourceStrings* FResourceStrings;
	bool FStoreResourceStrings;
	Graphics::TColor FBackColor;
	Graphics::TColor FBackColorStop;
	Graphics::TColor FBarColor;
	Graphics::TColor FBarColorStop;
	Rzcommon::TBarStyle FBarStyle;
	int FFreeMemory;
	int FFreePercent;
	Rzcommon::TGradientDirection FGradientDirection;
	Rzcommon::TOrientation FOrientation;
	Rzprgres::TSegmentRange FNumSegments;
	TResourceType FResourceType;
	bool FShowPercent;
	TDisplayStyle FDisplayStyle;
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	DYNAMIC void __fastcall TimerExpired(void);
	virtual void __fastcall Paint(void);
	AnsiString __fastcall GetResourceString(TResourceType ResType);
	void __fastcall ResourceStringChanged(void);
	virtual void __fastcall SetBackColor(Graphics::TColor Value);
	void __fastcall SetBackColorStop(Graphics::TColor Value);
	virtual void __fastcall SetBarColor(Graphics::TColor Value);
	void __fastcall SetBarColorStop(Graphics::TColor Value);
	virtual void __fastcall SetBarStyle(Rzcommon::TBarStyle Value);
	virtual void __fastcall SetDisplayStyle(TDisplayStyle Value);
	void __fastcall SetGradientDirection(Rzcommon::TGradientDirection Value);
	virtual void __fastcall SetNumSegments(Rzprgres::TSegmentRange Value);
	virtual void __fastcall SetOrientation(Rzcommon::TOrientation Value);
	virtual void __fastcall SetResourceStrings(TRzResourceStrings* Value);
	virtual void __fastcall SetShowPercent(bool Value);
	
public:
	__fastcall virtual TRzResourceStatus(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzResourceStatus(void);
	__property int FreeMemory = {read=FFreeMemory, nodefault};
	__property int FreePercent = {read=FFreePercent, nodefault};
	
__published:
	__property Graphics::TColor BackColor = {read=FBackColor, write=SetBackColor, default=-16777201};
	__property Graphics::TColor BackColorStop = {read=FBackColorStop, write=SetBackColorStop, default=-16777201};
	__property Graphics::TColor BarColor = {read=FBarColor, write=SetBarColor, default=-16777203};
	__property Graphics::TColor BarColorStop = {read=FBarColorStop, write=SetBarColorStop, default=-16777190};
	__property Rzcommon::TBarStyle BarStyle = {read=FBarStyle, write=SetBarStyle, default=0};
	__property TDisplayStyle DisplayStyle = {read=FDisplayStyle, write=SetDisplayStyle, default=0};
	__property Rzcommon::TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=3};
	__property Rzprgres::TSegmentRange NumSegments = {read=FNumSegments, write=SetNumSegments, default=15};
	__property Rzcommon::TOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property TRzResourceStrings* ResourceStrings = {read=FResourceStrings, write=SetResourceStrings, stored=FStoreResourceStrings};
	__property bool ShowPercent = {read=FShowPercent, write=SetShowPercent, default=0};
	__property Alignment  = {default=0};
	__property Blinking  = {default=0};
	__property BlinkColor  = {default=-16777203};
	__property BlinkIntervalOff  = {default=500};
	__property BlinkIntervalOn  = {default=500};
	__property CaptionOffset  = {default=2};
	__property Hint  = {stored=false};
	__property ShowHint  = {default=1};
};


class PASCALIMPLEMENTATION TRzResourceStrings : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TRzResourceStatus* FResourceStatus;
	AnsiString FSystem;
	AnsiString FMemory;
	
protected:
	void __fastcall SetResourceString(int Index, const AnsiString Value);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	
public:
	__fastcall TRzResourceStrings(void);
	
__published:
	__property AnsiString System = {read=FSystem, write=SetResourceString, index=0};
	__property AnsiString Memory = {read=FMemory, write=SetResourceString, index=1};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRzResourceStrings(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzMarqueeStatus;
class PASCALIMPLEMENTATION TRzMarqueeStatus : public TRzStatusPane 
{
	typedef TRzStatusPane inherited;
	
private:
	Rzcommon::TRzScrollType FScrollType;
	bool FScrolling;
	int FSteps;
	Word FScrollDelay;
	Word FScrollSize;
	Graphics::TBitmap* FBitmap;
	Extctrls::TTimer* FTimer;
	int FCurrentStep;
	Rzcommon::TRzScrollDisplayEvent FOnScrollDisplay;
	Classes::TNotifyEvent FOnScrollComplete;
	void __fastcall TimerEventHandler(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall DrawCaption(const AnsiString CaptionStr);
	void __fastcall UpdateSteps(void);
	DYNAMIC void __fastcall ScrollDisplay(int CurrentStep, int TotalSteps);
	DYNAMIC void __fastcall ScrollComplete(void);
	void __fastcall SetScrollType(Rzcommon::TRzScrollType Value);
	virtual void __fastcall SetScrolling(bool Value);
	virtual void __fastcall SetScrollSize(Word Value);
	void __fastcall SetScrollDelay(Word Value);
	
public:
	__fastcall virtual TRzMarqueeStatus(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzMarqueeStatus(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Rzcommon::TRzScrollType ScrollType = {read=FScrollType, write=SetScrollType, default=1};
	__property bool Scrolling = {read=FScrolling, write=SetScrolling, default=1};
	__property Word ScrollSize = {read=FScrollSize, write=SetScrollSize, default=1};
	__property Word ScrollDelay = {read=FScrollDelay, write=SetScrollDelay, default=100};
	__property Rzcommon::TRzScrollDisplayEvent OnScrollDisplay = {read=FOnScrollDisplay, write=FOnScrollDisplay};
	__property Classes::TNotifyEvent OnScrollComplete = {read=FOnScrollComplete, write=FOnScrollComplete};
};


class DELPHICLASS TRzCustomFieldStatus;
class PASCALIMPLEMENTATION TRzCustomFieldStatus : public TRzCustomStatusPane 
{
	typedef TRzCustomStatusPane inherited;
	
private:
	AnsiString FFieldLabel;
	Graphics::TColor FFieldLabelColor;
	
protected:
	virtual int __fastcall GetMinWidth(void);
	virtual Types::TRect __fastcall GetCaptionRect();
	virtual void __fastcall DrawCaption(const AnsiString CaptionStr);
	virtual void __fastcall SetFieldLabel(const AnsiString Value);
	virtual void __fastcall SetFieldLabelColor(Graphics::TColor Value);
	
public:
	__fastcall virtual TRzCustomFieldStatus(Classes::TComponent* AOwner);
	
__published:
	__property AnsiString FieldLabel = {read=FFieldLabel, write=SetFieldLabel};
	__property Graphics::TColor FieldLabelColor = {read=FFieldLabelColor, write=SetFieldLabelColor, default=-16777203};
	__property Alignment  = {default=0};
	__property AutoSize  = {default=0};
	__property Blinking  = {default=0};
	__property BlinkColor  = {default=-16777203};
	__property BlinkIntervalOff  = {default=500};
	__property BlinkIntervalOn  = {default=500};
	__property CaptionOffset  = {default=2};
public:
	#pragma option push -w-inl
	/* TRzCustomStatusPane.Destroy */ inline __fastcall virtual ~TRzCustomFieldStatus(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzFieldStatus;
class PASCALIMPLEMENTATION TRzFieldStatus : public TRzCustomFieldStatus 
{
	typedef TRzCustomFieldStatus inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property AutoHint  = {default=0};
	__property Caption ;
public:
	#pragma option push -w-inl
	/* TRzCustomFieldStatus.Create */ inline __fastcall virtual TRzFieldStatus(Classes::TComponent* AOwner) : TRzCustomFieldStatus(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TRzCustomStatusPane.Destroy */ inline __fastcall virtual ~TRzFieldStatus(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzVersionInfoField { vifCompanyName, vifFileDescription, vifFileVersion, vifInternalName, vifCopyright, vifTrademarks, vifOriginalFilename, vifProductName, vifProductVersion, vifComments };
#pragma option pop

class DELPHICLASS TRzVersionInfo;
class DELPHICLASS TRzVersionInfoStatus;
class PASCALIMPLEMENTATION TRzVersionInfo : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
public:
	AnsiString operator[](TRzVersionInfoField Index) { return Fields[Index]; }
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	AnsiString FFilePath;
	Classes::TStringList* FVersionInfo;
	bool FVersionInfoAvailable;
	Classes::TList* FStatusList;
	Word FVersionNumbers[4];
	bool FModuleAttributes[4];
	
protected:
	virtual void __fastcall Loaded(void);
	void __fastcall GetVersionInfo(void);
	AnsiString __fastcall GetField(int Index);
	AnsiString __fastcall GetVerField(TRzVersionInfoField Index);
	Word __fastcall GetVersionNumber(int Index);
	bool __fastcall GetModuleAttribute(int Index);
	System::TDateTime __fastcall GetFileDateTime(void);
	void __fastcall UpdateStatusControls(void);
	virtual void __fastcall SetFilePath(const AnsiString Value);
	__property AnsiString Fields[TRzVersionInfoField Index] = {read=GetVerField/*, default*/};
	
public:
	__fastcall virtual TRzVersionInfo(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzVersionInfo(void);
	void __fastcall AddStatus(TRzVersionInfoStatus* S);
	void __fastcall RemoveStatus(TRzVersionInfoStatus* S);
	AnsiString __fastcall GetCustomKeyValue(const AnsiString Key);
	__property bool VersionInfoAvailable = {read=FVersionInfoAvailable, nodefault};
	__property AnsiString CompanyName = {read=GetField, index=0};
	__property AnsiString FileDescription = {read=GetField, index=1};
	__property AnsiString FileVersion = {read=GetField, index=2};
	__property AnsiString InternalName = {read=GetField, index=3};
	__property AnsiString Copyright = {read=GetField, index=4};
	__property AnsiString Trademarks = {read=GetField, index=5};
	__property AnsiString OriginalFilename = {read=GetField, index=6};
	__property AnsiString ProductName = {read=GetField, index=7};
	__property AnsiString ProductVersion = {read=GetField, index=8};
	__property AnsiString Comments = {read=GetField, index=9};
	__property Word MajorVersion = {read=GetVersionNumber, index=1, nodefault};
	__property Word MinorVersion = {read=GetVersionNumber, index=2, nodefault};
	__property Word Release = {read=GetVersionNumber, index=3, nodefault};
	__property Word Build = {read=GetVersionNumber, index=4, nodefault};
	__property bool DebugBuild = {read=GetModuleAttribute, index=1, nodefault};
	__property bool PreRelease = {read=GetModuleAttribute, index=2, nodefault};
	__property bool PrivateBuild = {read=GetModuleAttribute, index=3, nodefault};
	__property bool SpecialBuild = {read=GetModuleAttribute, index=4, nodefault};
	__property System::TDateTime FileDateTime = {read=GetFileDateTime};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property AnsiString FilePath = {read=FFilePath, write=SetFilePath};
};


class PASCALIMPLEMENTATION TRzVersionInfoStatus : public TRzCustomFieldStatus 
{
	typedef TRzCustomFieldStatus inherited;
	
private:
	TRzVersionInfo* FVersionInfo;
	TRzVersionInfoField FField;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall UpdateCaption(void);
	virtual void __fastcall SetVersionInfo(TRzVersionInfo* Value);
	virtual void __fastcall SetField(TRzVersionInfoField Value);
	
public:
	__fastcall virtual TRzVersionInfoStatus(Classes::TComponent* AOwner);
	
__published:
	__property TRzVersionInfoField Field = {read=FField, write=SetField, nodefault};
	__property TRzVersionInfo* VersionInfo = {read=FVersionInfo, write=SetVersionInfo};
	__property Alignment  = {default=0};
	__property AutoSize  = {default=0};
	__property Blinking  = {default=0};
	__property BlinkColor  = {default=-16777203};
	__property BlinkIntervalOff  = {default=500};
	__property BlinkIntervalOn  = {default=500};
	__property CaptionOffset  = {default=2};
public:
	#pragma option push -w-inl
	/* TRzCustomStatusPane.Destroy */ inline __fastcall virtual ~TRzVersionInfoStatus(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzProgressStatus;
class PASCALIMPLEMENTATION TRzProgressStatus : public TRzCustomStatusPane 
{
	typedef TRzCustomStatusPane inherited;
	
private:
	Graphics::TColor FBackColor;
	Graphics::TColor FBackColorStop;
	Graphics::TColor FBarColor;
	Graphics::TColor FBarColorStop;
	Rzcommon::TBarStyle FBarStyle;
	Rzcommon::TGradientDirection FGradientDirection;
	Rzprgres::TSegmentRange FNumSegments;
	Rzprgres::TUnsignedLongint FPartsComplete;
	Word FPercent;
	bool FShowPercent;
	bool FShowParts;
	Rzprgres::TUnsignedLongint FTotalParts;
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetBackColor(Graphics::TColor Value);
	void __fastcall SetBackColorStop(Graphics::TColor Value);
	virtual void __fastcall SetBarColor(Graphics::TColor Value);
	void __fastcall SetBarColorStop(Graphics::TColor Value);
	virtual void __fastcall SetBarStyle(Rzcommon::TBarStyle Value);
	void __fastcall SetGradientDirection(Rzcommon::TGradientDirection Value);
	virtual void __fastcall SetNumSegments(Rzprgres::TSegmentRange Value);
	virtual void __fastcall SetPartsComplete(Rzprgres::TUnsignedLongint Value);
	virtual void __fastcall SetPercent(Word Value);
	virtual void __fastcall SetShowPercent(bool Value);
	virtual void __fastcall SetShowParts(bool Value);
	virtual void __fastcall SetTotalParts(Rzprgres::TUnsignedLongint Value);
	
public:
	__fastcall virtual TRzProgressStatus(Classes::TComponent* AOwner);
	void __fastcall IncPartsByOne(void);
	void __fastcall IncParts(Rzprgres::TUnsignedLongint N);
	
__published:
	__property Graphics::TColor BackColor = {read=FBackColor, write=SetBackColor, default=-16777201};
	__property Graphics::TColor BackColorStop = {read=FBackColorStop, write=SetBackColorStop, default=-16777201};
	__property Graphics::TColor BarColor = {read=FBarColor, write=SetBarColor, default=-16777203};
	__property Graphics::TColor BarColorStop = {read=FBarColorStop, write=SetBarColorStop, default=-16777190};
	__property Rzcommon::TBarStyle BarStyle = {read=FBarStyle, write=SetBarStyle, default=0};
	__property Rzcommon::TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=3};
	__property Rzprgres::TSegmentRange NumSegments = {read=FNumSegments, write=SetNumSegments, default=15};
	__property Rzprgres::TUnsignedLongint PartsComplete = {read=FPartsComplete, write=SetPartsComplete, nodefault};
	__property Word Percent = {read=FPercent, write=SetPercent, nodefault};
	__property bool ShowPercent = {read=FShowPercent, write=SetShowPercent, default=0};
	__property bool ShowParts = {read=FShowParts, write=SetShowParts, default=0};
	__property Rzprgres::TUnsignedLongint TotalParts = {read=FTotalParts, write=SetTotalParts, nodefault};
	__property Alignment  = {default=0};
	__property Hint  = {stored=false};
	__property ShowHint  = {default=1};
public:
	#pragma option push -w-inl
	/* TRzCustomStatusPane.Destroy */ inline __fastcall virtual ~TRzProgressStatus(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzstatus */
using namespace Rzstatus;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzstatus
