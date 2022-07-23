// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzradgrp.pas' rev: 10.00

#ifndef RzradgrpHPP
#define RzradgrpHPP

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
#include <Rzpanel.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzintlst.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzradgrp
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TRzIndexChangingEvent)(System::TObject* Sender, int NewIndex, bool &AllowChange);

class DELPHICLASS TRzCustomRadioGroup;
class PASCALIMPLEMENTATION TRzCustomRadioGroup : public Rzpanel::TRzCustomGroupBox 
{
	typedef Rzpanel::TRzCustomGroupBox inherited;
	
private:
	Classes::TList* FButtons;
	Graphics::TFont* FItemFont;
	bool FItemFontChanged;
	Classes::TStrings* FItems;
	int FItemIndex;
	int FColumns;
	bool FReading;
	bool FUpdating;
	bool FSpaceEvenly;
	int FStartXPos;
	int FStartYPos;
	int FVerticalSpacing;
	int FItemHeight;
	bool FItemHeightChanged;
	int FGlyphWidth;
	int FGlyphHeight;
	int FNumGlyphs;
	Graphics::TBitmap* FCustomGlyphs;
	Imglist::TCustomImageList* FCustomGlyphImages;
	Imglist::TChangeLink* FCustomGlyphImagesChangeLink;
	bool FUseCustomGlyphs;
	Graphics::TColor FTransparentColor;
	Graphics::TColor FWinMaskColor;
	bool FLightTextStyle;
	Rzcommon::TTextStyle FTextStyle;
	Graphics::TColor FTextHighlightColor;
	Graphics::TColor FTextShadowColor;
	int FTextShadowDepth;
	bool FTabOnEnter;
	Graphics::TColor FItemFrameColor;
	bool FItemHotTrack;
	Graphics::TColor FItemHotTrackColor;
	Rzcommon::TRzHotTrackColorType FItemHotTrackColorType;
	Graphics::TColor FItemHighlightColor;
	bool FReadOnly;
	Graphics::TColor FReadOnlyColor;
	bool FReadOnlyColorOnFocus;
	TRzIndexChangingEvent FOnChanging;
	void __fastcall ReadOldFlatProp(Classes::TReader* Reader);
	void __fastcall ButtonClick(System::TObject* Sender);
	void __fastcall ItemsChange(System::TObject* Sender);
	void __fastcall ItemFontChanged(System::TObject* Sender);
	void __fastcall CustomGlyphsChanged(System::TObject* Sender);
	void __fastcall CustomGlyphImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	virtual void __fastcall SetButtonCount(int Value);
	virtual void __fastcall UpdateButtons(void);
	void __fastcall FocusNextButton(void);
	void __fastcall FocusPreviousButton(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual bool __fastcall CanModify(void);
	virtual void __fastcall CustomFramingChanged(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC bool __fastcall CanChange(int NewIndex);
	virtual Rzradchk::TRzRadioButton* __fastcall GetButtons(int Index);
	virtual AnsiString __fastcall GetCaption();
	virtual void __fastcall SetCaption(const AnsiString Value);
	virtual void __fastcall SetColumns(int Value);
	virtual void __fastcall SetCustomGlyphs(Graphics::TBitmap* Value);
	virtual void __fastcall SetCustomGlyphImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetItemFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetItemHotTrack(bool Value);
	virtual void __fastcall SetItemHotTrackColor(Graphics::TColor Value);
	virtual void __fastcall SetItemHotTrackColorType(Rzcommon::TRzHotTrackColorType Value);
	virtual void __fastcall SetItemHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetBannerHeight(int Value);
	virtual void __fastcall SetGroupBoxStyle(Rzpanel::TRzGroupBoxStyle Value);
	bool __fastcall GetItemEnabled(int Index);
	void __fastcall SetItemEnabled(int Index, bool Value);
	virtual void __fastcall SetItemFont(Graphics::TFont* Value);
	virtual void __fastcall SetItemHeight(int Value);
	virtual void __fastcall SetItemIndex(int Value);
	virtual void __fastcall SetItems(Classes::TStrings* Value);
	virtual void __fastcall SetLightTextStyle(bool Value);
	virtual void __fastcall SetTextHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetTextShadowColor(Graphics::TColor Value);
	virtual void __fastcall SetTextShadowDepth(int Value);
	virtual void __fastcall SetReadOnly(bool Value);
	virtual void __fastcall SetReadOnlyColor(Graphics::TColor Value);
	virtual void __fastcall SetReadOnlyColorOnFocus(bool Value);
	virtual void __fastcall SetSpaceEvenly(bool Value);
	virtual void __fastcall SetStartPos(int Index, int Value);
	virtual void __fastcall SetTextStyle(Rzcommon::TTextStyle Value);
	virtual void __fastcall SetVerticalSpacing(int Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual void __fastcall SetTransparentColor(Graphics::TColor Value);
	virtual void __fastcall SetUseCustomGlyphs(bool Value);
	virtual void __fastcall SetWinMaskColor(Graphics::TColor Value);
	__property Rzradchk::TRzRadioButton* Buttons[int Index] = {read=GetButtons};
	__property AnsiString Caption = {read=GetCaption, write=SetCaption};
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property Graphics::TBitmap* CustomGlyphs = {read=FCustomGlyphs, write=SetCustomGlyphs};
	__property Imglist::TCustomImageList* CustomGlyphImages = {read=FCustomGlyphImages, write=SetCustomGlyphImages};
	__property Graphics::TColor ItemFrameColor = {read=FItemFrameColor, write=SetItemFrameColor, default=-16777200};
	__property bool ItemHotTrack = {read=FItemHotTrack, write=SetItemHotTrack, default=0};
	__property Graphics::TColor ItemHighlightColor = {read=FItemHighlightColor, write=SetItemHighlightColor, default=-16777203};
	__property Graphics::TColor ItemHotTrackColor = {read=FItemHotTrackColor, write=SetItemHotTrackColor, default=1350640};
	__property Rzcommon::TRzHotTrackColorType ItemHotTrackColorType = {read=FItemHotTrackColorType, write=SetItemHotTrackColorType, default=1};
	__property Graphics::TFont* ItemFont = {read=FItemFont, write=SetItemFont, stored=FItemFontChanged};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, stored=FItemHeightChanged, nodefault};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property bool ItemEnabled[int Index] = {read=GetItemEnabled, write=SetItemEnabled};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property bool LightTextStyle = {read=FLightTextStyle, write=SetLightTextStyle, default=0};
	__property Graphics::TColor TextHighlightColor = {read=FTextHighlightColor, write=SetTextHighlightColor, default=-16777196};
	__property Graphics::TColor TextShadowColor = {read=FTextShadowColor, write=SetTextShadowColor, default=-16777200};
	__property int TextShadowDepth = {read=FTextShadowDepth, write=SetTextShadowDepth, default=2};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property Graphics::TColor ReadOnlyColor = {read=FReadOnlyColor, write=SetReadOnlyColor, default=-16777192};
	__property bool ReadOnlyColorOnFocus = {read=FReadOnlyColorOnFocus, write=SetReadOnlyColorOnFocus, default=0};
	__property bool SpaceEvenly = {read=FSpaceEvenly, write=SetSpaceEvenly, default=0};
	__property int StartXPos = {read=FStartXPos, write=SetStartPos, index=1, default=8};
	__property int StartYPos = {read=FStartYPos, write=SetStartPos, index=2, default=2};
	__property bool TabOnEnter = {read=FTabOnEnter, write=FTabOnEnter, default=0};
	__property Rzcommon::TTextStyle TextStyle = {read=FTextStyle, write=SetTextStyle, default=0};
	__property Graphics::TColor TransparentColor = {read=FTransparentColor, write=SetTransparentColor, default=32896};
	__property bool UseCustomGlyphs = {read=FUseCustomGlyphs, write=SetUseCustomGlyphs, default=0};
	__property int VerticalSpacing = {read=FVerticalSpacing, write=SetVerticalSpacing, default=3};
	__property Graphics::TColor WinMaskColor = {read=FWinMaskColor, write=SetWinMaskColor, default=65280};
	__property TRzIndexChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property Alignment  = {default=0};
	__property AlignmentVertical  = {default=0};
	
public:
	__fastcall virtual TRzCustomRadioGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomRadioGroup(void);
	virtual void __fastcall ArrangeButtons(void);
	DYNAMIC void __fastcall FlipChildren(bool AllLevels);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomRadioGroup(HWND ParentWindow) : Rzpanel::TRzCustomGroupBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzRadioGroup;
class PASCALIMPLEMENTATION TRzRadioGroup : public TRzCustomRadioGroup 
{
	typedef TRzCustomRadioGroup inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	
public:
	__property Buttons ;
	__property ItemEnabled ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Align  = {default=0};
	__property Alignment  = {default=0};
	__property Anchors  = {default=3};
	__property BannerHeight  = {default=0};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderColor  = {default=-16777201};
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=0};
	__property BorderSides  = {default=15};
	__property BorderWidth  = {default=0};
	__property Caption ;
	__property CaptionFont ;
	__property Color  = {default=-16777201};
	__property Columns  = {default=1};
	__property Constraints ;
	__property Ctl3D ;
	__property CustomGlyphs ;
	__property CustomGlyphImages ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=30};
	__property Font ;
	__property FrameController ;
	__property GradientColorStyle  = {default=0};
	__property GradientColorStart  = {default=16777215};
	__property GradientColorStop  = {default=-16777201};
	__property GradientDirection  = {default=2};
	__property GroupStyle  = {default=3};
	__property Height  = {default=105};
	__property Hint ;
	__property ItemFrameColor  = {default=-16777200};
	__property ItemHotTrack  = {default=0};
	__property ItemHighlightColor  = {default=-16777203};
	__property ItemHotTrackColor  = {default=1350640};
	__property ItemHotTrackColorType  = {default=1};
	__property ItemFont ;
	__property ItemHeight ;
	__property ItemIndex  = {default=-1};
	__property Items ;
	__property LightTextStyle  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property TextHighlightColor  = {default=-16777196};
	__property TextShadowColor  = {default=-16777200};
	__property TextShadowDepth  = {default=2};
	__property ReadOnly  = {default=0};
	__property ReadOnlyColor  = {default=-16777192};
	__property ReadOnlyColorOnFocus  = {default=0};
	__property ShowHint ;
	__property SpaceEvenly  = {default=0};
	__property StartXPos  = {index=1, default=8};
	__property StartYPos  = {index=2, default=2};
	__property TabOnEnter  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property TextStyle  = {default=0};
	__property Transparent  = {default=0};
	__property TransparentColor  = {default=32896};
	__property UseCustomGlyphs  = {default=0};
	__property VerticalSpacing  = {default=3};
	__property Visible  = {default=1};
	__property VisualStyle  = {default=1};
	__property WinMaskColor  = {default=65280};
	__property OnChanging ;
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnPaint ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TRzCustomRadioGroup.Create */ inline __fastcall virtual TRzRadioGroup(Classes::TComponent* AOwner) : TRzCustomRadioGroup(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomRadioGroup.Destroy */ inline __fastcall virtual ~TRzRadioGroup(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzRadioGroup(HWND ParentWindow) : TRzCustomRadioGroup(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzCustomCheckGroup;
class PASCALIMPLEMENTATION TRzCustomCheckGroup : public Rzpanel::TRzCustomGroupBox 
{
	typedef Rzpanel::TRzCustomGroupBox inherited;
	
private:
	Classes::TList* FChecks;
	Graphics::TFont* FItemFont;
	bool FItemFontChanged;
	Classes::TStrings* FItems;
	int FColumns;
	bool FReading;
	bool FSpaceEvenly;
	int FStartXPos;
	int FStartYPos;
	int FVerticalSpacing;
	int FItemHeight;
	bool FItemHeightChanged;
	int FGlyphWidth;
	int FGlyphHeight;
	int FNumGlyphs;
	Graphics::TBitmap* FCustomGlyphs;
	Imglist::TCustomImageList* FCustomGlyphImages;
	Imglist::TChangeLink* FCustomGlyphImagesChangeLink;
	bool FUseCustomGlyphs;
	Graphics::TColor FTransparentColor;
	Graphics::TColor FWinMaskColor;
	bool FLightTextStyle;
	Rzcommon::TTextStyle FTextStyle;
	Graphics::TColor FTextHighlightColor;
	Graphics::TColor FTextShadowColor;
	int FTextShadowDepth;
	bool FTabOnEnter;
	bool FAllowGrayed;
	Graphics::TColor FItemFrameColor;
	bool FItemHotTrack;
	Graphics::TColor FItemHotTrackColor;
	Rzcommon::TRzHotTrackColorType FItemHotTrackColorType;
	Graphics::TColor FItemHighlightColor;
	bool FReadOnly;
	Graphics::TColor FReadOnlyColor;
	bool FReadOnlyColorOnFocus;
	Rzintlst::TRzIntegerList* FItemStates;
	Rzcommon::TStateChangeEvent FOnChange;
	void __fastcall ReadCheckStates(Classes::TReader* Reader);
	void __fastcall WriteCheckStates(Classes::TWriter* Writer);
	void __fastcall CheckClick(System::TObject* Sender);
	void __fastcall ItemsChange(System::TObject* Sender);
	void __fastcall ItemFontChanged(System::TObject* Sender);
	void __fastcall CustomGlyphsChanged(System::TObject* Sender);
	void __fastcall CustomGlyphImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	
protected:
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	virtual void __fastcall SetCheckCount(int Value);
	virtual void __fastcall UpdateChecks(void);
	int __fastcall GetIndex(Rzradchk::TRzCheckBox* CheckBox);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual bool __fastcall CanModify(void);
	virtual void __fastcall CustomFramingChanged(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall Change(int Index, Stdctrls::TCheckBoxState NewState);
	virtual Rzradchk::TRzCheckBox* __fastcall GetChecks(int Index);
	virtual void __fastcall SetAllowGrayed(bool Value);
	virtual AnsiString __fastcall GetCaption();
	virtual void __fastcall SetCaption(const AnsiString Value);
	virtual void __fastcall SetColumns(int Value);
	virtual void __fastcall SetCustomGlyphs(Graphics::TBitmap* Value);
	virtual void __fastcall SetCustomGlyphImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetGroupBoxStyle(Rzpanel::TRzGroupBoxStyle Value);
	virtual void __fastcall SetItemFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetItemHotTrack(bool Value);
	virtual void __fastcall SetItemHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetItemHotTrackColor(Graphics::TColor Value);
	virtual void __fastcall SetItemHotTrackColorType(Rzcommon::TRzHotTrackColorType Value);
	virtual bool __fastcall GetItemChecked(int Index);
	virtual void __fastcall SetItemChecked(int Index, bool Value);
	virtual bool __fastcall GetItemEnabled(int Index);
	virtual void __fastcall SetItemEnabled(int Index, bool Value);
	virtual void __fastcall SetItemFont(Graphics::TFont* Value);
	virtual void __fastcall SetItemHeight(int Value);
	virtual void __fastcall SetItems(Classes::TStrings* Value);
	virtual Stdctrls::TCheckBoxState __fastcall GetItemState(int Index);
	virtual void __fastcall SetItemState(int Index, Stdctrls::TCheckBoxState Value);
	virtual void __fastcall SetLightTextStyle(bool Value);
	virtual void __fastcall SetTextHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetTextShadowColor(Graphics::TColor Value);
	virtual void __fastcall SetTextShadowDepth(int Value);
	virtual void __fastcall SetReadOnly(bool Value);
	virtual void __fastcall SetReadOnlyColor(Graphics::TColor Value);
	virtual void __fastcall SetReadOnlyColorOnFocus(bool Value);
	virtual void __fastcall SetSpaceEvenly(bool Value);
	virtual void __fastcall SetStartPos(int Index, int Value);
	virtual void __fastcall SetTextStyle(Rzcommon::TTextStyle Value);
	virtual void __fastcall SetVerticalSpacing(int Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual void __fastcall SetTransparentColor(Graphics::TColor Value);
	virtual void __fastcall SetUseCustomGlyphs(bool Value);
	virtual void __fastcall SetWinMaskColor(Graphics::TColor Value);
	__property bool AllowGrayed = {read=FAllowGrayed, write=SetAllowGrayed, default=0};
	__property Rzradchk::TRzCheckBox* Checks[int Index] = {read=GetChecks};
	__property AnsiString Caption = {read=GetCaption, write=SetCaption};
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property Graphics::TBitmap* CustomGlyphs = {read=FCustomGlyphs, write=SetCustomGlyphs};
	__property Imglist::TCustomImageList* CustomGlyphImages = {read=FCustomGlyphImages, write=SetCustomGlyphImages};
	__property Graphics::TColor ItemFrameColor = {read=FItemFrameColor, write=SetItemFrameColor, default=-16777200};
	__property bool ItemHotTrack = {read=FItemHotTrack, write=SetItemHotTrack, default=0};
	__property Graphics::TColor ItemHighlightColor = {read=FItemHighlightColor, write=SetItemHighlightColor, default=-16777203};
	__property Graphics::TColor ItemHotTrackColor = {read=FItemHotTrackColor, write=SetItemHotTrackColor, default=1350640};
	__property Rzcommon::TRzHotTrackColorType ItemHotTrackColorType = {read=FItemHotTrackColorType, write=SetItemHotTrackColorType, default=1};
	__property Graphics::TFont* ItemFont = {read=FItemFont, write=SetItemFont, stored=FItemFontChanged};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, stored=FItemHeightChanged, nodefault};
	__property bool ItemChecked[int Index] = {read=GetItemChecked, write=SetItemChecked};
	__property bool ItemEnabled[int Index] = {read=GetItemEnabled, write=SetItemEnabled};
	__property Stdctrls::TCheckBoxState ItemState[int Index] = {read=GetItemState, write=SetItemState};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property bool LightTextStyle = {read=FLightTextStyle, write=SetLightTextStyle, default=0};
	__property Graphics::TColor TextHighlightColor = {read=FTextHighlightColor, write=SetTextHighlightColor, default=-16777196};
	__property Graphics::TColor TextShadowColor = {read=FTextShadowColor, write=SetTextShadowColor, default=-16777200};
	__property int TextShadowDepth = {read=FTextShadowDepth, write=SetTextShadowDepth, default=2};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property Graphics::TColor ReadOnlyColor = {read=FReadOnlyColor, write=SetReadOnlyColor, default=-16777192};
	__property bool ReadOnlyColorOnFocus = {read=FReadOnlyColorOnFocus, write=SetReadOnlyColorOnFocus, default=0};
	__property bool SpaceEvenly = {read=FSpaceEvenly, write=SetSpaceEvenly, default=0};
	__property int StartXPos = {read=FStartXPos, write=SetStartPos, index=1, default=8};
	__property int StartYPos = {read=FStartYPos, write=SetStartPos, index=2, default=2};
	__property bool TabOnEnter = {read=FTabOnEnter, write=FTabOnEnter, default=0};
	__property Rzcommon::TTextStyle TextStyle = {read=FTextStyle, write=SetTextStyle, default=0};
	__property Graphics::TColor TransparentColor = {read=FTransparentColor, write=SetTransparentColor, default=32896};
	__property bool UseCustomGlyphs = {read=FUseCustomGlyphs, write=SetUseCustomGlyphs, default=0};
	__property int VerticalSpacing = {read=FVerticalSpacing, write=SetVerticalSpacing, default=3};
	__property Graphics::TColor WinMaskColor = {read=FWinMaskColor, write=SetWinMaskColor, default=65280};
	__property Rzcommon::TStateChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Alignment  = {default=0};
	__property AlignmentVertical  = {default=0};
	
public:
	__fastcall virtual TRzCustomCheckGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomCheckGroup(void);
	virtual void __fastcall ArrangeChecks(void);
	DYNAMIC void __fastcall FlipChildren(bool AllLevels);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomCheckGroup(HWND ParentWindow) : Rzpanel::TRzCustomGroupBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzCheckGroup;
class PASCALIMPLEMENTATION TRzCheckGroup : public TRzCustomCheckGroup 
{
	typedef TRzCustomCheckGroup inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	
public:
	__property Checks ;
	__property ItemChecked ;
	__property ItemEnabled ;
	__property ItemState ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Align  = {default=0};
	__property Alignment  = {default=0};
	__property AllowGrayed  = {default=0};
	__property Anchors  = {default=3};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderColor  = {default=-16777201};
	__property BorderInner  = {default=0};
	__property BorderOuter  = {default=0};
	__property BorderSides  = {default=15};
	__property BorderWidth  = {default=0};
	__property Caption ;
	__property CaptionFont ;
	__property Color  = {default=-16777201};
	__property Columns  = {default=1};
	__property Constraints ;
	__property Ctl3D ;
	__property CustomGlyphs ;
	__property CustomGlyphImages ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FlatColor  = {default=-16777200};
	__property FlatColorAdjustment  = {default=30};
	__property Font ;
	__property FrameController ;
	__property GradientColorStyle  = {default=0};
	__property GradientColorStart  = {default=16777215};
	__property GradientColorStop  = {default=-16777201};
	__property GradientDirection  = {default=2};
	__property GroupStyle  = {default=3};
	__property Height  = {default=105};
	__property ItemFrameColor  = {default=-16777200};
	__property ItemHighlightColor  = {default=-16777203};
	__property ItemHotTrack  = {default=0};
	__property ItemHotTrackColor  = {default=1350640};
	__property ItemHotTrackColorType  = {default=1};
	__property ItemFont ;
	__property ItemHeight ;
	__property Items ;
	__property LightTextStyle  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property TextHighlightColor  = {default=-16777196};
	__property TextShadowColor  = {default=-16777200};
	__property TextShadowDepth  = {default=2};
	__property ReadOnly  = {default=0};
	__property ReadOnlyColor  = {default=-16777192};
	__property ReadOnlyColorOnFocus  = {default=0};
	__property ShowHint ;
	__property SpaceEvenly  = {default=0};
	__property StartXPos  = {index=1, default=8};
	__property StartYPos  = {index=2, default=2};
	__property TabOnEnter  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property TextStyle  = {default=0};
	__property Transparent  = {default=0};
	__property TransparentColor  = {default=32896};
	__property UseCustomGlyphs  = {default=0};
	__property VerticalSpacing  = {default=3};
	__property Visible  = {default=1};
	__property VisualStyle  = {default=1};
	__property WinMaskColor  = {default=65280};
	__property OnChange ;
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnPaint ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TRzCustomCheckGroup.Create */ inline __fastcall virtual TRzCheckGroup(Classes::TComponent* AOwner) : TRzCustomCheckGroup(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomCheckGroup.Destroy */ inline __fastcall virtual ~TRzCheckGroup(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCheckGroup(HWND ParentWindow) : TRzCustomCheckGroup(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzradgrp */
using namespace Rzradgrp;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzradgrp
