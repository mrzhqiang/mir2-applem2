unit PlayScn;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, HGE,
  HGETextures, IntroScn, Grobal2, cliUtil, HGEBase,
  Actor, HerbActor, AxeMon, SoundUtil, clEvent, WIL, DirectXGraphics, AxeMon2, AxeMon3,
  StdCtrls, ClFunc, magiceff, ExtCtrls, MShare, Share, MNShare;

const
  // todo ��̫����˲���������
  LONGHEIGHT_IMAGE = 35 {35};
  AAX = 16;
  SOFFX = 0;
  SOFFY = 0;
  // ����ͷ�ϵ� HP ���� �ر����� �е�����
  HEALTHBAR_BLACK = 6;
  // �����б�������ģ���ʱ���ĵ����������Ļ��ÿһ���б������Ļ�ϵ�һ�У����ϵ���һ���ֳ� 40 ��
  // ��νһ��ʵ������ָ��ͼ����ϵ�У�y ������ͬ x ���겻ͬ��һ����
  // ���� UNITY=32 �趨�������ֱ��� 1600x900 �У�900 div 32 = 28.125 < 40����˵�ǰ������������
  // ��ʹ��Ϊ��ͼ�����С��Ե�ʣ���Ҫ�� Top �� Bottom ��������ٺ����� 5 �����꣬�� 28.125 + 10 < 40 Ҳ��������
  // ����Էֱ��������Ķ�����ע����Ĵ˲���
  DRAWLISTCOUNT = 40;

type
  // �����б���ʾ�ڵ�ͼ����ϵ�У������ҵ�ÿһ����Ҫ���Ƶ�����
  // ͨ����������Ŀɼ���Χ�й�ϵ����ο� g_Config.nSendRefMsgRange
  TDrawList = record
    // ��Ʒ�б�
    ItemList: TList;
    // ����б�
    ActorList: TList;
    // ��������б�
    DeathActorList: TList;
    // ��̯����б�
    ShopActorList: TList;
    // ������Ч�б����ƻ�ǽ����
    MagicEffList: TList;
    // �¼��б�
    ClEvent: TList;
  end;
  // ��ҳ���������Ϸ����
  TPlayScene = class(TScene)
    // ��ͼ����
    m_MapSurface: TDXRenderTargetTexture;
    // �������
    m_ObjSurface: TDXRenderTargetTexture;
    // ���ܱ���
    m_MagSurface: TDXRenderTargetTexture;
{$IF Var_Interface =  Var_Default}
    m_OperateHintSurface: TDirectDrawSurface;
{$IFEND}
    // HP ��
    m_HealthBarSurface: TDXImageTexture;
    // ����Ƿ�仯
    m_boPlayChange: Boolean;
    // ��ұ仯���
    m_dwPlayChangeTick: LongWord;

  private
    m_dwMoveTime: LongWord;
    m_nMoveStepCount: Integer;
    m_dwAniTime: LongWord;
    m_nAniCount: Integer;
    m_nDefXX: Integer;
    m_nDefYY: Integer;
    // ������Ƶ���ż�ʱ��
    m_MainSoundTimer: TTimer;
    // ��Ƶ���ż�ʱ���Ļص�
    procedure SoundOnTimer(Sender: TObject);

  public
{$IFDEF DEBUG}
    MemoLog: TMemo;
{$ENDIF}
    m_DrawArray: array[0..DRAWLISTCOUNT] of TDrawList;
    m_DrawOutsideList: TList;
    // ����б�
    m_ActorList: TList;
    m_EffectList: TList;
    m_FlyList: TList;
    m_dwBlinkTime: LongWord;
    m_boViewBlink: Boolean;

    constructor Create;

    destructor Destroy; override;

    function Initialize: Boolean; override;

    procedure Finalize; override;

    procedure Lost;

    procedure Recovered;

    procedure OpenScene; override;

    procedure CloseScene; override;

    procedure OpeningScene; override;

    procedure DrawTileMap(Sender: TObject);

    procedure PlayScene(MSurface: TDirectDrawSurface); override;

    procedure BeginScene();

    procedure PlaySurface(Sender: TObject);

    procedure MagicSurface(Sender: TObject);

    procedure PlayDrawScreen();

    procedure PlayDrawCenterMsg();

    function CanDrawTileMap(): Boolean;

    function ButchAnimal(X, Y: Integer): TActor;

    function FindActor(id: Integer): TActor; overload;

    function FindActor(sname: string): TActor; overload;

    function FindNpcActor(id: Integer): TNpcActor;

    function FindActorXY(X, Y: Integer): TActor;

    function IsValidActor(Actor: TActor): Boolean;

    function NewActor(chrid: Integer; cx, cy, cdir: Word; cfeature, cstate: Integer; btSIdx: Integer = -1; btWuXin: Integer = -1): TActor;

    procedure SetMissionList(Actor: TNPCActor);

    procedure RefMissionList;

    procedure RefMissionInfo;

    procedure ClearMissionList(Actor: TActor);

    procedure SetMissionInfo(Actor: TNPCActor);

    procedure SetOperateHint(sHint: string);

    procedure ActorDied(Actor: TObject);

    procedure SetActorDrawLevel(Actor: TObject; Level: Integer);

    procedure ClearActors;

    function DeleteActor(id: Integer): TActor;

    procedure DelActor(Actor: TObject);

    procedure SetEditChar(sMsg: string);

    procedure ClearGroup();

    procedure SetActorGroup(Actor: TActor);

    procedure SetMembersGroup(GroupMember: pTGroupMember; boGroup: Boolean); overload;

    procedure SetMembersGroup(GroupMembers: TList); overload;

    procedure SendMsg(ident, chrid, X, Y, cdir, Feature, State: Integer; str: string; btSIdx: Integer = -1; btWuXin: Integer = -1);

    procedure NewMagic(aowner: TActor; magid, magnumb, cx, cy, tx, ty, targetcode: Integer; mtype: TMagicType; Recusion: Boolean; anitime: Integer; var bofly: Boolean);

    procedure DelMagic(magid: Integer);

    function NewFlyObject(aowner: TActor; cx, cy, tx, ty, targetcode: Integer; mtype: TMagicType): TMagicEff;

    procedure ScreenXYfromMCXY(cx, cy: Integer; var sx, sy: Integer);

    procedure CXYfromMouseXY(mx, my: Integer; var ccx, ccy: Integer);

    function GetCharacter(X, Y, wantsel: Integer; var nowsel: Integer; liveonly: Boolean): TActor;

    function GetAttackFocusCharacter(X, Y, wantsel: Integer; var nowsel: Integer; liveonly: Boolean): TActor;

    function IsSelectMyself(X, Y: Integer): Boolean;

    function GetDropItems(X, Y: Integer; var inames: string; var MaxWidth: Integer): pTDropItem;

    function GetXYDropItems(nX, nY: Integer): pTDropItem;

    procedure GetXYDropItemsList(nX, nY: Integer; var ItemList: TList);

    function CanHorseRun(sx, sy, ex, ey: Integer): Boolean;

    function CanHorseRunEx(sx, sy, ex, ey: Integer): Boolean;

    function CanRun(sx, sy, ex, ey: Integer): Boolean;

    function CanLeap(sx, sy, ex, ey: Integer): Boolean;

    function CanRunEx(sx, sy, ex, ey: Integer): Boolean;

    function CanWalk(mx, my: Integer): Boolean;

    function CanWalkEx(mx, my: Integer): Boolean;

    function CanWalkEx2(mx, my: Integer): Boolean;

    function CrashMan(mx, my: Integer): Boolean;

    function CanFly(mx, my: Integer): Boolean;

    procedure RefreshScene;

    procedure CleanObjects;

    function CrashManEx(mx, my: Integer): Boolean;

    function CrashManEx2(mx, my: Integer): Boolean;
  end;

implementation

uses
  ClMain, FState2, FState, GameSetup, WMFile, Hutil32, NpcActor;

constructor TPlayScene.Create;
var
  i: Integer;
begin
  m_MapSurface := nil;
  m_ObjSurface := nil;
  m_MagSurface := nil;
{$IF Var_Interface =  Var_Default}
  m_OperateHintSurface := nil;
{$IFEND}
  m_HealthBarSurface := nil;

  m_ActorList := TList.Create;
  m_EffectList := TList.Create;
  m_FlyList := TList.Create;
  m_dwBlinkTime := GetTickCount;
  m_boViewBlink := FALSE;

  for i := Low(m_DrawArray) to High(m_DrawArray) do
  begin
    m_DrawArray[i].ItemList := TList.Create;
    m_DrawArray[i].ActorList := TList.Create;
    m_DrawArray[i].ShopActorList := TList.Create;
    m_DrawArray[i].DeathActorList := TList.Create;
    m_DrawArray[i].MagicEffList := TList.Create;
    m_DrawArray[i].ClEvent := TList.Create;
  end;

  m_DrawOutsideList := TList.Create;

{$IFDEF DEBUG}
  MemoLog := TMemo.Create(frmMain.Owner);
  with MemoLog do begin
    Parent := frmMain;
    BorderStyle := bsNone;
    Visible := FALSE;
    Ctl3D := True;
    Left := 0;
    Top := 250;
    Width := 300;
    Height := 150;
  end;
{$ENDIF}

  m_dwMoveTime := GetTickCount;
  m_nMoveStepCount := 0;
  m_dwAniTime := GetTickCount;
  m_nAniCount := 0;
  m_MainSoundTimer := TTimer.Create(frmMain.Owner);
  with m_MainSoundTimer do
  begin
    OnTimer := SoundOnTimer;
    Interval := 1;
    Enabled := FALSE;
  end;
end;

destructor TPlayScene.Destroy;
var
  i: Integer;
begin
  m_ActorList.Free;
  m_EffectList.Free;
  m_FlyList.Free;
  for i := Low(m_DrawArray) to High(m_DrawArray) do
  begin
    m_DrawArray[i].ItemList.Free;
    m_DrawArray[i].ActorList.Free;
    m_DrawArray[i].ShopActorList.Free;
    m_DrawArray[i].DeathActorList.Free;
    m_DrawArray[i].MagicEffList.Free;
    m_DrawArray[i].ClEvent.Free;
  end;
  m_DrawOutsideList.Free;
  inherited Destroy;
end;

//��Ϸ�������ı������֣����ȣ�43�룩
procedure TPlayScene.SoundOnTimer(Sender: TObject);
begin
  PlaySound(s_main_theme);
  m_MainSoundTimer.Interval := 46 * 1000;
end;

function TPlayScene.Initialize: Boolean;
var
  DXAccessInfo: TDXAccessInfo;
  Y, X: Integer;
  WriteBuffer: PWord;
begin
  Result := False;
  m_MapSurface := TDXRenderTargetTexture.Create(g_DXCanvas);
  m_MapSurface.Size := Point(g_FScreenWidth + 10 * UNITX, g_FScreenHeight + 10 * UNITY);
  m_MapSurface.Active := True;
  if not m_MapSurface.Active then
    exit;

  m_ObjSurface := TDXRenderTargetTexture.Create(g_DXCanvas);
  m_ObjSurface.Size := Point(g_FScreenWidth, g_FScreenHeight);
  m_ObjSurface.Active := True;
  if not m_ObjSurface.Active then
    exit;

  m_MagSurface := TDXRenderTargetTexture.Create(g_DXCanvas);
  m_MagSurface.Size := Point(g_FScreenWidth, g_FScreenHeight);
  m_MagSurface.Active := True;
  if not m_MagSurface.Active then
    exit;

{$IF Var_Interface =  Var_Default}
  m_OperateHintSurface := MakeDXImageTexture(OPERATEHINTWIDTH, OPERATEHINTHEIGHT, WILFMT_A4R4G4B4, g_DXCanvas);
  if m_OperateHintSurface = nil then exit;
{$IFEND}

  m_HealthBarSurface := MakeDXImageTexture(30, 6, WILFMT_R5G6B5, g_DXCanvas);

  if m_HealthBarSurface = nil then exit;

  if m_HealthBarSurface.Lock(lfWriteOnly, DXAccessInfo) then
  begin
    Try
      for Y := 0 to m_HealthBarSurface.Size.Y - 1 do
      begin
        // ����û���õ� WriteBuffer ����
        WriteBuffer := PWord(Integer(DXAccessInfo.Bits) + (DXAccessInfo.Pitch * Y));
        for X := 0 to m_HealthBarSurface.Size.X - 1 do
        begin
          case Y of
            0: WriteBuffer^ := 63488;
            1: WriteBuffer^ := 38912;
            2: WriteBuffer^ := 831;
            3: WriteBuffer^ := 31;
            4: WriteBuffer^ := 19705;
            5: WriteBuffer^ := 12944;
          end;
          Inc(WriteBuffer);
        end;
      end;
    Finally
      m_HealthBarSurface.Unlock;
    End;
  end;
  Result := True;
end;

procedure TPlayScene.Finalize;
begin
  if m_MapSurface <> nil then
    m_MapSurface.Free;
  if m_ObjSurface <> nil then
    m_ObjSurface.Free;
  if m_MagSurface <> nil then
    m_MagSurface.Free;
{$IF Var_Interface =  Var_Default}
  if m_OperateHintSurface <> nil then
    m_OperateHintSurface.Free;
  m_OperateHintSurface := nil;
{$IFEND}
  if m_HealthBarSurface <> nil then
    m_HealthBarSurface.Free;
  m_MapSurface := nil;
  m_ObjSurface := nil;
  m_MagSurface := nil;
  m_HealthBarSurface := nil;
end;

//������ʼ
procedure TPlayScene.OpenScene;
begin
  ClMain.HGE.Gfx_Restore(g_FScreenWidth, g_FScreenHeight, g_BitCount);
  SetImeMode(frmMain.Handle, LocalLanguage);
  FrmDlg.DBottom.Visible := True;
{$IF Var_Interface =  Var_Default}
  FrmDlg.DTop.Visible := True;
  FrmDlg.DWndSay.Visible := True;
{$IFEND}
  FrmDlg2.DWndHint.Visible := True;
end;

//�رճ���
procedure TPlayScene.CloseScene;
begin
  FrmDlg.DBottom.Visible := False;
{$IF Var_Interface =  Var_Default}
  FrmDlg.DTop.Visible := False;
  FrmDlg.DWndSay.Visible := False;
{$IFEND}
  FrmDlg2.DWndHint.Visible := False;
  DScreen.ClearSysMsg;
  ClearBGM;
end;

procedure TPlayScene.OpeningScene;
begin
end;

procedure TPlayScene.Recovered;
begin
  if m_MapSurface <> nil then
    m_MapSurface.Recovered;
  if m_ObjSurface <> nil then
    m_ObjSurface.Recovered;
  if m_MagSurface <> nil then
    m_MagSurface.Recovered;
end;

procedure TPlayScene.RefreshScene;
var
  i: Integer;
begin
  Map.m_OldClientRect.Left := -1;
  for i := 0 to m_ActorList.count - 1 do
    TActor(m_ActorList[i]).LoadSurface;
end;

procedure TPlayScene.ClearActors;
var
  i: Integer;
begin
  for i := 0 to m_ActorList.count - 1 do
  begin
    if TActor(m_ActorList[i]).m_Group <> nil then
    begin
      TActor(m_ActorList[i]).m_Group.isScreen := nil;
      TActor(m_ActorList[i]).m_Group := nil;
    end;
    ClearMissionList(TActor(m_ActorList[i]));
    TActor(m_ActorList[i]).Free;
  end;
  m_ActorList.Clear;
  g_MySelf := nil;
  g_TargetCret := nil;
  g_FocusCret := nil;
  g_MagicTarget := nil;
  g_NPCTarget := nil;
  g_MagicLockTarget := nil;

  for i := 0 to m_EffectList.count - 1 do
    TMagicEff(m_EffectList[i]).Free;
  m_EffectList.Clear;
end;

procedure TPlayScene.CleanObjects;
var
  i: Integer;
begin
  //ɾ�����зǵ�ǰ��ҽ�ɫ
  for i := m_ActorList.count - 1 downto 0 do
  begin
    if TActor(m_ActorList[i]) <> g_MySelf then
    begin
      if TActor(m_ActorList[i]).m_Group <> nil then
      begin
        TActor(m_ActorList[i]).m_Group.isScreen := nil;
        TActor(m_ActorList[i]).m_Group := nil;
      end;
      ClearMissionList(TActor(m_ActorList[i]));
      TActor(m_ActorList[i]).Free;
      m_ActorList.Delete(i);
    end;
  end;
  g_TargetCret := nil;
  g_FocusCret := nil;
  g_MagicTarget := nil;
  g_NPCTarget := nil;
  g_MagicLockTarget := nil;
  for i := 0 to m_EffectList.count - 1 do
    TMagicEff(m_EffectList[i]).Free;
  m_EffectList.Clear;
  for i := 0 to m_FlyList.Count - 1 do
  begin
    TMagicEff(m_FlyList[i]).Free
  end;
  m_FlyList.Clear;
end;

// ���Ƶذ��ͼ
procedure TPlayScene.DrawTileMap(Sender: TObject);
var
  i, j, nY, nX, bkIndex, midIndex: Integer;
  dsurface: TDirectDrawSurface;
begin
  // �����ͼ�Ŀ��û�б仯����ô��������
  with Map do
    if (m_ClientRect.Left = m_OldClientRect.Left) and (m_ClientRect.Top = m_OldClientRect.Top) then Exit;

  // ��¼��ǰ��ͼ�Ŀͻ��˾���Ϊ�ɰ汾
  Map.m_OldClientRect := Map.m_ClientRect;

  // ����ж�ûʲô����
  if not g_boDrawTileMap then Exit;

  // ��ͼ�ذ�
  with Map.m_ClientRect do
  begin
    nY := - 1 * UNITY;
    for j := (Top - Map.m_nBlockTop - 1) to (Bottom - Map.m_nBlockTop + 1) do
    begin
      if (j >= 0) and (j < 3 * LOGICALMAPUNIT) and (j mod 2 = 0) then
      begin
        nX := - 2 * UNITX + g_FScreenXOrigin mod UNITX + UNITX div 2;
        for i := (Left - Map.m_nBlockLeft - 2) to (Right - Map.m_nBlockLeft + 1) do
        begin
          if (i >= 0) and (i < 3 * LOGICALMAPUNIT) and (i mod 2 = 0) then
          begin
            bkIndex := (Map.m_MArr[i, j].wBkImg and $7FFF);
            if bkIndex > 0 then
            begin
              bkIndex := bkIndex - 1;
              if Map.m_MArr[i, j].btBkIndex = 1 then
              begin
                dsurface := g_WTiles2Images.Images[bkIndex]
              end else
                dsurface := g_WTilesImages.Images[bkIndex];
              if dsurface <> nil then
                m_MapSurface.Draw(nX, nY, dsurface.ClientRect, dsurface, FALSE);
            end;
          end;
          Inc(nX, UNITX);
        end;
      end;
      Inc(nY, UNITY);
    end;
  end;

  //��ͼ�м��
  //��ʾ���ϵĲ�   ������밲ȫ���Ĳ�
  with Map.m_ClientRect do
  begin
    nY := - 1 * UNITY;
    for j := (Top - Map.m_nBlockTop - 1) to (Bottom - Map.m_nBlockTop + 1) do
    begin
      if (j >= 0) and (j < 3 * LOGICALMAPUNIT) then
      begin
        nX := - 2 * UNITX + g_FScreenXOrigin mod UNITX + UNITX div 2;
        for i := (Left - Map.m_nBlockLeft - 2) to (Right - Map.m_nBlockLeft + 1) do
        begin
          if (i >= 0) and (i < 3 * LOGICALMAPUNIT) then
          begin
            midIndex := Map.m_MArr[i, j].wMidImg;
            if midIndex > 0 then
            begin
              midIndex := midIndex - 1;
              if Map.m_MArr[i, j].btSmIndex = 1 then
              begin
                dsurface := g_WSmTiles2Images.Images[midIndex]
              end else
                dsurface := g_WSmTilesImages.Images[midIndex];
              if dsurface <> nil then
                m_MapSurface.Draw(nX, nY, dsurface.ClientRect, dsurface, True);
            end;
          end;
          Inc(nX, UNITX);
        end;
      end;
      Inc(nY, UNITY);
    end;
  end;

end;

procedure TPlayScene.BeginScene();
// ����ص�����
function CheckOverlappedObject(myrc, obrc: TRect): Boolean;
begin
  if (obrc.Right > myrc.Left) and (obrc.Left < myrc.Right)
  and (obrc.Bottom > myrc.Top) and (obrc.Top < myrc.Bottom) then
    Result := True
  else
    Result := FALSE;
end;

var
  i, rectXOffset, rectYOffset: Integer;
  movetick: Boolean;
  Actor: TActor;
  meff: TMagicEff;
  boChange: Boolean;
begin
  // �����Ҳ����ڣ���ô��������
  if g_MySelf = nil then
    exit;

  // ��ʼ������
  g_boDoFastFadeOut := FALSE;
  m_boPlayChange := FALSE;
  movetick := FALSE;

  // ����ϴ��ƶ�ʱ����������ڳ���һ����ֵ����ִ������߼�
  if GetTickCount - m_dwMoveTime >= 95 then
  begin
    // ���¼�¼�ƶ�ʱ��
    m_dwMoveTime := GetTickCount;
    // �ı��ƶ���ʱ״̬
    movetick := True;
    // �ƶ�����ͳ�� +1
    Inc(m_nMoveStepCount);
    // ����ƶ�����ͳ�Ƴ��� 1 �Σ�������Ϊ 0
    // ���������������ƶ����������ֵ
    if m_nMoveStepCount > 1 then
      m_nMoveStepCount := 0;
  end;

  // ����ϴλ��ƶ�����ʱ�䳬��һ����ֵ����ִ������߼�
  if GetTickCount - m_dwAniTime >= 50 then
  begin
    // ���¼�¼���ƶ���ʱ��
    m_dwAniTime := GetTickCount;

    // �������ƴ���ͳ�� +1
    Inc(m_nAniCount);

    // ����������ƴ���ͳ�Ƴ��� 10w �Σ�������Ϊ 0
    if m_nAniCount > 100000 then
      m_nAniCount := 0;
  end;
  // ѭ����ǰ���ӷ�Χ�ڵ�����б�������ز���
  try
    i := 0;
    while True do
    begin
      // ��������������������������ѭ��
      if i >= m_ActorList.count then
        break;
      // ��ʼ������Ҳ���
      Actor := m_ActorList[i];
      // ����ƶ���ʱ���ã�����ұ�������ٶ�
      if movetick or Actor.m_boNoCheckSpeed then
        // ���趨����Ҳ���������֡
        Actor.m_boLockEndFrame := FALSE;
      // �����Ҳ���������֡
      if not Actor.m_boLockEndFrame then
      begin
        Actor.ProcMsg;
        // ����ƶ���ʱ��Ȼ���ã�����ұ�����Ȼ������ٶ�
        if movetick or Actor.m_boNoCheckSpeed then
          // ��ôͨ��ָ�������ͱ仯״̬�ź�ֵ�������ƶ����
          if Actor.Move(m_nMoveStepCount, boChange) then
          begin
            m_boPlayChange := m_boPlayChange or boChange;
            Inc(i);
            continue;
          end;
        Actor.Run;
        if Actor <> g_MySelf then
          Actor.ProcHurryMsg;
      end;
      if Actor = g_MySelf then
        Actor.ProcHurryMsg;
      if Actor.m_nWaitForRecogId <> 0 then
      begin
        if Actor.IsIdle then
        begin
          DelChangeFace(Actor.m_nWaitForRecogId);
          NewActor(Actor.m_nWaitForRecogId, Actor.m_nCurrX, Actor.m_nCurrY,
                    Actor.m_btDir, Actor.m_nWaitForFeature, Actor.m_nWaitForStatus);
          Actor.m_nWaitForRecogId := 0;
          Actor.m_boDelActor := True;
        end;
      end;
      if Actor.m_boDelActor then
      begin
        ClearMissionList(Actor);
        g_FreeActorList.Add(Actor);
        m_ActorList.Delete(i);
        if g_TargetCret = Actor then
          g_TargetCret := nil;
        if g_FocusCret = Actor then
          g_FocusCret := nil;
        if g_MagicTarget = Actor then
          g_MagicTarget := nil;
        if g_NPCTarget = Actor then
          g_NPCTarget := nil;
        if g_MagicLockTarget = Actor then
          g_MagicLockTarget := nil;
      end
      else
        Inc(i);
    end;
  except
    DebugOutStr('101');
  end;
  m_boPlayChange := m_boPlayChange or (GetTickCount > m_dwPlayChangeTick);
  try
    i := 0;
    while True do
    begin
      if i >= m_EffectList.count then
        break;
      meff := m_EffectList[i];
      if meff.m_boActive then
      begin
        if not meff.Run then
        begin
          meff.Free;
          m_EffectList.Delete(i);
          continue;
        end;
      end;
      Inc(i);
    end;
    i := 0;
    while True do
    begin
      if i >= m_FlyList.count then
        break;
      meff := m_FlyList[i];
      if meff.m_boActive then
      begin
        if not meff.Run then
        begin
          meff.Free;
          m_FlyList.Delete(i);
          continue;
        end;
      end;
      Inc(i);
    end;
    EventMan.Execute;
  except
    DebugOutStr('102');
  end;
  // ���� MapSurface �Ƿֱ��������� 10 ��λ�Ŀ��
  // ��������㷨����Ļ�ֱ������ 4--6 ����λ
  // ��˿��Ա�֤�ڿͻ��˾����� MapSurface ��ֱ���֮�����
  rectXOffset := g_FScreenXOrigin div UNITX + 3;
  rectYOffset := g_FScreenYOrigin div UNITY + 1;
  try
    with Map.m_ClientRect do
    begin
      Left := g_MySelf.m_nRx - rectXOffset;
      Top := g_MySelf.m_nRy - rectYOffset - 2;
      Right := g_MySelf.m_nRx + rectXOffset;
      Bottom := g_MySelf.m_nRy + rectYOffset;
    end;
    Map.UpdateMapPos(g_MySelf.m_nRx, g_MySelf.m_nRy);
  except
    DebugOutStr('104');
  end;
end;

procedure TPlayScene.PlayDrawCenterMsg();
var
  CenterMsg: pTCenterMsg;
  I, nHeight, n: Integer;
  sShowStr: string;
begin
  for I := g_CenterMsgList.Count - 1 downto 0 do
  begin
    CenterMsg := g_CenterMsgList[I];
    if GetTickCount >= CenterMsg.nTime then
    begin
      FrmMain.SendClientMessage(CM_CENTERMSG_CLICK, CenterMsg.nID, 0, 0, 0, '');
      Dispose(CenterMsg);
      g_CenterMsgList.Delete(I);
    end;
  end;
  n := 0;
{$IF Var_Interface = Var_Mir2}
  nHeight := g_FScreenHeight - 220;
  for I := g_CenterMsgList.Count - 1 downto 0 do
  begin
    if n >= 5 then break;
    CenterMsg := g_CenterMsgList[I];
    sShowStr := Format(CenterMsg.sMsgStr, [_MAX(1, (CenterMsg.nTime - GetTickCount) div 1000)]);
    g_DXCanvas.TextOut(g_FScreenXOrigin - g_DXCanvas.TextWidth(sShowStr) div 2, nHeight - n * 18, CenterMsg.nFColor, sShowStr);
    Inc(n);
  end;
{$ELSE}
  nHeight := g_FScreenHeight - 150;
  for I := g_CenterMsgList.Count - 1 downto 0 do begin
  if n >= 5 then break;
  CenterMsg := g_CenterMsgList[I];
  sShowStr := Format(CenterMsg.sMsgStr, [_MAX(1, (CenterMsg.nTime - GetTickCount) div 1000)]);
  g_DXCanvas.TextOut(294 + ((506 - g_DXCanvas.TextWidth(sShowStr)) div 2) + g_FScreenXOrigin - OLD_SCREEN_WIDTH div 2, nHeight - n * 18, CenterMsg.nFColor, sShowStr);
  Inc(n);
  end;
{$IFEND}

end;

procedure TPlayScene.PlayDrawScreen();
  procedure NameTextOut(Actor: TActor; Surface: TDirectDrawSurface; X, Y, fcolor, bcolor: Integer; namestr: string);
  var
    i, row: Integer;
    nstr: string;
  begin
    row := 0;
    if g_boUseWuXin and (Actor.m_btWuXin in [1..5]) then
    begin
      g_DXCanvas.TextOut(X - 12, Y - 6, GetWuXinColor(Actor.m_btWuXin), '[' + GetWuXinName(Actor.m_btWuXin) + ']');
      row := 1;
    end;
    for i := 0 to 10 do
    begin
      if namestr = '' then break;
      namestr := GetValidStr3(namestr, nstr, ['\']);
      if (row = 0) and (namestr <> '') then row := -1;
      g_DXCanvas.TextOut(X - g_DXCanvas.TextWidth(nstr) div 2, Y + row * 6, fcolor, nstr);
      Inc(row, 2);
    end;
  end;

const
  MissionIconPlace: array[0..9] of Integer = (0, 1, 2, 3, 4, 5, 4, 3, 2, 1);
var
  i, k, ax, ay, nx, ny: Integer;
  Actor: TActor;
  uname: string;
  d: TDirectDrawSurface;
  rc: TRect;
  infoMsg: string;
begin
  k := 0;
  while True do
  begin
    if K > m_ActorList.Count then
      break;
    if K = m_ActorList.Count then
      Actor := g_MySelf
    else begin
      Actor := m_ActorList[k];
      if (Actor = g_MySelf) or (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) > MAXLEFT2)
      or (g_MySelf.m_nCurrY - actor.m_nCurrY > MAXTOP2) or (Actor.m_nSayX = 0)
      or (g_MySelf.m_nCurrY - actor.m_nCurrY < (MAXTOP3 + 1)) then
      begin
        Inc(k);
        Continue;
      end;
    end;

    if (actor.m_btRace = 0) and (actor.m_btHorse <> 0) then
      actor.m_nShowY := 22
    else
      actor.m_nShowY := 6;

    ax := 0;
    ay := 0;
    // ��̯
    if (actor.m_btRace = 0) and (actor.m_boShop) and (not Actor.m_boDeath) then
    begin
      if Actor.m_UserShopSurface <> nil then
      begin
        Inc(actor.m_nShowY, Actor.m_UserShopSurface.Height);
        DrawWindow(m_ObjSurface, Actor.m_nSayX - Actor.m_UserShopSurface.Width div 2, Actor.m_nSayY - actor.m_nShowY - 1, Actor.m_UserShopSurface);
      end;
    end else
    begin
      //��ʾ����Ѫ��(������ʾ)
      if (not Actor.m_boDeath) and (Actor.m_boShowHealthBar) then
      begin
        // ��ұ�����ʾ����
        if actor = g_MySelf then
        begin
          Inc(actor.m_nShowY, 3);
          // �����ղ�
          d := g_WMain99Images.Images[HEALTHBAR_BLACK];
          if d <> nil then
          begin
            ax := Actor.m_nSayX - d.Width div 2;
            ay := Actor.m_nSayY - actor.m_nShowY - 1;
            m_ObjSurface.Draw(ax, ay, d.ClientRect, d, True);
          end;
          // �������
          d := g_WMain99Images.Images[0];
          if d <> nil then
          begin
            rc := d.ClientRect;
            rc.Top := 2;
            rc.Bottom := 4;
            if Actor.m_Abil.MaxMP > 0 then
              rc.Right := Round((rc.Right - rc.Left) / Actor.m_Abil.MaxMP * Actor.m_Abil.MP);
            ax := Actor.m_nSayX - d.Width div 2;
            ay := Actor.m_nSayY - actor.m_nShowY - 1 + 1;
            m_ObjSurface.Draw(ax, ay, rc, d, True);
          end;
        end;

        //������ġ�Ѫ����ͷ�ϵ�һ����ܣ�
        Inc(actor.m_nShowY, 4);
        // Ѫ���ղ�
        d := g_WMain99Images.Images[HEALTHBAR_BLACK];
        if d <> nil then
        begin
          ax := Actor.m_nSayX - d.Width div 2;
          ay := Actor.m_nSayY - actor.m_nShowY;
          m_ObjSurface.Draw(ax, ay, d.ClientRect, d, True);
        end;
        // Ѫ�����
        d := m_HealthBarSurface;
        if d <> nil then
        begin
          rc := d.ClientRect;
          if actor.m_btRaceServer = RC_NPC then
          begin
            rc.Top := 4;
            rc.Bottom := 6;
          end else begin
            rc.Top := 0;
            rc.Bottom := 2;
          end;
          if Actor.m_Abil.MaxHP > 0 then
            rc.Right := Round((rc.Right - rc.Left) / Actor.m_Abil.MaxHP * Actor.m_Abil.HP);
          ax := Actor.m_nSayX - d.Width div 2;
          ay := Actor.m_nSayY - actor.m_nShowY + 1;
          m_ObjSurface.Draw(ax, ay, rc, d, True);
        end;
      end;

      if (Actor.m_Abil.MaxHP > 1) and (not Actor.m_boDeath) and (Actor.m_boShowHealthBar) then
      begin
        Inc(actor.m_nShowY, 12);
        if (g_SetupInfo.boUnitHpMp) then
          infoMsg := IntUnit(actor.m_Abil.HP) + '/' + IntUnit(actor.m_Abil.MaxHP)
        else
          infoMsg := IntToStr(actor.m_Abil.HP) + '/' + IntToStr(actor.m_Abil.MaxHP);
        nx := actor.m_nSayX - g_DXCanvas.TextWidth(infoMsg) div 2;
        ny := actor.m_nSayY - actor.m_nShowY;
        g_DXCanvas.TextOut(nx, ny, clWhite, infoMsg);
        if Actor.m_Group <> nil then
        begin
          // ��Ա��ʶ
          d := g_WMain99Images.Images[179];
          if d <> nil then
          begin
            nx := nx - d.Width - 5;
            if nx > ax then
              nx := ax;
            ny := actor.m_nSayY - actor.m_nShowY;
            m_ObjSurface.Draw(nx, ny, d.ClientRect, d, True);
          end;
        end;
      end;
      // ͷ������ƺ�
      if (not Actor.m_boDeath) and (Actor.m_btStrengthenIdx in [1..10]) then
      begin
        nx := 1015 + Actor.m_btStrengthenIdx * 15 + (GetTickCount - Actor.m_dwStrengthenTick) div 100 mod 15;
        d := g_WMain99Images.Images[nx];
        if d <> nil then
        begin
          Inc(actor.m_nShowY, 30);
          nx := Actor.m_nSayX - d.Width div 2;
          ny := Actor.m_nSayY - actor.m_nShowY;
          m_ObjSurface.Draw(nx, ny, d.ClientRect, d, True);
          Inc(actor.m_nShowY, -15);
        end;
      end;

      for i := Low(TIconInfos) to High(TIconInfos) do
      begin
        if (actor.m_IconInfo[i].btFrame = 0) or (actor.m_IconInfo[i].wIndex > High(g_ClientImages)) then
          Continue;
        if GetTickCount() - actor.m_IconInfoShow[i].dwFrameTick >= (actor.m_IconInfo[i].wFrameTime * 10) then
        begin
          actor.m_IconInfoShow[i].dwFrameTick := GetTickCount();
          if (actor.m_IconInfoShow[i].dwCurrentFrame < actor.m_IconInfo[i].wStart)
            or (Integer(actor.m_IconInfoShow[i].dwCurrentFrame) >= actor.m_IconInfo[i].wStart + actor.m_IconInfo[i].btFrame - 1) then
            actor.m_IconInfoShow[i].dwCurrentFrame := actor.m_IconInfo[i].wStart
          else
            actor.m_IconInfoShow[i].dwCurrentFrame := actor.m_IconInfoShow[i].dwCurrentFrame + 1;
        end;

        d := g_ClientImages[actor.m_IconInfo[i].wIndex].Images[actor.m_IconInfoShow[i].dwCurrentFrame];
        if d <> nil then
        begin
          nx := Actor.m_nSayX - actor.m_IconInfo[i].nX;
          ny := actor.m_nSayY - actor.m_nShowY - d.Height + 2 - actor.m_IconInfo[i].nY;
          m_ObjSurface.Draw(nx, ny, d.ClientRect, d, True);
        end;
      end;

      // ͷ�������ʶ
      if (actor.m_btRace = 50) then
      begin
        with Actor as TNPCActor do
        begin
          if m_MissionStatus <> NPCMS_None then
          begin
            d := nil;
            if GetTickCount > m_dwMissionIconTick then
            begin
              m_dwMissionIconTick := GetTickCount + 100;
              Inc(m_dwMissionIconIdx);
            end;
            if m_dwMissionIconIdx > 9 then m_dwMissionIconIdx := 0;
            case m_MissionStatus of
              NPCMS_Accept: d := g_WMain99Images.Images[667];
              NPCMS_Complete: d := g_WMain99Images.Images[668];
              NPCMS_Atelic: d := g_WMain99Images.Images[669];
            end;
            if d <> nil then
            begin
              Inc(actor.m_nShowY, d.Height + 5);
              nx := Actor.m_nSayX - d.Width div 2;
              ny := actor.m_nSayY - actor.m_nShowY - MissionIconPlace[m_dwMissionIconIdx];
              m_ObjSurface.Draw(nx, ny, d.ClientRect, d, True);
              d := g_WMain99Images.Images[1990 + m_dwMissionIconIdx];
              if d <> nil then
              begin
                nx := Actor.m_nSayX - d.Width div 2;
                ny := actor.m_nSayY - actor.m_nShowY - 32;
                DrawBlend(m_ObjSurface, nx, ny, d, 1);
              end;
            end;
          end;
        end;
      end;
    end;
    Actor.DrawStruck(m_ObjSurface);
    Inc(k);
  end;
{$IF Var_Interface =  Var_Default}
  if m_OperateHintSurface <> nil then
    m_ObjSurface.Draw(g_FScreenWidth - OLD_SCREEN_WIDTH + OPERATEHINTX,
                       g_FScreenHeight - OLD_SCREEN_HEIGHT + OPERATEHINTY,
                       m_OperateHintSurface.ClientRect,
                       m_OperateHintSurface, True);
{$IFEND}

  if (g_FocusCret <> nil) and IsValidActor(g_FocusCret) then
  begin
    if (g_FocusCret.m_btRace = RCC_MERCHANT) then
    begin
      if (g_FocusCret.m_sDescUserName <> '') then
      begin
        nx := g_FocusCret.m_nSayX - g_FocusCret.m_DescNameWidth div 2;
        ny := g_FocusCret.m_nSayY + 24;
        g_DXCanvas.TextOut(nx, ny, g_FocusCret.m_NameColor, g_FocusCret.m_sDescUserName);
        nx := g_FocusCret.m_nSayX - g_FocusCret.m_NameWidth div 2;
        ny := g_FocusCret.m_nSayY + 36;
        g_DXCanvas.TextOut(nx, ny, clWhite, g_FocusCret.m_UserName);
      end else
      begin
        nx := g_FocusCret.m_nSayX - g_FocusCret.m_NameWidth div 2;
        ny := g_FocusCret.m_nSayY + 30;
        g_DXCanvas.TextOut(nx, ny, g_FocusCret.m_NameColor, g_FocusCret.m_UserName);
      end;
    end else begin
      uname := g_FocusCret.m_sDescUserName + '\' + g_FocusCret.m_UserName;
      NameTextOut(g_FocusCret, m_ObjSurface, g_FocusCret.m_nSayX, g_FocusCret.m_nSayY + 30, g_FocusCret.m_NameColor, clBlack, uname);
    end;
  end;
  if g_boSelectMyself and (g_MySelf <> nil) then
  begin
    uname := g_MySelf.m_sDescUserName + '\' + g_MySelf.m_UserName;
    NameTextOut(g_MySelf, m_ObjSurface, g_MySelf.m_nSayX, g_MySelf.m_nSayY + 30, g_MySelf.m_NameColor, clBlack, uname);
  end;
end;

//����Ϸ��ʽ����
procedure TPlayScene.PlayScene(MSurface: TDirectDrawSurface);
begin
end;

procedure TPlayScene.PlaySurface(Sender: TObject);
function CheckOverlappedObject(myrc, obrc: TRect): Boolean;
begin
  if (obrc.Right > myrc.Left) and (obrc.Left < myrc.Right) and
  (obrc.Bottom > myrc.Top) and (obrc.Top < myrc.Bottom) then
    Result := True
  else
    Result := FALSE;
end;

procedure NameTextOut(Actor: TActor; Surface: TDirectDrawSurface; X, Y, fcolor: Integer; namestr: string; boShow: Boolean);
var
  i, row: Integer;
  nstr: string;
begin
  row := 0;
  if g_boUseWuXin and boShow and (Actor.m_btWuXin in [1..5]) then
  begin
    Surface.TextOutEx(X - 12, Y - 6, '[' + GetWuXinName(Actor.m_btWuXin) + ']', GetWuXinColor(Actor.m_btWuXin));
    row := 1;
  end;
  for i := 0 to 10 do
  begin
    if namestr = '' then break;
    namestr := GetValidStr3(namestr, nstr, ['\']);
    if (row = 0) and (namestr <> '') then row := -1;
    Surface.TextOutEx(X - g_DXCanvas.TextWidth(nstr) div 2, Y + row * 6, nstr, fcolor);
    Inc(row, 2);
  end;
end;

const
  DropItemColor: array[Boolean] of LongWord = ($F0C8A0, $FF);

var
  i, j, k, ii, n, M, mmm, ix, iy, line, defx, defy, wunit, fridx, ani, anitick,
    ax,
    ay, idx, drawingbottomline: Integer;
  dsurface, d: TDirectDrawSurface;
  blend, movetick: Boolean;
  DropItem: pTDropItem;
  evn: TClEvent;
  Actor: TActor;
  meff: TMagicEff;
  msgstr: string;
  nFColor, nBColor: Integer;
  TestTick1: LongWord;
  NameTexture, HintTexture: TDXImageTexture;
  nIndex: Integer;
begin
  LastForm := lf_Play;
  drawingbottomline := g_FScreenHeight;
{$IF Var_Interface = Var_Mir2}
  m_ObjSurface.Draw(0, 0,
                     Rect(UNITX * 4 + g_MySelf.m_nShiftX,
                           UNITY * 5 + g_MySelf.m_nShiftY,
                           UNITX * 4 + g_MySelf.m_nShiftX + g_FScreenWidth,
                           UNITY * 5 + g_MySelf.m_nShiftY + g_FScreenHeight),
                     m_MapSurface,
                     FALSE);
  defx := -UNITX * 4 - g_MySelf.m_nShiftX + g_FScreenXOrigin mod UNITX + UNITX div 2;
  defy := -UNITY * 4 - g_MySelf.m_nShiftY;
{$ELSE}
  m_ObjSurface.Draw(0, 0,
  Rect(UNITX * 4 + g_MySelf.m_nShiftX,
  UNITY * 3 + g_MySelf.m_nShiftY,
  UNITX * 4 + g_MySelf.m_nShiftX + g_FScreenWidth,
  UNITY * 3 + g_MySelf.m_nShiftY + g_FScreenHeight),
  m_MapSurface,
  FALSE);

  if g_FScreenWidth = 1024 then defx := -UNITX * 4 - g_MySelf.m_nShiftX + AAX + 28
  else defx := -UNITX * 6 - g_MySelf.m_nShiftX + AAX + 14;

  if g_FScreenHeight = 768 then defy := -UNITY * 2 - g_MySelf.m_nShiftY
  else defy := -UNITY * 5 - g_MySelf.m_nShiftY;

{$IFEND}

  m_nDefXX := defx;
  m_nDefYY := defy;
  nIndex := 0;
  try
    m := defy - UNITY;

    for i := Low(m_DrawArray) to High(m_DrawArray) do
    begin
      m_DrawArray[i].ItemList.Clear;
      m_DrawArray[i].ActorList.Clear;
      m_DrawArray[i].ShopActorList.Clear;
      m_DrawArray[i].DeathActorList.Clear;
      m_DrawArray[i].MagicEffList.Clear;
      m_DrawArray[i].ClEvent.Clear;
    end;
    nIndex := 1;
    m_DrawOutsideList.Clear;

    for i := EventMan.EventList.Count - 1 downto 0 do
    begin
      evn := TClEvent(EventMan.EventList[i]);
      // ��������ֱ��ʣ��ǵü���һ�������Ƿ�������ķ�Χ��
      if (abs(evn.m_nX - g_MySelf.m_nCurrX) > 20) and (abs(evn.m_nY - g_MySelf.m_nCurrY) > 20) and (not evn.m_boClient)
      then
      begin
        evn.Free;
        EventMan.EventList.Delete(i);
        break;
      end
      else begin
        k := evn.m_nY - Map.m_nBlockTop - (Map.m_ClientRect.Top - Map.m_nBlockTop);
        if (k >= 0) and (k <= DRAWLISTCOUNT) then
        begin
          m_DrawArray[k].ClEvent.Add(evn);
        end;
      end;
    end;
    nIndex := 2;
    for i := g_DropedItemList.Count - 1 downto 0 do
    begin
      DropItem := PTDropItem(g_DropedItemList[i]);
      // ��������ֱ��ʣ��ǵü���һ�������Ƿ�������ķ�Χ��
      if (abs(DropItem.X - g_MySelf.m_nCurrX) > 20) and (abs(DropItem.Y - g_MySelf.m_nCurrY) > 20) then
      begin
        DisopseDropItem(DropItem, 0);
        g_DropedItemList.Delete(i);
      end
      else if (abs(g_MySelf.m_nCurrX - DropItem.X) > MAXLEFT2) or
      (g_MySelf.m_nCurrY - DropItem.Y > MAXTOP2) or
      (g_MySelf.m_nCurrY - DropItem.Y < MAXTOP3) then
        Continue;
      k := DropItem.Y - Map.m_nBlockTop - (Map.m_ClientRect.Top - Map.m_nBlockTop);
      if (k >= 0) and (k <= DRAWLISTCOUNT) then
      begin
        m_DrawArray[k].ItemList.Add(DropItem);
      end;
    end;
    nIndex := 3;
    for i := 0 to m_ActorList.Count - 1 do
    begin
      Actor := TActor(m_ActorList[i]);
      if (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) > MAXLEFT2) or
      (g_MySelf.m_nCurrY - actor.m_nCurrY > MAXTOP2) or
      (g_MySelf.m_nCurrY - actor.m_nCurrY < MAXTOP3) then
        Continue;
      k := Actor.m_nRy - Map.m_nBlockTop - (Map.m_ClientRect.Top - Map.m_nBlockTop) - actor.m_nDownDrawLevel;
      if (k >= 0) and (k <= DRAWLISTCOUNT) then
      begin
        if Actor.m_boOutside then
          m_DrawOutsideList.Add(Actor);
        if Actor.m_boDeath then
        begin
          m_DrawArray[k].DeathActorList.Add(Actor);
        end
        else begin
          m_DrawArray[k].ActorList.Add(Actor);
          if (Actor.m_boShop) and (Actor.m_btRace = 0) and (Actor.m_boShopLeft) and (K > 0) then
          begin
            m_DrawArray[k - 1].ShopActorList.Add(Actor);
          end;
        end;
      end;
    end;
    nIndex := 4;
    for i := 0 to m_FlyList.Count - 1 do
    begin
      meff := TMagicEff(m_FlyList[i]);
      k := meff.Ry - Map.m_nBlockTop - (Map.m_ClientRect.Top - Map.m_nBlockTop);
      if (k >= 0) and (k <= DRAWLISTCOUNT) then
      begin
        m_DrawArray[k].MagicEffList.Add(meff);
      end;
    end;
    nIndex := 5;
    for j := (Map.m_ClientRect.Top - Map.m_nBlockTop) to (Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE) do
    begin
      if j < 0 then
      begin
        Inc(m, UNITY);
        continue;
      end;
      n := defx - UNITX * 2;
      //*** 48*32 ��һ������СͼƬ�Ĵ�С
      for i := (Map.m_ClientRect.Left - Map.m_nBlockLeft - 2) to (Map.m_ClientRect.Right - Map.m_nBlockLeft + 2) do
      begin
        if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT * 3) then
        begin
          fridx := (Map.m_MArr[i, j].wFrImg) and $7FFF;
          if fridx > 0 then
          begin
            ani := Map.m_MArr[i, j].btAniFrame;
            wunit := Map.m_MArr[i, j].btArea;
            blend := FALSE;
            if (ani and $80) > 0 then
            begin
              blend := TRUE;
              ani := ani and $7F;
            end;
            if ani > 0 then
            begin
              anitick := Map.m_MArr[i, j].btAniTick;
              fridx := fridx + (m_nAniCount mod (ani + (ani * anitick))) div (1 + anitick);
            end;
            if (Map.m_MArr[i, j].btDoorOffset and $80) > 0 then
            begin
              if (Map.m_MArr[i, j].btDoorIndex and $7F) > 0 then
                fridx := fridx + (Map.m_MArr[i, j].btDoorOffset and $7F);
            end;
            fridx := fridx - 1;
            // ȡͼƬ
            DSurface := GetObjsEx(wunit, fridx, ax, ay);
            if DSurface <> nil then
            begin
              if blend then
              begin
                mmm := m + ay - 68; //UNITY - DSurface.Height;
                if (n > 0) and (mmm + DSurface.Height > 0) and (n + Dsurface.Width < g_FScreenWidth) and (mmm < drawingbottomline) then
                begin
                  DrawBlend(m_ObjSurface, n + ax - 2, mmm, DSurface, 1);
                end
                else begin
                  if mmm < drawingbottomline then
                  begin
                    DrawBlend(m_ObjSurface, n + ax - 2, mmm, DSurface, 1);
                  end;
                end;
              end
              else if (DSurface.Width = 48) and (DSurface.Height = 32) then
              begin
                mmm := m + UNITY - DSurface.Height;
                if (n + DSurface.Width > 0) and (n <= g_FScreenWidth) and (mmm + DSurface.Height > 0) and
                (mmm < drawingbottomline) then
                begin
                  m_ObjSurface.Draw(n, mmm, DSurface.ClientRect, Dsurface, TRUE)
                end
                else begin
                  if mmm < drawingbottomline then
                  begin
                    m_ObjSurface.Draw(n, mmm, DSurface.ClientRect, DSurface, TRUE)
                  end;
                end;
              end
              else begin
                mmm := m + UNITY - DSurface.Height;
                if (n + DSurface.Width > 0) and (n <= g_FScreenWidth) and (mmm + DSurface.Height > 0) and
                (mmm < drawingbottomline) then
                begin
                  m_ObjSurface.Draw(n, mmm, DSurface.ClientRect, Dsurface, TRUE)
                end
                else begin
                  if mmm < drawingbottomline then
                  begin
                    m_ObjSurface.Draw(n, mmm, DSurface.ClientRect, DSurface, TRUE)
                  end;
                end;
              end;
            end;
          end;
        end;
        Inc(n, UNITX);
      end;
      if (j <= (Map.m_ClientRect.Bottom - Map.m_nBlockTop)) and (not g_boServerChanging) then
      begin
        k := j - (Map.m_ClientRect.Top - Map.m_nBlockTop);
        for ii := m_DrawArray[k].ClEvent.Count - 1 downto 0 do
        begin
          evn := TClEvent(m_DrawArray[k].ClEvent[ii]);
          evn.DrawEvent(m_ObjSurface, (evn.m_nX - Map.m_ClientRect.Left) * UNITX + defx, m);
        end;

        for ii := m_DrawArray[k].DeathActorList.Count - 1 downto 0 do
        begin
          actor := m_DrawArray[k].DeathActorList[ii];
          actor.m_nSayX := (actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx + actor.m_nShiftX + 24;
          actor.m_nSayY := m + UNITY + actor.m_nShiftY + 16 - 60 + (actor.m_nDownDrawLevel * UNITY);
          actor.m_nDrawX := (actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx;
          actor.m_nDrawY := m + (actor.m_nDownDrawLevel * UNITY);
          if not Actor.m_boOutside then
            actor.DrawChr(m_ObjSurface, actor.m_nDrawX, actor.m_nDrawY, FALSE, True);
        end;
        nIndex := 8;
        if g_boDrawDropItem then
        begin
          //��ʾ������Ʒ����
          for ii := m_DrawArray[k].ItemList.Count - 1 downto 0 do
          begin
            DropItem := PTDropItem(m_DrawArray[k].ItemList[ii]);
            if DropItem <> nil then
            begin
              d := GetDnItemImg(DropItem.Looks);
              if d <> nil then
              begin
                ix := (DropItem.x - Map.m_ClientRect.Left) * UNITX + defx + SOFFX; // + actor.ShiftX;
                iy := m; // + actor.ShiftY;
                if DropItem = g_FocusItem then
                begin
                  DrawEffect(m_ObjSurface, ix + HALFX - (d.Width div 2), iy + HALFY - (d.Height div 2), d, ceBright, False);
                end
                else begin
                  m_ObjSurface.Draw(ix + HALFX - (d.Width div 2), iy + HALFY - (d.Height div 2), d.ClientRect, d, TRUE);
                end;
              end;
            end;
          end;
        end;
        nIndex := 9;
        for ii := 0 to m_DrawArray[k].ShopActorList.Count - 1 do
        begin
          actor := m_DrawArray[k].ShopActorList[ii];
          actor.m_nSayX := (actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx + actor.m_nShiftX + 24;
          actor.m_nSayY := m + UNITY + actor.m_nShiftY + 16 - 95 + (actor.m_nDownDrawLevel * UNITY);
          d := g_WMain99Images.GetCachedImage(511 + actor.m_btShopIdx * 2, ax, ay);
          if d <> nil then
            m_ObjSurface.Draw(actor.m_nSayX + ax, actor.m_nSayY + ay, d.ClientRect, d, True);
        end;
        nIndex := 10;
        for ii := 0 to m_DrawArray[k].ActorList.Count - 1 do
        begin
          actor := m_DrawArray[k].ActorList[ii];
          actor.m_nSayX := (actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx + actor.m_nShiftX + 24;
          actor.m_nSayY := m + UNITY + actor.m_nShiftY + 16 - 95 + (actor.m_nDownDrawLevel * UNITY);
          actor.m_nDrawX := (actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx;
          actor.m_nDrawY := m + (actor.m_nDownDrawLevel * UNITY);
          if not Actor.m_boOutside then
          begin
            if ((not g_SetupInfo.boHideAroundHum) or (Actor.m_btRace <> 0) or (Actor = g_MySelf)) and
            ((not g_SetupInfo.boHideAllyHum) or (Actor.m_btRace <> 0) or (Actor = g_MySelf) or (Actor.m_OldNameColor <> ALLYCOLOR)) then
              actor.DrawChr(m_ObjSurface, actor.m_nDrawX, actor.m_nDrawY, FALSE, True);
            if Actor.m_boShop and not Actor.m_boShopLeft then
            begin
              d := g_WMain99Images.GetCachedImage(510 + actor.m_btShopIdx * 2, ax, ay);
              if d <> nil then
                m_ObjSurface.Draw((actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx + ax,
                                   m + (actor.m_nDownDrawLevel * UNITY) + ay, d.ClientRect, d, True);
            end;
            if Actor.m_nState and $02000000 <> 0 then
            begin
              d := g_WMons[24].GetCachedImage(3740 + GetTickCount div 200 mod 10, ax, ay);
              if d <> nil then
                m_ObjSurface.Draw(actor.m_nDrawX + ax, actor.m_nDrawY + ay, d.ClientRect, d, fxAnti);
            end;
          end;
        end;
        nIndex := 11;
        for ii := 0 to m_DrawArray[k].MagicEffList.Count - 1 do
        begin
          meff := TMagicEff(m_DrawArray[k].MagicEffList[ii]);
          meff.DrawEff(m_ObjSurface);
        end;
      end;
      Inc(m, UNITY);
    end;
    nIndex := 12;
    for I := 0 to m_DrawOutsideList.Count - 1 do
    begin
      actor := m_DrawOutsideList[i];
      actor.DrawChr(m_ObjSurface, actor.m_nDrawX, actor.m_nDrawY, FALSE, True);
    end;
      //��ʾ������Ʒ����
      //NameTexture := nil;
      //if g_boDrawDropItem then begin
      //TestTick1 := GetTickCount;
      //2010-10-01
    nIndex := 13;
    NameTexture := GetTempSurface(WILFMT_A4R4G4B4);
    HintTexture := GetTempSurface(WILFMT_A1R5G5B5);
    if (NameTexture <> nil) and (HintTexture <> nil) then
    begin
      NameTexture.Clear;
      HintTexture.Clear;
      nIndex := 14;
      for K := Low(m_DrawArray) to High(m_DrawArray) do
      begin
        for ii := m_DrawArray[k].ItemList.Count - 1 downto 0 do
        begin
          DropItem := PTDropItem(m_DrawArray[k].ItemList[ii]);
          if DropItem <> nil then
          begin
            ix := (DropItem.X - Map.m_ClientRect.Left) * UNITX + defx + SOFFX;
            iy := (DropItem.Y - Map.m_ClientRect.Top - 1) * UNITY + defy + SOFFY;
            if GetTickCount - DropItem.FlashTime > g_dwDropItemFlashTime {5 * 1000} then
            begin
              DropItem.FlashTime := GetTickCount;
              DropItem.BoFlash := TRUE;
              DropItem.FlashStepTime := GetTickCount;
              DropItem.FlashStep := 0;
            end;
            I := 0;
            if DropItem.BoFlash then
            begin
              if GetTickCount - DropItem.FlashStepTime >= 20 then
              begin
                DropItem.FlashStepTime := GetTickCount;
                Inc(DropItem.FlashStep);
              end;
              if (DropItem.FlashStep >= 0) and (DropItem.FlashStep < 10) then
              begin
                I := DropItem.FlashStep;
              end
              else
                DropItem.BoFlash := FALSE;
            end;
            if (DropItem <> g_FocusItem) and (DropItem.Filtr.boShow or (g_SetupInfo.boShowItemName and g_boCtrlDown)) then
            begin
              NameTexture.TextOutEx(ix + HALFX - DropItem.Width div 2,
                                     iy + HALFY - DropItem.Height * 2,
                                     DropItem.Name,
                                     DropItemColor[DropItem.Filtr.boColor]);
            end else begin
              if DropItem.BoFlash then
              begin
                DSurface := g_WMain99Images.GetCachedImage(FLASHBASE + I, ax, ay);
                HintTexture.CopyTexture(ix + ax, iy + ay, DSurface);
              end;
            end;
          end;
        end;
      end;
      nIndex := 15;
      if g_SetupInfo.boShowName or g_SetupInfo.boShowNameMon then
      begin
        k := 0;
        while True do
        begin
          if K > m_ActorList.Count then break;
          if K = m_ActorList.Count then
          begin
            Actor := g_MySelf;
            if not g_SetupInfo.boShowName then break;
          end
          else begin
            Actor := m_ActorList[k];
            if (Actor = g_MySelf) or ((Actor.m_btRace <> RCC_USERHUMAN) and Actor.m_boDeath) or
            (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) > MAXLEFT2) or
            (g_MySelf.m_nCurrY - actor.m_nCurrY > MAXTOP2) or
            (g_MySelf.m_nCurrY - actor.m_nCurrY < (MAXTOP3 + 1)) or
            (Actor.m_nSayX = 0) or
            ((not Actor.m_boShowName) and (not g_SetupInfo.boShowNameMon)) or
            ((Actor.m_boShowName) and (not g_SetupInfo.boShowName)) then
            begin
              Inc(k);
              Continue;
            end;
          end;
          if (g_FocusCret <> Actor) then
          begin
            if Actor = g_MySelf then
            begin
              if not g_boSelectMyself then
              begin
                if g_SetupInfo.boShowNameAll then
                begin
                  NameTextOut(Actor, NameTexture,
                               Actor.m_nSayX,
                               Actor.m_nSayY + 30,
                               Actor.m_NameColor,
                               Actor.m_sDescUserName + '\' + Actor.m_UserName, True);
                end else begin
                  if g_boUseWuXin and (Actor.m_btWuXin in [1..5]) then
                  begin
                    NameTexture.TextOutEx(Actor.m_nSayX - 12,
                                           Actor.m_nSayY + 30 - 6,
                                           '[' + GetWuXinName(Actor.m_btWuXin) + ']',
                                           GetWuXinColor(Actor.m_btWuXin));
                    NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_NameWidth div 2,
                                           Actor.m_nSayY + 30 + 6,
                                           Actor.m_UserName,
                                           Actor.m_NameColor);
                  end else begin
                    NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_NameWidth div 2,
                                           Actor.m_nSayY + 30,
                                           Actor.m_UserName,
                                           Actor.m_NameColor);
                  end;
                end;
              end;
            end else begin
              if (Actor.m_btRace = RCC_MERCHANT) then
              begin
                if Actor.m_sDescUserName <> '' then
                begin
                  NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_DescNameWidth div 2,
                                         Actor.m_nSayY + 30 - 6,
                                         Actor.m_sDescUserName,
                                         Actor.m_NameColor);
                  NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_NameWidth div 2,
                                         Actor.m_nSayY + 30 + 6,
                                         Actor.m_UserName,
                                         clWhite);
                end else begin
                  NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_NameWidth div 2,
                                         Actor.m_nSayY + 30,
                                         Actor.m_UserName,
                                         Actor.m_NameColor);
                end;

              end else begin
                if g_SetupInfo.boShowNameAll and (Actor.m_btRace = RCC_USERHUMAN) then
                begin
                  NameTextOut(Actor, NameTexture,
                               Actor.m_nSayX,
                               Actor.m_nSayY + 30,
                               Actor.m_NameColor,
                               Actor.m_sDescUserName + '\' + Actor.m_UserName, False);
                end else begin
                  NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_NameWidth div 2,
                                         Actor.m_nSayY + 30,
                                         Actor.m_UserName,
                                         Actor.m_NameColor);
                end;
              end;
            end;
          end;
          Inc(K);
        end;
      end;
      DrawBlend(m_ObjSurface, 0, 0, HintTexture, 1);
    end;
  except
    DebugOutStr('106 ' + intToStr(nIndex));
  end;
  if not g_boServerChanging then
  begin
    try
        //**** ������״̬
      if not g_boCheckBadMapMode then
        if g_MySelf.m_nState and $00800000 = 0 then
          g_MySelf.DrawChr(m_ObjSurface, (g_MySelf.m_nRx - Map.m_ClientRect.Left)
          * UNITX + defx, (g_MySelf.m_nRy - Map.m_ClientRect.Top - 1) * UNITY +
          defy, True, FALSE);

        //**** ��ǰ���ָ��Ľ�ɫ
      if (g_FocusCret <> nil) then
      begin
        if IsValidActor(g_FocusCret) and (g_FocusCret <> g_MySelf) then
          if (g_FocusCret.m_nState and $00800000 = 0) then
            g_FocusCret.DrawChr(m_ObjSurface,
                                 (g_FocusCret.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
                                 (g_FocusCret.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy,
                                 True, FALSE);
      end;
        //**** ��ħ����ʱ����������ʾ
      if (g_MagicTarget <> nil) then
      begin
        if IsValidActor(g_MagicTarget) and (g_MagicTarget <> g_MySelf) then
          if g_MagicTarget.m_nState and $00800000 = 0 then
            g_MagicTarget.DrawChr(m_ObjSurface,
                                   (g_MagicTarget.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
                                   (g_MagicTarget.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy,
                                   True, FALSE);
      end;
    except
      DebugOutStr('108');
    end;
  end;
  try
      //**** ����ɫЧ��
    for k := 0 to m_ActorList.count - 1 do
    begin
      Actor := m_ActorList[k];
      if (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) > MAXLEFT2) or
      (g_MySelf.m_nCurrY - actor.m_nCurrY > MAXTOP2) or
      (g_MySelf.m_nCurrY - actor.m_nCurrY < MAXTOP3) then
        Continue;
      Actor.DrawEff(m_ObjSurface,
                     (Actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
                     (Actor.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy);
    end;
  except
    DebugOutStr('109');
  end;
  //2010-10-01
  if NameTexture <> nil then
  begin
    if g_FBTime > 0 then
    begin
{$IF Var_Interface = Var_Mir2}
      NameTexture.TextOutEx(40, 3, g_sFBTime, clLime);
{$ELSE}
      NameTexture.TextOutEx(92, 39, g_sFBTime, clLime);  
{$IFEND}

    end;
    if g_FBExitTime > 0 then
    begin
      NameTexture.TextOutEx(319, {$IF Var_Interface = Var_Mir2}136{$ELSE}                 146{$IFEND}, g_sFBExitTime, clYellow);
    end else
      if g_FBFailTime > 0 then
      begin
        NameTexture.TextOutEx(160, {$IF Var_Interface = Var_Mir2}136{$ELSE}                 146{$IFEND}, g_sFBFailTime, clYellow);
      end;
    m_ObjSurface.Draw(0, 0, NameTexture.ClientRect, NameTexture, fxBlend);
  end;
  try
    PlayDrawScreen;
  except
    DebugOutStr('111');
  end;

  try
    PlayDrawCenterMsg();
  except
    DebugOutStr('112');
  end;
  m_dwPlayChangeTick := GetTickCount + 50;
end;

procedure TPlayScene.MagicSurface(Sender: TObject);
var
  k: integer;
  meff: TMagicEff;
begin
  m_MagSurface.Draw(SOFFX, SOFFY, m_ObjSurface.ClientRect, m_ObjSurface, FALSE);
  for k := 0 to m_EffectList.count - 1 do
  begin
    meff := TMagicEff(m_EffectList[k]);
    meff.DrawEff(m_ObjSurface);
  end;
end;

{------------------------------------------------------------------------------}
//ʵ����ָ��Ŀ�겥��ĳ��ħ��Ч��(20071029 ����)
//NewMagic(aowner, magid,magnumb,cx,cy,tx,ty,targetcode,mtype,Recusion,anitime,bofly)
//
//
//        �����Ժ�����
//
//
//
{------------------------------------------------------------------------------}
//cx, cy, tx, ty : ���� ��ǥ

procedure TPlayScene.NewMagic(aowner: TActor;
                                 magid, magnumb {Effect}, cx, cy, tx, ty, targetcode: Integer;
                                 mtype: TMagicType; //EffectType
                                 Recusion: Boolean;
                                 anitime: Integer;
                                 var bofly: Boolean);
var
  i, scx, scy, sctx, scty, effnum: Integer;
  meff: TMagicEff;
  target: TActor;
  wimg: TWMImages;
begin
  bofly := FALSE;
  if magid <> 111 then //
    for i := 0 to m_EffectList.count - 1 do
      if TMagicEff(m_EffectList[i]).ServerMagicId = magid then
        Exit; //
  ScreenXYfromMCXY(cx, cy, scx, scy);
  ScreenXYfromMCXY(tx, ty, sctx, scty);
  if magnumb > 0 then
    GetEffectBase(magnumb - 1, 0, wimg, effnum) //magnumb{Effect}
  else
    effnum := -magnumb;
  target := FindActor(targetcode); //Ŀ��

  meff := nil;
  case mtype of //EffectType
    mtReady, mtFly, mtFlyAxe:
    begin
      if magnumb = 120 then
      begin
        for I := 0 to 2 do
        begin
          meff := TDelayMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.TargetActor := target;
          TDelayMagicEff(meff).nDelayTime := GetTickCount + LongWord(I * 100);
          meff.frame := 5;
          meff.EffectBase := 3240;
          meff.ImgLib := g_WCboEffectImages;
          meff.MagExplosionBase := 3560;
          if i = 0 then
            meff.ExplosionFrame := 6
          else
            meff.ExplosionFrame := 1;
          meff.m_nFlyParameter := 600;

          meff.TargetRx := tx;
          meff.TargetRy := ty;
          if meff.TargetActor <> nil then
          begin
            meff.TargetRx := TActor(meff.TargetActor).m_nCurrX;
            meff.TargetRy := TActor(meff.TargetActor).m_nCurrY;
          end;
          meff.MagOwner := aowner;
          m_EffectList.Add(meff);
        end;
        exit;
      end
      else if magnumb = 118 then
      begin
        meff := TTigerMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
        meff.TargetActor := target;
        TTigerMagicEff(meff).btDir := aowner.m_btDir;
        meff.frame := 5;
        meff.EffectBase := 3580;
        meff.Repetition := False;
        meff.ImgLib := g_WCboEffectImages;
        meff.MagExplosionBase := 3740;
        meff.ExplosionFrame := 10;
        meff.m_nFlyParameter := 600;
      end
      else if magnumb = 33 then
      begin
        meff := TFlameIceMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
        meff.TargetActor := target;
      end
      else begin
        meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
        meff.TargetActor := target;
        if magnumb = 98 then
        begin
          meff.frame := 3;
          meff.EffectBase := 100;
          meff.MagExplosionBase := 270;
          meff.TargetActor := target;
          meff.NextFrameTime := 60;
          meff.ExplosionFrame := 10;
          meff.ImgLib := g_WMagic5Images;
        end else
          if magnumb = 99 then
          begin
            meff.frame := 6;
            meff.EffectBase := 280;
            meff.MagExplosionBase := 450;
            meff.TargetActor := target;
            meff.NextFrameTime := 60;
            meff.ExplosionFrame := 10;
            meff.ImgLib := g_WMagic5Images;
          end else
            if magnumb = 39 then
            begin
              meff.frame := 4;
              if wimg <> nil then
                meff.ImgLib := wimg;
            end
            else if magnumb = 114 then
            begin
              //meff.NextFrameTime := 0;
              meff.EffectBase := 2600;
              meff.frame := 5;
              meff.ImgLib := g_WCboEffectImages;
              meff.MagExplosionBase := 2770;
              meff.ExplosionFrame := 25;
              meff.m_nFlyParameter := 600;
            end;
        if magnumb = 115 then
        begin
          meff.EffectBase := 2410;
          meff.frame := 3;
          meff.ImgLib := g_WCboEffectImages;
          meff.MagExplosionBase := 2580;
          meff.ExplosionFrame := 8;
          meff.m_nFlyParameter := 600;
        end;
        if magnumb = 116 then
        begin
          meff.EffectBase := 4230;
          meff.NotFixed := True;
          meff.frame := 4;
          meff.ImgLib := g_WCboEffectImages;
          meff.MagExplosionBase := 4240;
          meff.ExplosionFrame := 8;
          meff.m_nFlyParameter := 600;
        end;
        if magnumb = 119 then
        begin
          meff.EffectBase := 2080;
          meff.frame := 3;
          meff.MagExplosionDir := True;
          meff.ImgLib := g_WCboEffectImages;
          meff.MagExplosionBase := 2250;
          meff.ExplosionFrame := 5;
          meff.m_nFlyParameter := 600;
        end;
        if magnumb = 121 then
        begin
          meff.EffectBase := 2810;
          meff.frame := 5;
          meff.Repetition := False;
          meff.MagExplosionDir := True;
          meff.ImgLib := g_WCboEffectImages;
          meff.MagExplosionBase := 2980;
          meff.ExplosionFrame := 10;
          meff.m_nFlyParameter := 600;
        end;
      end;
      bofly := True;
    end;
    mtExplosion: case magnumb of
                   18:
                   begin
                     //�ջ�֮��
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 1570;
                     meff.TargetActor := target;
                     meff.NextFrameTime := 80;
                   end;
                   21:
                   begin
                     //���ѻ���
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 1660;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 20;
                     meff.light := 3;
                   end;
                   26:
                   begin
                     //������ʾ
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
                                               Recusion, anitime);
                     meff.MagExplosionBase := 3990;
                     meff.TargetActor := target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 10;
                     meff.light := 2;
                   end;
                   27:
                   begin
                     //Ⱥ��������
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
                                               Recusion, anitime);
                     meff.MagExplosionBase := 1800;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 10;
                     meff.light := 3;
                   end;
                   30:
                   begin
                     //ʥ����
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
                                               Recusion, anitime);
                     meff.MagExplosionBase := 3930;
                     meff.TargetActor := target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 16;
                     meff.light := 3;
                   end;
                   31:
                   begin
                     //������
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 3850;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 20;
                     meff.light := 3;
                   end;
                   34:
                   begin
                     //�����
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
                                               Recusion, anitime);
                     meff.MagExplosionBase := 140;
                     meff.TargetActor := target; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 20;
                     meff.light := 3;
                     if wimg <> nil then
                       meff.ImgLib := wimg;
                   end;
                   40:
                   begin
                     // ������
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
                                               Recusion, anitime);
                     meff.MagExplosionBase := 620;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 100;
                     meff.ExplosionFrame := 20;
                     meff.light := 3;
                     if wimg <> nil then
                       meff.ImgLib := wimg;
                   end;
                   45:
                   begin
                     //��������
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 920;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 100;
                     meff.ExplosionFrame := 20;
                     meff.light := 3;
                     if wimg <> nil then
                       meff.ImgLib := wimg;
                   end;
                   47, MAGICEX_AMYOUNSULGROUP:
                   begin
                     //쫷���
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 990;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 100;
                     meff.ExplosionFrame := 10;
                     meff.light := 3;
                     if wimg <> nil then
                       meff.ImgLib := g_WMagic2Images;
                   end;
                   48:
                   begin
                     //Ѫ��
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 1060;
                     meff.TargetActor := target; //target;
                     meff.NextFrameTime := 50;
                     meff.ExplosionFrame := 20;
                     meff.light := 3;
                     if wimg <> nil then
                       meff.ImgLib := wimg;
                   end;
                   49:
                   begin
                     //���ǻ���
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 640;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 60;
                     meff.ExplosionFrame := 40;
                     if wimg <> nil then
                       meff.ImgLib := wimg;
                   end;
                   58:
                   begin
                     //��˪ѩ��
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 370;
                     meff.MagicId := 66;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 70;
                     meff.ExplosionFrame := 40;
                     if wimg <> nil then
                       meff.ImgLib := wimg;
                   end;
                   51:
                   begin
                     //������
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 910;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 100;
                     meff.ExplosionFrame := 11;
                     meff.ImgLib := g_WMagic99Images;
                   end;
                   53:
                   begin
                     //������
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 820;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 13;
                     meff.ImgLib := g_WMagic99Images;
                   end;
                   52:
                   begin
                     //�¸�����
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 850;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 10;
                     meff.ImgLib := g_WMagic99Images;
                   end;
                   55:
                   begin
                     //������
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 1010;
                     meff.TargetActor := target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 18;
                     meff.ImgLib := g_WMagic2Images;
                   end;
                   71:
                   begin
                     //��˪Ⱥ��
                     ScreenXYfromMCXY(tx - 2, ty - 2, sctx, scty);
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 80;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 17;
                     if wimg <> nil then
                       meff.ImgLib := wimg;

                     meff.TargetRx := tx - 2;
                     meff.TargetRy := ty - 2;
                     meff.MagOwner := aowner;
                     m_EffectList.Add(meff);

                     ScreenXYfromMCXY(tx + 2, ty - 2, sctx, scty);
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 80;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 17;
                     if wimg <> nil then
                       meff.ImgLib := wimg;

                     meff.TargetRx := tx + 2;
                     meff.TargetRy := ty - 2;
                     meff.MagOwner := aowner;
                     m_EffectList.Add(meff);

                     ScreenXYfromMCXY(tx + 2, ty + 2, sctx, scty);
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 80;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 17;
                     if wimg <> nil then
                       meff.ImgLib := wimg;

                     meff.TargetRx := tx + 2;
                     meff.TargetRy := ty + 2;
                     meff.MagOwner := aowner;
                     m_EffectList.Add(meff);

                     ScreenXYfromMCXY(tx - 2, ty + 2, sctx, scty);
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 80;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 17;
                     if wimg <> nil then
                       meff.ImgLib := wimg;

                     meff.TargetRx := tx - 2;
                     meff.TargetRy := ty + 2;
                     meff.MagOwner := aowner;
                     m_EffectList.Add(meff);

                     ScreenXYfromMCXY(tx, ty, sctx, scty);
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 80;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 17;
                     if wimg <> nil then
                       meff.ImgLib := wimg;
                   end;
                   72:
                   begin
                     //����֮��
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 30;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 22;
                     if wimg <> nil then
                       meff.ImgLib := wimg;
                   end;
                   117:
                   begin
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.MagExplosionBase := 3150 + aowner.m_btDir * 10;
                     meff.TargetActor := nil; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 10;
                     meff.ImgLib := g_WcboEffectImages;
                     meff.light := 3;
                   end;
                   123:
                   begin
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, False, anitime);
                     meff.MagExplosionBase := 930;
                     meff.TargetActor := aowner; //target;
                     meff.NextFrameTime := 40;
                     meff.FixedEffect := True;
                     meff.ExplosionFrame := 10;
                     meff.ImgLib := g_WMagic99Images;
                   end;
                   124:
                   begin
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, False, anitime);
                     meff.MagExplosionBase := 1391;
                     //meff.TargetActor := aowner; //target;
                     meff.NextFrameTime := 80;
                     meff.ExplosionFrame := 14;
                     meff.ImgLib := g_WMagic2Images;
                   end;
                   4:
                   begin
                     //ʩ������
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.TargetActor := target;
                     meff.NextFrameTime := 80;
                     meff.MagExplosionBase := 578;
                     meff.ImgLib := g_WMagic99Images;
                   end;
                   MAGICEX_AMYOUNSUL:
                   begin
                     //ʩ������
                     meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
                     meff.TargetActor := target;
                     meff.NextFrameTime := 80;
                     meff.MagExplosionBase := 598;
                     meff.ImgLib := g_WMagic99Images;
                   end
    else
    begin
      //Ĭ��
      meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
      meff.TargetActor := target;
      meff.NextFrameTime := 80;
    end;
    end;
    mtFireWind: meff := nil; //ȿ�� ����
    mtFireGun: //ȭ�����
      meff := TFireGunEffect.Create(930, scx, scy, sctx, scty);
    mtThunder:
    begin
      //meff := TThuderEffect.Create (950, sctx, scty, nil); //target);
      if magid = 75 then
      begin
        meff := TThuderEffect.Create(400, sctx, scty, nil); //target);
        meff.ExplosionFrame := 4;
        meff.ImgLib := g_WDragonImages;
      end else begin
        if g_WMagic7Images.boInitialize then
        begin
          meff := TThuderEffect.Create(20, sctx, scty, nil); //target);
          meff.ExplosionFrame := 10;
          meff.NextFrameTime := 80;
          meff.ImgLib := g_WMagic7Images;
        end else begin
          meff := TThuderEffect.Create(10, sctx, scty, nil); //target);
          meff.ExplosionFrame := 10;
          meff.NextFrameTime := 80;
          meff.ImgLib := g_WMagic2Images;
        end;
      end;
    end;
    mtLightingThunder:
    begin
//�����Ӱ ħ��

      meff := TLightingThunder.Create(970, scx, scy, sctx, scty, target);
    end;
    mtExploBujauk:
    begin
      case magnumb of
        10:
        begin
          //
          meff := TExploBujaukEffect.Create(140, scx, scy, sctx, scty, target);
          meff.ImgLib := g_WMagic6Images;
          TExploBujaukEffect(meff).MagicNumber := 10;
          meff.MagExplosionBase := 300;
        end;
        59:
        begin
          //
          meff := TExploBujaukEffect.Create(1110, scx, scy, sctx, scty, target);
          meff.ImgLib := g_WMagic8Images;
          TExploBujaukEffect(meff).MagicNumber := 10;
          TExploBujaukEffect(meff).MagicBlend := True;
          meff.MagExplosionBase := 1640;
          meff.frame := 6;
        end;
        17:
        begin
          ////����������
          meff := TExploBujaukEffect.Create(140, scx, scy, sctx, scty, target);
          TExploBujaukEffect(meff).MagicNumber := 17;
          meff.ImgLib := g_WMagic6Images;
          meff.MagExplosionBase := 1540;
        end;
      end;
      bofly := True;
    end;
    mtBujaukGroundEffect:
    begin
      meff := TBujaukGroundEffect.Create(140, magnumb, scx, scy, sctx, scty);
      meff.ImgLib := g_WMagic6Images;
      case magnumb of
        11: meff.ExplosionFrame := 20; ////�����
        12: meff.ExplosionFrame := 20; ////��ʥս����
        46: meff.ExplosionFrame := 24; //������
      end;
      bofly := True;
    end;
    mtKyulKai:
    begin
      meff := nil; //TKyulKai.Create (1380, scx, scy, sctx, scty);
    end;
    mt12:
    begin

    end;
    mt13:
    begin
      meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
      if meff <> nil then
      begin
        case magnumb of
          32:
          begin
            meff.ImgLib := g_WMons[21];
            meff.MagExplosionBase := 3580;
            meff.TargetActor := target;
            meff.light := 3;
            meff.NextFrameTime := 20;
          end;
          37:
          begin
            meff.ImgLib := g_WMons[22];
            meff.MagExplosionBase := 3520;
            meff.TargetActor := target;
            meff.light := 5;
            meff.NextFrameTime := 20;
          end;
        end;
      end;
    end;
    mt14:
    begin
      meff := TThuderEffect.Create(100, sctx, scty, nil); //target);
      meff.ExplosionFrame := 15;
      meff.ImgLib := g_WMagic6Images;
    end;
    mt15:
    begin
      meff := TFlyingBug.Create(magid, effnum, scx, scy, sctx, scty, mtype,
                                 Recusion, anitime);
      meff.TargetActor := target;
      bofly := True;
    end;
    mt16:
    begin

    end;
  end;
  if (meff = nil) then
    Exit;

  meff.TargetRx := tx;
  meff.TargetRy := ty;
  if meff.TargetActor <> nil then
  begin
    meff.TargetRx := TActor(meff.TargetActor).m_nCurrX;
    meff.TargetRy := TActor(meff.TargetActor).m_nCurrY;
  end;
  meff.MagOwner := aowner;
  m_EffectList.Add(meff);
end;

procedure TPlayScene.DelMagic(magid: Integer);
var
  i: Integer;
begin
  for i := 0 to m_EffectList.count - 1 do
  begin
    if TMagicEff(m_EffectList[i]).ServerMagicId = magid then
    begin
      TMagicEff(m_EffectList[i]).Free;
      m_EffectList.Delete(i);
      break;
    end;
  end;
end;

//cx, cy, tx, ty : ���� ��ǥ

function TPlayScene.NewFlyObject(aowner: TActor; cx, cy, tx, ty, targetcode: Integer; mtype: TMagicType): TMagicEff;
var
  scx, scy, sctx, scty: Integer;
  meff: TMagicEff;
begin
  ScreenXYfromMCXY(cx, cy, scx, scy);
  ScreenXYfromMCXY(tx, ty, sctx, scty);
  case mtype of
    mtFlyArrow: meff := TFlyingArrow.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
    mt12: meff := TFlyingFireBall.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
    mt15: meff := TFlyingBug.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
  else
    meff := TFlyingAxe.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
  end;
  meff.TargetRx := tx;
  meff.TargetRy := ty;
  meff.TargetActor := FindActor(targetcode);
  meff.MagOwner := aowner;
  m_FlyList.Add(meff);
  Result := meff;
end;

procedure TPlayScene.ScreenXYfromMCXY(cx, cy: Integer; var sx, sy: Integer);
var
  dx,dy: Integer;
begin
  if g_MySelf = nil then Exit;
{$IF Var_Interface = Var_Mir2}
    dx := g_FScreenWidth div 2 - 36;
    sx := (cx - g_MySelf.m_nRx) * UNITX + dx + UNITX div 2 - g_MySelf.m_nShiftX;

    dy := g_FScreenHeight div 2 - 66;
    sy := (cy - g_MySelf.m_nRy) * UNITY + dy + UNITY div 2 - g_MySelf.m_nShiftY;
{$ELSE}
  if g_FScreenWidth = 1024 then sx := (cx - g_MySelf.m_nRx) * UNITX + 476 + UNITX div 2 - g_MySelf.m_nShiftX
  else sx := (cx - g_MySelf.m_nRx) * UNITX + 364 + UNITX div 2 - g_MySelf.m_nShiftX;

  if g_FScreenHeight = 768 then sy := (cy - g_MySelf.m_nRy) * UNITY + 384 + UNITY div 2 - g_MySelf.m_nShiftY
  else sy := (cy - g_MySelf.m_nRy) * UNITY + 288 + UNITY div 2 - g_MySelf.m_nShiftY;
{$IFEND}
end;

//��Ļ���� mx, myת����ccx, ccy��ͼ����

procedure TPlayScene.CXYfromMouseXY(mx, my: Integer; var ccx, ccy: Integer);
var
  sx,sy: Integer;
begin
  if g_MySelf = nil then Exit;
{$IF Var_Interface = Var_Mir2}
  sx := g_FScreenWidth div 2 - 36;
  ccx := Round((mx - sx + g_MySelf.m_nShiftX - UNITX div 2) / UNITX) + g_MySelf.m_nRx;
  sy := g_FScreenHeight div 2 - 66;
  ccy := Round((my - sy + g_MySelf.m_nShiftY - UNITY div 2) / UNITY) + g_MySelf.m_nRy;
{$ELSE}
  if g_FScreenWidth = 1024 then ccx := Round((mx - 476 + g_MySelf.m_nShiftX - UNITX div 2) / UNITX) + g_MySelf.m_nRx
  else ccx := Round((mx - 364 + g_MySelf.m_nShiftX - UNITX div 2) / UNITX) + g_MySelf.m_nRx;

  if g_FScreenHeight = 768 then ccy := Round((my - 384 + g_MySelf.m_nShiftY - UNITY div 2) / UNITY) + g_MySelf.m_nRy
  else ccy := Round((my - 288 + g_MySelf.m_nShiftY - UNITY div 2) / UNITY) + g_MySelf.m_nRy;
{$IFEND}

end;

//��ͼ�����������Ϊ��λѡ��

function TPlayScene.GetCharacter(X, Y, wantsel: Integer; var nowsel: Integer;
                                    liveonly: Boolean): TActor;
var
  k, i, ccx, ccy, dx, dy: Integer;
  a: TActor;
begin
  Result := nil;
  nowsel := -1;
  CXYfromMouseXY(X, Y, ccx, ccy);
  for k := ccy + 8 downto ccy - 1 do
  begin
    for i := m_ActorList.count - 1 downto 0 do
      if TActor(m_ActorList[i]) <> g_MySelf then
      begin
        a := TActor(m_ActorList[i]);
        if (not liveonly or not a.m_boDeath) and (a.m_boHoldPlace) and (a.m_boVisible) then
        begin
          if a.m_nCurrY = k then
          begin
            //ѡ��ķ�Χ�����
            dx := (a.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX + a.m_nPx + a.m_nShiftX;
            dy := (a.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY + a.m_nPy + a.m_nShiftY;
            if a.CheckSelect(X - dx, Y - dy) then
            begin
              Result := a;
              Inc(nowsel);
              if nowsel >= wantsel then
                Exit;
            end;
          end;
        end;
      end;
  end;
end;

//ȡ�������ָ����Ľ�ɫ

function TPlayScene.GetAttackFocusCharacter(X, Y, wantsel: Integer; var nowsel: Integer; liveonly: Boolean): TActor;
var
  k, i, ccx, ccy, dx, dy, centx, centy: Integer;
  a: TActor;
begin
  Result := GetCharacter(X, Y, wantsel, nowsel, liveonly);
  if Result = nil then
  begin
    nowsel := -1;
    CXYfromMouseXY(X, Y, ccx, ccy);
    for k := ccy + 8 downto ccy - 1 do
    begin
      for i := m_ActorList.count - 1 downto 0 do
        if TActor(m_ActorList[i]) <> g_MySelf then
        begin
          a := TActor(m_ActorList[i]);
          if (not liveonly or not a.m_boDeath) and (a.m_boHoldPlace) and (a.m_boVisible) then
          begin
            if a.m_nCurrY = k then
            begin
              //
              dx := (a.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX + a.m_nPx + a.m_nShiftX;
              dy := (a.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY + a.m_nPy + a.m_nShiftY;
              if a.CharWidth > 40 then
                centx := (a.CharWidth - 40) div 2
              else
                centx := 0;
              if a.CharHeight > 70 then
                centy := (a.CharHeight - 70) div 2
              else
                centy := 0;
              if (X - dx >= centx) and (X - dx <= a.CharWidth - centx) and (Y - dy >= centy) and
              (Y - dy <= a.CharHeight - centy) then
              begin
                Result := a;
                Inc(nowsel);
                if nowsel >= wantsel then
                  Exit;
              end;
            end;
          end;
        end;
    end;
  end;
end;

function TPlayScene.IsSelectMyself(X, Y: Integer): Boolean;
var
  k, ccx, ccy, dx, dy: Integer;
begin
  Result := FALSE;
  CXYfromMouseXY(X, Y, ccx, ccy);
  for k := ccy + 2 downto ccy - 1 do
  begin
    if g_MySelf.m_nCurrY = k then
    begin
      //ѡ��ķ�Χ�����
      dx := (g_MySelf.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX + g_MySelf.m_nPx + g_MySelf.m_nShiftX;
      dy := (g_MySelf.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY + g_MySelf.m_nPy + g_MySelf.m_nShiftY;
      if g_MySelf.CheckSelect(X - dx, Y - dy) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;
//ȡ��ָ�����������Ʒ
// x,y Ϊ��Ļ����

//ȡ��ָ�����������Ʒ
// x,y Ϊ��Ļ����
function TPlayScene.GetDropItems(X, Y: Integer; var inames: string; var MaxWidth: Integer): pTDropItem;
var
  i, ccx, ccy, ssx, ssy, nWidth: Integer;
  DropItem: pTDropItem;
begin
  Result := nil;
  CXYfromMouseXY(X, Y, ccx, ccy);
  ScreenXYfromMCXY(ccx, ccy, ssx, ssy);
  inames := '';
  MaxWidth := 0;
  for i := 0 to g_DropedItemList.count - 1 do
  begin
    DropItem := pTDropItem(g_DropedItemList[i]);
    if (DropItem.X = ccx) and (DropItem.Y = ccy) then
    begin
      if Result = nil then
        Result := DropItem;
      nWidth := g_DXCanvas.TextWidth(DropItem.name);
      if nWidth > MaxWidth then MaxWidth := nWidth;
      inames := inames + DropItem.name + '\';
    end;
  end;
end;

procedure TPlayScene.GetXYDropItemsList(nX, nY: Integer; var ItemList: TList);
var
  i: Integer;
  DropItem: pTDropItem;
begin
  for i := 0 to g_DropedItemList.count - 1 do
  begin
    DropItem := g_DropedItemList[i];
    if (DropItem.X = nX) and (DropItem.Y = nY) then
    begin
      ItemList.Add(DropItem);
    end;
  end;
end;

function TPlayScene.GetXYDropItems(nX, nY: Integer): pTDropItem;
var
  i: Integer;
  DropItem: pTDropItem;
begin
  Result := nil;
  for i := 0 to g_DropedItemList.count - 1 do
  begin
    DropItem := g_DropedItemList[i];
    if (DropItem.X = nX) and (DropItem.Y = nY) then
    begin
      Result := DropItem;
      break;
    end;
  end;
end;

function TPlayScene.CanHorseRun(sx, sy, ex, ey: Integer): Boolean;
var
  ndir, rx, ry: Integer;
begin
  Result := False;
  if g_boSendLuck then
    exit;

  ndir := GetNextDirection(sx, sy, ex, ey);
  rx := sx;
  ry := sy;
  GetNextPosXY(ndir, rx, ry);
  if not CanWalkEx(rx, ry) then
    exit;
  GetNextPosXY(ndir, rx, ry);
  if CanWalkEx(rx, ry) and CanWalkEx(ex, ey) then
    Result := True
  else
    Result := FALSE;
end;

function TPlayScene.CanHorseRunEx(sx, sy, ex, ey: Integer): Boolean;
var
  ndir, rx, ry: Integer;
begin
  Result := False;
  if g_boSendLuck then
    exit;

  ndir := GetNextDirection(sx, sy, ex, ey);
  rx := sx;
  ry := sy;
  GetNextPosXY(ndir, rx, ry);
  if not CanWalkEx2(rx, ry) then
    exit;
  GetNextPosXY(ndir, rx, ry);
  if CanWalkEx2(rx, ry) and CanWalkEx2(ex, ey) then
    Result := True
  else
    Result := FALSE;
end;

function TPlayScene.CanLeap(sx, sy, ex, ey: Integer): Boolean;
begin
  Result := False;
  if g_boSendLuck then
    exit;
  if CanWalkEx(ex, ey) then
    Result := True
  else
    Result := FALSE;
end;

function TPlayScene.CanRun(sx, sy, ex, ey: Integer): Boolean;
var
  ndir, rx, ry: Integer;
begin
  Result := False;
  if g_boSendLuck then
    exit;
  ndir := GetNextDirection(sx, sy, ex, ey);
  rx := sx;
  ry := sy;
  GetNextPosXY(ndir, rx, ry);

  if CanWalkEx(rx, ry) and CanWalkEx(ex, ey) then
    Result := True
  else
    Result := FALSE;
end;

function TPlayScene.CanRunEx(sx, sy, ex, ey: Integer): Boolean;
var
  ndir, rx, ry: Integer;
begin
  ndir := GetNextDirection(sx, sy, ex, ey);
  rx := sx;
  ry := sy;
  GetNextPosXY(ndir, rx, ry);

  if CanWalkEx2(rx, ry) and CanWalkEx2(ex, ey) then
    Result := True
  else
    Result := FALSE;

end;

function TPlayScene.CanWalkEx(mx, my: Integer): Boolean;
begin
  Result := FALSE;
  if Map.CanMove(mx, my) then
    Result := not CrashManEx(mx, my); //����
end;

function TPlayScene.CanWalkEx2(mx, my: Integer): Boolean;
begin
  Result := FALSE;
  if Map.CanMove(mx, my) then
    Result := not CrashManEx2(mx, my);
end;

function TPlayScene.CrashManEx2(mx, my: Integer): Boolean;
var
  i: Integer;
  Actor: TActor;
begin
  Result := FALSE;
  for i := 0 to m_ActorList.count - 1 do
  begin
    Actor := TActor(m_ActorList[i]);
    if (Actor.m_boVisible) and (Actor.m_boHoldPlace) and (not Actor.m_boDeath)
    and (Actor.m_nCurrX = mx) and (Actor.m_nCurrY = my) then
    begin
      Result := True;
      break;
    end;
  end;
end;
//����

function TPlayScene.CrashManEx(mx, my: Integer): Boolean;
var
  i: Integer;
  Actor: TActor;
begin
  Result := FALSE;

  for i := 0 to m_ActorList.count - 1 do
  begin
    Actor := TActor(m_ActorList[i]);
    if (Actor.m_boVisible) and (Actor.m_boHoldPlace) and (not Actor.m_boDeath)
    and (Actor.m_nCurrX = mx) and (Actor.m_nCurrY = my) then
    begin
      //      DScreen.AddChatBoardString ('Actor.m_btRace ' + IntToStr(Actor.m_btRace),clWhite, clRed);
      if g_ClientConf.boWarDisHumRun and (g_nAreaStateValue = OT_FREEPKAREA) then
      begin
        Result := True;
        Exit;
      end;
      if (Actor.m_btRace = RCC_USERHUMAN) then
      begin
        if g_ClientConf.boRUNHUMAN or (g_ClientConf.SafeAreaLimited and (g_nAreaStateValue = OT_SAFEAREA)) then
          continue;
      end
      else if (Actor.m_btRace = RCC_MERCHANT) then
      begin
        if g_ClientConf.boRunNpc then
          continue;
      end
      else if ((Actor.m_btRace <> RCC_USERHUMAN) and (Actor.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD])) then
      begin
        if g_ClientConf.boRunGuard then
          continue;
      end
      else if (Actor.m_btRaceServer <> 55) and (Actor.m_btRaceServer <> 30) then
      begin
        if g_ClientConf.boRUNMON or
        (g_ClientConf.SafeAreaLimited and (g_nAreaStateValue = OT_SAFEAREA)) then
          Continue;
      end;
      //m_btRace ���� 0 �������� 50 ��Ϊ����
      Result := True;
      break;
    end;
  end;
end;

function TPlayScene.CanWalk(mx, my: Integer): Boolean;
begin
  if g_boSendLuck then
  begin
    Result := False;
    exit;
  end;
  Result := FALSE;
  if Map.CanMove(mx, my) then
    Result := not CrashMan(mx, my);
end;

function TPlayScene.CrashMan(mx, my: Integer): Boolean;
var
  i: Integer;
  a: TActor;
begin
  Result := FALSE;
  for i := 0 to m_ActorList.count - 1 do
  begin
    a := TActor(m_ActorList[i]);
    if (a.m_boVisible) and (a.m_boHoldPlace) and (not a.m_boDeath) and
    (a.m_nCurrX = mx) and (a.m_nCurrY = my) then
    begin
      Result := True;
      break;
    end;
  end;
end;

function TPlayScene.CanDrawTileMap: Boolean;
begin
  Result := False;
  with Map do
    if (m_ClientRect.Left = m_OldClientRect.Left) and (m_ClientRect.Top = m_OldClientRect.Top) then
      Exit;
  if not g_boDrawTileMap then
    Exit;
  Result := True;
end;

function TPlayScene.CanFly(mx, my: Integer): Boolean;
begin
  Result := Map.CanFly(mx, my);
end;

{------------------------ Actor ------------------------}

function TPlayScene.FindNpcActor(id: Integer): TNpcActor;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to m_ActorList.count - 1 do
  begin
    if TActor(m_ActorList[i]).m_nRecogId = id then
    begin
      if TActor(m_ActorList[i]) is TNpcActor then
      begin
        Result := TNpcActor(m_ActorList[i]);
      end;
      break;
    end;
  end;
end;
//ͨ��ID ���������ɫ
function TPlayScene.FindActor(id: Integer): TActor;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to m_ActorList.count - 1 do
  begin
    if TActor(m_ActorList[i]).m_nRecogId = id then
    begin
      Result := TActor(m_ActorList[i]);
      break;
    end;
  end;
end;
//ͨ�������������ɫ
function TPlayScene.FindActor(sname: string): TActor;
var
  i: Integer;
  Actor: TActor;
begin
  Result := nil;
  for i := 0 to m_ActorList.count - 1 do
  begin
    Actor := TActor(m_ActorList[i]);
    if CompareText(Actor.m_UserName, sname) = 0 then
    begin
      Result := Actor;
      break;
    end;
  end;
end;
//��X��Y�����������ɫ
function TPlayScene.FindActorXY(X, Y: Integer): TActor;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to m_ActorList.count - 1 do
  begin
    if (TActor(m_ActorList[i]).m_nCurrX = X) and (TActor(m_ActorList[i]).m_nCurrY = Y) then
    begin
      Result := TActor(m_ActorList[i]);
      if (not Result.m_boDeath) and Result.m_boVisible and Result.m_boHoldPlace then
        break;
      Result := nil;
    end;
  end;
end;
//�б����Ƿ��������ɫ
function TPlayScene.IsValidActor(Actor: TActor): Boolean;
var
  i: Integer;
begin
  Result := FALSE;
  for i := 0 to m_ActorList.count - 1 do
  begin
    if TActor(m_ActorList[i]) = Actor then
    begin
      Result := True;
      break;
    end;
  end;
end;

procedure TPlayScene.Lost;
begin
  if m_MapSurface <> nil then
    m_MapSurface.Lost;
  if m_ObjSurface <> nil then
    m_ObjSurface.Lost;
  if m_MagSurface <> nil then
    m_MagSurface.Lost;
end;

procedure TPlayScene.ClearMissionList(Actor: TActor);
var
  ClientMission: pTClientMission;
begin
  if Actor.m_btRace = 50 then
  begin
    with Actor as TNPCActor do
    begin
      if m_MissionList <> nil then
      begin
        for ClientMission in m_MissionList do
        begin
          ClientMission.NPC := nil;
        end;
        m_MissionList.Clear;
      end;
    end;
  end;
end;

procedure TPlayScene.SetMissionList(Actor: TNPCActor);
var
  ClientMission: pTClientMission;
begin
  with Actor do
  begin
    if m_MissionList <> nil then
    begin
      m_MissionList.Clear;
    end;
    for ClientMission in g_MissionList do
    begin
      if (CompareText(ClientMission.sNPCMapName, g_sMapTitle) = 0) and
      (ClientMission.wNPCCurrX = m_nCurrX) and (ClientMission.wNPCCurrY = m_nCurrY) then
      begin
        if m_MissionList = nil then
          m_MissionList := TList.Create;
        ClientMission.NPC := Actor;
        m_MissionList.Add(ClientMission);
      end;
    end;
  end;
end;

procedure TPlayScene.RefMissionList;
var
  Actor: TActor;
  I: Integer;
begin
  for I := 0 to m_ActorList.Count - 1 do
  begin
    Actor := TActor(m_ActorList.Items[I]);
    if (Actor.m_btRace = 50) then
    begin
      SetMissionList(TNPCActor(Actor));
    end;
  end;
end;

procedure TPlayScene.RefMissionInfo;
var
  Actor: TActor;
  I: Integer;
begin
  if g_MySelf = nil then exit;
  for I := 0 to m_ActorList.Count - 1 do
  begin
    Actor := TActor(m_ActorList.Items[I]);
    if (Actor.m_btRace = 50) then
    begin
      SetMissionInfo(TNPCActor(Actor));
    end;
  end;
end;

procedure TPlayScene.SetMissionInfo(Actor: TNPCActor);
var
  MissionList: TList;
  ClientMission: pTClientMission;
  MissionInfo: pTClientMissionInfo;
  MissionStatus, OldMissionStatus: TNPCMissionStatus;
begin
  if g_MySelf = nil then exit;
  MissionList := Actor.m_MissionList;
  Actor.m_MissionStatus := NPCMS_None;
  if (MissionList <> nil) and (MissionList.Count > 0) then
  begin
    for ClientMission in MissionList do
    begin
      if ClientMission.boHide then Continue;
      if Actor.m_MissionStatus = NPCMS_Complete then break;
      MissionInfo := pTClientMissionInfo(ClientMission.MissionInfo);
      OldMissionStatus := Actor.m_MissionStatus;
      MissionStatus := OldMissionStatus;
      //�Ƿ������������
      if (MissionInfo <> nil) and (not ClientMission.boAccept) then
      begin
        if OldMissionStatus = NPCMS_None then
          OldMissionStatus := NPCMS_Atelic;
        MissionStatus := NPCMS_Complete;
        if (ClientMission.CompleteFlag[0].nFlag <> 0) and
        (GetMissionFlagStatus(ClientMission.CompleteFlag[0].nFlag) <> ClientMission.CompleteFlag[0].btValue) then
          MissionStatus := OldMissionStatus;
        if (MissionStatus = NPCMS_Complete) and (ClientMission.CompleteFlag[1].nFlag <> 0) and
        (GetMissionFlagStatus(ClientMission.CompleteFlag[1].nFlag) <> ClientMission.CompleteFlag[1].btValue) then
          MissionStatus := OldMissionStatus;
        if (MissionStatus = NPCMS_Complete) and (ClientMission.CompleteFlag[2].nFlag <> 0) and
        (GetMissionFlagStatus(ClientMission.CompleteFlag[2].nFlag) <> ClientMission.CompleteFlag[2].btValue) then
          MissionStatus := OldMissionStatus;

        if ((MissionStatus = NPCMS_Complete) and (MissionInfo <> nil) and
        (MissionInfo.nItemCount1 < ClientMission.CompleteItem[0].wItemCount)) then
          MissionStatus := OldMissionStatus;
        if ((MissionStatus = NPCMS_Complete) and (MissionInfo <> nil) and
        (MissionInfo.nItemCount2 < ClientMission.CompleteItem[1].wItemCount)) then
          MissionStatus := OldMissionStatus;
        if ((MissionStatus = NPCMS_Complete) and (MissionInfo <> nil) and
        (MissionInfo.nItemCount3 < ClientMission.CompleteItem[2].wItemCount)) then
          MissionStatus := OldMissionStatus;

        if ((MissionStatus = NPCMS_Complete) and (MissionInfo <> nil) and
        (MissionInfo.MissionInfo.btKillCount1 < ClientMission.btKillCount1)) then
          MissionStatus := OldMissionStatus;
        if ((MissionStatus = NPCMS_Complete) and (MissionInfo <> nil) and
        (MissionInfo.MissionInfo.btKillCount2 < ClientMission.btKillCount2)) then
          MissionStatus := OldMissionStatus;
      end else
        if ClientMission.boAccept and (OldMissionStatus <> NPCMS_Complete) and (OldMissionStatus <> NPCMS_Accept) then
        begin
          MissionStatus := NPCMS_Accept;
          if (ClientMission.AcceptFlag[0].nFlag <> 0) and
          (GetMissionFlagStatus(ClientMission.AcceptFlag[0].nFlag) <> ClientMission.AcceptFlag[0].btValue) then
            MissionStatus := OldMissionStatus;
          if (MissionStatus = NPCMS_Accept) and (ClientMission.AcceptFlag[1].nFlag <> 0) and
          (GetMissionFlagStatus(ClientMission.AcceptFlag[1].nFlag) <> ClientMission.AcceptFlag[1].btValue) then
            MissionStatus := OldMissionStatus;
          if (MissionStatus = NPCMS_Accept) and (ClientMission.AcceptFlag[2].nFlag <> 0) and
          (GetMissionFlagStatus(ClientMission.AcceptFlag[2].nFlag) <> ClientMission.AcceptFlag[2].btValue) then
            MissionStatus := OldMissionStatus;

          if (MissionStatus = NPCMS_Accept) and (ClientMission.btJob <> 99) and (g_MySelf.m_btJob <> ClientMission.btJob) then
            MissionStatus := OldMissionStatus;

          if (MissionStatus = NPCMS_Accept) and (ClientMission.btSex <> 99) and (g_MySelf.m_btSex <> ClientMission.btSex) then
            MissionStatus := OldMissionStatus;

          if (MissionStatus = NPCMS_Accept) and
          ((g_MySelf.m_Abil.Level < ClientMission.nMinLevel) or (g_MySelf.m_Abil.Level > ClientMission.nMaxLevel)) then
            MissionStatus := OldMissionStatus;

          if (MissionStatus = NPCMS_Accept) and (ClientMission.btCycCount > 0) and
          (ClientMission.btCycVar in [Low(g_MissionArithmometer)..High(g_MissionArithmometer)]) and
          (g_MissionArithmometer[ClientMission.btCycVar] >= ClientMission.btCycCount) then
            MissionStatus := OldMissionStatus;
        end;
      Actor.m_MissionStatus := MissionStatus;
    end;
  end;
end;

function TPlayScene.NewActor(chrid: Integer;
                                cx: Word; //x
                                cy: Word; //y
                                cdir: Word;
                                cfeature: Integer; //race, hair, dress, weapon
                                cstate: Integer;
                                btSIdx, btWuXin: Integer): TActor;
var
  i: Integer;
  Actor: TActor;
begin
  Result := nil; //jacky
  //��������ɫ�Ƿ��Ѿ����ڽ�ɫ�б��У������ڣ����ô���
  for i := 0 to m_ActorList.count - 1 do
    if TActor(m_ActorList[i]).m_nRecogId = chrid then
    begin
      Result := TActor(m_ActorList[i]);
      Exit; //�̹� ����
    end;
  if IsChangingFace(chrid) then
    Exit; //������...
//����Race������Ӧ�Ľ�ɫ����
  case RACEfeature(cfeature) of //m_btRaceImg
    0: Actor := THumActor.Create; //����
    9: Actor := TSoccerBall.Create; //����
    13: Actor := TKillingHerb.Create; //ʳ�˻�
    14: Actor := TSkeletonOma.Create; //����
    15: Actor := TDualAxeOma.Create; //��������

    16: Actor := TGasKuDeGi.Create; //����

    17: Actor := TCatMon.Create; //��צè
    18: Actor := THuSuABi.Create; //������
    19: Actor := TCatMon.Create; //����սʿ

    20: Actor := TFireCowFaceMon.Create; //��������
    21: Actor := TCowFaceKing.Create; //�������
    22: Actor := TDualAxeOma.Create; //�ڰ�սʿ
    23: Actor := TWhiteSkeleton.Create; //��������
    24: Actor := TSuperiorGuard.Create; //������ʿ
    25: Actor := TBoxSpider.Create;
    26: Actor := TGrassSpider.Create;
    30: Actor := TCatMon.Create; //������
    31: Actor := TCatMon.Create; //��Ӭ
    32: Actor := TScorpionMon.Create; //Ы��

    33: Actor := TCentipedeKingMon.Create; //������
    34: Actor := TBigHeartMon.Create; //���¶�ħ
    35: Actor := TSpiderHouseMon.Create; //��Ӱ֩��
    36: Actor := TExplosionSpider.Create; //��ħ֩��
    37: Actor := TFlyingSpider.Create; //

    40: Actor := TZombiLighting.Create; //��ʬ1
    41: Actor := TZombiDigOut.Create; //��ʬ2
    42: Actor := TZombiZilkin.Create; //��ʬ3

    43: Actor := TBeeQueen.Create; //��Ӭ��
    44: Actor := TMoonMon.Create;
    45: Actor := TArcherMon.Create; //������
    47: Actor := TSculptureMon.Create; //�������  ��������
    48: Actor := TSculptureMon.Create; //
    49: Actor := TSculptureKingMon.Create; //�������

    50:
    begin
      case APPRfeature(cfeature) of
        52, 78: Actor := TSnowmanNpcActor.Create; //ѩ��
        53, 77, 80, 81, 92, 96: Actor := TFixedNpcActor.Create;
        54..64, 74, 76, 146: Actor := TBoxNpcActor.Create;
        67..69, 79: Actor := THeroNpcActor.Create;
        70: Actor := TDynamicBoxNpcActor.Create;
        75: Actor := TTavernNpcActor.Create;
        125: Actor := TQuiescenceNpcActor.Create;
        83, 88..90, 94, 126..139, 141..143, 147..152, 162, 164..166, 169..175, 177, 178, 180: Actor := TBaseNpcActor.Create;
        156: Actor := TStatuaryNpcActor.Create;
        140, 144: Actor := TTreeNpcActor.Create;
        145: Actor := TDynamicTreeNpcActor.Create;
        153: Actor := TFlyDynamicNpcActor.Create;
        154..155: Actor := TMachineryNpcActor.Create;
        157..159, 161, 163, 176, 179: Actor := T2NpcActor.Create;
        82, 160: Actor := TDynamicTree2NpcActor.Create;
        167, 168: Actor := TDynamicTreeNpcActor.Create;
      else Actor := TNpcActor.Create;
      end;
    end;

    52: Actor := TGasKuDeGi.Create; //Ш��
    53: Actor := TGasKuDeGi.Create; //���
    54: Actor := TSmallElfMonster.Create; //����
    55: Actor := TWarriorElfMonster.Create; //����1

    60: Actor := TElectronicScolpionMon.Create;
    61: Actor := TBossPigMon.Create;
    62: Actor := TKingOfSculpureKingMon.Create;
    63: Actor := TSkeletonKingMon.Create;
    64: Actor := TGasKuDeGi.Create;
    65: Actor := TSamuraiMon.Create;
    66: Actor := TSkeletonSoldierMon.Create;
    67: Actor := TSkeletonSoldierMon.Create;
    68: Actor := TSkeletonSoldierMon.Create;
    69: Actor := TSkeletonArcherMon.Create;
    70: Actor := TBanyaGuardMon.Create; //ţħ��ʦ
    71: Actor := TBanyaGuardMon.Create; //ţħ��˾
    72: Actor := TBanyaGuardMon.Create; //��֮ţħ��
    73: Actor := TPBOMA1Mon.Create;
    74: Actor := TCatMon.Create;
    75: Actor := TStoneMonster.Create;
    76: Actor := TSuperiorGuard.Create;
    77: Actor := TStoneMonster.Create;
    78: Actor := TMolongKindSpider.Create; //ħ������
    79: Actor := TPBOMA6Mon.Create;
    80: Actor := TMineMon.Create;
    81: Actor := TAngel.Create;
    83: Actor := TFireDragon.Create;
    84: Actor := TDragonStatue.Create;
    85: Actor := TDoubleATKSpider.Create; //��׼˫�ع�������
    86: Actor := TMagicMonSpider.Create;
    87: Actor := T87KindSpider.Create;
    90: Actor := TFiredrakeKingSpider.Create; //��
    91: Actor := TXueyuKindSpider.Create; //ѩ��ħ��
    92: Actor := TM2N4XKingSpider.Create;
      // 93: Actor := TM3N4XKingSpider.Create;
    98: Actor := TWallStructure.Create; //LeftWall
    99: Actor := TCastleDoor.Create; //MainDoor
    100: Actor := TDualEffectSpider.Create;
    101: Actor := TPillarSpider.Create;
  else
    Actor := TActor.Create;
  end;

  with Actor do
  begin
    m_nRecogId := chrid;
    m_nCurrX := cx;
    m_nCurrY := cy;
    m_nRx := m_nCurrX;
    m_nRy := m_nCurrY;
    m_btDir := cdir;
    m_nFeature := cfeature;
    m_btRace := RACEfeature(cfeature); //����
    m_btHair := HAIRfeature(cfeature); //ͷ��
    m_btDress := DRESSfeature(cfeature); //��װ
    m_btWeapon := WEAPONfeature(cfeature); //����
    m_btRaceServer := 0;
    if m_btRace <> 0 then
    begin
      m_btRaceServer := m_btWeapon;
      m_btWeapon := 0;
    end;

    m_wAppearance := APPRfeature(cfeature); //��ò
    m_WMImages := GetMonImg(m_wAppearance);
    //      Horse:=Horsefeature(cfeature);
    //      Effect:=Effectfeature(cfeature);
    m_Action := nil;
    if m_btRace = 0 then
    begin
//����
      m_btSex := m_btDress mod 2; //0:�� 1:Ů
    end else
      if m_btRace = 50 then
      begin
        SetMissionList(TNPCActor(Actor));
        SetMissionInfo(TNPCActor(Actor));
        m_btSex := 0;
        if m_wAppearance in [33..50, 53..64, 70, 74, 76..78, 80..82, 92, 96, 140, 145, 146, 154..161, 163, 167, 168, 176, 179] then
          Actor.m_boShowHealthBar := False;
      end
      else begin
        m_btSex := 0;
      end;
    if btSIdx <> -1 then m_btStrengthenIdx := btSIdx;
    if (btWuXin in [1..5]) then m_btWuXin := btWuXin;
    m_nState := cstate;
    //m_SayingArr[0] := '';
    if m_btRace = 0 then
    begin
      SetActorGroup(Actor);
    end;
  end;
  m_ActorList.Add(Actor);
  Result := Actor;
end;

procedure TPlayScene.SetOperateHint(sHint: string);
{$IF Var_Interface =  Var_Default}
var
  sTextWidth: Integer;
  sStr: string;
{$IFEND}
begin
{$IF Var_Interface =  Var_Default}
  if m_OperateHintSurface <> nil then
  begin
    m_OperateHintSurface.Clear;
    sTextWidth := g_DXCanvas.TextWidth(sHint);
    sStr := GetValidStr3(sHint, sHint, ['\']);
    if sStr <> '' then
    begin
      m_OperateHintSurface.TextOutEx(OPERATEHINTWIDTH div 2 - g_DXCanvas.TextWidth(sHint) div 2, 2, sHint, $66CCFF);
      m_OperateHintSurface.TextOutEx(OPERATEHINTWIDTH div 2 - g_DXCanvas.TextWidth(sStr) div 2, 18, sStr, $66CCFF);
    end else begin
      m_OperateHintSurface.TextOutEx(OPERATEHINTWIDTH div 2 - sTextWidth div 2, OPERATEHINTHEIGHT div 2 - 7, sHint, $66CCFF);
    end;
  end;
{$IFEND}
end;
//��ɫ�������Ѹý�ɫɾ����Ȼ�����·ŵ���ɫ�б��еĵ�һ��δ������ɫǰ��
procedure TPlayScene.ActorDied(Actor: TObject);
//var
//  i: Integer;
    // flag: Boolean;
begin
  TActor(Actor).m_btHorse := 0;
  {for i := 0 to m_ActorList.count - 1 do
    if m_ActorList[i] = Actor then begin
      m_ActorList.Delete(i);
      break;
    end;
  flag := FALSE;
  for i := 0 to m_ActorList.count - 1 do
    if not TActor(m_ActorList[i]).m_boDeath then begin
      m_ActorList.Insert(i, Actor);
      flag := True;
      break;
    end;
  if not flag then
    m_ActorList.Add(Actor); }
end;

//���ý�ɫ����ʾ�㼶����ɫ�б��˳��
//��Level=0ʱ������ָ���Ľ�ɫ���ڽ�ɫ�б����ǰ��
procedure TPlayScene.SetActorDrawLevel(Actor: TObject; Level: Integer);
var
  i: Integer;
begin
  if Level = 0 then
  begin
    //�� ó���� �׸����� ��
    for i := 0 to m_ActorList.count - 1 do
      if m_ActorList[i] = Actor then
      begin
        m_ActorList.Delete(i);
        m_ActorList.Insert(0, Actor);
        break;
      end;
  end;
end;

procedure TPlayScene.SetMembersGroup(GroupMember: pTGroupMember; boGroup: Boolean);
var
  i: Integer;
  Actor: TActor;
begin
  for i := 0 to m_ActorList.count - 1 do
  begin
    Actor := m_ActorList.Items[i];
    if GroupMember.ClientGroup.UserID = Actor.m_nRecogId then
    begin
      if boGroup then
      begin
        Actor.m_Group := GroupMember;
        GroupMember.isScreen := Actor;
        Actor.m_Abil.MaxHP := GroupMember.ClientGroup.MaxHP;
        Actor.m_Abil.HP := GroupMember.ClientGroup.HP;
      end
      else begin
        Actor.m_Group := nil;
        GroupMember.isScreen := nil;
      end;
      Break;
    end;
  end;
end;
//������н�ɫ
procedure TPlayScene.SetMembersGroup(GroupMembers: TList);
var
  i, ii: Integer;
  Actor: TActor;
  GroupMember: pTGroupMember;
begin
  for i := 0 to m_ActorList.count - 1 do
  begin
    Actor := m_ActorList.Items[i];
    Actor.m_Group := nil;
    for ii := 0 to GroupMembers.Count - 1 do
    begin
      GroupMember := GroupMembers.Items[ii];
      if GroupMember.ClientGroup.UserID = Actor.m_nRecogId then
      begin
        Actor.m_Group := GroupMember;
        GroupMember.isScreen := Actor;
        Actor.m_Abil.MaxHP := GroupMember.ClientGroup.MaxHP;
        Actor.m_Abil.HP := GroupMember.ClientGroup.HP;
        //Actor.
        Break;
      end;
    end;
  end;
end;

procedure TPlayScene.SetActorGroup(Actor: TActor);
var
  ii: Integer;
  GroupMember: pTGroupMember;
begin
  if g_GroupMembers.Count <= 0 then
    exit;
  for ii := 0 to g_GroupMembers.Count - 1 do
  begin
    GroupMember := g_GroupMembers.Items[ii];
    if GroupMember.ClientGroup.UserID = Actor.m_nRecogId then
    begin
      GroupMember.isScreen := Actor;
      Actor.m_Group := GroupMember;
      Actor.m_Abil.MaxHP := GroupMember.ClientGroup.MaxHP;
      Actor.m_Abil.HP := GroupMember.ClientGroup.HP;
      Break;
    end;
  end;
end;

procedure TPlayScene.ClearGroup();
var
  i: Integer;
begin
  for i := 0 to m_ActorList.count - 1 do
  begin
    TActor(m_ActorList[i]).m_Group := nil;
  end;
end;
//���ݽ�ɫIDɾ��һ����ɫ
function TPlayScene.DeleteActor(id: Integer): TActor;
var
  i: Integer;
begin
  Result := nil;
  i := 0;
  while True do
  begin
    if i >= m_ActorList.count then
      break;
    if TActor(m_ActorList[i]).m_nRecogId = id then
    begin
      if g_TargetCret = TActor(m_ActorList[i]) then
        g_TargetCret := nil;
      if g_FocusCret = TActor(m_ActorList[i]) then
        g_FocusCret := nil;
      if g_MagicTarget = TActor(m_ActorList[i]) then
        g_MagicTarget := nil;
      if g_MagicLockTarget = TActor(m_ActorList[i]) then
        g_MagicLockTarget := nil;
      if g_NPCTarget = TActor(m_ActorList[i]) then
        g_NPCTarget := nil;
      if TActor(m_ActorList[i]).m_Group <> nil then
      begin
        TActor(m_ActorList[i]).m_Group.isScreen := nil;
        TActor(m_ActorList[i]).m_Group := nil;
      end;
      ClearMissionList(TActor(m_ActorList[i]));
      TActor(m_ActorList[i]).m_dwDeleteTime := GetTickCount;
      g_FreeActorList.Add(m_ActorList[i]);
      //TActor(ActorList[i]).Free;
      m_ActorList.Delete(i);
    end
    else
      Inc(i);
  end;
end;

procedure TPlayScene.SetEditChar(sMsg: string);
begin
  if sMsg <> '' then
  begin
    FrmDlg.DEditChat.Visible := True;
    FrmDlg.DEditChat.SetFocus;
    FrmDlg.DEditChat.Text := '/' + sMsg + ' ';
    //FrmDlg.DEditChatChange(FrmDlg.DEditChat);
  end;
end;
//�ӽ�ɫ�б���ɾ��һ����ɫ
procedure TPlayScene.DelActor(Actor: TObject);
var
  i: Integer;
begin
  for i := 0 to m_ActorList.count - 1 do
    if m_ActorList[i] = Actor then
    begin
      if TActor(m_ActorList[i]).m_Group <> nil then
      begin
        TActor(m_ActorList[i]).m_Group.isScreen := nil;
        TActor(m_ActorList[i]).m_Group := nil;
      end;
      ClearMissionList(TActor(m_ActorList[i]));
      TActor(m_ActorList[i]).m_dwDeleteTime := GetTickCount;
      g_FreeActorList.Add(m_ActorList[i]);
      m_ActorList.Delete(i);
      break;
    end;
end;

//��������(X,Y)���Ľ�ɫ�������ɫ�Ѿ��������Ҳ�������
function TPlayScene.ButchAnimal(X, Y: Integer): TActor;
var
  i: Integer;
  a: TActor;
begin
  Result := nil;
  for i := 0 to m_ActorList.count - 1 do
  begin
    a := TActor(m_ActorList[i]);
    if a.m_boDeath and (a.m_btRace <> 0) then
    begin
      //���� ��ü
      if (abs(a.m_nCurrX - X) <= 1) and (abs(a.m_nCurrY - Y) <= 1) then
      begin
        Result := a;
        break;
      end;
    end;
  end;
end;

{------------------------- Msg -------------------------}

procedure TPlayScene.SendMsg(ident, chrid, X, Y, cdir, Feature, State: Integer; str: string; btSIdx, btWuXin: Integer);
var
  Actor: TActor;
begin
  case ident of
    SM_TEST:
    begin
      Actor := NewActor(111, 254 {x}, 214 {y}, 0, 0, 0);
      g_MySelf := THumActor(Actor);
      Map.LoadMap('0', g_MySelf.m_nCurrX, g_MySelf.m_nCurrY);
    end;
    SM_CHANGEMAP,
    SM_NEWMAP:
    begin
      g_boAutoMoveing := False;
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      g_nMiniMapPath := nil;

      Map.LoadMap(str, X, Y);
      //DarkLevel := cdir;
      FrmDlg.DMaxMiniMap.Visible := False;
      g_nMiniMapIndex := cdir - 1;
      g_nMiniMapOldX := -1;
{$IF Var_Interface = Var_Mir2}
      FrmDlg.SetMiniMapSize(g_nViewMinMapLv);
{$IFEND}
      if (ident = SM_NEWMAP) and (g_MySelf <> nil) then
      begin
        g_MySelf.m_nCurrX := X;
        g_MySelf.m_nCurrY := Y;
        g_MySelf.m_nRx := X;
        g_MySelf.m_nRy := Y;
        DelActor(g_MySelf);
      end;
      //g_LegendMapName := Map.m_sFileName;
      //g_LegendMap.LoadMap();
    end;
    SM_LOGON:
    begin
      Actor := FindActor(chrid);
      if Actor = nil then
      begin
        Actor := NewActor(chrid, X, Y, cdir, Feature, State);
        //Actor.m_btWuXin := Hibyte(cdir);
        //cdir := Lobyte(cdir);
        Actor.SendMsg(SM_TURN, X, Y, cdir, Feature, State, '', 0); //ת��
      end;
      if g_MySelf <> nil then
      begin
        g_MySelf := nil;
      end;
      g_MySelf := THumActor(Actor);
    end;
    SM_HIDE:
    begin
      Actor := FindActor(chrid);
      if Actor <> nil then
      begin
        if Actor.m_boDelActionAfterFinished then
        begin
          //������ ������� �ִϸ��̼��� ������ �ڵ����� �����.
          Exit;
        end;
        if Actor.m_nWaitForRecogId <> 0 then
        begin
          //������.. ������ ������ �ڵ����� �����
          Exit;
        end;
      end;
      DeleteActor(chrid);
    end;
  else
  begin
    Actor := FindActor(chrid);
    if (ident = SM_TURN) or (ident = SM_RUN) or (ident = SM_LEAP) or (ident = SM_HORSERUN) or (ident = SM_WALK) or
    (ident = SM_BACKSTEP) or (ident = SM_MAGICMOVE) or (ident = SM_MAGICFIR) or
    (ident = SM_DEATH) or (ident = SM_SKELETON) or
    (ident = SM_DIGUP) or (ident = SM_ALIVE) then
    begin
      if Actor = nil then
        Actor := NewActor(chrid, X, Y, cdir, Feature, State);
      if Actor <> nil then
      begin
        //if Hibyte(cdir) in [1..5] then
        //Actor.m_btWuXin := Hibyte(cdir);
        //cdir := Lobyte(cdir);
        if ident = SM_SKELETON then
        begin
          Actor.m_boDeath := True;
          Actor.m_boSkeleton := True;
        end;
      end;
    end;
    if Actor = nil then Exit;
    if btSIdx <> -1 then Actor.m_btStrengthenIdx := btSIdx;
    if (btWuXin in [1..5]) then Actor.m_btWuXin := btWuXin;
    case ident of
      SM_FEATURECHANGED:
      begin
        Actor.m_nFeature := Feature;
        Actor.m_nFeatureEx := State;
        Actor.FeatureChanged;
      end;
      SM_CHARSTATUSCHANGED:
      begin
        Actor.m_nState := Feature;
        Actor.m_nHitSpeed := State;
      end;
    else
    begin
      if ident = SM_TURN then
      begin
        Actor.SetUsername(str, -1);
        //Actor.m_sUserName := str;
      end;
      Actor.SendMsg(ident, X, Y, cdir, Feature, State, '', 0);
    end;
    end;
  end;
  end;
end;

end.

