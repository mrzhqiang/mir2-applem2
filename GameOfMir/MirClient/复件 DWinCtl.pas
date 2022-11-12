unit DWinCtl;

interface

uses
  Windows, Classes, Graphics, Controls, StrUtils, SysUtils, DXDraws, DXClass,
  Grids, Wil, Clipbrd, imm;
const
  AllowedChars = [#32..#254];
  AllowedIntegerChars = [#48..#57];
  AllowedEnglishChars = [#33..#126];

type
  TClickSound = (csNone, csStone, csGlass, csNorm);
  TDEditClass = (deNone, deInteger, deMonoCase, deChinese);
  TMouseEntry = (msIn, msOut);
  TDControlStyle = (dsNone, dsTop, dsBottom);

  TDControl = class;
  TOnDirectPaint = procedure(Sender: TObject; dsurface: TDirectDrawSurface) of object;
  TOnKeyPress = procedure(Sender: TObject; var Key: Char) of object;
  TOnKeyDown = procedure(Sender: TObject; var Key: word; Shift: TShiftState) of object;
  TOnKeyUp = procedure(Sender: TObject; var Key: word; Shift: TShiftState) of object;
  TOnMouseMove = procedure(Sender: TObject; Shift: TShiftState; X, Y: integer) of object;
  TOnMouseDown = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer) of object;
  TOnMouseUp = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;
  TOnClick = procedure(Sender: TObject) of object;
  TOnVisible = procedure(Sender: TObject; boVisible: Boolean) of object;
  TOnClickEx = procedure(Sender: TObject; X, Y: integer) of object;
  TOnInRealArea = procedure(Sender: TObject; X, Y: integer; var IsRealArea: Boolean) of object;
  TOnGridSelect = procedure(Sender: TObject; ACol, ARow: integer; Shift: TShiftState) of object;
  TOnItemIndex = procedure(Sender: TObject; ItemIndex, SubIndex: integer) of object;
  TOnPopIndex = procedure(Sender, AddendData: TObject; ItemIndex: integer) of object;
  TOnGridPaint = procedure(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState;
    dsurface: TDirectDrawSurface) of object;
  TOnClickSound = procedure(Sender: TObject; Clicksound: TClickSound) of object;
  TOnMouseEntry = procedure(Sender: TObject; MouseEntry: TMouseEntry) of object;

  TDControl = class(TCustomControl)
  private
    FCaption: string; //0x1F0
    FDParent: TDControl; //0x1F4
    //  FEnableFocus: Boolean; //0x1F8
    FMouseFocus: Boolean;
    FKeyFocus: Boolean;
    FOnDirectPaint: TOnDirectPaint; //0x1FC
    FOnEndDirectPaint: TOnDirectPaint; //0x1FC
    FOnKeyPress: TOnKeyPress; //0x200
    FOnKeyDown: TOnKeyDown; //0x204
    FOnKeyUp: TOnKeyUp;
    FOnMouseMove: TOnMouseMove; //0x208
    FOnMouseDown: TOnMouseDown; //0x20C
    FOnMouseUp: TOnMouseUp; //0x210
    FOnDblClick: TNotifyEvent; //0x214
    FOnClick: TOnClickEx; //0x218
    FOnInRealArea: TOnInRealArea; //0x21C
    FOnBackgroundClick: TOnClick; //0x220
    FOnMouseEntry: TOnMouseEntry;
    FMouseEntry: TMouseEntry;
    FOnEnter: TOnClick;
    FOnLeave: TOnClick;
    FOnVisible: TOnVisible;
    FChangeCaption: Boolean;
    FSurface: TDirectDrawSurface;
    FAppendData: Pointer;
    FDFColor: TColor;
    FDFMoveColor: TColor;
    FDFEnabledColor: TColor;
    FDFDownColor: TColor;
    FDFBackColor: TColor;
    procedure SetCaption(str: string);
    procedure SetVisible(flag: Boolean);
  protected
    FVisible: Boolean;
    FIsHide: Boolean;
    FEnabled: Boolean;
    FTabDControl: TDControl;
  public
    Background: Boolean; //0x24D
    DControls: TList; //0x250
    DTabControls: TList; //0x25
    //FaceSurface: TDirectDrawSurface;
    WLib: TWMImages; //0x254
    FaceIndex: integer; //0x258
    WantReturn: Boolean; //Background老锭, Click狼 荤侩 咯何..
    AppendTick: LongWord;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Loaded; override;
    function SurfaceX(x: integer): integer;
    function SurfaceY(y: integer): integer;
    function LocalX(x: integer): integer;
    function LocalY(y: integer): integer;
    procedure AddChild(dcon: TDControl);
    procedure ChangeChildOrder(dcon: TDControl);
    function InRange(x, y: integer): Boolean; dynamic;
    function KeyPress(var Key: Char): Boolean; dynamic;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; dynamic;
    function KeyUp(var Key: Word; Shift: TShiftState): Boolean; dynamic;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; dynamic;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; dynamic;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; dynamic;
    function DblClick(X, Y: integer): Boolean; dynamic;
    function CheckTab(): Boolean; dynamic;
    procedure CloseSurface();
    procedure IsVisible(flag: Boolean); dynamic;

    function Click(X, Y: integer): Boolean; dynamic;
    function CanFocusMsg: Boolean;
    procedure Leave(); dynamic;
    procedure Enter(); dynamic;
    procedure SetFocus(); dynamic;
    procedure SetImgIndex(Lib: TWMImages; index: integer);
    procedure SetSurface(DDraw: TDirectDraw; Lib: TWMImages; index: integer = 0);
    procedure DirectPaint(dsurface: TDirectDrawSurface); dynamic;
    property MouseEntry: TMouseEntry read FMouseEntry;
    property ChangeCaption: Boolean read FChangeCaption;
    property IsHide: Boolean read FIsHide;
    property Surface: TDirectDrawSurface read FSurface;
    property AppendData: Pointer read FAppendData write FAppendData;

  published
    property DFColor: TColor read FDFColor write FDFColor;
    property DFEnabledColor: TColor read FDFEnabledColor write FDFEnabledColor;
    property DFMoveColor: TColor read FDFMoveColor write FDFMoveColor;
    property DFDownColor: TColor read FDFDownColor write FDFDownColor;
    property DFBackColor: TColor read FDFBackColor write FDFBackColor;

    property OnDirectPaint: TOnDirectPaint read FOnDirectPaint write FOnDirectPaint;
    property OnEndDirectPaint: TOnDirectPaint read FOnEndDirectPaint write FOnEndDirectPaint;
    property OnKeyPress: TOnKeyPress read FOnKeyPress write FOnKeyPress;
    property OnKeyDown: TOnKeyDown read FOnKeyDown write FOnKeyDown;
    property OnMouseMove: TOnMouseMove read FOnMouseMove write FOnMouseMove;
    property OnMouseDown: TOnMouseDown read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TOnMouseUp read FOnMouseUp write FOnMouseUp;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnInRealArea: TOnInRealArea read FOnInRealArea write FOnInRealArea;
    property OnBackgroundClick: TOnClick read FOnBackgroundClick write
      FOnBackgroundClick;
    property OnMouseEntry: TOnMouseEntry read FOnMouseEntry write FOnMouseEntry;
    property OnEnter: TOnClick read FOnEnter write FOnEnter;
    property OnLeave: TOnClick read FOnLeave write FOnLeave;
    property OnVisible: TOnVisible read FOnVisible write FOnVisible;
    property Caption: string read FCaption write SetCaption;
    property DParent: TDControl read FDParent write FDParent;
    property Visible: Boolean read FVisible write SetVisible;
    property Enabled: Boolean read FEnabled write FEnabled;
    //property EnableFocus: Boolean read FEnableFocus write FEnableFocus;
    property MouseFocus: Boolean read FMouseFocus write FMouseFocus;
    property KeyFocus: Boolean read FKeyFocus write FKeyFocus;
    property Color;
    property Font;
    property Hint;
    property ShowHint;
    property Align;
  end;
  //按钮控件
  TDButton = class(TDControl)
  private
    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;
  public
    Downed: Boolean;
    constructor Create(AOwner: TComponent); override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
  published
    property ClickCount: TClickSound read FClickSound write FClickSound;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
  end;
  //表格控件
  TDGrid = class(TDControl)
  private
    FColCount, FRowCount: integer;
    FColWidth, FRowHeight: integer;
    FColoffset, FRowoffset: Integer;
    FViewTopLine: integer;
    SelectCell: TPoint;
    DownPos: TPoint;
    FOnGridSelect: TOnGridSelect;
    FOnGridMouseMove: TOnGridSelect;
    FOnGridPaint: TOnGridPaint;
    function GetColRow(x, y: integer; var acol, arow: integer): Boolean;
  public
    CX, CY: integer;
    Col, Row: integer;
    constructor Create(AOwner: TComponent); override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    function Click(X, Y: integer): Boolean; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
  published
    property ColCount: integer read FColCount write FColCount;
    property RowCount: integer read FRowCount write FRowCount;
    property ColWidth: integer read FColWidth write FColWidth;
    property RowHeight: integer read FRowHeight write FRowHeight;
    property Coloffset: integer read FColoffset write FColoffset;
    property Rowoffset: integer read FRowoffset write FRowoffset;
    property ViewTopLine: integer read FViewTopLine write FViewTopLine;
    property OnGridSelect: TOnGridSelect read FOnGridSelect write FOnGridSelect;
    property OnGridMouseMove: TOnGridSelect read FOnGridMouseMove write
      FOnGridMouseMove;
    property OnGridPaint: TOnGridPaint read FOnGridPaint write FOnGridPaint;
  end;
  //窗口控件
  TDWindow = class(TDButton)
  private
    FFloating: Boolean;
    //FFMovie: Boolean;
    SpotX, SpotY: integer;
    FControlStyle: TDControlStyle;
  protected
    procedure SetVisible(flag: Boolean);
  public
    DialogResult: TModalResult;
    constructor Create(AOwner: TComponent); override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    procedure Show;
    function ShowModal: integer;
  published
    property Visible: Boolean read FVisible write SetVisible;
    property Floating: Boolean read FFloating write FFloating;
    property ControlStyle: TDControlStyle read FControlStyle write FControlStyle;
    //property FMovie: Boolean read FFMovie write FFMovie default True;
  end;

  TDCheckBox = class(TDControl)
  private
    FChecked: Boolean;
    FFontSpace: Integer;
    FOnClick: TOnClickEx;
    FWidth: Integer;
    FHeight: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    function InRange(x, y: integer): Boolean; override;
  published
    property Checked: Boolean read FChecked write FChecked;
    property FontSpace: Integer read FFontSpace write FFontSpace;
    property OnClick: TOnClickEx read FOnClick write FOnClick;
  end;

  TDUpDown = class(TDButton)
  private
    FUpButton: TDButton;
    FDownButton: TDButton;
    FMoveButton: TDButton;
    FPosition: Integer;
    FMaxPosition: Integer;
    FOnPositionChange: TOnClick;
    FTop: Integer;
    FAddTop: Integer;
    FMaxLength: Integer;
    FOffset: Integer;
    FBoMoveShow: Boolean;
    StopY: Integer;
    FStopY: Integer;
    FClickTime: LongWord;
    procedure SetButton(Button: TDButton);
    procedure SetPosition(value: Integer);
    procedure SetMaxPosition(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    procedure ButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y:
      integer);
    procedure ButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure ButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    property UpButton: TDButton read FUpButton;
    property DownButton: TDButton read FDownButton;
    property MoveButton: TDButton read FMoveButton;
  published
    property Position: Integer read FPosition write SetPosition;
    property Offset: Integer read FOffset write FOffset;
    property MoveShow: Boolean read FBoMoveShow write FBoMoveShow;
    property MaxPosition: Integer read FMaxPosition write SetMaxPosition;
    property OnPositionChange: TOnClick read FOnPositionChange write
      FOnPositionChange;
  end;

  TDHooKKey = class(TDControl)
  private
    FShiftState: TShiftState;
    FKey: Word;
    FText: string;
    FFrameColor: TColor;
    FOnChange: TOnClick;
    procedure SetShiftState(Value: TShiftState);
    procedure SetKey(Value: Word);
  public
    constructor Create(AOwner: TComponent); override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; override;
    procedure RefHookKeyStr();
    property Text: string read FText;
  published
    property ShiftState: TShiftState read FShiftState write SetShiftState;
    property Key: Word read FKey write SetKey;
    property FrameColor: TColor read FFrameColor write FFrameColor;
    property OnChange: TOnClick read FOnChange write FOnChange;
  end;

  TCursor = (deLeft, deRight);

  TDMemo = class(TDControl)
  private
    FLines: TStrings;
    FOnChange: TOnClick;
    FReadOnly: Boolean;
    FFrameColor: TColor;
    FCaretShowTime: LongWord;
    FCaretShow: Boolean;
    FTopIndex: Integer;
    FCaretX: Integer;
    FCaretY: Integer;
    FSCaretX: Integer;
    FSCaretY: Integer;
    FUpDown: TDUpDown;
    FMoveTick: LongWord;
    FInputStr: string;
    bDoubleByte: Boolean;
    KeyByteCount: Integer;
    FTransparent: Boolean;
    FEditClass: TDEditClass;
    FMaxLength: integer;
    //procedure SetLines(const Value: TStrings);
    procedure DownCaret(X, Y: Integer);
    procedure MoveCaret(X, Y: Integer);
    procedure KeyCaret(Key: Word);
    procedure SetUpDown(const Value: TDUpDown);
    procedure SetCaret(boBottom: Boolean);
    function ClearKey(): Boolean;
    function GetKey(): string;
    procedure SetCaretY(const Value: Integer);
    function FiltrateChar(Char1, Char2: Byte): Boolean;
  public
    Downed: Boolean;
    KeyDowned: Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;

    function KeyPress(var Key: Char): Boolean; override;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; override;
    function KeyUp(var Key: Word; Shift: TShiftState): Boolean; override;

    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;

    procedure Enter(); override;
    procedure Leave(); override;
    procedure SetFocus(); override;

    procedure PositionChange(Sender: TObject);
    procedure TextChange();

    property Lines: TStrings read FLines;
    property ItemIndex: Integer read FCaretY write SetCaretY;

    procedure RefListWidth(ItemIndex: Integer; nCaret: Integer);
  published
    property OnChange: TOnClick read FOnChange write FOnChange;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property FrameColor: TColor read FFrameColor write FFrameColor;

    property UpDown: TDUpDown read FUpDown write SetUpDown;
    property boTransparent: Boolean read FTransparent write FTransparent;
    property EditClass: TDEditClass read FEditClass write FEditClass;
    property MaxLength: Integer read FMaxLength write FMaxLength default 0;
  end;

  TDMemoStringList = class(TStringList)
    DMemo: TDMemo;
  private
    procedure Put(Index: Integer; const Value: string);
    function SelfGet(Index: Integer): string;
  published
  public
    function Add(const S: string): Integer; override;
    function AddObject(const S: string; AObject: TObject): Integer; override;
    procedure InsertObject(Index: Integer; const S: string;
      AObject: TObject); override;
    function Get(Index: Integer): string; override;

    function GetText: PChar; override;
    procedure LoadFromFile(const FileName: string); override;
    procedure SaveToFile(const FileName: string); override;

    property Str[Index: Integer]: string read SelfGet write Put; default;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
  end;

  TDEdit = class(TDControl)
  private
    FReadOnly: Boolean;
    FEditString: WideString;
    FFrameColor: TColor;
    FCaretShowTime: LongWord;
    FCaretShow: Boolean;
    FMaxLength: Integer;
    FEditClass: TDEditClass;
    FInputStr: string;
    bDoubleByte: Boolean;
    KeyByteCount: Integer;
    FPasswordChar: Char;
    FCursor: TCursor;
    FStartX: Integer;
    FStopX: Integer;
    FCaretStart: Integer; //光标起始位置
    FCaretStop: Integer; //光标结束位置
    FCaretPos: Integer; //当前光标所在位置
    FOnChange: TOnClick;
    FIndent: Integer;
    FCloseSpace: Boolean;
    procedure SetCursorPos(cCursor: TCursor);
    procedure SetCursorPosEx(nLen: Integer);
    procedure SetText(Value: string);
    function GetText(): string;
    procedure MoveCaret(X, Y: Integer);
    function ClearKey(): Boolean;
    function CloseIME: Boolean;
    function GetPasswordstr(str: string): string;
    function GetCopy(): string;
    function FiltrateChar(Char1, Char2: Byte): Boolean;
  public
    Downed: Boolean;
    KeyDowned: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function KeyPress(var Key: Char): Boolean; override;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean; override;
    function KeyUp(var Key: Word; Shift: TShiftState): Boolean; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    procedure Enter(); override;
    procedure Leave(); override;
    procedure SetFocus(); override;
    procedure TextChange();
  published
    property OnChange: TOnClick read FOnChange write FOnChange;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property Text: string read GetText write SetText;
    property FrameColor: TColor read FFrameColor write FFrameColor;
    property MaxLength: Integer read FMaxLength write FMaxLength default 0;
    property EditClass: TDEditClass read FEditClass write FEditClass default deNone;
    property PasswordChar: Char read FPasswordChar write FPasswordChar default #0;
    property CloseSpace: Boolean read FCloseSpace write FCloseSpace default False;

  end;

  TDComboBox = class(TDEdit)
  private
    FUpDown: TDUpDown;
    FItem: TStrings;
    FShowCount: Integer;
    FListHeight: Integer;
    FShowHeight: Integer;
    FListIndex: Integer;
    FX: Integer;
    FY: Integer;
    FDWidth: Integer;
    FItemIndex: Integer;
    FOnChange: TOnClick;
    procedure SetUpDownButton(Button: TDUpDown);
    procedure SetShowCount(Value: Integer);
    procedure SetShowHeight(Value: Integer);
    procedure SetItem(const Value: TStrings);
    function GetItemIndex: Integer;
    procedure SetItemIndex(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    function InRange(x, y: integer): Boolean; override;
    property UpDown: TDUpDown read FUpDown;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
  published
    property ShowCount: Integer read FShowCount write SetShowCount;
    property ShowHeight: Integer read FShowHeight write SetShowHeight;

    property Item: TStrings read FItem write SetItem;
    property OnChange: TOnClick read FOnChange write FOnChange;
  end;

  TDBiDiMode = (dbLeft, dbCenter, dbRight);

  TDListViewHead = record
    sName: string[40];
    DBiDiMode: TDBiDiMode;
    nWidth: Word;
    Rect: TRect;
  end;
  pTDListViewHead = ^TDListViewHead;

  TDListView = class(TDControl)
  private
    FUpDown: TDUpDown;
    FHeadList: TList;
    FItemList: TList;
    FItemHeigth: Integer;
    FItemIndex: Integer;
    FItemCount: Integer;
    FOnItemIndex: TOnItemIndex;
    procedure SetUpDownButton(Button: TDUpDown);
    function GetItems(Index: Integer): TStringList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearHead();
    procedure Clear();
    property HeadList: TList read FHeadList;
    function AddItem(): TStringList;
    procedure AddHead(sName: string; DBiDiMode: TDBiDiMode; Width: Word);
    property UpDown: TDUpDown read FUpDown;
    property Item[Index: Integer]: TStringList read GetItems;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    property ItemIndex: Integer read FItemIndex;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
  published
    property OnItemIndex: TOnItemIndex read FOnItemIndex write FOnItemIndex;
  end;

  TDPopUpMemu = class(TDControl)
  private
    FItem: TStrings;
    FHeightOffset: Integer;
    FItemIndex: Integer;
    FOnPopIndex: TOnPopIndex;
    FAlpha: Integer;
    FHeight: Integer;
    FWidth: Integer;
    procedure SetItem(const Value: TStrings);
    procedure SetOffset(const Value: Integer);
    procedure SetItemIndex(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function InRange(x, y: integer): Boolean; override;
    procedure DirectPaint(dsurface: TDirectDrawSurface); override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean; override;
    procedure Popup(Sender: TObject; nLeft, nTop: Integer);
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    procedure RefSize();
    property ShowHeight: Integer read FHeight;
    property ShowWidth: Integer read FWidth;
  published
    property Item: TStrings read FItem write SetItem;
    property HeightOffset: Integer read FHeightOffset write SetOffset;
    property OnPopIndex: TOnPopIndex read FOnPopIndex write FOnPopIndex;
    property Alpha: Integer read FAlpha write FAlpha;

  end;

  //控件管理器
  TDWinManager = class(TComponent)
  private
  public
    DWinList: TList; //list of TDControl;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddDControl(dcon: TDControl; visible: Boolean);
    procedure DelDControl(dcon: TDControl);
    procedure CloseSurface();
    procedure ClearAll;

    function KeyPress(var Key: Char): Boolean;
    function KeyDown(var Key: Word; Shift: TShiftState): Boolean;
    function KeyUp(var Key: Word; Shift: TShiftState): Boolean;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer):
      Boolean;
    function DblClick(X, Y: integer): Boolean;
    function Click(X, Y: integer): Boolean;
    procedure DirectPaint(dsurface: TDirectDrawSurface);
  end;

procedure Register;
procedure SetDFocus(dcon: TDControl);
procedure ReleaseDFocus;
procedure SetDCapture(dcon: TDControl);
procedure ReleaseDCapture;
procedure SetDKocus(dcon: TDControl);
procedure ReleaseDKocus;

var
  MouseCaptureControl: TDControl; //mouse message
  FocusedControl: TDControl;
  KeyControl: TDControl;
  MainWinHandle: integer;
  FrmMainWinHandle: Integer;
  ModalDWindow: TDControl;
  PopUpDWindow: TDControl = nil;
  MouseEntryControl: TDControl = nil;
  //DefDsurface: TDirectDrawSurface;

implementation

uses
  Share;

var
  ChrBuff: PChar;

procedure Register;
begin
  RegisterComponents('MirGame', [TDWinManager, TDControl, TDButton, TDGrid,
    TDWindow, TDCheckBox, TDUpDown, TDHooKKey, TDEdit, TDComboBox, TDListView,
      TDMemo, TDPopUpMemu]);
end;

function GetValidStr3(Str: string; var Dest: string; const Divider: array of
  Char): string;
const
  BUF_SIZE = 20480; //$7FFF;
var
  Buf: array[0..BUF_SIZE] of Char;
  BufCount, Count, SrcLen, i, ArrCount: LongInt;
  Ch: Char;
label
  CATCH_DIV;
begin
  Ch := #0; //Jacky
  try
    SrcLen := Length(Str);
    BufCount := 0;
    Count := 1;

    if SrcLen >= BUF_SIZE - 1 then begin
      Result := '';
      Dest := '';
      Exit;
    end;

    if Str = '' then begin
      Dest := '';
      Result := Str;
      Exit;
    end;
    ArrCount := SizeOf(Divider) div SizeOf(Char);

    while True do begin
      if Count <= SrcLen then begin
        Ch := Str[Count];
        for i := 0 to ArrCount - 1 do
          if Ch = Divider[i] then
            goto CATCH_DIV;
      end;
      if (Count > SrcLen) then begin
        CATCH_DIV:
        if (BufCount > 0) then begin
          if BufCount < BUF_SIZE - 1 then begin
            Buf[BufCount] := #0;
            Dest := string(Buf);
            Result := Copy(Str, Count + 1, SrcLen - Count);
          end;
          break;
        end
        else begin
          if (Count > SrcLen) then begin
            Dest := '';
            Result := Copy(Str, Count + 2, SrcLen - 1);
            break;
          end;
        end;
      end
      else begin
        if BufCount < BUF_SIZE - 1 then begin
          Buf[BufCount] := Ch;
          Inc(BufCount);
        end; // else
        //ShowMessage ('BUF_SIZE overflow !');
      end;
      Inc(Count);
    end;
  except
    Dest := '';
    Result := '';
  end;
end;

procedure BoldTextOutEx(surface: TDirectDrawSurface; x, y, fcolor, bcolor:
  integer; str: string);
var
  nLen: Integer;
begin
  if str = '' then Exit;
  with surface do begin
    nLen := Length(str);
    Move(str[1], ChrBuff^, nlen);
    Canvas.Font.Color := bcolor;
    TextOut(Canvas.Handle, x, y - 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x, y + 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x - 1, y, ChrBuff, nlen);
    TextOut(Canvas.Handle, x + 1, y, ChrBuff, nlen);
    TextOut(Canvas.Handle, x - 1, y - 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x + 1, y + 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x - 1, y + 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x + 1, y - 1, ChrBuff, nlen);
    Canvas.Font.Color := fcolor;
    TextOut(Canvas.Handle, x, y, ChrBuff, nlen);
  end;
end;

procedure BoldTextOut(surface: TDirectDrawSurface; x, y, fcolor, bcolor:
  integer; str: string);
begin
  with surface do begin
    Canvas.Font.Color := bcolor;
    Canvas.TextOut(x - 1, y, str);
    Canvas.TextOut(x + 1, y, str);
    Canvas.TextOut(x, y - 1, str);
    Canvas.TextOut(x, y + 1, str);
    Canvas.Font.Color := fcolor;
    Canvas.TextOut(x, y, str);
  end;
end;

procedure TextRectEx(surface: TDirectDrawSurface; var Rect: TRect; var Text: string; fcolor, bcolor:integer; TextFormat: TTextFormat = []);
var
  dc: TRect;
begin
  with Surface.Canvas do begin
    Font.Color := bcolor;
    dc := Rect;
    Rect.Left := Rect.Left - 1;
    Rect.Right := Rect.Right - 1;
    TextRect(Rect, Text, TextFormat);
    Rect := dc;
    Rect.Left := Rect.Left + 1;
    Rect.Right := Rect.Right + 1;
    TextRect(Rect, Text, TextFormat);
    Rect := dc;
    Rect.Top := Rect.Top - 1;
    Rect.Bottom := Rect.Bottom - 1;
    TextRect(Rect, Text, TextFormat);
    Rect := dc;
    Rect.Top := Rect.Top + 1;
    Rect.Bottom := Rect.Bottom + 1;
    TextRect(Rect, Text, TextFormat);
    Font.Color := fcolor;
    Rect := dc;
    TextRect(Rect, Text, TextFormat);
  end;

end;

//设置当前获得输入焦点的控件

procedure SetDKocus(dcon: TDControl);
begin
  if KeyControl <> dcon then begin
    if (KeyControl <> nil) then
      KeyControl.Leave;
    dcon.Enter;
  end;
  KeyControl := dcon;
end;

procedure ReleaseDKocus;
begin
  if (KeyControl <> nil) then begin
    KeyControl.Leave;
  end;
  KeyControl := nil;
end;

//设置当前获得鼠标焦点的控件

procedure SetDFocus(dcon: TDControl);
begin
  FocusedControl := dcon;
  if dcon.FKeyFocus then
    SetDKocus(dcon);
end;

procedure ReleaseDFocus;
begin
  FocusedControl := nil;
end;

procedure SetDCapture(dcon: TDControl);
begin
  SetCapture(MainWinHandle);
  MouseCaptureControl := dcon;
end;

procedure ReleaseDCapture;
begin
  ReleaseCapture;
  MouseCaptureControl := nil;
end;

{----------------------------- TDControl -------------------------------}

constructor TDControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DParent := nil;
  inherited Visible := FALSE;
  FMouseFocus := True;
  FOnVisible := nil;
  FEnabled := True;

  FSurface := nil;
  FAppendData := nil;
  AppendTick := GetTickCount;
  //FEnabled := True;
  //FEnableFocus := False;
  FKeyFocus := False;
  Background := FALSE;

  FOnDirectPaint := nil;
  FOnEndDirectPaint := nil;
  FOnKeyPress := nil;
  FOnKeyDown := nil;
  FOnMouseMove := nil;
  FOnMouseDown := nil;
  FOnMouseUp := nil;
  FOnInRealArea := nil;
  DControls := TList.Create;
  DTabControls := TList.Create;
  FDParent := nil;

  Width := 80;
  Height := 24;
  FCaption := '';
  FVisible := TRUE;
  FIsHide := False;
  //FaceSurface := nil;
  WLib := nil;
  FaceIndex := 0;

  FMouseEntry := msOut;
  FOnEnter := nil;
  FOnLeave := nil;

  FTabDControl := nil;

  FDFColor := $C5D2BD;
  FDFMoveColor := $C5D2BD;
  FDFEnabledColor := $C5D2BD;
  FDFDownColor := clWhite;
  FDFBackColor := $8;
end;

destructor TDControl.Destroy;
begin
  DControls.Free;
  DTabControls.Free;
  if FSurface <> nil then
    FSurface.Free;
  inherited Destroy;
end;

procedure TDControl.SetCaption(str: string);
begin
  FCaption := str;
  FChangeCaption := True;
  if csDesigning in ComponentState then begin
    Refresh;
  end;
end;

procedure TDControl.SetFocus;
begin
  SetDFocus(Self);
end;

procedure TDControl.Paint;
begin
  if csDesigning in ComponentState then begin
    if self is TDWindow then begin
      with Canvas do begin
        Pen.Color := clBlack;
        MoveTo(0, 0);
        LineTo(Width - 1, 0);
        LineTo(Width - 1, Height - 1);
        LineTo(0, Height - 1);
        LineTo(0, 0);
        LineTo(Width - 1, Height - 1);
        MoveTo(Width - 1, 0);
        LineTo(0, Height - 1);
        TextOut((Width - TextWidth(Caption)) div 2, (Height -
          TextHeight(Caption)) div 2, Caption);
      end;
    end
    else begin
      with Canvas do begin
        Pen.Color := clBlack;
        MoveTo(0, 0);
        LineTo(Width - 1, 0);
        LineTo(Width - 1, Height - 1);
        LineTo(0, Height - 1);
        LineTo(0, 0);
        SetBkMode(Handle, TRANSPARENT);
        Font.Color := self.Font.Color;
        TextOut((Width - TextWidth(Caption)) div 2, (Height -
          TextHeight(Caption)) div 2, Caption);
      end;
    end;
  end;
end;

procedure TDControl.Leave();
begin
  if Assigned(FOnLeave) then
    FOnLeave(Self);
end;

procedure TDControl.Loaded;
var
  i: integer;
  dcon: TDControl;
begin
  if not (csDesigning in ComponentState) then begin
    if Parent <> nil then
      for i := 0 to TControl(Parent).ComponentCount - 1 do begin
        if TControl(Parent).Components[i] is TDControl then begin
          dcon := TDControl(TControl(Parent).Components[i]);
          if dcon.DParent = self then begin
            AddChild(dcon);
          end;
        end;
      end;
  end;
end;

//瘤开 谅钎甫 傈眉 谅钎肺 官厕

function TDControl.SurfaceX(x: integer): integer;
var
  d: TDControl;
begin
  d := self;
  while TRUE do begin
    if d.DParent = nil then
      break;
    x := x + d.DParent.Left;
    d := d.DParent;
  end;
  Result := x;
end;

function TDControl.SurfaceY(y: integer): integer;
var
  d: TDControl;
begin
  d := self;
  while TRUE do begin
    if d.DParent = nil then
      break;
    y := y + d.DParent.Top;
    d := d.DParent;
  end;
  Result := y;
end;

//傈眉谅钎甫 按眉狼 谅钎肺 官厕

function TDControl.LocalX(x: integer): integer;
var
  d: TDControl;
begin
  d := self;
  while TRUE do begin
    if d.DParent = nil then
      break;
    x := x - d.DParent.Left;
    d := d.DParent;
  end;
  Result := x;
end;

function TDControl.LocalY(y: integer): integer;
var
  d: TDControl;
begin
  d := self;
  while TRUE do begin
    if d.DParent = nil then
      break;
    y := y - d.DParent.Top;
    d := d.DParent;
  end;
  Result := y;
end;

procedure TDControl.AddChild(dcon: TDControl);
begin
  DControls.Add(Pointer(dcon));
  if dcon is TDEdit then begin
    DTabControls.Add(Pointer(dcon));
  end;
  {else if dcon is TDHooKKey then begin
    DTabControls.Add(Pointer(dcon));
  end; }
end;

procedure TDControl.ChangeChildOrder(dcon: TDControl);
var
  i: integer;
  DWindow: TDWindow;
begin
  if not (dcon is TDWindow) then exit;
  DWindow := TDWindow(dcon);
  if DWindow.FControlStyle = dsBottom then exit;
  for i := 0 to DControls.Count - 1 do begin
    if dcon = DControls[i] then begin
      DControls.Delete(i);
      break;
    end;
  end;
  if DWindow.FControlStyle = dsTop then begin
    DControls.Add(dcon);
    exit;
  end else
  if DWindow.FControlStyle = dsNone then begin
    for i := DControls.Count - 1 downto 0 do begin
      if TDControl(DControls[i]) is TDWindow then begin
        DWindow := TDWindow(DControls[i]);
        if DWindow.FControlStyle <> dsTop then begin
          if i = (DControls.Count - 1) then DControls.Add(dcon)
          else begin
            DControls.Insert(i + 1, dcon);
          end;
          exit;
        end;
      end;
    end;
  end;
  DControls.Add(dcon);
end;

function TDControl.CheckTab: Boolean;
var
  TabControl, TopControl: TDControl;
  I: Integer;
  boMy: Boolean;
begin
  boMy := False;
  Result := False;
  TopControl := nil;
  if DParent = nil then
    exit;
  for I := 0 to DParent.DTabControls.Count - 1 do begin
    TabControl := TDControl(DParent.DTabControls.Items[I]);
    if (TopControl = nil) and (TabControl.Visible) then
      TopControl := TabControl;
    if not boMy then begin
      if TabControl = self then
        boMy := True;
    end
    else begin
      if TabControl.Visible then begin
        TabControl.SetFocus;
        exit;
      end;
    end;
  end;
  if TopControl <> nil then
    TopControl.SetFocus;

end;

function TDControl.InRange(x, y: integer): Boolean;
var
  boinrange: Boolean;
  d: TDirectDrawSurface;
begin
  if (FEnabled) and (x >= Left) and (x < Left + Width) and (y >= Top) and (y < Top + Height) then begin
    boinrange := TRUE;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(self, x - Left, y - Top, boinrange)
    else if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        if d.Pixels[x - Left, y - Top] <= 0 then
          boinrange := FALSE;
    end;
    Result := boinrange;
  end
  else
    Result := FALSE;
end;

procedure TDControl.IsVisible(flag: Boolean);
var
  I: Integer;
begin
  for i := 0 to DControls.Count - 1 do
    TDControl(DControls[i]).IsVisible(flag);
  FIsHide := not flag;
  if Assigned(FOnVisible) then
    FOnVisible(Self, flag);
end;

function TDControl.KeyPress(var Key: Char): Boolean;
begin
  Result := FALSE;
  { if Background then
     exit;
   for i := DControls.Count - 1 downto 0 do
     if TDControl(DControls[i]).Visible then
       if TDControl(DControls[i]).KeyPress(Key) then begin
         Result := TRUE;
         exit;
       end;    }
  if (KeyControl = self) then begin
    if Assigned(FOnKeyPress) then
      FOnKeyPress(self, Key);
    Result := TRUE;
  end;
end;

function TDControl.KeyUp(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := FALSE;
  {if Background then
    exit;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).KeyUp(Key, Shift) then begin
        Result := TRUE;
        exit;
      end;   }
  if (KeyControl = self) then begin
    if Assigned(FOnKeyUp) then
      FOnKeyUp(self, Key, Shift);
    Result := TRUE;
  end;
end;

function TDControl.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := FALSE;
  {if Background then
    exit;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).KeyDown(Key, Shift) then begin
        Result := TRUE;
        exit;
      end;   }
  if (KeyControl = self) then begin
    if Assigned(FOnKeyDown) then
      FOnKeyDown(self, Key, Shift);
    Result := TRUE;
  end;
end;

function TDControl.CanFocusMsg: Boolean;
begin
  if (MouseCaptureControl = nil) or ((MouseCaptureControl <> nil) and
    ((MouseCaptureControl = self) or (MouseCaptureControl = DParent))) then
    Result := TRUE
  else
    Result := FALSE;
end;

function TDControl.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).MouseMove(Shift, X - Left, Y - Top) then begin
        Result := TRUE;
        exit;
      end;

  if (MouseCaptureControl <> nil) then begin
    if (MouseCaptureControl = self) then begin
      if Assigned(FOnMouseMove) then
        FOnMouseMove(self, Shift, X, Y);
      Result := TRUE;
    end;
    exit;
  end;

  if Background then begin
    if (MouseEntryControl <> nil) and (MouseEntryControl <> self) then begin
      MouseEntryControl.FMouseEntry := msOut;
      if Assigned(MouseEntryControl.FOnMouseEntry) then
        MouseEntryControl.FOnMouseEntry(MouseEntryControl,
          MouseEntryControl.FMouseEntry);
      MouseEntryControl := nil;
    end;
    if (MouseEntryControl = nil) then begin
      MouseEntryControl := Self;
      FMouseEntry := msIn;
      if Assigned(FOnMouseEntry) then
        FOnMouseEntry(Self, FMouseEntry);
    end;
    exit;
  end;
  if InRange(X, Y) then begin
    if (MouseEntryControl <> nil) and (MouseEntryControl <> self) then begin
      MouseEntryControl.FMouseEntry := msOut;
      if Assigned(MouseEntryControl.FOnMouseEntry) then
        MouseEntryControl.FOnMouseEntry(MouseEntryControl,
          MouseEntryControl.FMouseEntry);
      MouseEntryControl := nil;
    end;
    if (MouseEntryControl = nil) then begin
      MouseEntryControl := Self;
      FMouseEntry := msIn;
      if Assigned(FOnMouseEntry) then
        FOnMouseEntry(MouseEntryControl, FMouseEntry);
    end;
    if Assigned(FOnMouseMove) then
      FOnMouseMove(self, Shift, X, Y);
    Result := TRUE;
  end;
end;

function TDControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).MouseDown(Button, Shift, X - Left, Y - Top) then begin
        Result := TRUE;
        exit;
      end;
  if Background then begin
    if Assigned(FOnBackgroundClick) then begin
      WantReturn := FALSE;
      FOnBackgroundClick(self);
      if WantReturn then
        Result := TRUE;
    end;
    ReleaseDFocus;
    exit;
  end;
  if CanFocusMsg then begin
    if InRange(X, Y) or (MouseCaptureControl = self) then begin
      if Assigned(FOnMouseDown) then
        FOnMouseDown(self, Button, Shift, X, Y);
      if FMouseFocus {and FEnableFocus} then
        SetDFocus(self);
      //else ReleaseDFocus;
      Result := TRUE;
    end;
  end;
