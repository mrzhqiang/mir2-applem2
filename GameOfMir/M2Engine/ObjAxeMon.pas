unit ObjAxeMon;

interface
uses
  Windows, Classes, Grobal2, ObjBase, ObjMon;
type
  TDualAxeMonster = class(TMonster)
    bo558: Boolean;
    m_nAttackCount: Integer; //0x55C
    m_nAttackMax: Integer; //0x560
  private
    procedure FlyAxeAttack(Target: TBaseObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override; //FFEB
    procedure Run; override;
  end;

  TThornDarkMonster = class(TDualAxeMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TArcherMonster = class(TDualAxeMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;

  TDualEffectMonster = class(TMonster)
  private
    procedure FlyAxeAttack(Target: TBaseObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override; //FFEB
    procedure Run; override;
  end;
implementation

uses M2Share, HUtil32;

{ TDualAxeMonster }

procedure TDualAxeMonster.FlyAxeAttack(Target: TBaseObject);
var
  WAbil: pTAbility;
  nDamage: Integer;
begin
  if m_PEnvir.CanFly(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY) then begin
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY);
    WAbil := @m_WAbil;
    nDamage := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    if nDamage > 0 then begin
      nDamage := Target.GetHitStruckDamage(Self, nDamage);
    end;
    if nDamage > 0 then begin
      Target.StruckDamage(nDamage, Self);
      Target.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
        Target.m_WAbil.HP, Target.m_WAbil.MaxHP, Integer(Self),0, '',
        _MAX(abs(m_nCurrX - Target.m_nCurrX), abs(m_nCurrY - Target.m_nCurrY)) * 50 + 600);
    end;
    SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(Target), '');
  end;

end;

function TDualAxeMonster.AttackTarget: Boolean; //00459B14
begin
  Result := False;
  if m_TargetCret = nil then exit;
  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 7) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 7) then begin
      //if (m_nAttackMax - 1) > m_nAttackCount then begin
        Inc(m_nAttackCount);
        m_dwTargetFocusTick := GetTickCount();
        FlyAxeAttack(m_TargetCret);
      {end
      else begin
        if Random(5) = 0 then begin
          m_nAttackCount := 0;
        end;
      end;   }
      Result := True;
      exit;
    end;
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end
    else begin
      DelTargetCreat();
    end;
  end;
end;

constructor TDualAxeMonster.Create;
begin
  inherited;
  bo558 := False;
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000;
  m_nAttackCount := 0;
  m_nAttackMax := 2;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 87;
end;

destructor TDualAxeMonster.Destroy;
begin

  inherited;
end;

procedure TDualAxeMonster.Run; //00459C98
var
  i, n14: Integer;
  nAbs: Integer;
  nRage: Integer;
  BaseObject: TBaseObject;
  TargeTBaseObject: TBaseObject;
begin
  nRage := 9999;
  TargeTBaseObject := nil;
  if not m_boDeath and not bo558 and not m_boGhost and CanWork then begin

    if (GetTickCount - m_dwSearchEnemyTick) >= 5000 then begin
      m_dwSearchEnemyTick := GetTickCount();
      for i := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            nAbs := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
            if nAbs < nRage then begin
              nRage := nAbs;
              TargeTBaseObject := BaseObject;
            end;
          end;
        end;
      end;
      if TargeTBaseObject <> nil then begin
        SetTargetCreat(TargeTBaseObject);
      end;
    end;

    if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) and (m_TargetCret <> nil) then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) then begin
          if Random(5) = 0 then begin
            //GetBackPosition(m_nTargetX, m_nTargetY);
            n14 := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
            m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
          end;
        end
        else begin
          //GetBackPosition(m_nTargetX, m_nTargetY);
          n14 := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
          m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
        end;
      end;
    end;
  end;
  inherited;
end;

{ TThornDarkMonster }

constructor TThornDarkMonster.Create; //00459EE4
begin
  inherited;
  m_nAttackMax := 3;
  m_btRaceServer := 93;
end;

destructor TThornDarkMonster.Destroy;
begin

  inherited;
end;

{ TArcherMonster }

constructor TArcherMonster.Create;
begin
  inherited;
  m_nAttackMax := 6;
  m_btRaceServer := 104;
end;

destructor TArcherMonster.Destroy;
begin

  inherited;
end;
{ TDualEffectMonster }

function TDualEffectMonster.AttackTarget: Boolean;
var
  bt06: Byte;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, bt06); //FFED
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else
    if (m_TargetCret.m_PEnvir = m_PEnvir) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 7) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 7) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        FlyAxeAttack(m_TargetCret);
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
      end
      else begin
        DelTargetCreat(); {0FFF1h}
        //004A9009
      end;
    end;
  end;
end;

constructor TDualEffectMonster.Create;
begin
  inherited;
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000;
  m_dwSearchTick := GetTickCount();
end;

destructor TDualEffectMonster.Destroy;
begin

  inherited;
end;

procedure TDualEffectMonster.FlyAxeAttack(Target: TBaseObject);
var
  WAbil: pTAbility;
  nDamage: Integer;
begin
  if m_PEnvir.CanFly(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY) then begin
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY);
    WAbil := @m_WAbil;
    nDamage := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    if nDamage > 0 then begin
      nDamage := Target.GetHitStruckDamage(Self, nDamage);
    end;
    if nDamage > 0 then begin
      Target.StruckDamage(nDamage, Self);
      Target.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
        Target.m_WAbil.HP, Target.m_WAbil.MaxHP, Integer(Self),0, '',
        _MAX(abs(m_nCurrX - Target.m_nCurrX), abs(m_nCurrY - Target.m_nCurrY)) * 50 + 600);
    end;
    SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(Target), '');
  end;
end;

procedure TDualEffectMonster.Run;
var
  i: Integer;
  nAbs: Integer;
  nRage: Integer;
  BaseObject: TBaseObject;
  TargeTBaseObject: TBaseObject;
begin
  nRage := 9999;
  TargeTBaseObject := nil;
  if not m_boDeath  and not m_boGhost and CanWork then begin

    if (GetTickCount - m_dwSearchEnemyTick) >= 5000 then begin
      m_dwSearchEnemyTick := GetTickCount();
      for i := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            nAbs := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
            if nAbs < nRage then begin
              nRage := nAbs;
              TargeTBaseObject := BaseObject;
            end;
          end;
        end;
      end;
      if TargeTBaseObject <> nil then begin
        SetTargetCreat(TargeTBaseObject);
      end;
    end;
  end;
  inherited;
end;

end.
