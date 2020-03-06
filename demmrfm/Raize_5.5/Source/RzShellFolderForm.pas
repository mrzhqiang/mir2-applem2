{===============================================================================
  RzShellFolderForm Unit

  Raize Components - Component Source Unit

  Copyright © 1995-2010 by Raize Software, Inc.  All Rights Reserved.
  Copyright © 1996-2010 by Plasmatech Software Design. All Rights Reserved.

  Raize Shell Controls are licensed from Plasmatech Software Design.


  Components
  ------------------------------------------------------------------------------
  TRzShellTree
    Explorer-like tree view of the namespace.


  Modification History
  ------------------------------------------------------------------------------
  3.0.10 (26 Dec 2003)
    * Added InitFraming and InitHotTracking methods.
  ------------------------------------------------------------------------------
  3.0.6  (11 Apr 2003)
    * Modified fix introduced in 3.0.4 to address Large Font issues
      (i.e. removed DeferredAutoFill).
  ------------------------------------------------------------------------------
  3.0.4  (04 Mar 2003)
    * Fixed problem with nodes in tree view not showing up when running under
      Large Fonts.
    * Fixed problem with status bar showing above buttons when running under
      Large Fonts.
  ------------------------------------------------------------------------------
  3.0.3  (21 Jan 2003)
    * Modified the layout of the dialog.
    * StatusTxt was removed. StatusBar added--displays selected node.
  ------------------------------------------------------------------------------
  3.0    (20 Dec 2002)
    * Initial inclusion in Raize Components.
===============================================================================}

{$I RzComps.inc}

{$RANGECHECKS OFF}
{$WRITEABLECONST OFF}
{$TYPEDADDRESS ON}

unit RzShellFolderForm;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  ExtCtrls,
  Buttons,
  ShlObj,
  RzCommon,
  RzTreeVw,
  RzShellIntf,
  RzShellCtrls,
  RzShellDialogs,
  RzPanel,
  ImgList,
  RzButton;

type
  TRzSelectFolderForm = class( TForm )
    ShellTree: TRzShellTree;
    ButtonPanel: TPanel;
    btnOk: TRzBitBtn;
    btnCancel: TRzBitBtn;
    RzStatusBar1: TRzStatusBar;
    btnNewFolder: TRzToolButton;
    btnDeleteFolder: TRzToolButton;
    ImageList1: TImageList;
    procedure FormResize( Sender: TObject );
    procedure ShellTreeChange( Sender: TObject; Node: TTreeNode );
    procedure FormCreate( Sender: TObject );
    procedure CreateBtnClick( Sender: TObject );
    procedure DeleteBtnClick( Sender: TObject );
  private
    function GetSelectedPathname: string;
    function GetStatus: string;
    function GetOkEnabled: Boolean;
    procedure SetSelectedPathname( const Value: string );
    procedure SetStatus( const Value: string );
    procedure SetOkEnabled( Value: Boolean );
    procedure WMGetMinMaxInfo( var Msg: TWMGetMinMaxInfo ); message WM_GETMINMAXINFO;
  protected
//    FHGripWindow: HWND;
    FExecuting: Boolean;
    FOptions: TRzSelectFolderDialogOptions;
    FOnFormShow: TNotifyEvent;
    FOnFormClose: TNotifyEvent;
    FOnSelChange: TRzFolderBrowseSelChangeEvent;
    FOnAddItem: TRzShAddItemEvent;
    procedure CreateWnd; override;
    procedure DoShow; override;
    procedure DoHide; override;
    procedure DoTranslation; dynamic;
    procedure SetOptions( Value: TRzSelectFolderDialogOptions ); virtual;
  public
    constructor Create( AOwner: TComponent ); override;

    procedure InitFraming( FrameColor: TColor; FrameStyle: TFrameStyle;
                           FrameVisible: Boolean;
                           FramingPreference: TFramingPreference );
    procedure InitHotTracking( ButtonColor: TColor;
                               HotTrack: Boolean; HighlightColor: TColor;
                               HotTrackColor: TColor;
                               HotTrackColorType: TRzHotTrackColorType );

    procedure InitShowButtonGlyphs( ShowButtonGlyphs: Boolean );
    procedure InitToolButtons( ToolBtnGradientColorStyle: TRzGradientColorStyle;
                               ToolBtnSelectionColorStart,
                               ToolBtnSelectionColorStop,
                               ToolBtnSelectionFrameColor: TColor;
                               ToolBtnVisualStyle: TRzVisualStyle );

    property Executing: Boolean
      read FExecuting;

    property SelectedPathname: string
      read GetSelectedPathname
      write SetSelectedPathname;

    property Status: string
      read GetStatus
      write SetStatus;

    property OkEnabled: Boolean
      read GetOkEnabled
      write SetOkEnabled;

    property Options: TRzSelectFolderDialogOptions
      read FOptions
      write SetOptions;

    property OnAddItem: TRzShAddItemEvent
      read FOnAddItem
      write FOnAddItem;

    property OnFormClose: TNotifyEvent
      read FOnFormClose
      write FOnFormClose;

    property OnFormShow: TNotifyEvent
      read FOnFormShow
      write FOnFormShow;

    property OnSelChange: TRzFolderBrowseSelChangeEvent
      read FOnSelChange
      write FOnSelChange;
  end;


