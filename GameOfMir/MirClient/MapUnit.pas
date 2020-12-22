unit MapUnit;
//地图单元
{ MAP文件结构
    文件头：52字节
    第一行第一列定义
    第二行第一列定义
    第三行第一列定义
    。
    。
    。
    第Width行第一列定义
    第一行第二列定义
    。
    。
    。
}
interface

uses
  Windows, Classes, SysUtils, Grobal2, HUtil32, 
  MShare, Share, FindMapPath;

type
  // -------------------------------------------------------------------------------
  // Map
  // -------------------------------------------------------------------------------

  TMapInfoArr = array[0..MaxListSize] of TMapInfo;
  pTMapInfoArr = ^TMapInfoArr;

  TMap = class
  private
    //    function LoadMapInfo(sMapFile: string; var nWidth, nHeight: Integer): Boolean;
    procedure UpdateMapSeg(cx, cy: Integer); //, maxsegx, maxsegy: integer);
    procedure LoadMapArr(nCurrX, nCurrY: Integer);
    //    procedure SaveMapArr(nCurrX, nCurrY: Integer);
  public
//    m_sMapBase: string;
    m_boNewMap: Boolean;
    m_sFileName: string;
    m_MArr: array[0..MAXX * 3, 0..MAXY * 3] of TMapInfo;
    m_boChange: Boolean;
    m_ClientRect: TRect;
    m_OldClientRect: TRect;
    m_nBlockLeft: Integer;
    m_nBlockTop: Integer; //鸥老 谅钎肺 哭率, 怖措扁 谅钎
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
    destructor Destroy; override; //Jacky
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
  //GetMem (MInfoArr, sizeof(TMapInfo) * LOGICALMAPUNIT * 3 * LOGICALMAPUNIT * 3);
  m_ClientRect := Rect(0, 0, 0, 0);
  m_boChange := FALSE;
  //m_sMapBase := '.\Map\';
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
//读MAP文件的宽度和高度
{function TMap.LoadMapInfo(sMapFile: string; var nWidth, nHeight: Integer): Boolean;
var
  sFileName: string;
  nHandle: Integer;
  Header: TMapHeader;
begin
  Result := FALSE;
  sFileName := m_sMapBase + sMapFile;
  if FileExists(sFileName) then begin
    nHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if nHandle > 0 then begin
      FileRead(nHandle, Header, sizeof(TMapHeader));
      nWidth := Header.wWidth;
      nHeight := Header.wHeight;
    end;
    FileClose(nHandle);
  end;
end;         }

//segmented map 牢 版快

procedure TMap.UpdateMapSeg(cx, cy: Integer); //, maxsegx, maxsegy: integer);
begin

end;

//加载地图段数据
//以当前座标为准

procedure TMap.LoadMapArr(nCurrX, nCurrY: Integer);
var
  i: Integer;
  //  k: Integer;
//  nAline: Integer;
  nLx: Integer;
  nRx: Integer;
  nTy: Integer;
  nBy: Integer;
  //sFileName: string;
//  nHandle: Integer;
  Header: TMapHeader;
begin
  SafeFillChar(m_MArr, sizeof(m_MArr), #0);
  Header := g_LegendMap.MapHeader;
  nLx := (nCurrX - 1) * LOGICALMAPUNIT;
  nRx := (nCurrX + 2) * LOGICALMAPUNIT; //rx
  nTy := (nCurrY - 1) * LOGICALMAPUNIT;
  nBy := (nCurrY + 2) * LOGICALMAPUNIT;

  if nLx < 0 then nLx := 0;
  if nTy < 0 then nTy := 0;
  if nBy >= Header.wHeight then nBy := Header.wHeight;
  for i := nLx to nRx - 1 do begin
    if (i >= 0) and (i < Header.wWidth) then begin
      Move(g_LegendMap.MapData[Header.wHeight * i + nTy], m_MArr[i - nLx, 0], Sizeof(TMapInfo) * (nBy - nTy));
    end;
  end;
  m_boNewMap := g_LegendMap.boNewMap; 
end;

{procedure TMap.SaveMapArr(nCurrX, nCurrY: Integer);
var
  i: Integer;
//  k: Integer;
  nAline: Integer;
  nLx: Integer;
  nRx: Integer;
  nTy: Integer;
  nBy: Integer;
  sFileName: string;
  nHandle: Integer;
  Header: TMapHeader;
begin
  SafeFillChar(m_MArr, sizeof(m_MArr), #0);
  sFileName := m_sMapBase + m_sCurrentMap + '.map';
  if FileExists(sFileName) then begin
    nHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if nHandle > 0 then begin
      FileRead(nHandle, Header, sizeof(TMapHeader));
      nLx := (nCurrX - 1) * LOGICALMAPUNIT;
      nRx := (nCurrX + 2) * LOGICALMAPUNIT; //rx
      nTy := (nCurrY - 1) * LOGICALMAPUNIT;
      nBy := (nCurrY + 2) * LOGICALMAPUNIT;

      if nLx < 0 then nLx := 0;
      if nTy < 0 then nTy := 0;
      if nBy >= Header.wHeight then nBy := Header.wHeight;
      nAline := sizeof(TMapInfo) * Header.wHeight;
      for i := nLx to nRx - 1 do begin
        if (i >= 0) and (i < Header.wWidth) then begin
          FileSeek(nHandle, sizeof(TMapHeader) + (nAline * i) + (sizeof(TMapInfo) * nTy), 0);
          FileRead(nHandle, m_MArr[i - nLx, 0], sizeof(TMapInfo) * (nBy - nTy));
        end;
      end;
      FileClose(nHandle);
    end;
  end;
end;    }

procedure TMap.ReadyReload;
begin
  m_nCurUnitX := -1;
  m_nCurUnitY := -1;
end;

//cx, cy: 位置, 以LOGICALMAPUNIT为单位

procedure TMap.UpdateMapSquare(cx, cy: Integer);
begin
  if (cx <> m_nCurUnitX) or (cy <> m_nCurUnitY) then begin
    if m_boSegmented then
      UpdateMapSeg(cx, cy)
    else
      LoadMapArr(cx, cy);
    m_nCurUnitX := cx;
    m_nCurUnitY := cy;
  end;
end;

//林某腐捞 捞悼矫 后锅捞 龋免..

procedure TMap.UpdateMapPos(mx, my: Integer);//mx,my象素坐标
var
  cx, cy: Integer; //地图的逻辑坐标
begin
  cx := mx div LOGICALMAPUNIT; //折算成逻辑坐标
  cy := my div LOGICALMAPUNIT;
  m_nBlockLeft := _MAX(0, (cx - 1) * LOGICALMAPUNIT);//象素坐标
  m_nBlockTop := _MAX(0, (cy - 1) * LOGICALMAPUNIT);

  UpdateMapSquare(cx, cy);

  m_nOldLeft := m_nBlockLeft;
  m_nOldTop := m_nBlockTop;
end;

//甘函版矫 贸澜 茄锅 龋免..

procedure TMap.LoadMap(sMapName: string; nMx, nMy: Integer);
begin
  m_nCurUnitX := -1;
  m_nCurUnitY := -1;
  m_sCurrentMap := sMapName;
  m_boSegmented := FALSE; //Segmented 登绢 乐绰瘤 八荤茄促.
  UpdateMapPos(nMx, nMy);
  m_sOldMap := m_sCurrentMap;
end;
//置前景是否可以行走
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
  Result := FALSE; //jacky
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) or (cx > MAXX * 3) or (cy > MAXY * 3) then
    Exit;//前景和背景都可以走（最高位为0）
  Result := ((Map.m_MArr[cx, cy].wBkImg and $8000) + (Map.m_MArr[cx, cy].wFrImg and $8000)) = 0;
  if Result then begin //巩八荤
    if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin //巩娄捞 乐澜
      if (Map.m_MArr[cx, cy].btDoorOffset and $80) = 0 then
        Result := FALSE; //巩捞 救 凯啡澜.
    end;
  end;
end;

//若前景可以走，则返回真。
function TMap.CanFly(mx, my: Integer): Boolean;
var
  cx, cy: Integer;
begin
  Result := FALSE; //jacky
  cx := mx - m_nBlockLeft;
  cy := my - m_nBlockTop;
  if (cx < 0) or (cy < 0) or (cx > MAXX * 3) or (cy > MAXY * 3) then
    Exit;
  Result := (Map.m_MArr[cx, cy].wFrImg and $8000) = 0;
  if Result then begin //巩八荤
    if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin //巩娄捞 乐澜
      if (Map.m_MArr[cx, cy].btDoorOffset and $80) = 0 then
        Result := FALSE; //巩捞 救 凯啡澜.
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
