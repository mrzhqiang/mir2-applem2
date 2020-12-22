unit DrawScrn;//DrawScrn,其实更准确地说是DrawScrn-txt,,,,整个场景的实际绘图工作已经在introscrn.pas和playscrn.pas中完成了
//场景管理器
interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, HGE, 
  IntroScn, HGETextures, DirectXGraphics, HGEBase, 
  HUtil32, MShare, wil;

const
  MAXSYSLINE = 8;

  BOTTOMBOARD = 1;
   VIEWCHATLINE = 9;//9行文本输入框
   AREASTATEICONBASE = 150;//area state icon base Prguse.wil中150战斗151安全
  

type

  pTSayHint = ^TSayHint;
  TSayHint = record
    SaySurface: TDirectDrawSurface;
    AddTime: LongWord;
    EffectTime: LongWord;
    EffectIndex: Integer;
  end;

  pTAddSysInfo = ^TAddSysInfo;
  TAddSysInfo = record
    str: string;
    Color: TColor;
    DefColor: TColor;
    boFirst: Boolean;
  end;
//走马灯

  TDrawScreen = class
  private
    //m_dwFrameTime: LongWord;
    //m_dwFrameCount: LongWord;
    //m_dwDrawFrameCount: LongWord;

  public
      CurrentScene: TScene;       //当前场景
    //ChatStrs: TStringList;
    //    ChatBks: TList;
    //ChatBoardTop: Integer;
    m_SysMsgList: TStringList;
    m_SysInfoList: TList;
    m_NewSayMsgList: TList;
    m_SayTransferList: TList;

//    SysMsgBoardTop: Integer;

    HintX, HintY, HintWidth, HintHeight: Integer;
    HintUp: Boolean;
    NpcTempList: TStringList;
    AutoImgTime: LongWord;
    m_HintSurface: TDirectDrawSurface; //0x0C
//    m_HintBGSurface: TDirectDrawSurface;
    m_HintList: TList;
    SurfaceRefTick: LongWord;
    boShowSurface: Boolean;
    nShowIndex: Integer;
    m_nShowSysTick: LongWord;

    //    SysMsgCount: array[0..10 - 1] of Integer;
    //    SysMsgPosition: array[0..10 - 1] of Integer;
    constructor Create;
    destructor Destroy; override;
    procedure KeyPress(var Key: Char);
    procedure KeyDown(var Key: Word; Shift: TShiftState);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Initialize;
    procedure Finalize;
    procedure ChangeScene(scenetype: TSceneType);
    procedure DrawScreen(MSurface: TDirectDrawSurface);
    procedure DrawScreenTop(MSurface: TDirectDrawSurface);
    procedure ClearSysMsg;
    procedure AddSysMsgEx(str: string; Color: TColor; boFirst: Boolean = True; DefColor: TColor = 0);
    procedure AddSysMsg(str: string; Color: TColor; boFirst: Boolean = True; DefColor: TColor = 0);
    //procedure DeleteSysMsg(nType: Integer);
    //function GetLaseSysMsg(nType, nX, nY: Integer): pTSysMsg;
    procedure AddSayMsg(str: string; FColor: TColor; BColor: TColor; boSys: Boolean; UserSayType: TUserSayType; boFirst: Boolean = True;
      DefFColor: TColor = 0; DefBColor: TColor = 0);

    //procedure AddChatBoardString(str: string; fcolor, bcolor: Integer);
    procedure ClearChatBoard;
    procedure DisposeSayMsg(SayMessage: pTSayMessage);
    procedure DelTransferMsg(SayMessage: pTSayMessage);
    procedure ChangeTransferMsg(UserSaySet: TUserSaySet);
    Function  NewSayMsg(nWidth, nHeight:Integer; UserSayType: TUserSayType): pTSayMessage;
    Function  NewSayMsgEx(nWidth, nHeight:Integer; UserSayType: TUserSayType; BColor: Cardinal): pTSayMessage;
    procedure ClearBit(SayMessage: pTSayMessage; nMaxLen: Integer);

    Function ShowHint(X, Y: Integer; str: string; Color: TColor; drawup:
      Boolean; ShowIndex: Integer; boItemHint: Boolean = False; HintSurface:TDirectDrawSurface = nil;
      HintList: TList = nil; boLeft: Boolean = False): TPoint;
    procedure ShowHintEx(X, Y: Integer; str: string);
    procedure ClearHint(boClear: Boolean = False);
    procedure DrawHint(MSurface: TDirectDrawSurface);
    procedure DrawHintEx(MSurface, HintSurface: TDirectDrawSurface; nX, nY, HWidth, HHeight: Integer; HintList: TList);
  end;

implementation

uses
  ClMain, Share, Grobal2, FState, WMFile, cliUtil;

constructor TDrawScreen.Create;
//var
//  i: Integer;
begin
  CurrentScene := nil;
  //m_dwFrameTime := GetTickCount;
  //m_dwFrameCount := 0;
  m_SysMsgList := TStringList.Create;
  //ChatBks := TList.Create;
  //SysMsgBoardTop := 0;
  m_HintSurface := nil;
  m_nShowSysTick := GetTickCount;
  //m_HintBGSurface := nil;
  m_SysInfoList := TList.Create;
  SurfaceRefTick := GetTickCount;
  boShowSurface := False;
  NpcTempList := TStringList.Create;
  AutoImgTime := GetTickCount;
  nShowIndex := 0;
  m_HintList := TList.Create;
  m_NewSayMsgList := TList.Create;
  m_SayTransferList := TList.Create;
  //SafeFillChar(SysMsgCount, SizeOf(SysMsgCount), #0);
 // SafeFillChar(SysMsgPosition, SizeOf(SysMsgPosition), #0);
end;

destructor TDrawScreen.Destroy;
var
  i: Integer;
  SayHint: pTSayHint;
begin
  Finalize;
  ClearChatBoard;
  for i := 0 to m_SysMsgList.Count - 1 do begin
    SayHint := pTSayHint(m_SysMsgList.Objects[i]);
    SayHint.Saysurface.free;
    Dispose(SayHint);
  end;

  for i := 0 to m_HintList.Count - 1 do begin
    if pTnewShowHint(m_HintList[i]).IndexList <> nil then
      pTnewShowHint(m_HintList[i]).IndexList.Free;
    Dispose(pTnewShowHint(m_HintList[i]));
  end;

  for I := 0 to m_SysInfoList.Count - 1 do begin
    Dispose(pTAddSysInfo(m_SysInfoList[I]));
  end;
  m_SysInfoList.Free;
  m_SysMsgList.Free;
  m_HintList.Free;
  //ChatBks.Free; pTShowHint
  NpcTempList.Free;
  m_NewSayMsgList.Free;
  m_SayTransferList.Free;
  ClearHint;
  inherited Destroy;
end;

procedure TDrawScreen.Initialize;
begin
  m_HintSurface := TDXImageTexture.Create(g_DXCanvas);
  m_HintSurface.Size := Point(g_FScreenWidth, g_FScreenHeight);
  m_HintSurface.PatternSize := Point(g_FScreenWidth, g_FScreenHeight);
  m_HintSurface.Format := D3DFMT_A4R4G4B4;
  m_HintSurface.Active := True;

  //更新
  {m_HintSurface := TDirectDrawSurface.Create(frmMain.DXDraw.DDraw);
  m_HintSurface.SystemMemory := True;
  m_HintSurface.SetSize(400, 600);
  m_HintSurface.Canvas.Font.Name := DEFFONTNAME;
  m_HintSurface.Canvas.Font.Size := DEFFONTSIZE;    }

  {m_HintBGSurface := TDirectDrawSurface.Create(frmMain.DXDraw.DDraw);
  m_HintBGSurface.SystemMemory := True;
  m_HintBGSurface.SetSize(400, 600);
  m_HintBGSurface.Canvas.Font.Name := DEFFONTNAME;
  m_HintBGSurface.Canvas.Font.Size := DEFFONTSIZE;
  m_HintBGSurface.Fill(2048);     }

end;

procedure TDrawScreen.Finalize;
begin
  if m_HintSurface <> nil then
    m_HintSurface.Free;
  {if m_HintBGSurface <> nil then
    m_HintBGSurface.Free;  }
  m_HintSurface := nil;
  //m_HintBGSurface := nil;
end;

procedure TDrawScreen.KeyPress(var Key: Char);
begin
  if CurrentScene <> nil then
    CurrentScene.KeyPress(Key);
end;

procedure TDrawScreen.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if CurrentScene <> nil then
    CurrentScene.KeyDown(Key, Shift);
end;

procedure TDrawScreen.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if CurrentScene <> nil then
    CurrentScene.MouseMove(Shift, X, Y);
end;

procedure TDrawScreen.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if CurrentScene <> nil then
    CurrentScene.MouseDown(Button, Shift, X, Y);
end;

procedure TDrawScreen.ChangeScene(scenetype: TSceneType);
begin
  if CurrentScene <> nil then
    CurrentScene.CloseScene;
  case scenetype of
    stLogin: CurrentScene := LoginScene;
    stSelectChr: CurrentScene := SelectChrScene;
    stPlayGame: CurrentScene := PlayScene;
    stSelServer: CurrentScene := SelServer;
    stHint: CurrentScene := HintScene;
    else CurrentScene := nil;
  end;
  if CurrentScene <> nil then
    CurrentScene.OpenScene;
end;
//添加系统信息
procedure TDrawScreen.AddSysMsg(str: string; Color: TColor; boFirst: Boolean = True; DefColor: TColor = 0);
var
  AddSysInfo: pTAddSysInfo; 
begin
  New(AddSysInfo);
  AddSysInfo.str := str;
  AddSysInfo.Color := Color;
  AddSysInfo.DefColor := DefColor;
  AddSysInfo.boFirst := boFirst;
  m_SysInfoList.Add(AddSysInfo);
  if m_SysInfoList.Count > 9 then begin
    Dispose(pTAddSysInfo(m_SysInfoList[0]));
    m_SysInfoList.Delete(0);
  end;
  if m_SysMsgList.Count < 5 then
    m_nShowSysTick := 0;
end;

      //DefColor: TColor = 0
procedure TDrawScreen.AddSysMsgEx(str: string; Color: TColor; boFirst: Boolean; DefColor: TColor);
  function GetStrLen: Integer;
  var
    nLen: Integer;
    sTempStr: string;
    sLenStr: string;
  begin
    sTempStr := GetValidStr3(str, sLenStr, ['<']);
    nLen := g_DXCanvas.TextWidth(sLenStr);
    while sTempStr <> '' do begin
      sTempStr := GetValidStr3(sTempStr, sLenStr, ['>']);
      if sTempStr = '' then break;
      sTempStr := GetValidStr3(sTempStr, sLenStr, ['<']);
      Inc(nLen, g_DXCanvas.TextWidth(sLenStr));
    end;
    Result := nLen;
  end;
var
  fdata, cmdstr, temp, cmd, cmdinfo: string;
  nLeng, Len, I, cmdi: Integer;
  boCmd: Boolean;
  fColor, bColor: TColor;
  SaySurface: TDirectDrawSurface;
  SayHint: pTSayHint;
  tempstr: string;
begin
  tempstr := '';
  if Str = '' then Exit;
  if boFirst then tempstr := str;
  nLeng := GetStrLen;
  SaySurface := TDXImageTexture.Create(g_DXCanvas);
  SaySurface.Size := Point(nLeng + 2, ADDSaYHEIGHT);
  SaySurface.PatternSize := Point(nLeng + 2, ADDSaYHEIGHT);
  SaySurface.Format := D3DFMT_A4R4G4B4;
  SaySurface.Active := True;
  SaySurface.Clear;

  with SaySurface do begin
    len := Length(str);
    //SetBkMode(Canvas.Handle, TRANSPARENT);
    nLeng := 1;
    fColor := Color;
    bColor := $8;
    if not boFirst then nLeng := 10;
    temp := '';
    cmdstr := '';
    cmdi := 1;
    boCmd := False;
    i := 1;
    while True do begin
      if i > len then begin
        str := '';
        break;
      end;

      if boCmd then begin
        if str[i] = '>' then begin
          boCmd := False;
          if Length(cmdstr) >= 2 then begin
            cmd := Copy(cmdstr, 1, 2);
            cmdinfo := Copy(cmdstr, 3, Length(cmdstr) - 2);
            if cmd = 'CO' then begin
              fColor := StrToIntDef(cmdinfo, Color);
            end;
            if cmd = 'CE' then begin
              if DefColor <> 0 then
                fColor := DefColor
              else
                fColor := Color;
            end;
          end;
          if i >= len then begin
            str := '';
            break;
          end;
          Inc(I);
          Continue;
        end;
        if byte(str[i]) >= $81 then begin
          cmdstr := cmdstr + str[i];
          Inc(i);
          if i <= len then
            cmdstr := cmdstr + str[i]
          else begin
            str := '';
            break;
          end;
        end
        else
          cmdstr := cmdstr + str[i];
        Inc(i);
        Continue;
      end
      else if str[i] = '<' then begin
        boCmd := True;
        cmdi := i - 1;
        Inc(i);
        if temp <> '' then begin
          TextOutEx(nLeng, 2, temp, fColor, bColor);
          Inc(nLeng, g_DXCanvas.TextWidth(temp));
          temp := '';
        end;
        cmdstr := '';
        Continue;
      end
      else if byte(str[i]) >= $81 then begin
        fdata := str[i];
        Inc(i);
        if i <= len then
          fdata := fdata + str[i]
        else
          break;
      end
      else
        fdata := str[i];
      if (nLeng + g_DXCanvas.TextWidth(temp + fdata)) > (g_FScreenWidth - 10) then begin
        TextOutEx(nLeng, 2, temp, fColor, bColor);
        str := Copy(str, cmdi + 1, len - cmdi);
        temp := '';
        Break;
      end;
      temp := temp + fdata;
      cmdi := i;
      Inc(i);
    end;
    if temp <> '' then begin
      TextOutEx(nLeng, 2, temp, fColor, bColor);
      str := '';
    end;
    //Canvas.Release;
    New(SayHint);
    SayHint.SaySurface := SaySurface;
    SayHint.AddTime := GetTickCount;
    SayHint.EffectTime := GetTickCount;
    SayHint.EffectIndex := 0;
    if m_SysMsgList.Count > 30 then begin
      SayHint := pTSayHint(m_SysMsgList.Objects[0]);
      SayHint.SaySurface.Free;
      Dispose(SayHint);
      m_SysMsgList.Delete(0);
    end;
    m_SysMsgList.AddObject(tempstr, TObject(SayHint));
    {if m_SysMsgList.Count > ADDSAYCOUNT then begin
      SayHint := pTSayHint(m_SysMsgList.Objects[0]);
      m_SysMsgList.Delete(0);
      SayHint.SaySurface.Free;
      Dispose(SayHint);
    end;    }
    //if str <> '' then
      //AddSysMsg(str, fColor, False, Color);
  end;
end;

procedure TDrawScreen.AddSayMsg(str: string; FColor: TColor; BColor: TColor; boSys: Boolean; UserSayType: TUserSayType; boFirst: Boolean = True;
  DefFColor: TColor = 0; DefBColor: TColor = 0);
var
  ClickName: pTClickName;
  ClickItem: pTClickItem;
  SayImage: pTSayImage;
  SayMessage: pTSayMessage;
  WideStr, WideStr2: WideString;
  i, ii, nid, nident, nindex: integer;
  nLen, nTextLen: integer;
  tstr, tstr2, AddStr, AddStr2, OldStr, OldStr2, cmdstr, sid, sident, sindex, sfcolor, sbcolor: string;
  sname, sClickIndex: string;
  boClickName, boClickItem, boBeginColor, boImage: Boolean;
  nFColor, nBColor: TColor;
  StdItem: TStdItem;
  d: TDirectDrawSurface;
  ClickIndex: integer;
begin
  if Str = '' then Exit;
  WideStr := str;

{$IF Var_Interface = Var_Mir2}
  SayMessage := NewSayMsgEx(DEFSAYLISTWIDTH + g_FScreenWidth - DEFSCREENWIDTH, SAYLISTHEIGHT, UserSayType, BColor);
{$ELSE}
  SayMessage := NewSayMsg(DEFSAYLISTWIDTH, SAYLISTHEIGHT, UserSayType);
{$IFEND}

  if boFirst then begin
{$IF Var_Interface =  Var_Default}
    if boSys then begin
      d := g_WMain99Images.Images[288];
      if d <> nil then begin
        SayMessage.SaySurface.CopyTexture(6, (SAYLISTHEIGHT - d.Height) div 2, d);
      end;
      nLen := 24;
    end else
{$IFEND}
      nLen := 1;

    nFColor := FColor;
    nBColor := BColor;
  end else begin
{$IF Var_Interface =  Var_Default}
    if boSys then nLen := 24
    else nLen := 37;
{$IFEND}
{$IF Var_Interface = Var_Mir2}
    nLen := 3;
{$IFEND}
    nFColor := DefFColor;
    nBColor := DefBColor;
  end;
  with SayMessage.SaySurface do begin
    boClickName := False;
    boClickItem := False;
    boBeginColor := False;
    boImage := False;
    AddStr := '';
    for I := 1 to Length(WideStr) do begin
      tstr := WideStr[i];
      OldStr := Copy(WideStr, I + 1, Length(WideStr));
      if boImage then begin
        if tstr = '#' then begin
          boImage := False;
          nindex := StrToIntDef(cmdstr, -1);
          if nIndex in [Low(g_FaceIndexInfo)..High(g_FaceIndexInfo)] then begin
            if (nLen + SAYFACEWIDTH) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - DEFSCREENWIDTH{$IFEND} - 1) then begin
              OldStr := '#' + cmdstr + '#' + OldStr;
              cmdstr := '';
              Break;
            end else begin
              New(SayImage);
              SayImage.nLeft := nLen;
              SayImage.nRight := nLen + SAYFACEWIDTH;
              SayImage.nIndex := nIndex;
              Inc(nLen, SAYFACEWIDTH);
              if SayMessage.ImageList = nil then SayMessage.ImageList := TList.Create;
              SayMessage.ImageList.Add(SayImage);
            end;
          end;
          cmdstr := '';
        end else cmdstr := cmdstr + tstr;
      end else
      if boClickName then begin
        if tstr = #7 then begin
          ClickIndex := 0;
          boClickName := False;
          sClickIndex := GetValidStr3(cmdstr, sname, ['\']);
          if sClickIndex <> '' then ClickIndex := StrToIntDef(sClickIndex, 0);
          cmdstr := sname;
          nTextLen := g_DXCanvas.TextWidth(cmdstr);
          if (nLen + nTextLen) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - DEFSCREENWIDTH{$IFEND} - 1) then begin
            WideStr2 := cmdstr;
            cmdstr := '';
            AddStr2 := '';
            for ii := 1 to Length(WideStr2) do begin
              tstr2 := WideStr2[ii];
              OldStr2 := Copy(WideStr2, ii + 1, Length(WideStr2));
              if (nLen + g_DXCanvas.TextWidth(AddStr2 + tstr2)) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - DEFSCREENWIDTH{$IFEND} - 1) then begin
                nTextLen := g_DXCanvas.TextWidth(AddStr2);
                New(ClickName);
                ClickIndex := Integer(ClickName);
                ClickName.nLeft := nLen;
                ClickName.sStr := AddStr2;
                ClickName.nRight := nLen + nTextLen;
                ClickName.Index := ClickIndex;
                if SayMessage.ClickList = nil then SayMessage.ClickList := TList.Create;
                SayMessage.ClickList.Add(ClickName);
                TextOutEx(nLen, 2, AddStr2, {$IF Var_Interface =  Var_Default}clYellow{$ELSE}nFColor, nBColor{$IFEND});
                Inc(nLen, nTextLen);
                AddStr2 := '';
                OldStr2 := tstr2 + OldStr2;
                break;
              end else AddStr2 := AddStr2 + tstr2;
            end;
            AddStr := '';
            OldStr := #7 + OldStr2 + '\' + IntToStr(ClickIndex) + #7 + OldStr;
            cmdstr := '';
            break;
          end else begin
            New(ClickName);
            ClickName.nLeft := nLen;
            ClickName.sStr := cmdstr;
            ClickName.nRight := nLen + nTextLen;
            ClickName.Index := ClickIndex;
            TextOutEx(nLen, 2, cmdstr, {$IF Var_Interface =  Var_Default}clYellow{$ELSE}nFColor, nBColor{$IFEND});
            Inc(nLen, nTextLen);
            cmdstr := '';
            if SayMessage.ClickList = nil then SayMessage.ClickList := TList.Create;
            SayMessage.ClickList.Add(ClickName);
          end;

        end else cmdstr := cmdstr + tstr;
      end else
      if boClickItem then begin
        if tstr = '}' then begin
          boClickItem := False;
          cmdstr := GetValidStr3(cmdstr, sid, ['/']);
          cmdstr := GetValidStr3(cmdstr, sident, ['/']);
          cmdstr := GetValidStr3(cmdstr, sindex, ['/']);
          cmdstr := GetValidStr3(cmdstr, sname, ['/']);
          cmdstr := GetValidStr3(cmdstr, sClickIndex, ['/']);
          cmdstr := '';
          nid := StrToIntDef(sid, -1);
          nident := StrToIntDef(sident, -1);
          nindex := StrToIntDef(sindex, 0);
          if (nId >= 0) and (nident > 0) and (nindex <> 0) then begin
            StdItem := GetStdItem(nident);
            if StdItem.Name <> '' then begin
              ClickIndex := 0;
              if sClickIndex <> '' then begin
                cmdstr := sname;
                ClickIndex := StrToIntDef(sClickIndex, 0);
              end else cmdstr := '<' + StdItem.Name + '>';
              nTextLen := g_DXCanvas.TextWidth(cmdstr);
              if (nLen + nTextLen) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - DEFSCREENWIDTH{$IFEND} - 1) then begin
                WideStr2 := cmdstr;
                cmdstr := '';
                AddStr2 := '';
                for ii := 1 to Length(WideStr2) do begin
                  tstr2 := WideStr2[ii];
                  OldStr2 := Copy(WideStr2, ii + 1, Length(WideStr2));
                  if (nLen + g_DXCanvas.TextWidth(AddStr2 + tstr2)) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - DEFSCREENWIDTH{$IFEND} - 1) then begin
                    nTextLen := g_DXCanvas.TextWidth(AddStr2);
                    New(ClickItem);
                    SafeFillChar(ClickItem^, SizeOf(TClickItem), #0);
                    ClickIndex := Integer(ClickItem);
                    ClickItem.nLeft := nLen;
                    ClickItem.sStr := AddStr2;
                    ClickItem.nRight := nLen + nTextLen;
                    ClickItem.nIndex := nid;
                    ClickItem.wIdent := nident;
                    ClickItem.ItemIndex := nindex;
                    ClickItem.Index := ClickIndex;
                    if SayMessage.ItemList = nil then SayMessage.ItemList := TList.Create;
                    SayMessage.ItemList.Add(ClickItem);
                    TextOutEx(nLen, 2, AddStr2, $03ABFC);
                    Inc(nLen, nTextLen);
                    AddStr2 := '';
                    OldStr2 := tstr2 + OldStr2;
                    break;
                  end else AddStr2 := AddStr2 + tstr2;
                end;
                AddStr := '';
                OldStr := '{' + sid + '/' + sident + '/' + sindex + '/' + OldStr2 + '/' + IntToStr(ClickIndex) + '}' + OldStr;
                cmdstr := '';
                Break;
              end else begin
                New(ClickItem);
                SafeFillChar(ClickItem^, SizeOf(TClickItem), #0);
                ClickItem.nLeft := nLen;
                ClickItem.sStr := cmdstr;
                ClickItem.nRight := nLen + nTextLen;
                ClickItem.nIndex := nid;
                ClickItem.wIdent := nident;
                ClickItem.ItemIndex := nindex;
                ClickItem.Index := ClickIndex;
                TextOutEx(nLen, 2, cmdstr, $03ABFC);         
                Inc(nLen, nTextLen);
                cmdstr := '';
                if SayMessage.ItemList = nil then SayMessage.ItemList := TList.Create;
                SayMessage.ItemList.Add(ClickItem);
              end;
            end;
          end;
        end else cmdstr := cmdstr + tstr;
      end else
      if boBeginColor then begin
        if tstr = #6 then begin
          boBeginColor := False;
          sbcolor := GetValidStr3(cmdstr, sfcolor, ['/']);
{$IF Var_Interface =  Var_Default}
          nFColor := StrToIntDef('$' + sfcolor, FColor);
          nBColor := StrToIntDef('$' + sbcolor, BColor);
{$IFEND}
          cmdstr := '';
        end else cmdstr := cmdstr + tstr;
      end else begin
        if tstr = #7 then begin
          boClickName := True;
          TextOutEx(nLen, 2, AddStr, nFColor, nBColor);
          Inc(nLen, g_DXCanvas.TextWidth(AddStr));
          AddStr := '';
          cmdstr := '';
        end else
        if tstr = '{' then begin
          boClickItem := True;
          TextOutEx(nLen, 2, AddStr, nFColor, nBColor);
          Inc(nLen, g_DXCanvas.TextWidth(AddStr));
          AddStr := '';
          cmdstr := '';
        end else
        if tstr = #6 then begin
          boBeginColor := True;
          TextOutEx(nLen, 2, AddStr, nFColor, nBColor);
          Inc(nLen, g_DXCanvas.TextWidth(AddStr));
          AddStr := '';
          cmdstr := '';
        end else
        if tstr = #5 then begin
          TextOutEx(nLen, 2, AddStr, nFColor, nBColor);
          Inc(nLen, g_DXCanvas.TextWidth(AddStr));
          AddStr := '';
          cmdstr := '';
{$IF Var_Interface =  Var_Default}
          nFColor := FColor;
          nBColor := BColor;
{$IFEND}
        end else
        if tstr = '#' then begin
          boImage := True;
          TextOutEx(nLen, 2, AddStr, nFColor, nBColor);
          Inc(nLen, g_DXCanvas.TextWidth(AddStr));
          AddStr := '';
          cmdstr := '';
        end else
        if (nLen + g_DXCanvas.TextWidth(AddStr + tstr)) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - DEFSCREENWIDTH{$IFEND} - 1) then begin
          TextOutEx(nLen, 2, AddStr, nFColor, nBColor);
          Inc(nLen, g_DXCanvas.TextWidth(AddStr));
          AddStr := '';
          cmdstr := '';
          OldStr := tstr + OldStr;
          Break;
        end else AddStr := AddStr + tstr;
      end;
    end;
    if AddStr <> '' then begin
      TextOutEx(nLen, 2, AddStr, nFColor, nBColor);
{$IF Var_Interface = Var_Mir2}
      Inc(nLen, g_DXCanvas.TextWidth(AddStr));
{$IFEND}
    end;
    //Release;
{$IF Var_Interface = Var_Mir2}
    ClearBit(SayMessage, nLen);
{$IFEND}
    m_NewSayMsgList.Add(SayMessage);
    if (UserSayType = g_SayShowType) or (g_SayShowType = us_All) or
      ((g_SayShowType = us_Custom) and (UserSayType in g_SayShowCustom)) then begin
      m_SayTransferList.Add(SayMessage);
    end else
    if (UserSayType in [us_Hear, us_Whisper, us_Cry, us_Group, us_Guild, us_Sys]) then begin
      g_SayEffectIndex[UserSayType] := True;
    end;
    if m_NewSayMsgList.Count > 100 then begin
      SayMessage := m_NewSayMsgList[0];
      DelTransferMsg(SayMessage);
      DisposeSayMsg(SayMessage);
      Dispose(SayMessage);
      m_NewSayMsgList.Delete(0);
    end;
    FrmDlg.DSayUpDown.MaxPosition := _MAX(0, m_SayTransferList.count - FrmDlg.DWndSay.Height div SAYLISTHEIGHT);
    if not g_SayUpDownLock then
      FrmDlg.DSayUpDown.Position := FrmDlg.DSayUpDown.MaxPosition;
    if OldStr <> '' then
      AddSayMsg(OldStr, FColor, BColor, boSys, UserSayType, False, nFColor, nBColor);
  end;
end;
(*
procedure TDrawScreen.AddChatBoardString(str: string; fcolor, bcolor: Integer);
  {procedure AddStrToList(StrList: TStringList; Msg: string);
  var
    nLen: Integer;
    d: TDirectDrawSurface;
  begin
    nLen := frmMain.Canvas.TextWidth(Msg);
    d := TDirectDrawSurface.Create(frmMain.DXDraw.DDraw);
    d.SystemMemory := True;
    d.SetSize(nLen, SAYLISTHEIGHT);
    d.Canvas.Font.Name := DEFFONTNAME;
    d.Canvas.Font.Size := DEFFONTSIZE;
    //d.Fill(bcolor);
    SetBkMode(d.Canvas.Handle, TRANSPARENT);
    //d.Canvas.Font.Color := fcolor;
    //d.Canvas.Brush.Color := bcolor;
    BoldTextOutEx(d, 0, (SAYLISTHEIGHT - 12) div 2, fcolor, bcolor, Msg);
    //d.Canvas.TextOut(0, (SAYLISTHEIGHT - 12) div 2, Msg);
    d.Canvas.Release;
    StrList.AddObject(Msg, TObject(d));
  end;
var
  i, len, aline, cmdi: Integer;
  temp, fdata: string;
const
  BOXWIDTH = 295 - 18; //41 聊天框文字宽度 }
begin
  {len := Length(str);
  temp := '';
  i := 1;
  cmdi := 1;
  while True do begin
    if i > len then
      break;
    if byte(str[i]) >= 128 then begin
      fdata := str[i];
      Inc(i);
      if i <= len then
        fdata := fdata + str[i]
      else
        break;
    end
    else
      fdata := str[i];

    aline := frmMain.Canvas.TextWidth(temp + fdata);
    if aline > BOXWIDTH then begin
      AddStrToList(ChatStrs, temp);
      str := Copy(str, cmdi + 1, len - cmdi);
      temp := '';
      break;
    end;
    temp := temp + fdata;
    cmdi := i;
    Inc(i);
  end;
  if temp <> '' then begin
    AddStrToList(ChatStrs, temp);
    str := '';
  end;          
  if ChatStrs.Count > 200 then begin
    TDirectDrawSurface(ChatStrs.Objects[0]).Free;
    ChatStrs.Delete(0);
    if ChatStrs.Count - ChatBoardTop < VIEWCHATLINE then
      Dec(ChatBoardTop);
  end
  else if (ChatStrs.Count - ChatBoardTop) > VIEWCHATLINE then begin
    Inc(ChatBoardTop);
  end;
  if str <> '' then
    AddChatBoardString(' ' + str, fcolor, bcolor); }
end;       *)

procedure TDrawScreen.ShowHintEx(X, Y: Integer; str: string);
begin
  ClearHint;
end;
//鼠标放在某个物品上显示的信息   清清 2007.10.21
Function TDrawScreen.ShowHint(X, Y: Integer; str: string; Color: TColor;
  drawup: Boolean; ShowIndex: Integer; boItemHint: Boolean; HintSurface:TDirectDrawSurface;
  HintList: TList; boLeft: Boolean): TPoint;
var
  data, fdata, cmdstr, scmdstr, cmdparam, sFColor, sBColor, sTemp: string;
  w, h, addw, addh, offHint: Integer;
  HintColor, OldHintColor, FColor, BColor: TColor;
  boEndColor: Boolean;
  boMove: Boolean;
  boTransparent: Boolean;
  dc, rc: TRect;
  dwTime: LongWord;
  boReduce: Byte;
  nAlpha: Integer;
  Idx, nMin, nMax: Integer;
  mfid, mmid, mx, my, ax, ay, ii: Integer;
  sName, sparam, sMin, sMax: string;
  d: TDirectDrawSurface;
  ShowHint: pTNewShowHint;
  boBlend: Boolean;
begin
  ClearHint;
  HintX := X;
  HintY := Y;
  Result.X := 0;
  Result.Y := 0;
  addw := 0;
//  addh := 0;
  if HintSurface = nil then HintSurface := m_HintSurface;
  if HintList = nil then HintList := m_HintList;


  if (GetTickCount > SurfaceRefTick) or (nShowIndex <> ShowIndex) then begin
    nShowIndex := ShowIndex;
    SurfaceRefTick := GetTickCount + 100;
    ClearHint(True);
    HintSurface.Clear;
    HintWidth := 0;
    HintHeight := 0;
    HintUp := drawup;
    OldHintColor := Color;
    HintColor := Color;
    boEndColor := False;
    //SetBkMode(HintSurface.Canvas.Handle, TRANSPARENT);
    offHint := g_DXCanvas.TextHeight('A');
    if boItemHint then h := 14
    else h := 5;
    addh := h;
    while True do begin
      if str = '' then break;
      if h >= (g_FScreenHeight - 20) then begin
        if boItemHint then begin
          if (h + 9) > HintHeight then
            HintHeight := HintHeight + h + 9;
        end else begin
          if (h + 3) > HintHeight then
            HintHeight := HintHeight + h + 3;
        end;
        //HintHeight := HintHeight + h + 2;
        h := addh;
        addw := HintWidth + 10;
      end;
      str := GetValidStr3(str, data, ['\']);
      if boItemHint then begin
        w := 12 + addw;
      end else begin
        w := 7 + addw;
      end;
      if data <> '' then begin
        while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do
          begin
          fdata := '';
          if data[1] <> '<' then begin
            data := '<' + GetValidStr3(data, fdata, ['<']);
          end;
          if fdata <> '' then begin
            HintSurface.TextOutEx(w, h, fdata, HintColor);
            Inc(w, g_DXCanvas.TextWidth(fdata));
            Continue;
          end;
          data := ArrestStringEx(data, '<', '>', cmdstr);
          if cmdstr <> '' then begin
            if CompareLStr(cmdstr, 'COLOR', Length('COLOR')) then begin
              sFColor := GetValidStr3(cmdstr, sTemp, ['=']);
              HintColor := StrToIntDef(sFColor, Color);
              //HintColor := GetRGBEx(GetBValue(HintColor),GetGValue(HintColor),GetRValue(HintColor));
              Continue;
            end
            else if CompareLStr(cmdstr, 'ENDCOLOR', Length('ENDCOLOR')) then begin
              data := fdata;
              boEndColor := True;
              Continue;
            end
            else if CompareLStr(cmdstr, 'x', Length('x')) then begin
              scmdstr := GetValidStr3(cmdstr, sTemp, ['=']);
              w := w + StrToIntDef(scmdstr, 0);
              Continue;
            end
            else if CompareLStr(cmdstr, 'y', Length('y')) then begin
              scmdstr := GetValidStr3(cmdstr, sTemp, ['=']);
              h := h + StrToIntDef(scmdstr, 0);
              Continue;
            end
            else if CompareText(cmdstr, 'Height') = 0 then begin
              addh := h;
              Continue;
            end
            else if CompareText(cmdstr, 'SetItem') = 0 then begin
              //HintHeight := HintHeight + h + 2;
              if boItemHint then begin
                if (h + 9) > HintHeight then
                  HintHeight := {HintHeight +} h + 9;
              end else begin
                if (h + 3) > HintHeight then
                  HintHeight := {HintHeight +} h + 3;
              end;
              h := 14;
              addw := HintWidth + 10;
              Continue;
            end
            else if CompareText(cmdstr, 'Line') = 0 then begin
              //addh := h;
              Inc(h, 4);
              New(ShowHint);
              SafeFillChar(ShowHint^, SizeOf(TNewShowHint), #0);
              ShowHint.boLine := True;
              ShowHint.nX := w;
              ShowHint.nY := h;
              HintList.Add(ShowHint);
              Inc(h, 5);
              Continue;
            end
            else if CompareLStr(cmdstr, 'img', length('img')) then begin //new
              scmdstr := GetValidStr3(cmdstr, sTemp, ['=']);
              boTransparent := True;
              boMove := False;
              mfid := -1;
              mmid := -1;
              mx := 0;
              my := 0;
              dwTime := 100;
              boReduce := 0;
              nAlpha := 255;
              boBlend := False;
              while True do begin
                if scmdstr = '' then Break;
                scmdstr := GetValidStr3(scmdstr, stemp, [',']);
                if stemp = '' then Break;
                sTemp := LowerCase(stemp);
                sparam := GetValidStr3(stemp, sName, ['.']);
                if (sName <> '') and (sparam <> '') then begin
                  case sName[1] of
                    'f': begin
                        mfid := StrToIntDef(sparam, -1);
                        if not (mfid in [Images_Begin..Images_End]) then
                          mfid := -1;
                      end;
                    'i': begin
                        NpcTempList.Clear;
                        if ExtractStrings(['+'], [], PChar(sparam), NpcTempList) > 0 then begin
                          Idx := 0;
                          while True do begin
                            if Idx >= NpcTempList.Count then Break;
                            sTemp := NpcTempList[Idx];
                            if pos('-', sTemp) > 0 then begin
                              sMax := GetValidStr3(stemp, sMin, ['-']);
                              nMin := StrToIntDef(sMin, 0);
                              nMax := StrToIntDef(sMax, 0);
                              if nMin = 0 then nMin := nMax;
                              if nMax = 0 then nMax := nMin;
                              if nMin > nMax then nMin := nMax;
                              NpcTempList.Delete(Idx);
                              if nMin <> 0 then begin
                                for ii := nMin to nMax do begin
                                  NpcTempList.Insert(Idx, IntToStr(ii));
                                  Inc(idx);
                                end;
                              end;

                            end
                            else
                              Inc(Idx);
                          end;
                        end
                        else
                          NpcTempList.add(sparam);
                      end;
                    'x': mx := StrToIntDef(sparam, 0);
                    'y': my := StrToIntDef(sparam, 0);
                    'b': boBlend := (sparam = '1');
                    'p': boTransparent := (sparam = '1');
                    'm': boMove := (sparam = '1');
                    't': dwTime := StrToIntDef(sparam, 0);
                    'a': nAlpha := StrToIntDef(sparam, 255);
                  end;
                end;
              end;
              if (mfid > -1) and (g_ClientImages[mfid] <> nil) and (NpcTempList.Count > 0) then begin
                if mx = 0 then
                  mx := w;
                if my = 0 then
                  my := h;
                New(ShowHint);
                SafeFillChar(ShowHint^, SizeOf(TNewShowHint), #0);
                ShowHint.Surfaces := g_ClientImages[mfid];
                ShowHint.IndexList := NpcTempList;
                ShowHint.nX := mx;
                ShowHint.nY := mY;
                ShowHint.boTransparent := boTransparent;
                ShowHint.Alpha := nAlpha;
                ShowHint.dwTime := dwTime;
                ShowHint.boBlend := boBlend;
                ShowHint.boMove := boMove;
                HintList.Add(ShowHint);
                NpcTempList := TStringList.Create;
              end;
              Continue;
            end
            else begin
              cmdparam := GetValidStr3(cmdstr, cmdstr, ['^']);
              if cmdparam = '' then
                cmdparam := GetValidStr3(cmdstr, cmdstr, ['/']);
            end;
          end;
          if cmdstr <> '' then begin
            sFColor := '';
            sBColor := '';
            FColor := HintColor;
//            BColor := $8;
            if pos(',', cmdparam) > 0 then begin
              sBColor := GetValidStr3(cmdparam, sFColor, [',']);
            end
            else
              sFColor := cmdparam;

            if CompareLStr(sFColor, 'FCOLOR', length('FCOLOR')) then begin
              sFColor := GetValidStr3(sFColor, sTemp, ['=']);
              FColor := StrToIntDef(sFColor, Color);
              //pHint.FColor := GetRGBEx(GetBValue(pHint.FColor),GetGValue(pHint.FColor),GetRValue(pHint.FColor));
            end;
            if CompareLStr(sBColor, 'BCOLOR', length('BCOLOR')) then begin
              sBColor := GetValidStr3(sBColor, sTemp, ['=']);
//              BColor := StrToIntDef(sBColor, Color);
            end;
            HintSurface.TextOutEx(w, h, cmdstr, FColor);
            Inc(w, g_DXCanvas.TextWidth(cmdstr));
          end;
        end;
        if data <> '' then begin
          HintSurface.TextOutEx(w, h, data, HintColor);
          Inc(w, g_DXCanvas.TextWidth(data));
        end;
        if boEndColor then
          HintColor := OldHintColor;
        boEndColor := False;
        if boItemHint then begin
          if (w + 10) > HintWidth then
            HintWidth := w + 10;
        end else begin
          if (w + 5) > HintWidth then
            HintWidth := w + 5;
        end;
        Inc(h, offHint + 1);
      end;
    end;
    //HintSurface.Canvas.Release;
    if boItemHint then
      HintWidth := _MAX(150, HintWidth);
    if boItemHint then begin
      if (h + 9) > HintHeight then
        HintHeight := {HintHeight +} h + 9;
    end else begin
      if (h + 3) > HintHeight then
        HintHeight := {HintHeight +} h + 3;
    end;
  end;
  if HintUp then
    HintY := HintY - HintHeight;
  if boItemHint then begin
    if HintX > 370 then
      HintX := HintX - HintWidth div 2;
  end;
  boShowSurface := True;
  Result.X := HintWidth;
  Result.Y := HintHeight;
  //HintX := 20;
  //HintY := (g_FScreenHeight - HintHeight) div 2;
end;
//清除鼠标放在某个物品上显示的信息   清清 2007.10.21
procedure TDrawScreen.ClearHint(boClear: Boolean);
var
  i: integer;
begin
  boShowSurface := False;
  if boClear then begin
    for i := 0 to m_HintList.Count - 1 do begin
      if pTNewShowHint(m_HintList[i]).IndexList <> nil then
        pTNewShowHint(m_HintList[i]).IndexList.Free;
      Dispose(pTNewShowHint(m_HintList[i]));
    end;
    m_HintList.Clear;
  end;
end;

procedure TDrawScreen.ClearSysMsg;
var
  SayHint: pTSayHint;
  I: Integer;
begin
  for I := 0 to m_SysMsgList.Count - 1 do begin
    SayHint := pTSayHint(m_SysMsgList.Objects[I]);
    SayHint.SaySurface.Free;
    Dispose(SayHint);
  end;
  m_SysMsgList.Clear;
  for I := 0 to m_SysInfoList.Count - 1 do begin
    Dispose(pTAddSysInfo(m_SysInfoList[I]));
  end;
  m_SysInfoList.Clear;
end;

procedure TDrawScreen.ChangeTransferMsg(UserSaySet: TUserSaySet);
var
  i: Integer;
  UserSayType: TUserSayType;
begin
  for UserSayType in UserSaySet do
    g_SayEffectIndex[UserSayType] := False;
  m_SayTransferList.Clear;
  for I := 0 to m_NewSayMsgList.Count - 1 do begin
    if (pTSayMessage(m_NewSayMsgList[I]).UserSayType in UserSaySet) then begin
      m_SayTransferList.Add(m_NewSayMsgList[I]);
    end;
  end;
  FrmDlg.DSayUpDown.MaxPosition := _MAX(0, m_SayTransferList.count - FrmDlg.DWndSay.Height div SAYLISTHEIGHT);
  if not g_SayUpDownLock then
    FrmDlg.DSayUpDown.Position := FrmDlg.DSayUpDown.MaxPosition;
end;

procedure TDrawScreen.DelTransferMsg(SayMessage: pTSayMessage);
var
  i: Integer;
begin
  for I := 0 to m_SayTransferList.Count - 1 do begin
    if m_SayTransferList[I] = SayMessage then begin
      m_SayTransferList.Delete(I);
      break;
    end;
  end;
end;

procedure TDrawScreen.DisposeSayMsg(SayMessage: pTSayMessage);
var
  i: integer;
begin
  if SayMessage.ClickList <> nil then begin
    for I := 0 to SayMessage.ClickList.Count - 1 do begin
      Dispose(pTClickName(SayMessage.ClickList[i]));
    end;
    SayMessage.ClickList.Free;
    SayMessage.ClickList := nil;
  end;
  if SayMessage.ItemList <> nil then begin
    for I := 0 to SayMessage.ItemList.Count - 1 do begin
      Dispose(pTClickItem(SayMessage.ItemList[i]));
    end;
    SayMessage.ItemList.Free;
    SayMessage.ItemList := nil;
  end;

  if SayMessage.ImageList <> nil then begin
    for I := 0 to SayMessage.ImageList.Count - 1 do begin
      Dispose(pTSayImage(SayMessage.ImageList[i]));
    end;
    SayMessage.ImageList.Free;
    SayMessage.ImageList := nil;
  end;

  if SayMessage.SaySurface <> nil then begin
    SayMessage.SaySurface.Free;
    SayMessage.SaySurface := nil;
  end;
end;

Function  TDrawScreen.NewSayMsgEx(nWidth, nHeight:Integer; UserSayType: TUserSayType; BColor: Cardinal): pTSayMessage;
var
  Access: TDXAccessInfo;
  wBColor: Word;
  RGBQuad: TRGBQuad;
  Y, X: Integer;
  WriteBuffer: PWord;
begin
  New(Result);
  Result.ClickList := nil;
  Result.ItemList := nil;
  Result.ImageList := nil;
  Result.SaySurface := MakeDXImageTexture(nWidth, nHeight, WILFMT_A4R4G4B4, g_DXCanvas);
  if Result.SaySurface <> nil then begin
    Result.SaySurface.Clear;
    Result.UserSayType := UserSayType;
    BColor := DisplaceRB(BColor or $FF000000);
    RGBQuad := PRGBQuad(@BColor)^;
    wBColor := ($F0 shl 8) + ((WORD(RGBQuad.rgbRed) and $F0) shl 4) + (WORD(RGBQuad.rgbGreen) and $F0) + (WORD(RGBQuad.rgbBlue) shr 4);
    if Result.SaySurface.Lock(lfWriteOnly, Access) then begin
      Try
        for Y := 0 to Result.SaySurface.Height - 1 do begin
          WriteBuffer := PWord(Integer(Access.Bits) + Access.Pitch * Y);
          for X := 0 to Result.SaySurface.Width - 1 do begin
            WriteBuffer^ := wBColor;
            Inc(WriteBuffer);
          end;
        end;
      Finally
        Result.SaySurface.Unlock;
      End;
    end;
  end;
end;

Function TDrawScreen.NewSayMsg(nWidth, nHeight:Integer; UserSayType: TUserSayType): pTSayMessage;
begin
  //Result := nil;
  New(Result);
  {Result.SayMsg := '';
  Result.boFirst := False;
  Result.boSys := False;  }
  Result.ClickList := nil;
  Result.ItemList := nil;
  Result.ImageList := nil;
  Result.SaySurface := MakeDXImageTexture(nWidth, nHeight, WILFMT_A4R4G4B4, g_DXCanvas);
  Result.SaySurface.Clear;
  //Result.boTransfer := False;
  Result.UserSayType := UserSayType;
  {Result.SaySurface.Canvas.Font.Name := DEFFONTNAME;
  Result.SaySurface.Canvas.Font.Size := DEFFONTSIZE;}
end;

procedure TDrawScreen.ClearBit(SayMessage: pTSayMessage; nMaxLen: Integer);
var
  Access: TDXAccessInfo;
  Y, X: Integer;
  WriteBuffer: PWord;
begin
  if SayMessage.SaySurface <> nil then begin
    Inc(nMaxLen);
    if nMaxLen >= SayMessage.SaySurface.Width then Exit;
    if SayMessage.SaySurface.Lock(lfWriteOnly, Access) then begin
      Try
        for Y := 0 to SayMessage.SaySurface.Height - 1 do begin
          WriteBuffer := PWord(Integer(Access.Bits) + Access.Pitch * Y);
          Inc(WriteBuffer, nMaxLen);
          for X := nMaxLen to SayMessage.SaySurface.Width - 1 do begin
            WriteBuffer^ := 0;
            Inc(WriteBuffer);
          end;
        end;
      Finally
        SayMessage.SaySurface.Unlock;
      End;
    end;
  end;
end;

procedure TDrawScreen.ClearChatBoard;
var
  i: Integer;
  SayHint: ptSayHint;
  SayMessage: pTSayMessage;
begin
  for i := 0 to m_SysMsgList.Count - 1 do begin
    SayHint := ptSayHint(m_SysMsgList.Objects[i]);
    SayHint.Saysurface.free;
    Dispose(SayHint);
  end;
  m_SysMsgList.Clear;

  for I := 0 to m_SysInfoList.Count - 1 do begin
    Dispose(pTAddSysInfo(m_SysInfoList[I]));
  end;
  m_SysInfoList.Clear;

  for I := 0 to m_NewSayMsgList.Count - 1 do begin
    SayMessage := m_NewSayMsgList[i];
    DisposeSayMsg(SayMessage);
    Dispose(SayMessage);
  end;
  m_NewSayMsgList.Clear;
  m_SayTransferList.Clear;
end;

procedure TDrawScreen.DrawScreen(MSurface: TDirectDrawSurface);
begin
  if CurrentScene <> nil then
    CurrentScene.PlayScene(MSurface);
end;
//显示左上角信息文字

procedure TDrawScreen.DrawScreenTop(MSurface: TDirectDrawSurface);
var
  ax, ay: integer;
  SayHint: pTSayHint;
  i: integer;
  nAlpha: Integer;
  boTop: Boolean;
  EffectTime: LongWord;
  AddSysInfo: pTAddSysInfo;
begin
  if g_MySelf = nil then Exit;
  if GetTickCount > m_nShowSysTick then begin
    if m_SysInfoList.Count > 6 then begin
      for I := 0 to m_SysMsgList.Count - 1 do begin
        SayHint := pTSayHint(m_SysMsgList.Objects[i]);
        SayHint.SaySurface.Free;
        Dispose(SayHint);
      end;
      m_SysMsgList.Clear;
    end;
    for I := 0 to m_SysInfoList.Count - 1 do begin
      AddSysInfo := m_SysInfoList[I];
      AddSysMsgEx(AddSysInfo.str, AddSysInfo.Color, AddSysInfo.boFirst, AddSysInfo.DefColor);
      Dispose(AddSysInfo);
    end;
    m_SysInfoList.Clear;
    m_nShowSysTick := GetTickCount + 1000;
  end;
  //ax := 360;

{$IF Var_Interface = Var_Mir2}
  ay := g_FScreenHeight - 310;
{$ELSE}
  ay := 70;
{$IFEND}
  I := 0;
  nAlpha := 0;
  boTop := False;
  if m_SysMsgList.Count > ADDSAYCOUNT then EffectTime := _MAX(100 - (m_SysMsgList.Count - ADDSAYCOUNT) * 10, 30)
  else EffectTime := 100;
  while True do begin
    if (I >= m_SysMsgList.Count) or (I > ADDSAYCOUNT) then break;
    SayHint := pTSayHint(m_SysMsgList.Objects[i]);
{$IF Var_Interface = Var_Mir2}
    ax := 30;
{$ELSE}
    ax := (g_FScreenWidth - SayHint.SaySurface.Width - 20) div 2;
{$IFEND}
    if I = ADDSAYCOUNT then begin
      if boTop then begin
        MSurface.Draw(ax, ay, SayHint.SaySurface.ClientRect, SayHint.SaySurface, (250 - nAlpha) shl 24 or $FFFFFF, fxBlend);
      end;
      break;
    end;
    if (((GetTickCount - SayHint.AddTime) > 4000) or
      (m_SysMsgList.Count > ADDSAYCOUNT)) and (I = 0) then begin
      boTop := True;
      if GetTickCount > SayHint.EffectTime then begin
        SayHint.EffectTime := GetTickCount + EffectTime;
        Inc(SayHint.EffectIndex);
      end;
      if SayHint.EffectIndex >= 8 then begin
        boTop := False;
        SayHint.SaySurface.Free;
        Dispose(SayHint);
        m_SysMsgList.Delete(i);
        Continue;
      end
      else begin
        nAlpha := Round(250 - 250 / 7 * SayHint.EffectIndex);
        Dec(ay, SayHint.EffectIndex * 2);
        MSurface.Draw(ax, ay, SayHint.SaySurface.ClientRect, SayHint.SaySurface, nAlpha shl 24 or $FFFFFF, fxBlend);
      end;
    end
    else begin
      MSurface.Draw(ax, ay, SayHint.SaySurface.ClientRect, SayHint.SaySurface, True);
    end;
    Inc(I);
    Inc(ay, ADDSAYHEIGHT);
  end;
end;

procedure TDrawScreen.DrawHintEx(MSurface, HintSurface: TDirectDrawSurface; nX, nY, HWidth, HHeight: Integer;
  HintList: TList);
var
  d: TDirectDrawSurface;
  hx, hy: Integer;
  defRect: TRect;
  i: integer;
  ShowHint: pTNewShowHint;
  Index, px, py: Integer;
  dwTime: LongWord;
begin
  if nX + HWidth > g_FScreenWidth then hx := g_FScreenWidth - HWidth
  else hx := nX;
  if nY + HHeight > g_FScreenHeight then hy := g_FScreenHeight - HHeight
  else hy := nY;
  if hY < 0 then hy := 0;
  if hx < 0 then hx := 0;
  g_DXCanvas.FillRect(hx + 1, hy + 1, HWidth - 2, HHeight - 2, BGSURFACECOLOR or $C8000000);
  defRect.Left := 0;
  defRect.Top := 0;
  defRect.Right := HWidth;
  defRect.Bottom := HHeight;
  MSurface.Draw(hx, hy, defRect, HintSurface, True);
  dwTime := GetTickCount;
  for i := 0 to HintList.Count - 1 do begin
    ShowHint := HintList[i];
    if ShowHint.boLine then begin
      g_DXCanvas.MoveTo(hx + ShowHint.nX, hy + ShowHint.ny);
      g_DXCanvas.LineTo(hx + HWidth - 12, hy + ShowHint.ny, $727474);
    end else
    if (ShowHint.Surfaces <> nil) and (ShowHint.IndexList <> nil) and (ShowHint.IndexList.Count > 0) then begin
      Index := dwTime div ShowHint.dwTime mod LongWord(ShowHint.IndexList.Count);
      d := ShowHint.Surfaces.GetCachedImage(StrToIntDef(ShowHint.IndexList[Index], -1), px, py);
      if d <> nil then begin
        if ShowHint.boMove then begin
          px := ShowHint.nX + px;
          py := ShowHint.ny + py;
        end else begin
          px := ShowHint.nX;
          py := ShowHint.ny;
        end;
        if ShowHint.boBlend then DrawBlendR(MSurface, hx + px, hy + py, d.ClientRect, d, Integer(ShowHint.boTransparent))
        else MSurface.Draw(hx + px, hy + py, d.ClientRect, d, ShowHint.boTransparent);
      end;
    end;
  end;
  with g_DXCanvas do begin
    RoundRect(hx, hy, hx + HWidth, hy + HHeight, 5, 5, clBlack);
    RoundRect(hx + 1, hy + 1, hx + (HWidth - 1), hy + (HHeight - 1), clBlack);
    RoundRect(hx + 1, hy + 1, hx + (HWidth - 1), hy + (HHeight - 1), 5, 5, $727474);
  end;
end;

//显示提示信息
procedure TDrawScreen.DrawHint(MSurface: TDirectDrawSurface);
begin
  if boShowSurface then
    DrawHintEx(MSurface, m_HintSurface, HintX, HintY, HintWidth, HintHeight, m_HintList);
end;

end.
