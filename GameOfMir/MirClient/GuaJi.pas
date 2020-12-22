unit GuaJi;

interface
uses
  Windows, Classes, SysUtils, Graphics, Controls, HUtil32, Grobal2, FindMapPath, Actor;
type
  TMapWalkXY = record
    boWalk: Boolean;
    nMonCount: Integer;
    nX: Integer;
    nY: Integer;
  end;
  pTMapWalkXY = ^TMapWalkXY;

  TGuaJi = class
    m_TargetCret: TActor;
    m_nTargetX: Integer; //目标座标
    m_nTargetY: Integer; //目标座标
  private
    FPath: TPath;
    FStarted: Boolean;
    FRunTick: LongWord;
    FAttackTick: LongWord;
    function CanRunEx(sx, sY, ex, ey: Integer; Flag: Boolean): Boolean;
    function CanWalkEx(nTargetX, nTargetY: Integer; Flag: Boolean): Boolean;
    function CanWalk(nTargetX, nTargetY: Integer; Flag: Boolean): Boolean;
    procedure SetStarted(Value: Boolean);
    procedure Avoid;
    function UseMagic(AFlag: Boolean): Boolean;
    function GetRangeTargetCount(nX, nY, nRange: Integer): Integer;
    procedure SearchTarget;
    procedure GetAutoWalkXY(var nTargetX, nTargetY: Integer);
    function GetNextPosition(sX, sY, nDir, nFlag: Integer; var snx: Integer; var sny: Integer): Boolean;
    function IsAttackTarget(const AActor: TActor): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    procedure Stop;
    procedure Run;
    property Started: Boolean read FStarted write SetStarted;
  end;
implementation
uses MShare, FState3, ClMain, ClFunc;

constructor TGuaJi.Create;
begin
  inherited;
  FStarted := False;
  FPath := nil;
  m_TargetCret := nil;
  m_nTargetX := -1; //目标座标
  m_nTargetY := -1; //目标座标
  FRunTick := GetTickCount;
  FAttackTick := GetTickCount;
end;

destructor TGuaJi.Destroy;
begin
  inherited;
end;

procedure TGuaJi.Start;
begin
  if (g_MySelf <> nil) and (not g_MySelf.m_boDeath) and (not FStarted) then
  begin
    if not UseMagic(True) then
    begin
      DScreen.AddSysMsg('[请先在游戏设置的技能面版设置好挂机技能]', clYellow);
      exit;
    end;
    FStarted := True;
    FRunTick := GetTickCount;
    DScreen.AddSysMsg('[开始自动练级(Ctrl + L)]', clYellow);
  end;
end;

procedure TGuaJi.Stop;
begin
  if FStarted then
  begin
    FStarted := False;
    FPath := nil;
    DScreen.AddSysMsg('[停止自动练级(Ctrl + L)]', clYellow);
  end;
end;

procedure TGuaJi.SetStarted(Value: Boolean);
begin
  if FStarted <> Value then
  begin
    if FStarted then
      Stop
    else
      Start;
  end;
end;

function TGuaJi.GetNextPosition(sX, sY, nDir, nFlag: Integer; var snx: Integer; var sny: Integer): Boolean;
begin
  snx := sX;
  sny := sY;
  case nDir of
    DR_UP: if sny > nFlag - 1 then
        Dec(sny, nFlag);
    DR_DOWN: if sny < (g_LegendMap.MapHeader.wHeight - nFlag) then
        Inc(sny, nFlag);
    DR_LEFT: if snx > nFlag - 1 then
        Dec(snx, nFlag);
    DR_RIGHT: if snx < (g_LegendMap.MapHeader.wWidth - nFlag) then
        Inc(snx, nFlag);
    DR_UPLEFT:
      begin
        if (snx > nFlag - 1) and (sny > nFlag - 1) then
        begin
          Dec(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_UPRIGHT:
      begin
        if (snx > nFlag - 1) and (sny < (g_LegendMap.MapHeader.wHeight - nFlag)) then
        begin
          Inc(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_DOWNLEFT:
      begin
        if (snx < (g_LegendMap.MapHeader.wWidth - nFlag)) and (sny > nFlag - 1) then
        begin
          Dec(snx, nFlag);
          Inc(sny, nFlag);
        end;
      end;
    DR_DOWNRIGHT:
      begin
        if (snx < (g_LegendMap.MapHeader.wWidth - nFlag)) and (sny < (g_LegendMap.MapHeader.wHeight - nFlag)) then
        begin
          Inc(snx, nFlag);
          Inc(sny, nFlag);
        end;
      end;
  end;
  if (snx = sX) and (sny = sY) then
    Result := False
  else
    Result := True;
end;

function TGuaJi.CanWalkEx(nTargetX, nTargetY: Integer; Flag: Boolean): Boolean;
begin
  Result := Map.CanMove(nTargetX, nTargetY);
  if Flag then
    Result := not PlayScene.CrashManEx(nTargetX, nTargetY);
end;

function TGuaJi.CanRunEx(sx, sY, ex, ey: Integer; Flag: Boolean): Boolean;
var
  ndir, rx, ry: Integer;
begin
  ndir := GetNextDirection(sx, sY, ex, ey);
  rx := sx;
  ry := sY;
  GetNextPosXY(ndir, rx, ry);

  if Map.CanMove(rx, ry) and Map.CanMove(ex, ey) then
    Result := True
  else
    Result := False;

  if Flag then
  begin
    if CanWalkEx(rx, ry, Flag) and CanWalkEx(ex, ey, Flag) then
      Result := True
    else
      Result := False;
  end;
end;

function TGuaJi.CanWalk(nTargetX, nTargetY: Integer; Flag: Boolean): Boolean;
var
  nDir: Integer;
  nX, nY: Integer;
  nX1, nY1: Integer;
begin
  Result := True;
  nDir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nTargetX, nTargetY);
  nX := g_MySelf.m_nCurrX;
  nY := g_MySelf.m_nCurrY;
  nX1 := nTargetX;
  nY1 := nTargetY;
  if (abs(nX - nX1) >= 2) or (abs(nY - nY1) >= 2) then
  begin
    while True do
    begin
      if nDir <> GetNextDirection(nX, nY, nTargetX, nTargetY) then
        break;
      if (abs(nX - nX1) >= 2) or (abs(nY - nY1) >= 2) then
      begin
        if GetNextPosition(nX, nY, nDir, 2, nX1, nY1) then
        begin
          if CanRunEx(nX, nY, nX1, nY1, Flag) then
          begin
            nX := nX1;
            nY := nY1;
            nX1 := nTargetX;
            nY1 := nTargetY;
          end
          else
          begin
            Result := False;
            break;
          end;
        end
        else
        begin
          Result := False;
          break;
        end;
      end
      else
      begin
        if GetNextPosition(nX, nY, nDir, 1, nX1, nY1) then
        begin
          if CanWalkEx(nX1, nY1, Flag) then
          begin
            nX := nX1;
            nY := nY1;
            nX1 := nTargetX;
            nY1 := nTargetY;
          end
          else
          begin
            Result := False;
            break;
          end;
        end
        else
        begin
          Result := False;
          break;
        end;
      end;
    end;
  end
  else
  begin
    Result := CanWalkEx(nX1, nY1, Flag);
  end;
end;

procedure TGuaJi.GetAutoWalkXY(var nTargetX, nTargetY: Integer);
  function GetRandXY(var nX: Integer; var nY: Integer): Boolean;
  begin
    Result := False;
    if (abs(g_MySelf.m_nCurrX - nX) >= 2) or (abs(g_MySelf.m_nCurrY - nY) >= 2) then
    begin
      if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY) then
        Result := (nX <> g_MySelf.m_nCurrX) or (nY <> g_MySelf.m_nCurrY);
    end
    else
    begin
      if PlayScene.CanWalkEx(nX, nY) then
        Result := (nX <> g_MySelf.m_nCurrX) or (nY <> g_MySelf.m_nCurrY);
    end;
  end;

  function GetNextDir(btDir: Byte): Byte;
  begin
    Result := DR_UP;
    case btDir of
      DR_UP: Result := DR_UPRIGHT;
      DR_UPRIGHT: Result := DR_RIGHT;
      DR_RIGHT: Result := DR_DOWNRIGHT;
      DR_DOWNRIGHT: Result := DR_DOWN;
      DR_DOWN: Result := DR_DOWNLEFT;
      DR_DOWNLEFT: Result := DR_LEFT;
      DR_LEFT: Result := DR_UPLEFT;
      DR_UPLEFT: Result := DR_UP;
    end;
  end;
