unit Share;

interface

uses
  MSHTML, ActiveX, Variants, SysUtils, Graphics, Windows, ShlObj, ComObj, DateUtils;

const
  XML_MASTERNODE = 'XMLSetup';
  XML_SERVER_MASTERNODE = 'ServerList';
  XML_SERVER_GROUP = 'Group';
  XML_SERVER_SERVER = 'Server';
  XML_SERVER_NAME = 'Name';
  XML_SERVER_NODE_ADDRS = 'Addrs';
  XML_SERVER_NODE_PORT = 'Port';
  XML_SERVER_NODE_ENADDRS = 'ENAddrs';
  XML_SERVER_NODE_ENPORT = 'ENPort';
  XML_SERVER_NODELIST = 'Child';
  XML_URL_MASTERNODE = 'Url';
  //XML_URL_HOME = 'Home';
  XML_URL_LFRAME = 'Loginframe';
  XML_URL_CONTACTGM = 'ContactGM';
  XML_URL_PAYMENT = 'Payment';
  XML_URL_PAYMENT2 = 'Payment2';
  XML_URL_HOMR = 'Home';
  XML_URL_REGISTER = 'Register';
  XML_URL_CHANGEPASS = 'ChangePass';
  XML_URL_LostPASS = 'LostPass';
  XML_URL_LOGOIMAGE = 'LogoImage';
  XML_UPDATE_MASTERNODE = 'UpDate';
  XML_CONFIG = 'Config';
  XML_UPDATE_SAVEDIR = 'SDir';
  XML_UPDATE_FILENAME = 'FName';
  XML_UPDATE_DOWNPATH = 'DUrl';
  XML_UPDATE_ZIP = 'ZIP';
  XML_UPDATE_CHECK = 'Check';
  XML_UPDATE_DOWNTYPE = 'DType';
  XML_UPDATE_DATE = 'Date';
  XML_UPDATE_VAR = 'VAR';
  XML_UPDATE_MD5 = 'MD5';
  XML_UPDATE_ID = 'ID';

  XML_ZIP_NO = '0';
  XML_ZIP_YES = '1';

  XML_CHECK_VAR = '0';
  XML_CHECK_EXISTS = '1';
  XML_CHECK_PACK = '2';
  XML_CHECK_MD5 = '3';

  XML_DOWNTYPE_DEF = '0';
  XML_DOWNTYPE_BAIDU = '1';

  BMP_PART_SIZE = $7CCF0;
  BMP_MAX_SIZE = $7CD2E;

  LOGINSKININFOTITLE = '361M2 SKIN';
  LOGINSKININFOVAR = 20101227;

  SCREENWIDTH = 800;
  SCREENHEIGHT = 600;

  WINLEFT = 60;
  WINTOP = 60;
  WINRIGHT = 800 - 60;
  BOTTOMEDGE = 600 - 60; // Bottom WINBOTTOM

  DEF_FONT_NAME = '宋体';
  DEF_FONT_SIZE = 9;

type
  TBmpPartBuffer = array[0..BMP_PART_SIZE - 1] of Char;

  TBmpPartInfo = packed record
    BitmapFileHeader: TBitmapFileHeader;
    BitmapInfoHeader: TBitmapInfoHeader;
    nFileSize: Integer;
    nDataSize: Integer;
    //Data: TBmpPartBuffer;
  end;

  TSkin_Bitmap = packed record
    Offset: Integer;
    Size: Integer;
  end;

  TSkin_Rect = packed record
    Left: Word;
    Top: Word;
    Width: Word;
    Height: Word;
  end;

  TSkin_Pos = packed record
    Left: Word;
    Top: Word;
  end;

  TImageType = (it_Bitmap, it_Jpeg);

  TLoginSkinBottom = packed record
    sTitle:array[0..2] of Char;
    nOffset: Integer;
    nSize: Integer;
  end;

  TLoginSkinHeader = packed record
    sTitle: string[11];
    nVar: Integer;
    nSize: Integer;
  end;

  pTLoginSkinInfo = ^TLoginSkinInfo;
  TLoginSkinInfo = packed record
    BG_boTransparent: Boolean;
    BG_TransparentColor: LongWord;
    BG_Bitmap: TSkin_Bitmap;
    BG_ImageType: TImageType;
    ServerLIST_Rect: TSkin_Rect;
    IE_Rect: TSkin_Rect;
    Var_boShow: Boolean;
    Var_Pos: TSkin_Pos;
    Var_Color: LongWord;
    Hint_Pos: TSkin_Pos;
    ProgressNow_Rect: TSkin_Rect;
    ProgressNow_Color1: LongWord;
    ProgressNow_Color2: LongWord;
    ProgressAll_Rect: TSkin_Rect;
    ProgressAll_Color1: LongWord;
    ProgressAll_Color2: LongWord;
    ProgressNowHint_Pos: TSkin_Pos;
    ProgressNowHint_Color: LongWord;
    ProgressAllHint_Pos: TSkin_Pos;
    ProgressAllHint_Color: LongWord;
    Start_Pos: TSkin_Pos;
    Start_Bitmap_Idle: TSkin_Bitmap;
    Start_Bitmap_Move: TSkin_Bitmap;
    Start_Bitmap_Down: TSkin_Bitmap;
    Start_Bitmap_Dsbld: TSkin_Bitmap;
    Reg_boShow: Boolean;
    Reg_Pos: TSkin_Pos;
    Reg_Bitmap_Idle: TSkin_Bitmap;
    Reg_Bitmap_Move: TSkin_Bitmap;
    Reg_Bitmap_Down: TSkin_Bitmap;
    Reg_Bitmap_Dsbld: TSkin_Bitmap;
    ChangePass_boShow: Boolean;
    ChangePass_Pos: TSkin_Pos;
    ChangePass_Bitmap_Idle: TSkin_Bitmap;
    ChangePass_Bitmap_Move: TSkin_Bitmap;
    ChangePass_Bitmap_Down: TSkin_Bitmap;
    ChangePass_Bitmap_Dsbld: TSkin_Bitmap;
    LostPass_boShow: Boolean;
    LostPass_Pos: TSkin_Pos;
    LostPass_Bitmap_Idle: TSkin_Bitmap;
    LostPass_Bitmap_Move: TSkin_Bitmap;
    LostPass_Bitmap_Down: TSkin_Bitmap;
    LostPass_Bitmap_Dsbld: TSkin_Bitmap;
    Setup_boShow: Boolean;
    Setup_Pos: TSkin_Pos;
    Setup_Bitmap_Idle: TSkin_Bitmap;
    Setup_Bitmap_Move: TSkin_Bitmap;
    Setup_Bitmap_Down: TSkin_Bitmap;
    Home_boShow: Boolean;
    Home_Pos: TSkin_Pos;
    Home_Bitmap_Idle: TSkin_Bitmap;
    Home_Bitmap_Move: TSkin_Bitmap;
    Home_Bitmap_Down: TSkin_Bitmap;
    Pay_boShow: Boolean;
    Pay_Pos: TSkin_Pos;
    Pay_Bitmap_Idle: TSkin_Bitmap;
    Pay_Bitmap_Move: TSkin_Bitmap;
    Pay_Bitmap_Down: TSkin_Bitmap;
    Exit_boShow: Boolean;
    Exit_Pos: TSkin_Pos;
    Exit_Bitmap_Idle: TSkin_Bitmap;
    Exit_Bitmap_Move: TSkin_Bitmap;
    Exit_Bitmap_Down: TSkin_Bitmap;
    Min_boShow: Boolean;
    Min_Pos: TSkin_Pos;
    Min_Bitmap_Idle: TSkin_Bitmap;
    Min_Bitmap_Move: TSkin_Bitmap;
    Min_Bitmap_Down: TSkin_Bitmap;
    Close_boShow: Boolean;
    Close_Pos: TSkin_Pos;
    Close_Bitmap_Idle: TSkin_Bitmap;
    Close_Bitmap_Move: TSkin_Bitmap;
    Close_Bitmap_Down: TSkin_Bitmap;
    Reserved: array[0..1023] of Byte;
  end;

var
  g_SkinInfo: TLoginSkinInfo;

function HtmlToText(HtmlText: WideString): WideString;
procedure CreateShortCut(FilePath: string; sName: string);

implementation

function HtmlToText(HtmlText: WideString): WideString;
var
  V: OleVariant;
  Document: IHTMLDocument2;
begin
  Result := HtmlText;
  if HtmlText = '' then
    Exit;
  CoInitialize(nil);
  Document := CoHTMLDocument.Create as IHtmlDocument2;
  try
    V := VarArrayCreate([0, 0], varVariant);
    V[0] := HtmlText;
    Document.Write(PSafeArray(TVarData(v).VArray));
    Document.Close;
    Result := Trim(Document.body.outerText);
  finally
    Document := nil;
    CoUninitialize;
  end;
end;

procedure CreateShortCut(FilePath: string; sName: string); //创建快捷方式
var
  tmpObject: IUnknown;
  tmpSLink: IShellLink;
  tmpPFile: IPersistFile;
  PIDL: PItemIDList;
  StartupDirectory: array[0..MAX_PATH] of Char;
  LinkFilename: WideString;
  Name: string;
begin
  try
    tmpObject := CreateComObject(CLSID_ShellLink); //创建建立快捷方式的外壳扩展
    tmpSLink := tmpObject as IShellLink; //取得接口
    tmpPFile := tmpObject as IPersistFile; //用来储存*.lnk文件的接口
    tmpSLink.SetPath(pChar(FilePath)); //设定notepad.exe所在路径
    tmpSLink.SetWorkingDirectory(pChar(ExtractFilePath(FilePath))); //设定工作目录
    SHGetSpecialFolderLocation(0, CSIDL_DESKTOPDIRECTORY, PIDL); //获得桌面的Itemidlist
    SHGetPathFromIDList(PIDL, StartupDirectory); //获得桌面路径
    Name := '\' + sName + '.lnk';
    LinkFilename := StartupDirectory + Name;
    tmpPFile.Save(pWChar(LinkFilename), FALSE); //保存*.lnk文件
  except
  end;
end;

//时间转换为GMT格式

function DateTimeToGMT(const DateTime: TDateTime): string;
begin
  Result := FormatDateTime('ddd, dd mmm yyyy hh:mm:ss', IncHour(DateTime, -8));
  Result := StringReplace(Result, '一月', 'Jan', [rfReplaceAll]);
  Result := StringReplace(Result, '二月', 'Feb', [rfReplaceAll]);
  Result := StringReplace(Result, '三月', 'Mar', [rfReplaceAll]);
  Result := StringReplace(Result, '四月', 'Apr', [rfReplaceAll]);
  Result := StringReplace(Result, '五月', 'May', [rfReplaceAll]);
  Result := StringReplace(Result, '六月', 'Jun', [rfReplaceAll]);
  Result := StringReplace(Result, '七月', 'Jul', [rfReplaceAll]);
  Result := StringReplace(Result, '八月', 'Aug', [rfReplaceAll]);
  Result := StringReplace(Result, '九月', 'Sep', [rfReplaceAll]);
  Result := StringReplace(Result, '十月', 'Oct', [rfReplaceAll]);
  Result := StringReplace(Result, '十一月', 'Nov', [rfReplaceAll]);
  Result := StringReplace(Result, '十二月', 'Dec', [rfReplaceAll]);
  Result := StringReplace(Result, '星期日', 'Sun', [rfReplaceAll]);
  Result := StringReplace(Result, '星期一', 'Mon', [rfReplaceAll]);
  Result := StringReplace(Result, '星期二', 'Tue', [rfReplaceAll]);
  Result := StringReplace(Result, '星期三', 'Wed', [rfReplaceAll]);
  Result := StringReplace(Result, '星期四', 'Thu', [rfReplaceAll]);
  Result := StringReplace(Result, '星期五', 'Fri', [rfReplaceAll]);
  Result := StringReplace(Result, '星期六', 'Sat', [rfReplaceAll]);
  Result := Result + ' GMT';
end;

initialization
  OleInitialize(nil);

finalization
  try
    OleUninitialize;
  except
  end;

end.

