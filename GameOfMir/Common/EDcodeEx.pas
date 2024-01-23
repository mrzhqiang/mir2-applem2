unit EDcodeEx;

interface

uses
  SysUtils, Grobal2, Windows;

type
  TDecode6BitBuf = procedure(sSource: PChar; pbuf: PChar; nSrcLen, nBufLen: Integer); stdcall;
  TEncode6BitBuf = procedure(pSrc, PDest: PChar; nSrcLen, nDestLen: Integer); stdcall;

function EncodeMessage(smsg: TDefaultMessage): string;
function DecodeMessage(str: string): TDefaultMessage;
function EncodeString(str: string): string;
function DecodeString(str: string): string;
function EncodeBuffer(Buf: PChar; bufsize: Integer): string;
procedure DecodeBuffer(Src: string; Buf: PChar; bufsize: Integer);
function MakeDefaultMsg(wIdent: Integer; nRecog: Integer; WParam, wTag, wSeries: Integer): TDefaultMessage;
function EncodeLongBuffer(Buf: PChar; bufsize: Integer): string;
procedure DecodeLongBuffer(Src: string; Buf: PChar; bufsize: Integer);



var
  RSADECODESTRING2: string = '_DqDNXi';
  DLL_Decode6BitBuf: TDecode6BitBuf = nil;
  DLL_Encode6BitBuf: TEncode6BitBuf = nil;


implementation


const
  BITMASKS = $AA;

function MakeDefaultMsg(wIdent: Integer; nRecog: Integer; WParam, wTag, wSeries: Integer): TDefaultMessage;
begin
  Result.Recog := nRecog;
  Result.ident := wIdent;
  Result.param := WParam;
  Result.tag := wTag;
  Result.series := wSeries;
end;

procedure code_Encode6BitBuf(pSrc, PDest: PChar; nSrcLen, nDestLen: Integer);  stdcall;
var
  i: Integer;
  nRestCount: Integer;
  nDestPos: Integer;
  btMade: byte;
  btCh: byte;
  btRest: byte;
  btXor: Byte;
begin
  nRestCount := 0;
  btRest := 0;
  nDestPos := 0;
  for i := 0 to nSrcLen - 1 do
  begin
    if nDestPos >= nDestLen then
      break;
    btCh := byte(pSrc[i]);

    btXor := BITMASKS;
    Inc(btXor, i);
    btCh := btCh xor btXor;

    btMade := byte((btRest or (btCh shr (2 + nRestCount))) and $3F);
    btRest := byte(((btCh shl (8 - (2 + nRestCount))) shr 2) and $3F);
    Inc(nRestCount, 2);

    if nRestCount < 6 then
    begin
      PDest[nDestPos] := Char(btMade + $3C);
      Inc(nDestPos);
    end
    else
    begin
      if nDestPos < nDestLen - 1 then
      begin
        PDest[nDestPos] := Char(btMade + $3C);
        PDest[nDestPos + 1] := Char(btRest + $3C);
        Inc(nDestPos, 2);
      end
      else
      begin
        PDest[nDestPos] := Char(btMade + $3C);
        Inc(nDestPos);
      end;
      nRestCount := 0;
      btRest := 0;
    end;
  end;
  if nRestCount > 0 then
  begin
    PDest[nDestPos] := Char(btRest + $3C);
    Inc(nDestPos);
  end;
  PDest[nDestPos] := #0;
end;

procedure code_Decode6BitBuf(sSource: PChar; pbuf: PChar; nSrcLen, nBufLen: Integer);  stdcall;
const
  Masks: array[2..6] of byte = ($FC, $F8, $F0, $E0, $C0);
var
  i, nBitPos, nMadeBit, nBufPos: Integer;
  btCh, btTmp, btByte, btXor: byte;
begin
  nBitPos := 2;
  nMadeBit := 0;
  nBufPos := 0;
  btTmp := 0;
  btCh := 0;
  for i := 0 to nSrcLen - 1 do
  begin
    if Integer(sSource[i]) - $3C >= 0 then
      btCh := byte(sSource[i]) - $3C
    else
    begin
      nBufPos := 0;
      break;
    end;
    if nBufPos >= nBufLen then
      break;
    if (nMadeBit + 6) >= 8 then
    begin
      btByte := byte(btTmp or ((btCh and $3F) shr (6 - nBitPos)));

      btXor := BITMASKS;
      Inc(btXor, nBufPos);
      btByte := btByte xor btXor;

      pbuf[nBufPos] := Char(btByte);
      Inc(nBufPos);
      nMadeBit := 0;
      if nBitPos < 6 then
        Inc(nBitPos, 2)
      else
      begin
        nBitPos := 2;
        continue;
      end;
    end;
    btTmp := byte(byte(btCh shl nBitPos) and Masks[nBitPos]);
    Inc(nMadeBit, 8 - nBitPos);
  end;
  pbuf[nBufPos] := #0;
end;

{$IF Public_Ver <> Public_Free}
procedure Decode6BitBuf(sSource: PChar; pbuf: PChar; nSrcLen, nBufLen: Integer);
begin
  if Assigned(DLL_Decode6BitBuf) then begin
    DLL_Decode6BitBuf(sSource, pBuf, nSrcLen, nBufLen);
  end;
end;

procedure Encode6BitBuf(pSrc, PDest: PChar; nSrcLen, nDestLen: Integer);
begin
  if Assigned(DLL_Encode6BitBuf) then begin
    DLL_Encode6BitBuf(pSrc, PDest, nSrcLen, nDestLen);
  end;
end;

{$ELSE}
procedure Decode6BitBuf(sSource: PChar; pbuf: PChar; nSrcLen, nBufLen: Integer); stdcall
const
  Masks: array[2..6] of byte = ($FC, $F8, $F0, $E0, $C0);
var
  i, nBitPos, nMadeBit, nBufPos: Integer;
  btCh, btTmp, btByte, btXor: byte;
begin
  Try
    nBitPos := 2;
    nMadeBit := 0;
    nBufPos := 0;
    btTmp := 0;
    btCh := 0;
    for i := 0 to nSrcLen - 1 do begin
      if Integer(sSource[i]) - $3C >= 0 then
        btCh := byte(sSource[i]) - $3C
      else begin
        nBufPos := 0;
        break;
      end;
      if nBufPos >= nBufLen then
        break;
      if (nMadeBit + 6) >= 8 then begin
        btByte := byte(btTmp or ((btCh and $3F) shr (6 - nBitPos)));

        btXor := BITMASKS;
        Inc(btXor, nBufPos);
        btByte := btByte xor btXor;

        pbuf[nBufPos] := Char(btByte);
        Inc(nBufPos);
        nMadeBit := 0;
        if nBitPos < 6 then
          Inc(nBitPos, 2)
        else begin
          nBitPos := 2;
          continue;
        end;
      end;
      btTmp := byte(byte(btCh shl nBitPos) and Masks[nBitPos]);
      Inc(nMadeBit, 8 - nBitPos);
    end;
    pbuf[nBufPos] := #0;
  Except
  End;
end;

procedure Encode6BitBuf(pSrc, PDest: PChar; nSrcLen, nDestLen: Integer); stdcall
var
  i: Integer;
  nRestCount: Integer;
  nDestPos: Integer;
  btMade: byte;
  btCh: byte;
  btRest: byte;
  btXor: Byte;
begin
  Try
    nRestCount := 0;
    btRest := 0;
    nDestPos := 0;
    for i := 0 to nSrcLen - 1 do begin
      if nDestPos >= nDestLen then
        break;
      btCh := byte(pSrc[i]);

      btXor := BITMASKS;
      Inc(btXor, i);
      btCh := btCh xor btXor;

      btMade := byte((btRest or (btCh shr (2 + nRestCount))) and $3F);
      btRest := byte(((btCh shl (8 - (2 + nRestCount))) shr 2) and $3F);
      Inc(nRestCount, 2);

      if nRestCount < 6 then begin
        PDest[nDestPos] := Char(btMade + $3C);
        Inc(nDestPos);
      end
      else begin
        if nDestPos < nDestLen - 1 then begin
          PDest[nDestPos] := Char(btMade + $3C);
          PDest[nDestPos + 1] := Char(btRest + $3C);
          Inc(nDestPos, 2);
        end
        else begin
          PDest[nDestPos] := Char(btMade + $3C);
          Inc(nDestPos);
        end;
        nRestCount := 0;
        btRest := 0;
      end;
    end;
    if nRestCount > 0 then begin
      PDest[nDestPos] := Char(btRest + $3C);
      Inc(nDestPos);
    end;
    PDest[nDestPos] := #0;
  Except
  End;
