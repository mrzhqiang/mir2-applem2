unit LogDataMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, IdBaseComponent, IdComponent,
  IdUDPBase, IdUDPServer, INIFiles, IdSocketHandle, DB, ADODB, AppEvnts,
  IdAntiFreezeBase,
  IdAntiFreeze, ShellAPI;

type
  TFormMain = class(TForm)
    MainMenu1: TMainMenu;
    V1: TMenuItem;
    MEMU_VIEW_LOGVIEW: TMenuItem;
    H1: TMenuItem;
    MEMU_HELP_ABOUT: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    TimerSave: TTimer;
    IdUDPServer: TIdUDPServer;
    ADOQuery1: TADOQuery;
    Label3: TLabel;
    ApplicationEvents1: TApplicationEvents;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerSaveTimer(Sender: TObject);
    procedure MEMU_VIEW_LOGVIEWClick(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure IdUDPServerUDPRead(Sender: TObject; AData: TBytes;
      ABinding: TIdSocketHandle);
    procedure MEMU_HELP_ABOUTClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    LogMsgList: TStringList;
    AStrings: TStringList;
    m_boRemoteClose: Boolean;
    ODBConnect: string;
    SaveCount: LongWord;
    MaxSaveCount: LongWord;
    procedure WriteLogFile();
    procedure WriteLogDB(DBName: string);
    function GetDBFileName(): string;
  public
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
    procedure OnProgramException(Sender: TObject; E: Exception);
    procedure MainOutMessage(sMsg: string);
  end;

var
  FormMain: TFormMain;

implementation
uses LogShare, HUtil32, FrmViewLog, Grobal2;

{$R *.dfm}
{$R LogDB.RES}

procedure TFormMain.OnProgramException(Sender: TObject; E: Exception);
begin
end;

procedure TFormMain.MyMessage(var MsgData: TWmCopyData);
var
  sData: string;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of
    GS_QUIT: begin
        m_boRemoteClose := TRUE;
        Close();
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  Conf: TIniFile;
  nX, nY: Integer;
  //AStrings: TStringList;
begin
  g_dwGameCenterHandle := StrToIntDef(ParamStr(1), 0);
  nX := StrToIntDef(ParamStr(2), -1);
  nY := StrToIntDef(ParamStr(3), -1);
  g_boTeledata := False;
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top := nY;
  end;
  Memo1.Lines.Clear;
  //AStrings := TStringList.Create;
  //ShowMessage(IntToStr(ExtractStrings([#9], [], '6	JZ001	216	120	狂战ㄨ旋风	合金钢	256763	2	 	+	1	捡取', AStrings)));
  Application.OnException := OnProgramException;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  SendGameCenterMsg(SG_STARTNOW, '正在启动日志服务器...');
  LogMsgList := TStringList.Create;
  AStrings := TStringList.Create;
  if g_boTeledata then begin
    Conf := TIniFile.Create('.\Config\Config.ini');
    sBaseDir := '.\GameData\GameLog\';
  end else begin
    Conf := TIniFile.Create('.\Logdata.ini');
    sBaseDir := '.\BaseDir\';
  end;
  SaveCount := 0;
  MaxSaveCount := 0;
  if Conf <> nil then begin
    sServerName := Conf.ReadString('LogDataServer', 'ServerName', sServerName);
    Conf.WriteString('LogDataServer', 'ServerName', sServerName);
    nServerPort := Conf.ReadInteger('LogDataServer', 'Port', nServerPort);
    Conf.WriteInteger('LogDataServer', 'Port', nServerPort);
    sBaseDir := Conf.ReadString('LogDataServer', 'BaseDir', sBaseDir);
    Conf.WriteString('LogDataServer', 'BaseDir', sBaseDir);
    Conf.Free;
  end;
  Caption := sCaption + ' (' + sServerName + ')';
  ODBConnect := Format(ADODBString, [sBaseDir + GetDBFileName]);
  if not (FileExists(sBaseDir + GetDBFileName)) then begin
    CreateDirectoryA(PChar(sBaseDir), nil);
    WriteLogDB(sBaseDir + GetDBFileName);
  end;
  ADOQuery1.ConnectionString := ODBConnect;
  SendGameCenterMsg(SG_STARTOK, '日志服务器启动完成...');
  IdUDPServer.Bindings.Clear;
  IdUDPServer.Bindings.Add;
  IdUDPServer.Bindings.Items[0].IP := '127.0.0.1';
  IdUDPServer.Bindings.Items[0].Port := nServerPort;
  IdUDPServer.Active := True;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  //IdUDPServer.Active := False;
  LogMsgList.Free;
  AStrings.Free;
end;

procedure TFormMain.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then Height := 246
  else Height := 90;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if m_boRemoteClose then
    exit;
  if Application.MessageBox('是否确认关闭日志程序？', '提示信息', MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    IdUDPServer.Active := False;
  end
  else
    CanClose := False;
end;

procedure TFormMain.IdUDPServerUDPRead(Sender: TObject; AData: TBytes; ABinding: TIdSocketHandle);
var
  sMsg: string;
  AMaxCount: Integer;
  UserItem: pTUserItem;
begin
  try
    AMaxCount := Length(AData);
    if AMaxCount > 0 then begin
      sMsg := PChar(@AData[0]);
      if AMaxCount = (Length(sMsg) + 1 + SizeOf(TUserItem)) then begin
        New(UserItem);
        Move(AData[Length(sMsg) + 1], UserItem^, SizeOf(TUserItem));
        LogMsgList.AddObject(sMsg, TObject(UserItem));
      end else
        LogMsgList.Add(sMsg);
    end;
  except
  end;
end;

procedure TFormMain.WriteLogFile();
var
  DBFile: string;
  WhiteStr: string;
  UserItem: pTUserItem;
  MemoryStream: TMemoryStream;
begin
  DBFile := GetDBFileName;
  Label2.Caption := sBaseDir + DBFile;
  Label3.Caption := IntToStr(SaveCount) + '/' + IntToStr(MaxSaveCount);
  if LogMsgList.Count <= 0 then exit;

  if not (FileExists(sBaseDir + DBFile)) then begin
    CreateDirectoryA(PChar(sBaseDir), nil);
    WriteLogDB(sBaseDir + DBFile);
    ADOQuery1.ConnectionString := ODBConnect;
  end;
  MemoryStream := TMemoryStream.Create;
  MemoryStream.SetSize(SizeOf(TUserItem));
  ADOQuery1.SQL.SetText('select top 1 * from Log');
  ADOQuery1.Open;
  Try
    while (LogMsgList.Count > 0) do begin
      WhiteStr := LogMsgList.Strings[0];
      if LogMsgList.Objects[0] <> nil then UserItem := PTUserItem(LogMsgList.Objects[0])
      else UserItem := nil;
      LogMsgList.Delete(0);
      Inc(MaxSaveCount);
      AStrings.Clear;
      if ExtractStrings([#9], [], PChar(WhiteStr), AStrings) > 11 then begin
        Inc(SaveCount);
        try
          ADOQuery1.Append;
          ADOQuery1.FieldByName('动作').AsString := AStrings.Strings[0];
          ADOQuery1.FieldByName('地图').AsString := AStrings.Strings[1];
          ADOQuery1.FieldByName('X坐标').AsString := AStrings.Strings[2];
          ADOQuery1.FieldByName('Y坐标').AsString := AStrings.Strings[3];
          ADOQuery1.FieldByName('人物名称').AsString := AStrings.Strings[4];
          ADOQuery1.FieldByName('物品名称').AsString := AStrings.Strings[5];
          ADOQuery1.FieldByName('物品ID').AsString := AStrings.Strings[6];
          ADOQuery1.FieldByName('物品数量').AsString := AStrings.Strings[7];
          ADOQuery1.FieldByName('交易对像').AsString := AStrings.Strings[8];
          ADOQuery1.FieldByName('备注1').AsString := AStrings.Strings[9];
          ADOQuery1.FieldByName('备注2').AsString := AStrings.Strings[10];
          ADOQuery1.FieldByName('备注3').AsString := AStrings.Strings[11];
          if UserItem <> nil then begin
            MemoryStream.Position := 0;
            Move(UserItem^, MemoryStream.Memory^, SizeOf(TUserItem));
            TBlobField(ADOQuery1.FieldByName('物品数据')).LoadFromStream(MemoryStream);
          end;
          ADOQuery1.Post;
        except
          Continue;
        end;
      end else
        MainOutMessage(WhiteStr);
    end;
  Finally
    ADOQuery1.Close;
    MemoryStream.Free;
  End;
end;

function TFormMain.GetDBFileName(): string;
begin
  Result := FormatDateTime('yy-mm-dd', Now) + '.mdb';
end;

procedure TFormMain.WriteLogDB(DBName: string);
var
  Res: TResourceStream;
begin
  Res := TresourceStream.Create(0, 'LOGDB', 'DB');
  try
    Res.SaveToFile(DBName);
  finally
    Res.Free;
  end;
  ODBConnect := Format(ADODBString, [DBName]);
end;

procedure TFormMain.TimerSaveTimer(Sender: TObject);
begin
  WriteLogFile();
end;

procedure TFormMain.MainOutMessage(sMsg: string);
begin
  if Memo1.Lines.Count > 500 then Memo1.Lines.Clear;
  Memo1.Lines.Add(sMsg);
end;

procedure TFormMain.MEMU_HELP_ABOUTClick(Sender: TObject);
begin
  ShellAbout(Handle, '游戏日志服务器 2020/12/26', 'Copyright (C) 2020 randall.top',
    Application.Icon.Handle);
end;

procedure TFormMain.MEMU_VIEW_LOGVIEWClick(Sender: TObject);
begin
  FormView := TFormView.Create(Self);
  FormView.ShowModal;
  FormView.Free;
end;

procedure TFormMain.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
  MainOutMessage(E.Message);
end;

end.

