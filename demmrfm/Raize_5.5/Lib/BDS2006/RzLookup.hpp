// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzlookup.pas' rev: 10.00

#ifndef RzlookupHPP
#define RzlookupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzlookup
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzLookupDialog;
class PASCALIMPLEMENTATION TRzLookupDialog : public Rzcommon::TRzDialogComponent 
{
	typedef Rzcommon::TRzDialogComponent inherited;
	
private:
	bool FAutoSelect;
	bool FButtonGlyphs;
	Stdctrls::TEditCharCase FCharCase;
	AnsiString FPrompt;
	Classes::TStrings* FList;
	int FSelectedIndex;
	AnsiString FSelectedItem;
	Stdctrls::TCustomEdit* FSearchEdit;
	AnsiString FSearchString;
	bool FUpdateSearchEdit;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall SetList(Classes::TStrings* Value);
	
public:
	__fastcall virtual TRzLookupDialog(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzLookupDialog(void);
	bool __fastcall Execute(void);
	__property AnsiString SearchString = {read=FSearchString, write=FSearchString};
	__property int SelectedIndex = {read=FSelectedIndex, write=FSelectedIndex, nodefault};
	__property AnsiString SelectedItem = {read=FSelectedItem};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AutoSelect = {read=FAutoSelect, write=FAutoSelect, default=1};
	__property bool ButtonGlyphs = {read=FButtonGlyphs, write=FButtonGlyphs, default=0};
	__property Stdctrls::TEditCharCase CharCase = {read=FCharCase, write=FCharCase, default=0};
	__property AnsiString Prompt = {read=FPrompt, write=FPrompt};
	__property Classes::TStrings* List = {read=FList, write=SetList};
	__property Stdctrls::TCustomEdit* SearchEdit = {read=FSearchEdit, write=FSearchEdit};
	__property bool UpdateSearchEdit = {read=FUpdateSearchEdit, write=FUpdateSearchEdit, default=0};
	__property BorderStyle  = {default=2};
	__property Caption ;
	__property CaptionOK ;
	__property CaptionCancel ;
	__property CaptionHelp ;
	__property Font ;
	__property FrameColor  = {default=-16777200};
	__property FrameStyle  = {default=1};
	__property FrameVisible  = {default=0};
	__property FramingPreference  = {default=1};
	__property Height  = {default=275};
	__property HelpContext  = {default=0};
	__property Width  = {default=275};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzlookup */
using namespace Rzlookup;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzlookup
