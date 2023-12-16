unit MapUnit;
//地图单元
{ MAP文件结构
    文件头：52字节
    第一行第一列定义
    第二行第一列定义
    第三行第一列定义
    ...
    第Width行第一列定义
    第一行第二列定义
    ...
}
interface

uses
  Windows, Classes, SysUtils, Grobal2, HUtil32, 
  MShare, Share, FindMapPath;

type
  TMapInfoArr = array[0..MaxListSize] of TMapInfo;
  pTMapInfoArr = ^TMapInfoArr;

  TMap = class
  private
    procedure UpdateMapSeg(cx, cy: Integer);
    procedure LoadMapArr(nCurrX, nCurrY: Integer);
  public
    m_boNewMap: Boolean;
    m_sFileName: string;
    m_MArr: array[0..MAXX * 3, 0..MAXY * 3] of TMapInfo;
    m_boChange: Boolean;
    m_ClientRect: TRect;
    m_OldClientRect: TRect;
    m_nBlockLeft: Integer;
    m_nBlockTop: Integer;
    m_nOldLeft: Integer;
    m_nOldTop: Integer;
    m_sOldMap: string;
    m_nCurUnitX: Integer;
    m_nCurUnitY: Integer;
    m_sCurrentMap: string;
    m_boSegmented: Boolean;
    m_nSegXCount: Integer;
    m_nSegYCount: Integer;
    constructor Create;
    destructor Destroy; override;
    procedure UpdateMapSquare(cx, cy: Integer);
    procedure UpdateMapPos(mx, my: Integer);
    procedure ReadyReload;
    procedure LoadMap(sMapName: string; nMx, nMy: Integer);
    procedure MarkCanWalk(mx, my: Integer; bowalk: Boolean);
    function CanMove(mx, my: Integer): Boolean;
    function CanFly(mx, my: Integer): Boolean;
    function GetDoor(mx, my: Integer): Integer;
    function IsDoorOpen(mx, my: Integer): Boolean;
    function OpenDoor(mx, my: Integer): Boolean;
    function CloseDoor(mx, my: Integer): Boolean;
  end;

implementation

uses
  ClMain;

constructor TMap.Create;
begin
  inherited Create;
  m_ClientRect := Rect(0, 0, 0, 0);
  m_boChange := FALSE;
  m_sCurrentMap := '';//当前地图文件名（不含.MAP）
  m_boSegmented := FALSE;
  m_nSegXCount := 0;
  m_nSegYCount := 0;
  m_nCurUnitX := -1;//当前单元位置X、Y
  m_nCurUnitY := -1;
  m_nBlockLeft := -1;//当前块X,Y左上角
  m_nBlockTop := -1;
  m_sOldMap := '';//前一个地图文件名（在换地图的时候用）
  m_boNewMap := False;
end;

destructor TMap.Destroy;
begin
  inherited Destroy;
end;

procedure TMap.UpdateMapSeg(cx, cy: Integer);
begin
// do nothing
end;

// 加载地图段数据
procedure TMap.LoadMapArr(nCurrX, nCurrY: Integer);
var
  i: Integer;
  nLx: Integer;
  nRx: Integer;
  nTy: Integer;
  nBy: Integer;
  Header: TMapHeader;
begin
  SafeFillChar(m_MArr, sizeof(m_MArr), #0);
  Header := g_LegendMap.MapHeader;
  // 计算得到 LOGICALMAPUNIT 划分的地图区域中，当前坐标所属区域的左上对角区域和右下对角区域
  // 所谓右下对角，就是以田字为准，当前区域为左上区域，则右下对角为右下区域
  nLx := (nCurrX - 1) * LOGICALMAPUNIT;
  nRx := (nCurrX + 2) * LOGICALMAPUNIT;
  nTy := (nCurrY - 1) * LOGICALMAPUNIT;
  nBy := (nCurrY + 2) * LOGICALMAPUNIT;
  // 判断计算出来的区域坐标是否超出地图坐标系，如果有超出则重置为地图界限
  if nLx < 0 then nLx := 0;
  if nTy < 0 then nTy := 0;
  if nBy >= Header.wHeight then nBy := Header.wHeight;
  // 将计算得到的区域数据，从已加载的地图数据中复制到当前使用的地图数据
  for i := nLx to nRx - 1 do begin
    if (i >= 0) and (i < Header.wWidth) then begin
      Move(g_LegendMap.MapData[Header.wHeight * i + nTy], m_MArr[i - nLx, 0], Sizeof(TMapInfo) * (nBy - nTy));
    end;
  end;
  m_boNewMap := g_LegendMap.boNewMap;
end;

procedure TMap.ReadyReload;
begin
  m_nCurUnitX := -1;
  m_nCurUnitY := -1;
end;

// 更新地图方块
procedure TMap.UpdateMapSquare(cx, cy: Integer);
begin
  if (cx <> m_nCurUnitX) or (cy <> m_nCurUnitY) then begin
    // 目前始终是 FALSE
    if m_boSegmented then
      UpdateMapSeg(cx, cy)
    else
      LoadMapArr(cx, cy);
    m_nCurUnitX := cx;
    m_nCurUnitY := cy;
  end;
end;

// 移动时频繁调用，用于更新地图位置
procedure TMap.UpdateMapPos(mx, my: Integer);
var
  cx, cy: Integer;
begin
  // 地图坐标为 mx my
  // 通过 LOGICALMAPUNIT 将地图坐标系均分 N 份区域
  // 从而计算得到当前坐标所属的区域左上角坐标 cx cy
  cx := mx div LOGICALMAPUNIT;
  cy := my div LOGICALMAPUNIT;
  // 再找到当前区域对角区域的左上角坐标 m_nBlockLeft m_nBlockTop
  // 所谓对角区域就是 田 字的右下部分对角左上部分
  m_nBlockLeft := _MAX(0, (cx - 1) * LOGICALMAPUNIT);
  m_nBlockTop := _MAX(0, (cy - 1) * LOGICALMAPUNIT);

  UpdateMapSquare(cx, cy);

  m_nOldLeft := m_nBlockLeft;
  m_nOldTop := m_nBlockTop;
end;

// 加载地图
procedure TMap.LoadMap(sMapName: string; nMx, nMy: Integer);
begin
  m_nCurUnitX := -1;
  m_nCurUnitY := -1;
  m_sCurrentMap := sMapName;
  m_boSegmented := FALSE;
  UpdateMapPos(nMx, nMy);
  m_sOldMap := m_sCurrentMap;
end;

// 标记前景是否可以行走
procedure TMap.MarkCanWalk(mx, my: Integer; bowalk: Boolean);
var
  cx, cy: Integer;
begin
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) or (cx > MAXX * 3) or (cy > MAXY * 3) then Exit;
  if bowalk then//该坐标可以行走，则MArr[cx,cy]的值最高位为0
    Map.m_MArr[cx, cy].wFrImg := Map.m_MArr[cx, cy].wFrImg and $7FFF
  else //不可以行走的，最高位为1
    Map.m_MArr[cx, cy].wFrImg := Map.m_MArr[cx, cy].wFrImg or $8000;
end;

//若前景和背景都可以走，则返回真
function TMap.CanMove(mx, my: Integer): Boolean;
var
  cx, cy: Integer;
begin
  Result := FALSE;
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) or (cx > MAXX * 3) or (cy > MAXY * 3) then
    Exit;//前景和背景都可以走（最高位为0）
  Result := ((Map.m_MArr[cx, cy].wBkImg and $8000) + (Map.m_MArr[cx, cy].wFrImg and $8000)) = 0;
  if Result then begin
    if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
      if (Map.m_MArr[cx, cy].btDoorOffset and $80) = 0 then
        Result := FALSE;
    end;
  end;
end;

//若前景可以走，则返回真。
function TMap.CanFly(mx, my: Integer): Boolean;
var
  cx, cy: Integer;
begin
  Result := FALSE;
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) or (cx > MAXX * 3) or (cy > MAXY * 3) then
    Exit;
  Result := (Map.m_MArr[cx, cy].wFrImg and $8000) = 0;
  if Result then begin
    if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
      if (Map.m_MArr[cx, cy].btDoorOffset and $80) = 0 then
        Result := FALSE;
    end;
  end;
end;

//获得指定坐标的门的索引号
function TMap.GetDoor(mx, my: Integer): Integer;
var
  cx, cy: Integer;
begin
  Result := 0;
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) or (cx > MAXX * 3) or (cy > MAXY * 3) then
    Exit;
  if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin//是门
    Result := Map.m_MArr[cx, cy].btDoorIndex and $7F;  //门的索引在低7位
  end;
end;

//判断门是否打开
function TMap.IsDoorOpen(mx, my: Integer): Boolean;
var
  cx, cy: Integer;
begin
  Result := FALSE;
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) or (cx > MAXX * 3) or (cy > MAXY * 3) then
    Exit;
  if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin//是门
    Result := (Map.m_MArr[cx, cy].btDoorOffset and $80 <> 0);
  end;
end;

//打开门
function TMap.OpenDoor(mx, my: Integer): Boolean;
var
  i, j, cx, cy, idx: Integer;
begin
  Result := FALSE;
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) or (cx > MAXX * 3) or (cy > MAXY * 3) then
    Exit;
  if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
    idx := Map.m_MArr[cx, cy].btDoorIndex and $7F;
    for i := cx - 10 to cx + 10 do
      for j := cy - 10 to cy + 10 do begin
        if (i > 0) and (j > 0) then
          if (Map.m_MArr[i, j].btDoorIndex and $7F) = idx then
            Map.m_MArr[i, j].btDoorOffset := Map.m_MArr[i, j].btDoorOffset or $80;
      end;
  end;
end;

function TMap.CloseDoor(mx, my: Integer): Boolean;
var
  i, j, cx, cy, idx: Integer;
begin
  Result := FALSE;
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) or (cx > MAXX * 3) or (cy > MAXY * 3) then
    Exit;
  if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
    idx := Map.m_MArr[cx, cy].btDoorIndex and $7F;
    for i := cx - 8 to cx + 10 do
      for j := cy - 8 to cy + 10 do begin
        if (Map.m_MArr[i, j].btDoorIndex and $7F) = idx then
          Map.m_MArr[i, j].btDoorOffset := Map.m_MArr[i, j].btDoorOffset and $7F;
      end;
  end;
end;

end.
