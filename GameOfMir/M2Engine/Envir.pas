unit Envir;

interface

uses
  Windows, SysUtils, Classes, SDK, Grobal2;

const
  ENEVENT_FIREBURN = 0;
  
type

  TWalkFlag = (wf_Hum, wf_Mon, wf_Npc, wf_Guard, wf_War);

  TWalkFlagArr = set of TWalkFlag;

  TMapHeader = packed record
    wWidth: Word;
    wHeight: Word;
    sTitle: string[15];
    UpdateDate: TDateTime;
    Reserved: array[0..23] of Char;
  end;
  TOldMapUnitInfo = packed record
    wBkImg: Word; //32768 $8000 为禁止移动区域
    wMidImg: Word;
    wFrImg: Word;
    btDoorIndex: Byte; //$80 (巩娄), 巩狼 侥喊 牢郸胶
    btDoorOffset: Byte;
      //摧腮 巩狼 弊覆狼 惑措 困摹, $80 (凯覆/摧塞(扁夯))
    btAniFrame: Byte; //$80(Draw Alpha) +  橇贰烙 荐
    btAniTick: Byte;
    btArea: Byte; //瘤开 沥焊
    btLight: Byte; //0..1..4 堡盔 瓤苞
  end;
  pTOldMapUnitInfo = ^TOldMapUnitInfo;

  TMapUnitInfo = packed record
    wBkImg: Word; //32768 $8000 为禁止移动区域
    wMidImg: Word;
    wFrImg: Word;
    btDoorIndex: Byte; //$80 (巩娄), 巩狼 侥喊 牢郸胶
    btDoorOffset: Byte;
      //摧腮 巩狼 弊覆狼 惑措 困摹, $80 (凯覆/摧塞(扁夯))
    btAniFrame: Byte; //$80(Draw Alpha) +  橇贰烙 荐
    btAniTick: Byte;
    btArea: Byte; //瘤开 沥焊
    btLight: Byte; //0..1..4 堡盔 瓤苞
    btBkIndex: Byte;
    btSmIndex: Byte;
  end;
  pTMapUnitInfo = ^TMapUnitInfo;

  TENMapHeader = packed record
    Title: string[16];
    Reserved: LongWord;
    Width: Word;
    Not1: Word;
    Height: Word;
    Not2: Word;
    Reserved2: array[0..24] of char;
  end;

  TENMapInfo = packed record
    BkImg: Word;
    BkImgNot: word;
    MidImg: word;
    FrImg: word;
    DoorIndex: byte;
    DoorOffset: byte;
    AniFrame: byte;
    AniTick: byte;
    Area: byte;
    light: byte;
    btNot: byte;
  end;
  PTENMapInfo = ^TENMapInfo;

  TMap = array[0..1000 * 1000 - 1] of TMapUnitInfo;
  pTMap = ^TMap;

  TOldMap = array[0..1000 * 1000 - 1] of TOldMapUnitInfo;
  pTOldMap = ^TOldMap;

  TMapCellinfo = record
    chFlag: Byte;
    btFlag: Byte;
    {bt1: Byte;
    bt2: Byte;
    bt3: Byte;}
    ObjList: TList;
  end;
  pTMapCellinfo = ^TMapCellinfo;
  PTEnvirnoment = ^TEnvirnoment;
  TEnvirnoment = class
    sMapName: string; //0x4
    sMapDesc: string;
    sMainMapName: string; //0x4
    sSubMapName: string; //0x4
    m_boMainMap: Boolean; //0x25
    MapCellArray: array of TMapCellinfo; //0x0C
    nMinMap: Integer; //0x10
//    nServerIndex: Integer; //0x14
    nRequestLevel: Integer; //0x18 进入本地图所需等级
    m_nWidth: Integer; //0x1C
    m_nHeight: Integer; //0x20
    m_boDARK: Boolean; //0x24
    m_boDAY: Boolean; //0x25
    m_boDarkness: Boolean;
    m_boDayLight: Boolean;
    m_Event: TStringList;
    m_MonsterList: TList;
    m_MasterObject: TObject;
    m_dwCheckMonsterTick: LongWord;
    m_DoorList: TList; //0x28
    bo2C: Boolean;
    m_boSAFE: Boolean; //0x2D
    m_boFightZone: Boolean; //0x2E
    m_boFight3Zone: Boolean; //0x2F  //行会战争地图
    m_boQUIZ: Boolean; //0x30
    m_boNORECONNECT: Boolean; //0x31
    m_boNEEDHOLE: Boolean; //0x32
    m_boNORECALL: Boolean; //0x33
    m_boNOGUILDRECALL: Boolean;
    m_boNODEARRECALL: Boolean;
    m_boNOMASTERRECALL: Boolean;
    m_boNORANDOMMOVE: Boolean; //0x34
    m_boNODRUG: Boolean; //0x35
    m_boMINE: Boolean; //0x36
    m_boNOPOSITIONMOVE: Boolean; //0x37
    sNoReconnectMap: string; //0x38
    NoReconnectEnvir: TEnvirnoment;
    m_nReConnectX: Integer;
    m_nReConnectY: Integer;
    QuestNPC: TObject; //0x3C
    nNEEDSETONFlag: Integer; //0x40
    nNeedONOFF: Integer; //0x44
    //m_QuestList: TList; //0x48
    m_boRUNHUMAN: Boolean; //可以穿人
    m_boRUNMON: Boolean; //可以穿怪
    m_boINCHP: Boolean; //自动加HP值
    m_boDECHP: Boolean; //自动减HP值
    m_boIncGameGold: Boolean; //自动减游戏币
    m_boINCGAMEPOINT: Boolean; //自动加点
    m_boDecGameGold: Boolean; //自动减游戏币
    m_boDECGAMEPOINT: Boolean; //自动减点
    m_boMUSIC: Boolean; //音乐
    m_boEXPRATE: Boolean; //杀怪经验倍数
    m_boPKWINLEVEL: Boolean; //PK得等级
    m_boPKWINEXP: Boolean; //PK得经验
    m_boPKLOSTLEVEL: Boolean; //PK丢等级
    m_boPKLOSTEXP: Boolean; //PK丢经验
    m_nPKWINLEVEL: Integer; //PK得等级数
    m_nPKLOSTLEVEL: Integer; //PK丢等级
    m_nPKWINEXP: Integer; //PK得经验数
    m_nPKLOSTEXP: Integer; //PK丢经验
    m_nDECHPTIME: Integer; //减HP间隔时间
    m_nDECHPPOINT: Integer; //一次减点数
    m_nINCHPTIME: Integer; //加HP间隔时间
    m_nINCHPPOINT: Integer; //一次加点数
    m_nDECGAMEGOLDTIME: Integer; //减游戏币间隔时间
    m_nDecGameGold: Integer; //一次减数量
    m_nDECGAMEPOINTTIME: Integer; //减游戏点间隔时间
    m_nDECGAMEPOINT: Integer; //一次减数量
    m_nINCGAMEGOLDTIME: Integer; //加游戏币间隔时间
    m_nIncGameGold: Integer; //一次加数量
    m_nINCGAMEPOINTTIME: Integer; //加游戏币间隔时间
    m_nINCGAMEPOINT: Integer; //一次加数量
    m_nMUSICID: Integer; //音乐ID
    m_nEXPRATE: Integer; //经验倍率
    m_nMonCount: Integer;
    m_nHumCount: Integer;
    m_boDropItemMapEvent: Boolean; //是否有地图事件信息
    m_boPickUpItemMapEvent: Boolean; //是否有地图事件信息
    m_boHeavyHitMapEvent: Boolean; //是否有地图事件信息
    m_boNotReAlive: Boolean;
    m_boNotStone: Boolean;
    m_boDieTime: Boolean;
    m_dwDieTime: LongWord;

    m_boDropItemEvent: Boolean; //是否有地图事件信息
    m_boPickUpItemEvent: Boolean; //是否有地图事件信息
    m_boHeavyHitEvent: Boolean; //是否有地图事件信息
    m_DropItemEventList: TList;
    m_PickUpItemEventList: TList;
    m_HeavyHitEventList: TList;

    m_boUnAllowStdItems: Boolean; //是否不允许使用物品
    m_UnAllowStdItemsList: TGStringList; //不允许使用物品列表
    m_boUnAllowMagic: Boolean; //是否不允许使用物品
    m_UnAllowMagicList: TGStringList; //不允许使用物品列表
    m_boUnAllowFireMagic: Boolean; //不允许使用火墙
    m_StartPointList: TList;
    m_boFB: Boolean;
    m_boFBCreate: Boolean;
    m_dwFBCreateTime: LongWord;
    m_boFBFail: Boolean;
    m_dwFBFailTime: LongWord;
    m_dwFBTime: LongWord;
    m_btFBIndex: Byte;
    m_sFBName: string;
    m_sHitMonLabel: string;
    m_MonGenList: TList;
    m_nMapIndex: Integer;
    m_boShop: Boolean;                    
    m_boOffLine: Boolean;
    m_boNotHorse: Boolean;
    m_boNODEAL: Boolean;
    m_boNOTHROWITEM: boolean;
    m_QuestFlag: TQuestFlag;
    m_RandomMapGateList: TList;
    m_boFBIsJob: Boolean;
  private
    procedure Initialize(nWidth, nHeight: Integer);
  public
    constructor Create();
    destructor Destroy; override;
    function AddToMap(nX, nY: Integer; btType: Byte; pRemoveObject: TObject): Pointer;
    function CanWalk(nX, nY: Integer; boFlag: Boolean): Boolean;
    function CanWalkOfItem(nX, nY: Integer; boFlag, boItem: Boolean): Boolean;
    function CanWalkEx(nX, nY: Integer; boFlag: Boolean): Boolean; overload;
    function CanWalkEx(nX, nY: Integer; Flag: TWalkFlagArr): Boolean; overload;
    function CanFly(nSX, nSY, nDX, nDY: Integer): Boolean;
    function MoveToMovingObject(nCX, nCY: Integer; Cert: TObject; nX, nY: Integer; boFlag: Boolean): Integer;
    function GetItem(nX, nY: Integer): PTMapItem;
    function DeleteFromMap(nX, nY: Integer; btType: Byte; pRemoveObject:
      TObject): Integer;
    //function IsCheapStuff(): Boolean;
    function GetQuestFalgStatus(nFlag: Integer): Integer;
    procedure SetQuestFlagStatus(nFlag: Integer; nValue: Integer);
    procedure AddDoorToMap;
    procedure DelEventByID(Event: Pointer);
    function AddToMapMineEvent(nX, nY: Integer; nType: Integer; Event: TObject): TObject;
    function LoadMapData(sMapFile: string): Boolean;
//    function CreateQuest(nFlag, nValue, nFlag2, nValue2: Integer; sMonName, sQuestName: string; boGrouped: Boolean): Boolean;
    //function GetQuestList(sMonName: string): TList;
    function GetMapCellInfo(nX, nY: Integer; var MapCellInfo: pTMapCellinfo):
      Boolean;
    function GetXYObjCount(nX, nY: Integer): Integer;
    function GetNextPosition(sX, sY, nDir, nFlag: Integer; var snx: Integer; var
      sny: Integer): Boolean;
    function sub_4B5FC8(nX, nY: Integer): Boolean;
    procedure VerifyMapTime(nX, nY: Integer; BaseObject: TObject);
    function CanSafeWalk(nX, nY: Integer): Boolean;
    function ArroundDoorOpened(nX, nY: Integer): Boolean;
    function GetMovingObject(nX, nY: Integer; boFlag: Boolean): Pointer;
    //function GetQuestNPC(BaseObject: TObject; sCharName, sStr: string; boFlag: Boolean): TObject;
    function GetItemEx(nX, nY: Integer; var nCount: Integer): Pointer;
    function GetDoor(nX, nY: Integer): pTDoorInfo;
    function IsValidObject(nX, nY: Integer; nRage: Integer; BaseObject: TObject): Boolean;
    function GetRangeBaseObject(nX, nY: Integer; nRage: Integer; boFlag: Boolean; BaseObjectList: TList): Integer;
    function GeTBaseObjects(nX, nY: Integer; boFlag: Boolean; BaseObjectList: TList): Integer;
    function GetShopingCount(nX, nY: Integer): Integer;
    function GetOffLincCount(nX, nY: Integer): Integer;
    function GetEvent(nX, nY: Integer): TObject;
    procedure SetMapXYFlag(nX, nY: Integer; boFlag: Boolean);
    function GetXYHuman(nMapX, nMapY, nRage: Integer): Integer;
    function GetEnvirInfo(): string;
    function AllowStdItems(sItemName: string): Boolean; overload;
    function AllowStdItems(nItemIdx: Integer): Boolean; overload;
    function AllowMagic(sMagicName: string): Boolean; overload;
    function AllowMagic(nMagicID: Integer): Boolean; overload;

    procedure AddObject(nType: Integer);
    procedure DelObjectCount(BaseObject: TObject);
    procedure SetFireBurn(nX, nY: Integer; boFlag: Boolean);
    function GetFireBurn(nX, nY: Integer): Boolean;
    property MonCount: Integer read m_nMonCount;
    property HumCount: Integer read m_nHumCount;

  end;
  TMapManager = class(TGList)
  private
  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadMapDoor();
    function LoadMapData(nIndex: Integer): Boolean;
    function AddMapInfo(sMapName, sMainMapName, sMapDesc: string; nServerNumber:
      Integer; MapFlag: pTMapFlag; QuestNPC: TObject): TEnvirnoment;
    function GetMapInfo(nServerIdx: Integer; sMapName: string): TEnvirnoment;
    function AddMapRoute(sSMapNO: string; nSMapX, nSMapY: Integer; sDMapNO:
      string; nDMapX, nDMapY: Integer): Boolean;
    function GetMapOfServerIndex(sMapName: string): Integer;
    function FindMap(sMapName: string): TEnvirnoment;
    function GetMainMap(Envir: TEnvirnoment): string;
    procedure ReSetMinMap();
    procedure Run();
    procedure ProcessMapDoor();
    procedure MakeSafePkZone();
  end;

  pTMonGenInfo = ^TMonGenInfo;
  TMonGenInfo = record
    sMapName: string[14];
    nRace: Integer;
    nRange: Integer;
    nMissionGenRate: Integer;
    dwStartTick: LongWord;
    nX: Integer;
    nY: Integer;
    sMonName: string[14];
    nAreaX: Integer;
    nAreaY: Integer;
    nCount: Integer;
    dwZenTime: LongWord;
    dwStartTime: LongWord;
    CertList: TList;
    Envir: TEnvirnoment;
    boFB: Boolean;
    sMakeScript: string;
    nMakeScript: Integer;
    sDieScript: string;
    nDieScript: Integer;
    sCanMakeScript: string;
    nCanMakeScript: Integer;
    dwCanMakeHintTime: Integer;
    boCanMakeHint: Boolean;
    nTimeHintIndex: Integer;
    nFlagInfo: Integer;
  end;


var
  g_MapObjectCount: array of Integer;

implementation

uses ObjBase, ObjNpc, M2Share, Event, ObjMon, HUtil32, Castle, ObjPlay;

{ TEnvirList }

procedure TMapManager.MakeSafePkZone();
var
  nX, nY: Integer;
//  SafeEvent: TSafeEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  nPKMinX, nPKMaxX, nPKMinY, nPKMaxY: Integer;
  //nRange, nType, nTime, nPoint: Integer;
  I: Integer;
  StartPoint: pTStartPoint;
  Envir: TEnvirnoment;
  MapStartPoint: pTMapStartPoint;
  //MapEventStartPoint: pTMapEventStartPoint;
begin
  g_StartPointList.Lock;
  for I := 0 to g_StartPointList.Count - 1 do begin
    StartPoint := pTStartPoint(g_StartPointList.Objects[I]);
    if (StartPoint <> nil) {and (StartPoint.m_nType > 0) }then begin
      Envir := FindMap(StartPoint.m_sMapName);
      if Envir <> nil then begin
        New(MapStartPoint);
        MapStartPoint.nSafeX := StartPoint.m_nCurrX;
        MapStartPoint.nSafeY := StartPoint.m_nCurrY;
        MapStartPoint.nPKSize := Startpoint.m_nPkSize;
        Envir.m_StartPointList.Add(MapStartPoint);

        nMinX := StartPoint.m_nCurrX - StartPoint.m_nRange;
        nMaxX := StartPoint.m_nCurrX + StartPoint.m_nRange;
        nMinY := StartPoint.m_nCurrY - StartPoint.m_nRange;
        nMaxY := StartPoint.m_nCurrY + StartPoint.m_nRange;
        nPKMinX := StartPoint.m_nCurrX - StartPoint.m_nRange - Startpoint.m_nPkSize;
        nPKMaxX := StartPoint.m_nCurrX + StartPoint.m_nRange + Startpoint.m_nPkSize;
        nPKMinY := StartPoint.m_nCurrY - StartPoint.m_nRange - Startpoint.m_nPkSize;
        nPKMaxY := StartPoint.m_nCurrY + StartPoint.m_nRange + Startpoint.m_nPkSize;

        for nX := nMinX to nMaxX do begin
          for nY := nMinY to nMaxY do begin
            Envir.AddToMap(nX, nY, OS_SAFEAREA, nil);
            {if ((nX < nMaxX) and (nY = nMinY)) or
              ((nY < nMaxY) and (nX = nMinX)) or
              (nX = nMaxX) or (nY = nMaxY) then begin
              SafeEvent := TSafeEvent.Create(Envir, nX, nY, StartPoint.m_nType);
              g_EventManager.AddEvent(SafeEvent);
            end;  }
          end;
        end;
        if Startpoint.m_nPkSize > 0 then begin
          for nX := nPKMinX to nPKMaxX do begin
            for nY := nPKMinY to nPKMaxY do begin
              if (nX < nMinX) or (nX > nMaxX) or (((nX >= nMinX) and (nX <= nMaxX)) and ((nY < nMinY) or (nY > nMaxY))) then
                Envir.AddToMap(nX, nY, OS_SAFEPK, nil);
              {if ((nX < nPKMaxX) and (nY = nPKMinY)) or
                ((nY < nPKMaxY) and (nX = nPKMinX)) or
                (nX = nPKMaxX) or (nY = nPKMaxY) then begin
                SafeEvent := TSafeEvent.Create(Envir, nX, nY,
                  StartPoint.m_nPkType);
                g_EventManager.AddEvent(SafeEvent);
              end;  }
            end;
          end;
        end;
        nPKMinX := StartPoint.m_nCurrX - StartPoint.m_nRange - 10;
        nPKMaxX := StartPoint.m_nCurrX + StartPoint.m_nRange + 10;
        nPKMinY := StartPoint.m_nCurrY - StartPoint.m_nRange - 10;
        nPKMaxY := StartPoint.m_nCurrY + StartPoint.m_nRange + 10;
        for nX := nPKMinX to nPKMaxX do begin
          for nY := nPKMinY to nPKMaxY do begin
            if (nX < nMinX) or (nX > nMaxX) or (((nX >= nMinX) and (nX <= nMaxX)) and ((nY < nMinY) or (nY > nMaxY))) then
              Envir.AddToMap(nX, nY, OS_SAFEMILIEU, nil);
          end;
        end;
      end;
    end;
  end;
  Envir := FindMap(g_Config.sRedHomeMap);
  if Envir <> nil then begin
    nMinX := g_Config.nRedHomeX - g_Config.nSafeZoneSize;
    nMaxX := g_Config.nRedHomeX + g_Config.nSafeZoneSize;
    nMinY := g_Config.nRedHomeY - g_Config.nSafeZoneSize;
    nMaxY := g_Config.nRedHomeY + g_Config.nSafeZoneSize;

    for nX := nMinX to nMaxX do begin
      for nY := nMinY to nMaxY do begin
        Envir.AddToMap(nX, nY, OS_SAFEAREA, nil);
      end;
    end;
    nPKMinX := g_Config.nRedHomeX - g_Config.nSafeZoneSize - 10;
    nPKMaxX := g_Config.nRedHomeX + g_Config.nSafeZoneSize + 10;
    nPKMinY := g_Config.nRedHomeY - g_Config.nSafeZoneSize - 10;
    nPKMaxY := g_Config.nRedHomeY + g_Config.nSafeZoneSize + 10;
    for nX := nPKMinX to nPKMaxX do begin
      for nY := nPKMinY to nPKMaxY do begin
        if (nX < nMinX) or (nX > nMaxX) or (((nX >= nMinX) and (nX <= nMaxX)) and ((nY < nMinY) or (nY > nMaxY))) then
          Envir.AddToMap(nX, nY, OS_SAFEMILIEU, nil);
      end;
    end;
  end;
end;

function TMapManager.LoadMapData(nIndex: Integer): Boolean;
var
  Envir: TEnvirnoment;
begin
  Result := False;
  if (nIndex >= 0) and (nIndex < Self.Count) then begin
    Envir := TEnvirnoment(Self.Items[nIndex]);
    Envir.m_nMapIndex := nIndex;
    if Envir.sMainMapName <> '' then begin
      //CopyFile(PChar('E:\网络游戏\热血传奇2\Map\' + Envir.sMainMapName + '.map'), PChar(g_Config.sMapDir + Envir.sMainMapName + '.map'), False);
      if Envir.LoadMapData(g_Config.sMapDir + Envir.sMainMapName + '.map') then begin
        Result := True;
      end;
    end
    else begin
      //CopyFile(PChar('E:\网络游戏\热血传奇2\Map\' + Envir.sMapName + '.map'), PChar(g_Config.sMapDir + Envir.sMapName + '.map'), False);
      if Envir.LoadMapData(g_Config.sMapDir + Envir.sMapName + '.map') then begin
        Result := True;
      end;
    end;
  end;

end;

function TMapManager.AddMapInfo(sMapName, sMainMapName, sMapDesc: string;
  nServerNumber: Integer; MapFlag: pTMapFlag; QuestNPC: TObject): TEnvirnoment;
var
  I: Integer;
  nStd: Integer;
  TempList: TStringList;
  Magic: pTMagic;
