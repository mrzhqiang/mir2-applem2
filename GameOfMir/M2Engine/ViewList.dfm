object frmViewList: TfrmViewList
  Left = 242
  Top = 196
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26597#30475#21015#34920#20449#24687
  ClientHeight = 504
  ClientWidth = 915
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
  object PageControl1: TPageControl
    Left = 8
    Top = 9
    Width = 899
    Height = 488
    ActivePage = TabSheet15
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet15: TTabSheet
      Caption = #28216#25103#21015#34920
      object PageControlViewList: TPageControl
        Left = 3
        Top = 3
        Width = 694
        Height = 368
        ActivePage = TabSheet10
        TabOrder = 0
        object TabSheet10: TTabSheet
          Caption = #31649#29702#21592#21015#34920
          ImageIndex = 10
          object GroupBox12: TGroupBox
            Left = 8
            Top = 4
            Width = 180
            Height = 334
            Caption = #31649#29702#21592#21015#34920
            TabOrder = 0
            object ListBoxAdminList: TListBox
              Left = 8
              Top = 16
              Width = 161
              Height = 310
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxAdminListClick
            end
          end
          object GroupBox15: TGroupBox
            Left = 194
            Top = 4
            Width = 175
            Height = 181
            Caption = #31649#29702#21592#20449#24687
            TabOrder = 1
            object Label4: TLabel
              Left = 9
              Top = 20
              Width = 54
              Height = 12
              Caption = #35282#33394#21517#31216':'
            end
            object Label5: TLabel
              Left = 9
              Top = 44
              Width = 54
              Height = 12
              Caption = #35282#33394#31561#32423':'
            end
            object LabelAdminIPaddr: TLabel
              Left = 9
              Top = 68
              Width = 42
              Height = 12
              Caption = #30331#24405'IP:'
            end
            object EditAdminName: TEdit
              Left = 65
              Top = 16
              Width = 97
              Height = 20
              TabOrder = 0
            end
            object EditAdminPremission: TSpinEdit
              Left = 65
              Top = 39
              Width = 61
              Height = 21
              MaxValue = 10
              MinValue = 1
              TabOrder = 1
              Value = 10
            end
            object ButtonAdminListAdd: TButton
              Left = 10
              Top = 104
              Width = 70
              Height = 25
              Caption = #22686#21152'(&A)'
              TabOrder = 2
              OnClick = ButtonAdminListAddClick
            end
            object ButtonAdminListChange: TButton
              Left = 91
              Top = 104
              Width = 70
              Height = 25
              Caption = #20462#25913'(&M)'
              TabOrder = 3
              OnClick = ButtonAdminListChangeClick
            end
            object ButtonAdminListDel: TButton
              Left = 10
              Top = 138
              Width = 70
              Height = 25
              Caption = #21024#38500'(&D)'
              TabOrder = 4
              OnClick = ButtonAdminListDelClick
            end
            object EditAdminIPaddr: TEdit
              Left = 65
              Top = 64
              Width = 97
              Height = 20
              TabOrder = 5
            end
            object ButtonAdminLitsSave: TButton
              Left = 91
              Top = 138
              Width = 70
              Height = 25
              Caption = #20445#23384'(&S)'
              TabOrder = 6
              OnClick = ButtonAdminLitsSaveClick
            end
          end
        end
        object TabSheet8: TTabSheet
          Hint = #28216#25103#26085#24535#36807#28388#65292#21487#20197#25351#23450#35760#24405#37027#20123#29289#21697#20135#29983#30340#26085#24535#65292#20174#32780#20943#23569#26085#24535#30340#22823#23567#12290
          Caption = #28216#25103#26085#24535#36807#28388
          ImageIndex = 8
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object GroupBox8: TGroupBox
            Left = 288
            Top = 4
            Width = 177
            Height = 334
            Caption = #35760#24405#29289#21697'(Ctrl+F'#26597#25214')'
            TabOrder = 0
            object ListBoxGameLogList: TListBox
              Left = 8
              Top = 16
              Width = 161
              Height = 309
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxGameLogListClick
              OnKeyDown = ListBox1KeyDown
            end
          end
          object ButtonGameLogAdd: TButton
            Left = 200
            Top = 24
            Width = 73
            Height = 25
            Caption = #22686#21152'(&A)'
            TabOrder = 1
            OnClick = ButtonGameLogAddClick
          end
          object ButtonGameLogDel: TButton
            Left = 200
            Top = 56
            Width = 73
            Height = 25
            Caption = #21024#38500'(&D)'
            TabOrder = 2
            OnClick = ButtonGameLogDelClick
          end
          object ButtonGameLogAddAll: TButton
            Left = 200
            Top = 88
            Width = 73
            Height = 25
            Caption = #20840#37096#22686#21152'(&A)'
            TabOrder = 3
            OnClick = ButtonGameLogAddAllClick
          end
          object ButtonGameLogDelAll: TButton
            Left = 200
            Top = 120
            Width = 73
            Height = 25
            Caption = #20840#37096#21024#38500'(&D)'
            TabOrder = 4
            OnClick = ButtonGameLogDelAllClick
          end
          object ButtonGameLogSave: TButton
            Left = 200
            Top = 152
            Width = 73
            Height = 25
            Caption = #20445#23384'(&S)'
            TabOrder = 5
            OnClick = ButtonGameLogSaveClick
          end
          object GroupBox9: TGroupBox
            Left = 8
            Top = 4
            Width = 177
            Height = 334
            Caption = #29289#21697#21015#34920'(Ctrl+F'#26597#25214')'
            TabOrder = 6
            object ListBoxitemList2: TListBox
              Left = 8
              Top = 16
              Width = 161
              Height = 309
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxitemList2Click
              OnKeyDown = ListBox1KeyDown
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #29190#29575#25511#21046
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Label1: TLabel
            Left = 191
            Top = 21
            Width = 54
            Height = 12
            Caption = #29289#21697#21517#31216':'
          end
          object Label2: TLabel
            Left = 191
            Top = 65
            Width = 54
            Height = 12
            Caption = #38480#21046#25968#37327':'
          end
          object Label3: TLabel
            Left = 191
            Top = 92
            Width = 54
            Height = 12
            Caption = #24050#29190#25968#37327':'
          end
          object Label6: TLabel
            Left = 191
            Top = 119
            Width = 48
            Height = 12
            Caption = #24320#22987'/'#24180':'
          end
          object Label7: TLabel
            Left = 191
            Top = 146
            Width = 48
            Height = 12
            Caption = #24320#22987'/'#26376':'
          end
          object Label8: TLabel
            Left = 191
            Top = 173
            Width = 48
            Height = 12
            Caption = #24320#22987'/'#26085':'
          end
          object Label9: TLabel
            Left = 191
            Top = 200
            Width = 48
            Height = 12
            Caption = #24320#22987'/'#26102':'
          end
          object GroupBox2: TGroupBox
            Left = 8
            Top = 4
            Width = 177
            Height = 334
            Caption = #29289#21697#21015#34920'(Ctrl+F'#26597#25214')'
            TabOrder = 0
            object ListBox1: TListBox
              Left = 8
              Top = 16
              Width = 161
              Height = 309
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBox1Click
              OnKeyDown = ListBox1KeyDown
            end
          end
          object GroupBox3: TGroupBox
            Left = 307
            Top = 4
            Width = 377
            Height = 334
            Caption = #35774#32622#21015#34920
            TabOrder = 1
            object StringGridMonDropLimit: TStringGrid
              Left = 8
              Top = 16
              Width = 361
              Height = 309
              ColCount = 4
              DefaultRowHeight = 18
              FixedCols = 0
              RowCount = 2
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
              TabOrder = 0
              OnClick = StringGridMonDropLimitClick
              ColWidths = (
                92
                62
                60
                120)
            end
          end
          object EditMonDropName: TEdit
            Left = 191
            Top = 36
            Width = 110
            Height = 20
            TabOrder = 2
          end
          object ButtonMonDropAdd: TButton
            Left = 191
            Top = 230
            Width = 52
            Height = 25
            Caption = #22686#21152'(&A)'
            Enabled = False
            TabOrder = 3
            OnClick = ButtonMonDropAddClick
          end
          object EditMonDropMaxCount: TSpinEdit
            Left = 247
            Top = 62
            Width = 54
            Height = 21
            MaxValue = 0
            MinValue = 0
            TabOrder = 4
            Value = 0
          end
          object EditMonDropMinCount: TSpinEdit
            Left = 247
            Top = 89
            Width = 54
            Height = 21
            MaxValue = 0
            MinValue = 0
            TabOrder = 5
            Value = 0
          end
          object EditMonDropYear: TSpinEdit
            Left = 247
            Top = 116
            Width = 54
            Height = 21
            MaxValue = 3000
            MinValue = 2010
            TabOrder = 6
            Value = 2010
          end
          object EditMonDropMonth: TSpinEdit
            Left = 247
            Top = 143
            Width = 54
            Height = 21
            MaxValue = 12
            MinValue = 0
            TabOrder = 7
            Value = 0
          end
          object EditMonDropDay: TSpinEdit
            Left = 247
            Top = 170
            Width = 54
            Height = 21
            MaxValue = 31
            MinValue = 0
            TabOrder = 8
            Value = 0
          end
          object ButtonMonDropDel: TButton
            Left = 249
            Top = 230
            Width = 52
            Height = 25
            Caption = #21024#38500'(&D)'
            Enabled = False
            TabOrder = 9
            OnClick = ButtonMonDropDelClick
          end
          object ButtonMonDropSave: TButton
            Left = 249
            Top = 292
            Width = 52
            Height = 25
            Caption = #20445#23384'(&S)'
            Enabled = False
            TabOrder = 10
            OnClick = ButtonMonDropSaveClick
          end
          object ButtonMonDropLoad: TButton
            Left = 191
            Top = 292
            Width = 52
            Height = 25
            Caption = #21047#26032'(&R)'
            TabOrder = 11
            OnClick = ButtonMonDropLoadClick
          end
          object EditMonDropHour: TSpinEdit
            Left = 247
            Top = 197
            Width = 54
            Height = 21
            MaxValue = 31
            MinValue = 0
            TabOrder = 12
            Value = 0
          end
          object ButtonMonDropClear: TButton
            Left = 249
            Top = 261
            Width = 52
            Height = 25
            Caption = #28165#29190'(&C)'
            TabOrder = 13
            OnClick = ButtonMonDropClearClick
          end
          object ButtonMonDropEdit: TButton
            Left = 191
            Top = 261
            Width = 52
            Height = 25
            Caption = #20462#25913'(&E)'
            Enabled = False
            TabOrder = 14
            OnClick = ButtonMonDropEditClick
          end
        end
        object TabSheet3: TTabSheet
          Caption = #33258#23450#20041'GM'#21629#20196
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Label12: TLabel
            Left = 447
            Top = 24
            Width = 226
            Height = 223
            AutoSize = False
            Caption = 
              #28216#25103#21629#20196#65306' '#27979#35797#21629#20196#13#10#23545#24212#26631#35782#65306' 1'#13#10#13#10#13#10#29609#23478#36755#20837#65306' @'#27979#35797#21629#20196' '#36825#26159#21442#25968#19968' '#21442#25968#20108#13#10#22791#27880#65306#24635#20849#25903#25345#24102'9'#20010#21442#25968#13#10#13#10 +
              'QFunction-0.txt'#20013#35774#32622#65306#13#10'[@USERCMD1]'#13#10#29609#23478#36755#20837#21442#25968#19968#26159#65306'<$STR(T0)>\'#13#10#29609#23478#36755#20837#21442#25968#20108#26159 +
              #65306'<$STR(T1)>\'#13#10#29609#23478#36755#20837#21442#25968#19977#26159#65306'<$STR(T2)>\'#13#10#13#10#13#10#23454#38469#26174#31034#65306#13#10#29609#23478#36755#20837#21442#25968#19968#26159#65306#36825#26159#21442#25968#19968#13#10#29609 +
              #23478#36755#20837#21442#25968#20108#26159#65306#21442#25968#20108#13#10#29609#23478#36755#20837#21442#25968#19977#26159#65306
          end
          object GroupBox4: TGroupBox
            Left = 8
            Top = 4
            Width = 433
            Height = 334
            Caption = #21629#20196#21015#34920
            TabOrder = 0
            object Label10: TLabel
              Left = 281
              Top = 20
              Width = 54
              Height = 12
              Caption = #28216#25103#21629#20196':'
            end
            object Label11: TLabel
              Left = 281
              Top = 44
              Width = 54
              Height = 12
              Caption = #23545#24212#26631#35782':'
            end
            object StringGridUserCmd: TStringGrid
              Left = 8
              Top = 16
              Width = 267
              Height = 309
              ColCount = 3
              DefaultRowHeight = 18
              FixedCols = 0
              RowCount = 30
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
              TabOrder = 0
              OnClick = StringGridUserCmdClick
              ColWidths = (
                93
                46
                100)
            end
            object EditUserCmdName: TEdit
              Left = 337
              Top = 16
              Width = 88
              Height = 20
              TabOrder = 1
            end
            object EditUserCmdID: TSpinEdit
              Left = 337
              Top = 39
              Width = 40
              Height = 21
              EditorEnabled = False
              MaxValue = 255
              MinValue = 1
              TabOrder = 2
              Value = 1
            end
            object ButtonUserCmdAdd: TButton
              Left = 284
              Top = 75
              Width = 66
              Height = 25
              Caption = #22686#21152'(&A)'
              TabOrder = 3
              OnClick = ButtonUserCmdAddClick
            end
            object ButtonUserCmdDel: TButton
              Left = 356
              Top = 75
              Width = 66
              Height = 25
              Caption = #21024#38500'(&D)'
              Enabled = False
              TabOrder = 4
              OnClick = ButtonUserCmdDelClick
            end
            object ButtonUserCmdEdit: TButton
              Left = 284
              Top = 106
              Width = 66
              Height = 25
              Caption = #20462#25913'(&E)'
              Enabled = False
              TabOrder = 5
              OnClick = ButtonUserCmdEditClick
            end
            object ButtonUserCmdSave: TButton
              Left = 356
              Top = 106
              Width = 66
              Height = 25
              Caption = #20445#23384'(&S)'
              Enabled = False
              TabOrder = 6
              OnClick = ButtonUserCmdSaveClick
            end
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = #29289#21697#35268#21010
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 363
        Caption = #29289#21697#21015#34920'(Ctrl+F'#26597#25214')'
        TabOrder = 0
        object ListBoxItem: TListBox
          Left = 8
          Top = 38
          Width = 161
          Height = 317
          Style = lbOwnerDrawFixed
          ItemHeight = 12
          MultiSelect = True
          TabOrder = 0
          OnClick = ListBoxItemClick
          OnDrawItem = ListBoxItemDrawItem
          OnKeyDown = ListBox1KeyDown
        end
        object CheckBox1: TCheckBox
          Left = 8
          Top = 17
          Width = 57
          Height = 17
          Caption = #21482#26174#31034
          TabOrder = 1
          OnClick = CheckBox1Click
        end
        object ComboBox1: TComboBox
          Left = 71
          Top = 15
          Width = 98
          Height = 20
          Style = csDropDownList
          Enabled = False
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 2
          Text = #25152#26377#35774#32622
          OnChange = CheckBox1Click
          Items.Strings = (
            #25152#26377#35774#32622
            #25171#36896#25552#31034
            #25481#33853#25552#31034
            #23453#31665#25552#31034)
        end
      end
      object GroupBox18: TGroupBox
        Left = 191
        Top = 8
        Width = 161
        Height = 334
        Caption = #29289#21697#35268#21017#23646#24615
        TabOrder = 1
        object CheckBoxMake: TCheckBox
          Left = 8
          Top = 17
          Width = 66
          Height = 17
          Hint = #36873#20013#35813#39033#65292#29289#21697#25172#12289#25441#21017#36827#34892#33050#26412#35302#21457
          Caption = #25171#36896#25552#31034
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxDropHint: TCheckBox
          Tag = 1
          Left = 88
          Top = 17
          Width = 66
          Height = 17
          Caption = #25481#33853#25552#31034
          TabOrder = 1
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxDropDown: TCheckBox
          Tag = -1
          Left = 88
          Top = 34
          Width = 66
          Height = 17
          Caption = #31105#27490#29190#20986
          Enabled = False
          TabOrder = 2
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxSave: TCheckBox
          Tag = -1
          Left = 88
          Top = 51
          Width = 66
          Height = 17
          Caption = #31105#27490#23384#20179
          Enabled = False
          TabOrder = 3
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object chkBox: TCheckBox
          Tag = 2
          Left = 8
          Top = 34
          Width = 66
          Height = 17
          Caption = #23453#31665#25552#31034
          TabOrder = 4
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxSell: TCheckBox
          Tag = -1
          Left = 8
          Top = 51
          Width = 66
          Height = 17
          Caption = #31105#27490#20986#21806
          Enabled = False
          TabOrder = 5
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxDeath: TCheckBox
          Tag = -1
          Left = 8
          Top = 101
          Width = 66
          Height = 17
          Caption = #27515#20129#25481#33853
          Enabled = False
          TabOrder = 6
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxBoxs: TCheckBox
          Tag = -1
          Left = 88
          Top = 68
          Width = 66
          Height = 17
          Hint = #36873#20013#35813#39033#65292#29289#21697#25171#24320#23453#31665#33719#24471#26102#21521#20840#26381#21457#36865#25552#31034#12290#25552#31034#25991#20214#22312'Strings.ini'#20013#20462#25913#12290
          Caption = #23453#31665#25552#31034
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxGhost: TCheckBox
          Tag = -1
          Left = 8
          Top = 84
          Width = 66
          Height = 17
          Caption = #19979#32447#25481#33853
          Enabled = False
          TabOrder = 8
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxPlaySell: TCheckBox
          Tag = -1
          Left = 88
          Top = 85
          Width = 66
          Height = 17
          Caption = #31105#27490#25670#25674
          Enabled = False
          TabOrder = 9
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxResell: TCheckBox
          Tag = -1
          Left = 8
          Top = 68
          Width = 66
          Height = 17
          Caption = #31105#27490#20462#29702
          Enabled = False
          TabOrder = 10
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxNoDrop: TCheckBox
          Tag = -1
          Left = 88
          Top = 101
          Width = 66
          Height = 17
          Hint = #36873#20013#35813#39033#65292#35813#29289#21697#27515#20129#19981#25481#33853#12290
          Caption = #27704#19981#25481#33853
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxDropHint2: TCheckBox
          Tag = -1
          Left = 8
          Top = 117
          Width = 66
          Height = 17
          Hint = #36873#20013#35813#39033#65292#29289#21697#25481#33853#21040#22320#19978#26102#21521#20840#26381#21457#21521#22352#26631#25552#31034#12290#25552#31034#25991#20214#22312'Strings.ini'#20013#20462#25913#12290
          Caption = #25481#33853#25552#31034
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxNoLevel: TCheckBox
          Tag = -1
          Left = 88
          Top = 117
          Width = 66
          Height = 17
          Hint = #35813#36873#39033#20165#29992#20110#27801#24052#20811#27494#22120#21319#32423#65292#31105#27490#21319#32423#30340#27494#22120#35774#32622#12290
          Caption = #31105#27490#21319#32423
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxButchItem: TCheckBox
          Tag = -1
          Left = 8
          Top = 133
          Width = 66
          Height = 17
          Hint = #36873#20013#35813#39033#65292#20174#24618#29289#25110#20154#22411#24618#36523#19978#25366#21040#25351#23450#29289#21697#26102#36827#34892#20840#26381#25552#31034#12290#25552#31034#25991#20214#22312'Strings.ini'#20013#20462#25913#12290
          Caption = #25366#21462#25552#31034
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxHeroBag: TCheckBox
          Tag = -1
          Left = 88
          Top = 133
          Width = 66
          Height = 17
          Hint = #29289#21697#31105#27490#25918#21040#33521#38596#21253#35065
          Caption = #33521#38596#21253#35065
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBox17: TCheckBox
          Tag = -1
          Left = 88
          Top = 149
          Width = 66
          Height = 17
          Caption = #39044#30041#20301#32622
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 16
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxNoTakeOff: TCheckBox
          Tag = 3
          Left = 8
          Top = 149
          Width = 66
          Height = 17
          Caption = #31105#27490#21462#19979
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object ButtonAllAdd: TButton
          Left = 5
          Top = 303
          Width = 70
          Height = 23
          Caption = #20840#37096#36873#20013
          TabOrder = 18
        end
        object ButtonAllClose: TButton
          Left = 84
          Top = 303
          Width = 70
          Height = 23
          Caption = #20840#37096#21462#28040
          TabOrder = 19
        end
      end
      object ButtonRuleSave: TButton
        Left = 282
        Top = 348
        Width = 70
        Height = 23
        Caption = #20445#23384'(&S)'
        Enabled = False
        TabOrder = 2
        OnClick = ButtonRuleSaveClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = #22871#35013#35774#32622
      ImageIndex = 2
      object GroupBox6: TGroupBox
        Left = 191
        Top = 139
        Width = 697
        Height = 318
        Caption = #23646#24615#35774#32622
        TabOrder = 0
        object Label14: TLabel
          Left = 336
          Top = 27
          Width = 42
          Height = 12
          Caption = #29983#21629#20540':'
        end
        object Label15: TLabel
          Left = 452
          Top = 27
          Width = 42
          Height = 12
          Caption = #39764#27861#20540':'
        end
        object Label16: TLabel
          Left = 576
          Top = 27
          Width = 30
          Height = 12
          Caption = #38450#24481':'
        end
        object Label17: TLabel
          Left = 336
          Top = 49
          Width = 30
          Height = 12
          Caption = #39764#24481':'
        end
        object Label18: TLabel
          Left = 456
          Top = 50
          Width = 30
          Height = 12
          Caption = #25915#20987':'
        end
        object Label19: TLabel
          Left = 576
          Top = 50
          Width = 30
          Height = 12
          Caption = #39764#27861':'
        end
        object Label20: TLabel
          Left = 336
          Top = 73
          Width = 30
          Height = 12
          Caption = #36947#26415':'
        end
        object Label21: TLabel
          Left = 456
          Top = 73
          Width = 30
          Height = 12
          Caption = #20934#30830':'
        end
        object Label22: TLabel
          Left = 336
          Top = 96
          Width = 54
          Height = 12
          Caption = #20307#21147#24674#22797':'
        end
        object Label23: TLabel
          Left = 456
          Top = 96
          Width = 54
          Height = 12
          Caption = #39764#27861#24674#22797':'
        end
        object Label24: TLabel
          Left = 336
          Top = 119
          Width = 54
          Height = 12
          Caption = #39764#27861#36530#36991':'
        end
        object Label25: TLabel
          Left = 456
          Top = 119
          Width = 54
          Height = 12
          Caption = #27602#29289#36530#36991':'
        end
        object Label32: TLabel
          Left = 336
          Top = 142
          Width = 54
          Height = 12
          Caption = #25915#20987#20493#25968':'
        end
        object Label31: TLabel
          Left = 456
          Top = 142
          Width = 54
          Height = 12
          Caption = #39764#27861#20493#25968':'
        end
        object Label26: TLabel
          Left = 576
          Top = 73
          Width = 30
          Height = 12
          Caption = #25935#25463':'
        end
        object Label27: TLabel
          Left = 576
          Top = 96
          Width = 54
          Height = 12
          Caption = #20013#27602#24674#22797':'
        end
        object Label28: TLabel
          Left = 576
          Top = 119
          Width = 54
          Height = 12
          Caption = #32463#39564#20493#25968':'
        end
        object Label29: TLabel
          Left = 576
          Top = 142
          Width = 54
          Height = 12
          Caption = #36947#26415#20493#25968':'
        end
        object Label35: TLabel
          Left = 576
          Top = 165
          Width = 54
          Height = 12
          Caption = #33268#21629#19968#20987':'
        end
        object Label36: TLabel
          Left = 456
          Top = 165
          Width = 54
          Height = 12
          Caption = #39764#24481#20493#25968':'
        end
        object Label37: TLabel
          Left = 336
          Top = 165
          Width = 54
          Height = 12
          Caption = #38450#24481#20493#25968':'
        end
        object Label30: TLabel
          Left = 15
          Top = 288
          Width = 30
          Height = 12
          Caption = #22791#27880':'
        end
        object Label33: TLabel
          Left = 336
          Top = 188
          Width = 54
          Height = 12
          Caption = #40635#30201#23646#24615':'
        end
        object Label34: TLabel
          Left = 456
          Top = 188
          Width = 54
          Height = 12
          Caption = #25252#36523#23646#24615':'
        end
        object Label38: TLabel
          Left = 576
          Top = 188
          Width = 54
          Height = 12
          Caption = #22797#27963#23646#24615':'
        end
        object Label50: TLabel
          Left = 336
          Top = 212
          Width = 54
          Height = 12
          Caption = #20260#23475#21152#25104':'
        end
        object Label51: TLabel
          Left = 456
          Top = 212
          Width = 54
          Height = 12
          Caption = #20260#23475#21560#25910':'
        end
        object EditHP: TSpinEdit
          Tag = 7
          Left = 394
          Top = 23
          Width = 52
          Height = 21
          Color = clWhite
          MaxValue = 60000
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EditHPChange
        end
        object EditMP: TSpinEdit
          Tag = 8
          Left = 514
          Top = 23
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = EditHPChange
        end
        object EditACt: TSpinEdit
          Left = 634
          Top = 23
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = EditHPChange
        end
        object EditMAC3: TSpinEdit
          Tag = 1
          Left = 394
          Top = 45
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = EditHPChange
        end
        object EditDC: TSpinEdit
          Tag = 2
          Left = 514
          Top = 46
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnChange = EditHPChange
        end
        object EditMC: TSpinEdit
          Tag = 3
          Left = 634
          Top = 46
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnChange = EditHPChange
        end
        object EditSC: TSpinEdit
          Tag = 4
          Left = 394
          Top = 69
          Width = 52
          Height = 21
          Color = clWhite
          MaxValue = 60000
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnChange = EditHPChange
        end
        object EditSC2: TSpinEdit
          Tag = 5
          Left = 514
          Top = 69
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 7
          Value = 0
          OnChange = EditHPChange
        end
        object EditAC: TSpinEdit
          Tag = 14
          Left = 394
          Top = 92
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'1'#21017#20026'10%'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnChange = EditHPChange
        end
        object EditAC2: TSpinEdit
          Tag = 15
          Left = 514
          Top = 92
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'1'#21017#20026'10%'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 9
          Value = 0
          OnChange = EditHPChange
        end
        object EditMAC: TSpinEdit
          Tag = 17
          Left = 394
          Top = 115
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'1'#21017#20026'10%'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 10
          Value = 0
          OnChange = EditHPChange
        end
        object EditMAC2: TSpinEdit
          Tag = 18
          Left = 514
          Top = 115
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'1'#21017#20026'10%'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 11
          Value = 0
          OnChange = EditHPChange
        end
        object EditHitPoint: TSpinEdit
          Tag = 11
          Left = 394
          Top = 138
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'10'#21017#20026'1'#20493
          MaxValue = 1000
          MinValue = 0
          TabOrder = 12
          Value = 0
          OnChange = EditHPChange
        end
        object EditSpeedPoint: TSpinEdit
          Tag = 12
          Left = 514
          Top = 138
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'10'#21017#20026'1'#20493
          MaxValue = 1000
          MinValue = 0
          TabOrder = 13
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit1: TSpinEdit
          Tag = 6
          Left = 634
          Top = 69
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 14
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit2: TSpinEdit
          Tag = 16
          Left = 634
          Top = 92
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'1'#21017#20026'10%'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 15
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit3: TSpinEdit
          Tag = 22
          Left = 634
          Top = 115
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'10'#21017#20026'1'#20493
          MaxValue = 1000
          MinValue = 0
          TabOrder = 16
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit4: TSpinEdit
          Tag = 13
          Left = 634
          Top = 138
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'10'#21017#20026'1'#20493
          MaxValue = 1000
          MinValue = 0
          TabOrder = 17
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit8: TSpinEdit
          Tag = 21
          Left = 634
          Top = 161
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'1'#21017#20026'1%'
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 18
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit9: TSpinEdit
          Tag = 10
          Left = 514
          Top = 161
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'10'#21017#20026'1'#20493
          MaxValue = 1000
          MinValue = 0
          TabOrder = 19
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit10: TSpinEdit
          Tag = 9
          Left = 394
          Top = 161
          Width = 52
          Height = 21
          Hint = #35774#32622#25968#20540#20026'10'#21017#20026'1'#20493
          MaxValue = 1000
          MinValue = 0
          TabOrder = 20
          Value = 0
          OnChange = EditHPChange
        end
        object Button1: TButton
          Left = 336
          Top = 283
          Width = 62
          Height = 25
          Caption = #22686#21152'(&A)'
          Enabled = False
          TabOrder = 21
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 404
          Top = 283
          Width = 62
          Height = 25
          Caption = #20462#25913'(&E)'
          Enabled = False
          TabOrder = 22
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 472
          Top = 283
          Width = 62
          Height = 25
          Caption = #21024#38500'(&D)'
          Enabled = False
          TabOrder = 23
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 540
          Top = 283
          Width = 62
          Height = 25
          Caption = #20445#23384'(&S)'
          Enabled = False
          TabOrder = 24
          OnClick = Button4Click
        end
        object Edit1: TEdit
          Tag = -1
          Left = 51
          Top = 285
          Width = 271
          Height = 20
          Hint = #29992#20110#31649#29702#21592#33258#24049#20316#20026#25552#31034#20316#29992#65292#23545#28216#25103#20869#26174#31034#26080#24433#21709#12290
          MaxLength = 50
          TabOrder = 25
        end
        object SpinEdit5: TSpinEdit
          Tag = 23
          Left = 394
          Top = 184
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 1
          MinValue = 0
          TabOrder = 26
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit6: TSpinEdit
          Tag = 24
          Left = 514
          Top = 184
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 1
          MinValue = 0
          TabOrder = 27
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit7: TSpinEdit
          Tag = 25
          Left = 634
          Top = 184
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 1
          MinValue = 0
          TabOrder = 28
          Value = 0
          OnChange = EditHPChange
        end
        object GroupBox10: TGroupBox
          Left = 12
          Top = 15
          Width = 310
          Height = 258
          Caption = #35013#22791#21015#34920
          TabOrder = 29
          object Label13: TLabel
            Left = 10
            Top = 22
            Width = 30
            Height = 12
            Caption = #26381#35013':'
          end
          object Label39: TLabel
            Left = 167
            Top = 23
            Width = 12
            Height = 12
            Caption = #25110
          end
          object Label40: TLabel
            Left = 10
            Top = 48
            Width = 30
            Height = 12
            Caption = #27494#22120':'
          end
          object Label41: TLabel
            Left = 10
            Top = 74
            Width = 30
            Height = 12
            Caption = #39033#38142':'
          end
          object Label42: TLabel
            Left = 10
            Top = 100
            Width = 30
            Height = 12
            Caption = #22836#30420':'
          end
          object Label43: TLabel
            Left = 10
            Top = 126
            Width = 30
            Height = 12
            Caption = #21195#31456':'
          end
          object Label44: TLabel
            Left = 10
            Top = 152
            Width = 30
            Height = 12
            Caption = #25163#38255':'
          end
          object Label45: TLabel
            Left = 159
            Top = 152
            Width = 30
            Height = 12
            Caption = #25163#38255':'
          end
          object Label46: TLabel
            Left = 159
            Top = 178
            Width = 30
            Height = 12
            Caption = #25106#25351':'
          end
          object Label47: TLabel
            Left = 10
            Top = 178
            Width = 30
            Height = 12
            Caption = #25106#25351':'
          end
          object Label49: TLabel
            Left = 10
            Top = 204
            Width = 30
            Height = 12
            Caption = #33136#24102':'
          end
          object Label48: TLabel
            Left = 10
            Top = 230
            Width = 30
            Height = 12
            Caption = #38772#23376':'
          end
          object Edit2: TEdit
            Left = 46
            Top = 19
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354#12290#26381#35013#35831#20998#21035#22635#20889#30007#35013#21644#22899#35013#65281
            TabOrder = 0
          end
          object Edit3: TEdit
            Tag = 1
            Left = 46
            Top = 45
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354
            TabOrder = 1
          end
          object Edit4: TEdit
            Tag = 3
            Left = 46
            Top = 71
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354
            TabOrder = 2
          end
          object Edit5: TEdit
            Tag = 2
            Left = 46
            Top = 97
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354
            TabOrder = 3
          end
          object Edit6: TEdit
            Tag = 4
            Left = 46
            Top = 123
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354
            TabOrder = 4
          end
          object Edit7: TEdit
            Tag = 5
            Left = 46
            Top = 149
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354#12290#25106#25351#25110#25163#38255#21487#22635#19968#20214#20063#21487#20197#22635#20889#20004#20214
            TabOrder = 5
          end
          object Edit8: TEdit
            Tag = 7
            Left = 46
            Top = 175
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354#12290#25106#25351#25110#25163#38255#21487#22635#19968#20214#20063#21487#20197#22635#20889#20004#20214
            TabOrder = 6
          end
          object Edit9: TEdit
            Tag = 10
            Left = 46
            Top = 201
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354
            TabOrder = 7
          end
          object Edit10: TEdit
            Tag = 11
            Left = 46
            Top = 227
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354
            TabOrder = 8
          end
          object Edit11: TEdit
            Tag = 9
            Left = 195
            Top = 19
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354#12290#26381#35013#35831#20998#21035#22635#20889#30007#35013#21644#22899#35013#65281
            TabOrder = 9
          end
          object Edit12: TEdit
            Tag = 6
            Left = 195
            Top = 149
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354#12290#25106#25351#25110#25163#38255#21487#22635#19968#20214#20063#21487#20197#22635#20889#20004#20214
            TabOrder = 10
          end
          object Edit13: TEdit
            Tag = 8
            Left = 195
            Top = 175
            Width = 107
            Height = 20
            Hint = #22914#19981#38656#35201#35813#29289#21697#65292#35831#30041#31354#12290#25106#25351#25110#25163#38255#21487#22635#19968#20214#20063#21487#20197#22635#20889#20004#20214
            TabOrder = 11
          end
        end
        object SpinEdit11: TSpinEdit
          Tag = 19
          Left = 394
          Top = 208
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 30
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit12: TSpinEdit
          Tag = 20
          Left = 514
          Top = 208
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 31
          Value = 0
          OnChange = EditHPChange
        end
        object CheckBox2: TCheckBox
          Left = 336
          Top = 238
          Width = 110
          Height = 17
          Caption = #38544#34255#23458#25143#31471#26174#31034
          TabOrder = 32
        end
      end
      object GroupBox7: TGroupBox
        Left = 191
        Top = 8
        Width = 697
        Height = 125
        Caption = #22871#35013#21015#34920
        TabOrder = 1
        object ListViewSuit: TListView
          Left = 9
          Top = 18
          Width = 672
          Height = 98
          Columns = <
            item
              Caption = #22791#27880
              Width = 160
            end
            item
              Caption = #35013#22791#21015#34920
              Width = 220
            end
            item
              AutoSize = True
              Caption = #23646#24615
            end
            item
              Caption = #38544#34255#23646#24615
              Width = 60
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewSuitClick
        end
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 449
        Caption = #35013#22791#21015#34920'('#36873#20013#21491#38190#25805#20316')'
        TabOrder = 2
        object ListBoxSetItems: TListBox
          Left = 7
          Top = 18
          Width = 161
          Height = 418
          Style = lbOwnerDrawFixed
          ItemHeight = 12
          MultiSelect = True
          PopupMenu = PopupMenu1
          TabOrder = 0
          OnKeyDown = ListBox1KeyDown
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 40
    Top = 144
    object A1: TMenuItem
      Caption = #28155#21152#21040#35013#22791#21015#34920'(&A)'
      OnClick = A1Click
    end
  end
end
