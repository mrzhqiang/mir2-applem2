unit Share;

interface

var
  // 客户端更新时间——改为客户端版本号
  CLIENTUPDATETIME: string = 'v2022.1.0';
const
  // 字体及大小
  DEF_FONT_NAME = '宋体';
  DEF_FONT_SIZE = 10;
  // 屏幕颜色位数
  DEF_COLOR_BIT = 32;
  // 屏幕模式：默认屏幕、大屏
//  OLD_SCREEN_MODE = 0;
  DEF_SCREEN_MODE = 0;
  LARGE_SCREEN_MODE = 1;
  // 旧客户端的屏幕分辨率：以此为基础不用重新调整坐标，增加一个适配坐标即可
  // fixme 已废弃
  OLD_SCREEN_WIDTH = 800;
  OLD_SCREEN_HEIGHT = 600;
  // 默认屏幕分辨率
  DEF_SCREEN_WIDTH = 1024;
  DEF_SCREEN_HEIGHT = 768;
  // 大屏幕分辨率
  LARGE_SCREEN_WIDTH = 1600;
  LARGE_SCREEN_HEIGHT = 900;

  // 调试开关——FIXME 需要确定是否有用
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

  DEFAULTCURSOR = 0; //系统默认光标
  IMAGECURSOR = 1; //图形光标

  USECURSOR = IMAGECURSOR; //使用什么类型的光标

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
  // 屏幕色彩位数
  g_BitCount: Integer = DEF_COLOR_BIT;
  // 屏幕分辨率模式
  g_FScreenMode: Byte = DEF_SCREEN_MODE;
  // 屏幕宽、高
  g_FScreenWidth: Integer = DEF_SCREEN_WIDTH;
  g_FScreenHeight: Integer = DEF_SCREEN_HEIGHT;
  // 屏幕中心点
  g_FScreenXOrigin: Integer = 0;
  g_FScreenYOrigin: Integer = 0;
  // 音乐音量
  g_btMP3Volume: Byte = 70;
  // 音效音量
  g_btSoundVolume: Byte = 70;
  // 是否开启音乐
  g_boBGSound: Boolean = True;
  // 是否开启音效
  g_boSound: Boolean = True;

Type
  TCursorMode = (cr_None, cr_Buy, cr_Sell, cr_Repair, cr_SelItem, cr_Deal, cr_Srepair);

var
  g_CursorMode: TCursorMode = cr_None;
  g_CanTab: Boolean = True;

  function GetStrengthenText(nMasterLevel, nLevel: Integer): string;

  // 获取布局的 X 坐标，即相对于场景中心点的左上角 X 坐标
  function getLayoutX(width: Integer): Integer;
  // 获取布局的 Y 坐标，即相对于场景中心点的左上角 Y 坐标
  function getLayoutY(height: Integer): Integer;
  // 获取兼容的 X 坐标，原先是在 800x600 坐标系中的参数，需要切换到大屏时，必须使用兼容坐标
  function getSupportX(x: Integer): Integer;
  // 获取兼容的 Y 坐标，原先是在 800x600 坐标系中的参数，需要切换到大屏时，必须使用兼容坐标
  function getSupportY(y: Integer): Integer;

implementation

uses
  SysUtils;

// 装备强化属性文本
function GetStrengthenText(nMasterLevel, nLevel: Integer): string;
begin
  Result := '';
  case nMasterLevel of
    3:
    begin
      case nLevel of
        0..2: Result := Format('准确 +%d', [nLevel + 1]);
        3..7: Result := Format('生命值上限 +%d', [(nLevel - 2) * 10]);
        8..12: Result := Format('魔法值上限 +%d', [(nLevel - 7) * 10]);
        13..15: Result := Format('敏捷 +%d', [nLevel - 12]);
      end;
    end;
    6:
    begin
      case nLevel of
        0..4: Result := Format('五行防御 +%d', [nLevel + 1]) + '%';
        5..14: Result := Format('经验加成 +%d', [nLevel - 4]) + '%';
        15..19: Result := Format('五行伤害 +%d', [nLevel - 14]) + '%';
      end;
    end;
    9:
    begin
      case nLevel of
        0..2: Result := Format('防御 +%d', [nLevel + 1]) + '%';
        3..5: Result := Format('魔御 +%d', [nLevel - 2]) + '%';
        6..10: Result := Format('攻击 +%d', [nLevel - 5]);
        11..15: Result := Format('道术 +%d', [nLevel - 10]);
        16..20: Result := Format('魔法 +%d', [nLevel - 15]);
      end;
    end;
    12:
    begin
      case nLevel of
        0..2: Result := Format('伤害加成 +%d', [nLevel + 1]) + '%';
        3..11: Result := Format('生命魔法上限 +%d', [nLevel - 1]) + '%';
        12..14: Result := Format('伤害吸收 +%d', [nLevel - 11]) + '%';
      end;
    end;
    15:
    begin
      case nLevel of
        0..2: Result := Format('致命一击 +%d', [nLevel + 1]) + '%';
        3..23: Result := Format('攻,魔,道 +%d点', [nLevel + 7]);
      end;
    end;
    18:
    begin
      case nLevel of
        0..5: Result := Format('掉落机率减少 %d0', [nLevel + 4]) + '%';
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