end;

{$IFEND}

function DecodeMessage(str: string): TDefaultMessage;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
  Msg: TDefaultMessage;
begin
  Decode6BitBuf(PChar(str), @EncBuf, Length(str), sizeof(EncBuf));
  Move(EncBuf, Msg, sizeof(TDefaultMessage));
  Result := Msg;
end;

function DecodeString(str: string): string;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Decode6BitBuf(PChar(str), @EncBuf, Length(str), sizeof(EncBuf));
  Result := StrPas(EncBuf);
end;

procedure DecodeBuffer(Src: string; Buf: PChar; bufsize: Integer);
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Decode6BitBuf(PChar(Src), @EncBuf, Length(Src), sizeof(EncBuf));
  Move(EncBuf, Buf^, bufsize);
end;

function EncodeMessage(smsg: TDefaultMessage): string;
var
  EncBuf, TempBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Move(smsg, TempBuf, sizeof(TDefaultMessage));
  Encode6BitBuf(@TempBuf, @EncBuf, sizeof(TDefaultMessage), sizeof(EncBuf));
  Result := StrPas(EncBuf);
end;

function EncodeString(str: string): string;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Encode6BitBuf(PChar(str), @EncBuf, Length(str), sizeof(EncBuf));
  Result := StrPas(EncBuf);
end;

function EncodeBuffer(Buf: PChar; bufsize: Integer): string;
var
  EncBuf, TempBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  if bufsize < BUFFERSIZE then
  begin
    //CopyMemory(@TempBuf, Buf, bufsize);
    Move(Buf^, TempBuf, bufsize);
    Encode6BitBuf(@TempBuf, @EncBuf, bufsize, sizeof(EncBuf));
    Result := StrPas(EncBuf);
  end
  else
    Result := '';
end;



procedure DecodeLongBuffer(Src: string; Buf: PChar; bufsize: Integer);
  function GetCodeMsgSize(x: Double): Integer;
  begin
    if INT(x) < x then Result := Trunc(x) + 1
    else Result := Trunc(x);
  end;
var
  MaxLen: Integer;
  TextLen: Integer;
  WhiteLen: Integer;
  CStr: string;
begin
  MaxLen := GetCodeMsgSize(DATABUFFERSIZE * 4 / 3);
  TextLen := Length(Src);
  if TextLen > MaxLen then begin
    WhiteLen := 0;
    while (TextLen >= MaxLen) and (bufsize >= DATABUFFERSIZE) do begin
      CStr := Copy(Src, 1, MaxLen);
      Src := Copy(Src, MaxLen + 1, TextLen);
      Dec(TextLen, MaxLen);
      DecodeBuffer(CStr, @Buf[WhiteLen], DATABUFFERSIZE);
      Inc(WhiteLen, DATABUFFERSIZE);
      Dec(bufsize, DATABUFFERSIZE);
    end;
    if (bufsize > 0) and (TextLen > 0) and (Src <> '') then begin
      DecodeBuffer(Src, @Buf[WhiteLen], bufsize);
    end;
  end else begin
    DecodeBuffer(Src, Buf, BufSize);
  end;
end;

function EncodeLongBuffer(Buf: PChar; bufsize: Integer): string;
var
  WhiteLen: Integer;
begin
  Result := '';
  if bufsize > DATABUFFERSIZE then begin
    WhiteLen := 0;
    while (bufsize > DATABUFFERSIZE) do begin
      Result := Result + EncodeBuffer(@Buf[WhiteLen], DATABUFFERSIZE);
      Inc(WhiteLen, DATABUFFERSIZE);
      Dec(bufsize, DATABUFFERSIZE);
    end;
    if bufsize > 0 then
      Result := Result + EncodeBuffer(@Buf[WhiteLen], bufsize);
  end else begin
    Result := EncodeBuffer(Buf, bufsize);
  end;
end;

initialization
  begin
    DLL_Decode6BitBuf := @code_Decode6BitBuf;
    DLL_Encode6BitBuf := @code_Encode6BitBuf;
  end;

finalization
  begin
  end;
end.
