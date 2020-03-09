unit FrmMain;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, Share, ZLIB, DES, MD5Unit,  
  Dialogs, ExtCtrls, EzRgnBtn, OleCtrls, SHDocVw, ComCtrls, RzStatus, RzLabel, IEDCode, MyCommon,{, PNGImage,}
  XMLDoc, XMLIntf, LShare, LAShare, xmldom, msxmldom, StdCtrls, JSocket, WebBrowserWithUI, GraphicEx, jpeg;

type

  pTMapDataInfo = ^TMapDataInfo;
  TMapDataInfo = packed record
    Handle: THandle;
  end;

  TFormMain = class(TForm)
    ImageBg: TImage;
    BtnMin: TEzRgnBtn;
    BtnClose: TEzRgnBtn;
    TreeViewServer: TTreeView;
    LabelLog: TRzLabel;
    ProgressNow: TRzProgressStatus;
    BtnUpdating: TEzRgnBtn;
    BtnPlay: TEzRgnBtn;
    BtnSetup: TEzRgnBtn;
    BtnExit: TEzRgnBtn;
    LabelNow: TRzLabel;
    LabelAll: TRzLabel;
    ProgressAll: TRzProgressStatus;
    tmrStart: TTimer;
    xmldSetup: TXMLDocument;
    tmrCheck: TTimer;
    WebBrowser: TWebBrowserWithUI;
    EzRgnBtn1: TEzRgnBtn;
    EzRgnBtn2: TEzRgnBtn;
    EzRgnBtn3: TEzRgnBtn;
    EzRgnBtn4: TEzRgnBtn;
    RzLabel1: TRzLabel;
    DeleteTimer: TTimer;
    JianXiaCheckBox: TCheckBox;
    procedure ImageBgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BtnMinClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSetupClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TreeViewServerCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure tmrStartTimer(Sender: TObject);
    procedure TreeViewServerChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewServerChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure BtnUpdatingClick(Sender: TObject);
    procedure BtnPlayClick(Sender: TObject);
    procedure tmrCheckTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure WebBrowserDownloadBegin(Sender: TObject);
    procedure WebBrowserNavigateComplete2(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure EzRgnBtn1Click(Sender: TObject);
    procedure EzRgnBtn2Click(Sender: TObject);
    procedure EzRgnBtn4Click(Sender: TObject);
    procedure EzRgnBtn3Click(Sender: TObject);
    procedure DeleteTimerTimer(Sender: TObject);
    procedure JianXiaCheckBoxClick(Sender: TObject);
  private
    FMapHandle: THandle;
    FMapDataInfo: pTMapDataInfo;
    FboLoad: Boolean;
    SelectServerInfo: pTLServerInfo;
    FClientList: array of THandle;
    FboHide: Boolean;
    FCheckIndex: Integer;
    FCheckCount: Integer;
    FboFrist: Boolean;
    FDeleteFile: string;
    bJianXia : Boolean;
    function CheckIsRun(): THandle;
    procedure CloseMapInfo();
    procedure CreateMapInfo();
    procedure CreateClientSocket(sAddrs: string; wPort: Word; nIndex: Integer);
    function GetCheckIndex: Integer;
    //procedure InitSetup(SkinInfo: pTLoginSkinInfo; Buffer: PChar);
//    function LoadPNGtoBMP(Stream: TStream; var Bmp: TBitmap): Boolean;
  public

    procedure MyRest(var Message: TMessage); message WM_REST;
    procedure ShowHintMsg(sMsg: string);
    procedure ChangePercent(Percent: TPPercent; boAll: Boolean);
    procedure MyException(Sender: TObject; E: Exception);
    procedure MyDisposalXML(var Msg: TMessage); message WM_DISPOSALXML;
    procedure MyChangePercent(var Msg: TMessage); message WM_CHANGEPERCENT;
    procedure MyReadOK(var Msg: TMessage); message WM_MYREAD_OK;
    procedure MySelfChange(var Msg: TMessage); message WM_SELFCHANGE;
    procedure MyCopyDataMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
    procedure MyGetServerList(var Msg: TMessage); message WM_GETSERVERLIST;
    procedure MyCheckClient(var Msg: TMessage); message WM_CHECK_CLIENT;
//    procedure MyWriteLogo(var Msg: TMessage); message WM_WRITELOGO;
    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
  end;

  //  procedure GetServerListThread(lpParameter: Pointer); stdcall;

var
  FormMain: TFormMain;
  boAllReadOK: Boolean;

implementation

uses FrmSetup, UpThread, ShellAPI, FrmFindClient, Hutil32, FrmRegID, FrmChangePass, FrmLostPass;

{$R *.dfm}
{$R Data.RES}

procedure TFormMain.BtnMinClick(Sender: TObject);
begin
  SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;

procedure TFormMain.BtnPlayClick(Sender: TObject);
var
  I, nCount: Integer;
  Res: TResourceStream;
  cName: string;
  reName: string;
begin
  if SelectServerInfo <> nil then begin
    //if FileExists(g_ClientName) then begin
      if CheckMirDir(g_SelfPath, True) then begin
        nCount := 0;
        for I := Low(FClientList) to High(FClientList) do begin
          if FClientList[I] = 0 then begin
            Inc(nCount);
          end;
        end;
        if nCount > 0 then begin
          cName := g_ClientName;
          reName := 'mir2Data2';
          if bJianXia then
          begin
            cName := g_CurrentDir + 'jx-' + g_TitleName + '.dat';
            reName := 'mir2Data'
          end;
          if (not FileExists(cName)) or (nCount = 0) then
          begin
            Res := TResourceStream.Create(Hinstance, reName, 'Data');
            try
              Res.SaveToFile(cName);
            finally
              Res.Free;
            end;
          end;
//          Hide;
//          FboHide := True;
          //if g_boSQL then WinExec(PChar(g_ClientName + ' ' + IntToStr(Handle) + ' 1'), SW_SHOW)
          //else
          WinExec(PChar(cName + ' ' + IntToStr(Handle) + ' 0'), SW_SHOW);
        end else
          Application.MessageBox(PChar('最多只能同时运行' + IntToStr(Length(FClientList)) + '个游戏客户端！'), '提示信息', MB_OK + MB_ICONSTOP);
      end else
        Application.MessageBox('缺少必要的补丁文件！', '提示信息', MB_OK + MB_ICONSTOP);
    //end else
      //Application.MessageBox('进入游戏失败，客户端文件丢失！', '提示信息', MB_OK + MB_ICONSTOP);
  end;
end;

procedure TFormMain.BtnSetupClick(Sender: TObject);
begin
  FormSetup := TFormSetup.Create(Self);
  FormSetup.Open;
  FreeAndNil(FormSetup);
end;

procedure TFormMain.BtnUpdatingClick(Sender: TObject);
begin
  {if g_boSQL then begin
    if g_PayUrl <> ''  then begin
      SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
      ShellExecute(Handle, 'Open', PChar(g_RegUrl), '', '', SW_SHOW);
    end;
  end else begin    }
    if SelectServerInfo <> nil then begin
      if SelectServerInfo.boCheck then begin
        FormReg := TFormReg.Create(Owner);
        FormReg.Open(SelectServerInfo.CAddr, SelectServerInfo.CPort);
        FormReg.Free;
        FormReg := nil;
      end else
        Application.MessageBox('服务器维护中！', '提示信息', MB_OK + MB_ICONINFORMATION);
    end else
      Application.MessageBox('请先选择服务器！', '提示信息', MB_OK + MB_ICONINFORMATION);
  //end;
    //Application.MessageBox('请先选择服务器！', '提示信息', MB_OK + MB_ICONINFORMATION);

  //
end;

procedure TFormMain.ChangePercent(Percent: TPPercent; boAll: Boolean);
begin
  if boAll then begin
    ProgressAll.Percent := Percent;
    LabelAll.Caption := IntToStr(Percent) + '%';
  end
  else begin
    ProgressNow.Percent := Percent;
    LabelNow.Caption := IntToStr(Percent) + '%';
  end;
end;

function TFormMain.CheckIsRun: THandle;
begin
  Result := 0;
  FMapHandle := OpenFileMapping(FILE_MAP_ALL_ACCESS, False, PChar(g_MapName));
  if FMapHandle = 0 then begin
    CreateMapInfo;
  end
  else begin
    FMapDataInfo := MapViewOfFile(FMapHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
    if FMapDataInfo <> nil then begin
      Result := FMapDataInfo.Handle;
    end;
  end;
end;

procedure TFormMain.ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  if (SelectServerInfo <> nil) and (Socket.nIndex = SelectServerInfo.nIndex) and (not SelectServerInfo.boCheck) then begin
    Socket.SendText('*');
  end else
    Sender.Free;
end;

procedure TFormMain.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  if (SelectServerInfo <> nil) and (Socket.nIndex = SelectServerInfo.nIndex) and (not SelectServerInfo.boCheck) then begin
    Dec(FCheckCount);
    if FCheckCount <= 0 then begin
      BtnPlay.Enabled := False;
      BtnPlay.Refresh;
      LabelLog.Font.Color := clRed;
      LabelLog.Caption := '服务器正在维护...';
    end;
  end;
  ErrorCode:=0;
  Sender.Free;
end;

procedure TFormMain.ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
begin
  if (SelectServerInfo <> nil) and (Socket.nIndex = SelectServerInfo.nIndex) and (not SelectServerInfo.boCheck) then begin
    SelectServerInfo.boCheck := True;
    SelectServerInfo.CAddr := Socket.RemoteAddress;
    SelectServerInfo.CPort := Socket.RemotePort;
    BtnPlay.Enabled := True;
    BtnPlay.Refresh;
    LabelLog.Font.Color := clLime;
    LabelLog.Caption := '服务器正常开放...';
  end;
  Sender.Free;
end;

procedure TFormMain.CloseMapInfo;
begin
  if FMapDataInfo <> nil then
    UnMapViewOfFile(FMapDataInfo);
  if FMapHandle <> 0 then
    CloseHandle(FMapHandle);
  FMapDataInfo := nil;
  FMapHandle := 0;
end;

procedure TFormMain.CreateClientSocket(sAddrs: string; wPort: Word; nIndex: Integer);
begin
  With TClientSocket.Create(Nil) do begin
    Active := False;
    Socket.nIndex := nIndex;
    ClientType := ctNonBlocking;
    OnConnect := ClientSocketConnect;
    OnError := ClientSocketError;
    OnRead := ClientSocketRead;
    Host := sAddrs;
    Port := wPort;
    Active := True;
  end;
end;

procedure TFormMain.CreateMapInfo;
begin
  FMapHandle := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, SizeOf(TMapDataInfo), PChar(g_MapName));
  FMapDataInfo := MapViewOfFile(FMapHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
  if FMapDataInfo <> nil then begin
    FMapDataInfo.Handle := Handle;
  end;
end;

procedure TFormMain.DeleteTimerTimer(Sender: TObject);
begin
  DeleteTimer.Enabled := False;
  DeleteFile(PChar(FDeleteFile));
end;

procedure TFormMain.EzRgnBtn1Click(Sender: TObject);
begin
  {if g_boSQL then begin
    if g_PayUrl <> ''  then begin
      SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
      ShellExecute(Handle, 'Open', PChar(g_ChangePassUrl), '', '', SW_SHOW);
    end;
  end else begin     }
    if SelectServerInfo <> nil then begin
      if SelectServerInfo.boCheck then begin
        FormChangePass := TFormChangePass.Create(Owner);
        FormChangePass.Open(SelectServerInfo.CAddr, SelectServerInfo.CPort);
        FormChangePass.Free;
        FormChangePass := nil;
      end else
        Application.MessageBox('服务器维护中！', '提示信息', MB_OK + MB_ICONINFORMATION);
    end else
      Application.MessageBox('请先选择服务器！', '提示信息', MB_OK + MB_ICONINFORMATION);
 // end;
end;

procedure TFormMain.EzRgnBtn2Click(Sender: TObject);
begin
  {if g_boSQL then begin
    if g_PayUrl <> ''  then begin
      SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
      ShellExecute(Handle, 'Open', PChar(g_LostPassUrl), '', '', SW_SHOW);
    end;
  end else begin     }
    if SelectServerInfo <> nil then begin
      if SelectServerInfo.boCheck then begin
        FormLostPass := TFormLostPass.Create(Owner);
        FormLostPass.Open(SelectServerInfo.CAddr, SelectServerInfo.CPort);
        FormLostPass.Free;
        FormLostPass := nil;
      end else
        Application.MessageBox('服务器维护中！', '提示信息', MB_OK + MB_ICONINFORMATION);
    end else
      Application.MessageBox('请先选择服务器！', '提示信息', MB_OK + MB_ICONINFORMATION);
  //end;
end;

procedure TFormMain.EzRgnBtn3Click(Sender: TObject);
begin
  if g_HomeUrl <> ''  then begin
    SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
    ShellExecute(Handle, 'Open', PChar(g_HomeUrl), '', '', SW_SHOW);
  end;
end;

procedure TFormMain.EzRgnBtn4Click(Sender: TObject);
begin
  if g_PayUrl2 <> ''  then begin
    SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
    ShellExecute(Handle, 'Open', PChar(g_PayUrl2), '', '', SW_SHOW);
  end;
end;

procedure TFormMain.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  I, nCount: Integer;
begin
  nCount := 0;
  for I := Low(FClientList) to High(FClientList) do begin
    if FClientList[I] <> 0 then begin
      if SendMessage(FClientList[I], WM_CHECK_CLIENT, Handle, MSG_CHECK_CLIENT_TEST) <= 0 then begin
        FClientList[I] := 0;
      end else Inc(nCount);
    end;
  end;
  if (nCount > 0) then begin
    CanClose := False;
    Hide;
    FboHide := True;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  nRunHandle: THandle;
  FileVersionInfo: TFileVersionInfo;
//  FileStream: TFileStream;
//  SkinBottom: TLoginSkinBottom;
//  SkinHeader: TLoginSkinHeader;
//  Buffer: PChar;
//  GetBuffer: Pointer;
//  GetSize: Integer;
begin
  Randomize;
  g_CurrentDir := GetCurrentDir();
  if RightStr(g_CurrentDir, 1) <> '\' then
    g_CurrentDir := g_CurrentDir + '\';

  FboFrist := True;
  g_SelfName := ParamStr(0);
  GetFileVersion(g_SelfName, @FileVersionInfo);
  RzLabel1.Caption := 'Ver ' + FileVersionInfo.sVersion;
  FboHide := False;
  FCheckIndex := 0;
  g_SelfPath := g_CurrentDir;
  if FileExists(ParamStr(1)) then begin
    DeleteTimer.Enabled := True;
    FDeleteFile := ParamStr(1);
  end;
  //Application.OnMessage := MyMessage;
  //Application.OnException := MyException;
  g_TitleName := '兰达尔传奇';
  g_ListName := 'http://small.randall.top:8081/ServerInfo.txt';
  g_MapName := '1234567890123456';
  //sStr := 'DBC';

  //g_boSQL := sStr = 'SQL';
  g_TitleName := Trim(g_TitleName);
  g_SaveFileName := g_CurrentDir + 'Resource\' + g_MapName + '.xml';
  g_UpDataDir := g_CurrentDir + 'Down\' + g_MapName + '\';

  g_ClientName := g_CurrentDir + g_TitleName + '.dat';
  if FileExists(g_ClientName) then begin
    DeleteFile(PChar(g_ClientName));
  end;

  Application.Title := g_TitleName;
  FboLoad := False;
  boAllReadOK := False;
  FMapHandle := 0;
  FMapDataInfo := nil;
  SelectServerInfo := nil;
  g_DownList := TList.Create;
  ChangePercent(0, False);
  ChangePercent(0, True);
  CreateDir(g_CurrentDir + 'Down\');
  bJianXia := False;
  JianXiaCheckBox.Checked := bJianXia;

  nRunHandle := CheckIsRun;
  SetLength(FClientList, 3);
  FillChar(FClientList[0], Length(FClientList) * SizeOf(FClientList[0]), 0);
  if (nRunHandle <> 0) then begin
    SendMessage(nRunHandle, WM_REST, 0, 0);
    Application.Terminate;
  end
  else
  if (g_ListName = '') or (g_TitleName = '') or (g_MapName = '') then begin
    Application.MessageBox('加载配置信息失败！', '提示信息', MB_OK + MB_ICONSTOP);
    Application.Terminate;
  end
  else
  if not CheckMirDir(g_SelfPath, False) then begin
    FormFindClient := TFormFindClient.Create(Self.Owner);
    FormFindClient.ShowModal;
    if (sFindDir <> '')  then begin
      if CopyFile(PChar(g_SelfName), PChar(sFindDir + ExtractFileName(g_SelfName)), False) then begin
        PostMessage(Handle, WM_CLOSE, 0, 0);
        SetCurrentDir(sFindDir);
        ShellExecute(0, 'open', PChar(sFindDir + ExtractFileName(g_SelfName)), PChar(g_SelfName), nil, SW_SHOW);
        Exit;
      end;
    end;
    FormFindClient.Free;
    Application.Terminate;
  end else
    tmrStart.Enabled := True;

  { else begin
  g_ListName := GetValidStr3(sStr, TitleName, [#13]);
  g_TitleName := TitleName;
  g_MapName := MapName;
    CreateDir(g_CurrentDir + 'Down\');
    Try
      FileStream := TFileStream.Create(ParamStr(0), fmOpenRead or fmShareDenyNone);
      Try
        FileStream.Seek(-SizeOf(SkinBottom), soEnd);
        if FileStream.Read(SkinBottom, SizeOf(SkinBottom)) = SizeOf(SkinBottom) then begin
          if (SkinBottom.sTitle[0] = '3') and (SkinBottom.sTitle[1] = '6') and (SkinBottom.sTitle[2] = '1') then begin
            FileStream.Seek(SkinBottom.nOffset, soBeginning);
            if FileStream.Read(SkinHeader, SizeOf(SkinHeader)) = SizeOf(SkinHeader) then begin
              if (SkinHeader.sTitle = LOGINSKININFOTITLE) and (SkinHeader.nVar = LOGINSKININFOVAR) and (SkinHeader.nSize > 0) then begin
                GetMem(Buffer, SkinHeader.nSize);
                Try
                  if FileStream.Read(Buffer^, SkinHeader.nSize) = SkinHeader.nSize then begin
                    DecompressBuf(Buffer, SkinHeader.nSize, 0, GetBuffer, GetSize);
                    if GetSize > 0 then begin
                      Move(PChar(GetBuffer)[GetSize - SizeOf(g_SkinInfo)], g_SkinInfo, SizeOf(g_SkinInfo));
                      InitSetup(@g_SkinInfo, GetBuffer);
                      FreeMem(GetBuffer);
                      tmrStart.Enabled := True;
                      Exit;
                    end;
                    FreeMem(GetBuffer);
                  end;
                Finally
                  FreeMem(Buffer);
                End;
              end;
            end;
          end;
        end;
      Finally
        FileStream.Free;
      End;
    Except
      on E:Exception do begin
        Application.MessageBox(PChar('加载皮肤文件出现错误，加载失败！' + #13#10 + E.Message), '提示信息', MB_OK + MB_ICONSTOP);
        Application.Terminate;
        Exit;
      end;
    End;
    Application.MessageBox('加载皮肤文件失败！', '提示信息', MB_OK + MB_ICONSTOP);
    Application.Terminate;
  end;              }
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  CloseMapInfo;
  g_DownList.Free;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  with TreeViewServer do begin
    Left := 73;
    Top := 70;
    Width := 246;
    Height := 340;
  end;
  WebBrowser.Width := 418;
  WebBrowser.Height := 371;
  WebBrowser.Left := 340;
  WebBrowser.Top := 71;
end;

function TFormMain.GetCheckIndex: Integer;
begin
  Inc(FCheckIndex);
  Result := FCheckIndex;
end;

procedure TFormMain.ImageBgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture; //释放鼠标的捕获状态；
  Perform(wm_SysCommand, {sc_DragMove} $F012, 0); //向窗体发送移动消息
end;
procedure TFormMain.JianXiaCheckBoxClick(Sender: TObject);
var
  cName : string;
begin
  cName := g_ClientName;
  bJianXia := JianXiaCheckBox.Checked;
  if bJianXia then
  begin
    cName := g_CurrentDir + 'jx-' + g_TitleName + '.dat';;
  end;
  if FileExists(cName) then begin
    DeleteFile(PChar(cName));
  end;
end;

(*
procedure TFormMain.InitSetup(SkinInfo: pTLoginSkinInfo; Buffer: PChar);
var
  MemoryStream: TMemoryStream;
  JPG: TJPEGImage;
  Bitmap: TBitmap;
begin
  MemoryStream := nil;
  {Width := ImageBg.Picture.Width;
  Height := ImageBg.Picture.Height;
  TransparentColor := True;
  TransparentColorValue := $636363};
  if Buffer = nil then Exit;
  Try
    if (Buffer <> nil) then begin
      MemoryStream := TMemoryStream.Create;
    end;
    TransparentColor := SKinInfo.BG_boTransparent;
    TransparentColorValue := SkinInfo.BG_TransparentColor;
    if (Buffer <> nil) and (SkinInfo.BG_Bitmap.Offset >= 0) and (SkinInfo.BG_Bitmap.Size > 0) then begin
      MemoryStream.Clear;
      MemoryStream.Write(Buffer[SkinInfo.BG_Bitmap.Offset], SkinInfo.BG_Bitmap.Size);
      MemoryStream.Position := 0;
      if SkinInfo.BG_ImageType = it_Jpeg then begin
        JPG := TJPEGImage.Create;
        Try
          ImageBg.Picture.Graphic := JPG;
          ImageBg.Picture.Graphic.LoadFromStream(MemoryStream);
        Finally
          JPG.Free;
        End;
      end else begin
        Bitmap := TBitmap.Create;
        Try
          ImageBg.Picture.Graphic := Bitmap;
          ImageBg.Picture.Graphic.LoadFromStream(MemoryStream);
        Finally
          Bitmap.Free;
        End;
      end;
    end;
    Width := ImageBg.Picture.Width;
    Height := ImageBg.Picture.Height;

    RzLabel1.Visible := SkinInfo.Var_boShow;
    RzLabel1.Left := SkinInfo.Var_Pos.Left;
    RzLabel1.Top := SkinInfo.Var_Pos.Top;
    RzLabel1.Font.Color := SkinInfo.Var_Color;

    LabelLog.Left := SkinInfo.Hint_Pos.Left;
    LabelLog.Top := SkinInfo.Hint_Pos.Top;

    ProgressNow.Left := SkinInfo.ProgressNow_Rect.Left;
    ProgressNow.Top := SkinInfo.ProgressNow_Rect.Top;
    ProgressNow.Width := SkinInfo.ProgressNow_Rect.Width;
    ProgressNow.Height := SKinInfo.ProgressNow_Rect.Height;
    ProgressNow.BarColor := SkinInfo.ProgressNow_Color1;
    ProgressNow.BarColorStop := SkinInfo.ProgressNow_Color2;

    ProgressAll.Left := SkinInfo.ProgressAll_Rect.Left;
    ProgressAll.Top := SkinInfo.ProgressAll_Rect.Top;
    ProgressAll.Width := SkinInfo.ProgressAll_Rect.Width;
    ProgressAll.Height := SKinInfo.ProgressAll_Rect.Height;
    ProgressAll.BarColor := SkinInfo.ProgressAll_Color1;
    ProgressAll.BarColorStop := SkinInfo.ProgressAll_Color2;


    LabelNow.Left := SkinInfo.ProgressNowHint_Pos.Left;
    LabelNow.Top := SkinInfo.ProgressNowHint_Pos.Top;
    LabelNow.Font.Color := SkinInfo.ProgressNowHint_Color;

    LabelAll.Left := SkinInfo.ProgressAllHint_Pos.Left;
    LabelAll.Top := SkinInfo.ProgressAllHint_Pos.Top;
    LabelAll.Font.Color := SKinInfo.ProgressAllHint_Color;

    btnPlay.Left := SKinInfo.Start_Pos.Left;
    btnPlay.Top := SkinInfo.Start_Pos.Top;
    if (Buffer <> nil) and (SkinInfo.Start_Bitmap_Idle.Offset >= 0) and (SkinInfo.Start_Bitmap_Idle.Size > 0) then begin
      MemoryStream.Clear;
      MemoryStream.Write(Buffer[SkinInfo.Start_Bitmap_Idle.Offset], SkinInfo.Start_Bitmap_Idle.Size);
      MemoryStream.Position := 0;
      btnPlay.PicIdle.Bitmap.LoadFromStream(MemoryStream);
    end;
    if (Buffer <> nil) and (SkinInfo.Start_Bitmap_Move.Offset >= 0) and (SkinInfo.Start_Bitmap_Move.Size > 0) then begin
      MemoryStream.Clear;
      MemoryStream.Write(Buffer[SkinInfo.Start_Bitmap_Move.Offset], SkinInfo.Start_Bitmap_Move.Size);
      MemoryStream.Position := 0;
      btnPlay.PicUp.Bitmap.LoadFromStream(MemoryStream);
    end;
    if (Buffer <> nil) and (SkinInfo.Start_Bitmap_Down.Offset >= 0) and (SkinInfo.Start_Bitmap_Down.Size > 0) then begin
      MemoryStream.Clear;
      MemoryStream.Write(Buffer[SkinInfo.Start_Bitmap_Down.Offset], SkinInfo.Start_Bitmap_Down.Size);
      MemoryStream.Position := 0;
      btnPlay.PicDown.Bitmap.LoadFromStream(MemoryStream);
    end;
    if (Buffer <> nil) and (SkinInfo.Start_Bitmap_Dsbld.Offset >= 0) and (SkinInfo.Start_Bitmap_Dsbld.Size > 0) then begin
      MemoryStream.Clear;
      MemoryStream.Write(Buffer[SkinInfo.Start_Bitmap_Dsbld.Offset], SkinInfo.Start_Bitmap_Dsbld.Size);
      MemoryStream.Position := 0;
      btnPlay.PicDsbld.Bitmap.LoadFromStream(MemoryStream);
    end;

    btnUpdating.Visible := SkinInfo.Reg_boShow;
    if SkinInfo.Reg_boShow then begin
      btnUpdating.Left := SkinInfo.Reg_Pos.Left;
      btnUpdating.Top := SkinInfo.Reg_Pos.Top;
      if (Buffer <> nil) and (SkinInfo.Reg_Bitmap_Idle.Offset >= 0) and (SkinInfo.Reg_Bitmap_Idle.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Reg_Bitmap_Idle.Offset], SkinInfo.Reg_Bitmap_Idle.Size);
        MemoryStream.Position := 0;
        btnUpdating.PicIdle.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Reg_Bitmap_Move.Offset >= 0) and (SkinInfo.Reg_Bitmap_Move.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Reg_Bitmap_Move.Offset], SkinInfo.Reg_Bitmap_Move.Size);
        MemoryStream.Position := 0;
        btnUpdating.PicUp.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Reg_Bitmap_Down.Offset >= 0) and (SkinInfo.Reg_Bitmap_Down.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Reg_Bitmap_Down.Offset], SkinInfo.Reg_Bitmap_Down.Size);
        MemoryStream.Position := 0;
        btnUpdating.PicDown.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Reg_Bitmap_Dsbld.Offset >= 0) and (SkinInfo.Reg_Bitmap_Dsbld.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Reg_Bitmap_Dsbld.Offset], SkinInfo.Reg_Bitmap_Dsbld.Size);
        MemoryStream.Position := 0;
        btnUpdating.PicDsbld.Bitmap.LoadFromStream(MemoryStream);
      end;
    end;

    EzRgnbtn1.Visible := SkinInfo.ChangePass_boShow;
    if SkinInfo.ChangePass_boShow then begin
      EzRgnbtn1.Left := SkinInfo.ChangePass_Pos.Left;
      EzRgnbtn1.Top := SkinInfo.ChangePass_Pos.Top;
      if (Buffer <> nil) and (SkinInfo.ChangePass_Bitmap_Idle.Offset >= 0) and (SkinInfo.ChangePass_Bitmap_Idle.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.ChangePass_Bitmap_Idle.Offset], SkinInfo.ChangePass_Bitmap_Idle.Size);
        MemoryStream.Position := 0;
        EzRgnbtn1.PicIdle.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.ChangePass_Bitmap_Move.Offset >= 0) and (SkinInfo.ChangePass_Bitmap_Move.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.ChangePass_Bitmap_Move.Offset], SkinInfo.ChangePass_Bitmap_Move.Size);
        MemoryStream.Position := 0;
        EzRgnbtn1.PicUp.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.ChangePass_Bitmap_Down.Offset >= 0) and (SkinInfo.ChangePass_Bitmap_Down.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.ChangePass_Bitmap_Down.Offset], SkinInfo.ChangePass_Bitmap_Down.Size);
        MemoryStream.Position := 0;
        EzRgnbtn1.PicDown.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.ChangePass_Bitmap_Dsbld.Offset >= 0) and (SkinInfo.ChangePass_Bitmap_Dsbld.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.ChangePass_Bitmap_Dsbld.Offset], SkinInfo.ChangePass_Bitmap_Dsbld.Size);
        MemoryStream.Position := 0;
        EzRgnbtn1.PicDsbld.Bitmap.LoadFromStream(MemoryStream);
      end;
    end;

    EzRgnbtn2.Visible := SkinInfo.LostPass_boShow;
    if SkinInfo.LostPass_boShow then begin
      EzRgnbtn2.Left := SkinInfo.LostPass_Pos.Left;
      EzRgnbtn2.Top := SkinInfo.LostPass_Pos.Top;
      if (Buffer <> nil) and (SkinInfo.LostPass_Bitmap_Idle.Offset >= 0) and (SkinInfo.LostPass_Bitmap_Idle.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.LostPass_Bitmap_Idle.Offset], SkinInfo.LostPass_Bitmap_Idle.Size);
        MemoryStream.Position := 0;
        EzRgnbtn2.PicIdle.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.LostPass_Bitmap_Move.Offset >= 0) and (SkinInfo.LostPass_Bitmap_Move.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.LostPass_Bitmap_Move.Offset], SkinInfo.LostPass_Bitmap_Move.Size);
        MemoryStream.Position := 0;
        EzRgnbtn2.PicUp.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.LostPass_Bitmap_Down.Offset >= 0) and (SkinInfo.LostPass_Bitmap_Down.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.LostPass_Bitmap_Down.Offset], SkinInfo.LostPass_Bitmap_Down.Size);
        MemoryStream.Position := 0;
        EzRgnbtn2.PicDown.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.LostPass_Bitmap_Dsbld.Offset >= 0) and (SkinInfo.LostPass_Bitmap_Dsbld.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.LostPass_Bitmap_Dsbld.Offset], SkinInfo.LostPass_Bitmap_Dsbld.Size);
        MemoryStream.Position := 0;
        EzRgnbtn2.PicDsbld.Bitmap.LoadFromStream(MemoryStream);
      end;
    end;

    btnSetup.Visible := SkinInfo.Setup_boShow;
    if SkinInfo.Setup_boShow then begin
      btnSetup.Left := SkinInfo.Setup_Pos.Left;
      btnSetup.Top := SkinInfo.Setup_Pos.Top;
      if (Buffer <> nil) and (SkinInfo.Setup_Bitmap_Idle.Offset >= 0) and (SkinInfo.Setup_Bitmap_Idle.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Setup_Bitmap_Idle.Offset], SkinInfo.Setup_Bitmap_Idle.Size);
        MemoryStream.Position := 0;
        btnSetup.PicIdle.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Setup_Bitmap_Move.Offset >= 0) and (SkinInfo.Setup_Bitmap_Move.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Setup_Bitmap_Move.Offset], SkinInfo.Setup_Bitmap_Move.Size);
        MemoryStream.Position := 0;
        btnSetup.PicUp.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Setup_Bitmap_Down.Offset >= 0) and (SkinInfo.Setup_Bitmap_Down.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Setup_Bitmap_Down.Offset], SkinInfo.Setup_Bitmap_Down.Size);
        MemoryStream.Position := 0;
        btnSetup.PicDown.Bitmap.LoadFromStream(MemoryStream);
      end;
    end;

    EzRgnbtn3.Visible := SkinInfo.Home_boShow;
    if SkinInfo.Home_boShow then begin
      EzRgnbtn3.Left := SkinInfo.Home_Pos.Left;
      EzRgnbtn3.Top := SkinInfo.Home_Pos.Top;
      if (Buffer <> nil) and (SkinInfo.Home_Bitmap_Idle.Offset >= 0) and (SkinInfo.Home_Bitmap_Idle.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Home_Bitmap_Idle.Offset], SkinInfo.Home_Bitmap_Idle.Size);
        MemoryStream.Position := 0;
        EzRgnbtn3.PicIdle.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Home_Bitmap_Move.Offset >= 0) and (SkinInfo.Home_Bitmap_Move.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Home_Bitmap_Move.Offset], SkinInfo.Home_Bitmap_Move.Size);
        MemoryStream.Position := 0;
        EzRgnbtn3.PicUp.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Home_Bitmap_Down.Offset >= 0) and (SkinInfo.Home_Bitmap_Down.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Home_Bitmap_Down.Offset], SkinInfo.Home_Bitmap_Down.Size);
        MemoryStream.Position := 0;
        EzRgnbtn3.PicDown.Bitmap.LoadFromStream(MemoryStream);
      end;
    end;

    EzRgnbtn4.Visible := SkinInfo.Pay_boShow;
    if SkinInfo.Pay_boShow then begin
      EzRgnbtn4.Left := SkinInfo.Pay_Pos.Left;
      EzRgnbtn4.Top := SkinInfo.Pay_Pos.Top;
      if (Buffer <> nil) and (SkinInfo.Pay_Bitmap_Idle.Offset >= 0) and (SkinInfo.Pay_Bitmap_Idle.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Pay_Bitmap_Idle.Offset], SkinInfo.Pay_Bitmap_Idle.Size);
        MemoryStream.Position := 0;
        EzRgnbtn4.PicIdle.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Pay_Bitmap_Move.Offset >= 0) and (SkinInfo.Pay_Bitmap_Move.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Pay_Bitmap_Move.Offset], SkinInfo.Pay_Bitmap_Move.Size);
        MemoryStream.Position := 0;
        EzRgnbtn4.PicUp.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Pay_Bitmap_Down.Offset >= 0) and (SkinInfo.Pay_Bitmap_Down.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Pay_Bitmap_Down.Offset], SkinInfo.Pay_Bitmap_Down.Size);
        MemoryStream.Position := 0;
        EzRgnbtn4.PicDown.Bitmap.LoadFromStream(MemoryStream);
      end;
    end;

    btnExit.Visible := SkinInfo.Exit_boShow;
    if SkinInfo.Exit_boShow then begin
      btnExit.Left := SkinInfo.Exit_Pos.Left;
      btnExit.Top := SkinInfo.Exit_Pos.Top;
      if (Buffer <> nil) and (SkinInfo.Exit_Bitmap_Idle.Offset >= 0) and (SkinInfo.Exit_Bitmap_Idle.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Exit_Bitmap_Idle.Offset], SkinInfo.Exit_Bitmap_Idle.Size);
        MemoryStream.Position := 0;
        btnExit.PicIdle.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Exit_Bitmap_Move.Offset >= 0) and (SkinInfo.Exit_Bitmap_Move.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Exit_Bitmap_Move.Offset], SkinInfo.Exit_Bitmap_Move.Size);
        MemoryStream.Position := 0;
        btnExit.PicUp.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Exit_Bitmap_Down.Offset >= 0) and (SkinInfo.Exit_Bitmap_Down.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Exit_Bitmap_Down.Offset], SkinInfo.Exit_Bitmap_Down.Size);
        MemoryStream.Position := 0;
        btnExit.PicDown.Bitmap.LoadFromStream(MemoryStream);
      end;
    end;

    btnMin.Visible := SkinInfo.Min_boShow;
    if SkinInfo.Min_boShow then begin
      btnMin.Left := SkinInfo.Min_Pos.Left;
      btnMin.Top := SkinInfo.Min_Pos.Top;
      if (Buffer <> nil) and (SkinInfo.Min_Bitmap_Idle.Offset >= 0) and (SkinInfo.Min_Bitmap_Idle.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Min_Bitmap_Idle.Offset], SkinInfo.Min_Bitmap_Idle.Size);
        MemoryStream.Position := 0;
        btnMin.PicIdle.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Min_Bitmap_Move.Offset >= 0) and (SkinInfo.Min_Bitmap_Move.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Min_Bitmap_Move.Offset], SkinInfo.Min_Bitmap_Move.Size);
        MemoryStream.Position := 0;
        btnMin.PicUp.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Min_Bitmap_Down.Offset >= 0) and (SkinInfo.Min_Bitmap_Down.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Min_Bitmap_Down.Offset], SkinInfo.Min_Bitmap_Down.Size);
        MemoryStream.Position := 0;
        btnMin.PicDown.Bitmap.LoadFromStream(MemoryStream);
      end;
    end;

    btnClose.Visible := SkinInfo.Close_boShow;
    if SkinInfo.Close_boShow then begin
      btnClose.Left := SkinInfo.Close_Pos.Left;
      btnClose.Top := SkinInfo.Close_Pos.Top;
      if (Buffer <> nil) and (SkinInfo.Close_Bitmap_Idle.Offset >= 0) and (SkinInfo.Close_Bitmap_Idle.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Close_Bitmap_Idle.Offset], SkinInfo.Close_Bitmap_Idle.Size);
        MemoryStream.Position := 0;
        btnClose.PicIdle.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Close_Bitmap_Move.Offset >= 0) and (SkinInfo.Close_Bitmap_Move.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Close_Bitmap_Move.Offset], SkinInfo.Close_Bitmap_Move.Size);
        MemoryStream.Position := 0;
        btnClose.PicUp.Bitmap.LoadFromStream(MemoryStream);
      end;
      if (Buffer <> nil) and (SkinInfo.Close_Bitmap_Down.Offset >= 0) and (SkinInfo.Close_Bitmap_Down.Size > 0) then begin
        MemoryStream.Clear;
        MemoryStream.Write(Buffer[SkinInfo.Close_Bitmap_Down.Offset], SkinInfo.Close_Bitmap_Down.Size);
        MemoryStream.Position := 0;
        btnClose.PicDown.Bitmap.LoadFromStream(MemoryStream);
      end;
    end;
  Finally
    if MemoryStream <> nil then MemoryStream.Free;
  End;
end;         *)

procedure TFormMain.MyChangePercent(var Msg: TMessage);
begin
  ChangePercent(Msg.WParam, Msg.LParam = 1);
end;

procedure TFormMain.MyCheckClient(var Msg: TMessage);
var
  nMsg, nIndex: Integer;
  nHandle: THandle;
begin
  nHandle := Msg.WParam;
  nMsg := LoWord(Msg.LParam);
  nIndex := HiWord(Msg.LParam);
  if (nIndex >= Low(FClientList)) and (nIndex <= High(FClientList)) then begin
    case nMsg of
      MSG_CHECK_CLIENT_TEST: begin
          if (nHandle = FClientList[nIndex]) and (nHandle <> 0) then begin
            Msg.Result := 1;
          end;
        end;
      MSG_CHECK_CLIENT_EXIT: begin
          FClientList[nIndex] := 0;
          tmrCheckTimer(tmrCheck);
        end;
    end;
  end;
end;

procedure TFormMain.MyDisposalXML(var Msg: TMessage);
var
  RootNode, ANode, BNode, CNode, DNode: IXMLNode;
  xmlList, ln, bn, cn: IXMLNodeList;
  i, k, j, n: Integer;
  MasterTreeNode, CTreeNode: TTreeNode;
  sName, sAddrs, sPort, sCheckStr{, sENAddrs, sENPort}: string;
  //nPort: Integer;
  LServerInfo: pTLServerInfo;
  UpDataInfo: TUpDataInfo;
  pUpDataInfo: PTUpDataInfo;
  boAddDown: Boolean;
