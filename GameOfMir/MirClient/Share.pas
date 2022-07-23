unit Share;

interface

var
  CLIENTUPDATETIME: string = '2022.05.04';


const

  RUNLOGINCODE = 0; //进入游戏状态码,默认为0 测试为 9

  STDCLIENT = 0;
  RMCLIENT = 99;
  CLIENTTYPE = 0; //普通的为0 ,99 为管理客户端

  DEFFONTNAME = '宋体';
  DEFFONTSIZE = 9;

  DEBUG = 0;
  {SWH800 = 0;
  SWH1024 = 1;
  SWH = SWH800;  }

  MAXLEFT2 = 10;
  MAXTOP2 = 10;
  MAXTOP3 = -14;

  BGSURFACECOLOR = 8;

  // mode == other
  DEFSCREENWIDTH = 1024;
  DEFSCREENHEIGHT = 576;
  // mode == 1
  DEFWIDESCREENWIDTH = 1280;
  DEFWIDESCREENHEIGHT = 720;
  // mode == 2
  DEFMAXSCREENWIDTH = 1600;
  DEFMAXSCREENHEIGHT = 900;

  OPERATEHINTWIDTH = 425;
  OPERATEHINTHEIGHT = 32;
  OPERATEHINTX = 335;
  OPERATEHINTY = 474;

  MISSIONHINTWIDTH = 220 + 18;
  MISSIONHINTHEIGHT = 337;
  MISSIONHINTX = -238;
  MISSIONHINTY = 169;

  //MAPSURFACEWIDTH = g_FScreenWidth;
  //MAPSURFACEHEIGHT = g_FScreenHeight;
  //MAPSURFACEHEIGHT = g_FScreenHeight - 150;

  ADDSAYHEIGHT = 16;
  //ADDSAYWHDTH = g_FScreenWidth - 600 - 5;
  ADDSAYCOUNT = 5;

  WINLEFT = 60;
  WINTOP = 60;
  //WINRIGHT = g_FScreenWidth - 60;
  //BOTTOMEDGE = g_FScreenHeight - 60; // Bottom WINBOTTOM

  //MAPDIR = 'Map\'; //地图文件所在目录
  CONFIGFILE = 'Config\%s.ini';

  MAXX = 52;
  MAXY = 40;

 // MAXX = g_FScreenWidth div 20;
 // MAXY = g_FScreenWidth div 20;

  DEFAULTCURSOR = 0; //系统默认光标
  IMAGECURSOR = 1; //图形光标

  USECURSOR = IMAGECURSOR; //使用什么类型的光标

  {  MAXBAGITEMCL = 52;}
  MAXFONT = 8;
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
  g_BitCount : Integer = 16;
  // 屏幕分辨率模式：1 1024 x 768 2 1600 x 900 other 800 x 600
  g_FScreenMode: Byte = 1;
  g_FScreenWidth: Integer = DEFSCREENWIDTH;
  g_FScreenHeight: Integer = DEFSCREENHEIGHT;
  g_FScreenWidthOffset: Integer = 0;
  g_FScreenHeightOffset: Integer = 0;
  g_btMP3Volume: Byte = 70;
  g_btSoundVolume: Byte = 70;
  g_boBGSound: Boolean = True;
  g_boSound: Boolean = True;


Type
  TCursorMode = (cr_None, cr_Buy, cr_Sell, cr_Repair, cr_SelItem, cr_Deal, cr_Srepair);

var
  g_CursorMode: TCursorMode = cr_None;
  TestTick2: LongWord;
  g_CanTab: Boolean = True;

function GetStrengthenText(nMasterLevel, nLevel: Integer): string;

implementation

uses
SysUtils;

function GetStrengthenText(nMasterLevel, nLevel: Integer): string;
begin
  Result := '';
  case nMasterLevel of
    3: begin
      case nLevel of
        0..2: Result := Format('准确 +%d', [nLevel + 1]);
        3..7: Result := Format('生命值上限 +%d', [(nLevel - 2) * 10]);
        8..12: Result := Format('魔法值上限 +%d', [(nLevel - 7) * 10]);
        13..15: Result := Format('敏捷 +%d', [nLevel - 12]);
      end;
    end;
    6: begin
      case nLevel of
        0..4: Result := Format('五行防御 +%d', [nLevel + 1]) + '%';
        5..14: Result := Format('经验加成 +%d', [nLevel - 4]) + '%';
        15..19: Result := Format('五行伤害 +%d', [nLevel - 14]) + '%';
      end;
    end;
    9: begin
      case nLevel of
        0..2:   Result := Format('防御 +%d', [nLevel + 1]) + '%';
        3..5:   Result := Format('魔御 +%d', [nLevel - 2]) + '%';
        6..10:  Result := Format('攻击 +%d', [nLevel - 5]);
        11..15: Result := Format('道术 +%d', [nLevel - 10]);
        16..20: Result := Format('魔法 +%d', [nLevel - 15]);
      end;
    end;
    12: begin
      case nLevel of
        0..2: Result := Format('伤害加成 +%d', [nLevel + 1]) + '%';
        3..11: Result := Format('生命魔法上限 +%d', [nLevel - 1]) + '%';
        12..14: Result := Format('伤害吸收 +%d', [nLevel - 11]) + '%';
      end;
    end;
    15: begin
      case nLevel of
        0..2: Result := Format('致命一击 +%d', [nLevel + 1]) + '%';
        3..23: Result := Format('攻,魔,道 +%d点', [nLevel + 7]);
      end;
    end;
    18: begin
      case nLevel of
        0..5: Result := Format('掉落机率减少 %d0', [nLevel + 4]) + '%';
      end;
    end;
  end;
end;
 {
function GetStrengthenText(nMasterLevel, nLevel: Integer): string;
begin
  Result := '';
  case nMasterLevel of
    3: begin
      case nLevel of
        0, 1: Result := Format('最大生命值增加：%d点', [(nLevel + 1) * 10]);
        2, 3: Result := Format('最大魔法值增加：%d点', [(nLevel - 1) * 10]);
        4: Result := '体力恢复增加：10%';
        5: Result := '魔法恢复增加：10%';
        6: Result := '毒物恢复增加：10%';
      end;
    end;
    6: begin
      case nLevel of
        0: Result := '准确增加：1点';
        1: Result := '敏捷增加：1点';
        2..5: Result := Format('五行防御增加：%d', [nLevel]) + '%';
        6..9: Result := Format('五行伤害增加：%d', [nLevel - 4]) + '%';
      end;
    end;
    9: begin
      case nLevel of
        0..3:   Result := Format('最高防御增加：%d点', [nLevel + 2]);
        4..7:   Result := Format('最高魔御增加：%d点', [nLevel - 2]);
        8..11:  Result := Format('最高攻击增加：%d点', [nLevel - 6]);
        12..15: Result := Format('最高道术增加：%d点', [nLevel - 10]);
        16..19: Result := Format('最高魔法增加：%d点', [nLevel - 14]);
      end;
    end;
    12: begin
      case nLevel of
        0: Result := '魔法躲避增加：10%';
        1: Result := '毒物躲避增加：10%';
        2..4: Result := Format('伤害加成增加：%d', [nLevel - 1]) + '%';
        5..7: Result := Format('伤害吸收增加：%d', [nLevel - 4]) + '%';
      end;
    end;
    15: begin
      case nLevel of
        0..2: Result := Format('致命一击增加：%d', [nLevel + 1]) + '%';
      end;
    end;
    18: begin
      case nLevel of
        0..5: Result := Format('掉落机率减少：%d0', [nLevel + 4]) + '%';
        //6: Result := '永不掉落，不可交易，不可丢弃';
      end;
    end;
  end;
end;     }

end.


