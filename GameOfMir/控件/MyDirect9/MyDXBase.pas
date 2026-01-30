unit MyDXBase;

interface
uses
  Windows, Messages, SysUtils, Classes, Controls, MyDirect3D9;

resourcestring
  SDirectSound = '音频设备';
  SDirectSoundBuffer = '音频缓冲';
  SDirectSoundPrimaryBuffer = '主音频缓冲';
  SNotMade = '%s 丢失设备';
  SStreamNotOpend = '尚未初始化';
  SStreamOpend = '已经初始化';
  SInvalidWave = '数据错误';
  SInvalidWaveFormat = '音频格式错误';
  SCannotInitialized = '%s 无法初始化';
  SCannotLock = '%s 无法锁定';
  SCannotMade = '%s 无法创建';
  SNoForm = '没有父窗口';

type
  EDirectXError = class(Exception);
  
  TBlendCoef = (bcZero, bcOne, bcSrcColor, bcInvSrcColor, bcSrcAlpha, bcInvSrcAlpha, bcDestAlpha, bcInvDestAlpha,
    bcDestColor, bcInvDestColor, bcSrcAlphaSat, bcBothSrcAlpha, bcBothInvSrcAlpha, bcBlendFActor, bcInvBlendFActor);

  TBlendOp = (boAdd, boSub, boRevSub, boMin, boMax);
    
  TAsphyreQuality = (aqLow, aqMedium, aqHigh);

  TAlphaLevel = (alNone, alMask, alFull, alExclusive);

  TColorFormat = (COLOR_R3G3B2, COLOR_R5G6B5, COLOR_X8R8G8B8, COLOR_X1R5G5B5,
    COLOR_X4R4G4B4, COLOR_A8R8G8B8, COLOR_A1R5G5B5, COLOR_A4R4G4B4,
    COLOR_A8R3G3B2, COLOR_A2R2G2B2, COLOR_A8, COLOR_UNKNOWN);

  PPoint2 = ^TPoint2;
  TPoint2 = record
    x, y: Single;

    class operator Implicit(val: Real): TPoint2;
    class operator Add(const a, b: TPoint2): TPoint2;
    class operator Subtract(const a, b: TPoint2): TPoint2;
    class operator Multiply(const a, b: TPoint2): TPoint2;
    class operator Trunc(const Point: TPoint2): TPoint;
    class operator Equal(const a, b: TPoint2): Boolean;
    class operator NotEqual(const a, b: TPoint2): Boolean;
  end;

  PPoint3 = ^TPoint3;
  TPoint3 = array[0..2] of TPoint2;

  PPoint4 = ^TPoint4;
  TPoint4 = array[0..3] of TPoint2;

  PPoint5 = ^TPoint5;
  TPoint5 = array[0..4] of TPoint2;

  PPoint6 = ^TPoint6;
  TPoint6 = array[0..5] of TPoint2;

  PPoint7 = ^TPoint7;
  TPoint7 = array[0..6] of TPoint2;

  //---------------------------------------------------------------------------
  PColor4 = ^TColor4;
  TColor4 = array[0..3] of Cardinal;

  //---------------------------------------------------------------------------
  PTexCoord = ^TTexCoord;
  TTexCoord = record
//    Pattern: Integer;
    x, y, w, h: Integer;
    Flip: Boolean;
    Mirror: Boolean;
  end;

  TDirectX = class(TPersistent)
  private
    procedure SetDXResult(Value: HRESULT);
  protected
    FDXResult: HRESULT;
    procedure Check; virtual;
  public
    property DXResult: HRESULT read FDXResult write SetDXResult;
  end;

  TDirectXDriver = class(TCollectionItem)
  private
    FGUID: PGUID;
    FGUID2: TGUID;
    FDescription: string;
    FDriverName: string;
    procedure SetGUID(Value: PGUID);
  public
    property GUID: PGUID read FGUID write SetGUID;
    property Description: string read FDescription write FDescription;
    property DriverName: string read FDriverName write FDriverName;
  end;

  TDirectXDrivers = class(TCollection)
  private
    function GetDriver(Index: Integer): TDirectXDriver;
  public
    constructor Create;
    property Drivers[Index: Integer]: TDirectXDriver read GetDriver; default;
  end;

  TControlSubClassProc = procedure(var Message: TMessage; DefWindowProc: TWndMethod) of object;

  TControlSubClass = class
  private
    FControl: TControl;
    FDefWindowProc: TWndMethod;
    FWindowProc: TControlSubClassProc;
    procedure WndProc(var Message: TMessage);
  public
    constructor Create(Control: TControl; WindowProc: TControlSubClassProc);
    destructor Destroy; override;
  end;

const
  msgDeviceInitialize = $100;
  msgDeviceFinalize   = $101;
  msgDeviceLost       = $102;
  msgDeviceRecovered  = $103;
  msgBeginScene       = $104;
  msgEndScene         = $105;
  msgMonoCanvasBegin  = $200;
  msgMultiCanvasBegin = $201;

  Format2Bytes: array[TColorFormat] of Integer = (1, 2, 4, 2, 2, 4, 2, 2, 2, 1, 1, 0);

  Format2Bits: array[TColorFormat] of Cardinal = ($0233, $0565, $0888, $0555,
    $0444, $8888, $1555, $4444, $8233, $2222, $8000, $0000);

  clWhite4  : TColor4 = ($FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF);
  clBlack4  : TColor4 = ($FF000000, $FF000000, $FF000000, $FF000000);
  clMaroon4 : TColor4 = ($FF000080, $FF000080, $FF000080, $FF000080);
  clGreen4  : TColor4 = ($FF008000, $FF008000, $FF008000, $FF008000);
  clOlive4  : TColor4 = ($FF008080, $FF008080, $FF008080, $FF008080);
  clNavy4   : TColor4 = ($FF800000, $FF800000, $FF800000, $FF800000);
  clPurple4 : TColor4 = ($FF800080, $FF800080, $FF800080, $FF800080);
  clTeal4   : TColor4 = ($FF808000, $FF808000, $FF808000, $FF808000);
  clGray4   : TColor4 = ($FF808080, $FF808080, $FF808080, $FF808080);
  clSilver4 : TColor4 = ($FFC0C0C0, $FFC0C0C0, $FFC0C0C0, $FFC0C0C0);
  clRed4    : TColor4 = ($FF0000FF, $FF0000FF, $FF0000FF, $FF0000FF);
  clLime4   : TColor4 = ($FF00FF00, $FF00FF00, $FF00FF00, $FF00FF00);
  clYellow4 : TColor4 = ($FF00FFFF, $FF00FFFF, $FF00FFFF, $FF00FFFF);
  clBlue4   : TColor4 = ($FFFF0000, $FFFF0000, $FFFF0000, $FFFF0000);
  clFuchsia4: TColor4 = ($FFFF00FF, $FFFF00FF, $FFFF00FF, $FFFF00FF);

  clAqua4   : TColor4 = ($FFFFFF00, $FFFFFF00, $FFFFFF00, $FFFFFF00);
  clLtGray4 : TColor4 = ($FFC0C0C0, $FFC0C0C0, $FFC0C0C0, $FFC0C0C0);
  clDkGray4 : TColor4 = ($FF808080, $FF808080, $FF808080, $FF808080);
  clOpaque4 : TColor4 = ($00FFFFFF, $00FFFFFF, $00FFFFFF, $00FFFFFF);

  tcNull    : TTexCoord = (x: 0; y: 0; w: 0; h: 0; Flip: False; Mirror: False);

  ZeroCoord4: TPoint4 = ((x: 0.0; y: 0.0), (x: 0.0; y: 0.0), (x: 0.0; y: 0.0),
  (x: 0.0; y: 0.0));
          
  fxNone             = $00000001;
  fxAdd              = $00000104;
  fxBlend            = $00000504;
  fxShadow           = $00000500;
  fxMultiply         = $00000200;
  fxInvMultiply      = $00000300;
  fxBlendNA          = $00000302;
  fxSub              = $00010104;
  fxRevSub           = $00020104;
  fxMax              = $00040101;
  fxMin              = $00030101;
  fxAnti             = $00000109;

  fxAddX             = $00000101;
  fxSrcColorAdd      = $00000102;
  fxInvert           = $00000009;
  fxSrcBright        = $00000202;
  fxDestBright       = $00000808;
  fxInvSrcBright     = $00000303;
  fxInvDestBright    = $00000909;
  fxMultiplyX        = $00000800;
  fxMultiplyAlpha    = $00000600;
  fxInvMultiplyX     = $00000900;
  fxOneSrcColor      = $00000201;

  fxAdd2X            = $7FFFFFF0;
  fxLight            = $7FFFFFF1;
  fxLightAdd         = $7FFFFFF2;
  fxBright           = $7FFFFFF3;
  fxBrightAdd        = $7FFFFFF4;
  fxGrayScale        = $7FFFFFF5;
  fxOneColor         = $7FFFFFF6;

var
  Direct3D: IDirect3D9 = nil;
  Direct3DDevice: IDirect3DDevice9 = nil;
  PresentParams: TD3DPresentParameters;
  DeviceCaps: TD3DCaps9;
  Direct3DCompatible: Boolean = False;
  //DirectInput8  : IDirectInput8    = nil;

//---------------------------------------------------------------------------
// DXBestBackFormat()
//
// Attempts to find the best back-buffer format for full-screen mode, that
// complies with the requested attributes.
//---------------------------------------------------------------------------
function DXBestBackFormat(HighDepth: Boolean; Width, Height, Refresh: Integer): TD3DFormat;

//---------------------------------------------------------------------------
// DXGetDisplayFormat()
//
// Retreives the current display format.
// In case of failure, D3DFMT_UNKNOWN is returned.
//---------------------------------------------------------------------------
function DXGetDisplayFormat(): TD3DFormat;

//---------------------------------------------------------------------------
// DXGetDisplayFormat()
//
// Attempts to find an available format for depth-buffer, based on specified
// preference.
//
// NOTICE: The availability of stencil buffer is *NOT* guaranteed!
//---------------------------------------------------------------------------
function DXBestDepthFormat(HighDepth: Boolean; BackFormat: TD3DFormat): TD3DFormat;

function DisplaceRB(Color: Cardinal): Cardinal; stdcall;

function D3DToFormat(Fmt: TD3DFormat): TColorFormat;

function PixelXto32(Source: Pointer; SrcFmt: TColorFormat): Longword;

procedure Pixel32toX(Source: Longword; Dest: Pointer; DestFmt: TColorFormat);

function Point2(x, y: Real): TPoint2;
function Point(x, y: Integer): TPoint;
function pBounds4(_Left, _Top, _Width, _Height: Real): TPoint4;
function cColor4(Color: Cardinal):TColor4; overload;
function cColor4(Color1, Color2, Color3, Color4: Cardinal): TColor4; overload;

procedure Fx2Blend(Effect: Cardinal; out SrcBlend, DestBlend: TBlendCoef; out BlendOp: TBlendOp);

function Max(Val1, Val2: Integer): Integer;
function Min(Val1, Val2: Integer): Integer;
function pRect4(const Rect: TRect): TPoint4;
function FiltrateChar(Char1, Char2: Byte): Boolean;
function D3DDataSize(Fmt: TD3DFormat): Byte;

implementation

{$INCLUDE include\bitconv32.inc}

const
  BackFormats: array[0..4] of TD3DFormat = (
    {  0 }D3DFMT_A8R8G8B8,
    {  1 }D3DFMT_X8R8G8B8,
    {  2 }D3DFMT_A1R5G5B5,
    {  3 }D3DFMT_X1R5G5B5,
    {  4 }D3DFMT_R5G6B5);

  //---------------------------------------------------------------------------
  (*TextureFormats: array[0..9] of TD3DFormat = (
    {  0 }D3DFMT_A8R8G8B8,
    {  1 }D3DFMT_X8R8G8B8,
    {  2 }D3DFMT_A1R5G5B5,
    {  3 }D3DFMT_X1R5G5B5,
    {  4 }D3DFMT_A4R4G4B4,
    {  5 }D3DFMT_X4R4G4B4,
    {  6 }D3DFMT_A8R3G3B2,
    {  7 }D3DFMT_R3G3B2,
    {  8 }D3DFMT_R5G6B5,
    {  9 }D3DFMT_A8);   *)

  //---------------------------------------------------------------------------
  DepthFormats: array[0..5] of TD3DFormat = (
    {  0 }D3DFMT_D24S8,
    {  1 }D3DFMT_D24X8,
    {  2 }D3DFMT_D24X4S4,
    {  3 }D3DFMT_D15S1,
    {  4 }D3DFMT_D32,
    {  5 }D3DFMT_D16);

  //---------------------------------------------------------------------------

class operator TPoint2.Implicit(val: Real): TPoint2;
begin
  Result.x := val;
  Result.y := val;
end;

//---------------------------------------------------------------------------
class operator TPoint2.Add(const a, b: TPoint2): TPoint2;
begin
  Result.x := a.x + b.x;
  Result.y := a.y + b.y;
end;

//---------------------------------------------------------------------------
class operator TPoint2.Subtract(const a, b: TPoint2): TPoint2;
begin
  Result.x := a.x - b.x;
  Result.y := a.y - b.y;
end;

//---------------------------------------------------------------------------
class operator TPoint2.Multiply(const a, b: TPoint2): TPoint2;
begin
  Result.x := a.x * b.x;
  Result.y := a.y * b.y;
end;

//---------------------------------------------------------------------------
class operator TPoint2.Trunc(const Point: TPoint2): TPoint;
begin
  Result.X := Trunc(Point.x);
  Result.Y := Trunc(Point.y);
end;

//---------------------------------------------------------------------------
class operator TPoint2.Equal(const a, b: TPoint2) : Boolean;
begin
  Result := (a.x =  b.x) and (a.y = b.y);
end;

//---------------------------------------------------------------------------
class operator TPoint2.NotEqual(const a, b: TPoint2) : Boolean;
begin
  Result := (a.x <>  b.x) or (a.y <> b.y);
end;

function D3DDataSize(Fmt: TD3DFormat): Byte;
begin
 Result:= 0;
 case Fmt of
  D3DFMT_R5G6B5  : Result:= 2;
  D3DFMT_X8R8G8B8: Result:= 3;
  D3DFMT_X1R5G5B5: Result:= 2;
  D3DFMT_X4R4G4B4: Result:= 2;
  D3DFMT_A8R8G8B8: Result:= 4;
  D3DFMT_A1R5G5B5: Result:= 2;
  D3DFMT_A4R4G4B4: Result:= 2;
  D3DFMT_A8      : Result:= 1;
 end;
end;

function pRect4(const Rect: TRect): TPoint4;
begin
 Result[0].x:= Rect.Left;
 Result[0].y:= Rect.Top;
 Result[1].x:= Rect.Right;
 Result[1].y:= Rect.Top;
 Result[2].x:= Rect.Right;
 Result[2].y:= Rect.Bottom;
 Result[3].x:= Rect.Left;
 Result[3].y:= Rect.Bottom;
end;

function Max(Val1, Val2: Integer): Integer;
begin
  if Val1>=Val2 then Result := Val1 else Result := Val2;
end;

function Min(Val1, Val2: Integer): Integer;
begin
  if Val1<=Val2 then Result := Val1 else Result := Val2;
end;

function DXBestBackFormat(HighDepth: Boolean; Width, Height, Refresh: Integer): TD3DFormat;
const
  LowFormats: array[0..4] of Longword = (4, 3, 1, 2, 0);
  HighFormats: array[0..4] of Longword = (1, 4, 3, 0, 2);
var
  Mode: TD3DDisplayMode;
  Index: Integer;
  Format: TD3DFormat;
  ModeCount: Integer;
  ModeIndex: Integer;
  FormatIndex: ^Longword;
begin
  Result := D3DFMT_UNKNOWN;

  // determine what search list to use
  FormatIndex := @LowFormats[0];
  if (HighDepth) then
    FormatIndex := @HighFormats[0];

  // use the selected search list to look for formats
  for Index := 0 to 4 do
  begin
    // retreive next format in the list
    Format := BackFormats[FormatIndex^];

    // cycle through all supported modes for this format
    ModeCount := Direct3D.GetAdapterModeCount(D3DADAPTER_DEFAULT, Format);
    for ModeIndex := 0 to ModeCount - 1 do
    begin
      // check if the mode is available
      if (Succeeded(Direct3D.EnumAdapterModes(D3DADAPTER_DEFAULT, Format, ModeIndex, Mode))) then
      begin
        if (Integer(Mode.Width) = Width) and (Integer(Mode.Height) = Height) and
          ((Integer(Mode.RefreshRate) = Refresh) or (Refresh = 0)) then
        begin
          Result := Mode.Format;
          Exit;
        end;
      end;
    end;

    Inc(FormatIndex);
  end;
end;

//---------------------------------------------------------------------------

function DXGetDisplayFormat(): TD3DFormat;
var
  Mode: TD3DDisplayMode;
begin
  Result := D3DFMT_UNKNOWN;

  if (Succeeded(Direct3D.GetAdapterDisplayMode(D3DADAPTER_DEFAULT, Mode))) then
    Result := Mode.Format;
end;

function DXBestDepthFormat(HighDepth: Boolean; BackFormat: TD3DFormat): TD3DFormat;
const
  HighFormats: array[0..5] of Integer = (4, 0, 2, 1, 3, 5);
  LowFormats: array[0..5] of Integer = (5, 3, 4, 0, 2, 1);
var
  FormatIndex: ^Longword;
  Index: Integer;
begin
  // determine the search list
  FormatIndex := @LowFormats[0];
  if (HighDepth) then
    FormatIndex := @HighFormats[0];

  // go through the search list
  for Index := 0 to 5 do
  begin
    if (Succeeded(Direct3D.CheckDeviceFormat(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, BackFormat,
      D3DUSAGE_DEPTHSTENCIL, D3DRTYPE_SURFACE, DepthFormats[FormatIndex^]))) then
    begin
      Result := DepthFormats[FormatIndex^];
      Exit;
    end;

    Inc(FormatIndex);
  end;

  Result := D3DFMT_UNKNOWN;
end;

function DisplaceRB(Color: Cardinal): Cardinal; stdcall;
asm
 mov eax, Color
 mov ecx, eax
 mov edx, eax
 and eax, 0FF00FF00h
 and edx, 0000000FFh
 shl edx, 16
 or eax, edx
 mov edx, ecx
 shr edx, 16
 and edx, 0000000FFh
 or eax, edx
 mov Result, eax
end;

function D3DToFormat(Fmt: TD3DFormat): TColorFormat;
begin
  Result := COLOR_UNKNOWN;
  case Fmt of
    D3DFMT_R3G3B2: Result := COLOR_R3G3B2;
    D3DFMT_R5G6B5: Result := COLOR_R5G6B5;
    D3DFMT_X8R8G8B8: Result := COLOR_X8R8G8B8;
    D3DFMT_X1R5G5B5: Result := COLOR_X1R5G5B5;
    D3DFMT_X4R4G4B4: Result := COLOR_X4R4G4B4;
    D3DFMT_A8R8G8B8: Result := COLOR_A8R8G8B8;
    D3DFMT_A1R5G5B5: Result := COLOR_A1R5G5B5;
    D3DFMT_A4R4G4B4: Result := COLOR_A4R4G4B4;
    D3DFMT_A8R3G3B2: Result := COLOR_A8R3G3B2;
    D3DFMT_A8: Result := COLOR_A8;
  end;
end;

function PixelXto32(Source: Pointer; SrcFmt: TColorFormat): Longword;
const
  bAnd: array[0..8] of Longword = (0, 1, 3, 7, 15, 31, 63, 127, 255);
var
  Px: Longword;
  Bits: Word;
  RedBits, GreenBits, BlueBits, AlphaBits: Integer;
  Red, Green, Blue, Alpha: Longword;
begin
  Px := 0;
  Move(Source^, Px, Format2Bytes[SrcFmt]);

  Bits := Format2Bits[SrcFmt];

  RedBits := Bits and $F;
  Red := BitConv32[RedBits, Px and bAnd[RedBits]];

  GreenBits := (Bits shr 4) and $F;
  Green := BitConv32[GreenBits, (Px shr RedBits) and bAnd[GreenBits]];

  BlueBits := (Bits shr 8) and $F;
  Blue := BitConv32[BlueBits, (Px shr (RedBits + GreenBits)) and bAnd[BlueBits]];

  AlphaBits := (Bits shr 12) and $F;
  Alpha := BitConv32[AlphaBits, (Px shr (RedBits + GreenBits + BlueBits)) and bAnd[AlphaBits]];

  Result := Red or (Green shl 8) or (Blue shl 16) or (Alpha shl 24);
end;

function PixelA8R8G8B8_R3G3B2(Color: Longword): Byte; stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  r2 = 3;
  g2 = 3;
  b2 = 2;
begin
{$DEFINE PxInDWORD}{$DEFINE PxOutBYTE}
{$INCLUDE include\pixasm.inc}
end;

//---------------------------------------------------------------------------
// A8R8G8B8 (32-bit) -> R5G6B5 (16-bit)
//---------------------------------------------------------------------------

function PixelA8R8G8B8_R5G6B5(Color: Longword): Word; stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  r2 = 5;
  g2 = 6;
  b2 = 5;
begin
{$DEFINE PxInDWORD}{$DEFINE PxOutWORD}
{$INCLUDE include\pixasm.inc}
end;

//---------------------------------------------------------------------------
// A8R8G8B8 (32-bit) -> X1R5G5B5 (16-bit)
//---------------------------------------------------------------------------

function PixelA8R8G8B8_X1R5G5B5(Color: Longword): Word; stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  r2 = 5;
  g2 = 5;
  b2 = 5;
begin
{$DEFINE PxInDWORD}{$DEFINE PxOutWORD}
{$INCLUDE include\pixasm.inc}
end;

//---------------------------------------------------------------------------
// A8R8G8B8 (32-bit) -> X4R4G4B4 (16-bit)
//---------------------------------------------------------------------------

function PixelA8R8G8B8_X4R4G4B4(Color: Longword): Word; stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  r2 = 4;
  g2 = 4;
  b2 = 4;
begin
{$DEFINE PxInDWORD}{$DEFINE PxOutWORD}
{$INCLUDE include\pixasm.inc}
end;

//---------------------------------------------------------------------------
// A8R8G8B8 (32-bit) -> A1R5G5B5 (16-bit)
//---------------------------------------------------------------------------

function PixelA8R8G8B8_A1R5G5B5(Color: Longword): Word; stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  a2 = 1;
  r2 = 5;
  g2 = 5;
  b2 = 5;
begin
{$DEFINE PxInDWORD}{$DEFINE PxALPHA}{$DEFINE PxOutWORD}
{$INCLUDE include\pixasm.inc}
end;

//---------------------------------------------------------------------------
// A8R8G8B8 (32-bit) -> A4R4G4B4 (16-bit)
//---------------------------------------------------------------------------

function PixelA8R8G8B8_A4R4G4B4(Color: Longword): Word; stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  a2 = 4;
  r2 = 4;
  g2 = 4;
  b2 = 4;
begin
{$DEFINE PxInDWORD}{$DEFINE PxALPHA}{$DEFINE PxOutWORD}
{$INCLUDE include\pixasm.inc}
end;

//---------------------------------------------------------------------------
// A8R8G8B8 (32-bit) -> A8R3G3B2 (16-bit)
//---------------------------------------------------------------------------

function PixelA8R8G8B8_A8R3G3B2(Color: Longword): Word; stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  a2 = 8;
  r2 = 3;
  g2 = 3;
  b2 = 2;
begin
{$DEFINE PxInDWORD}{$DEFINE PxALPHA}{$DEFINE PxOutWORD}
{$INCLUDE include\pixasm.inc}
end;

//---------------------------------------------------------------------------
// A8R8G8B8 (32-bit) -> A2R2G2B2 (8-bit)
//---------------------------------------------------------------------------

function PixelA8R8G8B8_A2R2G2B2(Color: Longword): Byte; stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  a2 = 2;
  r2 = 2;
  g2 = 2;
  b2 = 2;
begin
{$DEFINE PxInDWORD}{$DEFINE PxALPHA}{$DEFINE PxOutBYTE}
{$INCLUDE include\pixasm.inc}
end;

//---------------------------------------------------------------------------
// line A8R8G8B8 (32-bit) -> R3G3B2 (8-bit)
//---------------------------------------------------------------------------

procedure LineA8R8G8B8_R3G3B2(Source, Dest: Pointer; Count: Integer); stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  r2 = 3;
  g2 = 3;
  b2 = 2;
begin
{$DEFINE PxInDWORD}{$DEFINE PxOutBYTE}
{$INCLUDE include\lineasm.inc}
end;

//---------------------------------------------------------------------------
// line A8R8G8B8 (32-bit) -> R5G6B5 (16-bit)
//---------------------------------------------------------------------------

procedure LineA8R8G8B8_R5G6B5(Source, Dest: Pointer; Count: Integer); stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  r2 = 5;
  g2 = 6;
  b2 = 5;
begin
{$DEFINE PxInDWORD}{$DEFINE PxOutWORD}
{$INCLUDE include\lineasm.inc}
end;

//---------------------------------------------------------------------------
// line A8R8G8B8 (32-bit) -> X1R5G5B5 (16-bit)
//---------------------------------------------------------------------------

procedure LineA8R8G8B8_X1R5G5B5(Source, Dest: Pointer; Count: Integer); stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  r2 = 5;
  g2 = 5;
  b2 = 5;
begin
{$DEFINE PxInDWORD}{$DEFINE PxOutWORD}
{$INCLUDE include\lineasm.inc}
end;

//---------------------------------------------------------------------------
// line A8R8G8B8 (32-bit) -> X4R4G4B4 (16-bit)
//---------------------------------------------------------------------------

procedure LineA8R8G8B8_X4R4G4B4(Source, Dest: Pointer; Count: Integer); stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  r2 = 4;
  g2 = 4;
  b2 = 4;
begin
{$DEFINE PxInDWORD}{$DEFINE PxOutWORD}
{$INCLUDE include\lineasm.inc}
end;

//---------------------------------------------------------------------------
// line A8R8G8B8 (32-bit) -> A1R5G5B5 (16-bit)
//---------------------------------------------------------------------------

procedure LineA8R8G8B8_A1R5G5B5(Source, Dest: Pointer; Count: Integer); stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  a2 = 1;
  r2 = 5;
  g2 = 5;
  b2 = 5;
begin
{$DEFINE PxInDWORD}{$DEFINE PxALPHA}{$DEFINE PxOutWORD}
{$INCLUDE include\lineasm.inc}
end;

//---------------------------------------------------------------------------
// line A8R8G8B8 (32-bit) -> A4R4G4B4 (16-bit)
//---------------------------------------------------------------------------

procedure LineA8R8G8B8_A4R4G4B4(Source, Dest: Pointer; Count: Integer); stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  a2 = 4;
  r2 = 4;
  g2 = 4;
  b2 = 4;
begin
{$DEFINE PxInDWORD}{$DEFINE PxALPHA}{$DEFINE PxOutWORD}
{$INCLUDE include\lineasm.inc}
end;

//---------------------------------------------------------------------------
// line A8R8G8B8 (32-bit) -> A8R3G3B2 (16-bit)
//---------------------------------------------------------------------------

procedure LineA8R8G8B8_A8R3G3B2(Source, Dest: Pointer; Count: Integer); stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  a2 = 8;
  r2 = 3;
  g2 = 3;
  b2 = 2;
begin
{$DEFINE PxInDWORD}{$DEFINE PxALPHA}{$DEFINE PxOutWORD}
{$INCLUDE include\lineasm.inc}
end;

//---------------------------------------------------------------------------
// line A8R8G8B8 (32-bit) -> A2R2G2B2 (8-bit)
//---------------------------------------------------------------------------

procedure LineA8R8G8B8_A2R2G2B2(Source, Dest: Pointer; Count: Integer); stdcall;
const
  x1 = 0;
  a1 = 8;
  r1 = 8;
  g1 = 8;
  b1 = 8;
  a2 = 2;
  r2 = 2;
  g2 = 2;
  b2 = 2;
begin
{$DEFINE PxInDWORD}{$DEFINE PxALPHA}{$DEFINE PxOutBYTE}
{$INCLUDE include\lineasm.inc}
end;

procedure Pixel32toX(Source: Longword; Dest: Pointer; DestFmt: TColorFormat);
begin
  case DestFmt of
    COLOR_R3G3B2: PByte(Dest)^ := PixelA8R8G8B8_R3G3B2(Source);
    COLOR_R5G6B5: PWord(Dest)^ := PixelA8R8G8B8_R5G6B5(Source);
    COLOR_X1R5G5B5: PWord(Dest)^ := PixelA8R8G8B8_X1R5G5B5(Source);
    COLOR_X4R4G4B4: PWord(Dest)^ := PixelA8R8G8B8_X4R4G4B4(Source);
    COLOR_A1R5G5B5: PWord(Dest)^ := PixelA8R8G8B8_A1R5G5B5(Source);
    COLOR_A4R4G4B4: PWord(Dest)^ := PixelA8R8G8B8_A4R4G4B4(Source);
    COLOR_A8R3G3B2: PWord(Dest)^ := PixelA8R8G8B8_A8R3G3B2(Source);
    COLOR_A2R2G2B2: PByte(Dest)^ := PixelA8R8G8B8_A2R2G2B2(Source);
    COLOR_X8R8G8B8: PLongword(Dest)^ := Source or $FF000000;
    COLOR_A8R8G8B8: PLongword(Dest)^ := Source;
    COLOR_A8: PByte(Dest)^ := Source shr 24;
  end;
