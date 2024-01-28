unit DrawScrn;
// 其实更准确地说是文本绘制器，因为整个场景的实际绘图工作已经在 introscrn.pas 和 playscrn.pas 中完成了
// TODO 参考 GEE 以及 GOM 引擎，可以将一些特效放在屏幕中间，以字幕形式展示出来
interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, HGE, 
  IntroScn, HGETextures, DirectXGraphics, HGEBase, 
  HUtil32, MShare, wil, Resource;

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

  TDrawScreen = class
  private
  public
    CurrentScene: TScene;
    m_SysMsgList: TStringList;
    m_SysInfoList: TList;
    m_NewSayMsgList: TList;
    m_SayTransferList: TList;

    HintX, HintY, HintWidth, HintHeight: Integer;
    HintUp: Boolean;

    NpcTempList: TStringList;
    AutoImgTime: LongWord;
    m_HintSurface: TDirectDrawSurface;
    m_HintList: TList;
    SurfaceRefTick: LongWord;
    boShowSurface: Boolean;
    nShowIndex: Integer;
    m_nShowSysTick: LongWord;

    constructor Create;
    destructor Destroy; override;

    procedure Initialize;
    procedure Finalize;

    procedure KeyPress(var Key: Char);
    procedure KeyDown(var Key: Word; Shift: TShiftState);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure AddSysMsgEx(str: string; Color: TColor; boFirst: Boolean = True; DefColor: TColor = 0);
    procedure AddSysMsg(str: string; Color: TColor; boFirst: Boolean = True; DefColor: TColor = 0);
    procedure AddSayMsg(str: string; FColor: TColor; BColor: TColor;
                           boSys: Boolean; UserSayType: TUserSayType; boFirst: Boolean = True;
                           DefFColor: TColor = 0; DefBColor: TColor = 0);
    procedure ChangeScene(scenetype: TSceneType);
    procedure ChangeTransferMsg(UserSaySet: TUserSaySet);

    procedure DrawScreen(MSurface: TDirectDrawSurface);
    procedure DrawScreenTop(MSurface: TDirectDrawSurface);
    procedure DrawHint(MSurface: TDirectDrawSurface);
    procedure DrawHintEx(MSurface, HintSurface: TDirectDrawSurface;
                            nX, nY, HWidth, HHeight: Integer; HintList: TList);
    procedure ShowHintEx(X, Y: Integer; str: string);

    procedure ClearSysMsg;
    procedure ClearChatBoard;
    procedure ClearBit(SayMessage: pTSayMessage; nMaxLen: Integer);
    procedure ClearHint(boClear: Boolean = False);
    procedure DisposeSayMsg(SayMessage: pTSayMessage);
    procedure DelTransferMsg(SayMessage: pTSayMessage);

    Function ShowHint(X, Y: Integer;
                         str: string; Color: TColor; drawup: Boolean;
                         ShowIndex: Integer; boItemHint: Boolean = False;
                         HintSurface:TDirectDrawSurface = nil;
                         HintList: TList = nil; boLeft: Boolean = False): TPoint;
    Function  NewSayMsg(nWidth, nHeight:Integer; UserSayType: TUserSayType): pTSayMessage;
    Function  NewSayMsgEx(nWidth, nHeight:Integer;
                             UserSayType: TUserSayType; BColor: Cardinal): pTSayMessage;
  end;

implementation

uses
  ClMain, Share, Grobal2, FState, WMFile, cliUtil;

constructor TDrawScreen.Create;
begin
  CurrentScene := nil;
  m_SysMsgList := TStringList.Create;
  m_HintSurface := nil;
  m_nShowSysTick := GetTickCount;
  m_SysInfoList := TList.Create;
  SurfaceRefTick := GetTickCount;
  boShowSurface := False;
  NpcTempList := TStringList.Create;
  AutoImgTime := GetTickCount;
  nShowIndex := 0;
  m_HintList := TList.Create;
  m_NewSayMsgList := TList.Create;
  m_SayTransferList := TList.Create;
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
end;

procedure TDrawScreen.Finalize;
begin
  if m_HintSurface <> nil then
    m_HintSurface.Free;
  m_HintSurface := nil;
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

//添加系统消息
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
  SayMessage := NewSayMsgEx(DEFSAYLISTWIDTH, SAYLISTHEIGHT, UserSayType, BColor);
{$ELSE}
  SayMessage := NewSayMsg(DEFSAYLISTWIDTH, SAYLISTHEIGHT, UserSayType);
{$IFEND}

  if boFirst then begin
{$IF Var_Interface =  Var_Default}
    if boSys then begin
      d := g_WMain99Images.Images[Resource.EXCLAMATION_POINT];
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
            if (nLen + SAYFACEWIDTH) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - OLD_SCREEN_WIDTH{$IFEND} - 1) then begin
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
          if (nLen + nTextLen) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - OLD_SCREEN_WIDTH{$IFEND} - 1) then begin
            WideStr2 := cmdstr;
            cmdstr := '';
            AddStr2 := '';
            for ii := 1 to Length(WideStr2) do begin
              tstr2 := WideStr2[ii];
              OldStr2 := Copy(WideStr2, ii + 1, Length(WideStr2));
              if (nLen + g_DXCanvas.TextWidth(AddStr2 + tstr2)) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - OLD_SCREEN_WIDTH{$IFEND} - 1) then begin
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
              if (nLen + nTextLen) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - OLD_SCREEN_WIDTH{$IFEND} - 1) then begin
                WideStr2 := cmdstr;
                cmdstr := '';
                AddStr2 := '';
                for ii := 1 to Length(WideStr2) do begin
                  tstr2 := WideStr2[ii];
                  OldStr2 := Copy(WideStr2, ii + 1, Length(WideStr2));
                  if (nLen + g_DXCanvas.TextWidth(AddStr2 + tstr2)) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - OLD_SCREEN_WIDTH{$IFEND} - 1) then begin
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
        if (nLen + g_DXCanvas.TextWidth(AddStr + tstr)) > (DEFSAYLISTWIDTH{$IF Var_Interface = Var_Mir2} + g_FScreenWidth - OLD_SCREEN_WIDTH{$IFEND} - 1) then begin
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
  tempList: TStringList;
begin
  ClearHint;
  HintX := X;
  HintY := Y;
  Result.X := 0;
  Result.Y := 0;
  addw := 0;
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
                // 添加装备预览图标后面的边框
                New(ShowHint);
                tempList := TStringList.Create;
                tempList.Add('671');
                SafeFillChar(ShowHint^, SizeOf(TNewShowHint), #0);
                ShowHint.Surfaces := g_WMain99Images;
                ShowHint.IndexList := tempList;
                ShowHint.nX := mx;
                ShowHint.nY := my;
                ShowHint.boTransparent := False;
                ShowHint.Alpha := 255;
                ShowHint.dwTime := 100;
                ShowHint.boBlend := False;
                ShowHint.boMove := False;
                HintList.Add(ShowHint);
                New(ShowHint);
                // 装备预览图标如果存在多个，则只取第一个图标
                d := g_ClientImages[mfid].Images[StrToInt(NpcTempList[0])];
                SafeFillChar(ShowHint^, SizeOf(TNewShowHint), #0);
                ShowHint.Surfaces := g_ClientImages[mfid];
                ShowHint.IndexList := NpcTempList;
                ShowHint.nX := mx + (ITEMTABLEWIDTH - d.Width) div 2;
                ShowHint.nY := mY + (ITEMTABLEHEIGHT - d.Height) div 2;
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
            if pos(',', cmdparam) > 0 then begin
              sBColor := GetValidStr3(cmdparam, sFColor, [',']);
            end
            else
              sFColor := cmdparam;

            if CompareLStr(sFColor, 'FCOLOR', length('FCOLOR')) then begin
              sFColor := GetValidStr3(sFColor, sTemp, ['=']);
              FColor := StrToIntDef(sFColor, Color);
            end;
            if CompareLStr(sBColor, 'BCOLOR', length('BCOLOR')) then begin
              sBColor := GetValidStr3(sBColor, sTemp, ['=']);
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
  New(Result);
  Result.ClickList := nil;
  Result.ItemList := nil;
  Result.ImageList := nil;
  Result.SaySurface := MakeDXImageTexture(nWidth, nHeight, WILFMT_A4R4G4B4, g_DXCanvas);
  Result.SaySurface.Clear;
  Result.UserSayType := UserSayType;
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
    ax := g_FScreenXOrigin - 10 - SayHint.SaySurface.Width div 2;
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
