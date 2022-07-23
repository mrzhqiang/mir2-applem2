// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzstringmodule.pas' rev: 10.00

#ifndef RzstringmoduleHPP
#define RzstringmoduleHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Designconst.hpp>	// Pascal unit
#include <Toolsapi.hpp>	// Pascal unit
#include <Istreams.hpp>	// Pascal unit
#include <Stfilsys.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzstringmodule
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRzStringsModuleCreator;
class PASCALIMPLEMENTATION TRzStringsModuleCreator : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	AnsiString FFileName;
	Classes::TStringStream* FStream;
	System::TDateTime FAge;
	
public:
	__fastcall TRzStringsModuleCreator(const AnsiString FileName, Classes::TStringStream* Stream, System::TDateTime Age);
	__fastcall virtual ~TRzStringsModuleCreator(void);
	AnsiString __fastcall GetCreatorType();
	bool __fastcall GetExisting(void);
	AnsiString __fastcall GetFileSystem();
	Toolsapi::_di_IOTAModule __fastcall GetOwner();
	bool __fastcall GetUnnamed(void);
	AnsiString __fastcall GetAncestorName();
	AnsiString __fastcall GetImplFileName();
	AnsiString __fastcall GetIntfFileName();
	AnsiString __fastcall GetFormName();
	bool __fastcall GetMainForm(void);
	bool __fastcall GetShowForm(void);
	bool __fastcall GetShowSource(void);
	Toolsapi::_di_IOTAFile __fastcall NewFormFile(const AnsiString FormIdent, const AnsiString AncestorIdent);
	Toolsapi::_di_IOTAFile __fastcall NewImplSource(const AnsiString ModuleIdent, const AnsiString FormIdent, const AnsiString AncestorIdent);
	Toolsapi::_di_IOTAFile __fastcall NewIntfSource(const AnsiString ModuleIdent, const AnsiString FormIdent, const AnsiString AncestorIdent);
	void __fastcall FormCreated(const Toolsapi::_di_IOTAFormEditor FormEditor);
private:
	void *__IOTAModuleCreator;	/* Toolsapi::IOTAModuleCreator */
	
public:
	operator IOTAModuleCreator*(void) { return (IOTAModuleCreator*)&__IOTAModuleCreator; }
	operator IOTACreator*(void) { return (IOTACreator*)&__IOTAModuleCreator; }
	
};


class DELPHICLASS TRzOTAFile;
class PASCALIMPLEMENTATION TRzOTAFile : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	AnsiString FSource;
	System::TDateTime FAge;
	
public:
	__fastcall TRzOTAFile(const AnsiString ASource, System::TDateTime AAge);
	AnsiString __fastcall GetSource();
	System::TDateTime __fastcall GetAge(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzOTAFile(void) { }
	#pragma option pop
	
private:
	void *__IOTAFile;	/* Toolsapi::IOTAFile */
	
public:
	operator IOTAFile*(void) { return (IOTAFile*)&__IOTAFile; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Rzstringmodule */
using namespace Rzstringmodule;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzstringmodule
