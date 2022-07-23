// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzdbdtp.pas' rev: 10.00

#ifndef RzdbdtpHPP
#define RzdbdtpHPP

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
#include <Rzdtp.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzdbdtp
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzDBDateTimePicker;
class PASCALIMPLEMENTATION TRzDBDateTimePicker : public Rzdtp::TRzDateTimePicker 
{
	typedef Rzdtp::TRzDateTimePicker inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	Rzdtp::TRzDateTimePicker* FPaintControl;
	void __fastcall ActiveChangeHandler(System::TObject* Sender);
	void __fastcall DataChangeHandler(System::TObject* Sender);
	void __fastcall UpdateDataHandler(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall CheckFieldType(const AnsiString Value);
	virtual void __fastcall DataChange(void);
	virtual void __fastcall UpdateData(void);
	virtual void __fastcall ActiveChange(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual Db::TField* __fastcall GetField(void);
	virtual AnsiString __fastcall GetDataField();
	virtual void __fastcall SetDataField(const AnsiString Value);
	virtual Db::TDataSource* __fastcall GetDataSource(void);
	virtual void __fastcall SetDataSource(Db::TDataSource* Value);
	virtual bool __fastcall GetReadOnly(void);
	virtual void __fastcall SetReadOnly(bool Value);
	
public:
	__fastcall virtual TRzDBDateTimePicker(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDBDateTimePicker(void);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	__property Db::TField* Field = {read=GetField};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDBDateTimePicker(HWND ParentWindow) : Rzdtp::TRzDateTimePicker(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzdbdtp */
using namespace Rzdbdtp;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzdbdtp
