unit IntroScn;//游戏的引导场景，，比如选人,注册，，登录等,,与游戏的主场景构成游戏的整个场景
//一般场景定义
interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, HGETextures, Grobal2, cliUtil, SoundUtil,
  HUtil32;

const

{$IF Var_Interface = Var_Mir2}
   SELECTEDFRAME = 16;//selected frame 选人时点了左边或右边的角色此时会有人物动画，有16帧
   //打开ChrSel.wil,,可以看到男54是40-55,,
   FREEZEFRAME = 13;//freeze frame 男54,,60-72,,共13帧
  EFFECTFRAME = 14;
  LOGINBAGIMGINDEX = 22;
{$ELSE}
  SELECTEDFRAME = 16;
  FREEZEFRAME = 16;
  EFFECTFRAME = 14;
  LOGINBAGIMGINDEX = 301;
{$IFEND}

type
  TLoginState = (lsLogin, lsNewid, lsNewidRetry, lsChgpw, lsCloseAll, lsCard);
  TSelectChrState = (scSelectChr, scCreateChr, scRenewChr);
  TSceneType = (stLogin, stSelectChr, stPlayGame, stSelServer, stHint, stClose);
  TLastForm = (lf_Login, lf_SelectChr, lf_Play);

  TSelChar = record
    Valid: Boolean;
    UserChr: TUserCharacterInfo;
    Selected: Boolean;
    FreezeState: Boolean; //TRUE:倔篮惑怕 FALSE:踌篮惑怕
    Unfreezing: Boolean; //踌绊 乐绰 惑怕牢啊?
    Freezing: Boolean; //倔绊 乐绰 惑怕?
    AniIndex: Integer; //踌绰(绢绰) 局聪皋捞记
    DarkLevel: Integer;
    EffIndex: Integer; //瓤苞 局聪皋捞记
    StartTime: LongWord;
    moretime: LongWord;
    startefftime: LongWord;
  end;

  TScene = class
  private
  public
    scenetype: TSceneType;
    constructor Create(scenetype: TSceneType);
    function Initialize: Boolean; dynamic;
    procedure Finalize; dynamic;
    procedure OpenScene; dynamic;
    procedure CloseScene; dynamic;
    procedure OpeningScene; dynamic;
    procedure KeyPress(var Key: Char); dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); dynamic;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
      Integer);
      dynamic;
    procedure PlayScene(MSurface: TDirectDrawSurface); dynamic;
  end;

  TSelServer = class(TScene)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure OpenScene; override;
    procedure CloseScene; override;
    procedure PlayScene(MSurface: TDirectDrawSurface); override;
  end;

  THintScene = class(TScene)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure OpenScene; override;
    procedure CloseScene; override;
    procedure PlayScene(MSurface: TDirectDrawSurface); override;
  end;

  TLoginScene = class(TScene)
  private
    m_nCurFrame: Integer;
    m_nMaxFrame: Integer;
    m_dwStartTime: LongWord; //茄 橇贰烙寸 矫埃
    m_boNowOpening: Boolean;
    m_boOpenFirst: Boolean;
    m_NewIdRetryUE: TUserEntry;
    m_NewIdRetryAdd: TUserEntryAdd;
    procedure EdLoginIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdLoginPasswdKeyPress(Sender: TObject; var Key: Char);
    procedure EdNewIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdCardKeyPress(Sender: TObject; var Key: Char);
{$IF Var_Interface = Var_Mir2}
    procedure EdNewOnEnter(Sender: TObject);
{$IFEND}
    function CheckUserEntrys: Boolean;
    function NewIdCheckNewId: Boolean;
    function NewIdCheckBirthDay: Boolean;
    procedure EdChrnameKeyPress(Sender: TObject; var Key: Char);
  public
    m_sLoginId: string;
    m_sLoginPasswd: string;
    //m_boUpdateAccountMode: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure Initialize;
    procedure OpenScene; override;
    procedure CloseScene; override;
    procedure PlayScene(MSurface: TDirectDrawSurface); override;
    procedure ChangeLoginState(State: TLoginState);
    procedure NewClick;
    procedure NewIdRetry(boupdate: Boolean);
    procedure OkClick;
    procedure ChgPwClick;
    procedure NewAccountOk;
    procedure CardOK;
    procedure NewAccountClose;
    procedure ChgpwOk;
    procedure ChgpwCancel;
      procedure HideLoginBox; //验证通过，，隐藏登录对话框
      procedure OpenLoginDoor;//开门
    procedure PassWdFail;
  end;

  TSelectChrScene = class(TScene)
  private
    SoundTimer: TTimer;
    CreateChrMode: Boolean;
    procedure SoundOnTimer(Sender: TObject);
    procedure MakeNewChar(Index: Integer);
  public
    NewIndex: Integer;
    ChrArr: array[0..2] of TSelChar;
    RenewChr: array[0..16] of TRenewChrInfo;
    constructor Create;
    destructor Destroy; override;
    procedure OpenScene; override;
    procedure CloseScene; override;
    procedure PlayScene(MSurface: TDirectDrawSurface); override;
    procedure SelChrSelect1Click;
    procedure SelChrSelect2Click;
    procedure SelChrSelect3Click;
    procedure SelChrStartClick;
    procedure SelChrNewChrClick;
    procedure SelChrEraseChrClick;
    procedure SelChrCreditsClick;
    procedure SelChrExitClick;
    procedure SelChrNewClose;
    procedure SelChrNewJob(job: Integer);
    procedure SelChrNewm_btSex(sex: Integer);
    procedure SelChrNewPrevHair;
    procedure SelChrNewNextHair;
    procedure SelChrNewOk;
    procedure SelRenewChr;
    procedure ClearChrs;
    procedure AddChr(uname: string; ID, job, wuxin, Level, sex: Integer; LoginTime: TDateTime);
    procedure SelectChr(Index: Integer);
    procedure ChangeSelectChrState(State: TSelectChrState);
  end;

var
  LastForm: TLastForm = lf_Login;

implementation

uses
  ClMain, MShare, Share, HGEGUI, FState, FState2, WMFile, MD5Unit, MNShare;


constructor TScene.Create(scenetype: TSceneType);
begin
  //  scenetype := scenetype;
end;

function TScene.Initialize: Boolean;
begin
  Result := False;
end;

procedure TScene.Finalize;
begin
end;

procedure TScene.OpenScene;
begin
  ;
end;

procedure TScene.CloseScene;
begin
  ;
end;

procedure TScene.OpeningScene;
begin
end;

procedure TScene.KeyPress(var Key: Char);
begin
end;

procedure TScene.KeyDown(var Key: Word; Shift: TShiftState);
begin
end;

procedure TScene.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TScene.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer);
begin
end;

procedure TScene.PlayScene(MSurface: TDirectDrawSurface);
begin
  ;
end;

procedure TLoginScene.Initialize;
begin
{$IF Var_Interface = Var_Mir2}
  with FrmDlg2.DCardNo1 do begin
    Height := 16;
    Width := 54;
    Left := 45;
    Top := 86;
    OnKeyPress := EdCardKeyPress;
    Visible := True;
  end;

  with FrmDlg2.DCardNo2 do begin
    Height := 16;
    Width := 34;
    Left := 128;
    Top := 86;
    OnKeyPress := EdCardKeyPress;
    Visible := True;
  end;

  with FrmDlg2.DCardNo3 do begin
    Height := 16;
    Width := 34;
    Left := 211;
    Top := 86;
    OnKeyPress := EdCardKeyPress;
    Visible := True;
  end;

  //创建帐号
  with FrmDlg.DEditNewId do begin
    Height := 16;
    Width := 116;
    Left := 161;
    Top := 115;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditNewPasswd do begin
    Height := 16;
    Width := 116;
    Left := 161;
    Top := 136;
    //MaxLength := 10;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditConfirm do begin
    Height := 16;
    Width := 116;
    Left := 161;
    Top := 157;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditYourName do begin
    Height := 16;
    Width := 116;
    Left := 161;
    Top := 186;
    //MaxLength := 20;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditRecommendation do begin
    Height := 16;
    Width := 116;
    Left := 161;
    Top := 225;
    //MaxLength := 14;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
    Visible := False;
  end;

  with FrmDlg.DEditBirthDay do begin
    Height := 16;
    Width := 116;
    Left := 161;
    Top := 225;
    boTransparent := False;
    //MaxLength := 10;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditQuiz1 do begin
    Height := 16;
    Width := 163;
    Left := 161;
    Top := 255;
    //MaxLength := 20;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditAnswer1 do begin
    Height := 16;
    Width := 163;
    Left := 161;
    Top := 275;
    //MaxLength := 12;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditQuiz2 do begin
    Height := 16;
    Width := 163;
    Left := 161;
    Top := 296;
    //MaxLength := 20;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditAnswer2 do begin
    Height := 16;
    Width := 163;
    Left := 161;
    Top := 316;
    //MaxLength := 12;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditPhone do begin
    Height := 16;
    Width := 116;
    Left := 161;
    Top := 346;
    //MaxLength := 14;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditMobPhone do begin
    Height := 16;
    Width := 116;
    Left := 161;
    Top := 367;
    //MaxLength := 13;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditEMail do begin
    Height := 16;
    Width := 116;
    Left := 161;
    Top := 387;
    //MaxLength := 40;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  //修改密码
  with FrmDlg.DEditChgId do begin
    Height := 16;
    Width := 136;
    Left := 239;
    Top := 117;
    boTransparent := False;
    //MaxLength := 15;
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  with FrmDlg.DEditChgCurrentpw do begin
    Height := 16;
    Width := 136;
    Left := 239;
    Top := 149;
    boTransparent := False;
    //MaxLength := 20;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  with FrmDlg.DEditChgNewPw do begin
    Height := 16;
    Width := 136;
    Left := 239;
    Top := 176;
    boTransparent := False;
    //MaxLength := 20;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  with FrmDlg.DEditChgRepeat do begin
    Height := 16;
    Width := 136;
    Left := 239;
    Top := 208;
    boTransparent := False;
    //MaxLength := 20;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  //创建人物
  with FrmDlg.DEditChrName do begin
    Height := 16;
    Width := 136;
    Left := 71;
    Top := 107;
    MaxLength := 14;
    boTransparent := False;
    OnKeyPress := EdChrnameKeyPress;
  end;

{$ELSE}
  with FrmDlg2.DCardNo1 do begin
    Height := 16;
    Width := 54;
    Left := 45;
    Top := 86;
    OnKeyPress := EdCardKeyPress;
    Visible := True;
  end;

  with FrmDlg2.DCardNo2 do begin
    Height := 16;
    Width := 34;
    Left := 128;
    Top := 86;
    OnKeyPress := EdCardKeyPress;
    Visible := True;
  end;

  with FrmDlg2.DCardNo3 do begin
    Height := 16;
    Width := 34;
    Left := 211;
    Top := 86;
    OnKeyPress := EdCardKeyPress;
    Visible := True;
  end;

  
  with FrmDlg.DEditNewId do begin
    Height := 16;
    Width := 116;
    Left := 140;
    Top := 94;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditNewPasswd do begin
    Height := 16;
    Width := 116;
    Left := 140;
    Top := 208;
    //MaxLength := 10;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditConfirm do begin
    Height := 16;
    Width := 116;
    Left := 140;
    Top := 238;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditYourName do begin
    Height := 16;
    Width := 116;
    Left := 140;
    Top := 357;
    //MaxLength := 20;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditRecommendation do begin
    Height := 16;
    Width := 116;
    Left := 381;
    Top := 357;
    //MaxLength := 14;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditBirthDay do begin
    Height := 16;
    Width := 116;
    Left := 140;
    Top := 387;
    //MaxLength := 10;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditQuiz1 do begin
    Height := 16;
    Width := 163;
    Left := 382;
    Top := 94;
    //MaxLength := 20;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditAnswer1 do begin
    Height := 16;
    Width := 163;
    Left := 382;
    Top := 124;
    //MaxLength := 12;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditQuiz2 do begin
    Height := 16;
    Width := 163;
    Left := 382;
    Top := 154;
    //MaxLength := 20;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditAnswer2 do begin
    Height := 16;
    Width := 163;
    Left := 382;
    Top := 184;
    //MaxLength := 12;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditPhone do begin
    Height := 16;
    Width := 116;
    Left := 381;
    Top := 274;
    //MaxLength := 14;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditMobPhone do begin
    Height := 16;
    Width := 116;
    Left := 381;
    Top := 304;
    //MaxLength := 13;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditEMail do begin
    Height := 16;
    Width := 116;
    Left := 381;
    Top := 244;
    //MaxLength := 40;
    OnKeyPress := EdNewIdKeyPress;
    tag := 11;
  end;

  with FrmDlg.DEditChgId do begin
    Height := 16;
    Width := 170;
    Left := 106;
    Top := 57;
    //MaxLength := 15;
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  with FrmDlg.DEditChgCurrentpw do begin
    Height := 16;
    Width := 170;
    Left := 106;
    Top := 98;
    //MaxLength := 20;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  with FrmDlg.DEditChgNewPw do begin
    Height := 16;
    Width := 170;
    Left := 106;
    Top := 139;
    //MaxLength := 20;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  with FrmDlg.DEditChgRepeat do begin
    Height := 16;
    Width := 170;
    Left := 106;
    Top := 180;
    //MaxLength := 20;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  with FrmDlg.DEditChrName do begin
    Height := 16;
    Width := 133;
    Left := 395;
    Top := 69;
    MaxLength := 14;
    OnKeyPress := EdChrnameKeyPress;
  end;

  with FrmDlg.DEditChrName2 do begin
    Height := 16;
    Width := 133;
    Left := 395;
    Top := 69;
    MaxLength := 14;
    OnKeyPress := EdChrnameKeyPress;
  end;
{$IFEND}
end;

{--------------------- Login ----------------------}

constructor TLoginScene.Create;
begin
  inherited Create(stLogin);
end;

destructor TLoginScene.Destroy;
begin
  inherited Destroy;
end;

procedure TLoginScene.OpenScene;
//var
//  i: Integer;
//  d: TDirectDrawSurface;
begin
  HGE.Gfx_Restore(DEFSCREENWIDTH, DEFSCREENHEIGHT, 16);
  m_nCurFrame := 0;
{$IF Var_Interface = Var_Mir2}
  m_nMaxFrame := 10;
{$ELSE}
  m_nMaxFrame := 40;
{$IFEND}

  //m_sLoginId := '';
  //m_sLoginPasswd := '';

  //FrmDlg.DEditID.
  //FrmDlg.DEditPass.
{$IF Var_Interface = Var_Mir2}
  with FrmDlg.DEditID do begin
    Left := 98;
    Top := 85;
    Height := 16;
    Width := 136;
    Visible := True;
    OnKeyPress := EdLoginIdKeyPress;
    Tag := 10;
  end;
  with FrmDlg.DEditPass do begin
    Left := 98;
    Top := 117;
    Height := 16;
    Width := 136;
    Visible := True;
    OnKeyPress := EdLoginPasswdKeyPress;
    Tag := 10;
  end;
{$ELSE}
  with FrmDlg.DEditID do begin
    Left := 105;
    Top := 78;
    Height := 16;
    Width := 170;
    Visible := True;
    OnKeyPress := EdLoginIdKeyPress;
    Tag := 10;
  end;
  with FrmDlg.DEditPass do begin
    Left := 105;
    Top := 122;
    Height := 16;
    Width := 170;
    Visible := True;
    OnKeyPress := EdLoginPasswdKeyPress;
    Tag := 10;
  end;
{$IFEND}
  m_boOpenFirst := True;

  FrmDlg.DLogin.Visible := True;
  FrmDlg.DNewAccount.Visible := FALSE;
  FrmDlg.DChgPw.Visible := False;
  FrmDlg2.DMatrixCardWnd.Visible := False;
  m_boNowOpening := FALSE;

end;

procedure TLoginScene.CloseScene;
begin
  FrmDlg.DNewAccount.Visible := FALSE;
  FrmDlg.DChgPw.Visible := False;
  FrmDlg.DLogin.Visible := FALSE;
  FrmDlg2.DMatrixCardWnd.Visible := False;
end;

procedure TLoginScene.EdLoginIdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    Key := #0;
    m_sLoginId := LowerCase(FrmDlg.DEditID.Text);
    if m_sLoginId <> '' then begin
      FrmDlg.DEditPass.SetFocus;
    end;
  end;
end;

