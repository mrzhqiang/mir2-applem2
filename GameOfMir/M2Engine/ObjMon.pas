unit ObjMon;

interface
uses
  Windows, Classes, SysUtils, Grobal2, ObjBase;
type
  TMonster = class(TAnimalObject)
    n54C: Integer; //0x54C
    m_dwThinkTick: LongWord; //0x550
    bo554: Boolean; //0x554
    m_boDupMode: Boolean; //0x555
  private
    function Think: Boolean;
    function MakeClone(sMonName: string; OldMon: TBaseObject): TBaseObject;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    function AttackTarget(): Boolean; virtual; //FFEB
    procedure Run; override;
  end;

  TDoubleATKMonster = class(TMonster)
    m_dwNextHitTime: LongWord;
    m_nWalkSpeed: Integer;
    m_dwCheckTick: LongWord;
    m_dwDeliriaTime: LongWord;
    m_boDeliria: Boolean;
    m_boAutoSearch: Boolean;
    m_boRandomMove: Boolean;
    n560: Integer;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Initialize(); override;
    procedure BeginDeliria; virtual;
    procedure EndDeliria; virtual;
  end;


  TChickenDeer = class(TMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TDrunkardMonster = class(TMonster)
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function GetShowName(): string; override;
  end;

  THorseMonster = class(TMonster)
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function GetShowName(): string; override;
    procedure OrdinaryAttack(BaseObject: TBaseObject); override;
  end;

  TATMonster = class(TMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TSlowATMonster = class(TATMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TScorpion = class(TATMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TSpitSpider = class(TATMonster)
    m_boUsePoison: Boolean;
  private
    procedure SpitAttack(btDir: Byte); virtual;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override; //FFEB
  end;
  THighRiskSpider = class(TSpitSpider)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TBigPoisionSpider = class(TSpitSpider)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TBlackPoisionSpider = class(TSpitSpider)
  private
    procedure SpitAttack(btDir: Byte); override;
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TGasAttackMonster = class(TATMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget: Boolean; override;
    function sub_4A9C78(bt05: Byte): TBaseObject; virtual; //FFEA
  end;
  TCowMonster = class(TATMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TMagCowMonster = class(TATMonster)
  private
    procedure sub_4A9F6C(btDir: Byte);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget: Boolean; override;
  end;
  TCowKingMonster = class(TATMonster)
    dw558: LongWord;
    bo55C: Boolean;
    bo55D: Boolean;
    n560: Integer;
    dw564: LongWord;
    dw568: LongWord;
    dw56C: LongWord;
    n570: Integer;
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
    procedure Initialize(); override;
  end;
  {TElectronicScolpionMon = class(TMonster)
  private
    m_boUseMagic: Boolean;
    procedure LightingAttack(nDir: Integer);

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;    }
  TLightingZombi = class(TMonster)
  private
    procedure LightingAttack(nDir: Integer);

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TDigOutZombi = class(TMonster)
  private
    procedure sub_4AA8DC;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TZilKinZombi = class(TATMonster)
    dw558: LongWord;
    nZilKillCount: Integer;
    dw560: LongWord;
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Die; override;
    procedure Run; override;
    procedure MakeGhost; override;
  end;
  TWhiteSkeleton = class(TATMonster)
    m_boIsFirst: Boolean;
  private
    procedure sub_4AAD54;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    procedure Run; override;
  end;

  TMoonMonster = class(TATMonster)
    m_dwCheckRageTick: LongWord;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;

  TScultureMonster = class(TMonster)
  private
    procedure MeltStone; //
    procedure MeltStoneAll;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Initialize(); override;
  end;

  TFiredrakeGeneralMonster = class(TScultureMonster)
  private
    dwNextHitTime: LongWord;
    nWalkSpeed: Integer;
    dwCheckTick: LongWord;
    dwDeliriaTime: LongWord;
    boDeliria: Boolean;
    n560: Integer;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override; //FFEB
    procedure Run; override;
    procedure Initialize(); override;
  end;

  TSnowfieldKavassMon = class(TScultureMonster)
    m_boEspecial: Boolean;
  public
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TScultureKingMonster = class(TMonster)
    m_nDangerLevel: Integer;
    m_SlaveObjectList: TList; //0x55C
  private
    procedure MeltStone;
    procedure CallSlave;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
      //0FFED
    procedure Run; override;
  end;
  TGasMothMonster = class(TGasAttackMonster) //楔蛾
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function sub_4A9C78(bt05: Byte): TBaseObject; override; //FFEA
  end;
  TGasDungMonster = class(TGasAttackMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TElfMonster = class(TMonster)
    boIsFirst: Boolean; //0x558
    nMasterHP: Integer;
  private
    procedure AppearNow;
    procedure ResetElfMon;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    procedure Run; override;
  end;
  TElfWarriorMonster = class(TSpitSpider)
    n55C: Integer;
    boIsFirst: Boolean; //0x560
    dwDigDownTick: LongWord; //0x564
  private
    procedure AppearNow;
    procedure ResetElfMon;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    procedure Run; override;
  end;

  TCamionMonster = class(TAnimalObject)
    m_sMasterName: string;
    m_MasterGhostTick: LongWord;
    m_nMasterIndex: Integer;
  private
    m_boHintMaster: Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Die; override;
    function GetShowName(): string; override;
    function GetNamecolor: Byte; override;
    function AttackTarget(): Boolean; virtual; //FFEB
  end;
implementation

uses UsrEngn, M2Share, Event, ObjPlay, Hutil32;
{ TMonster }

constructor TMonster.Create;
begin
  inherited;
  m_boDupMode := False;
  bo554 := False;
  m_dwThinkTick := GetTickCount();
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 80;
end;

destructor TMonster.Destroy;
begin
  inherited;
end;

function TMonster.MakeClone(sMonName: string; OldMon: TBaseObject): TBaseObject;
var
  ElfMon: TBaseObject;
begin
  Result := nil;
  ElfMon := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, m_nCurrX, m_nCurrY, sMonName);
  if ElfMon <> nil then begin
    ElfMon.m_Master := OldMon.m_Master;
    ElfMon.m_nSlaveMagIndex := OldMon.m_nSlaveMagIndex;
    ElfMon.m_dwMasterRoyaltyTick := OldMon.m_dwMasterRoyaltyTick;
    ElfMon.m_btSlaveMakeLevel := OldMon.m_btSlaveMakeLevel;
    ElfMon.m_btSlaveExpLevel := OldMon.m_btSlaveExpLevel;
    ElfMon.RecalcAbilitys;
    ElfMon.RefNameColor;
    if OldMon.m_Master <> nil then begin
      OldMon.m_Master.m_SlaveList.Add(ElfMon);
      ElfMon.m_btWuXin := 0;
    end;
    ElfMon.m_WAbil := OldMon.m_WAbil;
    ElfMon.m_wStatusTimeArr := OldMon.m_wStatusTimeArr;
    Elfmon.m_dwStatusArrTick := OldMon.m_dwStatusArrTick;
    ElfMon.m_TargetCret := OldMon.m_TargetCret;
    ElfMon.m_dwTargetFocusTick := OldMon.m_dwTargetFocusTick;
    ElfMon.m_LastHiter := OldMon.m_LastHiter;
    ElfMon.m_LastHiterTick := OldMon.m_LastHiterTick;
    ElfMon.m_btDirection := OldMon.m_btDirection;
    Result := ElfMon;
  end;
end;

function TMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);

end;

function TMonster.Think(): Boolean; //004A8E54
var
  nOldX, nOldY: Integer;
begin
  Result := False;
  if (GetTickCount - m_dwThinkTick) > 3 * 1000 then begin
    m_dwThinkTick := GetTickCount();
    if m_PEnvir.GetXYObjCount(m_nCurrX, m_nCurrY) >= 2 then
      m_boDupMode := True;
    if not IsProperTarget {FFFF4}(m_TargetCret) then
      m_TargetCret := nil;
  end; //004A8ED2
  if m_boDupMode then begin
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;
    WalkTo(Random(8), False);
    if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then begin
      m_boDupMode := False;
      Result := True;
    end;
  end;
end;

function TMonster.AttackTarget(): Boolean; //004A8F34
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

procedure TMonster.Run;
var
  nX, nY: Integer;
begin
  MeltTargetAll;
  if not m_boGhost and not m_boDeath and not m_boFixedHideMode and not m_boStoneMode and CanWork then begin

    if Think then begin
      inherited;
      Exit;
    end;
    if m_boWalkWaitLocked then begin
      if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then begin
        m_boWalkWaitLocked := False;
      end;
    end;
    if not m_boWalkWaitLocked and (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
      m_dwWalkTick := GetTickCount();
      Inc(m_nWalkCount);
      if m_nWalkCount > m_nWalkStep then begin
        m_nWalkCount := 0;
        m_boWalkWaitLocked := True;
        m_dwWalkWaitTick := GetTickCount();
      end; //004A9151
      if not m_boRunAwayMode then begin
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            if AttackTarget {FFEB} then begin
              inherited;
              Exit;
            end;
          end
          else begin
            m_nTargetX := -1;
            if m_boMission then begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end; //004A91D3
          end;
        end; //004A91D3  if not bo2C0 then begin
        if m_Master <> nil then begin
          if m_PEnvir.m_boFB and (m_PEnvir <> m_Master.m_PEnvir) then begin
            m_Master.GetBackPosition(nX, nY);
            if (abs(m_nTargetX - nX) > 1) or (abs(m_nTargetY - nY {nX}) > 1) then begin
              m_nTargetX := nX;
              m_nTargetY := nY;
              if (abs(m_nCurrX - nX) <= 2) and (abs(m_nCurrY - nY) <= 2) then
                begin
                if m_PEnvir.GetMovingObject(nX, nY, True) <> nil then begin
                  m_nTargetX := m_nCurrX;
                  m_nTargetY := m_nCurrY;
                end;
              end;
            end;
            SpaceMove(m_Master.m_PEnvir, m_nTargetX, m_nTargetY, 1);
            if m_Master.m_boSlaveRelax then m_Master.SysMsg('副本不能滞留宠物！', c_Red, t_Hint);
          end else begin
            if m_TargetCret = nil then begin
              m_Master.GetBackPosition(nX, nY);
              if (abs(m_nTargetX - nX) > 1) or (abs(m_nTargetY - nY {nX}) > 1) then begin
                m_nTargetX := nX;
                m_nTargetY := nY;
                if (abs(m_nCurrX - nX) <= 2) and (abs(m_nCurrY - nY) <= 2) then
                  begin
                  if m_PEnvir.GetMovingObject(nX, nY, True) <> nil then begin
                    m_nTargetX := m_nCurrX;
                    m_nTargetY := m_nCurrY;
                  end //004A92A5
                end;
              end; //004A92A5
            end; //004A92A5 if m_TargetCret = nil then begin
            if (not m_Master.m_boSlaveRelax) and
              ((m_PEnvir <> m_Master.m_PEnvir) or
              (abs(m_nCurrX - m_Master.m_nCurrX) > 20) or
              (abs(m_nCurrY - m_Master.m_nCurrY) > 20)) then begin
              SpaceMove(m_Master.m_PEnvir, m_nTargetX, m_nTargetY, 1);
            end; // 004A937E
          end;
        end; // 004A937E if m_Master <> nil then begin
      end
      else begin //004A9344
        if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) > m_dwRunAwayTime) then begin
          m_boRunAwayMode := False;
          m_dwRunAwayTime := 0;
        end;
      end; //004A937E
      if (m_Master <> nil) and m_Master.m_boSlaveRelax then begin
        inherited;
        Exit;
      end; //004A93A6
      if m_nTargetX <> -1 then begin
        GotoTargetXY(); //004A93B5 0FFEF
      end
      else begin
        if (m_TargetCret = nil) and (not m_PEnvir.m_boFB) then
          Wondering(); // FFEE   //Jacky
      end; //004A93D8
    end; //004A93D8  if not bo510 and ((GetTickCount - m_dwWalkTick) > n4FC) then begin
  end; //004A93D8

  inherited;

end;

{ TChickenDeer }

constructor TChickenDeer.Create; //004A93E8
begin
  inherited;
  m_nViewRange := 5;
end;

destructor TChickenDeer.Destroy;
begin
  inherited;
end;

procedure TChickenDeer.Run; //004A9438
var
  I: Integer;
  nC, n10, n14 {, n1C}: Integer;
  BaseObject1C, BaseObject: TBaseObject;
begin
  n10 := 9999;
  BaseObject := nil;
  BaseObject1C := nil;
  if (not m_boDeath) and (not bo554) and (not m_boGhost) and CanWork then begin
    if (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then Continue;
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
            if nC < n10 then begin
              n10 := nC;
              BaseObject1C := BaseObject;
            end;
          end;
        end;
      end; // for
      if BaseObject1C <> nil then begin
        m_boRunAwayMode := True;
        m_TargetCret := BaseObject1C;
      end
      else begin
        m_boRunAwayMode := False;
        m_TargetCret := nil;
      end;
    end; //
    if m_boRunAwayMode and (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
      if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 4) and (abs(m_nCurrX - BaseObject.m_nCurrX) <= 4) then begin
        n14 := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
        m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
      end;
    end;
  end;
  inherited;

end;

{ TATMonster }

constructor TATMonster.Create; //004A9690
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TATMonster.Destroy;
begin

  inherited;
end;

procedure TATMonster.Run; //004A9720
begin
  if not m_boDeath and not bo554 and not m_boGhost and CanWork then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
      (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;

{ TSlowATMonster }

constructor TSlowATMonster.Create; //004A97AC
begin
  inherited;
end;

destructor TSlowATMonster.Destroy;
begin

  inherited;
end;

{ TScorpion }

constructor TScorpion.Create; //004A97F0
begin
  inherited;
  m_boAnimal := True;
end;

destructor TScorpion.Destroy;
begin

  inherited;
end;

{ TSpitSpider }

constructor TSpitSpider.Create; //004A983C
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_boAnimal := True;
  m_boUsePoison := True;
end;

destructor TSpitSpider.Destroy;
begin

  inherited;
end;

procedure TSpitSpider.SpitAttack(btDir: Byte); //004A98AC
var
  WAbil: pTAbility;
  nC, n10, n14, n18, n1C: Integer;
  BaseObject: TBaseObject;
begin
  m_btDirection := btDir;
  WAbil := @m_WAbil;
  n1C := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) +
    LoWord(WAbil.DC));
  if n1C <= 0 then
    Exit;
  //SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
  nC := 0;

  while (nC < 5) do begin
    n10 := 0;
    while (n10 < 5) do begin
      if g_Config.SpitMap[btDir, nC, n10] = 1 then begin
        n14 := m_nCurrX - 2 + n10;
        n18 := m_nCurrY - 2 + nC;
        BaseObject := m_PEnvir.GetMovingObject(n14, n18, True);
        if (BaseObject <> nil) and
          (BaseObject <> Self) and
          (IsProperTarget(BaseObject)) and
          (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
          n1C := BaseObject.GetMagStruckDamage(Self, n1C);
          if n1C > 0 then begin
            BaseObject.StruckDamage(n1C, Self);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n1C,
              m_WAbil.HP, m_WAbil.MaxHP, Integer(Self), 0,'', 300);
            if m_boUsePoison then begin
              if (Random(m_btAntiPoison + 20) = 0) then
                BaseObject.MakePosion(POISON_DECHEALTH, 30, 1);
              //if Random(2) = 0 then
              //  BaseObject.MakePosion(POISON_STONE,5,1);
            end;
          end;
        end;
      end;

      Inc(n10);
      {
      if n10 >= 5 then break;
      }
    end;
    Inc(nC);
    //if nC >= 5 then break;
  end; // while

end;

function TSpitSpider.AttackTarget: Boolean;
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then
    Exit;
  if TargetInSpitRange(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      SpitAttack(btDir);
      BreakHolySeizeMode();
    end;
    Result := True;
    Exit;
  end;
  if m_TargetCret.m_PEnvir = m_PEnvir then begin
    SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  end
  else begin
    DelTargetCreat();
  end;
end;

{ THighRiskSpider }

constructor THighRiskSpider.Create; //004A9B64
begin
  inherited;
  m_boAnimal := False;
  m_boUsePoison := False;
end;

destructor THighRiskSpider.Destroy;
begin

  inherited;
end;

{ TBigPoisionSpider }

constructor TBigPoisionSpider.Create; //004A9BBC
begin
  inherited;
  m_boAnimal := False;
  m_boUsePoison := True;
end;

destructor TBigPoisionSpider.Destroy;
begin

  inherited;
end;

{ TGasAttackMonster }

constructor TGasAttackMonster.Create; //004A9C14
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_boAnimal := True;
end;

destructor TGasAttackMonster.Destroy;
begin

  inherited;
end;

function TGasAttackMonster.sub_4A9C78(bt05: Byte): TBaseObject;
var
  WAbil: pTAbility;
  n10: Integer;
  BaseObject: TBaseObject;
begin
  Result := nil;
  m_btDirection := bt05;
  WAbil := @m_WAbil;
  n10 := Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) +
    LoWord(WAbil.DC);
  if n10 > 0 then begin
    //SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
    BaseObject := GetPoseCreate();
    if (BaseObject <> nil) and
      IsProperTarget(BaseObject) and
      (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
      n10 := BaseObject.GetMagStruckDamage(Self, n10);
      if n10 > 0 then begin
        BaseObject.StruckDamage(n10, self);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n10,
          BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'',
          300);
        if Random(BaseObject.m_btAntiPoison + 20) = 0 then begin
          BaseObject.MakePosion(POISON_STONE, 5, 0)
        end;
        Result := BaseObject;
      end;
    end;
  end;
end;

function TGasAttackMonster.AttackTarget(): Boolean; //004A9DD4
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then
    Exit;
  if GetAttackDir(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      sub_4A9C78(btDir);
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

{ TCowMonster }

constructor TCowMonster.Create; //004A9EB4
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TCowMonster.Destroy;
begin

  inherited;
end;

{ TMagCowMonster }

constructor TMagCowMonster.Create; //004A9F10
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TMagCowMonster.Destroy;
begin

  inherited;
end;

procedure TMagCowMonster.sub_4A9F6C(btDir: Byte);
var
  WAbil: pTAbility;
  n10: Integer;
  BaseObject: TBaseObject;
begin
  m_btDirection := btDir;
  WAbil := @m_WAbil;
  n10 := Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC);
  if n10 > 0 then begin
    SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
    BaseObject := GetPoseCreate();
    if (BaseObject <> nil) and
      IsProperTarget(BaseObject) and
      (m_nAntiMagic >= 0) then begin
      n10 := BaseObject.GetMagStruckDamage(Self, n10);
      if n10 > 0 then begin
        BaseObject.StruckDamage(n10, Self);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n10,
          BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), 0,'',
          300);
      end;
    end;
  end;
end;

function TMagCowMonster.AttackTarget: Boolean;
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then
    Exit;
  if GetAttackDir(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      sub_4A9F6C(btDir);
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

{ TCowKingMonster }

constructor TCowKingMonster.Create; //004AA160
begin
  inherited;
  m_dwSearchTime := Random(1500) + 500;
  dw558 := GetTickCount();
  bo2BF := True;
  n560 := 0;
  bo55C := False;
  bo55D := False;
end;

destructor TCowKingMonster.Destroy;
begin

  inherited;
end;

procedure TCowKingMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
  //004AA1F0
var
  WAbil: pTAbility;
  nPower: Integer;
begin
  WAbil := @m_WAbil;
  nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) -
    LoWord(WAbil.DC)));
  HitMagAttackTarget(TargeTBaseObject, nPower div 2, nPower div 2, True);
  //  inherited;
end;

procedure TCowKingMonster.Initialize;
begin
  dw56C := m_nNextHitTime;
  n570 := m_nWalkSpeed;
  inherited;

end;

procedure TCowKingMonster.Run; //004AA294
var
  //  I: Integer;
  n8, nC, n10: Integer;
  //  BaseObject: TBaseObject;
begin
  if (not m_boDeath) and
    (not bo554) and
    (not m_boGhost) and
    ((GetTickCount - dw558) > 30 * 1000) then begin

    dw558 := GetTickCount();
    if (m_TargetCret <> nil) and (sub_4C3538 >= 5) then begin
      m_TargetCret.GetBackPosition(n8, nC);
      if m_PEnvir.CanWalk(n8, nC, False) then begin
        SpaceMove(m_PEnvir, n8, nC, 0);
        Exit;
      end;
      MapRandomMove(m_PEnvir, 0);
      Exit;
    end;
    n10 := n560;
    n560 := 7 - m_WAbil.HP div (m_WAbil.MaxHP div 7);
    if (n560 >= 2) and (n560 <> n10) then begin
      bo55C := True;
      dw564 := GetTickCount();
    end;
    if bo55C then begin
      if (GetTickCount - dw564) < 8000 then begin
        m_nNextHitTime := 10000;
      end
      else begin
        bo55C := False;
        bo55D := True;
        dw568 := GetTickCount();
      end;
    end; //004AA43D
    if bo55D then begin
      if (GetTickCount - dw568) < 8000 then begin
        m_nNextHitTime := 500;
        m_nWalkSpeed := 400;
      end
      else begin
        bo55D := False;
        m_nNextHitTime := dw56C;
        m_nWalkSpeed := n570;
      end;
    end;
  end;
  inherited;
end;

{ TLightingZombi }

constructor TLightingZombi.Create; //004AA4B4
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TLightingZombi.Destroy;
begin

  inherited;
end;

procedure TLightingZombi.LightingAttack(nDir: Integer);
var
  nSX, nSY, nTX, nTY, nPwr: Integer;
  WAbil: pTAbility;
begin
  m_btDirection := nDir;
  SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
  if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, nDir, 1, nSX, nSY) then begin
    m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, nDir, 9, nTX, nTY);
    WAbil := @m_WAbil;
    nPwr := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) +
      LoWord(WAbil.DC));
    MagPassThroughMagic(nSX, nSY, nTX, nTY, nDir, nPwr, -1, True);
  end;
  BreakHolySeizeMode();
end;

procedure TLightingZombi.Run; //004AA604
var
  {n08,}nAttackDir: Integer;
begin
  //  n08 := 9999;
  if (not m_boDeath) and
    (not bo554) and
    (not m_boGhost) and
    CanWork and
    ((GetTickCount - m_dwSearchEnemyTick) > 8000) then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)
      then begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;
    if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) and
      (m_TargetCret <> nil) and
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and
      (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 4) then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and
        (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2) and
        (Random(3) <> 0) then begin
        inherited;
        Exit;
      end;
      GetBackPosition(m_nTargetX, m_nTargetY);
    end;
    if (m_TargetCret <> nil) and
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 6) and
      (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 6) and
      (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin

      m_dwHitTick := GetTickCount();
      nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,
        m_TargetCret.m_nCurrY);
      LightingAttack(nAttackDir);
    end;
  end;
  inherited;
end;

{ TDigOutZombi }

constructor TDigOutZombi.Create; //004AA848
begin
  inherited;
  bo554 := False;
  m_nViewRange := 7;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 95;
  m_boFixedHideMode := True;
end;

destructor TDigOutZombi.Destroy;
begin

  inherited;
end;

procedure TDigOutZombi.sub_4AA8DC;
var
  Event: TEvent;
begin
  Event := TEvent.Create(m_PEnvir, m_nCurrX, m_nCurrY, 1, 5 * 60 * 1000, True);
  g_EventManager.AddEvent(Event);
  m_boFixedHideMode := False;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, Integer(Event), '');
end;

procedure TDigOutZombi.Run; //004AA95C
var
  I: Integer;
  //  n10: Integer;
  BaseObject: TBaseObject;
begin
  if (not m_boGhost) and
    (not m_boDeath) and
    CanWork and
    (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
    //    n10 := 0;
    if m_boFixedHideMode then begin
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject :=
          TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then
          Continue;
        if BaseObject.m_boDeath then
          Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 3) and (abs(m_nCurrY -
              BaseObject.m_nCurrY) <= 3) then begin
              sub_4AA8DC();
              m_dwWalkTick := GetTickCount + 1000;
              break;
            end;
          end;
        end;
      end; // for
    end
    else begin //004AB0C7
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil))
          then begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();
      end;
    end;
  end;
  inherited;
end;

{ TZilKinZombi }

constructor TZilKinZombi.Create;
begin
  inherited;
  m_nViewRange := 6;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 96;
  nZilKillCount := 0;
  if Random(3) = 0 then begin
    nZilKillCount := Random(3) + 1;
  end;
end;

destructor TZilKinZombi.Destroy;
begin
  inherited;

end;

procedure TZilKinZombi.Die;
begin
  inherited;
  m_boReliveNoDrop := True;
  if nZilKillCount > 0 then begin
    dw558 := GetTickCount();
    dw560 := (Random(20) + 4) * 1000;
  end;
  Dec(nZilKillCount);
end;

procedure TZilKinZombi.MakeGhost;
begin
  inherited;
  m_boReliveNoDrop := False;
end;

procedure TZilKinZombi.Run; //004AABE4
begin
  if m_boDeath and
    (not m_boGhost) and
    (nZilKillCount >= 0) and
    CanWork and
    (m_VisibleActors.Count > 0) and
    ((GetTickCount - dw558) >= dw560) then begin
    m_Abil.MaxHP := m_Abil.MaxHP shr 1;
    m_dwFightExp := m_dwFightExp div 2;
    m_Abil.HP := m_Abil.MaxHP;
    m_WAbil.HP := m_Abil.MaxHP;
    ReAlive();
    m_dwWalkTick := GetTickCount + 1000
  end;
  inherited;
end;

{ TWhiteSkeleton }

constructor TWhiteSkeleton.Create; //00004AACCC
begin
  inherited;
  m_boIsFirst := True;
  m_boFixedHideMode := True;
  m_btRaceServer := 100;
  m_nViewRange := 6;
end;

destructor TWhiteSkeleton.Destroy;
begin

  inherited;
end;

procedure TWhiteSkeleton.RecalcAbilitys; //004AAD38
begin
  inherited;
  sub_4AAD54();
end;

procedure TWhiteSkeleton.Run;
begin
  if m_boIsFirst then begin
    m_boIsFirst := False;
    m_btDirection := 5;
    m_boFixedHideMode := False;
    SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  end;
  inherited;
end;

procedure TWhiteSkeleton.sub_4AAD54; //004AAD54
begin
  m_nNextHitTime := 3000 - m_btSlaveMakeLevel * 600;
  m_nWalkSpeed := 1200 - m_btSlaveMakeLevel * 250;
  m_dwWalkTick := GetTickCount + 2000;
end;

{ TScultureMonster }

constructor TScultureMonster.Create; //004AAE20
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_nViewRange := 7;
  m_boStoneMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;
end;

destructor TScultureMonster.Destroy;
begin

  inherited;
end;

procedure TScultureMonster.Initialize;
begin
  if (m_PEnvir <> nil) and m_PEnvir.m_boFB then begin
    m_boStoneMode := False;
    m_nCharStatusEx := 0;
    m_nCharStatus := GetCharStatus();
  end;
  inherited;
end;

procedure TScultureMonster.MeltStone;
begin
  m_nCharStatusEx := 0;
  m_nCharStatus := GetCharStatus();
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boStoneMode := False;
end;

procedure TScultureMonster.MeltStoneAll;
var
  I: Integer;
  List10: TList;
  BaseObject: TBaseObject;
begin
  MeltStone();
  List10 := TList.Create;
  GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 7, List10);
  for I := 0 to List10.Count - 1 do begin
    BaseObject := TBaseObject(List10.Items[I]);
    if BaseObject <> nil then begin
      if BaseObject.m_boStoneMode then begin
        if BaseObject is TScultureMonster then begin
          TScultureMonster(BaseObject).MeltStone
        end;
      end;
    end;
  end; // for
  List10.Free;
end;

procedure TScultureMonster.Run; //004AAF98
var
  I: Integer;
  //  n10: Integer;
  BaseObject: TBaseObject;
begin
  if (not m_boGhost) and (not m_boDeath) and CanWork and (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then
  begin
    //    n10 := 0;
    if m_boStoneMode then begin
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then Continue;
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 2) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 2) then begin
              MeltStoneAll();
              break;
            end;
          end;
        end;
      end; // for
    end
    else begin //004AB0C7
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();
      end;
    end;
  end;
  inherited;
end;

{ TScultureKingMonster }

constructor TScultureKingMonster.Create; //004AB120
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_nViewRange := 8;
  m_boStoneMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;
  m_btDirection := 5;
  m_nDangerLevel := 5;
  m_SlaveObjectList := TList.Create;
end;

destructor TScultureKingMonster.Destroy; //004AB1C8
begin
  m_SlaveObjectList.Free;
  inherited;
end;

procedure TScultureKingMonster.MeltStone; //004AB208
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

procedure TScultureKingMonster.CallSlave; //004AB29C
var
  I: Integer;
  nC: Integer;
  n10, n14: Integer;
  //sMonName:array[0..3] of String;
  BaseObject: TBaseObject;
begin
  nC := Random(6) + 6;
  GetFrontPosition(n10, n14);
  {
  sMonName[0]:=sZuma1;
  sMonName[1]:=sZuma2;
  sMonName[2]:=sZuma3;
  sMonName[3]:=sZuma4;
  }
  for I := 1 to nC do begin
    if m_SlaveObjectList.Count >= 30 then
      break;
    BaseObject := UserEngine.RegenMonsterByName(m_sMapName, n10, n14,
      g_Config.sZuma[Random(4)]);
    if BaseObject <> nil then begin
      //BaseObject.m_Master:=Self;
      //BaseObject.m_dwMasterRoyaltyTick:=GetTickCount + 24 * 60 * 60 * 1000;
      m_SlaveObjectList.Add(BaseObject);
    end;
  end; // for
end;

procedure TScultureKingMonster.Attack(TargeTBaseObject: TBaseObject; nDir:
  Integer); //004AB3E8
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

procedure TScultureKingMonster.Run; //004AB444
var
  I: Integer;
  //  n10: Integer;
  BaseObject: TBaseObject;
begin
  if (not m_boGhost) and
    (not m_boDeath) and
    CanWork and
    (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
    //    n10 := 0;
    if m_boStoneMode then begin
      //MeltStone();//测试用
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject :=
          TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then
          Continue;
        if BaseObject.m_boDeath then
          Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 2) and (abs(m_nCurrY -
              BaseObject.m_nCurrY) <= 2) then begin
              MeltStone();
              break;
            end;
          end;
        end;
      end; // for
    end
    else begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil))
          then begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();
        //CallSlave(); //测试用
        if (m_nDangerLevel > m_WAbil.HP / m_WAbil.MaxHP * 5) and (m_nDangerLevel
          > 0) then begin
          Dec(m_nDangerLevel);
          CallSlave();
        end;
        if m_WAbil.HP = m_WAbil.MaxHP then
          m_nDangerLevel := 5;
      end;
    end;
    for I := m_SlaveObjectList.Count - 1 downto 0 do begin
      if m_SlaveObjectList.Count <= 0 then
        break;
      BaseObject := TBaseObject(m_SlaveObjectList.Items[I]);
      if BaseObject <> nil then begin
        if BaseObject.m_boDeath or BaseObject.m_boGhost then
          m_SlaveObjectList.Delete(I);
      end;
    end; // for
  end;
  inherited;
end;
{ TGasMothMonster }

constructor TGasMothMonster.Create; //004AB6B8
begin
  inherited;
  m_nViewRange := 7;
end;

destructor TGasMothMonster.Destroy;
begin

  inherited;
end;

function TGasMothMonster.sub_4A9C78(bt05: Byte): TBaseObject; //004AB708
var
  BaseObject: TBaseObject;
begin
  BaseObject := inherited sub_4A9C78(bt05);
  if (BaseObject <> nil) and (Random(3) = 0) and (BaseObject.m_boHideMode) then
    begin
    BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {8 0x70}] := 1;
  end;
  Result := BaseObject;
end;

procedure TGasMothMonster.Run; //004AB758
//var
  //n08, nC: Integer;
begin
  //  n08 := 9999;
  //  nC := 0;
  if (not m_boDeath) and
    (not bo554) and
    (not m_boGhost) and
    CanWork and
    (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
      (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil))
        then begin
      m_dwSearchEnemyTick := GetTickCount();
      sub_4C959C();
    end;
  end;
  inherited;
end;
{ TGasDungMonster }

constructor TGasDungMonster.Create; //004AB7F4
begin
  inherited;
  m_nViewRange := 7;
end;

destructor TGasDungMonster.Destroy;
begin

  inherited;
end;

{ TElfMonster }

procedure TElfMonster.AppearNow; //004AB908 神兽
begin
  boIsFirst := False;
  m_boFixedHideMode := False;
  //SendRefMsg (RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
//   Appear;
//   ResetElfMon;
  RecalcAbilitys;
  m_dwWalkTick := m_dwWalkTick + 800; //
end;

constructor TElfMonster.Create;
//004AB844
begin
  inherited;
  m_nViewRange := 6;
  m_boFixedHideMode := True;
  m_boNoAttackMode := True;
  boIsFirst := True;
  nMasterHP := 0;
end;

destructor TElfMonster.Destroy;
begin

  inherited;
end;

procedure TElfMonster.RecalcAbilitys; //004AB8B0
begin
  inherited;
  ResetElfMon();
end;

procedure TElfMonster.ResetElfMon(); //004AB8CC
begin
  m_nWalkSpeed := 700 - m_btSlaveMakeLevel * 50;
  m_dwWalkTick := GetTickCount + 2000;
end;

procedure TElfMonster.Run; //4AB944
var
  boChangeFace: Boolean;
  ElfMon: TBaseObject;
begin
  if boIsFirst then begin
    boIsFirst := False;
    m_boFixedHideMode := False;
    SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    ResetElfMon();
  end;
  if m_boDeath then begin
    if (GetTickCount - m_dwDeathTick > 2 * 1000) then begin
      MakeGhost();
    end;
  end
  else begin
    boChangeFace := False;
    if m_TargetCret <> nil then
      boChangeFace := True;
    if (m_Master <> nil) and ((m_Master.m_TargetCret <> nil) or (m_Master.m_LastHiter <> nil)) then
      boChangeFace := True;
    if boChangeFace then begin
      //ElfMon:=MakeClone(sDogz1,Self);
      ElfMon := MakeClone(m_sCharName + '1', Self);
      if ElfMon <> nil then begin
        ElfMon.m_boAutoChangeColor := m_boAutoChangeColor;
        if ElfMon is TElfWarriorMonster then begin
          TElfWarriorMonster(ElfMon).AppearNow;
          if nMasterHP > 0 then begin
            ElfMon.m_WAbil.HP := _MIN(nMasterHP, ElfMon.m_WAbil.MAXHP);
          end;
        end;
        m_Master := nil;
        KickException();
      end;
    end;
  end;
  inherited;
end;
{ TElfWarriorMonster }

procedure TElfWarriorMonster.AppearNow; //004ABB60
begin
  boIsFirst := False;
  m_boFixedHideMode := False;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  RecalcAbilitys;
  m_dwWalkTick := m_dwWalkTick + 800; //函脚饶 距埃 掉饭捞 乐澜
  dwDigDownTick := GetTickCount();
end;

constructor TElfWarriorMonster.Create;
begin
  inherited;
  m_nViewRange := 6;
  m_boFixedHideMode := True;
  boIsFirst := True;
  m_boUsePoison := False;
end;

destructor TElfWarriorMonster.Destroy;
begin

  inherited;
end;

procedure TElfWarriorMonster.RecalcAbilitys;
begin
  inherited;
  ResetElfMon();
end;

procedure TElfWarriorMonster.ResetElfMon();
begin
  m_nNextHitTime := 1350 - (m_btSlaveMakeLevel * 50);
  m_nWalkSpeed := 800 - (m_btSlaveMakeLevel * 60);
  m_dwWalkTick := GetTickCount + 2000;
end;

procedure TElfWarriorMonster.Run; //004ABBD0
var
  boChangeFace: Boolean;
  ElfMon: TBaseObject;
  ElfName: string;
begin
  ElfMon := nil;
  if boIsFirst then begin
    boIsFirst := False;
    m_boFixedHideMode := False;
    SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    ResetElfMon();
  end; //004ABC27
  if m_boDeath then begin
    if (GetTickCount - m_dwDeathTick > 2 * 1000) then begin
      MakeGhost();
    end;
  end
  else begin
    boChangeFace := True;
    if m_TargetCret <> nil then
      boChangeFace := False;
    if (m_Master <> nil) and ((m_Master.m_TargetCret <> nil) or (m_Master.m_LastHiter <> nil)) then
      boChangeFace := False;
    if boChangeFace then begin
      if (GetTickCount - dwDigDownTick) > 6 * 10 * 1000 then begin
        //if (GetTickCount - dwDigDownTick) > 10 * 1000 then begin
          //ElfMon:=MakeClone(sDogz,Self);

        ElfName := m_sCharName;
        if ElfName[length(ElfName)] = '1' then begin
          ElfName := Copy(ElfName, 1, length(ElfName) - 1);
          ElfMon := MakeClone(ElfName, Self);
        end;
        if ElfMon <> nil then begin
          SendRefMsg(RM_DIGDOWN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
          SendRefMsg(RM_CHANGEFACE, 0, Integer(Self), Integer(ElfMon), 0, '');
          ElfMon.m_boAutoChangeColor := m_boAutoChangeColor;
          if ElfMon is TElfMonster then begin
            TElfMonster(ElfMon).AppearNow;
            TElfMonster(ElfMon).nMasterHP := m_WAbil.HP;
          end;
          m_Master := nil;
          KickException();
        end;
      end;
    end
    else begin
      dwDigDownTick := GetTickCount();
    end;
  end;
  inherited;
end;

{ TElectronicScolpionMon }
(*
constructor TElectronicScolpionMon.Create;
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_boUseMagic := False;
end;

destructor TElectronicScolpionMon.Destroy;
begin

  inherited;
end;

procedure TElectronicScolpionMon.LightingAttack(nDir: Integer);
var
  WAbil: pTAbility;
  nPower, nDamage: Integer;
  btGetBackHP: Integer;
begin
  if m_TargetCret <> nil then begin
    m_btDirection := nDir;
    WAbil := @m_WAbil;
    nPower := GetAttackPower(LoWord(WAbil.MC), SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)));
    nDamage := m_TargetCret.GetMagStruckDamage(Self, nPower);
    if nDamage > 0 then begin
      btGetBackHP := LoByte(m_WAbil.MP);
      if btGetBackHP <> 0 then Inc(m_WAbil.HP, nDamage div btGetBackHP);
      m_TargetCret.StruckDamage(nDamage);
      m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), '', 200);
    end;
    SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
  end;
end;

procedure TElectronicScolpionMon.Run;
var
  nAttackDir: Integer;
  nX, nY: Integer;
begin
  if (not m_boDeath) and
    (not bo554) and
    (not m_boGhost) and
    CanWork then begin

    //血量低于一半时开始用魔法攻击
    if m_WAbil.HP < m_WAbil.MaxHP div 2 then m_boUseMagic := True
    else m_boUseMagic := False;

    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;
    if m_TargetCret = nil then Exit;

    nX := abs(m_nCurrX - m_TargetCret.m_nCurrX);
    nY := abs(m_nCurrY - m_TargetCret.m_nCurrY);

    if (nX <= 2) and (nY <= 2) then begin
      if m_boUseMagic or ((nX = 2) or (nY = 2)) then begin
        if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
          m_dwHitTick := GetTickCount();
          nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          LightingAttack(nAttackDir);
        end;
      end;
    end;
  end;
  inherited Run;
end;
    *)
{ TDoubleATKMonster }

procedure TDoubleATKMonster.BeginDeliria;
begin
  //
end;

constructor TDoubleATKMonster.Create;
begin
  inherited;
  m_dwSearchTime := 3000 + Random(2000);
  m_boAutoSearch := True;
  m_dwCheckTick := GetTickCount;
  n560 := 0;
  m_boDeliria := False;
  m_boRandomMove := False;
end;

destructor TDoubleATKMonster.Destroy;
begin

  inherited;
end;

procedure TDoubleATKMonster.EndDeliria;
begin
  //
end;

procedure TDoubleATKMonster.Initialize;
begin
  m_dwNextHitTime := m_nNextHitTime;
  m_nWalkSpeed := m_nWalkSpeed;
  inherited;
end;

procedure TDoubleATKMonster.Run;
var
  n8, nC, n10: Integer;
begin
  if not m_boDeath and not bo554 and not m_boGhost and CanWork then begin
    if m_boAutoSearch then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();
      end;
    end;

    if ((GetTickCount - m_dwCheckTick) > 10000) then begin
      m_dwCheckTick := GetTickCount();
      if m_boRandomMove and (m_TargetCret <> nil) and (sub_4C3538 >= 5) then begin
        m_TargetCret.GetBackPosition(n8, nC);
        if m_PEnvir.CanWalk(n8, nC, False) then begin
          SpaceMove(m_PEnvir, n8, nC, 0);
          Exit;
        end;
        MapRandomMove(m_PEnvir, 0);
        Exit;
      end;
      n10 := n560;
      n560 := 7 - m_WAbil.HP div (m_WAbil.MaxHP div 7);
      if (n560 >= 2) and (n560 <> n10) then begin
        m_boDeliria := True;
        m_dwDeliriaTime := GetTickCount();
      end;
      if m_boDeliria then begin
        if (GetTickCount - m_dwDeliriaTime) < 8000 then begin
          BeginDeliria;
        end
        else begin
          m_boDeliria := False;
          EndDeliria;
        end;
      end;
    end;
  end;
  inherited;
end;

{ TFiredrakeGeneralMonster }

constructor TFiredrakeGeneralMonster.Create;
begin
  inherited;
  dwCheckTick := GetTickCount;
  n560 := 0;
  boDeliria := False;
end;

destructor TFiredrakeGeneralMonster.Destroy;
begin

  inherited;
end;

procedure TFiredrakeGeneralMonster.Initialize;
begin
  dwNextHitTime := m_nNextHitTime;
  nWalkSpeed := m_nWalkSpeed;
  inherited;
end;

procedure TFiredrakeGeneralMonster.Run;
begin
  inherited;

end;

function TFiredrakeGeneralMonster.AttackTarget(): Boolean; //004A8F34
var
  bt06: Byte;
  n10: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
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
          m_nNextHitTime := Round(dwNextHitTime - dwNextHitTime * 0.3);
          m_nWalkSpeed := Round(nWalkSpeed - nWalkSpeed * 0.3);;
          SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
          Result := True;
          exit;
        end
        else begin
          boDeliria := False;
          m_nNextHitTime := dwNextHitTime;
          m_nWalkSpeed := nWalkSpeed;
        end;
      end;
    end;
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

{ TBlackPoisionSpider }

constructor TBlackPoisionSpider.Create;
begin
  inherited;
  m_boAnimal := False;
  m_boUsePoison := True;
end;

destructor TBlackPoisionSpider.Destroy;
begin

  inherited;
end;

procedure TBlackPoisionSpider.SpitAttack(btDir: Byte);
var
  WAbil: pTAbility;
  nC, n10, n14, n18, n1C: Integer;
  BaseObject: TBaseObject;
begin
  m_btDirection := btDir;
  WAbil := @m_WAbil;
  n1C := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
  if n1C <= 0 then
    Exit;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
  nC := 0;
  while (nC < 5) do begin
    n10 := 0;
    while (n10 < 5) do begin
      if g_Config.SpitMap[btDir, nC, n10] = 1 then begin
        n14 := m_nCurrX - 2 + n10;
        n18 := m_nCurrY - 2 + nC;
        BaseObject := m_PEnvir.GetMovingObject(n14, n18, True);
        if (BaseObject <> nil) and
          (BaseObject <> Self) and
          (IsProperTarget(BaseObject)) and
          (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
          n1C := BaseObject.GetMagStruckDamage(Self, n1C);
          if n1C > 0 then begin
            BaseObject.StruckDamage(n1C, Self);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n1C,
              m_WAbil.HP, m_WAbil.MaxHP, Integer(Self), 0,'', 300);
            if m_boUsePoison then begin
              if (Random(m_btAntiPoison + 20) = 0) then
                BaseObject.MakePosion(POISON_STONE, g_Config.nAttackPosionTime, g_Config.nAttackPosionTime);
            end;
          end;
        end;
      end;
      Inc(n10);
    end;
    Inc(nC);
  end;
end;

{ TSnowfieldKavassMon }

procedure TSnowfieldKavassMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  AttackTarget: TBaseObject;
  nCheckCode: Integer;
  wHitMode: Word;
resourcestring
  sExceptionMsg = '[Exception] TSnowfieldKavassMon.Attack Code: %d';
begin
  nCheckCode := 0;
  wHitMode := 0;
  try
    nCheckCode := 1;
    m_btDirection := nDir;
    if TargeTBaseObject = nil then begin
      nCheckCode := 2;
      AttackTarget := GetPoseCreate();
    end
    else
      AttackTarget := TargeTBaseObject;

    nCheckCode := 5;
    if _Attack(wHitMode, AttackTarget) then begin
      nCheckCode := 6;
      SetTargetCreat(AttackTarget);
      nCheckCode := 7;
    end;
    nCheckCode := 8;
    if m_boEspecial and (AttackTarget <> nil) then
      SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(AttackTarget), '')
    else
      SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
    nCheckCode := 9;
  except
    on E:Exception do begin
      MainOutMessage(format(sExceptionMsg, [nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
end;

{ TCamionMonster }

function TCamionMonster.AttackTarget: Boolean;
begin
  Result := False;
end;

constructor TCamionMonster.Create;
begin
  inherited;
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := RC_CAMION;
  m_boAnimal := True;
  m_boHintMaster := False;
  m_sMasterName := '';
  m_MasterGhostTick := GetTickCount;
  m_nMasterIndex := -1;
end;

destructor TCamionMonster.Destroy;
begin

  inherited;
end;

procedure TCamionMonster.Die;
begin
  m_Master := nil;
  inherited;
end;

function TCamionMonster.GetNamecolor: Byte;
begin
  if m_Master = nil then Result := 247
  else Result := 255;
end;

function TCamionMonster.GetShowName: string;
var
  sShowName: string;
begin
  sShowName := m_sCharName;
  Result := FilterShowName(sShowName);
  if (m_Master <> nil) and not m_Master.m_boObMode then begin
    Result := Result + '(' + m_Master.m_sCharName + ')';
  end else
  if (m_Master = nil) and (m_sMasterName <> '') then begin
    Result := Result + '(' + m_sMasterName + ')';
  end;
end;

procedure TCamionMonster.Run;
var
  nX, nY: Integer;
  PlayObject: TPlayObject;
begin
  if m_Master = nil then begin
    if (m_nMasterIndex = -1) or (GetTickCount > m_MasterGhostTick) then begin
      MakeGhost;
    end
    else begin
      PlayObject := GetLoginPlay(m_nMasterIndex);
      if PlayObject <> nil then begin
        PlayObject.m_SlaveList.Add(Self);
        m_Master := PlayObject;
        PlayObject.SysMsg(Format('你的%s正停在 %s(%d,%d)', [FilterShowName(m_sCharName), m_PEnvir.sMapDesc, m_nCurrX, m_nCurrY]), c_Red, t_Hint);
        RefNameColor;
      end;
    end;
  end else
  if not m_boGhost and not m_boDeath and not m_boFixedHideMode and not m_boStoneMode and CanWork then begin
    if m_boWalkWaitLocked then begin
      if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then begin
        m_boWalkWaitLocked := False;
      end;
    end;
    if not m_boWalkWaitLocked and (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
      m_dwWalkTick := GetTickCount();
      Inc(m_nWalkCount);
      if m_nWalkCount > m_nWalkStep then begin
        m_nWalkCount := 0;
        m_boWalkWaitLocked := True;
        m_dwWalkWaitTick := GetTickCount();
      end; //004A9151
      m_nTargetX := -1;
      if not m_boRunAwayMode then begin
        if (m_Master <> nil) and (m_PEnvir = m_Master.m_PEnvir) and
          (abs(m_nCurrX - m_Master.m_nCurrX) < g_Config.nSendRefMsgRange) and
          (abs(m_nCurrY - m_Master.m_nCurrY) < g_Config.nSendRefMsgRange)  then begin
          m_boHintMaster := False;
          m_Master.GetBackPosition(nX, nY);
          if (abs(m_nCurrX - nX) > 2) or (abs(m_nCurrY - nY) > 2) then begin
            m_nTargetX := nX;
            m_nTargetY := nY;
          end;
        end else begin
          if (m_Master <> nil) and (not m_boHintMaster) and (m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
            m_Master.SysMsg('你的随从已离开视线，停止移动.', c_Red, t_Hint);
            m_boHintMaster := True;
          end;
        end;
      end
      else begin //004A9344
        if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) > m_dwRunAwayTime) then begin
          m_boRunAwayMode := False;
          m_dwRunAwayTime := 0;
        end;
      end; //004A937E
      if (m_Master <> nil) and m_Master.m_boSlaveRelax then begin
        inherited;
        Exit;
      end; //004A93A6
      if m_nTargetX <> -1 then begin
        GotoTargetXY(); //004A93B5 0FFEF
      end; //004A93D8
    end; //004A93D8  if not bo510 and ((GetTickCount - m_dwWalkTick) > n4FC) then begin
  end; //004A93D8
  //if m_Master = nil then
    //m_WAbil.HP := 0;
  inherited;
end;

{ TDrunkardMonster }

constructor TDrunkardMonster.Create;
begin
  inherited;
  m_nViewRange := 4;
end;

destructor TDrunkardMonster.Destroy;
begin

  inherited;
end;

function TDrunkardMonster.GetShowName: string;
var
  sShowName: string;
begin
  sShowName := m_sCharName;
  Result := FilterShowName(sShowName);
end;

procedure TDrunkardMonster.Run;
var
  I: Integer;
  nC, n10, n14 {, n1C}: Integer;
  BaseObject1C, BaseObject: TBaseObject;
begin
  n10 := 9999;
  BaseObject := nil;
  BaseObject1C := nil;
  if (not m_boDeath) and (not bo554) and (not m_boGhost) and CanWork then begin
    if (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then Continue;
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
            if nC < n10 then begin
              n10 := nC;
              BaseObject1C := BaseObject;
            end;
          end;
        end;
      end; // for
      if BaseObject1C <> nil then begin
        m_boRunAwayMode := True;
        m_TargetCret := BaseObject1C;
      end
      else begin
        m_boRunAwayMode := False;
        m_TargetCret := nil;
      end;
    end; //
    if m_boRunAwayMode and (m_TargetCret <> nil) then begin
      if (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 4) and (abs(m_nCurrX - BaseObject.m_nCurrX) <= 4) then begin
          n14 := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
          m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
        end;
      end;
    end else
    if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      if Random(3) = 0 then
        SendRefMsg(RM_LIGHTING, m_btDirection, m_nCurrX, m_nCurrY, Integer(Self), '');
      BreakHolySeizeMode();
    end;
  end;
  inherited;
end;

{ TMoonMonster }

function TMoonMonster.AttackTarget: Boolean;
  function CheckViewRange(Targe: TBaseObject; nViewRange: Integer): Boolean;
  begin
    Result := False;
    if (Targe <> nil) and (abs(m_nCurrX - Targe.m_nCurrX) <= nViewRange) and (abs(m_nCurrY - Targe.m_nCurrY) <= nViewRange) then
      Result := True;
  end;
var
  nPower, nX, nY, nDir: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    nDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    if GetTickCount > m_dwCheckRageTick then begin
      m_dwCheckRageTick := GetTickCount + 2000;
      if Random(10) < 3 then begin
        if m_PEnvir.GetXYHuman(m_nCurrX, m_nCurrY, 1) > 1 then begin
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
        if Random(10) < 3 then begin
          SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 2;
          SendRefMsg(RM_10205, 0, Integer(m_TargetCret), 0, 32, '', 800);
        end else begin
          SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendRefMsg(RM_10205, 0, Integer(m_TargetCret), 0, 31, '', 400);
        end;
        SendDelayMsg(Self, RM_DELAYMAGIC, nPower, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3, Integer(m_TargetCret), '', 1000);
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

constructor TMoonMonster.Create;
begin
  inherited;
  m_btRaceServer := 128;
  m_nViewRange := 8;
  m_dwCheckRageTick := GetTickCount;
end;

destructor TMoonMonster.Destroy;
begin

  inherited;
end;

procedure TMoonMonster.RecalcAbilitys;
begin
  inherited;
  m_nNextHitTime := 3000 - m_btSlaveMakeLevel * 600;
  m_nWalkSpeed := 1200 - m_btSlaveMakeLevel * 250;
  m_dwWalkTick := GetTickCount + 2000;
end;

procedure TMoonMonster.Run;
begin
  inherited;

end;

{ THorseMonster }

constructor THorseMonster.Create;
begin
  inherited;
  m_nViewRange := 4;
  m_boCanGetRandomItems := False;
end;

destructor THorseMonster.Destroy;
begin

  inherited;
end;

function THorseMonster.GetShowName: string;
var
  sShowName: string;
begin
  sShowName := m_sCharName;
  Result := FilterShowName(sShowName);
end;

procedure THorseMonster.OrdinaryAttack(BaseObject: TBaseObject);
var
  StdItem: pTStdItem;
  I: Integer;
  UserItem: pTUserItem;
begin
  if (BaseObject <> nil) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (not BaseObject.m_boOnHorse) then begin
    if (not g_Config.boDomesticationCheckLevel) or (BaseObject.m_Abil.Level > m_Abil.Level) then begin
      if (not g_Config.boDomesticationUseWeapon) or (BaseObject.m_UseItems[U_Weapon].wIndex > 0) then begin
        StdItem := UserEngine.GetStdItem(BaseObject.m_UseItems[U_Weapon].wIndex);
        if (not g_Config.boDomesticationUseWeapon) or ((StdItem <> nil) and (StdItem.StdMode2 = 9)) then begin
          if (Random(100) < g_Config.nDomesticationRate) and (TPlayObject(BaseObject).IsEnoughBag) then begin
            if (m_CanDropItemList <> nil) then begin
              UserEngine.MonGetRandomItems(Self, m_CanDropItemList);
              if m_ItemList <> nil then begin
                for I := m_ItemList.Count - 1 downto 0 do begin
                  if not TPlayObject(BaseObject).IsEnoughBag then break;
                  UserItem := m_ItemList[I];
                  if UserItem = nil then Continue;
                  UserItem.MakeIndex := GetItemNumber();
                  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
                  if StdItem <> nil then begin
                    BaseObject.m_ItemList.Add(UserItem);
                    TPlayObject(BaseObject).SendAddItem(UserItem);
                    if StdItem.NeedIdentify = 1 then
                      AddGameLog(BaseObject, LOG_ADDITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, m_sCharName, '0', '0', '驯化', UserItem);
                    m_ItemList.Delete(I);
                  end;
                end;
              end;
            end;
            BaseObject.SysMsg('恭喜你[' + FilterShowName(m_sCharName) + ']已成功被驯化...', c_Red, t_Hint);
            MakeGhost;
          end;
        end;
      end;
    end;
  end;
end;

procedure THorseMonster.Run;
var
  I: Integer;
  nC, n10, n14 {, n1C}: Integer;
  BaseObject1C, BaseObject: TBaseObject;
begin
  n10 := 9999;
  BaseObject := nil;
  BaseObject1C := nil;
  if (not m_boDeath) and (not bo554) and (not m_boGhost) and CanWork then begin
    if (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then Continue;
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
            if nC < n10 then begin
              n10 := nC;
              BaseObject1C := BaseObject;
            end;
          end;
        end;
      end; // for
      if BaseObject1C <> nil then begin
        m_boRunAwayMode := True;
        m_TargetCret := BaseObject1C;
      end
      else begin
        m_boRunAwayMode := False;
        m_TargetCret := nil;
      end;
    end; //
    if m_boRunAwayMode and (m_TargetCret <> nil) then begin
      if (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 4) and (abs(m_nCurrX - BaseObject.m_nCurrX) <= 4) then begin
          n14 := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
          m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
        end;
      end;
    end;
  end;
  inherited;
end;

end.

