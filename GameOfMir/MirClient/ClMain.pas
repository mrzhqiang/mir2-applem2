unit ClMain;
{ 客户端主界面
由这个单元来展现各种界面（场景），简单表示如下：
1. logo 界面
2. 服务器列表界面
3. 登录界面
3.1 注册界面
3.2 找回密码界面
4. 选择角色界面
4.1 创建角色界面
4.2 删除角色界面
4.3 恢复角色界面
5. *游戏界面--PlanScn.pas
}

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs, GMManage,
  JSocket, ExtCtrls, DrawScrn, HGEGUI, HGETextures, Imm, DES, HGE, HGESounds, DirectX,
  IntroScn, PlayScn, MapUnit, WIL, Grobal2, HGEFonts, DirectXGraphics, D3DX81mo,
  Actor, CliUtil, HUtil32, EDcodeEx, LShare,
  ClFunc, magiceff, SoundUtil, clEvent, Bass, DateUtils,
  MShare, Share, jpeg, HGECanvas, RSA, SDK, Resource;

type
  TLoginConnInfo = packed record
    sAddrs: string[30];
    wPort: Word;
  end;

  TLoginConnInfos = array[0..9] of TLoginConnInfo;

  TDirectDrawCreate = function(lpGUID: PGUID; out lplpDD: IDirectDraw; pUnkOuter: IUnknown): HRESULT;
stdcall;

  TKornetWorld = record
    CPIPcode: string;
    SVCcode: string;
    LoginID: string;
    CheckSum: string;
  end;

  TOneClickMode = (toNone, toKornetWorld);

  TfrmMain = class(TForm)
    CSocket: TClientSocket;
    TimerSocket: TTimer;
    MouseTimer: TTimer;
    WaitMsgTimer: TTimer;
    SelChrWaitTimer: TTimer;
    CmdTimer: TTimer;
    MinTimer: TTimer;
    WgTimer: TTimer;
    TimerInitialize: TTimer;
    TimerRun: TTimer;
    TimerTest: TTimer;
    PackENRSA: TRSA;

    procedure FormCreate(Sender: TObject);

    procedure FormDestroy(Sender: TObject);

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

    procedure DXDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure DXDrawFinalize(Sender: TObject);

    procedure CSocketConnect(Sender: TObject; Socket: TCustomWinSocket);

    procedure CSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);

    procedure CSocketError(Sender: TObject; Socket: TCustomWinSocket;
                              ErrorEvent: TErrorEvent; var ErrorCode: Integer);

    procedure CSocketRead(Sender: TObject; Socket: TCustomWinSocket);

    procedure TimerSocketTimer(Sender: TObject);

    procedure DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
                               Shift: TShiftState; X, Y: Integer);

    procedure MouseTimerTimer(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure DXDrawDblClick(Sender: TObject);

    procedure WaitMsgTimerTimer(Sender: TObject);

    procedure SelChrWaitTimerTimer(Sender: TObject);

    procedure DXDrawClick(Sender: TObject);

    procedure CmdTimerTimer(Sender: TObject);

    procedure MinTimerTimer(Sender: TObject);

    procedure CheckHackTimerTimer(Sender: TObject);

    procedure SendTimeTimerTimer(Sender: TObject);

    procedure FormShow(Sender: TObject);

    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure AutoPickUpItem(boFlag: Boolean);

    procedure WgTimerTimer(Sender: TObject);

    procedure TimerRunTimer(Sender: TObject);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);

    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);

    procedure AddSystemMsg(sMsg: string; MsgColor: TColor);

    procedure FormActivate(Sender: TObject);

    procedure TimerTestTimer(Sender: TObject);

    procedure TimerInitializeTimer(Sender: TObject);

  private
    SocStr, BufferStr: string;
    WarningLevel: Integer;
    TimerCmd: TTimerCommand;
    MakeNewId: string;

    ActionLockTime: LongWord;
    LastHitTick: LongWord;
    ActionFailLock: Boolean;
    ActionFailLockTime: LongWord;
    FailAction, FailDir: Integer;

    mousedowntime: LongWord;
    mousemovetime: LongWord;
    mousechecktime: LongWord;
    WaitingMsg: TDefaultMessage;
    WaitingStr: string;
    WhisperName: string;
    TempItemList: TList;
    FCriticalSection: TRTLCriticalSection;
    FSendSocketStr: string;
    m_boCheckAppend: Boolean;
    m_FreeTextureTick: LongWord;
    m_FreeTextureIndex: Integer;
    m_boGroupPoison: Boolean;
    //m_CheckTick: LongWord;
    procedure SocketLock;

    procedure SocketUnLock;

    procedure ProcessKeyMessages;

    procedure ProcessActionMessages;

    procedure ProcessFreeTexture;

    procedure GetAutoMovingXY();

    procedure DecodeMessagePacket(datablock: string);

    procedure ActionFailed;

    procedure CheckUserState(UserState: Integer);

    procedure UseMagicSpell(who, effnum, targetx, targety, magic_id: Integer);

    procedure UseMagicFire(who, efftype, effnum, targetx, targety, target: Integer);

    procedure UseMagicFireFail(who: Integer);

    procedure CloseAllWindows;

    procedure ClearDropItems;

    procedure ResetGameVariables;
//    procedure ChangeServerClearGameVariables;
    procedure _DXDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure AttackTarget(target: TActor);

    procedure InitializeMap(sMapName: string);

    function CheckDoorAction(dx, dy: Integer): Boolean;

    procedure ClientGetPasswdSuccess(body: string);
    //    procedure ClientGetSelectServer;
    //procedure ClientGetPasswordOK(Msg: TDefaultMessage; sBody: string);
    procedure ClientGetReceiveChrs(body: string);

    procedure ClientGetStartPlay(body: string);

    procedure ClientGetReconnect(body: string);

    procedure ClientGetAppend(Msg: pTDefaultMessage; sBody: string);

    procedure ClientGetServerConfig(Msg: TDefaultMessage; sBody: string);

    procedure ClientGetMissionInfo(Msg: TDefaultMessage; sBody: string);

    procedure ClientGetMapDescription(Msg: TDefaultMessage; sBody: string);

    procedure ClientGetGameGoldName(Msg: TDefaultMessage; sBody: string);

    procedure ClientGetSayItem(Msg: TDefaultMessage; sBody: string);
    //procedure ClientGetAdjustBonus(bonus: Integer; body: string);
    procedure ClientGetAddItem(Msg: TDefaultMessage; body: string);

    procedure ClientGetGroupAddItem(Msg: pTDefaultMessage);

    procedure ClientGetUpdateItem(body: string);
    //procedure ClientGetUpdateItemEx(Msg: TDefaultMessage);
    procedure ClientGetDelItem(sindex, nIdent: Integer);

    procedure ClientGetDelItems(body: string);

    procedure ClientGetBagItmes(body: string);

    procedure ClientGetAddBagItmes(body: string);

    procedure ClientUpdateUserItem(body: string);

    procedure ClientGetDropItemFail(sindex: Integer);

    procedure ClientGetFriendChange(Msg: pTDefaultMessage; body: string);

    procedure ClientGetEMail(Msg: pTDefaultMessage; body: string);

    procedure ClientGetShowItem(itemid, X, Y, looks: Integer; itmname: string);

    procedure ClientGetHideItem(itemid, pickup: Integer);

    procedure ClientGetSenduseItems(body: string);

    procedure ClientGetUserShopList(Msg: pTDefaultMessage; body: string);

    procedure ClientGetMyShopList(Msg: pTDefaultMessage; body: string);

    procedure ClientGetRenewHum(Msg: pTDefaultMessage; Body: string);
    //procedure ClientGetSendAddUseItems(body: string);
    procedure ClientGetAddMagic(body: string);

    procedure ClientGetDelMagic(magid: Integer);

    procedure ClientGetMyMagics(body: string);

    procedure ClientGetMagicLvExp(magid, maglv, magtrain: Integer);

    procedure ClientGetDuraChange(uidx, newdura, newduramax, nPic: Integer);

    procedure ClientGetBabDuraChange(Idx, Dura, MaxDura: integer);

    procedure ClientGetBabDuraChange2(Msg: pTDefaultMessage);

    procedure ClientGetMerchantSay(merchant, nResID, nWidth, nHeight: Integer; saying: string);

    procedure ClientGetSendGoodsList(merchant, count, nFlag: Integer; body: string);

    procedure ClientGetAbilityMoveSet(body: string);

    procedure ClientGetCompoundInfos(body: string);

    procedure ClientGetSendMakeDrugList(Msg: pTDefaultMessage; body: string);

    procedure ClientGetHintDataList(Msg: pTDefaultMessage; body: string);

    procedure ClientSendInfo(Msg: pTDefaultMessage; bodystr: string);

    procedure ClientGetSendReturnItemList(body: string);
    //procedure ClientGetSendUserSell(merchant: Integer);
    //procedure ClientGetSendUserRepair(merchant: Integer);
//    procedure ClientGetSendUserStorage(merchant: Integer);
    procedure ClientGetSaveItemList(Msg: pTDefaultMessage; bodystr: string);
    //procedure ClientGetSendDetailGoodsList(merchant, count, topline: Integer; bodystr: string);
    procedure ClientGetSendNotice(body: string);

    procedure ClientGetDataFile(Msg: TDefaultMessage; bodystr: string);

    procedure ClientFilterInfo(Msg: TDefaultMessage; bodystr: string);

    procedure ClientGetGroupMembers(Msg: TDefaultMessage; bodystr: string);

    procedure ClientGetAddMembers(Msg: pTDefaultMessage; bodystr: string);

    procedure ClientGetDelMembers(Msg: pTDefaultMessage; bodystr: string);

    procedure ClientGetGroupInfo(Msg: TDefaultMessage; bodystr: string);

    procedure ClientGetCheckMsg(Msg: pTDefaultMessage; bodystr: string);

    procedure ClientGetOpenGuildDlg(Msg: pTDefaultMessage; bodystr: string);

    procedure ClientGetSendGuildMemberList(Msg: pTDefaultMessage; body: string);

    procedure ClientGetDealRemoteAddItem(body: string);

    procedure ClientGetDealRemoteDelItem(body: string);

    procedure ClientGetSetItems(Msg: pTDefaultMessage; body: string);
    //procedure ClientGetReadMiniMap(mapindex, mapindex2: Integer);
    //procedure ClientGetChangeGuildName(body: string);
    procedure ClientGetSendUserState(Msg: pTDefaultMessage; body: string);

    procedure DrawEffectHum(nType, nX, nY, nActor: Integer);

    procedure DrawMonMagic(Msg: pTDefaultMessage; body: string);

    procedure ClientGetNeedPassword(body: string);

    procedure ClientGetPasswordStatus(Msg: pTDefaultMessage; body: string);

    procedure ClientGetRegInfo(Msg: pTDefaultMessage; body: string);

    procedure ClientGetCenterMsg(Msg: pTDefaultMessage; body: string);

    procedure ClientGetClearCenterMsg(Msg: pTDefaultMessage; body: string);

    procedure ClientGetSetIcon(DefMsg: pTDefaultMessage; body: string);

    procedure ClientGetHumLook(DefMsg: pTDefaultMessage);

    procedure ClientOpenBox(Msg: pTDefaultMessage; body: string);

    procedure ClientGetShopItems(Msg: pTDefaultMessage; body: string);

    procedure ClientGetTaxisList(nIdx, nNowPage, nMaxPage, nClickIdx: integer; body: string);
    //    procedure ClientGetShopItems(Msg: pTDefaultMessage; body: string);
    procedure ClientGetSayMsg(Msg: TDefaultMessage; sBody: string);
    //procedure WMDisplayChange(var message: TMessage); message WM_DISPLAYCHANGE;
    procedure OnWM_INPUTLANGCHANGEREQUEST(var WMessage: TMessage); message WM_INPUTLANGCHANGEREQUEST;

    procedure OnWM_IME_COMPOSITION(var WMessage: TMessage); message WM_IME_COMPOSITION;

    //    procedure SetInputStatus();
{$IFDEF DEBUG}
    procedure CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4, sParam5: string);
    procedure CmdTest(sParam1, sParam2, sParam3, sParam4,
    sParam5: string);
    procedure ShowHumanMsg(Msg: pTDefaultMessage);

{$ENDIF}
  public
    ActionKey: Integer;
    LoginID, LoginPasswd, CharName: string;

    Certification: Integer;
    ActionLock: Boolean;
    tempidx: Integer;
    boSizeMove: Boolean;
    boInFocus: Boolean;
    m_SayMsgList: TList;
    m_SayIndex: Integer;
    CheckSpeedTick: LongWord;
    boCheckSpeed: Boolean;
    boSocketClose: Boolean;
    boOpenLoginDoor: Boolean;
    m_Point: TPoint;
    CreateChrName: string;
    m_boExit: Boolean;
    FLoginConnInfos: TLoginConnInfos;
    FLoginConnIndex: Word;
    FCheckLogin: Boolean;
    FCheckCount: Integer;
    FShowHintTick: LongWord;
    FShowHintTick2: LongWord;
    FboShowLogo: Boolean;
    FnShowLogoIndex: Integer;
    FdwShowLogoTick: LongWord;
    FMissionTick: LongWord;
    // FDevMode: TDeviceMode;
    FDDrawHandle: THandle;
    FIDDraw: IDirectDraw;
    FboDisplayChange: Boolean;
    FHotKeyId: Integer;
    boShowPrintMsg: Boolean;
    procedure CreateClientSocket(sAddrs: string; wPort: Word; nIndex: Integer);

    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);

    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);

    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);

    procedure DecodeItem(sMsg: string; ItemBuf: PChar);
//    procedure FullScreen(boFull: Boolean);
    procedure WMMove(var Message: TWMMove); message WM_MOVE;

    procedure WMEnterSizeMove(var Message: TWMMove); message WM_ENTERSIZEMOVE;

    procedure WMExitSizeMove(var Message: TWMMove); message WM_EXITSIZEMOVE;

    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;

    procedure WMSetFocus(var WMessage: TMessage); message WM_SETFOCUS;

    procedure WMKillFocus(var WMessage: TMessage); message WM_KILLFOCUS;

    procedure WMTabKey(var WMessage: TMessage); message WM_USER + 1003;

    procedure WMHotKey(var Msg: Tmessage); message WM_HOTKEY;

    //procedure WMLegendMap(var WMessage: TMessage); message WM_USER + 1004;

    //procedure ProcOnIdle;
    procedure AppOnIdle(boInitialize: Boolean = False);

    procedure OnIdle(Sender: TObject; var Done: Boolean);

    procedure AppLogout;

    procedure AppExit;

    procedure PrintScreenNow;

    procedure EatItem(idx: Integer);

    procedure GetMoveHPShow(Actor: TActor; nCount: Word);

    function EatItembyName(sItemName: string): Boolean;

    function EatItemByType(nType: Integer): Boolean;

    function GetClientVersion(): Integer;

    procedure SendClientMessage(Msg, Recog, param, tag, series: Integer; pszMsg: string = '');

    procedure SendClientSocket(Msg, Recog, param, tag, series: Integer; pszMsg: string = '');

    procedure SendLogin(uid, passwd: string);

    procedure SendCardInfo(No1, No2, No3: Word);

    procedure SendNewAccount(ue: TUserEntry; ua: TUserEntryAdd);

    procedure SendSelectServer(svname: string);

    procedure SendChgPw(id, passwd, newpasswd: string);

    procedure SendNewChr(uid, uname, shair, sjob, ssex: string);

    procedure SendQueryChr;

    procedure SendDelChr(chrname: string);

    procedure SendSelChr(chrname: string);

    procedure SendViewDelHum();

    procedure SendRenewHum(chrname: string);

    procedure SendRunLogin;

    procedure SendSay(str: string);

    procedure SendQueryBagItems();

    procedure SendActMsg(ident, X, Y, dir: Integer);

    procedure SendSitDownMsg(uid, X, Y, dir: Integer);

    procedure SendSpellMsg(ident, X, Y, dir, target: Integer);

    procedure SendQueryUserName(targetid, X, Y: Integer);

    procedure SendDropItem(name: string; itemserverindex: Integer);

    procedure SendPickup;

    procedure SendTakeOnItem(where: byte; itmindex: Integer; itmname: string);

    procedure SendTakeOffItem(where: byte; itmindex: Integer; itmname: string);

    procedure SendEat(Item: pTNewClientItem);

    procedure SendButchAnimal(X, Y, dir, actorid: Integer);
    //procedure SendMagicKeyChange(magid: Integer; keych: Char);
    procedure SendMerchantDlgSelect(merchant: Integer; rstr: string);

    procedure SendCheckMsgDlgSelect(merchant, nBut: Integer);
    //procedure SendQueryPrice(merchant, itemindex: Integer; itemname: string);
    // procedure SendQueryRepairCost(merchant, itemindex: Integer; itemname: string);
    procedure SendSellItem(merchant, itemindex: Integer {; itemname: string});

    procedure SendRepairItem(merchant, itemindex: Integer; wFlag: Word);

    procedure SendStorageItem(merchant, itemindex, nIdx: Integer {; itemname: string});
    //procedure SendGetDetailItem(merchant, menuindex: Integer; itemname: string);
    procedure SendBuyItem(merchant, itemserverindex, nCount: Integer; boBindGold: Boolean);

    procedure SendTakeBackStorageItem(merchant, itemserverindex, nIdx: Integer);
    //procedure SendMakeDrugItem(merchant: Integer; itemname: string);
    procedure SendDropGold(dropgold: Integer);

    procedure SendGroupMode();

    procedure SendCreateGroup(ItemClass: Integer; withwho: string);
    //    procedure SendWantMiniMap;
    procedure SendDealTry(nID, nX, nY: Integer); //菊俊 荤恩捞 乐绰瘤 八荤
    procedure SendGuildDlg(index: integer);

    procedure SendCancelDeal;

    procedure SendAddDealItem(ci: TNewClientItem);

    procedure SendDelDealItem(ci: TNewClientItem);

    procedure SendTakeOnAddBagItem(idx, ItemIndex: integer);

    procedure SendTakeOffAddBagItem(idx: integer);

    procedure SendChangeDealGold(gold: Integer);

    procedure SendDealEnd;

    procedure SendDealLock;

    procedure SendAddGroupMember(withwho: string);

    procedure SendDelGroupMember(withwho: string);

    procedure SendShopList(nIdent, nIndex: Integer);
    //procedure SendGuildHome;
    procedure SendGuildMemberList(index: integer);

    procedure SendGuildAddMem(who: string);

    procedure SendGuildDelMem(who: string);

    procedure SendGuildUpdateNotice(notices: string);

    procedure SendGuildUpdateGrade(rankinfo: string);

    procedure SendMakeItem(TitleItem, LevelItem, MakeStone1, MakeStone2, MakeStone3: Integer);

    procedure SendSpeedHackUser;

    procedure SendGetSayItem(nid, ItemIndex: Integer);
    //SpeedHaker 荤侩磊甫 辑滚俊 烹焊茄促.
    //procedure SendAdjustBonus(remain: Integer; babil: TNakedAbility);
    //procedure SendPassword(sPassword: string; nIdent: Integer);
    //procedure SendShopDlg(wPage: Word);
    //procedure SendBuyShopItem(sItems: string; btType: byte);

    procedure SendShopBuyItem(nIdx, ItemIndex, wIdent, btGameGold: Integer);

    procedure SendCustomIconClick(nIdx: Integer);

    procedure SendShopGetPoint(nCount: Integer);
    //procedure SendTaxis(nIdx, nJob, nPage: Integer);

    function TargetInSwordLongAttackRange(ndir: Integer): Boolean;

    function TargetInSwordWideAttackRange(ndir: Integer): Boolean;

    function TargetInSwordCrsAttackRange(ndir: Integer): Boolean;

    procedure OnProgramException(Sender: TObject; E: Exception);

    procedure SendSocket(sendstr: string);

    procedure SendSocketEx(sendstr: string);

    function ServerAcceptNextAction: Boolean;

    function CanNextAction: Boolean;

    function CanNextActionEx: Boolean;

    function CanNextHit: Boolean;

    function IsUnLockAction(Action, adir: Integer): Boolean;

    procedure ActiveCmdTimer(cmd: TTimerCommand); overload;

    procedure MyCopyDataMessage(var MsgData: TWmCopyData); message WM_COPYDATA;

    procedure MyCheckClient(var Msg: TMessage); message WM_CHECK_CLIENT;

    procedure OpenADForm(nWidth, nHeight: Integer; sUrl: string);

    procedure MyDeviceInitialize(Sender: TObject; var Success: Boolean; var ErrorMsg: string);

    procedure MyDeviceFinalize(Sender: TObject);

    procedure MyDeviceRender(Sender: TObject);

    procedure MyDeviceNotifyEvent(Sender: TObject; Msg: Cardinal);

    procedure DisplayChange(boReset: Boolean);

{$IFDEF DEBUG}
    procedure ProcessCommand(sData: string);
{$ENDIF}
    procedure UseMagic(tx, ty: Integer; pcm: PTNewClientMagic);
  end;
  function IsDebug(): Boolean;

  function IsDebugA(): Boolean;
//function CheckMirProgram: Boolean;
  procedure PomiTextOut(dsurface: TDirectDrawSurface; X, Y: Integer; str: string);

  procedure WaitAndPass(msec: LongWord);

  function GetRGB(c256: byte): LongWord;

  procedure DebugOutStr(Msg: string);

  function KeyboardHookProc(Code: Integer; WParam: WParam; lparam: LPARAM): Longint; stdcall;

var
  HGE: IHGE = nil;
  boOutbugStr: Boolean = True;
  boOutMsg: Boolean = False;
  nLeft: Integer = 10;
  nTop: Integer = 10;
  //nWidth: Integer;
  //nHeight: Integer;
  g_boShowMemoLog: Boolean = FALSE;
  g_boShowRecog: Integer = 0;
  frmMain: TfrmMain;
  DScreen: TDrawScreen;
  //IntroScene: TIntroScene;
  LoginScene: TLoginScene;
  SelectChrScene: TSelectChrScene;
  PlayScene: TPlayScene;
  SelServer: TSelServer;
  HintScene: THintScene;
  //LoginNoticeScene: TLoginNotice;

  LocalLanguage: TImeMode = imChinese;

  //MP3: TMPEG;
  TestServerAddr: string = '127.0.0.1';
  BGMusicList: TStringList;
  //DObjList: TList;  //官蹿俊 函版等 瘤屈狼 钎泅
  EventMan: TClEventManager;
  KornetWorld: TKornetWorld;
  Map: TMap;
  //  BoOneClick: Boolean;
  OneClickMode: TOneClickMode;

implementation

uses
  HerbActor, GameSetup, Common, FState3, FState2, FState, FState4, FindMapPath, MudUtil, WMFile, HGEBase,
  MD5Unit, Registry, FWeb, MNShare, CheckDLL, MyCommon, UrlMon, Logo, EncryptFile, FrmAD, ShellAPI,
  DlgConfig, GuaJi, IniFiles, ClientSetup;

{$R *.DFM}
{$R NewCursor.RES}
{$R ColorTable.RES}
var
{$IFDEF DEBUG}
  ShowMsgActor: TActor;
{$ENDIF}
  s7: string[20] = 'vUoHU5zS';
    //g_boInitialize: Byte;
    (*
function CheckMirProgram: Boolean;
var
  pstr: array[0..255] of Char;
  mirapphandle: HWnd;
begin
  Result := FALSE;
  StrPCopy(pstr, 'legend of mir2');
  mirapphandle := FindWindow(nil, pstr);
  if (mirapphandle <> 0) and (mirapphandle <> Application.Handle) then begin
{$IFNDEF COMPILE}
    SetActiveWindow(mirapphandle);
    Result := True;
{$ENDIF}
    Exit;
  end;
end;
       *)

procedure PomiTextOut(dsurface: TDirectDrawSurface; X, Y: Integer; str: string);
var
  i, n: Integer;
  d: TDirectDrawSurface;
begin
  for i := 1 to Length(str) do
  begin
    n := byte(str[i]) - byte('0');
    if n in [0..9] then
    begin
      //箭磊父 凳
      d := g_WMain99Images.Images[1821 + n];
      if d <> nil then
        dsurface.Draw(X + i * 8, Y, d.ClientRect, d, True);
    end
    else begin
      if str[i] = '-' then
      begin
        d := g_WMain99Images.Images[1831];
        if d <> nil then
          dsurface.Draw(X + i * 8, Y, d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure WaitAndPass(msec: LongWord);
var
  start: LongWord;
begin
  start := GetTickCount;
  while GetTickCount - start < msec do
  begin
    Application.ProcessMessages;
  end;
end;

function GetRGB(c256: byte): LongWord;
begin
  Result := RGB(g_ColorTable[c256].rgbRed,
                 g_ColorTable[c256].rgbGreen,
                 g_ColorTable[c256].rgbBlue);
end;

procedure DebugOutStr(Msg: string);
var
  flname: string;
  fhandle: TextFile;
begin
  //DScreen.AddChatBoardString(msg,clWhite, clBlack);
  if not boOutbugStr then
    Exit;
  flname := '.\!debug.txt';
  if FileExists(flname) then
  begin
    AssignFile(fhandle, flname);
    Append(fhandle);
  end
  else begin
    AssignFile(fhandle, flname);
    Rewrite(fhandle);
  end;
  WriteLn(fhandle, DateTimeToStr(Now) + ' ' + Msg);
  CloseFile(fhandle);
end;

Type
  TNEWDISPLAY_DEVICEW = packed record
    cb: DWORD;
    DeviceName: array[0..31] of AnsiChar;
    DeviceString: array[0..127] of AnsiChar;
    StateFlags: DWORD;
    DeviceID: array[0..127] of AnsiChar;
    DeviceKey: array[0..127] of AnsiChar;
  end;

  TNewEnumDisplayDevices = function(Unused: Pointer; iDevNum: DWORD; var lpDisplayDevice: TNEWDISPLAY_DEVICEW; dwFlags: DWORD): BOOL;
stdcall;

  TNewChangeDisplaySettings = function(lpDevMode: Pointer; dwFlags: DWORD): Longint;
stdcall;

procedure TfrmMain.FormCreate(Sender: TObject);
function ReadInteger(Reg: TRegistry; sName: string; Default: Integer): Integer;
begin
  Try
    Result := Reg.ReadInteger(sName);
  Except
    Result := Default;
  End;
end;

var
  flname: string;
  I: Integer;
  Res: TResourceStream;
  Reg: TRegistry;
  dv: TNEWDISPLAY_DEVICEW;
  MODULE: HMODULE;
  NewEnumDisplayDevices: TNewEnumDisplayDevices;
  NewChangeDisplaySettings: TNewChangeDisplaySettings;
  REGPathStr: string;
begin
  // 获取 RGB 资源，并读取到 g_ColorTable -- TRGBQuad 数组
  Res := TResourceStream.Create(Hinstance, '256RGB', 'RGB');
  try
    Res.Read(g_ColorTable, SizeOf(g_ColorTable));
  finally
    Res.Free;
  end;

  // 加载客户端配置
  ClientSetup.loadData();
  // Windows 系统库
  // https://learn.microsoft.com/zh-cn/windows/win32/dlls/dynamic-link-library-creation#using-an-import-library
  MODULE := LoadLibrary('user32.dll');
  // 查询注册表
  Reg := TRegistry.Create;
  REGPathStr := '';
  Try
    // 允许你获取有关当前会话中的显示设备的信息
    // https://learn.microsoft.com/zh-cn/windows/win32/api/winuser/nf-winuser-enumdisplaydevicesa
    NewEnumDisplayDevices := GetProcAddress(MODULE, 'EnumDisplayDevicesA');
    // 将默认显示设备的设置更改为指定的图形模式
    // https://learn.microsoft.com/zh-cn/windows/win32/api/winuser/nf-winuser-changedisplaysettingsa
    NewChangeDisplaySettings := GetProcAddress(MODULE, 'ChangeDisplaySettingsA');
    if Assigned(NewEnumDisplayDevices) then
    begin
      dv.cb := SizeOf(dv);
      NewEnumDisplayDevices(nil, 0, dv, 0);
      REGPathStr := dv.DeviceKey;
      REGPathStr := GetValidStr3(REGPathStr, flname, ['\']);
      REGPathStr := GetValidStr3(REGPathStr, flname, ['\']);
    end;

    Try
      if (REGPathStr <> '') and (Assigned(NewChangeDisplaySettings)) then
      begin
        // WIN + R 输入 regedit 可以打开注册表编辑器
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        // 计算机\HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000
        if Reg.OpenKey(REGPathStr, True) then
        begin
          // 检查是否开启显卡硬件加速，0 为开启，非 0 为关闭
          if ReadInteger(Reg, 'Acceleration.Level', 0) <> 0 then
          begin
            Reg.DeleteValue('Acceleration.Level');
            // https://learn.microsoft.com/zh-cn/windows/win32/api/winuser/nf-winuser-changedisplaysettingsa#parameters
            // $40 不符合参数描述，可能在 delphi 中有特殊意义？或者它根本没生效？
            // 所以我们使用 CDS_RESET  试试
            NewChangeDisplaySettings(nil, CDS_RESET);
          end;
        end;
        Reg.CloseKey;
      end;

      // https://www.office26.com/windows/windows_35890.html
      // WIN + R 输入 dxdiag 可以查看硬件相关参数，下面三个注册表参数就与之相关
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey('SOFTWARE\Microsoft\DirectDraw', True) then
      begin
        if ReadInteger(Reg, 'EmulationOnly', 0) <> 0 then
          Reg.WriteInteger('EmulationOnly', 0);
        if ReadInteger(Reg, 'DisableAGPSupport', 0) <> 0 then
          Reg.WriteInteger('DisableAGPSupport', 0);
      end;
      Reg.CloseKey;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey('SOFTWARE\Microsoft\Direct3D\Drivers', True) then
      begin
        if ReadInteger(Reg, 'SoftwareOnly', 0) <> 0 then
          Reg.WriteInteger('SoftwareOnly', 0);
      end;
      Reg.CloseKey;
    Except
    End;
  Finally
    Reg.Free;
    FreeLibrary(MODULE);
  End;

  // 根据读取的客户端配置，设置分辨率
  case g_FScreenMode of
    DEF_SCREEN_MODE:
    begin
      g_FScreenWidth := DEF_SCREEN_WIDTH;
      g_FScreenHeight := DEF_SCREEN_HEIGHT;
    end;
    LARGE_SCREEN_MODE:
    begin
      g_FScreenWidth := LARGE_SCREEN_WIDTH;
      g_FScreenHeight := LARGE_SCREEN_HEIGHT;
    end;
  else
    begin
      g_FScreenWidth := DEF_SCREEN_WIDTH;
      g_FScreenHeight := DEF_SCREEN_HEIGHT;
    end;
  end;

  // 记录屏幕中心点 X Y 坐标
  g_FScreenXOrigin := g_FScreenWidth div 2;
  g_FScreenYOrigin := g_FScreenHeight div 2;
  // 设置 HGE 的屏幕宽高
  GUIFScreenWidth := g_FScreenWidth;
  GUIFScreenHeight := g_FScreenHeight;
  // DirectDrawCreate 句柄，但看代码似乎没什么用
  // https://learn.microsoft.com/zh-cn/windows/win32/api/ddraw/nf-ddraw-directdrawcreate
  FDDrawHandle := 0;
  FIDDraw := nil;
  FboDisplayChange := False;
  // =====以上无用代码分割线=====

  // 显示截图消息
  boShowPrintMsg := True;

  g_btMapinitializePos := 0;
  FLoginConnIndex := 0;
  FCheckLogin := False;

  // 程序请求参数
  g_sMainParam1 := ParamStr(1);
  g_sMainParam2 := ParamStr(2);
  g_sMainParam3 := ParamStr(3);
  g_sMainParam4 := ParamStr(4);
  g_sMainParam5 := ParamStr(5);
  g_sMainParam6 := ParamStr(6);

  // 各种提示计时
  FShowHintTick := 0;
  FShowHintTick2 := 0;

  // 服务器列表相关参数
  FillChar(g_ServerInfo, SizeOf(g_ServerInfo), #0);
  g_Login_Handle := StrToIntDef(ParamStr(1), 0);
  g_ServerInfoCount := 0;

  // logo 相关参数
  FboShowLogo := False;
  FnShowLogoIndex := 0;
  FdwShowLogoTick := GetTickCount;

  // 内嵌网页浏览器
  FrmWeb := TFrmWeb.Create(Self);
  FrmWeb.Left := 5;
  FrmWeb.Top := 39;
  FrmWeb.ClientWidth := g_FScreenWidth - 10;
  FrmWeb.ClientHeight := g_FScreenHeight - 54;
  FrmWeb.Parent := Self;

  // 文件版本信息
  GetFileVersion(ParamStr(0), @g_FileVersionInfo);
  // 初始化随机种子
  Randomize;
  // 临界区，相当于可重入锁
  InitializeCriticalSection(FCriticalSection);
  // 鼠标移动计时？
  mousemovetime := GetTickCount;

  // 鼠标光标样式
{$IF Var_Interface = Var_Mir2}
  Screen.Cursors[crMyDeal] := LoadCursor(HInstance, MAKEINTRESOURCE('Deal'));
  Screen.Cursors[crOpenBox] := LoadCursor(HInstance, MAKEINTRESOURCE('OpenBox'));
  Screen.Cursors[crMySell] := LoadCursor(HInstance, MAKEINTRESOURCE('SellCursor'));
  Screen.Cursors[crMyBuy] := LoadCursor(HInstance, MAKEINTRESOURCE('BuyCursor'));
  Screen.Cursors[crMyRepair] := LoadCursor(HInstance, MAKEINTRESOURCE('RepairCursor'));
  Screen.Cursors[crMySelItem] := LoadCursor(HInstance, MAKEINTRESOURCE('SelItem'));
  Screen.Cursors[crSrepair] := LoadCursor(HInstance, MAKEINTRESOURCE('Srepair'));
{$IFEND}

{$IF Var_Interface =  Var_Default}
  Screen.Cursors[crMyNone] := LoadCursor(HInstance, MAKEINTRESOURCE('NoneCursor'));
  Screen.Cursors[crMyDialog] := LoadCursor(HInstance, MAKEINTRESOURCE('DialogCursor'));
  Screen.Cursors[crMyAttack] := LoadCursor(HInstance, MAKEINTRESOURCE('AttackCursor'));
  Screen.Cursors[crMySell] := LoadCursor(HInstance, MAKEINTRESOURCE('SellCursor'));
  Screen.Cursors[crMyBuy] := LoadCursor(HInstance, MAKEINTRESOURCE('BuyCursor'));
  Screen.Cursors[crMyRepair] := LoadCursor(HInstance, MAKEINTRESOURCE('RepairCursor'));
  Screen.Cursors[crMySelItem] := LoadCursor(HInstance, MAKEINTRESOURCE('SelItem'));
  Screen.Cursors[crMyDeal] := LoadCursor(HInstance, MAKEINTRESOURCE('Deal'));
  Screen.Cursors[crOpenBox] := LoadCursor(HInstance, MAKEINTRESOURCE('OpenBox'));
  Screen.Cursors[crSrepair] := LoadCursor(HInstance, MAKEINTRESOURCE('Srepair'));
{$IFEND}

  HGE := HGECreate(HGE_VERSION);
  HGE.System_SetState(HGE_SCREENBPP, g_BitCount);

  m_FreeTextureTick := GetTickCount;
  m_FreeTextureIndex := 0;

  m_boExit := False;

  g_StditemList := TList.Create;
  g_StditemFiltrateList := TList.Create;

  boSocketClose := False;

  tempidx := 0;
  CheckSpeedTick := 0;

  TempItemList := TList.Create;
  g_SetItemsList := TList.Create;
  mousechecktime := GetTickCount;

  g_DWinMan := TDWinManager.Create(Self);

  boSizeMove := False;
  boInFocus := True;
  g_boSendLuck := False;
  boOpenLoginDoor := False;

  g_dwDefTime := GetTickCount;
  g_EMailList := TQuickStringPointerList.Create;

  m_SayMsgList := TList.Create;
  BorderStyle := bsSingle;
  HGE.System_SetState(HGE_WINDOWED, True);
  ClientWidth := g_FScreenWidth;
  ClientHeight := g_FScreenHeight;
  HGE.System_SetState(HGE_FScreenWidth, g_FScreenWidth);
  HGE.System_SetState(HGE_FScreenHeight, g_FScreenHeight);
  HGE.System_SetState(HGE_HIDEMOUSE, False);
  HGE.System_SetState(HGE_HWNDPARENT, Handle);
  HGE.System_SetState(HGE_SHOWSPLASH, False);
  HGE.System_SetState(HGE_HARDWARE, True);
  HGE.System_SetState(HGE_TEXTUREFILTER, True);
  HGE.System_SetState(HGE_FPS, HGEFPS_VSYNC);
  HGE.System_SetState(HGE_INITIALIZE, MyDeviceInitialize);
  HGE.System_SetState(HGE_FINALIZE, MyDeviceFinalize);
  HGE.System_SetState(HGE_NOTIFYEVENT, MyDeviceNotifyEvent);

  if not DirectoryExists(g_sPhotoDirname) then
    CreateDir(g_sPhotoDirname);

  Caption := g_sLogoText;
  LoadWMImagesLib(nil);

  g_WMusicImages.FileName := MUSICFILE;
  g_WMusicImages.LibType := ltFileData;
  g_WMusicImages.Initialize;

  g_WSettingImages.FileName := SETTINGFILE;
  g_WSettingImages.LibType := ltFileData;
  g_WSettingImages.Initialize;

  g_WgHintList := TStringList.Create;
  g_DControlFreeList := TList.Create;

  g_MasterHDInfoList := TList.Create;
  g_QuestMsgList := TList.Create;
  g_DXSound := TDXSound.Create(Self);
  g_DXSound.Initialize;

  if g_DXSound.Initialized then
  begin
    g_Sound := TSoundEngine.Create(g_DXSound.DSound);
    g_Sound.Volume := g_btSoundVolume;
  end
  else begin
    g_Sound := nil;
  end;

  g_ToolMenuHook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardHookProc, 0, GetCurrentThreadID);

  g_DXFont := TDXFont.Create;

  g_SoundList := TStringList.Create;
  BGMusicList := TStringList.Create;
  g_MapDescList := TList.Create;
  g_MapEffectList := TStringList.Create;
  g_ShopHintList := TStringList.Create;
  g_CompoundInfoList := TGStringList.Create;

  ZeroMemory(@g_CompoundSet, SizeOf(TCompoundSet));
  ZeroMemory(@g_AbilityMoveSet, SizeOf(TAbilityMoveSet));

  flname := '.\wav\sound.lst';
  LoadSoundList(flname);
  flname := WAVDIRNAME + 'sound.lst';
  LoadBGMusicList(flname);
  InitializeSound();
  g_boAllLoadStream := False;
  g_MissionDateStream := TMemoryStream.Create;
  g_StditemsDateStream := TMemoryStream.Create;
  g_MagicDateStream := TMemoryStream.Create;
  g_MapDescDateStream := TMemoryStream.Create;
  g_MakeMagicDateStream := TMemoryStream.Create;
  Try
    g_MissionDateStream.LoadFromFile(GETMISSIONDESCFILE);
  Except
  End;
  Try
    g_StditemsDateStream.LoadFromFile(GETSTDITEMSDESCFILE);
  Except
  End;
  Try
    g_MagicDateStream.LoadFromFile(GETMAGICDESCFILE);
  Except
  End;
  Try
    g_MapDescDateStream.LoadFromFile(GETMAPDESCFILE);
  Except
  End;
  Try
    g_MakeMagicDateStream.LoadFromFile(GETMAKEMAGICFILE);
  Except
  End;

  for I := Low(g_MakeMagicList) to High(g_MakeMagicList) do
    g_MakeMagicList[I] := TList.Create;

  LoadMapEffectList();

  // 文本屏幕
  DScreen := TDrawScreen.Create;
  LoginScene := TLoginScene.Create;
  SelectChrScene := TSelectChrScene.Create;
  PlayScene := TPlayScene.Create;
  HintScene := THintScene.Create;
  SelServer := TSelServer.Create;
  g_FriendList := TStringList.Create;
  g_MyWhisperList := TStringList.Create;
  g_MyBlacklist := TStringList.Create;

  Map := TMap.Create;
  g_nMiniMapPath := nil;
  m_boCheckAppend := False;
  g_LegendMap := TLegendMap.Create;
  g_GuaJi := TGuaJi.Create;
  g_DropedItemList := TList.Create;
  g_FreeActorList := TList.Create;
  g_FreeItemList := TList.Create;
  EventMan := TClEventManager.Create;
  g_ChangeFaceReadyList := TList.Create;

  g_MySelf := nil;

  SafeFillChar(g_UseItems, sizeof(g_UseItems), #0);
  SafeFillChar(g_ItemArr, sizeof(g_ItemArr), #0);
  SafeFillChar(g_DealItems, sizeof(g_DealItems), #0);
  SafeFillChar(g_DealRemoteItems, sizeof(g_DealRemoteItems), #0);

  SafeFillChar(g_TaxisSelf, SizeOf(g_TaxisSelf), #0);

  for I := Low(g_StorageArrList) to High(g_StorageArrList) do
    g_StorageArrList[i] := TList.Create;

  SafeFillChar(g_ShopLoading, SizeOf(g_ShopLoading), 0);

  SafeFillChar(g_MyShopSellItems, SizeOf(g_MyShopSellItems), 0);
  SafeFillChar(g_MyShopBuyItems, SizeOf(g_MyShopBuyItems), 0);

  g_SaveItemList := TList.Create;
  g_MenuItemList := TList.Create;
  g_WaitingUseItem.Item.S.name := '';
  g_EatingItem.Item.S.name := '';

  g_nTargetX := -1;
  g_nTargetY := -1;
  g_TargetCret := nil;
  g_FocusCret := nil;
  g_FocusItem := nil;
  g_MagicTarget := nil;
  g_MagicLockTarget := nil;
  g_NPCTarget := nil;
  g_nDebugCount := 0;
  g_nDebugCount1 := 0;
  g_nDebugCount2 := 0;
  g_nTestSendCount := 0;
  g_nTestReceiveCount := 0;
  g_boServerChanging := FALSE;
  g_boAutoDig := FALSE;

  for I := Low(g_ShopList) to High(g_ShopList) do
    g_ShopList[i] := TList.Create;
  for I := Low(g_ShopGoldList) to High(g_ShopGoldList) do
    g_ShopGoldList[i] := TList.Create;
  g_ShopBuyItem := nil;
  g_dwLatestClientTime2 := 0;
  g_dwFirstClientTime := 0;
  g_dwFirstServerTime := 0;
  g_dwFirstClientTimerTime := 0;
  g_dwLatestClientTimerTime := 0;
  g_dwFirstClientGetTime := 0;
  g_dwLatestClientGetTime := 0;

  g_nTimeFakeDetectCount := 0;
  g_nTimeFakeDetectTimer := 0;
  g_nTimeFakeDetectSum := 0;

  g_dwSHGetTime := 0;
  g_dwSHTimerTime := 0;
  g_nSHFakeCount := 0;

  g_nAreaStateValue := 0;
  g_ConnectionStep := cnsSelServer;

  g_boSendLogin := FALSE;
  g_boServerConnected := FALSE;
  SocStr := '';
  WarningLevel := 0;
  ActionFailLock := FALSE;
  g_boMapMovingWait := FALSE;
  g_boMapInitialize := False;
  g_boMapApoise := False;
  g_boCheckBadMapMode := FALSE;
  g_boCheckSpeedHackDisplay := FALSE;
  g_boShowWhiteHint := True;
  FailDir := 0;
  FailAction := 0;
  g_nDupSelection := 0;

  g_dwLastAttackTick := GetTickCount;
  g_dwLastMoveTick := GetTickCount;
  g_dwLatestSpellTick := GetTickCount;
  g_boLatestSpell := False;

  g_dwAutoPickupTick := GetTickCount;
  g_boFirstTime := True;
  g_boItemMoving := FALSE;
  g_boDoFadeIn := FALSE;
  g_boDoFadeOut := FALSE;
  g_boDoFastFadeOut := FALSE;
  g_boAttackSlow := FALSE;
  g_boMoveSlow := FALSE;
  g_boNextTimePowerHit := FALSE;
  g_boCanLongHit := FALSE;
  g_boCanWideHit := FALSE;
  g_boCanCrsHit := FALSE;
  g_boCanTwnHit := FALSE;
  g_boCan110Hit := FALSE;
  g_boCan111Hit := FALSE;
  g_boCan112Hit := FALSE;
  g_boCan113Hit := FALSE;
  g_boCan122Hit := False;
  g_boCan56Hit := False;
  g_boCanLongIceHit := False;

  g_boNextTimeFireHit := FALSE;

  g_SoftClosed := FALSE;

  g_GroupMembers := TList.Create;
  SetDefKeyInfo();

  MainWinHandle := Handle;
  FrmMainWinHandle := Handle;
  g_FrmMainWinHandle := Handle;

  OneClickMode := toNone;

  DebugOutStr('----------------------- started ------------------------');
  Application.OnException := OnProgramException;
  FrmDlg := TFrmDlg.Create(nil);
  FrmDlg2 := TFrmDlg2.Create(nil);
  FrmDlg3 := TFrmDlg3.Create(nil);
  FrmDlg4 := TFrmDlg4.Create(nil);
end;

procedure TfrmMain.OnProgramException(Sender: TObject; E: Exception);
begin
  DebugOutStr(E.Message);
end;

procedure TfrmMain.OnWM_IME_COMPOSITION(var WMessage: TMessage);
var
  H: HIMC;
  CForm: TCompositionForm;
begin
  if (WMessage.LParam and GCS_RESULTSTR) <> 0 then
  begin
    H := Imm32GetContext(Handle);
    if H <> 0 then
    begin
      with CForm do
      begin
        dwStyle := CFS_POINT;
        ptCurrentPos.x := FrmIMEX + 20;
        ptCurrentPos.y := FrmIMEY;
      end;
      Imm32SetCompositionWindow(H, @CForm);
      Imm32ReleaseContext(Handle, H);
    end;
  end;
  inherited;
end;

procedure TfrmMain.OnWM_INPUTLANGCHANGEREQUEST(var WMessage: TMessage);
begin
  if FrmShowIME or ImmIsIME(GetKeyboardLayout(0)) then
  begin
    inherited;
  end;
end;

procedure TfrmMain.OpenADForm(nWidth, nHeight: Integer; sUrl: string);
begin
//  if not g_boFullScreen then begin
  if not Assigned(FormAD) then
  begin
    FormAD := TFormAD.Create(Owner);
    FormAD.Open(nWidth, nHeight, sUrl);
  end;
//  end;
end;

procedure TfrmMain.WMSetFocus(var WMessage: TMessage);
begin
  boInFocus := True;
  inherited;
end;

procedure TfrmMain.WMSysCommand(var Message: TWMSysCommand);
begin
  if Message.CmdType = SC_MINIMIZE then
  begin
    boSizeMove := True;
    DisplayChange(True);
  end
  else if Message.CmdType = SC_RESTORE then
  begin
    boSizeMove := False;
//    if g_boFullScreen then DisplayChange(False);
  end;
  //DebugOutStr(inttostr(Message.CmdType));
  inherited;
end;
{
procedure TfrmMain.WMDisplayChange(var message: TMessage);
begin
if (Tag = 1) then Exit;
if (MyDevice.Initialize) and (MyDevice.Windowed) then
  MyDevice.Reset();
end;     }

procedure TfrmMain.WMEnterSizeMove(var Message: TWMMove);
begin
  //boSizeMove := True;
  inherited;
end;

procedure TfrmMain.WMExitSizeMove(var Message: TWMMove);
begin
  //boSizeMove := False;
  inherited;
end;

procedure TfrmMain.WMHotKey(var Msg: Tmessage);
begin
  if (Msg.LparamLo = MOD_ALT) and (Msg.LParamHi = VK_TAB) then
  begin
    PostMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  end;
end;

procedure TfrmMain.WMKillFocus(var WMessage: TMessage);
begin
  boInFocus := False;
  inherited;
end;

{
procedure TfrmMain.WMLegendMap(var WMessage: TMessage);
begin
  g_LegendMapRun := False;
  if g_LegendMapName <> '' then
    g_LegendMap.LoadMap;
  inherited;
end;       }

procedure TfrmMain.WMMove(var Message: TWMMove);
begin
  m_Point := ClientOrigin;
  inherited;
end;

procedure TfrmMain.WMTabKey(var WMessage: TMessage);
var
  Key: Char;
  nKey: Word;
begin
  Key := #9;
  nKey := VK_TAB;
  FormKeyDown(self, nKey, []);
  FormKeyPress(self, Key);
  FormKeyUp(self, nKey, []);
end;

function KeyboardHookProc(Code: Integer; WParam: WParam; lparam: LPARAM): Longint; stdcall;
begin
  if Code < 0 then
    Result := CallNextHookEx(g_ToolMenuHook, Code, WParam, lparam)
  else begin
    if g_CanTab and (WParam = 9) and ((lParam and $80000000) = 0) then
    begin
      PostMessage(FrmMain.Handle, WM_USER + 1003, 0, 0);
      Result := 1;
    end
    else
      Result := CallNextHookEx(g_ToolMenuHook, Code, WParam, lparam);
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  i: Integer;
  II: Integer;
begin

  //g_boChangeWin := False;
  //ClearShowItemList();
  //g_ShowItemList.Free;
  FIDDraw := nil;
  if FDDrawHandle > 0 then
    FreeLibrary(FDDrawHandle);

  g_WMusicImages.Finalize;
  g_WMusicImages.Free;
  g_WSettingImages.Finalize;
  g_WSettingImages.Free;

  ClearMapDescList;
  ClearMapEffectList;
  ClearMasterHDInfo(g_MasterHDInfoList);
  //ClearMsgDlgList();
  //g_ShowMsgDlgList.Free;
  g_MasterHDInfoList.Free;
  m_SayMsgList.Free;
  TempItemList.Free;
  g_MapDescList.Free;
  g_MapEffectList.Free;
  for I := 0 to g_SetItemsList.Count - 1 do
    Dispose(pTSetItems(g_SetItemsList[I]));

  for i := 0 to g_CompoundInfoList.Count - 1 do
    Dispose(pTCompoundInfos(g_CompoundInfoList.Objects[i]));
  FreeAndNil(g_CompoundInfoList);

  g_SetItemsList.Free;
  g_ShopHintList.Free;
  ClearEMailInfo();
  g_EMailList.Free;
  for I := Low(g_StorageArrList) to High(g_StorageArrList) do
    g_StorageArrList[i].Free;
  g_DControlFreeList.Free;
  //ClearGetSayItemList();
  //g_GetSayItemList.Free;
  //FreeLibrary(Moudle);
  for I := 2 to 5 do
  begin
    for II := 0 to g_ShopList[i].Count - 1 do
    begin
      Dispose(pTShopItem(g_ShopList[i].Items[ii]));
    end;
    g_ShopList[i].Free;
  end;
  for I := Low(g_ShopGoldList) to High(g_ShopGoldList) do
  begin
    g_ShopGoldList[i].Free;
  end;
  for I := Low(g_MakeMagicList) to High(g_MakeMagicList) do
    g_MakeMagicList[I].Free;
  g_ShopList[0].Free;
  g_ShopList[1].Free;
  g_WgHintList.Free;
  g_ShopBuyItem := nil;

  //g_ShowItemList := nil;
  //g_AutoPickupList.Free;
  //g_AutoPickupList := nil;
  g_FriendList.Free;
  g_MyWhisperList.Free;
  g_MyBlacklist.Free;
  //ClearItemRule();
  //g_ItemFiltrateList.Free;
  if g_ToolMenuHook <> 0 then
    UnhookWindowsHookEx(g_ToolMenuHook);
  //SoundCloseProc;
  //DXTimer.Enabled := FALSE;
  //TimerSocket.Enabled := FALSE;
  MinTimer.Enabled := FALSE;

  //UnLoadWMImagesLib();

  DScreen.Finalize;
  HintScene.Finalize;
  PlayScene.Finalize;
  //LoginNoticeScene.Finalize;

  DScreen.Free;
  //IntroScene.Free;
  LoginScene.Free;
  SelectChrScene.Free;
  PlayScene.Free;
  HintScene.Free;
  SelServer.Free;
  //LoginNoticeScene.Free;
  g_SaveItemList.Free;
  g_MenuItemList.Free;
  g_QuestMsgList.Free;

  DebugOutStr('----------------------- closed -------------------------');
  Map.Free;
  g_DropedItemList.Free;
  //g_MagicList.Free;
  g_FreeActorList.Free;
  g_FreeItemList.Free;
  g_ChangeFaceReadyList.Free;
  g_GuaJi.Free;
  g_LegendMap.Free;

  //if MainSurface <> nil then MainSurface.Free;

  g_Sound.Free;
  g_SoundList.Free;
  BGMusicList.Free;
  //DObjList.Free;
  EventMan.Free;

  g_DXSound.Free;
  g_DWinMan.Free;
  ClearStditemList();
  ClearMissionList();
  g_StditemList.Free;
  g_StditemFiltrateList.Free;

  DeleteCriticalSection(FCriticalSection);
  FrmDlg.Free;
  FrmDlg2.Free;
  FrmDlg3.Free;


  BASS_StreamFree(MusicHS);
  if MusicStream <> nil then
    MusicStream.Free;
  BASS_Free;
  FrmWeb.Free;
  FreeCheckDll;
  HGE.System_Shutdown;
  g_DXFont.Free;
  HGE := nil;
end;

function ComposeColor(Dest, Src: TRGBQuad; Percent: Integer): TRGBQuad;
begin
  with Result do
  begin
    rgbRed := Src.rgbRed + ((Dest.rgbRed - Src.rgbRed) * Percent div 256);
    rgbGreen := Src.rgbGreen + ((Dest.rgbGreen - Src.rgbGreen) * Percent div 256);
    rgbBlue := Src.rgbBlue + ((Dest.rgbBlue - Src.rgbBlue) * Percent div 256);
    rgbReserved := 0;
  end;
end;

    {
procedure TfrmMain.FullScreen(boFull: Boolean);
begin
  if g_boFullScreen <> boFull then begin
    TimerRun.Enabled := False;
    application.ProcessMessages;
    g_boFullScreen := boFull;
    if g_boFullScreen then begin
      DisplayChange(False);

      BorderStyle := bsNone;
      BorderIcons := [];

      ClientWidth := HGE.System_GetState(HGE_FScreenWidth);
      ClientHeight := HGE.System_GetState(HGE_FScreenHeight);
      WindowState := wsMaximized;



      m_Point.X := 0;
      m_Point.Y := 0;
    end else begin
      DisplayChange(True);

      BorderStyle := bsSingle;
      FormStyle := fsNormal;
      WindowState := wsNormal;
      ClientWidth := HGE.System_GetState(HGE_FScreenWidth);
      ClientHeight := HGE.System_GetState(HGE_FScreenHeight);
      BorderIcons := [biSystemMenu, biMinimize];
      Left := (Screen.width - ClientWidth) div 2;
      Top := (Screen.Height - ClientHeight) div 2 - 40;
      SetWindowPos(handle, HWND_NOTOPMOST, left, top, width, height, SWP_SHOWWINDOW);
    end;
    TimerRun.Enabled := True;
    Tag := 0;
  end;
end;
    }

procedure TfrmMain.MyDeviceNotifyEvent(Sender: TObject; Msg: Cardinal);
begin
  case Msg of
    msgDeviceLost:
    begin
      PlayScene.Lost;
      g_DXFont.Lost;
      DScreen.ClearHint(True);
      //DebugOutStr('DeviceLost');
    end;
    msgDeviceRecovered:
    begin
      PlayScene.Recovered;
      g_DXFont.Recovered;
      Map.m_OldClientRect := Rect(0, 0, 0, 0);
      DScreen.ClearHint(True);
      //DebugOutStr('DeviceRecovered');
    end;
    msgDeviceRestoreSize:
    begin
      ClientWidth := HGE.System_GetState(HGE_FScreenWidth);
      ClientHeight := HGE.System_GetState(HGE_FScreenHeight);
//        if g_boFullScreen then begin
//          if FIDDraw <> nil then begin
//            if ClientWidth = OLD_SCREEN_WIDTH then FIDDraw.SetDisplayMode(OLD_SCREEN_WIDTH, OLD_SCREEN_HEIGHT, 16)
//            else FIDDraw.SetDisplayMode(LARGE_SCREEN_WIDTH, LARGE_SCREEN_HEIGHT, 16);
//          end;
//          m_Point.X := 0;
//          m_Point.Y := 0;
//        end else begin
      Left := (Screen.Width - ClientWidth) div 2;
      Top := (Screen.Height - ClientHeight) div 2 - 40;
      // HWND_NOTOPMOST 值为-2，将窗口置于所有非顶层窗口之上（即在所有顶层窗口之后）。如果窗口已经是非顶层窗口则该标志不起作用。
      // SWP_SHOWWINDOW：显示窗口
      SetWindowPos(handle, HWND_NOTOPMOST, left, top, width, height, SWP_SHOWWINDOW);
//        end;
    end;
  end;
end;

procedure TfrmMain.DXDrawFinalize(Sender: TObject);
begin
  (* TimerRun.Enabled := False;
   if g_boChangeWindow then begin
     UnLoadWMImagesLibEx();
     g_DWinMan.CloseSurface;
     ClearActorSurface();
     ClearItemSurface();
     ClearSaySurface;
     DScreen.Finalize;
     DScreen.ClearHint(True);
     PlayScene.Finalize;
     g_ImgMixSurface.Free;
     g_ImgMixSurface := nil;
     g_MiniMapSurface.Free;
     g_MiniMapSurface := nil;
     g_nMiniMapOldX := -1;
     if FrmDlg2.HDInfoSurface <> nil then begin
       FrmDlg2.HDInfoSurface.Free;
       FrmDlg2.HDInfoSurface := nil;
     end;
     if FrmDlg.MyHDInfoSurface <> nil then begin
       FrmDlg.MyHDInfoSurface.Free;
       FrmDlg.MyHDInfoSurface := nil;
     end;
     if FrmDlg.UserHDInfoSurface <> nil then FrmDlg.UserHDInfoSurface.Free;
     FrmDlg.UserHDInfoSurface := nil;
     {if FrmDlg.m_DMsgSurface <> nil then
       FrmDlg.m_DMsgSurface.Free;
     FrmDlg.m_DMsgSurface := nil; }
     Map.m_OldClientRect := Rect(0, 0, 0, 0);
   end;   *)
end;

type
  TInt64Decompose = packed record
  case Integer of
    1: (
        nInt64: Int64;
      );
    2: (
        nInteger1: Integer;
        nInteger2: Integer;
      );
  end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  ErrorMsg: string;
  Int64Decompose: TInt64Decompose;
  MemoryStatus: TMemoryStatus;
  Reg: TRegistry;
  VersionInfo: TosversionInfo;
  DI: TD3DAdapterIdentifier8;
  D3D: IDirect3D8;
{$IFNDEF DEBUG}
  nCount: Integer;
{$ENDIF}
begin
  if g_boFirstTime then
  begin
    g_boFirstTime := FALSE;
    if not CheckMirDir(ExtractFilePath(Application.ExeName), True) then
    begin
{$IFDEF RELEASE}
      {$IF Public_Ver = Public_Test}
      Application.MessageBox('缺少必要的补丁文件，无法运行！', '提示信息', MB_OK + MB_ICONSTOP);
      {$IFEND}
{$ENDIF}
      Close;
      exit;
    end;
// 非调试模式，从跳转过来的自由登录器获取服务信息
{$IFNDEF DEBUG}
    g_ServerInfoCount := 0;
    g_Login_Index := 0;
    g_boSQLReg := g_sMainParam2 = '1';
    if g_Login_Handle <> 0 then
    begin

      nCount := SendMessage(g_Login_Handle, WM_GETSERVERLIST, Handle, 0);
      g_ServerInfoCount := SmallInt(LoWord(nCount));
      g_Login_Index := SmallInt(HiWord(nCount));
    end;
    if (g_ServerInfoCount <= 0) or (g_Login_Index < 0) then
    begin
      Close;
      exit;
    end;
{$ELSE}
    g_ServerInfoCount := 0;
    g_Login_Index := 0;
    g_boSQLReg := False;
    g_ServerInfoCount := 4;
    g_ServerInfo[0].sName := '单机-127';
    g_ServerInfo[0].sAddrs := '127.0.0.1';
    g_ServerInfo[0].sPort := '7000';
    g_ServerInfo[1].sName := '兰达尔第一季v1.0';
//    g_ServerInfo[1].sAddrs := '121.37.13.127';
    g_ServerInfo[1].sAddrs := '47.106.84.184';
    g_ServerInfo[1].sPort := '7000';
{$ENDIF}

    if not BASS_Init(-1, 44100, 0, 0, nil) then
      Application.MessageBox(PCHar('游戏音频初始化失败，将无法播放背景音乐'), '提示信息', MB_OK + MB_ICONSTOP);

    if not HGE.System_Initiate then
    begin
      ErrorMsg := '----------------错误信息--------------------' + #13#10;
      ErrorMsg := ErrorMsg + HGE.System_GetErrorMessage + #13#10;
      ErrorMsg := ErrorMsg + #13#10;
      ErrorMsg := ErrorMsg + '----------------系统信息--------------------' + #13#10;
      VersionInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
      Reg := TRegistry.Create;
      if Windows.GetVersionEx(VersionInfo) then
      begin
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        case VersionInfo.dwPlatformId of
          VER_PLATFORM_WIN32s:
          begin

          end;
          VER_PLATFORM_WIN32_WINDOWS:
          begin
            if Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion', False) then
            begin
              ErrorMsg := ErrorMsg + '操作系统：' + Reg.ReadString('ProductName') + #13#10;
            end;
            Reg.CloseKey;
          end;
          VER_PLATFORM_WIN32_NT:
          begin
            if Reg.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion', False) then
            begin
              ErrorMsg := ErrorMsg + '操作系统：' + Reg.ReadString('ProductName') + #13#10;
            end;
            Reg.CloseKey;
          end;
          VER_PLATFORM_WIN32_CE:
          begin

          end;
        end;
        ErrorMsg := ErrorMsg + '系统版本：' + Format('%d.%d.%d', [VersionInfo.dwMajorVersion, VersionInfo.dwMinorVersion, VersionInfo.dwBuildNumber]) + #13#10;
        ErrorMsg := ErrorMsg + '补丁版本：' + VersionInfo.szCSDVersion + #13#10;
        if Reg.OpenKey('SOFTWARE\Microsoft\DirectX', False) then
        begin
          ErrorMsg := ErrorMsg + 'DirectX ：' + Reg.ReadString('Version') + #13#10;
        end;
        Reg.CloseKey;
      end;
      Reg.Free;

      D3D := Direct3DCreate8(D3D_SDK_VERSION);
      if D3D <> nil then
      begin
        Try
          D3D.GetAdapterIdentifier(D3DADAPTER_DEFAULT, D3DENUM_NO_WHQL_LEVEL, DI);
        Except
        End;
        ErrorMsg := ErrorMsg + #13#10;
        ErrorMsg := ErrorMsg + '----------------显卡信息--------------------' + #13#10;
        ErrorMsg := ErrorMsg + '显卡名称：' + DI.Description + #13#10;
        ErrorMsg := ErrorMsg + '驱动程序：' + DI.Driver + #13#10;
        Int64Decompose.nInteger1 := DI.DriverVersionLowPart;
        Int64Decompose.nInteger2 := DI.DriverVersionHighPart; ;
        ErrorMsg := ErrorMsg + Format('驱动版本：%d.%d.%d.%d', [
      HiWord(Int64Decompose.nInteger2),
      LoWord(Int64Decompose.nInteger2),
      HiWord(Int64Decompose.nInteger1),
      LoWord(Int64Decompose.nInteger1)]) + #13#10;

        ErrorMsg := ErrorMsg + '可用显存：' + IntToStr(HGE.AvailableTextureMem div 1024 div 1024) + 'M' + #13#10;
        ErrorMsg := ErrorMsg + '纹理大小：' + IntToStr(HGE.D3DCaps.MaxTextureWidth) + '*' + IntToStr(HGE.D3DCaps.MaxTextureHeight) + #13#10;
      end;
      D3D := nil;
      SafeFillChar(MemoryStatus, SizeOf(MemoryStatus), #0);
      MemoryStatus.dwLength := SizeOf(TMemoryStatus);
      GlobalMemoryStatus(MemoryStatus);
      ErrorMsg := ErrorMsg + #13#10;
      ErrorMsg := ErrorMsg + '----------------内存信息--------------------' + #13#10;
      ErrorMsg := ErrorMsg + '物理内存：' + intToStr(MemoryStatus.dwTotalPhys div 1024 div 1024) + 'M' + #13#10;
      ErrorMsg := ErrorMsg + '可用物理内存：' + intToStr(MemoryStatus.dwAvailPhys div 1024 div 1024) + 'M' + #13#10;
      ErrorMsg := ErrorMsg + '虚拟内存：' + intToStr(MemoryStatus.dwTotalVirtual div 1024 div 1024) + 'M' + #13#10;
      ErrorMsg := ErrorMsg + '可用虚拟内存：' + intToStr(MemoryStatus.dwAvailVirtual div 1024 div 1024) + 'M' + #13#10;
      CopyStrToClipboard(ErrorMsg);
      ErrorMsg := ErrorMsg + #13#10;
      ErrorMsg := ErrorMsg + '请使用 Ctrl + V 粘贴以上信息发送给游戏管理员        ';
      //Visible := False;
      Application.MessageBox(PCHar(ErrorMsg), '游戏初始化失败', MB_OK + MB_ICONSTOP);
      close;
      HGE.System_Shutdown;
      Exit;
    end;
    // 回调 MinTimerTimer 函数
    MinTimer.Enabled := True;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DisplayChange(True);
  if g_sExitUrl <> '' then
    ShellExecute(Handle, 'Open', PChar(g_sExitUrl), '', '', SW_SHOW);
{$IFDEF RELEASE}
  if g_Login_Handle <> 0 then
  SendMessage(g_Login_Handle, WM_CHECK_CLIENT, Handle, MakeLong(MSG_CHECK_CLIENT_EXIT, g_Login_Index));
{$ENDIF}
  SaveIDInfo();
  SaveHumInfo(CharName);
  ClearBGMEx;
  if g_boAllLoadStream then
  begin
    Try
      g_MissionDateStream.SaveToFile(GETMISSIONDESCFILE);
    Except
    End;
    Try
      g_StditemsDateStream.SaveToFile(GETSTDITEMSDESCFILE);
    Except
    End;
    Try
      g_MagicDateStream.SaveToFile(GETMAGICDESCFILE);
    Except
    End;
    Try
      g_MapDescDateStream.SaveToFile(GETMAPDESCFILE);
    Except
    End;
    Try
      g_MakeMagicDateStream.SaveToFile(GETMAKEMAGICFILE);
    Except
    End;

  end;

  //Savebags ('.\Data\' + ServerName + '.' + CharName + '.itm', @ItemArr);
  //DxTimer.Enabled := FALSE;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (not g_boQueryExit) and (g_MySelf <> nil) then
  begin
    CanClose := False;
    AppExit;
  end
  else begin
    TimerRun.Enabled := False;
    //HGE.System_Shutdown;
  end;
end;

{------------------------------------------------------------}
{
procedure TfrmMain.ProcOnIdle;
var
  Deon: Boolean;
begin
  AppOnIdle(Self, Deon);
  //DXTimerTimer (self, 0);
end;             }

procedure TfrmMain.OnIdle(Sender: TObject; var Done: Boolean);
begin
  Done := True;
  //Timer2.Enabled := True;
  Application.OnIdle := nil;
end;

procedure TfrmMain.MyDeviceRender(Sender: TObject);
procedure RefInitialize(MinImage, Pointer, Len: Integer);
var
  d: TDirectDrawSurface;
  rc: TRect;
begin
  d := g_WMain99Images.Images[MinImage];
  if d <> nil then
    g_DXCanvas.Draw(0, 0, d.ClientRect, d, True);

  d := g_WMain99Images.Images[7];
  if d <> nil then
    g_DXCanvas.Draw(102, 450 + Pointer, d.ClientRect, d, True);

  d := g_WMain99Images.Images[8];
  if d <> nil then
  begin
    rc := d.ClientRect;
    rc.Right := Trunc(d.Width * (len / 100));
    g_DXCanvas.Draw(108, 457 + Pointer, rc, d, True);
  end;
end;
// 游戏 LOGO 界面初始化
procedure LogoInitialize(MinImage: Integer);
var
  d: TDirectDrawSurface;
  x, y: Integer;
begin
  if g_LogoSurface <> nil then
  begin
    x := getLayoutX(g_LogoSurface.Width);
    y := getLayoutY(g_LogoSurface.Height);
    if FnShowLogoIndex < 256 then
    begin
      // 绘制居中的 LOGO 图片
      g_DXCanvas.Draw(x, y, g_LogoSurface.ClientRect, g_LogoSurface, True, cColor4($FFFFFF or (FnShowLogoIndex shl 24)));
    end else if FnShowLogoIndex < 400 then
    begin
      // 绘制居中的 LOGO 图片
      g_DXCanvas.Draw(x, y, g_LogoSurface.ClientRect, g_LogoSurface, True);
    end else if FnShowLogoIndex < 626 then
    begin
      d := g_WMain99Images.Images[MinImage];
      if d <> nil then
      begin
        // 先绘制整个客户端界面的背景图片
        g_DXCanvas.Draw(0, 0, d.ClientRect, d, True, cColor4($FFFFFF or ((FnShowLogoIndex - 400) shl 24)));
      end;
      // 再绘制居中的 LOGO 图片
      g_DXCanvas.Draw(x, y, g_LogoSurface.ClientRect, g_LogoSurface, True, cColor4($FFFFFF or ((655 - FnShowLogoIndex) shl 24)));
    end else begin
      d := g_WMain99Images.Images[MinImage];
      if d <> nil then
        g_DXCanvas.Draw(0, 0, d.ClientRect, d, True);
      FBoShowLogo := True;
    end;
  end else FBoShowLogo := True;
end;

var
  d: TDirectDrawSurface;
  p: TPoint;
begin
  if not FBoShowLogo then
  begin
    LogoInitialize(Resource.LOGINBAGIMGINDEX);
  end
  else if g_boMapInitialize or g_boMapApoise then
  begin
    RefInitialize(303, 110, g_btMapinitializePos);
  end
  else if not g_boInitialize then
  begin
    ProcessFreeTexture;
    ProcessKeyMessages;
    ProcessActionMessages;
    if DScreen.CurrentScene = PlayScene then
    begin
      {if (g_MySelf <> nil) and g_MySelf.m_boDeath then
      MyDevice.Canvas.Draw(SOFFX, SOFFY, PlayScene.m_MagSurface.ClientRect, PlayScene.m_MagSurface, True, clRed4)
    else  }
      g_DXCanvas.Draw(SOFFX, SOFFY, PlayScene.m_MagSurface.ClientRect, PlayScene.m_MagSurface, True);
    end;
    DScreen.DrawScreen(g_DXCanvas.DrawTexture);
    if g_boCanDraw then
    begin
      g_DWinMan.DirectPaint(g_DXCanvas.DrawTexture);
      DScreen.DrawScreenTop(g_DXCanvas.DrawTexture);
      //if g_boCtrlDown then
      // g_DXCanvas.FillRect(0, 0, 800, 600, $FF000000);
      DScreen.DrawHint(g_DXCanvas.DrawTexture);

      if g_boItemMoving and g_boCanDraw then
      begin
        GetCursorPos(p);
        p.X := p.X - m_Point.X;
        p.Y := p.Y - m_Point.Y;
        if g_MovingItem.ItemType = mtBottom then
        begin
          case LoWord(g_MovingItem.Index2) of
            UKTYPE_ITEM:
            begin
              d := GetBagItemImg(g_MovingItem.Item.S.looks);
              if d <> nil then
              begin
                FrmDlg.RefItemPaint(g_DXCanvas.DrawTexture, d,
                                     p.X - (d.ClientRect.Right div 2),
                                     p.Y - (d.ClientRect.Bottom div 2),
                                     p.X - (d.ClientRect.Right div 2) + 34,
                                     p.Y - (d.ClientRect.Bottom div 2) + 18,
                                     @g_MovingItem.Item, False);
              end;
            end;
            UKTYPE_MAGIC:
            begin
              d := g_WMagIconImages.Images[g_MovingItem.Item.S.looks];
              if d <> nil then
                g_DXCanvas.Draw(p.X - d.Width div 2, p.Y - d.Height div 2, d.ClientRect, d, True);
            end;
          end;
        end
        else if g_MovingItem.ItemType = mtStateMagic then
        begin
          d := g_WMagIconImages.Images[HiWord(g_MovingItem.Index2)];
          if d <> nil then
          begin
            g_DXCanvas.Draw(p.X - d.Width div 2, p.Y - d.Height div 2, d.ClientRect, d, True);
          end;
        end
        else if (g_MovingItem.Item.S.name <> g_sGoldName {'金币'}) then
        begin
          d := GetBagItemImg(g_MovingItem.Item.S.looks);
          if d <> nil then
          begin
            FrmDlg.RefItemPaint(g_DXCanvas.DrawTexture, d,
                                 p.X - (d.ClientRect.Right div 2),
                                 p.Y - (d.ClientRect.Bottom div 2),
                                 p.X - (d.ClientRect.Right div 2) + 34,
                                 p.Y - (d.ClientRect.Bottom div 2) + 18,
                                 @g_MovingItem.Item, False);
          end;
        end
        else begin
          d := GetBagItemImg(115); //金币外形
          if d <> nil then
          begin
            g_DXCanvas.Draw(p.X - (d.ClientRect.Right div 2),
                             p.Y - (d.ClientRect.Bottom div 2),
                             d.ClientRect,
                             d,
                             True);
          end;
        end;
      end;
      if g_boShowFormImage then
      begin
        d := g_WMain99Images.Images[g_boShowFormIndex];
        if d <> nil then
        begin
          g_DXCanvas.Draw(g_FScreenXOrigin - d.Width div 2, g_FScreenYOrigin - d.Height div 2, d.ClientRect, d, True);
        end else
          g_boShowFormImage := False;
      end;
    end;
  end
  else
    RefInitialize(Resource.LOGINBAGIMGINDEX, 60, g_nInitializePer);
end;

procedure TfrmMain.AppOnIdle(boInitialize: Boolean = False);
var
  CanDraw: Boolean;
begin
  CanDraw := HGE.Gfx_CanBegin();
  g_boCanDraw := CanDraw and (not boSizeMove);

  if MusicHS >= BASS_ERROR_ENDED then
  begin
    if boInFocus and g_boCanDraw then
    begin
      if BASS_ChannelIsActive(MusicHS) = BASS_ACTIVE_PAUSED then
      begin
        ChangeBGMState(bgmPlay);
      end;
      g_boCanSound := True;
    end
    else begin
      if BASS_ChannelIsActive(MusicHS) = BASS_ACTIVE_PLAYING then
      begin
        ChangeBGMState(bgmPause);
      end;
      g_boCanSound := False;
      SilenceSound;
    end;
  end;

  if not FboShowLogo then
  begin
    if g_boCanDraw then
    begin
      HGE.Gfx_BeginScene;
      HGE.Gfx_Clear($FF222222);
      HGE.RenderBatch;
      MyDeviceRender(nil);
      HGE.Gfx_EndScene;
    end;
  end else if g_boMapInitialize or g_boMapApoise then
  begin
    if g_boCanDraw then
    begin
      HGE.Gfx_BeginScene;
      HGE.Gfx_Clear(0);
      HGE.RenderBatch;
      MyDeviceRender(nil);
      HGE.Gfx_EndScene;
    end;
  end else if not boInitialize then
  begin
    if DScreen.CurrentScene = PlayScene then
    begin
      PlayScene.BeginScene; //DebugOutStr('106');

      if g_boCanDraw then
      begin
        if PlayScene.CanDrawTileMap then
        begin
          HGE.Gfx_BeginScene(PlayScene.m_MapSurface.Target);
          HGE.Gfx_Clear(0);
          HGE.RenderBatch;
          PlayScene.DrawTileMap(nil);
          HGE.Gfx_EndScene;
        end;
        if PlayScene.m_boPlayChange then
        begin
          HGE.Gfx_BeginScene(PlayScene.m_ObjSurface.Target);
          HGE.Gfx_Clear(0);
          HGE.RenderBatch;
          PlayScene.PlaySurface(nil);
          HGE.Gfx_EndScene;
        end;
        HGE.Gfx_BeginScene(PlayScene.m_MagSurface.Target);
        HGE.Gfx_Clear(0);
        HGE.RenderBatch;
        PlayScene.MagicSurface(nil);
        HGE.Gfx_EndScene;
      end;
    end;
    if g_boCanDraw then
    begin
      HGE.Gfx_BeginScene;
      HGE.Gfx_Clear(0);
      HGE.RenderBatch;
      MyDeviceRender(nil);
      HGE.Gfx_EndScene;
    end;
  end else begin
    if g_boCanDraw then
    begin
      HGE.Gfx_BeginScene;
      HGE.Gfx_Clear(0);
      HGE.RenderBatch;
      MyDeviceRender(nil);
      HGE.Gfx_EndScene;
    end;
  end;

  if g_MySelf <> nil then
  begin
    if boCheckSpeed and (GetTickCount > CheckSpeedTick) then
    begin
      boCheckSpeed := False;
      SendSocketEx(g_ClientCheck);
    end;
  end;
end;

procedure TfrmMain.AppLogout;
begin
  if g_boQueryExit then
    exit;
  g_boQueryExit := True;
  try
    if mrOk = FrmDlg.DMessageDlg('你是否要退出游戏，切换到选择人物界面?', [mbOk, mbCancel]) then
    begin

      //SendGameSetupInfo;
      SendClientMessage(CM_SOFTCLOSE, 0, 0, 0, 0);
      ResetGameVariables;
      FrmDlg.HintBack := stSelectChr;
      FrmDlg.sHintStr := '正在保存游戏设置，请稍候。。。';
      FrmDlg.DBTHintClose.Caption := '取消';
      FrmDlg.boHintFocus := False;
      DScreen.ChangeScene(stHint);
      FrmDlg.DBTHintClose.Visible := False;
      g_SoftClosed := True;
      ActiveCmdTimer(tcSoftClose);
      //PlayBGM(bmg_SelChr);
    end;
  finally
    g_boQueryExit := False;
  end;
end;

procedure TfrmMain.AppExit;
begin
  if g_boQueryExit then
    exit;
  g_boQueryExit := True;
  try
    if mrOk = FrmDlg.DMessageDlg('你是否确定要退出游戏吗？', [mbOk, mbCancel]) then
    begin
      CloseAllWindows;
      //SendClientSocket(CM_USERKEYSETUP, 0, 0, 0, 0, EncodeBuffer(@g_UserKeySetup, SizeOf(g_UserKeySetup)));
      //SendGameSetupInfo;
      //SendClientMessage(CM_SOFTCLOSE, 0, 0, 0, 0);
      SaveIDInfo();
      SaveHumInfo(CharName);
      FrmDlg.HintBack := stSelectChr;
      FrmDlg.sHintStr := '正在保存游戏设置，请稍候。。。';
      FrmDlg.DBTHintClose.Caption := '取消';
      FrmDlg.boHintFocus := False;
      DScreen.ChangeScene(stHint);
      FrmDlg.DBTHintClose.Visible := False;
      m_boExit := True;
      ActiveCmdTimer(tcSoftClose);
      //PlayBGM(bmg_SelChr);
    end;
  finally
    g_boQueryExit := False;
  end;
  {if g_boQueryExit then
    exit;
  g_boQueryExit := True;
  try
    if mrOk = FrmDlg.DMessageDlg('你真的要退出游戏吗?', [mbOk, mbCancel]) then begin
      SendClientSocket(CM_USERKEYSETUP, 0, 0, 0, 0, EncodeBuffer(@g_UserKeySetup, SizeOf(g_UserKeySetup)));
      SendGameSetupInfo;
      SaveIDInfo();
      SaveHumInfo(CharName);
      frmMain.Close;
    end;
  finally
    g_boQueryExit := False;
  end;  }
end;

procedure TfrmMain.PrintScreenNow;
procedure BitmapBoldTextOut(Canvas: TCanvas; x, y, fcolor, bcolor: integer; str: string);
var
  nLen: Integer;
  ChrBuff: PChar;
begin
  if str = '' then
    Exit;
  nLen := Length(str);
  GetMem(ChrBuff, nLen);
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
  FreeMem(ChrBuff);
end;

function IntToStr2(n: Integer): string;
begin
  if n < 10 then
    Result := '0' + IntToStr(n)
  else
    Result := IntToStr(n);
end;

var
  //  i, n: Integer;
  flname, Dirname: string;
  //DIB: TDIB;
  //ddsd: TDDSurfaceDesc;
//  sptr, dptr: PChar;
  JPG: TJPEGImage;
  BItmap: TBitmap;
  //PrevTarget, Offscreen: IDirect3DSurface9;
//  DRect: TRect;
  Surf: IDirect3DSurface8;
  //Y,
  n: Integer;
{var
  Surf, Dest: IDirect3DSurface8;
  Desc : TD3DSurface_Desc;  }
begin
  //PlaySoundEx(bmg_Camera);
  //HGE.Target_GetTexture()
  {Surf.GetDesc(Desc);
  HGE.GetD3DDevice.GetBackBuffer(0, D3DBACKBUFFER_TYPE_MONO, Surf);
  D3DXSaveSurfaceToFile('D:\Temp.bmp', D3DXIFF_BMP, Dest, nil, nil);
  Surf := nil;
  Dest := nil;  }

  PlaySoundEx(bmg_Camera);
  if (HGE = nil) or (HGE.GetD3DDevice = nil) then
    exit;

  Dirname := GetCurrentDir;
  if Copy(Dirname, Length(Dirname), 1) <> '\' then
    Dirname := Dirname + '\';
  Dirname := Dirname + '游戏截图\';
  if not DirectoryExists(Dirname) then
    CreateDir(Dirname);
  while True do
  begin
    flname := Dirname + 'Images' + IntToStr2(g_nCaptureSerial) + '.jpg';
    if not FileExists(flname) then
      break;
    Inc(g_nCaptureSerial);
  end;

  HGE.GetD3DDevice.GetBackBuffer(0, D3DBACKBUFFER_TYPE_MONO, Surf);
  D3DXSaveSurfaceToFile(PChar(flname), D3DXIFF_BMP, Surf, nil, nil);
  Bitmap := TBitmap.Create;
  JPG := TJPEGImage.Create;
  Try
    Bitmap.LoadFromFile(flname);
    Bitmap.Canvas.Font.Name := '宋体';
    Bitmap.Canvas.Font.Size := 9;
    n := 0;
    SetBkMode(Bitmap.Canvas.Handle, TRANSPARENT);
    BitmapBoldTextOut(Bitmap.Canvas, 2, 2, clWhite, clBlack, 'AppleM2');
    if g_MySelf <> nil then
    begin
      BitmapBoldTextOut(Bitmap.Canvas, 2, 14, clWhite, clBlack, g_MySelf.m_UserName);
      BitmapBoldTextOut(Bitmap.Canvas, 2, 14 + 12, clWhite, clBlack, g_sServerName);
      Inc(n, 2);
    end;
    BitmapBoldTextOut(Bitmap.Canvas, 2, 14 + n * 12, clWhite, clBlack, FormatDateTime('YYYY-MM-DD HH:MM:SS', Now));
    JPG.Assign(Bitmap); //FormatDateTime('YYYY-MM-DD HH:MM:SS', Now)
    Jpg.CompressionQuality := 100;
    Jpg.SaveToFile(flname);
      //Bitmap.SaveToFile(flname);
    Bitmap.Free;
    JPG.Free;
    Bitmap := nil;
    JPG := nil;
      //Bitmap.SaveToFile(flname);
    if boShowPrintMsg then
      DScreen.AddSysMsg('[截图保存位置：' + flname + ']', clWhite);
  Finally
    if Bitmap <> nil then
      Bitmap.Free;
    if JPG <> nil then
      JPG.Free;
  End;

  (*try
    if not Succeeded(Direct3DDevice.CreateOffscreenPlainSurface(PresentParams.BackBufferWidth,
      PresentParams.BackBufferHeight, PresentParams.BackBufferFormat, D3DPOOL_SYSTEMMEM, PrevTarget, nil)) then
      Exit;

    DRect := Rect(0, 0, PresentParams.BackBufferWidth, PresentParams.BackBufferHeight);

    if not Succeeded(Direct3DDevice.GetBackBuffer(0, 0, D3DBACKBUFFER_TYPE_MONO, Offscreen)) then
      Exit;
    if not Succeeded(Direct3DDevice.GetRenderTargetData(Offscreen, PrevTarget)) then
      Exit;

    if Succeeded(PrevTarget.LockRect(LockedRect, nil, D3DLOCK_READONLY)) then begin
      Bitmap := TBitmap.Create;
      JPG := TJPEGImage.Create;
      ImageBuffer := nil;
      try
        Dirname := GetCurrentDir;
        if Copy(Dirname, Length(Dirname), 1) <> '\' then
          Dirname := Dirname + '\';
        Dirname := Dirname + '游戏截图\';
        if not DirectoryExists(Dirname) then
          CreateDir(Dirname);
        while True do begin
          flname := Dirname + 'Images' + IntToStr2(g_nCaptureSerial) + '.jpg';
          if not FileExists(flname) then
            break;
          Inc(g_nCaptureSerial);
        end;
        Bitmap.Width := PresentParams.BackBufferWidth;
        Bitmap.Height := PresentParams.BackBufferHeight;
        Bitmap.Canvas.Font.Name := '宋体';
        Bitmap.Canvas.Font.Size := 9;
        case D3DDataSize(PresentParams.BackBufferFormat) of
          1: begin
              Bitmap.PixelFormat := pf8bit;
              SetDIBColorTable(Bitmap.Canvas.Handle, 0, 256, g_ColorTable);
              for Y := 0 to Bitmap.Height - 1 do begin
                ReadBuffer := PChar(Integer(LockedRect.pBits) + LockedRect.Pitch * Y);
                WriteBuffer := Bitmap.ScanLine[Y];
                Move(ReadBuffer^, WriteBuffer^, LockedRect.Pitch);
              end;
            end;
          2: begin
              case PresentParams.BackBufferFormat of
                D3DFMT_X1R5G5B5: Bitmap.PixelFormat := pf15bit;
                D3DFMT_R5G6B5: Bitmap.PixelFormat := pf16bit;
              else
                exit;
              end;
              for Y := 0 to Bitmap.Height - 1 do begin
                ReadBuffer := PChar(Integer(LockedRect.pBits) + LockedRect.Pitch * Y);
                WriteBuffer := Bitmap.ScanLine[Y];
                Move(ReadBuffer^, WriteBuffer^, LockedRect.Pitch);
              end;
            end;
          {3: begin
            Bitmap.PixelFormat := pf24bit;
            for Y := 0 to Bitmap.Height - 1 do begin
              RGBQuadBuffer := PRGBQuad(Integer(LockedRect.pBits) + LockedRect.Pitch * Y);
              RGBTripleBuffer := Bitmap.ScanLine[Y];
              for X := 0 to Bitmap.Width - 1 do begin
                RGBTripleBuffer.rgbtRed := RGBQuadBuffer.rgbRed;
                RGBTripleBuffer.rgbtGreen := RGBQuadBuffer.rgbGreen;
                RGBTripleBuffer.rgbtBlue := RGBQuadBuffer.rgbBlue;
                Inc(RGBQuadBuffer);
                Inc(RGBTripleBuffer);
              end;
            end;
          end; }
          3, 4: begin
              Bitmap.PixelFormat := pf32bit;
              for Y := 0 to Bitmap.Height - 1 do begin
                ReadBuffer := PChar(Integer(LockedRect.pBits) + LockedRect.Pitch * Y);
                WriteBuffer := Bitmap.ScanLine[Y];
                Move(ReadBuffer^, WriteBuffer^, LockedRect.Pitch);
              end;
            end;
        end;
      finally
        PrevTarget.UnlockRect;
        n := 0;
        SetBkMode(Bitmap.Canvas.Handle, TRANSPARENT);
        if g_MySelf <> nil then begin
          BitmapBoldTextOut(Bitmap.Canvas, 2, 2, clWhite, clBlack, g_MySelf.m_UserName);
          BitmapBoldTextOut(Bitmap.Canvas, 2, 2 + 12, clWhite, clBlack, g_sServerName);
          Inc(n, 2);
        end;
        BitmapBoldTextOut(Bitmap.Canvas, 2, 2 + n * 12, clWhite, clBlack, FormatDateTime('YYYY-MM-DD HH:MM:SS', Now));
        JPG.Assign(Bitmap); //FormatDateTime('YYYY-MM-DD HH:MM:SS', Now)
        Jpg.CompressionQuality := 100;
        Jpg.SaveToFile(flname);
        //Bitmap.SaveToFile(flname);
        Bitmap.Free;
        JPG.Free;
        //Bitmap.SaveToFile(flname);
        if ImageBuffer <> nil then
          FreeMem(ImageBuffer);
        PrevTarget := nil;
        DScreen.AddSysMsg('[截图保存位置：' + flname + ']', clWhite);
      end;
    end;
  finally
    PrevTarget := nil;
    Offscreen := nil;
  end;   *)
end;

{------------------------------------------------------------}

procedure TfrmMain.ProcessKeyMessages;
var
  nKey: Integer;
  nMagID: Integer;
begin
  if g_MySelf = nil then
    exit;

  nKey := ActionKey - 1;
  if nKey in [Low(g_UserKeySetup)..High(g_UserKeySetup)] then
  begin
{$IF Var_Interface = Var_Default}
    if (g_UserKeySetup[nKey].btType = UKTYPE_MAGIC) and (g_MySelf.m_btHorse = 0) then
    begin
      if ((GetTickCount - g_dwLatestSpellTick) > g_dwMagicDelayTime) then
      begin
        nMagID := g_UserKeySetup[nKey].wIndex;
        if (nMagID > 0) and (nMagID < SKILL_MAX) then
        begin
          if g_MyMagicArry[nMagID].boStudy and (not g_MyMagicArry[nMagID].boNotUse) then
          begin
            if (GetTickCount > g_MyMagicArry[nMagID].dwInterval) then
            begin
              UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[nMagID]); //胶农赴 谅钎
              ActionKey := 0;
              g_nTargetX := -1;
            end else begin
              if GetTickCount > FShowHintTick then
              begin
                FShowHintTick := GetTickCount + 2000;
                DScreen.AddSysMsg('[技能尚未恢复]', cllime);
              end;
            end;
          end;
        end;
      end;
      //FShowHintTick := 0;
      //FShowHintTick2 := 0;
    end else
{$IFEND}
      if g_UserKeySetup[nKey].btType = UKTYPE_ITEM then
      begin
        nMagID := GetBagItemIdx(g_UserKeySetup[nKey].wIndex);
        if nMagID <> -1 then
        begin
          EatItem(nMagID)
        end else begin
          if GetTickCount > FShowHintTick2 then
          begin
            FShowHintTick2 := GetTickCount + 2000;
            DScreen.AddSysMsg('[' + GetStditem(g_UserKeySetup[nKey].wIndex).Name + ' 已经用完]', clYellow);
          end;
        end;
      end;
    ActionKey := 0;
  end else begin
{$IF Var_Interface = Var_Mir2}
    nKey := -ActionKey;
    if (nKey > 0) and ((GetTickCount - g_dwLatestSpellTick) > g_dwMagicDelayTime) then
    begin
      nMagID := GetMagIDByKey(nKey);
      if (nMagID > 0) and (nMagID < SKILL_MAX) then
      begin
        if g_MyMagicArry[nMagID].boStudy and (not g_MyMagicArry[nMagID].boNotUse) then
        begin
          if (GetTickCount > g_MyMagicArry[nMagID].dwInterval) then
          begin
            UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[nMagID]); //胶农赴 谅钎
            ActionKey := 0;
            g_nTargetX := -1;
          end else begin
            if GetTickCount > FShowHintTick then
            begin
              FShowHintTick := GetTickCount + 2000;
              DScreen.AddSysMsg('[技能尚未恢复]', cllime);
            end;
          end;
        end;
      end;
    end;
    ActionKey := 0;
{$IFEND}
  end;
end;

//自动移动

procedure TfrmMain.GetAutoMovingXY();
var
  I: Integer;
  Actor: TActor;
  Count: Integer;
  ni: Integer;
//  boAbout: Boolean;
label
LB_WALK, LB_STOP;
begin
  if g_MySelf = nil then exit;
  Count := 0;
  LB_WALK: if g_boNpcMoveing and (abs(g_MySelf.m_nCurrX - g_nScriptGotoX) <= 2) and
(abs(g_MySelf.m_nCurrY - g_nScriptGotoY) <= 2) and
(not PlayScene.CanWalkEx2(g_nScriptGotoX, g_nScriptGotoY)) then
begin
  GotoClickNpc(g_nScriptGotoX, g_nScriptGotoY);
  g_nMiniMapPath := nil;
  g_boAutoMoveing := False;
  g_boNpcMoveing := False;
  g_nMiniMapMoseX := -1;
  g_nMiniMapMoseY := -1;
  g_nMiniMapPath := nil;
  exit;
end;
  //g_nMiniMapPath := nil;
  if High(g_nMiniMapPath) >= 0 then
  begin
    for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do
    begin
      if (g_MySelf.m_nCurrX = g_nMiniMapPath[i].X) and (g_MySelf.m_nCurrY = g_nMiniMapPath[i].Y) then
      begin
        DynArrayDelete(g_nMiniMapPath, SizeOf(TPoint), 0, I + 1);
        break;
      end;
    end;
    if High(g_nMiniMapPath) < 0 then
    begin
      goto LB_STOP;
    end;
    //骑马行走
    if g_MySelf.m_btHorse <> 0 then
    begin
      nI := 0;
      for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do
      begin
        if CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) and
        PlayScene.CanHorseRunEx(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) and
        (GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) = 3) then
        begin
          g_ChrAction := caRun;
          g_nTargetX := g_nMiniMapPath[i].X;
          g_nTargetY := g_nMiniMapPath[i].Y;
          exit;
        end;
        Inc(nI);
        if nI >= 10 then
          break;
      end;

      if (High(g_nMiniMapPath) >= 2) and
      CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[2].X, g_nMiniMapPath[2].Y) then
      begin
        g_ChrAction := caRun;
        g_nTargetX := g_nMiniMapPath[2].X;
        g_nTargetY := g_nMiniMapPath[2].Y;
        if (not PlayScene.CanHorseRunEx(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nTargetX, g_nTargetY)) or
        (GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nTargetX, g_nTargetY) <= 2) then
        begin
          g_ChrAction := caWalk;
          g_nTargetX := g_nMiniMapPath[0].X;
          g_nTargetY := g_nMiniMapPath[0].Y;
        end;
      end
      else begin
        g_ChrAction := caWalk;
        g_nTargetX := g_nMiniMapPath[0].X;
        g_nTargetY := g_nMiniMapPath[0].Y;
      end;
    end
    else begin
      nI := 0;
      for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do
      begin
        if CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) and
        PlayScene.CanRunEx(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) and
        (GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) = 2) then
        begin
          g_ChrAction := caRun;
          g_nTargetX := g_nMiniMapPath[i].X;
          g_nTargetY := g_nMiniMapPath[i].Y;
          exit;
        end;
        Inc(nI);
        if nI >= 10 then
          break;
      end;
      if (High(g_nMiniMapPath) >= 1) and
      CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[1].X, g_nMiniMapPath[1].Y) then
      begin
        g_ChrAction := caRun;
        g_nTargetX := g_nMiniMapPath[1].X;
        g_nTargetY := g_nMiniMapPath[1].Y;
        if (not PlayScene.CanRunEx(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nTargetX, g_nTargetY)) or
        (GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nTargetX, g_nTargetY) <= 1) then
        begin
          g_ChrAction := caWalk;
          g_nTargetX := g_nMiniMapPath[0].X;
          g_nTargetY := g_nMiniMapPath[0].Y;
        end;
      end
      else begin
        g_ChrAction := caWalk;
        g_nTargetX := g_nMiniMapPath[0].X;
        g_nTargetY := g_nMiniMapPath[0].Y;
      end;
    end;

    if g_ChrAction = caWalk then
    begin
      if not PlayScene.CanWalkEx2(g_nTargetX, g_nTargetY) then
      begin
        for i := PlayScene.m_ActorList.Count - 1 downto 0 do
        begin
          Actor := TActor(PlayScene.m_ActorList[i]);
          if not ((actor.m_boDeath or (g_boNpcMoveing and (Actor.m_nCurrX = g_nScriptGotoX) and (Actor.m_nCurrY = g_nScriptGotoY)))) then
          begin
            g_LegendMap.SetTerrainType(Actor.m_nCurrX, Actor.m_nCurrY, False);
          end;
        end;
        Try
          g_nMiniMapPath := FindPath(g_nMiniMapPath[High(g_nMiniMapPath)].X, g_nMiniMapPath[High(g_nMiniMapPath)].Y);
        Finally
          for i := PlayScene.m_ActorList.Count - 1 downto 0 do
          begin
            Actor := TActor(PlayScene.m_ActorList[i]);
            if not ((actor.m_boDeath or (g_boNpcMoveing and (Actor.m_nCurrX = g_nScriptGotoX) and (Actor.m_nCurrY = g_nScriptGotoY)))) then
            begin
              g_LegendMap.SetTerrainType(Actor.m_nCurrX, Actor.m_nCurrY, True);
            end;
          end;
        End;
        if High(g_nMiniMapPath) >= 0 then
        begin
          Inc(Count);
          if Count > 5 then
          begin
            if g_boNpcMoveing and (abs(g_MySelf.m_nCurrX - g_nScriptGotoX) <= 5) and
            (abs(g_MySelf.m_nCurrY - g_nScriptGotoY) <= 5) then
            begin
              GotoClickNpc(g_nScriptGotoX, g_nScriptGotoY);
              g_nMiniMapPath := nil;
              g_boAutoMoveing := False;
              g_boNpcMoveing := False;
              g_nMiniMapMoseX := -1;
              g_nMiniMapMoseY := -1;
              g_nMiniMapPath := nil;
              exit;
            end;
            //if not g_boNpcMoveing then
            DScreen.AddSysMsg('[无法到达目的地]', clWhite);
            g_boAutoMoveing := False;
            g_boNpcMoveing := False;
            g_nMiniMapMoseX := -1;
            g_nMiniMapMoseY := -1;
            g_nMiniMapPath := nil;
            exit;
          end;
          goto LB_WALK
        end
        else begin
          if g_boNpcMoveing and (abs(g_MySelf.m_nCurrX - g_nScriptGotoX) <= 5) and
          (abs(g_MySelf.m_nCurrY - g_nScriptGotoY) <= 5) then
          begin
            GotoClickNpc(g_nScriptGotoX, g_nScriptGotoY);
            g_nMiniMapPath := nil;
            g_boAutoMoveing := False;
            g_boNpcMoveing := False;
            g_nMiniMapMoseX := -1;
            g_nMiniMapMoseY := -1;
            g_nMiniMapPath := nil;
            exit;
          end;
          //if not g_boNpcMoveing then
          DScreen.AddSysMsg('[无法到达目的地]', clWhite);
          g_boAutoMoveing := False;
          g_boNpcMoveing := False;
          g_nMiniMapMoseX := -1;
          g_nMiniMapMoseY := -1;
          g_nMiniMapPath := nil;
          exit;
        end;
      end;
    end;
  end
  else begin
    LB_STOP: if (High(g_nMiniMapPath) < 0) then
  begin
    if not g_boNpcMoveing then
      DScreen.AddSysMsg('[到达目的地]', clWhite);
    //DynArrayDelete(g_nMiniMapPath,SizeOf(TPoint),0,1);
    g_nMiniMapPath := nil;
    g_boAutoMoveing := False;
    g_boNpcMoveing := False;
    g_nMiniMapMoseX := -1;
    g_nMiniMapMoseY := -1;
    g_nMiniMapPath := nil;
    exit;
  end;
    if (g_MySelf.m_nCurrX = g_nMiniMapPath[0].X) and (g_MySelf.m_nCurrY = g_nMiniMapPath[0].Y) then
    begin
      //DynArrayDelete(g_nMiniMapPath, SizeOf(TPoint), 0, 1);
      g_nMiniMapPath := nil;
    end;
    if (High(g_nMiniMapPath) < 0) then
    begin
      if not g_boNpcMoveing then
        DScreen.AddSysMsg('[到达目的地]', clWhite);
      //DynArrayDelete(g_nMiniMapPath,SizeOf(TPoint),0,1);
      g_nMiniMapPath := nil;
      g_boAutoMoveing := False;
      g_boNpcMoveing := False;
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      g_nMiniMapPath := nil;
      exit;
    end;
    g_ChrAction := caWalk;
    g_nTargetX := g_nMiniMapPath[0].X;
    g_nTargetY := g_nMiniMapPath[0].Y;
    if not PlayScene.CanWalkEx2(g_nTargetX, g_nTargetY) then
    begin
      //if not g_boNpcMoveing then
      DScreen.AddSysMsg('[无法到达目的地]', clWhite);
      //DynArrayDelete(g_nMiniMapPath, SizeOf(TPoint), 0, 1);
      g_nMiniMapPath := nil;
      g_boAutoMoveing := False;
      g_boNpcMoveing := False;
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      g_nMiniMapPath := nil;
    end;
  end;
end;
{
 鼠标控制 左　键 控制基本的行动：行走、攻击拾取物品和其他东西
右　键 近处的点击能够看到物品使用方法，远处的点击能够在地图上跑动。
Shift + 左键 强制攻击
Ctrl + 左键 跑动
Ctrl + 右键 关于对手的信息，如同F10一样。
Alt + 右键 取得肉或者其他玩家因为死亡丢失的东西。
双　击 拾取在地上的物品或者使用自己包裹中的物品。
}

procedure TfrmMain.ProcessActionMessages;
var
  mx, my, dx, dy, crun: Integer;
  ndir, adir, mdir: byte;
  bowalk, bostop: Boolean;
label
LB_WALK;
begin
  if g_MySelf = nil then
    Exit;

  //自动移动
  if g_boAutoMoveing and CanNextAction and ServerAcceptNextAction and (not g_boMapMovingWait) then
    GetAutoMovingXY();
  //Move
  //ActionLock捞 钱府搁, ActionLock篮 悼累捞 场唱扁 傈俊 钱赴促.
  if (g_nTargetX >= 0) then
  begin
    {DScreen.AddSysMsg('1 ' + IntToStr(GetTickCount - g_dwLastAttackTick), clWhite);
    if not CanNextAction then exit;
    DScreen.AddSysMsg('2 ' + IntToStr(GetTickCount - g_dwLastAttackTick), clWhite);  }
    if CanNextAction and ServerAcceptNextAction then
    begin
      //需要更新坐标位置
      if (g_nTargetX <> g_MySelf.m_nCurrX) or (g_nTargetY <> g_MySelf.m_nCurrY) then
      begin
        //   TTTT:
        mx := g_MySelf.m_nCurrX;
        my := g_MySelf.m_nCurrY;
        dx := g_nTargetX;
        dy := g_nTargetY;
        ndir := GetNextDirection(mx, my, dx, dy);
        //当前动作
        case g_ChrAction of
          caWalk:
          begin
            LB_WALK: crun := g_MySelf.CanWalk;
            mx := g_MySelf.m_nCurrX;
            my := g_MySelf.m_nCurrY;
            if IsUnLockAction(CM_WALK, ndir) and (crun > 0) then
            begin
              GetNextPosXY(ndir, mx, my);
              //              bowalk := True;
              bostop := FALSE;
              if not PlayScene.CanWalk(mx, my) then
              begin
                bowalk := FALSE;
                adir := 0;
                if not bowalk then
                begin
                  //涝备 八荤
                  mx := g_MySelf.m_nCurrX;
                  my := g_MySelf.m_nCurrY;
                  GetNextPosXY(ndir, mx, my);
                  if CheckDoorAction(mx, my) then
                    bostop := True;
                end;
                if not bostop and not PlayScene.CrashMan(mx, my) then
                begin
                  //荤恩篮 磊悼栏肺 乔窍瘤 臼澜..
                  mx := g_MySelf.m_nCurrX;
                  my := g_MySelf.m_nCurrY;
                  adir := PrivDir(ndir);
                  GetNextPosXY(adir, mx, my);
                  if not Map.CanMove(mx, my) then
                  begin
                    mx := g_MySelf.m_nCurrX;
                    my := g_MySelf.m_nCurrY;
                    adir := NextDir(ndir);
                    GetNextPosXY(adir, mx, my);
                    if Map.CanMove(mx, my) then
                      bowalk := True;
                  end
                  else
                    bowalk := True;
                end;
                if bowalk then
                begin
                  g_MySelf.UpdateMsg(CM_WALK, mx, my, adir, 0, 0, '', 0);
                  g_dwLastMoveTick := GetTickCount;
                end
                else begin
                  mdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, dx, dy);
                  if mdir <> g_MySelf.m_btDir then
                    g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, 0, 0, '', 0);
                  g_nTargetX := -1;
                end;
              end
              else begin
                g_MySelf.UpdateMsg(CM_WALK, mx, my, ndir, 0, 0, '', 0);
                g_dwLastMoveTick := GetTickCount;
              end;
            end
            else begin
              g_nTargetX := -1;
            end;
          end;
          caRun:
          begin
            //免助跑
            //if g_nRunReadyCount >= 0 then begin
            crun := g_MySelf.CanRun;
            if (g_MySelf.m_btHorse <> 0) then
            begin
              //骑马跑
              if (GetDistance(mx, my, dx, dy) >= 3) and (crun > 0) then
              begin
                if IsUnLockAction(CM_HORSERUN, ndir) then
                begin
                  GetNextHorseRunXY(ndir, mx, my);
                  if PlayScene.CanHorseRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then
                  begin
                    g_MySelf.UpdateMsg(CM_HORSERUN, mx, my, ndir, 0, 0, '', 0);
                    g_dwLastMoveTick := GetTickCount;
                  end
                  else begin
                    goto LB_WALK;
                  end;
                end
                else
                  g_nTargetX := -1;
              end
              else begin
                goto LB_WALK;
              end;
            end
            else begin
              if (GetDistance(mx, my, dx, dy) >= 2) and (crun > 0) then
              begin
                if IsUnLockAction(CM_RUN, ndir) then
                begin
                  GetNextRunXY(ndir, mx, my);
                  if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then
                  begin
                    g_MySelf.UpdateMsg(CM_RUN, mx, my, ndir, 0, 0, '', 0);
                    g_dwLastMoveTick := GetTickCount;
                  end
                  else begin
//如果跑失败则跳回去走
                    goto LB_WALK;
                  end;
                end
                else
                  g_nTargetX := -1;
              end
              else begin
                goto LB_WALK;
              end;
            end;
          end;
          caLeap:
          begin
            crun := g_MySelf.CanRun;
            if (GetDistance(mx, my, dx, dy) >= 2) and (crun > 0) then
            begin
              if IsUnLockAction(CM_LEAP, ndir) then
              begin
                GetNextRunXY(ndir, mx, my);
                if PlayScene.CanLeap(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then
                begin
                  g_MySelf.UpdateMsg(CM_Leap, mx, my, ndir, 0, 0, '', 0);
                  g_dwLastMoveTick := GetTickCount;
                end
                else begin
                  goto LB_WALK;
                end;
              end
              else
                g_nTargetX := -1;
            end
            else begin
              goto LB_WALK;
            end;
          end;
        end;
      end;
    end;
  end;
  g_nTargetX := -1; //茄锅俊 茄沫究..
  if g_MySelf.RealActionMsg.ident > 0 then
  begin
    FailAction := g_MySelf.RealActionMsg.ident; //角菩且锭 措厚
    FailDir := g_MySelf.RealActionMsg.dir;
    if g_MySelf.RealActionMsg.ident = CM_SPELL then
    begin
      SendSpellMsg(g_MySelf.RealActionMsg.ident,
                    g_MySelf.RealActionMsg.X,
                    g_MySelf.RealActionMsg.Y,
                    g_MySelf.RealActionMsg.dir,
                    g_MySelf.RealActionMsg.State);
    end
    else if g_MySelf.RealActionMsg.ident = CM_SITDOWN then
    begin
      SendSitDownMsg(g_MySelf.RealActionMsg.feature,
                      g_MySelf.RealActionMsg.X,
                      g_MySelf.RealActionMsg.Y,
                      g_MySelf.RealActionMsg.dir);
    end
    else
      SendActMsg(g_MySelf.RealActionMsg.ident,
                  g_MySelf.RealActionMsg.X,
                  g_MySelf.RealActionMsg.Y,
                  g_MySelf.RealActionMsg.dir);
    g_MySelf.RealActionMsg.ident := 0;

    //玩家离NPC远了 关闭NPC窗口
    if g_nMDlgX <> -1 then
      if (abs(g_nMDlgX - g_MySelf.m_nCurrX) >= 8) or (abs(g_nMDlgY - g_MySelf.m_nCurrY) >= 8) then
      begin
        //if FrmDlg.DMerchantDlg.Visible then
        FrmDlg.CloseMDlg;
        g_nMDlgX := -1;
      end;
    if g_nMyReadShopDlgX <> -1 then
    begin
      if (abs(g_nMyReadShopDlgX - g_MySelf.m_nCurrX) >= 8) or (abs(g_nMyReadShopDlgY - g_MySelf.m_nCurrY) >= 8) then
      begin
        FrmDlg2.DReadUserShop.Visible := False;
        g_nMyReadShopDlgX := -1;
      end;
    end;
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  //  mx, my: Integer;
  I: Integer;
  str: string;
begin
  if g_boMapApoise then exit;
  if g_boShowFormImage then
  begin
    if Key = 27 then ShowInterface(False);
    exit;
  end;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then
  begin
    g_TopDWindow.KeyDown(Key, Shift);
    Exit;
  end;
  g_boCtrlDown := (ssCtrl in Shift);
{$IFDEF DEBUG}
  //if Key = $56 then
  //g_boLeapDown := True;
{$ENDIF}
  if g_SetupInfo.boExemptShift and g_boShiftUp and (ssShift in Shift) then
  begin
    g_boShiftUp := False;
    if not g_boEasyNotShift then
    begin
      g_boShiftOpen := not g_boShiftOpen;
      if g_boShiftOpen then
        str := '[自动Shift 开]'
      else
        str := '[自动Shift 关]';
      DScreen.AddSysMsg(str, cllime);
    end;
    //DScreen.AddChatBoardString(str, clWhite, clBlue);
  end;
//{$IFDEF DEBUG}
//  if (ssAlt in Shift) and (Key = VK_RETURN) then begin
//    FullScreen(not g_boFullScreen);
//  end;
//{$ENDIF}

  //2008-02-21 新增自定义快捷键
  for i := Low(g_CustomKey) to High(g_CustomKey) do
  begin
    if (not g_SetupInfo.boCustomKey) or ((g_CustomKey[i].CustomKey.Shift = []) and (g_CustomKey[i].CustomKey.Key = 0)) then
    begin
      if (Shift = g_CustomKey[i].DefKey.Shift) and
      (g_CustomKey[i].DefKey.Key = Key) then
      begin
        if g_CustomKey[i].boLoginGame then
        begin
          if (g_MySelf <> nil) or (DScreen.CurrentScene = PlayScene) then
          begin
            if OpenKeyInfo(I) then
            begin
              Key := 0;
              Exit;
            end;
            {Key := 0;
            Exit; }
          end;
        end
        else begin
          OpenKeyInfo(I);
          {Key := 0;
          Exit; }
        end;
        break;
      end;
    end
    else begin
      if (Shift = g_CustomKey[i].CustomKey.Shift) and (g_CustomKey[i].CustomKey.Key = Key) then
      begin
        if g_CustomKey[i].boLoginGame then
        begin
          if (g_MySelf <> nil) or (DScreen.CurrentScene = PlayScene) then
          begin
            if OpenKeyInfo(I) then
            begin
              Key := 0;
              Exit;
            end;
            {Key := 0;
            Exit; }
          end;
        end
        else begin
          OpenKeyInfo(I);
          {Key := 0;
          Exit;}
        end;
        break;
      end;
    end;
  end;

  if g_DWinMan.KeyDown(Key, Shift) then Exit;
  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then
    Exit;

  case Key of
{$IF Var_Interface = Var_Mir2}
    VK_F1..VK_F8:
    begin
      if ((GetTickCount - g_dwLatestSpellTick) > g_dwMagicDelayTime) then
      begin
        if ssCtrl in Shift then
        begin
          ActionKey := -(byte(Key) - VK_F1 + 1);
        end else begin
          ActionKey := -(byte(Key) - VK_F1 + 9);
        end;
      end;
    end;
{$ELSE}
      VK_F1..VK_F8: begin
      if ((GetTickCount - g_dwLatestSpellTick) > g_dwMagicDelayTime) then begin
      ActionKey := byte(Key) - VK_F1 + 13;
      end;
      end;
{$IFEND}

  end;

  with FrmDlg do
  begin
    case Key of
      VK_UP: DSayUpDown.Position := DSayUpDown.Position - 1;
      VK_DOWN: DSayUpDown.Position := FrmDlg.DSayUpDown.Position + 1;
      VK_PRIOR: DSayUpDown.Position := DSayUpDown.Position - (DWndSay.Height div SAYLISTHEIGHT - 1);
      VK_NEXT: DSayUpDown.Position := DSayUpDown.Position + (DWndSay.Height div SAYLISTHEIGHT - 1);
      VK_F10: Key := 0;
      Word('R'):
      begin
        if (ssAlt in Shift) and DItemBagRef.Enabled then
          DItemBagRefClick(DItemBagRef, 0, 0);
      end;
      Word('L'):
      begin
        //挂机
        if ssCtrl in Shift then
          g_GuaJi.Started := not g_GuaJi.Started;
      end;

{$IF Var_Interface =  Var_Default}
      VK_ESCAPE:
      begin
        FrmDlg2.dwndSysSetup.Left := g_FScreenXOrigin - FrmDlg2.dwndSysSetup.Width div 2;
        FrmDlg2.dwndSysSetup.Top := g_FScreenYOrigin - FrmDlg2.dwndSysSetup.Height div 2;
        FrmDlg2.dwndSysSetup.TopShow;
      end;
{$IFEND}
    end;
  end;
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if g_boMapApoise or g_boShowFormImage then
    exit;

  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then
  begin
    g_TopDWindow.KeyPress(Key);
    //若聊天信息输入框可见，则不处理，而由系统自动处理(作为输入信息)
    Exit;
  end;
  //ShowMessage(IntToStr(Byte(key)));
  if g_DWinMan.KeyPress(Key) then
    Exit;

{$IFDEF DEBUG}
  case byte(Key) of
  byte('G'), byte('g'): begin
  if not frmDlgConfig.Showing then
  frmDlgConfig.Open;
  end;
  byte('B'), byte('b'): begin
  GMManageShow;
  end;
  end;
{$ENDIF}

  if (DScreen.CurrentScene = PlayScene) and (g_MySelf <> nil) then
  begin
    case byte(Key) of
        {byte('1')..byte('6'): begin
          EatItem(byte(Key) - byte('1'));
        end;  }
        {27: {//ESC begin
        end;  }
      byte('C'), byte('c'):
      begin
        FrmDlg.StatePage := 0;
        FrmDlg.OpenMyStatus;
      end;
      byte('B'), byte('b'):
      begin
        FrmDlg.OpenItemBag;
      end;
      byte('S'), byte('s'):
      begin
        FrmDlg.StatePage := 2;
        FrmDlg.OpenMyStatus;
      end;
      byte('W'), byte('w'):
      begin
        FrmDlg.DBotGuildClick(FrmDlg.DBotGuild, 0, 0);
      end;
      byte('G'), byte('g'):
      begin
        FrmDlg.DGroupDlg.Visible := not FrmDlg.DGroupDlg.Visible;
      end;
      byte('F'), byte('f'):
      begin
        FrmDlg2.DWinFriend.Visible := not FrmDlg2.DWinFriend.Visible;
      end;
      byte('Q'), byte('q'):
      begin
        FrmDlg3.dwndMission.Visible := not FrmDlg3.dwndMission.Visible;
      end;
      byte('E'), byte('e'):
      begin
        FrmDlg2.DWinEmail.Visible := not FrmDlg2.DWinEmail.Visible;
      end;
      byte('D'), byte('d'):
      begin
        g_CursorMode := cr_Deal;
        Cursor := crMyDeal;
      end;
      byte('H'), byte('h'):
      begin
        //FrmDlg2.DWinEmail.Visible := not FrmDlg2.DWinEmail.Visible;
        FrmDlg.DTopHelpClick(FrmDlg.DTopHelp, 0, 0);
      end;
      byte('M'), byte('m'):
      begin
        FrmDlg.DMiniMapMaxClick(FrmDlg.DMiniMapMax, 0, 0);
      end;
      byte('`'):
      begin
        AutoPickUpItem(False);
      end;
      byte(' '), 13:
      begin
        {FrmDlg.DEditChat.Visible := True;
          FrmDlg.DEditChat.SetFocus;
          FrmDlg.DEditChat.Text := '';
          FrmDlg.DEditChatChange(FrmDlg.DEditChat);  }
        FrmDlg.DBTEditClick(FrmDlg.DBTEdit, 0, 0);
        {if FrmDlg.BoGuildChat then begin
            FrmDlg.DEditChat.Text := '!~';
          end
          else begin
            FrmDlg.DEditChat.Text := '';
          end; }
      end;
      byte('@'),
      byte('~'),
      byte('!'),
      byte('/'):
      begin
        if not FrmDlg.DEditChat.Visible then
        begin
          FrmDlg.DEditChat.Visible := True;
          FrmDlg.DEditChat.SetFocus;
          FrmDlg.DEditChat.Text := Key;
        end else begin
          FrmDlg.DEditChat.SetFocus;
        end;
        //FrmDlg.DEditChatChange(FrmDlg.DEditChat);
        {if Key = '/' then begin
              FrmDlg.DEditChat.Text := Key;
              FrmDlg.DEditChatChange(FrmDlg.DEditChat);
            end
            else begin
              FrmDlg.DEditChat.Visible := True;
              FrmDlg.DEditChat.SetFocus;
              FrmDlg.DEditChat.Text := Key;
            end; }
        //end;
      end;
{$IF Var_Interface = Var_Mir2}
      $31..$36:
      begin
        // 0..9
        //if ((GetTickCount - g_dwLatestSpellTick) > g_dwMagicDelayTime) then begin
        ActionKey := byte(Key) - $31 + 1;
        //end;
      end;
{$ELSE}
        $31..$39: begin // 0..9
        //if ((GetTickCount - g_dwLatestSpellTick) > g_dwMagicDelayTime) then begin
        ActionKey := byte(Key) - $31 + 1;
        //end;
        end;
        $30: begin // 0..9
        //if ((GetTickCount - g_dwLatestSpellTick) > g_dwMagicDelayTime) then begin
        ActionKey := 10;
        //end;
        end;
        Byte('-'): begin
        //if ((GetTickCount - g_dwLatestSpellTick) > g_dwMagicDelayTime) then begin
        ActionKey := 11;
        //end;
        end;
        Byte('='): begin
        //if ((GetTickCount - g_dwLatestSpellTick) > g_dwMagicDelayTime) then begin
        ActionKey := 12;
        //end;
        end;
{$IFEND}

    end;
    Key := #0;
  end;

  { case Key of
     VK_F1..VK_F8: begin
         //if ((GetTickCount - g_dwLatestSpellTick) > (500 + g_dwMagicDelayTime)) then begin
           ActionKey := Key - VK_F1 + 13;
         //end;
         Key := 0;
       end;
     $31..$39: begin // 0..9
       //if ((GetTickCount - g_dwLatestSpellTick) > (500 + g_dwMagicDelayTime)) then begin
         ActionKey := Key - $31 + 1;
       //end;
       Key := 0;
     end;
     $30: begin // 0..9
       //if ((GetTickCount - g_dwLatestSpellTick) > (500 + g_dwMagicDelayTime)) then begin
         ActionKey := 10;
       //end;
       Key := 0;
     end;
     189: begin
         //if ((GetTickCount - g_dwLatestSpellTick) > (500 + g_dwMagicDelayTime)) then begin
           ActionKey := 11;
         //end;
       end;
     187: begin
         //if ((GetTickCount - g_dwLatestSpellTick) > (500 + g_dwMagicDelayTime)) then begin
           ActionKey := 12;
         //end;
       end;
   end;}
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if g_boMapApoise or g_boShowFormImage then
    exit;
  //ShowMessage(IntToStr(key));
  if Key = VK_CONTROL then
    g_boCtrlDown := False;
  if Key = VK_SHIFT then
    g_boShiftUp := True;
  if Key = $56 then
    g_boLeapDown := False;

  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then
  begin
    g_TopDWindow.KeyUp(Key, Shift);
    Exit;
  end;
  if g_DWinMan.KeyUp(Key, Shift) then Exit;


end;

procedure TfrmMain.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  nX, nY: integer;

begin
  if g_boMapApoise or g_boShowFormImage then exit;
  nX := MousePos.X - ClientOrigin.X;
  nY := MousePos.Y - ClientOrigin.Y;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then Exit;
  if (nX >= 0) and (nY >= 0) and (nX <= g_FScreenWidth) and (nY <= g_FScreenHeight) then
  begin
    if not g_DWinMan.MouseWheel(Shift, mw_Down, nX, nY) then
      FrmDlg.DSayUpDown.MouseWheel(Shift, mw_Down, nX, nY);
  end;
end;

procedure TfrmMain.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  nX, nY: integer;
begin
  if g_boMapApoise or g_boShowFormImage then exit;
  nX := MousePos.X - ClientOrigin.X;
  nY := MousePos.Y - ClientOrigin.Y;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then Exit;
  if (nX >= 0) and (nY >= 0) and (nX <= g_FScreenWidth) and (nY <= g_FScreenHeight) then
  begin
    if not g_DWinMan.MouseWheel(Shift, mw_Up, nX, nY) then
      FrmDlg.DSayUpDown.MouseWheel(Shift, mw_Up, nX, nY);
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  ShowWindow(application.Handle, SW_HIDE);
end;

procedure TfrmMain.GetMoveHPShow(Actor: TActor; nCount: Word);
var
  MoveShow: pTMoveHMShow;
  str: string;
  i: integer;
  d: TDirectDrawSurface;
  boAdd: Boolean;
begin
  if (g_MySelf = nil) or (not g_SetupInfo.boMoveHpShow) or (Actor = nil) or (actor.m_btRace = 50) then
    exit;
  with Actor do
  begin
    boAdd := False;
    New(MoveShow);
    MoveShow.dwMoveHpTick := GetTickCount;
    //MoveShow.Surface := TDXImageTexture.Create(g_DXCanvas);
    //MoveShow.Surface := MakeDXImageTexture(OPERATEHINTWIDTH, OPERATEHINTHEIGHT, D3DFMT_A4R4G4B4)
    //MoveShow.Surface.Format := D3DFMT_A4R4G4B4;
    {m_UserNameSurface := TDXImageTexture.Create(g_DXCanvas);
    m_UserNameSurface.Size := Point(MAXNAMEWIDTH, MAXNAMEHEIGHT);
    m_UserNameSurface.PatternSize := Point(MAXNAMEWIDTH, MAXNAMEHEIGHT);
    m_UserNameSurface.Active := True;
    m_UserNameSurface.Clear;   }
    if nCount > 0 then
    begin
      str := IntToStr(nCount);
      //MoveShow.Surface.Size := Point(Length(str) * 9, 12);
      //MoveShow.Surface.PatternSize := MoveShow.Surface.Size;
      //MoveShow.Surface.Active := True;
      MoveShow.Surface := MakeDXImageTexture(Length(str) * 9, 12, WILFMT_A4R4G4B4, g_DXCanvas);
      if MoveShow.Surface = nil then Exit;
      MoveShow.Surface.Clear;
      for I := 1 to Length(str) do
      begin
        d := g_WMain99Images.Images[690 + StrToIntDef(Str[I], 0)];
        if d <> nil then
        begin
          MoveShow.Surface.CopyTexture((I - 1) * 9, 0, d);
          //MoveShow.Surface.Draw((I - 1) * 9, 0, d.ClientRect, d, False);
          boAdd := True;
        end;
      end;
    end
    else begin
      d := g_WMain99Images.Images[726];
      if d <> nil then
      begin
        //MoveShow.Surface.SetSize(d.Width, d.Height);
        {MoveShow.Surface.Size := Point(d.Width, d.Height);
        MoveShow.Surface.PatternSize := MoveShow.Surface.Size;
        MoveShow.Surface.Active := True; }
        MoveShow.Surface := MakeDXImageTexture(d.Width, d.Height, WILFMT_A4R4G4B4, g_DXCanvas);
        if MoveShow.Surface = nil then Exit;
        MoveShow.Surface.Clear;
        MoveShow.Surface.CopyTexture(0, 0, d);
        //MoveShow.Surface.Draw(0, 0, d.ClientRect, d, False);
        boAdd := True;
      end;
    end;
    if boAdd then
    begin
      m_nMoveHpList.Add(MoveShow);
    end
    else begin
      MoveShow.Surface.Free;
      Dispose(MoveShow);
    end;
  end;
end;

procedure TfrmMain.UseMagic(tx, ty: Integer; pcm: PTNewClientMagic);
function CheckAmulet(nCount: Integer; nType: Integer): Boolean;
begin
  Result := False;
  if (g_UseItems[U_BUJUK].s.Name <> '') and (g_UseItems[U_BUJUK].s.StdMode = tm_Amulet) then
  begin
    case nType of
      1:
      begin
        Result := (g_UseItems[U_BUJUK].s.Shape = 5) and (g_UseItems[U_BUJUK].UserItem.Dura >= nCount);
      end;
      2:
      begin
        Result := (g_UseItems[U_BUJUK].s.Shape <= 2) and (g_UseItems[U_BUJUK].UserItem.Dura >= nCount);
      end;
      3:
      begin
        Result := (g_UseItems[U_BUJUK].s.Shape = 1) and (g_UseItems[U_BUJUK].UserItem.Dura >= nCount);
      end;
      4:
      begin
        Result := (g_UseItems[U_BUJUK].s.Shape = 2) and (g_UseItems[U_BUJUK].UserItem.Dura >= nCount);
      end;
    end;
  end;
end;

function GetAmulet(nCount: Integer; nType: Integer; var nItemIdx: Integer): pTNewClientItem;
var
  i: Integer;
begin
  Result := nil;
  nItemIdx := -1;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do
  begin
    if (g_ItemArr[i].s.Name <> '') and (g_ItemArr[i].s.StdMode = tm_Amulet) then
    begin
      case nType of
        1:
        begin
          if (g_ItemArr[i].s.Shape = 5) and (g_ItemArr[i].UserItem.Dura >= nCount) then
          begin
            Result := @g_ItemArr[i];
            nItemIdx := I;
            exit;
          end;
        end;
        2:
        begin
          if (g_ItemArr[i].s.Shape <= 2) and (g_ItemArr[i].UserItem.Dura >= nCount) then
          begin
            Result := @g_ItemArr[i];
            nItemIdx := I;
            exit;
          end;
        end;
        3:
        begin
          if (g_ItemArr[i].s.Shape = 1) and (g_ItemArr[i].UserItem.Dura >= nCount) then
          begin
            Result := @g_ItemArr[i];
            nItemIdx := I;
            exit;
          end;
        end;
        4:
        begin
          if (g_ItemArr[i].s.Shape = 2) and (g_ItemArr[i].UserItem.Dura >= nCount) then
          begin
            Result := @g_ItemArr[i];
            nItemIdx := I;
            exit;
          end;
        end;
      end;
    end;
  end;
end;
//procedure UseAmulet(PlayObject: TBaseObject { 修改 TBaseObject}; nCount: Integer; nType: Integer);
var
  tdir, targx, targy, targid, nCount, nItemIdx: Integer;
  pmag: PTUseMagicInfo;
  item: pTNewClientItem;
begin
  // 技能不存在，或施法者不存在，或施法者处于摆摊状态，或施法者正在骑马，则不能使用魔法
  if (pcm = nil) or (g_MySelf = nil) or (g_MySelf.m_boShop) or (g_MySelf.m_btHorse <> 0) then
    Exit;
  // 全局施法间隔，即两次施法间隔不能低于 g_dwMagicDelayTime，默认是 500ms
  if ((GetTickCount - g_dwLatestSpellTick) < g_dwMagicDelayTime) then exit;
  // 技能施法间隔，fixme 这里为什么是直接判断，需要查清楚
  if GetTickCount < pcm.dwInterval then Exit;
  //是否可以使用魔法：需要的点数<当前点数，或者是魔法EffectType = 0
  if (GetSpellPoint(pcm) <= g_MySelf.m_Abil.MP) or (pcm.Def.Magic.btEffectType = 0) then
  begin

    if pcm.Def.Magic.btEffectType = 0 then
    begin
      g_dwLatestSpellTick := GetTickCount;
      g_boLatestSpell := False;
      g_dwMagicDelayTime := 500;
      if (pcm.Def.Magic.wMagicId = 100) and (g_MySelf.m_btJob <> 0) then
      begin
        if g_FocusCret = nil then g_MagicTarget := g_MagicLockTarget
        else g_MagicTarget := g_FocusCret;
        g_MagicLockTarget := g_MagicTarget;
        if not PlayScene.IsValidActor(g_MagicTarget) then
        begin
          g_MagicTarget := nil;
          DScreen.AddSysMsg('[无法释放连击,请先选择目标]', cllime);
          exit;
        end;
        if g_MagicTarget = nil then
        begin
          exit;
        end
        else begin
          targx := g_MagicTarget.m_nCurrX;
          targy := g_MagicTarget.m_nCurrY;
          targid := g_MagicTarget.m_nRecogId;
        end;
        SendSpellMsg(CM_SPELL, targx, targy, pcm.Def.Magic.wMagicId, targid);
      end
          { else
      if (pcm.Def.Magic.wMagicId = 70) then begin
        if g_MagicTarget = nil then begin
          PlayScene.CXYfromMouseXY(tx, ty, targx, targy);
          targid := 0;
        end
        else begin
          targx := g_MagicTarget.m_nCurrX;
          targy := g_MagicTarget.m_nCurrY;
          targid := g_MagicTarget.m_nRecogId;
        end;
        SendSpellMsg(CM_SPELL, targx, targy, pcm.Def.Magic.wMagicId, targid);
      end    }
      else begin
        //pcm.dwInterval := GetTickCount + pcm.Def.Magic.nInterval + 500;
        SendSpellMsg(CM_SPELL, g_MySelf.m_btDir {x}, 0, pcm.Def.Magic.wMagicId, 0);
      end;
      g_CboMagicID := -1;
    end
    else begin
{$IF Var_Interface = Var_Mir2}
      tdir := GetFlyDirection(364, 224 + (12), tx, ty);
{$ELSE}
      tdir := GetFlyDirection(364, 288 + (12), tx, ty);
{$IFEND}

      //     MagicTarget := FocusCret;
      //魔法锁定
      if (g_MagicLockTarget <> nil) and g_MagicLockTarget.m_boDeath then
        g_MagicLockTarget := nil;
      if (mm_MagLock in pcm.def.magic.MagicMode) or
      (g_SetupInfo.boAutoCloak and (pcm.Def.Magic.wMagicId = 2)) or
      ((not g_SetupInfo.boSnowWindLock) and (pcm.Def.Magic.wMagicId = 33)) or
      ((not g_SetupInfo.boFieryDragonLock) and (pcm.Def.Magic.wMagicId = 47)) then
      begin
        if (g_FocusCret = nil) or (g_FocusCret.m_boDeath) then g_MagicTarget := g_MagicLockTarget
        else g_MagicTarget := g_FocusCret;
        g_MagicLockTarget := g_MagicTarget;
      end else begin
        g_MagicTarget := g_FocusCret;
        if g_MagicLockTarget = nil then g_MagicLockTarget := g_FocusCret;
      end;
      if not PlayScene.IsValidActor(g_MagicTarget) then
        g_MagicTarget := nil;


      //智能换符
      if (pcm.Def.Magic.wMagicId in [13..19, SKILL_SINSU, SKILL_52, SKILL_67]) then
      begin
        if pcm.Def.Magic.wMagicId = SKILL_SINSU then nCount := 5
        else nCount := 1;
        if not CheckAmulet(nCount, 1) then
        begin
          Item := GetAmulet(nCount, 1, nItemIdx);
          if Item <> nil then
          begin
            if (g_WaitingUseItem.Item.S.name <> '') then Exit;
            g_WaitingUseItem.Item := Item^;
            g_WaitingUseItem.ItemType := mtBagItem;
            g_WaitingUseItem.Index2 := U_BUJUK;
            frmMain.SendTakeOnItem(U_BUJUK, Item.UserItem.MakeIndex, Item.S.name);
            DelItemBagByIdx(nItemIdx);
          end else begin
            DScreen.AddSysMsg('[护身符已经用完]', cllime);
            exit;
          end;
        end;
      end else                       //SKILL_GROUPAMYOUNSUL
        if (pcm.Def.Magic.wMagicId = 6) then
        begin
          nCount := 2;
          if g_MagicTarget <> nil then
          begin
            if (g_MagicTarget.m_nState and $40000000 = 0) then
            begin
              nCount := 4;
            end;
            if (g_MagicTarget.m_nState and $80000000 = 0) then
            begin
              nCount := 3;
            end;
          end;
          if not CheckAmulet(1, nCount) then
          begin
            Item := GetAmulet(1, nCount, nItemIdx);
            if (Item = nil) and (g_UseItems[U_BUJUK].s.Name <> '') and (g_UseItems[U_BUJUK].s.StdMode = tm_Amulet) and
            (g_UseItems[U_BUJUK].s.Shape <= 2) then
            begin
              Item := @g_UseItems[U_BUJUK];
            end else begin
              if (Item = nil) and (nCount <> 2) then Item := GetAmulet(1, 2, nItemIdx);
              if Item <> nil then
              begin
                if (g_WaitingUseItem.Item.S.name <> '') then Exit;
                g_WaitingUseItem.Item := Item^;
                g_WaitingUseItem.ItemType := mtBagItem;
                g_WaitingUseItem.Index2 := U_BUJUK;
                frmMain.SendTakeOnItem(U_BUJUK, Item.UserItem.MakeIndex, Item.S.name);
                DelItemBagByIdx(nItemIdx);
              end else begin
                DScreen.AddSysMsg('[毒药已经用完]', cllime);
                exit;
              end;
            end;
          end else begin
            Item := @g_UseItems[U_BUJUK];
          end;
          if Item.S.Shape = 1 then pcm.Def.Magic.btEffect := 4
          else pcm.Def.Magic.btEffect := MAGICEX_AMYOUNSUL;
        end else
          if (pcm.Def.Magic.wMagicId = SKILL_GROUPAMYOUNSUL) then
          begin

            if m_boGroupPoison then nCount := 3
            else nCount := 4;
            m_boGroupPoison := not m_boGroupPoison;
            if not CheckAmulet(1, nCount) then
            begin
              Item := GetAmulet(1, nCount, nItemIdx);
              if (Item = nil) and (g_UseItems[U_BUJUK].s.Name <> '') and (g_UseItems[U_BUJUK].s.StdMode = tm_Amulet) and
              (g_UseItems[U_BUJUK].s.Shape <= 2) then
              begin
                Item := @g_UseItems[U_BUJUK];
              end else begin
                if (Item = nil) and (nCount <> 2) then Item := GetAmulet(1, 2, nItemIdx);
                if Item <> nil then
                begin
                  if (g_WaitingUseItem.Item.S.name <> '') then Exit;
                  g_WaitingUseItem.Item := Item^;
                  g_WaitingUseItem.ItemType := mtBagItem;
                  g_WaitingUseItem.Index2 := U_BUJUK;
                  frmMain.SendTakeOnItem(U_BUJUK, Item.UserItem.MakeIndex, Item.S.name);
                  DelItemBagByIdx(nItemIdx);
                end else begin
                  DScreen.AddSysMsg('[毒药已经用完]', cllime);
                  exit;
                end;
              end;
            end else begin
              Item := @g_UseItems[U_BUJUK];
            end;
            if Item.S.Shape = 1 then pcm.Def.Magic.btEffect := 47
            else pcm.Def.Magic.btEffect := MAGICEX_AMYOUNSULGROUP;
          end;
      if g_MagicTarget = nil then
      begin
        PlayScene.CXYfromMouseXY(tx, ty, targx, targy);
        targid := 0;
      end
      else begin
        targx := g_MagicTarget.m_nCurrX;
        targy := g_MagicTarget.m_nCurrY;
        targid := g_MagicTarget.m_nRecogId;
      end;
      if CanNextAction and ServerAcceptNextAction then
      begin
        g_dwLatestSpellTick := GetTickCount;
        g_boLatestSpell := True;
        new(pmag);
        SafeFillChar(pmag^, sizeof(TUseMagicInfo), #0);
        pmag.EffectNumber := pcm.Def.Magic.btEffect;
        pmag.MagicSerial := pcm.Def.Magic.wMagicId;
        pmag.ServerMagicCode := 0;
        //pmag.nFrame := pcm.def.magic.nSpellFrame;

        g_dwMagicDelayTime := 500 + pcm.Def.Magic.dwDelayTime; //魔法延迟时间
        //g_dwMagicDelayTime := 0;

        case pmag.MagicSerial of
          2, 14, 15, 16, 17, 18, 19, 21, 12, 25, 26, 28, 29, 30, 31: ;
        else
          g_dwLatestMagicTick := GetTickCount;
        end;

        //PK时使用魔法
        g_dwMagicPKDelayTime := 0;
        if g_MagicTarget <> nil then
          if g_MagicTarget.m_btRace = 0 then
            g_dwMagicPKDelayTime := 300 + Random(1100);
        // 特别注意：Integer(pmag),该值将保存到 msg.feature,仅当actor=myself时
        if pmag.MagicSerial = 123 then
          tdir := g_MySelf.m_btDir;

        g_nLastMagicIdx := pcm.Def.Magic.wMagicId;
        g_MySelf.SendMsg(CM_SPELL, targx, targy, tdir, Integer(pmag), targid, '', 0);
        g_CboMagicID := -1;
      end; // else
    end;
  end
  else
    DScreen.AddSysMsg('[魔法值不够当前技能释放]', cllime);
end;

procedure TfrmMain.UseMagicSpell(who, effnum, targetx, targety, magic_id: Integer);
var
  Actor: TActor;
  adir: Integer;
  UseMagic: PTUseMagicInfo;
begin
  Actor := PlayScene.FindActor(who);
  if Actor <> nil then
  begin
    adir := GetFlyDirection(Actor.m_nCurrX, Actor.m_nCurrY, targetx, targety);
    new(UseMagic);
    SafeFillChar(UseMagic^, sizeof(TUseMagicInfo), #0);
    UseMagic.EffectNumber := effnum; //magnum;
    UseMagic.ServerMagicCode := 0; //烙矫
    UseMagic.MagicSerial := magic_id;
    //UseMagic.nFrame := GetMagicInfo(effnum).magic.nSpellFrame;
    Actor.SendMsg(SM_SPELL, 0, 0, adir, Integer(UseMagic), 0, '', 0);
    Inc(g_nSpellCount);
  end
  else
    Inc(g_nSpellFailCount);
end;

procedure TfrmMain.UseMagicFire(who, efftype, effnum, targetx, targety, target: Integer);
var
  Actor: TActor;
  sound: Integer;
    //  pmag: PTUseMagicInfo;
begin
  sound := 0; //jacky
  Actor := PlayScene.FindActor(who);
  if Actor <> nil then
  begin
    Actor.SendMsg(SM_MAGICFIRE, targetx, targety, target {111magid}, efftype, effnum, '', sound);
    if g_nFireCount < g_nSpellCount then
      Inc(g_nFireCount);
  end;
  g_MagicTarget := nil;
end;

procedure TfrmMain.UseMagicFireFail(who: Integer);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(who);
  if Actor <> nil then
  begin
    Actor.SendMsg(SM_MAGICFIRE_FAIL, 0, 0, 0, 0, 0, '', 0);
  end;
  g_MagicTarget := nil;
end;
//吃药

procedure TfrmMain.EatItem(idx: Integer);
var
  Stditem: TStdItem;
begin
  if g_dwEatTick > GetTickCount then Exit;
  if (g_EatingItem.Item.S.name <> '') and (GetTickCount - g_dwEatTime > 30 * 1000) then
  begin
    g_EatingItem.Item.S.name := '';
  end;
  if g_EatingItem.Item.S.name <> '' then exit;
  if idx in [Low(g_ItemArr)..High(g_ItemArr)] then
  begin
    if (g_ItemArr[idx].S.name <> '') then
    begin
      g_EatingItem.Item := g_ItemArr[idx];
      g_EatingItem.Index2 := idx;
      g_dwEatTime := GetTickCount;
      SendEat(@g_ItemArr[idx]);
      ItemUseSound(g_ItemArr[idx].S.StdMode);
    end;
  end
  else begin
    if (idx = -1) and g_boItemMoving  then
    begin
      g_EatingItem := g_MovingItem;
      AddItemBag(g_EatingItem.Item, g_EatingItem.Index2);
      ClearMovingItem();
      g_dwEatTime := GetTickCount;
      SendEat(@g_EatingItem.Item);
      ItemUseSound(g_EatingItem.Item.S.StdMode);
    end;
  end;
  g_sOpenItemName := '';
  if (g_EatingItem.Item.S.name <> '') and (g_EatingItem.Item.s.Reserved <> 0) then
  begin
    StdItem := GetStditem(g_EatingItem.Item.s.Reserved + 1);
    if (StdItem.Name <> '') and (GetBagItemCountByName(g_EatingItem.Item.S.name, 2) < 2) then
      g_sOpenItemName := StdItem.Name;
  end;
end;

function TfrmMain.TargetInSwordLongAttackRange(ndir: Integer): Boolean;
var
  nX, nY: Integer;
  Actor: TActor;
begin
  Result := FALSE;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nX, nY);
  GetFrontPosition(nX, nY, ndir, nX, nY);
  if (abs(g_MySelf.m_nCurrX - nX) = 2) or (abs(g_MySelf.m_nCurrY - nY) = 2) then
  begin
    Actor := PlayScene.FindActorXY(nX, nY);
    if Actor <> nil then
      if not Actor.m_boDeath then
        Result := True;
  end;
end;

function TfrmMain.TargetInSwordWideAttackRange(ndir: Integer): Boolean;
var
  nX, nY, rx, ry, mdir: Integer;
  Actor, ractor: TActor;
  I: Integer;
begin
  Result := FALSE;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nX, nY);
  Actor := PlayScene.FindActorXY(nX, nY);
  if Actor = nil then exit;
  for I := 1 to 7 do
  begin
    //if I = 4 then Continue;
    mdir := (ndir + I) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    Ractor := PlayScene.FindActorXY(rx, ry);
    if (Ractor <> nil) and (not Ractor.m_boDeath) then
    begin
      Result := True;
      exit;
    end;
  end;
  {mdir := (ndir + 1) mod 8;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
  ractor := PlayScene.FindActorXY(rx, ry);
  if ractor = nil then begin
    mdir := (ndir + 2) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  end;
  if ractor = nil then begin
    mdir := (ndir + 7) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  end;
  if (Actor <> nil) and (ractor <> nil) then
    if not Actor.m_boDeath and not Ractor.m_boDeath then
      Result := True;    }
end;

function TfrmMain.TargetInSwordCrsAttackRange(ndir: Integer): Boolean;
var
  nX, nY, rx, ry, mdir: Integer;
  Actor, ractor: TActor;
begin
  Result := FALSE;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nX, nY);
  Actor := PlayScene.FindActorXY(nX, nY);

  mdir := (ndir + 1) mod 8;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
  ractor := PlayScene.FindActorXY(rx, ry);
  if ractor = nil then
  begin
    mdir := (ndir + 2) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  end;
  if ractor = nil then
  begin
    mdir := (ndir + 7) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  end;

  if (Actor <> nil) and (ractor <> nil) then
    if not Actor.m_boDeath and not ractor.m_boDeath then
      Result := True;
end;

{--------------------- Mouse Interface ----------------------}

procedure TfrmMain.DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
const
  itemnames: string = '';
  itemnamewidth: Integer = 0;
var
  mx, my, sel: Integer;
  target: TActor;
begin
  g_nMouseX := X;
  g_nMouseY := Y;
  DScreen.ClearHint;
  g_nMiniMapX := -1;
  g_nMiniMapMaxX := -1;
  if g_boMapApoise or g_boShowFormImage then exit;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then
  begin
    g_TopDWindow.MouseMove(Shift, X, Y);
    Exit;
  end;
  if (Sender = Self) and g_DWinMan.MouseMove(Shift, X, Y) then
  begin
    if g_CursorMode = cr_None then
    begin
      Cursor := crMyNone;
    end;
    Exit;
  end;
  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then
    Exit;
  if GetTickCount > mousechecktime then
  begin
    mousechecktime := GetTickCount + 50;
    g_boSelectMyself := PlayScene.IsSelectMyself(X, Y);

    target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel, FALSE);
    if g_nDupSelection <> sel then
      g_nDupSelection := 0;
    if target <> nil then
    begin
      if (target.m_UserName = '') and (GetTickCount - target.m_dwSendQueryUserNameTime > 10 * 1000) then
      begin
        target.m_dwSendQueryUserNameTime := GetTickCount;
        SendQueryUserName(target.m_nRecogId, target.m_nCurrX, target.m_nCurrY);
      end;
      g_FocusCret := target;
      if g_CursorMode = cr_None then
      begin
        if (target.m_btRaceServer = RC_BOX) then
        begin
          Cursor := crOpenBox;
        end else
          if (target.m_btRaceServer = RC_NPC) then
          begin
            Cursor := crMyDialog;
          end
          else if ((target.m_btRace <> RCC_USERHUMAN) and (target.m_btRaceServer <> RC_GUARD) and (pos('(', target.m_UserName) = 0))
          or (ssShift in Shift) or (target.m_OldNameColor = ENEMYCOLOR) then
          begin
            Cursor := crMyAttack;
          end
          else
            Cursor := crMyNone;
      end;
    end
    else begin
      g_FocusCret := nil;
      if g_CursorMode = cr_None then
        Cursor := crMyNone;
    end;

    g_FocusItem := PlayScene.GetDropItems(X, Y, itemnames, itemnamewidth);
  end;
  if g_FocusItem <> nil then
  begin
    PlayScene.ScreenXYfromMCXY(g_FocusItem.X, g_FocusItem.Y, mx, my);
    DScreen.ShowHint(mx - itemnamewidth div 2,
                      my - 10,
                      itemnames, //PTDropItem(ilist[i]).Name,
                      clWhite,
                      True, Integer(g_FocusItem));
  end;
  PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);
  if ((ssLeft in Shift) or (ssRight in Shift)) and (GetTickCount - mousedowntime > 300) then
    _DXDrawMouseDown(Self, mbLeft, Shift, X, Y);
end;

procedure TfrmMain.DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
                                      Shift: TShiftState; X, Y: Integer);
begin
  if g_boMapApoise or g_boShowFormImage then exit;
  mousedowntime := GetTickCount;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then
  begin
    g_TopDWindow.MouseDown(Button, Shift, X, Y);
    Exit;
  end;
  //g_nRunReadyCount := 0; //档框摧扁 秒家(顿扁 牢版快)
  _DXDrawMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TfrmMain.AttackTarget(target: TActor);
var
  tdir, dx, dy, nHitMsg, nRate: Integer;
begin
  if (g_MySelf = nil) then exit;
  g_GuaJi.m_TargetCret := target;

  if (g_MySelf.m_btHorse <> 0) then
  begin
    if target.m_btRaceServer = RC_BOX then
    begin
      tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY);
      if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 1) and (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 1) and (not target.m_boDeath) then
      begin
        if CanNextAction and ServerAcceptNextAction and (tdir <> g_MySelf.m_btDir) then
        begin
          g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
        end else
          if CanNextAction and ServerAcceptNextAction then
          begin
            g_TargetCret := nil;
            if (GetTickCount - g_dwClickNpcTick) > 2000 then
            begin
              g_dwClickNpcTick := GetTickCount;
              SendClientMessage(CM_CLICKBOX, target.m_nRecogId, 0, 0, 0);
            end;
          end;
      end else begin
        if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 2) and (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 2) and (not target.m_boDeath) then
          g_ChrAction := caWalk
        else
          g_ChrAction := caRun; //跑步砍
        GetBackPosition(target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
        g_nTargetX := dx;
        g_nTargetY := dy;
      end;
    end else begin
      if g_UseItems[U_HOUSE].s.StdMode2 = 33 then
      begin
        tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY);
        if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 1) and (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 1) and (not target.m_boDeath) then
        begin
          if CanNextAction and ServerAcceptNextAction and CanNextHit then
          begin
            g_MySelf.SendMsg(CM_LONGHIT, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
            g_dwLatestHitTick := GetTickCount;
            g_CboMagicID := -1;
          end;
          g_dwLastAttackTick := GetTickCount;
        end else
          if CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY) and
          (not target.m_boDeath) and (GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY) <= 2) then
          begin

            if CanNextAction and ServerAcceptNextAction and CanNextHit then
            begin
              g_MySelf.SendMsg(CM_LONGHIT, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
              g_dwLatestHitTick := GetTickCount;
              g_CboMagicID := -1;
            end;
            g_dwLastAttackTick := GetTickCount;
          end else begin
            if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 3) and (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 3) and (not target.m_boDeath) then
              g_ChrAction := caWalk
            else
              g_ChrAction := caRun; //跑步砍
            GetBackPosition(target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
            g_nTargetX := dx;
            g_nTargetY := dy;
          end;
      end;
    end;
  end else begin
    nHitMsg := CM_HIT;
    if g_UseItems[U_WEAPON].S.StdMode2 = 6 then
      nHitMsg := CM_HEAVYHIT;
    //if target.m_btRaceServer = RC_BOX then begin
    //end else begin
    tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY);
    if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 1) and (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 1) and (not target.m_boDeath) then
    begin
      if target.m_btRaceServer = RC_BOX then
      begin
        if CanNextAction and ServerAcceptNextAction and (tdir <> g_MySelf.m_btDir) then
        begin
          g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
        end else
          if CanNextAction and ServerAcceptNextAction then
          begin
            g_TargetCret := nil;
            if (GetTickCount - g_dwClickNpcTick) > 2000 then
            begin
              g_dwClickNpcTick := GetTickCount;
              SendClientMessage(CM_CLICKBOX, target.m_nRecogId, 0, 0, 0);
            end;
          end;
      end else
        if CanNextAction and ServerAcceptNextAction and CanNextHit then
        begin
          if g_boCan110Hit then
          begin
            //氛 酒咆牢 版快, 绢八贱
            g_boCan110Hit := False;
            nHitMsg := CM_110;
            g_MyMagicArry[110].boNotUse := False;
            SetMagicUse(110);
            if g_CboMagicID = 110 then
              g_CboMagicID := -1;
          end
          else if g_boCan112Hit then
          begin
            //氛 酒咆牢 版快, 绢八贱
            g_boCan112Hit := False;
            nHitMsg := CM_112;
            g_MyMagicArry[112].boNotUse := False;
            SetMagicUse(112);
            if g_CboMagicID = 112 then
              g_CboMagicID := -1;
          end
          else if g_boCan113Hit then
          begin
            //氛 酒咆牢 版快, 绢八贱
            g_boCan113Hit := False;
            nHitMsg := CM_113;
            g_MyMagicArry[113].boNotUse := False;
            SetMagicUse(113);
            if g_CboMagicID = 113 then
              g_CboMagicID := -1;
          end
          else if g_boCan122Hit then
          begin
            g_boCan122Hit := False;
            nHitMsg := CM_122;
            g_MyMagicArry[122].boNotUse := False;
            SetMagicUse(122);
          end
          else if g_boCanLongIceHit then
          begin
            g_boCanLongIceHit := False;
            nHitMsg := CM_LONGICEHIT;
            g_MyMagicArry[43].boNotUse := False;
            SetMagicUse(43);
          end
          else if g_boCan56Hit then
          begin
            g_boCan56Hit := False;
            nHitMsg := CM_56;
            g_MyMagicArry[56].boNotUse := False;
            SetMagicUse(56);
          end
          else if g_boNextTimeFireHit and (g_MySelf.m_Abil.MP >= 7) then
          begin
            g_boNextTimeFireHit := FALSE;
            nHitMsg := CM_FIREHIT;
            g_MyMagicArry[26].boNotUse := False;
            SetMagicUse(26);
          end
          else if g_boNextTimePowerHit then
          begin
            //颇况 酒咆牢 版快, 抗档八过
            g_boNextTimePowerHit := FALSE;
            nHitMsg := CM_POWERHIT;
          end
          else if g_boCanTwnHit and (g_MySelf.m_Abil.MP >= 10) then
          begin
            g_boCanTwnHit := FALSE;
            nHitMsg := CM_TWINHIT;
          end
          else if (g_boCanWideHit and (g_MySelf.m_Abil.MP >= 3)) or
          (g_SetupInfo.boAutoWideHit and (g_MySelf.m_Abil.MP >= 3) and (TargetInSwordWideAttackRange(tdir))) then
          begin
            nHitMsg := CM_WIDEHIT;
          end
          else if g_boCanCrsHit and (g_MySelf.m_Abil.MP >= 6) then
          begin
            nHitMsg := CM_CRSHIT;
          end
          else if g_SetupInfo.boAutoLongHit or (g_boCanLongHit and (TargetInSwordLongAttackRange(tdir))) then
          begin
            nHitMsg := CM_LONGHIT;
          end;
          //g_SetupInfo.boAutoLongHit or (g_boCanLongHit and (TargetInSwordLongAttackRange(tdir)))
          g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
          g_dwLatestHitTick := GetTickCount;
          g_CboMagicID := -1;
        end;
      g_dwLastAttackTick := GetTickCount;
    end
    else begin
      nHitMsg := 0;
      if CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY) and
      (not target.m_boDeath) and (target.m_btRaceServer <> RC_BOX) then
      begin
        nRate := GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY);
        if CanNextAction and ServerAcceptNextAction and CanNextHit then
        begin
          if (nRate <= 4) and g_boCanLongIceHit and g_boLongIceHitIsLong then
          begin
            g_boCanLongIceHit := False;
            nHitMsg := CM_LONGICEHIT;
            g_MyMagicArry[43].boNotUse := False;
            SetMagicUse(43);
          end
          else if (nRate <= 4) and g_boCan56Hit then
          begin
            g_boCan56Hit := False;
            nHitMsg := CM_56;
            g_MyMagicArry[56].boNotUse := False;
            SetMagicUse(56);
          end
          else if (nRate <= 3) and g_boCan112Hit then
          begin
            g_boCan112Hit := False;
            nHitMsg := CM_112;
            g_MyMagicArry[112].boNotUse := False;
            SetMagicUse(112);
            if g_CboMagicID = 112 then
              g_CboMagicID := -1;
          end
          else if (nRate <= 2) and g_boCanLongIceHit then
          begin
            g_boCanLongIceHit := False;
            nHitMsg := CM_LONGICEHIT;
            g_MyMagicArry[43].boNotUse := False;
            SetMagicUse(43);
          end
          else if (nRate <= 2) and g_boCan122Hit then
          begin
            g_boCan122Hit := False;
            nHitMsg := CM_122;
            g_MyMagicArry[122].boNotUse := False;
            SetMagicUse(122);
          end
          else if (nRate <= 2) and g_boCanLongHit and g_SetupInfo.boAutoLongWide then
          begin
            nHitMsg := CM_LONGHIT;
          end;
          if nHitMsg <> 0 then
          begin
            g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
            g_dwLatestHitTick := GetTickCount;
            g_dwLastAttackTick := GetTickCount;
          end;
        end else begin
          if (nRate <= 2) and g_boCanLongHit and g_SetupInfo.boAutoLongWide then
          begin
            Exit;
          end;
        end;
      end;
      if nHitMsg = 0 then
      begin
        if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 2) and
        (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 2) and (not target.m_boDeath) then
          g_ChrAction := caWalk
        else
          g_ChrAction := caRun; //跑步砍
        GetBackPosition(target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
        g_nTargetX := dx;
        g_nTargetY := dy;
      end;
    end;
  end;
end;

procedure TfrmMain._DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
                                       Shift: TShiftState; X, Y: Integer);
var
  tdir, nX, nY, nHitMsg, sel: Integer;
  target: TActor;
begin
  ActionKey := 0;
  g_nMouseX := X;
  g_nMouseY := Y;
  g_boAutoDig := FALSE;
  if (Button = mbRight) and g_boItemMoving then
  begin
    //是否当前在移动物品
    FrmDlg.CancelItemMoving;
    Exit;
  end;
  if (Button = mbRight) and (g_CursorMode <> cr_None) then
  begin
    g_CursorMode := cr_None;
    Cursor := crMyNone;
    //FrmDlg.DMenuSellClick(Self, 0, 0);
    exit;
  end;

  if (Sender = Self) and g_DWinMan.MouseDown(Button, Shift, X, Y) then
    Exit; //鼠标移到窗口上了则跳过
  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then
    Exit; //如果人物退出则跳过

  if (g_CursorMode <> cr_None) and (g_CursorMode <> cr_Deal) then
  begin
    g_CursorMode := cr_None;
    Cursor := crMyNone;
    //FrmDlg.DMenuSellClick(Self, 0, 0);
    exit;
  end;
  try
    if g_boAutoMoveing then
    begin
      g_boAutoMoveing := False;
      g_boNpcMoveing := False;
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      g_nMiniMapOldX := -1;
      DScreen.AddSysMsg('[自动移动已停止]', clWhite);
      g_nMiniMapPath := nil;
    end;

    if ssRight in Shift then
    begin
      //鼠标右键

      if Shift = [ssRight] then
        Inc(g_nDupSelection); //般闷阑 版快 急琶
      target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel, FALSE); //取指定坐标上的角色
      if g_nDupSelection <> sel then
        g_nDupSelection := 0;
      if target <> nil then
      begin
        if ssCtrl in Shift then
        begin
          //CTRL + 鼠标右键 = 显示角色的信息
          if GetTickCount - g_dwLastMoveTick > 1000 then
          begin
            if (target.m_btRace = 0) and (not target.m_boDeath) then
            begin
              //取得人物信息
              //FrmDlg.DBackground.WantReturn := False;
              FrmDlg.OpenPlayPopupMemu(target, X, Y);
              //SendClientMessage(CM_QUERYUSERSTATE, target.m_nRecogId, target.m_nCurrX, target.m_nCurrY, 0);
              Exit;
            end;
          end;
        end;
      end
      else
        g_nDupSelection := 0;

      if g_MySelf.m_boShop then
        exit; //摆摊不允许操作

      //按鼠标右键，并且鼠标指向空位置
      PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);
      if (abs(g_MySelf.m_nCurrX - g_nMouseCurrX) <= 1) and (abs(g_MySelf.m_nCurrY - g_nMouseCurrY) <= 1) then
      begin
        //目标座标
        tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
        if CanNextAction and ServerAcceptNextAction and (tdir <> g_MySelf.m_btDir) then
        begin
          g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
        end;
      end
      else begin
        //如果不行跑步,则检测是否允许步行
        //else if GetTickCount - g_dwLastAttackTick > 300 then begin //最后攻击操作停留指定时间才能移动

        tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
        nX := g_MySelf.m_nCurrX;
        nY := g_MySelf.m_nCurrY;
        if g_MySelf.m_btHorse <> 0 then
        begin
          GetNextHorseRunXY(tdir, nX, nY);
          if PlayScene.CanHorseRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY) then
          begin
            g_ChrAction := caRun;
            g_nTargetX := nX;
            g_nTargetY := nY;
            Exit;
          end;
        end
        else begin
          GetNextRunXY(tdir, nX, nY);
          if g_boLeapDown and PlayScene.CanLeap(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY) then
          begin
            g_ChrAction := caLeap;
            g_nTargetX := nX;
            g_nTargetY := nY;
            Exit;
          end
          else if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, nX, nY) then
          begin
            g_ChrAction := caRun;
            g_nTargetX := nX;
            g_nTargetY := nY;
            Exit;
          end;
        end;
        nX := g_MySelf.m_nCurrX;
        nY := g_MySelf.m_nCurrY;
        GetNextPosXY(tdir, nx, ny);
        if PlayScene.CanWalk(nx, ny) then
        begin
          g_ChrAction := caWalk;
          g_nTargetX := nX;
          g_nTargetY := nY;
        end;
        Exit;
      end;
    end;
      //摆摊不允许操作左键
    if (ssLeft in Shift) {Button = mbLeft} and (not g_MySelf.m_boShop) then
    begin
//鼠标左键
      target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel, True); //混酒乐绰 仇父..
      if g_CursorMode = cr_Deal then
      begin
        if target <> nil then
        begin
          if (target.m_btRace = RCC_USERHUMAN) and (not Target.m_boDeath) and (GetTickCount > g_dwQueryMsgTick) then
          begin
            if target = g_MySelf then
              exit;
            g_dwQueryMsgTick := GetTickCount + 3000;
            frmMain.SendDealTry(target.m_nRecogId, target.m_nCurrX, target.m_nCurrY);
          end;
        end;
        exit;
      end;
      PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);
      g_TargetCret := nil;
      //骑马状态不可以操作
      if (g_UseItems[U_WEAPON].S.name <> '') and (target = nil) and (g_MySelf.m_btHorse = 0) then
      begin
        //挖矿
        if g_UseItems[U_WEAPON].S.Shape = 19 then
        begin
          //鹤嘴锄
          tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
          GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, nX, nY);
          if not Map.CanMove(nX, nY) or (ssShift in Shift) then
          begin
            //不能移动或强行挖矿
            if CanNextAction and ServerAcceptNextAction and CanNextHit then
            begin
              g_MySelf.SendMsg(CM_HIT + 1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
            end;
            if not Map.CanMove(nX, nY) then
              g_boAutoDig := True;
            Exit;
          end;
        end;
      end;
      //骑马状态不可以操作
      if (ssAlt in Shift) and (g_MySelf.m_btHorse = 0) then
      begin
        //挖物品
        tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
        if CanNextAction and ServerAcceptNextAction then
        begin
          target := PlayScene.ButchAnimal(g_nMouseCurrX, g_nMouseCurrY);
          if target <> nil then
          begin
            g_MySelf.SendMsg(CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, target.m_nRecogId, 0, '', 0);
            //SendButchAnimal(g_nMouseCurrX, g_nMouseCurrY, tdir, target.m_nRecogId);
            //g_MySelf.SendMsg(CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
            //Exit;
          end
          else
            g_MySelf.SendMsg(CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
        end;
        g_nTargetX := -1;
      end
      else begin
        if (target <> nil) or (ssShift in Shift) then
        begin
          //对象不为nil 或 Shift+左键
          g_nTargetX := -1;
          if target <> nil then
          begin
            if GetTickCount - g_dwLastMoveTick > 1000 then
            begin
              if (target.m_btRaceServer = RC_NPC) and (GetTickCount - g_dwClickNpcTick > 500) then
              begin
//点的目标商人
                g_dwClickNpcTick := GetTickCount;
                SendClientMessage(CM_CLICKNPC, target.m_nRecogId, 0, 0, 0);
                target.Click;
                Exit;
              end
              else if (target.m_btRace = RCC_USERHUMAN) and (target.m_boShop) and (GetTickCount - g_dwClickNpcTick > 500) then
              begin
                g_dwClickNpcTick := GetTickCount;
                SendClientMessage(CM_CLICKUSERSHOP, target.m_nRecogId, target.m_nCurrX, target.m_nCurrY, 0);
                Exit;
              end;
            end; //骑马不允许操作
            if (not target.m_boDeath) and (not target.m_boShop) and ((g_MySelf.m_btHorse = 0) or (g_UseItems[U_HOUSE].s.StdMode2 = 33) or (target.m_btRaceServer = RC_BOX)) then
            begin
              g_TargetCret := target;
              if ((target.m_btRace <> RCC_USERHUMAN) and
              (target.m_btRaceServer <> RC_GUARD) and
              (target.m_btRaceServer <> RC_NPC) and
              (pos('(', target.m_UserName) = 0)) or (ssShift in Shift) or
              (target.m_OldNameColor = ENEMYCOLOR) then
              begin

                AttackTarget(target);
                g_dwLatestHitTick := GetTickCount;
              end;
            end;
          end
          else begin
            //骑马不允许操作
            if (g_MySelf.m_btHorse = 0) then
            begin
              tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
              if CanNextAction and ServerAcceptNextAction and CanNextHit then
              begin
                nHitMsg := CM_HIT + Random(3);

                //是否可以使用刺杀
                if g_SetupInfo.boAutoLongHit or (g_boCanLongHit and (TargetInSwordLongAttackRange(tdir))) then
                begin
                  nHitMsg := CM_LONGHIT;
                end;
                if (g_boCanWideHit or g_SetupInfo.boAutoWideHit) and
                (g_MySelf.m_Abil.MP >= 3) and (TargetInSwordWideAttackRange(tdir)) then
                begin
                  //是否可以使用半月
                  nHitMsg := CM_WIDEHIT;
                end;
                g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
              end;
              g_dwLastAttackTick := GetTickCount;
            end;
          end;
        end
        else begin
          if (g_nMouseCurrX = (g_MySelf.m_nCurrX)) and (g_nMouseCurrY = (g_MySelf.m_nCurrY)) then
          begin
            AutoPickUpItem(False);
          end
          else if GetTickCount - g_dwLastAttackTick > 300 then
          begin
            //最后攻击操作停留指定时间才能移动
            {if ssCtrl in Shift then begin
              g_ChrAction := caRun;
            end
            else begin   }
            g_ChrAction := caWalk;
            //end;
            g_nTargetX := g_nMouseCurrX;
            g_nTargetY := g_nMouseCurrY;
          end;
        end;
      end;
    end;
  finally
    if (g_CursorMode <> cr_None) then
    begin
      g_CursorMode := cr_None;
      Cursor := crMyNone;
    end;
  end;
end;

procedure TfrmMain.DXDrawDblClick(Sender: TObject);
var
  pt: TPoint;
begin
  if g_boMapApoise or g_boShowFormImage then
    exit;
  GetCursorPos(pt);
  pt.X := pt.X - m_Point.X;
  pt.Y := pt.Y - m_Point.Y;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then
  begin
    g_TopDWindow.DblClick(pt.X, pt.Y);
    Exit;
  end;
  if g_DWinMan.DblClick(pt.X, pt.Y) then
    Exit;
end;

function TfrmMain.CheckDoorAction(dx, dy: Integer): Boolean;
var
  door: Integer;
begin
  Result := FALSE;
  //if not Map.CanMove (dx, dy) then begin
  //if (Abs(dx-Myself.XX) <= 2) and (Abs(dy-Myself.m_nCurrY) <= 2) then begin
  door := Map.GetDoor(dx, dy);
  if door > 0 then
  begin
    if not Map.IsDoorOpen(dx, dy) then
    begin
      SendClientMessage(CM_OPENDOOR, door, dx, dy, 0);
      Result := True;
    end;
  end;
  //end;
//end;
end;

procedure TfrmMain.DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
                                    Shift: TShiftState; X, Y: Integer);
begin
  FrmDlg.SayDlgDown := False;
  if g_boMapApoise or g_boShowFormImage then exit;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then
  begin
    g_TopDWindow.MouseUp(Button, Shift, X, Y);
    Exit;
  end;
  if g_DWinMan.MouseUp(Button, Shift, X, Y) then
    Exit;
  g_nTargetX := -1;
end;

procedure TfrmMain.DXDrawClick(Sender: TObject);
var
  pt: TPoint;
begin
  if g_boMapApoise or g_boShowFormImage then
    exit;

  GetCursorPos(pt);
  pt.X := pt.X - m_Point.X;
  pt.Y := pt.Y - m_Point.Y;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then
  begin
    g_TopDWindow.Click(pt.X, pt.Y);
    Exit;
  end;

  if g_DWinMan.Click(pt.X, pt.Y) then
    Exit;
end;

//鼠标事件:当选择了魔法等攻击前，显示一个选择被攻击对象的鼠标
procedure TfrmMain.MouseTimerTimer(Sender: TObject);
var
  pt: TPoint;
  keyvalue: TKeyBoardState;
  Shift: TShiftState;
begin
  if g_boChangeWindow or (g_MySelf = nil) then
    exit;
  GetCursorPos(pt);
  SetCursorPos(pt.X, pt.Y);
  if g_MySelf.m_boShop then
    exit;

  if g_TargetCret <> nil then
  begin
    if ActionKey > 0 then
    begin
      ProcessKeyMessages;
    end
    else begin
      //(target.m_btRace <> RCC_MERCHANT)
      if PlayScene.IsValidActor(g_TargetCret) and not g_TargetCret.m_boDeath then
      begin
        if (g_TargetCret.m_btRace <> RCC_MERCHANT) and
        ((g_MySelf.m_btHorse = 0) or (g_UseItems[U_HOUSE].s.StdMode2 = 33) or (g_TargetCret.m_btRaceServer = RC_BOX)) and
        ((g_TargetCret.m_btRace <> RCC_USERHUMAN) or (not g_TargetCret.m_boShop)) then
        begin
          SafeFillChar(keyvalue, sizeof(TKeyBoardState), #0);
          if GetKeyboardState(keyvalue) then
          begin
            Shift := [];
            if ((keyvalue[VK_SHIFT] and $80) <> 0) then
              Shift := Shift + [ssShift];
            if ((g_TargetCret.m_btRace <> RCC_USERHUMAN) and
            (g_TargetCret.m_btRaceServer <> RC_GUARD) and
            (g_TargetCret.m_btRaceServer <> RC_NPC) and
            (pos('(', g_TargetCret.m_UserName) = 0)) //宝宝
            or (g_TargetCret.m_OldNameColor = ENEMYCOLOR)
            or (((ssShift in Shift) or g_boShiftOpen) and (not FrmDlg.DEditChat.Visible)) then
            begin
              AttackTarget(g_TargetCret);
            end;
          end;                      //  (g_UseItems[U_HOUSE].s.StdMode2 = 33)
        end;
      end
      else
        g_TargetCret := nil;
    end;
  end;
  if g_boAutoDig and (g_MySelf.m_btHorse = 0) then
  begin
//自动挖矿
    if CanNextAction and ServerAcceptNextAction and CanNextHit then
    begin
      g_MySelf.SendMsg(CM_HIT + 1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_MySelf.m_btDir, 0, 0, '', 0);
    end;
  end;
  g_GuaJi.Run;
end;

procedure TfrmMain.MyCheckClient(var Msg: TMessage);
var
  nMsg: Integer;
  nHandle: THandle;
begin
  nHandle := Msg.WParam;
  nMsg := Msg.LParam;
  if nHandle = g_Login_Handle then
  begin
    case nMsg of
      MSG_CHECK_CLIENT_TEST: Msg.Result := 1;
      MSG_CHECK_CLIENT_EXIT: ;
    end;
  end;
end;

procedure TfrmMain.MyCopyDataMessage(var MsgData: TWmCopyData);
begin
  DebugOutStr(IntToStr(MsgData.From));
  case MsgData.From of
    COPYMSG_LOGIN_SENDSERVERLIST: Move(MsgData.CopyDataStruct^.lpData^, g_ServerInfo[0], MsgData.CopyDataStruct^.cbData);
    COPYMSG_LOGIN_WEBINFO:
    begin
      Move(MsgData.CopyDataStruct^.lpData^, g_WebInfo, MsgData.CopyDataStruct^.cbData);
//      g_DESKey := GetMD5TextOf16(g_WebInfo.g_UserList);
      g_DESKey := g_WebInfo.g_UserList;
      g_DESKey := Copy(g_DESKey, 5, 8);
//      g_PackPassword := GetMD5TextOf16(PackENRSA.EncryptStr(g_WebInfo.g_UserList));
      g_PackPassword := g_WebInfo.g_UserList;
      DebugOutStr(g_PackPassword);
      Caption := g_WebInfo.g_GameName;
      Application.Title := g_WebInfo.g_GameName;
      g_sLogoText := g_WebInfo.g_GameName;
    end;
  end;
end;

procedure TfrmMain.MyDeviceFinalize(Sender: TObject);
begin
  TimerRun.Enabled := False;
  g_DXCanvas := nil;
  UnLoadWMImagesLibEx();
  UnLoadColorLevels();
  //g_DXFont.Finalize;
  DScreen.Finalize;
  PlayScene.Finalize;
end;

procedure TfrmMain.MyDeviceInitialize(Sender: TObject; var Success: Boolean; var ErrorMsg: string);
var
  { di: TD3DAdapter_Identifier8;
  I: Integer;     }
  nCount: Integer;
begin
  HGETextures.InitializeTexturesInfo();
  Try
    g_LogoStr := RSADecodeString('bk9iZk7sqab=ZMlhJQVYmfhjgxddHaDZJcgyS7Sh9whNZ72w=y4');
  Except
  End;
  frmMain.Font.name := DEF_FONT_NAME;
  frmMain.Font.Size := DEF_FONT_SIZE;
  frmMain.Canvas.Font.name := DEF_FONT_NAME;
  frmMain.Canvas.Font.Size := DEF_FONT_SIZE;

  g_boInitialize := True;
  g_nInitializePer := 0;
  {HGEFont := TDXFont.Create;
  HGEFont.CreateTexture;
  HGEFont.Initialize('宋体', 9);}

  MShare.g_DXCanvas := TDXDrawCanvas.Create(g_DXFont);
  HGECanvas.g_DXCanvas := MShare.g_DXCanvas;
  g_Font := Font;

  nCount := g_DXFont.CreateTexture;
  if nCount = -1 then
  begin
    Success := False;
    ErrorMsg := 'Texture Size Error';
    exit;
  end; { else
  if nCount = 2 then begin
    Direct3DCompatible := True;
  end;  }

  //if g_boFirstTime then begin
  //g_boFirstTime := FALSE;
  CreateLogoSurface();

  while not FboShowLogo do
  begin
    AppOnIdle();
    Sleep(1);
    Application.ProcessMessages;
    if GetTickCount > FdwShowLogoTick then
    begin
      FdwShowLogoTick := GetTickCount + 30;
      //if FnShowLogoIndex < 400 then

      Inc(FnShowLogoIndex, 5);
{$IF Var_Interface = Var_Mir2}
      if FnShowLogoIndex = 400 then
      begin
        InitWMImagesLib(g_PackPassword);
        break;
      end;
{$ELSE}
      if FnShowLogoIndex = 400 then InitWMImagesLib(g_PackPassword);
{$IFEND}
    end;
  end;
  //g_nInitializePer := 10;
  //AppOnIdle();
  //Refresh; //刷新主窗口,以免全黑


  g_nInitializePer := 0;
  AppOnIdle();

  FrmDlg.Initialize();
  FrmDlg.InitializeEx();
  g_nInitializePer := 30;
  AppOnIdle();
  FrmDlg2.Initialize();
  FrmDlg2.InitializeEx();
  g_nInitializePer := 40;
  AppOnIdle();
  FrmDlg3.Initialize();
  FrmDlg3.InitializeEx();
  FrmDlg4.Initialize();
  FrmDlg4.InitializeEx();
  g_nInitializePer := 50;
  AppOnIdle();
  DScreen.Initialize;
  g_nInitializePer := 60;
  AppOnIdle();
  Success := PlayScene.Initialize;
  if not Success then
  begin
    ErrorMsg := 'PlayScene Initialize Error';
    exit;
  end;
  g_nInitializePer := 70;
  AppOnIdle();
  Success := g_DXFont.Initialize(DEF_FONT_NAME, DEF_FONT_SIZE);
  if not Success then
  begin
    ErrorMsg := 'Font Initialize Error';
    exit;
  end;
  //DScreen.Initialize;
  g_nInitializePer := 100;
  Try
    AppOnIdle();
    ErrorMsg := 'Error Code = 1';
    LoadColorLevels();
    ErrorMsg := 'Error Code = 2';
      //  nCount := HGE.GetD3D.GetAdapterCount;
    ErrorMsg := 'Error Code = 3';
    FrmDlg3.DDGSDisplay.Item.Clear;
    FrmDlg3.DDGSDisplay.Item.Add('默认显示器');
    ErrorMsg := 'Error Code = 9';
      {for I := 0 to nCount - 1 do begin
      HGE.GetD3D.GetAdapterIdentifier(I, 0, di);
      ErrorMsg := 'Error Code = 10';
      FrmDlg3.DDGSDisplay.Item.Add(di.Description);
    end; }
    ErrorMsg := 'Error Code = 4';
    FrmDlg3.DDGSDisplay.ItemIndex := 0;
    FrmDlg3.DDGSXY.ItemIndex := g_FScreenMode;
    FrmDlg3.DDGSBits.ItemIndex := 0;

    Sleep(100);
      {$IFDEF RELEASE}
      DLL_Encode6BitBuf := nil;
      {$ENDIF}
    ErrorMsg := 'Error Code = 5';
    DScreen.ChangeScene(stSelServer);
    ErrorMsg := 'Error Code = 6';
      {$IFDEF RELEASE}
{$IF Public_Ver <> Public_Free}
      EncryptFile_InitializationDataStream;
      DLL_Encode6BitBuf := Dll_Encrypt.FindExport(DecodeString('wxSKlhgF]kKWm     {     W<p<'));
      DLL_Decode6BitBuf := Dll_Encrypt.FindExport(DecodeString('whwKlhgF]kKWm     {     W<p<'));
{$IFEND}
      {$ENDIF}
    ErrorMsg := 'Error Code = 7';
{$IF Var_Interface = Var_Mir2}
    FBoShowLogo := True;
{$IFEND}
    g_boInitialize := False;
    TimerRun.Enabled := True;
    ErrorMsg := 'Error Code = 8';
//    if g_boFullScreen then begin
//      m_Point.X := 0;
//      m_Point.Y := 0;
//    end;
    asm
      finit; //D3D初始化引起时间错误, 重新初始化浮点单元解决问题
  end;
  ErrorMsg := 'Error Code = 9';
Except
Success := False;
End;
  //end;
end;

procedure TfrmMain.AutoPickUpItem(boFlag: Boolean);
var
  i: Integer;
  DropItem: pTDropItem;
begin
  if {CanNextAction and }ServerAcceptNextAction then
  begin
    TempItemList.Clear;
    PlayScene.GetXYDropItemsList(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, TempItemList);
    if TempItemList.Count > 0 then
    begin
      if boFlag and (not g_SetupInfo.boAutoPickUpItem) then
      begin
        for I := 0 to TempItemList.Count - 1 do
        begin
          DropItem := TempItemList.Items[i];
          if DropItem.Filtr.boPickUp then
          begin
            SendPickup;
            Break;
          end;
        end;
      end
      else
        SendPickup;
    end;
  end;
end

;

procedure TfrmMain.WaitMsgTimerTimer(Sender: TObject);
begin
  if g_boChangeWindow then exit;
  if g_MySelf = nil then Exit;
  if g_MySelf.ActionFinished then
  begin
    WaitMsgTimer.Enabled := FALSE;
    //      PlayScene.MemoLog.Lines.Add('WaitingMsg: ' + IntToStr(WaitingMsg.Ident));
    case WaitingMsg.ident of
      SM_CHANGEMAP,
      SM_CHANGEMAP_OLD:
      begin
{$IF CHANGEMAPMODE = NEWMAPMODE}
        if WaitingMsg.ident = SM_CHANGEMAP then
        begin
          g_boMapInitialize := True;
          g_btMapinitializePos := 0;
          g_boMapApoise := True;
        end;
{$IFEND}
        g_boMapMovingWait := FALSE;
        Map.m_OldClientRect.Left := -1;
        if g_LegendMap.Title <> WaitingStr then
        begin
          ClearBGM;
          g_LegendMap.LoadFileData(GetMapDirAndName(WaitingStr));
        end;
        g_LegendMap.Title := WaitingStr;
        if g_boAutoMoveing and g_boNpcMoveing and (g_nScriptGotoStr <> '') then
          g_boNpcMoveing := True
        else
          g_boNpcMoveing := False;

        g_boAutoMoveing := False;
        g_nMiniMapPath := nil;
        if g_nMDlgX <> -1 then
        begin
          FrmDlg.CloseMDlg;
          g_nMDlgX := -1;
        end;
        if g_nMyReadShopDlgX <> -1 then
        begin
          FrmDlg2.DReadUserShop.Visible := False;
          g_nMyReadShopDlgX := -1;
        end;
        ClearDropItems;
        EventMan.ClearEvents;
        PlayScene.CleanObjects;
        g_sMapTitle := '';
        g_MapDesc := nil;
        g_MySelf.CleanCharMapSetting(WaitingMsg.param, WaitingMsg.tag);
        g_nTargetX := -1;
        g_TargetCret := nil;
        g_FocusCret := nil;
        g_MagicLockTarget := nil;
        g_NPCTarget := nil;
        g_MagicTarget := nil;

        PlayScene.SendMsg(SM_CHANGEMAP, 0,
                           WaitingMsg.param {x},
                           WaitingMsg.tag {y},
                           WaitingMsg.series {darkness},
                           0, 0,
                           WaitingStr {mapname});
{$IF CHANGEMAPMODE = NEWMAPMODE}
        if WaitingMsg.ident = SM_CHANGEMAP then
        begin
          InitializeMap(WaitingStr);
        end;
{$ELSE}
        TimerInitialize.Enabled := True;
{$IFEND}
        ReleaseDCapture;
      end;
    end;
  end;
end

;

function TfrmMain.EatItembyName(sItemName: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  if sItemName = '' then Exit;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do
  begin
    if (g_ItemArr[i].S.Name = sItemName) then
    begin
      EatItem(i);
      Result := True;
      break;
    end;
  end;
end

;

function TfrmMain.EatItemByType(nType: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do
  begin
    if (g_ItemArr[i].S.Name <> '') then
    begin
      case nType of
        4:
        begin
          if (g_ItemArr[i].s.StdMode = tm_Drug) and (g_ItemArr[i].s.Shape = 1) and (g_ItemArr[i].s.nMAC > 0) then
          begin
            EatItem(i);
            Result := True;
            break;
          end;
        end;
        3:
        begin
          if (g_ItemArr[i].s.StdMode = tm_Drug) and (g_ItemArr[i].s.Shape = 1) and (g_ItemArr[i].s.nAC > 0) then
          begin
            EatItem(i);
            Result := True;
            break;
          end;
        end;
        2:
        begin
          if (g_ItemArr[i].s.StdMode = tm_Drug) and (g_ItemArr[i].s.Shape = 0) and (g_ItemArr[i].s.nMAC > 0) then
          begin
            EatItem(i);
            Result := True;
            break;
          end;
        end;
        1:
        begin
          if (g_ItemArr[i].s.StdMode = tm_Drug) and (g_ItemArr[i].s.Shape = 0) and (g_ItemArr[i].s.nAC > 0) then
          begin
            EatItem(i);
            Result := True;
            break;
          end;
        end;
      end;
    end;
  end;
end

;

procedure TfrmMain.WgTimerTimer(Sender: TObject);
const
  boIsRun: Boolean = False;
var
  i: Integer;
  ClientMissionInfo: pTClientMissionInfo;
  ClientMission: pTClientMission;
  boChange: Boolean;
  OldCount: Integer;
begin
  if boIsRun or (g_MySelf = nil) or g_boWgVisible or g_boChangeWindow or (g_MySelf.m_boDeath) then
    Exit;
  boIsRun := True;
  try
      //if (GetTickCount - g_DControlFreeTick) > 30 then
    for i := 0 to g_DControlFreeList.Count - 1 do
      TDControl(g_DControlFreeList[i]).Free;
    g_DControlFreeList.Clear;
      {g_DControlFreeList: TList;
  g_DControlFreeTick: LongWord = 0; }


      //回城物品保护
    if g_SetupInfo.boHpProtect3 and
    (g_EatingItem.Item.S.name = '') and
    (GetTickCount > g_dwEatTick) and
    (g_MySelf.m_Abil.HP <= g_SetupInfo.nHpProtectCount3) and
    (GetTickCount > g_dwHpProtectTime3) then
    begin
      g_dwHpProtectTime3 := GetTickCount + g_SetupInfo.dwHpProtectTime3 * 1000;
      if (g_SetupInfo.btHpProtectIdx < FrmDlg3.DDPReelItem.Item.Count) then
      begin
        if not EatItembyName(FrmDlg3.DDPReelItem.Item[g_SetupInfo.btHpProtectIdx]) then
        begin
          if GetTickCount > g_dwHpProtectTick3 then
          begin
            g_dwHpProtectTick3 := GetTickCount + 5000;
            DScreen.AddSysMsg('您的[<CO$FFFF>' + FrmDlg3.DDPReelItem.Item[g_SetupInfo.btHpProtectIdx] + '<CE>]已经用完', clAqua);
          end;
        end;
      end;
    end;
      //特殊金创药保护
    if g_SetupInfo.boHpProtect2 and (g_EatingItem.Item.S.name = '') and (GetTickCount > g_dwEatTick) and
    (g_MySelf.m_Abil.HP <= g_SetupInfo.nHpProtectCount2) and (GetTickCount > g_dwHpProtectTime2) then
    begin
      g_dwHpProtectTime2 := GetTickCount + g_SetupInfo.dwHpProtectTime2 * 1000;
      if not EatItembyType(3) then
      begin
        if GetTickCount > g_dwHpProtectTick2 then
        begin
          g_dwHpProtectTick2 := GetTickCount + 5000;
          DScreen.AddSysMsg('您的[<CO$FFFF>特效金创药<CE>]已经用完', clAqua);
        end;
      end;
    end;

      //HP保护
    if g_SetupInfo.boHpProtect and (g_EatingItem.Item.S.name = '') and (GetTickCount > g_dwEatTick) and
    (g_MySelf.m_Abil.HP <= g_SetupInfo.nHpProtectCount) and (GetTickCount > g_dwHpProtectTime) then
    begin
      g_dwHpProtectTime := GetTickCount + g_SetupInfo.dwHpProtectTime * 1000;
      if not EatItembyType(1) then
      begin
        if GetTickCount > g_dwHpProtectTick then
        begin
          g_dwHpProtectTick := GetTickCount + 5000;
          DScreen.AddSysMsg('您的[<CO$FFFF>金创药<CE>]已经用完', clAqua);
        end;
      end;
    end;

      //特殊魔法药保护
    if g_SetupInfo.boMpProtect2 and (g_EatingItem.Item.S.name = '') and (GetTickCount > g_dwEatTick) and
    (g_MySelf.m_Abil.MP <= g_SetupInfo.nMpProtectCount2) and (GetTickCount > g_dwMpProtectTime2) then
    begin
      g_dwMpProtectTime2 := GetTickCount + g_SetupInfo.dwMpProtectTime2 * 1000;
      if not EatItembyType(4) then
      begin
        if GetTickCount > g_dwMpProtectTick2 then
        begin
          g_dwMpProtectTick2 := GetTickCount + 5000;
          DScreen.AddSysMsg('您的[<CO$FFFF>特效魔法药<CE>]已经用完', clAqua);
        end;
      end;
    end;

      //MP保护
    if g_SetupInfo.boMpProtect and (g_EatingItem.Item.S.name = '') and (GetTickCount > g_dwEatTick) and
    (g_MySelf.m_Abil.MP <= g_SetupInfo.nMpProtectCount) and (GetTickCount > g_dwMpProtectTime) then
    begin
      g_dwMpProtectTime := GetTickCount + g_SetupInfo.dwMpProtectTime * 1000;
      if not EatItembyType(2) then
      begin
        if GetTickCount > g_dwMpProtectTick then
        begin
          g_dwMpProtectTick := GetTickCount + 5000;
          DScreen.AddSysMsg('您的[<CO$FFFF>魔法药<CE>]已经用完', clAqua);
        end;
      end;
    end;

      //自动捡取

    if (GetTickCount() - g_dwAutoPickupTick) > g_dwAutoPickupTime then
    begin
      g_dwAutoPickupTick := GetTickCount();
      AutoPickUpItem(True);
    end;

      //持久警告
    if g_SetupInfo.boDuraHint and ((GetTickCount() - g_dwDuraAlertTick) > g_dwDuraAlertTime) then
    begin
      g_dwDuraAlertTick := GetTickCount();
      for I := Low(g_UseItems) to High(g_UseItems) do
      begin
        if (g_UseItems[I].S.Name <> '') and (sm_Arming in g_UseItems[I].S.StdModeEx) then
        begin
          if (Round(g_UseItems[I].UserItem.Dura / 100) <= 1) then
            DScreen.AddSysMsg('您的装备[<CO$FFFF>' + g_UseItems[I].S.Name + '<CE>]持久过低', clAqua);
        end;
      end;
    end;


    if g_boCanDraw then
    begin
      //自动练功
      if g_SetupInfo.boAutoMagic and (g_MySelf.m_btHorse = 0) and (not (g_SetupInfo.nAutoMagicIndex in [3, 4, 7])) and
      (g_SetupInfo.nAutoMagicIndex > 0) and (g_SetupInfo.nAutoMagicIndex < SKILL_MAX) and
      ((GetTickCount() - g_dwAutoMagicTime) > g_SetupInfo.dwAutoMagicTick) and
      (not FrmDlg.DDealDlg.Visible) and
      (g_MyMagicArry[g_SetupInfo.nAutoMagicIndex].boStudy) then
      begin
        g_dwAutoMagicTime := GetTickCount();
        UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[g_SetupInfo.nAutoMagicIndex]);
      end;


      //自动开盾
      if g_SetupInfo.boAutoShield and g_MyMagicArry[SKILL_SHIELD].boStudy and (g_MySelf.m_btHorse = 0) and
      ((g_MySelf.m_nState and $00100000) = 0) and (g_CboMagicID = -1) and (not FrmDLg2.DWndBar.Visible) and
      (not FrmDlg.DDealDlg.Visible) and
      (GetTickCount > (g_MyMagicArry[SKILL_SHIELD].dwInterval + 500))  then
      begin
        UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[SKILL_SHIELD]);
      end;

      //自动开天斩
      if g_SetupInfo.boAutoLongIceHit and (g_MySelf.m_btHorse = 0) and g_MyMagicArry[SKILL_LONGICEHIT].boStudy and (not FrmDLg2.DWndBar.Visible) and
      ((g_MySelf.m_nState and $00100000) = 0) and (g_CboMagicID = -1) and (not g_boNextTimeFireHit) and (not g_boCanLongIceHit) and
      (not FrmDlg.DDealDlg.Visible) and
      (GetTickCount > (g_MyMagicArry[SKILL_LONGICEHIT].dwInterval + 500))  then
      begin
        UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[SKILL_LONGICEHIT]);
      end;

      //自动烈火
      if g_SetupInfo.boAutoFireHit and (g_MySelf.m_btHorse = 0) and g_MyMagicArry[SKILL_FIRESWORD].boStudy and (not FrmDLg2.DWndBar.Visible) and
      ((g_MySelf.m_nState and $00100000) = 0) and (g_CboMagicID = -1) and (not g_boNextTimeFireHit) and (not g_boCanLongIceHit) and
      (not FrmDlg.DDealDlg.Visible) and
      (GetTickCount > (g_MyMagicArry[SKILL_FIRESWORD].dwInterval + 500))  then
      begin
        UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[SKILL_FIRESWORD]);
      end;


    end;

      //自动隐身
      {if g_SetupInfo.boAutoCloak and g_MyMagicArry[SKILL_CLOAK].boStudy and
      ((g_MySelf.m_nState and $00800000) = 0) and
      (GetTickCount > g_MyMagicArry[SKILL_CLOAK].dwInterval)  then begin
      UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[SKILL_CLOAK]);
    end;        }

    if GetTickCount > g_RefMissionItemTick then
    begin
      g_RefMissionItemTick := GetTickCount + 1500;

      for ClientMissionInfo in g_MissionInfoList do
      begin
        ClientMission := ClientMissionInfo.ClientMission;
        boChange := False;
        if (ClientMission.CompleteItem[0].sItemName <> '') then
        begin
          OldCount := ClientMissionInfo.nItemCount1;
          ClientMissionInfo.nItemCount1 := GetBagItemCountByName(ClientMission.CompleteItem[0].sItemName,
                                                                  ClientMission.CompleteItem[0].wItemCount);
          if ClientMissionInfo.nItemCount1 <> OldCount then
            boChange := True;
        end;
        if (ClientMission.CompleteItem[1].sItemName <> '') then
        begin
          OldCount := ClientMissionInfo.nItemCount2;
          ClientMissionInfo.nItemCount2 := GetBagItemCountByName(ClientMission.CompleteItem[1].sItemName,
                                                                  ClientMission.CompleteItem[1].wItemCount);
          if ClientMissionInfo.nItemCount2 <> OldCount then
            boChange := True;
        end;
        if (ClientMission.CompleteItem[2].sItemName <> '') then
        begin
          OldCount := ClientMissionInfo.nItemCount3;
          ClientMissionInfo.nItemCount3 := GetBagItemCountByName(ClientMission.CompleteItem[2].sItemName,
                                                                  ClientMission.CompleteItem[2].wItemCount);
          if ClientMissionInfo.nItemCount3 <> OldCount then
            boChange := True;
        end;
        if boChange and (ClientMission.NPC <> nil) then
          PlayScene.SetMissionInfo(ClientMission.NPC);

        if boChange and (FrmDlg3.DTrvwMission.Select <> nil) and
        (FrmDlg3.DTrvwMission.Select.Item = ClientMissionInfo) then
          FrmDlg3.MDlgChange := True;
        if boChange and ClientMissionInfo.MissionInfo.boTrack then
          FrmDlg2.m_boShowMissionChange := True;

      end;
    end;
{$IF Var_Interface =  Var_Default}
    if GetTickCount > g_dwOperateHintTick then
    begin
      g_dwOperateHintTick := GetTickCount + 15000;
      Inc(g_nOperateHintIdx);
      if g_nOperateHintIdx >= g_OperateHintList.Count then g_nOperateHintIdx := 0;
      if (g_nOperateHintIdx >= 0) and (g_nOperateHintIdx < g_OperateHintList.Count) then
        if g_OperateHintList[g_nOperateHintIdx] <> '' then
          PlayScene.SetOperateHint(g_OperateHintList[g_nOperateHintIdx])
        else
          g_dwOperateHintTick := 0;
    end;
{$IFEND}

      //自动喊话
      {if (g_AutoSysMsg) and ((GetTickCount - g_AutoMsgTick) > g_AutoMsgTime) then begin
      g_AutoMsgTick := GetTickCount;
      SendSay(g_AutoMsg);
    end; }
  finally
    boIsRun := False;
  end;

end

;

{----------------------- Socket -----------------------}
//在选择服务器后开启，等待一段时间后进入选择角色状态（等待“开门”的动画完成）
procedure TfrmMain.SelChrWaitTimerTimer(Sender: TObject);
begin
  if g_boChangeWindow then
    exit;
  SelChrWaitTimer.Enabled := FALSE;
  SendQueryChr;
  boOpenLoginDoor := True;
end

;

procedure TfrmMain.ActiveCmdTimer(cmd: TTimerCommand);
begin
  CmdTimer.Enabled := True;
  TimerCmd := cmd;
end

;

procedure TfrmMain.AddSystemMsg(sMsg: string; MsgColor: TColor);
begin
  sMsg := AnsiReplaceText(sMsg, '#5', #5);
  sMsg := AnsiReplaceText(sMsg, '#6', #6);
  sMsg := AnsiReplaceText(sMsg, '#7', #7);
  DScreen.AddSayMsg(sMsg, MsgColor, clBlack, True, us_Sys);
end

;
//处理跟网络连接有关的几个事件
procedure TfrmMain.CmdTimerTimer(Sender: TObject);
begin
  if g_boChangeWindow then exit;
  CmdTimer.Enabled := FALSE;
  CmdTimer.Interval := 1000;
  case TimerCmd of
    tcSoftClose:
    begin
      CmdTimer.Enabled := FALSE;
      CSocket.Socket.Close;
    end;
    tcReSelConnect:
    begin
      ResetGameVariables;  //清除所有对象
      g_ConnectionStep := cnsReSelChr;   //重新连接服务器
      with CSocket do
      begin
        Active := FALSE;
        Address := g_sSelChrAddr;
        Port := g_nSelChrPort;
        Active := True;
      end;
    end;
    tcFastQueryChr:
    begin
//查询角色
      ResetGameVariables;
      SendQueryChr;
    end;
  end;
end

;

procedure TfrmMain.CreateClientSocket(sAddrs: string; wPort: Word; nIndex: Integer);
begin
  With TClientSocket.Create(Nil) do
  begin
    Active := False;
    Socket.nIndex := nIndex;
    ClientType := ctNonBlocking;
    OnConnect := ClientSocketConnect;
    OnError := ClientSocketError;
    OnRead := ClientSocketRead;
    Host := sAddrs;
    Port := wPort;
    Active := True;
  end;
end

;

procedure TfrmMain.CloseAllWindows;
begin
  FrmDlg.MDlgVisible := False;
  with FrmDlg4 do
  begin
    DWndArmAbilityMove.Visible := False;
    DWndCompound.Visible := False;
    DTopMsg.Visible := False;
    DWndItemRemove.Visible := False;
    DWndMagicKey.Visible := False;
    m_TopMsgList.Clear;
  end;
  with FrmDlg3 do
  begin
    DWndArmStrengthen.Visible := False;
    DWndMakeItem.Visible := False;
    DWndItemUnseal.Visible := False;
    DGuildDlg.Visible := False;
    DGameSetup.Visible := False;
    dwndMission.Visible := False;
    dwndBox.Visible := False;
    MDlgStr := '';
    ShowCanAccept := False;
    DWindowTop.Visible := False;

    InitializeMissionTree;
    FboTopSend := False;
  end;
  with FrmDlg2 do
  begin
    DWndHint.Visible := False;
    DWndGroup.Visible := False;
    IconButtonLayout.Visible := False;
    DShopWin.Visible := False;
    DWinEmail.Visible := False;
    DWinFriend.Visible := False;
    DWndEMailRead.Visible := False;
    DWndEMailNew.Visible := False;
    DWinUpLoad.Visible := False;
    DWndUserShop.Visible := False;
    DUserShopOpen.Enabled := True;
    DReadUserShop.Visible := False;
    DStorageDlg.Visible := False;
    DWndDeath.Visible := False;
    DWndBar.Visible := False;
    DWndWeb.Visible := False;
    dwndSysSetup.Visible := False;
    m_boShowMissionChange := True;
  end;
  with FrmDlg do
  begin
    DMaxMiniMap.Visible := False;
    DItemBag.Visible := FALSE;
    DWndFace.Visible := False;
    DWudItemShow.Visible := False;
    DStateWin.Visible := False; //人物信息栏
    DUserState.Visible := False;
    DMerchantDlg.Visible := False;
    DDealDlg.Visible := FALSE;
    DGroupDlg.Visible := False;
    DItemAppendBag1.Visible := False;
    DItemAppendBag2.Visible := False;
    DItemAppendBag3.Visible := False;
    DWndAttackModeList.Visible := False;
    dwndSayMode.Visible := False;
    dwndWhisperName.Visible := False;
    DTopStatusEXP.Visible := False;
    DTopStatusPOW.Visible := False;
    DTopStatusSC.Visible := False;
    DTopStatusAC.Visible := False;
    DTopStatusDC.Visible := False;
    DTopStatusHIDEMODE.Visible := False;
    DTopStatusSTONE.Visible := False;
    DTopStatusMC.Visible := False;
    DTopStatusMP.Visible := False;
    DTopStatusMAC.Visible := False;
    DTopStatusHP.Visible := False;
    DTopStatusDAMAGEARMOR.Visible := False;
    DTopStatusDECHEALTH.Visible := False;
    DTopStatusCOBWEB.Visible := False;
    DBTCheck1.Visible := False;
    DBTCheck2.Visible := False;
    DBTCheck3.Visible := False;
    DBTCheck4.Visible := False;
    DBTCheck5.Visible := False;
    DBTCheck6.Visible := False;
    DBTCheck7.Visible := False;
    DBTCheck8.Visible := False;
    DBTCheck9.Visible := False;
    DBTCheck10.Visible := False;
    DMiniMap.Visible := False;
    MagicList1.Clear;
    MagicList2.Clear;
  end;
  g_DWinMan.CloseModalShow();
  if g_nMDlgX <> -1 then
  begin
    FrmDlg.CloseMDlg;
    g_nMDlgX := -1;
  end;
  g_nMyReadShopDlgX := -1;
  g_boItemMoving := FALSE;
  g_GuaJi.Started := False;
end

;

procedure TfrmMain.ClearDropItems;
var
  i: Integer;
  DropItem: pTDropItem;
begin
  for i := 0 to g_DropedItemList.count - 1 do
  begin
    DropItem := g_DropedItemList[i];
    {if DropItem.d <> nil then
      DropItem.d.Free;
    DropItem.d := nil; }
    Dispose(DropItem);
  end;
  g_DropedItemList.Clear;
  for i := 0 to g_FreeItemList.count - 1 do
  begin
    DropItem := g_FreeItemList[i];
    { if DropItem.d <> nil then
       DropItem.d.Free;
     DropItem.d := nil;  }
    Dispose(DropItem);
  end;
  g_FreeItemList.Clear;
end

;

procedure TfrmMain.ResetGameVariables;
var
  i: Integer;
  ii: Integer;
    //  ClientMagic: PTClientMagic;
begin
  try
    g_CursorMode := cr_None;
    Cursor := crMyNone;
    SaveIDInfo();
    SaveHumInfo(CharName);
    CloseAllWindows;
    ClearDropItems;
    ClearEMailInfo();
    FrmDlg2.DUpLoadOk.Caption := '确认上传';
    FrmDlg.DStateInfoUpLoadPic.Enabled := True;
    FrmDlg2.DUpLoadOk.Enabled := True;
    FrmDlg.DStateInfoUpLoadPic.Enabled := True;
      //ClearShowItemList();
    for I := 2 to 5 do
    begin
      for II := 0 to g_ShopList[i].Count - 1 do
      begin
        Dispose(pTShopItem(g_ShopList[i].Items[ii]));
      end;
      g_ShopList[i].Clear;
    end;
    g_ShopList[0].Clear;
    g_ShopList[1].Clear;
    for I := Low(g_ShopGoldList) to High(g_ShopGoldList) do
    begin
      g_ShopGoldList[i].Clear;
    end;
    for I := Low(g_StatusInfoArr) to High(g_StatusInfoArr) do
      g_StatusInfoArr[I].dwTime := 0;
    g_StatusInfoList.Clear;
    g_ShopBuyItem := nil;
    g_boShiftOpen := False;
      {for i := Low(g_MyMagic) to High(g_MyMagic) do
      g_MyMagic[i] := nil;  }
    SafeFillChar(g_MyMagicArry, SizeOf(g_MyMagicArry), #0);

    if (FrmDlg2.HDInfoSurface <> nil) then
      FrmDlg2.HDInfoSurface.Free;
    FrmDlg2.HDInfoSurface := nil;
    if (FrmDlg2.HDSaveJpeg <> nil) then
      FrmDlg2.HDSaveJpeg.Free;
    FrmDlg2.HDSaveJpeg := nil;

    if (FrmDlg.MyHDInfoSurface <> nil) then
      FrmDlg.MyHDInfoSurface.Free;
    FrmDlg.MyHDInfoSurface := nil;
    FrmDlg.DMagicIndex := 0;
    FrmDlg.DMagicSub.Left := 185 - 8;
      {if (FrmDlg.MyHDDIB <> nil) then FrmDlg.MyHDDIB.Free;
    FrmDlg.MyHDDIB := nil;

    if FrmDlg.UserHDDIB <> nil then FrmDlg.UserHDDIB.Free;
    FrmDlg.UserHDDIB := nil;   }
    if FrmDlg.UserHDInfoSurface <> nil then
      FrmDlg.UserHDInfoSurface.Free;
    FrmDlg.UserHDInfoSurface := nil;

      //ClearGetSayItemList();
    for i := 0 to g_QuestMsgList.Count - 1 do
    begin
      if pTClientCheckMsg(g_QuestMsgList[i]) <> g_ClientCheckMsg then
        Dispose(pTClientCheckMsg(g_QuestMsgList[i]));
    end;

    for I := 0 to g_CenterMsgList.Count - 1 do
    begin
      Dispose(pTCenterMsg(g_CenterMsgList[I]));
    end;
    g_CenterMsgList.Clear;
    for I := 0 to g_SetItemsList.Count - 1 do
      Dispose(pTSetItems(g_SetItemsList[I]));

    g_SetItemsList.Clear;

    if g_ClientCheckMsg <> nil then
      Dispose(g_ClientCheckMsg);
    g_ClientCheckMsg := nil;
    g_nNakedCount := 0;
    g_nNakedBackCount := 0;
    g_FBTime := -1;
    g_FBExitTime := -1;
    g_FBFailTime := -1;
    SafeFillChar(g_ClientNakedInfo, SizeOf(g_ClientNakedInfo), #0);
    SafeFillChar(g_ClientNakedAddAbil, SizeOf(g_ClientNakedAddAbil), #0);
    SafeFillChar(g_UserKeySetup, SizeOf(g_UserKeySetup), #0);
    SafeFillChar(g_UserKeyIndex, SizeOf(g_UserKeyIndex), #0);
    SafeFillChar(g_CboMagicList, SizeOf(g_CboMagicList), #0);
    SafeFillChar(g_SendSelectItem, SizeOf(g_SendSelectItem), #0);
    SafeFillChar(g_Selectitem, SizeOf(g_Selectitem), #0);
    SafeFillChar(g_GuildIndex, SizeOf(g_GuildIndex), #0);
    SafeFillChar(g_ClientGuildInfo, SizeOf(g_ClientGuildInfo), #0);
    SetDefaultSetupInfo;
    g_CboMagicID := -1;
    g_QuestMsgList.Clear;
    g_boItemMoving := FALSE;
    g_boSendMakeMagicAdd := False;
    g_WaitingUseItem.Item.S.name := '';
    g_EatingItem.Item.S.name := '';
    g_dwEatTick := 0;
    g_MoveAddBagItem.Item.s.name := '';
    g_sOpenItemName := '';
    g_UniteUseItem.Item.s.Name := '';
    g_DealDlgItem.Item.s.Name := '';
    g_SellDlgItemSellWait.Item.s.name := '';
    g_SendRemoveStoneItem.s.name := '';
    g_MyShopItem.Item.s.Name := '';
    g_boLeapDown := False;
    g_nTargetX := -1;
    FrmDlg.dchkSayLock.Checked := True;
    g_SayUpDownLock := False;
    g_SayMode := usm_Hear;
      //g_SayShowType := us_All;
      //g_SayShowCustom := [];
    SafeFillChar(g_SayEffectIndex, SizeOf(g_SayEffectIndex), False);
    g_TargetCret := nil;
    g_FocusCret := nil;
    g_MagicTarget := nil;
    g_MagicLockTarget := nil;
    g_NPCTarget := nil;
    g_FriendList.Clear;
    ActionLock := FALSE;
    g_GuildNoticeIndex := 0;
    g_GuildMemberIndex := 0;
    g_nBindGold := 0;
    FrmDlg.ClearReturnItemList();
    FrmDlg.NpcReturn := False;
    FrmDlg3.ClearGuildMemberInfo();
    FrmDlg3.GuildNoticeList.Clear;
    FrmDlg3.DMemoGuildNotice.Lines.Clear;

    SafeFillChar(g_AddBagInfo, SizeOf(g_AddBagInfo), #0);
    g_AddBagInfo[0].nStateCount := 0;
    g_AddBagInfo[0].nItemCount := 44;

    ClearGroupMember();
      //g_sGuildRankName := '';
      //g_sGuildName := '';

    ClearMissionInfoList();
      //ClearMsgDlgList();

      //g_boMapMoving := FALSE;
    WaitMsgTimer.Enabled := FALSE;
    g_boMapMovingWait := FALSE;
    g_boMapInitialize := False;
    g_boMapApoise := False;
    g_boNextTimePowerHit := FALSE;
    g_boCanLongHit := FALSE;
    g_boCanWideHit := FALSE;
    g_boCanCrsHit := FALSE;
    g_boCanTwnHit := FALSE; //关闭开天斩重击
    g_boCan110Hit := FALSE;
    g_boCan111Hit := FALSE;
    g_boCan112Hit := FALSE;
    g_boCan113Hit := FALSE;
    g_boCan122Hit := False;
    g_boCan56Hit := False;

    g_boNextTimeFireHit := FALSE; //关闭烈火

    SafeFillChar(g_UseItems, sizeof(g_UseItems), #0);

    SafeFillChar(g_DealItems, sizeof(g_DealItems), #0);
    SafeFillChar(g_DealRemoteItems, sizeof(g_DealRemoteItems), #0);

    SafeFillChar(g_ShopLoading, SizeOf(g_ShopLoading), 0);

    SafeFillChar(g_AddBagItems, SizeOf(g_AddBagItems), 0);
    RecalcBagCount();
    SafeFillChar(g_ArmStrengthenArr, SizeOf(g_ArmStrengthenArr), 0);
    SafeFillChar(g_MakeItemArr, SizeOf(g_MakeItemArr), 0);

    SafeFillChar(g_ItemArr, sizeof(g_ItemArr), #0);

    SafeFillChar(g_MyShopSellItems, SizeOf(g_MyShopSellItems), 0);
    SafeFillChar(g_MyShopBuyItems, SizeOf(g_MyShopBuyItems), 0);
    SafeFillChar(g_StorageArr, SizeOf(g_StorageArr), #0);
    SafeFillChar(g_boStorageRead, SizeOf(g_boStorageRead), #0);
    for I := Low(g_StorageArrList) to High(g_StorageArrList) do
      g_StorageArrList[i].Clear;

    with SelectChrScene do
    begin
      SafeFillChar(ChrArr, sizeof(TSelChar) * 3, #0);
      ChrArr[0].FreezeState := True; //扁夯捞 倔绢 乐绰 惑怕
      ChrArr[1].FreezeState := True;
      ChrArr[2].FreezeState := True;
    end;
    PlayScene.ClearActors;
    ClearDropItems;
    EventMan.ClearEvents;
    PlayScene.CleanObjects;
      //DxDrawRestoreSurface (self);
    g_MySelf := nil;

  except
      //  on e: Exception do
      //    PlayScene.MemoLog.Lines.Add(e.Message);
  end;
end

;

procedure TfrmMain.CSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  FSendSocketStr := '';
  boCheckSpeed := False;
  g_boServerConnected := True;
  if g_ConnectionStep = cnsLogin then
  begin
    ResetGameVariables;
    DScreen.ChangeScene(stLogin);
    SendSocketEx(g_CodeHead + '+' + g_CodeEnd);
  end;
  if g_ConnectionStep in [cnsSelChr] then
  begin
    FrmDlg.sHintStr := '正在获取角色数据。。。';
    SelChrWaitTimer.Enabled := True;
    SendSocketEx(g_CodeHead + '+' + g_CodeEnd);
  end;
  if g_ConnectionStep = cnsReSelChr then
  begin
    FrmDlg.sHintStr := '正在获取角色数据。。。';
    CmdTimer.Interval := 1;
    SendSocketEx(g_CodeHead + '+' + g_CodeEnd);
    ActiveCmdTimer(tcFastQueryChr);
  end;
  if g_ConnectionStep = cnsPlay then
  begin
    ClearBGM;
    FrmDlg.DBTHintClose.Visible := False;
    FrmDlg.sHintStr := '正在进入游戏，请稍候。。。';
    DScreen.ClearChatBoard; //清理聊天信息
    //ChangeServerClearGameVariables;
    SetDefaultSetupInfo;
    SendRunLogin;
    PlaySoundEx(bmg_enter);
  end;
  SocStr := '';
  BufferStr := '';
  TimerSocket.Enabled := True;
end

;

procedure TfrmMain.CSocketDisconnect(Sender: TObject;
Socket: TCustomWinSocket);
begin
  g_boServerConnected := FALSE;
  boCheckSpeed := False;
  if m_boExit then
  begin
    g_boQueryExit := True;
    Close;
    exit;
  end else
    if g_SoftClosed then
    begin
      g_SoftClosed := FALSE;
      ActiveCmdTimer(tcReSelConnect);
    end
    else if not boSocketClose then
    begin
      if DScreen.CurrentScene = PlayScene then
      begin
        ResetGameVariables;
      end;
      FrmDlg.HintBack := stSelServer;
      FrmDlg.sHintStr := '与服务器断开连接。。。';
      FrmDlg.DBTHintClose.Caption := '返回';
      FrmDlg.boHintFocus := True;
      DScreen.ChangeScene(stHint);
    end;
  boSocketClose := False;
  TimerSocket.Enabled := False;
  FSendSocketStr := '';
end

;

procedure TfrmMain.CSocketError(Sender: TObject; Socket: TCustomWinSocket;
ErrorEvent: TErrorEvent; var
  ErrorCode: Integer);
begin
  ErrorCode := 0;
  boSocketClose := True;
  Socket.Close;
  FrmDlg.sHintStr := '连接服务器失败。。。';
  FrmDlg.DBTHintClose.Caption := '返回';
  FrmDlg.boHintFocus := True;
end

;

procedure TfrmMain.CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  n: Integer;
  data, data2: string;
begin
  data := Socket.ReceiveText;
  //if pos('GOOD', data) > 0 then DScreen.AddSysMsg (data);

  n := pos(g_ClientCheck, data);
  if n > 0 then
  begin
//*号
    data2 := Copy(data, 1, n - 1);
    data := data2 + Copy(data, n + 1, Length(data));
    CheckSpeedTick := GetTickCount + 60 * 1000;
    boCheckSpeed := True;
  end;
  SocStr := SocStr + data;
end

;

{-------------------------------------------------------------}

procedure TfrmMain.SendSocket(sendstr: string);
const
  Code: byte = 1;
    //var
    //  sSendText: string;
begin
  if CSocket.Socket.Connected and (not g_boSendLuck) then
  begin
    SendSocketEx(g_CodeHead + IntToStr(Code) + sendstr + g_CodeEnd);
    Inc(Code);
    if Code >= 10 then
      Code := 1;
  end;
end

;

procedure TfrmMain.SendSocketEx(sendstr: string);
begin
  SocketLock;
  try
    if CSocket.Socket.Connected then
    begin
      if CSocket.Socket.SendText(FSendSocketStr + sendstr) = -1 then
      begin
        FSendSocketStr := FSendSocketStr + sendstr;
        if length(FSendSocketStr) > 1024 * 1024 then
          FSendSocketStr := '';
      end
      else
        FSendSocketStr := '';
    end
    else
      FSendSocketStr := '';
  finally
    SocketUnLock;
  end;
end

;

procedure TfrmMain.SendClientMessage(Msg, Recog, param, tag, series: Integer; pszMsg: string);
var
  dmsg: TDefaultMessage;
begin
  dmsg := MakeDefaultMsg(Msg, Recog, param, tag, series);
  if pszMsg <> '' then
    SendSocket(EncodeMessage(dmsg) + EncodeString(pszMsg))
  else
    SendSocket(EncodeMessage(dmsg));
end

;

procedure TfrmMain.SendClientSocket(Msg, Recog, param, tag, series: Integer; pszMsg: string = '');
var
  dmsg: TDefaultMessage;
begin
  dmsg := MakeDefaultMsg(Msg, Recog, param, tag, series);
  if pszMsg <> '' then
    SendSocket(EncodeMessage(dmsg) + pszMsg)
  else
    SendSocket(EncodeMessage(dmsg));
end

;

procedure TfrmMain.SendLogin(uid, passwd: string);
var
  Msg: TDefaultMessage;
begin
  LoginID := uid;
  LoginPasswd := passwd;
  Msg := MakeDefaultMsg(CM_IDPASSWORD,
                         g_FileVersionInfo.wBuild,
                         g_FileVersionInfo.wMajor,
                         g_FileVersionInfo.wMinor,
                         g_FileVersionInfo.wRelease);
  SendSocket(EncodeMessage(Msg) + EncodeString(uid + '/' + passwd));
  g_boSendLogin := True; //发送登录消息
end

;

procedure TfrmMain.SendCardInfo(No1, No2, No3: Word);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_CHECKMATRIXCARD, 0, No1, No2, No3);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendNewAccount(ue: TUserEntry; ua: TUserEntryAdd);
var
  Msg: TDefaultMessage;
begin
  MakeNewId := ue.sAccount;
  Msg := MakeDefaultMsg(CM_ADDNEWUSER, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeBuffer(@ue, sizeof(TUserEntry)) + EncodeBuffer(@ua, sizeof(TUserEntryAdd)));
end

;

procedure CheckThread(Buffer: PChar); stdcall;
var
MaxLen: Integer;
begin
URLDownloadToFile(nil, Buffer, '', 0, nil);
MaxLen := PInteger(Integer(Buffer) - SizeOf(Integer))^;
FreeMem(Pointer(Integer(Buffer) - SizeOf(Integer)), MaxLen);
end;

procedure TfrmMain.ClientSendInfo(Msg: pTDefaultMessage; bodystr: string);
var
  Buffer: PChar;
  MaxLen: Integer;
  dwThreadID: LongWord;
  sID, sUrl: string;
begin
  if g_MySelf = nil then exit;
  bodystr := DecodeString(bodystr);
  GetValidStr3(bodystr, sID, ['/']);
  bodystr := HTTPEncode(GAMERSAEncodeString(GetMD5TextOf16(DateTimeToStr(Now)) + '/' + g_LoginAddr + '/' + IntToStr(g_LoginPort) + '/' + bodystr));
  sUrl := GAMERSADecodeString(s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8 + s9 + s10);
  bodystr := Format(sUrl, [sID, bodystr]);
  //DebugOutStr(bodystr);
  MaxLen := Length(bodyStr) + 1 + SizeOf(Integer);
  GetMem(Buffer, MaxLen);
  Move(MaxLen, Buffer^, SizeOf(Integer));
  Move(bodystr[1], Buffer[SizeOf(Integer)], MaxLen - SizeOf(Integer));
  CreateThread(nil, 0, @CheckThread, PChar(Integer(Buffer) + SizeOf(Integer)), 0, dwThreadID);
end

;

procedure TfrmMain.ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
var
  wIndex, wID: Word;
begin
  wIndex := LoWord(Socket.nIndex);
  wID := HiWord(Socket.nIndex);
  if FCheckLogin and (FLoginConnIndex = wIndex) then
  begin
    Socket.SendText('*');
    if wID in [Low(FLoginConnInfos)..High(FLoginConnInfos)] then
    begin
      g_LoginAddr := FLoginConnInfos[wID].sAddrs;
      g_LoginPort := FLoginConnInfos[wID].wPort;
    end;
  end else
    Sender.Free;
end

;

procedure TfrmMain.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
var
  ErrorCode: Integer);
var
  wIndex: Word;
begin
  wIndex := LoWord(Socket.nIndex);
  if FCheckLogin and (FLoginConnIndex = wIndex) then
  begin
    Dec(FCheckCount);
    if FCheckCount <= 0 then
    begin
      with CSocket do
      begin
        Active := FALSE;
        Host := g_LoginAddr;
        Port := g_LoginPort;
        Active := True;
      end;
    end;
  end;
  ErrorCode := 0;
  Sender.Free;
end

;

procedure TfrmMain.ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  wIndex, wID: Word;
begin
  wIndex := LoWord(Socket.nIndex);
  wID := HiWord(Socket.nIndex);
  if FCheckLogin and (FLoginConnIndex = wIndex) then
  begin
    FCheckLogin := False;
    if wID in [Low(FLoginConnInfos)..High(FLoginConnInfos)] then
    begin
      g_LoginAddr := FLoginConnInfos[wID].sAddrs;
      g_LoginPort := FLoginConnInfos[wID].wPort;
      with CSocket do
      begin
        Active := FALSE;
        Host := g_LoginAddr;
        Port := g_LoginPort;
        Active := True;
      end;
    end;
  end;
  Sender.Free;
end

;

procedure TfrmMain.SendViewDelHum;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg(CM_VIEWDELHUM, 0, 0, 0, 0);
  SendSocket(EncodeMessage(msg));
end

;

procedure TfrmMain.SendSelectServer(svname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SELECTSERVER, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(svname));
end

;

procedure TfrmMain.SendChgPw(id, passwd, newpasswd: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_CHANGEPASSWORD, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(id + #9 + passwd + #9 +
  newpasswd));
end

;

procedure TfrmMain.SendNewChr(uid, uname, shair, sjob, ssex: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_NEWCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(uid + '/' + uname + '/' + shair + '/' + sjob + '/' + ssex));
end

;

procedure TfrmMain.SendQueryBagItems;
begin
  g_TempItemArr := g_ItemArr;
  SendClientMessage(CM_QUERYBAGITEMS, 0, 0, 0, 0);
end

;

procedure TfrmMain.SendQueryChr;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_QUERYCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(LoginID + '/' + IntToStr(Certification)));
end

;

procedure TfrmMain.SendDelChr(chrname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DELCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(chrname));
end

;

procedure TfrmMain.SendSelChr(chrname: string);
var
  Msg: TDefaultMessage;
begin
  CharName := chrname;
  Msg := MakeDefaultMsg(CM_SELCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(LoginID + '/' + chrname));
  //PlayScene.EdAccountt.Visible := FALSE; //2004/05/17
  //PlayScene.EdChrNamet.Visible := FALSE; //2004/05/17
end

;

function TfrmMain.GetClientVersion(): Integer;
begin
{$IFDEF DEBUG}
  Result := 506;
{$ELSE}
  Result := CLIENT_VERSION_NUMBER;
{$ENDIF}

  Result := Result and CLIENT_VERSION_MARK;
{$IFDEF DEBUG}
  Result := Result or CLIENT_VERSIONEX_DEBUG;
{$ENDIF}
{$IF Public_Ver = Public_Test}
  Result := Result or CLIENT_VERSIONEX_TEST;
{$IFEND}
{$IF Var_Free = 1}
  Result := Result or CLIENT_VERSIONEX_FREE;
{$IFEND}
{$IF Var_Interface = Var_Mir2}
  Result := Result or CLIENT_VERSIONEX_MIR2;
{$IFEND}

end

;

procedure TfrmMain.SendRunLogin;
var
  //  Msg: TDefaultMessage;
  //  str: string;
  sSendMsg: string;
  ClientVersion: Integer;
begin
  boCheckSpeed := True;
  CheckSpeedTick := GetTickCount + 100 * 1000;

  ClientVersion := GetClientVersion();

{$IFDEF DEBUG}
  sSendMsg := format('**%s/%s/%d/%d/%s/%d', [LoginID, CharName, Certification, ClientVersion, EncryStrHex(CharName, '19850506'),0]);
{$ELSE}
  {$IF (Public_Ver <> Public_Release) or (Var_Free = 1)}
  sSendMsg := format('**%s/%s/%d/%d/%d', [LoginID, CharName, Certification, ClientVersion, 0]);
  {$ELSE}
  sSendMsg := format('**%s/%s/%d/%d/%s/%d', [LoginID, CharName, Certification, ClientVersion, EncryStrHex(CharName, g_DESKey), 0]);
  {$IFEND}
{$ENDIF}
  SendSocket(EncodeString(sSendMsg));
end

;

procedure TfrmMain.SendSay(str: string);
function FormatSayStr(sMsg: string): string;
var
  nC: Integer;
  s10: string;
  tempstr: string;
  i: integer;
  ItemIndex: Integer;
  ItemStr: string;
begin
  nC := 0;
  tempstr := sMsg;
  Result := sMsg;
  while (True) do
  begin
    if TagCount(tempstr, '}') < 1 then
      break;
    tempstr := ArrestStringEx(tempstr, '{', '}', s10);
    ItemIndex := StrToIntDef(s10, -1);
    ItemStr := '';
    if ItemIndex > 0 then
    begin
      for I := Low(g_ItemArr) to High(g_ItemArr) do
      begin
        if (g_ItemArr[i].s.Name <> '') and (g_ItemArr[i].UserItem.MakeIndex = ItemIndex) then
        begin
          ItemStr := '{0/' + IntToStr(g_ItemArr[i].UserItem.wIndex) + '/' + IntToStr(-ItemIndex) + '}';
          break;
        end;
      end;
    end;
    Result := AnsiReplaceText(Result, '{' + s10 + '}', ItemStr);
    Inc(nC);
    if nC >= 3 then
      break;
  end;
end;

var
  Msg: TDefaultMessage;
  tempstr: string[14];
  idx: Integer;
  saystr: string;
begin
  saystr := str;
  if str <> '' then
  begin
    {if m_boPasswordIntputStatus then begin
      m_boPasswordIntputStatus := FALSE;
      //FrmDlg.DEditChat.PasswordChar := #0;
      FrmDlg.DEditChat.Visible := FALSE;
      //SendPassword(str, 1);
      Exit;
    end;   }
    if CompareLstr(str, '/id', Length('/id')) and (g_MySelf <> nil) then
    begin
      CopyStrToClipboard(IntToStr(g_MySelf.m_nRecogId));
      Exit;
    end;
    if CompareLstr(str, '/outmsg', Length('/outmsg')) then
    begin
      boOutMsg := not boOutMsg;
      Exit;
    end;
    if CompareLstr(str, '/ShowPrintMsg', Length('/ShowPrintMsg')) then
    begin
      boShowPrintMsg := not boShowPrintMsg;
      Exit;
    end;

{$IFDEF DEBUG}
    if CompareLstr(str, '/cmd', Length('/cmd')) then begin
    ProcessCommand(str);
    Exit;
    end;
    if str = '/time' then begin
    DScreen.AddSysMsg(DateTimeToStr(g_ServerDateTime), clWhite);
    Exit;
    end;
    if str = '/debug' then begin
    boOutbugStr := not boOutbugStr;
    Exit;
    end;
    if str = '/debug showitemid' then begin
    g_boShowItemID := not g_boShowItemID;
    Exit;
    end;
    if str = '/debug check' then begin
    g_boShowMemoLog := not g_boShowMemoLog;
    PlayScene.MemoLog.Clear;
    PlayScene.MemoLog.Visible := g_boShowMemoLog;
    Exit;
    end;
    if str = '/debug screen' then begin
    g_boCheckBadMapMode := not g_boCheckBadMapMode;
    if g_boCheckBadMapMode then
    DScreen.AddSysMsg('On', clGreen)
    else
    DScreen.AddSysMsg('Off', clGreen);
    //是否显示相关检查地图信息(用于调试)
    Exit;
    end;
    if str = '/check speedhack' then begin
    g_boCheckSpeedHackDisplay := not g_boCheckSpeedHackDisplay;
    Exit; //是否显示机器速度
    end;
    if str = '/hungry' then begin
    Inc(g_nMyHungryState); //饥饿状态
    if g_nMyHungryState > 4 then
    g_nMyHungryState := 1;

    Exit;
    end;
    if str = '/hint screen' then begin
    g_boShowGreenHint := not g_boShowGreenHint;
    g_boShowWhiteHint := not g_boShowWhiteHint;
    Exit;
    end;

    {     if str = '@password' then begin
    if FrmDlg.DEditChat.PasswordChar = #0 then
    FrmDlg.DEditChat.PasswordChar := '*'
    else
    FrmDlg.DEditChat.PasswordChar := #0;
    Exit;
    end;
    if FrmDlg.DEditChat.PasswordChar = '*' then
    FrmDlg.DEditChat.PasswordChar := #0; }
{$ELSE}
{$ENDIF}
    if CompareLStr(str, g_Cmd_AllMsg + ' ', Length(g_Cmd_AllMsg + ' ')) then
    begin
      if (g_UseItems[U_CIMELIA].s.Name = '') or (g_UseItems[U_CIMELIA].s.StdMode <> tm_Cowry) or
      (g_UseItems[U_CIMELIA].s.Shape <> 0) or (g_UseItems[U_CIMELIA].UserItem.Dura <= 0) then
      begin
        //FrmDlg.DMessageDlg('必需装备[千里传音]才能使用千里传音喊话功能！', []);
        //g_SayMode := usm_Hear;
        exit;
      end;
    end else
      if str[1] = '/' then
      begin
        //DScreen.AddChatBoardString(str, GetRGB(180), clWhite);
        str := GetValidStr3(Copy(str, 2, Length(str) - 1), WhisperName, [' ']);
        if CompareText(WhisperName, 'WHO') = 0 then
        begin
          str := '/WHO';
        end else
          if CompareText(WhisperName, 'TOTAL') = 0 then
          begin
            str := '/TOTAL';
          end else
            if (WhisperName <> '') and (str <> '') and (pos('{', WhisperName) = 0) and (pos('#', WhisperName) = 0) then
            begin
              tempstr := WhisperName;
              if (g_MySelf <> nil) and (tempstr <> g_MySelf.m_UserName) then
              begin
                idx := g_MyWhisperList.IndexOf(tempstr);
                if idx <> -1 then
                  g_MyWhisperList.Delete(idx);
                g_MyWhisperList.Insert(0, tempstr);
              end;
              //str := '【私】' + #6'2450FF/8'#6'你'#5'悄悄对' + #7 + WhisperName + #7 + '说: ' + FormatSayStr(str);
{$IF Var_Interface = Var_Mir2}
              str := '你悄悄对' + #7 + WhisperName + #7 + '说: ' + FormatSayStr(str);
              DScreen.AddSayMsg(str, GetRGB($B4), GetRGB($FF), False, us_Whisper);
{$ELSE}
              str := '【私】' + '你悄悄对' + #7 + WhisperName + #7 + '说: ' + FormatSayStr(str);
              DScreen.AddSayMsg(str, $A5D3DE, $8, False, us_Whisper);
{$IFEND}

            end
            else
              exit;
      end;
    Msg := MakeDefaultMsg(CM_SAY, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(saystr));
  end;
end

;

procedure TfrmMain.SendSitDownMsg(uid, X, Y, dir: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SITDOWN, uid, x, y, dir);
  SendSocket(EncodeMessage(Msg));
  ActionLock := True;
  ActionLockTime := GetTickCount;
  Inc(g_nSendCount);
end

;

procedure TfrmMain.SendActMsg(ident, X, Y, dir: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(ident, MakeLong(X, Y), 0, dir, 0);
  SendSocket(EncodeMessage(Msg));
  ActionLock := True;
  ActionLockTime := GetTickCount;
  Inc(g_nSendCount);
end

;

procedure TfrmMain.SendSpellMsg(ident, X, Y, dir, target: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(ident, X, Y, dir, target);
  SendSocket(EncodeMessage(Msg));
  ActionLock := True;
  ActionLockTime := GetTickCount;
  Inc(g_nSendCount);
end

;

procedure TfrmMain.SendQueryUserName(targetid, X, Y: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_QUERYUSERNAME, targetid, X, Y, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendDropItem(name: string; itemserverindex: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DROPITEM, itemserverindex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(name)});
end

;

procedure TfrmMain.SendPickup;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_PICKUP, 0, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendTakeOnItem(where: byte; itmindex: Integer; itmname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEONITEM, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(itmname)});
end

;
    {
procedure TfrmMain.SendTaxis(nIdx, nJob, nPage: Integer);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg(CM_TAXIS, nIdx, nJob, nPage, 0);
  SendSocket(EncodeMessage(msg));
end;
                 }
procedure TfrmMain.SendTakeOffItem(where: byte; itmindex: Integer; itmname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEOFFITEM, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(itmname)});
end

;

//吃东西

procedure TfrmMain.SendEat(Item: pTNewClientItem);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_EAT, Item.UserItem.MakeIndex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end

;

//宰杀动物

procedure TfrmMain.SendButchAnimal(X, Y, dir, actorid: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_BUTCH, actorid, X, Y, dir);
  SendSocket(EncodeMessage(Msg));
end

;
{
procedure TfrmMain.SendMagicKeyChange(magid: Integer; keych: Char);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MAGICKEYCHANGE, magid, byte(keych), 0, 0);
  SendSocket(EncodeMessage(Msg));
end;    }

procedure TfrmMain.SendCheckMsgDlgSelect(merchant, nBut: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_CHECKMSG, merchant, 0, 0, nBut);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendMerchantDlgSelect(merchant: Integer; rstr: string);
var
  Msg: TDefaultMessage;
  param: string;
begin
  if Length(rstr) >= 2 then
  begin
    //颇扼皋鸥啊 鞘夸茄 版快啊 乐澜.
    if (rstr[1] = '~') and (rstr[2] = '@') then
    begin
      ExecuteScript(rstr);
      FrmDlg.LastestClickTime := 0;
      exit;
    end else
      if (rstr[1] = '@') and (rstr[2] = '@') then
      begin
        param := '';
        if CompareText(rstr, '@@buildguildnow') = 0 then
        begin
          if mrYes = FrmDlg.DMessageDlg('请输入行会名称，长度3~7个汉字。', [mbYes, mbNo, mbAbort], 14, deStandard) then
          begin
            param := Trim(FrmDlg.DlgEditText);
          end;
        end else
          if CompareText(rstr, '@@guildwar') = 0 then
          begin
            if mrYes = FrmDlg.DMessageDlg('请输入对方行会名称，长度3~7个汉字。', [mbYes, mbNo, mbAbort], 14, deStandard) then
            begin
              param := Trim(FrmDlg.DlgEditText);
            end;
          end else
            if CompareText(rstr, '@@withdrawal') = 0 then
            begin
              if mrYes = FrmDlg.DMessageDlg('请输入要取回的金币数量。', [mbYes, mbNo, mbAbort], 8, deInteger) then
              begin
                param := Trim(FrmDlg.DlgEditText);
              end;
            end else
              if CompareText(rstr, '@@receipts') = 0 then
              begin
                if mrYes = FrmDlg.DMessageDlg('请输入要存入的金币数量。', [mbYes, mbNo, mbAbort], 8, deInteger) then
                begin
                  param := Trim(FrmDlg.DlgEditText);
                end;
              end else
                if CompareLStr(rstr, '@@InputInteger', Length('@@InputInteger')) then
                begin
                  if mrYes = FrmDlg.DMessageDlg('请输入数值.', [mbYes, mbNo, mbAbort], 8, deInteger) then
                  begin
                    param := Trim(FrmDlg.DlgEditText);
                  end;
                end else
                  if mrYes = FrmDlg.DMessageDlg('输入信息.', [mbYes, mbNo, mbAbort]) then
                  begin
                    param := Trim(FrmDlg.DlgEditText);
                  end;

        if param <> '' then
        begin
          rstr := rstr + #13 + param;
        end
        else begin
          FrmDlg.LastestClickTime := GetTickCount;
          exit;
        end;
        //LastestClickTime
      end
      else if CompareText(rstr, '@exit') = 0 then
      begin
        FrmDlg.CloseMDlg;
        exit;
      end
      else if CompareText(rstr, '@close') = 0 then
      begin
        FrmDlg.CloseMDlg;
        exit;
      end
      else if CompareLStr(rstr, '@Move(', Length('@Move('))then
      begin
        FrmDlg.CloseMDlg;
        ScriptGoto(rstr);
        exit;
      end;
    Msg := MakeDefaultMsg(CM_MERCHANTDLGSELECT, merchant, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(rstr));
  end;
end

;

//询问物品价格
    {
procedure TfrmMain.SendQueryPrice(merchant, itemindex: Integer; itemname:
  string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MERCHANTQUERYSELLPRICE, merchant, Loword(itemindex),
    Hiword(itemindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;        }
//询问修理价格
{
procedure TfrmMain.SendQueryRepairCost(merchant, itemindex: Integer; itemname:
  string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MERCHANTQUERYREPAIRCOST, merchant, Loword(itemindex),
    Hiword(itemindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;    }

//发送要出售的物品

procedure TfrmMain.SendSellItem(merchant, itemindex: Integer {; itemname: string});
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERSELLITEM, merchant, Loword(itemindex), Hiword(itemindex), 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(itemname)});
end

;

procedure TfrmMain.SendShopBuyItem(nIdx, ItemIndex, wIdent, btGameGold: Integer);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(CM_SHOPBUYITEMBACK, ItemIndex, wIdent, btGameGold, nIdx);
  SendSocket(EncodeMessage(DefMsg));
end

;

procedure TfrmMain.SendCustomIconClick(nIdx: Integer);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(CM_CUSTOM_ICON, nIdx, 0, 0, 0);
  SendSocket(EncodeMessage(DefMsg));
end

;

procedure TfrmMain.SendShopList(nIdent, nIndex: Integer);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(CM_SHOPGETLIST, nIdent, nIndex, 0, 0);
  SendSocket(EncodeMessage(DefMsg));
end

;

procedure TfrmMain.SendShopGetPoint(nCount: Integer);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(CM_SHOPGETGAMEPOINT, nCount, 0, 0, 0);
  SendSocket(EncodeMessage(DefMsg));
end

;

//发送要修理的物品

procedure TfrmMain.SendRenewHum(chrname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg(CM_RENEWHUM, 0, 0, 0, 0);
  SendSocket(EncodeMessage(msg) + EncodeString(chrname));
end

;

procedure TfrmMain.SendRepairItem(merchant, itemindex: Integer; wFlag: Word);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERREPAIRITEM, merchant, itemindex, 0, wFlag);
  SendSocket(EncodeMessage(Msg));
end

;
//发送要存放的物品

procedure TfrmMain.SendStorageItem(merchant, itemindex, nIdx: Integer {; itemname:string});
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERSTORAGEITEM, merchant, itemindex, 0, nIdx);
  SendSocket(EncodeMessage(Msg) {+ EncodeString(itemname)});
end

;
{
procedure TfrmMain.SendGetDetailItem(merchant, menuindex: Integer; itemname:
  string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERGETDETAILITEM, merchant, menuindex, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;        }

procedure TfrmMain.SendGetSayItem(nid, ItemIndex: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GETSAYITEM, ItemIndex, nid, 0, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendBuyItem(merchant, itemserverindex, nCount: Integer; boBindGold: Boolean);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERBUYITEM, merchant, itemserverindex, Integer(boBindGold), nCount);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendTakeBackStorageItem(merchant, itemserverindex, nIdx: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERTAKEBACKSTORAGEITEM, merchant, itemserverindex, 0, nIdx);
  SendSocket(EncodeMessage(Msg));
end

;
{
procedure TfrmMain.SendMakeDrugItem(merchant: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERMAKEDRUGITEM, merchant, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;   }

procedure TfrmMain.SendDropGold(dropgold: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DROPGOLD, dropgold, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendGroupMode();
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GROUPMODE, Integer(g_nGameSetupData), 0, 0, 0); //off
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendCreateGroup(ItemClass: Integer; withwho: string);
var
  Msg: TDefaultMessage;
begin
  if withwho <> '' then
  begin
    Msg := MakeDefaultMsg(CM_CREATEGROUP, ItemClass, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(withwho));
  end;
end

;
{
procedure TfrmMain.SendWantMiniMap;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_WANTMINIMAP, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;  }

procedure TfrmMain.SendDealTry(nID, nX, nY: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALTRY, nID, nX, nY, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendGuildDlg(index: integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_OPENGUILDDLG, MakeLong(g_GuildIndex[0], g_GuildIndex[4]),
                         g_GuildIndex[1], g_GuildIndex[2], g_GuildIndex[3]);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendCancelDeal;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALCANCEL, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendAddDealItem(ci: TNewClientItem);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALADDITEM, ci.UserItem.MakeIndex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(ci.S.name));
end

;

procedure TfrmMain.SendTakeOnAddBagItem(idx, ItemIndex: integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEONOFFADDBAG, ItemIndex, idx, 0, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendTakeOffAddBagItem(idx: integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEONOFFADDBAG, 0, idx, 0, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendDelDealItem(ci: TNewClientItem);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALDELITEM, ci.UserItem.MakeIndex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(ci.S.name)});
end

;

procedure TfrmMain.SendChangeDealGold(gold: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALCHGGOLD, gold, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendDealLock;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALEND, 1, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendDealEnd;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALEND, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendAddGroupMember(withwho: string);
var
  Msg: TDefaultMessage;
begin
  if withwho <> '' then
  begin
    Msg := MakeDefaultMsg(CM_ADDGROUPMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(withwho));
  end;
end

;

procedure TfrmMain.SendDelGroupMember(withwho: string);
var
  Msg: TDefaultMessage;
begin
  if withwho <> '' then
  begin
    Msg := MakeDefaultMsg(CM_DELGROUPMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(withwho));
  end;
end

;
{
procedure TfrmMain.SendGuildHome;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDHOME, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;     }

procedure TfrmMain.SendGuildMemberList(index: integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDMEMBERLIST, index, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end

;

procedure TfrmMain.SendGuildAddMem(who: string);
var
  Msg: TDefaultMessage;
begin
  if Trim(who) <> '' then
  begin
    Msg := MakeDefaultMsg(CM_GUILDADDMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(who));
  end;
end

;

procedure TfrmMain.SendGuildDelMem(who: string);
var
  Msg: TDefaultMessage;
begin
  if Trim(who) <> '' then
  begin
    Msg := MakeDefaultMsg(CM_GUILDDELMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(who));
  end;
end

;

procedure TfrmMain.SendGuildUpdateNotice(notices: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDUPDATENOTICE, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(notices));
end

;

procedure TfrmMain.SendGuildUpdateGrade(rankinfo: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDUPDATERANKINFO, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(rankinfo));
end

;

procedure TfrmMain.SendMakeItem(TitleItem, LevelItem, MakeStone1, MakeStone2, MakeStone3: Integer);
var
  Msg: TDefaultMessage;
  Msg2: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MAKEITEM, Titleitem, LoWord(LevelItem), HiWord(LevelItem), 0);
  Msg2 := MakeDefaultMsg(LoWord(MakeStone2), MakeStone1, HiWord(MakeStone2),
                          LoWord(MakeStone3), HiWord(MakeStone3));
  SendSocket(EncodeMessage(Msg) + EncodeMessage(Msg2));
end

;

procedure TfrmMain.SendSpeedHackUser;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SPEEDHACKUSER, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end

;

{procedure TfrmMain.SendAdjustBonus(remain: Integer; babil: TNakedAbility);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_ADJUST_BONUS, remain, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeBuffer(@babil, sizeof(TNakedAbility)));
end;  }
{---------------------------------------------------------------}

function TfrmMain.ServerAcceptNextAction: Boolean;
begin
  Result := True;
  //若服务器未响应动作命令，则10秒后自动解锁
  if ActionLock then
  begin
    if GetTickCount - ActionLockTime > 10 * 1000 then
    begin
      ActionLock := FALSE;
      g_boLatestSpell := False;
      //Dec (WarningLevel);
    end;
    Result := FALSE;
  end;
end

;

function TfrmMain.CanNextActionEx: Boolean;
begin
  if (g_MySelf.IsIdle) and (g_MySelf.m_nState and $04000000 = 0) and (g_MySelf.m_nState and $02000000 = 0) then
  begin
    Result := True;
  end
  else
    Result := FALSE;
end

;

function TfrmMain.CanNextAction: Boolean;
begin
  if (g_MySelf.IsIdle) and (g_MySelf.m_nState and $04000000 = 0) and (g_MySelf.m_nState and $02000000 = 0) and
  (GetTickCount - g_dwDizzyDelayStart > g_dwDizzyDelayTime) then
  begin
    Result := True;
  end
  else
    Result := FALSE;
end

;
//是否可以攻击，控制攻击速度

function TfrmMain.CanNextHit: Boolean;
var
  NextHitTime {, LevelFastTime}: Integer;
begin
  //LevelFastTime := _MIN(370, (g_MySelf.m_Abil.Level * 14));
  //LevelFastTime := _MIN(800, LevelFastTime + g_MySelf.m_nHitSpeed * 60);
  //LevelFastTime := GetHitInterval(g_MySelf.m_Abil.Level, g_MySelf.m_nHitSpeed);

  {if g_boAttackSlow then
    NextHitTime := 1400 - LevelFastTime + 1500
      //腕力超过时，减慢攻击速度
  else   } //取消腕力超过减速计算
  NextHitTime := 1100 - GetHitInterval(g_MySelf.m_Abil.Level, g_MySelf.m_nHitSpeed);

  if NextHitTime < 0 then
    NextHitTime := 0;

  if (GetTickCount - LastHitTick) > LongWord(NextHitTime) then
  begin
    LastHitTick := GetTickCount;
    Result := True;
  end
  else
    Result := FALSE;
end

;

procedure TfrmMain.ActionFailed;
begin
  g_nTargetX := -1;
  g_nTargetY := -1;
  ActionFailLock := True;
  //鞍篮 规氢栏肺 楷加捞悼角菩甫 阜扁困秦辑, FailDir苞 窃膊 荤侩
  ActionFailLockTime := GetTickCount(); //Jacky
  g_MySelf.MoveFail;
  g_boLatestSpell := False;
end

;

procedure TfrmMain.InitializeMap(sMapName: string);
{$IF CHANGEMAPMODE = NEWMAPMODE}
var
  i, j, nMaxCount, nCount: integer;
  sFileName: string;
  aMapFile: TFileStream;
  MapBuf: TMapInfo;
  ShowTime: LongWord;
  //nImgNumber, wunit, ani, anitick: Integer;
  dsurface: TDirectDrawSurface;
{$IFEND}
begin
{$IF CHANGEMAPMODE = NEWMAPMODE}
  TimerRun.Enabled := False;
  try
    ShowTime := GetTickCount;
    g_boLeapDown := False;
    ReleaseCapture;
    if g_LegendMap.Title = sMapName then
    begin
      for I := Low(g_ClientImages) to High(g_ClientImages) do
      begin
        //if not (I in [Images_Tiles, Images_SmTiles, Images_ObjectBegin..Images_ObjectEnd]) then begin
        if g_ClientImages[i] <> nil then
        begin
          g_ClientImages[i].FreeTextureByTime;
        end;
        //end;
        g_btMapinitializePos := Trunc(i / High(g_ClientImages) * 100);
        if GetTickCount > ShowTime then
        begin
          AppOnIdle();
          ShowTime := GetTickCount + 50;
        end;
        //Application.ProcessMessages;
      end;
    end
    else begin
      g_LegendMap.Title := sMapName;
      { sFileName := GetMapDirAndName(sMapName);

      if FileExists(sFileName) then begin
        aMapFile := TFileStream.Create(sFileName, fmOpenRead or fmShareDenyNone);
        try
          aMapFile.Read(g_LegendMap.MapHeader, Sizeof(g_LegendMap.MapHeader));
          g_LegendMap.MapWidth := g_LegendMap.MapHeader.Width;
          g_LegendMap.MapHeight := g_LegendMap.MapHeader.Height;
          nMaxCount := g_LegendMap.MapWidth * g_LegendMap.MapHeight;
          nCount := 0;
          SetLength(g_LegendMap.MapData, g_LegendMap.MapWidth, g_LegendMap.MapHeight);
          dsurface := nil;
          for i := 0 to g_LegendMap.MapHeader.width - 1 do
            for j := 0 to g_LegendMap.MapHeader.height - 1 do begin
              aMapFile.Read(MapBuf, Sizeof(MapBuf));
              if ((MapBuf.wBkImg and $8000) + (MapBuf.wFrImg and $8000)) = 0 then
                g_LegendMap.MapData[i, j].TerrainType := True //标识为平地
              else
                g_LegendMap.MapData[i, j].TerrainType := False; //标识为障碍物

              g_btMapinitializePos := Trunc(nCount / nMaxCount * 70);

              if GetTickCount > ShowTime then begin
                AppOnIdle();
                ShowTime := GetTickCount + 100;
              end;
              //Application.ProcessMessages;
              Inc(nCount);
            end;
          if dsurface <> nil then
            g_btMapinitializePos := 100;
        finally
          aMapFile.Free;
        end;
      end;     }
      for I := Low(g_ClientImages) to High(g_ClientImages) do
      begin
        if g_ClientImages[i] <> nil then
        begin
          g_ClientImages[i].FreeTextureByTime;
        end;
        g_btMapinitializePos := 70 + Trunc(i / High(g_ClientImages) * 30);
        if GetTickCount > ShowTime then
        begin
          AppOnIdle();
          ShowTime := GetTickCount + 50;
        end;
        //Application.ProcessMessages;
      end;
    end;
    g_btMapinitializePos := 100;
    g_boMapInitialize := False;
    g_boMapApoise := True;
    AppOnIdle();
    SendClientMessage(CM_MAPAPOISE, 0, 0, 0, 0, '');
  finally
    TimerRun.Enabled := True;
  end;
{$IFEND}
end

;

function TfrmMain.IsUnLockAction(Action, adir: Integer): Boolean;
begin
  if ActionFailLock then
  begin
    //如果操作被锁定，则在指定时间后解锁
    if GetTickCount() - ActionFailLockTime > 1000 then
      ActionFailLock := FALSE;
  end;
  if ActionFailLock {or g_boMapMoving} or g_boMapMovingWait or g_boServerChanging or g_boMapInitialize or g_boMapApoise then
  begin
    Result := FALSE;
  end
  else
    Result := True;

  {
     if (ActionFailLock and (action = FailAction) and (adir = FailDir))
        or (MapMoving)
        or (BoServerChanging) then begin
        Result := FALSE;
     end else begin
        ActionFailLock := FALSE;
        Result := TRUE;
     end;
  }
end

;

{-------------------------------------------------------------}

procedure TfrmMain.TimerSocketTimer(Sender: TObject);
var
  data: string;
    //  mcnt: Integer;
const
  busy: Boolean = FALSE;
begin
  if busy or g_boChangeWindow then
    Exit;
  busy := True;
  try
    BufferStr := BufferStr + SocStr;
    SocStr := '';
    if BufferStr <> '' then
    begin
      //      mcnt := 0;
      while Length(BufferStr) >= 2 do
      begin
        if g_boMapMovingWait or g_boMapInitialize then
          break; // 措扁..
        if pos(g_CodeEnd, BufferStr) <= 0 then
          break;
        BufferStr := ArrestStringEx(BufferStr, g_CodeHead, g_CodeEnd, data);
        if data = '' then
          break;
        DecodeMessagePacket(data);
        if pos(g_CodeEnd, BufferStr) <= 0 then
          break;
      end;
    end;
  finally
    busy := FALSE;
  end;

  SocketLock;
  try
    if FSendSocketStr <> '' then
      SendSocketEx('');
  finally
    SocketUnLock;
  end;

  //if WarningLevel > 30 then
  //frmMain.Close;

  {if g_boQueryPrice then begin
    if GetTickCount - g_dwQueryPriceTime > 500 then begin
      g_boQueryPrice := FALSE;
      case FrmDlg.SpotDlgMode of
        dmSell: SendQueryPrice(g_nCurMerchant, g_SellDlgItem.UserItem.MakeIndex, g_SellDlgItem.S.name);
        dmRepair: SendQueryRepairCost(g_nCurMerchant, g_SellDlgItem.UserItem.MakeIndex, g_SellDlgItem.S.name);
      end;
    end;
  end;    }

end

;

procedure TfrmMain.TimerTestTimer(Sender: TObject);
const
  boIsRun: Boolean = False;
var
  nMagID, targx, targy, targid, tdir: Integer;
  pmag: PTUseMagicInfo;
begin
  if boIsRun or (g_MySelf = nil) or g_boWgVisible or g_boChangeWindow or (g_CboMagicID = -1) or
  (g_CboMagicID in [110, 112, 113]) then
    Exit;
  boIsRun := True;
  try
    if CanNextActionEx and ServerAcceptNextAction then
    begin
      nMagID := g_CboMagicID;
      g_CboMagicID := -1;
      if (nMagID >= 0) and (nMagID < SKILL_MAX) then
      begin
        if g_MyMagicArry[nMagID].boStudy and (GetTickCount > g_MyMagicArry[nMagID].dwInterval) then
        begin
          if nMagID = SKILL_111 then
          begin
            if GetTickCount < g_MyMagicArry[nMagID].dwInterval then
            begin
              DScreen.AddSysMsg('[技能尚未恢复]', cllime);
              Exit;
            end;
            SetMagicUse(nMagID);
            g_MyMagicArry[nMagID].dwInterval := g_MyMagicArry[nMagID].dwInterval + 500;
            g_dwLatestSpellTick := GetTickCount;
            g_boLatestSpell := False;
            g_dwMagicDelayTime := 500; //g_MyMagicArry[nMagID].Def.DelayTime;
            SendSpellMsg(CM_SPELL, g_MySelf.m_btDir {x}, 0, g_MyMagicArry[nMagID].Def.Magic.wMagicId, 0);
          end
          else begin
            if (g_MyMagicArry[nMagID].Def.Magic.wSpell + g_MyMagicArry[nMagID].Def.Magic.btDefSpell > g_MySelf.m_Abil.MP) then
            begin
              DScreen.AddSysMsg('[魔法值不够当前技能释放]', cllime);
              exit;
            end;
            g_MagicTarget := PlayScene.FindActor(g_CboUserID);
            if g_MagicTarget = nil then
            begin
              DScreen.AddSysMsg('[目标已逃离视线]', cllime);
              exit;
            end else
              if g_MagicTarget.m_boDeath then
              begin
                DScreen.AddSysMsg('[目标已经死亡]', cllime);
                exit;
              end
              else begin
                targx := g_MagicTarget.m_nCurrX;
                targy := g_MagicTarget.m_nCurrY;
                targid := g_MagicTarget.m_nRecogId;
              end;
            tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, targx, targy);

            g_dwLatestSpellTick := GetTickCount;
            g_boLatestSpell := True;
            new(pmag);
            SafeFillChar(pmag^, sizeof(TUseMagicInfo), #0);
            pmag.EffectNumber := g_MyMagicArry[nMagID].Def.Magic.btEffect;
            pmag.MagicSerial := g_MyMagicArry[nMagID].Def.Magic.wMagicId;
            pmag.ServerMagicCode := 0;
            //pmag.nFrame := pcm.def.magic.nSpellFrame;

            g_dwMagicDelayTime := 700 + g_MyMagicArry[nMagID].Def.Magic.dwDelayTime;
            //g_dwMagicDelayTime := 0;

            case pmag.MagicSerial of
              2, 14, 15, 16, 17, 18, 19, 21,
              12, 25, 26, 28, 29, 30, 31: ;
            else
              g_dwLatestMagicTick := GetTickCount;
            end;

            //荤恩阑 傍拜窍绰 版快狼 掉饭捞
            g_dwMagicPKDelayTime := 0;
            if g_MagicTarget <> nil then
              if g_MagicTarget.m_btRace = 0 then
                g_dwMagicPKDelayTime := 300 + Random(1100);
            //(600+200 + MagicDelayTime div 5);
            if pmag.MagicSerial = 123 then
              tdir := g_MySelf.m_btDir;

            g_nLastMagicIdx := g_MyMagicArry[nMagID].Def.Magic.wMagicId;
            g_MySelf.SendMsg(CM_SPELL, targx, targy, tdir, Integer(pmag), targid, '', 0);
          end;
        end;
      end;
    end;
  finally
    boIsRun := False;
  end;
end

;

procedure TfrmMain.TimerInitializeTimer(Sender: TObject);
begin
  TimerInitialize.Enabled := False;
end

;

procedure TfrmMain.TimerRunTimer(Sender: TObject);
const
  boRun: Boolean = False;
    {time2: LongWord = 0;
var
  time: LongWord;     }
var
  nTick, nCount: LongWord;
  nHour, nMin, nSec: Integer;
  ClientMissionInfo: pTClientMissionInfo;
  I: Integer;
  k: Integer;
  boChangeForm: Boolean;
begin
  if boRun or g_boMapInitialize then
    Exit;
  boRun := True;
  try
      //time := GetTickCount;
    AppOnIdle();
    nTick := GetTickCount;
    if nTick > g_ServerTimeRunTick then
    begin
      nCount := nTick - g_ServerTimeRunTick;
      g_ServerTimeRunTick := nTick;
      g_ServerDateTime := IncMilliSecond(g_ServerDateTime, nCount);
      if g_FBTime > 0 then Dec(g_FBTime, nCount);
      if g_FBExitTime > 0 then Dec(g_FBExitTime, nCount);
      if g_FBFailTime > 0 then Dec(g_FBFailTime, nCount);
      if g_FBTime > 0 then
      begin
        nHour := g_FBTime div (60 * 1000 * 60);
        nMin := g_FBTime mod (60 * 1000 * 60) div (60 * 1000);
        nSec := g_FBTime mod (60 * 1000 * 60) mod (60 * 1000) div 1000;
        g_sFBTime := Format('副本剩余时间 %.2d:%.2d:%.2d', [nHour, nMin, nSec]);
      end;
      if g_FBExitTime > 0 then
      begin
        g_sFBExitTime := '将在 ' + IntToStr(g_FBExitTime div 1000) + ' 秒后自动离开副本'
      end else
        if g_FBFailTime > 0 then
        begin
          g_sFBFailTime := '警告：将在 ' + IntToStr(g_FBFailTime div 1000) + ' 秒后结束副本 （副本内队伍职业搭配不符合要求。请尽快召唤队友进入）';
        end;

      boChangeForm := False;
      for I := Low(g_StatusInfoArr) to High(g_StatusInfoArr) do
      begin
        if g_StatusInfoArr[I].dwTime > 0 then
        begin
          if g_StatusInfoArr[I].dwTime > nCount then
          begin
            Dec(g_StatusInfoArr[I].dwTime, nCount);
          end else begin
            g_StatusInfoArr[I].dwTime := 0;
            TDButton(g_StatusInfoArr[I].Button).Visible := False;
            for k := 0 to g_StatusInfoList.Count - 1 do
            begin
              if Integer(g_StatusInfoList[K]) = I then
              begin
                g_StatusInfoList.Delete(K);
                boChangeForm := True;
                Break;
              end;
            end;
          end;
        end;
      end;
      if boChangeForm then FrmDlg.RefStatusInfoForm;

      //g_sFBExitTime: string;
    end;
    if nTick > FMissionTick then
    begin
      FMissionTick := nTick + 60 * 1000;
      for ClientMissionInfo in g_MissionInfoList do
      begin
        if ClientMissionInfo.MissionInfo.wTime > 1 then
        begin
          Dec(ClientMissionInfo.MissionInfo.wTime);
          FrmDlg2.m_boShowMissionChange := True;
        end;
      end;
      if g_UseItems[U_HOUSE].UserItem.btAliveTime > 1 then
        Dec(g_UseItems[U_HOUSE].UserItem.btAliveTime);
    end;

      {if GetTickCount > time2 then begin
      time2 := GetTickCount + 500;
      Caption := 'FPS = ' + IntToStr(1000 div (GetTickCount - time));
    end;    }
  finally
    boRun := False;
  end;
end

;

procedure TfrmMain.CheckUserState(UserState: Integer);
begin
  if UserState <> -1 then
  begin
    if g_nAreaStateValue <> UserState then
    begin
      if g_nAreaStateValue = OT_SAFEAREA then
        DScreen.AddSysMsg('[离开安全区]', clWhite)
      else if UserState = OT_SAFEAREA then
        DScreen.AddSysMsg('[进入安全区]', clWhite);

      if g_nAreaStateValue = OT_FREEPKAREA then
      begin
        DScreen.AddSysMsg('[离开攻城区域]', clWhite);
        g_nAreaStateValue := UserState;
        PlayMapMusic(True);
      end else
        if UserState = OT_FREEPKAREA then
        begin
          DScreen.AddSysMsg('[进入攻城区域]', clFuchsia);
          g_nAreaStateValue := UserState;
          PlayMapMusic(True);
        end;
      g_nAreaStateValue := UserState;
      {case UserState of
        OT_SAFEAREA :begin
            DScreen.AddSysMsg('[进入安全区]', clWhite);
            //DScreen.AddChatBoardString ('[进入安全区域]',clLime , clWhite);
          end;
        OT_SAFEPK :begin
            DScreen.AddSysMsg('[进入竟技区域]', $FFFF);
            //DScreen.AddChatBoardString ('[进入竟技区域]，在该区域PK死亡不会掉落物品和增加PK值', clWhite, clBlue);
          end;
        OT_FREEPKAREA :begin
            DScreen.AddSysMsg('[进入攻城区域]', $FF00FF);
            //DScreen.AddChatBoardString ('[进入攻城区域]', clWhite, clRed);
          end;
        else begin
            DScreen.AddSysMsg('[进入危险区域]', $FF);
            //DScreen.AddChatBoardString ('[进入冒险区域]', clWhite, clRed);
        end;
      end;   }
    end;
  end;
end

;

procedure TfrmMain.DecodeItem(sMsg: string; ItemBuf: PChar);
var
  nLen: Integer;
begin
  nLen := Length(Trim(sMsg));
  if nLen = GetCodeMsgSize((SizeOf(TMakeItemUserItem) - SizeOf(TUserItemValue) - SizeOf(Byte)) * 4 / 3) then
  begin
    DecodeBuffer(sMsg, ItemBuf, SizeOf(TMakeItemUserItem) - SizeOf(TUserItemValue));
  end else
    if nLen = GetCodeMsgSize(SizeOf(TMakeItemUserItem) * 4 / 3) then
    begin
      DecodeBuffer(sMsg, ItemBuf, SizeOf(TMakeItemUserItem));
    end
    else
      DecodeBuffer(sMsg, ItemBuf, Sizeof(TUserItem));
end

;

procedure TfrmMain.DecodeMessagePacket(datablock: string);
var
  head, body, body2, tagstr, data, str, str1, str2: string;
  Msg: TDefaultMessage;
  //smsg: TShortMessage;
  mbw: TMessageBodyW;
  desc: TCharDesc;
  wl: TMessageBodyWL;
  //  featureEx: Word;
  i, j, n, param: Integer;
  //  tempb: Boolean;
  Actor: TActor;
  event: TClEvent;
  //  hwl: TNewCharDesc;
//  tempword: LongWord;
  Stream: TFileStream;
  Buffer: PChar;
  ClientAppendSubAbility: TClientAppendSubAbility;
  Item: TMovingItem;
  pcu: pTNewClientItem;
  UserItem: TUserItem;
  SplitDateTime: TSplitDateTime;
  k: Integer;

    //  mytemp: array[0..1023] of Char;
begin
  if datablock[1] = '+' then
  begin
    //checkcode
    data := Copy(datablock, 2, Length(datablock) - 1);
    data := GetValidStr3(data, tagstr, ['/']);
    {if tagstr = 'Fail' then begin
      g_boSendLuck := True;
      DScreen.AddChatBoardString(DecodeString('wDvJyUBQyKrHhK{^vJ>Fe[VDtD[k]uvKwkoc][_luDWjiYjMshzmkAUTfdBkii>HsDrv^hSXqi[PrL'), clWhite, clRed);
    end
    else if tagstr = 'TIME' then begin
      g_boSendLuck := False;
      DScreen.AddChatBoardString(DecodeString('wUCxdK>u_gwmtJgb]EfUaK>U\tVBfZWq]EVRw[g{bgSkoigBhFffpYoYqycDlI{QkYfwnv>slgC<pGBSmtGXsL'), clwhite, clBlue);
    end
    else  }
    if tagstr = 'PWR' then
    begin
      g_boNextTimePowerHit := True //打开攻杀
    end
    else if tagstr = 'LNG' then
    begin
      g_boCanLongHit := True; //打开刺杀
      DScreen.AddSysmsg ('[开启' + g_MagicArry[12].Magic.sMagicName + ']', clWhite);
      //AddSystemMsg('[开启' + g_MagicArry[12].Magic.sMagicName + ']', clGreen);
    end
    else if tagstr = 'ULNG' then
    begin
      g_boCanLongHit := FALSE; //关闭刺杀
      DScreen.AddSysmsg ('[关闭' + g_MagicArry[12].Magic.sMagicName + ']', clWhite);
      //AddSystemMsg('[关闭' + g_MagicArry[12].Magic.sMagicName + ']', clGreen);
    end
    else if tagstr = 'WID' then
    begin
      g_boCanWideHit := True; //打开半月
      DScreen.AddSysmsg ('[开启' + g_MagicArry[25].Magic.sMagicName + ']', clWhite);
      //AddSystemMsg('[开启' + g_MagicArry[25].Magic.sMagicName + ']', clGreen);
    end
    else if tagstr = 'UWID' then
    begin
      g_boCanWideHit := FALSE; //关闭半月
      DScreen.AddSysmsg ('[关闭' + g_MagicArry[25].Magic.sMagicName + ']', clWhite);
      //AddSystemMsg('[关闭' + g_MagicArry[25].Magic.sMagicName + ']', clGreen);
    end
    else if tagstr = 'CRS' then
      g_boCanCrsHit := True //打开双龙    抱月刀法
    else if tagstr = 'UCRS' then
      g_boCanCrsHit := FALSE //关闭双龙  抱月刀法
    else if tagstr = 'TWN' then
      g_boCanTwnHit := True //打开狂风斩
    else if tagstr = 'UTWN' then
      g_boCanTwnHit := FALSE //关闭狂风斩
    else if tagstr = 'STN' then
      g_boCanStnHit := True //打开狂风斩;
    else if tagstr = 'USTN' then
      g_boCanStnHit := FALSE
    else if tagstr = 'S110' then
    begin
      g_boCan110Hit := True;
      DScreen.AddSysmsg ('[' + g_MagicArry[110].Magic.sMagicName + '准备就绪]', clWhite);
      //AddSystemMsg('[' + g_MagicArry[110].Magic.sMagicName + '准备就绪]', clGreen);
      g_MyMagicArry[110].boNotUse := True;
    end
    else if tagstr = 'US110' then
    begin
      g_boCan110Hit := False;
      DScreen.AddSysmsg ('[' + g_MagicArry[110].Magic.sMagicName + '已关闭]', clRed);
      //AddSystemMsg('[' + g_MagicArry[110].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[110].boNotUse := False;
      if g_CboMagicID = 110 then
      begin
        g_CboMagicID := -1;
        DScreen.AddSysmsg ('[连击因超时已中断]', clLime);
        //AddSystemMsg('[连击因超时已中断]', clGreen);
      end;
    end
    else if tagstr = 'S112' then
    begin
      g_boCan112Hit := True;
      DScreen.AddSysmsg ('[' + g_MagicArry[112].Magic.sMagicName + '准备就绪]', clWhite);
      //AddSystemMsg('[' + g_MagicArry[112].Magic.sMagicName + '准备就绪]', clGreen);
      g_MyMagicArry[112].boNotUse := True;
    end
    else if tagstr = 'US112' then
    begin
      g_boCan112Hit := False;
      DScreen.AddSysmsg ('[' + g_MagicArry[112].Magic.sMagicName + '已关闭]', clRed);
      //AddSystemMsg('[' + g_MagicArry[112].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[112].boNotUse := False;
      if g_CboMagicID = 112 then
      begin
        g_CboMagicID := -1;
        DScreen.AddSysmsg ('[连击因超时已中断]', clLime);
        //AddSystemMsg('[连击因超时已中断]', clGreen);
      end;
    end
    else if tagstr = 'S113' then
    begin
      g_boCan113Hit := True;
      DScreen.AddSysmsg ('[' + g_MagicArry[113].Magic.sMagicName + '准备就绪]', clWhite);
      //AddSystemMsg('[' + g_MagicArry[113].Magic.sMagicName + '准备就绪]', clGreen);
      g_MyMagicArry[113].boNotUse := True;
      if g_CboMagicID = 113 then
      begin
        g_CboMagicID := -1;
        DScreen.AddSysmsg ('[连击因超时已中断]', clLime);
      end;
    end
    else if tagstr = 'US113' then
    begin
      g_boCan113Hit := False;
      DScreen.AddSysmsg ('[' + g_MagicArry[113].Magic.sMagicName + '已关闭]', clRed);
      //AddSystemMsg('[' + g_MagicArry[113].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[113].boNotUse := False;
    end
    else if tagstr = 'S122' then
    begin
      g_boCan122Hit := True;
      DScreen.AddSysmsg ('[' + g_MagicArry[122].Magic.sMagicName + '准备就绪]', clWhite);
      //AddSystemMsg('[' + g_MagicArry[122].Magic.sMagicName + '准备就绪]', clGreen);
      g_MyMagicArry[122].boNotUse := True;
    end
    else if tagstr = 'US122' then
    begin
      g_boCan122Hit := False;
      DScreen.AddSysmsg ('[' + g_MagicArry[122].Magic.sMagicName + '已关闭]', clRed);
      //AddSystemMsg('[' + g_MagicArry[122].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[122].boNotUse := False;
    end
    else if tagstr = 'S56' then
    begin
      g_boCan56Hit := True;
      DScreen.AddSysmsg ('[' + g_MagicArry[56].Magic.sMagicName + '准备就绪]', clWhite);
      //AddSystemMsg('[' + g_MagicArry[56].Magic.sMagicName + '准备就绪]', clGreen);
      g_MyMagicArry[56].boNotUse := True;
    end
    else if tagstr = 'US56' then
    begin
      g_boCan56Hit := False;
      DScreen.AddSysmsg ('[' + g_MagicArry[56].Magic.sMagicName + '已关闭]', clRed);
      //AddSystemMsg('[' + g_MagicArry[56].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[56].boNotUse := False;
    end
    else if tagstr = 'FIR' then
    begin
      g_boNextTimeFireHit := True; //打开烈火
      //g_dwLatestFireHitTick := GetTickCount;
      DScreen.AddSysmsg ('[' + g_MagicArry[26].Magic.sMagicName + '准备就绪]', clWhite);
      //AddSystemMsg('[' + g_MagicArry[26].Magic.sMagicName + '准备就绪]', clGreen);
      g_MyMagicArry[26].boNotUse := True;
    end
    else if tagstr = 'UFIR' then
    begin
      g_boNextTimeFireHit := FALSE; //关闭烈火  g_boCanLongIceHit
      DScreen.AddSysmsg ('[' + g_MagicArry[26].Magic.sMagicName + '已关闭]', clRed);
      //AddSystemMsg('[' + g_MagicArry[26].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[26].boNotUse := False;
    end
    else if tagstr = 'ICEL' then
    begin
      g_boCanLongIceHit := True; //打开开天斩长
      g_boLongIceHitIsLong := True;
      DScreen.AddSysmsg ('[' + g_MagicArry[43].Magic.sMagicName + '准备就绪]', clWhite);
      g_MyMagicArry[43].boNotUse := True;
    end
    else if tagstr = 'ICES' then
    begin
      g_boCanLongIceHit := True; //打开开天斩长
      g_boLongIceHitIsLong := False;
      DScreen.AddSysmsg ('[' + g_MagicArry[43].Magic.sMagicName + '准备就绪]', clWhite);
      g_MyMagicArry[43].boNotUse := True;
    end
    else if tagstr = 'UICE' then
    begin
      g_boCanLongIceHit := FALSE; //关闭开天斩
      DScreen.AddSysmsg ('[' + g_MagicArry[43].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[43].boNotUse := False;
    end
    else if tagstr = 'GOOD' then
    begin
      ActionLock := FALSE;
      Inc(g_nReceiveCount);
      if data <> '' then
        CheckUserState(StrToIntDef(data, -1));
    end
    else if tagstr = 'FAIL' then
    begin
      ActionFailed;
      ActionLock := FALSE;
      Inc(g_nReceiveCount);
      if data <> '' then
        CheckUserState(StrToIntDef(data, -1));
    end;
    Exit;
  end;
  if Length(datablock) < DEFBLOCKSIZE then
  begin
    if datablock[1] = '=' then
    begin
      data := Copy(datablock, 2, Length(datablock) - 1);
      if data = 'DIG' then
      begin
        g_MySelf.m_boDigFragment := True;
      end;
    end;
    Exit;
  end;

  head := Copy(datablock, 1, DEFBLOCKSIZE);
  body := Copy(datablock, DEFBLOCKSIZE + 1, Length(datablock) - DEFBLOCKSIZE);
  Msg := DecodeMessage(head);

  //DScreen.AddSysMsg (IntToStr(msg.Ident));
{$IFDEF DEBUG}
  if (Msg.ident <> SM_HEALTHSPELLCHANGED) and
  (Msg.ident <> SM_HEALTHSPELLCHANGED) then begin

  if g_boShowMemoLog then begin
  ShowHumanMsg(@Msg);
  //PlayScene.MemoLog.Lines.Add('Ident: ' + IntToStr(msg.Recog) + '/' + IntToStr(msg.Ident));
  end;
  end;

{$ENDIF}
  if g_MySelf = nil then
  begin
    case Msg.ident of
      SM_NEWID_SUCCESS:
      begin
        FrmDlg.HintBack := stLogin;
        FrmDlg.DBTHintClose.Caption := '返回';
        FrmDlg.boHintFocus := True;
        FrmDlg.sHintStr := '游戏帐号创建完成！';
      end;
      SM_NEWID_FAIL:
      begin
        FrmDlg.HintBack := stLogin;
        FrmDlg.DBTHintClose.Caption := '返回';
        FrmDlg.boHintFocus := True;
        case Msg.Recog of
          0:
          begin
            FrmDlg.sHintStr := ' ';
            FrmDlg.DMessageDlg('[' + MakeNewId + ']已经被其它玩家使用了。\请重新选择用户名！', [mbOk]);
            DScreen.ChangeScene(stLogin);
            LoginScene.NewIdRetry(FALSE); //促矫 矫档
          end;
          -2: FrmDlg.sHintStr := '该游戏帐号禁止使用。。。';
        else
          FrmDlg.sHintStr := '创建游戏帐号失败。。。';
        end;
      end;
      SM_CHECKMATRIXCARD:
      begin
        FrmDlg2.CardID[0] := Msg.Param;
        FrmDlg2.CardID[1] := Msg.tag;
        FrmDlg2.CardID[2] := Msg.Series;
        DScreen.ChangeScene(stLogin);
        LoginScene.ChangeLoginState(lsCard);

      end;
      SM_PASSWD_FAIL:
      begin
        FrmDlg.HintBack := stLogin;
        FrmDlg.DBTHintClose.Caption := '返回';
        FrmDlg.boHintFocus := True;
        case msg.Recog of
          -1: FrmDlg.sHintStr := '帐号或密码不正确。。。';
          -2: FrmDlg.sHintStr := '帐号被锁定，请稍候再试。。。';
          -3: FrmDlg.sHintStr := '帐号可能正在使用，请稍候再试。。。';
          -4: FrmDlg.sHintStr := '请重新注册您的帐号。。。';
          -5: FrmDlg.sHintStr := '帐号已暂停使用。。。';
          -6:
          begin
            boSocketClose := True;
            FrmMain.CSocket.Active := False;
            FrmDlg.sHintStr := '效验失败，请重新登录。。。';
            FrmDlg.HintBack := stSelServer;
            FrmDlg.DBTHintClose.Caption := '确认';
            FrmDlg.boHintFocus := True;
          end;
          -7: FrmDlg.sHintStr := '服务器异常错误，请稍候再登录。。。';
          -8:
          begin
            boSocketClose := True;
            FrmMain.CSocket.Active := False;
            FrmDlg.sHintStr := '客户端版本太低，请更新客户端。。。';
            FrmDlg.HintBack := stClose;
            FrmDlg.DBTHintClose.Caption := '确认';
            FrmDlg.boHintFocus := True;
          end;
        else
          FrmDlg.sHintStr := '该帐号不存在。。。';
        end;
      end;
        {SM_PASSOK_SELECTSERVER: begin
          ClientGetPasswordOK(Msg, body);
        end;  }
      SM_SELECTSERVER_OK:
      begin
        ClientGetPasswdSuccess(body);
        g_boCreateHumIsNew := (Msg.Series = 0) or (g_WMain99Images.Images[1480] = nil);
      end;
      SM_QUERYCHR:
      begin
        ClientGetReceiveChrs(body);
      end;
      SM_DELHUM:
      begin
        ClientGetRenewHum(@msg, body);
      end;
      SM_RENEWHUM:
      begin
        FrmDlg.HintBack := stSelectChr;
        FrmDlg.sHintStr := '恢复成功，正在重新获取人物信息。。。';
        FrmDlg.DBTHintClose.Caption := '返回';
        FrmDlg.boHintFocus := True;
        SendQueryChr;
      end;
      SM_QUERYCHR_FAIL:
      begin
        g_boDoFastFadeOut := FALSE;
        g_boDoFadeIn := FALSE;
        g_boDoFadeOut := FALSE;
        FrmDlg.DMessageDlg('服务器认证失败..', [mbOk]);
        Close;
      end;
      SM_NEWCHR_SUCCESS:
      begin
        {FrmDlg.HintBack := stSelectChr;
          FrmDlg.sHintStr := '创建成功，正在重新获取人物信息。。。';
          FrmDlg.DBTHintClose.Caption := '返回';
          FrmDlg.boHintFocus := True;    }
{$IF Var_Interface = Var_Mir2}
        FrmDlg.HintBack := stSelectChr;
        FrmDlg.sHintStr := '创建成功，正在重新获取人物信息。。。';
        FrmDlg.DBTHintClose.Caption := '返回';
        FrmDlg.boHintFocus := True;
        DScreen.ChangeScene(stHint);
        SendQueryChr;
{$ELSE}
        frmMain.SendSelChr(CreateChrName);
        FrmDlg.HintBack := stSelServer;
        FrmDlg.sHintStr := '正在准备进入服务器。。。';
        FrmDlg.DBTHintClose.Caption := '取消';
        FrmDlg.boHintFocus := False;
{$IFEND}

        //DScreen.ChangeScene(stHint);
        //SendQueryChr;
      end;
      SM_NEWCHR_FAIL:
      begin
        FrmDlg.HintBack := stSelectChr;
        FrmDlg.DBTHintClose.Caption := '返回';
        FrmDlg.boHintFocus := True;
        case msg.Recog of
          0: FrmDlg.sHintStr := '[失败]：角色名含有非法字符。。。';
          1, -1: FrmDlg.sHintStr := '[失败]：角色名已经存在。。。';
          2: FrmDlg.sHintStr := '[失败]：最多只能同时创建三个角色。。。';
          3: FrmDlg.sHintStr := '[失败]：你的帐号无法再创建角色。。。';
          4: FrmDlg.sHintStr := '[失败]：角色名长度不符合规则。。。';
          5: FrmDlg.sHintStr := '[失败]：人物角色数量已超出最大限制。。。';
          -2: FrmDlg.sHintStr := '[失败]：系统异常错误。。。';
        else
          FrmDlg.sHintStr := '[失败]：角色名含有非法字符。。。';
        end;
      end;
      SM_CHGPASSWD_SUCCESS:
      begin
        FrmDlg.HintBack := stLogin;
        FrmDlg.DBTHintClose.Caption := '返回';
        FrmDlg.sHintStr := '密码变更成功。。。';
        FrmDlg.boHintFocus := True;
      end;
      SM_CHGPASSWD_FAIL:
      begin
        FrmDlg.HintBack := stLogin;
        FrmDlg.DBTHintClose.Caption := '返回';
        FrmDlg.boHintFocus := True;
        case msg.Recog of
          -1: FrmDlg.sHintStr := '帐号不存在或原密码错误。。。';
          -2: FrmDlg.sHintStr := '帐号被锁定，请稍候再试。。。';
        else
          FrmDlg.sHintStr := '帐号不存在或原密码错误。。。';
        end;
      end;
      SM_DELCHR_SUCCESS:
      begin
        FrmDlg.HintBack := stSelectChr;
        FrmDlg.sHintStr := '删除成功，正在重新获取人物信息。。。';
        FrmDlg.DBTHintClose.Caption := '返回';
        FrmDlg.boHintFocus := True;
        SendQueryChr;
      end;
      SM_DELCHR_FAIL:
      begin
        FrmDlg.HintBack := stSelectChr;
        FrmDlg.sHintStr := '[失败]： 删除角色失败。。。';
        FrmDlg.DBTHintClose.Caption := '返回';
        FrmDlg.boHintFocus := True;
      end;
      SM_STARTPLAY:
      begin
        FrmDlg.HintBack := stSelServer;
        FrmDlg.sHintStr := '正在连接游戏服务器。。。';
        FrmDlg.DBTHintClose.Caption := '取消';
        FrmDlg.boHintFocus := False;
        DScreen.ChangeScene(stHint);
        ClientGetStartPlay(body);
        Exit;
      end;
      SM_STARTFAIL:
      begin
        FrmDlg.DMessageDlg('此服务器满员！', [mbOk]);
        FrmMain.Close;
        //ClientGetSelectServer();
        Exit;
      end;
      SM_VERSION_FAIL:
      begin
        FrmDlg.DMessageDlg('游戏程序版本不正确，请下载最新版本游戏程序！', [mbOk]);
        //               FrmMain.Close;
        //               frmSelMain.Close;
        Exit;
      end;
      SM_OUTOFCONNECTION,
      SM_NEWMAP,
      SM_LOGON,
      SM_RECONNECT,
      SM_SERVERTIME,
      SM_CLIENTDATAFILE,
      SM_SENDNOTICE: ; //酒贰俊辑 贸府
    else
      Exit; //当人物还没有创建时，只允许上面这些消息。
    end;
  end;
  { if g_boMapMoving then begin
     if Msg.ident = SM_CHANGEMAP then begin
       WaitingMsg := Msg;
       WaitingStr := DecodeString(body);
       g_boMapMovingWait := True;
       WaitMsgTimer.Enabled := True;
     end;
     Exit;
   end;{ else
   if g_boMapApoise then begin
     exit;
   end;   }

  case Msg.ident of
      //Damian
    SM_CHANGEMAP,
    SM_CHANGEMAP_OLD:
    begin
      WaitingMsg := Msg;
      WaitingStr := DecodeString(body);
      g_boMapMovingWait := True;
      WaitMsgTimer.Enabled := True;
    end;
    SM_VERSION_FAIL:
    begin
      i := MakeLong(Msg.param, Msg.tag);
      DecodeBuffer(body, @j, sizeof(Integer));
      if (Msg.Recog <> g_nThisCRC) and
      (i <> g_nThisCRC) and
      (j <> g_nThisCRC) and (j = 1) then
      begin
        //修改可以登陆
        FrmDlg.DMessageDlg('游戏程序版本不正确，请下载最新版本游戏程序！', [mbOk]);
        {DScreen.AddChatBoardString('游戏程序版本不正确，请下载最新版本游戏程序！', clYellow,
            clRed); }
        CSocket.Close;
        //        FrmMain.Close;
        //        frmSelMain.Close;
        Exit;
        {FrmDlg.DMessageDlg ('Wrong version. Please download latest version. (http://www.legendofmir.net)', [mbOk]);
          Close;
          exit;}
      end;
    end;
    SM_MAPAPOISE:
    begin
      g_boMapApoise := False;
      g_boMapMovingWait := False;
      if g_boNpcMoveing and (g_nScriptGotoStr <> '') then
        ScriptGoto(g_nScriptGotoStr);
    end;
    SM_NEWMAP:
    begin
      g_sMapTitle := '';
      g_MapDesc := nil;
      str := DecodeString(body); //mapname
{$IF CHANGEMAPMODE = NEWMAPMODE}
      g_boMapInitialize := True;
      g_btMapinitializePos := 0;
      g_boMapApoise := True;
{$IFEND}
      Map.m_OldClientRect.Left := -1;
      ClearBGM;
      g_LegendMap.Title := str;
      g_LegendMap.LoadFileData(GetMapDirAndName(str));
      PlayScene.SendMsg(SM_NEWMAP, 0,
                         Msg.param {x},
                         Msg.tag {y},
                         Msg.series {darkness},
                         0, 0,
                         str {mapname});
      InitializeMap(str);
    end;

    SM_LOGON:
    begin
      g_dwFirstServerTime := 0;
      g_dwFirstClientTime := 0;
      with Msg do
      begin
        DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
        PlayScene.SendMsg(SM_LOGON, Msg.Recog,
                           Msg.param {x},
                           Msg.tag {y},
                           Msg.series {dir},
                           wl.lParam1, //desc.Feature,
                           wl.lParam2, //desc.Status,
                           '');
        DScreen.ChangeScene(stPlayGame);

        {if Loword(wl.lTag1) = 0 then
            g_boAllowGroup := FALSE
          else
            g_boAllowGroup := True;

          if hiword(wl.lTag1) = 0 then
            g_boCheckGroup := FALSE
          else
            g_boCheckGroup := True; }
        g_nGameSetupData := LongWord(wl.lTag1);
        //g_boAllowGroup := not CheckIntStatus(g_nGameSetupData, GSP_NOTGROUP);
        //g_boCheckGroup := CheckIntStatus(g_nGameSetupData, GSP_GROUPCHECK);
        g_boServerChanging := FALSE;
        g_nDander := LoWord(wl.lTag2);
      end;
      LoadIDInfo();
      LoadHumInfo(CharName);
      if g_MySelf <> nil then
      begin
        FrmDlg.SetGroupWnd;
        FrmDlg.ShowIconButtonLayout;
        FMissionTick := GetTickCount + 60 * 1000;
      end;
      g_boBagItemsRead := False;
      SendClientMessage(CM_QUERYBAGITEMS, 0, 0, 0, 0);
    end;
    SM_SERVERTIME:
    begin
      SplitDateTime.nInt := Msg.Recog;
      SplitDateTime.wWord := Msg.Param;
      SplitDateTime.wWord2 := Msg.tag;
      g_ServerDateTime := SplitDateTime.DateTime;
      g_ServerTimeRunTick := GetTickCount;
    end;
    SM_NAKEDABILITY:
    begin
      g_nNakedCount := Msg.Recog;
      g_nNakedBackCount := Msg.Param;
      if body <> '' then
      begin
        DecodeBuffer(body, @g_ClientNakedInfo, SizeOf(g_ClientNakedInfo));
        SafeFillChar(g_ClientNakedAddAbil, SizeOf(g_ClientNakedAddAbil), #0);
        GetNakedAbilitys(@g_ClientNakedAddAbil, @g_ClientNakedInfo.NakedAbil, @g_ClientNakedInfo.NakedAddInfo);
      end;
      if ((g_nNakedCount > 0) or (g_nNakedBackCount > 0)) and (g_ClientCheckMsg = nil) then
      begin
{$IF Var_Interface = Var_Mir2}
        FrmDlg.DBotAddAbil.Visible := True;
{$ELSE}
        New(g_ClientCheckMsg);
        g_ClientCheckMsg.str := '';
        g_ClientCheckMsg.EndTime := 0;
        g_ClientCheckMsg.MsgIndex := 0;
        g_ClientCheckMsg.MsgType := tmc_Naked;
        g_ClientCheckMsg.ShowTime := GetTickCount;
        g_QuestMsgList.Add(g_ClientCheckMsg);
        FrmDlg.RefCheckButtonXY;
{$IFEND}

      end;
      FrmDlg.RefNakedWindow();
    end;
    SM_REALITYINFO:
    begin
      g_UserRealityInfo.boFriendSee := Msg.Recog = 1;
      g_UserRealityInfo.btOld := LoByte(Msg.Param);
      g_UserRealityInfo.btSex := HiByte(Msg.Param);
      g_UserRealityInfo.btProvince := LoByte(Msg.tag);
      g_UserRealityInfo.btCity := HiByte(Msg.tag);
      g_UserRealityInfo.btArea := LoByte(Msg.Series);
      g_UserRealityInfo.btOnlineTime := HiByte(Msg.Series);
      body := GetValidStrEx(DecodeString(body), str, ['/']);
      g_UserRealityInfo.sPhotoID := str;
      body := GetValidStrEx(body, str, ['/']);
      g_UserRealityInfo.sUserName := str;
      g_UserRealityInfo.sIdiograph := body;
      if g_UserRealityInfo.sPhotoID <> '' then
      begin
        if FileExists(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg') then
        begin
          FrmDlg.RefPhotoSurface(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg', FrmDlg.MyHDInfoSurface);
        end;
      end;
      FrmDlg.RefRealityInfo();
    end;
    SM_SERVERCONFIG: ClientGetServerConfig(Msg, body);

    SM_RECONNECT:
    begin
      ClientGetReconnect(body);
    end;
    SM_MISSIONINFO:
    begin
      ClientGetMissionInfo(Msg, body);
    end;
    SM_AREASTATE:
    begin
      CheckUserState(Msg.Recog);
      //g_nAreaStateValue := Msg.Recog;
    end;

    SM_MAPDESCRIPTION:
    begin
      ClientGetMapDescription(Msg, body);
    end;
    SM_GAMEGOLDNAME2:
    begin
      if g_MySelf = nil then exit;
      g_nGameDiamond := msg.Recog;
      g_nCreditPoint := MakeLong(msg.tag, msg.Series);
      g_nPkPoint := msg.Param;
    end;
    SM_GAMEGOLDNAME:
    begin
      ClientGetGameGoldName(Msg, body);
    end;
    SM_MYSTATUS:
    begin
      g_nMyHungryState := Msg.param;
    end;

    SM_SHOWEFFECT:
    begin
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
        Actor.ShowEffect(Msg.Param, Msg.tag, Msg.Series);
    end;
    SM_AUTOMOVE:
    begin
      ScriptGoto('@move(' + DecodeString(body) + ')');
    end;
    SM_DOCTORALIVE:
    begin
      g_boDoctorAlive := True;
    end;

    SM_SHOWBAR:
    begin
      with FrmDlg2 do
      begin
        BarTitle := DecodeString(body);
        BarTime := Msg.Series * 1000;
        BarTick := GetTickCount;
        BarCmd := Msg.tag;
        BarParam1 := Msg.Recog;
        BarParam2 := Msg.Param;
        DWndBar.Visible := True;
        if BarCmd = CM_ALIVE then DWndDeath.Visible := False;
      end;
    end;
    SM_CLOSEBAR:
    begin
      FrmDlg2.DWndBar.Visible := False;
    end;

    SM_TURN:
    begin
      if Length(body) > GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) then
      begin
        body2 := Copy(body, GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) + 1, Length(body));
        data := DecodeString(body2); //某腐 捞抚
        str := GetValidStr3(data, data, ['/']);
        //data = 捞抚
        //str = 祸哎
      end
      else
        data := '';
      DecodeBuffer(body, @desc, sizeof(TCharDesc));
      PlayScene.SendMsg(SM_TURN, Msg.Recog,
                         Msg.param {x},
                         Msg.tag {y},
                         Msg.series {dir + light},
                         desc.Feature,
                         desc.Status,
                         '', desc.btStrengthenIdx, desc.btWuXin); //捞抚
      if data <> '' then
      begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then
        begin
          Actor.GetUserName(data, StrToIntDef(str, 255));
          {Actor.m_sDescUserName := GetValidStr3(data, str, ['\']);
            //actor.UserName := data;
            i := StrToIntDef(str, 255);
            Actor.SetUsername(str, GetRGB(i));  }
          {if Actor.m_Group <> nil then begin
              if Actor.m_Group.ClientGroup.NameColor <> i then begin
                FrmDlg2.m_boChangeGroup := True;
                Actor.m_Group.ClientGroup.NameColor := i;
              end;
            end;  }
        end;
      end;
    end;

    SM_BACKSTEP:
    begin
      if Length(body) > GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) then
      begin
        body2 := Copy(body, GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) + 1, Length(body));
        data := DecodeString(body2); //某腐 捞抚
        str := GetValidStr3(data, data, ['/']);
        //data = 捞抚
        //str = 祸哎
      end
      else
        data := '';
      DecodeBuffer(body, @desc, sizeof(TCharDesc));
      PlayScene.SendMsg(SM_BACKSTEP, Msg.Recog,
                         Msg.param {x},
                         Msg.tag {y},
                         Msg.series {dir + light},
                         desc.Feature,
                         desc.Status,
                         '', desc.btStrengthenIdx, desc.btWuXin); //捞抚
      if data <> '' then
      begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then
        begin
          Actor.GetUserName(data, StrToIntDef(str, 255));
          {Actor.m_sDescUserName := GetValidStr3(data, str, ['\']);
            //actor.UserName := data;
            i := StrToIntDef(str, 255);
            Actor.SetUsername(str, GetRGB(i));  }
          {if Actor.m_Group <> nil then begin
              if Actor.m_Group.ClientGroup.NameColor <> i then begin
                FrmDlg2.m_boChangeGroup := True;
                Actor.m_Group.ClientGroup.NameColor := i;
              end;
            end;    }
        end;
      end;
    end;

    SM_SPACEMOVE_HIDE,
    SM_SPACEMOVE_HIDE2,
    SM_SPACEMOVE_HIDE3:
    begin
      if Msg.Recog <> g_MySelf.m_nRecogId then
      begin
        PlayScene.SendMsg(Msg.ident, Msg.Recog, Msg.param {x}, Msg.tag {y}, 0, 0, 0, '')
      end;
    end;

    SM_SPACEMOVE_SHOW,
    SM_SPACEMOVE_SHOW2,
    SM_SPACEMOVE_SHOW3:
    begin
      if Length(body) > GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) then
      begin
        body2 := Copy(body, GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) + 1, Length(body));
        data := DecodeString(body2); //某腐 捞抚
        str := GetValidStr3(data, data, ['/']);
        //data = 捞抚
        //str = 祸哎
      end
      else
        data := '';
      DecodeBuffer(body, @desc, sizeof(TCharDesc));
      if Msg.Recog <> g_MySelf.m_nRecogId then
      begin
        //促弗 某腐磐牢 版快
        PlayScene.NewActor(Msg.Recog, Msg.param, Msg.tag, Msg.series, desc.Feature, desc.Status,
                            desc.btStrengthenIdx, desc.btWuXin);
      end;
      PlayScene.SendMsg(Msg.ident, Msg.Recog,
                         Msg.param {x},
                         Msg.tag {y},
                         Msg.series {dir + light},
                         desc.Feature,
                         desc.Status,
                         '', desc.btStrengthenIdx, desc.btWuXin); //捞抚
      if data <> '' then
      begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then
        begin
          Actor.GetUserName(data, StrToIntDef(str, 255));
          {Actor.m_sDescUserName := GetValidStr3(data, str, ['\']);
            //actor.UserName := data;
            i := StrToIntDef(str, 255);
            Actor.SetUsername(str, GetRGB(i));  }
          {if Actor.m_Group <> nil then begin
              if Actor.m_Group.ClientGroup.NameColor <> i then begin
                FrmDlg2.m_boChangeGroup := True;
                Actor.m_Group.ClientGroup.NameColor := i;
              end;
            end;   }
        end;
      end;
    end;

    SM_WALK, SM_RUSH, SM_RUSHCBO, SM_RUSHKUNG, SM_MAGICMOVE, SM_MAGICFIR:
    begin
      //DScreen.AddSysMsg ('WALK ' + IntToStr(msg.Param) + ':' + IntToStr(msg.Tag));
      DecodeBuffer(body, @desc, sizeof(TCharDesc));
      if (Msg.Recog <> g_MySelf.m_nRecogId) or (Msg.ident = SM_RUSH) or (msg.Ident = SM_RUSHCBO) or (msg.Ident = SM_MAGICMOVE) or
      (Msg.ident = SM_RUSHKUNG) or (Msg.ident = SM_MAGICFIR) then
        PlayScene.SendMsg(Msg.ident, Msg.Recog,
                           Msg.param {x},
                           Msg.tag {y},
                           Msg.series {dir+light},
                           desc.Feature,
                           desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);
      if (Msg.ident = SM_RUSH) or (Msg.ident = SM_RUSHCBO) then
        g_dwLatestRushRushTick := GetTickCount;
    end;

    SM_RUN, SM_HORSERUN, SM_LEAP:
    begin
      //DScreen.AddSysMsg ('RUN ' + IntToStr(msg.Param) + ':' + IntToStr(msg.Tag));
      DecodeBuffer(body, @desc, sizeof(TCharDesc));
      if Msg.Recog <> g_MySelf.m_nRecogId then
        PlayScene.SendMsg(Msg.ident, Msg.Recog,
                           Msg.param {x},
                           Msg.tag {y},
                           Msg.series {dir+light},
                           desc.Feature,
                           desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);
    end;

    SM_MOVEFAIL:
    begin
      ActionFailed;
      DecodeBuffer(body, @desc, sizeof(TCharDesc));
      PlayScene.SendMsg(SM_TURN, Msg.Recog,
                         Msg.param {x},
                         Msg.tag {y},
                         Msg.series {dir},
                         desc.Feature,
                         desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);
    end;
    SM_BUTCH:
    begin
      DecodeBuffer(body, @desc, sizeof(TCharDesc));
      if Msg.Recog <> g_MySelf.m_nRecogId then
      begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then
          Actor.SendMsg(SM_SITDOWN,
                         Msg.param {x},
                         Msg.tag {y},
                         Msg.series {dir},
                         0, 0, '', 0);
      end;
    end;
    SM_CHANGEEFFIGYSTATE:
    begin
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
        Actor.SetEffigyState(Msg.Param, Msg.tag);
    end;
    SM_SITDOWN:
    begin
      DecodeBuffer(body, @desc, sizeof(TCharDesc));
      if Msg.Recog <> g_MySelf.m_nRecogId then
      begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then
          Actor.SendMsg(SM_SITDOWN,
                         Msg.param {x},
                         Msg.tag {y},
                         Msg.series {dir},
                         0, 0, '', 0);
      end;
    end;

    SM_HIT, //14
    SM_HEAVYHIT, //15
    SM_POWERHIT, //18
    SM_LONGHIT, //19
    SM_WIDEHIT, //24
    SM_BIGHIT, //16
    SM_FIREHIT, //8{烈火}
    SM_CRSHIT,
    SM_110,
    SM_111,
    SM_112,
    SM_113,
    SM_122,
    SM_56,
    SM_HIT_2,
    SM_HIT_3,
    SM_HIT_4,
    SM_HIT_5,
    SM_TWINHIT,
    SM_LONGICEHIT_L,
    SM_LONGICEHIT_S:
    begin
      if Msg.Recog <> g_MySelf.m_nRecogId then
      begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then
        begin
          Actor.SendMsg(Msg.ident,
                         Msg.param {x},
                         Msg.tag {y},
                         Msg.series {dir},
                         0, 0, '',
                         0);
          if Msg.ident = SM_HEAVYHIT then
          begin
            if body <> '' then
              Actor.m_boDigFragment := True;
          end;
        end;
      end;
    end;
    SM_FLYAXE:
    begin
      DecodeBuffer(body, @mbw, sizeof(TMessageBodyW));
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        Actor.SendMsg(Msg.ident,
                       Msg.param {x},
                       Msg.tag {y},
                       Msg.series {dir},
                       0, 0, '',
                       0);
        Actor.m_nTargetX := mbw.Param1; //x 带瘤绰 格钎
        Actor.m_nTargetY := mbw.Param2; //y
        Actor.m_nTargetRecog := MakeLong(mbw.Tag1, mbw.Tag2);
      end;
    end;

    SM_LIGHTING:
    begin
      DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        Actor.SendMsg(Msg.ident,
                       Msg.param {x},
                       Msg.tag {y},
                       Msg.series {dir},
                       0, 0, '',
                       0);
        Actor.m_nTargetX := wl.lParam1; //x 带瘤绰 格钎
        Actor.m_nTargetY := wl.lParam2; //y
        Actor.m_nTargetRecog := wl.lTag1;
        Actor.m_nMagicNum := wl.lTag2; //付过 锅龋
      end;
    end;

    SM_SPELL:
    begin
      UseMagicSpell(Msg.Recog {who}, Msg.series {effectnum}, Msg.param {tx},
                     Msg.tag {y}, StrToIntDef(body, 0));
    end;
    SM_MAGICFIRE:
    begin
      DecodeBuffer(body, @param, sizeof(Integer));
      UseMagicFire(Msg.Recog {who}, Lobyte(Msg.series) {efftype},
                    Hibyte(Msg.series) {effnum}, Msg.param {tx}, Msg.tag {y}, param);
      //Lobyte(msg.Series) = EffectType
      //Hibyte(msg.Series) = Effect
    end;
    SM_MAGICFIRE_FAIL:
    begin
      UseMagicFireFail(Msg.Recog {who});
    end;
    SM_MAGICFIRE_CBO:
    begin
      if g_MySelf <> nil then
        SetMagicUse(Msg.Recog);
    end;
    SM_FBTIME:
    begin
      if msg.Series = 1 then g_FBTime := Msg.Recog
      else if msg.Series = 2 then g_FBExitTime := Msg.Recog
      else g_FBFailTime := Msg.Recog;

    end;
    SM_GETTOPINFO:
    begin
      if Msg.Series = 1 then
      begin
        FrmDlg.DMessageDlg(DecodeString(body), [mbOk]);
        FrmDlg3.FboTopSend := False;
      end else begin
        FrmDlg3.FboTopSend := False;
        FrmDlg3.FnMaxTopPage := Msg.tag;
        FrmDlg3.FnMinTopPage := Msg.Param;
        if body <> '' then
        begin
          DecodeBuffer(Body, @FrmDlg3.FTopInfo[0], SizeOf(TClientTopInfo));
        end else begin
          FillChar(FrmDlg3.FTopInfo, SizeOf(TClientTopInfo), #0);
        end;
      end;
    end;

    SM_ITEMSTRENGTHEN:
    begin
      g_MySelf.m_nGold := msg.recog;
      g_nBindGold := msg.Param;
      FrmDlg3.ClientStrengthenItems(Msg.Series, body);
    end;
    SM_ITEMABILITYMOVE:
    begin
      g_MySelf.m_nGold := msg.recog;
      FrmDlg4.ClientAbilityMoveItems(Msg.Series, DeCodeString(body));
    end;
    SM_COMPOUNDITEM:
    begin
      g_MySelf.m_nGold := msg.recog;
      g_MySelf.m_nGameGold := msg.Param;
      FrmDlg4.ClientCompoundItem(Msg.Series, DeCodeString(body));
    end;
    SM_MAKEDRUG:
    begin
      g_MySelf.m_nGold := msg.recog;
      g_nBindGold := msg.Param;
      FrmDlg3.ClientMakeItems(Msg.Series, 1, body);
    end;
    SM_MAKEDRUG_AUTO:
    begin
      g_MySelf.m_nGold := msg.recog;
      g_nBindGold := msg.Param;
      FrmDlg3.ClientMakeItems(-8, Msg.Series, body);
    end;
    SM_BAGUSEITEM:
    begin
      g_SendSelectItem.s.name := '';
      if msg.Series = 1 then
      begin
        if msg.Recog > 0 then
        begin
          ClientGetBabDuraChange(g_SendSelectItem.UserItem.MakeIndex, msg.recog, g_SendSelectItem.UserItem.DuraMax);
        end
        else begin
          DelItemBag(g_SendSelectItem.UserItem.wIndex, g_SendSelectItem.UserItem.MakeIndex);
        end;
        DecodeItem(body, @UserItem);
        UpdateItemBagByUserItem(UserItem);
        FrmDlg.FShowItemEffectTick := GetTickCount + 1500;
        FrmDlg.FShowItemEffectIndex := UserItem.MakeIndex;
      end;
    end;
    SM_UNSEAL_OK:
    begin
      FrmDlg3.ClientUnSealItems(Msg.Series, body);
    end;
    SM_OUTOFCONNECTION:
    begin
      g_boDoFastFadeOut := FALSE;
      g_boDoFadeIn := FALSE;
      g_boDoFadeOut := FALSE;
      FrmDlg.DMessageDlg('服务器连接被强行中断。\' +
      '连接时间可能超过限制。\' +
      '或者用户请求重新连接。', [mbOk]);
      Close;
    end;

    SM_DEATH,
    SM_NOWDEATH:
    begin
      DecodeBuffer(body, @desc, sizeof(TCharDesc));
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        Actor.m_btStrengthenIdx := desc.btStrengthenIdx;
        Actor.m_btWuXin := desc.btWuXin;
        Actor.SendMsg(Msg.ident,
                       Msg.param {x}, Msg.tag {y}, Msg.series {damage},
                       desc.Feature, desc.Status, '',
                       0);
        Actor.m_Abil.HP := 0;
        if Actor.m_Group <> nil then
        begin
          Actor.m_Group.ClientGroup.HP := 0;
        end;
      end
      else begin
        PlayScene.SendMsg(SM_DEATH, Msg.Recog, Msg.param {x}, Msg.tag {y},
                           Msg.series {damage}, desc.Feature, desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);
      end;
    end;
    SM_SKELETON:
    begin
      DecodeBuffer(body, @desc, sizeof(TCharDesc));
      PlayScene.SendMsg(SM_SKELETON, Msg.Recog, Msg.param {HP}, Msg.tag
          {maxHP}, Msg.series {damage}, desc.Feature, desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);
    end;
    SM_USERKEYSETUP:
    begin
      g_boUseWuXin := (Msg.Series = 0);
      body2 := GetValidStr3(body, body, ['/']);
      DecodeBuffer(body, @g_UserKeySetup, sizeof(g_UserKeySetup));
      RefUserKeyItemInfo(nil);
      RefM2SetupInfo(Msg.Recog);

      body2 := DecodeString(body2);
      body2 := GetValidStr3(body2, str, ['/']);
      if str <> '' then g_Cmd_UserMove := str;
      body2 := GetValidStr3(body2, str, ['/']);
      if str <> '' then g_Cmd_MemberFunction := str;
      body2 := GetValidStr3(body2, str, ['/']);
      if str <> '' then g_Cmd_MemberFunctionEx := str;
      body2 := GetValidStr3(body2, str, ['/']);
      if str <> '' then g_Cmd_Auth := str;
      body2 := GetValidStr3(body2, str, ['/']);
      if str <> '' then g_Cmd_AuthCancel := str;
      body2 := GetValidStr3(body2, str, ['/']);
      if str <> '' then g_Cmd_EndGuild := str;
      body2 := GetValidStr3(body2, str, ['/']);
      if str <> '' then g_Cmd_AllMsg := str;
      body2 := GetValidStr3(body2, str, ['/']);
      if str <> '' then g_Cmd_TakeOnHorse := str;
      body2 := GetValidStr3(body2, str, ['/']);
      if str <> '' then g_Cmd_TakeOffHorse := str;
    end;
    SM_ALIVE:
    begin

      DecodeBuffer(body, @desc, sizeof(TCharDesc));
      PlayScene.SendMsg(SM_ALIVE, Msg.Recog, Msg.param {HP}, Msg.tag {maxHP},
                         Msg.series {damage}, desc.Feature, desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);

    end;
    SM_SETITEMS: ClientGetSetItems(@msg, body);
    SM_ABILITY:
    begin
      if g_MySelf <> nil then
      begin
        g_MySelf.m_nGold := Msg.Recog;
        g_MySelf.m_btJob := Msg.param;
        FrmDlg.RefJobMagic(Msg.param);
        g_nBindGold := Msg.tag;
        DecodeBuffer(body, @g_MySelf.m_Abil, sizeof(TAbility));
{$IF Var_Interface =  Var_Default}
        if g_MySelf.m_Abil.Level < 2 then ShowInterface(True);
{$IFEND}
      end;
    end;

    SM_SUBABILITY:
    begin
      if g_MySelf <> nil then
      begin
        DecodeBuffer(body, @ClientAppendSubAbility, Sizeof(ClientAppendSubAbility));
        g_nMyHitPoint := Lobyte(LoWord(Msg.param));
        g_nMySpeedPoint := Lobyte(HiWord(Msg.param));
        g_nMyAntiPoison := Lobyte(LoWord(Msg.tag));
        g_nMyPoisonRecover := Lobyte(HiWord(Msg.tag));
        g_nMyHealthRecover := Lobyte(LoWord(Msg.series));
        g_nMySpellRecover := Lobyte(HiWord(Msg.series));
        g_nMyAntiMagic := Lobyte(LoWord(Msg.Recog));
        g_MySelf.m_btWuXin := Hibyte(LoWord(Msg.Recog));
        g_nMyAddAttack := Lobyte(HiWord(Msg.Recog));
        g_nMyDelDamage := Hibyte(HiWord(Msg.Recog));
        g_nMyAddWuXinAttack := LoByte(LoWord(ClientAppendSubAbility.nParam1));
        g_nMyDelWuXinAttack := HiByte(LoWord(ClientAppendSubAbility.nParam1));
        g_nDeadliness := LoByte(HiWord(ClientAppendSubAbility.nParam1));
        g_nGameGird := ClientAppendSubAbility.nParam2;
        g_nLiterary := ClientAppendSubAbility.nParam3;
      end;
    end;
    SM_GAMEGOLDNAME3:
    begin
      g_nGameGird := Msg.Recog;
      g_nLiterary := Msg.tag;
    end;
      {SM_SUBABILITY2: begin
        if g_MySelf <> nil then begin
          g_MySelf.m_btWuXin := LoByte(msg.Param);
          g_MySelf.m_btWuXinLevel := HiByte(msg.Param);
          g_MySelf.m_dwWuXinExp := msg.Recog;
          g_MySelf.m_dwWuXinMaxExp := MakeLong(msg.tag, msg.Series);
        end;
      end; }
    SM_AD_EXIT: g_sExitUrl := DecodeString(body);
    SM_AD_FRAME: OpenADForm(LoWord(Msg.Recog), HiWord(Msg.Recog), DecodeString(body));

    SM_DAYCHANGING:
    begin
      //g_nDayBright := Msg.param;
      {DarkLevel := Msg.tag;
        if DarkLevel = 0 then
          g_boViewFog := FALSE
        else
          g_boViewFog := True;}
    end;
      {SM_WUXINEXP: begin
        g_MySelf.m_dwWuXinExp := Msg.Recog;
        tempword := LongWord(MakeLong(msg.Param, msg.Tag));
        if (tempword mod 60000) = 0 then
          DScreen.AddSysMsg('获得 <CO$FFFF>' + IntToStr(tempword div 60000) + '<CE> 点五行经验', cllime)
        else
          DScreen.AddSysMsg('获得 <CO$FFFF>' + format('%.1f', [tempword / 60000]) + '<CE> 点五行经验', cllime);
      end;   }

    SM_WINEXP:
    begin
      if msg.Series = 2 then
      begin
        g_UseItems[u_House].UserItem.dwExp := Msg.recog;
        DScreen.AddSysMsg('恭喜你坐骑升到了 <CO$FFFF>' + IntToStr(Msg.recog) + '<CE> 级', cllime);
      end else
        if msg.Series = 1 then
        begin
          g_UseItems[u_House].UserItem.dwExp := Msg.recog;
          if g_SetupInfo.boGetExpFiltrate then
          begin
            if LongWord(msg.Param) > g_SetupInfo.nExpFiltrateCount then
              DScreen.AddSysMsg('获得 <CO$FFFF>' + IntToStr(LongWord(msg.Param)) + '<CE> 点坐骑经验值', cllime); //$32F4
          end else
            DScreen.AddSysMsg('获得 <CO$FFFF>' + IntToStr(LongWord(msg.Param)) + '<CE> 点坐骑经验值', cllime); //$32F4
        end else begin
          g_MySelf.m_Abil.Exp := Msg.Recog;
          if g_SetupInfo.boGetExpFiltrate then
          begin
            if LongWord(MakeLong(msg.Param, msg.Tag)) > g_SetupInfo.nExpFiltrateCount then
              DScreen.AddSysMsg('获得 <CO$FFFF>' + IntToStr(LongWord(msg.Param)) + '<CE> 点经验值', cllime); //$32F4
          end else
            DScreen.AddSysMsg('获得 <CO$FFFF>' + IntToStr(LongWord(msg.Param)) + '<CE> 点经验值', cllime); //$32F4
        end;
    end;

    SM_LEVELUP:
    begin
      g_nMakeMagicPoint := Msg.Series;
      if g_MySelf.m_Abil.Level <> Msg.param then
      begin
        g_MySelf.m_Abil.Level := Msg.param;
        DScreen.AddSysMsg('恭喜你升到了 <CO$FFFF>' + IntToStr(Msg.param) + '<CE> 级', cllime);
        PlayScene.RefMissionInfo;
      end;
      {if g_MySelf.m_btWuxinLevel <> Msg.tag then begin
          g_MySelf.m_btWuxinLevel := Msg.tag;
          DScreen.AddSysMsg('五行提升到了 <CO$FFFF>' + IntToStr(Msg.tag) + '<CE> 级', cllime);
        end;     }
    end;
    SM_MAKEMAGIC:
    begin
      g_boSendMakeMagicAdd := False;
      g_nMakeMagicPoint := Msg.Series;
      g_btMakeMagicAddPoint := LoByte(Msg.Param);
      g_btMakeMagicUsePoint := HiByte(Msg.Param);
      g_btMakeMagicAddRate := LoByte(Msg.Tag);
      g_btMakeMagicMaxLevel := HiByte(Msg.Tag);
      DecodeBuffer(body, @g_MakeMagic[0], SizeOf(TMakeMagic));
    end;

    SM_HEALTHSPELLCHANGED:
    begin
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        //GetMoveHMShow(Actor, msg.Param, msg.Tag);
        Actor.m_Abil.HP := Msg.param;
        Actor.m_Abil.MP := Msg.tag;
        Actor.m_Abil.MaxHP := Msg.series;
      end;
      if Actor.m_Group <> nil then
      begin
        Actor.m_Group.ClientGroup.HP := msg.Param;
        Actor.m_Group.ClientGroup.MP := Msg.tag;
        Actor.m_Group.ClientGroup.MaxHP := Msg.Series;
        if Actor.m_Group.ClientGroup.MaxMP < Actor.m_Group.ClientGroup.MP then
          Actor.m_Group.ClientGroup.MaxMP := Actor.m_Group.ClientGroup.MP;
      end;
    end;

    SM_STRUCK:
    begin
      //wl: TMessageBodyWL;
      DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        if Actor = g_MySelf then
        begin
          if g_MySelf.m_OldNameColor = 249 then
              //弧盎捞绰 嘎栏搁 立加阑 给 谗绰促.
            g_dwLatestStruckTick := GetTickCount;
        end
        else begin
          if Actor.CanCancelAction then
            Actor.CancelAction;
        end;
        if Actor <> g_MySelf then
        begin
          Actor.UpdateMsg(SM_STRUCK, LoWord(wl.lTag2), 0, Msg.series {damage}, wl.lParam1, wl.lParam2, '', wl.lTag1);
        end
        else begin
          g_nDander := HiWord(wl.lTag2);
        end;
        GetMoveHPShow(Actor, msg.Series);
        Actor.m_Abil.HP := Msg.param;
        Actor.m_Abil.MaxHP := Msg.tag;

        if Actor.m_Group <> nil then
        begin
          Actor.m_Group.ClientGroup.HP := msg.Param;
          Actor.m_Group.ClientGroup.MaxHP := Msg.tag;
        end;

      end;
    end;

    SM_GROUPINFO1,
    SM_GROUPINFO2:
    begin
      ClientGetGroupInfo(Msg, DecodeString(body));
    end;

    SM_CHANGEFACE:
    begin
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        Actor.m_nWaitForRecogId := Msg.param;
        Actor.m_nWaitForFeature := desc.Feature;
        Actor.m_nWaitForStatus := desc.Status;
        Actor.m_btStrengthenIdx := desc.btStrengthenIdx;
        Actor.m_btWuXin := desc.btWuXin;
        AddChangeFace(Actor.m_nWaitForRecogId);
      end;
    end;
      {SM_PASSWORD: begin
        //PlayScene.EdChat.PasswordChar:='*';
        SetInputStatus();
      end;   }
    SM_OPENHEALTH:
    begin
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        if Actor <> g_MySelf then
        begin
          Actor.m_Abil.HP := Msg.param;
          Actor.m_Abil.MaxHP := Msg.tag;
        end;
        if Actor.m_Group <> nil then
        begin
          Actor.m_Group.ClientGroup.HP := msg.Param;
          Actor.m_Group.ClientGroup.MaxHP := Msg.tag;
        end;
        Actor.m_boOpenHealth := True;
        //actor.OpenHealthTime := 999999999;
        //actor.OpenHealthStart := GetTickCount;
      end;
    end;
    SM_CLOSEHEALTH:
    begin
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        Actor.m_boOpenHealth := FALSE;
      end;
    end;
    SM_APPEND: ClientGetAppend(@Msg, body);
    SM_INSTANCEHEALGUAGE:
    begin
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        Actor.m_Abil.HP := Msg.param;
        Actor.m_Abil.MaxHP := Msg.tag;
      end;
    end;

    SM_BREAKWEAPON:
    begin
      //武器破碎
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        if Actor is THumActor then
          THumActor(Actor).DoWeaponBreakEffect;
      end;
    end;
      {SM_WHISPER: begin
        str := DecodeString(body);
        CheckBlockListSys(SM_WHISPER, str, body);
        DScreen.AddChatBoardString(str, GetRGB(Lobyte(Msg.param)),
          GetRGB(Hibyte(Msg.param)));
        if (body <> '') and (g_MySelf <> nil) and (body <> g_MySelf.m_UserName) then
          if g_MyWhisperList.IndexOf(body) = -1 then
            g_MyWhisperList.Insert(0, body);
      end;  }
    SM_HEAR,
    SM_CRY, //喊话
    SM_GROUPMESSAGE, //   组队
    SM_GUILDMESSAGE, //行会
    SM_WHISPER, //私聊
    SM_SYSMESSAGE, {//系统消息}
    SM_BUGLE: {喇叭}
    begin
      if boOutMsg then
      begin
        DebugOutStr(body);
        DebugOutStr(DecodeString(body));
      end;
      ClientGetSayMsg(Msg, DecodeString(body));
    end;
      {SM_CRY,
      SM_GROUPMESSAGE,
      SM_GUILDMESSAGE,
      SM_SYSMESSAGE: begin
        if (Msg.Ident = SM_CRY) and (g_CloseCrcSys) and
          (not CheckBlockListSys(msg.Ident, DecodeString(body), body)) then
          exit;
        if (Msg.Ident = SM_WHISPER) and (g_CloseMySys) then
          exit;
        if (Msg.Ident = SM_GUILDMESSAGE) and (g_CloseGuildSys) then
          exit;
        str := DecodeString(body);
        DScreen.AddChatBoardString(str, GetRGB(Lobyte(Msg.param)),
          GetRGB(Hibyte(Msg.param)));
        if Msg.ident = SM_GUILDMESSAGE then
          FrmDlg.AddGuildChat(str);
      end;

    SM_HEAR: begin
        str := DecodeString(body);
        if (not g_CloseAllSys) then
          DScreen.AddChatBoardString(str, GetRGB(Lobyte(Msg.param)),
            GetRGB(Hibyte(Msg.param)));
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then
          Actor.Say(str);
      end;   }
    SM_HINTMSG:
    begin
      DScreen.AddSysMsg(DecodeString(body), Msg.Recog);
    end;
    SM_GETSAYITEM:
    begin
      ClientGetSayItem(Msg, body);
    end;

    SM_USERNAME:
    begin
      str := DecodeString(body);
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        Actor.m_btWuXin := Msg.tag;
        Actor.GetUserName(str, Msg.param);
        {Actor.m_sDescUserName := GetValidStr3(str, str, ['\']);
          //actor.UserName := str;
          i := GetRGB(Msg.param);
          Actor.SetUsername(str, i);  }
        {if Actor.m_Group <> nil then begin
            if Actor.m_Group.ClientGroup.NameColor <> Msg.param then begin
              FrmDlg2.m_boChangeGroup := True;
              Actor.m_Group.ClientGroup.NameColor := Msg.param;
            end;
          end;  }
      end;
    end;
    SM_CHANGENAMECOLOR:
    begin
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        //Actor.m_nNameColor := GetRGB(Msg.param);
        Actor.SetUsername('', Msg.param);
        {if Actor.m_Group <> nil then begin
            if Actor.m_Group.ClientGroup.NameColor <> Msg.param then begin
              FrmDlg2.m_boChangeGroup := True;
              Actor.m_Group.ClientGroup.NameColor := Msg.param;
            end;
          end;     }
      end;
    end;

    SM_HIDE,
    SM_GHOST, //儡惑..
    SM_DISAPPEAR:
    begin
      if g_MySelf.m_nRecogId <> Msg.Recog then
        PlayScene.SendMsg(SM_HIDE, Msg.Recog, Msg.param {x}, Msg.tag {y}, 0, 0, 0, '');
    end;

    SM_DIGUP:
    begin
      DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor = nil then
        Actor := PlayScene.NewActor(Msg.Recog, Msg.param, Msg.tag, Msg.series, wl.lParam1, wl.lParam2);
      Actor.m_nCurrentEvent := wl.lTag1;
      Actor.SendMsg(SM_DIGUP,
                     Msg.param {x},
                     Msg.tag {y},
                     Msg.series {dir + light},
                     wl.lParam1,
                     wl.lParam2, '', 0);
    end;
    SM_DIGDOWN:
    begin
      PlayScene.SendMsg(SM_DIGDOWN, Msg.Recog, Msg.param {x}, Msg.tag {y}, 0, 0, 0, '');
    end;
    SM_SHOWEVENT:
    begin
      //DecodeBuffer(body, @smsg, sizeof(TShortMessage));
      event := TClEvent.Create(Msg.Recog, Loword(Msg.tag) {x}, Msg.series {y}, Msg.param {e-type});
      event.m_nDir := 0;
      event.m_nEventParam := StrToIntDef(DecodeString(body), 0);
      EventMan.AddEvent(event); //clvent啊 Free瞪 荐 乐澜
    end;
    SM_HIDEEVENT:
    begin
      EventMan.DelEventById(Msg.Recog);
    end;

      //Item ??
    SM_ADDITEM:
    begin
      ClientGetAddItem(msg, body);
    end;
    SM_GROUPADDITEM: ClientGetGroupAddItem(@Msg);

    SM_BAGITEMS:
    begin
      ClientGetBagItmes(body);
    end;
    SM_SENDADDBAGITEMS:
    begin
      ClientGetAddBagItmes(body);
    end;
    SM_TAKEOFFADDBAG_OK:
    begin
      AddItemBag(g_MoveAddBagItem.Item);
      g_MoveAddBagItem.Item.s.Name := '';
      RecalcBagCount();
      FrmDlg.RefAddBagWindow();
      ArrangeItemBagEx();
    end;
    SM_TAKEOFFADDBAG_FAIL:
    begin
      if g_MoveAddBagItem.Index2 in [Low(g_AddBagItems)..High(g_AddBagItems)] then
        g_AddBagItems[g_MoveAddBagItem.Index2] := g_MoveAddBagItem.Item;
      g_MoveAddBagItem.Item.s.Name := '';
      RecalcBagCount();
      FrmDlg.RefAddBagWindow();
      FrmDlg.DMessageDlg('卸下失败，请先清空背包中的物品\并且必需要留出一格用来存放背包', []);
      ArrangeItemBagEx();
    end;
    SM_UPDATEUSERITEM:
    begin
      ClientUpdateUserItem(body);
    end;
    SM_TAKEONADDBAG_OK:
    begin
      if Msg.Series in [Low(g_AddBagItems)..High(g_AddBagItems)] then
        g_AddBagItems[Msg.Series] := g_MoveAddBagItem.Item;
      g_MoveAddBagItem.Item.s.Name := '';
      RecalcBagCount();
      FrmDlg.RefAddBagWindow();
      ArrangeItemBagEx();
    end;
    SM_TAKEONADDBAG_FAIL:
    begin
      AddItemBag(g_MoveAddBagItem.Item, g_MoveAddBagItem.Index2);
      g_MoveAddBagItem.Item.s.Name := '';
      RecalcBagCount();
      FrmDlg.RefAddBagWindow();
      ArrangeItemBagEx();
    end;
    SM_UPDATEITEM:
    begin
      ClientGetUpdateItem(body);
    end;
    SM_DELITEM:
    begin
      //ClientGetDelItem(body);
      ClientGetDelItem(Msg.Recog, msg.Param);
    end;
    SM_DELITEMS:
    begin
      ClientGetDelItems(body);
    end;

    SM_DROPITEM_SUCCESS:
    begin
      DelDropItem(Msg.Recog);
      ArrangeItemBagEx;
    end;
    SM_DROPITEM_FAIL:
    begin
      ClientGetDropItemFail(Msg.Recog);
    end;

    SM_FRIEND_LOGIN:
    begin
      ClientGetFriendChange(@Msg, body);
    end;
    SM_EMAIL:
    begin
      ClientGetEMail(@Msg, body);
    end;

    SM_ITEMSHOW: ClientGetShowItem(Msg.Recog, Msg.param {x}, Msg.tag {y},
                                    Msg.series {looks}, DecodeString(body));
    SM_ITEMHIDE: ClientGetHideItem(Msg.Recog, Msg.Series);
    SM_OPENDOOR_OK: Map.OpenDoor(Msg.param, Msg.tag);
    SM_OPENDOOR_LOCK: DScreen.AddSysMsg('[门被锁住了]', clWhite);
    SM_CLOSEDOOR: Map.CloseDoor(Msg.param, Msg.tag);

    SM_TAKEON_AUTO:
    begin
      g_MySelf.m_nFeature := Msg.Recog;
      g_MySelf.FeatureChanged;
      DecodeItem(body, @g_UseItems[Msg.Series].UserItem);
      g_UseItems[Msg.Series].s := GetStditem(g_UseItems[Msg.Series].UserItem.wIndex);
      //DecodeItem(body, @cu.UserItem);
    end;

    SM_TAKEON_OK:
    begin
      g_MySelf.m_nFeature := Msg.Recog;
      g_MySelf.FeatureChanged;
      //            if WaitingUseItem.Index in [0..8] then
      if g_WaitingUseItem.Index2 in [0..MAXUSEITEMS - 1] then
        g_UseItems[g_WaitingUseItem.Index2] := g_WaitingUseItem.Item;
      if g_WaitingUseItem.Index2 in [16..20] then
        g_UseItems[U_HOUSE].UserItem.HorseItems[g_WaitingUseItem.Index2 - 16] := UserItemToHorseItem(@g_WaitingUseItem.Item.UserItem);
      g_WaitingUseItem.Item.S.name := '';
      ArrangeItemBagEx();
    end;
    SM_TAKEON_FAIL:
    begin
      AddItemBag(g_WaitingUseItem.Item);
      g_WaitingUseItem.Item.S.name := '';
      ArrangeItemBagEx();
    end;
    SM_TAKEOFF_OK:
    begin
      g_MySelf.m_nFeature := Msg.Recog;
      g_MySelf.FeatureChanged;
      AddItemBag(g_WaitingUseItem.Item);
      g_WaitingUseItem.Item.S.name := '';
      ArrangeItemBagEx();
    end;
    SM_TAKEOFF_FAIL:
    begin
      if g_WaitingUseItem.Index2 < 0 then
      begin
        n := -(g_WaitingUseItem.Index2 + 1);
        if n in [0..MAXUSEITEMS - 1] then
          g_UseItems[n] := g_WaitingUseItem.Item;
        if n in [16..20] then
          g_UseItems[U_HOUSE].UserItem.HorseItems[n - 16] := UserItemToHorseItem(@g_WaitingUseItem.Item.UserItem);
      end;
      g_WaitingUseItem.Item.S.name := '';
      ArrangeItemBagEx();
    end;

    SM_OPENARMSTRENGTHENDLG:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      FrmDlg3.DWndArmStrengthen.Visible := True;
    end;

    SM_OPENARMABILITYMOVEDLG:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      FrmDlg4.DWndArmAbilityMove.Visible := True;
    end;

    SM_UNSEAL:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      FrmDlg3.DWndItemUnseal.Visible := True;
    end;
    SM_REMOVESTONE:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      FrmDlg4.DWndItemRemove.Visible := True;
    end;
    SM_REMOVESTONE_BACK:
    begin
      case Msg.Recog of
        -1:
        begin
          FrmDlg.DMessageDlg('[卸下失败]：提交的信息错误！', []);
          FrmDlg4.FRemoveStoneLock := False;
          g_SendRemoveStoneItem.s.name := '';
        end;
        -2:
        begin
          FrmDlg.DMessageDlg('[卸下失败]：卸下所使用的道具错误！', []);
          FrmDlg4.FRemoveStoneLock := False;
          g_SendRemoveStoneItem.s.name := '';
        end;
        -3:
        begin
          FrmDlg.DMessageDlg('[卸下失败]：装备没有可卸下的宝石！', []);
          FrmDlg4.FRemoveStoneLock := False;
          g_SendRemoveStoneItem.s.name := '';
        end;
        1:
        begin
          if g_CursorMode = cr_Srepair then
          begin
            g_CursorMode := cr_None;
            Cursor := crMyNone;
          end;
          PlaySoundEx(bmg_Repair);
          FrmDlg4.FRemoveStoneIdx := Msg.Series;
          FrmDlg4.FRemoveStoneIndex := Msg.Param;
          FrmDlg4.FRemoveStoneShowEffect := True;
          FrmDlg4.FRemoveStoneShowEffectIdx := 0;
          FrmDlg4.DItemRemoveItems.AppendTick := GetTickCount;
          {DelItemBag(g_SendRemoveStoneItem.UserItem.wIndex, g_SendRemoveStoneItem.UserItem.MakeIndex);
              AddNewItemToBagByIdx(FrmDlg4.FRemoveStoneItem.Item.UserItem.Value.wFlute[Msg.Series], MakeLong(Msg.Param, Msg.tag));
              FrmDlg4.FRemoveStoneItem.Item.UserItem.Value.wFlute[Msg.Series] := 0;}
        end;
      end;
      //g_SendRemoveStoneItem.s.name := '';

    end;
    SM_GETUSERSHOPLIST_OFFLINE: ClientGetMyShopList(@Msg, body);
    SM_USEROPENSHOP:
    begin
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
      begin
        Actor.m_boShop := Msg.Series = 1;
        if Actor.m_boShop then
        begin
          Actor.m_sShopTitle := DecodeString(body);
          Actor.m_btShopIdx := Byte(msg.Param) - 1;
          Actor.m_boShopLeft := msg.Tag <> 0;
          if Actor.m_boShopLeft then
            Actor.m_btDir := 1
          else
            Actor.m_btDir := 5;
          if Msg.Recog = g_nMyReadShopDlgID then
          begin
            FrmDlg2.DReadUserShop.Visible := False;
            g_nMyReadShopDlgX := -1;
          end;
        end
        else begin
          if FrmDlg2.DReadUserShop.Visible and (FrmDlg2.UserShopID = msg.Recog) then
            FrmDlg2.DReadUserShop.Visible := False;
        end;

        Actor.LoadShopTitle();
      end;
    end;
    SM_GETUSERSHOPLIST: ClientGetUserShopList(@Msg, body);

    SM_BUYUSERSHOP:
    begin
      g_MySelf.m_nGold := Msg.Recog;
      g_MySelf.m_nGameGold := Msg.Param;
      case Msg.Series of
        11: FrmDlg.DMessageDlg('[出售失败]: 对方已完成对该物品的收购.', []);
        12: FrmDlg.DMessageDlg('[出售失败]: 对方店铺的' + g_sGameGoldName + '不足.', []);
        13: FrmDlg.DMessageDlg('[出售失败]: 对方店铺的' + g_sGoldName + '不足.', []);
        14: FrmDlg.DMessageDlg('[出售失败]: 对方无法携带更多的物品.', []);
        15:
        begin
          if body <> '' then
          begin
            body := DecodeString(body);
            body := GetValidStr3(body, str, ['/']);
            n := StrToIntDef(str, 0);
            j := StrToIntDef(body, 0);
            if n in [Low(g_MyReadShopBuyItems)..High(g_MyReadShopBuyItems)] then
            begin
              if j > 0 then
              begin
                if (g_MyShopItem.Item.UserItem.Dura > j) then
                begin
                  Dec(g_MyShopItem.Item.UserItem.Dura, j);
                  AddItemBag(g_MyShopItem.Item, g_MyShopItem.Index2);
                end;
                if g_MyReadShopBuyItems[n].ShopItem.Item.UserItem.Dura > j then
                  Dec(g_MyReadShopBuyItems[n].ShopItem.Item.UserItem.Dura, j)
                else
                  SafeFillChar(g_MyReadShopBuyItems[n], SizeOf(g_MyReadShopBuyItems[n]), #0);
              end
              else begin
                if (sm_Superposition in g_MyReadShopBuyItems[n].ShopItem.Item.s.StdModeEx) and (g_MyReadShopBuyItems[n].ShopItem.Item.s.DuraMax > 1) then
                begin
                  if g_MyReadShopBuyItems[n].ShopItem.Item.UserItem.Dura > g_MyShopItem.Item.UserItem.Dura then
                    Dec(g_MyReadShopBuyItems[n].ShopItem.Item.UserItem.Dura, g_MyShopItem.Item.UserItem.Dura)
                  else
                    SafeFillChar(g_MyReadShopBuyItems[n], SizeOf(g_MyReadShopBuyItems[n]), #0);
                end
                else
                  SafeFillChar(g_MyReadShopBuyItems[n], SizeOf(g_MyReadShopBuyItems[n]), #0);
              end;

            end;
          end;
        end;
        1: FrmDlg.DMessageDlg('[购买失败]: 你所购买的物品已被其它人购买.', []);
        2: FrmDlg.DMessageDlg('[购买失败]: 你身上的' + g_sGameGoldName + '不够本次支付.', []);
        3: FrmDlg.DMessageDlg('[购买失败]: 你身上的' + g_sGoldName + '不够本次支付.', []);
        4: FrmDlg.DMessageDlg('[购买失败]: 你无法携带更多的物品.', []);
        5:
        begin
          for I := Low(g_MyReadShopSellItems) to High(g_MyReadShopSellItems) do
          begin
            if g_MyReadShopSellItems[i].ShopItem.Item.UserItem.MakeIndex = g_MyShopItem.Item.UserItem.MakeIndex then
            begin
              if body <> '' then
              begin
                body := DecodeString(body);
                body := GetValidStr3(body, str, ['/']);
                n := StrToIntDef(str, 0);
                j := StrToIntDef(body, 0);
                if (J > 0) then
                begin
                  Dec(g_MyReadShopSellItems[i].ShopItem.Item.UserItem.Dura, j);
                end;
                if (n > 0) and (J > 0) then
                begin
                  Item := g_MyShopItem;
                  Item.Item.UserItem.MakeIndex := n;
                  Item.Item.UserItem.Dura := j;
                  AddItemBag(Item.Item);
                end;
              end
              else begin
                SafeFillChar(g_MyReadShopSellItems[i], SizeOf(g_MyReadShopSellItems[i]), #0);
                AddItemBag(g_MyShopItem.Item);
              end;
              break;
            end;
          end;
        end;
      end;
      g_MyShopItem.Item.s.Name := '';
    end;

    SM_USERSHOPSAY:
    begin
      body := GetValidStr3(body, str, ['/']);
      FrmDlg2.AddShopMsg(FormatDateTime('[DD HH:MM:SS] ', Now) + DecodeString(str) + ': ' + DecodeString(body));
    end;



    SM_USERSHOPITEMCHANGE:
    begin
      if Msg.Series = 1 then
      begin
        for I := Low(g_MyShopSellItems) to High(g_MyShopSellItems) do
        begin
          if g_MyShopSellItems[i].ShopItem.Item.UserItem.MakeIndex = msg.Recog then
          begin
            FrmDlg2.AddShopMsg(FormatDateTime('[DD HH:MM:SS] ', Now) +
            DecodeString(body) + ' 向你购买了 ' + g_MyShopSellItems[i].ShopItem.Item.s.Name + ' 数量 ' +
            IntToStr(msg.tag));
            if Msg.Param > 0 then
            begin
              g_MyShopSellItems[i].ShopItem.Item.UserItem.Dura := Msg.Param;
            end
            else begin
              SafeFillChar(g_MyShopSellItems[i], SizeOf(g_MyShopSellItems[i]), #0);
            end;
            break;
          end;
        end;
      end
      else begin
        if msg.tag in [Low(g_MyShopBuyItems)..High(g_MyShopBuyItems)] then
        begin
          FrmDlg2.AddShopMsg(FormatDateTime('[DD HH:MM:SS] ', Now) +
          DecodeString(body) + ' 向你出售了 ' + g_MyShopBuyItems[msg.Tag].ShopItem.Item.s.Name + ' 数量 ' +
          IntToStr(msg.Recog));
          if Msg.Param > 0 then
          begin
            Item.Item.UserItem.Dura := g_MyShopBuyItems[msg.Tag].ShopItem.Item.UserItem.Dura - msg.Param;
            g_MyShopBuyItems[msg.Tag].ShopItem.Item.UserItem.Dura := Msg.Param;
          end
          else
            SafeFillChar(g_MyShopBuyItems[msg.Tag], SizeOf(g_MyShopBuyItems[msg.Tag]), #0);
        end;
      end;
    end;

    SM_USERSHOPCHANGE:
    begin
      if g_MySelf <> nil then
      begin
        g_MySelf.m_nGold := Msg.Recog;
        g_MySelf.m_nGameGold := Msg.Param;
        with FrmDlg2 do
        begin
          DUserShopOpen.Enabled := True;
          if Msg.Series > 0 then
          begin
            g_MySelf.m_boShop := True;
            g_MySelf.m_btShopIdx := LoByte(Msg.Series) - 1;
            g_MySelf.m_boShopLeft := HiByte(msg.Series) <> 0;
            FrmDlg2.DUserShopMemo.Lines.Clear;
            if g_MySelf.m_boShopLeft then
              g_MySelf.m_btDir := 1
            else
              g_MySelf.m_btDir := 5;
            g_MySelf.m_sShopTitle := g_MyShopTitle;
            DUserShopOpen.Caption := '停止摆摊';
            g_MySelf.LoadShopTitle();
          end
          else if Msg.Series = 0 then
          begin
            g_MyShopGold := 0;
            g_MyShopGameGold := 0;
            g_MySelf.m_boShop := False;
            DUserShopOpen.Caption := '开始摆摊';
            if not DWndUserShop.Visible then
              ClearShopSellItems;
            g_MySelf.LoadShopTitle();
          end;
        end;
      end;
    end;

    SM_USERSHOPGOLDCHANGE:
    begin
      g_MyShopGold := Msg.Recog;
      g_MyShopGameGold := Msg.Param;
    end;
      { SM_EXCHGTAKEON_OK: ;
     SM_EXCHGTAKEON_FAIL: ;   }

    SM_SENDUSEITEMS:
    begin
      ClientGetSenduseItems(body);
    end;
    SM_WEIGHTCHANGED:
    begin
      g_MySelf.m_Abil.Weight := Msg.Recog;
      g_MySelf.m_Abil.WearWeight := Msg.param;
      g_MySelf.m_Abil.HandWeight := Msg.tag;
    end;
    SM_GOLDCHANGED:
    begin
      SoundUtil.PlaySound(s_money);
      if Msg.Recog > g_MySelf.m_nGold then
      begin
        DScreen.AddSysMsg('获得 <CO$FFFF>' + g_sGoldName + ' ' +
        IntToStr(Msg.Recog - g_MySelf.m_nGold) + '<CE>', cllime);
      end;
      g_MySelf.m_nGold := Msg.Recog;
      //g_MySelf.m_nGameGold := MakeLong(Msg.param, Msg.tag);
      if Msg.param > g_nBindGold then
      begin
        DScreen.AddSysMsg('获得 <CO$FFFF>' + g_sBindGoldName + ' ' +
        IntToStr(Msg.param - g_nBindGold) + '<CE>', cllime);
      end;
      g_nBindGold := Msg.param;
    end;
    SM_GOLDPOINTCHANGED:
    begin
      SoundUtil.PlaySound(s_money);
      if Msg.Recog > g_MySelf.m_nGold then
      begin
        DScreen.AddSysMsg('获得 <CO$FFFF>' + g_sGoldName + ' ' + IntToStr(Msg.Recog - g_MySelf.m_nGold) + '<CE>', cllime);
      end;
      g_MySelf.m_nGold := Msg.Recog;
      g_MySelf.m_nGamePoint := Msg.param;
    end;
    SM_FEATURECHANGED:
    begin
      PlayScene.SendMsg(Msg.ident, Msg.Recog, 0, 0, 0, Msg.param, Msg.series, '', StrToIntDef(DecodeString(body), -1));
    end;
    SM_CHARSTATUSCHANGED:
    begin
      PlayScene.SendMsg(Msg.ident, Msg.Recog, 0, 0, 0, Msg.param, Msg.series, '');
    end;
    SM_EAT_OK:
    begin
      if Msg.Recog > 0 then
      begin
        if g_EatingItem.Item.S.StdMode = tm_Drug then
        begin
          g_dwEatTick := GetTickCount + LongWord(Msg.Recog);
        end;
      end;

      DelItemBagByIdxEx(g_EatingItem.Index2, g_EatingItem.Item.UserItem.wIndex, g_EatingItem.Item.UserItem.MakeIndex);
      g_EatingItem.Item.S.name := '';
      //ArrangeItembag;
      ArrangeItemBagEx();
      if g_sOpenItemName <> '' then
      begin
        EatItembyName(g_sOpenItemName);
      end;
      g_sOpenItemName := '';
    end;
    SM_EAT_FAIL:
    begin
      if msg.Recog = g_EatingItem.Item.UserItem.MakeIndex then
      begin
        g_EatingItem.Item.UserItem.Dura := msg.Param;
        g_EatingItem.Item.UserItem.DuraMax := msg.tag;
        UpdateItemBagByIdx(g_EatingItem.Index2, g_EatingItem.Item);
        //AddItemBag(g_EatingItem.Item, g_EatingItem.Index2);
        g_EatingItem.Item.S.name := '';
      end
      else begin
        g_EatingItem.Item.S.name := '';
        //DelItemBagByIdxEx(g_EatingItem.Index2, g_EatingItem.Item.UserItem.wIndex, g_EatingItem.Item.UserItem.MakeIndex);
      end;
      ArrangeItemBagEx();
      g_sOpenItemName := '';
    end;
    SM_CHANGEITEMDURA_FAIL:
    begin
      if Msg.Series <> 0 then
      begin
        if Msg.Param > 0 then
        begin
          g_UniteUseItem.Item.UserItem.Dura := Msg.Param;
          ClientGetBabDuraChange(Msg.Recog, Msg.tag, Msg.tag);
        end;
        AddItemBag(g_UniteUseItem.Item, g_UniteUseItem.Index2);
      end;
      g_UniteUseItem.Item.s.Name := '';
      ArrangeItemBagEx();
    end;
    SM_CHANGEITEMDURA_OK:
    begin
      if Msg.Series = 0 then
      begin
        ClientGetBabDuraChange(Msg.Recog, Msg.Param, Msg.tag);
        ClientGetAddItem(Msg, body);
      end
      else begin
        ClientGetBabDuraChange(Msg.Recog, Msg.Param, Msg.tag);
      end;
      g_UniteUseItem.Item.s.Name := '';
      ArrangeItemBagEx();
    end;

    SM_ADDMAGIC:
    begin
      if body <> '' then
        ClientGetAddMagic(body);
    end;
    SM_SENDMYMAGIC:
    begin
      if msg.Series = 1 then
      begin
        g_CboMagicID := Msg.Param;
        g_CboUserID := Msg.Recog;
        if g_CboMagicID in [114..121] then
          g_TargetCret := nil;
        if g_CboMagicID = 111 then
          TimerTestTimer(TimerTest);
      end
      else begin
        g_CboMagicList.nMagicList := Msg.Recog;
        if body <> '' then
          ClientGetMyMagics(body);
      end;
    end;

    SM_DELMAGIC:
    begin
      ClientGetDelMagic(Msg.Recog);
    end;
    SM_MAGIC_LVEXP:
    begin
      ClientGetMagicLvExp(Msg.Recog {magid}, Msg.param {lv}, Msg.tag);
    end;
    SM_DURACHANGE:
    begin
      ClientGetDuraChange(Msg.Series, Msg.Param, Msg.tag, Msg.Recog);
    end;
    SM_BAG_DURACHANGE:
    begin
      ClientGetBabDuraChange(Msg.Recog, Msg.Param, Msg.Tag);
    end;
    SM_BAG_DURACHANGE2:
    begin
      ClientGetBabDuraChange2(@Msg);
    end;
    SM_MERCHANTSAY:
    begin
      ClientGetMerchantSay(Msg.Recog, Msg.param, Msg.tag, Msg.Series, DecodeString(body));
    end;
    SM_MERCHANTDLGCLOSE:
    begin
      FrmDlg.CloseMDlg;
    end;
    SM_SENDGOODSLIST:
    begin
      ClientGetSendGoodsList(Msg.Recog, Msg.Param, Msg.tag, body);
    end;
    SM_COMPOUNDINFOS:
    begin
      ClientGetCompoundInfos(DecodeString(body));
    end;
    SM_ABILITYMOVESET:
    begin
      ClientGetAbilityMoveSet(DecodeString(body));
    end;
    SM_SENDUSERMAKEDRUGITEMLIST:
    begin
      ClientGetSendMakeDrugList(@Msg, body);
    end;

    SM_HINTDATA:
    begin
      ClientGetHintDataList(@Msg, body);
    end;
    SM_GETRETURNITEMS: ClientGetSendReturnItemList(body);
    SM_BUYRETURNITEM_OK:
    begin
      g_MySelf.m_nGold := Msg.Recog;
      g_nBindGold := Msg.Param;
      SoundUtil.PlaySound(s_money);
      if (msg.Series < FrmDlg.NpcReturnItemList.Count) then
      begin
        Dispose(pTNewClientItem(FrmDlg.NpcReturnItemList[msg.Series]));
        FrmDlg.NpcReturnItemList.Delete(msg.Series);
      end;
      AddItemBag(g_SellDlgItemSellWait.Item);
      g_SellDlgItemSellWait.Item.S.name := '';
    end;
    SM_BUYRETURNITEM_FAIL:
    begin
      g_SellDlgItemSellWait.Item.S.name := '';
      case msg.Series of
        1: FrmDlg.DMessageDlg('购买失败，你的' + g_sGoldname + '不足，无法完成支付.', []);
        2: FrmDlg.DMessageDlg('购买失败，你无法携带更多的物品.', []);
      end;
    end;
    SM_USERSELLITEM_OK:
    begin
      SoundUtil.PlaySound(s_money);
      FrmDlg.LastestClickTime := GetTickCount;
      g_MySelf.m_nGold := Msg.Recog;
      g_nBindGold := Msg.tag;
      new(pcu);
      pcu^ := g_SellDlgItemSellWait.Item;
      FrmDlg.NpcReturnItemList.Insert(0, pcu);
      if FrmDlg.NpcReturnItemList.Count > MAXRETURNITEMSCOUNT then
      begin
        Dispose(pTNewClientItem(FrmDlg.NpcReturnItemList[MAXRETURNITEMSCOUNT]));
        FrmDlg.NpcReturnItemList.Delete(MAXRETURNITEMSCOUNT);
      end;
      g_SellDlgItemSellWait.Item.S.name := '';
    end;

    SM_STATUSMODE:
    begin
      if Msg.Series in [Low(g_StatusInfoArr)..High(g_StatusInfoArr)] then
      begin
        g_StatusInfoArr[Msg.Series].dwTime := Msg.Recog * 1000;
        g_StatusInfoArr[Msg.Series].nPower := Msg.Param;
        if Msg.Recog > 0 then
        begin
          for I := 0 to g_StatusInfoList.Count - 1 do
          begin
            if Integer(g_StatusInfoList[I]) = Msg.Series then Exit;
          end;
          g_StatusInfoList.Add(Pointer(Msg.Series));
          TDButton(g_StatusInfoArr[Msg.Series].Button).Visible := True;
          FrmDlg.RefStatusInfoForm;
        end else begin
          for I := 0 to g_StatusInfoList.Count - 1 do
          begin
            if Integer(g_StatusInfoList[I]) = Msg.Series then
            begin
              TDButton(g_StatusInfoArr[Msg.Series].Button).Visible := False;
              g_StatusInfoList.Delete(I);
              FrmDlg.RefStatusInfoForm;
              Break;
            end;
          end;
        end;
      end;
    end;

    SM_USERSELLITEM_FAIL:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      AddItemBag(g_SellDlgItemSellWait.Item, g_SellDlgItemSellWait.Index2);
      g_SellDlgItemSellWait.Item.S.name := '';
      if msg.Recog = 1 then
        FrmDlg.DMessageDlg('[错误]：你无法携带更多的' + g_sGoldName + '.', [mbOk])
      else
        FrmDlg.DMessageDlg('[错误]：该物品不能出售.', [mbOk]);
    end;

      (*SM_SENDREPAIRCOST: begin
        if g_SellDlgItem.Item.S.name <> '' then begin
          if Msg.Recog >= 0 then
            g_sSellPriceStr := IntToStr(Msg.Recog) + ' ' + g_sGoldName {金币}
          else
            g_sSellPriceStr := '???? ' + g_sGoldName {金币};
        end;
      end;    *)
    SM_USERREPAIRITEM_OK:
    begin
      FrmDlg.CancelItemMoving;
      if g_SellDlgItemSellWait.Item.S.name <> '' then
      begin
        FrmDlg.LastestClickTime := GetTickCount;
        g_MySelf.m_nGold := Msg.Recog;
        g_SellDlgItemSellWait.Item.UserItem.Dura := Msg.Series;
        g_SellDlgItemSellWait.Item.UserItem.DuraMax := Msg.Series;
        g_nBindGold := Msg.Param;
        g_boItemMoving := True;
        g_MovingItem := g_SellDlgItemSellWait;
        FrmDlg.CancelItemMoving;
        //AddItemBag(g_SellDlgItemSellWait.Item, g_SellDlgItemSellWait.Index2);
        g_SellDlgItemSellWait.Item.S.name := '';
      end;
    end;
    SM_USERREPAIRITEM_FAIL:
    begin
      FrmDlg.CancelItemMoving;
      FrmDlg.LastestClickTime := GetTickCount;
      g_boItemMoving := True;
      g_MovingItem := g_SellDlgItemSellWait;
      FrmDlg.CancelItemMoving;
      //AddItemBag(g_SellDlgItemSellWait.Item, g_SellDlgItemSellWait.Index2);
      g_SellDlgItemSellWait.Item.S.name := '';
      if msg.Recog = 1 then
        FrmDlg.DMessageDlg('[错误]：该物品不能修理.', [mbOk])
      else
        FrmDlg.DMessageDlg('[错误]：你的' + g_sGoldName + '不够，无法进行修理.', [mbOk]);
    end;
    SM_STORAGE_OK:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      AddItemStorage(@g_SellDlgItemSellWait.Item, msg.Param, msg.tag);
      g_SellDlgItemSellWait.Item.S.name := '';
    end;
    SM_STORAGE_FAIL:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      AddItemBag(g_SellDlgItemSellWait.Item, g_SellDlgItemSellWait.Index2);
      g_SellDlgItemSellWait.Item.S.name := '';
    end;
    SM_SAVEITEMLIST:
    begin
      ClientGetSaveItemList(@Msg, body);
    end;
    SM_SENDINFO: ClientSendInfo(@Msg, body);
    SM_TAKEBACKSTORAGEITEM_OK:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      AddItemBag(g_SellDlgItemSellWait.Item);
      g_SellDlgItemSellWait.Item.S.name := '';
    end;
    SM_TAKEBACKSTORAGEITEM_FAIL:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      AddItemStorage(@g_SellDlgItemSellWait.Item, LoWord(g_SellDlgItemSellWait.Index2),
                      HiWord(g_SellDlgItemSellWait.Index2));
      g_SellDlgItemSellWait.Item.S.name := '';
    end;

    SM_BUYITEM_SUCCESS:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      g_MySelf.m_nGold := Msg.Recog;
      g_nBindGold := Msg.tag;
      g_SellDlgItemSellWait.Item.S.name := '';
    end;
    SM_BUYITEM_FAIL:
    begin
      g_SellDlgItemSellWait.Item.S.name := '';
      FrmDlg.LastestClickTime := GetTickCount;
      case Msg.Recog of
        1: FrmDlg.DMessageDlg('[错误]：此物品被卖出.', [mbOk]);
        2: FrmDlg.DMessageDlg('[错误]：您无法携带更多物品了.', [mbOk]);
        3: FrmDlg.DMessageDlg('[错误]：您没有足够的' + g_sGoldName + '来购买此物品.', [mbOk]);
        4: FrmDlg.DMessageDlg('[错误]：您没有足够的' + g_sBindGoldName + '来购买此物品.', [mbOk]);
        5: FrmDlg.DMessageDlg('[错误]：此物品没有足够库存了.', [mbOk]);
      end;
    end;
      {SM_MAKEDRUG_SUCCESS: begin
        FrmDlg.LastestClickTime := GetTickCount;
        g_MySelf.m_nGold := Msg.Recog;
        FrmDlg.DMessageDlg('物品成功打造', [mbOk]);
      end;
    SM_MAKEDRUG_FAIL: begin
        FrmDlg.LastestClickTime := GetTickCount;
        case msg.Recog of
          1: FrmDlg.DMessageDlg('发生了错误.', [mbOk]);
          2: FrmDlg.DMessageDlg('没有更多的物品可以携带了.',
              [mbOk]);
          3: FrmDlg.DMessageDlg(g_sGoldName  + '不足.', [mbOk]);
          4: FrmDlg.DMessageDlg('你缺乏所必需的物品。', [mbOk]);
        end;
      end; }
    SM_716:
    begin
      DrawEffectHum(Msg.series {type}, Msg.param {x}, Msg.tag {y}, Msg.Recog);
    end;
    SM_MONMAGIC:
    begin
      DrawMonMagic(@Msg, body);
      //DrawEffectHum(Msg.series {type}, Msg.param {x}, Msg.tag {y});
    end;
      {SM_SENDDETAILGOODSLIST: begin
        ClientGetSendDetailGoodsList(Msg.Recog, Msg.param, Msg.tag, body);
      end;   }
    SM_TEST:
    begin
      Inc(g_nTestReceiveCount);
    end;
    SM_CLIENTDATAFILE:
    begin
      ClientGetDataFile(Msg, body);
    end;
    SM_FILTERINFO:
    begin
      ClientFilterInfo(Msg, body);
    end;
    SM_SENDNOTICE:
    begin
      ClientGetSendNotice(body);
    end;
    SM_GROUPMODECHANGED:
    begin
      {if Msg.param > 0 then
          g_boAllowGroup := True
        else
          g_boAllowGroup := FALSE;

        if Msg.tag > 0 then
          g_boCheckGroup := True
        else
          g_boCheckGroup := FALSE; }
      g_nGameSetupData := LongWord(Msg.Recog);
      //g_boAllowGroup := not CheckIntStatus(g_nGameSetupData, GSP_NOTGROUP);
      //g_boCheckGroup := CheckIntStatus(g_nGameSetupData, GSP_GROUPCHECK);
      if body <> '' then
      begin
        DScreen.AddSysMsg(DecodeString (body), clWhite);
      end;
      g_dwChangeGroupModeTick := GetTickCount;
    end;
    SM_CREATEGROUP_OK:
    begin
      g_dwChangeGroupModeTick := GetTickCount;
      //g_boAllowGroup := True;
      SetIntStatus(g_nGameSetupData, GSP_NOTGROUP, False);
      {GroupMembers.Add (Myself.UserName);
        GroupMembers.Add (DecodeString(body));}
    end;
    SM_CREATEGROUP_FAIL:
    begin
      g_dwChangeGroupModeTick := GetTickCount;
      case Msg.Recog of
        1: FrmDlg.DMessageDlg('成功发送了组队邀请，请等待对方回应！', [mbOk]);
        2: FrmDlg.DMessageDlg('[失败]: 已经向该玩家发送了组队邀请，请不要重复发送！', [mbOk]);
        -1: FrmDlg.DMessageDlg('[失败]：你已经加入了队伍！', [mbOk]);
        -2: FrmDlg.DMessageDlg('[失败]：你想邀请的人物无法添加为队员！', [mbOk]);
        -3: FrmDlg.DMessageDlg('[失败]：您想邀请的人已经加入了其它队伍！', [mbOk]);
        -4: FrmDlg.DMessageDlg('[失败]：对方不允许编组！', [mbOk]);
      end;
    end;
    SM_GROUPADDMEM_OK:
    begin
      g_dwChangeGroupModeTick := GetTickCount;
      ClientGetAddMembers(@Msg, body);
      //GroupMembers.Add (DecodeString(body));
    end;
    SM_GROUPADDMEM_FAIL:
    begin
      g_dwChangeGroupModeTick := GetTickCount;
      case Msg.Recog of
        -1: FrmDlg.DMessageDlg('[操作失败]：你不是队长无法添加成员！', [mbOk]);
        -2: FrmDlg.DMessageDlg('[操作失败]：你想邀请的人物无法添加为队员！', [mbOk]);
        -3: FrmDlg.DMessageDlg('[操作失败]：您想邀请的人已经加入了其它队伍！', [mbOk]);
        -4: FrmDlg.DMessageDlg('[操作失败]：对方不允许编组！',
                                [mbOk]);
        -5: FrmDlg.DMessageDlg('[操作失败]：队伍成员已满！',
                                [mbOk]);
      end;
    end;
    SM_GROUPDELMEM_OK:
    begin
      g_dwChangeGroupModeTick := GetTickCount;
      ClientGetDelMembers(@Msg, body);
      //data := DecodeString (body);
      {for i:=0 to GroupMembers.Count-1 do begin
           if GroupMembers[i] = data then begin
              GroupMembers.Delete (i);
              break;
           end;
        end;   }
    end;
    SM_GROUPDELMEM_FAIL:
    begin
      g_dwChangeGroupModeTick := GetTickCount;
      case Msg.Recog of
        -1: FrmDlg.DMessageDlg('[操作失败]：你不是队长无法删除成员！', [mbOk]);
        -2: FrmDlg.DMessageDlg('[操作失败]：你想删除的人物不存在！', [mbOk]);
        -3: FrmDlg.DMessageDlg('[操作失败]：你想删除的人物不在队伍当中！', [mbOk]);
      end;
    end;
    SM_CHECKMSG:
    begin
      ClientGetCheckMsg(@Msg, DecodeString(body));
    end;
    SM_GROUPCANCEL:
    begin
      ClearGroupMember(True, Boolean(msg.Recog));
    end;
    SM_GROUPMEMBERS:
    begin
      //g_boAllowGroup := True;
      SetIntStatus(g_nGameSetupData, GSP_NOTGROUP, False);
      ClientGetGroupMembers(msg, DecodeString(body));
    end;

    SM_OPENGUILDDLG:
    begin
      g_dwQueryMsgTick := GetTickCount;
      ClientGetOpenGuildDlg(@Msg, body);
    end;

    SM_SENDGUILDMEMBERLIST:
    begin
      g_dwQueryMsgTick := GetTickCount;
      ClientGetSendGuildMemberList(@msg, body);
    end;

    SM_OPENGUILDDLG_FAIL:
    begin
      g_dwQueryMsgTick := GetTickCount;
      FrmDlg.DMessageDlg('[错误]：您还没有加入行会。', [mbOk]);
    end;

    SM_DEALTRY_FAIL:
    begin
      g_dwQueryMsgTick := GetTickCount;
      FrmDlg.DMessageDlg('[错误]：只有二人面对面才能进行交易。', [mbOk]);
    end;
    SM_DEALMENU:
    begin
      g_dwQueryMsgTick := GetTickCount;
      g_sDealWho := DecodeString(body);
      FrmDlg.OpenDealDlg;
    end;
    SM_DEALCANCEL:
    begin
      MoveDealItemToBag;
      if g_DealDlgItem.Item.S.name <> '' then
      begin
        AddItemBag(g_DealDlgItem.Item); //啊规俊 眠啊
        g_DealDlgItem.Item.S.name := '';
      end;
      if g_nDealGold > 0 then
      begin
        g_MySelf.m_nGold := g_MySelf.m_nGold + g_nDealGold;
        g_nDealGold := 0;
      end;
      FrmDlg.CloseDealDlg;
      ArrangeItemBagEx();
    end;
    SM_DEALADDITEM_OK:
    begin
      g_dwDealActionTick := GetTickCount;
      if g_DealDlgItem.Item.S.name <> '' then
      begin
        AddDealItem(g_DealDlgItem.Item); //Deal Dlg俊 眠啊
        g_DealDlgItem.Item.S.name := '';
      end;
      ArrangeItemBagEx();
    end;
    SM_DEALADDITEM_FAIL:
    begin
      g_dwDealActionTick := GetTickCount;
      if g_DealDlgItem.Item.S.name <> '' then
      begin
        AddItemBag(g_DealDlgItem.Item, g_DealDlgItem.Index2); //啊规俊 眠啊
        g_DealDlgItem.Item.S.name := '';
      end;
      ArrangeItemBagEx();
    end;
    SM_DEALDELITEM_OK:
    begin
      g_dwDealActionTick := GetTickCount;
      if g_DealDlgItem.Item.S.name <> '' then
      begin
        AddItemBag(g_DealDlgItem.Item); //啊规俊 眠啊
        g_DealDlgItem.Item.S.name := '';
      end;
      ArrangeItemBagEx();
    end;
    SM_DEALDELITEM_FAIL:
    begin
      g_dwDealActionTick := GetTickCount;
      if g_DealDlgItem.Item.S.name <> '' then
      begin
        AddDealItem(g_DealDlgItem.Item);
        g_DealDlgItem.Item.S.name := '';
      end;
      ArrangeItemBagEx();
    end;
    SM_DEALREMOTEADDITEM: ClientGetDealRemoteAddItem(body);
    SM_DEALREMOTEDELITEM: ClientGetDealRemoteDelItem(body);
    SM_DEALCHGGOLD_OK:
    begin
      g_nDealGold := Msg.Recog;
      g_MySelf.m_nGold := Msg.param;
      g_dwDealActionTick := GetTickCount;
    end;
    SM_DEALCHGGOLD_FAIL:
    begin
      g_nDealGold := Msg.Recog;
      g_MySelf.m_nGold := Msg.param;
      g_dwDealActionTick := GetTickCount;
    end;
    SM_DEALREMOTECHGGOLD:
    begin
      g_nDealRemoteGold := Msg.Recog;
      SoundUtil.PlaySound(s_money);
      //惑措规捞 捣阑 函版茄 版快 家府啊 抄促.
    end;
    SM_DEALSUCCESS:
    begin
      case Msg.Recog of
        1:
        begin
          FrmDlg.DDRDealLock.Checked := True;
          FrmDlg.DDealOk.Enabled := FrmDlg.DDRDealLock.Checked and g_boDealLock;
          DScreen.AddSysMsg('[对方已经锁定交易]', $32F4);
        end;
        2:
        begin
          FrmDlg.DDRDealOk.Checked := True;
          DScreen.AddSysMsg('[对方已确认交易]', $32F4);
        end;
      else
      begin
        FrmDlg.CloseDealDlg;
        DScreen.AddSysMsg('[交易完成]', $32F4);
      end;
      end;
    end;
      {SM_SENDUSERSTORAGEITEM: begin
        ClientGetSendUserStorage(Msg.Recog);
      end;  }
    SM_STORAGEGOLDCHANGE:
    begin
      g_nStorageGold := Msg.Recog;
      case msg.Param of
        1: FrmDlg.DMessageDlg('[错误]：仓库存款余额不足！', []);
        2: FrmDlg.DMessageDlg('[错误]：你无法携带更多的' + g_sGoldName + '！', []);
        3: FrmDlg.DMessageDlg('[错误]：你身上的' + g_sGoldName + '不足！', []);
        4: FrmDlg.DMessageDlg('[错误]：仓库的容量不足，无法存放！', []);
      end;
    end;
    SM_STORAGEINFO:
    begin
      g_nStorageGold := Msg.Recog;
      g_boStorageOpen[0] := True;
      g_boStorageOpen[1] := LoByte(LoWord(msg.Param)) = 1;
      g_boStorageOpen[2] := HiByte(LoWord(msg.Param)) = 1;
      g_boStorageOpen[3] := LoByte(HiWord(msg.Param)) = 1;
      g_boStorageOpen[4] := HiByte(HiWord(msg.Param)) = 1;
      if body <> '' then
        DecodeBuffer(body, @g_dwStorageTime[1], SizeOf(TDateTime) * 4);
      FrmDlg2.DStorageDlg.Visible := True;
      FrmDlg.LastestClickTime := GetTickCount;
    end;
    SM_GETBACKPASSWORD:
    begin
      if msg.Series = 1 then
      begin
        if mrYes = FrmDlg.DMessageDlg('请输入新密码！留空默认为取消密码', [mbYes, mbNo, mbAbort, mbIgnore],
                                       msg.Param, deNone) then
        begin
          body := Trim(FrmDlg.DlgEditText);
          if body <> '' then
          begin
            if mrYes = FrmDlg.DMessageDlg('请重复输入新密码！', [mbYes, mbNo, mbAbort, mbIgnore], msg.Param, deNone)
            then
            begin
              if Trim(FrmDlg.DlgEditText) = body then
              begin
                SendClientMessage(msg.Recog, msg.tag, 0, 0, 0, body);
              end
              else
                FrmDlg.DMessageDlg('两次输入的密码不一致！', []);
            end;
          end
          else begin
            if mrYes = FrmDlg.DMessageDlg('留空密码将默认为取消密码\是否确认取消密码？', [mbYes, mbNo])
            then
            begin
              SendClientMessage(msg.Recog, msg.tag, 0, 0, 0, '');
            end;
          end;
        end;
      end
      else begin
        if mrYes = FrmDlg.DMessageDlg(DecodeString(body), [mbYes, mbNo, mbAbort, mbIgnore], msg.Param, deNone) then
        begin
          body := Trim(FrmDlg.DlgEditText);
          if body <> '' then
          begin
            SendClientMessage(msg.Recog, msg.tag, 0, 0, 0, GetMD5Text(body + IntToStr(g_MySelf.m_nRecogId)))
          end;
        end;
      end;
      FrmDlg.LastestClickTime := GetTickCount;
    end;
      { SM_CHANGEGUILDNAME: begin
         ClientGetChangeGuildName(DecodeString(body));
       end; }
    SM_GUILDCHANGE:
    begin
      FrmDlg3.GuildChange(@msg, DecodeString(body));
    end;
    SM_SENDUSERSTATE:
    begin
      ClientGetSendUserState(@Msg, body);
    end;
    SM_GUILDADDMEMBER_OK:
    begin
      if g_MySelf <> nil then
      begin
        body := GetValidStrEx(DecodeString(body), str, ['/']);
        if (body <> '') and (str <> '') then
        begin
          FrmDlg3.AddGuildMember(Msg.Param, Msg.Recog, str, body);
        end;
      end;
    end;
    SM_GUILDADDMEMBER_FAIL:
    begin
      case Msg.Recog of
        -1: FrmDlg.DMessageDlg('成功发送了加入行会邀请，请等待对方回应！', [mbOk]);
        -2: FrmDlg.DMessageDlg('[失败]: 已经向该玩家发送了加入行会邀请，请不要重复发送！', [mbOk]);
        1: FrmDlg.DMessageDlg('[失败]: 你没有权利使用这个命令。', [mbOk]);
        2: FrmDlg.DMessageDlg('[失败]: 想加入进来的成员没有在线。', [mbOk]);
        3: FrmDlg.DMessageDlg('[失败]: 对方已经加入了其它行会。', [mbOk]);
        4: FrmDlg.DMessageDlg('[失败]: 对方拒绝加入行会。', [mbOk]);
        5: FrmDlg.DMessageDlg('[失败]: 行会成员数量已满。', [mbOk]);
          //4: FrmDlg.DMessageDlg('[失败]: 对方已经加入其他行会。', [mbOk]);
          //5: FrmDlg.DMessageDlg('对方不允许加入行会。', [mbOk]);
      end;
    end;
    SM_GUILDDELMEMBER_OK:
    begin
      if g_MySelf <> nil then
      begin
        FrmDlg3.DelGuildMember(DecodeString(body));
      end;
    end;
    SM_GUILDGOLDCHANGE_FAIL:
    begin
      g_ClientGuildInfo.nGuildMoney := Msg.Recog;
      case Msg.Series of
        1: FrmDlg.DMessageDlg('[提示信息] 不能使用此命令！', [mbOk]);
        2: FrmDlg.DMessageDlg('[提示信息] 你身上的' + g_sGoldName + '不够！', [mbOk]);
        3: FrmDlg.DMessageDlg('[提示信息] 行会资金不足！', [mbOk]);
        4: FrmDlg.DMessageDlg('[提示信息] 无法携带更金的' + g_sGoldName + '！', [mbOk]);
      end;
    end;
    SM_GUILDDELMEMBER_FAIL:
    begin
      case Msg.Recog of
        1: FrmDlg.DMessageDlg('[提示信息] 不能使用此命令！', [mbOk]);
        2: FrmDlg.DMessageDlg('[提示信息] 此人非本行会成员！', [mbOk]);
        3: FrmDlg.DMessageDlg('[提示信息] 行会掌门人不能开除自己！', [mbOk]);
        4: FrmDlg.DMessageDlg('[提示信息] 副掌人不能开除掌门人和副掌门人！', [mbOk]);
      end;
    end;
    SM_GUILDRANKUPDATE_FAIL:
    begin
      case Msg.Recog of
        -2: FrmDlg.DMessageDlg('[提示信息] 掌门人位置不能为空。', [mbOk]);
        -3: FrmDlg.DMessageDlg('[提示信息] 职位封号不能为空。', [mbOk]);
        -4: FrmDlg.DMessageDlg('[提示信息] 一个行会最多只能有一位掌门人。', [mbOk]);
        -5: FrmDlg.DMessageDlg('[提示信息] 掌门人位置不能为空。', [mbOk]);
        -6: FrmDlg.DMessageDlg('[提示信息] 不能添加成员/删除成员。', [mbOk]);
        -7: FrmDlg.DMessageDlg('[提示信息] 封号编号有重复号码。', [mbOk]);
        -8: FrmDlg.DMessageDlg('[提示信息] 封号中包含特殊字符。\' +
        '           只能使用 简体中文 和 中文特殊符号 。', [mbOk]);
        -9: FrmDlg.DMessageDlg('[提示信息] 一个行会最多只能有二位副掌门人。', [mbOk]);
        -10: FrmDlg.DMessageDlg('[提示信息] 一个行会最多只能有十位长老。', [mbOk]);
        -11: FrmDlg.DMessageDlg('[提示信息] 封号编号只能为1~99之间的数值。', [mbOk]);
      end;
      //FrmDlg.DGDEditGradeExitClick(FrmDlg.DGDEditGradeExit, 0, 0);
    end;
    SM_GUILDMAKEALLY_OK,
    SM_GUILDMAKEALLY_FAIL:
    begin
      case Msg.Recog of
        -1: FrmDlg.DMessageDlg('[提示信息] 双方掌门人必需面对面.', [mbOk]);
        -2: FrmDlg.DMessageDlg('[提示信息] 已经是敌对行会，无法结盟.', [mbOk]);
        -3: FrmDlg.DMessageDlg('[提示信息] 行会结盟必须双方掌门人面对面.', [mbOk]);
        -4: FrmDlg.DMessageDlg('[提示信息] 对方行会掌门人不允许结盟.', [mbOk]);
        -5: FrmDlg.DMessageDlg('[提示信息] 攻城战守城方和攻城方无法结盟.', [mbOk]);
      end;
    end;
    SM_GUILDBREAKALLY_OK,
    SM_GUILDBREAKALLY_FAIL:
    begin
      case Msg.Recog of
        -1: FrmDlg.DMessageDlg('[提示信息] 解除结盟！', [mbOk]);
        -2: FrmDlg.DMessageDlg('[提示信息] 此行会不是您行会的结盟行会！', [mbOk]);
        -3: FrmDlg.DMessageDlg('[提示信息] 没有此行会！', [mbOk]);
      end;
    end;
    SM_BUILDGUILD_OK:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      FrmDlg.DMessageDlg('[提示信息] 行会建立成功。', [mbOk]);
    end;
    SM_BUILDGUILD_FAIL:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      case Msg.Recog of
        -1: FrmDlg.DMessageDlg('[失败]: 您已经加入其它行会。', [mbOk]);
        -2: FrmDlg.DMessageDlg('[失败]: 缺少创建费用。', [mbOk]);
        -3: FrmDlg.DMessageDlg('[失败]: 你没有准备好需要的全部物品。', [mbOk]);
        -4: FrmDlg.DMessageDlg('[失败]: 行会名称包含非法字符。\' +
        '        只能使用 简体中文 和 中文特殊符号。', []);
        -5: FrmDlg.DMessageDlg('[失败]: 行会名称长度为3-7个汉字。', [mbOk]);
        -6: FrmDlg.DMessageDlg('[失败]: 创建失败，行会名称已经存在。', [mbOk]);
        -7: FrmDlg.DMessageDlg('[失败]: 行会名称包含禁止使用的字符！', [mbOk]);
      else
        FrmDlg.DMessageDlg('[提示信息] 创建行会失败...', [mbOk]);
      end;
    end;
    SM_MENU_OK:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
      if body <> '' then
        FrmDlg.DMessageDlg(DecodeString(body), [mbOk]);
    end;
    SM_UPLOADUSERPHOTO_FAIL:
    begin
      FrmDlg2.DUpLoadOk.Enabled := True;
      FrmDlg2.DUpLoadOk.Caption := '确认上传';
      FrmDlg.DStateInfoUpLoadPic.Enabled := True;
      FrmDlg.DMessageDlg(DecodeString(body), []);
    end;
    SM_UPLOADUSERPHOTO:
    begin
      case Msg.Series of
        0:
        begin
          FrmDlg2.DWinUpLoad.Visible := True;
          FrmDlg2.DUpLoadOk.Enabled := True;
          FrmDlg2.DUpLoadOk.Caption := '确认上传';
          FrmDlg.DStateInfoUpLoadPic.Enabled := True;
        end;
        1:
        begin
          FrmDlg2.DUpLoadOk.Caption := '确认上传';
          FrmDlg2.DUpLoadOk.Enabled := True;
          g_UserRealityInfo.sPhotoID := DecodeString(body);
          FrmDlg.DStateInfoUpLoadPic.Enabled := False;
          if FrmDLg2.HDSaveJpeg <> nil then
          begin
            FrmDlg2.HDSaveJpeg.SaveToFile(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg');
            FrmDlg2.HDSaveJpeg.Free;
            FrmDlg2.HDSaveJpeg := nil;
            FrmDlg.RefPhotoSurface(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg', FrmDlg.MyHDInfoSurface);
          end;
          FrmDlg2.DWinUpLoad.Visible := False;
          FrmDlg.DMessageDlg('照片上传成功', []);
        end;
        2:
        begin
          if (Length(body) = GetCodeMsgSize(MSg.Recog * 4 / 3)) and (g_UserRealityInfo.sPhotoID <> '') then
          begin
            GetMem(Buffer, Msg.Recog);
            Stream := TFileStream.Create(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg', fmCreate);
            try
              DecodeBuffer(Body, Buffer, Msg.Recog);
              Stream.Write(Buffer^, Msg.Recog);
            finally
              Stream.Free;
              FreeMem(Buffer);
            end;
            FrmDlg.RefPhotoSurface(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg', FrmDlg.MyHDInfoSurface);
          end;
        end;
        3:
        begin
          if (Length(body) = GetCodeMsgSize(MSg.Recog * 4 / 3)) and
          (Length(FrmDlg.UserState1.RealityInfo.sPhotoID) = (SizeOf(FrmDlg.UserState1.RealityInfo.sPhotoID) - 1)) then
          begin
            GetMem(Buffer, Msg.Recog);
            Stream := TFileStream.Create(g_sPhotoDirname + FrmDlg.UserState1.RealityInfo.sPhotoID + '.jpg',
                                          fmCreate);
            try
              DecodeBuffer(Body, Buffer, Msg.Recog);
              Stream.Write(Buffer^, Msg.Recog);
            finally
              Stream.Free;
              FreeMem(Buffer);
            end;
            FrmDlg.RefPhotoSurface(g_sPhotoDirname + FrmDlg.UserState1.RealityInfo.sPhotoID + '.jpg',
                                    FrmDlg.UserHDInfoSurface);
          end;
        end;
      end;

    end;
    SM_DLGMSG:
    begin
      if body <> '' then
        FrmDlg.DMessageDlg(DecodeString(body), [mbOk]);
    end;
    SM_DONATE_OK:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
    end;
    SM_DONATE_FAIL:
    begin
      FrmDlg.LastestClickTime := GetTickCount;
    end;

    SM_PLAYDICE:
    begin
      body2 := Copy(body, GetCodeMsgSize(sizeof(TMessageBodyWL) * 4 / 3) + 1, Length(body));
      DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
      data := DecodeString(body2);
      FrmDlg.m_nDiceCount := Msg.param; //QuestActionInfo.nParam1
      FrmDlg.m_Dice[0].nDicePoint := Lobyte(Loword(wl.lParam1));
      //UserHuman.m_DyVal[0]                                      人个八
      FrmDlg.m_Dice[1].nDicePoint := Hibyte(Loword(wl.lParam1));
      //UserHuman.m_DyVal[0]
      FrmDlg.m_Dice[2].nDicePoint := Lobyte(Hiword(wl.lParam1));
      //UserHuman.m_DyVal[0]
      FrmDlg.m_Dice[3].nDicePoint := Hibyte(Hiword(wl.lParam1));
      //UserHuman.m_DyVal[0]

      FrmDlg.m_Dice[4].nDicePoint := Lobyte(Loword(wl.lParam2));
      //UserHuman.m_DyVal[0]
      FrmDlg.m_Dice[5].nDicePoint := Hibyte(Loword(wl.lParam2));
      //UserHuman.m_DyVal[0]
      FrmDlg.m_Dice[6].nDicePoint := Lobyte(Hiword(wl.lParam2));
      //UserHuman.m_DyVal[0]
      FrmDlg.m_Dice[7].nDicePoint := Hibyte(Hiword(wl.lParam2));
      //UserHuman.m_DyVal[0]

      FrmDlg.m_Dice[8].nDicePoint := Lobyte(Loword(wl.lTag1));
      //UserHuman.m_DyVal[0]
      FrmDlg.m_Dice[9].nDicePoint := Hibyte(Loword(wl.lTag1));
      //UserHuman.m_DyVal[0]
      if FrmDlg.m_nDiceCount in [1..3] then
        FrmDlg.DMessageDlg('', [mbHelp]);
      FrmDlg.m_nDiceCount := 0;
      SendMerchantDlgSelect(Msg.Recog, data);
    end;
    SM_NEEDPASSWORD:
    begin
      ClientGetNeedPassword(body);
    end;
    SM_PASSWORDSTATUS:
    begin
      ClientGetPasswordStatus(@Msg, body);
    end;
    SM_TOPMSG:
    begin
      body := DecodeString(body);
      body := AnsiReplaceText(body, '#6', #6);
      body := AnsiReplaceText(body, '#5', #5);
      FrmDlg4.m_TopMsgList.AddObject(body, nil);
      FrmDlg4.DTopMsg.Visible := True;
    end;
    SM_CENTERMSG: ClientGetCenterMsg(@Msg, body);
    SM_CLEARCENTERMSG: ClientGetClearCenterMsg(@Msg, DeCodeString(body));
    SM_GETREGINFO: ClientGetRegInfo(@Msg, body);
    SM_GETSHOPLIST: ClientGetShopItems(@msg, body);
    SM_CLIENTBUYITEM:
    begin
      case Msg.Recog of
        1: FrmDlg.DMessageDlg('购买成功，请到背包查收。', [mbOk]);
        2: FrmDlg.DMessageDlg('赠送成功。', [mbOk]);
        -1: FrmDlg.DMessageDlg('您所购买的物品不存在，请重新选择。', [mbOk]);
        -2: FrmDlg.DMessageDlg('你的' + g_sGamePointName + '数量不够本次支付。', [mbOk]);
        -3: FrmDlg.DMessageDlg('你的背包空间不足，购买失败。', [mbOk]);
        -4: FrmDlg.DMessageDlg('赠送失败，你所赠送的对像不在线。', [mbOk]);
        -5: FrmDlg.DMessageDlg('赠送失败，你所赠送的对像背包空间不够。', [mbOk]);
        -6:
        begin
          i := Msg.Param;
          FrmDlg.DMessageDlg(Format('[对换成功]: 获得%d%s和%d%s', [i, g_sGameGoldName, i, g_sGameDiamondName]),
                              [mbOK]);
        end;
        -7: FrmDlg.DMessageDlg('你的' + g_sGameGoldName + '数量不够本次支付。', [mbOk]);
        -8: FrmDlg.DMessageDlg('你的' + g_sGoldName + '数量不够本次支付。', [mbOk]);
        -20: FrmDlg.DMessageDlg('系统错误，请稍候再试。。。', [mbOk]);
      else
        FrmDlg.DMessageDlg('获取物品信息失败。', [mbOk]);
      end;
    end;
    SM_CLIENTBUYSHOPITEM:
    begin
      case Msg.Recog of
        1:
        begin
          FrmDlg.DMessageDlg('购买成功，请到背包查收。', [mbOk]);
          if g_ShopBuyItem <> nil then
            g_ShopBuyItem.ClientShopItem.nCount := Msg.Series;
        end;
        -1: FrmDlg.DMessageDlg('[失败]：您所购买的物品不存在，请重新选择。', [mbOk]);
        -2: FrmDlg.DMessageDlg('[失败]：您所购买的物品没有库存了。', [mbOk]);
        -3: FrmDlg.DMessageDlg('[失败]：您的背包空间不足。', [mbOk]);
        -4: FrmDlg.DMessageDlg('[失败]：您的' + g_sGameGoldName + '数量不够本次支付。', [mbOk]);
        -5: FrmDlg.DMessageDlg('[失败]：您的' + g_sGamePointName + '数量不够本次支付。', [mbOk]);
        -6: FrmDlg.DMessageDlg('[失败]：您有未处理消息，请稍候再购买。', [mbOk]);
        -7: FrmDlg.DMessageDlg('[失败]：系统发生错误，请稍候再购买。', [mbOk]);
        -8: FrmDlg.DMessageDlg('[失败]：您的' + g_sGoldName + '数量不够本次支付。', [mbOk]);
        -9: FrmDlg.DMessageDlg('[失败]：该物品无法使用' + g_sGoldName + '购买。', [mbOk]);
      end;
      g_ShopBuyItem := nil;
    end;
    SM_OPENBOX:
    begin
      ClientOpenBox(@Msg, Body);
    end;
    SM_OPENBOXINFO:
    begin
      FrmDlg3.OpenGetItem := False;
      case Msg.Series of
        1:
        begin
          FrmDlg3.OpenBox(Msg.Param, Msg.tag);
        end;
        2:
        begin
          FrmDlg3.OpenGetItem := True;
          FrmDlg3.OpenBoxGold := Msg.Recog;
          FrmDlg3.OpenBoxGameGold := Msg.Param;
          FrmDlg3.OpenBoxShowEffect := True;
          FrmDlg3.OpenBoxEffectIdx := 0;
          FrmDlg3.OpenBoxEffectTick := GetTickCount + 150;
          FrmDlg3.OpenBoxItems[FrmDlg3.OpenGetItemIndex].ItemType := bit_None;
          //FrmDlg3.OpenGetItemIndex := 0;
          //FrmDlg3.dbtnBoxNext.Caption := '继续转动轮盘';
        end;
        3: FrmDlg3.dwndBox.Visible := False;
        1000:
        begin
          FrmDlg.DMessageDlg('[失败]：系统错误！', [mbOk]);
          FrmDlg3.dwndBox.Visible := False;
        end;
        1001:
        begin
          FrmDlg.DMessageDlg('[失败]：对不起，您身上的' + g_sGoldName + '或者' + g_sGameGoldName + '不足！', [mbOk]);
          FrmDlg3.OpenBoxStop := False;
        end;
        1002:
        begin
          FrmDlg.DMessageDlg('[失败]：领取失败，背包空间不足！', [mbOk]);
        end;
      end;
    end;
    SM_TAXISLIST:
    begin
      ClientGetTaxisList(Msg.Recog, msg.Param, Msg.Tag, msg.Series, Body);
    end;
    SM_TAXISLIST_FAIL:
    begin
      FrmDlg.DMessageDlg('您没有上榜', [mbOK]);
    end;
    SM_GAMESETUPINFO:
    begin
      GetGameSetupInfo(@Msg, Body);
    end;
    SM_MAKEITEM:
    begin
      //frmdlg2.MakeItemBack(@msg, body);
    end;
    SM_OPENURL:
    begin
      FrmWEB.wb.UISettings.EnableScrollBars := True;
      FrmDlg2.OpenWeb(DecodeString(body), Msg.Param, Msg.tag);

    end;
    SM_REFICONINFO:
    begin
      ClientGetSetIcon(@Msg, DeCodeString(body));
    end;
    SM_REFHUMLOOK:
    begin
      ClientGetHumLook(@Msg);
    end;
  else
  begin
    if g_MySelf = nil then
      Exit; //Jacky 在未进入游戏时不处理下面
    //Jacky
    //            DScreen.AddSysMsg (IntToStr(msg.Ident) + ' : ' + body);
    PlayScene.MemoLog.Lines.Add('Ident: ' + IntToStr(Msg.ident));
    PlayScene.MemoLog.Lines.Add('Recog: ' + IntToStr(Msg.Recog));
    PlayScene.MemoLog.Lines.Add('Param: ' + IntToStr(Msg.param));
    PlayScene.MemoLog.Lines.Add('Tag: ' + IntToStr(Msg.tag));
    PlayScene.MemoLog.Lines.Add('Series: ' + IntToStr(Msg.series));
  end;
  end;

  if pos(g_CodeHead, datablock) > 0 then
    DScreen.AddSysMsg(datablock, clGreen);
end

;

procedure TfrmMain.DisplayChange(boReset: Boolean);
var
  nWidth, nHeight: Integer;
begin
  if boReset then
  begin
    if FboDisplayChange then
    begin
      FormStyle := fsNormal;
      FIDDraw := nil;
      if FDDrawHandle > 0 then
        FreeLibrary(FDDrawHandle);
      FDDrawHandle := 0;
      FboDisplayChange := False;
      UnRegisterHotKey(Handle, FHotKeyId);
    end;
  end else begin
    if not FboDisplayChange then
    begin
      FormStyle := fsStayOnTop;
      if HGE.System_GetState(HGE_FScreenWidth) = OLD_SCREEN_WIDTH then
      begin
        nWidth := OLD_SCREEN_WIDTH;
        nHeight := OLD_SCREEN_HEIGHT;
      end
      else begin
        nWidth := DEF_SCREEN_WIDTH;
        nHeight := DEF_SCREEN_HEIGHT;
      end;

      FIDDraw := nil;
      if FDDrawHandle > 0 then
        FreeLibrary(FDDrawHandle);
      FDDrawHandle := LoadLibrary('DDraw.dll');

      if DD_OK = TDirectDrawCreate(GetProcAddress(FDDrawHandle, 'DirectDrawCreate'))(nil, FIDDraw, nil) then
      begin
        if DD_OK = FIDDraw.SetDisplayMode(nWidth, nHeight, 16) then
        begin
          FboDisplayChange := True;
          FHotKeyId := GlobalAddAtom('361ClientKey') - $C000;
          RegisterHotKey(Handle, FHotKeyId, MOD_ALT, VK_TAB);
        end;
      end;
    end;
  end;
end

;

procedure TfrmMain.ClientGetPasswdSuccess(body: string);
var
  str, runaddr, runport, certifystr: string;
begin
  str := DecodeString(body);
  str := GetValidStr3(str, runaddr, ['/']);
  str := GetValidStr3(str, runport, ['/']);
  str := GetValidStr3(str, certifystr, ['/']);
  Certification := StrToIntDef(certifystr, 0);
  FrmDlg.sHintStr := '正在连接角色服务器。。。';
  boSocketClose := True;
  CSocket.Active := FALSE;
  CSocket.Host := '';
  CSocket.Port := 0;
  //FrmDlg.DSelServerDlg.Visible := FALSE;
  WaitAndPass(500); //0.5檬悼救 扁促覆
  g_ConnectionStep := cnsSelChr;
  with CSocket do
  begin
    g_sSelChrAddr := runaddr;
    g_nSelChrPort := StrToIntDef(runport, 0);
    Address := g_sSelChrAddr;
    Port := g_nSelChrPort;
    Active := True;
  end;

  boSocketClose := False;
end

;
(*
procedure TfrmMain.ClientGetPasswordOK(Msg: TDefaultMessage;
  sBody: string);
var
  i: Integer;
  sServerName: string;
  sServerStatus: string;
  nCount: Integer;
begin
  sBody := DecodeString(sBody);
  //  FrmDlg.DMessageDlg (sBody + '/' + IntToStr(Msg.Series), [mbOk]);
  nCount := _MIN(6, Msg.series);
  g_ServerList.Clear;
  for i := 0 to nCount - 1 do begin
    sBody := GetValidStr3(sBody, sServerName, ['/']);
    sBody := GetValidStr3(sBody, sServerStatus, ['/']);
    //g_ServerList.AddObject(sServerName, TObject(StrToIntDef(sServerStatus, 0)));
  end;
  //if g_ServerList.Count = 0 then begin
//    g_ServerList.InsertObject(0,'九月传奇',TObject(StrToIntDef(sServerStatus,0)));
//  end;

  g_wAvailIDDay := Loword(Msg.Recog);
  g_wAvailIDHour := Hiword(Msg.Recog);
  g_wAvailIPDay := Msg.param;
  g_wAvailIPHour := Msg.tag;

  if g_wAvailIDDay > 0 then begin
    if g_wAvailIDDay = 1 then
      FrmDlg.DMessageDlg('您当前ID费用到今天为止。', [mbOk])
    else if g_wAvailIDDay <= 3 then
      FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIDDay) +
        ' 天。', [mbOk]);
  end
  else if g_wAvailIPDay > 0 then begin
    if g_wAvailIPDay = 1 then
      FrmDlg.DMessageDlg('您当前IP费用到今天为止。', [mbOk])
    else if g_wAvailIPDay <= 3 then
      FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIPDay) +
        ' 天。', [mbOk]);
  end
  else if g_wAvailIPHour > 0 then begin
    if g_wAvailIPHour <= 100 then
      FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIPHour) +
        ' 小时。', [mbOk]);
  end
  else if g_wAvailIDHour > 0 then begin
    FrmDlg.DMessageDlg('您当前ID费用还剩 ' + IntToStr(g_wAvailIDHour) +
      ' 小时。', [mbOk]);
    ;
  end;

  //if not LoginScene.m_boUpdateAccountMode then
  ClientGetSelectServer;
end;

procedure TfrmMain.ClientGetSelectServer;
//var
//  sname: string;
begin
  LoginScene.HideLoginBox;
  if g_ServerList.Count = 1 then begin
    //g_sServerMiniName := g_ServerList[0];
    SendSelectServer(g_sServerMiniName);
    g_sServerName := g_sServerMiniName;
  end
  else
    FrmDlg.ShowSelectServerDlg;
end;   *)

procedure TfrmMain.ClientGetReceiveChrs(body: string);
var
  i, select: Integer;
  //OldDateTime, tTime: TDateTime;
  str, sID, uname, sjob, swuxin, slevel, ssex: string;
begin
  SelectChrScene.ClearChrs;
  str := DecodeString(body);
  select := 0;
  //OldDateTime := 0;
  for i := 0 to 2 do
  begin
    str := GetValidStr3(str, uname, ['/']);
    str := GetValidStr3(str, sjob, ['/']);
    str := GetValidStr3(str, swuxin, ['/']);
    str := GetValidStr3(str, slevel, ['/']);
    str := GetValidStr3(str, ssex, ['/']);

    if (uname <> '') and (slevel <> '') and (ssex <> '') then
    begin
      if uname[1] = '*' then
      begin
        select := i;
        uname := Copy(uname, 2, Length(uname) - 1);
      end;
      SelectChrScene.AddChr(uname, StrToIntDef(sID, 0), StrToIntDef(sjob, 0), StrToIntDef(swuxin, 0),
                             StrToIntDef(slevel, 0), StrToIntDef(ssex, 0), now);
    end;
    {str := GetValidStr3(str, sID, ['/']);
    str := GetValidStr3(str, uname, ['/']);
    str := GetValidStr3(str, sjob, ['/']);
    str := GetValidStr3(str, ssex, ['/']);
    str := GetValidStr3(str, slevel, ['/']);
    str := GetValidStr3(str, swuxin, ['/']);
    str := GetValidStr3(str, stime, ['/']);
    if (uname <> '') and (slevel <> '') and (ssex <> '') and (stime <> '') then begin
      tTime := StrToDateTimeDef(stime, now);
      if tTime > OldDateTime then begin
        select := i;
        OldDateTime := tTime;
      end;
      SelectChrScene.AddChr(uname, StrToIntDef(sID, 0), StrToIntDef(sjob, 0), StrToIntDef(swuxin, 0),
        StrToIntDef(slevel, 0), StrToIntDef(ssex, 0), tTime);
    end;  }
  end;
  with SelectChrScene do
  begin
    if select = 0 then
    begin
      ChrArr[0].FreezeState := FALSE;
      ChrArr[0].Selected := True;
      ChrArr[1].FreezeState := True;
      ChrArr[1].Selected := FALSE;
      ChrArr[2].FreezeState := True;
      ChrArr[2].Selected := FALSE;
    end
    else if select = 1 then
    begin
      ChrArr[0].FreezeState := True;
      ChrArr[0].Selected := FALSE;
      ChrArr[1].FreezeState := FALSE;
      ChrArr[1].Selected := True;
      ChrArr[2].FreezeState := True;
      ChrArr[2].Selected := FALSE;
    end
    else begin
      ChrArr[0].FreezeState := True;
      ChrArr[0].Selected := FALSE;
      ChrArr[1].FreezeState := True;
      ChrArr[1].Selected := FALSE;
      ChrArr[2].FreezeState := FALSE;
      ChrArr[2].Selected := True;
    end;
  end;
  if boOpenLoginDoor then
  begin
    LoginScene.OpenLoginDoor;
    boOpenLoginDoor := False;
  end
  else begin
    DScreen.ChangeScene(stSelectChr);
  end;
end

;

procedure TfrmMain.ClientGetStartPlay(body: string);
var
  str, sport: string;
begin
  str := DecodeString(body);
  sport := GetValidStr3(str, g_sRunServerAddr, ['/']);
  g_nRunServerPort := StrToIntDef(sport, 0);
  boSocketClose := True;
  CSocket.Active := FALSE; //肺弊牢俊 楷搬等 家南 摧澜
  CSocket.Host := '';
  CSocket.Port := 0;
  WaitAndPass(500); //0.5檬悼救 扁促覆

  g_ConnectionStep := cnsPlay;

  with CSocket do
  begin
    Address := g_sRunServerAddr;
    Port := g_nRunServerPort;
    Active := True;
  end;
  boSocketClose := False;
end

;

procedure TfrmMain.ClientGetTaxisList(nIdx, nNowPage, nMaxPage, nClickIdx: integer;
body: string);
begin

end

;

procedure TfrmMain.ClientGetReconnect(body: string);
var
  str, addr, sport: string;
begin
  str := DecodeString(body);
  sport := GetValidStr3(str, addr, ['/']);
  SaveIDInfo();
  SaveHumInfo(CharName);

  g_boServerChanging := True;
  CSocket.Active := FALSE; //肺弊牢俊 楷搬等 家南 摧澜
  CSocket.Host := '';
  CSocket.Port := 0;

  WaitAndPass(500); //0.5檬悼救 扁促覆

  g_ConnectionStep := cnsPlay;
  with CSocket do
  begin
    Address := addr;
    Port := StrToIntDef(sport, 0);
    Active := True;
  end;
end

;

procedure TfrmMain.ClientGetMapDescription(Msg: TDefaultMessage; sBody: string);
var
  sTitle: string;
  List: TList;
  i: integer;
  MapEffect: pTClientMapEffect;
  event: TShopClEvent;
begin
  GetValidStr3(DecodeString(sBody), sTitle, [#13]);
  g_sMapTitle := sTitle;
  g_MapDesc := GetMapDescList(sTitle);
  g_nMapMusic := Msg.Recog;
  List := GetMapEffectList(sTitle);
  if List <> nil then
  begin
    for I := 0 to List.Count - 1 do
    begin
      MapEffect := List[i];
      event := TShopClEvent.Create(Integer(MapEffect), MapEffect.wX, MapEffect.wY, MapEffect.btType, MapEffect.sName);
      event.m_nDir := 0;
      event.m_boClient := True;
      event.m_dwFrameTick := 100;
      EventMan.AddEvent(event); //clvent啊 Free瞪 荐 乐澜
    end;
  end;
  PlayMapMusic(True);
  if g_boNpcMoveing and (g_nScriptGotoStr <> '') then
    ScriptGoto(g_nScriptGotoStr);
end

;

procedure TfrmMain.ClientGetMissionInfo(Msg: TDefaultMessage; sBody: string);
var
  i, nIdx: Integer;
  ClientMissionInfo: pTClientMissionInfo;
  MissionInfo: TMissionInfo;
  sIdx, sMission, sMasterName, sName: string;
  ClientMission, OldClientMission: pTClientMission;
  DTreeNodes, DTreeNodes2: pTDTreeNodes;
  OldCount: Integer;

begin
  case Msg.Series of
    MISSTAG_FLAGLIST:
    begin
      DecodeBuffer(sBody, @g_MissionFlag[0], SizeOf(g_MissionFlag));
    end;
    MISSTAG_ARITHMOMETERLIST:
    begin
      DecodeBuffer(sBody, @g_MissionArithmometer[0], SizeOf(g_MissionArithmometer));
      if Msg.tag <> 0 then
        PlayScene.RefMissionInfo;
    end;
    MISSTAG_MISSIONLIST:
    begin
      ClearMissionInfoList();
      FrmDlg3.InitializeMissionTree;
      while True do
      begin
        if sBody = '' then break;
        sBody := GetValidStr3(sBody, sIdx, ['/']);
        sBody := GetValidStr3(sBody, sMission, ['/']);
        nIdx := StrToIntDef(sIdx, -1);
        if (nIdx in [Low(TMissionInfos)..High(TMissionInfos)]) and (sMission <> '') then
        begin
          SafeFillChar(MissionInfo, SizeOf(MissionInfo), #0);
          DecodeBuffer(sMission, @MissionInfo, SizeOf(MissionInfo));
          ClientMission := GetMissionInfo(MissionInfo.sMissionName);
          if ClientMission <> nil then
          begin
            New(ClientMissionInfo);
            SafeFillChar(ClientMissionInfo^, SizeOf(TClientMissionInfo), #0);
            ClientMissionInfo.MissionIdx := nIdx;
            ClientMissionInfo.MissionInfo := MissionInfo;
            ClientMissionInfo.ClientMission := ClientMission;
            ClientMissionInfo.DTreeNodes := nil;
            ClientMission.MissionInfo := ClientMissionInfo;
            g_MissionInfoList.Add(ClientMissionInfo);
            if not ClientMission.boHide then
            begin
              sMasterName := ClientMission.sMissionMaster;
              DTreeNodes := nil;
              while True do
              begin
                sMasterName := GetValidStr3(sMasterName, sName, ['/', '\', '|']);
                if sName = '' then break;
                DTreeNodes := FrmDlg3.DTrvwMission.GetTreeNodes(DTreeNodes, sName, True);
              end;
              if DTreeNodes <> nil then
              begin
                DTreeNodes2 := FrmDlg3.DTrvwMission.NewTreeNodes(ClientMission.sMissionShowName);
                DTreeNodes2.Item := ClientMissionInfo;
                DTreeNodes.ItemList.Add(DTreeNodes2);
                ClientMissionInfo.DTreeNodes := DTreeNodes2;
                if FrmDlg3.DTrvwMission.Select = nil then
                begin
                  FrmDlg3.DTrvwMissionTreeViewSelect(FrmDlg3.DTrvwMission, DTreeNodes2);
                  FrmDlg3.DTrvwMission.Select := DTreeNodes2;
                end;
              end;
            end;
          end;
        end;
      end;
      FrmDlg3.DTrvwMission.RefHeight;
      PlayScene.RefMissionList;
      PlayScene.RefMissionInfo;
      FrmDlg2.m_boShowMissionChange := True;
      //刷新任务
    end;
    MISSTAG_FLAGCHANGE:
    begin
      if (Msg.Recog >= Low(g_MissionFlag)) and (Msg.Recog <= High(g_MissionFlag)) then
      begin
        g_MissionFlag[Msg.Recog] := Msg.Param;
        PlayScene.RefMissionInfo;
        FrmDlg3.MDlgChange := True;
        FrmDlg2.m_boShowMissionChange := True;
      end;
    end;
    MISSTAG_ADDMISSION:
    begin
      sMission := DecodeString(sBody);
      if (Msg.Recog in [Low(TMissionInfos)..High(TMissionInfos)]) and (sMission <> '') then
      begin
        SafeFillChar(MissionInfo, SizeOf(MissionInfo), #0);
        MissionInfo.wTime := Msg.tag;
        MissionInfo.sMissionName := sMission;
        ClientMission := GetMissionInfo(sMission);
        if ClientMission <> nil then
        begin
          New(ClientMissionInfo);
          SafeFillChar(ClientMissionInfo^, SizeOf(TClientMissionInfo), #0);
          ClientMissionInfo.MissionIdx := Msg.Recog;
          ClientMissionInfo.MissionInfo := MissionInfo;
          ClientMissionInfo.MissionInfo.boTrack := True;
          ClientMissionInfo.ClientMission := ClientMission;
          ClientMissionInfo.DTreeNodes := nil;
          ClientMission.MissionInfo := ClientMissionInfo;
          g_MissionInfoList.Add(ClientMissionInfo);
          if not ClientMission.boHide then
          begin
            if ClientMission.NPC <> nil then
              PlayScene.SetMissionInfo(ClientMission.NPC);

            sMasterName := ClientMission.sMissionMaster;
            DTreeNodes := nil;
            while True do
            begin
              sMasterName := GetValidStr3(sMasterName, sName, ['/', '\', '|']);
              if sName = '' then break;
              DTreeNodes := FrmDlg3.DTrvwMission.GetTreeNodes(DTreeNodes, sName, True);
            end;
            //DTreeNodes := FrmDlg3.DTrvwMission.GetTreeNodes(nil, ClientMission.sMissionMaster, True);
            if DTreeNodes <> nil then
            begin
              DTreeNodes2 := FrmDlg3.DTrvwMission.NewTreeNodes(ClientMission.sMissionShowName);
              DTreeNodes2.Item := ClientMissionInfo;
              DTreeNodes.ItemList.Add(DTreeNodes2);
              DTreeNodes.boOpen := True;
              FrmDlg3.DTrvwMission.Select := DTreeNodes2;
              ClientMissionInfo.DTreeNodes := DTreeNodes2;
              FrmDlg3.DTrvwMission.RefHeight;
              FrmDlg3.dwndMission.Visible := True;
              FrmDlg3.DTrvwMissionTreeViewSelect(FrmDlg3.DTrvwMission, DTreeNodes2);
            end;
          end;
          FrmDlg2.m_boShowMissionChange := True;
        end;
      end;
    end;
    MISSTAG_DELMISSION:
    begin
      for I := 0 to g_MissionInfoList.Count - 1 do
      begin
        ClientMissionInfo := g_MissionInfoList[i];
        if ClientMissionInfo.MissionIdx = Msg.Recog then
        begin
          if ClientMissionInfo.DTreeNodes <> nil then
          begin
            if FrmDlg3.DTrvwMission.Select = ClientMissionInfo.DTreeNodes then
              FrmDlg3.ShowMissionDlg(nil);
            FrmDlg3.DTrvwMission.DelItem(ClientMissionInfo.DTreeNodes, False);
          end;
          ClientMissionInfo.ClientMission.MissionInfo := nil;
          if ClientMissionInfo.ClientMission.NPC <> nil then
            PlayScene.SetMissionInfo(ClientMissionInfo.ClientMission.NPC);
          Dispose(ClientMissionInfo);
          g_MissionInfoList.Delete(I);
          FrmDlg2.m_boShowMissionChange := True;
          break;
        end;
      end;
    end;
    MISSTAG_UPDATEMISSION:
    begin
      sMission := DecodeString(sBody);
      if (Msg.Recog in [Low(TMissionInfos)..High(TMissionInfos)]) and (sMission <> '') then
      begin
        ClientMission := GetMissionInfo(sMission);
        if ClientMission <> nil then
        begin
          for I := 0 to g_MissionInfoList.Count - 1 do
          begin
            ClientMissionInfo := g_MissionInfoList[i];
            if ClientMissionInfo.MissionIdx = Msg.Recog then
            begin
              OldClientMission := ClientMissionInfo.ClientMission;
              ClientMissionInfo.ClientMission.MissionInfo := nil;
              ClientMissionInfo.MissionInfo.sMissionName := sMission;
              ClientMissionInfo.MissionInfo.btKillCount1 := Msg.Param;
              ClientMissionInfo.MissionInfo.btKillCount2 := Msg.tag;
              //ClientMissionInfo.MissionInfo.boTrack := True;
              ClientMissionInfo.nItemCount1 := 0;
              ClientMissionInfo.nItemCount2 := 0;
              ClientMissionInfo.nItemCount3 := 0;
              ClientMissionInfo.ClientMission := ClientMission;
              ClientMission.MissionInfo := ClientMissionInfo;
              if ClientMission.NPC <> nil then
                PlayScene.SetMissionInfo(ClientMission.NPC);
              if OldClientMission.NPC <> nil then
                PlayScene.SetMissionInfo(OldClientMission.NPC);

              if ClientMissionInfo.DTreeNodes <> nil then
              begin
                ClientMissionInfo.DTreeNodes.sName := ClientMission.sMissionShowName;
                ClientMissionInfo.DTreeNodes.nNameLen := g_DXCanvas.TextWidth(ClientMission.sMissionShowName) +
              FrmDlg3.DTrvwMission.ImageWidth;
                if FrmDlg3.DTrvwMission.Select = ClientMissionInfo.DTreeNodes then
                  FrmDlg3.DTrvwMissionTreeViewSelect(FrmDlg3.DTrvwMission, ClientMissionInfo.DTreeNodes);
              end else
                if not ClientMission.boHide then
                begin
                  sMasterName := ClientMission.sMissionMaster;
                  DTreeNodes := nil;
                  while True do
                  begin
                    sMasterName := GetValidStr3(sMasterName, sName, ['/', '\', '|']);
                    if sName = '' then break;
                    DTreeNodes := FrmDlg3.DTrvwMission.GetTreeNodes(DTreeNodes, sName, True);
                  end;
                  //DTreeNodes := FrmDlg3.DTrvwMission.GetTreeNodes(nil, ClientMission.sMissionMaster, True);
                  if DTreeNodes <> nil then
                  begin
                    DTreeNodes2 := FrmDlg3.DTrvwMission.NewTreeNodes(ClientMission.sMissionShowName);
                    DTreeNodes2.Item := ClientMissionInfo;
                    DTreeNodes.ItemList.Add(DTreeNodes2);
                    DTreeNodes.boOpen := True;
                    FrmDlg3.DTrvwMission.Select := DTreeNodes2;
                    ClientMissionInfo.DTreeNodes := DTreeNodes2;
                    FrmDlg3.DTrvwMission.RefHeight;
                    //FrmDlg3.dwndMission.Visible := True;
                    FrmDlg3.DTrvwMissionTreeViewSelect(FrmDlg3.DTrvwMission, DTreeNodes2);
                  end;
                end;
              FrmDlg2.m_boShowMissionChange := True;
              break;
            end;
          end;
        end;
      end;
    end;
    MISSTAG_UPDATEMISSIONTIME:
    begin
      if (Msg.Recog in [Low(TMissionInfos)..High(TMissionInfos)]) then
      begin
        for I := 0 to g_MissionInfoList.Count - 1 do
        begin
          ClientMissionInfo := g_MissionInfoList[i];
          if ClientMissionInfo.MissionIdx = Msg.Recog then
          begin
            ClientMissionInfo.MissionInfo.wTime := Msg.tag;
            FrmDlg2.m_boShowMissionChange := True;
            break;
          end;
        end;
      end;
    end;
    MISSTAG_CHANGEKILLMONCOUNT:
    begin
      for ClientMissionInfo in g_MissionInfoList do
      begin
        if ClientMissionInfo.MissionIdx = Msg.Recog then
        begin
          if Msg.Param = 2 then
          begin
            if ClientMissionInfo.MissionInfo.btKillCount2 < ClientMissionInfo.ClientMission.btKillCount2 then
            begin
              OldCount := ClientMissionInfo.MissionInfo.btKillCount2;
              ClientMissionInfo.MissionInfo.btKillCount2 := _MIN(Msg.tag, ClientMissionInfo.ClientMission.btKillCount2);
              if ClientMissionInfo.MissionInfo.btKillCount2 >= ClientMissionInfo.ClientMission.btKillCount2 then
              begin
                if ClientMissionInfo.ClientMission.NPC <> nil then
                  PlayScene.SetMissionInfo(ClientMissionInfo.ClientMission.NPC);
              end;
              if OldCount <> ClientMissionInfo.MissionInfo.btKillCount2 then
              begin
                if (FrmDlg3.DTrvwMission.Select <> nil) and (FrmDlg3.DTrvwMission.Select.Item = ClientMissionInfo) then
                  FrmDlg3.MDlgChange := True;
                if CLientMissionInfo.MissionInfo.boTrack then
                  FrmDlg2.m_boShowMissionChange := True;
              end;
            end;
          end else begin
            if ClientMissionInfo.MissionInfo.btKillCount1 < ClientMissionInfo.ClientMission.btKillCount1 then
            begin
              OldCount := ClientMissionInfo.MissionInfo.btKillCount1;
              ClientMissionInfo.MissionInfo.btKillCount1 := _MIN(Msg.tag, ClientMissionInfo.ClientMission.btKillCount1);
              if ClientMissionInfo.MissionInfo.btKillCount1 >= ClientMissionInfo.ClientMission.btKillCount1 then
              begin
                if ClientMissionInfo.ClientMission.NPC <> nil then
                  PlayScene.SetMissionInfo(ClientMissionInfo.ClientMission.NPC);
              end;
              if OldCount <> ClientMissionInfo.MissionInfo.btKillCount1 then
              begin
                if (FrmDlg3.DTrvwMission.Select <> nil) and (FrmDlg3.DTrvwMission.Select.Item = ClientMissionInfo) then
                  FrmDlg3.MDlgChange := True;
                if CLientMissionInfo.MissionInfo.boTrack then
                  FrmDlg2.m_boShowMissionChange := True;
              end;
            end;
          end;
          break;
        end;
      end;
    end;
    MISSTAG_ARITHMOMETERCHANGE:
    begin
      if Msg.Recog in [Low(g_MissionArithmometer)..High(g_MissionArithmometer)] then
      begin
        g_MissionArithmometer[Msg.Recog] := Msg.Param;
        PlayScene.RefMissionInfo;
      end;
    end;
  end;
end

;

procedure TfrmMain.ClientGetGameGoldName(Msg: TDefaultMessage; sBody: string);
begin
  {if sBody <> '' then begin
    g_sGamePointName := DecodeString(sBody);
  end;     }
  if sBody <> '' then
  begin
    g_sGameGoldName := DecodeString(sBody);
    FrmDlg2.DShopGetGamePoint.Caption := '对换' + g_sGameGoldName;
    FrmDlg2.DShopGamePoint.Caption := g_sGameGoldName + '区';
  end;

  if g_MySelf = nil then exit;

  g_MySelf.m_nGameGold := Msg.Recog;
  g_MySelf.m_nGamePoint := Msg.param;
  g_nDander := msg.Series;
end

;

procedure TfrmMain.ClientGetBabDuraChange2(Msg: pTDefaultMessage);
var
  I: Integer;
begin
  for I := High(g_ItemArr) downto Low(g_ItemArr) do
  begin
    if (g_ItemArr[I].UserItem.MakeIndex = Msg.Recog) and (g_ItemArr[I].S.Name <> '') then
    begin
      g_ItemArr[I].UserItem.Dura := Msg.Param;
      g_ItemArr[I].UserItem.DuraMax := Msg.Tag;
      RefUserKeyItemInfo(@g_ItemArr[I]);
      DScreen.AddSysMsg('获得 <CO$FFFF>' + g_ItemArr[I].s.Name + ' ' + IntToStr(MSg.Series) + '<CE>', cllime);
      exit;
    end;
  end;
  if g_MovingItem.Item.UserItem.MakeIndex = Msg.Recog then
  begin
    g_MovingItem.Item.UserItem.Dura := Msg.Param;
    g_MovingItem.Item.UserItem.DuraMax := Msg.Tag;
    DScreen.AddSysMsg('获得 <CO$FFFF>' + g_MovingItem.Item.s.Name + ' ' + IntToStr(MSg.Series) + '<CE>', cllime);
  end;
end

;

procedure TfrmMain.ClientGetAddItem(Msg: TDefaultMessage; body: string);
var
  cu: TNewClientItem;
  sCount: string;
begin
  if body <> '' then
  begin
    SafeFillChar(cu, SizeOf(TNewClientItem), #0);
    DecodeItem(body, @cu.UserItem);
    cu.s := GetStditem(cu.UserItem.wIndex);
    sCount := '1';
    if (sm_Superposition in cu.s.StdModeEx) and (cu.s.DuraMax > 1) then
    begin
      sCount := IntToStr(cu.UserItem.Dura);
    end;
    AddItemBag(cu);
    DScreen.AddSysMsg('获得 <CO$FFFF>' + cu.S.name + ' ' + sCount + '<CE>', clLime);
  end;
end

;

procedure TfrmMain.ClientGetGroupAddItem(Msg: pTDefaultMessage);
var
  GroupMember: pTGroupMember;
  i: Integer;
  StdItem: TStdItem;
  sCount: string;
begin
  if g_GroupMembers.Count > 0 then
  begin
    for i := 0 to g_GroupMembers.Count - 1 do
    begin
      GroupMember := g_GroupMembers[i];
      if GroupMember.ClientGroup.UserID = msg.Recog then
      begin
        StdItem := GetStditem(msg.Param);
        if StdItem.Name <> '' then
        begin
          sCount := '1';
          if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then
          begin
            sCount := IntToStr(msg.tag);
          end;
          DScreen.AddSysMsg('<CO$FFFF00>' + GroupMember.ClientGroup.UserName +
          '<CE> 获得 <CO$FFFF>' + StdItem.name + ' ' + sCount + '<CE>', cllime);
        end;
        break;
      end;
    end;
  end;
end

;

procedure TfrmMain.ClientGetUpdateItem(body: string);
var
  i: Integer;
  cu: TNewClientItem;
begin
  if body <> '' then
  begin
    SafeFillChar(cu, SizeOf(TNewClientItem), #0);
    DecodeItem(body, @cu.UserItem);
    cu.s := GetStditem(cu.UserItem.wIndex);
    UpdateItemBag(cu);
    for i := 0 to MAXUSEITEMS - 1 do
    begin
      if (g_UseItems[i].S.name = cu.S.name) and (g_UseItems[i].UserItem.MakeIndex = cu.UserItem.MakeIndex) then
      begin
        g_UseItems[i] := cu;
      end;
    end;
  end;
end

;

procedure TfrmMain.ClientGetDelItem(sindex, nIdent: Integer);
begin
  DelItemBag(nIdent, sindex);
end

;

procedure TfrmMain.ClientGetDelItems(body: string);
var
  str, iname: string;
begin
  body := DecodeString(body);
  while body <> '' do
  begin
    body := GetValidStr3(body, iname, ['/']);
    body := GetValidStr3(body, str, ['/']);
    if (iname <> '') and (str <> '') then
    begin
      DelItemBag(StrToIntDef(iname, 0), StrToIntDef(str, 0));
    end
    else
      break;
  end;
end

;

procedure TfrmMain.ClientGetBabDuraChange(Idx, Dura, MaxDura: integer);
var
  I: Integer;
begin
  for I := High(g_ItemArr) downto Low(g_ItemArr) do
  begin
    if (g_ItemArr[I].UserItem.MakeIndex = Idx) and (g_ItemArr[I].S.Name <> '') then
    begin
      g_ItemArr[I].UserItem.Dura := Dura;
      g_ItemArr[I].UserItem.DuraMax := MaxDura;
      RefUserKeyItemInfo(@g_ItemArr[I]);
      exit;
    end;
  end;
  if g_MovingItem.Item.UserItem.MakeIndex = Idx then
  begin
    g_MovingItem.Item.UserItem.Dura := Dura;
    g_MovingItem.Item.UserItem.DuraMax := MaxDura;
  end;
end

;

procedure TfrmMain.ClientGetAddBagItmes(body: string);
var
  Index: Integer;
  str, data: string;
  cu: TNewClientItem;
begin
  SafeFillChar(g_AddBagItems, sizeof(g_AddBagItems), #0);
  while True do
  begin
    if body = '' then break;
    body := GetValidStr3(body, str, ['/']);
    body := GetValidStr3(body, data, ['/']);
    Index := StrToIntDef(str, -1);
    if Index in [Low(g_AddBagItems)..High(g_AddBagItems)] then
    begin
      SafeFillChar(cu, SizeOf(TNewClientItem), #0);
      DecodeItem(data, @cu.UserItem);
      cu.s := GetStditem(cu.UserItem.wIndex);
      g_AddBagItems[Index] := cu;
    end;
  end;
  RecalcBagCount();
  FrmDlg.RefAddBagWindow();
end

;

procedure TfrmMain.ClientUpdateUserItem(body: string);
var
  UserItem: TUserItem;
begin
  SafeFillChar(UserItem, SizeOf(TUserItem), #0);
  DecodeItem(body, @UserItem);
  UpdateItemBagByUserItem(UserItem);
end

;

procedure TfrmMain.ClientGetBagItmes(body: string);
var
  str: string;
  cu: TNewClientItem;
begin
  //ClearBag;
  g_boBagItemsRead := True;
  FrmDlg2.ClearShopSellItems;
  FrmDlg3.ClearStrengthenInfo;
  FrmDlg3.ClearMakeItemInfo;
  FrmDlg3.ClearUnSealInfo;
  SafeFillChar(g_ItemArr, sizeof(g_ItemArr), #0);
  while True do
  begin
    if body = '' then
      break;
    body := GetValidStr3(body, str, ['/']);

    SafeFillChar(cu, SizeOf(TNewClientItem), #0);
    DecodeItem(str, @cu.UserItem);
    cu.s := GetStditem(cu.UserItem.wIndex);
    if not FrmDlg2.GetShopSellItems(cu) then
      AddItemBagByEx(cu);
  end;
  ArrangeItembag;
  RefUserKeyItemInfo(nil);
  //g_boBagLoaded := True;
end

;

procedure TfrmMain.ClientGetEMail(Msg: pTDefaultMessage; body: string);
var
  ClientEMailHeader: TClientEMailHeader;
  str: string;
  EMailInfo: pTEMailInfo;
  I: integer;
  nCount: Integer;
  nIndex: Integer;
begin
  case Msg.Series of
    0:
    begin
      nCount := 0;
      ClearEMailInfo();
      while True do
      begin
        if Body = '' then
          break;
        body := GetValidStr3(body, str, ['/']);
        if str = '' then
          break;
        DecodeBuffer(str, @ClientEMailHeader, Sizeof(ClientEMailHeader));
        New(EMailInfo);
        SafeFillChar(EMailInfo^, SizeOf(TEMailInfo), #0);
        EMailInfo.ClientEMail := ClientEMailHeader;
        if not EMailInfo.ClientEMail.boRead then
          Inc(nCount);

        EMailInfo.sText := '';
        g_EMailList.AddObject(Format('%d%d%.3d',
                                      [Integer(EMailInfo.ClientEMail.boRead),
                                      Integer(not EMailInfo.ClientEMail.boSystem),
                                      EMailInfo.ClientEMail.btTime]), TObject(EMailInfo));
      end;
      g_EMailList.SortString(0, g_EMailList.Count - 1);
      FrmDlg2.DUpDownEMail.MaxPosition := g_EMailList.Count - 5;
      FrmDlg2.DUpDownEMail.Position := 0;
      if nCount > 0 then
      begin
        DScreen.AddSysMsg('[你有 ' + IntToStr(nCount) + '封 未读的信件]', clWhite);
        try
          g_Sound.Volume := Round(g_btSoundVolume * 0.8);
          PlaySoundEx(bmg_NewEMail);
        finally
          g_Sound.Volume := g_btSoundVolume;
        end;
      end;
    end;
    1:
    begin
      FrmDlg2.EMailSelectTick := 0;
      if Msg.Recog >= 0 then
      begin
        for I := 0 to g_EMailList.Count - 1 do
        begin
          EMailInfo := pTEMailInfo(g_EMailList.Objects[i]);
          if EMailInfo.ClientEMail.nIdx = Msg.Recog then
          begin
            body := GetValidStrEx(body, str, ['/']);
            EMailInfo.sText := DecodeString(body);
            EMailInfo.nGold := Msg.Param;
            if str <> '' then
            begin
              DecodeItem(str, @EMailInfo.Item.UserItem);
              EMailInfo.Item.s := GetStditem(EMailInfo.Item.UserItem.wIndex);
            end;
            EMailInfo.ClientEMail.boRead := True;
            g_EMailList[i] := Format('%d%d%.3d', [Integer(EMailInfo.ClientEMail.boRead), Integer(not
          EMailInfo.ClientEMail.boSystem),
          EMailInfo.ClientEMail.btTime]);
            g_EMailList.SortString(0, g_EMailList.Count - 1);
            FrmDLg2.OpenReadMail(EMailInfo);
            break;
          end;
        end;
      end
      else
        FrmDlg.DMessageDlg('读取信件内容失败...', []);

    end;
    2:
    begin
      if (msg.Recog < 0) and (msg.recog <> 2) then
      begin
        if g_SendEMailItem.Item.s.name <> '' then
          AddItemBag(g_SendEMailItem.Item, g_SendEMailItem.Index2);
      end;
      case msg.Recog of
        -1: FrmDlg.DMessageDlg('[发送失败]：信件内容不完整', []);
        -2: FrmDlg.DMessageDlg('[发送失败]：收件人不是你的好友', []);
        -3: FrmDlg.DMessageDlg('[发送失败]：对方的收件箱已满，无法接收', []);
        -4: FrmDlg.DMessageDlg('[发送失败]：系统错误！', []);
        -5: FrmDlg.DMessageDlg('[发送失败]：你的' + g_sGoldName + '不够支付发送费用', []);
        -6: FrmDlg.DMessageDlg('[发送失败]：邮件中附带的物品不允许交易！', []);
        -11: FrmDlg.DMessageDlg('[发送失败]：发送物品只能在安全区进行操作', []);
        1: FrmDlg.DMessageDlg('信件发送成功', []);
        2:
        begin
          DecodeBuffer(body, @ClientEMailHeader, Sizeof(ClientEMailHeader));
          New(EMailInfo);
          SafeFillChar(EMailInfo^, SizeOf(TEMailInfo), #0);
          EMailInfo.ClientEMail := ClientEMailHeader;
          EMailInfo.sText := '';
          g_EMailList.AddString(Format('%d%d%.3d',
                                        [Integer(EMailInfo.ClientEMail.boRead),
                                        Integer(not EMailInfo.ClientEMail.boSystem),
                                        EMailInfo.ClientEMail.btTime]), EMailInfo);
          FrmDlg2.DUpDownEMail.MaxPosition := g_EMailList.Count - 5;
          FrmDlg2.DUpDownEMail.Position := 0;
          DScreen.AddSysMsg('[你有新的信件]', clWhite);
          try
            g_Sound.Volume := Round(g_btSoundVolume * 0.8);
            PlaySoundEx(bmg_NewEMail);
          finally
            g_Sound.Volume := g_btSoundVolume;
          end;
        end;
      end;
      g_SendEMailItem.Item.s.name := '';
    end;
    4:
    begin
      FrmDlg2.EMailSelectTick := 0;
      if (Msg.Recog >= 0) then
      begin
        nIndex := Msg.Param;
        for I := 0 to g_EMailList.Count - 1 do
        begin
          EMailInfo := pTEMailInfo(g_EMailList.Objects[i]);
          if EMailInfo.ClientEMail.nIdx = nIndex then
          begin
            EMailInfo.nGold := 0;
            if FrmDlg2.ReadEMailInfo.ClientEMail.nIdx = nIndex then
              FrmDlg2.ReadEMailInfo.nGold := 0;
            break;
          end;
        end;
        if Msg.Recog > g_MySelf.m_nGold then
        begin
          DScreen.AddSysMsg('获得 <CO$FFFF>' + g_sGoldName + ' ' + IntToStr(Msg.Recog - g_MySelf.m_nGold) + '<CE>', cllime);
        end;
        g_MySelf.m_nGold := Msg.Recog;
        SoundUtil.PlaySound(s_money);
      end
      else begin
        FrmDlg.DMessageDlg('获取信件' + g_sGoldName + '失败...', []);
      end;
    end;
    5:
    begin
      FrmDlg2.EMailSelectTick := 0;
      if (Msg.Recog >= 0) then
      begin
        nIndex := Msg.Recog;
        for I := 0 to g_EMailList.Count - 1 do
        begin
          EMailInfo := pTEMailInfo(g_EMailList.Objects[i]);
          if EMailInfo.ClientEMail.nIdx = nIndex then
          begin
            AddItemBag(EMailInfo.Item);
            SafeFillChar(EMailInfo.Item, SizeOf(EMailInfo.Item), #0);
            if FrmDlg2.ReadEMailInfo.ClientEMail.nIdx = nIndex then
              SafeFillChar(FrmDlg2.ReadEMailInfo.Item, SizeOf(FrmDlg2.ReadEMailInfo.Item), #0);
            break;
          end;
        end;
      end
      else begin
        FrmDlg.DMessageDlg('获取信件附件物品失败...', []);
      end;
    end;
  end;
end

;

procedure TfrmMain.ClientGetFriendChange(Msg: pTDefaultMessage; body: string);
var
  i: integer;
  sName, sIndex: string;
begin
  case Msg.Series of
    0:
    begin
      body := DecodeString(body);
      for I := 0 to g_FriendList.Count - 1 do
      begin
        if CompareText(g_FriendList[i], body) = 0 then
        begin
          g_FriendList.Objects[i] := TObject(Msg.Param);
          if msg.Param = 1 then
            DScreen.AddSysMsg('好友 [' + body + '] 上线了.', clWhite)
          else
            DScreen.AddSysMsg('好友 [' + body + '] 离线了.', clWhite);
          break;
        end;
      end;
    end;
    1:
    begin
      body := DecodeString(body);
      while True do
      begin
        if body = '' then
          break;
        body := GetValidStr3(body, sName, ['/']);
        body := GetValidStr3(body, sIndex, ['/']);
        if (sName <> '') and (sIndex <> '') then
        begin
          if sIndex = '1' then
            g_FriendList.AddObject(sName, TObject(1))
          else
            g_FriendList.AddObject(sName, nil);
        end;
      end;
    end;
    2:
    begin
      g_FriendList.AddObject(DecodeString(body), TObject(1));
    end;
    3:
    begin
      body := DecodeString(body);
      for I := 0 to g_FriendList.Count - 1 do
      begin
        if CompareText(g_FriendList[i], body) = 0 then
        begin
          DScreen.AddSysMsg('[<CO$FFFF>' + body + '<CE>] 已经将你从好友列表当中删除.', $32F4);
          g_FriendList.Delete(i);
          break;
        end;
      end;
    end;
  end;
end

;

procedure TfrmMain.ClientGetDropItemFail(sindex: Integer);
var
  pc: PTNewClientItem;
begin
  pc := GetDropItem(sindex);
  if pc <> nil then
  begin
    AddItemBag(pc^);
    DelDropItem(sindex);
  end;
end

;

procedure TfrmMain.ClientGetShopItems(Msg: pTDefaultMessage; body: string);
var
  str, sIndex: string;
  ClientShopItem: TClientShopItem;
  cu: pTShopItem;
  i, ii, nIndex: Integer;
  ClientDateTime: TClientDateTime;
  QuickPointList: TQuickPointList;
begin
  ClientDateTime.nInteger := Msg.Recog;
  ClientDateTime.wWord1 := Msg.Param;
  ClientDateTime.wWord2 := MSg.tag;
  g_ShopDateTime := ClientDateTime.DateTime;
  g_ShopLoading[0] := Msg.Series;
  if body <> '' then
  begin
    for ii := 2 to 5 do
    begin
      for I := 0 to g_ShopList[ii].Count - 1 do
      begin
        Dispose(pTShopItem(g_ShopList[ii].Items[i]));
      end;
      g_ShopList[ii].Clear;
    end;
    for i := Low(g_ShopGoldList) to High(g_ShopGoldList) do
    begin
      g_ShopGoldList[i].Clear;
    end;
    g_ShopList[0].Clear;
    g_ShopList[1].Clear;
    g_ShopBuyItem := nil;
    QuickPointList := TQuickPointList.Create;
    try
      while True do
      begin
        if body = '' then
          break;
        body := GetValidStr3(body, sIndex, ['/']);
        body := GetValidStr3(body, str, ['/']);
        nIndex := StrToIntDef(sIndex, -1);
        if nIndex = -1 then
          Continue;
        DecodeBuffer(str, @ClientShopItem, sizeof(TClientShopItem));
        New(cu);
        SafeFillChar(cu^, SizeOf(TShopItem), #0);
        cu.nIndex := nIndex;
        cu.CLientItem.s := GetStditem(ClientShopItem.wIdent);
        cu.CLientItem.UserItem.Dura := cu.CLientItem.s.DuraMax;
        cu.CLientItem.UserItem.DuraMax := cu.CLientItem.s.DuraMax;
        cu.CLientItem.UserItem.btBindMode1 := ClientShopItem.btStatus;
        //SetByteStatus(cu.CLientItem.UserItem.btBindMode2, Ib2_Bind, CheckByteStatus(ClientShopItem.btStatus, Ib_NoDown));
        //SetByteStatus(cu.CLientItem.UserItem.btBindMode1, Ib_NoDown, False);
        cu.ClientShopItem := ClientShopItem;
        cu.sHint := GetShopHintList(cu.CLientItem.s.Name);
        if ClientShopItem.btIdx in [0..3] then
        begin
          if ClientShopItem.nPrict > 0 then
            g_ShopList[ClientShopItem.btIdx + 2].Add(cu);
          if ClientShopItem.nGoldPrict > 0 then
            g_ShopGoldList[ClientShopItem.btIdx + 2].Add(cu);
{$IF Var_Interface = Var_Mir2}
          if ClientShopItem.nCount > -1 then
          begin
            if ClientShopItem.nPrict > 0 then
              g_ShopList[1].Add(cu);
            if ClientShopItem.nGoldPrict > 0 then
              g_ShopGoldList[1].Add(cu);
          end;
{$ELSE}
          if ClientShopItem.btAgio > 0 then begin
          if ClientShopItem.nPrict > 0 then
          g_ShopList[1].Add(cu);
          if ClientShopItem.nGoldPrict > 0 then
          g_ShopGoldList[1].Add(cu);
          end;
{$IFEND}

          if ClientShopItem.nSellCount > 0 then
          begin
            QuickPointList.AddPointer(ClientShopItem.nSellCount, cu, True);
          end;
        end
        else
          Dispose(cu);
      end;
      for I := 0 to QuickPointList.Count - 1 do
      begin
        if pTShopItem(QuickPointList.GetPointer(I)).ClientShopItem.nPrict > 0 then
          g_ShopList[0].Add(QuickPointList.GetPointer(I));
        if pTShopItem(QuickPointList.GetPointer(I)).ClientShopItem.nGoldPrict > 0 then
          g_ShopGoldList[0].Add(QuickPointList.GetPointer(I));
      end;
    finally
      QuickPointList.Free;
    end;
  end;
end

;

//掉落物品

procedure TfrmMain.ClientGetShowItem(itemid, X, Y, looks: Integer; itmname: string);
resourcestring
  sTest1 = '[<CO$FFFF>%s<CE>] 出现在坐标 [<CO$FFFF>%d:%d<CE>] 方向 <CO$FFFF>%s<CE>';
var
  i: Integer;
  DropItem: pTDropItem;
begin
  for i := 0 to g_DropedItemList.count - 1 do
  begin
    if pTDropItem(g_DropedItemList[i]).id = itemid then
      Exit;
  end;
  for i := 0 to g_FreeItemList.count - 1 do
  begin
    if pTDropItem(g_FreeItemList[i]).id = itemid then
      Exit;
  end;

  new(DropItem);
  DropItem.id := itemid;
  DropItem.X := X;
  DropItem.Y := Y;
  DropItem.looks := looks;
  DropItem.name := itmname;
  DropItem.FlashTime := GetTickCount - LongWord(Random(5000));
  DropItem.BoFlash := FALSE;
  DropItem.Width := g_DXCanvas.TextWidth(itmname) + 2; //
  DropItem.Height := g_DXCanvas.TextHeight(itmname) + 2;
  DropItem.Filtr := GetStditemFiltrate(itmname);
  if itmname = g_sGoldName then
  begin
    DropItem.Filtr.boPickUp := True;
    DropItem.Filtr.boShow := True;
  end;
  DropItem.nColor := GetRGB(147);
  //DropItem.d := nil;
  {DropItem.d := TDXImageTexture.Create(g_DXCanvas);
  DropItem.d.Size := Point(DropItem.Width, DropItem.Height);
  DropItem.d.PatternSize := Point(DropItem.Width, DropItem.Height);
  DropItem.d.Format := D3DFMT_A4R4G4B4;
  DropItem.d.Active := True;
  DropItem.d.Clear;
  DropItem.d.TextOutEx(1, 1, itmname);}
  g_DropedItemList.Add(DropItem);
  {DropItem.d := TDirectDrawSurface.Create(DXDraw.DDraw);
  DropItem.d.SystemMemory := True;
  DropItem.d.SetSize(DropItem.Width, DropItem.Height);
  DropItem.d.Canvas.Font.Name := DEF_FONT_NAME;
  DropItem.d.Canvas.Font.Size := DEF_FONT_SIZE;
  DropItem.boColor := DropItem.Filtr.boColor;
  SetBkMode(DropItem.d.Canvas.Handle, TRANSPARENT);
  if DropItem.boColor then
    DropItem.d.Canvas.Font.Color := g_SetupInfo.nItemColor
  else
    DropItem.d.Canvas.Font.Color := GetRGB(147);
  BoldTextOutEx(DropItem.d, 1, 1, DropItem.d.Canvas.Font.Color, $000008, itmname);
  DropItem.d.Canvas.Release;  }

  {if DropItem.Filtr.boHint and (g_MySelf <> nil) then begin
    DScreen.AddSysMsg(Format(sTest1, [itmname, x, y,
      g_WayTag[GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, X, Y)]]), clAqua);
  end;   }
end

;

procedure TfrmMain.ClientGetHideItem(itemid, pickup: Integer);
var
  i: Integer;
  DropItem: pTDropItem;
begin
  for i := 0 to g_DropedItemList.count - 1 do
  begin
    DropItem := g_DropedItemList[i];
    if DropItem.id = itemid then
    begin
      DisopseDropItem(DropItem, pickup);
      g_DropedItemList.Delete(i);
      break;
    end;
  end;
end

;
{procedure TfrmMain.ClientGetSendAddUseItems(body: string);
var
  Index: Integer;
  str, data: string;
  cu: TClientItem;
begin
  while True do begin
    if body = '' then break;
    body := GetValidStr3(body, str, ['/']);
    body := GetValidStr3(body, data, ['/']);
    Index := StrToIntDef(str, -1);
    if Index in [9..12] then begin
      DecodeBuffer(data, @cu, sizeof(TClientItem));
      g_UseItems[Index] := cu;
    end;
  end;
end;       }

procedure TfrmMain.ClientGetSenduseItems(body: string);
var
  Index: Integer;
  str, data: string;
  cu: TNewClientItem;
begin
  SafeFillChar(g_UseItems, sizeof(g_UseItems), #0);
  //   SafeFillChar (UseItems, sizeof(TClientItem)*9, #0);
  while True do
  begin
    if body = '' then
      break;
    body := GetValidStr3(body, str, ['/']);
    body := GetValidStr3(body, data, ['/']);
    Index := StrToIntDef(str, -1);
    if Index in [0..MAXUSEITEMS - 1] then
    begin
      SafeFillChar(cu, SizeOf(TNewClientItem), #0);
      DecodeItem(data, @cu.UserItem);
      cu.s := GetStditem(cu.UserItem.wIndex);
      g_UseItems[Index] := cu;
    end;
  end;
end

;

procedure TfrmMain.ClientGetMyShopList(Msg: pTDefaultMessage; body: string);
var
  str: string;
  nSellLen, nBuyLen: integer;
  ClientMyShopSellItem: TClientMyShopSellItem;
  ClientMyShopBuyItem: TClientMyShopBuyItem;
begin
  body := GetValidStr3(body, str, ['/']);
  if g_MySelf <> nil then
  begin
    g_MySelf.m_boShop := True;
    g_MyShopTitle := DecodeString(str);
    g_MySelf.m_sShopTitle := g_MyShopTitle;
    g_MyShopGold := Msg.Param;
    g_MyShopGameGold := Msg.Recog;
    g_MySelf.m_btShopIdx := Msg.tag;
    g_MySelf.m_boShopLeft := msg.Series <> 0;
    if g_MySelf.m_boShopLeft then
      g_MySelf.m_btDir := 1
    else
      g_MySelf.m_btDir := 5;

    g_MySelf.LoadShopTitle();

    SafeFillChar(g_MyReadShopSellItems, SizeOf(g_MyReadShopSellItems), #0);
    SafeFillChar(g_MyReadShopBuyItems, SizeOf(g_MyReadShopBuyItems), #0);

    nSellLen := GetCodeMsgSize(Sizeof(ClientMyShopSellItem) * 4 / 3);
    nBuyLen := GetCodeMsgSize(Sizeof(ClientMyShopBuyItem) * 4 / 3);
    while True do
    begin
      if body = '' then break;
      body := GetValidStr3(body, str, ['/']);
      if str = '' then break;
      if Length(str) = nSellLen then
      begin
        DecodeBuffer(str, @ClientMyShopSellItem, sizeof(ClientMyShopSellItem));
        if ClientMyShopSellItem.btIdx in [Low(g_MyShopSellItems)..High(g_MyShopSellItems)] then
        begin
          g_MyShopSellItems[ClientMyShopSellItem.btIdx].nMoney := ClientMyShopSellItem.nMoney;
          g_MyShopSellItems[ClientMyShopSellItem.btIdx].boGamePoint := ClientMyShopSellItem.boGameGold;
          g_MyShopSellItems[ClientMyShopSellItem.btIdx].ShopItem.Item.UserItem := ClientMyShopSellItem.UserItem;
          g_MyShopSellItems[ClientMyShopSellItem.btIdx].ShopItem.Item.s := GetStditem(ClientMyShopSellItem.UserItem.wIndex);
        end;
      end
      else if Length(str) = nBuyLen then
      begin
        DecodeBuffer(str, @ClientMyShopBuyItem, sizeof(ClientMyShopBuyItem));
        if ClientMyShopBuyItem.btIdx in [Low(g_MyShopBuyItems)..High(g_MyShopBuyItems)] then
        begin
          g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].nMoney := ClientMyShopBuyItem.nMoney;
          g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].boGamePoint := ClientMyShopBuyItem.boGameGold;
          g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.wIndex := ClientMyShopBuyItem.wIdent;
          g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s := GetStditem(ClientMyShopBuyItem.wIdent);
          g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.DuraMax :=
                                                                                       g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax;
          if (sm_Superposition in g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.StdModeEx) and
          (g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax > 1) then
          begin
            g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.Dura := ClientMyShopBuyItem.wCount;
          end
          else
            g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.Dura :=
                                                                                      g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax;
        end;
      end;
    end;
  end;
end

;

procedure TfrmMain.ClientGetUserShopList(Msg: pTDefaultMessage; body: string);
var
  Actor: TActor;
  str: string;
  nSellLen, nBuyLen: integer;
  ClientMyShopSellItem: TClientMyShopSellItem;
  ClientMyShopBuyItem: TClientMyShopBuyItem;
begin
  SafeFillChar(g_MyReadShopSellItems, SizeOf(g_MyReadShopSellItems), #0);
  SafeFillChar(g_MyReadShopBuyItems, SizeOf(g_MyReadShopBuyItems), #0);
  Actor := Playscene.FindActor(Msg.Recog);
  if Actor <> nil then
  begin
    FrmDlg2.UserShopID := msg.Recog;
    g_MyReadTitle := Actor.m_UserName + ' 的店铺';
    nSellLen := GetCodeMsgSize(Sizeof(ClientMyShopSellItem) * 4 / 3);
    nBuyLen := GetCodeMsgSize(Sizeof(ClientMyShopBuyItem) * 4 / 3);
    while True do
    begin
      if body = '' then
        break;
      body := GetValidStr3(body, str, ['/']);
      if str = '' then
        break;
      if Length(str) = nSellLen then
      begin
        DecodeBuffer(str, @ClientMyShopSellItem, sizeof(ClientMyShopSellItem));
        if ClientMyShopSellItem.btIdx in [Low(g_MyReadShopSellItems)..High(g_MyReadShopSellItems)] then
        begin
          g_MyReadShopSellItems[ClientMyShopSellItem.btIdx].nMoney := ClientMyShopSellItem.nMoney;
          g_MyReadShopSellItems[ClientMyShopSellItem.btIdx].boGamePoint := ClientMyShopSellItem.boGameGold;
          g_MyReadShopSellItems[ClientMyShopSellItem.btIdx].ShopItem.Item.UserItem := ClientMyShopSellItem.UserItem;
          g_MyReadShopSellItems[ClientMyShopSellItem.btIdx].ShopItem.Item.s := GetStditem(ClientMyShopSellItem.UserItem.wIndex);
        end;
      end
      else if Length(str) = nBuyLen then
      begin
        DecodeBuffer(str, @ClientMyShopBuyItem, sizeof(ClientMyShopBuyItem));
        if ClientMyShopBuyItem.btIdx in [Low(g_MyReadShopBuyItems)..High(g_MyReadShopBuyItems)] then
        begin
          g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].nMoney := ClientMyShopBuyItem.nMoney;
          g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].boGamePoint := ClientMyShopBuyItem.boGameGold;
          g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.wIndex := ClientMyShopBuyItem.wIdent;
          g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s := GetStditem(ClientMyShopBuyItem.wIdent);
          g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.DuraMax :=
                                                                                           g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax;
          if (sm_Superposition in g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.StdModeEx) and
          (g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax > 1) then
          begin
            g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.Dura := ClientMyShopBuyItem.wCount;
          end
          else
            g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.Dura :=
                                                                                          g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax;
        end;
      end;
    end;
    g_nMyReadShopDlgID := msg.Recog;
    g_nMyReadShopDlgX := Msg.Param;
    g_nMyReadShopDlgY := Msg.tag;
    FrmDlg2.DReadShopMemo.Lines.Clear;
    FrmDlg2.DReadUserShop.Visible := True;
  end;
end

;

procedure TfrmMain.ClientOpenBox(Msg: pTDefaultMessage; body: string);
var
  ClientBoxInfo: TClientBoxInfo;
  I: Integer;
begin
  SafeFillChar(ClientBoxInfo, Sizeof(ClientBoxInfo), #0);
  DecodeBuffer(body, @ClientBoxInfo, sizeof(ClientBoxInfo));
  with FrmDlg3 do
  begin
    OpenBoxGold := Msg.Recog;
    OpenBoxGameGold := Msg.Param;
    OpenBoxIndex := Msg.Series;
    OpenBoxSelectIndex := 0;
    OpenGetItemIndex := 0;
    OpenBoxMove := False;
    OpenGetItem := False;
    dbtnBoxNext.Caption := '转动轮盘';
    dbtnBoxGetItem.Caption := '领取奖励';
    OpenBoxStop := False;
    SafeFillChar(OpenBoxItems, Sizeof(OpenBoxItems), #0);
    for I := Low(ClientBoxInfo.Normal) to High(ClientBoxInfo.Normal) do
    begin
      OpenBoxItems[I].ItemType := ClientBoxInfo.Normal[I].ItemType;
      OpenBoxItems[I].Item.UserItem := ClientBoxInfo.Normal[I].Item;
      case OpenBoxItems[I].ItemType of
        bit_Item:
        begin
          OpenBoxItems[I].Item.s := GetStditem(ClientBoxInfo.Normal[I].Item.wIndex);
        end;
      end;
    end;
    for I := Low(ClientBoxInfo.Peculiar) to High(ClientBoxInfo.Peculiar) do
    begin
      OpenBoxItems[I + 9].ItemType := ClientBoxInfo.Peculiar[I].ItemType;
      OpenBoxItems[I + 9].Item.UserItem := ClientBoxInfo.Peculiar[I].Item;
      case OpenBoxItems[I + 9].ItemType of
        bit_Item:
        begin
          OpenBoxItems[I + 9].Item.s := GetStditem(ClientBoxInfo.Peculiar[I].Item.wIndex);
        end;
      end;
    end;
    dwndBox.Visible := True;
  end;
end

;

procedure TfrmMain.ClientGetSetIcon(DefMsg: pTDefaultMessage; body: string);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if (Actor <> nil) and (body <> '') then
  begin
    DecodeBuffer(body, @Actor.m_IconInfo[0], SizeOf(TIconInfos));
    SafeFillChar(Actor.m_IconInfoShow[0], SizeOf(TIconInfoShows), #0);
  end;
end

;

procedure TfrmMain.ClientGetHumLook(DefMsg: pTDefaultMessage);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if (Actor <> nil) then
    Actor.m_nWeaponEffect := LoByte(DefMsg.Param);
end

;

procedure TfrmMain.ClientGetAddMagic(body: string);
var
  ClientMagic: TClientMagic;
begin
  SafeFillChar(ClientMagic, Sizeof(ClientMagic), #0);
  DecodeBuffer(body, @ClientMagic, sizeof(ClientMagic));
  if (ClientMagic.btMagID > 0) and (ClientMagic.btMagID < SKILL_MAX) then
  begin
    g_MyMagicArry[ClientMagic.btMagID].boStudy := True;
    g_MyMagicArry[ClientMagic.btMagID].Level := ClientMagic.Level;
    g_MyMagicArry[ClientMagic.btMagID].CurTrain := ClientMagic.CurTrain;
    g_MyMagicArry[ClientMagic.btMagID].btKey := ClientMagic.btKey;
    g_MyMagicArry[ClientMagic.btMagID].dwInterval := 0;
    g_MyMagicArry[ClientMagic.btMagID].boUse := False;
    g_MyMagicArry[ClientMagic.btMagID].Def := GetMagicInfo(ClientMagic.btMagID);
{$IF Var_Interface = Var_Mir2}
    if ClientMagic.btMagID <> 100 then
    begin
//      if (ClientMagic.btMagID in [110..121]) then
//        FrmDlg.MagicList2.AddObject(' ', TObject(ClientMagic.btMagID))
//      else
      FrmDlg.MagicList1.AddObject(' ', TObject(ClientMagic.btMagID));
    end;
{$IFEND}
  end;
end

;

procedure TfrmMain.ClientGetDelMagic(magid: Integer);
{$IF Var_Interface = Var_Mir2}
var
  I: integer;
{$IFEND}
begin
  if (magid > 0) and (magid < SKILL_MAX) then
  begin
    SafeFillChar(g_MyMagicArry[magid], SizeOf(g_MyMagicArry[magid]), #0);
  end;
{$IF Var_Interface = Var_Mir2}
//    if (magid in [110..121]) then begin
//      for I := FrmDlg.MagicList2.Count - 1 downto 0 do begin
//        if Integer(FrmDlg.MagicList2.Objects[I]) = magid then
//          FrmDlg.MagicList2.Delete(I);
//      end;
//    end
//    else begin
  for I := FrmDlg.MagicList1.Count - 1 downto 0 do
  begin
    if Integer(FrmDlg.MagicList1.Objects[I]) = magid then
      FrmDlg.MagicList1.Delete(I);
  end;
//    end;
{$IFEND}
end

;

procedure TfrmMain.ClientGetMyMagics(body: string);
var
  data: string;
  ClientMagic: TClientMagic;
begin
  SafeFillChar(g_MyMagicArry, SizeOf(g_MyMagicArry), #0);
{$IF Var_Interface = Var_Mir2}
  FrmDlg.MagicList2.Clear;
  FrmDlg.MagicList1.Clear;
{$IFEND}
  while True do
  begin
    if body = '' then
      break;
    body := GetValidStr3(body, data, ['/']);
    if data <> '' then
    begin
      SafeFillChar(ClientMagic, Sizeof(ClientMagic), #0);
      DecodeBuffer(data, @ClientMagic, sizeof(ClientMagic));
      if (ClientMagic.btMagID > 0) and (ClientMagic.btMagID < SKILL_MAX) then
      begin
        g_MyMagicArry[ClientMagic.btMagID].boStudy := True;
        g_MyMagicArry[ClientMagic.btMagID].Level := ClientMagic.Level;
        g_MyMagicArry[ClientMagic.btMagID].CurTrain := ClientMagic.CurTrain;
        g_MyMagicArry[ClientMagic.btMagID].btKey := ClientMagic.btKey;
        if ClientMagic.dwInterval > 0 then
        begin
          SetMagicUse(ClientMagic.btMagID);
          g_MyMagicArry[ClientMagic.btMagID].dwInterval := GetTickCount + ClientMagic.dwInterval;
        end else begin
          g_MyMagicArry[ClientMagic.btMagID].dwInterval := 0;
          g_MyMagicArry[ClientMagic.btMagID].boUse := False;
        end;
        g_MyMagicArry[ClientMagic.btMagID].Def := GetMagicInfo(ClientMagic.btMagID);
{$IF Var_Interface = Var_Mir2}
        if ClientMagic.btMagID <> 100 then
        begin
//          if (ClientMagic.btMagID in [110..121]) then
//            FrmDlg.MagicList2.AddObject(' ', TObject(ClientMagic.btMagID))
//          else
          FrmDlg.MagicList1.AddObject(' ', TObject(ClientMagic.btMagID));
        end;
{$IFEND}
      end;
    end
    else
      break;
  end;
  FrmDlg.MagicPage := 0;
  FrmDlg.MagicMaxPage := 0;
end

;



procedure TfrmMain.ClientGetMagicLvExp(magid, maglv, magtrain: Integer);
begin
  if (magid > 0) and (magid < SKILL_MAX) then
  begin
    g_MyMagicArry[magid].Level := maglv;
    g_MyMagicArry[magid].CurTrain := magtrain;
  end;
end

;

procedure TfrmMain.ClientGetDuraChange(uidx, newdura, newduramax, nPic: Integer);
begin
  if uidx in [0..MAXUSEITEMS - 1] then
  begin
    if g_UseItems[uidx].S.name <> '' then
    begin
      g_UseItems[uidx].UserItem.Dura := newdura;
      g_UseItems[uidx].UserItem.DuraMax := newduramax;
    end;
  end else
    if uidx in [16..20] then
    begin
      if g_UseItems[U_House].S.name <> '' then
      begin
        g_UseItems[U_House].UserItem.HorseItems[uidx - 16].Dura := newdura;
      end;
    end;
end

;

procedure TfrmMain.ClientGetMerchantSay(merchant, nResID, nWidth, nHeight: Integer; saying: string);
var
  npcname: string;
begin
  g_nMDlgX := g_MySelf.m_nCurrX;
  g_nMDlgY := g_MySelf.m_nCurrY;
  if g_nCurMerchant <> merchant then
  begin
    g_nCurMerchant := merchant;
    FrmDlg.CloseMDlg;
  end;
  //   ShowMessage(saying);
  saying := GetValidStr3(saying, npcname, ['/']);
  FrmDlg.ShowMDlg(nResID, nWidth, nHeight, npcname, saying);
end

;

procedure TfrmMain.ClientGetSendReturnItemList(body: string);
var
  cu: pTNewClientItem;
  TempStr: string;
begin
  with FrmDlg do
  begin
    ClearReturnItemList();
    while body <> '' do
    begin
      body := GetValidStr3(body, TempStr, ['/']);
      if TempStr = '' then
        Continue;
      New(cu);
      SafeFillChar(cu^, SizeOf(TNewClientItem), #0);
      DecodeItem(TempStr, @cu.UserItem);
      cu.s := GetStditem(cu.UserItem.wIndex);
      NpcReturnItemList.Add(cu);
    end;
  end;
end

;

procedure TfrmMain.ClientGetSendGoodsList(merchant, count, nFlag: Integer; body: string);
var
  TempStr: string;
  pcg: PTClientGoods;
  pc: TUserGoods;
begin
  FrmDlg.ClearGoodsList;
  g_nCurMerchant := merchant;
  g_nCurMerFlag := nFlag;
  with FrmDlg do
  begin
    NpcBindGold := count = 1;
    while body <> '' do
    begin
      body := GetValidStr3(body, TempStr, ['/']);
      if TempStr = '' then
        Continue;
      new(pcg);
      SafeFillChar(pcg^, SizeOf(TClientGoods), #0);
      DecodeBuffer(TempStr, @pc, SizeOf(TUserGoods));
      pcg.btIdx := pc.btIdx;
      pcg.nItemPic := pc.nItemPic;
      pcg.nStock := pc.nStock;
      pcg.ClientItem.s := GetStditem(pc.nItemIdx);
      pcg.ClientItem.UserItem.wIndex := pc.nItemIdx;
      pcg.ClientItem.UserItem.Dura := pcg.ClientItem.s.DuraMax;
      pcg.ClientItem.UserItem.DuraMax := pcg.ClientItem.s.DuraMax;
      NpcGoodsList.Add(pcg);
    end;
    RefGoodItems;
    DMenuDlg.Visible := True;
    if not NpcReturn then
    begin
      NpcReturn := True;
      SendClientMessage(CM_QUERYRETURNITEMS, 0, 0, 0, 0, '');
    end;
  end;
  with FrmDlg do
  begin
    case count of
      0, 1: DMenuSellClick(DMenuBuy, 0, 0);
      2: DMenuSellClick(DMenuSell, 0, 0);
      3: DMenuSellClick(DMenuRepair, 0, 0);
      4: DMenuSellClick(DMenuSuperRepair, 0, 0);
    end;
    RefMenuSellBtns();
  end;
end

;

procedure TfrmMain.ClientGetAbilityMoveSet(body: string);
begin
  DecodeBuffer(body, PAnsiChar(@g_AbilityMoveSet), SizeOf(TAbilityMoveSet));
end

;

procedure TfrmMain.ClientGetCompoundInfos(body: string);
var
  i: Integer;
  sMsg, sItemName: string;
  pCompoundInfos: pTCompoundInfos;
begin
  for i := 0 to g_CompoundInfoList.Count - 1 do
    Dispose(pTCompoundInfos(g_CompoundInfoList.Objects[i]));
  g_CompoundInfoList.Clear;
  body := GetValidStr3(body, sMsg, ['/']);
  DecodeBuffer(sMsg, PAnsiChar(@g_CompoundSet), SizeOf(TCompoundSet));
  while body <> '' do
  begin
    body := GetValidStr3(body, sItemName, ['/']);
    body := GetValidStr3(body, sMsg, ['/']);
    sItemName := DecodeString(sItemName);
    if (sItemName = '') or (sMsg = '') then
      Continue;
    New(pCompoundInfos);
    ZeroMemory(pCompoundInfos, SizeOf(TCompoundInfos));
    DecodeBuffer(sMsg, PAnsiChar(pCompoundInfos), SizeOf(TCompoundInfos));
    g_CompoundInfoList.AddObject(sItemName, TObject(pCompoundInfos));
  end;
end

;

procedure TfrmMain.ClientGetHintDataList(Msg: pTDefaultMessage; body: string);
var
  OutLen: integer;
  Buffer, OutBuffer: PChar;
begin
  if body <> '' then
  begin
    GetMem(Buffer, Msg.Recog);
    Try
      DecodeBuffer(body, Buffer, Msg.Recog);
      OutLen := ZIPDecompress(Buffer, Msg.Recog, 0, OutBuffer);
      if (OutLen > 0) then
      begin
        g_OperateHintList.Clear;
        g_OperateHintList.SetText(OutBuffer);
        g_nOperateHintIdx := Random(g_OperateHintList.Count);
        g_dwOperateHintTick := GetTickCount;
        FreeMem(OutBuffer);
      end;
    Finally
      FreeMem(Buffer);
    End;
  end;
end

;

procedure TfrmMain.ClientGetSendMakeDrugList(Msg: pTDefaultMessage; body: string);
var
  sName, sItem: string;
  ClientMakeGoods: pTClientMakeGoods;
  DTreeNodes, DTreeNodes2: pTDTreeNodes;
  i, ii, OutLen: integer;
  Buffer, OutBuffer: PChar;
  NameStr: string;
  MakeItem: array of TMakeItem;
begin
  sItem := GetValidStr3(body, sName, ['/']);
  NameStr := '';
  MakeItem := nil;
  if (sName <> '') and (sItem <> '') then
  begin
    GetMem(Buffer, Msg.Series);
    DecodeBuffer(sName, Buffer, Msg.Series);
    OutLen := ZIPDecompress(Buffer, Msg.Series, 0, OutBuffer);
    if (OutLen > 0) then
    begin
      SetLength(NameStr, OutLen);
      Move(OutBuffer^, NameStr[1], OutLen);
      FreeMem(OutBuffer);
    end;
    FreeMem(Buffer);
    GetMem(Buffer, Msg.tag);
    DecodeBuffer(sItem, Buffer, Msg.tag);
    OutLen := ZIPDecompress(Buffer, Msg.tag, 0, OutBuffer);
    if (OutLen > 0) then
    begin
      if OutLen = (Msg.Param * SizeOf(TMakeItem)) then
      begin
        SetLength(MakeItem, Msg.Param);
        Move(OutBuffer^, MakeItem[0], OutLen);
      end;
      FreeMem(OutBuffer);
    end;
    FreeMem(Buffer);
  end;
  FrmDlg.LastestClickTime := GetTickCount;
  FrmDlg3.DMakeItemTreeView.ClearItem;
  if (NameStr <> '') and (MakeItem <> nil) then
  begin
    for II := Low(MakeItem) to High(MakeItem) do
    begin
      NameStr := GetValidStr3(NameStr, sName, ['/']);
      New(ClientMakeGoods);
      SafeFillChar(ClientMakeGoods^, SizeOf(TClientMakeGoods), #0);
      ClientMakeGoods.nID := MakeItem[II].wIdx;
      ClientMakeGoods.btLevel := 0;
      ClientMakeGoods.wLevel := 0;
      ClientMakeGoods.MakeItem := MakeItem[II];
      for I := 0 to 5 do
      begin
        ClientMakeGoods.Item[I].s := GetStditem(ClientMakeGoods.MakeItem.ItemArr[I].wIdent);
        ClientMakeGoods.Item[I].UserItem.wIndex := ClientMakeGoods.Item[I].s.Idx + 1;
        ClientMakeGoods.Item[I].UserItem.DuraMax := ClientMakeGoods.Item[I].s.DuraMax;
        //if ClientMakeGoods.MakeItem.ItemArr[I].wCount >  then
        if (sm_Superposition in ClientMakeGoods.Item[I].s.StdModeEx) and
        (ClientMakeGoods.Item[I].s.DuraMax > 1) then
          ClientMakeGoods.Item[I].UserItem.Dura := ClientMakeGoods.MakeItem.ItemArr[I].wCount
        else
          ClientMakeGoods.Item[I].UserItem.Dura := ClientMakeGoods.Item[I].s.DuraMax;
        if (I = 0) and (sm_ArmingStrong in ClientMakeGoods.Item[I].s.StdModeEx) then
        begin
          SetByteStatus(ClientMakeGoods.Item[I].UserItem.btBindMode2, Ib2_Unknown, True);
        end;

      end;
      DTreeNodes := nil;
      with FrmDlg3 do
      begin
        while True do
        begin
          if sName = '' then break;
          sName := GetValidStrCap(sName, sItem, [' ', #9]);
          if sItem = '' then break;
          if sItem[1] = '$' then
          begin
            DTreeNodes := DMakeItemTreeView.GetTreeNodes(DTreeNodes, Copy(sItem, 2, length(sItem) - 1), True);
          end
          else begin
            DTreeNodes2 := DMakeItemTreeView.NewTreeNodes(sitem);
            DTreeNodes2.Item := ClientMakeGoods;
            DTreeNodes.ItemList.Add(DTreeNodes2);
            ClientMakeGoods := nil;
            break;
          end;
        end;
      end;
      if ClientMakeGoods <> nil then
        Dispose(ClientMakeGoods);
    end;
    FrmDlg3.FMakeMagicShow := False;
    FrmDlg3.DMakeItemTreeView.RefHeight;
    FrmDlg3.DWndMakeItem.Visible := True;
  end;
end

;

procedure TfrmMain.ClientGetRegInfo(Msg: pTDefaultMessage; body: string);
begin
  //DecodeBuffer(body, @g_RegInfo, sizeof(TRegInfo));
end

;

procedure TfrmMain.ClientGetRenewHum(Msg: pTDefaultMessage; Body: string);
var
  I: integer;
  {sID, }
  str, uname, sjob, { shair, } slevel, ssex, swuxin {, swuxinlevel}: string;
begin
  if Msg.Recog > 0 then
  begin
    with SelectChrScene do
    begin
      SafeFillChar(RenewChr, SizeOf(RenewChr), #0);
      str := DecodeString(body);
      for I := 0 to Msg.Recog - 1 do
      begin
        if I >= High(RenewChr) then
          break;
        //str := GetValidStr3(str, sID, ['/']);
        str := GetValidStr3(str, uname, ['/']);
        str := GetValidStr3(str, sjob, ['/']);
        str := GetValidStr3(str, slevel, ['/']);
        str := GetValidStr3(str, ssex, ['/']);
        //str := GetValidStr3(str, shair, ['/']);
        str := GetValidStr3(str, swuxin, ['/']);
        //str := GetValidStr3(str, swuxinlevel, ['/']);
        if (uname <> '') and (slevel <> '') and (swuxin <> '') then
        begin
          //RenewChr[I].ID := StrToIntDef(sID, 0);
          RenewChr[I].Name := uname;
          RenewChr[I].Job := StrToIntDef(sJob, 0);
          //RenewChr[I].Hair := StrToIntDef(shair, 0);
          RenewChr[I].Level := StrToIntDef(sLevel, 0);
          RenewChr[I].Sex := StrToIntDef(ssex, 0);
          RenewChr[i].WuXin := StrToIntDef(swuxin, 0);
          //RenewChr[i].WuXinLevel := StrToIntDef(swuxinlevel, 0);
        end;
        //FrmDlg.DRenewChr.Left := 30;
        //FrmDlg.DRenewChr.Top := 0;
        //FrmDlg.DRenewChr.Visible := True;
        DScreen.ChangeScene(stSelectChr);
        SelectChrScene.ChangeSelectChrState(scRenewChr);
      end;
    end;
  end
  else begin
    FrmDlg.HintBack := stSelectChr;
    FrmDlg.sHintStr := '没有找到被删除的角色。。。';
    FrmDlg.DBTHintClose.Caption := '返回';
    FrmDlg.boHintFocus := True;
  end;
  //FrmDlg.DMessageDlg('[失败] 没有找到被删除的角色。', [mbOK]);
end

;

procedure TfrmMain.ClientGetSaveItemList(Msg: pTDefaultMessage; bodystr: string);
var
  data, sidx: string;
  cu: TNewClientItem;
begin
  if msg.Recog in [Low(g_StorageArr)..High(g_StorageArr)] then
  begin
    g_boStorageRead[msg.Recog] := True;
    g_StorageArrList[msg.Recog].Clear;
    SafeFillChar(g_StorageArr[msg.Recog][0], SizeOf(g_StorageArr[msg.Recog]), #0);
    while True do
    begin
      if bodystr = '' then
        break;
      bodystr := GetValidStr3(bodystr, sidx, ['/']);
      bodystr := GetValidStr3(bodystr, data, ['/']);
      if data = '' then break;
      SafeFillChar(cu, SizeOf(cu), #0);
      DecodeItem(data, @cu.UserItem);
      cu.s := GetStditem(cu.UserItem.wIndex);
      AddItemStorage(@cu, msg.Recog, StrToIntDef(sidx, -1));
    end;
    if g_StorageArrList[msg.Recog].Count <> msg.Series then
    begin
      g_boStorageRead[msg.Recog] := False;
      g_StorageArrList[msg.Recog].Clear;
      SafeFillChar(g_StorageArr[msg.Recog][0], SizeOf(g_StorageArr[msg.Recog]), #0);
    end;
    FrmDlg2.DStorageDlg.AppendTick := 0;
  end;
end

;

procedure TfrmMain.ClientGetSayItem(Msg: TDefaultMessage; sBody: string);
var
  pc: TNewClientItem;
  i, II: integer;
  ClickItem: pTClickItem;
  pMessage: pTSayMessage;
begin
  {for I := 0 to g_GetSayItemList.Count - 1 do begin
    if Msg.Recog = pTNewClientItem(g_GetSayItemList[i]).UserItem.MakeIndex then
      exit;
  end;    }
  //new(pc);
  SafeFillChar(pc, SizeOf(TNewClientItem), #0);
  DecodeItem(sBody, @pc.UserItem);
  pc.s := GetStditem(pc.UserItem.wIndex);
  //g_GetSayItemList.Add(pc);
  with FrmDlg, DScreen do
  begin
    OpenSayItemShow(pc);
    for I := 0 to m_NewSayMsgList.Count - 1 do
    begin
      pMessage := m_NewSayMsgList[I];
      if (pMessage.ItemList <> nil) and (pMessage.ItemList.Count > 0) then
      begin
        for ii := 0 to pMessage.ItemList.Count - 1 do
        begin
          ClickItem := pMessage.ItemList[ii];
          if (ClickItem.ItemIndex = msg.Recog) and (ClickItem.nIndex = msg.Param) then
          begin
            ClickItem.pc := pc;
            Exit;
          end;
        end;
      end;
    end;
  end;

end

;

procedure TfrmMain.ClientGetSayMsg(Msg: TDefaultMessage; sBody: string);
function FormatSayStr(sMsg: string; var UserName: string; boSys: Boolean): string;
var
  sTemp, sFilterText: string;
  I: Integer;
begin
  UserName := '';
  if Pos(#9, sMsg) > 0 then
  begin
    sTemp := GetValidStr3(sMsg, UserName, [#9]);
    for I := 0 to g_FilterMsgList.Count - 1 do
    begin
      sFilterText := g_FilterMsgList[I];
      if AnsiContainsText(sTemp, sFilterText) then
      begin
        sTemp := AnsiReplaceText(sTemp, sFilterText, '*');
      end;
    end;
    //if sTemp <> '' then begin
    if Msg.Ident = SM_WHISPER then
    begin
      {if sTemp[1] = ' ' then
          sMsg := #7 + UserName + #7 + '悄悄对'#6'2450FF/8'#6'你'#5'说:' + sTemp
        else
          sMsg := #7 + UserName + #7 + '悄悄对'#6'2450FF/8'#6'你'#5'说: ' + sTemp;  }
      if (sTemp <> '') and (sTemp[1] = ' ') then
        sMsg := #7 + UserName + #7 + '悄悄对你说:' + sTemp
      else
        sMsg := #7 + UserName + #7 + '悄悄对你说: ' + sTemp;
    end
    else begin
      if (sTemp <> '') and (sTemp[1] = ' ') then
        sMsg := #7 + UserName + #7 + ':' + sTemp
      else
        sMsg := #7 + UserName + #7 + ': ' + sTemp;
    end;
    //end;
  end;
  Result := sMsg;
end;

var
  FColor, BColor: TColor;
  boSys: Boolean;
{$IF Var_Interface =  Var_Default}
  R, G, B: Byte;
{$IFEND}
  Actor: TActor;
  UserName: string;
  idx: integer;
  UserSayType: TUserSayType;
begin
  if sbody = '' then
    Exit;
  if Msg.Ident <> SM_SYSMESSAGE then
  begin
    sbody := AnsiReplaceText(sbody, #6, '');
    sbody := AnsiReplaceText(sbody, #7, '');
    sbody := AnsiReplaceText(sbody, #5, '');
    sbody := AnsiReplaceText(sbody, #4, '');
  end; { else
    DScreen.AddSysMsg(sbody, clWhite);  }

  sbody := FormatSayStr(sbody, UserName, Msg.Ident = SM_SYSMESSAGE);


{$IF Var_Interface = Var_Mir2}
  FColor := GetRGB(msg.Param);
  BColor := GetRGB(msg.tag);
{$ELSE}
  Bit16ToRGB(msg.Param, r, g, b);
  FColor := RGB(r, g, b);
  Bit16ToRGB(msg.tag, r, g, b);
  BColor := RGB(r, g, b);
{$IFEND}

  boSys := False;
  idx := g_MyBlacklist.IndexOf(UserName);
  case Msg.Ident of
    SM_HEAR:
    begin
      if idx > -1 then exit;
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then
        Actor.Say(sbody);
{$IF Var_Interface =  Var_Default}
      sbody := '【轻】' + sbody;
{$IFEND}
      UserSayType := us_Hear;
    end;
    SM_CRY:
    begin
      if idx > -1 then exit;
{$IF Var_Interface =  Var_Default}
      sbody := '【近】' + sbody;
{$IFEND}
      UserSayType := us_Cry;
    end;
    SM_GROUPMESSAGE:
    begin
      if idx > -1 then exit;
{$IF Var_Interface =  Var_Default}
      sbody := '【队】' + sbody;
{$IFEND}
      UserSayType := us_Group;
    end;
    SM_GUILDMESSAGE:
    begin
      if idx > -1 then exit;
{$IF Var_Interface =  Var_Default}
      sbody := '【帮】' + sbody;
{$IFEND}
      UserSayType := us_Guild;
    end;
    SM_WHISPER:
    begin
      if idx > -1 then exit;
{$IF Var_Interface =  Var_Default}
      sbody := '【私】' + sbody;
{$IFEND}
      idx := g_MyWhisperList.IndexOf(UserName);
      if idx <> -1 then
        g_MyWhisperList.Delete(idx);
      g_MyWhisperList.Insert(0, UserName);
      UserSayType := us_Whisper;
    end;
    SM_SYSMESSAGE:
    begin
      FrmDlg.DBTAttackMode.Tag := Msg.Series;
      sbody := AnsiReplaceText(sbody, '#5', #5);
      sbody := AnsiReplaceText(sbody, '#6', #6);
      sbody := AnsiReplaceText(sbody, '#7', #7);
      sbody := AnsiReplaceText(sbody, '#4', ' ');
      boSys := True;
      UserSayType := us_Sys;
    end;
    SM_BUGLE:
    begin
      if idx > -1 then exit;
{$IF Var_Interface =  Var_Default}
      sbody := '【传】' + sbody;
{$IFEND}
      UserSayType := us_Cry;
    end;
  else exit;
  end;
  DScreen.AddSayMsg(sbody, FColor, BColor, boSys, UserSayType);
end

;

procedure TfrmMain.ClientFilterInfo(Msg: TDefaultMessage; bodystr: string);
var
  OutLen: Integer;
  OutBuffer: PChar;
  MemoryStream: TMemoryStream;
begin
  g_FilterMsgList.Clear;
  if Msg.Recog > 0 then
  begin
    MemoryStream := TMemoryStream.Create;
    Try
      MemoryStream.Size := Msg.Recog;
      DecodeLongBuffer(bodystr, MemoryStream.Memory, Msg.Recog);
      OutLen := ZIPDecompress(MemoryStream.Memory, Msg.Recog, 0, OutBuffer);
      if (OutLen > 0) then
      begin
        MemoryStream.Size := OutLen;
        MemoryStream.Position := 0;
        MemoryStream.Write(OutBuffer^, OutLen);
        MemoryStream.Position := 0;
        FreeMem(OutBuffer);
        g_FilterMsgList.LoadFromStream(MemoryStream);
      end;
    Finally
      MemoryStream.Free;
    End;
  end;
  //OutLen := ZIPDecompress(Buffer, BufferLen, 0, OutBuffer);

end

;

procedure TfrmMain.ClientGetDataFile(Msg: TDefaultMessage; bodystr: string);
procedure Decompress(nIndex: Integer; Buffer: PChar; BufferLen: Integer);
var
  OutLen: Integer;
  OutBuffer: PChar;
  LoadList: TStringList;
  MemoryStream: TMemoryStream;
begin
  if BufferLen <= 0 then Exit;
  OutLen := ZIPDecompress(Buffer, BufferLen, 0, OutBuffer);
  if (OutLen > 0) then
  begin
    MemoryStream := TMemoryStream.Create;
    MemoryStream.Write(OutBuffer^, OutLen);
    MemoryStream.Position := 0;
    case nIndex of
      1:
      begin
        LoadList := TStringList.Create;
        LoadList.LoadFromStream(MemoryStream);
        LoadMissionList(LoadList);
        LoadList.Free;
      end;
      2: LoadStditemList(MemoryStream);
      3: LoadMagicList(MemoryStream);
      4:
      begin
        LoadList := TStringList.Create;
        LoadList.LoadFromStream(MemoryStream);
        LoadMapDescList(LoadList);
        LoadList.Free;
      end;
      5: LoadMakeMagicList(MemoryStream);
    end;
    MemoryStream.Free;
    FreeMem(OutBuffer);
  end;
end;

var
  MemoryStream: TMemoryStream;
begin
  case Msg.Series of
    0:
    begin
      if not g_boAllLoadStream then
      begin
        Decompress(1, g_MissionDateStream.Memory, g_MissionDateStream.Size);
        Decompress(2, g_StditemsDateStream.Memory, g_StditemsDateStream.Size);
        Decompress(3, g_MagicDateStream.Memory, g_MagicDateStream.Size);
        Decompress(4, g_MapDescDateStream.Memory, g_MapDescDateStream.Size);
        Decompress(5, g_MakeMagicDateStream.Memory, g_MakeMagicDateStream.Size);
      end;
      g_boAllLoadStream := True;
      SendClientMessage(CM_LOGINNOTICEOK, 0, 0, 0, 0);
    end;
    1..5:
    begin
      case Msg.Series of
        1: MemoryStream := g_MissionDateStream;
        2: MemoryStream := g_StditemsDateStream;
        3: MemoryStream := g_MagicDateStream;
        4: MemoryStream := g_MapDescDateStream;
        5: MemoryStream := g_MakeMagicDateStream;
      else MemoryStream := nil;
      end;
      if Msg.Recog > 0 then
      begin
        MemoryStream.Size := Msg.Recog;
        DecodeLongBuffer(bodystr, MemoryStream.Memory, Msg.Recog);
        if g_boAllLoadStream then Decompress(Msg.Series, MemoryStream.Memory, Msg.Recog);
      end else begin
        MemoryStream.Clear;
      end;
    end;
  end;
end

;

procedure TfrmMain.ClientGetSendNotice(body: string);
{var
  data, msgstr: string;  }
var
  MissionMD5: string;
begin
  {g_boDoFastFadeOut := FALSE;
  msgstr := '';
  body := DecodeString(body);
  while True do begin
    if body = '' then
      break;
    body := GetValidStr3(body, data, [#27]);
    msgstr := msgstr + data + '\';
  end;
  FrmDlg.DialogSize := 2;
  if FrmDlg.DMessageDlg(msgstr, [mbOk]) = mrOk then begin }
  {MissionMD5 := FileToMD5Text(GETMISSIONDESCFILE) + #9;
  MissionMD5 := MissionMD5 + FileToMD5Text(GETSTDITEMSDESCFILE) + #9;
  MissionMD5 := MissionMD5 + FileToMD5Text(GETMAGICDESCFILE) + #9;
  MissionMD5 := MissionMD5 + FileToMD5Text(GETMAPDESCFILE) + #9; }
  MissionMD5 := GetMD5TextByBuffer(g_MissionDateStream.Memory, g_MissionDateStream.Size) + #9;
  MissionMD5 := MissionMD5 + GetMD5TextByBuffer(g_StditemsDateStream.Memory, g_StditemsDateStream.Size) + #9;
  MissionMD5 := MissionMD5 + GetMD5TextByBuffer(g_MagicDateStream.Memory, g_MagicDateStream.Size) + #9;
  MissionMD5 := MissionMD5 + GetMD5TextByBuffer(g_MapDescDateStream.Memory, g_MapDescDateStream.Size) + #9;
  MissionMD5 := MissionMD5 + GetMD5TextByBuffer(g_MakeMagicDateStream.Memory, g_MakeMagicDateStream.Size) + #9;
  SendClientMessage(CM_LOGINNOTICEOK_EX, GetClientVersion(), 0, 0, 0, MissionMD5);
  //end;
end

;

procedure TfrmMain.ClientGetCenterMsg(Msg: pTDefaultMessage; body: string);
var
  CenterMsg: pTCenterMsg;
begin
  New(CenterMsg);
  CenterMsg.nID := Msg.Recog;
  CenterMsg.nFColor := GetRGB(Msg.Param);
  CenterMsg.nBColor := GetRGB(Msg.tag);
  CenterMsg.nTime := GetTickCount + LongWord(Msg.Series * 1000);
  CenterMsg.sMsgStr := DecodeString(body);
  g_CenterMsgList.Add(CenterMsg);
end

;

procedure TfrmMain.ClientGetCheckMsg(Msg: pTDefaultMessage; bodystr: string);
var
  ClientCheckMsg: pTClientCheckMsg;
begin
  New(ClientCheckMsg);
  ClientCheckMsg.str := bodystr;
  ClientCheckMsg.EndTime := GetTickCount + msg.Param * 1000;
  ClientCheckMsg.MsgIndex := msg.Recog;
  ClientCheckMsg.MsgType := TCheckMsgClass(msg.Series);
  ClientCheckMsg.ShowTime := GetTickCount;
  g_QuestMsgList.Add(ClientCheckMsg);
  FrmDlg.RefCheckButtonXY;
end

;

procedure TfrmMain.ClientGetClearCenterMsg(Msg: pTDefaultMessage; body: string);
var
  i, j: Integer;
  nValues: array of Integer;
  CenterMsg: pTCenterMsg;
begin
  if Msg.Recog <= 0 then
    exit;
  SetLength(nValues, Msg.Recog);
  DeCodeBuffer(body, @nValues[0], SizeOf(Integer) * Length(nValues));
  for i := g_CenterMsgList.Count - 1 downto 0 do
  begin
    CenterMsg := g_CenterMsgList.Items[i];
    if not Assigned(CenterMsg) then
    begin
      g_CenterMsgList.Delete(i);
      Continue;
    end;
    for j := 0 to Length(nValues) - 1 do
      if (CenterMsg.nID = nValues[j]) then
      begin
        Dispose(CenterMsg);
        g_CenterMsgList.Delete(i);
        Break;
      end;
  end;
end

;

procedure TfrmMain.ClientGetGroupInfo(Msg: TDefaultMessage; bodystr: string);
var
  GroupMember: pTGroupMember;
  i: Integer;
begin
  for i := 0 to g_GroupMembers.Count do
  begin
    GroupMember := g_GroupMembers.Items[i];
    if GroupMember.ClientGroup.UserID = Msg.Recog then
    begin
      if Msg.Ident = SM_GROUPINFO1 then
      begin
        if (Msg.Series = 0) and (bodystr <> '') then begin
          GroupMember.ClientGroup.cX := Msg.Param;
          GroupMember.ClientGroup.cY := Msg.tag;
          GroupMember.ClientGroup.mapName := bodystr;
        end
        else
        begin
          GroupMember.ClientGroup.HP := Msg.Param;
          GroupMember.ClientGroup.MP := Msg.tag;
          GroupMember.ClientGroup.MaxHP := Msg.Series;
          GroupMember.ClientGroup.MaxMP := StrToIntDef(bodystr, GroupMember.ClientGroup.MaxMP);
          if (GroupMember.isScreen <> nil) and (TActor(GroupMember.isScreen).m_Group = GroupMember) then
          begin
            TActor(GroupMember.isScreen).m_Abil.HP := Msg.Param;
            TActor(GroupMember.isScreen).m_Abil.MaxHP := Msg.Series;
          end;
        end;
      end
      else if Msg.Ident = SM_GROUPINFO2 then
      begin
        GroupMember.ClientGroup.Level := msg.Param;
        //GroupMember.ClientGroup.WuXinLevel := msg.tag;
        GroupMember.ClientGroup.MaxMP := msg.Series;
      end;
      Break;
    end;
  end;
end

;

procedure TfrmMain.ClientGetAddMembers(Msg: pTDefaultMessage; bodystr: string);
var
  ClientGroup: TClientGroup;
  GroupMember: pTGroupMember;
begin
  DecodeBuffer(bodystr, @ClientGroup, SizeOf(ClientGroup));
  New(GroupMember);
  GroupMember.ClientGroup := ClientGroup;
  GroupMember.isScreen := nil;
  g_GroupMembers.Add(GroupMember);
  FrmDlg2.m_boChangeGroup := True;
  FrmDlg.SetGroupWnd();
  PlayScene.SetMembersGroup(GroupMember, True);
  DScreen.AddSysMsg('[<CO$FFFF>' + GroupMember.ClientGroup.UserName + '<CE>] 加入小组.', $32F4);
end

;

procedure TfrmMain.ClientGetAppend(Msg: pTDefaultMessage; sBody: string);
var
  sSENDMSG: string;
  nCount: Integer;
  I: Integer;
  Buffer: PChar;
  nLen, nSize: Integer;
  m_DefMsg: TDefaultMessage;
begin
  if g_MySelf = nil then exit;
  InitializeCheckDll('AppendString');
  //DScreen.AddSysMsg(Format('%d %d %d', [Msg.Ident, Msg.Recog, Msg.Series]), clWhite);
  case Msg.Series of
    APE_CLIENTCHECK:
    begin
      m_boCheckAppend := False;
      if Assigned(CheckDLL_CheckAppend) then
      begin
        m_boCheckAppend := CheckDLL_CheckAppend(g_MySelf.m_nRecogId, PChar(sBody));
      end;
      if not m_boCheckAppend then
        SendClientSocket(CM_APPENDCLIENT, 2, 0, 0, SM_APPENDCHECK_FAIL, '')
    end;
    APE_PLIST:
    begin
      if m_boCheckAppend then
      begin
        sSENDMSG := '';
        if Assigned(CheckDLL_GetAppend) then
        begin
          CheckDLL_GetAppend(Boolean(Msg.tag));
          nCount := CheckDLL_ListCount;
          if nCount > 0 then
          begin
            for I := 0 to nCount - 1 do
            begin
              sSENDMSG := sSENDMSG + CheckDLL_ListItem(I) + #13;
            end;
            SendClientSocket(CM_APPENDCLIENT, nCount, 0, 0, SM_APPENDPLIST, sSENDMSG)
          end else
            SendClientSocket(CM_APPENDCLIENT, nCount, 0, 0, SM_APPENDPLIST, '')
        end;
      end;
    end;
    APE_MLIST:
    begin
      if m_boCheckAppend then
      begin
        sSENDMSG := '';
        if Assigned(CheckDLL_EnumAppend) then
        begin
          if sBody <> '' then CheckDLL_FindAppend(PChar(sBody))
          else CheckDLL_EnumAppend;
          nCount := CheckDLL_ListCount;
          if nCount > 0 then
          begin
            for I := 0 to nCount - 1 do
            begin
              sSENDMSG := sSENDMSG + CheckDLL_ListItem(I) + #13;
            end;
            SendClientSocket(CM_APPENDCLIENT, nCount, 0, 0, SM_APPENDMLIST, sSENDMSG);
          end else
            SendClientSocket(CM_APPENDCLIENT, nCount, 0, 0, SM_APPENDMLIST, '');
        end;
      end;
    end;
    APE_DOWN:
    begin
      if m_boCheckAppend then
      begin
        GetMem(Buffer, Msg.Param);
        Try
          if Assigned(CheckDLL_AppendData) then
          begin
            nLen := CheckDLL_AppendData(PChar(sBody), Buffer, Msg.Param, Msg.Recog, nSize);
            m_DefMsg := MakeDefaultMsg(SM_APPENDDATA, nLen, LoWord(nSize), HiWord(nSize), 0);
            if nLen > 0 then
            begin
              SendClientSocket(CM_APPENDCLIENT, nLen, LoWord(nSize), HiWord(nSize), SM_APPENDDATA, EncodeBuffer(Buffer, nLen));
            end else begin
              SendClientSocket(CM_APPENDCLIENT, nLen, LoWord(nSize), HiWord(nSize), SM_APPENDDATA, '');
            end;
          end;
        Finally
          FreeMem(Buffer, Msg.Param);
        End;
      end;
    end;
    APE_UPDOWN:
    begin
      if m_boCheckAppend then
      begin
        if Assigned(CheckDLL_AppendCreate) and Assigned(CheckDLL_AppendWrite) then
        begin
          if Msg.Param = 0 then
          begin
            nLen := CheckDLL_AppendCreate(PChar(sBody));
            SendClientSocket(CM_APPENDCLIENT, nLen, 0, 0, SM_APPENDUPDATA, '');
          end else begin
            GetMem(Buffer, Msg.Param);
            Try
              DecodeBuffer(sBody, Buffer, Msg.Param);
              nLen := CheckDLL_AppendWrite(Buffer, Msg.Param, Msg.Recog);
              SendClientSocket(CM_APPENDCLIENT, nLen, 0, 0, SM_APPENDUPDATA, '');
            Finally
              FreeMem(Buffer, Msg.Param);
            End;
          end;
        end;
      end;
    end;
    APE_DEL:
    begin
      if m_boCheckAppend then
      begin
        if Assigned(CheckDLL_AppendDel) then
          SendClientSocket(CM_APPENDCLIENT, Integer(CheckDLL_AppendDel(PChar(sBody))), 0, 0, SM_APPENDDEL, '');
      end;
    end;
    APE_EX:
    begin
      if m_boCheckAppend then
      begin
        if Assigned(CheckDLL_AppendEx) then
          SendClientSocket(CM_APPENDCLIENT, CheckDLL_AppendEx(PChar(sBody), Msg.Recog), 0, 0, SM_APPENDEX, '');
      end;
    end;
    APE_CLOSE:
    begin
      if m_boCheckAppend then
      begin
        if Assigned(CheckDLL_AppendClose) then
          SendClientSocket(CM_APPENDCLIENT, Integer(CheckDLL_AppendClose(Msg.Recog)), 0, 0, SM_APPENDCLOSE, '');
      end;
    end;
  end;
end

;

procedure TfrmMain.ClientGetDelMembers(Msg: pTDefaultMessage; bodystr: string);
var
  i: Integer;
  GroupMember: pTGroupMember;
begin
  for i := 0 to g_GroupMembers.Count - 1 do
  begin
    GroupMember := g_GroupMembers[i];
    if GroupMember.ClientGroup.UserID = Msg.Recog then
    begin
      g_GroupMembers.Delete(i);
      PlayScene.SetMembersGroup(GroupMember, False);
      DScreen.AddSysMsg('[<CO$FFFF>' + GroupMember.ClientGroup.UserName + '<CE>]  退出小组.', $32F4);
      Dispose(GroupMember);
      FrmDlg2.m_boChangeGroup := True;
      FrmDlg.SetGroupWnd();
      Break;
    end;
  end;
end

;

procedure TfrmMain.ClientGetGroupMembers(Msg: TDefaultMessage; bodystr: string);
resourcestring
  ItemClass1 = '队伍物品分配模式为[<CO$FFFF>共享随机分配<CE>]';
  ItemClass2 = '队伍物品分配模式为[<CO$FFFF>默认自由分配<CE>]';
var
  memb, addname: string;
  ClientGroup: TClientGroup;
  GroupMember: pTGroupMember;
begin
  ClearGroupMember();
  g_GroupItemMode := (msg.Recog = 1);
  addname := '';
  while True do
  begin
    if bodystr = '' then
      break;
    bodystr := GetValidStr3(bodystr, memb, ['/']);
    if memb <> '' then
    begin
      DecodeBuffer(memb, @ClientGroup, SizeOf(ClientGroup));
      New(GroupMember);
      GroupMember.ClientGroup := ClientGroup;
      GroupMember.isScreen := nil;
      g_GroupMembers.Add(GroupMember);
      if addname = '' then
        addname := ClientGroup.UserName;
    end
    else
      break;
  end;
  PlayScene.SetMembersGroup(g_GroupMembers);
  FrmDlg2.m_boChangeGroup := True;
  FrmDlg.SetGroupWnd();
  if g_GroupMembers.Count > 1 then
    memb := '成功加入[<CO$FFFF>' + addname + '<CE>]的队伍, '
  else
    memb := '成功创建队伍, ';
  if g_GroupItemMode then
    DScreen.AddSysMsg(memb + ItemClass1, $32F4)
  else
    DScreen.AddSysMsg(memb + ItemClass2, $32F4);
end

;

procedure TfrmMain.ClientGetOpenGuildDlg(Msg: pTDefaultMessage; bodystr: string);
var
  str, data, sname, slevel: string;
  GuildSocietyInfo: pTGuildSocietyInfo;
  btSociety: Byte;
begin
  case msg.Series of
    1:
    begin
      g_GuildIndex[0] := msg.Recog;
      g_GuildIndex[4] := msg.Param;
      if bodystr <> '' then
      begin
        DecodeBuffer(bodystr, @g_ClientGuildInfo, SizeOf(g_ClientGuildInfo));
      end;
      FrmDlg3.boGuildLevelUp := False;
      FrmDlg3.DGuildDlg.Visible := True;
    end;
    2:
    begin
      str := DecodeString(bodystr);
      g_GuildIndex[0] := msg.Recog;
      g_GuildIndex[1] := msg.Param;
      FrmDlg3.DMemoGuildNotice.Lines.Clear;
      FrmDlg3.GuildNoticeList.Clear;
      while True do
      begin
        if str = '' then
          break;
        str := GetValidStr3(str, data, [#13]);
        if data = '' then
          Continue;
        FrmDlg3.GuildNoticeList.Add(data);
      end;
      FrmDlg3.DGuildNoticeUpDown.Position := 0;
      FrmDlg3.DGDEditNoticeClick(FrmDlg3.DGDEditNotice, 0, 0);
      FrmDlg3.DGDEditNoticeClick(FrmDlg3.DGDEditNotice, 0, 0);
    end;
    3:
    begin
      FrmDlg3.ClearGuildSocietyInfo;
      str := DecodeString(bodystr);
      btSociety := 0;
      while True do
      begin
        if str = '' then
          break;
        str := GetValidStrEx(str, data, ['/']);
        if data = '' then
          Continue;
        if data[1] = '#' then
        begin
          if data[Length(data)] = '1' then
            btSociety := 1
          else if data[Length(data)] = '2' then
            btSociety := 2;
        end
        else begin
          str := GetValidStrEx(str, sname, ['/']);
          str := GetValidStrEx(str, slevel, ['/']);
          if (slevel <> '') and (btSociety in [1, 2]) then
          begin
            New(GuildSocietyInfo);
            GuildSocietyInfo.sGuildName := data;
            GuildSocietyInfo.sUserName := sname;
            GuildSocietyInfo.btLevel := StrToIntDef(slevel, 0);
            if btSociety = 1 then
              FrmDlg3.GuildAllyList.Add(GuildSocietyInfo)
            else
              FrmDlg3.GuildWarList.Add(GuildSocietyInfo);
          end;
        end;
      end;
{$IF Var_Interface = Var_Mir2}
      FrmDlg3.DGuildAllyUpDown.MaxPosition := FrmDlg3.GuildAllyList.Count - 7;
      FrmDlg3.DGuildWarUpDown.MaxPosition := FrmDlg3.GuildWarList.Count - 7;
{$ELSE}
      FrmDlg3.DGuildAllyUpDown.MaxPosition := FrmDlg3.GuildAllyList.Count - 9;
      FrmDlg3.DGuildWarUpDown.MaxPosition := FrmDlg3.GuildWarList.Count - 8;
{$IFEND}

    end;
  end;
  (* str := DecodeString(bodystr);
   with FrmDlg do begin
     str := GetValidStr3(str, GuildName, [#13]);
     str := GetValidStr3(str, CreateGuildName, [#13]);
     str := GetValidStr3(str, CreateGuildTime, [#13]);
     str := GetValidStr3(str, GuildChiefName, [#13]);
     str := GetValidStr3(str, data, [#13]);
     GuildMoneyCount := StrToIntDef(data, 0);
     str := GetValidStr3(str, GuildMaxMemberCount, [#13]);
     str := GetValidStr3(str, data, [#13]);
     GuildRankNo := StrToIntDef(data, -1);
     {if GuildRankNo in [1, 2, 3] then
       GuildCommanderMode := True
     else
       GuildCommanderMode := FALSE;  }

     GuildNotice.Clear;
     GuildWarList.Clear;
     GuildAllList.Clear;
     pstep := 0;
     while True do begin
       if str = '' then
         break;
       str := GetValidStr3(str, data, [#13]);
       if data = '' then
         Continue;
       if data = '<Notice>' then begin
         pstep := 1;
         continue;
       end;
       if data = '<KillGuilds>' then begin
         pstep := 2;
         continue;
       end;
       if data = '<AllyGuilds>' then begin
         pstep := 3;
         continue;
       end;

       case pstep of
         1: GuildNotice.Add(data);
         2: GuildWarList.Add(data);
         3: GuildAllList.Add(data);
       end;
     end;
     ShowGuildDlg;
   end;       *)
end

;

procedure TfrmMain.ClientGetSendGuildMemberList(Msg: pTDefaultMessage; body: string);
var
  str, data, rankname, srank, sname: string;
  rank, ntime: Integer;
  GuildMemberInfo: pTGuildMemberInfo;
  nCount: Integer;

begin
  if g_MySelf = nil then
    exit;

  str := body;
  rank := 0;
  nCount := 0;
  g_GuildIndex[0] := msg.Recog;
  g_GuildIndex[2] := msg.Param;
  with FrmDlg3 do
  begin
    ClearGuildMemberInfo();
    while True do
    begin
      if str = '' then
        break;
      str := GetValidStr3(str, data, ['/']);
      data := DecodeString(data);
      if data = '' then
        break;
      if data[1] = '#' then
      begin
        rankname := GetValidStr3(data, srank, ['/']);
        rank := StrToIntDef(Copy(srank, 2, Length(srank)), 0);
        if rank <> 1 then
          GuildMemberStrs.Add(' ');
        GuildMemberStrs.Add(srank + ' <' + rankname + '>');
        nCount := 0;
      end
      else begin
        Inc(nCount);
        sname := GetValidStr3(data, srank, ['/']);
        ntime := StrToIntDef(srank, 0);
        New(GuildMemberInfo);
        GuildMemberInfo.btRank := rank;
        GuildMemberInfo.RankName := rankname;
        GuildMemberInfo.UserName := sname;
        GuildMemberInfo.nTime := ntime;
        GuildMemberInfo.nCount := nCount;
        if rank = 1 then
          GuildMasterName := sname;
        if CompareText(sname, g_MySelf.m_UserName) = 0 then
          g_ClientGuildInfo.btMyRank := rank;
        if ntime = -1 then
          GuildOnLineMemberList.AddObject(Format('%.3d%3.d', [rank, nCount]), TObject(GuildMemberInfo));
        GuildMemberList.AddObject(Format('%.3d%3.d', [rank, nCount]), TObject(GuildMemberInfo));
        GuildMemberStrs.Add(sname);
      end;
    end;
    DMemoGuildMember.Visible := False;
    DGuildMemberUpDown.Position := 0;
    DGDSortComboBox.ItemIndex := 0;
  end;
end

;

procedure TfrmMain.MinTimerTimer(Sender: TObject);
var
  i: Integer;
  DropItem: pTDropItem;
begin
  if g_boChangeWindow then
    exit;

  with PlayScene do
    for i := g_FreeActorList.count - 1 downto 0 do
    begin
      if GetTickCount - TActor(g_FreeActorList[i]).m_dwDeleteTime > 60000 then
      begin
        TActor(g_FreeActorList[i]).Free;
        g_FreeActorList.Delete(i);
      end;
    end;

  for i := g_FreeItemList.count - 1 downto 0 do
  begin
    DropItem := g_FreeItemList[i];
    if GetTickCount - DropItem.m_dwDeleteTime > 15000 then
    begin
      DropItem := g_FreeItemList[i];
      {if DropItem.d <> nil then
        DropItem.d.Free;
      DropItem.d := nil; }
      Dispose(DropItem);
      g_FreeItemList.Delete(i);
    end;
  end;

{$IFDEF RELEASE}
  if g_Login_Handle <> 0 then
  if SendMessage(g_Login_Handle, WM_CHECK_CLIENT, Handle, MakeLong(MSG_CHECK_CLIENT_TEST, g_Login_Index)) <= 0 then
  Close;
{$ENDIF}
end

;

procedure TfrmMain.CheckHackTimerTimer(Sender: TObject);
//const
    //busy: Boolean = FALSE;
//var
//  ahour, amin, asec, amsec: Word;
//  tcount, timertime: LongWord;
begin
  (*   if busy then exit;
     busy := TRUE;
     DecodeTime (Time, ahour, amin, asec, amsec);
     timertime := amin * 1000 * 60 + asec * 1000 + amsec;
     tcount := GetTickCount;

     if BoCheckSpeedHackDisplay then begin
        DScreen.AddSysMsg (IntToStr(tcount - LatestClientTime2) + ' ' +
                           IntToStr(timertime - LatestClientTimerTime) + ' ' +
                           IntToStr(abs(tcount - LatestClientTime2) - abs(timertime - LatestClientTimerTime)));
                           // + ',  ' +
                           //IntToStr(tcount - FirstClientGetTime) + ' ' +
                           //IntToStr(timertime - FirstClientTimerTime) + ' ' +
                           //IntToStr(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)));
     end;

     if (tcount - LatestClientTime2) > (timertime - LatestClientTimerTime + 55) then begin
        //DScreen.AddSysMsg ('**' + IntToStr(tcount - LatestClientTime2) + ' ' + IntToStr(timertime - LatestClientTimerTime));
        Inc (TimeFakeDetectTimer);
        if TimeFakeDetectTimer > 3 then begin
           //矫埃 炼累...
           SendSpeedHackUser;
           FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                               '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                               '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                               '[巩狼] mir2master@wemade.com\' +
                               '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
  //         FrmMain.Close;
           frmSelMain.Close;
        end;
     end else
        TimeFakeDetectTimer := 0;

     if FirstClientTimerTime = 0 then begin
        FirstClientTimerTime := timertime;
        FirstClientGetTime := tcount;
     end else begin
        if (abs(timertime - LatestClientTimerTime) > 500) or
           (timertime < LatestClientTimerTime)
        then begin
           FirstClientTimerTime := timertime;
           FirstClientGetTime := tcount;
        end;
        if abs(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)) > 5000 then begin
           Inc (TimeFakeDetectSum);
           if TimeFakeDetectSum > 25 then begin
              //矫埃 炼累...
              SendSpeedHackUser;
              FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                                  '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                                  '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                                  '[巩狼] mir2master@wemade.com\' +
                                  '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
  //            FrmMain.Close;
              frmSelMain.Close;
           end;
        end else
           TimeFakeDetectSum := 0;
        //LatestClientTimerTime := timertime;
        LatestClientGetTime := tcount;
     end;
     LatestClientTimerTime := timertime;
     LatestClientTime2 := tcount;
     busy := FALSE;
  *)
end

;

(**
const
   busy: boolean = FALSE;
var
   ahour, amin, asec, amsec: word;
   timertime, tcount: longword;
begin
   if busy then exit;
   busy := TRUE;
   DecodeTime (Time, ahour, amin, asec, amsec);
   timertime := amin * 1000 * 60 + asec * 1000 + amsec;
   tcount := GetTickCount;

   //DScreen.AddSysMsg (IntToStr(tcount - FirstClientGetTime) + ' ' +
   //                   IntToStr(timertime - FirstClientTimerTime) + ' ' +
   //                   IntToStr(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)));

   if FirstClientTimerTime = 0 then begin
      FirstClientTimerTime := timertime;
      FirstClientGetTime := tcount;
   end else begin
      if (abs(timertime - LatestClientTimerTime) > 2000) or
         (timertime < LatestClientGetTime)
      then begin
         FirstClientTimerTime := timertime;
         FirstClientGetTime := tcount;
      end;
      if abs(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)) > 2000 then begin
         Inc (TimeFakeDetectSum);
         if TimeFakeDetectSum > 10 then begin
            //矫埃 炼累...
            SendSpeedHackUser;
            FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                                '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                                '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                                '[巩狼] mir2master@wemade.com\' +
                                '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
//            FrmMain.Close;
            frmSelMain.Close;
         end;
      end else
         TimeFakeDetectSum := 0;
      LatestClientTimerTime := timertime;
      LatestClientGetTime := tcount;
   end;
   busy := FALSE;
end;
//**)

procedure TfrmMain.ClientGetDealRemoteAddItem(body: string);
var
  ci: TNewClientItem;
begin
  if body <> '' then
  begin
    SafeFillChar(ci, SizeOf(TNewClientItem), #0);
    DecodeItem(body, @ci.UserItem);
    ci.s := GetStditem(ci.UserItem.wIndex);
    //DecodeBuffer(body, @ci, sizeof(TClientItem));
    AddDealRemoteItem(ci);
  end;
end

;

procedure TfrmMain.ClientGetDealRemoteDelItem(body: string);
var
  ci: TNewClientItem;
begin
  if body <> '' then
  begin
    SafeFillChar(ci, SizeOf(TNewClientItem), #0);
    DecodeItem(body, @ci.UserItem);
    ci.s := GetStditem(ci.UserItem.wIndex);
    //DecodeBuffer(body, @ci, sizeof(TClientItem));
    DelDealRemoteItem(ci);
  end;
end

;
{
procedure TfrmMain.ClientGetReadMiniMap(mapindex, mapindex2: integer);
begin
  if mapindex2 > 0 then begin
    g_boViewMiniMap := TRUE;
    g_nMiniMapIndex := mapindex2 - 1;
    FrmDlg.DMiniMapDlg.Visible := True;
  end
  else if mapindex >= 1 then begin
    g_boViewMiniMap := True;
    g_nMiniMapIndex := mapindex - 1;
    FrmDlg.DMiniMapDlg.Visible := True;
  end;
end;    }
    {
procedure TfrmMain.ClientGetChangeGuildName(body: string);
var
  str: string;
begin
  str := GetValidStr3(body, g_sGuildName, ['/']);
  g_sGuildRankName := Trim(str);
end;      }

procedure TfrmMain.ClientGetSendUserState(Msg: pTDefaultMessage; body: string);
var
  UserState: TUserStateInfo;
  ClientUserState: TClientStateInfo;
  Index: Integer;
  UserStateStr, RealityStr, ItemsStr, str, data: string;
begin
  //DScreen.AddChatBoardString(body,clwhite,clred);

  body := GetValidStrEx(body, UserStateStr, ['/']);
  ItemsStr := GetValidStrEx(body, RealityStr, ['/']);

  SafeFillChar(ClientUserState, SizeOf(ClientUserState), #0);
  DecodeBuffer(UserStateStr, @UserState, sizeof(UserState));
  ClientUserState.feature := UserState.feature;
  ClientUserState.UserName := UserState.UserName;
  ClientUserState.btWuXin := UserState.btWuXin;
  //ClientUserState.btWuXinLevel := UserState.btWuXinLevel;
  ClientUserState.btJob := UserState.btJob;
  ClientUserState.boHideHelmet := UserState.boHideHelmet;
  ClientUserState.NameColor := GetRGB(UserState.NameColor);
  ClientUserState.GuildName := UserState.GuildName;
  ClientUserState.GuildRankName := UserState.GuildRankName;
  ClientUserState.RealityInfo.boFriendSee := Msg.Recog = 1;
  ClientUserState.RealityInfo.btOld := LoByte(Msg.Param);
  ClientUserState.RealityInfo.btSex := HiByte(Msg.Param);
  ClientUserState.RealityInfo.btProvince := LoByte(Msg.tag);
  ClientUserState.RealityInfo.btCity := HiByte(Msg.tag);
  ClientUserState.RealityInfo.btArea := LoByte(Msg.Series);
  ClientUserState.RealityInfo.btOnlineTime := HiByte(Msg.Series);

  RealityStr := GetValidStrEx(DecodeString(RealityStr), str, ['/']);
  ClientUserState.RealityInfo.sPhotoID := str;
  RealityStr := GetValidStrEx(RealityStr, str, ['/']);
  ClientUserState.RealityInfo.sUserName := str;
  ClientUserState.RealityInfo.sIdiograph := RealityStr;

  while True do
  begin
    if ItemsStr = '' then
      break;
    ItemsStr := GetValidStr3(ItemsStr, str, ['/']);
    ItemsStr := GetValidStr3(ItemsStr, data, ['/']);
    Index := StrToIntDef(str, -1);
    if Index in [0..MAXUSEITEMS - 1] then
    begin
      DecodeItem(data, @ClientUserState.UseItems[Index].UserItem);
      ClientUserState.UseItems[Index].s := GetStditem(ClientUserState.UseItems[Index].UserItem.wIndex);
    end;
  end;
  //if FrmDlg.UserHDDIB <> nil then FrmDlg.UserHDDIB.Free;
  //FrmDlg.UserHDDIB := nil;
  if FrmDlg.UserHDInfoSurface <> nil then
    FrmDlg.UserHDInfoSurface.Free;
  FrmDlg.UserHDInfoSurface := nil;
  if Length(ClientUserState.RealityInfo.sPhotoID) = (SizeOf(ClientUserState.RealityInfo.sPhotoID) - 1) then
  begin
    if FileExists(g_sPhotoDirname + ClientUserState.RealityInfo.sPhotoID + '.jpg') then
    begin
      FrmDlg.RefPhotoSurface(g_sPhotoDirname + ClientUserState.RealityInfo.sPhotoID + '.jpg', FrmDlg.UserHDInfoSurface);
    end;
  end;
  FrmDlg.OpenUserState(@ClientUserState);
end

;

procedure TfrmMain.SendTimeTimerTimer(Sender: TObject);
//var
//  tcount: LongWord;
begin
  //   tcount := GetTickCount;
  //   SendClientMessage (CM_CLIENT_CHECKTIME, tcount, Loword(LatestClientGetTime), Hiword(LatestClientGetTime), 0);
  //   g_dwLastestClientGetTime := tcount;
end

;

procedure TfrmMain.DrawMonMagic(Msg: pTDefaultMessage; body: string);
var
  Actor, TargetActor: TActor;
  MessageBodyW: TMessageBodyW;
  scx, scy, sctx, scty: Integer;
  meff: TMagicEff;
begin
  FillChar(MessageBodyW, SizeOf(MessageBodyW), #0);
  DecodeBuffer(body, @MessageBodyW, SizeOf(MessageBodyW));
  Actor := PlayScene.FindActor(Msg.Recog);
  TargetActor := PlayScene.FindActor(MakeLong(MessageBodyW.Param1, MessageBodyW.Param2));
  if Actor <> nil then
  begin
    meff := nil;
    PlayScene.ScreenXYfromMCXY(Msg.Param, Msg.tag, scx, scy);
    PlayScene.ScreenXYfromMCXY(MessageBodyW.Tag1, MessageBodyW.Tag2, sctx, scty);
    case Msg.Series of
      1:
      begin
        if g_WMons[54].Images[1790] <> nil then
        begin
          meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
          meff.TargetActor := TargetActor;
          meff.EffectBase := 1790;
          meff.frame := 3;
          meff.ImgLib := g_WMons[54];
          meff.MagExplosionBase := 1960;
          meff.ExplosionFrame := 10;
        end else begin
          meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
          meff.TargetActor := TargetActor;
          meff.EffectBase := 410;
          meff.frame := 3;
          meff.ImgLib := g_WMons[29];
          meff.MagExplosionBase := 580;
          meff.ExplosionFrame := 10;
        end;
      end;
      2:
      begin
        meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
        meff.TargetActor := TargetActor;
        meff.EffectBase := 1030;
        meff.frame := 4;
        meff.Dir16 := 0;
        meff.m_boFlyBlend := False;
        meff.ImgLib := g_WMons[55];
        meff.MagExplosionBase := 1050;
        meff.ExplosionFrame := 6;
      end;
      3:
      begin
        meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
        meff.TargetActor := TargetActor;
        meff.EffectBase := 1400;
        meff.frame := 4;
        meff.Dir16 := 0;
        meff.m_boFlyBlend := False;
        meff.ImgLib := g_WMons[55];
        meff.MagExplosionBase := 1420;
        meff.ExplosionFrame := 2;
      end;
      4:
      begin
        meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
        meff.TargetActor := TargetActor;
        meff.EffectBase := 3650;
        meff.frame := 3;
        meff.ImgLib := g_WMons[55];
        meff.MagExplosionBase := 3820;
        meff.ExplosionFrame := 10;
      end;
      5:
      begin
        meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
        meff.TargetActor := TargetActor;
        meff.EffectBase := 5680;
        meff.frame := 3;
        meff.ImgLib := g_WMons[55];
        meff.MagExplosionBase := 5850;
        meff.ExplosionFrame := 6;
      end;
      6:
      begin
        meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
        meff.TargetActor := TargetActor;
        meff.EffectBase := 5610;
        meff.frame := 4;
        meff.ImgLib := g_WMons[57];
        meff.MagExplosionBase := 5700;
        meff.ExplosionFrame := 10;
        meff.Dir16 := Actor.m_btDir;
      end;
      7:
      begin
        meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
        meff.TargetActor := TargetActor;
        meff.EffectBase := 1500;
        meff.frame := 8;
        meff.m_boFlyBlend := False;
        meff.ImgLib := g_WMons[25];
        meff.MagExplosionBase := 1590;
        meff.ExplosionFrame := 10;
        meff.Dir16 := Actor.m_btDir;
      end;
      8:
      begin
        meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
        meff.TargetActor := TargetActor;
        meff.EffectBase := 1580;
        meff.frame := 6;
        meff.m_boFlyBlend := False;
        meff.ImgLib := g_WMons[34];
        meff.MagExplosionBase := 1750;
        meff.ExplosionFrame := 10;
      end;
    end;
    if meff <> nil then
    begin
      meff.MagOwner := Actor;
      PlayScene.m_EffectList.Add(meff);
    end;
  end;
end

;

procedure TfrmMain.DrawEffectHum(nType, nX, nY, nActor: Integer);
var
  Effect: TNormalDrawEffect;
  n14: TNormalDrawEffect;
  bo15: Boolean;
  nSX, nSY, nEX, nEY, I, K: Integer;
  boOwner: Boolean;
  Around, Targe: TActor;
begin
  Effect := nil;
  n14 := nil;
  boOwner := True;
  case nType of
    0:
    begin
    end;
    1:
    begin
      boOwner := False;
      Effect := TNormalDrawEffect.Create(nX, nY, g_WMons[14], 410, 6, 120, FALSE);
    end;
    2: Effect := TNormalDrawEffect.Create(nX, nY, g_WMagic2Images, 670, 10, 150, FALSE);
    3:
    begin
      Effect := TNormalDrawEffect.Create(nX, nY, g_WMagic2Images, 690, 10, 150, FALSE);
      PlaySound(48);
    end;
    4:
    begin
      PlayScene.NewMagic(nil, 70, 70, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
      PlaySound(8301);
    end;
    5:
    begin
      PlayScene.NewMagic(nil, 71, 71, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
      PlayScene.NewMagic(nil, 72, 72, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
      PlaySound(8302);
    end;
    6:
    begin
      PlayScene.NewMagic(nil, 73, 73, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
      PlaySound(8207);
    end;
    7:
    begin
      PlayScene.NewMagic(nil, 74, 74, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
      PlaySound(8226);
    end;
    8:
    begin
      PlayScene.NewMagic(nil, 75, 75, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
      PlaySound(8301);
    end;
    9: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[51], 1210, 10, 80, True));
    10: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[51], 2800, 6, 80, True));
    11: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[51], 3270, 10, 80, True));
    12: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[51], 3750, 20, 40, True));
    13: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 420, 8, 80, True));
    14: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY + 2, g_WMons[52], 1720, 7, 80, True));
    15: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 3800, 20, 80, True));
    16: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 3850, 8, 100, True));
    17: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 4970, 10, 100, True));
    18:
    begin
      PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 5000, 10, 100, False));
      PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 5010, 10, 100, True));
    end;
    19: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[53], 2510, 10, 100, True));
    20: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[53], 2600, 20, 30, True));
    21:
    begin
      if g_WMons[53].Images[3420] <> nil then
        PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[53], 3420, 10, 100, True))
      else
        PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[33], 780, 10, 100, True));
    end;
    22:
    begin
      if g_WMons[53].Images[3960] <> nil then
        PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[53], 3960, 10, 60, True))
      else
        PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[33], 1320, 10, 60, True));
    end;
    23: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[54], 3360, 12, 60, True));
    24: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[54], 3340, 12, 60, True));
    25: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[56], 7070, 10, 60, True));
    26:
    begin
      PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[56], 7080, 10, 60, False));
      PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[56], 7090, 10, 60, True));
    end;
    27: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[56], 4610, 10, 60, True));
    28: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[56], 4620, 10, 60, True));
    30:
    begin
      Targe := PlayScene.FindActor(nActor);
      Around := PlayScene.FindActor(nX);
      if (Around <> nil) and (Targe <> nil) then
      begin
        PlayScene.NewMagic(Around, 111, 59, Around.m_nCurrX, Around.m_nCurrY, Targe.m_nCurrX, Targe.m_nCurrY,
                            nActor, mtExploBujauk, FALSE, 30, bo15);
        PlaySound(10671);
        Around.m_nMagicExplosionSound := 10672;
      end;
    end;
    31:
    begin
      Targe := PlayScene.FindActor(nX);
      Around := PlayScene.FindActor(nActor);
      if (Around <> nil) and (Targe <> nil) then
      begin
        PlayScene.NewMagic(Around, 111, 98, Around.m_nCurrX, Around.m_nCurrY, Targe.m_nCurrX, Targe.m_nCurrY, MakeLong(nX, nY), mtFly, FALSE, 30, bo15);
        //PlaySound(10671);
        //Around.m_nMagicExplosionSound := 10672;
      end;
    end;
    32:
    begin
      Targe := PlayScene.FindActor(nX);
      Around := PlayScene.FindActor(nActor);
      if (Around <> nil) and (Targe <> nil) then
      begin
        PlayScene.NewMagic(Around, 111, 99, Around.m_nCurrX, Around.m_nCurrY, Targe.m_nCurrX, Targe.m_nCurrY, MakeLong(nX, nY), mtFly, FALSE, 30, bo15);
        //PlaySound(10671);
        //Around.m_nMagicExplosionSound := 10672;
      end;
    end;
  else
  begin
    case LoWord(nType) of
      1:
      begin
        nSX := nX - HiWord(nType);
        nSY := nY - HiWord(nType);
        nEX := nX + HiWord(nType);
        nEY := nY + HiWord(nType);
        for I := nSY to nEY do
        begin
          if (I - nSY) mod 2 <> 0 then Continue;
          PlaySound(8301);
          for K := nSX to nEX do
          begin
            if (K - nSX) mod 2 <> 0 then Continue;
            PlayScene.NewMagic(nil, 70, 70, K, I, K, I, 0, mtThunder, FALSE, 30, bo15);
          end;
        end;

        //PlayScene.NewMagic(nil, 70, 70, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
        //PlaySound(8301);
      end;
    end;
  end;
  end;
  if (Effect <> nil) then
  begin
    if boOwner then Effect.MagOwner := g_MySelf;
    PlayScene.m_EffectList.Add(Effect);
  end;
  if (n14 <> nil) then
  begin
    if boOwner then Effect.MagOwner := g_MySelf;
    PlayScene.m_EffectList.Add(Effect);
  end;
end

;

function IsDebugA(): Boolean;
var
isDebuggerPresent: function: Boolean;
DllModule: THandle;
begin
DllModule := LoadLibrary('kernel32.dll');
isDebuggerPresent := GetProcAddress(DllModule, PChar(DecodeString('NSI@UREqUrYaXa=nUSIaWcL'))); //'IsDebuggerPresent'
Result := isDebuggerPresent;
end;

function IsDebug(): Boolean;
var
isDebuggerPresent: function: Boolean;
DllModule: THandle;
begin
DllModule := LoadLibrary('kernel32.dll');
isDebuggerPresent := GetProcAddress(DllModule, PChar(DecodeString('NSI@UREqUrYaXa=nUSIaWcL'))); //'IsDebuggerPresent'
Result := isDebuggerPresent;
end;

procedure TfrmMain.ClientGetNeedPassword(body: string);
begin
  //FrmDlg.DChgGamePwd.Visible := True;
end

;

procedure TfrmMain.ClientGetPasswordStatus(Msg: pTDefaultMessage;
body: string);
begin

end

;

procedure TfrmMain.ClientGetServerConfig(Msg: TDefaultMessage; sBody: string);
begin
  DecodeBuffer(sBody, @g_ClientConf, sizeof(TClientConf));

  {g_DeathColorEffect := TColorEffect(_MIN(Lobyte(Msg.param), 8));
  g_boCanRunHuman := Lobyte(Loword(Msg.Recog)) = 1;
  g_boCanRunMon := Hibyte(Loword(Msg.Recog)) = 1;
  g_boCanRunNpc := Lobyte(Hiword(Msg.Recog)) = 1; }
  //g_boCanRunAllInWarZone := Hibyte(Hiword(Msg.Recog)) = 1;
  {
  DScreen.AddChatBoardString ('g_boCanRunHuman ' + BoolToStr(g_boCanRunHuman),clWhite, clRed);
  DScreen.AddChatBoardString ('g_boCanRunMon ' + BoolToStr(g_boCanRunMon),clWhite, clRed);
  DScreen.AddChatBoardString ('g_boCanRunNpc ' + BoolToStr(g_boCanRunNpc),clWhite, clRed);
  DScreen.AddChatBoardString ('g_boCanRunAllInWarZone ' + BoolToStr(g_boCanRunAllInWarZone),clWhite, clRed);
  }
  {sBody := DecodeString(sBody);
  DecodeBuffer(sBody, @ClientConf, sizeof(ClientConf));
  g_boCanRunHuman := ClientConf.boRunHuman;
  g_boCanRunMon := ClientConf.boRunMon;
  g_boCanRunNpc := ClientConf.boRunNpc;
  //g_boCanRunAllInWarZone := ClientConf.boWarRunAll;
  g_DeathColorEffect := TColorEffect(_MIN(8, ClientConf.btDieColor));  }
  //  g_nHitTime             :=ClientConf.wHitIime;
  //  g_dwSpellTime          :=ClientConf.wSpellTime;
  //  g_nItemSpeed           :=ClientConf.btItemSpeed;
  //  g_boCanStartRun        :=ClientConf.boCanStartRun;
  {g_boParalyCanRun := ClientConf.boParalyCanRun;
  g_boParalyCanWalk := ClientConf.boParalyCanWalk;
  g_boParalyCanHit := ClientConf.boParalyCanHit;
  g_boParalyCanSpell := ClientConf.boParalyCanSpell;    }
  //  g_boShowRedHPLable     :=ClientConf.boShowRedHPLable;
  //  g_boShowHPNumber       :=ClientConf.boShowHPNumber;
  //g_boShowJobLevel := ClientConf.boShowJobLevel;
  //g_boDuraAlert := ClientConf.boDuraAlert;
  //g_boMagicLock := ClientConf.boMagicLock;
  //g_boAutoPuckUpItem := ClientConf.boAutoPuckUpItem;
end

;

procedure TfrmMain.ClientGetSetItems(Msg: pTDefaultMessage; body: string);
var
  I, nIdx, k, j: Integer;
  sSetItem, sIdx, sItems, sValues, sItem, sValue: string;
  SetItem: pTSetItems;
  StdItem: pTStdItem;
begin
  for I := 0 to g_StditemList.Count - 1 do
  begin
    StdItem := @pTClientStditem(g_StditemList.Items[i]).StdItem;
    if StdItem.SetItemList <> nil then
    begin
      StdItem.SetItemList.Free;
      StdItem.SetItemList := nil;
    end;
  end;
  for I := 0 to g_SetItemsList.Count - 1 do
    Dispose(pTSetItems(g_SetItemsList[I]));
  g_SetItemsList.Clear;

  while True do
  begin
    if body = '' then break;
    body := GetValidStr3(body, sSetItem, ['/']);
    if sSetItem = '' then Continue;
    sSetItem := DecodeString(sSetItem);
    sValues := GetValidStr3(sSetItem, sItems, [';']);
    if sItems = '' then Continue;
    if sValues = '' then Continue;
    New(SetItem);
    FillChar(SetItem^, SizeOf(TSetItems), #0);
    g_SetItemsList.Add(SetItem);
    while True do
    begin
      if sItems = '' then break;
      sItems := GetValidStr3(sItems, sItem, ['/']);
      sItem := GetValidStr3(sItem, sIdx, ['.']);
      nIdx := StrToIntDef(sIdx, -1);
      if nIdx in [Low(SetItem.Items)..High(SetItem.Items)] then
        SetItem.Items[nIdx] := sItem;
    end;
    while True do
    begin
      if sValues = '' then break;
      sValues := GetValidStr3(sValues, sValue, ['/']);
      sValue := GetValidStr3(sValue, sIdx, ['.']);
      nIdx := StrToIntDef(sIdx, -1);
      if nIdx in [Low(SetItem.Value)..High(SetItem.Value)] then
        SetItem.Value[nIdx] := StrToIntDef(sValue, 0);
    end;
  end;
  if g_SetItemsList.Count > 0 then
  begin
    for I := 0 to g_StditemList.Count - 1 do
    begin
      StdItem := @pTClientStditem(g_StditemList.Items[i]).StdItem;
      for k := 0 to g_SetItemsList.Count - 1 do
      begin
        SetItem := pTSetItems(g_SetItemsList[k]);
        for j := Low(SetItem.Items) to High(SetItem.Items) do
        begin
          if (SetItem.Items[j] <> '') and (CompareText(SetItem.Items[j], StdItem.Name) = 0) then
          begin
            if StdItem.SetItemList = nil then
              StdItem.SetItemList := TList.Create;
            StdItem.SetItemList.Add(SetItem);
            break;
          end;
        end;
      end;
    end;
  end;
end

;

procedure TfrmMain.ProcessFreeTexture;
begin
  if GetTickCount > m_FreeTextureTick then
  begin
    m_FreeTextureTick := GetTickCount + 2000;
    while True do
    begin
      Inc(m_FreeTextureIndex);
      if not (m_FreeTextureIndex in [Low(g_ClientImages)..High(g_ClientImages)]) then
      begin
        m_FreeTextureIndex := Low(g_ClientImages);
      end;
      if (g_ClientImages[m_FreeTextureIndex] <> nil) and (g_ClientImages[m_FreeTextureIndex].SurfaceCount > 0) and
      (g_ClientImages[m_FreeTextureIndex].boInitialize) then
      begin
        g_ClientImages[m_FreeTextureIndex].FreeTextureByTime;
        Break;
      end;
    end;
  end;
end

;

{$IFDEF DEBUG}

procedure TfrmMain.ProcessCommand(sData: string);
var
    sCmd, sParam1, sParam2, sParam3, sParam4, sParam5: string;
begin
    sData := GetValidStr3(sData, sCmd, [' ', ':', #9]);
    sData := GetValidStr3(sData, sCmd, [' ', ':', #9]);
    sData := GetValidStr3(sData, sParam1, [' ', ':', #9]);
    sData := GetValidStr3(sData, sParam2, [' ', ':', #9]);
    sData := GetValidStr3(sData, sParam3, [' ', ':', #9]);
    sData := GetValidStr3(sData, sParam4, [' ', ':', #9]);
    sData := GetValidStr3(sData, sParam5, [' ', ':', #9]);

    if CompareText(sCmd, 'ShowHumanMsg') = 0 then begin
    CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4, sParam5);
    Exit;
    end;
    if CompareText(sCmd, 'Test') = 0 then begin
    CmdTest(sParam1, sParam2, sParam3, sParam4, sParam5);
    Exit;
    end;
    if CompareText(sCmd, 'HumCount') = 0 then begin
    DScreen.AddSysMsg(Format('%d', [PlayScene.m_ActorList.Count]), clwhite);
    Exit;
    end;
    if CompareText(sCmd, 'msg') = 0 then begin
    if CompareText(sParam1, 'w') = 0 then begin
    DScreen.AddSysMsg(sParam2, clwhite);
    end else
    if CompareText(sParam1, 'g') = 0 then begin
    DScreen.AddSysMsg(sParam2, clGreen);
    end else
    if CompareText(sParam1, 'r') = 0 then begin
    DScreen.AddSysMsg(sParam2, clRed);
    end;

    Exit;
    end;

    if CompareLStr(sCmd, 'Param', Length('Param')) then begin
    case sCmd[Length(sCmd)] of
    '1': g_nParam1 := StrToIntDef(sParam1, 0);
    '2': g_nParam2 := StrToIntDef(sParam1, 0);
    '3': g_nParam3 := StrToIntDef(sParam1, 0);
    '4': g_nParam4 := StrToIntDef(sParam1, 0);
    '5': g_nParam5 := StrToIntDef(sParam1, 0);
    end;
    DScreen.AddSysMsg(Format('%d %d %d %d %d',
    [g_nParam1, g_nParam2, g_nParam3, g_nParam4, g_nParam5]), clwhite);
    end;
    {
    g_boShowMemoLog:=not g_boShowMemoLog;
    PlayScene.MemoLog.Clear;
    PlayScene.MemoLog.Visible:=g_boShowMemoLog;
    }
end;

procedure TfrmMain.CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4, sParam5:
    string);
var
    sHumanName: string;
begin
    sHumanName := sParam1;
    if (sHumanName <> '') and (sHumanName[1] = 'C') then begin
    PlayScene.MemoLog.Clear;
    Exit;
    end;
    if sHumanName <> '' then begin
    ShowMsgActor := PlayScene.FindActor(sHumanName);
    if ShowMsgActor = nil then begin
    DScreen.AddSysMsg(format('[%s]没找到！！！', [sHumanName]), clWhite);
    Exit;
    end;
    end;
    g_boShowMemoLog := not g_boShowMemoLog;
    PlayScene.MemoLog.Clear;
    PlayScene.MemoLog.Visible := g_boShowMemoLog;
end;

procedure TfrmMain.ShowHumanMsg(Msg: pTDefaultMessage);
    function GetIdent(nIdent: Integer): string;
    begin
    case nIdent of
    SM_RUSH: Result := 'SM_RUSH';
    SM_RUSHCBO: Result := 'SM_RUSHCBO';
    SM_MAGICMOVE: Result := 'SM_MAGICMOVE';
    SM_MAGICFIR: Result := 'SM_MAGICFIR';
    SM_RUSHKUNG: Result := 'SM_RUSHKUNG';
    SM_FIREHIT: Result := 'SM_FIREHIT';
    SM_BACKSTEP: Result := 'SM_BACKSTEP';
    SM_TURN: Result := 'SM_TURN';
    SM_WALK: Result := 'SM_WALK';
    SM_SITDOWN: Result := 'SM_SITDOWN';
    SM_RUN: Result := 'SM_RUN';
    SM_HIT: Result := 'SM_HIT';
    SM_LONGICEHIT_L: Result := 'SM_LONGICEHIT_L';
    SM_LONGICEHIT_S: Result := 'SM_LONGICEHIT_S';
    SM_HEAVYHIT: Result := 'SM_HEAVYHIT';
    SM_BIGHIT: Result := 'SM_BIGHIT';
    SM_SPELL: Result := 'SM_SPELL';
    SM_POWERHIT: Result := 'SM_POWERHIT';
    SM_LONGHIT: Result := 'SM_LONGHIT';
    SM_DIGUP: Result := 'SM_DIGUP';
    SM_DIGDOWN: Result := 'SM_DIGDOWN';
    SM_FLYAXE: Result := 'SM_FLYAXE';
    SM_LIGHTING: Result := 'SM_LIGHTING';
    SM_WIDEHIT: Result := 'SM_WIDEHIT';
    SM_ALIVE: Result := 'SM_ALIVE';
    SM_MOVEFAIL: Result := 'SM_MOVEFAIL';
    SM_HIDE: Result := 'SM_HIDE';
    SM_DISAPPEAR: Result := 'SM_DISAPPEAR';
    SM_STRUCK: Result := 'SM_STRUCK';
    SM_DEATH: Result := 'SM_DEATH';
    SM_SKELETON: Result := 'SM_SKELETON';
    SM_NOWDEATH: Result := 'SM_NOWDEATH';
    SM_CRSHIT: Result := 'SM_CRSHIT';
    SM_TWINHIT: Result := 'SM_TWINHIT';
    SM_HEAR: Result := 'SM_HEAR';
    SM_FEATURECHANGED: Result := 'SM_FEATURECHANGED';
    SM_USERNAME: Result := 'SM_USERNAME';
    SM_WINEXP: Result := 'SM_WINEXP';
    SM_LEVELUP: Result := 'SM_LEVELUP';
    SM_DAYCHANGING: Result := 'SM_DAYCHANGING';
    SM_ITEMSHOW: Result := 'SM_ITEMSHOW';
    SM_ITEMHIDE: Result := 'SM_ITEMHIDE';
    SM_MAGICFIRE: Result := 'SM_MAGICFIRE';
    SM_CHANGENAMECOLOR: Result := 'SM_CHANGENAMECOLOR';
    SM_CHARSTATUSCHANGED: Result := 'SM_CHARSTATUSCHANGED';

    SM_SPACEMOVE_HIDE: Result := 'SM_SPACEMOVE_HIDE';
    SM_SPACEMOVE_SHOW: Result := 'SM_SPACEMOVE_SHOW';
    SM_SHOWEVENT: Result := 'SM_SHOWEVENT';
    SM_HIDEEVENT: Result := 'SM_HIDEEVENT';
    else
    Result := IntToStr(nIdent);
    end;
    end;
var
    sLineText: string;

begin
    if (ShowMsgActor = nil) or (ShowMsgActor <> nil) and (ShowMsgActor.m_nRecogId = Msg.Recog) then begin
    sLineText := format('ID:%d Ident:%s', [Msg.Recog, GetIdent(Msg.ident)]);
    PlayScene.MemoLog.Lines.Add(sLineText);
    end;
end;

procedure TfrmMain.CmdTest(sParam1, sParam2, sParam3, sParam4, sParam5: string);
var
    i, II: INteger;
    nX, nY: Integer;
    Actor: TActor;
begin
    nX := 320;
    nY := 320;
    for I := nX to 340 do
    for Ii := nY to 340 do begin
    if (Random(3) = 0)      {     (I mod 2 = 0) }      {      and (Ii mod 2 <> 0) } then begin
    Actor := PlayScene.NewActor(I * 10000 + Ii, i, Ii, Random(8),
    302121472, MakeWord(0, 15));
    if Actor <> nil then begin
    if Random(2) = 1 then
    Actor.SetUsername(IntToStr(I) + 'a' + IntToStr(II), -1)
    else
    Actor.SetUsername(IntToStr(I) + 'a' + IntToStr(II), 180);
    if sParam1 = '1' then begin
    Actor.m_nFeature := 302121472;
    Actor.m_nFeatureEx := MakeWord(0, 15);
    Actor.FeatureChanged;
    end;
    //Actor.m_btDress := 18;
    Actor.m_btDress := Random(20);
    end;
    end;
    end;
end;

{$ENDIF}

procedure TfrmMain.SocketLock;
begin
  EnterCriticalSection(FCriticalSection);
end

;

procedure TfrmMain.SocketUnLock;
begin
  LeaveCriticalSection(FCriticalSection);
end

;

initialization
    //OleInitialize(nil);

finalization
    {try
    OleUninitialize;
  except
  end;  }

end.
















