unit FrmAdd;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, WIL, GraphicEx, PNGImage,
  Dialogs, StdCtrls, ComCtrls, TeCanvas, ExtCtrls, Spin, Gauges, Mask, RzEdit, RzStatus, RzPrgres, wmMyImage;

type
  pTFileListInfo = ^TFileListInfo;
  TFileListInfo = packed record
    FileName: string;
    nPx: SmallInt;
    nPy: SmallInt;
    btFormat: Byte;
  end;

  TFormAdd = class(TForm)
    GroupBox1: TGroupBox;
    ImageStream: TRadioButton;
    WavaStream: TRadioButton;
    DataStream: TRadioButton;
    GroupBox2: TGroupBox;
    File_List: TListBox;
    ImageOption: TGroupBox;
    GroupBox4: TGroupBox;
    Mode_after: TRadioButton;
    Mode_Insert: TRadioButton;
    Mode_Bestrow: TRadioButton;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    File_Add: TButton;
    File_Del: TButton;
    File_Clear: TButton;
    GroupBox7: TGroupBox;
    Image_ImgAndOffset: TRadioButton;
    Image_Img: TRadioButton;
    Image_Offset: TRadioButton;
    GroupBox6: TGroupBox;
    Image_Offset_File: TRadioButton;
    Image_Offset_App: TRadioButton;
    Image_Offset_AppData: TEdit;
    Image_Alpha: TCheckBox;
    Image_RLE: TCheckBox;
    Image_Cut: TCheckBox;
    Label1: TLabel;
    File_Begin: TButton;
    WavaOption: TGroupBox;
    DataOption: TGroupBox;
    OpenDialog: TOpenDialog;
    ProgressBar: TProgressBar;
    Image_TColor: TRzColorEdit;
    Index_Start: TSpinEdit;
    Index_End: TSpinEdit;
    File_AddDIR: TButton;
    NoneOption: TGroupBox;
    Label6: TLabel;
    None_Count: TSpinEdit;
    NoneStream: TRadioButton;
    Image_Blend: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Image_Format: TComboBox;
    Image_Window: TCheckBox;
    GroupBox8: TGroupBox;
    Wava_ZIP: TCheckBox;
    Label4: TLabel;
    Wava_ZIP_Level: TSpinEdit;
    GroupBox9: TGroupBox;
    Data_ZIP: TCheckBox;
    Label5: TLabel;
    Data_ZIP_Level: TSpinEdit;
    File_AddDIRALL: TButton;
    Image_Format_byFile: TCheckBox;
    procedure ImageStreamClick(Sender: TObject);
    procedure File_BeginClick(Sender: TObject);
    procedure File_AddClick(Sender: TObject);
    procedure File_ClearClick(Sender: TObject);
    procedure File_DelClick(Sender: TObject);
    procedure File_AddDIRClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image_BlendChange(Sender: TObject);
    procedure File_AddDIRALLClick(Sender: TObject);
  private
    //    FFileList: TStringList;
    //    FImageOffsetList: TStringList;
    procedure ChangeControl(boBegin: Boolean = False);
    function LoadFileToBmp(sFileName: string): TBitmap;

    function FormatBitmap(const Bitmap: TBitmap; boAlpha, boRLE, boCut: Boolean; BColor: TColor; var Data: PChar;
      WILColorFormat: TWILColorFormat): Integer;
    function FormatData(sFileName: string; boZIP: Boolean; nZIPLevel, nSize: Integer; var Data: PChar): Integer;
    function CheckWavaData(sFileName: string): Integer;
    function EncodeRLE(const Source, Target: Pointer; Count: Integer; bitLength: Byte): Integer;
  public
    procedure Open();
    procedure WriteToFile(DataBuffer: PChar; DataLen, nW, nY: Integer);
  end;

var
  FormAdd: TFormAdd;

implementation
uses
  ZShare, HUtil32, FrmMain;

{$R *.dfm}

{ TFormAdd }