end;

function TDControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).MouseUp(Button, Shift, X - Left, Y - Top) then begin
        Result := TRUE;
        exit;
      end;

  if (MouseCaptureControl <> nil) then begin
    if (MouseCaptureControl = self) then begin
      if Assigned(FOnMouseUp) then
        FOnMouseUp(self, Button, Shift, X, Y);
      Result := TRUE;
    end;
    exit;
  end;

  if Background then
    exit;
  if InRange(X, Y) then begin
    if Assigned(FOnMouseUp) then
      FOnMouseUp(self, Button, Shift, X, Y);
    Result := TRUE;
  end;
end;

function TDControl.DblClick(X, Y: integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if (MouseCaptureControl <> nil) then begin //MouseCapture 捞搁 磊脚捞 快急
    if (MouseCaptureControl = self) then begin
      if Assigned(FOnDblClick) then
        FOnDblClick(self);
      Result := TRUE;
    end;
    exit;
  end;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).DblClick(X - Left, Y - Top) then begin
        Result := TRUE;
        exit;
      end;
  if Background then
    exit;
  if InRange(X, Y) then begin
    if Assigned(FOnDblClick) then
      FOnDblClick(self);
    Result := TRUE;
  end;
end;

function TDControl.Click(X, Y: integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if (MouseCaptureControl <> nil) then begin //MouseCapture 捞搁 磊脚捞 快急
    if (MouseCaptureControl = self) then begin
      if Assigned(FOnClick) then
        FOnClick(self, X, Y);
      Result := TRUE;
    end;
    exit;
  end;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).Click(X - Left, Y - Top) then begin
        Result := TRUE;
        exit;
      end;
  if Background then
    exit;
  if InRange(X, Y) then begin
    if Assigned(FOnClick) then
      FOnClick(self, X, Y);
    Result := TRUE;
  end;
end;

procedure TDControl.CloseSurface;
var
  i: integer;
begin
  for i := DControls.Count - 1 downto 0 do
    TDControl(DControls[i]).CloseSurface();

  if FSurface <> nil then begin
    FSurface.Free;
    FSurface := nil;
  end;
end;

procedure TDControl.SetImgIndex(Lib: TWMImages; index: integer);
var
  d: TDirectDrawSurface;
begin
  //FaceSurface := dsurface;
  if Lib <> nil then begin
    d := Lib.Images[index];
    WLib := Lib;
    FaceIndex := index;
    if d <> nil then begin
      Width := d.Width;
      Height := d.Height;
    end;
  end;
end;

procedure TDControl.SetSurface(DDraw: TDirectDraw; Lib: TWMImages; index:
  integer);
var
  d: TDirectDrawSurface;
begin
  if FSurface <> nil then
    FSurface.Free;
  FSurface := nil;
  if DDraw <> nil then begin
    if Lib <> nil then begin
      d := Lib.Images[index];
      if d <> nil then begin
        FSurface := TDirectDrawSurface.Create(DDraw);
        FSurface.SystemMemory := True;
        FSurface.Canvas.Font.Name := DEF_FONT_NAME;
        FSurface.Canvas.Font.Size := DEFFONTSIZE;
        FSurface.SetSize(d.Width, d.Height);
        FSurface.Draw(0, 0, d.ClientRect, d, True);
      end;
    end
    else begin
      FSurface := TDirectDrawSurface.Create(DDraw);
      FSurface.SystemMemory := True;
      FSurface.Canvas.Font.Name := DEF_FONT_NAME;
      FSurface.Canvas.Font.Size := DEFFONTSIZE;
      FSurface.SetSize(Width, Height);
      FSurface.Fill(0);
    end;
  end;
end;

procedure TDControl.SetVisible(flag: Boolean);
begin
  if FVisible <> flag then
    IsVisible(flag);
  FVisible := flag;
end;

procedure TDControl.DirectPaint(dsurface: TDirectDrawSurface);
var
  i: integer;
  d: TDirectDrawSurface;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(self, dsurface)
  else if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end;
  for i := 0 to DControls.Count - 1 do
    if TDControl(DControls[i]).Visible then
      TDControl(DControls[i]).DirectPaint(dsurface);

  if Assigned(FOnEndDirectPaint) then
    FOnEndDirectPaint(self, dsurface);
end;

procedure TDControl.Enter();
begin
  if Assigned(FOnEnter) then
    FOnEnter(Self)
end;

{--------------------- TDButton --------------------------}

constructor TDButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Downed := FALSE;
  FOnClick := nil;
  //FEnabled := True;
  //FEnableFocus := TRUE;
  FClickSound := csNone;
end;

function TDButton.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove(Shift, X, Y);
    if MouseCaptureControl = self then
      if InRange(X, Y) then
        Downed := TRUE
      else
        Downed := FALSE;
  end;
end;

procedure TDButton.DirectPaint(dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  FColor: TColor;
  i: integer;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(self, dsurface)
  else if WLib <> nil then begin
    if not FEnabled then begin
      d := WLib.Images[FaceIndex + 3];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      FColor := FDFEnabledColor;
    end
    else if Downed then begin
      d := WLib.Images[FaceIndex + 2];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      FColor := FDFDownColor;
    end
    else if MouseEntry = msIn then begin
      d := WLib.Images[FaceIndex + 1];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      FColor := FDFMoveColor;
    end
    else begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      FColor := FDFColor;
    end;
    with dsurface.Canvas do begin
      SetBkMode(Handle, TRANSPARENT);
      BoldTextOutEx(dsurface, SurfaceX(Left) + (Width - TextWidth(Caption)) div 2,
        SurfaceY(Top) + (Height - TextHeight(Caption)) div 2, FColor, FDFBackColor, Caption);
      Release;
    end;
  end;
  for i := 0 to DControls.Count - 1 do
    if TDControl(DControls[i]).Visible then
      TDControl(DControls[i]).DirectPaint(dsurface);
  if Assigned(FOnEndDirectPaint) then
    FOnEndDirectPaint(self, dsurface);
end;

function TDButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      Downed := TRUE;
      SetDCapture(self);
    end;
    Result := TRUE;
  end;
end;

function TDButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) then begin
        if Assigned(FOnClickSound) then
          FOnClickSound(self, FClickSound);
        if Assigned(FOnClick) then
          FOnClick(self, X, Y);
      end;
    end;
    Downed := FALSE;
    Result := TRUE;
    exit;
  end
  else begin
    ReleaseDCapture;
    Downed := FALSE;
  end;
end;

{------------------------- TDGrid --------------------------}

constructor TDGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColCount := 8;
  FRowCount := 5;
  FColWidth := 36;
  FRowHeight := 32;
  FOnGridSelect := nil;
  FOnGridMouseMove := nil;
  FOnGridPaint := nil;
  FColoffset := 0;
  FRowoffset := 0;
end;

function TDGrid.GetColRow(x, y: integer; var acol, arow: integer): Boolean;
var
  nX, nY: Integer;
begin
  Result := FALSE;
  if InRange(x, y) then begin
    nX := x - Left;
    nY := y - Top;
    acol := nX div (FColWidth + FColoffset);
    arow := nY div (FRowHeight + FRowoffset);
    if (nX - (FColWidth + FColoffset) * (acol) - FColWidth <= 0) and
      (nY - (FRowHeight + FRowoffset) * (arow) - FRowHeight <= 0) then
      Result := TRUE;
  end;
end;

function TDGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer): Boolean;
var
  acol, arow: integer;
begin
  Result := FALSE;
  if mbLeft = Button then begin
    if GetColRow(X, Y, acol, arow) then begin
      SelectCell.X := acol;
      SelectCell.Y := arow;
      DownPos.X := X;
      DownPos.Y := Y;
      SetDCapture(self);
      Result := TRUE;
    end;
  end;
end;

function TDGrid.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  acol, arow: integer;
begin
  Result := FALSE;
  if InRange(X, Y) then begin
    if GetColRow(X, Y, acol, arow) then begin
      if Assigned(FOnGridMouseMove) then
        FOnGridMouseMove(self, acol, arow, Shift);
    end;
    Result := TRUE;
  end;
end;

function TDGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer): Boolean;
var
  acol, arow: integer;
begin
  Result := FALSE;
  if mbLeft = Button then begin
    if GetColRow(X, Y, acol, arow) then begin
      if (SelectCell.X = acol) and (SelectCell.Y = arow) then begin
        Col := acol;
        Row := arow;
        if Assigned(FOnGridSelect) then
          FOnGridSelect(self, acol, arow, Shift);
      end;
      Result := TRUE;
    end;
    ReleaseDCapture;
  end;
end;

function TDGrid.Click(X, Y: integer): Boolean;
begin
  Result := FALSE;
  { if GetColRow (X, Y, acol, arow) then begin
      if Assigned (FOnGridSelect) then
         FOnGridSelect (self, acol, arow, []);
      Result := TRUE;
   end; }
end;

procedure TDGrid.DirectPaint(dsurface: TDirectDrawSurface);
var
  i, j: integer;
  rc: TRect;
begin
  if Assigned(FOnGridPaint) then
    for i := 0 to FRowCount - 1 do
      for j := 0 to FColCount - 1 do begin
        rc.Top := Top + i * FRowHeight + i * FRowoffset;
        rc.Left := Left + j * FColWidth + j * FColoffset;
        rc.Right := rc.Left + FColWidth;
        rc.Bottom := rc.Top + FRowHeight;
        {rc := Rect(Left + j * FColWidth + j * FColoffset,
          Top + i * FRowHeight + i * FRowoffset,
          Left + j * FColWidth + j * FColoffset + FColWidth,
          Top + i * FRowHeight + i * FRowoffset + FRowHeight);  }
        if (SelectCell.Y = i) and (SelectCell.X = j) then
          FOnGridPaint(self, j, i, rc, [gdSelected], dsurface)
        else
          FOnGridPaint(self, j, i, rc, [], dsurface);
      end;
end;

{--------------------- TDWindown --------------------------}

constructor TDWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFloating := FALSE;
  //FEnabled := True;
  //FEnableFocus := TRUE;
  Width := 120;
  Height := 120;
  FControlStyle := dsNone;
end;

procedure TDWindow.SetVisible(flag: Boolean);
begin
  if FVisible <> flag then
    IsVisible(flag);
  FVisible := flag;
  //if Floating then begin
  if DParent <> nil then
    DParent.ChangeChildOrder(self);
  //end;
end;

function TDWindow.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  al, at: integer;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if Result and FFloating and (MouseCaptureControl = self) then begin
    if (SpotX <> X) or (SpotY <> Y) then begin
      al := Left + (X - SpotX);
      at := Top + (Y - SpotY);
      if al + Width < WINLEFT then
        al := WINLEFT - Width;
      if al > WINRIGHT then
        al := WINRIGHT;
      if at + Height < WINTOP then
        at := WINTOP - Height;
      if at {+ Height} > BOTTOMEDGE then
        at := BOTTOMEDGE { - Height};
      Left := al;
      Top := at;
      SpotX := X;
      SpotY := Y;
    end;
  end;
end;

procedure TDWindow.DirectPaint(dsurface: TDirectDrawSurface);
var
  i: integer;
  d: TDirectDrawSurface;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(self, dsurface)
  else if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end;
  for i := 0 to DControls.Count - 1 do
    if TDControl(DControls[i]).Visible then
      TDControl(DControls[i]).DirectPaint(dsurface);
      
  if Assigned(FOnEndDirectPaint) then
    FOnEndDirectPaint(self, dsurface);
end;

function TDWindow.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer): Boolean;
begin
  Result := inherited MouseDown(Button, Shift, X, Y);
  if Result then begin
    //if Floating then begin
    if DParent <> nil then
      DParent.ChangeChildOrder(self);
    //end;
    SpotX := X;
    SpotY := Y;
  end;
end;

function TDWindow.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer): Boolean;
begin
  Result := inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDWindow.Show;
begin
  Visible := TRUE;
  //if Floating then begin
  if DParent <> nil then
    DParent.ChangeChildOrder(self);
  //end;
  if FMouseFocus {and FEnableFocus} then
    SetDFocus(self);
end;

function TDWindow.ShowModal: integer;
begin
  Result := 0; //Jacky
  Visible := TRUE;
  ModalDWindow := self;
  if FMouseFocus {and FEnableFocus} then
    SetDFocus(self);
end;

{--------------------- TDWinManager --------------------------}

constructor TDWinManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DWinList := TList.Create;
  MouseCaptureControl := nil;
  FocusedControl := nil;
  KeyControl := nil;
  MouseEntryControl := nil;
  ModalDWindow := nil;
end;

destructor TDWinManager.Destroy;
begin
  inherited Destroy;
end;

procedure TDWinManager.ClearAll;
begin
  DWinList.Clear;
end;

procedure TDWinManager.AddDControl(dcon: TDControl; visible: Boolean);
begin
  dcon.Visible := visible;
  DWinList.Add(dcon);
end;

procedure TDWinManager.DelDControl(dcon: TDControl);
var
  i: integer;
begin
  for i := 0 to DWinList.Count - 1 do
    if DWinList[i] = dcon then begin
      DWinList.Delete(i);
      break;
    end;
end;

function TDWinManager.KeyPress(var Key: Char): Boolean;
begin
  Result := FALSE;
  //自动切换可选组件
  if Key = #9 then begin
    if KeyControl <> nil then begin
      if KeyControl.Visible and KeyControl.Enabled and (not KeyControl.IsHide) then begin
        if KeyControl.CheckTab then begin

        end;
      end
      else
        ReleaseDKocus;
    end;
  end;
  if KeyControl <> nil then begin
    if KeyControl.Visible and KeyControl.Enabled and (not KeyControl.IsHide) then
      Result := KeyControl.KeyPress(Key)
    else
      ReleaseDKocus;
  end;
  {if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := KeyPress(Key);
      exit;
    end
    else
      ModalDWindow := nil;
    Key := #0;
    //ModalDWindow啊 KeyDown阑 芭摹搁辑 Visible=false肺 函窍搁辑
  //KeyPress甫 促矫芭媚辑 ModalDwindow=nil捞 等促.
  end;    }

  {if FocusedControl <> nil then begin
    if FocusedControl.Visible then begin
      Result := FocusedControl.KeyPress(Key);
    end
    else
      ReleaseDFocus;
  end;    }
  {for i:=0 to DWinList.Count-1 do begin
     if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).KeyPress (Key) then begin
           Result := TRUE;
           break;
        end;
     end;
  end; }
end;

function TDWinManager.KeyUp(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := FALSE;
  if KeyControl <> nil then begin
    if KeyControl.Visible and KeyControl.Enabled and (not KeyControl.IsHide) then
      Result := KeyControl.KeyUp(Key, Shift)
    else
      ReleaseDKocus;
  end;
  { if ModalDWindow <> nil then begin
     if ModalDWindow.Visible then begin
       with ModalDWindow do
         Result := KeyUp(Key, Shift);
       exit;
     end
     else
       MOdalDWindow := nil;
   end;
   if FocusedControl <> nil then begin
     if FocusedControl.Visible then
       Result := FocusedControl.KeyUp(Key, Shift)
     else
       ReleaseDFocus;
   end;  }
end;

function TDWinManager.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := FALSE;
  if KeyControl <> nil then begin
    if KeyControl.Visible and KeyControl.Enabled and (not KeyControl.IsHide) then
      Result := KeyControl.KeyDown(Key, Shift)
    else
      ReleaseDKocus;
  end;
  {if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := KeyDown(Key, Shift);
      exit;
    end
    else
      MOdalDWindow := nil;
  end;
  if FocusedControl <> nil then begin
    if FocusedControl.Visible then
      Result := FocusedControl.KeyDown(Key, Shift)
    else
      ReleaseDFocus;
  end;       }
  {for i:=0 to DWinList.Count-1 do begin
     if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).KeyDown (Key, Shift) then begin
           Result := TRUE;
           break;
        end;
     end;
  end; }
end;

function TDWinManager.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;

  if PopUpDWindow <> nil then begin
    if PopUpDWindow.Visible then begin
      with PopUpDWindow do
        Result := MouseMove(Shift, LocalX(X), LocalY(Y));
    end
    else
      PopUpDWindow := nil;
    if Result then
      Exit;
  end;

  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        MouseMove(Shift, LocalX(X), LocalY(Y));
      Result := TRUE;
      exit;
    end
    else
      MOdalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := MouseMove(Shift, LocalX(X), LocalY(Y));
  end
  else
    for i := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).MouseMove(Shift, X, Y) then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
end;

function TDWinManager.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  if PopUpDWindow <> nil then begin
    if PopUpDWindow.Visible then begin
      with PopUpDWindow do
        Result := MouseDown(Button, Shift, LocalX(X), LocalY(Y));
    end;
    if not Result then begin
      PopUpDWindow.Visible := False;
      PopUpDWindow := nil;
    end
    else
      exit;
  end;

  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        MouseDown(Button, Shift, LocalX(X), LocalY(Y));
      Result := TRUE;
      exit;
    end
    else
      ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := MouseDown(Button, Shift, LocalX(X), LocalY(Y));
  end
  else
    for i := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).MouseDown(Button, Shift, X, Y) then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
end;

function TDWinManager.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer): Boolean;
var
  i: integer;
begin
  Result := TRUE;

  if PopUpDWindow <> nil then begin
    if PopUpDWindow.Visible then begin
      with PopUpDWindow do
        Result := MouseUp(Button, Shift, LocalX(X), LocalY(Y));
      if Result then
        exit;
    end
    else
      PopUpDWindow := nil;
  end;

  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := MouseUp(Button, Shift, LocalX(X), LocalY(Y));
      exit;
    end
    else
      ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := MouseUp(Button, Shift, LocalX(X), LocalY(Y));
  end
  else
    for i := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).MouseUp(Button, Shift, X, Y) then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
end;

function TDWinManager.DblClick(X, Y: integer): Boolean;
var
  i: integer;
begin
  Result := TRUE;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := DblClick(LocalX(X), LocalY(Y));
      exit;
    end
    else
      ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := DblClick(LocalX(X), LocalY(Y));
  end
  else
    for i := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).DblClick(X, Y) then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
end;

function TDWinManager.Click(X, Y: integer): Boolean;
var
  i: integer;
begin
  Result := TRUE;
  if ModalDWindow <> nil then begin
    if ModalDWindow.Visible then begin
      with ModalDWindow do
        Result := Click(LocalX(X), LocalY(Y));
      exit;
    end
    else
      ModalDWindow := nil;
  end;
  if MouseCaptureControl <> nil then begin
    with MouseCaptureControl do
      Result := Click(LocalX(X), LocalY(Y));
  end
  else
    for i := 0 to DWinList.Count - 1 do begin
      if TDControl(DWinList[i]).Visible then begin
        if TDControl(DWinList[i]).Click(X, Y) then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
end;

procedure TDWinManager.CloseSurface;
var
  i: integer;