var
  nStep: Integer;
  btDir: Byte;
  nCount: Integer;
begin
  nTargetX := g_MySelf.m_nCurrX;
  nTargetY := g_MySelf.m_nCurrY;

  for nStep := 2 downto 1 do
  begin
    if GetNextPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_MySelf.m_btDir, nStep, nTargetX, nTargetY) then
    begin
      if GetRandXY(nTargetX, nTargetY) then
      begin
        {
        DScreen.AddSayMsg('GetAutoWalkXY:' + IntToStr(nStep) + ' nX' + IntToStr(g_MySelf.m_nCurrX) + ' nY' + IntToStr(g_MySelf.m_nCurrY) +
           ' nTargetX' + IntToStr(nTargetX) + ' nTargetY' + IntToStr(nTargetY), clYellow, clRed, True, us_Sys);
        }
        Exit;
      end;
    end;
  end;

  nCount := 0;
  btDir := g_MySelf.m_btDir;
  while True do
  begin
    Inc(nCount);
    btDir := GetNextDir(btDir);
    for nStep := 2 downto 1 do
    begin
      if GetNextPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, btDir, nStep, nTargetX, nTargetY) then
      begin
        if GetRandXY(nTargetX, nTargetY) then
        begin
          Exit;
        end;
      end;
    end;
    if (nCount >= 8) then
      Break;
  end;
end;

function TGuaJi.GetRangeTargetCount(nX, nY, nRange: Integer): Integer;
var
  Actor: TActor;
  I, nC, n10: Integer;
begin
  Result := 0;
  n10 := nRange;
  for I := 0 to PlayScene.m_ActorList.Count - 1 do
  begin
    Actor := TActor(PlayScene.m_ActorList[I]);
    if Actor <> nil then
    begin
      if IsAttackTarget(Actor) then
      begin
        nC := abs(nX - Actor.m_nCurrX) + abs(nY - Actor.m_nCurrY);
        if nC <= n10 then
        begin
          Inc(Result);
        end;
      end;
    end;
  end;
end;

function TGuaJi.IsAttackTarget(const AActor: TActor): Boolean;
begin
  Result := (not AActor.m_boDeath);
  Result := Result and (AActor <> g_MySelf);
  Result := Result and (AActor.m_btRace > RCC_USERHUMAN);
  Result := Result and (AActor.m_btRace <> RCC_GUARD);
  Result := Result and (AActor.m_btRace <> RC_ARCHERGUARD);
  Result := Result and (AActor.m_btRace <> RCC_MERCHANT);
  Result := Result and (AActor.m_btRace <> 25);
  Result := Result and (AActor.m_btRace <> 26);
  Result := Result and (Pos('(', AActor.m_UserName) = 0);
end;

procedure TGuaJi.SearchTarget;
var
  Actor, Actor18: TActor;
  I, nC, n10: Integer;
  tdir, dx, dy: Integer;
  boResult: Boolean;
begin
  //if IsMasterRange(m_nCurrX, m_nCurrY, 8) and (m_TargetCret = nil) then begin //和主人同一屏幕内允许自动搜怪
  Actor18 := nil;
  n10 := 9999;
  with PlayScene do
  begin
    for I := 0 to m_ActorList.Count - 1 do
    begin
      Actor := TActor(m_ActorList[I]);
      boResult := Actor.m_boDeath;
      boResult := boResult or (not Actor.m_boVisible);
      boResult := boResult or (not Actor.m_boHoldPlace);
      boResult := boResult or (abs(Actor.m_nCurrX - g_MySelf.m_nCurrX) > 7);
      boResult := boResult or (abs(Actor.m_nCurrY - g_MySelf.m_nCurrY) > 7);
      if boResult then
        Continue;
      tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, Actor.m_nCurrX, Actor.m_nCurrY);
      GetBackPosition(Actor.m_nCurrX, Actor.m_nCurrY, tdir, dx, dy);
      boResult := IsAttackTarget(Actor);
      boResult := boResult and Self.CanWalk(dx, dy, not UseMagic(False));
      boResult := boResult or ((dx = g_MySelf.m_nCurrX) and (dy = g_MySelf.m_nCurrY));
      if boResult then
      begin
        nC := abs(g_MySelf.m_nCurrX - Actor.m_nCurrX) + abs(g_MySelf.m_nCurrY - Actor.m_nCurrY);
        if nC < n10 then
        begin
          n10 := nC;
          Actor18 := Actor;
        end;
      end;
    end;
  end;
  if Actor18 <> nil then
    m_TargetCret := Actor18;
  //if m_TargetCret <> nil then
  //  DScreen.AddSayMsg(Format('m_TargetCret: %s m_btRace: %d X: %d Y: %d', [m_TargetCret.m_UserName, m_TargetCret.m_btRace, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY]), clYellow, clRed, True, us_Sys);