procedure TFormAdd.ChangeControl(boBegin: Boolean);
begin
  ImageStream.Enabled := not boBegin;
  WavaStream.Enabled := not boBegin;
  DataStream.Enabled := not boBegin;
  NoneStream.Enabled := not boBegin;

  File_Begin.Enabled := not boBegin;
  File_Add.Enabled := not boBegin;
  File_AddDIR.Enabled := not boBegin;
  File_AddDIRAll.Enabled := not boBegin;
  File_Del.Enabled := (not boBegin) and (File_List.ItemIndex <> -1);
  File_Clear.Enabled := (not boBegin) and (File_List.Items.Count > 0);

  ImageOption.Visible := ImageStream.Checked;
  WavaOption.Visible := WavaStream.Checked;
  DataOption.Visible := DataStream.Checked;
  NoneOption.Visible := NoneStream.Checked;

  Mode_after.Enabled := (not boBegin);
  Mode_Insert.Enabled := (not boBegin);
  Mode_Bestrow.Enabled := (not boBegin);
  Index_End.Enabled := False;
  if NoneOption.Visible then begin
    None_Count.Enabled := (not boBegin);
    if Mode_Bestrow.Checked then begin
      Mode_Bestrow.Checked := False;
      Mode_after.Checked := True;
    end;
    Mode_Bestrow.Enabled := False;
  end
  else if DataOption.Visible then begin
    Data_ZIP_Level.Enabled := (not boBegin) and Data_ZIP.Checked;
    label5.Enabled := Data_ZIP_Level.Enabled;
  end
  else if WavaOption.Visible then begin
    //Wava_WAVA.Enabled := not boBegin;
    //Wava_MP3.Enabled := not boBegin;
    Wava_ZIP_Level.Enabled := (not boBegin) and Wava_ZIP.Checked;
    label4.Enabled := Wava_ZIP_Level.Enabled;
  end
  else if ImageOption.Visible then begin
    Image_ImgAndOffset.Enabled := not boBegin;
    Image_Blend.Enabled := (not boBegin) and (not Image_Offset.Checked);
    Label7.Enabled := Image_Blend.Enabled;
    Image_Format_byFile.Enabled := (not boBegin) and (Image_ImgAndOffset.Checked) and (Image_Offset_File.Checked) and (not Image_Window.Checked);
    Image_Format_byFile.Checked := (Image_ImgAndOffset.Checked) and (Image_Offset_File.Checked) and Image_Format_byFile.Checked and (not Image_Window.Checked);
    Image_Format.Enabled := (not boBegin) and (not Image_Offset.Checked) and (not Image_Window.Checked) and
      (not Image_Format_byFile.Checked);
    if Image_Window.Checked then
      Image_Format.ItemIndex := 0;
    Label8.Enabled := Image_Format.Enabled;

    if Image_Format.ItemIndex in [3] then
      Image_Alpha.Checked := True
    else
      Image_Alpha.Checked := ((Image_Format.ItemIndex in [0]) and Image_Alpha.Checked) or Image_Format_byFile.Checked;
    Image_Img.Enabled := not boBegin;
    Image_Offset.Enabled := not boBegin;
    Image_Alpha.Enabled := (not boBegin) and (not Image_Offset.Checked) and (Image_Format.ItemIndex in [0]) and (not
      Image_Window.Checked) and (not Image_Format_byFile.Checked);
    Image_RLE.Enabled := (not boBegin) and (not Image_Offset.Checked);
    Image_Cut.Enabled := (not boBegin) and (not Image_Offset.Checked);
    //Image_Com.Enabled := (not boBegin) and (not Image_Offset.Checked) and (not Image_Alpha.Checked);
    Image_TColor.Enabled := (not boBegin) and (not Image_Offset.Checked) and (not Image_Alpha.Checked) and (Image_Format.ItemIndex
      <> 2);
    Label1.Enabled := Image_TColor.Enabled;
    Image_Offset_File.Enabled := (not boBegin) and (not Image_Img.Checked);
    Image_Offset_App.Enabled := (not boBegin) and (not Image_Img.Checked);
    Image_Offset_AppData.Enabled := (not boBegin) and (not Image_Img.Checked) and (Image_Offset_App.Checked);
    Image_Window.Enabled := (not boBegin) and (not Image_Alpha.Checked) and (not Image_Offset.Checked);

    if Image_Offset.Checked then
      Image_Offset_File.Caption := '使用文件列表'
    else
      Image_Offset_File.Caption := '同名坐标文件';

    Mode_after.Enabled := (not boBegin) and (Image_ImgAndOffset.Checked { or Image_Img.Checked});
    Mode_Insert.Enabled := (not boBegin) and (Image_ImgAndOffset.Checked { or Image_Img.Checked});
    Mode_Bestrow.Enabled := (not boBegin) and (Image_ImgAndOffset.Checked or Image_Img.Checked or Image_Offset.Checked);

    Mode_after.Checked := Mode_after.Checked and (not Image_Offset.Checked) and (not Image_Img.Checked);
    Mode_Insert.Checked := Mode_Insert.Checked and (not Image_Offset.Checked) and (not Image_Img.Checked);
    Mode_Bestrow.Checked := Mode_Bestrow.Checked or Image_Offset.Checked or Image_Img.Checked;

    Index_End.Enabled := (not boBegin) and Image_Offset.Checked and Image_Offset_App.Checked;
  end;

  Index_Start.Enabled := (not boBegin) and (Mode_Insert.Checked or Mode_Bestrow.Checked);
  Label2.Enabled := Index_Start.Enabled;
  Label3.Enabled := Index_End.Enabled;
  if not Index_End.Enabled then
    Index_End.Value := Index_Start.Value + (File_List.Count - 1);
  GroupBox2.Caption := '文件列表(' + IntToStr(File_List.Count) + ')';

end;

procedure TFormAdd.File_AddClick(Sender: TObject);
var
  i: integer;
  FileName, FIdxFile {, TempStr, sX, sY}: string;
  TempList: TStringList;
  FileListInfo: pTFileListInfo;
begin
  OpenDialog.FileName := '';
  if OpenDialog.Execute(Handle) and (OpenDialog.FileName <> '') and (OpenDialog.Files.Count > 0) then begin
    ChangeControl(True);
    File_List.Visible := False;
    TempList := TStringList.Create;
    ProgressBar.Max := OpenDialog.Files.Count;
    try
      for I := 0 to OpenDialog.Files.Count - 1 do begin
        FileName := ExtractFileName(OpenDiaLog.Files[i]);
        New(FileListInfo);
        FileListInfo.FileName := OpenDiaLog.Files[i];
        FileListInfo.nPx := 0;
        FileListInfo.nPy := 0;
        FileListInfo.btFormat := 0;
        File_List.Items.AddObject(FileName, TObject(FileListInfo));
        FIdxFile := ExtractFilePath(Filename) + IMAGEOFFSETDIR + ExtractFileNameOnly(FileName) + '.txt';
        if FileExists(FIdxFile) then begin
          TempList.LoadFromFile(FIdxFile);
          if TempList.Count > 1 then begin
            //TempStr := Templist[0];
            //TempStr := GetValidStr3(TempStr, Templist[0], [' ', ',']);
            //TempStr := GetValidStr3(TempStr, sY, [' ', ',']);
            FileListInfo.nPx := StrToIntDef(Templist[0], 0);
            FileListInfo.nPy := StrToIntDef(Templist[1], 0);
            if TempList.Count > 2 then
              FileListInfo.btFormat := StrToIntDef(Templist[2], 0);
          end;
        end;
        ProgressBar.Position := I + 1;
      end;
    finally
      TempList.Free;
      File_List.Visible := True;
      ChangeControl();
    end;
  end;

end;

procedure TFormAdd.File_AddDIRALLClick(Sender: TObject);
var
  sStr: string;
  sr: TSearchRec;
  I: Integer;
  FIdxFile, sDir: string;
  TempList, DirList, DirNameList: TStringList;
  FileListInfo: pTFileListInfo;
begin
  sStr := BrowseForFolder(Handle, '请选择文件夹');
  if sStr <> '' then begin
    if RightStr(sStr, 1) <> '\' then
      sStr := sStr + '\';
    ChangeControl(True);
    File_List.Visible := False;
    TempList := TStringList.Create;
    DirList := TStringList.Create;
    DirNameList := TStringList.Create;
    DirList.Add(sStr);
    DirNameList.Add(' ');

    try
      while DirList.Count > 0 do begin
        sStr := Trim(DirList[0]);
        DirList.Delete(0);
        sDir := Trim(DirNameList[0]);
        DirNameList.Delete(0);
        I := FindFirst(sStr + '*.*', faAnyFile or faDirectory, sr);
        try
          while i = 0 do begin
            if (Sr.Attr and faDirectory) = faDirectory then begin
              if (sr.Name[1] <> '.') and (sr.Name[1] <> '..') then begin
                DirNameList.Add(sDir + sr.Name + '_');
                DirList.Add(sStr + sr.Name + '\');
              end;
            end
            else if (Sr.Attr and faDirectory) = 0 then begin
              if sr.Name[1] <> '.' then begin
                New(FileListInfo);
                FileListInfo.FileName := sStr + sr.Name;
                FileListInfo.nPx := 0;
                FileListInfo.nPy := 0;
                FileListInfo.btFormat := 0;
                File_List.Items.AddObject(sDir + sr.Name, TObject(FileListInfo));
                FIdxFile := sStr + IMAGEOFFSETDIR + ExtractFileNameOnly(sr.Name) + '.txt';
                if FileExists(FIdxFile) then begin
                  TempList.LoadFromFile(FIdxFile);
                  if TempList.Count > 1 then begin
                    FileListInfo.nPx := StrToIntDef(Templist[0], 0);
                    FileListInfo.nPy := StrToIntDef(Templist[1], 0);
                    if TempList.Count > 2 then
                      FileListInfo.btFormat := StrToIntDef(Templist[2], 0);
                  end;
                end;
              end;
            end;
            i := FindNext(sr);
          end;
        finally
          FindClose(sr);
        end;
      end;
    finally
      TempList.Free;
      DirList.Free;
      File_List.Visible := True;
      ChangeControl();
      DirNameList.Free;
    end;

  end;
end;

procedure TFormAdd.File_AddDIRClick(Sender: TObject);
var
  sStr: string;
  sr: TSearchRec;
  I: Integer;
  FIdxFile {, TempStr, sX, sY}: string;
  TempList: TStringList;
  FileListInfo: pTFileListInfo;
begin
  sStr := BrowseForFolder(Handle, '请选择文件夹');
  if sStr <> '' then begin
    if RightStr(sStr, 1) <> '\' then
      sStr := sStr + '\';
    ChangeControl(True);
    File_List.Visible := False;
    TempList := TStringList.Create;
    I := FindFirst(sStr + '*.*', faAnyFile, sr);
    try
      while i = 0 do begin
        if (Sr.Attr and faDirectory) = 0 then begin
          if sr.Name[1] <> '.' then begin
            New(FileListInfo);
            FileListInfo.FileName := sStr + sr.Name;
            FileListInfo.nPx := 0;
            FileListInfo.nPy := 0;
            FileListInfo.btFormat := 0;
            File_List.Items.AddObject(sr.Name, TObject(FileListInfo));
            FIdxFile := sStr + IMAGEOFFSETDIR + ExtractFileNameOnly(sr.Name) + '.txt';
            if FileExists(FIdxFile) then begin
              TempList.LoadFromFile(FIdxFile);
              if TempList.Count > 1 then begin
                FileListInfo.nPx := StrToIntDef(Templist[0], 0);
                FileListInfo.nPy := StrToIntDef(Templist[1], 0);
                if TempList.Count > 2 then
                  FileListInfo.btFormat := StrToIntDef(Templist[2], 0);
              end;
            end;
          end;
        end;
        i := FindNext(sr);
      end;
    finally
      FindClose(sr);
      TempList.Free;
      File_List.Visible := True;
      ChangeControl();
    end;

  end;
end;

procedure TFormAdd.File_BeginClick(Sender: TObject);
const
  MAXBUFFERLEN = 1024 * 1024 * 50;
  MAXFILESIZE = 1024 * 1024 * 10;
var
  i, X, Y, nX, nY: Integer;
  StartInt, EndInt, StartPos, EndPos: Integer;
  TempStr, sX, sY: string;
  AddBufferCount: Integer;
  BufferLen, DataBufferLen: Integer;
  Buffer, DataBuffer: PChar;
  Bitmap: TBitmap;
  OffsetList: TList;
  OffsetStrList: TStringList;
  ImageInfo: wmMyImage.TWMImageInfo;
  WMImages: wmMyImage.TWMMyImageImages;
  FileListInfo: pTFileListInfo;
  btXS, btYS: Byte;
  nProgress: Integer;
  btFormat: Byte;
begin
  if (g_WMImages = nil) or (not g_WMImages.boInitialize) or (g_WMImages.ReadOnly) or (not (g_WMImages is TWMMyImageImages)) then
    exit;
  WMImages := TWMMyImageImages(g_WMImages);
  StartInt := Index_Start.Value;
  EndInt := Index_End.Value;

  TempStr := Image_Offset_AppData.Text;
  TempStr := GetValidStr3(TempStr, sX, [' ', ',']);
  TempStr := GetValidStr3(TempStr, sY, [' ', ',']);
  X := StrToIntDef(sX, 0);
  Y := StrToIntDef(sY, 0);
  btFormat := 0;

  if Mode_Insert.Checked and (StartInt >= g_WMImages.ImageCount) then begin
    Application.MessageBox('起始编号设置错误', '提示信息！', MB_OK or MB_ICONASTERISK);
    exit;
  end;
  if Mode_Bestrow.Checked and (EndInt >= g_WMImages.ImageCount) then begin
    Application.MessageBox('结束编号设置错误', '提示信息！', MB_OK or MB_ICONASTERISK);
    exit;
  end;

  if ImageStream.Checked and Image_Offset.Checked and Image_Offset_App.Checked then begin
    TempStr := Image_Offset_AppData.Text;
    TempStr := GetValidStr3(TempStr, sX, [' ', ',']);
    TempStr := GetValidStr3(TempStr, sY, [' ', ',']);
    sX := Trim(sX);
    sY := Trim(sY);
    if (sX = '') or (sY = '') then begin
      Application.MessageBox('坐标设置不正确，无法更新！', '提示信息！', MB_OK or MB_ICONASTERISK);
      exit;
    end;
    case sX[1] of
      '+': begin
          btXS := 1;
          sX := Copy(sX, 2, Length(sX) - 1);
        end;
      '_': begin
          btXS := 2;
          sX := Copy(sX, 2, Length(sX) - 1);
        end
    else
      btXS := 3;
    end;
    case sY[1] of
      '+': begin
          btYS := 1;
          sY := Copy(sY, 2, Length(sY) - 1);
        end;
      '_': begin
          btYS := 2;
          sY := Copy(sY, 2, Length(sY) - 1);
        end
    else
      btYS := 3;
    end;
    X := StrToIntDef(sX, 0);
    Y := StrToIntDef(sY, 0);
    if (btXS = 3) and (btYS = 3) then begin
      for I := StartInt to EndInt do begin
        WMImages.UpdateImageXY(I, X, Y);
      end;
    end
    else begin
      for I := StartInt to EndInt do begin

        WMImages.GetImageXY(I, nX, nY);
        case btXS of
          1: nX := nX + X;
          2: nX := nX - X;
          3: nX := X;
        end;
        case btYS of
          1: nY := nY + Y;
          2: nY := nY - Y;
          3: nY := Y;
        end;
        WMImages.UpdateImageXY(I, nX, nY);
      end;
    end;
    FormMain.DrawGrid.RowCount := g_WMImages.ImageCount div 6 + 1;
    FormMain.DrawGrid.Repaint;
    if Application.MessageBox('执行完成，是否退出导入界面？', '提示信息', MB_OKCANCEL + MB_ICONQUESTION) = IDOK
      then begin
      Close;
    end;
    exit;
  end;

  if Mode_Bestrow.Checked and ((EndInt - StartInt) <> File_List.Items.Count - 1) then begin
    Application.MessageBox('文件数量与编号设置不相同，无法完成覆盖！', '提示信息', MB_OK or
      MB_ICONASTERISK);
    exit;
  end;

  if NoneStream.Checked then begin
    for I := 0 to None_Count.Value - 1 do begin
      if Mode_after.Checked then begin
        g_WMImages.AddIndex(-1, 0);
      end
      else if Mode_Insert.Checked then begin
        g_WMImages.AddIndex(StartInt, 0);
      end;
    end;
    g_WMImages.SaveIndexList;
    FormMain.DrawGrid.RowCount := g_WMImages.ImageCount div 6 + 1;
    FormMain.DrawGrid.Repaint;
    if Application.MessageBox('执行完成，是否退出导入界面？', '提示信息', MB_OKCANCEL + MB_ICONQUESTION) = IDOK
      then begin
      Close;
    end;
    exit;
  end;
  if (File_List.Items.Count <= 0) then begin
    Application.MessageBox('请先选项要打包的文件！', '提示信息', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  ChangeControl(True);
  ProgressBar.Max := 100{File_List.Items.Count};
  nProgress := 0;
  ProgressBar.Position := 0;

  //建立缓冲
  BufferLen := 0;
  AddBufferCount := StartInt;
  GetMem(Buffer, MAXBUFFERLEN);
  OffsetList := TList.Create;
  OffsetStrList := TStringList.Create;
  DataBuffer := nil;
  Bitmap := nil;
  try
    {
      以下为自己使用的方式
      如果说用于玩家动态增加或修改打包文件数据,不采用清除原数据
      直接在尾部增加数据,更改索引值既可
      采用该方式的好处是可以加快修改数据的速度,坏处是文件是不断增大
    }
      //for nI := 0 to File_List.Items.Count - 1 do begin
    for I := 0 to File_List.Items.Count - 1 do begin
      {BufferLen := 0;
      AddBufferCount := StartInt;
      OffsetList.Clear;
      OffsetStrList.Clear;
      DataBuffer := nil;
      Bitmap := nil;    }
      {if i = 11955 then begin
        FileListInfo := pTFileListInfo(File_List.Items.Objects[I]);
      end;     }
      FileListInfo := pTFileListInfo(File_List.Items.Objects[I]);
      {AddBufferCount := StrToIntDef(ExtractFileNameOnly(FileListInfo.FileName), -1);
      if AddBufferCount = -1 then Continue;
      StartInt := AddBufferCount;
      EndInt := AddBufferCount;  }
      if DataBuffer <> nil then begin
        FreeMem(DataBuffer);
      end;
      if Bitmap <> nil then begin
        Bitmap.Free;
      end;
      DataBuffer := nil;
      Bitmap := nil;
      DataBufferLen := 0;
      if ImageStream.Checked then begin
        if Image_Offset.Checked then begin //更新坐标
          X := 0;
          Y := 0;
          try
            OffsetStrList.LoadFromFile(FileListInfo.FileName);
            if OffsetStrList.Count > 0 then begin
              TempStr := OffsetStrList[0];
              TempStr := GetValidStr3(TempStr, sX, [' ', ',']);
              TempStr := GetValidStr3(TempStr, sY, [' ', ',']);
              X := StrToIntDef(sX, 0);
              Y := StrToIntDef(sY, 0);
            end;
          except
          end;
          WMImages.UpdateImageXY(StartInt + I, X, Y);
        end
        else begin //更新图片和坐标
          if Image_ImgAndOffset.Checked and Image_Offset_File.Checked then begin
            X := FileListInfo.nPx;
            Y := FileListInfo.nPy;
            btFormat := FileListInfo.btFormat;
          end;
          try
            Bitmap := LoadFileToBmp(FileListInfo.FileName); //将不同类型的图型文件转换为BMP类型
          except
            Bitmap := nil;
          end;
          if Bitmap = nil then begin
            if Application.MessageBox(PChar(FileListInfo.FileName + #13#10 + '未支持该文件类型或格式不正确，是否继续？'),
              '提示信息', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then begin
              if Mode_after.Checked then begin
                WMImages.AddIndex(-1, 0);
              end
              else if Mode_Insert.Checked then begin
                OffsetList.Add(Pointer(-1));
              end
              else if Mode_Bestrow.Checked then begin
                OffsetList.Add(Pointer(-1));
              end;
              Continue;
            end
            else
              break;
          end;
          if (Bitmap.Width < MINIMAGESIZE) or (Bitmap.Height < MINIMAGESIZE) or (Bitmap.Width > MAXIMAGESIZE) or (Bitmap.Height > MAXIMAGESIZE) then begin
            if Mode_after.Checked then begin
              g_WMImages.AddIndex(-1, 0);
            end
            else if Mode_Insert.Checked then begin
              OffsetList.Add(Pointer(-1));
            end
            else if Mode_Bestrow.Checked then begin
              OffsetList.Add(Pointer(-1));
            end;
            Continue;
          end
          else begin
            //将图型数据转换为存储数据
            DataBufferLen := FormatBitmap(Bitmap, Image_Alpha.Checked, Image_RLE.Checked, Image_Cut.Checked,
              Image_TColor.SelectedColor, DataBuffer, TWILColorFormat(Image_Format.ItemIndex));
            if Image_ImgAndOffset.Checked then begin
              FillChar(ImageInfo, SizeOf(ImageInfo), #0);
              ImageInfo.DXInfo.px := X;
              ImageInfo.DXInfo.py := Y;
            end
            else begin
              ImageInfo := WMImages.GetDataImageInfo(StartInt + I);
            end;
            // fixme 只是用来生成 Logo 数组
            WriteToFile(DataBuffer, DataBufferLen, Bitmap.Width, Bitmap.Height);
            ImageInfo.DXInfo.nWidth := Bitmap.Width;
            ImageInfo.DXInfo.nHeight := Bitmap.Height;
            ImageInfo.btFileType := FILETYPE_IMAGE;
            ImageInfo.boEncrypt := Image_RLE.Checked;
            ImageInfo.nDataSize := DataBufferLen;
            ImageInfo.nDrawBlend := Integer(Image_Blend.Items.Objects[Image_Blend.ItemIndex]);
            if Image_Format_byFile.Checked then begin
              ImageInfo.btImageFormat := TWILColorFormat(btFormat);
            end else begin
              ImageInfo.btImageFormat := TWILColorFormat(Image_Format.ItemIndex);
            end;
          end;
          if Bitmap <> nil then begin
            Bitmap.Free;
            Bitmap := nil;
          end;
        end;
      end
      else if WavaStream.Checked then {//音频数据处理} begin
        try
          FillChar(ImageInfo, SizeOf(ImageInfo), #0);
          ImageInfo.btFileType := CheckWavaData(FileListInfo.FileName);
          if ImageInfo.btFileType = 0 then begin
            if Application.MessageBox(PChar(FileListInfo.FileName + #13#10 +
              '未支持该文件类型或格式不正确，是否继续？'),
              '提示信息', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then begin
              if Mode_after.Checked then begin
                g_WMImages.AddIndex(-1, 0);
              end
              else if Mode_Insert.Checked then begin
                OffsetList.Add(Pointer(-1));
              end
              else if Mode_Bestrow.Checked then begin
                OffsetList.Add(Pointer(-1));
              end;
              Continue;
            end
            else
              break;
          end;

          DataBufferLen := FileSize(FileListInfo.FileName);
          if (DataBufferLen > MAXFILESIZE) or (DataBufferLen <= 0) then begin
            if MessageBox(Handle, PChar(FileListInfo.FileName + #13#10 +
              '文件超出大小限制，数据大小(' + IntToStr(DataBufferLen) + ')，是否继续？'),
              '提示信息', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then begin
              if Mode_after.Checked then begin
                g_WMImages.AddIndex(-1, 0);
              end
              else if Mode_Insert.Checked then begin
                OffsetList.Add(Pointer(-1));
              end
              else if Mode_Bestrow.Checked then begin
                OffsetList.Add(Pointer(-1));
              end;
              Continue;
            end
            else
              break;
          end;

          DataBufferLen := FormatData(FileListInfo.FileName, Wava_ZIP.Checked, Wava_ZIP_Level.Value, DataBufferLen,
            DataBuffer);
          ImageInfo.boEncrypt := Wava_ZIP.Checked;
          ImageInfo.nDataSize := DataBufferLen;
          {DataBufferLen := FormatWavaData(FileListInfo.FileName, Wava_ZIP.Checked, Wava_ZIP_Level.Value, DataBuffer);
          if (DataBufferLen > MAXFILESIZE) or (DataBufferLen <= 0) then begin
            if MessageBox(Handle, PChar(FileListInfo.FileName + #13#10 +
              '文件超出大小限制，数据大小(' + IntToStr(DataBufferLen) + ')，是否继续？'),
              '提示信息', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then
            begin
              if Mode_after.Checked then begin
                g_WMImages.AddIndex(-1, 0);
              end
              else if Mode_Insert.Checked then begin
                OffsetList.Add(Pointer(-1));
              end
              else if Mode_Bestrow.Checked then begin
                OffsetList.Add(Pointer(-1));
              end;
              Continue;
            end else break;
          end;
          FillChar(ImageInfo, SizeOf(ImageInfo), #0);
          ImageInfo.btFileType := FILETYPE_WAVA;
          ImageInfo.boEncrypt := Wava_ZIP.Checked;
          ImageInfo.nDataSize := DataBufferLen;    }
        except
          DataBufferLen := 0;
        end;
        if DataBufferLen = 0 then begin
          if Application.MessageBox(PChar(FileListInfo.FileName + #13#10 + '压缩该文件错误，是否继续？'),
            '提示信息', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then begin
            if Mode_after.Checked then begin
              g_WMImages.AddIndex(-1, 0);
            end
            else if Mode_Insert.Checked then begin
              OffsetList.Add(Pointer(-1));
            end
            else if Mode_Bestrow.Checked then begin
              OffsetList.Add(Pointer(-1));
            end;
            Continue;
          end
          else
            break;
        end;
      end
      else if DataStream.Checked then begin //数据处理
        try
          DataBufferLen := FileSize(FileListInfo.FileName);
          if (DataBufferLen > MAXFILESIZE) or (DataBufferLen <= 0) then begin
            if MessageBox(Handle, PChar(FileListInfo.FileName + #13#10 +
              '文件超出大小限制，数据大小(' + IntToStr(DataBufferLen) + ')，是否继续？'),
              '提示信息', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then begin
              if Mode_after.Checked then begin
                g_WMImages.AddIndex(-1, 0);
              end
              else if Mode_Insert.Checked then begin
                OffsetList.Add(Pointer(-1));
              end
              else if Mode_Bestrow.Checked then begin
                OffsetList.Add(Pointer(-1));
              end;
              Continue;
            end
            else
              break;
          end;
          FillChar(ImageInfo, SizeOf(ImageInfo), #0);
          DataBufferLen := FormatData(FileListInfo.FileName, Data_ZIP.Checked, Data_ZIP_Level.Value, DataBufferLen,
            DataBuffer);
          ImageInfo.btFileType := FILETYPE_DATA;
          ImageInfo.boEncrypt := Data_ZIP.Checked;
          ImageInfo.nDataSize := DataBufferLen;
        except
          DataBufferLen := 0;
        end;
        if DataBufferLen = 0 then begin
          if Application.MessageBox(PChar(FileListInfo.FileName + #13#10 + '压缩该文件错误，是否继续？'),
            '提示信息', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then begin
            if Mode_after.Checked then begin
              g_WMImages.AddIndex(-1, 0);
            end
            else if Mode_Insert.Checked then begin
              OffsetList.Add(Pointer(-1));
            end
            else if Mode_Bestrow.Checked then begin
              OffsetList.Add(Pointer(-1));
            end;
            Continue;
          end
          else
            break;
        end;
      end; //处理结束
      if (DataBufferLen > 0) and (DataBuffer <> nil) then begin
        if DataBufferLen + SizeOf(ImageInfo) > MAXBUFFERLEN then begin
          Application.MessageBox(PChar(FileListInfo.FileName + #13#10 +
            '内存溢出，数据大小(' + IntToStr(DataBufferLen) + ')'), '提示信息', MB_OK + MB_ICONSTOP);
          break;
        end;
        if Mode_after.Checked then begin //尾部增加的数据
          WMImages.AddDataToFile(@ImageInfo, DataBuffer, DataBufferLen);
        end
        else begin
          if (DataBufferLen + SizeOf(ImageInfo) + BufferLen) > MAXBUFFERLEN then begin
            if Mode_Insert.Checked then begin
              StartPos := WMImages.GetDataOffset(AddBufferCount, False);
              if (StartPos <= 0) then begin
                Application.MessageBox('文件索引错误！', '提示信息', MB_OK + MB_ICONSTOP);
                break;
              end;
              AppendData(WMImages.FileName, StartPos, BufferLen); //申请空间
              WMImages.AddDataToFile(StartPos, Buffer, BufferLen);
              WMImages.InsertOffsetToList(OffsetList, AddBufferCount, StartPos, BufferLen);
              Inc(AddBufferCount, OffsetList.Count);
            end
            else begin
              StartPos := WMImages.GetDataOffset(AddBufferCount, False);
              EndPos := WMImages.GetDataOffset(AddBufferCount + OffsetList.Count, False);
              if (StartPos <= 0) or (EndPos <= 0) or (EndPos < StartPos) then begin
                Application.MessageBox('文件索引错误！', '提示信息', MB_OK + MB_ICONSTOP);
                break;
              end;
              if BufferLen > (EndPos - StartPos) then begin
                AppendData(WMImages.FileName, StartPos, BufferLen - (EndPos - StartPos)); //申请空间
              end
              else if BufferLen < (EndPos - StartPos) then begin
                RemoveData(WMImages.FileName, StartPos, (EndPos - StartPos) - BufferLen); //删除空间
              end;
              WMImages.AddDataToFile(StartPos, Buffer, BufferLen);
              WMImages.UpdateOffsetToList(OffsetList, AddBufferCount, StartPos, BufferLen - (EndPos - StartPos));
              Inc(AddBufferCount, OffsetList.Count);
            end;
            BufferLen := 0;
            OffsetList.Clear;
          end;
          OffsetList.Add(Pointer(BufferLen));
          WMImages.FormatImageInfo(@ImageInfo, True);
          Move(ImageInfo, Buffer[BufferLen], SizeOf(ImageInfo));
          Move(DataBuffer^, Buffer[BufferLen + SizeOf(ImageInfo)], DataBufferLen);
          Inc(BufferLen, SizeOf(ImageInfo) + DataBufferLen);
        end;
      end
      else begin
        if Mode_after.Checked then begin
          g_WMImages.AddIndex(-1, 0);
        end
        else if Mode_Insert.Checked then begin
          OffsetList.Add(Pointer(-1));
        end
        else if Mode_Bestrow.Checked then begin
          OffsetList.Add(Pointer(-1));
        end;
      end;
      if DataBuffer <> nil then begin
        FreeMem(DataBuffer);
        DataBuffer := nil;
      end;
      nY := Round(I / File_List.Items.Count * 100);
      if nProgress <> nY then begin
        nProgress := nY;
        ProgressBar.Position := nProgress;
      end;
      Application.ProcessMessages;
    end; //for I := 0 to File_List.Items.Count - 1 do begin
    if (BufferLen > 0) or (OffsetList.Count > 0) then begin
      if Mode_Insert.Checked then begin
        StartPos := WMImages.GetDataOffset(AddBufferCount, False);
        if (StartPos > 0) then begin
          AppendData(WMImages.FileName, StartPos, BufferLen); //申请空间
          WMImages.AddDataToFile(StartPos, Buffer, BufferLen);
          WMImages.InsertOffsetToList(OffsetList, AddBufferCount, StartPos, BufferLen);
        end
        else
          Application.MessageBox('文件索引错误！', '提示信息', MB_OK + MB_ICONSTOP);
      end
      else begin
        StartPos := WMImages.GetDataOffset(AddBufferCount, False);
        EndPos := WMImages.GetDataOffset(AddBufferCount + OffsetList.Count, False);
        if (StartPos > 0) and (EndPos > 0) and (EndPos >= StartPos) then begin
          if BufferLen > (EndPos - StartPos) then begin
            AppendData(WMImages.FileName, StartPos, BufferLen - (EndPos - StartPos)); //申请空间
          end
          else if BufferLen < (EndPos - StartPos) then begin
            RemoveData(WMImages.FileName, StartPos, (EndPos - StartPos) - BufferLen); //删除空间
          end;
          WMImages.AddDataToFile(StartPos, Buffer, BufferLen);
          WMImages.UpdateOffsetToList(OffsetList, AddBufferCount, StartPos, BufferLen - (EndPos - StartPos));
        end
        else
          Application.MessageBox('文件索引错误！', '提示信息', MB_OK + MB_ICONSTOP);
      end;
    end;
    {if Bitmap <> nil then
      Bitmap.Free;
    if DataBuffer <> nil then begin
      FreeMem(DataBuffer);
    end;
    Bitmap := nil;
    DataBuffer := nil;        }
  //end;
    WMImages.SaveIndexList;
    FormMain.DrawGrid.RowCount := g_WMImages.ImageCount div 6 + 1;
    FormMain.DrawGrid.Repaint;
  finally
    if Bitmap <> nil then
      Bitmap.Free;
    if DataBuffer <> nil then begin
      FreeMem(DataBuffer);
    end;
    OffsetList.Free;
    OffsetStrList.Free;
    FreeMem(Buffer);
    ChangeControl(False);
  end;
  if MessageBox(Handle, '执行完成，是否退出导入界面？', '提示信息', MB_OKCANCEL + MB_ICONQUESTION) = IDOK then
    begin
    Close;
  end;
end;

function TFormAdd.EncodeRLE(const Source, Target: Pointer; Count: Integer; bitLength: Byte): Integer;
var
  i: Integer;
  DiffCount, // pixel count until two identical
  SameCount: Integer; // number of identical adjacent pixels
  SourcePtr,
  TargetPtr: PByte;
begin
  Result := 0;
  SourcePtr := Source;
  TargetPtr := Target;
  while Count > 0 do begin
    DiffCount := CountDiffPixels(SourcePtr, bitLength, Count);
    SameCount := CountSamePixels(SourcePtr, bitLength, Count);
    if DiffCount > 128 then
      DiffCount := 128;
    if SameCount > 128 then
      SameCount := 128;
    if DiffCount > 0 then begin
      TargetPtr^ := DiffCount - 1;
      Inc(TargetPtr);
      Dec(Count, DiffCount);
      Inc(Result, (DiffCount * bitLength) + 1);
      while DiffCount > 0 do begin
        for i := 0 to bitLength - 1 do
        begin
          TargetPtr^ := SourcePtr^;
          Inc(SourcePtr);
          Inc(TargetPtr);
        end;  
        Dec(DiffCount);
      end;
    end;
    if SameCount > 1 then begin
      TargetPtr^ := (SameCount - 1) or $80;
      Inc(TargetPtr);
      Dec(Count, SameCount);
      Inc(Result, bitLength + 1);
      Inc(SourcePtr, (SameCount - 1) * bitLength);
      for i := 0 to bitLength - 1 do
      begin
        TargetPtr^ := SourcePtr^;
        Inc(SourcePtr);
        Inc(TargetPtr);
      end;
    end;
  end;
end;

procedure TFormAdd.File_ClearClick(Sender: TObject);
var
  i: integer;
begin
  for I := 0 to File_List.Items.Count - 1 do begin
    Dispose(pTFileListInfo(File_List.Items.Objects[I]))
  end;
  File_List.Items.Clear;
  ChangeControl();
end;

procedure TFormAdd.File_DelClick(Sender: TObject);
var
  i: integer;
begin
  for I := File_List.Count - 1 downto 0 do begin
    if File_List.Selected[I] then begin
      Dispose(pTFileListInfo(File_List.Items.Objects[I]));
      File_List.Items.Delete(I);
    end;
  end;
  ChangeControl();
end;

procedure TFormAdd.ImageStreamClick(Sender: TObject);
begin
  ChangeControl();
end;

procedure TFormAdd.Image_BlendChange(Sender: TObject);
var
  nBlend: LongWord;
begin
  if Image_Blend.ItemIndex = g_CustomIndex then begin
    nBlend := StrToIntDef(InputBox('混合', '请输入混合模式', '$' +
      IntToHex(Cardinal(Image_Blend.Items.Objects[Image_Blend.ItemIndex]), 8)), 0);
    Image_Blend.Items.Objects[Image_Blend.ItemIndex] := Pointer(nBlend);
  end;
end;

function TFormAdd.LoadFileToBmp(sFileName: string): TBitmap;
const
  PngHeader: array[0..7] of Char = (#137, #80, #78, #71, #13, #10, #26, #10);
var
  FileStream: TFileStream;
  ChrBuff: array[0..7] of Char;
begin
  Result := nil;
  FileStream := TFileStream.Create(sFileName, fmOpenRead or fmShareDenyNone);
  try
    FileStream.Read(ChrBuff[0], SizeOf(ChrBuff));
    FileStream.Seek(0, 0);               
    if (ChrBuff[0] + ChrBuff[1]) = 'BM' then begin //BMP
      Result := TBitmap.Create; //TTargaGraphic
      Result.LoadFromStream(FileStream);
    end
    else if ChrBuff = PngHeader then begin
      Result := TBitmap.Create;
      LoadPNGtoBMP(FileStream, Result);
    end
    else if CompareText(RightStr(sFileName, 3), 'tga') = 0 then begin
      Result := TTargaGraphic.Create;
      Result.LoadFromStream(FileStream);
    end;
    if Result <> nil then begin
      Result.Canvas.Brush.Color := clBlack;
      if Result.Width mod 2 <> 0 then
        Result.Width := Result.Width + 1;
    end;
  finally
    FileStream.Free;
  end;
end;

function TFormAdd.FormatBitmap(const Bitmap: TBitmap; boAlpha, boRLE, boCut: Boolean; BColor: TColor;
  var Data: PChar; WILColorFormat: TWILColorFormat): Integer;
var
  nBuffLen: Integer;
  Buffer: PChar;
  nY, nX, nAlpha: Integer;
  PDWord: PWord;
  P32RGB: PRGBQuad;
  CheckColor: Integer;
  bitLength: Byte;
  //testindex, testindex1: Word;
begin
  Data := nil;
  //testindex := StrToInt(FormMain.edt1.Text);
  //testindex1 := StrToInt(FormMain.edt2.Text);
  Result := 0;

  if WILColorFormat in [WILFMT_A4R4G4B4, WILFMT_A1R5G5B5, WILFMT_R5G6B5] then
    bitLength := 2
  else
    bitLength := 4;

  nBuffLen := Bitmap.Width * Bitmap.Height * bitLength;
  Buffer := AllocMem(nBuffLen);
  CheckColor := DisplaceRB(BColor) and $FFFFFF;
  try
    if WILColorFormat in [WILFMT_A8R8G8B8] then
    begin
          for nY := 0 to Bitmap.Height - 1 do
          begin
            if boCut then
              P32RGB := PRGBQuad(Bitmap.ScanLine[Bitmap.Height - 1 - nY])
            else
              P32RGB := PRGBQuad(Bitmap.ScanLine[nY]);
            PDWord := PWord(@Buffer[Bitmap.Width * bitLength * nY]);
            CopyMemory(PDWord, P32RGB, Bitmap.Width * bitLength);
            {for nX := 0 to Bitmap.Width - 1 do
            begin
              PDWord^ := (WORD(P32RGB.rgbReserved) and $F0 shl 8) + ((WORD(P32RGB.rgbRed) and $F0) shl 4) + (WORD(P32RGB.rgbGreen) and $F0) + (WORD(P32RGB.rgbBlue) shr 4);
              Inc(P32RGB);
              Inc(PDWord);
            end;}
          end;
    end
    else
    begin
      if not boAlpha then
      begin
        Bitmap.PixelFormat := pf32bit;
        for nY := 0 to Bitmap.Height - 1 do
        begin
          if boCut then
            P32RGB := PRGBQuad(Bitmap.ScanLine[Bitmap.Height - 1 - nY])
          else
            P32RGB := PRGBQuad(Bitmap.ScanLine[nY]);
          PDWord := PWord(@Buffer[Bitmap.Width * bitLength * nY]);
          for nX := 0 to Bitmap.Width - 1 do
          begin
            if (PInteger(P32RGB)^ and $FFFFFF) = CheckColor then
            begin
              PDWord^ := 0;
            end
            else
            begin
              case WILColorFormat of
                WILFMT_A4R4G4B4:
                  begin
                    nAlpha := 255;
                    if Image_Window.Checked then
                    begin
                      case ((WORD(P32RGB.rgbRed) and $F8) shl 8) + ((WORD(P32RGB.rgbGreen) and $FC) shl 3) + ((WORD(P32RGB.rgbBlue)) shr 3) of
                        38099:
                          nAlpha := 144;
                        12678, 29647:
                          nAlpha := 200;
                        2113:
                          nAlpha := 210;
                        10597:
                          nAlpha := 220;
                      end;
                      { if (P32RGB.rgbRed = $90) and (P32RGB.rgbGreen = $98) and (P32RGB.rgbBlue = $98) then nAlpha := 144
                        else if (P32RGB.rgbRed = $30) and (P32RGB.rgbGreen = $30) and (P32RGB.rgbBlue = $30) then nAlpha := 200
                        else if (P32RGB.rgbRed = $70) and (P32RGB.rgbGreen = $78) and (P32RGB.rgbBlue = $78) then nAlpha := 200
                        else if (P32RGB.rgbRed = $8) and (P32RGB.rgbGreen = $8) and (P32RGB.rgbBlue = $8) then nAlpha := 210; }
                    end;
                    PDWord^ := (nAlpha and $F0 shl 8) + ((WORD(P32RGB.rgbRed) and $F0) shl 4) + (WORD(P32RGB.rgbGreen) and $F0) + (WORD(P32RGB.rgbBlue) shr 4);
                  end;

                WILFMT_A1R5G5B5:
                  PDWord^ := $8000 + ((WORD(P32RGB.rgbRed) and $F8) shl 7) + ((WORD(P32RGB.rgbGreen) and $F8) shl 2) + ((WORD(P32RGB.rgbBlue)) shr 3);

                WILFMT_R5G6B5:
                  PDWord^ := ((WORD(P32RGB.rgbRed) and $F8) shl 8) + ((WORD(P32RGB.rgbGreen) and $FC) shl 3) + ((WORD(P32RGB.rgbBlue)) shr 3);
              end;
            end;
            Inc(P32RGB);
            Inc(PDWord);
          end;
        end;
      end
      else
      begin
        if Bitmap.PixelFormat = pf32bit then
        begin
          for nY := 0 to Bitmap.Height - 1 do
          begin
            if boCut then
              P32RGB := PRGBQuad(Bitmap.ScanLine[Bitmap.Height - 1 - nY])
            else
              P32RGB := PRGBQuad(Bitmap.ScanLine[nY]);
            PDWord := PWord(@Buffer[Bitmap.Width * 2 * nY]);
            for nX := 0 to Bitmap.Width - 1 do
            begin
              PDWord^ := (WORD(P32RGB.rgbReserved) and $F0 shl 8) + ((WORD(P32RGB.rgbRed) and $F0) shl 4) + (WORD(P32RGB.rgbGreen) and $F0) + (WORD(P32RGB.rgbBlue) shr 4);
              Inc(P32RGB);
              Inc(PDWord);
            end;
          end;
        end
        else if Bitmap.PixelFormat = pf16bit then
        begin
          for nY := 0 to Bitmap.Height - 1 do
          begin
            if boCut then
              Move(Bitmap.ScanLine[Bitmap.Height - 1 - nY]^, Buffer[Bitmap.Width * 2 * nY], Bitmap.Width * 2)
            else
              Move(Bitmap.ScanLine[nY]^, Buffer[Bitmap.Width * 2 * nY], Bitmap.Width * 2);
          end;
        end;
      end;
    end;

    if boRLE then begin
      Data := AllocMem(nBuffLen * bitLength);
      Result := EncodeRLE(Buffer, Data, Bitmap.Width * Bitmap.Height, bitLength);
      FreeMem(Buffer);
    end
    else begin
      Result := nBuffLen;
      Data := Buffer;
    end;
  except
    FreeMem(Buffer);
  end;
end;

function TFormAdd.FormatData(sFileName: string; boZIP: Boolean; nZIPLevel, nSize: Integer; var Data: PChar): Integer;
var
  //FileName: string;
  //nFileLen: Integer;
  fhandle: THandle;
  Buffer: PChar;
begin
  Result := 0;
  //FileName := ExtractFileName(sFileName);
  //nFileLen := Length(FileName);
  //if nFileLen <= 0 then exit;
  fhandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
  if (fhandle > 0) then begin
    Result := nSize;
    GetMem(Buffer, nSize);
    try
      ///Move(nFileLen, Buffer^, SizeOf(Integer));
      //Move(FileName[1], Buffer[SizeOf(Integer)], nFileLen);
      if FileRead(fhandle, Buffer^, nSize) = nSize then begin
        if boZIP and (nZIPLevel > 0) then begin
          Result := ZIPCompress(Buffer, Result, nZIPLevel, Data);
        end
        else begin
          Result := nSize;
          GetMem(Data, Result);
          Move(Buffer^, Data^, Result);
        end;
      end;
    finally
      FreeMem(Buffer);
      FileClose(fhandle);
    end;
  end;
end;

type
  TChrBuff = record
    case Integer of
      0: (
        RIFF: array[0..3] of Char;
        );
      1: (
        MP3: Word;
        );
      2: (
        ID3: array[0..2] of Char;
        );
  end;

function TFormAdd.CheckWavaData(sFileName: string): Integer;
var
  Stream: TFileStream;
  ChrBuff: TChrBuff;
  //total_size: Integer;
  nIndex: Integer;
  Buffer: Char;
begin
  Result := 0;
  Stream := TFileStream.Create(sFilename, fmOpenRead);
  try
    Stream.Read(ChrBuff, SizeOf(ChrBuff));
    if ChrBuff.RIFF = 'RIFF' then begin
      Result := FILETYPE_WAVA;
    end
    else if ((ChrBuff.MP3 and $F0FF) = $F0FF) or (ChrBuff.ID3 = 'ID3') then begin
      Result := FILETYPE_MP3;

      {total_size = (ChrBuff.Size[0] and $7F) * $200000 + (ChrBuff.Size[1] and $7F) * $400 + (ChrBuff.Size[2] and $7F) *  $80 + (ChrBuff.Size[3] and $7F);
      ShowMessage(IntToStr(total_size));   }

    end else
    if ((ChrBuff.MP3 and $F0FF) = $0) then begin
      nIndex := 0;
      while True do begin
        if Stream.Read(Buffer, 1) <> 1 then break;
        if Buffer <> #0 then begin
          Stream.Seek(-1, soCurrent);
          if Stream.Read(ChrBuff, SizeOf(ChrBuff)) <> SizeOf(ChrBuff) then break;
          if ((ChrBuff.MP3 and $F0FF) = $F0FF) then begin
            Result := FILETYPE_MP3;
          end;
          break;
        end;
        Inc(nIndex);
        if nIndex > 10000 then break;
      end;
    end;
  finally
    Stream.Free;
  end;
end;

procedure TFormAdd.FormCreate(Sender: TObject);
begin
  Image_Blend.Items.Assign(FormMain.Tool_BlendMode.Items);
  Image_Blend.ItemIndex := 0;
end;

procedure TFormAdd.FormDestroy(Sender: TObject);
begin
  File_ClearClick(File_Clear);
end;

procedure TFormAdd.Open;
begin
  Index_Start.MaxValue := g_WMImages.ImageCount - 1;
  Index_End.MaxValue := g_WMImages.ImageCount - 1;
  Index_Start.Value := g_SelectImageIndex;
  Index_End.Value := g_SelectImageIndex;
  ChangeControl;
  ProgressBar.Position := 0;
  ShowModal;
end;

procedure TFormAdd.WriteToFile(DataBuffer: PChar; DataLen, nW, nY: Integer);
var
  SaveList: TStringList;
  I: Integer;
  addstr: string;
  WriteBuffer: PByte;
begin
  SaveList := TStringList.Create;
  Try
    WriteBuffer := PByte(DataBuffer);
    SaveList.add('Const');
    SaveList.add('  LogoWidth = ' + IntToStr(nW) + ';');
    SaveList.add('  LogoHeight = ' + IntToStr(nY) + ';');
    SaveList.add('  LogoBuffer: array[0..' + IntToStr(DataLen) + ' - 1] of Byte = (');
    for I := 0 to DataLen - 1 do begin
      if i = 0 then begin
        addstr := '  $' + IntToHex(WriteBuffer^, 2) + ', ';
      end else begin
        if (I mod 16) = 0 then begin
          SaveList.Add(addstr);
          addstr := '  ';
        end;
        addstr := addstr + '$' + IntToHex(WriteBuffer^, 2) + ', ';
      end;
      Inc(WriteBuffer);
    end;
    SaveList.add(addstr);
    SaveList.add('  ); ');
    SaveList.SaveToFile('D:\LogoBitemp.inc');
  Finally
    SaveList.Free;
  End;
end;

end.

