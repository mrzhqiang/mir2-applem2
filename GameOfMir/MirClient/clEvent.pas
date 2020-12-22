unit clEvent;

interface

uses
  Windows, Classes, HGETextures, Grobal2, CliUtil, MShare;

const
   ZOMBIDIGUPDUSTBASE = 420;//石墓尸王从土中钻出来(的事件event),,这里是图片帧，存在于
   //mon6.wil中从第420开始的地图效果
   STONEFRAGMENTBASE = 64;//Effect.wil中,,,挖矿时会有二个地图效果，1，尘土飞扬，不在地面堆积
   //2,,碎石坠落，，在地面产生变化就像ZOMBIDIGUPDUSTBASE,,
   HOLYCURTAINBASE = 1390; //Magic.wil,,困魔咒的地面效果
  SHOPBASE = 328;
   FIREBURNBASE = 1630;//火墙的地面效果
   SCULPTUREFRAGMENT = 1349;//mon7.wil中祖玛教主被激活
type
  TClEvent = class
    m_nX: Integer;
    m_nY: Integer;
    m_nDir: Integer;
    m_nPx: Integer;
    m_nPy: Integer;
    m_nPx2: Integer;
    m_nPy2: Integer;
    m_nPx3: Integer;
    m_nPy3: Integer;
    m_nPx4: Integer;
    m_nPy4: Integer;
    m_nPx5: Integer;
    m_nPy5: Integer;
    m_nEventType: Integer;
    m_nEventParam: Integer;
    m_nServerId: Integer;
    m_Dsurface: TDirectDrawSurface;
    m_Dsurface2: TDirectDrawSurface;
    m_Dsurface3: TDirectDrawSurface;
    m_Dsurface4: TDirectDrawSurface;
    m_Dsurface5: TDirectDrawSurface;
    m_boBlend: Boolean;
    m_dwFrameTime: LongWord;
    m_dwFrameTick: LongWord;
    m_dwCurframe: LongWord;
    m_boClient: Boolean;
    m_nLight: Integer;
  private
  public
    constructor Create(svid, ax, ay, evtype: integer);
    destructor Destroy; override;
    procedure DrawEvent(backsurface: TDirectDrawSurface; ax, ay: integer); dynamic;
    procedure Run; dynamic;
  end;

  TShopClEvent = class(TClEvent)
    m_sShopName: string[10];
  public
    constructor Create(svid, ax, ay, evtype: integer; sName: string);
    procedure DrawEvent(backsurface: TDirectDrawSurface; ax, ay: integer); override;
  end;

  TClEventManager = class
  private
  public
    EventList: TList;
    constructor Create;
    destructor Destroy; override;
    procedure ClearEvents;
    function AddEvent(evn: TClEvent): TClEvent;
    procedure DelEvent(evn: TClEvent);
    procedure DelEventById(svid: integer);
    function GetEvent(ax, ay, etype: integer): TClEvent;
    procedure Execute;
  end;

implementation

uses
  ClMain, WMFile;

constructor TClEvent.Create(svid, ax, ay, evtype: integer);
begin
  m_nServerId := svid;
  m_nX := ax;
  m_nY := ay;
  m_nEventType := evtype;
  m_nEventParam := 0;
  m_boBlend := FALSE;
  m_dwFrameTime := GetTickCount;
  m_dwCurframe := 0;
  m_nLight := 0;
  m_boClient := False;
  m_dwFrameTick := 20;
end;

destructor TClEvent.Destroy;
begin
  if m_nEventType = ET_MACHINERY then
    Map.MarkCanWalk(m_nX, m_nY, True);
  inherited Destroy;
end;

procedure TClEvent.DrawEvent(backsurface: TDirectDrawSurface; ax, ay: integer);
begin
  if m_Dsurface <> nil then begin
    if m_boBlend then
      DrawBlend(backsurface, ax + m_nPx, ay + m_nPy, m_Dsurface, 1)
    else
      backsurface.Draw(ax + m_nPx, ay + m_nPy, m_Dsurface.ClientRect, m_Dsurface, TRUE);
  end;
  if m_Dsurface2 <> nil then begin
    if m_boBlend then
      DrawBlend(backsurface, ax + m_nPx2, ay + m_nPy2, m_Dsurface2, 1)
    else
      backsurface.Draw(ax + m_nPx2, ay + m_nPy2, m_Dsurface2.ClientRect, m_Dsurface2, TRUE);
  end;
  if m_Dsurface3 <> nil then begin
    if m_boBlend then
      DrawBlend(backsurface, ax + m_nPx3, ay + m_nPy3, m_Dsurface3, 1)
    else
      backsurface.Draw(ax + m_nPx3, ay + m_nPy3, m_Dsurface3.ClientRect, m_Dsurface3, TRUE);
  end;
  if m_Dsurface4 <> nil then begin
    if m_boBlend then
      DrawBlend(backsurface, ax + m_nPx4, ay + m_nPy4, m_Dsurface4, 1)
    else
      backsurface.Draw(ax + m_nPx4, ay + m_nPy4, m_Dsurface4.ClientRect, m_Dsurface4, TRUE);
  end;
  if m_Dsurface5 <> nil then begin
    if m_boBlend then
      DrawBlend(backsurface, ax + m_nPx5, ay + m_nPy5, m_Dsurface5, 1)
    else
      backsurface.Draw(ax + m_nPx5, ay + m_nPy5, m_Dsurface5.ClientRect, m_Dsurface5, TRUE);
  end;
end;

procedure TClEvent.Run;
begin
  m_Dsurface := nil;
  m_Dsurface2 := nil;
  m_Dsurface3 := nil;
  m_Dsurface4 := nil;
  m_Dsurface5 := nil;
  if GetTickCount - m_dwFrameTime > m_dwFrameTick then begin
    m_dwFrameTime := GetTickCount;
    Inc(m_dwCurframe);
  end;
  //Inc(m_dwCurframe);
  case m_nEventType of

    ET_DIGOUTZOMBI: m_Dsurface := g_WMons[6].GetCachedImage(ZOMBIDIGUPDUSTBASE + m_nDir, m_nPx, m_nPy);
    ET_PILESTONES: begin
        if m_nEventParam <= 0 then
          m_nEventParam := 1;
        if m_nEventParam > 5 then
          m_nEventParam := 5;

        m_Dsurface := g_WEffectImages.GetCachedImage(STONEFRAGMENTBASE + (m_nEventParam - 1), m_nPx, m_nPy);
      end;
    ET_HOLYCURTAIN: begin
        m_Dsurface := g_WMagicImages.GetCachedImage(HOLYCURTAINBASE + (m_dwCurframe mod 10), m_nPx, m_nPy);

        m_boBlend := TRUE;
        m_nLight := 1;
      end;
    ET_MACHINERY: begin
        m_Dsurface := g_WMagicImages.GetCachedImage(HOLYCURTAINBASE + (m_dwCurframe mod 10), m_nPx, m_nPy);
        m_Dsurface2 := g_WMagicImages.GetCachedImage(HOLYCURTAINBASE + ((m_dwCurframe + 2) mod 10), m_nPx2, m_nPy2);
        m_Dsurface3 := g_WMagicImages.GetCachedImage(HOLYCURTAINBASE + ((m_dwCurframe + 4) mod 10), m_nPx3, m_nPy3);
        m_boBlend := TRUE;
        m_nLight := 1;
        Map.MarkCanWalk(m_nX, m_nY, False);
      end;
    ET_FIRE: begin
       // m_Dsurface := g_WMagic99Images.GetCachedImage(FIREBURNBASE + ((m_dwCurframe div 3) mod 3), m_nPx, m_nPy);
        m_Dsurface := g_WMagicImages.GetCachedImage(FIREBURNBASE + ((m_dwCurframe div 2) mod 6), m_nPx, m_nPy);
        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_SCULPEICE: begin
        m_Dsurface := g_WMons[7].GetCachedImage(SCULPTUREFRAGMENT, m_nPx, m_nPy);
      end;
    ET_SHOP: begin
        m_Dsurface := g_WEffectImages.GetCachedImage(SHOPBASE + (m_dwCurframe mod 10), m_nPx, m_nPy);
        m_boBlend := TRUE;
        m_nLight := 1;
      end;
    ET_INCHP: begin
        m_Dsurface := g_WMagic99Images.GetCachedImage(880 + ((m_dwCurframe div 3) mod 16), m_nPx, m_nPy);

        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_RANDOMGATE: begin
        m_Dsurface := g_WEffectImages.GetCachedImage(846 + ((m_dwCurframe div 3) mod 10), m_nPx, m_nPy);

        m_boBlend := True;
        m_nLight := 1;
      end;
  end;
end;

{-----------------------------------------------------------------------------}

{-----------------------------------------------------------------------------}

constructor TClEventManager.Create;
begin
  EventList := TList.Create;
end;

destructor TClEventManager.Destroy;
var
  i: integer;
begin
  for i := 0 to EventList.Count - 1 do
    TClEvent(EventList[i]).Free;
  EventList.Free;
  inherited Destroy;
end;

procedure TClEventManager.ClearEvents;
var
  i: integer;
begin
  for i := 0 to EventList.Count - 1 do
    TClEvent(EventList[i]).Free;
  EventList.Clear;
end;

function TClEventManager.AddEvent(evn: TClEvent): TClEvent;
var
  i: integer;
  //  event: TClEvent;
begin
  for i := 0 to EventList.Count - 1 do
    if (EventList[i] = evn) or (TClEvent(EventList[i]).m_nServerId = evn.m_nServerId) then begin
      evn.Free;
      Result := nil;
      exit;
    end;
  EventList.Add(evn);
  Result := evn;
end;

procedure TClEventManager.DelEvent(evn: TClEvent);
var
  i: integer;
begin
  for i := 0 to EventList.Count - 1 do
    if (EventList[i] = evn) and (not evn.m_boClient) then begin
      TClEvent(EventList[i]).Free;
      EventList.Delete(i);
      break;
    end;
end;

procedure TClEventManager.DelEventById(svid: integer);
var
  i: integer;
begin
  for i := 0 to EventList.Count - 1 do
    if (TClEvent(EventList[i]).m_nServerId = svid) and (not TClEvent(EventList[i]).m_boClient) then begin
      TClEvent(EventList[i]).Free;
      EventList.Delete(i);
      break;
    end;
end;

function TClEventManager.GetEvent(ax, ay, etype: integer): TClEvent;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to EventList.Count - 1 do
    if (TClEvent(EventList[i]).m_nX = ax) and (TClEvent(EventList[i]).m_nY = ay) and
      (TClEvent(EventList[i]).m_nEventType = etype) then begin
      Result := TClEvent(EventList[i]);
      break;
    end;
end;

procedure TClEventManager.Execute;
var
  i: integer;
begin
  for i := 0 to EventList.Count - 1 do
    TClEvent(EventList[i]).Run;
end;

{ TShopClEvent }

constructor TShopClEvent.Create(svid, ax, ay, evtype: integer; sName: string);
begin
  inherited Create(svid, ax, ay, evtype);
  m_sShopName := sName;
end;

procedure TShopClEvent.DrawEvent(backsurface: TDirectDrawSurface; ax, ay: integer);
begin
  inherited;
  with g_DXCanvas do begin
    //SetBkMode(Handle, TRANSPARENT);
    TextOut(ax, ay, $B1D2B7, m_sShopName);
    //Release;
  end;
end;

end.
