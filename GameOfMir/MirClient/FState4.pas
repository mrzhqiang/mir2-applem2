unit FState4;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, HGE, MNShare,   
  MShare, HGEGUI, WIL, HGETextures, Grobal2, Grids, Share, WMFile;

type
  TFrmDlg4 = class(TForm)
    DTopMsg: TDWindow;
    DWndItemRemove: TDWindow;
    DItemRemoveClose: TDButton;
    DItemRemoveArm: TDButton;
    DItemRemoveClose2: TDButton;
    DItemRemoveItems: TDGrid;
    DWndMagicKey: TDWindow;
    DMagicKeyF1: TDButton;
    DMagicKeyF2: TDButton;
    DMagicKeyF3: TDButton;
    DMagicKeyF4: TDButton;
    DMagicKeyF5: TDButton;
    DMagicKeyF6: TDButton;
    DMagicKeyF7: TDButton;
    DMagicKeyF8: TDButton;
    DMagicKeyF9: TDButton;
    DMagicKeyF10: TDButton;
    DMagicKeyF11: TDButton;
    DMagicKeyF12: TDButton;
    DMagicKeyF13: TDButton;
    DMagicKeyF14: TDButton;
    DMagicKeyF15: TDButton;
    DMagicKeyF16: TDButton;
    DMagicKeyNone: TDButton;
    DMagicKeyClose: TDButton;
    DWndArmAbilityMove: TDWindow;
    DAbilityMoveItemSrc: TDButton;
    DAbilityMoveItemDes: TDButton;
    DAbilityMoveRateItems: TDGrid;
    DStartAbilityMove: TDButton;
    DCloseAbilityMove: TDButton;
    DWndCompound: TDWindow;
    DCompoundItem1: TDButton;
    DCompoundItem2: TDButton;
    DCompoundItem3: TDButton;
    DCompoundItem4: TDButton;
    DCompoundItem0: TDButton;
    DStartCompound: TDButton;
    DCloseCompound: TDButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DTopMsgInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
    procedure DTopMsgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopMsgVisible(Sender: TObject; boVisible: Boolean);
    procedure DItemRemoveCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DItemRemoveCloseClickSound(Sender: TObject; Clicksound: TClickSound);
    procedure DItemRemoveCloseClick(Sender: TObject; X, Y: Integer);
    procedure DWndItemRemoveDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWndItemRemoveVisible(Sender: TObject; boVisible: Boolean);
    procedure DItemRemoveArmDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DItemRemoveArmClick(Sender: TObject; X, Y: Integer);
    procedure DItemRemoveArmMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DItemRemoveItemsGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
    procedure DItemRemoveItemsGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DItemRemoveItemsGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DWndMagicKeyDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMagicKeyF1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMagicKeyF1Click(Sender: TObject; X, Y: Integer);
    procedure DMagicKeyCloseClick(Sender: TObject; X, Y: Integer);
    procedure DAbilityMoveItemSrcClick(Sender: TObject; X, Y: Integer);
    procedure DStartAbilityMoveDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DCloseAbilityMoveClick(Sender: TObject; X, Y: Integer);
    procedure DWndArmAbilityMoveVisible(Sender: TObject; boVisible: Boolean);
    procedure DAbilityMoveItemDesClick(Sender: TObject; X, Y: Integer);
    procedure DAbilityMoveItemSrcDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DAbilityMoveItemDesDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DAbilityMoveItemSrcMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DAbilityMoveItemDesMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DAbilityMoveRateItemsGridMouseMove(Sender: TObject; X, Y, ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DAbilityMoveRateItemsGridSelect(Sender: TObject; X, Y, ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DAbilityMoveRateItemsGridPaint(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
    procedure DStartAbilityMoveClick(Sender: TObject; X, Y: Integer);
    procedure DWndArmAbilityMoveDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DCompoundItemClick(Sender: TObject; X, Y: Integer);
    procedure DCompoundItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DCompoundItemMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DCloseCompoundClick(Sender: TObject; X, Y: Integer);
    procedure DWndCompoundVisible(Sender: TObject; boVisible: Boolean);
    procedure DStartCompoundClick(Sender: TObject; X, Y: Integer);
    procedure DWndCompoundDirectPaint(Sender: TObject; dsurface: TDXTexture);
  private
    FAbilityMoveLock: Boolean;
    FAbilityMoveItemSrc, FAbilityMoveItemDes: TMovingItem;
    FAbilityMoveRateItems: array [0 .. 4] of TMovingItem;
    FAbilityMoveItems: array [0 .. 1] of TUserItem;
    FAbilityMoveShowTick: LongWord;
    FAbilityMoveShowSchedule, FAbilityMoveShowEffect: Boolean;
    FAbilityMoveShowSchedulePos: Integer;
    FAbilityMoveRate, FAbilityMoveResult: Byte;

    FCompoundLock: Boolean;
    FCompoundItems: array [0 .. 4] of TMovingItem;
    FCompoundUserItem: TUserItem;
    FCompoundShowTick: LongWord;
    FCompoundShowSchedule, FCompoundShowEffect: Boolean;
    FCompoundShowSchedulePos: Integer;
    FCompoundResult: Byte;
  public
    FRemoveStoneLock: Boolean;
    FRemoveStoneItem: TMovingItem;
    FRemoveStoneShowEffect: Boolean;
    FRemoveStoneShowEffectIdx: Integer;
    FRemoveStoneIndex: Integer;
    FRemoveStoneIdx: Byte;
    FMagicKeyIndex: Byte;
    FMagidID: Integer;

    m_TopMsgList: TStringList;
    procedure Initialize;
    procedure InitializeEx();
    function CanItemRemoveStoneAdd(Item: pTNewClientItem): Boolean;
    procedure ItemRemoveStoneAdd(nItemIndex: Integer);

    function CanArmAbilityMoveAdd(Item: pTNewClientItem): Boolean;
    procedure ArmAbilityMoveAdd(nItemIndex: Integer);
    procedure ClearAbilityMoveInfo();
    procedure RefAbilityMoveRate();
    procedure ClientAbilityMoveItems(nResult: Integer; sMsg: string);

    function CanCompoundItemAdd(Item: pTNewClientItem): Boolean;
    function CanCompoundItemAddEx(Item: pTNewClientItem; boFirst: Boolean): Boolean;
    procedure CompoundItemAdd(nItemIndex: Integer);
    procedure ClearCompoundItemInfo(boClick: Boolean);
    procedure ClientCompoundItem(nResult: Integer; sMsg: string);
  end;

var
  FrmDlg4: TFrmDlg4;

implementation

uses
  SoundUtil, ClMain, DrawScrn, ClFunc, HUtil32, FState, HGEBase, cliUtil, EDcodeEx,
  FState2;

{$R *.dfm}

function TFrmDlg4.CanItemRemoveStoneAdd(Item: pTNewClientItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  if FRemoveStoneLock or g_boItemMoving then exit;
  if sm_ArmingStrong in Item.s.StdModeEx then begin
    for I := 0 to Item.UserItem.Value.btFluteCount - 1 do begin
      if Item.UserItem.Value.wFlute[I] > 0 then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

procedure TFrmDlg4.DItemRemoveArmClick(Sender: TObject; X, Y: Integer);
var
  I: Integer;
begin
  if FRemoveStoneLock then exit;
  if not g_boItemMoving then begin
    if FRemoveStoneItem.Item.s.Name <> '' then
      AddItemBag(FRemoveStoneItem.Item, FRemoveStoneItem.Index2);
    SafeFillChar(FRemoveStoneItem, SizeOf(FRemoveStoneItem), #0);
  end
  else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
    if sm_ArmingStrong in g_MovingItem.Item.s.StdModeEx then begin
      if g_MovingItem.Item.UserItem.Value.btFluteCount > 0 then begin
        for I := 0 to g_MovingItem.Item.UserItem.Value.btFluteCount - 1 do begin
          if g_MovingItem.Item.UserItem.Value.wFlute[I] > 0 then begin
            if FRemoveStoneItem.Item.s.Name <> '' then
              AddItemBag(FRemoveStoneItem.Item, FRemoveStoneItem.Index2);
            FRemoveStoneItem := g_MovingItem;
            g_boItemMoving := False;
            g_MovingItem.Item.s.Name := '';
            Exit;
          end;
        end;
        FrmDlg.CancelItemMoving;
        FrmDlg.DMessageDlg('该件装备没有可以卸下的宝石.', []);
      end else begin
        FrmDlg.CancelItemMoving;
        FrmDlg.DMessageDlg('该件装备没有凹槽.', []);
      end;
    end
    else begin
      FrmDlg.CancelItemMoving;
    end;
  end;
end;

procedure TFrmDlg4.DItemRemoveArmDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay{, px, py}: integer;
  pRect: TRect;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if FRemoveStoneItem.Item.s.Name <> '' then begin
      d := GetBagItemImg(FRemoveStoneItem.Item.S.looks);
      pRect.Left := ax;
      pRect.Top := ay;
      pRect.Right := ax + Width + 1;
      pRect.Bottom := ay + Height;
      if d <> nil then
        FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
          ax + (Width - d.Width) div 2,
          ay + (Height - d.Height) div 2,
          Width,
          Height,
          @FRemoveStoneItem.Item, False, [pmShowLevel], @pRect);
    end;{
    else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
      if (sm_ArmingStrong in g_MovingItem.Item.s.StdModeEx) and
        CheckByteStatus(g_MovingItem.Item.UserItem.btBindMode2, Ib2_Unknown) then begin
        d := g_WMain3Images.Images[600 + (gettickcount - AppendTick) div 200 mod 2];
        if d <> nil then
          DrawBlend(dsurface, SurfaceX(Left) - 12, SurfaceY(Top) - 11, d, 1);
      end;
    end;
    if FUnsealShowEffect then begin
      if GetTickCount >= FUnSealShowTick then begin
        FUnSealShowTick := GetTickCount + 80;
        Inc(FUnsealShowIndex);
      end;
      d := g_WMain99Images.GetCachedImage(1188 + FUnsealShowIndex, px, py);
      if d <> nil then
        dsurface.Draw(ax + px - 113, ay + py - 113, d.ClientRect, d, True);

      if FUnsealShowIndex >= 29 then begin
        FUnsealLock := False;
        FUnsealShowEffect := False;
      end;
    end;  }
  end;
end;

procedure TFrmDlg4.DItemRemoveArmMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
begin
  with Sender as TDButton do begin
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX + 30;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    if FRemoveStoneItem.Item.s.Name <> '' then
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(FRemoveStoneItem.Item, [mis_ArmStrengthen], []),
        clwhite, False, Tag, True);
  end;
end;

procedure TFrmDlg4.DItemRemoveCloseClick(Sender: TObject; X, Y: Integer);
begin
  if FRemoveStoneLock then exit;
  DWndItemRemove.Visible := False;
end;

procedure TFrmDlg4.DItemRemoveCloseClickSound(Sender: TObject; Clicksound: TClickSound);
begin
  case Clicksound of
    csNorm: PlaySound(s_norm_button_click);
    csStone: PlaySound(s_rock_button_click);
    csGlass: PlaySound(s_glass_button_click);
  end;
end;

procedure TFrmDlg4.DItemRemoveCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
{$IF Var_Interface = Var_Default}
  idx: integer;
{$IFEND}
begin
{$IF Var_Interface = Var_Mir2}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end;
    end;
  end;
{$ELSE}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if Downed then begin
        inc(idx, 2)
      end
      else if MouseEntry = msIn then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
{$IFEND}
end;

procedure TFrmDlg4.DItemRemoveItemsGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  Item: TNewClientItem;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx >= FRemoveStoneItem.Item.UserItem.Value.btFluteCount then Exit;
    if idx in [Low(FRemoveStoneItem.Item.UserItem.Value.wFlute)..High(FRemoveStoneItem.Item.UserItem.Value.wFlute)] then begin
      if (FRemoveStoneItem.Item.S.name <> '') and (FRemoveStoneItem.Item.UserItem.Value.wFlute[idx] > 0) then begin
        Fillchar(Item, SizeOf(Item), #0);
        Item.s := GetStditem(FRemoveStoneItem.Item.UserItem.Value.wFlute[idx]);
        Item.UserItem.MakeIndex := 0;
        Item.UserItem.wIndex := FRemoveStoneItem.Item.UserItem.Value.wFlute[idx];

        DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(Item, [], []), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg4.DItemRemoveItemsGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
  Item: TNewClientItem;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx >= FRemoveStoneItem.Item.UserItem.Value.btFluteCount then Exit;
    if idx in [Low(FRemoveStoneItem.Item.UserItem.Value.wFlute)..High(FRemoveStoneItem.Item.UserItem.Value.wFlute)] then begin
      if (FRemoveStoneItem.Item.S.name <> '') and (FRemoveStoneItem.Item.UserItem.Value.wFlute[idx] > 0) then begin

        Fillchar(Item, SizeOf(Item), #0);
        Item.s := GetStditem(FRemoveStoneItem.Item.UserItem.Value.wFlute[idx]);
        Item.UserItem.MakeIndex := 0;
        Item.UserItem.wIndex := FRemoveStoneItem.Item.UserItem.Value.wFlute[idx];
        if Item.S.Name <> '' then begin
          d := GetBagItemImg(Item.S.looks);
          if d <> nil then begin
            FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
              SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
              SurfaceX(Rect.Right),
              SurfaceY(Rect.Bottom) - 12,
              @Item);
          end;
        end;

        if FRemoveStoneShowEffect and (idx = FRemoveStoneIdx) then begin
          if (GetTickCount - DItemRemoveItems.AppendTick) > 54 then begin
            DItemRemoveItems.AppendTick := GetTickCount;
            Inc(FRemoveStoneShowEffectIdx);
            if FRemoveStoneShowEffectIdx >= 25 then begin
              FRemoveStoneShowEffect := False;
              DelItemBag(g_SendRemoveStoneItem.UserItem.wIndex, g_SendRemoveStoneItem.UserItem.MakeIndex);
              AddNewItemToBagByIdx(FRemoveStoneItem.Item.UserItem.Value.wFlute[FRemoveStoneIdx], FRemoveStoneIndex);
              FRemoveStoneItem.Item.UserItem.Value.wFlute[FRemoveStoneIdx] := 0;
              FRemoveStoneLock := False;
              g_SendRemoveStoneItem.s.name := '';
            end;
          end;
          d := g_WMain99Images.Images[1459 + FRemoveStoneShowEffectIdx mod 7];
          if d <> nil then begin
            dsurface.Draw(SurfaceX(Rect.Left) + 1, SurfaceY(Rect.Top) + 1, d.ClientRect, d, True);
          end;
        end;
      end; { else
      if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
        if (tm_MakeStone = g_MovingItem.Item.s.StdMode) and (g_MovingItem.Item.s.Shape in [1, 2]) then begin
          d := g_WMain3Images.Images[600 + (gettickcount - AppendTick) div 200 mod 2];
          if d <> nil then
            DrawBlend(dsurface, SurfaceX(Rect.Left) - 11, SurfaceY(Rect.Top) - 11, d, 1);
        end;
      end; }
    end;
  end;
end;

procedure TFrmDlg4.DItemRemoveItemsGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  if FRemoveStoneLock then exit;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx >= FRemoveStoneItem.Item.UserItem.Value.btFluteCount then Exit;
    if idx in [Low(FRemoveStoneItem.Item.UserItem.Value.wFlute)..High(FRemoveStoneItem.Item.UserItem.Value.wFlute)] then begin
      if not g_boItemMoving then begin
        if (FRemoveStoneItem.Item.S.name <> '') and (FRemoveStoneItem.Item.UserItem.Value.wFlute[idx] > 0) then begin
          if (g_CursorMode = cr_Srepair) and (g_RemoveStoneItem.s.Name <> '') and (g_SendRemoveStoneItem.s.name = '') then begin
            g_SendRemoveStoneItem := g_RemoveStoneItem;
            FRemoveStoneLock := True;
            FrmMain.SendClientMessage(CM_REMOVESTONE, g_RemoveStoneItem.UserItem.MakeIndex,
              LoWord(FRemoveStoneItem.Item.UserItem.MakeIndex),
              HiWord(FRemoveStoneItem.Item.UserItem.MakeIndex), idx, '');
            {g_CursorMode := cr_None;
            Cursor := crMyNone; }

          end else
            FrmDlg.DMessageDlg('请先使用卸下宝石的道具.', []);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg4.DMagicKeyCloseClick(Sender: TObject; X, Y: Integer);
var
  I: Integer;
begin
  if FMagicKeyIndex > 0 then begin

    for I := Low(g_MyMagicArry) to High(g_MyMagicArry) do
      if g_MyMagicArry[I].btKey = FMagicKeyIndex then begin
        g_MyMagicArry[I].btKey := 0;
        FrmMain.SendClientMessage(CM_SETMAGICKEY, I, 0, 0, 0, '');
      end;
  end;
      
  g_MyMagicArry[FMagidID].btKey := FMagicKeyIndex;
  FrmMain.SendClientMessage(CM_SETMAGICKEY, FMagidID, FMagicKeyIndex, 0, 0, '');
  DWndMagicKey.Visible := False;
end;

procedure TFrmDlg4.DMagicKeyF1Click(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    FMagicKeyIndex := Tag;
  end;
end;

procedure TFrmDlg4.DMagicKeyF1DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      d := nil;
      if FMagicKeyIndex = Tag then begin
        d := WLib.Images[FaceIndex + 1];
      end else
      if Downed then begin
        d := WLib.Images[FaceIndex];
      end;
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg4.DTopMsgDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay: integer;
  nParam: Integer;
  wFontWidth: Word;
  wIndex: Word;
  nLeft: Integer;
  WideStr: WideString;
  I: Integer;
  tStr, AddStr, cmdstr, sbcolor, sfcolor: string;
  boBeginColor: Boolean;
  nFColor, nBColor: TColor;
begin
  with Sender as TDWindow do begin
    if Surface = nil then Exit;

    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    g_DXCanvas.FillRect(ax, ay, Width, Height, $99080808);
    if m_TopMsgList.Count > 0 then begin
      WideStr := m_TopMsgList[0];
      nParam := Integer(m_TopMsgList.Objects[0]);
      if nParam = 0 then begin
        wFontWidth := g_DXCanvas.TextWidth(m_TopMsgList[0]) + 4 + Width;
        wIndex := 0;
        AppendTick := 0;
      end else begin
        wFontWidth := LoWord(nParam);
        wIndex := HiWord(nParam);
      end;
      if GetTickCount > AppendTick then begin
        AppendTick := GetTickCount + 20;
        Surface.Clear;
        Inc(wIndex);
        if wIndex > (wFontWidth * 2) then begin
          m_TopMsgList.Delete(0);
          Exit;
        end;
        m_TopMsgList.Objects[0] := TObject(MakeLong(wFontWidth, wIndex));
        nLeft := Width - (wIndex mod wFontWidth);
        boBeginColor := False;
        AddStr := '';
        cmdstr := '';
        nFColor := $CCFFFF;
        nBColor := 0;

        for I := 1 to Length(WideStr) do begin
          tStr := WideStr[i];
          if boBeginColor then begin
            if tstr = #6 then begin
              boBeginColor := False;
              sbcolor := GetValidStr3(cmdstr, sfcolor, ['/']);
              nFColor := StrToIntDef('$' + sfcolor, $CCFFFF);
              nBColor := StrToIntDef('$' + sbcolor, 0);
              cmdstr := '';
            end else cmdstr := cmdstr + tstr;
          end else begin
            if tstr = #6 then begin
              boBeginColor := True;
              Surface.TextOutEx(nLeft, 2, AddStr, nFColor, nBColor);
              Inc(nLeft, g_DXCanvas.TextWidth(AddStr));
              AddStr := '';
              cmdstr := '';
            end else
            if tstr = #5 then begin
              Surface.TextOutEx(nLeft, 2, AddStr, nFColor, nBColor);
              Inc(nLeft, g_DXCanvas.TextWidth(AddStr));
              AddStr := '';
              cmdstr := '';
              nFColor := $CCFFFF;
              nBColor := 0;
            end else AddStr := AddStr + tstr;
          end;
        end;
        if AddStr <> '' then begin
          Surface.TextOutEx(nLeft, 2, AddStr, nFColor, nBColor);
        end;
      end;
      dsurface.Draw(ax, ay, Surface.ClientRect, Surface, fxBlend);
    end else Visible := False;
  end;

end;

procedure TFrmDlg4.DTopMsgInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
begin
  IsRealArea := False;
end;

procedure TFrmDlg4.DTopMsgVisible(Sender: TObject; boVisible: Boolean);
begin
  DTopMsg.Surface.Clear;
end;

procedure TFrmDlg4.DWndItemRemoveDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);

{$IF Var_Interface = Var_Default}
    with g_DXCanvas do begin
      TextOut(ax + Width div 2 - TextWidth(Caption) div 2, ay + 12, $B1D2B7, Caption);
    end;
{$IFEND}
    {DItemUnsealClose2.Enabled := not FUnsealLock;
    DItemUnsealOK.Enabled := (FUnsealItem.Item.s.Name <> '') and (not FUnsealLock) and
      CheckByteStatus(FUnsealItem.Item.UserItem.btBindMode2, Ib2_Unknown);  }
    {FUnsealLock := True;
    FUnsealShowEffect := True;
    FUnsealShowIndex := 0;
    FUnSealShowTick := GetTickCount; }
  end;
end;

procedure TFrmDlg4.DWndItemRemoveVisible(Sender: TObject; boVisible: Boolean);
begin
  if FRemoveStoneItem.Item.s.Name <> '' then
    AddItemBag(FRemoveStoneItem.Item, FRemoveStoneItem.Index2);
  FRemoveStoneItem.Item.s.Name := '';
  g_SendRemoveStoneItem.s.Name := '';
  FRemoveStoneLock := False;
  FRemoveStoneShowEffect := False;
  FrmDlg.LastestClickTime := GetTickCount;
  if boVisible then begin
    FrmDlg.boOpenItemBag := FrmDlg.DItemBag.Visible;
    FrmDlg.DItemBag.Visible := True;
    FrmDlg.DMerchantDlg.Visible := False;
  end
  else begin
    FrmDlg.DItemBag.Visible := FrmDlg.boOpenItemBag;
    //FrmDlg.DMerchantDlg.Visible := FrmDlg.MDlgVisible;
  end;
end;

procedure TFrmDlg4.DWndMagicKeyDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  Magic: TClientDefMagic;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    Magic := GetMagicInfo(FMagidID);
    if Magic.Magic.sMagicName <> '' then begin
    
      if Magic.Magic.wMagicIcon > 30000 then d := g_WMagIconImages.Images[Magic.Magic.wMagicIcon - 30000]
      else if Magic.Magic.wMagicIcon > 20000 then d := g_WDefMagIcon2Images.Images[Magic.Magic.wMagicIcon - 20000]
      else if Magic.Magic.wMagicIcon > 10000 then d := g_WDefMagIconImages.Images[Magic.Magic.wMagicIcon - 10000]
      else d := GetDefMagicIcon(@Magic);
      
      if d <> nil then begin
        dsurface.Draw(ax + 49, ay + 29, d.ClientRect, d, False);
      end;
    end;
  end;
end;

procedure TFrmDlg4.FormCreate(Sender: TObject);
begin
  m_TopMsgList := TStringList.Create;
  FMagicKeyIndex := 0;
  FMagidID := 0;
end;

procedure TFrmDlg4.FormDestroy(Sender: TObject);
begin
  m_TopMsgList.Free;
end;

procedure TFrmDlg4.Initialize;
var
  d: TDirectDrawSurface;
  i: Integer;
  dcon: TDControl;
begin
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TDWindow) or (Components[i] is TDPopUpMemu) then begin
      dcon := TDControl(Components[i]);
      if dcon.DParent = nil then begin
        dcon.DParent := FrmDlg.DBackground;
        FrmDlg.DBackground.AddChild(dcon);
      end;
    end;
  end;

  //顶部公告
{$IF Var_Interface = Var_Mir2}
  DTopMsg.Left := 260;
  DTopMsg.Top := 0;
  DTopMsg.Width := 280 + (g_FScreenWidth - OLD_SCREEN_WIDTH);
  DTopMsg.Height := 16;
{$ELSE}
  DTopMsg.Left := 224 + g_FScreenXOrigin - OLD_SCREEN_WIDTH div 2;
  DTopMsg.Top := 37;
  DTopMsg.Width := 280;
  DTopMsg.Height := 16;
{$IFEND}


  //装备宝石取下
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1706];
  if d <> nil then begin
    DWndItemRemove.SetImgIndex(g_WMain99Images, 1706);
    DWndItemRemove.Left := 0;
    DWndItemRemove.Top := 60;
  end;
  DItemRemoveClose.SetImgIndex(g_WMain99Images, 1850);
  DItemRemoveClose.Left := 262;
  DItemRemoveClose.Top := 24;

  DItemRemoveArm.Top := 36;
  DItemRemoveArm.Left := 130;
  DItemRemoveArm.Width := 33;
  DItemRemoveArm.Height := 31;

  DItemRemoveItems.Top := 173;
  DItemRemoveItems.Left := 57;
  DItemRemoveItems.Width := 179;
  DItemRemoveItems.Height := 31;
  DItemRemoveItems.ColWidth := 33;
  DItemRemoveItems.Coloffset := 40;
  DItemRemoveItems.RowHeight := 31;

  DItemRemoveClose2.SetImgIndex(g_WMain99Images, 1711);
  DItemRemoveClose2.Left := 111;
  DItemRemoveClose2.Top := 224;
  DItemRemoveClose2.OnDirectPaint := DItemRemoveCloseDirectPaint;
{$ELSE}
  d := g_WMain99Images.Images[1458];
  if d <> nil then begin
    DWndItemRemove.SetImgIndex(g_WMain99Images, 1458);
    DWndItemRemove.Left := 0;
    DWndItemRemove.Top := 90;
  end;
  DItemRemoveClose.SetImgIndex(g_WMain99Images, 133);
  DItemRemoveClose.Left := DWndItemRemove.Width - 20;
  DItemRemoveClose.Top := 8 + 4;

  DItemRemoveArm.Top := 62;
  DItemRemoveArm.Left := 135;
  DItemRemoveArm.Width := 36;
  DItemRemoveArm.Height := 36;

  DItemRemoveItems.Top := 198;
  DItemRemoveItems.Left := 55;
  DItemRemoveItems.Width := 196;
  DItemRemoveItems.Height := 36;

  DItemRemoveClose2.SetImgIndex(g_WMain99Images, 156);
  DItemRemoveClose2.Left := (DWndItemRemove.Width - DItemRemoveClose2.Width) div 2;
  DItemRemoveClose2.Top := 288;  
{$IFEND}

//装备属性转移
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[2233];
  if d <> nil then begin
    DWndArmAbilityMove.SetImgIndex(g_WMain99Images, 2233);
    DWndArmAbilityMove.Left := 0;
    DWndArmAbilityMove.Top := 60;
  end;

  DAbilityMoveItemSrc.Left := 70;
  DAbilityMoveItemSrc.Top := 36;
  DAbilityMoveItemSrc.Width := 33;
  DAbilityMoveItemSrc.Height := 31;

  DAbilityMoveItemDes.Left := 193;
  DAbilityMoveItemDes.Top := 36;
  DAbilityMoveItemDes.Width := 33;
  DAbilityMoveItemDes.Height := 31;

  DAbilityMoveRateItems.Top := 167;
  DAbilityMoveRateItems.Left := 29;
  DAbilityMoveRateItems.Width := 233;
  DAbilityMoveRateItems.Height := 31;
  DAbilityMoveRateItems.ColCount := 5;
  DAbilityMoveRateItems.ColWidth := 33;
  DAbilityMoveRateItems.Coloffset := 17;
  DAbilityMoveRateItems.RowHeight := 31;

  DStartAbilityMove.SetImgIndex(g_WMain99Images, 2234);
  DStartAbilityMove.Left := 111;
  DStartAbilityMove.Top := 263;

  DCloseAbilityMove.SetImgIndex(g_WMain99Images, 1850);
  DCloseAbilityMove.Left := 262;
  DCloseAbilityMove.Top := 24;
{$ELSE}
  d := g_WMain99Images.Images[738];
  if d <> nil then begin
    DWndArmAbilityMove.SetImgIndex(g_WMain99Images, 738);
    DWndArmAbilityMove.Left := 0;
    DWndArmAbilityMove.Top := 90;
  end;

  DAbilityMoveItemSrc.Left := 75;
  DAbilityMoveItemSrc.Top := 65;
  DAbilityMoveItemSrc.Width := 33;
  DAbilityMoveItemSrc.Height := 31;

  DAbilityMoveItemDes.Left := 197;
  DAbilityMoveItemDes.Top := 65;
  DAbilityMoveItemDes.Width := 33;
  DAbilityMoveItemDes.Height := 31;

  DAbilityMoveRateItems.Top := 192;
  DAbilityMoveRateItems.Left := 36;
  DAbilityMoveRateItems.Width := 365;
  DAbilityMoveRateItems.Height := 31;
  DAbilityMoveRateItems.ColCount := 5;
  DAbilityMoveRateItems.ColWidth := 33;
  DAbilityMoveRateItems.Coloffset := 17;
  DAbilityMoveRateItems.RowHeight := 31;

  DStartAbilityMove.SetImgIndex(g_WMain99Images, 156);
  DStartAbilityMove.Left := (DWndArmAbilityMove.Width - DStartAbilityMove.Width) div 2;
  DStartAbilityMove.Top := 308;  
  DStartAbilityMove.OnDirectPaint := nil;

  DCloseAbilityMove.Caption := '';
  DCloseAbilityMove.SetImgIndex(g_WMain99Images, 133);
  DCloseAbilityMove.Left := DWndArmAbilityMove.Width - 20;
  DCloseAbilityMove.Top := 8 + 4;
  DCloseAbilityMove.OnDirectPaint := nil;
{$IFEND}

//道具合成
{$IF Var_Interface = Var_Mir2}
  d := g_WMain99Images.Images[1812];
  if d <> nil then begin
    DWndCompound.SetImgIndex(g_WMain99Images, 1812);
    DWndCompound.Left := 400;
    DWndCompound.Top := 0;
  end;

  DCompoundItem0.Left := 123;
  DCompoundItem0.Top := 194;
  DCompoundItem0.Width := 33;
  DCompoundItem0.Height := 31;

  DCompoundItem1.Left := 49;
  DCompoundItem1.Top := 162;
  DCompoundItem1.Width := 33;
  DCompoundItem1.Height := 31;

  DCompoundItem2.Left := 197;
  DCompoundItem2.Top := 162;
  DCompoundItem2.Width := 33;
  DCompoundItem2.Height := 31;

  DCompoundItem3.Left := 49;
  DCompoundItem3.Top := 225;
  DCompoundItem3.Width := 33;
  DCompoundItem3.Height := 31;

  DCompoundItem4.Left := 197;
  DCompoundItem4.Top := 225;
  DCompoundItem4.Width := 33;
  DCompoundItem4.Height := 31;

  DCloseCompound.SetImgIndex(g_WMain99Images, 1850);
  DCloseCompound.Left := 259;
  DCloseCompound.Top := 5;

  DStartCompound.SetImgIndex(g_WMain99Images, 1650);
  DStartCompound.Left := 100;
  DStartCompound.Top := 246;
  DStartCompound.OnDirectPaint := FrmDlg2.DEMailReadDirectPaint;
{$ELSE}
  d := g_WMain99Images.Images[2130];
  if d <> nil then begin
    DWndCompound.SetImgIndex(g_WMain99Images, 2130);
    DWndCompound.Left := 0;
    DWndCompound.Top := 90;
  end;

  DCompoundItem0.Left := 128;
  DCompoundItem0.Top := 226;
  DCompoundItem0.Width := 33;
  DCompoundItem0.Height := 31;

  DCompoundItem1.Left := 56;
  DCompoundItem1.Top := 197;
  DCompoundItem1.Width := 33;
  DCompoundItem1.Height := 31;

  DCompoundItem2.Left := 199;
  DCompoundItem2.Top := 197;
  DCompoundItem2.Width := 33;
  DCompoundItem2.Height := 31;

  DCompoundItem3.Left := 56;
  DCompoundItem3.Top := 255;
  DCompoundItem3.Width := 33;
  DCompoundItem3.Height := 31;

  DCompoundItem4.Left := 199;
  DCompoundItem4.Top := 255;
  DCompoundItem4.Width := 33;
  DCompoundItem4.Height := 31;

  DCloseCompound.Caption := '';
  DCloseCompound.SetImgIndex(g_WMain99Images, 133);
  DCloseCompound.Left := DWndCompound.Width - 20;
  DCloseCompound.Top := 8 + 4;
  DCloseCompound.OnDirectPaint := nil;

  DStartCompound.SetImgIndex(g_WMain99Images, 156);
  DStartCompound.Left := (DWndCompound.Width - DStartCompound.Width) div 2;
  DStartCompound.Top := 340;  
  DStartCompound.OnDirectPaint := nil;
{$IFEND}

  //技能快捷键

  d := g_WMain99Images.Images[2074];
  if d <> nil then begin
    DWndMagicKey.SetImgIndex(g_WMain99Images, 2074);
    DWndMagicKey.Left := g_FScreenXOrigin - d.Width div 2;
    DWndMagicKey.Top := g_FScreenYOrigin - d.Height div 2;
  end;

  DMagicKeyF1.SetImgIndex(g_WMain99Images, 1970);
  DMagicKeyF1.Left := 25;
  DMagicKeyF1.Top := 78;
  DMagicKeyF2.SetImgIndex(g_WMain99Images, 1972);
  DMagicKeyF2.Left := 57;
  DMagicKeyF2.Top := 78;
  DMagicKeyF3.SetImgIndex(g_WMain99Images, 1974);
  DMagicKeyF3.Left := 89;
  DMagicKeyF3.Top := 78;
  DMagicKeyF4.SetImgIndex(g_WMain99Images, 1976);
  DMagicKeyF4.Left := 121;
  DMagicKeyF4.Top := 78;

  DMagicKeyF5.SetImgIndex(g_WMain99Images, 1978);
  DMagicKeyF5.Left := 160;
  DMagicKeyF5.Top := 78;
  DMagicKeyF6.SetImgIndex(g_WMain99Images, 1980);
  DMagicKeyF6.Left := 192;
  DMagicKeyF6.Top := 78;
  DMagicKeyF7.SetImgIndex(g_WMain99Images, 1982);
  DMagicKeyF7.Left := 224;
  DMagicKeyF7.Top := 78;
  DMagicKeyF8.SetImgIndex(g_WMain99Images, 1984);
  DMagicKeyF8.Left := 256;
  DMagicKeyF8.Top := 78;

  DMagicKeyF9.SetImgIndex(g_WMain99Images, 2080);
  DMagicKeyF9.Left := 25;
  DMagicKeyF9.Top := 120;
  DMagicKeyF10.SetImgIndex(g_WMain99Images, 2082);
  DMagicKeyF10.Left := 57;
  DMagicKeyF10.Top := 120;
  DMagicKeyF11.SetImgIndex(g_WMain99Images, 2084);
  DMagicKeyF11.Left := 89;
  DMagicKeyF11.Top := 120;
  DMagicKeyF12.SetImgIndex(g_WMain99Images, 2086);
  DMagicKeyF12.Left := 121;
  DMagicKeyF12.Top := 120;

  DMagicKeyF13.SetImgIndex(g_WMain99Images, 2088);
  DMagicKeyF13.Left := 160;
  DMagicKeyF13.Top := 120;
  DMagicKeyF14.SetImgIndex(g_WMain99Images, 2090);
  DMagicKeyF14.Left := 192;
  DMagicKeyF14.Top := 120;
  DMagicKeyF15.SetImgIndex(g_WMain99Images, 2092);
  DMagicKeyF15.Left := 224;
  DMagicKeyF15.Top := 120;
  DMagicKeyF16.SetImgIndex(g_WMain99Images, 2094);
  DMagicKeyF16.Left := 256;
  DMagicKeyF16.Top := 120;

  DMagicKeyNone.SetImgIndex(g_WMain99Images, 2077);
  DMagicKeyNone.Left := 296;
  DMagicKeyNone.Top := 78;

  DMagicKeyClose.SetImgIndex(g_WMain99Images, 2075);
  DMagicKeyClose.Left := 295;
  DMagicKeyClose.Top := 118;
end;

procedure TFrmDlg4.InitializeEx;
begin
  DTopMsg.CreateSurface(nil);
end;

procedure TFrmDlg4.ItemRemoveStoneAdd(nItemIndex: Integer);
var
  I: Integer;
begin
  if FRemoveStoneLock or g_boItemMoving then exit;
  if g_ItemArr[nItemIndex].UserItem.Value.btFluteCount > 0 then begin
    for I := 0 to g_ItemArr[nItemIndex].UserItem.Value.btFluteCount - 1 do begin
      if g_ItemArr[nItemIndex].UserItem.Value.wFlute[I] > 0 then begin
        g_boItemMoving := True;
        g_MovingItem.Index2 := nItemIndex;
        g_MovingItem.Item := g_ItemArr[nItemIndex];
        g_MovingItem.ItemType := mtBagItem;
        DelItemBagByIdx(nItemIndex);
        ItemClickSound(g_ItemArr[nItemIndex].S);
        DItemRemoveArmClick(DItemRemoveArm, 0, 0);
        Exit;
      end;
    end;
  end;
end;

function TFrmDlg4.CanArmAbilityMoveAdd(Item: pTNewClientItem): Boolean;
begin
  Result := False;
  if FAbilityMoveLock or g_boItemMoving then exit;
  if (sm_ArmingStrong in Item.s.StdModeEx) then
    Result := True;
  if (tm_MakeStone = Item.s.StdMode) and (Item.s.Shape in [4]) then
    Result := True;
end;

procedure TFrmDlg4.ArmAbilityMoveAdd(nItemIndex: Integer);
var
  Item: pTNewClientItem;
  I: Integer;
begin
  if FAbilityMoveLock or g_boItemMoving then exit;
  Item := @g_ItemArr[nItemIndex];
  if (sm_ArmingStrong in Item.s.StdModeEx) then begin
    g_boItemMoving := True;
    g_MovingItem.Index2 := nItemIndex;
    g_MovingItem.Item := g_ItemArr[nItemIndex];
    g_MovingItem.ItemType := mtBagItem;
    DelItemBagByIdx(nItemIndex);
    ItemClickSound(g_ItemArr[nItemIndex].S);
    if (FAbilityMoveItemSrc.Item.s.Name = '') then
      DAbilityMoveItemSrcClick(DAbilityMoveItemSrc, 0, 0)
    else if (FAbilityMoveItemDes.Item.s.Name = '') then
      DAbilityMoveItemDesClick(DAbilityMoveItemDes, 0, 0);
  end else
  if (tm_MakeStone = Item.s.StdMode) and (Item.s.Shape = 4) then begin
    for I := Low(FAbilityMoveRateItems) to High(FAbilityMoveRateItems) do begin
      if FAbilityMoveRateItems[i].Item.s.Name = '' then begin
        g_boItemMoving := True;
        g_MovingItem.Index2 := nItemIndex;
        g_MovingItem.Item := g_ItemArr[nItemIndex];
        g_MovingItem.ItemType := mtBagItem;
        DelItemBagByIdx(nItemIndex);
        ItemClickSound(g_ItemArr[nItemIndex].S);
        DAbilityMoveRateItemsGridSelect(DAbilityMoveRateItems, 0, 0, I, 0, []);
        break;
      end;
    end;
  end;
end;

procedure TFrmDlg4.DAbilityMoveItemSrcClick(Sender: TObject; X, Y: Integer);
var
  tmp: TMovingItem;
begin
  if FAbilityMoveLock then
    exit;
  if not g_boItemMoving then begin
    if FAbilityMoveItemSrc.Item.s.Name <> '' then
      AddItemBag(FAbilityMoveItemSrc.Item, FAbilityMoveItemSrc.Index2);
    SafeFillChar(FAbilityMoveItemSrc, SizeOf(FAbilityMoveItemSrc), #0);
  end
  else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
    if sm_ArmingStrong in g_MovingItem.Item.s.StdModeEx then begin
      if (not CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoMake)) then begin
        if not CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_Unknown) then begin
          tmp := FAbilityMoveItemSrc;
          FAbilityMoveItemSrc := g_MovingItem;
          g_MovingItem := tmp;
          g_boItemMoving := (g_MovingItem.Item.s.Name <> '');
        end
        else begin
          FrmDlg.CancelItemMoving;
          FrmDlg.DMessageDlg('未开光装备不允许进行属性转移.', []);
        end;
      end
      else begin
        FrmDlg.CancelItemMoving;
        FrmDlg.DMessageDlg('该装备不可以进行属性转移.', []);
      end;
    end
    else begin
      FrmDlg.CancelItemMoving;
    end;
  end;
end;

procedure TFrmDlg4.DAbilityMoveItemDesClick(Sender: TObject; X, Y: Integer);
var
  tmp: TMovingItem;
begin
  if FAbilityMoveLock then
    exit;
  if not g_boItemMoving then begin
    if FAbilityMoveItemDes.Item.s.Name <> '' then
      AddItemBag(FAbilityMoveItemDes.Item, FAbilityMoveItemDes.Index2);
    SafeFillChar(FAbilityMoveItemDes, SizeOf(FAbilityMoveItemDes), #0);
  end
  else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
    if sm_ArmingStrong in g_MovingItem.Item.s.StdModeEx then begin
      if (not CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoMake)) then begin
        if not CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_Unknown) then begin
          tmp := FAbilityMoveItemDes;
          FAbilityMoveItemDes := g_MovingItem;
          g_MovingItem := tmp;
          g_boItemMoving := (g_MovingItem.Item.s.Name <> '');
        end
        else begin
          FrmDlg.CancelItemMoving;
          FrmDlg.DMessageDlg('未开光装备不允许进行属性转移.', []);
        end;
      end
      else begin
        FrmDlg.CancelItemMoving;
        FrmDlg.DMessageDlg('该装备不可以进行属性转移.', []);
      end;
    end
    else begin
      FrmDlg.CancelItemMoving;
    end;
  end;
end;

procedure TFrmDlg4.DAbilityMoveItemSrcDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  pRect: TRect;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if (FAbilityMoveItemSrc.Item.s.Name <> '') then begin
      d := GetBagItemImg(FAbilityMoveItemSrc.Item.S.looks);
      pRect.Left := ax;
      pRect.Top := ay;
      pRect.Right := ax + Width + 1;
      pRect.Bottom := ay + Height;
      if d <> nil then
        FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
          ax + (Width - d.Width) div 2,
          ay + (Height - d.Height) div 2,
          Width,
          Height,
          @FAbilityMoveItemSrc.Item, False, [pmShowLevel], @pRect);
    end;
    if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
      if ((FAbilityMoveItemSrc.Item.s.Name = '') or (FAbilityMoveItemDes.Item.s.Name <> '')) and (sm_ArmingStrong in g_MovingItem.Item.s.StdModeEx) then begin
        d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
        if d <> nil then
          DrawBlend(dsurface, SurfaceX(Left) - 13, SurfaceY(Top) - 14, d, 1);
      end;
    end;
  end;
end;

procedure TFrmDlg4.DAbilityMoveItemSrcMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
begin
  with Sender as TDButton do begin
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY;
    if FAbilityMoveItemSrc.Item.s.Name <> '' then
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(FAbilityMoveItemSrc.Item, [mis_ArmStrengthen], []),
        clwhite, False, Tag, True);
  end;
end;

procedure TFrmDlg4.DAbilityMoveRateItemsGridMouseMove(Sender: TObject; X, Y,
  ACol, ARow: Integer; Shift: TShiftState);
var
  nHintX, nHintY: Integer;
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FAbilityMoveRateItems)..High(FAbilityMoveRateItems)] then begin
      nHintX := SurfaceX(Left) + (ColWidth + ColOffset) * idx + ColWidth ;
      nHintY := SurfaceY(Top) + RowHeight;
      if FAbilityMoveRateItems[idx].Item.s.Name <> '' then
        DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(FAbilityMoveRateItems[idx].Item, [mis_ArmStrengthen], []),
          clwhite, False, Tag, True);
    end;
  end;
end;

procedure TFrmDlg4.DAbilityMoveRateItemsGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FAbilityMoveRateItems)..High(FAbilityMoveRateItems)] then begin
      if FAbilityMoveRateItems[idx].Item.S.name <> '' then begin
        d := GetBagItemImg(FAbilityMoveRateItems[idx].Item.S.looks);
        if d <> nil then begin
          FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @FAbilityMoveRateItems[idx].Item);
        end;
      end
      else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
        if (tm_MakeStone = g_MovingItem.Item.s.StdMode) and (g_MovingItem.Item.s.Shape in [4]) then begin
          d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
          if d <> nil then
            DrawBlend(dsurface, SurfaceX(Rect.Left) - 13, SurfaceY(Rect.Top) - 14, d, 1);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg4.DAbilityMoveRateItemsGridSelect(Sender: TObject; X, Y, ACol,
  ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  tmp: TMovingItem;
begin
  if FAbilityMoveLock then
    exit;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount;
    if idx in [Low(FAbilityMoveRateItems)..High(FAbilityMoveRateItems)] then begin
      if not g_boItemMoving then begin
        if FAbilityMoveRateItems[idx].Item.s.Name <> '' then begin
          AddItemBag(FAbilityMoveRateItems[idx].Item, FAbilityMoveRateItems[idx].Index2);
          SafeFillChar(FAbilityMoveRateItems[idx], SizeOf(FAbilityMoveRateItems[idx]), #0);
          //RefStrengthenRateInfo();
        end;
      end
      else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
        if (tm_MakeStone = g_MovingItem.Item.s.StdMode) and (g_MovingItem.Item.s.Shape in [4]) then begin
          tmp := FAbilityMoveRateItems[idx];
          FAbilityMoveRateItems[idx] := g_MovingItem;
          g_MovingItem := tmp;
          g_boItemMoving := (g_MovingItem.Item.s.Name <> '');
          //RefStrengthenRateInfo();
        end;
      end;
    end;
  end;
  RefAbilityMoveRate();
end;

procedure TFrmDlg4.DAbilityMoveItemDesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
begin
  with Sender as TDButton do begin
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY;
    if FAbilityMoveItemDes.Item.s.Name <> '' then
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(FAbilityMoveItemDes.Item, [mis_ArmStrengthen], []),
        clwhite, False, Tag, True);
  end;
end;

procedure TFrmDlg4.DAbilityMoveItemDesDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  pRect: TRect;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if FAbilityMoveItemDes.Item.s.Name <> '' then begin
      d := GetBagItemImg(FAbilityMoveItemDes.Item.S.looks);
      pRect.Left := ax;
      pRect.Top := ay;
      pRect.Right := ax + Width + 1;
      pRect.Bottom := ay + Height;
      if d <> nil then
        FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
          ax + (Width - d.Width) div 2,
          ay + (Height - d.Height) div 2,
          Width,
          Height,
          @FAbilityMoveItemDes.Item, False, [pmShowLevel], @pRect);
    end;
    if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
      if ((FAbilityMoveItemDes.Item.s.Name = '') or (FAbilityMoveItemSrc.Item.s.Name <> '')) and (sm_ArmingStrong in g_MovingItem.Item.s.StdModeEx) then begin
        d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
        if d <> nil then
          DrawBlend(dsurface, SurfaceX(Left) - 13, SurfaceY(Top) - 14, d, 1);
      end;
    end;
  end;
end;

procedure TFrmDlg4.DCloseAbilityMoveClick(Sender: TObject; X, Y: Integer);
begin
  if FAbilityMoveLock then
    exit;
  DWndArmAbilityMove.Visible := False;
end;

procedure TFrmDlg4.DStartAbilityMoveClick(Sender: TObject; X, Y: Integer);
var
  i: Integer;
  AbilityMoveItems: array of Integer;
begin
  if FAbilityMoveLock then
    exit;
  if (FAbilityMoveItemSrc.Item.s.Name = '') or (FAbilityMoveItemDes.Item.s.Name = '') then
  begin
    FrmDlg.DMessageDlg('请放置好需要转移属性的装备.', []);
    exit;
  end;
  SetLength(AbilityMoveItems, 2);
  AbilityMoveItems[0] := FAbilityMoveItemSrc.Item.UserItem.MakeIndex;
  AbilityMoveItems[1] := FAbilityMoveItemDes.Item.UserItem.MakeIndex;
  for i := Low(FAbilityMoveRateItems) to High(FAbilityMoveRateItems) do begin
    if FAbilityMoveRateItems[i].Item.s.Name <> '' then
    begin
      SetLength(AbilityMoveItems, Length(AbilityMoveItems) + 1);
      AbilityMoveItems[Length(AbilityMoveItems) - 1] := FAbilityMoveRateItems[i].Item.UserItem.MakeIndex;
    end;
  end;
  FAbilityMoveLock := True;
  FrmMain.SendClientSocket(CM_ITEMABILITYMOVE, g_nCurMerchant,
    0, 0, Length(AbilityMoveItems),
    EncodeBuffer(@AbilityMoveItems[0], Length(AbilityMoveItems) * SizeOf(Integer)));
end;

procedure TFrmDlg4.DStartAbilityMoveDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure TFrmDlg4.DWndArmAbilityMoveDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
  end;
  with g_DXCanvas do begin
    TextOut(ax + 28{$IF Var_Interface = Var_Default} + 28{$IFEND}, ay + 212{$IF Var_Interface = Var_Default} + 27{$IFEND}, format('成功几率: %d%%', [FAbilityMoveRate]), clWhite);
    TextOut(ax + 28{$IF Var_Interface = Var_Default} + 28{$IFEND}, ay + 237{$IF Var_Interface = Var_Default} + 25{$IFEND}, format('需要金币: %d', [g_AbilityMoveSet.Gold]), clWhite);
  end;
  DStartAbilityMove.Enabled := (not FAbilityMoveLock);
  DCloseAbilityMove.Enabled := (not FAbilityMoveLock);
  if FAbilityMoveShowEffect then
  begin
    if GetTickCount() > FAbilityMoveShowTick then begin
      FAbilityMoveShowTick := GetTickCount() + 150;
      Inc(FAbilityMoveShowSchedulePos);
    end;
    case FAbilityMoveResult of
      1:
        begin
          d := g_WMain99Images.Images[919 + FAbilityMoveShowSchedulePos];
          if d <> nil then
            DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
          if FAbilityMoveShowSchedulePos >= 10 then begin
            FAbilityMoveShowEffect := False;
          end;
        end;
      2:
        begin
          d := g_WMain99Images.Images[929 + FAbilityMoveShowSchedulePos];
          if d <> nil then
            DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} + 64, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} - 136, d, 1);
          if FAbilityMoveShowSchedulePos >= 5 then begin
            FAbilityMoveShowEffect := False;
          end;
        end;
    else
      FAbilityMoveShowEffect := False;
    end;
  end
  else if FAbilityMoveShowSchedule then
  begin
    if GetTickCount() > FAbilityMoveShowTick then
    begin
      if FAbilityMoveShowSchedulePos = 0 then
        PlaySoundEx(bmg_Repair);
      FAbilityMoveShowTick := GetTickCount() + 100;
      Inc(FAbilityMoveShowSchedulePos);
    end;
    //FStrengthenHint := '正在进行强化...';
    if FAbilityMoveShowSchedulePos < 6 then
    begin
      d := g_WMain99Images.Images[800 + FAbilityMoveShowSchedulePos];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} + 64, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} - 136, d, 1);
      d := g_WMain99Images.Images[810 + FAbilityMoveShowSchedulePos];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} + 64, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} - 136, d, 1);
      d := g_WMain99Images.Images[820 + FAbilityMoveShowSchedulePos];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} + 64, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} - 136, d, 1);
      d := g_WMain99Images.Images[830 + FAbilityMoveShowSchedulePos];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} + 64, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} - 136, d, 1);
      d := g_WMain99Images.Images[840 + FAbilityMoveShowSchedulePos];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} + 64, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} - 136, d, 1);
    end
    else
    if FAbilityMoveShowSchedulePos = 6 then
      FAbilityMoveShowSchedulePos := 92;

    if FAbilityMoveShowSchedulePos in [92..100] then
    begin
      d := g_WMain99Images.Images[850 + FAbilityMoveShowSchedulePos - 92];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} + 64, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} - 136, d, 1);
    end;

    if FAbilityMoveShowSchedulePos >= 100 then
    begin
      FAbilityMoveShowSchedule := False;
      FAbilityMoveLock := False;
      case FAbilityMoveResult of
        1:
          begin
            //FStrengthenHint := '恭喜，强化成功';
            FAbilityMoveItemSrc.Item.UserItem := FAbilityMoveItems[0];
            FAbilityMoveItemDes.Item.UserItem := FAbilityMoveItems[1];
            PlaySoundEx(bmg_ItemLevel_OK);
          end;
        2:
          begin
            //FStrengthenHint := '装备破碎了';
            PlaySoundEx(bmg_ItemLevel_Fail);
          end;
      end;
      FAbilityMoveShowSchedulePos := 0;
      FAbilityMoveShowTick := GetTickCount();
      FAbilityMoveShowEffect := True;
    end;
  end;
end;

procedure TFrmDlg4.DWndArmAbilityMoveVisible(Sender: TObject;
  boVisible: Boolean);
begin
  ClearAbilityMoveInfo();
  FrmDlg.LastestClickTime := GetTickCount;
  //FStrengthenHint := '需要强化的装备';
  if boVisible then begin
    FrmDlg.boOpenItemBag := FrmDlg.DItemBag.Visible;
    FrmDlg.DItemBag.Visible := True;
    FrmDlg.DMerchantDlg.Visible := False;
  end
  else begin
    FrmDlg.DItemBag.Visible := FrmDlg.boOpenItemBag;
  end;
end;

procedure TFrmDlg4.RefAbilityMoveRate;
var
  i: Integer;
begin
  FAbilityMoveRate := g_AbilityMoveSet.BaseRate;
  for i := Low(FAbilityMoveRateItems) to High(FAbilityMoveRateItems) do begin
    if FAbilityMoveRateItems[I].Item.s.Name <> '' then
      Inc(FAbilityMoveRate, FAbilityMoveRateItems[I].Item.s.Reserved);
  end;
end;

procedure TFrmDlg4.ClearAbilityMoveInfo;
var
  i: integer;
begin
  FAbilityMoveLock := False;
  FAbilityMoveShowSchedule := False;
  FAbilityMoveShowEffect := False;
  FAbilityMoveShowSchedulePos := 0;
  FAbilityMoveResult := 0;
  {FStrengthenHint := '需要强化的装备';
  FStrengthenMoney := 0;
  FStrengthenMaxRate := 0;
  FStrengthenRate := 0;
  FStrengthenDownLevelRate := 0;
  FStrengthenBreakUpRate := 0;
  FStrengthenLevelType := 0;
  FStrengthenShowEffect := False;}
  //SafeFillChar(FStrengthenUseItem, SizeOf(FStrengthenUseItem), #0);
  if FAbilityMoveItemSrc.Item.s.Name <> '' then begin
    AddItemBag(FAbilityMoveItemSrc.Item, FAbilityMoveItemSrc.Index2);
  end;
  SafeFillChar(FAbilityMoveItemSrc, SizeOf(FAbilityMoveItemSrc), #0);
  if FAbilityMoveItemDes.Item.s.Name <> '' then begin
    AddItemBag(FAbilityMoveItemDes.Item, FAbilityMoveItemDes.Index2);
  end;
  SafeFillChar(FAbilityMoveItemDes, SizeOf(FAbilityMoveItemDes), #0);
  for I := Low(FAbilityMoveRateItems) to High(FAbilityMoveRateItems) do begin
    if FAbilityMoveRateItems[I].Item.s.Name <> '' then
      AddItemBag(FAbilityMoveRateItems[I].Item, FAbilityMoveRateItems[I].Index2);
  end;
  SafeFillChar(FAbilityMoveRateItems[0], SizeOf(TMovingItem) * Length(FAbilityMoveRateItems), #0);
  RefAbilityMoveRate();
end;

procedure TFrmDlg4.ClientAbilityMoveItems(nResult: Integer; sMsg: string);
var
  sSrcItem: string;
begin
  case nResult of
    2: FrmDlg.DMessageDlg('没有足够的手续费用.', []);
    3: FrmDlg.DMessageDlg('请放置好需要转移属性的装备.', []);
    4: FrmDlg.DMessageDlg('需要转移属性的某件装备不允许强化.', []);
    5: FrmDlg.DMessageDlg('需要转移属性的某件装备未开光.', []);
    6: FrmDlg.DMessageDlg('放入了错误的几率神石.', []);
    8: begin  //转移失败
        FAbilityMoveShowSchedule := True;
        FAbilityMoveShowSchedulePos := 0;
        FAbilityMoveShowTick := GetTickCount();
        FAbilityMoveResult := 2;
      end;
    9: begin  //转移成功
        FAbilityMoveShowSchedule := True;
        FAbilityMoveShowSchedulePos := 0;
        FAbilityMoveShowTick := GetTickCount();
        FAbilityMoveResult := 1;
        sMsg := GetValidStr3(sMsg, sSrcItem, ['/']);
        FrmMain.DecodeItem(sSrcItem, @FAbilityMoveItems[0]);
        FrmMain.DecodeItem(sMsg, @FAbilityMoveItems[1]);
      end;
  end;
  if nResult >= 7 then
    SafeFillChar(FAbilityMoveRateItems[0], SizeOf(TMovingItem) * Length(FAbilityMoveRateItems), #0);
  FAbilityMoveLock := False;
  RefAbilityMoveRate();
end;

procedure TFrmDlg4.DCompoundItemDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  i: Integer;
  d: TDXTexture;
  ax, ay: integer;
  pRect: TRect;
begin
  with Sender as TDButton do begin
    i := Tag;
    if not (i in [Low(FCompoundItems) .. High(FCompoundItems)]) then
      exit;
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if (FCompoundItems[i].Item.s.Name <> '') then begin
      d := GetBagItemImg(FCompoundItems[i].Item.S.looks);
      pRect.Left := ax;
      pRect.Top := ay;
      pRect.Right := ax + Width + 1;
      pRect.Bottom := ay + Height;
      if d <> nil then
        FrmDlg.RefItemPaint(dsurface, d, //人物背包栏
          ax + (Width - d.Width) div 2,
          ay + (Height - d.Height) div 2,
          Width,
          Height,
          @FCompoundItems[i].Item, False, [pmShowLevel], @pRect);
    end;
    if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
      if (FCompoundItems[i].Item.s.Name = '') and CanCompoundItemAddEx(@g_MovingItem.Item, Sender = DCompoundItem0) then begin
        d := g_WMain99Images.Images[2112 + (gettickcount - AppendTick) div 200 mod 2];
        if d <> nil then
          DrawBlend(dsurface, SurfaceX(Left) - 13, SurfaceY(Top) - 14, d, 1);
      end;
    end;
  end;
end;

procedure TFrmDlg4.DCompoundItemMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  i: Integer;
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
begin
  with Sender as TDButton do begin
    i := Tag;
    if not (i in [Low(FCompoundItems) .. High(FCompoundItems)]) then
      exit;
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY;
    if FCompoundItems[i].Item.s.Name <> '' then
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(FCompoundItems[i].Item, [mis_ArmStrengthen], []),
        clwhite, False, Tag, True);
  end;
end;

procedure TFrmDlg4.DCompoundItemClick(Sender: TObject; X, Y: Integer);
var
  i: Integer;
  tmp: TMovingItem;
begin
  i := TCustomControl(Sender).Tag;
  if FCompoundLock or not (i in [Low(FCompoundItems) .. High(FCompoundItems)]) then
    exit;
  if not g_boItemMoving then begin
    if Sender <> DCompoundItem0 then
    begin
      if FCompoundItems[i].Item.s.Name <> '' then
        AddItemBag(FCompoundItems[i].Item, FCompoundItems[i].Index2);
      SafeFillChar(FCompoundItems[i], SizeOf(TMovingItem), #0);
    end
    else
      ClearCompoundItemInfo(True);
  end
  else if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.Name <> '') then begin
    if CanCompoundItemAddEx(@g_MovingItem.Item, Sender = DCompoundItem0) then
    begin
      tmp := FCompoundItems[i];
      FCompoundItems[i] := g_MovingItem;
      g_MovingItem := tmp;
      g_boItemMoving := (g_MovingItem.Item.s.Name <> '');
    end;
  end;
end;

procedure TFrmDlg4.DCloseCompoundClick(Sender: TObject; X, Y: Integer);
begin
  if FCompoundLock then
    exit;
  DWndCompound.Visible := False;
end;

procedure TFrmDlg4.DWndCompoundVisible(Sender: TObject; boVisible: Boolean);
begin
  ClearCompoundItemInfo(False);
  FrmDlg.LastestClickTime := GetTickCount;
end;

procedure TFrmDlg4.ClearCompoundItemInfo(boClick: Boolean);
var
  i: integer;
begin
  FCompoundLock := False;
  {FAbilityMoveShowSchedule := False;
  FAbilityMoveShowEffect := False;
  FAbilityMoveShowSchedulePos := 0;
  FAbilityMoveResult := 0;}
  for I := Low(FCompoundItems) to High(FCompoundItems) do begin
    if FCompoundItems[I].Item.s.Name <> '' then
      AddItemBag(FCompoundItems[I].Item, FCompoundItems[I].Index2);
  end;
  SafeFillChar(FCompoundItems[0], SizeOf(TMovingItem) * Length(FCompoundItems), #0);
end;

procedure TFrmDlg4.CompoundItemAdd(nItemIndex: Integer);
var
  //Item: pTNewClientItem;
  I: Integer;
begin
  if FCompoundLock or g_boItemMoving then exit;
  //Item := @g_ItemArr[nItemIndex];
    for I := Low(FCompoundItems) to High(FCompoundItems) do begin
      if FCompoundItems[i].Item.s.Name = '' then begin
        g_boItemMoving := True;
        g_MovingItem.Index2 := nItemIndex;
        g_MovingItem.Item := g_ItemArr[nItemIndex];
        g_MovingItem.ItemType := mtBagItem;
        DelItemBagByIdx(nItemIndex);
        ItemClickSound(g_ItemArr[nItemIndex].S);
        case i of
          0: DCompoundItemClick(DCompoundItem0, 0, 0);
          1: DCompoundItemClick(DCompoundItem1, 0, 0);
          2: DCompoundItemClick(DCompoundItem2, 0, 0);
          3: DCompoundItemClick(DCompoundItem3, 0, 0);
          4: DCompoundItemClick(DCompoundItem4, 0, 0);
        end;
        break;
      end;
    end;
end;

function TFrmDlg4.CanCompoundItemAdd(Item: pTNewClientItem): Boolean;
begin
  Result := CanCompoundItemAddEx(Item, FCompoundItems[Low(FCompoundItems)].Item.s.Name = '');
end;

function TFrmDlg4.CanCompoundItemAddEx(Item: pTNewClientItem; boFirst: Boolean): Boolean;
var
  nLV, nValue: Integer;
  pCompoundInfos: pTCompoundInfos;
  pCompoundInfos2: pTCompoundInfos;
begin
  Result := False;
  if FCompoundLock then
    exit;
  if boFirst then
  begin
    pCompoundInfos := GetCompoundInfos(Item.s.Name);
    if Assigned(pCompoundInfos) then
    begin
      nLV := (Item.UserItem.ComLevel);
      nLV := _MAX(nLV, Low(TCompoundInfos));
      Result := nLV in [Low(TCompoundInfos) .. High(TCompoundInfos)];
      Result := Result and (pCompoundInfos[nLV].Value > 0);
      nLV := (Item.UserItem.ComLevel + 1);
      Result := Result and (nLV in [Low(TCompoundInfos) .. High(TCompoundInfos)]);
      Result := Result and (pCompoundInfos[nLV].Value > 0);
    end;
  end
  else
  begin
    if FCompoundItems[Low(FCompoundItems)].Item.s.Name <> '' then
    begin
      if (Item.UserItem.ComLevel <> FCompoundItems[Low(FCompoundItems)].Item.UserItem.ComLevel) then
        exit;
      pCompoundInfos := GetCompoundInfos(Item.s.Name);
      pCompoundInfos2 := GetCompoundInfos(FCompoundItems[Low(FCompoundItems)].Item.s.Name);
      if Assigned(pCompoundInfos) and Assigned(pCompoundInfos2) then
      begin
        nLV := (FCompoundItems[Low(FCompoundItems)].Item.UserItem.ComLevel);
        nLV := _MAX(nLV, Low(TCompoundInfos));
        if not (nLV in [Low(TCompoundInfos) .. High(TCompoundInfos)]) then
          exit;
        nValue := pCompoundInfos2[nLV].Value;
        nLV := (Item.UserItem.ComLevel);
        nLV := _MAX(nLV, Low(TCompoundInfos));
        if not (nLV in [Low(TCompoundInfos) .. High(TCompoundInfos)]) then
          exit;
        Result := (pCompoundInfos[nLV].Value > nValue - g_CompoundSet.ValueLimit);
      end;
    end;
  end;
end;

procedure TFrmDlg4.DStartCompoundClick(Sender: TObject; X, Y: Integer);
var
  i: Integer;
  CompoundItems: array of Integer;
begin
  if FCompoundLock then
    exit;
  SetLength(CompoundItems, 0);
  for i := Low(FCompoundItems) to High(FCompoundItems) do
  begin
    if (FCompoundItems[i].Item.s.Name = '') then
    begin
      SetLength(CompoundItems, 0);
      FrmDlg.DMessageDlg('请放置好需要合成的装备.', []);
      exit;
    end;
    SetLength(CompoundItems, Length(CompoundItems) + 1);
    CompoundItems[Length(CompoundItems) - 1] := FCompoundItems[i].Item.UserItem.MakeIndex;
  end;
  FCompoundLock := True;
  FrmMain.SendClientSocket(CM_COMPOUNDITEM, g_nCurMerchant, 0, 0, Length(CompoundItems),
    EncodeBuffer(@CompoundItems[0], Length(CompoundItems) * SizeOf(Integer)));
end;

procedure TFrmDlg4.ClientCompoundItem(nResult: Integer; sMsg: string);
begin
  case nResult of
    2: FrmDlg.DMessageDlg('没有足够的手续费用.', []);
    3: FrmDlg.DMessageDlg('请放置好需要合成的装备及材料.', []);
    4: FrmDlg.DMessageDlg('需要合成的主装备不允许强化.', []);
    5: FrmDlg.DMessageDlg('需要合成的主装备未开光.', []);
    6: FrmDlg.DMessageDlg('需要合成的材料装备不允许强化.', []);
    7: FrmDlg.DMessageDlg('需要合成的材料装备未开光.', []);
    9: begin  //合成失败
        FCompoundShowSchedule := True;
        FCompoundShowSchedulePos := 0;
        FCompoundShowTick := GetTickCount();
        FCompoundResult := 2;
      end;
    10: begin  //合成成功
        FCompoundShowSchedule := True;
        FCompoundShowSchedulePos := 0;
        FCompoundShowTick := GetTickCount();
        FCompoundResult := 1;
        FrmMain.DecodeItem(sMsg, @FCompoundUserItem);
      end;
  end;
  if nResult >= 8 then
    SafeFillChar(FCompoundItems[1], SizeOf(TMovingItem) * (Length(FCompoundItems) - 1), #0);
  FCompoundLock := False;
end;

procedure TFrmDlg4.DWndCompoundDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
  end;
  with g_DXCanvas do begin
    TextOut(ax + 34{$IF Var_Interface = Var_Default} + 6{$IFEND}, ay + 35{$IF Var_Interface = Var_Default} + 35{$IFEND}, '1: 合成装备可以提高装备的颜色品质', clWhite);
    TextOut(ax + 34{$IF Var_Interface = Var_Default} + 6{$IFEND}, ay + 52{$IF Var_Interface = Var_Default} + 35{$IFEND}, '2: 只有同颜色的5件装备可以进行合成', clWhite);
    TextOut(ax + 34{$IF Var_Interface = Var_Default} + 6{$IFEND}, ay + 69{$IF Var_Interface = Var_Default} + 35{$IFEND}, '3: 合成成功后将在中央物品栏的装备基', clWhite);
    TextOut(ax + 52{$IF Var_Interface = Var_Default} + 6{$IFEND}, ay + 86{$IF Var_Interface = Var_Default} + 35{$IFEND}, '础上附加属性', clWhite);
    TextOut(ax + 34{$IF Var_Interface = Var_Default} + 6{$IFEND}, ay + 103{$IF Var_Interface = Var_Default} + 35{$IFEND}, '4: 无论是否成功周围4件装备都将消失', clWhite);
  end;
  DStartCompound.Enabled := (not FCompoundLock);
  DCloseCompound.Enabled := (not FCompoundLock);
  if FCompoundShowEffect then
  begin
    if GetTickCount() > FCompoundShowTick then begin
      FCompoundShowTick := GetTickCount() + 150;
      Inc(FCompoundShowSchedulePos);
    end;
    case FCompoundResult of
      1:
        begin
          d := g_WMain99Images.Images[919 + FCompoundShowSchedulePos];
          if d <> nil then
            DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND}, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND}, d, 1);
          if FCompoundShowSchedulePos >= 10 then begin
            FCompoundShowEffect := False;
          end;
        end;
      2:
        begin
          d := g_WMain99Images.Images[929 + FCompoundShowSchedulePos];
          if d <> nil then
            DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} - 6, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} + 22, d, 1);
          if FCompoundShowSchedulePos >= 5 then begin
            FCompoundShowEffect := False;
          end;
        end;
    else
      FCompoundShowEffect := False;
    end;
  end
  else if FCompoundShowSchedule then
  begin
    if GetTickCount() > FCompoundShowTick then
    begin
      if FCompoundShowSchedulePos = 0 then
        PlaySoundEx(bmg_Repair);
      FCompoundShowTick := GetTickCount() + 100;
      Inc(FCompoundShowSchedulePos);
    end;
    //FStrengthenHint := '正在进行强化...';
    if FCompoundShowSchedulePos < 6 then
    begin
      d := g_WMain99Images.Images[800 + FCompoundShowSchedulePos];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} - 6, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} + 22, d, 1);
      d := g_WMain99Images.Images[810 + FCompoundShowSchedulePos];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} - 6, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} + 22, d, 1);
      d := g_WMain99Images.Images[820 + FCompoundShowSchedulePos];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} - 6, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} + 22, d, 1);
      d := g_WMain99Images.Images[830 + FCompoundShowSchedulePos];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} - 6, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} + 22, d, 1);
      d := g_WMain99Images.Images[840 + FCompoundShowSchedulePos];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} - 6, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} + 22, d, 1);
    end
    else
    if FCompoundShowSchedulePos = 6 then
      FCompoundShowSchedulePos := 92;

    if FCompoundShowSchedulePos in [92..100] then
    begin
      d := g_WMain99Images.Images[850 + FCompoundShowSchedulePos - 92];
      if d <> nil then
        DrawBlend(dsurface, ax + {$IF Var_Interface = Var_Mir2} 25{$ELSE}75{$IFEND} - 6, ay{$IF Var_Interface = Var_Mir2} - 35{$IFEND} + 22, d, 1);
    end;

    if FCompoundShowSchedulePos >= 100 then
    begin
      FCompoundShowSchedule := False;
      FCompoundLock := False;
      case FCompoundResult of
        1:
          begin
            //FStrengthenHint := '恭喜，强化成功';
            FCompoundItems[0].Item.UserItem := FCompoundUserItem;
            PlaySoundEx(bmg_ItemLevel_OK);
          end;
        2:
          begin
            //FStrengthenHint := '装备破碎了';
            PlaySoundEx(bmg_ItemLevel_Fail);
          end;
      end;
      FCompoundShowSchedulePos := 0;
      FCompoundShowTick := GetTickCount();
      FCompoundShowEffect := True;
    end;
  end;
end;

end.




