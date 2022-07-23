// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzshellutils.pas' rev: 10.00

#ifndef RzshellutilsHPP
#define RzshellutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Shlobj.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Rzshellintf.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzshellutils
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TCSIDL { csidlDesktop, csidl_None1, csidlPrograms, csidlControls, csidlPrinters, csidlPersonal, csidlFavorites, csidlStartup, csidlRecent, csidlSendTo, csidlBitBucket, csidlStartMenu, csidl_None2, csidl_None3, csidl_None4, csidl_None5, csidlDesktopDirectory, csidlDrives, csidlNetwork, csidlNethood, csidlFonts, csidlTemplates, csidlCommonStartMenu, csidlCommonPrograms, csidlCommonStartup, csidlCommonDesktopDirectory, csidlAppData, csidlPrintHood, csidlLocalAppData, csidlAltStartup, csidlCommonAltStartup, csidlCommonFavorites, csidlInternetCache, csidlCookies, csidlHistory, csidlCommonAppData, csidlWindows, csidlSystem, csidlProgramFiles, csidlMyPictures, csidlProfile, csidlSystemX86, csidlProgramFilesX86, csidlProgramFilesCommon, csidlProgramFilesCommonX86, csidlCommonTemplates, csidlCommonDocuments, csidlCommonAdminTools, csidlAdminTools, csidlConnections, csidlNone };
#pragma option pop

#pragma pack(push,1)
struct TRzModuleVersion
{
	
	union
	{
		struct 
		{
			__int64 asInt64;
			
		};
		struct 
		{
			int _3;
			int version;
			
		};
		struct 
		{
			Word _1;
			Word _2;
			Word minor;
			Word major;
			
		};
		struct 
		{
			__int64 asComp;
			
		};
		struct 
		{
			int dw1;
			int dw2;
			
		};
		struct 
		{
			Word w1;
			Word w2;
			Word w3;
			Word w4;
			
		};
		
	};
} ;
#pragma pack(pop)

typedef TRzModuleVersion *PRzModuleVersion;

#pragma option push -b-
enum TRzFriendlyNameFlags { fnNormal, fnInFolder, fnForParsing, fnForEditing };
#pragma option pop

#pragma option push -b-
enum TRzShellIconSize { iszSmall, iszLarge };
#pragma option pop

class DELPHICLASS TRzIdListArray;
class PASCALIMPLEMENTATION TRzIdListArray : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	Shlobj::PItemIDList operator[](int Index) { return Item[Index]; }
	
protected:
	_ITEMIDLIST *FPidl;
	_ITEMIDLIST *FLastItem;
	int __fastcall GetCount(void);
	Shlobj::PItemIDList __fastcall GetItem(int Index);
	
public:
	__fastcall TRzIdListArray(Shlobj::PItemIDList p);
	__fastcall virtual ~TRzIdListArray(void);
	Shlobj::PItemIDList __fastcall GoUp(int items);
	__property int ItemCount = {read=GetCount, nodefault};
	__property Shlobj::PItemIDList Item[int Index] = {read=GetItem/*, default*/};
	__property Shlobj::PItemIDList Pidl = {read=FPidl};
};


class DELPHICLASS TRzPidlList;
class PASCALIMPLEMENTATION TRzPidlList : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	Shlobj::PItemIDList operator[](int index) { return PIDLs[index]; }
	
private:
	Classes::TList* FList;
	bool FSorted;
	Rzshellintf::IShellFolder_NRC* FShellFolder;
	Rzshellintf::IMalloc_NRC* FMalloc;
	Classes::TDuplicates FDuplicates;
	Shlobj::PItemIDList __fastcall GetPIDL(int Index);
	void __fastcall SetPIDL(int Index, Shlobj::PItemIDList PIDL);
	void * __fastcall GetObject(int Index);
	void __fastcall SetObject(int Index, void * aObject);
	void __fastcall SetSorted(bool isSorted);
	int __fastcall GetCount(void);
	int __fastcall GetCapacity(void);
	void __fastcall SetCapacity(int cap);
	
protected:
	bool __fastcall BinarySearch(const Shlobj::PItemIDList PIDL, int &Index);
	bool __fastcall LinearSearch(const Shlobj::PItemIDList PIDL, int &Index);
	
public:
	__fastcall TRzPidlList(void);
	__fastcall virtual ~TRzPidlList(void);
	virtual int __fastcall Add(const Shlobj::PItemIDList PIDL);
	virtual int __fastcall AddObject(const Shlobj::PItemIDList PIDL, System::TObject* aObject);
	void __fastcall Delete(int index);
	void __fastcall Clear(void);
	int __fastcall IndexOf(const Shlobj::PItemIDList PIDL);
	void __fastcall Insert(int Index, Shlobj::PItemIDList Pidl);
	void __fastcall InsertObject(int Index, Shlobj::PItemIDList Pidl, void * aObject);
	void __fastcall Sort(void);
	__property Shlobj::PItemIDList PIDLs[int index] = {read=GetPIDL, write=SetPIDL/*, default*/};
	__property void * Objects[int index] = {read=GetObject, write=SetObject};
	__property bool Sorted = {read=FSorted, write=SetSorted, nodefault};
	__property Rzshellintf::IMalloc_NRC* Malloc = {read=FMalloc, write=FMalloc};
	__property int Count = {read=GetCount, nodefault};
	__property Rzshellintf::IShellFolder_NRC* ShellFolder = {read=FShellFolder, write=FShellFolder};
	__property Classes::TDuplicates Duplicates = {read=FDuplicates, write=FDuplicates, nodefault};
	__property int Capacity = {read=GetCapacity, write=SetCapacity, nodefault};
};


#pragma option push -b-
enum TLinkDataOption { ldoUseDesc, ldoUseArgs, ldoUseIcon, ldoUseWorkDir, ldoUseHotKey, ldoUseShowCmd };
#pragma option pop

typedef Set<TLinkDataOption, ldoUseDesc, ldoUseShowCmd>  TLinkDataOptions;

struct TLinkData
{
	
public:
	AnsiString pathName;
	TLinkDataOptions options;
	AnsiString desc;
	AnsiString args;
	AnsiString iconPath;
	int iconIndex;
	AnsiString workingDir;
	int showCmd;
	Word hotkey;
	bool noUI;
	_ITEMIDLIST *idList;
	_WIN32_FIND_DATAA w32fd;
} ;

typedef void __fastcall (__closure *TRzDeviceChangeEvent)(System::TObject* ASender, Messages::TMessage &AMessage);

class DELPHICLASS TRzDeviceChangeHandler;
class PASCALIMPLEMENTATION TRzDeviceChangeHandler : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	bool FActive;
	HWND FWindowReceiver;
	Classes::TList* FNotifyList;
	
protected:
	void __fastcall DeleteItem(int AItemIndex);
	void __fastcall WndProc(Messages::TMessage &AMessage);
	void __fastcall BroadcastToList(Messages::TMessage &AMessage);
	
