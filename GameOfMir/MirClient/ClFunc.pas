unit ClFunc;

interface

uses
  Windows, SysUtils, Classes, Graphics, Grobal2, HUtil32;

const
  DR_0 = 0;
  DR_1 = 1;
  DR_2 = 2;
  DR_3 = 3;
  DR_4 = 4;
  DR_5 = 5;
  DR_6 = 6;
  DR_7 = 7;
  DR_8 = 8;
  DR_9 = 9;
  DR_10 = 10;
  DR_11 = 11;
  DR_12 = 12;
  DR_13 = 13;
  DR_14 = 14;
  DR_15 = 15;

  //type
    { TDynamicObject = record  //官蹿俊 如利
        X: integer;  //某腐 谅钎拌
        Y: integer;
        px: integer;  //shiftx ,y
        py: integer;
        DSurface: TDirectDrawSurface;
     end;
     PTDynamicObject = ^TDynamicObject;     }

var
  DropItems: TList; //lsit of TClientItem

function fmStr(str: string; len: integer): string;
function GetGoldStr(gold: integer): string;
procedure ClearBag;
function AddNewItemToBagByIdx(wIdent, iindex: Integer): Boolean;
function AddItemStorage(cu: pTNewClientItem; nIdx, nGridIdx: Integer): pTNewClientItem;
function AddItemBag(cu: TNewClientItem; nIdx: Integer = -1): Boolean;
function AddItemBagByEx(cu: TNewClientItem): Boolean;
function AddItemBagOfDura(cu: TNewClientItem; nIdx: Integer = -1): Boolean;
function UpdateItemBag(cu: TNewClientItem): Boolean;
function UpdateItemBagByUserItem(cu: TUserItem): Boolean;
function UpdateItemBagByIdx(nIdx: Integer; cu: TNewClientItem): Boolean;
function DelItemBag(wIdent: Word; iindex: integer): Boolean;
function DelItemBagByIdxEx(nIdx: Integer; wIdent: Word; iindex: integer): Boolean;
function DelItemBagByIdx(nIdx: Integer): Boolean;
function DelItemBagByIdxOfDura(nIdx: Integer; nDura: Integer): Boolean;
function GetBagResidualCount(): Integer;
function GetBagItemCountByName(sName: string; nMax: Word): Word;
procedure ArrangeItemBag;
function GetItemBag(var cu: TNewClientItem; var nIdx: Integer): Boolean;
procedure ClearMovingItem();
procedure RefUserKeyItemInfo(CheckItem: pTNewClientItem);
function IsUserKeyItem(StdItem: pTStdItem): Boolean;
function GetBagItemIdx(wIndex: Integer): Integer;

procedure ArrangeItemBagEx;
procedure RecalcBagCount;
procedure AddDropItem(ci: TNewClientItem);
function GetDropItem(MakeIndex: integer): PTNewClientItem;
procedure DelDropItem(MakeIndex: integer);
procedure AddDealItem(ci: TNewClientItem);
procedure DelDealItem(ci: TNewClientItem);
procedure MoveDealItemToBag;
procedure AddDealRemoteItem(ci: TNewClientItem);
procedure DelDealRemoteItem(ci: TNewClientItem);
function GetDistance(sx, sy, dx, dy: integer): integer;
function CheckBeeline(nX, nY, sX, sY: Integer): Boolean;
procedure GetNextPosXY(dir: byte; var x, y: Integer);
procedure GetNextRunXY(dir: byte; var x, y: Integer);
procedure GetNextHorseRunXY(dir: byte; var x, y: Integer);
function GetNextDirection(sx, sy, dx, dy: Integer): byte;
function GetBack(dir: integer): integer;
procedure GetBackPosition(sx, sy, dir: integer; var newx, newy: integer);
procedure GetFrontPosition(sx, sy, dir: integer; var newx, newy: integer);
function GetFlyDirection(sx, sy, ttx, tty: integer): Integer;
function GetFlyDirection16(sx, sy, ttx, tty: integer): Integer;
function PrivDir(ndir: integer): integer;
function NextDir(ndir: integer): integer;
{procedure BoldTextOut(surface: TDirectDrawSurface; x, y, fcolor, bcolor:
  integer; str: string);
procedure BoldTextOutEx(surface: TDirectDrawSurface; x, y, fcolor, bcolor:
  integer; str: string);  }
function IsKeyPressed(key: byte): Boolean;

procedure AddChangeFace(recogid: integer);
procedure DelChangeFace(recogid: integer);
function IsChangingFace(recogid: integer): Boolean;

implementation
uses
  MShare, FState;

var
  ChrBuff: PChar;
//格式化字符串为指定长度（后面添空格）
function fmStr(str: string; len: integer): string;
var
  i: integer;
begin
  try
    Result := str + ' ';
    for i := 1 to len - Length(str) - 1 do
      Result := Result + ' ';
  except
    Result := str + ' ';
  end;
end;
//整数转换为千位带逗号的字符串，例如1234567转换为“1,234,567”
//这里用于显示金钱数量
function GetGoldStr(gold: integer): string;
var
  i, n: integer;
  str: string;
begin
  str := IntToStr(gold);
  n := 0;
  Result := '';
  for i := Length(str) downto 1 do begin
    if n = 3 then begin
      Result := str[i] + ',' + Result;
      n := 1;
    end
    else begin
      Result := str[i] + Result;
      Inc(n);
    end;
  end;
end;

//清除物品
procedure ClearBag;
begin
  SafeFillChar(g_ItemArr, SizeOf(g_ItemArr), #0);
  SafeFillChar(g_UserKeyIndex, SizeOf(g_UserKeyIndex), #0);
end;

function GetBagResidualCount(): Integer;
var
  i: integer;
  nItemCount: integer;
begin
  nItemCount := 0;
  for i := Low(g_ItemArr) to g_NonceBagCount - 1 do begin
    if (g_ItemArr[i].S.Name <> '') then Inc(nItemCount);
  end;
  Result := _MAX(0, g_NonceBagCount - nItemCount);
end;

function GetBagItemCountByName(sName: string; nMax: Word): Word;
var
  i, nCount: integer;
begin
  Result := 0;
  if (sName = '') or (nMax <= 0) then exit;
  nCount := 0;
  for i := Low(g_ItemArr) to High(g_ItemArr) do begin
    if (g_ItemArr[i].s.Name = sName)  then begin
      if (sm_Superposition in g_ItemArr[i].s.StdModeEx) and (g_ItemArr[i].s.DuraMax > 1) then begin
        Inc(nCount, g_ItemArr[i].UserItem.Dura);
      end else
        Inc(nCount);
    end;
    if nCount >= nMax then begin
      Result := nMax;
      exit;
    end;
  end;
  if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name = sName) then begin
    if (sm_Superposition in g_MovingItem.Item.s.StdModeEx) and (g_MovingItem.Item.s.DuraMax > 1) then begin
      Inc(nCount, g_MovingItem.Item.UserItem.Dura);
    end else
      Inc(nCount);
    if nCount >= nMax then begin
      Result := nMax;
      exit;
    end;
  end;
  Result := nCount;
end;

function GetItemBag(var cu: TNewClientItem; var nIdx: Integer): Boolean;
var
  i: integer;
begin
  Result := False;
  for i := Low(g_ItemArr) to High(g_ItemArr) do begin
    if (g_ItemArr[i].s.Name <> '') and (cu.UserItem.MakeIndex = g_ItemArr[i].UserItem.MakeIndex) and
      (cu.UserItem.wIndex = g_ItemArr[i].UserItem.wIndex) then begin
      cu := g_ItemArr[i];
      nIdx := i;
      Result := True;
      DelItemBagByIdx(i);
      break;
    end;
  end;
end;

procedure ClearMovingItem();
begin
  g_boItemMoving := False;
  g_MovingItem.Item.S.name := '';
end;

function IsUserKeyItem(StdItem: pTStdItem): Boolean;
begin
  Result := False;
  if (StdItem.StdMode2 = 0) or ((StdItem.StdMode2 = 3) and (StdItem.Shape < 13)) or
    ((StdItem.StdMode2 = 2) and (Pos('传送', StdItem.Name) > 0)) then begin
    Result := True;
  end;
end;

procedure RefUserKeyItemInfo(CheckItem: pTNewClientItem);
var
  i, ii: integer;
  StdItem: TStdItem;
  Item: TNewClientItem;
begin
  if CheckItem <> nil then begin
    Item := CheckItem^;
    if (Item.UserItem.wIndex > 0) and (Item.s.name = '') then
      Item.s := GetStdItem(Item.UserItem.wIndex);
    if IsUserKeyItem(@Item.s) then begin
      for I := Low(g_UserKeySetup) to High(g_UserKeySetup) do begin
        if (g_UserKeySetup[i].btType = UKTYPE_ITEM) and (g_UserKeySetup[i].wIndex = Item.UserItem.wIndex) then begin
          g_UserKeyIndex[i] := 0;
          StdItem := GetStdItem(g_UserKeySetup[i].wIndex);
          if (StdItem.Name <> '') and IsUserKeyItem(@StdItem) then begin
            for II := Low(g_ItemArr) to High(g_ItemArr) do begin
              if (g_ItemArr[ii].s.Name <> '') and (g_ItemArr[ii].s.Idx = StdItem.Idx) then begin
                if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
                  Inc(g_UserKeyIndex[i], g_ItemArr[ii].UserItem.Dura);
                end else
                if (StdItem.StdMode2 = 2) then begin
                  Inc(g_UserKeyIndex[i], g_ItemArr[ii].UserItem.Dura div 1000);
                end else
                  Inc(g_UserKeyIndex[i]);
              end;
            end;
          end else
            g_UserKeySetup[i].btType := 0;
          break;
        end;
      end;
    end;
  end else begin
    SafeFillChar(g_UserKeyIndex, SizeOf(g_UserKeyIndex), #0);
    for I := Low(g_UserKeySetup) to High(g_UserKeySetup) do begin
      if g_UserKeySetup[i].btType = 0 then Continue;
      for ii := I + 1 to High(g_UserKeySetup) do begin
        if (g_UserKeySetup[i].btType = g_UserKeySetup[ii].btType) and
           (g_UserKeySetup[i].wIndex = g_UserKeySetup[ii].wIndex) then begin
          g_UserKeySetup[i].btType := 0;
          g_UserKeySetup[i].wIndex := 0;
        end;
      end;
    end;
    for I := Low(g_UserKeySetup) to High(g_UserKeySetup) do begin
      if g_UserKeySetup[i].btType = UKTYPE_ITEM then begin
        StdItem := GetStdItem(g_UserKeySetup[i].wIndex);
        if (StdItem.Name <> '') and IsUserKeyItem(@StdItem) then begin
          for II := Low(g_ItemArr) to High(g_ItemArr) do begin
            if (g_ItemArr[ii].s.Name <> '') and (g_ItemArr[ii].s.Idx = StdItem.Idx) then begin
              {if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then
                Inc(g_UserKeyIndex[i], g_ItemArr[ii].UserItem.Dura)
              else
                Inc(g_UserKeyIndex[i]);  }
              if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
                Inc(g_UserKeyIndex[i], g_ItemArr[ii].UserItem.Dura);
              end else
              if (StdItem.StdMode2 = 2) then begin
                Inc(g_UserKeyIndex[i], g_ItemArr[ii].UserItem.Dura div 1000);
              end else
                Inc(g_UserKeyIndex[i]);
            end;
          end;
        end else
          g_UserKeySetup[i].btType := 0;
      end;
    end;
  end;
end;

function AddItemBagByEx(cu: TNewClientItem): Boolean;
{var
  i: integer; }
begin
  Result := False;
  {for i := Low(g_TempItemArr) to High(g_TempItemArr) do begin
    if (g_TempItemArr[i].s.Name <> '') and (cu.UserItem.MakeIndex = g_TempItemArr[i].UserItem.MakeIndex) and
      (cu.UserItem.wIndex = g_TempItemArr[i].UserItem.wIndex) then begin
      if I < g_NonceBagCount then begin
        AddItemBag(cu, i);
        Exit;
      end else
        break;
    end;
  end;        }
  AddItemBag(cu);
end;

function AddNewItemToBagByIdx(wIdent, iindex: Integer): Boolean;
var
  Item: TNewClientItem;
begin
  Fillchar(Item, SizeOf(Item), #0);
  Item.s := GetStditem(wIdent);
  Item.UserItem.MakeIndex := 0;
  Item.UserItem.wIndex := wIdent;
  Item.UserItem.DuraMax := Item.s.DuraMax;
  Item.UserItem.Dura := Item.s.DuraMax;
  Item.UserItem.MakeIndex := iindex;
  Result := AddItemBag(Item);
end;

function AddItemBag(cu: TNewClientItem; nIdx: Integer = -1): Boolean;
var
  i: integer;
  Idx: integer;
  AddCu: pTNewClientItem;
begin
  Result := FALSE;
  if cu.S.Name = '' then exit;
  Idx := nIdx;
  if (Idx <> -1) and (Idx in [Low(g_ItemArr)..High(g_ItemArr)]) and (g_ItemArr[Idx].S.Name = '') then begin
    g_ItemArr[Idx] := cu;
    Result := True;
    RefUserKeyItemInfo(@g_ItemArr[Idx]);
    exit;
  end else Idx := -1;
  AddCu := nil;
  if Idx = -1 then begin
    for i := Low(g_ItemArr) to High(g_ItemArr) do begin
      if g_ItemArr[i].S.Name = '' then begin
        if AddCu = nil then
          AddCu := @g_ItemArr[i];
      end else
      if (g_ItemArr[i].UserItem.MakeIndex = cu.UserItem.MakeIndex) and (g_ItemArr[i].S.Idx = cu.S.Idx) then begin
        exit;
      end;
    end;
    if g_boItemMoving and (g_MovingItem.ItemType = mtBagitem) and (g_MovingItem.Item.S.name <> '') and
        (g_MovingItem.Item.UserItem.MakeIndex = cu.UserItem.MakeIndex) and (g_MovingItem.Item.S.Idx = cu.S.Idx)
    then begin
      exit;
    end;
    if AddCu <> nil then begin
      AddCu^ := cu;
      Result := True;
      RefUserKeyItemInfo(AddCu);
    end;
  end;
  ArrangeItembag;
end;

function AddItemStorage(cu: pTNewClientItem; nIdx, nGridIdx: Integer): pTNewClientItem;
var
  i: integer;
begin
  Result := nil;
  if nGridIdx in [Low(g_StorageArr[nIdx])..High(g_StorageArr[nIdx])] then begin
    if g_StorageArr[nIdx][nGridIdx].s.Name = '' then begin
      g_StorageArr[nIdx][nGridIdx] := cu^;
      g_StorageArrList[nIdx].Add(@g_StorageArr[nIdx][nGridIdx]);
      exit;
    end;
  end;

  for i := Low(g_StorageArr[nIdx]) to High(g_StorageArr[nIdx]) do begin
    if g_StorageArr[nIdx][i].s.Name = '' then begin
      g_StorageArr[nIdx][i] := cu^;
      g_StorageArrList[nIdx].Add(@g_StorageArr[nIdx][i]);
      Break;
    end;
  end;
end;

function AddItemBagOfDura(cu: TNewClientItem; nIdx: Integer = -1): Boolean;
var
  i: integer;
  AddCu: pTNewClientItem;
  Idx: integer;
begin
  Result := False;
  if cu.S.Name = '' then exit;
  if (sm_Superposition in cu.s.StdModeEx) and (cu.s.DuraMax > 1) then begin
    Idx := nIdx;
    if (Idx <> -1) and (Idx in [Low(g_ItemArr)..High(g_ItemArr)]) and (g_ItemArr[Idx].S.Name <> '') and
      (g_ItemArr[Idx].UserItem.MakeIndex = cu.UserItem.MakeIndex) and (g_ItemArr[Idx].S.Idx = cu.S.Idx) then begin
      if (cu.UserItem.Dura + g_ItemArr[Idx].UserItem.Dura) > g_ItemArr[Idx].UserItem.DuraMax then
        g_ItemArr[Idx].UserItem.Dura := g_ItemArr[Idx].UserItem.DuraMax
      else
        Inc(g_ItemArr[Idx].UserItem.Dura, cu.UserItem.Dura);
      Result := True;
      RefUserKeyItemInfo(@g_ItemArr[Idx]);
      exit;
    end else Idx := -1;
    AddCu := nil;
    if Idx = -1 then begin
      for i := Low(g_ItemArr) to High(g_ItemArr) do begin
        if g_ItemArr[i].S.Name = '' then begin
          if AddCu = nil then
            AddCu := @g_ItemArr[i];
        end else
        if (g_ItemArr[i].UserItem.MakeIndex = cu.UserItem.MakeIndex) and (g_ItemArr[i].S.Idx = cu.S.Idx) then begin
          if (cu.UserItem.Dura + g_ItemArr[i].UserItem.Dura) > g_ItemArr[i].UserItem.DuraMax then
            g_ItemArr[i].UserItem.Dura := g_ItemArr[i].UserItem.DuraMax
          else
            Inc(g_ItemArr[i].UserItem.Dura, cu.UserItem.Dura);
          exit;
        end;
      end;
      if g_boItemMoving and (g_MovingItem.ItemType = mtBagitem) and (g_MovingItem.Item.S.name <> '') and
        (g_MovingItem.Item.UserItem.MakeIndex = cu.UserItem.MakeIndex) and (g_MovingItem.Item.S.Idx = cu.S.Idx)
      then begin
        if (cu.UserItem.Dura + g_MovingItem.Item.UserItem.Dura) > g_MovingItem.Item.UserItem.DuraMax then
          g_MovingItem.Item.UserItem.Dura := g_MovingItem.Item.UserItem.DuraMax
        else
          Inc(g_MovingItem.Item.UserItem.Dura, cu.UserItem.Dura);
        exit;
      end;
      if AddCu <> nil then begin
        AddCu^ := cu;
        Result := True;
        RefUserKeyItemInfo(AddCu);
      end;
    end;
    ArrangeItembag;
  end else begin
    AddItemBag(cu, nIdx);
  end;
end;

function UpdateItemBagByIdx(nIdx: Integer; cu: TNewClientItem): Boolean;
var
  i: integer;
begin
  Result := False;
  if nIdx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
    if (g_ItemArr[nIdx].S.Name <> '') and (g_ItemArr[nIdx].S.Idx = cu.S.Idx) and
      (g_ItemArr[nIdx].UserItem.MakeIndex = cu.UserItem.MakeIndex) then begin
      g_ItemArr[nIdx].S.Name := '';
      AddItemBag(cu, nIdx);
      Result := TRUE;
      exit;
    end;
  end;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[i].S.Name <> '') and (g_ItemArr[i].S.Idx = cu.S.Idx) and
      (g_ItemArr[i].UserItem.MakeIndex = cu.UserItem.MakeIndex) then begin
      g_ItemArr[i].S.Name := '';
      AddItemBag(cu, I);
      Result := TRUE;
      break;
    end;
  end;
  if g_boItemMoving and (g_MovingItem.ItemType = mtBagitem) and (g_MovingItem.Item.S.Idx = cu.S.Idx) and
    (g_MovingItem.Item.UserItem.MakeIndex = cu.UserItem.MakeIndex) and (g_MovingItem.Item.S.name <> '') then begin
    g_MovingItem.Item := cu;
    Result := TRUE;
  end;
end;

function UpdateItemBag(cu: TNewClientItem): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[i].S.Name <> '') and (g_ItemArr[i].S.Idx = cu.S.Idx) and
      (g_ItemArr[i].UserItem.MakeIndex = cu.UserItem.MakeIndex) then begin
      g_ItemArr[i].S.Name := '';
      AddItemBag(cu, I);
      Result := TRUE;
      break;
    end;
  end;
  if g_boItemMoving and (g_MovingItem.ItemType = mtBagitem) and (g_MovingItem.Item.S.Idx = cu.S.Idx) and
    (g_MovingItem.Item.UserItem.MakeIndex = cu.UserItem.MakeIndex) and (g_MovingItem.Item.S.name <> '') then begin
    g_MovingItem.Item := cu;
    Result := TRUE;
  end;
end;

function UpdateItemBagByUserItem(cu: TUserItem): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[i].S.Name <> '') and (g_ItemArr[i].UserItem.wIndex = cu.wIndex) and
      (g_ItemArr[i].UserItem.MakeIndex = cu.MakeIndex) then begin
      g_ItemArr[i].UserItem := cu;
      Result := TRUE;
      break;
    end;
  end;
  if g_boItemMoving and (g_MovingItem.ItemType = mtBagitem) and (g_MovingItem.Item.UserItem.wIndex = cu.wIndex) and
    (g_MovingItem.Item.UserItem.MakeIndex = cu.MakeIndex) and (g_MovingItem.Item.S.name <> '') then begin
    g_MovingItem.Item.UserItem := cu;
    Result := TRUE;
  end;
end;

function DelItemBagByIdx(nIdx: Integer): Boolean;
begin
  Result := False;
  if nIdx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
    g_ItemArr[nIdx].s.Name := '';
    RefUserKeyItemInfo(@g_ItemArr[nIdx]);
    //SafeFillChar(g_ItemArr[nIdx], sizeof(TNewClientItem), #0);
    Result := True;
  end;
end;

function GetBagItemIdx(wIndex: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[i].S.Name <> '') and (g_ItemArr[i].UserItem.wIndex = wIndex) then begin
      Result := i;
      break;
    end;
  end;
end;

function DelItemBagByIdxOfDura(nIdx: Integer; nDura: Integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[i].S.Name <> '') and (g_ItemArr[i].UserItem.MakeIndex = nIdx) then begin
      if (g_ItemArr[i].UserItem.Dura > nDura) and (sm_Superposition in g_ItemArr[i].s.StdModeEx) and (g_ItemArr[i].s.DuraMax > 1) then
        Dec(g_ItemArr[i].UserItem.Dura, nDura)
      else
        g_ItemArr[i].s.Name := '';
      Result := TRUE;
      RefUserKeyItemInfo(@g_ItemArr[i]);
    end;
  end;
  if g_boItemMoving and (g_MovingItem.ItemType = mtBagitem) and (g_MovingItem.Item.S.name <> '') and
    (g_MovingItem.Item.UserItem.MakeIndex = nIdx) then begin
    if (g_MovingItem.Item.UserItem.Dura > nDura)  and (sm_Superposition in g_MovingItem.Item.s.StdModeEx) and (g_MovingItem.Item.s.DuraMax > 1) then
      Dec(g_MovingItem.Item.UserItem.Dura, nDura)
    else begin
      ClearMovingItem();
    end;
    Result := TRUE;
  end;
  ArrangeItemBagEx;
end;

function DelItemBagByIdxEx(nIdx: Integer; wIdent: Word; iindex: integer): Boolean;
var
  i: integer;
begin
  Result := False;
  if nIdx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
    if (g_ItemArr[nIdx].s.Name <> '') and (g_ItemArr[nIdx].UserItem.MakeIndex = iindex) and
      (g_ItemArr[nIdx].UserItem.wIndex = wIdent) then begin
      g_ItemArr[nIdx].s.Name := '';
      RefUserKeyItemInfo(@g_ItemArr[nIdx]);
      Result := TRUE;
      exit;
    end;
  end;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[i].s.Name <> '') and (g_ItemArr[i].UserItem.MakeIndex = iindex) and
      (g_ItemArr[i].UserItem.wIndex = wIdent) then begin
      g_ItemArr[i].s.Name := '';
      RefUserKeyItemInfo(@g_ItemArr[i]);
      Result := TRUE;
      exit;
    end;
  end;
  if g_boItemMoving and (g_MovingItem.ItemType = mtBagitem) and (g_MovingItem.Item.S.name <> '') and
    (g_MovingItem.Item.UserItem.MakeIndex = iindex) and (g_MovingItem.Item.UserItem.wIndex = wIdent) then begin
    ClearMovingItem();
    exit;
  end;

end;

function DelItemBag(wIdent: Word; iindex: integer): Boolean;
var
  i: integer;
  ii, iii: integer;
begin
  Result := FALSE;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[i].s.Name <> '') and (g_ItemArr[i].UserItem.MakeIndex = iindex) and
      ((g_ItemArr[i].UserItem.wIndex = wIdent) or (wIdent < 1)) then begin
      g_ItemArr[i].s.Name := '';
      Result := TRUE;
      RefUserKeyItemInfo(@g_ItemArr[i]);
      ArrangeItemBagEx;
      exit;
    end;
  end;
  if g_boItemMoving and (g_MovingItem.ItemType = mtBagitem) and (g_MovingItem.Item.S.name <> '') and
    (g_MovingItem.Item.UserItem.MakeIndex = iindex) and ((g_MovingItem.Item.UserItem.wIndex = wIdent) or (wIdent < 1)) then begin
    ClearMovingItem();
    ArrangeItemBagEx;
    exit;
  end;
  for I := Low(g_UseItems) to High(g_UseItems) do begin
    if (g_UseItems[i].s.Name <> '') and (g_UseItems[i].UserItem.MakeIndex = iindex) and
      ((g_UseItems[i].UserItem.wIndex = wIdent) or (wIdent < 1)) then begin
      g_UseItems[i].s.Name := '';
      Result := True;
      ArrangeItemBagEx;
      exit;
    end;
  end;
  for i := Low(g_AddBagItems) to High(g_AddBagItems) do begin
    if (g_AddBagItems[i].s.Name <> '') and (g_AddBagItems[i].UserItem.MakeIndex = iindex) and
      ((g_AddBagItems[i].UserItem.wIndex = wIdent) or (wIdent < 1)) then begin
      g_AddBagItems[i].s.Name := '';
      Result := True;
      ArrangeItemBagEx;
      RecalcBagCount();
      FrmDlg.RefAddBagWindow();
      exit;
    end;
  end;

  for ii := Low(g_StorageArr) to High(g_StorageArr) do begin
    for I := Low(g_StorageArr[ii]) to High(g_StorageArr[ii]) do begin
      if (g_StorageArr[ii][i].s.Name <> '') and (g_StorageArr[ii][i].UserItem.MakeIndex = iindex) and
        ((g_StorageArr[ii][i].UserItem.wIndex = wIdent) or (wIdent < 1)) then begin
        for iii := 0 to g_StorageArrList[ii].Count - 1 do begin
          if (PTNewClientItem(g_StorageArrList[ii][iii]).UserItem.MakeIndex = iindex) and
            (PTNewClientItem(g_StorageArrList[ii][iii]).UserItem.wIndex = wIdent) then begin
            g_StorageArrList[ii].Delete(iii);
            break;
          end;
        end;
        g_StorageArr[ii][i].s.Name := '';
        ArrangeItemBagEx;
        exit;
      end;
    end;
  end;
end;

procedure RecalcBagCount;
var
  i: integer;
begin
  g_NonceBagCount := 45;
  for I := Low(g_AddBagItems) to High(g_AddBagItems) do begin
    if g_AddBagItems[i].s.Name <> '' then begin
      Inc(g_NonceBagCount, GetAppendBagCount(g_AddBagItems[i].s.Shape));
    end;
  end;
  ArrangeItemBagEx;
end;

procedure ArrangeItemBagEx;
var
  i: integer;
  TempList: TList;
begin
  TempList := TList.Create;
  for i := g_NonceBagCount to High(g_ItemArr) do begin
    if g_ItemArr[i].s.Name <> '' then
      TempList.Add(Pointer(i));
  end;
  if TempList.Count > 0 then
    for i := 0 to g_NonceBagCount do begin
      if TempList.Count <= 0 then break;
      if g_ItemArr[i].s.Name = '' then begin
        g_ItemArr[i] := g_ItemArr[Integer(TempList[0])];
        g_ItemArr[Integer(TempList[0])].s.name := '';
        TempList.Delete(0);
      end;
    end;
  TempList.Free;
end;

procedure ArrangeItemBag;
var
  i, k: integer;
begin
   //整理背包物品
  for i := Low(g_ItemArr) to High(g_ItemArr) do begin
    if g_ItemArr[i].S.Name <> '' then begin
      for k := i + 1 to High(g_ItemArr) do begin
        if (g_ItemArr[i].S.Idx = g_ItemArr[k].S.Idx) and (g_ItemArr[i].S.Name <> '') and
          (g_ItemArr[i].UserItem.MakeIndex = g_ItemArr[k].UserItem.MakeIndex) then begin
          DelItemBagByIdx(k);
        end;
      end;
      
      if g_boItemMoving and (g_ItemArr[i].S.Idx = g_MovingItem.Item.S.Idx) and (g_MovingItem.Item.S.name <> '') and
        (g_ItemArr[i].UserItem.MakeIndex = g_MovingItem.Item.UserItem.MakeIndex) then begin
        g_MovingItem.Index2 := 0;
        ClearMovingItem();
      end;
    end;
  end;
end;

{----------------------------------------------------------}
//添加跌落物品
procedure AddDropItem(ci: TNewClientItem);
var
  pc: PTNewClientItem;
begin
  new(pc);
  pc^ := ci;
  DropItems.Add(pc);
end;
//获取跌落物品
function GetDropItem(MakeIndex: integer): PTNewClientItem;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to DropItems.Count - 1 do begin
    if {(PTNewClientItem(DropItems[i]).S.Name = iname) and }
      (PTNewClientItem(DropItems[i]).UserItem.MakeIndex = MakeIndex) then begin
      Result := PTNewClientItem(DropItems[i]);
      break;
    end;
  end;
end;
//删除跌落物品
procedure DelDropItem(MakeIndex: integer);
var
  i: integer;
begin
  for i := 0 to DropItems.Count - 1 do begin
    if {(PTNewClientItem(DropItems[i]).S.Name = iname) and }
      (PTNewClientItem(DropItems[i]).UserItem.MakeIndex = MakeIndex) then begin
      Dispose(PTNewClientItem(DropItems[i]));
      DropItems.Delete(i);
      break;
    end;
  end;
end;

{----------------------------------------------------------}

procedure AddDealItem(ci: TNewClientItem);
var
  i: integer;
begin
  for i := Low(g_DealItems) to High(g_DealItems) do begin
    if g_DealItems[i].S.Name = '' then begin
      g_DealItems[i] := ci;
      break;
    end;
  end;
end;

procedure DelDealItem(ci: TNewClientItem);
var
  i: integer;
begin
  for i := Low(g_DealItems) to High(g_DealItems) do begin
    if (g_DealItems[i].S.Idx = ci.S.Idx) and (g_DealItems[i].UserItem.MakeIndex = ci.UserItem.MakeIndex) then begin
      SafeFillChar(g_DealItems[i], sizeof(TNewClientItem), #0);
      break;
    end;
  end;
end;

procedure MoveDealItemToBag;
var
  i: integer;
begin
  for i := Low(g_DealItems) to High(g_DealItems) do begin
    if g_DealItems[i].S.Name <> '' then
      AddItemBag(g_DealItems[i]);
  end;
  SafeFillChar(g_DealItems, sizeof(g_DealItems), #0);
end;

procedure AddDealRemoteItem(ci: TNewClientItem);
var
  i: integer;
begin
  for i := Low(g_DealRemoteItems) to High(g_DealRemoteItems) do begin
    if g_DealRemoteItems[i].S.Name = '' then begin
      g_DealRemoteItems[i] := ci;
      break;
    end;
  end;
end;

procedure DelDealRemoteItem(ci: TNewClientItem);
var
  i: integer;
begin
  for i := Low(g_DealRemoteItems) to High(g_DealRemoteItems) do begin
    if (g_DealRemoteItems[i].S.Idx = ci.S.Idx) and
      (g_DealRemoteItems[i].UserItem.MakeIndex = ci.UserItem.MakeIndex) then begin
      SafeFillChar(g_DealRemoteItems[i], sizeof(TNewClientItem), #0);
      break;
    end;
  end;
end;

{----------------------------------------------------------}
//计算两点间的距离（X或Y方向）
function GetDistance(sx, sy, dx, dy: integer): integer;
begin
  Result := _MAX(abs(sx - dx), abs(sy - dy));
end;
//根据方向和当前位置确定下一个位置坐标(位移量=1）
//检查是否在同一直线上

function CheckBeeline(nX, nY, sX, sY: Integer): Boolean;
begin
  Result := False;
  if nX = sX then
    Result := True;
  if nY = sY then
    Result := True;
  if abs(nX - sX) = abs(nY - sY) then
    Result := True;
end;

procedure GetNextPosXY(dir: byte; var x, y: Integer);
begin
  case dir of
    DR_UP: begin
        x := x;
        y := y - 1;
      end;
    DR_UPRIGHT: begin
        x := x + 1;
        y := y - 1;
      end;
    DR_RIGHT: begin
        x := x + 1;
        y := y;
      end;
    DR_DOWNRIGHT: begin
        x := x + 1;
        y := y + 1;
      end;
    DR_DOWN: begin
        x := x;
        y := y + 1;
      end;
    DR_DOWNLEFT: begin
        x := x - 1;
        y := y + 1;
      end;
    DR_LEFT: begin
        x := x - 1;
        y := y;
      end;
    DR_UPLEFT: begin
        x := x - 1;
        y := y - 1;
      end;
  end;
end;

//根据方向和当前位置确定下一个位置坐标(位移量=2）
procedure GetNextRunXY(dir: byte; var x, y: Integer);
begin
  case dir of
    DR_UP: begin
        x := x;
        y := y - 2;
      end;
    DR_UPRIGHT: begin
        x := x + 2;
        y := y - 2;
      end;
    DR_RIGHT: begin
        x := x + 2;
        y := y;
      end;
    DR_DOWNRIGHT: begin
        x := x + 2;
        y := y + 2;
      end;
    DR_DOWN: begin
        x := x;
        y := y + 2;
      end;
    DR_DOWNLEFT: begin
        x := x - 2;
        y := y + 2;
      end;
    DR_LEFT: begin
        x := x - 2;
        y := y;
      end;
    DR_UPLEFT: begin
        x := x - 2;
        y := y - 2;
      end;
  end;
end;

procedure GetNextHorseRunXY(dir: byte; var x, y: Integer);
begin
  case dir of
    DR_UP: begin
        x := x;
        y := y - 3;
      end;
    DR_UPRIGHT: begin
        x := x + 3;
        y := y - 3;
      end;
    DR_RIGHT: begin
        x := x + 3;
        y := y;
      end;
    DR_DOWNRIGHT: begin
        x := x + 3;
        y := y + 3;
      end;
    DR_DOWN: begin
        x := x;
        y := y + 3;
      end;
    DR_DOWNLEFT: begin
        x := x - 3;
        y := y + 3;
      end;
    DR_LEFT: begin
        x := x - 3;
        y := y;
      end;
    DR_UPLEFT: begin
        x := x - 3;
        y := y - 3;
      end;
  end;
end;

//根据两点计算移动的方向
function GetNextDirection(sx, sy, dx, dy: Integer): byte;
var
  flagx, flagy: integer;
begin
  Result := DR_DOWN;
  if sx < dx then
    flagx := 1
  else if sx = dx then
    flagx := 0
  else
    flagx := -1;
  if abs(sy - dy) > 2 then
    if (sx >= dx - 1) and (sx <= dx + 1) then
      flagx := 0;

  if sy < dy then
    flagy := 1
  else if sy = dy then
    flagy := 0
  else
    flagy := -1;
  if abs(sx - dx) > 2 then
    if (sy > dy - 1) and (sy <= dy + 1) then
      flagy := 0;

  if (flagx = 0) and (flagy = -1) then
    Result := DR_UP;
  if (flagx = 1) and (flagy = -1) then
    Result := DR_UPRIGHT;
  if (flagx = 1) and (flagy = 0) then
    Result := DR_RIGHT;
  if (flagx = 1) and (flagy = 1) then
    Result := DR_DOWNRIGHT;
  if (flagx = 0) and (flagy = 1) then
    Result := DR_DOWN;
  if (flagx = -1) and (flagy = 1) then
    Result := DR_DOWNLEFT;
  if (flagx = -1) and (flagy = 0) then
    Result := DR_LEFT;
  if (flagx = -1) and (flagy = -1) then
    Result := DR_UPLEFT;
end;
//根据当前方向获得转身后的方向
function GetBack(dir: integer): integer;
begin
  Result := DR_UP;
  case dir of
    DR_UP: Result := DR_DOWN;
    DR_DOWN: Result := DR_UP;
    DR_LEFT: Result := DR_RIGHT;
    DR_RIGHT: Result := DR_LEFT;
    DR_UPLEFT: Result := DR_DOWNRIGHT;
    DR_UPRIGHT: Result := DR_DOWNLEFT;
    DR_DOWNLEFT: Result := DR_UPRIGHT;
    DR_DOWNRIGHT: Result := DR_UPLEFT;
  end;
end;
//根据当前坐标和方向获得后退的坐标
procedure GetBackPosition(sx, sy, dir: integer; var newx, newy: integer);
begin
  newx := sx;
  newy := sy;
  case dir of
    DR_UP: newy := newy + 1;
    DR_DOWN: newy := newy - 1;
    DR_LEFT: newx := newx + 1;
    DR_RIGHT: newx := newx - 1;
    DR_UPLEFT: begin
        newx := newx + 1;
        newy := newy + 1;
      end;
    DR_UPRIGHT: begin
        newx := newx - 1;
        newy := newy + 1;
      end;
    DR_DOWNLEFT: begin
        newx := newx + 1;
        newy := newy - 1;
      end;
    DR_DOWNRIGHT: begin
        newx := newx - 1;
        newy := newy - 1;
      end;
  end;
end;
//根据当前位置和方向获得前进一步的坐标
procedure GetFrontPosition(sx, sy, dir: integer; var newx, newy: integer);
begin
  newx := sx;
  newy := sy;
  case dir of
    DR_UP: newy := newy - 1;
    DR_DOWN: newy := newy + 1;
    DR_LEFT: newx := newx - 1;
    DR_RIGHT: newx := newx + 1;
    DR_UPLEFT: begin
        newx := newx - 1;
        newy := newy - 1;
      end;
    DR_UPRIGHT: begin
        newx := newx + 1;
        newy := newy - 1;
      end;
    DR_DOWNLEFT: begin
        newx := newx - 1;
        newy := newy + 1;
      end;
    DR_DOWNRIGHT: begin
        newx := newx + 1;
        newy := newy + 1;
      end;
  end;
end;
//根据两点位置获得飞行方向（8个方向）
function GetFlyDirection(sx, sy, ttx, tty: integer): Integer;
var
  fx, fy: Real;
begin
  fx := ttx - sx;
  fy := tty - sy;
  //   sx := 0;
  //   sy := 0;
  Result := DR_DOWN;
  if fx = 0 then begin//两点的X坐标相等
    if fy < 0 then
      Result := DR_UP
    else
      Result := DR_DOWN;
    exit;
  end;
  if fy = 0 then begin  //两点的Y坐标相等
    if fx < 0 then
      Result := DR_LEFT
    else
      Result := DR_RIGHT;
    exit;
  end;
  if (fx > 0) and (fy < 0) then begin
    if - fy > fx * 2.5 then
      Result := DR_UP
    else if - fy < fx / 3 then
      Result := DR_RIGHT
    else
      Result := DR_UPRIGHT;
  end;
  if (fx > 0) and (fy > 0) then begin
    if fy < fx / 3 then
      Result := DR_RIGHT
    else if fy > fx * 2.5 then
      Result := DR_DOWN
    else
      Result := DR_DOWNRIGHT;
  end;
  if (fx < 0) and (fy > 0) then begin
    if fy < -fx / 3 then
      Result := DR_LEFT
    else if fy > -fx * 2.5 then
      Result := DR_DOWN
    else
      Result := DR_DOWNLEFT;
  end;
  if (fx < 0) and (fy < 0) then begin
    if - fy > -fx * 2.5 then
      Result := DR_UP
    else if - fy < -fx / 3 then
      Result := DR_LEFT
    else
      Result := DR_UPLEFT;
  end;
end;
//根据两点位置获得飞行方向(16个方向)
function GetFlyDirection16(sx, sy, ttx, tty: integer): Integer;
var
  fx, fy: Real;
begin
  fx := ttx - sx;
  fy := tty - sy;
  //   sx := 0;
  //   sy := 0;
  Result := 0;
  if fx = 0 then begin
    if fy < 0 then
      Result := 0
    else
      Result := 8;
    exit;
  end;
  if fy = 0 then begin
    if fx < 0 then
      Result := 12
    else
      Result := 4;
    exit;
  end;
  if (fx > 0) and (fy < 0) then begin
    Result := 4;
    if - fy > fx / 4 then
      Result := 3;
    if - fy > fx / 1.9 then
      Result := 2;
    if - fy > fx * 1.4 then
      Result := 1;
    if - fy > fx * 4 then
      Result := 0;
  end;
  if (fx > 0) and (fy > 0) then begin
    Result := 4;
    if fy > fx / 4 then
      Result := 5;
    if fy > fx / 1.9 then
      Result := 6;
    if fy > fx * 1.4 then
      Result := 7;
    if fy > fx * 4 then
      Result := 8;
  end;
  if (fx < 0) and (fy > 0) then begin
    Result := 12;
    if fy > -fx / 4 then
      Result := 11;
    if fy > -fx / 1.9 then
      Result := 10;
    if fy > -fx * 1.4 then
      Result := 9;
    if fy > -fx * 4 then
      Result := 8;
  end;
  if (fx < 0) and (fy < 0) then begin
    Result := 12;
    if - fy > -fx / 4 then
      Result := 13;
    if - fy > -fx / 1.9 then
      Result := 14;
    if - fy > -fx * 1.4 then
      Result := 15;
    if - fy > -fx * 4 then
      Result := 0;
  end;
end;
//按逆时针转动一个方向后的方向
function PrivDir(ndir: integer): integer;
begin
  if ndir - 1 < 0 then
    Result := 7
  else
    Result := ndir - 1;
end;
//按顺时针转动一个方向后的方向
function NextDir(ndir: integer): integer;
begin
  if ndir + 1 > 7 then
    Result := 0
  else
    Result := ndir + 1;
end;
 {
procedure BoldTextOutEx(surface: TDirectDrawSurface; x, y, fcolor, bcolor:
  integer; str: string);
var
  nLen: Integer;
begin
  if str = '' then Exit;
  with surface do begin
    nLen := Length(str);
    Move(str[1], ChrBuff^, nlen);
    Canvas.Font.Color := bcolor;
    TextOut(Canvas.Handle, x, y - 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x, y + 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x - 1, y, ChrBuff, nlen);
    TextOut(Canvas.Handle, x + 1, y, ChrBuff, nlen);
    TextOut(Canvas.Handle, x - 1, y - 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x + 1, y + 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x - 1, y + 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x + 1, y - 1, ChrBuff, nlen);
    Canvas.Font.Color := fcolor;
    TextOut(Canvas.Handle, x, y, ChrBuff, nlen);
  end;
end;

procedure BoldTextOut(surface: TDirectDrawSurface; x, y, fcolor, bcolor:
  integer; str: string);
var
  nLen: Integer;
begin
  if str = '' then Exit;
  with surface do begin
    nLen := Length(str);
    Move(str[1], ChrBuff^, nlen);
    Canvas.Font.Color := bcolor;
    TextOut(Canvas.Handle, x - 1, y, ChrBuff, nlen);
    TextOut(Canvas.Handle, x + 1, y, ChrBuff, nlen);
    TextOut(Canvas.Handle, x, y - 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x, y + 1, ChrBuff, nlen);
    Canvas.Font.Color := fcolor;
    TextOut(Canvas.Handle, x, y, ChrBuff, nlen);
  end;
end;     }

//判断某个键是否按下
function IsKeyPressed(key: byte): Boolean;
var
  keyvalue: TKeyBoardState;
begin
  Result := FALSE;
  SafeFillChar(keyvalue, sizeof(TKeyboardState), #0);
  if GetKeyboardState(keyvalue) then
    if (keyvalue[key] and $80) <> 0 then
      Result := TRUE;
end;

procedure AddChangeFace(recogid: integer);
begin
  g_ChangeFaceReadyList.Add(pointer(recogid));
end;

procedure DelChangeFace(recogid: integer);
var
  i: integer;
begin
  for i := 0 to g_ChangeFaceReadyList.Count - 1 do begin
    if integer(g_ChangeFaceReadyList[i]) = recogid then begin
      g_ChangeFaceReadyList.Delete(i);
      break;
    end;
  end;
end;

function IsChangingFace(recogid: integer): Boolean;
var
  i: integer;
begin
  Result := FALSE;
  for i := 0 to g_ChangeFaceReadyList.Count - 1 do begin
    if integer(g_ChangeFaceReadyList[i]) = recogid then begin
      Result := TRUE;
      break;
    end;
  end;
end;

initialization
  begin
    DropItems := TList.Create;
    GetMem(ChrBuff, 2048);
  end;

finalization
  begin
    DropItems.Free;
    FreeMem(ChrBuff);
  end;

end.

