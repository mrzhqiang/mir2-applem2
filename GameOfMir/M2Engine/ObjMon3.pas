unit ObjMon3;

interface
uses
  Windows, Classes, Grobal2, ObjBase, ObjMon;

type
  TCriticalMon = class(TMonster) //±ê×¼Ë«ÖØ¹¥»÷¹ÖÎï
  private

  public
    constructor Create(); override;
    procedure CriticalAttack(AttackTarget: TBaseObject; nDir: Integer); virtual;
    procedure Run; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TElectronicScolpionMon = class(TCriticalMon) //ºçÄ§Ð«ÎÀ
  private
    procedure LightingAttack(nDir: Integer);
  public
    function AttackTarget(): Boolean; override; //FFEB
  end;

  TFiredrakeBodyguardMon = class(TATMonster)
  public
    function AttackTarget(): Boolean; override; //FFEB
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TLeiyanAraneidMon = class(TATMonster)
  public
    function AttackTarget(): Boolean; override; //FFEB
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TGreenAraneidMon = class(TATMonster)
  public
    function AttackTarget(): Boolean; override; //FFEB
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TSnowfieldWarriorMon = class(TATMonster)
  public
    function AttackTarget(): Boolean; override; //FFEB
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TSnowfieldForceMon = class(TATMonster)
  public
    function AttackTarget(): Boolean; override; //FFEB
  end;

  TPakNewMon = class(TDoubleATKMonster)
    m_dwCheckRageTick: LongWord;
    m_boDeliriaOK: Boolean;
    m_boCanDeliria: Boolean;
    m_boIsFirst: Boolean; //0x558
  private
    function CheckViewRange(Targe: TBaseObject; nViewRange: Integer): Boolean;
    function WideAttack(nSX, nSY:Integer; nRate: Byte; boMagic: Boolean): Boolean;
    function AttackBy506(nDir: Integer): Boolean;
    function AttackByMagic(nDir, nMagId: Integer): Boolean;
    function AttackBy512(nDir: Integer): Boolean;
    function AttackBy515(nDir: Integer): Boolean;
    function AttackBy516(nDir: Integer): Boolean;
    function AttackBy526(nDir: Integer): Boolean;
    function AttackBy527(nDir: Integer): Boolean;
    function AttackBy534(nDir: Integer): Boolean;
    function AttackBy535(nDir: Integer): Boolean;
    function AttackBy542(nDir: Integer): Boolean;
    function AttackBy543(nDir: Integer): Boolean;
    function AttackBy544(nDir: Integer): Boolean;
    function AttackBy545(nDir: Integer): Boolean;
    function AttackBy546(nDir: Integer): Boolean;
    function AttackBy547(nDir: Integer): Boolean;
    function AttackBy548(nDir: Integer): Boolean;
    function AttackBy555(nDir: Integer): Boolean;
    function AttackBy557(nDir: Integer): Boolean;
    function AttackBy560(nDir: Integer): Boolean;
    function AttackBy563(nDir: Integer): Boolean;
    function AttackBy564(nDir: Integer): Boolean;
    function AttackBy568(nDir: Integer): Boolean;
    function AttackBy255(nDir: Integer): Boolean;
    function AttackBy243(nDir: Integer): Boolean;
    function AttackBy244(nDir: Integer): Boolean;
    function BaseDoubleAttack(nDir: Integer): Boolean;
    function BaseDoubleMagAttack(nDir, nMID1, nMID2: Integer): Boolean;
    function BaseAttackTarget(nCmd: Integer = SM_HIT): Boolean;
    function BaseLongAttackTarget(btDir, btRate: Byte; nCmd: Integer = SM_HIT): Boolean;
    function BaseLongMsgTarget(btDir, btRate: Byte; nCmd: Integer = SM_HIT): Boolean;
    function GetCircumambienceMonCount(btRate: Byte = 2): Integer;
//    procedure FirstEffect();
  public
    constructor Create(); override;
    procedure Run; override;
    procedure Initialize(); override;
    procedure Die(); override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
    function AttackTarget(): Boolean; override; //FFEB
    procedure BeginDeliria; override;
    procedure EndDeliria; override;
  end;

  TPillarMonster = class(TAnimalObject)
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Initialize(); override;
  end;


implementation

uses
  UsrEngn, M2Share, Event, Envir;

{ TCriticalMon }

procedure TCriticalMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
begin
  if TargeTBaseObject = nil then Exit;
  CriticalAttack(TargeTBaseObject, nDir);
  if m_boDeliria then
    SendRefMsg(RM_LIGHTING, nDir, 0 {msgid}, 0 {Ô¤Áô}, Integer(TargeTBaseObject), '')
  else
    //SendRefMsg(RM_HIT, nDir, m_nCurrX, m_nCurrY, 0, '');
    SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

constructor TCriticalMon.Create;
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

procedure TCriticalMon.CriticalAttack(AttackTarget: TBaseObject; nDir: Integer);
var
  nPower, n20: Integer;
begin
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
  if IsProperTarget(AttackTarget) then begin
    if (Random(AttackTarget.m_btSpeedPoint) >= m_btHitPoint) then begin
      nPower := 0;
    end;
  end
  else
    nPower := 0;
  if nPower > 0 then begin
    nPower := AttackTarget.GetHitStruckDamage(Self, nPower);
    //nWeaponDamage := (Random(5) + 2) - m_AddAbil.btWeaponStrong;
  end;
  if nPower > 0 then begin
    AttackTarget.StruckDamage(nPower, Self);
    AttackTarget.SendDelayMsg(TBaseObject(RM_STRUCK),
      RM_10101, nPower,
      AttackTarget.m_WAbil.HP,
      AttackTarget.m_WAbil.MaxHP,
      Integer(Self), 0,'', 200);

    if not AttackTarget.m_boUnParalysis and
      m_boParalysis and
      (Random(AttackTarget.m_btAntiPoison + g_Config.nAttackPosionRate {5}) = 0)
        then begin
      AttackTarget.MakePosion(POISON_STONE, g_Config.nAttackPosionTime {5}, 0);
    end;
    //ºçÄ§£¬ÎüÑª
    if m_nHongMoSuite > 0 then begin
      m_db3B0 := nPower / 1.E2 * m_nHongMoSuite;
      if m_db3B0 >= 2.0 then begin
        n20 := Trunc(m_db3B0);
        m_db3B0 := n20;
        DamageHealth(-n20);
      end;
    end;
  end;
  if (AttackTarget <> nil) and (AttackTarget.m_btRaceServer <> RC_PLAYOBJECT) then
    AttackTarget.SendMsg(AttackTarget,
      RM_STRUCK, nPower,
      AttackTarget.m_WAbil.HP,
      AttackTarget.m_WAbil.MaxHP, Integer(Self), '');
end;

procedure TCriticalMon.Run;
begin
  if (not m_boDeath) and (not bo554) and (not m_boGhost) and CanWork then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil))
        then begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;

    //ÑªÁ¿µÍÓÚÒ»°ëÊ±¿ªÊ¼·¢¿ñ¹¥»÷
    if m_WAbil.HP < m_WAbil.MaxHP div 2 then
      m_boDeliria := True
    else
      m_boDeliria := False;

  end;
  inherited;
end;

{ TElectronicScolpionMon }

function TElectronicScolpionMon.AttackTarget: Boolean;
var
  nAttackDir: byte;
  nX, nY: Integer;
begin
  Result := False;
  if m_TargetCret = nil then
    Exit;
  if m_boDeliria then begin
    nX := abs(m_nCurrX - m_TargetCret.m_nCurrX);
    nY := abs(m_nCurrY - m_TargetCret.m_nCurrY);
    if GetAttackDir(m_TargetCret, nAttackDir) then begin
      Result := True;
      if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
        m_dwHitTick := GetTickCount();
        LightingAttack(nAttackDir);
      end;
    end
    else if (nX <= 2) and (nY <= 2) and
      CheckBeeline(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) then begin
      Result := True;
      if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
        m_dwHitTick := GetTickCount();
        nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        LightingAttack(nAttackDir);
      end;
    end
    else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
      end
      else begin
        DelTargetCreat(); {0FFF1h}
        //004A9009
      end;
    end;
  end
  else
    Result := inherited AttackTarget;
end;

procedure TElectronicScolpionMon.LightingAttack(nDir: Integer);
var
  nPower, nDamage: Integer;
  i, nX, nY: Integer;
  BaseObject: TBaseObject;
begin
  m_btDirection := nDir;
  nPower := GetAttackPower(LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)));
  for I := 1 to 2 do begin
    if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, nDir, I, nX, nY) then begin
      BaseObject := TBaseObject(m_PEnvir.GetMovingObject(nX, nY, True));
      if BaseObject <> nil then begin
        if IsProperTarget(BaseObject) then begin
          if Random(10) >= BaseObject.m_nAntiMagic then begin
            nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
            if nDamage > 0 then begin
              BaseObject.StruckDamage(nDamage, Self);
              BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),
                RM_10101, nDamage,
                BaseObject.m_WAbil.HP,
                BaseObject.m_WAbil.MaxHP, Integer(Self),0, '', 200);
            end;
          end;
        end;
      end;
    end;
  end;
  SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
end;

{ TFiredrakeBodyguardMon }

procedure TFiredrakeBodyguardMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
const
  WideAttack: array[0..4] of Byte = (0, 1, 2, 6, 7);
var
  nPower: Integer;
  nC, n10: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
  nDamage: Integer;
begin
  m_btDirection := nDir;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
  if nPower > 0 then begin
    nC := 0;
    while (True) do begin
      n10 := (m_btDirection + WideAttack[nC]) mod 8;
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
          SetTargetCreat(BaseObject);
          if (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
            nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
            if nDamage > 0 then begin
              BaseObject.StruckDamage(nDamage, Self);
              BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
                BaseObject.m_WAbil.MaxHP, Integer(Self),0, '', 200);
            end;
          end;
        end;
      end;
      Inc(nC);
      if nC >= 5 then begin
        if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, nX, nY) then begin
          BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
          if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
            SetTargetCreat(BaseObject);
            if (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
              nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
                  BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
              end;
            end;
          end;
        end;
        break;
      end;
    end;
  end;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

function TFiredrakeBodyguardMon.AttackTarget: Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckBeeline(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) and
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY));
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

{ TLeiyanAraneidMon }

procedure TLeiyanAraneidMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  nPower: Integer;
  n10: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
  nDamage: Integer;
begin
  m_btDirection := nDir;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
  if nPower > 0 then begin
    n10 := 1;
    while (True) do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, n10, nX, nY) then begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
          SetTargetCreat(BaseObject);
          nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
          if nDamage > 0 then begin
            BaseObject.StruckDamage(nDamage, Self);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
              BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
          end;
        end;
      end;
      if n10 >= 3 then break;
      Inc(n10);
    end;
  end;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

function TLeiyanAraneidMon.AttackTarget: Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckBeeline(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) and
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 3) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 3) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY));
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

{ TGreenAraneidMon }

procedure TGreenAraneidMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  nPower: Integer;
  n10: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
  nDamage: Integer;
begin
  m_btDirection := nDir;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
  if nPower > 0 then begin
    n10 := 1;
    while (True) do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, n10, nX, nY) then begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
          SetTargetCreat(BaseObject);
          nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
          if nDamage > 0 then begin
            BaseObject.StruckDamage(nDamage, Self);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
              BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
          end;
        end;
      end;
      if n10 >= 4 then break;
      Inc(n10);
    end;
  end;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

function TGreenAraneidMon.AttackTarget: Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckBeeline(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) and
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 4) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY));
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

{ TSnowfieldWarriorMon }

procedure TSnowfieldWarriorMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  nPower: Integer;
  nX, nY, aX, aY: Integer;
  BaseObject: TBaseObject;
  nDamage: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  I: Integer;
begin
  m_btDirection := nDir;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
  if nPower > 0 then begin
    if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, aX, aY) then begin
      for nX := aX - 1 to aX + 1 do begin
        for nY := aY - 1 to aY + 1 do begin
          if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := MapCellInfo.ObjList.Items[I];
              if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                BaseObject := TBaseObject(OSObject.CellObj);
                if ((BaseObject <> nil) and (not BaseObject.m_boGhost) and (BaseObject.bo2B9)) and
                  (not BaseObject.m_boDeath) and IsProperTarget(BaseObject) then begin
                  SetTargetCreat(BaseObject);
                  nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
                  if nDamage > 0 then begin
                    BaseObject.StruckDamage(nDamage, Self);
                    BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
                      BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

function TSnowfieldWarriorMon.AttackTarget: Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 3) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 3) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY));
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

{ TSnowfieldForceMon }

function TSnowfieldForceMon.AttackTarget: Boolean;
var
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  nDamage: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  nPower: Integer;
  bt06: Byte;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        if Random(10) = 0 then begin
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
          m_btDirection := bt06;
          if nPower > 0 then begin
            for nX := m_nCurrX - 1 to m_nCurrX + 1 do begin
              for nY := m_nCurrY - 1 to m_nCurrY + 1 do begin
                if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
                  for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                    OSObject := MapCellInfo.ObjList.Items[I];
                    if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                      BaseObject := TBaseObject(OSObject.CellObj);
                      if ((BaseObject <> nil) and (not BaseObject.m_boGhost) and (BaseObject.bo2B9)) and
                        (not BaseObject.m_boDeath) and IsProperTarget(BaseObject) then begin
                        SetTargetCreat(BaseObject);
                        nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
                        if nDamage > 0 then begin
                          BaseObject.StruckDamage(nDamage, Self);
                          BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
                            BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
                        end;
                        if (Random(m_btAntiPoison + 20) = 0) then
                          BaseObject.MakePosion(POISON_STONE, g_Config.nAttackPosionTime, g_Config.nAttackPosionTime);
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
          SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
        end else
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

{ TPakNewMon }

procedure TPakNewMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
begin
  inherited;

end;

function TPakNewMon.AttackBy243(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseAttackTarget() then begin
      if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 5, Integer(m_TargetCret), '',
            1000 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
          SendRefMsg(RM_MONMAGIC, 7, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 600);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy244(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseAttackTarget() then begin
      if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 5, Integer(m_TargetCret), '',
            1000 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
          SendRefMsg(RM_MONMAGIC, 8, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 600);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy255(nDir: Integer): Boolean;
var
  btAttackMode, bt06: Byte;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    btAttackMode := 0;
    if (Random(10) = 0) and (GetCircumambienceMonCount > 1) then begin
      btAttackMode := 1;
    end else
    if GetAttackDir(m_TargetCret, bt06) then begin
      nDir := bt06;
      btAttackMode := 2;
    end{ else
    if CheckViewRange(m_TargetCret, 7) then begin
      btAttackMode := 3;
    end};  
    if btAttackMode > 0 then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        case btAttackMode of
          1: begin
              SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
              WideAttack(m_nCurrX, m_nCurrY, 3, False);
            end;
          3: begin
              SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
              //FlyWideAttack(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3);
              //SendRefMsg(RM_MONMAGIC, 6, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 400);
            end;
          2: Attack(m_TargetCret, nDir);
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
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

function TPakNewMon.AttackBy506(nDir: Integer): Boolean;
var
  nPower, nX, nY: Integer;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetTickCount > m_dwCheckRageTick then begin
      m_dwCheckRageTick := GetTickCount + 2000;
      if Random(10) < 3 then begin
        if m_PEnvir.GetXYHuman(m_nCurrX, m_nCurrY, 1) > 0 then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_SPACEMOVE_FIRE3, 0, 0, 0, 0, '');
          nX := m_nCurrX + (Random(16) - 8);
          nY := m_nCurrY + (Random(16) - 8);
          SpaceMove(m_PEnvir, nX, nY, 2);
          Result := True;
          Exit;
        end;
      end;
    end;
    if CheckViewRange(m_TargetCret, m_nViewRange) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        //self.m_PEnvir.GetXYHuman()
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        for nX := m_TargetCret.m_nCurrX - 1 to m_TargetCret.m_nCurrX + 1 do begin
          for nY := m_TargetCret.m_nCurrY - 1 to m_TargetCret.m_nCurrY + 1 do begin
            if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
              for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                OSObject := MapCellInfo.ObjList.Items[I];
                if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                  BaseObject := TBaseObject(OSObject.CellObj);
                  if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                    IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
                  begin
                      SendDelayMsg(Self, RM_DELAYMAGIC, nPower, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 3, Integer(BaseObject), '', 500);
                  end;
                end;
              end;
            end;
          end;
        end;
        SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 12, '', 360);
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

function TPakNewMon.AttackBy512(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseLongAttackTarget(nDir, 4) then begin
      if CheckViewRange(m_TargetCret, m_nViewRange) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3, Integer(m_TargetCret), '', 400);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 14, '', 300);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy515(nDir: Integer): Boolean;
var
  nPower, nX, nY, nDamage: Integer;
  BaseObject: TBaseObject;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if (not m_boDeliriaOK) and m_boDeliria then begin
      m_boDeliriaOK := True;
      m_btDirection := nDir;
      m_dwHitTick := GetTickCount() + LongWord(m_nNextHitTime);
      m_dwTargetFocusTick := GetTickCount() + LongWord(m_nNextHitTime);
      SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
      nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 2;
      for nX := m_nCurrX - 2 to m_nCurrX + 2 do begin
        for nY := m_nCurrY - 2 to m_nCurrY + 2 do begin
          if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := MapCellInfo.ObjList.Items[I];
              if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                BaseObject := TBaseObject(OSObject.CellObj);
                if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                  IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
                begin
                  nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
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
      BreakHolySeizeMode();
      Result := True;
      Exit;
    end;
    Result := BaseLongAttackTarget(nDir, 3);
  end;
end;

function TPakNewMon.AttackBy516(nDir: Integer): Boolean;
var
  nPower, nX, nY, nDamage: Integer;
  BaseObject: TBaseObject;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckViewRange(m_TargetCret, 7) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount() + LongWord(m_nNextHitTime);
        m_dwTargetFocusTick := GetTickCount() + LongWord(m_nNextHitTime);
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        if m_boDeliria then begin
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          for i := 0 to m_VisibleActors.Count - 1 do begin
            BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
            if BaseObject = nil then Continue;
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
              IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
            begin
              SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 16, '', 100);
              nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                  BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
              end;
              if BaseObject.m_wStatusTimeArr[POISON_DECHEALTH] <= 0 then begin
                BaseObject.SendDelayMsg(Self, RM_POISON, POISON_DECHEALTH, nPower, Integer(Self),
                  ROUND(nPower / g_Config.nAmyOunsulPoint), 0,'', 400);
              end;
            end;
          end;
        end else begin
          SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 15, '', 100);
          for nX := m_TargetCret.m_nCurrX - 1 to m_TargetCret.m_nCurrX + 1 do begin
            for nY := m_TargetCret.m_nCurrY - 1 to m_TargetCret.m_nCurrY + 1 do begin
              if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
                for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                  OSObject := MapCellInfo.ObjList.Items[I];
                  if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                    BaseObject := TBaseObject(OSObject.CellObj);
                    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                      IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
                    begin
                      nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
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
        end;
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
 { Result := False;
  if m_TargetCret <> nil then begin
    if (not m_boDeliriaOK) and m_boDeliria then begin
      m_boDeliriaOK := True;
      m_btDirection := nDir;
      m_dwHitTick := GetTickCount() + LongWord(m_nNextHitTime);
      m_dwTargetFocusTick := GetTickCount() + LongWord(m_nNextHitTime);
      SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
      nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 2;
      for nX := m_nCurrX - 2 to m_nCurrX + 2 do begin
        for nY := m_nCurrY - 2 to m_nCurrY + 2 do begin
          if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := MapCellInfo.ObjList.Items[I];
              if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                BaseObject := TBaseObject(OSObject.CellObj);
                if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                  IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
                begin
                  nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
                  if nDamage > 0 then begin
                    BaseObject.StruckDamage(nDamage, Self);
                    BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                      BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
      BreakHolySeizeMode();
      Result := True;
      Exit;
    end;
    Result := BaseLongAttackTarget(nDir, 3);
  end;}
end;

function TPakNewMon.AttackBy526(nDir: Integer): Boolean;
var
  nPower, nX, nY: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetTickCount > m_dwCheckRageTick then begin
      m_dwCheckRageTick := GetTickCount + 2000;
      if Random(10) < 3 then begin
        if m_PEnvir.GetXYHuman(m_nCurrX, m_nCurrY, 1) > 0 then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_SPACEMOVE_FIRE3, 0, 0, 0, 0, '');
          nX := m_nCurrX + (Random(16) - 8);
          nY := m_nCurrY + (Random(16) - 8);
          SpaceMove(m_PEnvir, nX, nY, 2);
          Result := True;
          Exit;
        end;
      end;
    end;
    if CheckViewRange(m_TargetCret, m_nViewRange) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3, Integer(m_TargetCret), '', 400);

        SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 21, '', 360);
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

function TPakNewMon.AttackBy527(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if m_boDeliria and (not m_boDeliriaOK) then begin
      m_boDeliriaOK := True;
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
      BreakHolySeizeMode();
      Result := True;
      Exit;
    end;
    if not BaseAttackTarget() then begin
      if m_boDeliria and CheckViewRange(m_TargetCret, m_nViewRange) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3, Integer(m_TargetCret), '', 400);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 22, '', 360);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy534(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseAttackTarget() then begin
      if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 5, Integer(m_TargetCret), '',
            1000 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
          SendRefMsg(RM_MONMAGIC, 1, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 600);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy535(nDir: Integer): Boolean;
var
  nPower: Integer;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if m_boDeliria then begin
      if CheckViewRange(m_TargetCret, 7) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendAttackMsg(RM_HIT, SM_HIT_4, m_btDirection, m_nCurrX, m_nCurrY);
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          for i := 0 to m_VisibleActors.Count - 1 do begin
            BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
              IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
            begin
              SendDelayMsg(Self, RM_DELAYMAGIC, nPower, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 5, Integer(BaseObject), '', 700);
              SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 24, '', 600);
            end;
          end;
          BreakHolySeizeMode();
        end;
        Result := True;
        Exit;
      end;
    end;
    if not BaseLongAttackTarget(nDir, 4) then begin
      if CheckViewRange(m_TargetCret, 6) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 5, Integer(m_TargetCret), '', 700);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 23, '', 600);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy542(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 5, Integer(m_TargetCret), '',
          800 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
        SendRefMsg(RM_MONMAGIC, 2, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 600);
        BreakHolySeizeMode();
      end;
      Result := True;
      Exit;
    end;
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
    end
    else begin
      DelTargetCreat(); {0FFF1h}
    end;
  end;
end;

function TPakNewMon.AttackBy543(nDir: Integer): Boolean;
var
  nPower, n14: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 5, Integer(m_TargetCret), '',
          800 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
        SendRefMsg(RM_MONMAGIC, 3, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 600);
        BreakHolySeizeMode();
      end;
      Result := True;
      Exit;
    end;
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) then begin
        n14 := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
        m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
        SetTargetXY(m_nTargetX, m_nTargetY);
      end else
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    end
    else begin
      DelTargetCreat(); {0FFF1h}
    end;
  end;
end;

function TPakNewMon.AttackBy544(nDir: Integer): Boolean;
var
  nPower, nDamage: Integer;
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if m_boDeliria and (not m_boDeliriaOK) then begin
      m_boDeliriaOK := True;
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
      nPower := Round(GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 1.5);
      for nX := m_nCurrX - 3 to m_nCurrX + 3 do begin
        for nY := m_nCurrY - 3 to m_nCurrY + 3 do begin
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
                      BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
      BreakHolySeizeMode();
      Result := True;
      Exit;
    end;
    Result := BaseLongAttackTarget(nDir, 4);
  end;
end;

function TPakNewMon.AttackBy545(nDir: Integer): Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    Result := BaseLongAttackTarget(nDir, 2);
    if not Result then Result := BaseLongMsgTarget(nDir, 5, SM_LIGHTING);
  end;
end;

function TPakNewMon.AttackBy546(nDir: Integer): Boolean;
var
  nPower: Integer;
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseLongAttackTarget(nDir, 2) then begin
      if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendRefMsg(RM_MONMAGIC, 4, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 400);
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
                      SendDelayMsg(Self, RM_DELAYMAGIC, nPower, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 3, Integer(BaseObject), '',
                        800 + (abs(BaseObject.m_nCurrX - m_nCurrX) + abs(BaseObject.m_nCurrY - m_nCurrY)) div 2 * 20);
                    end;
                  end;
                end;
              end;
            end;
          end;
          BreakHolySeizeMode();
        end;
        Result := True;
        Exit;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy547(nDir: Integer): Boolean;
var
  nPower, nDamage: Integer;
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetCircumambienceMonCount > 1 then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        for nX := m_nCurrX - 2 to m_nCurrX + 2 do begin
          for nY := m_nCurrY - 2 to m_nCurrY + 2 do begin
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
                        BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 500);
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
      Exit;
    end;
    Result := BaseLongAttackTarget(nDir, 2);
  end;
end;

function TPakNewMon.AttackBy548(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseLongAttackTarget(nDir, 2) then begin
      if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendRefMsg(RM_MONMAGIC, 5, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 400);
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3, Integer(m_TargetCret), '',
            800 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
          BreakHolySeizeMode();
        end;
        Result := True;
        Exit;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy555(nDir: Integer): Boolean;
const
  WideAttack: array[0..2] of Byte = (7, 0, 1);
var
  nC, n10, nCount, nPower, nDamage: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
  bt06: Byte;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := bt06;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        nC := 0;
        nCount := 0;
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        while (True) do begin
          n10 := (m_btDirection + WideAttack[nC]) mod 8;
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then begin
            BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
              Inc(nCount);
              nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, BaseObject.m_WAbil.HP,
                  BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 400);
              end;
            end;
          end;
          Inc(nC);
          if nC >= 3 then break;
        end;
        if nCount > 1 then SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '')
        else SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

function TPakNewMon.AttackBy557(nDir: Integer): Boolean;
var
  bt06: Byte;
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if m_boDeliria and (not m_boDeliriaOK) then begin
      m_btDirection := nDir;
      m_boDeliriaOK := True;
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
      BreakHolySeizeMode();
      Result := True;
      Exit;
    end else
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        if m_boDeliria then nPower := Round(m_TargetCret.GetHitStruckDamage(Self, nPower) * 2);
        if nPower > 0 then begin
          m_TargetCret.StruckDamage(nPower, Self);
          m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower,
            m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
        end;
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
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

function TPakNewMon.AttackBy560(nDir: Integer): Boolean;
var
  nPower, nDamage: Integer;
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetCircumambienceMonCount > 1 then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
        nPower := Round(GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 1.5);
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
                    nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
                    if nDamage > 0 then begin
                      BaseObject.StruckDamage(nDamage, Self);
                      BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                        BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 400);
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
      Exit;
    end;
    Result := BaseLongAttackTarget(nDir, 2);
  end;
end;

function TPakNewMon.AttackBy563(nDir: Integer): Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseAttackTarget() then begin
      Result := BaseLongAttackTarget(nDir, 3, RM_LIGHTING);
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy564(nDir: Integer): Boolean;
var
  nPower, nDamage: Integer;
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetCircumambienceMonCount > 1 then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
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
                    nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
                    if nDamage > 0 then begin
                      BaseObject.StruckDamage(nDamage, Self);
                      BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                        BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 600);
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
      Exit;
    end;
    if m_boDeliriaOK then Result := BaseAttackTarget()
    else Result := BaseAttackTarget(RM_LIGHTING);

  end;
end;

function TPakNewMon.AttackBy568(nDir: Integer): Boolean;
var
  nX, nY, i, nDamage: Integer;
  btDir: Byte;
  PoseCreate: TBaseObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      if (GetCircumambienceMonCount > 1) and GetAttackDir(m_TargetCret, btDir) then begin
        if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, btDir, 2, nX, nY) then begin
          if m_PEnvir.GetMovingObject(nX, nY, True) = nil then begin
            m_btDirection := btDir;
            for i := 0 to 2 do begin
              PoseCreate := GetPoseCreate();
              if PoseCreate <> nil then begin
                if PoseCreate.CharPushed(m_btDirection, 1) <> 1 then break;
                GetFrontPosition(nX, nY);
                if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False) > 0 then begin
                  m_nCurrX := nX;
                  m_nCurrY := nY;
                  GetStartType();
                  SendRefMsg(RM_RUSH, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
                  Result := True;
                end else break;
              end;
            end;
          end;
        end;
      end;
      if Result then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        nDamage := m_TargetCret.GetHitStruckDamage(Self, GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)))) div 2;
        if nDamage > 0 then begin
          m_TargetCret.StruckDamage(nDamage, Self);
          m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
            m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), 0,'', 800);
        end;
        BreakHolySeizeMode();
        Exit;
      end;
    end;
    Result := BaseAttackTarget();
  end;
end;

function TPakNewMon.AttackByMagic(nDir, nMagId: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseAttackTarget() then begin
      if CheckViewRange(m_TargetCret, m_nViewRange) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3, Integer(m_TargetCret), '', 400);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, nMagId, '', 360);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackTarget: Boolean;
var
  nAttackDir: byte;
begin
  Result := False;
  if (m_TargetCret = nil) or (not IsProperTarget(m_TargetCret)) then Exit;
  nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  case m_wAppr of
    243: Result := AttackBy243(nAttackDir);
    255: Result := AttackBy255(nAttackDir);
    331, 332: Result := AttackBy244(nAttackDir);
    501: Result := AttackByMagic(nAttackDir, 9);
    504: Result := AttackByMagic(nAttackDir, 10);
    505: Result := AttackByMagic(nAttackDir, 11);
    506: Result := AttackBy506(nAttackDir);
    510: Result := AttackByMagic(nAttackDir, 13);
    512: Result := AttackBy512(nAttackDir);
    513: Result := BaseLongAttackTarget(nAttackDir, 4);
    515: Result := AttackBy515(nAttackDir);
    516: Result := AttackBy516(nAttackDir);
    518: Result := BaseDoubleAttack(nAttackDir);
    525, 320: Result := BaseLongAttackTarget(nAttackDir, 3);
    526, 321: Result := AttackBy526(nAttackDir);
    527, 322: Result := AttackBy527(nAttackDir);
    534, 280: Result := AttackBy534(nAttackDir);
    535: Result := AttackBy535(nAttackDir);
    542: Result := AttackBy542(nAttackDir);
    543: Result := AttackBy543(nAttackDir);
    544: Result := AttackBy544(nAttackDir);
    545: Result := AttackBy545(nAttackDir);
    546: Result := AttackBy546(nAttackDir);
    547: Result := AttackBy547(nAttackDir);
    548: Result := AttackBy548(nAttackDir);
    555: Result := AttackBy555(nAttackDir);
    556: Result := BaseDoubleMagAttack(nAttackDir, 27, 28);
    557: Result := AttackBy557(nAttackDir);
    558: Result := BaseLongAttackTarget(nAttackDir, 2, RM_LIGHTING);
    560: Result := AttackBy560(nAttackDir);
    563: Result := AttackBy563(nAttackDir);
    564: Result := AttackBy564(nAttackDir);
    565, 566, 567: Result := BaseDoubleAttack(nAttackDir);
    568: Result := AttackBy568(nAttackDir);
    else Result := inherited AttackTarget;
  end;
end;

function TPakNewMon.BaseAttackTarget(nCmd: Integer): Boolean;
var
  bt06: Byte;
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        if nCmd = RM_LIGHTING then begin
          SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          nPower := Round(m_TargetCret.GetHitStruckDamage(Self, nPower) * 1.5);
          if nPower > 0 then begin
            m_TargetCret.StruckDamage(nPower, Self);
            m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower,
              m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
          end;
        end else
          Attack(m_TargetCret, bt06); //FFED
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else begin
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

function TPakNewMon.BaseDoubleAttack(nDir: Integer): Boolean;
var
  bt06: Byte;
  nPower, nDamage: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        m_btDirection := bt06;
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        if not m_boDeliriaOK then nPower := nPower * 2;
        nDamage := m_TargetCret.GetHitStruckDamage(Self, nPower);
        if nDamage > 0 then begin
          m_TargetCret.StruckDamage(nDamage, Self);
          m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, m_TargetCret.m_WAbil.HP,
            m_TargetCret.m_WAbil.MaxHP, Integer(Self), 0,'', 200);
        end;
        if not m_boDeliriaOK then SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '')
        else SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else begin
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

function TPakNewMon.BaseDoubleMagAttack(nDir, nMID1, nMID2: Integer): Boolean;
var
  nPower, nDamage: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckViewRange(m_TargetCret, m_nViewRange) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        m_btDirection := nDir;
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        if not m_boDeliriaOK then nPower := nPower * 2;
        nDamage := m_TargetCret.GetMagStruckDamage(Self, nPower);
        if nDamage > 0 then begin
          m_TargetCret.StruckDamage(nDamage, Self);
          m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, m_TargetCret.m_WAbil.HP,
            m_TargetCret.m_WAbil.MaxHP, Integer(Self), 0,'', 500);
        end;
        if not m_boDeliriaOK then begin
          SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, nMID2, '', 400);
        end
        else begin
          SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, nMID1, '', 400);
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

function TPakNewMon.BaseLongAttackTarget(btDir, btRate: Byte; nCmd: Integer = SM_HIT): Boolean;
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
        if nCmd = RM_LIGHTING then SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '')
        else SendAttackMsg(RM_HIT, nCmd, m_btDirection, m_nCurrX, m_nCurrY);
        //Attack(m_TargetCret, btDir); //FFED
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

function TPakNewMon.BaseLongMsgTarget(btDir, btRate: Byte; nCmd: Integer): Boolean;
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
        SendRefMsg(RM_LIGHTING, btDir, 0, 0, Integer(m_TargetCret), '');
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        for I := 1 to btRate do begin
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nX, nY) then begin
            BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
              nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, BaseObject.m_WAbil.HP,
                  BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 500);
              end;
            end;
          end;
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TPakNewMon.BeginDeliria;
begin
  if m_boCanDeliria then begin
    m_nNextHitTime := 700;
    m_nWalkSpeed := 400;
  end;
  m_boDeliriaOK := False;
end;

function TPakNewMon.CheckViewRange(Targe: TBaseObject; nViewRange: Integer): Boolean;
begin
  Result := False;
  if (Targe <> nil) and (abs(m_nCurrX - Targe.m_nCurrX) <= nViewRange) and (abs(m_nCurrY - Targe.m_nCurrY) <= nViewRange) then
    Result := True;
end;

constructor TPakNewMon.Create;
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_dwCheckRageTick := GetTickCount;
  m_boDeliriaOK := True;
  m_boCanDeliria := False;
  m_boIsFirst := True;
  {if m_wAppr = 558 then begin
    m_boFixedHideMode := True;
    m_boNoAttackMode := True;
  end;   }
end;

procedure TPakNewMon.Die;
var
  I, nPower, nX, nY, nDamage: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  if (m_wAppr = 561) then begin
    SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
    nPower := Round(GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 1.5);
    for nX := m_nCurrX - 2 to m_nCurrX + 2 do begin
      for nY := m_nCurrY - 2 to m_nCurrY + 2 do begin
        if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := MapCellInfo.ObjList.Items[I];
            if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
              begin
                nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
                if nDamage > 0 then begin
                  BaseObject.StruckDamage(nDamage, Self);
                  BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                    BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 1200);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end else
  if (m_wAppr = 560) then begin
    nPower := Round(GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 1.5);
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
                BaseObject.SendDelayMsg(Self, RM_POISON, POISON_DECHEALTH, nPower, Integer(Self), ROUND(nPower / g_Config.nAmyOunsulPoint), 0,'', 600);
              end;
            end;
          end;
        end;
      end;
    end;
  end else
  if (m_wAppr = 526) then begin
    nPower := Round(GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 1.5);
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
                nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
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
  end;
  inherited Die;
end;

procedure TPakNewMon.EndDeliria;
begin
  if m_boCanDeliria then begin
    m_nNextHitTime := m_dwNextHitTime;
    m_nWalkSpeed := m_nWalkSpeed;
  end;
  m_boDeliriaOK := True;
end;
     {
procedure TPakNewMon.FirstEffect;
begin
  if m_wAppr = 558 then begin
    SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
  end;
end;         }

function TPakNewMon.GetCircumambienceMonCount(btRate: Byte): Integer;
var
  i: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
      (BaseObject.m_PEnvir = m_PEnvir) and (abs(BaseObject.m_nCurrX - m_nCurrX) <= btRate) and (abs(BaseObject.m_nCurrY - m_nCurrY) <= btRate) then begin
      if (not BaseObject.m_boHideMode or m_boCoolEye) and IsProperTarget(BaseObject) then
        Inc(Result);
    end;
  end;
end;

procedure TPakNewMon.Initialize;
begin
  inherited Initialize;
  if (m_wAppr = 512) or (m_wAppr = 535) then m_nViewRange := 7;
  if (m_wAppr = 515) or (m_wAppr = 516) or (m_wAppr = 535) then begin
    m_boRandomMove := True;
    m_boCanDeliria := True;
  end;
  if (m_wAppr = 527) or (m_wAppr = 322) or (m_wAppr = 544) or (m_wAppr = 557) then begin
    m_boCanDeliria := True;
  end;
end;

procedure TPakNewMon.Run;
begin
  if (not m_boDeath) and (not bo554) and (not m_boGhost) and CanWork then begin
    {if m_boIsFirst then begin
      m_boIsFirst := False;
      m_boFixedHideMode := False;
      FirstEffect();
    end;   }
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;

function TPakNewMon.WideAttack(nSX, nSY: Integer; nRate: Byte; boMagic: Boolean): Boolean;
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

{ TPillarMonster }

constructor TPillarMonster.Create;
begin
  inherited;
  m_nViewRange := 2;
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
end;

destructor TPillarMonster.Destroy;
begin

  inherited;
end;

procedure TPillarMonster.Initialize;
begin
  inherited;
  m_Abil.Level := High(Word);
end;

procedure TPillarMonster.Run;
var
  i: Integer;
  BaseObject: TBaseObject;
  TargeTBaseObject: TBaseObject;
  WAbil: pTAbility;
  nDamage, nPower: Integer;
begin
  TargeTBaseObject := nil;
  m_TargetCret := nil;
  if not m_boGhost and not m_boDeath and not m_boFixedHideMode and not m_boStoneMode and CanWork then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      WAbil := @m_WAbil;
      nDamage := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
      if nDamage > 0 then begin
        for i := 0 to m_VisibleActors.Count - 1 do begin
          BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
          if BaseObject.m_boDeath then Continue;
          if IsProperTarget(BaseObject) and ((not BaseObject.m_boHideMode) or m_boCoolEye) then begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) < 3) and (abs(m_nCurrY - BaseObject.m_nCurrY) < 3) and (m_PEnvir = BaseObject.m_PEnvir) then begin
              TargeTBaseObject := BaseObject;
              nPower := BaseObject.GetMagStruckDamage(Self, nDamage);
              if nPower > 0 then begin
                BaseObject.StruckDamage(nPower, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'', 100);
              end;
            end;
          end;
        end;
      end;
      if TargeTBaseObject <> nil then
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
      BreakHolySeizeMode();
    end;
  end;
  inherited;
end;

end.