end;

procedure TGuaJi.Avoid;
var
  n10, I: Integer;
  nX, nY: Integer;
  RunCount: array[0..7] of TMapWalkXY;
  WalkCount: array[0..7] of TMapWalkXY;
  MapWalkXY: pTMapWalkXY;
begin
  FillChar(RunCount, SizeOf(RunCount), 0);
  for n10 := 0 to 7 do
  begin
    RunCount[n10].boWalk := False;
    RunCount[n10].nMonCount := 0;
  end;
  for n10 := 0 to 7 do
  begin
    if GetNextPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, n10, 2, nX, nY) then
    begin
      if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY) then
      begin
        RunCount[n10].boWalk := True;
        RunCount[n10].nMonCount := GetRangeTargetCount(nX, nY, 2);
        RunCount[n10].nX := nX;
        RunCount[n10].nY := nY;
      end;
    end;
  end;

  MapWalkXY := nil;
  n10 := 9999;
  for I := 0 to 7 do
  begin
    if RunCount[I].boWalk then
    begin
      if RunCount[I].nMonCount < n10 then
      begin
        n10 := RunCount[I].nMonCount;
        MapWalkXY := @RunCount[I];
      end;
    end;
  end;

  if MapWalkXY <> nil then
  begin
    g_ChrAction := caRun;
    g_nTargetX := MapWalkXY.nX;
    g_nTargetY := MapWalkXY.nY;
    Exit;
  end;

  //==============================================================================

  FillChar(WalkCount, SizeOf(WalkCount), 0);

  for n10 := 0 to 7 do
  begin
    RunCount[n10].boWalk := False;
    RunCount[n10].nMonCount := 0;
  end;

  for n10 := 0 to 7 do
  begin
    if GetNextPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, n10, 1, nX, nY) then
    begin
      if PlayScene.CanWalkEx(nX, nY) then
      begin
        WalkCount[n10].boWalk := True;
        WalkCount[n10].nMonCount := GetRangeTargetCount(nX, nY, 2);
        WalkCount[n10].nX := nX;
        WalkCount[n10].nY := nY;
      end;
    end;
  end;

  MapWalkXY := nil;
  n10 := 9999;
  for I := 0 to 7 do
  begin
    if WalkCount[I].boWalk then
    begin
      if WalkCount[I].nMonCount < n10 then
      begin
        n10 := WalkCount[I].nMonCount;
        MapWalkXY := @WalkCount[I];
      end;
    end;
  end;

  if MapWalkXY <> nil then
  begin
    g_ChrAction := caWalk;
    g_nTargetX := MapWalkXY.nX;
    g_nTargetY := MapWalkXY.nY;
  end;
end;

function TGuaJi.UseMagic(AFlag: Boolean): Boolean;
var
  nMagicID: Integer;
begin
  Result := AFlag;
  nMagicID := -1;
  if g_MySelf.m_btJob > 0 then
  begin
    if (FrmDlg3.DDAPMagicList.ItemIndex >= 0) and (FrmDlg3.DDAPMagicList.ItemIndex < FrmDlg3.DDAPMagicList.Item.Count) then
      nMagicID := Integer(FrmDlg3.DDAPMagicList.Item.Objects[FrmDlg3.DDAPMagicList.ItemIndex]);
    Result := (nMagicID > 0) and (nMagicID < SKILL_MAX);
  end;
end;

procedure TGuaJi.Run;
var
  nMagicID: Integer;
  nTargetX, nTargetY, tdir, dx, dy: Integer;
begin
  if FStarted then
  begin
    if g_MySelf = nil then
      Stop;

    if (g_MySelf <> nil) and g_MySelf.m_boDeath then
      Stop;
  end;

  if FStarted and (GetTickCount - FRunTick > 200) then
  begin
    FRunTick := GetTickCount;
    if not PlayScene.IsValidActor(m_TargetCret) then
      m_TargetCret := nil;
    if (m_TargetCret <> nil) and (not IsAttackTarget(m_TargetCret)) then
      m_TargetCret := nil;
    if m_TargetCret = nil then
      SearchTarget;

    if m_TargetCret <> nil then
    begin
      nMagicID := -1;
      if g_MySelf.m_btJob > 0 then
      begin
        if {(GetRangeTargetCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 4) > 1) and }(FrmDlg3.DDAPMagicList.ItemIndex >= 0) and (FrmDlg3.DDAPMagicList.ItemIndex < FrmDlg3.DDAPMagicList.Item.Count) then
          nMagicID := Integer(FrmDlg3.DDAPMagicList.Item.Objects[FrmDlg3.DDAPMagicList.ItemIndex]);

        if (nMagicID > 0) and (nMagicID < SKILL_MAX) and g_MyMagicArry[nMagicID].boStudy then
        begin
          g_TargetCret := nil;
          g_FocusCret := m_TargetCret;

          PlayScene.ScreenXYfromMCXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, g_nMouseX, g_nMouseY);
          if (GetTickCount - FAttackTick > 1000) and (frmMain.ActionKey = 0) then
          begin
            FAttackTick := GetTickCount;
            frmMain.UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[nMagicID]);
          end;
          if GetRangeTargetCount(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, 2) > 0 then
          begin
            //DScreen.AddChatBoardString('Avoid', clYellow, clRed);
            Avoid;
            exit;
          end;

        end
        else
        begin
          tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          GetBackPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, tdir, dx, dy);

          if CanWalk(dx, dy, True) then
            g_TargetCret := m_TargetCret
          else
          begin
            g_TargetCret := nil;
          end;
        end;
      end
      else
      begin
        {tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        GetBackPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, tdir, dx, dy);
        if CanWalk(dx, dy, True) then
          g_TargetCret := m_TargetCret
        else
          g_TargetCret := nil;}
        g_TargetCret := m_TargetCret;
      end;
    end
    else
    begin
      //g_TargetCret := nil;
      if (g_nTargetX > 0) and (g_nTargetY > 0) then
      begin
        if (abs(g_MySelf.m_nCurrX - g_nTargetX) >= 1) or (abs(g_MySelf.m_nCurrY - g_nTargetY) >= 1) then
        else
        begin
          GetAutoWalkXY(nTargetX, nTargetY);
          if (abs(g_MySelf.m_nCurrX - nTargetX) >= 2) or (abs(g_MySelf.m_nCurrY - nTargetY) >= 2) then
            g_ChrAction := caRun
          else
            g_ChrAction := caWalk;
          //GetBackPosition(target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
          g_nTargetX := nTargetX;
          g_nTargetY := nTargetY;
          m_nTargetX := nTargetX;
          m_nTargetY := nTargetY;
          //DScreen.AddSayMsg('m_TargetCret1 = nil X:' + IntToStr(g_MySelf.m_nCurrX) + ' Y:' + IntToStr(g_MySelf.m_nCurrY) + ' TX:' + IntToStr(g_nTargetX) + ' TY:' + IntToStr(g_nTargetY), clYellow, clRed, True, us_Sys);
        end;
      end
      else
      begin
        GetAutoWalkXY(nTargetX, nTargetY);
        if (abs(g_MySelf.m_nCurrX - nTargetX) >= 2) or (abs(g_MySelf.m_nCurrY - nTargetY) >= 2) then
          g_ChrAction := caRun
        else
          g_ChrAction := caWalk;
        //GetBackPosition(target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
        g_nTargetX := nTargetX;
        g_nTargetY := nTargetY;
        m_nTargetX := nTargetX;
        m_nTargetY := nTargetY;
        //DScreen.AddSayMsg('m_TargetCret2 = nil X:' + IntToStr(g_MySelf.m_nCurrX) + ' Y:' + IntToStr(g_MySelf.m_nCurrY) + ' TX:' + IntToStr(g_nTargetX) + ' TY:' + IntToStr(g_nTargetY), clYellow, clRed, True, us_Sys);
      end
    end;
  end;
end;

end.