implementation

{$R *.dfm}

uses
  RzShellConsts, RzShellUtils;

const
  SIZEGRIP_SIZE = 13;


{=================================}
{== TFrmFolderBrowseDlg Methods ==}
{=================================}

constructor TRzSelectFolderForm.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
end;


procedure TRzSelectFolderForm.CreateWnd;
begin
  inherited CreateWnd;
end;


procedure TRzSelectFolderForm.DoShow;
begin
  inherited;
  Font.Name := SDialogFontName;

  ShellTree.Options := ShellTree.Options + [ stoAutoFill ];
  ShellTree.FillItems;

  DoTranslation;
  if Assigned( FOnFormShow ) then
    FOnFormShow( Self );
end;


procedure TRzSelectFolderForm.DoHide;
begin
  inherited;
  if Assigned( FOnFormClose ) then
    FOnFormClose( Self );
end;


procedure TRzSelectFolderForm.DoTranslation;
begin
  btnOk.Caption := SOkButton;
  btnCancel.Caption := SCancelButton;
  BtnNewFolder.Caption := SCreateFolder;
  BtnDeleteFolder.Caption := SDeleteHint;

  if Caption = '' then
    Caption := SBrowseForFolder;
end;


procedure TRzSelectFolderForm.SetOptions( Value: TRzSelectFolderDialogOptions );
var
  TreeOptions: TRzShellTreeOptions;

  procedure ApplyOption( Apply: Boolean; Option: TRzShellTreeOption );
  begin
    if Apply then
      Include( treeOptions, Option )
    else
      Exclude( treeOptions, Option );
  end;

begin
  FOptions := Value;

  TreeOptions := ShellTree.Options;
  ApplyOption( sfdoOleDrag in Value, stoOleDrag );
  ApplyOption( sfdoOleDrop in Value, stoOleDrop );
  ApplyOption( sfdoIncludeNonFolders in Value, stoIncludeNonFolders );
  ApplyOption( sfdoVirtualFolders in Value, stoVirtualFolders );
  ApplyOption( sfdoContextMenus in Value, stoContextMenus );
  ApplyOption( sfdoShowHidden in Value, stoShowHidden );
  ShellTree.Options := TreeOptions;

  BtnNewFolder.Visible := ( sfdoCreateDeleteButtons in Value );
  BtnDeleteFolder.Visible := ( sfdoCreateDeleteButtons in Value );

  if sfdoCreateFolderIcon in Value then
    BtnNewFolder.ImageIndex := 0
  else
  begin
    BtnNewFolder.ImageIndex := -1;
  end;
  if sfdoDeleteFolderIcon in Value then
    BtnDeleteFolder.ImageIndex := 2
  else
    BtnDeleteFolder.ImageIndex := -1;

  if not ( sfdoCreateFolderIcon in Value ) or not ( sfdoDeleteFolderIcon in Value ) then
  begin
    BtnNewFolder.Flat := False;
    BtnDeleteFolder.Flat := False;
  end;

  ShellTree.ReadOnly := ( sfdoReadOnly in Value );
end; {= TRzSelectFolderForm.SetOptions =}


procedure TRzSelectFolderForm.InitFraming( FrameColor: TColor; FrameStyle: TFrameStyle;
                                           FrameVisible: Boolean;
                                           FramingPreference: TFramingPreference );
begin
  ShellTree.FrameColor := FrameColor;
  ShellTree.FrameStyle := FrameStyle;
  ShellTree.FrameVisible := FrameVisible;
  ShellTree.FramingPreference := FramingPreference;
end;


procedure TRzSelectFolderForm.InitHotTracking( ButtonColor: TColor;
                                               HotTrack: Boolean; HighlightColor: TColor;
                                               HotTrackColor: TColor;
                                               HotTrackColorType: TRzHotTrackColorType );
begin
  btnOk.Color := ButtonColor;
  btnOk.HotTrack := HotTrack;
  btnOk.HighlightColor := HighlightColor;
  btnOk.HotTrackColor := HotTrackColor;
  btnOk.HotTrackColorType := HotTrackColorType;

  btnCancel.Color := ButtonColor;
  btnCancel.HotTrack := HotTrack;
  btnCancel.HighlightColor := HighlightColor;
  btnCancel.HotTrackColor := HotTrackColor;
  btnCancel.HotTrackColorType := HotTrackColorType;
end;


procedure TRzSelectFolderForm.InitShowButtonGlyphs( ShowButtonGlyphs: Boolean );
begin
  if ShowButtonGlyphs then
  begin
    btnOk.Glyph.Handle := LoadBitmap( HInstance, 'RZCOMMON_OK' );
    btnCancel.Glyph.Handle := LoadBitmap( HInstance, 'RZCOMMON_CANCEL' );
  end;
end;


procedure TRzSelectFolderForm.InitToolButtons( ToolBtnGradientColorStyle: TRzGradientColorStyle;
                                               ToolBtnSelectionColorStart,
                                               ToolBtnSelectionColorStop,
                                               ToolBtnSelectionFrameColor: TColor;
                                               ToolBtnVisualStyle: TRzVisualStyle );
begin
  btnNewFolder.GradientColorStyle := ToolBtnGradientColorStyle;
  btnNewFolder.SelectionColorStart := ToolBtnSelectionColorStart;
  btnNewFolder.SelectionColorStop := ToolBtnSelectionColorStop;
  btnNewFolder.SelectionFrameColor := ToolBtnSelectionFrameColor;
  btnNewFolder.VisualStyle := ToolBtnVisualStyle;

  btnDeleteFolder.GradientColorStyle := ToolBtnGradientColorStyle;
  btnDeleteFolder.SelectionColorStart := ToolBtnSelectionColorStart;
  btnDeleteFolder.SelectionColorStop := ToolBtnSelectionColorStop;
  btnDeleteFolder.SelectionFrameColor := ToolBtnSelectionFrameColor;
  btnDeleteFolder.VisualStyle := ToolBtnVisualStyle;
  
  RzStatusBar1.VisualStyle := ToolBtnVisualStyle;
end;


function TRzSelectFolderForm.GetSelectedPathname: string;
begin
  Result := ShellTree.SelectedPathname;
end;


function TRzSelectFolderForm.GetStatus: string;
begin
  Result := RzStatusBar1.SimpleCaption;
end;


function TRzSelectFolderForm.GetOkEnabled: Boolean;
begin
  Result := btnOk.Enabled
end;


procedure TRzSelectFolderForm.SetSelectedPathname( const Value: string );
begin
  ShellTree.SelectedPathname := Value;
end;


procedure TRzSelectFolderForm.SetStatus( const Value: string );
begin
  RzStatusBar1.SimpleCaption := Value;
end;


procedure TRzSelectFolderForm.SetOkEnabled( Value: Boolean );
begin
  btnOk.Enabled := Value;
end;


procedure TRzSelectFolderForm.WMGetMinMaxInfo( var Msg: TWMGetMinMaxInfo );
begin
  Msg.minMaxInfo.ptMinTrackSize := Point( 366, 340 );
end;


procedure TRzSelectFolderForm.FormCreate( Sender: TObject );
begin
  {$IFDEF VCL90_OR_HIGHER}
  PopupMode := pmAuto;
  {$ENDIF}

  ShellTree.ShowRoot := TRUE;
  RzStatusBar1.Top := Height;
