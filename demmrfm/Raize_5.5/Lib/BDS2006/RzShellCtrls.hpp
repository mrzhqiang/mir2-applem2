// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Rzshellctrls.pas' rev: 10.00

#ifndef RzshellctrlsHPP
#define RzshellctrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Shlobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Rzshellintf.hpp>	// Pascal unit
#include <Rztreevw.hpp>	// Pascal unit
#include <Rzlistvw.hpp>	// Pascal unit
#include <Rzshellutils.hpp>	// Pascal unit
#include <Rzcmbobx.hpp>	// Pascal unit
#include <Rzcommon.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rzshellctrls
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TRzShellTreeOption { stoAutoFill, stoVirtualFolders, stoDesignInteractive, stoDefaultKeyHandling, stoContextMenus, stoDynamicRefresh, stoIncludeNonFolders, stoOleDrag, stoOleDrop, stoShowHidden };
#pragma option pop

typedef Set<TRzShellTreeOption, stoAutoFill, stoShowHidden>  TRzShellTreeOptions;

#pragma option push -b-
enum TRzShellListOption { sloAutoFill, sloNonFilesystemAncestors, sloDesignInteractive, sloDefaultKeyHandling, sloContextMenus, sloDontChangeFolder, sloDontGoBelowBase, sloDynamicRefresh, sloHideFoldersWhenLinkedToTree, sloOleDrag, sloOleDrop, sloFolderContextMenu, sloShowHidden, sloFilesCanBeFolders };
#pragma option pop

typedef Set<TRzShellListOption, sloAutoFill, sloFilesCanBeFolders>  TRzShellListOptions;

#pragma option push -b-
enum TRzShellComboOption { scoAutofill, scoNonFilesystemAncestors };
#pragma option pop

typedef Set<TRzShellComboOption, scoAutofill, scoNonFilesystemAncestors>  TRzShellComboOptions;

typedef void __fastcall (__closure *TRzShAddItemEvent)(System::TObject* Sender, Rzshellintf::IShellFolder_NRC* ParentIShf, Shlobj::PItemIDList ParentAbsIdList, Shlobj::PItemIDList ItemRelIdList, int Attribs, BOOL &AllowAdd);

typedef void __fastcall (__closure *TRzShTreeInsertItemEvent)(System::TObject* Sender, Comctrls::TTreeNode* Node);

class DELPHICLASS TRzShellTreeData;
typedef void __fastcall (__closure *TRzShTreeDeleteItemEvent)(System::TObject* Sender, Comctrls::TTreeNode* Node, TRzShellTreeData* TreeData);

class DELPHICLASS TRzShellListData;
typedef void __fastcall (__closure *TRzShListDeleteItemEvent)(System::TObject* Sender, Comctrls::TListItem* Node, TRzShellListData* ListData);

class DELPHICLASS TRzShellComboData;
typedef void __fastcall (__closure *TRzShComboDeleteItemEvent)(System::TObject* Sender, int Item, TRzShellComboData* ComboData);

typedef void __fastcall (__closure *TRzShDblClickOpenEvent)(System::TObject* Sender, bool &Handled);

typedef void __fastcall (__closure *TRzShPopupHintEvent)(System::TObject* Sender, const AnsiString Hint);

#pragma option push -b-
enum TRzShellLocator_Which { usePidl, useCSIDL };
#pragma option pop

class DELPHICLASS TRzShellLocator;
class PASCALIMPLEMENTATION TRzShellLocator : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
protected:
	TRzShellLocator_Which FWhich;
	_ITEMIDLIST *FIdList;
	Rzshellutils::TCSIDL FCSIDL;
	Classes::TNotifyEvent FOnChange;
	DYNAMIC void __fastcall Changed(void);
	AnsiString __fastcall GetPathName();
	Shlobj::PItemIDList __fastcall GetIdList(void);
	Rzshellutils::TCSIDL __fastcall GetCSIDL(void);
	void __fastcall SetIdList(Shlobj::PItemIDList Value);
	void __fastcall SetPathName(const AnsiString Value);
	void __fastcall SetCSIDL(Rzshellutils::TCSIDL Value);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	
public:
	__fastcall virtual ~TRzShellLocator(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	bool __fastcall IsEqual(TRzShellLocator* Value);
	void __fastcall Clear(void);
	void __fastcall ReadData(Classes::TStream* Stream);
	void __fastcall WriteData(Classes::TStream* Stream);
	__property Shlobj::PItemIDList IdList = {read=GetIdList, write=SetIdList};
	__property AnsiString PathName = {read=GetPathName, write=SetPathName};
	__property Rzshellutils::TCSIDL CSIDL = {read=GetCSIDL, write=SetCSIDL, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TRzShellLocator(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TRzCustomShellTree;
class DELPHICLASS TRzCustomShellList;
#pragma option push -b-
enum TRzCustomShellList_LCS { lcsNone, lcsShellDetails, lcsDefault };
#pragma option pop

class DELPHICLASS TRzCustomShellCombo;
class PASCALIMPLEMENTATION TRzCustomShellCombo : public Rzcmbobx::TRzCustomImageComboBox 
{
	typedef Rzcmbobx::TRzCustomImageComboBox inherited;
	
private:
	int FIgnoreChanges;
	TRzCustomShellTree* FShellTree;
	TRzCustomShellList* FShellList;
	TRzShellLocator* FSelectedFolder;
	TRzShellComboOptions FOptions;
	bool FAutoDropDownCount;
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	TRzShellLocator* __fastcall GetSelectedFolder(void);
	TRzShellComboData* __fastcall GetShellComboData(int Index);
	void __fastcall SetSelectedFolder(TRzShellLocator* Value);
	void __fastcall SetShellList(TRzCustomShellList* Value);
	void __fastcall SetShellTree(TRzCustomShellTree* Value);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	
protected:
	virtual bool __fastcall CanAdd(Rzshellintf::IShellFolder_NRC* ParentIShf, Shlobj::PItemIDList ParentAbsPidl, Shlobj::PItemIDList ItemRelPidl, unsigned attribs, int Level);
	DYNAMIC void __fastcall SelEndOk(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DeleteItem(void * Item);
	DYNAMIC void __fastcall DropDown(void);
	virtual void __fastcall GetItemData(Rzcmbobx::TRzImageComboBoxItem* Item);
	virtual void __fastcall SelectedFolderChanged(System::TObject* Sender);
	virtual void __fastcall TreeChanged(Comctrls::TTreeNode* Node);
	virtual void __fastcall FillCombo(Rzshellintf::IShellFolder_NRC* aIShf, Shlobj::PItemIDList aBasePidl, int aIndent, Rzshellutils::TRzIdListArray* aSelectedItem);
	__property bool AutoDropDownCount = {read=FAutoDropDownCount, write=FAutoDropDownCount, default=1};
	__property TRzCustomShellTree* ShellTree = {read=FShellTree, write=SetShellTree};
	__property TRzCustomShellList* ShellList = {read=FShellList, write=SetShellList};
	__property ItemIndent  = {default=12};
	__property TRzShellComboOptions Options = {read=FOptions, write=FOptions, default=3};
	__property TRzShellLocator* SelectedFolder = {read=GetSelectedFolder, write=SetSelectedFolder};
	__property TRzShellComboData* ShellComboData[int Index] = {read=GetShellComboData};
	__property Items  = {stored=false};
	
public:
	__fastcall virtual TRzCustomShellCombo(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomShellCombo(void);
	void __fastcall FillItems(void);
	void __fastcall GoUp(int Levels);
	void __fastcall Synchronize(bool ApplyToGroup);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomShellCombo(HWND ParentWindow) : Rzcmbobx::TRzCustomImageComboBox(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzCustomShellList : public Rzlistvw::TRzCustomListView 
{
	typedef Rzlistvw::TRzCustomListView inherited;
	
private:
	TRzCustomShellList_LCS FLastColState;
	bool FLastFolderWasDir;
	TRzShPopupHintEvent FOnPopupHint;
	Rzshellintf::IShellFolder_NRC* FIShf;
	_ITEMIDLIST *FIShfPidl;
	bool FIShellDetailsValid;
	Rzshellintf::IShellDetails_NRC* FIShellDetails;
	TRzShellLocator* FFolder;
	TRzShellListOptions FOptions;
	TRzShAddItemEvent FOnAddItem;
	TRzShListDeleteItemEvent FOnDeleteItem;
	TRzShDblClickOpenEvent FOnDblClickOpen;
	Classes::TNotifyEvent FOnFillComplete;
	Classes::TNotifyEvent FOnFillStart;
	Classes::TNotifyEvent FOnFolderChanged;
	AnsiString FFileFilter;
	void *FFilterLookupTable;
	Classes::TStringList* FFilterExtensions;
	Extctrls::TTimer* FTimer;
	TRzCustomShellTree* FShellTree;
	TRzCustomShellCombo* FShellCombo;
	Rzshellintf::IContextMenu_NRC* FActiveContextMenu;
	int FSortColumn;
	int FIgnoreChanges;
	bool FIgnoreNextChangeNotify;
	void *FChangeHandlerThread;
	AnsiString FDeferredEditName;
	bool FSkipRButtonUp;
	bool FDeferRefresh;
	bool FRefreshDeferred;
	TRzShellListData* FCurrentItemData;
	unsigned FCurrentItemFlags;
	Rzshellintf::IShellDetails_NRC* FCurrentItemIShd;
	int FLastAutoScrollTick;
	bool FLoaded;
	bool FInCreateWnd;
	bool FSortColumnAssigned;
	bool FDeletingItems;
	
protected:
	Rzshellintf::IDataObject_NRC* FIDataObject;
	void __fastcall OleBeginDrag(Controls::TMouseButton Button);
	Rzshellintf::IDropTarget_NRC* FIDropTarget;
	Rzshellintf::IDataObject_NRC* FILastDropDataObject;
	int FInitialDropKeyState;
	virtual Rzshellintf::IDropSource_NRC* __fastcall CreateIDropSource(Controls::TMouseButton Button, Rzshellintf::IDataObject_NRC* DataObject);
	virtual HRESULT __fastcall OnDropTarget_DragEnter(const Rzshellintf::IDataObject_NRC* dataObj, int grfKeyState, const Types::TPoint &pt, int &dwEffect);
	virtual HRESULT __fastcall OnDropTarget_DragOver(int grfKeyState, const Types::TPoint &pt, int &dwEffect);
	virtual HRESULT __fastcall OnDropTarget_DragLeave(void);
	virtual HRESULT __fastcall OnDropTarget_Drop(const Rzshellintf::IDataObject_NRC* dataObj, int grfKeyState, const Types::TPoint &pt, int &dwEffect);
	
private:
	void __fastcall InitColumns(Rzshellintf::IShellDetails_NRC* ishd);
	void __fastcall InitImageLists(void);
	bool __fastcall IsFolderStored(void);
	Rzshellintf::IShellDetails_NRC* __fastcall GetCurrentFolderIShellDetails(void);
	void __fastcall HandleOnFolderChanged(System::TObject* Sender);
	TRzShellListData* __fastcall GetSelectedItem(void);
	TRzShellListData* __fastcall GetShellListData(int Index);
	void __fastcall SetFileFilter(const AnsiString Value);
	void __fastcall SetFolder(TRzShellLocator* Value);
	void __fastcall SetShellTree(TRzCustomShellTree* Value);
	void __fastcall SetShellCombo(TRzCustomShellCombo* Value);
	void __fastcall SetSortColumn(int Value);
	void __fastcall SetOptions(TRzShellListOptions Value);
	void __fastcall TimerElapsed(System::TObject* Sender);
	MESSAGE void __fastcall AMChangeNotify(Messages::TMessage &Msg);
	MESSAGE void __fastcall AMDeferredEdit(Messages::TMessage &Msg);
	MESSAGE void __fastcall AMDeferredFill(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Msg);
	MESSAGE void __fastcall WMMenuChar(Messages::TWMMenuChar &Msg);
	HIDESBASE MESSAGE void __fastcall WMDrawItem(Messages::TWMDrawItem &Msg);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCDestroy(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMMeasureItem(Messages::TWMMeasureItem &Msg);
	MESSAGE void __fastcall WMMenuSelect(Messages::TWMMenuSelect &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMInitMenuPopup(Messages::TWMInitMenuPopup &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Msg);
	MESSAGE void __fastcall WMGetIShellBrowser(Messages::TMessage &Msg);
	
protected:
	bool __fastcall ShouldInclude(Shlobj::PItemIDList baseidlist, Shlobj::PItemIDList relidlist, unsigned &attrib);
	HRESULT __fastcall AddNewShellItem(Shlobj::PItemIDList AbsIdList, Shlobj::PItemIDList RelIdList);
	virtual BOOL __fastcall CanAdd(Rzshellintf::IShellFolder_NRC* parentIShf, Shlobj::PItemIDList parentAbsPidl, Shlobj::PItemIDList itemRelPidl, unsigned itemAttributes);
	DYNAMIC bool __fastcall CanEdit(Comctrls::TListItem* Item);
	DYNAMIC bool __fastcall DblClickOpen(void);
	virtual void __fastcall DeviceChangeDetected(System::TObject* Sender, Messages::TMessage &Msg);
	DYNAMIC void __fastcall Edit(const tagLVITEMA &Item);
	virtual void __fastcall FillList(Rzshellintf::IShellFolder_NRC* ishf, Shlobj::PItemIDList basepidl);
	DYNAMIC void __fastcall FillComplete(void);
	DYNAMIC void __fastcall FillStart(void);
	DYNAMIC void __fastcall FolderChanged(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* Component, Classes::TOperation Operation);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	void __fastcall TreeChanged(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Delete(Comctrls::TListItem* Item);
	DYNAMIC void __fastcall ColClick(Comctrls::TListColumn* Column);
	DYNAMIC HRESULT __fastcall GetUIObjectForAllSelected(const GUID &riid, void * &interfaceOut);
	DYNAMIC HRESULT __fastcall GetUIObjectForItem(Comctrls::TListItem* Item, const GUID &riid, void * &interfaceOut);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState ShiftState);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int x, int y);
	DYNAMIC void __fastcall ItemContextMenu(Comctrls::TListItem* Item, Types::TPoint &P, Menus::TPopupMenu* &Menu);
	bool __fastcall ItemHasData(Comctrls::TListItem* Item);
	DYNAMIC void __fastcall InsertItem(Comctrls::TListItem* Item);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC void __fastcall InstallChangeHandler(void);
	virtual void __fastcall FilterPreApply(void);
	virtual bool __fastcall FilterApply(const AnsiString FileName, unsigned Attrib);
	virtual void __fastcall FilterPostApply(void);
	bool __fastcall IsFolderNetworkShare(void);
	__property Columns  = {stored=false};
	__property Items  = {stored=false};
	__property AllocBy  = {stored=false, default=0};
	__property TRzShellListData* SelectedItem = {read=GetSelectedItem};
	__property TRzShellListData* ShellListData[int Index] = {read=GetShellListData};
	__property int SortColumn = {read=FSortColumn, write=SetSortColumn, nodefault};
	__property Rzshellintf::IShellFolder_NRC* _IShellFolder = {read=FIShf};
	__property TRzShellListOptions Options = {read=FOptions, write=SetOptions, default=16027};
	__property TRzShellLocator* Folder = {read=FFolder, write=SetFolder, stored=IsFolderStored};
	__property AnsiString FileFilter = {read=FFileFilter, write=SetFileFilter};
	__property TRzShAddItemEvent OnAddItem = {read=FOnAddItem, write=FOnAddItem};
	__property TRzShListDeleteItemEvent OnDeleteItem = {read=FOnDeleteItem, write=FOnDeleteItem};
	__property TRzShPopupHintEvent OnPopupHint = {read=FOnPopupHint, write=FOnPopupHint};
	__property TRzShDblClickOpenEvent OnDblClickOpen = {read=FOnDblClickOpen, write=FOnDblClickOpen};
	__property Classes::TNotifyEvent OnFillComplete = {read=FOnFillComplete, write=FOnFillComplete};
	__property Classes::TNotifyEvent OnFillStart = {read=FOnFillStart, write=FOnFillStart};
	__property Classes::TNotifyEvent OnFolderChanged = {read=FOnFolderChanged, write=FOnFolderChanged};
	
public:
	__fastcall virtual TRzCustomShellList(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomShellList(void);
	bool __fastcall CreateNewFolder(bool EditNow);
	void __fastcall DoCommandForItem(Comctrls::TListItem* Item, char * Cmd);
	void __fastcall DoCommandForAllSelected(char * Cmd);
	void __fastcall DoCommandForFolder(char * Cmd);
	void __fastcall FillItems(void);
	void __fastcall GoUp(int Levels);
	TRzShellListData* __fastcall GetDataFromItem(Comctrls::TListItem* Item);
	void __fastcall OpenItem(Comctrls::TListItem* Item);
	void __fastcall OpenSelectedItems(void);
	void __fastcall ProcessMenu(Comctrls::TListItem* Item, const Types::TPoint &Pt);
	void __fastcall ProcessMenuForAllSelected(const Types::TPoint &Pt);
	void __fastcall ProcessSendTo(int Index);
	void __fastcall RefreshItems(void);
	unsigned __fastcall GetDragDropAttributesForAllSelected(void);
	unsigned __fastcall GetDragDropAttributesForItem(Comctrls::TListItem* Item);
	virtual void __fastcall SelectAll(void);
	int __fastcall ShellSelCount(void);
	void __fastcall SortList(void);
	void __fastcall Synchronize(bool ApplyToGroup);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomShellList(HWND ParentWindow) : Rzlistvw::TRzCustomListView(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzCustomShellTree : public Rztreevw::TRzCustomTreeView 
{
	typedef Rztreevw::TRzCustomTreeView inherited;
	
private:
	TRzShellLocator* FBaseFolder;
	TRzShellLocator* FSelectedFolder;
	Extctrls::TTimer* FTimer;
	TRzCustomShellList* FShellList;
	TRzShellTreeOptions FOptions;
	TRzShAddItemEvent FOnAddItem;
	TRzShTreeDeleteItemEvent FOnDeleteItem;
	TRzShTreeInsertItemEvent FOnInsertItem;
	TRzShPopupHintEvent FOnPopupHint;
	Classes::TNotifyEvent FOnFillComplete;
	Classes::TNotifyEvent FOnFillStart;
	TRzCustomShellCombo* FShellCombo;
	Rzshellintf::IContextMenu_NRC* FActiveContextMenu;
	bool FQuickSelect;
	int FIgnoreChanges;
	int FIgnoreErrors;
	bool FEatExpand;
	bool FIgnoreNextChangeNotify;
	void *FChangeHandlerThread;
	bool FDeferRefresh;
	bool FRefreshDeferred;
	Comctrls::TTreeNode* FLastNode;
	bool FLoaded;
	bool FDeletingNodes;
	bool FSettingParent;
	
protected:
	Comctrls::TTreeNode* FDragNode;
	Rzshellintf::IDataObject_NRC* FIDataObject;
	Rzshellintf::IDropTarget_NRC* FIDropTarget;
	Rzshellintf::IDataObject_NRC* FILastDropDataObject;
	int FInitialDropKeyState;
	int FLastAutoScrollTick;
	#pragma pack(push,1)
	Types::TPoint FLastAutoOpenPos;
	#pragma pack(pop)
	int FLastAutoOpenTick;
	void __fastcall OleBeginDrag(Controls::TMouseButton Button);
	virtual Rzshellintf::IDropSource_NRC* __fastcall CreateIDropSource(Controls::TMouseButton Button, Rzshellintf::IDataObject_NRC* DataObject);
	virtual HRESULT __fastcall OnDropTarget_DragEnter(const Rzshellintf::IDataObject_NRC* dataObj, int grfKeyState, const Types::TPoint &pt, int &dwEffect);
	virtual HRESULT __fastcall OnDropTarget_DragOver(int grfKeyState, const Types::TPoint &pt, int &dwEffect);
	virtual HRESULT __fastcall OnDropTarget_DragLeave(void);
	virtual HRESULT __fastcall OnDropTarget_Drop(const Rzshellintf::IDataObject_NRC* dataObj, int grfKeyState, const Types::TPoint &pt, int &dwEffect);
	virtual void __fastcall DoDropTargetAutoscroll(const Types::TPoint &pt);
	
private:
	void __fastcall InitImageList(void);
	void __fastcall BaseFolderChanged(System::TObject* Sender);
	void __fastcall SelectedFolderChanged(System::TObject* Sender);
	void __fastcall TimerElapsed(System::TObject* Sender);
	TRzShellTreeData* __fastcall GetSelectedItem(void);
	AnsiString __fastcall GetSelectedPathName();
	TRzShellTreeData* __fastcall GetShellTreeData(int idx);
	HWND __fastcall GetParentHWND(void);
	void __fastcall SetBaseFolder(TRzShellLocator* Value);
	void __fastcall SetShellList(TRzCustomShellList* Value);
	void __fastcall SetOptions(TRzShellTreeOptions Value);
	void __fastcall SetSelectedFolder(TRzShellLocator* Value);
	void __fastcall DoSetSelectedIdList(Shlobj::PItemIDList Value);
	void __fastcall SetShellCombo(TRzCustomShellCombo* Value);
	MESSAGE void __fastcall AMChangeNotify(Messages::TMessage &Msg);
	MESSAGE void __fastcall AMDeferredFill(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Msg);
	MESSAGE void __fastcall TVMDeleteItem(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMMenuChar(Messages::TWMMenuChar &Msg);
	HIDESBASE MESSAGE void __fastcall WMDrawItem(Messages::TWMDrawItem &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCDestroy(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMMeasureItem(Messages::TWMMeasureItem &Msg);
	MESSAGE void __fastcall WMMenuSelect(Messages::TWMMenuSelect &Msg);
	MESSAGE void __fastcall WMInitMenuPopup(Messages::TWMInitMenuPopup &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	
protected:
	void __fastcall SetSelectedPathName(const AnsiString Value);
	virtual HRESULT __fastcall AddNewShellNode(Rzshellintf::IShellFolder_NRC* Parent, Shlobj::PItemIDList ParentAbsIdList, Comctrls::TTreeNode* ParentNode, Shlobj::PItemIDList RelIdList);
	virtual BOOL __fastcall CanAdd(Rzshellintf::IShellFolder_NRC* ParentIShf, Shlobj::PItemIDList ParentAbsPidl, Shlobj::PItemIDList ItemRelPidl, unsigned Attribs);
	DYNAMIC bool __fastcall CanExpand(Comctrls::TTreeNode* Node);
	DYNAMIC bool __fastcall CanEdit(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Change(Comctrls::TTreeNode* Node);
	virtual void __fastcall DeviceChangeDetected(System::TObject* Sender, Messages::TMessage &Msg);
	DYNAMIC void __fastcall DoOnInsertItem(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall NodeContextMenu(Comctrls::TTreeNode* Node, Types::TPoint &P, Menus::TPopupMenu* &Menu);
	bool __fastcall NodeHasData(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Delete(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall ExpandNode(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall Edit(const tagTVITEMA &Item);
	virtual void __fastcall FillTree(Rzshellintf::IShellFolder_NRC* ishf, Comctrls::TTreeNode* ABaseNode);
	DYNAMIC void __fastcall FillComplete(void);
	DYNAMIC void __fastcall FillStart(void);
	Comctrls::TTreeNode* __fastcall GetFirstRootLevelShellNode(void);
	virtual void __fastcall GetImageIndex(Comctrls::TTreeNode* Node);
	virtual void __fastcall GetSelectedIndex(Comctrls::TTreeNode* Node);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* Component, Classes::TOperation Operation);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState ShiftState);
	DYNAMIC void __fastcall ProcessSendTo(Comctrls::TTreeNode* Node, int Index);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC void __fastcall InstallChangeHandler(const AnsiString PathName);
	void __fastcall InstallChangeHandlersForAllLocalDrives(void);
	__property TRzShellTreeData* SelectedItem = {read=GetSelectedItem};
	__property TRzShellLocator* SelectedFolder = {read=FSelectedFolder, write=SetSelectedFolder};
	__property AnsiString SelectedPathName = {read=GetSelectedPathName, write=SetSelectedPathName};
	__property TRzShellTreeData* ShellTreeData[int Index] = {read=GetShellTreeData};
	__property Items  = {stored=false};
	__property TRzShellLocator* BaseFolder = {read=FBaseFolder, write=SetBaseFolder};
	__property TRzCustomShellList* ShellList = {read=FShellList, write=SetShellList};
	__property TRzShellTreeOptions Options = {read=FOptions, write=SetOptions, default=955};
	__property TRzShAddItemEvent OnAddItem = {read=FOnAddItem, write=FOnAddItem};
	__property TRzShTreeDeleteItemEvent OnDeleteItem = {read=FOnDeleteItem, write=FOnDeleteItem};
	__property TRzShTreeInsertItemEvent OnInsertItem = {read=FOnInsertItem, write=FOnInsertItem};
	__property TRzShPopupHintEvent OnPopupHint = {read=FOnPopupHint, write=FOnPopupHint};
	__property Classes::TNotifyEvent OnFillComplete = {read=FOnFillComplete, write=FOnFillComplete};
	__property Classes::TNotifyEvent OnFillStart = {read=FOnFillStart, write=FOnFillStart};
	
public:
	__fastcall virtual TRzCustomShellTree(Classes::TComponent* AOwner);
	__fastcall virtual ~TRzCustomShellTree(void);
	void __fastcall FillItems(void);
	void __fastcall RefreshNodes(void);
	TRzShellTreeData* __fastcall GetDataFromNode(Comctrls::TTreeNode* Node);
	void __fastcall GoUp(int Levels);
	bool __fastcall CreateNewFolder(bool EditNow);
	HRESULT __fastcall DoCommandForNode(Comctrls::TTreeNode* Node, char * Cmd);
	Comctrls::TTreeNode* __fastcall FindNodeWithIdList(Comctrls::TTreeNode* BaseNode, Shlobj::PItemIDList pidl);
	DYNAMIC void __fastcall ProcessMenu(Comctrls::TTreeNode* Node, const Types::TPoint &P);
	void __fastcall SortNode(Comctrls::TTreeNode* Node);
	void __fastcall Synchronize(bool afApplyToGroup);
	unsigned __fastcall GetDragDropAttributesForNode(Comctrls::TTreeNode* Node);
	__property Height  = {default=150};
	__property Width  = {default=150};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzCustomShellTree(HWND ParentWindow) : Rztreevw::TRzCustomTreeView(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzShellTree;
class PASCALIMPLEMENTATION TRzShellTree : public TRzCustomShellTree 
{
	typedef TRzCustomShellTree inherited;
	
public:
	__property SelectedItem ;
	__property SelectedFolder ;
	__property SelectedPathName ;
	__property ShellTreeData ;
	__property Items ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property AutoExpand  = {default=0};
	__property BaseFolder ;
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
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property FrameHotColor  = {default=-16777200};
	__property FrameHotTrack  = {default=0};
	__property FrameHotStyle  = {default=10};
	__property FrameSides  = {default=15};
	__property FrameStyle  = {default=1};
	__property FrameVisible  = {default=0};
	__property FramingPreference  = {default=1};
	__property HideSelection  = {default=1};
	__property HotTrack  = {default=0};
	__property Indent ;
	__property ItemHeight  = {default=0};
	__property MultiSelect  = {default=0};
	__property MultiSelectStyle  = {default=1};
	__property Options  = {default=955};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property RightClickSelect  = {default=0};
	__property RowSelect  = {default=0};
	__property ShellList ;
	__property ShowButtons  = {default=1};
	__property ShowHint ;
	__property ShowLines  = {default=1};
	__property ShowRoot  = {default=0};
	__property StateImages ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property ToolTips  = {default=1};
	__property Visible  = {default=1};
	__property OnAddItem ;
	__property OnAdvancedCustomDraw ;
	__property OnAdvancedCustomDrawItem ;
	__property OnCancelEdit ;
	__property OnChange ;
	__property OnChanging ;
	__property OnClick ;
	__property OnCollapsed ;
	__property OnCollapsing ;
	__property OnContextPopup ;
	__property OnCustomDraw ;
	__property OnCustomDrawItem ;
	__property OnDblClick ;
	__property OnDeleteItem ;
	__property OnDeletion ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEdited ;
	__property OnEditing ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnExpanded ;
	__property OnExpanding ;
	__property OnFillComplete ;
	__property OnFillStart ;
	__property OnGetImageIndex ;
	__property OnGetSelectedIndex ;
	__property OnInsertItem ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseWheel ;
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnNodeContextMenu ;
	__property OnPopupHint ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TRzCustomShellTree.Create */ inline __fastcall virtual TRzShellTree(Classes::TComponent* AOwner) : TRzCustomShellTree(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomShellTree.Destroy */ inline __fastcall virtual ~TRzShellTree(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzShellTree(HWND ParentWindow) : TRzCustomShellTree(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzShellList;
class PASCALIMPLEMENTATION TRzShellList : public TRzCustomShellList 
{
	typedef TRzCustomShellList inherited;
	
public:
	__property SelectedItem ;
	__property ShellListData ;
	__property SortColumn ;
	__property Columns ;
	__property Items ;
	__property _IShellFolder ;
	__property HeaderCanvas ;
	__property HeaderHandle ;
	__property HeaderSortColumn  = {default=-1};
	__property HeaderSortDirection  = {default=0};
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property BorderStyle  = {default=1};
	__property BorderWidth  = {default=0};
	__property Checkboxes  = {default=0};
	__property Color  = {default=-16777211};
	__property ColumnClick  = {default=1};
	__property Constraints ;
	__property Ctl3D ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FileFilter ;
	__property FlatScrollBars  = {default=0};
	__property Folder ;
	__property Font ;
	__property FocusColor  = {default=-16777211};
	__property FrameColor  = {default=-16777200};
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property FrameHotColor  = {default=-16777200};
	__property FrameHotTrack  = {default=0};
	__property FrameHotStyle  = {default=10};
	__property FrameSides  = {default=15};
	__property FrameStyle  = {default=1};
	__property FrameVisible  = {default=0};
	__property FramingPreference  = {default=1};
	__property FullDrag  = {default=0};
	__property GridLines  = {default=0};
	__property HeaderSortDisplayMode  = {default=2};
	__property HideSelection  = {default=1};
	__property HotTrack  = {default=0};
	__property HotTrackStyles  = {default=0};
	__property IconOptions ;
	__property MultiSelect  = {default=0};
	__property Options  = {default=16027};
	__property OwnerData  = {default=0};
	__property OwnerDraw  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property RowSelect  = {default=0};
	__property ShowColumnHeaders  = {default=1};
	__property ShowHint ;
	__property StateImages ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property ViewStyle  = {default=0};
	__property Visible  = {default=1};
	__property OnAddItem ;
	__property OnAdvancedCustomDraw ;
	__property OnAdvancedCustomDrawItem ;
	__property OnAdvancedCustomDrawSubItem ;
	__property OnChange ;
	__property OnChanging ;
	__property OnClick ;
	__property OnColumnClick ;
	__property OnCompare ;
	__property OnContextPopup ;
	__property OnCustomDraw ;
	__property OnCustomDrawItem ;
	__property OnData ;
	__property OnDataFind ;
	__property OnDataHint ;
	__property OnDataStateChange ;
	__property OnDblClick ;
	__property OnDblClickOpen ;
	__property OnDeleteItem ;
	__property OnDeletion ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawItem ;
	__property OnEdited ;
	__property OnEditing ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnFillComplete ;
	__property OnFillStart ;
	__property OnFolderChanged ;
	__property OnGetImageIndex ;
	__property OnInfoTip ;
	__property OnInsert ;
	__property OnItemContextMenu ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseActivate ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseWheel ;
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnPopupHint ;
	__property OnResize ;
	__property OnSelectItem ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TRzCustomShellList.Create */ inline __fastcall virtual TRzShellList(Classes::TComponent* AOwner) : TRzCustomShellList(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomShellList.Destroy */ inline __fastcall virtual ~TRzShellList(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzShellList(HWND ParentWindow) : TRzCustomShellList(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TRzShellCombo;
class PASCALIMPLEMENTATION TRzShellCombo : public TRzCustomShellCombo 
{
	typedef TRzCustomShellCombo inherited;
	
public:
	__property SelectedFolder ;
	__property ShellComboData ;
	
__published:
	__property Rzcommon::TRzAboutInfo About = {read=FAboutInfo, write=FAboutInfo, stored=false, nodefault};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property AutoDropDownCount  = {default=1};
	__property BiDiMode ;
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property Ctl3D ;
	__property DisabledColor  = {default=-16777201};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property DropDownCount  = {default=8};
	__property DropDownWidth  = {default=0};
	__property Enabled  = {default=1};
	__property FlatButtons  = {default=0};
	__property Font ;
	__property FocusColor  = {default=-16777211};
	__property FrameColor  = {default=-16777200};
	__property FrameControllerNotifications  = {default=65535};
	__property FrameController ;
	__property FrameHotColor  = {default=-16777200};
	__property FrameHotTrack  = {default=0};
	__property FrameHotStyle  = {default=10};
	__property FrameSides  = {default=15};
	__property FrameStyle  = {default=1};
	__property FrameVisible  = {default=0};
	__property FramingPreference  = {default=1};
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property ItemIndent  = {default=12};
	__property Options  = {default=3};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShellList ;
	__property ShellTree ;
	__property ShowHint ;
	__property Sorted  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property OnChange ;
	__property OnClick ;
	__property OnCloseUp ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDeleteItem ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawItem ;
	__property OnDropDown ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMeasureItem ;
	__property OnSelEndCancel ;
	__property OnSelEndOk ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TRzCustomShellCombo.Create */ inline __fastcall virtual TRzShellCombo(Classes::TComponent* AOwner) : TRzCustomShellCombo(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TRzCustomShellCombo.Destroy */ inline __fastcall virtual ~TRzShellCombo(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TRzShellCombo(HWND ParentWindow) : TRzCustomShellCombo(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TRzShellTreeData : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TRzCustomShellTree* FOwner;
	TRzShellTreeData* FParent;
	_ITEMIDLIST *FRelPidl;
	_ITEMIDLIST *FAbsPidl;
	Rzshellintf::IShellFolder_NRC* FThisIshf;
	Rzshellintf::IShellFolder_NRC* FParentIShf;
	void *FData;
	Shlobj::PItemIDList __fastcall GetAbsPidl(void);
	unsigned __fastcall GetAttributes(void);
	bool __fastcall GetEditable(void);
	AnsiString __fastcall GetPathName();
	Rzshellintf::IShellFolder_NRC* __fastcall GetParentIShf(void);
	Rzshellintf::IShellFolder_NRC* __fastcall GetThisIShf(void);
	void __fastcall SetData(TRzShellTreeData* AParent, Shlobj::PItemIDList thisRelativePidl);
	void __fastcall SetRelPidl(Shlobj::PItemIDList newRelPidl);
	
public:
	__fastcall TRzShellTreeData(TRzCustomShellTree* AOwner);
	__fastcall virtual ~TRzShellTreeData(void);
	HRESULT __fastcall GetIDropTarget(HWND h, Rzshellintf::IDropTarget_NRC* &idt);
	bool __fastcall IsRootDir(void);
	void __fastcall Flush(void);
	__property unsigned Attributes = {read=GetAttributes, nodefault};
	__property TRzShellTreeData* Parent = {read=FParent};
	__property Rzshellintf::IShellFolder_NRC* ParentIShf = {read=GetParentIShf};
	__property Shlobj::PItemIDList AbsoluteIdList = {read=GetAbsPidl};
	__property Shlobj::PItemIDList RelativeIdList = {read=FRelPidl};
	__property Rzshellintf::IShellFolder_NRC* ThisIShf = {read=GetThisIShf};
	__property AnsiString PathName = {read=GetPathName};
	__property bool Editable = {read=GetEditable, nodefault};
	__property void * Data = {read=FData, write=FData};
};


class PASCALIMPLEMENTATION TRzShellListData : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TRzCustomShellList* FOwner;
	_ITEMIDLIST *FAbsPidl;
	_ITEMIDLIST *FRelPidl;
	void *FData;
	AnsiString FDisplayName;
	bool FDataValid;
	AnsiString FSize;
	AnsiString FType;
	AnsiString FModified;
	Shlobj::PItemIDList __fastcall GetAbsoluteIdList(void);
	unsigned __fastcall GetAttributes(void);
	bool __fastcall GetEditable(void);
	AnsiString __fastcall GetDisplayName();
	AnsiString __fastcall GetFilename();
	AnsiString __fastcall GetPathName();
	AnsiString __fastcall GetColText(int col);
	void __fastcall GetExtraData(void);
	AnsiString __fastcall GetSize();
	AnsiString __fastcall GetFileType();
	AnsiString __fastcall GetModified();
	void __fastcall SetData(Shlobj::PItemIDList aRelPidl);
	
public:
	__fastcall TRzShellListData(TRzCustomShellList* aOwner);
	__fastcall virtual ~TRzShellListData(void);
	bool __fastcall IsFolder(void);
	bool __fastcall IsLnkShortcut(void);
	bool __fastcall IsValid(void);
	bool __fastcall IsFileSystem(void);
	void __fastcall Flush(void);
	__property TRzCustomShellList* Owner = {read=FOwner};
	__property Shlobj::PItemIDList AbsoluteIdList = {read=GetAbsoluteIdList};
	__property bool Editable = {read=GetEditable, nodefault};
	__property Shlobj::PItemIDList RelativeIdList = {read=FRelPidl};
	__property unsigned Attributes = {read=GetAttributes, nodefault};
	__property AnsiString DisplayName = {read=GetDisplayName};
	__property AnsiString FileName = {read=GetFilename};
	__property AnsiString PathName = {read=GetPathName};
	__property AnsiString ColText[int Col] = {read=GetColText};
	__property AnsiString Size = {read=GetSize};
	__property AnsiString FileType = {read=GetFileType};
	__property AnsiString Modified = {read=GetModified};
	__property void * Data = {read=FData, write=FData};
};


class PASCALIMPLEMENTATION TRzShellComboData : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	TRzCustomShellCombo* FOwner;
	Rzshellintf::IShellFolder_NRC* FIShfParent;
	_ITEMIDLIST *FParentPidl;
	_ITEMIDLIST *FRelPidl;
	_ITEMIDLIST *FAbsPidl;
	Rzshellintf::IShellFolder_NRC* FThisIshf;
	void *FData;
	Rzshellintf::IShellFolder_NRC* __fastcall GetThisIShf(void);
	void __fastcall SetData(Rzshellintf::IShellFolder_NRC* aParentIShf, Shlobj::PItemIDList parentPidl, Shlobj::PItemIDList curRelativePidl);
	
public:
	__fastcall TRzShellComboData(TRzCustomShellCombo* aOwner);
	__fastcall virtual ~TRzShellComboData(void);
	__property Shlobj::PItemIDList ParentIdList = {read=FParentPidl};
	__property Rzshellintf::IShellFolder_NRC* ParentIShf = {read=FIShfParent};
	__property Shlobj::PItemIDList RelativeIdList = {read=FRelPidl};
	__property Shlobj::PItemIDList AbsoluteIdList = {read=FAbsPidl};
	__property Rzshellintf::IShellFolder_NRC* ThisIShf = {read=GetThisIShf};
	__property void * Data = {read=FData, write=FData};
};


//-- var, const, procedure ---------------------------------------------------
static const Word RZSH_AM_CHANGE_NOTIFY = 0x465;
static const Word RZSH_AM_DEFERRED_EDIT = 0x466;
static const Word RZSH_AM_DEFERRED_FILL = 0x467;
static const Word RZSH_AM_LAST = 0x496;
extern PACKAGE int RZSH_CHANGE_NOTIFY_DELAY;
extern PACKAGE int RZSH_CHANGE_NOTIFY_FASTDELAY;
extern PACKAGE int RZSH_TREE_KEY_UPDATE_DELAY;
extern PACKAGE int RZSH_MAX_FOLDER_ATTEMPTS;
extern PACKAGE int RZSH_AUTOSCROLL_THRESHOLD_X;
extern PACKAGE int RZSH_AUTOSCROLL_THRESHOLD_Y;
extern PACKAGE int RZSH_AUTOSCROLL_MINDELAY_MS;
extern PACKAGE int RZSH_AUTOOPEN_DELAY_MS;
extern PACKAGE int RZSH_AUTOOPEN_THRESHOLD_X;
extern PACKAGE int RZSH_AUTOOPEN_THRESHOLD_Y;
extern PACKAGE Word CF_IDLIST;
extern PACKAGE bool __fastcall RzShCreateNewFolder(AnsiString aPathname, AnsiString &aNewName);
extern PACKAGE bool __fastcall RzShIsFolder(unsigned Attributes, bool CanTreatFilesAsFolders);

}	/* namespace Rzshellctrls */
using namespace Rzshellctrls;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Rzshellctrls
