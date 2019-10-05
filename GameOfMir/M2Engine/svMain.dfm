object FrmMain: TFrmMain
  Left = 549
  Top = 307
  ClientHeight = 339
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzSplitter: TRzSplitter
    Left = 0
    Top = 235
    Width = 435
    Height = 104
    Orientation = orVertical
    Position = 55
    Percent = 53
    SplitterWidth = 2
    Align = alClient
    BorderShadow = clBtnFace
    Color = 16744448
    TabOrder = 0
    ExplicitHeight = 84
    BarSize = (
      0
      55
      435
      57)
    UpperLeftControls = ()
    LowerRightControls = (
      RzSplitter1)
    object RzSplitter1: TRzSplitter
      Left = 0
      Top = 0
      Width = 435
      Height = 47
      Orientation = orVertical
      Position = 0
      Percent = 0
      SplitterWidth = 0
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 27
      BarSize = (
        0
        0
        435
        0)
      UpperLeftControls = ()
      LowerRightControls = ()
    end
  end
  object MemoLog: TMemo
    Left = 0
    Top = 0
    Width = 435
    Height = 176
    Align = alTop
    BevelInner = bvNone
    Color = clBlack
    Ctl3D = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = MemoLogChange
    OnDblClick = MemoLogDblClick
    OnKeyPress = MemoLogKeyPress
  end
  object GridGate: TStringGrid
    Left = 0
    Top = 235
    Width = 435
    Height = 104
    Align = alClient
    ColCount = 7
    Ctl3D = True
    DefaultRowHeight = 15
    FixedCols = 0
    RowCount = 8
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentCtl3D = False
    TabOrder = 2
    ExplicitHeight = 84
    ColWidths = (
      28
      110
      56
      54
      52
      50
      56)
  end
  object Panel1: TPanel
    Left = 0
    Top = 176
    Width = 435
    Height = 59
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object LbUserCount: TLabel
      Left = 361
      Top = 3
      Width = 66
      Height = 12
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'LbUserCount'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      Transparent = False
    end
    object LbRunTime: TLabel
      Left = 373
      Top = 16
      Width = 54
      Height = 12
      Alignment = taRightJustify
      Caption = 'LbRunTime'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 6
      Top = 29
      Width = 42
      Height = 12
      Caption = 'Label20'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 6
      Top = 16
      Width = 36
      Height = 12
      Caption = 'Label2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 3
      Width = 36
      Height = 12
      Caption = 'Label1'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabelMon: TLabel
      Left = 6
      Top = 43
      Width = 48
      Height = 12
      Caption = 'LabelMon'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabelVersion: TLabel
      Left = 355
      Top = 43
      Width = 72
      Height = 12
      Alignment = taRightJustify
      Caption = 'LabelVersion'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    Left = 60
    Top = 12
  end
  object RunTimer: TTimer
    Enabled = False
    Interval = 1
    Left = 96
    Top = 12
  end
  object DBSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 6000
    OnConnect = DBSocketConnect
    OnDisconnect = DBSocketDisconnect
    OnRead = DBSocketRead
    OnError = DBSocketError
    Left = 24
    Top = 48
  end
  object ConnectTimer: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = ConnectTimerTimer
    Left = 60
    Top = 48
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 100
    Left = 132
    Top = 12
  end
  object SaveVariableTimer: TTimer
    Enabled = False
    Interval = 10000
    Left = 167
    Top = 12
  end
  object CloseTimer: TTimer
    Enabled = False
    Interval = 100
    Left = 96
    Top = 48
  end
  object MainMenu: TMainMenu
    Left = 167
    Top = 48
    object MENU_CONTROL: TMenuItem
      Caption = #25511#21046'(&C)'
      OnClick = MENU_CONTROLClick
      object MENU_CONTROL_CLEARLOGMSG: TMenuItem
        Caption = #28165#38500#26085#24535'(&C)'
        OnClick = MENU_CONTROL_CLEARLOGMSGClick
      end
      object MENU_CONTROL_RELOAD: TMenuItem
        Caption = #37325#26032#21152#36733'(&R)'
        object MENU_CONTROL_RELOAD_ITEMDB: TMenuItem
          Caption = #29289#21697#25968#25454#24211'(&I)'
          OnClick = MENU_CONTROL_RELOAD_ITEMDBClick
        end
        object MENU_CONTROL_RELOAD_MAGICDB: TMenuItem
          Caption = #25216#33021#25968#25454#24211'(&S)'
          OnClick = MENU_CONTROL_RELOAD_MAGICDBClick
        end
        object MENU_CONTROL_RELOAD_MONSTERDB: TMenuItem
          Caption = #24618#29289#25968#25454#24211'(&M)'
          OnClick = MENU_CONTROL_RELOAD_MONSTERDBClick
        end
        object MENU_CONTROL_RELOAD_MONSTERSAY: TMenuItem
          Caption = #24618#29289#35828#35805#35774#32622'(&M)'
          OnClick = MENU_CONTROL_RELOAD_MONSTERSAYClick
        end
        object MENU_CONTROL_RELOAD_DISABLEMAKE: TMenuItem
          Caption = #25968#25454#21015#34920'(&D)'
          OnClick = MENU_CONTROL_RELOAD_DISABLEMAKEClick
        end
        object MENU_CONTROL_RELOAD_CONF: TMenuItem
          Caption = #21442#25968#35774#32622'(&C)'
          OnClick = MENU_CONTROL_RELOAD_CONFClick
        end
        object QFunctionNPC: TMenuItem
          Caption = #21151#33021#33050#26412'(&Q)'
          OnClick = QFunctionNPCClick
        end
        object QManageNPC: TMenuItem
          Caption = #30331#38470#33050#26412'(&L)'
          OnClick = QManageNPCClick
        end
        object P1: TMenuItem
          Caption = #22320#22270#20107#20214#33050#26412'(&P)'
          object E1: TMenuItem
            Caption = #37325#26032#21152#36733#22320#22270#20107#20214#37197#32622'(&E)'
            OnClick = E1Click
          end
          object S1: TMenuItem
            Caption = #37325#26032#21152#36733#22320#22270#20107#20214#33050#26412'(&S)'
            OnClick = S1Click
          end
        end
        object RobotManageNPC: TMenuItem
          Caption = #26426#22120#20154#33050#26412'(&R)'
          OnClick = RobotManageNPCClick
        end
        object MonItems: TMenuItem
          Caption = #24618#29289#29190#29575'(&M)'
          OnClick = MonItemsClick
        end
        object M1: TMenuItem
          Caption = #25171#36896#21015#34920'(&K)'
          OnClick = M1Click
        end
        object N2: TMenuItem
          Caption = #33050#26412#24120#37327#21015#34920'(&A)'
          OnClick = N2Click
        end
        object B1: TMenuItem
          Caption = #23453#31665#37197#32622'(&B)'
          OnClick = B1Click
        end
        object V1: TMenuItem
          Caption = #20219#21153#25552#31034#37197#32622'(&V)'
          OnClick = V1Click
        end
        object L1: TMenuItem
          Caption = #29983#27963#25216#33021#25171#36896#21015#34920'(&L)'
          OnClick = L1Click
        end
        object NPC1: TMenuItem
          Caption = #25152#26377'NPC'#37197#32622
          OnClick = NPC1Click
        end
        object F1: TMenuItem
          Caption = #36807#28388#21015#34920'(&F)'
          OnClick = F1Click
        end
      end
      object MENU_CONTROL_GATE: TMenuItem
        Caption = #28216#25103#32593#20851'(&G)'
        object MENU_CONTROL_GATE_OPEN: TMenuItem
          Caption = #25171#24320'(&O)'
          OnClick = MENU_CONTROL_GATE_OPENClick
        end
        object MENU_CONTROL_GATE_CLOSE: TMenuItem
          Caption = #20851#38381'(&C)'
          OnClick = MENU_CONTROL_GATE_CLOSEClick
        end
      end
      object MENU_CONTROL_TESTSERVER: TMenuItem
        Caption = #27979#35797#26381#21153#22120'(&T)'
        Visible = False
        OnClick = MENU_CONTROL_TESTSERVERClick
      end
      object MENU_CONTROL_EXIT: TMenuItem
        Caption = #36864#20986'(&X)'
        OnClick = MENU_CONTROL_EXITClick
      end
    end
    object MENU_VIEW: TMenuItem
      Caption = #26597#30475'(&V)'
      object MENU_VIEW_ONLINEHUMAN: TMenuItem
        Caption = #22312#32447#20154#29289'(&O)'
        OnClick = MENU_VIEW_ONLINEHUMANClick
      end
      object MENU_VIEW_SESSION: TMenuItem
        Caption = #20840#23616#20250#35805'(&S)'
        OnClick = MENU_VIEW_SESSIONClick
      end
      object MENU_VIEW_LEVEL: TMenuItem
        Caption = #31561#32423#23646#24615'(&L)'
        OnClick = MENU_VIEW_LEVELClick
      end
      object MENU_VIEW_LIST: TMenuItem
        Caption = #21015#34920#20449#24687'(&L)'
        OnClick = MENU_VIEW_LISTClick
      end
      object MENU_VIEW_COM: TMenuItem
        Caption = #35013#22791#21512#25104'(&C)'
        OnClick = MENU_VIEW_COMClick
      end
      object MENU_VIEW_KERNELINFO: TMenuItem
        Caption = #20869#26680#25968#25454'(&K)'
        OnClick = MENU_VIEW_KERNELINFOClick
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = #36873#39033'(&P)'
      object MENU_OPTION_GENERAL: TMenuItem
        Caption = #22522#26412#35774#32622'(&G)'
        OnClick = MENU_OPTION_GENERALClick
      end
      object MENU_OPTION_GAME: TMenuItem
        Caption = #21442#25968#35774#32622'(&O)'
        OnClick = MENU_OPTION_GAMEClick
      end
      object MENU_OPTION_ITEMFUNC: TMenuItem
        Caption = #29289#21697#35013#22791'(&I)'
        OnClick = MENU_OPTION_ITEMFUNCClick
      end
      object MENU_OPTION_FUNCTION: TMenuItem
        Caption = #21151#33021#35774#32622'(&F)'
        OnClick = MENU_OPTION_FUNCTIONClick
      end
      object G1: TMenuItem
        Caption = #28216#25103#21629#20196'(&C)'
        OnClick = G1Click
      end
      object MENU_OPTION_MONSTER: TMenuItem
        Caption = #24618#29289#35774#32622'(&M)'
        OnClick = MENU_OPTION_MONSTERClick
      end
      object MENU_OPTION_SERVERCONFIG: TMenuItem
        Caption = #24615#33021#21442#25968'(&P)'
        OnClick = MENU_OPTION_SERVERCONFIGClick
      end
    end
    object MENU_MANAGE: TMenuItem
      Caption = #31649#29702'(&M)'
      object MENU_MANAGE_ONLINEMSG: TMenuItem
        Caption = #22312#32447#28040#24687'(&M)'
        OnClick = MENU_MANAGE_ONLINEMSGClick
      end
      object MENU_MANAGE_ONLINEEMAIL: TMenuItem
        Caption = #21457#36865#37038#20214'(&E)'
        OnClick = MENU_MANAGE_ONLINEEMAILClick
      end
      object MENU_MANAGE_PLUG: TMenuItem
        Caption = #21151#33021#25554#20214'(&P)'
        Visible = False
        OnClick = MENU_MANAGE_PLUGClick
      end
      object MENU_MANAGE_CASTLE: TMenuItem
        Caption = #22478#22561#31649#29702'(&C)'
        OnClick = MENU_MANAGE_CASTLEClick
      end
      object MENU_MANAGE_SHOP: TMenuItem
        Caption = #21830#38138#31649#29702'(&S)'
        OnClick = MENU_MANAGE_SHOPClick
      end
    end
    object MENU_TOOLS: TMenuItem
      Caption = #24037#20855'(&T)'
      object MENU_TOOLS_MERCHANT: TMenuItem
        Caption = #20132#26131'NPC'#37197#32622'(&M)'
        OnClick = MENU_TOOLS_MERCHANTClick
      end
      object MENU_TOOLS_NPC: TMenuItem
        Caption = #31649#29702'NPC'#37197#32622'(&N)'
        OnClick = MENU_TOOLS_NPCClick
      end
      object MENU_TOOLS_MONGEN: TMenuItem
        Caption = #21047#24618#37197#32622'(&G)'
        OnClick = MENU_TOOLS_MONGENClick
      end
      object MENU_TOOLS_IPSEARCH: TMenuItem
        Caption = #22320#21306#26597#35810'(&S)'
        OnClick = MENU_TOOLS_IPSEARCHClick
      end
      object MENU_TOOLS_TEST: TMenuItem
        Caption = #27979#35797
        Visible = False
        OnClick = MENU_TOOLS_TESTClick
      end
      object MENU_TOOLS_OFFLINE: TMenuItem
        Caption = #33073#26426#31649#29702'(&O)'
        object MENU_TOOLS_OFFLINE_SAVENAME: TMenuItem
          Caption = #20445#23384#24403#21069#33073#26426#21517#21333'(&S)'
          OnClick = MENU_TOOLS_OFFLINE_SAVENAMEClick
        end
        object MENU_TOOLS_OFFLINE_LOADNAME: TMenuItem
          Caption = #20174#21517#21333#21152#25130#33258#21160#33073#26426'(&A)'
          OnClick = MENU_TOOLS_OFFLINE_LOADNAMEClick
        end
      end
    end
    object MENU_HELP: TMenuItem
      Caption = #24110#21161'(&H)'
      object MENU_HELP_ABOUT: TMenuItem
        Caption = #20851#20110'(&A)'
        OnClick = MENU_HELP_ABOUTClick
      end
    end
  end
  object IdUDPClientLog: TIdUDPClient
    BufferSize = 81920
    Port = 0
    Left = 132
    Top = 48
  end
  object OpenDialog: TOpenDialog
    Left = 24
    Top = 12
  end
  object GateSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = GateSocketClientConnect
    OnClientDisconnect = GateSocketClientDisconnect
    OnClientRead = GateSocketClientRead
    OnClientError = GateSocketClientError
    Left = 24
    Top = 80
  end
  object enmsg: TRSA
    CommonalityKey = '421166909'
    CommonalityMode = '78676586259407574469749356447'
    PrivateKey = '71362022359665638368808298557'
    Left = 56
    Top = 80
  end
end
