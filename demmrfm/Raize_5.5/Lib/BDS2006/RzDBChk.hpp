// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzdbchk.pas' rev: 10.00

#ifndef RzdbchkHPP
#define RzdbchkHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzbutton.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Rzradchk.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzdbchk
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzDBCheckBox;
class PASCALIMPLEMENTATION TRzDBCheckBox : public Rzradchk::TRzCustomCheckBox 
{
	typedef Rzradchk::TRzCustomCheckBox inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	Dbctrls::TFieldDataLink* FDataLink;
	AnsiString FValueCheck;
	AnsiString FValueUncheck;
	bool FNullAsUnchecked;
	Rzradchk::TRzCheckBox* FPaintControl;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall ChangeState(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	bool __fastcall ValueMatch(const AnsiString ValueList, const AnsiString Value);
	virtual AnsiString __fastcall GetDataField();
	virtual void __fastcall SetDataField(const AnsiString Value);
	virtual Db::TDataSource* __fastcall GetDataSource(void);
	virtual void __fastcall SetDataSource(Db::TDataSource* Value);
	virtual Db::TField* __fastcall GetField(void);
	virtual Stdctrls::TCheckBoxState __fastcall GetFieldState(void);
	virtual bool __fastcall GetReadOnly(void);
	virtual void __fastcall SetReadOnly(bool Value);
	virtual void __fastcall SetValueCheck(const AnsiString Value);
	virtual void __fastcall SetValueUncheck(const AnsiString Value);
	virtual void __fastcall SetNullAsUnchecked(bool Value);
	
public:
	__fastcall virtual TRzDBCheckBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDBCheckBox(void);
	__property Checked  = {default=0};
	__property Db::TField* Field = {read=GetField};
	__property State ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool NullAsUnchecked = {read=FNullAsUnchecked, write=SetNullAsUnchecked, default=1};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property AnsiString ValueChecked = {read=FValueCheck, write=SetValueCheck};
	__property AnsiString ValueUnchecked = {read=FValueUncheck, write=SetValueUncheck};
	__property Action ;
	__property Align  = {default=0};
	__property Alignment  = {default=1};
	__property AlignmentVertical  = {default=0};
	__property AllowGrayed  = {default=0};
	__property Anchors  = {default=3};
	__property AutoSize  = {default=1};
	__property BiDiMode ;
	__property Caption ;
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property Ctl3D ;
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
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property TextHighlightColor  = {default=-16777196};
	__property TextShadowColor  = {default=-16777200};
	__property TextShadowDepth  = {default=2};
	__property ShowHint ;
	__property TabOnEnter  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property TextStyle  = {default=0};
	__property ThemeAware  = {default=1};
	__property Transparent  = {default=0};
	__property TransparentColor  = {default=32896};
	__property UseCustomGlyphs  = {default=0};
	__property Visible  = {default=1};
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
	/* TWinControl.CreateParented */ inline __fastcall TRzDBCheckBox(HWND ParentWindow) : Rzradchk::TRzCustomCheckBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzdbchk */
using namespace Rzdbchk;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzdbchk
