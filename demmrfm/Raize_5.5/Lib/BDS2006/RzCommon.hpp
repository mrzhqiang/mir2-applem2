// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzcommon.pas' rev: 10.00

#ifndef RzcommonHPP
#define RzcommonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Themes.hpp>	// Pascal unit
#include <Uxtheme.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzcommon
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAlignmentVertical { avTop, avCenter, avBottom };
#pragma option pop

#pragma option push -b-
enum TBlinkState { bsOn, bsOff };
#pragma option pop

#pragma option push -b-
enum TTextStyle { tsNormal, tsRaised, tsRecessed, tsShadow };
#pragma option pop

#pragma option push -b-
enum TOrientation { orHorizontal, orVertical };
#pragma option pop

#pragma option push -b-
enum TBarStyle { bsTraditional, bsLED, bsGradient };
#pragma option pop

#pragma option push -b-
enum TLineStyle { lsNone, lsFlat, lsGroove, lsBump };
#pragma option pop

#pragma option push -b-
enum TFrameStyleEx { fsNone, fsFlat, fsGroove, fsBump, fsLowered, fsButtonDown, fsRaised, fsButtonUp, fsStatus, fsPopup, fsFlatBold, fsFlatRounded };
#pragma option pop

typedef TFrameStyleEx TFrameStyle;

#pragma option push -b-
enum TFramingPreference { fpCustomFraming, fpXPThemes };
#pragma option pop

#pragma option push -b-
enum TRzGroupBarGradientPath { gpTopToBottom, gpBottomToTop };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdDiagonalUp, gdDiagonalDown, gdHorizontalEnd, gdHorizontalCenter, gdHorizontalBox, gdVerticalEnd, gdVerticalCenter, gdVerticalBox, gdSquareBox, gdBigSquareBox };
#pragma option pop

#pragma option push -b-
enum TDirection { dirUp, dirDown, dirLeft, dirRight };
#pragma option pop

#pragma option push -b-
enum TRzScrollStyle { scsNone, scsLeft, scsUp, scsRight, scsDown };
#pragma option pop

#pragma option push -b-
enum TSide { sdLeft, sdTop, sdRight, sdBottom };
#pragma option pop

typedef Set<TSide, sdLeft, sdBottom>  TSides;

typedef void __fastcall (__closure *TPositionChangingEvent)(System::TObject* Sender, int NewPos, bool &AllowChange);

#pragma option push -b-
enum TExpandOnType { etMouseButton2Click, etFocus, etNone };
#pragma option pop

typedef Byte TPositiveByte;

typedef Word TPositiveSmallint;

typedef int TPositiveInteger;

typedef Word TUnsignedSmallint;

