object frmItemSet: TfrmItemSet
  Left = 457
  Top = 335
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #29305#27530#23646#24615#29289#21697#35774#32622
  ClientHeight = 329
  ClientWidth = 505
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
  object PageControl: TPageControl
    Left = 8
    Top = 8
    Width = 489
    Height = 313
    ActivePage = TabSheet8
    TabOrder = 0
    object TabSheet8: TTabSheet
      Caption = #29305#27530#23646#24615
      object ItemSetPageControl: TPageControl
        Left = 8
        Top = 4
        Width = 465
        Height = 245
        ActivePage = TabSheet22
        MultiLine = True
        TabOrder = 0
        object TabSheet22: TTabSheet
          Caption = #22522#26412#36873#39033
          ImageIndex = 5
          object GroupBox82: TGroupBox
            Left = 3
            Top = 3
            Width = 126
            Height = 70
            Caption = #22522#26412#35774#32622
            TabOrder = 0
            object CheckBoxOpenArmStrengthen: TCheckBox
              Left = 16
              Top = 16
              Width = 97
              Height = 17
              Caption = #24320#21551#24378#21270#21151#33021
              TabOrder = 0
              OnClick = CheckBoxOpenArmStrengthenClick
            end
            object CheckBoxOpenItemFlute: TCheckBox
              Left = 16
              Top = 39
              Width = 97
              Height = 17
              Caption = #24320#21551#20985#27133#21151#33021
              TabOrder = 1
              OnClick = CheckBoxOpenItemFluteClick
            end
          end
          object GroupBox83: TGroupBox
            Left = 3
            Top = 80
            Width = 126
            Height = 70
            Caption = #23646#24615#36716#31227
            TabOrder = 1
            object Label234: TLabel
              Left = 8
              Top = 20
              Width = 54
              Height = 12
              Caption = #22522#30784#20960#29575':'
            end
            object Label235: TLabel
              Left = 8
              Top = 43
              Width = 54
              Height = 12
              Caption = #38656#35201#37329#24065':'
            end
            object EditAbilityMoveBaseRate: TSpinEdit
              Left = 64
              Top = 16
              Width = 60
              Height = 21
              MaxValue = 100
              MinValue = 0
              TabOrder = 0
              Value = 20
              OnChange = EditAbilityMoveBaseRateChange
            end
            object EditAbilityMoveGold: TSpinEdit
              Left = 64
              Top = 39
              Width = 60
              Height = 21
              MaxValue = 0
              MinValue = 0
              TabOrder = 1
              Value = 0
              OnChange = EditAbilityMoveGoldChange
            end
          end
        end
        object TabSheet1: TTabSheet
          Caption = #32463#39564#32763#20493
          object GroupBox141: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 201
            Caption = #32463#39564#32763#20493
            TabOrder = 0
            object Label108: TLabel
              Left = 11
              Top = 24
              Width = 30
              Height = 12
              Caption = #20493#29575':'
            end
            object Label109: TLabel
              Left = 8
              Top = 144
              Width = 353
              Height = 49
              AutoSize = False
              Caption = 
                #20493#29575#20197#25345#20037#20026#26631#20934#65292#38500#20197#35774#23450#20540#65292#20026#27491#30495#30340#20493#29575#65292#29289#21697#26368#39640#25345#20037#20026'65'#65292#20063#23601#26159'65000'#28857#65292#20197#27492#25345#20037#26469#31639#38500#20197#35774#32622#30340#25968#23383#23601#26159#20493#25968#20102#65292#22914#26524#35774 +
                #32622#20026'10000'#65292#21017#20026' 6.5'#20493#32463#39564#12290#22914#26524#36523#19978#24102#20102#22810#20010#27492#23646#24615#35013#22791#65292#20493#29575#26159#32047#21152#30340#12290
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object EditItemExpRate: TSpinEdit
              Left = 56
              Top = 20
              Width = 57
              Height = 21
              EditorEnabled = False
              MaxValue = 60000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditItemExpRateChange
            end
            object GroupBox1: TGroupBox
              Left = 160
              Top = 16
              Width = 201
              Height = 81
              Caption = #25968#25454#24211#35774#32622#32534#21495' [141]'
              TabOrder = 1
              object Label1: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = #27494#22120#12289#34593#28891#31867#20351#29992#23383#27573': AniCount'
              end
              object Label2: TLabel
                Left = 8
                Top = 32
                Width = 126
                Height = 12
                Caption = #39318#39280#31867#20351#29992#23383#27573': Shape'
              end
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #25915#20987#32763#20493
          ImageIndex = 1
          object GroupBox142: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 201
            Caption = #25915#20987#32763#20493
            TabOrder = 0
            object Label110: TLabel
              Left = 11
              Top = 24
              Width = 30
              Height = 12
              Caption = #20493#29575':'
            end
            object Label3: TLabel
              Left = 8
              Top = 144
              Width = 353
              Height = 49
              AutoSize = False
              Caption = 
                #20493#29575#20197#25345#20037#20026#26631#20934#65292#38500#20197#35774#23450#20540#65292#20026#27491#30495#30340#20493#29575#65292#29289#21697#26368#39640#25345#20037#20026'65'#65292#20063#23601#26159'65000'#28857#65292#20197#27492#25345#20037#26469#31639#38500#20197#35774#32622#30340#25968#23383#23601#26159#20493#25968#20102#65292#22914#26524#35774 +
                #32622#20026'10000'#65292#21017#20026' 6.5'#20493#32463#39564#12290#22914#26524#36523#19978#24102#20102#22810#20010#27492#23646#24615#35013#22791#65292#20493#29575#26159#32047#21152#30340#12290
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object EditItemPowerRate: TSpinEdit
              Left = 56
              Top = 20
              Width = 57
              Height = 21
              EditorEnabled = False
              MaxValue = 60000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditItemPowerRateChange
            end
            object GroupBox2: TGroupBox
              Left = 160
              Top = 16
              Width = 201
              Height = 81
              Caption = #25968#25454#24211#35774#32622#32534#21495' [142]'
              TabOrder = 1
              object Label4: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = #27494#22120#12289#34593#28891#31867#20351#29992#23383#27573': AniCount'
              end
              object Label5: TLabel
                Left = 8
                Top = 32
                Width = 126
                Height = 12
                Caption = #39318#39280#31867#20351#29992#23383#27573': Shape'
              end
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = #34892#20250#20256#36865
          ImageIndex = 3
          object GroupBox28: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 201
            Caption = #34892#20250#20256#36865
            TabOrder = 0
            object Label85: TLabel
              Left = 11
              Top = 24
              Width = 54
              Height = 12
              Caption = #20351#29992#38388#38548':'
            end
            object Label86: TLabel
              Left = 8
              Top = 144
              Width = 353
              Height = 49
              AutoSize = False
              Caption = #34892#20250#20256#36865#29289#21697#65292#34892#20250#25484#38376#20154#25165#33021#20351#29992#65292#23558#25972#20010#34892#20250#25104#21592#20840#37096#38598#20013#20110#20256#36865#25484#38376#20154#36523#36793#12290#34987#20256#36865#25104#21592#65292#24517#39035#20351#29992#21629#20196#20801#35768#34892#20250#20256#36865#12290
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object EditGuildRecallTime: TSpinEdit
              Left = 72
              Top = 20
              Width = 57
              Height = 21
              Hint = #37325#22797#20351#29992#27492#21151#33021#65292#25152#38656#38388#38548#26102#38388#12290#27492#35774#32622#20462#25913#21518#19981#33021#31435#21363#29983#25928#65292#38656#22312#19979#27425#20351#29992#26102#29983#25928#12290
              EditorEnabled = False
              MaxValue = 60000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditGuildRecallTimeChange
            end
            object GroupBox29: TGroupBox
              Left = 160
              Top = 16
              Width = 201
              Height = 81
              Caption = #25968#25454#24211#35774#32622#32534#21495' [145]'
              TabOrder = 1
              object Label87: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = #27494#22120#12289#34593#28891#31867#20351#29992#23383#27573': AniCount'
              end
              object Label88: TLabel
                Left = 8
                Top = 32
                Width = 126
                Height = 12
                Caption = #39318#39280#31867#20351#29992#23383#27573': Shape'
              end
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = #40635#30201#25915#20987
          ImageIndex = 4
          object GroupBox44: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 201
            Caption = #32463#39564#32763#20493
            TabOrder = 0
            object GroupBox45: TGroupBox
              Left = 165
              Top = 16
              Width = 194
              Height = 81
              Caption = #25968#25454#24211#35774#32622#32534#21495' [113]'
              TabOrder = 0
              object Label122: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = #27494#22120#12289#34593#28891#31867#20351#29992#23383#27573': AniCount'
              end
              object Label123: TLabel
                Left = 8
                Top = 32
                Width = 126
                Height = 12
                Caption = #39318#39280#31867#20351#29992#23383#27573': Shape'
              end
            end
            object GroupBox42: TGroupBox
              Left = 8
              Top = 16
              Width = 150
              Height = 81
              Caption = #21442#25968
              TabOrder = 1
              object Label120: TLabel
                Left = 11
                Top = 24
                Width = 54
                Height = 12
                Caption = #40635#30201#26426#29575':'
              end
              object Label116: TLabel
                Left = 11
                Top = 48
                Width = 54
                Height = 12
                Caption = #40635#30201#26102#38388':'
              end
              object Label124: TLabel
                Left = 131
                Top = 48
                Width = 12
                Height = 12
                Caption = #31186
              end
              object EditAttackPosionRate: TSpinEdit
                Left = 72
                Top = 20
                Width = 49
                Height = 21
                Hint = #40635#30201#25104#21151#26426#29575#65292#25968#23383#36234#23567#26426#29575#36234#22823#65292#27492#35774#32622#40664#35748#20026'5'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 0
                Value = 100
                OnChange = EditAttackPosionRateChange
              end
              object EditAttackPosionTime: TSpinEdit
                Left = 72
                Top = 44
                Width = 49
                Height = 21
                Hint = #40635#30201#26102#38388#38271#24230#65292#21333#20301#31186#65292#40664#35748#35774#32622#20026'6'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 1
                Value = 100
                OnChange = EditAttackPosionTimeChange
              end
            end
          end
        end
        object TabSheet6: TTabSheet
          Caption = #20256#36865
          ImageIndex = 5
          object GroupBox43: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 201
            Caption = #20256#36865
            TabOrder = 0
            object GroupBox46: TGroupBox
              Left = 165
              Top = 16
              Width = 194
              Height = 81
              Caption = #25968#25454#24211#35774#32622#32534#21495' [112]'
              TabOrder = 0
              object Label117: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = #27494#22120#12289#34593#28891#31867#20351#29992#23383#27573': AniCount'
              end
              object Label118: TLabel
                Left = 8
                Top = 32
                Width = 126
                Height = 12
                Caption = #39318#39280#31867#20351#29992#23383#27573': Shape'
              end
            end
            object GroupBox47: TGroupBox
              Left = 8
              Top = 16
              Width = 150
              Height = 81
              Caption = #21442#25968
              TabOrder = 1
              object Label119: TLabel
                Left = 11
                Top = 56
                Width = 54
                Height = 12
                Caption = #20351#29992#38388#38548':'
              end
              object Label121: TLabel
                Left = 123
                Top = 56
                Width = 12
                Height = 12
                Caption = #31186
              end
              object CheckBoxUserMoveCanDupObj: TCheckBox
                Left = 8
                Top = 16
                Width = 137
                Height = 17
                Hint = #20851#38381#27492#36873#39033#21518#65292#20256#36865#24231#26631#19978#26377#35282#33394#26102#23558#19981#20801#35768#20256#36865
                Caption = #20801#35768#20256#36865#35282#33394#37325#21472
                TabOrder = 0
                OnClick = CheckBoxUserMoveCanDupObjClick
              end
              object CheckBoxUserMoveCanOnItem: TCheckBox
                Left = 8
                Top = 32
                Width = 137
                Height = 17
                Hint = #20851#38381#27492#36873#39033#21518#65292#20256#36865#24231#26631#19978#26377#29289#21697#26102#23558#19981#20801#35768#20256#36865
                Caption = #20801#35768#20256#36865#29289#21697#37325#21472
                TabOrder = 1
                OnClick = CheckBoxUserMoveCanOnItemClick
              end
              object EditUserMoveTime: TSpinEdit
                Left = 72
                Top = 52
                Width = 49
                Height = 21
                Hint = #20256#36865#21629#20196#20351#29992#38388#38548#26102#38388
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 2
                Value = 100
                OnChange = EditUserMoveTimeChange
              end
            end
          end
        end
      end
      object ButtonItemSetSave: TButton
        Left = 396
        Top = 255
        Width = 77
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonItemSetSaveClick
      end
    end
    object TabSheet9: TTabSheet
      Caption = #26497#21697#26426#29575
      ImageIndex = 1
      object AddValuePageControl: TPageControl
        Left = 8
        Top = 4
        Width = 465
        Height = 245
        ActivePage = TabSheet11
        MultiLine = True
        TabOrder = 0
        object TabSheet10: TTabSheet
          Caption = #26426#29575#25511#21046
          object GroupBox3: TGroupBox
            Left = 8
            Top = 8
            Width = 225
            Height = 102
            Caption = #26497#21697#20986#29616#26426#29575
            TabOrder = 0
            object Label6: TLabel
              Left = 11
              Top = 24
              Width = 54
              Height = 12
              Caption = #24618#29289#25481#33853':'
            end
            object Label7: TLabel
              Left = 11
              Top = 48
              Width = 54
              Height = 12
              Caption = #21629#20196#21046#36896':'
            end
            object Label125: TLabel
              Left = 11
              Top = 73
              Width = 54
              Height = 12
              Caption = #33050#26412#25171#36896':'
            end
            object EditMonRandomAddValue: TSpinEdit
              Left = 72
              Top = 20
              Width = 57
              Height = 21
              Hint = #24618#29289#27515#20129#25481#33853#29289#21697#26497#21697#20986#29616#26426#29575#65292#25968#25454#36234#22823#65292#26426#29575#36234#23567#12290
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditMonRandomAddValueChange
            end
            object EditMakeRandomAddValue: TSpinEdit
              Left = 72
              Top = 44
              Width = 57
              Height = 21
              Hint = 'GM'#21629#20196#21046#36896#29289#21697#26497#21697#20986#29616#26426#29575#65292#25968#25454#36234#22823#65292#26426#29575#36234#23567#12290
              MaxValue = 10000
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMakeRandomAddValueChange
            end
            object EditNpcMakeRandomAddValue: TSpinEdit
              Left = 72
              Top = 69
              Width = 57
              Height = 21
              Hint = 'NPC'#25171#36896#30340#29289#21697#26497#21697#20986#29616#26426#29575#65292#25968#25454#36234#22823#65292#26426#29575#36234#23567#12290
              MaxValue = 10000
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNpcMakeRandomAddValueChange
            end
            object CheckBoxMonRandom: TCheckBox
              Left = 135
              Top = 22
              Width = 82
              Height = 17
              Hint = #26497#21697#29289#21697#26159#21542#30452#25509#24320#20809#65292#32780#19981#38656#35201#25214'NPC'#24320#20809#12290
              Caption = #26159#21542#24050#24320#20809
              TabOrder = 3
              OnClick = CheckBoxMonRandomClick
            end
            object CheckBoxMakeRandom: TCheckBox
              Left = 135
              Top = 47
              Width = 82
              Height = 17
              Hint = #26497#21697#29289#21697#26159#21542#30452#25509#24320#20809#65292#32780#19981#38656#35201#25214'NPC'#24320#20809#12290
              Caption = #26159#21542#24050#24320#20809
              TabOrder = 4
              OnClick = CheckBoxMakeRandomClick
            end
            object CheckBoxNpcMakeRandom: TCheckBox
              Left = 135
              Top = 71
              Width = 82
              Height = 17
              Hint = #26497#21697#29289#21697#26159#21542#30452#25509#24320#20809#65292#32780#19981#38656#35201#25214'NPC'#24320#20809#12290
              Caption = #26159#21542#24050#24320#20809
              TabOrder = 5
              OnClick = CheckBoxNpcMakeRandomClick
            end
          end
          object GroupBox60: TGroupBox
            Left = 239
            Top = 8
            Width = 137
            Height = 102
            Caption = #20985#27133#20986#29616#26426#29575
            TabOrder = 1
            object Label169: TLabel
              Left = 11
              Top = 24
              Width = 42
              Height = 12
              Caption = #20985#27133#19968':'
            end
            object Label170: TLabel
              Left = 11
              Top = 48
              Width = 42
              Height = 12
              Caption = #20985#27133#20108':'
            end
            object Label171: TLabel
              Left = 11
              Top = 73
              Width = 42
              Height = 12
              Caption = #20985#27133#19977':'
            end
            object EditFlute1Rate: TSpinEdit
              Left = 72
              Top = 20
              Width = 57
              Height = 21
              Hint = #29289#21697#24320#20809#21518#20985#27133#20986#29616#26426#29575#65292#25968#25454#36234#22823#65292#26426#29575#36234#23567#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditFlute1RateChange
            end
            object EditFlute2Rate: TSpinEdit
              Left = 72
              Top = 44
              Width = 57
              Height = 21
              Hint = #29289#21697#24320#20809#21518#20985#27133#20986#29616#26426#29575#65292#25968#25454#36234#22823#65292#26426#29575#36234#23567#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditFlute2RateChange
            end
            object EditFlute3Rate: TSpinEdit
              Left = 72
              Top = 69
              Width = 57
              Height = 21
              Hint = #29289#21697#24320#20809#21518#20985#27133#20986#29616#26426#29575#65292#25968#25454#36234#22823#65292#26426#29575#36234#23567#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditFlute3RateChange
            end
          end
          object GroupBox61: TGroupBox
            Left = 8
            Top = 116
            Width = 137
            Height = 77
            Caption = #20116#34892#26426#29575
            TabOrder = 2
            object Label172: TLabel
              Left = 11
              Top = 24
              Width = 54
              Height = 12
              Caption = #26368#20302#28857#25968':'
            end
            object Label173: TLabel
              Left = 11
              Top = 48
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object EditWuXinMinRate: TSpinEdit
              Left = 72
              Top = 20
              Width = 57
              Height = 21
              Hint = #20116#34892#23646#24615#20986#29616#26368#20302#28857#25968
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWuXinMinRateChange
            end
            object EditWuXinMaxRate: TSpinEdit
              Left = 72
              Top = 44
              Width = 57
              Height = 21
              Hint = #20116#34892#23646#24615#20986#29616#26368#39640#28857#25968
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWuXinMaxRateChange
            end
          end
        end
        object TabSheet18: TTabSheet
          Caption = #22836#30420
          ImageIndex = 8
          object GroupBox7: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label14: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label15: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label16: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
          object GroupBox8: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label17: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label18: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label19: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
          object GroupBox9: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 2
            object Label20: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label21: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label22: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
          object GroupBox10: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 3
            object Label23: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label24: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label25: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
          object GroupBox11: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 4
            object Label26: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label27: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label28: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
          object GroupBox12: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 5
            object Label29: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label30: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label31: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet11: TTabSheet
          Caption = #27494#22120
          ImageIndex = 1
          object GroupBox4: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 0
            object Label8: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label9: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label130: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditWeaponDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
          object GroupBox5: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 1
            object Label10: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label11: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label131: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditWeaponMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
          object GroupBox6: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 2
            object Label12: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label13: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label133: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditWeaponSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
          object GroupBox48: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 3
            object Label126: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label127: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label32: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditWeaponACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
          object GroupBox52: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 4
            object Label128: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label129: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label132: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditWeaponMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
          object GroupBox53: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 5
            object Label134: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label135: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label136: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditWeaponCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet12: TTabSheet
          Caption = #34915#26381
          ImageIndex = 2
          object GroupBox13: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label33: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label34: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label35: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
          object GroupBox14: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label36: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label37: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label38: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
          object GroupBox15: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 2
            object Label39: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label40: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label41: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
          object GroupBox16: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 3
            object Label42: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label43: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label44: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
          object GroupBox17: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 4
            object Label45: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label46: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label47: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
          object GroupBox18: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 5
            object Label48: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label49: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label50: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet13: TTabSheet
          Caption = #39033#38142
          ImageIndex = 3
          object GroupBox19: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label51: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label52: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label53: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
          object GroupBox20: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label54: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label55: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label56: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
          object GroupBox21: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 2
            object Label57: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label58: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label59: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
          object GroupBox22: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 3
            object Label60: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label61: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label62: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
          object GroupBox23: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 4
            object Label63: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label64: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label65: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
          object GroupBox24: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 5
            object Label66: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label67: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label68: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet15: TTabSheet
          Caption = #25163#38255
          ImageIndex = 5
          object GroupBox25: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label69: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label70: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label71: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmRingACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
          object GroupBox26: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label72: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label73: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label74: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmRingMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
          object GroupBox27: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 2
            object Label75: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label76: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label77: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmRingCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
          object GroupBox30: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 3
            object Label78: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label79: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label80: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmRingDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
          object GroupBox31: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 4
            object Label81: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label82: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label83: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmRingMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
          object GroupBox32: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 5
            object Label84: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label89: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label90: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmRingSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet16: TTabSheet
          Caption = #25106#25351
          ImageIndex = 6
          object GroupBox33: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label91: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label92: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label93: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
          object GroupBox34: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label94: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label95: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label96: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
          object GroupBox35: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 2
            object Label97: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label98: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label99: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
          object GroupBox36: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 3
            object Label100: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label101: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label102: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
          object GroupBox37: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 4
            object Label103: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label104: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label105: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
          object GroupBox38: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 5
            object Label106: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label107: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label111: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet3: TTabSheet
          Caption = #33136#24102
          ImageIndex = 7
          object GroupBox39: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label112: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label113: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label114: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBeltACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
          object GroupBox40: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label115: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label137: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label138: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBeltMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 13
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
          object GroupBox41: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 2
            object Label139: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label140: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label141: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBeltCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
          object GroupBox49: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 3
            object Label142: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label143: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label144: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBeltDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
          object GroupBox50: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 4
            object Label145: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label146: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label147: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBeltMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
          object GroupBox51: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 5
            object Label148: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label149: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label150: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBeltSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = #38772#23376
          ImageIndex = 8
          object GroupBox54: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label151: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label152: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label153: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBootACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
          object GroupBox55: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label154: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label155: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label156: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBootMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
          object GroupBox56: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 2
            object Label157: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label158: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label159: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBootCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
          object GroupBox57: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 3
            object Label160: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label161: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label162: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBootDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
          object GroupBox58: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 4
            object Label163: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label164: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label165: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBootMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
          object GroupBox59: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 5
            object Label166: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label167: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label168: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBootSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet14: TTabSheet
          Caption = #22352#39569#32560#32499
          ImageIndex = 9
          object GroupBox78: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label222: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label223: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label224: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditReinACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
          end
          object GroupBox79: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label225: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label226: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label227: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditReinMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
          end
          object GroupBox80: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #25915#20987
            TabOrder = 2
            object Label228: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label229: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label230: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditReinDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
          end
          object GroupBox81: TGroupBox
            Left = 8
            Top = 102
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 3
            object Label231: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label232: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label233: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditReinCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet17: TTabSheet
          Caption = #22352#39569#38083#38107
          ImageIndex = 10
          object GroupBox62: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label174: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label175: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label176: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBellACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
          end
          object GroupBox63: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label177: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label178: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label179: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBellMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
          end
          object GroupBox64: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #25915#20987
            TabOrder = 2
            object Label180: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label181: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label182: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBellDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
          end
          object GroupBox65: TGroupBox
            Left = 8
            Top = 102
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 3
            object Label183: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label184: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label185: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBellCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet19: TTabSheet
          Caption = #22352#39569#39532#38797
          ImageIndex = 11
          object GroupBox66: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label186: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label187: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label188: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditSaddleACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
          end
          object GroupBox67: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label189: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label190: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label191: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditSaddleMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
          end
          object GroupBox68: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #25915#20987
            TabOrder = 2
            object Label192: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label193: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label194: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditSaddleDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
          end
          object GroupBox69: TGroupBox
            Left = 8
            Top = 102
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 3
            object Label195: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label196: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label197: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditSaddleCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet20: TTabSheet
          Caption = #22352#39569#35013#39280
          ImageIndex = 12
          object GroupBox70: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label198: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label199: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label200: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDecorationACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
          end
          object GroupBox71: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label201: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label202: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label203: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDecorationMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
          end
          object GroupBox72: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #25915#20987
            TabOrder = 2
            object Label204: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label205: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label206: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDecorationDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
          end
          object GroupBox73: TGroupBox
            Left = 8
            Top = 102
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 3
            object Label207: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label208: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label209: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDecorationCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet21: TTabSheet
          Caption = #22352#39569#33050#38025
          ImageIndex = 13
          object GroupBox74: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = #38450#24481
            TabOrder = 0
            object Label210: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label211: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label212: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNailACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
          end
          object GroupBox75: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = #39764#24481
            TabOrder = 1
            object Label213: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label214: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label215: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNailMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
          end
          object GroupBox76: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = #25915#20987
            TabOrder = 2
            object Label216: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label217: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label218: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNailDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
          end
          object GroupBox77: TGroupBox
            Left = 8
            Top = 102
            Width = 113
            Height = 88
            Caption = #29305#27530
            TabOrder = 3
            object Label219: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label220: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label221: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNailCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
          end
        end
      end
      object ButtonAddValueSave: TButton
        Left = 396
        Top = 255
        Width = 77
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonAddValueSaveClick
      end
    end
  end
end
