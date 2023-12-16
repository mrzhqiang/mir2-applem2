unit cliUtil;

interface

uses
  Windows, WIL, HGE, HGETextures, Graphics;

(*Windows,
DXDraws, DirectX, DIB, HUtil32; //, bmputil;

const
MAXGRADE = 64;
DIVUNIT = 4;
BIT16ALPHAMAXCOUNT = $10;
type
TColorEffect = (ceNone, ceGrayScale, ceBright, ceRed, ceGreen, ceBlue, ceYellow, ceFuchsia);

{TNearestIndexHeader = record
  Title: string[30];
  IndexCount: integer;
  desc: array[0..10] of byte;
end;   }
pTAlphaColor = ^TAlphaColor;
TAlphaColor = packed record
  Alpha: array[0..High(Byte), 0..High(Byte)] of Byte;
end;

TAlphaBit16 = packed record
  rgbBlue: Byte;
  rgbGreen: Byte;
  rgbRed: Byte;
  rgbReserved: Byte;
  Color: Word;
end;             *)
{
procedure BuildColorLevels();

procedure DrawBlend(dsuf: TDirectDrawSurface; x, y: integer; ssuf:
TDirectDrawSurface; blendmode: integer);
procedure DrawBlendEx(dsuf: TDirectDrawSurface; x, y: integer; ssuf:
TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight, blendmode:
integer);
procedure DrawAlpha(dsuf: TDirectDrawSurface; x, y: integer; ssuf:
TDirectDrawSurface; blendmode: integer; Alpha: Byte);
procedure DrawAlphaEx(dsuf: TDirectDrawSurface; x, y: integer; ssuf:
TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight, blendmode:
integer; Alpha: Byte);
procedure DrawAlphaOfColor(dsuf: TDirectDrawSurface; x, y, Width, Height: Integer; AColor: Word; Alpha: Byte);
procedure DrawAlphaWin(dsuf: TDirectDrawSurface; x, y: integer; ssuf:
TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight: integer);

procedure DrawEffect(x, y, width, height: integer; ssuf: TDirectDrawSurface; eff: TColorEffect);
procedure DrawLine(Surface: TDirectDrawSurface); }
procedure LoadColorLevels();
procedure UnLoadColorLevels();
function GetTempSurface(ColorFormat: TWILColorFormat): TDXImageTexture;
procedure DrawBlend(dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; blendmode: integer);
procedure DrawBlendR(dsuf: TDirectDrawSurface; x, y: integer; Rect: TRect; ssuf: TDirectDrawSurface; blendmode:
  integer);
procedure DrawEffect(dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; eff: TColorEffect; boBlend:
  Boolean; blendmode: integer = 0);
procedure CopyByGrayScale(Source, Target: TDirectDrawSurface; x, y: Integer);
//var
  //darklevel: integer;

implementation

uses
  HGEBase, MShare, Share;

var
  GrayScaleByR5G6B5: array[Word] of Word;
  GrayScaleByA1R5G5B5: array[Word] of Word;
  GrayScaleByA4R4G4B4: array[Word] of Word;
  GSA1R5G5B5ToA4R4G4B4: array[Word] of Word;
  ImgMixSurfaceR5G6B5: TDXImageTexture;
  ImgMixSurfaceA1R5G5B5: TDXImageTexture; //0x0C
  ImgMixSurfaceA4R4G4B4: TDXImageTexture; //0x0C
  ImgMaxSurfaceR5G6B5: TDXImageTexture;
  ImgMaxSurfaceA1R5G5B5: TDXImageTexture; //0x0C
  ImgMaxSurfaceA4R4G4B4: TDXImageTexture; //0x0C
  boA1R5G5B5, boR5G6B5, boA4R4G4B4: Boolean;

function GetTempSurface(ColorFormat: TWILColorFormat): TDXImageTexture;
begin
  Result := nil;
  case ColorFormat of
    WILFMT_A1R5G5B5: begin
      if boA1R5G5B5 then Result := ImgMaxSurfaceA1R5G5B5
      else Result := ImgMixSurfaceA1R5G5B5;
      boA1R5G5B5 := not boA1R5G5B5;
    end;
    WILFMT_A4R4G4B4: begin
      if boA4R4G4B4 then Result := ImgMaxSurfaceA4R4G4B4
      else Result := ImgMixSurfaceA4R4G4B4;
      boA4R4G4B4 := not boA4R4G4B4;
    end;
    WILFMT_R5G6B5: begin
      if boR5G6B5 then Result := ImgMaxSurfaceR5G6B5
      else Result := ImgMixSurfaceR5G6B5;
      boR5G6B5 := not boR5G6B5;
    end;
  end;
  if Result <> nil then
    Result.PatternSize := Point(g_FScreenWidth, g_FScreenHeight);
end;

procedure LoadColorLevels();
var
  i: integer;
  nA, nR, nG, nB, nX: Byte;
begin                           
  ImgMixSurfaceR5G6B5 := MakeDXImageTexture(g_FScreenWidth, g_FScreenHeight, WILFMT_R5G6B5);
  ImgMixSurfaceA1R5G5B5 := MakeDXImageTexture(g_FScreenWidth, g_FScreenHeight, WILFMT_A1R5G5B5);
  ImgMixSurfaceA4R4G4B4 := MakeDXImageTexture(g_FScreenWidth, g_FScreenHeight, WILFMT_A4R4G4B4);
  ImgMaxSurfaceR5G6B5 := MakeDXImageTexture(g_FScreenWidth, g_FScreenHeight, WILFMT_R5G6B5);
  ImgMaxSurfaceA1R5G5B5 := MakeDXImageTexture(g_FScreenWidth, g_FScreenHeight, WILFMT_A1R5G5B5);
  ImgMaxSurfaceA4R4G4B4 := MakeDXImageTexture(g_FScreenWidth, g_FScreenHeight, WILFMT_A4R4G4B4);
  ImgMixSurfaceR5G6B5.Canvas := g_DXCanvas;
  ImgMixSurfaceA1R5G5B5.Canvas := g_DXCanvas;
  ImgMixSurfaceA4R4G4B4.Canvas := g_DXCanvas;
  ImgMaxSurfaceR5G6B5.Canvas := g_DXCanvas;
  ImgMaxSurfaceA1R5G5B5.Canvas := g_DXCanvas;
  ImgMaxSurfaceA4R4G4B4.Canvas := g_DXCanvas;
  GrayScaleByR5G6B5[0] := 0;
  GrayScaleByA1R5G5B5[0] := 0;
  GrayScaleByA4R4G4B4[0] := 0;
  for I := Low(Word) to High(Word) do begin
    //R5G6B5
    nB := BYTE((Word(I) and $1F) shl 3);
    nG := BYTE((Word(I) and $7E0) shr 3);
    nR := BYTE((Word(I) and $F800) shr 8);
    nX := (nR + nG + nB) div 3;
    GrayScaleByR5G6B5[I] := ((Word(nX) and $F8) shl 8) + (Word(nX) and $FC shl 3) + (Word(nX) shr 3);

    //A1R5G5B5
    nB := BYTE((Word(I) and $1F) shl 3);
    nG := BYTE((Word(I) and $3E0) shr 2);
    nR := BYTE((Word(I) and $7C00) shr 7);
    nA := BYTE((Word(I) and $8000) shr 15);
    nX := (nR + nG + nB) div 3;
    GrayScaleByA1R5G5B5[I] := Word(nA) shl 15 + ((Word(nX) and $F8) shl 7) + (Word(nX) and $F8 shl 2) + (Word(nX) shr 3);

    //A4R4G4B4
    nB := BYTE((Word(I) and $F) shl 4);
    nG := BYTE(Word(I) and $F0);
    nR := BYTE((Word(I) and $F00) shr 4);
    nA := BYTE((Word(I) and $F000) shr 8);
    nX := (nR + nG + nB) div 3;
    GrayScaleByA4R4G4B4[I] := Word(nA) and $F0 shl 8 + ((Word(nX) and $F0) shl 4) + (Word(nX) and $F0) + (Word(nX) shr 4);

    nB := BYTE((Word(I) and $1F) shl 3);
    nG := BYTE((Word(I) and $3E0) shr 2);
    nR := BYTE((Word(I) and $7C00) shr 7);
    nA := BYTE((Word(I) and $8000) shr 15);
    nX := (nR + nG + nB) div 3;
    if nA = 0 then
      GSA1R5G5B5ToA4R4G4B4[I] := ((Word(nX) and $F0) shl 4) + (Word(nX) and $F0) + (Word(nX) shr 4)
    else
      GSA1R5G5B5ToA4R4G4B4[I] := $F000 + ((Word(nX) and $F0) shl 4) + (Word(nX) and $F0) + (Word(nX) shr 4);
  end;
end;

procedure UnLoadColorLevels();
begin
  if ImgMixSurfaceR5G6B5 <> nil then
    ImgMixSurfaceR5G6B5.Free;
  if ImgMixSurfaceA1R5G5B5 <> nil then
    ImgMixSurfaceA1R5G5B5.Free;
  if ImgMixSurfaceA4R4G4B4 <> nil then
    ImgMixSurfaceA4R4G4B4.Free;
  ImgMixSurfaceR5G6B5 := nil;
  ImgMixSurfaceA1R5G5B5 := nil;
  ImgMixSurfaceA4R4G4B4 := nil;
  if ImgMaxSurfaceR5G6B5 <> nil then
    ImgMaxSurfaceR5G6B5.Free;
  if ImgMaxSurfaceA1R5G5B5 <> nil then
    ImgMaxSurfaceA1R5G5B5.Free;
  if ImgMaxSurfaceA4R4G4B4 <> nil then
    ImgMaxSurfaceA4R4G4B4.Free;
  ImgMaxSurfaceR5G6B5 := nil;
  ImgMaxSurfaceA1R5G5B5 := nil;
  ImgMaxSurfaceA4R4G4B4 := nil;

end;

procedure DrawBlend(dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; blendmode: integer);
begin
  if blendmode = 0 then
    dsuf.Draw(x, y, ssuf.ClientRect, ssuf, $80FFFFFF, fxBlend)
  else
    dsuf.Draw(x, y, ssuf.ClientRect, ssuf, fxAnti);
end;

procedure DrawBlendR(dsuf: TDirectDrawSurface; x, y: integer; Rect: TRect; ssuf: TDirectDrawSurface; blendmode:
  integer);
begin
  if blendmode = 0 then
    dsuf.Draw(x, y, Rect, ssuf, $80FFFFFF, fxBlend)
  else
    dsuf.Draw(x, y, Rect, ssuf, fxAnti);
end;

procedure CopyByGrayScale(Source, Target: TDirectDrawSurface; x, y: Integer);
var
  SourceAccess, TargetAccess: TDXAccessInfo;
  srcleft, srcwidth, srctop, srcbottom, I: Integer;
  SourcePtr, TargetPtr: PChar;
  peff: PByte;
begin
  if Source = nil then exit;
  if x >= Target.Width then exit;
  if y >= Target.Height then exit;
  if x < 0 then begin
    srcleft := -x;
    srcwidth := Source.Width + x;
    x := 0;
  end
  else begin
    srcleft := 0;
    srcwidth := Source.Width;
  end;
  if y < 0 then begin
    srctop := -y;
    srcbottom := srctop + Source.Height + y;
    y := 0;
  end
  else begin
    srctop := 0;
    srcbottom := srctop + Source.Height;
  end;

  if (srcleft + srcwidth) > Source.Width then
    srcwidth := Source.Width - srcleft;
  if srcbottom > Source.Height then
    srcbottom := Source.Height;
  if (x + srcwidth) > Target.Width then
    srcwidth := Target.Width - x;

  if (y + srcbottom - srctop) > Target.Height then
    srcbottom := Target.Height - y + srctop;

  if (srcwidth <= 0) or (srcbottom <= 0) or (srcleft >= Source.Width) or (srctop >= Source.Height) then
    exit;

  if Source.Lock(lfReadOnly, SourceAccess) then begin
    Try
      case SourceAccess.Format of
        COLOR_A1R5G5B5: peff := @GSA1R5G5B5ToA4R4G4B4[0];
        COLOR_A4R4G4B4: peff := @GrayScaleByA4R4G4B4[0];
      else exit;
      end;
      if Target.Lock(lfWriteOnly, TargetAccess) then begin
        Try
          for i := srctop to srcbottom - 1 do begin
            SourcePtr := PChar(Integer(SourceAccess.Bits) + SourceAccess.Pitch * I + (srcleft * 2));
            TargetPtr := PChar(Integer(TargetAccess.Bits) + TargetAccess.Pitch * (y + i - srctop) + (X * 2));
            asm
              push esi
              push edi
              push ebx
              push edx
              push eax

              mov esi, SourcePtr
              mov edi, TargetPtr
              mov ecx, SrcWidth
              mov edx, peff
            @pixloop:
              movzx eax, [esi].Word
              add esi, 2

              cmp eax, 0
              je @Next

              shl eax, 1
              mov ax, [edx+eax].word

              mov [edi], ax
            @Next:
              add edi, 2

              dec ecx
              jnz @pixloop

              pop eax
              pop edx
              pop ebx
              pop edi
              pop esi
            end;
          end;
        Finally
          Target.UnLock;
        End;
      end;
    Finally
      Source.Unlock;
    End;
  end;
end;

procedure DrawEffect(dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; eff: TColorEffect; boBlend:
  Boolean; blendmode: integer);
var
  nColor: Integer;
  SourceAccess, TargetAccess: TDXAccessInfo;
  peff: PByte;
  TargetTexture: TDXImageTexture;
  SourcePtr, TargetPtr: PChar;
  I, nCount: Integer;
  DrawFx: Cardinal;
  nWidth, nHeight: Integer;
begin
  if boBlend then nColor := Integer($80000000)
    else nColor := Integer($FF000000);
  if blendmode = 0 then begin
    DrawFx := fxBlend;
  end
  else begin
    DrawFx := fxAnti;
  end;

  case eff of
    ceNone: ;
    ceGrayScale: begin
        nWidth := ssuf.Width;
        nHeight := ssuf.Height;
        if (nWidth > g_FScreenWidth) then nWidth := g_FScreenWidth;
        if (nHeight > g_FScreenHeight) then nHeight := g_FScreenHeight;
        if ssuf.Lock(lfReadOnly, SourceAccess) then begin
          try
            case SourceAccess.Format of
              COLOR_A1R5G5B5: begin
                  peff := @GrayScaleByA1R5G5B5[0];
                  TargetTexture := GetTempSurface(WILFMT_A1R5G5B5);
                end;
              COLOR_A4R4G4B4: begin
                  peff := @GrayScaleByA4R4G4B4[0];
                  TargetTexture := GetTempSurface(WILFMT_A4R4G4B4);
                end;
              COLOR_R5G6B5: begin
                  peff := @GrayScaleByR5G6B5[0];
                  TargetTexture := GetTempSurface(WILFMT_R5G6B5);
                end;
            else
              exit;
            end;
            if (peff <> nil) and (TargetTexture <> nil) then begin
              TargetTexture.PatternSize := Point(nWidth, nHeight);
              if TargetTexture.Lock(lfWriteOnly, TargetAccess) then begin
                Try
                  nCount := nWidth;
                  for I := 0 to nHeight - 1 do begin
                    SourcePtr := PChar(Integer(SourceAccess.Bits) + (SourceAccess.Pitch * I));
                    TargetPtr := PChar(Integer(TargetAccess.Bits) + (TargetAccess.Pitch * I));
                    asm
                      push esi
                      push edi
                      push ebx
                      push edx
                      push eax

                      mov esi, SourcePtr
                      mov edi, TargetPtr
                      mov ecx, nCount
                      mov edx, peff
                    @pixloop:
                      movzx eax, [esi].Word
                      add esi, 2

                      shl eax, 1
                      mov ax, [edx+eax].word

                      mov [edi], ax
                      add edi, 2

                      dec ecx
                      jnz @pixloop

                      pop eax
                      pop edx
                      pop ebx
                      pop edi
                      pop esi
                    end;
                  end;
                Finally
                  TargetTexture.Unlock;
                End;
              end;
            end;
          finally
            ssuf.Unlock;
          end;
          if TargetTexture <> nil then
            Dsuf.Draw(x, y, TargetTexture.ClientRect, TargetTexture, clWhite or nColor, DrawFx);
        end;
      end;
    ceBright: begin
      Dsuf.Draw(x, y, ssuf.ClientRect, ssuf, $FFFFFFFF, fxBlend);
      Dsuf.Draw(x, y, ssuf.ClientRect, ssuf, $FFC0C0C0, fxAnti);
    end;
    ceRed: Dsuf.Draw(x, y, ssuf.ClientRect, ssuf, clRed or nColor, DrawFx);
    ceGreen: Dsuf.Draw(x, y, ssuf.ClientRect, ssuf, clGreen or nColor, DrawFx);
    ceBlue: Dsuf.Draw(x, y, ssuf.ClientRect, ssuf, clBlue or nColor, DrawFx);
    ceYellow: Dsuf.Draw(x, y, ssuf.ClientRect, ssuf, clYellow or nColor, DrawFx);
    ceFuchsia: Dsuf.Draw(x, y, ssuf.ClientRect, ssuf, clFuchsia or nColor, DrawFx);
  end;
end;

//uses Share, MShare;

(*
 procedure DrawEffect(x, y, width, height: integer; ssuf: TDirectDrawSurface; eff: TColorEffect);
var
  i, srclen, scrheight: integer;
  sddsd: TDDSurfaceDesc;
  peff: PByte;
  sdptr: PWORD;
begin
  if (ssuf.canvas = nil) or (ssuf.canvas = nil) then
    exit;
  if x >= ssuf.Width then
    exit;
  if y >= ssuf.Height then
    exit;
  if (width > g_FScreenWidth) or (height > g_FScreenHeight) or (width < 1) or (height < 1) or (eff = ceNone) then
    Exit;
  srclen := width;
  scrheight := height;
  if srclen > ssuf.Width then
    srclen := ssuf.Width;
  if scrheight > ssuf.Height then
    scrheight := ssuf.Height;
  try
    peff := nil;
    case eff of
      ceGrayScale: peff := @GrayScaleLevel;
      ceBright: peff := @BrightColorLevel;
      ceRed: peff := @RedColorLevel;
      ceGreen: peff := @GreenColorLevel;
      ceBlue: peff := @BlueColorLevel;
      ceYellow: peff := @YellowColorLevel;
      ceFuchsia: peff := @FuchsiaColorLevel;
    end;
    if peff = nil then
      Exit;
    sddsd.dwSize := Sizeof(sddsd);
    ssuf.Lock(TRect(nil^), sddsd);
    if ssuf.BitCount = 16 then begin
      srclen := srclen * 2;
      for i := 0 to scrheight - 1 do begin
        sdptr := PWORD(integer(sddsd.lpSurface) + (y + i) * sddsd.lPitch + (x * 2));
        asm
            mov    ecx, 0
            mov    edi, sdptr
            mov    esi, peff
          @@CopySource:
            cmp    ecx, srclen
            jae    @@EndSourceCopy

            mov    ebx, ecx
            movzx  eax, [edi+ebx].word

            IMUL   eax, 2
            mov    ax, [esi+eax].word
            mov    [edi+ebx], ax

            Add    ecx, 2
            jmp    @@CopySource
          @@EndSourceCopy:
        end;
      end;
    end;
  finally
    ssuf.UnLock();
  end;
end;

var
  Color256Mix: array[0..High(Byte), 0..High(Byte)] of byte;
  Color256Anti: array[0..High(Byte), 0..High(Byte)] of byte;
  //Bit16ColorEx: array[0..BIT16RGBMAXCOUNT - 1, 0..BIT16RGBMAXCOUNT - 1, 0..BIT16RGBMAXCOUNT - 1] of Word;
  Bit16Color: array[0..High(Word)] of TRGBTriple;
  AlphaBit16Color: array[0..High(Word)] of TAlphaBit16;
  AlphaColor: array[0..BIT16ALPHAMAXCOUNT - 1] of pTAlphaColor;
  BrightColorLevel: array[0..High(Word)] of Word;
  GrayScaleLevel: array[0..High(Word)] of Word;
  RedColorLevel: array[0..High(Word)] of Word;
  GreenColorLevel: array[0..High(Word)] of Word;
  YellowColorLevel: array[0..High(Word)] of Word;
  BlueColorLevel: array[0..High(Word)] of Word;
  FuchsiaColorLevel: array[0..High(Word)] of Word;

procedure BuildColorLevels();
var
  n, i, ii, x, y: Integer;
  DefColor: Word;
  R, G, B, A, AR, AG, AB: Byte;
  Alpha: Integer;
begin
  for ii := Low(AlphaColor) to High(AlphaColor) do begin
    AlphaColor[ii] := AllocMem(SizeOf(TAlphaColor));
  end;
  BrightColorLevel[0] := 0;
  GrayScaleLevel[0] := 0;
  RedColorLevel[0] := 0;
  GreenColorLevel[0] := 0;
  YellowColorLevel[0] := 0;
  BlueColorLevel[0] := 0;
  FuchsiaColorLevel[0] := 0;
  Bit16Color[0].rgbtBlue := 0;
  Bit16Color[0].rgbtGreen := 0;
  Bit16Color[0].rgbtRed := 0;
  AlphaBit16Color[0].rgbBlue := 0;
  AlphaBit16Color[0].rgbGreen := 0;
  AlphaBit16Color[0].rgbRed := 0;
  AlphaBit16Color[0].rgbReserved := 0;
  AlphaBit16Color[0].Color := 0;
  Color256Mix[0, 0] := 0;
  Color256Anti[0, 0] := 0;
  for i := 1 to High(Word) do begin
    DefColor := i;
    Bit16ToRGB(DefColor, R, G, B);
    Bit16ToRGBAndAlpha(DefColor, A, AR, AG, AB);
    n := (R + G + B) div 3;
    Bit16Color[i].rgbtRed := r;
    Bit16Color[i].rgbtGreen := g;
    Bit16Color[i].rgbtBlue := b ;
    AlphaBit16Color[i].rgbBlue := AB;
    AlphaBit16Color[i].rgbGreen := AG;
    AlphaBit16Color[i].rgbRed := AR;
    AlphaBit16Color[i].rgbReserved := (Word(A) shr 4) and $F;
    AlphaBit16Color[i].Color := Bit24To16Bit(AR, AG, AB);
    GrayScaleLevel[i] := _MAX(Bit24To16Bit(n, n, n), $8);

    RedColorLevel[i] := _MAX(Bit24To16Bit(n, 0, 0), $8);
    GreenColorLevel[i] := _MAX(Bit24To16Bit(0, n, 0), $8);
    BlueColorLevel[i] := _MAX(Bit24To16Bit(0, 0, n), $8);
    YellowColorLevel[i] := _MAX(Bit24To16Bit(n, n, 0), $8);
    FuchsiaColorLevel[i] := _MAX(Bit24To16Bit(n, 0, n), $8);
    R := _MIN(Round(R * 1.5), 255);
    G := _MIN(Round(G * 1.5), 255);
    B := _MIN(Round(B * 1.5), 255);
    BrightColorLevel[i] := _MAX(Bit24To16Bit(R, G, B), $8);
    x := LoByte(i);
    y := HiByte(i);
    Color256Mix[x, y] := x div 2 + y div 2;
    Color256Anti[x, y] := _MIN(255, Round(x + (255 - x) / 255 * y));
    for ii := Low(AlphaColor) to High(AlphaColor) do begin
      Alpha := ii * 16;
      AlphaColor[ii].Alpha[x, y] := ((x * Alpha + y * (255 - Alpha)) div 255);
    end;
  end;
  {for R := 0 to BIT16RGBMAXCOUNT - 1 do
    for G := 0 to BIT16RGBMAXCOUNT - 1 do
      for B := 0 to BIT16RGBMAXCOUNT - 1 do begin
        Bit16ColorEx[R][G][B] := ((Word(r) and $3E) shl 10) + ((Word(g) and $3F) shl 5) + ((Word(b) and $3E) shr 1);
      end;     }
end;

procedure DrawAlphaWin(dsuf: TDirectDrawSurface; x, y: integer; ssuf:
  TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight: integer);
var
  i, srcleft, srctop, srcwidth, srcbottom: integer;
  sddsd, dddsd: TDDSurfaceDesc;
  sdptr, ddptr: PWORD;
  R, G, B: Byte;
  srclen: integer;
begin
  if (dsuf.canvas = nil) or (ssuf.canvas = nil) then
    exit;
  if x >= dsuf.Width then
    exit;
  if y >= dsuf.Height then
    exit;
  if x < 0 then begin
    srcleft := -x;
    srcwidth := ssufwidth + x;
    x := 0;
  end
  else begin
    srcleft := ssufleft;
    srcwidth := ssufwidth;
  end;
  if y < 0 then begin
    srctop := -y;
    srcbottom := srctop + ssufheight + y;
    y := 0;
  end
  else begin
    srctop := ssuftop;
    srcbottom := srctop + ssufheight;
  end;
  if (srcleft + srcwidth) > ssuf.Width then
    srcwidth := ssuf.Width - srcleft;
  if srcbottom > ssuf.Height then
    srcbottom := ssuf.Height;
  if (x + srcwidth) > dsuf.Width then
    srcwidth := dsuf.Width - x;

  if (y + srcbottom - srctop) > dsuf.Height then
    srcbottom := dsuf.Height - y + srctop;

  if (srcwidth <= 0) or (srcbottom <= 0) or (srcleft >= ssuf.Width) or (srctop >= ssuf.Height) then
    exit;

  try
    sddsd.dwSize := SizeOf(sddsd);
    dddsd.dwSize := SizeOf(dddsd);
    ssuf.Lock(TRect(nil^), sddsd);
    dsuf.Lock(TRect(nil^), dddsd);
    srclen := srcwidth * 2;
    srcleft := srcleft * 2;
    x := x * 2;

    if ssuf.BitCount = 16 then begin
      for i := srctop to srcbottom - 1 do begin
        sdptr := PWORD(integer(sddsd.lpSurface) + sddsd.lPitch * i + srcleft);
        ddptr := PWORD(integer(dddsd.lpSurface) + (y + i - srctop) * dddsd.lPitch + x);
        asm
            mov    ecx, 0
            //mov    esi, sdptr
            mov    edi, ddptr
          @@CopySource:
            cmp    ecx, srclen
            jae    @@EndSourceCopy

            mov    esi, sdptr
            movzx  eax, [esi+ecx].word    //sdptr
            cmp    eax, 0
            JE     @@Next

            lea    esi, AlphaBit16Color
            imul   eax, 6
            mov    bx,  [esi+eax].word //Alpha
            mov    edx,  [esi+eax+2] //Alpha

            cmp    dh, 0
            JE     @@Next

            cmp    dh, $0F
            JL    @@NextEx

            shr    edx, 16
            mov    [edi+ecx], dx
            add    ecx, 2
            jmp    @@CopySource
          @@NextEx:
            mov    B, bl
            mov    G, bh
            mov    R, dl

            movzx  eax, [edi+ecx].word    //sdptr
            lea    esi, Bit16Color
            imul   eax, 3
            mov    bx,  [esi+eax].word //Alpha
            mov    dl,  [esi+eax+2].byte //Alpha

            lea    esi, AlphaColor
            movzx  eax, dh
            imul   eax, 4
            mov    esi, [esi+eax]
            mov    dh, 0

            mov    eax, 0
            movzx  ax, R
            shl    ax, 8
            add    ax, dx
            mov    al, [esi+eax].byte
            mov    R, al

            movzx  eax, G
            movzx  edx, bh
            shl    eax, 8
            add    eax, edx
            mov    bh, [esi+eax].byte

            movzx  eax, B
            movzx  edx, bl
            shl    eax, 8
            add    eax, edx
            mov    bl, [esi+eax].byte

            //mov    [edi+edx], ax
            movzx  ax,    R
            and    ax,    $F8
            shl    ax,    8

            movzx  dx,    bh
            and    dx,    $FC
            shl    dx,    3

            movzx  bx,    bl
            shr    bx,    3

            add    ax,    dx
            add    ax,    bx

            mov    [edi+ecx], ax
          @@Next:
            add    ecx, 2
            jmp    @@CopySource
          @@EndSourceCopy:
        end;
      end;
    end;
  finally
    ssuf.UnLock();
    dsuf.UnLock();
  end;
end;

procedure DrawAlpha(dsuf: TDirectDrawSurface; x, y: integer; ssuf:
  TDirectDrawSurface; blendmode: integer; Alpha: Byte);
begin
  DrawAlphaEx(dsuf, x, y, ssuf, 0, 0, ssuf.Width, ssuf.Height, blendmode, Alpha);
end;

procedure DrawAlphaOfColor(dsuf: TDirectDrawSurface; x, y, Width, Height: Integer; AColor: Word; Alpha: Byte);
var
  i, srcleft, srctop, srcwidth, srcbottom: integer;
  dddsd: TDDSurfaceDesc;
  pmix: PByte;
  ddptr: PWORD;
  R, nR, nG, nB: Byte;
  srclen: integer;
  btAlpha: Byte;
begin
  if (dsuf.canvas = nil) then
    exit;
  btAlpha := Alpha div 16;
  if (btAlpha < 1) then
    exit;
  if x >= dsuf.Width then
    exit;
  if y >= dsuf.Height then
    exit;
  if x < 0 then begin
    srcleft := -x;
    srcwidth := Width + x;
    x := 0;
  end
  else begin
    srcleft := 0;
    srcwidth := Width;
  end;
  if y < 0 then begin
    srctop := -y;
    srcbottom := srctop + Height + y;
    y := 0;
  end
  else begin
    srctop := 0;
    srcbottom := srctop + Height;
  end;

  if (srcleft + srcwidth) > Width then
    srcwidth := Width - srcleft;
  if srcbottom > Height then
    srcbottom := Height;
  if (x + srcwidth) > dsuf.Width then
    srcwidth := dsuf.Width - x;

  if (y + srcbottom - srctop) > dsuf.Height then
    srcbottom := dsuf.Height - y + srctop;

  if (srcwidth <= 0) or (srcbottom <= 0) or (srcleft >= Width) or (srctop >= Height) then
    exit;
  nR := Bit16Color[AColor].rgbtRed;
  nG := Bit16Color[AColor].rgbtGreen;
  nB := Bit16Color[AColor].rgbtBlue;
  try
    dddsd.dwSize := SizeOf(dddsd);
    dsuf.Lock(TRect(nil^), dddsd);
    srclen := srcwidth * 2;
    pmix := @AlphaColor[btAlpha].Alpha[0, 0];
    x := x * 2;

    if dsuf.BitCount = 16 then begin
      for i := srctop to srcbottom - 1 do begin
        ddptr := PWORD(integer(dddsd.lpSurface) + (y + i - srctop) * dddsd.lPitch + x);
        asm
            mov    ecx, 0
            mov    esi, ddptr

          @@CopySource:
            cmp    ecx, srclen
            jae    @@EndSourceCopy

            movzx  eax, [esi+ecx].word
            imul   eax, 3

            lea    edi, Bit16Color
            mov    bx,  [edi+eax].word
            mov    dl,  [edi+eax+2].byte
            mov    dh, 0

            mov    edi, pmix
            mov    eax, 0
            movzx  ax, nR
            shl    ax, 8
            add    ax, dx
            mov    al, [edi+eax].byte
            mov    R, al

            movzx  eax, nG
            movzx  edx, bh
            shl    eax, 8
            add    eax, edx
            mov    bh, [edi+eax].byte

            movzx  eax, nB
            movzx  edx, bl
            shl    eax, 8
            add    eax, edx
            mov    bl, [edi+eax].byte

            movzx  ax,    R
            and    ax,    $F8
            shl    ax,    8

            movzx  dx,    bh
            and    dx,    $FC
            shl    dx,    3

            movzx  bx,    bl
            shr    bx,    3

            add    ax,    dx
            add    ax,    bx

            mov    [esi+ecx], ax
          @@Next:
            add    ecx, 2
            jmp    @@CopySource
          @@EndSourceCopy:
        end;
      end;
    end;
  finally
    dsuf.UnLock();
  end;
end;

procedure DrawAlphaEx(dsuf: TDirectDrawSurface; x, y: integer; ssuf:
  TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight, blendmode:
  integer; Alpha: Byte);
var
  i, srcleft, srctop, srcwidth, srcbottom: integer;
  sddsd, dddsd: TDDSurfaceDesc;
  pmix: PByte;
  sdptr, ddptr: PWORD;
  R, G, B: Byte;
  srclen: integer;
  btAlpha: Byte;
begin
  if (dsuf.canvas = nil) or (ssuf.canvas = nil) then
    exit;
  btAlpha := Alpha div 16;
  if (btAlpha < 1) then
    exit;
  if btAlpha > 14 then begin
    dsuf.Draw(x, y, ssuf.ClientRect, ssuf, Boolean(blendmode));
    exit;
  end;

  if x >= dsuf.Width then
    exit;
  if y >= dsuf.Height then
    exit;
  if x < 0 then begin
    srcleft := -x;
    srcwidth := ssufwidth + x;
    x := 0;
  end
  else begin
    srcleft := ssufleft;
    srcwidth := ssufwidth;
  end;
  if y < 0 then begin
    srctop := -y;
    srcbottom := srctop + ssufheight + y;
    y := 0;
  end
  else begin
    srctop := ssuftop;
    srcbottom := srctop + ssufheight;
  end;
  if (srcleft + srcwidth) > ssuf.Width then
    srcwidth := ssuf.Width - srcleft;
  if srcbottom > ssuf.Height then
    srcbottom := ssuf.Height;
  if (x + srcwidth) > dsuf.Width then
    srcwidth := dsuf.Width - x;

  if (y + srcbottom - srctop) > dsuf.Height then
    srcbottom := dsuf.Height - y + srctop;

  if (srcwidth <= 0) or (srcbottom <= 0) or (srcleft >= ssuf.Width) or (srctop >= ssuf.Height) then
    exit;

  try
    sddsd.dwSize := SizeOf(sddsd);
    dddsd.dwSize := SizeOf(dddsd);
    ssuf.Lock(TRect(nil^), sddsd);
    dsuf.Lock(TRect(nil^), dddsd);
    srclen := srcwidth * 2;
    srcleft := srcleft * 2;
    x :=  x * 2;
    pmix := @AlphaColor[btAlpha].Alpha[0, 0];

    if ssuf.BitCount = 16 then begin
      for i := srctop to srcbottom - 1 do begin
        sdptr := PWORD(integer(sddsd.lpSurface) + sddsd.lPitch * i + srcleft);
        ddptr := PWORD(integer(dddsd.lpSurface) + (y + i - srctop) * dddsd.lPitch + x);
        asm
            mov    ecx, 0
            mov    esi, pmix
          @@CopySource:
            cmp    ecx, srclen
            jae    @@EndSourceCopy

            mov    edi, sdptr
            movzx  eax, [edi+ecx].word    //sdptr
            cmp    eax, 0
            JE     @@Next

            lea    edi, Bit16Color
            imul   eax, 3
            mov    bx,  [edi+eax].word //Alpha
            mov    dl,  [edi+eax+2].byte //Alpha

            mov    B, bl
            mov    G, bh
            mov    R, dl

            mov    edi, ddptr
            movzx  eax, [edi+ecx].word    //sdptr

            lea    edi, Bit16Color
            imul   eax, 3
            mov    bx,  [edi+eax].word //Alpha
            mov    dl,  [edi+eax+2].byte //Alpha

            mov    dh, 0

            mov    eax, 0
            movzx  ax, R
            shl    ax, 8
            add    ax, dx
            mov    al, [esi+eax].byte
            mov    R, al

            movzx  eax, G
            movzx  edx, bh
            shl    eax, 8
            add    eax, edx
            mov    bh, [esi+eax].byte

            movzx  eax, B
            movzx  edx, bl
            shl    eax, 8
            add    eax, edx
            mov    bl, [esi+eax].byte

            movzx  ax,    R
            and    ax,    $F8
            shl    ax,    8

            movzx  dx,    bh
            and    dx,    $FC
            shl    dx,    3

            movzx  bx,    bl
            shr    bx,    3

            add    ax,    dx
            add    ax,    bx

            mov    edi, ddptr
            mov    [edi+ecx], ax
          @@Next:
            add    ecx, 2
            jmp    @@CopySource
          @@EndSourceCopy:
        end;
      end;
    end;
  finally
    ssuf.UnLock();
    dsuf.UnLock();
  end;
end;

procedure DrawBlend(dsuf: TDirectDrawSurface; x, y: integer; ssuf:
  TDirectDrawSurface; blendmode: integer);
begin
  DrawBlendEx(dsuf, x, y, ssuf, 0, 0, ssuf.Width, ssuf.Height, blendmode);
end;

procedure DrawBlendEx(dsuf: TDirectDrawSurface; x, y: integer; ssuf:
  TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight, blendmode:
  integer);
var
  i, srcleft, srctop, srcwidth, srcbottom: integer;
  sddsd, dddsd: TDDSurfaceDesc;
  pmix: PByte;
  sdptr, ddptr: PWORD;
  R, G, B: Byte;
  srclen: integer;
begin
  if (dsuf.canvas = nil) or (ssuf.canvas = nil) then
    exit;
  if x >= dsuf.Width then
    exit;
  if y >= dsuf.Height then
    exit;
  if x < 0 then begin
    srcleft := -x;
    srcwidth := ssufwidth + x;
    x := 0;
  end
  else begin
    srcleft := ssufleft;
    srcwidth := ssufwidth;
  end;
  if y < 0 then begin
    srctop := -y;
    srcbottom := srctop + ssufheight + y;
    y := 0;
  end
  else begin
    srctop := ssuftop;
    srcbottom := srctop + ssufheight;
  end;
  if (srcleft + srcwidth) > ssuf.Width then
    srcwidth := ssuf.Width - srcleft;
  if srcbottom > ssuf.Height then
    srcbottom := ssuf.Height;
  if (x + srcwidth) > dsuf.Width then
    srcwidth := dsuf.Width - x;

  if (y + srcbottom - srctop) > dsuf.Height then
    srcbottom := dsuf.Height - y + srctop;

  if (srcwidth <= 0) or (srcbottom <= 0) or (srcleft >= ssuf.Width) or (srctop >= ssuf.Height) then
    exit;

  try
    sddsd.dwSize := SizeOf(sddsd);
    dddsd.dwSize := SizeOf(dddsd);
    ssuf.Lock(TRect(nil^), sddsd);
    dsuf.Lock(TRect(nil^), dddsd);
    srclen := srcwidth * 2;
    srcleft := srcleft * 2;
    x := x * 2;
    if blendmode = 0 then
      pmix := @Color256Mix[0, 0]
    else
      pmix := @Color256Anti[0, 0];

    if ssuf.BitCount = 16 then begin
      for i := srctop to srcbottom - 1 do begin
        sdptr := PWORD(integer(sddsd.lpSurface) + sddsd.lPitch * i + srcleft);
        ddptr := PWORD(integer(dddsd.lpSurface) + (y + i - srctop) * dddsd.lPitch + x);
        asm
            mov    ecx, 0
            mov    esi, pmix
          @@CopySource:
            cmp    ecx, srclen
            jae    @@EndSourceCopy

            mov    edi, sdptr
            movzx  eax, [edi+ecx].word    //sdptr
            cmp    eax, 0
            JE     @@Next

            lea    edi, Bit16Color
            imul   eax, 3
            mov    bx,  [edi+eax].word //Alpha
            mov    dl,  [edi+eax+2].byte //Alpha

            mov    B, bl
            mov    G, bh
            mov    R, dl

            mov    edi, ddptr
            movzx  eax, [edi+ecx].word    //sdptr

            lea    edi, Bit16Color
            imul   eax, 3
            mov    bx,  [edi+eax].word //Alpha
            mov    dl,  [edi+eax+2].byte //Alpha

            mov    dh, 0

            mov    eax, 0
            movzx  ax, R
            shl    ax, 8
            add    ax, dx
            mov    al, [esi+eax].byte
            mov    R, al

            movzx  eax, G
            movzx  edx, bh
            shl    eax, 8
            add    eax, edx
            mov    bh, [esi+eax].byte

            movzx  eax, B
            movzx  edx, bl
            shl    eax, 8
            add    eax, edx
            mov    bl, [esi+eax].byte

            movzx  ax,    R
            and    ax,    $F8
            shl    ax,    8

            movzx  dx,    bh
            and    dx,    $FC
            shl    dx,    3

            movzx  bx,    bl
            shr    bx,    3

            add    ax,    dx
            add    ax,    bx

            mov    edi, ddptr
            mov    [edi+ecx], ax
          @@Next:
            add    ecx, 2
            jmp    @@CopySource
          @@EndSourceCopy:
        end;
      end;
    end;
  finally
    ssuf.UnLock();
    dsuf.UnLock();
  end;
end;

procedure DrawEffect(x, y, width, height: integer; ssuf: TDirectDrawSurface; eff: TColorEffect);
var
  i, srclen, scrheight: integer;
  sddsd: TDDSurfaceDesc;
  peff: PByte;
  sdptr: PWORD;
begin
  if (ssuf.canvas = nil) or (ssuf.canvas = nil) then
    exit;
  if x >= ssuf.Width then
    exit;
  if y >= ssuf.Height then
    exit;
  if (width > g_FScreenWidth) or (height > g_FScreenHeight) or (width < 1) or (height < 1) or (eff = ceNone) then
    Exit;
  srclen := width;
  scrheight := height;
  if srclen > ssuf.Width then
    srclen := ssuf.Width;
  if scrheight > ssuf.Height then
    scrheight := ssuf.Height;
  try
    peff := nil;
    case eff of
      ceGrayScale: peff := @GrayScaleLevel;
      ceBright: peff := @BrightColorLevel;
      ceRed: peff := @RedColorLevel;
      ceGreen: peff := @GreenColorLevel;
      ceBlue: peff := @BlueColorLevel;
      ceYellow: peff := @YellowColorLevel;
      ceFuchsia: peff := @FuchsiaColorLevel;
    end;
    if peff = nil then
      Exit;
    sddsd.dwSize := Sizeof(sddsd);
    ssuf.Lock(TRect(nil^), sddsd);
    if ssuf.BitCount = 16 then begin
      srclen := srclen * 2;
      for i := 0 to scrheight - 1 do begin
        sdptr := PWORD(integer(sddsd.lpSurface) + (y + i) * sddsd.lPitch + (x * 2));
        asm
            mov    ecx, 0
            mov    edi, sdptr
            mov    esi, peff
          @@CopySource:
            cmp    ecx, srclen
            jae    @@EndSourceCopy

            mov    ebx, ecx
            movzx  eax, [edi+ebx].word

            IMUL   eax, 2
            mov    ax, [esi+eax].word
            mov    [edi+ebx], ax

            Add    ecx, 2
            jmp    @@CopySource
          @@EndSourceCopy:
        end;
      end;
    end;
  finally
    ssuf.UnLock();
  end;
end;

procedure DrawLine(Surface: TDirectDrawSurface);
var
  nX, nY: integer;
begin
  for nX := 0 to Surface.width - 1 do begin
    Surface.Pixels[nX, 0] := 255;
  end;
  for nY := 0 to Surface.height - 1 do begin
    Surface.Pixels[0, nY] := 255;
  end;
  //Surface.height
end;            *)

end.


