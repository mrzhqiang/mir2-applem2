{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       BusinessSkinForm                                            }
{       Version 9.45                                                }
{                                                                   }
{       Copyright (c) 2000-2011 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit bspngimage;

interface

{$TYPEDADDRESS OFF}
{$RANGECHECKS OFF} 
{$WARNINGS OFF}
{$HINTS OFF}

{$IFDEF VER220}
{$DEFINE VER200}
{$ENDIF}

{$IFDEF VER210}
{$DEFINE VER200}
{$ENDIF}


{$J+}
//{$DEFINE RegisterPNG}

{$IFDEF VER200}
 Uses PngImage;

 type
   TbsPngImage = class(TPngImage);

{$ELSE}

uses
 Windows, Classes, Graphics, SysUtils, bszlib;

const
  Z_NO_FLUSH      = 0;
  Z_FINISH        = 4;
  Z_STREAM_END    = 1;

  FILTER_NONE    = 0;
  FILTER_SUB     = 1;
  FILTER_UP      = 2;
  FILTER_AVERAGE = 3;
  FILTER_PAETH   = 4;

  COLOR_GRAYSCALE      = 0;
  COLOR_RGB            = 2;
  COLOR_PALETTE        = 3;
  COLOR_GRAYSCALEALPHA = 4;
  COLOR_RGBALPHA       = 6;

type
  TRGBLine = array[word] of TRGBTriple;
  pRGBLine = ^TRGBLine;

  TMAXBITMAPINFO = packed record
    bmiHeader: TBitmapInfoHeader;
    bmiColors: packed array[0..255] of TRGBQuad;
  end;

  TbsPngTransparencyMode = (bsptmNone, bsptmBit, bsptmPngLayerial);
  pCardinal = ^Cardinal;
  pRGBPixel = ^TRGBPixel;
  TRGBPixel = packed record
    B, G, R: Byte;
  end;

  TByteArray = Array[Word] of Byte;
  PByteArray = ^TByteArray;

  TbsPngImage = class;
  PPointerArray = ^TPointerArray;
  TPointerArray = Array[Word] of Pointer;

  TbsPngPointerList = class
  private
    fOwner: TbsPngImage;
    fCount : Cardinal;
    fMemory: pPointerArray;
    function GetItem(Index: Cardinal): Pointer;
    procedure SetItem(Index: Cardinal; const Value: Pointer);
  protected
    function Remove(Value: Pointer): Pointer; virtual;
    procedure Insert(Value: Pointer; Position: Cardinal);
    procedure Add(Value: Pointer);
    property Item[Index: Cardinal]: Pointer read GetItem write SetItem;
    procedure SetSize(const Size: Cardinal);
    property Owner: TbsPngImage read fOwner;
  public
    constructor Create(AOwner: TbsPngImage);
    destructor Destroy; override;
    property Count: Cardinal read fCount write SetSize;
  end;

  TbsPngLayer = class;
  TbsPngLayerClass = class of TbsPngLayer;

  TbsPngList = class(TbsPngPointerList)
  private
    function GetItem(Index: Cardinal): TbsPngLayer;
  public
    function FindPngLayer(PngLayerClass: TbsPngLayerClass): TbsPngLayer;
    procedure RemovePngLayer(PngLayer: TbsPngLayer); overload;
    function Add(PngLayerClass: TbsPngLayerClass): TbsPngLayer;
    function ItemFromClass(PngLayerClass: TbsPngLayerClass): TbsPngLayer;
    property Item[Index: Cardinal]: TbsPngLayer read GetItem;
  end;

  TbsPngLayerIHDR = class;
  TbsPngLayerpHYs = class;
  TbsInterlaceMethod = (bsimNone, bsimAdam7);
  TbsCompressionLevel = 0..9;
  TbsPngFilter = (bspfNone, bspfSub, bspfUp, bspfAverage, bspfPaeth);
  TbsPngFilters = set of TbsPngFilter;

  TbsPngImage = class(TGraphic)
  private
    fMaxIdatSize: Integer;
    fInterlaceMethod: TbsInterlaceMethod;
    fPngLayerList: TbsPngList;
    fCanvas: TCanvas;
    fFilters: TbsPngFilters;
    fCompressionLevel: TbsCompressionLevel;
    procedure ClearPngLayers;
    function HeaderPresent: Boolean;
    procedure GetPixelInfo(var LineSize, Offset: Cardinal);
    procedure SetMaxIdatSize(const Value: Integer);
    function GetAlphaScanline(const LineIndex: Integer): pByteArray;
    function GetScanline(const LineIndex: Integer): Pointer;
    function GetExtraScanline(const LineIndex: Integer): Pointer;
    function GetTransparencyMode: TbsPngTransparencyMode;
    function GetTransparentColor: TColor;
    procedure SetTransparentColor(const Value: TColor);
  protected
    InverseGamma: Array[Byte] of Byte;
    BeingCreated: Boolean;
    procedure InitializeGamma;
    function GetPalette: HPALETTE; override;
    procedure SetPalette(Value: HPALETTE); override;
    procedure DoSetPalette(Value: HPALETTE; const UpdateColors: Boolean);
    function GetWidth: Integer; override;
    function GetHeight: Integer; override;
    procedure SetWidth(Value: Integer);  override;
    procedure SetHeight(Value: Integer); override;
    procedure AssignPNG(Source: TbsPngImage);
    function GetEmpty: Boolean; override; 
    function GetHeader: TbsPngLayerIHDR;
    procedure DrawPngLayerialTrans(DC: HDC; Rect: TRect);
    function GetTransparent: Boolean; override;
    function GetPixels(const X, Y: Integer): TColor; virtual;
    procedure SetPixels(const X, Y: Integer; const Value: TColor); virtual;
  public
    GammaTable: Array[Byte] of Byte;
    procedure Resize(const CX, CY: Integer);
    procedure CreateAlpha;
    procedure RemoveTransparency;
    procedure Assign(Source: TPersistent);override;
    procedure AssignTo(Dest: TPersistent);override;
    procedure AssignHandle(Handle: HBitmap; Transparent: Boolean;
      TransparentColor: ColorRef);
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
    constructor Create; override;
    constructor CreateBlank(ColorType, Bitdepth: Cardinal; cx, cy: Integer);
    destructor Destroy; override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromResourceName(Instance: HInst; const Name: String);
    procedure LoadFromResourceID(Instance: HInst; ResID: Integer);
    property TransparentColor: TColor read GetTransparentColor write
      SetTransparentColor;
    property Scanline[const Index: Integer]: Pointer read GetScanline;
    property ExtraScanline[const Index: Integer]: Pointer read GetExtraScanline;
    property AlphaScanline[const Index: Integer]: pByteArray read
      GetAlphaScanline;
    property Canvas: TCanvas read fCanvas;
    property Header: TbsPngLayerIHDR read GetHeader;
    property TransparencyMode: TbsPngTransparencyMode read GetTransparencyMode;

    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property InterlaceMethod: TbsInterlaceMethod read fInterlaceMethod
      write fInterlaceMethod;
    property Filters: TbsPngFilters read fFilters write fFilters;
    property MaxIdatSize: Integer read fMaxIdatSize write SetMaxIdatSize;
    property Empty: Boolean read GetEmpty;
    property CompressionLevel: TbsCompressionLevel read fCompressionLevel
      write fCompressionLevel;
    property PngLayers: TbsPngList read fPngLayerList;
    property Pixels[const X, Y: Integer]: TColor read GetPixels write SetPixels;
  end;

  TbsPngLayerName = Array[0..3] of Char;

  TbsPngLayer = class
  private
    fData: Pointer;
    fDataSize: Cardinal;
    fOwner: TbsPngImage;
    fName: TbsPngLayerName;
    function GetHeader: TbsPngLayerIHDR;
    function GetIndex: Integer;
    class function GetName: String; virtual;
    function GetPngLayerName: String;
  public
    procedure ResizeData(const NewSize: Cardinal);
    procedure Assign(Source: TbsPngLayer); virtual;
    constructor Create(Owner: TbsPngImage); virtual;
    destructor Destroy; override;
    function LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
      Size: Integer): Boolean; virtual;
    function SaveData(Stream: TStream): Boolean;
    function SaveToStream(Stream: TStream): Boolean; virtual;
    property Index: Integer read GetIndex;
    property Header: TbsPngLayerIHDR read GetHeader;
    property Data: Pointer read fData;
    property DataSize: Cardinal read fDataSize;
    property Owner: TbsPngImage read fOwner;
    property Name: String read GetPngLayerName;
  end;

  TbsPngLayerIEND = class(TbsPngLayer); 

  pIHDRData = ^TIHDRData;
  TIHDRData = packed record
    Width, Height: Cardinal;
    BitDepth,
    ColorType,
    CompressionMethod,
    FilterMethod,
    InterlaceMethod: Byte;
  end;

  TbsPngLayerIHDR = class(TbsPngLayer)
  private
    ImageHandle: HBitmap;
    ImageDC: HDC;
    ImagePalette: HPalette;
    HasPalette: Boolean;
    BitmapInfo: TMaxBitmapInfo;
    ExtraImageData: Pointer;
    ImageData: pointer;
    ImageAlpha: Pointer;
    IHDRData: TIHDRData;
  protected
    BytesPerRow: Integer;
    function CreateGrayscalePalette(Bitdepth: Integer): HPalette;
    procedure PaletteToDIB(Palette: HPalette);
    procedure PrepareImageData;
    procedure FreeImageData;
  public
    function LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
      Size: Integer): Boolean; override;
    function SaveToStream(Stream: TStream): Boolean; override;
    constructor Create(Owner: TbsPngImage); override;
    destructor Destroy; override;
    procedure Assign(Source: TbsPngLayer); override;

    property ImageHandleValue: HBitmap read ImageHandle;
    property Width: Cardinal read IHDRData.Width write IHDRData.Width;
    property Height: Cardinal read IHDRData.Height write IHDRData.Height;
    property BitDepth: Byte read IHDRData.BitDepth write IHDRData.BitDepth;
    property ColorType: Byte read IHDRData.ColorType write IHDRData.ColorType;
    property CompressionMethod: Byte read IHDRData.CompressionMethod
      write IHDRData.CompressionMethod;
    property FilterMethod: Byte read IHDRData.FilterMethod
      write IHDRData.FilterMethod;
    property InterlaceMethod: Byte read IHDRData.InterlaceMethod
      write IHDRData.InterlaceMethod;

  end;

  pUnitType = ^TUnitType;
  TUnitType = (utUnknown, utMeter);
  TbsPngLayerpHYs = class(TbsPngLayer)
  private
    fPPUnitX, fPPUnitY: Cardinal;
    fUnit: TUnitType;
  public
    function LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
      Size: Integer): Boolean; override;
    function SaveToStream(Stream: TStream): Boolean; override;
    procedure Assign(Source: TbsPngLayer); override;
    property PPUnitX: Cardinal read fPPUnitX write fPPUnitX;
    property PPUnitY: Cardinal read fPPUnitY write fPPUnitY;
    property UnitType: TUnitType read fUnit write fUnit;
  end;

  TbsPngLayergAMA = class(TbsPngLayer)
  private
    function GetValue: Cardinal;
    procedure SetValue(const Value: Cardinal);
  public
    function LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
      Size: Integer): Boolean; override;
    constructor Create(Owner: TbsPngImage); override;
    procedure Assign(Source: TbsPngLayer); override;
    property Gamma: Cardinal read GetValue write SetValue;
  end;

  TZStreamRec2 = packed record
    ZLIB: z_stream;
    Data: Pointer;
    fStream   : TStream;
  end;

  TbsPngLayerPLTE = class(TbsPngLayer)
  protected
    fCount: Integer;
  private
    function GetPaletteItem(Index: Byte): TRGBQuad;
  public
    property Item[Index: Byte]: TRGBQuad read GetPaletteItem;
    property Count: Integer read fCount;
    function LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
      Size: Integer): Boolean; override;
    function SaveToStream(Stream: TStream): Boolean; override;
    procedure Assign(Source: TbsPngLayer); override;
  end;

  TbsPngLayertRNS = class(TbsPngLayer)
  private
    fBitTransparency: Boolean;
    function GetTransparentColor: ColorRef;
    procedure SetTransparentColor(const Value: ColorRef);
  public
    PaletteValues: Array[Byte] of Byte;
    function LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
      Size: Integer): Boolean; override;
    function SaveToStream(Stream: TStream): Boolean; override;
    procedure Assign(Source: TbsPngLayer); override;
    property BitTransparency: Boolean read fBitTransparency;
    property TransparentColor: ColorRef read GetTransparentColor write
      SetTransparentColor;
  end;

  TbsPngLayerIDAT = class(TbsPngLayer)
  private
    Header: TbsPngLayerIHDR;
    ImageWidth, ImageHeight: Integer;
    Row_Bytes, Offset : Cardinal;
    Encode_Buffer: Array[0..5] of pByteArray;
    Row_Buffer: Array[Boolean] of pByteArray;
    RowUsed: Boolean;
    EndPos: Integer;
    procedure FilterRow;
    function FilterToEncode: Byte;
    function IDATZlibRead(var ZLIBStream: TZStreamRec2; Buffer: Pointer;
      Count: Integer; var EndPos: Integer; var crcfile: Cardinal): Integer;
    procedure IDATZlibWrite(var ZLIBStream: TZStreamRec2; Buffer: Pointer;
      const Length: Cardinal);
    procedure FinishIDATZlib(var ZLIBStream: TZStreamRec2);
    procedure PreparePalette;
  protected
    procedure DecodeInterlacedAdam7(Stream: TStream;
      var ZLIBStream: TZStreamRec2; const Size: Integer; var crcfile: Cardinal);
    procedure DecodeNonInterlaced(Stream: TStream;
      var ZLIBStream: TZStreamRec2; const Size: Integer;
      var crcfile: Cardinal);
  protected
    procedure EncodeNonInterlaced(Stream: TStream;
      var ZLIBStream: TZStreamRec2);
    procedure EncodeInterlacedAdam7(Stream: TStream;
      var ZLIBStream: TZStreamRec2);
  protected
    procedure CopyNonInterlacedRGB8(
      Src, Dest, Trans, Extra: pChar);
    procedure CopyNonInterlacedRGB16(
      Src, Dest, Trans, Extra: pChar);
    procedure CopyNonInterlacedPalette148(
      Src, Dest, Trans, Extra: pChar);
    procedure CopyNonInterlacedPalette2(
      Src, Dest, Trans, Extra: pChar);
    procedure CopyNonInterlacedGray2(
      Src, Dest, Trans, Extra: pChar);
    procedure CopyNonInterlacedGrayscale16(
      Src, Dest, Trans, Extra: pChar);
    procedure CopyNonInterlacedRGBAlpha8(
      Src, Dest, Trans, Extra: pChar);
    procedure CopyNonInterlacedRGBAlpha16(
      Src, Dest, Trans, Extra: pChar);
    procedure CopyNonInterlacedGrayscaleAlpha8(
      Src, Dest, Trans, Extra: pChar);
    procedure CopyNonInterlacedGrayscaleAlpha16(
      Src, Dest, Trans, Extra: pChar);
    procedure CopyInterlacedRGB8(const Pass: Byte;
      Src, Dest, Trans, Extra: pChar);
    procedure CopyInterlacedRGB16(const Pass: Byte;
      Src, Dest, Trans, Extra: pChar);
    procedure CopyInterlacedPalette148(const Pass: Byte;
      Src, Dest, Trans, Extra: pChar);
    procedure CopyInterlacedPalette2(const Pass: Byte;
      Src, Dest, Trans, Extra: pChar);
    procedure CopyInterlacedGray2(const Pass: Byte;
      Src, Dest, Trans, Extra: pChar);
    procedure CopyInterlacedGrayscale16(const Pass: Byte;
      Src, Dest, Trans, Extra: pChar);
    procedure CopyInterlacedRGBAlpha8(const Pass: Byte;
      Src, Dest, Trans, Extra: pChar);
    procedure CopyInterlacedRGBAlpha16(const Pass: Byte;
      Src, Dest, Trans, Extra: pChar);
    procedure CopyInterlacedGrayscaleAlpha8(const Pass: Byte;
      Src, Dest, Trans, Extra: pChar);
    procedure CopyInterlacedGrayscaleAlpha16(const Pass: Byte;
      Src, Dest, Trans, Extra: pChar);
  protected
    procedure EncodeNonInterlacedRGB8(Src, Dest, Trans: pChar);
    procedure EncodeNonInterlacedRGB16(Src, Dest, Trans: pChar);
    procedure EncodeNonInterlacedGrayscale16(Src, Dest, Trans: pChar);
    procedure EncodeNonInterlacedPalette148(Src, Dest, Trans: pChar);
    procedure EncodeNonInterlacedRGBAlpha8(Src, Dest, Trans: pChar);
    procedure EncodeNonInterlacedRGBAlpha16(Src, Dest, Trans: pChar);
    procedure EncodeNonInterlacedGrayscaleAlpha8(Src, Dest, Trans: pChar);
    procedure EncodeNonInterlacedGrayscaleAlpha16(Src, Dest, Trans: pChar);
    procedure EncodeInterlacedRGB8(const Pass: Byte; Src, Dest, Trans: pChar);
    procedure EncodeInterlacedRGB16(const Pass: Byte; Src, Dest, Trans: pChar);
    procedure EncodeInterlacedPalette148(const Pass: Byte;
      Src, Dest, Trans: pChar);
    procedure EncodeInterlacedGrayscale16(const Pass: Byte;
      Src, Dest, Trans: pChar);
    procedure EncodeInterlacedRGBAlpha8(const Pass: Byte;
      Src, Dest, Trans: pChar);
    procedure EncodeInterlacedRGBAlpha16(const Pass: Byte;
      Src, Dest, Trans: pChar);
    procedure EncodeInterlacedGrayscaleAlpha8(const Pass: Byte;
      Src, Dest, Trans: pChar);
    procedure EncodeInterlacedGrayscaleAlpha16(const Pass: Byte;
      Src, Dest, Trans: pChar);
  public
    function LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
      Size: Integer): Boolean; override;
    function SaveToStream(Stream: TStream): Boolean; override;
  end;

  TbsPngLayertIME = class(TbsPngLayer)
  private
    fYear: Word;
    fMonth, fDay, fHour, fMinute, fSecond: Byte;
  public
    function LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
      Size: Integer): Boolean; override;
    function SaveToStream(Stream: TStream): Boolean; override;
    procedure Assign(Source: TbsPngLayer); override;
    property Year: Word read fYear write fYear;
    property Month: Byte read fMonth write fMonth;
    property Day: Byte read fDay write fDay;
    property Hour: Byte read fHour write fHour;
    property Minute: Byte read fMinute write fMinute;
    property Second: Byte read fSecond write fSecond;
  end;

  TbsPngLayertEXt = class(TbsPngLayer)
  private
    fKeyword, fText: String;
  public
    function LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
      Size: Integer): Boolean; override;
    function SaveToStream(Stream: TStream): Boolean; override;
    procedure Assign(Source: TbsPngLayer); override;
    property Keyword: String read fKeyword write fKeyword;
    property Text: String read fText write fText;
  end;

  TbsPngLayerzTXt = class(TbsPngLayertEXt)
    function LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
      Size: Integer): Boolean; override;
    function SaveToStream(Stream: TStream): Boolean; override;
  end;

procedure RegisterPngLayer(PngLayerClass: TbsPngLayerClass);
function update_crc(crc: Integer; buf: pByteArray; len: Integer): Cardinal;
function ByteSwap(const a: integer): integer;

{$ENDIF}

implementation

{$IFNDEF VER200}

var
  PngLayerClasses: TbsPngPointerList;
  crc_table: Array[0..255] of Cardinal;
  crc_table_computed: Boolean;

procedure DrawTransparentBitmap(dc: HDC; srcBits: Pointer;
  var srcHeader: TBitmapInfoHeader;
  srcBitmapInfo: pBitmapInfo; Rect: TRect; cTransparentColor: COLORREF);
var
  cColor:   COLORREF;
  bmAndBack, bmAndObject, bmAndMem: HBITMAP;
  bmBackOld, bmObjectOld, bmMemOld: HBITMAP;
  hdcMem, hdcBack, hdcObject, hdcTemp: HDC;
  ptSize, orgSize: TPOINT;
  OldBitmap, DrawBitmap: HBITMAP;
begin
  hdcTemp := CreateCompatibleDC(dc);

  DrawBitmap := CreateDIBitmap(dc, srcHeader, CBM_INIT, srcBits, srcBitmapInfo^,
    DIB_RGB_COLORS);
  OldBitmap := SelectObject(hdcTemp, DrawBitmap);

  OrgSize.x := abs(srcHeader.biWidth);
  OrgSize.y := abs(srcHeader.biHeight);
  ptSize.x := Rect.Right - Rect.Left;
  ptSize.y := Rect.Bottom - Rect.Top;

  hdcBack  := CreateCompatibleDC(dc);
  hdcObject := CreateCompatibleDC(dc);
  hdcMem   := CreateCompatibleDC(dc);

  bmAndBack  := CreateBitmap(ptSize.x, ptSize.y, 1, 1, nil);
  bmAndObject := CreateBitmap(ptSize.x, ptSize.y, 1, 1, nil);

  bmAndMem   := CreateCompatibleBitmap(dc, ptSize.x, ptSize.y);

  bmBackOld  := SelectObject(hdcBack, bmAndBack);
  bmObjectOld := SelectObject(hdcObject, bmAndObject);
  bmMemOld   := SelectObject(hdcMem, bmAndMem);

  cColor := SetBkColor(hdcTemp, cTransparentColor);

  StretchBlt(hdcObject, 0, 0, ptSize.x, ptSize.y, hdcTemp, 0, 0,
    orgSize.x, orgSize.y, SRCCOPY);

  SetBkColor(hdcTemp, cColor);

  BitBlt(hdcBack, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0,
       NOTSRCCOPY);

  BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, dc, Rect.Left, Rect.Top,
       SRCCOPY);

  BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, SRCAND);

  StretchBlt(hdcTemp, 0, 0, OrgSize.x, OrgSize.y, hdcBack, 0, 0,
    PtSize.x, PtSize.y, SRCAND);

  StretchBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, hdcTemp, 0, 0,
    OrgSize.x, OrgSize.y, SRCPAINT);

  BitBlt(dc, Rect.Left, Rect.Top, ptSize.x, ptSize.y, hdcMem, 0, 0, SRCCOPY);

  DeleteObject(SelectObject(hdcBack, bmBackOld));
  DeleteObject(SelectObject(hdcObject, bmObjectOld));
  DeleteObject(SelectObject(hdcMem, bmMemOld));
  DeleteObject(SelectObject(hdcTemp, OldBitmap));

  DeleteDC(hdcMem);
  DeleteDC(hdcBack);
  DeleteDC(hdcObject);
  DeleteDC(hdcTemp);
end;

procedure make_crc_table;
var
  c: Cardinal;
  n, k: Integer;
begin
  for n := 0 to 255 do
  begin
    c := Cardinal(n);
    for k := 0 to 7 do
    begin
      if Boolean(c and 1) then
        c := $edb88320 xor (c shr 1)
      else
        c := c shr 1;
    end;
    crc_table[n] := c;
  end;
  crc_table_computed := true;
end;

function update_crc(crc: Integer; buf: pByteArray; len: Integer): Cardinal;
var
  c: Cardinal;
  n: Integer;
begin
  c := crc;
  if not crc_table_computed then make_crc_table;
  for n := 0 to len - 1 do
    c := crc_table[(c XOR buf^[n]) and $FF] XOR (c shr 8);
  Result := c;
end;

function PaethPredictor(a, b, c: Byte): Byte;
var
  pa, pb, pc: Integer;
begin
  pa := abs(b - c);
  pb := abs(a - c);
  pc := abs(a + b - c * 2);
  if (pa <= pb) and (pa <= pc) then
    Result := a
  else
    if pb <= pc then
      Result := b
    else
      Result := c;
end;

function ByteSwap(const a: integer): integer;
asm
  bswap eax
end;

function ByteSwap16(inp:word): word;
asm
  bswap eax
  shr   eax, 16
end;

function BytesForPixels(const Pixels: Integer; const ColorType,
  BitDepth: Byte): Integer;
begin
  case ColorType of
    COLOR_GRAYSCALE, COLOR_PALETTE:
      Result := (Pixels * BitDepth + 7) div 8;
    COLOR_RGB:
      Result := (Pixels * BitDepth * 3) div 8;
    COLOR_GRAYSCALEALPHA:
      Result := (Pixels * BitDepth * 2) div 8;
    COLOR_RGBALPHA:
      Result := (Pixels * BitDepth * 4) div 8;
    else
      Result := 0;
  end; 
end;

type
  pPngLayerClassInfo = ^TbsPngLayerClassInfo;
  TbsPngLayerClassInfo = record
    ClassName: TbsPngLayerClass;
  end;

procedure RegisterPngLayer(PngLayerClass: TbsPngLayerClass);
var
  NewClass: pPngLayerClassInfo;
begin
  if PngLayerClasses = nil then PngLayerClasses := TbsPngPointerList.Create(nil);
  new(NewClass);
  NewClass^.ClassName := PngLayerClass;
  PngLayerClasses.Add(NewClass);
end;

procedure FreePngLayerClassList;
var
  i: Integer;
begin
  if (PngLayerClasses <> nil) then
  begin
    FOR i := 0 TO PngLayerClasses.Count - 1 do
      Dispose(pPngLayerClassInfo(PngLayerClasses.Item[i]));
    PngLayerClasses.Free;
  end;
end;

procedure RegisterCommonPngLayers;
begin
  RegisterPngLayer(TbsPngLayerIEND);
  RegisterPngLayer(TbsPngLayerIHDR);
  RegisterPngLayer(TbsPngLayerIDAT);
  RegisterPngLayer(TbsPngLayerPLTE);
  RegisterPngLayer(TbsPngLayergAMA);
  RegisterPngLayer(TbsPngLayertRNS);
  RegisterPngLayer(TbsPngLayerpHYs);
  RegisterPngLayer(TbsPngLayertIME);
  RegisterPngLayer(TbsPngLayertEXt);
  RegisterPngLayer(TbsPngLayerzTXt);
end;

function CreateClassPngLayer(Owner: TbsPngImage; Name: TbsPngLayerName): TbsPngLayer;
var
  i       : Integer;
  NewPngLayer: TbsPngLayerClass;
begin
  NewPngLayer := TbsPngLayer;
  if Assigned(PngLayerClasses) then
    FOR i := 0 TO PngLayerClasses.Count - 1 DO
    begin
      if pPngLayerClassInfo(PngLayerClasses.Item[i])^.ClassName.GetName = Name then
      begin
        NewPngLayer := pPngLayerClassInfo(PngLayerClasses.Item[i])^.ClassName;
        break;
      end;
    end;
  Result := NewPngLayer.Create(Owner);
  Result.fName := Name;
end;

const
  ZLIBAllocate = High(Word);

function ZLIBInitInflate(Stream: TStream): TZStreamRec2;
begin
  Fillchar(Result, SIZEOF(TZStreamRec2), #0);
  with Result do
  begin
    GetMem(Data, ZLIBAllocate);
    fStream := Stream;
  end;
  InflateInit_(@Result.zlib, zlib_version, SIZEOF(z_stream));
end;

function ZLIBInitDeflate(Stream: TStream;
  Level: TbsCompressionlevel; Size: Cardinal): TZStreamRec2;
begin
  Fillchar(Result, SIZEOF(TZStreamRec2), #0);
  with Result do
  begin
    GetMem(Data, Size);
    fStream := Stream;
    ZLIB.next_out := Data;
    ZLIB.avail_out := Size;
  end;
  deflateInit_(@Result.zlib, Level, zlib_version, sizeof(z_stream));
end;

procedure ZLIBTerminateDeflate(var ZLIBStream: TZStreamRec2);
begin
  DeflateEnd(ZLIBStream.zlib);
  FreeMem(ZLIBStream.Data, ZLIBAllocate);
end;

procedure ZLIBTerminateInflate(var ZLIBStream: TZStreamRec2);
begin
  InflateEnd(ZLIBStream.zlib);
  FreeMem(ZLIBStream.Data, ZLIBAllocate);
end;

function DecompressZLIB(const Input: Pointer; InputSize: Integer;
  var Output: Pointer; var OutputSize: Integer;
  var ErrorOutput: String): Boolean;
var
  StreamRec : z_stream;
  Buffer    : Array[Byte] of Byte;
  InflateRet: Integer;
begin
  with StreamRec do
  begin
    Result := True;
    OutputSize := 0;
    FillChar(StreamRec, SizeOf(z_stream), #0);
    InflateInit_(@StreamRec, zlib_version, SIZEOF(z_stream));
    next_in := Input;
    avail_in := InputSize;
    repeat
      if (avail_out = 0) then
      begin
        next_out := @Buffer;
        avail_out := SizeOf(Buffer);
      end; 
      InflateRet := inflate(StreamRec, 0);
      if (InflateRet = Z_STREAM_END) or (InflateRet = 0) then
      begin
        inc(OutputSize, total_out);
        if Output = nil then
          GetMem(Output, OutputSize) else ReallocMem(Output, OutputSize);
        CopyMemory(Ptr(Longint(Output) + OutputSize - total_out),
          @Buffer, total_out);
      end
      else if InflateRet < 0 then
      begin
        Result := False;
        ErrorOutput := StreamRec.msg;
        InflateEnd(StreamRec);
        Exit;
      end;
    until InflateRet = Z_STREAM_END;
    InflateEnd(StreamRec);
  end;
end;

function CompressZLIB(Input: Pointer; InputSize, CompressionLevel: Integer;
  var Output: Pointer; var OutputSize: Integer;
  var ErrorOutput: String): Boolean;
var
  StreamRec : z_stream;
  Buffer    : Array[Byte] of Byte;
  DeflateRet: Integer;
begin
  with StreamRec do
  begin
    Result := True;
    FillChar(StreamRec, SizeOf(z_stream), #0);
    DeflateInit_(@StreamRec, CompressionLevel,zlib_version, SIZEOF(StreamRec));

    next_in := Input;
    avail_in := InputSize;

    while avail_in > 0 do
    begin
      if avail_out = 0 then
      begin
        next_out := @Buffer;
        avail_out := SizeOf(Buffer);
      end;

      DeflateRet := deflate(StreamRec, Z_FINISH);

      if (DeflateRet = Z_STREAM_END) or (DeflateRet = 0) then
      begin
        inc(OutputSize, total_out);
        if Output = nil then
          GetMem(Output, OutputSize) else ReallocMem(Output, OutputSize);

        CopyMemory(Ptr(Longint(Output) + OutputSize - total_out),
          @Buffer, total_out);
      end
      else if DeflateRet < 0 then
      begin
        Result := False;
        ErrorOutput := StreamRec.msg;
        DeflateEnd(StreamRec);
        Exit;
      end;

    end;
    DeflateEnd(StreamRec);
  end;
end;

{TbsPngPointerList}

constructor TbsPngPointerList.Create(AOwner: TbsPngImage);
begin
  inherited Create;
  fOwner := AOwner;
  fMemory := nil;
  fCount := 0;
end;

function TbsPngPointerList.Remove(Value: Pointer): Pointer;
var
  I, Position: Integer;
begin
  Position := -1;
  FOR I := 0 TO Count - 1 DO
    if Value = Item[I] then Position := I;
  if Position >= 0 then
  begin
    Result := Item[Position];
    Dec(fCount);
    if Position < Integer(FCount) then
      System.Move(fMemory^[Position + 1], fMemory^[Position],
      (Integer(fCount) - Position) * SizeOf(Pointer));
  end {if Position >= 0} else Result := nil
end;

procedure TbsPngPointerList.Add(Value: Pointer);
begin
  Count := Count + 1;
  Item[Count - 1] := Value;
end;

destructor TbsPngPointerList.Destroy;
begin
  if fMemory <> nil then
    FreeMem(fMemory, fCount * sizeof(Pointer));
  inherited Destroy;
end;

function TbsPngPointerList.GetItem(Index: Cardinal): Pointer;
begin
  if (Index <= Count - 1) then
    Result := fMemory[Index]
  else
    Result := nil;
end;

procedure TbsPngPointerList.Insert(Value: Pointer; Position: Cardinal);
begin
  if (Position < Count) or (Count = 0) then
  begin
    SetSize(Count + 1);
    if Position < Count then
      System.Move(fMemory^[Position], fMemory^[Position + 1],
        (Count - Position - 1) * SizeOf(Pointer));
    Item[Position] := Value;
  end;
end;

procedure TbsPngPointerList.SetItem(Index: Cardinal; const Value: Pointer);
begin
  if (Index <= Count - 1) then
    fMemory[Index] := Value
end;

procedure TbsPngPointerList.SetSize(const Size: Cardinal);
begin
  if (fMemory = nil) and (Size > 0) then
    GetMem(fMemory, Size * SIZEOF(Pointer))
  else
    if Size > 0 then
      ReallocMem(fMemory, Size * SIZEOF(Pointer))
    else
    begin
      FreeMem(fMemory);
      fMemory := nil;
    end;
  fCount := Size;
end;

{TbsPngList}

function TbsPngList.FindPngLayer(PngLayerClass: TbsPngLayerClass): TbsPngLayer;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Item[i] is PngLayerClass then
    begin
      Result := Item[i];
      Break
    end
end;

procedure TbsPngList.RemovePngLayer(PngLayer: TbsPngLayer);
begin
  Remove(PngLayer);
  PngLayer.Free
end;

function TbsPngList.Add(PngLayerClass: TbsPngLayerClass): TbsPngLayer;
var
  IHDR: TbsPngLayerIHDR;
  IEND: TbsPngLayerIEND;

  IDAT: TbsPngLayerIDAT;
  PLTE: TbsPngLayerPLTE;
begin
  Result := nil; 
  if ((PngLayerClass = TbsPngLayerIHDR) or (PngLayerClass = TbsPngLayerIDAT) or
    (PngLayerClass = TbsPngLayerPLTE) or (PngLayerClass = TbsPngLayerIEND)) and not
    (Owner.BeingCreated)
    then
      begin
      end
  else if ((PngLayerClass = TbsPngLayergAMA) and (ItemFromClass(TbsPngLayergAMA) <> nil)) or
     ((PngLayerClass = TbsPngLayertRNS) and (ItemFromClass(TbsPngLayertRNS) <> nil)) or
     ((PngLayerClass = TbsPngLayerpHYs) and (ItemFromClass(TbsPngLayerpHYs) <> nil)) then
     begin
     end
  else if ((ItemFromClass(TbsPngLayerIEND) = nil) or
    (ItemFromClass(TbsPngLayerIHDR) = nil)) and not Owner.BeingCreated then
    begin
    end
  else
  begin
    IHDR := ItemFromClass(TbsPngLayerIHDR) as TbsPngLayerIHDR;
    IEND := ItemFromClass(TbsPngLayerIEND) as TbsPngLayerIEND;
    Result := PngLayerClass.Create(Owner);
    if (PngLayerClass = TbsPngLayergAMA) or (PngLayerClass = TbsPngLayerpHYs) or
      (PngLayerClass = TbsPngLayerPLTE) then
      Insert(Result, IHDR.Index + 1)
    else if (PngLayerClass = TbsPngLayerIEND) then
      Insert(Result, Count)
    else if (PngLayerClass = TbsPngLayerIHDR) then
      Insert(Result, 0)
    else if (PngLayerClass = TbsPngLayertRNS) then
    begin
      IDAT := ItemFromClass(TbsPngLayerIDAT) as TbsPngLayerIDAT;
      PLTE := ItemFromClass(TbsPngLayerPLTE) as TbsPngLayerPLTE;
      if Assigned(PLTE) then
        Insert(Result, PLTE.Index + 1)
      else if Assigned(IDAT) then
        Insert(Result, IDAT.Index)
      else
        Insert(Result, IHDR.Index + 1)
    end
    else
      Insert(Result, IEND.Index);
  end 
end;

function TbsPngList.GetItem(Index: Cardinal): TbsPngLayer;
begin
  Result := inherited GetItem(Index);
end;

function TbsPngList.ItemFromClass(PngLayerClass: TbsPngLayerClass): TbsPngLayer;
var
  i: Integer;
begin
  Result := nil;
  FOR i := 0 TO Count - 1 DO
    if Item[i] is PngLayerClass then
    begin
      Result := Item[i];
      break;
    end {if}
end;

{TbsPngLayer}

procedure TbsPngLayer.ResizeData(const NewSize: Cardinal);
begin
  fDataSize := NewSize;
  ReallocMem(fData, NewSize + 1);
end;

function TbsPngLayer.GetIndex: Integer;
var
  i: Integer;
begin
  Result := -1; 
  FOR i := 0 TO Owner.PngLayers.Count - 1 DO
    if Owner.PngLayers.Item[i] = Self then
    begin
      Result := i;
      exit;
    end;
end;

function TbsPngLayer.GetHeader: TbsPngLayerIHDR;
begin
  Result := Owner.PngLayers.Item[0] as TbsPngLayerIHDR;
end;

procedure TbsPngLayer.Assign(Source: TbsPngLayer);
begin
  fName := Source.fName;
  ResizeData(Source.fDataSize);
  if fDataSize > 0 then CopyMemory(fData, Source.fData, fDataSize);
end;

constructor TbsPngLayer.Create(Owner: TbsPngImage);
var
  PngLayerName: String;
begin
  inherited Create;
  PngLayerName := System.Copy(ClassName, Length('TbsPngLayer') + 1, Length(ClassName));
  if Length(PngLayerName) = 4 then CopyMemory(@fName[0], @PngLayerName[1], 4);
  GetMem(fData, 1);
  fDataSize := 0;
  fOwner := Owner;
end;

destructor TbsPngLayer.Destroy;
begin
  FreeMem(fData, fDataSize + 1);
  inherited Destroy;
end;

function TbsPngLayer.GetPngLayerName: String;
begin
  Result := fName
end;

class function TbsPngLayer.GetName: String;
begin
  Result := System.Copy(ClassName, Length('TbsPngLayer') + 1, Length(ClassName));
end;

function TbsPngLayer.SaveData(Stream: TStream): Boolean;
var
  PngLayerSize, PngLayerCRC: Cardinal;
begin
  PngLayerSize := ByteSwap(DataSize);
  Stream.Write(PngLayerSize, 4);
  Stream.Write(fName, 4);
  if DataSize > 0 then Stream.Write(Data^, DataSize);
  PngLayerCRC := update_crc($ffffffff, @fName[0], 4);
  PngLayerCRC := Byteswap(update_crc(PngLayerCRC, Data, DataSize) xor $ffffffff);
  Stream.Write(PngLayerCRC, 4);
  Result := TRUE;
end;

function TbsPngLayer.SaveToStream(Stream: TStream): Boolean;
begin
  Result := SaveData(Stream)
end;

function TbsPngLayer.LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
  Size: Integer): Boolean;
var
  CheckCRC: Cardinal;
  RightCRC: Cardinal;
begin
  ResizeData(Size);
  if Size > 0 then Stream.Read(fData^, Size);
  Stream.Read(CheckCRC, 4);
  CheckCrc := ByteSwap(CheckCRC);
   RightCRC := update_crc($ffffffff, @PngLayerName[0], 4);
   RightCRC := update_crc(RightCRC, fData, Size) xor $ffffffff;
   Result := RightCRC = CheckCrc;
   if not Result then
   begin
     exit;
   end;
end;

{TbsPngLayertIME}

function TbsPngLayertIME.LoadFromStream(Stream: TStream;
  const PngLayerName: TbsPngLayerName; Size: Integer): Boolean;
begin
  Result := inherited LoadFromStream(Stream, PngLayerName, Size);
  if not Result or (Size <> 7) then exit; {Size must be 7}
  fYear := ((pByte(Longint(Data) )^) * 256)+ (pByte(Longint(Data) + 1)^);
  fMonth := pByte(Longint(Data) + 2)^;
  fDay := pByte(Longint(Data) + 3)^;
  fHour := pByte(Longint(Data) + 4)^;
  fMinute := pByte(Longint(Data) + 5)^;
  fSecond := pByte(Longint(Data) + 6)^;
end;

procedure TbsPngLayertIME.Assign(Source: TbsPngLayer);
begin
  fYear := TbsPngLayertIME(Source).fYear;
  fMonth := TbsPngLayertIME(Source).fMonth;
  fDay := TbsPngLayertIME(Source).fDay;
  fHour := TbsPngLayertIME(Source).fHour;
  fMinute := TbsPngLayertIME(Source).fMinute;
  fSecond := TbsPngLayertIME(Source).fSecond;
end;

function TbsPngLayertIME.SaveToStream(Stream: TStream): Boolean;
begin
  ResizeData(7);  
  pWord(Data)^ := ByteSwap16(Year);
  pByte(Longint(Data) + 2)^ := Month;
  pByte(Longint(Data) + 3)^ := Day;
  pByte(Longint(Data) + 4)^ := Hour;
  pByte(Longint(Data) + 5)^ := Minute;
  pByte(Longint(Data) + 6)^ := Second;
  Result := inherited SaveToStream(Stream);
end;

{TbsPngLayerztX}

function TbsPngLayerzTXt.LoadFromStream(Stream: TStream;
  const PngLayerName: TbsPngLayerName; Size: Integer): Boolean;
var
  ErrorOutput: String;
  CompressionMethod: Byte;
  Output: Pointer;
  OutputSize: Integer;
begin
  Result := inherited LoadFromStream(Stream, PngLayerName, Size);
  if not Result or (Size < 4) then exit;
  fKeyword := PChar(Data);
  if Longint(fKeyword) = 0 then
    CompressionMethod := pByte(Data)^
  else
    CompressionMethod := pByte(Longint(fKeyword) + Length(fKeyword))^;
  fText := '';

  if CompressionMethod = 0 then
  begin
    Output := nil;
    if DecompressZLIB(PChar(Longint(Data) + Length(fKeyword) + 2),
      Size - Length(fKeyword) - 2, Output, OutputSize, ErrorOutput) then
    begin
      SetLength(fText, OutputSize);
      CopyMemory(@fText[1], Output, OutputSize);
    end;
    FreeMem(Output);
  end; 
end;

function TbsPngLayerztXt.SaveToStream(Stream: TStream): Boolean;
var
  Output: Pointer;
  OutputSize: Integer;
  ErrorOutput: String;
begin
  Output := nil;
  if fText = '' then fText := ' ';
  if CompressZLIB(@fText[1], Length(fText), Owner.CompressionLevel, Output,
    OutputSize, ErrorOutput) then
  begin
    ResizeData(Length(fKeyword) + 2 + OutputSize);
    Fillchar(Data^, DataSize, #0);
    if Keyword <> '' then
      CopyMemory(Data, @fKeyword[1], Length(Keyword));
    pByte(Ptr(Longint(Data) + Length(Keyword) + 1))^ := 0;
    if OutputSize > 0 then
      CopyMemory(Ptr(Longint(Data) + Length(Keyword) + 2), Output, OutputSize);
    Result := SaveData(Stream);
  end {if CompressZLIB(...} else Result := False;
  if Output <> nil then FreeMem(Output)
end;

{TbsPngLayertEXt}

procedure TbsPngLayertEXt.Assign(Source: TbsPngLayer);
begin
  fKeyword := TbsPngLayertEXt(Source).fKeyword;
  fText := TbsPngLayertEXt(Source).fText;
end;

function TbsPngLayertEXt.LoadFromStream(Stream: TStream;
  const PngLayerName: TbsPngLayerName; Size: Integer): Boolean;
begin
  Result := inherited LoadFromStream(Stream, PngLayerName, Size);
  if not Result or (Size < 3) then exit;
  fKeyword := PChar(Data);
  SetLength(fText, Size - Length(fKeyword) - 1);
  CopyMemory(@fText[1], Ptr(Longint(Data) + Length(fKeyword) + 1),
    Length(fText));
end;

function TbsPngLayertEXt.SaveToStream(Stream: TStream): Boolean;
begin
  ResizeData(Length(fKeyword) + 1 + Length(fText));
  Fillchar(Data^, DataSize, #0);
  if Keyword <> '' then
    CopyMemory(Data, @fKeyword[1], Length(Keyword));
  if Text <> '' then
    CopyMemory(Ptr(Longint(Data) + Length(Keyword) + 1), @fText[1],
      Length(Text));
  Result := inherited SaveToStream(Stream);
end;


{TbsPngLayerIHDR}

constructor TbsPngLayerIHDR.Create(Owner: TbsPngImage);
begin
  ImageHandle := 0;
  ImagePalette := 0;
  ImageDC := 0;
  inherited Create(Owner);
end;

destructor TbsPngLayerIHDR.Destroy;
begin
  FreeImageData();
  inherited Destroy;
end;

procedure CopyPalette(Source: HPALETTE; Destination: HPALETTE);
var
  PaletteSize: Integer;
  Entries: Array[Byte] of TPaletteEntry;
begin
  PaletteSize := 0;
  if GetObject(Source, SizeOf(PaletteSize), @PaletteSize) = 0 then Exit;
  if PaletteSize = 0 then Exit;
  ResizePalette(Destination, PaletteSize);
  GetPaletteEntries(Source, 0, PaletteSize, Entries);
  SetPaletteEntries(Destination, 0, PaletteSize, Entries);
end;

procedure TbsPngLayerIHDR.Assign(Source: TbsPngLayer);
begin
  if Source is TbsPngLayerIHDR then
  begin
    IHDRData := TbsPngLayerIHDR(Source).IHDRData;
    PrepareImageData();
    CopyMemory(ImageData, TbsPngLayerIHDR(Source).ImageData,
      BytesPerRow * Integer(Height));
    CopyMemory(ImageAlpha, TbsPngLayerIHDR(Source).ImageAlpha,
      Integer(Width) * Integer(Height));
    BitmapInfo.bmiColors := TbsPngLayerIHDR(Source).BitmapInfo.bmiColors;
    CopyPalette(TbsPngLayerIHDR(Source).ImagePalette, ImagePalette);
  end;
end;

procedure TbsPngLayerIHDR.FreeImageData;
begin
  {Free old image data}
  if ImageHandle <> 0  then DeleteObject(ImageHandle);
  if ImageDC     <> 0  then DeleteDC(ImageDC);
  if ImageAlpha <> nil then FreeMem(ImageAlpha);
  if ImagePalette <> 0 then DeleteObject(ImagePalette);
  if ExtraImageData <> nil then FreeMem(ExtraImageData);
  ImageHandle := 0; ImageDC := 0; ImageAlpha := nil; ImageData := nil;
  ImagePalette := 0; ExtraImageData := nil;
end;

function TbsPngLayerIHDR.LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
  Size: Integer): Boolean;
begin
  Result := inherited LoadFromStream(Stream, PngLayerName, Size);
  if not Result then Exit;
  if (fDataSize < SIZEOF(TIHdrData)) then
  begin
    Result := False;
    exit;
  end;

  IHDRData := pIHDRData(fData)^;
  IHDRData.Width := ByteSwap(IHDRData.Width);
  IHDRData.Height := ByteSwap(IHDRData.Height);

  if (IHDRData.Width > High(Word)) or (IHDRData.Height > High(Word)) then
  begin
    Result := False;
    exit;
  end; 
  if (IHDRData.CompressionMethod <> 0) then
  begin
    Result := False;
    exit;
  end;
  if (IHDRData.InterlaceMethod <> 0) and (IHDRData.InterlaceMethod <> 1) then
  begin
    Result := False;
    exit;
  end;
  Owner.InterlaceMethod := TbsInterlaceMethod(IHDRData.InterlaceMethod);
  PrepareImageData();
end;

function TbsPngLayerIHDR.SaveToStream(Stream: TStream): Boolean;
begin
  if BitDepth = 2 then BitDepth := 4;
  ResizeData(SizeOf(TIHDRData));
  pIHDRData(fData)^ := IHDRData;
  pIHDRData(fData)^.Width := ByteSwap(pIHDRData(fData)^.Width);
  pIHDRData(fData)^.Height := ByteSwap(pIHDRData(fData)^.Height);
  pIHDRData(fData)^.InterlaceMethod := Byte(Owner.InterlaceMethod);
  Result := inherited SaveToStream(Stream);
end;

function TbsPngLayerIHDR.CreateGrayscalePalette(Bitdepth: Integer): HPalette;
var
  j: Integer;
  palEntries: TMaxLogPalette;
begin
  if Bitdepth = 16 then Bitdepth := 8;
  fillchar(palEntries, sizeof(palEntries), 0);
  palEntries.palVersion := $300;
  palEntries.palNumEntries := 1 shl Bitdepth;
  for j := 0 to palEntries.palNumEntries - 1 do
  begin
    palEntries.palPalEntry[j].peRed  :=
      fOwner.GammaTable[MulDiv(j, 255, palEntries.palNumEntries - 1)];
    palEntries.palPalEntry[j].peGreen := palEntries.palPalEntry[j].peRed;
    palEntries.palPalEntry[j].peBlue := palEntries.palPalEntry[j].peRed;
  end;
  Result := CreatePalette(pLogPalette(@palEntries)^);
end;

procedure TbsPngLayerIHDR.PaletteToDIB(Palette: HPalette);
var
  j: Integer;
  palEntries: TMaxLogPalette;
begin
  Fillchar(palEntries, sizeof(palEntries), #0);
  BitmapInfo.bmiHeader.biClrUsed := GetPaletteEntries(Palette, 0, 256, palEntries.palPalEntry[0]);
  for j := 0 to BitmapInfo.bmiHeader.biClrUsed - 1 do
  begin
    BitmapInfo.bmiColors[j].rgbBlue  := palEntries.palPalEntry[j].peBlue;
    BitmapInfo.bmiColors[j].rgbRed   := palEntries.palPalEntry[j].peRed;
    BitmapInfo.bmiColors[j].rgbGreen := palEntries.palPalEntry[j].peGreen;
  end;
end;

procedure TbsPngLayerIHDR.PrepareImageData();
  procedure SetInfo(const Bitdepth: Integer; const Palette: Boolean);
  begin
    HasPalette := Palette;
    with BitmapInfo.bmiHeader do
    begin
      biSize := sizeof(TBitmapInfoHeader);
      biHeight := Height;
      biWidth := Width;
      biPlanes := 1;
      biBitCount := BitDepth;
      biCompression := BI_RGB;
    end;
  end;
begin
  Fillchar(BitmapInfo, sizeof(TMaxBitmapInfo), #0);
  FreeImageData();
  case ColorType of
    COLOR_GRAYSCALE, COLOR_PALETTE, COLOR_GRAYSCALEALPHA:
      case BitDepth of
        1, 4, 8: SetInfo(BitDepth, TRUE);
        2      : SetInfo(4, TRUE);
        16     : SetInfo(8, TRUE);
      end;
    COLOR_RGB, COLOR_RGBALPHA:  SetInfo(24, FALSE);
  end;

  BytesPerRow := (((BitmapInfo.bmiHeader.biBitCount * Width) + 31)
    and not 31) div 8;

  if (ColorType = COLOR_RGBALPHA) or (ColorType = COLOR_GRAYSCALEALPHA) then
  begin
    GetMem(ImageAlpha, Integer(Width) * Integer(Height));
    FillChar(ImageAlpha^, Integer(Width) * Integer(Height), #0);
  end;

  if (BitDepth = 16) then
  begin
    GetMem(ExtraImageData, BytesPerRow * Integer(Height));
    FillChar(ExtraImageData^, BytesPerRow * Integer(Height), #0);
  end;

  ImageDC := CreateCompatibleDC(0);
  if Self.Owner.Canvas <> nil
  then
    Self.Owner.Canvas.Handle := ImageDC;

  if HasPalette then
  begin
    if ColorType = COLOR_PALETTE then
      ImagePalette := CreateHalfTonePalette(ImageDC)
    else
      ImagePalette := CreateGrayscalePalette(Bitdepth);
    ResizePalette(ImagePalette, 1 shl BitmapInfo.bmiHeader.biBitCount);
    BitmapInfo.bmiHeader.biClrUsed := 1 shl BitmapInfo.bmiHeader.biBitCount;
    SelectPalette(ImageDC, ImagePalette, False);
    RealizePalette(ImageDC);
    PaletteTODIB(ImagePalette);
  end;

  ImageHandle := CreateDIBSection(ImageDC, pBitmapInfo(@BitmapInfo)^,
    DIB_RGB_COLORS, ImageData, 0, 0);
  SelectObject(ImageDC, ImageHandle);

  fillchar(ImageData^, BytesPerRow * Integer(Height), 0);
end;

{TbsPngLayertRNS}

procedure TbsPngLayertRNS.SetTransparentColor(const Value: ColorRef);
var
  i: Byte;
  LookColor: TRGBQuad;
begin
  Fillchar(PaletteValues, SizeOf(PaletteValues), #0);
  fBitTransparency := True;
  with Header do
    case ColorType of
      COLOR_GRAYSCALE:
      begin
        Self.ResizeData(2);
        pWord(@PaletteValues[0])^ := ByteSwap16(GetRValue(Value));
      end;
      COLOR_RGB:
      begin
        Self.ResizeData(6);
        pWord(@PaletteValues[0])^ := ByteSwap16(GetRValue(Value));
        pWord(@PaletteValues[2])^ := ByteSwap16(GetGValue(Value));
        pWord(@PaletteValues[4])^ := ByteSwap16(GetBValue(Value));
      end;
      COLOR_PALETTE:
      begin
        LookColor.rgbRed := GetRValue(Value);
        LookColor.rgbGreen := GetGValue(Value);
        LookColor.rgbBlue := GetBValue(Value);
        for i := 0 to BitmapInfo.bmiHeader.biClrUsed - 1 do
          if CompareMem(@BitmapInfo.bmiColors[i], @LookColor, 3) then
            Break;
        Fillchar(PaletteValues, i, 255);
        Self.ResizeData(i + 1)
      end;
    end;
end;

function TbsPngLayertRNS.GetTransparentColor: ColorRef;
var
  PalettePngLayer: TbsPngLayerPLTE;
  i: Integer;
  Value: Byte;
begin
  Result := 0;
  with Header do
    case ColorType of
      COLOR_GRAYSCALE:
      begin
        Value := BitmapInfo.bmiColors[PaletteValues[1]].rgbRed;
        Result := RGB(Value, Value, Value);
      end;
      COLOR_RGB:
        Result := RGB(fOwner.GammaTable[PaletteValues[1]],
        fOwner.GammaTable[PaletteValues[3]],
        fOwner.GammaTable[PaletteValues[5]]);
      COLOR_PALETTE:
      begin
        PalettePngLayer := Owner.PngLayers.ItemFromClass(TbsPngLayerPLTE) as TbsPngLayerPLTE;
        for i := 0 to Self.DataSize - 1 do
          if PaletteValues[i] = 0 then
            with PalettePngLayer.GetPaletteItem(i) do
            begin
              Result := RGB(rgbRed, rgbGreen, rgbBlue);
              break
            end
      end;
    end;
end;

function TbsPngLayertRNS.SaveToStream(Stream: TStream): Boolean;
begin
  if DataSize <= 256 then
    CopyMemory(fData, @PaletteValues[0], DataSize);
  Result := inherited SaveToStream(Stream);
end;

procedure TbsPngLayertRNS.Assign(Source: TbsPngLayer);
begin
  CopyMemory(@PaletteValues[0], @TbsPngLayerTrns(Source).PaletteValues[0], 256);
  fBitTransparency := TbsPngLayerTrns(Source).fBitTransparency;
  inherited Assign(Source);
end;

function TbsPngLayertRNS.LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
  Size: Integer): Boolean;
var
  i, Differ255: Integer;
begin
  Result := inherited LoadFromStream(Stream, PngLayerName, Size);

  if not Result then Exit;

  Fillchar(PaletteValues[0], 256, 255);
  CopyMemory(@PaletteValues[0], fData, Size);
  case Header.ColorType of
    COLOR_RGB, COLOR_GRAYSCALE: fBitTransparency := True;
    COLOR_PALETTE:
    begin
      Differ255 := 0;
      for i := 0 to Size - 1 do
        if PaletteValues[i] <> 255 then inc(Differ255);
      fBitTransparency := (Differ255 = 1);
    end;
  end;
end;

procedure TbsPngLayerIDAT.PreparePalette;
var
  Entries: Word;
  j      : Integer;
  palEntries: TMaxLogPalette;
begin
  with Header do
    if (ColorType = COLOR_GRAYSCALE) or (ColorType = COLOR_GRAYSCALEALPHA) then
    begin
      Entries := (1 shl Byte(BitmapInfo.bmiHeader.biBitCount));
      Fillchar(palEntries, sizeof(palEntries), #0);
      palEntries.palVersion := $300;
      palEntries.palNumEntries := Entries;
       FOR j := 0 TO Entries - 1 DO
        with palEntries.palPalEntry[j] do
        begin
          peRed := fOwner.GammaTable[MulDiv(j, 255, Entries - 1)];
          peGreen := peRed;
          peBlue := peRed;
        end;
        Owner.SetPalette(CreatePalette(pLogPalette(@palEntries)^));
    end;
end;

function TbsPngLayerIDAT.IDATZlibRead(var ZLIBStream: TZStreamRec2;
  Buffer: Pointer; Count: Integer; var EndPos: Integer;
  var crcfile: Cardinal): Integer;
var
  ProcResult : Integer;
  IDATHeader : Array[0..3] of char;
  IDATCRC    : Cardinal;
begin
  with ZLIBStream, ZLIBStream.zlib do
  begin
    next_out := Buffer;
    avail_out := Count;
    while avail_out > 0 do
    begin
      if (fStream.Position = EndPos) and (avail_out > 0) and
        (avail_in = 0) then
      begin
        fStream.Read(IDATCRC, 4);
        if crcfile xor $ffffffff <> Cardinal(ByteSwap(IDATCRC)) then
          begin
            Result := -1;
            exit;
          end;
        fStream.Read(EndPos, 4);
        fStream.Read(IDATHeader[0], 4);
        if IDATHeader <> 'IDAT' then
        begin
          result := -1;
          exit;
        end;
          crcfile := update_crc($ffffffff, @IDATHeader[0], 4);
        EndPos := fStream.Position + ByteSwap(EndPos);
      end;
      if avail_in = 0 then
      begin
        if fStream.Position + ZLIBAllocate > EndPos then
          avail_in := fStream.Read(Data^, EndPos - fStream.Position)
         else
          avail_in := fStream.Read(Data^, ZLIBAllocate);
        crcfile := update_crc(crcfile, Data, avail_in);

        if avail_in = 0 then
        begin
          Result := Count - avail_out;
          Exit;
        end;
        next_in := Data;
      end;

      ProcResult := inflate(zlib, 0);

      if (ProcResult < 0) then
      begin
        Result := -1;
        exit;
      end;
    end;
  end;

  Result := Count;
end;

{TbsPngLayerIDAT}

const
  RowStart: array[0..6] of Integer = (0, 0, 4, 0, 2, 0, 1);
  ColumnStart: array[0..6] of Integer = (0, 4, 0, 2, 0, 1, 0);
  RowIncrement: array[0..6] of Integer = (8, 8, 8, 4, 4, 2, 2);
  ColumnIncrement: array[0..6] of Integer = (8, 8, 4, 4, 2, 2, 1);

{Copy interlaced images with 1 byte for R, G, B}
procedure TbsPngLayerIDAT.CopyInterlacedRGB8(const Pass: Byte;
  Src, Dest, Trans, Extra: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Dest := pChar(Longint(Dest) + Col * 3);
  repeat
    Byte(Dest^) := fOwner.GammaTable[pByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^) := fOwner.GammaTable[pByte(Longint(Src) + 1)^]; inc(Dest);
    Byte(Dest^) := fOwner.GammaTable[pByte(Longint(Src)    )^]; inc(Dest);

    inc(Src, 3);
    inc(Dest, ColumnIncrement[Pass] * 3 - 3);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.CopyInterlacedRGB16(const Pass: Byte;
  Src, Dest, Trans, Extra: pChar);
var
  Col: Integer;
begin
  {Get first column and enter in loop}
  Col := ColumnStart[Pass];
  Dest := pChar(Longint(Dest) + Col * 3);
  repeat
    Byte(Dest^) := Owner.GammaTable[pByte(Longint(Src) + 4)^]; inc(Dest);
    Byte(Dest^) := Owner.GammaTable[pByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^) := Owner.GammaTable[pByte(Longint(Src)    )^]; inc(Dest);

    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 5)^]; inc(Extra);
    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 3)^]; inc(Extra);
    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 1)^]; inc(Extra);

    inc(Src, 6);
    inc(Dest, ColumnIncrement[Pass] * 3 - 3);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.CopyInterlacedPalette148(const Pass: Byte;
  Src, Dest, Trans, Extra: pChar);
const
  BitTable: Array[1..8] of Integer = ($1, $3, 0, $F, 0, 0, 0, $FF);
  StartBit: Array[1..8] of Integer = (7 , 0 , 0, 4,  0, 0, 0, 0);
var
  CurBit, Col: Integer;
  Dest2: PChar;
begin
  Col := ColumnStart[Pass];
  repeat
    CurBit := StartBit[Header.BitDepth];
    repeat
      Dest2 := pChar(Longint(Dest) + (Header.BitDepth * Col) div 8);
      Byte(Dest2^) := Byte(Dest2^) or
        ( ((Byte(Src^) shr CurBit) and BitTable[Header.BitDepth])
          shl (StartBit[Header.BitDepth] - (Col * Header.BitDepth mod 8)));
      inc(Col, ColumnIncrement[Pass]);
      dec(CurBit, Header.BitDepth);
    until CurBit < 0;
    inc(Src);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.CopyInterlacedPalette2(const Pass: Byte; Src, Dest,
  Trans, Extra: pChar);
var
  CurBit, Col: Integer;
  Dest2: PChar;
begin
  Col := ColumnStart[Pass];
  repeat
    CurBit := 6;
    repeat
      Dest2 := pChar(Longint(Dest) + Col div 2);
      Byte(Dest2^) := Byte(Dest2^) or (((Byte(Src^) shr CurBit) and $3)
         shl (4 - (4 * Col) mod 8));
      inc(Col, ColumnIncrement[Pass]);
      dec(CurBit, 2);
    until CurBit < 0;
    inc(Src);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.CopyInterlacedGray2(const Pass: Byte;
  Src, Dest, Trans, Extra: pChar);
var
  CurBit, Col: Integer;
  Dest2: PChar;
begin
  Col := ColumnStart[Pass];
  repeat
    CurBit := 6;
    repeat
      Dest2 := pChar(Longint(Dest) + Col div 2);
      Byte(Dest2^) := Byte(Dest2^) or ((((Byte(Src^) shr CurBit) shl 2) and $F)
         shl (4 - (Col*4) mod 8));
      inc(Col, ColumnIncrement[Pass]);
      dec(CurBit, 2);
    until CurBit < 0;
    inc(Src);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.CopyInterlacedGrayscale16(const Pass: Byte;
  Src, Dest, Trans, Extra: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Dest := pChar(Longint(Dest) + Col);
  repeat
    Dest^ := Src^; inc(Dest);
    Extra^ := pChar(Longint(Src) + 1)^; inc(Extra);
    inc(Src, 2);
    inc(Dest, ColumnIncrement[Pass] - 1);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.CopyInterlacedRGBAlpha8(const Pass: Byte;
  Src, Dest, Trans, Extra: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Dest := pChar(Longint(Dest) + Col * 3);
  Trans := pChar(Longint(Trans) + Col);
  repeat
    Trans^ := pChar(Longint(Src) + 3)^;
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src) + 1)^]; inc(Dest);
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src)    )^]; inc(Dest);

    inc(Src, 4);
    inc(Dest, ColumnIncrement[Pass] * 3 - 3);
    inc(Trans, ColumnIncrement[Pass]);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.CopyInterlacedRGBAlpha16(const Pass: Byte;
  Src, Dest, Trans, Extra: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Dest := pChar(Longint(Dest) + Col * 3);
  Trans := pChar(Longint(Trans) + Col);
  repeat
    Trans^ := pChar(Longint(Src) + 6)^;
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src) + 4)^]; inc(Dest);
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src)    )^]; inc(Dest);

    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 5)^]; inc(Extra);
    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 3)^]; inc(Extra);
    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 1)^]; inc(Extra);

    inc(Src, 8);
    inc(Dest, ColumnIncrement[Pass] * 3 - 3);
    inc(Trans, ColumnIncrement[Pass]);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.CopyInterlacedGrayscaleAlpha8(const Pass: Byte;
  Src, Dest, Trans, Extra: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Dest := pChar(Longint(Dest) + Col);
  Trans := pChar(Longint(Trans) + Col);
  repeat
    Dest^ := Src^;  inc(Src);
    Trans^ := Src^; inc(Src);
    inc(Dest, ColumnIncrement[Pass]);
    inc(Trans, ColumnIncrement[Pass]);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.CopyInterlacedGrayscaleAlpha16(const Pass: Byte;
  Src, Dest, Trans, Extra: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Dest := pChar(Longint(Dest) + Col);
  Trans := pChar(Longint(Trans) + Col);
  repeat
    Extra^ := pChar(Longint(Src) + 1)^; inc(Extra);
    Dest^ := Src^;  inc(Src, 2);
    Trans^ := Src^; inc(Src, 2);
    inc(Dest, ColumnIncrement[Pass]);
    inc(Trans, ColumnIncrement[Pass]);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.DecodeInterlacedAdam7(Stream: TStream;
  var ZLIBStream: TZStreamRec2; const Size: Integer; var crcfile: Cardinal);
var
  CurrentPass: Byte;
  PixelsThisRow: Integer;
  CurrentRow: Integer;
  Trans, Data, Extra: pChar;
  CopyProc: procedure(const Pass: Byte; Src, Dest,
    Trans, Extra: pChar) of object;
begin
  CopyProc := nil;
  case Header.ColorType of
    COLOR_RGB:
      case Header.BitDepth of
        8:  CopyProc := CopyInterlacedRGB8;
       16:  CopyProc := CopyInterlacedRGB16;
      end;
    COLOR_PALETTE, COLOR_GRAYSCALE:
      case Header.BitDepth of
        1, 4, 8: CopyProc := CopyInterlacedPalette148;
        2      : if Header.ColorType = COLOR_PALETTE then
                   CopyProc := CopyInterlacedPalette2
                 else
                   CopyProc := CopyInterlacedGray2;
        16     : CopyProc := CopyInterlacedGrayscale16;
      end;
    COLOR_RGBALPHA:
      case Header.BitDepth of
        8:  CopyProc := CopyInterlacedRGBAlpha8;
       16:  CopyProc := CopyInterlacedRGBAlpha16;
      end;
     COLOR_GRAYSCALEALPHA:
      case Header.BitDepth of
        8:  CopyProc := CopyInterlacedGrayscaleAlpha8;
       16:  CopyProc := CopyInterlacedGrayscaleAlpha16;
      end;
  end;

  FOR CurrentPass := 0 TO 6 DO
  begin
    PixelsThisRow := (ImageWidth - ColumnStart[CurrentPass] +
      ColumnIncrement[CurrentPass] - 1) div ColumnIncrement[CurrentPass];
    Row_Bytes := BytesForPixels(PixelsThisRow, Header.ColorType,
      Header.BitDepth);
    ZeroMemory(Row_Buffer[not RowUsed], Row_Bytes);
    CurrentRow := RowStart[CurrentPass];
    Data := Ptr(Longint(Header.ImageData) + Header.BytesPerRow *
      (ImageHeight - 1 - CurrentRow));
    Trans := Ptr(Longint(Header.ImageAlpha) + ImageWidth * CurrentRow);
    Extra := Ptr(Longint(Header.ExtraImageData) + Header.BytesPerRow *
      (ImageHeight - 1 - CurrentRow));
    if Row_Bytes > 0 then {There must have bytes for this interlaced pass}
      while CurrentRow < ImageHeight do
      begin
        if IDATZlibRead(ZLIBStream, @Row_Buffer[RowUsed][0], Row_Bytes + 1,
          EndPos, CRCFile) = 0 then break;
        FilterRow;

        CopyProc(CurrentPass, @Row_Buffer[RowUsed][1], Data, Trans,  Extra);
        RowUsed := not RowUsed;
        inc(CurrentRow, RowIncrement[CurrentPass]);
        dec(Data, RowIncrement[CurrentPass] * Header.BytesPerRow);
        inc(Trans, RowIncrement[CurrentPass] * ImageWidth);
        dec(Extra, RowIncrement[CurrentPass] * Header.BytesPerRow);
      end;
  end;
end;

procedure TbsPngLayerIDAT.CopyNonInterlacedRGB8(
  Src, Dest, Trans, Extra: pChar);
var
  I: Integer;
begin
  FOR I := 1 TO ImageWidth DO
  begin
    Byte(Dest^) := fOwner.GammaTable[pByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^) := fOwner.GammaTable[pByte(Longint(Src) + 1)^]; inc(Dest);
    Byte(Dest^) := fOwner.GammaTable[pByte(Longint(Src)    )^]; inc(Dest);
    inc(Src, 3);
  end;
end;

procedure TbsPngLayerIDAT.CopyNonInterlacedRGB16(
  Src, Dest, Trans, Extra: pChar);
var
  I: Integer;
begin
  FOR I := 1 TO ImageWidth DO
  begin
    Byte(Dest^) := fOwner.GammaTable[pByte(Longint(Src) + 4)^]; inc(Dest);
    Byte(Dest^) := fOwner.GammaTable[pByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^) := fOwner.GammaTable[pByte(Longint(Src)    )^]; inc(Dest);
    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 5)^]; inc(Extra);
    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 3)^]; inc(Extra);
    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 1)^]; inc(Extra);
    inc(Src, 6);
  end;
end;

procedure TbsPngLayerIDAT.CopyNonInterlacedPalette148(
  Src, Dest, Trans, Extra: pChar);
begin
  CopyMemory(Dest, Src, Row_Bytes);
end;

procedure TbsPngLayerIDAT.CopyNonInterlacedGray2(
  Src, Dest, Trans, Extra: pChar);
var
  i: Integer;
begin
  FOR i := 1 TO Row_Bytes do
  begin
    Byte(Dest^) := ((Byte(Src^) shr 2) and $F) or ((Byte(Src^)) and $F0);
      inc(Dest);
    Byte(Dest^) := ((Byte(Src^) shl 2) and $F) or ((Byte(Src^) shl 4) and $F0);
      inc(Dest);
    inc(Src);
  end;
end;

procedure TbsPngLayerIDAT.CopyNonInterlacedPalette2(
  Src, Dest, Trans, Extra: pChar);
var
  i: Integer;
begin
  FOR i := 1 TO Row_Bytes do
  begin
    Byte(Dest^) := ((Byte(Src^) shr 4) and $3) or ((Byte(Src^) shr 2) and $30);
      inc(Dest);
    Byte(Dest^) := (Byte(Src^) and $3) or ((Byte(Src^) shl 2) and $30);
      inc(Dest);
    inc(Src);
  end;
end;

procedure TbsPngLayerIDAT.CopyNonInterlacedGrayscale16(
  Src, Dest, Trans, Extra: pChar);
var
  I: Integer;
begin
  FOR I := 1 TO ImageWidth DO
  begin
    Dest^ := Src^; inc(Dest);
    Extra^ := pChar(Longint(Src) + 1)^; inc(Extra);
    inc(Src, 2);
  end;
end;

procedure TbsPngLayerIDAT.CopyNonInterlacedRGBAlpha8(
  Src, Dest, Trans, Extra: pChar);
var
  i: Integer;
begin
  FOR I := 1 TO ImageWidth DO
  begin
    Trans^ := pChar(Longint(Src) + 3)^;
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src) + 1)^]; inc(Dest);
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src)    )^]; inc(Dest);
    inc(Src, 4); inc(Trans);
  end;
end;

procedure TbsPngLayerIDAT.CopyNonInterlacedRGBAlpha16(
  Src, Dest, Trans, Extra: pChar);
var
  I: Integer;
begin
  FOR I := 1 TO ImageWidth DO
  begin
    Trans^ := pChar(Longint(Src) + 6)^;
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src) + 4)^]; inc(Dest);
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^)  := fOwner.GammaTable[pByte(Longint(Src)    )^]; inc(Dest);

    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 5)^]; inc(Extra);
    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 3)^]; inc(Extra);
    Byte(Extra^) := fOwner.GammaTable[pByte(Longint(Src) + 1)^]; inc(Extra);

    inc(Src, 8); inc(Trans);
  end;
end;

procedure TbsPngLayerIDAT.CopyNonInterlacedGrayscaleAlpha8(
  Src, Dest, Trans, Extra: pChar);
var
  I: Integer;
begin
  FOR I := 1 TO ImageWidth DO
  begin
    Dest^  := Src^;  inc(Src);
    Trans^ := Src^;  inc(Src);
    inc(Dest); inc(Trans);
  end;
end;

procedure TbsPngLayerIDAT.CopyNonInterlacedGrayscaleAlpha16(
  Src, Dest, Trans, Extra: pChar);
var
  I: Integer;
begin
  FOR I := 1 TO ImageWidth DO
  begin
    Extra^ := pChar(Longint(Src) + 1)^; inc(Extra);
    Dest^  := Src^;  inc(Src, 2);
    Trans^ := Src^;  inc(Src, 2);
    inc(Dest); inc(Trans);
  end;
end;


procedure TbsPngLayerIDAT.DecodeNonInterlaced(Stream: TStream;
  var ZLIBStream: TZStreamRec2; const Size: Integer; var crcfile: Cardinal);
var
  j: Cardinal;
  Trans, Data, Extra: pChar;
  CopyProc: procedure(
    Src, Dest, Trans, Extra: pChar) of object;
begin
  CopyProc := nil; 

  case Header.ColorType of
    COLOR_RGB:
      case Header.BitDepth of
        8: CopyProc := CopyNonInterlacedRGB8;
       16: CopyProc := CopyNonInterlacedRGB16;
      end;
    COLOR_PALETTE, COLOR_GRAYSCALE:
      case Header.BitDepth of
        1, 4, 8: CopyProc := CopyNonInterlacedPalette148;
        2      : if Header.ColorType = COLOR_PALETTE then
                   CopyProc := CopyNonInterlacedPalette2
                 else
                   CopyProc := CopyNonInterlacedGray2;
        16     : CopyProc := CopyNonInterlacedGrayscale16;
      end;
    COLOR_RGBALPHA:
      case Header.BitDepth of
        8  : CopyProc := CopyNonInterlacedRGBAlpha8;
       16  : CopyProc := CopyNonInterlacedRGBAlpha16;
      end;
    COLOR_GRAYSCALEALPHA:
      case Header.BitDepth of
        8  : CopyProc := CopyNonInterlacedGrayscaleAlpha8;
       16  : CopyProc := CopyNonInterlacedGrayscaleAlpha16;
      end;
  end;

  Longint(Data) := Longint(Header.ImageData) +
    Header.BytesPerRow * (ImageHeight - 1);
  Trans := Header.ImageAlpha;
  Longint(Extra) := Longint(Header.ExtraImageData) +
    Header.BytesPerRow * (ImageHeight - 1);
  FOR j := 0 to ImageHeight - 1 do
  begin
    if IDATZlibRead(ZLIBStream, @Row_Buffer[RowUsed][0], Row_Bytes + 1, EndPos,
      CRCFile) = 0 then break;
    FilterRow;
    CopyProc(@Row_Buffer[RowUsed][1], Data, Trans, Extra);
    RowUsed := not RowUsed;
    dec(Data, Header.BytesPerRow);
    dec(Extra, Header.BytesPerRow);
    inc(Trans, ImageWidth);
  end;
end;

procedure TbsPngLayerIDAT.FilterRow;
var
  pp: Byte;
  vv, left, above, aboveleft: Integer;
  Col: Cardinal;
begin
  case Row_Buffer[RowUsed]^[0] of
    FILTER_NONE: begin end;
    FILTER_SUB:
      FOR Col := Offset + 1 to Row_Bytes DO
        Row_Buffer[RowUsed][Col] := (Row_Buffer[RowUsed][Col] +
          Row_Buffer[RowUsed][Col - Offset]) and 255;
    FILTER_UP:
      FOR Col := 1 to Row_Bytes DO
        Row_Buffer[RowUsed][Col] := (Row_Buffer[RowUsed][Col] +
          Row_Buffer[not RowUsed][Col]) and 255;
    FILTER_AVERAGE:
      FOR Col := 1 to Row_Bytes DO
      begin
        above := Row_Buffer[not RowUsed][Col];
        if col - 1 < Offset then
          left := 0
        else
          Left := Row_Buffer[RowUsed][Col - Offset];
        Row_Buffer[RowUsed][Col] := (Row_Buffer[RowUsed][Col] +
          (left + above) div 2) and 255;
      end;
    FILTER_PAETH:
    begin
      left := 0;
      aboveleft := 0;
      FOR Col := 1 to Row_Bytes DO
      begin
        above := Row_Buffer[not RowUsed][Col];
        if (col - 1 >= offset) Then
        begin
          left := row_buffer[RowUsed][col - offset];
          aboveleft := row_buffer[not RowUsed][col - offset];
        end;
        vv := row_buffer[RowUsed][Col];
        pp := PaethPredictor(left, above, aboveleft);
        Row_Buffer[RowUsed][Col] := (pp + vv) and $FF;
      end;
    end;
  end;
end;

function TbsPngLayerIDAT.LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
  Size: Integer): Boolean;
var
  ZLIBStream: TZStreamRec2;
  CRCCheck,
  CRCFile  : Cardinal;
begin
  Header := Owner.PngLayers.Item[0] as TbsPngLayerIHDR;
  if Header.HasPalette then PreparePalette();
  ImageWidth := Header.Width;
  ImageHeight := Header.Height;
  CRCFile := update_crc($ffffffff, @PngLayerName[0], 4);
  Owner.GetPixelInfo(Row_Bytes, Offset);
  ZLIBStream := ZLIBInitInflate(Stream);
  EndPos := Stream.Position + Size;
  GetMem(Row_Buffer[false], Row_Bytes + 1);
  GetMem(Row_Buffer[true], Row_Bytes + 1);
  ZeroMemory(Row_Buffer[false], Row_bytes + 1);
  RowUsed := TRUE;
  case Owner.InterlaceMethod of
    bsimNone:  DecodeNonInterlaced(stream, ZLIBStream, Size, crcfile);
    bsimAdam7: DecodeInterlacedAdam7(stream, ZLIBStream, size, crcfile);
  end;
  ZLIBTerminateInflate(ZLIBStream); {Terminates decompression}
  FreeMem(Row_Buffer[False], Row_Bytes + 1);
  FreeMem(Row_Buffer[True], Row_Bytes + 1);
  Stream.Read(CRCCheck, 4);
  CRCFile := CRCFile xor $ffffffff;
  CRCCheck := ByteSwap(CRCCheck);
  Result := CRCCheck = CRCFile;
 if not Result then
 begin
    exit;
  end;
end;

const
  IDATHeader: Array[0..3] of char = ('I', 'D', 'A', 'T');
  BUFFER = 5;

function TbsPngLayerIDAT.SaveToStream(Stream: TStream): Boolean;
var
  ZLIBStream : TZStreamRec2;
begin
  Header := Owner.PngLayers.Item[0] as TbsPngLayerIHDR;
  ImageWidth := Header.Width;
  ImageHeight := Header.Height;
  Owner.GetPixelInfo(Row_Bytes, Offset); {Obtain line information}
  GetMem(Encode_Buffer[BUFFER], Row_Bytes);
  ZeroMemory(Encode_Buffer[BUFFER], Row_Bytes);
  GetMem(Encode_Buffer[FILTER_NONE], Row_Bytes);
  ZeroMemory(Encode_Buffer[FILTER_NONE], Row_Bytes);
  if bspfSub in Owner.Filters then
    GetMem(Encode_Buffer[FILTER_SUB], Row_Bytes);
  if bspfUp in Owner.Filters then
    GetMem(Encode_Buffer[FILTER_UP], Row_Bytes);
  if bspfAverage in Owner.Filters then
    GetMem(Encode_Buffer[FILTER_AVERAGE], Row_Bytes);
  if bspfPaeth in Owner.Filters then
    GetMem(Encode_Buffer[FILTER_PAETH], Row_Bytes);

  ZLIBStream := ZLIBInitDeflate(Stream, Owner.fCompressionLevel,
    Owner.MaxIdatSize);
  case Owner.InterlaceMethod of
    bsimNone: EncodeNonInterlaced(stream, ZLIBStream);
    bsimAdam7: EncodeInterlacedAdam7(stream, ZLIBStream);
  end;

  ZLIBTerminateDeflate(ZLIBStream);

  FreeMem(Encode_Buffer[BUFFER], Row_Bytes);
  FreeMem(Encode_Buffer[FILTER_NONE], Row_Bytes);
  if bspfSub in Owner.Filters then
    FreeMem(Encode_Buffer[FILTER_SUB], Row_Bytes);
  if bspfUp in Owner.Filters then
    FreeMem(Encode_Buffer[FILTER_UP], Row_Bytes);
  if bspfAverage in Owner.Filters then
    FreeMem(Encode_Buffer[FILTER_AVERAGE], Row_Bytes);
  if bspfPaeth in Owner.Filters then
    FreeMem(Encode_Buffer[FILTER_PAETH], Row_Bytes);

  Result := True;
end;

procedure WriteIDAT(Stream: TStream; Data: Pointer; const Length: Cardinal);
var
  PngLayerLen, CRC: Cardinal;
begin
  PngLayerLen := ByteSwap(Length);
  Stream.Write(PngLayerLen, 4);
  Stream.Write(IDATHeader[0], 4);
  CRC := update_crc($ffffffff, @IDATHeader[0], 4); 
  Stream.Write(Data^, Length);
  CRC := Byteswap(update_crc(CRC, Data, Length) xor $ffffffff);
  Stream.Write(CRC, 4);
end;

procedure TbsPngLayerIDAT.IDATZlibWrite(var ZLIBStream: TZStreamRec2;
  Buffer: Pointer; const Length: Cardinal);
begin
  with ZLIBStream, ZLIBStream.ZLIB do
  begin
    next_in := Buffer;
    avail_in := Length;

    while avail_in > 0 do
    begin
      deflate(ZLIB, Z_NO_FLUSH);

      if avail_out = 0 then
      begin
        WriteIDAT(fStream, Data, Owner.MaxIdatSize);

        next_out := Data;
        avail_out := Owner.MaxIdatSize;
      end;
    end;
  end;
end;

procedure TbsPngLayerIDAT.FinishIDATZlib(var ZLIBStream: TZStreamRec2);
begin
  with ZLIBStream, ZLIBStream.ZLIB do
  begin
    next_in := nil;
    avail_in := 0;

    while deflate(ZLIB,Z_FINISH) <> Z_STREAM_END do
    begin
      WriteIDAT(fStream, Data, Owner.MaxIdatSize - avail_out);
      next_out := Data;
      avail_out := Owner.MaxIdatSize;
    end;
    if avail_out < Owner.MaxIdatSize then
      WriteIDAT(fStream, Data, Owner.MaxIdatSize - avail_out);
  end;
end;

procedure TbsPngLayerIDAT.EncodeNonInterlacedRGB8(Src, Dest, Trans: pChar);
var
  I: Integer;
begin
  FOR I := 1 TO ImageWidth DO
  begin
    Byte(Dest^) := fOwner.InverseGamma[pByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^) := fOwner.InverseGamma[pByte(Longint(Src) + 1)^]; inc(Dest);
    Byte(Dest^) := fOwner.InverseGamma[pByte(Longint(Src)    )^]; inc(Dest);
    inc(Src, 3);
  end {for I}
end;

procedure TbsPngLayerIDAT.EncodeNonInterlacedRGB16(Src, Dest, Trans: pChar);
var
  I: Integer;
begin
  FOR I := 1 TO ImageWidth DO
  begin
    pWORD(Dest)^ := fOwner.InverseGamma[pByte(Longint(Src) + 2)^]; inc(Dest, 2);
    pWORD(Dest)^ := fOwner.InverseGamma[pByte(Longint(Src) + 1)^]; inc(Dest, 2);
    pWORD(Dest)^ := fOwner.InverseGamma[pByte(Longint(Src)    )^]; inc(Dest, 2);
    inc(Src, 3);
  end;
end;

procedure TbsPngLayerIDAT.EncodeNonInterlacedPalette148(Src, Dest, Trans: pChar);
begin
  CopyMemory(Dest, Src, Row_Bytes);
end;

procedure TbsPngLayerIDAT.EncodeNonInterlacedGrayscale16(Src, Dest, Trans: pChar);
var
  I: Integer;
begin
  FOR I := 1 TO ImageWidth DO
  begin
    pWORD(Dest)^ := pByte(Longint(Src))^; inc(Dest, 2);
    inc(Src);
  end;
end;

procedure TbsPngLayerIDAT.EncodeNonInterlacedRGBAlpha8(Src, Dest, Trans: pChar);
var
  i: Integer;
begin
  FOR i := 1 TO ImageWidth do
  begin
    Byte(Dest^) := Owner.InverseGamma[PByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^) := Owner.InverseGamma[PByte(Longint(Src) + 1)^]; inc(Dest);
    Byte(Dest^) := Owner.InverseGamma[PByte(Longint(Src)    )^]; inc(Dest);
    Dest^ := Trans^; inc(Dest);
    inc(Src, 3); inc(Trans);
  end;
end;

procedure TbsPngLayerIDAT.EncodeNonInterlacedRGBAlpha16(Src, Dest, Trans: pChar);
var
  i: Integer;
begin
  FOR i := 1 TO ImageWidth do
  begin
    pWord(Dest)^ := Owner.InverseGamma[PByte(Longint(Src) + 2)^]; inc(Dest, 2);
    pWord(Dest)^ := Owner.InverseGamma[PByte(Longint(Src) + 1)^]; inc(Dest, 2);
    pWord(Dest)^ := Owner.InverseGamma[PByte(Longint(Src)    )^]; inc(Dest, 2);
    pWord(Dest)^ := PByte(Longint(Trans)  )^; inc(Dest, 2);
    inc(Src, 3); inc(Trans);
  end;
end;

procedure TbsPngLayerIDAT.EncodeNonInterlacedGrayscaleAlpha8(
  Src, Dest, Trans: pChar);
var
  i: Integer;
begin
  FOR i := 1 TO ImageWidth do
  begin
    Dest^ := Src^; inc(Dest);
    Dest^ := Trans^; inc(Dest);
    inc(Src); inc(Trans);
  end;
end;

procedure TbsPngLayerIDAT.EncodeNonInterlacedGrayscaleAlpha16(
  Src, Dest, Trans: pChar);
var
  i: Integer;
begin
  FOR i := 1 TO ImageWidth do
  begin
    pWord(Dest)^ := pByte(Src)^;    inc(Dest, 2);
    pWord(Dest)^ := pByte(Trans)^;  inc(Dest, 2);
    inc(Src); inc(Trans);
  end;
end;

procedure TbsPngLayerIDAT.EncodeNonInterlaced(Stream: TStream;
  var ZLIBStream: TZStreamRec2);
var
  j: Cardinal;
  Data, Trans: PChar;
  Filter: Byte;
  CopyProc: procedure(Src, Dest, Trans: pChar) of object;
