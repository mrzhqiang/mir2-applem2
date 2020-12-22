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

unit bsMessages;

{$WARNINGS OFF}
{$HINTS OFF}

{$IFDEF VER220}
{$DEFINE VER200}
{$ENDIF}

{$IFDEF VER210}
{$DEFINE VER200}
{$ENDIF}


// {$DEFINE TNTUNICODE}

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms,
     BusinessSkinForm, bsSkinData, bsSkinCtrls, ExtCtrls,
     Dialogs, ImgList {$IFDEF TNTUNICODE}, TntStdCtrls {$ENDIF};

type
  TbsMessageSetShowPosEvent = procedure (var AX, AY: Integer; AWidth, AHeight: Integer) of object;

  TbsMessageForm = class(TForm)
  protected
    procedure HelpButtonClick(Sender: TObject);
  public
    BSF: TbsBusinessSkinForm;
    DisplayCheckBox: TbsSkinCheckRadioBox;
    {$IFDEF TNTUNICODE}
    WideMessage: TTntLabel;
    {$ENDIF}
    Message: TbsSkinStdLabel;
    constructor CreateEx(AOwner: TComponent; X, Y: Integer);
  end;

  TbsSkinMessage = class(TComponent)
  protected
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FButtonSkinDataName: String;
    FMessageLabelSkinDataName: String;
    FDefaultFont: TFont;
    FDefaultButtonFont: TFont;
    FAlphaBlend: Boolean;
    FAlphaBlendAnimation: Boolean;
    FAlphaBlendValue: Byte;
    FUseSkinFont: Boolean;
    FShowAgainFlag: Boolean;
    FShowAgainFlagValue: Boolean;
    FOnSetShowPos: TbsMessageSetShowPosEvent;
    procedure SetDefaultFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    // messages with wide string
    function WideMessageDlg(const Msg: WideString; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;

    function WideMessageDlgPos(const Msg: WideString; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer;
    // 
    function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;

    function MessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer;

    function MessageDlgHelp(const Msg: string; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; HelpCtx: Longint; const HelpFileName: string): Integer;

    function CustomMessageDlg(const Msg: string;
      ACaption: String; AImages: TCustomImageList; AImageIndex: Integer;
      Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;

    function CustomMessageDlgPos(const Msg: string;
      ACaption: String; AImages: TCustomImageList; AImageIndex: Integer;
      Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer;

    function CustomMessageDlgHelp(const Msg: string;
      ACaption: String; AImages: TCustomImageList; AImageIndex: Integer;
      Buttons: TMsgDlgButtons; HelpCtx: Longint; const HelpFileName: string): Integer;

    function MessageDlg2(const Msg: string; ACaption: String; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;

    function MessageDlgHelp2(const Msg: string; ACaption: String; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; HelpCtx: Longint; const HelpFileName: string): Integer;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ShowAgainFlag: Boolean read FShowAgainFlag write FShowAgainFlag;
    property ShowAgainFlagValue: Boolean
      read FShowAgainFlagValue write FShowAgainFlagValue;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String
      read FButtonSkinDataName write FButtonSkinDataName;
    property MessageLabelSkinDataName: String
      read FMessageLabelSkinDataName write FMessageLabelSkinDataName;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property OnSetShowPos: TbsMessageSetShowPosEvent
      read FOnSetShowPos write FOnSetShowPos;
  end;

implementation

Uses bsUtils, bsConst;

var
  {$IFNDEF VER200}
  ButtonNames: array[TMsgDlgBtn] of string = (
    'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'NoToAll',
    'YesToAll', 'Help');
  {$ELSE}
  ButtonNames: array[TMsgDlgBtn] of string = (
    'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'NoToAll',
    'YesToAll', 'Help', 'Close');
  {$ENDIF}

  {$IFNDEF VER200}
  ButtonCaptions: array[TMsgDlgBtn] of string = (
    BS_MSG_BTN_YES, BS_MSG_BTN_NO, BS_MSG_BTN_OK, BS_MSG_BTN_CANCEL, BS_MSG_BTN_ABORT,
    BS_MSG_BTN_RETRY, BS_MSG_BTN_IGNORE, BS_MSG_BTN_ALL,
    BS_MSG_BTN_NOTOALL, BS_MSG_BTN_YESTOALL, BS_MSG_BTN_HELP);
  {$ELSE}
  ButtonCaptions: array[TMsgDlgBtn] of string = (
    BS_MSG_BTN_YES, BS_MSG_BTN_NO, BS_MSG_BTN_OK, BS_MSG_BTN_CANCEL, BS_MSG_BTN_ABORT,
    BS_MSG_BTN_RETRY, BS_MSG_BTN_IGNORE, BS_MSG_BTN_ALL,
    BS_MSG_BTN_NOTOALL, BS_MSG_BTN_YESTOALL, BS_MSG_BTN_HELP, BS_MSG_BTN_CLOSE);
  {$ENDIF}

  Captions: array[TMsgDlgType] of string = (BS_MSG_CAP_WARNING, BS_MSG_CAP_ERROR,
    BS_MSG_CAP_INFORMATION, BS_MSG_CAP_CONFIRM, '');

  {$IFNDEF VER200}
  ModalResults: array[TMsgDlgBtn] of Integer = (
    mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
    mrYesToAll, 0);
  {$ELSE}
  ModalResults: array[TMsgDlgBtn] of Integer = (
    mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
    mrYesToAll, 0, mrClose);
  {$ENDIF}


  IconIDs: array[TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, nil);

const
   MSGFORMBUTTONWIDTH = 40;

function GetButtonCaption(B: TMsgDlgBtn; ASkinData: TbsSkinData): String;
begin
  if (ASkinData <> nil) and (ASkinData.ResourceStrData <> nil)
  then
    case B of
      mbYes: Result := ASkinData.ResourceStrData.GetResStr('MSG_BTN_YES');
      mbNo: Result := ASkinData.ResourceStrData.GetResStr('MSG_BTN_NO');
      mbOK: Result := ASkinData.ResourceStrData.GetResStr('MSG_BTN_OK');
      mbCancel: Result := ASkinData.ResourceStrData.GetResStr('MSG_BTN_CANCEL');
      mbAbort: Result := ASkinData.ResourceStrData.GetResStr('MSG_BTN_ABORT');
      mbRetry: Result := ASkinData.ResourceStrData.GetResStr('MSG_BTN_RETRY');
      mbIgnore: Result := ASkinData.ResourceStrData.GetResStr('MSG_BTN_IGNORE');
      mbAll: Result := ASkinData.ResourceStrData.GetResStr('MSG_BTN_ALL');
      mbNoToAll: Result := ASkinData.ResourceStrData.GetResStr('MSG_BTN_NOTOALL');
      mbYesToAll: Result := ASkinData.ResourceStrData.GetResStr('MSG_BTN_YESTOALL');
      mbHelp: Result := ASkinData.ResourceStrData.GetResStr('MSG_BTN_HELP');
    end
  else
    Result := ButtonCaptions[B];
end;


function GetMsgCaption(DT: TMsgDlgType; ASkinData: TbsSkinData): String;
begin
  if (ASkinData <> nil) and (ASkinData.ResourceStrData <> nil)
  then
    case DT of
      mtWarning: Result := ASkinData.ResourceStrData.GetResStr('MSG_CAP_WARNING');
      mtError: Result := ASkinData.ResourceStrData.GetResStr('MSG_CAP_ERROR');
      mtInformation: Result := ASkinData.ResourceStrData.GetResStr('MSG_CAP_INFORMATION');
      mtConfirmation: Result := ASkinData.ResourceStrData.GetResStr('MSG_CAP_CONFIRM');
      mtCustom: Result := '';
    end
  else
    Result := Captions[DT];
end;

function CreateCustomMessageDialog(const Msg: string; ACaption: String;
  AImageList: TCustomImageList; AImageIndex: Integer;
  Buttons: TMsgDlgButtons; ASkinData, ACtrlSkinData: TbsSkinData;
  AButtonSkinDataName: String;  AMessageLabelSkinDataName: String;
  ADefaultFont: TFont; ADefaultButtonFont: TFont; AUseSkinFont: Boolean;
  AAlphaBlend, AAlphaBlendAnimation: Boolean; AAlphaBlendValue: Byte;
  AShowAgainFlag, AShowAgainFlagValue: Boolean; MX, MY: Integer): TbsMessageForm;
var
  BI, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth, X, Y: Integer;
  B, DefaultButton, CancelButton: TMsgDlgBtn;
  IconID: PChar;
  W: Integer;
begin
  Result := TbsMessageForm.CreateEx(Application, MX, MY);
  with Result do
  begin
    with BSF do
    begin
      SkinData := ASkinData;
      MenusSkinData := ACtrlSkinData;
      AlphaBlend := AAlphaBlend;
      AlphaBlendAnimation := AAlphaBlendAnimation;
      AlphaBlendValue := AAlphaBlendValue;
    end;

    ButtonWidth := 70;
    //
    if (ACtrlSkinData <> nil) and (not ACtrlSkinData.Empty)
    then
      begin
        BI := ACtrlSkinData.GetControlIndex(AButtonSkinDataName);
        if (BI <> -1) and
           (TbsDataSkinControl(ACtrlSkinData.CtrlList.Items[BI]) is TbsDataSkinButtonControl)
        then
          begin
            with TbsDataSkinButtonControl(ACtrlSkinData.CtrlList.Items[BI]) do
             ButtonHeight := SkinRect.Bottom - SkinRect.Top;
          end
        else
          ButtonHeight := 25;
      end
    else
      ButtonHeight := 25;
    //
    ButtonSpacing := 10;

    ButtonCount := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then Inc(ButtonCount);

    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);
    Caption := ACaption;

    // add label
    Result.Message := TbsSkinStdLabel.Create(Result);
    with Result.Message do
    begin
      Font := ADefaultFont;
      DefaultFont := ADefaultFont;
      UseSkinFont := AUseSkinFont;
      SkinDataName := AMessageLabelSkinDataName;
      SkinData := ACtrlSkinData;
      Name := 'Message';
      Parent := Result;
      AutoSize := True;
      Caption := Msg;
      Left := 50;
      Top := 15;
      X := Left + Width;
    end;

    if (AImageList <> nil) and (AImageIndex >= 0) and
       (AImageIndex <= AImageList.Count - 1)
    then
     with TImage.Create(Result) do
      begin
        Transparent := True;
        Width := AImageList.Width;
        Height := AImageList.Height;
        Name := 'Image';
        Parent := Result;
        AImageList.GetIcon(AImageIndex, Picture.Icon);
        Y := Result.Message.Top + Result.Message.Height div 2 - 16;
        Left := 5;
        Top := Y;
      end;

    ClientHeight := 50 + ButtonHeight + Result.Message.Height;

    if ButtonGroupWidth < X
    then
      ClientWidth := X + 40
    else
      ClientWidth := ButtonGroupWidth + 40;

    // "Do not display this message again" flag

    if AShowAgainFlag
    then
      begin
        ClientHeight := ClientHeight + 40;
        Result.DisplayCheckBox := TbsSkinCheckRadioBox.Create(Result);
        with Result.DisplayCheckBox do
        begin
          Name := 'checkbox';
          DefaultHeight := 30;
          Checked := not AShowAgainFlagValue;
          Parent := Result;
          DefaultFont := ADefaultFont;
          UseSkinFont := AUseSKinFont;
          SkinData := ACtrlSkinData;
          Y := Result.ClientHeight - ButtonHeight - 50;
          if (ACtrlSkinData <> nil) and (ACtrlSkinData.ResourceStrData <> nil)
          then
            begin
              Caption := ACtrlSkinData.ResourceStrData.GetResStr('MSG_CAP_SHOWFLAG');
              if Caption = '' then Caption := BS_MSG_CAP_SHOWFLAG;
            end
          else
            Caption := BS_MSG_CAP_SHOWFLAG;
          if (FIndex <> -1) and UseSkinFont
          then
            begin
              Result.Canvas.Font.Name := FontName;
              Result.Canvas.Font.Height := FontHeight;
            end
          else
            Result.Canvas.Font.Assign(ADefaultFont);
          W := Result.Canvas.TextWidth(Caption);
          W := W + 30;
          if Result.ClientWidth < W + 30 then Result.ClientWidth := W + 30;
          SetBounds(5, Y, W + 25, DefaultHeight);
        end;
      end;

    if Width > Result.BSF.GetMaxWidth
    then
      Width := Result.BSF.GetMaxWidth
    else
    if Width < Result.BSF.GetMinWidth
    then
      Width := Result.BSF.GetMinWidth;

    // add buttons
    if mbOk in Buttons then DefaultButton := mbOk else
      if mbYes in Buttons then DefaultButton := mbYes else
        DefaultButton := mbRetry;
    if mbCancel in Buttons then CancelButton := mbCancel else
      if mbNo in Buttons then CancelButton := mbNo else
        CancelButton := mbOk;
    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
        with TbsSkinButton.Create(Result) do
        begin
          Parent := Result;
          Name := ButtonNames[B];
          CanFocused := True;
          Caption := GetButtonCaption(B, ACtrlSkinData);
          ModalResult := ModalResults[B];
          if B = DefaultButton then Default := True;
          if B = CancelButton then Cancel := True;
          DefaultHeight := ButtonHeight;
          SetBounds(X, Result.ClientHeight - ButtonHeight - 10,
            ButtonWidth, ButtonHeight);
          DefaultFont := ADefaultButtonFont;
          UseSkinFont := AUseSkinFont;
          Inc(X, ButtonWidth + ButtonSpacing);
          if B = mbHelp then
            OnClick := Result.HelpButtonClick;
          SkinDataName := AButtonSkinDataName;
          SkinData := ACtrlSkinData;
        end;
  end;
end;


function CreateMessageDialog2(const Msg: string; ACaption: String;
  DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; ASkinData, ACtrlSkinData: TbsSkinData;
  AButtonSkinDataName: String;  AMessageLabelSkinDataName: String;
  ADefaultFont: TFont; ADefaultButtonFont: TFont; AUseSkinFont: Boolean;
  AAlphaBlend, AAlphaBlendAnimation: Boolean; AAlphaBlendValue: Byte;
  AShowAgainFlag, AShowAgainFlagValue: Boolean; MX, MY: Integer): TbsMessageForm;
var
  BI, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth, X, Y: Integer;
  B, DefaultButton, CancelButton: TMsgDlgBtn;
  IconID: PChar;
  W: Integer;
begin
  Result := TbsMessageForm.CreateEx(Application, MX, MY);
  with Result do
  begin
    with BSF do
    begin
      SkinData := ASkinData;
      MenusSkinData := ACtrlSkinData;
      AlphaBlend := AAlphaBlend;
      AlphaBlendAnimation := AAlphaBlendAnimation;
      AlphaBlendValue := AAlphaBlendValue;
    end;

    ButtonWidth := 70;
    //
    if (ACtrlSkinData <> nil) and (not ACtrlSkinData.Empty)
    then
      begin
        BI := ACtrlSkinData.GetControlIndex(AButtonSkinDataName);
        if (BI <> -1) and
           (TbsDataSkinControl(ACtrlSkinData.CtrlList.Items[BI]) is TbsDataSkinButtonControl)
        then
          begin
            with TbsDataSkinButtonControl(ACtrlSkinData.CtrlList.Items[BI]) do
             ButtonHeight := SkinRect.Bottom - SkinRect.Top;
          end
        else
          ButtonHeight := 25;
      end
    else
      ButtonHeight := 25;
    //
    ButtonSpacing := 10;

    ButtonCount := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then Inc(ButtonCount);

    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);

    Caption := ACaption;

    // add label
    Result.Message := TbsSkinStdLabel.Create(Result);
    with Result.Message do
    begin
      Font := ADefaultFont;
      DefaultFont := ADefaultFont;
      UseSkinFont := AUseSkinFont;
      SkinDataName := AMessageLabelSkinDataName;
      SkinData := ACtrlSkinData;
      Name := 'Message';
      Parent := Result;
      AutoSize := True;
      Caption := Msg;
      Left := 50;
      Top := 15;
      X := Left + Width;
    end;

    IconID := IconIDs[DlgType];
    with TImage.Create(Result) do
      begin
        Name := 'Image';
        Parent := Result;
        Picture.Icon.Handle := LoadIcon(0, IconID);
        Y := Result.Message.Top + Result.Message.Height div 2 - 16;
        if Y < 10 then Y := 10;
        SetBounds(5, Y, 32, 32);
      end;

    ClientHeight := 50 + ButtonHeight + Result.Message.Height;

    if ButtonGroupWidth < X
    then
      ClientWidth := X + 40
    else
      ClientWidth := ButtonGroupWidth + 40;


    // "Do not display this message again" flag

    if AShowAgainFlag
    then
      begin
        ClientHeight := ClientHeight + 40;
        Result.DisplayCheckBox := TbsSkinCheckRadioBox.Create(Result);
        with Result.DisplayCheckBox do
        begin
          Name := 'checkbox';
          DefaultHeight := 30;
          Checked := not AShowAgainFlagValue;
          Parent := Result;
          DefaultFont := ADefaultFont;
          UseSkinFont := AUseSKinFont;
          SkinData := ACtrlSkinData;
          Y := Result.ClientHeight - ButtonHeight - 50;
          if (ACtrlSkinData <> nil) and (ACtrlSkinData.ResourceStrData <> nil)
          then
            begin
              Caption := ACtrlSkinData.ResourceStrData.GetResStr('MSG_CAP_SHOWFLAG');
              if Caption = '' then Caption := BS_MSG_CAP_SHOWFLAG;
            end
          else
            Caption := BS_MSG_CAP_SHOWFLAG;
          if (FIndex <> -1) and UseSkinFont
          then
            begin
              Result.Canvas.Font.Name := FontName;
              Result.Canvas.Font.Height := FontHeight;
            end
          else
            Result.Canvas.Font.Assign(ADefaultFont);
          W := Result.Canvas.TextWidth(Caption);
          W := W + 30;
          if Result.ClientWidth < W + 30 then Result.ClientWidth := W + 30;
          SetBounds(5, Y, W + 25, DefaultHeight);
        end;
      end;

    if Width > Result.BSF.GetMaxWidth
    then
      Width := Result.BSF.GetMaxWidth
    else
    if Width < Result.BSF.GetMinWidth
    then
      Width := Result.BSF.GetMinWidth;

    // add buttons
    if mbOk in Buttons then DefaultButton := mbOk else
      if mbYes in Buttons then DefaultButton := mbYes else
        DefaultButton := mbRetry;
    if mbCancel in Buttons then CancelButton := mbCancel else
      if mbNo in Buttons then CancelButton := mbNo else
        CancelButton := mbOk;
    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
        with TbsSkinButton.Create(Result) do
        begin
          Parent := Result;
          Name := ButtonNames[B];
          CanFocused := True;
          Caption := GetButtonCaption(B, ACtrlSkinData);
          ModalResult := ModalResults[B];
          if B = DefaultButton then Default := True;
          if B = CancelButton then Cancel := True;
          DefaultHeight := ButtonHeight;
          SetBounds(X, Result.ClientHeight - ButtonHeight - 10,
            ButtonWidth, ButtonHeight);
          DefaultFont := ADefaultButtonFont;
          UseSkinFont := AUseSkinFont;
          Inc(X, ButtonWidth + ButtonSpacing);
          if B = mbHelp then
            OnClick := Result.HelpButtonClick;
          SkinDataName := AButtonSkinDataName;
          SkinData := ACtrlSkinData;
        end;
  end;
end;

function CreateMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; ASkinData, ACtrlSkinData: TbsSkinData;
  AButtonSkinDataName: String;  AMessageLabelSkinDataName: String;
  ADefaultFont: TFont; ADefaultButtonFont: TFont; AUseSkinFont: Boolean;
  AAlphaBlend, AAlphaBlendAnimation: Boolean; AAlphaBlendValue: Byte;
  AShowAgainFlag, AShowAgainFlagValue: Boolean; MX, MY: Integer): TbsMessageForm;
var
  BI, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth, X, Y: Integer;
  B, DefaultButton, CancelButton: TMsgDlgBtn;
  IconID: PChar;
  W: Integer;
begin
  Result := TbsMessageForm.CreateEx(Application, MX, MY);
  with Result do
  begin
    with BSF do
    begin
      SkinData := ASkinData;
      MenusSkinData := ACtrlSkinData;
      AlphaBlend := AAlphaBlend;
      AlphaBlendAnimation := AAlphaBlendAnimation;
      AlphaBlendValue := AAlphaBlendValue;
    end;

    ButtonWidth := 70;
    //
    if (ACtrlSkinData <> nil) and (not ACtrlSkinData.Empty)
    then
      begin
        BI := ACtrlSkinData.GetControlIndex(AButtonSkinDataName);
        if (BI <> -1) and
           (TbsDataSkinControl(ACtrlSkinData.CtrlList.Items[BI]) is TbsDataSkinButtonControl)
        then
          begin
            with TbsDataSkinButtonControl(ACtrlSkinData.CtrlList.Items[BI]) do
             ButtonHeight := SkinRect.Bottom - SkinRect.Top;
          end
        else
          ButtonHeight := 25;
      end
    else
      ButtonHeight := 25;
    //
    ButtonSpacing := 10;

    ButtonCount := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then Inc(ButtonCount);

    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);


    if DlgType <> mtCustom
    then Caption := GetMsgCaption(DlgType, ACtrlSkinData)
    else Caption := Application.Title;

    // add label
    Result.Message := TbsSkinStdLabel.Create(Result);
    with Result.Message do
    begin
      Font := ADefaultFont;
      DefaultFont := ADefaultFont;
      UseSkinFont := AUseSkinFont;
      SkinDataName := AMessageLabelSkinDataName;
      SkinData := ACtrlSkinData;
      Name := 'Message';
      Parent := Result;
      AutoSize := True;
      Caption := Msg;
      Left := 50;
      Top := 15;
      X := Left + Width;
    end;

    IconID := IconIDs[DlgType];
    with TImage.Create(Result) do
      begin
        Name := 'Image';
        Parent := Result;
        Picture.Icon.Handle := LoadIcon(0, IconID);
        Y := Result.Message.Top + Result.Message.Height div 2 - 16;
        if Y < 10 then Y := 10;
        SetBounds(5, Y, 32, 32);
      end;

    ClientHeight := 50 + ButtonHeight + Result.Message.Height;

    if ButtonGroupWidth < X
    then
      ClientWidth := X + 40
    else
      ClientWidth := ButtonGroupWidth + 40;

    // "Do not display this message again" flag

    if AShowAgainFlag
    then
      begin
        ClientHeight := ClientHeight + 40;
        Result.DisplayCheckBox := TbsSkinCheckRadioBox.Create(Result);
        with Result.DisplayCheckBox do
        begin
          Name := 'checkbox';
          DefaultHeight := 30;
          Checked := not AShowAgainFlagValue;
          Parent := Result;
          DefaultFont := ADefaultFont;
          UseSkinFont := AUseSKinFont;
          SkinData := ACtrlSkinData;
          Y := Result.ClientHeight - ButtonHeight - 50;
          if (ACtrlSkinData <> nil) and (ACtrlSkinData.ResourceStrData <> nil)
          then
            begin
              Caption := ACtrlSkinData.ResourceStrData.GetResStr('MSG_CAP_SHOWFLAG');
              if Caption = '' then Caption := BS_MSG_CAP_SHOWFLAG;
            end
          else
            Caption := BS_MSG_CAP_SHOWFLAG;
          if (FIndex <> -1) and UseSkinFont
          then
            begin
              Result.Canvas.Font.Name := FontName;
              Result.Canvas.Font.Height := FontHeight;
            end
          else
            Result.Canvas.Font.Assign(ADefaultFont);
          W := Result.Canvas.TextWidth(Caption);
          W := W + 30;
          if Result.ClientWidth < W + 30 then Result.ClientWidth := W + 30;
          SetBounds(5, Y, W + 25, DefaultHeight);
        end;
      end;

    if Width > Result.BSF.GetMaxWidth
    then
      Width := Result.BSF.GetMaxWidth
    else
    if Width < Result.BSF.GetMinWidth
    then
      Width := Result.BSF.GetMinWidth;

    // add buttons
    if mbOk in Buttons then DefaultButton := mbOk else
      if mbYes in Buttons then DefaultButton := mbYes else
        DefaultButton := mbRetry;
    if mbCancel in Buttons then CancelButton := mbCancel else
      if mbNo in Buttons then CancelButton := mbNo else
        CancelButton := mbOk;
    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
        with TbsSkinButton.Create(Result) do
        begin
          Parent := Result;
          Name := ButtonNames[B];
          CanFocused := True;
          Caption := GetButtonCaption(B, ACtrlSkinData);
          ModalResult := ModalResults[B];
          if B = DefaultButton then Default := True;
          if B = CancelButton then Cancel := True;
          DefaultHeight := ButtonHeight;
          SetBounds(X, Result.ClientHeight - ButtonHeight - 10,
            ButtonWidth, ButtonHeight);
          DefaultFont := ADefaultButtonFont;
          UseSkinFont := AUseSkinFont;
          Inc(X, ButtonWidth + ButtonSpacing);
          if B = mbHelp then
            OnClick := Result.HelpButtonClick;
          SkinDataName := AButtonSkinDataName;
          SkinData := ACtrlSkinData;
        end;
  end;
end;

function CreateWideMessageDialog(const Msg: WideString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; ASkinData, ACtrlSkinData: TbsSkinData;
  AButtonSkinDataName: String;  AMessageLabelSkinDataName: String;
  ADefaultFont: TFont; ADefaultButtonFont: TFont; AUseSkinFont: Boolean;
  AAlphaBlend, AAlphaBlendAnimation: Boolean; AAlphaBlendValue: Byte;
  MX, MY: Integer): TbsMessageForm;
var
  BI, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth, X, Y: Integer;
  B, DefaultButton, CancelButton: TMsgDlgBtn;
  IconID: PChar;
  W: Integer;
begin
  Result := TbsMessageForm.CreateEx(Application, MX, MY);
  with Result do
  begin
    with BSF do
    begin
      SkinData := ASkinData;
      MenusSkinData := ACtrlSkinData;
      AlphaBlend := AAlphaBlend;
      AlphaBlendAnimation := AAlphaBlendAnimation;
      AlphaBlendValue := AAlphaBlendValue;
    end;

    ButtonWidth := 70;
    //
    if (ACtrlSkinData <> nil) and (not ACtrlSkinData.Empty)
    then
      begin
        BI := ACtrlSkinData.GetControlIndex(AButtonSkinDataName);
        if (BI <> -1) and
           (TbsDataSkinControl(ACtrlSkinData.CtrlList.Items[BI]) is TbsDataSkinButtonControl)
        then
          begin
            with TbsDataSkinButtonControl(ACtrlSkinData.CtrlList.Items[BI]) do
             ButtonHeight := SkinRect.Bottom - SkinRect.Top;
          end
        else
          ButtonHeight := 25;
      end
    else
      ButtonHeight := 25;
    //
    ButtonSpacing := 10;

    ButtonCount := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then Inc(ButtonCount);

    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);


    if DlgType <> mtCustom
    then Caption := GetMsgCaption(DlgType, ACtrlSkinData)
    else Caption := Application.Title;

    // message text

    {$IFDEF TNTUNICODE}
    Result.WideMessage := TTNTLabel.Create(Result);
    with Result.WideMessage do
    begin
      Transparent := True;
      Font := ADefaultFont;
      if (ACtrlSkinData <> nil) and not ACtrlSkinData.Empty
      then
        Font.Color := ACtrlSkinData.SkinColors.cBtnText;
      Name := 'Message';
      Parent := Result;
      AutoSize := True;
      Caption := Msg;
      Left := 50;
      Top := 15;
      X := Left + Width;
    end;
    {$ELSE}
    Result.Message := TbsSkinStdLabel.Create(Result);
    with Result.Message do
    begin
      Font := ADefaultFont;
      DefaultFont := ADefaultFont;
      UseSkinFont := AUseSkinFont;
      SkinDataName := AMessageLabelSkinDataName;
      SkinData := ACtrlSkinData;
      Name := 'Message';
      Parent := Result;
      AutoSize := True;
      Caption := Msg;
      Left := 50;
      Top := 15;
      X := Left + Width;
    end;
    {$ENDIF}

    IconID := IconIDs[DlgType];
    with TImage.Create(Result) do
      begin
        Name := 'Image';
        Parent := Result;
        Picture.Icon.Handle := LoadIcon(0, IconID);
        {$IFDEF TNTUNICODE}
        Y := Result.WideMessage.Top + Result.WideMessage.Height div 2 - 16;
        {$ELSE}
        Y := Result.Message.Top + Result.Message.Height div 2 - 16;
        {$ENDIF}
        if Y < 10 then Y := 10;
        SetBounds(5, Y, 32, 32);
      end;

    {$IFDEF TNTUNICODE}
     ClientHeight := 50 + ButtonHeight + Result.WideMessage.Height;
    {$ELSE}
     ClientHeight := 50 + ButtonHeight + Result.Message.Height;
    {$ENDIF}

    if ButtonGroupWidth < X
    then
      ClientWidth := X + 40
    else
      ClientWidth := ButtonGroupWidth + 40;

    if Width > Result.BSF.GetMaxWidth
    then
      Width := Result.BSF.GetMaxWidth
    else
    if Width < Result.BSF.GetMinWidth
    then
      Width := Result.BSF.GetMinWidth;

    // add buttons
    if mbOk in Buttons then DefaultButton := mbOk else
      if mbYes in Buttons then DefaultButton := mbYes else
        DefaultButton := mbRetry;
    if mbCancel in Buttons then CancelButton := mbCancel else
      if mbNo in Buttons then CancelButton := mbNo else
        CancelButton := mbOk;
    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
        with TbsSkinButton.Create(Result) do
        begin
          Parent := Result;
          Name := ButtonNames[B];
          CanFocused := True;
          Caption := GetButtonCaption(B, ACtrlSkinData);
          ModalResult := ModalResults[B];
          if B = DefaultButton then Default := True;
          if B = CancelButton then Cancel := True;
          DefaultHeight := ButtonHeight;
          SetBounds(X, Result.ClientHeight - ButtonHeight - 10,
            ButtonWidth, ButtonHeight);
          DefaultFont := ADefaultButtonFont;
          UseSkinFont := AUseSkinFont;
          Inc(X, ButtonWidth + ButtonSpacing);
          if B = mbHelp then
            OnClick := Result.HelpButtonClick;
          SkinDataName := AButtonSkinDataName;
          SkinData := ACtrlSkinData;
        end;
  end;
