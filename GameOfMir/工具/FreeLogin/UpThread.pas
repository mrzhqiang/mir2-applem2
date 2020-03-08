unit UpThread;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, Share, UrlMon,
  Dialogs, IEDCode, IdHTTP, LShare, JSocket, LAShare, DFUnRar, ImageHlp, IdCompressorZLibEx;

type
  TUpdateThread = class(TThread)
  private
    FClientSocket: TClientSocket;
    FHTTP: TIdHTTP;
    FIdCompressorZLibEx: TIdCompressorZLibEx;
    FMainFormHandle: THandle;
    FUnRar: TDFUnRar;
    FUnRarError: Boolean;
    FProgressTick: LongWord;
  protected
    procedure Execute; override;
    function HTTPGet(sUrl: string): string;
    procedure GetServerList;
    procedure ShowHintMsg(sSendMsg: string);
    procedure Update;
    //function GetUrlText(sUrl: string): string;
    procedure ChangePercent(Percent: TPPercent; boAll: Boolean);
    function UpDataByInfo(UpDataInfo: PTUpDataInfo): Boolean;
    function BaiduUpDataByInfo(UpDataInfo: PTUpDataInfo; const DownFileList: TStringList): Boolean;
    function NormalUpDataByInfo(UpDataInfo: PTUpDataInfo; sDownPath, sUrlHost, sHost: string; wPort: Word): Boolean;
    procedure UnRarDataProgress(Sender: TObject; SizeProcessed, SizeCount: Int64);
    procedure UnRarOverride(Sender: TObject; FileName: string; var OverRide: Boolean);
    procedure UnRarError(Sender: TObject; Message: string; MessageID: Integer);
    function ProcessingHead(sHeadStr: string; var nCode, nSize: Integer): Boolean;
    function ProcessingDownFile(sDownFileName: string; UpDataInfo: PTUpDataInfo): Boolean;
    function FormatSizeStr(nMinSize, nMaxSize: Integer): string;
  public
    constructor Create(Handle: THandle; CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure ProgressEvent(aPercent: Integer);
  end;

var
  UpdateThread: TUpdateThread;

implementation

uses Hutil32, MD5Unit;

function TUpdateThread.NormalUpDataByInfo(UpDataInfo: PTUpDataInfo; sDownPath, sUrlHost, sHost: string; wPort: Word): Boolean;
const
  ReadSize = 8193;
  SaveSize = 512 * 1024;
var
  FileStream: TFileStream;
  sFileName, sSendMsg: string;
  ReadBuffer, SaveBuffer: PChar;
  nReadSize, nFileNowSize: Integer;
  boReadHead: Boolean;
  sHeadStr, sStr: string;
  nPos, nLen: Integer;
  nFileSize, nCode, nSaveSize: Integer;
//  dwTick: LongWord;
Label
  RefDown;
begin
  Result := False; //http://hiphotos.baidu.com
  sFileName := g_UpDataDir + UpDataInfo.sID + DOWNFILEEXT;
  if FileExists(sFileName) then
    FileStream := TFileStream.Create(sFileName, fmOpenReadWrite or fmShareDenyWrite)
  else
    FileStream := TFileStream.Create(sFileName, fmCreate);
  GetMem(ReadBuffer, ReadSize);
  GetMem(SaveBuffer, SaveSize);
  try
    nFileNowSize := FileStream.Size;
    FileStream.Seek(nFileNowSize, 0);
  RefDown:
    FClientSocket.Close;
    FClientSocket.Host := sHost;
    FClientSocket.Port := wPort;
    try
      FClientSocket.Open;
    Except
      ShowHintMsg('连接更新服务器失败！');
      Exit;
    end;
//    dwTick := GetTickCount;
    sSendMsg := 'GET ' + sDownPath + ' HTTP/1.1' + #13#10;
    sSendMsg := sSendMsg + 'Accept: */*' + #13#10;
    if nFileNowSize > 0 then
      sSendMsg := sSendMsg + 'Range: bytes=' + IntToStr(nFileNowSize) + '-'#13#10;
    sSendMsg := sSendMsg + 'Accept-Language: zh-cn' + #13#10;
    sSendMsg := sSendMsg + 'Accept-Encoding: gzip, deflate' + #13#10;
    sSendMsg := sSendMsg + 'Host: ' + sUrlHost + #13#10;
    sSendMsg := sSendMsg + 'Connection: close' + #13#10;
    sSendMsg := sSendMsg + #13#10;
    FClientSocket.Socket.SendText(sSendMsg);
    boReadHead := False;
    sHeadStr := '';
    nSaveSize := 0;
    while FClientSocket.Active do begin
      if not boReadHead then ZeroMemory(ReadBuffer, ReadSize);
      nReadSize := FClientSocket.Socket.ReceiveBuf(ReadBuffer^, ReadSize - 1);
      if nReadSize > 0 then begin
        if not boReadHead then begin
          sStr := Strpas(ReadBuffer);
          nPos := Pos(#13#10#13#10, sStr);
          if nPos > 0 then begin
            sStr := Copy(sStr, 1, nPos + 3);
            sHeadStr := sHeadStr + sStr;
            nLen := Length(sStr);
            boReadHead := True;
            if ProcessingHead(sHeadStr, nCode, nFileSize) then begin
              if nFileNowSize > 0 then begin
                if (nCode <> 206) then begin
                  nFileNowSize := 0;
                  FileStream.Seek(0, 0);
                  FClientSocket.Close;
                  GOTO RefDown;
                end;
              end else begin
                if (nCode <> 200) then begin
                  ShowHintMsg('读取数据出错. code ' + IntToStr(nCode));
                  Exit;
                end;
              end;
            end else begin
              if nFileNowSize > 0 then begin
                nFileNowSize := 0;
                FileStream.Seek(0, 0);
                FClientSocket.Close;
                GOTO RefDown;
              end else begin
                ShowHintMsg('读取数据出错. code ' + IntToStr(nCode) + ' size ' + IntToStr(nFileSize));
                Exit;
              end;
            end;
            if nLen < nReadSize then begin
              nSaveSize := nReadSize - nLen;
              Move(ReadBuffer[nLen], SaveBuffer^, nSaveSize);
            end;
          end
          else
            sHeadStr := sHeadStr + sStr;
        end
        else begin
          if (nSaveSize + nReadSize) >= SaveSize then begin
            FileStream.Write(SaveBuffer^, nSaveSize);
            Inc(nFileNowSize, nSaveSize);
            nSaveSize := 0;
          end;
          Move(ReadBuffer^, SaveBuffer[nSaveSize], nReadSize);
          Inc(nSaveSize, nReadSize);
          ChangePercent(Round((nFileNowSize + nSaveSize) / nFileSize * 100), False);
        end;
      end
      else begin
        if nSaveSize > 0 then begin
          FileStream.Write(SaveBuffer^, nSaveSize);
          Inc(nFileNowSize, nSaveSize);
        end;
        if (nFileNowSize = nFileSize) then begin
          Result := True;
          Break;
        end
        else begin
          ShowHintMsg('与更新服务器断开连接. code 101');
          Exit;
        end;
      end;
    end;
  finally
    FreeMem(ReadBuffer);
    FreeMem(SaveBuffer);
    FileStream.Free;
    FClientSocket.Close;
  end;
  if Result then
    Result := ProcessingDownFile(sFileName, UpDataInfo);
end;

function TUpdateThread.BaiduUpDataByInfo(UpDataInfo: PTUpDataInfo; const DownFileList: TStringList): Boolean;
const
  ReadSize = 8193;
var
  FileStream: TFileStream;
  sFileName, sSendMsg: string;
  I, nI: Integer;
  ReadBuffer, SaveBuffer: PChar;
  nReadSize, nSaveSize, nFileMaxSize, nDataSize, nFileNowSize: Integer;
  boReadHead, boReadMaxSize: Boolean;
  sHeadStr, sStr: string;
  nPos, nLen: Integer;
  nFileSize, nCode: Integer;
  dwTick: LongWord;
begin
  Result := False; //http://hiphotos.baidu.com
  sFileName := g_UpDataDir + UpDataInfo.sID + DOWNFILEEXT;
  if FileExists(sFileName) then
    FileStream := TFileStream.Create(sFileName, fmOpenReadWrite or fmShareDenyWrite)
  else
    FileStream := TFileStream.Create(sFileName, fmCreate);
  GetMem(ReadBuffer, ReadSize);
  GetMem(SaveBuffer, BMP_MAX_SIZE);
  try
    nI := 0;
    dwTick := 0;
    if (FileStream.Size mod BMP_PART_SIZE) = 0 then begin
      FileStream.Seek(FileStream.Size, 0);
      nI := FileStream.Size div BMP_PART_SIZE;
      if nI >= DownFileList.Count then
        Exit;
      nFileNowSize := FileStream.Size;
    end
    else
      nFileNowSize := 0;

    nFileMaxSize := 0;
    for I := nI to DownFileList.Count - 1 do begin
      FClientSocket.Close;
      FClientSocket.Host := 'hiphotos.baidu.com';
      FClientSocket.Port := 80;
      try
        FClientSocket.Open;
      Except
        ShowHintMsg('连接更新服务器失败！');
        Exit;
      end;
      sSendMsg := 'GET ' + DownFileList[I] + ' HTTP/1.1' + #13#10;
      sSendMsg := sSendMsg + 'Accept: */*' + #13#10;
      sSendMsg := sSendMsg + 'Accept-Language: zh-cn' + #13#10;
      sSendMsg := sSendMsg + 'Accept-Encoding: gzip, deflate' + #13#10;
      sSendMsg := sSendMsg + 'Host: hiphotos.baidu.com' + #13#10;
      sSendMsg := sSendMsg + 'Connection: close' + #13#10;
      sSendMsg := sSendMsg + #13#10;
      FClientSocket.Socket.SendText(sSendMsg);
      boReadHead := False;
      sHeadStr := '';
      boReadMaxSize := False;
      nDataSize := 0;
      nSaveSize := 0;
      while FClientSocket.Active do begin
        if not boReadHead then ZeroMemory(ReadBuffer, ReadSize);
        nReadSize := FClientSocket.Socket.ReceiveBuf(ReadBuffer^, ReadSize - 1);
        if nReadSize > 0 then begin
          if not boReadHead then begin
            sStr := Strpas(ReadBuffer);
            nPos := Pos(#13#10#13#10, sStr);
            if nPos > 0 then begin
              sStr := Copy(sStr, 1, nPos + 3);
              sHeadStr := sHeadStr + sStr;
              nLen := Length(sStr);
              if nLen < nReadSize then begin
                Move(ReadBuffer[nLen], SaveBuffer^, nReadSize - nLen);
                Inc(nSaveSize, nReadSize - nLen);
              end;
              boReadHead := True;
              if (not ProcessingHead(sHeadStr, nCode, nFileSize)) or (nCode <> 200) or (nFileSize <= 0) then begin
                ShowHintMsg('读取数据出错. code ' + IntToStr(nCode) + ' size ' + IntToStr(nFileSize));
                Exit;
              end;
            end
            else
              sHeadStr := sHeadStr + sStr;
          end
          else begin
            if nSaveSize + nReadSize <= BMP_MAX_SIZE then begin
              Move(ReadBuffer^, SaveBuffer[nSaveSize], nReadSize);
              Inc(nSaveSize, nReadSize);
            end;
          end;
          if (not boReadMaxSize) and (nSaveSize >= $3E) then begin
            nFileMaxSize := PInteger(Integer(SaveBuffer) + $36)^;
            nDataSize := PInteger(Integer(SaveBuffer) + $3A)^;
            boReadMaxSize := True;
            ChangePercent(Round((nSaveSize - $3E + nFileNowSize) / nFileMaxSize * 100), False);
            ShowHintMsg('正在下载 ' + UpDataInfo.sHint{ + ' ' + FormatSizeStr((nSaveSize - $3E + nFileNowSize), nFileMaxSize)});
          end;
          if boReadMaxSize then begin
            if GetTickCount > dwTick then begin
              dwTick := GetTickCount + 500;
              ChangePercent(Round((nSaveSize - $3E + nFileNowSize) / nFileMaxSize * 100), False);
              ShowHintMsg('正在下载 ' + UpDataInfo.sHint{ + ' ' + FormatSizeStr((nSaveSize - $3E + nFileNowSize), nFileMaxSize)});
            end;
          end;
          if (nSaveSize >= BMP_MAX_SIZE) then
            break;
        end
        else begin
          if ((nFileNowSize + nDataSize) = nFileMaxSize) and (nSaveSize = nFileSize) then begin
            Result := True;
            ChangePercent(100, False);
            ShowHintMsg('正在下载 ' + UpDataInfo.sHint{ + ' ' + FormatSizeStr(nFileMaxSize, nFileMaxSize)});
            Break;
          end
          else begin
            ShowHintMsg('与更新服务器断开连接. code 101');
            Exit;
          end;
        end;
      end;
      if nDataSize > 0 then begin
        FileStream.Write(SaveBuffer[$3E], nDataSize);
        Inc(nFileNowSize, nDataSize);
      end;
    end;
  finally
    FreeMem(SaveBuffer);
    FreeMem(ReadBuffer);
    FileStream.Free;
    FClientSocket.Close;
  end;
  if Result then
    Result := ProcessingDownFile(sFileName, UpDataInfo);
end;

procedure TUpdateThread.ChangePercent(Percent: TPPercent; boAll: Boolean);
begin
  SendMessage(FMainFormHandle, WM_CHANGEPERCENT, Percent, Integer(boAll));
end;

constructor TUpdateThread.Create(Handle: THandle; CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FMainFormHandle := Handle;
  FClientSocket := TClientSocket.Create(nil);
  FClientSocket.ClientType := ctBlocking;
  FClientSocket.Tag := 0;
  FHTTP := TIDHTTP.Create(nil);
  FIdCompressorZLibEx := TIdCompressorZLibEx.Create(nil);
  FHTTP.Compressor := FIdCompressorZLibEx;
  FHTTP.HandleRedirects:= True;
  FUnRar := TDFUnRar.Create(nil);
  FUnRar.CanProgress := True;
  FUnRar.Mode := DFRAR_EXTRACT;
  FUnRar.OverrideEvent := OR_ALWAYS;
  FUnRar.Tag := 0;
  FUnRar.FileList.Clear;
  FUnRar.OnDataProgress := UnRarDataProgress;
  FUnRar.OnOverride := UnRarOverride;
  FUnRar.OnError := UnRarError;
  FProgressTick := GetTickCount;
//  g_ListName := IDeCodeString(Trim(g_ListName));
  g_ListName := Trim(g_ListName);
end;

destructor TUpdateThread.Destroy;
begin
  FIdCompressorZLibEx.Free;
  FClientSocket.Free;
  FHTTP.Free;
  FUnRar.Free;
  inherited;
end;

procedure TUpdateThread.Execute;
begin
  try
    GetServerList;
  except
  end;
  try
    Update;
  except
  end;
  PostMessage(FMainFormHandle, WM_MYREAD_OK, 0, 0);
end;

function TUpdateThread.FormatSizeStr(nMinSize, nMaxSize: Integer): string;
begin
  if nMaxSize > 999 * 1024 then begin
    Result := Format('(%.2fM/%.2fM)', [nMinSize / 1024 / 1024, nMaxSize / 1024 / 1024]);
  end else begin
    Result := Format('(%.2fK/%.2fK)', [nMinSize / 1024, nMaxSize / 1024]);
  end;
end;

procedure TUpdateThread.GetServerList;
var
  sUrlData: string;
  nPos: Integer;
  List: TStringList;
begin
  List := TStringList.Create;
  try
    sUrlData := HTTPGet('http://small.randall.top:8081/ServerInfo.txt');
    //http://hi.baidu.com/mir2k_1001/home
    //sUrlData := HtmlToText(HTTPGet(DecryptStr('bp=BL=+YrTXE0sIiMKemHuvTlP4bJhJBPlplBY9qP1TxvxabTia')));

//    if CompareText(LeftStr(g_ListName, 24), 'http://small.randall.top:8081') = 0 then begin
      {sUrlData := HtmlToText(HTTPGet(g_ListName));
      nPos := Pos('$BEGIN', sUrlData);
      if nPos > 0 then begin
        sUrlData := Copy(sUrlData, nPos + 6, Length(sUrlData));
        nPos := Pos('$END', sUrlData);
        if nPos > 0 then begin
          sUrlData := Copy(sUrlData, 1, nPos - 1);
          List.SetText(PChar(Trim(sUrlData)));
          List.SaveToFile(g_SaveFileName);
        end;
      end;}
//    end else begin
//      sUrlData := HTTPGet(g_ListName);
      {nPos := Pos('XMLSetup', sUrlData);
      if nPos > 0 then begin
        List.SetText(PChar(Trim(sUrlData)));
        List.SaveToFile(g_SaveFileName);
      end; }
//    end;
    nPos := Pos('$BEGIN', sUrlData);
    if nPos > 0 then begin
      sUrlData := Copy(sUrlData, nPos + 6, Length(sUrlData));
      nPos := Pos('$END', sUrlData);
      if nPos > 0 then begin
        sUrlData := Copy(sUrlData, 1, nPos - 1);
        List.SetText(PChar(Trim(sUrlData)));
        List.SaveToFile(g_SaveFileName);
      end;
    end;
  finally
    List.Free;
    SendMessage(FMainFormHandle, WM_DISPOSALXML, 0, 0);
  end;
end;

function TUpdateThread.HTTPGet(sUrl: string): string;
begin
  Try
    Result := FHttp.Get(sUrl);
  Except
    Result := '';
  End;
end;

(*
function TUpdateThread.GetUrlText(sUrl: string): string;
var
  InStream, OutStream: TMemoryStream;
  StrList: TStringList;
begin
  //Result := '';
  {if FHttp.Connected = true then begin
    FHttp.Disconnect;
    while FHttp.Connected do
      Application.ProcessMessages;
  end;   }
  InStream := TMemoryStream.Create;
  OutStream := TMemoryStream.Create;
  StrList := TStringList.Create;
  Try
    HTTPGet(sUrl, InStream);
    InStream.Position := 0;
    {if CompareText(FHttp.Response.ContentEncoding, 'gzip') = 0 then begin
      FHttp.Compressor.DecompressGZipStream(InStream, OutStream);
      OutStream.Position := 0;
      StrList.LoadFromStream(OutStream);
    end else
    if CompareText(FHttp.Response.ContentEncoding, 'deflate') = 0 then begin
      FHttp.Compressor.DecompressHTTPDeflate(InStream, OutStream);
      OutStream.Position := 0;
      StrList.LoadFromStream(OutStream);
    end else  }
      StrList.LoadFromStream(InStream);

    Result := HtmlToText(StrList.Text);
  Finally
    InStream.Free;
    OutStream.Free;
    StrList.Free;
    FHttp.Disconnect;
  End;
  //InStream, OutStream
  //sUrlData := HtmlToText(HTTPGet(sUrl));
    //List.add(HtmlToText(HTTPGet(sUrl)));
end;
              *)
function TUpdateThread.ProcessingDownFile(sDownFileName: string; UpDataInfo: PTUpDataInfo): Boolean;
  function UnRarFile(sSaveDir: string): Boolean;
  begin
    Result := False;
    Try
      FUnRarError := False;
      ShowHintMsg('正在解压 ' + UpDataInfo.sHint);
      with FUnRar do begin
        FileList.Clear;
        FileName := sDownFileName;
        Directory := sSaveDir;
        Extract;
        Result := not FUnRarError;
      end;
    Except
    End;
  end;

  function CopyFileToDir(sFileName: string): Boolean;
  var
    sPath: string;
  begin
    sPath := ExtractFilePath(sFileName);
    MakeSureDirectoryPathExists(PChar(sPath));
    Result := CopyFile(PChar(sDownFileName), PChar(sFileName), False);
  end;
var
  Buffer: PChar;
begin
  Result := True;
  ShowHintMsg('正在验证 ' + UpDataInfo.sHint);
  ChangePercent(0, False);
  if CompareText(MD5Print(GetMD5OfFile(sDownFileName, ProgressEvent)), UpDataInfo.sID) <> 0 then begin
    ShowHintMsg('验证 ' + UpDataInfo.sHint + ' 失败...');
    Result := False;
    Exit;
  end;
  case UpDataInfo.CheckType of
    dct_var: begin

      end;
    dct_exists: begin
        if UpDataInfo.boZip then begin
          Result := UnRarFile(UpDataInfo.sSaveDir);
          if not Result then
            ShowHintMsg('解压缩 ' + UpDataInfo.sHint + ' 错误！');
        end else begin
          if not CopyFileToDir(UpDataInfo.sSaveDir + UpDataInfo.sFileName) then begin
            Result := False;
            ShowHintMsg('替换 ' + UpDataInfo.sHint + ' 失败！');
          end;
        end;
      end;
    dct_pack: begin

      end;
    dct_md5: begin
        if CompareText(UpDataInfo.sFileName, 'SELF') = 0 then begin
          GetMem(Buffer, Length(sDownFileName) + 1);
          Move(sDownFileName[1], Buffer^, Length(sDownFileName) + 1);
          SendMessage(FMainFormHandle, WM_SELFCHANGE, 0, Cardinal(Buffer));
          FreeMem(Buffer);
          Result := False;
        end else begin
          if UpDataInfo.boZip then begin
            Result := UnRarFile(UpDataInfo.sSaveDir);
            if not Result then
              ShowHintMsg('解压缩 ' + UpDataInfo.sHint + ' 错误！');
          end else
          if not CopyFileToDir(UpDataInfo.sSaveDir + UpDataInfo.sFileName) then begin
            Result := False;
            ShowHintMsg('替换 ' + UpDataInfo.sHint + ' 失败！');
          end;
        end;
      end;
  end;
  DeleteFile(PChar(sDownFileName));
end;

function TUpdateThread.ProcessingHead(sHeadStr: string; var nCode, nSize: Integer): Boolean;
var
  sStr, sTemp: string;
begin
  Result := False;
  nCode := 0;
  nSize := 0;
  while (sHeadStr <> '') do begin
    sHeadStr := GetValidStr3(sHeadStr, sStr, [#13, #10]);
    if sStr = '' then
      break;
    if CompareLStr(sStr, 'HTTP/', Length('HTTP/')) then begin
      ArrestStringEx(sStr, ' ', ' ', sStr);
      nCode := StrToIntDef(sStr, 0);
    end
    else if CompareLStr(sStr, 'Content-Length:', Length('Content-Length:')) then begin
      sStr := GetValidStr3(sStr, sTemp, [' ']);
      nSize := StrToIntDef(sStr, 0);
    end
    else if CompareLStr(sStr, 'Content-Range:', Length('Content-Range:')) then begin
      sStr := GetValidStr3(sStr, sTemp, ['/']);
      nSize := StrToIntDef(sStr, 0);
      break;
    end;
  end;
  if (nCode > 0) and (nSize > 0) then
    Result := True;
end;

procedure TUpdateThread.ProgressEvent(aPercent: Integer);
begin
  if aPercent < 100 then begin
    if GetTickCount > FProgressTick then begin
      FProgressTick := GetTickCount + 100;
      ChangePercent(aPercent, False);
    end;
  end else
    ChangePercent(aPercent, False);
end;

procedure TUpdateThread.ShowHintMsg(sSendMsg: string);
var
  SendData: TCopyDataStruct;
begin
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(FMainFormHandle, WM_COPYDATA, COPYMSG_LOGIN_HINTMSG, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

procedure TUpdateThread.UnRarDataProgress(Sender: TObject; SizeProcessed, SizeCount: Int64);
begin
  ChangePercent(Round(SizeProcessed / SizeCount * 100), False);
end;

procedure TUpdateThread.UnRarError(Sender: TObject; Message: string; MessageID: Integer);
begin
  FUnRarError := True;
end;

procedure TUpdateThread.UnRarOverride(Sender: TObject; FileName: string; var OverRide: Boolean);
begin
  FUnRar.OverrideEvent := OR_ALWAYS;
end;

function TUpdateThread.UpDataByInfo(UpDataInfo: PTUpDataInfo): Boolean;
  function DisposalDownUrl(var NameList, UrlList, DownList: TStringList): Boolean;
  var
    sStr, sTemp: string;
    I, nIndex, k: Integer;
  begin
    for I := 0 to NameList.Count - 1 do begin
      sStr := NameList[I];
      sStr := GetValidStr3(sStr, sTemp, ['_']);
      GetValidStr3(sStr, sTemp, ['.']);
      nIndex := StrToIntDef(sTemp, 0);
      if (nIndex > 0) and (nIndex < 999) then begin
        for k := DownList.Count to nIndex - 1 do
          DownList.Add(' ');
        DownList[nIndex - 1] := UrlList[I];
      end;
    end;
    Result := DownList.Count = NameList.Count;
  end;
var
  sHtmlStr, sID, sName, sUserID, sDownUrl, sDownPath, sUrlHost, sHost, sPort: string;
  BmpDownList, NameList, UrlList: TStringList;
  nPos, nIndex: Integer;
  wPort: Word;
Label
  ReDown;
begin
  Result := False;
  if UpDataInfo.boBaiduDown then begin
    BmpDownList := TStringList.Create;
    NameList := TStringList.Create;
    UrlList := TStringList.Create;
    nIndex := 0;
    try
      ReDown:              ///mir2k_updata/album/Audio/index/1
      if nIndex > 0 then sHtmlStr := HTTPGet(UpDataInfo.sDownUrl + '/index/' + IntToStr(nIndex))
      else sHtmlStr := HTTPGet(UpDataInfo.sDownUrl);
      nPos := Pos('baidu.com/', UpDataInfo.sDownUrl);
      if nPos > 0 then begin
        sUserID := Copy(UpDataInfo.sDownUrl, nPos + 10, Length(UpDataInfo.sDownUrl));
        GetValidStr3(sUserID, sUserID, ['/']);
        if sUserID <> '' then begin
          while True do begin
            nPos := Pos('pname:"', sHtmlStr);
            if nPos <= 0 then break;
            sHtmlStr := Copy(sHtmlStr, nPos, Length(sHtmlStr) - nPos);
            sHtmlStr := ArrestStringEx(sHtmlStr, '"', '"', sName);
            if sName = '' then break;
            nPos := Pos('pid:"', sHtmlStr);
            if nPos <= 0 then break;
            sHtmlStr := Copy(sHtmlStr, nPos, Length(sHtmlStr) - nPos);
            sHtmlStr := ArrestStringEx(sHtmlStr, '"', '"', sID);
            if sID = '' then break;
            NameList.Add(sName);
            UrlList.Add('/' + sUserID + '/pic/item/' + sID + '.jpg');
          end;
          if Pos('下一页', sHtmlStr) > 0 then begin
            Inc(nIndex);
            GOTO ReDown;
          end;
          if DisposalDownUrl(NameList, UrlList, BmpDownList) and (BmpDownList.Count > 0) then begin
            Result := BaiduUpDataByInfo(UpDataInfo, BmpDownList);
            Exit;
          end;
        end;
      end;
      ShowHintMsg('下载文件数据出错. code 100');
    finally
      BmpDownList.Free;
      NameList.Free;
      UrlList.Free;
    end;
  end
  else begin
    sDownUrl := UpDataInfo.sDownUrl;
    if CompareLStr(sDownUrl, 'HTTP://', Length('HTTP://')) then begin
      sDownUrl := Copy(sDownUrl, 8, Length(sDownUrl));
      sDownPath := '/' + GetValidStr3(sDownUrl, sUrlHost, ['/', '\']);
      if (sUrlHost <> '') and (sDownPath <> '') then begin
        if Pos(':', sUrlHost) > 0 then begin
          sPort := GetValidStr3(sUrlHost, sHost, [':']);
          wPort := StrToIntDef(sPort, 0);
        end else begin
          sHost := sUrlHost;
          wPort := 80;
        end;
        Result := NormalUpDataByInfo(UpDataInfo, sDownPath, sUrlHost, sHost, wPort);
        Exit;
      end;
    end;
    ShowHintMsg('下载地址错误. code 102');
  end;
end;

procedure TUpdateThread.Update;
var
  i: Integer;
  UpDataInfo: PTUpDataInfo;
  boUp: Boolean;
  sFileName, sMD5, sMD52, sFileMD5: string;
begin
  //URLDownloadToFile(nil, PChar(g_LogoImage), PChar('.\Resource\Logo\' + g_MapName + '.png'), 0, nil);
  //SendMessage(FMainFormHandle, WM_WRITELOGO, 0, 0);
  if g_DownList.Count > 0 then begin
    CreateDir(g_UpDataDir);
    //CreateDir(UPDATADIR + MAPNAME + '\');
    if g_DownList.Count < 100 then begin
      ChangePercent(100 - g_DownList.Count, True);
    end else begin
      ChangePercent(0, True);
    end;
    ChangePercent(0, False);
    for I := 0 to g_DownList.Count - 1 do begin
      UpDataInfo := g_DownList[I];
      boUP := False;
      case UpDataInfo.CheckType of
        dct_var: begin

          end;
        dct_exists: begin
            if not FileExists(UpDataInfo.sSaveDir + UpDataInfo.sFileName) then
              boUp := True;
          end;
        dct_pack: begin

          end;
        dct_md5: begin
            if CompareText(UpDataInfo.sFileName, 'SELF') = 0 then sFileName := g_SelfName
            else sFileName := UpDataInfo.sSaveDir + UpDataInfo.sFileName;
            ShowHintMsg('正在效验 ' + UpDataInfo.sHint);
            sMD5 := UpDataInfo.sMD5;
            boUp := True;
            sFileMD5 := MD5Print(GetMD5OfFile(sFileName, ProgressEvent));
            while True do begin
              sMD5 := GetValidStr3(sMD5, sMD52, [';']);
              if sMD52 = '' then break;
              if CompareText(sFileMD5, sMD52) = 0 then begin
                boUp := False;
                Break;
              end;
            end;
          end;
      end;
      if boUP then begin
        ShowHintMsg('正在更新 ' + UpDataInfo.sHint);
        ChangePercent(0, False);
        if not UpDataByInfo(UpDataInfo) then begin
          Exit;
        end;
      end;
      if g_DownList.Count < 100 then begin
        ChangePercent(100 - g_DownList.Count + I + 1, True);
      end else begin
        ChangePercent(Round((I + 1) / g_DownList.Count * 100), True);
      end;
    end;
  end
  else begin
    ChangePercent(100, True);
    ChangePercent(100, False);
  end;
  ChangePercent(100, False);
  ShowHintMsg('您现在可以进入游戏了！');
end;
end.

