object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20848#36798#23572#30331#24405#22120#37197#32622#22120
  ClientHeight = 354
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object pgc1: TPageControl
    Left = 8
    Top = 8
    Width = 473
    Height = 337
    ActivePage = ts6
    TabOrder = 0
    object ts2: TTabSheet
      Caption = #26381#21153#22120#21015#34920
      ImageIndex = 1
      object pgc2: TPageControl
        Left = 12
        Top = 10
        Width = 449
        Height = 297
        ActivePage = ts3
        Style = tsFlatButtons
        TabOrder = 0
        object ts3: TTabSheet
          Caption = #26381#21153#22120#35774#32622
          object grp2: TGroupBox
            Left = 0
            Top = 8
            Width = 441
            Height = 49
            Caption = #20998#32452#35774#32622
            TabOrder = 0
            object lbl12: TLabel
              Left = 8
              Top = 21
              Width = 54
              Height = 12
              Caption = #20998#32452#21015#34920':'
            end
            object cbbServerGroup: TComboBox
              Left = 64
              Top = 18
              Width = 100
              Height = 20
              Style = csDropDownList
              ItemHeight = 12
              TabOrder = 0
            end
            object btnAddGroup: TButton
              Left = 294
              Top = 14
              Width = 60
              Height = 25
              Caption = #22686#21152#20998#32452
              TabOrder = 1
              OnClick = btnAddGroupClick
            end
            object btnDelGroup: TButton
              Left = 356
              Top = 14
              Width = 60
              Height = 25
              Caption = #21024#38500#20998#32452
              TabOrder = 2
              OnClick = btnAddGroupClick
            end
            object BtnMoveSrvUp: TButton
              Left = 170
              Top = 14
              Width = 60
              Height = 25
              Caption = #20998#32452#19978#31227
              TabOrder = 3
              OnClick = BtnMoveSrvUpClick
            end
            object BtnMoveSrvDown: TButton
              Left = 232
              Top = 14
              Width = 60
              Height = 25
              Caption = #20998#32452#19979#31227
              TabOrder = 4
              OnClick = BtnMoveSrvDownClick
            end
          end
          object grp3: TGroupBox
            Left = 0
            Top = 63
            Width = 441
            Height = 177
            Caption = #26381#21153#22120#21015#34920
            TabOrder = 1
            object lvServerList: TListView
              Left = 8
              Top = 16
              Width = 425
              Height = 121
              Columns = <
                item
                  Caption = #26381#21153#22120#32452
                  Width = 90
                end
                item
                  Caption = #26174#31034#21517#31216
                  Width = 90
                end
                item
                  Caption = #26381#21153#22120#21517#31216
                  Width = 80
                end
                item
                  Caption = #26381#21153#22120#22320#22336
                  Width = 105
                end
                item
                  Caption = #31471#21475
                  Width = 40
                end>
              GridLines = True
              ReadOnly = True
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
            end
            object btnAddServer: TButton
              Left = 40
              Top = 142
              Width = 60
              Height = 25
              Caption = #22686#21152'(&A)'
              TabOrder = 1
              OnClick = btnAddServerClick
            end
            object btnDelServer: TButton
              Left = 200
              Top = 142
              Width = 60
              Height = 25
              Caption = #21024#38500'(&D)'
              TabOrder = 2
              OnClick = btnAddServerClick
            end
            object btnEditServer: TButton
              Left = 120
              Top = 142
              Width = 60
              Height = 25
              Caption = #20462#25913'(&E)'
              TabOrder = 3
              OnClick = btnAddServerClick
            end
            object BtnGameUp: TButton
              Left = 280
              Top = 142
              Width = 60
              Height = 25
              Caption = #19978#31227
              TabOrder = 4
              OnClick = BtnGameUpClick
            end
            object BtnGameDown: TButton
              Left = 360
              Top = 142
              Width = 60
              Height = 25
              Caption = #19979#31227
              TabOrder = 5
              OnClick = BtnGameDownClick
            end
          end
        end
        object ts4: TTabSheet
          Caption = #32593#39029#35774#32622
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object grp4: TGroupBox
            Left = 0
            Top = 8
            Width = 441
            Height = 99
            Caption = #30331#24405#22120#35774#32622
            TabOrder = 0
            object lbl8: TLabel
              Left = 8
              Top = 22
              Width = 66
              Height = 12
              Caption = #30331#24405#22120#31383#21475':'
            end
            object Label2: TLabel
              Left = 8
              Top = 74
              Width = 54
              Height = 12
              Caption = #20805#20540#20013#24515':'
            end
            object Label3: TLabel
              Left = 8
              Top = 48
              Width = 54
              Height = 12
              Caption = #23448#26041#32593#31449':'
            end
            object edtLoginframeUrl: TEdit
              Left = 77
              Top = 19
              Width = 348
              Height = 20
              MaxLength = 255
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Text = 'http://www.baidu.com'
            end
            object edtPayUrl2: TEdit
              Left = 77
              Top = 71
              Width = 348
              Height = 20
              MaxLength = 255
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Text = 'http://www.baidu.com'
            end
            object edtHomeUrl: TEdit
              Left = 77
              Top = 45
              Width = 348
              Height = 20
              MaxLength = 255
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Text = 'http://www.baidu.com'
            end
          end
          object grp5: TGroupBox
            Left = 0
            Top = 113
            Width = 441
            Height = 80
            Caption = #28216#25103#20869#32593#39029#22320#22336
            TabOrder = 1
            object lbl16: TLabel
              Left = 8
              Top = 22
              Width = 66
              Height = 12
              Caption = #32852#31995'GM'#25353#25197':'
            end
            object lbl7: TLabel
              Left = 8
              Top = 48
              Width = 54
              Height = 12
              Caption = #20805#20540#25353#25197':'
            end
            object edtGMUrl: TEdit
              Left = 77
              Top = 19
              Width = 348
              Height = 20
              MaxLength = 255
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Text = 'http://www.baidu.com'
            end
            object edtPayUrl: TEdit
              Left = 77
              Top = 45
              Width = 348
              Height = 20
              MaxLength = 255
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Text = 'http://www.baidu.com'
            end
          end
        end
        object ts5: TTabSheet
          Caption = #25968#25454#26356#26032#35774#32622
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object grp7: TGroupBox
            Left = 0
            Top = 8
            Width = 441
            Height = 225
            Caption = #26356#26032#21015#34920
            TabOrder = 0
            object lvUpDataList: TListView
              Left = 8
              Top = 17
              Width = 426
              Height = 167
              Columns = <
                item
                  Caption = #26356#26032#25552#31034
                  Width = 100
                end
                item
                  Caption = #20445#23384#20301#32622
                  Width = 80
                end
                item
                  Caption = #20445#23384#25991#20214#21517
                  Width = 90
                end
                item
                  Caption = #19979#36733#22320#22336
                  Width = 150
                end
                item
                  Caption = #35299#21387
                  Width = 40
                end
                item
                  Caption = #26816#27979
                end
                item
                  Caption = #19979#36733
                end
                item
                  Caption = #26102#38388
                  Width = 100
                end
                item
                  Caption = #29256#26412#21495
                end
                item
                  Caption = 'MD5'
                  Width = 180
                end
                item
                  Caption = #19979#36733#25928#39564
                  Width = 180
                end>
              GridLines = True
              ReadOnly = True
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
            end
            object btnAddUp: TButton
              Left = 72
              Top = 190
              Width = 89
              Height = 25
              Caption = #22686#21152'(&A)'
              TabOrder = 1
              OnClick = btnAddUpClick
            end
            object btnDelUp: TButton
              Left = 293
              Top = 190
              Width = 89
              Height = 25
              Caption = #21024#38500'(&D)'
              TabOrder = 2
              OnClick = btnAddUpClick
            end
            object btnEditUp: TButton
              Left = 184
              Top = 190
              Width = 89
              Height = 25
              Caption = #20462#25913'(&E)'
              TabOrder = 3
              OnClick = btnAddUpClick
            end
          end
        end
      end
      object btnServerInfoSave: TButton
        Left = 83
        Top = 280
        Width = 113
        Height = 25
        Hint = #24314#35758#20445#23384#65292#26041#20415#19979#27425#26356#26032#20351#29992#12290
        Caption = #20445#23384#37197#32622#20449#24687'(&S)'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnServerInfoSaveClick
      end
      object btnServerInfoWrite: TButton
        Left = 296
        Top = 280
        Width = 113
        Height = 25
        Caption = #29983#25104#37197#32622#25991#20214'(&W)'
        TabOrder = 2
        OnClick = btnServerInfoWriteClick
      end
    end
    object ts6: TTabSheet
      Caption = #28216#25103#30331#24405#22120
      ImageIndex = 3
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 441
        Height = 73
        Caption = #22522#26412#20449#24687
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 22
          Width = 60
          Height = 12
          Caption = #28216#25103#21517#23383#65306
        end
        object Label5: TLabel
          Left = 8
          Top = 48
          Width = 60
          Height = 12
          Caption = #21015#34920#22320#22336#65306
        end
        object GameNameEdit: TEdit
          Left = 88
          Top = 19
          Width = 337
          Height = 20
          MaxLength = 255
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Text = #20848#36798#23572#20256#22855
        end
        object ServerListEdit: TEdit
          Left = 88
          Top = 45
          Width = 337
          Height = 20
          MaxLength = 255
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Text = 'http://small.randall.top:8888/ServerInfo.txt'
        end
      end
      object GenerateLoginButton: TButton
        Left = 193
        Top = 281
        Width = 75
        Height = 25
        Caption = #29983#25104#30331#24405#22120
        TabOrder = 1
        OnClick = GenerateLoginButtonClick
      end
    end
  end
  object xmldSetup: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    Left = 448
    Top = 32
    DOMVendorDesc = 'MSXML'
  end
end
