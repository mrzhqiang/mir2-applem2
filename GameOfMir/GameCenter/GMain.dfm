object frmMain: TfrmMain
  Left = 172
  Top = 106
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20848#36798#23572#25511#21046#21488'(2020.1.0)'
  ClientHeight = 376
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl: TPageControl
    Left = 8
    Top = 8
    Width = 520
    Height = 360
    ActivePage = ConfigTab
    HotTrack = True
    TabOrder = 0
    object ControlTab: TTabSheet
      Caption = #25511#21046#20013#24515
      object ControlGroup: TGroupBox
        Left = 8
        Top = 3
        Width = 497
        Height = 313
        Caption = #26381#21153#22120#25511#21046
        TabOrder = 0
        object StartHoursLabel: TLabel
          Left = 330
          Top = 133
          Width = 30
          Height = 12
          Caption = #23567#26102':'
        end
        object StartMinutesLabel: TLabel
          Left = 410
          Top = 133
          Width = 30
          Height = 12
          Caption = #20998#38047':'
        end
        object StartGameButton: TButton
          Left = 166
          Top = 275
          Width = 145
          Height = 33
          Caption = #21551#21160#28216#25103#25511#21046#22120'(&S)'
          TabOrder = 0
          OnClick = StartGameButtonClick
        end
        object M2ServerCheckBox: TCheckBox
          Left = 8
          Top = 33
          Width = 161
          Height = 17
          Caption = #28216#25103#20027#31243#24207'(M2Server):'
          TabOrder = 1
          OnClick = M2ServerCheckBoxClick
        end
        object DBServerCheckBox: TCheckBox
          Left = 8
          Top = 17
          Width = 177
          Height = 17
          Caption = #25968#25454#24211#26381#21153#22120'(DBServer):'
          TabOrder = 2
          OnClick = DBServerCheckBoxClick
        end
        object LoginServerCheckBox: TCheckBox
          Left = 248
          Top = 17
          Width = 177
          Height = 17
          Caption = #30331#38470#26381#21153#22120'(LoginSrv):'
          TabOrder = 3
          OnClick = LoginServerCheckBoxClick
        end
        object LogServerCheckBox: TCheckBox
          Left = 248
          Top = 33
          Width = 177
          Height = 17
          Caption = #26085#24535#26381#21153#22120'(LogServer):'
          TabOrder = 4
          OnClick = LogServerCheckBoxClick
        end
        object SelGate1CheckBox: TCheckBox
          Left = 248
          Top = 113
          Width = 161
          Height = 17
          Caption = #35282#33394#32593#20851#20108'(SelGate):'
          TabOrder = 5
          OnClick = SelGate1CheckBoxClick
        end
        object RunGateCheckBox: TCheckBox
          Left = 8
          Top = 49
          Width = 161
          Height = 17
          Caption = #28216#25103#32593#20851#19968'(Rungate):'
          TabOrder = 6
          OnClick = RunGateCheckBoxClick
        end
        object RunGate1CheckBox: TCheckBox
          Tag = 1
          Left = 248
          Top = 49
          Width = 161
          Height = 17
          Caption = #28216#25103#32593#20851#20108'(Rungate):'
          TabOrder = 7
          OnClick = RunGateCheckBoxClick
        end
        object RunGate2CheckBox: TCheckBox
          Tag = 2
          Left = 8
          Top = 65
          Width = 161
          Height = 17
          Caption = #28216#25103#32593#20851#19977'(Rungate):'
          TabOrder = 8
          OnClick = RunGateCheckBoxClick
        end
        object MemoLog: TMemo
          Left = 8
          Top = 176
          Width = 473
          Height = 93
          Color = clNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clYellow
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          Lines.Strings = (
            #26174#31034#25511#21046#21488#36755#20986#28040#24687)
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 9
          OnChange = MemoLogChange
        end
        object RunGate3CheckBox: TCheckBox
          Tag = 3
          Left = 248
          Top = 65
          Width = 161
          Height = 17
          Caption = #28216#25103#32593#20851#22235'(Rungate):'
          TabOrder = 10
          OnClick = RunGateCheckBoxClick
        end
        object RunGate4CheckBox: TCheckBox
          Tag = 4
          Left = 8
          Top = 81
          Width = 161
          Height = 17
          Caption = #28216#25103#32593#20851#20116'(Rungate):'
          TabOrder = 11
          OnClick = RunGateCheckBoxClick
        end
        object RunGate5CheckBox: TCheckBox
          Tag = 5
          Left = 248
          Top = 81
          Width = 161
          Height = 17
          Caption = #28216#25103#32593#20851#20845'(Rungate):'
          TabOrder = 12
          OnClick = RunGateCheckBoxClick
        end
        object RunGate6CheckBox: TCheckBox
          Tag = 6
          Left = 8
          Top = 97
          Width = 161
          Height = 17
          Caption = #28216#25103#32593#20851#19971'(Rungate):'
          TabOrder = 13
          OnClick = RunGateCheckBoxClick
        end
        object RunGate7CheckBox: TCheckBox
          Tag = 7
          Left = 248
          Top = 97
          Width = 161
          Height = 17
          Caption = #28216#25103#32593#20851#20843'(Rungate):'
          TabOrder = 14
          OnClick = RunGateCheckBoxClick
        end
        object SelGateCheckBox: TCheckBox
          Left = 8
          Top = 113
          Width = 161
          Height = 17
          Caption = #35282#33394#32593#20851#19968'(SelGate):'
          TabOrder = 15
          OnClick = SelGateCheckBoxClick
        end
        object LoginGateCheckBox: TCheckBox
          Left = 8
          Top = 131
          Width = 162
          Height = 17
          Caption = #30331#38470#32593#20851'(LoginGate): '
          TabOrder = 16
          OnClick = LoginGateCheckBoxClick
        end
        object RunStatusComboBox: TComboBox
          Left = 248
          Top = 129
          Width = 73
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 17
          Text = #27491#24120#21551#21160
          OnChange = RunStatusComboBoxChange
          Items.Strings = (
            #27491#24120#21551#21160
            #24310#26102#21551#21160
            #23450#26102#21551#21160)
        end
        object EditHour: TSpinEdit
          Left = 360
          Top = 129
          Width = 41
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 23
          MinValue = 0
          TabOrder = 18
          Value = 0
          OnChange = RunStatusComboBoxChange
        end
        object EditMinute: TSpinEdit
          Left = 440
          Top = 129
          Width = 41
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 59
          MinValue = 0
          TabOrder = 19
          Value = 0
          OnChange = RunStatusComboBoxChange
        end
        object PlugTopCheckBox: TCheckBox
          Left = 8
          Top = 153
          Width = 162
          Height = 17
          Caption = #25490#34892#27036#25554#20214'(PlugTop)'
          TabOrder = 20
          OnClick = PlugTopCheckBoxClick
        end
      end
    end
    object ConfigTab: TTabSheet
      Caption = #37197#32622#21521#23548
      ImageIndex = 1
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 512
        Height = 332
        ActivePage = TabSheet5
        Align = alClient
        TabOrder = 0
        TabPosition = tpBottom
        object TabSheet4: TTabSheet
          Caption = #31532#19968#27493'('#22522#26412#35774#32622')'
          object GroupBox1: TGroupBox
            Left = 3
            Top = 13
            Width = 489
            Height = 177
            Caption = #31243#24207#30446#24405#21450#29289#21697#25968#25454#24211#35774#32622
            TabOrder = 0
            object Label1: TLabel
              Left = 8
              Top = 28
              Width = 114
              Height = 12
              Caption = #28216#25103#26381#21153#31471#25152#22312#30446#24405':'
            end
            object Label2: TLabel
              Left = 8
              Top = 52
              Width = 90
              Height = 12
              Caption = #28216#25103#25968#25454#24211#21517#31216':'
            end
            object Label3: TLabel
              Left = 8
              Top = 76
              Width = 126
              Height = 12
              Caption = #28216#25103#26381#21153#22120#26381#21153#22120#21517#31216':'
            end
            object Label4: TLabel
              Left = 8
              Top = 100
              Width = 126
              Height = 12
              Alignment = taRightJustify
              Caption = #28216#25103#26381#21153#22120#22806#32593'IP'#22320#22336':'
            end
            object Label30: TLabel
              Left = 86
              Top = 126
              Width = 48
              Height = 12
              Alignment = taRightJustify
              Caption = #22806#32593'IP2:'
              Visible = False
            end
            object EditGameDir: TEdit
              Left = 136
              Top = 24
              Width = 225
              Height = 20
              Hint = #36755#20837#26381#21153#22120#25152#22312#30446#24405#12290#19968#33324#40664#35748#20026#8220'D:\MirServer\'#8221#12290
              TabOrder = 0
              Text = 'D:\MirServer\'
            end
            object EditHeroDB: TEdit
              Left = 136
              Top = 46
              Width = 225
              Height = 20
              Hint = #26381#21153#22120#31471'BDE '#25968#25454#24211#21517#31216#65292#40664#35748#20026' '#8220'HeroDB'#8221#12290
              TabOrder = 1
              Text = 'HeroDB'
            end
            object EditGameName: TEdit
              Left = 136
              Top = 72
              Width = 161
              Height = 20
              Hint = #36755#20837#28216#25103#30340#21517#31216#12290
              TabOrder = 2
              Text = #26032#28909#34880#20256#22855
            end
            object EditGameExtIPaddr: TEdit
              Left = 136
              Top = 96
              Width = 97
              Height = 20
              Hint = #36755#20837#26381#21153#22120#30340#22806#32593'IP'#22320#22336#12290
              TabOrder = 3
              Text = '127.0.0.1'
            end
            object ButtonGeneralDefalult: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = #40664#35748#35774#32622'(&D)'
              TabOrder = 4
              OnClick = ButtonGeneralDefalultClick
            end
            object CheckBoxIP2: TCheckBox
              Left = 247
              Top = 98
              Width = 97
              Height = 17
              Caption = #21452'IP'#19968#21306#35774#32622
              TabOrder = 5
              OnClick = CheckBoxIP2Click
            end
            object EditGameExtIPaddr2: TEdit
              Left = 136
              Top = 122
              Width = 97
              Height = 20
              Hint = #36755#20837#26381#21153#22120#30340#22806#32593'IP'#22320#22336#12290
              TabOrder = 6
              Text = '127.0.0.1'
              Visible = False
            end
            object SpinEditAllPortAdd: TSpinEdit
              Left = 136
              Top = 154
              Width = 97
              Height = 21
              MaxValue = 0
              MinValue = 0
              TabOrder = 7
              Value = 0
              OnChange = SpinEditAllPortAddChange
            end
            object ButtonAllPortAdd: TButton
              Left = 5
              Top = 150
              Width = 125
              Height = 25
              Caption = #25152#26377#31471#21475#25209#37327#22686#21152':'
              TabOrder = 8
              OnClick = ButtonAllPortAddClick
            end
          end
          object ButtonNext1: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 1
            OnClick = ButtonNext1Click
          end
          object ButtonReLoadConfig: TButton
            Left = 408
            Top = 223
            Width = 81
            Height = 33
            Caption = #37325#21152#36733'(&R)'
            TabOrder = 2
            OnClick = ButtonReLoadConfigClick
          end
          object GroupBox20: TGroupBox
            Left = 3
            Top = 196
            Width = 185
            Height = 101
            Caption = #26381#21153#31471#21151#33021#36873#39033
            TabOrder = 3
            object CheckBoxCloseWuXin: TCheckBox
              Left = 13
              Top = 19
              Width = 137
              Height = 17
              Caption = #20851#38381#26381#21153#22120#20116#34892#21151#33021
              TabOrder = 0
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = #31532#20108#27493'('#30331#24405#32593#20851')'
          ImageIndex = 1
          object ButtonNext2: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 0
            OnClick = ButtonNext2Click
          end
          object GroupBox2: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #30331#38470#32593#20851#35774#32622
            TabOrder = 1
            object GroupBox7: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label9: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label10: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditLoginGate_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLoginGate_MainFormXChange
              end
              object EditLoginGate_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLoginGate_MainFormYChange
              end
            end
            object ButtonLoginGateDefault: TButton
              Left = 405
              Top = 149
              Width = 81
              Height = 25
              Caption = #40664#35748#35774#32622'(&D)'
              TabOrder = 1
              OnClick = ButtonLoginGateDefaultClick
            end
            object GroupBox23: TGroupBox
              Left = 144
              Top = 16
              Width = 129
              Height = 49
              Caption = #26381#21153#22120#31471#21475
              TabOrder = 2
              object Label28: TLabel
                Left = 8
                Top = 20
                Width = 30
                Height = 12
                Caption = #31471#21475':'
              end
              object EditLoginGate_GatePort: TEdit
                Left = 56
                Top = 16
                Width = 41
                Height = 20
                TabOrder = 0
                Text = '7000'
              end
            end
            object GroupBox27: TGroupBox
              Left = 8
              Top = 96
              Width = 145
              Height = 41
              Caption = #26159#21542#21551#21160
              TabOrder = 3
              object CheckBoxboLoginGate_GetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 129
                Height = 17
                Caption = #21551#21160#30331#24405#32593#20851
                TabOrder = 0
                OnClick = CheckBoxboLoginGate_GetStartClick
              end
            end
          end
          object ButtonPrv2: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 2
            OnClick = ButtonPrv2Click
          end
        end
        object TabSheet6: TTabSheet
          Caption = #31532#19977#27493'('#35282#33394#32593#20851')'
          ImageIndex = 2
          object GroupBox3: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #35282#33394#32593#20851#35774#32622
            TabOrder = 0
            object GroupBox8: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label11: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label12: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditSelGate_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditSelGate_MainFormXChange
              end
              object EditSelGate_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditSelGate_MainFormYChange
              end
            end
            object ButtonSelGateDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = #40664#35748#35774#32622'(&D)'
              TabOrder = 1
              OnClick = ButtonSelGateDefaultClick
            end
            object GroupBox24: TGroupBox
              Left = 144
              Top = 16
              Width = 129
              Height = 73
              Caption = #26381#21153#22120#31471#21475
              TabOrder = 2
              object Label29: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #31471#21475'1:'
              end
              object Label49: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #31471#21475'2:'
              end
              object EditSelGate_GatePort: TEdit
                Left = 56
                Top = 16
                Width = 41
                Height = 20
                TabOrder = 0
                Text = '7100'
              end
              object EditSelGate_GatePort1: TEdit
                Left = 56
                Top = 40
                Width = 41
                Height = 20
                TabOrder = 1
                Text = '7100'
              end
            end
            object GroupBox28: TGroupBox
              Left = 8
              Top = 96
              Width = 153
              Height = 57
              Caption = #26159#21542#21551#21160
              TabOrder = 3
              object CheckBoxboSelGate_GetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 129
                Height = 17
                Caption = #21551#21160#35282#33394#32593#20851#19968
                TabOrder = 0
                OnClick = CheckBoxboSelGate_GetStartClick
              end
              object CheckBoxboSelGate_GetStart2: TCheckBox
                Left = 8
                Top = 33
                Width = 129
                Height = 17
                Caption = #21551#21160#35282#33394#32593#20851#20108
                TabOrder = 1
                OnClick = CheckBoxboSelGate_GetStart2Click
              end
            end
          end
          object ButtonPrv3: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 1
            OnClick = ButtonPrv3Click
          end
          object ButtonNext3: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 2
            OnClick = ButtonNext3Click
          end
        end
        object TabSheet12: TTabSheet
          Caption = #31532#22235#27493'('#28216#25103#32593#20851')'
          ImageIndex = 8
          object ButtonPrv4: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 0
            OnClick = ButtonPrv4Click
          end
          object ButtonNext4: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 1
            OnClick = ButtonNext4Click
          end
          object GroupBox17: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #28216#25103#32593#20851#35774#32622
            TabOrder = 2
            object GroupBox18: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label21: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label22: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditRunGate_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditRunGate_MainFormXChange
              end
              object EditRunGate_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditRunGate_MainFormYChange
              end
            end
            object GroupBox19: TGroupBox
              Left = 8
              Top = 112
              Width = 354
              Height = 57
              Caption = #24320#21551#32593#20851#25968#37327
              TabOrder = 1
              object CheckBoxboRunGate_GetStart1: TCheckBox
                Left = 8
                Top = 16
                Width = 81
                Height = 17
                Caption = #21551#21160#32593#20851#19968
                TabOrder = 0
                OnClick = CheckBoxboRunGate_GetStart2Click
              end
              object CheckBoxboRunGate_GetStart2: TCheckBox
                Tag = 1
                Left = 8
                Top = 33
                Width = 81
                Height = 17
                Caption = #21551#21160#32593#20851#20108
                TabOrder = 1
                OnClick = CheckBoxboRunGate_GetStart2Click
              end
              object CheckBoxboRunGate_GetStart3: TCheckBox
                Tag = 2
                Left = 95
                Top = 16
                Width = 81
                Height = 17
                Caption = #21551#21160#32593#20851#19977
                TabOrder = 2
                OnClick = CheckBoxboRunGate_GetStart2Click
              end
              object CheckBoxboRunGate_GetStart4: TCheckBox
                Tag = 3
                Left = 95
                Top = 33
                Width = 81
                Height = 17
                Caption = #21551#21160#32593#20851#22235
                TabOrder = 3
                OnClick = CheckBoxboRunGate_GetStart2Click
              end
              object CheckBoxboRunGate_GetStart5: TCheckBox
                Tag = 4
                Left = 182
                Top = 16
                Width = 81
                Height = 17
                Caption = #21551#21160#32593#20851#20116
                TabOrder = 4
                OnClick = CheckBoxboRunGate_GetStart2Click
              end
              object CheckBoxboRunGate_GetStart6: TCheckBox
                Tag = 5
                Left = 182
                Top = 33
                Width = 81
                Height = 17
                Caption = #21551#21160#32593#20851#20845
                TabOrder = 5
                OnClick = CheckBoxboRunGate_GetStart2Click
              end
              object CheckBoxboRunGate_GetStart7: TCheckBox
                Tag = 6
                Left = 269
                Top = 16
                Width = 81
                Height = 17
                Caption = #21551#21160#32593#20851#19971
                TabOrder = 6
                OnClick = CheckBoxboRunGate_GetStart2Click
              end
              object CheckBoxboRunGate_GetStart8: TCheckBox
                Tag = 7
                Left = 269
                Top = 33
                Width = 81
                Height = 17
                Caption = #21551#21160#32593#20851#20843
                TabOrder = 7
                OnClick = CheckBoxboRunGate_GetStart2Click
              end
            end
            object GroupBox22: TGroupBox
              Left = 144
              Top = 16
              Width = 329
              Height = 95
              Caption = #26381#21153#22120#31471#21475
              TabOrder = 2
              object LabelRunGate_GatePort1: TLabel
                Left = 8
                Top = 20
                Width = 18
                Height = 12
                Caption = #19968':'
              end
              object LabelLabelRunGate_GatePort2: TLabel
                Left = 8
                Top = 44
                Width = 18
                Height = 12
                Caption = #20108':'
              end
              object LabelRunGate_GatePort3: TLabel
                Left = 8
                Top = 68
                Width = 18
                Height = 12
                Caption = #19977':'
              end
              object LabelRunGate_GatePort4: TLabel
                Left = 104
                Top = 20
                Width = 18
                Height = 12
                Caption = #22235':'
              end
              object LabelRunGate_GatePort5: TLabel
                Left = 104
                Top = 44
                Width = 18
                Height = 12
                Caption = #20116':'
              end
              object LabelRunGate_GatePort6: TLabel
                Left = 104
                Top = 70
                Width = 18
                Height = 12
                Caption = #20845':'
              end
              object LabelRunGate_GatePort7: TLabel
                Left = 200
                Top = 20
                Width = 18
                Height = 12
                Caption = #19971':'
              end
              object LabelRunGate_GatePort78: TLabel
                Left = 200
                Top = 44
                Width = 18
                Height = 12
                Caption = #20843':'
              end
              object EditRunGate_GatePort1: TEdit
                Left = 56
                Top = 16
                Width = 41
                Height = 20
                TabOrder = 0
                Text = '7200'
              end
              object EditRunGate_GatePort2: TEdit
                Left = 56
                Top = 40
                Width = 41
                Height = 20
                TabOrder = 1
                Text = '7200'
              end
              object EditRunGate_GatePort3: TEdit
                Left = 56
                Top = 64
                Width = 41
                Height = 20
                TabOrder = 2
                Text = '7200'
              end
              object EditRunGate_GatePort4: TEdit
                Left = 152
                Top = 16
                Width = 41
                Height = 20
                TabOrder = 3
                Text = '7200'
              end
              object EditRunGate_GatePort5: TEdit
                Left = 152
                Top = 40
                Width = 41
                Height = 20
                TabOrder = 4
                Text = '7200'
              end
              object EditRunGate_GatePort6: TEdit
                Left = 152
                Top = 66
                Width = 41
                Height = 20
                TabOrder = 5
                Text = '7200'
              end
              object EditRunGate_GatePort7: TEdit
                Left = 248
                Top = 16
                Width = 41
                Height = 20
                TabOrder = 6
                Text = '7200'
              end
              object EditRunGate_GatePort8: TEdit
                Left = 248
                Top = 40
                Width = 41
                Height = 20
                TabOrder = 7
                Text = '7200'
              end
            end
            object ButtonRunGateDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = #40664#35748#35774#32622'(&D)'
              TabOrder = 3
              OnClick = ButtonRunGateDefaultClick
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = #31532#20116#27493'('#30331#24405#26381#21153#22120')'
          ImageIndex = 3
          object GroupBox9: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #30331#24405#26381#21153#22120#35774#32622
            TabOrder = 0
            object GroupBox10: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label13: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label14: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditLoginServer_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLoginServer_MainFormXChange
              end
              object EditLoginServer_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLoginServer_MainFormYChange
              end
            end
            object ButtonLoginSrvDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = #40664#35748#35774#32622'(&D)'
              TabOrder = 1
              OnClick = ButtonLoginSrvDefaultClick
            end
            object GroupBox33: TGroupBox
              Left = 144
              Top = 16
              Width = 214
              Height = 73
              Caption = #21069#32622#26381#21153#22120#31471#21475
              TabOrder = 2
              object Label50: TLabel
                Left = 8
                Top = 20
                Width = 54
                Height = 12
                Caption = #36830#25509#31471#21475':'
              end
              object Label51: TLabel
                Left = 8
                Top = 44
                Width = 54
                Height = 12
                Caption = #36890#35759#31471#21475':'
              end
              object Label26: TLabel
                Left = 109
                Top = 20
                Width = 54
                Height = 12
                Caption = #30417#25511#31471#21475':'
              end
              object EditLoginServerGatePort: TEdit
                Left = 64
                Top = 16
                Width = 41
                Height = 20
                TabOrder = 0
                Text = '7200'
              end
              object EditLoginServerServerPort: TEdit
                Left = 64
                Top = 40
                Width = 41
                Height = 20
                TabOrder = 1
                Text = '7200'
              end
              object EditLoginServerMonPort: TEdit
                Left = 165
                Top = 16
                Width = 41
                Height = 20
                TabOrder = 2
                Text = '7200'
              end
            end
            object GroupBox34: TGroupBox
              Left = 8
              Top = 96
              Width = 161
              Height = 41
              Caption = #26159#21542#21551#21160
              TabOrder = 3
              object CheckBoxboLoginServer_GetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 137
                Height = 17
                Caption = #21551#21160#30331#24405#26381#21153#22120
                TabOrder = 0
                OnClick = CheckBoxboLoginServer_GetStartClick
              end
            end
          end
          object ButtonPrv5: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 1
            OnClick = ButtonPrv5Click
          end
          object ButtonNext5: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 2
            OnClick = ButtonNext5Click
          end
        end
        object TabSheet8: TTabSheet
          Caption = #31532#20845#27493'('#25968#25454#24211#26381#21153#22120')'
          ImageIndex = 4
          object GroupBox11: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #25968#25454#24211#26381#21153#22120#35774#32622
            TabOrder = 0
            object GroupBox12: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label15: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label16: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditDBServer_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditDBServer_MainFormXChange
              end
              object EditDBServer_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditDBServer_MainFormYChange
              end
            end
            object ButtonDBServerDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = #40664#35748#35774#32622'(&D)'
              TabOrder = 1
              OnClick = ButtonDBServerDefaultClick
            end
            object GroupBox35: TGroupBox
              Left = 8
              Top = 96
              Width = 129
              Height = 41
              Caption = #26159#21542#21551#21160
              TabOrder = 2
              object CheckBoxDBServerGetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 113
                Height = 17
                Caption = #21551#21160#25968#25454#24211#26381#21153#22120
                TabOrder = 0
                OnClick = CheckBoxDBServerGetStartClick
              end
            end
            object GroupBox36: TGroupBox
              Left = 144
              Top = 16
              Width = 209
              Height = 73
              Caption = #21069#32622#26381#21153#22120#31471#21475
              TabOrder = 3
              object Label52: TLabel
                Left = 8
                Top = 20
                Width = 54
                Height = 12
                Caption = #36830#25509#31471#21475':'
              end
              object Label53: TLabel
                Left = 8
                Top = 44
                Width = 54
                Height = 12
                Caption = #36890#35759#31471#21475':'
              end
              object EditDBServerGatePort: TEdit
                Left = 64
                Top = 16
                Width = 41
                Height = 20
                TabOrder = 0
                Text = '5100'
              end
              object EditDBServerServerPort: TEdit
                Left = 64
                Top = 40
                Width = 41
                Height = 20
                TabOrder = 1
                Text = '6000'
              end
            end
          end
          object ButtonPrv6: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 1
            OnClick = ButtonPrv6Click
          end
          object ButtonNext6: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 2
            OnClick = ButtonNext6Click
          end
        end
        object TabSheet9: TTabSheet
          Caption = #31532#19971#27493'('#28216#25103#26085#24535#26381#21153#22120')'
          ImageIndex = 5
          object GroupBox13: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #28216#25103#26085#24535#26381#21153#22120#35774#32622
            TabOrder = 0
            object GroupBox14: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label17: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label18: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditLogServer_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLogServer_MainFormXChange
              end
              object EditLogServer_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLogServer_MainFormYChange
              end
            end
            object ButtonLogServerDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = #40664#35748#35774#32622'(&D)'
              TabOrder = 1
              OnClick = ButtonLogServerDefaultClick
            end
            object GroupBox37: TGroupBox
              Left = 8
              Top = 96
              Width = 129
              Height = 41
              Caption = #26159#21542#21551#21160
              TabOrder = 2
              object CheckBoxLogServerGetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 113
                Height = 17
                Caption = #21551#21160#26085#24535#26381#21153#22120
                TabOrder = 0
                OnClick = CheckBoxLogServerGetStartClick
              end
            end
            object GroupBox38: TGroupBox
              Left = 144
              Top = 16
              Width = 209
              Height = 73
              Caption = #32593#32476#31471#21475
              TabOrder = 3
              object Label54: TLabel
                Left = 8
                Top = 20
                Width = 54
                Height = 12
                Caption = #32593#32476#31471#21475':'
              end
              object EditLogServerPort: TEdit
                Left = 64
                Top = 16
                Width = 41
                Height = 20
                TabOrder = 0
                Text = '10000'
              end
            end
          end
          object ButtonPrv7: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 1
            OnClick = ButtonPrv7Click
          end
          object ButtonNext7: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 2
            OnClick = ButtonNext7Click
          end
        end
        object TabSheet10: TTabSheet
          Caption = #31532#20843#27493'('#28216#25103#24341#25806#20027#26381#21153#22120')'
          ImageIndex = 6
          object GroupBox15: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #28216#25103#24341#25806#26381#21153#22120#35774#32622
            TabOrder = 0
            object GroupBox16: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label19: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label20: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditM2Server_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditM2Server_MainFormXChange
              end
              object EditM2Server_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditM2Server_MainFormYChange
              end
            end
            object ButtonM2ServerDefault: TButton
              Left = 400
              Top = 144
              Width = 81
              Height = 25
              Caption = #40664#35748#35774#32622'(&D)'
              TabOrder = 1
              OnClick = ButtonM2ServerDefaultClick
            end
            object GroupBox39: TGroupBox
              Left = 144
              Top = 16
              Width = 185
              Height = 73
              Caption = #21069#32622#26381#21153#22120#31471#21475
              TabOrder = 2
              object Label55: TLabel
                Left = 8
                Top = 20
                Width = 54
                Height = 12
                Caption = #36830#25509#31471#21475':'
              end
              object Label56: TLabel
                Left = 8
                Top = 44
                Width = 54
                Height = 12
                Caption = #36890#35759#31471#21475':'
              end
              object EditM2ServerGatePort: TEdit
                Left = 64
                Top = 16
                Width = 41
                Height = 20
                TabOrder = 0
                Text = '5000'
              end
              object EditM2ServerMsgSrvPort: TEdit
                Left = 64
                Top = 40
                Width = 41
                Height = 20
                TabOrder = 1
                Text = '4900'
              end
            end
            object GroupBox40: TGroupBox
              Left = 8
              Top = 96
              Width = 193
              Height = 41
              Caption = #26159#21542#21551#21160
              TabOrder = 3
              object CheckBoxM2ServerGetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 169
                Height = 17
                Caption = #21551#21160#28216#25103#26381#21153#22120
                TabOrder = 0
                OnClick = CheckBoxM2ServerGetStartClick
              end
            end
          end
          object ButtonPrv8: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 1
            OnClick = ButtonPrv8Click
          end
          object ButtonNext8: TButton
            Left = 407
            Top = 265
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 2
            OnClick = ButtonNext8Click
          end
        end
        object TabSheet11: TTabSheet
          Caption = #31532#20061#27493'('#20445#23384#37197#32622')'
          ImageIndex = 7
          object ButtonSave: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #20445#23384'(&S)'
            TabOrder = 0
            OnClick = ButtonSaveClick
          end
          object ButtonGenGameConfig: TButton
            Left = 232
            Top = 263
            Width = 81
            Height = 33
            Caption = #29983#25104#37197#32622'(&G)'
            TabOrder = 1
            OnClick = ButtonGenGameConfigClick
          end
          object ButtonPrv9: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 2
            OnClick = ButtonPrv9Click
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #25968#25454#22791#20221
      ImageIndex = 2
      object LabelBackMsg: TLabel
        Left = 384
        Top = 304
        Width = 6
        Height = 12
        Font.Charset = GB2312_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 8
        Width = 497
        Height = 153
        Caption = #22791#20221#21015#34920
        TabOrder = 0
        object ListViewDataBackup: TListView
          Left = 8
          Top = 16
          Width = 481
          Height = 129
          Columns = <
            item
              Caption = #25968#25454#30446#24405
              Width = 220
            end
            item
              Caption = #22791#20221#30446#24405
              Width = 220
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewDataBackupClick
        end
      end
      object GroupBox6: TGroupBox
        Left = 8
        Top = 168
        Width = 497
        Height = 121
        Caption = #32534#36753
        TabOrder = 1
        object Label5: TLabel
          Left = 8
          Top = 20
          Width = 54
          Height = 12
          Caption = #25968#25454#30446#24405':'
        end
        object Label6: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = #22791#20221#30446#24405':'
        end
        object Label7: TLabel
          Left = 120
          Top = 68
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label8: TLabel
          Left = 200
          Top = 68
          Width = 12
          Height = 12
          Caption = #20998
        end
        object Label64: TLabel
          Left = 116
          Top = 92
          Width = 24
          Height = 12
          Caption = #23567#26102
        end
        object Label65: TLabel
          Left = 200
          Top = 92
          Width = 12
          Height = 12
          Caption = #20998
        end
        object RadioButtonBackMode1: TRadioButton
          Left = 8
          Top = 64
          Width = 49
          Height = 17
          Caption = #27599#22825
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = RadioButtonBackMode1Click
        end
        object RzButtonEditSource: TRzButtonEdit
          Left = 64
          Top = 16
          Width = 425
          Height = 20
          TabOrder = 1
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = RzButtonEditSourceButtonClick
        end
        object RzButtonEditDest: TRzButtonEdit
          Left = 64
          Top = 40
          Width = 425
          Height = 20
          TabOrder = 2
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = RzButtonEditDestButtonClick
        end
        object RadioButtonBackMode2: TRadioButton
          Left = 8
          Top = 88
          Width = 49
          Height = 17
          Caption = #27599#38548
          TabOrder = 3
          OnClick = RadioButtonBackMode2Click
        end
        object RzSpinEditHour1: TRzSpinEdit
          Left = 64
          Top = 64
          Width = 47
          Height = 20
          Max = 23.000000000000000000
          TabOrder = 4
        end
        object RzSpinEditHour2: TRzSpinEdit
          Left = 64
          Top = 88
          Width = 47
          Height = 20
          Max = 10000000000.000000000000000000
          TabOrder = 5
        end
        object RzSpinEditMin1: TRzSpinEdit
          Left = 144
          Top = 64
          Width = 47
          Height = 20
          Max = 59.000000000000000000
          TabOrder = 6
        end
        object CheckBoxBackUp: TCheckBox
          Left = 224
          Top = 80
          Width = 49
          Height = 17
          Caption = #22791#20221
          Checked = True
          State = cbChecked
          TabOrder = 7
        end
        object RzSpinEditMin2: TRzSpinEdit
          Left = 144
          Top = 88
          Width = 47
          Height = 20
          Max = 59.000000000000000000
          TabOrder = 8
        end
        object CheckBoxZip: TCheckBox
          Left = 288
          Top = 80
          Width = 49
          Height = 17
          Caption = #21387#32553
          Checked = True
          State = cbChecked
          TabOrder = 9
        end
        object CheckBoxAutoRunBak: TCheckBox
          Left = 349
          Top = 80
          Width = 128
          Height = 17
          Caption = #33258#21160#36816#34892#22791#20221#31995#32479
          TabOrder = 10
          OnClick = CheckBoxAutoRunBakClick
        end
      end
      object ButtonBackChg: TButton
        Left = 8
        Top = 296
        Width = 65
        Height = 25
        Caption = #20462#25913'(&C)'
        TabOrder = 2
        OnClick = ButtonBackChgClick
      end
      object ButtonBackDel: TButton
        Left = 80
        Top = 296
        Width = 65
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonBackDelClick
      end
      object ButtonBackAdd: TButton
        Left = 153
        Top = 295
        Width = 65
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 4
        OnClick = ButtonBackAddClick
      end
      object ButtonBackStart: TButton
        Left = 295
        Top = 295
        Width = 75
        Height = 25
        Caption = #21551#21160'(&B)'
        TabOrder = 5
        OnClick = ButtonBackStartClick
      end
      object ButtonBackSave: TButton
        Left = 224
        Top = 296
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonBackSaveClick
      end
    end
    object TabSheet13: TTabSheet
      Caption = #24320#21306#25968#25454#28165#29702
      ImageIndex = 5
      object GroupBox25: TGroupBox
        Left = 8
        Top = 8
        Width = 497
        Height = 190
        Caption = #28165#29702#36873#39033
        TabOrder = 0
        object CheckBox1: TCheckBox
          Left = 16
          Top = 20
          Width = 97
          Height = 17
          Caption = #21024#38500#20154#29289#25968#25454
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object CheckBox2: TCheckBox
          Left = 16
          Top = 43
          Width = 97
          Height = 17
          Caption = #21024#38500#24080#21495#25968#25454
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object CheckBox3: TCheckBox
          Left = 16
          Top = 66
          Width = 97
          Height = 17
          Caption = #21024#38500#34892#20250#25968#25454
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object CheckBox4: TCheckBox
          Left = 16
          Top = 89
          Width = 113
          Height = 17
          Caption = #28165#31354#27801#24052#20811#25968#25454
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object CheckBox5: TCheckBox
          Left = 16
          Top = 112
          Width = 113
          Height = 17
          Caption = #28165#31354#20840#23616#21464#37327
          TabOrder = 4
        end
        object CheckBox6: TCheckBox
          Left = 16
          Top = 135
          Width = 113
          Height = 17
          Caption = #22797#20301#29289#21697'ID'#35745#25968
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
        object CheckBox7: TCheckBox
          Left = 16
          Top = 158
          Width = 168
          Height = 17
          Caption = #28165#31354#20986#24072#12289#31163#23130#12289#26029#20132#25968#25454
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object CheckBox8: TCheckBox
          Left = 208
          Top = 20
          Width = 121
          Height = 17
          Caption = #21024#38500'NPC'#25171#36896#25968#25454
          Checked = True
          State = cbChecked
          TabOrder = 7
        end
        object CheckBox9: TCheckBox
          Left = 208
          Top = 43
          Width = 121
          Height = 17
          Caption = #21024#38500'EMail'#25968#25454
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
        object CheckBox10: TCheckBox
          Left = 208
          Top = 66
          Width = 121
          Height = 17
          Caption = #21024#38500#24080#21495#26085#24535#35760#24405
          Checked = True
          State = cbChecked
          TabOrder = 9
        end
        object CheckBox11: TCheckBox
          Left = 208
          Top = 89
          Width = 121
          Height = 17
          Caption = #21024#38500#24341#25806#26085#24535#35760#24405
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
        object CheckBox12: TCheckBox
          Left = 208
          Top = 112
          Width = 121
          Height = 17
          Caption = #21024#38500#28216#25103#26085#24535#35760#24405
          Checked = True
          State = cbChecked
          TabOrder = 11
        end
      end
      object Button1: TButton
        Left = 174
        Top = 226
        Width = 139
        Height = 25
        Caption = #24320#22987#28165#29702'(&S)'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
  end
  object TimerStartGame: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerStartGameTimer
    Left = 8
    Top = 304
  end
  object TimerStopGame: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerStopGameTimer
    Left = 40
    Top = 304
  end
  object TimerCheckRun: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = TimerCheckRunTimer
    Left = 72
    Top = 304
  end
end
