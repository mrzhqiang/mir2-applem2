object FrmBasicSet: TFrmBasicSet
  Left = 648
  Top = 183
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22522#26412#35774#32622
  ClientHeight = 240
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 401
    Height = 193
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22522#26412#35774#32622
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 121
        Height = 97
        Caption = #32593#20851#35774#32622
        TabOrder = 0
        object CheckBoxDisabledCreateID: TCheckBox
          Left = 15
          Top = 21
          Width = 97
          Height = 17
          Caption = #31105#27490#27880#20876#24080#21495
          TabOrder = 0
          OnClick = CheckBoxDisabledCreateIDClick
        end
        object CheckBoxDisabledChangePassword: TCheckBox
          Left = 15
          Top = 44
          Width = 97
          Height = 17
          Caption = #31105#27490#20462#25913#23494#30721
          TabOrder = 1
          OnClick = CheckBoxDisabledChangePasswordClick
        end
        object CheckBoxDisabledLostPassword: TCheckBox
          Left = 15
          Top = 67
          Width = 97
          Height = 17
          Caption = #31105#27490#25214#22238#23494#30721
          TabOrder = 2
          OnClick = CheckBoxDisabledLostPasswordClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #32593#32476#35774#32622
      ImageIndex = 1
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 185
        Height = 65
        Caption = #32593#20851#35774#32622
        TabOrder = 0
        object Label3: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #32465#23450#22320#22336':'
        end
        object Label4: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #32593#20851#31471#21475':'
        end
        object EditGateAddr: TEdit
          Left = 72
          Top = 14
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditGateAddrChange
        end
        object EditGatePort: TEdit
          Left = 72
          Top = 38
          Width = 57
          Height = 20
          TabOrder = 1
          OnChange = EditGatePortChange
        end
      end
      object GroupBox4: TGroupBox
        Left = 199
        Top = 79
        Width = 185
        Height = 65
        Caption = #36828#31243#30417#25511#35774#32622
        TabOrder = 1
        object Label5: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #32465#23450#22320#22336':'
        end
        object Label6: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #32593#20851#31471#21475':'
        end
        object EditMonAddr: TEdit
          Left = 72
          Top = 14
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditMonAddrChange
        end
        object EditMonPort: TEdit
          Left = 72
          Top = 38
          Width = 57
          Height = 20
          TabOrder = 1
          OnChange = EditMonPortChange
        end
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 79
        Width = 185
        Height = 65
        Caption = #26381#21153#22120#32593#32476#35774#32622
        TabOrder = 2
        object Label7: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #32465#23450#22320#22336':'
        end
        object Label8: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20351#29992#31471#21475':'
        end
        object EditServerAddr: TEdit
          Left = 72
          Top = 12
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditServerAddrChange
        end
        object EditServerPort: TEdit
          Left = 72
          Top = 38
          Width = 57
          Height = 20
          TabOrder = 1
          OnChange = EditServerPortChange
        end
      end
      object GroupBox8: TGroupBox
        Left = 199
        Top = 8
        Width = 185
        Height = 65
        Caption = 'SQL'#32593#32476#35774#32622
        TabOrder = 3
        object Label11: TLabel
          Left = 8
          Top = 18
          Width = 48
          Height = 12
          Caption = 'SQL'#22320#22336':'
        end
        object Label12: TLabel
          Left = 8
          Top = 42
          Width = 48
          Height = 12
          Caption = 'SQL'#31471#21475':'
        end
        object EditSQLAddr: TEdit
          Left = 72
          Top = 14
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditSQLAddrChange
        end
        object EditSQLPort: TEdit
          Left = 72
          Top = 38
          Width = 57
          Height = 20
          TabOrder = 1
          OnChange = EditSQLPortChange
        end
      end
    end
  end
  object ButtonSave: TButton
    Left = 253
    Top = 208
    Width = 75
    Height = 25
    Caption = #20445#23384'(&S)'
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
  object ButtonClose: TButton
    Left = 334
    Top = 208
    Width = 75
    Height = 25
    Caption = #30830#23450'(&O)'
    TabOrder = 2
    OnClick = ButtonCloseClick
  end
  object ButtonRestoreNet: TButton
    Left = 172
    Top = 207
    Width = 75
    Height = 26
    Caption = #40664#35748'(&D)'
    TabOrder = 3
    OnClick = ButtonRestoreNetClick
  end
end
