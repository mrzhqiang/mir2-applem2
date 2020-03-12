object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '361M2'#26381#21153#31471#31649#29702#24037#20855' V2.5 (SQL'#29256')'
  ClientHeight = 261
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 425
    Height = 209
    Caption = #26085#24535#31383#21475
    TabOrder = 0
    object MemoLog: TMemo
      Left = 9
      Top = 16
      Width = 407
      Height = 186
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 242
    Width = 440
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = '7700'
        Width = 40
      end
      item
        Alignment = taCenter
        Text = '[0]'
        Width = 30
      end
      item
        Text = ' '#39564#35777#65306'0'
        Width = 90
      end
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = ' '#30331#24405#22120#65306'0'
        Width = 102
      end
      item
        Text = ' '#24341#25806#65306'0'
        Width = 90
      end
      item
        Width = 50
      end>
    ExplicitTop = 222
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 48
    object MENU_ACCOUNT: TMenuItem
      Caption = #24080#25143'(&A)'
      object MENU_ACCOUNT_MANAGE: TMenuItem
        Caption = #24080#25143#31649#29702'(&M)'
        OnClick = MENU_ACCOUNT_MANAGEClick
      end
    end
    object S1: TMenuItem
      Caption = #35774#32622'(&S)'
      object N2: TMenuItem
        Caption = #28165#29702#26410#29983#25104#25968#25454'(&C)'
        OnClick = N2Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object T1: TMenuItem
        Caption = #27979#35797#27169#24335'(&T)'
        OnClick = T1Click
      end
      object N201103111: TMenuItem
        Caption = '2011-03-12'#26356#26032'(&U)'
        OnClick = N201103111Click
      end
    end
    object H1: TMenuItem
      Caption = #24110#21161'(&H)'
      object A2: TMenuItem
        Caption = #20851#20110'(&A)'
      end
    end
  end
  object SSocket: TServerSocket
    Active = False
    Address = '0.0.0.0'
    Port = 7800
    ServerType = stNonBlocking
    OnListen = SSocketListen
    OnClientConnect = SSocketClientConnect
    OnClientDisconnect = SSocketClientDisconnect
    OnClientRead = SSocketClientRead
    OnClientError = SSocketClientError
    Left = 88
    Top = 48
  end
  object StartTimer: TTimer
    Interval = 200
    OnTimer = StartTimerTimer
    Left = 120
    Top = 48
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 152
    Top = 47
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 184
    Top = 48
  end
  object DecodeTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = DecodeTimerTimer
    Left = 216
    Top = 48
  end
  object CHECKRSA: TRSA
    CommonalityMode = '1019792440150204761367420205883145987530635720731440113'
    PrivateKey = '1'
    Server = True
    Left = 248
    Top = 48
  end
  object LISTRSA: TRSA
    CommonalityMode = '859155539878932763694923350143'
    PrivateKey = '1'
    Server = True
    Left = 280
    Top = 48
  end
  object ADDRSRSA: TRSA
    CommonalityMode = '486041964784552904735358570911'
    PrivateKey = '1'
    Server = True
    Left = 312
    Top = 48
  end
  object TOOLSRSA: TRSA
    CommonalityKey = '732212959'
    CommonalityMode = '964913030490212291072611329949'
    PrivateKey = '1'
    Server = True
    Left = 344
    Top = 48
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Compressor = IdCompressorZLibEx1
    Left = 24
    Top = 80
  end
  object IdCompressorZLibEx1: TIdCompressorZLibEx
    Left = 56
    Top = 80
  end
  object ADRSA: TRSA
    CommonalityKey = '65537'
    CommonalityMode = '84637663316415018074435415671'
    PrivateKey = '1'
    Server = True
    Left = 376
    Top = 48
  end
  object ShareRSA: TRSA
    CommonalityKey = '438932551'
    CommonalityMode = '430722197387646401855452920803'
    PrivateKey = '285569886502809593162490792151'
    Server = True
    Left = 120
    Top = 80
  end
  object ADOConnection: TADOConnection
    CommandTimeout = 20
    ConnectionTimeout = 10
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    AfterConnect = ADOConnectionAfterConnect
    BeforeConnect = ADOConnectionBeforeConnect
    OnDisconnect = ADOConnectionDisconnect
    OnLogin = ADOConnectionLogin
    Left = 24
    Top = 112
  end
  object UserLogin: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'UserLogin'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@Account'
        DataType = ftString
        Size = 30
        Value = #39#39
      end
      item
        Name = '@LoginAddress'
        DataType = ftString
        Size = 18
        Value = #39#39
      end
      item
        Name = '@Password'
        DataType = ftString
        Direction = pdOutput
        Size = 20
        Value = #39#39
      end
      item
        Name = '@Active'
        DataType = ftBoolean
        Direction = pdOutput
        Size = 1
        Value = False
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Direction = pdOutput
        Size = 10
        Value = 0
      end
      item
        Name = '@IsAdmin'
        DataType = ftBoolean
        Direction = pdOutput
        Size = 1
        Value = False
      end
      item
        Name = '@IsAgent'
        DataType = ftBoolean
        Direction = pdOutput
        Size = 1
        Value = False
      end
      item
        Name = '@BindCount'
        DataType = ftInteger
        Direction = pdOutput
        Size = 10
        Value = 0
      end
      item
        Name = '@Money'
        DataType = ftInteger
        Direction = pdOutput
        Size = 10
        Value = 0
      end
      item
        Name = '@AgentM2'
        DataType = ftInteger
        Direction = pdOutput
        Size = 10
        Value = 0
      end
      item
        Name = '@AgentLogin'
        DataType = ftInteger
        Direction = pdOutput
        Size = 10
        Value = 0
      end
      item
        Name = '@ResetCount'
        DataType = ftInteger
        Direction = pdOutput
        Size = 10
        Value = 0
      end
      item
        Name = '@PackEN'
        DataType = ftBoolean
        Direction = pdOutput
        Size = 1
        Value = False
      end
      item
        Name = '@UrlList'
        DataType = ftString
        Direction = pdOutput
        Size = 255
        Value = #39#39
      end>
    Left = 24
    Top = 152
  end
  object GetBindPCList: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'GetBindPCList'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Size = 10
        Value = 0
      end>
    Left = 56
    Top = 152
  end
  object SetDownLoginInfo: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'SetDownLoginInfo'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Size = 10
        Value = 0
      end
      item
        Name = '@SetType'
        DataType = ftInteger
        Size = 10
        Value = 0
      end
      item
        Name = '@Version'
        DataType = ftString
        Size = 24
        Value = #39#39
      end
      item
        Name = '@GameName'
        DataType = ftString
        Size = 12
        Value = #39#39
      end
      item
        Name = '@GameNameMD5'
        DataType = ftString
        Size = 32
        Value = #39#39
      end
      item
        Name = '@MD5'
        DataType = ftString
        Direction = pdInputOutput
        Size = 32
        Value = #39#39
      end
      item
        Name = '@ListID'
        DataType = ftInteger
        Direction = pdOutput
        Size = 10
        Value = 0
      end
      item
        Name = '@PublicID'
        DataType = ftString
        Direction = pdOutput
        Size = 20
        Value = #39#39
      end
      item
        Name = '@UrlList'
        DataType = ftString
        Direction = pdOutput
        Size = 255
        Value = #39#39
      end>
    Left = 88
    Top = 152
  end
  object SetDownM2ServerInfo: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'SetDownM2ServerInfo'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Size = 10
        Value = 0
      end
      item
        Name = '@SetType'
        DataType = ftInteger
        Size = 10
        Value = 0
      end
      item
        Name = '@Version'
        DataType = ftString
        Size = 24
        Value = #39#39
      end
      item
        Name = '@MD5'
        DataType = ftString
        Direction = pdInputOutput
        Size = 32
        Value = #39#39
      end
      item
        Name = '@ListID'
        DataType = ftInteger
        Direction = pdOutput
        Size = 10
        Value = 0
      end
      item
        Name = '@GUID'
        DataType = ftString
        Direction = pdOutput
        Size = 38
        Value = #39#39
      end>
    Left = 120
    Top = 152
  end
  object ChangeBindInfo: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'ChangeBindInfo'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Direction = pdInputOutput
        Size = 10
        Value = 0
      end
      item
        Name = '@AccountID'
        DataType = ftInteger
        Direction = pdInputOutput
        Size = 10
        Value = 0
      end>
    Left = 152
    Top = 152
  end
  object AgentRegM2: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'AgentRegM2'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Size = 10
        Value = 0
      end
      item
        Name = '@Account'
        DataType = ftString
        Size = 30
        Value = #39#39
      end
      item
        Name = '@Count'
        DataType = ftInteger
        Size = 10
        Value = 0
      end>
    Left = 184
    Top = 152
  end
  object AgentRegLogin: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'AgentRegLogin'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Size = 10
        Value = 0
      end
      item
        Name = '@Account'
        DataType = ftString
        Size = 30
        Value = #39#39
      end
      item
        Name = '@UrlList'
        DataType = ftString
        Size = 255
        Value = #39#39
      end
      item
        Name = '@QQ'
        DataType = ftInteger
        Size = 10
        Value = 0
      end
      item
        Name = '@GUID'
        DataType = ftString
        Size = 38
        Value = #39#39
      end
      item
        Name = '@PublicID'
        DataType = ftString
        Size = 20
        Value = #39#39
      end>
    Left = 216
    Top = 152
  end
  object BindPC: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'BindPC'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Size = 10
        Value = 0
      end
      item
        Name = '@Password'
        DataType = ftString
        Size = 20
        Value = #39#39
      end
      item
        Name = '@PCMark'
        DataType = ftString
        Size = 40
        Value = #39#39
      end
      item
        Name = '@PublicMark'
        DataType = ftString
        Size = 16
        Value = #39#39
      end
      item
        Name = '@IPAddress'
        DataType = ftString
        Size = 18
        Value = #39#39
      end>
    Left = 248
    Top = 152
  end
  object CheckPC: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'CheckPC'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Size = 10
        Value = 0
      end
      item
        Name = '@BindPC'
        DataType = ftBoolean
        Size = 1
        Value = False
      end
      item
        Name = '@BindIP'
        DataType = ftBoolean
        Size = 1
        Value = False
      end
      item
        Name = '@PCMark'
        DataType = ftString
        Size = 40
        Value = #39#39
      end
      item
        Name = '@IPAddress'
        DataType = ftString
        Size = 18
        Value = #39#39
      end
      item
        Name = '@PCName'
        DataType = ftString
        Size = 16
        Value = #39#39
      end>
    Left = 280
    Top = 152
  end
  object CheckMD5: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'CheckMD5'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@PublicID'
        DataType = ftString
        Size = 20
        Value = #39#39
      end
      item
        Name = '@MD5'
        DataType = ftString
        Size = 32
        Value = #39#39
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Direction = pdOutput
        Size = 10
        Value = 0
      end
      item
        Name = '@BindPC'
        DataType = ftBoolean
        Direction = pdOutput
        Size = 1
        Value = False
      end
      item
        Name = '@BindIP'
        DataType = ftBoolean
        Direction = pdOutput
        Size = 1
        Value = False
      end>
    Left = 312
    Top = 152
  end
  object SetName: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'SetName'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@Account'
        DataType = ftString
        Size = 30
        Value = #39#39
      end
      item
        Name = '@PublicID'
        DataType = ftString
        Direction = pdOutput
        Size = 20
        Value = #39#39
      end>
    Left = 344
    Top = 152
  end
  object CheckOK: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'CheckOK'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Size = 10
        Value = 0
      end>
    Left = 376
    Top = 152
  end
  object ChangePassword: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'ChangePassword'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end
      item
        Name = '@ID'
        DataType = ftInteger
        Size = 10
        Value = 0
      end
      item
        Name = '@Password'
        DataType = ftString
        Direction = pdInputOutput
        Size = 20
        Value = #39#39
      end>
    Left = 24
    Top = 184
  end
  object TestConnect: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'TestConnect'
    Parameters = <
      item
        Name = '@Return_Value'
        DataType = ftInteger
        Direction = pdReturnValue
        Size = 10
        Value = 0
      end>
    Left = 56
    Top = 184
  end
  object PackENRSA: TRSA
    CommonalityKey = '661093877'
    CommonalityMode = '133868792560389331997065127'
    PrivateKey = '30156305415518470408373165'
    Server = True
    Left = 152
    Top = 80
  end
end
