// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzforms.pas' rev: 10.00

#ifndef RzformsHPP
#define RzformsHPP

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
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzforms
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzFormState;
class PASCALIMPLEMENTATION TRzFormState : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FEnabled;
	Rzcommon::TRzRegIniFile* FRegIniFile;
	AnsiString FSection;
	Classes::TNotifyEvent FOrigCreateHandler;
	Classes::TNotifyEvent FOrigShowHandler;
	Forms::TCloseEvent FOrigCloseHandler;
	Classes::TNotifyEvent FOnSaveState;
	Classes::TNotifyEvent FOnRestoreState;
	void __fastcall FormCreateHandler(System::TObject* Sender);
	void __fastcall FormShowHandler(System::TObject* Sender);
	void __fastcall FormCloseHandler(System::TObject* Sender, Forms::TCloseAction &Action);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	AnsiString __fastcall GetSection();
	bool __fastcall ValidMonitorAtPoint(int X, int Y);
	virtual void __fastcall SetRegIniFile(Rzcommon::TRzRegIniFile* Value);
	
public:
	__fastcall virtual TRzFormState(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzFormState(void);
	virtual void __fastcall ChainEvents(void);
	virtual void __fastcall UnchainEvents(void);
	virtual void __fastcall SaveState(void);
	virtual void __fastcall RestoreState(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property AnsiString Section = {read=FSection, write=FSection};
	__property Rzcommon::TRzRegIniFile* RegIniFile = {read=FRegIniFile, write=SetRegIniFile};
	__property Classes::TNotifyEvent OnSaveState = {read=FOnSaveState, write=FOnSaveState};
	__property Classes::TNotifyEvent OnRestoreState = {read=FOnRestoreState, write=FOnRestoreState};
};


class DELPHICLASS TRzFormShape;
class PASCALIMPLEMENTATION TRzFormShape : public Extctrls::TImage 
{
	typedef Extctrls::TImage inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FAllowFormDrag;
	bool FInitializedRegion;
	Classes::TNotifyEvent FOnFormShow;
	void __fastcall FormShowHandler(System::TObject* Sender);
	
protected:
	void __fastcall InitRegion(void);
	virtual HRGN __fastcall GetRegionFromBitmap(Graphics::TBitmap* B);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TRzFormShape(Classes::TComponent* AOwner);
	void __fastcall RecreateRegion(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AllowFormDrag = {read=FAllowFormDrag, write=FAllowFormDrag, default=1};
	__property Classes::TNotifyEvent OnFormShow = {read=FOnFormShow, write=FOnFormShow};
	__property Align  = {default=5};
	__property Transparent  = {default=1};
public:
	#pragma option push -w-inl
	/* TImage.Destroy */ inline __fastcall virtual ~TRzFormShape(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzforms */
using namespace Rzforms;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzforms
