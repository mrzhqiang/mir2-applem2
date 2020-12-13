unit FrmSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tabs, ExtCtrls, StdCtrls, CheckLst, ComCtrls;

type
  TFormSetup = class(TForm)
    TabSet: TTabSet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    clbDisplay: TCheckListBox;
    cbDisplay: TComboBox;
    ComboBox2: TComboBox;
    cbBitDepth: TComboBox;
    Panel2: TPanel;
    clbMusic: TCheckListBox;
    tBarMusic: TTrackBar;
    tBarSound: TTrackBar;
    lbMusic: TLabel;
    lbSound: TLabel;
    btOK: TButton;
    btDefault: TButton;
    procedure TabSetChange(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure tBarMusicChange(Sender: TObject);
    procedure tBarSoundChange(Sender: TObject);
    procedure btDefaultClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FormSetup: TFormSetup;

implementation

{$R *.dfm}
uses
  Registry, IniFiles;

const
  REG_SETUP_OPATH = 'SOFTWARE\IEngine\Mir2\Setup';
  REG_SETUP_PATH = 'SOFTWARE\IEngine\Mir2\Setup';
  REG_SETUP_BITDEPTH = 'BitDepth';
  REG_SETUP_DISPLAY = 'DisplaySize';
  REG_SETUP_WINDOWS = 'Window';
  REG_SETUP_MP3VOLUME = 'MusicVolume';
  REG_SETUP_SOUNDVOLUME = 'SoundVolume';
  REG_SETUP_MP3OPEN = 'MusicOpen';
  REG_SETUP_SOUNDOPEN = 'SoundOpen';

procedure TFormSetup.btOKClick(Sender: TObject);
var
  ini: TIniFile;
begin
  Try
    ini := TIniFile.Create('.\mir2.ini');
    Try
      if ini <> nil then begin
        ini.WriteBool(REG_SETUP_PATH, REG_SETUP_BITDEPTH, Boolean(cbBitDepth.ItemIndex));
        ini.WriteInteger(REG_SETUP_PATH, REG_SETUP_DISPLAY, ComboBox2.ItemIndex);
        ini.WriteBool(REG_SETUP_PATH, REG_SETUP_WINDOWS, clbDisplay.Checked[0]);
        ini.WriteBool(REG_SETUP_PATH, REG_SETUP_MP3OPEN, clbMusic.Checked[0]);
        ini.WriteInteger(REG_SETUP_PATH, REG_SETUP_MP3VOLUME, tBarMusic.Position);
        ini.WriteBool(REG_SETUP_PATH, REG_SETUP_SOUNDOPEN, clbMusic.Checked[1]);
        ini.WriteInteger(REG_SETUP_PATH, REG_SETUP_SOUNDVOLUME, tBarSound.Position);
      end;
    Except
    End;
  Finally
    if ini <> nil then begin
      ini.Free();
    end;
  End;
  Close;
end;

procedure TFormSetup.Open;
  function ReadBool(Reg: TRegistry; sName: string; Default: Boolean): Boolean;
  begin
    try
      Result := Reg.ReadBool(sName);
    except
      Result := Default;
    end;
  end;

  function ReadInteger(Reg: TRegistry; sName: string; Default: Integer): Integer;
  begin
    try
      Result := Reg.ReadInteger(sName);
    except
      Result := Default;
    end;
  end;
var
//  Reg: TRegistry;
  ini: TIniFile;
//  nCount: Integer;
  //di: D3DADAPTER_IDENTIFIER9;
begin
  TabSet.TabIndex := 0;
  Panel1.Visible := True;
  Panel2.Visible := False;

  cbDisplay.Items.Clear;
  cbDisplay.Items.Add('Ä¬ÈÏÏÔÊ¾Æ÷');
  cbDisplay.ItemIndex := 0;
  {Direct3D := Direct3DCreate9(D3D_SDK_VERSION);
  if Direct3D <> nil then begin
    nCount := Direct3D.GetAdapterCount;
    for nCount := 0 to nCount - 1 do begin
      Direct3D.GetAdapterIdentifier(nCount, 0, di);
      cbDisplay.Items.Add(di.Description);
    end;
    cbDisplay.ItemIndex := 0;
  end;
  Direct3D := nil;  }

  try
    ini := TIniFile.Create('.\mir2.ini');
    if ini <> nil then begin
      if ini.ReadBool(REG_SETUP_OPATH, REG_SETUP_BITDEPTH, False) then
        cbBitDepth.ItemIndex := 1
      else
        cbBitDepth.ItemIndex := 0;
      ComboBox2.ItemIndex := ini.ReadInteger(REG_SETUP_OPATH, REG_SETUP_DISPLAY, ComboBox2.ItemIndex);
      clbDisplay.Checked[0] := ini.ReadBool(REG_SETUP_OPATH, REG_SETUP_WINDOWS, True);
      clbDisplay.Checked[1] := True;
      clbDisplay.Checked[2] := True;
      clbDisplay.ItemEnabled[1] := False;
      clbDisplay.ItemEnabled[2] := False;
      clbMusic.Checked[0] := ini.ReadBool(REG_SETUP_OPATH, REG_SETUP_MP3OPEN, True);
      clbMusic.Checked[1] := ini.ReadBool(REG_SETUP_OPATH, REG_SETUP_SOUNDOPEN, True);
      tBarMusic.Position := ini.ReadInteger(REG_SETUP_OPATH, REG_SETUP_MP3VOLUME, 70);
      tBarSound.Position := ini.ReadInteger(REG_SETUP_OPATH, REG_SETUP_SOUNDVOLUME, 70);

      if ini.ReadBool(REG_SETUP_PATH, REG_SETUP_BITDEPTH, False) then
        cbBitDepth.ItemIndex := 1
      else
        cbBitDepth.ItemIndex := 0;
      ComboBox2.ItemIndex := ini.ReadInteger(REG_SETUP_PATH, REG_SETUP_DISPLAY, ComboBox2.ItemIndex);
      clbDisplay.Checked[0] := ini.ReadBool(REG_SETUP_PATH, REG_SETUP_WINDOWS, True);
      clbDisplay.Checked[1] := True;
      clbDisplay.Checked[2] := True;
      clbDisplay.ItemEnabled[1] := False;
      clbDisplay.ItemEnabled[2] := False;
      clbMusic.Checked[0] := ini.ReadBool(REG_SETUP_PATH, REG_SETUP_MP3OPEN, True);
      clbMusic.Checked[1] := ini.ReadBool(REG_SETUP_PATH, REG_SETUP_SOUNDOPEN, True);
      tBarMusic.Position := ini.ReadInteger(REG_SETUP_PATH, REG_SETUP_MP3VOLUME, 70);
      tBarSound.Position := ini.ReadInteger(REG_SETUP_PATH, REG_SETUP_SOUNDVOLUME, 70);
    end;
  finally
    if ini <> nil then begin
      ini.Free();
    end;
  end;
  ShowModal;
end;

procedure TFormSetup.btDefaultClick(Sender: TObject);
begin
  cbBitDepth.ItemIndex := 0;
  ComboBox2.ItemIndex := 0;
  clbDisplay.Checked[0] := True;
  clbMusic.Checked[0] := True;
  clbMusic.Checked[1] := True;
  tBarMusic.Position := 60;
  tBarSound.Position := 60;
end;

procedure TFormSetup.TabSetChange(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  if TabSet.TabIndex = 1 then begin
    Panel1.Visible := True;
    Panel2.Visible := False;
  end
  else if TabSet.TabIndex = 0 then begin
    Panel1.Visible := False;
    Panel2.VIsible := True;
  end;
end;

procedure TFormSetup.tBarMusicChange(Sender: TObject);
begin
  lbMusic.Caption := IntToStr(tBarMusic.Position) + '%';
end;

procedure TFormSetup.tBarSoundChange(Sender: TObject);
begin
  lbSound.Caption := IntToStr(tBarSound.Position) + '%';
end;

end.