public:
	__fastcall TRzDeviceChangeHandler(void);
	__fastcall virtual ~TRzDeviceChangeHandler(void);
	void __fastcall Add(TRzDeviceChangeEvent AToNotify);
	void __fastcall Remove(TRzDeviceChangeEvent AToNotify);
	__property bool Active = {read=FActive, write=FActive, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
static const int COMCTL32_VER600 = 0x60000;
static const int COMCTL32_VER581 = 0x50051;
static const int COMCTL32_VER580 = 0x50050;
static const int COMCTL32_VER472 = 0x40048;
static const int COMCTL32_VER471 = 0x40047;
static const int COMCTL32_VER470 = 0x40046;
static const int COMCTL32_VER400 = 0x40000;
static const int SHELL32_VER50 = 0x50000;
static const int SHELL32_VER60 = 0x60000;
extern PACKAGE TRzModuleVersion COMCTL32_VER;
extern PACKAGE TRzModuleVersion SHELL32_VER;
extern PACKAGE int gFlushDriveInfoSem;
#define RZSH_CMDS_DELETE "delete"
#define RZSH_CMDS_PASTE "paste"
#define RZSH_CMDS_CUT "cut"
#define RZSH_CMDS_COPY "copy"
#define RZSH_CMDS_PROPERTIES "properties"
#define RZSH_CMDS_EXPLORE "explore"
#define RZSH_CMDS_OPEN "open"
#define RZSH_CMDS_FIND "find"
#define RZSH_CMDS_LINK "link"
#define RZSH_CMDS_DUN_CREATE "create"
#define RZSH_CMDS_DUN_CONNECT "connect"
#define RZSH_CMDID_FORMAT (char *)(0x23)
extern PACKAGE bool __fastcall IsWin95(void);
extern PACKAGE bool __fastcall IsOSR2OrGreater(void);
extern PACKAGE bool __fastcall IsWinNT(void);
extern PACKAGE bool __fastcall IsWin2000(void);
extern PACKAGE bool __fastcall HasWin95Shell(void);
extern PACKAGE bool __fastcall GetModuleVersion(const AnsiString aModuleName, TRzModuleVersion &aVersion);
extern PACKAGE void * __fastcall ShellMemAlloc(unsigned size);
extern PACKAGE void * __fastcall ShellMemRealloc(void * p, unsigned size);
extern PACKAGE void __fastcall ShellMemFree(void * p);
extern PACKAGE Rzshellintf::IMalloc_NRC* __fastcall ShellIMalloc(void);
extern PACKAGE HRESULT __fastcall ShellGetFolderFromIdList(Shlobj::PItemIDList p, Rzshellintf::IShellFolder_NRC* &ish);
extern PACKAGE HRESULT __fastcall ShellGetIdListFromPath(const AnsiString path, Shlobj::PItemIDList &p);
extern PACKAGE AnsiString __fastcall ShellGetPathFromIdList(Shlobj::PItemIDList p);
extern PACKAGE AnsiString __fastcall ShellGetDisplayPathName(AnsiString aPathName);
extern PACKAGE AnsiString __fastcall ShellGetSpecialFolderPath(HWND ahwnd, TCSIDL csidl);
extern PACKAGE HRESULT __fastcall ShellGetSpecialFolderIdList(HWND ahwnd, TCSIDL csidl, Shlobj::PItemIDList &idlist);
extern PACKAGE int __fastcall ShellGetIconIndex(Shlobj::PItemIDList absIdList, unsigned uFlags);
extern PACKAGE int __fastcall ShellGetIconIndexFromPath(const AnsiString path, unsigned uFlags);
extern PACKAGE int __fastcall ShellGetIconIndexFromExt(const AnsiString ext, unsigned uFlags);
extern PACKAGE int __fastcall ShellGetSpecialFolderIconIndex(TCSIDL csidl, unsigned uFlags);
extern PACKAGE TCSIDL __fastcall ShellFindCSIDLFromIdList(Shlobj::PItemIDList aIdList);
extern PACKAGE bool __fastcall ShellCSIDLEqualsIdList(Shlobj::PItemIDList aIdList, TCSIDL csidl);
extern PACKAGE AnsiString __fastcall ShellGetFriendlyNameFromIdList(Rzshellintf::IShellFolder_NRC* ishf, Shlobj::PItemIDList pidl, TRzFriendlyNameFlags flags);
extern PACKAGE AnsiString __fastcall ShellGetFriendlyNameForLastIdListElement(Shlobj::PItemIDList AAbsoluteIdList);
extern PACKAGE unsigned __fastcall ShellGetSystemImageList(TRzShellIconSize Size);
extern PACKAGE HRESULT __fastcall ShellGetDesktopFolder(Rzshellintf::IShellFolder_NRC* &Folder);
extern PACKAGE AnsiString __fastcall StrretToString(Shlobj::PItemIDList pidl, const Rzshellintf::TStrRet &r);
extern PACKAGE void __fastcall StrretFree(const Rzshellintf::TStrRet &r);
extern PACKAGE AnsiString __fastcall EnsureTrailingCharDB(const AnsiString Source, char TrailingChar);
extern PACKAGE int __fastcall IdListLen(Shlobj::PItemIDList pidl);
extern PACKAGE int __fastcall CompareAbsIdLists(Shlobj::PItemIDList pidl1, Shlobj::PItemIDList pidl2);
extern PACKAGE Shlobj::PItemIDList __fastcall ConcatIdLists(Rzshellintf::IMalloc_NRC* ishm, Shlobj::PItemIDList First, Shlobj::PItemIDList Second);
extern PACKAGE Shlobj::PItemIDList __fastcall CopyIdList(Rzshellintf::IMalloc_NRC* ishm, Shlobj::PItemIDList pidl);
extern PACKAGE HRESULT __fastcall CreateShortcut(const AnsiString linkPathName, const TLinkData &linkData);
extern PACKAGE HRESULT __fastcall CreateQuickShortcut(const AnsiString linkPathName, const AnsiString targetPathName);
extern PACKAGE HRESULT __fastcall ResolveShortcut(const AnsiString linkPathName, TLinkData &linkData, bool afWantIdList);
extern PACKAGE bool __fastcall RzClsidFromFileType(AnsiString aExtension, GUID &aCLSID);
extern PACKAGE void __fastcall FlushDriveInfoCache(void);
extern PACKAGE void __fastcall LockFlushDriveInfoCache(void);
extern PACKAGE void __fastcall UnlockFlushDriveInfoCache(void);
extern PACKAGE AnsiString __fastcall FormatStrPos(AnsiString aFmtStr, AnsiString * data, const int data_Size);
extern PACKAGE void __fastcall ParametizeCmdLineDB(const AnsiString ins, Classes::TStrings* outs);
extern PACKAGE AnsiString __fastcall TrimRightDB(AnsiString Str);
extern PACKAGE void __fastcall CopyCharDB(int &APos, const AnsiString ASource, AnsiString &ADest);
extern PACKAGE TRzDeviceChangeHandler* __fastcall RzDeviceChangeHandler(void);
extern PACKAGE bool __fastcall IsNetworkDriveConnected(char ADriveLetter);

}	/* namespace Rzshellutils */
using namespace Rzshellutils;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzshellutils
