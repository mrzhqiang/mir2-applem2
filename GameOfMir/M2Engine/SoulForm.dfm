object frmSoul: TfrmSoul
  Left = 0
  Top = 0
  Width = 800
  Height = 600
  Caption = '\u5143\u9b44/\u7cbe\u9b42\u5408\u6210\u7cfb\u7edf'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 600
    Align = alClient
    TabOrder = 0
    object lblTitle: TLabel
      Left = 16
      Top = 16
      Width = 156
      Height = 16
      Caption = '\u5143\u9b44/\u7cbe\u9b42\u5408\u6210\u7cfb\u7edf'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gbSoulSynthesis: TGroupBox
      Left = 16
      Top = 40
      Width = 360
      Height = 200
      Caption = '\u5143\u9b44\u5408\u6210'
      TabOrder = 0
      object lblSoulJob: TLabel
        Left = 16
        Top = 24
        Width = 48
        Height = 13
        Caption = '\u804c\u4e1a\u7c7b\u578b:'
      end
      object lblEquipments: TLabel
        Left = 16
        Top = 56
        Width = 60
        Height = 13
        Caption = '\u51dd\u7ec3\u88c5\u5907:'
      end
      object cbSoulJob: TComboBox
        Left = 80
        Top = 21
        Width = 100
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cbSoulJobChange
      end
      object lbEquipments: TListBox
        Left = 16
        Top = 80
        Width = 240
        Height = 80
        ItemHeight = 13
        TabOrder = 1
        OnClick = lbEquipmentsClick
      end
      object btnAddEquipment: TButton
        Left = 272
        Top = 80
        Width = 75
        Height = 25
        Caption = '\u6dfb\u52a0\u88c5\u5907'
        TabOrder = 2
        OnClick = btnAddEquipmentClick
      end
      object btnRemoveEquipment: TButton
        Left = 272
        Top = 112
        Width = 75
        Height = 25
        Caption = '\u79fb\u9664\u88c5\u5907'
        TabOrder = 3
        OnClick = btnRemoveEquipmentClick
      end
      object btnClearEquipments: TButton
        Left = 272
        Top = 144
        Width = 75
        Height = 25
        Caption = '\u6e05\u7a7a\u88c5\u5907'
        TabOrder = 4
        OnClick = btnClearEquipmentsClick
      end
    end
    object gbSoulUpgrade: TGroupBox
      Left = 16
      Top = 250
      Width = 360
      Height = 120
      Caption = '\u5143\u9b44\u5347\u7ea7(\u5347\u7ea7\u4e3a\u7cbe\u9b42)'
      TabOrder = 1
      object lblSelectedSoul: TLabel
        Left = 16
        Top = 24
        Width = 48
        Height = 13
        Caption = '\u9009\u4e2d\u5143\u9b44:'
      end
      object lblUpgradeEquipment: TLabel
        Left = 16
        Top = 56
        Width = 60
        Height = 13
        Caption = '\u5347\u7ea7\u88c5\u5907:'
      end
      object edtSelectedSoul: TEdit
        Left = 80
        Top = 21
        Width = 180
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
      object btnSelectSoul: TButton
        Left = 272
        Top = 19
        Width = 75
        Height = 25
        Caption = '\u9009\u62e9\u5143\u9b44'
        TabOrder = 1
        OnClick = btnSelectSoulClick
      end
      object edtUpgradeEquipment: TEdit
        Left = 80
        Top = 53
        Width = 180
        Height = 21
        ReadOnly = True
        TabOrder = 2
      end
      object btnSelectUpgradeEquipment: TButton
        Left = 272
        Top = 51
        Width = 75
        Height = 25
        Caption = '\u9009\u62e9\u88c5\u5907'
        TabOrder = 3
        OnClick = btnSelectUpgradeEquipmentClick
      end
    end
    object gbEssenceUpgrade: TGroupBox
      Left = 16
      Top = 380
      Width = 360
      Height = 160
      Caption = '\u7cbe\u9b42\u5347\u7ea7(\u6750\u6599\u5347\u7ea7)'
      TabOrder = 2
      object lblSelectedEssence: TLabel
        Left = 16
        Top = 24
        Width = 48
        Height = 13
        Caption = '\u9009\u4e2d\u7cbe\u9b42:'
      end
      object lblMaterials: TLabel
        Left = 16
        Top = 56
        Width = 60
        Height = 13
        Caption = '\u51dd\u7ec3\u6750\u6599:'
      end
      object edtSelectedEssence: TEdit
        Left = 80
        Top = 21
        Width = 180
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
      object btnSelectEssence: TButton
        Left = 272
        Top = 19
        Width = 75
        Height = 25
        Caption = '\u9009\u62e9\u7cbe\u9b42'
        TabOrder = 1
        OnClick = btnSelectEssenceClick
      end
      object lbMaterials: TListBox
        Left = 16
        Top = 80
        Width = 240
        Height = 64
        ItemHeight = 13
        TabOrder = 2
        OnClick = lbMaterialsClick
      end
      object btnAddMaterial: TButton
        Left = 272
        Top = 80
        Width = 75
        Height = 25
        Caption = '\u6dfb\u52a0\u6750\u6599'
        TabOrder = 3
        OnClick = btnAddMaterialClick
      end
      object btnRemoveMaterial: TButton
        Left = 272
        Top = 112
        Width = 75
        Height = 25
        Caption = '\u79fb\u9664\u6750\u6599'
        TabOrder = 4
        OnClick = btnRemoveMaterialClick
      end
      object btnClearMaterials: TButton
        Left = 272
        Top = 144
        Width = 75
        Height = 25
        Caption = '\u6e05\u7a7a\u6750\u6599'
        TabOrder = 5
        OnClick = btnClearMaterialsClick
      end
    end
    object gbSuccessRate: TGroupBox
      Left = 392
      Top = 40
      Width = 200
      Height = 80
      Caption = '\u6210\u529f\u7387'
      TabOrder = 3
      object lblSuccessRate: TLabel
        Left = 16
        Top = 24
        Width = 60
        Height = 13
        Caption = '\u6210\u529f\u7387: 0%'
      end
      object pbSuccessRate: TProgressBar
        Left = 16
        Top = 48
        Width = 168
        Height = 17
        Max = 100
        TabOrder = 0
      end
    end
    object btnSynthesizeSoul: TButton
      Left = 392
      Top = 136
      Width = 90
      Height = 35
      Caption = '\u5408\u6210\u5143\u9b44'
      TabOrder = 4
      OnClick = btnSynthesizeSoulClick
    end
    object btnUpgradeSoul: TButton
      Left = 392
      Top = 184
      Width = 90
      Height = 35
      Caption = '\u5347\u7ea7\u5143\u9b44'
      TabOrder = 5
      OnClick = btnUpgradeSoulClick
    end
    object btnUpgradeEssence: TButton
      Left = 392
      Top = 232
      Width = 90
      Height = 35
      Caption = '\u5347\u7ea7\u7cbe\u9b42'
      TabOrder = 6
      OnClick = btnUpgradeEssenceClick
    end
    object btnClose: TButton
      Left = 392
      Top = 280
      Width = 90
      Height = 35
      Caption = '\u5173\u95ed'
      TabOrder = 7
      OnClick = btnCloseClick
    end
    object gbAttributes: TGroupBox
      Left = 608
      Top = 40
      Width = 176
      Height = 280
      Caption = '\u5c5e\u6027\u4fe1\u606f'
      TabOrder = 8
      object lblSoulInfo: TLabel
        Left = 16
        Top = 24
        Width = 60
        Height = 13
        Caption = '\u5143\u9b44/\u7cbe\u9b42:'
      end
      object memoSoulInfo: TMemo
        Left = 16
        Top = 48
        Width = 144
        Height = 216
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object gbLog: TGroupBox
      Left = 16
      Top = 550
      Width = 768
      Height = 100
      Caption = '\u64cd\u4f5c\u65e5\u5fd7'
      TabOrder = 9
      object memoLog: TMemo
        Left = 16
        Top = 24
        Width = 736
        Height = 64
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
end