procedure TLoginScene.EdLoginPasswdKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = '~') or (Key = '''') then
    Key := '_';
  if Key = #13 then begin
    Key := #0;
    m_sLoginId := LowerCase(FrmDlg.DEditID.Text);
    m_sLoginPasswd := FrmDlg.DEditPass.Text;
    if Length(m_sLoginId) < 5 then begin
      FrmDlg.DMessageDlg('通行证账号长度不能低于5位', [mbOk]);
      FrmDlg.DEditID.SetFocus;
      exit;
    end;
    if Length(m_sLoginPasswd) < 5 then begin
      FrmDlg.DMessageDlg('通行证密码长度不能低于5位', [mbOk]);
      FrmDlg.DEditPass.SetFocus;
      exit;
    end;
    if (m_sLoginId <> '') and (m_sLoginPasswd <> '') then begin
      FrmDlg.HintBack := stSelServer;
      FrmDlg.sHintStr := '正在验证账号和密码信息。。。';
      FrmDlg.DBTHintClose.Caption := '取消';
      FrmDlg.boHintFocus := False;
      DScreen.ChangeScene(stHint);
      if g_boSQLReg then
        frmMain.SendLogin(m_sLoginId, GetMD5TextOf16(m_sLoginPasswd))
      else
        frmMain.SendLogin(m_sLoginId, m_sLoginPasswd);
      FrmDlg.DEditID.Text := '';
      FrmDlg.DEditPass.Text := '';
    end
    else if (FrmDlg.DEditID.Text = '') then
      FrmDlg.DEditID.SetFocus;
  end;
end;

procedure TLoginScene.PassWdFail;
begin
  FrmDlg.DEditID.SetFocus;
end;

function TLoginScene.NewIdCheckNewId: Boolean;
begin
  Result := True;
  FrmDlg.DEditNewId.Text := Trim(FrmDlg.DEditNewId.Text);
  if Length(FrmDlg.DEditNewId.Text) < 5 then begin
    FrmDlg.DMessageDlg('登录帐号的长度不能少于5位.', [mbOk]);
    Beep;
    FrmDlg.DEditNewId.SetFocus;
    Result := FALSE;
  end;
end;

procedure TLoginScene.NewIdRetry(boupdate: Boolean);
begin
  ChangeLoginState(lsNewidRetry);
  FrmDlg.DEditNewId.Text := m_NewIdRetryUE.sAccount;
  FrmDlg.DEditNewPasswd.Text := m_NewIdRetryUE.sPassword;
  FrmDlg.DEditYourName.Text := m_NewIdRetryUE.sUserName;
  FrmDlg.DEditRecommendation.Text := m_NewIdRetryUE.sSSNo;
  FrmDlg.DEditQuiz1.Text := m_NewIdRetryUE.sQuiz;
  FrmDlg.DEditAnswer1.Text := m_NewIdRetryUE.sAnswer;
  FrmDlg.DEditPhone.Text := m_NewIdRetryUE.sPhone;
  FrmDlg.DEditEMail.Text := m_NewIdRetryUE.sEMail;
  FrmDlg.DEditQuiz2.Text := m_NewIdRetryAdd.sQuiz2;
  FrmDlg.DEditAnswer2.Text := m_NewIdRetryAdd.sAnswer2;
  FrmDlg.DEditMobPhone.Text := m_NewIdRetryAdd.sMobilePhone;
  FrmDlg.DEditBirthDay.Text := m_NewIdRetryAdd.sBirthDay;
end;

function TLoginScene.NewIdCheckBirthDay: Boolean;
var
  str, syear, smon, sday: string;
  ayear, amon, aday: Integer;
  flag: Boolean;
begin
  Result := True;
  flag := True;
  str := FrmDlg.DEditBirthDay.Text;
  str := GetValidStr3(str, syear, ['/']);
  str := GetValidStr3(str, smon, ['/']);
  str := GetValidStr3(str, sday, ['/']);
  ayear := StrToIntDef(syear, 0);
  amon := StrToIntDef(smon, 0);
  aday := StrToIntDef(sday, 0);
  if (ayear <= 1890) or (ayear > 2101) then
    flag := FALSE;
  if (amon <= 0) or (amon > 12) then
    flag := FALSE;
  if (aday <= 0) or (aday > 31) then
    flag := FALSE;
  if not flag then begin
    Beep;
    FrmDlg.DEditBirthDay.SetFocus;
    Result := FALSE;
  end;
end;

procedure TLoginScene.EdNewIdKeyPress(Sender: TObject; var Key: Char);
//var
  //syear, smon, sday: string;
  //ayear, amon, aday, sex: Integer;
//  flag: Boolean;
begin
  if (Sender = FrmDlg.DEditNewPasswd) or (Sender = FrmDlg.DEditChgNewPw) or
    (Sender = FrmDlg.DEditChgRepeat) then
    if (Key = '~') or (Key = '''') or (Key = ' ') then
      Key := #0;
  if Key = #13 then begin
    Key := #0;
    if Sender = FrmDlg.DEditNewId then begin
      if not NewIdCheckNewId then
        Exit;
    end;
    if Sender = FrmDlg.DEditNewPasswd then begin
      if Length(FrmDlg.DEditNewPasswd.Text) < 4 then begin
        FrmDlg.DMessageDlg('密码长度必须大于 4位.', [mbOk]);
        Beep;
        FrmDlg.DEditNewPasswd.SetFocus;
        Exit;
      end;
    end;
    if Sender = FrmDlg.DEditConfirm then begin
      if FrmDlg.DEditNewPasswd.Text <> FrmDlg.DEditConfirm.Text then begin
        FrmDlg.DMessageDlg('二次输入的密码不一至！！！', [mbOk]);
        Beep;
        FrmDlg.DEditConfirm.SetFocus;
        Exit;
      end;
    end;
    if (Sender = FrmDlg.DEditYourName) or (Sender = FrmDlg.DEditQuiz1) or (Sender
      = FrmDlg.DEditAnswer1)
      or
      (Sender = FrmDlg.DEditQuiz2) or (Sender = FrmDlg.DEditAnswer2) or (Sender
      = FrmDlg.DEditPhone) or
      (Sender = FrmDlg.DEditMobPhone) or (Sender = FrmDlg.DEditEMail) then begin
      TDEdit(Sender).Text := Trim(TDEdit(Sender).Text);
      if TDEdit(Sender).Text = '' then begin
        Beep;
        TDEdit(Sender).SetFocus;
        Exit;
      end;
    end;
    if Sender = FrmDlg.DEditBirthDay then begin
      if not NewIdCheckBirthDay then
        Exit;
    end;
    if TDEdit(Sender).Text <> '' then begin
      if Sender = FrmDlg.DEditNewId then
        FrmDlg.DEditNewPasswd.SetFocus;
      if Sender = FrmDlg.DEditNewPasswd then
        FrmDlg.DEditConfirm.SetFocus;
      if Sender = FrmDlg.DEditConfirm then
        FrmDlg.DEditYourName.SetFocus;
      if Sender = FrmDlg.DEditYourName then
        FrmDlg.DEditBirthDay.SetFocus;
      if Sender = FrmDlg.DEditBirthDay then
        FrmDlg.DEditQuiz1.SetFocus;
      if Sender = FrmDlg.DEditQuiz1 then
        FrmDlg.DEditAnswer1.SetFocus;
      if Sender = FrmDlg.DEditAnswer1 then
        FrmDlg.DEditQuiz2.SetFocus;
      if Sender = FrmDlg.DEditQuiz2 then
        FrmDlg.DEditAnswer2.SetFocus;
      if Sender = FrmDlg.DEditAnswer2 then
        FrmDlg.DEditEMail.SetFocus;
      if Sender = FrmDlg.DEditEMail then
        FrmDlg.DEditPhone.SetFocus;
      if Sender = FrmDlg.DEditPhone then
        FrmDlg.DEditMobPhone.SetFocus;
      if Sender = FrmDlg.DEditMobPhone then
        FrmDlg.DEditRecommendation.SetFocus;
      if Sender = FrmDlg.DEditRecommendation then
        FrmDlg.DEditNewId.SetFocus;

      if Sender = FrmDlg.DEditChgId then
        FrmDlg.DEditChgCurrentpw.SetFocus;
      if Sender = FrmDlg.DEditChgCurrentpw then
        FrmDlg.DEditChgNewPw.SetFocus;
      if Sender = FrmDlg.DEditChgNewPw then
        FrmDlg.DEditChgRepeat.SetFocus;
      if Sender = FrmDlg.DEditChgRepeat then
        FrmDlg.DEditChgId.SetFocus;
    end;
  end;
end;

{$IF Var_Interface = Var_Mir2}
procedure TLoginScene.EdNewOnEnter(Sender: TObject);
begin
  FrmDlg.NAHelps.Clear;
  if Sender = FrmDlg.DEditNewId then begin
    FrmDlg.NAHelps.Add('[用户]也称：账户、账号、ID。');
    FrmDlg.NAHelps.Add('可以是字符、数字的组合。');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('ID必须至少有4位。');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('你输入的ID是你用于登陆游戏的名字');
    FrmDlg.NAHelps.Add('请仔细选择你的ID');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('你的ID可以用于本区所有的服务器。');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('我们建议：');
    FrmDlg.NAHelps.Add('你现在输入的ID名与你随后即将在');
    FrmDlg.NAHelps.Add('游戏中建立的[角色名]区分开来。');
  end;
  if Sender = FrmDlg.DEditNewPasswd then begin
    FrmDlg.NAHelps.Add('你的密码可以是字符和数字的组合。');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('密码的最少长度是4位。');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('记住密码是继续游戏的基本要素。');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('为了消除一些不安全因素，');
    FrmDlg.NAHelps.Add('我们建议：');
    FrmDlg.NAHelps.Add('1：不要将你的密码告诉他人。');
    FrmDlg.NAHelps.Add('2：不要使用太过简单的密码。');
  end;
  if Sender = FrmDlg.DEditConfirm then begin
    FrmDlg.NAHelps.Add('再次输入密码，以确认。');
  end;
  if Sender = FrmDlg.DEditYourName then begin
    FrmDlg.NAHelps.Add('输入你的全名，请正确输入。');
    FrmDlg.NAHelps.Add('这是你找回密码的依据之一。');
  end;
  if Sender = FrmDlg.DEditBirthDay then begin
    FrmDlg.NAHelps.Add('请输入你的出生日期和月份，');
    FrmDlg.NAHelps.Add('年/月/日：1977/09/15');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('这是你找回密码的依据之一。');
  end;
  if (Sender = FrmDlg.DEditQuiz1) or (Sender = FrmDlg.DEditQuiz2) then begin
    FrmDlg.NAHelps.Add('请输入一个找回密码的提示问题');
    FrmDlg.NAHelps.Add('请明确，只有你本人才知道这个问题。');
  end;
  if (Sender = FrmDlg.DEditAnswer1) or (Sender = FrmDlg.DEditAnswer2) then begin
    FrmDlg.NAHelps.Add('请输入上面问题的答案');

  end;
  if (Sender = FrmDlg.DEditYourName) or (Sender = FrmDlg.DEditQuiz1) or (Sender = FrmDlg.DEditQuiz2) or (Sender = FrmDlg.DEditAnswer1) or (Sender = FrmDlg.DEditAnswer2) then begin
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('你必须输入正确的信息。');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('如果使用了错误的信息，');
    FrmDlg.NAHelps.Add('你将无法享受我们的所有服务。');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('如果你提供的信息错误，');
    FrmDlg.NAHelps.Add('你的账户将会被取消。');
  end;

  if Sender = FrmDlg.DEditPhone then begin
    FrmDlg.NAHelps.Add('请输入你的电话号码。');
    FrmDlg.NAHelps.Add('');
  end;
  if Sender = FrmDlg.DEditMobPhone then begin
    FrmDlg.NAHelps.Add('请输入你的手机号码。');
    FrmDlg.NAHelps.Add('');
  end;
  if Sender = FrmDlg.DEditEMail then begin
    FrmDlg.NAHelps.Add('请输入你的邮件（E-Mail）地址。');
    FrmDlg.NAHelps.Add('你的E-Mail将被用于访问我们的');
    FrmDlg.NAHelps.Add('一些服务器。');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('你就能收到最近更新的一些信息。');
    FrmDlg.NAHelps.Add('请务必正确填写。');
  end;
end;
{$IFEND}

procedure TLoginScene.HideLoginBox;
begin
  //EdId.Visible := FALSE;
  //EdPasswd.Visible := FALSE;
  //FrmDlg.DLogin.Visible := FALSE;
  ChangeLoginState(lsCloseAll);
end;

procedure TLoginScene.OpenLoginDoor;
begin

  DScreen.ChangeScene(stLogin);
  HideLoginBox;
  m_boNowOpening := True;
  m_dwStartTime := GetTickCount;
{$IF Var_Interface = Var_Mir2}
  PlaySound(s_rock_door_open);
{$IFEND}

  //ClearBGM;
  //PlaySoundEx(bmg_LoginDoor);
end;

procedure TLoginScene.PlayScene(MSurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  LastForm := lf_Login;
  if m_boOpenFirst then begin
    m_boOpenFirst := FALSE;
    FrmDlg.DEditID.SetFocus;
  end;
{$IF Var_Interface = Var_Mir2}
  d := g_WOChrSelImages.Images[LOGINBAGIMGINDEX];
{$ELSE}
  d := g_WMain99Images.Images[LOGINBAGIMGINDEX];
{$IFEND}
  if (d <> nil) and (g_boCanDraw) then begin
    MSurface.Draw(0, 0, d.ClientRect, d, FALSE);
    with g_DXCanvas do begin
      TextOut(DEFSCREENWIDTH - TextWidth(CLIENTUPDATETIME) - 1, DEFSCREENHEIGHT - TextHeight(CLIENTUPDATETIME) - 1, clYellow, CLIENTUPDATETIME);
{$IF Var_Interface = Var_Mir2}
      TextOut(359, 530, $88ECF0, '健康游戏公告');
      TextOut(191, 552, $88ECF0, '抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防受骗上当。适度游戏益脑，');
      TextOut(191, 574, $88ECF0, '沉迷游戏伤身。合理安排时间，享受健康生活。严厉打击赌博，营造和谐环境。');
{$IFEND}
    end;
  end;
  if m_boNowOpening then begin
    //开门速度
    if GetTickCount - m_dwStartTime > 20 then begin
      m_dwStartTime := GetTickCount;
      Inc(m_nCurFrame);
    end;
    if m_nCurFrame >= m_nMaxFrame - 1 then begin
      m_nCurFrame := m_nMaxFrame - 1;
      DScreen.ChangeScene(stSelectChr);
    end;
{$IF Var_Interface = Var_Mir2}
    d := g_WOChrSelImages.Images[23 + m_nCurFrame];
    if (d <> nil) and (g_boCanDraw) then
      MSurface.Draw({(g_FScreenWidth - DEFSCREENWIDTH) div 2 + }152, {(g_FScreenHeight - DEFSCREENHEIGHT) div 2 + }96, d.ClientRect, d, True);
{$ELSE}
    d := g_WMain99Images.Images[9];
    if (d <> nil) and (g_boCanDraw) then
      MSurface.Draw(15, g_FScreenHeight div m_nMaxFrame * (m_nCurFrame + 1) - g_FScreenHeight + 3, d.ClientRect, d, True);
{$IFEND}         

  end;
end;

procedure TLoginScene.CardOK;
var
  No1, No2, No3: Integer;
begin
  No1 := StrToIntDef(FrmDlg2.DCardNo1.Text, -1);
  No2 := StrToIntDef(FrmDlg2.DCardNo2.Text, -1);
  No3 := StrToIntDef(FrmDlg2.DCardNo3.Text, -1);
  if (No1 < 0) then begin
    FrmDlg2.DCardNo1.SetFocus;
    Beep;
    exit;
  end;
  if (No2 < 0) then begin
    FrmDlg2.DCardNo2.SetFocus;
    Beep;
    exit;
  end;
  if (No3 < 0) then begin
    FrmDlg2.DCardNo3.SetFocus;
    Beep;
    exit;
  end;
  FrmDlg.HintBack := stSelServer;
  FrmDlg.sHintStr := '正在验证密保卡信息。。。';
  FrmDlg.DBTHintClose.Caption := '取消';
  FrmDlg.boHintFocus := False;
  DScreen.ChangeScene(stHint);
  frmMain.SendCardInfo(No1, No2, No3);
end;

procedure TLoginScene.ChangeLoginState(State: TLoginState);
var
  i, focus: Integer;
  c: TControl;
begin
  focus := -1;
  case State of
    lsLogin: focus := 10;
    lsNewid: focus := 11;
    lsChgpw: focus := 12;
    lsCloseAll: focus := -1;
  end;
  with FrmDlg do begin //login
    for i := 0 to ControlCount - 1 do begin
      c := Controls[i];
      if c is TDEdit then begin
        if c.tag = focus then begin
          TDEdit(c).Text := '';
        end;
      end;
    end;
    case State of
      lsLogin: begin
          FrmDlg.DNewAccount.Visible := FALSE;
          FrmDlg.DChgPw.Visible := FALSE;
          FrmDlg.DLogin.Visible := True;
          FrmDlg2.DMatrixCardWnd.Visible := False;
          FrmDlg.DEditID.SetFocus;
        end;
      lsNewid: begin
          FrmDlg.DNewAccount.Visible := True;
          FrmDlg.DChgPw.Visible := FALSE;
          FrmDlg.DLogin.Visible := FALSE;
          FrmDlg2.DMatrixCardWnd.Visible := False;
          FrmDlg.DEditBirthDay.Text := '1988/01/01';
          FrmDlg.DEditNewId.SetFocus;
        end;
      lsChgpw: begin
          FrmDlg.DNewAccount.Visible := FALSE;
          FrmDlg.DChgPw.Visible := True;
          FrmDlg.DLogin.Visible := FALSE;
          FrmDlg2.DMatrixCardWnd.Visible := False;
          FrmDlg.DEditChgId.SetFocus;
        end;
      lsCard: begin
          FrmDlg.DNewAccount.Visible := FALSE;
          FrmDlg.DChgPw.Visible := FALSE;
          FrmDlg.DLogin.Visible := FALSE;
          FrmDlg2.DMatrixCardWnd.Visible := True;
          FrmDlg2.DCardNo1.Text := '';
          FrmDlg2.DCardNo2.Text := '';
          FrmDlg2.DCardNo3.Text := '';
          FrmDlg2.DCardNo1.SetFocus;
          m_boOpenFirst := False;
        end;
      lsCloseAll: begin
          FrmDlg.DNewAccount.Visible := FALSE;
          FrmDlg.DChgPw.Visible := FALSE;
          FrmDlg.DLogin.Visible := FALSE;
          FrmDlg2.DMatrixCardWnd.Visible := False;
        end;
      lsNewidRetry: begin
          FrmDlg.DNewAccount.Visible := True;
          FrmDlg.DChgPw.Visible := FALSE;
          FrmDlg.DLogin.Visible := FALSE;
          FrmDlg2.DMatrixCardWnd.Visible := False;
          FrmDlg.DEditNewId.SetFocus;
        end;
    end;
  end;
end;

procedure TLoginScene.NewClick;
begin
  ChangeLoginState(lsNewid);
end;

procedure TLoginScene.OkClick;
var
  Key: Char;
begin
  Key := #13;
  EdLoginPasswdKeyPress(Self, Key);
end;

procedure TLoginScene.ChgPwClick;
begin
  ChangeLoginState(lsChgpw);
end;

function TLoginScene.CheckUserEntrys: Boolean;
begin
  Result := FALSE;
  FrmDlg.DEditNewId.Text := Trim(FrmDlg.DEditNewId.Text);
  FrmDlg.DEditQuiz1.Text := Trim(FrmDlg.DEditQuiz1.Text);
  FrmDlg.DEditYourName.Text := Trim(FrmDlg.DEditYourName.Text);
  if not NewIdCheckNewId then
    Exit;
  if Length(FrmDlg.DEditNewPasswd.Text) < 5 then begin
    FrmDlg.DMessageDlg('密码长度不能少于5位.', [mbOk]);
    Beep;
    FrmDlg.DEditNewPasswd.SetFocus;
    Exit;
  end;
  if not NewIdCheckBirthDay then
    Exit;
  if Length(FrmDlg.DEditNewId.Text) < 6 then begin
    FrmDlg.DEditNewId.SetFocus;
    Exit;
  end;

  if FrmDlg.DEditNewPasswd.Text <> FrmDlg.DEditConfirm.Text then begin
    FrmDlg.DEditConfirm.SetFocus;
    Exit;
  end;
  if Length(FrmDlg.DEditQuiz1.Text) < 1 then begin
    FrmDlg.DEditQuiz1.SetFocus;
    Exit;
  end;
  if Length(FrmDlg.DEditAnswer1.Text) < 1 then begin
    FrmDlg.DEditAnswer1.SetFocus;
    Exit;
  end;
  if Length(FrmDlg.DEditQuiz2.Text) < 1 then begin
    FrmDlg.DEditQuiz2.SetFocus;
    Exit;
  end;
  if Length(FrmDlg.DEditAnswer2.Text) < 1 then begin
    FrmDlg.DEditAnswer2.SetFocus;
    Exit;
  end;
  if Length(FrmDlg.DEditYourName.Text) < 1 then begin
    FrmDlg.DEditYourName.SetFocus;
    Exit;
  end;
  Result := True;
end;

procedure TLoginScene.NewAccountOk;
var
  ue: TUserEntry;
  ua: TUserEntryAdd;
begin
  if CheckUserEntrys then begin
    SafeFillChar(ue, sizeof(TUserEntry), #0);
    SafeFillChar(ua, sizeof(TUserEntryAdd), #0);
    ue.sAccount := LowerCase(FrmDlg.DEditNewId.Text);
    ue.sPassword := FrmDlg.DEditNewPasswd.Text;
    ue.sUserName := FrmDlg.DEditYourName.Text;

    ue.sSSNo := FrmDlg.DEditRecommendation.Text;

    ue.sQuiz := FrmDlg.DEditQuiz1.Text;
    ue.sAnswer := Trim(FrmDlg.DEditAnswer1.Text);
    ue.sPhone := FrmDlg.DEditPhone.Text;
    ue.sEMail := Trim(FrmDlg.DEditEMail.Text);

    ua.sQuiz2 := FrmDlg.DEditQuiz2.Text;
    ua.sAnswer2 := Trim(FrmDlg.DEditAnswer2.Text);
    ua.sBirthDay := FrmDlg.DEditBirthDay.Text;
    ua.sMobilePhone := FrmDlg.DEditMobPhone.Text;

    m_NewIdRetryUE := ue; //犁矫档锭 荤侩
    m_NewIdRetryUE.sAccount := '';
    m_NewIdRetryUE.sPassword := '';
    m_NewIdRetryAdd := ua;
    frmMain.SendNewAccount(ue, ua);
    NewAccountClose;
    FrmDlg.HintBack := stSelServer;
    FrmDlg.sHintStr := '正在创建游戏帐号。。。';
    FrmDlg.DBTHintClose.Caption := '取消';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
  end;
end;

procedure TLoginScene.NewAccountClose;
begin
  ChangeLoginState(lsLogin);
end;

procedure TLoginScene.ChgpwOk;
var
  uid, passwd, newpasswd: string;
begin
  if FrmDlg.DEditChgNewPw.Text = FrmDlg.DEditChgRepeat.Text then begin
    uid := FrmDlg.DEditChgId.Text;
    passwd := FrmDlg.DEditChgCurrentpw.Text;
    newpasswd := FrmDlg.DEditChgNewPw.Text;
    ChgpwCancel;
    FrmDlg.HintBack := stSelServer;
    FrmDlg.sHintStr := '正在验证账号信息。。。';
    FrmDlg.DBTHintClose.Caption := '取消';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
    frmMain.SendChgPw(uid, passwd, newpasswd);
  end
  else begin
    FrmDlg.DMessageDlg('二次输入的密码不匹配！！！。', [mbOk]);
    FrmDlg.DEditChgNewPw.SetFocus;
  end;
end;

procedure TLoginScene.ChgpwCancel;
begin
  ChangeLoginState(lsLogin);
end;

{-------------------- TSelectChrScene ------------------------}

constructor TSelectChrScene.Create;
begin
  //CreateChrMode := FALSE;
  SafeFillChar(ChrArr, sizeof(TSelChar) * 3, #0);
  ChrArr[0].FreezeState := True; //扁夯捞 倔绢 乐绰 惑怕
  ChrArr[1].FreezeState := True;
  ChrArr[2].FreezeState := True;
  NewIndex := 0;

  SoundTimer := TTimer.Create(frmMain.Owner);
  with SoundTimer do begin
    OnTimer := SoundOnTimer;
    Interval := 1;
    Enabled := FALSE;
  end;
  inherited Create(stSelectChr);
end;

destructor TSelectChrScene.Destroy;
begin
  inherited Destroy;
end;

procedure TSelectChrScene.OpenScene;
begin
  HGE.Gfx_Restore(DEFSCREENWIDTH, DEFSCREENHEIGHT, 16);
  FrmDlg.DSelectChr.Visible := True;
  SoundTimer.Enabled := True;
  SoundTimer.Interval := 100;
  ChangeSelectChrState(scSelectChr);
  
end;

procedure TSelectChrScene.CloseScene;
begin
  //  ClearBGM;
{$IF Var_Interface = Var_Mir2}
  SilenceSound;
  FrmDlg.DCreateChr.Visible := FALSE;
  FrmDlg.DRenewChr.Visible := FALSE;
{$IFEND}
  FrmDlg.DSelectChr.Visible := FALSE;
  SoundTimer.Enabled := FALSE;
end;

procedure TSelectChrScene.SoundOnTimer(Sender: TObject);
begin
  //PlayBGM(bmg_select);
{$IF Var_Interface = Var_Mir2}
  SilenceSound;
  PlayBGM(bmg_select);
{$ELSE}
  PlayBGM(bmg_SelChr);
{$IFEND}

  SoundTimer.Enabled := FALSE;
  //SoundTimer.Interval := 38 * 1000;
end;

procedure TSelectChrScene.SelChrSelect1Click;
begin
  if (not ChrArr[0].Selected) and (ChrArr[0].Valid) then begin
    ChrArr[0].Freezing := FALSE; //促 倔菌澜
    ChrArr[0].FreezeState := True; //
    ChrArr[0].Selected := True;
    ChrArr[1].Selected := FALSE;
    if ChrArr[1].Unfreezing then
      ChrArr[1].FreezeState := False;
    ChrArr[1].Unfreezing := False;
    ChrArr[2].Selected := FALSE;
    if ChrArr[2].Unfreezing then
      ChrArr[2].FreezeState := False;
    ChrArr[2].Unfreezing := False;

    ChrArr[0].Unfreezing := True;
    ChrArr[0].AniIndex := 0;
    ChrArr[0].DarkLevel := 0;
    ChrArr[0].EffIndex := 0;
    ChrArr[0].StartTime := GetTickCount;
    ChrArr[0].moretime := GetTickCount;
    ChrArr[0].startefftime := GetTickCount;
    PlaySound(s_meltstone);
  end;
end;

procedure TSelectChrScene.SelChrSelect2Click;
begin
  if (not ChrArr[1].Selected) and (ChrArr[1].Valid) then begin
    ChrArr[1].Freezing := FALSE; //促 倔菌澜
    ChrArr[1].FreezeState := True; //
    ChrArr[1].Selected := True;
    ChrArr[0].Selected := FALSE;
    if ChrArr[0].Unfreezing then
      ChrArr[0].FreezeState := False;
    ChrArr[0].Unfreezing := False;
    ChrArr[2].Selected := FALSE;
    if ChrArr[2].Unfreezing then
      ChrArr[2].FreezeState := False;
    ChrArr[2].Unfreezing := False;
    ChrArr[1].Unfreezing := True;
    ChrArr[1].AniIndex := 0;
    ChrArr[1].DarkLevel := 0;
    ChrArr[1].EffIndex := 0;
    ChrArr[1].StartTime := GetTickCount;
    ChrArr[1].moretime := GetTickCount;
    ChrArr[1].startefftime := GetTickCount;
    PlaySound(s_meltstone);
  end;
end;

procedure TSelectChrScene.SelChrSelect3Click;
begin
  if (not ChrArr[2].Selected) and (ChrArr[2].Valid) then begin
    ChrArr[2].Freezing := FALSE; //促 倔菌澜
    ChrArr[2].FreezeState := True; //
    ChrArr[2].Selected := True;
    ChrArr[0].Selected := FALSE;
    if ChrArr[0].Unfreezing then
      ChrArr[0].FreezeState := False;
    ChrArr[0].Unfreezing := False;

    ChrArr[1].Selected := FALSE;
    if ChrArr[1].Unfreezing then
      ChrArr[1].FreezeState := False;
    ChrArr[1].Unfreezing := False;
    ChrArr[2].Unfreezing := True;
    ChrArr[2].AniIndex := 0;
    ChrArr[2].DarkLevel := 0;
    ChrArr[2].EffIndex := 0;
    ChrArr[2].StartTime := GetTickCount;
    ChrArr[2].moretime := GetTickCount;
    ChrArr[2].startefftime := GetTickCount;
    PlaySound(s_meltstone);
  end;
end;

procedure TSelectChrScene.SelChrStartClick;
var
  chrname: string;
  //chrid: integer;
begin
  chrname := '';
  //chrid := 0;
  if ChrArr[0].Valid and ChrArr[0].Selected then begin
    chrname := ChrArr[0].UserChr.name;
    //chrid := ChrArr[0].UserChr.ID;
  end;
  if ChrArr[1].Valid and ChrArr[1].Selected then begin
    chrname := ChrArr[1].UserChr.name;
    //chrid := ChrArr[1].UserChr.ID;
  end;
  if ChrArr[2].Valid and ChrArr[2].Selected then begin
    chrname := ChrArr[2].UserChr.name;
    //chrid := ChrArr[2].UserChr.ID;
  end;
  if chrname <> '' then begin
    frmMain.SendSelChr(chrname);
    LastForm := lf_Play;
    FrmDlg.HintBack := stSelServer;
    FrmDlg.sHintStr := '正在准备进入服务器。。。';
    FrmDlg.DBTHintClose.Caption := '取消';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);

  end
  else
    FrmDlg.DMessageDlg('还没创建游戏角色！\点击创建角色按钮创建一个游戏角色。', [mbOk]);
end;

procedure TSelectChrScene.SelChrNewChrClick;
begin
{$IF Var_Interface = Var_Mir2}
  if (not ChrArr[0].Valid) or (not ChrArr[1].Valid) then begin
    if not ChrArr[0].Valid then MakeNewChar(0)
    else MakeNewChar(1);
  end
  else
    FrmDlg.DMessageDlg('一个帐号最多只能创建两个游戏角色！', [mbOk]);
{$ELSE}
  if (not ChrArr[0].Valid) or (not ChrArr[1].Valid) or (not ChrArr[2].Valid) then begin
    MakeNewChar(1);
  end
  else
    FrmDlg.DMessageDlg('一个帐号最多只能创建三个游戏角色！', [mbOk]);
{$IFEND}

end;

procedure TSelectChrScene.SelChrEraseChrClick;
var
  n: Integer;
begin
  n := 0;
  if ChrArr[0].Valid and ChrArr[0].Selected then
    n := 0;
  if ChrArr[1].Valid and ChrArr[1].Selected then
    n := 1;
  if ChrArr[2].Valid and ChrArr[2].Selected then
    n := 2;
  if (ChrArr[n].Valid) and (not ChrArr[n].FreezeState) and
    (ChrArr[n].UserChr.name <> '') then begin
    //版绊 皋技瘤甫 焊辰促.
    if mrYes = FrmDlg.DMessageDlg('"' + ChrArr[n].UserChr.name + '" 是否确认删除此角色？', [mbYes, mbNo]) then begin
      frmMain.SendDelChr(ChrArr[n].UserChr.Name);
      FrmDlg.HintBack := stSelServer;
      FrmDlg.sHintStr := '正在删除人物，请稍候。。。';
      FrmDlg.DBTHintClose.Caption := '取消';
      FrmDlg.boHintFocus := False;
      DScreen.ChangeScene(stHint);
    end;
  end;
end;

procedure TSelectChrScene.SelChrCreditsClick;
begin
  if FrmDlg.DRenewChr.Visible then
    Exit;
{$IF Var_Interface = Var_Mir2}
  if (not ChrArr[0].Valid) or (not ChrArr[1].Valid) then begin
    FrmMain.SendViewDelHum;
    FrmDlg.HintBack := stSelectChr;
    FrmDlg.sHintStr := '正在获取恢复信息，请稍候。。。';
    FrmDlg.DBTHintClose.Caption := '取消';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
  end
  else
    FrmDlg.DMessageDlg('你已经创建了两个人物。', [mbOk]);
{$ELSE}
  if (not ChrArr[0].Valid) or (not ChrArr[1].Valid) or (not ChrArr[2].Valid) then begin
    FrmMain.SendViewDelHum;
    FrmDlg.HintBack := stSelectChr;
    FrmDlg.sHintStr := '正在获取恢复信息，请稍候。。。';
    FrmDlg.DBTHintClose.Caption := '取消';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
  end
  else
    FrmDlg.DMessageDlg('你已经创建了三个人物。', [mbOk]);
{$IFEND}

end;

procedure TSelectChrScene.SelChrExitClick;
begin
  //frmMain.Close;
  FrmMain.CSocket.Active := False;
  DScreen.ChangeScene(stSelServer);
end;

procedure TSelectChrScene.ChangeSelectChrState(State: TSelectChrState);
begin

{$IF Var_Interface = Var_Mir2}
  CreateChrMode := False;
{$ELSE}
  CreateChrMode := True;
{$IFEND}
  case State of
    scSelectChr: begin
        CreateChrMode := False;
{$IF Var_Interface = Var_Mir2}
        FrmDlg.DSelectChr.Visible := True;
{$IFEND}
        FrmDlg.DCreateChr.Visible := False;
        FrmDlg.DCreateChr2.Visible := False;
        FrmDlg.DRenewChr.Visible := False;
      end;
    scCreateChr: begin
        FrmDlg.DRenewChr.Visible := False;

{$IF Var_Interface = Var_Mir2}
        FrmDlg.DSelectChr.Visible := False;
        FrmDlg.DCreateChr.Visible := True;
        FrmDlg.DEditChrName.SetFocus;
{$ELSE}
        if g_boCreateHumIsNew then begin
          FrmDlg.DCreateChr.Visible := True;
          FrmDlg.DEditChrName.SetFocus;
        end
        else begin
          FrmDlg.DCreateChr2.Visible := True;
          FrmDlg.DEditChrName2.SetFocus;
        end;
{$IFEND}
      end;
    scRenewChr: begin
{$IF Var_Interface = Var_Mir2}
        FrmDlg.DSelectChr.Visible := False;
{$IFEND}
        FrmDlg.DCreateChr.Visible := False;
        FrmDlg.DCreateChr2.Visible := False;
        FrmDlg.DRenewChr.Visible := True;
      end;
  end;
  FrmDlg.DscSelect1.Visible := not CreateChrMode;
  FrmDlg.DscSelect2.Visible := not CreateChrMode;
  FrmDlg.DscSelect3.Visible := not CreateChrMode;
  FrmDlg.DscStart.Visible := not CreateChrMode;
  FrmDlg.DscNewChr.Visible := not CreateChrMode;
  FrmDlg.DscEraseChr.Visible := not CreateChrMode;
  FrmDlg.DscCredits.Visible := not CreateChrMode;
  FrmDlg.DscExit.Visible := not CreateChrMode;
end;

procedure TSelectChrScene.ClearChrs;
begin
  SafeFillChar(ChrArr, sizeof(TSelChar) * 3, #0);
  ChrArr[0].FreezeState := FALSE;
  ChrArr[1].FreezeState := True; //扁夯捞 倔绢 乐绰 惑怕
  ChrArr[2].FreezeState := True;
  ChrArr[0].Selected := True;
  ChrArr[1].Selected := FALSE;
  ChrArr[2].Selected := FALSE;
  ChrArr[0].UserChr.name := '';
  ChrArr[1].UserChr.name := '';
  ChrArr[2].UserChr.name := '';
end;

procedure TSelectChrScene.AddChr(uname: string; ID, job, wuxin, Level, sex: Integer; LoginTime: TDateTime);
var
  n: Integer;
begin
  if not ChrArr[0].Valid then
    n := 0
  else if not ChrArr[1].Valid then
    n := 1
  else if not ChrArr[2].Valid then
    n := 2
  else
    Exit;
  ChrArr[n].UserChr.ID := ID;
  ChrArr[n].UserChr.name := uname;
  ChrArr[n].UserChr.job := job;
  ChrArr[n].UserChr.wuxin := wuxin;
  ChrArr[n].UserChr.Level := Level;
  ChrArr[n].UserChr.sex := sex;
  ChrArr[n].UserChr.LoginTime := LoginTime;
  ChrArr[n].Valid := True;
end;

procedure TSelectChrScene.MakeNewChar(Index: Integer);
begin
  FrmDlg.btWuXin := Random(5);
{$IF Var_Interface = Var_Mir2}
  NewIndex := index;
  if index = 0 then begin
    FrmDlg.DCreateChr.Left := 415;
    FrmDlg.DCreateChr.Top := 15;
  end else begin
    FrmDlg.DCreateChr.Left := 75;
    FrmDlg.DCreateChr.Top := 15;
  end;
  ChrArr[NewIndex].Valid := TRUE;
  ChrArr[NewIndex].FreezeState := FALSE;
  SelectChr(index);
{$IFEND}
  ChangeSelectChrState(scCreateChr);
end;

procedure TLoginScene.EdCardKeyPress(Sender: TObject; var Key: Char);
begin
  {if Sender = FrmDlg2.DCardNo1 then begin
    if (Length(FrmDlg2.DCardNo1.Text) >= 1) then begin
      FrmDlg2.DCardNo2.SetFocus;
      Exit;
    end;
  end;
  if Sender = FrmDlg2.DCardNo2 then begin
    if (Length(FrmDlg2.DCardNo2.Text) >= 1) then begin
      FrmDlg2.DCardNo3.SetFocus;
      Exit;
    end;
  end;     }
  if (Sender = FrmDlg2.DCardNo3) and (Key = #13) then begin
    CardOK;
  end;
end;

procedure TLoginScene.EdChrnameKeyPress(Sender: TObject; var Key: Char);
begin

end;

procedure TSelectChrScene.SelectChr(Index: Integer);
begin
  ChrArr[Index].Selected := True;
  ChrArr[Index].DarkLevel := 30;
  ChrArr[Index].StartTime := GetTickCount;
  ChrArr[Index].moretime := GetTickCount;
  if Index = 0 then begin
    ChrArr[1].Selected := FALSE;
    ChrArr[2].Selected := FALSE;
  end
  else if Index = 1 then begin
    ChrArr[0].Selected := FALSE;
    ChrArr[2].Selected := FALSE;
  end
  else begin
    ChrArr[0].Selected := FALSE;
    ChrArr[1].Selected := FALSE;
  end;

end;

procedure TSelectChrScene.SelRenewChr;
begin
  if (FrmDlg.RenewChrIdx - 1) in [Low(RenewChr)..high(RenewChr)] then begin
    FrmMain.SendRenewHum(RenewChr[FrmDlg.RenewChrIdx - 1].Name);
    FrmDlg.HintBack := stSelServer;
    FrmDlg.sHintStr := '正在恢复人物，请稍候。。。';
    FrmDlg.DBTHintClose.Caption := '取消';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
  end;
end;

procedure TSelectChrScene.SelChrNewClose;
begin
{$IF Var_Interface = Var_Mir2}
   ChrArr[NewIndex].Valid := FALSE;
   if NewIndex = 1 then begin
      ChrArr[0].Selected := TRUE;
      ChrArr[0].FreezeState := FALSE;
   end;
{$IFEND}
  ChangeSelectChrState(scSelectChr);
end;

procedure TSelectChrScene.SelChrNewOk;
var
  chrname, shair, sjob, ssex: string;
begin
{$IF Var_Interface = Var_Mir2}
  chrname := Trim(FrmDlg.DEditChrName.Text);
{$ELSE}
  if g_boCreateHumIsNew then
    chrname := Trim(FrmDlg.DEditChrName.Text)
  else
    chrname := Trim(FrmDlg.DEditChrName2.Text);  
{$IFEND}

  if (chrname <> '') then begin
    if not (Length(chrname) in [6..14]) then begin
      FrmDlg.DMessageDlg('[失败]: 角色名长度为3~7个汉字', []);
      exit;
    end;
    if not CheckCorpsChr(chrname) then begin
      FrmDlg.DMessageDlg('[失败]: 你的角色名称中包含了特殊字符！\' +
        '        只能使用 简体中文 和 中文特殊符号。', []);
      exit;
    end;
{$IF Var_Interface = Var_Mir2}

    ChrArr[NewIndex].Valid := FALSE;
   if NewIndex = 1 then begin
      ChrArr[0].Selected := TRUE;
      ChrArr[0].FreezeState := FALSE;
   end;  
{$IFEND}
    shair := IntToStr(FrmDlg.btWuXin + 1);
    sjob := IntToStr(FrmDlg.btjob);
    ssex := IntToStr(FrmDlg.btsex);
    frmMain.SendNewChr(frmMain.LoginID, chrname, shair, sjob, ssex);
    frmMain.CreateChrName := chrname;
    FrmDlg.HintBack := stSelServer;
    FrmDlg.sHintStr := '正在创建人物，请稍候。。。';
    FrmDlg.DBTHintClose.Caption := '取消';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
  end;
end;

procedure TSelectChrScene.SelChrNewJob(job: Integer);
begin
  if (job in [0..2]) and (ChrArr[NewIndex].UserChr.job <> job) then begin
    ChrArr[NewIndex].UserChr.job := job;
    SelectChr(NewIndex);
  end;
end;

procedure TSelectChrScene.SelChrNewm_btSex(sex: Integer);
begin
  if sex <> ChrArr[NewIndex].UserChr.sex then begin
    ChrArr[NewIndex].UserChr.sex := sex;
    SelectChr(NewIndex);
  end;
end;

procedure TSelectChrScene.SelChrNewPrevHair;
begin
end;

procedure TSelectChrScene.SelChrNewNextHair;
begin
end;

procedure TSelectChrScene.PlayScene(MSurface: TDirectDrawSurface);
var
  n, fx, fy, img: Integer;
  ex, ey: Integer; //选择人物时显示的效果光位置
  d, E: TDirectDrawSurface;
  svname: string;
{$IF Var_Interface = Var_Mir2}
  bx, by: Integer;
{$IFEND}
begin
  //  bx := 0;
  //  by := 0;
  LastForm := lf_SelectChr;
  fx := 0;
  fy := 0; //Jacky
{$IF Var_Interface = Var_Mir2}
  bx := 0;
  by := 0;
  d := g_WMain99Images.Images[2062];
{$ELSE}
  d := g_WMain99Images.Images[LOGINBAGIMGINDEX];
{$IFEND}

  //显示选择人物背景画面
  if (d <> nil) and (g_boCanDraw) then begin
    //      MSurface.Draw (0, 0, d.ClientRect, d, FALSE);
    MSurface.Draw((DEFSCREENWIDTH - d.Width) div 2, (DEFSCREENHEIGHT - d.Height) div 2, d.ClientRect, d, FALSE);
    if CreateChrMode then
      exit;
{$IF Var_Interface =  Var_Default}
    d := g_WMain99Images.Images[9];
    if d <> nil then begin
      MSurface.Draw(15, 3, d.ClientRect, d, True);
    end;
{$IFEND}
    if (g_boCanDraw) then begin
      with g_DXCanvas do begin
        //SetBkMode(Canvas.Handle, TRANSPARENT);
        svname := g_sServerName;
{$IF Var_Interface = Var_Mir2}
        TextOut(DEFSCREENWIDTH div 2 + 3 - TextWidth(svname) div 2, 8, clWhite, svname);
{$ELSE}
        TextOut(DEFSCREENWIDTH div 2 {405} - TextWidth(svname) div 2, (DEFSCREENHEIGHT - 600) div 2 + 18 {8}, clWhite, svname);
{$IFEND}

        //Canvas.Release;
      end;
    end;
{$IF Var_Interface =  Var_Default}
    with g_DXCanvas do begin
      TextOut(DEFSCREENWIDTH - TextWidth(CLIENTUPDATETIME) - 1, DEFSCREENHEIGHT - TextHeight(CLIENTUPDATETIME) - 1, clYellow, CLIENTUPDATETIME);
    end;
{$IFEND}
  end;
  if not g_boCanDraw then
    exit;

{$IF Var_Interface = Var_Mir2}
  for n := 0 to 1 do begin
    if ChrArr[n].Valid then begin
      ex := (DEFSCREENWIDTH - 800) div 2 + 90 {90};
      ey := (DEFSCREENHEIGHT - 600) div 2 + 60 - 2 {60-2};
      case ChrArr[n].UserChr.Job of
        0: begin
            if ChrArr[n].UserChr.Sex = 0 then begin
              bx := (DEFSCREENWIDTH - 800) div 2 + 71 {71};
              by := (DEFSCREENHEIGHT - 600) div 2 + 75 - 23 {75-23}; //巢磊
              fx := bx;
              fy := by;
            end
            else begin
              bx := (DEFSCREENWIDTH - 800) div 2 + 65 {65};
              by := (DEFSCREENHEIGHT - 600) div 2 + 75 - 2 - 18 {75-2-18}; //咯磊  倒惑怕
              fx := bx - 28 + 28;
              fy := by - 16 + 16; //框流捞绰 惑怕
            end;
          end;
        1: begin
            if ChrArr[n].UserChr.Sex = 0 then begin
              bx := (DEFSCREENWIDTH - 800) div 2 + 77 {77};
              by := (DEFSCREENHEIGHT - 600) div 2 + 75 - 29 {75-29};
              fx := bx;
              fy := by;
            end
            else begin
              bx := (DEFSCREENWIDTH - 800) div 2 + 141 + 30 {141+30};
              by := (DEFSCREENHEIGHT - 600) div 2 + 85 + 14 - 2 {85+14-2};
              fx := bx - 30;
              fy := by - 14;
            end;
          end;
        2: begin
            if ChrArr[n].UserChr.Sex = 0 then begin
              bx := (DEFSCREENWIDTH - 800) div 2 + 85 {85};
              by := (DEFSCREENHEIGHT - 600) div 2 + 75 - 12 {75-12};
              fx := bx;
              fy := by;
            end
            else begin
              bx := (DEFSCREENWIDTH - 800) div 2 + 141 + 23 {141+23};
              by := (DEFSCREENHEIGHT - 600) div 2 + 85 + 20 - 2 {85+20-2};
              fx := bx - 23;
              fy := by - 20;
            end;
          end;
      end;
      if n = 1 then begin
        ex := (DEFSCREENWIDTH - 800) div 2 + 430 {430};
        ey := (DEFSCREENHEIGHT - 600) div 2 + 60 {60};
        bx := bx + 340;
        by := by + 2;
        fx := fx + 340;
        fy := fy + 2;
      end;
      if ChrArr[n].Unfreezing then begin //踌绊 乐绰 吝
        img := 140 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
        d := g_WOChrSelImages.Images[img + ChrArr[n].aniIndex];
        e := g_WOChrSelImages.Images[4 + ChrArr[n].effIndex];
        if d <> nil then
          MSurface.Draw(bx, by, d.ClientRect, d, TRUE);
        if e <> nil then
          DrawBlend(MSurface, ex, ey, e, 1);
        if GetTickCount - ChrArr[n].StartTime > 50 {120} then begin
          ChrArr[n].StartTime := GetTickCount;
          ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
        end;
        if GetTickCount - ChrArr[n].startefftime > 50 { 110} then begin
          ChrArr[n].startefftime := GetTickCount;
          ChrArr[n].effIndex := ChrArr[n].effIndex + 1;
          //if ChrArr[n].effIndex > EFFECTFRAME-1 then
          //   ChrArr[n].effIndex := EFFECTFRAME-1;
        end;
        if ChrArr[n].aniIndex > FREEZEFRAME - 1 then begin
          ChrArr[n].Unfreezing := FALSE; //促 踌疽澜
          ChrArr[n].FreezeState := FALSE; //
          ChrArr[n].aniIndex := 0;
        end;
      end
      else if not ChrArr[n].Selected and (not ChrArr[n].FreezeState and not ChrArr[n].Freezing) then begin
        ChrArr[n].Freezing := TRUE;
        ChrArr[n].aniIndex := 0;
        ChrArr[n].StartTime := GetTickCount;
      end;
      if ChrArr[n].Freezing then begin //倔绊 乐绰 吝
        img := 140 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
        d := g_WOChrSelImages.Images[img + FREEZEFRAME - ChrArr[n].aniIndex - 1];
        if d <> nil then
          MSurface.Draw(bx, by, d.ClientRect, d, TRUE);
        if GetTickCount - ChrArr[n].StartTime > 50 then begin
          ChrArr[n].StartTime := GetTickCount;
          ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
        end;
        if ChrArr[n].aniIndex > FREEZEFRAME - 1 then begin
          ChrArr[n].Freezing := FALSE; //促 倔菌澜
          ChrArr[n].FreezeState := TRUE; //
          ChrArr[n].aniIndex := 0;
        end;
      end;
      if not ChrArr[n].Unfreezing and not ChrArr[n].Freezing then begin
        if not ChrArr[n].FreezeState then begin //踌酒乐绰惑怕
          img := 120 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].aniIndex + ChrArr[n].UserChr.Sex * 120;
          d := g_WOChrSelImages.Images[img];
          if d <> nil then begin
            {if ChrArr[n].DarkLevel > 0 then begin
              dd := TDirectDrawSurface.Create(frmMain.DXDraw.DDraw);
              dd.SystemMemory := TRUE;
              dd.SetSize(d.Width, d.Height);
              dd.Draw(0, 0, d.ClientRect, d, FALSE);
              //MakeDark (dd, 30-ChrArr[n].DarkLevel);
              MSurface.Draw(fx, fy, dd.ClientRect, dd, TRUE);
              dd.Free;
            end
            else  }
            MSurface.Draw(fx, fy, d.ClientRect, d, TRUE);

          end;
        end
        else begin //倔绢乐绰惑怕
          img := 140 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
          d := g_WOChrSelImages.Images[img];
          if d <> nil then
            MSurface.Draw(bx, by, d.ClientRect, d, TRUE);
        end;
        if ChrArr[n].Selected then begin
          if GetTickCount - ChrArr[n].StartTime > 200 then begin
            ChrArr[n].StartTime := GetTickCount;
            ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
            if ChrArr[n].aniIndex > SELECTEDFRAME - 1 then
              ChrArr[n].aniIndex := 0;
          end;
          if GetTickCount - ChrArr[n].moretime > 25 then begin
            ChrArr[n].moretime := GetTickCount;
            if ChrArr[n].DarkLevel > 0 then
              ChrArr[n].DarkLevel := ChrArr[n].DarkLevel - 1;
          end;
        end;
      end;
      if (ChrArr[n].UserChr.name <> '') and (g_boCanDraw) then begin
        with g_DXCanvas do begin
          if n = 0 then begin
            with MSurface do begin
              TextOut((DEFSCREENWIDTH - 800) div 2 + 117 {117}, (DEFSCREENHEIGHT - 600) div 2 + 492 + 2 {492+2}, clWhite, ChrArr[n].UserChr.Name);
              TextOut((DEFSCREENWIDTH - 800) div 2 + 117 {117}, (DEFSCREENHEIGHT - 600) div 2 + 523 {523}, clWhite, IntToStr(ChrArr[n].UserChr.Level));
              TextOut((DEFSCREENWIDTH - 800) div 2 + 117 {117}, (DEFSCREENHEIGHT - 600) div 2 + 553 {553}, clWhite, GetJobName(ChrArr[n].UserChr.Job));
            end;
          end
          else begin
            with MSurface do begin
              TextOut((DEFSCREENWIDTH - 800) div 2 + 671 {671}, (DEFSCREENHEIGHT - 600) div 2 + 492 + 4 {492+4}, clWhite, ChrArr[n].UserChr.Name);
              TextOut((DEFSCREENWIDTH - 800) div 2 + 671 {671}, (DEFSCREENHEIGHT - 600) div 2 + 523 + 2 {525}, clWhite, IntToStr(ChrArr[n].UserChr.Level));
              TextOut((DEFSCREENWIDTH - 800) div 2 + 671 {671}, (DEFSCREENHEIGHT - 600) div 2 + 553 + 2 {555}, clWhite, GetJobName(ChrArr[n].UserChr.Job));
            end;
          end;
        end;
      end;
    end;
  end;
{$ELSE}
  for n := 0 to 2 do begin
    {ChrArr[n].UserChr.Job := n;
    ChrArr[n].UserChr.Sex := 1;
    ChrArr[n].FreezeState := True;  }
    if (ChrArr[n].Valid) then begin
      ex := 0;
      ey := 0;
      if n = 0 then begin
        ex := 21 + 110;
        ey := 90 + 170;
      end
      else if n = 1 then begin
        ex := 284 + 110;
        ey := 90 + 170;
      end
      else if n = 2 then begin
        ex := 547 + 110;
        ey := 90 + 170;
      end;

      if ChrArr[n].Unfreezing then begin //解冻进行
        img := 60 + ChrArr[n].UserChr.job * 60 + ChrArr[n].UserChr.sex * 180 + ChrArr[n].AniIndex;
        d := g_WChrSelImages.GetCachedImage(img, fx, fy);
        if (d <> nil) and (g_boCanDraw) then
          MSurface.Draw(ex + fx, ey + fY, d.ClientRect, d, True);
        E := g_WChrSelImages.GetCachedImage(ChrArr[n].EffIndex, fx, fy);
        if (E <> nil) and (g_boCanDraw) then
          DrawBlend(MSurface, ex + fx, ey + fY, E, 1);
        if GetTickCount - ChrArr[n].StartTime > 50 {120} then begin
          ChrArr[n].StartTime := GetTickCount;
          ChrArr[n].AniIndex := ChrArr[n].AniIndex + 1;
        end;
        if GetTickCount - ChrArr[n].startefftime > 50 { 110} then begin
          ChrArr[n].startefftime := GetTickCount;
          ChrArr[n].EffIndex := ChrArr[n].EffIndex + 1;
        end;
        if ChrArr[n].AniIndex > FREEZEFRAME - 1 then begin
          ChrArr[n].Unfreezing := FALSE; //促 踌疽澜
          ChrArr[n].FreezeState := FALSE; //
          ChrArr[n].AniIndex := 0;
        end;
      end
      else if not ChrArr[n].Selected and (not ChrArr[n].FreezeState and not ChrArr[n].Freezing) then begin
        ChrArr[n].Freezing := True;
        ChrArr[n].AniIndex := 0;
        ChrArr[n].StartTime := GetTickCount;
      end;
      if ChrArr[n].Freezing then begin //冰冻进行
        img := 60 + ChrArr[n].UserChr.job * 60 + ChrArr[n].UserChr.sex * 180;
        d := g_WChrSelImages.GetCachedImage(img + FREEZEFRAME - ChrArr[n].AniIndex - 1, fx, fy);
        if (d <> nil) and (g_boCanDraw) then
          MSurface.Draw(ex + fx, ey + fY, d.ClientRect, d, True);
        if GetTickCount - ChrArr[n].StartTime > 50 then begin
          ChrArr[n].StartTime := GetTickCount;
          ChrArr[n].AniIndex := ChrArr[n].AniIndex + 1;
        end;
        if ChrArr[n].AniIndex > FREEZEFRAME - 1 then begin
          ChrArr[n].Freezing := FALSE; //促 倔菌澜
          ChrArr[n].FreezeState := True; //
          ChrArr[n].AniIndex := 0;
        end;
      end;
      if not ChrArr[n].Unfreezing and not ChrArr[n].Freezing then begin
        if not ChrArr[n].FreezeState then begin //正常状态
          img := 20 + ChrArr[n].UserChr.job * 60 + ChrArr[n].UserChr.sex * 180 + ChrArr[n].AniIndex;
          d := g_WChrSelImages.GetCachedImage(img, fx, fy);
          if (d <> nil) and (g_boCanDraw) then begin
            MSurface.Draw(ex + fx, ey + fY, d.ClientRect, d, True);
          end;
          d := g_WChrSelImages.GetCachedImage(img + 20, fx, fy);
          if (d <> nil) and (g_boCanDraw) then begin
            DrawBlend(MSurface, ex + fx, ey + fY, d, 1);
            //MSurface.Draw(ex + fx, ey + fY, d.ClientRect, d, $FFFFFFFF, fxAdd);
          end;
        end
        else begin //处于冰冻状态
          img := 60 + ChrArr[n].UserChr.job * 60 + ChrArr[n].UserChr.sex * 180;
          d := g_WChrSelImages.GetCachedImage(img, fx, fy);
          if (d <> nil) and (g_boCanDraw) then
            MSurface.Draw(ex + fx, ey + fY, d.ClientRect, d, True);
        end;
        if ChrArr[n].Selected then begin
          if GetTickCount - ChrArr[n].StartTime > 200 then begin
            ChrArr[n].StartTime := GetTickCount;
            ChrArr[n].AniIndex := ChrArr[n].AniIndex + 1;
            if ChrArr[n].AniIndex > SELECTEDFRAME - 1 then
              ChrArr[n].AniIndex := 0;
          end;
          if GetTickCount - ChrArr[n].moretime > 25 then begin
            ChrArr[n].moretime := GetTickCount;
            if ChrArr[n].DarkLevel > 0 then
              ChrArr[n].DarkLevel := ChrArr[n].DarkLevel - 1;
          end;
        end;
      end;
      if n = 0 then begin
        ex := 21;
        ey := 90;
      end
      else if n = 1 then begin
        ex := 284;
        ey := 90;
      end
      else if n = 2 then begin
        ex := 547;
        ey := 90;
      end;
      if (ChrArr[n].UserChr.name <> '') and (g_boCanDraw) then begin
        with g_DXCanvas do begin
          TextOut(ex, ey, clSilver, '名称: ' + ChrArr[n].UserChr.name);
          TextOut(ex, ey + 14, clSilver, '职业: ' + GetJobName(ChrArr[n].UserChr.job));
          TextOut(ex, ey + 28, clSilver, '等级: ' + IntToStr(ChrArr[n].UserChr.Level));
          if g_boCreateHumIsNew then
            TextOut(ex, ey + 42, clSilver, '五行: ' + GetWuXinName(ChrArr[n].UserChr.wuxin));
        end;
      end;
    end;
  end;
{$IFEND}
end;

{ TSelServer }

procedure TSelServer.CloseScene;
begin
  //inherited;
  FrmDlg.DWinSelServer.Visible := False;
end;

constructor TSelServer.Create;
begin
  inherited Create(stSelServer);
end;

destructor TSelServer.Destroy;
begin
  inherited Destroy;
end;

procedure TSelServer.OpenScene;
begin
  //inherited OpenScene;
  FrmDlg.DWinSelServer.Visible := True;
  HGE.Gfx_Restore(DEFSCREENWIDTH, DEFSCREENHEIGHT, 16);
{$IF Var_Interface = Var_Mir2}
  PlayBGM(bmg_intro);
{$ELSE}
  PlayBGM(bmg_Login);
{$IFEND}
end;

procedure TSelServer.PlayScene(MSurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  LastForm := lf_Login;
{$IF Var_Interface = Var_Mir2}
  d := g_WOChrSelImages.Images[LOGINBAGIMGINDEX];
{$ELSE}
  d := g_WMain99Images.Images[LOGINBAGIMGINDEX];
{$IFEND}
  if (d <> nil) and (g_boCanDraw) then begin
    MSurface.Draw(0, 0, d.ClientRect, d, FALSE);
    with g_DXCanvas do begin
      TextOut(DEFSCREENWIDTH - TextWidth(CLIENTUPDATETIME) - 1, DEFSCREENHEIGHT - TextHeight(CLIENTUPDATETIME) - 1, clYellow, CLIENTUPDATETIME);
{$IF Var_Interface = Var_Mir2}
      TextOut(359, 530, $88ECF0, '健康游戏公告');
      TextOut(191, 552, $88ECF0, '抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防受骗上当。适度游戏益脑，');
      TextOut(191, 574, $88ECF0, '沉迷游戏伤身。合理安排时间，享受健康生活。严厉打击赌博，营造和谐环境。');
{$IFEND}
    end;
  end;
end;

{ THintScene }

procedure THintScene.CloseScene;
begin
  FrmDlg.DWndHint.Visible := False;
end;

constructor THintScene.Create;
begin
  inherited Create(stHint);
end;

destructor THintScene.Destroy;
begin
  inherited;
end;

procedure THintScene.OpenScene;
begin
  FrmDlg.DWndHint.Visible := True;
  FrmDlg.DBTHintClose.Visible := True;
  HGE.Gfx_Restore(DEFSCREENWIDTH, DEFSCREENHEIGHT, 16);
end;

procedure THintScene.PlayScene(MSurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
{$IF Var_Interface = Var_Mir2}
  if LastForm = lf_Login then begin
    d := g_WOChrSelImages.Images[LOGINBAGIMGINDEX];
    if (d <> nil) and (g_boCanDraw) then begin
      MSurface.Draw(0, 0, d.ClientRect, d, FALSE);
      with g_DXCanvas do begin
        TextOut(DEFSCREENWIDTH - TextWidth(CLIENTUPDATETIME) - 1, DEFSCREENHEIGHT - TextHeight(CLIENTUPDATETIME) - 1, clYellow, CLIENTUPDATETIME);
        TextOut(359, 530, $88ECF0, '健康游戏公告');
        TextOut(191, 552, $88ECF0, '抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防受骗上当。适度游戏益脑，');
        TextOut(191, 574, $88ECF0, '沉迷游戏伤身。合理安排时间，享受健康生活。严厉打击赌博，营造和谐环境。');
      end;
    end;
  end else
  if LastForm = lf_SelectChr then begin
    SelectChrScene.PlayScene(MSurface);
  end;
{$ELSE}
  d := g_WMain99Images.Images[LOGINBAGIMGINDEX];
  if (d <> nil) and (g_boCanDraw) then begin
    MSurface.Draw(0, 0, d.ClientRect, d, FALSE);
    with g_DXCanvas do begin
      TextOut(DEFSCREENWIDTH - TextWidth(CLIENTUPDATETIME) - 1, DEFSCREENHEIGHT - TextHeight(CLIENTUPDATETIME) - 1, clYellow, CLIENTUPDATETIME);
    end;
  end;
{$IFEND}
end;


end.

