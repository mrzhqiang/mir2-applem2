object frmEditRcd: TfrmEditRcd
  Left = 407
  Top = 294
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #32534#36753#20154#29289#25968#25454
  ClientHeight = 370
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl: TPageControl
    Left = 10
    Top = 9
    Width = 631
    Height = 323
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22522#26412
      object GroupBox1: TGroupBox
        Left = 11
        Top = 3
        Width = 609
        Height = 284
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = #20154#29289#21517#31216':'
        end
        object Label2: TLabel
          Left = 8
          Top = 68
          Width = 54
          Height = 12
          Caption = #30331#24405#24080#21495':'
        end
        object Label3: TLabel
          Left = 424
          Top = 68
          Width = 54
          Height = 12
          Caption = #20179#24211#23494#30721':'
        end
        object Label11: TLabel
          Left = 8
          Top = 20
          Width = 54
          Height = 12
          Caption = #32034#24341#21495#30721':'
        end
        object Label12: TLabel
          Left = 8
          Top = 92
          Width = 54
          Height = 12
          Caption = #24403#21069#22320#22270':'
        end
        object Label13: TLabel
          Left = 8
          Top = 116
          Width = 54
          Height = 12
          Caption = #24403#21069#24231#26631':'
        end
        object Label14: TLabel
          Left = 8
          Top = 140
          Width = 54
          Height = 12
          Caption = #22238#22478#22320#22270':'
        end
        object Label15: TLabel
          Left = 8
          Top = 164
          Width = 54
          Height = 12
          Caption = #22238#22478#24231#26631':'
        end
        object Label6: TLabel
          Left = 232
          Top = 20
          Width = 30
          Height = 12
          Caption = #31561#32423':'
        end
        object Label7: TLabel
          Left = 232
          Top = 92
          Width = 30
          Height = 12
          Caption = #37329#24065':'
        end
        object Label8: TLabel
          Left = 232
          Top = 116
          Width = 30
          Height = 12
          Caption = #20803#23453':'
        end
        object Label9: TLabel
          Left = 232
          Top = 140
          Width = 30
          Height = 12
          Caption = #28857#21367':'
        end
        object Label16: TLabel
          Left = 232
          Top = 213
          Width = 42
          Height = 12
          Caption = #22768#26395#28857':'
        end
        object Label17: TLabel
          Left = 232
          Top = 262
          Width = 30
          Height = 12
          Caption = 'PK'#20540':'
        end
        object Label18: TLabel
          Left = 232
          Top = 238
          Width = 42
          Height = 12
          Caption = #25104#38271#28857':'
        end
        object Label20: TLabel
          Left = 424
          Top = 44
          Width = 54
          Height = 12
          Caption = #32463#39564#26102#38388':'
        end
        object Label19: TLabel
          Left = 424
          Top = 20
          Width = 54
          Height = 12
          Caption = #32463#39564#20493#29575':'
        end
        object Label33: TLabel
          Left = 8
          Top = 189
          Width = 54
          Height = 12
          Caption = #27515#20129#22320#22270':'
        end
        object Label34: TLabel
          Left = 8
          Top = 213
          Width = 54
          Height = 12
          Caption = #27515#20129#24231#26631':'
        end
        object Label35: TLabel
          Left = 232
          Top = 165
          Width = 30
          Height = 12
          Caption = #31215#20998':'
        end
        object Label36: TLabel
          Left = 232
          Top = 189
          Width = 30
          Height = 12
          Caption = #20462#28860':'
        end
        object Label37: TLabel
          Left = 232
          Top = 44
          Width = 42
          Height = 12
          Caption = #32463#39564#20540':'
        end
        object Label38: TLabel
          Left = 232
          Top = 68
          Width = 54
          Height = 12
          Caption = #21319#32423#39564#20540':'
        end
        object Label5: TLabel
          Left = 8
          Top = 238
          Width = 54
          Height = 12
          Caption = #21019#24314#26102#38388':'
        end
        object Label32: TLabel
          Left = 8
          Top = 262
          Width = 54
          Height = 12
          Caption = #30331#24405#26102#38388':'
        end
        object Label10: TLabel
          Left = 424
          Top = 92
          Width = 54
          Height = 12
          Caption = #32465#23450#37329#24065':'
        end
        object Label21: TLabel
          Left = 424
          Top = 116
          Width = 54
          Height = 12
          Caption = #20179#24211#37329#24065':'
        end
        object EditChrName: TEdit
          Left = 64
          Top = 40
          Width = 97
          Height = 20
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 0
        end
        object EditAccount: TEdit
          Left = 64
          Top = 64
          Width = 97
          Height = 20
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 1
        end
        object EditPassword: TEdit
          Left = 480
          Top = 64
          Width = 97
          Height = 20
          MaxLength = 12
          TabOrder = 2
          OnChange = EditPasswordChange
        end
        object EditIdx: TEdit
          Left = 64
          Top = 16
          Width = 45
          Height = 20
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 3
        end
        object EditCurMap: TEdit
          Left = 64
          Top = 88
          Width = 97
          Height = 20
          TabOrder = 4
          OnChange = EditPasswordChange
        end
        object EditCurX: TSpinEdit
          Left = 64
          Top = 112
          Width = 49
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditCurY: TSpinEdit
          Left = 112
          Top = 112
          Width = 49
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditHomeMap: TEdit
          Left = 64
          Top = 136
          Width = 97
          Height = 20
          TabOrder = 7
          OnChange = EditPasswordChange
        end
        object EditHomeX: TSpinEdit
          Left = 64
          Top = 160
          Width = 49
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditHomeY: TSpinEdit
          Left = 112
          Top = 160
          Width = 49
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 9
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditLevel: TSpinEdit
          Left = 288
          Top = 16
          Width = 97
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 10
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditGold: TSpinEdit
          Left = 288
          Top = 88
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 11
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditGameGold: TSpinEdit
          Left = 288
          Top = 112
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 12
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditGamePoint: TSpinEdit
          Left = 288
          Top = 136
          Width = 97
          Height = 21
          Color = cl3DLight
          MaxValue = 0
          MinValue = 0
          ReadOnly = True
          TabOrder = 13
          Value = 0
        end
        object EditCreditPoint: TSpinEdit
          Left = 288
          Top = 209
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 14
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditPKPoint: TSpinEdit
          Left = 288
          Top = 258
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 15
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditPullulation: TSpinEdit
          Left = 288
          Top = 234
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 16
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditExpRate: TSpinEdit
          Left = 480
          Top = 16
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 17
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditExpTime: TSpinEdit
          Left = 480
          Top = 40
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 18
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditDieMap: TEdit
          Left = 64
          Top = 185
          Width = 97
          Height = 20
          TabOrder = 19
          OnChange = EditPasswordChange
        end
        object EditDieX: TSpinEdit
          Left = 64
          Top = 209
          Width = 49
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 20
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditDieY: TSpinEdit
          Left = 112
          Top = 209
          Width = 49
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 21
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditGameDiamond: TSpinEdit
          Left = 288
          Top = 161
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 22
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditGameGird: TSpinEdit
          Left = 288
          Top = 185
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 23
          Value = 0
          OnChange = EditPasswordChange
        end
        object CheckBoxChangeName: TCheckBox
          Left = 167
          Top = 42
          Width = 57
          Height = 17
          Caption = #26356#21517
          TabOrder = 24
          OnClick = EditPasswordChange
        end
        object EditExp: TSpinEdit
          Left = 288
          Top = 40
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 25
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditMaxExp: TSpinEdit
          Left = 288
          Top = 64
          Width = 97
          Height = 21
          Color = cl3DLight
          MaxValue = 0
          MinValue = 0
          ReadOnly = True
          TabOrder = 26
          Value = 0
        end
        object EditDBIdx: TEdit
          Left = 115
          Top = 16
          Width = 46
          Height = 20
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 27
        end
        object EditCreateTime: TEdit
          Left = 64
          Top = 234
          Width = 153
          Height = 20
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 28
          OnChange = EditPasswordChange
        end
        object EditLoginTime: TEdit
          Left = 64
          Top = 258
          Width = 153
          Height = 20
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 29
          OnChange = EditPasswordChange
        end
        object EditBindGold: TSpinEdit
          Left = 480
          Top = 88
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 30
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditStorageGold: TSpinEdit
          Left = 480
          Top = 112
          Width = 97
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 31
          Value = 0
          OnChange = EditPasswordChange
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25968#25454
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 7
        Top = 6
        Width = 609
        Height = 284
        TabOrder = 0
        object GroupBox12: TGroupBox
          Left = 173
          Top = 13
          Width = 311
          Height = 191
          Caption = #33258#23450#20041#21464#37327
          TabOrder = 0
          object Label46: TLabel
            Left = 6
            Top = 18
            Width = 30
            Height = 12
            Caption = #25991#37319':'
          end
          object Label47: TLabel
            Left = 106
            Top = 18
            Width = 30
            Height = 12
            Caption = #25276#38230':'
          end
          object Label48: TLabel
            Left = 206
            Top = 18
            Width = 30
            Height = 12
            Caption = #21163#21290':'
          end
          object Label49: TLabel
            Left = 6
            Top = 42
            Width = 18
            Height = 12
            Caption = 'C3:'
          end
          object Label50: TLabel
            Left = 106
            Top = 42
            Width = 18
            Height = 12
            Caption = 'C4:'
          end
          object Label51: TLabel
            Left = 206
            Top = 42
            Width = 18
            Height = 12
            Caption = 'C5:'
          end
          object Label52: TLabel
            Left = 6
            Top = 66
            Width = 18
            Height = 12
            Caption = 'C6:'
          end
          object Label53: TLabel
            Left = 106
            Top = 66
            Width = 18
            Height = 12
            Caption = 'C7:'
          end
          object Label54: TLabel
            Left = 206
            Top = 66
            Width = 18
            Height = 12
            Caption = 'C8:'
          end
          object Label55: TLabel
            Left = 6
            Top = 90
            Width = 12
            Height = 12
            Caption = 'C9'
          end
          object Label56: TLabel
            Left = 106
            Top = 90
            Width = 24
            Height = 12
            Caption = 'C10:'
          end
          object Label57: TLabel
            Left = 206
            Top = 90
            Width = 24
            Height = 12
            Caption = 'C11:'
          end
          object Label58: TLabel
            Left = 6
            Top = 114
            Width = 24
            Height = 12
            Caption = 'C12:'
          end
          object Label59: TLabel
            Left = 106
            Top = 114
            Width = 24
            Height = 12
            Caption = 'C13:'
          end
          object Label60: TLabel
            Left = 206
            Top = 114
            Width = 24
            Height = 12
            Caption = 'C14:'
          end
          object Label61: TLabel
            Left = 6
            Top = 138
            Width = 24
            Height = 12
            Caption = 'C15:'
          end
          object Label62: TLabel
            Left = 106
            Top = 138
            Width = 24
            Height = 12
            Caption = 'C16:'
          end
          object Label63: TLabel
            Left = 206
            Top = 138
            Width = 24
            Height = 12
            Caption = 'C17:'
          end
          object Label64: TLabel
            Left = 6
            Top = 162
            Width = 24
            Height = 12
            Caption = 'C18:'
          end
          object Label65: TLabel
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
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
            OnChange = EditPasswordChange
          end
        end
        object GroupBox11: TGroupBox
          Left = 14
          Top = 13
          Width = 153
          Height = 193
          Caption = #20154#29289#23646#24615#28857
          TabOrder = 1
          object Label66: TLabel
            Left = 8
            Top = 19
            Width = 30
            Height = 12
            Caption = #38450#24481':'
          end
          object Label67: TLabel
            Left = 8
            Top = 43
            Width = 30
            Height = 12
            Caption = #39764#38450':'
          end
          object Label68: TLabel
            Left = 8
            Top = 67
            Width = 30
            Height = 12
            Caption = #25915#20987':'
          end
          object Label69: TLabel
            Left = 8
            Top = 91
            Width = 30
            Height = 12
            Caption = #39764#27861':'
          end
          object Label70: TLabel
            Left = 8
            Top = 115
            Width = 30
            Height = 12
            Caption = #36947#26415':'
          end
          object Label71: TLabel
            Left = 8
            Top = 139
            Width = 30
            Height = 12
            Caption = #29983#21629':'
          end
          object Label72: TLabel
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
    end
    object TabSheet6: TTabSheet
      Caption = #20132#38469
      ImageIndex = 5
      object GroupBox7: TGroupBox
        Left = 11
        Top = 11
        Width = 190
        Height = 46
        Caption = #22827#22971#20851#31995
        TabOrder = 0
        object Label4: TLabel
          Left = 12
          Top = 21
          Width = 54
          Height = 12
          Caption = #37197#20598#21517#31216':'
        end
        object EditDearName: TEdit
          Left = 72
          Top = 18
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 0
          OnChange = EditPasswordChange
        end
      end
      object GroupBox8: TGroupBox
        Left = 11
        Top = 63
        Width = 190
        Height = 225
        Caption = #24072#24466#20851#31995
        TabOrder = 1
        object Label39: TLabel
          Left = 12
          Top = 42
          Width = 54
          Height = 12
          Caption = #24072#29238#21517#31216':'
        end
        object Label40: TLabel
          Left = 12
          Top = 68
          Width = 42
          Height = 12
          Caption = #24466#24351#20108':'
        end
        object Label41: TLabel
          Left = 12
          Top = 94
          Width = 36
          Height = 12
          Caption = #24466#24351#20108
        end
        object Label42: TLabel
          Left = 12
          Top = 120
          Width = 42
          Height = 12
          Caption = #24466#24351#22235':'
        end
        object Label43: TLabel
          Left = 12
          Top = 146
          Width = 42
          Height = 12
          Caption = #24466#24351#20116':'
        end
        object Label44: TLabel
          Left = 12
          Top = 172
          Width = 42
          Height = 12
          Caption = #24466#24351#20845':'
        end
        object Label45: TLabel
          Left = 12
          Top = 198
          Width = 42
          Height = 12
          Caption = #24466#24351#19971':'
        end
        object EditMasterName1: TEdit
          Left = 72
          Top = 39
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 0
          OnChange = EditPasswordChange
        end
        object CheckBoxIsMaster: TCheckBox
          Left = 72
          Top = 16
          Width = 81
          Height = 17
          Caption = #26159#21542#20026#24072#29238
          TabOrder = 1
          OnClick = EditPasswordChange
        end
        object EditMasterName2: TEdit
          Left = 72
          Top = 65
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 2
          OnChange = EditPasswordChange
        end
        object EditMasterName3: TEdit
          Left = 72
          Top = 91
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 3
          OnChange = EditPasswordChange
        end
        object EditMasterName4: TEdit
          Left = 72
          Top = 117
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 4
          OnChange = EditPasswordChange
        end
        object EditMasterName5: TEdit
          Left = 72
          Top = 143
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 5
          OnChange = EditPasswordChange
        end
        object EditMasterName6: TEdit
          Left = 72
          Top = 169
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 6
          OnChange = EditPasswordChange
        end
        object EditMasterName7: TEdit
          Left = 72
          Top = 195
          Width = 97
          Height = 20
          MaxLength = 14
          TabOrder = 7
          OnChange = EditPasswordChange
        end
      end
      object GroupBox9: TGroupBox
        Left = 207
        Top = 11
        Width = 154
        Height = 277
        Caption = #22909#21451#20851#31995
        TabOrder = 2
        object ListBoxFirend: TListBox
          Left = 7
          Top = 18
          Width = 138
          Height = 249
          ItemHeight = 12
          TabOrder = 0
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #25216#33021
      ImageIndex = 2
      object GroupBox3: TGroupBox
        Left = 7
        Top = 6
        Width = 433
        Height = 284
        Caption = #26222#36890#25216#33021
        TabOrder = 0
        object ListViewMagic: TListView
          Left = 8
          Top = 16
          Width = 417
          Height = 257
          Columns = <
            item
              Caption = #25216#33021'ID'
              Width = 60
            end
            item
              Caption = #25216#33021#21517#31216
              Width = 120
            end
            item
              Caption = #31561#32423
              Width = 60
            end
            item
              Caption = #20462#28860#28857
              Width = 90
            end>
          GridLines = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
      object GroupBox6: TGroupBox
        Left = 446
        Top = 6
        Width = 170
        Height = 284
        Caption = #29983#27963#25216#33021
        TabOrder = 1
        object Label22: TLabel
          Left = 10
          Top = 255
          Width = 66
          Height = 12
          Caption = #21097#20313#25216#33021#28857':'
        end
        object ListViewMakeMagic: TListView
          Left = 8
          Top = 16
          Width = 153
          Height = 226
          Columns = <
            item
              Caption = #25216#33021#21517#31216
              Width = 100
            end
            item
              Caption = #31561#32423
              Width = 40
            end>
          GridLines = True
          Items.ItemData = {
            01AE0100000A00000000000000FFFFFFFFFFFFFFFF0100000000000000045362
            2090666B685601300000000000FFFFFFFFFFFFFFFF0100000000000000045362
            2090D476327501300000000000FFFFFFFFFFFFFFFF0100000000000000045362
            20903459D47601300000000000FFFFFFFFFFFFFFFF0100000000000000045362
            20907998FE9401300000000000FFFFFFFFFFFFFFFF0100000000000000045362
            20904B626F9501300000000000FFFFFFFFFFFFFFFF0100000000000000045362
            20901262076301300000000000FFFFFFFFFFFFFFFF0100000000000000045362
            20907081265E01300000000000FFFFFFFFFFFFFFFF0100000000000000045362
            20907497505B01300000000000FFFFFFFFFFFFFFFF0100000000000000045362
            20906F83C15401300000000000FFFFFFFFFFFFFFFF0100000000000000045362
            209050679965013000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
        object EditMakeMagic: TSpinEdit
          Left = 82
          Top = 252
          Width = 79
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = EditPasswordChange
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #35013#22791
      ImageIndex = 3
      object GroupBox4: TGroupBox
        Left = 7
        Top = 6
        Width = 609
        Height = 284
        TabOrder = 0
        object ListViewUserItem: TListView
          Left = 8
          Top = 16
          Width = 591
          Height = 257
          Columns = <
            item
              Caption = #20301#32622
              Width = 60
            end
            item
              Caption = #26631#35782#24207#21495
              Width = 75
            end
            item
              Caption = #29289#21697#21517#31216
              Width = 90
            end
            item
              Alignment = taCenter
              Caption = #25345#20037
              Width = 85
            end
            item
              Caption = #21442#25968
              Width = 260
            end>
          GridLines = True
          Items.ItemData = {
            01020300000F00000000000000FFFFFFFFFFFFFFFF0400000000000000026388
            0D6701300001300001300001300000000000FFFFFFFFFFFFFFFF040000000000
            000002666B685601300001300001300001300000000000FFFFFFFFFFFFFFFF04
            00000000000000023459D47601300001300001300001300000000000FFFFFFFF
            FFFFFFFF0400000000000000027998FE94013000013000013000013000000000
            00FFFFFFFFFFFFFFFF04000000000000000367710E6669720130000130000130
            0001300000000000FFFFFFFFFFFFFFFF040000000000000003E65D4B626F9501
            300001300001300001300000000000FFFFFFFFFFFFFFFF040000000000000003
            F3534B626F9501300001300001300001300000000000FFFFFFFFFFFFFFFF0400
            00000000000003E65D1262076301300001300001300001300000000000FFFFFF
            FFFFFFFFFF040000000000000003F35312620763013000013000013000013000
            00000000FFFFFFFFFFFFFFFF040000000000000002267BD26B01300001300001
            300001300000000000FFFFFFFFFFFFFFFF0400000000000000027081265E0130
            0001300001300001300000000000FFFFFFFFFFFFFFFF0400000000000000028B
            97505B01300001300001300001300000000000FFFFFFFFFFFFFFFF0400000000
            000000029D5BF37701300001300001300001300000000000FFFFFFFFFFFFFFFF
            0400000000000000026C9A4C7201300001300001300001300000000000FFFFFF
            FFFFFFFFFF04000000000000000253907751013000013000013000013000FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = #32972#21253
      ImageIndex = 6
      object GroupBox10: TGroupBox
        Left = 7
        Top = 6
        Width = 609
        Height = 284
        TabOrder = 0
        object ListViewBagItem: TListView
          Left = 8
          Top = 16
          Width = 591
          Height = 257
          Columns = <
            item
              Caption = #24207#21495
              Width = 40
            end
            item
              Caption = #26631#35782#24207#21495
              Width = 80
            end
            item
              Caption = #29289#21697#21517#31216
              Width = 90
            end
            item
              Alignment = taCenter
              Caption = #25345#20037
              Width = 90
            end
            item
              Caption = #21442#25968
              Width = 270
            end>
          GridLines = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #20179#24211
      ImageIndex = 4
      object GroupBox5: TGroupBox
        Left = 7
        Top = 6
        Width = 609
        Height = 284
        TabOrder = 0
        object ListViewStorage: TListView
          Left = 8
          Top = 16
          Width = 591
          Height = 257
          Columns = <
            item
              Caption = #24207#21495
              Width = 40
            end
            item
              Caption = #26631#35782#24207#21495
              Width = 80
            end
            item
              Caption = #29289#21697#21517#31216
              Width = 90
            end
            item
              Alignment = taCenter
              Caption = #25345#20037
              Width = 90
            end
            item
              Caption = #21442#25968
              Width = 270
            end>
          GridLines = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
  end
  object ButtonSaveData: TButton
    Left = 560
    Top = 338
    Width = 81
    Height = 25
    Caption = #20445#23384#20462#25913'(&S)'
    TabOrder = 1
    OnClick = ButtonExportDataClick
  end
  object ButtonExportData: TButton
    Left = 386
    Top = 338
    Width = 81
    Height = 25
    Caption = #23548#20986#25968#25454'(&E)'
    TabOrder = 2
    OnClick = ButtonExportDataClick
  end
  object ButtonImportData: TButton
    Left = 473
    Top = 338
    Width = 81
    Height = 25
    Caption = #23548#20837#25968#25454'(&I)'
    TabOrder = 3
    OnClick = ButtonExportDataClick
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'hum'
    Filter = #20154#29289#25968#25454' (*.hum)|*.hum'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 192
    Top = 336
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'hum'
    Filter = #20154#29289#25968#25454' (*.hum)|*.hum'
    Left = 232
    Top = 336
  end
end
