object FormSetup: TFormSetup
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #28216#25103#35774#32622
  ClientHeight = 171
  ClientWidth = 325
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 12
  object TabSet: TTabSet
    Left = 8
    Top = 111
    Width = 305
    Height = 18
    AutoScroll = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    Style = tsModernTabs
    Tabs.Strings = (
      #35270#39057
      #38899#39057)
    TabIndex = 0
    OnChange = TabSetChange
  end
  object btOK: TButton
    Left = 238
    Top = 138
    Width = 75
    Height = 25
    Caption = #30830#23450'(&O)'
    Default = True
    TabOrder = 3
    OnClick = btOKClick
  end
  object btDefault: TButton
    Left = 144
    Top = 138
    Width = 88
    Height = 25
    Caption = #40664#35748#35774#32622'(&D)'
    TabOrder = 4
    OnClick = btDefaultClick
  end
  object Panel2: TPanel
    Left = 8
    Top = 8
    Width = 305
    Height = 97
    TabOrder = 2
    object lbMusic: TLabel
      Left = 251
      Top = 26
      Width = 24
      Height = 12
      Caption = '100%'
    end
    object lbSound: TLabel
      Left = 251
      Top = 54
      Width = 24
      Height = 12
      Caption = '100%'
    end
    object clbMusic: TCheckListBox
      Left = 16
      Top = 19
      Width = 73
      Height = 59
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      ItemHeight = 28
      Items.Strings = (
        #32972#26223#38899#20048
        #28216#25103#38899#25928)
      Style = lbOwnerDrawFixed
      TabOrder = 0
    end
    object tBarMusic: TTrackBar
      Left = 95
      Top = 26
      Width = 150
      Height = 15
      Hint = '1000'
      LineSize = 0
      Max = 100
      ParentShowHint = False
      PageSize = 1
      Frequency = 0
      ShowHint = False
      ShowSelRange = False
      TabOrder = 1
      ThumbLength = 10
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = tBarMusicChange
    end
    object tBarSound: TTrackBar
      Left = 95
      Top = 54
      Width = 150
      Height = 15
      Hint = '1000'
      LineSize = 0
      Max = 100
      ParentShowHint = False
      PageSize = 1
      Frequency = 0
      ShowHint = False
      ShowSelRange = False
      TabOrder = 2
      ThumbLength = 10
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = tBarSoundChange
    end
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 305
    Height = 97
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 42
      Height = 12
      Caption = #26174#31034#22120':'
    end
    object Label2: TLabel
      Left = 16
      Top = 40
      Width = 42
      Height = 12
      Caption = #20998#36776#29575':'
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 42
      Height = 12
      Caption = #33394'  '#28145':'
    end
    object clbDisplay: TCheckListBox
      Left = 200
      Top = 12
      Width = 97
      Height = 76
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      ItemHeight = 24
      Items.Strings = (
        #21551#29992#31383#21475#27169#24335
        #21551#29992#22402#30452#21516#27493
        #21551#29992#32441#29702#21387#32553)
      Style = lbOwnerDrawFixed
      TabOrder = 0
    end
    object cbDisplay: TComboBox
      Left = 64
      Top = 13
      Width = 130
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 1
    end
    object ComboBox2: TComboBox
      Left = 64
      Top = 37
      Width = 97
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 2
      Items.Strings = (
        '800'#215'600['#40664#35748']'
        '1024'#215'600['#23485#23631']'
        '1024'#215'768['#25512#33616']')
    end
    object cbBitDepth: TComboBox
      Left = 64
      Top = 61
      Width = 49
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      ItemIndex = 0
      TabOrder = 3
      Text = '16'#20301
      Items.Strings = (
        '16'#20301
        '32'#20301)
    end
  end
end