begin
  ShowHintMsg('正在解析服务器列表信息...');
  try
    TreeViewServer.Items.Clear;
    if FileExists(g_SaveFileName) then begin
      xmldSetup.FileName := g_SaveFileName;
      try
        xmldSetup.Active := True;
        RootNode := xmldSetup.DocumentElement;
        xmlList := RootNode.ChildNodes;
        ANode := xmlList[XML_SERVER_MASTERNODE];
        if ANode.HasChildNodes then begin
          ln := ANode.ChildNodes;
          for I := 0 to ln.Count - 1 do begin
            BNode := ln[I];
            MasterTreeNode := TreeViewServer.Items.Add(nil, IDeCodeString(BNode.GetAttribute(XML_SERVER_NAME)));
            bn := BNode.ChildNodes;
            for k := 0 to bn.Count - 1 do begin
              CNode := bn[k];
              New(LServerInfo);
              FillChar(LServerInfo^, SizeOf(TLServerInfo), #0);
              LServerInfo.sShowName := IDeCodeString(CNode.GetAttribute(XML_SERVER_NAME));
              CTreeNode := TreeViewServer.Items.AddChild(MasterTreeNode, LServerInfo.sShowName);
              CTreeNode.Data := LServerInfo;
              cn := CNode.ChildNodes;
              n := 0;
              for j := 0 to cn.Count - 1 do begin
                if n >= 8 then break;
                DNode := cn[j];
                if not VarIsNull(DNode.Text) then begin
                  sName := IDeCodeString(DNode.Text);
                  sAddrs := IDeCodeString(DNode.GetAttribute(XML_SERVER_NODE_ADDRS));
                  sPort := IDeCodeString(DNode.GetAttribute(XML_SERVER_NODE_PORT));
                  //sENAddrs := DNode.GetAttribute(XML_SERVER_NODE_ENADDRS);
                  //sENPort := DNode.GetAttribute(XML_SERVER_NODE_ENPORT);
                  //nPort := StrToIntDef(sPort, -1);
                  if (sName <> '') and (sAddrs <> '') {and (nPort > 0) and (nPort < 65535)} then begin
                    LServerInfo.Info[n].sName := sName;
                    LServerInfo.Info[n].sAddrs := sAddrs;
                    LServerInfo.Info[n].sPort := sPort;
                    LServerInfo.ENInfo[n].sName := sName;
                    LServerInfo.ENInfo[n].sAddrs := sAddrs;
                    LServerInfo.ENInfo[n].sPort := sPort;
                    Inc(n);
                  end;
                end;
              end;
            end;
            MasterTreeNode.Expanded := True;
          end;

          ANode := xmlList[XML_URL_MASTERNODE];

          if not VarIsNull(ANode.ChildValues[XML_URL_LFRAME]) then
            g_LoginframeUrl := IDeCodeString(ANode.ChildValues[XML_URL_LFRAME]);
          if not VarIsNull(ANode.ChildValues[XML_URL_CONTACTGM]) then
            g_GMUrl := IDeCodeString(ANode.ChildValues[XML_URL_CONTACTGM]);
          if not VarIsNull(ANode.ChildValues[XML_URL_PAYMENT]) then
            g_PayUrl := IDeCodeString(ANode.ChildValues[XML_URL_PAYMENT]);
          if not VarIsNull(ANode.ChildValues[XML_URL_REGISTER]) then
            g_RegUrl := IDeCodeString(ANode.ChildValues[XML_URL_REGISTER]);
          if not VarIsNull(ANode.ChildValues[XML_URL_CHANGEPASS]) then
            g_ChangePassUrl := IDeCodeString(ANode.ChildValues[XML_URL_CHANGEPASS]);
          if not VarIsNull(ANode.ChildValues[XML_URL_LostPASS]) then
            g_LostPassUrl := IDeCodeString(ANode.ChildValues[XML_URL_LostPASS]);
          if not VarIsNull(ANode.ChildValues[XML_URL_PAYMENT2]) then
            g_PayUrl2 := IDeCodeString(ANode.ChildValues[XML_URL_PAYMENT2]);
          if not VarIsNull(ANode.ChildValues[XML_URL_HOMR]) then
            g_HomeUrl := IDeCodeString(ANode.ChildValues[XML_URL_HOMR]);
          {if not VarIsNull(ANode.ChildValues[XML_URL_LOGOIMAGE]) then
            g_LogoImage := DecryptStr(ANode.ChildValues[XML_URL_LOGOIMAGE]);   }


          ANode := xmlList[XML_UPDATE_MASTERNODE];
          if ANode.HasChildNodes then begin
            ln := ANode.ChildNodes;
            for I := 0 to ln.Count - 1 do begin
              BNode := ln[I];
              if not VarIsNull(BNode.Text) then begin
                FillChar(UpDataInfo, SizeOf(UpDataInfo), #0);
                boAddDown := False;
                UpDataInfo.sHint := IDeCodeString(BNode.Text);
                UpDataInfo.sSaveDir := IDeCodeString(BNode.GetAttribute(XML_UPDATE_SAVEDIR));
                UpDataInfo.sFileName := IDeCodeString(BNode.GetAttribute(XML_UPDATE_FILENAME));
                UpDataInfo.sDownUrl := IDeCodeString(BNode.GetAttribute(XML_UPDATE_DOWNPATH));
                UpDataInfo.boZip := BNode.GetAttribute(XML_UPDATE_ZIP) = XML_ZIP_YES;
                sCheckStr := BNode.GetAttribute(XML_UPDATE_CHECK);
                UpDataInfo.boBaiduDown := BNode.GetAttribute(XML_UPDATE_DOWNTYPE) = XML_DOWNTYPE_BAIDU;
                UpDataInfo.nDate := StrToIntDef(BNode.GetAttribute(XML_UPDATE_DATE), 0);
                UpDataInfo.nVar := StrToIntDef(BNode.GetAttribute(XML_UPDATE_VAR), 0);
                UpDataInfo.sMD5 := BNode.GetAttribute(XML_UPDATE_MD5);
                UpDataInfo.sID := BNode.GetAttribute(XML_UPDATE_ID);
                if sCheckStr <> '' then begin
                  case sCheckStr[1] of
                    XML_CHECK_VAR: begin
                        boAddDown := True;
                        UpDataInfo.CheckType := dct_var;
                      end;
                    XML_CHECK_EXISTS: begin
                        boAddDown := True;
                        UpDataInfo.CheckType := dct_exists;
                      end;
                    XML_CHECK_PACK: begin
                        boAddDown := True;
                        UpDataInfo.CheckType := dct_pack;
                      end;
                    XML_CHECK_MD5: begin
                        boAddDown := True;
                        UpDataInfo.CheckType := dct_md5;
                      end;
                  end;
                  if boAddDown then begin
                    New(pUpDataInfo);
                    pUpDataInfo^ := UpDataInfo;
                    g_DownList.Add(pUpDataInfo);
                  end;
                end;
              end;
            end;
          end;
          if g_LoginframeUrl <> '' then WebBrowser.Navigate(g_LoginframeUrl);
        end;
      finally
        xmldSetup.Active := False;
        BtnUpdating.Enabled := True;
        EzRgnBtn1.Enabled := True;
        EzRgnBtn2.Enabled := True;
        BtnUpdating.Repaint;
        EzRgnBtn1.Repaint;
        EzRgnBtn2.Repaint;
      end;
    end;
  except
  end;
end;

procedure TFormMain.MyException(Sender: TObject; E: Exception);
begin
  //
end;

procedure TFormMain.MyGetServerList(var Msg: TMessage);
var
  nCount, nIndex: SmallInt;
  nHandle: THandle;
  I: Integer;
  SendData: TCopyDataStruct;
begin
  nCount := 0;
  nIndex := -1;
  if (SelectServerInfo <> nil) then begin
    nHandle := Msg.WParam;
    for I := Low(FClientList) to High(FClientList) do begin
      if FClientList[I] = 0 then begin
        FClientList[I] := nHandle;
        nIndex := I;
        break;
      end;
    end;
    if nIndex > -1 then begin
      FillChar(g_ServerInfo, SizeOf(g_ServerInfo), #0);
      for I := Low(SelectServerInfo.Info) to High(SelectServerInfo.Info) do begin
        if SelectServerInfo.Info[I].sName <> '' then begin
          g_ServerInfo[I] := SelectServerInfo.ENInfo[I];
          Inc(nCount);
        end;
      end;
      if nCount > 0 then begin
        SendData.cbData := SizeOf(g_ServerInfo);
        GetMem(SendData.lpData, SendData.cbData);
        Move(g_ServerInfo[0], SendData.lpData^, SendData.cbData);
        SendMessage(nHandle, WM_COPYDATA, COPYMSG_LOGIN_SENDSERVERLIST, Cardinal(@SendData));
        FreeMem(SendData.lpData);
      end;
      g_WebInfo.g_GMUrl := g_GMUrl;
      g_WebInfo.g_PayUrl := g_PayUrl;
      g_WebInfo.g_RegUrl := g_RegUrl;
      g_WebInfo.g_ChangePassUrl := g_ChangePassUrl;
      g_WebInfo.g_LostPassUrl := g_LostPassUrl;
      g_WebInfo.g_UserList := g_ListName;
      g_WebInfo.g_GameName := g_TitleName;
      SendData.cbData := SizeOf(g_WebInfo);
      GetMem(SendData.lpData, SendData.cbData);
      Move(g_WebInfo, SendData.lpData^, SendData.cbData);
      SendMessage(nHandle, WM_COPYDATA, COPYMSG_LOGIN_WEBINFO, Cardinal(@SendData));
      FreeMem(SendData.lpData);
    end;
  end;
  Msg.Result := MakeLong(nCount, nIndex);
end;

procedure TFormMain.MyCopyDataMessage(var MsgData: TWmCopyData);
begin
  case MsgData.From of
    COPYMSG_LOGIN_HINTMSG: ShowHintMsg(StrPas(MsgData.CopyDataStruct^.lpData));
  end;
end;

procedure TFormMain.MyReadOK(var Msg: TMessage);
var
  UpDataInfo: PTUpDataInfo;
begin
  boAllReadOK := True;
  for UpDataInfo in g_DownList do
    Dispose(UpDataInfo);
  g_DownList.Clear;
end;

procedure TFormMain.MyRest(var Message: TMessage);
begin
  Show;
  FboHide := False;
  SendMessage(Application.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
end;

procedure TFormMain.MySelfChange(var Msg: TMessage);
begin
  if FileExists(g_SelfName + '.bak') then DeleteFile(PChar(g_SelfName + '.bak'));
  RenameFile(g_SelfName, g_SelfName + '.bak');
  CopyFile(PChar(Msg.LParam), PChar(g_SelfName), False);
  PostMessage(Handle, WM_CLOSE, 0, 0);
  ShellExecute(0, 'open', PChar(g_SelfName), PChar(g_SelfName + '.bak'), nil, SW_SHOW);

end;
  {
function TFormMain.LoadPNGtoBMP(Stream: TStream; var Bmp: TBitmap): Boolean;
var
  Image: TPngObject;
  ScanIndex, i, k: Integer;
  PxScan: PLongword;
  PxAlpha: PByte;
  Dest: TBitmap;
  nX, nY: Integer;
  P32RGB, P32RGB2: PRGBQuad;
  ImageMarkX, ImageMarkY: Integer;
begin
  Result := True;
  ImageMarkX := 84;
  ImageMarkY := 385;
  Image := TPngObject.Create();
  try
    Image.LoadFromStream(Stream);
  except
    Result := False;
  end;
  Dest := TBitmap.Create;
  if (Result) then begin
    Image.AssignTo(Dest);

    if (Image.Header.ColorType = COLOR_RGBALPHA) or (Image.Header.ColorType = COLOR_GRAYSCALEALPHA) then begin
      Dest.PixelFormat := pf32bit;

      for ScanIndex := 0 to Dest.Height - 1 do begin
        PxScan := Dest.Scanline[ScanIndex];
        PxAlpha := @Image.AlphaScanline[ScanIndex][0];
        for i := 0 to Dest.Width - 1 do begin
          PxScan^ := (PxScan^ and $FFFFFF) or (Longword(Byte(PxAlpha^)) shl 24);
          Inc(PxScan);
          Inc(PxAlpha);
        end;
      end;
    end;

    if (Bmp.Width > Dest.Width) and (Bmp.Height > Dest.Height) then begin
      nX := Bmp.Width - Dest.Width;
      nY := Bmp.Height - Dest.Height;
      if (nX >= ImageMarkX) and (ImageMarkX > 0) then begin
        Dec(nX, ImageMarkX);
      end;
      if (nY >= ImageMarkY) and (ImageMarkY > 0) then begin
        Dec(nY, ImageMarkY);
      end;
      for I := 0 to Dest.Height - 1 do begin
        P32RGB := PRGBQuad(Dest.ScanLine[I]);
        P32RGB2 := PRGBQuad(Bmp.ScanLine[I + nY]);
        Inc(P32RGB2, nX);
        for K := 0 to Dest.Width - 1 do begin
          P32RGB2.rgbBlue := (P32RGB.rgbBlue * P32RGB.rgbReserved + P32RGB2.rgbBlue * (255 - P32RGB.rgbReserved)) div 255;
          P32RGB2.rgbGreen := (P32RGB.rgbGreen * P32RGB.rgbReserved + P32RGB2.rgbGreen * (255 - P32RGB.rgbReserved)) div 255;
          P32RGB2.rgbRed := (P32RGB.rgbRed * P32RGB.rgbReserved + P32RGB2.rgbRed * (255 - P32RGB.rgbReserved)) div 255;
          P32RGB2.rgbReserved := 255;
          Inc(P32RGB);
          Inc(P32RGB2);
        end;
      end;
    end;
  end;
  Image.Free();
  Dest.Free;
end;       }
 {
procedure TFormMain.MyWriteLogo(var Msg: TMessage);
var
  Bitmap: TBitmap;
  MemoryStream: TMemoryStream;
begin
  if FileExists('.\Resource\Logo\' + g_MapName + '.png') then begin
    MemoryStream := TMemoryStream.Create;
    MemoryStream.LoadFromFile('.\Resource\Logo\' + g_MapName + '.png');
    MemoryStream.Position := 0;
    Bitmap := ImageBg.Picture.Bitmap;
    Bitmap.PixelFormat := pf32bit;
    Try
      LoadPNGtoBMP(MemoryStream, Bitmap);
    Finally
      MemoryStream.Free;
    End;
  end;
end;       }

procedure TFormMain.ShowHintMsg(sMsg: string);
begin
  LabelLog.Caption := sMsg;
end;

procedure TFormMain.tmrCheckTimer(Sender: TObject);
var
  I, nCount: Integer;
begin
  nCount := 0;
  for I := Low(FClientList) to High(FClientList) do begin
    if FClientList[I] <> 0 then begin
      if SendMessage(FClientList[I], WM_CHECK_CLIENT, Handle, MSG_CHECK_CLIENT_TEST) <= 0 then begin
        FClientList[I] := 0;
      end else Inc(nCount);
    end;
  end;
  if (nCount <= 0) and (FboHide) then
    Close;
end;

procedure TFormMain.tmrStartTimer(Sender: TObject);
//var
//  sUrl: string;
begin
  tmrStart.Enabled := False;
  if FboLoad then Exit;
  FboLoad := True;
  SetCurrentDir(g_CurrentDir);
  CreateShortCut(g_SelfName, g_TitleName);
  CreateDir(g_CurrentDir + 'Resource\');
  //CreateDir('.\Resource\Logo\');
  {if DirectoryExists('.\Resource\') then begin
    sUrl := 'http://www.mir2k.com/Loginframe/';
  end
  else begin
    CreateDir('.\Resource\');
    sUrl := 'http://www.mir2k.com/Loginframe/?first=1';
  end;  }
  SendMessage(Handle, WM_WRITELOGO, 0, 0);
  ShowHintMsg('正在获取服务器列表信息...');
  UpdateThread := TUpdateThread.Create(Handle, True);
  UpdateThread.FreeOnTerminate := True;
  UpdateThread.Resume;
  
end;

procedure TFormMain.TreeViewServerChange(Sender: TObject; Node: TTreeNode);
var
  sAddr, sPort, sAddrs, sPorts: string;
  nPort, I, K: Integer;
begin
  if not boAllReadOK then exit;

  if Node.Data <> nil then begin
    SelectServerInfo := pTLServerInfo(Node.Data);
    SelectServerInfo.boCheck := False;
    BtnPlay.Enabled := False;
    BtnPlay.Refresh;
    LabelLog.Font.Color := clYellow;
    LabelLog.Caption := '正在检测服务器状态...';
    SelectServerInfo.nIndex := GetCheckIndex;
    FCheckCount := 0;
    for I := Low(SelectServerInfo.Info) to High(SelectServerInfo.Info) do begin
      if SelectServerInfo.Info[I].sAddrs = '' then break;
      sAddrs := SelectServerInfo.Info[I].sAddrs;
      sPorts := SelectServerInfo.Info[I].sPort;
      K := 0;
      while True do begin
        if K > 9 then break;
        sAddrs := GetValidStr3(sAddrs, sAddr, [',']);
        sPorts := GetValidStr3(sPorts, sPort, [',']);
        nPort := StrToIntDef(sPort, -1);
        if (sAddr <> '') and (nPort > 0) and (nPort < 65535) then begin
          Inc(K);
          Inc(FCheckCount);
          CreateClientSocket(sAddr, nPort, SelectServerInfo.nIndex);
        end
        else
          Break;
      end;
    end;
  end
  else begin
    LabelLog.Font.Color := clYellow;
    LabelLog.Caption := '请先选择服务器...';
    SelectServerInfo := nil;
    FormMain.BtnPlay.Enabled := False;
    FormMain.BtnPlay.Refresh;
  end;
end;

procedure TFormMain.TreeViewServerChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
begin
  if (not boAllReadOK) then begin
    AllowChange := False;
  end;
end;

procedure TFormMain.TreeViewServerCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if Node.Level = 0 then begin
    Sender.Canvas.Font.Color := clLime;
  end;
end;

procedure TFormMain.WebBrowserDownloadBegin(Sender: TObject);
begin
  WebBrowser.Silent := True;
end;

procedure TFormMain.WebBrowserNavigateComplete2(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
begin
  WebBrowser.Silent := True;
end;

end.

