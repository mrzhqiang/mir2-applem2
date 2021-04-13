object FrmDlg: TFrmDlg
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FrmDlg'
  ClientHeight = 612
  ClientWidth = 1011
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DBackground: TDWindow
    Left = 0
    Top = 0
    Width = 434
    Height = 362
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseDown = DBackgroundMouseDown
    OnBackgroundClick = DBackgroundBackgroundClick
    Caption = 'DBackground'
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DWinSelServer: TDWindow
    Left = 8
    Top = 8
    Width = 169
    Height = 120
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWinSelServerDirectPaint
    OnMouseMove = DWinSelServerMouseMove
    OnClick = DWinSelServerClick
    OnVisible = DWinSelServerVisible
    Caption = #36873#25321#26381#21153#22120
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DWndHint: TDWindow
    Left = 183
    Top = 8
    Width = 169
    Height = 73
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWndHintDirectPaint
    OnKeyDown = DWndHintKeyDown
    OnVisible = DWndHintVisible
    Caption = #25552#31034#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DBTHintClose: TDButton
    Left = 239
    Top = 24
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTHintCloseDirectPaint
    OnClick = DBTHintCloseClick
    Caption = #21462#28040
    DParent = DWndHint
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DLogIn: TDWindow
    Left = 8
    Top = 134
    Width = 169
    Height = 109
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLogInDirectPaint
    Caption = #30331#24405#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DLoginClose: TDButton
    Left = 64
    Top = 216
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DLoginCloseClick
    Caption = #36820#22238
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DLoginOk: TDButton
    Left = 17
    Top = 216
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DWinSelServerExitClick
    Caption = #30331#24405
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DLoginChgPw: TDButton
    Left = 122
    Top = 162
    Width = 52
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLoginHomeDirectPaint
    OnClick = DLoginChgPwClick
    Caption = #20462#25913#23494#30721
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DLoginNew: TDButton
    Left = 122
    Top = 135
    Width = 50
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLoginHomeDirectPaint
    OnClick = DLoginNewClick
    Caption = #27880#20876#36890#34892#35777
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DEditID: TDEdit
    Left = 17
    Top = 134
    Width = 80
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deCDKey
    FrameColor = clBlack
    MaxLength = 10
    CloseSpace = True
    boTransparent = True
  end
  object DEditPass: TDEdit
    Left = 17
    Top = 157
    Width = 80
    Height = 16
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 20
    boTransparent = True
  end
  object DLoginHome: TDButton
    Left = 122
    Top = 189
    Width = 50
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLoginHomeDirectPaint
    OnClick = DLoginHomeClick
    Caption = #23448#26041#32593#31449
    DParent = DLogIn
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DLoginExit: TDButton
    Left = 122
    Top = 216
    Width = 50
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DWinSelServerExitClick
    Caption = #36864#20986#28216#25103
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DNewAccount: TDWindow
    Left = 183
    Top = 134
    Width = 169
    Height = 109
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DNewAccountDirectPaint
    Caption = #21019#24314#24080#21495#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DNewAccountOk: TDButton
    Left = 280
    Top = 216
    Width = 31
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DWinSelServerExitClick
    Caption = #25552#20132
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DNewAccountCancel: TDButton
    Left = 312
    Top = 216
    Width = 31
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DWinSelServerExitClick
    Caption = #36820#22238
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DEditNewId: TDEdit
    Left = 192
    Top = 134
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deCDKey
    FrameColor = clBlack
    MaxLength = 10
    boTransparent = True
  end
  object DEditNewPasswd: TDEdit
    Left = 192
    Top = 157
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DEditConfirm: TDEdit
    Left = 192
    Top = 180
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DEditYourName: TDEdit
    Left = 192
    Top = 203
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 12
    boTransparent = True
  end
  object DEditBirthDay: TDEdit
    Left = 192
    Top = 226
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 10
    boTransparent = True
  end
  object DEditQuiz1: TDEdit
    Left = 223
    Top = 134
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 20
    boTransparent = True
  end
  object DEditAnswer1: TDEdit
    Left = 223
    Top = 157
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 20
    boTransparent = True
  end
  object DEditQuiz2: TDEdit
    Left = 223
    Top = 180
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 20
    boTransparent = True
  end
  object DEditAnswer2: TDEdit
    Left = 223
    Top = 203
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 20
    boTransparent = True
  end
  object DEditEMail: TDEdit
    Left = 254
    Top = 134
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 30
    boTransparent = True
  end
  object DEditPhone: TDEdit
    Left = 254
    Top = 157
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 14
    boTransparent = True
  end
  object DEditMobPhone: TDEdit
    Left = 254
    Top = 180
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 14
    boTransparent = True
  end
  object DEditRecommendation: TDEdit
    Left = 254
    Top = 203
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DChgPw: TDWindow
    Left = 358
    Top = 134
    Width = 161
    Height = 109
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DNewAccountDirectPaint
    Caption = #20462#25913#23494#30721#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DChgpwOk: TDButton
    Left = 389
    Top = 212
    Width = 49
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DWinSelServerExitClick
    Caption = #25552#20132
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DChgpwCancel: TDButton
    Left = 452
    Top = 212
    Width = 49
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DWinSelServerExitClick
    Caption = #36820#22238
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DEditChgId: TDEdit
    Left = 358
    Top = 134
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deCDKey
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DEditChgCurrentpw: TDEdit
    Left = 358
    Top = 157
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DEditChgNewPw: TDEdit
    Left = 358
    Top = 180
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DEditChgRepeat: TDEdit
    Left = 358
    Top = 203
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DMsgDlg: TDWindow
    Left = 358
    Top = 8
    Width = 161
    Height = 120
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMsgDlgDirectPaint
    OnKeyDown = DMsgDlgKeyDown
    OnInRealArea = DMsgDlgInRealArea
    Caption = #28040#24687#26694#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    ClickCount = csNone
    Floating = True
    EscExit = False
    ControlStyle = dsNone
  end
  object DMsgDlgOk: TDButton
    Left = 365
    Top = 95
    Width = 69
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMsgDlgOkClick
    Caption = #30830#23450
    DParent = DMsgDlg
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMsgDlgCancel: TDButton
    Left = 440
    Top = 95
    Width = 69
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMsgDlgOkClick
    Caption = #21462#28040
    DParent = DMsgDlg
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSelectChr: TDWindow
    Left = 8
    Top = 249
    Width = 169
    Height = 128
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #36873#25321#20154#29289#32972#26223#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DscSelect1: TDButton
    Left = 8
    Top = 272
    Width = 57
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #36873#25321'1'
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csStone
  end
  object DscSelect2: TDButton
    Left = 8
    Top = 301
    Width = 57
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #36873#25321'2'
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csStone
  end
  object DscSelect3: TDButton
    Left = 8
    Top = 331
    Width = 57
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #36873#25321'3'
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csStone
  end
  object DscStart: TDButton
    Left = 71
    Top = 261
    Width = 102
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #36827#20837#28216#25103
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DscNewChr: TDButton
    Left = 71
    Top = 284
    Width = 101
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #21019#24314#20154#29289
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DscEraseChr: TDButton
    Left = 71
    Top = 308
    Width = 101
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #21024#38500#20154#29289
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DscCredits: TDButton
    Left = 71
    Top = 331
    Width = 101
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #24674#22797#20154#29289
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DscExit: TDButton
    Left = 71
    Top = 352
    Width = 101
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #36820#22238#30331#24405#30028#38754
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCreateChr: TDWindow
    Left = 183
    Top = 249
    Width = 169
    Height = 128
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCreateChrDirectPaint
    OnVisible = DCreateChrVisible
    Caption = #21019#24314#20154#29289#31383#21475
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DccWarrior: TDButton
    Left = 183
    Top = 249
    Width = 51
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #25112#22763
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccWizzard: TDButton
    Tag = 1
    Left = 183
    Top = 272
    Width = 50
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #39764#27861#24072
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccMonk: TDButton
    Tag = 2
    Left = 183
    Top = 293
    Width = 50
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #36947#22763
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccJ: TDButton
    Tag = 20
    Left = 279
    Top = 315
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #37329
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccM: TDButton
    Tag = 21
    Left = 314
    Top = 315
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #26408
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccS: TDButton
    Tag = 22
    Left = 253
    Top = 284
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #27700
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccH: TDButton
    Tag = 23
    Left = 288
    Top = 284
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #28779
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccT: TDButton
    Tag = 24
    Left = 323
    Top = 284
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #22303
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccMale: TDButton
    Tag = 10
    Left = 300
    Top = 249
    Width = 23
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnClick = DscSelect1Click
    Caption = #30007
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccFemale: TDButton
    Tag = 11
    Left = 329
    Top = 249
    Width = 23
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnClick = DscSelect1Click
    Caption = #22899
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccClose: TDButton
    Left = 232
    Top = 315
    Width = 41
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #36820#22238
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccOk: TDButton
    Left = 183
    Top = 316
    Width = 40
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #25552#20132
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DRenewChr: TDWindow
    Left = 447
    Top = 444
    Width = 165
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DRenewChrDirectPaint
    OnClick = DRenewChrClick
    Caption = #24674#22797#20154#29289#31383#21475
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DEditChrName: TDEdit
    Left = 239
    Top = 261
    Width = 43
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deStandard
    FrameColor = clBlack
    MaxLength = 10
    CloseSpace = True
    boTransparent = True
  end
  object DButRenewChr: TDButton
    Left = 555
    Top = 450
    Width = 49
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DButRenewChrDirectPaint
    OnClick = DscSelect1Click
    Caption = #24674#22797#13#10
    DParent = DRenewChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DButRenewClose: TDButton
    Left = 451
    Top = 449
    Width = 50
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #36820#22238
    DParent = DRenewChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBottom: TDWindow
    Left = 8
    Top = 383
    Width = 344
    Height = 229
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBottomDirectPaint
    OnEndDirectPaint = DBottomEndDirectPaint
    OnMouseMove = DBottomMouseMove
    OnMouseDown = DBottom2MouseDown
    Caption = #24213#37096#26174#31034#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DMyState: TDButton
    Left = 10
    Top = 383
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = #29366#24577
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMyBag: TDButton
    Left = 45
    Top = 383
    Width = 25
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = #32972#21253
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMyMagic: TDButton
    Left = 76
    Top = 383
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = #25216#33021
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DOption: TDButton
    Left = 271
    Top = 383
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = #35774#32622
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotTrade: TDButton
    Left = 112
    Top = 384
    Width = 25
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = #20132#26131
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotGuild: TDButton
    Left = 143
    Top = 383
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DBotGuildClick
    Caption = #34892#20250
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotGroup: TDButton
    Left = 178
    Top = 383
    Width = 24
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = #32452#38431
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotFriend: TDButton
    Left = 208
    Top = 383
    Width = 25
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = #22909#21451
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotSort: TDButton
    Left = 239
    Top = 383
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DBotSortClick
    Caption = #25490#34892#27036
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTop: TDWindow
    Left = 765
    Top = 499
    Width = 88
    Height = 105
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopDirectPaint
    OnMouseMove = DTopMouseMove
    Caption = #39030#37096#29366#24577#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DTopHelp: TDButton
    Left = 765
    Top = 530
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopHelpDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DTopHelpClick
    Caption = #24110#21161
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopGM: TDButton
    Left = 765
    Top = 499
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DTopGMClick
    Caption = 'GM'
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DOpenMinmap: TDButton
    Left = 797
    Top = 499
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DOpenMinmapDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DOpenMinmapClick
    Caption = #23567#22320#22270
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMiniMapDlg: TDWindow
    Left = 766
    Top = 561
    Width = 87
    Height = 37
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMiniMapDlgDirectPaint
    OnInRealArea = DMiniMapDlgInRealArea
    Caption = #23567#22320#22270#31383#21475
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DMinMap128: TDWindow
    Left = 800
    Top = 550
    Width = 41
    Height = 41
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMinMap128DirectPaint
    OnMouseMove = DMinMap128MouseMove
    OnMouseDown = DMinMap128MouseDown
    OnMouseEntry = DMinMap128MouseEntry
    Caption = '128*128'
    DParent = DMiniMapDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DTopShop: TDButton
    Left = 765
    Top = 561
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopShopDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DTopShopClick
    Caption = #21830#38138
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMiniMapMax: TDButton
    Left = 832
    Top = 530
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DMiniMapMaxClick
    Caption = #20840#26223#22320#22270
    DParent = DMinMap128
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMaxMiniMap: TDWindow
    Left = 525
    Top = 8
    Width = 79
    Height = 57
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMaxMiniMapDirectPaint
    Caption = #20840#26223#22320#22270
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = True
    ControlStyle = dsTop
  end
  object DMaxMinimapClose: TDButton
    Left = 544
    Top = 8
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = #20851#38381
    DParent = DMaxMiniMap
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMaxMap792: TDWindow
    Left = 525
    Top = 17
    Width = 61
    Height = 41
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMaxMap792DirectPaint
    OnMouseMove = DMaxMap792MouseMove
    OnMouseDown = DMaxMap792MouseDown
    Caption = '792*536'
    DParent = DMaxMiniMap
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DBottom2: TDWindow
    Left = 8
    Top = 464
    Width = 344
    Height = 54
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBottom2DirectPaint
    OnEndDirectPaint = DBottom2EndDirectPaint
    OnMouseDown = DBottom2MouseDown
    Caption = #25353#25197'2'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DItemBag: TDWindow
    Left = 525
    Top = 134
    Width = 161
    Height = 109
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemBagDirectPaint
    OnMouseMove = DItemBagMouseMove
    OnMouseDown = DItemBagMouseDown
    OnVisible = DItemBagVisible
    Caption = #20154#29289#32972#21253
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = True
    ControlStyle = dsNone
  end
  object DItemGrid: TDGrid
    Left = 525
    Top = 134
    Width = 161
    Height = 45
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DItemGridDblClick
    Caption = #32972#21253#34920#26684
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 5
    RowCount = 9
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DItemGridGridSelect
    OnGridMouseMove = DItemGridGridMouseMove
    OnGridPaint = DItemGridGridPaint
  end
  object DGold: TDButton
    Left = 525
    Top = 216
    Width = 72
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DGoldClick
    Caption = #37329#24065#25353#25197
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DCloseBag: TDButton
    Left = 657
    Top = 216
    Width = 29
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = #20851#38381
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DEditDlgEdit: TDEdit
    Left = 365
    Top = 24
    Width = 80
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnKeyDown = DMsgDlgKeyDown
    OnMouseUp = DEditIDMouseUp
    DParent = DMsgDlg
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deChinese
    FrameColor = clBlack
    MaxLength = 70
    CloseSpace = True
    boTransparent = True
  end
  object DWndSay: TDWindow
    Left = 610
    Top = 8
    Width = 243
    Height = 120
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWndSayDirectPaint
    OnEndDirectPaint = DWndSayEndDirectPaint
    OnMouseDown = DWndSayMouseDown
    OnMouseUp = DWndSayMouseUp
    OnInRealArea = DWndSayInRealArea
    WheelDControl = DSayUpDown
    Caption = #32842#22825#26694#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DBTEdit: TDButton
    Left = 724
    Top = 94
    Width = 37
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTEditDirectPaint
    OnClick = DBTEditClick
    WheelDControl = DSayUpDown
    Caption = #32534#36753#26694
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DBTSayLock: TDButton
    Left = 692
    Top = 94
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTSayLockDirectPaint
    OnClick = DBTSayLockClick
    WheelDControl = DSayUpDown
    Caption = #38145
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTSayMove: TDButton
    Left = 692
    Top = 16
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    Caption = #31227#21160
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSayUpDown: TDUpDown
    Left = 692
    Top = 47
    Width = 26
    Height = 41
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    WheelDControl = DSayUpDown
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Position = 0
    Offset = 0
    Normal = False
    MovePosition = 1
    MoveShow = True
    MaxPosition = 0
    MoveFlicker = False
  end
  object DEditChat: TDImageEdit
    Left = 724
    Top = 16
    Width = 37
    Height = 25
    DFColor = clWhite
    DFEnabledColor = clYellow
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnKeyPress = DEditChatKeyPress
    OnKeyDown = DEditChatKeyDown
    OnMouseUp = DEditIDMouseUp
    OnClick = DEditChatClick
    OnVisible = DEditChatVisible
    WheelDControl = DSayUpDown
    DParent = DWndSay
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    OnChange = DEditChatChange
    OnCheckItem = DEditChatCheckItem
    OnDrawEditImage = DEditChatDrawEditImage
    MaxLength = 70
    BeginChar = '{'
    EndChar = '}'
    ImageChar = '#'
    ItemCount = 3
    ImageCount = 5
    boTransparent = True
  end
  object DBTFace: TDButton
    Left = 767
    Top = 94
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTFaceClick
    Caption = #34920#24773
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTOption: TDButton
    Left = 799
    Top = 94
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTOptionClick
    Caption = #35774#32622
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DWndFace: TDWindow
    Left = 784
    Top = 16
    Width = 61
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWndFaceDirectPaint
    OnMouseMove = DWndFaceMouseMove
    OnClick = DWndFaceClick
    Caption = #34920#24773#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsTop
  end
  object DWudItemShow: TDWindow
    Left = 784
    Top = 47
    Width = 61
    Height = 41
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWudItemShowDirectPaint
    OnMouseMove = DWudItemShowMouseMove
    OnVisible = DWudItemShowVisible
    Caption = #26174#31034#35013#22791#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = False
    ControlStyle = dsNone
  end
  object DBTItemShowClose: TDButton
    Left = 816
    Top = 47
    Width = 17
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTItemShowCloseDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = #20851#38381
    DParent = DWudItemShow
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DUserState: TDWindow
    Left = 358
    Top = 477
    Width = 401
    Height = 135
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateDirectPaint
    OnVisible = DUserStateVisible
    Caption = #26597#30475#20154#29289#35013#22791#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = True
    ControlStyle = dsNone
  end
  object DCloseUserState: TDButton
    Left = 732
    Top = 477
    Width = 27
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = #20851#38381
    DParent = DUserState
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMerchantDlg: TDWindow
    Left = 858
    Top = 133
    Width = 139
    Height = 110
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMerchantDlgDirectPaint
    OnMouseMove = DMerchantDlgMouseMove
    OnMouseDown = DMerchantDlgMouseDown
    OnClick = DMerchantDlgClick
    WheelDControl = DMDlgUpDonw
    Caption = 'NPC'#38754#26495#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = True
    ControlStyle = dsNone
  end
  object DMDlgUpDonw: TDUpDown
    Left = 858
    Top = 133
    Width = 109
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnEndDirectPaint = DMDlgUpDonwEndDirectPaint
    WheelDControl = DMDlgUpDonw
    DParent = DMerchantDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Position = 0
    Offset = 0
    Normal = False
    MovePosition = 10
    MoveShow = True
    MaxPosition = 0
    MoveFlicker = True
    OnPositionChange = DMDlgUpDonwPositionChange
  end
  object DMerchantDlgClose: TDButton
    Left = 973
    Top = 180
    Width = 24
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMerchantDlgCloseClick
    Caption = #20851#38381
    DParent = DMerchantDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuDlg: TDWindow
    Left = 858
    Top = 8
    Width = 139
    Height = 120
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMenuDlgDirectPaint
    OnVisible = DMenuDlgVisible
    WheelDControl = DMenuUpDonw
    Caption = #21830#24215#29289#21697#21015#34920
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = True
    ControlStyle = dsNone
  end
  object DMenuUpDonw: TDUpDown
    Left = 945
    Top = 31
    Width = 22
    Height = 42
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    WheelDControl = DMenuUpDonw
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Position = 0
    Offset = 0
    Normal = False
    MovePosition = 1
    MoveShow = True
    MaxPosition = 0
    MoveFlicker = True
  end
  object DWndBuy: TDWindow
    Left = 692
    Top = 134
    Width = 161
    Height = 109
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWndBuyDirectPaint
    OnVisible = DWndBuyVisible
    Caption = #36141#20080#29289#21697#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = True
    ControlStyle = dsTop
  end
  object DBuyOK: TDButton
    Left = 720
    Top = 212
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DBuyOKClick
    Caption = #30830#23450
    DParent = DWndBuy
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBuyClose: TDButton
    Left = 784
    Top = 213
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMaxMinimapCloseClick
    Caption = #21462#28040
    DParent = DWndBuy
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBuyAdd: TDButton
    Left = 720
    Top = 161
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBuyAddDirectPaint
    OnClick = DBuyAddClick
    Caption = '+'
    DParent = DWndBuy
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBuyDel: TDButton
    Left = 784
    Top = 162
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBuyAddDirectPaint
    OnClick = DBuyAddClick
    Caption = '-'
    DParent = DWndBuy
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBuyEdit: TDEdit
    Left = 724
    Top = 138
    Width = 80
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnKeyPress = DBuyEditKeyPress
    OnMouseUp = DEditIDMouseUp
    DParent = DWndBuy
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deInteger
    OnChange = DBuyEditChange
    FrameColor = clBlack
    MaxLength = 5
    CloseSpace = True
    boTransparent = True
  end
  object DDealDlg: TDWindow
    Left = 876
    Top = 249
    Width = 121
    Height = 128
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DDealDlgDirectPaint
    Caption = #20132#26131#30028#38754
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = False
    ControlStyle = dsNone
  end
  object DDRGrid: TDGrid
    Left = 885
    Top = 253
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #20132#26131#34920#26684
    DParent = DDealDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 6
    RowCount = 2
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridMouseMove = DDRGridGridMouseMove
    OnGridPaint = DDRGridGridPaint
  end
  object DDGrid: TDGrid
    Left = 888
    Top = 307
    Width = 47
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #20132#26131#34920#26684
    DParent = DDealDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 6
    RowCount = 2
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DDGridGridSelect
    OnGridMouseMove = DDGridGridMouseMove
    OnGridPaint = DDGridGridPaint
  end
  object DDGold: TDButton
    Left = 888
    Top = 362
    Width = 49
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DDGoldClick
    Caption = #37329#24065#25353#25197
    DParent = DDealDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DDealOk: TDButton
    Left = 890
    Top = 335
    Width = 33
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DDealOkClick
    Caption = #20132#26131
    DParent = DDealDlg
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DDealClose: TDButton
    Left = 980
    Top = 249
    Width = 17
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DDealCloseClick
    Caption = #20851#38381
    DParent = DDealDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DDealLock: TDButton
    Left = 964
    Top = 335
    Width = 33
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DDealLockClick
    Caption = #38145#23450
    DParent = DDealDlg
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DDRDealLock: TDCheckBox
    Left = 885
    Top = 284
    Width = 30
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    Caption = #38145#23450
    DParent = DDealDlg
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DDRDealOk: TDCheckBox
    Left = 967
    Top = 280
    Width = 30
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    Caption = #20132#26131
    DParent = DDealDlg
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DGroupDlg: TDWindow
    Left = 876
    Top = 390
    Width = 122
    Height = 128
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DGroupDlgDirectPaint
    OnMouseMove = DGroupDlgMouseMove
    OnVisible = DGroupDlgVisible
    WheelDControl = DGroupUpDown
    Caption = #38431' '#20237' '#20449' '#24687
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = True
    ControlStyle = dsNone
  end
  object DGrpCreate: TDButton
    Left = 930
    Top = 497
    Width = 33
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DGrpCreateClick
    Caption = #36992#35831
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DGrpAddMem: TDButton
    Left = 934
    Top = 471
    Width = 29
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DGrpAddMemClick
    Caption = #28155#21152
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DGrpDelMem: TDButton
    Left = 932
    Top = 444
    Width = 31
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DGrpDelMemClick
    Caption = #21024#38500
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DGroupExit: TDButton
    Left = 966
    Top = 444
    Width = 31
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DGroupExitClick
    Caption = #31163#32452
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCBGroupItemDef: TDCheckBox
    Left = 932
    Top = 390
    Width = 65
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DCBGroupItemDefClick
    Caption = #40664#35748#33258#30001#20998#37197
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 4
    OffsetTop = 1
  end
  object DCBGroupItemRam: TDCheckBox
    Left = 932
    Top = 417
    Width = 65
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DCBGroupItemDefClick
    Caption = #20849#20139#38543#26426#20998#37197
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 4
    OffsetTop = 1
  end
  object DGrpAllowGroup: TDCheckBox
    Left = 885
    Top = 390
    Width = 65
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DGrpAllowGroupClick
    Caption = #20801#35768#32452#38431
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 4
    OffsetTop = 1
  end
  object DGrpCheckGroup: TDCheckBox
    Left = 885
    Top = 417
    Width = 65
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DGrpCheckGroupClick
    Caption = #32452#38431#38656#35201#35748#35777
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 4
    OffsetTop = 1
  end
  object DGrpDlgClose: TDButton
    Left = 896
    Top = 444
    Width = 30
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = #20851#38381
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DGroupUpDown: TDUpDown
    Left = 969
    Top = 460
    Width = 24
    Height = 54
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    WheelDControl = DGroupUpDown
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Position = 0
    Offset = 0
    Normal = False
    MovePosition = 1
    MoveShow = True
    MaxPosition = 0
    MoveFlicker = False
  end
  object DGrpMemberList: TDWindow
    Left = 897
    Top = 471
    Width = 33
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DGrpMemberListDirectPaint
    OnMouseMove = DGrpMemberListMouseMove
    OnMouseDown = DGrpMemberListMouseDown
    OnMouseUp = DGrpMemberListMouseUp
    OnDblClick = DGrpMemberListDblClick
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DGrpUserList: TDWindow
    Left = 897
    Top = 498
    Width = 33
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DGrpMemberListDirectPaint
    OnMouseMove = DGrpUserListMouseMove
    OnMouseDown = DGrpUserListMouseDown
    OnMouseUp = DGrpUserListMouseUp
    OnDblClick = DGrpUserListDblClick
    WheelDControl = DGroupUpDown
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DTopEMail: TDButton
    Left = 832
    Top = 501
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopEMailDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DTopEMailClick
    Caption = #20449#20214
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck1: TDButton
    Left = 8
    Top = 462
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = #26816#27979'1'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck2: TDButton
    Tag = 1
    Left = 43
    Top = 464
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = #26816#27979'2'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck3: TDButton
    Tag = 2
    Left = 78
    Top = 462
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = #26816#27979'3'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck4: TDButton
    Tag = 3
    Left = 113
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = #26816#27979'4'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck5: TDButton
    Tag = 4
    Left = 148
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = #26816#27979'5'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck6: TDButton
    Tag = 5
    Left = 183
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = #26816#27979'6'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck7: TDButton
    Tag = 6
    Left = 218
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = #26816#27979'7'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck8: TDButton
    Tag = 7
    Left = 253
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = #26816#27979'8'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck9: TDButton
    Tag = 8
    Left = 288
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = #26816#27979'9'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck10: TDButton
    Tag = 9
    Left = 323
    Top = 464
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = #26816#27979'10'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DPopUpEdits: TDPopUpMemu
    Left = 183
    Top = 111
    Width = 169
    Height = 17
    DFColor = 9236471
    DFEnabledColor = 6320757
    DFMoveColor = 12964541
    DFDownColor = clYellow
    DFBackColor = 8
    Caption = #36755#20837#26694#24377#20986#26694
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Item.Strings = (
      #36716#31227#38431#38271
      #36386#20986#38431#20237
      #26597#30475#20449#24687
      #21152#20026#22909#21451)
    HeightOffset = 20
    OnPopIndex = DPopUpEditsPopIndex
    Alpha = 220
  end
  object DPopUpSayList: TDPopUpMemu
    Left = 691
    Top = 115
    Width = 161
    Height = 17
    DFColor = 9236471
    DFEnabledColor = 6320757
    DFMoveColor = 12964541
    DFDownColor = clYellow
    DFBackColor = 8
    Caption = #32842#22825#26694#24377#20986#26694
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Item.Strings = (
      #36716#31227#38431#38271
      #36386#20986#38431#20237
      #26597#30475#20449#24687
      #21152#20026#22909#21451)
    HeightOffset = 20
    OnPopIndex = DPopUpSayListPopIndex
    Alpha = 220
  end
  object DPopUpPlay: TDPopUpMemu
    Left = 183
    Top = 87
    Width = 169
    Height = 17
    DFColor = 9236471
    DFEnabledColor = 6320757
    DFMoveColor = 12964541
    DFDownColor = clYellow
    DFBackColor = 8
    Caption = #26597#30475#20154#29289#24377#20986#26694
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Item.Strings = (
      #36716#31227#38431#38271
      #36386#20986#38431#20237
      #26597#30475#20449#24687
      #21152#20026#22909#21451)
    HeightOffset = 20
    OnPopIndex = DPopUpPlayPopIndex
    Alpha = 220
  end
  object DStateWin: TDWindow
    Left = 358
    Top = 249
    Width = 495
    Height = 189
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinDirectPaint
    OnVisible = DStateWinVisible
    Caption = #20154#29289#23646#24615
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = True
    ControlStyle = dsNone
  end
  object DStateWinItem: TDWindow
    Left = 359
    Top = 247
    Width = 105
    Height = 128
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    OnMouseMove = DStateWinItemMouseMove
    OnMouseUp = DStateWinItemMouseUp
    Caption = #20154#29289#35013#22791#31383#21475
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DSWWeapon: TDButton
    Tag = 1
    Left = 362
    Top = 255
    Width = 28
    Height = 16
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #27494#22120
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DCloseState: TDButton
    Left = 823
    Top = 249
    Width = 29
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = #20851#38381
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSWDress: TDButton
    Left = 362
    Top = 277
    Width = 28
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #34915#26381
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWArmRingR: TDButton
    Tag = 6
    Left = 362
    Top = 300
    Width = 29
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #25163#38255#21491
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWRingR: TDButton
    Tag = 8
    Left = 362
    Top = 326
    Width = 29
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #25106#25351#21491
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWBelt: TDButton
    Tag = 10
    Left = 362
    Top = 347
    Width = 29
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #33136#24102
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWBujuk: TDButton
    Tag = 9
    Left = 397
    Top = 347
    Width = 29
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #25252#36523#31526
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWHouse: TDButton
    Tag = 13
    Left = 432
    Top = 346
    Width = 29
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #22352#39569
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWCharm: TDButton
    Tag = 12
    Left = 397
    Top = 303
    Width = 29
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #23453#30707
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWCowry: TDButton
    Tag = 14
    Left = 397
    Top = 326
    Width = 29
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #36947#20855
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWArmRingL: TDButton
    Tag = 5
    Left = 432
    Top = 320
    Width = 29
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #25163#38255#24038
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWLight: TDButton
    Tag = 4
    Left = 432
    Top = 294
    Width = 31
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #21195#31456
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWNecklace: TDButton
    Tag = 3
    Left = 430
    Top = 271
    Width = 31
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #39033#38142
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWHelmet: TDButton
    Tag = 2
    Left = 430
    Top = 250
    Width = 29
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #22836#30420
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWBoots: TDButton
    Tag = 11
    Left = 396
    Top = 254
    Width = 30
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #38772#23376
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWRingL: TDButton
    Tag = 7
    Left = 397
    Top = 277
    Width = 29
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #25106#25351#24038
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DStateWinAbil: TDWindow
    Left = 470
    Top = 247
    Width = 182
    Height = 44
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    Caption = #20154#29289#23646#24615#31383#21475
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DStateBTItem: TDButton
    Left = 757
    Top = 249
    Width = 31
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = #35013#22791
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateBTAbil: TDButton
    Tag = 1
    Left = 788
    Top = 249
    Width = 29
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = #23646#24615
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateBTMagic: TDButton
    Tag = 2
    Left = 727
    Top = 247
    Width = 29
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = #25216#33021
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateBTInfo: TDButton
    Tag = 3
    Left = 658
    Top = 247
    Width = 40
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = #20449#24687
    DParent = DStateWin
    Visible = False
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateAbilOk: TDButton
    Left = 470
    Top = 247
    Width = 20
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateAbilExitClick
    Caption = #30830#23450
    DParent = DStateWinAbil
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilExit: TDButton
    Left = 489
    Top = 247
    Width = 22
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateAbilExitClick
    Caption = #21462#28040
    DParent = DStateWinAbil
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagic: TDWindow
    Left = 358
    Top = 361
    Width = 294
    Height = 78
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    OnVisible = DStateWinMagicVisible
    Caption = #20154#29289#25216#33021#31383#21475
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DStateWinInfo: TDWindow
    Left = 470
    Top = 293
    Width = 181
    Height = 64
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    Caption = #20154#29289#20449#24687#31383#21475
    DParent = DStateWin
    Visible = False
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DStateGrid: TDGrid
    Left = 358
    Top = 388
    Width = 49
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #25216#33021#34920#26684
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 2
    RowCount = 5
    ColWidth = 38
    RowHeight = 38
    Coloffset = 79
    Rowoffset = 13
    ViewTopLine = 0
    OnGridSelect = DStateGridGridSelect
    OnGridMouseMove = DStateGridGridMouseMove
    OnGridPaint = DStateGridGridPaint
  end
  object DStateAbilAdd3: TDButton
    Tag = 2
    Left = 470
    Top = 270
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+3'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel3: TDButton
    Tag = 12
    Left = 489
    Top = 270
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-3'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilAdd1: TDButton
    Left = 518
    Top = 247
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+1'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel1: TDButton
    Tag = 10
    Left = 537
    Top = 247
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-1'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilAdd2: TDButton
    Tag = 1
    Left = 562
    Top = 247
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+2'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel2: TDButton
    Tag = 11
    Left = 581
    Top = 247
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-2'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilAdd4: TDButton
    Tag = 3
    Left = 508
    Top = 270
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+4'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel4: TDButton
    Tag = 13
    Left = 527
    Top = 270
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-4'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilAdd5: TDButton
    Tag = 4
    Left = 541
    Top = 270
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+5'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel5: TDButton
    Tag = 14
    Left = 560
    Top = 270
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-5'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilAdd6: TDButton
    Tag = 5
    Left = 573
    Top = 274
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+6'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel6: TDButton
    Tag = 15
    Left = 592
    Top = 274
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-6'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateInfoName: TDEdit
    Left = 501
    Top = 292
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deStandard
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    MaxLength = 8
    boTransparent = True
  end
  object DStateInfoAge: TDEdit
    Left = 501
    Top = 310
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deInteger
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    MaxLength = 2
    boTransparent = True
  end
  object DStateInfoAM: TDCheckBox
    Left = 470
    Top = 297
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #19978#21320
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OnChange = DStateInfoNameChange
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DStateInfoPM: TDCheckBox
    Left = 470
    Top = 310
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #19979#21320
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OnChange = DStateInfoNameChange
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DStateInfoNight: TDCheckBox
    Left = 470
    Top = 320
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #26202#19978
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OnChange = DStateInfoNameChange
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DStateInfoMidNight: TDCheckBox
    Left = 470
    Top = 328
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #21320#22812
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OnChange = DStateInfoNameChange
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DStateInfoFriend: TDCheckBox
    Left = 587
    Top = 309
    Width = 40
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #20165#22909#21451#21487#35265
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OnChange = DStateInfoNameChange
    OffsetLeft = 1
    OffsetTop = 1
  end
  object DStateInfoExit: TDButton
    Left = 610
    Top = 325
    Width = 22
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateInfoExitClick
    Caption = #21462#28040
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateInfoSave: TDButton
    Left = 587
    Top = 333
    Width = 20
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateInfoSaveClick
    Caption = #20445#23384
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateInfoRefPic: TDButton
    Left = 548
    Top = 326
    Width = 20
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateInfoRefPicDirectPaint
    OnClick = DStateInfoRefPicClick
    Caption = #21047#26032#29031#29255
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateInfoUpLoadPic: TDButton
    Left = 574
    Top = 325
    Width = 22
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateInfoRefPicClick
    Caption = #19978#20256#29031#29255
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateInfoMemo: TDMemo
    Left = 548
    Top = 307
    Width = 33
    Height = 17
    DFColor = 11913116
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    Caption = 'Memo'
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    OnChange = DStateInfoNameChange
    FrameColor = 8
    boTransparent = True
    MaxLength = 120
  end
  object DStateInfoArea: TDComboBox
    Left = 517
    Top = 328
    Width = 25
    Height = 18
    DFColor = 14605278
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    boTransparent = True
    ShowCount = 8
    ShowHeight = 18
    ItemIndex = -1
  end
  object DStateInfoCity: TDComboBox
    Left = 516
    Top = 311
    Width = 25
    Height = 16
    DFColor = 14605278
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    boTransparent = True
    ShowCount = 8
    ShowHeight = 18
    Item.Strings = (
      
        '"0_0_0",["'#19996#22478#21306'","'#35199#22478#21306'","'#23815#25991#21306'","'#23459#27494#21306'","'#26397#38451#21306'","'#20016#21488#21306'","'#30707#26223#23665#21306'","'#28023#28096#21306'","'#38376#22836#27807#21306'"' +
        ',"'#25151#23665#21306'","'#36890#24030#21306'","'#39034#20041#21306'","'#26124#24179#21306'","'#22823#20852#21306'","'#24576#26580#21306'","'#24179#35895#21306'","'#23494#20113#21439'","'#24310#24198#21439'","'#24310#24198#38215'"]'
      '"0_0",["'#21271#20140#24066'"]'
      
        '"0_1_0",["'#21644#24179#21306'","'#27827#19996#21306'","'#27827#35199#21306'","'#21335#24320#21306'","'#27827#21271#21306'","'#32418#26725#21306'","'#22616#27837#21306'","'#27721#27837#21306'","'#22823#28207#21306'","' +
        #19996#20029#21306'","'#35199#38738#21306'","'#27941#21335#21306'","'#21271#36784#21306'","'#27494#28165#21306'","'#23453#22395#21306'","'#34015#21439'","'#23425#27827#21439'","'#33446#21488#38215'","'#38745#28023#21439'","'#38745#28023#38215'"]'
      '"0_1",["'#22825#27941#24066'"]'
      
        '"0_2_0",["'#40644#28006#21306'","'#21346#28286#21306'","'#24464#27719#21306'","'#38271#23425#21306'","'#38745#23433#21306'","'#26222#38464#21306'","'#38392#21271#21306'","'#34425#21475#21306'","'#26472#28006#21306'","' +
        #38389#34892#21306'","'#23453#23665#21306#57355'","'#22025#23450#21306'","'#28006#19996#26032#21306'","'#37329#23665#21306'","'#26494#27743#21306'","'#38738#28006#21306'","'#21335#27719#21306'","'#22857#36132#21306'","'#23815#26126#21439'","'#22478#26725 +
        #38215'"]'
      '"0_2",["'#19978#28023#24066'"]'
      
        '"0_3_0",["'#28189#20013#21306'","'#22823#28193#21475#21306'","'#27743#21271#21306'","'#27801#22378#22365#21306'","'#20061#40857#22369#21306'","'#21335#23736#21306'","'#21271#30874#21306'","'#19975#30427#21306'","'#21452#26725#21306 +
        '","'#28189#21271#21306'","'#24052#21335#21306'","'#19975#24030#21306'","'#28074#38517#21306'","'#40660#27743#21306'","'#38271#23551#21306'","'#21512#24029#24066'","'#27704#24029#21306#24066'","'#27743#27941#24066'","'#21335#24029#24066'","' +
        #32166#27743#21439'","'#28540#21335#21439'","'#38108#26753#21439'","'#22823#36275#21439'","'#33635#26124#21439'","'#29863#23665#21439'","'#22443#27743#21439'","'#27494#38534#21439'","'#20016#37117#21439'","'#22478#21475#21439'","'#26753#24179#21439'"' +
        ',"'#24320#21439'","'#24043#28330#21439'","'#24043#23665#21439'","'#22857#33410#21439'","'#20113#38451#21439'","'#24544#21439'","'#30707#26609#22303#23478#26063#33258#27835#21439'","'#24429#27700#33495#26063#22303#23478#26063#33258#27835#21439'","'#37193#38451#22303#23478 +
        #26063#33495#26063#33258#27835#21439'","'#31168#23665#22303#23478#26063#33495#26063#33258#27835#21439'"]'
      '"0_3",["'#37325#24198#24066'"]'
      
        '"0_4_0",["'#38271#23433#21306'","'#26725#19996#21306'","'#26725#35199#21306'","'#26032#21326#21306'","'#35029#21326#21306'","'#20117#38473#30719#21306'","'#36763#38598#24066'","'#34241#22478#24066'","'#26187#24030#24066'",' +
        '"'#26032#20048#24066'","'#40575#27849#24066'","'#20117#38473#21439'","'#24494#27700#38215'","'#27491#23450#21439'","'#27491#23450#38215'","'#26686#22478#21439'","'#26686#22478#38215'","'#34892#21776#21439'","'#40857#24030#38215'","'#28789#23551#21439 +
        '","'#28789#23551#38215'","'#39640#37009#21439'","'#39640#37009#38215'","'#28145#27901#21439'","'#28145#27901#38215'","'#36190#30343#21439'","'#36190#30343#38215'","'#26080#26497#21439'","'#26080#26497#38215'","'#24179#23665#21439'","'#24179 +
        #23665#38215'","'#20803#27663#21439'","'#27088#38451#38215'","'#36213#21439'","'#36213#24030#38215'"]'
      
        '"0_4_1",["'#26725#35199#21306'","'#26725#19996#21306'","'#23459#21270#21306'","'#19979#33457#22253#21306'","'#23459#21270#21439'","'#24352#23478#21475#24066#23459#21270#21306'","'#24352#21271#21439'","'#24352#21271#38215'","'#24247 +
        #20445#21439'","'#24247#20445#38215'","'#27837#28304#21439'","'#24179#23450#22561#38215'","'#23578#20041#21439'","'#21335#22741#22545#38215'","'#34074#21439'","'#34074#24030#38215'","'#38451#21407#21439'","'#35199#22478#38215'","'#24576#23433#21439'"' +
        ',"'#26612#27807#22561#38215'","'#19975#20840#21439'","'#23380#23478#24196#38215'","'#24576#26469#21439'","'#27801#22478#38215'","'#28095#40575#21439'","'#28095#40575#38215'","'#36196#22478#21439'","'#36196#22478#38215'","'#23815#31036#21439'","' +
        #35199#28286#23376#38215'"]'
      
        '"0_4_2",["'#21452#26725#21306'","'#21452#28390#21306'","'#40560#25163#33829#23376#30719#21306'","'#25215#24503#21439'","'#19979#26495#22478#38215'","'#20852#38534#21439'","'#20852#38534#38215'","'#24179#27849#21439'","'#24179#27849 +
        #38215'","'#28390#24179#21439'","'#28390#24179#38215'","'#38534#21270#21439'","'#38534#21270#38215'","'#20016#23425#28385#26063#33258#27835#21439'","'#22823#38401#38215'","'#23485#22478#28385#26063#33258#27835#21439'","'#23485#22478#38215'","'#22260#22330#28385#26063 +
        #33945#21476#26063#33258#27835#21439'","'#22260#22330#38215'"]'
      
        '"0_4_3",["'#28023#28207#21306'","'#23665#28023#20851#21306'","'#21271#25140#27827#21306'","'#26124#40654#21439'","'#26124#40654#38215'","'#25242#23425#21439'","'#25242#23425#38215'","'#21346#40857#21439'","'#21346#40857#38215'"' +
        ',"'#38738#40857#28385#26063#33258#27835#21439'","'#38738#40857#38215'"]'
      
        '"0_4_4",["'#36335#21271#21306'","'#36335#21335#21306'","'#21476#20918#21306'","'#24320#24179#21306'","'#20016#28070#21306'","'#20016#21335#21306'","'#36981#21270#24066'","'#36801#23433#24066'","'#28390#21439'","'#28390 +
        #24030#38215'","'#28390#21335#21439'","'#20532#22478#38215'","'#20048#20141#21439'","'#20048#20141#38215'","'#36801#35199#21439'","'#20852#22478#38215'","'#29577#30000#21439'","'#29577#30000#38215'","'#21776#28023#21439'","'#21776#28023#38215'"]'
      
        '"0_4_5",["'#23433#27425#21306'","'#24191#38451#21306'","'#38712#24030#24066'","'#19977#27827#24066'","'#22266#23433#21439'","'#22266#23433#38215'","'#27704#28165#21439'","'#27704#28165#38215'","'#39321#27827#21439'","' +
        #28113#38451#38215'","'#22823#22478#21439'","'#24179#33298#38215'","'#25991#23433#21439'","'#25991#23433#38215'","'#22823#21378#22238#26063#33258#27835#21439'","'#22823#21378#38215'"]'
      
        '"0_4_6",["'#26032#24066#21306'","'#21271#24066#21306'","'#21335#24066#21306'","'#23450#24030#24066'","'#28095#24030#24066'","'#23433#22269#24066'","'#39640#30865#24215#24066'","'#28385#22478#21439'","'#28385#22478#38215'",' +
        '"'#28165#33489#21439'","'#28165#33489#38215'","'#26131#21439'","'#26131#24030#38215'","'#24464#27700#21439'","'#23433#32899#38215'","'#28062#28304#21439'","'#28062#28304#38215'","'#23450#20852#21439'","'#23450#20852#38215'","'#39034#24179#21439'"' +
        ',"'#33970#38451#38215'","'#21776#21439'","'#20161#21402#38215'","'#26395#37117#21439'","'#26395#37117#38215'","'#28062#27700#21439'","'#28062#27700#38215'","'#39640#38451#21439'","'#39640#38451#38215'","'#23433#26032#21439'","'#23433#26032#38215 +
        '","'#38596#21439'","'#38596#24030#38215'","'#23481#22478#21439'","'#23481#22478#38215'","'#26354#38451#21439'","'#24658#24030#38215'","'#38428#24179#21439'","'#38428#24179#38215'","'#21338#37326#21439'","'#21338#38517#38215'","'#34849#21439 +
        '","'#34849#21566#38215'"]'
      
        '"0_4_7",["'#26691#22478#21306'","'#20864#24030#24066'","'#28145#24030#24066'","'#26531#24378#21439'","'#26531#24378#38215'","'#27494#37009#21439'","'#27494#37009#38215'","'#27494#24378#21439'","'#27494#24378#38215'","' +
        #39286#38451#21439'","'#39286#38451#38215'","'#23433#24179#21439'","'#23433#24179#38215'","'#25925#22478#21439'","'#37073#21475#38215'","'#26223#21439'","'#26223#24030#38215'","'#38428#22478#21439'","'#38428#22478#38215'"]'
      
        '"0_4_8",["'#36816#27827#21306'","'#26032#21326#21306'","'#27850#22836#24066'","'#20219#19992#24066'","'#40644#39557#24066'","'#27827#38388#24066'","'#27815#21439'","'#27815#24030#24066#26032#21326#21306'","'#38738#21439'",' +
        '"'#28165#24030#38215'","'#19996#20809#21439'","'#19996#20809#38215'","'#28023#20852#21439'","'#33487#22522#38215'","'#30416#23665#21439'","'#30416#23665#38215'","'#32899#23425#21439'","'#32899#23425#38215'","'#21335#30382#21439'","'#21335#30382#38215 +
        '","'#21556#26725#21439'","'#26705#22253#38215'","'#29486#21439'","'#20048#23551#38215'","'#23391#26449#22238#26063#33258#27835#21439'","'#23391#26449#38215'"]'
      
        '"0_4_9",["'#26725#19996#21306'","'#26725#35199#21306'","'#21335#23467#24066'","'#27801#27827#24066'","'#37026#21488#21439'","'#37026#21488#24066#26725#19996#21306'","'#20020#22478#21439'","'#20020#22478#38215'","'#20869#19992#21439 +
        '","'#20869#19992#38215'","'#26575#20065#21439'","'#26575#20065#38215'","'#38534#23591#21439'","'#38534#23591#38215'","'#20219#21439'","'#20219#22478#38215'","'#21335#21644#21439'","'#21644#38451#38215'","'#23425#26187#21439'","'#20964#20976 +
        #38215'","'#24040#40575#21439'","'#24040#40575#38215'","'#26032#27827#21439'","'#26032#27827#38215'","'#24191#23447#21439'","'#24191#23447#38215'","'#24179#20065#21439'","'#20016#24030#38215'","'#23041#21439'","'#27962#24030#38215'","'#28165 +
        #27827#21439'","'#33883#20185#24196#38215'","'#20020#35199#21439'","'#20020#35199#38215'"]'
      
        '"0_4_10",["'#19995#21488#21306'","'#37039#23665#21306'","'#22797#20852#21306'","'#23792#23792#30719#21306'","'#27494#23433#24066'","'#37039#37112#21439'","'#21335#22561#20065#19996#23567#23663#26449'","'#20020#28467#21439'","' +
        #20020#28467#38215'","'#25104#23433#21439'","'#25104#23433#38215'","'#22823#21517#21439'","'#22823#21517#38215'","'#28041#21439'","'#28041#22478#38215'","'#30913#21439'","'#30913#24030#38215'","'#32933#20065#21439'","'#32933#20065#38215'","' +
        #27704#24180#21439'","'#20020#27962#20851#38215'","'#37041#21439'","'#26032#39532#22836#38215'","'#40481#27901#21439'","'#40481#27901#38215'","'#24191#24179#21439'","'#24191#24179#38215'","'#39302#38518#21439'","'#39302#38518#38215'","'#39759#21439'"' +
        ',"'#39759#22478#38215'","'#26354#21608#21439'","'#26354#21608#38215'"]'
      
        '"0_4",["'#30707#23478#24196#24066'","'#24352#23478#21475#24066'","'#25215#24503#24066'","'#31206#30343#23707#24066'","'#21776#23665#24066'","'#24266#22346#24066'","'#20445#23450#24066'","'#34913#27700#24066'","'#27815#24030#24066'",' +
        '"'#37026#21488#24066'","'#37039#37112#24066'"]'
      
        '"0_5_0",["'#26447#33457#23725#21306'","'#23567#24215#21306'","'#36814#27901#21306'","'#23574#33609#22378#21306'","'#19975#26575#26519#21306'","'#26187#28304#21306'","'#21476#20132#24066'","'#28165#24464#21439'","'#28165#28304#38215 +
        '","'#38451#26354#21439'","'#40644#23528#38215'","'#23044#28902#21439'","'#23044#28902#38215'"]'
      
        '"0_5_1",["'#26388#22478#21306'","'#24179#40065#21306'","'#23665#38452#21439'","'#23729#23731#20065'","'#24212#21439'","'#37329#22478#38215'","'#21491#29577#21439'","'#26032#22478#38215'","'#24576#20161#21439'","'#20113 +
        #20013#38215'"]'
      
        '"0_5_2",["'#22478#21306'","'#30719#21306'","'#21335#37066#21306'","'#26032#33635#21306'","'#38451#39640#21439'","'#40857#27849#38215'","'#22825#38215#21439'","'#29577#27849#38215'","'#24191#28789#21439'","'#22774#27849 +
        #38215'","'#28789#19992#21439'","'#27494#28789#38215'","'#27985#28304#21439'","'#27704#23433#38215'","'#24038#20113#21439'","'#20113#20852#38215'","'#22823#21516#21439'","'#35199#22378#38215'"]'
      '"0_5_3",["'#22478#21306'","'#30719#21306'","'#37066#21306'","'#24179#23450#21439'","'#20896#23665#38215'","'#30402#21439'","'#31168#27700#38215'"]'
      
        '"0_5_4",["'#22478#21306'","'#37066#21306'","'#28510#22478#24066'","'#38271#27835#21439'","'#38889#24215#38215'","'#35140#22435#21439'","'#21476#38889#38215'","'#23663#30041#21439'","'#40607#32475#38215'","'#24179#39034 +
        #21439'","'#38738#32650#38215'","'#40654#22478#21439'","'#40654#20399#38215'","'#22774#20851#21439'","'#40857#27849#38215'","'#38271#23376#21439'","'#20025#26417#38215'","'#27494#20065#21439'","'#20016#24030#38215'","'#27777#21439'","'#23450 +
        #26124#38215'","'#27777#28304#21439'","'#27777#27827#38215'"]'
      
        '"0_5_5",["'#22478#21306'","'#39640#24179#24066'","'#27901#24030#21439'","'#21335#26449#38215'","'#27777#27700#21439'","'#40857#28207#38215'","'#38451#22478#21439'","'#20964#22478#38215'","'#38517#24029#21439'","'#23815 +
        #25991#38215'"]'
      
        '"0_5_6",["'#24571#24220#21306'","'#21407#24179#24066'","'#23450#35140#21439'","'#26187#26124#38215'","'#20116#21488#21439'","'#21488#22478#38215'","'#20195#21439'","'#19978#39302#38215'","'#32321#23769#21439'","'#32321 +
        #22478#38215'","'#23425#27494#21439'","'#20964#20976#38215'","'#38745#20048#21439'","'#40517#22478#38215'","'#31070#27744#21439'","'#40857#27849#38215'","'#20116#23528#21439'","'#30746#22478#38215'","'#23714#23706#21439'","'#23706#28458#38215'",' +
        '"'#27827#26354#21439'","'#25991#31508#38215'","'#20445#24503#21439'","'#19996#20851#38215'","'#20559#20851#21439'","'#26032#20851#38215'"]'
      
        '"0_5_7",["'#27014#27425#21306'","'#20171#20241#24066'","'#27014#31038#21439'","'#31637#22478#38215'","'#24038#26435#21439'","'#36797#38451#38215'","'#21644#39034#21439'","'#20041#20852#38215'","'#26132#38451#21439'","' +
        #20048#24179#38215'","'#23551#38451#21439'","'#26397#38451#38215'","'#22826#35895#21439'","'#26126#26143#38215'","'#31041#21439'","'#26157#20313#38215'","'#24179#36965#21439'","'#21476#38518#38215'","'#28789#30707#21439'","'#32736#23792#38215'"]'
      
        '"0_5_8",["'#23591#37117#21306'","'#20399#39532#24066'","'#38669#24030#24066'","'#26354#27779#21439'","'#20048#26124#38215'","'#32764#22478#21439'","'#21776#20852#38215'","'#35140#27774#21439'","'#26032#22478#38215'","' +
        #27946#27934#21439'","'#22823#27088#26641#38215'","'#21476#21439'","'#23731#38451#38215'","'#23433#27901#21439'","'#24220#22478#38215'","'#28014#23665#21439'","'#22825#22363#38215'","'#21513#21439'","'#21513#26124#38215'","'#20065#23425#21439'",' +
        '"'#26124#23425#38215'","'#33970#21439'","'#33970#22478#38215'","'#22823#23425#21439'","'#26133#27700#38215'","'#27704#21644#21439'","'#33437#27827#38215'","'#38576#21439'","'#40857#27849#38215'","'#27774#35199#21439'","'#27704#23433#38215'"]'
      
        '"0_5_9",["'#31163#30707#21306'","'#23389#20041#24066'","'#27774#38451#24066'","'#25991#27700#21439'","'#20964#22478#38215'","'#20013#38451#21439'","'#23425#20065#38215'","'#20852#21439'","'#34074#27774#38215'","'#20020 +
        #21439'","'#20020#27849#38215'","'#26041#23665#21439'","'#22314#27934#38215'","'#26611#26519#21439'","'#26611#26519#38215'","'#23706#21439'","'#19996#26449#38215'","'#20132#21475#21439'","'#27700#22836#38215'","'#20132#22478#21439'","'#22825 +
        #23425#38215'","'#30707#27004#21439'","'#28789#27849#38215'"]'
      
        '"0_5_10",["'#30416#28246#21306'","'#27704#27982#24066'","'#27827#27941#24066'","'#33454#22478#21439'","'#21476#39759#38215'","'#20020#29463#21439'","'#29463#27663#38215'","'#19975#33635#21439'","'#35299#24215#38215'",' +
        '"'#26032#32475#21439'","'#40857#20852#38215'","'#31287#23665#21439'","'#31287#23792#38215'","'#38395#21916#21439'","'#26704#22478#38215'","'#22799#21439'","'#29814#23792#38215'","'#32475#21439'","'#21476#32475#38215'","'#24179#38470#21439'",' +
        '"'#22307#20154#28071#38215'","'#22435#26354#21439'","'#26032#22478#38215'"]'
      
        '"0_5",["'#22826#21407#24066'","'#26388#24030#24066'","'#22823#21516#24066'","'#38451#27849#24066'","'#38271#27835#24066'","'#26187#22478#24066'","'#24571#24030#24066'","'#26187#20013#24066'","'#20020#27774#24066'","'#21525#26753 +
        #24066'","'#36816#22478#24066'"]'
      
        '"0_6_0",["'#22238#27665#21306'","'#26032#22478#21306'","'#29577#27849#21306'","'#36187#32597#21306'","'#25176#20811#25176#21439'","'#21452#27827#38215'","'#27494#24029#21439'","'#21487#21487#20197#21147#26356#38215'","'#21644#26519 +
        #26684#23572#21439'","'#22478#20851#38215'","'#28165#27700#27827#21439'","'#22478#20851#38215'","'#22303#40664#29305#24038#26071'","'#23519#32032#40784#38215'"]'
      
        '"0_6_1",["'#26118#37117#20177#21306'","'#19996#27827#21306'","'#38738#23665#21306'","'#30707#25296#21306'","'#30333#20113#30719#21306'","'#20061#21407#21306'","'#22266#38451#21439'","'#37329#23665#38215'","'#22303#40664#29305#21491 +
        #26071'","'#33832#25289#40784#38215'","'#36798#23572#32597#33538#26126#23433#32852#21512#26071'","'#30334#28789#24217#38215'"]'
      '"0_6_2",["'#28023#21187#28286#21306'","'#28023#21335#21306'","'#20044#36798#21306'"]'
      
        '"0_6_3",["'#32418#23665#21306'","'#20803#23453#23665#21306'","'#26494#23665#21306'","'#23425#22478#21439'","'#22825#20041#38215'","'#26519#35199#21439'","'#26519#35199#38215'","'#38463#40065#31185#23572#27777#26071'","'#22825#23665 +
        #38215'","'#24052#26519#24038#26071'","'#26519#19996#38215'","'#24052#26519#21491#26071'","'#22823#26495#38215'","'#20811#20160#20811#33150#26071'","'#32463#26842#38215'","'#32705#29275#29305#26071'","'#20044#20025#38215'","'#21888#21895#27777#26071'","' +
        #38182#23665#38215'","'#25942#27721#26071'","'#26032#24800#38215'"]'
      
        '"0_6_4",["'#31185#23572#27777#21306'","'#38669#26519#37101#21202#24066'","'#24320#40065#21439'","'#24320#40065#38215'","'#24211#20262#26071'","'#24211#20262#38215'","'#22856#26364#26071'","'#22823#27777#20182#25289#38215'","'#25166 +
        #40065#29305#26071'","'#40065#21271#38215'","'#31185#23572#27777#24038#32764#20013#26071'","'#20445#24247#38215'","'#31185#23572#27777#24038#32764#21518#26071'","'#29976#26071#21345#38215'"]'
      
        '"0_6_5",["'#28023#25289#23572#21306'","'#28385#27954#37324#24066'","'#25166#20848#23663#24066'","'#29273#20811#30707#24066'","'#26681#27827#24066'","'#39069#23572#21476#32435#24066'","'#38463#33635#26071'","'#37027#21513#38215'","' +
        #26032#24052#23572#34382#21491#26071'","'#38463#25289#22374#39069#33707#21202#38215'","'#26032#24052#23572#34382#24038#26071'","'#38463#31302#21476#37070#38215'","'#38472#24052#23572#34382#26071'","'#24052#24422#24211#20161#38215'","'#37122#20262#26149#33258#27835#26071'","'#38463#37324#27827 +
        #38215'","'#37122#28201#20811#26063#33258#27835#26071'","'#24052#24422#25176#28023#38215'","'#33707#21147#36798#29926#36798#26017#23572#26063#33258#27835#26071'","'#23612#23572#22522#38215'"]'
      
        '"0_6_6",["'#19996#32988#21306'","'#36798#25289#29305#26071'","'#26641#26519#21484#38215'","'#20934#26684#23572#26071'","'#34203#23478#28286#38215'","'#37122#25176#20811#21069#26071'","'#25942#21202#21484#20854#38215'","'#37122#25176#20811#26071 +
        '","'#20044#20848#38215'","'#26477#38182#26071'","'#38177#23612#38215'","'#20044#23457#26071'","'#22030#40065#22270#38215'","'#20234#37329#38669#27931#26071'","'#38463#21202#33150#24109#28909#38215'"]'
      
        '"0_6_7",["'#38598#23425#21306'","'#20016#38215#24066'","'#21331#36164#21439'","'#21331#36164#23665#38215'","'#21270#24503#21439'","'#38271#39034#38215'","'#21830#37117#21439'","'#21830#37117#38215'","'#20852#21644#21439'",' +
        '"'#22478#20851#38215'","'#20937#22478#21439'","'#23729#28023#38215'","'#23519#21704#23572#21491#32764#21069#26071'","'#22303#36149#20044#25289#38215'","'#23519#21704#23572#21491#32764#20013#26071'","'#31185#24067#23572#38215'","'#23519#21704#23572#21491#32764#21518#26071'","' +
        #30333#38899#23519#24178#38215'","'#22235#23376#29579#26071'","'#20044#20848#33457#38215'"]'
      
        '"0_6_8",["'#20020#27827#21306'","'#20116#21407#21439'","'#38534#20852#26124#38215'","'#30964#21475#21439'","'#24052#24422#39640#21202#38215'","'#20044#25289#29305#21069#26071'","'#20044#25289#23665#38215'","'#20044#25289#29305#20013#26071'"' +
        ',"'#28023#27969#22270#38215'","'#20044#25289#29305#21518#26071'","'#24052#38899#23453#21147#26684#38215'","'#26477#38182#21518#26071'","'#38485#22365#38215'"]'
      
        '"0_6_9",["'#20044#20848#28009#29305#24066'","'#38463#23572#23665#24066'","'#31361#27849#21439'","'#31361#27849#38215'","'#31185#23572#27777#21491#32764#21069#26071'","'#22823#22365#27807#38215'","'#31185#23572#27777#21491#32764#20013#26071'","' +
        #24052#24422#21628#30805#38215'","'#25166#36169#29305#26071'","'#38899#24503#23572#38215'"]'
      
        '"0_6_10",["'#38177#26519#28009#29305#24066'","'#20108#36830#28009#29305#24066'","'#22810#20262#21439'","'#22810#20262#28118#23572#38215'","'#38463#24052#22030#26071'","'#21035#21147#21476#21488#38215'","'#33487#23612#29305#24038#26071'","' +
        #28385#37117#25289#22270#38215'","'#33487#23612#29305#21491#26071'","'#36187#27721#22612#25289#38215'","'#29664#31302#27777#26071'","'#20044#37324#38597#26031#22826#38215'","'#35199#20044#29664#31302#27777#26071'","'#22030#23572#37101#21202#38215'","'#22826#20166#23546#26071'","' +
        #23453#26124#38215'","'#38262#40644#26071'","'#26032#23453#25289#26684#38215'","'#27491#38262#30333#26071'","'#26126#23433#22270#38215'","'#27491#34013#26071'","'#19978#37117#38215'"]'
      '"0_6_11",["'#24052#24422#28009#29305#38215'","'#38463#25289#21892#21491#26071'","'#39069#32943#21628#37117#26684'","'#39069#27982#32435#26071'","'#36798#26469#21628#24067#38215'"]'
      
        '"0_6",["'#21628#21644#28009#29305#24066'","'#21253#22836#24066'","'#20044#28023#24066'","'#36196#23792#24066'","'#36890#36797#24066'","'#21628#20262#36125#23572#24066'","'#37122#23572#22810#26031#24066'","'#20044#20848#23519#24067#24066'","' +
        #24052#24422#28118#23572#24066'","'#20852#23433#30431'","'#38177#26519#37101#21202#30431'","'#38463#25289#21892#30431'"]'
      
        '"0_7_0",["'#27784#27827#21306'","'#21644#24179#21306'","'#22823#19996#21306'","'#30343#22993#21306'","'#38081#35199#21306'","'#33487#23478#23663#21306'","'#19996#38517#21306'","'#26032#22478#23376#21306'","'#20110#27946#21306'"' +
        ',"'#26032#27665#24066'","'#36797#20013#21439'","'#36797#20013#38215'","'#24247#24179#21439'","'#24247#24179#38215'","'#27861#24211#21439'","'#27861#24211#38215'"]'
      
        '"0_7_1",["'#21452#22612#21306'","'#40857#22478#21306'","'#21271#31080#24066'","'#20940#28304#24066'","'#26397#38451#21439'","'#26397#38451#24066#21452#22612#21306'","'#24314#24179#21439'","'#21888#21895#27777#24038#32764#33945#21476#26063#33258 +
        #27835#21439'","'#22823#22478#23376#38215'"]'
      
        '"0_7_2",["'#28023#24030#21306'","'#26032#37041#21306'","'#22826#24179#21306'","'#28165#27827#38376#21306'","'#32454#27827#21306'","'#24432#27494#21439'","'#24432#27494#38215'","'#38428#26032#33945#21476#26063#33258#27835#21439'","' +
        #38428#26032#38215'"]'
      
        '"0_7_3",["'#38134#24030#21306'","'#28165#27827#21306'","'#35843#20853#23665#24066'","'#24320#21407#24066'","'#38081#23725#21439'","'#38081#23725#24066#38134#24030#21306'","'#35199#20016#21439'","'#35199#20016#38215'","'#26124#22270 +
        #21439'","'#26124#22270#38215'"]'
      
        '"0_7_4",["'#39034#22478#21306'","'#26032#25242#21306'","'#19996#27954#21306'","'#26395#33457#21306'","'#25242#39034#21439'","'#25242#39034#24066#39034#22478#21306'","'#26032#23486#28385#26063#33258#27835#21439'","'#26032#23486#38215'",' +
        '"'#28165#21407#28385#26063#33258#27835#21439'","'#28165#21407#38215'"]'
      
        '"0_7_5",["'#24179#23665#21306'","'#28330#28246#21306'","'#26126#23665#21306'","'#21335#33452#21306'","'#26412#28330#28385#26063#33258#27835#21439'","'#23567#24066#38215'","'#26707#20161#28385#26063#33258#27835#21439'","'#26707#20161#38215'"' +
        ']'
      '"0_7_6",["'#30333#22612#21306'","'#25991#22307#21306'","'#23439#20255#21306'","'#24339#38271#23725#21306'","'#22826#23376#27827#21306'","'#28783#22612#24066'","'#36797#38451#21439'","'#39318#23665#38215'"]'
      
        '"0_7_7",["'#38081#19996#21306'","'#38081#35199#21306'","'#31435#23665#21306'","'#21315#23665#21306'","'#28023#22478#24066'","'#21488#23433#21439'","'#21488#23433#38215'","'#23723#23721#28385#26063#33258#27835#21439'","'#23723#23721 +
        #38215'"]'
      '"0_7_8",["'#25391#20852#21306'","'#20803#23453#21306'","'#25391#23433#21306'","'#20964#22478#24066'","'#19996#28207#24066'","'#23485#30008#28385#26063#33258#27835#21439'","'#23485#30008#38215'"]'
      
        '"0_7_9",["'#35199#23703#21306'","'#20013#23665#21306'","'#27801#27827#21475#21306'","'#29976#20117#23376#21306'","'#26053#39034#21475#21306'","'#37329#24030#21306'","'#29926#25151#24215#24066'","'#26222#20848#24215#24066'","'#24196 +
        #27827#24066'","'#38271#28023#21439'","'#22823#38271#23665#23707#38215'"]'
      '"0_7_10",["'#31449#21069#21306'","'#35199#24066#21306'","'#40069#40060#22280#21306'","'#32769#36793#21306'","'#22823#30707#26725#24066'","'#30422#24030#24066'"]'
      '"0_7_11",["'#20852#38534#21488#21306'","'#21452#21488#23376#21306'","'#22823#27964#21439'","'#22823#27964#38215'","'#30424#23665#21439'","'#30424#38182#24066#21452#21488#23376#21306'"]'
      '"0_7_12",["'#22826#21644#21306'","'#21476#22612#21306'","'#20940#27827#21306'","'#20940#28023#24066'","'#21271#23425#24066'","'#40657#23665#21439'","'#40657#23665#38215'","'#20041#21439'","'#20041#24030#38215'"]'
      '"0_7_13",["'#40857#28207#21306'","'#36830#23665#21306'","'#21335#31080#21306'","'#20852#22478#24066'","'#32485#20013#21439'","'#32485#20013#38215'","'#24314#26124#21439'","'#24314#26124#38215'"]'
      
        '"0_7",["'#27784#38451#24066'","'#26397#38451#24066'","'#38428#26032#24066'","'#38081#23725#24066'","'#25242#39034#24066'","'#26412#28330#24066'","'#36797#38451#24066'","'#38797#23665#24066'","'#20025#19996#24066'","'#22823#36830 +
        #24066'","'#33829#21475#24066'","'#30424#38182#24066'","'#38182#24030#24066'","'#33899#33446#23707#24066'"]'
      
        '"0_8_0",["'#26397#38451#21306'","'#21335#20851#21306'","'#23485#22478#21306'","'#20108#36947#21306'","'#32511#22253#21306'","'#21452#38451#21306'","'#24503#24800#24066'","'#20061#21488#24066'","'#27014#26641#24066'","' +
        #20892#23433#21439'","'#20892#23433#38215'"]'
      '"0_8_1",["'#27950#21271#21306'","'#22823#23433#24066'","'#27950#21335#24066'","'#38215#36169#21439'","'#38215#36169#38215'","'#36890#27014#21439'","'#24320#36890#38215'"]'
      
        '"0_8_2",["'#23425#27743#21306'","'#25206#20313#21439'","'#19977#23700#27827#38215'","'#38271#23725#21439'","'#38271#23725#38215'","'#20094#23433#21439'","'#20094#23433#38215'","'#21069#37101#23572#32599#26031#33945#21476#26063#33258#27835#21439 +
        '","'#21069#37101#38215'"]'
      
        '"0_8_3",["'#33337#33829#21306'","'#40857#28525#21306'","'#26124#37009#21306'","'#20016#28385#21306'","'#30928#30707#24066'","'#34527#27827#24066'","'#26726#30008#24066'","'#33298#20848#24066'","'#27704#21513#21439'","' +
        #21475#21069#38215'"]'
      '"0_8_4",["'#38081#35199#21306'","'#38081#19996#21306'","'#21452#36797#24066'","'#20844#20027#23725#24066'","'#26792#26641#21439'","'#26792#26641#38215'","'#20234#36890#28385#26063#33258#27835#21439'","'#20234#36890#38215'"]'
      '"0_8_5",["'#40857#23665#21306'","'#35199#23433#21306'","'#19996#20016#21439'","'#19996#20016#38215'","'#19996#36797#21439'","'#30333#27849#38215'"]'
      
        '"0_8_6",["'#19996#26124#21306'","'#20108#36947#27743#21306'","'#26757#27827#21475#24066'","'#38598#23433#24066'","'#36890#21270#21439'","'#24555#22823#33538#38215'","'#36745#21335#21439'","'#26397#38451#38215'","'#26611#27827#21439 +
        '","'#26611#27827#38215'"]'
      
        '"0_8_7",["'#20843#36947#27743#21306'","'#20020#27743#24066'","'#27743#28304#21439'","'#23385#23478#22561#23376#38215'","'#25242#26494#21439'","'#25242#26494#38215'","'#38742#23431#21439'","'#38742#23431#38215'","'#38271#30333#26397 +
        #40092#26063#33258#27835#21439'","'#38271#30333#38215'"]'
      
        '"0_8_8",["'#24310#21513#24066'","'#22270#20204#24066'","'#25958#21270#24066'","'#29682#26149#24066'","'#40857#20117#24066'","'#21644#40857#24066'","'#27754#28165#21439'","'#27754#28165#38215'","'#23433#22270#21439'","' +
        #26126#26376#38215'"]'
      '"0_8",["'#38271#26149#24066'","'#30333#22478#24066'","'#26494#21407#24066'","'#21513#26519#24066'","'#22235#24179#24066'","'#36797#28304#24066'","'#36890#21270#24066'","'#30333#23665#24066'","'#24310#36793#24030'"]'
      
        '"0_9_0",["'#26494#21271#21306'","'#36947#37324#21306'","'#21335#23703#21306'","'#36947#22806#21306'","'#39321#22346#21306'","'#21160#21147#21306'","'#24179#25151#21306'","'#21628#20848#21306'","'#21452#22478#24066'","' +
        #23578#24535#24066'","'#20116#24120#24066'","'#38463#22478#24066'","'#20381#20848#21439'","'#20381#20848#38215'","'#26041#27491#21439'","'#26041#27491#38215'","'#23486#21439'","'#23486#24030#38215'","'#24052#24422#21439'","'#24052#24422#38215'",' +
        '"'#26408#20848#21439'","'#26408#20848#38215'","'#36890#27827#21439'","'#36890#27827#38215'","'#24310#23551#21439'","'#24310#23551#38215'"]'
      
        '"0_9_1",["'#24314#21326#21306'","'#40857#27801#21306'","'#38081#38155#21306'","'#26114#26114#28330#21306'","'#23500#25289#23572#22522#21306'","'#30910#23376#23665#21306'","'#26757#37324#26031#36798#26017#23572#26063#21306'","'#35767#27827#24066 +
        '","'#40857#27743#21439'","'#40857#27743#38215'","'#20381#23433#21439'","'#20381#23433#38215'","'#27888#26469#21439'","'#27888#26469#38215'","'#29976#21335#21439'","'#29976#21335#38215'","'#23500#35029#21439'","'#23500#35029#38215'","'#20811 +
        #23665#21439'","'#20811#23665#38215'","'#20811#19996#21439'","'#20811#19996#38215'","'#25308#27849#21439'","'#25308#27849#38215'"]'
      '"0_9_2",["'#26691#23665#21306'","'#26032#20852#21306'","'#33540#23376#27827#21306'","'#21187#21033#21439'","'#21187#21033#38215'"]'
      
        '"0_9_3",["'#29233#36745#21306'","'#21271#23433#24066'","'#20116#22823#36830#27744#24066'","'#23273#27743#21439'","'#23273#27743#38215'","'#36874#20811#21439'","'#36793#30086#38215'","'#23385#21556#21439'","'#23385#21556#38215'"' +
        ']'
      
        '"0_9_4",["'#33832#23572#22270#21306'","'#40857#20964#21306'","'#35753#32993#36335#21306'","'#22823#21516#21306'","'#32418#23703#21306'","'#32903#24030#21439'","'#32903#24030#38215'","'#32903#28304#21439'","'#32903#28304#38215'"' +
        ',"'#26519#30008#21439'","'#26519#30008#38215'","'#26460#23572#20271#29305#33945#21476#26063#33258#27835#21439'","'#27888#24247#38215'"]'
      
        '"0_9_5",["'#20852#23665#21306'","'#21521#38451#21306'","'#24037#20892#21306'","'#21335#23665#21306'","'#20852#23433#21306'","'#19996#23665#21306'","'#33821#21271#21439'","'#20964#32724#38215'","'#32485#28392#21439'","' +
        #32485#28392#38215'"]'
      
        '"0_9_6",["'#20234#26149#21306'","'#21335#23700#21306'","'#21451#22909#21306'","'#35199#26519#21306'","'#32736#23782#21306'","'#26032#38738#21306'","'#32654#28330#21306'","'#37329#23665#23663#21306'","'#20116#33829#21306'",' +
        '"'#20044#39532#27827#21306'","'#27748#26106#27827#21306'","'#24102#23725#21306'","'#20044#20234#23725#21306'","'#32418#26143#21306'","'#19978#29976#23725#21306'","'#38081#21147#24066'","'#22025#33643#21439'","'#26397#38451#38215'"]'
      
        '"0_9_7",["'#21069#36827#21306'","'#27704#32418#21306'","'#21521#38451#21306'","'#19996#39118#21306'","'#37066#21306'","'#21516#27743#24066'","'#23500#38182#24066'","'#26726#21335#21439'","'#26726#21335#38215'","'#26726 +
        #24029#21439'","'#24742#26469#38215'","'#27748#21407#21439'","'#27748#21407#38215'","'#25242#36828#21439'","'#25242#36828#38215'"]'
      
        '"0_9_8",["'#23574#23665#21306'","'#23725#19996#21306'","'#22235#26041#21488#21306'","'#23453#23665#21306'","'#38598#36132#21439'","'#31119#21033#38215'","'#21451#35850#21439'","'#21451#35850#38215'","'#23453#28165#21439'",' +
        '"'#23453#28165#38215'","'#39286#27827#21439'","'#39286#27827#38215'"]'
      
        '"0_9_9",["'#40481#20896#21306'","'#24658#23665#21306'","'#28404#36947#21306'","'#26792#26641#21306'","'#22478#23376#27827#21306'","'#40635#23665#21306'","'#34382#26519#24066'","'#23494#23665#24066'","'#40481#19996#21439'",' +
        '"'#40481#19996#38215'"]'
      
        '"0_9_10",["'#29233#27665#21306'","'#19996#23433#21306'","'#38451#26126#21306'","'#35199#23433#21306'","'#31302#26865#24066'","'#32485#33452#27827#24066'","'#28023#26519#24066'","'#23425#23433#24066'","'#19996#23425#21439'"' +
        ',"'#19996#23425#38215'","'#26519#21475#21439'","'#26519#21475#38215'"]'
      
        '"0_9_11",["'#21271#26519#21306'","'#23433#36798#24066'","'#32903#19996#24066'","'#28023#20262#24066'","'#26395#22862#21439'","'#26395#22862#38215'","'#20848#35199#21439'","'#20848#35199#38215'","'#38738#20872#21439'",' +
        '"'#38738#20872#38215'","'#24198#23433#21439'","'#24198#23433#38215'","'#26126#27700#21439'","'#26126#27700#38215'","'#32485#26865#21439'","'#32485#26865#38215'"]'
      '"0_9_12",["'#21628#29595#21439'","'#21628#29595#38215'","'#22612#27827#21439'","'#22612#27827#38215'","'#28448#27827#21439'","'#35199#26519#21513#38215'"]'
      
        '"0_9",["'#21704#23572#28392#24066'","'#40784#40784#21704#23572#24066'","'#19971#21488#27827#24066'","'#40657#27827#24066'","'#22823#24198#24066'","'#40548#23703#24066'","'#20234#26149#24066'","'#20339#26408#26031#24066'","'#21452#40493#23665 +
        #24066'","'#40481#35199#24066'","'#29281#20025#27743#24066'","'#32485#21270#24066'","'#22823#20852#23433#23725'"]'
      
        '"0_10_0",["'#29572#27494#21306'","'#30333#19979#21306'","'#31206#28142#21306'","'#24314#37050#21306'","'#40723#27004#21306'","'#19979#20851#21306'","'#28006#21475#21306'","'#20845#21512#21306'","'#26646#38686#21306'",' +
        '"'#38632#33457#21488#21306'","'#27743#23425#21306'","'#28327#27700#21439'","'#27704#38451#38215'","'#39640#28147#21439'","'#28147#28330#38215'"]'
      
        '"0_10_1",["'#20113#40857#21306'","'#40723#27004#21306'","'#20061#37324#21306'","'#36158#27754#21306'","'#27849#23665#21306'","'#37043#24030#24066'","'#26032#27778#24066'","'#38108#23665#21439'","'#38108#23665#38215'",' +
        '"'#30562#23425#21439'","'#30562#22478#38215'","'#27803#21439'","'#27803#22478#38215'","'#20016#21439'","'#20964#22478#38215'"]'
      
        '"0_10_2",["'#26032#28006#21306'","'#36830#20113#21306'","'#28023#24030#21306'","'#36195#27014#21439'","'#38738#21475#38215'","'#28748#20113#21439'","'#20234#23665#38215'","'#19996#28023#21439'","'#29275#23665#38215'",' +
        '"'#28748#21335#21439'","'#26032#23433#38215'"]'
      '"0_10_3",["'#23487#22478#21306'","'#23487#35947#21306'","'#27821#38451#21439'","'#27821#22478#38215'","'#27863#38451#21439'","'#20247#20852#38215'","'#27863#27946#21439'","'#38738#38451#38215'"]'
      
        '"0_10_4",["'#28165#27827#21306'","'#28165#28006#21306'","'#26970#24030#21306'","'#28142#38452#21306'","'#37329#28246#21439'","'#40654#22478#38215'","'#30449#30489#21439'","'#30449#22478#38215'","'#27946#27901#21439'",' +
        '"'#39640#33391#28071#38215'","'#28063#27700#21439'","'#28063#22478#38215'"]'
      
        '"0_10_5",["'#20141#28246#21306'","'#30416#37117#21306'","'#19996#21488#24066'","'#22823#20016#24066'","'#23556#38451#21439'","'#21512#24503#38215'","'#38428#23425#21439'","'#38428#22478#38215'","'#28392#28023#21439'",' +
        '"'#19996#22350#38215'","'#21709#27700#21439'","'#21709#27700#38215'","'#24314#28246#21439'","'#36817#28246#38215'"]'
      '"0_10_6",["'#32500#25196#21306'","'#24191#38517#21306'","'#37015#27743#21306'","'#20202#24449#24066'","'#27743#37117#24066'","'#39640#37038#24066'","'#23453#24212#21439'","'#23433#23452#38215'"]'
      '"0_10_7",["'#28023#38517#21306'","'#39640#28207#21306'","'#38742#27743#24066'","'#27888#20852#24066'","'#23004#22576#24066'","'#20852#21270#24066'"]'
      
        '"0_10_8",["'#23815#24029#21306'","'#28207#38392#21306'","'#28023#38376#24066'","'#21551#19996#24066'","'#36890#24030#24066'","'#22914#30347#24066'","'#22914#19996#21439'","'#25496#28207#38215'","'#28023#23433#21439'",' +
        '"'#28023#23433#38215'"]'
      '"0_10_9",["'#20140#21475#21306'","'#28070#24030#21306'","'#20025#24466#21306'","'#25196#20013#24066'","'#20025#38451#24066'","'#21477#23481#24066'"]'
      '"0_10_10",["'#38047#27004#21306'","'#22825#23425#21306'","'#25114#22661#22576#21306'","'#26032#21271#21306'","'#27494#36827#21306'","'#37329#22363#24066'","'#28327#38451#24066'"]'
      '"0_10_11",["'#23815#23433#21306'","'#21335#38271#21306'","'#21271#22616#21306'","'#28392#28246#21306'","'#24800#23665#21306'","'#38177#23665#21306'","'#27743#38452#24066'","'#23452#20852#24066'"]'
      
        '"0_10_12",["'#37329#38410#21306'","'#27815#28010#21306'","'#24179#27743#21306'","'#34382#19992#21306'","'#21556#20013#21306'","'#30456#22478#21306'","'#21556#27743#24066'","'#26118#23665#24066'","'#22826#20179#24066'"' +
        ',"'#24120#29087#24066'","'#24352#23478#28207#24066'"]'
      
        '"0_10",["'#21335#20140#24066'","'#24464#24030#24066'","'#36830#20113#28207#24066'","'#23487#36801#24066'","'#28142#23433#24066'","'#30416#22478#24066'","'#25196#24030#24066'","'#27888#24030#24066'","'#21335#36890#24066'","' +
        #38215#27743#24066'","'#24120#24030#24066'","'#26080#38177#24066'","'#33487#24030#24066'"]'
      
        '"0_11_0",["'#25329#22661#21306'","'#19978#22478#21306'","'#19979#22478#21306'","'#27743#24178#21306'","'#35199#28246#21306'","'#28392#27743#21306'","'#20313#26477#21306'","'#33831#23665#21306'","'#20020#23433#24066'",' +
        '"'#23500#38451#24066'","'#24314#24503#24066'","'#26704#24208#21439'","'#28147#23433#21439'","'#21315#23707#28246#38215'"]'
      '"0_11_1",["'#21556#20852#21306'","'#21335#27988#21306'","'#38271#20852#21439'","'#38601#22478#38215'","'#24503#28165#21439'","'#27494#24247#38215'","'#23433#21513#21439'","'#36882#38138#38215'"]'
      '"0_11_2",["'#21335#28246#21306'","'#31168#27954#21306'","'#24179#28246#24066'","'#28023#23425#24066'","'#26704#20065#24066'","'#22025#21892#21439'","'#39759#22616#38215'","'#28023#30416#21439'","'#27494#21407#38215'"]'
      '"0_11_3",["'#23450#28023#21306'","'#26222#38464#21306'","'#23729#23665#21439'","'#39640#20141#38215'","'#23882#27863#21439'","'#33756#22253#38215'"]'
      
        '"0_11_4",["'#28023#26329#21306'","'#27743#19996#21306'","'#27743#21271#21306'","'#21271#20177#21306'","'#38215#28023#21306'","'#37150#24030#21306'","'#24904#28330#24066'","'#20313#23002#24066'","'#22857#21270#24066'",' +
        '"'#23425#28023#21439'","'#35937#23665#21439'"]'
      '"0_11_5",["'#36234#22478#21306'","'#35832#26280#24066'","'#19978#34398#24066'","'#23882#24030#24066'","'#32461#20852#21439'","'#26032#26124#21439'","'#22478#20851#38215'"]'
      '"0_11_6",["'#26607#22478#21306'","'#34914#27743#21306'","'#27743#23665#24066'","'#24120#23665#21439'","'#22825#39532#38215'","'#24320#21270#21439'","'#22478#20851#38215'","'#40857#28216#21439'"]'
      
        '"0_11_7",["'#23162#22478#21306'","'#37329#19996#21306'","'#20848#28330#24066'","'#27704#24247#24066'","'#20041#20044#24066'","'#19996#38451#24066'","'#27494#20041#21439'","'#28006#27743#21439'","'#30928#23433#21439'",' +
        '"'#23433#25991#38215'"]'
      
        '"0_11_8",["'#26898#27743#21306'","'#40644#23721#21306'","'#36335#26725#21306'","'#20020#28023#24066'","'#28201#23725#24066'","'#19977#38376#21439'","'#28023#28216#38215'","'#22825#21488#21439'","'#20185#23621#21439'",' +
        '"'#29577#29615#21439'","'#29664#28207#38215'"]'
      
        '"0_11_9",["'#40575#22478#21306'","'#40857#28286#21306'","'#29935#28023#21306'","'#29790#23433#24066'","'#20048#28165#24066'","'#27704#22025#21439'","'#19978#22616#38215'","'#25991#25104#21439'","'#22823#23747#38215'",' +
        '"'#24179#38451#21439'","'#26118#38451#38215'","'#27888#39034#21439'","'#32599#38451#38215'","'#27934#22836#21439'","'#21271#23705#38215'","'#33485#21335#21439'","'#28789#28330#38215'"]'
      
        '"0_11_10",["'#33714#37117#21306'","'#40857#27849#24066'","'#32537#20113#21439'","'#20116#20113#38215'","'#38738#30000#21439'","'#40548#22478#38215'","'#20113#21644#21439'","'#20113#21644#38215'","'#36930#26124#21439'"' +
        ',"'#22937#39640#38215'","'#26494#38451#21439'","'#35199#23631#38215'","'#24198#20803#21439'","'#26494#28304#38215'","'#26223#23425#33258#27835#21439'","'#40548#28330#38215'"]'
      
        '"0_11",["'#26477#24030#24066'","'#28246#24030#24066'","'#22025#20852#24066'","'#33311#23665#24066'","'#23425#27874#24066'","'#32461#20852#24066'","'#34914#24030#24066'","'#37329#21326#24066'","'#21488#24030#24066'","'#28201 +
        #24030#24066'","'#20029#27700#24066'"]'
      
        '"0_12_0",["'#24208#38451#21306'","'#29814#28023#21306'","'#34560#23665#21306'","'#21253#27827#21306'","'#38271#20016#21439'","'#27700#28246#38215'","'#32933#19996#21439'","'#24215#22496#38215'","'#32933#35199#21439'",' +
        '"'#19978#27966#38215'"]'
      '"0_12_1",["'#22471#26725#21306'","'#30720#23665#21439'","'#30720#22478#38215'","'#33831#21439'","'#40857#22478#38215'","'#28789#29863#21439'","'#28789#22478#38215'","'#27863#21439'","'#27863#22478#38215'"]'
      '"0_12_2",["'#30456#23665#21306'","'#26460#38598#21306'","'#28872#23665#21306'","'#28617#28330#21439'","'#28617#28330#38215'"]'
      '"0_12_3",["'#35887#22478#21306'","'#28065#38451#21439'","'#22478#20851#38215'","'#33945#22478#21439'","'#22478#20851#38215'","'#21033#36763#21439'","'#22478#20851#38215'"]'
      
        '"0_12_4",["'#39053#24030#21306'","'#39053#19996#21306'","'#39053#27849#21306'","'#30028#39318#24066'","'#20020#27849#21439'","'#22478#20851#38215'","'#22826#21644#21439'","'#22478#20851#38215'","'#38428#21335#21439'",' +
        '"'#22478#20851#38215'","'#39053#19978#21439'","'#24910#22478#38215'"]'
      
        '"0_12_5",["'#34444#23665#21306'","'#40857#23376#28246#21306'","'#31161#20250#21306'","'#28142#19978#21306'","'#24576#36828#21439'","'#22478#20851#38215'","'#20116#27827#21439'","'#22478#20851#38215'","'#22266#38215#21439'"' +
        ',"'#22478#20851#38215'"]'
      '"0_12_6",["'#30000#23478#24245#21306'","'#22823#36890#21306'","'#35874#23478#38598#21306'","'#20843#20844#23665#21306'","'#28504#38598#21306'","'#20964#21488#21439'","'#22478#20851#38215'"]'
      
        '"0_12_7",["'#29701#21306'","'#21335#35887#21306'","'#26126#20809#24066'","'#22825#38271#24066'","'#26469#23433#21439'","'#26032#23433#38215'","'#20840#26898#21439'","'#35140#27827#38215'","'#23450#36828#21439'","' +
        #23450#22478#38215'","'#20964#38451#21439'","'#24220#22478#38215'"]'
      '"0_12_8",["'#38632#23665#21306'","'#33457#23665#21306'","'#37329#23478#24196#21306'","'#24403#28034#21439'","'#22993#23408#38215'"]'
      
        '"0_12_9",["'#38236#28246#21306'","'#24331#27743#21306'","'#19977#23665#21306'","'#40480#27743#21306'","'#33436#28246#21439'","'#28286#38215'","'#32321#26124#21439'","'#32321#38451#38215'","'#21335#38517#21439'","' +
        #31821#23665#38215'"]'
      '"0_12_10",["'#38108#23448#23665#21306'","'#29422#23376#23665#21306'","'#37066#21306'","'#38108#38517#21439'","'#20116#26494#38215'"]'
      
        '"0_12_11",["'#36814#27743#21306'","'#22823#35266#21306'","'#23452#31168#21306'","'#26704#22478#24066'","'#24576#23425#21439'","'#39640#27827#38215'","'#26526#38451#21439'","'#26526#38451#38215'","'#28508#23665#21439'"' +
        ',"'#26757#22478#38215'","'#22826#28246#21439'","'#26187#29081#38215'","'#23487#26494#21439'","'#23386#29577#38215'","'#26395#27743#21439'","'#38647#38451#38215'","'#23731#35199#21439'","'#22825#22530#38215'"]'
      
        '"0_12_12",["'#23663#28330#21306'","'#40644#23665#21306'","'#24509#24030#21306'","'#27481#21439'","'#24509#22478#38215'","'#20241#23425#21439'","'#28023#38451#38215'","'#40671#21439'","'#30887#38451#38215'","' +
        #31041#38376#21439'","'#31041#23665#38215'"]'
      
        '"0_12_13",["'#37329#23433#21306'","'#35029#23433#21306'","'#23551#21439'","'#23551#26149#38215'","'#38669#37041#21439'","'#22478#20851#38215'","'#33298#22478#21439'","'#22478#20851#38215'","'#37329#23528#21439'",' +
        '"'#26757#23665#38215'","'#38669#23665#21439'","'#34913#23665#38215'"]'
      '"0_12_14",["'#23621#24034#21306'","'#24208#27743#21439'","'#24208#22478#38215'","'#26080#20026#21439'","'#26080#22478#38215'","'#21547#23665#21439'","'#29615#23792#38215'","'#21644#21439'","'#21382#38451#38215'"]'
      '"0_12_15",["'#36149#27744#21306'","'#19996#33267#21439'","'#23591#28193#38215'","'#30707#21488#21439'","'#19971#37324#38215'","'#38738#38451#21439'","'#33993#22478#38215'"]'
      
        '"0_12_16",["'#23459#24030#21306'","'#23425#22269#24066'","'#37070#28330#21439'","'#24314#24179#38215'","'#24191#24503#21439'","'#26691#24030#38215'","'#27902#21439'","'#27902#24029#38215'","'#26060#24503#21439'",' +
        '"'#26060#38451#38215'","'#32489#28330#21439'","'#21326#38451#38215'"]'
      
        '"0_12",["'#21512#32933#24066'","'#23487#24030#24066'","'#28142#21271#24066'","'#20147#24030#24066'","'#38428#38451#24066'","'#34444#22496#24066'","'#28142#21335#24066'","'#28353#24030#24066'","'#39532#38797#23665#24066'","' +
        #33436#28246#24066'","'#38108#38517#24066'","'#23433#24198#24066'","'#40644#23665#24066'","'#20845#23433#24066'","'#24034#28246#24066'","'#27744#24030#24066'","'#23459#22478#24066'"]'
      
        '"0_13_0",["'#40723#27004#21306'","'#21488#27743#21306'","'#20179#23665#21306'","'#39532#23614#21306'","'#26187#23433#21306'","'#31119#28165#24066'","'#38271#20048#24066'","'#38397#20399#21439'","'#36830#27743#21439'",' +
        '"'#20964#22478#38215'","'#32599#28304#21439'","'#20964#23665#38215'","'#38397#28165#21439'","'#26757#22478#38215'","'#27704#27888#21439'","'#27167#22478#38215'","'#24179#28525#21439'","'#28525#22478#38215'"]'
      
        '"0_13_1",["'#24310#24179#21306'","'#37045#27494#24066'","'#27494#22839#23665#24066'","'#24314#29935#24066'","'#24314#38451#24066'","'#39034#26124#21439'","'#28006#22478#21439'","'#20809#27901#21439'","'#26477#24029#38215'"' +
        ',"'#26494#28330#21439'","'#26494#28304#38215'","'#25919#21644#21439'","'#29066#23665#38215'"]'
      '"0_13_2",["'#22478#21410#21306'","'#28085#27743#21306'","'#33620#22478#21306'","'#31168#23679#21306'","'#20185#28216#21439'"]'
      
        '"0_13_3",["'#26757#21015#21306'","'#19977#20803#21306'","'#27704#23433#24066'","'#26126#28330#21439'","'#38634#23792#38215'","'#28165#27969#21439'","'#40857#27941#38215'","'#23425#21270#21439'","'#32736#27743#38215'",' +
        '"'#22823#30000#21439'","'#22343#28330#38215'","'#23588#28330#21439'","'#22478#20851#38215'","'#27801#21439'","'#23558#20048#21439'","'#21476#38235#38215'","'#27888#23425#21439'","'#26441#22478#38215'","'#24314#23425#21439'","'#28617#22478#38215'"' +
        ']'
      
        '"0_13_4",["'#40100#22478#21306'","'#20016#27901#21306'","'#27931#27743#21306'","'#27849#28207#21306'","'#30707#29422#24066'","'#26187#27743#24066'","'#21335#23433#24066'","'#24800#23433#21439'","'#34746#22478#38215'",' +
        '"'#23433#28330#21439'","'#20964#22478#38215'","'#27704#26149#21439'","'#26691#22478#38215'","'#24503#21270#21439'","'#27988#20013#38215'","'#37329#38376#21439'","'#9734'"]'
      '"0_13_5",["'#24605#26126#21306'","'#28023#27815#21306'","'#28246#37324#21306'","'#38598#32654#21306'","'#21516#23433#21306'","'#32724#23433#21306'"]'
      
        '"0_13_6",["'#33431#22478#21306'","'#40857#25991#21306'","'#40857#28023#24066'","'#20113#38660#21439'","'#20113#38517#38215'","'#28467#28006#21439'","'#32485#23433#38215'","'#35791#23433#21439'","'#21335#35791#38215'",' +
        '"'#38271#27888#21439'","'#27494#23433#38215'","'#19996#23665#21439'","'#35199#22484#38215'","'#21335#38742#21439'","'#23665#22478#38215'","'#24179#21644#21439'","'#23567#28330#38215'","'#21326#23433#21439'","'#21326#20016#38215'"]'
      
        '"0_13_7",["'#26032#32599#21306'","'#28467#24179#24066'","'#38271#27712#21439'","'#27712#24030#38215'","'#27704#23450#21439'","'#20964#22478#38215'","'#19978#26477#21439'","'#20020#27743#38215'","'#27494#24179#21439'",' +
        '"'#24179#24029#38215'","'#36830#22478#21439'","'#33714#23792#38215'"]'
      
        '"0_13_8",["'#34121#22478#21306'","'#31119#23433#24066'","'#31119#40718#24066'","'#23551#23425#21439'","'#40140#38451#38215'","'#38686#28006#21439'","'#26584#33635#21439'","'#21452#22478#38215'","'#23631#21335#21439'",' +
        '"'#21476#23792#38215'","'#21476#30000#21439'","'#21608#23425#21439'","'#29422#22478#38215'"]'
      '"0_13",["'#31119#24030#24066'","'#21335#24179#24066'","'#33670#30000#24066'","'#19977#26126#24066'","'#27849#24030#24066'","'#21414#38376#24066'","'#28467#24030#24066'","'#40857#23721#24066'","'#23425#24503#24066'"]'
      
        '"0_14_0",["'#19996#28246#21306'","'#35199#28246#21306'","'#38738#20113#35889#21306'","'#28286#37324#21306'","'#38738#23665#28246#21306'","'#21335#26124#21439'","'#33714#22616#38215'","'#26032#24314#21439'","'#38271#22542#38215 +
        '","'#23433#20041#21439'","'#40857#27941#38215'","'#36827#36132#21439'","'#27665#21644#38215'"]'
      
        '"0_14_1",["'#27988#38451#21306'","'#24208#23665#21306'","'#29790#26124#24066'","'#20061#27743#21439'","'#27801#27827#34903#38215'","'#27494#23425#21439'","'#26032#23425#38215'","'#20462#27700#21439'","'#20041#23425#38215'"' +
        ',"'#27704#20462#21439'","'#28034#22496#38215'","'#24503#23433#21439'","'#33970#20141#38215'","'#26143#23376#21439'","'#21335#24247#38215'","'#37117#26124#21439'","'#37117#26124#38215'","'#28246#21475#21439'","'#21452#38047#38215'","'#24429#27901 +
        #21439'","'#40857#22478#38215'"]'
      '"0_14_2",["'#29664#23665#21306'","'#26124#27743#21306'","'#20048#24179#24066'","'#28014#26753#21439'","'#28014#26753#38215'"]'
      '"0_14_3",["'#26376#28246#21306'","'#36149#28330#24066'","'#20313#27743#21439'","'#37011#22496#38215'"]'
      '"0_14_4",["'#28189#27700#21306'","'#20998#23452#21439'","'#20998#23452#38215'"]'
      '"0_14_5",["'#23433#28304#21306'","'#28248#19996#21306'","'#33714#33457#21439'","'#29748#20141#38215'","'#19978#26647#21439'","'#19978#26647#38215'","'#33446#28330#21439'","'#33446#28330#38215'"]'
      
        '"0_14_6",["'#31456#36129#21306'","'#29790#37329#24066'","'#21335#24247#24066'","'#36195#21439'","'#26757#26519#38215'","'#20449#20016#21439'","'#22025#23450#38215'","'#22823#20313#21439'","'#21335#23433#38215'","' +
        #19978#29369#21439'","'#19996#23665#38215'","'#23815#20041#21439'","'#27178#27700#38215'","'#23433#36828#21439'","'#27427#23665#38215'","'#40857#21335#21439'","'#40857#21335#38215'","'#23450#21335#21439'","'#21382#24066#38215'","'#20840#21335#21439'"' +
        ',"'#22478#21410#38215'","'#23425#37117#21439'","'#26757#27743#38215'","'#20110#37117#21439'","'#36129#27743#38215'","'#20852#22269#21439'","'#28491#27743#38215'","'#20250#26124#21439'","'#25991#27494#22365#38215'","'#23547#20044#21439'","'#38271 +
        #23425#38215'","'#30707#22478#21439'","'#29748#27743#38215'"]'
      
        '"0_14_7",["'#20449#24030#21306'","'#24503#20852#24066'","'#19978#39286#21439'","'#26093#26085#38215'","'#24191#20016#21439'","'#27704#20016#38215'","'#29577#23665#21439'","'#20912#28330#38215'","'#38085#23665#21439'",' +
        '"'#27827#21475#38215'","'#27178#23792#21439'","'#23697#38451#38215'","'#24331#38451#21439'","'#24331#27743#38215'","'#20313#24178#21439'","'#29577#20141#38215'","'#37169#38451#21439'","'#37169#38451#38215'","'#19975#24180#21439'","'#38472#33829#38215 +
        '","'#23162#28304#21439'","'#32043#38451#38215'"]'
      
        '"0_14_8",["'#20020#24029#21306'","'#21335#22478#21439'","'#24314#26124#38215'","'#40654#24029#21439'","'#26085#23792#38215'","'#21335#20016#21439'","'#29748#22478#38215'","'#23815#20161#21439'","'#24052#23665#38215'",' +
        '"'#20048#23433#21439'","'#40140#28330#38215'","'#23452#40644#21439'","'#20964#20872#38215'","'#37329#28330#21439'","'#31168#35895#38215'","'#36164#28330#21439'","'#40548#22478#38215'","'#19996#20065#21439'","'#23389#23703#38215'","'#24191#26124#21439 +
        '","'#26100#27743#38215'"]'
      
        '"0_14_9",["'#34945#24030#21306'","'#20016#22478#24066'","'#27167#26641#24066'","'#39640#23433#24066'","'#22857#26032#21439'","'#20911#24029#38215'","'#19975#36733#21439'","'#19978#39640#21439'","'#23452#20016#21439'",' +
        '"'#26032#26124#38215'","'#38742#23433#21439'","'#21452#28330#38215'","'#38108#40723#21439'","'#27704#23425#38215'"]'
      
        '"0_14_10",["'#21513#24030#21306'","'#38738#21407#21306'","'#20117#20872#23665#24066'","'#21414#22378#38215'","'#21513#23433#21439'","'#25958#21402#38215'","'#21513#27700#21439'","'#25991#23792#38215'","'#23777#27743#21439 +
        '","'#27700#36793#38215'","'#26032#24178#21439'","'#37329#24029#38215'","'#27704#20016#21439'","'#24681#27743#38215'","'#27888#21644#21439'","'#28548#27743#38215'","'#36930#24029#21439'","'#27849#27743#38215'","'#19975#23433#21439'","'#33433 +
        #33993#38215'","'#23433#31119#21439'","'#24179#37117#38215'","'#27704#26032#21439'","'#31166#24029#38215'"]'
      
        '"0_14",["'#21335#26124#24066'","'#20061#27743#24066'","'#26223#24503#38215#24066'","'#40560#28525#24066'","'#26032#20313#24066'","'#33805#20065#24066'","'#36195#24030#24066'","'#19978#39286#24066'","'#25242#24030#24066'","' +
        #23452#26149#24066'","'#21513#23433#24066'"]'
      
        '"0_15_0",["'#24066#20013#21306'","'#21382#19979#21306'","'#27088#33643#21306'","'#22825#26725#21306'","'#21382#22478#21306'","'#38271#28165#21306'","'#31456#19992#24066'","'#24179#38452#21439'","'#24179#38452#38215'",' +
        '"'#27982#38451#21439'","'#27982#38451#38215'","'#21830#27827#21439'"]'
      
        '"0_15_1",["'#24066#21335#21306'","'#24066#21271#21306'","'#22235#26041#21306'","'#40644#23707#21306'","'#23810#23665#21306'","'#22478#38451#21306'","'#26446#27815#21306'","'#33014#24030#24066'","'#21363#22696#24066'",' +
        '"'#24179#24230#24066'","'#33014#21335#24066'","'#33713#35199#24066'"]'
      '"0_15_2",["'#19996#26124#24220#21306'","'#20020#28165#24066'","'#38451#35895#21439'","'#33688#21439'","'#33548#24179#21439'","'#19996#38463#21439'","'#20896#21439'","'#20896#22478#38215'","'#39640#21776#21439'"]'
      
        '"0_15_3",["'#24503#22478#21306'","'#20048#38517#24066'","'#31161#22478#24066'","'#38517#21439'","'#38517#22478#38215'","'#24179#21407#21439'","'#22799#27941#21439'","'#22799#27941#38215'","'#27494#22478#21439'","' +
        #27494#22478#38215'","'#40784#27827#21439'","'#26191#22478#38215'","'#20020#37009#21439'","'#23425#27941#21439'","'#23425#27941#38215'","'#24198#20113#21439'","'#24198#20113#38215'"]'
      '"0_15_4",["'#19996#33829#21306'","'#27827#21475#21306'","'#22438#21033#21439'","'#22438#21033#38215'","'#21033#27941#21439'","'#21033#27941#38215'","'#24191#39286#21439'","'#24191#39286#38215'"]'
      
        '"0_15_5",["'#24352#24215#21306'","'#28100#24029#21306'","'#21338#23665#21306'","'#20020#28100#21306'","'#21608#26449#21306'","'#26707#21488#21439'","'#32034#38215'","'#39640#38738#21439'","'#30000#38215'","'#27778 +
        #28304#21439'","'#21335#40635#38215'"]'
      
        '"0_15_6",["'#28493#22478#21306'","'#23506#20141#21306'","'#22346#23376#21306'","'#22862#25991#21306'","'#23433#19992#24066'","'#26124#37009#24066'","'#39640#23494#24066'","'#38738#24030#24066'","'#35832#22478#24066'",' +
        '"'#23551#20809#24066'","'#20020#26384#21439'","'#26124#20048#21439'"]'
      
        '"0_15_7",["'#33713#23665#21306'","'#33437#32600#21306'","'#31119#23665#21306'","'#29279#24179#21306'","'#26646#38686#24066'","'#28023#38451#24066'","'#40857#21475#24066'","'#33713#38451#24066'","'#33713#24030#24066'",' +
        '"'#34028#33713#24066'","'#25307#36828#24066'","'#38271#23707#21439'","'#21335#38271#23665#38215'"]'
      '"0_15_8",["'#29615#32736#21306'","'#33635#25104#24066'","'#20083#23665#24066'","'#25991#30331#24066'"]'
      '"0_15_9",["'#19996#28207#21306'","'#23706#23665#21306'","'#20116#33714#21439'","'#27946#20957#38215'","'#33682#21439'","'#22478#38451#38215'"]'
      
        '"0_15_10",["'#20848#23665#21306'","'#32599#24196#21306'","'#27827#19996#21306'","'#37103#22478#21439'","'#37103#22478#38215'","'#33485#23665#21439'","'#21342#24196#38215'","'#33682#21335#21439'","'#21313#23383#36335#38215 +
        '","'#27778#27700#21439'","'#27778#27700#38215'","'#33945#38452#21439'","'#33945#38452#38215'","'#24179#37009#21439'","'#24179#37009#38215'","'#36153#21439'","'#36153#22478#38215'","'#27778#21335#21439'","'#30028#28246#38215'","'#20020#27821 +
        #21439'","'#20020#27821#38215'"]'
      '"0_15_11",["'#34203#22478#21306'","'#24066#20013#21306'","'#23748#22478#21306'","'#21488#20799#24196#21306'","'#23665#20141#21306'","'#28373#24030#24066'"]'
      
        '"0_15_12",["'#24066#20013#21306'","'#20219#22478#21306'","'#26354#38428#24066'","'#20822#24030#24066'","'#37049#22478#24066'","'#24494#23665#21439'","'#40060#21488#21439'","'#35895#20141#38215'","'#37329#20065#21439'"' +
        ',"'#37329#20065#38215'","'#22025#31077#21439'","'#22025#31077#38215'","'#27766#19978#21439'","'#27766#19978#38215'","'#27863#27700#21439'","'#26753#23665#21439'","'#26753#23665#38215'"]'
      '"0_15_13",["'#27888#23665#21306'","'#23729#23731#21306'","'#26032#27888#24066'","'#32933#22478#24066'","'#23425#38451#21439'","'#23425#38451#38215'","'#19996#24179#21439'","'#19996#24179#38215'"]'
      '"0_15_14",["'#33713#22478#21306'","'#38050#22478#21306'"]'
      
        '"0_15_15",["'#28392#22478#21306'","'#24800#27665#21439'","'#24800#27665#38215'","'#38451#20449#21439'","'#38451#20449#38215'","'#26080#26851#21439'","'#26080#26851#38215'","'#27838#21270#21439'","'#23500#22269#38215'"' +
        ',"'#21338#20852#21439'","'#21338#20852#38215'","'#37049#24179#21439'"]'
      
        '"0_15_16",["'#29281#20025#21306'","'#26361#21439'","'#26361#22478#38215'","'#23450#38518#21439'","'#23450#38518#38215'","'#25104#27494#21439'","'#25104#27494#38215'","'#21333#21439'","'#21333#22478#38215'","' +
        #24040#37326#21439'","'#24040#37326#38215'","'#37075#22478#21439'","'#37075#22478#38215'","'#37124#22478#21439'","'#37124#22478#38215'","'#19996#26126#21439'","'#22478#20851#38215'"]'
      
        '"0_15",["'#27982#21335#24066'","'#38738#23707#24066'","'#32842#22478#24066'","'#24503#24030#24066'","'#19996#33829#24066'","'#28100#21338#24066'","'#28493#22346#24066'","'#28895#21488#24066'","'#23041#28023#24066'","'#26085 +
        #29031#24066'","'#20020#27778#24066'","'#26531#24196#24066'","'#27982#23425#24066'","'#27888#23433#24066'","'#33713#33436#24066'","'#28392#24030#24066'","'#33743#27901#24066'"]'
      
        '"0_16_0",["'#20013#21407#21306'","'#20108#19971#21306'","'#31649#22478#22238#26063#21306'","'#37329#27700#21306'","'#19978#34903#21306'","'#24800#27982#21306#57355'","'#26032#37073#24066'","'#30331#23553#24066'","'#26032#23494 +
        #24066'","'#24041#20041#24066'","'#33637#38451#24066'","'#20013#29279#21439'","'#22478#20851#38215'"]'
      
        '"0_16_1",["'#40723#27004#21306'","'#40857#20141#21306'","'#39034#27827#22238#26063#21306'","'#31161#29579#21488#21306'","'#37329#26126#21306'","'#26462#21439'","'#22478#20851#38215'","'#36890#35768#21439'","'#22478#20851#38215 +
        '","'#23561#27663#21439'","'#22478#20851#38215'","'#24320#23553#21439'","'#22478#20851#38215'","'#20848#32771#21439'","'#22478#20851#38215'"]'
      '"0_16_2",["'#28246#28392#21306'","'#20041#39532#24066'","'#28789#23453#24066'","'#28177#27744#21439'","'#22478#20851#38215'","'#38485#21439'","'#22823#33829#38215'","'#21346#27663#21439'","'#22478#20851#38215'"]'
      
        '"0_16_3",["'#35199#24037#21306'","'#32769#22478#21306'","'#28685#27827#22238#26063#21306'","'#28071#35199#21306'","'#21513#21033#21306'","'#27931#40857#21306'","'#20547#24072#24066'","'#23391#27941#21439'","'#22478#20851#38215 +
        '","'#26032#23433#21439'","'#22478#20851#38215'","'#26686#24029#21439'","'#22478#20851#38215'","'#23913#21439'","'#22478#20851#38215'","'#27741#38451#21439'","'#22478#20851#38215'","'#23452#38451#21439'","'#22478#20851#38215'","'#27931#23425 +
        #21439'","'#22478#20851#38215'","'#20234#24029#21439'","'#22478#20851#38215'"]'
      
        '"0_16_4",["'#35299#25918#21306'","'#23665#38451#21306'","'#20013#31449#21306'","'#39532#26449#21306'","'#23391#24030#24066'","'#27777#38451#24066'","'#20462#27494#21439'","'#22478#20851#38215'","'#21338#29233#21439'",' +
        '"'#28165#21270#38215'","'#27494#38495#21439'","'#26408#22478#38215'","'#28201#21439'","'#28201#27849#38215'"]'
      
        '"0_16_5",["'#21355#28392#21306'","'#32418#26071#21306'","'#20964#27849#21306'","'#29287#37326#21306'","'#21355#36745#24066'","'#36745#21439#24066'","'#26032#20065#21439'","'#26032#20065#32418#26071#21306'","'#33719#22025#21439 +
        '","'#22478#20851#38215'","'#21407#38451#21439'","'#22478#20851#38215'","'#24310#27941#21439'","'#22478#20851#38215'","'#23553#19992#21439'","'#22478#20851#38215'","'#38271#22435#21439'","'#22478#20851#38215'"]'
      '"0_16_6",["'#28103#28392#21306'","'#23665#22478#21306'","'#40548#23665#21306'","'#27994#21439'","'#22478#20851#38215'","'#28103#21439'","'#26397#27468#38215'"]'
      
        '"0_16_7",["'#21271#20851#21306'","'#25991#23792#21306'","'#27575#37117#21306'","'#40857#23433#21306'","'#26519#24030#24066'","'#23433#38451#21439'","'#23433#38451#21271#20851#21306'","'#27748#38452#21439'","'#22478#20851#38215 +
        '","'#28369#21439'","'#36947#21475#38215'","'#20869#40644#21439'","'#22478#20851#38215'"]'
      
        '"0_16_8",["'#21326#40857#21306'","'#28165#20016#21439'","'#22478#20851#38215'","'#21335#20048#21439'","'#22478#20851#38215'","'#33539#21439'","'#22478#20851#38215'","'#21488#21069#21439'","'#22478#20851#38215'","' +
        #28654#38451#21439'","'#22478#20851#38215'"]'
      
        '"0_16_9",["'#26753#22253#21306'","'#30562#38451#21306'","'#27704#22478#24066'","'#34398#22478#21439'","'#22478#20851#38215'","'#27665#26435#21439'","'#22478#20851#38215'","'#23425#38517#21439'","'#22478#20851#38215'",' +
        '"'#30562#21439'","'#22478#20851#38215'","'#22799#37009#21439'","'#22478#20851#38215'","'#26584#22478#21439'","'#22478#20851#38215'"]'
      
        '"0_16_10",["'#39759#37117#21306'","'#31161#24030#24066'","'#38271#33883#24066'","'#35768#26124#21439'","'#35768#26124#39759#37117#21306'","'#37154#38517#21439'","'#23433#38517#38215'","'#35140#22478#21439'","'#22478#20851 +
        #38215'"]'
      '"0_16_11",["'#28304#27719#21306'","'#37118#22478#21306'","'#21484#38517#21306'","'#33310#38451#21439'","'#33310#27849#38215'","'#20020#39053#21439'","'#22478#20851#38215'"]'
      
        '"0_16_12",["'#26032#21326#21306'","'#21355#19996#21306'","'#28251#27827#21306'","'#30707#40857#21306'","'#33310#38050#24066'","'#27741#24030#24066'","'#23453#20016#21439'","'#22478#20851#38215'","'#21494#21439'",' +
        '"'#26118#38451#38215'","'#40065#23665#21439'","'#40065#38451#38215'","'#37071#21439'","'#22478#20851#38215'"]'
      
        '"0_16_13",["'#21351#40857#21306'","'#23451#22478#21306'","'#37011#24030#24066'","'#21335#21484#21439'","'#22478#20851#38215'","'#26041#22478#21439'","'#22478#20851#38215'","'#35199#23777#21439'","'#38215#24179#21439'"' +
        ',"'#22478#20851#38215'","'#20869#20065#21439'","'#22478#20851#38215'","'#28101#24029#21439'","'#31038#26071#21439'","'#36170#24215#38215'","'#21776#27827#21439'","'#26032#37326#21439'","'#22478#20851#38215'","'#26704#26575#21439'","'#22478#20851 +
        #38215'"]'
      
        '"0_16_14",["'#27827#21306'","'#24179#26725#21306'","'#24687#21439'","'#22478#20851#38215'","'#28142#28392#21439'","'#22478#20851#38215'","'#28514#24029#21439'","'#20809#23665#21439'","'#22266#22987#21439'","' +
        #22478#20851#38215'","'#21830#22478#21439'","'#22478#20851#38215'","'#32599#23665#21439'","'#22478#20851#38215'","'#26032#21439'","'#26032#38598#38215'"]'
      
        '"0_16_15",["'#24029#27719#21306'","'#39033#22478#24066'","'#25206#27807#21439'","'#22478#20851#38215'","'#35199#21326#21439'","'#22478#20851#38215'","'#21830#27700#21439'","'#22478#20851#38215'","'#22826#24247#21439'"' +
        ',"'#22478#20851#38215'","'#40575#37009#21439'","'#22478#20851#38215'","'#37112#22478#21439'","'#22478#20851#38215'","'#28142#38451#21439'","'#22478#20851#38215'","'#27784#19992#21439'","'#27088#24215#38215'"]'
      
        '"0_16_16",["'#39551#22478#21306'","'#30830#23665#21439'","'#30424#40857#38215'","'#27852#38451#21439'","'#27852#27700#38215'","'#36930#24179#21439'","'#28744#38451#38215'","'#35199#24179#21439'","'#19978#34081#21439'"' +
        ',"'#34081#37117#38215'","'#27741#21335#21439'","'#27741#23425#38215'","'#24179#33286#21439'","'#21476#27088#38215'","'#26032#34081#21439'","'#21476#21525#38215'","'#27491#38451#21439'","'#30495#38451#38215'"]'
      
        '"0_16",["'#37073#24030#24066'","'#24320#23553#24066'","'#19977#38376#23777#24066'","'#27931#38451#24066'","'#28966#20316#24066'","'#26032#20065#24066'","'#40548#22721#24066'","'#23433#38451#24066'","'#28654#38451#24066'","' +
        #21830#19992#24066'","'#35768#26124#24066'","'#28463#27827#24066'","'#24179#39030#23665#24066'","'#21335#38451#24066'","'#20449#38451#24066'","'#21608#21475#24066'","'#39547#39532#24215#24066'"]'
      
        '"0_17_0",["'#27743#23736#21306'","'#27743#27721#21306'","'#30810#21475#21306'","'#27721#38451#21306'","'#27494#26124#21306'","'#38738#23665#21306'","'#27946#23665#21306'","'#19996#35199#28246#21306'","'#27721#21335#21306'"' +
        ',"'#34081#30008#21306'","'#27743#22799#21306'","'#40644#38466#21306'","'#26032#27954#21306'"]'
      
        '"0_17_1",["'#24352#28286#21306'","'#33541#31661#21306'","'#20025#27743#21475#24066'","'#37095#21439'","'#22478#20851#38215'","'#31481#23665#21439'","'#22478#20851#38215'","'#25151#21439'","'#22478#20851#38215'","' +
        #37095#35199#21439'","'#22478#20851#38215'","'#31481#28330#21439'","'#22478#20851#38215'"]'
      
        '"0_17_2",["'#35140#22478#21306'","'#27146#22478#21306'","'#35140#38451#21306'","'#32769#27827#21475#24066'","'#26531#38451#24066'","'#23452#22478#24066'","'#21335#28467#21439'","'#22478#20851#38215'","'#35895#22478#21439'"' +
        ',"'#22478#20851#38215'","'#20445#24247#21439'","'#22478#20851#38215'"]'
      '"0_17_3",["'#19996#23453#21306'","'#25479#20992#21306'","'#38047#31077#24066'","'#27801#27915#21439'","'#27801#27915#38215'","'#20140#23665#21439'","'#26032#24066#38215'"]'
      
        '"0_17_4",["'#23389#21335#21306'","'#24212#22478#24066'","'#23433#38470#24066'","'#27721#24029#24066'","'#23389#26124#21439'","'#33457#22253#38215'","'#22823#24735#21439'","'#22478#20851#38215'","'#20113#26790#21439'",' +
        '"'#22478#20851#38215'"]'
      
        '"0_17_5",["'#40644#24030#21306'","'#40635#22478#24066'","'#27494#31348#24066'","'#32418#23433#21439'","'#22478#20851#38215'","'#32599#30000#21439'","'#20964#23665#38215'","'#33521#23665#21439'","'#28201#27849#38215'",' +
        '"'#28000#27700#21439'","'#28165#27849#38215'","'#34162#26149#21439'","'#28437#27827#38215'","'#40644#26757#21439'","'#40644#26757#38215'","'#22242#39118#21439'","'#22242#39118#38215'"]'
      '"0_17_6",["'#37122#22478#21306'","'#26753#23376#28246#21306'","'#21326#23481#21306'"]'
      '"0_17_7",["'#40644#30707#28207#21306'","'#35199#22622#23665#21306'","'#19979#38470#21306'","'#38081#23665#21306'","'#22823#20918#24066'","'#38451#26032#21439'","'#20852#22269#38215'"]'
      
        '"0_17_8",["'#21688#23433#21306'","'#36196#22721#24066'","'#22025#40060#21439'","'#40060#23731#38215'","'#36890#22478#21439'","'#38589#27700#38215'","'#23815#38451#21439'","'#22825#22478#38215'","'#36890#23665#21439'",' +
        '"'#36890#32650#38215'"]'
      
        '"0_17_9",["'#27801#24066#21306'","'#33606#24030#21306'","'#30707#39318#24066'","'#27946#28246#24066'","'#26494#28363#24066'","'#27743#38517#21439'","'#37085#31348#38215'","'#20844#23433#21439'","'#26007#28246#22564#38215'"' +
        ',"'#30417#21033#21439'","'#23481#22478#38215'"]'
      
        '"0_17_10",["'#35199#38517#21306'","'#20237#23478#23703#21306'","'#28857#20891#21306'","'#29447#20141#21306'","'#22839#38517#21306'","'#26525#27743#24066'","'#23452#37117#24066'","'#24403#38451#24066'","'#36828#23433#21439 +
        '","'#40483#20964#38215'","'#20852#23665#21439'","'#21476#22827#38215'","'#31213#24402#21439'","'#33541#22378#38215'","'#38271#38451#33258#27835#21439'","'#40857#33311#22378#38215'","'#20116#23792#33258#27835#21439'","'#20116#23792#38215'"]'
      '"0_17_11",["'#26366#37117#21306'","'#24191#27700#24066'"]'
      '"0_17_12",["'#20185#26691#24066'","'#22825#38376#24066'","'#28508#27743#24066'","'#31070#20892#26550#26519#21306'","'#26494#26575#38215'"]'
      
        '"0_17_13",["'#24681#26045#24066'","'#21033#24029#24066'","'#24314#22987#21439'","'#19994#24030#38215'","'#24052#19996#21439'","'#20449#38517#38215'","'#23459#24681#21439'","'#29664#23665#38215'","'#21688#20016#21439'"' +
        ',"'#39640#20048#23665#38215'","'#26469#20964#21439'","'#32724#20964#38215'","'#40548#23792#21439'","'#23481#32654#38215'"]'
      
        '"0_17",["'#27494#27721#24066'","'#21313#22576#24066'","'#35140#27146#24066'","'#33606#38376#24066'","'#23389#24863#24066'","'#40644#20872#24066'","'#37122#24030#24066'","'#40644#30707#24066'","'#21688#23425#24066'","'#33606 +
        #24030#24066'","'#23452#26124#24066'","'#38543#24030#24066'","'#30465#34892#25919#21333#20301'","'#24681#26045#24030'"]'
      
        '"0_18_0",["'#38271#27801#24066'","'#23731#40595#21306'","'#33433#33993#21306'","'#22825#24515#21306'","'#24320#31119#21306'","'#38632#33457#21306'","'#27983#38451#24066'","'#38271#27801#21439'","'#26143#27801#38215'",' +
        '"'#26395#22478#21439'","'#39640#22616#23725#38215'","'#23425#20065#21439'","'#29577#28525#38215'"]'
      '"0_18_1",["'#27704#23450#21306'","'#27494#38517#28304#21306'","'#24904#21033#21439'","'#38646#38451#38215'","'#26705#26893#21439'","'#28583#28304#38215'"]'
      
        '"0_18_2",["'#27494#38517#21306'","'#40718#22478#21306'","'#27941#24066#24066'","'#23433#20065#21439'","'#22478#20851#38215'","'#27721#23551#21439'","'#40857#38451#38215'","'#28583#21439'","'#28583#38451#38215'","' +
        #20020#28583#21439'","'#23433#31119#38215'","'#26691#28304#21439'","'#28467#27743#38215'","'#30707#38376#21439'","'#26970#27743#38215'"]'
      '"0_18_3",["'#36203#23665#21306'","'#36164#38451#21306'","'#27781#27743#24066'","'#21335#21439'","'#21335#27954#38215'","'#26691#27743#21439'","'#26691#33457#27743#38215'","'#23433#21270#21439'","'#19996#22378#38215'"]'
      
        '"0_18_4",["'#23731#38451#27004#21306'","'#21531#23665#21306'","'#20113#28330#21306'","'#27752#32599#24066'","'#20020#28248#24066'","'#23731#38451#21439'","'#33635#23478#28286#38215'","'#21326#23481#21439'","'#22478#20851#38215 +
        '","'#28248#38452#21439'","'#25991#26143#38215'","'#24179#27743#21439'","'#27721#26124#38215'"]'
      
        '"0_18_5",["'#22825#20803#21306'","'#33655#22616#21306'","'#33446#28126#21306'","'#30707#23792#21306'","'#37300#38517#24066'","'#26666#27954#21439'","'#28172#21475#38215'","'#25912#21439'","'#22478#20851#38215'","' +
        #33590#38517#21439'","'#22478#20851#38215'","'#28814#38517#21439'","'#38686#38451#38215'"]'
      '"0_18_6",["'#23731#22616#21306'","'#38632#28246#21306'","'#28248#20065#24066'","'#38902#23665#24066'","'#28248#28525#21439'","'#26131#20439#27827#38215'"]'
      
        '"0_18_7",["'#38593#23792#21306'","'#29664#26198#21306'","'#30707#40723#21306'","'#33976#28248#21306'","'#21335#23731#21306'","'#24120#23425#24066'","'#32786#38451#24066'","'#34913#38451#21439'","'#35199#28193#38215'",' +
        '"'#34913#21335#21439'","'#20113#38598#38215'","'#34913#23665#21439'","'#24320#20113#38215'","'#34913#19996#21439'","'#22478#20851#38215'","'#31041#19996#21439'","'#27946#26725#38215'"]'
      
        '"0_18_8",["'#21271#28246#21306'","'#33487#20185#21306'","'#36164#20852#24066'","'#26690#38451#21439'","'#22478#20851#38215'","'#27704#20852#21439'","'#22478#20851#38215'","'#23452#31456#21439'","'#22478#20851#38215'",' +
        '"'#22025#31166#21439'","'#22478#20851#38215'","'#20020#27494#21439'","'#22478#20851#38215'","'#27741#22478#21439'","'#22478#20851#38215'","'#26690#19996#21439'","'#22478#20851#38215'","'#23433#20161#21439'","'#22478#20851#38215'"]'
      
        '"0_18_9",["'#20919#27700#28393#21306'","'#38646#38517#21306'","'#19996#23433#21439'","'#30333#29273#24066#38215'","'#36947#21439'","'#36947#27743#38215'","'#23425#36828#21439'","'#33308#38517#38215'","'#27743#27704#21439'"' +
        ',"'#28487#28006#38215'","'#34013#23665#21439'","'#22612#23792#38215'","'#26032#30000#21439'","'#40857#27849#38215'","'#21452#29260#21439'","'#27895#27850#38215'","'#31041#38451#21439'","'#28015#28330#38215'","'#27743#21326#33258#27835#21439'","' +
        #27825#27743#38215'"]'
      
        '"0_18_10",["'#21452#28165#21306'","'#22823#31077#21306'","'#21271#22612#21306'","'#27494#20872#24066'","'#37045#19996#21439'","'#20004#24066#38215'","'#37045#38451#21439'","'#22616#28193#21475#38215'","'#26032#37045#21439 +
        '","'#37247#28330#38215'","'#38534#22238#21439'","'#26691#27946#38215'","'#27934#21475#21439'","'#27934#21475#38215'","'#32485#23425#21439'","'#38271#38138#38215'","'#26032#23425#21439'","'#37329#30707#38215'","'#22478#27493#33258#27835#21439'",' +
        '"'#20754#26519#38215'"]'
      
        '"0_18_11",["'#40548#22478#21306'","'#27946#27743#24066'","'#27781#38517#21439'","'#27781#38517#38215'","'#36784#28330#21439'","'#36784#38451#38215'","'#28294#28006#21439'","'#21346#23792#38215'","'#20013#26041#21439'"' +
        ',"'#20013#26041#38215'","'#20250#21516#21439'","'#26519#22478#38215'","'#40635#38451#33258#27835#21439'","'#39640#26449#38215'","'#26032#26179#33258#27835#21439'","'#26032#26179#38215'","'#33463#27743#33258#27835#21439'","'#33463#27743#38215'","'#38742#24030 +
        #33258#27835#21439'","'#28192#38451#38215'","'#36890#36947#33258#27835#21439'","'#21452#27743#38215'"]'
      '"0_18_12",["'#23044#26143#21306'","'#20919#27700#27743#24066'","'#28063#28304#24066'","'#21452#23792#21439'","'#27704#20016#38215'","'#26032#21270#21439'","'#19978#26757#38215'"]'
      
        '"0_18_13",["'#21513#39318#24066'","'#27896#28330#21439'","'#30333#27801#38215'","'#20964#20976#21439'","'#27825#27743#38215'","'#33457#22435#21439'","'#33457#22435#38215'","'#20445#38742#21439'","'#36801#38517#38215'"' +
        ',"'#21476#19976#21439'","'#21476#38451#38215'","'#27704#39034#21439'","'#28789#28330#38215'","'#40857#23665#21439'"]'
      
        '"0_18",["'#38271#27801#24066'","'#24352#23478#30028#24066'","'#24120#24503#24066'","'#30410#38451#24066'","'#23731#38451#24066'","'#26666#27954#24066'","'#28248#28525#24066'","'#34913#38451#24066'","'#37108#24030#24066'","' +
        #27704#24030#24066'","'#37045#38451#24066'","'#24576#21270#24066'","'#23044#24213#24066'","'#28248#35199#24030'"]'
      
        '"0_19_0",["'#36234#31168#21306'","'#33620#28286#21306'","'#28023#29664#21306'","'#22825#27827#21306'","'#30333#20113#21306'","'#40644#22484#21306'","'#30058#31162#21306'","'#33457#37117#21306'","'#21335#27801#21306'",' +
        '"'#33821#23703#21306'","'#22686#22478#24066'","'#20174#21270#24066'"]'
      '"0_19_1",["'#31119#30000#21306'","'#32599#28246#21306'","'#21335#23665#21306'","'#23453#23433#21306'","'#40857#23703#21306'","'#30416#30000#21306'"]'
      
        '"0_19_2",["'#28165#22478#21306'","'#33521#24503#24066'","'#36830#24030#24066'","'#20315#20872#21439'","'#30707#35282#38215'","'#38451#23665#21439'","'#38451#22478#38215'","'#28165#26032#21439'","'#22826#21644#38215'",' +
        '"'#36830#23665#33258#27835#21439'","'#21513#30000#38215'","'#36830#21335#33258#27835#21439'","'#19977#27743#38215'"]'
      
        '"0_19_3",["'#27976#27743#21306'","'#27494#27743#21306'","'#26354#27743#21306'","'#20048#26124#24066'","'#21335#38596#24066'","'#22987#20852#21439'","'#22826#24179#38215'","'#20161#21270#21439'","'#20161#21270#38215'",' +
        '"'#32705#28304#21439'","'#40857#20185#38215'","'#26032#20016#21439'","'#20083#28304#33258#27835#21439'","'#20083#22478#38215'"]'
      
        '"0_19_4",["'#28304#22478#21306'","'#32043#37329#21439'","'#32043#22478#38215'","'#40857#24029#21439'","'#32769#38534#38215'","'#36830#24179#21439'","'#20803#21892#38215'","'#21644#24179#21439'","'#38451#26126#38215'",' +
        '"'#19996#28304#21439'","'#20185#22616#38215'"]'
      
        '"0_19_5",["'#26757#27743#21306'","'#20852#23425#24066'","'#26757#21439'","'#31243#27743#38215'","'#22823#22484#21439'","'#28246#23534#38215'","'#20016#39034#21439'","'#27748#22353#38215'","'#20116#21326#21439'","' +
        #27700#23528#38215'","'#24179#36828#21439'","'#22823#26584#38215'","'#34121#23725#21439'","'#34121#22478#38215'"]'
      '"0_19_6",["'#28248#26725#21306'","'#28526#23433#21439'","'#24245#22496#38215'","'#39286#24179#21439'","'#40644#20872#38215'"]'
      '"0_19_7",["'#37329#24179#21306'","'#28640#27743#21306'","'#40857#28246#21306'","'#28526#38451#21306'","'#28526#21335#21306'","'#28548#28023#21306'","'#21335#28595#21439'","'#21518#23429#38215'"]'
      '"0_19_8",["'#27029#22478#21306'","'#26222#23425#24066'","'#25581#19996#21439'","'#26354#28330#38215'","'#25581#35199#21439'","'#27827#23110#38215'","'#24800#26469#21439'","'#24800#22478#38215'"]'
      '"0_19_9",["'#22478#21306'","'#38470#20016#24066'","'#28023#20016#21439'","'#28023#22478#38215'","'#38470#27827#21439'","'#27827#30000#38215'"]'
      '"0_19_10",["'#24800#22478#21306'","'#24800#38451#21306'","'#21338#32599#21439'","'#32599#38451#38215'","'#24800#19996#21439'","'#40857#38376#21439'"]'
      '"0_19_12",["'#31119#30000#21306'","'#32599#28246#21306'","'#21335#23665#21306'","'#23453#23433#21306'","'#40857#23703#21306'","'#30416#30000#21306'"]'
      '"0_19_13",["'#39321#27954#21306'","'#26007#38376#21306'","'#37329#28286#21306'"]'
      '"0_19_15",["'#27743#28023#21306'","'#34028#27743#21306'","'#26032#20250#21306'","'#24681#24179#24066'","'#21488#23665#24066'","'#24320#24179#24066'","'#40548#23665#24066'"]'
      '"0_19_16",["'#31109#22478#21306'","'#21335#28023#21306'","'#39034#24503#21306'","'#19977#27700#21306'","'#39640#26126#21306'"]'
      
        '"0_19_17",["'#31471#24030#21306'","'#40718#28246#21306'","'#39640#35201#24066'","'#22235#20250#24066'","'#24191#23425#21439'","'#21335#34903#38215'","'#24576#38598#21439'","'#24576#22478#38215'","'#23553#24320#21439'"' +
        ',"'#27743#21475#38215'","'#24503#24198#21439'"]'
      '"0_19_18",["'#20113#22478#21306'","'#32599#23450#24066'","'#20113#23433#21439'","'#20845#37117#38215'","'#26032#20852#21439'","'#26032#22478#38215'","'#37057#21335#21439'","'#37117#22478#38215'"]'
      '"0_19_19",["'#27743#22478#21306'","'#38451#26149#24066'","'#38451#35199#21439'","'#32455#38215'","'#38451#19996#21439'","'#19996#22478#38215'"]'
      '"0_19_20",["'#33538#21335#21306'","'#33538#28207#21306'","'#21270#24030#24066'","'#20449#23452#24066'","'#39640#24030#24066'","'#30005#30333#21439'","'#27700#19996#38215'"]'
      
        '"0_19_21",["'#36196#22350#21306'","'#38686#23665#21306'","'#22369#22836#21306'","'#40635#31456#21306'","'#21556#24029#24066'","'#24265#27743#24066'","'#38647#24030#24066'","'#36930#28330#21439'","'#36930#22478#38215'"' +
        ',"'#24464#38395#21439'","'#24191#24030#19996#23665#21306'","'#33459#26449#21306'","'#24191#24030#21335#27801#21306'","'#33821#23703#21306'"]'
      
        '"0_19",["'#24191#24030#24066'","'#28145#22323#24066'","'#28165#36828#24066'","'#38902#20851#24066'","'#27827#28304#24066'","'#26757#24030#24066'","'#28526#24030#24066'","'#27733#22836#24066'","'#25581#38451#24066'","'#27733 +
        #23614#24066'","'#24800#24030#24066'","'#19996#33694#24066'","'#28145#22323#24066'","'#29664#28023#24066'","'#20013#23665#24066'","'#27743#38376#24066'","'#20315#23665#24066'","'#32903#24198#24066'","'#20113#28014#24066'","'#38451#27743#24066'",' +
        '"'#33538#21517#24066'","'#28251#27743#24066'"]'
      
        '"0_20_0",["'#38738#31168#21306'","'#20852#23425#21306'","'#27743#21335#21306'","'#35199#20065#22616#21306'","'#33391#24198#21306'","'#37013#23425#21306'","'#27494#40483#21439'","'#27178#21439'","'#23486#38451#21439'",' +
        '"'#19978#26519#21439'","'#38534#23433#21439'","'#39532#23665#21439'"]'
      
        '"0_20_1",["'#35937#23665#21306'","'#21472#24425#21306'","'#31168#23792#21306'","'#19971#26143#21306'","'#38593#23665#21306'","'#38451#26388#21439'","'#38451#26388#38215'","'#20020#26690#21439'","'#20020#26690#38215'",' +
        '"'#28789#24029#21439'","'#28789#24029#38215'","'#20840#24030#21439'","'#20840#24030#38215'","'#20852#23433#21439'","'#20852#23433#38215'","'#27704#31119#21439'","'#27704#31119#38215'","'#28748#38451#21439'","'#28748#38451#38215'","'#36164#28304#21439 +
        '","'#36164#28304#38215'","'#24179#20048#21439'","'#24179#20048#38215'","'#33620#28006#21439'","'#33620#22478#38215'","'#40857#32988#33258#27835#21439'","'#40857#32988#38215'","'#24685#22478#33258#27835#21439'","'#24685#22478#38215'"]'
      
        '"0_20_2",["'#22478#20013#21306'","'#40060#23792#21306'","'#26611#21335#21306'","'#26611#21271#21306'","'#26611#27743#21439'","'#25289#22561#38215'","'#26611#22478#21439'","'#22823#22484#38215'","'#40575#23528#21439'",' +
        '"'#40575#23528#38215'","'#34701#23433#21439'","'#38271#23433#38215'","'#19977#27743#33258#27835#21439'","'#21476#23452#38215'","'#34701#27700#33258#27835#21439'","'#34701#27700#38215'"]'
      
        '"0_20_3",["'#19975#31168#21306'","'#34678#23665#21306'","'#38271#27954#21306'","'#23697#28330#24066'","'#33485#26791#21439'","'#40857#22313#38215'","'#34276#21439'","'#34276#24030#38215'","'#33945#23665#21439'","' +
        #33945#23665#38215'"]'
      '"0_20_4",["'#28207#21271#21306'","'#28207#21335#21306'","'#35203#22616#21306'","'#26690#24179#24066'","'#24179#21335#21439'","'#24179#21335#38215'"]'
      
        '"0_20_5",["'#29577#24030#21306'","'#21271#27969#24066'","'#20852#19994#21439'","'#30707#21335#38215'","'#23481#21439'","'#23481#24030#38215'","'#38470#24029#21439'","'#38470#22478#38215'","'#21338#30333#21439'","' +
        #21338#30333#38215'"]'
      '"0_20_6",["'#38054#21335#21306'","'#38054#21271#21306'","'#28789#23665#21439'","'#28789#22478#38215'","'#28006#21271#21439'","'#23567#27743#38215'"]'
      '"0_20_7",["'#28023#22478#21306'","'#38134#28023#21306'","'#38081#23665#28207#21306'","'#21512#28006#21439'","'#24265#24030#38215'"]'
      '"0_20_8",["'#28207#21475#21306'","'#38450#22478#21306'","'#19996#20852#24066'","'#19978#24605#21439'","'#24605#38451#38215'"]'
      
        '"0_20_9",["'#27743#24030#21306'","'#20973#31077#24066'","'#25206#32485#21439'","'#26032#23425#38215'","'#22823#26032#21439'","'#26691#22478#38215'","'#22825#31561#21439'","'#22825#31561#38215'","'#23425#26126#21439'",' +
        '"'#22478#20013#38215'","'#40857#24030#21439'","'#40857#24030#38215'"]'
      
        '"0_20_10",["'#21491#27743#21306'","'#30000#38451#21439'","'#30000#24030#38215'","'#30000#19996#21439'","'#24179#39532#38215'","'#24179#26524#21439'","'#39532#22836#38215'","'#24503#20445#21439'","'#22478#20851#38215'"' +
        ',"'#38742#35199#21439'","'#26032#38742#38215'","'#37027#22369#21439'","'#22478#21410#38215'","'#20940#20113#21439'","'#27863#22478#38215'","'#20048#19994#21439'","'#21516#20048#38215'","'#35199#26519#21439'","'#20843#36798#38215'","'#30000#26519 +
        #21439'","'#20048#37324#38215'","'#38534#26519#33258#27835#21439'","'#26032#24030#38215'"]'
      
        '"0_20_11",["'#37329#22478#27743#21306'","'#23452#24030#24066'","'#21335#20025#21439'","'#22478#20851#38215'","'#22825#23784#21439'","'#20845#25490#38215'","'#20964#23665#21439'","'#20964#22478#38215'","'#19996#20848#21439 +
        '","'#19996#20848#38215'","'#24052#39532#33258#27835#21439'","'#24052#39532#38215'","'#37117#23433#33258#27835#21439'","'#23433#38451#38215'","'#22823#21270#33258#27835#21439'","'#22823#21270#38215'","'#32599#22478#33258#27835#21439'","'#19996#38376#38215'",' +
        '"'#29615#27743#33258#27835#21439'","'#24605#24681#38215'"]'
      
        '"0_20_12",["'#20852#23486#21306'","'#21512#23665#24066'","'#35937#24030#21439'","'#35937#24030#38215'","'#27494#23459#21439'","'#27494#23459#38215'","'#24571#22478#21439'","'#22478#20851#38215'","'#37329#31168#33258#27835 +
        #21439'","'#37329#31168#38215'"]'
      '"0_20_13",["'#20843#27493#21306'","'#26157#24179#21439'","'#26157#24179#38215'","'#38047#23665#21439'","'#38047#23665#38215'","'#23500#24029#29814#26063#33258#27835#21439'","'#23500#38451#38215'"]'
      
        '"0_20",["'#21335#23425#24066'","'#26690#26519#24066'","'#26611#24030#24066'","'#26791#24030#24066'","'#36149#28207#24066'","'#29577#26519#24066'","'#38054#24030#24066'","'#21271#28023#24066'","'#38450#22478#28207#24066'","' +
        #23815#24038#24066'","'#30334#33394#24066'","'#27827#27744#24066'","'#26469#23486#24066'","'#36154#24030#24066'"]'
      '"0_21_0",["'#40857#21326#21306'","'#31168#33521#21306'","'#29756#23665#21306'","'#32654#20848#21306'"]'
      
        '"0_21_2",["'#25991#26124#24066'","'#29756#28023#24066'","'#19975#23425#24066'","'#20116#25351#23665#24066'","'#19996#26041#24066'","'#20747#24030#24066'","'#20020#39640#21439'","'#20020#22478#38215'","'#28548#36808#21439'"' +
        ',"'#37329#27743#38215'","'#23450#23433#21439'","'#23450#22478#38215'","'#23663#26124#21439'","'#23663#22478#38215'","'#26124#27743#33258#27835#21439'","'#30707#30860#38215'","'#30333#27801#33258#27835#21439'","'#29273#21449#38215'","'#29756#20013#33258#27835 +
        #21439'","'#33829#26681#38215'","'#38517#27700#33258#27835#21439'","'#26928#26519#38215'","'#20445#20141#33258#27835#21439'","'#20445#22478#38215'","'#20048#19996#33258#27835#21439'","'#25265#30001#38215'"]'
      '"0_21",["'#28023#21475#24066'","'#19977#20122#24066'","'#30465#30452#36758#34892#25919#21333#20301'"]'
      
        '"0_22_0",["'#38738#32650#21306'","'#38182#27743#21306'","'#37329#29275#21306'","'#27494#20399#21306'","'#25104#21326#21306'","'#40857#27849#39551#21306'","'#38738#30333#27743#21306'","'#26032#37117#21306'","'#28201#27743#21306 +
        '","'#37117#27743#22576#24066'","'#24429#24030#24066'","'#37019#23811#24066'","'#23815#24030#24066'","'#37329#22530#21439'","'#36213#38215'","'#21452#27969#21439'","'#37099#21439'","'#37099#31570#38215'","'#22823#37009#21439'","'#26187#21407 +
        #38215'","'#33970#27743#21439'","'#40548#23665#38215'","'#26032#27941#21439'","'#20116#27941#38215'"]'
      
        '"0_22_1",["'#24066#20013#21306'","'#20803#22365#21306'","'#26397#22825#21306'","'#26106#33485#21439'","'#19996#27827#38215'","'#38738#24029#21439'","'#20052#24196#38215'","'#21073#38401#21439'","'#19979#23546#38215'",' +
        '"'#33485#28330#21439'","'#38517#27743#38215'"]'
      
        '"0_22_2",["'#28074#22478#21306'","'#28216#20185#21306'","'#27743#27833#24066'","'#19977#21488#21439'","'#28540#24029#38215'","'#30416#20141#21439'","'#20113#28330#38215'","'#23433#21439'","'#33457#33604#38215'","' +
        #26771#28540#21439'","'#25991#26124#38215'","'#21271#24029#33258#27835#21439'","'#26354#23665#38215'","'#24179#27494#21439'","'#40857#23433#38215'"]'
      '"0_22_3",["'#26060#38451#21306'","'#20160#37025#24066'","'#24191#27721#24066'","'#32501#31481#24066'","'#32599#27743#21439'","'#32599#27743#38215'","'#20013#27743#21439'","'#20975#27743#38215'"]'
      
        '"0_22_4",["'#39034#24198#21306'","'#39640#22378#21306'","'#22025#38517#21306'","'#38406#20013#24066'","'#21335#37096#21439'","'#21335#38534#38215'","'#33829#23665#21439'","'#26391#27744#38215'","'#34028#23433#21439'",' +
        '"'#21608#21475#38215'","'#20202#38471#21439'","'#26032#25919#38215'","'#35199#20805#21439'","'#26187#22478#38215'"]'
      '"0_22_5",["'#24191#23433#21306'","'#21326#34021#24066'","'#23731#27744#21439'","'#20061#40857#38215'","'#27494#32988#21439'","'#27839#21475#38215'","'#37051#27700#21439'","'#40718#23631#38215'"]'
      '"0_22_6",["'#33337#23665#21306'","'#23433#23621#21306'","'#34028#28330#21439'","'#36196#22478#38215'","'#23556#27946#21439'","'#22826#21644#38215'","'#22823#33521#21439'","'#34028#33713#38215'"]'
      '"0_22_7",["'#24066#20013#21306'","'#19996#20852#21306'","'#23041#36828#21439'","'#20005#38517#38215'","'#36164#20013#21439'","'#37325#40857#38215'","'#38534#26124#21439'","'#37329#40517#38215'"]'
      
        '"0_22_8",["'#24066#20013#21306'","'#27801#28286#21306'","'#20116#36890#26725#21306'","'#37329#21475#27827#21306'","'#23784#30473#23665#24066'","'#29325#20026#21439'","'#29577#27941#38215'","'#20117#30740#21439'","'#30740#22478 +
        #38215'","'#22841#27743#21439'","'#28473#22478#38215'","'#27792#24029#21439'","'#27792#28330#38215'","'#23784#36793#33258#27835#21439'","'#27801#22378#38215'","'#39532#36793#33258#27835#21439'","'#27665#24314#38215'"]'
      '"0_22_9",["'#33258#27969#20117#21306'","'#22823#23433#21306'","'#36129#20117#21306'","'#27839#28393#21306'","'#33635#21439'","'#26093#38451#38215'","'#23500#39034#21439'","'#23500#19990#38215'"]'
      
        '"0_22_10",["'#27743#38451#21306'","'#32435#28330#21306'","'#40857#39532#28525#21306'","'#27896#21439'","'#31119#38598#38215'","'#21512#27743#21439'","'#21512#27743#38215'","'#21465#27704#21439'","'#21465#27704#38215'"' +
        ',"'#21476#34106#21439'","'#21476#34106#38215'"]'
      
        '"0_22_11",["'#32736#23631#21306'","'#23452#23486#21439'","'#26575#28330#38215'","'#21335#28330#21439'","'#21335#28330#38215'","'#27743#23433#21439'","'#27743#23433#38215'","'#38271#23425#21439'","'#38271#23425#38215'"' +
        ',"'#39640#21439'","'#24198#31526#38215'","'#31584#36830#21439'","'#31584#36830#38215'","'#29657#21439'","'#24033#22330#38215'","'#20852#25991#21439'","'#20013#22478#38215'","'#23631#23665#21439'","'#23631#23665#38215'"]'
      '"0_22_12",["'#19996#21306'","'#35199#21306'","'#20161#21644#21306'","'#31859#26131#21439'","'#25856#33714#38215'","'#30416#36793#21439'","'#26704#23376#26519#38215'"]'
      '"0_22_13",["'#24052#24030#21306'","'#36890#27743#21439'","'#35834#27743#38215'","'#21335#27743#21439'","'#21335#27743#38215'","'#24179#26124#21439'","'#27743#21475#38215'"]'
      
        '"0_22_14",["'#36890#24029#21306'","'#19975#28304#24066'","'#36798#21439'","'#21335#22806#38215'","'#23459#27721#21439'","'#19996#20065#38215'","'#24320#27743#21439'","'#26032#23425#38215'","'#22823#31481#21439'",' +
        '"'#31481#38451#38215'","'#28192#21439'","'#28192#27743#38215'"]'
      '"0_22_15",["'#38593#27743#21306'","'#31616#38451#24066'","'#20048#33267#21439'","'#22825#27744#38215'","'#23433#23731#21439'","'#23731#38451#38215'"]'
      
        '"0_22_16",["'#19996#22369#21306'","'#20161#23551#21439'","'#25991#26519#38215'","'#24429#23665#21439'","'#20964#40483#38215'","'#27946#38597#21439'","'#27946#24029#38215'","'#20025#26865#21439'","'#20025#26865#38215'"' +
        ',"'#38738#31070#21439'","'#22478#21410#38215'"]'
      
        '"0_22_17",["'#38632#22478#21306'","'#21517#23665#21439'","'#33945#38451#38215'","'#33637#32463#21439'","'#20005#36947#38215'","'#27721#28304#21439'","'#23500#26519#38215'","'#30707#26825#21439'","'#26032#26825#38215'"' +
        ',"'#22825#20840#21439'","'#22478#21410#38215'","'#33446#23665#21439'","'#33446#38451#38215'","'#23453#20852#21439'","'#31302#22378#38215'"]'
      
        '"0_22_18",["'#39532#23572#24247#21439'","'#39532#23572#24247#38215'","'#27766#24029#21439'","'#23041#24030#38215'","'#29702#21439'","'#26434#35895#33041#38215'","'#33538#21439'","'#20964#20202#38215'","'#26494#28504#21439 +
        '","'#36827#23433#38215'","'#20061#23528#27807#21439'","'#27704#20048#38215'","'#37329#24029#21439'","'#37329#24029#38215'","'#23567#37329#21439'","'#32654#20852#38215'","'#40657#27700#21439'","'#33446#33457#38215'","'#22756#22616#21439'","' +
        #22756#26607#38215'","'#38463#22365#21439'","'#38463#22365#38215'","'#33509#23572#30422#21439'","'#36798#25166#23546#38215'","'#32418#21407#21439'","'#37019#28330#38215'"]'
      
        '"0_22_19",["'#24247#23450#21439'","'#28809#22478#38215'","'#27896#23450#21439'","'#27896#26725#38215'","'#20025#24052#21439'","'#31456#35895#38215'","'#20061#40857#21439'","'#21623#23572#38215'","'#38597#27743#21439'"' +
        ',"'#27827#21475#38215'","'#36947#23386#21439'","'#40092#27700#38215'","'#28809#38669#21439'","'#26032#37117#38215'","'#29976#23388#21439'","'#29976#23388#38215'","'#26032#40857#21439'","'#33593#40857#38215'","'#24503#26684#21439'","'#26356#24198 +
        #38215'","'#30333#29577#21439'","'#24314#35774#38215'","'#30707#28192#21439'","'#23612#21623#38215'","'#33394#36798#21439'","'#33394#26607#38215'","'#29702#22616#21439'","'#39640#22478#38215'","'#24052#22616#21439'","'#22799#37019#38215'","' +
        #20065#22478#21439'","'#26705#25259#38215'","'#31291#22478#21439'","'#37329#29664#38215'","'#24471#33635#21439'","'#26494#40614#38215'"]'
      
        '"0_22_20",["'#35199#26124#24066'","'#30416#28304#21439'","'#30416#20117#38215'","'#24503#26124#21439'","'#24503#24030#38215'","'#20250#29702#21439'","'#22478#20851#38215'","'#20250#19996#21439'","'#20250#19996#38215'"' +
        ',"'#23425#21335#21439'","'#25259#30722#38215'","'#26222#26684#21439'","'#26222#22522#38215'","'#24067#25302#21439'","'#29305#26408#37324#38215'","'#37329#38451#21439'","'#22825#22320#22365#38215'","'#26157#35273#21439'","'#26032#22478#38215'","' +
        #21916#24503#21439'","'#20809#26126#38215'","'#20885#23425#21439'","'#22478#21410#38215'","'#36234#35199#21439'","'#36234#22478#38215'","'#29976#27931#21439'","'#26032#24066#22365#38215'","'#32654#22993#21439'","'#24052#26222#38215'","'#38647#27874#21439 +
        '","'#38182#22478#38215'","'#26408#37324#33258#27835#21439'","'#20052#29926#38215'"]'
      
        '"0_22",["'#25104#37117#24066'","'#24191#20803#24066'","'#32501#38451#24066'","'#24503#38451#24066'","'#21335#20805#24066'","'#24191#23433#24066'","'#36930#23425#24066'","'#20869#27743#24066'","'#20048#23665#24066'","'#33258 +
        #36129#24066'","'#27896#24030#24066'","'#23452#23486#24066'","'#25856#26525#33457#24066'","'#24052#20013#24066'","'#36798#24030#24066'","'#36164#38451#24066'","'#30473#23665#24066'","'#38597#23433#24066'","'#38463#22365#24030'","'#29976#23388#24030'"' +
        ',"'#20937#23665#24030'"]'
      
        '"0_23_0",["'#20044#24403#21306'","'#21335#26126#21306'","'#20113#23721#21306'","'#33457#28330#21306'","'#30333#20113#21306'","'#23567#27827#21306'","'#28165#38215#24066'","'#24320#38451#21439'","'#22478#20851#38215'",' +
        '"'#20462#25991#21439'","'#40857#22330#38215'","'#24687#28925#21439'","'#27704#38742#38215'"]'
      '"0_23_1",["'#38047#23665#21306'","'#30424#21439'","'#32418#26524#38215'","'#20845#26525#29305#21306'","'#24179#23528#38215'","'#27700#22478#21439'"]'
      
        '"0_23_2",["'#32418#33457#23703#21306'","'#27719#24029#21306'","'#36196#27700#24066'","'#20161#24576#24066'","'#36981#20041#21439'","'#21335#30333#38215'","'#26704#26771#21439'","'#23044#23665#20851#38215'","'#32485#38451#21439 +
        '","'#27915#24029#38215'","'#27491#23433#21439'","'#20964#20202#38215'","'#20964#20872#21439'","'#40857#27849#38215'","'#28228#28525#21439'","'#28228#27743#38215'","'#20313#24198#21439'","'#30333#27877#38215'","'#20064#27700#21439'","'#19996 +
        #30343#38215'","'#36947#30495#33258#27835#21439'","'#29577#28330#38215'","'#21153#24029#33258#27835#21439'","'#37117#28641#38215'"]'
      
        '"0_23_3",["'#35199#31168#21306'","'#24179#22365#21439'","'#22478#20851#38215'","'#26222#23450#21439'","'#22478#20851#38215'","'#20851#23725#33258#27835#21439'","'#20851#32034#38215'","'#38215#23425#33258#27835#21439'","'#22478 +
        #20851#38215'","'#32043#20113#33258#27835#21439'","'#26494#23665#38215'"]'
      
        '"0_23_4",["'#27605#33410#24066'","'#22823#26041#21439'","'#22823#26041#38215'","'#40660#35199#21439'","'#22478#20851#38215'","'#37329#27801#21439'","'#22478#20851#38215'","'#32455#37329#21439'","'#22478#20851#38215'",' +
        '"'#32435#38605#21439'","'#38605#29081#38215'","'#36203#31456#21439'","'#22478#20851#38215'","'#23041#23425#33258#27835#21439'","'#33609#28023#38215'"]'
      
        '"0_23_5",["'#38108#20161#24066'","'#27743#21475#21439'","'#21452#27743#38215'","'#30707#38433#21439'","'#27748#23665#38215'","'#24605#21335#21439'","'#24605#21776#38215'","'#24503#27743#21439'","'#38738#40857#38215'",' +
        '"'#29577#23631#33258#27835#21439'","'#24179#28330#38215'","'#21360#27743#33258#27835#21439'","'#23784#23725#38215'","'#27839#27827#33258#27835#21439'","'#21644#24179#38215'","'#26494#26691#33258#27835#21439'","'#34044#30347#38215'","'#19975#23665#29305#21306'","' +
        #19975#23665#38215'"]'
      
        '"0_23_6",["'#20975#37324#24066'","'#40644#24179#21439'","'#26032#24030#38215'","'#26045#31177#21439'","'#22478#20851#38215'","'#19977#31319#21439'","'#20843#24339#38215'","'#38215#36828#21439'","'#38451#38215'","' +
        #23697#24041#21439'","'#24605#26104#38215'","'#22825#26609#21439'","'#20964#22478#38215'","'#38182#23631#21439'","'#19977#27743#38215'","'#21073#27827#21439'","'#38761#19996#38215'","'#21488#27743#21439'","'#21488#25329#38215'","'#40654#24179#21439'"' +
        ',"'#24503#20964#38215'","'#27029#27743#21439'","'#21476#24030#38215'","'#20174#27743#21439'","'#19993#22969#38215'","'#38647#23665#21439'","'#20025#27743#38215'","'#40635#27743#21439'","'#26447#23665#38215'","'#20025#23528#21439'","'#40857#27849 +
        #38215'"]'
      
        '"0_23_7",["'#37117#21248#24066'","'#31119#27849#24066'","'#33620#27874#21439'","'#29577#23631#38215'","'#36149#23450#21439'","'#22478#20851#38215'","'#29934#23433#21439'","'#38605#38451#38215'","'#29420#23665#21439'",' +
        '"'#22478#20851#38215'","'#24179#22616#21439'","'#24179#28246#38215'","'#32599#30008#21439'","'#40857#22378#38215'","'#38271#39034#21439'","'#38271#23528#38215'","'#40857#37324#21439'","'#40857#23665#38215'","'#24800#27700#21439'","'#21644#24179#38215 +
        '","'#19977#37117#33258#27835#21439'","'#19977#21512#38215'"]'
      
        '"0_23_8",["'#20852#20041#24066'","'#20852#20161#21439'","'#22478#20851#38215'","'#26222#23433#21439'","'#30424#27700#38215'","'#26228#38534#21439'","'#33714#22478#38215'","'#36126#20016#21439'","'#29641#35895#38215'",' +
        '"'#26395#35871#21439'","'#22797#20852#38215'","'#20876#20136#21439'","'#32773#27004#38215'","'#23433#40857#21439'","'#26032#23433#38215'","'#21073#27827#21439#19996#38215'"]'
      
        '"0_23",["'#36149#38451#24066'","'#20845#30424#27700#24066'","'#36981#20041#24066'","'#23433#39034#24066'","'#27605#33410#22320#21306'","'#38108#20161#22320#21306'","'#40660#19996#21335#24030'","'#40660#21335#24030'","'#40660#35199#21335 +
        #24030'"]'
      
        '"0_24_0",["'#30424#40857#21306'","'#20116#21326#21306'","'#23448#28193#21306'","'#35199#23665#21306'","'#19996#24029#21306'","'#23433#23425#24066'","'#21576#36129#21439'","'#40857#22478#38215'","'#26187#23425#21439'",' +
        '"'#26118#38451#38215'","'#23500#27665#21439'","'#27704#23450#38215'","'#23452#33391#21439'","'#21281#36828#38215'","'#23913#26126#21439'","'#23913#38451#38215'","'#30707#26519#33258#27835#21439'","'#40575#38428#38215'","'#31108#21149#33258#27835#21439'",' +
        '"'#23631#23665#38215'","'#23547#30008#33258#27835#21439'","'#20161#24503#38215'"]'
      
        '"0_24_1",["'#40594#40607#21306'","'#23459#23041#24066'","'#39532#40857#21439'","'#36890#27849#38215'","'#27838#30410#21439'","'#35199#24179#38215'","'#23500#28304#21439'","'#20013#23433#38215'","'#32599#24179#21439'",' +
        '"'#32599#38596#38215'","'#24072#23447#21439'","'#20025#20964#38215'","'#38470#33391#21439'","'#20013#26530#38215'","'#20250#27901#21439'","'#37329#38047#38215'"]'
      
        '"0_24_2",["'#32418#22612#21306'","'#27743#24029#21439'","'#22823#34903#38215'","'#28548#27743#21439'","'#20964#40595#38215'","'#36890#28023#21439'","'#31168#23665#38215'","'#21326#23425#21439'","'#23425#24030#38215'",' +
        '"'#26131#38376#21439'","'#40857#27849#38215'","'#23784#23665#33258#27835#21439'","'#21452#27743#38215'","'#26032#24179#33258#27835#21439'","'#26690#23665#38215'","'#20803#27743#33258#27835#21439'","'#28583#27743#38215'"]'
      '"0_24_3",["'#38534#38451#21306'","'#26045#30008#21439'","'#30008#38451#38215'","'#33150#20914#21439'","'#33150#36234#38215'","'#40857#38517#21439'","'#40857#23665#38215'","'#26124#23425#21439'","'#30000#22253#38215'"]'
      
        '"0_24_4",["'#26157#38451#21306'","'#40065#30008#21439'","'#25991#23631#38215'","'#24039#23478#21439'","'#26032#21326#38215'","'#30416#27941#21439'","'#30416#20117#38215'","'#22823#20851#21439'","'#32736#21326#38215'",' +
        '"'#27704#21892#21439'","'#28330#33853#28193#38215'","'#32485#27743#21439'","'#20013#22478#38215'","'#38215#38596#21439'","'#20044#23792#38215'","'#24413#33391#21439'","'#35282#22862#38215'","'#23041#20449#21439'","'#25166#35199#38215'","'#27700#23500 +
        #21439'","'#21521#23478#22365#38215'"]'
      
        '"0_24_5",["'#21476#22478#21306'","'#27704#32988#21439'","'#27704#21271#38215'","'#21326#22378#21439'","'#20013#24515#38215'","'#29577#40857#33258#27835#21439'","'#40644#23665#38215'","'#23425#33943#33258#27835#21439'","'#22823 +
        #20852#38215'"]'
      
        '"0_24_6",["'#32736#20113#21306'","'#26222#27953#33258#27835#21439'","'#23425#27953#38215'","'#22696#27743#33258#27835#21439'","'#32852#29664#38215'","'#26223#19996#33258#27835#21439'","'#38182#23631#38215'","'#26223#35895#33258#27835#21439 +
        '","'#23041#36828#38215'","'#38215#27781#33258#27835#21439'","'#24681#20048#38215'","'#27743#22478#33258#27835#21439'","'#21200#28872#38215'","'#23391#36830#33258#27835#21439'","'#23068#20801#38215'","'#28572#27815#33258#27835#21439'","'#21200#26391#38215'",' +
        '"'#35199#30431#33258#27835#21439'","'#21200#26797#38215'"]'
      
        '"0_24_7",["'#20020#32724#21306'","'#20964#24198#21439'","'#20964#23665#38215'","'#20113#21439'","'#29233#21326#38215'","'#27704#24503#21439'","'#24503#20826#38215'","'#38215#24247#21439'","'#21335#20254#38215'","' +
        #21452#27743#33258#27835#21439'","'#21200#21200#38215'","'#32831#39532#33258#27835#21439'","'#32831#39532#38215'","'#27815#28304#33258#27835#21439'","'#21200#33891#38215'"]'
      '"0_24_8",["'#28510#35199#24066'","'#29790#20029#24066'","'#26753#27827#21439'","'#36974#23707#38215'","'#30408#27743#21439'","'#24179#21407#38215'","'#38471#24029#21439'","'#31456#20964#38215'"]'
      '"0_24_9",["'#27896#27700#21439'","'#20845#24211#38215'","'#31119#36129#21439'","'#19978#24085#38215'","'#36129#23665#33258#27835#21439'","'#33576#24320#38215'","'#20848#22378#33258#27835#21439'","'#37329#39030#38215'"]'
      '"0_24_10",["'#39321#26684#37324#25289#21439'","'#24314#22616#38215'","'#24503#38054#21439'","'#21319#24179#38215'","'#32500#35199#33258#27835#21439'","'#20445#21644#38215'"]'
      
        '"0_24_11",["'#22823#29702#24066'","'#31077#20113#21439'","'#31077#22478#38215'","'#23486#24029#21439'","'#37329#29275#38215'","'#24357#28193#21439'","'#24357#22478#38215'","'#27704#24179#21439'","'#21338#21335#38215'"' +
        ',"'#20113#40857#21439'","'#35834#37011#38215'","'#27953#28304#21439'","'#33544#30887#28246#38215'","'#21073#24029#21439'","'#37329#21326#38215'","'#40548#24198#21439'","'#20113#40548#38215'","'#28478#28638#33258#27835#21439'","'#33485#23665#35199#38215'"' +
        ',"'#21335#28071#33258#27835#21439'","'#21335#28071#38215'","'#24013#23665#33258#27835#21439'","'#21335#35791#38215'"]'
      
        '"0_24_12",["'#26970#38596#24066'","'#21452#26575#21439'","'#22949#30008#38215'","'#29279#23450#21439'","'#20849#21644#38215'","'#21335#21326#21439'","'#40857#24029#38215'","'#23002#23433#21439'","'#26635#24029#38215'"' +
        ',"'#22823#23002#21439'","'#37329#30887#38215'","'#27704#20161#21439'","'#27704#23450#38215'","'#20803#35851#21439'","'#20803#39532#38215'","'#27494#23450#21439'","'#29422#23665#38215'","'#31108#20016#21439'","'#37329#23665#38215'"]'
      
        '"0_24_13",["'#33945#33258#21439'","'#25991#28572#38215'","'#20010#26087#24066'","'#24320#36828#24066'","'#32511#26149#21439'","'#22823#20852#38215'","'#24314#27700#21439'","'#20020#23433#38215'","'#30707#23631#21439'"' +
        ',"'#24322#40857#38215'","'#24357#21202#21439'","'#24357#38451#38215'","'#27896#35199#21439'","'#20013#26530#38215'","'#20803#38451#21439'","'#21335#27801#38215'","'#32418#27827#21439'","'#36836#33832#38215'","'#37329#24179#33258#27835#21439'","' +
        #37329#27827#38215'","'#27827#21475#33258#27835#21439'","'#27827#21475#38215'","'#23631#36793#33258#27835#21439'","'#29577#23631#38215'"]'
      
        '"0_24_14",["'#25991#23665#21439'","'#24320#21270#38215'","'#30746#23665#21439'","'#27743#37027#38215'","'#35199#30068#21439'","'#35199#27922#38215'","'#40635#26647#22369#21439'","'#40635#26647#38215'","'#39532#20851#21439 +
        '","'#39532#30333#38215'","'#19992#21271#21439'","'#38182#23631#38215'","'#24191#21335#21439'","'#33714#22478#38215'","'#23500#23425#21439'","'#26032#21326#38215'"]'
      '"0_24_15",["'#26223#27946#24066'","'#21200#28023#21439'","'#21200#28023#38215'","'#21200#33098#21439'","'#21200#33098#38215'"]'
      
        '"0_24",["'#26118#26126#24066'","'#26354#38742#24066'","'#29577#28330#24066'","'#20445#23665#24066'","'#26157#36890#24066'","'#20029#27743#24066'","'#24605#33541#24066'","'#20020#27815#24066'","'#24503#23439#24030'","'#24594 +
        #27743#24030'","'#36842#24198#24030'","'#22823#29702#24030'","'#26970#38596#24030'","'#32418#27827#24030'","'#25991#23665#24030'","'#35199#21452#29256#32435#24030'"]'
      
        '"0_25_0",["'#22478#20851#21306'","'#26519#21608#21439'","'#29976#20025#26354#26524#38215'","'#24403#38596#21439'","'#24403#26354#21345#38215'","'#23612#26408#21439'","'#22612#33635#38215'","'#26354#27700#21439'","'#26354#27700 +
        #38215'","'#22534#40857#24503#24198#21439'","'#19996#22030#38215'","'#36798#23388#21439'","'#24503#24198#38215'","'#22696#31481#24037#21345#21439'","'#24037#21345#38215'"]'
      
        '"0_25_1",["'#37027#26354#21439'","'#37027#26354#38215'","'#22025#40654#21439'","'#38463#25166#38215'","'#27604#22914#21439'","'#27604#22914#38215'","'#32834#33635#21439'","'#32834#33635#38215'","'#23433#22810#21439'",' +
        '"'#24085#37027#38215'","'#30003#25166#21439'","'#30003#25166#38215'","'#32034#21439'","'#20122#25289#38215'","'#29677#25096#21439'","'#26222#20445#38215'","'#24052#38738#21439'","'#25289#35199#38215'","'#23612#29595#21439'","'#23612#29595#38215'"' +
        ']'
      
        '"0_25_2",["'#26124#37117#21439'","'#22478#20851#38215'","'#27743#36798#21439'","'#27743#36798#38215'","'#36129#35273#21439'","'#33707#27931#38215'","'#31867#20044#40784#21439'","'#26705#22810#38215'","'#19969#38738#21439'"' +
        ',"'#19969#38738#38215'","'#23519#38597#21439'","'#28895#22810#38215'","'#20843#23487#21439'","'#30333#29595#38215'","'#24038#36129#21439'","'#26106#36798#38215'","'#33426#24247#21439'","'#22030#25176#38215'","'#27931#38534#21439'","'#23388#25176 +
        #38215'","'#36793#22365#21439'","'#33609#21345#38215'"]'
      
        '"0_25_3",["'#26519#33437#21439'","'#20843#19968#38215'","'#24037#24067#27743#36798#21439'","'#24037#24067#27743#36798#38215'","'#31859#26519#21439'","'#31859#26519#38215'","'#22696#33073#21439'","'#22696#33073#38215'","'#27874 +
        #23494#21439'","'#25166#26408#38215'","'#23519#38533#21439'","'#31481#29926#26681#38215'","'#26391#21439'","'#26391#38215'"]'
      
        '"0_25_4",["'#20035#19996#21439'","'#27901#24403#38215'","'#25166#22218#21439'","'#25166#22616#38215'","'#36129#22030#21439'","'#21513#38596#38215'","'#26705#26085#21439'","'#26705#26085#38215'","'#29756#32467#21439'",' +
        '"'#29756#32467#38215'","'#26354#26494#21439'","'#26354#26494#38215'","'#25514#32654#21439'","'#25514#32654#38215'","'#27931#25166#21439'","'#27931#25166#38215'","'#21152#26597#21439'","'#23433#32469#38215'","'#38534#23376#21439'","'#38534#23376#38215 +
        '","'#38169#37027#21439'","'#38169#37027#38215'","'#28010#21345#23376#21439'","'#28010#21345#23376#38215'"]'
      
        '"0_25_5",["'#26085#21888#21017#24066'","'#21335#26408#26519#21439'","'#21335#26408#26519#38215'","'#27743#23388#21439'","'#27743#23388#38215'","'#23450#26085#21439'","'#21327#26684#23572#38215'","'#33832#36838#21439'","'#33832 +
        #36838#38215'","'#25289#23388#21439'","'#26354#19979#38215'","'#26114#20161#21439'","'#21345#22030#38215'","'#35874#36890#38376#21439'","'#21345#22030#38215'","'#30333#26391#21439'","'#27931#27743#38215'","'#20161#24067#21439'","'#24503#21513#26519#38215 +
        '","'#24247#39532#21439'","'#24247#39532#38215'","'#23450#32467#21439'","'#27743#22030#38215'","'#20210#24052#21439'","'#25289#35753#20065'","'#20122#19996#21439'","'#19979#21496#39532#38215'","'#21513#38534#21439'","'#23447#22030#38215'","' +
        #32834#25289#26408#21439'","'#32834#25289#26408#38215'","'#33832#22030#21439'","'#21152#21152#38215'","'#23703#24052#21439'","'#23703#24052#38215'"]'
      
        '"0_25_6",["'#22134#23572#21439'","'#29422#27849#27827#38215'","'#26222#20848#21439'","'#26222#20848#38215'","'#26413#36798#21439'","'#25176#26519#38215'","'#26085#22303#21439'","'#26085#22303#38215'","'#38761#21513#21439'"' +
        ',"'#38761#21513#38215'","'#25913#21017#21439'","'#25913#21017#38215'","'#25514#21220#21439'","'#25514#21220#38215'","'#26519#33437#21439'"]'
      '"0_25",["'#25289#33832#24066'","'#37027#26354#22320#21306'","'#26124#37117#22320#21306'","'#26519#33437#22320#21306'","'#23665#21335#22320#21306'","'#26085#21888#21017#22320#21306'","'#38463#37324#22320#21306'"]'
      
        '"0_26_0",["'#33714#28246#21306'","'#26032#22478#21306'","'#30865#26519#21306'","'#28766#26725#21306'","'#26410#22830#21306'","'#38593#22612#21306'","'#38414#33391#21306'","'#20020#28540#21306'","'#38271#23433#21306'",' +
        '"'#34013#30000#21439'","'#34013#20851#38215'","'#21608#33267#21439'","'#20108#26354#38215'","'#25143#21439'","'#29976#20141#38215'","'#39640#38517#21439'","'#40575#33489#38215'"]'
      
        '"0_26_1",["'#23453#22612#21306'","'#24310#38271#21439'","'#19971#37324#26449#38215'","'#24310#24029#21439'","'#24310#24029#38215'","'#23376#38271#21439'","'#29926#31377#22561#38215'","'#23433#22622#21439'","'#30495#27494#27934 +
        #38215'","'#24535#20025#21439'","'#20445#23433#38215'","'#21556#36215#21439'","'#21556#26071#38215'","'#29976#27849#21439'","'#22478#20851#38215'","'#23500#21439'","'#23500#22478#38215'","'#27931#24029#21439'","'#20964#26646#38215'","'#23452 +
        #24029#21439'","'#20025#24030#38215'","'#40644#40857#21439'","'#30707#22561#38215'","'#40644#38517#21439'","'#26725#23665#38215'"]'
      '"0_26_2",["'#32768#24030#21306'","'#29579#30410#21306'","'#21360#21488#21306'","'#23452#21531#21439'","'#22478#20851#38215'"]'
      
        '"0_26_3",["'#20020#28205#21306'","'#21326#38452#24066'","'#38889#22478#24066'","'#21326#21439'","'#21326#24030#38215'","'#28540#20851#21439'","'#22478#20851#38215'","'#22823#33620#21439'","'#22478#20851#38215'","' +
        #33970#22478#21439'","'#22478#20851#38215'","'#28548#22478#21439'","'#22478#20851#38215'","'#30333#27700#21439'","'#22478#20851#38215'","'#21512#38451#21439'","'#22478#20851#38215'","'#23500#24179#21439'","'#31398#26449#38215'"]'
      
        '"0_26_4",["'#31206#37117#21306'","'#26472#38517#21306'","'#28205#22478#21306'","'#20852#24179#24066'","'#19977#21407#21439'","'#22478#20851#38215'","'#27902#38451#21439'","'#27902#24178#38215'","'#20094#21439'","' +
        #22478#20851#38215'","'#31036#27849#21439'","'#22478#20851#38215'","'#27704#23551#21439'","'#30417#20891#38215'","'#24428#21439'","'#22478#20851#38215'","'#38271#27494#21439'","'#26157#20161#38215'","'#26092#37009#21439'","'#22478#20851#38215'",' +
        '"'#28147#21270#21439'","'#22478#20851#38215'","'#27494#21151#21439'","'#26222#38598#38215'"]'
      
        '"0_26_5",["'#28205#28392#21306'","'#37329#21488#21306'","'#38472#20179#21306'","'#20964#32724#21439'","'#22478#20851#38215'","'#23696#23665#21439'","'#20964#40483#38215'","'#25206#39118#21439'","'#22478#20851#38215'",' +
        '"'#30473#21439'","'#39318#21892#38215'","'#38471#21439'","'#22478#20851#38215'","'#21315#38451#21439'","'#22478#20851#38215'","'#40607#28216#21439'","'#20061#25104#23467#38215'","'#20964#21439'","'#21452#30707#38138#38215'","'#22826#30333#21439'"' +
        ',"'#22068#22836#38215'"]'
      
        '"0_26_6",["'#27721#21488#21306'","'#21335#37073#21439'","'#22478#20851#38215'","'#22478#22266#21439'","'#21338#26395#38215'","'#27915#21439'","'#27915#24030#38215'","'#35199#20065#21439'","'#22478#20851#38215'","' +
        #21193#21439'","'#21193#38451#38215'","'#23425#24378#21439'","'#27721#28304#38215'","'#30053#38451#21439'","'#22478#20851#38215'","'#38215#24052#21439'","'#27902#27915#38215'","'#30041#22365#21439'","'#22478#20851#38215'","'#20315#22378#21439'",' +
        '"'#34945#23478#24196#38215'"]'
      
        '"0_26_7",["'#27014#38451#21306'","'#31070#26408#21439'","'#31070#26408#38215'","'#24220#35895#21439'","'#24220#35895#38215'","'#27178#23665#21439'","'#27178#23665#38215'","'#38742#36793#21439'","'#24352#23478#30036#38215'"' +
        ',"'#23450#36793#21439'","'#23450#36793#38215'","'#32485#24503#21439'","'#21517#24030#38215'","'#31859#33026#21439'","'#38134#24030#38215'","'#20339#21439'","'#20339#33446#38215'","'#21556#22561#21439'","'#23435#23478#24029#38215'","'#28165#28071 +
        #21439'","'#23485#27954#38215'","'#23376#27954#21439'","'#21452#28246#23786#38215'"]'
      
        '"0_26_8",["'#27721#28392#21306'","'#27721#38452#21439'","'#22478#20851#38215'","'#30707#27849#21439'","'#22478#20851#38215'","'#23425#38485#21439'","'#22478#20851#38215'","'#32043#38451#21439'","'#22478#20851#38215'",' +
        '"'#23706#30347#21439'","'#22478#20851#38215'","'#24179#21033#21439'","'#22478#20851#38215'","'#38215#22378#21439'","'#22478#20851#38215'","'#26092#38451#21439'","'#22478#20851#38215'","'#30333#27827#21439'","'#22478#20851#38215'"]'
      
        '"0_26_9",["'#21830#24030#21306'","'#27931#21335#21439'","'#22478#20851#38215'","'#20025#20964#21439'","'#40857#39545#23528#38215'","'#21830#21335#21439'","'#22478#20851#38215'","'#23665#38451#21439'","'#22478#20851#38215'"' +
        ',"'#38215#23433#21439'","'#27704#20048#38215'","'#26590#27700#21439'","'#20094#20305#38215'"]'
      
        '"0_26",["'#35199#23433#24066'","'#24310#23433#24066'","'#38108#24029#24066'","'#28205#21335#24066'","'#21688#38451#24066'","'#23453#40481#24066'","'#27721#20013#24066'","'#27014#26519#24066'","'#23433#24247#24066'","'#21830 +
        #27931#24066'"]'
      
        '"0_27_0",["'#22478#20851#21306'","'#19971#37324#27827#21306'","'#35199#22266#21306'","'#23433#23425#21306'","'#32418#21476#21306'","'#27704#30331#21439'","'#22478#20851#38215'","'#30347#20848#21439'","'#30707#27934#38215'"' +
        ',"'#27014#20013#21439'","'#22478#20851#38215'"]'
      '"0_27_1",["'#37329#26124#24066'","'#37329#24029#21306'","'#27704#26124#21439'","'#22478#20851#38215'"]'
      '"0_27_2",["'#30333#38134#21306'","'#24179#24029#21306'","'#38742#36828#21439'","'#20044#20848#38215'","'#20250#23425#21439'","'#20250#24072#38215'","'#26223#27888#21439'","'#19968#26465#23665#38215'"]'
      
        '"0_27_3",["'#31206#24030#21306'","'#40614#31215#21306'","'#28165#27700#21439'","'#27704#28165#38215'","'#31206#23433#21439'","'#20852#22269#38215'","'#29976#35895#21439'","'#22823#20687#23665#38215'","'#27494#23665#21439'"' +
        ',"'#22478#20851#38215'","'#24352#23478#24029#21439'","'#24352#23478#24029#38215'"]'
      '"0_27_4",["'#20937#24030#21306'","'#27665#21220#21439'","'#22478#20851#38215'","'#21476#28010#21439'","'#21476#28010#38215'","'#22825#31069#33258#27835#21439'","'#21326#34255#23546#38215'"]'
      
        '"0_27_5",["'#32899#24030#21306'","'#29577#38376#24066'","'#25958#29004#24066'","'#37329#22612#21439'","'#37329#22612#38215'","'#23433#35199#21439'","'#28170#27849#38215'","'#32899#21271#33258#27835#21439'","'#20826#22478#28286 +
        #38215'","'#38463#20811#33258#27835#21439'","'#32418#26611#28286#38215'"]'
      
        '"0_27_6",["'#29976#24030#21306'","'#27665#20048#21439'","'#27946#27700#38215'","'#20020#27901#21439'","'#27801#27827#38215'","'#39640#21488#21439'","'#22478#20851#38215'","'#23665#20025#21439'","'#28165#27849#38215'",' +
        '"'#32899#21335#33258#27835#21439'","'#32418#28286#23546#38215'"]'
      
        '"0_27_7",["'#35199#23792#21306'","'#24198#22478#21439'","'#24198#22478#38215'","'#29615#21439'","'#29615#22478#38215'","'#21326#27744#21439'","'#26580#36828#38215'","'#21512#27700#21439'","'#35199#21326#27744#38215'",' +
        '"'#27491#23425#21439'","'#23665#27827#38215'","'#23425#21439'","'#26032#23425#38215'","'#38215#21407#21439'","'#22478#20851#38215'"]'
      
        '"0_27_8",["'#23814#23762#21306'","'#27902#24029#21439'","'#22478#20851#38215'","'#28789#21488#21439'","'#20013#21488#38215'","'#23815#20449#21439'","'#38182#23631#38215'","'#21326#20141#21439'","'#19996#21326#38215'",' +
        '"'#24196#28010#21439'","'#27700#27931#38215'","'#38745#23425#21439'","'#22478#20851#38215'"]'
      
        '"0_27_9",["'#23433#23450#21306'","'#36890#28205#21439'","'#24179#35140#38215'","'#20020#27950#21439'","'#27950#38451#38215'","'#28467#21439'","'#27494#38451#38215'","'#23735#21439'","'#23735#38451#38215'","'#28205 +
        #28304#21439'","'#28165#28304#38215'","'#38471#35199#21439'","'#24041#26124#38215'"]'
      
        '"0_27_10",["'#27494#37117#21306'","'#25104#21439'","'#22478#20851#38215'","'#23445#26124#21439'","'#22478#20851#38215'","'#24247#21439'","'#25991#21439'","'#22478#20851#38215'","'#35199#21644#21439'","'#27721 +
        #28304#38215'","'#31036#21439'","'#22478#20851#38215'","'#20004#24403#21439'","'#22478#20851#38215'","'#24509#21439'","'#22478#20851#38215'"]'
      
        '"0_27_11",["'#20020#22799#24066'","'#20020#22799#21439'","'#38889#38598#38215'","'#24247#20048#21439'","'#38468#22478#38215'","'#27704#38742#21439'","'#21016#23478#23777#38215'","'#24191#27827#21439'","'#22478#20851#38215 +
        '","'#21644#25919#21439'","'#22478#20851#38215'","'#19996#20065#33258#27835#21439'","'#38145#21335#22365#38215'","'#31215#30707#33258#27835#21439'","'#21561#40635#28393#38215'"]'
      
        '"0_27_12",["'#21512#20316#24066'","'#20020#28525#21439'","'#22478#20851#38215'","'#21331#23612#21439'","'#26611#26519#38215'","'#33311#26354#21439'","'#22478#20851#38215'","'#36845#37096#21439'","'#30005#23573#38215'"' +
        ',"'#29595#26354#21439'","'#23612#29595#38215'","'#30860#26354#21439'","'#29595#33406#38215'","'#22799#27827#21439'","'#25289#21340#26974#38215'"]'
      
        '"0_27",["'#20848#24030#24066'","'#22025#23786#20851#24066'","'#30333#38134#24066'","'#22825#27700#24066'","'#27494#23041#24066'","'#37202#27849#24066'","'#24352#25494#24066'","'#24198#38451#24066'","'#24179#20937#24066'","' +
        #23450#35199#24066'","'#38471#21335#24066'","'#20020#22799#24030'","'#29976#21335#24030'"]'
      
        '"0_28_0",["'#22478#20013#21306'","'#22478#19996#21306'","'#22478#35199#21306'","'#22478#21271#21306'","'#22823#36890#33258#27835#21439'","'#26725#22836#38215'","'#28255#28304#21439'","'#22478#20851#38215'","'#28255#20013#21439 +
        '","'#40065#27801#23572#38215'"]'
      
        '"0_28_1",["'#24179#23433#21439'","'#24179#23433#38215'","'#20048#37117#21439'","'#30910#20271#38215'","'#27665#21644#33258#27835#21439'","'#24029#21475#38215'","'#20114#21161#33258#27835#21439'","'#23041#36828#38215'","'#21270 +
        #38534#33258#27835#21439'","'#24052#29141#38215'","'#24490#21270#33258#27835#21439'","'#31215#30707#38215'"]'
      '"0_28_2",["'#28023#26191#21439'","'#19977#35282#22478#38215'","'#31041#36830#21439'","'#20843#23453#38215'","'#21018#23519#21439'","'#27801#26611#27827#38215'","'#38376#28304#33258#27835#21439'","'#28009#38376#38215'"]'
      
        '"0_28_3",["'#20849#21644#21439'","'#24688#21340#24688#38215'","'#21516#24503#21439'","'#23573#24052#26494#22810#38215'","'#36149#24503#21439'","'#27827#38452#38215'","'#20852#28023#21439'","'#23376#31185#28393#38215'","'#36149 +
        #21335#21439'","'#33579#26354#38215'"]'
      '"0_28_4",["'#21516#20161#21439'","'#38534#21153#38215'","'#23574#25166#21439'","'#39532#20811#21776#38215'","'#27901#24211#21439'","'#27901#26354#38215'","'#33945#21476#33258#27835#21439'","'#20248#24178#23425#38215'"]'
      
        '"0_28_5",["'#29595#27777#21439'","'#22823#27494#38215'","'#29677#29595#21439'","'#36187#26469#22616#38215'","'#29976#24503#21439'","'#26607#26354#38215'","'#36798#26085#21439'","'#21513#36808#38215'","'#20037#27835#21439'"' +
        ',"'#26234#38738#26494#22810#38215'","'#29595#22810#21439'","'#40644#27827#20065'"]'
      
        '"0_28_6",["'#29577#26641#21439'","'#32467#21476#38215'","'#26434#22810#21439'","'#33832#21628#33150#38215'","'#31216#22810#21439'","'#31216#25991#38215'","'#27835#22810#21439'","'#21152#21513#21338#27931#38215'","'#22218#35878 +
        #21439'","'#39321#36798#38215'","'#26354#40635#33713#21439'","'#32422#25913#38215'"]'
      '"0_28_7",["'#24503#20196#21704#24066'","'#26684#23572#26408#24066'","'#20044#20848#21439'","'#24076#37324#27807#38215'","'#37117#20848#21439'","'#23519#27735#20044#33487#38215'","'#22825#23803#21439'","'#26032#28304#38215'"]'
      '"0_28",["'#35199#23425#24066'","'#28023#19996#22320#21306'","'#28023#21271#24030'","'#28023#21335#24030'","'#40644#21335#24030'","'#26524#27931#24030'","'#29577#26641#24030'","'#28023#35199#24030'"]'
      '"0_29_0",["'#20852#24198#21306'","'#37329#20964#21306'","'#35199#22799#21306'","'#28789#27494#24066'","'#27704#23425#21439'","'#26472#21644#38215'","'#36154#20848#21439'","'#20064#23703#38215'"]'
      '"0_29_1",["'#22823#27494#21475#21306'","'#24800#20892#21306'","'#24179#32599#21439'","'#22478#20851#38215'"]'
      '"0_29_2",["'#21033#36890#21306'","'#38738#38108#23777#24066'","'#30416#27744#21439'","'#33457#39532#27744#38215'","'#21516#24515#21439'","'#35947#28023#38215'"]'
      '"0_29_3",["'#21407#24030#21306'","'#35199#21513#21439'","'#21513#24378#38215'","'#38534#24503#21439'","'#22478#20851#38215'","'#27902#28304#21439'","'#39321#27700#38215'","'#24429#38451#21439'","'#30333#38451#38215'"]'
      '"0_29_4",["'#27801#22369#22836#21306'","'#20013#23425#21439'","'#28023#21407#21439'"]'
      '"0_29",["'#38134#24029#24066'","'#30707#22068#23665#24066'","'#21556#24544#24066'","'#22266#21407#24066'","'#20013#21355#24066'"]'
      
        '"0_30_0",["'#22825#23665#21306'","'#27801#20381#24052#20811#21306'","'#26032#24066#21306'","'#27700#30952#27807#21306'","'#22836#23663#27827#21306'","'#36798#22338#22478#21306'","'#19996#23665#21306'","'#20044#40065#26408#40784#21439'"' +
        ',"'#20044#40065#30952#27807#21306'"]'
      '"0_30_1",["'#20811#25289#29595#20381#21306'","'#29420#23665#23376#21306'","'#30333#30897#28393#21306'","'#20044#23572#31166#21306'"]'
      '"0_30_2",["'#30707#27827#23376#24066'","'#38463#25289#23572#24066'","'#22270#26408#33298#20811#24066'","'#20116#23478#28192#24066'"]'
      
        '"0_30_3",["'#21888#20160#24066'","'#30095#38468#21439'","'#25176#20811#25166#20811#38215'","'#30095#21202#21439'","'#30095#21202#38215'","'#33521#21513#27801#21439'","'#33521#21513#27801#38215'","'#27901#26222#21439'","'#27901 +
        #26222#38215'","'#33678#36710#21439'","'#33678#36710#38215'","'#21494#22478#21439'","'#21888#26684#21202#20811#38215'","'#40614#30422#25552#21439'","'#40614#30422#25552#38215'","'#23731#26222#28246#21439'","'#23731#26222#28246#38215'","'#20285#24072#21439'",' +
        '"'#24052#20161#38215'","'#24052#26970#21439'","'#24052#26970#38215'","'#22612#20160#33258#27835#21439'","'#22612#20160#24178#38215'"]'
      
        '"0_30_4",["'#38463#20811#33487#24066'","'#28201#23487#21439'","'#28201#23487#38215'","'#24211#36710#21439'","'#24211#36710#38215'","'#27801#38597#21439'","'#27801#38597#38215'","'#26032#21644#21439'","'#26032#21644#38215'"' +
        ',"'#25308#22478#21439'","'#25308#22478#38215'","'#20044#20160#21439'","'#20044#20160#38215'","'#38463#29926#25552#21439'","'#38463#29926#25552#38215'","'#26607#22378#21439'","'#26607#22378#38215'"]'
      
        '"0_30_5",["'#21644#30000#24066'","'#21644#30000#21439'","'#22696#29577#21439'","'#21888#25289#21888#20160#38215'","'#30382#23665#21439'","'#22266#29595#38215'","'#27931#28006#21439'","'#27931#28006#38215'","'#31574#21202#21439 +
        '","'#31574#21202#38215'","'#20110#30000#21439'","'#26408#23573#25289#38215'","'#27665#20016#21439'","'#23612#38597#38215'"]'
      '"0_30_6",["'#21520#40065#30058#24066'","'#37167#21892#21439'","'#37167#21892#38215'","'#25176#20811#36874#21439'","'#25176#20811#36874#38215'"]'
      '"0_30_7",["'#21704#23494#24066'","'#20234#21566#21439'","'#20234#21566#38215'","'#24052#37324#22372#33258#27835#21439'","'#24052#37324#22372#38215'"]'
      '"0_30_8",["'#38463#22270#20160#24066'","'#38463#20811#38518#21439'","'#38463#20811#38518#38215'","'#38463#21512#22855#21439'","'#38463#21512#22855#38215'","'#20044#24688#21439'","'#20044#24688#38215'"]'
      '"0_30_9",["'#21338#20048#24066'","'#31934#27827#21439'","'#31934#27827#38215'","'#28201#27849#21439'","'#21338#26684#36798#23572#38215'"]'
      
        '"0_30_10",["'#26124#21513#24066'","'#38428#24247#24066'","'#31859#27849#24066'","'#21628#22270#22721#21439'","'#21628#22270#22721#38215'","'#29595#32435#26031#21439'","'#29595#32435#26031#38215'","'#22855#21488#21439'","' +
        #22855#21488#38215'","'#21513#26408#33832#23572#21439'","'#21513#26408#33832#23572#38215'","'#26408#22418#33258#27835#21439'","'#26408#22418#38215'"]'
      
        '"0_30_11",["'#24211#23572#21202#24066'","'#36718#21488#21439'","'#36718#21488#38215'","'#23561#29313#21439'","'#23561#29313#38215'","'#33509#32652#21439'","'#33509#32652#38215'","'#19988#26411#21439'","'#19988#26411#38215 +
        '","'#21644#38745#21439'","'#21644#38745#38215'","'#21644#30805#21439'","'#29305#21566#37324#20811#38215'","'#21338#28246#21439'","'#21338#28246#38215'","'#28937#32774#33258#27835#21439'","'#28937#32774#38215'"]'
      
        '"0_30_12",["'#20234#23425#24066'","'#22862#23663#24066'","'#20234#23425#21439'","'#21513#37324#20110#23388#38215'","'#38669#22478#21439'","'#27700#23450#38215'","'#24041#30041#21439'","'#24041#30041#38215'","'#26032#28304 +
        #21439'","'#26032#28304#38215'","'#26157#33487#21439'","'#26157#33487#38215'","'#29305#20811#26031#21439'","'#29305#20811#26031#38215'","'#23612#21202#20811#21439'","'#23612#21202#20811#38215'","'#23519#24067#33258#27835#21439'","'#23519#24067#38215'"]'
      
        '"0_30_13",["'#22612#22478#24066'","'#20044#33487#24066'","'#39069#25935#21439'","'#39069#25935#38215'","'#27801#28286#21439'","'#19977#36947#27827#23376#38215'","'#25176#37324#21439'","'#25176#37324#38215'","'#35029#27665 +
        #21439'","'#21704#25289#24067#25289#38215'","'#21644#24067#33258#27835#21439'","'#21644#24067#38215'"]'
      
        '"0_30_14",["'#38463#21202#27888#24066'","'#24067#23572#27941#21439'","'#24067#23572#27941#38215'","'#23500#34164#21439'","'#24211#39069#23572#40784#26031'","'#31119#28023#21439'","'#21704#24052#27827#21439'","'#38738#27827#21439'"' +
        ',"'#21513#26408#20035#21439'"]'
      
        '"0_30",["'#20044#40065#26408#40784#24066'","'#20811#25289#29595#20381#24066'","'#33258#27835#21306'","'#21888#20160#22320#21306'","'#38463#20811#33487#22320#21306'","'#21644#30000#22320#21306'","'#21520#40065#30058#22320#21306'","'#21704#23494#22320 +
        #21306'","'#20811#23388#21202'","'#21338#23572#22612#25289#24030'","'#26124#21513#24030'","'#24052#38899#37101#26974#24030'","'#20234#29313#24030'","'#22612#22478#22320#21306'","'#38463#21202#27888#22320#21306'"]'
      
        '"0_31_0",["'#20013#35199#21306'","'#19996#21306'","'#20061#40857#22478#21306'","'#35266#22616#21306'","'#21335#21306'","'#28145#27700#22487#21306'","'#28286#20180#21306'","'#40644#22823#20185#21306'","'#27833#23574#26106#21306 +
        '","'#31163#23707#21306'","'#33909#38738#21306'","'#21271#21306'","'#35199#36129#21306'","'#27801#30000#21306'","'#23663#38376#21306'","'#22823#22484#21306'","'#33603#28286#21306'","'#20803#26391#21306'"]'
      '"0_31",["'#39321#28207#34892#25919#21306'"]'
      '"0_32_0",["'#28595#38376#34892#25919#21306'"]'
      '"0_32",["'#28595#38376#34892#25919#21306'"]'
      
        '"0_33",["'#21488#21271'","'#39640#38596'","'#21488#20013'","'#33457#33714'","'#22522#38534'","'#22025#20041'","'#37329#38376'","'#36830#27743'","'#33495#26647'","'#21335#25237'","'#28558#28246'","' +
        #23631#19996'","'#21488#19996'","'#21488#21335'","'#26691#22253'","'#26032#31481'","'#23452#20848'","'#20113#26519'","'#24432#21270'"]')
    ItemIndex = -1
  end
  object DStateInfoProvince: TDComboBox
    Left = 515
    Top = 293
    Width = 25
    Height = 17
    DFColor = 14605278
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    boTransparent = True
    ShowCount = 8
    ShowHeight = 18
    Item.Strings = (
      #12288
      #21271#20140#24066
      #22825#27941#24066
      #19978#28023#24066
      #37325#24198#24066
      #27827#21271#30465
      #23665#35199#30465
      #20869#33945#21476
      #36797#23425#30465
      #21513#26519#30465
      #40657#40857#27743#30465
      #27743#33487#30465
      #27993#27743#30465
      #23433#24509#30465
      #31119#24314#30465
      #27743#35199#30465
      #23665#19996#10#30465
      #27827#21335#30465
      #28246#21271#30465
      #28246#21335#30465
      #24191#19996#30465
      #24191#35199
      #28023#21335#30465
      #22235#24029#30465
      #36149#24030#10#30465
      #20113#21335#30465
      #35199#34255
      #38485#35199#30465
      #29976#32899#30465
      #38738#28023#30465
      #23425#22799
      #26032#30086
      #39321#28207
      #28595#10#38376
      #21488#28286#30465)
    ItemIndex = -1
  end
  object DStateInfoSex: TDComboBox
    Left = 501
    Top = 328
    Width = 25
    Height = 18
    DFColor = 14605278
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    boTransparent = True
    ShowCount = 5
    ShowHeight = 18
    Item.Strings = (
      #30007
      #22899)
    ItemIndex = -1
  end
  object DUserStateItem: TDWindow
    Left = 362
    Top = 477
    Width = 122
    Height = 132
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateItemDirectPaint
    OnMouseMove = DUserStateItemMouseMove
    OnClick = DUserStateItemClick
    Caption = #20154#29289#35013#22791
    DParent = DUserState
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DWeaponUS1: TDButton
    Tag = 1
    Left = 368
    Top = 475
    Width = 28
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #27494#22120
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DDressUS1: TDButton
    Left = 367
    Top = 499
    Width = 29
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #34915#26381
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DArmringRUS1: TDButton
    Tag = 6
    Left = 368
    Top = 522
    Width = 29
    Height = 19
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #25163#38255#21491
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DRingRUS1: TDButton
    Tag = 8
    Left = 368
    Top = 547
    Width = 29
    Height = 23
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #25106#25351#21491
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DBeltUS1: TDButton
    Tag = 10
    Left = 368
    Top = 576
    Width = 28
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #33136#24102
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DCharmUS1: TDButton
    Tag = 12
    Left = 403
    Top = 552
    Width = 36
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #23453#30707
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DBujukUS1: TDButton
    Tag = 9
    Left = 402
    Top = 576
    Width = 37
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #25252#36523#31526
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHouseUS1: TDButton
    Tag = 13
    Left = 445
    Top = 578
    Width = 39
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #22352#39569
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DCowryUS1: TDButton
    Tag = 14
    Left = 403
    Top = 524
    Width = 39
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #23453#29289
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DBootsUS1: TDButton
    Tag = 11
    Left = 402
    Top = 476
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #38772#23376
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DRingLUS1: TDButton
    Tag = 7
    Left = 445
    Top = 556
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #25106#25351#24038
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DArmringLUS1: TDButton
    Tag = 5
    Left = 448
    Top = 535
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #25163#38255#24038
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DLightUS1: TDButton
    Tag = 4
    Left = 445
    Top = 515
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #21195#31456
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DNecklaceUS1: TDButton
    Tag = 3
    Left = 447
    Top = 496
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #39033#38142
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHelmetUS1: TDButton
    Tag = 2
    Left = 442
    Top = 476
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = #22836#30420
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUserStateInfo: TDWindow
    Left = 490
    Top = 477
    Width = 102
    Height = 132
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateItemDirectPaint
    Caption = #26597#30475#20154#29289#20449#24687#31383#21475
    DParent = DUserState
    Visible = False
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DUserStateInfoName: TDEdit
    Left = 487
    Top = 493
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deStandard
    FrameColor = clBlack
    MaxLength = 8
    boTransparent = True
  end
  object DUserStateInfoAge: TDEdit
    Left = 487
    Top = 516
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deInteger
    FrameColor = clBlack
    MaxLength = 2
    boTransparent = True
  end
  object DUserStateInfoMemo: TDMemo
    Left = 515
    Top = 552
    Width = 33
    Height = 17
    DFColor = 11913116
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Memo'
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = 8
    boTransparent = True
    MaxLength = 120
  end
  object DUserStateInfoRefPic: TDButton
    Left = 490
    Top = 583
    Width = 46
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateInfoRefPicClick
    Caption = #21047#26032#29031#29255
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DUserStateInforeport: TDButton
    Left = 541
    Top = 583
    Width = 51
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #20030#25253#29031#29255
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DUserStateInfoFriend: TDCheckBox
    Left = 487
    Top = 562
    Width = 48
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #20165#22909#21451#21487#35265
    DParent = DUserStateInfo
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 1
    OffsetTop = 1
  end
  object DUserStateInfoMidNight: TDCheckBox
    Left = 549
    Top = 552
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #21320#22812
    DParent = DUserStateInfo
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DUserStateInfoNight: TDCheckBox
    Left = 549
    Top = 534
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #26202#19978
    DParent = DUserStateInfo
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DUserStateInfoPM: TDCheckBox
    Left = 548
    Top = 516
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #19979#21320
    DParent = DUserStateInfo
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DUserStateInfoAM: TDCheckBox
    Left = 548
    Top = 498
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #19978#21320
    DParent = DUserStateInfo
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DUserStateBTItem: TDButton
    Left = 658
    Top = 477
    Width = 31
    Height = 15
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateBTInfoDirectPaint
    OnClick = DUserStateBTItemClick
    Caption = #35013' '#22791
    DParent = DUserState
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DUserStateBTInfo: TDButton
    Tag = 3
    Left = 599
    Top = 477
    Width = 53
    Height = 15
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateBTInfoDirectPaint
    OnClick = DUserStateBTItemClick
    Caption = #20010#20154#20449#24687
    DParent = DUserState
    Visible = False
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DUserStateInfoSex: TDEdit
    Left = 487
    Top = 535
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 2
    boTransparent = True
  end
  object DUserStateInfoArea: TDEdit
    Left = 517
    Top = 539
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 10
    boTransparent = True
  end
  object DUserStateInfoProvince: TDEdit
    Left = 517
    Top = 493
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 10
    boTransparent = True
  end
  object DUserStateInfoCity: TDEdit
    Left = 517
    Top = 516
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 10
    boTransparent = True
  end
  object DItemAddBag1: TDButton
    Left = 525
    Top = 185
    Width = 34
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemAddBag1DirectPaint
    OnMouseMove = DItemAddBag1MouseMove
    OnMouseUp = DItemAddBag1MouseUp
    Caption = #32972#21253'1'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DItemAddBag2: TDButton
    Tag = 1
    Left = 565
    Top = 185
    Width = 34
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemAddBag1DirectPaint
    OnMouseMove = DItemAddBag1MouseMove
    OnMouseUp = DItemAddBag1MouseUp
    Caption = #32972#21253'2'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DItemAddBag3: TDButton
    Tag = 2
    Left = 603
    Top = 185
    Width = 34
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemAddBag1DirectPaint
    OnMouseMove = DItemAddBag1MouseMove
    OnMouseUp = DItemAddBag1MouseUp
    Caption = #32972#21253'3'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DItemAppendBag1: TDWindow
    Tag = 1
    Left = 525
    Top = 134
    Width = 53
    Height = 37
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemBagDirectPaint
    OnMouseDown = DItemBagMouseDown
    Caption = #39069#22806#32972#21253'1'
    DParent = DItemBag
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DItemAppendBag2: TDWindow
    Tag = 2
    Left = 584
    Top = 134
    Width = 53
    Height = 37
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemBagDirectPaint
    OnMouseDown = DItemBagMouseDown
    Caption = #39069#22806#32972#21253'2'
    DParent = DItemBag
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DItemAppendBag3: TDWindow
    Tag = 3
    Left = 643
    Top = 134
    Width = 53
    Height = 37
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemBagDirectPaint
    OnMouseDown = DItemBagMouseDown
    Caption = #39069#22806#32972#21253'3'
    DParent = DItemBag
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DItemGrid1: TDGrid
    Tag = 1
    Left = 525
    Top = 134
    Width = 40
    Height = 29
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DItemGridDblClick
    Caption = #32972#21253#34920#26684
    DParent = DItemAppendBag1
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 5
    RowCount = 2
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DItemGridGridSelect
    OnGridMouseMove = DItemGridGridMouseMove
    OnGridPaint = DItemGridGridPaint
  end
  object DItemGrid2: TDGrid
    Tag = 2
    Left = 584
    Top = 134
    Width = 40
    Height = 29
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DItemGridDblClick
    Caption = #32972#21253#34920#26684
    DParent = DItemAppendBag2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 5
    RowCount = 2
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DItemGridGridSelect
    OnGridMouseMove = DItemGridGridMouseMove
    OnGridPaint = DItemGridGridPaint
  end
  object DItemGrid3: TDGrid
    Tag = 3
    Left = 643
    Top = 134
    Width = 40
    Height = 29
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DItemGridDblClick
    Caption = #32972#21253#34920#26684
    DParent = DItemAppendBag3
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 5
    RowCount = 2
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DItemGridGridSelect
    OnGridMouseMove = DItemGridGridMouseMove
    OnGridPaint = DItemGridGridPaint
  end
  object DItemBagRef: TDButton
    Left = 622
    Top = 216
    Width = 29
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemBagRefDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DItemBagRefClick
    Caption = #21047#26032#21253#35065
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DItemBagShop: TDButton
    Left = 587
    Top = 216
    Width = 29
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DItemBagShopClick
    Caption = #25171#24320#25670#25674#30028#38754
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTTakeHorse: TDButton
    Left = 827
    Top = 94
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTTakeHorseDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTTakeHorseClick
    Caption = #39569#39532
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackMode: TDButton
    Left = 291
    Top = 494
    Width = 61
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTAttackModeDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeClick
    Caption = #25915#20987#27169#24335
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DWndAttackModeList: TDWindow
    Left = 8
    Top = 493
    Width = 277
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWndAttackModeListDirectPaint
    Caption = #25915#20987#27169#24335#21015#34920#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsTop
  end
  object DBTAttackModeAll: TDButton
    Left = 8
    Top = 493
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTAttackModeDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = #20840#20307#25915#20987
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModePeace: TDButton
    Tag = 1
    Left = 64
    Top = 495
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTAttackModeDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = #21644#24179#25915#20987
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModeDear: TDButton
    Tag = 2
    Left = 120
    Top = 494
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTAttackModeDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = #22827#22971#25915#20987
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModeMaster: TDButton
    Tag = 3
    Left = 176
    Top = 494
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTAttackModeDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = #24072#24466#25915#20987
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModeGroup: TDButton
    Tag = 4
    Left = 232
    Top = 494
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTAttackModeDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = #38431#20237#25915#20987
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModeGuild: TDButton
    Tag = 5
    Left = 22
    Top = 450
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTAttackModeDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = #34892#20250#25915#20987
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModePK: TDButton
    Tag = 6
    Left = 92
    Top = 452
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTAttackModeDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = #32418#21517#25915#20987
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuShop: TDButton
    Left = 859
    Top = 13
    Width = 49
    Height = 17
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMenuShopDirectPaint
    OnClick = DMenuShopClick
    WheelDControl = DMenuUpDonw
    Caption = #21830#24215
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
  end
  object DMenuReturn: TDButton
    Tag = 1
    Left = 914
    Top = 8
    Width = 49
    Height = 17
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMenuShopDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DMenuShopClick
    WheelDControl = DMenuUpDonw
    Caption = #22238#36141
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
  end
  object DMenuRepairAll: TDButton
    Left = 909
    Top = 104
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = #20840#20462#29702
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuSuperRepairAll: TDButton
    Left = 956
    Top = 106
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = #20840#29305#20462
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuRepair: TDButton
    Left = 909
    Top = 77
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = #20462#29702
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuSuperRepair: TDButton
    Left = 956
    Top = 79
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = #29305#20462
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuBuy: TDButton
    Left = 862
    Top = 77
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = #20080#36827
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuSell: TDButton
    Left = 862
    Top = 104
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = #21334#20986
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuClose: TDButton
    Left = 969
    Top = 8
    Width = 24
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    WheelDControl = DMenuUpDonw
    Caption = #20851#38381
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuGrid: TDGrid
    Tag = 1
    Left = 859
    Top = 31
    Width = 64
    Height = 40
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    WheelDControl = DMenuUpDonw
    Caption = #29289#21697#34920#26684
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 5
    RowCount = 6
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DMenuGridGridSelect
    OnGridMouseMove = DMenuGridGridMouseMove
    OnGridPaint = DMenuGridGridPaint
  end
  object DMagicFront: TDButton
    Left = 358
    Top = 426
    Width = 44
    Height = 17
    DFColor = 11922415
    DFEnabledColor = clWhite
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMagicFrontDirectPaint
    OnClick = DMagicFrontClick
    Caption = #19978#19968#39029
    DParent = DStateWinMagic
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMagicNext: TDButton
    Left = 405
    Top = 426
    Width = 38
    Height = 17
    DFColor = 11922415
    DFEnabledColor = clWhite
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMagicFrontDirectPaint
    OnClick = DMagicFrontClick
    Caption = #19979#19968#39029
    DParent = DStateWinMagic
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DUserKeyGrid1: TDGrid
    Left = 8
    Top = 414
    Width = 98
    Height = 30
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DUserKeyGrid2DblClick
    Caption = #24555#25463#38190#34920#26684#19968
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 12
    RowCount = 1
    ColWidth = 38
    RowHeight = 38
    Coloffset = 4
    Rowoffset = 0
    ViewTopLine = 0
    OnGridSelect = DUserKeyGrid1GridSelect
    OnGridMouseMove = DUserKeyGrid1GridMouseMove
    OnGridPaint = DUserKeyGrid1GridPaint
  end
  object DUserKeyGrid2: TDGrid
    Tag = 1
    Left = 253
    Top = 445
    Width = 98
    Height = 30
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DUserKeyGrid2DblClick
    Caption = #24555#25463#38190#34920#26684#20108
    DParent = DBottom2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 8
    RowCount = 1
    ColWidth = 38
    RowHeight = 38
    Coloffset = 4
    Rowoffset = 0
    ViewTopLine = 0
    OnGridSelect = DUserKeyGrid1GridSelect
    OnGridMouseMove = DUserKeyGrid1GridMouseMove
    OnGridPaint = DUserKeyGrid1GridPaint
  end
  object DMagicBase: TDButton
    Left = 358
    Top = 365
    Width = 51
    Height = 17
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMagicBaseDirectPaint
    OnClick = DMagicBaseClick
    Caption = #26222#36890#25216#33021
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
  end
  object DMagicCbo: TDButton
    Tag = 1
    Left = 411
    Top = 365
    Width = 44
    Height = 17
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMagicBaseDirectPaint
    OnClick = DMagicBaseClick
    Caption = #36830#20987#25216#33021
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
  end
  object DMagicCBOSetup: TDButton
    Left = 449
    Top = 426
    Width = 47
    Height = 17
    DFColor = 11922415
    DFEnabledColor = clWhite
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMagicCBOSetupClick
    Caption = #36830#20987#35774#32622
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagicCbo: TDWindow
    Left = 533
    Top = 363
    Width = 114
    Height = 74
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinMagicCboDirectPaint
    OnVisible = DStateWinMagicCboVisible
    Caption = #36830#20987#35774#32622
    DParent = DStateWinMagic
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = False
    ControlStyle = dsNone
  end
  object DStateWinMagicCboClose: TDButton
    Left = 618
    Top = 369
    Width = 29
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = #20851#38381
    DParent = DStateWinMagicCbo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagicCboOK: TDButton
    Left = 544
    Top = 411
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateWinMagicCboOKClick
    Caption = #30830#23450
    DParent = DStateWinMagicCbo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagicCboExit: TDButton
    Left = 606
    Top = 410
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMaxMinimapCloseClick
    Caption = #21462#28040
    DParent = DStateWinMagicCbo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagicCboICO: TDButton
    Left = 542
    Top = 363
    Width = 50
    Height = 23
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinMagicCboICODirectPaint
    OnMouseMove = DStateWinMagicCboICOMouseMove
    OnClick = DStateWinMagicCboICOClick
    OnInRealArea = DStateWinMagicCboICOInRealArea
    Caption = #36830#20987#22270#26631
    DParent = DStateWinMagicCbo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagicCboGrid: TDGrid
    Left = 544
    Top = 383
    Width = 56
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = #25216#33021#34920#26684
    DParent = DStateWinMagicCbo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 4
    RowCount = 1
    ColWidth = 38
    RowHeight = 38
    Coloffset = 10
    Rowoffset = 0
    ViewTopLine = 0
    OnGridSelect = DStateWinMagicCboGridGridSelect
    OnGridMouseMove = DStateWinMagicCboGridGridMouseMove
    OnGridPaint = DStateWinMagicCboGridGridPaint
  end
  object DBtnSayAll: TDButton
    Left = 610
    Top = 8
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = #20840#37096
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayWhisper: TDButton
    Tag = 2
    Left = 610
    Top = 39
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = #31169#32842
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayCry: TDButton
    Tag = 3
    Left = 610
    Top = 55
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = #21898#35805
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayGroup: TDButton
    Tag = 4
    Left = 610
    Top = 71
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = #38431#20237
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayGuild: TDButton
    Tag = 5
    Left = 610
    Top = 88
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = #24110#20250
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSaySys: TDButton
    Tag = 6
    Left = 610
    Top = 111
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = #31995#32479
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayHear: TDButton
    Tag = 1
    Left = 610
    Top = 24
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = #38468#36817
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayCustom: TDButton
    Tag = 7
    Left = 642
    Top = 111
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = #36873#23450
    DParent = DWndSay
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object dchkSayLock: TDCheckBox
    Left = 634
    Top = 8
    Width = 30
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DBTSayMoveMouseMove
    Caption = #28378#23631
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = True
    FontSpace = 3
    OnChange = dchkSayLockChange
    OffsetLeft = 0
    OffsetTop = 1
  end
  object dwndSayMode: TDWindow
    Left = 618
    Top = 444
    Width = 235
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dwndSayModeDirectPaint
    Caption = #32842#22825#27169#24335#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object dbtnSayModeHear: TDButton
    Left = 618
    Top = 444
    Width = 50
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = #38468#36817#32842#22825
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSayModeWhisper: TDButton
    Tag = 1
    Left = 713
    Top = 447
    Width = 38
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = #31169#32842
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSayModeCry: TDButton
    Tag = 2
    Left = 757
    Top = 447
    Width = 39
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = #21898#35805
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSayModeGroup: TDButton
    Tag = 3
    Left = 648
    Top = 453
    Width = 38
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = #38431#20237
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSayModeGuild: TDButton
    Tag = 4
    Left = 680
    Top = 444
    Width = 38
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = #34892#20250
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSayModeWorld: TDButton
    Tag = 5
    Left = 802
    Top = 447
    Width = 50
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = #21315#37324#20256#38899
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dwndWhisperName: TDWindow
    Left = 358
    Top = 445
    Width = 87
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dwndWhisperNameDirectPaint
    OnVisible = dwndWhisperNameVisible
    Caption = #31169#32842#23545#20687#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object dbtnSelServer1: TDButton
    Left = 8
    Top = 16
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSelServer1DirectPaint
    OnClick = dbtnSelServer1Click
    Caption = #19968
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer2: TDButton
    Tag = 1
    Left = 67
    Top = 17
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = #20108
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer3: TDButton
    Tag = 2
    Left = 124
    Top = 17
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = #19977
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer4: TDButton
    Tag = 3
    Left = 8
    Top = 44
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = #22235
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer5: TDButton
    Tag = 4
    Left = 65
    Top = 44
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = #20116
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer6: TDButton
    Tag = 5
    Left = 124
    Top = 44
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = #20845
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer7: TDButton
    Tag = 6
    Left = 8
    Top = 71
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = #19971
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer8: TDButton
    Tag = 7
    Left = 67
    Top = 71
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = #20843
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServerClose: TDButton
    Left = 153
    Top = 111
    Width = 24
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DWinSelServerExitClick
    Caption = #20851#38381
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnLoginLostPw: TDButton
    Left = 64
    Top = 189
    Width = 52
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLoginHomeDirectPaint
    OnClick = dbtnLoginLostPwClick
    Caption = #25214#22238#23494#30721
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMagicSub: TDButton
    Tag = 2
    Left = 461
    Top = 365
    Width = 53
    Height = 17
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMagicBaseDirectPaint
    OnClick = DMagicBaseClick
    Caption = #29983#27963#25216#33021
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
  end
  object DMakeMagicAdd1: TDButton
    Left = 413
    Top = 388
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd2: TDButton
    Tag = 1
    Left = 432
    Top = 388
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd3: TDButton
    Tag = 2
    Left = 451
    Top = 388
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd4: TDButton
    Tag = 3
    Left = 470
    Top = 388
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd5: TDButton
    Tag = 4
    Left = 489
    Top = 388
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd6: TDButton
    Tag = 5
    Left = 413
    Top = 411
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd7: TDButton
    Tag = 6
    Left = 432
    Top = 411
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd8: TDButton
    Tag = 7
    Left = 451
    Top = 411
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd9: TDButton
    Tag = 8
    Left = 470
    Top = 411
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd10: TDButton
    Tag = 9
    Left = 489
    Top = 411
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DButtonTop: TDButton
    Left = 797
    Top = 530
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DButtonTopClick
    Caption = #25490#34892#27036
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCreateChr2: TDWindow
    Left = 859
    Top = 524
    Width = 146
    Height = 86
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCreateChrDirectPaint
    Caption = #21019#24314#20154#29289#31383#21475
    DParent = DSelectChr
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DEditChrName2: TDEdit
    Left = 964
    Top = 523
    Width = 28
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    EditClass = deStandard
    FrameColor = clBlack
    MaxLength = 10
    CloseSpace = True
    boTransparent = True
  end
  object DccOk2: TDButton
    Left = 957
    Top = 562
    Width = 40
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #25552#20132
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccClose2: TDButton
    Left = 964
    Top = 586
    Width = 41
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = #36820#22238
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccManWarrior: TDButton
    Left = 876
    Top = 528
    Width = 51
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #25112#22763
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccManWizzard: TDButton
    Tag = 10
    Left = 876
    Top = 551
    Width = 50
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #39764#27861#24072
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccManMonk: TDButton
    Tag = 20
    Left = 876
    Top = 572
    Width = 50
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #36947#22763
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccWoManWarrior: TDButton
    Tag = 1
    Left = 932
    Top = 528
    Width = 51
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #25112#22763
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccWoManWizzard: TDButton
    Tag = 11
    Left = 932
    Top = 551
    Width = 50
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #39764#27861#24072
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccWoManMonk: TDButton
    Tag = 21
    Left = 932
    Top = 572
    Width = 50
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = #36947#22763
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusEXP: TDButton
    Left = 8
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusPOW: TDButton
    Tag = 1
    Left = 43
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusSC: TDButton
    Tag = 2
    Left = 78
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusAC: TDButton
    Tag = 3
    Left = 113
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusDC: TDButton
    Tag = 4
    Left = 148
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusHIDEMODE: TDButton
    Tag = 5
    Left = 183
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusSTONE: TDButton
    Tag = 6
    Left = 218
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusMC: TDButton
    Tag = 7
    Left = 8
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusMP: TDButton
    Tag = 8
    Left = 43
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusMAC: TDButton
    Tag = 9
    Left = 78
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusHP: TDButton
    Tag = 10
    Left = 113
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusDAMAGEARMOR: TDButton
    Tag = 11
    Left = 148
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusDECHEALTH: TDButton
    Tag = 12
    Left = 183
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusCOBWEB: TDButton
    Tag = 13
    Left = 218
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = #29366#24577'1'
    DParent = DTop
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateBTHorse: TDButton
    Tag = 4
    Left = 692
    Top = 249
    Width = 40
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = #22352#39569
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateWinHorse: TDWindow
    Left = 657
    Top = 270
    Width = 61
    Height = 168
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    Caption = #22352#39569#20449#24687#31383#21475
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DHorseRein: TDButton
    Tag = 16
    Left = 657
    Top = 283
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #32560#32499
    DParent = DStateWinHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHorseBell: TDButton
    Tag = 17
    Left = 657
    Top = 315
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #38083#38107
    DParent = DStateWinHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHorseSaddle: TDButton
    Tag = 18
    Left = 658
    Top = 347
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #39532#38797
    DParent = DStateWinHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHorseDecoration: TDButton
    Tag = 19
    Left = 658
    Top = 379
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #35013#39280
    DParent = DStateWinHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHorseNail: TDButton
    Tag = 20
    Left = 658
    Top = 411
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = #33050#38025
    DParent = DStateWinHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUserStateBTHorse: TDButton
    Tag = 4
    Left = 695
    Top = 477
    Width = 31
    Height = 15
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateBTInfoDirectPaint
    OnClick = DUserStateBTItemClick
    Caption = #22352' '#39569
    DParent = DUserState
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DUserStateHorse: TDWindow
    Left = 598
    Top = 507
    Width = 153
    Height = 97
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateItemDirectPaint
    Caption = #22352#39569#20449#24687#31383#21475
    DParent = DUserState
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DUSHorseRein: TDButton
    Tag = 16
    Left = 598
    Top = 514
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUSHorseReinDirectPaint
    OnMouseMove = DUSHorseReinMouseMove
    Caption = #32560#32499
    DParent = DUserStateHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUSHorseBell: TDButton
    Tag = 17
    Left = 598
    Top = 546
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUSHorseReinDirectPaint
    OnMouseMove = DUSHorseReinMouseMove
    Caption = #38083#38107
    DParent = DUserStateHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUSHorseSaddle: TDButton
    Tag = 18
    Left = 598
    Top = 578
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUSHorseReinDirectPaint
    OnMouseMove = DUSHorseReinMouseMove
    Caption = #39532#38797
    DParent = DUserStateHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUSHorseDecoration: TDButton
    Tag = 19
    Left = 692
    Top = 552
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUSHorseReinDirectPaint
    OnMouseMove = DUSHorseReinMouseMove
    Caption = #35013#39280
    DParent = DUserStateHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUSHorseNail: TDButton
    Tag = 20
    Left = 695
    Top = 584
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUSHorseReinDirectPaint
    OnMouseMove = DUSHorseReinMouseMove
    Caption = #33050#38025
    DParent = DUserStateHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DNewAccountClose: TDButton
    Left = 328
    Top = 134
    Width = 24
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DWinSelServerExitClick
    Caption = #20851#38381
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotMiniMap: TDButton
    Left = 306
    Top = 383
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DButRenewChrDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DBotMiniMapClick
    Caption = #23567#22320#22270
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotAddAbil: TDButton
    Left = 317
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBotAddAbilDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = #23646#24615#28857
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotMusic: TDButton
    Left = 282
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = #22768#38899
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMiniMap: TDWindow
    Left = 525
    Top = 79
    Width = 79
    Height = 49
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMiniMapDirectPaint
    OnMouseMove = DMiniMapMouseMove
    OnMouseDown = DMiniMapMouseDown
    OnMouseEntry = DMiniMapMouseEntry
    Caption = #23567#22320#22270#31383#21475
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DBotWndSay: TDWindow
    Left = 264
    Top = 528
    Width = 73
    Height = 57
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBotWndSayDirectPaint
    OnMouseDown = DBotWndSayMouseDown
    OnMouseUp = DBotWndSayMouseUp
    OnInRealArea = DBotWndSayInRealArea
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DCloseSayHear: TDButton
    Left = 112
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCloseSayHearDirectPaint
    OnMouseMove = DCloseSayHearMouseMove
    OnClick = DCloseSayHearClick
    Caption = #38468#36817
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCloseSayWhisper: TDButton
    Left = 147
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCloseSayHearDirectPaint
    OnMouseMove = DCloseSayHearMouseMove
    OnClick = DCloseSayHearClick
    Caption = #31169#32842
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCloseSayCry: TDButton
    Left = 182
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCloseSayHearDirectPaint
    OnMouseMove = DCloseSayHearMouseMove
    OnClick = DCloseSayHearClick
    Caption = #21898#35805
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCloseSayGuild: TDButton
    Left = 218
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCloseSayHearDirectPaint
    OnMouseMove = DCloseSayHearMouseMove
    OnClick = DCloseSayHearClick
    Caption = #34892#20250
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCloseSayGroup: TDButton
    Left = 253
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCloseSayHearDirectPaint
    OnMouseMove = DCloseSayHearMouseMove
    OnClick = DCloseSayHearClick
    Caption = #38431#20237
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateBTState: TDButton
    Tag = 5
    Left = 646
    Top = 262
    Width = 40
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = #29366#24577
    DParent = DStateWin
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateWinState: TDWindow
    Left = 724
    Top = 270
    Width = 61
    Height = 168
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    Caption = #29366#24577#20449#24687#31383#21475
    DParent = DStateWin
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DOpenCompoundItem: TDButton
    Left = 643
    Top = 186
    Width = 25
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DOpenCompoundItemDirectPaint
    OnClick = DOpenCompoundItemClick
    Caption = #21512#25104
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object RState: TRSA
    CommonalityKey = '39910943079509316779579'
    CommonalityMode = '486041964784552904735358570911'
    Left = 120
    Top = 72
  end
end
