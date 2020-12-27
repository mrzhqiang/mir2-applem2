unit LogShare;

interface
uses
  Windows, Messages, SysUtils;

const
  GS_QUIT = 2000;
  SG_FORMHANDLE = 1000; //服务器HANLD
  SG_STARTNOW = 1001; //正在启动服务器...
  SG_STARTOK = 1002; //启动完成...

  tLogServer = 2;

  ADODBString = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;Persist Security Info=False';
  ADODBSQL =
    'INSERT INTO Log (动作,地图,X坐标,Y坐标,人物名称,物品名称,物品ID,物品数量,交易对像,备注1,备注2,备注3) values (%s,'#39'%s'#39',%s,%s,'#39'%s'#39','#39'%s'#39',%s,%s,'#39'%s'#39','#39'%s'#39','#39'%s'#39','#39'%s'#39')';

type
  TLogClass = record
    sLogName: string[10];
    nLogIdx: Byte;
  end;
var
  sBaseDir: string = '.\BaseDir\';
  sServerName: string = '兰达尔技术';
  sCaption: string = '日志服务器';
  g_dwGameCenterHandle: THandle;
  nServerPort: Integer = 10000;
  g_boTeledata: Boolean = False;

  m_LogList: array[0..12] of TLogClass = (
    (sLogName: '人物死亡'; nLogIdx: 0),
    (sLogName: '金币改变'; nLogIdx: 1),
    (sLogName: '绑金改变'; nLogIdx: 2),
    (sLogName: '点卷改变'; nLogIdx: 3),
    (sLogName: '元宝改变'; nLogIdx: 4),
    (sLogName: '积分改变'; nLogIdx: 5),
    (sLogName: '数量改变'; nLogIdx: 6),
    (sLogName: '增加物品'; nLogIdx: 7),
    (sLogName: '减少物品'; nLogIdx: 8),
    (sLogName: '仓库存取'; nLogIdx: 9),
    (sLogName: '强化改变'; nLogIdx: 10),
    (sLogName: '调整物品'; nLogIdx: 11),
    (sLogName: '声望改变'; nLogIdx: 12)
  );

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
implementation

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tLogServer), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

end.

