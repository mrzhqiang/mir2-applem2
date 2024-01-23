unit FrnEmail;

interface

uses
  Windows, Classes, SysUtils, Grobal2, SDK, MudUtil, DateUtils;

const
  MAXEMAILCOUNT = 3;
  
  MAXEMAILSAVEDAY = 30; //有物品的信件最大保存30天
  MAXEMAILSYSDAY = 3; //系统已读信件最短保存时间，未读则永久保存，但不超过最长保存时间
  MAXEMAILTEXTLEN = 1000;
  SYSEMAILNAME = '[系统]';

  EMS_USERLOGIN = 1000;
  EMS_USERGHOST = 1001;
  EMS_ADDEMAIL = 1002;
  EMS_READEMAIL = 1003;
  EMS_GETGOLD = 1004;
  EMS_GETITEM = 1005;
  EMS_DELEMAIL = 1006;
  EMS_ADDALLEMAIL = 1007;

type


  pTEMailHeaderInfo = ^TEMailHeaderInfo;
  TEMailHeaderInfo = packed record
    boRead: Boolean;
    boSystem: Boolean;
    sTitle: string[20];
    sSendName: string[ActorNameLen];
    CreateTime: TDateTime;
  end;

  pTEMailInfo = ^TEMailInfo;
  TEMailInfo = packed record
    boDelete: Boolean;
    Header: TEMailHeaderInfo;
    sReadName: string[ActorNameLen];
    nGold: Integer;
    Item: TUserItem;
    TextLen: Word;
    Text: array[0..MAXEMAILTEXTLEN - 1] of char;
  end;

  TOldEMailInfo = packed record
    boDelete: Boolean;
    Header: TEMailHeaderInfo;
    sReadName: string[ActorNameLen];
    nGold: Integer;
    Item: TOldUserItem;
    TextLen: Word;
    Text: array[0..MAXEMAILTEXTLEN - 1] of char;
  end;

  pTEMailListInfo = ^TEMailListInfo;
  TEMailListInfo = packed record
    nIndex: Integer;
    EMailInfo: TEMailHeaderInfo;
  end;

  pTEMailUserInfo = ^TEMailUserInfo;
  TEMailUserInfo = packed record
    nDBIndex: Integer;
    EMailList: TList;
  end;

  pTEMailSendMessage = ^TEMailSendMessage;
  TEMailSendMessage = packed record
    wIdent: Word;
    nDBIndex: Integer;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    Buff: PChar;
    EMailInfo: pTEMailInfo;
  end;

  pTEMailProcessMessage = ^TEMailProcessMessage;
  TEMailProcessMessage = packed record
    wIdent: Word;
    nDBIndex: Integer;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    sMsg: string;
    EMailInfo: pTEMailInfo;
  end;

  TUserEMail = class(TThread)
  protected
    FCriticalSection: TRTLCriticalSection;
    FMsgList: TList;
    FNameList: TQuickList;
    FFileStream: TFileStream;
    FDeleteList: TList;
    FEMailCount: Integer;
    FSYSMailUserInfo: pTEMailUserInfo;
    FInitialize: Boolean;
    FSaveNameTick: LongWord;
    procedure Execute; override;
    function GetMessage(Msg: pTEMailProcessMessage): Boolean;
    procedure Run();
    procedure UserLogin(nDBIndex: Integer; sChrName: string);
    procedure UserGhost(nDBIndex: Integer; sChrName: string);
    procedure AddEMail(nDBIndex: Integer; EMailInfo: pTEMailInfo);
    procedure AddAllEmail(EMailInfo: pTEMailInfo);
    procedure ReadEMail(nDBIndex, nIndex: Integer; sChrName: string);
    procedure GetGold(nDBIndex, nIndex: Integer; sChrName: string);
    procedure GetItem(nDBIndex, nIndex: Integer; sChrName: string);
    procedure DeleteEMail(nDBIndex, nIndex: Integer; sChrName: string);
    function WriteData(nIndex: Integer; Buffer: PChar; nLen: Integer): Integer;
    function ReadData(nIndex: Integer; Buffer: PChar; nLen: Integer): Integer;
    function GetWriteIndex: Integer;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;

    function Initialize: Integer;
    procedure FreeInitialize;
    procedure Lock;
    procedure UnLock;
    function MsgCount: Integer;
    function UserCount: Integer;
    function EMailCount: Integer;
    function IsIdle: Boolean;
    procedure SendMsg(wIdent: Integer; nDBIndex, nParam1, nParam2, nParam3: Integer; sMsg: string; EMailInfo: pTEMailInfo);
    function SendMail(const AUserName, AText, ATitle: string; AAll: Boolean): Boolean;
  end;

var
  UserEMail: TUserEMail;

implementation
uses
  M2Share, ObjBase, ObjPlay, UsrEngn, EDcodeEx, Hutil32;

const
  //DATADIR = 'EMail\';
  DATAFILE = 'EMailData.dat';
  DATALIST = 'EMailName.txt';

procedure TUserEMail.AddAllEmail(EMailInfo: pTEMailInfo);
var
  EMailUserInfo: pTEMailUserInfo;
  nIndex, nIDIndex: Integer;
  EMailListInfo: pTEMailListInfo;
//  nBack: Integer;
  //SendObject,
  ReadObject: TPlayObject;
  ClientEMailHeader: TClientEMailHeader;
//  UserItem: pTUserItem;
//  Stditem: pTStdItem;
  I: Integer;
  sName: string;
begin
  if EMailInfo = nil then exit;
  FNameList.Lock;
  Try
    for I := 0 to FNameList.Count - 1 do begin
      sName := FNameList[I];
      if sName <> SYSEMAILNAME then begin
        EMailUserInfo := pTEMailUserInfo(FNameList.Objects[I]);

        nIDIndex := GetWriteIndex;
        nIndex := WriteData(nIDIndex, PChar(EMailInfo), SizeOf(TEMailInfo));
        if nIndex = SizeOf(TEMailInfo) then begin
          New(EMailListInfo);
          EMailListInfo.nIndex := nIDIndex;
          EMailListInfo.EMailInfo := EMailInfo.Header;
          EMailUserInfo.EMailList.Add(EMailListInfo);

          ReadObject := GetLoginPlay(EMailUserInfo.nDBIndex);
          if (ReadObject <> nil) and (not ReadObject.m_boGhost) then begin
            ClientEMailHeader.nIdx := EMailListInfo.nIndex;
            ClientEMailHeader.sTitle := EMailListInfo.EMailInfo.sTitle;
            ClientEMailHeader.boRead := EMailListInfo.EMailInfo.boRead;
            ClientEMailHeader.sSendName := EMailListInfo.EMailInfo.sSendName;
            ClientEMailHeader.boSystem := EMailListInfo.EMailInfo.boSystem;
            ClientEMailHeader.btTime := 0;
            ReadObject.SendDefSocket(ReadObject, SM_EMAIL, 2, 0, 0, 2, EncodeBuffer(@ClientEMailHeader, SizeOf(ClientEMailHeader)));
          end;
        end;
      end;
    end;
  Finally
    Dispose(EMailInfo);
    FNameList.UnLock;
  End;
end;

procedure TUserEMail.AddEMail(nDBIndex: Integer; EMailInfo: pTEMailInfo);
var
  EMailUserInfo: pTEMailUserInfo;
  nIndex, nIDIndex: Integer;
  EMailListInfo: pTEMailListInfo;
  nBack: Integer;
  SendObject, ReadObject: TPlayObject;
  ClientEMailHeader: TClientEMailHeader;
  UserItem: pTUserItem;
  Stditem: pTStdItem;
begin
  if EMailInfo = nil then exit;
  FNameList.Lock;
  Try
    if EMailInfo.sReadName = '' then exit;
    nBack := -3;
    EMailListInfo := nil;
    nIndex := FNameList.GetIndex(EMailInfo.sReadName);
    if nIndex = -1 then begin
      New(EMailUserInfo);
      EMailUserInfo.nDBIndex := -1;
      EMailUserInfo.EMailList := TList.Create;
      FNameList.AddRecord(EMailInfo.sReadName, Integer(EMailUserInfo));
    end else begin
      EMailUserInfo := pTEMailUserInfo(FNameList.Objects[nIndex]);
    end;
    if (EMailUserInfo.EMailList.Count < MAXEMAILCOUNT) or (EMailInfo.Header.boSystem) then begin
      nIDIndex := GetWriteIndex;
      nIndex := WriteData(nIDIndex, PChar(EMailInfo), SizeOf(TEMailInfo));
      if nIndex = SizeOf(TEMailInfo) then begin
        New(EMailListInfo);
        EMailListInfo.nIndex := nIDIndex;
        EMailListInfo.EMailInfo := EMailInfo.Header;
        EMailUserInfo.EMailList.Add(EMailListInfo);
        nBack := 1;
      end else
        nBack := -4;
    end;
    if nBack = 1 then begin
      //AddGameLog(nil, LOG_EMAIL, EMailInfo.Header.sSendName, Integer(EMailInfo), 0, EMailInfo.sReadName, '0', '0', '发送成功');
      SendObject := GetLoginPlay(nDBIndex);
      if (SendObject <> nil) and (not SendObject.m_boGhost) then begin
        SendObject.SendDefMsg(SendObject, SM_EMAIL, 1, 0, 0, 2, '');
      end;
      ReadObject := GetLoginPlay(EMailUserInfo.nDBIndex);
      if (ReadObject <> nil) and (not ReadObject.m_boGhost) and (EMailListInfo <> nil) then begin
        ClientEMailHeader.nIdx := EMailListInfo.nIndex;
        ClientEMailHeader.sTitle := EMailListInfo.EMailInfo.sTitle;
        ClientEMailHeader.boRead := EMailListInfo.EMailInfo.boRead;
        ClientEMailHeader.sSendName := EMailListInfo.EMailInfo.sSendName;
        ClientEMailHeader.boSystem := EMailListInfo.EMailInfo.boSystem;
        ClientEMailHeader.btTime := 0;
        ReadObject.SendDefSocket(ReadObject, SM_EMAIL, 2, 0, 0, 2, EncodeBuffer(@ClientEMailHeader, SizeOf(ClientEMailHeader)));
      end;
    end else begin
      if (not EMailInfo.Header.boSystem) and (EMailInfo.Item.MakeIndex <> 0) then begin
        EnterCriticalSection(ProcessHumanCriticalSection);
        Try
          SendObject := GetLoginPlay(nDBIndex);
          if (SendObject <> nil) and (not SendObject.m_boGhost) then begin
            SendObject.SendDefMsg(SendObject, SM_EMAIL, nBack, 0, 0, 2, '');
            New(UserItem);
            UserItem^ := EMailInfo.Item;
            Stditem := UserEngine.GetStdItem(UserItem.wIndex);
            if Stditem <> nil then begin
              if Stditem.NeedIdentify = 1 then
                AddGameLog(SendObject, LOG_ADDITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura, EMailInfo.sReadName,
                  IntToStr(Integer(EMailInfo)), '0', '信件返回', UserItem);
              SendObject.m_ItemList.Add(UserItem);
              EMailInfo.Item.MakeIndex := 0;
            end else
              Dispose(UserItem);
          end;
        Finally
          LeaveCriticalSection(ProcessHumanCriticalSection);
        End;
        if (EMailInfo.Item.MakeIndex <> 0) and (FSYSMailUserInfo <> nil) and (nBack <> -4) then begin
          Stditem := UserEngine.GetStdItem(EMailInfo.Item.wIndex);
          if Stditem <> nil then begin
            if Stditem.NeedIdentify = 1 then
              AddGameLog(nil, LOG_ADDITEM, StdItem.Name, EMailInfo.Item.MakeIndex, EMailInfo.Item.Dura,
                EMailInfo.sReadName, IntToStr(Integer(EMailInfo)), SYSEMAILNAME, '信件转移', @EMailInfo.Item);
            EMailInfo.sReadName := SYSEMAILNAME;
            EMailInfo.boDelete := False;
            nIDIndex := GetWriteIndex;
            nIndex := WriteData(nIDIndex, PChar(EMailInfo), SizeOf(TEMailInfo));
            if nIndex = SizeOf(TEMailInfo) then begin
              New(EMailListInfo);
              EMailListInfo.nIndex := nIDIndex;
              EMailListInfo.EMailInfo := EMailInfo.Header;
              FSYSMailUserInfo.EMailList.Add(EMailListInfo);
            end;
          end;
        end;
      end else begin
        SendObject := GetLoginPlay(nDBIndex);
        if (SendObject <> nil) and (not SendObject.m_boGhost) then begin
          SendObject.SendDefMsg(SendObject, SM_EMAIL, nBack, 0, 0, 2, '');
        end;
      end;
    end;
  Finally
    Dispose(EMailInfo);
    FNameList.UnLock;
  End;
end;

constructor TUserEMail.Create(CreateSuspended: Boolean);
begin
  inherited;
  InitializeCriticalSection(FCriticalSection);
  FMsgList := TList.Create;
  FNameList := TQuickList.Create;
  FDeleteList := TList.Create;
  FEMailCount := 0;
  FSYSMailUserInfo := nil;
  FInitialize := False;
  FSaveNameTick := GetTickCount;
end;

destructor TUserEMail.Destroy;
begin
  FreeInitialize;
  FMsgList.Free;
  FNameList.Free;
  FDeleteList.Free;
  DeleteCriticalSection(FCriticalSection);
  inherited;
end;

function TUserEMail.EMailCount: Integer;
begin
  Result := FEMailCount;
end;

procedure TUserEMail.Execute;
resourcestring
  sExceptionMsg = '[Exception] TUserEMail.Execute';
begin
  while not Terminated do begin
    try
      Run();
    except
      MainOutMessage(sExceptionMsg);
    end;
    Sleep(10);
  end;
end;

procedure TUserEMail.FreeInitialize;
var
  i, ii: Integer;
  EMailUserInfo: pTEMailUserInfo;
begin
  if FInitialize then begin
    for I := 0 to FNameList.Count - 1 do begin
      EMailUserInfo := pTEMailUserInfo(FNameList.Objects[I]);
      if EMailUserInfo <> nil then begin
        for ii := 0 to EMailUserInfo.EMailList.Count - 1 do begin
          Dispose(pTEMailListInfo(EMailUserInfo.EMailList[ii]));
        end;
        EMailUserInfo.EMailList.Free;
        Dispose(EMailUserInfo);
      end;
    end;
    FNameList.SaveToFile(g_Config.sEMailDir + DATALIST);
    FNameList.Clear;
  end;
  FInitialize := False;
  FFileStream.Free;
end;

function TUserEMail.GetMessage(Msg: pTEMailProcessMessage): Boolean;
var
  SendMessage: pTEMailSendMessage;
begin
  Result := False;
  Lock;
  Try
    if FMsgList.Count > 0 then begin
      SendMessage := FMsgList[0];
      FMsgList.Delete(0);
      Msg.wIdent := SendMessage.wIdent;
      Msg.nDBIndex := SendMessage.nDBIndex;
      Msg.nParam1 := SendMessage.nParam1;
      Msg.nParam2 := SendMessage.nParam2;
      Msg.nParam3 := SendMessage.nParam3;
      Msg.EMailInfo := SendMessage.EMailInfo;
      if SendMessage.Buff <> nil then begin
        Msg.sMsg := Strpas(SendMessage.Buff);
        FreeMem(SendMessage.Buff);
      end else begin
        Msg.sMsg := '';
      end;
      Result := True;
    end;
  Finally
    UnLock;
  End;
end;

function TUserEMail.GetWriteIndex: Integer;
begin
  if FDeleteList.Count > 0 then begin
    Result := Integer(FDeleteList[0]);
    FDeleteList.Delete(0);
  end else begin
    Result := FEMailCount;
    Inc(FEMailCount);
  end;
end;

function TUserEMail.Initialize: Integer;
var
  sDirName, sFileName, sBakFileName: string;
  EMailInfo: TEMailInfo;
  OldEMailInfo: TOldEMailInfo;
  nIndex: Integer;
  EMailListInfo: pTEMailListInfo;
  EMailUserInfo: pTEMailUserInfo;
  dTime: TDateTime;
  nDay: Integer;
  I: Integer;
  boCreateNew: Boolean;
  TempFileStream: TFileStream;
begin
  Result := 0;
  FEMailCount := 0;
  sDirName := g_Config.sEMailDir;
  if not DirectoryExists(sDirName) then begin
    CreateDir(sDirName);
  end;
  sFileName := sDirName + DATALIST;
  FNameList.Clear;
  if FileExists(sFileName) then begin
    FNameList.LoadFromFile(sFileName);
  end;
  if FNameList.IndexOf(SYSEMAILNAME) = -1 then
    FNameList.Add(SYSEMAILNAME);
  FNameList.SortString(0, FNameList.Count - 1);

  sFileName := sDirName + DATAFILE;
  boCreateNew := False;
  if FileExists(sFileName) then begin
    FFileStream := TFileStream.Create(sFileName, fmOpenReadWrite or fmShareDenyWrite);
    if FFileStream.Size mod SizeOf(EMailInfo) <> 0 then begin
      if FFileStream.Size mod SizeOf(OldEMailInfo) = 0 then
        boCreateNew := True;
      FFileStream.Free;
      sBakFileName := ExtractFilePath(sFileName) + FormatDateTime('YYYY-MM-DD-HH-MM-SS', Now) + '.bak'; 
      RenameFile(sFileName, sBakFileName);
      FFileStream := TFileStream.Create(sFileName, fmCreate);
      if boCreateNew then begin
        TempFileStream := TFileStream.Create(sBakFileName, fmOpenReadWrite or fmShareDenyWrite);
        Try
          while True do begin
            if FFileStream.Read(OldEMailInfo, SizeOf(OldEMailInfo)) = SizeOf(OldEMailInfo) then begin
              FillChar(EMailInfo, SizeOf(EMailInfo), #0);
              EMailInfo.boDelete := OldEMailInfo.boDelete;
              EMailInfo.Header := OldEMailInfo.Header;
              EMailInfo.sReadName := OldEMailInfo.sReadName;
              EMailInfo.nGold := OldEMailInfo.nGold;
              EMailInfo.TextLen := OldEMailInfo.TextLen;
              Move(EMailInfo.Text[0], OldEMailInfo.Text[0], SizeOf(OldEMailInfo.Text));
              EMailInfo.Item.wIndex := OldEMailInfo.Item.wIndex;
              EMailInfo.Item.MakeIndex := OldEMailInfo.Item.MakeIndex;
              EMailInfo.Item.Dura := OldEMailInfo.Item.Dura;
              EMailInfo.Item.DuraMax := OldEMailInfo.Item.DuraMax;
              EMailInfo.Item.btBindMode1 := OldEMailInfo.Item.btBindMode1;
              EMailInfo.Item.btBindMode2 := OldEMailInfo.Item.btBindMode2;
              EMailInfo.Item.TermTime := DateTimeToLongWord(OldEMailInfo.Item.TermTime);
              EMailInfo.Item.EffectValue := OldEMailInfo.Item.EffectValue;
              EMailInfo.Item.Value := OldEMailInfo.Item.Value;
              FFileStream.Write(EMailInfo, SizeOf(EMailInfo));
            end else break;
          end;
        Finally
          TempFileStream.Free;
          FFileStream.Free;
          FFileStream := nil;
        End;
        Result := Initialize;
        Exit;
      end;
    end else begin
      dTime := Now;
      while True do begin
        if FFileStream.Read(EMailInfo, SizeOf(EMailInfo)) = SizeOf(EMailInfo) then begin
          if (not EMailInfo.boDelete) and (EMailInfo.sReadName <> SYSEMAILNAME) then begin
            nDay := DaysBetween(dTime, EMailInfo.Header.CreateTime);
            if nDay >= MAXEMAILSAVEDAY then begin //超过最大保存期限，则删除
              EMailInfo.boDelete := True;
            end else
            if (EMailInfo.nGold = 0) and (EMailInfo.Item.MakeIndex = 0) then begin
              //普通文字信件直接删除，系统文字信件已读大于最短保存期限则删除，未读永久保存
              if (not EMailInfo.Header.boSystem) or (EMailInfo.Header.boRead and (nDay >= MAXEMAILSYSDAY)) then begin
                EMailInfo.boDelete := True;
              end;
            end;
          end;
          if not EMailInfo.boDelete then begin
            Inc(Result);
            nIndex := FNameList.GetIndex(EMailInfo.sReadName);
            if nIndex <> -1 then begin
              EMailUserInfo := pTEMailUserInfo(FNameList.Objects[nIndex]);
              if EMailUserInfo = nil then begin
                New(EMailUserInfo);
                EMailUserInfo.nDBIndex := -1;
                EMailUserInfo.EMailList := TList.Create;
                FNameList.Objects[nIndex] := TObject(EMailUserInfo);
              end;
              New(EMailListInfo);
              EMailListInfo.nIndex := FEMailCount;
              EMailListInfo.EMailInfo := EMailInfo.Header;
              EMailUserInfo.EMailList.Add(EMailListInfo);
            end else
              FDeleteList.Add(Pointer(FEMailCount));
          end else
            FDeleteList.Add(Pointer(FEMailCount));
          Inc(FEMailCount);
        end else
          break;
      end;
    end;
  end else
    FFileStream := TFileStream.Create(sFileName, fmCreate);

  for I := 0 to FNameList.Count - 1 do begin
    EMailUserInfo := pTEMailUserInfo(FNameList.Objects[i]);
    if EMailUserInfo = nil then begin
      New(EMailUserInfo);
      EMailUserInfo.nDBIndex := -1;
      EMailUserInfo.EMailList := TList.Create;
      FNameList.Objects[i] := TObject(EMailUserInfo);
    end;
  end;

  nIndex := FNameList.GetIndex(SYSEMAILNAME);
  if nIndex <> -1 then begin
    FSYSMailUserInfo := pTEMailUserInfo(FNameList.Objects[nIndex]);
  end;
  FInitialize := True;
  FSaveNameTick := GetTickCount;
end;

procedure TUserEMail.Lock;
begin
  EnterCriticalSection(FCriticalSection);
end;

function TUserEMail.MsgCount: Integer;
begin
  Lock;
  Try
    Result := FMsgList.Count;
  Finally
    UnLock;
  End;
end;

function TUserEMail.IsIdle: Boolean;
begin
  Result := False;
  Lock;
  try
    if FMsgList.Count = 0 then
      Result := True;
  finally
    UnLock;
  end;
end;

procedure TUserEMail.Run;
var
  Msg: TEMailProcessMessage;
begin
  while GetMessage(@Msg) do begin
    case Msg.wIdent of
      EMS_USERLOGIN: UserLogin(Msg.nDBIndex, Msg.sMsg);
      EMS_USERGHOST: UserGhost(Msg.nDBIndex, Msg.sMsg);
      EMS_ADDEMAIL: AddEMail(Msg.nDBIndex, Msg.EMailInfo);
      EMS_ADDALLEMAIL: AddAllEMail(Msg.EMailInfo);
      EMS_READEMAIL: ReadEMail(Msg.nDBIndex, Msg.nParam1, Msg.sMsg);
      EMS_GETGOLD: GetGold(Msg.nDBIndex, Msg.nParam1, Msg.sMsg);
      EMS_GETITEM: GetItem(Msg.nDBIndex, Msg.nParam1, Msg.sMsg);
      EMS_DELEMAIL: DeleteEMail(Msg.nDBIndex, Msg.nParam1, Msg.sMsg);
    end;
  end;
  if FInitialize and (GetTickCount > FSaveNameTick) then begin
    FSaveNameTick := GetTickCount + 60 * 1000;
    FNameList.SaveToFile(g_Config.sEMailDir + DATALIST);
  end;
end;

procedure TUserEMail.SendMsg(wIdent: Integer; nDBIndex, nParam1, nParam2, nParam3: Integer; sMsg: string; EMailInfo: pTEMailInfo);
var
  SendMessage: pTEMailSendMessage;
begin
  Lock;
  Try
    New(SendMessage);
    SendMessage.wIdent := wIdent;
    SendMessage.nDBIndex := nDBIndex;
    SendMessage.nParam1 := nParam1;
    SendMessage.nParam2 := nParam2;
    SendMessage.nParam3 := nParam3;
    SendMessage.EMailInfo := EMailInfo;
    if sMsg <> '' then begin
      try
        GetMem(SendMessage.Buff, Length(sMsg) + 1);
        Move(sMsg[1], SendMessage.Buff^, Length(sMsg) + 1);
      except
        SendMessage.Buff := nil;
      end;
    end
    else begin
      SendMessage.Buff := nil;
    end;
    FMsgList.Add(SendMessage);
  Finally
    UnLock;
  End;
end;

function TUserEMail.SendMail(const AUserName, AText, ATitle: string;
  AAll: Boolean): Boolean;
var
  EMailInfo: pTEMailInfo;
begin
  New(EMailInfo);
  SafeFillChar(EMailInfo^, SizeOf(TEMailInfo), #0);
  EMailInfo.boDelete := False;
  EMailInfo.Header.boRead := False;
  EMailInfo.Header.boSystem := True;
  EMailInfo.Header.sTitle := ATitle;
  EMailInfo.Header.sSendName := SYSEMAILNAME;
  EMailInfo.Header.CreateTime := Now;
  if AAll then
    EMailInfo.sReadName := ''
  else
    EMailInfo.sReadName := AUserName;
  EMailInfo.nGold := 0;
  EMailInfo.TextLen := _MIN(Length(AText), MAXEMAILTEXTLEN);
  Move(AText[1], EMailInfo.Text[0], EMailInfo.TextLen);
  if AAll then
    SendMsg(EMS_ADDALLEMAIL, -1, 0, 0, 0, '', EMailInfo)
  else
    SendMsg(EMS_ADDEMAIL, -1, 0, 0, 0, '', EMailInfo);
  Result := True;
end;

procedure TUserEMail.UnLock;
begin
  LeaveCriticalSection(FCriticalSection);
end;

function TUserEMail.UserCount: Integer;
begin
  FNameList.Lock;
  Try
    Result := FNameList.Count;
  Finally
    FNameList.UnLock;
  End;
end;

procedure TUserEMail.DeleteEMail(nDBIndex, nIndex: Integer; sChrName: string);
var
  nIDIndex, I: Integer;
  EMailUserInfo: pTEMailUserInfo;
  EMailListInfo: pTEMailListInfo;
  boDelete: Boolean;
begin
  FNameList.Lock;
  Try
    nIDIndex := FNameList.GetIndex(sChrName);
    boDelete := True;
    if nIDIndex <> -1 then begin
      EMailUserInfo := pTEMailUserInfo(FNameList.Objects[nIDIndex]);
      EMailUserInfo.nDBIndex := nDBIndex;
      for I := EMailUserInfo.EMailList.Count - 1 downto 0 do begin
        EMailListInfo := EMailUserInfo.EMailList[I];
        if nIndex > -1 then begin
          if EMailListInfo.nIndex = nIndex then begin
            WriteData(EMailListInfo.nIndex, PChar(@boDelete), 1);
            FDeleteList.Add(Pointer(EMailListInfo.nIndex));
            Dispose(EMailListInfo);
            EMailUserInfo.EMailList.Delete(I);
            exit;
          end;
        end else begin
          WriteData(EMailListInfo.nIndex, PChar(@boDelete), 1);
          FDeleteList.Add(Pointer(EMailListInfo.nIndex));
          Dispose(EMailListInfo);
        end;
      end;
      if nIndex = -1 then
        EMailUserInfo.EMailList.Clear;
    end;
  Finally
    FNameList.UnLock;
  End;
end;

procedure TUserEMail.GetItem(nDBIndex, nIndex: Integer; sChrName: string);
var
  nIDIndex, I: Integer;
  EMailUserInfo: pTEMailUserInfo;
  EMailListInfo: pTEMailListInfo;
  EMailInfo: TEMailInfo;
  PlayObject: TPlayObject;
  UserItem, AddUserItem: pTUserItem;
  Stditem: pTStdItem;
begin
  FNameList.Lock;
  Try
    nIDIndex := FNameList.GetIndex(sChrName);
    if nIDIndex <> -1 then begin
      EMailUserInfo := pTEMailUserInfo(FNameList.Objects[nIDIndex]);
      EMailUserInfo.nDBIndex := nDBIndex;
      for I := 0 to EMailUserInfo.EMailList.Count - 1 do begin
        EMailListInfo := EMailUserInfo.EMailList[I];
        if EMailListInfo.nIndex = nIndex then begin
          if ReadData(nIndex, PChar(@EMailInfo), SizeOf(EMailInfo)) = SizeOf(EMailInfo) then begin
            if EMailInfo.Item.MakeIndex <> 0 then begin
              EnterCriticalSection(ProcessHumanCriticalSection);
              Try
                PlayObject := GetLoginPlay(nDBIndex);
                if (PlayObject <> nil) and (not PlayObject.m_boGhost) then begin
                  Stditem := UserEngine.GetStdItem(EMailInfo.Item.wIndex);
                  if Stditem <> nil then begin
                    New(UserItem);
                    UserItem^ := EMailInfo.Item;
                    if PlayObject.AddItemToBag(UserItem, Stditem, False, '', '', AddUserItem) <> -1 then begin
                      if Stditem.NeedIdentify = 1 then
                        AddGameLog(PlayObject, LOG_ADDITEM, StdItem.Name, UserItem.MakeIndex, UserItem.Dura,
                          EMailInfo.Header.sSendName, '0', '0', '信件取回', UserItem);
                      EMailInfo.Item.MakeIndex := 0;
                      PlayObject.SendDefMsg(PlayObject, SM_EMAIL, nIndex, 0, 0, 5, '');
                    end else
                      Dispose(UserItem);
                  end;
                end;
              Finally
                LeaveCriticalSection(ProcessHumanCriticalSection);
              End;
              if EMailInfo.Item.MakeIndex = 0 then begin
                WriteData(nIndex, PChar(@EMailInfo), SizeOf(EMailInfo));
                exit;
              end;
            end;
          end;
          break;
        end;
      end;
    end;
    PlayObject := GetLoginPlay(nDBIndex);
    if (PlayObject <> nil) and (not PlayObject.m_boGhost) then begin
      PlayObject.SendDefMsg(PlayObject, SM_EMAIL, -1, 0, 0, 5, '');
    end;
  Finally
    FNameList.UnLock;
  End;
end;

procedure TUserEMail.GetGold(nDBIndex, nIndex: Integer; sChrName: string);
var
  nIDIndex, I: Integer;
  EMailUserInfo: pTEMailUserInfo;
  EMailListInfo: pTEMailListInfo;
  EMailInfo: TEMailInfo;
  PlayObject: TPlayObject;
begin
  FNameList.Lock;
  Try
    nIDIndex := FNameList.GetIndex(sChrName);
    if nIDIndex <> -1 then begin
      EMailUserInfo := pTEMailUserInfo(FNameList.Objects[nIDIndex]);
      EMailUserInfo.nDBIndex := nDBIndex;
      for I := 0 to EMailUserInfo.EMailList.Count - 1 do begin
        EMailListInfo := EMailUserInfo.EMailList[I];
        if EMailListInfo.nIndex = nIndex then begin
          if ReadData(nIndex, PChar(@EMailInfo), SizeOf(EMailInfo)) = SizeOf(EMailInfo) then begin
            if EMailInfo.nGold > 0 then begin
              EnterCriticalSection(ProcessHumanCriticalSection);
              Try
                PlayObject := GetLoginPlay(nDBIndex);
                if (PlayObject <> nil) and (not PlayObject.m_boGhost) then begin
                  if PlayObject.IncGold(EMailInfo.nGold) then begin
                    if g_boGameLogGold then begin
                      AddGameLog(PlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, PlayObject.m_nGold,
                        EMailInfo.Header.sSendName, '+', IntToStr(EMailInfo.nGold), '信件取回', nil);
                    end;
                    EMailInfo.nGold := 0;
                    PlayObject.SendDefMsg(PlayObject, SM_EMAIL, PlayObject.m_nGold, nIndex, 0, 4, '');
                  end;
                end;
              Finally
                LeaveCriticalSection(ProcessHumanCriticalSection);
              End;
              if EMailInfo.nGold = 0 then begin
                WriteData(nIndex, PChar(@EMailInfo), SizeOf(EMailInfo));
                exit;
              end;
            end;
          end;
          break;
        end;
      end;
    end;
    PlayObject := GetLoginPlay(nDBIndex);
    if (PlayObject <> nil) and (not PlayObject.m_boGhost) then begin
      PlayObject.SendDefMsg(PlayObject, SM_EMAIL, -1, 0, 0, 4, '');
    end;
  Finally
    FNameList.UnLock;
  End;
end;

procedure TUserEMail.ReadEMail(nDBIndex, nIndex: Integer; sChrName: string);
var
  nIDIndex, I: Integer;
  EMailUserInfo: pTEMailUserInfo;
  EMailListInfo: pTEMailListInfo;
  EMailInfo: TEMailInfo;
  sSendMsg: string;
  nGold: Integer;
  PlayObject: TPlayObject;
begin
  FNameList.Lock;
  Try
    sSendMsg := '';
    nGold := 0;
    nIDIndex := FNameList.GetIndex(sChrName);
    if nIDIndex <> -1 then begin
      EMailUserInfo := pTEMailUserInfo(FNameList.Objects[nIDIndex]);
      EMailUserInfo.nDBIndex := nDBIndex;
      for I := 0 to EMailUserInfo.EMailList.Count - 1 do begin
        EMailListInfo := EMailUserInfo.EMailList[I];
        if EMailListInfo.nIndex = nIndex then begin
          if ReadData(nIndex, PChar(@EMailInfo), SizeOf(EMailInfo)) = SizeOf(EMailInfo) then begin
            EMailInfo.Header.boRead := True;
            EMailListInfo.EMailInfo.boRead := True;
            WriteData(nIndex, PChar(@EMailInfo), 2);
            nGold := EMailInfo.nGold;
            if EMailInfo.Item.MakeIndex <> 0 then sSendMsg := UserEngine.MakeClientItem(@EMailInfo.Item) + '/'
            else sSendMsg := '/';
            sSendMsg := sSendMsg + EncodeBuffer(@EMailInfo.Text[0], EMailInfo.TextLen);
          end;
          break;
        end;
      end;
    end;
    PlayObject := GetLoginPlay(nDBIndex);
    Try
      if (PlayObject <> nil) and (not PlayObject.m_boGhost) then begin
        if sSendMsg <> '' then begin
          PlayObject.SendDefSocket(PlayObject, SM_EMAIL, nIndex, nGold, 0, 1, sSendMsg);
        end else
          PlayObject.SendDefMsg(PlayObject, SM_EMAIL, -1, 0, 0, 1, '');
      end;
    Except
      On E:Exception do begin
        MainOutMessage('[Exception] TUserEMail.ReadEMail.SendDefSocket');
        MainOutMessage(E.Message);
      end;
    End;
    
    //SendDefMsg(PlayObject, PlayObject, SM_EMAIL, -1, 0, 0, 1, '');
  Finally
    FNameList.UnLock;
  End;
end;

procedure TUserEMail.UserGhost(nDBIndex: Integer; sChrName: string);
var
  nIndex: Integer;
  EMailUserInfo: pTEMailUserInfo;
begin
  FNameList.Lock;
  Try
    nIndex := FNameList.GetIndex(sChrName);
    if nIndex <> -1 then begin
      EMailUserInfo := pTEMailUserInfo(FNameList.Objects[nIndex]);
      EMailUserInfo.nDBIndex := -1;
    end else begin
      New(EMailUserInfo);
      EMailUserInfo.nDBIndex := -1;
      EMailUserInfo.EMailList := TList.Create;
      FNameList.AddRecord(sChrName, Integer(EMailUserInfo));
    end;
  Finally
    FNameList.UnLock;
  End;
end;

procedure TUserEMail.UserLogin(nDBIndex: Integer; sChrName: string);
var
  nIndex, I: Integer;
  EMailListInfo: pTEMailListInfo;
  EMailUserInfo: pTEMailUserInfo;
  ClientEMailHeader: TClientEMailHeader;
  dTime: TDateTime;
  sSendMsg: string;
  PlayObject: TPlayObject;
begin
  FNameList.Lock;
  Try
    nIndex := FNameList.GetIndex(sChrName);
    if nIndex <> -1 then begin
      EMailUserInfo := pTEMailUserInfo(FNameList.Objects[nIndex]);
      EMailUserInfo.nDBIndex := nDBIndex;
      dTime := Now;
      sSendMsg := '';
      for I := 0 to EMailUserInfo.EMailList.Count - 1 do begin
        EMailListInfo := EMailUserInfo.EMailList[I];
        ClientEMailHeader.nIdx := EMailListInfo.nIndex;
        ClientEMailHeader.sTitle := EMailListInfo.EMailInfo.sTitle;
        ClientEMailHeader.boRead := EMailListInfo.EMailInfo.boRead;
        ClientEMailHeader.sSendName := EMailListInfo.EMailInfo.sSendName;
        ClientEMailHeader.boSystem := EMailListInfo.EMailInfo.boSystem;
        ClientEMailHeader.btTime := DaysBetween(dTime, EMailListInfo.EMailInfo.CreateTime);
        sSendMsg := sSendMsg + EncodeBuffer(@ClientEMailHeader, SizeOf(ClientEMailHeader)) + '/';
      end;
      if sSendMsg <> '' then begin
        PlayObject := GetLoginPlay(nDBIndex);
        Try
          if (PlayObject <> nil) and (not PlayObject.m_boGhost) then
            PlayObject.SendDefSocket(PlayObject, SM_EMAIL, 0, 0, 0, 0, sSendMsg);
        Except
          On E:Exception do begin
            MainOutMessage('[Exception] TUserEMail.UserLogin.SendDefSocket');
            MainOutMessage(E.Message);
          end;
        End;
      end;
    end else begin
      New(EMailUserInfo);
      EMailUserInfo.nDBIndex := nDBIndex;
      EMailUserInfo.EMailList := TList.Create;
      FNameList.AddRecord(sChrName, Integer(EMailUserInfo));
    end;
  Finally
    FNameList.UnLock;
  End;
end;

function TUserEMail.WriteData(nIndex: Integer; Buffer: PChar; nLen: Integer): Integer;
begin
  Result := 0;
  if nIndex < 0 then exit;
  FFileStream.Seek(nIndex * SizeOf(TEMailInfo), soFromBeginning);
  Result := FFileStream.Write(Buffer^, nLen);
end;

function TUserEMail.ReadData(nIndex: Integer; Buffer: PChar; nLen: Integer): Integer;
begin
  Result := 0;
  if nIndex < 0 then exit;
  FFileStream.Seek(nIndex * SizeOf(TEMailInfo), soFromBeginning);
  Result := FFileStream.Read(Buffer^, nLen);
end;

end.
