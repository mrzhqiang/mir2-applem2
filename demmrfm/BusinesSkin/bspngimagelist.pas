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

unit bsPngImageList;

{$WARNINGS OFF}
{$HINTS OFF}

{$IFDEF VER220}
{$DEFINE VER200}
{$ENDIF}

{$IFDEF VER210}
{$DEFINE VER200}
{$ENDIF}

interface

uses
  Windows, Classes, SysUtils, Controls, Graphics, CommCtrl, ImgList, Messages,
  bsPngImage {$IFDEF VER200},PngImage {$ENDIF};

type
  TbsPngImageList = class;

  TbsPngImageItem = class(TCollectionItem)
   private
    FPngImage: TbsPngImage;
    FName: string;
    procedure SetPngImage(const Value: TbsPngImage);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Name: string read FName write FName;
    property PngImage: TbsPngImage read FPngImage write SetPngImage;
  end;

  TbsPngImageItems = class(TCollection)
  private
    function GetItem(Index: Integer): TbsPngImageItem;
    procedure SetItem(Index: Integer; Value:  TbsPngImageItem);
  protected
    function GetOwner: TPersistent; override;
  public
    FPngImageList: TbsPngImageList;
    constructor Create(APNGImageList: TbsPngImageList);
    property Items[Index: Integer]:  TbsPngImageItem read GetItem write SetItem; default;
  end;

   TbsPngImageStorage = class;

   TbsPngStorageImageItem = class(TCollectionItem)
   private
    FPngImage: TbsPngImage;
    FName: string;
    procedure SetPngImage(const Value: TbsPngImage);
    function GetWidth: Integer;
    function GetHeight: Integer;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Name: string read FName write FName;
    property PngImage: TbsPngImage read FPngImage write SetPngImage;
    property PngWidth: Integer read GetWidth;
    property PngHeight: Integer read  GetHeight;
  end;

  TbsPngStorageImageItems = class(TCollection)
  private
    function GetItem(Index: Integer): TbsPngStorageImageItem;
    procedure SetItem(Index: Integer; Value:  TbsPngStorageImageItem);
  protected
    function GetOwner: TPersistent; override;
  public
    FPngImageList: TbsPngImageStorage;
    constructor Create(APNGImageList: TbsPngImageStorage);
    property Items[Index: Integer]:  TbsPngStorageImageItem read GetItem write SetItem; default;
  end;
  
  TbsPngImageList = class(TCustomImageList)
  private
    FPngImages: TbsPngImageItems;
    function GetPngWidth: Integer;
    function GetPngHeight: Integer;
    procedure SetPngWidth(Value: Integer);
    procedure SetPngHeight(Value: Integer);
    procedure SetPngImages(Value: TbsPngImageItems);
  protected
    procedure DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Style: Cardinal; Enabled: Boolean = True); override;
    procedure InsertBitMap(Index: Integer);
    procedure DeleteBitMap(Index: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property PngImages: TbsPngImageItems read FPngImages write SetPngImages;
    property PngWidth: Integer read GetPngWidth write SetPngWidth;
    property PngHeight: Integer read GetPngHeight write SetPngHeight;
  end;


  TbsPngImageStorage = class(TComponent)
  private
    FPngImages: TbsPngStorageImageItems;
    procedure SetPngImages(Value: TbsPngStorageImageItems);
  public
    procedure Draw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Enabled: Boolean = True);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property PngImages: TbsPngStorageImageItems read FPngImages write SetPngImages;
  end;

  TbsPngImageView = class(TGraphicControl)
  private
    FDoubleBuffered: Boolean;
    FReflectionImage: Pointer;
    FReflectionEffect: Boolean; 
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;
    FAutoSize: Boolean;
    FPngImageList: TbsPngImageList;
    FPngImageStorage: TbsPngImageStorage;
    FImageIndex: Integer;
    FCenter: Boolean;
    procedure SetDoubleBuffered(Value: Boolean);
    procedure SetAutoSize(Value: Boolean);
    procedure SetImageIndex(Value: Integer);
    procedure SetCenter(Value: Boolean);
    procedure SetReflectionEffect(Value: Boolean);
    procedure CreateReflection;
    procedure DestroyReflection;
  protected
    procedure AdjustBounds;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DoubleBuffered: Boolean
      read FDoubleBuffered write SetDoubleBuffered;
    property ReflectionEffect: Boolean
      read FReflectionEffect write SetReflectionEffect;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property PngImageList: TbsPngImageList
      read FPngImageList write FPngImageList;
    property PngImageStorage: TbsPngImageStorage
      read FPngImageStorage write FPngImageStorage;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Align;
    property Anchors;
    property Center: Boolean read FCenter write SetCenter default False;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

implementation
  Uses bsEffects, bsUtils;

procedure TbsPngImageItem.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if (Dest is TbsPngImageItem)
  then
    TbsPngImageItem(Dest).PngImage := PngImage;
end;

constructor TbsPngImageItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FPngImage := TbsPngImage.Create;
  FName := Format('PngImage%d', [Index]);
  TbsPngImageItems(Self.Collection).FPngImageList.InsertBitmap(Index);
end;

destructor TbsPngImageItem.Destroy;
begin
  FPngImage.Free;
  if TbsPngImageItems(Self.Collection).FPngImageList.Count > Index
  then
    TbsPngImageItems(Self.Collection).FPngImageList.DeleteBitmap(Index);
  inherited Destroy;
end;

procedure TbsPngImageItem.Assign(Source: TPersistent);
begin
  if Source is TbsPngImageItem
  then
    begin
      PngImage.Assign(TbsPngImageItem(Source).PngImage);
      Name := TbsPngImageItem(Source).Name;
   end
  else
    inherited Assign(Source);
end;

function TbsPngImageItem.GetDisplayName: string;
begin
  if Length(FName) = 0
  then Result := inherited GetDisplayName
  else Result := FName;
end;

procedure TbsPngImageItem.SetPngImage(const Value: TbsPngImage);
begin
  FPngImage.Assign(Value);
  Changed(True);
end;

constructor TbsPngImageItems.Create;
begin
  inherited Create(TbsPngImageItem);
  FPngImageList := APngImageList;
end;


function TbsPngImageItems.GetOwner: TPersistent;
begin
  Result := FPngImageList;
end;

function TbsPngImageItems.GetItem(Index: Integer): TbsPngImageItem;
begin
  Result := TbsPngImageItem(inherited GetItem(Index));
end;

procedure TbsPngImageItems.SetItem;
begin
  inherited SetItem(Index, Value);
end;


constructor TbsPngImageList.Create(AOwner: TComponent);
begin
  inherited;
  FPngImages := TbsPngImageItems.Create(Self);
end;

destructor TbsPngImageList.Destroy;
begin
  FPngImages.Free;
  FPngImages := nil;
  inherited;
end;

function TbsPngImageList.GetPngWidth: Integer;
begin
  Result := Width;
end;

function TbsPngImageList.GetPngHeight: Integer;
begin
  Result := Height;
end;

procedure TbsPngImageList.SetPngWidth(Value: Integer);
begin
  if Width <> Value
  then
    begin
      Width := Value;
      if not (csLoading in ComponentState)
      then
        FPngImages.Clear;
    end;
end;

procedure TbsPngImageList.SetPngHeight(Value: Integer);
begin
  if Height <> Value
  then
    begin
      Height := Value;
      if not (csLoading in ComponentState)
      then
      FPngImages.Clear;
    end;
end;


procedure TbsPngImageList.SetPngImages(Value: TbsPngImageItems);
begin
  FPngImages.Assign(Value);
end;

procedure TbsPngImageList.DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Style: Cardinal; Enabled: Boolean);

procedure MakeImageBlended(Image: TbsPngImage; Amount: Byte = 127);

  procedure ForceAlphachannel(BitTransparency: Boolean; TransparentColor: TColor);
  var
     Assigner: TBitmap;
     Temp: TbsPngImage;
     X, Y: Integer;
     {$IFNDEF VER200}
     Line: bspngimage.PByteArray;
     {$ELSE}
     Line: PByteArray;
     {$ENDIF}
     Current: TColor;
  begin
  Temp := TbsPngImage.Create;
  try
    Assigner := TBitmap.Create;
    try
      Assigner.Width := Image.Width;
      Assigner.Height := Image.Height;
      Temp.Assign(Assigner);
    finally
      Assigner.Free;
     end;
    Temp.CreateAlpha;
    for Y := 0 to Image.Height - 1
    do begin
       Line := Temp.AlphaScanline[Y];
       for X := 0 to Image.Width - 1
       do begin
          Current := Image.Pixels[X, Y];
          Temp.Pixels[X, Y] := Current;
          if BitTransparency and (Current = TransparentColor)
          then Line^[X] := 0
          else Line^[X] := Amount;
          end;
       end;
    Image.Assign(Temp);
  finally
    Temp.Free;
   end;
  end;

var
   X, Y: Integer;
   {$IFNDEF VER200}
   Line: bspngimage.PByteArray;
   {$ELSE}
   Line: PByteArray;
   {$ENDIF}
   Forced: Boolean;
   TransparentColor: TColor;
   BitTransparency: Boolean;
begin
  {$IFNDEF VER200}
  BitTransparency := Image.TransparencyMode = bsptmBit;
  {$ELSE}
  BitTransparency := Image.TransparencyMode = ptmBit;
  {$ENDIF}
  TransparentColor := Image.TransparentColor;
  if not (Image.Header.ColorType in [COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA])
  then
    begin
      Forced := Image.Header.ColorType in [COLOR_GRAYSCALE, COLOR_PALETTE];
      if Forced
      then
        ForceAlphachannel(BitTransparency, TransparentColor)
      else
        Image.CreateAlpha;
    end
  else
   Forced := False;

  if not Forced and (Image.Header.ColorType in [COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA])
  then
     for Y := 0 to Image.Height - 1 do
     begin
       Line := Image.AlphaScanline[Y];
       for X := 0 to Image.Width - 1 do
         if BitTransparency and (Image.Pixels[X, Y] = TransparentColor)
         then
           Line^[X] := 0
         else
           Line^[X] := Round(Line^[X] / 256 * (Amount + 1));
     end;
end;

procedure DrawPNG(Png: TbsPngImage; Canvas: TCanvas; const Rect: TRect; AEnabled: Boolean);
var
  PngCopy: TbsPngImage;
begin
  if not AEnabled
  then
   begin
     PngCopy := TbsPngImage.Create;
     try
       PngCopy.Assign(Png);
       MakeImageBlended(PngCopy);
       PngCopy.Draw(Canvas, Rect);
     finally
       PngCopy.Free;
      end;
    end
  else
    Png.Draw(Canvas, Rect);
end;


var
  PaintRect: TRect;
  Png: TbsPngImageItem;
begin
  PaintRect := Rect(X, Y, X + Width, Y + Height);
  Png := TbsPngImageItem(FPngImages.Items[Index]);
  if Png <> nil
  then
    DrawPNG(Png.PngImage, Canvas, PaintRect, Enabled);
end;

procedure TbsPngImageList.InsertBitMap(Index: Integer);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Monochrome := True;
  B.Width := Width;
  B.height := Height;
  Insert(Index, B, nil);
  B.Free;
end;

procedure TbsPngImageList.DeleteBitMap(Index: Integer);
begin
  Delete(Index);
end;

constructor TbsPngImageView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque] + [csReplicatable];
  FDoubleBuffered := False;
  FReflectionImage := nil;
  FReflectionEffect := False;
  FPngImageList := nil;
  FPngImageStorage := nil;
  FAutoSize := True;
  FImageIndex := -1;
  FCenter := False;
  Width := 50;
  Height := 50;
end;

destructor TbsPngImageView.Destroy;
begin
  if FReflectionImage <> nil then DestroyReflection;
  inherited;
end;

procedure TbsPngImageView.SetDoubleBuffered(Value: Boolean);
begin
  FDoubleBuffered := Value;
  if FDoubleBuffered
  then ControlStyle := ControlStyle + [csOpaque]
  else ControlStyle := ControlStyle - [csOpaque];
end;

procedure TbsPngImageView.CMEnabledChanged(var Message: TMessage);
begin
  if FReflectionEffect then CreateReflection;
  inherited;
end;

procedure TbsPngImageView.CreateReflection;
begin
  DestroyReflection;
  if (FPngImageStorage <> nil) and (FPngImageStorage.PngImages.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      TbsBitMap(FReflectionImage) := TbsBitMap.Create;
      MakeCopyFromPng(TbsBitMap(FReflectionImage),
        FPngImageStorage.PngImages[FImageIndex].FPngImage);
      if Enabled
      then
        TbsBitMap(FReflectionImage).Reflection
      else
        TbsBitMap(FReflectionImage).Reflection2;
    end
  else
  if (FPngImageList <> nil) and
     (FPngImageList.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageList.Count) and
     (FPngImageList.Width > 0) and
     (FPngImageList.Height > 0)
  then
    begin
      TbsBitMap(FReflectionImage) := TbsBitMap.Create;
      MakeCopyFromPng(TbsBitMap(FReflectionImage),
        FPngImageList.PngImages[FImageIndex].FPngImage);
      if Enabled
      then
        TbsBitMap(FReflectionImage).Reflection
      else
        TbsBitMap(FReflectionImage).Reflection2;
    end;
end;

procedure TbsPngImageView.DestroyReflection;
begin
  if FReflectionImage <> nil
  then
    begin
      TbsBitMap(FReflectionImage).Free;
      FReflectionImage := nil;
    end;
end;

procedure TbsPngImageView.CMMouseEnter;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  if Enabled
  then
    if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TbsPngImageView.SetReflectionEffect;
begin
  if FReflectionEffect <> Value
  then
    begin
      FReflectionEffect := Value;
      if FReflectionEffect then CreateReflection else DestroyReflection;
      AdjustBounds;
      RePaint;
    end;
end;

procedure TbsPngImageView.CMMouseLeave;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  if Enabled
  then
    if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TbsPngImageView.Paint;
var
  H, X, Y: Integer;
  C: TCanvas;
  Buffer: TBitMap;
begin
  if FDoubleBuffered
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := Width;
      Buffer.Height := Height;
      GetParentImage(Self, Buffer.Canvas);
      C := Buffer.Canvas;
    end
  else
    C := Canvas;

  if (FPngImageStorage <> nil) and (FPngImageStorage.PngImages.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      if FCenter
      then
        begin
          H := FPngImageStorage.PngImages[FImageIndex].PngHeight;
          if FReflectionImage <> nil then H := H + H div 2;
          Y := Height div 2 - H div 2;
          X := Width div 2 - FPngImageStorage.PngImages[FImageIndex].PngWidth div 2;
          FPngImageStorage.Draw(FImageIndex, C, X, Y, Enabled);
          if FReflectionImage <> nil
          then
            TbsBitMap(FReflectionImage).Draw(C,
              X, Y + FPngImageStorage.PngImages[FImageIndex].PngHeight);
        end
      else
        begin
          FPngImageStorage.Draw(FImageIndex, C, 0, 0, Enabled);
          if FReflectionImage <> nil
          then
            TbsBitMap(FReflectionImage).Draw(C,
              0, FPngImageStorage.PngImages[FImageIndex].PngHeight);
        end;
    end
  else
  if (FPngImageList <> nil) and
     (FPngImageList.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageList.Count) and
     (FPngImageList.Width > 0) and
     (FPngImageList.Height > 0)
  then
    begin
      if FCenter
      then
        begin
          H := FPngImageList.Height;
          if FReflectionImage <> nil then H := H + H div 2;
          Y := Height div 2 - H div 2;
          X := Width div 2 - FPngImageList.Width div 2;
          FPngImageList.Draw(C,  X, Y, FImageIndex, Enabled);
          if FReflectionImage <> nil
          then
            TbsBitMap(FReflectionImage).Draw(C,
              X, Y + FPngImageList.Height);
        end
      else
        begin
          FPngImageList.Draw(C, 0, 0, FImageIndex, Enabled);
          if FReflectionImage <> nil
          then
            TbsBitMap(FReflectionImage).Draw(C,
              0, FPngImageList.Height);
        end;
    end;

  if csDesigning in ComponentState
  then
    with C do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;

  if FDoubleBuffered
  then
    begin
      Canvas.Draw(0, 0, Buffer);
      Buffer.Free;
    end;
end;    

procedure TbsPngImageView.Loaded;
begin
  inherited Loaded;
  if FReflectionEffect then CreateReflection;
  AdjustBounds;
end;

procedure TbsPngImageView.AdjustBounds;
begin
  if FAutoSize and (FPngImageStorage <> nil) and
     (FPngImageStorage.PngImages.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      Width := FPngImageStorage.PngImages[FImageIndex].PngWidth;
      if FReflectionEffect
      then
        Height := FPngImageStorage.PngImages[FImageIndex].PngHeight  +
          FPngImageStorage.PngImages[FImageIndex].PngHeight div 2 + 5
      else
        Height := FPngImageStorage.PngImages[FImageIndex].PngHeight;
    end
  else
  if FAutoSize and (FPngImageList <> nil)
  then
    begin
      Width := FPngImageList.Width;
      if FReflectionEffect
      then
        Height := FPngImageList.Height  + FPngImageList.Height div 2 + 5
      else
        Height := FPngImageList.Height;
    end;
end;

procedure TbsPngImageView.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
  end;
end;

procedure TbsPngImageView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FPngImageList) then
    FPngImageList := nil;
  if (Operation = opRemove) and (AComponent = FPngImageStorage) then
    FPngImageStorage := nil;
end;

procedure TbsPngImageView.SetImageIndex(Value: Integer);
begin
  if Value >= -1
  then
    FImageIndex := Value;
  if FPngImageStorage <> nil
  then
    begin
      if FReflectionEffect then CreateReflection;
      if FAutoSize then AdjustBounds;
      RePaint;
    end
  else
  if FPngImageList <> nil
  then
    begin
      if FReflectionEffect then CreateReflection;
      if FAutoSize then AdjustBounds;
      RePaint;
    end;
end;

procedure TbsPngImageView.SetCenter;
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    RePaint;
  end;
end;


// TbsPngImageStorage

procedure TbsPngStorageImageItem.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if (Dest is TbsPngStorageImageItem)
  then
    TbsPngStorageImageItem(Dest).PngImage := PngImage;
end;

constructor TbsPngStorageImageItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FPngImage := TbsPngImage.Create;
  FName := Format('PngImage%d', [Index]);
end;

destructor TbsPngStorageImageItem.Destroy;
begin
  FPngImage.Free;
  inherited Destroy;
end;

function TbsPngStorageImageItem.GetWidth: Integer;
begin
  Result := FPngImage.Width;
end;

function TbsPngStorageImageItem.GetHeight: Integer;
begin
  Result := FPngImage.Height;
end;


procedure TbsPngStorageImageItem.Assign(Source: TPersistent);
begin
  if Source is TbsPngStorageImageItem
  then
    begin
      PngImage.Assign(TbsPngStorageImageItem(Source).PngImage);
      Name := TbsPngStorageImageItem(Source).Name;
   end
  else
    inherited Assign(Source);
end;

function TbsPngStorageImageItem.GetDisplayName: string;
begin
  if Length(FName) = 0
  then Result := inherited GetDisplayName
  else Result := FName;
end;

procedure TbsPngStorageImageItem.SetPngImage(const Value: TbsPngImage);
begin
  FPngImage.Assign(Value);
  Changed(True);
end;

constructor TbsPngStorageImageItems.Create;
begin
  inherited Create(TbsPngStorageImageItem);
  FPngImageList := APngImageList;
end;

function TbsPngStorageImageItems.GetOwner: TPersistent;
begin
  Result := FPngImageList;
end;

function TbsPngStorageImageItems.GetItem(Index: Integer): TbsPngStorageImageItem;
begin
  Result := TbsPngStorageImageItem(inherited GetItem(Index));
end;

procedure TbsPngStorageImageItems.SetItem;
begin
  inherited SetItem(Index, Value);
end;

constructor TbsPngImageStorage.Create(AOwner: TComponent);
begin
  inherited;
  FPngImages := TbsPngStorageImageItems.Create(Self);
end;

destructor TbsPngImageStorage.Destroy;
begin
  FPngImages.Free;
  FPngImages := nil;
  inherited;
end;

procedure TbsPngImageStorage.SetPngImages(Value: TbsPngStorageImageItems);
begin
  FPngImages.Assign(Value);
end;

procedure TbsPngImageStorage.Draw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Enabled: Boolean);

procedure MakeImageBlended(Image: TbsPngImage; Amount: Byte = 127);

  procedure ForceAlphachannel(BitTransparency: Boolean; TransparentColor: TColor);
  var
     Assigner: TBitmap;
     Temp: TbsPngImage;
     X, Y: Integer;
     {$IFNDEF VER200}
     Line: bspngimage.PByteArray;
     {$ELSE}
     Line: PByteArray;
     {$ENDIF}
     Current: TColor;
  begin
  Temp := TbsPngImage.Create;
  try
    Assigner := TBitmap.Create;
    try
      Assigner.Width := Image.Width;
      Assigner.Height := Image.Height;
      Temp.Assign(Assigner);
    finally
      Assigner.Free;
     end;
    Temp.CreateAlpha;
    for Y := 0 to Image.Height - 1
    do begin
       Line := Temp.AlphaScanline[Y];
       for X := 0 to Image.Width - 1
       do begin
          Current := Image.Pixels[X, Y];
          Temp.Pixels[X, Y] := Current;
          if BitTransparency and (Current = TransparentColor)
          then Line^[X] := 0
          else Line^[X] := Amount;
          end;
       end;
    Image.Assign(Temp);
  finally
    Temp.Free;
   end;
  end;

var
   X, Y: Integer;
   {$IFNDEF VER200}
   Line: bspngimage.PByteArray;
   {$ELSE}
   Line: PByteArray;
   {$ENDIF}
   Forced: Boolean;
   TransparentColor: TColor;
   BitTransparency: Boolean;
begin
  {$IFNDEF VER200}
  BitTransparency := Image.TransparencyMode = bsptmBit;
  {$ELSE}
  BitTransparency := Image.TransparencyMode = ptmBit;
  {$ENDIF}
  TransparentColor := Image.TransparentColor;
  if not (Image.Header.ColorType in [COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA])
  then
    begin
      Forced := Image.Header.ColorType in [COLOR_GRAYSCALE, COLOR_PALETTE];
      if Forced
      then
        ForceAlphachannel(BitTransparency, TransparentColor)
      else
        Image.CreateAlpha;
    end
  else
   Forced := False;

  if not Forced and (Image.Header.ColorType in [COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA])
  then
     for Y := 0 to Image.Height - 1 do
     begin
       Line := Image.AlphaScanline[Y];
       for X := 0 to Image.Width - 1 do
         if BitTransparency and (Image.Pixels[X, Y] = TransparentColor)
         then
           Line^[X] := 0
         else
           Line^[X] := Round(Line^[X] / 256 * (Amount + 1));
     end;
end;

procedure DrawPNG(Png: TbsPngImage; Canvas: TCanvas; const Rect: TRect; AEnabled: Boolean);
var
  PngCopy: TbsPngImage;
begin
  if not AEnabled
  then
   begin
     PngCopy := TbsPngImage.Create;
     try
       PngCopy.Assign(Png);
       MakeImageBlended(PngCopy);
       PngCopy.Draw(Canvas, Rect);
     finally
       PngCopy.Free;
      end;
    end
  else
    Png.Draw(Canvas, Rect);
end;


var
  PaintRect: TRect;
  Png: TbsPngImageItem;
begin
  PaintRect := Rect(X, Y,
    X + FPngImages.Items[Index].PngWidth,
    Y + FPngImages.Items[Index].PngHeight);
  Png := TbsPngImageItem(FPngImages.Items[Index]);
  if Png <> nil
  then
    DrawPNG(Png.PngImage, Canvas, PaintRect, Enabled);
end;

end.
