unit LocalDB;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, ZLIB,
  Forms, ActiveX, DateUtils, RegDllFile,
  Dialogs, M2Share, {$IF DBTYPE = BDE}DBTables{$ELSE}ADODB{$IFEND}, DB, HUtil32,
  Grobal2, SDK, ObjNpc, UsrEngn;

type
  TDefineInfo = record
    sName: string;
    sText: string;
  end;
  pTDefineInfo = ^TDefineInfo;

  TQDDinfo = record
    n00: Integer;
    s04: string;
    sList: TStringList;
  end;
  pTQDDinfo = ^TQDDinfo;

  TGoodFileHeader = record
    nItemCount: Integer;
    Resv: array[0..251] of Integer;
  end;

  TFrmDB = class {(TForm)}
  private
    procedure QMangeNPC;
    procedure QFunctionNPC;
    procedure QMapEventNpc;
    procedure RobotNPC();
    function LoadSetItems(): Integer;
    function LoadCompoundInfoList: Integer;
    function GetSetItem(sItemName: string): TList;
    procedure DeCodeStringList(StringList: TStringList);
    procedure LoadListCall(sLoadName: string; var LoadList: TStringList);
    { Private declarations }
  public
{$IF DBTYPE = BDE}
    Query: TQuery;
{$ELSE}
    Query: TADOQuery;
{$IFEND}
    constructor Create();
    destructor Destroy; override;
    function LoadMonitems(MonName: string; var ItemList: TList): Integer;
    function LoadItemsDB(): Integer;
    function LoadMinMap(): Integer;
    function LoadMapInfo(): Integer;
    function LoadMonsterDB(): Integer;
    function LoadMagicDB(): Integer;
    function LoadMonGen(): Integer;
    function LoadUnbindList(): Integer;
    function LoadMapQuest(): Integer;
    function LoadMissionData(): Integer;
    function LoadMapDesc(): Integer;
    //function LoadQuestDiary(): Integer;
    function LoadAdminList(): Boolean;
    function LoadDefiniensConst: Boolean;
    function LoadMerchant(): Integer;
    function LoadGuardList(): Integer;
    function LoadNpcs(): Integer;
    function LoadMakeItem(): Integer;
    function LoadMakeMagic(): Integer;
    function LoadBoxs(): Integer;
    function LoadMonSayMsg(): Boolean;
    function LoadStartPoint(): Integer;
    function LoadNpcScript(NPC: TNormNpc; sPatch, sScritpName: string): Integer;
    function LoadScriptFile(NPC: TNormNpc; sPatch, sScritpName: string; boFlag: Boolean): Integer;
    // function LoadGoodRecord(NPC: TMerchant; sFile: string): Integer;
     //function LoadGoodPriceRecord(NPC: TMerchant; sFile: string): Integer;

     //function SaveGoodRecord(NPC: TMerchant; sFile: string): Integer;
     //function SaveGoodPriceRecord(NPC: TMerchant; sFile: string): Integer;

    function LoadUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
    function SaveUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
    procedure ReLoadMerchants();
    procedure ReLoadNpc();
    procedure LoadUserCmd();

    function LoadMapEvent(): Integer;
    { Public declarations }
  end;

var
  FrmDB: TFrmDB;
implementation

uses ObjBase, Envir, {$IFDEF PLUGOPEN}PlugOfEngine, {$ENDIF}svMain, ObjGuard, EDcodeEx, CheckDLL, MD5Unit;

//{$R *.dfm}

{ TFrmDB }
//00487630

function TFrmDB.LoadAdminList(): Boolean;
var
  sFileName: string;
  sLineText: string;
  sIPaddr: string;
  sCharName: string;
  sData: string;
  LoadList: TStringList;
  AdminInfo: pTAdminInfo;
  i: Integer;
  nLv: Integer;
begin
  Result := False;
  ;
  sFileName := g_Config.sGameDataDir + RSADecodeString('hkZIlTfk5YbIm2j2KwGtziv58WLB9F0foa'); //'AdminList.txt'
  if not FileExists(sFileName) then
    Exit;
  UserEngine.m_AdminList.Lock;
  try
    UserEngine.m_AdminList.Clear;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for i := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[i];
      nLv := -1;
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        if sLineText[1] = '*' then
          nLv := 10
        else if sLineText[1] = '1' then
          nLv := 9
        else if sLineText[1] = '2' then
          nLv := 8
        else if sLineText[1] = '3' then
          nLv := 7
        else if sLineText[1] = '4' then
          nLv := 6
        else if sLineText[1] = '5' then
          nLv := 5
        else if sLineText[1] = '6' then
          nLv := 4
        else if sLineText[1] = '7' then
          nLv := 3
        else if sLineText[1] = '8' then
          nLv := 2
        else if sLineText[1] = '9' then
          nLv := 1;
        if nLv > 0 then begin
          sLineText := GetValidStrCap(sLineText, sData, ['/', '\', ' ', #9]);
          sLineText := GetValidStrCap(sLineText, sCharName, ['/', '\', ' ',
            #9]);
          sLineText := GetValidStrCap(sLineText, sIPaddr, ['/', '\', ' ', #9]);

          New(AdminInfo);
          AdminInfo.nLv := nLv;
          AdminInfo.sChrName := sCharName;
          AdminInfo.sIPaddr := sIPaddr;
          UserEngine.m_AdminList.Add(AdminInfo);
        end;
      end;
    end;
    LoadList.Free;
  finally
    UserEngine.m_AdminList.UnLock;
  end;
  Result := True;
end;
//00488A68

function TFrmDB.LoadGuardList(): Integer;
var
  sFileName, s14, s1C, s20, s24, s2C, sX, sY: string;
  tGuardList: TStringList;
  i: Integer;
  tGuard: TBaseObject;
  PointList: TStringList;
  nCount, k: Integer;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + RSADecodeString('hkZIlTfk5YbIm2j2kcqZofTwCByu1LtiIa'); //'GuardList.txt'
  if MyFileExists(sFileName) then begin
    tGuardList := TMsgStringList.Create;
    PointList := TStringList.Create;
    tGuardList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), tGuardList);
    for i := 0 to tGuardList.Count - 1 do begin
      s14 := tGuardList.Strings[i];
      if (s14 <> '') and (s14[1] <> ';') then begin
        s14 := GetValidStrCap(s14, s1C, [' ', #9]);
        if (s1C <> '') and (s1C[1] = '"') then
          ArrestStringEx(s1C, '"', '"', s1C);
        s14 := GetValidStr3(s14, s20, [' ', #9]);
        s14 := GetValidStr3(s14, s24, [' ', #9]);
        if (s24 <> '') and (s24[1] = '[') and (s1C <> '') and (s20 <> '') then begin
          ArrestStringEx(s24, '[', ']', s24);
          PointList.Clear;
          nCount := ExtractStrings(['|'], [], PChar(s24), PointList);
          if nCount > 0 then begin
            sY := GetValidStr3(PointList[0], sX, [' ', ',', #9]);
            s14 := GetValidStr3(s14, s2C, [' ', #9, ':']);
            tGuard := UserEngine.RegenMonsterByName(s20, StrToIntDef(sX, 0), StrToIntDef(sY, 0), s1C);
            if tGuard <> nil then begin
              tGuard.m_btDirection := StrToIntDef(s2C, 0);
              if (nCount > 1) and (tGuard is TMoveSuperGuard) then begin
                with tGuard as TMoveSuperGuard do begin
                  SetLength(MovePoint, nCount);
                  MovePoint[0].X := StrToIntDef(sX, 0);
                  MovePoint[0].Y := StrToIntDef(sY, 0);
                  for k := 1 to nCount - 1 do begin
                    sY := GetValidStr3(PointList[k], sX, [' ', ',', #9]);
                    MovePoint[k].X := StrToIntDef(sX, 0);
                    MovePoint[k].Y := StrToIntDef(sY, 0);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
    tGuardList.Free;
    PointList.Free;
    Result := 1;
  end;
end;
//004855E0

function TFrmDB.LoadItemsDB: Integer;
var
  i, Idx, k: Integer;
  StdItem: pTStdItem;
  wBind: LongWord;
  ClientStditem: TClientStditem;
  ClientItemStr: string;
  OutLen: Integer;
  OutBuffer: PChar;
  StdItemLimit: pTStdItemLimit;
resourcestring
  sSQLString = 'select * from StdItems';
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    try
      for i := 0 to UserEngine.StdItemList.Count - 1 do begin
        Dispose(pTItemRule(pTStdItem(UserEngine.StdItemList.Items[i]).Rule));
        if pTStdItem(UserEngine.StdItemList.Items[i]).SetItemList <> nil then
          pTStdItem(UserEngine.StdItemList.Items[i]).SetItemList.Free;
        DisPose(pTStdItem(UserEngine.StdItemList.Items[i]));
      end;
      for i := 0 to UserEngine.StdItemLimitList.Count - 1 do begin
        DisPose(pTStdItemLimit(UserEngine.StdItemLimitList.Items[i]));
      end;
      UserEngine.StdItemLimitList.Clear;
      UserEngine.StdItemList.Clear;
      g_sItemData := '';
      g_sItemDataMD5 := '';
      g_nItemDataLen := 0;
      Result := -1;
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      try
        Query.Open;
      finally
        Result := -2;
      end;
      ClientItemStr := '';
      for i := 0 to Query.RecordCount - 1 do begin
        FillChar(ClientStditem, SizeOf(TClientStditem), #0);
        New(StdItem);
        SafeFillChar(StdItem^, SizeOf(TStdItem), #0);
        Idx := Query.FieldByName('Idx').AsInteger;
        StdItem.Idx := Idx;
        StdItem.Name := Query.FieldByName('Name').AsString;
        StdItem.StdMode2 := Query.FieldByName('StdMode').AsInteger;
        StdItem.Shape := Query.FieldByName('Shape').AsInteger;
        StdItem.Weight := Query.FieldByName('Weight').AsInteger;
        StdItem.AniCount := Query.FieldByName('AniCount').AsInteger;
        StdItem.Source := Query.FieldByName('Source').AsInteger;
        StdItem.Reserved := Query.FieldByName('Reserved').AsInteger;
        StdItem.Looks := Query.FieldByName('Looks').AsInteger;
        StdItem.Effect := Query.FieldByName('Effect').AsInteger;
        StdItem.DuraMax := Query.FieldByName('DuraMax').AsInteger;
        StdItem.nAC := Query.FieldByName('AC').AsInteger;
        StdItem.nAC2 := Query.FieldByName('AC2').AsInteger;
        StdItem.nMAC := Query.FieldByName('MAC').AsInteger;
        StdItem.nMAC2 := Query.FieldByName('MAC2').AsInteger;
        StdItem.nDC := Query.FieldByName('DC').AsInteger;
        StdItem.nDC2 := Query.FieldByName('DC2').AsInteger;
        StdItem.nMC := Query.FieldByName('MC').AsInteger;
        StdItem.nMC2 := Query.FieldByName('MC2').AsInteger;
        StdItem.nSC := Query.FieldByName('SC').AsInteger;
        StdItem.nSC2 := Query.FieldByName('SC2').AsInteger;
        StdItem.HP := Query.FieldByName('HP').AsInteger;
        StdItem.MP := Query.FieldByName('MP').AsInteger;
        StdItem.AddAttack := Query.FieldByName('AddDamage').AsInteger;
        StdItem.DelDamage := Query.FieldByName('DelDamage').AsInteger;
        StdItem.HitPoint := Query.FieldByName('HitPoint').AsInteger;
        StdItem.SpeedPoint := Query.FieldByName('SpeedPoint').AsInteger;
        StdItem.Strong := Query.FieldByName('Strong').AsInteger;
        StdItem.Luck := Query.FieldByName('Luck').AsInteger;
        StdItem.HitSpeed := Query.FieldByName('HitSpeed').AsInteger;
        StdItem.AntiMagic := Query.FieldByName('AntiMagic').AsInteger;
        StdItem.PoisonMagic := Query.FieldByName('PoisonMagic').AsInteger;
        StdItem.HealthRecover := Query.FieldByName('HealthRecover').AsInteger;
        StdItem.SpellRecover := Query.FieldByName('SpellRecover').AsInteger;
        StdItem.PoisonRecover := Query.FieldByName('PoisonRecover').AsInteger;
        StdItem.Color := Query.FieldByName('Color').AsInteger;
        wBind := Query.FieldByName('Bind').AsInteger;
        StdItem.Bind := 0;
        for k := 0 to 7 do
          SetByteStatus(StdItem.Bind, k, CheckIntStatus(wBind, k));
        //StdItem.Bind := Query.FieldByName('Bind').AsInteger;
        //StdItem.AddWuXinAttack := Query.FieldByName('AddWuXinAttack').AsInteger;
        //StdItem.DelWuXinAttack := Query.FieldByName('DelWuXinAttack').AsInteger;
        StdItem.AddWuXinAttack := 0;
        StdItem.DelWuXinAttack := 0;
        StdItem.StdMode := GetItemType(StdItem.StdMode2);
        StdItem.StdModeEx := GetItemTypeEx(StdItem.StdMode);
        StdItem.Need := Query.FieldByName('Need').AsInteger;
        StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;
        StdItem.Price := Query.FieldByName('Price').AsInteger;
        StdItem.NeedIdentify := GetGameLogItemNameList(StdItem.Name);
        StdItem.SetItemList := nil;
        if sm_Superposition in StdItem.StdModeEx then
          if StdItem.DuraMax < 1 then
            StdItem.DuraMax := 1;

        if UserEngine.StdItemList.Count = Idx then begin
          //Stditem.Rule := GetRuleItem(StdItem.Name);
          New(pTItemRule(Stditem.Rule));
          SafeFillChar(Stditem.Rule^, SizeOf(TItemRule), #0);
          New(StdItemLimit);
          StdItemLimit.MonDropLimit := GetMonDropLimitByName(StdItem.Name);
          UserEngine.StdItemList.Add(StdItem);
          UserEngine.StdItemLimitList.Add(StdItemLimit);

          ClientStditem.StdItem := StdItem^;
          ClientStditem.isShow := CheckIntStatus(wBind, II_Publicity);
          ClientStditem.sDesc := Query.FieldByName('Text').AsString;
          ClientStditem.Filtrate.boShow := CheckIntStatus(wBind, II_Show);
          ClientStditem.Filtrate.boPickUp := CheckIntStatus(wBind, II_PickUp);
          ClientStditem.Filtrate.boColor := CheckIntStatus(wBind, II_Color);
          ClientStditem.Filtrate.boHint := CheckIntStatus(wBind, II_Hint);
          Move(ClientStditem.sDesc[0], ClientStditem.StdItem.NeedIdentify, 1);
          ClientItemStr := ClientItemStr + EncodeBuffer(@ClientStditem, SizeOf(TClientStditem) - 256);
          if ClientStditem.StdItem.NeedIdentify > 0 then begin
            ClientItemStr := ClientItemStr + EncodeString(ClientStditem.sDesc);
          end;
          Result := 1;
        end
        else begin
          Dispose(StdItem);
          Memo.Lines.Add(format('加载物品(Idx:%d Name:%s)数据失败.', [Idx, StdItem.Name]));
          Result := -100;
          Exit;
        end;
        Query.Next;
      end;
      g_boGameLogGold := GetGameLogItemNameList(sSTRING_GOLDNAME) = 1;
      g_boGameLogBindGold := GetGameLogItemNameList(sSTRING_BINDGOLDNAME) = 1;
      g_boGameLogHumanDie := GetGameLogItemNameList(g_sHumanDieEvent) = 1;
      g_boGameLogGameGold := GetGameLogItemNameList(sSTRING_GAMEGOLD) = 1;
      g_boGameLogGamePoint := GetGameLogItemNameList(sSTRING_GAMEPOINT) = 1;
      g_boGameLogGameDiamond := GetGameLogItemNameList(sSTRING_GAMEDIAMOND) = 1;
      g_boGameLogCreditPoint := GetGameLogItemNameList(sSTRING_CREDITPOINT) = 1;
      g_boGameLogCustomVariable := GetGameLogItemNameList(sSTRING_CUSTOMVARIABLE) = 1;

      OutLen := ZIPCompress(PChar(ClientItemStr), Length(ClientItemStr), 9, OutBuffer);
      if OutLen > 0 then begin
        //MainOutmessage(IntToStr(OutLen));
        g_nItemDataLen := OutLen;
        g_sItemDataMD5 := GetMD5TextByBuffer(OutBuffer, OutLen);
        g_sItemData := EncodeLongBuffer(OutBuffer, OutLen);
        FreeMem(OutBuffer);
      end;
    finally
      Query.Close;
    end;
    LoadRuleItemList();
    LoadSetItems();
    LoadCompoundInfoList();
    for i := 0 to UserEngine.StdItemList.Count - 1 do begin
      StdItem := pTStdItem(UserEngine.StdItemList.Items[i]);
      StdItem.SetItemList := GetSetItem(StdItem.Name);
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TFrmDB.LoadListCall(sLoadName: string; var LoadList: TStringList);
  function LoadCallList(sFileName, sLabel: string; nIdx: Integer; var List: TStringList): Boolean;
  var
    i: Integer;
    LoadStrList: TStringList;
    bo1D: Boolean;
    s18: string;
  begin
    Result := False;
    if MyFileExists(sFileName) then begin
      LoadStrList := TMsgStringList.Create;
      LoadStrList.LoadFromFile(sFileName);
      DeCodeStringList(LoadStrList);
      sLabel := '[' + sLabel + ']';
      bo1D := False;
      for i := 0 to LoadStrList.Count - 1 do begin
        s18 := Trim(LoadStrList.Strings[i]);
        if s18 <> '' then begin
          if not bo1D then begin
            if (s18[1] = '[') and (CompareText(s18, sLabel) = 0) then begin
              bo1D := True;
              //List.Add(s18);
            end;
          end
          else begin
            if s18 <> '{' then begin
              if s18 = '}' then begin
                //bo1D := False;
                Result := True;
                break;
              end
              else begin
                //List.Add(s18);
                List.Insert(nIdx, s18);
                Inc(nIdx);
              end;
            end;
          end;
        end; //00489CE4 if s18 <> '' then begin
      end; // for I := 0 to LoadStrList.Count - 1 do begin
      LoadStrList.Free;
    end;
  end;
var
  i: Integer;
  s14, s18, s1C, s20, s34: string;
  Ing, nIdx, nCount: Integer;
  CallNameList: TStringList;
  //ScriptNameList: TStringList;
begin
  i := 0;
  Ing := 0;
  //ScriptNameList := TMsgStringList.Create;
  CallNameList := TStringList.Create;
  while (I < LoadList.Count) do begin //Jason 071209修改
    if Ing > 5000 then begin
      MainOutMessage('#CALL调用死循环 ' + sLoadName);
      break;
    end;
    s14 := Trim(LoadList.Strings[i]);
    if (s14 <> '') and (s14[1] = '#') and (CompareLStr(s14, '#CALL', Length('#CALL'))) then begin
      Inc(Ing);
      s14 := ArrestStringEx(s14, '[', ']', s1C);
      s20 := Trim(s1C);
      s18 := Trim(s14);
      if s20[1] = '\' then
        s20 := Copy(s20, 2, Length(s20) - 1);
      if s20[2] = '\' then
        s20 := Copy(s20, 3, Length(s20) - 2);
      s34 := g_Config.sEnvirDir + 'QuestDiary\' + s20;
      LoadList.Strings[i] := '';

      nIdx := CallNameList.IndexOf(s20 + '*' + s18);
      if nIdx > -1 then begin
        nCount := Integer(CallNameList.Objects[nIdx]);
        Inc(nCount);
        if nCount > 100 then begin
          MainOutMessage('#CALL调用死循环 ' + sLoadName + ' ' + s20 + ' ' + s18);
          break;
        end;
        CallNameList.Objects[nIdx] := TObject(nCount);
      end
      else
        CallNameList.AddObject(s20 + '*' + s18, nil);

      //if CallNameList.IndexOf(s20 + '*' + s18) = -1 then begin
        //CallNameList.Add(s20 + '*' + s18);
      if not LoadCallList(s34, s18, I + 1, LoadList) then begin
        MainOutMessage('加载文件错误, load fail: ' + s20 + ' ' + s18);
      end;
      //end;// else
        //MainOutMessage('脚本重复调用: ' + s20 + ' ' + s18);
    end;
    Inc(I);
  end;
  CallNameList.Free;
  //ScriptNameList.Free;
end;

function TFrmDB.LoadMagicDB(): Integer;
var
  i: Integer;
  Magic: pTMagic;
  nIdx: Integer;
  ClientDefMagic: TClientDefMagic;
  ClientStr: string;
  OutBuffer: PChar;
  OutLen: Integer;
resourcestring
  sSQLString = 'select * from Magic';
begin
  //  Result := -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -2;
    end;
    Result := 0;
    ClientStr := '';
    g_sMagicData := '';
    g_sMagicDataMD5 := '';
    g_nMagicDataLen := 0;
    for i := 0 to Query.RecordCount - 1 do begin
      FillChar(ClientDefMagic, SizeOf(TClientDefMagic), #0);
      nIdx := Query.FieldByName('MagId').AsInteger;
      if nIdx in [Low(UserEngine.m_MagicArr)..High(UserEngine.m_MagicArr)] then
      begin
        Magic := @UserEngine.m_MagicArr[nIdx];
        Magic.wMagicId := nIdx;
        Magic.wCopy := Query.FieldByName('Copy').AsInteger;
        Magic.sMagicName := Query.FieldByName('MagName').AsString;
        Magic.btEffectType := Query.FieldByName('EffectType').AsInteger;
        Magic.btEffect := Query.FieldByName('Effect').AsInteger;
        Magic.wMagicIcon := Query.FieldByName('MagicIcon').AsInteger;
        Magic.btJob := Query.FieldByName('Job').AsInteger;
        Magic.dwDelayTime := Query.FieldByName('Delay').AsInteger;
        Magic.nInterval := Query.FieldByName('Interval').AsInteger;
        Magic.nSpellFrame := Query.FieldByName('SpellFrame').AsInteger;
        Magic.wSpell := Query.FieldByName('Spell').AsInteger;
        Magic.btDefSpell := Query.FieldByName('DefSpell').AsInteger;
        Magic.wPower := Query.FieldByName('Power').AsInteger;
        Magic.wMaxPower := Query.FieldByName('MaxPower').AsInteger;
        Magic.btDefPower := Query.FieldByName('DefPower').AsInteger;
        Magic.btDefMaxPower := Query.FieldByName('DefMaxPower').AsInteger;
        Magic.TrainLevel[0] := Query.FieldByName('NeedL1').AsInteger;
        Magic.TrainLevel[1] := Query.FieldByName('NeedL2').AsInteger;
        Magic.TrainLevel[2] := Query.FieldByName('NeedL3').AsInteger;
        Magic.TrainLevel[3] := Query.FieldByName('NeedL4').AsInteger;
        Magic.TrainLevel[4] := Query.FieldByName('NeedL5').AsInteger;
        Magic.TrainLevel[5] := Query.FieldByName('NeedL6').AsInteger;
        Magic.TrainLevel[6] := Query.FieldByName('NeedL7').AsInteger;
        Magic.TrainLevel[7] := Query.FieldByName('NeedL8').AsInteger;
        Magic.TrainLevel[8] := Query.FieldByName('NeedL9').AsInteger;
        Magic.TrainLevel[9] := Query.FieldByName('NeedL10').AsInteger;
        Magic.TrainLevel[10] := Query.FieldByName('NeedL11').AsInteger;
        Magic.TrainLevel[11] := Query.FieldByName('NeedL12').AsInteger;
        Magic.TrainLevel[12] := Query.FieldByName('NeedL13').AsInteger;
        Magic.TrainLevel[13] := Query.FieldByName('NeedL14').AsInteger;
        Magic.TrainLevel[14] := Query.FieldByName('NeedL15').AsInteger;
        Magic.TrainLevel[15] := Query.FieldByName('NeedL16').AsInteger;
        Magic.TrainLevel[16] := Query.FieldByName('NeedL17').AsInteger;
        Magic.TrainLevel[17] := Query.FieldByName('NeedL18').AsInteger;
        Magic.TrainLevel[18] := Query.FieldByName('NeedL19').AsInteger;
        Magic.TrainLevel[19] := Query.FieldByName('NeedL19').AsInteger;
        Magic.MaxTrain[0] := Query.FieldByName('L1Train').AsInteger;
        Magic.MaxTrain[1] := Query.FieldByName('L2Train').AsInteger;
        Magic.MaxTrain[2] := Query.FieldByName('L3Train').AsInteger;
        Magic.MaxTrain[3] := Query.FieldByName('L4Train').AsInteger;
        Magic.MaxTrain[4] := Query.FieldByName('L5Train').AsInteger;
        Magic.MaxTrain[5] := Query.FieldByName('L6Train').AsInteger;
        Magic.MaxTrain[6] := Query.FieldByName('L7Train').AsInteger;
        Magic.MaxTrain[7] := Query.FieldByName('L8Train').AsInteger;
        Magic.MaxTrain[8] := Query.FieldByName('L9Train').AsInteger;
        Magic.MaxTrain[9] := Query.FieldByName('L10Train').AsInteger;
        Magic.MaxTrain[10] := Query.FieldByName('L11Train').AsInteger;
        Magic.MaxTrain[11] := Query.FieldByName('L12Train').AsInteger;
        Magic.MaxTrain[12] := Query.FieldByName('L13Train').AsInteger;
        Magic.MaxTrain[13] := Query.FieldByName('L14Train').AsInteger;
        Magic.MaxTrain[14] := Query.FieldByName('L15Train').AsInteger;
        Magic.MaxTrain[15] := Query.FieldByName('L16Train').AsInteger;
        Magic.MaxTrain[16] := Query.FieldByName('L17Train').AsInteger;
        Magic.MaxTrain[17] := Query.FieldByName('L18Train').AsInteger;
        Magic.MaxTrain[18] := Query.FieldByName('L19Train').AsInteger;
        Magic.MaxTrain[19] := Query.FieldByName('L19Train').AsInteger;
        Magic.btTrainLv := Query.FieldByName('NeedMax').AsInteger;
        Magic.MagicMode := GetMagicType(Magic.wMagicId);
        if Magic.wCopy > 0 then
        begin
          Magic.MagicMode := GetMagicType(Magic.wCopy);
        end;

        ClientDefMagic.Magic := Magic^;
        ClientDefMagic.sDesc := Query.FieldByName('Text').AsString;
        ClientDefMagic.isShow := Query.FieldByName('Bind').AsInteger <> 0;
        Move(ClientDefMagic.sDesc[0], ClientDefMagic.Magic.MagicMode, 1);
        ClientStr := ClientStr + EncodeBuffer(@ClientDefMagic, SizeOf(TClientDefMagic) - 256);
        if Byte(ClientDefMagic.Magic.MagicMode) > 0 then
        begin
          ClientStr := ClientStr + EncodeString(ClientDefMagic.sDesc);
        end;
      end;
      Inc(Result);
      Query.Next;
    end;

    OutLen := ZIPCompress(PChar(ClientStr), Length(ClientStr), 9, OutBuffer);
    if OutLen > 0 then begin
      //MainOutmessage(IntToStr(OutLen));
      g_nMagicDataLen := OutLen;
      g_sMagicDataMD5 := GetMD5TextByBuffer(OutBuffer, OutLen);
      g_sMagicData := EncodeLongBuffer(OutBuffer, OutLen);
      FreeMem(OutBuffer);
    end;

    Query.Close;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadBoxs(): Integer;
  procedure ChangeItemValue(const UserItem: pTUserItem; StdItem: pTStdItem; sValue: string);
  var
    sTemp, sStr: string;
    n1, n2, n3: Integer;
  begin
    while True do begin
      if sValue = '' then
        break;
      sValue := GetValidStr3(sValue, sTemp, [',', ' ']);
      if sTemp = '' then
        break;
      sTemp := GetValidStr3(sTemp, sStr, ['.']);
      n1 := StrToIntDef(sStr, -1);
      sTemp := GetValidStr3(sTemp, sStr, ['.']);
      n2 := StrToIntDef(sStr, -1);
      sTemp := GetValidStr3(sTemp, sStr, ['.']);
      n3 := StrToIntDef(sStr, 0);
      if Stditem.StdMode = tm_House then begin
        case n1 of
          1: begin
              if CompareText(sStr, 'HOUR') = 0 then DateTimeToLongWord(IncHour(Now, n2))
              else UserItem.TermTime := DateTimeToLongWord(IncDay(Now, n2));
            end;
          2: begin
              case n2 of
                0: SetByteStatus(UserItem.btBindMode1, 0, n3 = 1);
                1: SetByteStatus(UserItem.btBindMode1, 1, n3 = 1);
                2: SetByteStatus(UserItem.btBindMode1, 2, n3 = 1);
                3: SetByteStatus(UserItem.btBindMode1, 3, n3 = 1);
                4: SetByteStatus(UserItem.btBindMode1, 4, n3 = 1);
                5: SetByteStatus(UserItem.btBindMode1, 5, n3 = 1);
                6: SetByteStatus(UserItem.btBindMode1, 6, n3 = 1);
                7: SetByteStatus(UserItem.btBindMode1, 7, n3 = 1);
                8: SetByteStatus(UserItem.btBindMode2, 0, n3 = 1);
              end;
            end;
          10: UserItem.btLevel := n2;
          11: UserItem.dwExp := n2;
        end;
      end else begin
        case n1 of
          0: begin
              UserItem.DuraMax := n2;
            end;
          1: begin
              if CompareText(sStr, 'HOUR') = 0 then UserItem.TermTime := DateTimeToLongWord(IncHour(Now, n2))
              else UserItem.TermTime := DateTimeToLongWord(IncDay(Now, n2));
            end;
          2: begin
              case n2 of
                0: SetByteStatus(UserItem.btBindMode1, 0, n3 = 1);
                1: SetByteStatus(UserItem.btBindMode1, 1, n3 = 1);
                2: SetByteStatus(UserItem.btBindMode1, 2, n3 = 1);
                3: SetByteStatus(UserItem.btBindMode1, 3, n3 = 1);
                4: SetByteStatus(UserItem.btBindMode1, 4, n3 = 1);
                5: SetByteStatus(UserItem.btBindMode1, 5, n3 = 1);
                6: SetByteStatus(UserItem.btBindMode1, 6, n3 = 1);
                7: SetByteStatus(UserItem.btBindMode1, 7, n3 = 1);
                8: SetByteStatus(UserItem.btBindMode2, 0, n3 = 1);
              end;
            end;
          3: begin
              if n2 in [0..5] then
                UserItem.Value.btWuXin := n2;
            end;
          4: begin
              if n2 in [0..3] then
                UserItem.Value.btFluteCount := n2;
            end;
          5: begin
              if n2 in [0, 3, 6, 9, 12, 15, 18] then //CanStrengthenMax
                UserItem.Value.StrengthenInfo.btCanStrengthenCount := n2;
            end;
          6: begin
              case n2 of
                0: begin
                    if n3 in [0..(CanStrengthenMax[0] - 1)] then
                      UserItem.Value.StrengthenInfo.btStrengthenInfo[0] := n3;
                  end;
                1: begin
                    if n3 in [0..(CanStrengthenMax[1] - 1)] then
                      UserItem.Value.StrengthenInfo.btStrengthenInfo[1] := n3;
                  end;
                2: begin
                    if n3 in [0..(CanStrengthenMax[2] - 1)] then
                      UserItem.Value.StrengthenInfo.btStrengthenInfo[2] := n3;
                  end;
                3: begin
                    if n3 in [0..(CanStrengthenMax[3] - 1)] then
                      UserItem.Value.StrengthenInfo.btStrengthenInfo[3] := n3;
                  end;
                4: begin
                    if n3 in [0..(CanStrengthenMax[4] - 1)] then
                      UserItem.Value.StrengthenInfo.btStrengthenInfo[4] := n3;
                  end;
                5: begin
                    if n3 in [0..(CanStrengthenMax[5] - 1)] then
                      UserItem.Value.StrengthenInfo.btStrengthenInfo[5] := n3;
                  end;
              end;
            end;
          7: begin
              if n2 in [Low(TUserItemValueArray)..High(TUserItemValueArray)] then begin
                UserItem.Value.btValue[n2] := Byte(n3);
              end
              else if n2 = 27 then begin
                UserItem.EffectValue.btColor := n3;
              end
              else if n2 = 28 then begin
                UserItem.EffectValue.btEffect := n3;
              end;
            end;
          9: begin
              if n2 <= 18 then
                UserItem.Value.StrengthenInfo.btStrengthenCount := _MIN(n2, UserItem.Value.StrengthenInfo.btCanStrengthenCount);

            end;
        end;
      end;
    end;
  end;
  function LoadBoxInfo(nIndex: Integer): pTBoxInfo;
  var
    LoadList: TStringList;
    sFileName, sStr, sTemp, sName, sCount, sValue, sType: string;
    I, nCount, nType: Integer;
    boReadHeader: Boolean;
    BoxInfo: pTBoxInfo;
    BoxItemInfo: pTBoxItemInfo;
    StdItem: pTStdItem;
  begin
    Result := nil;
    BoxInfo := nil;
    boReadHeader := False;
    sFileName := g_Config.sEnvirDir + RSADecodeString('ba9FoJaLQbWB7qBlqa') + IntToStr(nIndex) + '.txt'; //'box.txt'
    if MyFileExists(sFileName) then begin
      LoadList := TMsgStringList.Create;
      LoadList.LoadFromFile(sFileName);
      LoadListCall(ExtractFileName(sFileName), LoadList);
      try
        for I := 0 to LoadList.Count - 1 do begin
          sStr := Trim(LoadList[I]);
          if (sStr <> '') and (sStr[1] <> ';') then begin
            if not boReadHeader then begin
              New(BoxInfo);
              SafeFillChar(BoxInfo^, SizeOf(TBoxInfo), #0);
              BoxInfo.ItemList[0] := TList.Create;
              BoxInfo.ItemList[1] := TList.Create;
              BoxInfo.ItemList[2] := TList.Create;
              BoxInfo.ItemList[3] := TList.Create;
              BoxInfo.ItemList[4] := TList.Create;
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[0].btRate := StrToIntDef(sTemp, -1);
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[0].nGold := StrToIntDef(sTemp, -1);
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[0].nGameGold := StrToIntDef(sTemp, -1);
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[1].btRate := StrToIntDef(sTemp, -1);
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[1].nGold := StrToIntDef(sTemp, -1);
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[1].nGameGold := StrToIntDef(sTemp, -1);
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[2].btRate := StrToIntDef(sTemp, -1);
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[2].nGold := StrToIntDef(sTemp, -1);
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[2].nGameGold := StrToIntDef(sTemp, -1);
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[3].btRate := StrToIntDef(sTemp, -1);
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[3].nGold := StrToIntDef(sTemp, -1);
              sStr := GetValidStr3(sStr, sTemp, [' ', '/', #9]);
              BoxInfo.GoldInfo[3].nGameGold := StrToIntDef(sTemp, -1);
              if (BoxInfo.GoldInfo[3].nGameGold >= 0) then begin
                boReadHeader := True;
              end
              else
                Break;
            end
            else begin
              sStr := GetValidStr3(sStr, sType, [' ', '/', #9]);
              sStr := GetValidStr3(sStr, sName, [' ', '/', #9]);
              sStr := GetValidStr3(sStr, sCount, [' ', '/', #9]);
              sStr := GetValidStr3(sStr, sValue, [' ', '/', #9]);
              nCount := StrToIntDef(sCount, 1);
              nType := StrToIntDef(sType, -1);
              if (nType in [0..4]) and (sName <> '') and (nCount > 0) then begin
                BoxItemInfo := nil;
                if CompareText(sName, '经验值') = 0 then begin
                  New(BoxItemInfo);
                  SafeFillChar(BoxItemInfo^, SizeOf(TBoxItemInfo), #0);
                  BoxItemInfo.ItemType := bit_Exp;
                  BoxItemInfo.Item.MakeIndex := nCount;
                end
                else if CompareText(sName, '金币') = 0 then begin
                  New(BoxItemInfo);
                  SafeFillChar(BoxItemInfo^, SizeOf(TBoxItemInfo), #0);
                  BoxItemInfo.ItemType := bit_Gold;
                  BoxItemInfo.Item.MakeIndex := nCount;
                end
                else if CompareText(sName, '元宝') = 0 then begin
                  New(BoxItemInfo);
                  SafeFillChar(BoxItemInfo^, SizeOf(TBoxItemInfo), #0);
                  BoxItemInfo.ItemType := bit_GameGold;
                  BoxItemInfo.Item.MakeIndex := nCount;
                end
                else if CompareText(sName, '绑定金币') = 0 then begin
                  New(BoxItemInfo);
                  SafeFillChar(BoxItemInfo^, SizeOf(TBoxItemInfo), #0);
                  BoxItemInfo.ItemType := bit_BindGold;
                  BoxItemInfo.Item.MakeIndex := nCount;
                end
                else begin
                  StdItem := UserEngine.GetStdItem(sName);
                  if StdItem <> nil then begin
                    New(BoxItemInfo);
                    SafeFillChar(BoxItemInfo^, SizeOf(TBoxItemInfo), #0);
                    BoxItemInfo.ItemType := bit_Item;
                    BoxItemInfo.Item.wIndex := StdItem.Idx + 1;
                    if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then
                      BoxItemInfo.Item.Dura := _MIN(nCount, High(Word))
                    else
                      BoxItemInfo.Item.Dura := StdItem.DuraMax;
                    BoxItemInfo.Item.DuraMax := StdItem.DuraMax;
                    ChangeItemValue(@BoxItemInfo.Item, StdItem, sValue);
                  end;
                end;
                if BoxItemInfo <> nil then begin
                  BoxInfo.ItemList[nType].Add(BoxItemInfo);
                end
                else begin
                  FrmMain.MemoLog.Lines.Add('加载宝箱数据[' + IntToStr(nIndex) + '.txt]物品[' + sName + ']失败！');
                  break;
                end;
              end
              else begin
                FrmMain.MemoLog.Lines.Add('加载宝箱数据[' + IntToStr(nIndex) + '.txt]物品[' + sName + ']失败！');
                break;
              end;
            end;
          end;
        end;
        if (BoxInfo <> nil) and (boReadHeader) and (BoxInfo.ItemList[0].Count > 0) and
          (BoxInfo.ItemList[1].Count > 0) and (BoxInfo.ItemList[2].Count > 0) and
          (BoxInfo.ItemList[3].Count > 0) and (BoxInfo.ItemList[4].Count > 0) then begin
          Result := BoxInfo;
        end
        else
          FrmMain.MemoLog.Lines.Add('加载宝箱数据[' + IntToStr(nIndex) + '.txt]失败！');
      finally
        LoadList.Free;
      end;
    end;
  end;
var
  LoadList: TStringList;
  sFileName, sName: string;
  BoxInfo: pTBoxInfo;
  BoxItemInfo: pTBoxItemInfo;
  I: Integer;
begin
  Result := 0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    sFileName := g_Config.sEnvirDir + RSADecodeString('uNAee9FOoy53RI3B'); //'BoxList.txt'
    for BoxInfo in g_BoxsList do begin
      for I := Low(BoxInfo.ItemList) to High(BoxInfo.ItemList) do begin
        for BoxItemInfo in BoxInfo.ItemList[I] do
          Dispose(BoxItemInfo);
        BoxInfo.ItemList[I].Free;
      end;
      Dispose(BoxInfo);
    end;
    g_BoxsList.Clear;
    if MyFileExists(sFileName) then begin
      LoadList := TMsgStringList.Create;
      LoadList.LoadFromFile(sFileName);
      LoadListCall(ExtractFileName(sFileName), LoadList);
      try
        for sName in LoadList do begin
          if (sName <> '') and (sName[1] <> ';') then begin
            if Result = StrToIntDef(sName, -1) then begin
              BoxInfo := LoadBoxInfo(Result);
              if BoxInfo = nil then begin
                Result := -Result - 1;
                break;
              end;
              g_BoxsList.Add(BoxInfo);
              Inc(Result);
            end
            else begin
              Result := -Result - 1;
              break;
            end;
          end;
        end;
      finally
        LoadList.Free;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TFrmDB.LoadUserCmd;
var
  sFileName, sLineText, sUserCmd, sCmdNo: string;
  I, nCmdNo: Integer;
  LoadList: TStringList;
begin
  g_UserCmdList.Lock;
  Try
    g_UserCmdList.Clear;
  Finally
    g_UserCmdList.UnLock;
  End;
  sFileName := g_Config.sEnvirDir + 'UserCmd.txt';
  LoadList := TStringList.Create();
  if not FileExists(sFileName) then begin
    LoadList.Add(';自定义GM命令配置文件');
    LoadList.Add(';命令名称'#9'对应编号');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    exit;
  end;
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sUserCmd, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCmdNo, [' ', #9]);
      nCmdNo := StrToIntDef(sCmdNo, -1);
      if (sUserCmd <> '') and (nCmdNo >= 0) then begin
        g_UserCmdList.Lock;
        Try
          g_UserCmdList.AddObject(sUserCmd, TObject(nCmdNo));
        Finally
          g_UserCmdList.UnLock;
        End;
      end;
    end;
  end;
  LoadList.Free;
end;

function TFrmDB.LoadMakeMagic(): Integer;
var
  I, k, nIdx, nLevel: Integer;
  MakeGoods: pTMakeGoods;
  MakeItem: pTMakeItem;
  LoadList: TStringList;
  sFileName, s18, s34, s48, sIdx, sName, sLevel, sHumLevel: string;
  Stditem: pTStditem;
  PackMakeItem: array of TPackMakeItem;
  nCount, nAddCount, OutLen, nHumLevel: Integer;
  OutBuf: PChar;
begin
  Result := 0;
  for I := Low(g_MakeMagicList) to High(g_MakeMagicList) do begin
    for k := 0 to g_MakeMagicList[I].Count - 1 do begin
      Dispose(pTMakeGoods(g_MakeMagicList[I][k]));
    end;
    g_MakeMagicList[I].Clear;
  end;
  nCount := 0;
  sFileName := g_Config.sEnvirDir + 'MakeMagic.txt'; //'MakeItem.txt'
  if MyFileExists(sFileName) then begin
    LoadList := TMsgStringList.Create;
    LoadList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), LoadList);
    for i := 0 to LoadList.Count - 1 do begin
      s18 := Trim(LoadList.Strings[i]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        s18 := GetValidStrCap(s18, sIdx, [' ', #9]);
        s18 := GetValidStrCap(s18, sLevel, [' ', #9]);
        s34 := GetValidStrCap(s18, sHumLevel, [' ', #9]);
        nIdx := StrToIntDef(sIdx, -1);
        nLevel := StrToIntDef(sLevel, -1);
        nHumLevel := StrToIntDef(sHumLevel, -1);
        if (nIdx in [Low(g_MakeMagicList)..High(g_MakeMagicList)]) and (nLevel >= 0) and (nHumLevel >= 0) then begin
          sName := Trim(s34);
          while True do begin
            if s34 = '' then
              break;
            s34 := GetValidStrCap(s34, s48, [' ', #9]);
            if s48 = '' then
              break;
            if s48[1] <> '$' then
              break;
          end;
          if (s48 <> '') then begin
            StdItem := UserEngine.GetStdItem(s48);
            if Stditem <> nil then begin
              MakeItem := GetMakeItemInfo(StdItem.Idx + 1);
              if MakeItem <> nil then begin
                New(MakeGoods);
                MakeGoods.sName := sName;
                MakeGoods.btLevel := nLevel;
                MakeGoods.wLevel := nHumLevel;
                MakeGoods.MakeItem := MakeItem^;
                MakeGoods.MakeItem.wIdx := g_MakeMagicList[nIdx].Add(MakeGoods);
                Inc(nCount);
              end;
            end;
          end;
        end;
      end;
    end;
    LoadList.Free;
  end;
  g_nMakeMagicDataLen := 0;
  g_sMakeMagicDataMD5 := '';
  g_sMakeMagicData := '';
  g_nMakeMagicCount := 0;
  if nCount > 0 then begin
    SetLength(PackMakeItem, nCount);
    nAddCount := 0;
    for I := Low(g_MakeMagicList) to High(g_MakeMagicList) do begin
      for k := 0 to g_MakeMagicList[I].Count - 1 do begin
        if nAddCount >= nCount then begin
          Result := -1;
          Exit;
        end;
        PackMakeItem[nAddCount].btIdx := I;
        PackMakeItem[nAddCount].btLevel := pTMakeGoods(g_MakeMagicList[I][k]).btLevel;
        PackMakeItem[nAddCount].wLevel := pTMakeGoods(g_MakeMagicList[I][k]).wLevel;
        PackMakeItem[nAddCount].sName := pTMakeGoods(g_MakeMagicList[I][k]).sName;
        PackMakeItem[nAddCount].MakeItem := pTMakeGoods(g_MakeMagicList[I][k]).MakeItem;
        Inc(nAddCount);
      end;
    end;
    OutLen := ZIPCompress(@PackMakeItem[0], SizeOf(TPackMakeItem) * nCount, 9, OutBuf);
    if OutLen > 0 then begin
      g_nMakeMagicCount := nCount;
      g_nMakeMagicDataLen := OutLen;
      g_sMakeMagicDataMD5 := GetMD5TextByBuffer(OutBuf, OutLen);
      g_sMakeMagicData := EncodeLongBuffer(OutBuf, OutLen);
      FreeMem(OutBuf);
    end;
    PackMakeItem := nil;
  end;
end;

function TFrmDB.LoadMakeItem(): Integer; //00488CDC
var
  i, nMoney, nRate, nMaxRate, II: Integer;
  s18, s20, s24, sMoney, sRate, sMaxRate, sNotGet: string;
  LoadList: TStringList;
  sFileName: string;
  StdItem: pTStdItem;
  MakeItem: pTMakeItem;
begin
  Result := -1;
  if g_MakeItemList.Count > 0 then begin
    for i := 0 to g_MakeItemList.Count - 1 do begin
      MakeItem := g_MakeItemList[i];
      Dispose(MakeItem);
    end;
    g_MakeItemList.Clear;
  end;
  sFileName := g_Config.sEnvirDir + RSADecodeString('AcIADfibOyWjmNj1Zq'); //'MakeItem.txt'
  if MyFileExists(sFileName) then begin
    LoadList := TMsgStringList.Create;
    LoadList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), LoadList);
    MakeItem := nil;
    s24 := '';
    for i := 0 to LoadList.Count - 1 do begin
      s18 := Trim(LoadList.Strings[i]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        if s18[1] = '[' then begin
          if MakeItem <> nil then begin
            g_MakeItemList.Add(MakeItem);
            MakeItem := nil;
          end;
          s18 := ArrestStringEx(s18, '[', ']', s24);
          s18 := GetValidStr3(s18, sMoney, [' ', #9]);
          s18 := GetValidStr3(s18, sRate, [' ', #9]);
          s18 := GetValidStr3(s18, sMaxRate, [' ', #9]);
          nMoney := StrToIntDef(sMoney, -1);
          nRate := StrTointDef(sRate, -1);
          nMaxRate := StrTointDef(sMaxRate, -1);
          StdItem := UserEngine.GetStdItem(s24);
          if (nMoney > 0) and (nRate > 0) and (nMaxRate > 0) and (nMaxRate >= nRate) and (StdItem <> nil) then begin
            New(MakeItem);
            SafeFillChar(MakeItem^, SizeOf(TMakeItem), #0);
            MakeItem.ItemArr[0].wIdent := StdItem.Idx + 1;
            MakeItem.ItemArr[0].wCount := 1;
            MakeItem.nMoney := nMoney;
            MakeItem.btRate := nRate;
            MakeItem.btMaxRate := nMaxRate;
          end
          else begin
            MainOutMessage('加载打造物品失败: ' + s24 + ' 不存在或信息不正确！');
          end;
        end
        else begin
          if MakeItem <> nil then begin
            s18 := GetValidStr3(s18, s20, [' ', #9]);
            s20 := Trim(s20);
            if (s20 <> '') then begin
              s18 := GetValidStr3(s18, sMoney, [' ', #9]);
              s18 := GetValidStr3(s18, sRate, [' ', #9]);
              s18 := GetValidStr3(s18, sNotGet, [' ', #9]);
              nMoney := StrToIntDef(sMoney, -1);
              nRate := StrTointDef(sRate, -1);
              StdItem := UserEngine.GetStdItem(s20);
              if (StdItem <> nil) and (nMoney > 0) then begin
                for II := 1 to 5 do begin
                  if MakeItem.ItemArr[II].wIdent = 0 then begin
                    MakeItem.ItemArr[nRate].wIdent := StdItem.Idx + 1;
                    MakeItem.ItemArr[nRate].boNotGet := (sNotGet = '1');
                    if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then
                      MakeItem.ItemArr[nRate].wCount := nMoney
                    else
                      MakeItem.ItemArr[nRate].wCount := 1;
                    break;
                  end;
                end;
              end
              else begin
                MainOutMessage('加载打造材料失败: ' + s20 + ' 不存在或参数不正确！');
                Dispose(MakeItem);
                MakeItem := nil;
              end;
            end;
          end;
        end;
      end;
    end; // for
    if MakeItem <> nil then
      g_MakeItemList.Add(MakeItem);
    LoadList.Free;
    Result := 1;
  end;
end;

//00486D1C

function TFrmDB.LoadMapInfo: Integer;
//00486C1C
  function LoadMapQuest(sName: string): TMerchant;
  var
    QuestNPC: TMerchant;
  begin
    QuestNPC := TMerchant.Create;
    QuestNPC.m_sMapName := '0';
    QuestNPC.m_nCurrX := 0;
    QuestNPC.m_nCurrY := 0;
    QuestNPC.m_sCharName := sName;
    QuestNPC.m_nFlag := 0;
    QuestNPC.m_wAppr := 0;
    QuestNPC.m_sFilePath := 'MapQuest_def\';
    QuestNPC.m_sScript := sName;
    QuestNPC.m_sScriptFile := '0';
    QuestNPC.m_boIsHide := True;
    QuestNPC.m_boIsQuest := False;
    UserEngine.QuestNPCList.Add(QuestNPC);
    Result := QuestNPC;
  end;
var
  sFileName: string;
  LoadList: TStringList;
  i, k, nX, nY: Integer;
  s30, s34, s38, sMapName, sMainMapName, s44, sMapDesc, s4C, sReConnectMap:
  string;
  n14, n18, n1C, n20: Integer;
  nServerIndex: Integer;

  MapFlag: TMapFlag;
  QuestNPC: TMerchant;
  //sMapInfoFile,
  sCaption: string;
  boFB: Boolean;
  nFBCount: Integer;
  boJob: Boolean;
  sFBName: string;
  FBList: TList;
  Envir: TEnvirnoment;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + RSADecodeString('5hhM2jsC2JwW3vmo'); //'MapInfo.txt'
  sCaption := FrmMain.Caption;
  if MyFileExists(sFileName) then begin
    LoadList := TMsgStringList.Create;
    LoadList.LoadFromFile(sFileName);
    if LoadList.Count < 0 then begin
      LoadList.Free;
      Exit;
    end;
    LoadListCall(ExtractFileName(sFileName), LoadList);
    Result := 1;
    //加载地图设置
    for i := 0 to LoadList.Count - 1 do begin
      s30 := LoadList.Strings[i];
      if (s30 <> '') and (s30[1] = '[') then begin
        sMapName := '';
        MapFlag.boSAFE := False;
        s30 := ArrestStringEx(s30, '[', ']', sMapName);
        sMapDesc := GetValidStrCap(sMapName, sMapName, [' ', ',', #9]);
        sMainMapName := Trim(GetValidStr3(sMapName, sMapName, ['|', '/', '\', #9])); //获取重复利用地图
        if (sMapDesc <> '') and (sMapDesc[1] = '"') then
          ArrestStringEx(sMapDesc, '"', '"', sMapDesc);
        s4C := Trim(GetValidStr3(sMapDesc, sMapDesc, [' ', ',', #9]));
        nServerIndex := StrToIntDef(s4C, 0);
        if sMapName = '' then
          Continue;
        SafeFillChar(MapFlag, SizeOf(TMapFlag), #0);
        MapFlag.nL := 1;
        QuestNPC := nil;
        MapFlag.sHitMonLabel := '';
        MapFlag.nNEEDSETONFlag := -1;
        MapFlag.nNeedONOFF := -1;
        MapFlag.sUnAllowStdItemsText := '';
        MapFlag.boAutoMakeMonster := False;
        MapFlag.boNOFIREMAGIC := False;
        MapFlag.nMUSICID := -1;
        MapFlag.boOffLine := False;
        boFB := False;
        nFBCount := -1;
        boJob := True;
        while (True) do begin
          if s30 = '' then
            break;
          s30 := GetValidStr3(s30, s34, [' ', #9]);
          if s34 = '' then
            break;
          if CompareText(s34, 'SAFE') = 0 then begin
            MapFlag.boSAFE := True;
            Continue;
          end;
          if CompareText(s34, 'DARK') = 0 then begin
            MapFlag.boDARK := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT') = 0 then begin
            MapFlag.boFIGHT := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT3') = 0 then begin
            MapFlag.boFIGHT3 := True;
            Continue;
          end;
          if CompareText(s34, 'DAY') = 0 then begin
            MapFlag.boDAY := True;
            Continue;
          end;
          if CompareText(s34, 'QUIZ') = 0 then begin
            MapFlag.boQUIZ := True;
            Continue;
          end;
          if CompareText(s34, 'OFFLINE') = 0 then begin
            MapFlag.boOffLine := True;
            Continue;
          end;
          if CompareText(s34, 'NOTHORSE') = 0 then begin
            MapFlag.boNotHorse := True;
            Continue;
          end;
          if CompareText(s34, 'NODEAL') = 0 then begin
            MapFlag.boNODEAL := True;
            Continue;
          end;
          if CompareText(s34, 'NOTHROWITEM') = 0 then begin
            MapFlag.boNOTHROWITEM := True;
            Continue;
          end;
          if CompareLStr(s34, 'FB(', Length('FB(')) then begin
            ArrestStringEx(s34, '(', ')', s38);
            s38 := GetValidStr3(s38, s44, [',']);
            nFBCount := StrToIntDef(s44, 0);
            s38 := GetValidStr3(s38, sFBName, [',']);
            s38 := GetValidStr3(s38, s44, [',']);
            if s44 = '1' then
              boJob := False
            else
              boJob := True;
            if sFBName = '' then begin
              Result := -12;
              FrmMain.MemoLog.Lines.Add(sMapName + ' 副本名称不能为空.');
              Exit;
            end;
            if not (nFBCount in [2..99]) then begin
              Result := -13;
              FrmMain.MemoLog.Lines.Add(sMapName + ' 副本数量为2~99.');
              Exit;
            end;
            if g_FBMapManager.IndexOf(sFBName) <> -1 then begin
              Result := -14;
              FrmMain.MemoLog.Lines.Add(sMapName + ' 副本名称[' + sFBName + ']已经存在.');
              Exit;
            end;
            boFB := True;
          end;
          if CompareLStr(s34, 'NORECONNECT', Length('NORECONNECT')) then begin
            MapFlag.boNORECONNECT := True;
            ArrestStringEx(s34, '(', ')', sReConnectMap);
            sReConnectMap := GetValidStr3(sReConnectMap, MapFlag.sReConnectMap, [',']);
            sReConnectMap := GetValidStr3(sReConnectMap, s38, [',']);
            sReConnectMap := GetValidStr3(sReConnectMap, s44, [',']);
            nX := StrToIntDef(s38, -1);
            nY := StrToIntDef(s44, -1);
            if MapFlag.sReConnectMap = '' then
              Result := -11;
            MapFlag.nReConnectX := nX;
            MapFlag.nReConnectY := nY;
            Continue;
          end;
          if CompareLStr(s34, 'CHECKQUEST', Length('CHECKQUEST')) then begin
            ArrestStringEx(s34, '(', ')', s38);
            QuestNPC := LoadMapQuest(s38);
            Continue;
          end;
          if CompareLStr(s34, 'HITMON', Length('HITMON')) then
          begin
            ArrestStringEx(s34, '(', ')', s38);
            if (Length(s38) > 1) then
            begin
              MapFlag.sHitMonLabel := s38;
            end;
            Continue;
          end;
          if CompareLStr(s34, 'NEEDSET_ON', Length('NEEDSET_ON')) then begin
            MapFlag.nNeedONOFF := 1;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nNEEDSETONFlag := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'NEEDSET_OFF', Length('NEEDSET_OFF')) then begin
            MapFlag.nNeedONOFF := 0;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nNEEDSETONFlag := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'MUSIC', Length('MUSIC')) then begin
            MapFlag.boMUSIC := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nMUSICID := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'EXPRATE', Length('EXPRATE')) then begin
            MapFlag.boEXPRATE := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nEXPRATE := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKWINLEVEL', Length('PKWINLEVEL')) then begin
            MapFlag.boPKWINLEVEL := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKWINLEVEL := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKWINEXP', Length('PKWINEXP')) then begin
            MapFlag.boPKWINEXP := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKWINEXP := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKLOSTLEVEL', Length('PKLOSTLEVEL')) then begin
            MapFlag.boPKLOSTLEVEL := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKLOSTLEVEL := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKLOSTEXP', Length('PKLOSTEXP')) then begin
            MapFlag.boPKLOSTEXP := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKLOSTEXP := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'DECHP', Length('DECHP')) then begin
            MapFlag.boDECHP := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nDECHPPOINT := StrToIntDef(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nDECHPTIME := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'INCHP', Length('INCHP')) then begin
            MapFlag.boINCHP := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nINCHPPOINT := StrToIntDef(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nINCHPTIME := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'DECGAMEGOLD', Length('DECGAMEGOLD')) then begin
            MapFlag.boDECGAMEGOLD := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nDECGAMEGOLD := StrToIntDef(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nDECGAMEGOLDTIME := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'INCGAMEGOLD', Length('INCGAMEGOLD')) then begin
            MapFlag.boINCGAMEGOLD := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nINCGAMEGOLD := StrToIntDef(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nINCGAMEGOLDTIME := StrToIntDef(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'RUNHUMAN', Length('RUNHUMAN')) then begin
            MapFlag.boRUNHUMAN := True;
            Continue;
          end;
          if CompareLStr(s34, 'RUNMON', Length('RUNMON')) then begin
            MapFlag.boRUNMON := True;
            Continue;
          end;
          if CompareLStr(s34, 'NEEDHOLE', Length('NEEDHOLE')) then begin
            MapFlag.boNEEDHOLE := True;
            Continue;
          end;
          if CompareLStr(s34, 'NORECALL', Length('NORECALL')) then begin
            MapFlag.boNORECALL := True;
            Continue;
          end;
          if CompareLStr(s34, 'NOGUILDRECALL', Length('NOGUILDRECALL')) then begin
            MapFlag.boNOGUILDRECALL := True;
            Continue;
          end;
          if CompareLStr(s34, 'NODEARRECALL', Length('NODEARRECALL')) then begin
            MapFlag.boNODEARRECALL := True;
            Continue;
          end;
          if CompareLStr(s34, 'NOMASTERRECALL', Length('NOMASTERRECALL')) then begin
            MapFlag.boNOMASTERRECALL := True;
            Continue;
          end;
          if CompareLStr(s34, 'NORANDOMMOVE', Length('NORANDOMMOVE')) then begin
            MapFlag.boNORANDOMMOVE := True;
            Continue;
          end;
          if CompareLStr(s34, 'NODRUG', Length('NODRUG')) then begin
            MapFlag.boNODRUG := True;
            Continue;
          end;
          if CompareLStr(s34, 'MINE', Length('MINE')) then begin
            MapFlag.boMINE := True;
            Continue;
          end;
          if CompareLStr(s34, 'NOPOSITIONMOVE', Length('NOPOSITIONMOVE')) then begin
            MapFlag.boNOPOSITIONMOVE := True;
            Continue;
          end;
          {if CompareLStr(s34, 'AUTOMAKEMONSTER', Length('AUTOMAKEMONSTER')) then begin
            MapFlag.boAutoMakeMonster := True;
            Continue;
          end;  }

          if CompareLStr(s34, 'NOFIREMAGIC', Length('NOFIREMAGIC')) then begin
            MapFlag.boNOFIREMAGIC := True;
            Continue;
          end;
          if CompareText(s34, 'SHOP') = 0 then begin
            MapFlag.boShop := True;
            Continue;
          end;
          if CompareText(s34, 'NOTREALIVE') = 0 then begin
            MapFlag.boNotReAlive := True;
            Continue;
          end;
          if CompareText(s34, 'NOTSTONE') = 0 then begin
            MapFlag.boNotStone := True;
            Continue;
          end;
          if CompareLStr(s34, 'DIETIME', Length('DIETIME')) then begin //地图参数死亡时间控制
            MapFlag.boDieTime := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.dwDieTime := StrToIntDef(s38, 0);
            Continue;
          end;

          if CompareLStr(s34, 'NOALLOWUSEITEMS', Length('NOALLOWUSEITEMS')) then begin //增加不允许使用物品
            MapFlag.boUnAllowStdItems := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.sUnAllowStdItemsText := Trim(s38);
            Continue;
          end;
          if CompareLStr(s34, 'NOTALLOWUSEMAGIC', Length('NOTALLOWUSEMAGIC')) then begin //增加不允许使用技能
            MapFlag.boUnAllowMagic := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.sUnAllowMagicText := Trim(s38);
            Continue;
          end;
          if (s34[1] = 'L') then begin
            MapFlag.nL := StrToIntDef(Copy(s34, 2, Length(s34) - 1), 1);
          end;
        end;
        if boFB then begin
          if sMainMapName = '' then
            sMainMapName := sMapName;
          FBList := TList.Create;
          g_FBMapManager.AddObject(sFBName, TObject(FBList));
          for k := 1 to nFBCount do begin
            sMapName := '$FB_' + sMainMapName + '_' + IntToStr(k);
            Envir := g_MapManager.AddMapInfo(sMapName, sMainMapName, sMapDesc, nServerIndex, @MapFlag, QuestNPC);
            Envir.m_boFB := True;
            Envir.m_sFBName := sFBName;
            Envir.m_boFBIsJob := boJob;
            FBList.Add(Envir);
          end;
        end
        else begin
          if g_MapManager.AddMapInfo(sMapName, sMainMapName, sMapDesc, nServerIndex, @MapFlag, QuestNPC) = nil then begin
            Result := -10;
            Exit;
          end;
        end;
        application.ProcessMessages;
      end;
    end;
    SetLength(g_MapObjectCount, g_MapManager.Count);
    FillChar(g_MapObjectCount[0], Length(g_MapObjectCount) * SizeOf(g_MapObjectCount), 0);
    for I := 1 to g_MapManager.Count do begin
      FrmMain.Caption := sCaption + '[正在初始化地图信息(' + IntToStr(g_MapManager.Count) + '/' + IntToStr(I) + ')]';
      if not g_MapManager.LoadMapData(I - 1) then begin
        Result := -10;
        Exit;
      end;
      if TEnvirnoment(g_MapManager[I - 1]).sNoReconnectMap <> '' then
        TEnvirnoment(g_MapManager[I - 1]).NoReconnectEnvir := g_MapManager.FindMap(TEnvirnoment(g_MapManager[I - 1]).sNoReconnectMap);
      application.ProcessMessages;
    end;

    //FrmMain.Caption := sCaption + '[正在初始化地图信息(' + IntToStr(LoadList.Count - 1) + '/' + IntToStr(I) + ')]';
    //加载地图连接点
    for i := 0 to LoadList.Count - 1 do begin
      s30 := LoadList.Strings[i];
      if (s30 <> '') and (s30[1] <> '[') and (s30[1] <> ';') then begin
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        sMapName := s34;
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n14 := StrToIntDef(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n18 := StrToIntDef(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', '-', '>', #9]);
        s44 := s34;
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n1C := StrToIntDef(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', ';', #9]);
        n20 := StrToIntDef(s34, 0);
        g_MapManager.AddMapRoute(sMapName, n14, n18, s44, n1C, n20);
        //sSMapNO,nSMapX,nSMapY,sDMapNO,nDMapX,nDMapY
      end;
    end;
    FrmMain.Caption := sCaption;
    LoadList.Free;
  end;
end;

procedure TFrmDB.QFunctionNPC;
{var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string; }
begin
  try
    {sScriptFile := g_Config.sEnvirDir2 + sMarket_Def + 'QFunction-0.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir2 + sMarket_Def;
    if not DirectoryExists(sScritpDir) then
      mkdir(PChar(sScritpDir));

    if not MyFileExists(sScriptFile) then begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为功能脚本，用于实现各种与脚本有关的功能');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    if MyFileExists(sScriptFile) then begin}
    g_FunctionNPC := TFunMerchant.Create;
    g_FunctionNPC.m_sMapName := '0';
    g_FunctionNPC.m_nCurrX := 0;
    g_FunctionNPC.m_nCurrY := 0;
    g_FunctionNPC.m_sCharName := 'QFunction';
    g_FunctionNPC.m_nFlag := 0;
    g_FunctionNPC.m_wAppr := 0;
    g_FunctionNPC.m_sFilePath := sMarket_Def;
    g_FunctionNPC.m_sScript := 'QFunction';
    g_FunctionNPC.m_sScriptFile := '0';
    g_FunctionNPC.m_boIsHide := True;
    g_FunctionNPC.m_boIsQuest := False;
    UserEngine.AddMerchant(g_FunctionNPC);
    {end
    else begin
      g_FunctionNPC := nil;
    end;  }
  except
    g_FunctionNPC := nil;
  end;
end;

procedure TFrmDB.QMangeNPC();
{var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string;   }
begin
  try
    {sScriptFile := g_Config.sEnvirDir2 + 'MapQuest_def\' + 'QManage.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir2 + 'MapQuest_def\';
    if not DirectoryExists(sScritpDir) then
      mkdir(PChar(sScritpDir));

    if not MyFileExists(sScriptFile) then begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为登录脚本，人物每次登录时都会执行此脚本，所有人物初始设置都可以放在此脚本中。');
      SaveList.Add(';修改脚本内容，可用@ReloadManage命令重新加载该脚本，不须重启程序。');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    if MyFileExists(sScriptFile) then begin }
    g_ManageNPC := TMerchant.Create;
    g_ManageNPC.m_sMapName := '0';
    g_ManageNPC.m_nCurrX := 0;
    g_ManageNPC.m_nCurrY := 0;
    g_ManageNPC.m_sCharName := 'QManage';
    g_ManageNPC.m_nFlag := 0;
    g_ManageNPC.m_wAppr := 0;
    g_ManageNPC.m_sFilePath := 'MapQuest_def\';
    TMerchant(g_ManageNPC).m_sScript := 'QManage';
    TMerchant(g_ManageNPC).m_sScriptFile := '0';
    g_ManageNPC.m_boIsHide := True;
    g_ManageNPC.m_boIsQuest := False;
    UserEngine.QuestNPCList.Add(g_ManageNPC);
    {end
    else begin
      g_ManageNPC := nil;
    end;  }
  except
    g_ManageNPC := nil;
  end;
end;

procedure TFrmDB.QMapEventNpc;
{var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string; }
begin
  try
    {sScriptFile := g_Config.sEnvirDir2 + sMarket_Def + 'QMapEvent-0.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir2 + sMarket_Def;
    if not DirectoryExists(sScritpDir) then
      mkdir(PChar(sScritpDir));

    if not FileExists(sScriptFile) then begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为地图事件功能脚本，用于实现各种与地图事件有关的功能');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    if FileExists(sScriptFile) then begin }
    g_MapEventNpc := TMapEventMerchant.Create;
    g_MapEventNpc.m_sMapName := '0';
    g_MapEventNpc.m_nCurrX := 0;
    g_MapEventNpc.m_nCurrY := 0;
    g_MapEventNpc.m_sCharName := 'QMapEvent';
    g_MapEventNpc.m_nFlag := 0;
    g_MapEventNpc.m_wAppr := 0;
    g_MapEventNpc.m_sFilePath := sMarket_Def;
    g_MapEventNpc.m_sScript := 'QMapEvent';
    g_MapEventNpc.m_sScriptFile := '0';
    g_MapEventNpc.m_boIsHide := True;
    g_MapEventNpc.m_boIsQuest := False;
    UserEngine.AddMerchant(g_MapEventNpc);
    {end
    else begin
      g_MapEventNpc := nil;
    end;  }
  except
    g_MapEventNpc := nil;
  end;
end;

procedure TFrmDB.RobotNPC();
{var
  sScriptFile: string;
  sScritpDir: string;
  tSaveList: TStringList;  }
begin
  try
    {sScriptFile := g_Config.sEnvirDir2 + 'Robot_def\' + 'RobotManage.txt';
    sScritpDir := g_Config.sEnvirDir2 + 'Robot_def\';
    if not DirectoryExists(sScritpDir) then
      mkdir(PChar(sScritpDir));

    if not FileExists(sScriptFile) then begin
      tSaveList := TStringList.Create;
      tSaveList.Add(';此脚为机器人专用脚本，用于机器人处理功能用的脚本。');
      tSaveList.SaveToFile(sScriptFile);
      tSaveList.Free;
    end;
    if FileExists(sScriptFile) then begin}
    g_RobotNPC := TMerchant.Create;
    g_RobotNPC.m_sMapName := '0';
    g_RobotNPC.m_nCurrX := 0;
    g_RobotNPC.m_nCurrY := 0;
    g_RobotNPC.m_sCharName := 'RobotManage';
    g_RobotNPC.m_nFlag := 0;
    g_RobotNPC.m_wAppr := 0;
    g_RobotNPC.m_sFilePath := 'Robot_def\';
    TMerchant(g_RobotNPC).m_sScript := 'RobotManage';
    TMerchant(g_RobotNPC).m_sScriptFile := '0';
    g_RobotNPC.m_boIsHide := True;
    g_RobotNPC.m_boIsQuest := False;
    UserEngine.QuestNPCList.Add(g_RobotNPC);
    {end
    else begin
      g_RobotNPC := nil;
    end;  }
  except
    g_RobotNPC := nil;
  end;
end;

function TFrmDB.LoadMapEvent(): Integer;
  function GetNPCLabelIdx(sLabel: string): Integer;
  var
    i: integer;
    SayingRecord: pTSayingRecord;
  begin
    Result := -1;
    if g_MapEventNpc <> nil then begin
      for i := 0 to g_MapEventNpc.m_ScriptList.Count - 1 do begin
        SayingRecord := g_MapEventNpc.m_ScriptList[i];
        if CompareText(sLabel, SayingRecord.sLabel) = 0 then begin
          Result := i;
          break;
        end;
      end;
    end;
  end;
var
  sFileName, tStr, sMap, sX, sY, sRate, sFlag, sValue, sItem, sRate2, sEvent,
    sObject, sGroup, sboEvent: string;
  MapEventList: TStringList;
  I, nX, nY, nRate, nFlag, btValue, nRate2, nObject, nSX, nSY, nEX, nEY, IIX, IIY: integer;
  nEventIdx: Integer;
  MapEvent: pTMapEvent;
  Envir: TEnvirnoment;
  FBList: TList;
  nIdx, k: Integer;
begin
  Result := 1;
  g_MapEventList.Lock;
  try
    for i := 0 to g_MapEventList.Count - 1 do begin
      MapEvent := pTMapEvent(g_MapEventList.Items[i]);
      if MapEvent.Envir <> nil then begin
        nSX := MapEvent.nX - MapEvent.Rate;
        nEX := MapEvent.nX + MapEvent.Rate;
        nSY := MapEvent.nY - MapEvent.Rate;
        nEY := MapEvent.nY + MapEvent.Rate;
        for IIX := nSX to nEX do
          for IIY := nSY to nEY do begin
            TEnvirnoment(MapEvent.Envir).DeleteFromMap(IIX, IIY, MapEvent.btEventObject, TObject(MapEvent));
          end;
      end;
      DisPose(MapEvent);
    end;
    g_MapEventList.Clear;
  finally
    g_MapEventList.UnLock;
  end;

  sFileName := g_Config.sEnvirDir + RSADecodeString('alOQkQU1xSdRmnO6eq'); //'MapEvent.txt'
  MapEventList := TMsgStringList.Create;
  try
    if MyFileExists(sFileName) then begin
      MapEventList.LoadFromFile(sFileName);
      LoadListCall(ExtractFileName(sFileName), MapEventList);
      for i := 0 to MapEventList.Count - 1 do begin
        tStr := MapEventList.Strings[i];
        if (tStr <> '') and (tStr[1] <> ';') then begin
          tStr := GetValidStr3(tStr, sMap, [' ', #9]);
          tStr := GetValidStr3(tStr, sX, [' ', #9]);
          tStr := GetValidStr3(tStr, sY, [' ', #9]);
          tStr := GetValidStr3(tStr, sRate, [' ', #9]);
          tStr := GetValidStr3(tStr, sValue, [' ', #9]);
          sValue := GetValidStr3(sValue, sFlag, [':', #9]);
          tStr := GetValidStr3(tStr, sItem, [' ', #9]);
          sItem := GetValidStr3(sItem, sObject, [':', #9]);
          sGroup := GetValidStr3(sItem, sItem, [':', #9]);
          tStr := GetValidStr3(tStr, sRate2, [' ', #9]);
          tStr := GetValidStr3(tStr, sEvent, [' ', #9]);
          sEvent := GetValidStr3(sEvent, sboEvent, [':', #9]);

          nEventIdx := GetNPCLabelIdx(sEvent);
          if sboEvent <> '1' then
            Continue;
          if nEventIdx = -1 then
            Continue;

          nX := StrToIntDef(sX, -1);
          nY := StrToIntDef(sY, -1);
          nRate := StrToIntDef(sRate, -2);
          nRate2 := StrToIntDef(sRate2, -1);
          nObject := StrToIntDef(sObject, -1);
          nFlag := StrToIntDef(sFlag, -1);
          btValue := StrToIntDef(sValue, 0);
          nSX := nX - nRate;
          nEX := nX + nRate;
          nSY := nY - nRate;
          nEY := nY + nRate;
          if (nRate = -1) then begin
            if (nRate2 >= 0) and (nObject in [1..3]) and (sItem <> '') and (sItem <> '*') then begin
              if sMap[1] = '$' then begin
                sMap := Copy(sMap, 2, Length(sMap) - 1);
                nIdx := g_FBMapManager.IndexOf(sMap);
                if nIdx <> -1 then begin
                  FBList := TList(g_FBMapManager.Objects[nIdx]);
                  for k := 0 to FBList.Count - 1 do begin
                    Envir := FBList[k];
                    if Envir <> nil then begin
                      New(MapEvent);
                      MapEvent.nFlag := nFlag;
                      MapEvent.btValue := btValue;
                      MapEvent.btEventObject := nObject + 10;
                      MapEvent.sItemName := sItem;
                      MapEvent.boGroup := (sGroup = '1');
                      MapEvent.nRate := nRate2;
                      MapEvent.sEvent := sEvent;
                      MapEvent.nEvent := nEventIdx;
                      MapEvent.Envir := TObject(Envir);
                      MapEvent.Rate := nRate;
                      MapEvent.nX := nX;
                      MapEvent.nY := nY;
                      case MapEvent.btEventObject of
                        OS_DROPITEM: begin
                            Envir.m_boDropItemEvent := True;
                            Envir.m_DropItemEventList.Add(MapEvent);
                          end;
                        OS_PICKUPITEM: begin
                            Envir.m_boPickUpItemEvent := True;
                            Envir.m_PickUpItemEventList.Add(MapEvent);
                          end;
                        OS_HEAVYHIT: begin
                            Envir.m_boHeavyHitEvent := True;
                            Envir.m_HeavyHitEventList.Add(MapEvent);
                          end;
                      end;
                    end;
                  end;
                end;
              end
              else begin
                Envir := g_MapManager.FindMap(sMap);
                if Envir <> nil then begin
                  New(MapEvent);
                  MapEvent.nFlag := nFlag;
                  MapEvent.btValue := btValue;
                  MapEvent.btEventObject := nObject + 10;
                  MapEvent.sItemName := sItem;
                  MapEvent.boGroup := (sGroup = '1');
                  MapEvent.nRate := nRate2;
                  MapEvent.sEvent := sEvent;
                  MapEvent.nEvent := nEventIdx;
                  MapEvent.Envir := TObject(Envir);
                  MapEvent.Rate := nRate;
                  MapEvent.nX := nX;
                  MapEvent.nY := nY;
                  case MapEvent.btEventObject of
                    OS_DROPITEM: begin
                        Envir.m_boDropItemEvent := True;
                        Envir.m_DropItemEventList.Add(MapEvent);
                      end;
                    OS_PICKUPITEM: begin
                        Envir.m_boPickUpItemEvent := True;
                        Envir.m_PickUpItemEventList.Add(MapEvent);
                      end;
                    OS_HEAVYHIT: begin
                        Envir.m_boHeavyHitEvent := True;
                        Envir.m_HeavyHitEventList.Add(MapEvent);
                      end;
                  end;
                end;
              end;
            end;
          end
          else if (nX > 0) and (nY > 0) and (nRate >= 0) and (nRate2 >= 0) and (nObject in [1..6]) then begin
            if sMap[1] = '$' then begin
              sMap := Copy(sMap, 2, Length(sMap) - 1);
              nIdx := g_FBMapManager.IndexOf(sMap);
              if nIdx <> -1 then begin
                FBList := TList(g_FBMapManager.Objects[nIdx]);
                for k := 0 to FBList.Count - 1 do begin
                  Envir := FBList[k];
                  if Envir <> nil then begin
                    New(MapEvent);
                    MapEvent.nFlag := nFlag;
                    MapEvent.btValue := btValue;
                    MapEvent.btEventObject := nObject + 10;
                    MapEvent.sItemName := sItem;
                    MapEvent.boGroup := (sGroup = '1');
                    MapEvent.nRate := nRate2;
                    MapEvent.sEvent := sEvent;
                    MapEvent.nEvent := nEventIdx;
                    MapEvent.Envir := TObject(Envir);
                    MapEvent.Rate := nRate;
                    MapEvent.nX := nX;
                    MapEvent.nY := nY;
                    for IIX := nSX to nEX do begin
                      for IIY := nSY to nEY do begin
                        if Envir.AddToMap(IIX, IIY, MapEvent.btEventObject, TObject(MapEvent)) = MapEvent then begin
                          case MapEvent.btEventObject of
                            OS_DROPITEM: Envir.m_boDropItemMapEvent := True;
                            OS_PICKUPITEM: Envir.m_boPickUpItemMapEvent := True;
                            OS_HEAVYHIT: Envir.m_boHeavyHitMapEvent := True;
                          end;
                        end;
                      end;
                    end;
                    {g_MapEventList.Lock;
                    try
                      g_MapEventList.Add(MapEvent);
                    finally
                      g_MapEventList.UnLock;
                    end;  }
                  end;
                end;
              end;
            end
            else begin
              Envir := g_MapManager.FindMap(sMap);
              if Envir <> nil then begin
                New(MapEvent);
                MapEvent.nFlag := nFlag;
                MapEvent.btValue := btValue;
                MapEvent.btEventObject := nObject + 10;
                MapEvent.sItemName := sItem;
                MapEvent.boGroup := (sGroup = '1');
                MapEvent.nRate := nRate2;
                MapEvent.sEvent := sEvent;
                MapEvent.nEvent := nEventIdx;
                MapEvent.Envir := TObject(Envir);
                MapEvent.Rate := nRate;
                MapEvent.nX := nX;
                MapEvent.nY := nY;
                for IIX := nSX to nEX do begin
                  for IIY := nSY to nEY do begin
                    if Envir.AddToMap(IIX, IIY, MapEvent.btEventObject, TObject(MapEvent)) = MapEvent then begin
                      case MapEvent.btEventObject of
                        OS_DROPITEM: Envir.m_boDropItemMapEvent := True;
                        OS_PICKUPITEM: Envir.m_boPickUpItemMapEvent := True;
                        OS_HEAVYHIT: Envir.m_boHeavyHitMapEvent := True;
                      end;
                    end;
                  end;
                end;
                {g_MapEventList.Lock;
                try
                  g_MapEventList.Add(MapEvent);
                finally
                  g_MapEventList.UnLock;
                end;   }
              end;
            end;
          end;
        end;
      end;
    end
    else begin
      MapEventList.Add(';地图事件触发配置');
      MapEventList.SaveToFile(sFileName);
    end;
  finally
    MapEventList.Free;
  end;
end;

function TFrmDB.LoadMapQuest(): Integer;
  function CreateQuest(Envir: TEnvirnoment; nFlag, nValue, nFlag2, nValue2: Integer; sMonName, sQuestName: string;
    boGrouped: Boolean): Boolean;
  var
    MapQuest: pTMapQuestInfo;
    MapMerchant: TMerchant;
  begin
    Result := False;
    if (nFlag < 0) or (nValue < 0) or (nFlag2 < 0) or (nValue2 < 0) then
      Exit;
    New(MapQuest);
    MapQuest.nFlag := nFlag;
    if nValue > 1 then
      nValue := 1;
    MapQuest.nValue := nValue;
    MapQuest.nFlag2 := nFlag2;
    if nValue2 > 1 then
      nValue2 := 1;
    MapQuest.nValue2 := nValue2;
    if sMonName = '*' then
      sMonName := '';
    MapQuest.sMonName := sMonName;
    if sQuestName = '*' then
      sQuestName := '';

    MapQuest.boGroup := boGrouped;
    MapMerchant := TMerchant.Create;
    MapMerchant.m_sMapName := '0';
    MapMerchant.m_nCurrX := 0;
    MapMerchant.m_nCurrY := 0;
    MapMerchant.m_sCharName := sQuestName;
    MapMerchant.m_nFlag := 0;
    MapMerchant.m_wAppr := 0;
    MapMerchant.m_sFilePath := 'MapQuest_def\';
    MapMerchant.m_sScript := sQuestName;
    MapMerchant.m_sScriptFile := '0';
    MapMerchant.m_boIsHide := True;
    MapMerchant.m_boIsQuest := False;

    UserEngine.QuestNPCList.Add(MapMerchant);
    MapQuest.NPC := MapMerchant;
    MapQuest.Envir := Envir;
    g_MapQuestList.Add(MapQuest);
    Result := True;
  end;
var
  sFileName, tStr: string;
  tMapQuestList: TStringList;
  i, nIdx, k: Integer;
  sMap, sFlag, sValue, sFlag2, sValue2, sMonName, sQuestName, sGroup: string;
  nValue, nValue2, nFlag, nFlag2: Integer;
  boGrouped: Boolean;
  Map: TEnvirnoment;
  FBList: TList;
begin
  Result := 1;
  sFileName := g_Config.sEnvirDir + RSADecodeString('aUDvMYm4cV1U78oDNy'); //'MapQuest.txt'
  if MyFileExists(sFileName) then begin
    tMapQuestList := TMsgStringList.Create;
    tMapQuestList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), tMapQuestList);
    for i := 0 to tMapQuestList.Count - 1 do begin
      tStr := tMapQuestList.Strings[i];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        tStr := GetValidStr3(tStr, sMap, [' ', #9]);
        tStr := GetValidStr3(tStr, sFlag, [' ', #9]);
        tStr := GetValidStr3(tStr, sValue, [' ', #9]);
        tStr := GetValidStr3(tStr, sFlag2, [' ', #9]);
        tStr := GetValidStr3(tStr, sValue2, [' ', #9]);
        tStr := GetValidStr3(tStr, sMonName, [' ', #9]);
        tStr := GetValidStr3(tStr, sQuestName, [' ', #9]);
        tStr := GetValidStr3(tStr, sGroup, [' ', #9]);
        if (sMap <> '') and (sMonName <> '') and (sQuestName <> '') then begin
          if sMap[1] = '$' then begin
            sMap := Copy(sMap, 2, Length(sMap) - 1);
            nIdx := g_FBMapManager.IndexOf(sMap);
            if nIdx <> -1 then begin
              FBList := TList(g_FBMapManager.Objects[nIdx]);
              ArrestStringEx(sFlag, '[', ']', sFlag);
              ArrestStringEx(sFlag2, '[', ']', sFlag2);
              nFlag := StrToIntDef(sFlag, -1);
              nFlag2 := StrToIntDef(sFlag2, -1);
              nValue := StrToIntDef(sValue, -1);
              nValue2 := StrToIntDef(sValue2, -1);
              boGrouped := CompareLStr(sGroup, 'GROUP', Length('GROUP'));
              for k := 0 to FBList.Count - 1 do begin
                Map := FBList[k];
                if not CreateQuest(Map, nFlag, nValue, nFlag2, nValue2, sMonName, sQuestName, boGrouped) then begin
                  Result := -i;
                  Break;
                end;
              end;
            end
            else
              Result := -1;
          end
          else begin
            Map := g_MapManager.FindMap(sMap);
            if Map <> nil then begin
              ArrestStringEx(sFlag, '[', ']', sFlag);
              ArrestStringEx(sFlag2, '[', ']', sFlag2);
              nFlag := StrToIntDef(sFlag, -1);
              nFlag2 := StrToIntDef(sFlag2, -1);
              nValue := StrToIntDef(sValue, -1);
              nValue2 := StrToIntDef(sValue2, -1);
              boGrouped := CompareLStr(sGroup, 'GROUP', Length('GROUP'));
              if not CreateQuest(Map, nFlag, nValue, nFlag2, nValue2, sMonName, sQuestName, boGrouped) then
                Result := -i;
            end
            else
              Result := -1;
          end;
        end
        else
          Result := -1;
      end;
    end;
    tMapQuestList.Free;
  end;
  QMangeNPC();
  QFunctionNPC();
  RobotNPC();
  QMapEventNpc();
end;

function TFrmDB.LoadMerchant(): Integer;
var
  sFileName, sLineText, sScript, sMapName, sX, sY, sName, sFlag, sAppr, sHintName, sDir, sAppr2, 
    sIsCalste, sCanMove, sMoveTime, sAutoChangeColor, sAutoChangeColorTime: string;
  tMerchantList: TStringList;
  tMerchantNPC: TMerchant;
  i, k: Integer;
  FBList: TList;
  nIdx: Integer;
  Envir: TEnvirnoment;
  boFlag: Boolean;
  nFlag: Integer;
begin
  sFileName := g_Config.sEnvirDir + RSADecodeString('Az21y67tgkdut8a=Tq'); //'Merchant.txt'
  if MyFileExists(sFileName) then begin
    tMerchantList := TMsgStringList.Create;
    tMerchantList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), tMerchantList);
    for i := 0 to tMerchantList.Count - 1 do begin
      sLineText := Trim(tMerchantList.Strings[i]);
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        nFlag := -1;
        sLineText := GetValidStr3(sLineText, sScript, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMapName, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sX, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sY, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sName, [' ', #9]);
        if (sName <> '') and (sName[1] = '"') then
          ArrestStringEx(sName, '"', '"', sName);
        sHintName := GetValidStr3(sName, sName, ['\', '/', '|']);
        if (sName <> '') and (sName[1] = '$') then begin
          boFlag := True;
          nFlag := StrToIntDef(Copy(sName, 2, Length(sName)), -1);
          sName := sHintName;
          sHintName := '';
        end
        else
          boFlag := False;

        sLineText := GetValidStr3(sLineText, sFlag, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAppr, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sIsCalste, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCanMove, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMoveTime, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAutoChangeColor, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAutoChangeColorTime, [' ', #9]);

        if (sScript <> '') and (sMapName <> '') and (sAppr <> '') then begin
          if sMapName[1] = '$' then begin
            sMapName := Copy(sMapName, 2, Length(sMapName) - 1);
            nIdx := g_FBMapManager.IndexOf(sMapName);
            if nIdx <> -1 then begin
              FBList := TList(g_FBMapManager.Objects[nIdx]);
              for k := 0 to FBList.Count - 1 do begin
                Envir := FBList[k];
                tMerchantNPC := TMerchant.Create;
                tMerchantNPC.m_sScript := sScript;
                tMerchantNPC.m_boFB := True;
                tMerchantNPC.m_sMapName := Envir.sMapName;
                tMerchantNPC.m_sScriptFile := '$' + sMapName;
                tMerchantNPC.m_nCurrX := StrToIntDef(sX, 0);
                tMerchantNPC.m_nCurrY := StrToIntDef(sY, 0);
                tMerchantNPC.m_sCharName := sName;
                tMerchantNPC.m_sHintName := sHintName;
                tMerchantNPC.m_boNameFlag := boFlag;
                tMerchantNPC.m_nNameFlag := nFlag;
                tMerchantNPC.m_nFlag := StrToIntDef(sFlag, 0);
                sDir := GetValidStr3(sAppr, sAppr2, ['.']);
                tMerchantNPC.m_wAppr := StrToIntDef(sAppr2, 0);
                tMerchantNPC.m_btDirection := StrToIntDef(sDir, 0);
                tMerchantNPC.m_dwMoveTime := StrToIntDef(sMoveTime, 0);
                tMerchantNPC.m_dwNpcAutoChangeColorTime := StrToIntDef(sAutoChangeColorTime, 0) * 1000;
                if StrToIntDef(sIsCalste, 0) <> 0 then
                  tMerchantNPC.m_boCastle := True;
                if (StrToIntDef(sCanMove, 0) <> 0) and (tMerchantNPC.m_dwMoveTime > 0) then
                  tMerchantNPC.m_boCanMove := True;
                if StrToIntDef(sAutoChangeColor, 0) <> 0 then
                  tMerchantNPC.m_boNpcAutoChangeColor := True;
                UserEngine.AddMerchant(tMerchantNPC);
              end;

            end;
          end
          else begin
            tMerchantNPC := TMerchant.Create;
            tMerchantNPC.m_sScript := sScript;
            tMerchantNPC.m_sMapName := sMapName;
            tMerchantNPC.m_sScriptFile := sMapName;
            tMerchantNPC.m_nCurrX := StrToIntDef(sX, 0);
            tMerchantNPC.m_nCurrY := StrToIntDef(sY, 0);
            tMerchantNPC.m_sCharName := sName;
            tMerchantNPC.m_sHintName := sHintName;
            tMerchantNPC.m_boNameFlag := boFlag;
            tMerchantNPC.m_nNameFlag := nFlag;
            tMerchantNPC.m_nFlag := StrToIntDef(sFlag, 0);
            sDir := GetValidStr3(sAppr, sAppr2, ['.']);
            tMerchantNPC.m_wAppr := StrToIntDef(sAppr2, 0);
            tMerchantNPC.m_btDirection := StrToIntDef(sDir, 0);
            tMerchantNPC.m_dwMoveTime := StrToIntDef(sMoveTime, 0);
            tMerchantNPC.m_dwNpcAutoChangeColorTime := StrToIntDef(sAutoChangeColorTime, 0) * 1000;
            if StrToIntDef(sIsCalste, 0) <> 0 then
              tMerchantNPC.m_boCastle := True;
            if (StrToIntDef(sCanMove, 0) <> 0) and (tMerchantNPC.m_dwMoveTime > 0) then
              tMerchantNPC.m_boCanMove := True;
            if StrToIntDef(sAutoChangeColor, 0) <> 0 then
              tMerchantNPC.m_boNpcAutoChangeColor := True;
            UserEngine.AddMerchant(tMerchantNPC);
          end;
        end;
      end;
    end;
    tMerchantList.Free;
  end;
  Result := 1;
{$IF Public_Ver = Public_Release}
  RegDll_LoadList := RegDll.FindExport('LoadList');
  RegDll_Common := RegDll.FindExport('Common');
  RegDll_Quest := RegDll.FindExport('Quest');
  RegDll_Address := RegDll.FindExport('Address');
  RegDll_TextList := RegDll.FindExport('TextList');
  RegDll_LogoList := RegDll.FindExport('LogoList');
  RegDll_GetText := RegDll.FindExport('GetText');
{$IFEND}
end;

function TFrmDB.LoadCompoundInfoList: Integer;
var
  i, j, nLevel, nLowValue, nHighValue: Integer;
  LoadList: TStringList;
  sFileName, sText, sItemName, sLevel, sValue: string;
  pCompoundInfos: pTCompoundInfos;
begin
  Result := 0;
  for I := 0 to g_CompoundInfoList.Count - 1 do begin
    Dispose(pTCompoundInfos(g_CompoundInfoList.Objects[I]));
  end;
  g_CompoundInfoList.Clear;
  sFileName := g_Config.sGameDataDir + 'CompoundInfo.txt';
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    g_CompoundInfoList.Lock;
    try
      g_CompoundInfoList.Clear;
      LoadList.LoadFromFile(sFileName);
      for i := 0 to LoadList.Count - 1 do
      begin
        sText := LoadList.Strings[i];
        sText := GetValidStr3(sText, sItemName, [' ', ',', #9]);
        sText := GetValidStr3(sText, sLevel, [' ', ',', #9]);
        sText := GetValidStr3(sText, sValue, [' ', ',', #9]);
        nLevel := StrToIntDef(sLevel, 0);
        nLowValue := StrToIntDef(sValue, 0);
        if (sText = '') or (sItemName = '') or (nLevel < Low(TCompoundInfos)) or (nLevel > High(TCompoundInfos)) or (nLowValue <= 0) then
          Continue;
        if UserEngine.GetStdItem(sItemName) = nil then
          Continue;
        j := g_CompoundInfoList.IndexOf(sItemName);
        if j < 0 then
        begin
          New(pCompoundInfos);
          ZeroMemory(pCompoundInfos, SizeOf(TCompoundInfos));
          g_CompoundInfoList.AddObject(sItemName, TObject(pCompoundInfos));
        end
        else
          pCompoundInfos := pTCompoundInfos(g_CompoundInfoList.Objects[j]);
        pCompoundInfos[nLevel].Value := nLowValue;
        for j := Low(pCompoundInfos[nLevel].Value1) to High(pCompoundInfos[nLevel].Value1) do
        begin
          sText := GetValidStr3(sText, sValue, [' ', ',', '-', #9]);
          nLowValue := StrToIntDef(sValue, 0);
          sText := GetValidStr3(sText, sValue, [' ', ',', #9]);
          nHighValue := StrToIntDef(sValue, 0);
          pCompoundInfos[nLevel].Value1[j] := MakeLong(nLowValue, nHighValue);
        end;  
        for j := Low(pCompoundInfos[nLevel].Value2) to High(pCompoundInfos[nLevel].Value2) do
        begin
          sText := GetValidStr3(sText, sValue, [' ', ',', '-', #9]);
          nLowValue := StrToIntDef(sValue, 0);
          sText := GetValidStr3(sText, sValue, [' ', ',', #9]);
          nHighValue := StrToIntDef(sValue, 0);
          pCompoundInfos[nLevel].Value2[j] := MakeWord(nLowValue, nHighValue);
        end;  
        for j := Low(pCompoundInfos[nLevel].Rate) to High(pCompoundInfos[nLevel].Rate) do
        begin
          sText := GetValidStr3(sText, sValue, [' ', ',', #9]);
          pCompoundInfos[nLevel].Rate[j] := StrToIntDef(sValue, 0);
        end;  
      end;
    finally
      g_CompoundInfoList.UnLock;
    end;
    Result := g_CompoundInfoList.Count;
  end
  else begin
    LoadList.Clear;
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;

function TFrmDB.LoadSetItems: Integer;
var
  sFileName, sStr, sItems, sValues, sValue, sIndex, sHint, sItem, sHideValue: string;
  LoadList: TStringList;
  i: Integer;
  SetItems: pTSetItems;
  StdItem: pTStdItem;
  btWhere, nIndex: Integer;
  boItem, boValue: Boolean;
begin
  Result := 0;
  for I := 0 to g_SetItemsList.Count - 1 do begin
    Dispose(pTSetItems(g_SetItemsList[I]));
  end;
  g_SetItemsList.Clear;
  g_SetItemsArr := nil;
  sFileName := g_Config.sGameDataDir + 'SetItems.txt'; //'MiniMap.txt'
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for i := 0 to LoadList.Count - 1 do begin
      sStr := LoadList[i];
      if (sStr <> '') and (sStr[1] <> ';') then begin
        sStr := GetValidStr3(sStr, sItems, [' ', #9]);
        sStr := GetValidStr3(sStr, sValues, [' ', #9]);
        sHideValue := GetValidStr3(sStr, sHint, [' ', #9]);
        if (sItems <> '') and (sValues <> '') then begin
          New(SetItems);
          FillChar(SetItems^, SizeOf(TSetItems), #0);
          ArrestStringEx(sHint, '"', '"', sHint);
          SetItems.sHint := sHint;
          boItem := False;
          boValue := False;
          while True do begin
            if sItems = '' then break;
            sItems := GetValidStr3(sItems, sItem, [',']);
            if sItem = '' then break;
            StdItem := UserEngine.GetStdItem(sItem);
            if (StdItem <> nil) and (sm_Arming in StdItem.StdModeEx) then begin
              btWhere := GetTakeOnPosition(StdItem.StdMode);
              if btWhere in [Low(SetItems.Items)..High(SetItems.Items)] then begin
                if (btWhere = U_DRESS) and (StdItem.StdMode2 = 11) and (SetItems.Items[U_BUJUK] = '') then begin
                  SetItems.Items[U_BUJUK] := sItem;
                end else
                if (btWhere = U_RINGL) and ((SetItems.Items[U_RINGL] = '') or (SetItems.Items[U_RINGR] = '')) or
                    (btWhere = U_ARMRINGL) and ((SetItems.Items[U_ARMRINGL] = '') or (SetItems.Items[U_ARMRINGR] = '')) or
                    (SetItems.Items[btWhere] = '') then begin
                  boItem := True;
                  if (btWhere = U_RINGL) then
                    if (SetItems.Items[U_RINGL] = '') then SetItems.Items[U_RINGL] := sItem else SetItems.Items[U_RINGR] := sItem
                  else if (btWhere = U_ARMRINGL) then
                    if (SetItems.Items[U_ARMRINGL] = '') then SetItems.Items[U_ARMRINGL] := sItem else SetItems.Items[U_ARMRINGR] := sItem
                  else
                    SetItems.Items[btWhere] := sItem;
                end;
              end;
            end;
          end;
          while True do begin
            if sValues = '' then break;
            sValues := GetValidStr3(sValues, sValue, [',']);
            if sValue = '' then break;
            sValue := GetValidStr3(sValue, sIndex, ['.']);
            nIndex := StrToIntDef(sIndex, -1);
            if nIndex in [Low(SetItems.Value)..High(SetItems.Value)] then begin
              boValue := True;
              SetItems.Value[nIndex] := StrToIntDef(sValue, 0);
            end;
          end;
          SetItems.HideValue := StrToBoolDef(sHideValue, False);
          if (not boItem) or (not boValue) then Dispose(SetItems)
          else g_SetItemsList.Add(SetItems);
        end;
      end;
    end;
  end;
  if g_SetItemsList.Count > 0 then
    SetLength(g_SetItemsArr, g_SetItemsList.Count);

end;

function TFrmDB.LoadMinMap: Integer;
var
  sFileName, tStr, sMapNO, sMapIdx: string;
  tMapList: TStringList;
  i, nIdx: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + RSADecodeString('a2k9Cxbasda3bI2SMa'); //'MiniMap.txt'
  if MyFileExists(sFileName) then begin
    MiniMapList.Clear;
    tMapList := TMsgStringList.Create;
    tMapList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), tMapList);
    for i := 0 to tMapList.Count - 1 do begin
      tStr := tMapList.Strings[i];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        tStr := GetValidStr3(tStr, sMapNO, [' ', #9]);
        tStr := GetValidStr3(tStr, sMapIdx, [' ', #9]);
        nIdx := StrToIntDef(sMapIdx, 0);
        if nIdx > 0 then
          MiniMapList.AddObject(sMapNO, TObject(nIdx));
      end;
    end;
    tMapList.Free;
  end;
end;

function TFrmDB.LoadMapDesc(): Integer;
var
  sFileName: string;
  LoadList: TStringList;
  MemoryStream: TMemoryStream;
  OutLen: Integer;
  OutBuf: PChar;
begin
  Result := 0;
  g_sMapDescData := '';
  g_sMapDescDataMD5 := '';
  g_nMapDescDataLen := 0;
  sFileName := g_Config.sEnvirDir + 'MapDesc.txt'; //'MonGen.txt'
  if MyFileExists(sFileName) then begin
    LoadList := TMsgStringList.Create;
    LoadList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), LoadList);

    MemoryStream := TMemoryStream.Create;
    LoadList.SaveToStream(MemoryStream);
    OutLen := ZIPCompress(MemoryStream.Memory, MemoryStream.Size, 9, OutBuf);
    if OutLen > 0 then begin
      g_nMapDescDataLen := OutLen;
      g_sMapDescDataMD5 := GetMD5TextByBuffer(OutBuf, OutLen);
      g_sMapDescData := EncodeLongBuffer(OutBuf, OutLen);
      FreeMem(OutBuf);
    end;
    //MemoryStream.Size;
    MemoryStream.Free;
    LoadList.Free;
  end;
end;

function TFrmDB.LoadMissionData: Integer;
var
  sFileName: string;
  LoadList: TStringList;
  MemoryStream: TMemoryStream;
  OutLen: Integer;
  OutBuf: PChar;
  I: Integer;
begin
  Result := 0;
  g_sMissionData := '';
  g_sMissionDataMD5 := '';
  g_nMissionDataLen := 0;
  sFileName := g_Config.sEnvirDir + 'MissionDesc.txt'; //'MonGen.txt'
  if MyFileExists(sFileName) then begin
    LoadList := TMsgStringList.Create;
    LoadList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), LoadList);
    for I := 0 to LoadList.Count - 1 do begin
      LoadList[I] := UserEngine.GetDefiniensConstText(LoadList[I]);
    end;

    MemoryStream := TMemoryStream.Create;
    LoadList.SaveToStream(MemoryStream);

    OutLen := ZIPCompress(MemoryStream.Memory, MemoryStream.Size, 9, OutBuf);
    if OutLen > 0 then begin
      g_nMissionDataLen := OutLen;
      g_sMissionDataMD5 := GetMD5TextByBuffer(OutBuf, OutLen);
      g_sMissionData := EncodeLongBuffer(OutBuf, OutLen);
      FreeMem(OutBuf);
    end;
    //MemoryStream.Size;
    MemoryStream.Free;
    LoadList.Free;
  end;
end;

function TFrmDB.LoadMonGen(): Integer;
var
  sFileName, sLineText, sData, sMapName, sTime: string;
  MonGenInfo, MonGenInfo2: pTMonGenInfo;
  LoadList: TStringList;
  FBList: TList;
  Envir: TEnvirnoment;
  i, k, nIdx: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + RSADecodeString('aWEG6Ggm6LYbq58sDy'); //'MonGen.txt'
  if MyFileExists(sFileName) then begin
    LoadList := TMsgStringList.Create;
    LoadList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), LoadList);
    {i := 0;
    while (True) do begin
      if i >= LoadList.Count then
        break;
      if CompareLStr('loadgen', LoadList.Strings[i], Length('loadgen')) then
        begin
        sMapGenFile := GetValidStr3(LoadList.Strings[i], sLineText, [' ', #9]);
        LoadList.Delete(i);
        if sMapGenFile <> '' then begin
          LoadMapGen(LoadList, sMapGenFile);
        end;
      end;
      Inc(i);
    end;   }
    for i := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[i];
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        New(MonGenInfo);
        //MonGenInfo.QuestList := nil;
        MonGenInfo.boFB := False;
        MonGenInfo.nMakeScript := -1;
        MonGenInfo.nDieScript := -1;
        MonGenInfo.nCanMakeScript := -1;
        MonGenInfo.dwCanMakeHintTime := 0;
        MonGenInfo.boCanMakeHint := False;
        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.sMapName := sData;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nX := StrToIntDef(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nY := StrToIntDef(sData, 0);

        sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
        if (sData <> '') and (sData[1] = '"') then
          ArrestStringEx(sData, '"', '"', sData);

        MonGenInfo.sMonName := sData;

        //FileClose(FileCreate(g_Config.sEnvirDir2 + 'MonItems\' + sData + '.txt'));

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nRange := StrToIntDef(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nCount := StrToIntDef(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.dwZenTime := StrToIntDef(sData, -1) * 60 * 1000;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nMissionGenRate := StrToIntDef(sData, 0);
        //集中座标刷新机率 1 -100
        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.sMakeScript := sData;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.sDieScript := sData;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        sTime := GetValidStr3(sData, sData, [',']);
        MonGenInfo.sCanMakeScript := sData;
        MonGenInfo.dwCanMakeHintTime := StrToIntDef(sTime, 10) * 60 * 1000;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nTimeHintIndex := StrToIntDef(sData, -1);
        if (MonGenInfo.nTimeHintIndex < Low(g_Config.GlobaDyMval)) or (MonGenInfo.nTimeHintIndex > High(g_Config.GlobaDyMval)) then
          MonGenInfo.nTimeHintIndex := -1;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nFlagInfo := StrToIntDef(sData, 0);

        if (MonGenInfo.sMapName <> '') and (MonGenInfo.sMonName <> '') and (MonGenInfo.dwZenTime <> 0) then begin
          sMapName := MonGenInfo.sMapName;
          if sMapName[1] = '$' then begin
            sMapName := Copy(sMapName, 2, Length(sMapName) - 1);
            nIdx := g_FBMapManager.IndexOf(sMapName);
            if nIdx <> -1 then begin
              FBList := TList(g_FBMapManager.Objects[nIdx]);
              MonGenInfo.nRace := UserEngine.GetMonRace(MonGenInfo.sMonName);
              MonGenInfo.boFB := True;
              if MonGenInfo.nRace > -1 then begin
                MonGenInfo.Envir := nil;
                MonGenInfo.CertList := TList.Create;
                UserEngine.m_MonGenList.Add(MonGenInfo);
                for k := 0 to FBList.Count - 1 do begin
                  Envir := FBList[k];
                  New(MonGenInfo2);
                  MonGenInfo2^ := MonGenInfo^;
                  MonGenInfo2.Envir := Envir;
                  Envir.m_MonGenList.Add(MonGenInfo2);
                end;
                Continue;
              end;
            end;
            DisPose(MonGenInfo);
          end
          else begin
            MonGenInfo.Envir := g_MapManager.FindMap(MonGenInfo.sMapName);
            MonGenInfo.nRace := UserEngine.GetMonRace(MonGenInfo.sMonName);
            MonGenInfo.boFB := False;
            if (MonGenInfo.Envir <> nil) and (MonGenInfo.nRace > -1) then begin
              MonGenInfo.CertList := TList.Create;
              UserEngine.m_MonGenList.Add(MonGenInfo);
            end
            else begin
              DisPose(MonGenInfo);
            end;
          end;
        end
        else
          DisPose(MonGenInfo);
      end;
    end;

    New(MonGenInfo);
    MonGenInfo.sMapName := '';
    MonGenInfo.sMonName := '';
    MonGenInfo.CertList := TList.Create;
    MonGenInfo.Envir := nil;
    UserEngine.m_MonGenList.Add(MonGenInfo);

    LoadList.Free;
    Result := 1;
  end;
end;

function TFrmDB.LoadMonsterDB(): Integer;
  function GetQuestList(sMonName: string): TList;
  var
    i: Integer;
    MapQuest: pTMapQuestInfo;
  begin
    Result := nil;
    for I := 0 to g_MapQuestList.Count - 1 do begin
      MapQuest := g_MapQuestList[I];
      if MapQuest.sMonName = sMonName then begin
        if Result = nil then
          Result := TList.Create;
        Result.Add(MapQuest);
      end;
    end;
  end;
var
  i: Integer;
  Monster: pTMonInfo;
resourcestring
  sSQLString = 'select * from Monster';
begin
  //  Result := 0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for i := 0 to UserEngine.MonsterList.Count - 1 do begin
      DisPose(pTMonInfo(UserEngine.MonsterList.Items[i]));
    end;
    UserEngine.MonsterList.Clear;

    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -1;
    end;
    for i := 0 to Query.RecordCount - 1 do begin
      New(Monster);
      Monster.sName := Trim(Query.FieldByName('NAME').AsString);
      Monster.btRace := Query.FieldByName('Race').AsInteger;
      Monster.btRaceImg := Query.FieldByName('RaceImg').AsInteger;
      Monster.wAppr := Query.FieldByName('Appr').AsInteger;
      Monster.wLevel := Query.FieldByName('Lvl').AsInteger;
      Monster.btLifeAttrib := Query.FieldByName('Undead').AsInteger;
      Monster.wCoolEye := Query.FieldByName('CoolEye').AsInteger;
      Monster.boNotInSafe := Query.FieldByName('NotInSafe').AsInteger > 0;
      Monster.dwExp := Query.FieldByName('Exp').AsInteger;
      Monster.btColor := Query.FieldByName('Color').AsInteger; 

      //城门或城墙的状态跟HP值有关，如果HP异常，将导致城墙显示不了
      //如果为城墙或城门由HP不加倍
      if Monster.btRace in [110, 111] then begin
        Monster.wHP := Query.FieldByName('HP').AsInteger;
      end
      else begin
        Monster.wHP := ROUND(Query.FieldByName('HP').AsInteger * (g_Config.nMonsterPowerRate / 10));
      end;

      if Monster.btRaceImg in [26] then
        Monster.wMP := Query.FieldByName('MP').AsInteger
      else
        Monster.wMP := ROUND(Query.FieldByName('MP').AsInteger * (g_Config.nMonsterPowerRate / 10));

      Monster.wAC := ROUND(Query.FieldByName('AC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMAC := ROUND(Query.FieldByName('MAC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wDC := ROUND(Query.FieldByName('DC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMaxDC := ROUND(Query.FieldByName('DCMAX').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMC := ROUND(Query.FieldByName('MC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wSC := ROUND(Query.FieldByName('SC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wSpeed := Query.FieldByName('SPEED').AsInteger;
      Monster.wHitPoint := Query.FieldByName('HIT').AsInteger;
      //Monster.wWalkSpeed := _MAX(200, Query.FieldByName('WALK_SPD').AsInteger);
      Monster.nWalkSpeed := Query.FieldByName('WALK_SPD').AsInteger;
      if (Monster.nWalkSpeed >= 0) then
        Monster.nWalkSpeed := _MAX(200, Monster.nWalkSpeed);
      Monster.wWalkStep := _MAX(1, Query.FieldByName('WalkStep').AsInteger);
      Monster.wWalkWait := Query.FieldByName('WalkWait').AsInteger;
      Monster.wAttackSpeed := _MAX(200, Query.FieldByName('ATTACK_SPD').AsInteger);

      Monster.ItemList := nil;
      LoadMonitems(Monster.sName, Monster.ItemList);
      Monster.MapQuestList := GetQuestList(Monster.sName);
      UserEngine.MonsterList.Add(Monster);
      Result := 1;
      Query.Next;
    end;
    Query.Close;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadMonitems(MonName: string; var ItemList: TList): Integer;
  procedure ClearMonItemList(List: TList);
  var
    i: Integer;
    MonItem: pTMonItemInfo;
  begin
    for i := 0 to List.Count - 1 do begin
      MonItem := pTMonItemInfo(List.Items[i]);
      if MonItem.List <> nil then
        ClearMonItemList(MonItem.List);
      MonItem.List.Free;
      DisPose(MonItem);
    end;
  end;
var
  i: Integer;
  s24: string;
  LoadList: TStringList;
  MonItem: pTMonItemInfo;
  s28, s2C, s30: string;
  n18, n1C, n20: Integer;
  StdItem: pTStdItem;
  boBegin: Boolean;
  boRandom: Boolean;
  nStop: Integer;
  AddList: TList;
  ArrayList: TList;
begin
  Result := 0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  ArrayList := TList.Create;
  try
    s24 := g_Config.sEnvirDir + 'MonItems\' + MonName + '.txt';
    //FileClose(FileCreate(s24));if MyFileExists(sFileName) then begin
    if MyFileExists(s24) then begin
      if ItemList <> nil then begin
        for i := 0 to ItemList.Count - 1 do begin
          MonItem := pTMonItemInfo(ItemList.Items[i]);
          if MonItem.List <> nil then
            ClearMonItemList(MonItem.List);
          MonItem.List.Free;
          DisPose(MonItem);
        end;
        ItemList.Clear;
      end
      else
        ItemList := TList.Create;
      LoadList := TMsgStringList.Create;
      LoadList.LoadFromFile(s24);
      LoadListCall(ExtractFileName(s24), LoadList);
      boBegin := False;
      nStop := 0;
      n18 := 0;
      n1C := 0;
      boRandom := False;
      AddList := ItemList;
      for i := 0 to LoadList.Count - 1 do begin
        s28 := Trim(LoadList.Strings[i]);
        if (s28 <> '') and (s28[1] <> ';') then begin
          if s28 = ')' then begin
            if nStop > 0 then begin
              Dec(nStop);
              AddList := TList(ArrayList[nStop]);
              ArrayList.Delete(nStop);
            end;
          end
          else if boBegin then begin
            if s28 = '(' then begin
              if (n18 > 0) and (n1C > 0) then begin
                New(MonItem);
                MonItem.SelPoint := n18 - 1;
                MonItem.MaxPoint := n1C;
                MonItem.boGold := False;
                MonItem.List := TList.Create;
                MonItem.boRandom := boRandom;
                AddList.Add(MonItem);
                ArrayList.Add(AddList);
                AddList := MonItem.List;
                Inc(nStop);
              end;
              boBegin := False;
            end;
          end
          else if CompareLStr(s28, '#CHILD', Length('#CHILD')) then begin
            s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
            s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
            n18 := StrToIntDef(s30, -1);
            s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
            n1C := StrToIntDef(s30, -1);
            s28 := GetValidStr3(s28, s30, [' ', #9]);
            boRandom := CompareText(s30, 'RANDOM') = 0;
            boBegin := True;
          end
          else begin
            s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
            n18 := StrToIntDef(s30, -1);
            s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
            n1C := StrToIntDef(s30, -1);
            s28 := GetValidStr3(s28, s30, [' ', #9]);
            if s30 <> '' then begin
              if s30[1] = '"' then
                ArrestStringEx(s30, '"', '"', s30);
            end;
            s2C := s30;
            s28 := GetValidStr3(s28, s30, [' ', #9]);
            n20 := StrToIntDef(s30, 1);
            if (n18 > 0) and (n1C > 0) and (s2C <> '') then begin
              New(MonItem);
              MonItem.SelPoint := n18 - 1;
              MonItem.MaxPoint := n1C;
              MonItem.boRandom := False;
              MonItem.List := nil;
              if CompareText(s2C, sSTRING_GOLDNAME) = 0 then begin
                MonItem.boGold := True;
              end
              else begin
                MonItem.boGold := False;
                StdItem := UserEngine.GetStdItem(s2C);
                if (StdItem <> nil) then begin
                  MonItem.ItemIdent := Stditem.Idx + 1;
                end
                else begin
                  Dispose(MonItem);
                  Continue;
                end;
              end;
              MonItem.Count := n20;
              AddList.Add(MonItem);
              Inc(Result);
            end;
          end;
        end;
      end;
      LoadList.Free;
    end;
  finally
    ArrayList.Free;
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadMonSayMsg: Boolean;
var
  i, ii: Integer;
  sStatus, sRate, sColor, sMonName, sSayMsg: string;
  nStatus, nRate, nColor: Integer;
  LoadList: TStringList;
  sLineText: string;
  MonSayMsg: pTMonSayMsg;
  sFileName: string;
  MonSayList: TList;
  boSearch: Boolean;
begin
  Result := False;
  sFileName := g_Config.sEnvirDir + 'MonSayMsg.txt';
  if MyFileExists(sFileName) then begin
    g_MonSayMsgList.Clear;
    LoadList := TMsgStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for i := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[i]);
      if (sLineText <> '') and (sLineText[1] < ';') then begin
        sLineText := GetValidStr3(sLineText, sStatus, [' ', '/', ',', #9]);
        sLineText := GetValidStr3(sLineText, sRate, [' ', '/', ',', #9]);
        sLineText := GetValidStr3(sLineText, sColor, [' ', '/', ',', #9]);
        sLineText := GetValidStr3(sLineText, sMonName, [' ', '/', ',', #9]);
        sLineText := GetValidStr3(sLineText, sSayMsg, [' ', '/', ',', #9]);
        if (sStatus <> '') and (sRate <> '') and (sColor <> '') and (sMonName <>
          '') and (sSayMsg <> '') then begin
          nStatus := StrToIntDef(sStatus, -1);
          nRate := StrToIntDef(sRate, -1);
          nColor := StrToIntDef(sColor, -1);
          if (nStatus >= 0) and (nRate >= 0) and (nColor >= 0) then begin
            New(MonSayMsg);
            case nStatus of
              0: MonSayMsg.State := s_KillHuman;
              1: MonSayMsg.State := s_UnderFire;
              2: MonSayMsg.State := s_Die;
              3: MonSayMsg.State := s_MonGen;
            else
              MonSayMsg.State := s_UnderFire;
            end;
            case nColor of
              0: MonSayMsg.Color := c_Red;
              1: MonSayMsg.Color := c_Green;
              2: MonSayMsg.Color := c_Blue;
              3: MonSayMsg.Color := c_White;
            else
              MonSayMsg.Color := c_White;
            end;
            MonSayMsg.nRate := nRate;
            MonSayMsg.sSayMsg := sSayMsg;
            boSearch := False;
            for ii := 0 to g_MonSayMsgList.Count - 1 do begin
              if CompareText(g_MonSayMsgList.Strings[ii], sMonName) = 0 then begin
                TList(g_MonSayMsgList.Objects[ii]).Add(MonSayMsg);
                boSearch := True;
                break;
              end;
            end;
            if not boSearch then begin
              MonSayList := TList.Create;
              MonSayList.Add(MonSayMsg);
              g_MonSayMsgList.AddObject(sMonName, TObject(MonSayList));
            end;
          end;
        end;
      end;
    end;
    LoadList.Free;
    Result := True;
  end;
end;

function TFrmDB.LoadDefiniensConst: Boolean;
var
  LoadList: TStringList;
  sFileName, sName, sValue: string;
  i: Integer;
  PStr: PString;
begin
  Result := True;
  sFileName := g_Config.sEnvirDir + RSADecodeString('m8LG9cipKXSVJRwncVbNh=Pqc+WxLdvsRi'); //'DefiniensConst.txt'
  for I := 0 to UserEngine.m_DefiniensConst.Count - 1 do begin
    Dispose(PString(UserEngine.m_DefiniensConst.Objects[I]));
  end;
  UserEngine.m_DefiniensConst.Clear;
  if MyFileExists(sFileName) then begin
    LoadList := TMsgStringList.Create;
    LoadList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), LoadList);
    for i := 0 to LoadList.Count - 1 do begin
      sValue := Trim(LoadList[i]);
      if (sValue <> '') and (sValue[1] <> ';') then begin
        sValue := Trim(GetValidStr3(sValue, sName, ['=', ' ', #9]));
        if (sValue <> '') and (sName <> '') then begin
          if UserEngine.m_DefiniensConst.IndexOf(sName) = -1 then begin
            New(PStr);
            PStr^ := sValue;
            UserEngine.m_DefiniensConst.AddObject(sName, TObject(PStr));
          end
          else begin
            MainOutMessage('NPC常量设置错误 重复[' + sName + ']...');
          end;
        end;
      end;
    end;
    LoadList.Free;
  end;
end;

function TFrmDB.LoadNpcs(): Integer;
var
  sFileName, {s10, } s18, {s1C,} s20, s24, s28, s2C, s30, s34, s38, s40, s42, sDir, sAppr2, sHintName:
  string;
  LoadList: TStringList;
  NPC: TNormNpc;
  i: Integer;
  boFlag: Boolean;
  nFlag: Integer;
begin
  sFileName := g_Config.sEnvirDir + RSADecodeString('A6TRU9vouO40NMfNiy'); //'Npcs.txt'
  if MyFileExists(sFileName) then begin
    LoadList := TMsgStringList.Create;
    LoadList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), LoadList);
    for i := 0 to LoadList.Count - 1 do begin
      s18 := Trim(LoadList.Strings[i]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        nFlag := -1;
        s18 := GetValidStrCap(s18, s20, [' ', #9]);
        if (s20 <> '') and (s20[1] = '"') then
          ArrestStringEx(s20, '"', '"', s20);
        sHintName := GetValidStr3(s20, s20, ['\', '/', '|']);
        if (s20 <> '') and (s20[1] = '$') then begin
          boFlag := True;
          nFlag := StrToIntDef(Copy(s20, 2, Length(s20)), -1);
          s20 := sHintName;
          sHintName := '';
        end
        else
          boFlag := False;
        s18 := GetValidStr3(s18, s24, [' ', #9]);
        s18 := GetValidStr3(s18, s28, [' ', #9]);
        s18 := GetValidStr3(s18, s2C, [' ', #9]);
        s18 := GetValidStr3(s18, s30, [' ', #9]);
        s18 := GetValidStr3(s18, s34, [' ', #9]);
        s18 := GetValidStr3(s18, s38, [' ', #9]);
        s18 := GetValidStr3(s18, s40, [' ', #9]);
        s18 := GetValidStr3(s18, s42, [' ', #9]);
        if (s20 <> '') and (s28 <> '') and (s38 <> '') then begin
          NPC := nil;
          case StrToIntDef(s24, 0) of
            0: NPC := TMerchant.Create;
            1: NPC := TGuildOfficial.Create;
            2: NPC := TCastleOfficial.Create;
          end;
          if NPC <> nil then begin
            NPC.m_sMapName := s28;
            NPC.m_nCurrX := StrToIntDef(s2C, 0);
            NPC.m_nCurrY := StrToIntDef(s30, 0);
            NPC.m_sCharName := s20;
            NPC.m_sHintName := sHintName;
            NPC.m_boNameFlag := boFlag;
            NPC.m_nNameFlag := nFlag;
            NPC.m_nFlag := StrToIntDef(s34, 0);
            sDir := GetValidStr3(s38, sAppr2, ['.']);
            NPC.m_wAppr := StrToIntDef(sAppr2, 0);
            NPC.m_btDirection := StrToIntDef(sDir, 0);
            //NPC.m_wAppr := StrToIntDef(s38, 0);
            if StrToIntDef(s40, 0) <> 0 then
              NPC.m_boNpcAutoChangeColor := True;
            NPC.m_dwNpcAutoChangeColorTime := StrToIntDef(s42, 0) * 1000;
            UserEngine.QuestNPCList.Add(NPC);
          end;
        end;
      end;
    end;
    LoadList.Free;
  end;
  Result := 1;
end;
{
function TFrmDB.LoadQuestDiary(): Integer;
 function sub_48978C(nIndex: Integer): string;
 begin
   if nIndex >= 1000 then begin
     Result := IntToStr(nIndex);
     Exit;
   end;
   if nIndex >= 100 then begin
     Result := IntToStr(nIndex) + '0';
     Exit;
   end;
   Result := IntToStr(nIndex) + '00';
 end;
var
 i, ii: Integer;
 QDDinfoList: TList;
 QDDinfo: pTQDDinfo;
 s14, s18, s1C, s20: string;
 bo2D: Boolean;
 nC: Integer;
 LoadList: TStringList;
begin
 Result := 1;
 for i := 0 to QuestDiaryList.Count - 1 do begin
   QDDinfoList := QuestDiaryList.Items[i];
   for ii := 0 to QDDinfoList.Count - 1 do begin
     QDDinfo := QDDinfoList.Items[ii];
     QDDinfo.sList.Free;
     DisPose(QDDinfo);
   end;
   QDDinfoList.Free;
 end;
 QuestDiaryList.Clear;
 bo2D := False;
 nC := 1;
 while (True) do begin
   QDDinfoList := nil;
   s14 := 'QuestDiary\' + sub_48978C(nC) + '.txt';
   if FileExists(s14) then begin
     s18 := '';
     QDDinfo := nil;
     LoadList := TStringList.Create;
     LoadList.LoadFromFile(s14);
     for i := 0 to LoadList.Count - 1 do begin
       s1C := LoadList.Strings[i];
       if (s1C <> '') and (s1C[1] <> ';') then begin
         if (s1C[1] = '[') and (Length(s1C) > 2) then begin
           if s18 = '' then begin
             ArrestStringEx(s1C, '[', ']', s18);
             QDDinfoList := TList.Create;
             New(QDDinfo);
             QDDinfo.n00 := nC;
             QDDinfo.s04 := s18;
             QDDinfo.sList := TStringList.Create;
             QDDinfoList.Add(QDDinfo);
             bo2D := True;
           end
           else begin
             if s1C[1] <> '@' then begin
               s1C := GetValidStr3(s1C, s20, [' ', #9]);
               ArrestStringEx(s20, '[', ']', s20);
               New(QDDinfo);
               QDDinfo.n00 := StrToIntDef(s20, 0);
               QDDinfo.s04 := s1C;
               QDDinfo.sList := TStringList.Create;
               QDDinfoList.Add(QDDinfo);
               bo2D := True;
             end
             else
               bo2D := False;
           end;
         end
         else begin
           if bo2D then
             QDDinfo.sList.Add(s1C);
         end;
       end;
     end;
     LoadList.Free;
   end;
   if QDDinfoList <> nil then
     QuestDiaryList.Add(QDDinfoList)
   else
     QuestDiaryList.Add(nil);
   Inc(nC);
   if nC >= 105 then
     break;
 end;
end;
        }

function TFrmDB.LoadStartPoint(): Integer;
var
  sFileName, tStr, s18, s1C, s20, s22, s24, s26, s28, s30: string;
  LoadList: TStringList;
  i: Integer;
  StartPoint: pTStartPoint;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + RSADecodeString('Gj2YT8gu=EzNdfTjwtAt3S9AJBN9iRZ7vq'); // 'StartPoint.txt'
  if MyFileExists(sFileName) then begin
    try
      g_StartPointList.Lock;
      g_StartPointList.Clear;
      LoadList := TMsgStringList.Create;
      LoadList.LoadFromFile(sFileName);
      LoadListCall(ExtractFileName(sFileName), LoadList);
      for i := 0 to LoadList.Count - 1 do begin
        tStr := Trim(LoadList.Strings[i]);
        if (tStr <> '') and (tStr[1] <> ';') then begin
          tStr := GetValidStr3(tStr, s18, [' ', #9]);
          tStr := GetValidStr3(tStr, s1C, [' ', #9]);
          tStr := GetValidStr3(tStr, s20, [' ', #9]);
          tStr := GetValidStr3(tStr, s22, [' ', #9]);
          tStr := GetValidStr3(tStr, s24, [' ', #9]);
          tStr := GetValidStr3(tStr, s26, [' ', #9]);
          tStr := GetValidStr3(tStr, s28, [' ', #9]);
          tStr := GetValidStr3(tStr, s30, [' ', #9]);
          if (s18 <> '') and (s1C <> '') and (s20 <> '') then begin
            New(StartPoint);
            StartPoint.m_sMapName := s18;
            StartPoint.m_nCurrX := StrToIntDef(s1C, 0);
            StartPoint.m_nCurrY := StrToIntDef(s20, 0);
            //StartPoint.m_boNotAllowSay := Boolean(StrToIntDef(s22, 0));
            StartPoint.m_nRange := StrToIntDef(s24, 0);
            //StartPoint.m_nType := StrToIntDef(s26, 0);
            StartPoint.m_nPkSize := StrToIntDef(s28, 0);
            //StartPoint.m_nPkType := StrToIntDef(s30, 0);
            g_StartPointList.AddObject(s18, TObject(StartPoint));
            //g_StartPointList.AddObject(s18, TObject(MakeLong(StrToIntDef(s1C, 0), StrToIntDef(s20, 0))));
            Result := 1;
          end;
        end;
      end;
      LoadList.Free;
    finally
      g_StartPointList.UnLock;
    end;
  end;
end;

function TFrmDB.LoadUnbindList(): Integer;
var
  sFileName, tStr, sData, s20: string;
  //  tUnbind: pTUnbindInfo;
  LoadList: TStringList;
  i: Integer;
  n10: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + RSADecodeString('H=5Cb2Cc4kMGJ1TkKHdqEggBAVqWRuoIlq'); //'UnbindList.txt'
  if MyFileExists(sFileName) then begin
    LoadList := TMsgStringList.Create;
    LoadList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), LoadList);
    for i := 0 to LoadList.Count - 1 do begin
      tStr := LoadList.Strings[i];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        //New(tUnbind);
        tStr := GetValidStr3(tStr, sData, [' ', #9]);
        tStr := GetValidStrCap(tStr, s20, [' ', #9]);
        if (s20 <> '') and (s20[1] = '"') then
          ArrestStringEx(s20, '"', '"', s20);

        n10 := StrToIntDef(sData, 0);
        if n10 > 0 then
          g_UnbindList.AddObject(s20, TObject(n10))
        else begin
          Result := -i; //需要取负数
          break;
        end;
      end;
    end;
    LoadList.Free;
  end;
end;

function TFrmDB.LoadNpcScript(NPC: TNormNpc; sPatch,
  sScritpName: string): Integer;
begin
  if sPatch = '' then
    sPatch := sNpc_def;
  Result := LoadScriptFile(NPC, sPatch, sScritpName, False);
end;

function TFrmDB.LoadScriptFile(NPC: TNormNpc; sPatch, sScritpName: string; boFlag: Boolean): Integer;
var
  //nQuestIdx,
  i, ii, n1C, n20, n24: Integer;
  n6C, n70: Integer;
  sScritpFileName, s30, s34, s48, s4C, s50, sName, sText: string;
  LoadList: TStringList;
  DefineList: TList;
  s54, s58, s5C, s74: string;
  DefineInfo: pTDefineInfo;
  bo8D: Boolean;
  //Script: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
  QuestConditionInfo: pTQuestConditionInfo;
  QuestActionInfo: pTQuestActionInfo;
  Goods: pTGoods;
  MakeGoods: pTMakeGoods;
  MakeItem: pTMakeItem;
  ScriptNameList: TStringList;
  GotoList: TList;
  DelayGotoList: TList;
  PlayDiceList: TList;
  boAddMain: Boolean;
  boAdd: Boolean;
  boChange: Boolean;
  StdItem: pTStdItem;

  function FormatLabelStr(sLabel: string; var boChange: Boolean): string;
  begin
    Result := sLabel;
    boChange := False;
    if Pos('(', sLabel) > 0 then begin
      GetValidStr3(sLabel, Result, ['(']);
      boChange := True;
    end;
  end;

  procedure InitializeVariable(sLabel: string; var sMsg: string);
  var
    sLabel2, s14: string;
  begin
    sLabel2 := UpperCase(sLabel);
    if sLabel2 = sVAR_SERVERNAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_SERVERNAME);
    end
    else if sLabel2 = sVAR_SERVERIP then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_SERVERIP);
    end
    else if sLabel2 = sVAR_WEBSITE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_WEBSITE);
    end
    else if sLabel2 = sVAR_BBSSITE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BBSSITE);
    end
    else if sLabel2 = sVAR_CLIENTDOWNLOAD then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CLIENTDOWNLOAD);
    end
    else if sLabel2 = sVAR_QQ then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_QQ);
    end
    else if sLabel2 = sVAR_PHONE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_PHONE);
    end
    else if sLabel2 = sVAR_BANKACCOUNT0 then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BANKACCOUNT0);
    end
    else if sLabel2 = sVAR_BANKACCOUNT1 then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BANKACCOUNT1);
    end
    else if sLabel2 = sVAR_BANKACCOUNT2 then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BANKACCOUNT2);
    end
    else if sLabel2 = sVAR_BANKACCOUNT3 then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BANKACCOUNT3);
    end
    else if sLabel2 = sVAR_BANKACCOUNT4 then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BANKACCOUNT4);
    end
    else if sLabel2 = sVAR_BANKACCOUNT5 then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BANKACCOUNT5);
    end
    else if sLabel2 = sVAR_BANKACCOUNT6 then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BANKACCOUNT6);
    end
    else if sLabel2 = sVAR_BANKACCOUNT7 then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BANKACCOUNT7);
    end
    else if sLabel2 = sVAR_BANKACCOUNT8 then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BANKACCOUNT8);
    end
    else if sLabel2 = sVAR_BANKACCOUNT9 then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BANKACCOUNT9);
    end
    else if sLabel2 = sVAR_GAMEGOLDNAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sSTRING_GAMEGOLD);
    end
    else if sLabel2 = sVAR_GAMEPOINTNAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', sSTRING_GAMEPOINT);
    end
    else if sLabel2 = sVAR_USERCOUNT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_USERCOUNT);
    end
    else if sLabel2 = sVAR_DATETIME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_DATETIME);
    end
    else if sLabel2 = sVAR_USERNAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_USERNAME);
    end
    else if sLabel2 = sVAR_FBMAPNAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_FBMAPNAME);
    end
    else if sLabel2 = sVAR_FBMAP then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_FBMAP);
    end
    else if sLabel2 = sVAR_ACCOUNT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_ACCOUNT);
    end
    else if sLabel2 = sVAR_ASSEMBLEITEMNAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_ASSEMBLEITEMNAME);
    end
    else if sLabel2 = sVAR_MAPNAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAPNAME);
    end
    else if sLabel2 = sVAR_GUILDNAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GUILDNAME);
    end
    else if sLabel2 = sVAR_RANKNAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_RANKNAME);
    end
    else if sLabel2 = sVAR_LEVEL then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_LEVEL);
    end
    else if sLabel2 = sVAR_HP then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_HP);
    end
    else if sLabel2 = sVAR_MAXHP then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAXHP);
    end
    else if sLabel2 = sVAR_MP then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MP);
    end
    else if sLabel2 = sVAR_MAXMP then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAXMP);
    end
    else if sLabel2 = sVAR_AC then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_AC);
    end
    else if sLabel2 = sVAR_MAXAC then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAXAC);
    end
    else if sLabel2 = sVAR_MAC then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAC);
    end
    else if sLabel2 = sVAR_MAXMAC then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAXMAC);
    end
    else if sLabel2 = sVAR_DC then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_DC);
    end
    else if sLabel2 = sVAR_MAXDC then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAXDC);
    end
    else if sLabel2 = sVAR_MC then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MC);
    end
    else if sLabel2 = sVAR_MAXMC then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAXMC);
    end
    else if sLabel2 = sVAR_SC then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_SC);
    end
    else if sLabel2 = sVAR_MAXSC then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAXSC);
    end
    else if sLabel2 = sVAR_EXP then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_EXP);
    end
    else if sLabel2 = sVAR_MAXEXP then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAXEXP);
    end
    else if sLabel2 = sVAR_PKPOINT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_PKPOINT);
    end
    else if sLabel2 = sVAR_CREDITPOINT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CREDITPOINT);
    end
    else if sLabel2 = sVAR_GOLDCOUNT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GOLDCOUNT);
    end
    else if sLabel2 = sVAR_GAMEGOLD then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GAMEGOLD);
    end
    else if sLabel2 = sVAR_GAMEPOINT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GAMEPOINT);
    end
    else if sLabel2 = sVAR_LOGINTIME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_LOGINTIME);
    end
    else if sLabel2 = sVAR_LOGINLONG then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_LOGINLONG);
    end
    else if sLabel2 = sVAR_DRESS then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_DRESS);
    end
    else if sLabel2 = sVAR_WEAPON then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_WEAPON);
    end
    else if sLabel2 = sVAR_RIGHTHAND then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_RIGHTHAND);
    end
    else if sLabel2 = sVAR_HELMET then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_HELMET);
    end
    else if sLabel2 = sVAR_NECKLACE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_NECKLACE);
    end
    else if sLabel2 = sVAR_RING_R then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_RING_R);
    end
    else if sLabel2 = sVAR_RING_L then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_RING_L);
    end
    else if sLabel2 = sVAR_ARMRING_R then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_ARMRING_R);
    end
    else if sLabel2 = sVAR_ARMRING_L then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_ARMRING_L);
    end
    else if sLabel2 = sVAR_BUJUK then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BUJUK);
    end
    else if sLabel2 = sVAR_BELT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BELT);
    end
    else if sLabel2 = sVAR_BOOTS then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BOOTS);
    end
    else if sLabel2 = sVAR_CHARM then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CHARM);
    end
    else if sLabel2 = sVAR_HOUSE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_HOUSE);
    end
    else if sLabel2 = sVAR_CIMELIA then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CIMELIA);
    end
    else if sLabel2 = sVAR_IPADDR then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_IPADDR);
    end
    else if sLabel2 = sVAR_IPLOCAL then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_IPLOCAL);
    end
    else if sLabel2 = sVAR_GUILDBUILDPOINT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GUILDBUILDPOINT);
    end
    else if sLabel2 = sVAR_GUILDAURAEPOINT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GUILDAURAEPOINT);
    end
    else if sLabel2 = sVAR_GUILDSTABILITYPOINT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GUILDSTABILITYPOINT);
    end
    else if sLabel2 = sVAR_GUILDFLOURISHPOINT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GUILDFLOURISHPOINT);
    end
    else if sLabel2 = sVAR_GUILDMONEYCOUNT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GUILDMONEYCOUNT);
    end
    else if sLabel2 = sVAR_REQUESTCASTLEWARITEM then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_REQUESTCASTLEWARITEM);
    end
    else if sLabel2 = sVAR_REQUESTCASTLEWARDAY then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_REQUESTCASTLEWARDAY);
    end
    else if sLabel2 = sVAR_REQUESTBUILDGUILDITEM then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_REQUESTBUILDGUILDITEM);
    end
    else if sLabel2 = sVAR_OWNERGUILD then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_OWNERGUILD);
    end
    else if sLabel2 = sVAR_CASTLENAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CASTLENAME);
    end
    else if sLabel2 = sVAR_LORD then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_LORD);
    end
    else if sLabel2 = sVAR_GUILDWARFEE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GUILDWARFEE);
    end
    else if sLabel2 = sVAR_BUILDGUILDFEE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BUILDGUILDFEE);
    end
    else if sLabel2 = sVAR_CASTLEWARDATE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CASTLEWARDATE);
    end
    else if sLabel2 = sVAR_LISTOFWAR then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_LISTOFWAR);
    end
    else if sLabel2 = sVAR_CASTLECHANGEDATE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CASTLECHANGEDATE);
    end
    else if sLabel2 = sVAR_CASTLEWARLASTDATE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CASTLEWARLASTDATE);
    end
    else if sLabel2 = sVAR_CASTLEGETDAYS then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CASTLEGETDAYS);
    end
    else if sLabel2 = sVAR_CMD_DATE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_DATE);
    end
    else if sLabel2 = sVAR_CMD_PRVMSG then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_PRVMSG);
    end
    else if sLabel2 = sVAR_CMD_ALLOWMSG then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_ALLOWMSG);
    end
    else if sLabel2 = sVAR_CMD_LETSHOUT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_LETSHOUT);
    end
    else if sLabel2 = sVAR_CMD_LETTRADE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_LETTRADE);
    end
    else if sLabel2 = sVAR_CMD_LETGUILD then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_LETGUILD);
    end
    else if sLabel2 = sVAR_CMD_ENDGUILD then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_ENDGUILD);
    end
    else if sLabel2 = sVAR_CMD_BANGUILDCHAT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_BANGUILDCHAT);
    end
    else if sLabel2 = sVAR_CMD_AUTHALLY then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_AUTHALLY);
    end
    else if sLabel2 = sVAR_CMD_AUTH then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_AUTH);
    end
    else if sLabel2 = sVAR_CMD_AUTHCANCEL then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_AUTHCANCEL);
    end
    else if sLabel2 = sVAR_CMD_USERMOVE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_USERMOVE);
    end
    else if sLabel2 = sVAR_CMD_SEARCHING then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_SEARCHING);
    end
    else if sLabel2 = sVAR_CMD_ALLOWGROUPCALL then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_ALLOWGROUPCALL);
    end
    else if sLabel2 = sVAR_CMD_GROUPRECALLL then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_GROUPRECALLL);
    end
    else if sLabel2 = sVAR_CMD_ALLOWGUILDRECALL then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_ALLOWGUILDRECALL);
    end
    else if sLabel2 = sVAR_CMD_GUILDRECALLL then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_GUILDRECALLL);
    end
    else if sLabel2 = sVAR_CMD_DEAR then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_DEAR);
    end
    else if sLabel2 = sVAR_CMD_ALLOWDEARRCALL then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_ALLOWDEARRCALL);
    end
    else if sLabel2 = sVAR_CMD_DEARRECALL then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_DEARRECALL);
    end
    else if sLabel2 = sVAR_CMD_MASTER then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_MASTER);
    end
    else if sLabel2 = sVAR_CMD_ALLOWMASTERRECALL then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_ALLOWMASTERRECALL);
    end
    else if sLabel2 = sVAR_CMD_MASTERECALL then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_MASTERECALL);
    end
    else if sLabel2 = sVAR_CMD_TAKEONHORSE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_TAKEONHORSE);
    end
    else if sLabel2 = sVAR_CMD_TAKEOFHORSE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_TAKEOFHORSE);
    end
    else if sLabel2 = sVAR_CMD_ALLSYSMSG then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_ALLSYSMSG);
    end
    else if sLabel2 = sVAR_CMD_MEMBERFUNCTION then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_MEMBERFUNCTION);
    end
    else if sLabel2 = sVAR_CMD_MEMBERFUNCTIONEX then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_MEMBERFUNCTIONEX);
    end
    else if sLabel2 = sVAR_CASTLEGOLD then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CASTLEGOLD);
    end
    else if sLabel2 = sVAR_TODAYINCOME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_TODAYINCOME);
    end
    else if sLabel2 = sVAR_CASTLEDOORSTATE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CASTLEDOORSTATE);
    end
    else if sLabel2 = sVAR_REPAIRDOORGOLD then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_REPAIRDOORGOLD);
    end
    else if sLabel2 = sVAR_REPAIRWALLGOLD then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_REPAIRWALLGOLD);
    end
    else if sLabel2 = sVAR_GUARDFEE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GUARDFEE);
    end
    else if sLabel2 = sVAR_ARCHERFEE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_ARCHERFEE);
    end
    else if sLabel2 = sVAR_GUARDRULE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GUARDRULE);
    end
    else if sLabel2 = sVAR_STORAGE2STATE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_STORAGE2STATE);
    end
    else if sLabel2 = sVAR_STORAGE3STATE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_STORAGE3STATE);
    end
    else if sLabel2 = sVAR_STORAGE4STATE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_STORAGE4STATE);
    end
    else if sLabel2 = sVAR_STORAGE5STATE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_STORAGE5STATE);
    end
    else if sLabel2 = sVAR_SELFNAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_SELFNAME);
    end
    else if sLabel2 = sVAR_POSENAME then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_POSENAME);
    end
    else if sLabel2 = sVAR_GAMEDIAMOND then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GAMEDIAMOND);
    end
    else if sLabel2 = sVAR_GAMEGIRD then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_GAMEGIRD);
    end
    else if sLabel2 = sVAR_CMD_ALLOWFIREND then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_ALLOWFIREND);
    end
    else if sLabel2 = sVAR_EFFIGYSTATE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_EFFIGYSTATE);
    end
    else if sLabel2 = sVAR_EFFIGYOFFSET then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_EFFIGYOFFSET);
    end
    else if sLabel2 = sVAR_YEAR then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_YEAR);
    end
    else if sLabel2 = sVAR_MONTH then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MONTH);
    end
    else if sLabel2 = sVAR_DAY then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_DAY);
    end
    else if sLabel2 = sVAR_HOUR then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_HOUR);
    end
    else if sLabel2 = sVAR_MINUTE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MINUTE);
    end
    else if sLabel2 = sVAR_SEC then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_SEC);
    end
    else if sLabel2 = sVAR_MAP then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAP);
    end
    else if sLabel2 = sVAR_X then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_X);
    end
    else if sLabel2 = sVAR_Y then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_Y);
    end
    else if sLabel2 = sVAR_UNMASTER_FORCE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_UNMASTER_FORCE);
    end
    else if sLabel2 = sVAR_USERGOLDCOUNT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_USERGOLDCOUNT);
    end
    else if sLabel2 = sVAR_MAXGOLDCOUNT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_MAXGOLDCOUNT);
    end
    else if sLabel2 = sVAR_STORAGEGOLDCOUNT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_STORAGEGOLDCOUNT);
    end
    else if sLabel2 = sVAR_BINDGOLDCOUNT then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_BINDGOLDCOUNT);
    end
    else if sLabel2 = sVAR_UPGRADEWEAPONFEE then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_UPGRADEWEAPONFEE);
    end
    else if sLabel2 = sVAR_USERWEAPON then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_USERWEAPON);
    end
    else if sLabel2 = sVAR_CMD_STARTQUEST then begin
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', tVAR_CMD_STARTQUEST);
    end
    else if CompareLStr(sLabel2, sVAR_TEAM, Length(sVAR_TEAM)) then begin
      s14 := Copy(sLabel2, Length(sVAR_TEAM) + 1, 1);
      
      if s14 <> '' then begin
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', Format(tVAR_TEAM, [s14]));
      end
      else
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
    end
    else if CompareLStr(sLabel2, sVAR_HUMAN, Length(sVAR_HUMAN)) then begin
      ArrestStringEx(sLabel, '(', ')', s14);
      if s14 <> '' then begin
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', Format(tVAR_HUMAN, [s14]));
      end
      else
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
    end
    else if CompareLStr(sLabel2, sVAR_GUILD, Length(sVAR_GUILD)) then begin
      ArrestStringEx(sLabel, '(', ')', s14);
      if s14 <> '' then begin
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', Format(tVAR_GUILD, [s14]));
      end
      else
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
    end
    else if CompareLStr(sLabel2, sVAR_GLOBAL, Length(sVAR_GLOBAL)) then begin
      ArrestStringEx(sLabel, '(', ')', s14);
      if s14 <> '' then begin
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', Format(tVAR_GLOBAL, [s14]));
      end
      else
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
    end
    else if CompareLStr(sLabel2, sVAR_STR, Length(sVAR_STR)) then begin
      ArrestStringEx(sLabel, '(', ')', s14);
      if s14 <> '' then begin
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', Format(tVAR_STR, [s14]));
      end
      else
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
    end
    else if CompareLStr(sLabel2, sVAR_MISSIONARITHMOMETER, Length(sVAR_MISSIONARITHMOMETER)) then begin
      ArrestStringEx(sLabel, '(', ')', s14);
      if s14 <> '' then begin
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', Format(tVAR_MISSIONARITHMOMETER, [s14]));
      end
      else
        sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');
    end
    else
      sMsg := AnsiReplaceText(sMsg, '<' + sLabel + '>', '????');

  end;

  procedure InitializeAppendLabel(sLabel: string; nIdx: Integer);
  var
    sIdx: string;
    nIndex: Integer;
  begin
    with NPC do begin
      sLabel := UpperCase(sLabel);
      if sLabel = SPLAYOFFLINE then begin
        FGotoLable[NPLAYOFFLINE] := nIdx;
      end
      else
        {if sLabel = SSUPERREPAIROK then begin
          FGotoLable[NSUPERREPAIROK] := nIdx;
        end else
        if sLabel = SREPAIROK then begin
          FGotoLable[NREPAIROK] := nIdx;  }
        if sLabel = SMARRYERROR then begin
          FGotoLable[NMARRYERROR] := nIdx;
        end
        else if sLabel = SMASTERERROR then begin
          FGotoLable[NMASTERERROR] := nIdx;
        end
        else if sLabel = SMARRYCHECKDIR then begin
          FGotoLable[NMARRYCHECKDIR] := nIdx;
        end
        else if sLabel = SHUMANTYPEERR then begin
          FGotoLable[NHUMANTYPEERR] := nIdx;
        end
        else if sLabel = SSTARTMARRY then begin
          FGotoLable[NSTARTMARRY] := nIdx;
        end
        else if sLabel = SMARRYSEXERR then begin
          FGotoLable[NMARRYSEXERR] := nIdx;
        end
        else if sLabel = SMARRYDIRERR then begin
          FGotoLable[NMARRYDIRERR] := nIdx;
        end
        else if sLabel = SWATEMARRY then begin
          FGotoLable[NWATEMARRY] := nIdx;
        end
        else if sLabel = SREVMARRY then begin
          FGotoLable[NREVMARRY] := nIdx;
        end
        else if sLabel = SENDMARRY then begin
          FGotoLable[NENDMARRY] := nIdx;
        end
        else if sLabel = SENDMARRYFAIL then begin
          FGotoLable[NENDMARRYFAIL] := nIdx;
        end
        else if sLabel = SMASTERCHECKDIR then begin
          FGotoLable[NMASTERCHECKDIR] := nIdx;
        end
        else if sLabel = SSTARTGETMASTER then begin
          FGotoLable[NSTARTGETMASTER] := nIdx;
        end
        else if sLabel = SMASTERDIRERR then begin
          FGotoLable[NMASTERDIRERR] := nIdx;
        end
        else if sLabel = SWATEMASTER then begin
          FGotoLable[NWATEMASTER] := nIdx;
        end
        else if sLabel = SREVMASTER then begin
          FGotoLable[NREVMASTER] := nIdx;
        end
        else if sLabel = SENDMASTER then begin
          FGotoLable[NENDMASTER] := nIdx;
        end
        else if sLabel = SSTARTMASTER then begin
          FGotoLable[NSTARTMASTER] := nIdx;
        end
        else if sLabel = SENDMASTERFAIL then begin
          FGotoLable[NENDMASTERFAIL] := nIdx;
        end
        else if sLabel = SEXEMARRYFAIL then begin
          FGotoLable[NEXEMARRYFAIL] := nIdx;
        end
        else if sLabel = SUNMARRYCHECKDIR then begin
          FGotoLable[NUNMARRYCHECKDIR] := nIdx;
        end
        else if sLabel = SUNMARRYTYPEERR then begin
          FGotoLable[NUNMARRYTYPEERR] := nIdx;
        end
        else if sLabel = SSTARTUNMARRY then begin
          FGotoLable[NSTARTUNMARRY] := nIdx;
        end
        else if sLabel = SUNMARRYEND then begin
          FGotoLable[NUNMARRYEND] := nIdx;
        end
        else if sLabel = SWATEUNMARRY then begin
          FGotoLable[NWATEUNMARRY] := nIdx;
        end
        else if sLabel = SEXEMASTERFAIL then begin
          FGotoLable[NEXEMASTERFAIL] := nIdx;
        end
        else if sLabel = SUNMASTERCHECKDIR then begin
          FGotoLable[NUNMASTERCHECKDIR] := nIdx;
        end
        else if sLabel = SUNMASTERTYPEERR then begin
          FGotoLable[NUNMASTERTYPEERR] := nIdx;
        end
        else if sLabel = SUNISMASTER then begin
          FGotoLable[NUNISMASTER] := nIdx;
        end
        else if sLabel = SUNMASTERERROR then begin
          FGotoLable[NUNMASTERERROR] := nIdx;
        end
        else if sLabel = SSTARTUNMASTER then begin
          FGotoLable[NSTARTUNMASTER] := nIdx;
        end
        else if sLabel = SWATEUNMASTER then begin
          FGotoLable[NWATEUNMASTER] := nIdx;
        end
        else if sLabel = SUNMASTEREND then begin
          FGotoLable[NUNMASTEREND] := nIdx;
        end
        else if sLabel = SREVUNMASTER then begin
          FGotoLable[NREVUNMASTER] := nIdx;
        end
        else if sLabel = SSUPREQUEST_OK then begin
          FGotoLable[NSUPREQUEST_OK] := nIdx;
        end
        else if sLabel = SMEMBER then begin
          FGotoLable[NMEMBER] := nIdx;
        end
        else if sLabel = SPLAYRECONNECTION then begin
          FGotoLable[NPLAYRECONNECTION] := nIdx;
        end
        else if sLabel = SLOGIN then begin
          FGotoLable[NLOGIN] := nIdx;
        end
        else if sLabel = SPLAYDIE then begin
          FGotoLable[NPLAYDIE] := nIdx;
        end
        else if sLabel = SKILLPLAY then begin
          FGotoLable[NKILLPLAY] := nIdx;
        end
        else if sLabel = SPLAYLEVELUP then begin
          FGotoLable[NPLAYLEVELUP] := nIdx;
        end
        else if sLabel = SKILLMONSTER then begin
          FGotoLable[NKILLMONSTER] := nIdx;
        end
        else if sLabel = SCREATEECTYPE_IN then begin
          FGotoLable[NCREATEECTYPE_IN] := nIdx;
        end
        else if sLabel = SCREATEECTYPE_OK then begin
          FGotoLable[NCREATEECTYPE_OK] := nIdx;
        end
        else if sLabel = SCREATEECTYPE_FAIL then begin
          FGotoLable[NCREATEECTYPE_FAIL] := nIdx;
        end
        else if sLabel = SRESUME then begin
          FGotoLable[NRESUME] := nIdx;
        end
        else if sLabel = SGETLARGESSGOLD_OK then begin
          FGotoLable[NGETLARGESSGOLD_OK] := nIdx;
        end
        else if sLabel = SGETLARGESSGOLD_FAIL then begin
          FGotoLable[NGETLARGESSGOLD_FAIL] := nIdx;
        end
        else if sLabel = SGETLARGESSGOLD_ERROR then begin
          FGotoLable[NGETLARGESSGOLD_ERROR] := nIdx;
        end
        else if sLabel = SMASTERISPRENTICE then begin
          FGotoLable[NMASTERISPRENTICE] := nIdx;
        end
        else if sLabel = SMASTERISFULL then begin
          FGotoLable[NMASTERISFULL] := nIdx;
        end
        else if sLabel = SGROUPCREATE then begin
          FGotoLable[NGROUPCREATE] := nIdx;
        end
        else if sLabel = SSTARTGROUP then begin
          FGotoLable[NSTARTGROUP] := nIdx;
        end
        else if sLabel = SJOINGROUP then begin
          FGotoLable[NJOINGROUP] := nIdx;
        end
        else if sLabel = SSPEEDCLOSE then begin
          FGotoLable[NSPEEDCLOSE] := nIdx;
        end
        else if sLabel = SUPGRADENOW_OK then begin
          FGotoLable[NUPGRADENOW_OK] := nIdx;
        end
        else if sLabel = SUPGRADENOW_ING then begin
          FGotoLable[NUPGRADENOW_ING] := nIdx;
        end
        else if sLabel = SUPGRADENOW_FAIL then begin
          FGotoLable[NUPGRADENOW_FAIL] := nIdx;
        end
        else if sLabel = SGETBACKUPGNOW_OK then begin
          FGotoLable[NGETBACKUPGNOW_OK] := nIdx;
        end
        else if sLabel = SGETBACKUPGNOW_ING then begin
          FGotoLable[NGETBACKUPGNOW_ING] := nIdx;
        end
        else if sLabel = SGETBACKUPGNOW_FAIL then
        begin
          FGotoLable[NGETBACKUPGNOW_FAIL] := nIdx;
        end
        else if sLabel = SGETBACKUPGNOW_BAGFULL then
        begin
          FGotoLable[NGETBACKUPGNOW_BAGFULL] := nIdx;
        end
        else if sLabel = STAKEONITEMS then
        begin
          FGotoLable[NTAKEONITEMS] := nIdx;
        end
        else if sLabel = STAKEOFFITEMS then
        begin
          FGotoLable[NTAKEOFFITEMS] := nIdx;
        end
        else if sLabel = SPLAYREVIVE then
        begin
          FGotoLable[NPLAYREVIVE] := nIdx;
        end
        else if sLabel = SMOVEABILITY_OK then
        begin
          FGotoLable[NMOVEABILITY_OK] := nIdx;
        end
        else if sLabel = SMOVEABILITY_FAIL then
        begin
          FGotoLable[NMOVEABILITY_FAIL] := nIdx;
        end
        else if sLabel = SASSEMBLEALL then
        begin
          FGotoLable[NASSEMBLEALL] := nIdx;
        end
        else if sLabel = SASSEMBLEWEAPON then
        begin
          FGotoLable[NASSEMBLEWEAPON] := nIdx;
        end
        else if sLabel = SASSEMBLEDRESS then
        begin
          FGotoLable[NASSEMBLEDRESS] := nIdx;
        end
        else if sLabel = SASSEMBLEHELMET then
        begin
          FGotoLable[NASSEMBLEHELMET] := nIdx;
        end
        else if sLabel = SASSEMBLENECKLACE then
        begin
          FGotoLable[NASSEMBLENECKLACE] := nIdx;
        end
        else if sLabel = SASSEMBLERING then
        begin
          FGotoLable[NASSEMBLERING] := nIdx;
        end
        else if sLabel = SASSEMBLEARMRING then
        begin
          FGotoLable[NASSEMBLEARMRING] := nIdx;
        end
        else if sLabel = SASSEMBLEBELT then
        begin
          FGotoLable[NASSEMBLEBELT] := nIdx;
        end
        else if sLabel = SASSEMBLEBOOT then
        begin
          FGotoLable[NASSEMBLEBOOT] := nIdx;
        end
        else if sLabel = SASSEMBLEFAIL then
        begin
          FGotoLable[NASSEMBLEFAIL] := nIdx;
        end
        else begin
          if m_btNPCRaceServer = NPC_RC_FUNMERCHANT then begin
            with NPC as TFunMerchant do begin
              if CompareLStr(sLabel, SSTDMODEFUNC, Length(SSTDMODEFUNC)) then begin
                sIdx := Copy(sLabel, Length(SSTDMODEFUNC) + 1, Length(SSTDMODEFUNC));
                nIndex := StrToIntDef(sIdx, -1);
                if nIndex in [Low(FStdModeFunc)..High(FStdModeFunc)] then
                  FStdModeFunc[nIndex] := nIdx;
              end
              else if CompareLStr(sLabel, SPLAYLEVELUPEX, Length(SPLAYLEVELUPEX)) then begin
                sIdx := Copy(sLabel, Length(SPLAYLEVELUPEX) + 1, Length(SPLAYLEVELUPEX));
                nIndex := StrToIntDef(sIdx, -1);
                if nIndex in [Low(FPlayLevelUp)..High(FPlayLevelUp)] then
                  FPlayLevelUp[nIndex] := nIdx;
              end
              else if CompareLStr(sLabel, SUSERCMD, Length(SUSERCMD)) then begin
                sIdx := Copy(sLabel, Length(SUSERCMD) + 1, Length(SUSERCMD));
                nIndex := StrToIntDef(sIdx, -1);
                if nIndex in [Low(FUserCmd)..High(FUserCmd)] then
                  FUserCmd[nIndex] := nIdx;
              end
              else if CompareLStr(sLabel, SCLEARMISSION, Length(SCLEARMISSION)) then begin
                sIdx := Copy(sLabel, Length(SCLEARMISSION) + 1, Length(SCLEARMISSION));
                nIndex := StrToIntDef(sIdx, -1);
                if nIndex in [Low(FClearMission)..High(FClearMission)] then
                  FClearMission[nIndex] := nIdx;
              end
              else if CompareLStr(sLabel, SMAGSELFFUNC, Length(SMAGSELFFUNC)) then begin
                sIdx := Copy(sLabel, Length(SMAGSELFFUNC) + 1, Length(SMAGSELFFUNC));
                nIndex := StrToIntDef(sIdx, -1);
                if nIndex in [Low(FMagSelfFunc)..High(FMagSelfFunc)] then
                  FMagSelfFunc[nIndex] := nIdx;
              end
              else if CompareLStr(sLabel, SMAGTAGFUNC, Length(SMAGTAGFUNC)) then begin
                sIdx := Copy(sLabel, Length(SMAGTAGFUNC) + 1, Length(SMAGTAGFUNC));
                nIndex := StrToIntDef(sIdx, -1);
                if nIndex in [Low(FMagTagFunc)..High(FMagTagFunc)] then
                  FMagTagFunc[nIndex] := nIdx;
              end
              else if CompareLStr(sLabel, SMAGTAGFUNCEX, Length(SMAGTAGFUNCEX)) then begin
                sIdx := Copy(sLabel, Length(SMAGTAGFUNCEX) + 1, Length(SMAGTAGFUNCEX));
                nIndex := StrToIntDef(sIdx, -1);
                if nIndex in [Low(FMagTagFuncEx)..High(FMagTagFuncEx)] then
                  FMagTagFuncEx[nIndex] := nIdx;
              end
              else if CompareLStr(sLabel, SMAGMONFUNC, Length(SMAGMONFUNC)) then begin
                sIdx := Copy(sLabel, Length(SMAGMONFUNC) + 1, Length(SMAGMONFUNC));
                nIndex := StrToIntDef(sIdx, -1);
                if nIndex in [Low(FMagMonFunc)..High(FMagMonFunc)] then
                  FMagMonFunc[nIndex] := nIdx;
              end;
            end;
          end;
        end;
    end;
  end;

  function InitializeProcedure(sMsg: string): string;
  var
    nC: Integer;
    s10: string;
    tempstr: string;
  begin
    nC := 0;
    tempstr := sMsg;
    while (True) do begin
      if pos('>', tempstr) <= 0 then
        break;
      tempstr := ArrestStringEx(tempstr, '<', '>', s10);
      if s10 <> '' then begin
        if s10[1] = '$' then begin
          InitializeVariable(s10, sMsg);
        end;
      end
      else
        break;
      Inc(nC);
      if nC >= 100 then
        break;
    end;
    Result := sMsg;
  end;

  function InitializeSayMsg(sMsg: string; var StringList: TStringList; var OldStringList: TStringList): string;
  var
    nC: Integer;
    s10: string;
    tempstr: string;
    sLabel: string;
    sname: string;
    nIdx, nChangeIndex: Integer;
    nNotIdx: Integer;
    boChange: Boolean;
    boAddResetLabel: Boolean;
  begin
    nC := 0;
    nNotIdx := -1;
    nChangeIndex := 1;
    tempstr := sMsg;
    boAddResetLabel := False;
    while (True) do begin
      if pos('>', tempstr) <= 0 then
        break;
      tempstr := ArrestStringEx(tempstr, '<', '>', s10);
      if s10 <> '' then begin
        if pos('/', s10) > 0 then begin
          sLabel := GetValidStr3(s10, sname, ['/']);
          if CompareText(sLabel, '@close') = 0 then
            Continue;
          if CompareText(sLabel, '@Exit') = 0 then
            Continue;
          if CompareLStr(sLabel, '@Move(', Length('@Move(')) then
            Continue;
          if CompareLStr(sLabel, '~@', Length('~@')) then
            Continue;
          if CompareLStr(sLabel, '@@', Length('@@')) then begin
            if not boAddResetLabel then begin
              boAddResetLabel := True;
              sMsg := RESETLABEL + sMsg;
            end;
            Continue;
          end;
          nIdx := ScriptNameList.IndexOf(FormatLabelStr(sLabel, boChange));
          if nIdx = -1 then begin
            nIdx := nNotIdx;
            Dec(nNotIdx);
          end
          else if boChange then begin
            nIdx := nChangeIndex * 100000 + nIdx;
            Inc(nChangeIndex);
          end;
          OldStringList.Add(sLabel);
          try
            if (Length(sLabel) >= 2) and (sLabel[2] = '@') and (sLabel[1] = '@') then
              sLabel := '@@' + IntToStr(nIdx)
            else
              sLabel := '@' + IntToStr(nIdx);
          finally
            StringList.Add(sLabel);
          end;
          sMsg := AnsiReplaceText(sMsg, '<' + s10 + '>', '<' + sname + '/' + sLabel + '>');
        end
        else if s10[1] = '$' then begin
          InitializeVariable(s10, sMsg);
        end;
      end
      else
        break;
      Inc(nC);
      if nC >= 100 then
        break;
    end;
    Result := sMsg;
  end;
  { function MakeNewSayingRecord(sLabel: string): pTSayingRecord;
   begin
     New(Result);
     Result.ProcedureList := TList.Create;
     Result.sLabel := sSUPERREPAIR;
     Result.boExtJmp := False;
   end;    }

  { procedure InitializeCorpsLabel();
   begin
     if ScriptNameList.IndexOf(sSUPERREPAIR) = -1 then begin
       NPC.m_ScriptList.Add(MakeNewSayingRecord(sSUPERREPAIR));
       ScriptNameList.Add(sSUPERREPAIR);
     end;
   end;     }

  procedure InitializeLabel();
  var
    i, ii: integer;
    nIdx: integer;
    boChange: Boolean;
  begin
    //InitializeCorpsLabel;
    with NPC do begin
      for i := Low(FGotoLable) to High(FGotoLable) do
        FGotoLable[i] := -1;
      if m_btNPCRaceServer = NPC_RC_FUNMERCHANT then begin
        with NPC as TFunMerchant do begin
          for i := Low(FStdModeFunc) to High(FStdModeFunc) do
            FStdModeFunc[i] := -1;
          for i := Low(FPlayLevelUp) to High(FPlayLevelUp) do
            FPlayLevelUp[i] := -1;
          for i := Low(FUserCmd) to High(FUserCmd) do
            FUserCmd[i] := -1;
          for i := Low(FClearMission) to High(FClearMission) do
            FClearMission[i] := -1;
          for i := Low(FMagSelfFunc) to High(FMagSelfFunc) do
            FMagSelfFunc[i] := -1;
          for i := Low(FMagTagFunc) to High(FMagTagFunc) do
            FMagTagFunc[i] := -1;
          for i := Low(FMagTagFuncEx) to High(FMagTagFuncEx) do
            FMagTagFuncEx[i] := -1;
          for i := Low(FMagMonFunc) to High(FMagMonFunc) do
            FMagMonFunc[i] := -1;
        end;
      end;
    end;
    for I := 0 to PlayDiceList.Count - 1 do begin
      QuestActionInfo := PlayDiceList[i];
      nIdx := ScriptNameList.IndexOf(FormatLabelStr(QuestActionInfo.sParam2, boChange));
      QuestActionInfo.sParam2 := '@' + IntToStr(nIdx);
    end;
    for I := 0 to GotoList.Count - 1 do begin
      QuestActionInfo := GotoList[i];
      nIdx := ScriptNameList.IndexOf(FormatLabelStr(QuestActionInfo.sParam1, boChange));
      QuestActionInfo.nParam1 := nIdx;
    end;
    for I := 0 to DelayGotoList.Count - 1 do begin
      QuestActionInfo := DelayGotoList[i];
      nIdx := ScriptNameList.IndexOf(FormatLabelStr(QuestActionInfo.sParam2, boChange));
      QuestActionInfo.nParam2 := nIdx;
    end;
    for I := 0 to NPC.m_ScriptList.Count - 1 do begin
      SayingRecord := NPC.m_ScriptList[i];
      for ii := 0 to SayingRecord.ProcedureList.Count - 1 do begin
        SayingProcedure := SayingRecord.ProcedureList[ii];
        if SayingProcedure.sSayMsg <> '' then begin
          SayingProcedure.sSayMsg := InitializeSayMsg(SayingProcedure.sSayMsg,
            SayingProcedure.SayNewLabelList, SayingProcedure.SayOldLabelList);
        end;
        if SayingProcedure.sElseSayMsg <> '' then begin
          SayingProcedure.sElseSayMsg := InitializeSayMsg(SayingProcedure.sElseSayMsg,
            SayingProcedure.ElseSayNewLabelList, SayingProcedure.ElseSayOldLabelList);
        end;
      end;
      InitializeAppendLabel(SayingRecord.sLabel, I);
    end;
  end;

  function LoadCallScript(sFileName, sLabel: string; nIdx: Integer; var List: TStringList):
      Boolean;
  var
    i: Integer;
    LoadStrList: TStringList;
    bo1D: Boolean;
    s18: string;
  begin
    Result := False;
    if MyFileExists(sFileName) then begin
      LoadStrList := TMsgStringList.Create;
      LoadStrList.LoadFromFile(sFileName);
      DeCodeStringList(LoadStrList);
      sLabel := '[' + sLabel + ']';
      bo1D := False;
      for i := 0 to LoadStrList.Count - 1 do begin
        s18 := Trim(LoadStrList.Strings[i]);
        if s18 <> '' then begin
          if not bo1D then begin
            if (s18[1] = '[') and (CompareText(s18, sLabel) = 0) then begin
              bo1D := True;
              //List.Add(s18);   2010-1-1 取消
            end;
          end
          else begin
            if s18 <> '{' then begin
              if s18 = '}' then begin
                //bo1D := False;
                Result := True;
                break;
              end
              else begin
                //List.Add(s18);
                List.Insert(nIdx, LoadStrList[i]);
                Inc(nIdx);
              end;
            end;
          end;
        end; //00489CE4 if s18 <> '' then begin
      end; // for I := 0 to LoadStrList.Count - 1 do begin
      LoadStrList.Free;
    end;
  end;

  function LoadOldCallScript(sFileName, sLabel: string; List: TStringList): Boolean; //00489BD4
  var
    I: Integer;
    LoadStrList: TStringList;
    bo1D: Boolean;
    s18: string;
  begin
    Result := False;
    SayingProcedure := nil;
    if MyFileExists(sFileName) then begin
      LoadStrList := TMsgStringList.Create;
      LoadStrList.LoadFromFile(sFileName);
      DeCodeStringList(LoadStrList);
      sLabel := '[' + sLabel + ']';
      bo1D := False;
      for I := 0 to LoadStrList.Count - 1 do begin
        s18 := Trim(LoadStrList.Strings[i]);
        if s18 <> '' then begin
          if not bo1D then begin
            if (s18[1] = '[') and (CompareText(s18, sLabel) = 0) then begin
              bo1D := True;
              List.Add(s18);
            end;
          end
          else begin
            if s18[1] <> '{' then begin
              if s18[1] = '}' then begin
                Result := True;
                break;
              end
              else begin
                List.Add(s18);
              end;
            end;
          end;
        end;
      end;
      LoadStrList.Free;
    end;
  end;

  procedure LoadScriptcall(sLoadName: string; var LoadList: TStringList);
  var
    i: Integer;
    s14, s18, s1C, s20, s34: string;
    Ing, nIdx, nCount: Integer;
    CallNameList: TStringList;
  begin
    i := 0;
    Ing := 0;
    //for i := 0 to LoadList.Count - 1 do begin
    CallNameList := TStringList.Create;
    while (I < LoadList.Count) do begin //Jason 071209修改
      if Ing > 5000 then begin
        MainOutMessage('#CALL调用死循环 ' + sLoadName);
        break;
      end;
      s14 := Trim(LoadList.Strings[i]);
      if (s14 <> '') and (s14[1] = '#') and (CompareLStr(s14, '#CALL', Length('#CALL'))) then begin
        Inc(Ing);
        s14 := ArrestStringEx(s14, '[', ']', s1C);
        s20 := Trim(s1C);
        s18 := Trim(s14);
        if s20[1] = '\' then
          s20 := Copy(s20, 2, Length(s20) - 1);
        if s20[2] = '\' then
          s20 := Copy(s20, 3, Length(s20) - 2);
        s34 := g_Config.sEnvirDir + 'QuestDiary\' + s20;
        LoadList.Strings[i] := '';
        nIdx := CallNameList.IndexOf(s20 + '*' + s18);
        if nIdx > -1 then begin
          nCount := Integer(CallNameList.Objects[nIdx]);
          Inc(nCount);
          if nCount > 100 then begin
            MainOutMessage('#CALL调用死循环 ' + sLoadName + ' ' + s20 + ' ' + s18);
            break;
          end;
          CallNameList.Objects[nIdx] := TObject(nCount);
        end
        else
          CallNameList.AddObject(s20 + '*' + s18, nil);
        if g_Config.boCanNewCall then begin
          if not LoadCallScript(s34, s18, I + 1, LoadList) then begin
            MainOutMessage('脚本错误, load fail: ' + s20 + ' ' + s18);
          end;
        end
        else begin
          if LoadOldCallScript(s34, s18, LoadList) then begin
            LoadList.Strings[i] := '#ACT';
            LoadList.Insert(i + 1, 'goto ' + s18);
          end
          else
            MainOutMessage('脚本错误, load fail: ' + s20 + ' ' + s18);
        end;
      end;
      Inc(I);
    end;
    CallNameList.Free;
  end;

  function LoadDefineInfo(var LoadList: TStringList; var List: TList): string;
  var
    i: Integer;
    s14, s28, s1C, s20, s24: string;
    DefineInfo: pTDefineInfo;
    LoadStrList: TStringList;
  begin
    for i := 0 to LoadList.Count - 1 do begin
      s14 := Trim(LoadList.Strings[i]);
      if (s14 <> '') and (s14[1] = '#') then begin
        if CompareLStr(s14, '#SETHOME', Length('#SETHOME')) then begin
          Result := Trim(GetValidStr3(s14, s1C, [' ', #9]));
          LoadList.Strings[i] := '';
        end;
        if CompareLStr(s14, '#DEFINE', Length('#DEFINE')) then begin
          s14 := (GetValidStr3(s14, s1C, [' ', #9]));
          s14 := (GetValidStr3(s14, s20, [' ', #9]));
          s14 := (GetValidStr3(s14, s24, [' ', #9]));
          New(DefineInfo);
          DefineInfo.sName := UpperCase(s20);
          DefineInfo.sText := s24;
          List.Add(DefineInfo);
          LoadList.Strings[i] := '';
        end;
        if CompareLStr(s14, '#INCLUDE', Length('#INCLUDE')) then begin
          s28 := Trim(GetValidStr3(s14, s1C, [' ', #9]));
          s28 := g_Config.sEnvirDir + 'Defines\' + s28;
          if MyFileExists(s28) then begin
            LoadStrList := TMsgStringList.Create;
            LoadStrList.LoadFromFile(s28);
            Result := LoadDefineInfo(LoadStrList, List);
            LoadStrList.Free;
          end
          else begin
            MainOutMessage('脚本错误, load fail: ' + s28);
          end;
          LoadList.Strings[i] := '';
        end;
      end;
    end;
  end;
  {function MakeNewScript(): pTScript;
  var
    ScriptInfo: pTScript;
  begin
    New(ScriptInfo);
    //ScriptInfo.boQuest := False;
    //SafeFillChar(ScriptInfo.QuestInfo, SizeOf(TQuestInfo) * 10, #0);
    nQuestIdx := 0;
    ScriptInfo.RecordList := TList.Create;
    NPC.m_ScriptList.Add(ScriptInfo);
    Result := ScriptInfo;
  end;   }
  function QuestCondition(sText: string; var QuestConditionInfo: pTQuestConditionInfo): Boolean; //00489DDC
  var
    sCmd, sParam1, sParam2, sParam3, sParam4, sParam5, sParam6, sParam7, sParam8, sParam9, sTemp: string;
    nCMDCode: Integer;
    boResult: Boolean;
  label
    L001;
  begin
    Result := False;
    boResult := True;
    sText := GetValidStrCap(sText, sCmd, [' ', #9]);
    if CompareText(sCmd, 'NOT') = 0 then begin
      boResult := False;
      sText := GetValidStrCap(sText, sCmd, [' ', #9]);
    end;
    sText := GetValidStrCap(sText, sParam1, [' ', #9]);
    sText := GetValidStrCap(sText, sParam2, [' ', #9]);
    sText := GetValidStrCap(sText, sParam3, [' ', #9]);
    sText := GetValidStrCap(sText, sParam4, [' ', #9]);
    sText := GetValidStrCap(sText, sParam5, [' ', #9]);
    sText := GetValidStrCap(sText, sParam6, [' ', #9]);
    sText := GetValidStrCap(sText, sParam7, [' ', #9]);
    sText := GetValidStrCap(sText, sParam8, [' ', #9]);
    sText := GetValidStrCap(sText, sParam9, [' ', #9]);

    sTemp := GetValidStrCap(sCmd, sCmd, ['.']);
    while (sTemp <> '') do begin
      if QuestConditionInfo.TCmdList = nil then
        QuestConditionInfo.TCmdList := TStringList.Create;
      QuestConditionInfo.TCmdList.Add(InitializeProcedure(sCmd));
      sTemp := GetValidStrCap(sTemp, sCmd, ['.']);
    end;

    sCmd := UpperCase(sCmd);
    nCMDCode := 0;
    if sCmd = sCHECK then begin
      nCMDCode := nCHECK;
      {ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;}
      goto L001;
    end;
    if sCmd = sSC_CHECKMISSION then begin
      nCMDCode := nSC_CHECKMISSION;
      {ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;}
      goto L001;
    end;
    if sCmd = sCHECKPKPOINT then begin
      nCMDCode := nCHECKPKPOINT;
      goto L001;
    end;
    if sCmd = sCHECKGOLD then begin
      nCMDCode := nCHECKGOLD;
      goto L001;
    end;
    if sCmd = sCHECKLEVEL then begin
      nCMDCode := nCHECKLEVEL;
      goto L001;
    end;
    if sCmd = sCHECKJOB then begin
      nCMDCode := nCHECKJOB;
      goto L001;
    end;
    if sCmd = sRANDOM then begin
      nCMDCode := nRANDOM;
      goto L001;
    end;
    if sCmd = sCHECKITEM then begin
      nCMDCode := nCHECKITEM;
      goto L001;
    end;
    if sCmd = sGENDER then begin
      nCMDCode := nGENDER;
      goto L001;
    end;
    if sCmd = sCHECKBAGGAGE then begin
      nCMDCode := nCHECKBAGGAGE;
      goto L001;
    end;

    if sCmd = sCHECKNAMELIST then begin
      nCMDCode := nCHECKNAMELIST;
      goto L001;
    end;
    if sCmd = sSC_HASGUILD then begin
      nCMDCode := nSC_HASGUILD;
      goto L001;
    end;

    if sCmd = sSC_ISGUILDMASTER then begin
      nCMDCode := nSC_ISGUILDMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEMASTER then begin
      nCMDCode := nSC_CHECKCASTLEMASTER;
      goto L001;
    end;
    if sCmd = sSC_ISNEWHUMAN then begin
      nCMDCode := nSC_ISNEWHUMAN;
      goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERTYPE then begin
      nCMDCode := nSC_CHECKMEMBERTYPE;
      goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERLEVEL then begin
      nCMDCode := nSC_CHECKMEMBERLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEPOINT then begin
      nCMDCode := nSC_CHECKGAMEPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKNAMELISTPOSITION then begin
      nCMDCode := nSC_CHECKNAMELISTPOSITION;
      goto L001;
    end;
    if sCmd = sSC_CHECKGUILDLIST then begin
      nCMDCode := nSC_CHECKGUILDLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKRENEWLEVEL then begin
      nCMDCode := nSC_CHECKRENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVELEVEL then begin
      nCMDCode := nSC_CHECKSLAVELEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVENAME then begin
      nCMDCode := nSC_CHECKSLAVENAME;
      goto L001;
    end;
    if sCmd = sSC_CHECKCREDITPOINT then begin
      nCMDCode := nSC_CHECKCREDITPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKOFGUILD then begin
      nCMDCode := nSC_CHECKOFGUILD;
      goto L001;
    end;
    if sCmd = sSC_CHECKUSEITEM then begin
      nCMDCode := nSC_CHECKUSEITEM;
      goto L001;
    end;
    if sCmd = sSC_CHECKBAGSIZE then begin
      nCMDCode := nSC_CHECKBAGSIZE;
      goto L001;
    end;
    if sCmd = sSC_CHECKLISTCOUNT then begin
      nCMDCode := nSC_CHECKLISTCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKDC then begin
      nCMDCode := nSC_CHECKDC;
      goto L001;
    end;
    if sCmd = sSC_CHECKMC then begin
      nCMDCode := nSC_CHECKMC;
      goto L001;
    end;
    if sCmd = sSC_CHECKSC then begin
      nCMDCode := nSC_CHECKSC;
      goto L001;
    end;
    if sCmd = sSC_CHECKHP then begin
      nCMDCode := nSC_CHECKHP;
      goto L001;
    end;
    if sCmd = sSC_CHECKMP then begin
      nCMDCode := nSC_CHECKMP;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMTYPE then begin
      nCMDCode := nSC_CHECKITEMTYPE;
      goto L001;
    end;
    if sCmd = sSC_CHECKEXP then begin
      nCMDCode := nSC_CHECKEXP;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEGOLD then begin
      nCMDCode := nSC_CHECKCASTLEGOLD;
      goto L001;
    end;
    if sCmd = sSC_CHECKBUILDPOINT then begin
      nCMDCode := nSC_CHECKBUILDPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKAURAEPOINT then begin
      nCMDCode := nSC_CHECKAURAEPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKSTABILITYPOINT then begin
      nCMDCode := nSC_CHECKSTABILITYPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKFLOURISHPOINT then begin
      nCMDCode := nSC_CHECKFLOURISHPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKCONTRIBUTION then begin
      nCMDCode := nSC_CHECKCONTRIBUTION;
      goto L001;
    end;
    if sCmd = sSC_CHECKRANGEMONCOUNT then begin
      nCMDCode := nSC_CHECKRANGEMONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMADDVALUE then begin
      nCMDCode := nSC_CHECKITEMADDVALUE;
      goto L001;
    end;
    if sCmd = sSC_CHECKINMAPRANGE then begin
      nCMDCode := nSC_CHECKINMAPRANGE;
      goto L001;
    end;
    if sCmd = sSC_CASTLECHANGEDAY then begin
      nCMDCode := nSC_CASTLECHANGEDAY;
      goto L001;
    end;
    if sCmd = sSC_CASTLEWARDAY then begin
      nCMDCode := nSC_CASTLEWARDAY;
      goto L001;
    end;
    if sCmd = sSC_ONLINELONGMIN then begin
      nCMDCode := nSC_ONLINELONGMIN;
      goto L001;
    end;
    if sCmd = sSC_CHECKGUILDCHIEFITEMCOUNT then begin
      nCMDCode := nSC_CHECKGUILDCHIEFITEMCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKNAMEDATELIST then begin
      nCMDCode := nSC_CHECKNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKMAPHUMANCOUNT then begin
      nCMDCode := nSC_CHECKMAPHUMANCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMAPMONCOUNT then begin
      nCMDCode := nSC_CHECKMAPMONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKVAR then begin
      nCMDCode := nSC_CHECKVAR;
      goto L001;
    end;
    if sCmd = sSC_CHECKSERVERNAME then begin
      nCMDCode := nSC_CHECKSERVERNAME;
      goto L001;
    end;
    if sCmd = sSC_ISATTACKGUILD then begin
      nCMDCode := nSC_ISATTACKGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISDEFENSEGUILD then begin
      nCMDCode := nSC_ISDEFENSEGUILD;
      goto L001;
    end;
    {if sCmd = sSC_ISATTACKALLYGUILD then begin
      nCMDCode := nSC_ISATTACKALLYGUILD;
      goto L001;
    end;   }
    if sCmd = sSC_ISDEFENSEALLYGUILD then begin
      nCMDCode := nSC_ISDEFENSEALLYGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISCASTLEGUILD then begin
      nCMDCode := nSC_ISCASTLEGUILD;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEDOOR then begin
      nCMDCode := nSC_CHECKCASTLEDOOR;
      goto L001;
    end;
    if sCmd = sSC_ISSYSOP then begin
      nCMDCode := nSC_ISSYSOP;
      goto L001;
    end;
    if sCmd = sSC_ISADMIN then begin
      nCMDCode := nSC_ISADMIN;
      goto L001;
    end;
    if sCmd = sSC_CHECKGROUPCOUNT then begin
      nCMDCode := nSC_CHECKGROUPCOUNT;
      goto L001;
    end;
    if sCmd = sCHECKACCOUNTLIST then begin
      nCMDCode := nCHECKACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sCHECKIPLIST then begin
      nCMDCode := nCHECKIPLIST;
      goto L001;
    end;
    if sCmd = sCHECKBBCOUNT then begin
      nCMDCode := nCHECKBBCOUNT;
      goto L001;
    end;
    if sCmd = sCHECKITEMW then begin
      nCMDCode := nCHECKITEMW;
      goto L001;
    end;
    if sCmd = sCHECKDURA then begin
      nCMDCode := nCHECKDURA;
      goto L001;
    end;
    if sCmd = sDAYOFWEEK then begin
      nCMDCode := nDAYOFWEEK;
      goto L001;
    end;
    if sCmd = sHOUR then begin
      nCMDCode := nHOUR;
      goto L001;
    end;
    if sCmd = sMIN then begin
      nCMDCode := nMIN;
      goto L001;
    end;
    if sCmd = sCHECKMONMAP then begin
      nCMDCode := nCHECKMONMAP;
      goto L001;
    end;
    if sCmd = sCHECKHUM then begin
      nCMDCode := nCHECKHUM;
      goto L001;
    end;
    if sCmd = sEQUAL then begin
      nCMDCode := nEQUAL;
      goto L001;
    end;
    if sCmd = sLARGE then begin
      nCMDCode := nLARGE;
      goto L001;
    end;
    if sCmd = sSMALL then begin
      nCMDCode := nSMALL;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEDIR then begin
      nCMDCode := nSC_CHECKPOSEDIR;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSELEVEL then begin
      nCMDCode := nSC_CHECKPOSELEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEGENDER then begin
      nCMDCode := nSC_CHECKPOSEGENDER;
      goto L001;
    end;
    if sCmd = sSC_CHECKLEVELEX then begin
      nCMDCode := nSC_CHECKLEVELEX;
      goto L001;
    end;
    if sCmd = sSC_CHECKBONUSPOINT then begin
      nCMDCode := nSC_CHECKBONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMARRY then begin
      nCMDCode := nSC_CHECKMARRY;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMARRY then begin
      nCMDCode := nSC_CHECKPOSEMARRY;
      goto L001;
    end;
    if sCmd = sSC_CHECKMARRYCOUNT then begin
      nCMDCode := nSC_CHECKMARRYCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMASTER then begin
      nCMDCode := nSC_CHECKMASTER;
      goto L001;
    end;
    if sCmd = sSC_HAVEMASTER then begin
      nCMDCode := nSC_HAVEMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMASTER then begin
      nCMDCode := nSC_CHECKPOSEMASTER;
      goto L001;
    end;
    if sCmd = sSC_POSEHAVEMASTER then begin
      nCMDCode := nSC_POSEHAVEMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKISMASTER then begin
      nCMDCode := nSC_CHECKISMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEISMASTER then begin
      nCMDCode := nSC_CHECKPOSEISMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKNAMEIPLIST then begin
      nCMDCode := nSC_CHECKNAMEIPLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKACCOUNTIPLIST then begin
      nCMDCode := nSC_CHECKACCOUNTIPLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVECOUNT then begin
      nCMDCode := nSC_CHECKSLAVECOUNT;
      goto L001;
    end;
    if sCmd = sCHECKMAPNAME then begin
      nCMDCode := nCHECKMAPNAME;
      goto L001;
    end;
    if sCmd = sINSAFEZONE then begin
      nCMDCode := nINSAFEZONE;
      goto L001;
    end;
    if sCmd = sCHECKSKILL then begin
      nCMDCode := nCHECKSKILL;
      goto L001;
    end;
    if sCmd = sSC_CHECKUSERDATE then begin
      nCMDCode := nSC_CHECKNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKCONTAINSTEXT then begin
      nCMDCode := nSC_CHECKCONTAINSTEXT;
      goto L001;
    end;
    if sCmd = sSC_COMPARETEXT then begin
      nCMDCode := nSC_COMPARETEXT;
      goto L001;
    end;
    if sCmd = sSC_CHECKTEXTLIST then begin
      nCMDCode := nSC_CHECKTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKCONTAINSTEXTLIST then begin
      nCMDCode := nSC_CHECKCONTAINSTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_ISGROUPMASTER then begin
      nCMDCode := nSC_ISGROUPMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKONLINE then begin
      nCMDCode := nSC_CHECKONLINE;
      goto L001;
    end;
    if sCmd = sSC_ISDUPMODE then begin
      nCMDCode := nSC_ISDUPMODE;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMCOUNT then begin
      nCMDCode := nSC_CHECKITEMCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLESTATE then begin
      nCMDCode := nSC_CHECKCASTLESTATE;
      goto L001;
    end;
    if sCmd = sSC_CHECKMISSIONCOUNT then begin
      nCMDCode := nSC_CHECKMISSIONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMISSIONKILLMONCOUNT then begin
      nCMDCode := nSC_CHECKMISSIONKILLMONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKARITHMOMETERCOUNT then begin
      nCMDCode := nSC_CHECKARITHMOMETERCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CANMOVEECTYPE then begin
      nCMDCode := nSC_CANMOVEECTYPE;
      goto L001;
    end;
    if sCmd = sSC_CHECKECTYPEMONCOUNT then begin
      nCMDCode := nSC_CHECKECTYPEMONCOUNT;
      goto L001;
    end;

    if sCmd = sSC_CHECKMAPQUEST then begin
      nCMDCode := nSC_CHECKMAPQUEST;
      ArrestStringEx(sParam2, '[', ']', sParam2);
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;
      if not IsStringNumber(sParam3) then
        nCMDCode := 0;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEDIAMOND then begin
      nCMDCode := nSC_CHECKGAMEDIAMOND;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEGIRD then begin
      nCMDCode := nSC_CHECKGAMEGIRD;
      goto L001;
    end;
    if sCmd = sSC_CHECKEMAILOK then begin
      nCMDCode := nSC_CHECKEMAILOK;
      goto L001;
    end;
    if sCmd = sSC_ISUNDERWAR then begin
      nCMDCode := nSC_ISUNDERWAR;
      goto L001;
    end;
    if sCmd = sSC_CHECKHUMORNPCRANGE then begin
      nCMDCode := nSC_CHECKHUMORNPCRANGE;
      goto L001;
    end;
    if sCmd = sSC_CHECKGROUPJOBCOUNT then begin
      nCMDCode := nSC_CHECKGROUPJOBCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKPULLULATION then begin
      nCMDCode := nSC_CHECKPULLULATION;
      goto L001;
    end;
    if sCmd = sSC_CHECKGUILDLEVEL then begin
      nCMDCode := nSC_CHECKGUILDLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMSTRENGTHENCOUNT then begin
      nCMDCode := nSC_CHECKITEMSTRENGTHENCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMFLUTECOUNT then begin
      nCMDCode := nSC_CHECKITEMFLUTECOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKHUMWUXIN then begin
      nCMDCode := nSC_CHECKHUMWUXIN;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMWUXIN then begin
      nCMDCode := nSC_CHECKITEMWUXIN;
      goto L001;
    end;
    if sCmd = sSC_CHECKMAKEMAGICLEVEL then begin
      nCMDCode := nSC_CHECKMAKEMAGICLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKGUILDISFULL then begin
      nCMDCode := nSC_CHECKGUILDISFULL;
      goto L001;
    end;
    if sCmd = sSC_CHECKSTRENGTHENCOUNT then begin
      nCMDCode := nSC_CHECKSTRENGTHENCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKHORSELEVEL then begin
      nCMDCode := nSC_CHECKHORSELEVEL;
      goto L001;
    end;
    if sCmd = sSC_ISONHOUSE then begin
      nCMDCode := nSC_ISONHOUSE;
      goto L001;
    end;
    if sCmd = sSC_CHECKKILLMOBNAME then begin
      nCMDCode := nSC_CHECKKILLMOBNAME;
      goto L001;
    end;
    if sCmd = sSC_CHECKMAPSAMEMONCOUNT then begin
      nCMDCode := nSC_CHECKMAPSAMEMONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKHITMONNAME then begin
      nCMDCode := nSC_CHECKHITMONNAME;
      goto L001;
    end;
{$IFDEF PLUGOPEN}
    if Assigned(zPlugOfEngine.ScriptConditionCmd) then begin
      nCMDCode := zPlugOfEngine.ScriptConditionCmd(PChar(sCmd));
      goto L001;
    end;
{$ENDIF}
    L001:
    if nCMDCode > 0 then begin
      QuestConditionInfo.nCMDCode := nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then begin
        ArrestStringEx(sParam1, '"', '"', sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then begin
        ArrestStringEx(sParam2, '"', '"', sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then begin
        ArrestStringEx(sParam3, '"', '"', sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then begin
        ArrestStringEx(sParam4, '"', '"', sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then begin
        ArrestStringEx(sParam5, '"', '"', sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then begin
        ArrestStringEx(sParam6, '"', '"', sParam6);
      end;
      if (sParam7 <> '') and (sParam7[1] = '"') then begin
        ArrestStringEx(sParam7, '"', '"', sParam7);
      end;
      if (sParam8 <> '') and (sParam8[1] = '"') then begin
        ArrestStringEx(sParam8, '"', '"', sParam8);
      end;
      if (sParam9 <> '') and (sParam9[1] = '"') then begin
        ArrestStringEx(sParam9, '"', '"', sParam9);
      end;
      QuestConditionInfo.boResult := boResult;
      QuestConditionInfo.sParam1 := sParam1;
      QuestConditionInfo.sParam2 := sParam2;
      QuestConditionInfo.sParam3 := sParam3;
      QuestConditionInfo.sParam4 := sParam4;
      QuestConditionInfo.sParam5 := sParam5;
      QuestConditionInfo.sParam6 := sParam6;
      QuestConditionInfo.sParam7 := sParam7;
      QuestConditionInfo.sParam8 := sParam8;
      QuestConditionInfo.sParam9 := sParam9;
      QuestConditionInfo.nParam1 := StrToIntDef(sParam1, 0);
      QuestConditionInfo.nParam2 := StrToIntDef(sParam2, 0);
      QuestConditionInfo.nParam3 := StrToIntDef(sParam3, 0);
      QuestConditionInfo.nParam4 := StrToIntDef(sParam4, 0);
      QuestConditionInfo.nParam5 := StrToIntDef(sParam5, 0);
      QuestConditionInfo.nParam6 := StrToIntDef(sParam6, 0);
      QuestConditionInfo.nParam7 := StrToIntDef(sParam7, 0);
      QuestConditionInfo.nParam8 := StrToIntDef(sParam8, 0);
      QuestConditionInfo.nParam9 := StrToIntDef(sParam9, 0);
      QuestConditionInfo.boDynamic1 := Pos('<$', sParam1) > 0;
      QuestConditionInfo.boDynamic2 := Pos('<$', sParam2) > 0;
      QuestConditionInfo.boDynamic3 := Pos('<$', sParam3) > 0;
      QuestConditionInfo.boDynamic4 := Pos('<$', sParam4) > 0;
      QuestConditionInfo.boDynamic5 := Pos('<$', sParam5) > 0;
      QuestConditionInfo.boDynamic6 := Pos('<$', sParam6) > 0;
      QuestConditionInfo.boDynamic7 := Pos('<$', sParam7) > 0;
      QuestConditionInfo.boDynamic8 := Pos('<$', sParam8) > 0;
      QuestConditionInfo.boDynamic9 := Pos('<$', sParam9) > 0;

      QuestConditionInfo.sParam1 := AnsiReplaceText(QuestConditionInfo.sParam1, '#60', '<');
      QuestConditionInfo.sParam1 := AnsiReplaceText(QuestConditionInfo.sParam1, '#62', '>');
      QuestConditionInfo.sParam2 := AnsiReplaceText(QuestConditionInfo.sParam2, '#60', '<');
      QuestConditionInfo.sParam2 := AnsiReplaceText(QuestConditionInfo.sParam2, '#62', '>');
      QuestConditionInfo.sParam3 := AnsiReplaceText(QuestConditionInfo.sParam3, '#60', '<');
      QuestConditionInfo.sParam3 := AnsiReplaceText(QuestConditionInfo.sParam3, '#62', '>');
      QuestConditionInfo.sParam4 := AnsiReplaceText(QuestConditionInfo.sParam4, '#60', '<');
      QuestConditionInfo.sParam4 := AnsiReplaceText(QuestConditionInfo.sParam4, '#62', '>');
      QuestConditionInfo.sParam5 := AnsiReplaceText(QuestConditionInfo.sParam5, '#60', '<');
      QuestConditionInfo.sParam5 := AnsiReplaceText(QuestConditionInfo.sParam5, '#62', '>');
      QuestConditionInfo.sParam6 := AnsiReplaceText(QuestConditionInfo.sParam6, '#60', '<');
      QuestConditionInfo.sParam6 := AnsiReplaceText(QuestConditionInfo.sParam6, '#62', '>');
      QuestConditionInfo.sParam7 := AnsiReplaceText(QuestConditionInfo.sParam7, '#60', '<');
      QuestConditionInfo.sParam7 := AnsiReplaceText(QuestConditionInfo.sParam7, '#62', '>');
      QuestConditionInfo.sParam8 := AnsiReplaceText(QuestConditionInfo.sParam8, '#60', '<');
      QuestConditionInfo.sParam8 := AnsiReplaceText(QuestConditionInfo.sParam8, '#62', '>');
      QuestConditionInfo.sParam9 := AnsiReplaceText(QuestConditionInfo.sParam9, '#60', '<');
      QuestConditionInfo.sParam9 := AnsiReplaceText(QuestConditionInfo.sParam9, '#62', '>');

      QuestConditionInfo.sParam1 := InitializeProcedure(QuestConditionInfo.sParam1);
      QuestConditionInfo.sParam2 := InitializeProcedure(QuestConditionInfo.sParam2);
      QuestConditionInfo.sParam3 := InitializeProcedure(QuestConditionInfo.sParam3);
      QuestConditionInfo.sParam4 := InitializeProcedure(QuestConditionInfo.sParam4);
      QuestConditionInfo.sParam5 := InitializeProcedure(QuestConditionInfo.sParam5);
      QuestConditionInfo.sParam6 := InitializeProcedure(QuestConditionInfo.sParam6);
      QuestConditionInfo.sParam7 := InitializeProcedure(QuestConditionInfo.sParam7);
      QuestConditionInfo.sParam8 := InitializeProcedure(QuestConditionInfo.sParam8);
      QuestConditionInfo.sParam9 := InitializeProcedure(QuestConditionInfo.sParam9);

      Result := True;
    end;
  end;

  function QuestAction(sText: string; var QuestActionInfo: pTQuestActionInfo): Boolean;
  var
    sCmd, sParam1, sParam2, sParam3, sParam4, sParam5, sParam6, sParam7, sParam8, sParam9, sTemp: string;
    nCMDCode: Integer;
    boGoto: Boolean;
    boDelayGoto: Boolean;
    boPlayDice: Boolean;
  label
    L001;
  begin
    Result := False;
    sText := GetValidStrCap(sText, sCmd, [' ', #9]);
    sText := GetValidStrCap(sText, sParam1, [' ', #9]);
    sText := GetValidStrCap(sText, sParam2, [' ', #9]);
    sText := GetValidStrCap(sText, sParam3, [' ', #9]);
    sText := GetValidStrCap(sText, sParam4, [' ', #9]);
    sText := GetValidStrCap(sText, sParam5, [' ', #9]);
    sText := GetValidStrCap(sText, sParam6, [' ', #9]);
    sText := GetValidStrCap(sText, sParam7, [' ', #9]);
    sText := GetValidStrCap(sText, sParam8, [' ', #9]);
    sText := GetValidStrCap(sText, sParam9, [' ', #9]);

    sTemp := GetValidStrCap(sCmd, sCmd, ['.']);
    while (sTemp <> '') do begin
      if QuestActionInfo.TCmdList = nil then
        QuestActionInfo.TCmdList := TStringList.Create;
      QuestActionInfo.TCmdList.Add(InitializeProcedure(sCmd));
      sTemp := GetValidStrCap(sTemp, sCmd, ['.']);
    end;

    sCmd := UpperCase(sCmd);
    nCMDCode := 0;
    boGoto := False;
    boPlayDice := False;
    boDelayGoto := False;
    if sCmd = sSET then begin
      nCMDCode := nSET;
      {ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;}
      goto L001;
    end;

    if sCmd = sSETMISSION then begin
      nCMDCode := nSETMISSION;
      {ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;}
      goto L001;
    end;

    if sCmd = sRESET then begin
      nCMDCode := nRESET;
      {ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;}
      goto L001;
    end;
    if sCmd = sRESETMISSION then begin
      nCMDCode := nRESETMISSION;
      {ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;}
      goto L001;
    end;
    if sCmd = sTAKE then begin
      nCMDCode := nTAKE;
      goto L001;
    end;
    if sCmd = sSC_GIVE then begin
      nCMDCode := nSC_GIVE;
      goto L001;
    end;
    if sCmd = sSC_DYNAMICGIVE then begin
      nCMDCode := nSC_DYNAMICGIVE;
      goto L001;
    end;
    if sCmd = sCLOSE then begin
      nCMDCode := nCLOSE;
      goto L001;
    end;
    if sCmd = sBREAK then begin
      nCMDCode := nBREAK;
      goto L001;
    end;
    if sCmd = sGOTO then begin
      nCMDCode := nGOTO;
      boGoto := True;
      goto L001;
    end;
    if sCmd = sADDNAMELIST then begin
      nCMDCode := nADDNAMELIST;
      goto L001;
    end;
    if sCmd = sDELNAMELIST then begin
      nCMDCode := nDELNAMELIST;
      goto L001;
    end;
    if sCmd = sADDGUILDLIST then begin
      nCMDCode := nADDGUILDLIST;
      goto L001;
    end;
    if sCmd = sDELGUILDLIST then begin
      nCMDCode := nDELGUILDLIST;
      goto L001;
    end;
    if sCmd = sSC_MAPTING then begin
      nCMDCode := nSC_MAPTING;
      goto L001;
    end;
    if sCmd = sADDACCOUNTLIST then begin
      nCMDCode := nADDACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sDELACCOUNTLIST then begin
      nCMDCode := nDELACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sADDIPLIST then begin
      nCMDCode := nADDIPLIST;
      goto L001;
    end;
    if sCmd = sDELIPLIST then begin
      nCMDCode := nDELIPLIST;
      goto L001;
    end;
    if sCmd = sPKPOINT then begin
      nCMDCode := nPKPOINT;
      goto L001;
    end;
    if sCmd = sSC_RECALLMOB then begin
      nCMDCode := nSC_RECALLMOB;
      goto L001;
    end;
    if sCmd = sKICK then begin
      nCMDCode := nKICK;
      goto L001;
    end;
    if sCmd = sTAKEW then begin
      nCMDCode := nTAKEW;
      goto L001;
    end;
    if sCmd = sTIMERECALL then begin
      nCMDCode := nTIMERECALL;
      goto L001;
    end;
    if sCmd = sSC_PARAM1 then begin
      nCMDCode := nSC_PARAM1;
      goto L001;
    end;
    if sCmd = sSC_PARAM2 then begin
      nCMDCode := nSC_PARAM2;
      goto L001;
    end;
    if sCmd = sSC_PARAM3 then begin
      nCMDCode := nSC_PARAM3;
      goto L001;
    end;
    if sCmd = sSC_PARAM4 then begin
      nCMDCode := nSC_PARAM4;
      goto L001;
    end;
    if sCmd = sSC_EXEACTION then begin
      nCMDCode := nSC_EXEACTION;
      goto L001;
    end;
    if sCmd = sMAPMOVE then begin
      nCMDCode := nMAPMOVE;
      goto L001;
    end;
    if sCmd = sMAP then begin
      nCMDCode := nMAP;
      goto L001;
    end;
    if sCmd = sMONGEN then begin
      nCMDCode := nMONGEN;
      goto L001;
    end;
    if sCmd = sMONCLEAR then begin
      nCMDCode := nMONCLEAR;
      goto L001;
    end;
    if sCmd = sMOV then begin
      nCMDCode := nMOV;
      goto L001;
    end;
    if sCmd = sINC then begin
      nCMDCode := nINC;
      goto L001;
    end;
    if sCmd = sDEC then begin
      nCMDCode := nDEC;
      goto L001;
    end;
    if sCmd = sSUM then begin
      nCMDCode := nSUM;
      goto L001;
    end;
    if sCmd = sBREAKTIMERECALL then begin
      nCMDCode := nBREAKTIMERECALL;
      goto L001;
    end;
    if sCmd = sMOVR then begin
      nCMDCode := nMOVR;
      goto L001;
    end;
    if sCmd = sEXCHANGEMAP then begin
      nCMDCode := nEXCHANGEMAP;
      goto L001;
    end;
    if sCmd = sRECALLMAP then begin
      nCMDCode := nRECALLMAP;
      goto L001;
    end;
    if sCmd = sADDBATCH then begin
      nCMDCode := nADDBATCH;
      goto L001;
    end;
    if sCmd = sBATCHDELAY then begin
      nCMDCode := nBATCHDELAY;
      goto L001;
    end;
    if sCmd = sBATCHMOVE then begin
      nCMDCode := nBATCHMOVE;
      goto L001;
    end;
    if sCmd = sPLAYDICE then begin
      nCMDCode := nPLAYDICE;
      boPlayDice := True;
      goto L001;
    end;
    {if sCmd = sGOQUEST then begin
      nCMDCode := nGOQUEST;
      goto L001;
    end;
    if sCmd = sENDQUEST then begin
      nCMDCode := nENDQUEST;
      goto L001;
    end;     }
    if sCmd = sSC_HAIRSTYLE then begin
      nCMDCode := nSC_HAIRSTYLE;
      goto L001;
    end;

    if sCmd = sSC_CHANGELEVEL then begin
      nCMDCode := nSC_CHANGELEVEL;
      goto L001;
    end;
    if sCmd = sSC_MARRY then begin
      nCMDCode := nSC_MARRY;
      goto L001;
    end;
    if sCmd = sSC_UNMARRY then begin
      nCMDCode := nSC_UNMARRY;
      goto L001;
    end;
    if sCmd = sSC_GETMARRY then begin
      nCMDCode := nSC_GETMARRY;
      goto L001;
    end;
    {if sCmd = sSC_GETMASTER then begin
      nCMDCode := nSC_GETMASTER;
      goto L001;
    end;    }
    if sCmd = sSC_CLEARSKILL then begin
      nCMDCode := nSC_CLEARSKILL;
      goto L001;
    end;
    if sCmd = sSC_DELNOJOBSKILL then begin
      nCMDCode := nSC_DELNOJOBSKILL;
      goto L001;
    end;
    if sCmd = sSC_DELSKILL then begin
      nCMDCode := nSC_DELSKILL;
      goto L001;
    end;
    if sCmd = sSC_ADDSKILL then begin
      nCMDCode := nSC_ADDSKILL;
      goto L001;
    end;
    if sCmd = sSC_SKILLLEVEL then begin
      nCMDCode := nSC_SKILLLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHANGEPKPOINT then begin
      nCMDCode := nSC_CHANGEPKPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHANGEEXP then begin
      nCMDCode := nSC_CHANGEEXP;
      goto L001;
    end;
    if sCmd = sSC_CHANGEJOB then begin
      nCMDCode := nSC_CHANGEJOB;
      goto L001;
    end;
    if sCmd = sSC_MISSION then begin
      nCMDCode := nSC_MISSION;
      goto L001;
    end;
    if sCmd = sSC_MOBPLACE then begin
      nCMDCode := nSC_MOBPLACE;
      goto L001;
    end;
    if sCmd = sSC_SETMEMBERTYPE then begin
      nCMDCode := nSC_SETMEMBERTYPE;
      goto L001;
    end;
    if sCmd = sSC_SETMEMBERLEVEL then begin
      nCMDCode := nSC_SETMEMBERLEVEL;
      goto L001;
    end;
    if sCmd = sSC_GAMEPOINT then begin
      nCMDCode := nSC_GAMEPOINT;
      goto L001;
    end;
    if sCmd = sSC_PKZONE then begin
      nCMDCode := nSC_PKZONE;
      goto L001;
    end;
    if sCmd = sSC_RESTBONUSPOINT then begin
      nCMDCode := nSC_RESTBONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_TAKECASTLEGOLD then begin
      nCMDCode := nSC_TAKECASTLEGOLD;
      goto L001;
    end;
    if sCmd = sSC_HUMANHP then begin
      nCMDCode := nSC_HUMANHP;
      goto L001;
    end;
    if sCmd = sSC_HUMANMP then begin
      nCMDCode := nSC_HUMANMP;
      goto L001;
    end;
    if sCmd = sSC_BUILDPOINT then begin
      nCMDCode := nSC_BUILDPOINT;
      goto L001;
    end;
    if sCmd = sSC_AURAEPOINT then begin
      nCMDCode := nSC_AURAEPOINT;
      goto L001;
    end;
    if sCmd = sSC_STABILITYPOINT then begin
      nCMDCode := nSC_STABILITYPOINT;
      goto L001;
    end;
    if sCmd = sSC_FLOURISHPOINT then begin
      nCMDCode := nSC_FLOURISHPOINT;
      goto L001;
    end;
    if sCmd = sSC_OPENMAGICBOX then begin
      nCMDCode := nSC_OPENMAGICBOX;
      goto L001;
    end;
    if sCmd = sSC_SETRANKLEVELNAME then begin
      nCMDCode := nSC_SETRANKLEVELNAME;
      goto L001;
    end;
    if sCmd = sSC_GMEXECUTE then begin
      nCMDCode := nSC_GMEXECUTE;
      goto L001;
    end;
    if sCmd = sSC_GUILDCHIEFITEMCOUNT then begin
      nCMDCode := nSC_GUILDCHIEFITEMCOUNT;
      goto L001;
    end;
    if sCmd = sSC_MOBFIREBURN then begin
      nCMDCode := nSC_MOBFIREBURN;
      goto L001;
    end;
    if sCmd = sSC_MESSAGEBOX then begin
      nCMDCode := nSC_MESSAGEBOX;
      goto L001;
    end;
    if sCmd = sSC_SETSCRIPTFLAG then begin
      nCMDCode := nSC_SETSCRIPTFLAG;
      goto L001;
    end;
    if sCmd = sSC_SETAUTOGETEXP then begin
      nCMDCode := nSC_SETAUTOGETEXP;
      goto L001;
    end;
    if sCmd = sSC_VAR then begin
      nCMDCode := nSC_VAR;
      goto L001;
    end;
    if sCmd = sSC_LOADVAR then begin
      nCMDCode := nSC_LOADVAR;
      goto L001;
    end;
    if sCmd = sSC_SAVEVAR then begin
      nCMDCode := nSC_SAVEVAR;
      goto L001;
    end;
    if sCmd = sSC_CALCVAR then begin
      nCMDCode := nSC_CALCVAR;
      goto L001;
    end;
    if sCmd = sSC_RECALLGROUPMEMBERS then begin
      nCMDCode := nSC_RECALLGROUPMEMBERS;
      goto L001;
    end;
    if sCmd = sSC_CLEARNAMELIST then begin
      nCMDCode := nSC_CLEARNAMELIST;
      goto L001;
    end;
    if sCmd = sSC_CHANGENAMECOLOR then begin
      nCMDCode := nSC_CHANGENAMECOLOR;
      goto L001;
    end;
    if sCmd = sSC_RENEWLEVEL then begin
      nCMDCode := nSC_RENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_KILLMONEXPRATE then begin
      nCMDCode := nSC_KILLMONEXPRATE;
      goto L001;
    end;
    if sCmd = sSC_POWERRATE then begin
      nCMDCode := nSC_POWERRATE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEMODE then begin
      nCMDCode := nSC_CHANGEMODE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEPERMISSION then begin
      nCMDCode := nSC_CHANGEPERMISSION;
      goto L001;
    end;
    if sCmd = sSC_KILL then begin
      nCMDCode := nSC_KILL;
      goto L001;
    end;
    if sCmd = sSC_BONUSPOINT then begin
      nCMDCode := nSC_BONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_RESTRENEWLEVEL then begin
      nCMDCode := nSC_RESTRENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_DELMARRY then begin
      nCMDCode := nSC_DELMARRY;
      goto L001;
    end;
    {if sCmd = sSC_DELMASTER then begin
      nCMDCode := nSC_DELMASTER;
      goto L001;
    end;    }
    if sCmd = sSC_MASTER then begin
      nCMDCode := nSC_MASTER;
      goto L001;
    end;
    if sCmd = sSC_UNMASTER then begin
      nCMDCode := nSC_UNMASTER;
      goto L001;
    end;
    if sCmd = sSC_CREDITPOINT then begin
      nCMDCode := nSC_CREDITPOINT;
      goto L001;
    end;
    if sCmd = sSC_CLEARNEEDITEMS then begin
      nCMDCode := nSC_CLEARNEEDITEMS;
      goto L001;
    end;
    if sCmd = sSC_CLEARMAKEITEMS then begin
      nCMDCode := nSC_CLEARMAEKITEMS;
      goto L001;
    end;
    if sCmd = sSC_SETSENDMSGFLAG then begin
      nCMDCode := nSC_SETSENDMSGFLAG;
      goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMS then begin
      nCMDCode := nSC_UPGRADEITEMS;
      goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMSEX then begin
      nCMDCode := nSC_UPGRADEITEMSEX;
      goto L001;
    end;
    if sCmd = sSC_MONGENEX then begin
      nCMDCode := nSC_MONGENEX;
      goto L001;
    end;
    if sCmd = sSC_CLEARMAPMON then begin
      nCMDCode := nSC_CLEARMAPMON;
      goto L001;
    end;
    if sCmd = sSC_SETMAPMODE then begin
      nCMDCode := nSC_SETMAPMODE;
      goto L001;
    end;
    if sCmd = sSC_KILLSLAVE then begin
      nCMDCode := nSC_KILLSLAVE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEGENDER then begin
      nCMDCode := nSC_CHANGEGENDER;
      goto L001;
    end;
    if sCmd = sSC_MAPTING then begin
      nCMDCode := nSC_MAPTING;
      goto L001;
    end;
    if sCmd = sOFFLINEPLAY then begin
      nCMDCode := nOFFLINEPLAY;
      goto L001;
    end;
    if sCmd = sKICKOFFLINE then begin
      nCMDCode := nKICKOFFLINE;
      goto L001;
    end;
    {if sCmd = sSTARTTAKEGOLD then begin
      nCMDCode := nSTARTTAKEGOLD;
      goto L001;
    end;   }
    if sCmd = sSC_DELAYGOTO then begin
      nCMDCode := nSC_DELAYGOTO;
      boDelayGoto := True;
      goto L001;
    end;
    if sCmd = sSC_CLEARDELAYGOTO then begin
      nCMDCode := nSC_CLEARDELAYGOTO;
      goto L001;
    end;
    if sCmd = sSC_ANSIREPLACETEXT then begin
      nCMDCode := nSC_ANSIREPLACETEXT;
      goto L001;
    end;
    if sCmd = sSC_ADDTEXTLIST then begin
      nCMDCode := nSC_ADDTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_DELTEXTLIST then begin
      nCMDCode := nSC_DELTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_GROUPMOVE then begin
      nCMDCode := nSC_GROUPMOVE;
      goto L001;
    end;
    if sCmd = sSC_GROUPMAPMOVE then begin
      nCMDCode := nSC_GROUPMAPMOVE;
      goto L001;
    end;
    if sCmd = sSC_RECALLHUMAN then begin
      nCMDCode := nSC_RECALLHUMAN;
      goto L001;
    end;
    if sCmd = sSC_REGOTO then begin
      nCMDCode := nSC_REGOTO;
      goto L001;
    end;
    if sCmd = sSC_GUILDMOVE then begin
      nCMDCode := nSC_GUILDMOVE;
      goto L001;
    end;
    if sCmd = sSC_GUILDMAPMOVE then begin
      nCMDCode := nSC_GUILDMAPMOVE;
      goto L001;
    end;
    if sCmd = sSC_RANDOMMOVE then begin
      nCMDCode := nSC_RANDOMMOVE;
      goto L001;
    end;
    if sCmd = sSC_USEBONUSPOINT then begin
      nCMDCode := nSC_USEBONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_REPAIRITEM then begin
      nCMDCode := nSC_REPAIRITEM;
      goto L001;
    end;
    if sCmd = sSC_TAKECOUNT then begin
      nCMDCode := nSC_TAKECOUNT;
      goto L001;
    end;
    if sCmd = sSC_DIV then begin
      nCMDCode := nSC_DIV;
      goto L001;
    end;
    if sCmd = sSC_MOD then begin
      nCMDCode := nSC_MOD;
      goto L001;
    end;
    if sCmd = sSC_MUL then begin
      nCMDCode := nSC_MUL;
      goto L001;
    end;
    if sCmd = sSC_PERCENT then begin
      nCMDCode := nSC_PERCENT;
      goto L001;
    end;
    if sCmd = sSC_SENDMSG then begin
      nCMDCode := nSC_LINEMSG;
      goto L001;
    end;
    if sCmd = sSC_LINEMSG then begin
      nCMDCode := nSC_LINEMSG;
      goto L001;
    end;
    if sCmd = sSC_ADDNAMEDATELIST then begin
      nCMDCode := nSC_ADDNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_ADDUSERDATE then begin
      nCMDCode := nSC_ADDNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_DELNAMEDATELIST then begin
      nCMDCode := nSC_DELNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_DELUSERDATE then begin
      nCMDCode := nSC_DELNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_STORAGETIMECHANGE then begin
      nCMDCode := nSC_STORAGETIMECHANGE;
      goto L001;
    end;
    if sCmd = sSC_ADDMISSION then begin
      nCMDCode := nSC_ADDMISSION;
      goto L001;
    end;
    if sCmd = sSC_DELMISSION then begin
      nCMDCode := nSC_DELMISSION;
      goto L001;
    end;
    if sCmd = sSC_UPDATEMISSION then begin
      nCMDCode := nSC_UPDATEMISSION;
      goto L001;
    end;
    if sCmd = sSC_CHANGEMISSIONKILLMONCOUNT then begin
      nCMDCode := nSC_CHANGEMISSIONKILLMONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHANGEARITHMOMETERCOUNT then begin
      nCMDCode := nSC_CHANGEARITHMOMETERCOUNT;
      goto L001;
    end;
    if sCmd = sSC_SHOWEFFECT then begin
      nCMDCode := nSC_SHOWEFFECT;
      goto L001;
    end;
    if sCmd = sSC_AUTOMOVE then begin
      nCMDCode := nSC_AUTOMOVE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEGIVEITEM then begin
      nCMDCode := nSC_CHANGEGIVEITEM;
      goto L001;
    end;
    if sCmd = sSC_MOBMACHINERYEVENT then begin
      nCMDCode := nSC_MOBMACHINERYEVENT;
      goto L001;
    end;
    if sCmd = sSC_CLEARMACHINERYEVENT then begin
      nCMDCode := nSC_CLEARMACHINERYEVENT;
      goto L001;
    end;
    if sCmd = sSC_CREATEECTYPE then begin
      nCMDCode := nSC_CREATEECTYPE;
      goto L001;
    end;
    if sCmd = sSC_MOVEECTYPE then begin
      nCMDCode := nSC_MOVEECTYPE;
      goto L001;
    end;
    if sCmd = sSC_MOBECTYPEMON then begin
      nCMDCode := nSC_MOBECTYPEMON;
      goto L001;
    end;
    if sCmd = sSC_CLEARECTYPEMON then begin
      nCMDCode := nSC_CLEARECTYPEMON;
      goto L001;
    end;
    if sCmd = sSC_OPENBOX then begin
      nCMDCode := nSC_OPENBOX;
      goto L001;
    end;
    if sCmd = sSC_SETMAPQUEST then begin
      nCMDCode := nSC_SETMAPQUEST;
      ArrestStringEx(sParam2, '[', ']', sParam2);
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;
      if not IsStringNumber(sParam3) then
        nCMDCode := 0;
      goto L001;
    end;
    if sCmd = sSC_RESETMAPQUEST then begin
      nCMDCode := nSC_RESETMAPQUEST;
      ArrestStringEx(sParam2, '[', ']', sParam2);
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;
      if not IsStringNumber(sParam3) then
        nCMDCode := 0;
      goto L001;
    end;
    if sCmd = sSC_CHANGEGAMEDIAMOND then begin
      nCMDCode := nSC_CHANGEGAMEDIAMOND;
      goto L001;
    end;
    if sCmd = sSC_CHANGEGAMEGIRD then begin
      nCMDCode := nSC_CHANGEGAMEGIRD;
      goto L001;
    end;
    if sCmd = sSC_GETRANDOMNAME then begin
      nCMDCode := nSC_GETRANDOMNAME;
      goto L001;
    end;
    if sCmd = sSC_MOBSLAVE then begin
      nCMDCode := nSC_MOBSLAVE;
      goto L001;
    end;
    if sCmd = sSC_CLEARLIST then begin
      nCMDCode := nSC_CLEARLIST;
      goto L001;
    end;
    if sCmd = sSC_HOOKOBJECT then begin
      nCMDCode := nSC_HOOKOBJECT;
      goto L001;
    end;
    if sCmd = sSC_REFSHOWNAME then begin
      nCMDCode := nSC_REFSHOWNAME;
      goto L001;
    end;
    if sCmd = sSC_SETEFFIGYSTATE then begin
      nCMDCode := nSC_SETEFFIGYSTATE;
      goto L001;
    end;
    if sCmd = sSC_STARTWALLCONQUESTWAR then begin
      nCMDCode := nSC_STARTWALLCONQUESTWAR;
      goto L001;
    end;
    if sCmd = sSC_SETGUAGEBAR then begin
      nCMDCode := nSC_SETGUAGEBAR;
      goto L001;
    end;
    if sCmd = sSC_ADDMAKEMAGIC then begin
      nCMDCode := nSC_ADDMAKEMAGIC;
      goto L001;
    end;
    if sCmd = sSC_ADDRANDOMMAPGATE then begin
      nCMDCode := nSC_ADDRANDOMMAPGATE;
      goto L001;
    end;
    if sCmd = sSC_DELRANDOMMAPGATE then begin
      nCMDCode := nSC_DELRANDOMMAPGATE;
      goto L001;
    end;
    if sCmd = sSC_GETLARGESSGOLD then begin
      nCMDCode := nSC_GETLARGESSGOLD;
      goto L001;
    end;
    if sCmd = sSC_UPDATEMISSIONTIME then begin
      nCMDCode := nSC_UPDATEMISSIONTIME;
      goto L001;
    end;
    if sCmd = sSC_RESETNAKEDABILPOINT then begin
      nCMDCode := nSC_RESETNAKEDABILPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHANGEPULLULATION then begin
      nCMDCode := nSC_CHANGEPULLULATION;
      goto L001;
    end;
    if sCmd = sSC_SETLIMITEXPLEVEL then begin
      nCMDCode := nSC_SETLIMITEXPLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHANGEGUILDLEVEL then begin
      nCMDCode := nSC_CHANGEGUILDLEVEL;
      goto L001;
    end;
    if sCmd = sSC_HCALL then begin
      nCMDCode := nSC_HCALL;
      goto L001;
    end;
    if sCmd = sSC_CREATEGROUPFAIL then begin
      nCMDCode := nSC_CREATEGROUPFAIL;
      goto L001;
    end;
    if sCmd = sSC_HOOKITEM then begin
      nCMDCode := nSC_HOOKITEM;
      goto L001;
    end;
    if sCmd = sSC_CHANGENAKEDCOUNT then begin
      nCMDCode := nSC_CHANGENAKEDCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHUMWUXIN then begin
      nCMDCode := nSC_CHANGEHUMWUXIN;
      goto L001;
    end;
    if sCmd = sSC_CHANGEMAKEMAGICLEVEL then begin
      nCMDCode := nSC_CHANGEMAKEMAGICLEVEL;
      goto L001;
    end;
    if sCmd = sSC_ADDGUILDMEMBER then begin
      nCMDCode := nSC_ADDGUILDMEMBER;
      goto L001;
    end;
    if sCmd = sSC_CHANGEMAKEMAGICPOINT then begin
      nCMDCode := nSC_CHANGEMAKEMAGICPOINT;
      goto L001;
    end;
    if sCmd = sSC_OPENURL then begin
      nCMDCode := nSC_OPENURL;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHUMABILITY then begin
      nCMDCode := nSC_CHANGEHUMABILITY;
      goto L001;
    end;
    if sCmd = sSC_SENDCENTERMSG then begin
      nCMDCode := nSC_SENDCENTERMSG;
      goto L001;
    end;
    if sCmd = sSC_CLEARSENDCENTERMSG then begin
      nCMDCode := nSC_CLEARSENDCENTERMSG;
      goto L001;
    end;
    if sCmd = sSC_TAKEOFFITEM then begin
      nCMDCode := nSC_TAKEOFFITEM;
      goto L001;
    end;
    if sCmd = sSC_DARE then begin
      nCMDCode := nSC_DARE;
      goto L001;
    end;
    if sCmd = sSC_SENDEMAIL then begin
      nCMDCode := nSC_SENDEMAIL;
      goto L001;
    end;
    if sCmd = sSC_SETHUMICON then begin
      nCMDCode := nSC_SETHUMICON;
      goto L001;
    end;
{$IFDEF PLUGOPEN}
    if Assigned(zPlugOfEngine.ScriptActionCmd) then begin
      nCMDCode := zPlugOfEngine.ScriptActionCmd(PChar(sCmd));
      goto L001;
    end;
{$ENDIF}
    L001:
    if nCMDCode > 0 then begin
      QuestActionInfo.nCMDCode := nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then begin
        ArrestStringEx(sParam1, '"', '"', sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then begin
        ArrestStringEx(sParam2, '"', '"', sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then begin
        ArrestStringEx(sParam3, '"', '"', sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then begin
        ArrestStringEx(sParam4, '"', '"', sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then begin
        ArrestStringEx(sParam5, '"', '"', sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then begin
        ArrestStringEx(sParam6, '"', '"', sParam6);
      end;
      if (sParam7 <> '') and (sParam7[1] = '"') then begin
        ArrestStringEx(sParam7, '"', '"', sParam7);
      end;
      if (sParam8 <> '') and (sParam8[1] = '"') then begin
        ArrestStringEx(sParam8, '"', '"', sParam8);
      end;
      if (sParam9 <> '') and (sParam9[1] = '"') then begin
        ArrestStringEx(sParam9, '"', '"', sParam9);
      end;
      QuestActionInfo.sParam1 := sParam1;
      QuestActionInfo.sParam2 := sParam2;
      QuestActionInfo.sParam3 := sParam3;
      QuestActionInfo.sParam4 := sParam4;
      QuestActionInfo.sParam5 := sParam5;
      QuestActionInfo.sParam6 := sParam6;
      QuestActionInfo.sParam7 := sParam7;
      QuestActionInfo.sParam8 := sParam8;
      QuestActionInfo.sParam9 := sParam9;
      QuestActionInfo.nParam1 := StrToIntDef(sParam1, 0);
      QuestActionInfo.nParam2 := StrToIntDef(sParam2, 1);
      QuestActionInfo.nParam3 := StrToIntDef(sParam3, 1);
      QuestActionInfo.nParam4 := StrToIntDef(sParam4, 0);
      QuestActionInfo.nParam5 := StrToIntDef(sParam5, 0);
      QuestActionInfo.nParam6 := StrToIntDef(sParam6, 0);
      QuestActionInfo.nParam7 := StrToIntDef(sParam7, 0);
      QuestActionInfo.nParam8 := StrToIntDef(sParam8, 0);
      QuestActionInfo.nParam9 := StrToIntDef(sParam9, 0);
      QuestActionInfo.boDynamic1 := Pos('<$', sParam1) > 0;
      QuestActionInfo.boDynamic2 := Pos('<$', sParam2) > 0;
      QuestActionInfo.boDynamic3 := Pos('<$', sParam3) > 0;
      QuestActionInfo.boDynamic4 := Pos('<$', sParam4) > 0;
      QuestActionInfo.boDynamic5 := Pos('<$', sParam5) > 0;
      QuestActionInfo.boDynamic6 := Pos('<$', sParam6) > 0;
      QuestActionInfo.boDynamic7 := Pos('<$', sParam7) > 0;
      QuestActionInfo.boDynamic8 := Pos('<$', sParam8) > 0;
      QuestActionInfo.boDynamic9 := Pos('<$', sParam9) > 0;

      QuestActionInfo.sParam1 := AnsiReplaceText(QuestActionInfo.sParam1, '#60', '<');
      QuestActionInfo.sParam1 := AnsiReplaceText(QuestActionInfo.sParam1, '#62', '>');
      QuestActionInfo.sParam2 := AnsiReplaceText(QuestActionInfo.sParam2, '#60', '<');
      QuestActionInfo.sParam2 := AnsiReplaceText(QuestActionInfo.sParam2, '#62', '>');
      QuestActionInfo.sParam3 := AnsiReplaceText(QuestActionInfo.sParam3, '#60', '<');
      QuestActionInfo.sParam3 := AnsiReplaceText(QuestActionInfo.sParam3, '#62', '>');
      QuestActionInfo.sParam4 := AnsiReplaceText(QuestActionInfo.sParam4, '#60', '<');
      QuestActionInfo.sParam4 := AnsiReplaceText(QuestActionInfo.sParam4, '#62', '>');
      QuestActionInfo.sParam5 := AnsiReplaceText(QuestActionInfo.sParam5, '#60', '<');
      QuestActionInfo.sParam5 := AnsiReplaceText(QuestActionInfo.sParam5, '#62', '>');
      QuestActionInfo.sParam6 := AnsiReplaceText(QuestActionInfo.sParam6, '#60', '<');
      QuestActionInfo.sParam6 := AnsiReplaceText(QuestActionInfo.sParam6, '#62', '>');
      QuestActionInfo.sParam7 := AnsiReplaceText(QuestActionInfo.sParam7, '#60', '<');
      QuestActionInfo.sParam7 := AnsiReplaceText(QuestActionInfo.sParam7, '#62', '>');
      QuestActionInfo.sParam8 := AnsiReplaceText(QuestActionInfo.sParam8, '#60', '<');
      QuestActionInfo.sParam8 := AnsiReplaceText(QuestActionInfo.sParam8, '#62', '>');
      QuestActionInfo.sParam9 := AnsiReplaceText(QuestActionInfo.sParam9, '#60', '<');
      QuestActionInfo.sParam9 := AnsiReplaceText(QuestActionInfo.sParam9, '#62', '>');

      QuestActionInfo.sParam1 := InitializeProcedure(QuestActionInfo.sParam1);
      QuestActionInfo.sParam2 := InitializeProcedure(QuestActionInfo.sParam2);
      QuestActionInfo.sParam3 := InitializeProcedure(QuestActionInfo.sParam3);
      QuestActionInfo.sParam4 := InitializeProcedure(QuestActionInfo.sParam4);
      QuestActionInfo.sParam5 := InitializeProcedure(QuestActionInfo.sParam5);
      QuestActionInfo.sParam6 := InitializeProcedure(QuestActionInfo.sParam6);
      QuestActionInfo.sParam7 := InitializeProcedure(QuestActionInfo.sParam7);
      QuestActionInfo.sParam8 := InitializeProcedure(QuestActionInfo.sParam8);
      QuestActionInfo.sParam9 := InitializeProcedure(QuestActionInfo.sParam9);
      Result := True;
      if boDelayGoto then begin
        DelayGotoList.Add(QuestActionInfo);
      end
      else if boGoto then begin
        GotoList.Add(QuestActionInfo);
      end
      else if boPlayDice then begin
        PlayDiceList.Add(QuestActionInfo);
      end;
    end;
  end;
var
  OutBuf: PChar;
  OutLen: Integer;
  MakeItemArr: array of TMakeItem;
  NameArr: string;
begin //0048B684
  Result := -1;
  boAddMain := False;
  ScriptNameList := TStringList.Create;
  GotoList := TList.Create;
  DelayGotoList := TList.Create;
  PlayDiceList := TList.Create;
  n6C := 0;
  //  n70 := 0;
  bo8D := False;
  SayingProcedure := nil;
  sScritpFileName := g_Config.sEnvirDir + sPatch + sScritpName + '.txt';
  if MyFileExists(sScritpFileName) then begin
    LoadList := TMsgStringList.Create;
    try
      LoadList.LoadFromFile(sScritpFileName);
      DeCodeStringList(LoadList);
    except
      LoadList.Free;
      Exit;
    end;
    //    i := 0;
    //LoadListCall(LoadList);
    LoadScriptcall(sPatch + sScritpName + '.txt', LoadList);
    {while (True) do begin
      LoadScriptcall(LoadList);
      Inc(i);
      if i >= 10 then break;
    end;    }
    ScriptNameList.Clear;

    DefineList := TList.Create;

    s54 := LoadDefineInfo(LoadList, DefineList);
    New(DefineInfo);
    DefineInfo.sName := '@HOME';
    if s54 = '' then
      s54 := '@main';
    DefineInfo.sText := s54;
    DefineList.Add(DefineInfo);
    // 常量处理
    for i := 0 to LoadList.Count - 1 do begin
      s34 := Trim(LoadList.Strings[i]);
      if (s34 <> '') then begin
        if (s34[1] = '[') then begin
          bo8D := False;
        end
        else begin //0048B83F
          if (s34[1] = '#') and
            (CompareLStr(s34, '#IF', Length('#IF')) or
            CompareLStr(s34, '#ACT', Length('#ACT')) or
            CompareLStr(s34, '#ELSEACT', Length('#ELSEACT'))) then begin
            bo8D := True;
          end
          else begin //0048B895
            if bo8D then begin
              // 将Define 好的常量换成指定值
              for n20 := 0 to DefineList.Count - 1 do begin
                DefineInfo := DefineList.Items[n20];
                n1C := 0;
                while (True) do begin
                  n24 := Pos(DefineInfo.sName, UpperCase(s34));
                  if n24 <= 0 then
                    break;
                  s58 := Copy(s34, 1, n24 - 1);
                  s5C := Copy(s34, Length(DefineInfo.sName) + n24, 256);
                  s34 := s58 + DefineInfo.sText + s5C;
                  LoadList.Strings[i] := s34;
                  Inc(n1C);
                  if n1C >= 10 then
                    break;
                end;
              end; // 将Define 好的常量换成指定值
            end;
          end;
        end;
      end;
    end;
    // 常量处理

    //释放常量定义内容
    for i := 0 to DefineList.Count - 1 do begin
      DisPose(pTDefineInfo(DefineList.Items[i]));
    end;
    DefineList.Free;
    //释放常量定义内容

    //Script := nil;
    SayingRecord := nil;
    //    nQuestIdx := 0;
    if boFlag then begin
      with NPC as TMerchant do begin
        if m_NewGoodsList.Count > 0 then begin
          for ii := 0 to m_NewGoodsList.Count - 1 do begin
            Goods := m_NewGoodsList.Items[ii];
            Dispose(Goods);
          end;
        end;
        if m_MakeItemsList.Count > 0 then begin
          for ii := 0 to m_MakeItemsList.Count - 1 do begin
            Dispose(pTMakeGoods(m_MakeItemsList.Items[ii]));
          end;
        end;
        m_MakeItemsCode := '';
        m_MakeNamesCode := '';
        m_NewGoodsList.Clear;
        m_MakeItemsList.Clear;
        //m_ItemTypeList.Clear;
        RefSelf();
      end;
    end;
    for i := 0 to LoadList.Count - 1 do begin //0048B9FC
      s34 := Trim(LoadList.Strings[i]);
      if (s34 = '') or (s34[1] = ';') or (s34[1] = '/') then
        Continue;

      //全局常量处理
      sText := UserEngine.GetDefiniensConstText(s34);
      s34 := sText;
      //UserEngine.m_DefiniensConst
      if (n6C = 0) and (boFlag) then begin
        //增加处理NPC可执行命令设置
        if s34[1] = '(' then begin
          ArrestStringEx(s34, '(', ')', s34);
          if s34 <> '' then begin
            while (s34 <> '') do begin
              s34 := GetValidStr3(s34, s30, [' ', ',', #9]);
              if CompareText(s30, sBUY) = 0 then begin
                with NPC as TMerchant do
                  m_boBuy := True;
                Continue;
              end;
              if CompareText(s30, sSELL) = 0 then begin
                with NPC as TMerchant do
                  m_boSell := True;
                Continue;
              end;
              if CompareText(s30, sMAKEDURG) = 0 then begin
                with NPC as TMerchant do
                  m_boMakeDrug := True;
                Continue;
              end;
              if CompareText(s30, sPRICES) = 0 then begin
                with NPC as TMerchant do
                  m_boPrices := True;
                Continue;
              end;
              if CompareText(s30, sSTORAGE) = 0 then begin
                with NPC as TMerchant do
                  m_boStorage := True;
                Continue;
              end;

              if CompareText(s30, sREPAIR) = 0 then begin
                with NPC as TMerchant do
                  m_boRepair := True;
                Continue;
              end;
              if CompareText(s30, sSUPERREPAIR) = 0 then begin
                with NPC as TMerchant do
                  m_boS_repair := True;
                Continue;
              end;
              if CompareText(s30, sSL_SENDMSG) = 0 then begin
                with NPC as TMerchant do
                  m_boSendmsg2 := True;
                Continue;
              end;
              if CompareText(s30, sUSEITEMNAME) = 0 then begin
                with NPC as TMerchant do
                  m_boUseItemName := True;
                Continue;
              end;
              if CompareText(s30, sGETSELLGOLD) = 0 then begin
                with NPC as TMerchant do
                  m_boGetSellGold := True;
                Continue;
              end;
              if CompareText(s30, sSELLOFF) = 0 then begin
                with NPC as TMerchant do
                  m_boSellOff := True;
                Continue;
              end;
              if CompareText(s30, sBUYOFF) = 0 then begin
                with NPC as TMerchant do
                  m_boBuyOff := True;
                Continue;
              end;
              if CompareText(s30, sdealgold) = 0 then begin
                with NPC as TMerchant do
                  m_boDealGold := True;
                Continue;
              end;
              if CompareText(s30, sARMSTRENGTHEN) = 0 then begin
                with NPC as TMerchant do
                  m_boArmStrengthen := True;
                Continue;
              end;
              if CompareText(s30, sARMABILITYMOVE) = 0 then begin
                with NPC as TMerchant do
                  m_boArmAbilityMove := True;
                Continue;
              end;
              if CompareText(s30, sARMUNSEAL) = 0 then begin
                with NPC as TMerchant do
                  m_boArmUnseal := True;
                Continue;
              end;
              if CompareText(s30, sARMREMOVESTONE) = 0 then begin
                with NPC as TMerchant do
                  m_boArmRemoveStone := True;
                Continue;
              end;
              if CompareText(s30, sINPUTINTEGER) = 0 then begin
                with NPC as TMerchant do
                  m_boInputInteger := True;
                Continue;
              end;
              if CompareText(s30, sINPUTSTRING) = 0 then begin
                with NPC as TMerchant do
                  m_boInputString := True;
                Continue;
              end;
              if CompareText(s30, sUPGRADENOW) = 0 then begin
                with NPC as TMerchant do
                  m_boUpgradeNow := True;
                Continue;
              end;
              if CompareText(s30, sGETBACKUPGNOW) = 0 then begin
                with NPC as TMerchant do
                  m_boGetBackUpgnow := True;
                Continue;
              end;
            end;
          end;
          Continue;
        end
      end;

      (* if s34[1] = '{' then begin
         if CompareLStr(s34, '{Quest', Length('{Quest')) then begin
           s38 := GetValidStr3(s34, s3C, [' ', '}', #9]);
           GetValidStr3(s38, s3C, [' ', '}', #9]);
           n70 := StrToIntDef(s3C, 0);
           Script := MakeNewScript();
           Script.nQuest := n70;
           Inc(n70);
         end; //0048BBA4
         if CompareLStr(s34, '{~Quest', Length('{~Quest')) then
           Continue;
       end; //0048BBBE    *)

      { if (n6C = 1) and (Script <> nil) and (s34[1] = '#') then begin
         s38 := GetValidStr3(s34, s3C, ['=', ' ', #9]);
         Script.boQuest := True;
         if CompareLStr(s34, '#IF', Length('#IF')) then begin
           ArrestStringEx(s34, '[', ']', s40);
           //Script.QuestInfo[nQuestIdx].wFlag := StrToIntDef(s40, 0);
           GetValidStr3(s38, s44, ['=', ' ', #9]);
           n24 := StrToIntDef(s44, 0);
           if n24 <> 0 then
             n24 := 1;
           //Script.QuestInfo[nQuestIdx].btValue := n24;
         end;

         if CompareLStr(s34, '#RAND', Length('#RAND')) then begin
           //Script.QuestInfo[nQuestIdx].nRandRage := StrToIntDef(s44, 0);
         end;
         Continue;
       end;     }

      if s34[1] = '[' then begin
        n6C := 10;
        if CompareText(s34, '[goods]') = 0 then begin
          n6C := 20;
          n70 := 0;
          Continue;
        end;
        if CompareText(s34, '[MakeItems]') = 0 then begin
          n6C := 21;
          Continue;
        end;
        s34 := ArrestStringEx(s34, '[', ']', s74);
        if NPC.m_ScriptList.Count <= 0 then begin
          New(SayingRecord);
          SayingRecord.ProcedureList := TList.Create;
          SayingRecord.sLabel := '@main';
          SayingRecord.boExtJmp := True;
          NPC.m_ScriptList.Add(SayingRecord);
          ScriptNameList.Add(SayingRecord.sLabel);
        end;
        if (not boAddMain) and (CompareText(s74, '@main') = 0) then begin
          SayingRecord := NPC.m_ScriptList[0];
          boAddMain := True;
          boAdd := False;
        end
        else begin
          boAdd := True;
          if ScriptNameList.IndexOf(FormatLabelStr(s74, boChange)) > -1 then begin
            //MainOutMessage('脚本重复调用: ' + sScritpFileName + ' ' + s74);
            n6C := 0;
            Continue;
          end;
          New(SayingRecord);
          SayingRecord.ProcedureList := TList.Create;
          SayingRecord.sLabel := s74;
        end;
        SayingRecord.boUserWindow := False;
        if (s34 <> '') and (s34[1] = '(') then
        begin
          s34 := ArrestStringEx(s34, '(', ')', s74);
          s74 := GetValidStrCap(s74, s48, [',', ' ', #9]);
          SayingRecord.nResID := StrToIntDef(s48, -1);
          s74 := GetValidStrCap(s74, s48, [',', ' ', #9]);
          SayingRecord.nWindowWidth := StrToIntDef(s48, -1);
          s74 := GetValidStrCap(s74, s48, [',', ' ', #9]);
          SayingRecord.nWindowHeight := StrToIntDef(s48, -1);
          if (SayingRecord.nResID >= 0) and (SayingRecord.nWindowWidth > 0) and (SayingRecord.nWindowHeight > 0) then
            SayingRecord.boUserWindow := True;
        end;
        s34 := GetValidStrCap(s34, s74, [' ', #9]);
        if CompareText(s74, 'TRUE') = 0 then begin
          SayingRecord.boExtJmp := True;
        end
        else begin
          SayingRecord.boExtJmp := False;
        end;
        New(SayingProcedure);
        SayingRecord.ProcedureList.Add(SayingProcedure);
        SayingProcedure.ConditionList := TList.Create;
        SayingProcedure.ActionList := TList.Create;
        SayingProcedure.sSayMsg := '';
        SayIngProcedure.SayNewLabelList := TStringList.Create;
        SayIngProcedure.SayOldLabelList := TStringList.Create;
        SayingProcedure.ElseActionList := TList.Create;
        SayingProcedure.sElseSayMsg := '';
        SayingProcedure.ElseSayNewLabelList := TStringList.Create;
        SayingProcedure.ElseSayOldLabelList := TStringList.Create;
        if boAdd then begin
          NPC.m_ScriptList.Add(SayingRecord);
          ScriptNameList.Add(SayingRecord.sLabel);
        end;
        Continue;
      end;
      if (SayingRecord <> nil) then begin
        if (n6C >= 10) and (n6C < 20) and (s34[1] = '#') then begin
          if CompareText(s34, '#IF') = 0 then begin
            //if (SayingProcedure.ConditionList.Count > 0) or (SayingProcedure.sSayMsg <> '') then begin //0048BE53
            New(SayingProcedure);
            SayingRecord.ProcedureList.Add(SayingProcedure);
            SayingProcedure.ConditionList := TList.Create;
            SayingProcedure.ActionList := TList.Create;
            SayingProcedure.sSayMsg := '';
            SayIngProcedure.SayNewLabelList := TStringList.Create;
            SayIngProcedure.SayOldLabelList := TStringList.Create;
            SayingProcedure.ElseActionList := TList.Create;
            SayingProcedure.sElseSayMsg := '';
            SayingProcedure.ElseSayNewLabelList := TStringList.Create;
            SayingProcedure.ElseSayOldLabelList := TStringList.Create;
            //end;
            n6C := 11;
          end;
          if CompareText(s34, '#ACT') = 0 then
            n6C := 12;
          if CompareText(s34, '#SAY') = 0 then
            n6C := 10;
          if CompareText(s34, '#ELSEACT') = 0 then
            n6C := 13;
          if CompareText(s34, '#ELSESAY') = 0 then
            n6C := 14;
          Continue;
        end; //0048BF3E
        if (n6C = 10) and (SayingProcedure <> nil) then
          SayingProcedure.sSayMsg := SayingProcedure.sSayMsg + sText;

        if (n6C = 11) then begin
          New(QuestConditionInfo);
          SafeFillChar(QuestConditionInfo^, SizeOf(TQuestConditionInfo), #0);
          QuestConditionInfo.TCmdList := nil;
          if QuestCondition(Trim(s34), QuestConditionInfo) then begin
            SayingProcedure.ConditionList.Add(QuestConditionInfo);
          end
          else begin
            DisPose(QuestConditionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(i) + ' 行: ' + sScritpFileName);
          end;
        end; //0048C004
        if (n6C = 12) then begin
          New(QuestActionInfo);
          SafeFillChar(QuestActionInfo^, SizeOf(TQuestActionInfo), #0);
          QuestActionInfo.TCmdList := nil;
          if QuestAction(Trim(s34), QuestActionInfo) then begin
            SayingProcedure.ActionList.Add(QuestActionInfo);
          end
          else begin
            DisPose(QuestActionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(i) + ' 行: ' + sScritpFileName);
          end;
        end;
        if (n6C = 13) then begin
          New(QuestActionInfo);
          SafeFillChar(QuestActionInfo^, SizeOf(TQuestActionInfo), #0);
          QuestActionInfo.TCmdList := nil;
          if QuestAction(Trim(s34), QuestActionInfo) then begin
            SayingProcedure.ElseActionList.Add(QuestActionInfo);
          end
          else begin
            DisPose(QuestActionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(i) + ' 行: ' + sScritpFileName);
          end;
        end;
        if (n6C = 14) then
          SayingProcedure.sElseSayMsg := SayingProcedure.sElseSayMsg + sText;
      end;
      if (n6C = 21) and boFlag then begin
        sName := Trim(s34);
        while True do begin
          if s34 = '' then
            break;
          s34 := GetValidStrCap(s34, s48, [' ', #9]);
          if s48 = '' then
            break;
          if s48[1] <> '$' then
            break;
        end;
        if (s48 <> '') then begin
          StdItem := UserEngine.GetStdItem(s48);
          if Stditem <> nil then begin
            MakeItem := GetMakeItemInfo(StdItem.Idx + 1);
            if MakeItem <> nil then begin
              New(MakeGoods);
              MakeGoods.sName := sName;
              MakeGoods.MakeItem := MakeItem^;
              with NPC as TMerchant do
                MakeGoods.MakeItem.wIdx := m_MakeItemsList.Add(MakeGoods);
            end;
          end;
        end;
      end;
      if (n6C = 20) and boFlag then begin
        s34 := GetValidStrCap(s34, s48, [' ', #9]);
        s34 := GetValidStrCap(s34, s4C, [' ', #9]);
        s34 := GetValidStrCap(s34, s50, [' ', #9]);
        s34 := GetValidStrCap(s34, s54, [' ', #9]);
        if (s48 <> '') then begin
          if (s48 <> '') and (s48[1] = '"') then begin
            ArrestStringEx(s48, '"', '"', s48);
          end;
          with NPC as TMerchant do begin
            Goods := nil;
            if m_NewGoodsList.Count > 0 then begin
              for ii := 0 to m_NewGoodsList.Count - 1 do begin
                Goods := m_NewGoodsList.Items[ii];
                if Goods = nil then
                  Continue;
                if CompareText(Goods.sItemName, s48) = 0 then begin
                  Break;
                end
                else
                  Goods := nil;
              end;
            end;
            if Goods <> nil then
              Continue;
            New(Goods);
            if UserEngine.CopyToUserItemFromNameEx(s48, @Goods.UserItem) then begin
              Goods.sItemName := s48;
              Goods.nCount := _MAX(StrToIntDef(s4C, 0), 1);
              Goods.nStock := Goods.nCount;
              Goods.dwRefillTime := _MAX(StrToIntDef(s50, 0), 1);
              Goods.dwRefillTick := 0;
              Goods.btIdx := StrToIntDef(s54, n70);
              n70 := Goods.btIdx + 1;
              m_NewGoodsList.Add(Goods);
            end
            else
              Dispose(Goods);
          end;
        end; //0048C2D2
      end; //0048C2D2
    end; // for
    LoadList.Free;
    InitializeLabel();
    if boFlag then begin
      with TMerchant(NPC) do begin
        if m_MakeItemsList.Count > 0 then begin
          SetLength(MakeItemArr, m_MakeItemsList.Count);
          NameArr := '';
          for I := 0 to m_MakeItemsList.Count - 1 do begin
            MakeItemArr[I] := pTMakeGoods(m_MakeItemsList[I])^.MakeItem;
            NameArr := NameArr + pTMakeGoods(m_MakeItemsList[I]).sName + '/';
          end;
          OutLen := ZIPCompress(@MakeItemArr[0], SizeOf(TMakeItem) * m_MakeItemsList.Count, 9, OutBuf);
          if OutLen > 0 then begin
            m_MakeItemsLen := OutLen;
            m_MakeItemsCode := EncodeBuffer(OutBuf, OutLen);
            FreeMem(OutBuf);
          end;
          OutLen := ZIPCompress(@NameArr[1], Length(NameArr) + 1, 9, OutBuf);
          if OutLen > 0 then begin
            m_MakeNamesLen := OutLen;
            m_MakeNamesCode := EncodeBuffer(OutBuf, OutLen);
            FreeMem(OutBuf);
          end;

        end;
      end;
    end;
  end
  else begin //0048C2EB
    MainOutMessage('脚本文件未找到: ' + sScritpName);
  end;
  Result := 1;
  ScriptNameList.Free;
  GotoList.Free;
  DelayGotoList.Free;
  PlayDiceList.Free;
  //Showmessage('OK');
end;

{
function TFrmDB.SaveGoodRecord(NPC: TMerchant; sFile: string): Integer; //0048C748
var
 i, ii: Integer;
 sFileName: string;
 FileHandle: Integer;
 UserItem: pTUserItem;
 List: TList;
 Header420: TGoodFileHeader;
begin
 Result := -1;
 sFileName := '.\Envir\Market_Saved\' + sFile + '.sav';
 if FileExists(sFileName) then begin
   FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
 end else begin
   FileHandle := FileCreate(sFileName);
 end;
 if FileHandle > 0 then begin
   SafeFillChar(Header420, SizeOf(TGoodFileHeader), #0);
   for i := 0 to NPC.m_GoodsList.Count - 1 do begin
     List := TList(NPC.m_GoodsList.Items[i]);
     Inc(Header420.nItemCount, List.Count);
   end;
   FileWrite(FileHandle, Header420, SizeOf(TGoodFileHeader));
   for i := 0 to NPC.m_GoodsList.Count - 1 do begin
     List := TList(NPC.m_GoodsList.Items[i]);
     for ii := 0 to List.Count - 1 do begin
       UserItem := List.Items[ii];
       FileWrite(FileHandle, UserItem^, SizeOf(TUserItem));
     end;
   end;
   FileClose(FileHandle);
   Result := 1;
 end;
end;

function TFrmDB.SaveGoodPriceRecord(NPC: TMerchant; sFile: string): Integer; //0048CA64
var
 i: Integer;
 sFileName: string;
 FileHandle: Integer;
 ItemPrice: pTItemPrice;
 Header420: TGoodFileHeader;
begin
 Result := -1;
 sFileName := '.\Envir\Market_Prices\' + sFile + '.prc';
 if FileExists(sFileName) then begin
   FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
 end else begin
   FileHandle := FileCreate(sFileName);
 end;
 if FileHandle > 0 then begin
   SafeFillChar(Header420, SizeOf(TGoodFileHeader), #0);
   Header420.nItemCount := NPC.m_ItemPriceList.Count;
   FileWrite(FileHandle, Header420, SizeOf(TGoodFileHeader));
   for i := 0 to NPC.m_ItemPriceList.Count - 1 do begin
     ItemPrice := NPC.m_ItemPriceList.Items[i];
     FileWrite(FileHandle, ItemPrice^, SizeOf(TItemPrice));
   end;
   FileClose(FileHandle);
   Result := 1;
 end;
end;       }

procedure TFrmDB.ReLoadNpc;
begin

end;

procedure TFrmDB.ReLoadMerchants; //00487BD8
var
  i, ii, nX, nY: Integer;
  sLineText, sFileName, sScript, sMapName, sX, sY, sCharName, sFlag, sAppr, sHintName, sDir, sAppr2,
    sCastle, sCanMove, sMoveTime: string;
  Merchant: TMerchant;
  LoadList: TStringList;
  boNewNpc: Boolean;
  boFlag: Boolean;
  nFlag: Integer;
begin
  sFileName := g_Config.sEnvirDir + RSADecodeString('Az21y67tgkdut8a=Tq'); // 'Merchant.txt'
  if not MyFileExists(sFileName) then
    Exit;
  UserEngine.m_MerchantList.Lock;
  try
    for i := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[i]);
      if not Merchant.m_boFB then
        Merchant.m_nFlag := -1;
    end;
    LoadList := TMsgStringList.Create;
    LoadList.LoadFromFile(sFileName);
    LoadListCall(ExtractFileName(sFileName), LoadList);
    for i := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[i]);
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        nFlag := -1;
        sLineText := GetValidStr3(sLineText, sScript, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMapName, [' ', #9]);
        if (sMapName <> '') and (sMapName[1] = '$') then
          Continue;
        sLineText := GetValidStr3(sLineText, sX, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sY, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCharName, [' ', #9]);
        if (sCharName <> '') and (sCharName[1] = '"') then
          ArrestStringEx(sCharName, '"', '"', sCharName);
        sHintName := GetValidStr3(sCharName, sCharName, ['\', '/', '|']);
        if (sCharName <> '') and (sCharName[1] = '$') then begin
          boFlag := True;
          nFlag := StrToIntDef(Copy(sCharName, 2, Length(sCharName)), -1);
          sCharName := sHintName;
          sHintName := '';
        end
        else
          boFlag := False;
        sLineText := GetValidStr3(sLineText, sFlag, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAppr, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCastle, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCanMove, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMoveTime, [' ', #9]);
        nX := StrToIntDef(sX, 0);
        nY := StrToIntDef(sY, 0);
        boNewNpc := True;
        for ii := 0 to UserEngine.m_MerchantList.Count - 1 do begin
          Merchant := TMerchant(UserEngine.m_MerchantList.Items[ii]);
          if (Merchant.m_sMapName = sMapName) and (Merchant.m_nCurrX = nX) and (Merchant.m_nCurrY = nY) then begin
            boNewNpc := False;
            Merchant.m_boHide := False;
            Merchant.m_sScript := sScript;
            Merchant.m_sCharName := sCharName;
            Merchant.m_sHintName := sHintName;
            Merchant.m_boNameFlag := boFlag;
            Merchant.m_nNameFlag := nFlag;
            Merchant.m_nFlag := StrToIntDef(sFlag, 0);
            sDir := GetValidStr3(sAppr, sAppr2, ['.']);
            Merchant.m_wAppr := StrToIntDef(sAppr2, 0);
            Merchant.m_btDirection := StrToIntDef(sDir, 0);
            //Merchant.m_wAppr := StrToIntDef(sAppr, 0);
            Merchant.m_dwMoveTime := StrToIntDef(sMoveTime, 0);
            if StrToIntDef(sCastle, 0) <> 1 then
              Merchant.m_boCastle := True
            else
              Merchant.m_boCastle := False;

            if (StrToIntDef(sCanMove, 0) <> 0) and (Merchant.m_dwMoveTime > 0) then
              Merchant.m_boCanMove := True;
            break;
          end;
        end;
        if boNewNpc then begin
          Merchant := TMerchant.Create;
          Merchant.m_sMapName := sMapName;
          Merchant.m_sScriptFile := sMapName;
          Merchant.m_PEnvir := g_MapManager.FindMap(Merchant.m_sMapName);
          if Merchant.m_PEnvir <> nil then begin
            Merchant.m_sScript := sScript;
            Merchant.m_nCurrX := nX;
            Merchant.m_nCurrY := nY;
            Merchant.m_sCharName := sCharName;
            Merchant.m_sHintName := sHintName;
            Merchant.m_boNameFlag := boFlag;
            Merchant.m_nNameFlag := nFlag;
            Merchant.m_nFlag := StrToIntDef(sFlag, 0);
            sDir := GetValidStr3(sAppr, sAppr2, ['.']);
            Merchant.m_wAppr := StrToIntDef(sAppr2, 0);
            Merchant.m_btDirection := StrToIntDef(sDir, 0);
            //Merchant.m_wAppr := StrToIntDef(sAppr, 0);
            Merchant.m_dwMoveTime := StrToIntDef(sMoveTime, 0);
            if StrToIntDef(sCastle, 0) <> 1 then
              Merchant.m_boCastle := True
            else
              Merchant.m_boCastle := False;
            if (StrToIntDef(sCanMove, 0) <> 0) and (Merchant.m_dwMoveTime > 0) then
              Merchant.m_boCanMove := True;
            UserEngine.m_MerchantList.Add(Merchant);
            Merchant.Initialize;
          end
          else
            Merchant.Free;
        end;
      end;
    end; // for
    LoadList.Free;
    for i := UserEngine.m_MerchantList.Count - 1 downto 0 do begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[i]);
      if Merchant.m_nFlag = -1 then begin
        Merchant.m_boHide := True;
        //Merchant.m_boGhost := True;
        //Merchant.m_dwGhostTick := GetTickCount();
        //        UserEngine.MerchantList.Delete(I);
      end;
    end;
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
end;

Type
  TOldUpgradeInfo = record //0x40
    sUserName: string[14]; //0x00
    UserItem: TOldUserItem; //0x10
    btDc: Byte; //0x28
    btSc: Byte; //0x29
    btMc: Byte; //0x2A
    btDura: Byte; //0x2B
    n2C: Integer;
    dtTime: TDateTime; //0x30
    dwGetBackTick: LongWord; //0x38
    n3C: Integer;
  end;


function TFrmDB.LoadUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer; //0048CBD0
var
  i: Integer;
  FileHandle, NewFileHandle: Integer;
  sFileName, sBakFileName: string;
  UpgradeInfo: pTUpgradeInfo;
  UpgradeRecord: TUpgradeInfo;
  nRecordCount: Integer;
  nFileSize: Integer;
  boChange: Boolean;
  OldUpgradeInfo: TOldUpgradeInfo;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + '\Market_Upg\' + sNPCName + '.upg';
  CreateDir(g_Config.sEnvirDir + '\Market_Upg\');
  if FileExists(sFileName) then begin
    boChange := False;
    nFileSize := 0;
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      nFileSize := FileSeek(FileHandle, 0, 2);
      if ((nFileSize - SizeOf(Integer)) mod SizeOf(TUpgradeInfo)) <> 0 then begin
        boChange := True;
      end;
      FileClose(FileHandle);
    end;
    if boChange then begin
      sBakFileName := ExtractFilePath(sFileName) + FormatDateTime('YYYY-MM-DD-HH-MM-SS', Now) + '.bak';
      RenameFile(sFileName, sBakFileName);
      DeleteFile(sFileName);
      if ((nFileSize - SizeOf(Integer)) mod SizeOf(TOldUpgradeInfo)) <> 0 then
        Exit;
      FileHandle := FileOpen(sBakFileName, fmOpenRead or fmShareDenyNone);
      NewFileHandle := FileCreate(sFileName);
      if FileHandle > 0 then begin
        FileRead(FileHandle, nRecordCount, SizeOf(Integer));
        FileWrite(NewFileHandle, nRecordCount, SizeOf(Integer));
        for i := 0 to nRecordCount - 1 do begin
          if FileRead(FileHandle, OldUpgradeInfo, SizeOf(TOldUpgradeInfo)) = SizeOf(TOldUpgradeInfo) then begin
            FillChar(UpgradeRecord, SizeOf(UpgradeRecord), #0);
            UpgradeRecord.UserItem.wIndex := OldUpgradeInfo.UserItem.wIndex;
            UpgradeRecord.UserItem.MakeIndex := OldUpgradeInfo.UserItem.MakeIndex;
            UpgradeRecord.UserItem.Dura := OldUpgradeInfo.UserItem.Dura;
            UpgradeRecord.UserItem.DuraMax := OldUpgradeInfo.UserItem.DuraMax;
            UpgradeRecord.UserItem.btBindMode1 := OldUpgradeInfo.UserItem.btBindMode1;
            UpgradeRecord.UserItem.btBindMode2 := OldUpgradeInfo.UserItem.btBindMode2;
            UpgradeRecord.UserItem.TermTime := DateTimeToLongWord(OldUpgradeInfo.UserItem.TermTime);
            UpgradeRecord.UserItem.EffectValue := OldUpgradeInfo.UserItem.EffectValue;
            UpgradeRecord.UserItem.Value := OldUpgradeInfo.UserItem.Value;
            UpgradeRecord.UserItem.ComLevel := 0;
            UpgradeRecord.sUserName := OldUpgradeInfo.sUserName;
            UpgradeRecord.btDc := OldUpgradeInfo.btDc;
            UpgradeRecord.btSc := OldUpgradeInfo.btSc;
            UpgradeRecord.btMc := OldUpgradeInfo.btMc;
            UpgradeRecord.btDura := OldUpgradeInfo.btDura;
            UpgradeRecord.n2C := OldUpgradeInfo.n2C;
            UpgradeRecord.dtTime := OldUpgradeInfo.dtTime;
            UpgradeRecord.dwGetBackTick := OldUpgradeInfo.dwGetBackTick;
            UpgradeRecord.n3C := OldUpgradeInfo.n3C; 
            FileWrite(NewFileHandle, UpgradeRecord, SizeOf(UpgradeRecord));
          end;
        end;
        FileClose(FileHandle);
        FileClose(NewFileHandle);
      end;
    end;
   FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
   if FileHandle > 0 then begin
     FileRead(FileHandle, nRecordCount, SizeOf(Integer));
     for i := 0 to nRecordCount - 1 do begin
       if FileRead(FileHandle, UpgradeRecord, SizeOf(TUpgradeInfo)) = SizeOf(TUpgradeInfo) then begin
         New(UpgradeInfo);
         UpgradeInfo^ := UpgradeRecord;
         UpgradeInfo.dwGetBackTick := 0;
         DataList.Add(UpgradeInfo);
       end;
     end;
     FileClose(FileHandle);
     Result := 1;
   end;
  end;
end;


function TFrmDB.SaveUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
var
 i: Integer;
 FileHandle: Integer;
 sFileName: string;
 UpgradeInfo: pTUpgradeInfo;
begin
 Result := -1;
 sFileName := g_Config.sEnvirDir + 'Market_Upg\' + sNPCName + '.upg';
 if FileExists(sFileName) then begin
   FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
 end
 else begin
   FileHandle := FileCreate(sFileName);
 end;
 if FileHandle > 0 then begin
   FileWrite(FileHandle, DataList.Count, SizeOf(Integer));
   for i := 0 to DataList.Count - 1 do begin
     UpgradeInfo := DataList.Items[i];
     FileWrite(FileHandle, UpgradeInfo^, SizeOf(TUpgradeInfo));
   end;
   FileClose(FileHandle);
   Result := 1;
 end;
end;

function DeCodeString(sSrc: string): string;
//var
//  Dest: array[0..1024] of Char;
  //nDest: Integer;
begin
  if sSrc = '' then
    Exit;
  {if (nDeCryptString >= 0) and Assigned(PlugProcArray[nDeCryptString].nProcAddr) then begin
    SafeFillChar(Dest, SizeOf(Dest), 0);
    TDeCryptString(PlugProcArray[nDeCryptString].nProcAddr)(@sSrc[1], @Dest, Length(sSrc), nDest);
    Result := StrPas(PChar(@Dest));
    Exit;
  end;     }
  Result := sSrc;
end;

procedure TFrmDB.DeCodeStringList(StringList: TStringList);
var
  i: Integer;
  sLine: string;
begin
  if StringList.Count > 0 then begin
    sLine := StringList.Strings[0];
    if not CompareLStr(sLine, sENCYPTSCRIPTFLAG, Length(sENCYPTSCRIPTFLAG)) then begin
      Exit;
    end;
  end;

  for i := 0 to StringList.Count - 1 do begin
    sLine := StringList.Strings[i];
    sLine := DeCodeString(sLine);
    StringList.Strings[i] := sLine;
  end;
end;

constructor TFrmDB.Create();
begin
  CoInitialize(nil);

{$IF DBTYPE = BDE}
  Query := TQuery.Create(nil);
{$ELSE}
  Query := TADOQuery.Create(nil);
{$IFEND}
end;

destructor TFrmDB.Destroy;
begin
  Query.Free;
  CoUnInitialize;
  inherited;
end;

function TFrmDB.GetSetItem(sItemName: string): TList;
var
  I, k: Integer;
  SetItems: pTSetItems;
begin
  Result := nil;
  if sItemName = '' then Exit;
  for I := 0 to g_SetItemsList.Count - 1 do begin
    SetItems := pTSetItems(g_SetItemsList[I]);
    for k := Low(SetItems.Items) to High(SetItems.Items) do begin
      if CompareText(SetItems.Items[k], sItemName) = 0 then begin
        if Result = nil then
          Result := TList.Create;
        Result.Add(Pointer(I));
        break;
      end;
    end;
  end;
end;

initialization
  begin
    //nDeCryptString := AddToPulgProcTable('DeCryptString', 0);
  end;

finalization
  begin

  end;

end.