end;


procedure CutFirstDirectory(var S: TFileName);
var
  Root: Boolean;
  P: Integer;
begin
  if S = '\' then
    S := ''
  else
  begin
    if S[1] = '\' then
    begin
      Root := True;
      Delete(S, 1, 1);
    end
    else
      Root := False;
    if S[1] = '.' then
      Delete(S, 1, 4);
    P := AnsiPos('\',S);
    if P <> 0 then
    begin
      Delete(S, 1, P);
      S := '...\' + S;
    end
    else
      S := '';
    if Root then
      S := '\' + S;
  end;
end;


function MinimizeName(const Filename: TFileName; Canvas: TCanvas;
  MaxLen: Integer): TFileName;
var
  Drive: TFileName;
  Dir: TFileName;
  Name: TFileName;
begin
  Result := FileName;
  Dir := ExtractFilePath(Result);
  Name := ExtractFileName(Result);

  if (Length(Dir) >= 2) and (Dir[2] = ':') then
  begin
    Drive := Copy(Dir, 1, 2);
    Delete(Dir, 1, 2);
  end
  else
    Drive := '';
  while ((Dir <> '') or (Drive <> '')) and (Canvas.TextWidth(Result) > MaxLen) do
  begin
    if Dir = '\...\' then
    begin
      Drive := '';
      Dir := '...\';
    end
    else if Dir = '' then
      Drive := ''
    else
      CutFirstDirectory(Dir);
    Result := Drive + Dir + Name;
  end;
end;


procedure TRzSelectFolderForm.FormResize( Sender: TObject );
const
  BUTTON_RIGHT_MARGIN = 8;
  CONTROL_HORZ_MARGIN = 12;                 // margin to left and right of controls above bottom buttons
var
  R: TRect;
  T: Integer;
begin
  R := ShellTree.BoundsRect;
  if BtnNewFolder.Visible then
    T := BtnNewFolder.BoundsRect.Bottom + 4
  else if BtnDeleteFolder.Visible then
    T := BtnDeleteFolder.BoundsRect.Bottom + 4
  else
    T := 8;
  ShellTree.BoundsRect := Rect( R.left, T, R.left + Width - CONTROL_HORZ_MARGIN * 2, ButtonPanel.BoundsRect.Top - 4 );

  btnCancel.Left := ClientRect.Right - BUTTON_RIGHT_MARGIN - btnCancel.ClientWidth;
  btnOk.Left := btnCancel.Left - 8 - btnOk.ClientWidth;

  if Assigned( ShellTree.Selected ) and Assigned( ShellTree.Selected.Data ) and ( TObject( ShellTree.Selected.Data ) is TRzShellTreeData ) then
  begin
    with TRzShellTreeData( ShellTree.Selected.Data ) do
      Status := MinimizeName( Pathname, Canvas, RzStatusBar1.Width - 20 );
  end;
end; {= TRzSelectFolderForm.FormResize =}



procedure TRzSelectFolderForm.ShellTreeChange( Sender: TObject; Node: TTreeNode );
var
  hasPathname: Boolean;
begin
  if Assigned( Node ) and Assigned( Node.Data ) and ( TObject( Node.Data ) is TRzShellTreeData ) then
    with TRzShellTreeData( Node.Data ) do
    begin
      hasPathname := ( Pathname <> '' );

      Status := MinimizeName( Pathname, Canvas, RzStatusBar1.Width - 20 );

      BtnNewFolder.Enabled := hasPathname;
      BtnDeleteFolder.Enabled := hasPathname and ( node.AbsoluteIndex <> 0 );

      if Assigned( OnSelChange ) then
        OnSelChange( Self, {.} AbsoluteIdList );
    end;
end;


procedure TRzSelectFolderForm.CreateBtnClick( Sender: TObject );
begin
  ShellTree.CreateNewFolder( TRUE );
end;


procedure TRzSelectFolderForm.DeleteBtnClick( Sender: TObject );
begin
  ShellTree.DoCommandForNode( ShellTree.Selected, RZSH_CMDS_DELETE );
  ShellTree.RefreshNodes;
end;


end.

