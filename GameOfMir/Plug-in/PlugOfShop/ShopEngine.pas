unit ShopEngine;

interface
uses
  Share, Windows, Classes, StrUtils, SysUtils, EngineAPI, EngineType, DateUtils;

type
  TShopItem = packed record
    sName: string[14];
    btIdx: Byte;
    wIdent: Word;
    nPrict: Integer;
    wTime: Word;
    nIntegral: Integer;
    btStatus: Byte;
    sHint: string[255];
  end;
  pTShopItem = ^TShopItem;

procedure LoadShopList();
procedure SaveShopList();
procedure ClearShopList();
procedure DelShopItem(ShopItem: pTShopItem);
procedure GetShopItems(PlayObject: TPlayObject; nIndex, nShowIndex: Integer);
procedure BuyShopItems(PlayObject: TPlayObject; nIndex, nItemIndex, nIdent: Integer);
procedure BuyShopItemsByPoint(PlayObject: TPlayObject; nIndex, nItemIndex, nIdent: Integer);
procedure BuyShopItemsEx(PlayObject: TPlayObject; sbody: string);
procedure GetPoint(PlayObject: TPlayObject; nCount: Integer);
procedure GetPointEx(PlayObject: TPlayObject; sbody: string);
function GetGameGoldChangeInfo(LogIndex: Pointer):pTGameGoldChange;
procedure SendShopItems(PlayObject: TPlayObject; nIndex, nItemIndex: Integer; sName: string);

implementation
uses
  HUtil32, Grobal2;

procedure DelShopItem(ShopItem: pTShopItem);
var
  i, II: Integer;
begin
  for I := Low(m_ShopItemList) to High(m_ShopItemList) do
    for II := 0 to m_ShopItemList[i].Count - 1 do begin
      if pTShopItem(m_ShopItemList[i].Items[ii]) = ShopItem then begin
        m_ShopItemList[i].Delete(ii);
        Exit;
      end;
    end;
end;

procedure ClearShopList();
var
  i, II: Integer;
begin
  for I := Low(m_ShopItemList) to High(m_ShopItemList) do begin
    for II := 0 to m_ShopItemList[i].Count - 1 do
      Dispose(pTShopItem(m_ShopItemList[i].Items[ii]));
    m_ShopItemList[i].Clear;
  end;
end;

procedure LoadShopList();
var
  sFileName: string;
  LoadList: TStringList;
  I, nIdx, nItemIdx, nPrict, nTime, nIntegral, nStatus: Integer;
  sLoadStr, sIdx, sName, sItemIdx, sPrict, sTime, sIntegral, sTest, sStatus: string;
  ShopItem: pTShopItem;
  StdItem: _LPTSTDITEM;
begin
  ClearShopList();
  sFileName := GetEnvirDir^ + SHOPLISTNAME;
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      try
        LoadList.LoadFromFile(sFileName);
      except
        MainOutMessage(PChar('[Exception] ��ȡ�ļ�ʧ�� -> ' + sFileName));
      end;
      for I := 0 to LoadList.Count - 1 do begin
        sLoadStr := LoadList.Strings[I];
        if (sLoadStr <> '') and (sLoadStr[1] <> ';') then begin
          sLoadStr := GetValidStr3(sLoadStr, sIdx, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sName, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sItemIdx, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sPrict, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sTime, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sIntegral, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sStatus, [' ', #9]);
          sLoadStr := GetValidStr3(sLoadStr, sTest, [' ', #9]);
          nIdx := StrToIntDef(sIdx, -1);
          nItemIdx := StrToIntDef(sItemIdx, 0);
          nPrict := StrToIntDef(sPrict, -1);
          nTime := StrToIntDef(sTime, 0);
          nIntegral := StrToIntDef(sIntegral, 0);
          nStatus := StrToIntDef(sStatus, 0);
          if (nIdx in [0..5]) and (nItemIdx > 0) and (nPrict >= 0) then begin
            StdItem := TUserEngine_GetStdItemByName(PChar(sName));
            if StdItem <> nil then begin
              New(ShopItem);
              ShopItem.sName := sName;
              ShopItem.btIdx := nIdx;
              ShopItem.wIdent := StdItem.Idx + 1;
              ShopItem.nPrict := nPrict;
              ShopItem.wTime := nTime;
              ShopItem.nIntegral := nIntegral;
              ShopItem.btStatus := nStatus;
              ShopItem.sHint := sTest;
              m_ShopItemList[nIdx].Add(ShopItem);
            end;
          end;
        end;
      end;
    finally
      LoadList.Free;
    end;
  end;
end;

procedure SaveShopList();
resourcestring
  sText = '%d'#9'%s'#9'%d'#9'%d'#9'%d'#9'%d'#9'%d'#9'%s';
var
  i, II: Integer;
  ShopItem: pTShopItem;
  SaveList: TStringList;
  sFileName, sSaveStr: string;
begin
  sFileName := GetEnvirDir^ + SHOPLISTNAME;
  SaveList := TStringList.Create;
  try
    for I := Low(m_ShopItemList) to High(m_ShopItemList) do begin
      Inc(m_ShopShowIdx[I]);
      for II := 0 to m_ShopItemList[i].Count - 1 do begin
        ShopItem := m_ShopItemList[i].Items[ii];
        sSaveStr := Format(sText, [ShopItem.btIdx,
          ShopItem.sName,
            ShopItem.wIdent,
            ShopItem.nPrict,
            ShopItem.wTime,
            ShopItem.nIntegral,
            ShopItem.btStatus,
            ShopItem.sHint]);
        SaveList.Add(sSaveStr);
      end;
    end;
    try
      SaveList.SaveToFile(sFileName);
    except
      MainOutMessage(PChar('[Exception] �����ļ�ʧ�� -> ' + sFileName));
    end;
  finally
    SaveList.Free;
  end;
end;

//������Ʒ

procedure SendShopItems(PlayObject: TPlayObject; nIndex, nItemIndex: Integer;
  sName: string);
{var
  nResult: Integer;
  i: Integer;
  ShopItem: pTShopItem;
  GameGold: PInteger;
  UserItem: _LPTUSERITEM;
  StdItem: _LPTSTDITEM;
  sItemName, sLog: string;
  SendObject: TPlayObject;     }
begin
  {nResult := -1; //�������Ʒ������
  ShopItem := nil;

  if (nIndex in [0..5]) then begin
    for I := 0 to m_ShopItemList[nIndex].Count - 1 do begin
      ShopItem := m_ShopItemList[nIndex].Items[i];
      if ShopItem.nItemIdx = nItemIndex then begin
        nResult := 2;
        Break;
      end;
    end;
    if (nResult = 2) and (ShopItem <> nil) then begin
      GameGold := TPlayObject_nGameGold(PlayObject);
      if (ShopItem.nPrict > 0) and (GameGold^ >= ShopItem.nPrict) then begin
        New(UserItem);
        sItemName := ShopItem.sName;
        SendObject := TUserEngine_GetPlayObject(PChar(sName), True);
        if SendObject <> nil then begin
          if TUserEngine_CopyToUserItemFromName(PChar(sItemName), UserItem) then
            begin
            if TBaseObject_AddItemToBag(SendObject, UserItem) <> -1 then begin
              Dec(GameGold^, ShopItem.nPrict);
              TPlayObject_SendAddItem(SendObject, UserItem);
              TBaseObject_GameGoldChanged(PlayObject);
              if GetGameLogGameGold()^ then begin
                sLog := format(g_sGameLogMsg1, [LOG_GAMEGOLD,
                  TBaseObject_sMapName(PlayObject)^,
                    TBaseObject_nCurrX(PlayObject)^,
                    TBaseObject_nCurrY(PlayObject)^,
                    TBaseObject_sCharName(PlayObject)^,
                    GetGameGoldName^,
                    ShopItem.nPrict,
                    '-',
                    '����']);
                AddGameDataLog(PChar(sLog));
              end;
              StdItem := TUserEngine_GetStdItemByIndex(ShopItem.nItemIdx);
              if StdItem <> nil then begin
                if StdItem.NeedIdentify = 1 then begin
                  sLog := format(g_sGameLogMsg1, [LOG_SHOPSEND,
                    TBaseObject_sMapName(PlayObject)^,
                      TBaseObject_nCurrX(PlayObject)^,
                      TBaseObject_nCurrY(PlayObject)^,
                      TBaseObject_sCharName(PlayObject)^,
                      sItemName,
                      UserItem.MakeIndex,
                      TBaseObject_sCharName(SendObject)^,
                      '����']);
                  AddGameDataLog(PChar(sLog));
                end;
              end;
            end
            else
              nResult := -5; //�����ռ䲻��
          end
          else
            nResult := -10; //��ȡ��Ʒ��Ϣʧ��
        end
        else
          nResult := -4; //���͵����ﲻ����
        Dispose(UserItem); //API�ڲ������������ڴ�
      end
      else
        nResult := -2; //Ԫ������
      //end else nResult := -4; //���͵����ﲻ����
    end;
  end;
  TPlayObject_SendDefMessage(PlayObject, SM_CLIENTBUYITEM, nResult, 0, 0, 0, '');  }
end;

function GetGameGoldChangeInfo(LogIndex: Pointer):pTGameGoldChange;
var
  i: integer;
begin
  Result := nil;
  for I := 0 to m_GoldChangeList.Count - 1 do begin
    if m_GoldChangeList[i] = LogIndex then begin
      Result := pTGameGoldChange(m_GoldChangeList[i]);
      m_GoldChangeList.Delete(I);
      break;
    end;
  end;
end;

procedure BuyShopItemsEx(PlayObject: TPlayObject; sbody: string);
var
  nResult: Integer;
  sID, sLogIndex: string;
  nID, nLogIndex, nGoldCount: Integer;
  UserItem: _LPTUSERITEM;
  StdItem: _LPTSTDITEM;
  sItemName: string;
  GameGoldChange, AddGameGoldChange: pTGameGoldChange;
  GameGold: pInteger;
  nIndex, nItemIndex: Integer;
  ShopItem: pTShopItem;
begin
  sbody := GetValidStr3(sBody, sLogIndex, ['/']);
  sbody := GetValidStr3(sBody, sID, ['/']);
  nID := StrToIntDef(sID, 10);
  nLogIndex := StrToIntDef(sLogIndex, -1);
  nGoldCount := StrToIntDef(sbody, -1);
  if (nID <> 10) and (nLogIndex > 0) then begin
    GameGoldChange := GetGameGoldChangeInfo(Pointer(nLogIndex));
    if GameGoldChange <> nil then begin
      Try
        nResult := -2;
        GameGold := TPlayObject_nGameGold(PlayObject);
        if nID = 1 then begin
          if GameGoldChange.boAdd then begin
            AddGameDataLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, Integer(GameGoldChange),
              GameGoldChange.nGoldCount, '����', '����', '�ɹ�', '0');
          end else begin
            AddGameDataLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, Integer(GameGoldChange),
              GameGoldChange.nGoldCount, '����', '�۳�', '�ɹ�', '0');

            nIndex := GameGoldChange.nIndex;
            nItemIndex := GameGoldChange.ItemIndex;
            if (nIndex in [0..5]) and (nItemIndex >=0) and (nItemIndex < m_ShopItemList[nIndex].Count) then begin
              nResult := 1;
              ShopItem := m_ShopItemList[nIndex][nItemIndex];
              New(UserItem);
              sItemName := ShopItem.sName;
              if TUserEngine_CopyToUserItemFromName(PChar(sItemName), UserItem) then begin
                UserItem.Dura := UserItem.DuraMax;
                UserItem.btBindMode1 := ShopItem.btStatus;
                if ShopItem.wTime > 0 then begin
                  UserItem.TermTime := IncDay(Now, ShopItem.wTime);
                end;

                if TBaseObject_AddItemToBag(PlayObject, UserItem) then begin
                  if API_IntegerChange(TPlayObject_nGameDiamond(PlayObject), ShopItem.nIntegral, INT_ADD) then begin
                    TPlayObject_DiamondChanged(PlayObject);
                    if GetGameLogGameDiamond^ then
                      AddGameDataLog(PlayObject, LOG_GAMEDIAMONDCHANGED, sSTRING_GAMEDIAMOND, 0,
                        TPlayObject_nGameDiamond(PlayObject)^, '����',
                          '+', PChar(IntToStr(ShopItem.nIntegral)), '����');
                  end;
                  TPlayObject_SendAddItem(PlayObject, UserItem);
                  StdItem := TUserEngine_GetStdItemByIndex(UserItem.wIndex);
                  if StdItem <> nil then begin
                    sItemName := StdItem.Name;
                    if StdItem.NeedIdentify = 1 then begin
                      AddGameDataLog(PlayObject, LOG_ADDITEM, PChar(sItemName), UserItem.MakeIndex, UserItem.Dura, '����',
                        PChar(IntToStr(Integer(GameGoldChange))), sSTRING_GAMEGOLD, '����');
                    end;
                  end;
                end
                else
                  nResult := -3; //�����ռ䲻��
              end
              else
                nResult := -10; //��ȡ��Ʒ��Ϣʧ��
              Dispose(UserItem); //API�ڲ������������ڴ�
            end;
            if nResult <> 1 then begin  //��������Ʒʧ�ܣ������·���Ԫ��
              New(AddGameGoldChange);
              AddGameGoldChange.nGoldCount := GameGoldChange.nGoldCount;
              AddGameGoldChange.boAdd := True;
              AddGameGoldChange.nIndex := nIndex;
              AddGameGoldChange.ItemIndex := nItemIndex;
              AddGameGoldChange.ItemName := '';
              m_GoldChangeList.Add(AddGameGoldChange);
              AddGameDataLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, Integer(AddGameGoldChange),
                GameGoldChange.nGoldCount, '����', '����', '����', '0');
              IDSrv_SendGameGoldChangeMsg(PlayObject, GameGoldChange.nGoldCount, Integer(AddGameGoldChange), True,
                PChar(IntToStr(RM_SHOPGAMEGOLDCHANGE) + '/' + IntToStr(Integer(AddGameGoldChange))));
            end;
          end;
        end else begin
          if GameGoldChange.boAdd then begin
            AddGameDataLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, Integer(GameGoldChange),
                GameGoldChange.nGoldCount, '����', '����', 'ʧ��', PChar(IntToStr(nID)));
          end else begin
            AddGameDataLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, Integer(GameGoldChange),
                GameGoldChange.nGoldCount, '����', '�۳�', 'ʧ��', PChar(IntToStr(nID)));
          end;
        end;

        if (nGoldCount >= 0) and (GameGold^ <> nGoldCount) then begin
          GameGold^ := nGoldCount;
          TBaseObject_GameGoldChanged(PlayObject);
          IDSrv_GameGoldChange(PlayObject, nGoldCount);
        end;
        if not GameGoldChange.boAdd then begin
          TPlayObject_SendDefMessage(PlayObject, SM_CLIENTBUYITEM, nResult, 0, 0, 0, '');
        end;
      Finally
        Dispose(GameGoldChange);
      End;
    end;
  end;
end;

//��Ϸ�㹺��
procedure BuyShopItemsByPoint(PlayObject: TPlayObject; nIndex, nItemIndex, nIdent: Integer);
var
  nResult: Integer;
  ShopItem: pTShopItem;
  GamePoint: PInteger;
  UserItem: _LPTUSERITEM;
  StdItem: _LPTSTDITEM;
  sItemName: string;
begin
  nResult := -1; //�������Ʒ������
  if (nIndex in [0..5]) and (nItemIndex >=0) and (nItemIndex < m_ShopItemList[nIndex].Count) then begin
    GamePoint := TPlayObject_nGamePoint(PlayObject);
    ShopItem := m_ShopItemList[nIndex][nItemIndex];
    if (ShopItem.nPrict >= 0) and (GamePoint^ >= ShopItem.nPrict) then begin
      nResult := 1;
      New(UserItem);
      sItemName := ShopItem.sName;

      if TUserEngine_CopyToUserItemFromName(PChar(sItemName), UserItem) then begin
        UserItem.Dura := UserItem.DuraMax;
        UserItem.btBindMode1 := ShopItem.btStatus;
        if ShopItem.wTime > 0 then begin
          UserItem.TermTime := IncDay(Now, ShopItem.wTime);
        end;
        if TBaseObject_AddItemToBag(PlayObject, UserItem) then begin
          TPlayObject_SendAddItem(PlayObject, UserItem);
          API_IntegerChange(GamePoint, ShopItem.nPrict, INT_DEL);
          TBaseObject_GameGoldChanged(PlayObject);
          AddGameDataLog(PlayObject, LOG_GAMEPOINTCHANGED, sSTRING_GAMEPOINT, 0,
            GamePoint^, '����', '-', PChar(IntToStr(ShopItem.nPrict)), '����');

          StdItem := TUserEngine_GetStdItemByIndex(UserItem.wIndex);
          if StdItem <> nil then begin
            sItemName := StdItem.Name;
            if StdItem.NeedIdentify = 1 then begin
              AddGameDataLog(PlayObject, LOG_ADDITEM, PChar(sItemName), UserItem.MakeIndex, UserItem.Dura, '����',
                '0', sSTRING_GAMEPOINT, '����');
            end;
          end;
        end
        else
          nResult := -3; //�����ռ䲻��
      end
      else
        nResult := -10; //��ȡ��Ʒ��Ϣʧ��
      Dispose(UserItem); //API�ڲ������������ڴ�
    end
    else
      nResult := -7; //Ԫ������
  end;
  TPlayObject_SendDefMessage(PlayObject, SM_CLIENTBUYITEM, nResult, 0, 0, 0, '');
end;

//������Ʒ

procedure BuyShopItems(PlayObject: TPlayObject; nIndex, nItemIndex, nIdent: Integer);
var
  nResult: Integer;
  ShopItem: pTShopItem;
  GameGold: PInteger;
  GameGoldChange: pTGameGoldChange;
//  UserItem: _LPTUSERITEM;
//  StdItem: _LPTSTDITEM;
begin
  nResult := -1; //�������Ʒ������
  if (nIndex in [0..5]) and (nItemIndex >=0) and (nItemIndex < m_ShopItemList[nIndex].Count) then begin
    ShopItem := m_ShopItemList[nIndex][nItemIndex];
    nResult := 1;
    if (nResult = 1) and (ShopItem <> nil) and (ShopItem.wIdent = nIdent) then begin
      GameGold := TPlayObject_nGameGold(PlayObject);
      if (ShopItem.nPrict > 0) and (GameGold^ >= ShopItem.nPrict) then begin
        New(GameGoldChange);
        GameGoldChange.nGoldCount := ShopItem.nPrict;
        GameGoldChange.boAdd := False;
        GameGoldChange.nIndex := nIndex;
        GameGoldChange.ItemIndex := nItemIndex;
        GameGoldChange.ItemName := ShopItem.sName;
        m_GoldChangeList.Add(GameGoldChange);
        AddGameDataLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, Integer(GameGoldChange),
          GameGoldChange.nGoldCount, '����', '�۳�', '����', '0');
        IDSrv_SendGameGoldChangeMsg(PlayObject, ShopItem.nPrict, Integer(GameGoldChange), False,
          PChar(IntToStr(RM_SHOPGAMEGOLDCHANGE) + '/' + IntToStr(Integer(GameGoldChange))));
        exit;
      end
      else
        nResult := -2; //Ԫ������
    end;
  end;
  TPlayObject_SendDefMessage(PlayObject, SM_CLIENTBUYITEM, nResult, 0, 0, 0, '');
end;

procedure GetPointEx(PlayObject: TPlayObject; sbody: string);
var
  sCount, sID: string;
  nCount, nID, nGoldCount, nResult: Integer;
  GameGold: PInteger;
begin
  sbody := GetValidStr3(sBody, sCount, ['/']);
  sbody := GetValidStr3(sBody, sID, ['/']);
  nID := StrToIntDef(sID, 10);
  nCount := StrToIntDef(sCount, -1);
  nGoldCount := StrToIntDef(sbody, -1);
  if (nID <> 10) and (nCount > 0) then begin
    nResult := -2;
    GameGold := TPlayObject_nGameGold(PlayObject);
    if nID = 1 then begin
      AddGameDataLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 1,
          nCount, '����', '�۳�', '�ɹ�', '�Ի�');
      API_IntegerChange(TPlayObject_nGamePoint(PlayObject), nCount, INT_ADD);

      AddGameDataLog(PlayObject, LOG_GAMEPOINTCHANGED, sSTRING_GAMEPOINT, 0,
            TPlayObject_nGamePoint(PlayObject)^, '����', '+', PChar(IntToStr(nCount)), '�Ի�');

      if API_IntegerChange(TPlayObject_nGameDiamond(PlayObject), nCount, INT_ADD) then begin
        TPlayObject_DiamondChanged(PlayObject);
        if GetGameLogGameDiamond^ then
          AddGameDataLog(PlayObject, LOG_GAMEDIAMONDCHANGED, sSTRING_GAMEDIAMOND, 0,
            TPlayObject_nGameDiamond(PlayObject)^, '����',
            '+', PChar(IntToStr(nCount)), '�Ի�');
      end;
      if (nGoldCount >= 0) and (GameGold^ <> nGoldCount) then begin
        GameGold^ := nGoldCount;
        IDSrv_GameGoldChange(PlayObject, nGoldCount);
      end;
      TBaseObject_GameGoldChanged(PlayObject);
      TPlayObject_SendDefMessage(PlayObject, SM_CLIENTBUYITEM, -6, nCount, 0, 0, '');
      exit;
    end else begin
      AddGameDataLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 1,
          nID, '����', '�۳�', 'ʧ��', '�Ի�');
    end;
    TPlayObject_SendDefMessage(PlayObject, SM_CLIENTBUYITEM, nResult, 0, 0, 0, '');
  end;
end;

procedure GetPoint(PlayObject: TPlayObject; nCount: Integer);
var
  GameGold: PInteger;
begin
  GameGold := TPlayObject_nGameGold(PlayObject);
  if GameGold^ >= nCount then begin
    AddGameDataLog(PlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 1,
          nCount, '����', '�۳�', '����', '�Ի�');
    IDSrv_SendGameGoldChangeMsg(PlayObject, nCount, 1, False, PChar(IntToStr(RM_SHOPGETPOINT) + '/' +
      IntToStr(nCount)));
  end else
    TPlayObject_SendDefMessage(PlayObject, SM_CLIENTBUYITEM, -2, 0, 0, 0, '');
end;

//ȡ��Ʒ�б�

procedure GetShopItems(PlayObject: TPlayObject; nIndex, nShowIndex: Integer);
var
  i: Integer;
  ShopItem: pTShopItem;
  ClientShopItem: TClientShopItem;
  sSendMsg: string;
  DefMsg: TDefaultMessage;
begin
  if (nIndex in [0..5]) and (m_ShopShowIdx[nIndex] <> nShowIndex) then begin
    sSendMsg := '';
    for I := 0 to m_ShopItemList[nIndex].Count - 1 do begin
      ShopItem := m_ShopItemList[nIndex].Items[i];
      FillChar(ClientShopItem, SizeOf(TClientShopItem), #0);
      ClientShopItem.btIdx := ShopItem.btIdx;
      ClientShopItem.wIdent := ShopItem.wIdent;
      ClientShopItem.nPrict := ShopItem.nPrict;
      ClientShopItem.wTime := ShopItem.wTime;
      ClientShopItem.nIntegral := ShopItem.nIntegral;
      ClientShopItem.btStatus := Shopitem.btStatus;
      sSendMsg := sSendMsg + EncodeBuffer(@ClientShopItem, SizeOf(TClientShopItem)) + '/';
    end;
    DefMsg := MakeDefaultMsg(SM_GETSHOPLIST, nIndex, m_ShopShowIdx[nIndex], 0, 0);
    TPlayObject_SendSocket(PlayObject, @DefMsg, PChar(sSendMsg));
  end;
end;

end.

