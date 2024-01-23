unit OjbKindMon;

interface
uses
  Windows, Classes, Grobal2, ObjBase, ObjMon, Envir;

Type

  { TBaseKingMonster }

  TBaseKingMonster = class(TDoubleATKMonster)
    m_boDeliriaOK: Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure BeginDeliria; override;
    procedure EndDeliria; override;
  end;

  //沃玛教主
  { TAomaKingMonster }
  TAomaKingMonster = class(TBaseKingMonster)
  public
    constructor Create(); override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  //祖玛教主
  { TZhumaKingMonster }
  TZhumaKingMonster = class(TBaseKingMonster)
    m_nDangerLevel: Integer;
    m_SlaveObjectList: TList; //0x55C
  private
    procedure MeltStone;
    procedure CallSlave;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
    procedure Run; override;
  end;

  //魔龙教主
  { TZhumaKingMonster }
  TMolongKindMonster = class(TBaseKingMonster)
  private
    procedure WideAttack(nTargetX, nTargetY: Integer);
  public
    constructor Create(); override;
    function AttackTarget(): Boolean; override; //FFEB
  end;

  //雪域魔王
  { TXueyuKindMonster }
  TXueyuKindMonster = class(TBaseKingMonster)
    m_MonsterLevel: Byte;
    m_AttackWide: Byte;
    m_FullWide: Byte;
  public
    constructor Create(); override;
    procedure Initialize(); override;
    function AttackTarget(): Boolean; override; //FFEB
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
    procedure BeginDeliria; override;
    procedure EndDeliria; override;
  end;

  {雷炎蛛王}
  TLeiyanKindMonster = class(TBaseKingMonster)
  public
    constructor Create(); override;
    function AttackTarget(): Boolean; override; //FFEB
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TMXNXXKingMonster = class(TBaseKingMonster)
  private
    function CheckViewRange(Targe: TBaseObject; nViewRange: Integer): Boolean;
    function GetCircumambienceMonCount(nRate: Byte = 2): Integer;
    function BaseLongAttackTarget(btDir, btRate: Byte): Boolean;
    function WideAttack(nSX, nSY:Integer; nRate: Byte; boMagic: Boolean): Boolean;
    function FlyWideAttack(nSX, nSY:Integer; nRate: Byte): Boolean;
  end;

  TM2N7XKindMonster = class(TMXNXXKingMonster)
  private
    function FullAttack: Boolean;
  public
    constructor Create(); override;
    function AttackTarget(): Boolean; override; //FFEB
  end;

  TM3N4XKindMonster = class(TMXNXXKingMonster)
  private
    function FullAttack: Boolean;
  public
    constructor Create(); override;
    function AttackTarget(): Boolean; override; //FFEB
  end;

  TM5N9XKindMonster = class(TMXNXXKingMonster)
  private
    function FullAttack: Boolean;
  public
    constructor Create(); override;
    function AttackTarget(): Boolean; override; //FFEB
  end;

  TM6N9XKindMonster = class(TMXNXXKingMonster)
  private
    function FullAttack: Boolean;
  public
    constructor Create(); override;
    function AttackTarget(): Boolean; override; //FFEB
  end;

  TM7N9XKindMonster = class(TMXNXXKingMonster)
  private
    function FullAttack: Boolean;
  public
    constructor Create(); override;
    function AttackTarget(): Boolean; override; //FFEB
  end;

  TM6N4XKingMonster = class(TAnimalObject)
    dwNextHitTime: LongWord;
    dwCheckTick: LongWord;
    dwDeliriaTime: LongWord;
    boDeliria: Boolean;
    n560: Integer;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; virtual; //FFEB
    procedure Run; override;
    procedure Initialize(); override;
  end;


  // 火龙神
  { TfiredrakeKingMonster}
  TFiredrakeKingMonster = class(TAnimalObject)
    dwNextHitTime: LongWord;
    dwCheckTick: LongWord;
    dwDeliriaTime: LongWord;
    boDeliria: Boolean;
    n560: Integer;
  private
    function FullAttack: Boolean;
    //function BoundAttack: Boolean;
    procedure CheckDirection;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; virtual; //FFEB
    procedure Run; override;
    procedure Initialize(); override;
  end;

  TM2N4XMonster = class(TAnimalObject)
    dwNextHitTime: LongWord;
    dwCheckTick: LongWord;
    dwDeliriaTime: LongWord;
    boDeliria: Boolean;
    n560: Integer;
  private
    function FullAttack: Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; virtual; //FFEB
    procedure Run; override;
    procedure Initialize(); override;
  end;


implementation
uses
  UsrEngn, M2Share, Event;

{ TBaseKingMonster }


procedure TBaseKingMonster.BeginDeliria;
begin
  m_nNextHitTime := 700;
  m_nWalkSpeed := 400;
  m_boDeliriaOK := False;
end;

constructor TBaseKingMonster.Create;
begin
  inherited;
  m_dwSearchTime := Random(1500) + 500;
  m_boRandomMove := True;
  m_boDeliriaOK := True;
  bo2BF := True;
end;

destructor TBaseKingMonster.Destroy;
begin

  inherited;
end;

procedure TBaseKingMonster.EndDeliria;
begin
  m_nNextHitTime := m_dwNextHitTime;
  m_nWalkSpeed := m_nWalkSpeed;
  m_boDeliriaOK := True;
end;

{ TAomaKingMonster }

procedure TAomaKingMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  WAbil: pTAbility;
  nPower: Integer;
begin
  WAbil := @m_WAbil;
  nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
  HitMagAttackTarget(TargeTBaseObject, nPower div 2, nPower div 2, True);
end;

constructor TAomaKingMonster.Create;
begin
  inherited;
end;

{ TZhumaKingMonster }

procedure TZhumaKingMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  WAbil: pTAbility;
  nPower: Integer;
begin
  if TargeTBaseObject <> nil then begin
    WAbil := @m_WAbil;
    nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
    HitMagAttackTarget(TargeTBaseObject, 0, nPower, True);
  end;
end;

procedure TZhumaKingMonster.CallSlave;
var
  I: Integer;
  nC: Integer;
  n10, n14: Integer;
  BaseObject: TBaseObject;
begin
  nC := Random(6) + 6;
  GetFrontPosition(n10, n14);
  for I := 1 to nC do begin
    if m_SlaveObjectList.Count >= 30 then break;
    BaseObject := UserEngine.RegenMonsterByName(m_sMapName, n10, n14, g_Config.sZuma[Random(4)]);
    if BaseObject <> nil then begin
      m_SlaveObjectList.Add(BaseObject);
    end;
  end; // for
end;

constructor TZhumaKingMonster.Create;
begin
  inherited;
  m_nViewRange := 8;
  m_boStoneMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;
  m_btDirection := 5;
  m_nDangerLevel := 5;
  m_SlaveObjectList := TList.Create;
  m_boAutoSearch := False;
end;

destructor TZhumaKingMonster.Destroy;
begin
  m_SlaveObjectList.Free;
  inherited;
end;

procedure TZhumaKingMonster.MeltStone;
var
  Event: TEvent;
begin
  m_nCharStatusEx := 0;
  m_nCharStatus := GetCharStatus();
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boStoneMode := False;
  Event := TEvent.Create(m_PEnvir, m_nCurrX, m_nCurrY, 6, 5 * 60 * 1000, True);
  g_EventManager.AddEvent(Event);
end;

procedure TZhumaKingMonster.Run;
var
  I: Integer;
  //  n10: Integer;
  BaseObject: TBaseObject;
begin
  if (not m_boGhost) and (not m_boDeath) and CanWork and
    (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
    if m_boStoneMode then begin
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then Continue;
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 2) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 2) then begin
              MeltStone();
              break;
            end;
          end;
        end;
      end; // for
    end
    else begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();
        if (m_nDangerLevel > m_WAbil.HP / m_WAbil.MaxHP * 5) and (m_nDangerLevel > 0) then begin
          Dec(m_nDangerLevel);
          CallSlave();
        end;
        if m_WAbil.HP = m_WAbil.MaxHP then
          m_nDangerLevel := 5;
      end;
    end;
    for I := m_SlaveObjectList.Count - 1 downto 0 do begin
      if m_SlaveObjectList.Count <= 0 then break;
      BaseObject := TBaseObject(m_SlaveObjectList.Items[I]);
      if BaseObject <> nil then begin
        if BaseObject.m_boDeath or BaseObject.m_boGhost then
          m_SlaveObjectList.Delete(I);
      end;
    end;
  end;
  inherited;
end;

{ TMolongKindMonster }

function TMolongKindMonster.AttackTarget: Boolean;
var
  bt06: Byte;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        WideAttack(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        //Attack(m_TargetCret, bt06);
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

constructor TMolongKindMonster.Create;
begin
  inherited;

end;

procedure TMolongKindMonster.WideAttack(nTargetX, nTargetY: Integer);
var
  nX, nY, nPower, nDamage: Integer;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, nTargetX, nTargetY);
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
  for nX := m_nCurrX - 1 to m_nCurrX + 1 do begin
    for nY := m_nCurrY - 1 to m_nCurrY + 1 do begin
      if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
              IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
            begin
              nDamage := 0;
              if (nX = nTargetX) and (nY = nTargetY) then begin
                nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
              end else begin
                nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
              end;
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                  BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

{ TFiredrakeKingMonster }

function TFiredrakeKingMonster.AttackTarget: Boolean;
begin
 { if boDeliria then Result := FullAttack
  else Result := BoundAttack;  }
  Result := FullAttack
end;

(*
function TFiredrakeKingMonster.BoundAttack: Boolean;
var
  i: Integer;
  BaseObject: TBaseObject;
  nPower: Integer;
  WAbil: pTAbility;
begin
  Result := False;
  if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
    m_dwHitTick := GetTickCount();
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    CheckDirection;
    SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
    WAbil := @m_WAbil;
    nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    {for i := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
      if BaseObject = nil then Continue;
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then
        begin
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 1,
            Integer(BaseObject), '', 200);
          SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 4, '');
        end;
      end;
    end; // for }
    Result := True;
  end;
end;     *)

procedure TFiredrakeKingMonster.CheckDirection;
begin

  case m_btDirection of
    0, 7, 6: m_btDirection := 2;
    5: m_btDirection := 1;
    4, 3, 2, 1: m_btDirection := 0;
    else m_btDirection := 1;
  end;
end;

constructor TFiredrakeKingMonster.Create;
begin
  inherited;
  m_nViewRange := g_Config.nSendRefMsgRange;
  m_dwSearchTime := Random(1500) + 500;
  dwCheckTick := GetTickCount;
  n560 := 0;
  boDeliria := False;
  bo2BF := True;
end;

destructor TFiredrakeKingMonster.Destroy;
begin

  inherited;
end;

function TFiredrakeKingMonster.FullAttack: Boolean;
var
  i: Integer;
  BaseObject: TBaseObject;
  nPower: Integer;
  WAbil: pTAbility;
begin
  Result := False;
  if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
    m_dwHitTick := GetTickCount();
    m_dwTargetFocusTick := GetTickCount();
    //m_btDirection := 1;
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    CheckDirection;
    SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
    WAbil := @m_WAbil;
    nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    for i := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
      if BaseObject = nil then Continue;
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then
        begin
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 3,
            Integer(BaseObject), '', 400);
          SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 8{雷电}, '', 360);
          //self.SendDelayMsg();
        end;
      end;
    end; // for
    BreakHolySeizeMode();
    Result := True;
  end;
end;

procedure TFiredrakeKingMonster.Initialize;
begin
  dwNextHitTime := m_nNextHitTime;
  inherited;
end;

procedure TFiredrakeKingMonster.Run;
var
  n10: Integer;
begin
  if (not m_boGhost) and (not m_boDeath) and CanWork then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
      (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;

    if ((GetTickCount - dwCheckTick) > 10000) then begin
      dwCheckTick := GetTickCount();
      n10 := n560;
      n560 := 7 - m_WAbil.HP div (m_WAbil.MaxHP div 7);
      if (n560 >= 2) and (n560 <> n10) then begin
        boDeliria := True;
        dwDeliriaTime := GetTickCount();
      end;
      if boDeliria then begin
        if (GetTickCount - dwDeliriaTime) < 8000 then begin
          m_nNextHitTime := 700;
        end
        else begin
          boDeliria := False;
          m_nNextHitTime := dwNextHitTime;
        end;
      end;
    end;

    if m_TargetCret <> nil then
      AttackTarget();
  end;
  inherited;
end;

{ TXueyuKindMonster }

procedure TXueyuKindMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  nPower, I, nX, nY, k: Integer;
  nDamage: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
begin
  m_btDirection := nDir;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) div 2;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
  BaseObjectList := TList.Create;
  for I := 1 to m_AttackWide do begin
    if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nX, nY) then begin
      BaseObjectList.Clear;
      m_PEnvir.GeTBaseObjects(nX, nY, True, BaseObjectList);
      for k := 0 to BaseObjectList.Count - 1 do begin
        BaseObject := TBaseObject(BaseObjectList.Items[k]);
        if BaseObject = nil then Continue;
        if IsProperTarget(BaseObject) then begin
          nDamage := 0;
          Inc(nDamage, BaseObject.GetHitStruckDamage(Self, nPower));
          Inc(nDamage, BaseObject.GetMagStruckDamage(Self, nPower));
          if nDamage > 0 then begin
            BaseObject.StruckDamage(nDamage, Self);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
              BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200 + I * 100);
          end;
        end;
      end;
    end;
  end;
  BaseObjectList.Free;
end;

function TXueyuKindMonster.AttackTarget: Boolean;
var
  bt06: Byte;
  BaseObject: TBaseObject;
  i, nPower, nDamage: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if m_boDeliria then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) div 2;
        SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
        for i := 0 to m_VisibleActors.Count - 1 do begin
          BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
          if BaseObject <> nil then begin
            if not BaseObject.m_boDeath then begin
              if IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) and
                (BaseObject.m_PEnvir = m_PEnvir) and (abs(BaseObject.m_nCurrX - m_nCurrX) < m_FullWide) and (abs(BaseObject.m_nCurrY - m_nCurrY) < m_FullWide) then
              begin
                nDamage := 0;
                Inc(nDamage, BaseObject.GetHitStruckDamage(Self, nPower));
                Inc(nDamage, BaseObject.GetMagStruckDamage(Self, nPower));
                if nDamage > 0 then begin
                  BaseObject.StruckDamage(nDamage, Self);
                  BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                    BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
                end;
              end;
            end;
          end;
        end;
        BreakHolySeizeMode();
        Result := True;
      end else begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) >= m_AttackWide) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) >= m_AttackWide) then
        begin
          if m_TargetCret.m_PEnvir = m_PEnvir then begin
            SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
            //004A8FE3
          end
          else begin
            DelTargetCreat(); {0FFF1h}
            //004A9009
          end;
        end else
          Result := True;
      end;
    end else begin
      if GetAttackDir(m_TargetCret, bt06) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          Attack(m_TargetCret, bt06); //FFED
          BreakHolySeizeMode();
        end;
        Result := True;
      end
      else begin
        if ((abs(m_nCurrX - m_TargetCret.m_nCurrX) <= m_AttackWide) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= m_AttackWide) and
          CheckBeeline(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY)) and
          (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime)  then
        begin
          m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          Attack(m_TargetCret, m_btDirection); //FFED
          BreakHolySeizeMode();
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
  end;
end;

procedure TXueyuKindMonster.BeginDeliria;
begin
  if m_MonsterLevel = 1 then begin
    inherited BeginDeliria;
  end;
  m_boDeliriaOK := False;
end;

constructor TXueyuKindMonster.Create;
begin
  inherited;
  m_nViewRange := 8;
  m_MonsterLevel := 1;
  m_AttackWide := 4;
  m_FullWide := 8;
end;

procedure TXueyuKindMonster.EndDeliria;
begin
  if m_MonsterLevel = 1 then begin
    inherited EndDeliria;
  end;
  m_boDeliriaOK := True;
end;

procedure TXueyuKindMonster.Initialize;
begin
  inherited Initialize;
  case m_wAppr of
    329, 266: begin
        m_boRandomMove := False;
        m_MonsterLevel := 3;
        m_nViewRange := 5;
        m_AttackWide := 2;
        m_FullWide := 3;
      end;
    267: begin
        m_boRandomMove := False;
        m_MonsterLevel := 2;
        m_nViewRange := 6;
        m_AttackWide := 3;
        m_FullWide := 5;
      end;
  end;
end;

{ TLeiyanKindMonster }

procedure TLeiyanKindMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  WAbil: pTAbility;
  nPower: Integer;
begin
  if TargeTBaseObject <> nil then begin
    WAbil := @m_WAbil;
    nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
    HitMagAttackTarget(TargeTBaseObject, nPower, 0, True);
  end;
end;

function TLeiyanKindMonster.AttackTarget: Boolean;
var
  bt06: Byte;
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if m_boDeliria and (m_TargetCret.m_wStatusTimeArr[POISON_COBWEB] <= 0) and
      (abs(m_TargetCret.m_nCurrX - m_nCurrX) < 12) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) < 12) then begin
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
      for nX := m_TargetCret.m_nCurrX - 2 to m_TargetCret.m_nCurrX + 2 do begin
        for nY := m_TargetCret.m_nCurrY - 2 to m_TargetCret.m_nCurrY + 2 do begin
          if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := MapCellInfo.ObjList.Items[I];
              if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                BaseObject := TBaseObject(OSObject.CellObj);
                if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                  IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
                begin
                  BaseObject.SendMsg(Self, RM_POISON,
                    POISON_COBWEB {中毒类型 - 蛛网}, g_Config.nAttackPosionTime,
                    Integer(BaseObject), g_Config.nAttackPosionTime, '');
                end;
              end;
            end;
          end;
        end;
      end;
      BreakHolySeizeMode();
      Result := True;
    end else begin
      if GetAttackDir(m_TargetCret, bt06) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          Attack(m_TargetCret, bt06);
          BreakHolySeizeMode();
        end;
        Result := True;
      end
      else begin
        if m_TargetCret.m_PEnvir = m_PEnvir then begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end
        else begin
          DelTargetCreat();
        end;
      end;
    end;
  end;
end;

constructor TLeiyanKindMonster.Create;
begin
  inherited;
  m_nViewRange := 8;
end;

{ TM2N4XMonster }

function TM2N4XMonster.AttackTarget: Boolean;
begin
  Result := FullAttack;
end;

constructor TM2N4XMonster.Create;
begin
  inherited;
  m_nViewRange := g_Config.nSendRefMsgRange;
  m_dwSearchTime := Random(1500) + 500;
  dwCheckTick := GetTickCount;
  n560 := 0;
  boDeliria := False;
  m_btDirection := 0;
  bo2BF := True;
end;

destructor TM2N4XMonster.Destroy;
begin

  inherited;
end;

function TM2N4XMonster.FullAttack: Boolean;
var
  i: Integer;
  BaseObject: TBaseObject;
  nPower, nDamage: Integer;
begin
  Result := False;
  if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
    m_dwHitTick := GetTickCount();
    m_dwTargetFocusTick := GetTickCount();
    SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
    nPower := (Random(SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1) + LoWord(m_WAbil.DC));
    for i := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
      if BaseObject = nil then Continue;
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then
        begin
          nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
          if nDamage > 0 then begin
            BaseObject.StruckDamage(nDamage, Self);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, BaseObject.m_WAbil.HP,
              BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
          end;
        end;
      end;
    end; // for
    BreakHolySeizeMode();
    Result := True;
  end;
end;

procedure TM2N4XMonster.Initialize;
begin
  dwNextHitTime := m_nNextHitTime;
  inherited;
  m_btDirection := 0;
end;

procedure TM2N4XMonster.Run;
var
  n10: Integer;
begin
  if (not m_boGhost) and (not m_boDeath) and CanWork then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
      (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;

    if ((GetTickCount - dwCheckTick) > 10000) then begin
      dwCheckTick := GetTickCount();
      n10 := n560;
      n560 := 7 - m_WAbil.HP div (m_WAbil.MaxHP div 7);
      if (n560 >= 2) and (n560 <> n10) then begin
        boDeliria := True;
        dwDeliriaTime := GetTickCount();
      end;
      if boDeliria then begin
        if (GetTickCount - dwDeliriaTime) < 8000 then begin
          m_nNextHitTime := 700;
        end
        else begin
          boDeliria := False;
          m_nNextHitTime := dwNextHitTime;
        end;
      end;
    end;

    if m_TargetCret <> nil then
      AttackTarget();
  end;
  inherited;
end;

{ TM2N7XKindMonster }

function TM2N7XKindMonster.AttackTarget: Boolean;
var
  nAttackDir: Byte;
  btAttackMode: Byte;
  nPower: Integer;
begin
  Result := False;
  if (m_TargetCret <> nil) or (not IsProperTarget(m_TargetCret)) then begin
    nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    if m_boDeliria then begin
      if CheckViewRange(m_TargetCret, 7) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nAttackDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          if not m_boDeliriaOK then begin
            m_boDeliriaOK := True;
            SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
            //WideAttack(5, False);
            WideAttack(m_nCurrX, m_nCurrY, 5, False);
          end else begin
            SendAttackMsg(RM_HIT, SM_HIT_4, m_btDirection, m_nCurrX, m_nCurrY);
            FullAttack;
          end;
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else begin
      btAttackMode := 0;
      if GetCircumambienceMonCount > 1 then begin
        btAttackMode := 1;
      end else
      if BaseLongAttackTarget(nAttackDir, 2) then begin
        btAttackMode := 2;
      end else
      if CheckViewRange(m_TargetCret, 5) then begin
        btAttackMode := 3;
      end;
      if btAttackMode > 0 then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nAttackDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          case btAttackMode of
            1: begin
                SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
                //WideAttack(2, False);
                WideAttack(m_nCurrX, m_nCurrY, 2, False);
              end;
            3: begin
                SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
                nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
                SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3, Integer(m_TargetCret), '', 100);
                SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 17, '', 100);
              end;
          end;
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end;
    if not Result then begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;


constructor TM2N7XKindMonster.Create;
begin
  inherited;
  m_nViewRange := g_Config.nSendRefMsgRange - 1;
end;

function TM2N7XKindMonster.FullAttack: Boolean;
var
  nPower: Integer;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := False;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
      IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
    begin
      SendDelayMsg(Self, RM_DELAYMAGIC, nPower, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 3, Integer(BaseObject), '', 500);
      SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 18, '', 500);
    end;
  end;
end;

{ TM3N4XKindMonster }

function TM3N4XKindMonster.AttackTarget: Boolean;
var
  nAttackDir: Byte;
  btAttackMode: Byte;
begin
  Result := False;
  if (m_TargetCret <> nil) or (not IsProperTarget(m_TargetCret)) then begin
    nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    if m_boDeliria then begin
      if CheckViewRange(m_TargetCret, 7) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nAttackDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendAttackMsg(RM_HIT, SM_HIT_4, m_btDirection, m_nCurrX, m_nCurrY);
          FullAttack;
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else begin
      btAttackMode := 0;
      if GetCircumambienceMonCount > 1 then begin
        btAttackMode := 1;
      end else
      if BaseLongAttackTarget(nAttackDir, 2) then begin
        btAttackMode := 2;
      end else
      if CheckViewRange(m_TargetCret, 5) then begin
        btAttackMode := 3;
      end;
      if btAttackMode > 0 then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nAttackDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          case btAttackMode of
            1: begin
                SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
                WideAttack(m_nCurrX, m_nCurrY, 3, False);
              end;
            3: begin
                SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
                WideAttack(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 2, True);
                SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 19, '', 200);
              end;
          end;
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end;
    if not Result then begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

constructor TM3N4XKindMonster.Create;
begin
  inherited;
  m_nViewRange := g_Config.nSendRefMsgRange - 1;
end;

function TM3N4XKindMonster.FullAttack: Boolean;
var
  nPower: Integer;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := False;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
      IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
    begin
      SendDelayMsg(Self, RM_DELAYMAGIC, nPower, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 3, Integer(BaseObject), '', 500);
      SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 20, '', 200);
    end;
  end;
end;

{ TM5N9XKindMonster }

function TM5N9XKindMonster.AttackTarget: Boolean;
var
  nAttackDir: Byte;
  btAttackMode: Byte;
begin
  Result := False;
  if (m_TargetCret <> nil) or (not IsProperTarget(m_TargetCret)) then begin
    nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    if m_boDeliria then begin
      if CheckViewRange(m_TargetCret, 7) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nAttackDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
          FullAttack;
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else begin
      btAttackMode := 0;
      if GetCircumambienceMonCount > 1 then begin
        btAttackMode := 1;
      end else
      if BaseLongAttackTarget(nAttackDir, 3) then begin
        btAttackMode := 2;
      end;
      if btAttackMode > 0 then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nAttackDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          case btAttackMode of
            1: begin
                SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
                WideAttack(m_nCurrX, m_nCurrY, 2, False);
              end;
          end;
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end;
    if not Result then begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

constructor TM5N9XKindMonster.Create;
begin
  inherited;
  m_nViewRange := 7;
end;

function TM5N9XKindMonster.FullAttack: Boolean;
var
  nPower, nDamage: Integer;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := False;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
      IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
    begin
      nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
      if nDamage > 0 then begin
        BaseObject.StruckDamage(nDamage, Self);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
          BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 500);
      end;
    end;
  end;
end;

{ TMXNXXKingMonster }

function TMXNXXKingMonster.BaseLongAttackTarget(btDir, btRate: Byte): Boolean;
var
  I, nX, nY, nPower, nDamage: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if (m_PEnvir = m_TargetCret.m_PEnvir) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= btRate) and
      (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= btRate) and CheckBeeline(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := btDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        for I := 1 to btRate do begin
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nX, nY) then begin
            BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
              nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, BaseObject.m_WAbil.HP,
                  BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
              end;
            end;
          end;
        end;
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        BreakHolySeizeMode();
      end;
      Result := True;
    end;
  end;
end;

function TMXNXXKingMonster.CheckViewRange(Targe: TBaseObject; nViewRange: Integer): Boolean;
begin
  Result := False;
  if (Targe <> nil) and (abs(m_nCurrX - Targe.m_nCurrX) <= nViewRange) and (abs(m_nCurrY - Targe.m_nCurrY) <= nViewRange) then
    Result := True;
end;

function TMXNXXKingMonster.FlyWideAttack(nSX, nSY: Integer; nRate: Byte): Boolean;
var
  nPower, nX, nY, nDamage: Integer;
  BaseObject: TBaseObject;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
  for nX := nSX - nRate to nSX + nRate do begin
    for nY := nSY - nRate to nSY + nRate do begin
      if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
              IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
            begin
              nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                  BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'',
                  800 + (abs(BaseObject.m_nCurrX - m_nCurrX) + abs(BaseObject.m_nCurrY - m_nCurrY)) div 2 * 20);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TMXNXXKingMonster.GetCircumambienceMonCount(nRate: Byte): Integer;
var
  i: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
      (BaseObject.m_PEnvir = m_PEnvir) and (abs(BaseObject.m_nCurrX - m_nCurrX) <= nRate) and (abs(BaseObject.m_nCurrY - m_nCurrY) <= nRate) then begin
      if (not BaseObject.m_boHideMode or m_boCoolEye) and IsProperTarget(BaseObject) then
        Inc(Result);
    end;
  end;
end;

function TMXNXXKingMonster.WideAttack(nSX, nSY: Integer; nRate: Byte; boMagic: Boolean): Boolean;
var
  nPower, nX, nY, nDamage: Integer;
  BaseObject: TBaseObject;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
  for nX := nSX - nRate to nSX + nRate do begin
    for nY := nSY - nRate to nSY + nRate do begin
      if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
              IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
            begin
              if boMagic then nDamage := BaseObject.GetMagStruckDamage(Self, nPower)
              else nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                  BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 450);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{ TM7N9XKindMonster }

function TM7N9XKindMonster.AttackTarget: Boolean;
var
  nAttackDir: Byte;
  btAttackMode: Byte;
begin
  Result := False;
  if (m_TargetCret <> nil) or (not IsProperTarget(m_TargetCret)) then begin
    nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    if m_boDeliria then begin
      if CheckViewRange(m_TargetCret, 7) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nAttackDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
          FullAttack;
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else begin
      btAttackMode := 0;
      if GetCircumambienceMonCount > 1 then begin
        btAttackMode := 1;
      end else
      if BaseLongAttackTarget(nAttackDir, 2) then begin
        btAttackMode := 2;
      end else
      if CheckViewRange(m_TargetCret, 8) then begin
        btAttackMode := 3;
      end;
      if btAttackMode > 0 then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nAttackDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          case btAttackMode of
            1: begin
                SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
                WideAttack(m_nCurrX, m_nCurrY, 2, False);
              end;
            3: begin
                SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
                FlyWideAttack(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3);
                SendRefMsg(RM_MONMAGIC, 6, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 400);
              end;
          end;
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end;
    if not Result then begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

constructor TM7N9XKindMonster.Create;
begin
  inherited;
  m_nViewRange := 7;
end;

function TM7N9XKindMonster.FullAttack: Boolean;
var
  nPower, nDamage: Integer;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := False;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
      IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
    begin
      nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
      if nDamage > 0 then begin
        BaseObject.StruckDamage(nDamage, Self);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
          BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 500);
      end;
    end;
  end;
end;

{ TM6N9XKindMonster }

function TM6N9XKindMonster.AttackTarget: Boolean;
var
  nAttackDir: Byte;
  btAttackMode: Byte;
  nPower: Integer;
begin
  Result := False;
  if (m_TargetCret <> nil) or (not IsProperTarget(m_TargetCret)) then begin
    nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    if m_boDeliria then begin
      if CheckViewRange(m_TargetCret, 7) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nAttackDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
          FullAttack;
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else begin
      btAttackMode := 0;
      if GetCircumambienceMonCount > 1 then begin
        btAttackMode := 1;
      end else
      if BaseLongAttackTarget(nAttackDir, 3) then begin
        btAttackMode := 2;
      end else
      if CheckViewRange(m_TargetCret, 7) then begin
        btAttackMode := 3;
      end;
      if btAttackMode > 0 then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nAttackDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          case btAttackMode of
            1: begin
                SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
                WideAttack(m_nCurrX, m_nCurrY, 2, False);
              end;
            3: begin
                SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
                nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
                SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 5, Integer(m_TargetCret), '', 600);
                SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 25, '', 500);
              end;
          end;
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end;
    if not Result then begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

constructor TM6N9XKindMonster.Create;
begin
  inherited;
  m_nViewRange := 7;
end;

function TM6N9XKindMonster.FullAttack: Boolean;
var
  nPower: Integer;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := False;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
      IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
    begin
      SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 5, Integer(m_TargetCret), '', 400);
      SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 26, '', 300);
    end;
  end;
end;

{ TM6N4XKingMonster }

function TM6N4XKingMonster.AttackTarget: Boolean;
begin
  Result := True;
end;

constructor TM6N4XKingMonster.Create;
begin
  inherited;
  m_nViewRange := g_Config.nSendRefMsgRange;
  m_dwSearchTime := Random(1500) + 500;
  dwCheckTick := GetTickCount;
  n560 := 0;
  bo2BF := True;
  boDeliria := False;
end;

destructor TM6N4XKingMonster.Destroy;
begin

  inherited;
end;

procedure TM6N4XKingMonster.Initialize;
begin
  dwNextHitTime := m_nNextHitTime;
  inherited;
end;

procedure TM6N4XKingMonster.Run;
var
  n10: Integer;
begin
  if (not m_boGhost) and (not m_boDeath) and CanWork then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
      (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;

    if ((GetTickCount - dwCheckTick) > 10000) then begin
      dwCheckTick := GetTickCount();
      n10 := n560;
      n560 := 7 - m_WAbil.HP div (m_WAbil.MaxHP div 7);
      if (n560 >= 2) and (n560 <> n10) then begin
        boDeliria := True;
        dwDeliriaTime := GetTickCount();
      end;
      if boDeliria then begin
        if (GetTickCount - dwDeliriaTime) < 8000 then begin
          m_nNextHitTime := 700;
        end
        else begin
          boDeliria := False;
          m_nNextHitTime := dwNextHitTime;
        end;
      end;
    end;

    if m_TargetCret <> nil then
      AttackTarget();
  end;
  inherited;
end;

end.

