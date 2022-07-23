// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzshellintf.pas' rev: 10.00

#ifndef RzshellintfHPP
#define RzshellintfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Shlobj.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------
#define NO_WIN32_LEAN_AND_MEAN

namespace Rzshellintf
{
//-- type declarations -------------------------------------------------------
typedef HWND TRzHandle;

class DELPHICLASS IUnknown_NRC;
class PASCALIMPLEMENTATION IUnknown_NRC : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	virtual HRESULT __stdcall QueryInterface(const GUID &iid, void *obj) = 0 ;
	virtual int __stdcall AddRef(void) = 0 ;
	virtual int __stdcall Release(void) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IUnknown_NRC(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IUnknown_NRC(void) { }
	#pragma option pop
	
};


class DELPHICLASS IOleWindow_NRC;
class PASCALIMPLEMENTATION IOleWindow_NRC : public IUnknown_NRC 
{
	typedef IUnknown_NRC inherited;
	
public:
	virtual HRESULT __stdcall GetWindow(HWND &wnd) = 0 ;
	virtual HRESULT __stdcall ContextSensitiveHelp(BOOL fEnterMode) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IOleWindow_NRC(void) : IUnknown_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IOleWindow_NRC(void) { }
	#pragma option pop
	
};


class DELPHICLASS IMalloc_NRC;
class PASCALIMPLEMENTATION IMalloc_NRC : public IUnknown_NRC 
{
	typedef IUnknown_NRC inherited;
	
public:
	virtual void * __stdcall Alloc(int cb) = 0 ;
	virtual void * __stdcall Realloc(void * pv, int cb) = 0 ;
	HIDESBASE virtual void __stdcall Free(void * pv) = 0 ;
	virtual int __stdcall GetSize(void * pv) = 0 ;
	virtual int __stdcall DidAlloc(void * pv) = 0 ;
	virtual void __stdcall HeapMinimize(void) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IMalloc_NRC(void) : IUnknown_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IMalloc_NRC(void) { }
	#pragma option pop
	
};


struct TStrRet
{
	
public:
	unsigned uType;
	union
	{
		struct 
		{
			char cStr[261];
			
		};
		struct 
		{
			unsigned uOffset;
			
		};
		struct 
		{
			WideChar *pOleStr;
			
		};
		
	};
} ;

typedef TStrRet *PStrRet;

struct TShColInfo
{
	
public:
	int justify;
	int width;
	TStrRet text;
} ;

typedef TShColInfo *PShColInfo;

class DELPHICLASS IShellDetails_NRC;
class PASCALIMPLEMENTATION IShellDetails_NRC : public IUnknown_NRC 
{
	typedef IUnknown_NRC inherited;
	
public:
	virtual HRESULT __stdcall GetDetailsOf(Shlobj::PItemIDList pidl, unsigned col, TShColInfo &info) = 0 ;
	virtual HRESULT __stdcall ColumnClick(unsigned col) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IShellDetails_NRC(void) : IUnknown_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IShellDetails_NRC(void) { }
	#pragma option pop
	
};


#pragma pack(push,1)
struct TCMInvokeCommandInfo
{
	
public:
	unsigned cbSize;
	unsigned fMask;
	unsigned hwnd;
	char *lpVerb;
	char *lpParameters;
	char *lpDirectory;
	int nShow;
	unsigned dwHotKey;
	unsigned hIcon;
} ;
#pragma pack(pop)

typedef TCMInvokeCommandInfo *PCMInvokeCommandInfo;

class DELPHICLASS IContextMenu_NRC;
class PASCALIMPLEMENTATION IContextMenu_NRC : public IUnknown_NRC 
{
	typedef IUnknown_NRC inherited;
	
public:
	virtual HRESULT __stdcall QueryContextMenu(unsigned hMenu, unsigned indexMenu, unsigned idCmdFirst, unsigned idCmdLast, unsigned uFlags) = 0 ;
	virtual HRESULT __stdcall InvokeCommand(const TCMInvokeCommandInfo &ici) = 0 ;
	virtual HRESULT __stdcall GetCommandString(unsigned idCmd, unsigned uType, PUINT pwReserved, char * pszName, unsigned cchMax) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IContextMenu_NRC(void) : IUnknown_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IContextMenu_NRC(void) { }
	#pragma option pop
	
};


class DELPHICLASS IContextMenu2_NRC;
class PASCALIMPLEMENTATION IContextMenu2_NRC : public IContextMenu_NRC 
{
	typedef IContextMenu_NRC inherited;
	
public:
	virtual HRESULT __stdcall HandleMenuMsg(unsigned uMsg, unsigned wParam, unsigned lParam) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IContextMenu2_NRC(void) : IContextMenu_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IContextMenu2_NRC(void) { }
	#pragma option pop
	
};


class DELPHICLASS IEnumIDList_NRC;
class PASCALIMPLEMENTATION IEnumIDList_NRC : public IUnknown_NRC 
{
	typedef IUnknown_NRC inherited;
	
public:
	virtual HRESULT __stdcall Next(int celt, Shlobj::PItemIDList &pidl, System::PInteger pFetched) = 0 ;
	virtual HRESULT __stdcall Skip(int celt) = 0 ;
	virtual HRESULT __stdcall Reset(void) = 0 ;
	virtual HRESULT __stdcall Clone(IEnumIDList_NRC* &enumIdList) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IEnumIDList_NRC(void) : IUnknown_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IEnumIDList_NRC(void) { }
	#pragma option pop
	
};


class DELPHICLASS IShellFolder_NRC;
class PASCALIMPLEMENTATION IShellFolder_NRC : public IUnknown_NRC 
{
	typedef IUnknown_NRC inherited;
	
public:
	virtual HRESULT __stdcall ParseDisplayName(HWND hwndOwner, void * reserved, WideChar * displayName, unsigned &chEaten, Shlobj::PItemIDList &pidl, unsigned &dwAttributes) = 0 ;
	virtual HRESULT __stdcall EnumObjects(HWND hwndOwner, unsigned grfFlags, IEnumIDList_NRC* &penumIdList) = 0 ;
	virtual HRESULT __stdcall BindToObject(Shlobj::PItemIDList pidl, void * reserved, const GUID &riid, void * &pvOut) = 0 ;
	virtual HRESULT __stdcall BindToStorage(Shlobj::PItemIDList pidl, void * reserved, const GUID &riid, void * &pvObj) = 0 ;
	virtual HRESULT __stdcall CompareIDs(int lparam, Shlobj::PItemIDList pidl1, Shlobj::PItemIDList pidl2) = 0 ;
	virtual HRESULT __stdcall CreateViewObject(HWND hwndOwner, const GUID &riid, void * &ppvOut) = 0 ;
	virtual HRESULT __stdcall GetAttributesOf(unsigned cidl, Shlobj::PItemIDList &pidl, unsigned &rgfInOut) = 0 ;
	virtual HRESULT __stdcall GetUIObjectOf(HWND hwndOwner, unsigned cild, Shlobj::PItemIDList &pidl, const GUID &riid, PUINT prgfInOut, void * &ppvOut) = 0 ;
	virtual HRESULT __stdcall GetDisplayNameOf(Shlobj::PItemIDList pidl, unsigned uFlags, TStrRet &name) = 0 ;
	virtual HRESULT __stdcall SetNameOf(HWND hwndOwner, Shlobj::PItemIDList pidl, WideChar * swzName, unsigned uFlags, Shlobj::PItemIDList &pidlOut) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IShellFolder_NRC(void) : IUnknown_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IShellFolder_NRC(void) { }
	#pragma option pop
	
};


class DELPHICLASS IShellFolder2_NRC;
class PASCALIMPLEMENTATION IShellFolder2_NRC : public IShellFolder_NRC 
{
	typedef IShellFolder_NRC inherited;
	
public:
	virtual void __stdcall F1(void) = 0 ;
	virtual void __stdcall F2(void) = 0 ;
	virtual void __stdcall F3(void) = 0 ;
	virtual HRESULT __stdcall GetDefaultColumnState(unsigned iColumn, unsigned &pcsFlags) = 0 ;
	virtual void __stdcall F5(void) = 0 ;
	virtual HRESULT __stdcall GetDetailsOf(Shlobj::PItemIDList pidl, unsigned iColumn, TShColInfo &sd) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IShellFolder2_NRC(void) : IShellFolder_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IShellFolder2_NRC(void) { }
	#pragma option pop
	
};


class DELPHICLASS IShellLink_NRC;
class PASCALIMPLEMENTATION IShellLink_NRC : public IUnknown_NRC 
{
	typedef IUnknown_NRC inherited;
	
public:
	virtual HRESULT __stdcall GetPath(char * pszFile, int cchMaxPath, _WIN32_FIND_DATAA &fd, unsigned fFlags) = 0 ;
	virtual HRESULT __stdcall GetIDList(Shlobj::PItemIDList &pidl) = 0 ;
	virtual HRESULT __stdcall SetIDList(Shlobj::PItemIDList pidl) = 0 ;
	virtual HRESULT __stdcall GetDescription(char * pszName, int cchMaxName) = 0 ;
	virtual HRESULT __stdcall SetDescription(char * pszName) = 0 ;
	virtual HRESULT __stdcall GetWorkingDirectory(char * pszDir, int cchMaxPath) = 0 ;
	virtual HRESULT __stdcall SetWorkingDirectory(char * pszDir) = 0 ;
	virtual HRESULT __stdcall GetArguments(char * pszArgs, int cchMaxPath) = 0 ;
	virtual HRESULT __stdcall SetArguments(char * pszArgs) = 0 ;
	virtual HRESULT __stdcall GetHotKey(Word &wHotKey) = 0 ;
	virtual HRESULT __stdcall SetHotKey(Word wHotKey) = 0 ;
	virtual HRESULT __stdcall GetShowCmd(int &iShowCmd) = 0 ;
	virtual HRESULT __stdcall SetShowCmd(int iShowCmd) = 0 ;
	virtual HRESULT __stdcall GetIconLocation(char * pszIconPath, int cchIconPath, int &iIcon) = 0 ;
	virtual HRESULT __stdcall SetIconLocation(char * pszIconPath, int iIcon) = 0 ;
	virtual HRESULT __stdcall SetRelativePath(char * pszPathRel, unsigned dwReserved) = 0 ;
	virtual HRESULT __stdcall Resolve(HWND hwnd, unsigned fFlags) = 0 ;
	virtual HRESULT __stdcall SetPath(char * pszFile) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IShellLink_NRC(void) : IUnknown_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IShellLink_NRC(void) { }
	#pragma option pop
	
};


class DELPHICLASS IEnumFormatEtc_NRC;
class PASCALIMPLEMENTATION IEnumFormatEtc_NRC : public IUnknown_NRC 
{
	typedef IUnknown_NRC inherited;
	
public:
	virtual HRESULT __stdcall Next(int celt, void *elt, PLongint pceltFetched) = 0 ;
	virtual HRESULT __stdcall Skip(int celt) = 0 ;
	virtual HRESULT __stdcall Reset(void) = 0 ;
	virtual HRESULT __stdcall Clone(IEnumFormatEtc_NRC* &Enum) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IEnumFormatEtc_NRC(void) : IUnknown_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IEnumFormatEtc_NRC(void) { }
	#pragma option pop
	
};


class DELPHICLASS IDataObject_NRC;
class PASCALIMPLEMENTATION IDataObject_NRC : public IUnknown_NRC 
{
	typedef IUnknown_NRC inherited;
	
public:
	virtual HRESULT __stdcall GetData(tagFORMATETC &formatetcIn, tagSTGMEDIUM &medium) = 0 ;
	virtual HRESULT __stdcall GetDataHere(tagFORMATETC &formatetc, tagSTGMEDIUM &medium) = 0 ;
	virtual HRESULT __stdcall QueryGetData(tagFORMATETC &formatetc) = 0 ;
	virtual HRESULT __stdcall GetCanonicalFormatEtc(tagFORMATETC &formatetc, tagFORMATETC &formatetcOut) = 0 ;
	virtual HRESULT __stdcall SetData(tagFORMATETC &formatetc, tagSTGMEDIUM &medium, BOOL fRelease) = 0 ;
	virtual HRESULT __stdcall EnumFormatEtc(int dwDirection, IEnumFormatEtc_NRC* &enumFormatEtc) = 0 ;
	virtual HRESULT __stdcall DAdvise(tagFORMATETC &formatetc, int advf, void * advSink, int &dwConnection) = 0 ;
	virtual HRESULT __stdcall DUnadvise(int dwConnection) = 0 ;
	virtual HRESULT __stdcall EnumDAdvise(void * &enumAdvise) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IDataObject_NRC(void) : IUnknown_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IDataObject_NRC(void) { }
	#pragma option pop
	
};


class DELPHICLASS IDropTarget_NRC;
class PASCALIMPLEMENTATION IDropTarget_NRC : public IUnknown_NRC 
{
	typedef IUnknown_NRC inherited;
	
public:
	virtual HRESULT __stdcall DragEnter(IDataObject_NRC* dataObj, int grfKeyState, const Types::TPoint pt, int &dwEffect) = 0 ;
	virtual HRESULT __stdcall DragOver(int grfKeyState, const Types::TPoint pt, int &dwEffect) = 0 ;
	virtual HRESULT __stdcall DragLeave(void) = 0 ;
	virtual HRESULT __stdcall Drop(IDataObject_NRC* dataObj_NRC, int grfKeyState, const Types::TPoint pt, int &dwEffect) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IDropTarget_NRC(void) : IUnknown_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IDropTarget_NRC(void) { }
	#pragma option pop
	
};


class DELPHICLASS IDropSource_NRC;
class PASCALIMPLEMENTATION IDropSource_NRC : public IUnknown_NRC 
{
	typedef IUnknown_NRC inherited;
	
public:
	virtual HRESULT __stdcall QueryContinueDrag(BOOL fEscapePressed, int grfKeyState) = 0 ;
	virtual HRESULT __stdcall GiveFeedback(int dwEffect) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall IDropSource_NRC(void) : IUnknown_NRC() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~IDropSource_NRC(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Byte PTSHELLCONTROLS_VERSION = 0xbe;
static const Byte PTSHELLCONTROLS_PATCHSYM = 0x20;
static const Shortint PTSHELLCONTROLS_PATCH = -64;

}	/* namespace Rzshellintf */
using namespace Rzshellintf;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzshellintf
