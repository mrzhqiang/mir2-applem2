// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzfilsys.pas' rev: 10.00

#ifndef RzfilsysHPP
#define RzfilsysHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Filectrl.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Rztreevw.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzfilsys
{
//-- type declarations -------------------------------------------------------
typedef Set<Filectrl::TDriveType, dtUnknown, dtRAM>  TDriveTypes;

typedef Set<Shortint, 0, 25>  TDriveBits;

class DELPHICLASS TRzFileInfo;
class PASCALIMPLEMENTATION TRzFileInfo : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	AnsiString Name;
	int Attr;
	int Time;
	int Size;
	bool IsDirectory;
	unsigned IconHandle;
	Graphics::TBitmap* IconGlyph;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TRzFileInfo(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TRzFileInfo(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRzFileListBox;
class DELPHICLASS TRzDirectoryTree;
#pragma option push -b-
enum TNetworkVolumeFormat { nvfExplorer, nvfUNC, nvfVolumeOnly };
#pragma option pop

class PASCALIMPLEMENTATION TRzDirectoryTree : public Rztreevw::TRzCustomTreeView 
{
	typedef Rztreevw::TRzCustomTreeView inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	TRzFileListBox* FFileList;
	Stdctrls::TLabel* FDirLabel;
	bool FShowHiddenDirs;
	bool FOpenCurrentDir;
	TNetworkVolumeFormat FNetworkVolumeFormat;
	void *FObjInst;
	void *FOldWndProc;
	HWND FFormHandle;
	AnsiString FSaveDirectory;
	bool FUpdating;
	Controls::TImageList* FImages;
	int FFolderOpenIconIndex;
	int FFolderClosedIconIndex;
	TDriveBits FActiveDrives;
	TDriveTypes FDriveTypes;
	unsigned FDriveSerialNums[26];
	char FOldDrive;
	Classes::TNotifyEvent FOnDriveChange;
	Comctrls::TTVExpandedEvent FOnDeletion;
	void __fastcall AddFolderInfoToNode(Comctrls::TTreeNode* Node, const AnsiString NodePath, int IconIndex);
	void __fastcall FormWndProc(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall CreateWindowHandle(const Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWindowHandle(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall InitImageList(void);
	virtual void __fastcall InitView(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall UpdateActiveDrives(void);
	virtual void __fastcall ClearTree(void);
	DYNAMIC bool __fastcall CanExpand(Comctrls::TTreeNode* Node);
	virtual void __fastcall ResetNode(Comctrls::TTreeNode* Node);
	void __fastcall ProcessChildren(Comctrls::TTreeNode* &Node);
	bool __fastcall HaveProcessedChildren(Comctrls::TTreeNode* Node);
	void __fastcall AddTempNodeIfHasChildren(Comctrls::TTreeNode* &Node);
	DYNAMIC void __fastcall Delete(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall DriveChange(void);
	DYNAMIC bool __fastcall CanChange(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Change(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	void __fastcall EditingHandler(System::TObject* Sender, Comctrls::TTreeNode* Node, bool &AllowEdit);
	void __fastcall EditedHandler(System::TObject* Sender, Comctrls::TTreeNode* Node, AnsiString &S);
	virtual AnsiString __fastcall GetDirectory();
	virtual void __fastcall SetDirectory(const AnsiString Value);
	virtual char __fastcall GetDrive(void);
	virtual TDriveBits __fastcall GetDrives(void);
	virtual void __fastcall SetDriveTypes(TDriveTypes Value);
	virtual void __fastcall SetFileList(TRzFileListBox* Value);
	virtual void __fastcall SetDirLabel(Stdctrls::TLabel* Value);
	virtual void __fastcall SetDirLabelCaption(void);
	virtual void __fastcall SetNetworkVolumeFormat(TNetworkVolumeFormat Value);
	virtual void __fastcall SetShowHiddenDirs(bool Value);
	__property Items  = {stored=false};
	
public:
	__fastcall virtual TRzDirectoryTree(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDirectoryTree(void);
	virtual void __fastcall RefreshTree(void);
	void __fastcall RefreshDriveTree(char DriveChar);
	bool __fastcall NodeHasData(Comctrls::TTreeNode* Node);
	Comctrls::TTreeNode* __fastcall GetNodeFromPath(AnsiString Path);
	AnsiString __fastcall GetPathFromNode(Comctrls::TTreeNode* Node);
	void __fastcall UpOneLevel(void);
	void __fastcall CreateNewDir(AnsiString NewDirName, bool PlaceInEditMode);
	__property AnsiString Directory = {read=GetDirectory, write=SetDirectory};
	__property char Drive = {read=GetDrive, nodefault};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Stdctrls::TLabel* DirLabel = {read=FDirLabel, write=SetDirLabel};
	__property TDriveTypes DriveTypes = {read=FDriveTypes, write=SetDriveTypes, default=125};
	__property TRzFileListBox* FileList = {read=FFileList, write=SetFileList};
	__property bool OpenCurrentDir = {read=FOpenCurrentDir, write=FOpenCurrentDir, default=0};
	__property TNetworkVolumeFormat NetworkVolumeFormat = {read=FNetworkVolumeFormat, write=SetNetworkVolumeFormat, default=0};
	__property bool ShowHiddenDirs = {read=FShowHiddenDirs, write=SetShowHiddenDirs, default=0};
	__property Classes::TNotifyEvent OnDriveChange = {read=FOnDriveChange, write=FOnDriveChange};
	__property Comctrls::TTVExpandedEvent OnDeletion = {read=FOnDeletion, write=FOnDeletion};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property AutoExpand  = {default=0};
	__property AutoSelect  = {default=0};
	__property BiDiMode ;
	__property BorderStyle  = {default=1};
	__property BorderWidth  = {default=0};
	__property ChangeDelay  = {default=0};
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property Ctl3D ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property FocusColor  = {default=-16777211};
	__property FrameColor  = {default=-16777200};
	__property FrameController ;
	__property FrameHotColor  = {default=-16777200};
	__property FrameHotTrack  = {default=0};
	__property FrameHotStyle  = {default=10};
	__property FrameSides  = {default=15};
	__property FrameStyle  = {default=1};
	__property FrameVisible  = {default=0};
	__property FramingPreference  = {default=1};
	__property Height  = {default=150};
	__property HideSelection  = {default=1};
	__property HotTrack  = {default=0};
	__property Indent ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=1};
	__property RightClickSelect  = {default=0};
	__property RowSelect  = {default=0};
	__property SelectionPen ;
	__property ShowButtons  = {default=1};
	__property ShowHint ;
	__property ShowLines  = {default=1};
	__property StateImages ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property ToolTips  = {default=1};
	__property Visible  = {default=1};
	__property Width  = {default=250};
	__property OnChange ;
	__property OnChanging ;
	__property OnClick ;
	__property OnCollapsed ;
	__property OnCollapsing ;
	__property OnCompare ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnExpanded ;
	__property OnExpanding ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
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
	/* TWinControl.CreateParented */ inline __fastcall TRzDirectoryTree(HWND ParentWindow) : Rztreevw::TRzCustomTreeView(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzFileListBox : public Filectrl::TFileListBox 
{
	typedef Filectrl::TFileListBox inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	TRzDirectoryTree* FDirTree;
	Classes::TStringList* FFileInfoList;
	bool FShowLongNames;
	bool FAllowOpen;
	bool FUpdatingColor;
	Graphics::TColor FDisabledColor;
	Graphics::TColor FFocusColor;
	Graphics::TColor FNormalColor;
	Graphics::TColor FFrameColor;
	Rzcommon::TRzFrameController* FFrameController;
	Graphics::TColor FFrameHotColor;
	bool FFrameHotTrack;
	Rzcommon::TFrameStyleEx FFrameHotStyle;
	Rzcommon::TSides FFrameSides;
	Rzcommon::TFrameStyleEx FFrameStyle;
	bool FFrameVisible;
	Rzcommon::TFramingPreference FFramingPreference;
	bool FInReadFileNames;
	HIDESBASE void __fastcall ResetItemHeight(void);
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameFocusStyleProp(Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanging(Messages::TWMWindowPosMsg &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	
protected:
	Graphics::TCanvas* FCanvas;
	bool FOverControl;
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall UpdateColors(void);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	virtual void __fastcall RepaintFrame(void);
	virtual void __fastcall ClearFileInfoList(void);
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall ReadBitmaps(void);
	virtual void __fastcall ReadFileNames(void);
	void __fastcall LocalSetDirectory(const AnsiString NewDirectory);
	AnsiString __fastcall LocalGetFileName();
	void __fastcall LocalSetFileName(const AnsiString NewFile);
	virtual int __fastcall Compare(TRzFileInfo* A, TRzFileInfo* B);
	virtual void __fastcall QuickSort(int L, int R);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	bool __fastcall StoreColor(void);
	bool __fastcall StoreFocusColor(void);
	bool __fastcall NotUsingController(void);
	virtual void __fastcall SetDisabledColor(Graphics::TColor Value);
	virtual void __fastcall SetFocusColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetFrameHotColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameHotTrack(bool Value);
	virtual void __fastcall SetFrameHotStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameSides(Rzcommon::TSides Value);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameVisible(bool Value);
	virtual void __fastcall SetFramingPreference(Rzcommon::TFramingPreference Value);
	virtual bool __fastcall GetShowGlyphs(void);
	HIDESBASE virtual void __fastcall SetShowGlyphs(bool Value);
	virtual void __fastcall SetShowLongNames(bool Value);
	virtual AnsiString __fastcall GetLongFileName();
	virtual AnsiString __fastcall GetShortFileName();
	
public:
	__fastcall virtual TRzFileListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzFileListBox(void);
	virtual bool __fastcall UseThemes(void);
	void __fastcall UpOneLevel(void);
	virtual void __fastcall ApplyFilePath(const AnsiString Value);
	__property AnsiString LongFileName = {read=GetLongFileName};
	__property AnsiString ShortFileName = {read=GetShortFileName};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property bool AllowOpen = {read=FAllowOpen, write=FAllowOpen, default=0};
	__property Columns  = {default=0};
	__property Color  = {stored=StoreColor, default=-16777211};
	__property Graphics::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, stored=NotUsingController, default=-16777201};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, stored=StoreFocusColor, default=-16777211};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, stored=NotUsingController, default=-16777200};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Graphics::TColor FrameHotColor = {read=FFrameHotColor, write=SetFrameHotColor, stored=NotUsingController, default=-16777200};
	__property Rzcommon::TFrameStyle FrameHotStyle = {read=FFrameHotStyle, write=SetFrameHotStyle, stored=NotUsingController, default=10};
	__property bool FrameHotTrack = {read=FFrameHotTrack, write=SetFrameHotTrack, stored=NotUsingController, default=0};
	__property Rzcommon::TSides FrameSides = {read=FFrameSides, write=SetFrameSides, stored=NotUsingController, default=15};
	__property Rzcommon::TFrameStyle FrameStyle = {read=FFrameStyle, write=SetFrameStyle, stored=NotUsingController, default=1};
	__property bool FrameVisible = {read=FFrameVisible, write=SetFrameVisible, stored=NotUsingController, default=0};
	__property Rzcommon::TFramingPreference FramingPreference = {read=FFramingPreference, write=SetFramingPreference, default=1};
	__property bool ShowLongNames = {read=FShowLongNames, write=SetShowLongNames, default=1};
	__property bool ShowGlyphs = {read=GetShowGlyphs, write=SetShowGlyphs, default=1};
	__property OnMouseWheel ;
	__property OnMouseWheelUp ;
	__property OnMouseWheelDown ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzFileListBox(HWND ParentWindow) : Filectrl::TFileListBox(ParentWindow) { }
	#pragma option pop
	
};


struct TFolderInfo;
typedef TFolderInfo *PFolderInfo;

struct TFolderInfo
{
	
public:
	AnsiString FullPath;
	bool ProcessedChildren;
} ;

class DELPHICLASS TRzDirectoryListBox;
class PASCALIMPLEMENTATION TRzDirectoryListBox : public Filectrl::TDirectoryListBox 
{
	typedef Filectrl::TDirectoryListBox inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	bool FUpdatingColor;
	Graphics::TColor FDisabledColor;
	Graphics::TColor FFocusColor;
	Graphics::TColor FNormalColor;
	Graphics::TColor FFrameColor;
	Rzcommon::TRzFrameController* FFrameController;
	Graphics::TColor FFrameHotColor;
	bool FFrameHotTrack;
	Rzcommon::TFrameStyleEx FFrameHotStyle;
	Rzcommon::TSides FFrameSides;
	Rzcommon::TFrameStyleEx FFrameStyle;
	bool FFrameVisible;
	Rzcommon::TFramingPreference FFramingPreference;
	bool FShowLongNames;
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameFocusStyleProp(Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	
protected:
	Graphics::TCanvas* FCanvas;
	bool FOverControl;
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall UpdateColors(void);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	virtual void __fastcall RepaintFrame(void);
	virtual void __fastcall BuildList(void);
	virtual void __fastcall Change(void);
	virtual void __fastcall ReadBitmaps(void);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	int __fastcall DirLevel(const AnsiString PathName);
	AnsiString __fastcall GetLongDirName();
	void __fastcall UpdateDirLabel(void);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	bool __fastcall StoreColor(void);
	bool __fastcall StoreFocusColor(void);
	bool __fastcall NotUsingController(void);
	virtual void __fastcall SetDisabledColor(Graphics::TColor Value);
	virtual void __fastcall SetFocusColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetFrameHotColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameHotTrack(bool Value);
	virtual void __fastcall SetFrameHotStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameSides(Rzcommon::TSides Value);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameVisible(bool Value);
	virtual void __fastcall SetFramingPreference(Rzcommon::TFramingPreference Value);
	void __fastcall SetShowLongNames(bool Value);
	
public:
	__fastcall virtual TRzDirectoryListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDirectoryListBox(void);
	virtual bool __fastcall UseThemes(void);
	__property AnsiString LongDirName = {read=GetLongDirName};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Color  = {stored=StoreColor, default=-16777211};
	__property Graphics::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, stored=NotUsingController, default=-16777201};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, stored=StoreFocusColor, default=-16777211};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, stored=NotUsingController, default=-16777200};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Graphics::TColor FrameHotColor = {read=FFrameHotColor, write=SetFrameHotColor, stored=NotUsingController, default=-16777200};
	__property Rzcommon::TFrameStyle FrameHotStyle = {read=FFrameHotStyle, write=SetFrameHotStyle, stored=NotUsingController, default=10};
	__property bool FrameHotTrack = {read=FFrameHotTrack, write=SetFrameHotTrack, stored=NotUsingController, default=0};
	__property Rzcommon::TSides FrameSides = {read=FFrameSides, write=SetFrameSides, stored=NotUsingController, default=15};
	__property Rzcommon::TFrameStyle FrameStyle = {read=FFrameStyle, write=SetFrameStyle, stored=NotUsingController, default=1};
	__property bool FrameVisible = {read=FFrameVisible, write=SetFrameVisible, stored=NotUsingController, default=0};
	__property Rzcommon::TFramingPreference FramingPreference = {read=FFramingPreference, write=SetFramingPreference, default=1};
	__property bool ShowLongNames = {read=FShowLongNames, write=SetShowLongNames, default=1};
	__property OnMouseWheel ;
	__property OnMouseWheelUp ;
	__property OnMouseWheelDown ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDirectoryListBox(HWND ParentWindow) : Filectrl::TDirectoryListBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzDriveComboBox;
class PASCALIMPLEMENTATION TRzDriveComboBox : public Filectrl::TDriveComboBox 
{
	typedef Filectrl::TDriveComboBox inherited;
	
private:
	Rzcommon::TRzAboutInfo FAboutInfo;
	TDriveTypes FDriveTypes;
	bool FFlatButtons;
	Graphics::TColor FFlatButtonColor;
	bool FUpdatingColor;
	Graphics::TColor FDisabledColor;
	Graphics::TColor FFocusColor;
	Graphics::TColor FNormalColor;
	Graphics::TColor FFrameColor;
	Rzcommon::TRzFrameController* FFrameController;
	Graphics::TColor FFrameHotColor;
	bool FFrameHotTrack;
	Rzcommon::TFrameStyleEx FFrameHotStyle;
	Rzcommon::TSides FFrameSides;
	Rzcommon::TFrameStyleEx FFrameStyle;
	bool FFrameVisible;
	Rzcommon::TFramingPreference FFramingPreference;
	void __fastcall ReadOldFrameFlatProp(Classes::TReader* Reader);
	void __fastcall ReadOldFrameFocusStyleProp(Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	
protected:
	Graphics::TCanvas* FCanvas;
	bool FInControl;
	bool FOverControl;
	bool FIsFocused;
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall UpdateColors(void);
	virtual void __fastcall UpdateFrame(bool ViaMouse, bool InFocus);
	void __fastcall ReadNewBitmaps(void);
	virtual void __fastcall BuildList(void);
	HIDESBASE void __fastcall ResetItemHeight(void);
	virtual void __fastcall SetFlatButtons(bool Value);
	virtual void __fastcall SetFlatButtonColor(Graphics::TColor Value);
	bool __fastcall StoreColor(void);
	bool __fastcall StoreFocusColor(void);
	bool __fastcall NotUsingController(void);
	virtual void __fastcall SetDisabledColor(Graphics::TColor Value);
	virtual void __fastcall SetFocusColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameController(Rzcommon::TRzFrameController* Value);
	virtual void __fastcall SetFrameHotColor(Graphics::TColor Value);
	virtual void __fastcall SetFrameHotTrack(bool Value);
	virtual void __fastcall SetFrameHotStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameSides(Rzcommon::TSides Value);
	virtual void __fastcall SetFrameStyle(Rzcommon::TFrameStyle Value);
	virtual void __fastcall SetFrameVisible(bool Value);
	virtual void __fastcall SetFramingPreference(Rzcommon::TFramingPreference Value);
	void __fastcall SetDriveTypes(TDriveTypes Value);
	
public:
	__fastcall virtual TRzDriveComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzDriveComboBox(void);
	virtual bool __fastcall UseThemes(void);
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property TDriveTypes DriveTypes = {read=FDriveTypes, write=SetDriveTypes, default=124};
	__property Color  = {stored=StoreColor, default=-16777211};
	__property Graphics::TColor FlatButtonColor = {read=FFlatButtonColor, write=SetFlatButtonColor, stored=NotUsingController, default=-16777201};
	__property bool FlatButtons = {read=FFlatButtons, write=SetFlatButtons, stored=NotUsingController, default=0};
	__property Graphics::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, stored=NotUsingController, default=-16777201};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, stored=StoreFocusColor, default=-16777211};
	__property Graphics::TColor FrameColor = {read=FFrameColor, write=SetFrameColor, stored=NotUsingController, default=-16777200};
	__property Rzcommon::TRzFrameController* FrameController = {read=FFrameController, write=SetFrameController};
	__property Graphics::TColor FrameHotColor = {read=FFrameHotColor, write=SetFrameHotColor, stored=NotUsingController, default=-16777200};
	__property Rzcommon::TFrameStyle FrameHotStyle = {read=FFrameHotStyle, write=SetFrameHotStyle, stored=NotUsingController, default=10};
	__property bool FrameHotTrack = {read=FFrameHotTrack, write=SetFrameHotTrack, stored=NotUsingController, default=0};
	__property Rzcommon::TSides FrameSides = {read=FFrameSides, write=SetFrameSides, stored=NotUsingController, default=15};
	__property Rzcommon::TFrameStyle FrameStyle = {read=FFrameStyle, write=SetFrameStyle, stored=NotUsingController, default=1};
	__property bool FrameVisible = {read=FFrameVisible, write=SetFrameVisible, stored=NotUsingController, default=0};
	__property Rzcommon::TFramingPreference FramingPreference = {read=FFramingPreference, write=SetFramingPreference, default=1};
	__property Align  = {default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzDriveComboBox(HWND ParentWindow) : Filectrl::TDriveComboBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString __fastcall VolumeID(char Drive);
extern PACKAGE AnsiString __fastcall NetworkVolume(char Drive);
extern PACKAGE void __fastcall GetDriveInfo(char Drive, AnsiString &Volume, unsigned &SerialNum);
extern PACKAGE void __fastcall GetVolumeInfo(char Drive, TNetworkVolumeFormat VolumeFormat, AnsiString &Volume, unsigned &SerialNum);
extern PACKAGE unsigned __fastcall GetDriveSerialNum(char Drive);
extern PACKAGE AnsiString __fastcall UNCPathToDriveMapping(AnsiString UNCPath);
extern PACKAGE AnsiString __fastcall GetCurrentRootDir();

}	/* namespace Rzfilsys */
using namespace Rzfilsys;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzfilsys
