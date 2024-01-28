unit Share;

interface

var
  // �ͻ��˸���ʱ�䡪����Ϊ�ͻ��˰汾��
  CLIENTUPDATETIME: string = 'v2022.1.0';
const
  // ���弰��С
  DEF_FONT_NAME = '����';
  DEF_FONT_SIZE = 10;
  // ��Ļ��ɫλ��
  DEF_COLOR_BIT = 32;
  // ��Ļģʽ��Ĭ����Ļ������
//  OLD_SCREEN_MODE = 0;
  DEF_SCREEN_MODE = 0;
  LARGE_SCREEN_MODE = 1;
  // �ɿͻ��˵���Ļ�ֱ��ʣ��Դ�Ϊ�����������µ������꣬����һ���������꼴��
  OLD_SCREEN_WIDTH = 800;
  OLD_SCREEN_HEIGHT = 600;
  // Ĭ����Ļ�ֱ���
  DEF_SCREEN_WIDTH = 1024;
  DEF_SCREEN_HEIGHT = 768;
  // ����Ļ�ֱ���
  LARGE_SCREEN_WIDTH = 1600;
  LARGE_SCREEN_HEIGHT = 900;

  // ���Կ��ء���FIXME ��Ҫȷ���Ƿ�����
  DEBUG = 0;

  // 1024/2/48 = 10..32
  // 768/2/32 = 12
  // 1600/2/48 = 16..32
  // 900/2/32 = 14..2
  MAXLEFT2 = 16;
  MAXTOP2 = 14;
  MAXTOP3 = -16;

  BGSURFACECOLOR = 8;

  OPERATEHINTWIDTH = 425;
  OPERATEHINTHEIGHT = 32;
  OPERATEHINTX = 335;
  OPERATEHINTY = 474;

  MISSIONHINTWIDTH = 220 + 18;
  MISSIONHINTHEIGHT = 337;
  MISSIONHINTX = -238;
  MISSIONHINTY = 169;

  ADDSAYHEIGHT = 16;
  ADDSAYCOUNT = 5;

  MAXX = 52;
  MAXY = 40;

  DEFAULTCURSOR = 0; //ϵͳĬ�Ϲ��
  IMAGECURSOR = 1; //ͼ�ι��

  USECURSOR = IMAGECURSOR; //ʹ��ʲô���͵Ĺ��

  ENEMYCOLOR = 69;
  ALLYCOLOR = 180;

  crMyNone = 1;
  crMyAttack = 2;
  crMyDialog = 3;
  crMyBuy = 4;
  crMySell = 5;
  crMyRepair = 6;
  crMySelItem = 7;
  crMyDeal = 8;
  crOpenBox = 9;
  crSrepair = 10;

var
  // ��Ļɫ��λ��
  g_BitCount: Integer = DEF_COLOR_BIT;
  // ��Ļ�ֱ���ģʽ
  g_FScreenMode: Byte = DEF_SCREEN_MODE;
  // ��Ļ����
  g_FScreenWidth: Integer = DEF_SCREEN_WIDTH;
  g_FScreenHeight: Integer = DEF_SCREEN_HEIGHT;
  // ��Ļ���ĵ�
  g_FScreenXOrigin: Integer = 0;
  g_FScreenYOrigin: Integer = 0;
  // ��������
  g_btMP3Volume: Byte = 70;
  // ��Ч����
  g_btSoundVolume: Byte = 70;
  // �Ƿ�������
  g_boBGSound: Boolean = True;
  // �Ƿ�����Ч
  g_boSound: Boolean = True;

Type
  TCursorMode = (cr_None, cr_Buy, cr_Sell, cr_Repair, cr_SelItem, cr_Deal, cr_Srepair);

var
  g_CursorMode: TCursorMode = cr_None;
  g_CanTab: Boolean = True;

  function GetStrengthenText(nMasterLevel, nLevel: Integer): string;

  // ��ȡ���ֵ� X ���꣬������ڳ������ĵ�����Ͻ� X ����
  function getLayoutX(width: Integer): Integer;
  // ��ȡ���ֵ� Y ���꣬������ڳ������ĵ�����Ͻ� Y ����
  function getLayoutY(height: Integer): Integer;
  // ��ȡ���ݵ� X ���꣬ԭ������ 800x600 ����ϵ�еĲ�������Ҫ�л�������ʱ������ʹ�ü�������
  function getSupportX(x: Integer): Integer;
  // ��ȡ���ݵ� Y ���꣬ԭ������ 800x600 ����ϵ�еĲ�������Ҫ�л�������ʱ������ʹ�ü�������
  function getSupportY(y: Integer): Integer;

implementation

uses
  SysUtils;

// װ��ǿ�������ı�
function GetStrengthenText(nMasterLevel, nLevel: Integer): string;
begin
  Result := '';
  case nMasterLevel of
    3:
    begin
      case nLevel of
        0..2: Result := Format('׼ȷ +%d', [nLevel + 1]);
        3..7: Result := Format('����ֵ���� +%d', [(nLevel - 2) * 10]);
        8..12: Result := Format('ħ��ֵ���� +%d', [(nLevel - 7) * 10]);
        13..15: Result := Format('���� +%d', [nLevel - 12]);
      end;
    end;
    6:
    begin
      case nLevel of
        0..4: Result := Format('���з��� +%d', [nLevel + 1]) + '%';
        5..14: Result := Format('����ӳ� +%d', [nLevel - 4]) + '%';
        15..19: Result := Format('�����˺� +%d', [nLevel - 14]) + '%';
      end;
    end;
    9:
    begin
      case nLevel of
        0..2: Result := Format('���� +%d', [nLevel + 1]) + '%';
        3..5: Result := Format('ħ�� +%d', [nLevel - 2]) + '%';
        6..10: Result := Format('���� +%d', [nLevel - 5]);
        11..15: Result := Format('���� +%d', [nLevel - 10]);
        16..20: Result := Format('ħ�� +%d', [nLevel - 15]);
      end;
    end;
    12:
    begin
      case nLevel of
        0..2: Result := Format('�˺����� +%d', [nLevel + 1]) + '%';
        3..11: Result := Format('����ħ������ +%d', [nLevel - 1]) + '%';
        12..14: Result := Format('�˺����� +%d', [nLevel - 11]) + '%';
      end;
    end;
    15:
    begin
      case nLevel of
        0..2: Result := Format('����һ�� +%d', [nLevel + 1]) + '%';
        3..23: Result := Format('��,ħ,�� +%d��', [nLevel + 7]);
      end;
    end;
    18:
    begin
      case nLevel of
        0..5: Result := Format('������ʼ��� %d0', [nLevel + 4]) + '%';
      end;
    end;
  end;
end;

function getLayoutX(width: Integer): Integer;
begin
    Result := g_FScreenXOrigin - width div 2;
end;

function getLayoutY(height: Integer): Integer;
begin
    Result := g_FScreenYOrigin - height div 2;
end;

function getSupportX(x: Integer): Integer;
begin
    Result := getLayoutX(OLD_SCREEN_WIDTH) + x;
end;

function getSupportY(y: Integer): Integer;
begin
    Result := getLayoutY(OLD_SCREEN_HEIGHT) + y;
end;

end.
