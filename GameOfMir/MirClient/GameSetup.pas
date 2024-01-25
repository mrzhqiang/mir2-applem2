unit GameSetup;

interface
uses
  Windows, Classes, SysUtils, StrUtils, Graphics, Grobal2;

const
  HELP_IMAGE_FORM = 660;
  HELP_IMAGE_ARMING = 661;
  
  OS_SHOWNAME = 0; //��ʾ��������
  OS_DURAHINT = 1; //�־þ���
  OS_SHOWMAPHINT = 2; //��ʾ��ͼ��ʶ
  OS_SHOWITEMNAME = 3; //Ctrl��ʾ��Ʒ����
  OS_AUTOPICKUPITEM = 4; //�Զ�����
  OS_EXEMPTSHIFT = 5; //��Shift��
  OS_GETEXPFILTRATE = 6; //����ֵ����
  OS_MOVEHPSHOW = 7; //�ƶ�ƮѪ��ʾ
  OS_HPPROTECT = 8; //Ѫ������
  OS_MPPROTECT = 9; //ħ��ֵ����
  OS_HPPROTECT2 = 10;// ����ҩƷ����
  OS_MPPROTECT2 = 11;// ����ҩƷħ��ֵ����
  OS_HPPROTECT3 = 12;// ���ᱣ��
  OS_HIDEAROUNDHUM = 13; //������Χ����
  OS_HIDEALLYHUM = 14; //������������
  OS_HIDEMAGICBEGIN = 15; //���ؼ��ܳ���Ч��
  OS_HIDEMAGICEND = 16; //���ؼ��ܹ���Ч��
  OS_AUTOLONGHIT = 17; //������ɱ
  OS_AUTOWIDEHIT = 18; //����Բ��
  OS_AUTOFIREHIT = 19; //�Զ��һ�
  OS_AUTOSHIELD = 20; //�Զ�����
  OS_AUTOCLOAK = 21; //�Զ�����
  OS_SHOWNAMEALL = 22;// ȫ����ʾ
  OS_SHOWNAMEMON = 23;// ��������
  OS_SNOWWINDLOCK = 24;// ����������
  OS_LONGWIND = 25;// �Զ���ɱ
  OS_AUTOLONGICEHIT = 26;// �Զ�����ն
  OS_FIERYDRAGONLOCK = 27;// ������������
  OS_UNIT_HPMP = 28;// ��λѪ��
//  OS_FIERYDRAGONLOCK = 29;// ������������
//  OS_FIERYDRAGONLOCK = 30;// ������������
//  OS_FIERYDRAGONLOCK = 32;// ������������
//  OS_FIERYDRAGONLOCK = 33;// ������������
//  OS_FIERYDRAGONLOCK = 34;// ������������

  OS_ISSETUP = 31;

  DK_CHANGEMINMAP = 0;
  DK_CHANGEATTACKMODE = 1;
  DK_SLAVEREST = 2;
  DK_PRINTSCREEN = 3; //��ͼ
  DK_APPLOGOUT = 4;
  DK_APPEXIT = 5;
  DK_CREATEGROUP = 6;
  DK_DELGROUPMEMBER = 7;
  DK_ADDTOUSERLIST = 8;
  DK_QUERYBAGITEMS = 9;
  DK_OPENITEMBAG = 10;
  DK_OPENMYSTATUS0 = 11;
  DK_OPENMYSTATUS3 = 12;
  DK_OPENGAMESETUP = 13;
  DK_ONHORSE = 14;

  DK_MAXHOOKKEYCOUNT = 14;

  DG_SAVEDIR = '.\Config\';
  DG_FORMATSTR = '%s\%s\%s\';
  //DG_FILTERITEMNAME = 'Filter.dat';
  //FriendListFile = 'FriendList.txt';
  BagItemsFile = '%s_BagItems.dat';
  BlackListFile = 'BlackList.txt';
  NotepaperFile = 'Notepaper.txt';
  CustomKeyFile = 'CustomKey.ini';
  ItemRuleFile = 'ItemsRule.txt';
  ShiftName = 'ShiftState';
  KeyName = 'Key';

type
  TKeyInfo = record
    Shift: TShiftState;
    Key: Word;
  end;
  pTKeyInfo = ^TKeyInfo;

  TDefKeyInfo = record
    DefKey: TKeyInfo;
    CustomKey: TKeyInfo;
    boLoginGame: Boolean;
    KeyHint: string;
  end;
  pTDefKeyInfo = ^TDefKeyInfo;

  TSetupInfo = packed record
    boCustomKey: Boolean; //�����Զ����ݼ�
    boShowName: Boolean; //��ʾ��������
    boShowNameAll: Boolean;  //ȫ����ʾ
    boShowNameMon: Boolean;  //��������
    boDuraHint: Boolean; //�־þ���
    boShowMapHint: Boolean; //��ʾ��ͼ��ʶ
    boShowItemName: Boolean; //Ctrl��ʾ��Ʒ����
    boAutoPickUpItem: Boolean; //�Զ�����
    boExemptShift: Boolean; //��Shift��
    boGetExpFiltrate: Boolean; //����ֵ����
    nExpFiltrateCount: Word; //�����������
    boMoveHpShow: Boolean; //�ƶ�ƮѪ��ʾ
    boHpProtect: Boolean; //Ѫ������
    nHpProtectCount: Word;
    dwHpProtectTime: Byte;
    boMpProtect: Boolean; //ħ��ֵ����
    nMpProtectCount: Word;
    dwMpProtectTime: Byte;
    boHpProtect2: Boolean; //����ҩƷ����
    nHpProtectCount2: Word;
    dwHpProtectTime2: Byte;
    boMpProtect2: Boolean; //����ҩƷħ��ֵ����
    nMpProtectCount2: Word;
    dwMpProtectTime2: Byte;
    boHpProtect3: Boolean; //���ᱣ��
    nHpProtectCount3: Word;
    dwHpProtectTime3: Byte;
    btHpProtectIdx: Byte;
    boHideAroundHum: Boolean; //������Χ����
    boHideAllyHum: Boolean; //������������
    boHideMagicBegin: Boolean; //���ؼ��ܳ���Ч��
    boHideMagicEnd: Boolean; //���ؼ��ܹ���Ч��
    boAutoLongHit: Boolean; //������ɱ
    boAutoWideHit: Boolean; //����Բ��
    boAutoFireHit: Boolean; //�Զ��һ�
    boAutoLongIceHit: Boolean; //�Զ�����ն
    boAutoShield: Boolean; //�Զ�����
    boAutoCloak: Boolean; //�Զ�����
    boSnowWindLock: Boolean; //����������
    boFieryDragonLock: Boolean; //������������

    boAutoMagic: Boolean; //�Զ�����
    dwAutoMagicTick: LongWord;
    nAutoMagicIndex: Integer;
    boAutoLongWide: Boolean;

    boUnitHpMp: Boolean;// ��λѪ��

  end;

var
  g_nGameSetupData: LongWord;
  g_boCanSound: Boolean = True;
  g_boChangeWindow: Boolean = False;
  g_boSaveIDInfo: Boolean = False;
  g_dwDefTime: LongWord;
  g_boSaveUserInfo: Boolean = False;
  g_boBagItemsRead: Boolean = False;
  g_boCtrlDown: Boolean = False;
  g_boLeapDown: Boolean = False;
  g_boShiftOpen: Boolean = False;
  g_boShiftUp: Boolean = True;
  g_boWgVisible: Boolean = False;
  g_BagCheckTick: LongWord = 0;
  g_CustomKey: array[0..DK_MAXHOOKKEYCOUNT] of TDefKeyInfo;
  g_ClientConf: TClientConf;
  g_MyBlacklist: TStringList;
  g_MyWhisperList: TStringList;
  g_FBTime: Integer = -1;
  g_FBExitTime: Integer = -1;
  g_FBFailTime: Integer = -1;
  g_sFBTime: string;
  g_sFBExitTime: string;
  g_sFBFailTime: string;
  //g_ItemFiltrateList: TList;
  g_boQueryExit: Boolean = False;
  g_WayTag: array[0..7] of string[2] = ('��', '�J', '��', '�K', '��',
    '�L', '��', '�I');

  g_dwDropItemFlashTime: LongWord = 3 * 1000; //������Ʒ��ʱ����

  g_dwAutoPickupTick: LongWord = 0; //�Զ�������ʱ��
  g_dwAutoPickupTime: LongWord = 500; //�Զ�������

  g_dwDuraAlertTick: LongWord = 0; //�־þ�����ʱ��
  g_dwDuraAlertTime: LongWord = 60 * 1000; //�־þ�����ʱ��
  g_dwHpProtectTime3: LongWord = 0; //�سǱ���ʱ��
  g_dwHpProtectTime2: LongWord = 0; //����ҩƷ����ʱ��
  g_dwHpProtectTime: LongWord = 0; //HP����
  g_dwMpProtectTime2: LongWord = 0; //MP����
  g_dwMpProtectTime: LongWord = 0; //MP����
  g_dwAutoMagicTime: LongWord = 0; //�Զ�����

  g_dwHpProtectTick3: LongWord = 0;
  g_dwHpProtectTick2: LongWord = 0;
  g_dwHpProtectTick: LongWord = 0;
  g_dwMpProtectTick2: LongWord = 0;
  g_dwMpProtectTick: LongWord = 0;
  g_sOpenItemName: string = '';
  g_boShowFormImage: Boolean = False;
  g_boShowFormIndex: Integer;

  g_SetupInfo: TSetupInfo;
  s9: string[20] = 'OWpRi3nZ';
  s10: string[20] = 'OKnAWOgcGRXk';

function InBlacklist(sName: string): Boolean;
procedure LoadIDInfo();
procedure SaveIDInfo();
procedure LoadHumInfo(UserName: string);
procedure SaveHumInfo(UserName: string);
procedure SetDefKeyInfo();
function OpenKeyInfo(KeyIndex: Integer): Boolean;
procedure SetDefaultSetupInfo;
procedure SendGameSetupInfo;
procedure GetGameSetupInfo(Msg: pTDefaultMessage; sBody: string);
procedure ShowInterface(boShow: Boolean);
procedure ShowArmingHint(boShow: Boolean);
//procedure ClearItemRule();
function GetHookKeyStr(DefKeyInfo: pTDefKeyInfo): string;
function RefHookKeyStr(FShiftState: TShiftState; FKey: Word): string;
function CheckBlockListSys(Ident: Integer; sMsg: string; var UserName: string): Boolean;
function ExecuteScript(sScript: string): Boolean;

implementation
uses
  MShare, ClMain, FState, FState3, IniFiles, HUtil32, EDcodeEx, MNShare;


procedure ShowInterface(boShow: Boolean);
begin
  g_boShowFormImage := boShow;
  g_boShowFormIndex := HELP_IMAGE_FORM;
end;

procedure ShowArmingHint(boShow: Boolean);
begin
  g_boShowFormImage := boShow;
  g_boShowFormIndex := HELP_IMAGE_ARMING;
end;

procedure LoadHumInfo(UserName: string);
  procedure LoadBagItems(sFileName: string);
  var
    FileStream: TFileStream;
  begin
    SafeFillChar(g_TempItemArr, SizeOf(g_TempItemArr), #0);
    if FileExists(sFileName) then begin
      FileStream := TFileStream.Create(sFileName, fmOpenRead or fmShareDenyNone);
      try
        if FileStream.Size = SizeOf(g_TempItemArr) then
          FileStream.Read(g_TempItemArr, SizeOf(g_TempItemArr));
      finally
        FileStream.Free;
      end;
    end;
  end;
var
  sDirname: string;
begin
  if g_boSaveUserInfo then
    Exit;
  g_boSaveUserInfo := True;
  g_MyShopTitle := UserName + '��̯λ';
  sDirname := Format(DG_FORMATSTR, [DG_SAVEDIR, g_sServerMiniName, LoginScene.m_sLoginId]);
  LoadBagItems(sDirname + Format(BagItemsFile, [UserName]));
end;

procedure SaveHumInfo(UserName: string);
  procedure SaveBagItems(sFileName: string);
  var
    FileStream: TFileStream;
  begin
    if g_boBagItemsRead then begin
      DeleteFile(sFileName);
      FileStream := TFileStream.Create(sFileName, fmCreate);
      try
        FileStream.Write(g_ItemArr, SizeOf(g_ItemArr));
      finally
        FileStream.Free;
      end;
    end;
  end;
var
  sDirname: string;
begin
  if not g_boSaveUserInfo then
    Exit;
  g_boSaveUserInfo := False;
  if not DirectoryExists(DG_SAVEDIR) then
    CreateDir(DG_SAVEDIR);
  sDirname := DG_SAVEDIR + g_sServerMiniName + '\';
  if not DirectoryExists(sDirname) then
    CreateDir(sDirname);
  sDirname := sDirname + LoginScene.m_sLoginId + '\';
  if not DirectoryExists(sDirname) then
    CreateDir(sDirname);

  SaveBagItems(sDirname + Format(BagItemsFile, [UserName]));
end;

//����������Ϣ

procedure SaveIDInfo();

  procedure SaveKeyInfo(sFileName: string);
  var
    i: Integer;
    Ini: TINIfile;
  begin
    Ini := TIniFile.Create(sFileName);
    try
      for i := Low(g_CustomKey) to High(g_CustomKey) do begin
        Ini.WriteInteger(ShiftName, g_CustomKey[i].KeyHint,
          Byte(g_CustomKey[i].CustomKey.Shift));
        Ini.WriteInteger(KeyName, g_CustomKey[i].KeyHint,
          g_CustomKey[i].CustomKey.Key);
      end;
    finally
      Ini.Free;
    end;
  end;

  procedure SaveItemRule(sFileName: string);
  var
    i: Integer;
    ClientStdItem: pTClientStditem;
    SaveList: TStringList;
    str: string;
  begin
    SaveList := TStringList.Create;
    for i := 0 to g_StditemList.Count - 1 do begin
      ClientStdItem := g_StditemList[i];
      if ClientStdItem.Filtrate.boChange then begin
        str := ClientStdItem.StdItem.Name + #9;
        str := str + IntToStr(Integer(ClientStdItem.Filtrate.boShow)) + #9;
        str := str + IntToStr(Integer(ClientStdItem.Filtrate.boPickUp)) + #9;
        str := str + IntToStr(Integer(ClientStdItem.Filtrate.boColor)) + #9;
        str := str + IntToStr(Integer(ClientStdItem.Filtrate.boHint)) + #9;
        SaveList.Add(str);
      end;
    end;
    SaveList.SaveToFile(sFileName);
    SaveList.Free;
  end;

var
  sDirname, sFileName: string;
begin
  if not g_boSaveIDInfo then
    Exit;
  g_boSaveIDInfo := False;
  if not DirectoryExists(DG_SAVEDIR) then
    CreateDir(DG_SAVEDIR);
  sDirname := DG_SAVEDIR + g_sServerMiniName + '\';
  if not DirectoryExists(sDirname) then
    CreateDir(sDirname);
  sDirname := sDirname + LoginScene.m_sLoginId + '\';
  if not DirectoryExists(sDirname) then
    CreateDir(sDirname);

  //sFileName := sDirname + FriendListFile;
  //g_MyFriendList.SaveToFile(sFileName);
  sFileName := sDirname + BlackListFile;
  g_MyBlacklist.SaveToFile(sFileName);
  sFileName := sDirname + NotepaperFile;
  //FrmDlg.DMemoNotepaper.Lines.SaveToFile(sFileName);

  //SaveKeyInfo(sDirname + CustomKeyFile); //�����Զ����ݼ���Ϣ
  //SaveItemRule(sDirname + ItemRuleFile); //������Ʒ������Ϣ

  //ClearItemRule();
end;

//����������Ϣ

procedure LoadIDInfo();
  procedure LoadKeyInfo(sFileName: string);
  var
    i: Integer;
    Ini: TINIfile;
  begin
    if FileExists(sFileName) then begin
      Ini := TIniFile.Create(sFileName);
      try
        for i := Low(g_CustomKey) to High(g_CustomKey) do begin
          g_CustomKey[i].CustomKey.Shift :=
            TShiftState(Byte(Ini.ReadInteger(ShiftName, g_CustomKey[i].KeyHint,
            0)));
          g_CustomKey[i].CustomKey.Key := Ini.ReadInteger(KeyName,
            g_CustomKey[i].KeyHint, 0);
        end;
      finally
        Ini.Free;
      end;
    end;
  end;

  procedure LoadItemRule(sFileName: string);
  var
    SaveList: TStringList;
    i: Integer;
    str: string;
    sShow: string;
    sPickUp: string;
    sColor: string;
    sHint: string;
    sname: string;
    Filtrate: TClientItemFiltrate;
  begin
    if FileExists(sFileName) then begin
      SaveList := TStringList.Create;
      try
        SaveList.LoadFromFile(sFileName);
        for i := 0 to SaveList.Count - 1 do begin
          str := SaveList[i];
          str := GetValidStr3(str, sname, [' ', #9]);
          str := GetValidStr3(str, sShow, [' ', #9]);
          str := GetValidStr3(str, sPickUp, [' ', #9]);
          str := GetValidStr3(str, sColor, [' ', #9]);
          str := GetValidStr3(str, sHint, [' ', #9]);
          Filtrate.boShow := sShow = '1';
          Filtrate.boPickUp := sPickUp = '1';
          Filtrate.boColor := sColor = '1';
          Filtrate.boHint := sHint = '1';
          Filtrate.boChange := True;
          SetStditemFiltrate(sname, @Filtrate);
        end;
      finally
        SaveList.Free;
      end;
    end;
  end;

var
  sDirname, sFileName: string;
begin
  if g_boSaveIDInfo then
    exit;
  g_boSaveIDInfo := True;
  sDirname := Format(DG_FORMATSTR, [DG_SAVEDIR, g_sServerMiniName, LoginScene.m_sLoginId]);

  g_SetupInfo.boAutoMagic := False;
  SetDefKeyInfo();
  //ClearItemRule();
  //sFileName := sDirname + FriendListFile;
  //if FileExists(sFileName) then g_MyFriendList.LoadFromFile(sFileName);
  sFileName := sDirname + blackListFile;
  if FileExists(sFileName) then
    g_MyBlacklist.LoadFromFile(sFileName);
  sFileName := sDirname + NotepaperFile;
  //if FileExists(sFileName) then
    //FrmDlg.DMemoNotepaper.Lines.LoadFromFile(sFileName);

  //LoadKeyInfo(sDirname + CustomKeyFile); //�����Զ����ݼ���Ϣ
  //LoadItemRule(sDirname + ItemRuleFile); //������Ʒ������Ϣ
end;
{
procedure ClearItemRule();
var
i: Integer;
begin
for i := 0 to g_ItemFiltrateList.Count - 1 do
 Dispose(pTClientItemFiltrate(g_ItemFiltrateList[i]));
g_ItemFiltrateList.Clear;
end;       }

function InBlacklist(sName: string): Boolean;
var
  i: integer;
begin
  Result := False;
  for I := 0 to g_MyBlacklist.Count - 1 do begin
    if CompareText(sName, g_MyBlacklist[i]) = 0 then begin
      Result := True;
      break;
    end;
  end;
end;

function OpenKeyInfo(KeyIndex: Integer): Boolean;
var
  idx: Integer;
  GroupMember: pTGroupMember;
begin
  Result := True;
  case KeyIndex of
    DK_CHANGEATTACKMODE: begin
        frmMain.SendSay('@AttackMode');
      end;
    DK_CHANGEMINMAP: begin
{$IF Var_Interface = Var_Mir2}
        FrmDlg.DBotMiniMapClick(FrmDlg.DBotMiniMap, 0, 0);
{$ELSE}
        FrmDlg.DMiniMapMaxClick(FrmDlg.DMiniMapMax, 0, 0);
{$IFEND}

      end;
    DK_PRINTSCREEN: begin
        frmMain.PrintScreenNow();
      end;
    DK_OPENITEMBAG: begin
        FrmDlg.OpenItemBag;
      end;
    DK_OPENMYSTATUS0: begin
        FrmDlg.StatePage := 0;
        FrmDlg.OpenMyStatus;
      end;
    DK_OPENMYSTATUS3: begin
        FrmDlg.StatePage := 2;
        FrmDlg.OpenMyStatus;
      end;
    DK_SLAVEREST: begin
        frmMain.SendSay('@Rest');
      end;
    DK_APPLOGOUT: begin
        frmMain.AppLogout;
      end;
    DK_APPEXIT: begin
        frmMain.AppExit;
      end;
    {DK_QUERYBAGITEMS: begin
        if (GetTickCount > m_CheckTick) then begin
          m_CheckTick := GetTickCount + 60 * 1000;
          frmMain.SendClientMessage(CM_QUERYBAGITEMS, 0, 0, 0, 0);
        end
        else
          DScreen.AddSysMsg('���Ժ���ʹ�øù���.', $32F4);
        //frmMain.SendQueryBagItems;
      end;  }
    DK_OPENGAMESETUP: begin
        FrmDlg3.DGameSetup.Visible := not FrmDlg3.DGameSetup.Visible;
      end;
    DK_ADDTOUSERLIST: begin
        if (g_FocusCret <> nil) and (g_FocusCret <> g_MySelf) and
          (g_FocusCret.m_btRace = 0) then begin
          idx := g_MyBlacklist.IndexOf(g_FocusCret.m_UserName);
          if idx = -1 then begin
            g_MyBlacklist.Add(g_FocusCret.m_UserName);
            DScreen.AddSysMsg(g_FocusCret.m_UserName + ' ���������', clWhite);
          end else begin
            g_MyBlacklist.Delete(idx);
            DScreen.AddSysMsg(g_FocusCret.m_UserName + ' �Ƴ�������', clWhite);
          end;
        end;
      end;
    DK_CREATEGROUP: begin
        if (g_FocusCret <> nil) and (g_FocusCret <> g_MySelf) and
          (g_FocusCret.m_btRace = 0) then begin
          g_dwChangeGroupModeTick := GetTickCount + 2000;
          if g_GroupMembers.Count <= 0 then begin
            frmMain.SendCreateGroup(Integer(g_GroupItemMode), g_FocusCret.m_UserName);
          end
          else begin
            GroupMember := g_GroupMembers[0];
            if GroupMember.ClientGroup.UserName = g_MySelf.m_UserName then begin
              frmMain.SendAddGroupMember(g_FocusCret.m_UserName);
            end;
          end;
        end;
      end;
    DK_DELGROUPMEMBER: begin
        if (g_FocusCret <> nil) and (g_FocusCret <> g_MySelf) and
          (g_FocusCret.m_btRace = 0) then begin
          g_dwChangeGroupModeTick := GetTickCount + 2000;
          if g_GroupMembers.Count > 0 then begin
            GroupMember := g_GroupMembers[0];
            if GroupMember.ClientGroup.UserName = g_MySelf.m_UserName then begin
              frmMain.SendDelGroupMember(g_FocusCret.m_UserName);
            end;
          end;
        end;
      end;
    DK_ONHORSE: begin
        with FrmDlg.DBTTakeHorse do begin
          if GetTickCount < AppendTick then
            exit;
          AppendTick := GetTickCount + 2000;
          if g_MySelf.m_btHorse = 0 then begin
            frmMain.SendSay(g_Cmd_TakeOnHorse);
          end
          else begin
            frmMain.SendSay(g_Cmd_TakeOffHorse);
          end;
        end;
      end
    else Result := False;
  end;
end;

procedure SetDefKeyInfo();
begin
  SafeFillChar(g_CustomKey, SizeOf(g_CustomKey), #0);

  g_CustomKey[DK_CHANGEATTACKMODE].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_CHANGEATTACKMODE].DefKey.Key := Word('H');
  g_CustomKey[DK_CHANGEATTACKMODE].boLoginGame := True;
  g_CustomKey[DK_CHANGEATTACKMODE].KeyHint := '�л�����ģʽ';

  g_CustomKey[DK_CHANGEMINMAP].DefKey.Shift := [];
  g_CustomKey[DK_CHANGEMINMAP].DefKey.Key := VK_TAB;
  g_CustomKey[DK_CHANGEMINMAP].boLoginGame := True;
  g_CustomKey[DK_CHANGEMINMAP].KeyHint := 'ȫ����ͼ';

  g_CustomKey[DK_PRINTSCREEN].DefKey.Shift := [];
  g_CustomKey[DK_PRINTSCREEN].DefKey.Key := VK_PAUSE;
  g_CustomKey[DK_PRINTSCREEN].boLoginGame := False;
  g_CustomKey[DK_PRINTSCREEN].KeyHint := '��Ϸ��ͼ';

  {g_CustomKey[DK_PRINTSCREEN].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_PRINTSCREEN].DefKey.Key := Word('O');
  g_CustomKey[DK_PRINTSCREEN].boLoginGame := False;
  g_CustomKey[DK_PRINTSCREEN].KeyHint := '��Ϸ��ͼ';  }

  g_CustomKey[DK_OPENITEMBAG].DefKey.Shift := [];
  g_CustomKey[DK_OPENITEMBAG].DefKey.Key := {$IF Var_Interface = Var_Default}VK_F10{$ELSE}VK_F9{$IFEND};
  g_CustomKey[DK_OPENITEMBAG].boLoginGame := True;
  g_CustomKey[DK_OPENITEMBAG].KeyHint := '���ﱳ��';

  g_CustomKey[DK_OPENMYSTATUS0].DefKey.Shift := [];
  g_CustomKey[DK_OPENMYSTATUS0].DefKey.Key := {$IF Var_Interface = Var_Default}VK_F9{$ELSE}VK_F10{$IFEND};
  g_CustomKey[DK_OPENMYSTATUS0].boLoginGame := True;
  g_CustomKey[DK_OPENMYSTATUS0].KeyHint := '����״̬';

  g_CustomKey[DK_OPENMYSTATUS3].DefKey.Shift := [];
  g_CustomKey[DK_OPENMYSTATUS3].DefKey.Key := VK_F11;
  g_CustomKey[DK_OPENMYSTATUS3].boLoginGame := True;
  g_CustomKey[DK_OPENMYSTATUS3].KeyHint := '���＼��';

  g_CustomKey[DK_SLAVEREST].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_SLAVEREST].DefKey.Key := Word('A');
  g_CustomKey[DK_SLAVEREST].boLoginGame := True;
  g_CustomKey[DK_SLAVEREST].KeyHint := '�ı�����״̬';

  g_CustomKey[DK_APPLOGOUT].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_APPLOGOUT].DefKey.Key := Word('X');
  g_CustomKey[DK_APPLOGOUT].boLoginGame := True;
  g_CustomKey[DK_APPLOGOUT].KeyHint := '�л�����';

  g_CustomKey[DK_APPEXIT].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_APPEXIT].DefKey.Key := Word('Q');
  g_CustomKey[DK_APPEXIT].boLoginGame := True;
  g_CustomKey[DK_APPEXIT].KeyHint := '�˳���Ϸ';

  g_CustomKey[DK_QUERYBAGITEMS].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_QUERYBAGITEMS].DefKey.Key := Word('R');
  g_CustomKey[DK_QUERYBAGITEMS].boLoginGame := True;
  g_CustomKey[DK_QUERYBAGITEMS].KeyHint := 'ˢ�±�����Ʒ';

  g_CustomKey[DK_OPENGAMESETUP].DefKey.Shift := [];
  g_CustomKey[DK_OPENGAMESETUP].DefKey.Key := VK_F12;
  g_CustomKey[DK_OPENGAMESETUP].boLoginGame := True;
  g_CustomKey[DK_OPENGAMESETUP].KeyHint := '��Ϸ����';

  g_CustomKey[DK_ADDTOUSERLIST].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_ADDTOUSERLIST].DefKey.Key := Word('S');
  g_CustomKey[DK_ADDTOUSERLIST].boLoginGame := True;
  g_CustomKey[DK_ADDTOUSERLIST].KeyHint := '����/ɾ��������';

  g_CustomKey[DK_CREATEGROUP].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_CREATEGROUP].DefKey.Key := Word('W');
  g_CustomKey[DK_CREATEGROUP].boLoginGame := True;
  g_CustomKey[DK_CREATEGROUP].KeyHint := '����/�������';

  g_CustomKey[DK_DELGROUPMEMBER].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_DELGROUPMEMBER].DefKey.Key := Word('E');
  g_CustomKey[DK_DELGROUPMEMBER].boLoginGame := True;
  g_CustomKey[DK_DELGROUPMEMBER].KeyHint := 'ɾ����Ա';

  g_CustomKey[DK_ONHORSE].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_ONHORSE].DefKey.Key := Word('J');
  g_CustomKey[DK_ONHORSE].boLoginGame := True;
  g_CustomKey[DK_ONHORSE].KeyHint := '��������';



end;

function GetHookKeyStr(DefKeyInfo: pTDefKeyInfo): string;
begin
  if (not g_SetupInfo.boCustomKey) or ((DefKeyInfo.CustomKey.Shift = []) and
    (DefKeyInfo.CustomKey.Key = 0)) then begin
    Result := RefHookKeyStr(DefKeyInfo.DefKey.Shift, DefKeyInfo.DefKey.Key);
  end
  else
    Result := RefHookKeyStr(DefKeyInfo.CustomKey.Shift,
      DefKeyInfo.CustomKey.Key);
end;

function RefHookKeyStr(FShiftState: TShiftState; FKey: Word): string;
var
  ShowStr: string;
begin
  ShowStr := '';
  if ssCtrl in FShiftState then
    ShowStr := 'Ctrl';

  if ssAlt in FShiftState then
    if ShowStr <> '' then
      ShowStr := ShowStr + '+Alt'
    else
      ShowStr := 'Alt';

  if ssShift in FShiftState then
    if ShowStr <> '' then
      ShowStr := ShowStr + '+Shift'
    else
      ShowStr := 'Shift';

  case FKey of
    VK_F1: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F1'
        else
          ShowStr := 'F1';
      end;
    VK_F2: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F2'
        else
          ShowStr := 'F2';
      end;
    VK_F3: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F3'
        else
          ShowStr := 'F3';
      end;
    VK_F4: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F4'
        else
          ShowStr := 'F4';
      end;
    VK_F5: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F5'
        else
          ShowStr := 'F5';
      end;
    VK_F6: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F6'
        else
          ShowStr := 'F6';
      end;
    VK_F7: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F7'
        else
          ShowStr := 'F7';
      end;
    VK_F8: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F8'
        else
          ShowStr := 'F8';
      end;
    VK_F9: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F9'
        else
          ShowStr := 'F9';
      end;
    VK_F10: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F10'
        else
          ShowStr := 'F10';
      end;
    VK_F11: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F11'
        else
          ShowStr := 'F11';
      end;
    VK_F12: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F12'
        else
          ShowStr := 'F12';
      end;
    VK_TAB: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Tab'
        else
          ShowStr := 'Tab';
      end;
    VK_PAUSE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Pause'
        else
          ShowStr := 'Pause';
      end;
    VK_HOME: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Home'
        else
          ShowStr := 'Home';
      end;
    VK_LEFT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Left'
        else
          ShowStr := 'Left';
      end;
    VK_UP: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Up'
        else
          ShowStr := 'Up';
      end;
    VK_RIGHT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Right'
        else
          ShowStr := 'Right';
      end;
    VK_DOWN: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Down'
        else
          ShowStr := 'Down';
      end;
    VK_SPACE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Space'
        else
          ShowStr := 'Space';
      end;
    VK_CAPITAL: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+CapsLock'
        else
          ShowStr := 'CapsLock';
      end;
    VK_ESCAPE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Esc'
        else
          ShowStr := 'Esc';
      end;
    VK_BACK: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Back'
        else
          ShowStr := 'Back';
      end;
    VK_PRIOR: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Prior'
        else
          ShowStr := 'Prior';
      end;
    VK_NEXT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Next'
        else
          ShowStr := 'Next';
      end;
    VK_END: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+End'
        else
          ShowStr := 'End';
      end;
    VK_SELECT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Select'
        else
          ShowStr := 'Select';
      end;
    VK_PRINT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Print'
        else
          ShowStr := 'Print';
      end;
    VK_EXECUTE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Execute'
        else
          ShowStr := 'Execute';
      end;
    VK_SNAPSHOT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Snapshot'
        else
          ShowStr := 'Snapshot';
      end;
    VK_INSERT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Insert'
        else
          ShowStr := 'Insert';
      end;
    VK_DELETE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Delete'
        else
          ShowStr := 'Delete';
      end;
    VK_HELP: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Help'
        else
          ShowStr := 'Help';
      end;
    VK_SHIFT,
      VK_CONTROL,
      VK_MENU: begin

      end
  else begin
      if ShowStr <> '' then
        ShowStr := ShowStr + '+' + Char(FKey)
      else
        ShowStr := Char(FKey);
    end;
  end;

  Result := ShowStr;
end;

function CheckBlockListSys(Ident: Integer; sMsg: string; var UserName: string):
  Boolean;
begin
  Result := True;
  UserName := '';
  case Ident of
    SM_HEAR,
      SM_GROUPMESSAGE,
      SM_GUILDMESSAGE: begin
        GetValidStr3(sMsg, UserName, [':']);
      end;
    SM_CRY: begin
        GetValidStr3(sMsg, UserName, [':']);
        UserName := RightStr(UserName, Length(UserName) - 3);
      end;
    SM_WHISPER: GetValidStr3(sMsg, UserName, ['=']);
  end;
  if UserName <> '' then begin
    if (g_MyBlacklist.IndexOf(UserName) > -1) then
      Result := False;
  end;
end;

procedure SendGameSetupInfo;
var
  UserOptionSetup: TUserOptionSetup;
  UserItemsSetup: TUserItemsSetup;
  ClientStditem: pTClientStditem;
  ClientItemFiltrate: pTClientItemFiltrate;
  I: Integer;
  nChangeCount: Integer;
begin
  SafeFillChar(UserOptionSetup, SizeOf(UserOptionSetup), #0);
  SafeFillChar(UserItemsSetup, SizeOf(UserItemsSetup), #0);

  SetIntStatus(UserOptionSetup.nOptionSetup, OS_ISSETUP, True);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAME, g_SetupInfo.boShowName);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAMEALL, g_SetupInfo.boShowNameAll);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAMEMON, g_SetupInfo.boShowNameMon);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_DURAHINT, g_SetupInfo.boDuraHint);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWMAPHINT, g_SetupInfo.boShowMapHint);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWITEMNAME, g_SetupInfo.boShowItemName);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOPICKUPITEM, g_SetupInfo.boAutoPickUpItem);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_EXEMPTSHIFT, g_SetupInfo.boExemptShift);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_GETEXPFILTRATE, g_SetupInfo.boGetExpFiltrate);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_MOVEHPSHOW, g_SetupInfo.boMoveHpShow);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT, g_SetupInfo.boHpProtect);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_MPPROTECT, g_SetupInfo.boMpProtect);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT2, g_SetupInfo.boHpProtect2);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_MPPROTECT2, g_SetupInfo.boMpProtect2);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT3, g_SetupInfo.boHpProtect3);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEAROUNDHUM, g_SetupInfo.boHideAroundHum);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEALLYHUM, g_SetupInfo.boHideAllyHum);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEMAGICBEGIN, g_SetupInfo.boHideMagicBegin);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEMAGICEND, g_SetupInfo.boHideMagicEnd);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOLONGHIT, g_SetupInfo.boAutoLongHit);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOWIDEHIT, g_SetupInfo.boAutoWideHit);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOFIREHIT, g_SetupInfo.boAutoFireHit);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOSHIELD, g_SetupInfo.boAutoShield);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOCLOAK, g_SetupInfo.boAutoCloak);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SNOWWINDLOCK, g_SetupInfo.boSnowWindLock);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_LONGWIND, g_SetupInfo.boAutoLongWide);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOLONGICEHIT, g_SetupInfo.boAutoLongIceHit);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_FIERYDRAGONLOCK, g_SetupInfo.boFieryDragonLock);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_UNIT_HPMP, g_SetupInfo.boUnitHpMp);


  //SetIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEHELMET, not g_SetupInfo.boShowHelmet);


  UserOptionSetup.nExpFiltrateCount := g_SetupInfo.nExpFiltrateCount;
  UserOptionSetup.nHpProtectCount := g_SetupInfo.nHpProtectCount;
  UserOptionSetup.dwHpProtectTime := g_SetupInfo.dwHpProtectTime;
  UserOptionSetup.nMpProtectCount := g_SetupInfo.nMpProtectCount;
  UserOptionSetup.dwMpProtectTime := g_SetupInfo.dwMpProtectTime;
  UserOptionSetup.nHpProtectCount2 := g_SetupInfo.nHpProtectCount2;
  UserOptionSetup.dwHpProtectTime2 := g_SetupInfo.dwHpProtectTime2;
  UserOptionSetup.nMpProtectCount2 := g_SetupInfo.nMpProtectCount2;
  UserOptionSetup.dwMpProtectTime2 := g_SetupInfo.dwMpProtectTime2;
  UserOptionSetup.nHpProtectCount3 := g_SetupInfo.nHpProtectCount3;
  UserOptionSetup.dwHpProtectTime3 := g_SetupInfo.dwHpProtectTime3;
  UserOptionSetup.btHpProtectIdx := g_SetupInfo.btHpProtectIdx;
  FrmMain.SendClientSocket(CM_GAMESETUPINFO, 0, 0, 0, 1, EncodeBuffer(@UserOptionSetup, SizeOf(UserOptionSetup)));

  nChangeCount := 0;
  for I := 0 to g_StditemList.Count - 1 do begin
    ClientStditem := g_StditemList[I];
    ClientItemFiltrate := pTClientItemFiltrate(g_StditemFiltrateList[I]);
    if ClientStditem.isShow then begin
      if (ClientStditem.Filtrate.boShow <> ClientItemFiltrate.boShow) or
        (ClientStditem.Filtrate.boColor <> ClientItemFiltrate.boColor) or
        (ClientStditem.Filtrate.boPickUp <> ClientItemFiltrate.boPickUp) then begin
        UserItemsSetup[nChangeCount] := ClientStditem.StdItem.Idx + 1;
        if ClientStditem.Filtrate.boShow then
          UserItemsSetup[nChangeCount] := UserItemsSetup[nChangeCount] or $2000;
        if ClientStditem.Filtrate.boColor then
          UserItemsSetup[nChangeCount] := UserItemsSetup[nChangeCount] or $4000;
        if ClientStditem.Filtrate.boPickUp then
          UserItemsSetup[nChangeCount] := UserItemsSetup[nChangeCount] or $8000;
        Inc(nChangeCount);
        if nChangeCount > MAXITEMSSETUPCOUNT then
          break;
      end;
    end;
  end;
  if nChangeCount > 0 then
    FrmMain.SendClientSocket(CM_GAMESETUPINFO, nChangeCount, 0, 0, 2,
      EncodeBuffer(@UserItemsSetup[0], SizeOf(Word) * nChangeCount))
  else
    FrmMain.SendClientSocket(CM_GAMESETUPINFO, 0, 0, 0, 2, '');
end;

procedure GetGameSetupInfo(Msg: pTDefaultMessage; sBody: string);
var
  UserOptionSetup: TUserOptionSetup;
  UserItemsSetup: TUserItemsSetup;
  ClientStditem: pTClientStditem;
  I: Integer;
begin
  if Msg.Series = 1 then begin
    DecodeBuffer(sBody, @UserOptionSetup, SizeOf(UserOptionSetup));
    g_SetupInfo.boShowName := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAME);
    g_SetupInfo.boShowNameAll := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAMEALL);
    g_SetupInfo.boShowNameMon := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAMEMON);
    g_SetupInfo.boDuraHint := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_DURAHINT);
    g_SetupInfo.boShowMapHint := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWMAPHINT);
    g_SetupInfo.boShowItemName := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWITEMNAME);
    g_SetupInfo.boAutoPickUpItem := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOPICKUPITEM);
    g_SetupInfo.boExemptShift := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_EXEMPTSHIFT);
    if g_boEasyNotShift and g_SetupInfo.boExemptShift then g_boShiftOpen := True;
    g_SetupInfo.boGetExpFiltrate := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_GETEXPFILTRATE);
    g_SetupInfo.boMoveHpShow := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_MOVEHPSHOW);
    g_SetupInfo.boHpProtect := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT);
    g_SetupInfo.boMpProtect := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_MPPROTECT);
    g_SetupInfo.boHpProtect2 := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT2);
    g_SetupInfo.boMpProtect2 := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_MPPROTECT2);
    g_SetupInfo.boHpProtect3 := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT3);
    g_SetupInfo.boHideAroundHum := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEAROUNDHUM);
    g_SetupInfo.boHideAllyHum := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEALLYHUM);
    g_SetupInfo.boHideMagicBegin := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEMAGICBEGIN);
    g_SetupInfo.boHideMagicEnd := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEMAGICEND);
    g_SetupInfo.boAutoLongHit := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOLONGHIT);
    g_SetupInfo.boAutoWideHit := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOWIDEHIT);
    g_SetupInfo.boAutoFireHit := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOFIREHIT);
    g_SetupInfo.boAutoShield := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOSHIELD);
    g_SetupInfo.boAutoCloak := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOCLOAK);
    g_SetupInfo.boSnowWindLock := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SNOWWINDLOCK);
    g_SetupInfo.boAutoLongWide := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_LONGWIND);
    g_SetupInfo.boAutoLongIceHit := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOLONGICEHIT);
    g_SetupInfo.boFieryDragonLock := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_FIERYDRAGONLOCK);
    g_SetupInfo.boUnitHpMp := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_UNIT_HPMP);

    //g_SetupInfo.boShowHelmet := not CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEHELMET);
    g_SetupInfo.nExpFiltrateCount := UserOptionSetup.nExpFiltrateCount;
    g_SetupInfo.nHpProtectCount := UserOptionSetup.nHpProtectCount;
    g_SetupInfo.dwHpProtectTime := UserOptionSetup.dwHpProtectTime;
    g_SetupInfo.nMpProtectCount := UserOptionSetup.nMpProtectCount;
    g_SetupInfo.dwMpProtectTime := UserOptionSetup.dwMpProtectTime;
    g_SetupInfo.nHpProtectCount2 := UserOptionSetup.nHpProtectCount2;
    g_SetupInfo.dwHpProtectTime2 := UserOptionSetup.dwHpProtectTime2;
    g_SetupInfo.nMpProtectCount2 := UserOptionSetup.nMpProtectCount2;
    g_SetupInfo.dwMpProtectTime2 := UserOptionSetup.dwMpProtectTime2;
    g_SetupInfo.nHpProtectCount3 := UserOptionSetup.nHpProtectCount3;
    g_SetupInfo.dwHpProtectTime3 := UserOptionSetup.dwHpProtectTime3;
    g_SetupInfo.btHpProtectIdx := UserOptionSetup.btHpProtectIdx;
  end
  else if Msg.Series = 2 then begin
    DecodeBuffer(sBody, @UserItemsSetup[0], SizeOf(Word) * Msg.Recog);
    for I := 0 to Msg.Recog - 1 do begin
      ClientStditem := GetClientStditem(UserItemsSetup[I] and $1FFF);
      if ClientStditem <> nil then begin
        ClientStditem.Filtrate.boShow := (UserItemsSetup[I] and $2000) = $2000;
        ClientStditem.Filtrate.boColor := (UserItemsSetup[I] and $4000) = $4000;
        ClientStditem.Filtrate.boPickUp := (UserItemsSetup[I] and $8000) = $8000;
      end;
    end;
  end;
end;

function ExecuteScript(sScript: string): Boolean;
begin
  Result := True;
  if Length(sScript) >= 2 then begin
    if CompareText(sScript, '~@image_interface') = 0 then begin
      ShowInterface(True);
    end else
    if CompareText(sScript, '~@image_arming') = 0 then begin
      ShowArmingHint(True);
    end else
    if CompareText(sScript, '~@quest_list') = 0 then begin
      FrmDlg3.dbtnMissionAcceptClick(FrmDlg3.dbtnMissionAccept, 0, 0);
    end else
    if CompareLStr(sScript, '@Move(', Length('@Move('))then begin
      ScriptGoto(sScript);
    end else
      Result := False;
  end else
    Result := False;
end;

procedure SetDefaultSetupInfo;
var
  ClientStditem: pTClientStditem;
  ClientItemFiltrate: pTClientItemFiltrate;
  I: Integer;
begin
  with g_SetupInfo do begin
    boCustomKey := False; //�����Զ����ݼ�
    //boShowHelmet := True; //�Ƿ���ʾͷ��
    boShowName := True; //��ʾ��������
    boShowNameAll := False; //��ʾ��������
    boShowNameMon := False; //��ʾ��������
    boDuraHint := True; //�־þ���
    boShowMapHint := True; //��ʾ��ͼ��ʶ
    boShowItemName := True; //Ctrl��ʾ��Ʒ����
    boAutoPickUpItem := False; //�Զ�����
    boExemptShift := False; //��Shift��
    boGetExpFiltrate := False; //�;���ֵ��ȡ����
    nExpFiltrateCount := 20000; //�����������
    boMoveHpShow := True; //�ƶ�ƮѪ��ʾ
    boHpProtect := False; //Ѫ������
    nHpProtectCount := 0;
    dwHpProtectTime := 4;
    boMpProtect := False; //ħ��ֵ����
    nMpProtectCount := 0;
    dwMpProtectTime := 4;
    boHpProtect2 := False; //����ҩƷ����
    nHpProtectCount2 := 0;
    dwHpProtectTime2 := 4;
    boMpProtect2 := False; //����ҩƷħ��ֵ����
    nMpProtectCount2 := 0;
    dwMpProtectTime2 := 4;
    boHpProtect3 := False; //���ᱣ��
    nHpProtectCount3 := 0;
    dwHpProtectTime3 := 4;
    btHpProtectIdx := 0;
    boHideAroundHum := False; //������Χ����
    boHideAllyHum := False; //������������
    boHideMagicBegin := False; //���ؼ��ܳ���Ч��
    boHideMagicEnd := False; //���ؼ��ܹ���Ч��
    boAutoLongHit := False; //������ɱ
    boAutoWideHit := False; //����Բ��
    boAutoFireHit := False; //�Զ��һ�
    boAutoShield := False; //�Զ�����
    boAutoCloak := False; //�Զ�����
    boAutoLongIceHit := False;
    boSnowWindLock := False;
    boFieryDragonLock := False;
    boUnitHpMp := False;

    boAutoMagic := False; //�Զ�����
    dwAutoMagicTick := 10000;
    nAutoMagicIndex := -1;
    boAutoLongWide := False;

    {boNotDeal := False;
    boNotGroup := False;
    boNotFriend := False;
    boNotGuild := False;  }
  end;

  for I := 0 to g_StditemList.Count - 1 do begin
    ClientStditem := g_StditemList[I];
    ClientItemFiltrate := pTClientItemFiltrate(g_StditemFiltrateList[I]);
    ClientStditem.Filtrate.boPickUp := ClientItemFiltrate.boPickUp;
    ClientStditem.Filtrate.boColor := ClientItemFiltrate.boColor;
    ClientStditem.Filtrate.boShow := ClientItemFiltrate.boShow;
  end;
end;

end.

