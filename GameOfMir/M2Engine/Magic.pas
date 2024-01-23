unit Magic;

interface
uses
  Windows, Classes, Grobal2, ObjBase, SysUtils, ObjPlay;
type
  TMagicManager = class
  private

  public
    constructor Create();
    destructor Destroy; override;
    function MagMakePrivateTransparent(BaseObject: TBaseObject; nHTime:
                                                                    Integer): Boolean;
    //function IsWarrSkill(wMagIdx: Integer): Boolean;
    function DoSpell(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX,
                                                                        nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;

    function MagBigHealing(PlayObject: TBaseObject; nPower, nX, nY, nMagID: Integer):
        Boolean;
    function MagPushArround(PlayObject: TBaseObject; nMagID, nPushLevel: Integer):
        Integer;
    function MagTurnUndead(BaseObject, TargeTBaseObject: TBaseObject; nTargetX,
                                                                        nTargetY: Integer; nLevel: Integer): Boolean;
    function MagMakeHolyCurtain(PlayObject: TPlayObject; delay, nPower: Integer; nX,
                                                                            nY: Integer): Integer;
    function MagMakeGroupTransparent(BaseObject: TBaseObject; nX, nY: Integer;
                                        nHTime, nMagID: Integer): Boolean;
    function MagTamming(BaseObject, TargeTBaseObject: TBaseObject; nTargetX,
                                                                     nTargetY: Integer; nMagicLevel: Integer): Boolean;
    function MagSaceMove(BaseObject: TBaseObject; nLevel: Integer): Boolean;
    function MagMakeFireCross(PlayObject: TPlayObject; nDamage, nHTime, nX, nY:
                                                           Integer): Integer;
    function MagBigExplosion(BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage, nMagID: Integer): Boolean;
    function MagBigExplosionTime(BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage, nMagID: Integer): Boolean;
    function MagBigExplosionAndMakePoisonByWarr(BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer; var boMove: Boolean): Boolean;
    function MagBigExplosionAndMakePoison(BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer): Boolean;
    function MagBigExplosionAndMakePoisonEx(BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer): Boolean;
    function MagDoubleBigExplosion(BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage: Integer): Boolean;
    function MagDoubleBigExplosionEx(PlayObject: TPlayObject; nPower, nX, nY: Integer; nRage, nMagID: Integer; boDecMP: Boolean = False): Boolean;
    function MagElecBlizzard(BaseObject: TBaseObject; nPower, nMagID: Integer): Boolean;
    function MabMabe(BaseObject, TargeTBaseObject: TBaseObject; nPower, nLevel,
                                                                  nTargetX, nTargetY, nMagID: Integer): Boolean;
    function MagMakeSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic):
        Boolean;
    //    function MagMakeSelf(BaseObject, TargeTBaseObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
    function MagMakeSinSuSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
    function MagMakeMoonSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;


    function MagWindTebo(PlayObject: TPlayObject; UserMagic: pTUserMagic):
        Boolean;
    function MagGroupLightening(PlayObject: TPlayObject; UserMagic: pTUserMagic;
                                   nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject; var boSpellFire:
                                                                                                   Boolean): Boolean;
    function MagGroupAmyounsul(PlayObject: TPlayObject {�޸� TBaseObject};
                                  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject:
                                                                                           TBaseObject): Boolean;
    function MagGroupDeDing(PlayObject: TPlayObject; UserMagic: pTUserMagic;
                               nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagGroupMb(PlayObject: TPlayObject; UserMagic: pTUserMagic;
                           nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagHbFireBall(PlayObject: TPlayObject; UserMagic: pTUserMagic;
                              nTargetX, nTargetY, nPower: Integer; var TargeTBaseObject: TBaseObject): Boolean;

    function MagWideAttack(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;

    function MagReturn(BaseObject, TargeTBaseObject: TBaseObject; nTargetX,
                                                                    nTargetY, nMagicLevel: Integer): Boolean;
    {function MagMakeSlave_(PlayObject: TPlayObject; UserMagic: pTUserMagic;
      sMonName: string; nCount, nHumLevel, nMonLevel: Integer): Boolean;  }
    function MagLightening(PlayObject: TPlayObject {�޸� TBaseObject};
                              UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject:
                                                                                       TBaseObject): Boolean;
    function MagMakeSuperFireCross(PlayObject: TPlayObject; nDamage, nHTime, nX,
                                                              nY: Integer; nCount: Integer): Integer;

    function MagMakeFireball(PlayObject: TPlayObject; UserMagic: pTUserMagic;
                                nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeCBOBase(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY, nPower: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagTreatment(PlayObject: TPlayObject; UserMagic: pTUserMagic; var
                                                                             nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeHellFire(PlayObject: TPlayObject; UserMagic: pTUserMagic;
                                nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeQuickLighting(PlayObject: TPlayObject; UserMagic:
                                                               pTUserMagic; var nTargetX, nTargetY: Integer; TargeTBaseObject:
                                                                                                                 TBaseObject): Boolean;
    function MagMakeLighting(PlayObject: TPlayObject; UserMagic: pTUserMagic;
                                nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeFireCharm(PlayObject: TBaseObject { �޸� TBaseObject};
                                 UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject:
                                                                                        TBaseObject; boMove: Boolean): Boolean;
    function MagMakeFireCharmEx(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY, nPower: Integer;
                                   var TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeUnTreatment(PlayObject: TPlayObject; UserMagic: pTUserMagic;
                                   nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeLivePlayObject(PlayObject: TPlayObject; UserMagic:
                                                                pTUserMagic; TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeArrestObject(PlayObject: TPlayObject; UserMagic:
                                                              pTUserMagic; TargeTBaseObject: TBaseObject): Boolean;
    function MagChangePosition(PlayObject: TPlayObject; nTargetX, nTargetY:
                                                            Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeFireDay(PlayObject: TPlayObject; UserMagic: pTUserMagic;
                               nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagVampire(PlayObject: TPlayObject; UserMagic: pTUserMagic;
                           nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagGroupFengPo(PlayObject: TPlayObject; UserMagic: pTUserMagic;
                               nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagTamming2(BaseObject, TargeTBaseObject: TBaseObject; nTargetX,
                                                                      nTargetY, nMagicLevel: Integer): Boolean;
  end;

function Max(Val1, Val2: Integer): Integer;
function Min(Val1, Val2: Integer): Integer;

function CheckMagicRate(UserMagic: pTUserMagic): Boolean;

function MPow(UserMagic: pTUserMagic): Integer;
function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
function GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
function GetRPow(wInt: Integer): Word;
function CheckAmulet(PlayObject: TBaseObject { �޸� TBaseObject}; nCount: Integer; nType: Integer): Boolean;
procedure UseAmulet(PlayObject: TBaseObject { �޸� TBaseObject}; nCount: Integer; nType: Integer);
function GetAmuletType(PlayObject: TBaseObject): Byte;

implementation

uses HUtil32, M2Share, Event, Envir{$IFDEF PLUGOPEN}, PlugOfEngine {$ENDIF};

function Max(Val1, Val2: Integer): Integer;
begin
  if Val1>=Val2 then Result := Val1 else Result := Val2;
end;

function Min(Val1, Val2: Integer): Integer;
begin
  if Val1<=Val2 then Result := Val1 else Result := Val2;
end;


function CheckMagicRate(UserMagic: pTUserMagic): Boolean;
begin
  Result := False;
  if UserMagic.MagicInfo.btTrainLv = 20 then
  begin
    // ħ��ϵ����Ҫ�������յĻ����˺�
    Result := UserMagic.MagicInfo.btDefPower <> 0;
  end;
end;


{���㼼�ܻ����˺���power �� maxPower ֮������ֵ�� }
function MPow(UserMagic: pTUserMagic): Integer;
begin
  Result := Max(0, UserMagic.MagicInfo.wPower);
  if UserMagic.MagicInfo.wMaxPower > UserMagic.MagicInfo.wPower then
  begin
    Result := Result + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower)
  end;
end;

  {
  ���㼼���˺���
  1. Ĭ������£����㷽ʽ��ƻ������汾������Ļ����˺� + ����Ĺ̶��˺� / �����ȼ�+1�� * ����ǰ�ȼ�+1����
  2. �����ȼ��� 9 ��ʱ������ǿ���㷨�������㷽ʽ�� ����Ļ����˺� * ��1 + ���̶��ӳ� / 100 / �����ȼ�+1�� * ����ǰ�ȼ�+1��)��
  3. �����ȼ��� 20 ��ʱ������֮�Ż����㷨�������㷽ʽ�ǣ�
      3.1 btDefPower = 0������Ļ����˺� * (1 + ����ϵ�� * ��ǰ���ܵȼ� / 100)
      3.2 btDefPower <> 0����ǰ�������˺� * ��1 + ����ϵ�� * ��ǰ���ܵȼ� / 100��
  4. �����ȼ��� 99 ���򳬹� 99 ʱ������֮��ת���㷨�������㷽ʽ��Ĭ�������
  }
function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
begin
  Result := (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower))
            + ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1));
  if UserMagic.MagicInfo.btTrainLv = 9 then
  begin
    Result := ROUND((UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower))
              / 100 * (100 + nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)));
  end;
  if UserMagic.MagicInfo.btTrainLv = 20 then
  begin
    if UserMagic.MagicInfo.btDefPower = 0 then
    begin
      Result := ROUND(nPower / 100 * (100 + UserMagic.MagicInfo.btDefMaxPower * (UserMagic.btLevel)));
    end
    else begin
      Result := Max(0, UserMagic.MagicInfo.btDefMaxPower * (UserMagic.btLevel + 1));
    end;
  end;
end;

{
����״̬�����ܼӳɣ������ӳ� + ���ȼ��ṩ�ļӳɡ�
�����ȼ��ṩ�ļӳɡ��㷨�ǣ���͵ȼ�Ϊ 1/3 ��ֵ�����ÿ������ 2/3/���ȼ� ��ֵ��ֱ��������ָ� nInt ��ֵ��
}
function GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
var
  d10: Double;
  d18: Double;
begin
  d10 := nInt / 3.0;
  d18 := nInt - d10; // d18 = 2 / 3 * nInt
  Result := ROUND(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 +
    (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
end;

{ȡ�˺��м�ֵ��ʵ����û��Ҫ������ Word ƴ��Ϊһ�� Integer����Ϊ Word �� 0-65535}
function GetRPow(wInt: Integer): Word;
begin
  if HiWord(wInt) > LoWord(wInt) then begin
    Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
  end
  else
    Result := LoWord(wInt);
end;

{��ȡ���������}
function GetAmuletType(PlayObject: TBaseObject): Byte;
var
  AmuletStdItem: pTStdItem;
begin
  Result := 0;
  {��ȡ����װ����λ U_BUJUK 9 Ϊ���������Ʒ����}
  if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then begin
    AmuletStdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
    if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = tm_Amulet) then begin
      {1 �Ҷ���2 �ƶ���5 �����}
      Result := AmuletStdItem.Shape;
    end;
  end;
end;

//nType Ϊָ������ 1 Ϊ����� 2 Ϊ��ҩ
{���ָ�������Ƿ�Ϊ�����������ʣ��־���Ҫ���ڽ����ĵ���ֵ}
function CheckAmulet(PlayObject: TBaseObject {�޸� TBaseObject}; nCount: Integer; nType: Integer): Boolean;
var
  AmuletStdItem: pTStdItem;
begin
  Result := False;
  if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then begin
    AmuletStdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
    if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = tm_Amulet) then begin
      case nType of //
        1: begin
            if (AmuletStdItem.Shape = 5) and (PlayObject.m_UseItems[U_BUJUK].Dura >= nCount) then begin
              Result := True;
              Exit;
            end;
          end;
        2: begin
            if (AmuletStdItem.Shape <= 2) and (PlayObject.m_UseItems[U_BUJUK].Dura >= nCount) then begin
              Result := True;
              Exit;
            end;
          end;
      end;
    end;
  end;
end;

//nType Ϊָ������ 1 Ϊ����� 2 Ϊ��ҩ
{ʹ�ö���}
procedure UseAmulet(PlayObject: TBaseObject; nCount: Integer; nType: Integer);
begin
  if PlayObject.m_UseItems[U_BUJUK].Dura > nCount then begin
    Dec(PlayObject.m_UseItems[U_BUJUK].Dura, nCount);
    PlayObject.DuraChange(U_BUJUK, PlayObject.m_UseItems[U_BUJUK].Dura, PlayObject.m_UseItems[U_BUJUK].DuraMax);
  end
  else begin
    PlayObject.m_UseItems[U_BUJUK].Dura := 0;
    if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
      TPlayObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[U_BUJUK]);
    PlayObject.m_UseItems[U_BUJUK].wIndex := 0;
  end;
end;

{�����ƿ����������}
function TMagicManager.MagPushArround(PlayObject: TBaseObject; nMagID, nPushLevel: Integer): Integer;
var
  i, nDir, levelgap, push: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  {�������пɼ�����Ա����ң���}
  for i := 0 to PlayObject.m_VisibleActors.Count - 1 do begin
    {ȡ�û�������}
    BaseObject := TBaseObject(pTVisibleBaseObject(PlayObject.m_VisibleActors[i]).BaseObject);
    {���������վ��}
    if (abs(PlayObject.m_nCurrX - BaseObject.m_nCurrX) <= 1) and (abs(PlayObject.m_nCurrY - BaseObject.m_nCurrY) <= 1) then begin
      {����û�����������Ҳ����Լ�}
      if (not BaseObject.m_boDeath) and (BaseObject <> PlayObject) then begin
        {�Է�û�д��ڼ���ģʽʱ��������š���ǽ��֩��Ů�ʹ����}
        if {(PlayObject.m_Abil.Level > BaseObject.m_Abil.Level - 10) and} (not BaseObject.m_boStickMode) then begin
          levelgap := PlayObject.m_Abil.Level - BaseObject.m_Abil.Level;
          // 2021-01-05 �Ż�Ϊ��Ĭ�� 20% �����ƿ����ˣ�ÿ������ +10% ���ʣ�ÿ 1 ���ȼ��� ��5% ����
          // ��������Ϊ 50% ���ʣ��߳� 10 ��ʱ���ﵽ 100% ���ʣ����� 10 ��ʱ������Ϊ 0% ����
          // todo ����ֵ������
          if (Random(100) < (20 + nPushLevel * 10 + levelgap * 5)) then begin
            // ��һ����ȷ��Ŀ�꣨�Է�����ҡ�����Ǳ�����û���ڰ�ȫ������������..��
            if PlayObject.IsProperTarget(BaseObject) then begin
              // �ƿ����룺2 -- 4 ����
              push := 1 + _MAX(0, nPushLevel - 1) + Random(2);
              nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
              BaseObject.CharPushed(nDir, push);
              BaseObject.MagicQuest(PlayObject, nMagID, mfs_TagEx);
              Inc(Result);
            end;
          end;
        end;
      end;
    end;
  end;
end;

{Ⱥ��������}
function TMagicManager.MagBigHealing(PlayObject: TBaseObject; nPower, nX, nY, nMagID:
  Integer): Boolean; //00492E50
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  // ͨ��������ڻ�����������꣬��ȡ 1 ��Χ��3x3���ڵ���Ҷ����б�
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nX, nY, 1, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList[i]);
    // ������Լ��ˣ����ޡ�ʦͽ����ӡ��л�ȣ���������ȫ�幥��ģʽ
    if PlayObject.IsProperFriend(BaseObject) then begin
      if BaseObject.m_WAbil.HP < BaseObject.m_WAbil.MaxHP then begin
        BaseObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, 0, '', 800);
        //BaseObject.SendMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '');
        BaseObject.MagicQuest(PlayObject, nMagID, mfs_TagEx);
        Result := True;
      end;
      // �������������ʾ����ô���Կ���Ѫ���ı仯
      if PlayObject.m_boAbilSeeHealGauge then
        PlayObject.SendDefMsg(PlayObject, SM_INSTANCEHEALGUAGE, Integer(BaseObject), BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, 0, '');
    end;
  end;
  BaseObjectList.Free;
end;

constructor TMagicManager.Create;
begin

end;

destructor TMagicManager.Destroy;
begin

  inherited;
end;

{˫���ơ����ױ�����}
function TMagicManager.MagMakeCBOBase(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY, nPower: Integer; var TargeTBaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if TargeTBaseObject = nil then exit;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    if PlayObject.IsProperTarget(TargeTBaseObject) then begin
      // fixme ��� ħ����� С�� 0 -- 9 ֮���ĳ��ֵ����ô�������ܣ���ô����ζ�� 1 = 10%��δ��Ӧ���޸�Ϊ Random(100)
      if (TargeTBaseObject.m_nAntiMagic <= Random(10)) and (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and
        (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
          nTargetX, nTargetY, 2, Integer(TargeTBaseObject), '',
          400 + (abs(PlayObject.m_nCurrX - nTargetX) + abs(PlayObject.m_nCurrY - nTargetY)) div 2 * 20);
        TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        //PlayObject.SendMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '');
        if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
          Result := True;
      end
      else
        TargeTBaseObject := nil;
    end;
    //else
      //TargeTBaseObject := nil;
  end
  else
    TargeTBaseObject := nil;
end;

{����}

function TMagicManager.MagMakeFireball(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
{  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;}
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  { ����Ƿ��ܹ����� }
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    { ����Ƿ���Թ��� }
    if PlayObject.IsProperTarget(TargeTBaseObject) then begin
      // fixme �ع�ħ�����
      if (TargeTBaseObject.m_nAntiMagic <= Random(10)) and
        (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and
        (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
          if CheckMagicRate(UserMagic) then begin
            nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                      Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
          end
          else begin
            nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                      SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
          end;
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
          nTargetX, nTargetY, 2, Integer(TargeTBaseObject), '',
          400 + (abs(PlayObject.m_nCurrX - nTargetX) + abs(PlayObject.m_nCurrY - nTargetY)) div 2 * 20);
        //PlayObject.SendMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '');

        // todo ����������
        // 0�� 3% ���� -- 3 �� 12% ����
        if (UserMagic.wMagIdx = SKILL_FIREBALL2) and (Random(100) < (UserMagic.btLevel + 1) * 3) then
        begin
          // todo ����ж�����
//          nPower := UserMagic.MagicInfo.btDefMaxPower;
          TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON,
                                         POISON_DAMAGEARMOR {�ж����� - �춾}, nPower{����ʱ��},
                                         Integer(PlayObject),
                                         ROUND(nPower * (UserMagic.btLevel + 1) / (UserMagic.MagicInfo.btTrainLv + 1)){����ϵ��}
              ,0, '', 800);
//          TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        end;

        TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        // ��ֵ��ж�
        if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
          Result := True;
      end
      else
        TargeTBaseObject := nil;
    end;
    //else
      //TargeTBaseObject := nil;
  end
  else
    TargeTBaseObject := nil;
end;

{������������ǿ��Ҳ������ 20 ������}

function TMagicManager.MagTreatment(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  // power -- maxPower ֮������ֵ
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  // ������˺��̶�ֵ + ��ǰ�ȼ��ȵ��˺��������������ֵ��0 ������ 1/(N+1)��
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  // Ŀ��Ϊ�գ����Լ���Ѫ
  if TargeTBaseObject = nil then begin
    TargeTBaseObject := PlayObject;
    nTargetX := PlayObject.m_nCurrX;
    nTargetY := PlayObject.m_nCurrY;
  end;
  if PlayObject.IsProperFriend(TargeTBaseObject) then begin
    nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
      LoWord(PlayObject.m_WAbil.SC) * 2,
      SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 2 + 1);
    if TargeTBaseObject.m_WAbil.HP < TargeTBaseObject.m_WAbil.MaxHP then begin
      TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, 0, '', 800);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      //TargeTBaseObject.SendMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '');
      Result := True;
    end;
    if PlayObject.m_boAbilSeeHealGauge then
      PlayObject.SendDefMsg(PlayObject, SM_INSTANCEHEALGUAGE, Integer(TargeTBaseObject), TargeTBaseObject.m_WAbil.HP, TargeTBaseObject.m_WAbil.MaxHP, 0, '');
  end;
end;

{�����}

function TMagicManager.MagMakeHellFire(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  n1C: Integer;
  n14, n18: Integer;
  {function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;}
begin
  Result := False;
  n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
  if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 1, n14, n18) then begin
    PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 5, nTargetX, nTargetY);
    if CheckMagicRate(UserMagic) then begin
      nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
    end
    else begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
    end;
    if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C, nPower, UserMagic.wMagIdx, False) > 0 then
      Result := True;
  end;
end;

{�����Ӱ}

function TMagicManager.MagMakeQuickLighting(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  n1C: Integer;
  n14, n18: Integer;
  {function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;}
begin
  Result := False;
  n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
  if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX,
    PlayObject.m_nCurrY, n1C, 1, n14, n18) then begin
    PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 8, nTargetX, nTargetY);
    if CheckMagicRate(UserMagic) then begin
      nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                           Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                           (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
    end
    else begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
    end;
    if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C, nPower, UserMagic.wMagIdx,
      True) > 0 then
      Result := True;
  end;
end;

{�׵���}

function TMagicManager.MagMakeLighting(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower,levelgap: Integer;
  {function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;}
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    // fixme ħ�����
    if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then begin
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      end;
      {if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then
        nPower := ROUND(nPower * 1.5); }
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, nTargetX, nTargetY, 2, Integer(TargeTBaseObject), '', 600);

      levelgap := PlayObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
      // 2021-01-05 �Ż�Ϊ��ÿ������ +5% ���ʣ�ÿ 1 ���ȼ��� ��1% ����
      // ��������Ϊ 15% ���ʣ��߳� 85 ��ʱ���ﵽ 100% ���ʣ����� 15 ��ʱ������Ϊ 0% ����
      // ����ʱ�䣺 [1, magic level]
      // todo ����ֵ������
      if (Random(100) < Round(UserMagic.btLevel * 5 + levelgap)) then begin
          TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_STONE
              {�ж����� - ���}, Round(1+Random(UserMagic.btLevel+1)){����ʱ��}, Integer(PlayObject), 0, 0, '', 600);
      end;

      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      //PlayObject.SendMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '');
      //if PlayObject.m_btRaceServer = RC_PLAYMOSTER then Result := True
      //else
      if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
        Result := True;
    end
    else
      TargeTBaseObject := nil
  end
  else
    TargeTBaseObject := nil;
end;

{�����}

function TMagicManager.MagMakeFireCharm(PlayObject: TBaseObject;
  {�޸� TBaseObject}
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject; boMove: Boolean): Boolean;
var
  nPower: Integer;
  {function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;}
  function GetAroundObject(Targe: TBaseObject): TBaseObject;
  var
    BaseObjectList: TList;
    TargeBase: TBaseObject;
    I: Integer;
  begin
    Result := nil;
    BaseObjectList := TList.Create;
    Try
      // fixme ��Χ 3 ��Ϊ ��Χ 5 ����۲�һ��Ч��
      Targe.GetMapBaseObjects(Targe.m_PEnvir, Targe.m_nCurrX, Targe.m_nCurrY, 5, BaseObjectList);
      for I := BaseObjectList.Count - 1 downto 0 do begin
        TargeBase := TBaseObject(BaseObjectList[I]);
        if (not PlayObject.IsProperTarget(TargeBase)) or (Targe = TargeBase) or (PlayObject = TargeBase) or
          (not Targe.MagCanHitTarget(Targe.m_nCurrX, Targe.m_nCurrY, TargeBase)) then begin
          BaseObjectList.Delete(I);
        end;
      end;
      if BaseObjectList.Count > 0 then
        Result := TBaseObject(BaseObjectList[Random(BaseObjectList.Count)]);
    Finally
      BaseObjectList.Free;
    End;
  end;
var
  I: Integer;
  AroundBase, TargeBase: TBaseObject;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    if PlayObject.IsProperTarget(TargeTBaseObject) then begin
      if Random(10) >= TargeTBaseObject.m_nAntiMagic then begin
        if (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and
          (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
          if CheckMagicRate(UserMagic) then begin
            nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.SC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                                 Round((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC) + 1) *
                                                 (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
          end
          else begin
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) +
            LoWord(PlayObject.m_WAbil.SC),
            SmallInt(HiWord(PlayObject.m_WAbil.SC) -
            LoWord(PlayObject.m_WAbil.SC)) + 1);
          end;
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, nTargetX, nTargetY, 2, Integer(TargeTBaseObject), '', 400);
          TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
          if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
            Result := True;

          if boMove then begin
            if UserMagic.btLevel >= 0 then begin
              TargeBase := TargeTBaseObject;
              // 0������1�Σ�1������3�Σ�2������5�Σ�3������7��
              for I := 2 to (_MIN(UserMagic.btLevel, UserMagic.MagicInfo.btTrainLv)+UserMagic.btLevel+2) do begin
                AroundBase := GetAroundObject(TargeBase);
                if AroundBase = nil then break;
                PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, AroundBase.m_nCurrX, AroundBase.m_nCurrY, 2, Integer(AroundBase), '', I * 400);
                AroundBase.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
                AroundBase.SendRefMsg(RM_10205, 0, Integer(TargeBase), 0, 30, '', 400 * I);
                TargeBase := AroundBase;
              end;
            end;
          end;
        end;
      end;
    end;
  end
  else
    TargeTBaseObject := nil;
end;


function TMagicManager.MagMakeFireCharmEx(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY, nPower: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    if PlayObject.IsProperTarget(TargeTBaseObject) then begin
      // fixme ħ�����
      if Random(10) >= TargeTBaseObject.m_nAntiMagic then begin
        if (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, nTargetX, nTargetY, 2, Integer(TargeTBaseObject), '',
            400 + (abs(PlayObject.m_nCurrX - nTargetX) + abs(PlayObject.m_nCurrY - nTargetY)) div 2 * 20);
          TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
          if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
            Result := True;
        end;
      end;
    end;
  end
  else
    TargeTBaseObject := nil;
end;

{��Ѫ��      }

function TMagicManager.MagVampire(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;

  {function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) +
      (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;}
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    // fixme ħ�����
    if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then begin
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.SC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.SC),
        SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
      end;
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC2, nPower, nTargetX, nTargetY, 2, Integer(TargeTBaseObject), '', 600);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      //PlayObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '', 800);
      Result := True;
      {if g_Config.boPlayObjectReduceMP then
        TargeTBaseObject.DamageSpell(nPower div 2);  }
    end;
  end;
end;

{�����}

function TMagicManager.MagMakeFireDay(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower, nPoint: Integer;
  {function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;}
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    // fixme ħ�����
    if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then
    begin
      if CheckMagicRate(UserMagic) then
      begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      end;
      {if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then
        nPower := ROUND(nPower * 1.5); }
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, nTargetX, nTargetY, 2, Integer(TargeTBaseObject), '', 600);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      if g_Config.boPlayObjectReduceMP and (Random(10) < UserMagic.btLevel)then
          // 1/4 ��ǰ����ֵ -- 1/1 ��ǰ����ֵ
        nPoint := Min(0, Round(TargeTBaseObject.m_WAbil.MP * (UserMagic.MagicInfo.btTrainLv + 1) / (UserMagic.btLevel + 1)));
        // 1/10 ���������С���˺��� 1/2�����滻֮
        TargeTBaseObject.DamageSpell(Max(nPoint div 10, nPower div 2));
      if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
        Result := True;
    end
    else
      TargeTBaseObject := nil
  end
  else
    TargeTBaseObject := nil;
end;

{�ⶾ��}

function TMagicManager.MagMakeUnTreatment(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if TargeTBaseObject = nil then begin
    TargeTBaseObject := PlayObject;
    //    nTargetX := PlayObject.m_nCurrX;
    //    nTargetY := PlayObject.m_nCurrY;
  end;
  if PlayObject.IsProperFriend {0FFF3}(TargeTBaseObject) then begin
    if Random(7) - (UserMagic.btLevel + 1) < 0 then begin
      if TargeTBaseObject.m_wStatusTimeArr[POISON_DECHEALTH] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_DECHEALTH] := 1;
        Result := True;
      end;
      if TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] := 1;
        Result := True;
      end;
      if TargeTBaseObject.m_wStatusTimeArr[POISON_STONE] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_STONE] := 1;
        Result := True;
      end;
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
    end;
  end;
end;

{������}

function TMagicManager.MagMakeLivePlayObject(PlayObject: TPlayObject; UserMagic:
  pTUserMagic; TargeTBaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if PlayObject.IsProperTargetSKILL_57(TargeTBaseObject) then begin
    if (Random(10 + UserMagic.btLevel) + UserMagic.btLevel) >= 8 then begin
      TPlayObject(TargeTBaseObject).ReAlive;
      TPlayObject(TargeTBaseObject).m_WAbil.HP :=
        TPlayObject(TargeTBaseObject).m_WAbil.MaxHP;
      TPlayObject(TargeTBaseObject).SendAbility;
      Result := True;
    end;
  end;
end;

{������}

function TMagicManager.MagMakeArrestObject(PlayObject: TPlayObject; UserMagic:
  pTUserMagic; TargeTBaseObject: TBaseObject): Boolean;
var
  nX, nY: Integer;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.IsProperTargetSKILL_55(PlayObject.m_WAbil.Level, TargeTBaseObject) then begin
    if (Random(10 + UserMagic.btLevel) + UserMagic.btLevel) >= 5 then begin
      PlayObject.GetFrontPosition(nX, nY);
      TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_MONMOVE, 0, 0, nX, nY,0, '', 1500);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      Result := True;
    end;
  end;
end;
{���л�λ}

function TMagicManager.MagChangePosition(PlayObject: TPlayObject; nTargetX,
  nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
//var
//  i, nX, nY, olddir, oldx, oldy, nBackDir{, nDir}: Integer;
  //n01: Integer;
begin
  Result := False;
  //  n01 := 0;
  if not PlayObject.m_boOnHorse then begin
    if PlayObject.IsProperTargetSKILL_56(TargeTBaseObject, nTargetX, nTargetY) then begin
      //      nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
      PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      PlayObject.SpaceMove(PlayObject.m_PEnvir, nTargetX, nTargetY, 0);
      Result := True;
    end;
  end;
end;
(*
function TMagicManager.IsWarrSkill(wMagIdx: Integer): Boolean; //�Ƿ���սʿ����
begin
  Result := False;
  if wMagIdx in [SKILL_ONESWORD {3}, SKILL_ILKWANG {4}, SKILL_YEDO {7},
    SKILL_ERGUM {12}, SKILL_BANWOL {25}, SKILL_FIRESWORD {26}, SKILL_MOOTEBO {27},
    SKILL_40 {40}, SKILL_42, SKILL_43] then
    Result := True;
end;    *)

function TMagicManager.DoSpell(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  boTrain: Boolean;// �Ƿ�����������
  boSpellFail: Boolean;
  boSpellFire: Boolean;
  btAmuletType: Byte;
  boMove: Boolean;
  //  n14: Integer;
  //  n18: Integer;
  //  n1C: Integer;
  nPower: Integer;
  magicId: Word;
  //  StdItem: pTStdItem;
//  nAmuletIdx: Integer;
  //  nX: Integer;
  //  nY: Integer;
//  nPowerRate: Integer;
  nDelayTime: Integer;
//  nDelayTimeRate: Integer;
  {function MPow(UserMagic: pTUserMagic): Integer; //004921C8
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer; //00493314
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) +
      (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;}
  function GetPower13(nInt: Integer): Integer; //0049338C
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := ROUND(d18 / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower -
      UserMagic.MagicInfo.btDefPower)));
  end;
  function GetRPow(wInt: Integer): Word; //ȡ�˺��м����ֵ
  begin
    if HiWord(wInt) > LoWord(wInt) then begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end
    else
      Result := LoWord(wInt);
  end;
  {procedure sub_4934B4(PlayObject: TPlayObject);
  begin
    if PlayObject.m_UseItems[U_ARMRINGL].Dura < 1 then begin
      PlayObject.m_UseItems[U_ARMRINGL].Dura := 0;
      PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
      PlayObject.m_UseItems[U_ARMRINGL].wIndex := 0;
    end;
  end;}
var
  MapFlag: TWalkFlagArr;
begin
  Result := False;
  boMove := False;
  //����Ƿ�սʿ����
  //if IsWarrSkill(UserMagic.wMagIdx) then Exit;
  //����ħ��������Χ
  if (TargeTBaseObject <> nil) and ((abs(PlayObject.m_nCurrX - nTargetX) > g_Config.nMagicAttackRage) or
    (abs(PlayObject.m_nCurrY - nTargetY) > g_Config.nMagicAttackRage)) then begin
    Exit;
  end;
  //���ͼ��ܿ�ʼЧ��
  PlayObject.MagicQuest(nil, UserMagic.wMagIdx, mfs_Self);
  if not ((UserMagic.wMagIdx = SKILL_AMYOUNSUL) or (UserMagic.wMagIdx = SKILL_GROUPAMYOUNSUL)) then
    PlayObject.SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY,
      UserMagic.MagicInfo.wMagicId, '');

  if (TargeTBaseObject <> nil) and TargeTBaseObject.m_boDeath and (UserMagic.MagicInfo.wMagicId <> SKILL_60) then
    TargeTBaseObject := nil;

  if TargeTBaseObject <> nil then begin

    if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      PlayObject.MagicQuest(TargeTBaseObject, UserMagic.wMagIdx, mfs_Tag);
    end else begin
      PlayObject.MagicQuest(TargeTBaseObject, UserMagic.wMagIdx, mfs_Mon);
    end;
  end;


  boTrain := False;
  boSpellFail := False;
  boSpellFire := True;
  //  nPower := 0;
    //if (PlayObject.m_nSoftVersionDateEx = 0) and (PlayObject.m_dwClientTick = 0) and (UserMagic.MagicInfo.wMagicId > 40) then Exit;
  // ���� ID �� 1000 ����ʱ�����Ը��ü���
  magicId := UserMagic.MagicInfo.wMagicId mod 1000;
  case magicId of //
    SKILL_FIREBALL{1},// С����
    SKILL_FIREBALL2: {5} //�����-������-˫����Ч��
      begin
        if MagMakeFireball(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_HEALLING {2}: begin //������
        if MagTreatment(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_AMYOUNSUL, {6} //ʩ����
      SKILL_GROUPAMYOUNSUL {38 Ⱥ��ʩ����}: begin
        btAmuletType := GetAmuletType(PlayObject);
        boSpellFire := False;
        if UserMagic.btLevel < 3 then // 0 -- 2 ����ͨʩ������3 ��Ⱥ��ʩ����
        begin
          if btAmuletType = 2 then
            btAmuletType := MAGICEX_AMYOUNSUL
          else
            btAmuletType := 4;
          PlayObject.SendRefMsg(RM_SPELL, btAmuletType, nTargetX, nTargetY, SKILL_AMYOUNSUL, '');
          if MagLightening(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then begin
            boTrain := True;
            PlayObject.SendRefMsg(RM_MAGICFIRE, 0, MakeLong(UserMagic.MagicInfo.btEffectType, btAmuletType),
                                   MakeLong(nTargetX, nTargetY), Integer(TargeTBaseObject), '');
          end
          else
            boSpellFail := True;
        end else begin
          if btAmuletType = 2 then
            btAmuletType := MAGICEX_AMYOUNSULGROUP
          else
            btAmuletType := 47;
          PlayObject.SendRefMsg(RM_SPELL, btAmuletType, nTargetX, nTargetY, SKILL_GROUPAMYOUNSUL, '');
          if MagGroupAmyounsul(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then begin
            boTrain := True;
            PlayObject.SendRefMsg(RM_MAGICFIRE, 0, MakeLong(UserMagic.MagicInfo.btEffectType, btAmuletType),
                                   MakeLong(nTargetX, nTargetY), Integer(TargeTBaseObject), '');
          end;
        end;
      end;
    SKILL_FIREWIND {8}: begin //���ܻ�  00493754
        if MagPushArround(PlayObject, UserMagic.wMagIdx, UserMagic.btLevel) > 0 then
          boTrain := True;
      end;
    SKILL_FIRE {9}: begin //������ 00493778
        if MagMakeHellFire(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTBaseObject) then
          boTrain := True;

      end;
    SKILL_SHOOTLIGHTEN {10}: begin //�����Ӱ 0049386A
        if MagMakeQuickLighting(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_LIGHTENING {11}: begin //�׵��� 0049395C
      if MagMakeLighting(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
        boTrain := True;
      end;
    SKILL_SKELLETON {17}: begin //�ٻ����� 004943A2
      if MagMakeSlave(PlayObject, UserMagic) then begin
        boTrain := True;
      end;
    end;
    SKILL_HOLYSHIELD {16}: begin //��ħ�� 00494353
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.SC),
                                           SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1, False);
      nDelayTime := GetPower(60, UserMagic) + (Word(GetRPow(PlayObject.m_WAbil.SC)) shr 1);

      if MagMakeHolyCurtain(PlayObject, nDelayTime, nPower, nTargetX, nTargetY) > 0 then
        boTrain := True;
    end;
    SKILL_52: begin //������
      nPower := PlayObject.GetAttackPower(60 + LoWord(PlayObject.m_WAbil.SC) * 10,
                                           SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 10 + 1);
      if PlayObject.MagMakeAbilityArea(nTargetX, nTargetY, 3, nPower, UserMagic.wMagIdx, 0, False) > 0 then
        boTrain := True;
    end;
    SKILL_FIRECHARM {13}, //�����
    SKILL_HANGMAJINBUB {14}, //�����
    SKILL_DEJIWONHO {15}, //��ʥս����
    SKILL_CLOAK {18}, //������
    SKILL_BIGCLOAK {19}, //����������
    SKILL_67: begin //004940BC  //�����
        boSpellFail := True;
        if CheckAmulet(PlayObject, 1, 1) then begin
          UseAmulet(PlayObject, 1, 1);
          case UserMagic.MagicInfo.wMagicId of //
            SKILL_FIRECHARM{13}: begin //����� 0049415F
                if MagMakeFireCharm(PlayObject,
                  UserMagic,
                  nTargetX,
                  nTargetY,
                  TargeTBaseObject, False) then
                  boTrain := True;
              end;
            SKILL_67 {67}: begin //����� 0049415F
                if MagMakeFireCharm(PlayObject,
                  UserMagic,
                  nTargetX,
                  nTargetY,
                  TargeTBaseObject, True) then
                  boTrain := True;
              end;
            SKILL_DEJIWONHO {15}, //��ʥս���� 004942E5
            SKILL_HANGMAJINBUB {14}: begin //����� 00494277
                // ��Ҫ���� SKILL_HANGMAJINBUB ��ħ����Ч
                PlayObject.SendRefMsg(RM_SPELL, 11, nTargetX, nTargetY, SKILL_HANGMAJINBUB, '');
                if (TargeTBaseObject <> nil) and TargeTBaseObject.m_boDeath then
                  TargeTBaseObject := nil;
                if TargeTBaseObject <> nil then begin
                  if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                    PlayObject.MagicQuest(TargeTBaseObject, SKILL_HANGMAJINBUB, mfs_Tag);
                  end else begin
                    PlayObject.MagicQuest(TargeTBaseObject, SKILL_HANGMAJINBUB, mfs_Mon);
                  end;
                end;

                // ʱ�䳤�ȣ��룬����ܺ���ʥս�����϶�Ϊһ
                nPower := PlayObject.GetAttackPower(60 + LoWord(PlayObject.m_WAbil.SC) * 10,
                  SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 10 + 1);
                if (PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, SKILL_HANGMAJINBUB, 1, True) > 0)
                  and (PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, SKILL_DEJIWONHO, 0, True) > 0) then
                    boTrain := True;
              end;
            SKILL_CLOAK {18},
            SKILL_BIGCLOAK {19}: begin //������ + ����������
                if (UserMagic.btLevel < 3) and
                  MagMakePrivateTransparent(PlayObject, 60 + GetRPow(PlayObject.m_WAbil.SC) * 10) then
                  boTrain := True;
                if  (UserMagic.btLevel = 3) and
                  MagMakeGroupTransparent(PlayObject, nTargetX, nTargetY,
                                           60 + GetRPow(PlayObject.m_WAbil.SC) * 10, SKILL_BIGCLOAK) then
                  boTrain := True;
              end;
            {SKILL_57: begin //������
                if MagMakeLivePlayObject(PlayObject, UserMagic, TargeTBaseObject)
                  then
                  boTrain := True;
              end;    }
          end;
          boSpellFail := False;
//          sub_4934B4(PlayObject);
        end;
      end;
    SKILL_TAMMING {20}: begin //�ջ�֮�� 00493A51
        if (TargeTBaseObject <> nil) and PlayObject.IsProperTarget(TargeTBaseObject) then begin
          if MagTamming(PlayObject, TargeTBaseObject, nTargetX, nTargetY, UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_SPACEMOVE {21}: begin //˲Ϣ�ƶ� 00493ADD
        PlayObject.SendRefMsg(RM_MAGICFIRE, 0, MakeLong(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
                               MakeLong(nTargetX, nTargetY), Integer(TargeTBaseObject), '');
        boSpellFire := False;
        if MagSaceMove(PlayObject, UserMagic.btLevel) then
          boTrain := True;
      end;
    SKILL_EARTHFIRE {22}: begin //��ǽ  00493B40
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1, False);
        nDelayTime := GetPower(100, UserMagic) + (Word(GetRPow(PlayObject.m_WAbil.MC)) shr 1);

        //2006-11-12 ��ǽ������ʱ��ı���
        nPower := ROUND(nPower * (g_Config.nFirePowerRate / 100));
        nDelayTime := ROUND(nDelayTime * (g_Config.nFireDelayTimeRate / 100));

        if MagMakeFireCross(PlayObject, nPower, nDelayTime, nTargetX, nTargetY) > 0 then
          boTrain := True;
      end;
    SKILL_FIREBOOM {23}: begin //���ѻ���
      // �ѵر���������Χ 1
      // todo ����������
      if UserMagic.MagicInfo.wMagicId = SKILL_FIREBOOM + 1000 then
      begin
        if MagBigExplosion(PlayObject,
                            PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
                            nTargetX, nTargetY, 1, UserMagic.wMagIdx) then
          boTrain := True;
      end
      else if MagBigExplosion(PlayObject,
                               PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                  SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
                               nTargetX, nTargetY, g_Config.nFireBoomRage {3}, UserMagic.wMagIdx) then
          boTrain := True;
      end;
    SKILL_LIGHTFLOWER {24}: begin //�����׹�
        if MagElecBlizzard(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) +
          LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) -
          LoWord(PlayObject.m_WAbil.MC)) + 1), UserMagic.wMagIdx) then
          boTrain := True;
      end;
    SKILL_SHOWHP {28}: begin //������ʾ
        if (TargeTBaseObject <> nil) and not TargeTBaseObject.m_boShowHP then begin
          if Random(6) <= (UserMagic.btLevel + 3) then begin
            TargeTBaseObject.m_dwShowHPTick := GetTickCount();
            TargeTBaseObject.m_dwShowHPInterval := GetPower13(GetRPow(PlayObject.m_WAbil.SC) * 2 + 30) * 1000;
            TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_DOOPENHEALTH, 0, 0, 0, 0, 0, '', 1500);
            TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
            //TargeTBaseObject.SendMsg(TargeTBaseObject, RM_DOOPENHEALTH, 0, 0, 0, 0, '');
            boTrain := True;
          end;
        end;
      end;
    SKILL_BIGHEALLING {29}: begin //Ⱥ��������
      // fixme �������� 20�� ���ܵ�ϵ��
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.SC) * 2,
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 2 + 1);
        if MagBigHealing(PlayObject, nPower, nTargetX, nTargetY, UserMagic.wMagIdx) then
          boTrain := True;
      end;
    SKILL_SINSU {30}: begin //�ٻ�����
        boSpellFail := True;
        if CheckAmulet(PlayObject, 5, 1) then begin
          UseAmulet(PlayObject, 5, 1);
          if MagMakeSinSuSlave(PlayObject, UserMagic) then begin
            boTrain := True;
          end;
//          sub_4934B4(PlayObject);
          boSpellFail := False;
        end;
      end;
    SKILL_SHIELD {31}: begin //ħ����
        boSpellFail := True;
        if PlayObject.m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] = 0 then begin
          boSpellFail := False;
          if PlayObject.MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(PlayObject.m_WAbil.MC) + 15, UserMagic), STATE_BUBBLEDEFENCEUP) then
            boTrain := True;
        end;
      end;
    SKILL_KILLUNDEAD {32}: begin //ʥ����
        if TargeTBaseObject <> nil then begin
          if PlayObject.IsProperTarget(TargeTBaseObject) then begin
            if MagTurnUndead(PlayObject, TargeTBaseObject, nTargetX, nTargetY, UserMagic.btLevel) then
              boTrain := True;
          end;
        end;
      end;
    SKILL_SNOWWIND {33}: begin //������
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      end;
        if MagBigExplosion(PlayObject,
          nPower,
          nTargetX,
          nTargetY,
          g_Config.nSnowWindRange {1}, UserMagic.wMagIdx) then
          boTrain := True;
      end;
    SKILL_UNAMYOUNSUL {34}: begin //�ⶾ��
        if MagMakeUnTreatment(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_WINDTEBO {35}: //��ʨ�Ӻ�
      //if MagWindTebo(PlayObject, UserMagic) then
        //boTrain := True;
                 ;
    //����
    SKILL_MABE {36}: begin //�����
        with PlayObject do begin
          if CheckMagicRate(UserMagic) then begin
            nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.SC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                                 Round((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC) + 1) *
                                                 (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
          end
          else begin
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.SC),
            SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
          end;
        end;
        if MabMabe(PlayObject, TargeTBaseObject, nPower, UserMagic.btLevel, nTargetX, nTargetY, UserMagic.wMagIdx) then
          boTrain := True;
      end;
    SKILL_GROUPLIGHTENING {37 Ⱥ���׵���}: begin
        if MagGroupLightening(PlayObject, UserMagic, nTargetX, nTargetY,
          TargeTBaseObject, boSpellFire) then
          boTrain := True;
      end;
    SKILL_GROUPDEDING {39 �ض�}: begin
       // if (GetTickCount - PlayObject.m_dwDedingUseTick) > LongWord(g_Config.nDedingUseTime * 1000) then begin
          //PlayObject.m_dwDedingUseTick := GetTickCount;
       if MagGroupDeDing(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
        //end;
      end;
    SKILL_41: begin //ʨ�Ӻ�
        if MagGroupMb(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_42: begin //��Ӱ����
        if MagWideAttack(PlayObject, UserMagic) then
          boTrain := True;
      end;
    //��ʦ
    SKILL_44: begin //����� ������
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      end;
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY, nPower, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_45: begin //�����
        if MagMakeFireDay(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_46: begin //������
        {if MagMakeSelf(PlayObject, TargeTBaseObject, UserMagic) then begin

        end;  }
        boTrain := True;
      end;
    SKILL_47: begin //��������
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      end;
        if MagBigExplosion(PlayObject,
          nPower,
          nTargetX,
          nTargetY,
          0{g_Config.nFireBoomRage} {1}, UserMagic.wMagIdx) then
          boTrain := True;
      end;
    //��ʿ
    SKILL_48: begin //������
        if MagPushArround(PlayObject, UserMagic.wMagIdx, UserMagic.btLevel) > 0 then
          boTrain := True;
      end;
    SKILL_49: begin //������
        boTrain := True;
      end;
    SKILL_50: begin //�޼�����
        if PlayObject.AbilityUp(UserMagic) then
          boTrain := True;
      end;
    SKILL_51: begin //쫷���
        if MagGroupFengPo(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_53: begin //��Ѫ��
        if MagVampire(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_54: begin //������
        if PlayObject.IsProperTargetSKILL_54(TargeTBaseObject) then begin
          if MagTamming2(PlayObject, TargeTBaseObject, nTargetX, nTargetY, UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_55: begin //������
        if MagMakeArrestObject(PlayObject, UserMagic, TargeTBaseObject) then
          boTrain := True;
      end;
    {SKILL_56: begin //���л�λ
        if MagChangePosition(PlayObject, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;   }
    SKILL_57: begin // ���ǻ���
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      end;
        if MagDoubleBigExplosionEx(PlayObject,
          nPower,
          nTargetX,
          nTargetY,
          1,
          UserMagic.wMagIdx) then
          boTrain := True;
      end;
    SKILL_58: begin //��Ѫ��
        boSpellFail := True;
        if PlayObject.m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] = 0 then begin
          boSpellFail := False;
          if PlayObject.MagShieldDefenceUp(UserMagic.btLevel,
            GetPower(GetRPow(PlayObject.m_WAbil.MC) + 15, UserMagic), STATE_BUBBLEDEFENCEUPEX) then
            boTrain := True;
        end;
      end;
    SKILL_59: begin //�������
        boTrain := True;
      end;
    SKILL_60: begin //����
        if (TargeTBaseObject <> nil) and TargeTBaseObject.m_boDeath and
          PlayObject.IsProperFriend(TargeTBaseObject) and
          (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) and
          (not TPlayObject(TargeTBaseObject).m_boAliveing) and
          (not TPlayObject(TargeTBaseObject).m_boDoctorAlive) then begin
          TPlayObject(TargeTBaseObject).m_boDoctorAlive := True;
//          if UserMagic.btLevel > 3 then
//            UserMagic.btLevel := 3;
          TPlayObject(TargeTBaseObject).m_btDoctorAliveLevel := _MIN(100, _MAX(10, Round((UserMagic.btLevel+1)/(UserMagic.MagicInfo.btTrainLv+1)*100)));
          TPlayObject(TargeTBaseObject).SendDefMsg(TargeTBaseObject, SM_DOCTORALIVE, 0, 0, 0, 0, '');
          TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
          boTrain := True;
        end;
      end;
    SKILL_61: begin //Ⱥ��
        boTrain := True;
      end;
    SKILL_62: begin //��Ѫ ҽ����
        if PlayObject.m_PEnvir.GetEvent(nTargetX, nTargetY) = nil then begin
          g_EventManager.AddEvent(TFireBurnEvent.Create(PlayObject, nTargetX, nTargetY, ET_INCHP, 10 * 1000, 100));
        end; //00492E3E
        boTrain := True;
      end;
    SKILL_63: begin   //���λ�λ
        //if PlayObject.m_PEnvir.CanWalk(nTargetX, nTargetY) then
        MapFlag := [];
        if g_Config.boSkill63RunHum then MapFlag := MapFlag + [wf_Hum];
        if g_Config.boSkill63RunMon then MapFlag := MapFlag + [wf_Mon];
        if g_Config.boSkill63RunNpc then MapFlag := MapFlag + [wf_Npc];
        if g_Config.boSkill63RunGuard then MapFlag := MapFlag + [wf_Guard];
        if g_Config.boSkill63WarDisHumRun then MapFlag := MapFlag + [wf_War];
        if PlayObject.m_PEnvir.CanWalkEx(nTargetX, nTargetY, MapFlag) then begin
          if Random(4) < _MAX(1, UserMagic.btLevel) then begin
            with PlayObject do begin
              if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, PlayObject, nTargetX, nTargetY, True) > 0 then begin
                m_nCurrX := nTargetX;
                m_nCurrY := nTargetY;
                // 2023-12-21 ���������Ͷ���λ��
                TPlayObject(PlayObject).SendGroupMsg(PlayObject, SM_GROUPINFO1, Integer(PlayObject), 0, 0, 0, 'GROUP_POSITION');
                GetStartType();
                boMove := True;
                boTrain := True;
              end;
            end;
          end;
        end;
      end;
    SKILL_65: begin //�ٻ�����
        if MagMakeMoonSlave(PlayObject, UserMagic) then begin
            boTrain := True;
          end;
      end;
    SKILL_66: begin // ��˪ѩ��
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        end;
        if MagDoubleBigExplosionEx(PlayObject,
          nPower,
          nTargetX,
          nTargetY,
          1, UserMagic.wMagIdx, True) then
          boTrain := True;
      end;
    SKILL_70: begin // ʮ��һɱ
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.DC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.DC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC)) + 1);
        end;
        if MagBigExplosionAndMakePoisonByWarr(PlayObject, UserMagic,
          nPower,
          nTargetX,
          nTargetY,
          3,
          boMove) then
          boTrain := True;
      end;
    SKILL_71: begin // ��˪Ⱥ��
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower:=PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                           SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        end;
        if MagBigExplosionAndMakePoisonEx(PlayObject, UserMagic,
          nPower,
          nTargetX,
          nTargetY,
          3) then
          boTrain := True;
      end;
    SKILL_72: begin  // ����֮��
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.SC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower:=PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.SC),
                                           SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
        end;
        if MagBigExplosionAndMakePoison(PlayObject, UserMagic,
          nPower,
          nTargetX,
          nTargetY,
          3) then
          boTrain := True;
      end;
    SKILL_114: begin
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        end;
        nPower := ROUND(nPower * (g_Config.nSkill114PowerRate / 100));
        if MagMakeCBOBase(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_115: begin
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        end;
      
        nPower := ROUND(nPower * (g_Config.nSkill115PowerRate / 100));
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_116: begin
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      end;
        
        nPower := ROUND(nPower * (g_Config.nSkill116PowerRate / 100));
        if MagMakeCBOBase(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_117: begin
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        end;

        nPower := ROUND(nPower * (g_Config.nSkill117PowerRate / 100));
        if MagBigExplosion(PlayObject,
          nPower,
          nTargetX,
          nTargetY,
          2, UserMagic.wMagIdx) then
          boTrain := True;
      end;
    SKILL_118: begin
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.SC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.SC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
        end;

        nPower := ROUND(nPower * (g_Config.nSkill118PowerRate / 100));
        if MagMakeFireCharmEx(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_119: begin
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.SC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.SC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
        end;

        nPower := ROUND(nPower * (g_Config.nSkill119PowerRate / 100));
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_120: begin
      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.SC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.SC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
        end;

        nPower := ROUND(nPower * (g_Config.nSkill120PowerRate / 100));
        if MagMakeFireCharmEx(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_121: begin
        if TargeTBaseObject <> nil then begin
          if CheckMagicRate(UserMagic) then begin
            nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.SC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                                 Round((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC) + 1) *
                                                 (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
          end
          else begin
            nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.SC),
                                                 SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
            end;

          nPower := ROUND(nPower * (g_Config.nSkill121PowerRate / 100));
          if MagBigExplosionTime(PlayObject,
            nPower,
            TargeTBaseObject.m_nCurrX,
            TargeTBaseObject.m_nCurrY,
            2, UserMagic.wMagIdx) then
            boTrain := True;
        end;
      end;
    SKILL_123: begin //ŭ������

      end;
    SKILL_124: begin //����ٵ�
        nPower := 0;
        nTargetX := PlayObject.m_nCurrX;
        nTargetY := PlayObject.m_nCurrY;
        if PlayObject.m_btJob = 0 then
          if CheckMagicRate(UserMagic) then begin
            nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.DC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                                 Round((HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC) + 1) *
                                                 (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
          end
          else begin
            nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.DC),
                                                 SmallInt(HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC)) + 1);
            end;
        if PlayObject.m_btJob = 1 then
          if CheckMagicRate(UserMagic) then begin
            nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                                 Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                                 (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
          end
          else begin
            nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                                 SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
            end;
        if PlayObject.m_btJob = 2 then
          if CheckMagicRate(UserMagic) then begin
            nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.SC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                                 Round((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC) + 1) *
                                                 (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
          end
          else begin
            nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.SC),
                                                 SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
            end;

        nPower := Round(g_Config.nEtenPowerRate / 100 * nPower);
        if MagBigExplosionTime(PlayObject,
            nPower,
            PlayObject.m_nCurrX,
            PlayObject.m_nCurrY,
            g_Config.nEtenMagicSize, UserMagic.wMagIdx) then
            boTrain := True;
      end;
  else begin
      //boTrain := True;
        {if Assigned(zPlugOfEngine.SetHookDoSpell) then begin
          try
            boTrain := zPlugOfEngine.SetHookDoSpell(Self, PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject, boSpellFail, boSpellFire);
          except
          end;
        end;  }
    end;
  end;
  if boSpellFail then
    Exit;
  if boSpellFire then begin
    PlayObject.SendRefMsg(RM_MAGICFIRE, 0, MakeLong(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
      MakeLong(nTargetX, nTargetY), Integer(TargeTBaseObject), '');
  end;
  // 9�������¼��ܣ�����Ҫ������
  if (UserMagic.MagicInfo.btTrainLv <= 9) and (UserMagic.btLevel < UserMagic.MagicInfo.btTrainLv)  and (boTrain) then begin
    if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] <= PlayObject.m_Abil.Level then begin
      PlayObject.TrainSkill(UserMagic, Random(3) + 1);
      if not PlayObject.CheckMagicLevelup(UserMagic) then begin
        PlayObject.SendDelayDefMsg(PlayObject, SM_MAGIC_LVEXP, UserMagic.MagicInfo.wMagicId,
          UserMagic.btLevel, UserMagic.nTranPoint, 0, '', 1000);
      end;
    end;
  end;
  if (UserMagic.MagicInfo.wMagicId = SKILL_70) and boMove then begin
    PlayObject.SendRefMsg(RM_MAGICMOVE, PlayObject.m_btDirection, PlayObject.m_nCurrX, PlayObject.m_nCurrY, 0, '');
  end else
  if (UserMagic.MagicInfo.wMagicId = SKILL_63) and boMove then begin
    PlayObject.SendRefMsg(RM_MAGICFIR, PlayObject.m_btDirection, PlayObject.m_nCurrX, PlayObject.m_nCurrY, 0, '');
  end;
  Result := True;
end;

    { ������ }
function TMagicManager.MagMakePrivateTransparent(BaseObject: TBaseObject;
  nHTime: Integer): Boolean; //004930E8
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] > 0 then
    Exit; //4930FE
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, BaseObject.m_nCurrX,
    BaseObject.m_nCurrY, 9, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and
      (TargeTBaseObject.m_TargetCret = BaseObject) then begin
      if (abs(TargeTBaseObject.m_nCurrX - BaseObject.m_nCurrX) > 1) or
        (abs(TargeTBaseObject.m_nCurrY - BaseObject.m_nCurrY) > 1) or
        (Random(2) = 0) then begin
        TargeTBaseObject.m_TargetCret := nil;
      end;
    end;
  end;
  BaseObjectList.Free;
  BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] := nHTime; //004931D2
  BaseObject.m_dwStatusArrTick[STATE_TRANSPARENT {0x70}] := GetTickCount; //004931D2
  BaseObject.m_nCharStatus := BaseObject.GetCharStatus();
  BaseObject.StatusChanged();
  BaseObject.m_boHideMode := True;
  BaseObject.m_boTransparent := True;
  BaseObject.ChangeStatusMode(STATUS_HIDEMODE, True);
  Result := True;
end;

function TMagicManager.MagReturn(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean; //00492368
begin
  //  Result := False;
  TargeTBaseObject.ReAlive;
  TargeTBaseObject.m_WAbil.HP := TargeTBaseObject.m_WAbil.MaxHP;
  TargeTBaseObject.SendAbility;
  Result := True;
end;

function TMagicManager.MagTamming2(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean;
//var
//  n14: Integer;
begin
  Result := False;
  if (TargeTBaseObject = nil) or (TargeTBaseObject.m_btRaceServer < RC_ANIMAL) then
    exit;
  if (TargeTBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and ((Random(4 - nMagicLevel) = 0)) then begin
    TargeTBaseObject.m_TargetCret := nil;
    if Random(2) = 0 then begin
      if TargeTBaseObject.m_Abil.Level <= BaseObject.m_Abil.Level + 2 then begin
        if Random(3) = 0 then begin
          if Random((BaseObject.m_Abil.Level + 20) + (nMagicLevel * 5)) >
            (TargeTBaseObject.m_Abil.Level + g_Config.nMagTammingTargetLevel {10}) then begin
            if {not (TargeTBaseObject.bo2C1) and  }
              (TargeTBaseObject.m_btLifeAttrib = 0) and
              (TargeTBaseObject.m_Abil.Level < g_Config.nMagTammingLevel {50})
              and
              (BaseObject.m_SlaveList.Count < g_Config.nMagTammingCount{(nMagicLevel + 2)}) then begin
              TargeTBaseObject.m_Master := BaseObject;
              TargeTBaseObject.m_btWuXin := 0;
              TargeTBaseObject.m_dwMasterRoyaltyTick :=
                LongWord((Random(BaseObject.m_Abil.Level * 2) + (nMagicLevel shl 2)
                * 5 + 20) * 60 * 1000) + GetTickCount;
              TargeTBaseObject.m_btSlaveMakeLevel := nMagicLevel;
              if TargeTBaseObject.m_dwMasterTick = 0 then
                TargeTBaseObject.m_dwMasterTick := GetTickCount();
              TargeTBaseObject.BreakHolySeizeMode();
              if LongWord(1500 - nMagicLevel * 200) <
                LongWord(TargeTBaseObject.m_nWalkSpeed) then begin
                TargeTBaseObject.m_nWalkSpeed := 1500 - nMagicLevel * 200;
              end;
              if LongWord(2000 - nMagicLevel * 200) <
                LongWord(TargeTBaseObject.m_nNextHitTime) then begin
                TargeTBaseObject.m_nNextHitTime := 2000 - nMagicLevel * 200;
              end;
              TargeTBaseObject.ReAlive;
              TargeTBaseObject.m_WAbil.HP := TargeTBaseObject.m_WAbil.MaxHP;
              TargeTBaseObject.SendAbility;
              TargeTBaseObject.RefShowName();
              BaseObject.m_SlaveList.Add(TargeTBaseObject);
            end;
          end;
        end
        else begin
          if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) =
            0) then
            TargeTBaseObject.OpenCrazyMode(Random(20) + 10);
        end;
      end
      else begin
        if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
          TargeTBaseObject.OpenCrazyMode(Random(20) + 10); //���
      end;
    end;
  end;
  Result := True;
end;

function TMagicManager.MagTamming(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean;
var
//  n14: Integer;
  levelGap: Integer;
begin
  Result := False;
  if (TargeTBaseObject = nil) or (TargeTBaseObject.m_btRaceServer < RC_ANIMAL) then
    exit;
  // ���ܵȼ����ӵļ��ʣ�25% -- 33% -- 50% -- 100%
  if (TargeTBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and ((Random(4) - nMagicLevel) <= 0) then begin
    TargeTBaseObject.m_TargetCret := nil;
    if TargeTBaseObject.m_Master = BaseObject then begin
      // �Ż������Լ��ı�����Ҫ��˲���
//      TargeTBaseObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
      Result := True;
    end
    else begin
      // 50%
      if Random(2) = 0 then begin
        // ����ȼ��ȹ���ȼ��� 10 ��Ҳ���Դ���
        if TargeTBaseObject.m_Abil.Level <= BaseObject.m_Abil.Level + 10 then begin
          // 33%
          if Random(3) = 0 then begin
            // ����ȼ��ȹ���ȼ��;��� ��������� -10�����������
            levelGap := TargeTBaseObject.m_Abil.Level - BaseObject.m_Abil.Level;
            // ԭ�����㷨������ȼ�Խ�ߣ����ܵĵȼ�Խ����Ӱ��ɹ����ʣ�
            // �� 10������ 10�������� 0--3����33% -- 43% -- 50% -- 55%
            // �� 50������ 10�������� 0--3����71% -- 73% -- 75% -- 76%
            // �� 50������ 50�������� 0--3����14% -- 20% -- 25% -- 29%
            // �Ż����Ӵ��ܵȼ���Ӱ������
            if Random(100) > Round((nMagicLevel * (levelGap + g_Config.nMagTammingTargetLevel {10}) + 1)) then begin
              if {not (TargeTBaseObject.bo2C1) and }
                // �ǲ���ϵ���������ջ�
                (TargeTBaseObject.m_btLifeAttrib = 0) and
                    // ȥ���ȼ�����
//                (TargeTBaseObject.m_Abil.Level < g_Config.nMagTammingLevel {50}) and
                (BaseObject.m_SlaveList.Count < g_Config.nMagTammingCount {(nMagicLevel + 2)}) then begin
                  // �Ż���MaxHP >> HP��Ѫ��Խ�ͼ���Խ��
//                n14 := TargeTBaseObject.m_WAbil.HP div g_Config.nMagTammingHPRate {100};
//                if n14 <= 2 then
//                  n14 := 2;
//                else
                  // �Ż���������������Ҫ��ô��̬�ļ���
//                  Inc(n14, n14);// n * 2
                // ȥ�������ļ��ʿ���
                if (TargeTBaseObject.m_Master <> BaseObject) {and (Random(n14) = 0)} then begin
                  TargeTBaseObject.BreakCrazyMode();
                  if TargeTBaseObject.m_Master <> nil then begin
                    TargeTBaseObject.m_WAbil.HP := TargeTBaseObject.m_WAbil.HP div 10;
                  end;
                  TargeTBaseObject.m_Master := BaseObject;
                  TargeTBaseObject.m_btWuXin := 0;
                  // ���ʱ�䣺([0--20) + (([0--3] * 4) * 5 + 20)) * 1m == 20m -- 100m��ÿ������ + 20m
                  // �Ż����� 0 �������ˣ���� 1440 ����Ҳ���� 24 Сʱ
                  TargeTBaseObject.m_dwMasterRoyaltyTick := LongWord((Random(BaseObject.m_Abil.Level * 2) +
                    (nMagicLevel shl 2) * 5 + 1440) * 60 * 1000) + GetTickCount;
                  TargeTBaseObject.m_btSlaveMakeLevel := nMagicLevel;
                  // ��¼�ٻ�ʱ�䣬δ������ 3 Сʱ�����������Ż�Ϊ��������
                  if TargeTBaseObject.m_dwMasterTick = 0 then TargeTBaseObject.m_dwMasterTick := GetTickCount();
                  TargeTBaseObject.BreakHolySeizeMode();
                  // ���ܵȼ�Ӱ������ƶ��ٶ�
                  if LongWord(1500 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nWalkSpeed) then begin
                    TargeTBaseObject.m_nWalkSpeed := 1500 - nMagicLevel * 200;
                  end;
                  // ���ܵȼ�Ӱ����﹥�����
                  if LongWord(2000 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nNextHitTime) then begin
                    TargeTBaseObject.m_nNextHitTime := 2000 - nMagicLevel * 200;
                  end;
                  TargeTBaseObject.RefShowName();
                  BaseObject.m_SlaveList.Add(TargeTBaseObject);
                end
              end
              else begin //004925F2
                // 7% �ļ�����ɱ���ڱ����б������������
                if Random(14) = 0 then
                  TargeTBaseObject.m_WAbil.HP := 0;
              end;
            end
            else begin //00492615
              // �Էǲ���ϵ�� 5% -- 20% �ļ�����ɱ
              if (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) <= nMagicLevel) then
                TargeTBaseObject.m_WAbil.HP := 0;
            end
          end
          else begin //00492641
            // ���ٻ��Ĺ��30% * 5% ���ʺ���
            if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) = 0) then
              TargeTBaseObject.OpenCrazyMode(Random(20) + 10);
          end;
        end
        else begin //00492674
          // �ȼ�����������£��������� 66%��ʱ�� 10s -- 30s
          if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
            TargeTBaseObject.OpenCrazyMode(Random(20) + 10); //���
        end;
      end
      else begin //00492699 50% ���ʽ���˷�֧
        // 10% �ļ��ʴ����������յ������Ŀ��ٻ����﹥������������̵���
        if Random(5) = 0 then begin
          // ʱ�� 10s
          if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
            TargeTBaseObject.OpenCrazyMode(10); //���
        end
        else
          // 50% * 90% ���ʻ�������൱�ڼ򻯰���ԣ�ʱ����10s -- 25s
          TargeTBaseObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
      end;
      Result := True;
    end;
  end
  else begin
    if Random(2) = 0 then
      Result := True;
  end;
end;

function TMagicManager.MagTurnUndead(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nLevel: Integer): Boolean; //004926D4
var
  levelGap: Integer;
begin
  Result := False;
  if TargeTBaseObject.m_boSuperMan or not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
    Exit;
  TAnimalObject(TargeTBaseObject).Struck {FFEC}(BaseObject);
  if TargeTBaseObject.m_TargetCret = nil then begin
    TAnimalObject(TargeTBaseObject).m_boRunAwayMode := True;
    TAnimalObject(TargeTBaseObject).m_dwRunAwayStart := GetTickCount();
    TAnimalObject(TargeTBaseObject).m_dwRunAwayTime := 10 * 1000;
  end;
  BaseObject.SetTargetCreat(TargeTBaseObject);
  // �������� 1% -- 31% -- 61% -- 91%
  if (Random(100) <= Round(nLevel * 30)) then begin
//    if TargeTBaseObject.m_Abil.Level < g_Config.nMagTurnUndeadLevel then begin
      levelGap := Max(0, BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level);
      // ��Ѫ���ʣ�(10 + levelGap) * level %
      // 0����Ҫ�ȼ��� 90 �� 100% ����
      // 1����Ҫ 40��2����Ҫ 23��3����Ҫ 15
      if Random(100) < ((nLevel+1) *(10 + levelGap)) then begin
        TargeTBaseObject.SetLastHiter(BaseObject);
        // 10% ��ǰ����ֵ�ĵ�Ѫ
        TargeTBaseObject.m_WAbil.HP := Max(0, Round(TargeTBaseObject.m_WAbil.HP - TargeTBaseObject.m_WAbil.HP div 10));
        // ��ɱ���ʣ� 5%
        if (Random(20) <= 1) then
          TargeTBaseObject.m_WAbil.HP := 0;
      end;
//    end;
        Result := True;
  end;
end;

function TMagicManager.MagWindTebo(PlayObject: TPlayObject;
  UserMagic: pTUserMagic): Boolean;
var
  PoseBaseObject: TBaseObject;
begin
  Result := False;
  PoseBaseObject := PlayObject.GetPoseCreate;
  if (PoseBaseObject <> nil) and
    (PoseBaseObject <> PlayObject) and
    (not PoseBaseObject.m_boDeath) and
    (not PoseBaseObject.m_boGhost) and
    (PlayObject.IsProperTarget(PoseBaseObject)) and
    (not PoseBaseObject.m_boStickMode) then begin
    if (abs(PlayObject.m_nCurrX - PoseBaseObject.m_nCurrX) <= 1) and
      (abs(PlayObject.m_nCurrY - PoseBaseObject.m_nCurrY) <= 1) and
      (PlayObject.m_Abil.Level > PoseBaseObject.m_Abil.Level) then begin
      if Random(20) < UserMagic.btLevel * 6 + 6 + (PlayObject.m_Abil.Level - PoseBaseObject.m_Abil.Level) then begin
        PoseBaseObject.CharPushed(GetNextDirection(PlayObject.m_nCurrX,
          PlayObject.m_nCurrY, PoseBaseObject.m_nCurrX, PoseBaseObject.m_nCurrY),
          _MAX(0, UserMagic.btLevel - 1) + 1);
        Result := True;
      end;
    end;
  end;
end;

function TMagicManager.MagSaceMove(BaseObject: TBaseObject;
  nLevel: Integer): Boolean;
var
  Envir: TEnvirnoment;
  PlayObject: TPlayObject;
begin
  Result := False;
  // 0 -- 4/11��3 -- 10 / 11
  if Random(11) < nLevel * 2 + 4 then begin
    BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE2, 0, 0, 0, 0, '');
    if BaseObject is TPlayObject then begin
      Envir := BaseObject.m_PEnvir;
      // BaseObject.m_sHomeMap �ĳɵ�ǰ������ͼ���������������
      BaseObject.MapRandomMove(Envir, 0);
      if (Envir <> BaseObject.m_PEnvir) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        PlayObject := TPlayObject(BaseObject);
        PlayObject.m_boTimeRecall := False;
      end;
    end;
    Result := True;
  end;
end;

function TMagicManager.MagGroupFengPo(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then
      Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
        nPower := PlayObject.GetAttackPower(LoWord(PlayObject.m_WAbil.SC),
                                             SmallInt((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC))));
      {if (Random(BaseObject.m_btSpeedPoint) >= PlayObject.m_btHitPoint) then begin
        nPower := 0;
      end;}
      if nPower > 0 then begin
        // fixme ��ҪŪ����ⲿ������
        nPower := BaseObject.GetHitStruckDamage(PlayObject, nPower);
      end;
      if nPower > 0 then begin
        BaseObject.StruckDamage(nPower, PlayObject);
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 2, Integer(BaseObject), '', 200);
      end;
      if BaseObject.m_btRaceServer >= RC_ANIMAL then
        Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagGroupAmyounsul(PlayObject: TPlayObject
  { �޸� TBaseObject};
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
  {procedure sub_4934B4;
  begin
    if PlayObject.m_UseItems[U_ARMRINGL].Dura < 1 then begin
      PlayObject.m_UseItems[U_ARMRINGL].Dura := 0;
      PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
      PlayObject.m_UseItems[U_ARMRINGL].wIndex := 0;
    end;
  end;   }
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
  StdItem: pTStdItem;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      if CheckAmulet(PlayObject, 1, 2) then begin
        StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
        if StdItem <> nil then begin
          UseAmulet(PlayObject, 1, 2);
          //if Random(BaseObject.m_btAntiPoison + 7) <= 6 then begin
          case StdItem.Shape of
            1: begin
                nPower := GetPower13(40, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                BaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH
                  {�ж����� - �̶�}, nPower, Integer(PlayObject),
                  ROUND(UserMagic.btLevel / 3 * (nPower /
                  g_Config.nAmyOunsulPoint)) {UserMagic.btLevel},0, '', 1000);
                BaseObject.MagicQuest(PlayObject, SKILL_GROUPAMYOUNSUL, mfs_TagEx);
              end;
            2: begin
                nPower := GetPower13(30, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                BaseObject.SendDelayMsg(PlayObject, RM_POISON,
                  POISON_DAMAGEARMOR {�ж����� - �춾}, nPower,
                  Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower /
                  g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, 0,'', 1000);
                BaseObject.MagicQuest(PlayObject, SKILL_GROUPAMYOUNSUL, mfs_TagEx);
              end;
          end;
          if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer >= RC_ANIMAL) then
            Result := True;
          BaseObject.SetLastHiter(PlayObject);
          PlayObject.SetTargetCreat(BaseObject);
          //end;
          //sub_4934B4;
        end;
      end;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagGroupDeDing(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower, nDamage: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  nPower := PlayObject.GetAttackPower(LoWord(PlayObject.m_WAbil.DC), SmallInt((HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC))));
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if (not g_Config.boDedingAllowPK) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then Continue;
    if (not g_Config.boDedingAllowPK) and (BaseObject.m_Master <> nil) and (BaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      if not (Random(BaseObject.m_btSpeedPoint) >= PlayObject.m_btHitPoint) then begin
        if nPower > 0 then begin
          nDamage := BaseObject.GetHitStruckDamage(PlayObject, nPower);
          if nDamage > 0 then begin
            nDamage := ROUND(nDamage * (g_Config.nDidingPowerRate / 100));
            if nDamage > 0 then begin
              PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), Integer(BaseObject), '', 200);
              BaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
            end;
          end;
        end;
        PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 1, '', 200);
      end;
      if BaseObject.m_btRaceServer >= RC_ANIMAL then
        Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagGroupLightening(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
  nRate: Integer;
begin
  Result := False;
  boSpellFire := True;
  BaseObjectList := TList.Create;
  nRate := _MAX(1, UserMagic.btLevel);
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, nRate, BaseObjectList);

  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then
      Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      //if (Random(10) >= BaseObject.m_nAntiMagic) then begin

      if CheckMagicRate(UserMagic) then begin
        nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.MC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                             Round((HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC) + 1) *
                                             (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
      end
      else begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
                                             SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        end;
      if BaseObject.m_btLifeAttrib = LA_UNDEAD then
        nPower := ROUND(nPower * 1.5);

      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
        nTargetX, nTargetY, nRate, Integer(BaseObject), '', 500);
      BaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      //PlayObject.SendMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '');
      //if PlayObject.m_btRaceServer = RC_PLAYMOSTER then Result := True
      //else
      if BaseObject.m_btRaceServer >= RC_ANIMAL then
        Result := True;
      //end;
      //if (BaseObject.m_nCurrX <> nTargetX) or (BaseObject.m_nCurrY <> nTargetY) then
        //PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 4 {type}, '');
    end;
  end;
  PlayObject.SendRefMsg(RM_10205, 0, nTargetX, nTargetY, MakeLong(1, nRate), '', 400);
  BaseObjectList.Free;
end;

function TMagicManager.MagLightening(PlayObject: TPlayObject {�޸� TBaseObject};
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  //boSpellFail: Boolean;
  nPower: Integer;
  StdItem: pTStdItem;
  function GetPower13(nInt: Integer): Integer; //0049338C
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := ROUND(d18 / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower -
      UserMagic.MagicInfo.btDefPower)));
  end;
  function GetRPow(wInt: Integer): Word;
  begin
    if HiWord(wInt) > LoWord(wInt) then begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end
    else
      Result := LoWord(wInt);
  end;

begin //ʩ����
  Result := False;
  //boSpellFail := True;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    if CheckAmulet(PlayObject, 1, 2) then begin
      StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
      if StdItem <> nil then begin
        UseAmulet(PlayObject, 1, 2);
        if Random(TargeTBaseObject.m_btAntiPoison + 7) <= 6 then begin
          case StdItem.Shape of
            1: begin
                nPower := GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON,
                  POISON_DECHEALTH {�ж����� - �̶�}, nPower, Integer(PlayObject),
                  ROUND(UserMagic.btLevel / 3 * (nPower /
                  g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, 0,'', 800);
                TargeTBaseObject.MagicQuest(PlayObject, SKILL_AMYOUNSUL, mfs_TagEx);
              end;
            2: begin
                nPower := GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON,
                  POISON_DAMAGEARMOR {�ж����� - �춾}, nPower,
                  Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower /
                  g_Config.nAmyOunsulPoint)) {UserMagic.btLevel},0, '', 800);
                TargeTBaseObject.MagicQuest(PlayObject, SKILL_AMYOUNSUL, mfs_TagEx);
              end;
          end;
          if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or
            (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
            Result := True;
        end;
        PlayObject.SetTargetCreat(TargeTBaseObject);
        //boSpellFail := False;
      end;
    end;
  end;
end;

function TMagicManager.MagWideAttack(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  BaseObjectList: TList;
  nTargetX, nTargetY: Integer;
  I, nPower: Integer;
  TargeBaseObject: TBaseObject;
begin
  Result := False;
  PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, PlayObject.m_btDirection, 2, nTargetX, nTargetY);
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, 1, BaseObjectList);
  with PlayObject do
    if CheckMagicRate(UserMagic) then begin
      nPower := PlayObject.GetAttackPower(Round(LoWord(PlayObject.m_WAbil.DC) * (1 + GetPower(MPow(UserMagic), UserMagic) / 100)),
                                           Round((HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC) + 1) *
                                           (1 + GetPower(MPow(UserMagic), UserMagic) / 100)));
    end
    else begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.DC),
                                SmallInt(HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC)) + 1);
      end;
  if nPower > 0 then begin
//    nPower := Round(nPower * (0.34 * _MAX(1, UserMagic.btLevel)));
    for I := 0 to BaseObjectList.Count - 1 do begin
      TargeBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if PlayObject.IsProperTarget(TargeBaseObject) then begin
        TargeBaseObject.SendDelayMsg(PlayObject, RM_MAGSTRUCK, 0, nPower, 0, 0, 0,'', 200);
        TargeBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        Result := True;
      end;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagHbFireBall(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY, nPower: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  //nPower: Integer;
  nDir: Integer;
  levelgap: Integer;
  push: Integer;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if not PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    TargeTBaseObject := nil;
    Exit;
  end;
  if not PlayObject.IsProperTarget(TargeTBaseObject) then begin
    //TargeTBaseObject := nil;
    Exit;
  end;
  if (TargeTBaseObject.m_nAntiMagic > Random(10)) then begin
    Exit;
  end;
  {with PlayObject do begin
    nPower := GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.MC),
      SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
  end;  }
  PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, nTargetX, nTargetY, 2, Integer(TargeTBaseObject), '',
    200 + (abs(PlayObject.m_nCurrX - nTargetX) + abs(PlayObject.m_nCurrY - nTargetY)) div 2 * 20);
  //PlayObject.SendMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '');
  if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
    Result := True;

  if {(PlayObject.m_Abil.Level > TargeTBaseObject.m_Abil.Level) and} (not TargeTBaseObject.m_boStickMode) then begin
    levelgap := PlayObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
    // 2021-01-05 �Ż�Ϊ��ÿ������ +5% ���ʣ�ÿ 1 ���ȼ��� ��1% ����
    // ��������Ϊ 15% ���ʣ��߳� 85 ��ʱ���ﵽ 100% ���ʣ����� 15 ��ʱ������Ϊ 0% ����
    // todo ����ֵ������
    if (Random(100) < (UserMagic.btLevel * 5 + levelgap)) then begin
//      push := Random(UserMagic.btLevel) + 1;
      //if push > 0 then begin
//      nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);
//      PlayObject.SendDelayMsg(PlayObject, RM_DELAYPUSHED, nDir,
//        MakeLong(nTargetX, nTargetY), push, Integer(TargeTBaseObject), '',
//        200 + (abs(PlayObject.m_nCurrX - nTargetX) + abs(PlayObject.m_nCurrY - nTargetY)) div 2 * 20);

      // 2021-01-05 �Ż�Ϊ��Ĭ�� 12% ���ʴ�����ÿ������ +6% ���ʣ�ÿ 1 ���ȼ��� ��3% ����
      // ��������Ϊ 30% ���ʣ��߳� 24 ��ʱ���ﵽ 100% ���ʣ����� 10 ��ʱ������Ϊ 0% ����
      // todo ����ֵ������
//      if (Random(100) < (12 + UserMagic.btLevel * 6 + levelgap * 3)) then begin
        TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_COBWEB
            {�ж����� - ����}, Round(1+Random(UserMagic.btLevel+1)), Integer(PlayObject), 0, 0, '',
            200 + (abs(PlayObject.m_nCurrX - nTargetX) + abs(PlayObject.m_nCurrY - nTargetY)) div 2 * 20);
//      end;

      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
    end;
  end;
end;

//����������״�Ļ�

function TMagicManager.MagMakeSuperFireCross(PlayObject: TPlayObject; nDamage,
  nHTime, nX, nY: Integer; nCount: Integer): Integer;
  function MagMakeSuperFireCrossOfDir(btDir: Integer): Integer;
  var
    FireBurnEvent: TFireBurnEvent;
    i, {ii,} x, y: Integer;
    nTime: Integer;
    //    x1, x2, y1, y2: string;
  begin
    //    Result := 0;
    nTime := 1;
    case btDir of
      DR_UP: begin
          for y := PlayObject.m_nCurrY downto PlayObject.m_nCurrY - 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject,
              PlayObject.m_nCurrX, y, ET_FIRE, nHTime * nTime, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_UPRIGHT: begin
          for i := 0 to 6 do begin
            x := PlayObject.m_nCurrX + i;
            y := PlayObject.m_nCurrY - i;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE,
              nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_RIGHT: begin
          for x := PlayObject.m_nCurrX to PlayObject.m_nCurrX + 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, PlayObject.m_nCurrY, ET_FIRE, nHTime * nTime,
              nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_DOWNRIGHT: begin
          for i := 0 to 6 do begin
            x := PlayObject.m_nCurrX + i;
            y := PlayObject.m_nCurrY + i;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE,
              nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_DOWN: begin
          for y := PlayObject.m_nCurrY to PlayObject.m_nCurrY + 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject,
              PlayObject.m_nCurrX, y, ET_FIRE, nHTime * nTime, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_DOWNLEFT: begin
          for i := 0 to 6 do begin
            x := PlayObject.m_nCurrX - i;
            y := PlayObject.m_nCurrY + i;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE,
              nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_LEFT: begin
          for x := PlayObject.m_nCurrX downto PlayObject.m_nCurrX - 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x,
              PlayObject.m_nCurrY, ET_FIRE, nHTime * nTime, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_UPLEFT: begin
          for i := 0 to 6 do begin
            x := PlayObject.m_nCurrX - i;
            y := PlayObject.m_nCurrY - i;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE,
              nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
    end;
    Result := 1;
  end;
var
  i: Integer;
begin
  Result := 0;
  case nCount of
    1: begin
        Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
      end;
    3: begin
        case PlayObject.m_btDirection of
          DR_UP: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
            end;
          DR_UPRIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UP);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
          DR_RIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWNRIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_RIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
            end;
          DR_DOWN: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWNLEFT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWN);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
            end;
          DR_LEFT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
            end;
          DR_UPLEFT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
            end;
        end;
      end;
    4: begin
        {Result := }MagMakeSuperFireCrossOfDir(DR_UP);
        {Result := }MagMakeSuperFireCrossOfDir(DR_LEFT);
        {Result := }MagMakeSuperFireCrossOfDir(DR_DOWN);
        Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
      end;
    5: begin
        case PlayObject.m_btDirection of
          DR_UP, DR_UPLEFT, DR_UPRIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(DR_UP);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPLEFT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
          DR_LEFT: begin
              {Result := }MagMakeSuperFireCrossOfDir(DR_UP);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWN);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPLEFT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
            end;
          DR_RIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(DR_UP);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWN);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_RIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWN, DR_DOWNLEFT, DR_DOWNRIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWN);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
        end;
      end;
    8: begin
        for i := DR_UP to DR_UPLEFT do
          Result := MagMakeSuperFireCrossOfDir(i);
      end;
  end;
end;

//��ǽ

function TMagicManager.MagMakeFireCross(PlayObject: TPlayObject; nDamage,
  nHTime, nX, nY: Integer): Integer; //00492C9C
var
  FireBurnEvent: TFireBurnEvent;
resourcestring
  sDisableInSafeZoneFireCross = '��ȫ��������ʹ��...';
  sDisableInSafeZoneFireCross1 = '��ǰ��ͼ������ʹ��...';
begin
  Result := 0;
  if g_Config.boDisableInSafeZoneFireCross and
    PlayObject.InSafeZone(PlayObject.m_PEnvir, nX, nY) then begin
    PlayObject.SysMsg(sDisableInSafeZoneFireCross, c_Red, t_Notice);
    Exit;
  end;

  if PlayObject.m_PEnvir.m_boUnAllowFireMagic then begin
    PlayObject.SysMsg(sDisableInSafeZoneFireCross1, c_Red, t_Notice);
    Exit;
  end;

  if PlayObject.m_PEnvir.GetEvent(nX, nY - 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY - 1, ET_FIRE,
      nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492CFC   x
  if PlayObject.m_PEnvir.GetEvent(nX - 1, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 1, nY, ET_FIRE,
      nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492D4D
  if PlayObject.m_PEnvir.GetEvent(nX, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, ET_FIRE, nHTime *
      1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492D9C
  if PlayObject.m_PEnvir.GetEvent(nX + 1, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 1, nY, ET_FIRE,
      nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492DED
  if PlayObject.m_PEnvir.GetEvent(nX, nY + 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY + 1, ET_FIRE,
      nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492E3E
  Result := 1;
end;

function TMagicManager.MagBigExplosionAndMakePoisonByWarr(BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer; var boMove: Boolean): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  PlayObject: TPlayObject;
  nPowerPoint: Integer;
  nTime: Integer;
  MakePoisonInfo: pTMakePoisonInfo;
begin
  Result := False;
  boMove := False;
  if BaseObject.MagCanMoveTarget(nX, nY) then begin
    boMove := True;
    nX := BaseObject.m_nCurrX;
    nY := BaseObject.m_nCurrY;
    nPowerPoint := Round(g_Config.nSkill70PowerRate / 100 * nPower);
    nTime := 3 * UserMagic.btLevel + Random(2 * UserMagic.btLevel);
    if BaseObject.m_btRaceServer <> RC_PLAYOBJECT then Exit;
    PlayObject := TPlayObject(BaseObject);
    BaseObjectList := TList.Create;
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
    for i := 0 to BaseObjectList.Count - 1 do begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if BaseObject.IsProperTarget(TargeTBaseObject) then begin
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPowerPoint, nX, nY, 3, Integer(TargeTBaseObject), '', 600);
        TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        if PlayObject.m_Abil.Level > TargeTBaseObject.m_Abil.Level then begin
          if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
            if g_Config.boSkill70MbAttackHuman then begin
              New(MakePoisonInfo);
              MakePoisonInfo.BaseObject := PlayObject;
              MakePoisonInfo.nX := nX;
              MakePoisonInfo.nY := nY;
              MakePoisonInfo.nRate := 3;
              MakePoisonInfo.boFastParalysis := g_Config.boSkill70MbFastParalysis;
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {�ж����� - ���}, nTime, Integer(MakePoisonInfo), 0, 0, '', 600);
             end;
          end else begin
            if (TargeTBaseObject.m_Master <> nil) and (TargeTBaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
              if g_Config.boSkill70MbAttackSlave then begin
                New(MakePoisonInfo);
                MakePoisonInfo.BaseObject := PlayObject;
                MakePoisonInfo.nX := nX;
                MakePoisonInfo.nY := nY;
                MakePoisonInfo.nRate := 3;
                MakePoisonInfo.boFastParalysis := g_Config.boSkill70MbFastParalysis;
                TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {�ж����� - ���}, nTime, Integer(MakePoisonInfo), 0,0, '', 600);
              end;
            end else begin
              if g_Config.boSkill70MbAttackMon then begin
                New(MakePoisonInfo);
                MakePoisonInfo.BaseObject := PlayObject;
                MakePoisonInfo.nX := nX;
                MakePoisonInfo.nY := nY;
                MakePoisonInfo.nRate := 3;
                MakePoisonInfo.boFastParalysis := g_Config.boSkill70MbFastParalysis;
                TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {�ж����� - ���}, nTime, Integer(MakePoisonInfo), 0, 0, '', 600);
              end;
            end;
          end;
        end;
        Result := True;
      end;
    end;
    BaseObjectList.Free;
  end;
end;

function TMagicManager.MagBigExplosionAndMakePoisonEx(BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  PlayObject: TPlayObject;
  nPowerPoint: Integer;
  nTime: Integer;
  MakePoisonInfo: pTMakePoisonInfo;
begin
  Result := False;
  nPowerPoint := Round(g_Config.nSkill71PowerRate / 100 * nPower);
  nTime := 3 * UserMagic.btLevel + Random(2 * UserMagic.btLevel);
  if BaseObject.m_btRaceServer <> RC_PLAYOBJECT then Exit;
  PlayObject := TPlayObject(BaseObject);
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperTarget(TargeTBaseObject) then begin
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPowerPoint, nX, nY, 3, Integer(TargeTBaseObject), '', 600);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      if PlayObject.m_Abil.Level > TargeTBaseObject.m_Abil.Level then begin
        if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if g_Config.boSkill71MbAttackHuman then begin
            New(MakePoisonInfo);
            MakePoisonInfo.BaseObject := PlayObject;
            MakePoisonInfo.nX := nX;
            MakePoisonInfo.nY := nY;
            MakePoisonInfo.nRate := 3;
            MakePoisonInfo.boFastParalysis := g_Config.boSkill71MbFastParalysis;
            TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {�ж����� - ���}, nTime, Integer(MakePoisonInfo), 0, 0, '', 600);
           end;
        end else begin
          if (TargeTBaseObject.m_Master <> nil) and (TargeTBaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
            if g_Config.boSkill71MbAttackSlave then begin
              New(MakePoisonInfo);
              MakePoisonInfo.BaseObject := PlayObject;
              MakePoisonInfo.nX := nX;
              MakePoisonInfo.nY := nY;
              MakePoisonInfo.nRate := 3;
              MakePoisonInfo.boFastParalysis := g_Config.boSkill71MbFastParalysis;
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {�ж����� - ���}, nTime, Integer(MakePoisonInfo), 0, 0, '', 600);
            end;
          end else begin
            if g_Config.boSkill71MbAttackMon then begin
              New(MakePoisonInfo);
              MakePoisonInfo.BaseObject := PlayObject;
              MakePoisonInfo.nX := nX;
              MakePoisonInfo.nY := nY;
              MakePoisonInfo.nRate := 3;
              MakePoisonInfo.boFastParalysis := g_Config.boSkill71MbFastParalysis;
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {�ж����� - ���}, nTime, Integer(MakePoisonInfo), 0, 0, '', 600);
            end;
          end;
        end;
      end;

      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagBigExplosionAndMakePoison(BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  PlayObject: TPlayObject;
  nPowerPoint: Integer;
  nTime: Integer;
  MakePoisonInfo: pTMakePoisonInfo;
begin
  Result := False;
  nPowerPoint := Round(g_Config.nSkill72PowerRate / 100 * nPower);
  nTime := 3 * UserMagic.btLevel + Random(2 * UserMagic.btLevel);
  if BaseObject.m_btRaceServer <> RC_PLAYOBJECT then Exit;
  PlayObject := TPlayObject(BaseObject);
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperTarget(TargeTBaseObject) then begin
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPowerPoint, nX, nY, 3, Integer(TargeTBaseObject), '', 1200);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      if g_Config.boSkill72Damagearmor then begin
        nPowerPoint := GetPower13(30, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
        New(MakePoisonInfo);
        MakePoisonInfo.BaseObject := PlayObject;
        MakePoisonInfo.nX := nX;
        MakePoisonInfo.nY := nY;
        MakePoisonInfo.nRate := 3;
        TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_DAMAGEARMOR {�ж����� - �춾}, nPower, Integer(MakePoisonInfo),
          ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, 0,'', 1200);
      end;
      if g_Config.boSkill72DecHealth then begin
        nPowerPoint := GetPower13(40, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
        New(MakePoisonInfo);
        MakePoisonInfo.BaseObject := PlayObject;
        MakePoisonInfo.nX := nX;
        MakePoisonInfo.nY := nY;
        MakePoisonInfo.nRate := 3;
        TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_DECHEALTH {�ж����� - �̶�}, nPower, Integer(MakePoisonInfo),
          ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, 0,'', 1200);
      end;

      if PlayObject.m_Abil.Level > TargeTBaseObject.m_Abil.Level then begin
        if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if g_Config.boSkill72MbAttackHuman then begin
            New(MakePoisonInfo);
            MakePoisonInfo.BaseObject := PlayObject;
            MakePoisonInfo.nX := nX;
            MakePoisonInfo.nY := nY;
            MakePoisonInfo.nRate := 3;
            MakePoisonInfo.boFastParalysis := g_Config.boSkill72MbFastParalysis;
            TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {�ж����� - ���}, nTime, Integer(MakePoisonInfo), 0, 0, '', 1200);
           end;
        end else begin
          if (TargeTBaseObject.m_Master <> nil) and (TargeTBaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
            if g_Config.boSkill72MbAttackSlave then begin
              New(MakePoisonInfo);
              MakePoisonInfo.BaseObject := PlayObject;
              MakePoisonInfo.nX := nX;
              MakePoisonInfo.nY := nY;
              MakePoisonInfo.nRate := 3;
              MakePoisonInfo.boFastParalysis := g_Config.boSkill72MbFastParalysis;
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {�ж����� - ���}, nTime, Integer(MakePoisonInfo), 0, 0, '', 1200);
            end;
          end else begin
            if g_Config.boSkill72MbAttackMon then begin
              New(MakePoisonInfo);
              MakePoisonInfo.BaseObject := PlayObject;
              MakePoisonInfo.nX := nX;
              MakePoisonInfo.nY := nY;
              MakePoisonInfo.nRate := 3;
              MakePoisonInfo.boFastParalysis := g_Config.boSkill72MbFastParalysis;
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {�ж����� - ���}, nTime, Integer(MakePoisonInfo), 0, 0, '', 1200);
            end;
          end;

        end;
      end;
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagBigExplosion(BaseObject: TBaseObject; nPower, nX,
  nY: Integer; nRage, nMagID: Integer): Boolean; //00492F4C
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperTarget(TargeTBaseObject) then begin
      BaseObject.SetTargetCreat(TargeTBaseObject);
      TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
      TargeTBaseObject.MagicQuest(BaseObject, nMagID, mfs_TagEx);
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagBigExplosionTime(BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage, nMagID: Integer): Boolean;
var
  i, nTime: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
  nTime := 400 + (abs(BaseObject.m_nCurrX - nX) + abs(BaseObject.m_nCurrY - nY)) div 2 * 20;
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperTarget(TargeTBaseObject) then begin
      BaseObject.SetTargetCreat(TargeTBaseObject);
      BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower, nX, nY, nRage, Integer(TargeTBaseObject), '', nTime);
      TargeTBaseObject.MagicQuest(BaseObject, nMagID, mfs_TagEx);
      //TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagDoubleBigExplosionEx(PlayObject: TPlayObject; nPower, nX, nY: Integer; nRage, nMagID: Integer; boDecMP: Boolean): Boolean;
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;
  for I := 0 to PlayObject.m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(PlayObject.m_VisibleActors.Items[i]).BaseObject);
    if (BaseObject = nil) or (BaseObject.m_boGhost) or BaseObject.m_boDeath then Continue;
    if (BaseObject.m_PEnvir = PlayObject.m_PEnvir) and (abs(BaseObject.m_nCurrX - nX) <= 6) and
      (abs(BaseObject.m_nCurrY - nY) <= 6) then begin
      if PlayObject.IsProperTarget(BaseObject) then begin
        BaseObject.MagicQuest(PlayObject, nMagID, mfs_TagEx);
        if boDecMP and g_Config.boSkill66ReduceMP then BaseObject.DamageSpell(nPower div 2);
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, nX, nY, 2, Integer(BaseObject), '', 1380);
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, nX, nY, 2, Integer(BaseObject), '', 2000);
        Result := True;
      end;
    end;
  end;
end;

function TMagicManager.MagDoubleBigExplosion(BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage: Integer): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperTarget(TargeTBaseObject) then begin
      BaseObject.SetTargetCreat(TargeTBaseObject);
      TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
      BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower,
        nX, nY, nRage, Integer(TargeTBaseObject), '', 1400);
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagElecBlizzard(BaseObject: TBaseObject; nPower, nMagID: Integer): Boolean;
var
  i{, n}: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  nPowerPoint: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, BaseObject.m_nCurrX,
    BaseObject.m_nCurrY, g_Config.nElecBlizzardRange {2}, BaseObjectList);
  //MainOutMessage('BaseCount' + IntToStr(BaseObjectList.Count));
  //n := 0;
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then begin
      nPowerPoint := nPower div 10;
    end
    else
      nPowerPoint := nPower;

    if BaseObject.IsProperTarget(TargeTBaseObject) then begin
      //BaseObject.SetTargetCreat(TargeTBaseObject);
      //Inc(n);
      TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPowerPoint, 0, 0, '');
      TargeTBaseObject.MagicQuest(BaseObject, nMagID, mfs_TagEx);
      Result := True;
    end;
  end;
  //MainOutMessage('AttackCount' + IntToStr(n));

  BaseObjectList.Free;
end;

function TMagicManager.MagMakeHolyCurtain(PlayObject: TPlayObject; delay, nPower:
  Integer; nX, nY: Integer): Integer; //004928C0
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  MagicEvent: pTMagicEvent;
  HolyCurtainEvent: THoly1CurtainEvent;
begin
  Result := 0;
  if PlayObject.m_PEnvir.CanWalk(nX, nY, True) then begin
    BaseObjectList := TList.Create;
    MagicEvent := nil;
    PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nX, nY, 2, BaseObjectList);
    for i := 0 to BaseObjectList.Count - 1 do begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and
        ((Random(20) + (PlayObject.m_Abil.Level + 1)) > TargeTBaseObject.m_Abil.Level) and
        (TargeTBaseObject.m_Master = nil) then begin
        TargeTBaseObject.OpenHolySeizeMode(delay * 1000);
        if MagicEvent = nil then begin
          New(MagicEvent);
          SafeFillChar(MagicEvent^, SizeOf(TMagicEvent), #0);
          MagicEvent.BaseObjectList := TList.Create;
          MagicEvent.dwStartTick := GetTickCount();
          MagicEvent.dwTime := delay * 1000;
        end;
        MagicEvent.BaseObjectList.Add(TargeTBaseObject);
        Inc(Result);
      end
      else begin //00492A02
        Result := 0;
      end;
    end;
    BaseObjectList.Free;
    if (Result > 0) and (MagicEvent <> nil) then begin
      HolyCurtainEvent := THoly1CurtainEvent.Create(PlayObject, nX - 1, nY - 2, ET_HOLYCURTAIN, delay * 1000, nPower);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[0] := HolyCurtainEvent;
      HolyCurtainEvent := THoly1CurtainEvent.Create(PlayObject, nX + 1, nY - 2, ET_HOLYCURTAIN, delay * 1000, nPower);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[1] := HolyCurtainEvent;
      HolyCurtainEvent := THoly1CurtainEvent.Create(PlayObject, nX - 2, nY - 1, ET_HOLYCURTAIN, delay * 1000, nPower);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[2] := HolyCurtainEvent;
      HolyCurtainEvent := THoly1CurtainEvent.Create(PlayObject, nX + 2, nY - 1, ET_HOLYCURTAIN, delay * 1000, nPower);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[3] := HolyCurtainEvent;
      HolyCurtainEvent := THoly1CurtainEvent.Create(PlayObject, nX - 2, nY + 1, ET_HOLYCURTAIN, delay * 1000, nPower);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[4] := HolyCurtainEvent;
      HolyCurtainEvent := THoly1CurtainEvent.Create(PlayObject, nX + 2, nY + 1, ET_HOLYCURTAIN, delay * 1000, nPower);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[5] := HolyCurtainEvent;
      HolyCurtainEvent := THoly1CurtainEvent.Create(PlayObject, nX - 1, nY + 2, ET_HOLYCURTAIN, delay * 1000, nPower);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[6] := HolyCurtainEvent;
      HolyCurtainEvent := THoly1CurtainEvent.Create(PlayObject, nX + 1, nY + 2, ET_HOLYCURTAIN, delay * 1000, nPower);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[7] := HolyCurtainEvent;
      UserEngine.m_MagicEventList.Add(MagicEvent);
    end
    else begin
      if MagicEvent <> nil then begin
        MagicEvent.BaseObjectList.Free;
        DisPose(MagicEvent);
      end;
    end;
  end;
end;

function TMagicManager.MagMakeGroupTransparent(BaseObject: TBaseObject; nX, nY,
  nHTime, nMagID: Integer): Boolean; //0049320C
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  // ����Χ��һ����
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, 2, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperFriend(TargeTBaseObject) then begin
      if TargeTBaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] = 0 then begin //00493287
        TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_TRANSPARENT, 0,
          nHTime, 0, 0, 0, '', 800);
        TargeTBaseObject.MagicQuest(BaseObject, nMagID, mfs_TagEx);
        //TargeTBaseObject.SendMsg(TargeTBaseObject, RM_TRANSPARENT, 0, nHTime, 0, 0, '');
        Result := True;
      end;
    end
  end;
  BaseObjectList.Free;
end;
//=====================================================================================
//���ƣ�
//���ܣ�
//������
//     BaseObject       ħ��������
//     TargeTBaseObject �ܹ�����ɫ
//     nPower           ħ������С
//     nLevel           ���������ȼ�
//     nTargetX         Ŀ������X
//     nTargetY         Ŀ������Y
//����ֵ��
//=====================================================================================

function TMagicManager.MabMabe(BaseObject, TargeTBaseObject: TBaseObject;
  nPower, nLevel,
  nTargetX, nTargetY, nMagID: Integer): Boolean;
var
  nLv: Integer;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if BaseObject.MagCanHitTarget(BaseObject.m_nCurrX, BaseObject.m_nCurrY, TargeTBaseObject) then begin
    if BaseObject.IsProperTarget(TargeTBaseObject) and (BaseObject <> TargeTBaseObject) then begin
      if (TargeTBaseObject.m_nAntiMagic <= Random(10)) and
        (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and
        (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
        BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower div 3,
          nTargetX, nTargetY, 2, Integer(TargeTBaseObject), '', 600);
        TargeTBaseObject.MagicQuest(BaseObject, nMagID, mfs_TagEx);
        if (Random(2) + (BaseObject.m_Abil.Level - 1)) >
          TargeTBaseObject.m_Abil.Level then begin
          nLv := BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
          if (Random(g_Config.nMabMabeHitRandRate {100}) <
            _MAX(g_Config.nMabMabeHitMinLvLimit, (nLevel * 8) - nLevel + 15 + nLv))
            {or (Random(abs(nLv))}then begin
            // if (Random(100) < ((nLevel shl 3) - nLevel + 15 + nLv)) {or (Random(abs(nLv))} then begin
            if (g_Config.nMabMabeHitSucessRate > 0) and (Random(g_Config.nMabMabeHitSucessRate {21}) < nLevel * 2 + 4) then begin
              if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                BaseObject.SetPKFlag(BaseObject);
                BaseObject.SetTargetCreat(TargeTBaseObject);
              end;
              TargeTBaseObject.SetLastHiter(BaseObject);
              nPower := TargeTBaseObject.GetMagStruckDamage(BaseObject, nPower);
              BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower,
                nTargetX, nTargetY, 2, Integer(TargeTBaseObject), '', 600);
              //BaseObject.SendMsg(BaseObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '');
              if not TargeTBaseObject.m_boUnParalysis then
                TargeTBaseObject.SendDelayMsg(BaseObject, RM_POISON, POISON_STONE
                  {�ж����� - ���}, nPower div g_Config.nMabMabeHitMabeTimeRate
                  {20}+ Random(nLevel), Integer(BaseObject), nLevel,0, '', 650);
              //TargeTBaseObject.SendDelayMsg(BaseObject, RM_POISON, POISON_STONE {�ж����� - ���}, nPower div g_Config.nMabMabeHitMabeTimeRate {20} + Random(nLevel), Integer(BaseObject), nLevel, '', 10);
            end;
            Result := True;
          end;
        end;
      end;
    end;
  end;
end;

function TMagicManager.MagMakeMoonSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  i: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel, nX, nY: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  BaseObject: TBaseObject;
begin
  Result := False;
  sMonName := g_Config.sMoonSpirit;
  nMakeLevel := UserMagic.btLevel;
  nExpLevel := UserMagic.btLevel;
  nCount := g_Config.nMoonSpiritCount;
  dwRoyaltySec := 10 * 24 * 60 * 60;
  for i := Low(g_Config.MoonSpiritArray) to High(g_Config.MoonSpiritArray) do begin
    if g_Config.MoonSpiritArray[i].nHumLevel = 0 then break;
    if PlayObject.m_Abil.Level >= g_Config.MoonSpiritArray[i].nHumLevel then begin
      sMonName := g_Config.MoonSpiritArray[i].sMonName;
      nExpLevel := g_Config.MoonSpiritArray[i].nLevel;
      nCount := g_Config.MoonSpiritArray[i].nCount;
    end;
  end;
  for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
    if nCount <= 0 then break;
    BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
      if (BaseObject.m_nSlaveMagIndex in [SKILL_SKELLETON, SKILL_SINSU, SKILL_65]) then Dec(nCount);
    end else
      PlayObject.m_SlaveList.Delete(I);
  end;
  if nCount > 0 then begin
    if (PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, 100, SKILL_65, dwRoyaltySec) <> nil) then
      Result := True;
  end else begin
    for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
      BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
      if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
        if BaseObject.m_nSlaveMagIndex = SKILL_65 then begin
          PlayObject.GetBackPosition(nX, nY);
          BaseObject.SpaceMove(PlayObject.m_PEnvir, nX, nY, 1);
        end;
      end else
        PlayObject.m_SlaveList.Delete(I);
    end;
  end;
end;

function TMagicManager.MagMakeSinSuSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  i: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel, nX, nY: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  BaseObject: TBaseObject;
begin
  Result := False;
  sMonName := g_Config.sDogz;
  nMakeLevel := UserMagic.btLevel;
  nExpLevel := UserMagic.btLevel;
  nCount := g_Config.nDogzCount;
  dwRoyaltySec := 10 * 24 * 60 * 60;
  for i := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
    if g_Config.DogzArray[i].nHumLevel = 0 then
      break;
    if PlayObject.m_Abil.Level >= g_Config.DogzArray[i].nHumLevel then begin
      sMonName := g_Config.DogzArray[i].sMonName;
      nExpLevel := g_Config.DogzArray[i].nLevel;
      nCount := g_Config.DogzArray[i].nCount;
    end;
  end;
  for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
    if nCount <= 0 then break;
    BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
      if (BaseObject.m_nSlaveMagIndex  in [SKILL_SKELLETON, SKILL_SINSU, SKILL_65]) then Dec(nCount);
    end else
      PlayObject.m_SlaveList.Delete(I);
  end;
  if nCount > 0 then begin
    if (PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, 100, SKILL_SINSU, dwRoyaltySec) <> nil) then
      Result := True;
  end else begin
    for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
      BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
      if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
        if BaseObject.m_nSlaveMagIndex = SKILL_SINSU then begin
          PlayObject.GetBackPosition(nX, nY);
          BaseObject.SpaceMove(PlayObject.m_PEnvir, nX, nY, 1);
        end;
      end else
        PlayObject.m_SlaveList.Delete(I);
    end;
  end;
end;

function TMagicManager.MagMakeSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  i: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel, nX, nY: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  BaseObject: TBaseObject;
begin
  Result := False;
  sMonName := g_Config.sBoneFamm;
  nMakeLevel := UserMagic.btLevel;
  nExpLevel := UserMagic.btLevel;
  nCount := g_Config.nBoneFammCount;
  dwRoyaltySec := 10 * 24 * 60 * 60;
  for i := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
    if g_Config.BoneFammArray[i].nHumLevel = 0 then
      break;
    if PlayObject.m_Abil.Level >= g_Config.BoneFammArray[i].nHumLevel then begin
      sMonName := g_Config.BoneFammArray[i].sMonName;
      nExpLevel := g_Config.BoneFammArray[i].nLevel;
      nCount := g_Config.BoneFammArray[i].nCount;
    end;
  end;
  for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
    if nCount <= 0 then break;
    BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
      if (BaseObject.m_nSlaveMagIndex in [SKILL_SKELLETON, SKILL_SINSU, SKILL_65]) then Dec(nCount);
    end else
      PlayObject.m_SlaveList.Delete(I);
  end;
  if nCount > 0 then begin
    if (PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, 100, SKILL_SKELLETON, dwRoyaltySec) <> nil) then
      Result := True;
  end else begin
    for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
      BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
      if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
        if BaseObject.m_nSlaveMagIndex = SKILL_SKELLETON then begin
          PlayObject.GetBackPosition(nX, nY);
          BaseObject.SpaceMove(PlayObject.m_PEnvir, nX, nY, 1);
        end;
      end else
        PlayObject.m_SlaveList.Delete(I);
    end;
  end;
end;


function TMagicManager.MagGroupMb(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  //  nPower: Integer;
  //  StdItem: pTStdItem;
  nTime: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  nTime := 5 * UserMagic.btLevel + 1;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, PlayObject.m_nCurrX, PlayObject.m_nCurrY, UserMagic.btLevel + 2,
    BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then
      Continue;
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (not g_Config.boGroupMbAttackPlayObject) then
      Continue;
    if (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) and (BaseObject.m_Master <> nil) and (not g_Config.boGroupMbAttackSlave) then
      Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      if not BaseObject.m_boUnParalysis and (Random(BaseObject.m_btAntiPoison) = 0) then begin
        if (BaseObject.m_Abil.Level < PlayObject.m_Abil.Level) or (Random(PlayObject.m_Abil.Level - BaseObject.m_Abil.Level) = 0)
          then begin
          BaseObject.MakePosion(POISON_STONE, nTime, 0);
          BaseObject.m_boFastParalysis := True;
          BaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        end;
      end;
    end;
    //if PlayObject.m_btRaceServer = RC_PLAYMOSTER then Result := True
    //else
    if BaseObject.m_btRaceServer >= RC_ANIMAL then
      Result := True;
  end;
  BaseObjectList.Free;
end;

end.