end;

function Point2(x, y: Real): TPoint2;
begin
 Result.x:= x;
 Result.y:= y;
end;

function Point(x, y: Integer): TPoint;
begin
  Result.X := X;
  Result.Y := Y;
end;

procedure Fx2Blend(Effect: Cardinal; out SrcBlend, DestBlend: TBlendCoef; out BlendOp: TBlendOp);
begin
  SrcBlend := TBlendCoef(Effect and $FF);
  DestBlend := TBlendCoef((Effect shr 8) and $FF);
  BlendOp  := TBlendOp((Effect shr 16) and $FF);
end;

function pBounds4(_Left, _Top, _Width, _Height: Real): TPoint4;
begin
 Result[0].X:= _Left;
 Result[0].Y:= _Top;
 Result[1].X:= _Left + _Width;
 Result[1].Y:= _Top;
 Result[2].X:= _Left + _Width;
 Result[2].Y:= _Top + _Height;
 Result[3].X:= _Left;
 Result[3].Y:= _Top + _Height;
end;

function cColor4(Color: Cardinal):TColor4;
begin
  Result[0] := Color;
  Result[1] := Color;
  Result[2] := Color;
  Result[3] := Color;
end;

function cColor4(Color1, Color2, Color3, Color4: Cardinal): TColor4;
begin
  Result[0]:= Color1;
  Result[1]:= Color2;
  Result[2]:= Color3;
  Result[3]:= Color4;
end;

{  TDirectX  }

procedure TDirectX.Check;
begin
end;

procedure TDirectX.SetDXResult(Value: HRESULT);
begin
  FDXResult := Value;
  if FDXResult<>0 then Check;
end;

{  TDirectXDriver  }

procedure TDirectXDriver.SetGUID(Value: PGUID);
begin
  if not IsBadHugeReadPtr(Value, SizeOf(TGUID)) then
  begin
    FGUID2 := Value^;
    FGUID := @FGUID2;
  end else
    FGUID := Value;
end;

{  TDirectXDrivers  }

constructor TDirectXDrivers.Create;
begin
  inherited Create(TDirectXDriver);
end;

function TDirectXDrivers.GetDriver(Index: Integer): TDirectXDriver;
begin
  Result := (inherited Items[Index]) as TDirectXDriver;
end;

{  TControlSubClass  }

constructor TControlSubClass.Create(Control: TControl;
  WindowProc: TControlSubClassProc);
begin
  inherited Create;
  FControl := Control;
  FDefWindowProc := FControl.WindowProc;
  FControl.WindowProc := WndProc;
  FWindowProc := WindowProc;
end;

destructor TControlSubClass.Destroy;
begin
  FControl.WindowProc := FDefWindowProc;
  inherited Destroy;
end;

procedure TControlSubClass.WndProc(var Message: TMessage);
begin
  FWindowProc(Message, FDefWindowProc);
end;

//常规字符检测
function FiltrateChar(Char1, Char2: Byte): Boolean;
begin
  Result := False;
  case Char1 of
    32..126: Result := Char2 = 0;
    //129..160, 176..214, 216..247: Result := (Char2 in [64..126, 128..254]);
    161: Result := (Char2 in [161..254]);
    162: Result := (Char2 in [161..170, 177..226, 229..238, 241..252]);
    163: Result := (Char2 in [161..254]);
    164: Result := (Char2 in [161..243]);
    165: Result := (Char2 in [161..246]);
    166: Result := (Char2 in [161..184, 193..216, 224..235, 238..242, 244, 245]);
    167: Result := (Char2 in [161..193, 209..241]);
    168: Result := (Char2 in [64..126, 128..149, 161..187, 189, 190, 192, 197..233]);
    169: Result := (Char2 in [64..90, 92, 96..126, 128..136, 150, 164..239]);
    176..214, 216..247: Result := (Char2 in [161..254]);
    215: Result := (Char2 in [161..249]);
    {170..175, 248..253: Result := (Char2 in [64..126, 128..160]);
    215: Result := (Char2 in [64..126, 128..249]);
    254: Result := (Char2 in [64..79]); }
  end;
end;

end.

