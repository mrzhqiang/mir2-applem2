unit FrmMain;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, Math, DES, MyCommon, 
  Dialogs, ComCtrls, StdCtrls, Spin, xmldom, XMLIntf, msxmldom, XMLDoc, IEDCode, Buttons, DropGroupPas;

const
  XMLFILENAME = '.\LSetup.xml';
  XMLCLIENTFILENAME = '.\ServerInfo.txt';

type
  TFormMain = class(TForm)
    pgc1: TPageControl;
    ts2: TTabSheet;
    pgc2: TPageControl;
    ts3: TTabSheet;
    grp2: TGroupBox;
    lbl12: TLabel;
    cbbServerGroup: TComboBox;
    btnAddGroup: TButton;
    btnDelGroup: TButton;
    grp3: TGroupBox;
    lvServerList: TListView;
    btnAddServer: TButton;
    btnDelServer: TButton;
    btnEditServer: TButton;
    ts4: TTabSheet;
    ts5: TTabSheet;
    grp7: TGroupBox;
    lvUpDataList: TListView;
    btnAddUp: TButton;
    btnDelUp: TButton;
    btnEditUp: TButton;
    btnServerInfoSave: TButton;
    btnServerInfoWrite: TButton;
    xmldSetup: TXMLDocument;
    grp4: TGroupBox;
    lbl8: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtLoginframeUrl: TEdit;
    edtPayUrl2: TEdit;
    edtHomeUrl: TEdit;
    grp5: TGroupBox;
    lbl16: TLabel;
    lbl7: TLabel;
    edtGMUrl: TEdit;
    edtPayUrl: TEdit;
    BtnMoveSrvUp: TButton;
    BtnMoveSrvDown: TButton;
    BtnGameUp: TButton;
    BtnGameDown: TButton;
    procedure btnAddGroupClick(Sender: TObject);
    procedure btnAddServerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnServerInfoSaveClick(Sender: TObject);
    procedure btnServerInfoWriteClick(Sender: TObject);
    procedure btnAddUpClick(Sender: TObject);
    procedure DropFileGroupBox1DropFile(Sender: TObject);
    procedure DropFileGroupBox2DropFile(Sender: TObject);
    procedure BtnMoveSrvUpClick(Sender: TObject);
    procedure BtnMoveSrvDownClick(Sender: TObject);
    procedure BtnGameDownClick(Sender: TObject);
    procedure BtnGameUpClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure FormCenter(MoveForm: TForm);
    procedure LoadSetup;
    procedure SaveSetup(FileName: string; boEncode: Boolean);
    procedure ShowProgress(aPercent: Integer);
  end;

var
  FormMain: TFormMain;

implementation

uses FrmEditServer, FrmEditUpData, Share, Hutil32, ShellApi, MD5Unit, FrmLogin;

{$R *.dfm}

const
  boZIP: array[Boolean] of string[2] = ('否', '是');
  btCheck: array[-1..3] of string[4] = ('未知', '版本', '存在', 'PAK', 'MD5');
  boDown: array[Boolean] of string[4] = ('直接', '百度');

procedure TFormMain.btnAddGroupClick(Sender: TObject);
var
  sInputText, sName: string;
  I: integer;
  Item: TListItem;
begin
  sInputText := '';
  if Sender = btnAddGroup then begin
    if not InputQuery('增加', '请输入你要增加的服务器分组:', sInputText) then
      exit;
    if sInputText = '' then begin
      Application.MessageBox('服务器分组内容不能为空!', '提示信息', MB_OK + MB_ICONERROR);
      exit;
    end;
    cbbServerGroup.ItemIndex := cbbServerGroup.Items.Add(sInputText);
  end
  else if Sender = btnDelGroup then begin
    if cbbServerGroup.ItemIndex = -1 then begin
      Application.MessageBox('请先选择你要删除的分组信息!', '提示信息', MB_OK + MB_ICONERROR);
      exit;
    end
    else begin
      sName := cbbServerGroup.Items.Strings[cbbServerGroup.ItemIndex];
      sInputText := Format('是否确定删除分组[%s]信息？'#13#10'将会同时删除所有该组的服务器列表!',
        [sName]);
      if Application.MessageBox(PChar(sInputText), '提示信息', MB_OKCANCEL + MB_ICONQUESTION) = IDOK then begin
        cbbServerGroup.Items.Delete(cbbServerGroup.ItemIndex);
        for I := lvServerList.Items.Count - 1 downto 0 do begin
          Item := lvServerList.Items[I];
          if CompareText(Item.Caption, sName) = 0 then
            lvServerList.Items.Delete(I);
        end;
      end;
    end;
  end;
end;

procedure TFormMain.btnAddServerClick(Sender: TObject);
var
  Item: TListItem;
begin
  if Sender = btnAddServer then begin
    FormCenter(FormEditServer);
    FormEditServer.ComboBoxServerGroup.Items := cbbServerGroup.Items;
    with FormEditServer do begin
      Caption := '增加服务器列表';
      EditShowName.Text := '';
      EditName.Text := '';
      EditAddr.Text := '';
      EdtPort.Text := '7000';
      if ShowModal = mrOk then begin
        Item := lvServerList.Items.Add;
        Item.Caption := ComboBoxServerGroup.Items.Strings[ComboBoxServerGroup.ItemIndex];
        Item.SubItems.Add(Trim(EditShowName.Text));
        Item.SubItems.Add(Trim(EditName.Text));
        Item.SubItems.Add(Trim(EditAddr.Text));
        Item.SubItems.Add(Trim(EdtPort.Text));
        //Item.SubItems.Add('');
        //Item.SubItems.Add('');
      end;
    end;
  end
  else if Sender = btnEditServer then begin
    if lvServerList.ItemIndex >= 0 then begin
      Item := lvServerList.Items[lvServerList.ItemIndex];
      FormCenter(FormEditServer);
      FormEditServer.ComboBoxServerGroup.Items := cbbServerGroup.Items;
      with FormEditServer do begin
        Caption := '修改服务器列表';
        EditShowName.Text := Item.SubItems.Strings[0];
        EditName.Text := Item.SubItems.Strings[1];
        EditAddr.Text := Item.SubItems.Strings[2];
        EdtPort.Text := Item.SubItems.Strings[3];
        //SetComBoxIdx(Item.Caption);
        if ShowModal = mrOk then begin
          Item.Caption := ComboBoxServerGroup.Items.Strings[ComboBoxServerGroup.ItemIndex];
          Item.SubItems.Strings[0] := Trim(EditShowName.Text);
          Item.SubItems.Strings[1] := Trim(EditName.Text);
          Item.SubItems.Strings[2] := Trim(EditAddr.Text);
          Item.SubItems.Strings[3] := Trim(EdtPort.Text);
          //Item.SubItems.Strings[4] := '';
          //Item.SubItems.Strings[5] := '';
        end;
      end;
    end
    else
      Application.MessageBox('请先选择你要修改的服务器信息!', '提示信息', MB_OK + MB_ICONERROR);
  end
  else if Sender = btnDelServer then begin
    if lvServerList.ItemIndex >= 0 then begin
      lvServerList.Items.Delete(lvServerList.ItemIndex);
    end
    else
      Application.MessageBox('请先选择你要删除的服务器信息!', '提示信息', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFormMain.btnAddUpClick(Sender: TObject);
var
  Item: TListItem;
begin
  if Sender = btnAddUp then begin
    FormCenter(FormEditUpData);
    with FormEditUpData do begin
      Caption := '增加更新列表';
      {EditDownUrl.Text := 'http://';
      EditSaveDir.Text := '.\';
      EditSaveName.Text := '';
      edtHint.Text := '';    }
      if ShowModal = mrOk then begin
        Item := lvUpDataList.Items.Add;
        Item.Caption := edtHint.Text;
        Item.SubItems.Add(Trim(EditSaveDir.Text));
        Item.SubItems.Add(Trim(EditSaveName.Text));
        Item.SubItems.Add(Trim(EditDownUrl.Text));
        Item.SubItems.Add(boZip[ComboBoxZip.ItemIndex = 1]);
        Item.SubItems.Add(btCheck[cbbCheckType.ItemIndex]);
        Item.SubItems.Add(boDown[cbbDownType.ItemIndex = 1]);
        Item.SubItems.Add(Trim(edtDate.Text));
        Item.SubItems.Add(EditVer.Text);
        Item.SubItems.Add(edtMD5.Text);
        Item.SubItems.Add(edtdownmd5.Text);
        //Item.SubItems.Add(GetMD5Text(DateTimeToStr(Now) + EditDownUrl.Text + EditSaveName.Text + IntToStr(Random(GetTickCount))));
      end;
    end;
  end
  else if Sender = btnEditUp then begin
    if lvUpDataList.ItemIndex >= 0 then begin
      Item := lvUpDataList.Items[lvUpDataList.ItemIndex];
      FormCenter(FormEditUpData);
      with FormEditUpData do begin
        Caption := '修改更新列表';
        EditDownUrl.Text := Item.SubItems.Strings[2];
        EditSaveDir.Text := Item.SubItems.Strings[0];
        EditSaveName.Text := Item.SubItems.Strings[1];
        edtHint.Text := Item.Caption;

        if Item.SubItems.Strings[3] = '是' then
          ComboBoxZip.ItemIndex := 1
        else
          ComboBoxZip.ItemIndex := 0;
        if Item.SubItems.Strings[4] = '版本' then
          cbbCheckType.ItemIndex := 0
        else if Item.SubItems.Strings[4] = '存在' then
          cbbCheckType.ItemIndex := 1
        else if Item.SubItems.Strings[4] = 'PAK' then
          cbbCheckType.ItemIndex := 2
        else
          cbbCheckType.ItemIndex := 3;

        if Item.SubItems.Strings[5] = '百度' then
          cbbDownType.ItemIndex := 1
        else
          cbbDownType.ItemIndex := 0;
        edtDate.Text := Item.SubItems.Strings[6];
        EditVer.Text := Item.SubItems.Strings[7];
        edtMD5.Text := Item.SubItems.Strings[8];
        edtdownmd5.Text := Item.SubItems.Strings[9];
        cbbCheckTypeChange(cbbCheckType);
        if ShowModal = mrOk then begin
          Item.Caption := edtHint.Text;
          Item.SubItems.Strings[0] := Trim(EditSaveDir.Text);
          Item.SubItems.Strings[1] := Trim(EditSaveName.Text);
          Item.SubItems.Strings[2] := Trim(EditDownUrl.Text);
          Item.SubItems.Strings[3] := boZip[ComboBoxZip.ItemIndex = 1];
          Item.SubItems.Strings[4] := btCheck[cbbCheckType.ItemIndex];
          Item.SubItems.Strings[5] := boDown[cbbDownType.ItemIndex = 1];
          Item.SubItems.Strings[6] := Trim(edtDate.Text);
          Item.SubItems.Strings[7] := EditVer.Text;
          Item.SubItems.Strings[8] := edtMD5.Text;
          Item.SubItems.Strings[9] := edtdownmd5.Text;
        end;
      end;
    end
    else
      Application.MessageBox('请先选择你要修改的更新信息!', '提示信息', MB_OK + MB_ICONERROR);
  end
  else if Sender = btnDelUp then begin
    if lvUpDataList.ItemIndex >= 0 then begin
      lvUpDataList.Items.Delete(lvUpDataList.ItemIndex);
    end
    else
      Application.MessageBox('请先选择你要删除的更新信息!', '提示信息', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFormMain.BtnGameUpClick(Sender: TObject);
var
  nIndex: Integer;
  tmp: TListItem;
begin
  if not Assigned(lvServerList.Selected) or (lvServerList.Selected.Index < 0) then begin
    Application.MessageBox('请选择好分组', '错误提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  nIndex := lvServerList.Selected.Index;
  if nIndex <= 0 then begin
    Application.MessageBox('该分组已经在最顶层', '错误提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  lvServerList.Items.BeginUpdate;
  tmp := lvServerList.Items.Insert(nIndex - 1);
  tmp.Assign(lvServerList.Items[nIndex + 1]);
  lvServerList.Items.Delete(nIndex + 1);
  lvServerList.Items.EndUpdate;
end;

procedure TFormMain.BtnGameDownClick(Sender: TObject);
var
  nIndex: Integer;
  tmp: TListItem;
begin
  if not Assigned(lvServerList.Selected) or (lvServerList.Selected.Index < 0) then begin
    Application.MessageBox('请选择好分组', '错误提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  nIndex := lvServerList.Selected.Index;
  if nIndex >= lvServerList.Items.Count - 1 then begin
    Application.MessageBox('该分组已经在最底层', '错误提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  lvServerList.Items.BeginUpdate;
  tmp := lvServerList.Items.Insert(nIndex + 2);
  tmp.Assign(lvServerList.Items[nIndex]);
  lvServerList.Items.Delete(nIndex);
  lvServerList.Items.EndUpdate;
end;

procedure TFormMain.BtnMoveSrvDownClick(Sender: TObject);
var
  nIndex: Integer;
begin
  if cbbServerGroup.ItemIndex < 0 then begin
    Application.MessageBox('请选择好分组', '错误提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  nIndex := cbbServerGroup.ItemIndex;
  if nIndex >= cbbServerGroup.Items.Count - 1 then begin
    Application.MessageBox('该分组已经在最底层', '错误提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  cbbServerGroup.Items.Move(nIndex, nIndex + 1);
  cbbServerGroup.ItemIndex := nIndex + 1;
end;

procedure TFormMain.BtnMoveSrvUpClick(Sender: TObject);
var
  nIndex: Integer;
begin
  if cbbServerGroup.ItemIndex < 0 then begin
    Application.MessageBox('请选择好分组', '错误提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  if cbbServerGroup.ItemIndex <= 0 then begin
    Application.MessageBox('该分组已经在最顶层', '错误提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  nIndex := cbbServerGroup.ItemIndex;
  cbbServerGroup.Items.Move(nIndex, nIndex - 1);
  cbbServerGroup.ItemIndex := nIndex - 1;
end;

procedure TFormMain.btnServerInfoSaveClick(Sender: TObject);
begin
  SaveSetup(XMLFILENAME, False);
  Application.MessageBox('保存配置成功完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TFormMain.btnServerInfoWriteClick(Sender: TObject);
 { function CanWriteList(): Boolean;
  var
    Item: TListItem;
    I: Integer;
  begin
    Result := True;
    for I := 0 to lvServerList.Items.Count - 1 do begin
      Item := lvServerList.Items[I];
      if (Item.SubItems[4] = '') or (Item.SubItems[5] = '') then begin
        Result := False;
        Break;
      end;
    end;
  end;    }
var
  List: TStringList;
  boLoad: Boolean;
begin
  boLoad := False;
 { if not CanWriteList then begin
    Application.MessageBox('跟据您目前的设置，需要连接361M2管理中心获取数据！', '提示信息', MB_OK + MB_ICONINFORMATION);
    FormLogin := TFormLogin.Create(Owner);
    FormLogin.ShowModal;
    FormLogin.Free;
    FormLogin := nil;
    boLoad := True;
  end;
  if CanWriteList then begin   }
  SaveSetup(XMLCLIENTFILENAME, True);
  List := TStringList.Create;
  List.LoadFromFile(XMLCLIENTFILENAME);
  List.Insert(0, '$BEGIN');
  List.Add('$END');
  List.SaveToFile(XMLCLIENTFILENAME);
  List.Free;
  Application.MessageBox('生成配置成功完成！', '提示信息', MB_OK + MB_ICONINFORMATION);
  if boLoad then begin
    if Application.MessageBox('成功从管理中心获取数据，是否保存数据？', '提示信息', MB_OKCANCEL + MB_ICONQUESTION) = IDOK then begin
      btnServerInfoSaveClick(btnServerInfoSave);
    end;
  end;
  //end else
   // Application.MessageBox('生成配置列表失败！', '提示信息', MB_OK + MB_ICONSTOP);
end;
(*
procedure TFormMain.Button1Click(Sender: TObject);
var
  Res: TResourceStream;
  sFileName, sTestStr: string;
  sGameName: string[12];
  sUserList: string[200];
  sPassword: string;
begin
  sGameName := Trim(EditServerName.Text);
  sUserList := Trim(EditServerList.Text);
  if sGameName = '' then begin
    Application.MessageBox('游戏名称不能留空！', '错误提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  if sUserList = '' then begin
    Application.MessageBox('列表地址不能留空！', '错误提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  sFileName := '.\' + sGameName + '.exe';
  if FileExists(sFileName) then begin
    if not DeleteFile(sFileName) then begin
      Application.MessageBox('生成登录器失败(无法生成文件)！', '错误提示', MB_OK + MB_ICONSTOP);
      Exit;
    end;
  end;
  Res := TResourceStream.Create(Hinstance, 'LoginData', 'Data');
  try
    Res.SaveToFile(sFileName);
  finally
    Res.Free;
  end;
  sTestStr := GetMD5TextOf16(FormatDateTime('YYYYMMDDHHSSMM', Now) + sGameName + sUserList + IntToStr(Random(99999))) + #13;
  sTestStr := sTestStr + sGameName + #13;
  sTestStr := sTestStr + sUserList;

  sPassword := 'http://www.361m2.com';
  sPassword := sPassword + '361免费版登录器';
  sPassword := sPassword + '361免费版登录器';
  sPassword := GetMD5TextOf16(sPassword);
  sTestStr := EncryStrHex(sTestStr, sPassword);
  if SetFileVerSionInfoByNameW(sFileName, 'OriginalFilename', sTestStr) then begin
    Application.MessageBox('登录器生成成功！', '提示信息', MB_OK + MB_ICONINFORMATION);
  end else begin
    Application.MessageBox('生成登录器失败(无法写入配置信息)！', '错误提示', MB_OK + MB_ICONSTOP);
  end;
end;
*)
procedure TFormMain.DropFileGroupBox1DropFile(Sender: TObject);
begin
  //edt1.Text := DropFileGroupBox1.Files[0];
end;

procedure TFormMain.DropFileGroupBox2DropFile(Sender: TObject);
begin
  //edt3.Text := DropFileGroupBox2.Files[0];
end;

procedure TFormMain.FormCenter(MoveForm: TForm);
begin
  MoveForm.Left := Left + (Width div 2 - MoveForm.Width div 2);
  MoveForm.Top := Top + (Height div 2 - MoveForm.Height div 2);
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Randomize;
  pgc2.TabIndex := 0;
  pgc1.TabIndex := 0;
  LoadSetup;
end;

procedure TFormMain.LoadSetup;
var
  RootNode, ANode, BNode, CNode, DNode: IXMLNode;
  xmlList, ln, bn, cn: IXMLNodeList;
  i, k, j: Integer;
  Item: TListItem;
  sStr: string;
  sName, sAddrs, sPort{, sENAddrs, sENPort}: string;
begin
  if FileExists(XMLFILENAME) then begin
    xmldSetup.FileName := XMLFILENAME;
    xmldSetup.Active := True;
    try
      RootNode := xmldSetup.DocumentElement;
      xmlList := RootNode.ChildNodes;
      ANode := xmlList[XML_SERVER_MASTERNODE];
      if ANode.HasChildNodes then begin
        ln := ANode.ChildNodes;
        for I := 0 to ln.Count - 1 do begin
          BNode := ln[I];
          cbbServerGroup.Items.Add(BNode.GetAttribute(XML_SERVER_NAME));
          bn := BNode.ChildNodes;
          for k := 0 to bn.Count - 1 do begin
            CNode := bn[k];
            sName := '';
            sAddrs := '';
            sPort := '';
            //sENAddrs := '';
            //sENPort := '';
            Item := lvServerList.Items.Add;
            Item.Caption := BNode.GetAttribute(XML_SERVER_NAME);
            Item.SubItems.Add(CNode.GetAttribute(XML_SERVER_NAME));
            cn := CNode.ChildNodes;
            for j := 0 to cn.Count - 1 do begin
              DNode := cn[j];
              if not VarIsNull(DNode.Text) then begin
                if sName <> '' then sName := sName + ';' + DNode.Text
                else sName := DNode.Text;
                if sAddrs <> '' then sAddrs := sAddrs + ';' + DNode.GetAttribute(XML_SERVER_NODE_ADDRS)
                else sAddrs := DNode.GetAttribute(XML_SERVER_NODE_ADDRS);
                if sPort <> '' then sPort := sPort + ';' + DNode.GetAttribute(XML_SERVER_NODE_PORT)
                else sPort := DNode.GetAttribute(XML_SERVER_NODE_PORT);
                {if sENAddrs <> '' then sENAddrs := sENAddrs + ';' + DNode.GetAttribute(XML_SERVER_NODE_ENADDRS)
                else sENAddrs := DNode.GetAttribute(XML_SERVER_NODE_ENADDRS);
                if sENPort <> '' then sENPort := sENPort + ';' + DNode.GetAttribute(XML_SERVER_NODE_ENPORT)
                else sENPort := DNode.GetAttribute(XML_SERVER_NODE_ENPORT);    }
              end;
            end;
            Item.SubItems.Add(sName);
            Item.SubItems.Add(sAddrs);
            Item.SubItems.Add(sPort);
            //Item.SubItems.Add(sENAddrs);
            //Item.SubItems.Add(sENPort);
          end;
        end;
      end;

      ANode := xmlList[XML_URL_MASTERNODE];
      //if not VarIsNull(ANode.ChildValues[XML_URL_HOME]) then
        //edtHostUrl.Text := ANode.ChildValues[XML_URL_HOME];
      if not VarIsNull(ANode.ChildValues[XML_URL_LFRAME]) then
        edtLoginframeUrl.Text := ANode.ChildValues[XML_URL_LFRAME];
      if not VarIsNull(ANode.ChildValues[XML_URL_CONTACTGM]) then
        edtGMUrl.Text := ANode.ChildValues[XML_URL_CONTACTGM];
      if not VarIsNull(ANode.ChildValues[XML_URL_PAYMENT]) then
        edtPayUrl.Text := ANode.ChildValues[XML_URL_PAYMENT];
      //if not VarIsNull(ANode.ChildValues[XML_URL_REGISTER]) then
        //edtRegUrl.Text := ANode.ChildValues[XML_URL_REGISTER];
      //if not VarIsNull(ANode.ChildValues[XML_URL_CHANGEPASS]) then
        //edtChangePassUrl.Text := ANode.ChildValues[XML_URL_CHANGEPASS];
      //if not VarIsNull(ANode.ChildValues[XML_URL_LostPASS]) then
        //edtLostPassUrl.Text := ANode.ChildValues[XML_URL_LostPASS];
      if not VarIsNull(ANode.ChildValues[XML_URL_PAYMENT2]) then
        edtPayUrl2.Text := ANode.ChildValues[XML_URL_PAYMENT2];
      if not VarIsNull(ANode.ChildValues[XML_URL_HOMR]) then
        edtHomeUrl.Text := ANode.ChildValues[XML_URL_HOMR];
      //if not VarIsNull(ANode.ChildValues[XML_URL_LOGOIMAGE]) then
        //EditLogoImage.Text := ANode.ChildValues[XML_URL_LOGOIMAGE];

      ANode := xmlList[XML_UPDATE_MASTERNODE];
      if ANode.HasChildNodes then begin
        ln := ANode.ChildNodes;
        for I := 0 to ln.Count - 1 do begin
          BNode := ln[I];
          if not VarIsNull(BNode.Text) then begin
            Item := lvUpDataList.Items.Add;
            Item.Caption := BNode.Text;
            Item.SubItems.Add(BNode.GetAttribute(XML_UPDATE_SAVEDIR));
            Item.SubItems.Add(BNode.GetAttribute(XML_UPDATE_FILENAME));
            Item.SubItems.Add(BNode.GetAttribute(XML_UPDATE_DOWNPATH));
            sStr := BNode.GetAttribute(XML_UPDATE_ZIP);
            if sStr = XML_ZIP_YES then
              Item.SubItems.Add(boZip[True])
            else
              Item.SubItems.Add(boZip[False]);
            sStr := BNode.GetAttribute(XML_UPDATE_CHECK);
            if sStr = XML_CHECK_VAR then
              Item.SubItems.Add(btCheck[StrToIntDef(sStr, 0)])
            else if sStr = XML_CHECK_EXISTS then
              Item.SubItems.Add(btCheck[StrToIntDef(sStr, 0)])
            else if sStr = XML_CHECK_PACK then
              Item.SubItems.Add(btCheck[StrToIntDef(sStr, 0)])
            else
              Item.SubItems.Add(btCheck[StrToIntDef(XML_CHECK_MD5, 0)]);
            sStr := BNode.GetAttribute(XML_UPDATE_DOWNTYPE);
            if sStr = XML_DOWNTYPE_BAIDU then
              Item.SubItems.Add(boDown[True])
            else
              Item.SubItems.Add(boDown[False]);
            Item.SubItems.Add(BNode.GetAttribute(XML_UPDATE_DATE));
            Item.SubItems.Add(BNode.GetAttribute(XML_UPDATE_VAR));
            Item.SubItems.Add(BNode.GetAttribute(XML_UPDATE_MD5));
            Item.SubItems.Add(BNode.GetAttribute(XML_UPDATE_ID));
          end;
        end;
      end;
    finally
      xmldSetup.Active := False;
    end;
  end;
end;

procedure TFormMain.SaveSetup(FileName: string; boEncode: Boolean);
  function Encode(sMsg: string): string;
  begin
    if boEncode then begin
      //Result := AnsiReplaceText(IEnCodeString(sMsg), '=', '-');
      Result := IEnCodeString(sMsg);
    end
    else begin
      Result := sMsg;
    end;
  end;
var
  RootNode, ANode, BNode, CNode, DNode: IXMLNode;
  I, k: Integer;
  Item: TListItem;
  sName, sAddrs, sPort,{ sENAddrs, sENPort, }sSubName, sSubAddrs, sSubPort{, sSubENAddr, sSubENPort}: string;
  //nPort: Integer;
begin
  xmldSetup.Active := True;
  try
    RootNode := xmldSetup.CreateNode(XML_MASTERNODE);
    xmldSetup.DocumentElement := RootNode;
    xmldSetup.Version := '1.0';
    xmldSetup.Encoding := 'GB2312';

    ANode := RootNode.AddChild(XML_SERVER_MASTERNODE);
    for I := 0 to cbbServerGroup.Items.Count - 1 do begin
      BNode := ANode.AddChild(XML_SERVER_GROUP);
      BNode.SetAttribute(XML_SERVER_NAME, Encode(cbbServerGroup.Items[I]));
      for k := 0 to lvServerList.Items.Count - 1 do begin
        Item := lvServerList.Items[k];
        if Item.Caption = cbbServerGroup.Items[I] then begin
          CNode := BNode.AddChild(XML_SERVER_SERVER);
          CNode.SetAttribute(XML_SERVER_NAME, Encode(Item.SubItems[0]));
          sName := Item.SubItems[1];
          sAddrs := Item.SubItems[2];
          sPort := Item.SubItems[3];
          //sENAddrs := Item.SubItems[4];
          //sENPort := Item.SubItems[5];
          while True do begin
            sName := GetValidStr3(sName, sSubName, [';']);
            sAddrs := GetValidStr3(sAddrs, sSubAddrs, [';']);
            sPort := GetValidStr3(sPort, sSubPort, [';']);
            //sENAddrs := GetValidStr3(sENAddrs, sSubENAddr, [';']);
            //sENPort := GetValidStr3(sENPort, sSubENPort, [';']);
            //nPort := StrToIntDef(sSubPort, -1);
            if (sSubName <> '') and (sSubAddrs <> '') {and (nPort > 0) and (nPort < 65535)} then begin
              DNode := CNode.AddChild(XML_SERVER_NODELIST);
              DNode.Text := Encode(sSubName);
              DNode.SetAttribute(XML_SERVER_NODE_ADDRS, Encode(sSubAddrs));
              DNode.SetAttribute(XML_SERVER_NODE_PORT, Encode(sSubPort));
              //DNode.SetAttribute(XML_SERVER_NODE_ENADDRS, sSubENAddr);
              //DNode.SetAttribute(XML_SERVER_NODE_ENPORT, sSubENPort);
            end
            else
              Break;
          end;
        end;
      end;
    end;

    ANode := RootNode.AddChild(XML_URL_MASTERNODE);
    //BNode := ANode.AddChild(XML_URL_HOME);
    //BNode.Text := Encode(edtHostUrl.Text);
    BNode := ANode.AddChild(XML_URL_LFRAME);
    BNode.Text := Encode(edtLoginframeUrl.Text);
    BNode := ANode.AddChild(XML_URL_CONTACTGM);
    BNode.Text := Encode(edtGMUrl.Text);
    BNode := ANode.AddChild(XML_URL_PAYMENT);
    BNode.Text := Encode(edtPayUrl.Text);
    {BNode := ANode.AddChild(XML_URL_REGISTER);
    BNode.Text := Encode('');
    BNode := ANode.AddChild(XML_URL_CHANGEPASS);
    BNode.Text := Encode('');
    BNode := ANode.AddChild(XML_URL_LostPASS);
    BNode.Text := Encode('');  }
    BNode := ANode.AddChild(XML_URL_PAYMENT2);
    BNode.Text := Encode(edtPayUrl2.Text);
    BNode := ANode.AddChild(XML_URL_HOMR);
    BNode.Text := Encode(edtHomeUrl.Text);
    {BNode := ANode.AddChild(XML_URL_LOGOIMAGE);
    BNode.Text := Encode('');   }

    ANode := RootNode.AddChild(XML_UPDATE_MASTERNODE);
    for I := 0 to lvUpDataList.Items.Count - 1 do begin
      BNode := ANode.AddChild(XML_CONFIG);
      Item := lvUpDataList.Items[i];
      BNode.Text := Encode(Item.Caption);
      BNode.SetAttribute(XML_UPDATE_SAVEDIR, Encode(Item.SubItems[0]));
      BNode.SetAttribute(XML_UPDATE_FILENAME, Encode(Item.SubItems[1]));
      BNode.SetAttribute(XML_UPDATE_DOWNPATH, Encode(Item.SubItems[2]));

      if Item.SubItems.Strings[3] = '是' then
        BNode.SetAttribute(XML_UPDATE_ZIP, XML_ZIP_YES)
      else
        BNode.SetAttribute(XML_UPDATE_ZIP, XML_ZIP_NO);
      if Item.SubItems.Strings[4] = '版本' then
        BNode.SetAttribute(XML_UPDATE_CHECK, XML_CHECK_VAR)
      else if Item.SubItems.Strings[4] = '存在' then
        BNode.SetAttribute(XML_UPDATE_CHECK, XML_CHECK_EXISTS)
      else if Item.SubItems.Strings[4] = 'PAK' then
        BNode.SetAttribute(XML_UPDATE_CHECK, XML_CHECK_PACK)
      else
        BNode.SetAttribute(XML_UPDATE_CHECK, XML_CHECK_MD5);
      if Item.SubItems.Strings[5] = '百度' then
        BNode.SetAttribute(XML_UPDATE_DOWNTYPE, XML_DOWNTYPE_BAIDU)
      else
        BNode.SetAttribute(XML_UPDATE_DOWNTYPE, XML_DOWNTYPE_DEF);

      BNode.SetAttribute(XML_UPDATE_DATE, Item.SubItems.Strings[6]);
      BNode.SetAttribute(XML_UPDATE_VAR, Item.SubItems.Strings[7]);
      BNode.SetAttribute(XML_UPDATE_MD5, Item.SubItems.Strings[8]);
      BNode.SetAttribute(XML_UPDATE_ID, Item.SubItems.Strings[9]);

    end;

    xmldSetup.SaveToFile(FileName);
  finally
    xmldSetup.Active := False;
  end;
end;
procedure TFormMain.ShowProgress(aPercent: Integer);
begin
  //pb1.Position := aPercent;
  //Application.ProcessMessages;
end;

end.

