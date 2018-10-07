object frmFunctionConfig: TfrmFunctionConfig
  Left = 269
  Top = 149
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #21151#33021#35774#32622
  ClientHeight = 378
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label14: TLabel
    Left = 8
    Top = 359
    Width = 432
    Height = 12
    Caption = #35843#25972#30340#21442#25968#31435#21363#29983#25928#65292#22312#32447#26102#35831#30830#35748#27492#21442#25968#30340#20316#29992#20877#35843#25972#65292#20081#35843#25972#23558#23548#33268#28216#25103#28151#20081
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object FunctionConfigControl: TPageControl
    Left = 6
    Top = 8
    Width = 457
    Height = 345
    ActivePage = TabSheet23
    MultiLine = True
    TabOrder = 0
    OnChanging = FunctionConfigControlChanging
    object TabSheetGeneral: TTabSheet
      Caption = #22522#26412#21151#33021
      ImageIndex = 3
      object ButtonGeneralSave: TButton
        Left = 368
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = ButtonGeneralSaveClick
      end
      object GroupBox34: TGroupBox
        Left = 8
        Top = 8
        Width = 137
        Height = 163
        Caption = #21517#23383#26174#31034#39068#33394
        TabOrder = 1
        object Label85: TLabel
          Left = 11
          Top = 22
          Width = 54
          Height = 12
          Caption = #25915#20987#29366#24577':'
        end
        object LabelPKFlagNameColor: TLabel
          Left = 112
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label87: TLabel
          Left = 11
          Top = 46
          Width = 54
          Height = 12
          Caption = #40644#21517#29366#24577':'
        end
        object LabelPKLevel1NameColor: TLabel
          Left = 112
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label89: TLabel
          Left = 11
          Top = 70
          Width = 54
          Height = 12
          Caption = #32418#21517#29366#24577':'
        end
        object LabelPKLevel2NameColor: TLabel
          Left = 112
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label91: TLabel
          Left = 11
          Top = 94
          Width = 54
          Height = 12
          Caption = #32852#30431#25112#20105':'
        end
        object LabelAllyAndGuildNameColor: TLabel
          Left = 112
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label93: TLabel
          Left = 11
          Top = 118
          Width = 54
          Height = 12
          Caption = #25932#23545#25112#20105':'
        end
        object LabelWarGuildNameColor: TLabel
          Left = 112
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label95: TLabel
          Left = 11
          Top = 142
          Width = 54
          Height = 12
          Caption = #25112#20105#21306#22495':'
        end
        object LabelInFreePKAreaNameColor: TLabel
          Left = 112
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditPKFlagNameColor: TSpinEdit
          Left = 64
          Top = 18
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#25915#20987#20854#20182#20154#29289#26102#21517#23383#39068#33394#65292#40664#35748#20026'47'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditPKFlagNameColorChange
        end
        object EditPKLevel1NameColor: TSpinEdit
          Left = 64
          Top = 42
          Width = 41
          Height = 21
          Hint = #24403#20154#29289'PK'#28857#36229#36807'100'#28857#26102#21517#23383#39068#33394#65292#40664#35748#20026'251'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditPKLevel1NameColorChange
        end
        object EditPKLevel2NameColor: TSpinEdit
          Left = 64
          Top = 66
          Width = 41
          Height = 21
          Hint = #24403#20154#29289'PK'#28857#36229#36807'200'#28857#26102#21517#23383#39068#33394#65292#40664#35748#20026'249'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditPKLevel2NameColorChange
        end
        object EditAllyAndGuildNameColor: TSpinEdit
          Left = 64
          Top = 90
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#26102#65292#26412#34892#20250#21450#32852#30431#34892#20250#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'180'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditAllyAndGuildNameColorChange
        end
        object EditWarGuildNameColor: TSpinEdit
          Left = 64
          Top = 114
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#26102#65292#25932#23545#34892#20250#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'69'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditWarGuildNameColorChange
        end
        object EditInFreePKAreaNameColor: TSpinEdit
          Left = 64
          Top = 138
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#21306#22495#26102#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'221'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditInFreePKAreaNameColorChange
        end
      end
      object GroupBox62: TGroupBox
        Left = 156
        Top = 183
        Width = 198
        Height = 106
        Caption = #22320#22270#20107#20214#35302#21457
        TabOrder = 2
        object chkStartDropItemMapEvent: TCheckBox
          Left = 9
          Top = 16
          Width = 160
          Height = 17
          Caption = #24320#21551#25172#29289#21697#22320#22270#20107#20214#35302#21457
          TabOrder = 0
          OnClick = chkStartDropItemMapEventClick
        end
        object chkStartPickUpItemMapEvent: TCheckBox
          Left = 9
          Top = 33
          Width = 152
          Height = 17
          Caption = #24320#21551#25441#29289#21697#22320#22270#20107#20214#35302#21457
          TabOrder = 1
          OnClick = chkStartPickUpItemMapEventClick
        end
        object chkStartHeavyHitMapEvent: TCheckBox
          Left = 9
          Top = 50
          Width = 152
          Height = 17
          Caption = #24320#21551#25366#30719#22320#22270#20107#20214#35302#21457
          TabOrder = 2
          OnClick = chkStartHeavyHitMapEventClick
        end
        object chkStartWalkMapEvent: TCheckBox
          Left = 9
          Top = 67
          Width = 144
          Height = 17
          Caption = #24320#21551#36208#36335#22320#22270#20107#20214#35302#21457
          TabOrder = 3
          OnClick = chkStartWalkMapEventClick
        end
        object chkStartRunMapEvent: TCheckBox
          Left = 9
          Top = 84
          Width = 144
          Height = 17
          Caption = #24320#21551#36305#27493#22320#22270#20107#20214#35302#21457
          TabOrder = 4
          OnClick = chkStartRunMapEventClick
        end
      end
      object GroupBox7: TGroupBox
        Left = 156
        Top = 8
        Width = 285
        Height = 163
        Caption = #27668#34880#30707'/'#39764#34880#30707#35774#32622
        TabOrder = 3
        object Label147: TLabel
          Left = 9
          Top = 22
          Width = 30
          Height = 12
          Caption = #24403'HP<'
        end
        object Label148: TLabel
          Left = 89
          Top = 22
          Width = 108
          Height = 12
          Caption = '% '#24320#21551#27668#34880#30707','#38388#38548':'
        end
        object Label149: TLabel
          Left = 239
          Top = 22
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label150: TLabel
          Left = 9
          Top = 46
          Width = 132
          Height = 12
          Caption = #22686#21152'HP'#20026#27668#34880#30707#24635#25345#20037#30340
        end
        object Label151: TLabel
          Left = 203
          Top = 46
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label152: TLabel
          Left = 9
          Top = 94
          Width = 30
          Height = 12
          Caption = #24403'MP<'
        end
        object Label153: TLabel
          Left = 89
          Top = 94
          Width = 108
          Height = 12
          Caption = '% '#24320#21551#39764#34880#30707','#38388#38548':'
        end
        object Label154: TLabel
          Left = 239
          Top = 94
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label155: TLabel
          Left = 207
          Top = 118
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label156: TLabel
          Left = 9
          Top = 118
          Width = 132
          Height = 12
          Caption = #22686#21152'MP'#20026#39764#34880#30707#24635#25345#20037#30340
        end
        object Label157: TLabel
          Left = 207
          Top = 70
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label158: TLabel
          Left = 9
          Top = 70
          Width = 132
          Height = 12
          Caption = #27599#27425#27668#34880#30707#20943#23569#30340#25345#20037#20540
        end
        object Label159: TLabel
          Left = 9
          Top = 142
          Width = 132
          Height = 12
          Caption = #27599#27425#39764#34880#30707#20943#23569#30340#25345#20037#20540
        end
        object Label160: TLabel
          Left = 207
          Top = 142
          Width = 12
          Height = 12
          Caption = #28857
        end
        object SpinEditHPStoneStartRate: TSpinEdit
          Left = 43
          Top = 18
          Width = 43
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = SpinEditHPStoneStartRateChange
        end
        object SpinEditHPStoneIntervalTime: TSpinEdit
          Left = 197
          Top = 18
          Width = 39
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 1
          Value = 1
          OnChange = SpinEditHPStoneIntervalTimeChange
        end
        object SpinEditHPStoneAddRate: TSpinEdit
          Left = 146
          Top = 42
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = SpinEditHPStoneAddRateChange
        end
        object SpinEditMPStoneStartRate: TSpinEdit
          Left = 43
          Top = 90
          Width = 43
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = SpinEditMPStoneStartRateChange
        end
        object SpinEditMPStoneIntervalTime: TSpinEdit
          Left = 197
          Top = 90
          Width = 39
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 5
          Value = 1
          OnChange = SpinEditMPStoneIntervalTimeChange
        end
        object SpinEditMPStoneAddRate: TSpinEdit
          Left = 146
          Top = 114
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = SpinEditMPStoneAddRateChange
        end
        object SpinEditHPStoneDecDura: TSpinEdit
          Left = 146
          Top = 66
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 3
          Value = 1000
          OnChange = SpinEditHPStoneDecDuraChange
        end
        object SpinEditMPStoneDecDura: TSpinEdit
          Left = 146
          Top = 138
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 7
          Value = 1000
          OnChange = SpinEditMPStoneDecDuraChange
        end
      end
      object grp1: TGroupBox
        Left = 8
        Top = 183
        Width = 137
        Height = 50
        Caption = #20854#23427#36873#39033
        TabOrder = 4
        object chkMonSayMsg: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #24320#21551#24618#29289#35828#35805
          TabOrder = 0
          OnClick = chkMonSayMsgClick
        end
        object chkCheckGuild: TCheckBox
          Left = 8
          Top = 40
          Width = 120
          Height = 17
          Caption = 'CheckGuild'
          TabOrder = 1
          Visible = False
          OnClick = chkCheckGuildClick
        end
      end
      object GroupBox55: TGroupBox
        Left = 8
        Top = 239
        Width = 137
        Height = 50
        Caption = #33258#28982#25104#38271#28857
        TabOrder = 5
        object Label140: TLabel
          Left = 11
          Top = 22
          Width = 60
          Height = 12
          Caption = #27599#20998#38047#22686#21152
        end
        object EditPullulation: TSpinEdit
          Left = 77
          Top = 19
          Width = 52
          Height = 21
          Hint = #35774#32622#33258#28982#25104#38271#28857#27599#20998#38047#22686#21152#30340#25968#37327#12290'1'#28857#33258#28982#25104#38271#28857'=60'#12290#40664#35748#35774#32622' 10'
          MaxValue = 100000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditPullulationChange
        end
      end
    end
    object TabSheet33: TTabSheet
      Caption = #24072#24466#31995#32479
      ImageIndex = 5
      object GroupBox21: TGroupBox
        Left = 8
        Top = 8
        Width = 161
        Height = 153
        Caption = #24466#24351#20986#24072
        TabOrder = 0
        object GroupBox22: TGroupBox
          Left = 8
          Top = 16
          Width = 145
          Height = 49
          Caption = #20986#24072#31561#32423
          TabOrder = 0
          object Label29: TLabel
            Left = 8
            Top = 18
            Width = 54
            Height = 12
            Caption = #20986#24072#31561#32423':'
          end
          object EditMasterOKLevel: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = #20986#24072#31561#32423#35774#32622#65292#20154#29289#22312#25308#24072#21518#65292#21040#25351#23450#31561#32423#21518#23558#33258#21160#20986#24072#12290
            MaxValue = 65535
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKLevelChange
          end
        end
        object GroupBox23: TGroupBox
          Left = 8
          Top = 72
          Width = 145
          Height = 73
          Caption = #24072#29238#25152#24471
          TabOrder = 1
          object Label30: TLabel
            Left = 8
            Top = 18
            Width = 54
            Height = 12
            Caption = #22768#26395#28857#25968':'
          end
          object Label31: TLabel
            Left = 8
            Top = 42
            Width = 54
            Height = 12
            Caption = #20998#37197#28857#25968':'
          end
          object EditMasterOKCreditPoint: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = #24466#24351#20986#24072#21518#65292#24072#29238#24471#21040#30340#22768#26395#28857#25968#12290
            MaxValue = 1000
            MinValue = 0
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKCreditPointChange
          end
          object EditMasterOKBonusPoint: TSpinEdit
            Left = 68
            Top = 39
            Width = 53
            Height = 21
            Hint = #24466#24351#20986#24072#21518#65292#24072#29238#24471#21040#30340#20998#37197#28857#25968#12290
            MaxValue = 1000
            MinValue = 0
            TabOrder = 1
            Value = 10
            OnChange = EditMasterOKBonusPointChange
          end
        end
      end
      object ButtonMasterSave: TButton
        Left = 360
        Top = 157
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonMasterSaveClick
      end
    end
    object TabSheet38: TTabSheet
      Caption = #36716#29983#31995#32479
      ImageIndex = 9
      object GroupBox29: TGroupBox
        Left = 8
        Top = 8
        Width = 113
        Height = 257
        Caption = #33258#21160#21464#33394
        TabOrder = 0
        object Label56: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object LabelReNewNameColor1: TLabel
          Left = 88
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label58: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object LabelReNewNameColor2: TLabel
          Left = 88
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label60: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object LabelReNewNameColor3: TLabel
          Left = 88
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label62: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object LabelReNewNameColor4: TLabel
          Left = 88
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label64: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object LabelReNewNameColor5: TLabel
          Left = 88
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label66: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object LabelReNewNameColor6: TLabel
          Left = 88
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label68: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object LabelReNewNameColor7: TLabel
          Left = 88
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label70: TLabel
          Left = 11
          Top = 184
          Width = 18
          Height = 12
          Caption = #20843':'
        end
        object LabelReNewNameColor8: TLabel
          Left = 88
          Top = 182
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label72: TLabel
          Left = 11
          Top = 208
          Width = 18
          Height = 12
          Caption = #20061':'
        end
        object LabelReNewNameColor9: TLabel
          Left = 88
          Top = 206
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label74: TLabel
          Left = 11
          Top = 232
          Width = 18
          Height = 12
          Caption = #21313':'
        end
        object LabelReNewNameColor10: TLabel
          Left = 88
          Top = 230
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditReNewNameColor1: TSpinEdit
          Left = 40
          Top = 12
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditReNewNameColor1Change
        end
        object EditReNewNameColor2: TSpinEdit
          Left = 40
          Top = 36
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditReNewNameColor2Change
        end
        object EditReNewNameColor3: TSpinEdit
          Left = 40
          Top = 60
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditReNewNameColor3Change
        end
        object EditReNewNameColor4: TSpinEdit
          Left = 40
          Top = 84
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditReNewNameColor4Change
        end
        object EditReNewNameColor5: TSpinEdit
          Left = 40
          Top = 108
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditReNewNameColor5Change
        end
        object EditReNewNameColor6: TSpinEdit
          Left = 40
          Top = 132
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditReNewNameColor6Change
        end
        object EditReNewNameColor7: TSpinEdit
          Left = 40
          Top = 156
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditReNewNameColor7Change
        end
        object EditReNewNameColor8: TSpinEdit
          Left = 40
          Top = 180
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditReNewNameColor8Change
        end
        object EditReNewNameColor9: TSpinEdit
          Left = 40
          Top = 204
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditReNewNameColor9Change
        end
        object EditReNewNameColor10: TSpinEdit
          Left = 40
          Top = 228
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 9
          Value = 100
          OnChange = EditReNewNameColor10Change
        end
      end
      object ButtonReNewLevelSave: TButton
        Left = 360
        Top = 157
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonReNewLevelSaveClick
      end
      object GroupBox30: TGroupBox
        Left = 128
        Top = 8
        Width = 105
        Height = 65
        Caption = #21517#23383#21464#33394
        TabOrder = 2
        object Label57: TLabel
          Left = 8
          Top = 42
          Width = 30
          Height = 12
          Caption = #38388#38548':'
        end
        object Label59: TLabel
          Left = 83
          Top = 44
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditReNewNameColorTime: TSpinEdit
          Left = 44
          Top = 39
          Width = 37
          Height = 21
          Hint = #20986#24072#31561#32423#35774#32622#65292#20154#29289#22312#25308#24072#21518#65292#21040#25351#23450#31561#32423#21518#23558#33258#21160#20986#24072#12290
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditReNewNameColorTimeChange
        end
        object CheckBoxReNewChangeColor: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Hint = #25171#24320#27492#21151#33021#21518#65292#36716#29983#30340#20154#29289#30340#21517#23383#39068#33394#20250#33258#21160#21464#21270#12290
          Caption = #33258#21160#21464#33394
          TabOrder = 1
          OnClick = CheckBoxReNewChangeColorClick
        end
      end
      object GroupBox33: TGroupBox
        Left = 128
        Top = 80
        Width = 105
        Height = 41
        Caption = #36716#29983#25511#21046
        TabOrder = 3
        object CheckBoxReNewLevelClearExp: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Hint = #36716#29983#26102#26159#21542#28165#38500#24050#32463#26377#30340#32463#39564#20540#12290
          Caption = #28165#38500#24050#26377#32463#39564
          TabOrder = 0
          OnClick = CheckBoxReNewLevelClearExpClick
        end
      end
    end
    object TabSheet39: TTabSheet
      Caption = #23453#23453#21319#32423
      ImageIndex = 10
      object ButtonMonUpgradeSave: TButton
        Left = 360
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = ButtonMonUpgradeSaveClick
      end
      object GroupBox32: TGroupBox
        Left = 8
        Top = 8
        Width = 113
        Height = 233
        Caption = #31561#32423#39068#33394
        TabOrder = 1
        object Label65: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object LabelMonUpgradeColor1: TLabel
          Left = 88
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label67: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object LabelMonUpgradeColor2: TLabel
          Left = 88
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label69: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object LabelMonUpgradeColor3: TLabel
          Left = 88
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label71: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object LabelMonUpgradeColor4: TLabel
          Left = 88
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label73: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object LabelMonUpgradeColor5: TLabel
          Left = 88
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label75: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object LabelMonUpgradeColor6: TLabel
          Left = 88
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label76: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object LabelMonUpgradeColor7: TLabel
          Left = 88
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label77: TLabel
          Left = 11
          Top = 184
          Width = 18
          Height = 12
          Caption = #20843':'
        end
        object LabelMonUpgradeColor8: TLabel
          Left = 88
          Top = 182
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label86: TLabel
          Left = 11
          Top = 208
          Width = 18
          Height = 12
          Caption = #20061':'
        end
        object LabelMonUpgradeColor9: TLabel
          Left = 88
          Top = 206
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditMonUpgradeColor1: TSpinEdit
          Left = 40
          Top = 12
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeColor1Change
        end
        object EditMonUpgradeColor2: TSpinEdit
          Left = 40
          Top = 36
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeColor2Change
        end
        object EditMonUpgradeColor3: TSpinEdit
          Left = 40
          Top = 60
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeColor3Change
        end
        object EditMonUpgradeColor4: TSpinEdit
          Left = 40
          Top = 84
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeColor4Change
        end
        object EditMonUpgradeColor5: TSpinEdit
          Left = 40
          Top = 108
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeColor5Change
        end
        object EditMonUpgradeColor6: TSpinEdit
          Left = 40
          Top = 132
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeColor6Change
        end
        object EditMonUpgradeColor7: TSpinEdit
          Left = 40
          Top = 156
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeColor7Change
        end
        object EditMonUpgradeColor8: TSpinEdit
          Left = 40
          Top = 180
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpgradeColor8Change
        end
        object EditMonUpgradeColor9: TSpinEdit
          Left = 40
          Top = 204
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpgradeColor9Change
        end
      end
      object GroupBox31: TGroupBox
        Left = 128
        Top = 8
        Width = 97
        Height = 233
        Caption = #21319#32423#26432#24618#25968
        TabOrder = 2
        object Label61: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object Label63: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object Label78: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object Label79: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object Label80: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object Label81: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object Label82: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object Label83: TLabel
          Left = 11
          Top = 184
          Width = 30
          Height = 12
          Caption = #22522#25968':'
        end
        object Label84: TLabel
          Left = 11
          Top = 208
          Width = 30
          Height = 12
          Caption = #20493#29575':'
        end
        object EditMonUpgradeKillCount1: TSpinEdit
          Left = 40
          Top = 12
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeKillCount1Change
        end
        object EditMonUpgradeKillCount2: TSpinEdit
          Left = 40
          Top = 36
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeKillCount2Change
        end
        object EditMonUpgradeKillCount3: TSpinEdit
          Left = 40
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeKillCount3Change
        end
        object EditMonUpgradeKillCount4: TSpinEdit
          Left = 40
          Top = 84
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeKillCount4Change
        end
        object EditMonUpgradeKillCount5: TSpinEdit
          Left = 40
          Top = 108
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeKillCount5Change
        end
        object EditMonUpgradeKillCount6: TSpinEdit
          Left = 40
          Top = 132
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeKillCount6Change
        end
        object EditMonUpgradeKillCount7: TSpinEdit
          Left = 40
          Top = 156
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeKillCount7Change
        end
        object EditMonUpLvNeedKillBase: TSpinEdit
          Left = 40
          Top = 180
          Width = 49
          Height = 21
          Hint = #26432#24618#25968#37327'='#31561#32423' * '#20493#29575' + '#31561#32423' + '#22522#25968' + '#27599#32423#25968#37327
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpLvNeedKillBaseChange
        end
        object EditMonUpLvRate: TSpinEdit
          Left = 40
          Top = 204
          Width = 49
          Height = 21
          Hint = #26432#24618#25968#37327'='#24618#29289#31561#32423' * '#20493#29575' + '#31561#32423' + '#22522#25968' + '#27599#32423#25968#37327
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpLvRateChange
        end
      end
      object GroupBox35: TGroupBox
        Left = 232
        Top = 8
        Width = 137
        Height = 113
        Caption = #20027#20154#27515#20129#25511#21046
        TabOrder = 3
        object Label88: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #21464#24322#26426#29575':'
        end
        object Label90: TLabel
          Left = 11
          Top = 64
          Width = 54
          Height = 12
          Caption = #22686#21152#25915#20987':'
        end
        object Label92: TLabel
          Left = 11
          Top = 88
          Width = 54
          Height = 12
          Caption = #22686#21152#36895#24230':'
        end
        object CheckBoxMasterDieMutiny: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #20027#20154#27515#20129#21518#21464#24322
          TabOrder = 0
          OnClick = CheckBoxMasterDieMutinyClick
        end
        object EditMasterDieMutinyRate: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          Hint = #25968#23383#36234#23567#65292#21464#24322#26426#29575#36234#22823#12290
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMasterDieMutinyRateChange
        end
        object EditMasterDieMutinyPower: TSpinEdit
          Left = 72
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMasterDieMutinyPowerChange
        end
        object EditMasterDieMutinySpeed: TSpinEdit
          Left = 72
          Top = 84
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMasterDieMutinySpeedChange
        end
      end
      object GroupBox47: TGroupBox
        Left = 232
        Top = 128
        Width = 137
        Height = 73
        Caption = #19971#24425#23453#23453
        TabOrder = 4
        object Label112: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #26102#38388#38388#38548':'
        end
        object CheckBoxBBMonAutoChangeColor: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #23453#23453#33258#21160#21464#33394
          TabOrder = 0
          OnClick = CheckBoxBBMonAutoChangeColorClick
        end
        object EditBBMonAutoChangeColorTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          Hint = #25968#23383#36234#23567#65292#21464#33394#36895#24230#36234#24555#65292#21333#20301'('#31186')'#12290
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = EditBBMonAutoChangeColorTimeChange
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = #25216#33021#39764#27861
      ImageIndex = 1
      object ButtonSkillSave: TButton
        Left = 379
        Top = 275
        Width = 68
        Height = 23
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = ButtonSkillSaveClick
      end
      object MagicPageControl: TPageControl
        Left = 0
        Top = 2
        Width = 446
        Height = 269
        ActivePage = TabSheet54
        TabOrder = 1
        object TabSheet54: TTabSheet
          Caption = #22522#26412#21442#25968
          object GroupBox17: TGroupBox
            Left = 8
            Top = 8
            Width = 145
            Height = 49
            Caption = #39764#27861#25915#20987#33539#22260#38480#21046
            TabOrder = 0
            object Label12: TLabel
              Left = 8
              Top = 21
              Width = 54
              Height = 12
              Caption = #33539#22260#22823#23567':'
            end
            object EditMagicAttackRage: TSpinEdit
              Left = 68
              Top = 18
              Width = 60
              Height = 21
              Hint = #39764#27861#25915#20987#26377#25928#36317#31163#65292#36229#36807#25351#23450#36317#31163#25915#20987#26080#25928#12290
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMagicAttackRageChange
            end
          end
          object GroupBox75: TGroupBox
            Left = 7
            Top = 68
            Width = 145
            Height = 49
            Caption = #39764#27861#23545#24618#29289#20260#23475#20493#29575
            TabOrder = 1
            object Label186: TLabel
              Left = 8
              Top = 21
              Width = 54
              Height = 12
              Caption = #20260#23475#20493#29575':'
            end
            object EditMagicAttackMonsteRate: TSpinEdit
              Left = 68
              Top = 18
              Width = 60
              Height = 21
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditMagicAttackMonsteRateChange
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #27494#22763#25216#33021
          ImageIndex = 1
          object PageControl2: TPageControl
            Left = 3
            Top = 3
            Width = 432
            Height = 237
            ActivePage = TabSheet24
            TabOrder = 0
            object TabSheet3: TTabSheet
              Caption = #21050#26432#21073#26415
              object GroupBox9: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #26080#38480#21050#26432
                TabOrder = 0
                object CheckBoxLimitSwordLong: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23558#26816#26597#26816#26597#38548#20301#26159#21542#26377#35282#33394#23384#22312#65292#20197#31105#27490#20992#20992#21050#26432#12290
                  Caption = #31105#27490#26080#38480#21050#26432
                  TabOrder = 0
                  OnClick = CheckBoxLimitSwordLongClick
                end
              end
              object GroupBox10: TGroupBox
                Left = 8
                Top = 56
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 1
                object Label4: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label10: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSwordLongPowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSwordLongPowerRateChange
                end
              end
            end
            object TabSheet4: TTabSheet
              Caption = #24443#22320#38025
              ImageIndex = 1
              object GroupBox56: TGroupBox
                Left = 159
                Top = 86
                Width = 138
                Height = 51
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 0
                Visible = False
                object Label119: TLabel
                  Left = 10
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label120: TLabel
                  Left = 114
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditSkill39Sec: TSpinEdit
                  Left = 50
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkill39SecChange
                end
              end
              object GroupBox57: TGroupBox
                Left = 9
                Top = 65
                Width = 137
                Height = 46
                Caption = #20801#35768'PK'
                TabOrder = 1
                object CheckBoxDedingAllowPK: TCheckBox
                  Left = 9
                  Top = 18
                  Width = 97
                  Height = 17
                  Caption = #20801#35768'PK'
                  TabOrder = 0
                  OnClick = CheckBoxDedingAllowPKClick
                end
              end
              object GroupBox52: TGroupBox
                Left = 9
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 2
                object Label135: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditDidingPowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditDidingPowerRateChange
                end
              end
            end
            object TabSheet5: TTabSheet
              Caption = #29422#23376#21564
              ImageIndex = 2
              object GroupBox48: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 59
                Caption = #40635#30201#36873#39033
                TabOrder = 0
                object CheckBoxGroupMbAttackPlayObject: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23601#21487#20197#40635#30201#20154#29289
                  Caption = #20801#35768#40635#30201#20154#29289
                  TabOrder = 0
                  OnClick = CheckBoxGroupMbAttackPlayObjectClick
                end
                object CheckBoxGroupMbAttackSlave: TCheckBox
                  Left = 8
                  Top = 36
                  Width = 97
                  Height = 17
                  Caption = #20801#35768#40635#30201#23453#23453
                  TabOrder = 1
                  OnClick = CheckBoxGroupMbAttackSlaveClick
                end
              end
            end
            object TabSheet6: TTabSheet
              Caption = #25810#40857#25163
              ImageIndex = 3
              object GroupBox50: TGroupBox
                Left = 8
                Top = 8
                Width = 161
                Height = 65
                Caption = #26159#21542#21487#20197#25235#20154#29289
                TabOrder = 0
                object CheckBoxPullPlayObject: TCheckBox
                  Left = 9
                  Top = 17
                  Width = 89
                  Height = 17
                  Caption = #20801#35768#25235#20154#29289
                  TabOrder = 0
                  OnClick = CheckBoxPullPlayObjectClick
                end
                object CheckBoxPullCrossInSafeZone: TCheckBox
                  Left = 9
                  Top = 40
                  Width = 121
                  Height = 17
                  Caption = #31105#27490#25235#23433#20840#21306#20154#29289
                  TabOrder = 1
                  OnClick = CheckBoxPullCrossInSafeZoneClick
                end
              end
            end
            object ts1: TTabSheet
              Caption = #19977#32477#26432
              ImageIndex = 4
              object grp3: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object lbl3: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill110PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill110PowerRateChange
                end
              end
            end
            object ts2: TTabSheet
              Caption = #36861#24515#21050
              ImageIndex = 5
              object grp4: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                Visible = False
                object lbl4: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill111PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill111PowerRateChange
                end
              end
            end
            object ts3: TTabSheet
              Caption = #26029#23731#26025
              ImageIndex = 6
              object grp5: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object lbl5: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill112PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill112PowerRateChange
                end
              end
            end
            object ts4: TTabSheet
              Caption = #27178#25195#21315#20891
              ImageIndex = 7
              object grp6: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object lbl6: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill113PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill113PowerRateChange
                end
              end
            end
            object TabSheet24: TTabSheet
              Caption = #21313#27493#19968#26432
              ImageIndex = 8
              object GroupBox59: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 195
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object Label142: TLabel
                  Left = 10
                  Top = 21
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object EditSkill70PowerRate: TSpinEdit
                  Left = 75
                  Top = 16
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill70PowerRateChange
                end
                object CheckBoxSkill70MbAttackMon: TCheckBox
                  Left = 10
                  Top = 40
                  Width = 107
                  Height = 17
                  Caption = #20801#35768#40635#30201#24618#29289
                  TabOrder = 1
                  OnClick = CheckBoxSkill70MbAttackMonClick
                end
                object CheckBoxSkill70MbAttackHuman: TCheckBox
                  Left = 10
                  Top = 57
                  Width = 107
                  Height = 17
                  Caption = #20801#35768#40635#30201#20154#29289
                  TabOrder = 2
                  OnClick = CheckBoxSkill70MbAttackHumanClick
                end
                object CheckBoxSkill70MbAttackSlave: TCheckBox
                  Left = 10
                  Top = 74
                  Width = 107
                  Height = 17
                  Caption = #20801#35768#40635#30201#23453#23453
                  TabOrder = 3
                  OnClick = CheckBoxSkill70MbAttackSlaveClick
                end
                object CheckBoxSkill70MbFastParalysis: TCheckBox
                  Left = 10
                  Top = 91
                  Width = 107
                  Height = 17
                  Hint = #24403#20154#29289#25110#24618#29289#34987#35813#25216#33021#40635#30201#21518#65292#26159#21542#34987#25915#20987#39532#19978#21462#28040#40635#30201#29366#24577#12290
                  Caption = #26159#21542#24555#36895#40635#30201
                  TabOrder = 4
                  OnClick = CheckBoxSkill70MbFastParalysisClick
                end
                object CheckBoxSkill70RunGuard: TCheckBox
                  Left = 10
                  Top = 158
                  Width = 99
                  Height = 13
                  Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#23558#21487#20197#31359#36807#23432#21355'('#22823#20992#12289#24339#31661#25163')'
                  Caption = #20801#35768#31359#36807#23432#21355
                  TabOrder = 5
                  OnClick = CheckBoxSkill70RunGuardClick
                end
                object CheckBoxSkill70RunNpc: TCheckBox
                  Left = 10
                  Top = 142
                  Width = 99
                  Height = 13
                  Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#23558#21487#20197#31359#36807'NPC'
                  Caption = #20801#35768#31359#36807'NPC'
                  TabOrder = 6
                  OnClick = CheckBoxSkill70RunNpcClick
                end
                object CheckBoxSkill70RunMon: TCheckBox
                  Left = 10
                  Top = 126
                  Width = 99
                  Height = 13
                  Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#23558#21487#20197#31359#36807#24618#29289
                  Caption = #20801#35768#31359#36807#24618#29289
                  TabOrder = 7
                  OnClick = CheckBoxSkill70RunMonClick
                end
                object CheckBoxSkill70RunHum: TCheckBox
                  Left = 10
                  Top = 110
                  Width = 98
                  Height = 13
                  Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#23558#21487#20197#31359#36807#20854#20182#20154#29289
                  Caption = #20801#35768#31359#36807#20154#29289
                  TabOrder = 8
                  OnClick = CheckBoxSkill70RunHumClick
                end
                object CheckBoxSkill70WarDisHumRun: TCheckBox
                  Left = 10
                  Top = 174
                  Width = 119
                  Height = 13
                  Hint = #25171#24320#27492#21151#33021#21518#65292#22312#25915#22478#21306#22495#20840#37096#31105#27490
                  Caption = #25915#22478#21306#22495#20840#37096#31105#27490
                  TabOrder = 9
                  OnClick = CheckBoxSkill70WarDisHumRunClick
                end
              end
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = #27861#24072#25216#33021
          ImageIndex = 2
          object PageControl3: TPageControl
            Left = 3
            Top = 3
            Width = 432
            Height = 236
            ActivePage = TabSheet25
            TabOrder = 0
            object TabSheet8: TTabSheet
              Caption = #35825#24785#20043#20809
              object GroupBox38: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #24618#29289#31561#32423#38480#21046
                TabOrder = 0
                object Label98: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #31561#32423':'
                end
                object EditMagTammingLevel: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #25351#23450#31561#32423#20197#19979#30340#24618#29289#25165#20250#34987#35825#24785#65292#25351#23450#31561#32423#20197#19978#30340#24618#29289#35825#24785#26080#25928#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingLevelChange
                end
              end
              object GroupBox45: TGroupBox
                Left = 128
                Top = 8
                Width = 113
                Height = 41
                Caption = #35825#24785#25968#37327
                TabOrder = 1
                object Label111: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #25968#37327':'
                end
                object EditTammingCount: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #21487#35825#24785#24618#29289#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditTammingCountChange
                end
              end
              object GroupBox39: TGroupBox
                Left = 8
                Top = 56
                Width = 113
                Height = 73
                Caption = #35825#24785#26426#29575
                TabOrder = 2
                object Label99: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#31561#32423':'
                end
                object Label100: TLabel
                  Left = 8
                  Top = 44
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#34880#37327':'
                end
                object EditMagTammingTargetLevel: TSpinEdit
                  Left = 64
                  Top = 15
                  Width = 41
                  Height = 21
                  Hint = #24618#29289#31561#32423#27604#29575#65292#27492#25968#23383#36234#23567#26426#29575#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingTargetLevelChange
                end
                object EditMagTammingHPRate: TSpinEdit
                  Left = 64
                  Top = 39
                  Width = 41
                  Height = 21
                  Hint = #24618#29289#34880#37327#27604#29575#65292#27492#25968#23383#36234#22823#65292#26426#29575#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 1
                  OnChange = EditMagTammingHPRateChange
                end
              end
            end
            object TabSheet12: TTabSheet
              Caption = #29190#35010#28779#28976
              ImageIndex = 4
              object GroupBox13: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label7: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditFireBoomRage: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditFireBoomRageChange
                end
              end
            end
            object TabSheet9: TTabSheet
              Caption = #28779#22681
              ImageIndex = 1
              object GroupBox53: TGroupBox
                Left = 8
                Top = 55
                Width = 185
                Height = 74
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object Label117: TLabel
                  Left = 8
                  Top = 20
                  Width = 84
                  Height = 12
                  Caption = #26377#25928#26102#38388#20493#25968#65306
                end
                object Label116: TLabel
                  Left = 8
                  Top = 44
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditFireDelayTime: TSpinEdit
                  Left = 96
                  Top = 16
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditFireDelayTimeChange
                end
                object SpinEditFirePower: TSpinEdit
                  Left = 96
                  Top = 40
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 1
                  Value = 100
                  OnChange = SpinEditFirePowerChange
                end
              end
              object GroupBox46: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #23433#20840#21306#31105#27490#28779#22681
                TabOrder = 1
                object CheckBoxFireCrossInSafeZone: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#22312#23433#20840#21306#19981#20801#35768#25918#28779#22681#12290
                  Caption = #31105#27490#28779#22681
                  TabOrder = 0
                  OnClick = CheckBoxFireCrossInSafeZoneClick
                end
              end
              object GroupBox63: TGroupBox
                Left = 127
                Top = 8
                Width = 134
                Height = 41
                Caption = #25442#22320#22270#33258#21160#28040#22833
                TabOrder = 2
                object CheckBoxFireChgMapExtinguish: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 108
                  Height = 17
                  Caption = #25442#22320#22270#33258#21160#28040#22833
                  TabOrder = 0
                  OnClick = CheckBoxFireChgMapExtinguishClick
                end
              end
              object grp2: TGroupBox
                Left = 199
                Top = 55
                Width = 143
                Height = 74
                Caption = #20260#23475#38388#38548
                TabOrder = 3
                object lbl1: TLabel
                  Left = 8
                  Top = 20
                  Width = 36
                  Height = 12
                  Caption = #20154#29289#65306
                end
                object lbl2: TLabel
                  Left = 8
                  Top = 44
                  Width = 36
                  Height = 12
                  Caption = #24618#29289#65306
                end
                object seFirePlayDamageTimeRate: TSpinEdit
                  Left = 50
                  Top = 17
                  Width = 81
                  Height = 21
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seFirePlayDamageTimeRateChange
                end
                object seFireMonDamageTimeRate: TSpinEdit
                  Left = 50
                  Top = 41
                  Width = 81
                  Height = 21
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 1
                  Value = 100
                  OnChange = seFireMonDamageTimeRateChange
                end
              end
            end
            object TabSheet11: TTabSheet
              Caption = #22320#29425#38647#20809
              ImageIndex = 3
              object GroupBox15: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label9: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditElecBlizzardRange: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditElecBlizzardRangeChange
                end
              end
            end
            object TabSheet10: TTabSheet
              Caption = #22307#35328#26415
              ImageIndex = 2
              object GroupBox37: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #24618#29289#31561#32423#38480#21046
                TabOrder = 0
                object Label97: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #31561#32423':'
                end
                object EditMagTurnUndeadLevel: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #25351#23450#31561#32423#20197#19979#30340#24618#29289#25165#20250#34987#22307#35328#65292#25351#23450#31561#32423#20197#19978#30340#24618#29289#22307#35328#26080#25928#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTurnUndeadLevelChange
                end
              end
            end
            object TabSheet13: TTabSheet
              Caption = #20912#21638#21742
              ImageIndex = 5
              object GroupBox14: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label8: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditSnowWindRange: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditSnowWindRangeChange
                end
              end
            end
            object TabSheet17: TTabSheet
              Caption = #28781#22825#28779
              ImageIndex = 7
              object GroupBox51: TGroupBox
                Left = 8
                Top = 8
                Width = 121
                Height = 49
                Caption = #20943'MP'#20540
                TabOrder = 0
                object CheckBoxPlayObjectReduceMP: TCheckBox
                  Left = 8
                  Top = 18
                  Width = 97
                  Height = 17
                  Caption = #20987#20013#20943'MP'#20540
                  TabOrder = 0
                  OnClick = CheckBoxPlayObjectReduceMPClick
                end
              end
            end
            object TabSheet36: TTabSheet
              Caption = #20912#38684#38634#38632
              ImageIndex = 13
              object GroupBox70: TGroupBox
                Left = 8
                Top = 8
                Width = 121
                Height = 49
                Caption = #20943'MP'#20540
                TabOrder = 0
                object CheckBoxSkill66ReduceMP: TCheckBox
                  Left = 8
                  Top = 18
                  Width = 97
                  Height = 17
                  Caption = #20987#20013#20943'MP'#20540
                  TabOrder = 0
                  OnClick = CheckBoxSkill66ReduceMPClick
                end
              end
            end
            object TabSheet27: TTabSheet
              Caption = #31227#24418#25442#20301
              ImageIndex = 12
              object GroupBox64: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 102
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object CheckBoxSkill63RunGuard: TCheckBox
                  Left = 10
                  Top = 65
                  Width = 99
                  Height = 13
                  Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#23558#21487#20197#37325#21472#23432#21355'('#22823#20992#12289#24339#31661#25163')'
                  Caption = #20801#35768#37325#21472#23432#21355
                  TabOrder = 0
                  OnClick = CheckBoxSkill63RunGuardClick
                end
                object CheckBoxSkill63RunNpc: TCheckBox
                  Left = 10
                  Top = 49
                  Width = 99
                  Height = 13
                  Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#23558#21487#20197#37325#21472'NPC'
                  Caption = #20801#35768#37325#21472'NPC'
                  TabOrder = 1
                  OnClick = CheckBoxSkill63RunNpcClick
                end
                object CheckBoxSkill63RunMon: TCheckBox
                  Left = 10
                  Top = 33
                  Width = 99
                  Height = 13
                  Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#23558#21487#20197#37325#21472#24618#29289
                  Caption = #20801#35768#37325#21472#24618#29289
                  TabOrder = 2
                  OnClick = CheckBoxSkill63RunMonClick
                end
                object CheckBoxSkill63RunHum: TCheckBox
                  Left = 10
                  Top = 17
                  Width = 98
                  Height = 13
                  Hint = #25171#24320#27492#21151#33021#21518#65292#20154#29289#23558#21487#20197#37325#21472#20854#20182#20154#29289
                  Caption = #20801#35768#37325#21472#20154#29289
                  TabOrder = 3
                  OnClick = CheckBoxSkill63RunHumClick
                end
                object CheckBoxSkill63WarDisHumRun: TCheckBox
                  Left = 10
                  Top = 81
                  Width = 119
                  Height = 13
                  Hint = #25171#24320#27492#21151#33021#21518#65292#22312#25915#22478#21306#22495#20840#37096#31105#27490
                  Caption = #25915#22478#21306#22495#20840#37096#31105#27490
                  TabOrder = 4
                  OnClick = CheckBoxSkill63WarDisHumRunClick
                end
              end
            end
            object ts5: TTabSheet
              Caption = #21452#40857#30772
              ImageIndex = 7
              object grp7: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object lbl7: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill114PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill114PowerRateChange
                end
              end
            end
            object ts6: TTabSheet
              Caption = #20964#33310#25216
              ImageIndex = 8
              object grp8: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object lbl8: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill115PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill115PowerRateChange
                end
              end
            end
            object ts7: TTabSheet
              Caption = #24778#38647#29190
              ImageIndex = 9
              object grp9: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object lbl9: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill116PowerRate: TSpinEdit
                  Left = 74
                  Top = 18
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill116PowerRateChange
                end
              end
            end
            object ts8: TTabSheet
              Caption = #20912#22825#38634#22320
              ImageIndex = 10
              object grp10: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object lbl10: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill117PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill117PowerRateChange
                end
              end
            end
            object TabSheet25: TTabSheet
              Caption = #20912#38684#32676#38632
              ImageIndex = 11
              object GroupBox60: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 133
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object Label143: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object EditSkill71PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill71PowerRateChange
                end
                object CheckBoxSkill71MbAttackMon: TCheckBox
                  Left = 10
                  Top = 46
                  Width = 107
                  Height = 17
                  Caption = #20801#35768#40635#30201#24618#29289
                  TabOrder = 1
                  OnClick = CheckBoxSkill71MbAttackMonClick
                end
                object CheckBoxSkill71MbAttackHuman: TCheckBox
                  Left = 10
                  Top = 66
                  Width = 107
                  Height = 17
                  Caption = #20801#35768#40635#30201#20154#29289
                  TabOrder = 2
                  OnClick = CheckBoxSkill71MbAttackHumanClick
                end
                object CheckBoxSkill71MbAttackSlave: TCheckBox
                  Left = 10
                  Top = 87
                  Width = 107
                  Height = 17
                  Caption = #20801#35768#40635#30201#23453#23453
                  TabOrder = 3
                  OnClick = CheckBoxSkill71MbAttackSlaveClick
                end
                object CheckBoxSkill71MbFastParalysis: TCheckBox
                  Left = 10
                  Top = 107
                  Width = 107
                  Height = 17
                  Hint = #24403#20154#29289#25110#24618#29289#34987#35813#25216#33021#40635#30201#21518#65292#26159#21542#34987#25915#20987#39532#19978#21462#28040#40635#30201#29366#24577#12290
                  Caption = #26159#21542#24555#36895#40635#30201
                  TabOrder = 4
                  OnClick = CheckBoxSkill71MbFastParalysisClick
                end
              end
            end
          end
        end
        object TabSheet15: TTabSheet
          Caption = #36947#22763#25216#33021
          ImageIndex = 3
          object PageControl4: TPageControl
            Left = 3
            Top = 3
            Width = 432
            Height = 236
            ActivePage = ts9
            TabOrder = 0
            object TabSheet16: TTabSheet
              Caption = #26045#27602#26415
              object GroupBox16: TGroupBox
                Left = 8
                Top = 8
                Width = 137
                Height = 49
                Caption = #27602#33647#38477#28857
                TabOrder = 0
                object Label11: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #28857#25968#25511#21046':'
                end
                object EditAmyOunsulPoint: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #20013#27602#21518#25351#23450#26102#38388#20869#38477#28857#25968#65292#23454#38469#28857#25968#36319#25216#33021#31561#32423#21450#26412#36523#36947#26415#39640#20302#26377#20851#65292#27492#21442#25968#21482#26159#35843#20854#20013#31639#27861#21442#25968#65292#27492#25968#23383#36234#23567#65292#28857#25968#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditAmyOunsulPointChange
                end
              end
            end
            object TabSheet18: TTabSheet
              Caption = #21484#21796#39607#39621
              ImageIndex = 1
              object GroupBox5: TGroupBox
                Left = 5
                Top = 2
                Width = 124
                Height = 204
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label2: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label3: TLabel
                  Left = 8
                  Top = 58
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditBoneFammName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  TabOrder = 0
                  OnChange = EditBoneFammNameChange
                end
                object EditBoneFammCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditBoneFammCountChange
                end
              end
              object GroupBox6: TGroupBox
                Left = 135
                Top = 2
                Width = 284
                Height = 204
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridBoneFamm: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 177
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet19: TTabSheet
              Caption = #21484#21796#31070#20861
              ImageIndex = 2
              object GroupBox11: TGroupBox
                Left = 5
                Top = 2
                Width = 124
                Height = 204
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label5: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label6: TLabel
                  Left = 8
                  Top = 58
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditDogzName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  TabOrder = 0
                  OnChange = EditDogzNameChange
                end
                object EditDogzCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditDogzCountChange
                end
              end
              object GroupBox12: TGroupBox
                Left = 135
                Top = 2
                Width = 284
                Height = 204
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridDogz: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 179
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet31: TTabSheet
              Caption = #21484#21796#26376#28789
              ImageIndex = 9
              object GroupBox67: TGroupBox
                Left = 5
                Top = 2
                Width = 124
                Height = 204
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label161: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label162: TLabel
                  Left = 8
                  Top = 58
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditMoonSpiritName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  TabOrder = 0
                  OnChange = EditDogzNameChange
                end
                object EditMoonSpiritCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditMoonSpiritCountChange
                end
              end
              object GroupBox68: TGroupBox
                Left = 135
                Top = 2
                Width = 284
                Height = 204
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridMoonSpirit: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 179
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet20: TTabSheet
              Caption = #28779#28976#20912
              ImageIndex = 3
              object GroupBox41: TGroupBox
                Left = 8
                Top = 8
                Width = 145
                Height = 73
                Caption = #35282#33394#31561#32423#26426#29575#35774#32622
                TabOrder = 0
                object Label101: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #30456#24046#26426#29575':'
                end
                object Label102: TLabel
                  Left = 8
                  Top = 42
                  Width = 54
                  Height = 12
                  Caption = #30456#24046#38480#21046':'
                end
                object EditMabMabeHitRandRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#34987#25915#20987#21452#26041#30456#24046#31561#32423#21629#20013#26426#29575#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitRandRateChange
                end
                object EditMabMabeHitMinLvLimit: TSpinEdit
                  Left = 68
                  Top = 39
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#34987#25915#20987#21452#26041#30456#24046#31561#32423#21629#20013#26426#29575#65292#26368#23567#38480#21046#65292#25968#23383#36234#23567#26426#29575#36234#20302#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditMabMabeHitMinLvLimitChange
                end
              end
              object GroupBox43: TGroupBox
                Left = 160
                Top = 8
                Width = 145
                Height = 49
                Caption = #40635#30201#26102#38388#21442#25968#20493#29575
                TabOrder = 1
                object Label104: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #21629#20013#26426#29575':'
                end
                object EditMabMabeHitMabeTimeRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #40635#30201#26102#38388#38271#24230#20493#29575#65292#22522#25968#19982#35282#33394#30340#39764#27861#26377#20851#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitMabeTimeRateChange
                end
              end
              object GroupBox42: TGroupBox
                Left = 8
                Top = 88
                Width = 145
                Height = 49
                Caption = #40635#30201#21629#20013#26426#29575
                TabOrder = 2
                object Label103: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #21629#20013#26426#29575':'
                end
                object EditMabMabeHitSucessRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#40635#30201#26426#29575#65292#26368#23567#38480#21046#65292#25968#23383#36234#23567#26426#29575#36234#20302#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitSucessRateChange
                end
              end
            end
            object TabSheet32: TTabSheet
              Caption = #35010#31070#31526
              ImageIndex = 10
            end
            object ts9: TTabSheet
              Caption = #34382#21880#20915
              ImageIndex = 4
              object grp11: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object lbl11: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill118PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill118PowerRateChange
                end
              end
            end
            object ts10: TTabSheet
              Caption = #20843#21350#25484
              ImageIndex = 5
              object grp12: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object lbl12: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill119PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill119PowerRateChange
                end
              end
            end
            object ts11: TTabSheet
              Caption = #19977#28976#21650
              ImageIndex = 6
              object grp13: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object lbl13: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill120PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill120PowerRateChange
                end
              end
            end
            object ts12: TTabSheet
              Caption = #19975#21073#24402#23447
              ImageIndex = 7
              object grp14: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object lbl14: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object seSkill121PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill121PowerRateChange
                end
              end
            end
            object TabSheet26: TTabSheet
              Caption = #27515#20129#20043#30524
              ImageIndex = 8
              object GroupBox61: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 174
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object Label144: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object EditSkill72PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill72PowerRateChange
                end
                object CheckBoxSkill72MbAttackMon: TCheckBox
                  Left = 10
                  Top = 46
                  Width = 107
                  Height = 17
                  Caption = #20801#35768#40635#30201#24618#29289
                  TabOrder = 1
                  OnClick = CheckBoxSkill72MbAttackMonClick
                end
                object CheckBoxSkill72MbAttackHuman: TCheckBox
                  Left = 10
                  Top = 66
                  Width = 107
                  Height = 17
                  Caption = #20801#35768#40635#30201#20154#29289
                  TabOrder = 2
                  OnClick = CheckBoxSkill72MbAttackHumanClick
                end
                object CheckBoxSkill72MbAttackSlave: TCheckBox
                  Left = 10
                  Top = 87
                  Width = 107
                  Height = 17
                  Caption = #20801#35768#40635#30201#23453#23453
                  TabOrder = 3
                  OnClick = CheckBoxSkill72MbAttackSlaveClick
                end
                object CheckBoxSkill72Damagearmor: TCheckBox
                  Left = 10
                  Top = 107
                  Width = 107
                  Height = 17
                  Caption = #20801#35768#20013#32418#27602
                  TabOrder = 4
                  OnClick = CheckBoxSkill72DamagearmorClick
                end
                object CheckBoxSkill72DecHealth: TCheckBox
                  Left = 10
                  Top = 127
                  Width = 107
                  Height = 17
                  Caption = #20801#35768#20013#32511#27602
                  TabOrder = 5
                  OnClick = CheckBoxSkill72DecHealthClick
                end
                object CheckBoxSkill72MbFastParalysis: TCheckBox
                  Left = 10
                  Top = 150
                  Width = 107
                  Height = 17
                  Hint = #24403#20154#29289#25110#24618#29289#34987#35813#25216#33021#40635#30201#21518#65292#26159#21542#34987#25915#20987#39532#19978#21462#28040#40635#30201#29366#24577#12290
                  Caption = #26159#21542#24555#36895#40635#30201
                  TabOrder = 6
                  OnClick = CheckBoxSkill72MbFastParalysisClick
                end
              end
            end
          end
        end
        object TabSheet28: TTabSheet
          Caption = #36890#29992#25216#33021
          ImageIndex = 4
          object PageControl1: TPageControl
            Left = 3
            Top = 3
            Width = 432
            Height = 236
            ActivePage = TabSheet30
            TabOrder = 0
            object TabSheet29: TTabSheet
              Caption = #25252#20307#31070#30462
              object GroupBox69: TGroupBox
                Left = 8
                Top = 8
                Width = 319
                Height = 130
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object Label163: TLabel
                  Left = 8
                  Top = 21
                  Width = 132
                  Height = 12
                  Caption = #25216#33021#31561#32423'0'#32423#26102#35302#21457#26426#29575':'
                end
                object Label164: TLabel
                  Left = 190
                  Top = 21
                  Width = 60
                  Height = 12
                  Caption = '% '#25269#28040#20260#23475
                end
                object Label165: TLabel
                  Left = 303
                  Top = 21
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object Label166: TLabel
                  Left = 8
                  Top = 48
                  Width = 132
                  Height = 12
                  Caption = #25216#33021#31561#32423'1'#32423#26102#35302#21457#26426#29575':'
                end
                object Label167: TLabel
                  Left = 190
                  Top = 48
                  Width = 60
                  Height = 12
                  Caption = '% '#25269#28040#20260#23475
                end
                object Label168: TLabel
                  Left = 303
                  Top = 48
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object Label169: TLabel
                  Left = 8
                  Top = 75
                  Width = 132
                  Height = 12
                  Caption = #25216#33021#31561#32423'2'#32423#26102#35302#21457#26426#29575':'
                end
                object Label170: TLabel
                  Left = 190
                  Top = 75
                  Width = 60
                  Height = 12
                  Caption = '% '#25269#28040#20260#23475
                end
                object Label171: TLabel
                  Left = 303
                  Top = 75
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object Label172: TLabel
                  Left = 8
                  Top = 102
                  Width = 132
                  Height = 12
                  Caption = #25216#33021#31561#32423'3'#32423#26102#35302#21457#26426#29575':'
                end
                object Label173: TLabel
                  Left = 190
                  Top = 102
                  Width = 60
                  Height = 12
                  Caption = '% '#25269#28040#20260#23475
                end
                object Label174: TLabel
                  Left = 303
                  Top = 102
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object EditProtectShieldRunRate0: TSpinEdit
                  Left = 143
                  Top = 18
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditProtectShieldRunRate0Change
                end
                object EditProtectShieldDelDamage0: TSpinEdit
                  Left = 256
                  Top = 18
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 1
                  Value = 100
                  OnChange = EditProtectShieldDelDamage0Change
                end
                object EditProtectShieldRunRate1: TSpinEdit
                  Left = 143
                  Top = 45
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 2
                  Value = 100
                  OnChange = EditProtectShieldRunRate1Change
                end
                object EditProtectShieldDelDamage1: TSpinEdit
                  Left = 256
                  Top = 45
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 3
                  Value = 100
                  OnChange = EditProtectShieldDelDamage1Change
                end
                object EditProtectShieldRunRate2: TSpinEdit
                  Left = 143
                  Top = 72
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 4
                  Value = 100
                  OnChange = EditProtectShieldRunRate2Change
                end
                object EditProtectShieldDelDamage2: TSpinEdit
                  Left = 256
                  Top = 72
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 5
                  Value = 100
                  OnChange = EditProtectShieldDelDamage2Change
                end
                object EditProtectShieldRunRate3: TSpinEdit
                  Left = 143
                  Top = 99
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 6
                  Value = 100
                  OnChange = EditProtectShieldRunRate3Change
                end
                object EditProtectShieldDelDamage3: TSpinEdit
                  Left = 256
                  Top = 99
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 7
                  Value = 100
                  OnChange = EditProtectShieldDelDamage3Change
                end
              end
            end
            object TabSheet30: TTabSheet
              Caption = #20506#22825#36767#22320
              ImageIndex = 1
              object GroupBox65: TGroupBox
                Left = 8
                Top = 8
                Width = 145
                Height = 49
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label145: TLabel
                  Left = 8
                  Top = 21
                  Width = 54
                  Height = 12
                  Caption = #33539#22260#22823#23567':'
                end
                object EditEtenMagicSize: TSpinEdit
                  Left = 68
                  Top = 18
                  Width = 53
                  Height = 21
                  Hint = #39764#27861#25915#20987#26377#25928#36317#31163#65292#36229#36807#25351#23450#36317#31163#25915#20987#26080#25928#12290
                  EditorEnabled = False
                  MaxValue = 10
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditEtenMagicSizeChange
                end
              end
              object GroupBox66: TGroupBox
                Left = 8
                Top = 64
                Width = 145
                Height = 50
                Caption = #25216#33021#21442#25968
                TabOrder = 1
                object Label146: TLabel
                  Left = 8
                  Top = 24
                  Width = 54
                  Height = 12
                  Caption = #23041#21147#20493#25968':'
                end
                object EditEtenPowerRate: TSpinEdit
                  Left = 68
                  Top = 21
                  Width = 53
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditEtenPowerRateChange
                end
              end
            end
          end
        end
      end
    end
    object TabSheet34: TTabSheet
      Caption = #21319#32423#27494#22120
      ImageIndex = 6
      object GroupBox8: TGroupBox
        Left = 8
        Top = 8
        Width = 161
        Height = 121
        Caption = #22522#26412#35774#32622
        TabOrder = 0
        object Label13: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #26368#39640#28857#25968':'
        end
        object Label15: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #25152#38656#36153#29992':'
        end
        object Label16: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #25152#38656#26102#38388':'
        end
        object Label17: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #36807#26399#26102#38388':'
        end
        object Label18: TLabel
          Left = 136
          Top = 65
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label19: TLabel
          Left = 136
          Top = 89
          Width = 12
          Height = 12
          Caption = #22825
        end
        object EditUpgradeWeaponMaxPoint: TSpinEdit
          Left = 68
          Top = 15
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditUpgradeWeaponMaxPointChange
        end
        object EditUpgradeWeaponPrice: TSpinEdit
          Left = 68
          Top = 39
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditUpgradeWeaponPriceChange
        end
        object EditUPgradeWeaponGetBackTime: TSpinEdit
          Left = 68
          Top = 63
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 36000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditUPgradeWeaponGetBackTimeChange
        end
        object EditClearExpireUpgradeWeaponDays: TSpinEdit
          Left = 68
          Top = 87
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditClearExpireUpgradeWeaponDaysChange
        end
      end
      object GroupBox18: TGroupBox
        Left = 176
        Top = 8
        Width = 265
        Height = 89
        Caption = #25915#20987#21147#21319#32423
        TabOrder = 1
        object Label20: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label21: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label22: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponDCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#25915#20987#21147#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponDCRateChange
        end
        object EditUpgradeWeaponDCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponDCTwoPointRateChange
        end
        object EditUpgradeWeaponDCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponDCThreePointRateChange
        end
        object EditUpgradeWeaponDCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox19: TGroupBox
        Left = 176
        Top = 104
        Width = 265
        Height = 97
        Caption = #36947#26415#21319#32423
        TabOrder = 2
        object Label23: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label24: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label25: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponSCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#36947#26415#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponSCRateChange
        end
        object EditUpgradeWeaponSCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponSCTwoPointRateChange
        end
        object EditUpgradeWeaponSCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponSCThreePointRateChange
        end
        object EditUpgradeWeaponSCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox20: TGroupBox
        Left = 176
        Top = 208
        Width = 265
        Height = 89
        Caption = #39764#27861#21319#32423
        TabOrder = 3
        object Label26: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label27: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label28: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponMCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#39764#27861#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponMCRateChange
        end
        object EditUpgradeWeaponMCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponMCTwoPointRateChange
        end
        object EditUpgradeWeaponMCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponMCThreePointRateChange
        end
        object EditUpgradeWeaponMCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object ButtonUpgradeWeaponSave: TButton
        Left = 8
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonUpgradeWeaponSaveClick
      end
      object ButtonUpgradeWeaponDefaulf: TButton
        Left = 80
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 5
        OnClick = ButtonUpgradeWeaponDefaulfClick
      end
    end
    object TabSheet35: TTabSheet
      Caption = #25366#30719#25511#21046
      ImageIndex = 7
      object GroupBox24: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 60
        Caption = #24471#21040#30719#30707#26426#29575
        TabOrder = 0
        object Label32: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #21629#20013#26426#29575':'
        end
        object Label33: TLabel
          Left = 8
          Top = 36
          Width = 54
          Height = 12
          Caption = #25366#30719#26426#29575':'
        end
        object ScrollBarMakeMineHitRate: TScrollBar
          Left = 73
          Top = 15
          Width = 129
          Height = 15
          Hint = #35774#32622#30340#25968#23383#36234#23567#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarMakeMineHitRateChange
        end
        object EditMakeMineHitRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarMakeMineRate: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Hint = #35774#32622#30340#25968#23383#36234#23567#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarMakeMineRateChange
        end
        object EditMakeMineRate: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
      end
      object GroupBox25: TGroupBox
        Left = 8
        Top = 72
        Width = 273
        Height = 217
        Caption = #30719#30707#31867#22411#26426#29575
        TabOrder = 1
        object Label34: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #30719#30707#22240#23376':'
        end
        object Label35: TLabel
          Left = 8
          Top = 38
          Width = 42
          Height = 12
          Caption = #37329#30719#29575':'
        end
        object Label36: TLabel
          Left = 8
          Top = 56
          Width = 42
          Height = 12
          Caption = #38134#30719#29575':'
        end
        object Label37: TLabel
          Left = 8
          Top = 76
          Width = 42
          Height = 12
          Caption = #38108#30719#29575':'
        end
        object Label38: TLabel
          Left = 8
          Top = 96
          Width = 54
          Height = 12
          Caption = #40657#38081#30719#29575':'
          Visible = False
        end
        object ScrollBarStoneTypeRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarStoneTypeRateChange
        end
        object EditStoneTypeRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarGoldStoneMax: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarGoldStoneMaxChange
        end
        object EditGoldStoneMax: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarSilverStoneMax: TScrollBar
          Left = 72
          Top = 56
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarSilverStoneMaxChange
        end
        object EditSilverStoneMax: TEdit
          Left = 208
          Top = 56
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarSteelStoneMax: TScrollBar
          Left = 72
          Top = 76
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarSteelStoneMaxChange
        end
        object EditSteelStoneMax: TEdit
          Left = 208
          Top = 76
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditBlackStoneMax: TEdit
          Left = 208
          Top = 96
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
          Visible = False
        end
        object ScrollBarBlackStoneMax: TScrollBar
          Left = 72
          Top = 96
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 9
          Visible = False
          OnChange = ScrollBarBlackStoneMaxChange
        end
      end
      object ButtonMakeMineSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonMakeMineSaveClick
      end
      object GroupBox26: TGroupBox
        Left = 288
        Top = 8
        Width = 153
        Height = 121
        Caption = #30719#30707#21697#36136
        TabOrder = 3
        object Label39: TLabel
          Left = 8
          Top = 18
          Width = 78
          Height = 12
          Caption = #30719#30707#26368#23567#21697#36136':'
        end
        object Label40: TLabel
          Left = 8
          Top = 42
          Width = 78
          Height = 12
          Caption = #26222#36890#21697#36136#33539#22260':'
        end
        object Label41: TLabel
          Left = 8
          Top = 66
          Width = 66
          Height = 12
          Caption = #39640#21697#36136#26426#29575':'
        end
        object Label42: TLabel
          Left = 8
          Top = 90
          Width = 66
          Height = 12
          Caption = #39640#21697#36136#33539#22260':'
        end
        object EditStoneMinDura: TSpinEdit
          Left = 92
          Top = 15
          Width = 45
          Height = 21
          Hint = #30719#30707#20986#29616#26368#20302#21697#36136#28857#25968#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditStoneMinDuraChange
        end
        object EditStoneGeneralDuraRate: TSpinEdit
          Left = 92
          Top = 39
          Width = 45
          Height = 21
          Hint = #30719#30707#38543#26426#20986#29616#21697#36136#28857#25968#33539#22260#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditStoneGeneralDuraRateChange
        end
        object EditStoneAddDuraRate: TSpinEdit
          Left = 92
          Top = 63
          Width = 45
          Height = 21
          Hint = #30719#30707#20986#29616#39640#21697#36136#28857#25968#26426#29575#65292#39640#21697#36136#37327#25351#21487#36798#21040'20'#25110#20197#19978#30340#28857#25968#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditStoneAddDuraRateChange
        end
        object EditStoneAddDuraMax: TSpinEdit
          Left = 92
          Top = 87
          Width = 45
          Height = 21
          Hint = #39640#21697#36136#30719#30707#38543#26426#20986#29616#21697#36136#28857#25968#33539#22260#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditStoneAddDuraMaxChange
        end
      end
      object ButtonMakeMineDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 4
        OnClick = ButtonMakeMineDefaultClick
      end
    end
    object TabSheet42: TTabSheet
      Caption = #31069#31119#27833
      ImageIndex = 12
      object GroupBox44: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 143
        Caption = #26426#29575#35774#32622
        TabOrder = 0
        object Label105: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #35781#21650#26426#29575':'
        end
        object Label106: TLabel
          Left = 8
          Top = 38
          Width = 54
          Height = 12
          Caption = #19968#32423#28857#25968':'
        end
        object Label107: TLabel
          Left = 8
          Top = 56
          Width = 54
          Height = 12
          Caption = #20108#32423#28857#25968':'
        end
        object Label108: TLabel
          Left = 8
          Top = 76
          Width = 54
          Height = 12
          Caption = #20108#32423#26426#29575':'
        end
        object Label109: TLabel
          Left = 8
          Top = 96
          Width = 54
          Height = 12
          Caption = #19977#32423#28857#25968':'
        end
        object Label110: TLabel
          Left = 8
          Top = 116
          Width = 54
          Height = 12
          Caption = #19977#32423#26426#29575':'
        end
        object ScrollBarWeaponMakeUnLuckRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Hint = #20351#29992#31069#31119#27833#35781#21650#26426#29575#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWeaponMakeUnLuckRateChange
        end
        object EditWeaponMakeUnLuckRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWeaponMakeLuckPoint1: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017'100% '#25104#21151#12290
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWeaponMakeLuckPoint1Change
        end
        object EditWeaponMakeLuckPoint1: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWeaponMakeLuckPoint2: TScrollBar
          Left = 72
          Top = 56
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017#25353#25351#23450#26426#29575#20915#23450#26159#21542#21152#24184#36816#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWeaponMakeLuckPoint2Change
        end
        object EditWeaponMakeLuckPoint2: TEdit
          Left = 208
          Top = 56
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar
          Left = 72
          Top = 76
          Width = 129
          Height = 15
          Hint = #26426#29575#28857#25968#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWeaponMakeLuckPoint2RateChange
        end
        object EditWeaponMakeLuckPoint2Rate: TEdit
          Left = 208
          Top = 76
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWeaponMakeLuckPoint3: TEdit
          Left = 208
          Top = 96
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWeaponMakeLuckPoint3: TScrollBar
          Left = 72
          Top = 96
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017#25353#25351#23450#26426#29575#20915#23450#26159#21542#21152#24184#36816#12290
          Max = 500
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWeaponMakeLuckPoint3Change
        end
        object ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar
          Left = 72
          Top = 116
          Width = 129
          Height = 15
          Hint = #26426#29575#28857#25968#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWeaponMakeLuckPoint3RateChange
        end
        object EditWeaponMakeLuckPoint3Rate: TEdit
          Left = 208
          Top = 116
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
      end
      object ButtonWeaponMakeLuckDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 1
        OnClick = ButtonWeaponMakeLuckDefaultClick
      end
      object ButtonWeaponMakeLuckSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonWeaponMakeLuckSaveClick
      end
      object GroupBox58: TGroupBox
        Left = 287
        Top = 7
        Width = 138
        Height = 55
        Caption = #26368#39640#28857#25968
        TabOrder = 3
        object Label141: TLabel
          Left = 12
          Top = 22
          Width = 54
          Height = 12
          Caption = #22686#21152#28857#25968':'
        end
        object EditUnLuckMaxCount: TSpinEdit
          Left = 73
          Top = 19
          Width = 49
          Height = 21
          Hint = #35774#32622#31069#31119#27833#36798#21040#25351#23450#23450#25968#21518#25165'100%'#21457#25381#26368#22823#25915#20987#65292#40664#35748#20026' 7'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditUnLuckMaxCountChange
        end
      end
    end
    object TabSheet37: TTabSheet
      Caption = #24425#31080#25511#21046
      ImageIndex = 8
      object GroupBox27: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 169
        Caption = #20013#22870#26426#29575
        TabOrder = 0
        object Label43: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = #19968#31561#22870':'
        end
        object Label44: TLabel
          Left = 8
          Top = 62
          Width = 42
          Height = 12
          Caption = #20108#31561#22870':'
        end
        object Label45: TLabel
          Left = 8
          Top = 80
          Width = 42
          Height = 12
          Caption = #19977#31561#22870':'
        end
        object Label46: TLabel
          Left = 8
          Top = 100
          Width = 42
          Height = 12
          Caption = #22235#31561#22870':'
        end
        object Label47: TLabel
          Left = 8
          Top = 120
          Width = 42
          Height = 12
          Caption = #20116#31561#22870':'
        end
        object Label48: TLabel
          Left = 8
          Top = 140
          Width = 42
          Height = 12
          Caption = #20845#31561#22870':'
        end
        object Label49: TLabel
          Left = 8
          Top = 18
          Width = 30
          Height = 12
          Caption = #22240#23376':'
        end
        object ScrollBarWinLottery1Max: TScrollBar
          Left = 56
          Top = 40
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWinLottery1MaxChange
        end
        object EditWinLottery1Max: TEdit
          Left = 192
          Top = 40
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWinLottery2Max: TScrollBar
          Left = 56
          Top = 60
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWinLottery2MaxChange
        end
        object EditWinLottery2Max: TEdit
          Left = 192
          Top = 60
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWinLottery3Max: TScrollBar
          Left = 56
          Top = 80
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWinLottery3MaxChange
        end
        object EditWinLottery3Max: TEdit
          Left = 192
          Top = 80
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWinLottery4Max: TScrollBar
          Left = 56
          Top = 100
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWinLottery4MaxChange
        end
        object EditWinLottery4Max: TEdit
          Left = 192
          Top = 100
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWinLottery5Max: TEdit
          Left = 192
          Top = 120
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWinLottery5Max: TScrollBar
          Left = 56
          Top = 120
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWinLottery5MaxChange
        end
        object ScrollBarWinLottery6Max: TScrollBar
          Left = 56
          Top = 140
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWinLottery6MaxChange
        end
        object EditWinLottery6Max: TEdit
          Left = 192
          Top = 140
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
        object EditWinLotteryRate: TEdit
          Left = 192
          Top = 16
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 12
        end
        object ScrollBarWinLotteryRate: TScrollBar
          Left = 56
          Top = 16
          Width = 129
          Height = 15
          Max = 100000
          PageSize = 0
          TabOrder = 13
          OnChange = ScrollBarWinLotteryRateChange
        end
      end
      object GroupBox28: TGroupBox
        Left = 288
        Top = 8
        Width = 145
        Height = 169
        Caption = #22870#37329
        TabOrder = 1
        object Label50: TLabel
          Left = 8
          Top = 18
          Width = 42
          Height = 12
          Caption = #19968#31561#22870':'
        end
        object Label51: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = #20108#31561#22870':'
        end
        object Label52: TLabel
          Left = 8
          Top = 66
          Width = 42
          Height = 12
          Caption = #19977#31561#22870':'
        end
        object Label53: TLabel
          Left = 8
          Top = 90
          Width = 42
          Height = 12
          Caption = #22235#31561#22870':'
        end
        object Label54: TLabel
          Left = 8
          Top = 114
          Width = 42
          Height = 12
          Caption = #20116#31561#22870':'
        end
        object Label55: TLabel
          Left = 8
          Top = 138
          Width = 42
          Height = 12
          Caption = #20845#31561#22870':'
        end
        object EditWinLottery1Gold: TSpinEdit
          Left = 56
          Top = 15
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 0
          Value = 100000000
          OnChange = EditWinLottery1GoldChange
        end
        object EditWinLottery2Gold: TSpinEdit
          Left = 56
          Top = 39
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditWinLottery2GoldChange
        end
        object EditWinLottery3Gold: TSpinEdit
          Left = 56
          Top = 63
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditWinLottery3GoldChange
        end
        object EditWinLottery4Gold: TSpinEdit
          Left = 56
          Top = 87
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditWinLottery4GoldChange
        end
        object EditWinLottery5Gold: TSpinEdit
          Left = 56
          Top = 111
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 4
          Value = 10
          OnChange = EditWinLottery5GoldChange
        end
        object EditWinLottery6Gold: TSpinEdit
          Left = 56
          Top = 135
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 5
          Value = 10
          OnChange = EditWinLottery6GoldChange
        end
      end
      object ButtonWinLotterySave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        ModalResult = 1
        TabOrder = 2
        OnClick = ButtonWinLotterySaveClick
      end
      object ButtonWinLotteryDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 3
        OnClick = ButtonWinLotteryDefaultClick
      end
    end
    object TabSheet40: TTabSheet
      Caption = #31048#31095#29983#25928
      ImageIndex = 11
      object GroupBox36: TGroupBox
        Left = 8
        Top = 9
        Width = 137
        Height = 89
        Caption = #31048#31095#29983#25928
        TabOrder = 0
        object Label94: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #29983#25928#26102#38271':'
        end
        object Label96: TLabel
          Left = 11
          Top = 64
          Width = 54
          Height = 12
          Caption = #33021#37327#20493#25968':'
          Enabled = False
        end
        object CheckBoxSpiritMutiny: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #21551#29992#31048#31095#29305#27530#21151#33021
          TabOrder = 0
          OnClick = CheckBoxSpiritMutinyClick
        end
        object EditSpiritMutinyTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditSpiritMutinyTimeChange
        end
        object EditSpiritPowerRate: TSpinEdit
          Left = 72
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditSpiritPowerRateChange
        end
      end
      object ButtonSpiritMutinySave: TButton
        Left = 360
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSpiritMutinySaveClick
      end
    end
    object TabSheet14: TTabSheet
      Caption = #29983#27963#25216#33021
      ImageIndex = 10
      object ButtonMakeMagicSave: TButton
        Left = 363
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = ButtonMakeMagicSaveClick
      end
      object GroupBox1: TGroupBox
        Left = 183
        Top = 6
        Width = 148
        Height = 158
        Caption = #22522#26412#21442#25968
        TabOrder = 1
        object Label1: TLabel
          Left = 12
          Top = 22
          Width = 54
          Height = 12
          Caption = #22686#21152#28857#25968':'
        end
        object Label113: TLabel
          Left = 12
          Top = 49
          Width = 54
          Height = 12
          Caption = #28040#32791#28857#25968':'
        end
        object Label114: TLabel
          Left = 12
          Top = 76
          Width = 54
          Height = 12
          Caption = #22686#21152#26426#29575':'
        end
        object Label115: TLabel
          Left = 12
          Top = 103
          Width = 54
          Height = 12
          Caption = #26368#39640#31561#32423':'
        end
        object lbl15: TLabel
          Left = 12
          Top = 129
          Width = 54
          Height = 12
          Caption = #36215#22987#31561#32423':'
        end
        object EditMakeMagicAddPoint: TSpinEdit
          Left = 73
          Top = 19
          Width = 49
          Height = 21
          Hint = #29609#23478#27599#21319#19968#32423#22686#21152#22810#23569#29983#27963#25216#33021#28857#25968#12290
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMakeMagicAddPointChange
        end
        object EditMakeMagicUsePoint: TSpinEdit
          Left = 73
          Top = 46
          Width = 49
          Height = 21
          Hint = #29609#23478#27599#22686#21152#19968#32423#29983#27963#25216#33021#28040#32791#30340#25216#33021#28857#25968#12290
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMakeMagicUsePointChange
        end
        object EditMakeMagicAddRate: TSpinEdit
          Left = 72
          Top = 73
          Width = 49
          Height = 21
          Hint = #29983#27963#25216#33021#27599#21319#19968#32423#22686#21152#22810#23569#25104#21151#26426#29575#12290#23454#38469#22686#21152#26426#29575' = '#25216#33021#31561#32423' / '#24403#21069#35774#32622' '
          EditorEnabled = False
          MaxValue = 200
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMakeMagicAddRateChange
        end
        object EditMakeMagicMaxLevel: TSpinEdit
          Left = 73
          Top = 100
          Width = 49
          Height = 21
          Hint = #29983#27963#25216#33021#26368#39640#21482#33021#22686#21152#21040#22810#23569#31561#32423
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMakeMagicMaxLevelChange
        end
        object seEditMakeMagicMaxBeginLevel: TSpinEdit
          Left = 73
          Top = 126
          Width = 49
          Height = 21
          Hint = #24403#20154#29289#31561#32423#36798#21040#25351#23450#31561#32423#26102#65292#25165#24320#22987#33258#21160#22686#21152#25216#33021#28857#12290
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = seEditMakeMagicMaxBeginLevelChange
        end
      end
      object grp15: TGroupBox
        Left = 8
        Top = 6
        Width = 169
        Height = 283
        Caption = #31561#32423#25511#21046
        TabOrder = 2
        object GridMakeMagic: TStringGrid
          Left = 10
          Top = 42
          Width = 149
          Height = 234
          ColCount = 2
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 12
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
          TabOrder = 0
          OnSetEditText = GridMakeMagicSetEditText
          ColWidths = (
            72
            71)
        end
        object ComboBoxMakeMagicType: TComboBox
          Left = 10
          Top = 17
          Width = 149
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 1
          Text = #25171#36896#27494#22120
          OnChange = ComboBoxMakeMagicTypeChange
          Items.Strings = (
            #25171#36896#27494#22120
            #25171#36896#26381#35013
            #25171#36896#22836#30420
            #25171#36896#39033#38142
            #25171#36896#25163#38255
            #25171#36896#25106#25351
            #25171#36896#33136#24102
            #25171#36896#38772#23376
            #25171#36896#33647#21697
            #25171#36896#26448#26009)
        end
      end
    end
    object TabSheet21: TTabSheet
      Caption = #23646#24615#28857
      ImageIndex = 11
      object GroupBox2: TGroupBox
        Left = 8
        Top = 6
        Width = 148
        Height = 83
        Caption = #22522#26412#21442#25968
        TabOrder = 0
        object Label118: TLabel
          Left = 12
          Top = 22
          Width = 54
          Height = 12
          Caption = #22686#21152#28857#25968':'
        end
        object Label124: TLabel
          Left = 12
          Top = 49
          Width = 54
          Height = 12
          Caption = #36215#22987#31561#32423':'
        end
        object EditNakedAddPoint: TSpinEdit
          Left = 73
          Top = 19
          Width = 49
          Height = 21
          Hint = #29609#23478#27599#21319#19968#32423#22686#21152#22810#23569#23646#24615#28857#28857#25968#12290
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditNakedAddPointChange
        end
        object EditNakedBeginLevel: TSpinEdit
          Left = 73
          Top = 46
          Width = 49
          Height = 21
          Hint = #24403#20154#29289#31561#32423#36798#21040#25351#23450#31561#32423#26102#65292#25165#24320#22987#33258#21160#22686#21152#23646#24615#28857#28857#25968#12290
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditNakedBeginLevelChange
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 95
        Width = 313
        Height = 186
        Caption = #21152#28857#35814#32454#35774#32622
        TabOrder = 1
        object Label121: TLabel
          Left = 12
          Top = 22
          Width = 36
          Height = 12
          Caption = #38450#24481'->'
        end
        object Label122: TLabel
          Left = 53
          Top = 22
          Width = 54
          Height = 12
          Caption = #28040#32791#28857#25968':'
        end
        object Label123: TLabel
          Left = 165
          Top = 22
          Width = 78
          Height = 12
          Caption = #22686#21152#19979#38480#28857#25968':'
        end
        object Label125: TLabel
          Left = 12
          Top = 49
          Width = 36
          Height = 12
          Caption = #39764#24481'->'
        end
        object Label126: TLabel
          Left = 53
          Top = 49
          Width = 54
          Height = 12
          Caption = #28040#32791#28857#25968':'
        end
        object Label127: TLabel
          Left = 165
          Top = 49
          Width = 78
          Height = 12
          Caption = #22686#21152#19979#38480#28857#25968':'
        end
        object Label128: TLabel
          Left = 12
          Top = 76
          Width = 36
          Height = 12
          Caption = #25915#20987'->'
        end
        object Label129: TLabel
          Left = 53
          Top = 76
          Width = 54
          Height = 12
          Caption = #28040#32791#28857#25968':'
        end
        object Label130: TLabel
          Left = 165
          Top = 76
          Width = 78
          Height = 12
          Caption = #22686#21152#19979#38480#28857#25968':'
        end
        object Label131: TLabel
          Left = 12
          Top = 103
          Width = 36
          Height = 12
          Caption = #39764#27861'->'
        end
        object Label132: TLabel
          Left = 53
          Top = 103
          Width = 54
          Height = 12
          Caption = #28040#32791#28857#25968':'
        end
        object Label133: TLabel
          Left = 165
          Top = 103
          Width = 78
          Height = 12
          Caption = #22686#21152#19979#38480#28857#25968':'
        end
        object Label134: TLabel
          Left = 12
          Top = 130
          Width = 36
          Height = 12
          Caption = #36947#26415'->'
        end
        object Label136: TLabel
          Left = 53
          Top = 130
          Width = 54
          Height = 12
          Caption = #28040#32791#28857#25968':'
        end
        object Label137: TLabel
          Left = 165
          Top = 130
          Width = 78
          Height = 12
          Caption = #22686#21152#19979#38480#28857#25968':'
        end
        object Label138: TLabel
          Left = 12
          Top = 157
          Width = 36
          Height = 12
          Caption = #29983#21629'->'
        end
        object Label139: TLabel
          Left = 53
          Top = 157
          Width = 54
          Height = 12
          Caption = #28040#32791#28857#25968':'
        end
        object EditNakedAc2Point: TSpinEdit
          Left = 113
          Top = 19
          Width = 49
          Height = 21
          Hint = #27599#22686#21152#19968#28857#38450#24481#28040#32791#23646#24615#28857#30340#25968#37327
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditNakedAc2PointChange
        end
        object EditNakedAcPoint: TSpinEdit
          Left = 249
          Top = 19
          Width = 49
          Height = 21
          Hint = #27599#28040#32791#24403#21069#35774#32622#30340#28857#25968#65292#22686#21152#19968#28857#38450#24481#19979#38480#12290
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditNakedAcPointChange
        end
        object EditNakedMac2Point: TSpinEdit
          Left = 113
          Top = 46
          Width = 49
          Height = 21
          Hint = #27599#22686#21152#19968#28857#39764#24481#28040#32791#23646#24615#28857#30340#25968#37327
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditNakedMac2PointChange
        end
        object EditNakedMacPoint: TSpinEdit
          Left = 249
          Top = 46
          Width = 49
          Height = 21
          Hint = #27599#28040#32791#24403#21069#35774#32622#30340#28857#25968#65292#22686#21152#19968#28857#39764#24481#19979#38480#12290
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditNakedMacPointChange
        end
        object EditNakedDc2Point: TSpinEdit
          Left = 113
          Top = 73
          Width = 49
          Height = 21
          Hint = #27599#22686#21152#19968#28857#25915#20987#28040#32791#23646#24615#28857#30340#25968#37327
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditNakedDc2PointChange
        end
        object EditNakedDcPoint: TSpinEdit
          Left = 249
          Top = 73
          Width = 49
          Height = 21
          Hint = #27599#28040#32791#24403#21069#35774#32622#30340#28857#25968#65292#22686#21152#19968#28857#25915#20987#19979#38480#12290
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditNakedDcPointChange
        end
        object EditNakedMC2Point: TSpinEdit
          Left = 113
          Top = 100
          Width = 49
          Height = 21
          Hint = #27599#22686#21152#19968#28857#39764#27861#28040#32791#23646#24615#28857#30340#25968#37327
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditNakedMC2PointChange
        end
        object EditNakedMCPoint: TSpinEdit
          Left = 249
          Top = 100
          Width = 49
          Height = 21
          Hint = #27599#28040#32791#24403#21069#35774#32622#30340#28857#25968#65292#22686#21152#19968#28857#39764#27861#19979#38480#12290
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditNakedMCPointChange
        end
        object EditNakedSC2Point: TSpinEdit
          Left = 113
          Top = 127
          Width = 49
          Height = 21
          Hint = #27599#22686#21152#19968#28857#36947#26415#28040#32791#23646#24615#28857#30340#25968#37327
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditNakedSC2PointChange
        end
        object EditNakedSCPoint: TSpinEdit
          Left = 249
          Top = 127
          Width = 49
          Height = 21
          Hint = #27599#28040#32791#24403#21069#35774#32622#30340#28857#25968#65292#22686#21152#19968#28857#36947#26415#19979#38480#12290
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 9
          Value = 100
          OnChange = EditNakedSCPointChange
        end
        object EditNakedHPPoint: TSpinEdit
          Left = 113
          Top = 154
          Width = 49
          Height = 21
          Hint = #27599#22686#21152#19968#28857#29983#21629#20540#28040#32791#23646#24615#28857#30340#25968#37327
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 10
          Value = 100
          OnChange = EditNakedHPPointChange
        end
      end
      object ButtonNakedSave: TButton
        Left = 363
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonNakedSaveClick
      end
    end
    object TabSheet22: TTabSheet
      Caption = #25991#37319#31995#32479
      ImageIndex = 12
      object GroupBox4: TGroupBox
        Left = 8
        Top = 6
        Width = 185
        Height = 283
        Caption = #32463#39564#20493#29575#25511#21046
        TabOrder = 0
        object GridLiterary: TStringGrid
          Left = 15
          Top = 22
          Width = 167
          Height = 258
          Hint = #32463#39564#20493#25968#65292'100 = 1'#20493
          ColCount = 2
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 31
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
          TabOrder = 0
          OnSetEditText = GridLiterarySetEditText
          ColWidths = (
            72
            71)
        end
      end
      object ButtonLiterarySave: TButton
        Left = 363
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonLiterarySaveClick
      end
    end
    object TabSheet23: TTabSheet
      Caption = #21151#33021#36873#39033
      ImageIndex = 13
      object GroupBox40: TGroupBox
        Left = 10
        Top = 6
        Width = 207
        Height = 114
        Caption = #23458#25143#31471#35774#32622
        TabOrder = 0
        object CheckBoxShowStrengthenInfo: TCheckBox
          Left = 13
          Top = 19
          Width = 168
          Height = 17
          Caption = #26159#21542#23436#25972#26174#31034#35013#22791#24378#21270#20449#24687
          TabOrder = 0
          OnClick = CheckBoxShowStrengthenInfoClick
        end
        object CheckBoxShowCBOForm: TCheckBox
          Left = 13
          Top = 41
          Width = 149
          Height = 17
          Caption = #26159#21542#26174#31034#36830#20987#25216#33021#38754#29256
          TabOrder = 1
          OnClick = CheckBoxShowCBOFormClick
        end
        object CheckBoxShowMakeMagicForm: TCheckBox
          Left = 13
          Top = 64
          Width = 149
          Height = 17
          Caption = #26159#21542#26174#31034#29983#27963#25216#33021#38754#29256
          TabOrder = 2
          OnClick = CheckBoxShowMakeMagicFormClick
        end
        object CheckBoxCancelDropItemHint: TCheckBox
          Left = 13
          Top = 88
          Width = 142
          Height = 17
          Hint = #36873#20013#21518#65292#23458#25143#25172#29289#21697#23558#19981#20877#24377#20986#30830#35748#31383#21475#12290#13#10#20294#22312#20132#26131#26102#20173#28982#20250#24377#20986#25552#31034#65292#38450#27490#35823#20173#29289#21697#65281
          Caption = #21462#28040#25172#29289#21697#24377#20986#30830#35748#26694
          TabOrder = 3
          OnClick = CheckBoxCancelDropItemHintClick
        end
      end
      object ButtonFunSave: TButton
        Left = 363
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonFunSaveClick
      end
      object GroupBox49: TGroupBox
        Left = 223
        Top = 6
        Width = 218
        Height = 92
        Caption = 'M2'#35774#32622
        TabOrder = 2
        object CheckBoxExpIsCumulative: TCheckBox
          Left = 13
          Top = 19
          Width = 150
          Height = 17
          Caption = #21452#20493#32463#39564#26102#38388#26159#21542#32047#21152
          TabOrder = 0
          OnClick = CheckBoxExpIsCumulativeClick
        end
        object CheckBoxExpOffLienSave: TCheckBox
          Left = 13
          Top = 41
          Width = 172
          Height = 17
          Caption = #21452#20493#32463#39564#26102#38388#19979#32447#26159#21542#20445#23384
          TabOrder = 1
          OnClick = CheckBoxExpOffLienSaveClick
        end
        object CheckBoxExpOffLineRunTime: TCheckBox
          Left = 35
          Top = 64
          Width = 142
          Height = 17
          Caption = #20445#23384#26159#21542#32487#32493#35745#31639#26102#38388
          TabOrder = 2
          OnClick = CheckBoxExpOffLineRunTimeClick
        end
      end
      object GroupBox54: TGroupBox
        Left = 10
        Top = 127
        Width = 207
        Height = 74
        Caption = #23458#25143#31471#20869#25346#35774#32622
        TabOrder = 3
        object CheckBoxWarLongWide: TCheckBox
          Left = 13
          Top = 19
          Width = 147
          Height = 17
          Caption = #26159#21542#20801#35768#25112#22763#38548#20301#21050#26432
          TabOrder = 0
          OnClick = CheckBoxWarLongWideClick
        end
        object CheckBoxNotShiftKey: TCheckBox
          Left = 13
          Top = 41
          Width = 149
          Height = 17
          Hint = #24403#20869#25346#36873#20013#20813'Shift'#38190#21518#65292#26159#21542#20813'Shift'#22987#32456#22788#20110#24320#21551#29366#24577#65292#19981#38656#35201#25353'Shift'#38190#26469#24320#20851#12290
          Caption = #26159#21542#21551#29992#31616#21333#20813'Shift'#38190
          TabOrder = 1
          OnClick = CheckBoxNotShiftKeyClick
        end
      end
    end
    object TabSheet41: TTabSheet
      Caption = #22352#39569
      ImageIndex = 14
      object GroupBox71: TGroupBox
        Left = 10
        Top = 6
        Width = 199
        Height = 75
        Caption = #26222#36890#22352#39569#36873#39033
        TabOrder = 0
        object Label175: TLabel
          Left = 12
          Top = 45
          Width = 78
          Height = 12
          Caption = #33719#24471#32463#39564#27604#20363':'
        end
        object Label180: TLabel
          Left = 151
          Top = 46
          Width = 6
          Height = 12
          Caption = '%'
        end
        object CheckBoxAllow32HorseGetExp: TCheckBox
          Left = 13
          Top = 19
          Width = 180
          Height = 17
          Hint = #24314#35758#24320#21551#35813#39033#65292#19981#28982#26222#36890#22352#39569#23558#26080#27861#21319#32423#33719#24471#32463#39564#12290
          Caption = #26159#21542#20801#35768#38750#39569#20056#29366#24577#33719#24471#32463#39564
          TabOrder = 0
          OnClick = CheckBoxAllow32HorseGetExpClick
        end
        object Edit32HorseGetExpRate: TSpinEdit
          Left = 96
          Top = 42
          Width = 49
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 999
          MinValue = 0
          TabOrder = 1
          Value = 20
          OnChange = Edit32HorseGetExpRateChange
        end
      end
      object ButtonSaveHorse: TButton
        Left = 363
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSaveHorseClick
      end
      object GroupBox72: TGroupBox
        Left = 10
        Top = 87
        Width = 199
        Height = 98
        Caption = #25112#39569#36873#39033
        TabOrder = 2
        object Label176: TLabel
          Left = 12
          Top = 45
          Width = 114
          Height = 12
          Caption = #38750#39569#20056#33719#24471#32463#39564#27604#20363':'
        end
        object Label177: TLabel
          Left = 12
          Top = 72
          Width = 102
          Height = 12
          Caption = #39569#20056#33719#24471#32463#39564#27604#20363':'
        end
        object Label181: TLabel
          Left = 187
          Top = 46
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label182: TLabel
          Left = 187
          Top = 73
          Width = 6
          Height = 12
          Caption = '%'
        end
        object CheckBoxAllow33HorseGetExp: TCheckBox
          Left = 13
          Top = 19
          Width = 180
          Height = 17
          Hint = #25112#39569#21487#20197#25915#20987#26432#24618#33719#24471#32463#39564#65292#26159#21542#20801#35768#35831#33258#34892#22788#29702#12290
          Caption = #26159#21542#20801#35768#38750#39569#20056#29366#24577#33719#24471#32463#39564
          TabOrder = 0
          OnClick = CheckBoxAllow33HorseGetExpClick
        end
        object Edit33HorseGetExpRate: TSpinEdit
          Left = 132
          Top = 42
          Width = 49
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 999
          MinValue = 0
          TabOrder = 1
          Value = 20
          OnChange = Edit33HorseGetExpRateChange
        end
        object Edit33HorseGetExpRate2: TSpinEdit
          Left = 132
          Top = 69
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 999
          MinValue = 0
          TabOrder = 2
          Value = 20
          OnChange = Edit33HorseGetExpRate2Change
        end
      end
      object GroupBox73: TGroupBox
        Left = 215
        Top = 6
        Width = 199
        Height = 75
        Caption = #20849#29992#22352#39569#36873#39033
        TabOrder = 3
        object Label178: TLabel
          Left = 12
          Top = 22
          Width = 102
          Height = 12
          Caption = #22352#39569#27515#20129#22797#27963#26102#38388':'
        end
        object Label179: TLabel
          Left = 167
          Top = 23
          Width = 24
          Height = 12
          Caption = #20998#38047
        end
        object Label183: TLabel
          Left = 12
          Top = 45
          Width = 78
          Height = 12
          Caption = #19978#39532#20934#22791#26102#38388':'
        end
        object Label184: TLabel
          Left = 167
          Top = 46
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditHorseAliveTime: TSpinEdit
          Left = 120
          Top = 19
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditHorseAliveTimeChange
        end
        object EditTakeOnHorseUseTime: TSpinEdit
          Left = 96
          Top = 42
          Width = 65
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditTakeOnHorseUseTimeChange
        end
      end
      object GroupBox74: TGroupBox
        Left = 215
        Top = 88
        Width = 199
        Height = 97
        Caption = #39535#21270#22352#39569#36873#39033
        TabOrder = 4
        object Label185: TLabel
          Left = 12
          Top = 22
          Width = 78
          Height = 12
          Caption = #39535#21270#25104#21151#26426#29575':'
        end
        object EditDomesticationRate: TSpinEdit
          Left = 96
          Top = 19
          Width = 46
          Height = 21
          Hint = #25968#23383#36234#22823#25104#21151#26426#29575#36234#22823
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditDomesticationRateChange
        end
        object CheckBoxDomesticationUseWeapon: TCheckBox
          Left = 12
          Top = 44
          Width = 149
          Height = 17
          Hint = #19987#29992#39535#21270#27494#22120#30340'Stdmode = 9'
          Caption = #24517#38656#35013#22791#39535#21270#19987#29992#27494#22120
          TabOrder = 1
          OnClick = CheckBoxDomesticationUseWeaponClick
        end
        object CheckBoxDomesticationCheckLevel: TCheckBox
          Left = 12
          Top = 64
          Width = 165
          Height = 17
          Caption = #29609#23478#31561#32423#24517#38656#39640#20110#24618#29289#31561#32423
          TabOrder = 2
          OnClick = CheckBoxDomesticationCheckLevelClick
        end
      end
    end
  end
end