class DELPHICLASS EInvalidFieldType;
class PASCALIMPLEMENTATION EInvalidFieldType : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall EInvalidFieldType(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EInvalidFieldType(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EInvalidFieldType(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EInvalidFieldType(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EInvalidFieldType(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EInvalidFieldType(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EInvalidFieldType(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EInvalidFieldType(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EInvalidFieldType(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TRzScrollType { stNone, stRightToLeft, stLeftToRight };
#pragma option pop

typedef void __fastcall (__closure *TRzScrollDisplayEvent)(System::TObject* Sender, int CurrentStep, int TotalSteps);

#pragma option push -b-
enum TRzHotTrackColorType { htctComplement, htctActual };
#pragma option pop

typedef void __fastcall (__closure *TStateChangingEvent)(System::TObject* Sender, int Index, Stdctrls::TCheckBoxState NewState, bool &AllowChange);

typedef void __fastcall (__closure *TStateChangeEvent)(System::TObject* Sender, int Index, Stdctrls::TCheckBoxState NewState);

#pragma option push -b-
enum TRzAboutInfo { aiRaizeComponents };
#pragma option pop

class DELPHICLASS TRzBlinkingControlsList;
class PASCALIMPLEMENTATION TRzBlinkingControlsList : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TBlinkState FBlinkState;
	Classes::TList* FControls;
	Extctrls::TTimer* FTimer;
	Word FIntervalOff;
	Word FIntervalOn;
	
protected:
	virtual int __fastcall GetCount(void);
	
public:
	__fastcall TRzBlinkingControlsList(void);
	__fastcall virtual ~TRzBlinkingControlsList(void);
	void __fastcall Add(Controls::TControl* Control);
	void __fastcall Remove(Controls::TControl* Control);
	void __fastcall TimerFired(System::TObject* Sender);
	__property int Count = {read=GetCount, nodefault};
	__property Word IntervalOff = {read=FIntervalOff, write=FIntervalOff, nodefault};
	__property Word IntervalOn = {read=FIntervalOn, write=FIntervalOn, nodefault};
};


#pragma option push -b-
enum TRzGradientColorStyle { gcsSystem, gcsMSOffice, gcsCustom };
#pragma option pop

#pragma option push -b-
enum TRzVisualStyle { vsClassic, vsWinXP, vsGradient };
#pragma option pop

#pragma option push -b-
enum TRzXPThemeColor { xptcEditBorder, xptcNormalGroupFont, xptcSpecialGroupFont, xptcGroupBarFill, xptcListGroupFill, xptcListGroupFont, xptcGroupBoxFont, xptcSpinButtonBorder };
#pragma option pop

#pragma option push -b-
enum TRzXPColorScheme { xpcsBlue, xpcsGreen, xpcsSilver };
#pragma option pop

#pragma option push -b-
enum TRzUIStyle { uiWindows95, uiWindowsXP, uiWindowsVista };
#pragma option pop

#pragma option push -b-
enum TRzButtonDisplayState { bdsNormal, bdsDown, bdsHot, bdsDisabled };
#pragma option pop

#pragma option push -b-
enum TRzButtonHotTrackStyle { htsInterior, htsFrame };
#pragma option pop

class DELPHICLASS TRzOldPropReader;
class PASCALIMPLEMENTATION TRzOldPropReader : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static void __fastcall ReadOldBooleanProp(TMetaClass* vmt, Classes::TReader* Reader);
	/*         class method */ static void __fastcall ReadOldEnumProp(TMetaClass* vmt, Classes::TReader* Reader);
	/*         class method */ static void __fastcall ReadOldIdentProp(TMetaClass* vmt, Classes::TReader* Reader);
	/*         class method */ static void __fastcall ReadOldIntegerProp(TMetaClass* vmt, Classes::TReader* Reader);
	/*         class method */ static void __fastcall ReadOldSetProp(TMetaClass* vmt, Classes::TReader* Reader);
	/*         class method */ static void __fastcall ReadOldStringProp(TMetaClass* vmt, Classes::TReader* Reader);
	/*         class method */ static void __fastcall WriteOldProp(TMetaClass* vmt, Classes::TWriter* Writer);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TRzOldPropReader(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzOldPropReader(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDialogComponent;
class PASCALIMPLEMENTATION TRzDialogComponent : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Forms::TFormBorderStyle FBorderStyle;
	AnsiString FCaption;
	AnsiString FCaptionOk;
	AnsiString FCaptionCancel;
	AnsiString FCaptionHelp;
	bool FCenterToParent;
	Graphics::TFont* FFont;
	Graphics::TColor FFrameColor;
	TFrameStyleEx FFrameStyle;
	bool FFrameVisible;
	TFramingPreference FFramingPreference;
	int FHeight;
	Classes::THelpContext FHelpContext;
	int FOriginLeft;
	int FOriginTop;
	int FWidth;
	Forms::TPosition FPosition;
	
protected:
	TRzAboutInfo FAboutInfo;
	void __fastcall CenterForm(Forms::TForm* Dlg);
	virtual void __fastcall SetFont(Graphics::TFont* Value);
	virtual void __fastcall SetCenterToParent(bool Value);
	__property Forms::TFormBorderStyle BorderStyle = {read=FBorderStyle, write=FBorderStyle, default=2};
	__property AnsiString Caption = {read=FCaption, write=FCaption};
	__property AnsiString CaptionOK = {read=FCaptionOk, write=FCaptionOk};
	__property AnsiString CaptionCancel = {read=FCaptionCancel, write=FCaptionCancel};
	__property AnsiString CaptionHelp = {read=FCaptionHelp, write=FCaptionHelp};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=FFrameColor, default=-16777200};
	__property TFrameStyle FrameStyle = {read=FFrameStyle, write=FFrameStyle, default=1};
	__property bool FrameVisible = {read=FFrameVisible, write=FFrameVisible, default=0};
	__property TFramingPreference FramingPreference = {read=FFramingPreference, write=FFramingPreference, default=1};
	__property int Height = {read=FHeight, write=FHeight, default=300};
	__property Classes::THelpContext HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
	__property int Width = {read=FWidth, write=FWidth, default=350};
	
public:
	__fastcall virtual TRzDialogComponent(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDialogComponent(void);
	
__published:
	__property bool CenterToParent = {read=FCenterToParent, write=SetCenterToParent, default=0};
	__property int OriginLeft = {read=FOriginLeft, write=FOriginLeft, default=100};
	__property Forms::TPosition Position = {read=FPosition, write=FPosition, default=4};
	__property int OriginTop = {read=FOriginTop, write=FOriginTop, default=100};
};


#pragma option push -b-
enum TRzFrameControllerProperty { fcpColor, fcpFocusColor, fcpDisabledColor, fcpReadOnlyColor, fcpReadOnlyColorOnFocus, fcpParentColor, fcpFlatButtonColor, fcpFlatButtons, fcpFrameColor, fcpFrameHotColor, fcpFrameHotTrack, fcpFrameHotStyle, fcpFrameSides, fcpFrameStyle, fcpFrameVisible, fcpFramingPreference, fcpAll };
#pragma option pop

typedef TRzFrameControllerProperty TRzFrameControllerPropertyConnection;

typedef Set<TRzFrameControllerPropertyConnection, fcpColor, fcpFramingPreference>  TRzFrameControllerNotifications;

__interface IRzCustomFramingNotification;
typedef System::DelphiInterface<IRzCustomFramingNotification> _di_IRzCustomFramingNotification;
__interface  INTERFACE_UUID("{64B1C9EA-C954-428A-95C4-4EA2EB0F1E16}") IRzCustomFramingNotification  : public IInterface 
{
	
public:
	virtual void __fastcall CustomFramingChanged(void) = 0 ;
};

class DELPHICLASS TRzFrameController;
class DELPHICLASS TRzRegIniFile;
#pragma option push -b-
enum TRzPathType { ptIniFile, ptRegistry };
#pragma option pop

#pragma option push -b-
enum TRzRegKey { hkeyClassesRoot, hkeyCurrentUser, hkeyLocalMachine, hkeyUsers, hkeyPerformanceData, hkeyCurrentConfig, hkeyDynData };
#pragma option pop

#pragma option push -b-
enum TRzRegAccessKey { keyQueryValue, keySetValue, keyCreateSubKey, keyEnumerateSubKeys, keyNotify, keyCreateLink, keyRead, keyWrite, keyExecute, keyAllAccess };
#pragma option pop

typedef Set<TRzRegAccessKey, keyQueryValue, keyAllAccess>  TRzRegAccess;

#pragma option push -b-
enum TRzSpecialFolder { sfNone, sfUserAppDataRoaming, sfUserAppDataLocal, sfUserDocuments, sfProgramData };
#pragma option pop

#pragma option push -b-
enum TRzIniFileEncoding { feDefault, feUTF8, feUnicode };
#pragma option pop

class PASCALIMPLEMENTATION TRzRegIniFile : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TRzAboutInfo FAboutInfo;
	AnsiString FPath;
	TRzPathType FPathType;
	TRzRegKey FRegKey;
	TRzRegAccess FRegAccess;
	TRzSpecialFolder FSpecialFolder;
	TRzIniFileEncoding FFileEncoding;
	bool FRefreshStorage;
	Inifiles::TMemIniFile* FIni;
	Registry::TRegistryIniFile* FReg;
	
protected:
	void __fastcall CheckAccess(void);
	void __fastcall UpdateIniFile(void);
	virtual void __fastcall SetPath(const AnsiString Value);
	virtual void __fastcall SetPathType(TRzPathType Value);
	virtual void __fastcall SetRegKey(TRzRegKey Value);
	virtual void __fastcall SetRegAccess(TRzRegAccess Value);
	virtual void __fastcall SetSpecialFolder(TRzSpecialFolder Value);
	virtual void __fastcall SetFileEncoding(TRzIniFileEncoding Value);
	
public:
	__fastcall virtual TRzRegIniFile(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzRegIniFile(void);
	bool __fastcall SectionExists(const AnsiString Section);
	bool __fastcall ValueExists(const AnsiString Section, const AnsiString Name);
	bool __fastcall ReadBool(const AnsiString Section, const AnsiString Name, bool Default);
	void __fastcall WriteBool(const AnsiString Section, const AnsiString Name, bool Value);
	System::TDateTime __fastcall ReadDate(const AnsiString Section, const AnsiString Name, System::TDateTime Default);
	void __fastcall WriteDate(const AnsiString Section, const AnsiString Name, System::TDateTime Value);
	System::TDateTime __fastcall ReadDateTime(const AnsiString Section, const AnsiString Name, System::TDateTime Default);
	void __fastcall WriteDateTime(const AnsiString Section, const AnsiString Name, System::TDateTime Value);
	double __fastcall ReadFloat(const AnsiString Section, const AnsiString Name, double Default);
	void __fastcall WriteFloat(const AnsiString Section, const AnsiString Name, double Value);
	int __fastcall ReadInteger(const AnsiString Section, const AnsiString Name, int Default);
	void __fastcall WriteInteger(const AnsiString Section, const AnsiString Name, int Value);
	AnsiString __fastcall ReadString(const AnsiString Section, const AnsiString Name, const AnsiString Default);
	void __fastcall WriteString(const AnsiString Section, const AnsiString Name, const AnsiString Value);
	System::TDateTime __fastcall ReadTime(const AnsiString Section, const AnsiString Name, System::TDateTime Default);
	void __fastcall WriteTime(const AnsiString Section, const AnsiString Name, System::TDateTime Value);
	int __fastcall ReadBinaryStream(const AnsiString Section, const AnsiString Name, Classes::TStream* Value);
	void __fastcall WriteBinaryStream(const AnsiString Section, const AnsiString Name, Classes::TStream* Value);
	void __fastcall ReadSection(const AnsiString Section, Classes::TStrings* Strings);
	void __fastcall ReadSections(Classes::TStrings* Strings);
	void __fastcall ReadSectionValues(const AnsiString Section, Classes::TStrings* Strings);
	void __fastcall EraseSection(const AnsiString Section);
	void __fastcall DeleteKey(const AnsiString Section, const AnsiString Name);
	
__published:
	__property TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property TRzIniFileEncoding FileEncoding = {read=FFileEncoding, write=SetFileEncoding, default=0};
	__property AnsiString Path = {read=FPath, write=SetPath};
	__property TRzPathType PathType = {read=FPathType, write=SetPathType, default=0};
	__property TRzRegKey RegKey = {read=FRegKey, write=SetRegKey, default=1};
	__property TRzRegAccess RegAccess = {read=FRegAccess, write=SetRegAccess, default=512};
	__property TRzSpecialFolder SpecialFolder = {read=FSpecialFolder, write=SetSpecialFolder, default=0};
};


class PASCALIMPLEMENTATION TRzFrameController : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TRzAboutInfo FAboutInfo;
	Graphics::TColor FColor;
	bool FParentColor;
	Classes::TList* FFrameList;
	Graphics::TColor FFlatButtonColor;
	bool FFlatButtons;
	Graphics::TColor FDisabledColor;
	Graphics::TColor FReadOnlyColor;
	bool FReadOnlyColorOnFocus;
	Graphics::TColor FFocusColor;
	Graphics::TColor FFrameColor;
	Graphics::TColor FFrameHotColor;
	bool FFrameHotTrack;
	TFrameStyleEx FFrameHotStyle;
	TSides FFrameSides;
	TFrameStyleEx FFrameStyle;
	bool FFrameVisible;
	TFramingPreference FFramingPreference;
	int FUpdateCount;
	TRzRegIniFile* FRegIniFile;
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameFocusStyleProp(Classes::TReader* Reader);
	bool __fastcall StoreColor(void);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	TRzFrameControllerNotifications __fastcall GetNotifications(Classes::TComponent* C);
	virtual void __fastcall UpdateControlFrame(Classes::TComponent* C, TRzFrameControllerProperty FrameProperty);
	virtual void __fastcall UpdateFrames(TRzFrameControllerProperty FrameProperty);
	virtual void __fastcall SetColor(Graphics::TColor Value);
	virtual void __fastcall SetParentColor(bool Value);
	virtual void __fastcall SetFlatButtonColor(Graphics::TColor Value);
	virtual void __fastcall SetFlatButtons(bool Value);
	virtual void __fastcall SetDisabledColor(Graphics::TColor Value);
	virtual void __fastcall SetReadOnlyColor(Graphics::TColor Value);
	virtual void __fastcall SetReadOnlyColorOnFocus(bool Value);
	virtual void __fastcall SetFocusColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameHotColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameHotTrack(bool Value);
	virtual void __fastcall SetFrameHotStyle(TFrameStyle Value);
	virtual void __fastcall SetFrameSides(TSides Value);
	virtual void __fastcall SetFrameStyle(TFrameStyle Value);
	virtual void __fastcall SetFrameVisible(bool Value);
	virtual void __fastcall SetFramingPreference(TFramingPreference Value);
	virtual void __fastcall SetRegIniFile(TRzRegIniFile* Value);
	
public:
	__fastcall virtual TRzFrameController(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzFrameController(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall UpdateControls(void);
	void __fastcall AddControl(Classes::TComponent* C);
	void __fastcall RemoveControl(Classes::TComponent* C);
	void __fastcall Load(const AnsiString Section);
	void __fastcall Save(const AnsiString Section);
	
__published:
	__property TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, stored=StoreColor, default=-16777211};
	__property Graphics::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, default=-16777201};
	__property Graphics::TColor ReadOnlyColor = {read=FReadOnlyColor, write=SetReadOnlyColor, default=-16777192};
	__property bool ReadOnlyColorOnFocus = {read=FReadOnlyColorOnFocus, write=SetReadOnlyColorOnFocus, default=0};
	__property Graphics::TColor FlatButtonColor = {read=FFlatButtonColor, write=SetFlatButtonColor, default=-16777201};
	__property bool FlatButtons = {read=FFlatButtons, write=SetFlatButtons, default=1};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=-16777211};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, default=-16777200};
	__property Graphics::TColor FrameHotColor = {read=FFrameHotColor, write=SetFrameHotColor, default=-16777200};
	__property TFrameStyle FrameHotStyle = {read=FFrameHotStyle, write=SetFrameHotStyle, default=10};
	__property bool FrameHotTrack = {read=FFrameHotTrack, write=SetFrameHotTrack, default=0};
	__property TSides FrameSides = {read=FFrameSides, write=SetFrameSides, default=15};
	__property TFrameStyle FrameStyle = {read=FFrameStyle, write=SetFrameStyle, default=1};
	__property bool FrameVisible = {read=FFrameVisible, write=SetFrameVisible, default=0};
	__property TFramingPreference FramingPreference = {read=FFramingPreference, write=SetFramingPreference, default=1};
	__property bool ParentColor = {read=FParentColor, write=SetParentColor, default=0};
	__property TRzRegIniFile* RegIniFile = {read=FRegIniFile, write=SetRegIniFile};
};


class DELPHICLASS ENoRegIniFile;
class PASCALIMPLEMENTATION ENoRegIniFile : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ENoRegIniFile(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ENoRegIniFile(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ENoRegIniFile(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ENoRegIniFile(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ENoRegIniFile(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ENoRegIniFile(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ENoRegIniFile(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ENoRegIniFile(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ENoRegIniFile(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzPropertyItem;
class PASCALIMPLEMENTATION TRzPropertyItem : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Classes::TComponent* FComponent;
	AnsiString FPropertyName;
	
protected:
	virtual AnsiString __fastcall GetDisplayName();
	
public:
	__fastcall virtual TRzPropertyItem(Classes::TCollection* Collection);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Classes::TComponent* Component = {read=FComponent, write=FComponent};
	__property AnsiString PropertyName = {read=FPropertyName, write=FPropertyName};
public:
	#pragma option push -w-inl
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TRzPropertyItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzPropertyCollection;
class DELPHICLASS TRzPropertyStore;
class PASCALIMPLEMENTATION TRzPropertyStore : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TRzAboutInfo FAboutInfo;
	TRzPropertyCollection* FProperties;
	TRzRegIniFile* FRegIniFile;
	AnsiString FSection;
	void __fastcall SaveProperties(const AnsiString Section, const AnsiString ParentPropName, System::TObject* Obj);
	void __fastcall SaveCollection(const AnsiString Section, const AnsiString FullPropName, Classes::TCollection* Collection);
	void __fastcall SaveStringList(const AnsiString Section, const AnsiString FullPropName, Classes::TStrings* StrList);
	void __fastcall LoadProperties(const AnsiString Section, const AnsiString ParentPropName, System::TObject* Obj);
	void __fastcall LoadCollection(const AnsiString Section, const AnsiString FullPropName, Classes::TCollection* Collection);
	void __fastcall LoadStringList(const AnsiString Section, const AnsiString FullPropName, Classes::TStrings* StrList);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	AnsiString __fastcall GetSection();
	virtual void __fastcall SetProperties(TRzPropertyCollection* Value);
	virtual void __fastcall SetRegIniFile(TRzRegIniFile* Value);
	
public:
	__fastcall virtual TRzPropertyStore(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzPropertyStore(void);
	virtual void __fastcall Save(void);
	virtual void __fastcall Load(void);
	void __fastcall AddProperty(Classes::TComponent* Component, const AnsiString PropertyName);
	
__published:
	__property TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property TRzPropertyCollection* Properties = {read=FProperties, write=SetProperties};
	__property TRzRegIniFile* RegIniFile = {read=FRegIniFile, write=SetRegIniFile};
	__property AnsiString Section = {read=FSection, write=FSection};
};


class PASCALIMPLEMENTATION TRzPropertyCollection : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TRzPropertyItem* operator[](int Index) { return Items[Index]; }
	
private:
	TRzPropertyStore* FStore;
	HIDESBASE TRzPropertyItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TRzPropertyItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TRzPropertyCollection(TRzPropertyStore* Store);
	HIDESBASE TRzPropertyItem* __fastcall Add(void);
	TRzPropertyItem* __fastcall AddProperty(Classes::TComponent* Component, const AnsiString PropertyName);
	__property TRzPropertyItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TRzPropertyStore* Store = {read=FStore};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TRzPropertyCollection(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzCustomColors;
class PASCALIMPLEMENTATION TRzCustomColors : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TRzAboutInfo FAboutInfo;
	Classes::TStrings* FColors;
	TRzRegIniFile* FRegIniFile;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall InitColors(void);
	AnsiString __fastcall GetColorName(int Index);
	void __fastcall FixupColors(void);
	virtual void __fastcall SetColors(Classes::TStrings* Value);
	virtual void __fastcall SetRegIniFile(TRzRegIniFile* Value);
	
public:
	__fastcall virtual TRzCustomColors(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomColors(void);
	void __fastcall Load(const AnsiString Section);
	void __fastcall Save(const AnsiString Section);
	
__published:
	__property TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Classes::TStrings* Colors = {read=FColors, write=SetColors};
	__property TRzRegIniFile* RegIniFile = {read=FRegIniFile, write=SetRegIniFile};
};


class DELPHICLASS TRzMenuController;
class PASCALIMPLEMENTATION TRzMenuController : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TRzAboutInfo FAboutInfo;
	Classes::TList* FMenuItemList;
	TRzGradientColorStyle FGradientColorStyle;
	Graphics::TColor FSelectionColorStart;
	Graphics::TColor FSelectionColorStop;
	Graphics::TColor FSelectionFrameColor;
	Graphics::TColor FIconBarColorStart;
	Graphics::TColor FIconBarColorStop;
	Graphics::TColor FMenuColor;
	Graphics::TColor FMenuFontColor;
	Graphics::TFont* FMenuFont;
	bool FUseCustomMenuFont;
	bool __fastcall HideMenuPrefix(void);
	void __fastcall ReadOldGradientColorStartProp(Classes::TReader* Reader);
	void __fastcall ReadOldGradientColorStopProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameColorProp(Classes::TReader* Reader);
	void __fastcall SetMenuFontColor(Graphics::TColor Value);
	void __fastcall SetMenuFont(Graphics::TFont* Value);
	void __fastcall AdvancedDrawItemHandler(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Windows::TOwnerDrawState State);
	void __fastcall MeasureItemHandler(System::TObject* Sender, Graphics::TCanvas* ACanvas, int &Width, int &Height);
	void __fastcall MenuFontChangeHandler(System::TObject* Sender);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall SetupMenus(void);
	void __fastcall SetupMenuItems(void);
	void __fastcall SetupMenuItem(Menus::TMenuItem* Item);
	void __fastcall CleanupMenuItems(void);
	void __fastcall CleanupMenuItem(Menus::TMenuItem* Item);
	bool __fastcall MenuIsRightToLeft(Menus::TMenuItem* Item);
	void __fastcall MeasureMenuItem(Menus::TMenuItem* Item, Graphics::TCanvas* Canvas, int &Width, int &Height);
	void __fastcall PaintMenuItem(Menus::TMenuItem* Item, Graphics::TCanvas* Canvas, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	
public:
	__fastcall virtual TRzMenuController(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzMenuController(void);
	
__published:
	__property TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property TRzGradientColorStyle GradientColorStyle = {read=FGradientColorStyle, write=FGradientColorStyle, default=0};
	__property Graphics::TColor SelectionColorStart = {read=FSelectionColorStart, write=FSelectionColorStart, default=-16777201};
	__property Graphics::TColor SelectionColorStop = {read=FSelectionColorStop, write=FSelectionColorStop, default=-16777200};
	__property Graphics::TColor SelectionFrameColor = {read=FSelectionFrameColor, write=FSelectionFrameColor, default=-16777195};
	__property Graphics::TColor IconBarColorStart = {read=FIconBarColorStart, write=FIconBarColorStart, default=16777215};
	__property Graphics::TColor IconBarColorStop = {read=FIconBarColorStop, write=FIconBarColorStop, default=-16777201};
	__property Graphics::TColor MenuColor = {read=FMenuColor, write=FMenuColor, default=-16777211};
	__property Graphics::TColor MenuFontColor = {read=FMenuFontColor, write=SetMenuFontColor, default=-16777208};
	__property Graphics::TFont* MenuFont = {read=FMenuFont, write=SetMenuFont, stored=FUseCustomMenuFont};
	__property bool UseCustomMenuFont = {read=FUseCustomMenuFont, write=FUseCustomMenuFont, default=0};
};


#pragma option push -b-
enum TRzWindowsVersion { win95, winNT, win98, winMe, win2000, winXP, winServer2003, winVista, win7 };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
#define RaizeComponents_Version "5.5"
static const Word cm_GetBlinking = 0xb3e8;
static const Word cm_Blink = 0xb3e9;
static const Word cm_ToolbarShowCaptionChanged = 0xb3ea;
static const Word cm_ToolbarButtonLayoutChanged = 0xb3eb;
static const Word cm_ToolbarButtonSizeChanged = 0xb3ec;
static const Word cm_ToolbarVisualStyleChanged = 0xb3ed;
static const Word cm_HidePreviewPanel = 0xb3ee;
static const Word cm_GroupItemSelected = 0xb3ef;
#define sdAllSides (Set<TSide, sdLeft, sdBottom> () << TSide(0) << TSide(1) << TSide(2) << TSide(3) )
#define fsDoubleBorders (Set<TFrameStyleEx, fsNone, fsFlatRounded> () << TFrameStyleEx(2) << TFrameStyleEx(3) << TFrameStyleEx(4) << TFrameStyleEx(5) << TFrameStyleEx(6) << TFrameStyleEx(7) << TFrameStyleEx(10) << TFrameStyleEx(11) )
extern PACKAGE Graphics::TColor ULFrameColor[11];
extern PACKAGE Graphics::TColor LRFrameColor[11];
extern PACKAGE Word DrawTextAlignments[3];
extern PACKAGE Word SetTextAlignments[3];
extern PACKAGE Word DrawTextWordWrap[2];
extern PACKAGE TRzBlinkingControlsList* BlinkingControls;
static const int xpHotTrackColor = 0x149bf0;
static const int xpRadChkMarkColor = 0x21a121;
static const int xpRadChkFrameColor = 0x80511c;
static const int xpButtonFrameColor = 0x743c00;
static const int xpButtonFaceColor = 0xf0f4f4;
static const int xpEditFrameColor = 0xb99d7f;
static const int xpTabControlFrameColor = 0x9c9b91;
static const int xpTabControlColor = 0xf5f6f7;
extern PACKAGE Graphics::TColor xpOfficeBlue_Selection_FrameColor;
extern PACKAGE Graphics::TColor xpOfficeBlue_Selection_ColorStart;
extern PACKAGE Graphics::TColor xpOfficeBlue_Selection_ColorStop;
extern PACKAGE Graphics::TColor xpOfficeBlue_Panel_ColorStart;
extern PACKAGE Graphics::TColor xpOfficeBlue_Panel_ColorStop;
extern PACKAGE Graphics::TColor xpOfficeBlue_Panel_FrameColor;
extern PACKAGE Graphics::TColor xpOfficeBlue_GroupBar_ColorStart;
extern PACKAGE Graphics::TColor xpOfficeBlue_GroupBar_ColorStop;
static const int xpOfficeBlue_CategoryGroup_CaptionBackColor = 16777215;
static const int xpOfficeBlue_CategoryGroup_CaptionBackColorStart = 16777215;
static const int xpOfficeBlue_CategoryGroup_CaptionBackColorStop = 0xf7d3c6;
static const int xpOfficeBlue_CategoryGroup_CaptionFontColor = 0xa53c00;
static const int xpOfficeBlue_CategoryGroup_CaptionFontHotColor = 0xff8e42;
static const int xpOfficeBlue_CategoryGroup_CaptionButtonColor = 0xfcfcfc;
static const int xpOfficeBlue_CategoryGroup_CaptionButtonBorderColor = 0xd9bab3;
static const int xpOfficeBlue_CategoryGroup_CaptionDividerColor = 0xc56a31;
static const int xpOfficeBlue_CategoryGroup_GroupColor = 0xf7dfd6;
static const int xpOfficeBlue_CategoryGroup_GroupBorderColor = 16777215;
static const int xpOfficeBlue_CategoryGroup_ItemFontColor = 0xc65d21;
static const int xpOfficeBlue_CategoryGroup_ItemFontHotColor = 0xff8e42;
static const int xpOfficeBlue_CategoryGroupSpecial_CaptionBackColor = 0xc56a31;
static const int xpOfficeBlue_CategoryGroupSpecial_CaptionBackColorStart = 0xbe500f;
static const int xpOfficeBlue_CategoryGroupSpecial_CaptionBackColorStop = 0xce5d29;
static const int xpOfficeBlue_CategoryGroupSpecial_CaptionFontColor = 16777215;
static const int xpOfficeBlue_CategoryGroupSpecial_CaptionFontHotColor = 0xf7dfd6;
static const int xpOfficeBlue_CategoryGroupSpecial_CaptionButtonColor = 0xc35e2f;
static const int xpOfficeBlue_CategoryGroupSpecial_CaptionButtonBorderColor = 0xde9a6a;
static const int xpOfficeBlue_CategoryGroupSpecial_CaptionDividerColor = 0xc56a31;
static const int xpOfficeBlue_CategoryGroupSpecial_GroupColor = 0xfff3ef;
static const int xpOfficeBlue_CategoryGroupSpecial_GroupBorderColor = 16777215;
extern PACKAGE Graphics::TColor xpOfficeGreen_Selection_FrameColor;
extern PACKAGE Graphics::TColor xpOfficeGreen_Selection_ColorStart;
extern PACKAGE Graphics::TColor xpOfficeGreen_Selection_ColorStop;
extern PACKAGE Graphics::TColor xpOfficeGreen_Panel_ColorStart;
extern PACKAGE Graphics::TColor xpOfficeGreen_Panel_ColorStop;
extern PACKAGE Graphics::TColor xpOfficeGreen_Panel_FrameColor;
extern PACKAGE Graphics::TColor xpOfficeGreen_GroupBar_ColorStart;
extern PACKAGE Graphics::TColor xpOfficeGreen_GroupBar_ColorStop;
static const int xpOfficeGreen_CategoryGroup_CaptionBackColor = 0xb8e7e0;
static const int xpOfficeGreen_CategoryGroup_CaptionBackColorStart = 0xd5f3f1;
static const int xpOfficeGreen_CategoryGroup_CaptionBackColorStop = 0xb8e7e0;
static const int xpOfficeGreen_CategoryGroup_CaptionFontColor = 0x1c674b;
static const int xpOfficeGreen_CategoryGroup_CaptionFontHotColor = 0x1d9272;
static const int xpOfficeGreen_CategoryGroup_CaptionButtonColor = 0xfcfcfc;
static const int xpOfficeGreen_CategoryGroup_CaptionButtonBorderColor = 0xbed5ca;
static const int xpOfficeGreen_CategoryGroup_CaptionDividerColor = 0x70a093;
static const int xpOfficeGreen_CategoryGroup_GroupColor = 0xecf6f6;
static const int xpOfficeGreen_CategoryGroup_GroupBorderColor = 16777215;
static const int xpOfficeGreen_CategoryGroup_ItemFontColor = 0x2d6656;
static const int xpOfficeGreen_CategoryGroup_ItemFontHotColor = 0x1d9272;
static const int xpOfficeGreen_CategoryGroupSpecial_CaptionBackColor = 0x70a093;
static const int xpOfficeGreen_CategoryGroupSpecial_CaptionBackColorStart = 0x4e9682;
static const int xpOfficeGreen_CategoryGroupSpecial_CaptionBackColorStop = 0x67a896;
static const int xpOfficeGreen_CategoryGroupSpecial_CaptionFontColor = 16777215;
static const int xpOfficeGreen_CategoryGroupSpecial_CaptionFontHotColor = 0xa9d6c8;
static const int xpOfficeGreen_CategoryGroupSpecial_CaptionButtonColor = 0x4fa382;
static const int xpOfficeGreen_CategoryGroupSpecial_CaptionButtonBorderColor = 0x81b7a9;
static const int xpOfficeGreen_CategoryGroupSpecial_CaptionDividerColor = 0x70a093;
static const int xpOfficeGreen_CategoryGroupSpecial_GroupColor = 0xecf6f6;
static const int xpOfficeGreen_CategoryGroupSpecial_GroupBorderColor = 16777215;
extern PACKAGE Graphics::TColor xpOfficeSilver_Selection_FrameColor;
extern PACKAGE Graphics::TColor xpOfficeSilver_Selection_ColorStart;
extern PACKAGE Graphics::TColor xpOfficeSilver_Selection_ColorStop;
extern PACKAGE Graphics::TColor xpOfficeSilver_Panel_ColorStart;
extern PACKAGE Graphics::TColor xpOfficeSilver_Panel_ColorStop;
extern PACKAGE Graphics::TColor xpOfficeSilver_Panel_FrameColor;
extern PACKAGE Graphics::TColor xpOfficeSilver_GroupBar_ColorStart;
extern PACKAGE Graphics::TColor xpOfficeSilver_GroupBar_ColorStop;
static const int xpOfficeSilver_CategoryGroup_CaptionBackColor = 0xe0d7d6;
static const int xpOfficeSilver_CategoryGroup_CaptionBackColorStart = 0xfcfbfb;
static const int xpOfficeSilver_CategoryGroup_CaptionBackColorStop = 0xe0d7d6;
static const int xpOfficeSilver_CategoryGroup_CaptionFontColor = 0x3d3d3f;
static const int xpOfficeSilver_CategoryGroup_CaptionFontHotColor = 0x7c7c7e;
static const int xpOfficeSilver_CategoryGroup_CaptionButtonColor = 0xfcfcfc;
static const int xpOfficeSilver_CategoryGroup_CaptionButtonBorderColor = 0xd1c5c3;
static const int xpOfficeSilver_CategoryGroup_CaptionDividerColor = 0xbfb4b2;
static const int xpOfficeSilver_CategoryGroup_GroupColor = 0xf5f1f0;
static const int xpOfficeSilver_CategoryGroup_GroupBorderColor = 16777215;
static const int xpOfficeSilver_CategoryGroup_ItemFontColor = 0x3d3d3f;
static const int xpOfficeSilver_CategoryGroup_ItemFontHotColor = 0x7c7c7e;
static const int xpOfficeSilver_CategoryGroupSpecial_CaptionBackColor = 0xab9594;
static const int xpOfficeSilver_CategoryGroupSpecial_CaptionBackColorStart = 0xa58d8c;
static const int xpOfficeSilver_CategoryGroupSpecial_CaptionBackColorStop = 0xc7b6b4;
static const int xpOfficeSilver_CategoryGroupSpecial_CaptionFontColor = 16777215;
static const int xpOfficeSilver_CategoryGroupSpecial_CaptionFontHotColor = 0xe0d7d6;
static const int xpOfficeSilver_CategoryGroupSpecial_CaptionButtonColor = 0x96746e;
static const int xpOfficeSilver_CategoryGroupSpecial_CaptionButtonBorderColor = 0xdec7c1;
static const int xpOfficeSilver_CategoryGroupSpecial_CaptionDividerColor = 0xbfb4b2;
static const int xpOfficeSilver_CategoryGroupSpecial_GroupColor = 0xf5f1f0;
static const int xpOfficeSilver_CategoryGroupSpecial_GroupBorderColor = 16777215;
extern PACKAGE TRzXPColorScheme CurrentXPColorScheme;
extern PACKAGE bool FullColorSupported;
extern PACKAGE int IncrementalSearchResetDelay;
#define fccAll (Set<TRzFrameControllerProperty, fcpColor, fcpAll> () << TRzFrameControllerProperty(0) << TRzFrameControllerProperty(1) << TRzFrameControllerProperty(2) << TRzFrameControllerProperty(3) << TRzFrameControllerProperty(4) << TRzFrameControllerProperty(5) << TRzFrameControllerProperty(6) << TRzFrameControllerProperty(7) << TRzFrameControllerProperty(8) << TRzFrameControllerProperty(9) << TRzFrameControllerProperty(10) << TRzFrameControllerProperty(11) << TRzFrameControllerProperty(12) << TRzFrameControllerProperty(13) << TRzFrameControllerProperty(14) << TRzFrameControllerProperty(15) )
static const Shortint fcpColorBit = 0x1;
static const Shortint fcpFocusColorBit = 0x2;
static const Shortint fcpDisabledColorBit = 0x4;
static const Shortint fcpReadOnlyColorBit = 0x8;
static const Shortint fcpReadOnlyColorOnFocusBit = 0x10;
static const Shortint fcpParentColorBit = 0x20;
static const Shortint fcpFlatButtonColorBit = 0x40;
static const Byte fcpFlatButtonsBit = 0x80;
static const Word fcpFrameColorBit = 0x100;
static const Word fcpFrameHotColorBit = 0x200;
static const Word fcpFrameHotTrackBit = 0x400;
static const Word fcpFrameHotStyleBit = 0x800;
static const Word fcpFrameSidesBit = 0x1000;
static const Word fcpFrameStyleBit = 0x2000;
static const Word fcpFrameVisibleBit = 0x4000;
static const Word fcpFramingPreferenceBit = 0x8000;
extern PACKAGE System::ResourceString _sRzNoRegIniFile;
#define Rzcommon_sRzNoRegIniFile System::LoadResourceString(&Rzcommon::_sRzNoRegIniFile)
extern PACKAGE System::ResourceString _sRzCannotLoadCustomFraming;
#define Rzcommon_sRzCannotLoadCustomFraming System::LoadResourceString(&Rzcommon::_sRzCannotLoadCustomFraming)
extern PACKAGE System::ResourceString _sRzCannotSaveCustomFraming;
#define Rzcommon_sRzCannotSaveCustomFraming System::LoadResourceString(&Rzcommon::_sRzCannotSaveCustomFraming)
extern PACKAGE System::ResourceString _sRzCannotLoadCustomColors;
#define Rzcommon_sRzCannotLoadCustomColors System::LoadResourceString(&Rzcommon::_sRzCannotLoadCustomColors)
extern PACKAGE System::ResourceString _sRzCannotSaveCustomColors;
#define Rzcommon_sRzCannotSaveCustomColors System::LoadResourceString(&Rzcommon::_sRzCannotSaveCustomColors)
extern PACKAGE System::ResourceString _sRzCannotLoadProperties;
#define Rzcommon_sRzCannotLoadProperties System::LoadResourceString(&Rzcommon::_sRzCannotLoadProperties)
extern PACKAGE System::ResourceString _sRzCannotSaveProperties;
#define Rzcommon_sRzCannotSaveProperties System::LoadResourceString(&Rzcommon::_sRzCannotSaveProperties)
extern PACKAGE System::ResourceString _sRzCannotRestoreFormState;
#define Rzcommon_sRzCannotRestoreFormState System::LoadResourceString(&Rzcommon::_sRzCannotRestoreFormState)
extern PACKAGE System::ResourceString _sRzCannotSaveFormState;
#define Rzcommon_sRzCannotSaveFormState System::LoadResourceString(&Rzcommon::_sRzCannotSaveFormState)
extern PACKAGE void __fastcall FreeBlinkingControlsListIfEmpty(void);
extern PACKAGE Types::TRect __fastcall CenterRect(const Types::TRect &R, int Width, int Height);
extern PACKAGE void __fastcall ColorToHSL(Graphics::TColor C, Byte &H, Byte &S, Byte &L);
extern PACKAGE Byte __fastcall ColorHue(Graphics::TColor C);
extern PACKAGE Byte __fastcall ColorSaturation(Graphics::TColor C);
extern PACKAGE Byte __fastcall ColorLuminance(Graphics::TColor C);
extern PACKAGE Graphics::TColor __fastcall HSLtoColor(Byte H, Byte S, Byte L);
extern PACKAGE Graphics::TColor __fastcall DarkerColor(Graphics::TColor C, Byte Adjustment);
extern PACKAGE Graphics::TColor __fastcall LighterColor(Graphics::TColor C, Byte Adjustment);
extern PACKAGE Graphics::TColor __fastcall AdjustColor(Graphics::TColor C, int Adjustment);
extern PACKAGE Graphics::TColor __fastcall BlendColors(Graphics::TColor ForeColor, Graphics::TColor BackColor, Byte Alpha);
extern PACKAGE Graphics::TColor __fastcall XorColors(Graphics::TColor ForeColor, Graphics::TColor BackColor);
extern PACKAGE bool __fastcall ColorsTooClose(Graphics::TColor ForeColor, Graphics::TColor BackColor);
extern PACKAGE Graphics::TColor __fastcall ComplementaryColor(Graphics::TColor C)/* overload */;
extern PACKAGE Graphics::TColor __fastcall ComplementaryColor(Graphics::TColor C, Byte Luminance)/* overload */;
extern PACKAGE Graphics::TColor __fastcall GetXPThemeColor(TRzXPThemeColor Element);
extern PACKAGE TRzXPColorScheme __fastcall GetXPColorScheme(void);
extern PACKAGE void __fastcall GetGradientSelectionColors(TRzGradientColorStyle ColorStyle, Graphics::TColor &FrameColor, Graphics::TColor &StartColor, Graphics::TColor &StopColor);
extern PACKAGE void __fastcall GetGradientPanelColors(TRzGradientColorStyle ColorStyle, Graphics::TColor &StartColor, Graphics::TColor &StopColor);
extern PACKAGE Graphics::TColor __fastcall GetGradientPanelFrameColor(TRzGradientColorStyle ColorStyle);
extern PACKAGE void __fastcall GetGradientStatusBarColors(TRzGradientColorStyle ColorStyle, Graphics::TColor &StartColor, Graphics::TColor &StopColor, Graphics::TColor &DividerColor);
extern PACKAGE void __fastcall GetGradientGroupBarColors(TRzGradientColorStyle ColorStyle, Graphics::TColor &StartColor, Graphics::TColor &StopColor);
extern PACKAGE void __fastcall GetGradientCategoryGroupColors(TRzGradientColorStyle ColorStyle, bool SpecialGroup, Graphics::TColor &CaptionBackColor, Graphics::TColor &CaptionBackColorStart, Graphics::TColor &CaptionBackColorStop, Graphics::TColor &CaptionFontColor, Graphics::TColor &CaptionFontHotColor, Graphics::TColor &CaptionButtonColor, Graphics::TColor &CaptionButtonBorderColor, Graphics::TColor &CaptionDividerColor, Graphics::TColor &GroupColor, Graphics::TColor &GroupBorderColor);
extern PACKAGE void __fastcall GetGradientOutlookGroupColors(TRzGradientColorStyle ColorStyle, Graphics::TColor &CaptionBackStartColor, Graphics::TColor &CaptionBackStopColor, Graphics::TColor &CaptionFontColor, Graphics::TColor &CaptionFontHotColor, Graphics::TColor &GroupStartColor, Graphics::TColor &GroupStopColor);
extern PACKAGE void __fastcall GetGradientGroupItemColors(TRzGradientColorStyle ColorStyle, Graphics::TColor &ItemFontColor, Graphics::TColor &ItemFontHotColor);
extern PACKAGE bool __fastcall IsFullColorSupported(void);
extern PACKAGE void __fastcall DrawDropShadow(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, int Depth, Graphics::TColor ShadowColor = (Graphics::TColor)(0x0));
extern PACKAGE Types::TRect __fastcall DrawSides(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Graphics::TColor ULColor, Graphics::TColor LRColor, TSides Sides);
extern PACKAGE Types::TRect __fastcall DrawBevel(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Graphics::TColor ULColor, Graphics::TColor LRColor, int Width, TSides Sides);
extern PACKAGE Types::TRect __fastcall DrawCtl3DBorder(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, bool Lowered);
extern PACKAGE Types::TRect __fastcall DrawCtl3DBorderSides(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, bool Lowered, TSides Sides);
extern PACKAGE Types::TRect __fastcall DrawButtonBorder(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, bool Lowered);
extern PACKAGE Types::TRect __fastcall DrawButtonBorderSides(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, bool Lowered, TSides Sides);
extern PACKAGE Types::TRect __fastcall DrawColorButtonBorder(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Graphics::TColor FaceColor, bool Lowered);
extern PACKAGE Types::TRect __fastcall DrawColorButtonBorderSides(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Graphics::TColor FaceColor, bool Lowered, TSides Sides);
extern PACKAGE Types::TRect __fastcall DrawBorder(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, TFrameStyle Style);
extern PACKAGE Types::TRect __fastcall DrawBorderSides(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, TFrameStyle Style, TSides Sides);
extern PACKAGE Types::TRect __fastcall DrawColorBorder(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Graphics::TColor FaceColor, TFrameStyle Style);
extern PACKAGE Types::TRect __fastcall DrawColorBorderSides(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Graphics::TColor FaceColor, TFrameStyle Style, TSides Sides);
extern PACKAGE Types::TRect __fastcall DrawBox(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Graphics::TColor LineColor);
extern PACKAGE Types::TRect __fastcall DrawBoxCorners(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Graphics::TColor LineColor, int CornerWidth);
extern PACKAGE Types::TRect __fastcall DrawDashedBorder(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Graphics::TColor DashColor);
extern PACKAGE Types::TRect __fastcall DrawFocusBorder(Graphics::TCanvas* Canvas, const Types::TRect &Bounds);
extern PACKAGE Types::TRect __fastcall DrawRoundedFlatBorder(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Graphics::TColor Color, TSides Sides);
extern PACKAGE Types::TRect __fastcall DrawInnerOuterBorders(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, TFrameStyleEx BorderOuter, TFrameStyleEx BorderInner, int BorderWidth, TSides BorderSides, int BevelWidth, Graphics::TColor BorderColor, Graphics::TColor BorderHighlight, Graphics::TColor BorderShadow, Graphics::TColor FlatColor, int FlatColorAdjustment, Graphics::TColor Color, Graphics::TColor ParentColor, bool Transparent, bool SoftInnerFlatBorder = false);
extern PACKAGE void __fastcall DrawGroupBarBackground(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, TRzVisualStyle VisualStyle, TRzGradientColorStyle ColorStyle, TRzGroupBarGradientPath GradientPath, Graphics::TColor CustomStartColor, Graphics::TColor CustomStopColor);
extern PACKAGE void __fastcall DrawLEDBar(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, TOrientation Orientation, Graphics::TColor BarColor, Graphics::TColor BackColor, int NumSegments, int Percent, bool ThemeAware, bool Transparent);
extern PACKAGE void __fastcall DrawPercentBar(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, TOrientation Orientation, Graphics::TColor BarColor, Graphics::TColor BackColor, Word Percent, bool ShowPercent, bool Transparent, bool ShowParts = false, int PartsComplete = 0x0, int TotalParts = 0x0);
extern PACKAGE void __fastcall DrawGradientPercentBar(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, TOrientation Orientation, Graphics::TColor BarColor, Graphics::TColor BarColorStop, Graphics::TColor BackColor, Graphics::TColor BackColorStop, TGradientDirection gradientDirection, Word Percent, bool ShowPercent, bool Transparent, bool ShowParts = false, int PartsComplete = 0x0, int TotalParts = 0x0);
extern PACKAGE void __fastcall DrawFrame(Graphics::TCanvas* Canvas, int Width, int Height, TFrameStyle FrameStyle, Graphics::TColor EraseColor, Graphics::TColor FrameColor, TSides FrameSides, bool Transparent = false);
extern PACKAGE void __fastcall InvalidateWindowFrame(HWND Handle, const Types::TRect &Bounds);
extern PACKAGE void __fastcall InvalidateControls(Controls::TWinControl* Container);
extern PACKAGE void __fastcall DrawDropDownArrow(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, TRzUIStyle UIStyle, bool Down, bool Enabled = true);
extern PACKAGE void __fastcall DrawSpinArrow(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, TRzUIStyle UIStyle, TDirection Direction, bool Down, bool Enabled = true);
extern PACKAGE void __fastcall DrawCloseX(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Graphics::TColor Color, bool Down, bool Enabled = true)/* overload */;
extern PACKAGE void __fastcall DrawCloseX(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, TRzUIStyle UIStyle, bool Down, bool Enabled = true)/* overload */;
extern PACKAGE void __fastcall DrawHighlightBox(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, TGradientDirection GradientDirection, Graphics::TColor StartColor, Graphics::TColor StopColor);
extern PACKAGE void __fastcall DrawCheckBox(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, Stdctrls::TCheckBoxState CheckState, TRzButtonDisplayState DisplayState, bool Focused, TRzButtonHotTrackStyle HotTrackStyle, Graphics::TColor FrameColor, Graphics::TColor MarkColor, Graphics::TColor FillColor, Graphics::TColor FocusColor, Graphics::TColor DisabledColor, Graphics::TColor HotTrackStartColor, Graphics::TColor HotTrackStopColor, bool ReadOnly, bool ReadOnlyColorOnFocus, Graphics::TColor ReadOnlyColor);
extern PACKAGE void __fastcall DrawRadioButton(Graphics::TCanvas* Canvas, const Types::TRect &Bounds, bool Checked, TRzButtonDisplayState DisplayState, bool Focused, TRzButtonHotTrackStyle HotTrackStyle, Graphics::TColor FrameColor, Graphics::TColor MarkColor, Graphics::TColor FillColor, Graphics::TColor FocusColor, Graphics::TColor DisabledColor, Graphics::TColor HotTrackStartColor, Graphics::TColor HotTrackStopColor, Graphics::TColor BackgroundColor, bool Transparent, Graphics::TColor TransparentColor, bool ReadOnly, bool ReadOnlyColorOnFocus, Graphics::TColor ReadOnlyColor);
extern PACKAGE void __fastcall AddImageToImageList(Imglist::TCustomImageList* ImageList, Graphics::TBitmap* Glyph, bool AddDisabled, int &ImageIndex, int &DisabledIndex);
extern PACKAGE AnsiString __fastcall GetNewComponentName(Classes::TComponent* AOwner, const AnsiString BaseName, bool TryNoIndex = true);
extern PACKAGE AnsiString __fastcall CreateValidIdent(const AnsiString Ident, const AnsiString DefaultName);
extern PACKAGE HFONT __fastcall RotateFont(Graphics::TFont* Font, int Angle);
extern PACKAGE bool __fastcall IsTrueTypeFont(Graphics::TFont* Font);
extern PACKAGE int __fastcall GetMinFontHeight(Graphics::TFont* Font);
extern PACKAGE int __fastcall GetAvgCharWidth(Graphics::TFont* Font);
extern PACKAGE bool __fastcall IsLeadChar(char C);
extern PACKAGE bool __fastcall CharInSet(char C, const Sysutils::TSysCharSet &CharSet);
extern PACKAGE char __fastcall FirstNonWhitespaceChar(const AnsiString S);
extern PACKAGE char __fastcall LastChar(const AnsiString S);
extern PACKAGE int __fastcall CountChar(char C, const AnsiString S);
extern PACKAGE AnsiString __fastcall CopyEx(const AnsiString S, int Start, char C, int Count);
extern PACKAGE bool __fastcall RemoveChar(AnsiString &S, char C);
extern PACKAGE AnsiString __fastcall RemoveAccelerators(const AnsiString S);
extern PACKAGE AnsiString __fastcall ExpandEnvironmentVariables(const AnsiString S);
extern PACKAGE int __fastcall Min(int A, int B);
extern PACKAGE int __fastcall Max(int A, int B);
extern PACKAGE void __fastcall Swap(int &A, int &B)/* overload */;
extern PACKAGE void __fastcall Swap(Word &A, Word &B)/* overload */;
extern PACKAGE void __fastcall UpdateObjectInspector(Controls::TControl* AControl);
extern PACKAGE Types::TRect __fastcall GetDesktopClientRect();
extern PACKAGE Types::TRect __fastcall GetActiveWorkArea(Controls::TWinControl* Window);
extern PACKAGE int __fastcall GetActiveWorkAreaWidth(Controls::TWinControl* Window);
extern PACKAGE int __fastcall GetActiveWorkAreaHeight(Controls::TWinControl* Window);
extern PACKAGE Types::TRect __fastcall GetMonitorWorkArea(Forms::TMonitor* Monitor);
extern PACKAGE Types::TRect __fastcall GetMonitorBoundsRect(Forms::TMonitor* Monitor);
extern PACKAGE Forms::TMonitor* __fastcall GetMonitorContainingPoint(const Types::TPoint &P);
extern PACKAGE void __fastcall CenterToWindow(Controls::TWinControl* ChildWin, Controls::TWinControl* Window, int &Left, int &Top);
extern PACKAGE void __fastcall CenterToForm(Controls::TWinControl* ChildWin, Forms::TCustomForm* AForm, int &Left, int &Top);
extern PACKAGE void __fastcall CenterToMDIChild(Controls::TWinControl* ChildWin, Forms::TForm* AForm, int &Left, int &Top);
extern PACKAGE bool __fastcall RunningUnder(TRzWindowsVersion ver);
extern PACKAGE bool __fastcall RunningAtLeast(TRzWindowsVersion ver);
extern PACKAGE int __fastcall DrawString(Graphics::TCanvas* Canvas, const AnsiString S, Types::TRect &Bounds, unsigned Flags);
extern PACKAGE void __fastcall DrawStringCentered(Graphics::TCanvas* Canvas, const AnsiString S, const Types::TRect &Bounds);
extern PACKAGE int __fastcall SendTextMessage(HWND Handle, unsigned Msg, int WParam, AnsiString LParam);

}	/* namespace Rzcommon */
using namespace Rzcommon;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzcommon
