object FrmDbcToSqlite: TFrmDbcToSqlite
  Left = 0
  Top = 0
  Caption = 'DBC2000 '#36716' SQLite3 '#24037#20855
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    800
    600)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 784
    Height = 584
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    DesignSize = (
      784
      584)
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 111
      Height = 13
      Caption = 'DBC2000 '#25968#25454#24211#30446#24405':'
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 98
      Height = 13
      Caption = 'SQLite '#25968#25454#24211#25991#20214':'
    end
    object Label3: TLabel
      Left = 16
      Top = 112
      Width = 76
      Height = 13
      Caption = #25968#25454#24211#34920#21015#34920':'
    end
    object EdtDatabasePath: TEdit
      Left = 16
      Top = 35
      Width = 600
      Height = 21
      TabOrder = 0
    end
    object BtnSelectDatabase: TButton
      Left = 622
      Top = 33
      Width = 75
      Height = 25
      Caption = #27983#35272'...'
      TabOrder = 1
      OnClick = BtnSelectDatabaseClick
    end
    object EdtSqlitePath: TEdit
      Left = 16
      Top = 83
      Width = 600
      Height = 21
      TabOrder = 2
    end
    object BtnSelectSqlite: TButton
      Left = 622
      Top = 81
      Width = 75
      Height = 25
      Caption = #27983#35272'...'
      TabOrder = 3
      OnClick = BtnSelectSqliteClick
    end
    object CheckBoxExportSchema: TCheckBox
      Left = 16
      Top = 280
      Width = 97
      Height = 17
      Caption = #23548#20986#34920#32467#26500
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object CheckBoxExportData: TCheckBox
      Left = 119
      Top = 280
      Width = 97
      Height = 17
      Caption = #23548#20986#25968#25454
      TabOrder = 7
    end
    object BtnExport: TButton
      Left = 544
      Top = 276
      Width = 75
      Height = 25
      Caption = #24320#22987#23548#20986
      TabOrder = 8
      OnClick = BtnExportClick
    end
    object BtnClose: TButton
      Left = 625
      Top = 276
      Width = 75
      Height = 25
      Caption = #20851#38381
      TabOrder = 9
      OnClick = BtnCloseClick
    end
    object MemoLog: TMemo
      Left = 16
      Top = 307
      Width = 752
      Height = 230
      Anchors = [akLeft, akTop, akRight, akBottom]
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 10
    end
    object ProgressBar: TProgressBar
      Left = 16
      Top = 543
      Width = 752
      Height = 17
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 11
    end
    object ListBoxTables: TListBox
      Left = 16
      Top = 131
      Width = 600
      Height = 139
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 4
    end
    object BtnRefreshTables: TButton
      Left = 622
      Top = 131
      Width = 75
      Height = 25
      Caption = #21047#26032#34920#21015#34920
      TabOrder = 5
      OnClick = BtnRefreshTablesClick
    end
  end
end
