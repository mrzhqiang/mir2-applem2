// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzchklst.pas' rev: 10.00

#ifndef RzchklstHPP
#define RzchklstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rzlstbox.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzchklst
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzCheckList;
class PASCALIMPLEMENTATION TRzCheckList : public Rzlstbox::TRzCustomTabbedListBox 
{
	typedef Rzlstbox::TRzCustomTabbedListBox inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FChangingItems;
	Classes::TStrings* FCheckItems;
	bool FAllowGrayed;
	int FGlyphWidth;
	int FGlyphHeight;
	int FNumGlyphs;
	Graphics::TBitmap* FCustomGlyphs;
	Imglist::TCustomImageList* FCustomGlyphImages;
	Imglist::TChangeLink* FCustomGlyphImagesChangeLink;
	bool FUseCustomGlyphs;
	Graphics::TColor FTransparentColor;
	Graphics::TColor FWinMaskColor;
	Graphics::TColor FHighlightColor;
	Graphics::TColor FItemFillColor;
	Graphics::TColor FItemFocusColor;
	Graphics::TColor FItemFrameColor;
	Imglist::TCustomImageList* FImages;
	Imglist::TChangeLink* FImagesChangeLink;
	int FSelectedItem;
	Classes::TStringList* FSaveCheckItems;
	int FSaveTopIndex;
	int FSaveItemIndex;
	bool FToggleOnItemClick;
	bool FChangingState;
	Rzcommon::TStateChangingEvent FOnChanging;
	Rzcommon::TStateChangeEvent FOnChange;
	void __fastcall CustomGlyphsChanged(System::TObject* Sender);
	void __fastcall CustomGlyphImagesChange(System::TObject* Sender);
	void __fastcall ImagesChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall UpdateItemHeight(void);
	virtual int __fastcall InitialTabStopOffset(void);
	virtual void __fastcall ToggleCheckState(void);
	void __fastcall ExtractGlyph(int Index, Graphics::TBitmap* Bitmap, Graphics::TBitmap* Source, int W, int H);
	virtual void __fastcall SelectGlyph(int Index, Graphics::TBitmap* Glyph);
	virtual int __fastcall OwnerDrawItemIndent(void);
	virtual AnsiString __fastcall HorzExtentPrefix();
	virtual void __fastcall DrawListItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall InvalidateItemImage(int Index);
	DYNAMIC bool __fastcall CanChange(int Index, Stdctrls::TCheckBoxState NewState);
	DYNAMIC void __fastcall Change(int Index, Stdctrls::TCheckBoxState NewState);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	virtual Classes::TStrings* __fastcall GetItems(void);
	virtual bool __fastcall GetItemChecked(int Index);
	virtual void __fastcall SetItemChecked(int Index, bool Value);
	virtual bool __fastcall GetItemEnabled(int Index);
	virtual void __fastcall SetItemEnabled(int Index, bool Value);
	virtual Stdctrls::TCheckBoxState __fastcall GetItemState(int Index);
	virtual void __fastcall SetItemState(int Index, Stdctrls::TCheckBoxState Value);
	virtual int __fastcall GetItemImageIndex(int Index);
	virtual void __fastcall SetItemImageIndex(int Index, int Value);
	virtual int __fastcall GetItemDisabledIndex(int Index);
	virtual void __fastcall SetItemDisabledIndex(int Index, int Value);
	HIDESBASE virtual void __fastcall SetItems(Classes::TStrings* Value);
	virtual void __fastcall SetAllowGrayed(bool Value);
	virtual void __fastcall SetCustomGlyphs(Graphics::TBitmap* Value);
	virtual void __fastcall SetCustomGlyphImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetImages(Imglist::TCustomImageList* Value);
	virtual void __fastcall SetUseCustomGlyphs(bool Value);
	virtual void __fastcall SetHighlightColor(Graphics::TColor Value);
	virtual void __fastcall SetItemFillColor(Graphics::TColor Value);
	virtual void __fastcall SetItemFocusColor(Graphics::TColor Value);
	virtual void __fastcall SetItemFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetTransparentColor(Graphics::TColor Value);
	virtual void __fastcall SetWinMaskColor(Graphics::TColor Value);
	__property int GlyphWidth = {read=FGlyphWidth, nodefault};
	__property int GlyphHeight = {read=FGlyphHeight, nodefault};
	
public:
	__fastcall virtual TRzCheckList(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCheckList(void);
	int __fastcall AddEx(const AnsiString S, bool Checked, bool Enabled = true, int ImageIndex = 0xffffffff, int DisabledIndex = 0xffffffff);
	virtual void __fastcall AddItem(AnsiString Item, System::TObject* AObject);
	void __fastcall CheckAll(void);
	void __fastcall UncheckAll(void);
	int __fastcall ItemsChecked(void);
	void __fastcall LoadFromFile(const AnsiString FileName);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall SaveToFile(const AnsiString FileName);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	virtual void __fastcall DefaultDrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall SetGroupState(int GroupIndex, Stdctrls::TCheckBoxState State);
	void __fastcall CheckGroup(int GroupIndex);
	void __fastcall UncheckGroup(int GroupIndex);
	void __fastcall EnableGroup(int GroupIndex);
	void __fastcall DisableGroup(int GroupIndex);
	__property bool ItemChecked[int Index] = {read=GetItemChecked, write=SetItemChecked};
	__property bool ItemEnabled[int Index] = {read=GetItemEnabled, write=SetItemEnabled};
	__property Stdctrls::TCheckBoxState ItemState[int Index] = {read=GetItemState, write=SetItemState};
	__property int ItemImageIndex[int Index] = {read=GetItemImageIndex, write=SetItemImageIndex};
	__property int ItemDisabledIndex[int Index] = {read=GetItemDisabledIndex, write=SetItemDisabledIndex};
	
__published:
	__property Classes::TStrings* Items = {read=FCheckItems, write=SetItems};
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AllowGrayed = {read=FAllowGrayed, write=SetAllowGrayed, default=0};
	__property Graphics::TBitmap* CustomGlyphs = {read=FCustomGlyphs, write=SetCustomGlyphs};
	__property Imglist::TCustomImageList* CustomGlyphImages = {read=FCustomGlyphImages, write=SetCustomGlyphImages};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=SetHighlightColor, default=-16777203};
	__property Graphics::TColor ItemFillColor = {read=FItemFillColor, write=SetItemFillColor, default=-16777211};
	__property Graphics::TColor ItemFocusColor = {read=FItemFocusColor, write=SetItemFocusColor, default=-16777211};
	__property Graphics::TColor ItemFrameColor = {read=FItemFrameColor, write=SetItemFrameColor, default=-16777200};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property bool UseCustomGlyphs = {read=FUseCustomGlyphs, write=SetUseCustomGlyphs, default=0};
	__property Graphics::TColor TransparentColor = {read=FTransparentColor, write=SetTransparentColor, default=32896};
	__property Graphics::TColor WinMaskColor = {read=FWinMaskColor, write=SetWinMaskColor, default=65280};
	__property Rzcommon::TStateChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Rzcommon::TStateChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property bool ToggleOnItemClick = {read=FToggleOnItemClick, write=FToggleOnItemClick, default=0};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property BeepOnInvalidKey  = {default=1};
	__property BiDiMode ;
	__property BorderStyle  = {default=1};
	__property Color  = {default=-16777211};
	__property Columns  = {default=0};
	__property Constraints ;
	__property Ctl3D ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property ShowItemHints  = {default=0};
	__property ExtendedSelect  = {default=1};
	__property Font ;
	__property FocusColor  = {default=-16777211};
	__property FrameColor  = {default=-16777200};
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property FrameHotColor  = {default=-16777200};
	__property FrameHotTrack  = {default=0};
	__property FrameHotStyle  = {default=10};
	__property FrameSides  = {default=15};
	__property FrameStyle  = {default=1};
	__property FrameVisible  = {default=0};
	__property FramingPreference  = {default=1};
	__property GroupColor  = {default=-16777197};
	__property GroupColorFromTheme  = {default=1};
	__property GroupFont ;
	__property HorzScrollBar  = {default=0};
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property IncrementalSearch  = {default=1};
	__property IntegralHeight  = {default=0};
	__property ItemHeight ;
	__property MultiSelect  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property Sorted  = {default=0};
	__property TabOnEnter  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property UseGradients  = {default=1};
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnData ;
	__property OnDataFind ;
	__property OnDataObject ;
	__property OnDblClick ;
	__property OnDeleteItems ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawItem ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMatch ;
	__property OnMeasureItem ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseWheel ;
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCheckList(HWND ParentWindow) : Rzlstbox::TRzCustomTabbedListBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzchklst */
using namespace Rzchklst;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzchklst
