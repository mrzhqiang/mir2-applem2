object FrmDbToSqlite: TFrmDbToSqlite
  Left = 0
  Top = 0
  Caption = '数据库迁移工具 - DBC2000 转 SQLite'
  ClientHeight = 500
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 200
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 60
      Height = 13
      Caption = 'Hum.DB 文件:'
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 60
      Height = 13
      Caption = 'Mir.DB 文件:'
    end
    object Label3: TLabel
      Left = 16
      Top = 96
      Width = 100
      Height = 13
      Caption = 'SQLite 数据库文件:'
    end
    object EdtHumDB: TEdit
      Left = 120
      Top = 13
      Width = 600
      Height = 21
      TabOrder = 0
    end
    object EdtMirDB: TEdit
      Left = 120
      Top = 53
      Width = 600
      Height = 21
      TabOrder = 1
    end
    object EdtSqlite: TEdit
      Left = 120
      Top = 93
      Width = 600
      Height = 21
      TabOrder = 2
    end
    object BtnSelectHumDB: TButton
      Left = 730
      Top = 11
      Width = 60
      Height = 25
      Caption = '浏览...'
      TabOrder = 3
      OnClick = BtnSelectHumDBClick
    end
    object BtnSelectMirDB: TButton
      Left = 730
      Top = 51
      Width = 60
      Height = 25
      Caption = '浏览...'
      TabOrder = 4
      OnClick = BtnSelectMirDBClick
    end
    object BtnSelectSqlite: TButton
      Left = 730
      Top = 91
      Width = 60
      Height = 25
      Caption = '浏览...'
      TabOrder = 5
      OnClick = BtnSelectSqliteClick
    end
    object BtnMigrate: TButton
      Left = 200
      Top = 140
      Width = 120
      Height = 40
      Caption = '开始迁移'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = BtnMigrateClick
    end
    object BtnClose: TButton
      Left = 480
      Top = 140
      Width = 120
      Height = 40
      Caption = '关闭'
      TabOrder = 7
      OnClick = BtnCloseClick
    end
  end
  object MemoLog: TMemo
    Left = 0
    Top = 240
    Width = 800
    Height = 240
    Align = alClient
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 200
    Width = 800
    Height = 40
    Align = alTop
    TabOrder = 2
  end
end

