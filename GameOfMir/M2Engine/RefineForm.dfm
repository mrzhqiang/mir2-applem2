object frmRefine: TfrmRefine
  Left = 0
  Top = 0
  Caption = '\u88c5\u5907\u51dd\u7ec3\u7cfb\u7edf'
  ClientHeight = 480
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 520
    Height = 480
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lblTitle: TLabel
      Left = 8
      Top = 8
      Width = 96
      Height = 16
      Caption = '\u88c5\u5907\u51dd\u7ec3\u7cfb\u7edf'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gbEquipment: TGroupBox
      Left = 8
      Top = 32
      Width = 240
      Height = 80
      Caption = '\u88c5\u5907\u9009\u62e9'
      TabOrder = 0
      object lblEquipment: TLabel
        Left = 8
        Top = 20
        Width = 60
        Height = 13
        Caption = '\u672a\u9009\u62e9\u88c5\u5907'
      end
      object lblRefineLevel: TLabel
        Left = 8
        Top = 36
        Width = 60
        Height = 13
        Caption = '\u51dd\u7ec3\u7b49\u7ea7: --'
      end
      object btnSelectEquipment: TButton
        Left = 152
        Top = 16
        Width = 80
        Height = 25
        Caption = '\u9009\u62e9\u88c5\u5907'
        TabOrder = 0
        OnClick = btnSelectEquipmentClick
      end
    end
    object gbMaterials: TGroupBox
      Left = 256
      Top = 32
      Width = 256
      Height = 140
      Caption = '\u51dd\u7ec3\u6750\u6599'
      TabOrder = 1
      object lblMaterial1: TLabel
        Left = 8
        Top = 20
        Width = 60
        Height = 13
        Caption = '\u672a\u9009\u62e9\u6750\u6599'
      end
      object lblMaterial2: TLabel
        Left = 8
        Top = 52
        Width = 60
        Height = 13
        Caption = '\u672a\u9009\u62e9\u6750\u6599'
      end
      object lblMaterial3: TLabel
        Left = 8
        Top = 84
        Width = 60
        Height = 13
        Caption = '\u672a\u9009\u62e9\u6750\u6599'
      end
      object btnSelectMaterial1: TButton
        Left = 168
        Top = 16
        Width = 80
        Height = 25
        Caption = '\u9009\u62e9\u6750\u65991'
        TabOrder = 0
        OnClick = btnSelectMaterial1Click
      end
      object btnSelectMaterial2: TButton
        Left = 168
        Top = 48
        Width = 80
        Height = 25
        Caption = '\u9009\u62e9\u6750\u65992'
        TabOrder = 1
        OnClick = btnSelectMaterial2Click
      end
      object btnSelectMaterial3: TButton
        Left = 168
        Top = 80
        Width = 80
        Height = 25
        Caption = '\u9009\u62e9\u6750\u65993'
        TabOrder = 2
        OnClick = btnSelectMaterial3Click
      end
      object btnClearMaterials: TButton
        Left = 168
        Top = 112
        Width = 80
        Height = 25
        Caption = '\u6e05\u7a7a\u6750\u6599'
        TabOrder = 3
        OnClick = btnClearMaterialsClick
      end
    end
    object gbSuccessRate: TGroupBox
      Left = 8
      Top = 120
      Width = 240
      Height = 52
      Caption = '\u6210\u529f\u7387'
      TabOrder = 2
      object lblSuccessRate: TLabel
        Left = 8
        Top = 20
        Width = 60
        Height = 13
        Caption = '\u6210\u529f\u7387: 0.0%'
      end
      object pbSuccessRate: TProgressBar
        Left = 88
        Top = 16
        Width = 144
        Height = 17
        TabOrder = 0
      end
    end
    object btnRefine: TButton
      Left = 8
      Top = 180
      Width = 100
      Height = 30
      Caption = '\u5f00\u59cb\u51dd\u7ec3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnRefineClick
    end
    object btnSynthesize: TButton
      Left = 116
      Top = 180
      Width = 100
      Height = 30
      Caption = '\u6750\u6599\u5408\u6210'
      TabOrder = 4
      OnClick = btnSynthesizeClick
    end
    object btnSoulBind: TButton
      Left = 224
      Top = 180
      Width = 100
      Height = 30
      Caption = '\u7075\u9b42\u7ed1\u5b9a'
      TabOrder = 8
      OnClick = btnSoulBindClick
    end
    object btnClose: TButton
      Left = 432
      Top = 180
      Width = 80
      Height = 30
      Caption = '\u5173\u95ed'
      TabOrder = 5
      OnClick = btnCloseClick
    end
  object gbAttributes: TGroupBox
    Left = 8
    Top = 220
    Width = 240
    Height = 252
    Caption = '\u51dd\u7ec3\u5c5e\u6027'
    TabOrder = 6
    object lblQuality: TLabel
      Left = 8
      Top = 20
      Width = 60
      Height = 13
      Caption = '\u54c1\u8d28: \u7c97\u7cd9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotalPoints: TLabel
      Left = 8
      Top = 36
      Width = 80
      Height = 13
      Caption = '\u603b\u5c5e\u6027\u70b9\u6570: 0'
    end
    object memoAttributes: TMemo
      Left = 8
      Top = 56
      Width = 224
      Height = 188
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object gbLog: TGroupBox
    Left = 256
    Top = 220
    Width = 256
    Height = 252
    Caption = '\u64cd\u4f5c\u65e5\u5fd7'
    TabOrder = 7
    object memoLog: TMemo
      Left = 8
      Top = 16
      Width = 240
      Height = 228
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  end
end
