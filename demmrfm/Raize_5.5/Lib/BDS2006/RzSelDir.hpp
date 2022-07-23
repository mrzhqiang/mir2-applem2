// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzseldir.pas' rev: 10.00

#ifndef RzseldirHPP
#define RzseldirHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Rzfilsys.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzseldir
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzSelDirDialog;
class PASCALIMPLEMENTATION TRzSelDirDialog : public Rzcommon::TRzDialogComponent 
{
	typedef Rzcommon::TRzDialogComponent inherited;
	
private:
	bool FAllowCreate;
	bool FButtonGlyphs;
	bool FChangeCurrentDir;
	AnsiString FDirectory;
	Rzfilsys::TNetworkVolumeFormat FNetworkVolumeFormat;
	bool FOpenCurrentDir;
	bool FAutoSelect;
	AnsiString FPrompt;
	AnsiString FPromptFolders;
	AnsiString FPromptDrives;
	Rzfilsys::TDriveTypes FDriveTypes;
	
public:
	__fastcall virtual TRzSelDirDialog(Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall Execute(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AllowCreate = {read=FAllowCreate, write=FAllowCreate, default=0};
	__property bool ButtonGlyphs = {read=FButtonGlyphs, write=FButtonGlyphs, default=0};
	__property bool ChangeCurrentDir = {read=FChangeCurrentDir, write=FChangeCurrentDir, default=1};
	__property AnsiString Directory = {read=FDirectory, write=FDirectory};
	__property Rzfilsys::TDriveTypes DriveTypes = {read=FDriveTypes, write=FDriveTypes, nodefault};
	__property Rzfilsys::TNetworkVolumeFormat NetworkVolumeFormat = {read=FNetworkVolumeFormat, write=FNetworkVolumeFormat, default=0};
	__property bool OpenCurrentDir = {read=FOpenCurrentDir, write=FOpenCurrentDir, default=0};
	__property bool AutoSelect = {read=FAutoSelect, write=FAutoSelect, default=0};
	__property AnsiString Prompt = {read=FPrompt, write=FPrompt};
	__property AnsiString PromptFolders = {read=FPromptFolders, write=FPromptFolders};
	__property AnsiString PromptDrives = {read=FPromptDrives, write=FPromptDrives};
	__property BorderStyle  = {default=3};
	__property Caption ;
	__property CaptionOK ;
	__property CaptionCancel ;
	__property CaptionHelp ;
	__property Font ;
	__property FrameColor  = {default=-16777200};
	__property FrameStyle  = {default=1};
	__property FrameVisible  = {default=0};
	__property FramingPreference  = {default=1};
	__property Height  = {default=325};
	__property HelpContext  = {default=0};
	__property Width  = {default=275};
public:
	#pragma option push -w-inl
	/* TRzDialogComponent.Destroy */ inline __fastcall virtual ~TRzSelDirDialog(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzseldir */
using namespace Rzseldir;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzseldir
