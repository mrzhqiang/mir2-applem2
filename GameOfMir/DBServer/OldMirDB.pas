unit OldMirDB;

interface
uses
  SysUtils, Windows, Classes, Grobal2;

const
  sOLdDBHeaderDesc = '新热血传奇数据库文件 2011/04/22';
  sOLdDBIdxHeaderDesc = '新热血传奇数据库索引文件 2011/04/22';
type

  {TOldMissionInfo = packed record
    sMissionName: string[MapNameLen];
    btKillCount1: Byte;
    btKillCount2: Byte;
    boTrack: Boolean;
  end;

  TOldMissionInfos = array[1..20] of TOldMissionInfo;    }

  {TOldUserItem = packed record
    MakeIndex: Integer;
    wIndex: Word;
    Dura: Word;
    DuraMax: Word;
    btBindMode1: Byte;
    btBindMode2: Byte;
    TermTime: TDateTime;
    Value: TUserItemValue;
  end;          }

  TOldStorageItem = packed record
    idx: Byte;
    UserItem: TOldUserItem;
  end;

  TOldHumanUseItems = array[Low(THumanUseItems)..High(THumanUseItems)] of TOldUserItem;
  TOldHumanReturnItems = array[Low(THumanReturnItems)..High(THumanReturnItems)] of TOldUserItem;
  TOldHumanAppendBagItems = array[Low(THumanAppendBagItems)..High(THumanAppendBagItems)] of TOldUserItem;
  TOldBagItems = array[Low(TBagItems)..High(TBagItems)] of TOldUserItem;
  TOldStorageItems = array[Low(TStorageItems)..High(TStorageItems)] of TOldStorageItem;

  TOldHumData = packed record
    nIdx: Integer;
    sChrName: string[ActorNameLen];
    sCurMap: string[MapNameLen];
    wCurX: Word;
    wCurY: Word;
    btDir: Byte;
    btHair: Byte;
    btSex: Byte;
    btJob: Byte;
    nGold: Integer;
    nBindGold: Integer;

    Abil: TAbility;
    NakedAbil: TNakedAbil;
    nNakedAbilCount: Word;
    wStatusTimeArr: TStatusTime;
    sHomeMap: string[MapNameLen];
    wHomeX: Word;
    wHomeY: Word;
    sDieMap: string[MapNameLen];
    wDieX: Word;
    wDieY: Word;

    sDearName: string[ActorNameLen];
    MasterName: THumMasterName;
    //sMasterName: string[14];
    boMaster: Boolean;

    LoginTime: TDateTime;
    LoginAddr: string[15];

    btCreditPoint: Integer;

    sStoragePwd: string[12]; //
    nStorageGold: Integer;
    boStorageLock: Boolean;
    btStorageErrorCount: Byte;
    StorageLockTime: TDateTime;
    btReLevel: Byte;

    nGameGold: Integer; //
    nGamePoint: Integer;
    nGameDiamond: Integer;
    nGameGird: Integer;
    nPKPoint: Integer;
    nPullulation: Integer;     //自然成长点
    //btMagicConcatenation: TMagicConcatenation;

    btAttatckMode: byte;
    nIncHealth: byte; //
    nIncSpell: byte; //
    nIncHealing: byte; //
    btFightZoneDieCount: Byte;
    sAccount: string[16]; //
    sGuildName: string[ActorNameLen];
    wContribution: Word;

    dBodyLuck: Double; //
    wGuildRcallTime: Word;
    wGroupRcallTime: Word;

    nAllowSetup: LongWord;
    boAddStabilityPoint: Boolean;

    {boAllowGroup: Boolean; //  允许组队
    boAllowGuildReCall: Boolean;   //允许行会天地合一
    boAllowGroupReCall: Boolean;  //允许天地合一
    boCheckGroup: Boolean;} //   组除需要验证

    btMasterCount: Word; //
    btWuXin: Byte;
    boChangeName: Boolean; //
    nExpRate: Integer;
    nExpTime: LongWord;
//    dwUpLoadPhotoTime: TDateTime;
//    UserRealityInfo: TUserRealityInfo; //用户真实信息
    UserKeySetup: TUserKeySetup;
    QuestFlag: TQuestFlag;
    MissionFlag: TMissionFlag;
    MissionInfo: TMissionInfos;
    MissionArithmometer: TMissionArithmometer;
    MissionIndex: TMissionIndex;

    ReturnItems: TOldHumanReturnItems; //回购物品
    AppendBagItems: TOldHumanAppendBagItems; //额外背包
    HumItems: TOldHumanUseItems;
    BagItems: TOldBagItems;

    HumMagics: THumMagics;
    CboMagicListInfo: TCboMagicListInfo;
    
    StorageItems: TOldStorageItems;

    StorageOpen2: Boolean;
    StorageTime2: TDateTime;
    StorageItems2: TOldStorageItems;

    StorageOpen3: Boolean;
    StorageTime3: TDateTime;
    StorageItems3: TOldStorageItems;
    {StorageOpen4: Boolean;
    StorageTime4: TDateTime;
    StorageItems4: TStorageItems;
    StorageOpen5: Boolean;
    StorageTime5: TDateTime;
    StorageItems5: TStorageItems;  }
    UserOptionSetup: TUserOptionSetup;
    wNakedBackCount: Word;
    nOptionReserve: array[0..253] of byte; //  无用
    nItemsSetupCount: Word;
    UserItemsSetup: TUserItemsSetup;
    FriendList: THumanFriends;
//    nPhotoSize: Word;
//    pPhotoData: array[0..MAXPHOTODATASIZE] of byte;
    MakeMagic: TMakeMagic;
    MakeMagicPoint: Word;
    //EMailInfo: THumanEMailInfo;
    CustomVariable: THumCustomVariable;
    BStrVariable: THumBVariable;
    nReserve: array[0..1023] of byte; //
  end;

  TOLDHumDataInfo = packed record
    Header: TRecordHeader;
    Data: TOLDHumData;
  end;

procedure CheckFileVer(sFileName: string);
procedure CheckIdxFileVer(sFileName: string);

implementation

uses
  HumDB;

procedure CheckIdxFileVer(sFileName: string);
var
  FileHandle: THandle;
  DBHeader: TDBHeader;
  boChange: Boolean;
begin
  boChange := False;
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenReadWrite or fmShareDenyNone);
    if FileHandle > 0 then begin
      FileRead(FileHandle, DBHeader, SizeOf(TDBHeader));
      if DBHeader.sDesc = sOLdDBHeaderDesc then begin
        boChange := True;
      end else
        FileClose(FileHandle);
    end;
    if boChange then begin
      FileSeek(FileHandle, 0, 0);
      DBHeader.sDesc := sDBHeaderDesc; 
      FileWrite(FileHandle, DBHeader, SizeOf(TDBHeader));
      FileClose(FileHandle);
    end;
  end;
end;

procedure CheckFileVer(sFileName: string);
var
  FileHandle, NewFileHandle: THandle;
  DBHeader: TDBHeader;
  boChange: Boolean;
  I: Integer;
  OldData: TOLDHumDataInfo;
  Data: THumDataInfo;
  K: Integer;
begin
  boChange := False;
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      FileRead(FileHandle, DBHeader, SizeOf(TDBHeader));
      if DBHeader.sDesc = sOLdDBHeaderDesc then begin
        boChange := True;
      end;
      FileClose(FileHandle);
    end;
    if boChange then begin
      DeleteFile(PChar(sFileName + '.bak'));
      RenameFile(sFileName, sFileName + '.bak');
      NewFileHandle := FileCreate(sFileName);
      if NewFileHandle > 0 then begin
        FileHandle := FileOpen(sFileName + '.bak', fmOpenRead or fmShareDenyNone);
        if FileHandle > 0 then begin
          FileRead(FileHandle, DBHeader, SizeOf(TDBHeader));
          DBHeader.sDesc := sDBHeaderDesc;
          FileWrite(NewFileHandle, DBHeader, SizeOf(TDBHeader));
          for I := 0 to DBHeader.nHumCount - 1 do begin
            if FileRead(FileHandle, OldData, SizeOf(OldData)) = SizeOf(OldData) then begin
              FillChar(Data, SizeOf(Data), #0);
              Data.Header := OldData.Header;
              Data.Data.nIdx := OldData.Data.nIdx;
              Data.Data.sChrName := OldData.Data.sChrName;
              Data.Data.sCurMap := OldData.Data.sCurMap;
              Data.Data.wCurX := OldData.Data.wCurX;
              Data.Data.wCurY := OldData.Data.wCurY;
              Data.Data.btDir := OldData.Data.btDir;
              Data.Data.btHair := OldData.Data.btHair;
              Data.Data.btSex := OldData.Data.btSex;
              Data.Data.btJob := OldData.Data.btJob;
              Data.Data.nGold := OldData.Data.nGold;
              Data.Data.nBindGold := OldData.Data.nBindGold;

              Data.Data.Abil := OldData.Data.Abil;
              Data.Data.NakedAbil := OldData.Data.NakedAbil;
              Data.Data.nNakedAbilCount := OldData.Data.nNakedAbilCount;
              Data.Data.wStatusTimeArr := OldData.Data.wStatusTimeArr;
              Data.Data.sHomeMap := OldData.Data.sHomeMap;
              Data.Data.wHomeX := OldData.Data.wHomeX;
              Data.Data.wHomeY := OldData.Data.wHomeY;
              Data.Data.sDieMap := OldData.Data.sDieMap;
              Data.Data.wDieX := OldData.Data.wDieX;
              Data.Data.wDieY := OldData.Data.wDieY;

              Data.Data.sDearName := OldData.Data.sDearName;
              Data.Data.MasterName := OldData.Data.MasterName;
              Data.Data.boMaster := OldData.Data.boMaster;

              Data.Data.LoginTime := OldData.Data.LoginTime;
              Data.Data.LoginAddr := OldData.Data.LoginAddr;

              Data.Data.btCreditPoint := OldData.Data.btCreditPoint;

              Data.Data.sStoragePwd := OldData.Data.sStoragePwd;
              Data.Data.nStorageGold := OldData.Data.nStorageGold;
              Data.Data.boStorageLock := OldData.Data.boStorageLock;
              Data.Data.btStorageErrorCount := OldData.Data.btStorageErrorCount;
              Data.Data.StorageLockTime := OldData.Data.StorageLockTime;
              Data.Data.btReLevel := OldData.Data.btReLevel;

              Data.Data.nGameGold := OldData.Data.nGameGold;
              Data.Data.nGamePoint := OldData.Data.nGamePoint;
              Data.Data.nGameDiamond := OldData.Data.nGameDiamond;
              Data.Data.nGameGird := OldData.Data.nGameGird;
              Data.Data.nPKPoint := OldData.Data.nPKPoint;
              Data.Data.nPullulation := OldData.Data.nPullulation;

              Data.Data.btAttatckMode := OldData.Data.btAttatckMode;
              Data.Data.nIncHealth := OldData.Data.nIncHealth;
              Data.Data.nIncSpell := OldData.Data.nIncSpell;
              Data.Data.nIncHealing := OldData.Data.nIncHealing;
              Data.Data.btFightZoneDieCount := OldData.Data.btFightZoneDieCount;
              Data.Data.sAccount := OldData.Data.sAccount;
              Data.Data.sGuildName := OldData.Data.sGuildName;
              Data.Data.wContribution := OldData.Data.wContribution;

              Data.Data.dBodyLuck := OldData.Data.dBodyLuck;
              Data.Data.wGuildRcallTime := OldData.Data.wGuildRcallTime;
              Data.Data.wGroupRcallTime := OldData.Data.wGroupRcallTime;

              Data.Data.nAllowSetup := OldData.Data.nAllowSetup;
              Data.Data.boAddStabilityPoint := OldData.Data.boAddStabilityPoint;

              Data.Data.btMasterCount := OldData.Data.btMasterCount;
              Data.Data.btWuXin := OldData.Data.btWuXin;
              Data.Data.boChangeName := OldData.Data.boChangeName;
              Data.Data.nExpRate := OldData.Data.nExpRate;
              Data.Data.nExpTime := OldData.Data.nExpTime;
//              Data.Data.dwUpLoadPhotoTime := OldData.Data.dwUpLoadPhotoTime;
//              Data.Data.UserRealityInfo := OldData.Data.UserRealityInfo;
              Data.Data.UserKeySetup := OldData.Data.UserKeySetup;
              Data.Data.QuestFlag := OldData.Data.QuestFlag;
              Data.Data.MissionFlag := OldData.Data.MissionFlag;
              Data.Data.MissionInfo := OldData.Data.MissionInfo;
              Data.Data.MissionArithmometer := OldData.Data.MissionArithmometer;
              Data.Data.MissionIndex := OldData.Data.MissionIndex;
              //Data.Data.ReturnItems := OldData.Data.ReturnItems;
              for k := Low(Data.Data.ReturnItems) to High(Data.Data.ReturnItems) do begin
                Data.Data.ReturnItems[k].MakeIndex := OldData.Data.ReturnItems[k].MakeIndex;
                Data.Data.ReturnItems[k].wIndex := OldData.Data.ReturnItems[k].wIndex;
                Data.Data.ReturnItems[k].Dura := OldData.Data.ReturnItems[k].Dura;
                Data.Data.ReturnItems[k].DuraMax := OldData.Data.ReturnItems[k].DuraMax;
                Data.Data.ReturnItems[k].btBindMode1 := OldData.Data.ReturnItems[k].btBindMode1;
                Data.Data.ReturnItems[k].btBindMode2 := OldData.Data.ReturnItems[k].btBindMode2;
                Data.Data.ReturnItems[k].TermTime := DateTimeToLongWord(OldData.Data.ReturnItems[k].TermTime);
                Data.Data.ReturnItems[k].Value := OldData.Data.ReturnItems[k].Value;
                Data.Data.ReturnItems[k].EffectValue := OldData.Data.ReturnItems[k].EffectValue;
              end;


              //Data.Data.AppendBagItems := OldData.Data.AppendBagItems;
              for k := Low(Data.Data.AppendBagItems) to High(Data.Data.AppendBagItems) do begin
                Data.Data.AppendBagItems[k].MakeIndex := OldData.Data.AppendBagItems[k].MakeIndex;
                Data.Data.AppendBagItems[k].wIndex := OldData.Data.AppendBagItems[k].wIndex;
                Data.Data.AppendBagItems[k].Dura := OldData.Data.AppendBagItems[k].Dura;
                Data.Data.AppendBagItems[k].DuraMax := OldData.Data.AppendBagItems[k].DuraMax;
                Data.Data.AppendBagItems[k].btBindMode1 := OldData.Data.AppendBagItems[k].btBindMode1;
                Data.Data.AppendBagItems[k].btBindMode2 := OldData.Data.AppendBagItems[k].btBindMode2;
                Data.Data.AppendBagItems[k].TermTime := DateTimeToLongWord(OldData.Data.AppendBagItems[k].TermTime);
                Data.Data.AppendBagItems[k].Value := OldData.Data.AppendBagItems[k].Value;
                Data.Data.AppendBagItems[k].EffectValue := OldData.Data.AppendBagItems[k].EffectValue;
              end;
              //Data.Data.HumItems := OldData.Data.HumItems;
              for k := Low(Data.Data.HumItems) to High(Data.Data.HumItems) do begin
                Data.Data.HumItems[k].MakeIndex := OldData.Data.HumItems[k].MakeIndex;
                Data.Data.HumItems[k].wIndex := OldData.Data.HumItems[k].wIndex;
                Data.Data.HumItems[k].Dura := OldData.Data.HumItems[k].Dura;
                Data.Data.HumItems[k].DuraMax := OldData.Data.HumItems[k].DuraMax;
                Data.Data.HumItems[k].btBindMode1 := OldData.Data.HumItems[k].btBindMode1;
                Data.Data.HumItems[k].btBindMode2 := OldData.Data.HumItems[k].btBindMode2;
                Data.Data.HumItems[k].TermTime := DateTimeToLongWord(OldData.Data.HumItems[k].TermTime);
                Data.Data.HumItems[k].Value := OldData.Data.HumItems[k].Value;
                Data.Data.HumItems[k].EffectValue := OldData.Data.HumItems[k].EffectValue;
              end;
              //Data.Data.BagItems := OldData.Data.BagItems;
              for k := Low(Data.Data.BagItems) to High(Data.Data.BagItems) do begin
                Data.Data.BagItems[k].MakeIndex := OldData.Data.BagItems[k].MakeIndex;
                Data.Data.BagItems[k].wIndex := OldData.Data.BagItems[k].wIndex;
                Data.Data.BagItems[k].Dura := OldData.Data.BagItems[k].Dura;
                Data.Data.BagItems[k].DuraMax := OldData.Data.BagItems[k].DuraMax;
                Data.Data.BagItems[k].btBindMode1 := OldData.Data.BagItems[k].btBindMode1;
                Data.Data.BagItems[k].btBindMode2 := OldData.Data.BagItems[k].btBindMode2;
                Data.Data.BagItems[k].TermTime := DateTimeToLongWord(OldData.Data.BagItems[k].TermTime);
                Data.Data.BagItems[k].Value := OldData.Data.BagItems[k].Value;
                Data.Data.BagItems[k].EffectValue := OldData.Data.BagItems[k].EffectValue;
              end;
              Data.Data.HumMagics := OldData.Data.HumMagics;
              Data.Data.CboMagicListInfo := OldData.Data.CboMagicListInfo;
              //Data.Data.StorageItems := OldData.Data.StorageItems;
              for k := Low(Data.Data.StorageItems) to High(Data.Data.StorageItems) do begin
                Data.Data.StorageItems[k].idx := OldData.Data.StorageItems[k].idx;
                Data.Data.StorageItems[k].UserItem.MakeIndex := OldData.Data.StorageItems[k].UserItem.MakeIndex;
                Data.Data.StorageItems[k].UserItem.wIndex := OldData.Data.StorageItems[k].UserItem.wIndex;
                Data.Data.StorageItems[k].UserItem.Dura := OldData.Data.StorageItems[k].UserItem.Dura;
                Data.Data.StorageItems[k].UserItem.DuraMax := OldData.Data.StorageItems[k].UserItem.DuraMax;
                Data.Data.StorageItems[k].UserItem.btBindMode1 := OldData.Data.StorageItems[k].UserItem.btBindMode1;
                Data.Data.StorageItems[k].UserItem.btBindMode2 := OldData.Data.StorageItems[k].UserItem.btBindMode2;
                Data.Data.StorageItems[k].UserItem.TermTime := DateTimeToLongWord(OldData.Data.StorageItems[k].UserItem.TermTime);
                Data.Data.StorageItems[k].UserItem.Value := OldData.Data.StorageItems[k].UserItem.Value;
                Data.Data.StorageItems[k].UserItem.EffectValue := OldData.Data.StorageItems[k].UserItem.EffectValue;
              end;
              Data.Data.StorageOpen2 := OldData.Data.StorageOpen2;
              Data.Data.StorageTime2 := OldData.Data.StorageTime2;
              //Data.Data.StorageItems2 := OldData.Data.StorageItems2;
              for k := Low(Data.Data.StorageItems2) to High(Data.Data.StorageItems2) do begin
                Data.Data.StorageItems2[k].idx := OldData.Data.StorageItems2[k].idx;
                Data.Data.StorageItems2[k].UserItem.MakeIndex := OldData.Data.StorageItems2[k].UserItem.MakeIndex;
                Data.Data.StorageItems2[k].UserItem.wIndex := OldData.Data.StorageItems2[k].UserItem.wIndex;
                Data.Data.StorageItems2[k].UserItem.Dura := OldData.Data.StorageItems2[k].UserItem.Dura;
                Data.Data.StorageItems2[k].UserItem.DuraMax := OldData.Data.StorageItems2[k].UserItem.DuraMax;
                Data.Data.StorageItems2[k].UserItem.btBindMode1 := OldData.Data.StorageItems2[k].UserItem.btBindMode1;
                Data.Data.StorageItems2[k].UserItem.btBindMode2 := OldData.Data.StorageItems2[k].UserItem.btBindMode2;
                Data.Data.StorageItems2[k].UserItem.TermTime := DateTimeToLongWord(OldData.Data.StorageItems2[k].UserItem.TermTime);
                Data.Data.StorageItems2[k].UserItem.Value := OldData.Data.StorageItems2[k].UserItem.Value;
                Data.Data.StorageItems2[k].UserItem.EffectValue := OldData.Data.StorageItems2[k].UserItem.EffectValue;
              end;
              Data.Data.StorageOpen3 := OldData.Data.StorageOpen3;
              Data.Data.StorageTime3 := OldData.Data.StorageTime3;
              //Data.Data.StorageItems3 := OldData.Data.StorageItems3;
              for k := Low(Data.Data.StorageItems3) to High(Data.Data.StorageItems3) do begin
                Data.Data.StorageItems3[k].idx := OldData.Data.StorageItems3[k].idx;
                Data.Data.StorageItems3[k].UserItem.MakeIndex := OldData.Data.StorageItems3[k].UserItem.MakeIndex;
                Data.Data.StorageItems3[k].UserItem.wIndex := OldData.Data.StorageItems3[k].UserItem.wIndex;
                Data.Data.StorageItems3[k].UserItem.Dura := OldData.Data.StorageItems3[k].UserItem.Dura;
                Data.Data.StorageItems3[k].UserItem.DuraMax := OldData.Data.StorageItems3[k].UserItem.DuraMax;
                Data.Data.StorageItems3[k].UserItem.btBindMode1 := OldData.Data.StorageItems3[k].UserItem.btBindMode1;
                Data.Data.StorageItems3[k].UserItem.btBindMode2 := OldData.Data.StorageItems3[k].UserItem.btBindMode2;
                Data.Data.StorageItems3[k].UserItem.TermTime := DateTimeToLongWord(OldData.Data.StorageItems3[k].UserItem.TermTime);
                Data.Data.StorageItems3[k].UserItem.Value := OldData.Data.StorageItems3[k].UserItem.Value;
                Data.Data.StorageItems3[k].UserItem.EffectValue := OldData.Data.StorageItems3[k].UserItem.EffectValue;
              end;

              Data.Data.UserOptionSetup := OldData.Data.UserOptionSetup;
              Data.Data.wNakedBackCount := OldData.Data.wNakedBackCount;
              //Move(OldData.Data.nOptionReserve[0], Data.Data.nOptionReserve[0], SizeOf(OldData.Data.nOptionReserve));
              Data.Data.nItemsSetupCount := OldData.Data.nItemsSetupCount;
              Data.Data.UserItemsSetup := OldData.Data.UserItemsSetup;
              Data.Data.FriendList := OldData.Data.FriendList;
//              Data.Data.nPhotoSize := OldData.Data.nPhotoSize;
//              Move(OldData.Data.pPhotoData[0], Data.Data.pPhotoData[0], SizeOf(OldData.Data.pPhotoData));

              Data.Data.MakeMagic := OldData.Data.MakeMagic;
              Data.Data.MakeMagicPoint := OldData.Data.MakeMagicPoint;
              Data.Data.CustomVariable := OldData.Data.CustomVariable;
              Data.Data.BStrVariable := OldData.Data.BStrVariable;

              FileWrite(NewFileHandle, Data, SizeOf(Data));
            end
            else
              break;
          end;
          FileClose(FileHandle);
        end;
        FileClose(NewFileHandle);
        DeleteFile(PChar(sFileName + '.idx'));
      end;
    end;
  end; 
end;

end.

