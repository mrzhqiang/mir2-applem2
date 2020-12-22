{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       BusinessSkinForm                                            }
{       Version 9.45                                                }  
{                                                                   }
{       Copyright (c) 2000-2011 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

{$P+,S-,W-,R-}
{$WARNINGS OFF}
{$HINTS OFF}

// {$DEFINE TNTUNICODE}

unit bsSkinHint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  bsSkinData, ExtCtrls, ImgList{$IFDEF TNTUNICODE}, TntForms, TntControls {$ENDIF};

type

  TbsSkinHint = class;
  {$IFDEF TNTUNICODE}
  TbsSkinHintWindow = class(TTntHintWindow)
//  TbsSkinHintWindow = class(TTntCustomHintWindow) // for old version of TNT controls
  {$ELSE}
  TbsSkinHintWindow = class(THintWindow)
  {$ENDIF}
  private
    NewClRect: TRect;
    NewLTPoint, NewRTPoint,
    NewLBPoint, NewRBPoint: TPoint;
    FspHint: TbsSkinHint;
    DrawBuffer: TBitMap;
    FSD:  TbsSkinData;
    FRgn: HRGN;
    FOldAlphaBlend: Boolean;
    FOldAlphaBlendValue: Byte;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMEraseBkGnd(var Msg: TWMEraseBkgnd); message WM_EraseBkgnd;
    function FindHintComponent: TbsSkinHint;
    {$IFDEF TNTUNICODE}
    procedure CalcHintSize(Cnvs: TCanvas; S: WideString; var W, H: Integer);
    {$ELSE}
    procedure CalcHintSize(Cnvs: TCanvas; S: String; var W, H: Integer);
    {$ENDIF}
    procedure CalcHintSizeEx(Cnvs: TCanvas; AHint, AHintTitle: String;
      AImageIndex: Integer; AImageList: TCustomImageList;
      var W, H: Integer);
    procedure CheckText(var S: String);
  protected
    procedure SetHintWindowRegion;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure PaintEx;
  public
    AExtendedStyle: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFDEF TNTUNICODE}
    procedure ActivateHint(Rect: TRect; const AHint: AnsiString); override;
    {$ELSE}
    procedure ActivateHint(Rect: TRect; const AHint: string); override;
    {$ENDIF}
    procedure ActivateHintFromRect(ARect: TRect; const AHint: string; ATop: Boolean);
    procedure ActivateHintEx(Rect: TRect;
      const AHintTitle, AHint: string; AImageIndex: Integer; AImageList: TCustomImageList);
  end;

  TbsSkinHint = class(TComponent)
  private
    FOnShowHint: TShowHintEvent;
    FActive: Boolean;
    FSD: TbsSkinData;
    HW: TbsSkinHintWindow;
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    HintTimer: TTimer;
    HintText: String;
    FLineSeparator: String;
    FromRect: TRect;
    Top: Boolean;
    procedure SetActive(Value: Boolean);
    procedure SetDefaultFont(Value: TFont);
    procedure HintTime1(Sender: TObject);
    procedure HintTime1x(Sender: TObject);
    procedure HintTimeEx1(Sender: TObject);
    procedure HintTime2(Sender: TObject);
  protected
    FHintTitle: String;
    FHintImageIndex: Integer;
    FHintImageList: TCustomImageList;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSkinData(Value: TbsSkinData);
    procedure SelfOnShowHint(var HintStr: string;
                             var CanShow: Boolean; var HintInfo: THintInfo);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetCursorHeightMargin: Integer;
    procedure ActivateHint(P: TPoint; const AHint: string);
    procedure ActivateHint2(const AHint: string);
    procedure ActivateHint3(AFromRect: TRect; const AHint: string; ATop: Boolean);

    procedure ActivateHintEx(P: TPoint;
      const AHintTitle, AHint: string;
      AImageIndex: Integer; AImageList: TCustomImageList);

    procedure ActivateHintEx2(const AHintTitle, AHint: string;
     AImageIndex: Integer; AImageList: TCustomImageList);

    function IsVisible: Boolean;
    procedure HideHint;
  published
    property LineSeparator: String read FLineSeparator write FLineSeparator;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property Active: Boolean read FActive write SetActive;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property OnShowHint: TShowHintEvent read FOnShowHint write FOnShowHint;
  end;

implementation
  Uses bsUtils, bsSkinCtrls;

const
  CS_DROPSHADOW_ = $20000;

constructor TbsSkinHintWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRgn := 0;
  FOldAlphaBlend := False;
  FOldAlphaBlendValue := 0;
end;

destructor TbsSkinHintWindow.Destroy;
begin
  inherited Destroy;
  if FRgn <> 0 then DeleteObject(FRgn);
end;

procedure TbsSkinHintWindow.CheckText(var S: String);
var
  I: Integer;
begin
  while Pos(FspHint.LineSeparator, S) <> 0 do
  begin
    I := Pos(FspHint.LineSeparator, S);
    Delete(S, I, Length(FspHint.LineSeparator));
    Insert(#10, S, I);
    Insert(#13, S, I + 1);
  end;
end;

procedure TbsSkinHintWindow.WMNCPaint(var Message: TMessage);
begin
end;

procedure TbsSkinHintWindow.SetHintWindowRegion;
var
  TempRgn: HRgn;
  MaskPicture: TBitMap;
begin
  if (FSD <> nil) and (FSD.HintWindow.MaskPictureIndex <> -1)
  then
    begin
      TempRgn := FRgn;
      with FSD.HintWindow do
      begin
        MaskPicture := TBitMap(FSD.FActivePictures[MaskPictureIndex]);
        CreateSkinRegion
          (FRgn, LTPoint, RTPoint, LBPoint, RBPoint, ClRect,
           NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewClRect,
           MaskPicture, Width, Height);
      end;
      SetWindowRgn(Handle, FRgn, False);
      if TempRgn <> 0 then DeleteObject(TempRgn);
    end
  else
    if FRgn <> 0 then
    begin
      SetWindowRgn(Handle, 0, False);
      DeleteObject(FRgn);
      FRgn := 0;
    end;
end;

procedure TbsSkinHintWindow.ActivateHintEx(Rect: TRect;
   const AHintTitle, AHint: string; AImageIndex: Integer;
   AImageList: TCustomImageList);
const
  WS_EX_LAYERED = $80000;
var
  HintWidth, HintHeight: Integer;
  CanSkin: Boolean;
  i: Integer;
  TickCount, ABV: Integer;
  S: String;
  WorkArea: TRect;
  AnimationStep: Integer;
begin
  AExtendedStyle := True;
  FspHint := FindHintComponent;
  if FspHint = nil then Exit;
  if not FspHint.Active then Exit;
  CanSkin := ((FspHint.FSD <> nil) and (not FspHInt.FSD.Empty) and
             (FspHint.FSD.HintWindow.WindowPictureIndex <> -1));
  //
  if CanSkin then FSD := FspHint.FSD else FSD := nil;

  if FSD <> nil
  then
    begin
      with Canvas, FSD.HintWindow do
      begin
        if FspHint.UseSkinFont
        then
          begin
            Font.Height := FontHeight;
            Font.Name := FontName;
            Font.Style := FontStyle;
          end
        else
          Font.Assign(FspHint.FDefaultFont);
      end;
    end
  else
    with Canvas do
    begin
      Font.Assign(FspHint.FDefaultFont);
    end;
  if (FspHint.SkinData <> nil) and (FspHint.SkinData.ResourceStrData <> nil)
  then
    Canvas.Font.CharSet := FspHint.SkinData.ResourceStrData.CharSet
  else
    Canvas.Font.CharSet := FspHint.DefaultFont.CharSet;

  S := AHint;
  CheckText(S);
  Caption := S;
  CalcHintSizeEx(Canvas, Caption, AHintTitle, AImageIndex, AImageList,
    HintWidth, HintHeight);
  Rect.Right := Rect.Left + HintWidth;
  Rect.Bottom := Rect.Top + HIntHeight;
   //
  if (Screen.ActiveCustomForm <> nil)
  then
    begin
      WorkArea := GetMonitorWorkArea(Screen.ActiveCustomForm.Handle, True);
      if (Rect.Right > WorkArea.Right) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > WorkArea.Bottom) then OffsetRect(Rect, 0, -HintHeight - 2);
    end
   else
  if (Application.MainForm <> nil) and (Application.MainForm.Visible)
  then
    begin
      WorkArea := GetMonitorWorkArea(Application.MainForm.Handle, True);
      if (Rect.Right > WorkArea.Right) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > WorkArea.Bottom) then OffsetRect(Rect, 0, -HintHeight - 2);
    end
  else
    begin
      if (Rect.Right > Screen.Width) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > Screen.Height) then OffsetRect(Rect, 0, -HintHeight - 2);
    end;

  //
  BoundsRect := Rect;
  //
  if CheckW2KWXP
  then
    begin
      if FspHint.AlphaBlend and not FOldAlphaBlend
      then
        begin
          SetWindowLong(Handle, GWL_EXSTYLE,
                        GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

        end
      else
      if not FspHint.AlphaBlend and FOldAlphaBlend
      then
        begin
         SetWindowLong(Handle, GWL_EXSTYLE,
            GetWindowLong(Handle, GWL_EXSTYLE) and (not WS_EX_LAYERED));
        end;
      FOldAlphaBlend := FspHint.AlphaBlend;

      if FspHint.AlphaBlend and FspHint.AlphaBlendAnimation
      then
        begin
          SetAlphaBlendTransparent(Handle, 0);
        end;

      if (FOldAlphaBlendValue <> FspHint.AlphaBlendValue) and FspHint.AlphaBlend
      then
        begin
          if not FspHint.AlphaBlendAnimation
          then
            SetAlphaBlendTransparent(Handle, FspHint.AlphaBlendValue);
          FOldAlphaBlendValue := FspHint.AlphaBlendValue;
        end;
    end;
  //
  SetHintWindowRegion;
  SetWindowPos(Handle, HWND_TOPMOST, Rect.Left, Rect.Top, 0,
    0, SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOSIZE);
  Visible := True;
  Self.RePaint;
  if CheckW2KWXP and FspHint.AlphaBlend and FspHint.AlphaBlendAnimation
  then
    begin
      i := 0;
      TickCount := 0;
      ABV := FspHint.AlphaBlendValue;
      AnimationStep := ABV div 10;
      if AnimationStep = 0 then AnimationStep := 1;
      repeat
        if (GetTickCount - TickCount > 3)
        then
          begin
            TickCount := GetTickCount;
            Inc(i, AnimationStep);
            if i > ABV then i := ABV;
            Self.RePaint;
            SetAlphaBlendTransparent(Handle, i);
          end;
      until i >= ABV;
    end;
end;


procedure TbsSkinHintWindow.CalcHintSizeEx(Cnvs: TCanvas; AHint, AHintTitle: String;
             AImageIndex: Integer; AImageList: TCustomImageList;
             var W, H: Integer);
var
  R: TRect;
  TH, PW, PH, OX, OY: Integer;
begin
  R := Rect(0, 0, 0, 0);
  DrawText(Cnvs.Handle, PChar(AHint), -1, R, DT_CALCRECT or DT_LEFT);
  W := RectWidth(R);
  H := RectHeight(R);
  TH := 0;
  if AHintTitle <> ''
  then
    begin
      R := Rect(0, 0, 0, 0);
      DrawText(Cnvs.Handle, PChar(AHintTitle), -1, R, DT_CALCRECT or DT_LEFT);
      H := H + RectHeight(R) + 10;
      if RectWidth(R) > W then W := RectWidth(R);
      TH := RectHeight(R);
    end;

  if (AImageList <> nil) and (AImageIndex >= 0) and (AImageIndex < AImageList.Count)
  then
    begin
      W := W + AImageList.Width + 10;
      if AImageList.Height + TH + 5 > H then
        H := AImageList.Height + TH + 5;
    end;

  if FSD <> nil
  then
    begin
      W := W + 10;
      with FSD.HintWindow do
      begin
        PW := TBitMap(FSD.FActivePictures[WindowPictureIndex]).Width;
        PH := TBitMap(FSD.FActivePictures[WindowPictureIndex]).Height;
        W := W + ClRect.Left + (PW - ClRect.Right);
        H := H + ClRect.Top + (PH - ClRect.Bottom);

        OX := W - PW;
        OY := H - PH;

        if RTPoint.X + OX < LTPoint.X
        then
          begin
            W := W + LTPoint.X - (RTPoint.X + OX);
            OX := W - PW;
          end;

        if RBPoint.X + OX < LBPoint.X
        then
          begin
            W := W + LBPoint.X - (RBPoint.X + OX);
            OX := W - PW;
          end;

        if LBPoint.Y + OY < LTPoint.Y
        then
          begin
            H := H + LTPoint.Y - (LBPoint.Y + OY);
            OY := H - PH;
          end;

        if RBPoint.Y + OY < RTPoint.Y
        then
          begin
            H := H + RTPoint.Y - (RBPoint.Y + OY);
            OX := H - PH;
          end;

        NewClRect := ClRect;
        Inc(NewClRect.Right, OX);
        Inc(NewClRect.Bottom, OY);
        NewLTPoint := LTPoint;
        NewRTPoint := Point(RTPoint.X + OX, RTPoint.Y);
        NewLBPoint := Point(LBPoint.X, LBPoint.Y + OY);
        NewRBPoint := Point(RBPoint.X + OX, RBPoint.Y + OY);
      end;
    end
  else
    begin
      Inc(W, 4);
      Inc(H, 4);
    end;
end;


{$IFDEF TNTUNICODE}
procedure TbsSkinHintWindow.CalcHintSize(Cnvs: TCanvas; S: WideString; var W, H: Integer);
var
  R: TRect;
  PW, PH, OX, OY: Integer;
begin
  R := Rect(0, 0, 0, 0);
  BSDrawSkinText(Cnvs, S, R, DT_CALCRECT or DT_LEFT);
  W := RectWidth(R);
  H := RectHeight(R);
  if FSD <> nil
  then
    begin
      with FSD.HintWindow do
      begin
        PW := TBitMap(FSD.FActivePictures[WindowPictureIndex]).Width;
        PH := TBitMap(FSD.FActivePictures[WindowPictureIndex]).Height;
        W := W + ClRect.Left + (PW - ClRect.Right);
        H := H + ClRect.Top + (PH - ClRect.Bottom);

        W := W + 5;

        OX := W - PW;
        OY := H - PH;

        if RTPoint.X + OX < LTPoint.X
        then
          begin
            W := W + LTPoint.X - (RTPoint.X + OX);
            OX := W - PW;
          end;

        if RBPoint.X + OX < LBPoint.X
        then
          begin
            W := W + LBPoint.X - (RBPoint.X + OX);
            OX := W - PW;
          end;

        if LBPoint.Y + OY < LTPoint.Y
        then
          begin
            H := H + LTPoint.Y - (LBPoint.Y + OY);
            OY := H - PH;
          end;

        if RBPoint.Y + OY < RTPoint.Y
        then
          begin
            H := H + RTPoint.Y - (RBPoint.Y + OY);
            OX := H - PH;
          end;

        NewClRect := ClRect;
        Inc(NewClRect.Right, OX);
        Inc(NewClRect.Bottom, OY);
        NewLTPoint := LTPoint;
        NewRTPoint := Point(RTPoint.X + OX, RTPoint.Y);
        NewLBPoint := Point(LBPoint.X, LBPoint.Y + OY);
        NewRBPoint := Point(RBPoint.X + OX, RBPoint.Y + OY);
      end;
    end
  else
    begin
      Inc(W, 4);
      Inc(H, 4);
    end;
end;

{$ELSE}

procedure TbsSkinHintWindow.CalcHintSize(Cnvs: TCanvas; S: String; var W, H: Integer);
var
  R: TRect;
  PW, PH, OX, OY: Integer;
begin
  R := Rect(0, 0, 0, 0);
  DrawText(Cnvs.Handle, PChar(S), -1, R, DT_CALCRECT or DT_LEFT);
  W := RectWidth(R);
  H := RectHeight(R);
  if FSD <> nil
  then
    begin
      with FSD.HintWindow do
      begin
        PW := TBitMap(FSD.FActivePictures[WindowPictureIndex]).Width;
        PH := TBitMap(FSD.FActivePictures[WindowPictureIndex]).Height;
        W := W + ClRect.Left + (PW - ClRect.Right);
        H := H + ClRect.Top + (PH - ClRect.Bottom);

        W := W + 5;

        OX := W - PW;
        OY := H - PH;

        if RTPoint.X + OX < LTPoint.X
        then
          begin
            W := W + LTPoint.X - (RTPoint.X + OX);
            OX := W - PW;
          end;

        if RBPoint.X + OX < LBPoint.X
        then
          begin
            W := W + LBPoint.X - (RBPoint.X + OX);
            OX := W - PW;
          end;

        if LBPoint.Y + OY < LTPoint.Y
        then
          begin
            H := H + LTPoint.Y - (LBPoint.Y + OY);
            OY := H - PH;
          end;

        if RBPoint.Y + OY < RTPoint.Y
        then
          begin
            H := H + RTPoint.Y - (RBPoint.Y + OY);
            OX := H - PH;
          end;

        NewClRect := ClRect;
        Inc(NewClRect.Right, OX);
        Inc(NewClRect.Bottom, OY);
        NewLTPoint := LTPoint;
        NewRTPoint := Point(RTPoint.X + OX, RTPoint.Y);
        NewLBPoint := Point(LBPoint.X, LBPoint.Y + OY);
        NewRBPoint := Point(RBPoint.X + OX, RBPoint.Y + OY);
      end;
    end
  else
    begin
      Inc(W, 4);
      Inc(H, 4);
    end;
end;

{$ENDIF}

function TbsSkinHintWindow.FindHintComponent;
var
  i: Integer;
begin
  Result := nil;
  if (Application.MainForm <> nil) and
     (Application.MainForm.ComponentCount > 0)
  then
    with Application.MainForm do
      for i := 0 to ComponentCount - 1 do
       if (Components[i] is TbsSkinHint) and
          (TbsSkinHint(Components[i]).Active)
       then
         begin
           Result := TbsSkinHint(Components[i]);
           Break;
         end;
end;

{$IFDEF TNTUNICODE}
procedure TbsSkinHintWindow.ActivateHint;
const
  WS_EX_LAYERED = $80000;
var
  HintWidth, HintHeight: Integer;
  CanSkin: Boolean;
  i: Integer;
  TickCount, ABV: Integer;
  WorkArea: TRect;
  AnimationStep: Integer;
begin
  inherited;
  AExtendedStyle := False;
  FspHint := FindHintComponent;
  if FspHint = nil then Exit;

  if not FspHint.Active then Exit;
  CanSkin := ((FspHint.FSD <> nil) and (not FspHInt.FSD.Empty) and
             (FspHint.FSD.HintWindow.WindowPictureIndex <> -1));
  //
  if CanSkin then FSD := FspHint.FSD else FSD := nil;

  if FSD <> nil
  then
    begin
      with Canvas, FSD.HintWindow do
      begin
        if FspHint.UseSkinFont
        then
          begin
            Font.Height := FontHeight;
            Font.Name := FontName;
            Font.Style := FontStyle;
          end
        else
          Font.Assign(FspHint.FDefaultFont);
      end;
    end
  else
    with Canvas do
    begin
      Font.Assign(FspHint.FDefaultFont);
    end;
  if (FspHint.SkinData <> nil) and (FspHint.SkinData.ResourceStrData <> nil)
  then
    Canvas.Font.CharSet := FspHint.SkinData.ResourceStrData.CharSet
  else
    Canvas.Font.CharSet := FspHint.DefaultFont.CharSet;

  CalcHintSize(Canvas, Caption, HintWidth, HintHeight);
  Rect.Right := Rect.Left + HintWidth;
  Rect.Bottom := Rect.Top + HIntHeight;
  //
  if (Screen.ActiveCustomForm <> nil)
  then
    begin
      WorkArea := GetMonitorWorkArea(Screen.ActiveCustomForm.Handle, True);
      if (Rect.Right > WorkArea.Right) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > WorkArea.Bottom) then OffsetRect(Rect, 0, -HintHeight - 2);
    end
   else
  if (Application.MainForm <> nil) and (Application.MainForm.Visible)
  then
    begin
      WorkArea := GetMonitorWorkArea(Application.MainForm.Handle, True);
      if (Rect.Right > WorkArea.Right) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > WorkArea.Bottom) then OffsetRect(Rect, 0, -HintHeight - 2);
    end
  else
    begin
      if (Rect.Right > Screen.Width) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > Screen.Height) then OffsetRect(Rect, 0, -HintHeight - 2);
    end;

  //
  BoundsRect := Rect;
  //
  if CheckW2KWXP
  then
    begin
      if FspHint.AlphaBlend and not FOldAlphaBlend
      then
        begin
          SetWindowLong(Handle, GWL_EXSTYLE,
                        GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

        end
      else
      if not FspHint.AlphaBlend and FOldAlphaBlend
      then
        begin
         SetWindowLong(Handle, GWL_EXSTYLE,
            GetWindowLong(Handle, GWL_EXSTYLE) and (not WS_EX_LAYERED));
        end;
      FOldAlphaBlend := FspHint.AlphaBlend;

      if FspHint.AlphaBlend and FspHint.AlphaBlendAnimation
      then
        begin
          SetAlphaBlendTransparent(Handle, 0);
        end;

      if (FOldAlphaBlendValue <> FspHint.AlphaBlendValue) and FspHint.AlphaBlend
      then
        begin
          if not FspHint.AlphaBlendAnimation
          then
            SetAlphaBlendTransparent(Handle, FspHint.AlphaBlendValue);
          FOldAlphaBlendValue := FspHint.AlphaBlendValue;
        end;
    end;
  //
  SetHintWindowRegion;
  SetWindowPos(Handle, HWND_TOPMOST, Rect.Left, Rect.Top, 0,
    0, SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOSIZE);
  Visible := True;
  Self.RePaint;
  if CheckW2KWXP and FspHint.AlphaBlend and FspHint.AlphaBlendAnimation
  then
    begin
      i := 0;
      TickCount := 0;
      ABV := FspHint.AlphaBlendValue;
      AnimationStep := ABV div 10;
      if AnimationStep = 0 then AnimationStep := 1;
      repeat
        if (GetTickCount - TickCount > 3)
        then
          begin
            TickCount := GetTickCount;
            Inc(i, AnimationStep);
            if i > ABV then i := ABV;
            Self.RePaint;
            SetAlphaBlendTransparent(Handle, i);
          end;
      until i >= ABV;
    end;
end;

{$ELSE}
procedure TbsSkinHintWindow.ActivateHint(Rect: TRect; const AHint: string);
const
  WS_EX_LAYERED = $80000;
var
  HintWidth, HintHeight: Integer;
  CanSkin: Boolean;
  i: Integer;
  TickCount, ABV: Integer;
  S: String;
  WorkArea: TRect;
  AnimationStep: Integer;
begin
  AExtendedStyle := False;
  FspHint := FindHintComponent;
  if FspHint = nil then Exit;
  if (FspHint.FHintTitle <> '') or (FspHint.FHintImageList <> nil)
  then
    begin
      ActivateHintEx(Rect, FspHint.FHintTitle, AHint,
        FspHint.FHintImageIndex, FspHint.FHintImageList);
      Exit;
    end;
  if not FspHint.Active then Exit;
  CanSkin := ((FspHint.FSD <> nil) and (not FspHInt.FSD.Empty) and
             (FspHint.FSD.HintWindow.WindowPictureIndex <> -1));
  //
  if CanSkin then FSD := FspHint.FSD else FSD := nil;

  if FSD <> nil
  then
    begin
      with Canvas, FSD.HintWindow do
      begin
        if FspHint.UseSkinFont
        then
          begin
            Font.Height := FontHeight;
            Font.Name := FontName;
            Font.Style := FontStyle;
          end
        else
          Font.Assign(FspHint.FDefaultFont);
      end;
    end
  else
    with Canvas do
    begin
      Font.Assign(FspHint.FDefaultFont);
    end;
  if (FspHint.SkinData <> nil) and (FspHint.SkinData.ResourceStrData <> nil)
  then
    Canvas.Font.CharSet := FspHint.SkinData.ResourceStrData.CharSet
  else
    Canvas.Font.CharSet := FspHint.DefaultFont.CharSet;

  S := AHint;
  CheckText(S);
  Caption := S;
  CalcHintSize(Canvas, Caption, HintWidth, HintHeight);
  Rect.Right := Rect.Left + HintWidth;
  Rect.Bottom := Rect.Top + HIntHeight;
  //
  if (Screen.ActiveCustomForm <> nil)
  then
    begin
      WorkArea := GetMonitorWorkArea(Screen.ActiveCustomForm.Handle, True);
      if (Rect.Right > WorkArea.Right) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > WorkArea.Bottom) then OffsetRect(Rect, 0, -HintHeight - 2);
    end
   else
  if (Application.MainForm <> nil) and (Application.MainForm.Visible)
  then
    begin
      WorkArea := GetMonitorWorkArea(Application.MainForm.Handle, True);
      if (Rect.Right > WorkArea.Right) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > WorkArea.Bottom) then OffsetRect(Rect, 0, -HintHeight - 2);
    end
  else
    begin
      if (Rect.Right > Screen.Width) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > Screen.Height) then OffsetRect(Rect, 0, -HintHeight - 2);
    end;

  //
  BoundsRect := Rect;
  //
  if CheckW2KWXP
  then
    begin
      if FspHint.AlphaBlend and not FOldAlphaBlend
      then
        begin
          SetWindowLong(Handle, GWL_EXSTYLE,
                        GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

        end
      else
      if not FspHint.AlphaBlend and FOldAlphaBlend
      then
        begin
         SetWindowLong(Handle, GWL_EXSTYLE,
            GetWindowLong(Handle, GWL_EXSTYLE) and (not WS_EX_LAYERED));
        end;
      FOldAlphaBlend := FspHint.AlphaBlend;

      if FspHint.AlphaBlend and FspHint.AlphaBlendAnimation
      then
        begin
          SetAlphaBlendTransparent(Handle, 0);
        end;

      if (FOldAlphaBlendValue <> FspHint.AlphaBlendValue) and FspHint.AlphaBlend
      then
        begin
          if not FspHint.AlphaBlendAnimation
          then
            SetAlphaBlendTransparent(Handle, FspHint.AlphaBlendValue);
          FOldAlphaBlendValue := FspHint.AlphaBlendValue;
        end;
    end;
  //
  SetHintWindowRegion;
  SetWindowPos(Handle, HWND_TOPMOST, Rect.Left, Rect.Top, 0,
    0, SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOSIZE);
  Visible := True;
  Self.RePaint;
  if CheckW2KWXP and FspHint.AlphaBlend and FspHint.AlphaBlendAnimation
  then
    begin
      i := 0;
      TickCount := 0;
      ABV := FspHint.AlphaBlendValue;
      AnimationStep := ABV div 10;
      if AnimationStep = 0 then AnimationStep := 1;
      repeat
        if (GetTickCount - TickCount > 3)
        then
          begin
            TickCount := GetTickCount;
            Inc(i, AnimationStep);
            if i > ABV then i := ABV;
            Self.RePaint;
            SetAlphaBlendTransparent(Handle, i);
          end;
      until i >= ABV;
    end;
end;
{$ENDIF}


procedure TbsSkinHintWindow.ActivateHintFromRect;
const
  WS_EX_LAYERED = $80000;
var
  HintWidth, HintHeight: Integer;
  CanSkin: Boolean;
  i: Integer;
  TickCount, ABV: Integer;
  S: String;
  WorkArea: TRect;
  Rect: TRect;
  AnimationStep: Integer;
begin
  FspHint := FindHintComponent;
  if FspHint = nil then Exit;
  if not FspHint.Active then Exit;
  CanSkin := ((FspHint.FSD <> nil) and (not FspHInt.FSD.Empty) and
             (FspHint.FSD.HintWindow.WindowPictureIndex <> -1));
  //
  if CanSkin then FSD := FspHint.FSD else FSD := nil;

  if FSD <> nil
  then
    begin
      with Canvas, FSD.HintWindow do
      begin
        if FspHint.UseSkinFont
        then
          begin
            Font.Height := FontHeight;
            Font.Name := FontName;
            Font.Style := FontStyle;
          end
        else
          Font.Assign(FspHint.FDefaultFont);
      end;
    end
  else
    with Canvas do
    begin
      Font.Assign(FspHint.FDefaultFont);
    end;
  if (FspHint.SkinData <> nil) and (FspHint.SkinData.ResourceStrData <> nil)
  then
    Canvas.Font.CharSet := FspHint.SkinData.ResourceStrData.CharSet
  else
    Canvas.Font.CharSet := FspHint.DefaultFont.CharSet;

  S := AHint;
  CheckText(S);
  Caption := S;
  CalcHintSize(Canvas, Caption, HintWidth, HintHeight);

  if ATop
  then
    begin
      Rect.Left := ARect.Left + RectWidth(ARect) div 2 - HintWidth div 2;
      Rect.Top := ARect.Top - HintHeight;
    end
  else
    begin
      Rect.Left := ARect.Left + RectWidth(ARect) div 2 - HintWidth div 2;
      Rect.Top := ARect.Bottom;
    end;
    
  Rect.Right := Rect.Left + HintWidth;
  Rect.Bottom := Rect.Top + HintHeight;
  //
  if (Screen.ActiveCustomForm <> nil)
  then
    begin
      WorkArea := GetMonitorWorkArea(Screen.ActiveCustomForm.Handle, True);
      if (Rect.Right > WorkArea.Right) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > WorkArea.Bottom) then OffsetRect(Rect, 0, -HintHeight - 2);
    end
   else
  if (Application.MainForm <> nil) and (Application.MainForm.Visible)
  then
    begin
      WorkArea := GetMonitorWorkArea(Application.MainForm.Handle, True);
      if (Rect.Right > WorkArea.Right) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > WorkArea.Bottom) then OffsetRect(Rect, 0, -HintHeight - 2);
    end
  else
    begin
      if (Rect.Right > Screen.Width) then OffsetRect(Rect, -HintWidth - 2, 0);
      if (Rect.Bottom > Screen.Height) then OffsetRect(Rect, 0, -HintHeight - 2);
    end;

  //
  BoundsRect := Rect;
  //
  if CheckW2KWXP
  then
    begin
      if FspHint.AlphaBlend and not FOldAlphaBlend
      then
        begin
          SetWindowLong(Handle, GWL_EXSTYLE,
                        GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

        end
      else
      if not FspHint.AlphaBlend and FOldAlphaBlend
      then
        begin
         SetWindowLong(Handle, GWL_EXSTYLE,
            GetWindowLong(Handle, GWL_EXSTYLE) and (not WS_EX_LAYERED));
        end;
      FOldAlphaBlend := FspHint.AlphaBlend;

      if FspHint.AlphaBlend and FspHint.AlphaBlendAnimation
      then
        begin
          SetAlphaBlendTransparent(Handle, 0);
        end;

      if (FOldAlphaBlendValue <> FspHint.AlphaBlendValue) and FspHint.AlphaBlend
      then
        begin
          if not FspHint.AlphaBlendAnimation
          then
            SetAlphaBlendTransparent(Handle, FspHint.AlphaBlendValue);
          FOldAlphaBlendValue := FspHint.AlphaBlendValue;
        end;
    end;
  //
  SetHintWindowRegion;
  SetWindowPos(Handle, HWND_TOPMOST, Rect.Left, Rect.Top, 0,
    0, SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOSIZE);
  Visible := True;
  Self.RePaint;
  if CheckW2KWXP and FspHint.AlphaBlend and FspHint.AlphaBlendAnimation
  then
    begin
      i := 0;
      TickCount := 0;
      ABV := FspHint.AlphaBlendValue;
      AnimationStep := ABV div 10;
      if AnimationStep = 0 then AnimationStep := 1;
      repeat
        if (GetTickCount - TickCount > 3)
        then
          begin
            TickCount := GetTickCount;
            Inc(i, AnimationStep);
            if i > ABV then i := ABV;
            Self.RePaint;
            SetAlphaBlendTransparent(Handle, i);
          end;
      until i >= ABV;
    end;
end;

procedure TbsSkinHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style - WS_BORDER;
  if CheckWXP
  then
    Params.WindowClass.Style := Params.WindowClass.style or CS_DROPSHADOW_;
end;

procedure TbsSkinHintWindow.PaintEx;
var
  R, R1: TRect;
  B: TBitMap;
  W, H, X, Y, OffsetX, OffsetY, GX, GY: Integer;
begin
  //
  DrawBuffer := TBitMap.Create;
  DrawBuffer.Width := Width;
  DrawBuffer.Height := Height;
  //
  if FSD <> nil
  then
    with DrawBuffer.Canvas, FSD.HintWindow do
    begin
      B := TBitMap(FSD.FActivePictures[WindowPictureIndex]);
      CreateSkinImageBS(LTPoint, RTPoint, LBPoint, RBPoint,
      CLRect, NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint,
      NewClRect, DrawBuffer, B,
      Rect(0, 0, B.Width, B.Height), Width, Height, True,
      FSD.HintWindow.LeftStretch, FSD.HintWindow.TopStretch,
      FSD.HintWindow.RightStretch, FSD.HintWindow.BottomStretch, StretchEffect, StretchType);
    end
  else
    with DrawBuffer.Canvas do
    begin
      Brush.Color := clInfoBk;
      FillRect(ClientRect);
      R := ClientRect;
      Frame3D(DrawBuffer.Canvas, R, clBtnShadow, clBtnShadow, 1);
    end;
  //
  if FSD <> nil
  then
    with DrawBuffer.Canvas, FSD.HintWindow do
    begin
      Brush.Style := bsClear;
      if FspHint.UseSkinFont
      then
        begin
          Font.Height := FontHeight;
          Font.Style := FontStyle;
          Font.Name := FontName;
        end
      else
        Font.Assign(FspHint.FDefaultFont);

      if (FspHint.SkinData <> nil) and (FspHint.SkinData.ResourceStrData <> nil)
      then
        Font.CharSet := FspHint.SkinData.ResourceStrData.CharSet
      else
        Font.CharSet := FspHint.DefaultFont.CharSet;

      Font.Color := FontColor;
      OffsetX := 0;
      OffsetY := 0;
      // title
      if FspHint.FHintTitle <> ''
      then
        begin
          R := Rect(0, 0, 0, 0);
          Font.Style := [fsBold];
          DrawText(Handle, PChar(FspHint.FHintTitle), -1, R, DT_CALCRECT or DT_LEFT);
          W := RectWidth(R);
          H := RectHeight(R);
          X := NewClRect.Left + 5;
          Y := NewClRect.Top;
          R := Rect(X, Y, X + W, Y + H);
          DrawText(Handle, PChar(FspHint.FHintTitle), -1, R, DT_LEFT);
          Font.Style := Font.Style  - [fsBold];
          OffsetY := H + 5;
        end;
      // image
      GX := -1;
      GY := -1;
      if (FspHint.FHintImageList <> nil) and (FspHint.FHintImageIndex >= 0) and
         (FspHint.FHintImageIndex < FspHint.FHintImageList.Count)
      then
        begin
          GX := NewClRect.Left + 5;
          if OffsetY = 0
          then
            GY := NewClRect.Top + RectHeight(NewClRect) div 2 -
                   FspHint.FHintImageList.Height div 2
          else
            GY := NewClRect.Top + OffsetY;
          FspHint.FHintImageList.Draw(DrawBuffer.Canvas,
            GX, GY, FspHint.FHintImageIndex);
          OffsetX := GX + FspHint.FHintImageList.Width + 5;
        end;
      //
      R := Rect(0, 0, 0, 0);
      DrawText(Handle, PChar(Caption), -1, R, DT_CALCRECT or DT_LEFT);
      W := RectWidth(R);
      H := RectHeight(R);
      if OffsetX = 0
      then
        X := NewClRect.Left + 5
      else
        X := OffsetX;
      if OffsetY <> 0
      then
        Y := NewClRect.Top + OffsetY
      else
        Y := NewClRect.Top + RectHeight(NewClRect) div 2 - H div 2;
      R := Rect(X, Y, X + W, Y + H);
      DrawText(Handle, PChar(Caption), -1, R, DT_LEFT);
    end
  else
    with DrawBuffer.Canvas do
    begin
      Font.Assign(FspHint.FDefaultFont);
      if (FspHint.SkinData <> nil) and (FspHint.SkinData.ResourceStrData <> nil)
      then
        Font.CharSet := FspHint.SkinData.ResourceStrData.CharSet
      else
        Font.CharSet := FspHint.DefaultFont.CharSet;
      Font.Color := clInfoText;
      Brush.Style := bsClear;
      R1 := Rect(2, 2, Width - 2, Height - 2);
      OffsetX := 0;
      OffsetY := 0;
      // title
      if FspHint.FHintTitle <> ''
      then
        begin
          R := Rect(0, 0, 0, 0);
          Font.Style := [fsBold];
          DrawText(Handle, PChar(FspHint.FHintTitle), -1, R, DT_CALCRECT or DT_LEFT);
          W := RectWidth(R);
          H := RectHeight(R);
          X := R1.Left;
          Y := R1.Top;
          R := Rect(X, Y, X + W, Y + H);
          DrawText(Handle, PChar(FspHint.FHintTitle), -1, R, DT_LEFT);
          Font.Style := Font.Style  - [fsBold];
          OffsetY := H + 5;
        end;
      // image
      GX := -1;
      GY := -1;
      if (FspHint.FHintImageList <> nil) and (FspHint.FHintImageIndex >= 0) and
         (FspHint.FHintImageIndex < FspHint.FHintImageList.Count)
      then
        begin
          GX := R1.Left;
          if OffsetY = 0
          then
            GY := R1.Top + RectHeight(R1) div 2 -
                   FspHint.FHintImageList.Height div 2
          else
            GY := OffsetY;
          FspHint.FHintImageList.Draw(DrawBuffer.Canvas,
            GX, GY, FspHint.FHintImageIndex);
          OffsetX := GX + FspHint.FHintImageList.Width + 5;
        end;
      //
      R1.Top := R1.Top + OffsetY;
      R1.Left := R1.Left + OffsetX;
      DrawText(Handle, PChar(Caption), -1, R1, DT_LEFT);
    end;
  //
  Canvas.Draw(0, 0, DrawBuffer);
  DrawBuffer.Free;
end;

procedure TbsSkinHintWindow.Paint;
var
  R: TRect;
  B: TBitMap;
  W, H, X, Y: Integer;
begin
  if FspHint = nil then Exit;
  {$IFNDEF TNTUNICODE}
  if AExtendedStyle
  then
    begin
      PaintEx;
      Exit;
    end;
  {$ENDIF}  
  //
  DrawBuffer := TBitMap.Create;
  DrawBuffer.Width := Width;
  DrawBuffer.Height := Height;
  //
  if FSD <> nil
  then
    with DrawBuffer.Canvas, FSD.HintWindow do
    begin
      B := TBitMap(FSD.FActivePictures[WindowPictureIndex]);
      CreateSkinImageBS(LTPoint, RTPoint, LBPoint, RBPoint,
      CLRect, NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint,
      NewClRect, DrawBuffer, B,
      Rect(0, 0, B.Width, B.Height), Width, Height, True,
      FSD.HintWindow.LeftStretch, FSD.HintWindow.TopStretch,
      FSD.HintWindow.RightStretch, FSD.HintWindow.BottomStretch, StretchEffect, StretchType);
    end
  else
    with DrawBuffer.Canvas do
    begin
      Brush.Color := clInfoBk;
      FillRect(ClientRect);
      R := ClientRect;
      Frame3D(DrawBuffer.Canvas, R, clBtnShadow, clBtnShadow, 1);
    end;
  //
  if FSD <> nil
  then
    with DrawBuffer.Canvas, FSD.HintWindow do
    begin
      Brush.Style := bsClear;
      if FspHint.UseSkinFont
      then
        begin
          Font.Height := FontHeight;
          Font.Style := FontStyle;
          Font.Name := FontName;
        end
      else
        Font.Assign(FspHint.FDefaultFont);

      if (FspHint.SkinData <> nil) and (FspHint.SkinData.ResourceStrData <> nil)
      then
        Font.CharSet := FspHint.SkinData.ResourceStrData.CharSet
      else
        Font.CharSet := FspHint.DefaultFont.CharSet;

      Font.Color := FontColor;
      R := Rect(0, 0, 0, 0);
      {$IFDEF TNTUNICODE}
      BSDrawSkinText(DrawBuffer.Canvas, Caption, R, DT_CALCRECT or DT_LEFT);
      {$ELSE}
      DrawText(Handle, PChar(Caption), -1, R, DT_CALCRECT or DT_LEFT);
      {$ENDIF}
      W := RectWidth(R);
      H := RectHeight(R);
      X := NewClRect.Left + RectWidth(NewClRect) div 2 - W div 2;
      Y := NewClRect.Top + RectHeight(NewClRect) div 2 - H div 2;
      R := Rect(X, Y, X + W, Y + H);
      {$IFDEF TNTUNICODE}
      BSDrawSkinText(DrawBuffer.Canvas, Caption, R, DT_LEFT);
      {$ELSE}
      DrawText(Handle, PChar(Caption), -1, R, DT_LEFT);
      {$ENDIF}
    end
  else
    with DrawBuffer.Canvas do
    begin
      Font.Assign(FspHint.FDefaultFont);
      if (FspHint.SkinData <> nil) and (FspHint.SkinData.ResourceStrData <> nil)
      then
        Font.CharSet := FspHint.SkinData.ResourceStrData.CharSet
      else
        Font.CharSet := FspHint.DefaultFont.CharSet;
      Font.Color := clInfoText;
      Brush.Style := bsClear;
      R := Rect(2, 2, Width - 2, Height - 2);
      {$IFDEF TNTUNICODE}
      BSDrawSkinText(DrawBuffer.Canvas, Caption, R, DT_LEFT);
      {$ELSE}
      DrawText(Handle, PChar(Caption), -1, R, DT_LEFT);
      {$ENDIF}
    end;
  //
  Canvas.Draw(0, 0, DrawBuffer);
  DrawBuffer.Free;
end;

procedure TbsSkinHintWindow.WMEraseBkGnd(var Msg: TWMEraseBkgnd);
begin
  Msg.Result := 1;
end;

constructor TbsSkinHint.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlphaBlendAnimation := False;
  FLineSeparator := '@';
  FAlphaBlend := False; 
  HintTimer := nil;
  FSD := nil;
  FDefaultFont := TFont.Create;
  FActive := True;
  HW := TbsSkinHintWindow.Create(Self);
  HW.Visible := False;
  if not (csDesigning in ComponentState)
  then
    begin
      HintWindowClass := TbsSkinHintWindow;
      with Application do begin
        ShowHint := not ShowHint;
        ShowHint := not ShowHint;
        OnShowHint := SelfOnShowHint;
        Application.HintShortPause := 100;
      end;
    end;
  UseSkinFont := True;  
end;

destructor TbsSkinHint.Destroy;
begin
  HW.Free;
  FDefaultFont.Free;
  if HintTimer <> nil then HintTimer.Free;
  inherited Destroy;
end;

procedure TbsSkinHint.SetDefaultFont(Value: TFont);
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSkinHint.SetSkinData;
begin
  FSD := Value;
end;

procedure TbsSkinHint.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinHint.SetActive(Value: Boolean);
var
  i: Integer;
begin
  FActive := Value;
  if FActive and (Application.MainForm <> nil)
  then
    with Application.MainForm do
      for i := 0 to ComponentCount-1 do
        if (Components[i] is TbsSkinHint) and (Components[i] <> Self)
        then
          if TbsSkinHint(Components[i]).Active
          then TbsSkinHint(Components[i]).Active := False;

  if not (csDesigning in ComponentState) and FActive
  then Application.OnShowHint := SelfOnShowHint;
end;

procedure TbsSkinHint.SelfOnShowHint(var HintStr: string;
                                 var CanShow: Boolean; var HintInfo: THintInfo);
begin
  FHintTitle := '';
  FHintImageIndex := 0;
  FHintImageList := nil;
  if HintInfo.HintControl is TbsSkinControl
  then
    with TbsSkinControl(HintInfo.HintControl) do
    begin
      Self.FHintTitle := HintTitle;
      Self.FHintImageIndex := HintImageIndex;
      Self.FHintImageList := HintImageList;
    end
  else                                                      
  if HintInfo.HintControl is TbsGraphicSkinControl
  then
    with TbsGraphicSkinControl(HintInfo.HintControl) do
    begin
      Self.FHintTitle := HintTitle;
      Self.FHintImageIndex := HintImageIndex;
      Self.FHintImageList := HintImageList;
    end;
  if Assigned(FOnShowHint) then FOnShowHint(HintStr, CanShow, HintInfo);
end;

function TbsSkinHint.GetCursorHeightMargin: Integer;
  var
    IconInfo: TIconInfo;
    BitmapInfoSize, BitmapBitsSize, ImageSize: DWORD;
    Bitmap: PBitmapInfoHeader;
    Bits: Pointer;
    BytesPerScanline: Integer;

      function FindScanline(Source: Pointer; MaxLen: Cardinal;
        Value: Cardinal): Cardinal; assembler;
      asm
              PUSH    ECX
              MOV     ECX,EDX
              MOV     EDX,EDI
              MOV     EDI,EAX
              POP     EAX
              REPE    SCASB
              MOV     EAX,ECX
              MOV     EDI,EDX
      end;

  begin
    { Default value is entire icon height }
    Result := GetSystemMetrics(SM_CYCURSOR);
    if GetIconInfo(GetCursor, IconInfo) then
    try
      GetDIBSizes(IconInfo.hbmMask, BitmapInfoSize, BitmapBitsSize);
      Bitmap := AllocMem(DWORD(BitmapInfoSize) + BitmapBitsSize);
      try
      Bits := Pointer(DWORD(Bitmap) + BitmapInfoSize);
      if GetDIB(IconInfo.hbmMask, 0, Bitmap^, Bits^) and
        (Bitmap^.biBitCount = 1) then
      begin
        { Point Bits to the end of this bottom-up bitmap }
        with Bitmap^ do
        begin
          BytesPerScanline := ((biWidth * biBitCount + 31) and not 31) div 8;
          ImageSize := biWidth * BytesPerScanline;
          Bits := Pointer(DWORD(Bits) + BitmapBitsSize - ImageSize);
          { Use the width to determine the height since another mask bitmap
            may immediately follow }
          Result := FindScanline(Bits, ImageSize, $FF);
          { In case the and mask is blank, look for an empty scanline in the
            xor mask. }
          if (Result = 0) and (biHeight >= 2 * biWidth) then
            Result := FindScanline(Pointer(DWORD(Bits) - ImageSize),
            ImageSize, $00);
          Result := Result div BytesPerScanline;
        end;
        Dec(Result, IconInfo.yHotSpot);
      end;
      finally
        FreeMem(Bitmap, BitmapInfoSize + BitmapBitsSize);
      end;
    finally
      if IconInfo.hbmColor <> 0 then DeleteObject(IconInfo.hbmColor);
      if IconInfo.hbmMask <> 0 then DeleteObject(IconInfo.hbmMask);
    end;
end;

procedure TbsSkinHint.HintTimeEx1(Sender: TObject);
var
  R: TRect;
  P: TPoint;
begin
  if HintTimer = nil then Exit;
  GetCursorPos(P);
  P.Y := P.Y + GetCursorHeightMargin;
  R := Rect(P.X, P.Y, P.X, P.Y);
  HW.ActivateHintEx(R, FHintTitle, HintText, FHintImageIndex, FHintImageList);
  HW.Visible := True;
  HintTimer.Enabled := False;
  HintTimer.Interval := Application.HintHidePause;
  HintTimer.OnTimer := HintTime2;
  HintTimer.Enabled := True;
end;

procedure TbsSkinHint.ActivateHintEx(P: TPoint;
      const AHintTitle, AHint: string;
      AImageIndex: Integer; AImageList: TCustomImageList);
var
  R: TRect;
begin
  R := Rect(P.X, P.Y, P.X, P.Y);
  HW.ActivateHintEx(R, AHintTitle, AHint, AImageIndex, AImageList);
  HW.Visible := True;
end;

procedure TbsSkinHint.ActivateHintEx2(const AHintTitle, AHint: string;
   AImageIndex: Integer; AImageList: TCustomImageList);
begin
  if HintTimer <> nil
  then
    begin
      HintTimer.Enabled := False;
      HintTimer.Free;
      HintTimer := nil;
    end;

  FHintTitle := AHintTitle;
  FHintImageIndex := AImageIndex;
  FHintImageList := AImageList;
  HintText := AHint;
  HintTimer := TTimer.Create(Self);
  HintTimer.Enabled := False;
  HintTimer.Interval := Application.HintPause;
  HintTimer.OnTimer := HintTimeEx1;
  HintTimer.Enabled := True;
end;




procedure TbsSkinHint.HintTime1(Sender: TObject);
var
  R: TRect;
  P: TPoint;
begin
  GetCursorPos(P);
  P.Y := P.Y + GetCursorHeightMargin;
  R := Rect(P.X, P.Y, P.X, P.Y);
  HW.ActivateHint(R, HintText);
  HW.Visible := True;
  HintTimer.Enabled := False;
  HintTimer.Interval := Application.HintHidePause;
  HintTimer.OnTimer := HintTime2;
  HintTimer.Enabled := True;
end;

procedure TbsSkinHint.HintTime1x(Sender: TObject);
begin
  HW.ActivateHintFromRect(FromRect, HintText, Top);
  HW.Visible := True;
  HintTimer.Enabled := False;
  HintTimer.Interval := Application.HintHidePause;
  HintTimer.OnTimer := HintTime2;
  HintTimer.Enabled := True;
end;


procedure TbsSkinHint.HintTime2(Sender: TObject);
begin
  HideHint;
end;

procedure TbsSkinHint.ActivateHint3(AFromRect: TRect; const AHint: string; ATop: Boolean);
begin
  FromRect := AFromRect;
  Top := ATop;
  if HintTimer <> nil then HintTimer.Free;
  HintText := AHint;
  Self.FHintTitle := '';
  Self.FHintImageList := nil;
  Self.FHintImageIndex := 0;
  HintTimer := TTimer.Create(Self);
  HintTimer.Enabled := False;
  HintTimer.Interval := Application.HintPause;
  HintTimer.OnTimer := HintTime1x;
  HintTimer.Enabled := True;
end;

procedure TbsSkinHint.ActivateHint2(const AHint: string);
begin
  if HintTimer <> nil then HintTimer.Free;
  HintText := AHint;
  Self.FHintTitle := '';
  Self.FHintImageList := nil;
  Self.FHintImageIndex := 0;
  HintTimer := TTimer.Create(Self);
  HintTimer.Enabled := False;
  HintTimer.Interval := Application.HintPause;
  HintTimer.OnTimer := HintTime1;
  HintTimer.Enabled := True;
end;

procedure TbsSkinHint.ActivateHint(P: TPoint; const AHint: string);
var
  R: TRect;
begin
  Self.FHintTitle := '';
  Self.FHintImageList := nil;
  Self.FHintImageIndex := 0;
  R := Rect(P.X, P.Y, P.X, P.Y);
  HW.ActivateHint(R, AHint);
  HW.Visible := True;
end;

function TbsSkinHint.IsVisible: Boolean;
begin
  Result := HW.Visible;
end;

procedure TbsSkinHint.HideHint;
begin
  if HintTimer <> nil
  then
    begin
      HintTimer.Enabled := False;
      HintTimer.Free;
      HintTimer := nil;
    end;
  if HW.Visible
  then
    begin
      HW.Visible := False;
      SetWindowPos(HW.Handle, HWND_TOPMOST, 0, 0, 0,
        0, SWP_HideWINDOW or SWP_NOACTIVATE or SWP_NOSIZE);
      Self.FHintTitle := '';
      Self.FHintImageList := nil;
      Self.FHintImageIndex := 0;
    end;
end;

end.


