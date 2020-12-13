object FormChangePass: TFormChangePass
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #20462#25913#23494#30721
  ClientHeight = 349
  ClientWidth = 261
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label8: TLabel
    Left = 14
    Top = 165
    Width = 66
    Height = 12
    Caption = #26381#21153#22120#29366#24577':'
  end
  object Label16: TLabel
    Left = 83
    Top = 165
    Width = 102
    Height = 12
    Caption = #26381#21153#22120#29366#24577#33391#22909'...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 14
    Top = 13
    Width = 227
    Height = 146
    Caption = #20462#25913#29992#25143#23494#30721
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 19
      Width = 54
      Height = 12
      Caption = #30331#24405#36134#21495':'
    end
    object Label2: TLabel
      Left = 10
      Top = 43
      Width = 42
      Height = 12
      Caption = #21407#23494#30721':'
    end
    object Label3: TLabel
      Left = 10
      Top = 67
      Width = 42
      Height = 12
      Caption = #26032#23494#30721':'
    end
    object Label4: TLabel
      Left = 10
      Top = 91
      Width = 66
      Height = 12
      Caption = #30830#35748#26032#23494#30721':'
    end
    object EditName: TEdit
      Left = 78
      Top = 16
      Width = 137
      Height = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      OnKeyPress = EditNameKeyPress
    end
    object EditOldPass: TEdit
      Left = 78
      Top = 40
      Width = 137
      Height = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
      OnKeyPress = EditNameKeyPress
    end
    object EditNewPass: TEdit
      Left = 78
      Top = 64
      Width = 137
      Height = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 2
      OnKeyPress = EditNameKeyPress
    end
    object EditNewPass2: TEdit
      Left = 78
      Top = 88
      Width = 137
      Height = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 3
      OnKeyPress = EditNameKeyPress
    end
    object Button1: TButton
      Left = 30
      Top = 114
      Width = 68
      Height = 25
      Caption = #30830#23450'(&O)'
      TabOrder = 4
      OnClick = Button1Click
    end
    object ButtonClose: TButton
      Left = 126
      Top = 114
      Width = 68
      Height = 25
      Caption = #20851#38381'(&X)'
      ModalResult = 2
      TabOrder = 5
      OnClick = ButtonCloseClick
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 183
    Width = 297
    Height = 202
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnRead = ClientSocketRead
    OnError = ClientSocketError
    Left = 216
    Top = 152
  end
end