begin
  for i := 0 to DWinList.Count - 1 do
    TDControl(DWinList[i]).CloseSurface();
end;

procedure TDWinManager.DirectPaint(dsurface: TDirectDrawSurface);
var
  i: integer;
  boVisible: Boolean;
begin
  boVisible := False;
  if ModalDWindow <> nil then begin
    boVisible := ModalDWindow.Visible;
    if boVisible then ModalDWindow.Visible := False;
  end;
  for i := 0 to DWinList.Count - 1 do begin
    if TDControl(DWinList[i]).Visible then begin
      TDControl(DWinList[i]).DirectPaint(dsurface);
    end;
  end;
  if ModalDWindow <> nil then begin
    if boVisible then begin
      ModalDWindow.Visible := True;
      with ModalDWindow do
        DirectPaint(dsurface);
    end;
  end;

  if PopUpDWindow <> nil then begin
    if PopUpDWindow.Visible then
      with PopUpDWindow do
        DirectPaint(dsurface);
  end;
end;

{ TDCheckBox }

constructor TDCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  FChecked := False;
  FFontSpace := 3;
  FWidth := 0;
  FHeight := 0;
  FOnClick := nil;
  //FEnabled := True;
  //FEnableFocus := True;
end;

procedure TDCheckBox.DirectPaint(dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  if FChangeCaption then begin
    FWidth := dsurface.Canvas.TextWidth(Caption);
    FHeight := dsurface.Canvas.TextHeight(Caption);
    FChangeCaption := False;
  end;
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(self, dsurface)
  else if WLib <> nil then begin
    if Checked then begin
      d := WLib.Images[FaceIndex + 1];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end
    else begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
    if d <> nil then begin
      with dsurface.Canvas do begin
        SetBkMode(Handle, TRANSPARENT);
        if MouseEntry = msIn then
          BoldTextOut(dsurface,
            SurfaceX(Left) + d.Width + FFontSpace,
            SurfaceY(Top) + d.Height div 2 - FHeight div 2,
            clWhite,
            clBlack,
            Caption)
        else
          BoldTextOut(dsurface,
            SurfaceX(Left) + d.Width + FFontSpace,
            SurfaceY(Top) + d.Height div 2 - FHeight div 2,
            clSilver,
            clBlack,
            Caption);
        Release;
      end;
    end;
  end;
end;

function TDCheckBox.InRange(x, y: integer): Boolean;
var
  boinrange: Boolean;
  nWidth, nHeight: Integer;
begin
  nWidth := FWidth + FFontSpace + Width;
  nHeight := MAX(Height, FHeight);
  if (FEnabled) and (x >= Left) and (x < Left + nWidth) and (y >= Top) and (y <
    Top
    + nHeight) then begin
    boinrange := TRUE;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(self, x - Left, y - Top, boinrange);
    Result := boinrange;
  end
  else
    Result := FALSE;
end;

function TDCheckBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      SetDCapture(self);
    end;
    Result := TRUE;
  end;
end;

function TDCheckBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) then begin
        FChecked := not FChecked;
        if Assigned(FOnClick) then
          FOnClick(self, X, Y);
      end;
    end;
    Result := TRUE;
    exit;
  end
  else begin
    ReleaseDCapture;
  end;
end;

{ TDUpDown }

procedure TDUpDown.ButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  FClickTime := GetTickCount;
  if Sender = FUpButton then begin
    if FPosition > 0 then
      Dec(FPosition);
    FAddTop := Round(FMaxLength / FMaxPosition * FPosition);
    if Assigned(FOnPositionChange) then
      FOnPositionChange(Self);
  end
  else if Sender = FDownButton then begin
    if FPosition < FMaxPosition then
      Inc(FPosition);
    FAddTop := Round(FMaxLength / FMaxPosition * FPosition);
    if Assigned(FOnPositionChange) then
      FOnPositionChange(Self);
  end
  else if Sender = FMoveButton then begin
    StopY := Y;
    FStopY := FAddTop;
  end;
  if Assigned(FOnMouseDown) then
    FOnMouseDown(self, Button, Shift, X, Y);
end;

procedure TDUpDown.ButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y:
  Integer);
var
  nIdx: Integer;
  OldPosition: Integer;
  nY: Integer;
  DButton: TDButton;
begin
  if Sender = FUpButton then begin
    DButton := TDButton(Sender);
    if (DButton.Downed) and ((GetTickCount - FClickTime) > 100) then
      ButtonMouseDown(Sender, mbLeft, Shift, X, Y);
  end
  else if Sender = FDownButton then begin
    DButton := TDButton(Sender);
    if (DButton.Downed) and ((GetTickCount - FClickTime) > 100) then
      ButtonMouseDown(Sender, mbLeft, Shift, X, Y);
  end
  else if Sender = FMoveButton then begin
    if (StopY < 0) or (StopY = y) then
      Exit;

    nY := Y - StopY;
    FAddTop := FStopY + nY;
    if FAddTop < 0 then
      FAddTop := 0;
    if FAddTop > FMaxLength then
      FAddTop := FMaxLength;

    OldPosition := FPosition;
    nIdx := Round(FAddTop / (FMaxLength / FMaxPosition));
    if nIdx <= 0 then
      FPosition := 0
    else if nIdx >= FMaxPosition then
      FPosition := FMaxPosition
    else
      FPosition := nIdx;
    if OldPosition <> FPosition then
      if Assigned(FOnPositionChange) then
        FOnPositionChange(Self);
  end;
  if Assigned(FOnMouseMove) then
    FOnMouseMove(self, Shift, X, Y);
end;

procedure TDUpDown.ButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift:
  TShiftState; X, Y: Integer);
begin
  StopY := -1;
  if Assigned(FOnMouseUp) then
    FOnMouseUp(self, Button, Shift, X, Y);
end;

constructor TDUpDown.Create(AOwner: TComponent);
begin
  inherited;
  FUpButton := TDButton.Create(nil);
  FDownButton := TDButton.Create(nil);
  FMoveButton := TDButton.Create(nil);
  //Enabled := True;
  //EnableFocus := True;
  SetButton(UpButton);
  SetButton(DownButton);
  SetButton(MoveButton);

  FOffset := 1;
  FBoMoveShow := False;

  FPosition := 0;
  FMaxPosition := 0;
  FMaxLength := 0;
  FTop := 0;
  FAddTop := 0;
  StopY := -1;
end;

destructor TDUpDown.Destroy;
begin
  FUpButton.Free;
  FDownButton.Free;
  FMoveButton.Free;
  inherited;
end;

procedure TDUpDown.DirectPaint(dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  dc, rc: TRect;
begin
  if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      dc.Left := SurfaceX(Left);
      dc.Top := SurfaceY(Top);
      dc.Right := SurfaceX(left + Width);
      dc.Bottom := SurfaceY(top + Height);
      rc.Left := 0;
      rc.Top := 0;
      rc.Right := d.ClientRect.Right;
      rc.Bottom := d.ClientRect.Bottom;
      dsurface.StretchDraw(dc, rc, d, True);
    end;
    if FUpButton <> nil then begin
      with FUpButton do begin
        Left := FOffset;
        Top := FOffset;
        if Downed then begin
          d := WLib.Images[FaceIndex + 1 + Integer(FBoMoveShow)];
        end
        else if MouseEntry = msIn then begin
          d := WLib.Images[FaceIndex + Integer(FBoMoveShow)];
        end
        else begin
          d := WLib.Images[FaceIndex];
        end;
        if d <> nil then begin
          FTop := d.Height + Top;
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        end;
      end;
    end;
    if FDownButton <> nil then begin
      with FDownButton do begin
        Left := FOffset;
        if FBoMoveShow then
          Top := Self.Height - d.Height + 1
        else
          Top := Self.Height - d.Height - 1;

        if Downed then begin
          d := WLib.Images[FaceIndex + 1 + Integer(FBoMoveShow)];
        end
        else if MouseEntry = msIn then begin
          d := WLib.Images[FaceIndex + Integer(FBoMoveShow)];
        end
        else begin
          d := WLib.Images[FaceIndex];
        end;
        if d <> nil then begin
          FMaxLength := Top - FTop;
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        end;
      end;
    end;
    if FMoveButton <> nil then begin
      with FMoveButton do begin
        Left := FOffset;
        if FBoMoveShow then begin
          if Downed then begin
            d := WLib.Images[FaceIndex + 2];
          end
          else if MouseEntry = msIn then begin
            d := WLib.Images[FaceIndex + 1];
          end
          else begin
            d := WLib.Images[FaceIndex];
          end;
          if (d <> nil) then begin
            Dec(FMaxLength, d.Height);
            Top := FTop + FAddTop;
            if FMaxPosition > 0 then
              dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d,
                True);
          end;
        end
        else begin
          d := WLib.Images[FaceIndex];
          if d <> nil then begin
            Dec(FMaxLength, d.Height);
            Top := FTop + FAddTop;
            dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
          end;
        end;
      end;
    end;
  end;
end;

procedure TDUpDown.SetButton(Button: TDButton);
begin
  Button.DParent := Self;
  Button.OnMouseMove := ButtonMouseMove;
  Button.OnMouseDown := ButtonMouseDown;
  Button.OnMouseUp := ButtonMouseUp;
  AddChild(Button);
end;

procedure TDUpDown.SetMaxPosition(const Value: Integer);
var
  OldPosition: integer;
begin
  OldPosition := FMaxPosition;
  FMaxPosition := Max(Value, 0);
  if OldPosition <> FMaxPosition then begin
    if FPosition > FMaxPosition then
      FPosition := FMaxPosition;
    if FMaxPosition > 0 then
      FAddTop := Round(FMaxLength / FMaxPosition * FPosition);
  end;
end;

procedure TDUpDown.SetPosition(value: Integer);
var
  OldPosition: integer;
begin
  OldPosition := FPosition;
  FPosition := Max(Value, 0);
  if FPosition > FMaxPosition then
    FPosition := FMaxPosition;
  if OldPosition <> FPosition then begin
    if FMaxPosition > 0 then
      FAddTop := Round(FMaxLength / FMaxPosition * FPosition);
  end;
end;

{ TDHooKKey }

constructor TDHooKKey.Create(AOwner: TComponent);
begin
  inherited;
  FShiftState := [];
  FKey := 0;
  FText := '';
  Color := clBlack;
  FrameColor := clSilver;
  FKeyFocus := True;
  FOnChange := nil;
  //FEnabled := True;
  //FEnableFocus := True;
end;

procedure TDHooKKey.DirectPaint(dsurface: TDirectDrawSurface);
var
  dc, rc: TRect;
  d: TDirectDrawSurface;
  //  ShowStr: string;
  OldColor, OldSize: Integer;
  OldName: string;
begin

  d := nil;
  dc.Left := SurfaceX(Left);
  dc.Top := SurfaceY(Top);
  dc.Right := SurfaceX(left + Width);
  dc.Bottom := SurfaceY(top + Height);
  if WLib <> nil then
    d := WLib.Images[FaceIndex];
  if d <> nil then begin
    rc.Left := 0;
    rc.Top := 0;
    rc.Right := d.ClientRect.Right;
    rc.Bottom := d.ClientRect.Bottom;
    dsurface.StretchDraw(dc, rc, d, FALSE);
  end
  else begin
    dsurface.Canvas.Brush.Color := Color;
    dsurface.Canvas.Pen.Color := FrameColor;
    dsurface.Canvas.Pen.Style := psAlternate;
    dsurface.Canvas.RoundRect(dc.Left, dc.Top, dc.Right, dc.Bottom, 0, 0);
    if (KeyControl = self) then begin
      dc.Left := SurfaceX(Left + 1);
      dc.Top := SurfaceY(Top + 1);
      dc.Right := SurfaceX(left + Width - 1);
      dc.Bottom := SurfaceY(top + Height - 1);
      dsurface.Canvas.RoundRect(dc.Left, dc.Top, dc.Right, dc.Bottom, 0, 0);
    end;
  end;
  with dsurface.Canvas do begin
    if FText <> '' then begin
      SetBkMode(Handle, TRANSPARENT);
      OldColor := Font.Color;
      OldName := Font.Name;
      OldSize := Font.Size;
      try
        Font.Color := self.Font.Color;
        Font.Name := self.Font.Name;
        Font.Size := self.Font.Size;
        dc.Left := SurfaceX(Left + 3);
        dc.Top := SurfaceY(Top);
        dc.Right := SurfaceX(left + Width - 5);
        dc.Bottom := SurfaceY(top + Height);
        TextRect(dc, FText, [tfSingleLine, tfCenter, tfVerticalCenter]);
      finally
        Font.Color := OldColor;
        Font.Name := OldName;
        Font.Size := OldSize;
      end;
    end;
    Release;
  end;
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(self, dsurface)

end;

function TDHooKKey.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := False;
  if (KeyControl = self) then begin
    if Assigned(FOnKeyDown) then
      FOnKeyDown(self, Key, Shift);
    if Key <> 0 then begin
      if (Key = VK_BACK) or (Key = VK_DELETE) then begin
        FShiftState := [];
        FKey := 0;
        Key := 0;
        RefHookKeyStr();
      end
      else begin
        FShiftState := Shift;
        FKey := Key;
        Key := 0;
        RefHookKeyStr();
      end;
      if Assigned(FOnChange) then
        FOnChange(self);
    end;
    Result := True;
  end;
end;

function TDHooKKey.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      SetDCapture(self);
    end;
    Result := TRUE;
  end;
end;

function TDHooKKey.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) then begin
        if Assigned(FOnClick) then
          FOnClick(self, X, Y);
      end;
    end;
    Result := TRUE;
    exit;
  end
  else begin
    ReleaseDCapture;
  end;
end;

procedure TDHooKKey.RefHookKeyStr;
var
  ShowStr: string;
begin
  ShowStr := '';
  if ssCtrl in FShiftState then
    ShowStr := 'Ctrl';

  if ssAlt in FShiftState then
    if ShowStr <> '' then
      ShowStr := ShowStr + '+Alt'
    else
      ShowStr := 'Alt';

  if ssShift in FShiftState then
    if ShowStr <> '' then
      ShowStr := ShowStr + '+Shift'
    else
      ShowStr := 'Shift';

  case FKey of
    VK_F1: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F1'
        else
          ShowStr := 'F1';
      end;
    VK_F2: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F2'
        else
          ShowStr := 'F2';
      end;
    VK_F3: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F3'
        else
          ShowStr := 'F3';
      end;
    VK_F4: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F4'
        else
          ShowStr := 'F4';
      end;
    VK_F5: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F5'
        else
          ShowStr := 'F5';
      end;
    VK_F6: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F6'
        else
          ShowStr := 'F6';
      end;
    VK_F7: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F7'
        else
          ShowStr := 'F7';
      end;
    VK_F8: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F8'
        else
          ShowStr := 'F8';
      end;
    VK_F9: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F9'
        else
          ShowStr := 'F9';
      end;
    VK_F10: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F10'
        else
          ShowStr := 'F10';
      end;
    VK_F11: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F11'
        else
          ShowStr := 'F11';
      end;
    VK_F12: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F12'
        else
          ShowStr := 'F12';
      end;
    VK_TAB: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Tab'
        else
          ShowStr := 'Tab';
      end;
    VK_PAUSE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Pause'
        else
          ShowStr := 'Pause';
      end;
    VK_HOME: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Home'
        else
          ShowStr := 'Home';
      end;
    VK_LEFT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Left'
        else
          ShowStr := 'Left';
      end;
    VK_UP: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Up'
        else
          ShowStr := 'Up';
      end;
    VK_RIGHT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Right'
        else
          ShowStr := 'Right';
      end;
    VK_DOWN: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Down'
        else
          ShowStr := 'Down';
      end;
    VK_SPACE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Space'
        else
          ShowStr := 'Space';
      end;
    VK_CAPITAL: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+CapsLock'
        else
          ShowStr := 'CapsLock';
      end;
    VK_ESCAPE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Esc'
        else
          ShowStr := 'Esc';
      end;
    VK_PRIOR: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Prior'
        else
          ShowStr := 'Prior';
      end;
    VK_NEXT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Next'
        else
          ShowStr := 'Next';
      end;
    VK_END: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+End'
        else
          ShowStr := 'End';
      end;
    VK_SELECT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Select'
        else
          ShowStr := 'Select';
      end;
    VK_PRINT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Print'
        else
          ShowStr := 'Print';
      end;
    VK_EXECUTE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Execute'
        else
          ShowStr := 'Execute';
      end;
    VK_SNAPSHOT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Snapshot'
        else
          ShowStr := 'Snapshot';
      end;
    VK_INSERT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Insert'
        else
          ShowStr := 'Insert';
      end;
    VK_HELP: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Help'
        else
          ShowStr := 'Help';
      end;
    VK_SHIFT,
      VK_CONTROL,
      VK_MENU: begin

      end
  else begin
      if ShowStr <> '' then
        ShowStr := ShowStr + '+' + Char(FKey)
      else
        ShowStr := Char(FKey);
    end;
  end;

  FText := ShowStr;
end;

procedure TDHooKKey.SetKey(Value: Word);
begin
  FKey := Value;
  RefHookKeyStr;
  { if Assigned(FOnChange) then
     FOnChange(self);    }
end;

procedure TDHooKKey.SetShiftState(Value: TShiftState);
begin
  FShiftState := Value;
  RefHookKeyStr;
  {if Assigned(FOnChange) then
    FOnChange(self);    }
end;

{ TDEdit }

function TDEdit.ClearKey: Boolean;
begin
  Result := False;
  if (FStartX > -1) and (FStopX > -1) and (FStartX <> FStopX) then begin
    if FStartX > FStopX then begin
      Delete(FEditString, FStopX, FStartX - FStopX);
      FCaretPos := FStopX;
    end
    else begin
      Delete(FEditString, FStartX, FStopX - FStartX);
      FCaretPos := FStartX;
    end;
    if FCaretPos < FCaretStart then
      FCaretStart := FCaretPos;
    FStartX := -1;
    FStopX := -1;
    FCursor := deLeft;
    Result := True;
  end;
  FStartX := -1;
  FStopX := -1;
end;

//当不允许输入中文汉字时自动关闭输入法

function TDEdit.CloseIME: Boolean;
var
  hklKeyboardLayout: LongWord;
begin
  Result := False;
  if (FPasswordChar <> #0) or (FEditClass = deInteger) or (FEditClass = deMonoCase) then begin
    Result := True;
    hklKeyboardLayout := GetKeyboardLayout(0);
    if ImmIsIME(hklKeyboardLayout) then
      ImmSimulateHotKey(FrmMainWinHandle, IME_CHotKey_IME_NonIME_Toggle);
  end;
end;

constructor TDEdit.Create(AOwner: TComponent);
begin
  inherited;
  FOnChange := nil;
  //Enabled := True;
  //EnableFocus := True;
  FKeyFocus := True;
  FCaretShowTime := GetTickCount;
  FrameColor := clSilver;
  FMaxLength := 0;
  FEditClass := deNone;
  FInputStr := '';
  bDoubleByte := False;
  KeyByteCount := 0;
  FCaretPos := 1;
  FCaretStart := 1;
  FCaretStop := 1;
  FPasswordChar := #0;
  FCursor := deLeft;
  FStartX := -1;
  FStopX := -1;
  FIndent := 2;
  FCloseSpace := False;
  Color := clBlack;
  Font.Name := DEF_FONT_NAME;
  Font.Color := clWhite;
  Font.Size := DEFFONTSIZE;
  Canvas.Font.Name := Font.Name;
  Canvas.Font.Color := Font.Color;
  Canvas.Font.Size := Font.Size;
  FDFColor := clWhite;
end;

destructor TDEdit.Destroy;
begin
  inherited;
end;

procedure TDEdit.DirectPaint(dsurface: TDirectDrawSurface);
var
  dc, {rc, }fDc: TRect;
  nLeft: integer;
  //d: TDirectDrawSurface;
  ShowStr: string;
  StopX, StartX, CaretIdx: Integer;
  OldColor, OldSize: Integer;
  OldName: string;
  boLeft: byte;
begin
//  d := nil;
  dc.Left := SurfaceX(Left);
  dc.Top := SurfaceY(Top);
  dc.Right := SurfaceX(left + Width);
  dc.Bottom := SurfaceY(top + Height);
  {
    //画EDIT外框
    dsurface.Canvas.Brush.Color := Color;
    dsurface.Canvas.Pen.Color := FrameColor;
    dsurface.Canvas.Pen.Style := psAlternate;
    dsurface.Canvas.RoundRect(dc.Left, dc.Top, dc.Right, dc.Bottom, 0, 0);
     }
  if (GetTickCount - FCaretShowTime) > 500 then begin //光标闪动间隔时间
    FCaretShowTime := GetTickCount;
    FCaretShow := not FCaretShow;
  end;
  nLeft := 0;
  boLeft := 0;
  with dsurface.Canvas do begin
    if FEditString <> '' then begin
      Canvas.Font.Name := self.Font.Name;
      Canvas.Font.Color := self.Font.Color;
      Canvas.Font.Size := self.Font.Size;
      if (FStartX <> FStopX) and (FStopX >= 0) and (FStartX >= 0) then begin
        StopX := FStopX;
        StartX := FStartX;
        CaretIdx := FCaretStart;
        SetBkMode(Handle, TRANSPARENT);
        Brush.Color := clBlue;
        if Height < 16 then begin
          dc.Top := SurfaceY(Top);
          dc.Bottom := SurfaceY(top + Height);
        end
        else begin
          dc.Top := SurfaceY(Top + FIndent);
          dc.Bottom := SurfaceY(top + Height - FIndent);
        end;
        if StartX > StopX then begin
          StartX := FStopX;
          StopX := FStartX;
          boLeft := 1;
        end;
        if StartX < CaretIdx then begin
          dc.Left := SurfaceX(Left + FIndent);
          ShowStr := Copy(FEditString, CaretIdx, StopX - CaretIdx);
          dc.Right := dc.Left + Canvas.TextWidth(ShowStr);
          boLeft := 2;
        end
        else begin

          if FCaretStart > 0 then begin
            ShowStr := Copy(FEditString, CaretIdx, StartX - CaretIdx);
            dc.Left := SurfaceX(Left + FIndent) + Canvas.TextWidth(ShowStr);
            //boLeft := 1;
          end
          else begin
            ShowStr := Copy(FEditString, CaretIdx, StartX - CaretIdx);
            dc.Left := SurfaceX(Left + FIndent) + Canvas.TextWidth(ShowStr);
            //boLeft := 2;
          end;
          ShowStr := Copy(FEditString, StartX, StopX - StartX);
          dc.Right := dc.Left + Canvas.TextWidth(ShowStr);
        end;
        dc.Right := MIN(dc.Right, SurfaceX(Left + Width - FIndent * 2));
        FillRect(dc);
        fDc := dc;
        Brush.Style := bsClear;
      end;
      SetBkMode(Handle, TRANSPARENT);
      OldColor := Font.Color;
      OldName := Font.Name;
      OldSize := Font.Size;
      try
        Font.Color := self.Font.Color;
        Font.Name := self.Font.Name;
        Font.Size := self.Font.Size;
        dc.Left := SurfaceX(Left + FIndent);
        dc.Top := SurfaceY(Top);
        dc.Right := SurfaceX(left + Width - FIndent * 2);
        dc.Bottom := SurfaceY(top + Height);
        if FCursor = deLeft then begin
          ShowStr := Copy(FEditString, FCaretStart, Length(FEditString));
          ShowStr := GetPasswordstr(ShowStr);
          TextRectEx(dsurface, dc, ShowStr, FDFColor, FDFBackColor, [tfSingleLine, tfLeft, tfVerticalCenter]);
          nLeft := MIN(Canvas.TextWidth(Copy(FEditString, FCaretStart,
            FCaretPos - FCaretStart)), Width - FIndent * 2);
          if Font.Color <> clWhite then begin
            ShowStr := GetPasswordstr(GetCopy);

            if ShowStr <> '' then begin
              Font.Color := clWhite;
              if boLeft = 1 then
                TextRectEx(dsurface, Fdc, ShowStr, FDFColor, FDFBackColor, [tfSingleLine, tfleft, tfVerticalCenter])
              else
                TextRectEx(dsurface, Fdc, ShowStr, FDFColor, FDFBackColor, [tfSingleLine, tfRight,
                  tfVerticalCenter]);
            end;
          end;
        end
        else begin
          ShowStr := copy(FEditString, 1, FCaretStop - 1);
          ShowStr := GetPasswordstr(ShowStr);
          TextRectEx(dsurface, dc, ShowStr, FDFColor, FDFBackColor, [tfSingleLine, tfRight, tfVerticalCenter]);
          ShowStr := Copy(FEditString, FCaretPos, FCaretStop - FCaretPos);
          nLeft := MIN(Width - FIndent * 3 - Canvas.TextWidth(ShowStr), Width -
            FIndent * 3);
          if Font.Color <> clWhite then begin
            ShowStr := GetPasswordstr(GetCopy);
            if ShowStr <> '' then begin
              Font.Color := clWhite;
              TextRectEx(dsurface, Fdc, ShowStr, FDFColor, FDFBackColor, [tfSingleLine, tfLeft, tfVerticalCenter]);
            end;
          end;
        end;
      finally
        Font.Color := OldColor;
        Font.Name := OldName;
        Font.Size := OldSize;
      end;
    end;
    //画光标
    if FCaretShow and (KeyControl = Self) then begin
      SetBkMode(Handle, TRANSPARENT);
      OldColor := Pen.Color;
      Pen.Color := self.Font.Color;
      if Height < 16 then begin
        RoundRect(SurfaceX(nLeft + FIndent + left), SurfaceY(Top),
          SurfaceX(left +
          FIndent + 1 + nLeft), SurfaceY(top + Height), 0, 0);
      end
      else begin
        RoundRect(SurfaceX(nLeft + FIndent + left), SurfaceY(Top + 2),
          SurfaceX(left +
          FIndent + 1 + nLeft), SurfaceY(top + Height - 2), 0, 0);
      end;
      Pen.Color := OldColor;
    end;
    Release;
  end;
end;

procedure TDEdit.Enter;
begin
  CloseIME;
  inherited;
end;

function TDEdit.FiltrateChar(Char1, Char2: Byte): Boolean;
begin
  Result := False;
  case Char1 of
    129..160, 176..214, 216..247: Result := (Char2 in [64..254]);
    161: Result := (Char2 in [162..254]);
    162: Result := (Char2 in [161..170, 177..226, 229..238, 241..252]);
    163: Result := (Char2 in [161..254]);
    164: Result := (Char2 in [161..243]);
    165: Result := (Char2 in [161..246]);
    166: Result := (Char2 in [161..184, 193..216, 224..235, 238..240]);
    167: Result := (Char2 in [161..193, 209..241]);
    168: Result := (Char2 in [64..149, 161..187, 197..233]);
    169: Result := (Char2 in [64..87, 96..136, 164..239]);
    170..175, 248..253: Result := (Char2 in [64..160]);
    215: Result := (Char2 in [64..249]);
    254: Result := (Char2 in [64..79]);
  end;
end;

function TDEdit.GetCopy: string;
begin
  Result := '';
  if FStartX > FStopX then begin
    Result := Copy(FEditString, FStopX, FStartX - FStopX);
  end
  else begin
    Result := Copy(FEditString, FStartX, FStopX - FStartX);
  end;
end;

function TDEdit.GetPasswordstr(str: string): string;
var
  i: Integer;
begin
  Result := str;
  if str = '' then
    Exit;
  if PasswordChar <> #0 then begin
    Result := '';
    for I := 1 to Length(str) do
      Result := Result + PasswordChar;
  end;
end;

function TDEdit.GetText: string;
begin
  Result := string(FEditString);
end;

function TDEdit.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
var
  i: integer;
  Clipboard: TClipboard;
  AddTx: string;
  nKey: Char;
  boChange: Boolean;
begin
  Result := FALSE;
  {if Background then
    exit;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).KeyDown(Key, Shift) then begin
        Result := TRUE;
        exit;
      end;  }
  if (KeyControl = self) then begin
    if Assigned(FOnKeyDown) then
      FOnKeyDown(self, Key, Shift);
    if Key = 0 then
      exit;

    if (ssCtrl in Shift) and (not Downed) and (Key = Word('X')) then begin
      if (FStartX > -1) and (FStopX > -1) and (FStartX <> FStopX) then begin
        Clipboard := TClipboard.Create;

        Clipboard.AsText := GetCopy;
        Clipboard.Free;
        ClearKey();
        TextChange();
      end;
      Key := 0;
      Result := True;
      Exit;
    end
    else if (ssCtrl in Shift) and (not Downed) and (Key = Word('C')) then begin

      if (FStartX > -1) and (FStopX > -1) and (FStartX <> FStopX) then begin
        Clipboard := TClipboard.Create;
        Clipboard.AsText := GetCopy;
        Clipboard.Free;
      end;
      Key := 0;
      Result := True;
      Exit;
    end
    else if (ssCtrl in Shift) and (not Downed) and (Key = Word('V')) then begin
      if (FPasswordChar = #0) then begin
        ClearKey();
        Clipboard := TClipboard.Create;
        AddTx := Clipboard.AsText;
        for I := 1 to Length(AddTx) do begin
          nKey := AddTx[i];
          if (nKey = #13) or (nKey = #10) then
            Continue;
          KeyPress(nKey);
        end;

        Clipboard.Free;
      end;
      Key := 0;
      Result := True;
      Exit;
    end
    else if (ssShift in Shift) and (not Downed) then begin
      KeyDowned := True;

      if FStartX < 0 then
        FStartX := FCaretPos;
    end
    else
      KeyDowned := False;
    case Key of
      VK_RIGHT: begin
          if not Downed then
            SetCursorPos(deRight);
          if (ssShift in Shift) then begin
            FCursor := deLeft;
            FStopX := FCaretPos
          end
          else begin
            FStartX := -1;
            FStopX := -1;
            KeyDowned := False;
          end;
          Key := 0;
          Result := TRUE;
        end;
      VK_LEFT: begin
          if not Downed then
            SetCursorPos(deLeft);
          if (ssShift in Shift) then begin
            FCursor := deLeft;
            FStopX := FCaretPos
          end
          else begin
            FStartX := -1;
            FStopX := -1;
            KeyDowned := False;
          end;
          Key := 0;
          Result := TRUE;
        end;
      VK_DELETE: begin
          boChange := ClearKey;
          if (not FReadOnly) and (not Downed) and (not KeyDowned) and (not
            boChange) then begin
            Delete(FEditString, FCaretPos, 1);
            FCaretPos := Min(FCaretPos, Length(FEditString) + 1);
            FCursor := deLeft;
            TextChange();
          end
          else if boChange then
            TextChange();
          Key := 0;
          Result := TRUE;
        end;
    end;
    //Key := 0;
    //Result := TRUE;
  end;
end;

function TDEdit.KeyPress(var Key: Char): Boolean;
var
  boChange: Boolean;
begin
  Result := False;
  if (KeyControl = Self) then begin
    Result := TRUE;
    if (not Downed) and (not FReadOnly) then begin
      if Assigned(FOnKeyPress) then
        FOnKeyPress(self, Key);
      if Key = #0 then
        Exit;
      case Key of
        Char(VK_BACK): begin
            boChange := ClearKey;
            if (FEditString <> '') and (not boChange) then begin
              FCursor := deleft;
              Delete(FEditString, FCaretPos - 1, 1);
              SetCursorPos(deLeft);
              TextChange();
            end
            else if boChange then
              TextChange();
          end;
      else begin

          if (FEditClass = deInteger) and (not (key in AllowedIntegerChars)) then begin
            Key := #0;
            exit;
          end
          else if ((FEditClass = deMonoCase) or (FPasswordChar <> #0)) and (not (key in AllowedEnglishChars)) then begin
            Key := #0;
            exit;
          end;

          if (key in AllowedChars) then begin
            if IsDBCSLeadByte(Ord(Key)) or bDoubleByte then begin
              bDoubleByte := true;
              Inc(KeyByteCount);
              FInputStr := FInputStr + key;
            end;
            if not bDoubleByte then begin
              if FCloseSpace and (Key = #32) then begin
                Key := #0;
                exit;
              end;
              ClearKey;
              if (MaxLength > 0) and (Length(string(FEditString)) >= MaxLength) then begin
                Key := #0;
                exit;
              end;
              if FCaretPos <= Length(FEditString) then begin
                Insert(Key, FEditString, FCaretPos);
                SetCursorPosEx(1);
              end
              else begin
                FEditString := FEditString + Key;
                SetCursorPos(deRight);
              end;
              Key := #0;
              TextChange();
            end
            else if KeyByteCount >= 2 then begin
              if length(FInputStr) <> 2 then begin
                bDoubleByte := false;
                KeyByteCount := 0;
                FInputStr := '';
                Key := #0;
                exit;
              end;
              if (FEditClass = deChinese) and (not FiltrateChar(Ord(FInputStr[1]), Ord(FInputStr[2]))) then begin
                bDoubleByte := false;
                KeyByteCount := 0;
                FInputStr := '';
                Key := #0;
                exit;
              end;
              ClearKey;
              if (MaxLength > 0) and (Length(string(FEditString)) >= (MaxLength - 1)) then begin
                bDoubleByte := false;
                KeyByteCount := 0;
                FInputStr := '';
                Key := #0;
                exit;
              end;
              if FCaretPos <= Length(FEditString) then begin
                Insert(FInputStr, FEditString, FCaretPos);
                SetCursorPosEx(1);
              end
              else begin
                FEditString := FEditString + FInputStr;
                SetCursorPos(deRight);
              end;
              TextChange();
              bDoubleByte := false;
              KeyByteCount := 0;
              FInputStr := '';
              Key := #0;
            end;
          end;
        end;
      end;
    end;
    Key := #0;
  end;
end;

function TDEdit.KeyUp(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := FALSE;
  {if Background then
    exit;
  for i := DControls.Count - 1 downto 0 do
    if TDControl(DControls[i]).Visible then
      if TDControl(DControls[i]).KeyUp(Key, Shift) then begin
        Result := TRUE;
        exit;
      end;     }
  if (KeyControl = self) then begin
    CloseIME;
    if (ssShift in Shift) then begin
      KeyDowned := False;
    end;
    if Assigned(FOnKeyUp) then
      FOnKeyUp(self, Key, Shift);
    Key := 0;
    Result := TRUE;
  end;
end;

procedure TDEdit.Leave;
begin
  FStartX := -1;
  FStopX := -1;
  inherited;
end;

function TDEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      FStartX := -1;
      FStopX := -1;
      KeyDowned := False;
      if (FocusedControl = self) then begin
        MoveCaret(X - left, Y - top);
      end;
      Downed := True;
      SetDCapture(self);
    end;
    Result := TRUE;
  end;
end;

function TDEdit.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if Result and (MouseCaptureControl = self) then begin
    if Downed and (not KeyDowned) then
      MoveCaret(X - left, Y - top);
  end;
end;

function TDEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := FALSE;
  Downed := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) then begin
        if Assigned(FOnClick) then
          FOnClick(self, X, Y);
      end;
    end;
    Result := TRUE;
    exit;
  end
  else begin
    ReleaseDCapture;
  end;
end;

procedure TDEdit.MoveCaret(X, Y: Integer);
var
  i: Integer;
  temstr: WideString;
begin
  FCursor := deLeft;
  if Length(FEditString) > 0 then begin
    if (X <= Canvas.TextWidth('A')) and (FCaretStart > 1) then
      Dec(FCaretStart);
    for i := FCaretStart to Length(FEditString) do begin
      temstr := Copy(FEditString, FCaretStart, I - FCaretStart + 1);

      if Canvas.TextWidth(temstr) > X then begin
        while I <> FCaretPos do begin
          if I > FCaretPos then begin
            SetCursorPos(deRight)
          end
          else begin
            SetCursorPos(deLeft);
          end;
        end;
        if Downed or KeyDowned then
          FStopX := FCaretPos
        else
          FStartX := FCaretPos;
        exit;
      end;
    end;
    while (Length(FEditString) + 1) <> FCaretPos do begin
      if (Length(FEditString) + 1) > FCaretPos then begin
        SetCursorPos(deRight)
      end
      else begin
        SetCursorPos(deLeft);
      end;
    end;
    if Downed or KeyDowned then
      FStopX := FCaretPos
    else
      FStartX := FCaretPos;
  end;
end;

procedure TDEdit.SetCursorPos(cCursor: TCursor);
var
  tempstr: WideString;
begin
  if cCursor = deRight then begin
    Inc(FCaretPos);
    if FCaretPos > (Length(FEditString) + 1) then
      FCaretPos := (Length(FEditString) + 1);
    while True do begin
      tempstr := Copy(FEditString, FCaretStart, FCaretPos - FCaretStart);
      if (FCaretStart < FCaretPos) and (Canvas.TextWidth(tempstr) > (Width -
        FIndent * 2)) then begin
        FCursor := deRight;
        Inc(FCaretStart);
        FCaretStop := FCaretPos;
      end
      else if FCaretPos > FCaretStop then begin
        FCaretStop := FCaretPos;
      end
      else
        Break;
    end;
  end
  else begin
    if FCaretPos > 1 then
      Dec(FCaretPos);
    if (FCaretPos <= FCaretStart) and (FCaretStart > 1) then begin
      FCursor := deleft;
      Dec(FCaretStart);
      FCaretStop := FCaretPos;
    end;
  end;
end;

procedure TDEdit.SetCursorPosEx(nLen: Integer);
var
  tempstr: WideString;
begin
  FCursor := deLeft;
  Inc(FCaretPos, nLen);
  if FCaretPos > (Length(FEditString) + 1) then
    FCaretPos := (Length(FEditString) + 1);
  while True do begin
    tempstr := Copy(FEditString, FCaretStart, FCaretPos - FCaretStart);
    if (FCaretStart < FCaretPos) and (Canvas.TextWidth(tempstr) > (Width -
      FIndent * 2)) then begin
      FCursor := deRight;
      Inc(FCaretStart);
      FCaretStop := FCaretPos;
    end
    else if FCaretPos > FCaretStop then begin
      FCaretStop := FCaretPos;
    end
    else
      Break;
  end;
end;

procedure TDEdit.SetFocus;
begin
  inherited;
  if FEditString <> '' then begin
    FStartX := 1;
    FStopX := Length(FEditString) + 1;
  end;
end;

procedure TDEdit.SetText(Value: string);
var
  i: Integer;
  nKey: Char;
  OldKeyControl: TDControl;
  OldFOnChange: TOnClick;
begin
  FEditString := '';
  FCursor := deLeft;
  FCaretStart := 1;
  FCaretStop := 1;
  FCaretPos := 1;
  FStartX := -1;
  OldKeyControl := KeyControl;
  KeyControl := Self;
  OldFOnChange := FOnChange;
  FOnChange := nil;
  try
    for I := 1 to Length(Value) do begin
      nKey := Value[i];
      KeyPress(nKey);
    end;
  finally
    KeyControl := OldKeyControl;
    FOnChange := OldFOnChange;
  end;
end;

procedure TDEdit.TextChange;
begin
  if Assigned(FOnChange) then
    FOnChange(self);
end;

{ TDComboBox }

constructor TDComboBox.Create(AOwner: TComponent);
begin
  inherited;
  //FEnabled := True;
  //FEnableFocus := True;
  FUpDown := TDUpDown.Create(nil);
  SetUpDownButton(FUpDown);
  FItem := TStringList.Create;
  ReadOnly := True;
  FShowCount := 5;
  FShowHeight := 18;
  FListIndex := 0;
  FDWidth := 0;
  FItemIndex := -1;
  FOnChange := nil;
end;

destructor TDComboBox.Destroy;
begin
  FItem.Free;
  FUpDown.Free;
  inherited;
end;

procedure TDComboBox.DirectPaint(dsurface: TDirectDrawSurface);
var
  dc, rc: TRect;
  //  nLeft: integer;
  d: TDirectDrawSurface;
  ShowStr: string;
  nI: Integer;
  //  StopX, StartX, CaretIdx: Integer;
  OldColor, OldSize, nLen, nHeight, nWidth, I: Integer;
  //  nCount,nListCount: Integer;
  OldName: string;
  pts: array[0..2] of TPoint;
  nShowCount: Integer;
  //d: TDirectDrawSurfaceCanvas;
begin
  if Assigned(FOnDirectPaint) then
    FOnDirectPaint(self, dsurface)
  else begin
    d := nil;
    dc.Left := SurfaceX(Left);
    dc.Top := SurfaceY(Top);
    dc.Right := SurfaceX(left + Width);
    dc.Bottom := SurfaceY(top + Height);
    if WLib <> nil then
      d := WLib.Images[FaceIndex];
    if d <> nil then begin
      rc.Left := 0;
      rc.Top := 0;
      rc.Right := d.ClientRect.Right;
      rc.Bottom := d.ClientRect.Bottom;
      dsurface.StretchDraw(dc, rc, d, FALSE);
    end
    else begin
      dsurface.Canvas.Brush.Color := Color;
      dsurface.Canvas.Pen.Color := FrameColor;
      dsurface.Canvas.Pen.Style := psAlternate;
      dsurface.Canvas.RoundRect(dc.Left, dc.Top, dc.Right, dc.Bottom, 0, 0);
    end;
    if (GetTickCount - FCaretShowTime) > 500 then begin
      FCaretShowTime := GetTickCount;
      FCaretShow := not FCaretShow;
    end;
    //    nLeft := 0;
    with dsurface.Canvas do begin
      if FItemIndex >= FItem.Count then
        FItemIndex := -1;
      if FItemIndex > -1 then begin
        SetBkMode(Handle, TRANSPARENT);
        OldColor := Font.Color;
        OldName := Font.Name;
        OldSize := Font.Size;
        try
          Font.Color := self.Font.Color;
          Font.Name := self.Font.Name;
          Font.Size := self.Font.Size;
          dc.Left := SurfaceX(Left + FIndent);
          dc.Top := SurfaceY(Top);
          dc.Right := SurfaceX(left + Width - FIndent * 2);
          dc.Bottom := SurfaceY(top + Height);
          ShowStr := FItem.Strings[FItemIndex];
          TextRect(dc, ShowStr, [tfSingleLine, tfLeft, tfVerticalCenter]);
        finally
          Font.Color := OldColor;
          Font.Name := OldName;
          Font.Size := OldSize;
        end;
      end;
      dc.Left := SurfaceX(Left);
      dc.Top := SurfaceY(Top);
      dc.Right := SurfaceX(left + Width);
      dc.Bottom := SurfaceY(top + Height);
      dsurface.Canvas.Brush.Color := FrameColor;
      dsurface.Canvas.Pen.Color := FrameColor;
      dsurface.Canvas.Pen.Style := psAlternate;
      nLen := Height div 4;
      if Downed then begin
        nWidth := 5;
        nHeight := 0;
      end
      else begin
        nWidth := 6;
        nHeight := -1;
      end;
      pts[0].X := dc.Right - nWidth;
      pts[0].Y := dc.Top + Height div 2 - nLen div 2 + nHeight;
      pts[1].X := dc.Right - nLen - nWidth;
      pts[1].y := pts[0].Y;
      pts[2].X := dc.Right - nWidth - nLen div 2;
      pts[2].Y := pts[0].Y + nlen;
      Polygon(pts);
      if (FocusedControl = self) then begin
        Brush.Color := $000000;
        Pen.Color := $FFFFFF;
        Pen.Style := psAlternate;
        nShowCount := MIN(FShowCount, FItem.Count);
        FListHeight := nShowCount * FShowHeight;
        if FUpDown.Visible then begin
          FDWidth := Width - FUpDown.Width;
        end
        else
          FDWidth := Width;
        RoundRect(SurfaceX(Left),
          SurfaceY(top + Height),
          SurfaceX(left + Width),
          SurfaceY(top + Height + MAX(10, FListHeight)), 0, 0);

        FUpDown.Height := FListHeight - 3;
        FUpDown.Top := Height + 2;
        FUpDown.Left := Width - FUpDown.Width - 1;

        OldColor := Font.Color;
        OldName := Font.Name;
        OldSize := Font.Size;
        dc.Left := SurfaceX(Left) + 2;
        dc.Right := dc.Left + FDWidth - 4;
        dc.Top := SurfaceY(top + Height) + 1;
        dc.Bottom := dc.Top + FShowHeight - 2;
        try
          Font.Color := self.Font.Color;
          Font.Name := self.Font.Name;
          Font.Size := self.Font.Size;
          SetBkMode(Handle, TRANSPARENT);

          nI := 0;
          for I := FUpDown.Position to (FUpDown.Position + nShowCount - 1) do begin
            ShowStr := FItem[i];
            if (SurfaceX(FX) >= dc.Left) and (SurfaceX(FX) < dc.Right) and
              (SurfaceY(FY) >= dc.Top) and (SurfaceY(FY) < dc.Bottom) then begin
              Brush.Color := clBlue;
              FillRect(dc);
              SetBkMode(Handle, TRANSPARENT);
            end;
            TextRect(dc, ShowStr, [tfSingleLine, tfLeft, tfVerticalCenter]);
            dc.Top := SurfaceY(top + Height) + 1 + FShowHeight * (nI + 1);
            dc.Bottom := dc.Top + FShowHeight - 2;
            Inc(nI);
          end;
        finally
          Font.Color := OldColor;
          Font.Name := OldName;
          Font.Size := OldSize;
        end;
      end
      else
        FUpDown.Visible := False;
      Release;
    end;
    if FUpDown.Visible then
      FUpDown.DirectPaint(dsurface);
  end;
end;

function TDComboBox.GetItemIndex: Integer;
begin
  if FItemIndex >= FItem.Count then
    FItemIndex := -1;
  Result := FItemIndex;
end;

function TDComboBox.InRange(x, y: integer): Boolean;
var
  boinrange: Boolean;
  d: TDirectDrawSurface;
begin
  if FEnabled and ((x >= Left) and (x < Left + Width) and (y >= Top) and (y < Top
    + Height) or
    (FocusedControl = self) and (x >= Left) and (x < Left + FDWidth) and (y >=
    Top)
    and (y < Top + Height + FListHeight)) then begin
    boinrange := TRUE;
    if Assigned(FOnInRealArea) then
      FOnInRealArea(self, x - Left, y - Top, boinrange)
    else if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        if d.Pixels[x - Left, y - Top] <= 0 then
          boinrange := FALSE;
    end;
    Result := boinrange;
  end
  else
    Result := FALSE;
end;

function TDComboBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  i: Integer;
begin
  Result := inherited MouseDown(Button, Shift, X, Y);
  if Result and (FocusedControl = self) then begin
    if InRange(x, y) and (Y > Top + height) then begin
      i := (Y - Top - Height) div FShowHeight + FUpDown.Position;
      if (I < FItem.Count) and (I >= 0) then begin
        FItemIndex := I;
        if Assigned(FOnChange) then
          FOnChange(Self);
      end;
      //FEditString := FItem[I];
      FocusedControl := nil;
      FUpDown.Visible := False;
    end
    else begin
      if FItem.Count > FShowCount then begin
        FUpDown.MaxPosition := FItem.Count - FShowCount;
        if FUpDown.Position > (FItem.Count - FShowCount) then
          FUpDown.Position := 0;

        FUpDown.Visible := True;
      end;
    end;
  end;
end;

function TDComboBox.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if Result and (FocusedControl = self) then begin
    FX := X;
    FY := Y;
  end;
end;

procedure TDComboBox.SetItem(const Value: TStrings);
begin
  if Assigned(FItem) then
    FItem.Assign(Value)
  else
    FItem := Value;
  if FItem.Count > FShowCount then begin
    FUpDown.MaxPosition := FItem.Count - FShowCount;
    if FUpDown.Position > (FItem.Count - FShowCount) then
      FUpDown.Position := 0;
  end
  else
    FUpDown.Visible := False;
end;

procedure TDComboBox.SetItemIndex(const Value: Integer);
begin
  if Value >= FItem.Count then
    FItemIndex := -1
  else
    FItemIndex := Value;
end;

procedure TDComboBox.SetShowCount(Value: Integer);
begin
  FShowCount := Value;
  FListHeight := FShowCount * FShowHeight;
end;

procedure TDComboBox.SetShowHeight(Value: Integer);
begin
  FShowHeight := Value;
  FListHeight := FShowCount * FShowHeight;
end;

procedure TDComboBox.SetUpDownButton(Button: TDUpDown);
begin
  Button.DParent := Self;
  Button.Visible := False;
  Button.FMouseFocus := False;
  Button.UpButton.FMouseFocus := False;
  Button.DownButton.FMouseFocus := False;
  Button.MoveButton.FMouseFocus := False;
  AddChild(Button);
end;

{ TDListView }

procedure TDListView.AddHead(sName: string; DBiDiMode: TDBiDiMode; Width: Word);
var
  DListViewHead: pTDListViewHead;
begin
  if (sName <> '') then begin
    New(DListViewHead);
    DListViewHead.sName := sName;
    DListViewHead.DBiDiMode := DBiDiMode;
    DListViewHead.nWidth := Width;
    FHeadList.Add(DListViewHead);
  end;
end;

function TDListView.AddItem: TStringList;
var
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  FItemList.Add(StringList);
  Result := StringList;
end;

procedure TDListView.Clear;
var
  StringList: TStringList;
  I: Integer;
begin
  for I := 0 to FItemList.Count - 1 do begin
    StringList := FItemList.Items[i];
    StringList.Free;
  end;
  FItemList.Clear;
  FUpDown.Position := 0;
end;

procedure TDListView.ClearHead;
var
  DListViewHead: pTDListViewHead;
  I: Integer;
begin
  for I := 0 to FHeadList.Count - 1 do begin
    DListViewHead := FHeadList.Items[i];
    Dispose(DListViewHead);
  end;
  FHeadList.Clear;
end;

constructor TDListView.Create(AOwner: TComponent);
begin
  inherited;
  FUpDown := TDUpDown.Create(nil);
  SetUpDownButton(FUpDown);
  FHeadList := TList.Create;
  FItemList := TList.Create;
  Color := $004A8494;
  FItemHeigth := 18;
  FItemIndex := -1;
  FOnItemIndex := nil;
end;

destructor TDListView.Destroy;
begin
  Clear;
  ClearHead;
  FHeadList.Free;
  FUpDown.Free;
  FItemList.Free;
  inherited;
end;

procedure TDListView.DirectPaint(dsurface: TDirectDrawSurface);
var
  ndc, dc: TRect;
  nLeft, nTop, I, ii: Integer;
  DListViewHead: pTDListViewHead;
  TempStr: string;
  StringList: TStringList;
begin
  with dsurface.Canvas do begin
    SetBkMode(Handle, TRANSPARENT);
    Brush.Color := Color;
    ndc.Left := SurfaceX(left);
    ndc.Top := SurfaceY(top);
    ndc.Right := ndc.Left + Width;
    ndc.Bottom := ndc.Top + Height;
    FrameRect(ndc);
    nLeft := ndc.Left;
    nTop := ndc.Top;
    FItemCount := (ndc.Bottom - ndc.Top) div FItemHeigth - 1;
    FUpDown.MaxPosition := FItemList.Count - FItemCount;
    Release;
    for I := 0 to FHeadList.Count - 1 do begin
      SetBkMode(Handle, TRANSPARENT);
      DListViewHead := FHeadList.Items[i];
      dc.Left := nLeft;
      dc.Top := nTop;
      dc.Right := dc.Left + DListViewHead.nWidth + 1;
      dc.Bottom := dc.Top + FItemHeigth;
      DListViewHead.Rect.Left := nLeft + 6;
      DListViewHead.Rect.Top := nTop;
      DListViewHead.Rect.Right := dc.Left + DListViewHead.nWidth + 1 - 6;
      DListViewHead.Rect.Bottom := dc.Top + FItemHeigth;
      FrameRect(dc);
      Inc(nLeft, DListViewHead.nWidth);
      TempStr := DListViewHead.sName;
      Font.Color := clSilver;
      Font.Style := [fsBold];
      Release;
      SetBkMode(Handle, TRANSPARENT);
      case DListViewHead.DBiDiMode of
        dbLeft: TextRect(DListViewHead.Rect, TempStr, [tfSingleLine, tfLeft,
            tfVerticalCenter]);
        dbCenter: TextRect(DListViewHead.Rect, TempStr, [tfSingleLine, tfCenter,
            tfVerticalCenter]);
        dbRight: TextRect(DListViewHead.Rect, TempStr, [tfSingleLine, tfRight,
            tfVerticalCenter]);
      end;
      Release;
    end;
    SetBkMode(Handle, TRANSPARENT);
    dc.Left := nLeft;
    dc.Top := nTop;
    dc.Right := ndc.Right;
    dc.Bottom := dc.Top + FItemHeigth;
    FrameRect(dc);
    Release;
    SetBkMode(Handle, TRANSPARENT);
    nTop := ndc.Top + FItemHeigth;
    Font.Style := [];
    Font.Color := clWhite;
    for I := Max(FUpDown.Position, 0) to (Max(FUpDown.Position, 0) + FItemCount
      - 1) do begin
      if (i >= FItemList.Count) or (i < 0) then
        Break;
      StringList := FItemList.Items[i];
      if FItemIndex = i then
        Font.Color := clRed
      else
        Font.Color := clWhite;
      for ii := 0 to StringList.Count - 1 do begin
        if ii >= FHeadList.Count then
          Break;
        DListViewHead := FHeadList.Items[ii];
        DListViewHead.Rect.Top := nTop;
        DListViewHead.Rect.Bottom := DListViewHead.Rect.Top + FItemHeigth;
        TempStr := StringList.Strings[ii];
        case DListViewHead.DBiDiMode of
          dbLeft: TextRect(DListViewHead.Rect, TempStr, [tfSingleLine, tfLeft,
              tfVerticalCenter]);
          dbCenter: TextRect(DListViewHead.Rect, TempStr, [tfSingleLine,
              tfCenter,
                tfVerticalCenter]);
          dbRight: TextRect(DListViewHead.Rect, TempStr, [tfSingleLine, tfRight,
              tfVerticalCenter]);
        end;
      end;
      Inc(nTop, FItemHeigth);
    end;
    Release;
  end;
  if FItemList.Count > FItemCount then begin
    FUpDown.Top := FItemHeigth + 1;
    FUpDown.Left := Width - FUpDown.Width - 1;
    FUpDown.Height := Height - FItemHeigth - 2;
    FUpDown.DirectPaint(dsurface);
  end
  else
    FUpDown.Position := 0;
end;

function TDListView.GetItems(Index: Integer): TStringList;
begin
  Result := nil;
  if (Index >= 0) and (Index < FItemList.Count) then
    Result := FItemList.Items[Index];
end;

function TDListView.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  i: Integer;
  DListViewHead: pTDListViewHead;
begin
  Result := inherited MouseDown(Button, Shift, X, Y);
  if Result and (FocusedControl = self) and ((X - left) < (Width -
    FUpDown.Width)) and
    (FItemIndex <> -1) then begin
    Dec(x, left);
    for I := 0 to FHeadList.Count - 1 do begin
      DListViewHead := FHeadList.Items[i];
      if X < DListViewHead.nWidth then begin
        if Assigned(FOnItemIndex) then
          FOnItemIndex(Self, FItemIndex, I);
        Break;
      end;
      Dec(X, DListViewHead.nWidth);
    end;
  end;
end;

function TDListView.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if Result and (InRange(x, y)) then begin
    if (Y - top) <= FItemHeigth then begin
      FItemIndex := -1;
    end
    else
      FItemIndex := ((Y - top) - FItemHeigth) div FItemHeigth +
        FUpDown.Position;
    if (FItemIndex - FUpDown.Position) > (FItemCount - 1) then
      FItemIndex := -1;

  end;
end;

procedure TDListView.SetUpDownButton(Button: TDUpDown);
begin
  Button.DParent := Self;
  Button.Visible := True;

  AddChild(Button);
end;

{ TDMemo }

function TDMemo.ClearKey: Boolean;
var
  nStartY, nStopY: Integer;
  nStartX, nStopX: Integer;
  TempStr: WideString;
  i: Integer;
begin
  Result := False;
  if FLines.Count > 0 then begin
    if (FCaretX <> FSCaretX) or (FSCaretY <> FCaretY) then begin

      if FSCaretY < 0 then
        FSCaretY := 0;
      if FSCaretY >= FLines.Count then
        FSCaretY := FLines.Count - 1;

      if FCaretY < 0 then
        FCaretY := 0;
      if FCaretY >= FLines.Count then
        FCaretY := FLines.Count - 1;

      if FSCaretY = FCaretY then begin
        if FSCaretX > FCaretX then begin
          nStartX := FCaretX;
          nStopX := FSCaretX;
        end
        else begin
          nStartX := FSCaretX;
          nStopX := FCaretX;
        end;

        TempStr := TDMemoStringList(FLines).Str[FCaretY];
        Delete(TempStr, nStartX + 1, nStopX - nStartX);
        TDMemoStringList(FLines).Str[FCaretY] := TempStr;
        RefListWidth(FCaretY, 0);
        FCaretX := nStartX;
        SetCaret(True);
        Result := True;
      end
      else begin
        if FSCaretY > FCaretY then begin
          nStartY := FCaretY;
          nStopY := FSCaretY;
          nStartX := FCaretX;
          nStopX := FSCaretX;
        end
        else begin
          nStartY := FSCaretY;
          nStopY := FCaretY;
          nStartX := FSCaretX;
          nStopX := FCaretX;
        end;
        TempStr := TDMemoStringList(FLines).Str[nStartY];
        Delete(TempStr, nStartX + 1, 255);
        TDMemoStringList(FLines).Str[nStartY] := TempStr;

        TempStr := TDMemoStringList(FLines).Str[nStopY];
        Delete(TempStr, 1, nStopX);
        TDMemoStringList(FLines).Str[nStartY] :=
          TDMemoStringList(FLines).Str[nStartY] + TempStr;
        FLines.Objects[nStartY] := FLines.Objects[nStopY];
        FLines.Delete(nStopY);
        if (nStopY - nStartY) > 1 then
          for i := nStopY - 1 downto nStartY + 1 do
            FLines.Delete(i);
        RefListWidth(nStartY, nStartX);
        SetCaret(True);
        Result := True;
      end;
    end;
  end;
end;

constructor TDMemo.Create(AOwner: TComponent);
begin
  inherited;
  FKeyFocus := True;
  FCaretShowTime := GetTickCount;

  Downed := False;
  KeyDowned := False;

  FUpDown := nil;

  FTopIndex := 0;
  FCaretY := 0;
  FCaretX := 0;

  FSCaretX := 0;
  FSCaretY := 0;

  FInputStr := '';
  bDoubleByte := False;
  KeyByteCount := 0;

  FTransparent := False;

  FMaxLength := 0;
  FEditClass := deNone;

  FOnChange := nil;
  FReadOnly := False;
  FFrameColor := clBlack;
  Color := clBlack;

  FLines := TDMemoStringList.Create;
  TDMemoStringList(FLines).DMemo := Self;

  Font.Name := DEF_FONT_NAME;
  Font.Color := clWhite;
  Font.Size := DEFFONTSIZE;
  Canvas.Font.Name := Font.Name;
  Canvas.Font.Color := Font.Color;
  Canvas.Font.Size := Font.Size;

  FMoveTick := GetTickCount;
end;

destructor TDMemo.Destroy;
begin
  FLines.Free;
  inherited;
end;

procedure TDMemo.DirectPaint(dsurface: TDirectDrawSurface);
var
  dc: TRect;
  nShowCount, i: Integer;
  ax, ay: Integer;
  TempStr: string;
  nStartY, nStopY: Integer;
  nStartX, nStopX: Integer;
  addax: Integer;
begin
  dc.Left := SurfaceX(Left);
  dc.Top := SurfaceY(Top);
  dc.Right := SurfaceX(left + Width);
  dc.Bottom := SurfaceY(top + Height);

  //画EDIT外框
  if not FTransparent then begin
    dsurface.Canvas.Brush.Color := Color;
    dsurface.Canvas.Pen.Color := FrameColor;
    dsurface.Canvas.Pen.Style := psAlternate;
    dsurface.Canvas.RoundRect(dc.Left, dc.Top, dc.Right, dc.Bottom, 0, 0);
  end;
  if (GetTickCount - FCaretShowTime) > 500 then begin //光标闪动间隔时间
    FCaretShowTime := GetTickCount;
    FCaretShow := not FCaretShow;
  end;

  nShowCount := (Height - 2) div 14;
  if (FTopIndex + nShowCount - 1) > Lines.Count then begin
    FTopIndex := Max(Lines.Count - nShowCount + 1, 0);
  end;
  if (FCaretY >= Lines.Count) then
    FCaretY := Max(Lines.Count - 1, 0);
  if FCaretY < 0 then begin
    FTopIndex := 0;
    FCaretY := 0;
  end;

  if Lines.Count > nShowCount then begin
    if FUpDown <> nil then begin
      if not FUpDown.Visible then
        FUpDown.Visible := True;
      FUpDown.MaxPosition := Lines.Count - nShowCount;
      FUpDown.Position := FTopIndex;
    end;
  end
  else begin
    if FUpDown <> nil then begin
      if FUpDown.Visible then
        FUpDown.Visible := False;
      FTopIndex := 0;
    end;
  end;

  if FSCaretY > FCaretY then begin
    nStartY := FCaretY;
    nStopY := FSCaretY;
    nStartX := FCaretX;
    nStopX := FSCaretX;
  end
  else begin
    nStartY := FSCaretY;
    nStopY := FCaretY;
    nStartX := FSCaretX;
    nStopX := FCaretX;
  end;
  if FSCaretY = FCaretY then begin
    if FSCaretX > FCaretX then begin
      nStartX := FCaretX;
      nStopX := FSCaretX;
    end
    else if FSCaretX < FCaretX then begin
      nStartX := FSCaretX;
      nStopX := FCaretX;
    end
    else begin
      nStartX := -1;
    end;
  end;
  ax := SurfaceX(Left) + 2;
  ay := SurfaceY(Top) + 2;
  with dsurface.Canvas do begin
    Font.Color := Self.Font.Color;
    SetBkMode(Handle, TRANSPARENT);
    for i := FTopIndex to (FTopIndex + nShowCount - 1) do begin
      if i >= Lines.Count then
        Break;
      if nStartY <> nStopY then begin
        if i = nStartY then begin
          TempStr := Copy(WideString(Lines[i]), 1, nStartX);
          TextOut(ax, ay + (i - FTopIndex) * 14, TempStr);
          addax := TextWidth(TempStr);
          Release;
          TempStr := Copy(WideString(Lines[i]), nStartX + 1, 255);
          SetBkMode(Handle, OPAQUE);
          Brush.Color := clBlue;
          TextOut(ax + addax, ay + (i - FTopIndex) * 14, TempStr);
          Release;
          SetBkMode(Handle, TRANSPARENT);
        end
        else if i = nStopY then begin
          Release;
          TempStr := Copy(WideString(Lines[i]), 1, nStopX);
          addax := TextWidth(TempStr);
          SetBkMode(Handle, OPAQUE);
          Brush.Color := clBlue;
          TextOut(ax, ay + (i - FTopIndex) * 14, TempStr);
          Release;
          SetBkMode(Handle, TRANSPARENT);
          TempStr := Copy(WideString(Lines[i]), nStopX + 1, 255);
          TextOut(ax + addax, ay + (i - FTopIndex) * 14, TempStr);
        end
        else if (i > nStartY) and (i < nStopY) then begin
          Release;
          SetBkMode(Handle, OPAQUE);
          Brush.Color := clBlue;
          TextOut(ax, ay + (i - FTopIndex) * 14, Lines[i]);
          Release;
          SetBkMode(Handle, TRANSPARENT);
        end
        else
          TextOut(ax, ay + (i - FTopIndex) * 14, Lines[i]);
      end
      else begin
        if (nStartX <> -1) and (i = FSCaretY) then begin
          TempStr := Copy(WideString(Lines[i]), 1, nStartX);
          TextOut(ax, ay + (i - FTopIndex) * 14, TempStr);
          addax := TextWidth(TempStr);
          Release;
          TempStr := Copy(WideString(Lines[i]), nStartX + 1, nStopX - nStartX);
          SetBkMode(Handle, OPAQUE);
          Brush.Color := clBlue;
          TextOut(ax + addax, ay + (i - FTopIndex) * 14, TempStr);
          addax := addax + TextWidth(TempStr);
          Release;
          SetBkMode(Handle, TRANSPARENT);
          TempStr := Copy(WideString(Lines[i]), nStopX + 1, 255);
          TextOut(ax + addax, ay + (i - FTopIndex) * 14, TempStr);
        end
        else
          TextOut(ax, ay + (i - FTopIndex) * 14, Lines[i]);
      end;
    end;
    if (FCaretY >= FTopIndex) and (FCaretY < (FTopIndex + nShowCount)) then begin
      ay := ay + (Max(FCaretY - FTopIndex, 0)) * 14;
      if FCaretY < Lines.Count then begin
        TempStr := LeftStr(WideString(Lines[FCaretY]), FCaretX);
        ax := ax + TextWidth(TempStr);
      end;
      if FCaretShow and (KeyControl = Self) then begin
        Pen.Color := Self.Font.Color;
        RoundRect(ax, ay, ax + 1, ay + 12, 0, 0);
      end;
    end;
    Release;
  end;
  for i := 0 to DControls.Count - 1 do
    if TDControl(DControls[i]).Visible then
      TDControl(DControls[i]).DirectPaint(dsurface);
end;

procedure TDMemo.Enter;
begin
  inherited;
end;

function TDMemo.FiltrateChar(Char1, Char2: Byte): Boolean;
begin
  Result := False;
  case Char1 of
    129..160, 176..214, 216..247: Result := (Char2 in [64..254]);
    161: Result := (Char2 in [162..254]);
    162: Result := (Char2 in [161..170, 177..226, 229..238, 241..252]);
    163: Result := (Char2 in [161..254]);
    164: Result := (Char2 in [161..243]);
    165: Result := (Char2 in [161..246]);
    166: Result := (Char2 in [161..184, 193..216, 224..235, 238..240]);
    167: Result := (Char2 in [161..193, 209..241]);
    168: Result := (Char2 in [64..149, 161..187, 197..233]);
    169: Result := (Char2 in [64..87, 96..136, 164..239]);
    170..175, 248..253: Result := (Char2 in [64..160]);
    215: Result := (Char2 in [64..249]);
    254: Result := (Char2 in [64..79]);
  end;
end;

function TDMemo.GetKey: string;
var
  nStartY, nStopY: Integer;
  nStartX, nStopX: Integer;
  TempStr: WideString;
  i: Integer;
begin
  Result := '';
  if FLines.Count > 0 then begin
    if (FCaretX <> FSCaretX) or (FSCaretY <> FCaretY) then begin

      if FSCaretY < 0 then
        FSCaretY := 0;
      if FSCaretY >= FLines.Count then
        FSCaretY := FLines.Count - 1;

      if FCaretY < 0 then
        FCaretY := 0;
      if FCaretY >= FLines.Count then
        FCaretY := FLines.Count - 1;

      if FSCaretY = FCaretY then begin
        if FSCaretX > FCaretX then begin
          nStartX := FCaretX;
          nStopX := FSCaretX;
        end
        else begin
          nStartX := FSCaretX;
          nStopX := FCaretX;
        end;
        TempStr := FLines[FCaretY];
        Result := Copy(TempStr, nStartX + 1, nStopX - nStartX);
      end
      else begin
        if FSCaretY > FCaretY then begin
          nStartY := FCaretY;
          nStopY := FSCaretY;
          nStartX := FCaretX;
          nStopX := FSCaretX;
        end
        else begin
          nStartY := FSCaretY;
          nStopY := FCaretY;
          nStartX := FSCaretX;
          nStopX := FCaretX;
        end;
        TempStr := FLines[nStartY];
        Result := Copy(TempStr, nStartX + 1, 255);
        if Integer(FLines.Objects[nStartY]) = 13 then
          Result := Result + #13#10;
        if (nStopY - nStartY) > 1 then
          for i := nStartY + 1 to nStopY - 1 do begin
            Result := Result + FLines[i];
            if Integer(FLines.Objects[i]) = 13 then
              Result := Result + #13#10;
          end;
        TempStr := FLines[nStopY];
        Result := Result + Copy(TempStr, 1, nStopX);
        if Integer(FLines.Objects[nStopY]) = 13 then
          Result := Result + #13#10;
      end;
    end;
  end;
end;

procedure TDMemo.KeyCaret(Key: Word);
var
  TempStr: WideString;
  nShowCount: Integer;
begin
  if FLines.Count > 0 then begin
    if FCaretY < 0 then
      FCaretY := 0;
    if FCaretY >= FLines.Count then
      FCaretY := FLines.Count - 1;
    TempStr := TDMemoStringList(FLines).Str[FCaretY];
    case Key of
      VK_UP: begin
          if FCaretY > 0 then
            Dec(FCaretY);
        end;
      VK_DOWN: begin
          if FCaretY < (FLines.Count - 1) then
            Inc(FCaretY);
        end;
      VK_RIGHT: begin
          if FCaretX < Length(TempStr) then
            Inc(FCaretX)
          else begin
            if FCaretY < (FLines.Count - 1) then begin
              Inc(FCaretY);
              FCaretX := 0;
            end;
          end;
        end;
      VK_LEFT: begin
          if FCaretX > 0 then
            Dec(FCaretX)
          else begin
            if FCaretY > 0 then begin
              Dec(FCaretY);
              FCaretX :=
                Length(WideString(TDMemoStringList(FLines).Str[FCaretY]));
            end;
          end;
        end;
    end;
    nShowCount := (Height - 2) div 14;
    if FCaretY < FTopIndex then
      FTopIndex := FCaretY
    else begin
      if (FCaretY - FTopIndex) >= nShowCount then begin
        FTopIndex := Max(FCaretY - nShowCount + 1, 0);
      end;
    end;

    if not KeyDowned then
      SetCaret(False);
  end;
end;

function TDMemo.KeyDown(var Key: Word; Shift: TShiftState): Boolean;
var
  Clipboard: TClipboard;
  AddTx, Data: string;
  boAdd: Boolean;
  TempStr: WideString;
begin
  Result := FALSE;

  if (KeyControl = self) then begin
    if Assigned(FOnKeyDown) then
      FOnKeyDown(self, Key, Shift);
    if Key = 0 then
      exit;
    if (ssCtrl in Shift) and (not Downed) and (Key = Word('A')) then begin
      if FLines.Count > 0 then begin
        FCaretY := FLines.Count - 1;
        FCaretX := Length(WideString(TDMemoStringList(FLines).Str[FSCaretY]));
        SetCaret(True);
        FSCaretX := 0;
        FSCaretY := 0;
      end;
      Key := 0;
      Result := True;
      Exit;
    end
    else if (ssCtrl in Shift) and (not Downed) and (Key = Word('X')) then begin
      AddTx := GetKey;
      if AddTx <> '' then begin
        Clipboard := TClipboard.Create;
        Clipboard.AsText := AddTx;
        Clipboard.Free;
        ClearKey();
        TextChange();
      end;
      Key := 0;
      Result := True;
      Exit;
    end
    else if (ssCtrl in Shift) and (not Downed) and (Key = Word('C')) then begin
      AddTx := GetKey;
      if AddTx <> '' then begin
        Clipboard := TClipboard.Create;
        Clipboard.AsText := AddTx;
        Clipboard.Free;
      end;
      Key := 0;
      Result := True;
      Exit;
    end
    else if (ssCtrl in Shift) and (not Downed) and (Key = Word('V')) then begin
      ClearKey();
      //exit;
      Clipboard := TClipboard.Create;
      AddTx := Clipboard.AsText;
      boAdd := False;
      while True do begin
        if AddTx = '' then
          break;
        AddTx := GetValidStr3(AddTx, data, [#13]);
        if Data <> '' then begin
          data := AnsiReplaceText(data, #10, '');
          if Data = '' then
            Data := #9;
          if FLines.Count <= 0 then begin
            FLines.AddObject(Data, TObject(13));
            FCaretY := 0;
            RefListWidth(FCaretY, -1);
          end
          else if boAdd then begin
            Inc(FCaretY);
            FLines.InsertObject(FCaretY, Data, TObject(13));
            FCaretX := 0;
            RefListWidth(FCaretY, -1);
          end
          else begin
            TempStr := TDMemoStringList(FLines).Str[FCaretY];
            Insert(Data, TempStr, FCaretX + 1);
            TDMemoStringList(FLines).Str[FCaretY] := TempStr;
            Inc(FCaretX, Length(WideString(Data)));
            FLines.Objects[FCaretY] := TObject(13);
            RefListWidth(FCaretY, FCaretX);
          end;

          boAdd := True;
        end;
      end;
      Clipboard.Free;
      Key := 0;
      Result := True;
      Exit;
    end
    else if (ssShift in Shift) and (not Downed) then begin
      KeyDowned := True;
    end
    else
      KeyDowned := False;
    if FLines.Count <= 0 then
      exit;
    case Key of
      VK_UP,
        VK_DOWN,
        VK_RIGHT,
        VK_LEFT: begin
          KeyCaret(Key);
          Key := 0;
          Result := TRUE;
        end;
      VK_BACK: begin
          if (not FReadOnly) then begin
            if not ClearKey then begin
              while True do begin
                TempStr := TDMemoStringList(FLines).Str[FCaretY];
                if FCaretX > 0 then begin
                  Delete(TempStr, FCaretX, 1);
                  if TempStr = '' then begin
                    FLines.Delete(FCaretY);
                    if FCaretY > 0 then begin
                      Dec(FCaretY);
                      FCaretX :=
                        Length(WideString(TDMemoStringList(FLines).Str[FCaretY]));
                      SetCaret(True);
                    end
                    else begin
                      FCaretY := 0;
                      FCaretX := 0;
                      SetCaret(False);
                    end;
                    Exit;
                  end
                  else begin
                    TDMemoStringList(FLines).Str[FCaretY] := TempStr;
                    Dec(FCaretX);
                  end;
                  break;
                end
                else if FCaretX = 0 then begin
                  if FCaretY > 0 then begin
                    if Integer(FLines.Objects[FCaretY - 1]) = 13 then begin
                      FLines.Objects[FCaretY - 1] := nil;
                      Break;
                    end
                    else begin
                      FLines.Objects[FCaretY - 1] := FLines.Objects[FCaretY];
                      FCaretX :=
                        Length(WideString(TDMemoStringList(FLines).Str[FCaretY -
                        1]));
                      TDMemoStringList(FLines).Str[FCaretY - 1] :=
                        TDMemoStringList(FLines).Str[FCaretY - 1] +
                        TDMemoStringList(FLines).Str[FCaretY];
                      FLines.Delete(FCaretY);
                      Dec(FCaretY);
                    end;
                  end
                  else
                    Break;
                end
                else
                  Break;
              end;
              RefListWidth(FCaretY, FCaretX);
              SetCaret(True);
            end;
            TextChange();
          end;
          Key := 0;
          Result := TRUE;
        end;
      VK_DELETE: begin
          if (not FReadOnly) then begin
            if not ClearKey then begin
              while True do begin
                TempStr := TDMemoStringList(FLines).Str[FCaretY];
                if Length(TempStr) > FCaretX then begin
                  Delete(TempStr, FCaretX + 1, 1);
                  if TempStr = '' then begin
                    FLines.Delete(FCaretY);
                    if FCaretY > 0 then begin
                      Dec(FCaretY);
                      FCaretX :=
                        Length(WideString(TDMemoStringList(FLines).Str[FCaretY]));
                      SetCaret(True);
                    end
                    else begin
                      FCaretY := 0;
                      FCaretX := 0;
                      SetCaret(False);
                    end;
                    Exit;
                  end
                  else
                    TDMemoStringList(FLines).Str[FCaretY] := TempStr;
                  break;
                end
                else if Integer(FLines.Objects[FCaretY]) = 13 then begin
                  FLines.Objects[FCaretY] := nil;
                  break;
                end
                else begin
                  if (FCaretY + 1) < FLines.Count then begin
                    TDMemoStringList(FLines).Str[FCaretY] :=
                      TDMemoStringList(FLines).Str[FCaretY] +
                      TDMemoStringList(FLines).Str[FCaretY + 1];
                    FLines.Objects[FCaretY] := FLines.Objects[FCaretY + 1];
                    FLines.Delete(FCaretY + 1);
                  end
                  else
                    Break;
                end;
              end;
              RefListWidth(FCaretY, FCaretX);
              SetCaret(True);
            end;
            TextChange();
          end;
          Key := 0;
          Result := TRUE;
        end;
    end;
    //Key := 0;
    //Result := TRUE;
  end;
end;

function TDMemo.KeyPress(var Key: Char): Boolean;
var
  //  boChange: Boolean;
  TempStr, Temp: WideString;
  OldObject: Integer;
begin
  Result := False;
  if (KeyControl = Self) then begin
    Result := TRUE;
    if (not Downed) and (not FReadOnly) then begin
      if Assigned(FOnKeyPress) then
        FOnKeyPress(self, Key);
      if Key = #0 then
        Exit;

      if (FCaretY >= Lines.Count) then
        FCaretY := Max(Lines.Count - 1, 0);
      if FCaretY < 0 then begin
        FTopIndex := 0;
        FCaretY := 0;
      end;
      if Key = #13 then begin
        //ClearKey;
        if FLines.Count <= 0 then begin
          FLines.AddObject('', TObject(13));
          FLines.AddObject('', TObject(13));
          FCaretX := 0;
          FCaretY := 1;
          SetCaret(True);
        end
        else begin
          Temp := TDMemoStringList(FLines).Str[FCaretY];
          OldObject := Integer(FLines.Objects[FCaretY]);

          TempStr := Copy(Temp, 1, FCaretX);
          TDMemoStringList(FLines).Str[FCaretY] := TempStr;
          FLines.Objects[FCaretY] := TObject(13);

          TempStr := Copy(Temp, FCaretX + 1, 255);
          if TempStr <> '' then begin
            FLines.InsertObject(FCaretY + 1, TempStr, TObject(OldObject));
          end
          else begin
            FLines.InsertObject(FCaretY + 1, '', TObject(OldObject));
          end;
          RefListWidth(FCaretY + 1, 0);
          FCaretY := FCaretY + 1;
          FCaretX := 0;
          SetCaret(True);
        end;
        exit;
      end;

      if (FEditClass = deInteger) and (not (key in AllowedIntegerChars)) then begin
        Key := #0;
        exit;
      end
      else if (FEditClass = deMonoCase) and (not (key in AllowedEnglishChars)) then begin
        Key := #0;
        exit;
      end;

      if (key in AllowedChars) then begin
        if IsDBCSLeadByte(Ord(Key)) or bDoubleByte then begin
          bDoubleByte := true;
          Inc(KeyByteCount);
          FInputStr := FInputStr + key;
        end;
        if not bDoubleByte then begin
          ClearKey;
          if (MaxLength > 0) and (Length(strpas(FLines.GetText)) >= MaxLength) then begin
            Key := #0;
            exit;
          end;
          if FLines.Count <= 0 then begin
            FLines.AddObject(Key, nil);
            FCaretX := 1;
            FCaretY := 0;
          end
          else begin
            TempStr := TDMemoStringList(FLines).Str[FCaretY];
            Insert(Key, TempStr, FCaretX + 1);
            TDMemoStringList(FLines).Str[FCaretY] := TempStr;
            Inc(FCaretX);
            RefListWidth(FCaretY, FCaretX);
          end;
          SetCaret(True);
          Key := #0;
          TextChange();
        end
        else if KeyByteCount >= 2 then begin
          if length(FInputStr) <> 2 then begin
            bDoubleByte := false;
            KeyByteCount := 0;
            FInputStr := '';
            Key := #0;
            exit;
          end;
          if (FEditClass = deChinese) and (not FiltrateChar(Ord(FInputStr[1]), Ord(FInputStr[2]))) then begin
            bDoubleByte := false;
            KeyByteCount := 0;
            FInputStr := '';
            Key := #0;
            exit;
          end;
          ClearKey;
          if (MaxLength > 0) and (Length(string(FLines.GetText)) >= (MaxLength - 1)) then begin
            bDoubleByte := false;
            KeyByteCount := 0;
            FInputStr := '';
            Key := #0;
            exit;
          end;
          if FLines.Count <= 0 then begin
            FLines.AddObject(FInputStr, nil);
            FCaretX := 1;
            FCaretY := 0;
          end
          else begin
            TempStr := TDMemoStringList(FLines).Str[FCaretY];
            Insert(FInputStr, TempStr, FCaretX + 1);
            TDMemoStringList(FLines).Str[FCaretY] := TempStr;
            Inc(FCaretX);
            RefListWidth(FCaretY, FCaretX);
          end;
          SetCaret(True);
          bDoubleByte := false;
          KeyByteCount := 0;
          FInputStr := '';
          Key := #0;
          TextChange();
        end;
      end;
    end;
  end;
  Key := #0;
end;

function TDMemo.KeyUp(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := FALSE;

  if (KeyControl = self) then begin
    if (ssShift in Shift) then begin
      KeyDowned := False;
    end;
    if Assigned(FOnKeyUp) then
      FOnKeyUp(self, Key, Shift);
    Key := 0;
    Result := TRUE;
  end;
end;

procedure TDMemo.Leave;
begin
  inherited;
end;

function TDMemo.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := FALSE;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl = nil) then begin
      KeyDowned := False;
      if (FocusedControl = self) then begin
        DownCaret(X - left, Y - top);
      end;
      SetCaret(False);
      Downed := True;
      SetDCapture(self);
    end;
    Result := TRUE;
  end;
end;

function TDMemo.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if Result and (MouseCaptureControl = self) then begin
    if Downed and (not KeyDowned) then
      MoveCaret(X - left, Y - top);
  end;
end;

function TDMemo.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := FALSE;
  Downed := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    if not Background then begin
      if InRange(X, Y) then begin
        if Assigned(FOnClick) then
          FOnClick(self, X, Y);
      end;
    end;
    Result := TRUE;
    exit;
  end
  else begin
    ReleaseDCapture;
  end;
end;

procedure TDMemo.MoveCaret(X, Y: Integer);
var
  tempstrw: WideString;
  nShowCount, i: Integer;
  tempstr: string;
begin
  nShowCount := (Height - 2) div 14;
  if Y < 0 then begin //往上移动
    if (GetTickCount - FMoveTick) < 50 then
      Exit;
    if FTopIndex > 0 then
      Dec(FTopIndex);
    FCaretY := FTopIndex;
  end
  else if Y > Height then begin //往下移动
    if (GetTickCount - FMoveTick) < 50 then
      Exit;
    Inc(FCaretY);
    if FCaretY >= FLines.Count then
      FCaretY := Max(FLines.Count - 1, 0);
    FTopIndex := Max(FCaretY - nShowCount + 1, 0);
  end
  else
    FCaretY := (y - 2) div 14 + FTopIndex;
  FMoveTick := GetTickCount;

  if FCaretY >= FLines.Count then
    FCaretY := Max(FLines.Count - 1, 0);
  FCaretX := 0;
  if FCaretY < FLines.Count then begin
    tempstrw := TDMemoStringList(FLines).Str[FCaretY];
    if tempstrw <> '' then begin
      for i := 1 to Length(tempstrw) do begin
        tempstr := Copy(tempstrw, 1, i);
        if (Canvas.TextWidth(tempstr)) > (X) then
          exit;
        FCaretX := i;
      end;
    end;
  end;
end;

procedure TDMemo.PositionChange(Sender: TObject);
begin
  FTopIndex := FUpDown.Position;
end;

procedure TDMemo.RefListWidth(ItemIndex: Integer; nCaret: Integer);
var
  i, Fi, nIndex, nY: Integer;
  TempStr, AddStr: WideString;
begin
  TempStr := '';
  nIndex := 0;
  while True do begin
    if ItemIndex >= FLines.Count then
      Break;
    TempStr := TempStr + TDMemoStringList(FLines).Str[ItemIndex];
    nIndex := Integer(Lines.Objects[ItemIndex]);
    FLines.Delete(ItemIndex);
    if nIndex = 13 then
      Break;
  end;
  if TempStr <> '' then begin
    AddStr := '';
    Fi := 1;
    nY := ItemIndex;
    for i := 1 to Length(TempStr) + 1 do begin
      AddStr := Copy(TempStr, Fi, i - Fi + 1);
      if Canvas.TextWidth(AddStr) > (Width - 20) then begin
        AddStr := Copy(TempStr, Fi, i - Fi);
        Fi := i;
        FLines.InsertObject(ItemIndex, AddStr, nil);
        nIndex := ItemIndex;
        Inc(ItemIndex);
        nY := ItemIndex;
        AddStr := '';
      end;
      if i = nCaret then begin
        FCaretX := i - Fi + 1;
        FCaretY := nY;
        SetCaret(True);
      end;
    end;
    if AddStr <> '' then begin
      FLines.InsertObject(ItemIndex, AddStr, TObject(13));
      nIndex := ItemIndex;
    end
    else begin
      FLines.Objects[nIndex] := TObject(13);
    end;
    if nCaret = -1 then begin
      FCaretY := nIndex;
      FCaretX := Length(WideString(TDMemoStringList(FLines).Str[nIndex]));
      SetCaret(True);
    end;
    {end else
    if nIndex = 13 then begin
      FLines.InsertObject(ItemIndex, '', nil);
      FCaretY := ItemIndex;
      FCaretX := 0;
      SetCaret(True); }
  end;
  if FCaretY >= FLines.Count then begin
    FCaretY := Max(FLines.Count - 1, 0);
    SetCaret(True);
  end;
end;

procedure TDMemo.DownCaret(X, Y: Integer);
var
  tempstrw: WideString;
  i: Integer;
  tempstr: string;
begin
  FCaretY := (y - 2) div 14 + FTopIndex;
  if FCaretY >= FLines.Count then
    FCaretY := Max(FLines.Count - 1, 0);
  FCaretX := 0;
  if FCaretY < FLines.Count then begin
    tempstrw := TDMemoStringList(FLines).Str[FCaretY];
    if tempstrw <> '' then begin
      for i := 1 to Length(tempstrw) do begin
        tempstr := Copy(tempstrw, 1, i);
        if (Canvas.TextWidth(tempstr)) > (X) then
          exit;
        FCaretX := i;
      end;
    end;
  end;
end;

procedure TDMemo.SetCaret(boBottom: Boolean);
var
  nShowCount: Integer;
begin
  FSCaretX := FCaretX;
  FSCaretY := FCaretY;
  if boBottom then begin
    nShowCount := (Height - 2) div 14;
    if FCaretY < FTopIndex then
      FTopIndex := FCaretY
    else begin
      if (FCaretY - FTopIndex) >= nShowCount then begin
        FTopIndex := Max(FCaretY - nShowCount + 1, 0);
      end;
    end;
  end;
end;

procedure TDMemo.SetCaretY(const Value: Integer);
begin
  FCaretY := Value;
  if FCaretY >= FLines.Count then
    FCaretY := Max(FLines.Count - 1, 0);
  if FCaretY < 0 then
    FCaretY := 0;
  SetCaret(True);
end;

procedure TDMemo.SetFocus;
begin
  inherited;
end;

procedure TDMemo.SetUpDown(const Value: TDUpDown);
begin
  FUpDown := Value;
  if FUpDown <> nil then begin
    FUpDown.OnPositionChange := PositionChange;
    FUpDown.Visible := False;
    FUpDown.MaxPosition := 0;
    FUpDown.Position := 0;
  end;
end;

procedure TDMemo.TextChange;
begin
  if Assigned(FOnChange) then
    FOnChange(self);
end;

{ TDMemoStringList }

function TDMemoStringList.Add(const S: string): Integer;
begin
  Result := AddObject(S, TObject(13));
  DMemo.RefListWidth(Result, -1);
end;

function TDMemoStringList.AddObject(const S: string; AObject: TObject): Integer;
var
  AddStr: string;
begin
  AddStr := AnsiReplaceText(S, #13, '');
  AddStr := AnsiReplaceText(AddStr, #10, '');
  if AddStr = '' then begin
    Result := inherited AddObject(#9, AObject);
  end
  else
    Result := inherited AddObject(AddStr, AObject);
end;

procedure TDMemoStringList.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  DMemo.FCaretY := 0;
  DMemo.FCaretX := 0;
  DMemo.SetCaret(False);
end;

procedure TDMemoStringList.Clear;
begin
  inherited;
  DMemo.FCaretY := 0;
  DMemo.FCaretX := 0;
  DMemo.SetCaret(False);
end;

function TDMemoStringList.Get(Index: Integer): string;
begin
  Result := inherited Get(Index);
  Result := AnsiReplaceText(Result, #9, '');
end;

procedure TDMemoStringList.InsertObject(Index: Integer; const S: string;
  AObject: TObject);
var
  AddStr: string;
begin
  AddStr := AnsiReplaceText(S, #13, '');
  AddStr := AnsiReplaceText(AddStr, #10, '');
  if AddStr = '' then begin
    inherited InsertObject(Index, #9, AObject);
  end
  else
    inherited InsertObject(Index, AddStr, AObject);
end;

function TDMemoStringList.GetText: PChar;
var
  i: Integer;
  AddStr: string;
begin
  AddStr := '';
  for i := 0 to Count - 1 do begin
    AddStr := AddStr + Get(i);
    if Char(Objects[i]) = #13 then begin
      AddStr := AddStr + #13;
    end;
  end;
  Result := StrNew(PChar(AddStr));
end;

procedure TDMemoStringList.SaveToFile(const FileName: string);
var
  TempString: TStringList;
  i: Integer;
  AddStr: string;
begin
  TempString := TStringList.Create;
  try
    AddStr := '';
    for i := 0 to Count - 1 do begin
      AddStr := AddStr + Get(i);
      if Char(Objects[i]) = #13 then begin
        TempString.Add(AddStr);
        AddStr := '';
      end;
    end;
    if AddStr <> '' then
      TempString.Add(AddStr);

    TempString.SaveToFile(FileName);
  finally
    TempString.Free;
  end;
end;

procedure TDMemoStringList.LoadFromFile(const FileName: string);
var
  TempString: TStringList;
  i: Integer;
begin
  Clear;
  TempString := TStringList.Create;
  try
    if FileExists(Filename) then begin
      TempString.LoadFromFile(FileName);
      for i := 0 to TempString.Count - 1 do begin
        Add(TempString[i]);
      end;
    end;
  finally
    TempString.Free;
  end;
end;

procedure TDMemoStringList.Put(Index: Integer; const Value: string);
var
  AddStr: string;
begin
  if Value <> '' then begin
    AddStr := AnsiReplaceText(Value, #13, '');
    AddStr := AnsiReplaceText(AddStr, #10, '');
  end
  else
    AddStr := #9;
  inherited Put(Index, AddStr);
end;

function TDMemoStringList.SelfGet(Index: Integer): string;
begin
  Result := inherited Get(Index);
end;

{ TDPopUpMemu }

constructor TDPopUpMemu.Create(AOwner: TComponent);
begin
  inherited;
  FItem := TStringList.Create;
  FVisible := False;
  FIsHide := True;
  FOnPopIndex := nil;
  FHeight := 0;
  FWidth := 0;
  FItemIndex := -1;
  Canvas.Font.Name := DEF_FONT_NAME;
  Canvas.Font.Size := DEFFONTSIZE;
  FHeightOffset := 16;
  FAlpha := 220;
end;

destructor TDPopUpMemu.Destroy;
begin
  FItem.Free;
  inherited;
end;

procedure TDPopUpMemu.DirectPaint(dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  defRect: TRect;
  i: Integer;
  nHeight: Integer;
begin
  if WLib <> nil then begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      defRect.Left := Left;
      defRect.Top := Top;
      defRect.Right := Left + FWidth;
      defRect.Bottom := Top + FHeight { - 4};
      dsurface.DrawAlpha(defRect, d.ClientRect, d, False, FAlpha);
    end;
  end;
  with dsurface.Canvas do begin
    if FItemIndex >= FItem.Count then
      FItemIndex := -1;
    if FItemIndex > -1 then begin
      defRect.Left := Left + 1;
      defRect.Top := Top + (FItemIndex * FHeightOffset) + 2 + MAX(FHeightOffset - 16, 0) div 2;
      defRect.Right := Left + FWidth - 2;
      defRect.Bottom := defRect.Top + Min(FHeightOffset, 16);
      Brush.Color := clBlue;
      FillRect(defRect);
    end;
    nHeight := 2;
    SetBkMode(Handle, TRANSPARENT);
    for i := 0 to FItem.Count - 1 do begin
      BoldTextOut(dsurface, Left + 4, Top + nHeight + (FHeightOffset - 12) div 2, clWhite, clBlack, FItem[i]);
      Inc(nHeight, FHeightOffset);
    end;
    Release;
  end;
end;

function TDPopUpMemu.InRange(x, y: integer): Boolean;
begin
  if (FEnabled) and (x >= Left) and (x < Left + FWidth) and (y >= Top) and
    (y < Top + FHeight) then
    Result := TRUE
  else
    Result := FALSE;
end;

function TDPopUpMemu.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := inherited MouseDown(Button, Shift, X, Y);
  if Result and (FocusedControl = self) then begin
    FItemIndex := (y - Top - 2) div FHeightOffset;
    if (AppendData <> nil) and (TObject(AppendData) is TDControl) and
      (TDControl(AppendData).Visible) then
      if Assigned(FOnPopIndex) then
        FOnPopIndex(Self, AppendData, FItemIndex);
    Visible := False;
  end;
end;

function TDPopUpMemu.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
begin
  Result := inherited MouseMove(Shift, X, Y);
  if Result and (MouseEntryControl = Self) then begin
    FItemIndex := (y - Top - 2) div FHeightOffset;
  end;
end;

procedure TDPopUpMemu.Popup(Sender: TObject; nLeft, nTop: Integer);
begin
  Left := nLeft;
  Top := nTop;
  AppendData := Sender;
  Visible := True;
  if (PopUpDWindow <> Self) and (PopUpDWindow <> nil) then
    PopUpDWindow.Visible := False;
  PopUpDWindow := Self;
end;

procedure TDPopUpMemu.RefSize;
var
  i: Integer;
begin
  FHeight := FItem.Count * FHeightOffset + 4;
  for i := 0 to FItem.Count - 1 do begin
    if (Canvas.TextWidth(FItem[i]) + 8) > FWidth then
      FWidth := Canvas.TextWidth(FItem[i]) + 8;
  end;
end;

procedure TDPopUpMemu.SetItem(const Value: TStrings);
begin
  if Assigned(FItem) then
    FItem.Assign(Value)
  else
    FItem := Value;
  FItemIndex := -1;
  RefSize;
end;

procedure TDPopUpMemu.SetItemIndex(const Value: Integer);
begin
  {if Value >= FItem.Count then FItemIndex := FItem.Count - 1
  else if Value < 0 then FItemIndex := 0
  else }
  FItemIndex := Value;
end;

procedure TDPopUpMemu.SetOffset(const Value: Integer);
begin
  FHeightOffset := Value;
  RefSize;
end;

initialization
  begin
    GetMem(ChrBuff, 2048);
  end;

finalization
  begin
    FreeMem(ChrBuff);
  end;

end.