begin
  CopyProc := nil;
  case Header.ColorType of
    COLOR_RGB:
      case Header.BitDepth of
        8: CopyProc := EncodeNonInterlacedRGB8;
       16: CopyProc := EncodeNonInterlacedRGB16;
      end;
    COLOR_GRAYSCALE, COLOR_PALETTE:
      case Header.BitDepth of
        1, 4, 8: CopyProc := EncodeNonInterlacedPalette148;
             16: CopyProc := EncodeNonInterlacedGrayscale16;
      end;
    COLOR_RGBALPHA:
      case Header.BitDepth of
          8: CopyProc := EncodeNonInterlacedRGBAlpha8;
         16: CopyProc := EncodeNonInterlacedRGBAlpha16;
      end;
    COLOR_GRAYSCALEALPHA:
      case Header.BitDepth of
        8:  CopyProc := EncodeNonInterlacedGrayscaleAlpha8;
       16:  CopyProc := EncodeNonInterlacedGrayscaleAlpha16;
      end;
  end;

  Longint(Data) := Longint(Header.ImageData) +
    Header.BytesPerRow * (ImageHeight - 1);
  Trans := Header.ImageAlpha;

  FOR j := 0 to ImageHeight - 1 do
  begin
    CopyProc(Data, @Encode_Buffer[BUFFER][0], Trans);
    Filter := FilterToEncode;
    IDATZlibWrite(ZLIBStream, @Filter, 1);
    IDATZlibWrite(ZLIBStream, @Encode_Buffer[Filter][0], Row_Bytes);
    dec(Data, Header.BytesPerRow);
    inc(Trans, ImageWidth);
  end;
  FinishIDATZlib(ZLIBStream);
end;

procedure TbsPngLayerIDAT.EncodeInterlacedRGB8(const Pass: Byte;
  Src, Dest, Trans: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Src := pChar(Longint(Src) + Col * 3);
  repeat
    Byte(Dest^) := fOwner.InverseGamma[pByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^) := fOwner.InverseGamma[pByte(Longint(Src) + 1)^]; inc(Dest);
    Byte(Dest^) := fOwner.InverseGamma[pByte(Longint(Src)    )^]; inc(Dest);
    inc(Src, ColumnIncrement[Pass] * 3);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.EncodeInterlacedRGB16(const Pass: Byte;
  Src, Dest, Trans: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Src := pChar(Longint(Src) + Col * 3);
  repeat
    pWord(Dest)^ := Owner.InverseGamma[pByte(Longint(Src) + 2)^]; inc(Dest, 2);
    pWord(Dest)^ := Owner.InverseGamma[pByte(Longint(Src) + 1)^]; inc(Dest, 2);
    pWord(Dest)^ := Owner.InverseGamma[pByte(Longint(Src)    )^]; inc(Dest, 2);
    inc(Src, ColumnIncrement[Pass] * 3);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.EncodeInterlacedPalette148(const Pass: Byte;
  Src, Dest, Trans: pChar);
const
  BitTable: Array[1..8] of Integer = ($1, $3, 0, $F, 0, 0, 0, $FF);
  StartBit: Array[1..8] of Integer = (7 , 0 , 0, 4,  0, 0, 0, 0);
var
  CurBit, Col: Integer;
  Src2: PChar;
begin
  fillchar(Dest^, Row_Bytes, #0);
  Col := ColumnStart[Pass];
  with Header.BitmapInfo.bmiHeader do
    repeat
      CurBit := StartBit[biBitCount];
      repeat
        Src2 := pChar(Longint(Src) + (biBitCount * Col) div 8);
        Byte(Dest^) := Byte(Dest^) or
          (((Byte(Src2^) shr (StartBit[Header.BitDepth] - (biBitCount * Col)
            mod 8))) and (BitTable[biBitCount])) shl CurBit;
        inc(Col, ColumnIncrement[Pass]);
        dec(CurBit, biBitCount);
      until CurBit < 0;
      inc(Dest);
    until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.EncodeInterlacedGrayscale16(const Pass: Byte;
  Src, Dest, Trans: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Src := pChar(Longint(Src) + Col);
  repeat
    pWord(Dest)^ := Byte(Src^); inc(Dest, 2);
    inc(Src, ColumnIncrement[Pass]);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.EncodeInterlacedRGBAlpha8(const Pass: Byte;
  Src, Dest, Trans: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Src := pChar(Longint(Src) + Col * 3);
  Trans := pChar(Longint(Trans) + Col);
  repeat
    Byte(Dest^) := Owner.InverseGamma[pByte(Longint(Src) + 2)^]; inc(Dest);
    Byte(Dest^) := Owner.InverseGamma[pByte(Longint(Src) + 1)^]; inc(Dest);
    Byte(Dest^) := Owner.InverseGamma[pByte(Longint(Src)    )^]; inc(Dest);
    Dest^ := Trans^; inc(Dest);
    inc(Src, ColumnIncrement[Pass] * 3);
    inc(Trans, ColumnIncrement[Pass]);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.EncodeInterlacedRGBAlpha16(const Pass: Byte;
  Src, Dest, Trans: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Src := pChar(Longint(Src) + Col * 3);
  Trans := pChar(Longint(Trans) + Col);
  repeat
    pWord(Dest)^ := pByte(Longint(Src) + 2)^; inc(Dest, 2);
    pWord(Dest)^ := pByte(Longint(Src) + 1)^; inc(Dest, 2);
    pWord(Dest)^ := pByte(Longint(Src)    )^; inc(Dest, 2);
    pWord(Dest)^ := pByte(Trans)^; inc(Dest, 2);
    inc(Src, ColumnIncrement[Pass] * 3);
    inc(Trans, ColumnIncrement[Pass]);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.EncodeInterlacedGrayscaleAlpha8(const Pass: Byte;
  Src, Dest, Trans: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Src := pChar(Longint(Src) + Col);
  Trans := pChar(Longint(Trans) + Col);
  repeat
    Dest^ := Src^;   inc(Dest);
    Dest^ := Trans^; inc(Dest);
    inc(Src, ColumnIncrement[Pass]);
    inc(Trans, ColumnIncrement[Pass]);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.EncodeInterlacedGrayscaleAlpha16(const Pass: Byte;
  Src, Dest, Trans: pChar);
var
  Col: Integer;
begin
  Col := ColumnStart[Pass];
  Src := pChar(Longint(Src) + Col);
  Trans := pChar(Longint(Trans) + Col);
  repeat
    pWord(Dest)^ := pByte(Src)^; inc(Dest, 2);
    pWord(Dest)^ := pByte(Trans)^; inc(Dest, 2);
    inc(Src, ColumnIncrement[Pass]);
    inc(Trans, ColumnIncrement[Pass]);
    inc(Col, ColumnIncrement[Pass]);
  until Col >= ImageWidth;
end;

procedure TbsPngLayerIDAT.EncodeInterlacedAdam7(Stream: TStream;
  var ZLIBStream: TZStreamRec2);
var
  CurrentPass, Filter: Byte;
  PixelsThisRow: Integer;
  CurrentRow : Integer;
  Trans, Data: pChar;
  CopyProc: procedure(const Pass: Byte;
    Src, Dest, Trans: pChar) of object;
begin
  CopyProc := nil;
  case Header.ColorType of
    COLOR_RGB:
      case Header.BitDepth of
        8: CopyProc := EncodeInterlacedRGB8;
       16: CopyProc := EncodeInterlacedRGB16;
      end;
    COLOR_PALETTE, COLOR_GRAYSCALE:
      case Header.BitDepth of
        1, 4, 8: CopyProc := EncodeInterlacedPalette148;
             16: CopyProc := EncodeInterlacedGrayscale16;
      end;
    COLOR_RGBALPHA:
      case Header.BitDepth of
          8: CopyProc := EncodeInterlacedRGBAlpha8;
         16: CopyProc := EncodeInterlacedRGBAlpha16;
      end;
    COLOR_GRAYSCALEALPHA:
      case Header.BitDepth of
          8: CopyProc := EncodeInterlacedGrayscaleAlpha8;
         16: CopyProc := EncodeInterlacedGrayscaleAlpha16;
      end;
  end;

  FOR CurrentPass := 0 TO 6 DO
  begin
    PixelsThisRow := (ImageWidth - ColumnStart[CurrentPass] +
      ColumnIncrement[CurrentPass] - 1) div ColumnIncrement[CurrentPass];
    Row_Bytes := BytesForPixels(PixelsThisRow, Header.ColorType,
      Header.BitDepth);
    ZeroMemory(Encode_Buffer[FILTER_NONE], Row_Bytes);
    CurrentRow := RowStart[CurrentPass];
    Data := Ptr(Longint(Header.ImageData) + Header.BytesPerRow *
      (ImageHeight - 1 - CurrentRow));
    Trans := Ptr(Longint(Header.ImageAlpha) + ImageWidth * CurrentRow);

    if Row_Bytes > 0 then
      while CurrentRow < ImageHeight do
      begin
        CopyProc(CurrentPass, Data, @Encode_Buffer[BUFFER][0], Trans);
        Filter := FilterToEncode;

        IDATZlibWrite(ZLIBStream, @Filter, 1);
        IDATZlibWrite(ZLIBStream, @Encode_Buffer[Filter][0], Row_Bytes);

        inc(CurrentRow, RowIncrement[CurrentPass]);
        dec(Data, RowIncrement[CurrentPass] * Header.BytesPerRow);
        inc(Trans, RowIncrement[CurrentPass] * ImageWidth);
      end;

  end;
  FinishIDATZlib(ZLIBStream);
end;

function TbsPngLayerIDAT.FilterToEncode: Byte;
var
  Run, LongestRun, ii, jj: Cardinal;
  Last, Above, LastAbove: Byte;
begin
  if bspfSub in Owner.Filters then
    for ii := 0 to Row_Bytes - 1 do
    begin
      if (ii >= Offset) then
        last := Encode_Buffer[BUFFER]^[ii - Offset]
      else
        last := 0;
      Encode_Buffer[FILTER_SUB]^[ii] := Encode_Buffer[BUFFER]^[ii] - last;
    end;

  if bspfUp in Owner.Filters then
    for ii := 0 to Row_Bytes - 1 do
      Encode_Buffer[FILTER_UP]^[ii] := Encode_Buffer[BUFFER]^[ii] -
        Encode_Buffer[FILTER_NONE]^[ii];

  if bspfAverage in Owner.Filters then
    for ii := 0 to Row_Bytes - 1 do
    begin
      if (ii >= Offset) then
        last := Encode_Buffer[BUFFER]^[ii - Offset]
      else
        last := 0;
      above := Encode_Buffer[FILTER_NONE]^[ii];
      Encode_Buffer[FILTER_AVERAGE]^[ii] := Encode_Buffer[BUFFER]^[ii] -
        (above + last) div 2 ;
    end;
  if bspfPaeth in Owner.Filters then
  begin
    last := 0;
    lastabove := 0;
    for ii := 0 to Row_Bytes - 1 do
    begin
      if (ii >= Offset) then
      begin
        last := Encode_Buffer[BUFFER]^[ii - Offset];
        lastabove := Encode_Buffer[FILTER_NONE]^[ii - Offset];
      end;
      above := Encode_Buffer[FILTER_NONE]^[ii];
      Encode_Buffer[FILTER_PAETH]^[ii] := Encode_Buffer[BUFFER]^[ii] -
        PaethPredictor(last, above, lastabove);
    end;
  end;

  CopyMemory(@Encode_Buffer[FILTER_NONE]^[0],
    @Encode_Buffer[BUFFER]^[0], Row_Bytes);

  if (Owner.Filters = [bspfNone]) or (Owner.Filters = []) then
  begin
    Result := FILTER_NONE;
    exit;
  end;

  LongestRun := 0; Result := FILTER_NONE;
  for ii := FILTER_NONE TO FILTER_PAETH do
    if TbsPngFilter(ii) in Owner.Filters then
    begin
      Run := 0;
      if Owner.Filters = [TbsPngFilter(ii)] then
      begin
        Result := ii;
        exit;
      end;

      for jj := 2 to Row_Bytes - 1 do
        if (Encode_Buffer[ii]^[jj] = Encode_Buffer [ii]^[jj-1]) or
            (Encode_Buffer[ii]^[jj] = Encode_Buffer [ii]^[jj-2]) then
          inc(Run);  {Count the number of sequences}

      if (Run > LongestRun) then
      begin
        Result := ii;
        LongestRun := Run;
      end;
    end;
end;

{TbsPngLayerPLTE}

function TbsPngLayerPLTE.GetPaletteItem(Index: Byte): TRGBQuad;
begin
  if Index > Count - 1 then
    begin
    end
  else
    Result := Header.BitmapInfo.bmiColors[Index];
end;

function TbsPngLayerPLTE.LoadFromStream(Stream: TStream;
  const PngLayerName: TbsPngLayerName; Size: Integer): Boolean;
type
  pPalEntry = ^PalEntry;
  PalEntry = record
    r, g, b: Byte;
  end;
var
  j        : Integer;
  PalColor : pPalEntry;
  palEntries: TMaxLogPalette;
begin
  Result := inherited LoadFromStream(Stream, PngLayerName, Size);
  if not Result then exit;
  if (Size mod 3 <> 0) or (Size div 3 > 256) then
  begin
    Result := FALSE;
    exit;
  end;
  fCount := Size div 3;
  Fillchar(palEntries, sizeof(palEntries), #0);
  palEntries.palVersion := $300;
  palEntries.palNumEntries := fCount;
  PalColor := Data;
  FOR j := 0 TO fCount - 1 DO
    with palEntries.palPalEntry[j] do
    begin
      peRed  :=  Owner.GammaTable[PalColor.r];
      peGreen := Owner.GammaTable[PalColor.g];
      peBlue :=  Owner.GammaTable[PalColor.b];
      peFlags := 0;
      inc(PalColor);
    end;
  Owner.SetPalette(CreatePalette(pLogPalette(@palEntries)^));
end;

function TbsPngLayerPLTE.SaveToStream(Stream: TStream): Boolean;
var
  J: Integer;
  DataPtr: pByte;
  BitmapInfo: TMAXBITMAPINFO;
  palEntries: TMaxLogPalette;
begin
  if fCount = 0 then fCount := Header.BitmapInfo.bmiHeader.biClrUsed;
  ResizeData(fCount * 3);
  fillchar(palEntries, sizeof(palEntries), #0);
  GetPaletteEntries(Header.ImagePalette, 0, 256, palEntries.palPalEntry[0]);
  DataPtr := fData;
  BitmapInfo := Header.BitmapInfo;
  FOR j := 0 TO fCount - 1 DO
    with palEntries.palPalEntry[j] do
    begin
      DataPtr^ := Owner.InverseGamma[peRed]; inc(DataPtr);
      DataPtr^ := Owner.InverseGamma[peGreen]; inc(DataPtr);
      DataPtr^ := Owner.InverseGamma[peBlue]; inc(DataPtr);
    end;
  Result := inherited SaveToStream(Stream);
end;

procedure TbsPngLayerPLTE.Assign(Source: TbsPngLayer);
begin
  if Source is TbsPngLayerPLTE then
    fCount := TbsPngLayerPLTE(Source).fCount;
end;

{TbsPngLayergAMA}

procedure TbsPngLayergAMA.Assign(Source: TbsPngLayer);
begin
  if Source is TbsPngLayergAMA then
    Gamma := TbsPngLayergAMA(Source).Gamma;
end;

constructor TbsPngLayergAMA.Create(Owner: TbsPngImage);
begin
  inherited Create(Owner);
  Gamma := 1;
end;

function TbsPngLayergAMA.GetValue: Cardinal;
begin
  if DataSize <> 4 then
  begin
    ResizeData(4);
    Result := 1;
  end
  else Result := Cardinal(ByteSwap(pCardinal(Data)^))
end;

function Power(Base, Exponent: Extended): Extended;
begin
  if Exponent = 0.0 then  Result := 1.0
  else if (Base = 0) or (Exponent = 0) then Result := 0
  else
    Result := Exp(Exponent * Ln(Base));
end;

function TbsPngLayergAMA.LoadFromStream(Stream: TStream;
  const PngLayerName: TbsPngLayerName; Size: Integer): Boolean;
var
  i: Integer;
  Value: Cardinal;
begin
  Result := inherited LoadFromStream(Stream, PngLayerName, Size);
  if not Result then exit;
  Value := Gamma;
  if Value <> 0 then
    with Owner do
      FOR i := 0 TO 255 DO
      begin
        GammaTable[I] := Round(Power((I / 255), 1 /
          (Value / 100000 * 2.2)) * 255);
        InverseGamma[Round(Power((I / 255), 1 /
          (Value / 100000 * 2.2)) * 255)] := I;
      end
end;

procedure TbsPngLayergAMA.SetValue(const Value: Cardinal);
begin
  if DataSize <> 4 then ResizeData(4);
  pCardinal(Data)^ := ByteSwap(Value);
end;

{TbsPngImage}

procedure TbsPngImage.Assign(Source: TPersistent);
begin
  if Source = nil then
    ClearPngLayers
  else if Source is TbsPngImage then
    AssignPNG(Source as TbsPngImage)
  else if Source is TBitmap then
    with Source as TBitmap do
      AssignHandle(Handle, Transparent,
        ColorToRGB(TransparentColor))
  else
    inherited;
end;

procedure TbsPngImage.CreateAlpha;
var
  TRNS: TbsPngLayerTRNS;
begin
  with Header do
    case ColorType of
      COLOR_GRAYSCALE, COLOR_RGB:
      begin
        if ColorType = COLOR_GRAYSCALE then
          ColorType := COLOR_GRAYSCALEALPHA
        else ColorType := COLOR_RGBALPHA;
        GetMem(ImageAlpha, Integer(Width) * Integer(Height));
        FillChar(ImageAlpha^, Integer(Width) * Integer(Height), #255);
      end;
      COLOR_PALETTE:
      begin
        if PngLayers.ItemFromClass(TbsPngLayerTRNS) = nil then
          TRNS := PngLayers.Add(TbsPngLayerTRNS) as TbsPngLayerTRNS
        else
          TRNS := PngLayers.ItemFromClass(TbsPngLayerTRNS) as TbsPngLayerTRNS;
          with TRNS do
          begin
            ResizeData(256);
            Fillchar(PaletteValues[0], 256, 255);
            fDataSize := 1 shl Header.BitDepth;
            fBitTransparency := False
          end;
        end;
    end;
end;

procedure TbsPngImage.ClearPngLayers;
var
  i: Integer;
begin
  InitializeGamma();
  for i := 0 TO Integer(PngLayers.Count) - 1 do
    TbsPngLayer(PngLayers.Item[i]).Free;
  PngLayers.Count := 0;
end;

constructor TbsPngImage.CreateBlank(ColorType, BitDepth: Cardinal;
  cx, cy: Integer);
var NewIHDR: TbsPngLayerIHDR;
begin
  Create;
  if not (ColorType in [COLOR_GRAYSCALE, COLOR_RGB, COLOR_PALETTE,
    COLOR_GRAYSCALEALPHA, COLOR_RGBALPHA]) or not (BitDepth in
    [1,2,4,8, 16]) or ((ColorType = COLOR_PALETTE) and (BitDepth = 16)) or
    ((ColorType = COLOR_RGB) and (BitDepth < 8)) then
  begin
    exit;
  end;
  if Bitdepth = 2 then Bitdepth := 4;
  InitializeGamma;
  BeingCreated := True;
  PngLayers.Add(TbsPngLayerIEND);
  NewIHDR := PngLayers.Add(TbsPngLayerIHDR) as TbsPngLayerIHDR;
  NewIHDR.IHDRData.ColorType := ColorType;
  NewIHDR.IHDRData.BitDepth := BitDepth;
  NewIHDR.IHDRData.Width := cx;
  NewIHDR.IHDRData.Height := cy;
  NewIHDR.PrepareImageData;
  if NewIHDR.HasPalette then
    TbsPngLayerPLTE(PngLayers.Add(TbsPngLayerPLTE)).fCount := 1 shl BitDepth;
  PngLayers.Add(TbsPngLayerIDAT);
  BeingCreated := False;
end;

constructor TbsPngImage.Create;
begin
  inherited Create;
  fCanvas := TCanvas.Create;
  fFilters := [bspfSub];
  fCompressionLevel := 7;
  fInterlaceMethod := bsimNone;
  fMaxIdatSize := High(Word);
  fPngLayerList := TbsPngList.Create(Self);

end;

destructor TbsPngImage.Destroy;
begin
  if fCanvas <> nil
  then
    begin
      fCanvas.Handle := 0;
      fCanvas.Free;
      fCanvas := nil;
    end;
  ClearPngLayers;
  fPngLayerList.Free;
  inherited Destroy;
end;

procedure TbsPngImage.GetPixelInfo(var LineSize, Offset: Cardinal);
begin
  if HeaderPresent then
  begin
    LineSize := BytesForPixels(Header.Width, Header.ColorType, Header.BitDepth);
    Case Header.ColorType of
      COLOR_GRAYSCALE:
        If Header.BitDepth = 16 Then
          Offset := 2
        Else
          Offset := 1 ;
      COLOR_PALETTE:
        offset := 1;
      COLOR_RGB:
        offset := 3 * Header.BitDepth Div 8;
      COLOR_GRAYSCALEALPHA:
        offset := 2 * Header.BitDepth Div 8;
      COLOR_RGBALPHA:
        offset := 4 * Header.BitDepth Div 8;
      else
        Offset := 0;
      End ;

  end
  else
  begin
    Offset := 0;
    LineSize := 0;
  end;
end;

function TbsPngImage.GetHeight: Integer;
begin
  if HeaderPresent then
    Result := TbsPngLayerIHDR(PngLayers.Item[0]).Height
  else Result := 0;
end;

function TbsPngImage.GetWidth: Integer;
begin
  if HeaderPresent then
    Result := Header.Width
  else Result := 0;
end;

function TbsPngImage.GetEmpty: Boolean;
begin
  Result := (PngLayers.Count = 0);
end;

procedure TbsPngImage.SetMaxIdatSize(const Value: Integer);
begin
  if Value < High(Word) then
    fMaxIdatSize := High(Word) else fMaxIdatSize := Value;
end;

function TbsPngImage.GetHeader: TbsPngLayerIHDR;
begin
  if (PngLayers.Count <> 0) and (PngLayers.Item[0] is TbsPngLayerIHDR) then
    Result := PngLayers.Item[0] as TbsPngLayerIHDR
  else
  begin
    Result := nil;
  end;
end;

procedure TbsPngImage.DrawPngLayerialTrans(DC: HDC; Rect: TRect);
  procedure AdjustRect(var Rect: TRect);
  var
    t: Integer;
  begin
    if Rect.Right < Rect.Left then
    begin
      t := Rect.Right;
      Rect.Right := Rect.Left;
      Rect.Left := t;
    end;
    if Rect.Bottom < Rect.Top then
    begin
      t := Rect.Bottom;
      Rect.Bottom := Rect.Top;
      Rect.Top := t;
    end
  end;

type
  TPixelLine = Array[Word] of TRGBQuad;
  pPixelLine = ^TPixelLine;
const

  BitmapInfoHeader: TBitmapInfoHeader =
    (biSize: sizeof(TBitmapInfoHeader);
     biWidth: 100;
     biHeight: 100;
     biPlanes: 1;
     biBitCount: 32;
     biCompression: BI_RGB;
     biSizeImage: 0;
     biXPelsPerMeter: 0;
     biYPelsPerMeter: 0;
     biClrUsed: 0;
     biClrImportant: 0);
var
  BitmapInfo  : TBitmapInfo;
  BufferDC    : HDC;
  BufferBits  : Pointer;
  OldBitmap,
  BufferBitmap: HBitmap;
  Header: TbsPngLayerIHDR;

  TransparencyPngLayer: TbsPngLayertRNS;
  PalettePngLayer: TbsPngLayerPLTE;
  TransValue, PaletteIndex: Byte;
  CurBit: Integer;
  Data: PByte;

  BytesPerRowDest,
  BytesPerRowSrc,
  BytesPerRowAlpha: Integer;
  ImageSource, ImageSourceOrg,
  AlphaSource     : pByteArray;
  ImageData       : pPixelLine;
  i, j, i2, j2    : Integer;

  W, H            : Cardinal;
  Stretch         : Boolean;
  FactorX, FactorY: Double;
begin
  if (Rect.Right = Rect.Left) or (Rect.Bottom = Rect.Top) then exit;
  AdjustRect(Rect);
  W := Rect.Right - Rect.Left;
  H := Rect.Bottom - Rect.Top;
  Header := Self.Header; {Fast access to header}
  Stretch := (W <> Header.Width) or (H <> Header.Height);
  if Stretch then FactorX := W / Header.Width else FactorX := 1;
  if Stretch then FactorY := H / Header.Height else FactorY := 1;

  Fillchar(BitmapInfo, sizeof(BitmapInfo), #0);
  BitmapInfoHeader.biWidth := W;
  BitmapInfoHeader.biHeight := -Integer(H);
  BitmapInfo.bmiHeader := BitmapInfoHeader;


  BufferDC := CreateCompatibleDC(0);

  BufferBitmap := CreateDIBSection(BufferDC, BitmapInfo, DIB_RGB_COLORS,
   BufferBits, 0, 0);

  if (BufferBitmap = 0) or (BufferBits = Nil) then
  begin
    if BufferBitmap <> 0 then DeleteObject(BufferBitmap);
    DeleteDC(BufferDC);
  end;

  OldBitmap := SelectObject(BufferDC, BufferBitmap);

  BitBlt(BufferDC, 0, 0, W, H, DC, Rect.Left, Rect.Top, SRCCOPY);

  BytesPerRowAlpha := Header.Width;
  BytesPerRowDest := (((BitmapInfo.bmiHeader.biBitCount * W) + 31)
    and not 31) div 8;
  BytesPerRowSrc := (((Header.BitmapInfo.bmiHeader.biBitCount * Header.Width) +
    31) and not 31) div 8; 

  ImageData := BufferBits;
  AlphaSource := Header.ImageAlpha;
  Longint(ImageSource) := Longint(Header.ImageData) +
    Header.BytesPerRow * Longint(Header.Height - 1);
  ImageSourceOrg := ImageSource;

  case Header.BitmapInfo.bmiHeader.biBitCount of
    24:
      FOR j := 1 TO H DO
      begin
        FOR i := 0 TO W - 1 DO
        begin
          if Stretch then i2 := trunc(i / FactorX) else i2 := i;
          if (AlphaSource[i2] <> 0) then
            if (AlphaSource[i2] = 255) then
              ImageData[i] := pRGBQuad(@ImageSource[i2 * 3])^
            else
              with ImageData[i] do
              begin
                rgbRed := (255+ImageSource[2+i2*3] * AlphaSource[i2] + rgbRed *
                  (not AlphaSource[i2])) shr 8;
                rgbGreen := (255+ImageSource[1+i2*3] * AlphaSource[i2] +
                  rgbGreen * (not AlphaSource[i2])) shr 8;
                rgbBlue := (255+ImageSource[i2*3] * AlphaSource[i2] + rgbBlue *
                 (not AlphaSource[i2])) shr 8;
            end;
          end;
        inc(Longint(ImageData), BytesPerRowDest);
        if Stretch then j2 := trunc(j / FactorY) else j2 := j;
        Longint(ImageSource) := Longint(ImageSourceOrg) - BytesPerRowSrc * j2;
        Longint(AlphaSource) := Longint(Header.ImageAlpha) +
          BytesPerRowAlpha * j2;
      end;
    1,4,8: if Header.ColorType = COLOR_GRAYSCALEALPHA then
      FOR j := 1 TO H DO
      begin
        FOR i := 0 TO W - 1 DO
          with ImageData[i], Header.BitmapInfo do begin
            if Stretch then i2 := trunc(i / FactorX) else i2 := i;
            rgbRed := (255 + ImageSource[i2] * AlphaSource[i2] +
              rgbRed * (255 - AlphaSource[i2])) shr 8;
            rgbGreen := (255 + ImageSource[i2] * AlphaSource[i2] +
              rgbGreen * (255 - AlphaSource[i2])) shr 8;
            rgbBlue := (255 + ImageSource[i2] * AlphaSource[i2] +
              rgbBlue * (255 - AlphaSource[i2])) shr 8;
          end;

        Longint(ImageData) := Longint(ImageData) + BytesPerRowDest;
        if Stretch then j2 := trunc(j / FactorY) else j2 := j;
        Longint(ImageSource) := Longint(ImageSourceOrg) - BytesPerRowSrc * j2;
        Longint(AlphaSource) := Longint(Header.ImageAlpha) +
          BytesPerRowAlpha * j2;
      end
    else
    begin
      TransparencyPngLayer := TbsPngLayertRNS(PngLayers.ItemFromClass(TbsPngLayertRNS));
      PalettePngLayer := TbsPngLayerPLTE(PngLayers.ItemFromClass(TbsPngLayerPLTE));

      FOR j := 1 TO H DO
      begin
        i := 0;
        repeat
          CurBit := 0;
          if Stretch then i2 := trunc(i / FactorX) else i2 := i;
          Data := @ImageSource[i2];

          repeat
            case Header.BitDepth of
              1: PaletteIndex := (Data^ shr (7-(I Mod 8))) and 1;
            2,4: PaletteIndex := (Data^ shr ((1-(I Mod 2))*4)) and $0F;
             else PaletteIndex := Data^;
            end;

            with ImageData[i] do
            begin
              TransValue := TransparencyPngLayer.PaletteValues[PaletteIndex];
              rgbRed := (255 + PalettePngLayer.Item[PaletteIndex].rgbRed *
                 TransValue + rgbRed * (255 - TransValue)) shr 8;
              rgbGreen := (255 + PalettePngLayer.Item[PaletteIndex].rgbGreen *
                 TransValue + rgbGreen * (255 - TransValue)) shr 8;
              rgbBlue := (255 + PalettePngLayer.Item[PaletteIndex].rgbBlue *
                 TransValue + rgbBlue * (255 - TransValue)) shr 8;
            end;

            inc(i); inc(CurBit, Header.BitmapInfo.bmiHeader.biBitCount);
          until CurBit >= 8;
        until i >= Integer(W);

        Longint(ImageData) := Longint(ImageData) + BytesPerRowDest;
        if Stretch then j2 := trunc(j / FactorY) else j2 := j;
        Longint(ImageSource) := Longint(ImageSourceOrg) - BytesPerRowSrc * j2;
      end;
    end;
  end;

  BitBlt(DC, Rect.Left, Rect.Top, W, H, BufferDC, 0, 0, SRCCOPY);

  SelectObject(BufferDC, OldBitmap);
  DeleteObject(BufferBitmap);
  DeleteDC(BufferDC);
end;

procedure TbsPngImage.Draw(ACanvas: TCanvas; const Rect: TRect);
var
  Header: TbsPngLayerIHDR;
begin
  if Empty then Exit;
  Header := PngLayers.GetItem(0) as TbsPngLayerIHDR;
  case Self.TransparencyMode of
    bsptmPngLayerial:
      DrawPngLayerialTrans(ACanvas.Handle, Rect);
    bsptmBit: DrawTransparentBitmap(ACanvas.Handle,
      Header.ImageData, Header.BitmapInfo.bmiHeader,
      pBitmapInfo(@Header.BitmapInfo), Rect, ColorToRGB(TransparentColor))
    else
    begin
      SetStretchBltMode(ACanvas.Handle, COLORONCOLOR);
      StretchDiBits(ACanvas.Handle, Rect.Left,
        Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, 0, 0,
        Header.Width, Header.Height, Header.ImageData,
        pBitmapInfo(@Header.BitmapInfo)^, DIB_RGB_COLORS, SRCCOPY)
    end
  end;
end;

const
  PngHeader: Array[0..7] of Char = (#137, #80, #78, #71, #13, #10, #26, #10);

procedure TbsPngImage.LoadFromStream(Stream: TStream);
var
  Header    : Array[0..7] of Char;
  HasIDAT   : Boolean;
  PngLayerCount : Cardinal;
  PngLayerLength: Cardinal;
  PngLayerName  : TbsPngLayerName;
begin
  PngLayerCount := 0;
  ClearPngLayers();
  Stream.Read(Header[0], 8);
  if Header <> PngHeader then
  begin
    Exit;
  end;

  HasIDAT := FALSE;
  PngLayers.Count := 10;

  repeat
    inc(PngLayerCount);
    if PngLayers.Count < PngLayerCount then
      PngLayers.Count := PngLayers.Count + 10;

    if Stream.Read(PngLayerLength, 4) = 0 then
    begin
      PngLayers.Count := PngLayerCount - 1;
    end;

    PngLayerLength := ByteSwap(PngLayerLength);
    Stream.Read(PngLayername, 4);

    if (PngLayerCount = 1) and (PngLayerName <> 'IHDR') then
    begin
      PngLayers.Count := PngLayerCount - 1;
      exit;
    end;

    if (HasIDAT and (PngLayerName = 'IDAT')) or (PngLayerName = 'cHRM') then
    begin
      dec(PngLayerCount);
      Stream.Seek(PngLayerLength + 4, soFromCurrent);
      Continue;
    end;
    if PngLayerName = 'IDAT' then HasIDAT := TRUE;

    PngLayers.SetItem(PngLayerCount - 1, CreateClassPngLayer(Self, PngLayerName));

    try if not TbsPngLayer(PngLayers.Item[PngLayerCount - 1]).LoadFromStream(Stream,
       PngLayerName, PngLayerLength) then break;
    except
      PngLayers.Count := PngLayerCount;
      raise;
    end;

  until (PngLayerName = 'IEND');

  PngLayers.Count := PngLayerCount;

end;

procedure TbsPngImage.SetHeight(Value: Integer);
begin
  Resize(Width, Value)
end;

procedure TbsPngImage.SetWidth(Value: Integer);
begin
  Resize(Value, Height)
end;

function TbsPngImage.GetTransparent: Boolean;
begin
  Result := (TransparencyMode <> bsptmNone);
end;

procedure TbsPngImage.SaveToStream(Stream: TStream);
var
  j: Integer;
begin
  Stream.Write(PNGHeader[0], 8);
  FOR j := 0 TO PngLayers.Count - 1 DO
    PngLayers.Item[j].SaveToStream(Stream)
end;

procedure BuildHeader(Header: TbsPngLayerIHDR; Handle: HBitmap; Info: pBitmap);
var
  DC: HDC;
begin
  Header.Width  := Info.bmWidth;
  Header.Height := abs(Info.bmHeight);
  if Info.bmBitsPixel >= 16 then
    Header.BitDepth := 8 else Header.BitDepth := Info.bmBitsPixel;
  if Info.bmBitsPixel >= 16 then
    Header.ColorType := COLOR_RGB else Header.ColorType := COLOR_PALETTE;
  Header.CompressionMethod := 0;
  Header.InterlaceMethod := 0;
  Header.PrepareImageData();
  DC := CreateCompatibleDC(0);
  GetDIBits(DC, Handle, 0, Header.Height, Header.ImageData,
    pBitmapInfo(@Header.BitmapInfo)^, DIB_RGB_COLORS);
  DeleteDC(DC);
end;

procedure TbsPngImage.LoadFromResourceName(Instance: HInst;
  const Name: String);
var
  ResStream: TResourceStream;
begin
  try ResStream := TResourceStream.Create(Instance, Name, RT_RCDATA);
  except 
    exit;
  end;
  try
    LoadFromStream(ResStream);
  finally
    ResStream.Free;
  end;
end;

procedure TbsPngImage.LoadFromResourceID(Instance: HInst; ResID: Integer);
begin
  LoadFromResourceName(Instance, String(ResID));
end;

procedure TbsPngImage.AssignTo(Dest: TPersistent);
  function DetectPixelFormat: TPixelFormat;
  begin
    with Header do
    begin
      if TransparencyMode = bsptmPngLayerial then
        DetectPixelFormat := pf24bit
      else
        case BitDepth of
          1: DetectPixelFormat := pf1bit;
          2, 4: DetectPixelFormat := pf4bit;
          8, 16:
            case ColorType of
              COLOR_RGB, COLOR_GRAYSCALE: DetectPixelFormat := pf24bit;
              COLOR_PALETTE: DetectPixelFormat := pf8bit;
              else raise Exception.Create('');
            end
          else raise Exception.Create('');
        end;
    end;
  end;
var
  TRNS: TbsPngLayerTRNS;
begin
  if Dest is TbsPngImage then
    TbsPngImage(Dest).AssignPNG(Self)
  else if (Dest is TBitmap) and HeaderPresent then
  begin
    TBitmap(Dest).PixelFormat := DetectPixelFormat;
    TBitmap(Dest).Width := Width;
    TBitmap(Dest).Height := Height;
    TBitmap(Dest).Canvas.Draw(0, 0, Self);

    if (TransparencyMode = bsptmBit) then
    begin
      TRNS := PngLayers.ItemFromClass(TbsPngLayerTRNS) as TbsPngLayerTRNS;
      TBitmap(Dest).TransparentColor := TRNS.TransparentColor;
      TBitmap(Dest).Transparent := True
    end;
  end
  else
    inherited AssignTo(Dest);
end;

procedure TbsPngImage.AssignHandle(Handle: HBitmap; Transparent: Boolean;
  TransparentColor: ColorRef);
var
  BitmapInfo: Windows.TBitmap;
  Header: TbsPngLayerIHDR;
  PLTE: TbsPngLayerPLTE;
  IDAT: TbsPngLayerIDAT;
  IEND: TbsPngLayerIEND;
  TRNS: TbsPngLayerTRNS;
  i: Integer;
  palEntries : TMaxLogPalette;
begin
  GetObject(Handle, SizeOf(BitmapInfo), @BitmapInfo);
  ClearPngLayers();
  Header := TbsPngLayerIHDR.Create(Self);
  BuildHeader(Header, Handle, @BitmapInfo);
  if Header.HasPalette then PLTE := TbsPngLayerPLTE.Create(Self) else PLTE := nil;
  if Transparent then TRNS := TbsPngLayerTRNS.Create(Self) else TRNS := nil;
  IDAT := TbsPngLayerIDAT.Create(Self);
  IEND := TbsPngLayerIEND.Create(Self);
  TbsPngPointerList(PngLayers).Add(Header);
  if Header.HasPalette then TbsPngPointerList(PngLayers).Add(PLTE);
  if Transparent then TbsPngPointerList(PngLayers).Add(TRNS);
  TbsPngPointerList(PngLayers).Add(IDAT);
  TbsPngPointerList(PngLayers).Add(IEND);


  if Header.HasPalette then
  begin
    PLTE.fCount := 1 shl BitmapInfo.bmBitsPixel;

    fillchar(palEntries, sizeof(palEntries), 0);
    palEntries.palVersion := $300;
    palEntries.palNumEntries := 1 shl BitmapInfo.bmBitsPixel;
    for i := 0 to palEntries.palNumEntries - 1 do
    begin
      palEntries.palPalEntry[i].peRed   := Header.BitmapInfo.bmiColors[i].rgbRed;
      palEntries.palPalEntry[i].peGreen := Header.BitmapInfo.bmiColors[i].rgbGreen;
      palEntries.palPalEntry[i].peBlue  := Header.BitmapInfo.bmiColors[i].rgbBlue;
    end;
    DoSetPalette(CreatePalette(pLogPalette(@palEntries)^), false);
  end;

  if Transparent then TRNS.TransparentColor := TransparentColor;
end;

procedure TbsPngImage.AssignPNG(Source: TbsPngImage);
var
  J: Integer;
begin
  InterlaceMethod := Source.InterlaceMethod;
  MaxIdatSize := Source.MaxIdatSize;
  CompressionLevel := Source.CompressionLevel;
  Filters := Source.Filters;
  ClearPngLayers();
  PngLayers.Count := Source.PngLayers.Count;
  FOR J := 0 TO PngLayers.Count - 1 DO
    with Source.PngLayers do
    begin
      PngLayers.SetItem(J, TbsPngLayerClass(TbsPngLayer(Item[J]).ClassType).Create(Self));
      TbsPngLayer(PngLayers.Item[J]).Assign(TbsPngLayer(Item[J]));
    end;
end;

function TbsPngImage.GetAlphaScanline(const LineIndex: Integer): pByteArray;
begin
  with Header do
    if (ColorType = COLOR_RGBALPHA) or (ColorType = COLOR_GRAYSCALEALPHA) then
      Longint(Result) := Longint(ImageAlpha) + (LineIndex * Longint(Width))
    else Result := nil;  {In case the image does not use alpha information}
end;

function TbsPngImage.GetExtraScanline(const LineIndex: Integer): Pointer;
begin
  with Header do
    Longint(Result) := (Longint(ExtraImageData) + ((Longint(Height) - 1) *
      BytesPerRow)) - (LineIndex * BytesPerRow);
end;

function TbsPngImage.GetScanline(const LineIndex: Integer): Pointer;
begin
  with Header do
    Longint(Result) := (Longint(ImageData) + ((Longint(Height) - 1) *
      BytesPerRow)) - (LineIndex * BytesPerRow);
end;

procedure TbsPngImage.InitializeGamma;
var
  i: Integer;
begin
  FOR i := 0 to 255 do
  begin
    GammaTable[i] := i;
    InverseGamma[i] := i;
  end;
end;

function TbsPngImage.GetTransparencyMode: TbsPngTransparencyMode;
var
  TRNS: TbsPngLayerTRNS;
begin
  with Header do
  begin
    Result := bsptmNone;
    TRNS := PngLayers.ItemFromClass(TbsPngLayerTRNS) as TbsPngLayerTRNS;

    case ColorType of
      COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA: Result := bsptmPngLayerial;
      COLOR_RGB, COLOR_GRAYSCALE: if TRNS <> nil then Result := bsptmBit;
      COLOR_PALETTE:
        if TRNS <> nil then
          if TRNS.BitTransparency then
            Result := bsptmBit else Result := bsptmPngLayerial
    end;
  end;
end;

procedure TbsPngImage.RemoveTransparency;
var
  TRNS: TbsPngLayerTRNS;
begin
  with Header do
    case ColorType of
      COLOR_PALETTE:
      begin
       TRNS := PngLayers.ItemFromClass(TbsPngLayerTRNS) as TbsPngLayerTRNS;
       if TRNS <> nil then PngLayers.RemovePngLayer(TRNS)
      end;
      COLOR_GRAYSCALEALPHA, COLOR_RGBALPHA:
      begin
        if ColorType = COLOR_GRAYSCALEALPHA then
          ColorType := COLOR_GRAYSCALE
        else ColorType := COLOR_RGB;
        if ImageAlpha <> nil then FreeMem(ImageAlpha);
        ImageAlpha := nil
      end
    end
end;

function TbsPngImage.GetTransparentColor: TColor;
var
  TRNS: TbsPngLayerTRNS;
begin
  TRNS := PngLayers.ItemFromClass(TbsPngLayerTRNS) as TbsPngLayerTRNS;
  if Assigned(TRNS) then Result := TRNS.TransparentColor
    else Result := 0
end;

procedure TbsPngImage.SetTransparentColor(const Value: TColor);
var
  TRNS: TbsPngLayerTRNS;
begin
  if HeaderPresent then
    case Header.ColorType of
    COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA:
      begin
      end;
    COLOR_PALETTE, COLOR_RGB, COLOR_GRAYSCALE:
      begin
        TRNS := PngLayers.ItemFromClass(TbsPngLayerTRNS) as TbsPngLayerTRNS;
        if not Assigned(TRNS) then TRNS := PngLayers.Add(TbsPngLayerTRNS) as TbsPngLayerTRNS;
        TRNS.TransparentColor := ColorToRGB(Value);
      end;
    end;
end;

function TbsPngImage.HeaderPresent: Boolean;
begin
  Result := ((PngLayers.Count <> 0) and (PngLayers.Item[0] is TbsPngLayerIHDR));
end;

function GetByteArrayPixel(const png: TbsPngImage; const X, Y: Integer): TColor;
var
  ByteData: Byte;
  DataDepth: Byte;
begin
  with png, Header do
  begin
    DataDepth := BitDepth;
    if DataDepth > 8 then DataDepth := 8;
    ByteData := pByteArray(png.Scanline[Y])^[X div (8 div DataDepth)];
    ByteData := (ByteData shr ((8 - DataDepth) -
      (X mod (8 div DataDepth)) * DataDepth));
    ByteData:= ByteData and ($FF shr (8 - DataDepth));
    case ColorType of
      COLOR_PALETTE:
        with TbsPngLayerPLTE(png.PngLayers.ItemFromClass(TbsPngLayerPLTE)).Item[ByteData] do
          Result := rgb(GammaTable[rgbRed], GammaTable[rgbGreen],
            GammaTable[rgbBlue]);
      COLOR_GRAYSCALE:
      begin
        if BitDepth = 1
        then ByteData := GammaTable[Byte(ByteData * 255)]
        else ByteData := GammaTable[Byte(ByteData * ((1 shl DataDepth) + 1))];
        Result := rgb(ByteData, ByteData, ByteData);
      end;
      else Result := 0;
    end;
  end;
end;

procedure SetByteArrayPixel(const png: TbsPngImage; const X, Y: Integer;
  const Value: TColor);
const
  ClearFlag: Array[1..8] of Integer = (1, 3, 0, 15, 0, 0, 0, $FF);
var
  ByteData: pByte;
  DataDepth: Byte;
  ValEntry: Byte;
begin
  with png.Header do
  begin
    ValEntry := GetNearestPaletteIndex(Png.Palette, ColorToRGB(Value));

    DataDepth := BitDepth;
    if DataDepth > 8 then DataDepth := 8;

    ByteData := @pByteArray(png.Scanline[Y])^[X div (8 div DataDepth)];

    ByteData^ := ByteData^ and not (ClearFlag[DataDepth] shl ((8 - DataDepth) -
      (X mod (8 div DataDepth)) * DataDepth));

    ByteData^ := ByteData^ or (ValEntry shl ((8 - DataDepth) -
      (X mod (8 div DataDepth)) * DataDepth));
  end;
end;

function GetRGBLinePixel(const png: TbsPngImage;
  const X, Y: Integer): TColor;
begin
  with pRGBLine(png.Scanline[Y])^[X] do
    Result := RGB(rgbtRed, rgbtGreen, rgbtBlue)
end;

procedure SetRGBLinePixel(const png: TbsPngImage;
 const X, Y: Integer; Value: TColor);
begin
  with pRGBLine(png.Scanline[Y])^[X] do
  begin
    rgbtRed := GetRValue(Value);
    rgbtGreen := GetGValue(Value);
    rgbtBlue := GetBValue(Value)
  end
end;

function GetGrayLinePixel(const png: TbsPngImage;
  const X, Y: Integer): TColor;
var
  B: Byte;
begin
  B := PByteArray(png.Scanline[Y])^[X];
  Result := RGB(B, B, B);
end;

procedure SetGrayLinePixel(const png: TbsPngImage;
 const X, Y: Integer; Value: TColor);
begin
  PByteArray(png.Scanline[Y])^[X] := GetRValue(Value);
end;

procedure TbsPngImage.Resize(const CX, CY: Integer);
  function Min(const A, B: Integer): Integer;
  begin
    if A < B then Result := A else Result := B;
  end;
var
  Header: TbsPngLayerIHDR;
  Line, NewBytesPerRow: Integer;
  NewHandle: HBitmap;
  NewDC: HDC;
  NewImageData: Pointer;
  NewImageAlpha: Pointer;
  NewImageExtra: Pointer;
begin
  if (CX > 0) and (CY > 0) then
  begin
    Header := Self.Header;

    NewDC := CreateCompatibleDC(Header.ImageDC);
    Header.BitmapInfo.bmiHeader.biWidth := cx;
    Header.BitmapInfo.bmiHeader.biHeight := cy;
    NewHandle := CreateDIBSection(NewDC, pBitmapInfo(@Header.BitmapInfo)^,
      DIB_RGB_COLORS, NewImageData, 0, 0);
    SelectObject(NewDC, NewHandle);
    if Canvas <> nil
    then
      Canvas.Handle := NewDC;
    NewBytesPerRow := (((Header.BitmapInfo.bmiHeader.biBitCount * cx) + 31)
      and not 31) div 8;

    for Line := 0 to Min(CY - 1, Height - 1) do
      CopyMemory(Ptr(Longint(NewImageData) + (Longint(CY) - 1) *
      NewBytesPerRow - (Line * NewBytesPerRow)), Scanline[Line],
      Min(NewBytesPerRow, Header.BytesPerRow));

    if (Header.ColorType = COLOR_RGBALPHA) or
      (Header.ColorType = COLOR_GRAYSCALEALPHA) then
    begin
      GetMem(NewImageAlpha, CX * CY);
      Fillchar(NewImageAlpha^, CX * CY, 255);
      for Line := 0 to Min(CY - 1, Height - 1) do
        CopyMemory(Ptr(Longint(NewImageAlpha) + (Line * CX)),
        AlphaScanline[Line], Min(CX, Width));
      FreeMem(Header.ImageAlpha);
      Header.ImageAlpha := NewImageAlpha;
    end;

    if (Header.BitDepth = 16) then
    begin
      GetMem(NewImageExtra, CX * CY);
      Fillchar(NewImageExtra^, CX * CY, 0);
      for Line := 0 to Min(CY - 1, Height - 1) do
        CopyMemory(Ptr(Longint(NewImageExtra) + (Line * CX)),
        ExtraScanline[Line], Min(CX, Width));
      FreeMem(Header.ExtraImageData);
      Header.ExtraImageData := NewImageExtra;
    end;

    DeleteObject(Header.ImageHandle);
    DeleteDC(Header.ImageDC);

    Header.BytesPerRow := NewBytesPerRow;
    Header.IHDRData.Width := CX;
    Header.IHDRData.Height := CY;
    Header.ImageData := NewImageData;

    Header.ImageHandle := NewHandle;
    Header.ImageDC := NewDC;
  end;
end;

procedure TbsPngImage.SetPixels(const X, Y: Integer; const Value: TColor);
begin
  if ((X >= 0) and (X <= Width - 1)) and
        ((Y >= 0) and (Y <= Height - 1)) then
    with Header do
    begin
      if ColorType in [COLOR_GRAYSCALE, COLOR_PALETTE] then
        SetByteArrayPixel(Self, X, Y, Value)
      else if ColorType in [COLOR_GRAYSCALEALPHA] then
        SetGrayLinePixel(Self, X, Y, Value)
      else
        SetRGBLinePixel(Self, X, Y, Value)
    end;
end;

function TbsPngImage.GetPixels(const X, Y: Integer): TColor;
begin
  if ((X >= 0) and (X <= Width - 1)) and
        ((Y >= 0) and (Y <= Height - 1)) then
    with Header do
    begin
      if ColorType in [COLOR_GRAYSCALE, COLOR_PALETTE] then
        Result := GetByteArrayPixel(Self, X, Y)
      else if ColorType in [COLOR_GRAYSCALEALPHA] then
        Result := GetGrayLinePixel(Self, X, Y)
      else
        Result := GetRGBLinePixel(Self, X, Y)
    end
  else Result := 0
end;

function TbsPngImage.GetPalette: HPALETTE;
begin
  Result := Header.ImagePalette;
end;

procedure TbsPngLayerpHYs.Assign(Source: TbsPngLayer);
begin
  fPPUnitY := TbsPngLayerpHYs(Source).fPPUnitY;
  fPPUnitX := TbsPngLayerpHYs(Source).fPPUnitX;
  fUnit := TbsPngLayerpHYs(Source).fUnit;
end;

function TbsPngLayerpHYs.LoadFromStream(Stream: TStream; const PngLayerName: TbsPngLayerName;
  Size: Integer): Boolean;
begin
  Result := inherited LoadFromStream(Stream, PngLayerName, Size);
  if not Result or (Size <> 9) then exit; 
  fPPUnitX := ByteSwap(pCardinal(Longint(Data))^);
  fPPUnitY := ByteSwap(pCardinal(Longint(Data) + 4)^);
  fUnit := pUnitType(Longint(Data) + 8)^;
end;

function TbsPngLayerpHYs.SaveToStream(Stream: TStream): Boolean;
begin
  ResizeData(9);
  pCardinal(Data)^ := ByteSwap(fPPUnitX);
  pCardinal(Longint(Data) + 4)^ := ByteSwap(fPPUnitY);
  pUnitType(Longint(Data) + 8)^ := fUnit;
  Result := inherited SaveToStream(Stream);
end;

procedure TbsPngImage.DoSetPalette(Value: HPALETTE; const UpdateColors: boolean);
begin
  if (Header.HasPalette)  then
  begin
    if UpdateColors then
      Header.PaletteToDIB(Value);
    SelectPalette(Header.ImageDC, Value, False);
    RealizePalette(Header.ImageDC);
    DeleteObject(Header.ImagePalette);
    Header.ImagePalette := Value;
  end
end;

procedure TbsPngImage.SetPalette(Value: HPALETTE);
begin
  DoSetPalette(Value, true);
end;

initialization
  PngLayerClasses := nil;
  crc_table_computed := FALSE;
  RegisterCommonPngLayers;
  {$IFDEF RegisterPNG}
  TPicture.RegisterFileFormat('PNG', 'PNG for BusinessSkinForm', TbsPngImage);
  {$ENDIF}
finalization
  {$IFDEF RegisterPNG}
  TPicture.UnregisterGraphicClass(TbsPngImage);
  {$ENDIF}
  FreePngLayerClassList;
 {$ENDIF}
end.