end;

constructor TbsMessageForm.CreateEx(AOwner: TComponent; X, Y: Integer);
begin
  inherited CreateNew(AOwner);
  DisplayCheckBox := nil;
  BorderStyle := bsDialog;
  KeyPreview := True;
  if X < -10000
  then
    Self.Position := poScreenCenter
  else
    begin
      Self.Position := poDesigned;
      Self.Left := X;
      Self.Top := Y;
    end;
  BSF := TbsBusinessSkinForm.Create(Self);
  BSF.BorderIcons := [];
end;

procedure TbsMessageForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

constructor TbsSkinMessage.Create;
begin
  inherited Create(AOwner);
  FShowAgainFlag := False;
  FShowAgainFlagValue := False;
  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;
  FButtonSkinDataName := 'button';
  FMessageLabelSkinDataName := 'stdlabel';
  FDefaultFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FUseSkinFont := True;
  with FDefaultFont do
  begin
    Name := 'Arial';
    Style := [];
    Height := 14;
  end;
  with FDefaultButtonFont do
  begin
    Name := 'Arial';
    Style := [];
    Height := 14;
  end;
end;

destructor TbsSkinMessage.Destroy;
begin
  FDefaultFont.Free;
  FDefaultButtonFont.Free;
  inherited;
end;

function TbsSkinMessage.CustomMessageDlgHelp;
begin
  with CreateCustomMessageDialog(Msg, ACaption, AImages, AImageIndex, Buttons,
       FSD, FCtrlFSD, FButtonSkinDataName,
       FMessageLabelSkinDataName, FDefaultFont, FDefaultButtonFont, FUseSkinFont,
       FAlphaBlend, FAlphaBlendAnimation, FAlphaBlendValue, FShowAgainFlag, FShowAgainFlagValue,
       -10001, -10001) do
  begin
    try
      HelpContext := HelpCtx;
      HelpFile := HelpFileName;
      Result := ShowModal;
    finally
      if DisplayCheckBox <> nil
      then
        begin
          Self.ShowAgainFlagValue := not DisplayCheckBox.Checked;
        end;
      Free;
    end;
  end;
end;

function  TbsSkinMessage.CustomMessageDlgPos(const Msg: string;
      ACaption: String; AImages: TCustomImageList; AImageIndex: Integer;
      Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer;
var
  FX, FY: Integer;
begin
  with CreateCustomMessageDialog(Msg, ACaption, AImages, AImageIndex, Buttons,
       FSD, FCtrlFSD, FButtonSkinDataName,
       FMessageLabelSkinDataName, FDefaultFont, FDefaultButtonFont, FUseSkinFont,
       FAlphaBlend, FAlphaBlendAnimation, FAlphaBlendValue, FShowAgainFlag, FShowAgainFlagValue,
       X, Y) do
    try
      HelpContext := HelpCtx;
      if Assigned(FOnSetShowPos)
      then
        begin
          FX := Left;
          FY := Top;
          FOnSetShowPos(FX, FY, Width, Height);
          Left := FX;
          Top := FY;
        end;

      Result := ShowModal;
    finally
      if DisplayCheckBox <> nil
      then
        begin
          Self.ShowAgainFlagValue := not DisplayCheckBox.Checked;
        end;
      Free;
    end;
end;

function TbsSkinMessage.CustomMessageDlg;
begin
  with CreateCustomMessageDialog(Msg, ACaption, AImages, AImageIndex, Buttons,
       FSD, FCtrlFSD, FButtonSkinDataName,
       FMessageLabelSkinDataName, FDefaultFont, FDefaultButtonFont, FUseSkinFont,
       FAlphaBlend, FAlphaBlendAnimation, FAlphaBlendValue, FShowAgainFlag, FShowAgainFlagValue,
       -10001, -10001) do
    try
      HelpContext := HelpCtx;
      Result := ShowModal;
    finally
      if DisplayCheckBox <> nil
      then
        begin
          Self.ShowAgainFlagValue := not DisplayCheckBox.Checked;
        end;
      Free;
    end;
end;

function TbsSkinMessage.MessageDlg2;
begin
  with CreateMessageDialog2(Msg, ACaption, DlgType, Buttons,
       FSD, FCtrlFSD, FButtonSkinDataName,
       FMessageLabelSkinDataName, FDefaultFont, FDefaultButtonFont, FUseSkinFont,
       FAlphaBlend, FAlphaBlendAnimation, FAlphaBlendValue, FShowAgainFlag, FShowAgainFlagValue,
       -10001, -10001) do
  begin
    try
      HelpContext := HelpCtx;
      Result := ShowModal;
    finally
      if DisplayCheckBox <> nil
      then
        begin
          Self.ShowAgainFlagValue := not DisplayCheckBox.Checked;
        end;
      Free;
    end;
  end;
end;

function TbsSkinMessage.MessageDlgHelp2;
begin
  with CreateMessageDialog2(Msg, ACaption,
       DlgType, Buttons,
       FSD, FCtrlFSD, FButtonSkinDataName,
       FMessageLabelSkinDataName, FDefaultFont, FDefaultButtonFont, FUseSkinFont,
       FAlphaBlend, FAlphaBlendAnimation, FAlphaBlendValue, FShowAgainFlag, FShowAgainFlagValue,
       -10001, -10001) do
  begin
    try
      HelpContext := HelpCtx;
      HelpFile := HelpFileName;
      Result := ShowModal;
    finally
      if DisplayCheckBox <> nil
      then
        begin
          Self.ShowAgainFlagValue := not DisplayCheckBox.Checked;
        end;
      Free;
    end;
  end;
end;

function TbsSkinMessage.MessageDlgPos;
var
  FX, FY: Integer;
begin
  with CreateMessageDialog(Msg, DlgType, Buttons,
       FSD, FCtrlFSD, FButtonSkinDataName,
       FMessageLabelSkinDataName, FDefaultFont, FDefaultButtonFont, FUseSkinFont,
       FAlphaBlend, FAlphaBlendAnimation, FAlphaBlendValue, FShowAgainFlag, FShowAgainFlagValue,
       X, Y) do
  begin
    try
      HelpContext := HelpCtx;
      if Assigned(FOnSetShowPos)
      then
        begin
          FX := Left;
          FY := Top;
          FOnSetShowPos(FX, FY, Width, Height);
          Left := FX;
          Top := FY;
        end;
      Result := ShowModal;
    finally
      if DisplayCheckBox <> nil
      then
        begin
          Self.ShowAgainFlagValue := not DisplayCheckBox.Checked;
        end;
      Free;
    end;
  end;
end;

function TbsSkinMessage.WideMessageDlgPos;
begin
  with CreateWideMessageDialog(Msg, DlgType, Buttons,
       FSD, FCtrlFSD, FButtonSkinDataName,
       FMessageLabelSkinDataName, FDefaultFont, FDefaultButtonFont, FUseSkinFont,
       FAlphaBlend, FAlphaBlendAnimation, FAlphaBlendValue,
       X, Y) do
  begin
    try
      HelpContext := HelpCtx;
      Result := ShowModal;
    finally
      Free;
    end;
  end;
end;


function TbsSkinMessage.MessageDlg;
begin
  with CreateMessageDialog(Msg, DlgType, Buttons,
       FSD, FCtrlFSD, FButtonSkinDataName,
       FMessageLabelSkinDataName, FDefaultFont, FDefaultButtonFont, FUseSkinFont,
       FAlphaBlend, FAlphaBlendAnimation, FAlphaBlendValue, FShowAgainFlag, FShowAgainFlagValue,
       -10001, -10001) do
  begin
    try
      HelpContext := HelpCtx;
      Result := ShowModal;
    finally
      if DisplayCheckBox <> nil
      then
        begin
          Self.ShowAgainFlagValue := not DisplayCheckBox.Checked;
        end;
      Free;
    end;
  end;
end;

function TbsSkinMessage.WideMessageDlg;
begin
  with CreateWideMessageDialog(Msg, DlgType, Buttons,
       FSD, FCtrlFSD, FButtonSkinDataName,
       FMessageLabelSkinDataName, FDefaultFont, FDefaultButtonFont, FUseSkinFont,
       FAlphaBlend, FAlphaBlendAnimation, FAlphaBlendValue,
       -10001, -10001) do
  begin
    try
      HelpContext := HelpCtx;
      Result := ShowModal;
    finally
      Free;
    end;
  end;
end;


function TbsSkinMessage.MessageDlgHelp;
begin
  with CreateMessageDialog(Msg, DlgType, Buttons,
       FSD, FCtrlFSD, FButtonSkinDataName,
       FMessageLabelSkinDataName, FDefaultFont, FDefaultButtonFont, FUseSkinFont,
       FAlphaBlend, FAlphaBlendAnimation, FAlphaBlendValue, FShowAgainFlag, FShowAgainFlagValue,
       -10001, -10001) do
  begin
    try
      HelpContext := HelpCtx;
      HelpFile := HelpFileName;
      Result := ShowModal;
    finally
      if DisplayCheckBox <> nil
      then
        begin
          Self.ShowAgainFlagValue := not DisplayCheckBox.Checked;
        end;
      Free;
    end;
  end;
end;

procedure TbsSkinMessage.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSkinMessage.SetDefaultButtonFont;
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinMessage.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

end.
