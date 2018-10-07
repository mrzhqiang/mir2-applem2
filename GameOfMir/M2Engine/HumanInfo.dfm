object frmHumanInfo: TfrmHumanInfo
  Left = 234
  Top = 185
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20154#29289#23646#24615
  ClientHeight = 335
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 633
    Height = 241
    ActivePage = TabSheet4
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #20154#29289#20449#24687
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 13
        Width = 201
        Height = 193
        Caption = #26597#30475#20449#24687
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 19
          Width = 54
          Height = 12
          Caption = #20154#29289#21517#31216':'
        end
        object Label2: TLabel
          Left = 8
          Top = 43
          Width = 54
          Height = 12
          Caption = #25152#22312#22320#22270':'
        end
        object Label3: TLabel
          Left = 8
          Top = 67
          Width = 54
          Height = 12
          Caption = #25152#22312#24231#26631':'
        end
        object Label4: TLabel
          Left = 8
          Top = 91
          Width = 54
          Height = 12
          Caption = #30331#24405#24080#21495':'
        end
        object Label5: TLabel
          Left = 8
          Top = 115
          Width = 42
          Height = 12
          Caption = #30331#24405'IP:'
        end
        object Label6: TLabel
          Left = 8
          Top = 139
          Width = 54
          Height = 12
          Caption = #30331#24405#26102#38388':'
        end
        object Label7: TLabel
          Left = 8
          Top = 163
          Width = 54
          Height = 12
          Caption = #22312#32447#26102#38271':'
        end
        object EditName: TEdit
          Left = 64
          Top = 16
          Width = 129
          Height = 20
          ReadOnly = True
          TabOrder = 0
          Text = 'EditName'
        end
        object EditMap: TEdit
          Left = 64
          Top = 40
          Width = 129
          Height = 20
          ReadOnly = True
          TabOrder = 1
          Text = 'Edit1'
        end
        object EditXY: TEdit
          Left = 64
          Top = 64
          Width = 129
          Height = 20
          ReadOnly = True
          TabOrder = 2
          Text = 'Edit1'
        end
        object EditAccount: TEdit
          Left = 64
          Top = 88
          Width = 129
          Height = 20
          ReadOnly = True
          TabOrder = 3
          Text = 'Edit1'
        end
        object EditIPaddr: TEdit
          Left = 64
          Top = 112
          Width = 129
          Height = 20
          ReadOnly = True
          TabOrder = 4
          Text = 'Edit1'
        end
        object EditLogonTime: TEdit
          Left = 64
          Top = 136
          Width = 129
          Height = 20
          ReadOnly = True
          TabOrder = 5
          Text = 'Edit1'
        end
        object EditLogonLong: TEdit
          Left = 64
          Top = 160
          Width = 129
          Height = 20
          ReadOnly = True
          TabOrder = 6
          Text = 'Edit1'
        end
      end
      object GroupBox3: TGroupBox
        Left = 215
        Top = 13
        Width = 153
        Height = 193
        Caption = #20154#29289#23646#24615
        TabOrder = 1
        object Label11: TLabel
          Left = 8
          Top = 19
          Width = 30
          Height = 12
          Caption = #38450#24481':'
        end
        object Label13: TLabel
          Left = 8
          Top = 43
          Width = 30
          Height = 12
          Caption = #39764#38450':'
        end
        object Label14: TLabel
          Left = 8
          Top = 67
          Width = 30
          Height = 12
          Caption = #25915#20987':'
        end
        object Label15: TLabel
          Left = 8
          Top = 91
          Width = 30
          Height = 12
          Caption = #39764#27861':'
        end
        object Label16: TLabel
          Left = 8
          Top = 115
          Width = 30
          Height = 12
          Caption = #36947#26415':'
        end
        object Label17: TLabel
          Left = 8
          Top = 139
          Width = 42
          Height = 12
          Caption = #29983#21629#20540':'
        end
        object Label18: TLabel
          Left = 8
          Top = 163
          Width = 42
          Height = 12
          Caption = #39764#27861#20540':'
        end
        object EditAC: TEdit
          Left = 56
          Top = 16
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 0
          Text = 'EditName'
        end
        object EditMAC: TEdit
          Left = 56
          Top = 40
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 1
          Text = 'EditName'
        end
        object EditDC: TEdit
          Left = 56
          Top = 64
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 2
          Text = 'EditName'
        end
        object EditMC: TEdit
          Left = 56
          Top = 88
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 3
          Text = 'EditName'
        end
        object EditSC: TEdit
          Left = 56
          Top = 112
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 4
          Text = 'EditName'
        end
        object EditHP: TEdit
          Left = 56
          Top = 136
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 5
          Text = 'EditName'
        end
        object EditMP: TEdit
          Left = 56
          Top = 160
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 6
          Text = 'EditName'
        end
      end
      object GroupBox11: TGroupBox
        Left = 374
        Top = 13
        Width = 153
        Height = 193
        Caption = #20154#29289#23646#24615#28857
        TabOrder = 2
        object Label20: TLabel
          Left = 8
          Top = 19
          Width = 30
          Height = 12
          Caption = #38450#24481':'
        end
        object Label22: TLabel
          Left = 8
          Top = 43
          Width = 30
          Height = 12
          Caption = #39764#38450':'
        end
        object Label23: TLabel
          Left = 8
          Top = 67
          Width = 30
          Height = 12
          Caption = #25915#20987':'
        end
        object Label24: TLabel
          Left = 8
          Top = 91
          Width = 30
          Height = 12
          Caption = #39764#27861':'
        end
        object Label25: TLabel
          Left = 8
          Top = 115
          Width = 30
          Height = 12
          Caption = #36947#26415':'
        end
        object Label30: TLabel
          Left = 8
          Top = 139
          Width = 30
          Height = 12
          Caption = #29983#21629':'
        end
        object Label31: TLabel
          Left = 8
          Top = 163
          Width = 42
          Height = 12
          Caption = #21097#20313#28857':'
        end
        object EditNakedAC: TEdit
          Left = 56
          Top = 16
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 0
          Text = 'EditNakedAC'
        end
        object EditNakedMAC: TEdit
          Left = 56
          Top = 40
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 1
          Text = 'EditNakedMAC'
        end
        object EditNakedDC: TEdit
          Left = 56
          Top = 64
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 2
          Text = 'EditNakedDC'
        end
        object EditNakedMC: TEdit
          Left = 56
          Top = 88
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 3
          Text = 'EditNakedMC'
        end
        object EditNakedSC: TEdit
          Left = 56
          Top = 112
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 4
          Text = 'EditNakedSC'
        end
        object EditNakedHP: TEdit
          Left = 56
          Top = 136
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 5
          Text = 'EditNakedHP'
        end
        object EditNakedPoint: TEdit
          Left = 56
          Top = 160
          Width = 81
          Height = 20
          ReadOnly = True
          TabOrder = 6
          Text = 'EditNakedPoint'
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #26222#36890#25968#25454
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox2: TGroupBox
        Left = 9
        Top = 10
        Width = 160
        Height = 191
        Caption = #21487#35843#23646#24615
        TabOrder = 0
        object Label12: TLabel
          Left = 8
          Top = 18
          Width = 30
          Height = 12
          Caption = #31561#32423':'
        end
        object Label8: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = #37329#24065#25968':'
        end
        object Label9: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #32465#23450#37329#24065':'
        end
        object Label10: TLabel
          Left = 8
          Top = 114
          Width = 54
          Height = 12
          Caption = #24403#21069#32463#39564':'
        end
        object Label21: TLabel
          Left = 8
          Top = 138
          Width = 54
          Height = 12
          Caption = #21319#32423#32463#39564':'
        end
        object Label26: TLabel
          Left = 8
          Top = 90
          Width = 30
          Height = 12
          Caption = 'PK'#20540':'
        end
        object Label51: TLabel
          Left = 8
          Top = 162
          Width = 54
          Height = 12
          Caption = #20179#24211#37329#24065':'
        end
        object EditLevel: TSpinEdit
          Left = 68
          Top = 15
          Width = 85
          Height = 21
          MaxValue = 20000
          MinValue = 0
          TabOrder = 0
          Value = 10
        end
        object EditGold: TSpinEdit
          Left = 68
          Top = 39
          Width = 85
          Height = 21
          Increment = 1000
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 1
          Value = 10
        end
        object EditBindGold: TSpinEdit
          Left = 68
          Top = 63
          Width = 85
          Height = 21
          Increment = 50
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 2
          Value = 10
        end
        object EditExp: TSpinEdit
          Left = 68
          Top = 111
          Width = 85
          Height = 21
          MaxValue = 2100000000
          MinValue = 0
          TabOrder = 3
          Value = 10
        end
        object EditMaxExp: TSpinEdit
          Left = 68
          Top = 135
          Width = 85
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 2100000000
          MinValue = 0
          ReadOnly = True
          TabOrder = 4
          Value = 10
        end
        object EditPKPoint: TSpinEdit
          Left = 68
          Top = 87
          Width = 85
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 5
          Value = 10
        end
        object EditStorageGold: TSpinEdit
          Left = 68
          Top = 159
          Width = 85
          Height = 21
          Increment = 50
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 6
          Value = 10
        end
      end
      object GroupBox9: TGroupBox
        Left = 175
        Top = 10
        Width = 130
        Height = 191
        Caption = #21487#35843#23646#24615
        TabOrder = 1
        object LabelGameGold: TLabel
          Left = 8
          Top = 18
          Width = 30
          Height = 12
          Caption = #20803#23453':'
        end
        object LabelGamePoint: TLabel
          Left = 8
          Top = 42
          Width = 30
          Height = 12
          Caption = #28857#21367':'
        end
        object LabelGameDiamond: TLabel
          Left = 8
          Top = 66
          Width = 30
          Height = 12
          Caption = #31215#20998':'
        end
        object Label19: TLabel
          Left = 8
          Top = 90
          Width = 30
          Height = 12
          Caption = #22768#26395':'
        end
        object Label27: TLabel
          Left = 8
          Top = 114
          Width = 30
          Height = 12
          Caption = #20462#28860':'
        end
        object Label35: TLabel
          Left = 8
          Top = 138
          Width = 42
          Height = 12
          Caption = #25104#38271#28857':'
        end
        object EditGameGold: TSpinEdit
          Left = 55
          Top = 15
          Width = 69
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 0
          Value = 10
        end
        object EditGamePoint: TSpinEdit
          Left = 55
          Top = 39
          Width = 69
          Height = 21
          Color = clSilver
          MaxValue = 2000000000
          MinValue = 0
          ReadOnly = True
          TabOrder = 1
          Value = 10
        end
        object EditCreditPoint: TSpinEdit
          Left = 55
          Top = 87
          Width = 69
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 2
          Value = 10
        end
        object EditGameDiamond: TSpinEdit
          Left = 55
          Top = 63
          Width = 69
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 3
          Value = 10
        end
        object EditGameGird: TSpinEdit
          Left = 55
          Top = 111
          Width = 69
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 4
          Value = 10
        end
        object EditPullulation: TSpinEdit
          Left = 55
          Top = 135
          Width = 69
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 5
          Value = 10
        end
      end
      object GroupBox12: TGroupBox
        Left = 311
        Top = 10
        Width = 311
        Height = 191
        Caption = #33258#23450#20041#21464#37327
        TabOrder = 2
        object Label28: TLabel
          Left = 6
          Top = 18
          Width = 30
          Height = 12
          Caption = #25991#37319':'
        end
        object Label36: TLabel
          Left = 106
          Top = 18
          Width = 30
          Height = 12
          Caption = #25276#38230':'
        end
        object Label37: TLabel
          Left = 206
          Top = 18
          Width = 30
          Height = 12
          Caption = #21163#21290':'
        end
        object Label29: TLabel
          Left = 6
          Top = 42
          Width = 18
          Height = 12
          Caption = 'C3:'
        end
        object Label32: TLabel
          Left = 106
          Top = 42
          Width = 18
          Height = 12
          Caption = 'C4:'
        end
        object Label33: TLabel
          Left = 206
          Top = 42
          Width = 18
          Height = 12
          Caption = 'C5:'
        end
        object Label34: TLabel
          Left = 6
          Top = 66
          Width = 18
          Height = 12
          Caption = 'C6:'
        end
        object Label38: TLabel
          Left = 106
          Top = 66
          Width = 18
          Height = 12
          Caption = 'C7:'
        end
        object Label39: TLabel
          Left = 206
          Top = 66
          Width = 18
          Height = 12
          Caption = 'C8:'
        end
        object Label40: TLabel
          Left = 6
          Top = 90
          Width = 12
          Height = 12
          Caption = 'C9'
        end
        object Label41: TLabel
          Left = 106
          Top = 90
          Width = 24
          Height = 12
          Caption = 'C10:'
        end
        object Label42: TLabel
          Left = 206
          Top = 90
          Width = 24
          Height = 12
          Caption = 'C11:'
        end
        object Label43: TLabel
          Left = 6
          Top = 114
          Width = 24
          Height = 12
          Caption = 'C12:'
        end
        object Label44: TLabel
          Left = 106
          Top = 114
          Width = 24
          Height = 12
          Caption = 'C13:'
        end
        object Label45: TLabel
          Left = 206
          Top = 114
          Width = 24
          Height = 12
          Caption = 'C14:'
        end
        object Label46: TLabel
          Left = 6
          Top = 138
          Width = 24
          Height = 12
          Caption = 'C15:'
        end
        object Label47: TLabel
          Left = 106
          Top = 138
          Width = 24
          Height = 12
          Caption = 'C16:'
        end
        object Label48: TLabel
          Left = 206
          Top = 138
          Width = 24
          Height = 12
          Caption = 'C17:'
        end
        object Label49: TLabel
          Left = 6
          Top = 162
          Width = 24
          Height = 12
          Caption = 'C18:'
        end
        object Label50: TLabel
          Left = 106
          Top = 162
          Width = 24
          Height = 12
          Caption = 'C19:'
        end
        object EditC0: TSpinEdit
          Left = 38
          Top = 15
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 0
          Value = 10
        end
        object EditC1: TSpinEdit
          Left = 138
          Top = 15
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 1
          Value = 10
        end
        object EditC2: TSpinEdit
          Left = 238
          Top = 15
          Width = 65
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 2
          Value = 10
        end
        object EditC3: TSpinEdit
          Left = 38
          Top = 39
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 3
          Value = 10
        end
        object EditC4: TSpinEdit
          Left = 138
          Top = 39
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 4
          Value = 10
        end
        object EditC5: TSpinEdit
          Left = 238
          Top = 39
          Width = 65
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 5
          Value = 10
        end
        object EditC6: TSpinEdit
          Left = 38
          Top = 63
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 6
          Value = 10
        end
        object EditC7: TSpinEdit
          Left = 138
          Top = 63
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 7
          Value = 10
        end
        object EditC8: TSpinEdit
          Left = 238
          Top = 63
          Width = 65
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 8
          Value = 10
        end
        object EditC9: TSpinEdit
          Left = 38
          Top = 87
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 9
          Value = 10
        end
        object EditC10: TSpinEdit
          Left = 138
          Top = 87
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 10
          Value = 10
        end
        object EditC11: TSpinEdit
          Left = 238
          Top = 87
          Width = 65
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 11
          Value = 10
        end
        object EditC12: TSpinEdit
          Left = 38
          Top = 111
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 12
          Value = 10
        end
        object EditC13: TSpinEdit
          Left = 138
          Top = 111
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 13
          Value = 10
        end
        object EditC14: TSpinEdit
          Left = 238
          Top = 111
          Width = 65
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 14
          Value = 10
        end
        object EditC15: TSpinEdit
          Left = 38
          Top = 135
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 15
          Value = 10
        end
        object EditC16: TSpinEdit
          Left = 138
          Top = 135
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 16
          Value = 10
        end
        object EditC17: TSpinEdit
          Left = 238
          Top = 135
          Width = 65
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 17
          Value = 10
        end
        object EditC18: TSpinEdit
          Left = 38
          Top = 159
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 18
          Value = 10
        end
        object EditC19: TSpinEdit
          Left = 138
          Top = 159
          Width = 61
          Height = 21
          MaxValue = 2000000000
          MinValue = 0
          TabOrder = 19
          Value = 10
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #36523#19978#35013#22791
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox7: TGroupBox
        Left = 8
        Top = 8
        Width = 609
        Height = 201
        Caption = #35013#22791#21015#34920
        TabOrder = 0
        object GridUserItem: TStringGrid
          Left = 8
          Top = 16
          Width = 593
          Height = 177
          ColCount = 10
          DefaultColWidth = 55
          DefaultRowHeight = 18
          RowCount = 16
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          TabOrder = 0
          ColWidths = (
            55
            67
            63
            68
            45
            45
            44
            43
            46
            87)
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #32972#21253#29289#21697
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox8: TGroupBox
        Left = 8
        Top = 8
        Width = 609
        Height = 201
        Caption = #35013#22791#21015#34920
        TabOrder = 0
        object GridBagItem: TStringGrid
          Left = 8
          Top = 16
          Width = 593
          Height = 177
          ColCount = 10
          DefaultColWidth = 55
          DefaultRowHeight = 18
          RowCount = 14
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          TabOrder = 0
          ColWidths = (
            55
            67
            63
            68
            45
            45
            44
            43
            46
            88)
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = #20179#24211#29289#21697
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox10: TGroupBox
        Left = 8
        Top = 8
        Width = 609
        Height = 201
        Caption = #35013#22791#21015#34920
        TabOrder = 0
        object GridStorageItem: TStringGrid
          Left = 8
          Top = 16
          Width = 593
          Height = 177
          ColCount = 10
          DefaultColWidth = 55
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 14
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          TabOrder = 0
          ColWidths = (
            55
            67
            63
            67
            45
            45
            44
            43
            46
            89)
        end
      end
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 255
    Width = 89
    Height = 73
    Caption = #25511#21046
    TabOrder = 1
    object CheckBoxMonitor: TCheckBox
      Left = 8
      Top = 16
      Width = 67
      Height = 17
      Caption = #23454#26102#30417#25511
      TabOrder = 0
      OnClick = CheckBoxMonitorClick
    end
    object ButtonKick: TButton
      Left = 8
      Top = 40
      Width = 65
      Height = 25
      Caption = #36386#19979#32447
      TabOrder = 1
      OnClick = ButtonKickClick
    end
  end
  object GroupBox5: TGroupBox
    Left = 103
    Top = 255
    Width = 81
    Height = 73
    Caption = #24403#21069#29366#24577
    TabOrder = 2
    object EditHumanStatus: TEdit
      Left = 8
      Top = 24
      Width = 65
      Height = 20
      ReadOnly = True
      TabOrder = 0
    end
  end
  object ButtonSave: TButton
    Left = 286
    Top = 302
    Width = 65
    Height = 25
    Caption = #20462#25913#25968#25454
    TabOrder = 3
    OnClick = ButtonSaveClick
  end
  object GroupBox6: TGroupBox
    Left = 190
    Top = 255
    Width = 90
    Height = 73
    Caption = #20154#29289#29366#24577
    TabOrder = 4
    object CheckBoxGameMaster: TCheckBox
      Left = 8
      Top = 16
      Width = 73
      Height = 17
      Caption = 'GM'#27169#24335
      TabOrder = 0
    end
    object CheckBoxSuperMan: TCheckBox
      Left = 8
      Top = 32
      Width = 73
      Height = 17
      Caption = #26080#25932#27169#24335
      TabOrder = 1
    end
    object CheckBoxObserver: TCheckBox
      Left = 8
      Top = 48
      Width = 73
      Height = 17
      Caption = #38544#36523#27169#24335
      TabOrder = 2
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 288
    Top = 264
  end
end