begin
  Result := TEnvirnoment.Create;
  Result.sMapName := sMapName;
  Result.sMainMapName := sMainMapName;
  Result.sSubMapName := sMapName;
  Result.sMapDesc := sMapDesc;
  if sMainMapName <> '' then
    Result.m_boMainMap := True;
  //Result.nServerIndex := nServerNumber;
  Result.m_boSAFE := MapFlag.boSAFE;
  Result.m_boFightZone := MapFlag.boFIGHT;
  Result.m_boFight3Zone := MapFlag.boFIGHT3;
  Result.m_boDARK := MapFlag.boDARK;
  Result.m_boDAY := MapFlag.boDAY;
  Result.m_boQUIZ := MapFlag.boQUIZ;
  Result.m_boNORECONNECT := MapFlag.boNORECONNECT;
  Result.m_boNEEDHOLE := MapFlag.boNEEDHOLE;
  Result.m_boNORECALL := MapFlag.boNORECALL;
  Result.m_boNOGUILDRECALL := MapFlag.boNOGUILDRECALL;
  Result.m_boNODEARRECALL := MapFlag.boNODEARRECALL;
  Result.m_boNOMASTERRECALL := MapFlag.boNOMASTERRECALL;
  Result.m_boNORANDOMMOVE := MapFlag.boNORANDOMMOVE;
  Result.m_boNODRUG := MapFlag.boNODRUG;
  Result.m_boMINE := MapFlag.boMINE;
  Result.m_boNOPOSITIONMOVE := MapFlag.boNOPOSITIONMOVE;
  Result.m_boOffLine := MapFlag.boOffLine;
  Result.m_boNotHorse := MapFlag.boNotHorse;
  Result.m_boNotStone := MapFlag.boNotStone;
  Result.m_boNoDeal := MapFlag.boNoDeal;
  Result.m_boNOTHROWITEM := MapFlag.boNOTHROWITEM;

  Result.m_boRUNHUMAN := MapFlag.boRUNHUMAN; //可以穿人
  Result.m_boRUNMON := MapFlag.boRUNMON; //可以穿怪
  Result.m_boDECHP := MapFlag.boDECHP; //自动减HP值
  Result.m_boINCHP := MapFlag.boINCHP; //自动加HP值
  Result.m_boDecGameGold := MapFlag.boDECGAMEGOLD; //自动减游戏币
  Result.m_boDECGAMEPOINT := MapFlag.boDECGAMEPOINT; //自动减游戏币
  Result.m_boIncGameGold := MapFlag.boINCGAMEGOLD; //自动加游戏币
  Result.m_boINCGAMEPOINT := MapFlag.boINCGAMEPOINT; //自动加游戏点
  Result.m_boMUSIC := MapFlag.boMUSIC; //音乐
  Result.m_boEXPRATE := MapFlag.boEXPRATE; //杀怪经验倍数
  Result.m_boPKWINLEVEL := MapFlag.boPKWINLEVEL; //PK得等级
  Result.m_boPKWINEXP := MapFlag.boPKWINEXP; //PK得经验
  Result.m_boPKLOSTLEVEL := MapFlag.boPKLOSTLEVEL;
  Result.m_boPKLOSTEXP := MapFlag.boPKLOSTEXP;
  Result.m_nPKWINLEVEL := MapFlag.nPKWINLEVEL; //PK得等级数
  Result.m_nPKWINEXP := MapFlag.nPKWINEXP; //PK得经验数
  Result.m_nPKLOSTLEVEL := MapFlag.nPKLOSTLEVEL;
  Result.m_nPKLOSTEXP := MapFlag.nPKLOSTEXP;
  Result.m_nPKWINEXP := MapFlag.nPKWINEXP; //PK得经验数
  Result.m_nDECHPTIME := MapFlag.nDECHPTIME; //减HP间隔时间
  Result.m_nDECHPPOINT := MapFlag.nDECHPPOINT; //一次减点数
  Result.m_nINCHPTIME := MapFlag.nINCHPTIME; //加HP间隔时间
  Result.m_nINCHPPOINT := MapFlag.nINCHPPOINT; //一次加点数
  Result.m_nDECGAMEGOLDTIME := MapFlag.nDECGAMEGOLDTIME; //减游戏币间隔时间
  Result.m_nDecGameGold := MapFlag.nDECGAMEGOLD; //一次减数量

  Result.m_nINCGAMEGOLDTIME := MapFlag.nINCGAMEGOLDTIME; //减游戏币间隔时间
  Result.m_nIncGameGold := MapFlag.nINCGAMEGOLD; //一次减数量
  
  Result.m_nINCGAMEPOINTTIME := MapFlag.nINCGAMEPOINTTIME;//减游戏币间隔时间
  Result.m_nINCGAMEPOINT := MapFlag.nINCGAMEPOINT; //一次减数量
  Result.m_nMUSICID := MapFlag.nMUSICID; //音乐ID
  Result.m_nEXPRATE := MapFlag.nEXPRATE; //经验倍率

  Result.m_boDieTime := MapFlag.boDieTime;
  Result.m_dwDieTime := MapFlag.dwDieTime;

  Result.sNoReconnectMap := MapFlag.sReConnectMap;
  Result.NoReconnectEnvir := nil;
  Result.m_nReConnectX := MapFlag.nReConnectX;
  Result.m_nReConnectY := MapFlag.nReConnectY;
  Result.QuestNPC := QuestNPC;
  Result.nNEEDSETONFlag := MapFlag.nNEEDSETONFlag;
  Result.nNeedONOFF := MapFlag.nNeedONOFF;
  Result.m_boShop := MapFlag.boShop;
  Result.m_boNotReAlive := MapFlag.boNotReAlive;

  Result.m_boUnAllowFireMagic := MapFlag.boNOFIREMAGIC; //不允许使用火墙

  Result.m_sHitMonLabel := MapFlag.sHitMonLabel;

  if (MapFlag.boUnAllowStdItems) and (MapFlag.sUnAllowStdItemsText <> '') then begin
    Result.m_boUnAllowStdItems := True;
    Result.m_UnAllowStdItemsList := TGStringList.Create;
    TempList := TStringList.Create;
    ExtractStrings(['|', '\', '/', ','], [], PChar(Trim(MapFlag.sUnAllowStdItemsText)), TempList);
    for I := 0 to TempList.Count - 1 do begin
      nStd := UserEngine.GetStdItemIdx(Trim(TempList.Strings[I]));
      if nStd >= 0 then
        Result.m_UnAllowStdItemsList.AddObject(Trim(TempList.Strings[I]), TObject(nStd));
    end;
    TempList.Free;
  end;

  if (MapFlag.boUnAllowMagic) and (MapFlag.sUnAllowMagicText <> '') then begin
    Result.m_boUnAllowMagic := True;
    Result.m_UnAllowMagicList := TGStringList.Create;
    TempList := TStringList.Create;
    ExtractStrings(['|', '\', '/', ','], [], PChar(Trim(MapFlag.sUnAllowMagicText)), TempList);
    for I := 0 to TempList.Count - 1 do begin
      Magic := UserEngine.FindMagic(Trim(TempList.Strings[I]));
      if Magic <> nil then
        Result.m_UnAllowMagicList.AddObject(Trim(TempList.Strings[I]), TObject(Magic.wMagicId));
    end;
    if Result.m_UnAllowMagicList.Count <= 0 then begin
      Result.m_UnAllowMagicList.Free;
      Result.m_UnAllowMagicList := nil;
      Result.m_boUnAllowMagic := False;
    end;
    TempList.Free;
  end;

  if sMainMapName <> '' then begin
    for I := 0 to MiniMapList.Count - 1 do begin
      if CompareText(MiniMapList.Strings[I], Result.sMainMapName) = 0 then begin
        Result.nMinMap := Integer(MiniMapList.Objects[I]);
        break;
      end;
    end;
  end
  else begin
    for I := 0 to MiniMapList.Count - 1 do begin
      if CompareText(MiniMapList.Strings[I], Result.sMapName) = 0 then begin
        Result.nMinMap := Integer(MiniMapList.Objects[I]);
        break;
      end;
    end;
  end;
  Self.Add(Result);
end;

function TMapManager.AddMapRoute(sSMapNO: string; nSMapX, nSMapY: Integer;
  sDMapNO: string; nDMapX, nDMapY: Integer): Boolean;
var
  GateObj: pTGateObj;
  SEnvir: TEnvirnoment;
  DEnvir: TEnvirnoment;
begin
  Result := False;
  SEnvir := FindMap(sSMapNO);
  DEnvir := FindMap(sDMapNO);
  if (SEnvir <> nil) and (DEnvir <> nil) then begin
    New(GateObj);
    GateObj.boRandom := False;
    GateObj.DEnvir := DEnvir;
    GateObj.nDMapX := nDMapX;
    GateObj.nDMapY := nDMapY;
    SEnvir.AddToMap(nSMapX, nSMapY, OS_GATEOBJECT, TObject(GateObj));
    Result := True;
  end;
end;

function TEnvirnoment.AddToMap(nX, nY: Integer; btType: Byte;
  pRemoveObject: TObject): Pointer;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  MapItem: PTMapItem;
  I: Integer;
  nGoldCount: Integer;
  bo1E: Boolean;
  btRaceServer: Byte;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::AddToMap';
begin
  Result := nil;
  try
    bo1E := False;
    if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then
      begin
      if MapCellInfo.ObjList = nil then begin
        MapCellInfo.ObjList := TList.Create;
      end
      else begin
        if btType = OS_ITEMOBJECT then begin
          if PTMapItem(pRemoveObject).Name = sSTRING_GOLDNAME then begin
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := MapCellInfo.ObjList.Items[I];
              if (OSObject <> nil) and (OSObject.btType = OS_ITEMOBJECT) then begin
                MapItem := PTMapItem(pTOSObject(MapCellInfo.ObjList.Items[I]).CellObj);
                if MapItem.Name = sSTRING_GOLDNAME then begin
                  nGoldCount := MapItem.Count + PTMapItem(pRemoveObject).Count;
                  if nGoldCount <= 2000 then begin
                    MapItem.Count := nGoldCount;
                    MapItem.Looks := GetGoldShape(nGoldCount);
                    MapItem.AniCount := 0;
                    MapItem.Reserved := 0;
                    OSObject.dwAddTime := GetTickCount();
                    Result := MapItem;
                    bo1E := True;
                  end;
                end;
              end;
            end;
          end;
          if not bo1E and (MapCellInfo.ObjList.Count >= 5) then begin
            Result := nil;
            bo1E := True;
          end;
        end;
        {if btType = OS_EVENTOBJECT then begin

        end; }
      end;
      if not bo1E then begin
        New(OSObject);
        OSObject.btType := btType;
        OSObject.CellObj := pRemoveObject;
        OSObject.dwAddTime := GetTickCount();
        MapCellInfo.ObjList.Add(OSObject);
        Result := Pointer(pRemoveObject);
        if (btType = OS_MOVINGOBJECT) and (not TBaseObject(pRemoveObject).m_boAddToMaped) then begin
          TBaseObject(pRemoveObject).m_boDelFormMaped := False;
          TBaseObject(pRemoveObject).m_boAddToMaped := True;
          btRaceServer := TBaseObject(pRemoveObject).m_btRaceServer;
          if btRaceServer = RC_PLAYOBJECT then
            Inc(m_nHumCount);
          if btRaceServer >= RC_ANIMAL then
            Inc(m_nMonCount);
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

//是否允许使用物品
function TEnvirnoment.AllowStdItems(sItemName: string): Boolean;
begin
  Result := True;
  if (not m_boUnAllowStdItems) or (m_UnAllowStdItemsList = nil) then
    Exit;
  Result := m_UnAllowStdItemsList.IndexOf(sItemName) = -1;
end;

//是否允许使用物品
function TEnvirnoment.AllowMagic(sMagicName: string): Boolean;
begin
  Result := False;
  if (not m_boUnAllowMagic) or (m_UnAllowMagicList = nil) then
    Exit;
  if m_UnAllowMagicList.IndexOf(sMagicName) > -1 then
    Result := True;
end;

function TEnvirnoment.AllowMagic(nMagicID: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (not m_boUnAllowMagic) or (m_UnAllowMagicList = nil) then
    Exit;
  for I := 0 to m_UnAllowMagicList.Count - 1 do begin
    if Integer(m_UnAllowMagicList.Objects[I]) = nMagicID then begin
      Result := True;
      break;
    end;
  end;
end;

function TEnvirnoment.AllowStdItems(nItemIdx: Integer): Boolean;

var
  I: Integer;
begin
  Result := True;
  if (not m_boUnAllowStdItems) or (m_UnAllowStdItemsList = nil) then
    Exit;
  for I := 0 to m_UnAllowStdItemsList.Count - 1 do begin
    if Integer(m_UnAllowStdItemsList.Objects[I]) = nItemIdx then begin
      Result := False;
      break;
    end;
  end;
end;

procedure TEnvirnoment.AddDoorToMap();
var
  I: Integer;
  Door: pTDoorInfo;
begin
  for I := 0 to m_DoorList.Count - 1 do begin
    Door := m_DoorList.Items[I];
    AddToMap(Door.nX, Door.nY, OS_DOOR, TObject(Door));
  end;
end;

function TEnvirnoment.GetMapCellInfo(nX, nY: Integer; var MapCellInfo:
  pTMapCellinfo): Boolean;
begin
  if (nX >= 0) and (nX < m_nWidth) and (nY >= 0) and (nY < m_nHeight) then begin
    MapCellInfo := @MapCellArray[nX * m_nHeight + nY];
    Result := True;
  end
  else begin
    Result := False;
  end;
end;

function TEnvirnoment.MoveToMovingObject(nCX, nCY: Integer; Cert: TObject; nX, nY: Integer; boFlag: Boolean): Integer;
var
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  OSObject: pTOSObject;
  I: Integer;
  bo1A: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::MoveToMovingObject';
label
  Loop, Over;
begin
  Result := 0;
  try
    bo1A := True;
    if not boFlag and GetMapCellInfo(nX, nY, MapCellInfo) then begin
      if MapCellInfo.chFlag = 0 then begin
        if MapCellInfo.ObjList <> nil then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            if pTOSObject(MapCellInfo.ObjList.Items[I]).btType = OS_MOVINGOBJECT then begin
              BaseObject := TBaseObject(pTOSObject(MapCellInfo.ObjList.Items[I]).CellObj);
              if BaseObject <> nil then begin
                if not BaseObject.m_boGhost
                  and BaseObject.bo2B9
                  and not BaseObject.m_boDeath
                  and not BaseObject.m_boFixedHideMode
                  and not BaseObject.m_boObMode
                  and BaseObject.m_boMapApoise then begin
                  bo1A := False;
                  break;
                end;
              end;
            end;
          end;
        end;
      end
      else begin //if MapCellInfo.chFlag = 0 then begin
        Result := -1;
        bo1A := False;
      end;
    end;
    if bo1A then begin
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag <> 0) then begin
        Result := -1;
      end
      else begin
        if GetMapCellInfo(nCX, nCY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          I := 0;
          while (True) do begin
            if MapCellInfo.ObjList.Count <= I then
              break;
            OSObject := MapCellInfo.ObjList.Items[I];
            if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
              if TBaseObject(OSObject.CellObj) = TBaseObject(Cert) then begin
                MapCellInfo.ObjList.Delete(I);
                DisPose(OSObject);
                if MapCellInfo.ObjList.Count <= 0 then begin
                  FreeAndNil(MapCellInfo.ObjList);
                  break;
                end;
                Continue;
              end;
            end;
            Inc(I);
          end;
        end;
        if GetMapCellInfo(nX, nY, MapCellInfo) then begin
          if (MapCellInfo.ObjList = nil) then begin
            MapCellInfo.ObjList := TList.Create;
          end;
          New(OSObject);
          OSObject.btType := OS_MOVINGOBJECT;
          OSObject.CellObj := Cert;
          OSObject.dwAddTime := GetTickCount;
          MapCellInfo.ObjList.Add(OSObject);
          Result := 1;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;
//======================================================================
//检查地图指定座标是否可以移动
//boFlag  如果为TRUE 则忽略座标上是否有角色
//返回值 True 为可以移动，False 为不可以移动
//======================================================================

function TEnvirnoment.CanWalk(nX, nY: Integer; boFlag: Boolean): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    Result := True;
    if not boFlag and (MapCellInfo.ObjList <> nil) then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if BaseObject <> nil then begin
            if not BaseObject.m_boGhost
              and BaseObject.bo2B9
              and not BaseObject.m_boDeath
              and not BaseObject.m_boFixedHideMode
              and not BaseObject.m_boObMode
              and BaseObject.m_boMapApoise then begin
              Result := False;
              break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//======================================================================
//检查地图指定座标是否可以移动
//boFlag  如果为TRUE 则忽略座标上是否有角色
//返回值 True 为可以移动，False 为不可以移动
//======================================================================

function TEnvirnoment.CanWalkOfItem(nX, nY: Integer; boFlag, boItem: Boolean):
  Boolean;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    //    Result:=True;
    if (MapCellInfo.ObjList <> nil) then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if (BaseObject <> nil) then begin
            if (BaseObject.m_btRaceServer in [RC_NPC, RC_GUARD, RC_ARCHERGUARD, RC_BOX, 55]) or
             (not boFlag and
              not BaseObject.m_boGhost
              and BaseObject.bo2B9
              and not BaseObject.m_boDeath
              and not BaseObject.m_boFixedHideMode
              and not BaseObject.m_boObMode
              and BaseObject.m_boMapApoise) then begin
              Result := False;
              break;
            end;
          end;
        end else
        if not boItem and (OSObject.btType = OS_ITEMOBJECT) then begin
          Result := False;
          break;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.CanWalkEx(nX, nY: Integer; Flag: TWalkFlagArr): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  I: Integer;
  Castle: TUserCastle;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    Result := True;
    if (MapCellInfo.ObjList <> nil) then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if OSObject <> nil then begin
          if OSObject.btType = OS_MOVINGOBJECT then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if BaseObject <> nil then begin
              {//01/25 多城堡 控制
              if g_Config.boWarDisHumRun and UserCastle.m_boUnderWar and
                UserCastle.InCastleWarArea(BaseObject.m_PEnvir,BaseObject.m_nCurrX,BaseObject.m_nCurrY) then begin
              }
              //攻城区域处理
              Castle := nil;
              if (wf_War in Flag) then
                Castle := g_CastleManager.InCastleWarArea(BaseObject);
              if not ((wf_War in Flag) and (Castle <> nil) and (Castle.m_boUnderWar)) then begin
                if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                  if wf_Hum in Flag then
                    Continue;
                end
                else if BaseObject.m_btRaceServer = RC_NPC then begin
                  if wf_Npc in Flag then
                    Continue;
                end
                else if BaseObject.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD] then begin
                  if wf_Guard in Flag then
                    Continue;
                end
                else if (BaseObject.m_btRaceServer <> 55) and (BaseObject.m_btRaceServer <> RC_BOX) then begin
                  //不允许穿过练功师和宝箱
                  if wf_Mon in Flag then
                    Continue;
                end;
                // end;
              // end;
             //end;
              end;
              if not BaseObject.m_boGhost and BaseObject.bo2B9
                and not BaseObject.m_boDeath
                and not BaseObject.m_boFixedHideMode
                and not BaseObject.m_boObMode
                and BaseObject.m_boMapApoise then begin
                Result := False;
                break;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.CanWalkEx(nX, nY: Integer; boFlag: Boolean): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  I: Integer;
  Castle: TUserCastle;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    Result := True;
    if not boFlag and (MapCellInfo.ObjList <> nil) then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if OSObject <> nil then begin
          if OSObject.btType = OS_MOVINGOBJECT then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if BaseObject <> nil then begin
              {//01/25 多城堡 控制
              if g_Config.boWarDisHumRun and UserCastle.m_boUnderWar and
                UserCastle.InCastleWarArea(BaseObject.m_PEnvir,BaseObject.m_nCurrX,BaseObject.m_nCurrY) then begin
              }
              //攻城区域处理
              Castle := nil;
              if g_Config.boWarDisHumRun then
                Castle := g_CastleManager.InCastleWarArea(BaseObject);
              if not (g_Config.boWarDisHumRun and (Castle <> nil) and (Castle.m_boUnderWar)) then begin
                if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                  if (g_Config.boRUNHUMAN and not m_boRUNHUMAN) or (not g_Config.boRUNHUMAN and m_boRUNHUMAN) then
                    Continue;
                end
                else if BaseObject.m_btRaceServer = RC_NPC then begin
                  if g_Config.boRunNpc then
                    Continue;
                end
                else if BaseObject.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD] then begin
                  if g_Config.boRunGuard then
                    Continue;
                end
                else if (BaseObject.m_btRaceServer <> 55) and (BaseObject.m_btRaceServer <> RC_BOX) then begin
                  //不允许穿过练功师和宝箱
                  if (g_Config.boRUNMON and not m_boRUNMON) or (not g_Config.boRUNMON and m_boRUNMON) then
                    Continue;
                end;
                // end;
              // end;
             //end;
              end;
              if not BaseObject.m_boGhost and BaseObject.bo2B9
                and not BaseObject.m_boDeath
                and not BaseObject.m_boFixedHideMode
                and not BaseObject.m_boObMode
                and BaseObject.m_boMapApoise then begin
                Result := False;
                break;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

constructor TMapManager.Create;
begin

  inherited Create;
end;

destructor TMapManager.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do begin
    TEnvirnoment(Items[I]).Free;
  end;

  inherited;
end;
//Envir:TEnvirnoment

function TMapManager.GetMainMap(Envir: TEnvirnoment): string;
begin
  if Envir.m_boMainMap then
    Result := Envir.sMainMapName
  else
    Result := Envir.sMapName;
end;

function TMapManager.FindMap(sMapName: string): TEnvirnoment;
var
  Map: TEnvirnoment;
  I: Integer;
begin
  Result := nil;
  Lock;
  try
    for I := 0 to Count - 1 do begin
      Map := TEnvirnoment(Items[I]);
      if CompareText(Map.sMapName, sMapName) = 0 then begin
        Result := Map;
        break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TMapManager.GetMapInfo(nServerIdx: Integer; sMapName: string):
  TEnvirnoment;
var
  I: Integer;
  Envir: TEnvirnoment;
begin
  Result := nil;
  Lock;
  try
    for I := 0 to Count - 1 do begin
      Envir := Items[I];
      if{ (Envir.nServerIndex = nServerIdx) and }(CompareText(Envir.sMapName, sMapName) = 0) then begin
        Result := Envir;
        break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TEnvirnoment.DeleteFromMap(nX, nY: Integer; btType: Byte;
  pRemoveObject: TObject): Integer;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  n18: Integer;
  btRaceServer: Byte;
resourcestring
  sExceptionMsg1 = '[Exception] TEnvirnoment::DeleteFromMap -> Except 1 ** %d';
  sExceptionMsg2 = '[Exception] TEnvirnoment::DeleteFromMap -> Except 2 ** %d';
begin
  Result := -1;
  try
    if GetMapCellInfo(nX, nY, MapCellInfo) then begin
      if MapCellInfo <> nil then begin
        try
          if MapCellInfo.ObjList <> nil then begin
            n18 := 0;
            while (True) do begin
              if MapCellInfo.ObjList.Count <= n18 then break;
              OSObject := MapCellInfo.ObjList.Items[n18];
              if OSObject <> nil then begin
                if (OSObject.btType = btType) and (OSObject.CellObj = pRemoveObject) then begin
                  MapCellInfo.ObjList.Delete(n18);
                  DisPose(OSObject);

                  Result := 1;
                  //减地图人物怪物计数
                  if (btType = OS_MOVINGOBJECT) and (not
                    TBaseObject(pRemoveObject).m_boDelFormMaped) then begin
                    TBaseObject(pRemoveObject).m_boDelFormMaped := True;
                    TBaseObject(pRemoveObject).m_boAddToMaped := False;
                    btRaceServer := TBaseObject(pRemoveObject).m_btRaceServer;
                    if btRaceServer = RC_PLAYOBJECT then
                      Dec(m_nHumCount);
                    if btRaceServer >= RC_ANIMAL then
                      Dec(m_nMonCount);
                  end;
                  if MapCellInfo.ObjList.Count <= 0 then begin
                    FreeAndNil(MapCellInfo.ObjList);
                    break;
                  end;
                  Continue;
                end
              end
              else begin
                MapCellInfo.ObjList.Delete(n18);
                if MapCellInfo.ObjList.Count > 0 then
                  Continue;
                if MapCellInfo.ObjList.Count <= 0 then begin
                  FreeAndNil(MapCellInfo.ObjList);
                  break;
                end;
              end;
              Inc(n18);
            end;
          end
          else begin
            Result := -2;
          end;
        except
          MainOutMessage(format(sExceptionMsg1, [btType]));
        end;
      end
      else
        Result := -3;
    end
    else
      Result := 0;
  except
    MainOutMessage(format(sExceptionMsg2, [btType]));
  end;
end;

function TEnvirnoment.GetItem(nX, nY: Integer): PTMapItem;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if OSObject <> nil then begin
          if OSObject.btType = OS_ITEMOBJECT then begin
            Result := PTMapItem(OSObject.CellObj);
            Exit;
          end;
          if OSObject.btType = OS_GATEOBJECT then
            bo2C := False;
          if OSObject.btType = OS_MOVINGOBJECT then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if not BaseObject.m_boDeath then
              bo2C := False;
          end;
        end;
      end;
    end;
  end;
end;

function TMapManager.GetMapOfServerIndex(sMapName: string): Integer;
{var
  I: Integer;
  Envir: TEnvirnoment;   }
begin
  Result := 0;
  {Lock;
  try
    for I := 0 to Count - 1 do begin
      Envir := Items[I];
      if (CompareText(Envir.sMapName, sMapName) = 0) then begin
        Result := Envir.nServerIndex;
        break;
      end;
    end;
  finally
    UnLock;
  end;       }
end;

procedure TMapManager.LoadMapDoor;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do begin
    TEnvirnoment(Items[I]).AddDoorToMap;
  end;
end;

procedure TMapManager.ProcessMapDoor;
begin

end;

procedure TMapManager.ReSetMinMap;
var
  I, ii: Integer;
  Envirnoment: TEnvirnoment;
begin
  for I := 0 to Count - 1 do begin
    Envirnoment := TEnvirnoment(Items[I]);
    for ii := 0 to MiniMapList.Count - 1 do begin
      if CompareText(MiniMapList.Strings[ii], Envirnoment.sMapName) = 0 then begin
        Envirnoment.nMinMap := Integer(MiniMapList.Objects[ii]);
        break;
      end;
    end;
  end;
end;
 {
function TEnvirnoment.IsCheapStuff: Boolean; //004B6E24
begin
  if m_QuestList.Count > 0 then
    Result := True
  else
    Result := False;
end;
               }

procedure TEnvirnoment.DelEventByID(Event: Pointer);
var
  k, i: Integer;
  AddList: TList;
begin
  for k := m_Event.Count - 1 downto 0 do begin
    AddList := TList(m_Event.Objects[k]);
    for I := AddList.Count - 1 downto 0 do begin
      if AddList[I] = Event then begin
        AddList.Delete(I);
        if AddList.Count <= 0 then begin
          AddList.Free;
          m_Event.Delete(k);
        end;
        Exit;
      end;
    end;
  end;
end;


function TEnvirnoment.AddToMapMineEvent(nX, nY: Integer; nType: Integer; Event:
  TObject): TObject; //004B6600
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  bo19, bo1A: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::AddToMapMineEvent ';
begin
  Result := nil;
  try
    bo19 := GetMapCellInfo(nX, nY, MapCellInfo);
    bo1A := False;
    if bo19 and (MapCellInfo.chFlag <> 0) then begin
      if MapCellInfo.ObjList = nil then
        MapCellInfo.ObjList := TList.Create;
      if not bo1A then begin
        New(OSObject);
        OSObject.btType := nType;
        OSObject.CellObj := Event;
        OSObject.dwAddTime := GetTickCount();
        MapCellInfo.ObjList.Add(OSObject);
        Result := Event;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TEnvirnoment.VerifyMapTime(nX, nY: Integer; BaseObject: TObject);
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  boVerify: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::VerifyMapTime';
begin
  try
    boVerify := False;
    if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo <> nil) and (MapCellInfo.ObjList <> nil) then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) and (OSObject.CellObj = BaseObject) then begin
          OSObject.dwAddTime := GetTickCount();
          boVerify := True;
          break;
        end;
      end;
    end;
    if not boVerify then
      AddToMap(nX, nY, OS_MOVINGOBJECT, BaseObject);
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

constructor TEnvirnoment.Create;
begin
  Pointer(MapCellArray) := nil;
  sMapName := '';
  sSubMapName := '';
  sMainMapName := '';
  m_boMainMap := False;
  m_MasterObject := nil;
  m_UnAllowStdItemsList := nil;
  m_boUnAllowMagic := False;
  m_boNotStone := False;
  m_UnAllowMagicList := nil;
  m_MonGenList := TList.Create;
  m_RandomMapGateList := TList.Create;
  //nServerIndex := 0;
  FillChar(m_QuestFlag, SizeOf(m_QuestFlag), 0);
  nMinMap := 0;
  m_nMapIndex := 0;
  m_boNotHorse := False;
  m_boNoDeal := False;
  m_boNOTHROWITEM := False;
  m_nWidth := 0;
  m_boFBFail := False;
  m_boOffLine := False;
  m_boFBIsJob := False;
  m_dwFBFailTime := 0;
  m_nHeight := 0;
  m_btFBIndex := 0;
  NoReconnectEnvir := nil;
  m_sFBName := '';
  m_boDARK := False;
  m_boDAY := False;
  m_nMonCount := 0;
  m_nHumCount := 0;
  m_boDropItemMapEvent := False;
  m_boPickUpItemMapEvent := False;
  m_boHeavyHitMapEvent := False;
  m_boNotReAlive := False;
  m_boDropItemEvent := False;
  m_boPickUpItemEvent := False;
  m_boHeavyHitEvent := False;
  m_boFBCreate := False;
  m_StartPointList := TList.Create;
  m_DropItemEventList := TList.Create;
  m_PickUpItemEventList := TList.Create;
  m_HeavyHitEventList := TList.Create;
  m_DoorList := TList.Create;
  m_boFB := False;
  m_Event := TStringList.Create;
  m_MonsterList := TList.Create;
  m_dwCheckMonsterTick := GetTickCount + 60 * 1000 + LongWord(Random(60 * 1000));
  //m_QuestList := TList.Create;  }
end;

destructor TEnvirnoment.Destroy;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  nX, nY: Integer;
  DoorInfo: pTDoorInfo;
begin
  for nX := 0 to m_nWidth - 1 do begin
    for nY := 0 to m_nHeight - 1 do begin
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil)
        then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          case OSObject.btType of
            OS_ITEMOBJECT: DisPose(PTMapItem(OSObject.CellObj));
            OS_GATEOBJECT: DisPose(pTGateObj(OSObject.CellObj));
            OS_EVENTOBJECT: TEvent(OSObject.CellObj).Free;
          end;
          DisPose(OSObject);
        end;
        FreeAndNil(MapCellInfo.ObjList);
      end;
    end;
  end;

  for I := 0 to m_DoorList.Count - 1 do begin
    DoorInfo := m_DoorList.Items[I];
    Dec(DoorInfo.Status.nRefCount);
    if DoorInfo.Status.nRefCount <= 0 then
      DisPose(DoorInfo.Status);

    DisPose(DoorInfo);
  end;
  m_DoorList.Free;
  {for I := 0 to m_QuestList.Count - 1 do begin
    DisPose(pTMapQuestInfo(m_QuestList.Items[I]));
  end;
  m_QuestList.Free;   }
  for I := 0 to m_StartPointList.Count - 1 do begin
    DisPose(pTMapStartPoint(m_StartPointList.Items[I]));
  end;
  m_StartPointList.Free;
  m_DropItemEventList.Free;
  m_PickUpItemEventList.Free;
  m_HeavyHitEventList.Free;
  FreeMem(Pointer(MapCellArray));
  m_MonGenList.Free;
  Pointer(MapCellArray) := nil;
  m_Event.Free;
  m_MonsterList.Free;
  m_RandomMapGateList.Free;
  inherited;
end;

function TEnvirnoment.LoadMapData(sMapFile: string): Boolean;
var
  fHandle: Integer;
  Header: TMapHeader;
  nMapSize, nOldMapSize: Integer;
  n24, nW, nH: Integer;
  MapBuffer: pTMap;
  OldMapBuffer: pTOldMap;
  Point: Integer;
  Door: pTDoorInfo;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  ENMapHeader: TENMapHeader;
  boENMap: Boolean;
  ENMapData: array of TENMapInfo;
  boNewMap: Boolean;
begin
  Result := False;

  if FileExists(sMapFile) then begin
    fHandle := FileOpen(sMapFile, fmOpenRead or fmShareExclusive);
    if fHandle > 0 then begin
     // FileRead(fHandle, Header, SizeOf(TMapHeader));
      boNewMap := False;
      FileRead(fHandle, ENMapHeader, Sizeof(TENMapHeader));
      boENMap := (ENMapHeader.Title = 'Map 2010 Ver 1.0');
      if boENMap then begin
        Header.wWidth := ENMapHeader.Width xor $AA38;
        Header.wHeight := ENMapHeader.Height xor $AA38;
      end else begin
        Move(ENMapHeader, Header, SizeOf(Header));
        if (Header.sTitle[14] = #$D) and (Header.sTitle[15] = #$A) then
          boNewMap := True;
        FileSeek(fHandle, SizeOf(Header), 0);
      end;
      if (Header.wWidth <= 1000) and (Header.wHeight <= 1000) then begin
        m_nWidth := Header.wWidth;
        m_nHeight := Header.wHeight;
        Initialize(m_nWidth, m_nHeight);
        nMapSize := m_nWidth * SizeOf(TMapUnitInfo) * m_nHeight;
        MapBuffer := AllocMem(nMapSize);
        if boENMap then begin
          SetLength(ENMapData, m_nWidth * m_nHeight);
          FileRead(fHandle, ENMapData[0], Length(ENMapData) * SizeOf(TENMapInfo));
          for I := Low(ENMapData) to High(ENMapData) do begin
            MapBuffer[i].wBkImg := ENMapData[i].BkImg xor $AA38;
            if (ENMapData[i].BkImgNot xor $AA38) = $2000 then
              MapBuffer[i].wBkImg := MapBuffer[i].wBkImg or $8000;
            MapBuffer[i].wMidImg := ENMapData[i].MidImg xor $AA38;
            MapBuffer[i].wFrImg := ENMapData[i].FrImg xor $AA38;
            MapBuffer[i].btDoorIndex := ENMapData[i].DoorIndex;
            MapBuffer[i].btDoorOffset := ENMapData[i].DoorOffset;
            MapBuffer[i].btAniFrame := ENMapData[i].AniFrame;
            MapBuffer[i].btAniTick := ENMapData[i].AniTick;
            MapBuffer[i].btArea := ENMapData[i].Area;
            MapBuffer[i].btlight := ENMapData[i].light;
            MapBuffer[i].btBkIndex := 0;
            MapBuffer[i].btSmIndex := 0;
          end;
          ENMapData := nil;
        end else
        if boNewMap then begin
          FileRead(fHandle, MapBuffer^, nMapSize);
        end else begin
          nOldMapSize := m_nWidth * SizeOf(TOldMapUnitInfo) * m_nHeight;
          OldMapBuffer := AllocMem(nOldMapSize);
          Try
            FileRead(fHandle, OldMapBuffer^, nOldMapSize);
            for I := 0 to (m_nWidth * m_nHeight) - 1 do begin
              Move(OldMapBuffer[I], MapBuffer[i], SizeOf(TOldMapUnitInfo));
              MapBuffer[i].btBkIndex := 0;
              MapBuffer[i].btSmIndex := 0;
            end;
          Finally
            FreeMem(OldMapBuffer);
          End;
        end;

        for nW := 0 to m_nWidth - 1 do begin
          n24 := nW * m_nHeight;
          for nH := 0 to m_nHeight - 1 do begin
            if (MapBuffer[n24 + nH].wBkImg) and $8000 <> 0 then begin
              MapCellInfo := @MapCellArray[n24 + nH];
              MapCellInfo.chFlag := 1;
            end;
            if MapBuffer[n24 + nH].wFrImg and $8000 <> 0 then begin
              MapCellInfo := @MapCellArray[n24 + nH];
              MapCellInfo.chFlag := 2;
            end;
            if MapBuffer[n24 + nH].btDoorIndex and $80 <> 0 then begin
              Point := (MapBuffer[n24 + nH].btDoorIndex and $7F);
              if Point > 0 then begin
                New(Door);
                Door.nX := nW;
                Door.nY := nH;
                Door.n08 := Point;
                Door.Status := nil;
                for I := 0 to m_DoorList.Count - 1 do begin
                  if abs(pTDoorInfo(m_DoorList.Items[I]).nX - Door.nX) <= 10 then begin
                    if abs(pTDoorInfo(m_DoorList.Items[I]).nY - Door.nY) <= 10 then begin
                      if pTDoorInfo(m_DoorList.Items[I]).n08 = Point then begin
                        Door.Status := pTDoorInfo(m_DoorList.Items[I]).Status;
                        Inc(Door.Status.nRefCount);
                        break;
                      end;
                    end;
                  end;
                end;
                if Door.Status = nil then begin
                  New(Door.Status);
                  Door.Status.boOpened := False;
                  Door.Status.bo01 := False;
                  Door.Status.n04 := 0;
                  Door.Status.dwOpenTick := 0;
                  Door.Status.nRefCount := 1;
                end;
                m_DoorList.Add(Door);
              end;
            end;
          end;
        end;
        //Dispose(MapBuffer);
        FreeMem(MapBuffer);
        FileClose(fHandle);
        Result := True;
      end;
    end;
  end;
end;

procedure TEnvirnoment.Initialize(nWidth, nHeight: Integer);
var
  nW, nH: Integer;
  MapCellInfo: pTMapCellinfo;
begin
  if (nWidth > 1) and (nHeight > 1) then begin
    if MapCellArray <> nil then begin
      for nW := 0 to m_nWidth - 1 do begin
        for nH := 0 to m_nHeight - 1 do begin
          MapCellInfo := @MapCellArray[nW * m_nHeight + nH];
          if MapCellInfo.ObjList <> nil then begin
            FreeAndNil(MapCellInfo.ObjList);
          end;
        end;
      end;
      FreeMem(Pointer(MapCellArray));
      Pointer(MapCellArray) := nil;
    end;
    m_nWidth := nWidth;
    m_nHeight := nHeight;
    Pointer(MapCellArray) := AllocMem((m_nWidth * m_nHeight) * SizeOf(TMapCellinfo));
  end;
end;

//nFlag,boFlag,Monster,Item,Quest,boGrouped
{
function TEnvirnoment.CreateQuest(nFlag, nValue, nFlag2, nValue2: Integer; sMonName, sQuestName: string;
  boGrouped: Boolean): Boolean;
var
  MapQuest: pTMapQuestInfo;
  MapMerchant: TMerchant;
begin
  Result := False;
  if (nFlag < 0) or (nValue < 0) or (nFlag2 < 0) or (nValue2 < 0) then Exit;
  New(MapQuest);
  MapQuest.nFlag := nFlag;
  if nValue > 1 then nValue := 1;
  MapQuest.nValue := nValue;
  MapQuest.nFlag2 := nFlag2;
  if nValue2 > 1 then nValue2 := 1;
  MapQuest.nValue2 := nValue2;
  if sMonName = '*' then sMonName := '';
  MapQuest.sMonName := sMonName;
  if sQuestName = '*' then sQuestName := '';

  MapQuest.boGroup := boGrouped;
  MapMerchant := TMerchant.Create;
  MapMerchant.m_sMapName := '0';
  MapMerchant.m_nCurrX := 0;
  MapMerchant.m_nCurrY := 0;
  MapMerchant.m_sCharName := sQuestName;
  MapMerchant.m_nFlag := 0;
  MapMerchant.m_wAppr := 0;
  MapMerchant.m_sFilePath := 'MapQuest_def\';
  MapMerchant.m_boIsHide := True;
  MapMerchant.m_boIsQuest := False;

  UserEngine.QuestNPCList.Add(MapMerchant);
  MapQuest.NPC := MapMerchant;
  m_QuestList.Add(MapQuest);
  Result := True;
end;            }
  {
function TEnvirnoment.GetQuestList(sMonName: string): TList;
var
  i: Integer;
  MapQuest: pTMapQuestInfo;
begin
  Result := nil;
  for I := 0 to m_QuestList.Count - 1 do begin
    MapQuest := m_QuestList[I];
    if MapQuest.sMonName = sMonName then begin
      if Result = nil then Result := TList.Create;
      Result.Add(MapQuest);
    end;
  end;
end;   }

function TEnvirnoment.GetXYObjCount(nX, nY: Integer): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := 0;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
    begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      OSObject := MapCellInfo.ObjList.Items[I];
      if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
        BaseObject := TBaseObject(OSObject.CellObj);
        if BaseObject <> nil then begin
          if not BaseObject.m_boGhost and
            BaseObject.bo2B9 and
            not BaseObject.m_boDeath and
            not BaseObject.m_boFixedHideMode and
            not BaseObject.m_boObMode and
            BaseObject.m_boMapApoise then begin
            Inc(Result);
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetNextPosition(sX, sY, nDir, nFlag: Integer; var snx:
  Integer; var sny: Integer): Boolean;
begin
  snx := sX;
  sny := sY;
  case nDir of
    DR_UP: if sny > nFlag - 1 then
        Dec(sny, nFlag);
    DR_DOWN: if sny < (m_nHeight - nFlag) then
        Inc(sny, nFlag);
    DR_LEFT: if snx > nFlag - 1 then
        Dec(snx, nFlag);
    DR_RIGHT: if snx < (m_nWidth - nFlag) then
        Inc(snx, nFlag);
    DR_UPLEFT: begin
        if (snx > nFlag - 1) and (sny > nFlag - 1) then begin
          Dec(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_UPRIGHT: begin
        if (snx > nFlag - 1) and (sny < (m_nHeight - nFlag)) then begin
          Inc(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_DOWNLEFT: begin
        if (snx < (m_nWidth - nFlag)) and (sny > nFlag - 1) then begin
          Dec(snx, nFlag);
          Inc(sny, nFlag);
        end;
      end;
    DR_DOWNRIGHT: begin
        if (snx < (m_nWidth - nFlag)) and (sny < (m_nHeight - nFlag)) then begin
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

function TEnvirnoment.GetOffLincCount(nX, nY: Integer): Integer;
var
  List: TList;
  I: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  List := TList.Create;
  Try
    GeTBaseObjects(nX, nY, True, List);
    for I := 0 to List.Count - 1 do begin
      BaseObject := TBaseObject(List[I]);
      if (BaseObject = nil) or BaseObject.m_boGhost or BaseObject.m_boDeath then break;
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
        if TPlayObject(BaseObject).m_boSafeOffLine then
          Inc(Result);
      end;
    end;
  Finally
    List.Free;
  End;
end;

function TEnvirnoment.GetQuestFalgStatus(nFlag: Integer): Integer;
var
  n10, n14: Integer;
begin
  Result := 0;
  Dec(nFlag);
  if nFlag < 0 then Exit;
  n10 := nFlag div 8;
  n14 := (nFlag mod 8);
  if (n10 in [Low(m_QuestFlag)..High(m_QuestFlag)]) then begin
    if ((128 shr n14) and (m_QuestFlag[n10])) <> 0 then
      Result := 1
    else
      Result := 0;
  end;
end;

function TEnvirnoment.CanSafeWalk(nX, nY: Integer): Boolean;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := MapCellInfo.ObjList.Count - 1 downto 0 do begin
      OSObject := MapCellInfo.ObjList.Items[I];
      if (OSObject <> nil) and (OSObject.btType = OS_EVENTOBJECT) then begin
        if TEvent(OSObject.CellObj).m_nDamage > 0 then
          Result := False;
      end;
    end;
  end;
end;

function TEnvirnoment.ArroundDoorOpened(nX, nY: Integer): Boolean;
var
  I: Integer;
  Door: pTDoorInfo;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::ArroundDoorOpened ';
begin
  Result := True;
  try
    for I := 0 to m_DoorList.Count - 1 do begin
      Door := m_DoorList.Items[I];
      //if (abs(Door.nX - nX) <= 1) and ((abs(Door.nY - nY) <= 1)) then begin
      if (Door.nX = nX) and (Door.nY = nY) then begin
        if not Door.Status.boOpened then begin
          Result := False;
          break;
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

function TEnvirnoment.GetMovingObject(nX, nY: Integer; boFlag: Boolean):
  Pointer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      OSObject := MapCellInfo.ObjList.Items[I];
      if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
        BaseObject := TBaseObject(OSObject.CellObj);
        if ((BaseObject <> nil) and
          (not BaseObject.m_boGhost) and
          (BaseObject.bo2B9)) and
          ((not boFlag) or (not BaseObject.m_boDeath)) then begin
          Result := BaseObject;
          break;
        end;
      end;
    end;
  end;
end;
    (*
function TEnvirnoment.GetQuestNPC(BaseObject: TObject; sCharName, sStr: string; boFlag: Boolean): TObject;
var
  I: Integer;
  MapQuestFlag: pTMapQuestInfo;
  nFlagValue: Integer;
  //bo1D: Boolean;
begin
  Result := nil;
  if TBaseObject(BaseObject).m_btRaceServer <> RC_PLAYOBJECT then exit;
  for I := 0 to m_QuestList.Count - 1 do begin
    MapQuestFlag := m_QuestList.Items[I];
    nFlagValue := TPlayObject(BaseObject).GetQuestFalgStatus(MapQuestFlag.nFlag);
    if nFlagValue = MapQuestFlag.nValue then begin
      if (boFlag = MapQuestFlag.boGroup) or (not boFlag) then begin
        //bo1D := False;
        if (MapQuestFlag.sMonName = '') or (MapQuestFlag.sMonName = sCharName) then begin
          Result := MapQuestFlag.NPC;
          break;
        end;
        {if (MapQuestFlag.s08 <> '') and (MapQuestFlag.s0C <> '') then begin
          if (MapQuestFlag.s08 = sCharName) and (MapQuestFlag.s0C = sStr) then
            bo1D := True;
        end;
        if (MapQuestFlag.s08 <> '') and (MapQuestFlag.s0C = '') then begin
          if (MapQuestFlag.s08 = sCharName) and (sStr = '') then
            bo1D := True;
        end;
        if (MapQuestFlag.s08 = '') and (MapQuestFlag.s0C <> '') then begin
          if (MapQuestFlag.s0C = sStr) then
            bo1D := True;
        end;
        if bo1D then begin
          Result := MapQuestFlag.NPC;
          break;
        end;   }
      end;
    end;
  end;
end;        *)

function TEnvirnoment.GetItemEx(nX, nY: Integer;
  var nCount: Integer): Pointer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  nCount := 0;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if OSObject <> nil then begin
          if OSObject.btType = OS_ITEMOBJECT then begin
            Result := Pointer(OSObject.CellObj);
            Inc(nCount);
          end;
          if OSObject.btType = OS_GATEOBJECT then begin
            bo2C := False;
          end;
          if OSObject.btType = OS_MOVINGOBJECT then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if not BaseObject.m_boDeath then
              bo2C := False;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetDoor(nX, nY: Integer): pTDoorInfo;
var
  I: Integer;
  Door: pTDoorInfo;
begin
  Result := nil;
  for I := 0 to m_DoorList.Count - 1 do begin
    Door := m_DoorList.Items[I];
    if (Door.nX = nX) and (Door.nY = nY) then begin
      Result := Door;
      Exit;
    end;
  end;
end;

function TEnvirnoment.IsValidObject(nX, nY, nRage: Integer; BaseObject: TObject): Boolean;
var
  nXX, nYY, I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      if GetMapCellInfo(nXX, nYY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) and
            (OSObject.CellObj = BaseObject) then begin
            Result := True;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetRangeBaseObject(nX, nY, nRage: Integer; boFlag:
  Boolean;
  BaseObjectList: TList): Integer;
var
  nXX, nYY: Integer;
begin
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      GeTBaseObjects(nXX, nYY, boFlag, BaseObjectList);
    end;
  end;
  Result := BaseObjectList.Count;
end;
function TEnvirnoment.GetShopingCount(nX, nY: Integer): Integer;
var
  List: TList;
  I: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  List := TList.Create;
  Try
    GeTBaseObjects(nX, nY, True, List);
    for I := 0 to List.Count - 1 do begin
      BaseObject := TBaseObject(List[I]);
      if (BaseObject = nil) or BaseObject.m_boGhost or BaseObject.m_boDeath then break;
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
        if TPlayObject(BaseObject).m_boShoping then
          Inc(Result);
      end;
    end;
  Finally
    List.Free;
  End;
end;

//boFlag 是否包括死亡对象
//FALSE 包括死亡对象
//TRUE  不包括死亡对象

function TEnvirnoment.GeTBaseObjects(nX, nY: Integer; boFlag: Boolean; BaseObjectList: TList): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      OSObject := MapCellInfo.ObjList.Items[I];
      if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
        BaseObject := TBaseObject(OSObject.CellObj);
        if BaseObject <> nil then begin
          if not BaseObject.m_boGhost and BaseObject.bo2B9 then begin
            if not boFlag or not BaseObject.m_boDeath then
              BaseObjectList.Add(BaseObject);
          end;
        end;
      end;
    end;
  end;
  Result := BaseObjectList.Count;
end;

function TEnvirnoment.GetEvent(nX, nY: Integer): TObject;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := nil;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
    begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
      OSObject := MapCellInfo.ObjList.Items[I];
      if (OSObject <> nil) and (OSObject.btType = OS_EVENTOBJECT) then begin
        Result := OSObject.CellObj;
      end;
    end;
  end;
end;

function TEnvirnoment.GetFireBurn(nX, nY: Integer): Boolean;
var
  MapCellInfo: pTMapCellinfo;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) then begin
    Result := CheckByteStatus(MapCellInfo.btFlag, ENEVENT_FIREBURN);
  end;
end;

procedure TEnvirnoment.SetFireBurn(nX, nY: Integer; boFlag: Boolean);
var
  MapCellInfo: pTMapCellinfo;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) then begin
    SetByteStatus(MapCellInfo.btFlag, ENEVENT_FIREBURN, boFlag);
  end;
end;

procedure TEnvirnoment.SetMapXYFlag(nX, nY: Integer; boFlag: Boolean);
var
  MapCellInfo: pTMapCellinfo;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) then begin
    if boFlag then
      MapCellInfo.chFlag := 0
    else
      MapCellInfo.chFlag := 2;
  end;
end;

procedure TEnvirnoment.SetQuestFlagStatus(nFlag: Integer; nValue: Integer);
var
  n10, n14: Integer;
  bt15: Byte;
begin
  Dec(nFlag);
  if nFlag < 0 then Exit;
  n10 := nFlag div 8;
  n14 := (nFlag mod 8);
  if (n10 in [Low(m_QuestFlag)..High(m_QuestFlag)]) then begin
    bt15 := m_QuestFlag[n10];
    if nValue = 0 then begin
      m_QuestFlag[n10] := (not (128 shr n14)) and (bt15);
    end
    else begin
      m_QuestFlag[n10] := (128 shr n14) or (bt15);
    end;
  end;
end;

function TEnvirnoment.CanFly(nSX, nSY, nDX, nDY: Integer): Boolean;
var
  r28, r30: real;
  n14, n18, n1C: Integer;
begin
  Result := True;
  r28 := (nDX - nSX) / 1.0E1;
  r30 := (nDY - nDX) / 1.0E1;
  n14 := 0;
  while (True) do begin
    n18 := ROUND(nSX + r28);
    n1C := ROUND(nSY + r30);
    if not CanWalk(n18, n1C, True) then begin
      Result := False;
      break;
    end;
    Inc(n14);
    if n14 >= 10 then
      break;
  end;
end;

function TEnvirnoment.GetXYHuman(nMapX, nMapY, nRage: Integer): Integer;
var
  nX, nY, I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := 0;
  for nX := nMapX - nRage to nMapX + nRage do begin
    for nY := nMapY - nRage to nMapY + nRage do begin
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) then begin
              Inc(Result);
              break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.sub_4B5FC8(nX, nY: Integer): Boolean;
var
  MapCellInfo: pTMapCellinfo;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 2) then
    Result := False;
end;

function TEnvirnoment.GetEnvirInfo: string;
var
  sMsg: string;
begin
  sMsg :=
    '地图名:%s(%s) DAY:%s DARK:%s SAFE:%s FIGHT:%s FIGHT3:%s QUIZ:%s NORECONNECT:%s(%s) MUSIC:%s(%d) EXPRATE:%s(%f) PKWINLEVEL:%s(%d) PKLOSTLEVEL:%s(%d) PKWINEXP:%s(%d) PKLOSTEXP:%s(%d) DECHP:%s(%d/%d) INCHP:%s(%d/%d)';
  sMsg := sMsg +
    ' DECGAMEGOLD:%s(%d/%d) INCGAMEGOLD:%s(%d/%d) INCGAMEPOINT:%s(%d/%d) RUNHUMAN:%s RUNMON:%s NEEDHOLE:%s NORECALL:%s NOGUILDRECALL:%s NODEARRECALL:%s NOMASTERRECALL:%s NODRUG:%s MINE:%s NOPOSITIONMOVE:%s';
  Result := format(sMsg, [sMapName,
    sMapDesc,
      BoolToCStr(m_boDAY),
      BoolToCStr(m_boDARK),
      BoolToCStr(m_boSAFE),
      BoolToCStr(m_boFightZone),
      BoolToCStr(m_boFight3Zone),
      BoolToCStr(m_boQUIZ),
      BoolToCStr(m_boNORECONNECT), sNoReconnectMap,
      BoolToCStr(m_boMUSIC), m_nMUSICID,
      BoolToCStr(m_boEXPRATE), m_nEXPRATE / 100,
      BoolToCStr(m_boPKWINLEVEL), m_nPKWINLEVEL,
      BoolToCStr(m_boPKLOSTLEVEL), m_nPKLOSTLEVEL,
      BoolToCStr(m_boPKWINEXP), m_nPKWINEXP,
      BoolToCStr(m_boPKLOSTEXP), m_nPKLOSTEXP,
      BoolToCStr(m_boDECHP), m_nDECHPTIME, m_nDECHPPOINT,
      BoolToCStr(m_boINCHP), m_nINCHPTIME, m_nINCHPPOINT,
      BoolToCStr(m_boDecGameGold), m_nDECGAMEGOLDTIME, m_nDecGameGold,
      BoolToCStr(m_boIncGameGold), m_nINCGAMEGOLDTIME, m_nIncGameGold,
      BoolToCStr(m_boINCGAMEPOINT), m_nINCGAMEPOINTTIME, m_nINCGAMEPOINT,
      BoolToCStr(m_boRUNHUMAN),
      BoolToCStr(m_boRUNMON),
      BoolToCStr(m_boNEEDHOLE),
      BoolToCStr(m_boNORECALL),
      BoolToCStr(m_boNOGUILDRECALL),
      BoolToCStr(m_boNODEARRECALL),
      BoolToCStr(m_boNOMASTERRECALL),
      BoolToCStr(m_boNODRUG),
      BoolToCStr(m_boMINE),
      BoolToCStr(m_boNOPOSITIONMOVE)
      ]);
end;

procedure TEnvirnoment.AddObject(nType: Integer);
begin
  case nType of
    0: Inc(m_nHumCount);
    1: Inc(m_nMonCount);
  end;
end;

procedure TEnvirnoment.DelObjectCount(BaseObject: TObject);
var
  btRaceServer: Byte;
begin
  btRaceServer := TBaseObject(BaseObject).m_btRaceServer;
  if btRaceServer = RC_PLAYOBJECT then
    Dec(m_nHumCount);
  if btRaceServer >= RC_ANIMAL then
    Dec(m_nMonCount);
end;

procedure TMapManager.Run;
begin

end;

end.

