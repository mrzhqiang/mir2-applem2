unit Actor;

interface

uses
  Windows, Classes, Graphics, SysUtils, StrUtils, Forms,
  Grobal2, HGETextures, CliUtil, magiceff, Wil, ClFunc, SDK;

const
  MAXACTORSOUND = 3;
  CMMX = 150;
  CMMY = 200;

  HUMANFRAME = 600;
  HUMCBOANFRAME = 2000;
  HUMHORSEANFRAME = 320;
  RIDEFRAME = 600;
  HUMHAIRANFRAME = 920;
  MONFRAME = 280;
  EXPMONFRAME = 360;
  SCULMONFRAME = 440;
  ZOMBIFRAME = 430;
  MERCHANTFRAME = 60;
  MAXSAY = 5;
  //   MON1_FRAME =
  //   MON2_FRAME =

   RUN_MINHEALTH = 10;//低于这个血量只能走动
   DEFSPELLFRAME = 10; //魔法最大浈
  FIREHIT_READYFRAME = 6; //堪拳搬 矫傈 橇贰烙
  MAGBUBBLEBASE = 30; //魔法盾效果图位置
  MAGBUBBLESTRUCKBASE = 33; //被攻击时魔法盾效果图位置
  MAXWPEFFECTFRAME = 5;
  WPEFFECTBASE = 3750;
  EFFECTBASE = 0;

type
  TNPCMissionStatus = (NPCMS_Accept, NPCMS_Complete, NPCMS_Atelic, NPCMS_None);

  TActionInfo = packed record
    start   :Word;//0x14              // 开始帧
    frame   :Word;//0x16              // 帧数
    skip    :Word;//0x18              // 跳过的帧数
    ftime   :Word;//0x1A              // 每帧的延迟时间（毫秒）
    usetick :Word;//0x1C              // 荤侩平, 捞悼 悼累俊父 荤侩凳
  end;
  pTActionInfo = ^TActionInfo;

//玩家的动作定义
  THumanAction = packed record
    ActStand: TActionInfo; //1
    ActWalk: TActionInfo; //8
    ActRun: TActionInfo; //8
    ActLeap: TActionInfo; //8
    ActRushLeft: TActionInfo;
    ActRushRight: TActionInfo;
    ActWarMode: TActionInfo; //1
    ActHit: TActionInfo; //6
    ActHorseHit: TActionInfo;
    ActHeavyHit: TActionInfo; //6
    ActBigHit: TActionInfo; //6
    ActFireHitReady: TActionInfo; //6
    ActSpell: TActionInfo; //6
    ActSitdown: TActionInfo; //1
    ActStruck: TActionInfo; //3
    ActHorseStruck: TActionInfo;
    ActDie: TActionInfo; //4
    Act110: TActionInfo;
    Act111: TActionInfo;
    Act112: TActionInfo;
    Act113: TActionInfo;
    Act114: TActionInfo; //6
    Act115: TActionInfo; //6
    Act116: TActionInfo; //6
    Act117: TActionInfo; //6
    Act118: TActionInfo; //6
    Act119: TActionInfo; //6
    Act120: TActionInfo; //6
    Act121: TActionInfo; //6
    Act122: TActionInfo; //6
    Act123: TActionInfo; //6
    Act124: TActionInfo; //6
  end;
  pTHumanAction = ^THumanAction;
  TMonsterAction = packed record
    ActStand: TActionInfo; //1
    ActWalk: TActionInfo; //8
    ActAttack: TActionInfo; //6 0x14 - 0x1C
    ActCritical: TActionInfo; //6 0x20 -
    ActStruck: TActionInfo; //3
    ActDie: TActionInfo; //4
    ActDeath: TActionInfo;
    ActAttack2: TActionInfo;
    ActAttack3: TActionInfo;
    ActAttack4: TActionInfo;
    ActAttack5: TActionInfo;
  end;
  pTMonsterAction = ^TMonsterAction;
const
   //人类动作定义
   //每个人物每个级别每个性别共600幅图
   //设级别=L，性别=S，则开始帧=L*600+600*S

   //Start:该动作在这组外观下的开始帧
   //frame:该动作需要的帧数
   //skip:跳过的帧数
   HA: THumanAction = (//开始帧       有效帧     跳过帧    每帧延迟
    ActStand: (start: 0; frame: 4; skip: 4; ftime: 200; usetick: 0);
    ActWalk: (start: 64; frame: 6; skip: 2; ftime: 90; usetick: 2);
    ActRun: (start: 128; frame: 6; skip: 2; ftime: 120; usetick: 3);
    ActLeap: (start: 880; frame: 10; skip: 0; ftime: 120; usetick: 3);
    ActRushLeft: (start: 128; frame: 3; skip: 5; ftime: 120; usetick: 3);
    ActRushRight: (start: 131; frame: 3; skip: 5; ftime: 120; usetick: 3);
    ActWarMode: (start: 192; frame: 1; skip: 0; ftime: 200; usetick: 0);
    //ActHit:    (start: 200;    frame: 5;  skip: 3;  ftime: 140;  usetick: 0);
    ActHit: (start: 200; frame: 6; skip: 2; ftime: 85; usetick: 0);
    ActHorseHit: (start: 256; frame: 6; skip: 2; ftime: 85; usetick: 0);
    ActHeavyHit: (start: 264; frame: 6; skip: 2; ftime: 90; usetick: 0);
    ActBigHit: (start: 328; frame: 8; skip: 0; ftime: 70; usetick: 0);
    ActFireHitReady: (start: 192; frame: 6; skip: 4; ftime: 70; usetick: 0);
    ActSpell: (start: 392; frame: 6; skip: 2; ftime: 60; usetick: 0);
    ActSitdown: (start: 456; frame: 2; skip: 0; ftime: 300; usetick: 0);
    ActStruck: (start: 472; frame: 3; skip: 5; ftime: 70; usetick: 0);
    ActHorseStruck: (start: 192; frame: 3; skip: 5; ftime: 70; usetick: 0);
    ActDie: (start: 536; frame: 4; skip: 4; ftime: 120; usetick: 0);
    Act110: (start: 160; frame: 15; skip: 5; ftime: 60; usetick: 0);
    Act111: (start: 80; frame: 8; skip: 2; ftime: 80; usetick: 0);
    Act112: (start: 316; frame: 10; skip: 0; ftime: 60; usetick: 0);
    Act113: (start: 560; frame: 10; skip: 0; ftime: 60; usetick: 0);
    Act114: (start: 1040; frame: 13; skip: 7; ftime: 60; usetick: 0);
    Act115: (start: 640; frame: 6; skip: 4; ftime: 100; usetick: 0);
    Act116: (start: 1280; frame: 6; skip: 4; ftime: 100; usetick: 0);
    Act117: (start: 800; frame: 8; skip: 2; ftime: 75; usetick: 0);
    Act118: (start: 1200; frame: 6; skip: 4; ftime: 120; usetick: 0);
    Act119: (start: 1440; frame: 12; skip: 8; ftime: 60; usetick: 0);
    Act120: (start: 1600; frame: 12; skip: 8; ftime: 75; usetick: 0);
    Act121: (start: 1760; frame: 14; skip: 6; ftime: 60; usetick: 0);
    Act122: (start: 0; frame: 6; skip: 4; ftime: 85; usetick: 0);
    Act123: (start: 720; frame: 6; skip: 4; ftime: 60; usetick: 0);
    Act124: (start: 400; frame: 13; skip: 7; ftime: 60; usetick: 0);
    );
  MA9: TMonsterAction = (//4C03D4
    ActStand: (start: 0; frame: 1; skip: 7; ftime: 200; usetick: 0);
    ActWalk: (start: 64; frame: 6; skip: 2; ftime: 120; usetick: 3);
    ActAttack: (start: 64; frame: 6; skip: 2; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 64; frame: 6; skip: 2; ftime: 100; usetick: 0);
    ActDie: (start: 0; frame: 1; skip: 7; ftime: 140; usetick: 0);
    ActDeath: (start: 0; frame: 1; skip: 7; ftime: 0; usetick: 0);
    );
  MA10: TMonsterAction = (//(8Frame) 带刀卫士
           //每个动作8帧    //从这里可以推测出怪物有几种？//这里是280的
    ActStand: (start: 0; frame: 4; skip: 4; ftime: 200; usetick: 0);
    ActWalk: (start: 64; frame: 6; skip: 2; ftime: 120; usetick: 3);
    ActAttack: (start: 128; frame: 4; skip: 4; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 192; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 208; frame: 4; skip: 4; ftime: 140; usetick: 0);
    ActDeath: (start: 272; frame: 1; skip: 0; ftime: 0; usetick: 0);
    );
  MA11: TMonsterAction = (//荤娇(10Frame楼府)//每个动作10帧 //280,(360的),440,430,,
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 0; usetick: 0);
    );
  MA12: TMonsterAction = (//版厚捍, 锭府绰 加档 狐福促.//每个动作8帧，每个动作8个方向，共7种动作
    ActStand: (start: 0; frame: 4; skip: 4; ftime: 200; usetick: 0);
    ActWalk: (start: 64; frame: 6; skip: 2; ftime: 120; usetick: 3);
    ActAttack: (start: 128; frame: 6; skip: 2; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 192; frame: 2; skip: 0; ftime: 150; usetick: 0);
    ActDie: (start: 208; frame: 4; skip: 4; ftime: 160; usetick: 0);
    ActDeath: (start: 272; frame: 1; skip: 0; ftime: 0; usetick: 0);
    );
  MA13: TMonsterAction = (// mon2.wil中的食人花
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
        //打开mon2.wil可以看到食人花,actstand是食人花站立状态
    ActWalk: (start: 10; frame: 8; skip: 2; ftime: 160; usetick: 0); //殿厘...
        //actwalk实际上是食人花站出来或消隐的效果注意到花尾的泥土实际一些objects.wil里面也有泥土tiles
         //石墓尸王钻出来时的地图效果，，食人花的效果跟暗龙相似，不知道暗龙的动作类型是不是也属于ma13
    ActAttack: (start: 30; frame: 6; skip: 4; ftime: 120; usetick: 0);
        //actattack从30开始是从各个方位攻击的效果
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
        //actcritical这个动作略去
    ActStruck: (start: 110; frame: 2; skip: 0; ftime: 100; usetick: 0);
        //受伤110开始，，
    ActDie: (start: 130; frame: 10; skip: 0; ftime: 120; usetick: 0);
        //130开始死亡效果
    ActDeath: (start: 20; frame: 9; skip: 0; ftime: 150; usetick: 0); //见澜..
        //20开始是食人花消隐的效果也是它死亡效果所以在这重用，，只有9帧最后一帧略去
    );
   MA14: TMonsterAction = (  //秦榜 坷付 mon3里面的骷髅战士,,分析方法同ma13
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 340; frame: 10; skip: 0; ftime: 100; usetick: 0);
    //归榜牢版快(家券)
    );
   MA15: TMonsterAction = (  //沃玛战土??新问题：源程序中对怪物的分类逻辑是不是就是mon*.wil的分类逻辑
        //又注意到沃玛战士的五器没有,它带的可是海魂，，难道它也跟hum.wil一样要跟weapon.wil挂钩才能钩成完整的形象?
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
        //die跟death有什么区别啊???一个是死亡开始，，一个是在地面上的残骸??但是按这样说下面的逻辑不对啊!!
    ActDeath: (start: 1; frame: 1; skip: 0; ftime: 100; usetick: 0);
    );
   MA16: TMonsterAction = (  //啊胶筋绰 备单扁  mon5里面的电僵尸？？代表可移动的魔法攻击动作的怪物一类??
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 4; skip: 6; ftime: 160; usetick: 0);
    ActDeath: (start: 0; frame: 1; skip: 0; ftime: 160; usetick: 0);
    );
   MA17: TMonsterAction = (  //官迭波府绰 各  mon6中的和尚僵王（和石墓尸王共用一形象）
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 60; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  MA19: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  MA20: TMonsterAction = (//磷菌促 混酒唱绰 粱厚)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActDeath: (start: 340; frame: 10; skip: 0; ftime: 170; usetick: 0);
    //促矫 混酒唱扁
    );
  MA21: TMonsterAction = (//国笼
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0); //
    ActAttack: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    //国 惯荤
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 20; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 30; frame: 10; skip: 0; ftime: 160; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0); //
    );
  MA22: TMonsterAction = (//籍惑阁胶磐(堪家措厘,堪家厘焙)
    ActStand: (start: 80; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 240; frame: 6; skip: 4; ftime: 100; usetick: 0); //
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 320; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 340; frame: 10; skip: 0; ftime: 160; usetick: 0);
    ActDeath: (start: 0; frame: 6; skip: 4; ftime: 170; usetick: 0);
    //籍惑踌澜
    );
  MA23: TMonsterAction = (//林付空
    ActStand: (start: 20; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 100; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 180; frame: 6; skip: 4; ftime: 100; usetick: 0); //
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 260; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 280; frame: 10; skip: 0; ftime: 160; usetick: 0);
    ActDeath: (start: 0; frame: 20; skip: 0; ftime: 100; usetick: 0);
    //籍惑踌澜
    );
   MA24: TMonsterAction = (  // (攻击) mon14中的蝎蛇??通过以下的分析好像又不是?
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 240; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 320; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 340; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 420; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  {
MA25: TMonsterAction = (  //瘤匙空
    ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
    ActWalk:   (start: 70;     frame: 10; skip: 0;  ftime: 200;  usetick: 3); //殿厘
    ActAttack: (start: 20;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0); //流立傍拜
    ActCritical:(start: 10;    frame: 6;  skip: 4;  ftime: 120;  usetick: 0); //刀魔傍拜(盔芭府)
    ActStruck: (start: 50;     frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
    ActDie:    (start: 60;     frame: 10; skip: 0;  ftime: 200;  usetick: 0);
    ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 140;  usetick: 0); //
  );
  }
  MA25: TMonsterAction = (//4C080C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 70; frame: 10; skip: 0; ftime: 200; usetick: 3);
    ActAttack: (start: 20; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 50; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 60; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 80; frame: 10; skip: 0; ftime: 200; usetick: 3);
    );

  MA26: TMonsterAction = (//己巩,
    ActStand: (start: 0; frame: 1; skip: 7; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 160; usetick: 0); //殿厘...
    ActAttack: (start: 56; frame: 6; skip: 2; ftime: 500; usetick: 0); //凯扁
    ActCritical: (start: 64; frame: 6; skip: 2; ftime: 500; usetick: 0); //摧扁
    ActStruck: (start: 0; frame: 4; skip: 4; ftime: 100; usetick: 0);
    ActDie: (start: 24; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 150; usetick: 0); //见澜..
    );
  MA27: TMonsterAction = (//己寒
    ActStand: (start: 0; frame: 1; skip: 7; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 160; usetick: 0); //殿厘...
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 250; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 250; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 0; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 150; usetick: 0); //见澜..
    );
  MA28: TMonsterAction = (//脚荐 (函脚 傈)
    ActStand: (start: 80; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 0; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 0; frame: 10; skip: 0; ftime: 100; usetick: 0); //殿厘..
    );
  MA29: TMonsterAction = (//脚荐 (函脚 饶)
    ActStand: (start: 80; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 240; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActStruck: (start: 320; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 340; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 0; frame: 10; skip: 0; ftime: 100; usetick: 0); //殿厘..
    );
  MA30: TMonsterAction = (//4C0974
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 10; skip: 0; ftime: 200; usetick: 3);
    ActAttack: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 20; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 30; frame: 20; skip: 0; ftime: 150; usetick: 0);
    ActDeath: (start: 0; frame: 10; skip: 0; ftime: 200; usetick: 3);
    );
  MA31: TMonsterAction = (//4C09BC
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 10; skip: 0; ftime: 200; usetick: 3);
    ActAttack: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 0; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 0; frame: 2; skip: 8; ftime: 100; usetick: 0);
    ActDie: (start: 20; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 0; frame: 10; skip: 0; ftime: 200; usetick: 3);
    );

  MA32: TMonsterAction = (//4C0A04
    ActStand: (start: 0; frame: 1; skip: 9; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 6; skip: 4; ftime: 200; usetick: 3);
    ActAttack: (start: 0; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 0; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 0; frame: 2; skip: 8; ftime: 100; usetick: 0);
    ActDie: (start: 80; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActDeath: (start: 80; frame: 10; skip: 0; ftime: 200; usetick: 3);
    );

  MA33: TMonsterAction = (//4C0A4C
             //开始帧    有效帧    跳过帧   每帧延迟
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    //actstand是站立状态
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 200; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    //actattack从30开始是从各个方位攻击的效果
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    );

  MA34: TMonsterAction = (//4C0A94
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 200; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 320; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 400; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 420; frame: 20; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 420; frame: 20; skip: 0; ftime: 200; usetick: 0);
    );

  MA35: TMonsterAction = (//4C0ADC
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 30; frame: 10; skip: 0; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA36: TMonsterAction = (//4C0B24
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 30; frame: 20; skip: 0; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA37: TMonsterAction = (//4C0B6C
    ActStand: (start: 30; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 30; frame: 4; skip: 6; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA38: TMonsterAction = (//4C0BB4
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 80; frame: 6; skip: 4; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA39: TMonsterAction = (//4C0BFC
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 300; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 10; frame: 6; skip: 4; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 20; frame: 2; skip: 0; ftime: 150; usetick: 0);
    ActDie: (start: 30; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA40: TMonsterAction = (//4C0C44
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 250; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 210; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 110; usetick: 0);
    ActCritical: (start: 580; frame: 20; skip: 0; ftime: 135; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 120; usetick: 0);
    ActDie: (start: 260; frame: 20; skip: 0; ftime: 130; usetick: 0);
    ActDeath: (start: 260; frame: 20; skip: 0; ftime: 130; usetick: 0);
    );

  MA41: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA42: TMonsterAction = (//4C0CD4
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 10; frame: 8; skip: 2; ftime: 160; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 30; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 30; frame: 10; skip: 0; ftime: 150; usetick: 0);
    );

  MA43: TMonsterAction = (//4C0D1C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 0);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 0);
    ActCritical: (start: 160; frame: 6; skip: 4; ftime: 160; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 150; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 340; frame: 10; skip: 0; ftime: 100; usetick: 0);
    );

  MA44: TMonsterAction = (//4C0D64
    ActStand: (start: 0; frame: 10; skip: 0; ftime: 300; usetick: 0);
    ActWalk: (start: 10; frame: 6; skip: 4; ftime: 150; usetick: 0);
    ActAttack: (start: 20; frame: 6; skip: 4; ftime: 150; usetick: 0);
    ActCritical: (start: 40; frame: 10; skip: 0; ftime: 150; usetick: 0);
    ActStruck: (start: 40; frame: 2; skip: 8; ftime: 150; usetick: 0);
    ActDie: (start: 30; frame: 6; skip: 4; ftime: 150; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );

  MA45: TMonsterAction = (//4C0DAC
    ActStand: (start: 0; frame: 10; skip: 0; ftime: 300; usetick: 0);
    ActWalk: (start: 0; frame: 10; skip: 0; ftime: 300; usetick: 0);
    ActAttack: (start: 10; frame: 10; skip: 0; ftime: 300; usetick: 0);
    ActCritical: (start: 10; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 300; usetick: 0);
    ActDie: (start: 0; frame: 1; skip: 9; ftime: 300; usetick: 0);
    ActDeath: (start: 0; frame: 1; skip: 9; ftime: 300; usetick: 0);
    );

  MA46: TMonsterAction = (//4C0DF4
    ActStand: (start: 0; frame: 20; skip: 0; ftime: 100; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA47: TMonsterAction = (//4C0A4C 嗜血教主
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 200; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 260; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 524; frame: 6; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 524; frame: 6; skip: 0; ftime: 200; usetick: 0);
    );
  MA48: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 12; skip: 0; ftime: 180; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA49: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 400; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA50: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 6; skip: 4; ftime: 300; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA51: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 8; skip: 2; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA52: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 20; skip: 0; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA53: TMonsterAction = (//4C0974
    ActStand: (start: 0; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 200; usetick: 3);
    ActAttack: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 44; frame: 6; skip: 0; ftime: 40; usetick: 0);
    ActDie: (start: 50; frame: 20; skip: 0; ftime: 70; usetick: 0);
    ActDeath: (start: 0; frame: 10; skip: 0; ftime: 200; usetick: 3);
    );
  MA54: TMonsterAction = (//4C0A4C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 340; frame: 8; skip: 2; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 80; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    );
  MA55: TMonsterAction = (//4C0A4C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 340; frame: 10; skip: 0; ftime: 72; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 80; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    );
  MA56: TMonsterAction = (//籍惑阁胶磐(堪家措厘,堪家厘焙)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0); //
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 160; usetick: 0);
    ActDeath: (start: 420; frame: 6; skip: 4; ftime: 170; usetick: 0);
    //籍惑踌澜
    );
  MA57: TMonsterAction = (//4C0A4C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 340; frame: 7; skip: 3; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 80; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    );
  MA58: TMonsterAction = (//籍惑阁胶磐(堪家措厘,堪家厘焙)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0); //
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 160; usetick: 0);
    ActDeath: (start: 420; frame: 4; skip: 6; ftime: 170; usetick: 0);
    //籍惑踌澜
    );
  MA59: TMonsterAction = (//4C0A4C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 3);
    ActAttack: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 80; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    );
  MA60: TMonsterAction = (//4C0A4C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 340; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 80; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 200; usetick: 0);
    );
  MA61: TMonsterAction = (//4C0A4C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 3);
    ActAttack: (start: 160; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 80; usetick: 0);
    ActDie: (start: 260; frame: 9; skip: 1; ftime: 200; usetick: 0);
    ActDeath: (start: 260; frame: 9; skip: 1; ftime: 200; usetick: 0);
    );
  MA62: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0); //
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 160; usetick: 0);
    ActDeath: (start: 660; frame: 10; skip: 0; ftime: 80; usetick: 0);
    //籍惑踌澜
    );
  MA63: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0); //
    ActCritical: (start: 420; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 160; usetick: 0);
    ActDeath: (start: 664; frame: 6; skip: 4; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA64: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 7; skip: 3; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  MA65: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 9; skip: 1; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  MA66: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 12; skip: 0; ftime: 120; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA67: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 120; usetick: 0);
    ActWalk: (start: 0; frame: 4; skip: 6; ftime: 120; usetick: 0);
    ActAttack: (start: 0; frame: 4; skip: 6; ftime: 120; usetick: 0);
    ActCritical: (start: 0; frame: 4; skip: 6; ftime: 120; usetick: 0);
    ActStruck: (start: 0; frame: 4; skip: 6; ftime: 120; usetick: 0);
    ActDie: (start: 0; frame: 4; skip: 6; ftime: 120; usetick: 0);
    ActDeath: (start: 0; frame: 4; skip: 6; ftime: 120; usetick: 0);
    );
  MA68: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 2; skip: 0; ftime: 120; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA69: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA70: TMonsterAction = (//4C0C8C
    ActStand: (start: 0; frame: 2; skip: 8; ftime: 120; usetick: 0);
    ActWalk: (start: 0; frame: 2; skip: 8; ftime: 120; usetick: 0);
    ActAttack: (start: 0; frame: 2; skip: 8; ftime: 120; usetick: 0);
    ActCritical: (start: 0; frame: 2; skip: 8; ftime: 120; usetick: 0);
    ActStruck: (start: 0; frame: 2; skip: 8; ftime: 120; usetick: 0);
    ActDie: (start: 0; frame: 2; skip: 8; ftime: 120; usetick: 0);
    ActDeath: (start: 0; frame: 2; skip: 8; ftime: 120; usetick: 0);
    );
  MA71: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 8; skip: 2; ftime: 140; usetick: 0); //
    ActAttack: (start: 160; frame: 7; skip: 3; ftime: 100; usetick: 0); //
    ActCritical: (start: 420; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 520; frame: 20; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 520; frame: 20; skip: 0; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA72: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 8; skip: 2; ftime: 140; usetick: 0); //
    ActAttack: (start: 160; frame: 7; skip: 3; ftime: 100; usetick: 0); //
    ActCritical: (start: 350; frame: 7; skip: 3; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 270; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 270; frame: 10; skip: 0; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA73: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 140; usetick: 0); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0); //
    ActCritical: (start: 340; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA74: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 140; usetick: 0); //
    ActAttack: (start: 160; frame: 10; skip: 0; ftime: 60; usetick: 0); //
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA75: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 8; skip: 2; ftime: 120; usetick: 0); //
    ActAttack: (start: 240; frame: 6; skip: 4; ftime: 80; usetick: 0); //
    ActCritical: (start: 240; frame: 6; skip: 4; ftime: 80; usetick: 0);
    ActStruck: (start: 160; frame: 3; skip: 7; ftime: 100; usetick: 0);
    ActDie: (start: 320; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActDeath: (start: 320; frame: 6; skip: 4; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA76: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 140; usetick: 0); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 80; usetick: 0); //
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 8; skip: 2; ftime: 120; usetick: 0);
    ActDeath: (start: 260; frame: 8; skip: 2; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA77: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 140; usetick: 0); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 8; skip: 2; ftime: 120; usetick: 0);
    ActDeath: (start: 260; frame: 8; skip: 2; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA78: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 140; usetick: 0); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActCritical: (start: 340; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 8; skip: 2; ftime: 120; usetick: 0);
    ActDeath: (start: 260; frame: 8; skip: 2; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA79: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 140; usetick: 0); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActCritical: (start: 340; frame: 7; skip: 3; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 8; skip: 2; ftime: 120; usetick: 0);
    ActDeath: (start: 260; frame: 8; skip: 2; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA80: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 140; usetick: 0); //
    ActAttack: (start: 10; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActCritical: (start: 40; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActStruck: (start: 20; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 30; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 30; frame: 10; skip: 0; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA81: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 140; usetick: 0); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 80; usetick: 0); //
    ActCritical: (start: 420; frame: 20; skip: 0; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 20; skip: 0; ftime: 60; usetick: 0);
    ActDeath: (start: 260; frame: 20; skip: 0; ftime: 60; usetick: 0);
    //籍惑踌澜
    );
  MA82: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActCritical: (start: 340; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA83: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 120; usetick: 0);
    ActAttack2: (start: 420; frame: 10; skip: 0; ftime: 72; usetick: 0);
    ActAttack3: (start: 500; frame: 7; skip: 3; ftime: 110; usetick: 0);
    ActAttack4: (start: 580; frame: 7; skip: 3; ftime: 110; usetick: 0);
    //籍惑踌澜
    );
  MA84: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActCritical: (start: 340; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 8; skip: 2; ftime: 120; usetick: 0);
    ActDeath: (start: 260; frame: 8; skip: 2; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA85: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActCritical: (start: 340; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 7; ftime: 100; usetick: 0);
    ActDie: (start: 320; frame: 4; skip: 6; ftime: 120; usetick: 0);
    ActDeath: (start: 320; frame: 4; skip: 6; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA86: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 8; skip: 2; ftime: 80; usetick: 0); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActCritical: (start: 340; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 270; frame: 5; skip: 5; ftime: 100; usetick: 0);
    ActDeath: (start: 270; frame: 5; skip: 5; ftime: 100; usetick: 0);
    //籍惑踌澜
    );
  MA87: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActAttack: (start: 160; frame: 10; skip: 0; ftime: 60; usetick: 0); //
    ActCritical: (start: 340; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 7; ftime: 100; usetick: 0);
    ActDie: (start: 320; frame: 4; skip: 6; ftime: 120; usetick: 0);
    ActDeath: (start: 320; frame: 4; skip: 6; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA88: TMonsterAction = (
    ActStand: (start: 0; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 0); //
    ActAttack: (start: 400; frame: 5; skip: 5; ftime: 120; usetick: 0); //
    ActCritical: (start: 160; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 7; ftime: 100; usetick: 0);
    ActDie: (start: 320; frame: 9; skip: 1; ftime: 100; usetick: 0);
    ActDeath: (start: 320; frame: 9; skip: 1; ftime: 100; usetick: 0);
    ActAttack2: (start: 480; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActAttack3: (start: 560; frame: 5; skip: 5; ftime: 120; usetick: 0);
    ActAttack4: (start: 640; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActAttack5: (start: 720; frame: 5; skip: 5; ftime: 120; usetick: 0);
    //籍惑踌澜
    );
  MA89: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0); //
    ActAttack2: (start: 420; frame: 10; skip: 0; ftime: 100; usetick: 0);
    );
  MA90: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0); //
    ActAttack2: (start: 420; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActAttack3: (start: 500; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActAttack4: (start: 580; frame: 8; skip: 2; ftime: 100; usetick: 0);
    );
  MA91: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 8; skip: 2; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  MA92: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 8; skip: 2; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  MA93: TMonsterAction = ( //雷炎蛛王 200808012
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 8; skip: 2; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    ActAttack2: (start: 420; frame: 8; skip: 2; ftime: 100; usetick: 0);
    );
  MA94: TMonsterAction = ( //雪域寒冰魔、雪域灭天魔、雪域五毒魔
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 7; skip: 3; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 8; skip: 2; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  MA95: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 6; skip: 4; ftime: 130; usetick: 0);
    ActWalk: (start: 80; frame: 10; skip: 0; ftime: 60; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 350; frame: 7; skip: 3; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 270; frame: 7; skip: 3; ftime: 200; usetick: 0);
    ActDeath: (start: 270; frame: 7; skip: 3; ftime: 200; usetick: 0); //
    );
  MA96: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 8; skip: 2; ftime: 80; usetick: 3); //
    ActAttack: (start: 160; frame: 7; skip: 3; ftime: 100; usetick: 0);
    ActCritical: (start: 270; frame: 10; skip: 0; ftime: 60; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 510; frame: 10; skip: 0; ftime: 100; usetick: 0);
    ActDeath: (start: 510; frame: 10; skip: 0; ftime: 100; usetick: 0); //
    );
  MA97: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 130; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActCritical: (start: 350; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 270; frame: 10; skip: 0; ftime: 180; usetick: 0);
    ActDeath: (start: 270; frame: 10; skip: 0; ftime: 180; usetick: 0); //
    );
  MA98: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 6; skip: 4; ftime: 130; usetick: 0);
    ActWalk: (start: 80; frame: 10; skip: 0; ftime: 60; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 350; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 270; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActDeath: (start: 270; frame: 10; skip: 0; ftime: 200; usetick: 0); //
    ActAttack2: (start: 430; frame: 6; skip: 4; ftime: 100; usetick: 0);
    );
  MA99: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 6; skip: 4; ftime: 130; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 100; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 350; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 270; frame: 9; skip: 1; ftime: 200; usetick: 0);
    ActDeath: (start: 270; frame: 9; skip: 1; ftime: 200; usetick: 0); //
    );
  MA100: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 6; skip: 4; ftime: 130; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 100; usetick: 3); //
    ActAttack: (start: 160; frame: 7; skip: 3; ftime: 100; usetick: 0);
    ActCritical: (start: 350; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 270; frame: 9; skip: 1; ftime: 200; usetick: 0);
    ActDeath: (start: 270; frame: 9; skip: 1; ftime: 200; usetick: 0); //
    );
  MA101: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 6; skip: 4; ftime: 130; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 100; usetick: 3); //
    ActAttack: (start: 160; frame: 7; skip: 3; ftime: 100; usetick: 0);
    ActCritical: (start: 350; frame: 9; skip: 1; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 3; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 270; frame: 8; skip: 2; ftime: 200; usetick: 0);
    ActDeath: (start: 270; frame: 8; skip: 2; ftime: 200; usetick: 0); //
    );
  MA102: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 6; skip: 4; ftime: 130; usetick: 0);
    ActWalk: (start: 80; frame: 10; skip: 0; ftime: 60; usetick: 3); //
    ActAttack: (start: 160; frame: 7; skip: 3; ftime: 100; usetick: 0);
    ActCritical: (start: 430; frame: 6; skip: 4; ftime: 160; usetick: 3);
    ActStruck: (start: 240; frame: 3; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 270; frame: 10; skip: 0; ftime: 150; usetick: 0);
    ActDeath: (start: 270; frame: 10; skip: 0; ftime: 150; usetick: 0); //
    ActAttack2: (start: 430; frame: 6; skip: 4; ftime: 100; usetick: 0);
    );
  MA103: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 6; skip: 4; ftime: 130; usetick: 0);
    ActWalk: (start: 80; frame: 8; skip: 2; ftime: 100; usetick: 3); //
    ActAttack: (start: 160; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActCritical: (start: 400; frame: 10; skip: 0; ftime: 80; usetick: 3);
    ActStruck: (start: 240; frame: 4; skip: 6; ftime: 100; usetick: 0);
    ActDie: (start: 320; frame: 10; skip: 0; ftime: 150; usetick: 0);
    ActDeath: (start: 320; frame: 10; skip: 0; ftime: 150; usetick: 0); //
    ActAttack2: (start: 480; frame: 8; skip: 2; ftime: 100; usetick: 0);
    ActAttack3: (start: 560; frame: 8; skip: 2; ftime: 100; usetick: 0);
    );
  MA104: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 100; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 3);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 150; usetick: 0);
    ActDeath: (start: 260; frame: 10; skip: 0; ftime: 150; usetick: 0); //
    ActAttack2: (start: 420; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActAttack3: (start: 500; frame: 7; skip: 3; ftime: 80; usetick: 0);
    );
  MA105: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 100; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 8; skip: 2; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    ActAttack2: (start: 420; frame: 8; skip: 2; ftime: 80; usetick: 0);
    );
  MA106: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 100; usetick: 3); //
    ActAttack: (start: 160; frame: 4; skip: 6; ftime: 140; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 8; skip: 2; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    ActAttack2: (start: 420; frame: 6; skip: 4; ftime: 120; usetick: 0);
    );
  MA107: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActAttack: (start: 10; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActDie: (start: 20; frame: 5; skip: 5; ftime: 140; usetick: 0);
    ActDeath: (start: 20; frame: 5; skip: 5; ftime: 140; usetick: 0); //
    );
  MA108: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 100; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 4; skip: 6; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 4; skip: 6; ftime: 140; usetick: 0); //
    );
  MA109: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 100; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 8; skip: 2; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 8; skip: 2; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    ActAttack2: (start: 420; frame: 7; skip: 3; ftime: 100; usetick: 0);
    );
  MA110: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 8; skip: 2; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  MA111: TMonsterAction = (
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 120; usetick: 3);
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActCritical: (start: 340; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 4; skip: 6; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 0; usetick: 0);
    );
  MA112: TMonsterAction = (
    ActStand: (start: 0; frame: 2; skip: 0; ftime: 200; usetick: 0);
    ActAttack: (start: 30; frame: 6; skip: 0; ftime: 120; usetick: 0);
    ActStruck: (start: 10; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 20; frame: 8; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 20; frame: 1; skip: 0; ftime: 0; usetick: 0);
    );
  MA113: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 8; skip: 2; ftime: 90; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  MA114: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 10; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 340; frame: 1; skip: 0; ftime: 140; usetick: 0); //
    );
  MA115: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 16; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 96; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 176; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 10; skip: 0; ftime: 80; usetick: 0);
    ActStruck: (start: 256; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 276; frame: 6; skip: 4; ftime: 180; usetick: 0);
    ActDeath: (start: 0; frame: 6; skip: 4; ftime: 140; usetick: 0); //
    );
  MA116: TMonsterAction = (//4C0ADC
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 10; frame: 10; skip: 0; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA117: TMonsterAction = (//4C0ADC
    ActStand: (start: 0; frame: 10; skip: 0; ftime: 200; usetick: 0);
    ActWalk: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActAttack: (start: 10; frame: 10; skip: 0; ftime: 150; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 0; frame: 1; skip: 9; ftime: 0; usetick: 0);
    ActDie: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActDeath: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    );
  MA118: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 320; frame: 4; skip: 4; ftime: 200; usetick: 0);
    ActWalk: (start: 384; frame: 8; skip: 0; ftime: 80; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActStruck: (start: 448; frame: 3; skip: 5; ftime: 100; usetick: 0);
    ActDie: (start: 512; frame: 8; skip: 0; ftime: 140; usetick: 0);
    ActDeath: (start: 512; frame: 8; skip: 0; ftime: 140; usetick: 0); //
    );
  MA119: TMonsterAction = (//快搁蓖 (磷绰芭 弧府磷澜)
    ActStand: (start: 0; frame: 4; skip: 6; ftime: 200; usetick: 0);
    ActWalk: (start: 80; frame: 6; skip: 4; ftime: 160; usetick: 3); //
    ActAttack: (start: 160; frame: 6; skip: 4; ftime: 100; usetick: 0);
    ActCritical: (start: 0; frame: 0; skip: 0; ftime: 0; usetick: 0);
    ActStruck: (start: 240; frame: 2; skip: 0; ftime: 100; usetick: 0);
    ActDie: (start: 260; frame: 6; skip: 4; ftime: 120; usetick: 0);
    ActDeath: (start: 340; frame: 6; skip: 4; ftime: 100; usetick: 0);
    //归榜牢版快(家券)
    );
{------------------------------------------------------------------------------}
// 武器绘制顺序 (是否先于身体绘制: 0是/1否)
// WEAPONORDERS: array [Sex, FrameIndex] of Byte
{------------------------------------------------------------------------------}
   WORDER: Array[0..1, 0..599] of byte = (  //1: 女,  0: 男
                                            //第一维是性别，第二维是动作图片索引
      (       //男
      //站
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
    0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1,
      //走
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
      //跑
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1,
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    //war葛靛
    0, 1, 1, 1, 0, 0, 0, 0,
      //击
    1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1,
      //击 2
    0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
    1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1,
      //击3
    1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0,
    1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0,
    //付过
    0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1,
    1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1,
    //澵扁
    0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0,
    //嘎扁
    0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    //静矾咙
    0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1
    ),

    (
    //沥瘤
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
    0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1,
    //叭扁
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    //顿扁
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1,
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    //war葛靛
    1, 1, 1, 1, 0, 0, 0, 0,
    //傍拜
    1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1,
    //傍拜 2
    0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
    1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1,
    //傍拜3
    1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0,
    1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0,
    //付过
    0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1,
    1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,
    0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1,
    //澵扁
    0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0,
    //嘎扁
    0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    //静矾咙
    0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,
    0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1
    )
    );

  EffDir: array[0..7] of byte = (0, 0, 1, 1, 1, 1, 1, 0);

type
  TActor = class //Size 0x240
    m_nRecogId: Integer; //角色标识 0x4
    m_btObjectClass: Byte;
    m_nCurrX: Integer; //当前所在地图座标X 0x08
    m_nCurrY: Integer; //当前所在地图座标Y 0x0A
    m_btDir: byte; //当前站立方向 0x0C
    m_btSex: byte; //性别 0x0D
    m_btRace: byte; //0x0E
    m_btRaceServer: Byte;
    m_btHair: byte; //头发类型 0x0F
    m_btDress: byte; //衣服类型 0x10
    m_btWeapon: byte; //武器类型
    m_btHorse: byte; //马类型
    m_btEffect: byte; //天使类型
    m_btJob: byte; //职业 0:武士  1:法师  2:道士
    m_wAppearance: Word; //0x14 DIV 10=种族（外貌）， Mod 10=外貌图片在图片库中的位置（第几种）
    m_btDeathState: byte;
    m_nFeature: Integer; //0x18
    m_nFeatureEx: Integer; //0x18
    m_nState: Integer; //0x1C
    m_btStep: Byte;
    m_boDeath: Boolean; //0x20
    m_boSkeleton: Boolean; //0x21
    m_boDelActor: Boolean; //0x22
    m_boDelActionAfterFinished: Boolean; //0x23
    m_sDescUserName: string; //人物名称，后缀
    m_UserName: string;  //名字
    m_NameWidth: Integer;
    m_DescNameWidth: Integer;
    m_sGuildName: string;
    m_sGuildRankName: string;
    m_NameColor: LongWord; //名字颜色
    m_OldNameColor: Byte;
    m_Abil: TAbility; //基本属性
    m_nGold: Integer; //金币数量0x58
    m_nGameGold: Integer; //游戏币数量
    m_nGamePoint: Integer; //游戏点数量
    m_nHitSpeed: ShortInt; //攻击速度 0: 扁夯, (-)蠢覆 (+)狐抚
    m_boVisible: Boolean; //0x5D
    m_boHoldPlace: Boolean; //0x5E

    // m_UserNameSurface: TDXImageTexture;
    m_UserShopSurface: TDXImageTexture;

    //m_SayingArr: array[0..MAXSAY - 1] of string;
    m_SayWidthsArr: Integer;
    m_dwSayTime: LongWord;
    m_nSayX: Integer;
    m_nSayY: Integer;
    m_nDrawX: Integer;
    m_nDrawY: Integer;
    //m_nSayLineCount: Integer;
    m_SayList: TList;
    m_Group: pTGroupMember;

    m_nShiftX: Integer; //0x98
    m_nShiftY: Integer; //0x9C

    m_nPx: Integer; //0xA0
    m_nHpx: Integer; //0xA4
    m_nWpx: Integer; //0xA8
    m_nSpx: Integer; //0xAC

    m_nPy: Integer;
    m_nHpy: Integer;
    m_nWpy: Integer;
    m_nSpy: Integer; //0xB0 0xB4 0xB8 0xBC

    m_boShop: Boolean;
    m_btShopIdx: Byte;
    m_boShopLeft: Boolean;
    m_sShopTitle: string[24];

    m_nRx: Integer;
    m_nRy: Integer; //0xC0 0xC4
    m_nDownDrawLevel: Integer; //0xC8
    m_nTargetX: Integer;
    m_nTargetY: Integer; //0xCC 0xD0
    m_nTargetRecog: Integer; //0xD4
    m_nHiterCode: Integer; //0xD8
    m_nMagicNum: Integer; //0xDC
    m_nCurrentEvent: Integer; //辑滚狼 捞亥飘 酒捞叼
    m_boDigFragment: Boolean; //捞锅 邦豹捞 龙捞 某脸绰瘤..
    m_boThrow: Boolean;
    m_boShowHealthBar: Boolean;

    m_nBodyOffset             :Integer;     //0x0E8   //0x0D0 // 身体图片索引的主偏移
    m_nHairOffset             :Integer;     //0x0EC           // 头发图片索引的主偏移
    m_nWeaponOffset           :Integer;   //0x0F4             // 武器图片索引的主偏移
    m_boUseMagic: Boolean; //0x0F8   //0xE0
    m_boHitEffect: Boolean; //0x0F9    //0xE1
    m_boUseEffect: Boolean; //0x0FA    //0xE2
    m_boShowCbo: Boolean;
    m_boNoCheckSpeed: Boolean;
    m_nHumWinOffset: Integer; //0x0F0
    m_nHitEffectNumber: Integer; //0xE4
    m_dwWaitMagicRequest: LongWord;
    m_nWaitForRecogId: Integer;
    //磊脚捞 荤扼瘤搁 WaitFor狼 actor甫 visible 矫挪促.
    m_nWaitForFeature: Integer;
    m_nWaitForStatus: Integer;
    m_btStrengthenIdx: Byte;
    m_dwStrengthenTick: LongWord;

    m_nCurEffFrame: Integer; //0x110
    m_nCurCboFrame: Integer;
    m_nSpellFrame: Integer; //0x114
    m_nNewMagicFrame: Integer;
    m_nSpellCboSkip: Integer;
    m_CurMagic: TUseMagicInfo; //0x118  //m_CurMagic.EffectNumber 0x110
    //GlimmingMode: Boolean;
    //CurGlimmer: integer;
    //MaxGlimmer: integer;
    //GlimmerTime: longword;
    m_nGenAniCount: Integer; //0x124
    m_boOpenHealth: Boolean; //0x140
    m_noInstanceOpenHealth: Boolean; //0x141
    m_dwOpenHealthStart: LongWord;
    m_dwOpenHealthTime: LongWord; //Integer;jacky

    //SRc: TRect;  //Screen Rect 拳搁狼 角力谅钎(付快胶 扁霖)
    m_BodySurface: TDirectDrawSurface; //0x14C   //0x134

    //m_boGrouped: Boolean; //0x150 是否组队
    m_nCurrentAction: Integer; //0x154         //0x13C
    m_boReverseFrame: Boolean; //0x158
    m_boWarMode: Boolean; //0x159
    m_dwWarModeTime: LongWord; //0x15C
    //m_nChrLight: Integer; //0x160
    //m_nMagLight: Integer; //0x164
    m_btWuXin: Byte;
    //    m_btWuXinLevel: byte;
     //   m_dwWuXinExp: LongWord;
     //   m_dwWuXinMaxExp: LongWord;
    m_nRushDir: Integer; //0, 1  //0x168
    m_nXxI: Integer; //0x16C
    m_boLockEndFrame: Boolean; //0x170
    m_dwLastStruckTime: LongWord; //0x174
    m_dwSendQueryUserNameTime: LongWord; //0x178
    m_dwDeleteTime: LongWord; //0x17C

    //荤款靛 瓤苞
    m_nMagicStruckSound: Integer; //0x180 被魔法攻击弯腰发出的声音
    m_boRunSound: Boolean; //0x184 跑步发出的声音
    m_nFootStepSound: Integer; //CM_WALK, CM_RUN //0x188  走步声
    m_nStruckSound: Integer; //SM_STRUCK         //0x18C  弯腰声音
    m_nStruckWeaponSound: Integer; //0x190  被指定武器攻击弯腰声音

    m_nAppearSound: Integer; //殿厘家府 0    //0x194
    m_nNormalSound: Integer; //老馆家府 1    //0x198
    m_nAttackSound: Integer; //         2    //0x19C
    m_nWeaponSound: Integer; //          3    //0x1A0
    m_nScreamSound: Integer; //         4    //0x1A4
    m_nDieSound: Integer; //磷阑锭   5 SM_DEATHNOW //0x1A8
    m_nDie2Sound: Integer; //0x1AC
    m_nAttack2Sound: Integer; //         2    //0x19C
    m_nAttack3Sound: Integer; //         2    //0x19C
    m_nAttack4Sound: Integer; //         2    //0x19C
    m_nAttack5Sound: Integer; //         2    //0x19C

    m_dwMissionIconTick: LongWord;
    m_dwMissionIconIdx: Byte;

    m_nMagicStartSound: Integer; //0x1B0
    m_nMagicFireSound: Integer; //0x1B4
    m_nMagicExplosionSound: Integer; //0x1B8
    m_Action: pTMonsterAction;
    m_dwLoadSurfaceTime: LongWord; //0x210  //0x200
    m_nShowY: Integer;
    m_nMoveHpList: TList;
    m_boShowName: Boolean;
    m_boOutside: Boolean;
    m_WMImages: TWMImages;

    m_IconInfo: TIconInfos;
    m_IconInfoShow: TIconInfoShows;
    m_nWeaponEffect: Byte;
  private
    function GetMessage(ChrMsg: pTChrMsg): Boolean;
  protected
    m_nStartFrame             :Integer;      //0x1BC        //0x1A8  // 当前动作的开始帧索引
    m_nEndFrame               :Integer;        //0x1C0      //0x1AC  // 当前动作的结束帧索引
    m_nCurrentFrame: Integer; //0x1C4          //0x1B0
    m_nEffectStart: Integer; //0x1C8         //0x1B4
    m_nEffectFrame: Integer; //0x1CC         //0x1B8
    m_nEffectEnd: Integer; //0x1D0       //0x1BC
    m_dwEffectStartTime: LongWord; //0x1D4             //0x1C0
    m_dwEffectFrameTime: LongWord; //0x1D8             //0x1C4
    m_dwFrameTime: LongWord; //0x1DC       //0x1C8
    m_dwStartTime: LongWord; //0x1E0       //0x1CC
    m_nMaxTick: Integer; //0x1E4
    m_nCurTick: Integer; //0x1E8
    m_nMoveStep: Integer; //0x1EC
    m_boMsgMuch: Boolean; //0x1F0
    m_dwStruckFrameTime: LongWord; //0x1F4
    m_nCurrentDefFrame: Integer; //0x1F8          //0x1E4
    m_dwDefFrameTime: LongWord; //0x1FC       //0x1E8
    m_dwDefFrameTick: LongWord;
    m_nDefFrameCount: Integer; //0x200        //0x1EC
    m_nSkipTick: Integer; //0x204
    m_dwSmoothMoveTime: LongWord; //0x208
    m_dwGenAnicountTime: LongWord; //0x20C

    m_nOldx: Integer;
    m_nOldy: Integer;
    m_nOldDir: Integer; //0x214 0x218 0x21C
    m_nActBeforeX: Integer;
    m_nActBeforeY: Integer; //0x220 0x224
    m_nWpord: Integer; //0x228

    procedure CalcActorFrame; dynamic;
    procedure DefaultMotion; dynamic;
    function GetDefaultFrame(wmode: Boolean): Integer; dynamic;
    procedure DrawEffSurface(dsurface, source: TDirectDrawSurface; ddx, ddy: Integer; blend: Boolean;
      ceff: TColorEffect; blendmode: integer = 0);
    procedure DrawWeaponGlimmer(dsurface: TDirectDrawSurface; ddx, ddy: Integer);
  public
    m_MsgList: TGList; //list of PTChrMsg 0x22C  //0x21C
    RealActionMsg: TChrMsg; //FrmMain    0x230

    constructor Create; dynamic;
    destructor Destroy; override;
    procedure SendMsg(wIdent: Word; nX, nY, ndir, nFeature, nState: Integer; sStr: string; nSound: Integer);
    procedure UpdateMsg(wIdent: Word; nX, nY, ndir, nFeature, nState: Integer; sStr: string; nSound: Integer);
    procedure CleanUserMsgs;
    procedure ProcMsg;
    procedure ProcHurryMsg;
    function IsIdle: Boolean;
    function ActionFinished: Boolean;
    function CanWalk: Integer;
    function CanRun: Integer;
    function Strucked: Boolean;
    procedure Click(); dynamic;
    procedure ClearSayList();
    procedure ShowEffect(nID, nX, nY: Integer);
    procedure Shift(dir, step, cur, max: Integer);
    procedure GetUserName(sStr: string; nameColor: Integer);
    procedure SetUsername(Username: string; nameColor: Integer; boClear: Boolean = False); dynamic;
    //procedure LoadUsername(); dynamic;
    procedure LoadShopTitle(); dynamic;
    procedure SetEffigyState(nEffigyState, nOffset: Integer); dynamic;
    procedure ReadyAction(msg: TChrMsg);
    function CharWidth: Integer;
    function CharHeight: Integer;
    function CheckSelect(dx, dy: Integer): Boolean;
    procedure CleanCharMapSetting(x, y: Integer);
    procedure Say(str: string; boFirst: Boolean = True);
    procedure SetSound; dynamic;
    function Run(): Boolean; dynamic;
    procedure RunSound; dynamic;
    procedure RunActSound(frame: Integer); dynamic;
    procedure RunFrameAction(frame: Integer); dynamic;
    //橇贰烙付促 刀漂窍霸 秦具且老
    procedure ActionEnded; dynamic;
    function Move(step: Integer; out boChange: Boolean): Boolean;
    procedure MoveFail;
    function CanCancelAction: Boolean;
    procedure CancelAction;
    procedure FeatureChanged; dynamic;
    //function Light: Integer; dynamic;
    procedure LoadSurface; dynamic;

    function GetDrawEffectValue: TColorEffect;
    procedure DrawChr(dsurface: TDirectDrawSurface; dx, dy: Integer; blend: Boolean; boFlag: Boolean); dynamic;
    procedure DrawEff(dsurface: TDirectDrawSurface; dx, dy: Integer); dynamic;
    procedure DrawStruck(dsurface: TDirectDrawSurface); dynamic;
    //property m_sUserName: String read FUserName write SetUserName;
  end;

  TNpcActor = class(TActor)
    m_MissionStatus: TNPCMissionStatus;
    m_MissionList: TList;
  private
    m_bo248: Boolean; //0x248
    m_dwUseEffectTick: LongWord; //0x24C
  protected
    m_nEffX: Integer; //0x240
    m_nEffY: Integer; //0x244
    m_EffSurface: TDirectDrawSurface; //0x250//画NPC 魔法动画效果
    m_boCanAnimation: Boolean;
    m_boCanChangeDir: Boolean;
    m_boCanModDir: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Run: Boolean; override;
    procedure CalcActorFrame; override;
    // procedure LoadUsername(); override;
    function GetDefaultFrame(wmode: Boolean): Integer; override;
    procedure LoadSurface; override;
    procedure DrawChr(dsurface: TDirectDrawSurface; dx, dy: Integer; blend: Boolean; boFlag: Boolean); override;
    procedure DrawEff(dsurface: TDirectDrawSurface; dx, dy: Integer); override;
    procedure SetUsername(Username: string; nameColor: Integer; boClear: Boolean = False); override;
  end;

  THumActor = class(TActor) //Size: 0x27C Address: 0x00475BB8
  private
    m_HairSurface: TDirectDrawSurface; //0x250  //0x240         //头发外观
    m_WeaponSurface: TDirectDrawSurface; //0x254  //0x244       //武器外观
    m_WeaponEffectSurface: TDirectDrawSurface; //0x254  //0x244
    m_HumWinSurface: TDirectDrawSurface; //0x258  //0x248       //人物外观
    m_HoresSurface: TDirectDrawSurface;

    m_boWeaponEffect: Boolean; //0x25C  //0x24C
    m_nCurWeaponEffect: Integer; //0x260  //0x250
    m_nCurBubbleStruck: Integer; //0x264  //0x254
    m_dwWeaponpEffectTime: LongWord; //0x268
    m_boHideWeapon: Boolean; //0x26C
    m_nFrame: Integer;
    m_dwFrameTick: LongWord;
    m_dwFrameTime: LongWord;
    //    m_bo2D0: Boolean;
    m_nhsX: Integer;
    m_nhsY: Integer;
    m_boReverse: Boolean;

    m_nWepx: Integer; //0xA8
    m_nWepy: Integer;
  protected
    procedure CalcActorFrame; override;
    procedure DefaultMotion; override;
    function GetDefaultFrame(wmode: Boolean): Integer; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Run: Boolean; override;
    procedure RunFrameAction(frame: Integer); override;
    procedure LoadShopTitle(); override;
    //function Light: Integer; override;
    procedure LoadSurface; override;
    procedure DoWeaponBreakEffect;
    procedure DrawChr(dsurface: TDirectDrawSurface; dx, dy: Integer; blend: Boolean; boFlag: Boolean); override;
  end;

function GetRaceByPM(race: Integer; Appr: Word): pTMonsterAction;
function GetOffset(Appr: Integer): Integer;
function GetNpcOffset(nAppr: Integer): Integer;

implementation

uses
  ClMain, SoundUtil, clEvent, MShare, Share, HUtil32, WMFile, HGEBase, FState2;

function GetRaceByPM(race: Integer; Appr: Word): pTMonsterAction;
begin
  Result := nil;

  case race of
    9 {01}: Result := @MA9; //475D70
    10 {02}: begin
        case Appr of
          264: Result := @MA111;
        else
          Result := @MA10; //475D7C
        end;
      end;
    11 {03}: Result := @MA11; //鸡和鹿
    12 {04}: Result := @MA12; //大刀卫士
    13 {05}: Result := @MA13; //食人花
    14 {06}: Result := @MA14; //骷髅系列怪
    15 {07}: Result := @MA15; //掷斧骷髅
    16 {08}: Result := @MA16; //洞蛆
    17 {06}: Result := @MA14; //多钩猫
    18 {06}: Result := @MA14; //稻草人
    19 {0A}: begin
        case Appr of
          258: Result := @MA64; //475DDC
          251: Result := @MA65; //475DDC
          252..254: Result := @MA110;
          507: Result := @MA75;
          520: Result := @MA85;
          522: Result := @MA86;
          540..541: Result := @MA91;
        else
          Result := @MA19; //半兽人、蛤蟆、毒蜘蛛之类的
        end;

      end;
    20 {0A}: Result := @MA19; //火焰沃玛
    21 {0A}: Result := @MA19; //沃玛教主
    22 {07}: Result := @MA15; //暗黑战士、暴牙蜘蛛
    23 {06}: begin
        case Appr of
          810..819: Result := @MA119;
        else
          Result := @MA14; //变异骷髅
        end;
      end;
    24 {04}: Result := @MA12; //带刀护卫
    25: Result := @MA67;
    26: Result := @MA70;
    30 {09}: Result := @MA17; //475DD0
    31 {09}: Result := @MA17; //蜜蜂
    32 {0F}: Result := @MA24; //蝎子
    33 {10}: Result := @MA25; //触龙神
    34 {11}: Result := @MA30; //赤月恶魔、宝箱、千年树妖
    35 {12}: Result := @MA31; //475E3C
    36 {13}: Result := @MA32; //475E48
    37 {0A}: Result := @MA19; //475DDC
    40 {0A}: Result := @MA19; //475DDC
    41 {0B}: Result := @MA20; //475DE8
    42 {0B}: Result := @MA20; //475DE8
    43 {0C}: Result := @MA21; //475DF4
    44: Result := @MA19;
    45 {0A}: begin
        case Appr of
          523: Result := @MA87;
        else
          Result := @MA19; //475DDC
        end;
      end;
    47 {0D}: begin
        case Appr of
          221, 233: Result := @MA56; //475E00
          232: Result := @MA58; //475E00
          263: Result := @MA62; //475E00
          330, 334: Result := @MA115;
        else
          Result := @MA22; //祖玛雕像
        end;

      end;
    48 {0E}: Result := @MA23; //475E0C
    49 {0E}: Result := @MA23; //祖玛教主
    50 {27}: begin //NPC
        case Appr of
          23 {01}: Result := @MA36; //475F77
          24 {02}: Result := @MA37; //475F80
          25 {02}: Result := @MA37; //475F80
          26 {00}: Result := @MA35; //475F9B
          27 {02}: Result := @MA37; //475F80
          28 {00}: Result := @MA35; //475F9B
          29 {00}: Result := @MA35; //475F9B
          30 {00}: Result := @MA35; //475F9B
          31 {00}: Result := @MA35; //475F9B
          32 {02}: Result := @MA37; //475F80
          33 {00}: Result := @MA35; //475F9B
          34 {00}: Result := @MA35; //475F9B
          35 {03}: Result := @MA41; //475F89
          36 {03}: Result := @MA41; //475F89
          37 {03}: Result := @MA41; //475F89
          38 {03}: Result := @MA41; //475F89
          39 {03}: Result := @MA41; //475F89
          40 {03}: Result := @MA41; //475F89
          41 {03}: Result := @MA41; //475F89
          42 {04}: Result := @MA46; //475F92
          43 {04}: Result := @MA46; //475F92
          44 {04}: Result := @MA46; //475F92
          45 {04}: Result := @MA46; //475F92
          46 {04}: Result := @MA46; //475F92
          47 {04}: Result := @MA46; //475F92
          48 {03}: Result := @MA41; //4777B3
          49 {03}: Result := @MA41; //4777B3
          50 {03}: Result := @MA41; //4777B3
          51 {00}: Result := @MA35; //4777C5
          52 {03}: Result := @MA41; //4777B3
          53 {03}: Result := @MA41; //4777B3
          67..69, 79: Result := @MA116;
          76: Result := @MA117;
          125: Result := @MA48;
          83, 88..90, 94, 126..142, 146..152, 156, 162, 164..166, 169..175, 177, 178, 180: Result := @MA49;
          143: Result := @MA50;
          144: Result := @MA51;
          82, 145, 160: Result := @MA52;
          153: Result := @MA66;
          154..155: Result := @MA53;
          157..159, 161, 163, 176, 179: Result := @MA68;
          167, 168: Result := @MA69;
        else
          Result := @MA35;
        end;
      end;

    52 {0A}: Result := @MA19; //475DDC
    53 {0A}: Result := @MA19; //475DDC
    54 {14}: Result := @MA28; //475E54
    55 {15}: Result := @MA29; //475E60
    60 {16}: Result := @MA33; //475E6C
    61 {16}: Result := @MA33; //475E6C
    62 {16}: Result := @MA33; //475E6C
    63 {17}: Result := @MA34; //475E78
    64 {18}: Result := @MA19; //475E84
    65 {18}: Result := @MA19; //475E84
    66 {18}: Result := @MA19; //475E84
    67 {18}: Result := @MA19; //475E84
    68 {18}: Result := @MA19; //475E84
    69 {18}: Result := @MA19; //475E84
    70 {19}: Result := @MA33; //475E90
    71 {19}: Result := @MA33; //475E90
    72 {19}: Result := @MA33; //475E90
    73 {1A}: Result := @MA19; //475E9C
    74 {1B}: Result := @MA19; //475EA8
    75 {1C}: Result := @MA39; //475EB4
    76 {1D}: Result := @MA38; //475EC0
    77 {1E}: Result := @MA39; //475ECC
    78 {1F}: Result := @MA40; //475ED8
    79 {20}: Result := @MA19; //475EE4
    80 {21}: Result := @MA42; //475EF0
    81 {22}: Result := @MA43; //475EFC
    83 {23}: Result := @MA44; //火龙教主
    84 {24}: Result := @MA45; //475F14
    85 {24}: begin
        case Appr of
          241: Result := @MA57; //475E00
          243: Result := @MA113;
          250: Result := @MA60; //475E00
          251: Result := @MA61; //475E00
          255: Result := @MA109;
          262: Result := @MA63;
          281: Result := @MA19;
          331, 332: Result := @MA114;
          500: Result := @MA71;
          501: Result := @MA72;
          503: Result := @MA19;
          504: Result := @MA73;
          505, 506: Result := @MA74;
          510: Result := @MA76;
          511: Result := @MA77;
          512: Result := @MA78;
          513: Result := @MA79;
          515: Result := @MA81;
          516: Result := @MA82;
          517: Result := @MA83;
          518: Result := @MA84;
          524: Result := @MA88;
          525, 526, 320, 321: Result := @MA19;
          527, 322: Result := @MA89;
          534, 280: Result := @MA19;
          535: Result := @MA90;
          542, 543: Result := @MA91;
          544: Result := @MA92;
          545..548: Result := @MA19;
          549: Result := @MA93;
          555: Result := @MA94;
          556, 557: Result := @MA105;
          558: Result := @MA106;
          560: Result := @MA95;
          561: Result := @MA96;
          562, 563: Result := @MA97;
          564: Result := @MA98;
          565: Result := @MA99;
          566: Result := @MA100;
          567: Result := @MA101;
          568: Result := @MA102;
          569: Result := @MA103;
          559: Result := @MA104;
          550..553: Result := @MA108;
          1100..1509: Result := @MA118;
        else
          Result := @MA55; //475F14
        end;
      end;
    86 {24}: begin
        case Appr of
          223, 231: Result := @MA59;
        else
          Result := @MA59;
        end;
      end;
    87 {24}: Result := @MA107; //475F14
    88 {24}: Result := @MA45; //475F14
    89 {24}: Result := @MA45; //475F14
    90 {11}: Result := @MA53; //475E30
    91 {11}: Result := @MA54; //475E30
    92: Result := @MA80;
    98 {25}: Result := @MA27; //475F20
    99 {26}: Result := @MA26; //475F29
    100: Result := @MA19;
    101: Result := @MA112;
  end
end;

//根据种族和外貌确定在图片库中的开始位置
function GetOffset(Appr: Integer): Integer;
var
  nrace, npos: Integer;
begin
  Result := 0;
   nrace := appr div 10;         //图片库
   npos := appr mod 10;          //图片库中的形象序号
  case nrace of
    0: Result := npos * 280; //8橇贰烙
    1: Result := npos * 230;
    2, 3, 7..12: Result := npos * 360; //10橇贰烙 扁夯
    4: begin
        Result := npos * 360; //
        if npos = 1 then
          Result := 600; //厚阜盔面
      end;
    5: Result := npos * 430; //
    6: Result := npos * 440; //
    //      13:   Result := npos * 360;
    13: case npos of
        0: Result := 0;
        1: Result := 360;
        2: Result := 440;
        3: Result := 550;
      else
        Result := npos * 360;
      end;
    14: Result := npos * 360;
    15: Result := npos * 360;
    16: Result := npos * 360;
    17: case npos of
        2: Result := 1280;
      else
        Result := npos * 350;
      end;
    18: case npos of  //魔龙系列怪
        0: Result := 0; //己巩
        1: Result := 520;
        2: Result := 950;
        4: Result := 1574;
        5: Result := 1934;
        6: Result := 2294;
        7: Result := 2654;
        8: Result := 3014;
      end;
    19: case npos of
        0: Result := 0; //己巩
        1: Result := 370;
        2: Result := 810;
        3: Result := 1250;
        4: Result := 1630;
        5: Result := 2010;
        6: Result := 2390;
      end;
    20: case npos of
        0: Result := 0; //己巩
        1: Result := 360;
        2: Result := 720;
        3: Result := 1080;
        4: Result := 1440;
        5: Result := 1800;
        6: Result := 2350;
        7: Result := 3060;
      end;
    21: case npos of
        0: Result := 0; //己巩
        1: Result := 460;
        2: Result := 820;
        3: Result := 1180;
        4: Result := 1540;
        5: Result := 1900;
        //               6: Result := 2260;
        6: Result := 2440;
        7: Result := 2570;
        8: Result := 2700;
        9: Result := 2700;
      end;
    22: case npos of
        0: Result := 0;
        1: Result := 430;
        2: Result := 1290;
        3: Result := 1810;
        //4: Result := 1810;
        //5: Result := 1810;
      else
        Result := npos * 360;
        {6: Result := 2440;
        7: Result := 2570;
        8: Result := 2700; }
      end;
    23: case npos of
        0: Result := 0; //340
        1: Result := 680; //1020
        2: Result := 1180;
        3: Result := 1770;
        4: Result := 2610;
        5: Result := 2950;
        6: Result := 3290;
        7: Result := 3750;
        8: Result := 4460;
        9: Result := 4810;
      end;
    24: case npos of
        0: Result := 0; //340
        1: Result := 510; //1020
        2: Result := 1020; //未做
        3: Result := 1090;
      else
        Result := npos * 350;
      end;
    25: case npos of
        0: Result := 0;
        1: Result := 510; //1020
        2: Result := 1020;
        3: Result := 1370;
        4: Result := 1720;
        5: Result := 2070;
        6: Result := 2740;
        7: Result := 3780; //城墙不用做
        8: Result := 3820;
        9: Result := 4170;
      end;
    26: case npos of
        0: Result := 0;
        1: Result := 340;
        2: Result := 680;
        3: Result := 1190;
        4: Result := 2100;
        5: Result := 2440;
        6: Result := 2540;
        7: Result := 3570;
      end;
    27: case npos of
        0: Result := 0;
        1: Result := 350; //1020
        2: Result := 780; //1020
        3: Result := 1130;
        4: Result := 1560;
        5: Result := 1910;
      end;
    28: case npos of
        0: Result := 0;
        1: Result := 600;
      end;
    29: case npos of
        0: Result := 0;
        1: Result := 360; //1020
        2: Result := 720;
      end;
    32: case npos of
        0: Result := 0;
        1: Result := 440;
        2: Result := 820;
        3: Result := 1360;
        4: Result := 1710; //未知 ?
        5: Result := 1730; //未知 ?
        6: Result := 2590; //未知 ?
        7: Result := 3500;
        8: Result := 3930;
        9: Result := 4440;
      end;
    33: case npos of
        0: Result := 4;
        1: Result := 720;
        2: Result := 1160;
        3: Result := 1170; //城墙不用做
        4: Result := 1824;
        5: Result := 2540;
        6: Result := 2900;
      end;
    50: case npos of
        0: Result := 0;
        1: Result := 690; //1020
        2: Result := 1320;
        3: Result := 1670;
        4: Result := 2380;
        5: Result := 2830;
        6: Result := 3300;
        7: Result := 3970;
      end;
    51: case npos of
        0: Result := 0;
        1: Result := 440; //1020
        2: Result := 880;
        3: Result := 1900;
        4: Result := 2480;
        5: Result := 2560;
        6: Result := 3370;
        7: Result := 3870;
        8: Result := 5030;
        9: Result := 5640;
      end;
    52: case npos of
        0: Result := 0;
        1: Result := 400; //1020
        2: Result := 750;
        3: Result := 1110;
        4: Result := 1530;
        5: Result := 2640;
        6: Result := 3080;
        7: Result := 3460;
        8: Result := 4000;
        9: Result := 4060;
      end;
    53: case npos of
        0: Result := 0;
        1: Result := 340; //1020
        2: Result := 680;
        3: Result := 1030;
        4: Result := 1380;
        5: Result := 1980;
        6: Result := 3430;
        7: Result := 3780;
      end;
    54: case npos of
        0: Result := 0;
        1: Result := 350;
        2: Result := 700;
        3: Result := 1070;
        4: Result := 1430;
        5: Result := 1890;
        6: Result := 2820;
        7: Result := 3840;
        8: Result := 4770;
        9: Result := 5870;
      end;
    55: case npos of
        0: Result := 0;
        1: Result := 880;
        2: Result := 1740;
        3: Result := 2600;
        4: Result := 3460;
        5: Result := 3670;
        6: Result := 4180;
        7: Result := 4640;
        8: Result := 5310;
        9: Result := 5900;
      end;
    56: case npos of
        0: Result := 0;
        1: Result := 460;
        2: Result := 1060;
        3: Result := 1420;
        4: Result := 2020;
        5: Result := 2550;
        6: Result := 3070;
        7: Result := 3590;
        8: Result := 4110;
        9: Result := 4720;
      end;
    //49,50,51,52,53: Result := npos * 360;

    80: case npos of
        0: Result := 0; //己巩
        1: Result := 300;
        2: Result := 320;
        3: Result := 3060;
        4: Result := 3120;
        5: Result := 3180;
        6: Result := 3240;
        7: Result := 4030;
        8: Result := 966;
      end;
    81: Result := npos * 360;
    90: case npos of
        0: Result := 80; //己巩
        1: Result := 168;
        2: Result := 184;
        3: Result := 200;
        4: Result := 1770;
        5: Result := 1780;
        6: Result := 1790;
      end;
    100: case nPos of
        0: Result := 3060;
        1: Result := 3120;
        2: Result := 3180;
        3: Result := 3240;
        4: Result := 4030;
      end;
    110..150: Result := npos * 600; //坐骑样子
  else
    Result := npos * 360;
  end;

end;

function GetNpcOffset(nAppr: Integer): Integer;
begin
  Result := 0;
  case nAppr of
    {0..22: Result := nAppr * 60;
    23: Result := 1380;
    24: Result := 1500;
    25: Result := 1560;
    26: Result := ;
    27: Result := ;
    28: Result := ;
    29: Result := ;
    30: Result := ;
    31: Result := ;
    32: Result := ;
    33: Result := 2040;
    34: Result := ;
    35: Result := ;
    36: Result := ;
    37: Result := ;
    38: Result := ;
    39: Result := ;
    40: Result := ;
    41: Result := ;
    42: Result := ;
    43: Result := ;
    44: Result := ;
    45: Result := ;
    46: Result := ;
    47: Result := ;
    48: Result := ;
    49: Result := ;
    50: Result := ;
    51: Result := 2880;}
   { 0..23: Result := nAppr * 60;
    24..41: Result := (nAppr - 24) * 60 + 1500;
    42, 43: Result := 2580;
    44..47: Result := 2640;   }

    0..22: Result := nAppr * 60;
    23: Result := 1380;
    24, 25: Result := (nAppr - 24) * 60 + 1470;
    27, 32: Result := (nAppr - 26) * 60 + 1620 - 30;
    26, 28..31, 33..41: Result := (nAppr - 26) * 60 + 1620;
    42, 43: Result := 2580;
    44..47: Result := 2640;
    48..50: Result := (nAppr - 48) * 60 + 2700;
    51: Result := 2880;
    52: Result := 2960; //雪人
    53: Result := 3040;
    54: Result := 3060;
    55: Result := 3120;
    56: Result := 3180;
    57: Result := 3240;
    58: Result := 3300;
    59: Result := 3360;
    60: Result := 3420;
    61: Result := 3480;
    62: Result := 3600;
    63: Result := 3750;
    64: Result := 3780;
    65: Result := 3840;
    66: Result := 3900;
    67: Result := 3960;
    68: Result := 3980;
    69: Result := 4000;
    70: Result := 4030;
    71: Result := 4060;
    72: Result := 4120;
    73: Result := 4180;
    74: Result := 4240;
    75: Result := {4250} 3900;
    76: Result := 4490;
    77: Result := 4540;
    78: Result := 4560;
    79: Result := 4600;
    80: Result := 4630;
    81: Result := 4690;
    82: Result := 4770;
    83: Result := 4810;
    84: Result := 10000;
    85: Result := 10070;
    86: Result := 10140;
    87: Result := 10210;
    88: Result := 10280;
    89: Result := 10350;
    90: Result := 10420;
    91: Result := 10490;
    92: Result := 10560;
    93: Result := 10630;
    94: Result := 10700;
    95: Result := 10740;
    96: Result := 10810;

    125: Result := 30000;
    126..139: Result := (nAppr - 126) * 30 + 30000;
    140: Result := 30420;
    141..143: Result := (nAppr - 141) * 30 + 30430;
    144: Result := 30520;
    145: Result := 30530;
    146..152: Result := (nAppr - 146) * 30 + 30560;
    153: Result := 30770;
    154: Result := 30800;
    155: Result := 30810;
    156: Result := 30820;
    157: Result := 30850; //2010-08-24
    158: Result := 30860;
    159: Result := 30870; //
    160: Result := 30880;
    161: Result := 30926;
    162: Result := 30936;
    163: Result := 30966;
    164: Result := 30976;
    165: Result := 31036;
    166: Result := 31066;
    167: Result := 31126;
    168: Result := 31156;
    169: Result := 31186;
    170: Result := 31216;
    171: Result := 31246;
    172: Result := 31276;
    173: Result := 31306;
    174: Result := 31336;
    175: Result := 31366;
    176: Result := 31396;
    177: Result := 31406;
    178: Result := 31436;
    179: Result := 31466;
    180: Result := 31476;

  end;
end;

constructor TActor.Create;
begin
  inherited Create;
  SafeFillChar(m_Abil, Sizeof(TAbility), 0);
  SafeFillChar(m_Action, Sizeof(m_Action), 0);
  m_btObjectClass := 0;
  m_MsgList := TGList.Create;
  m_nRecogId := 0;
  m_BodySurface := nil;
  m_nGold := 0;
  m_boVisible := TRUE;
  m_boHoldPlace := TRUE;
  m_nMoveHpList := TList.Create;
  m_btWuXin := 0;
  m_dwStrengthenTick := Random(GetTickCount);
  m_Group := nil;
  m_boOutside := False;
  m_WMImages := nil;
  m_dwMissionIconTick := GetTickCount;
  m_dwMissionIconIdx := 0;
  m_btStrengthenIdx := 0;
  m_boShowHealthBar := True;

  //m_UserNameSurface := nil;
  m_UserShopSurface := nil;
  m_boShowCbo := False;
  m_boNoCheckSpeed := False;
  m_sGuildName := '';
  m_sGuildRankName := '';

  m_boShop := False;
  m_sShopTitle := '';

  m_SayList := TList.Create;

  m_boShowName := False;

  //泅犁 柳青吝牢 悼累, 辆丰夌绢档 啊瘤绊 乐澜
  //悼累狼 m_nCurrentFrame捞 m_nEndFrame阑 逞菌栏搁 悼累捞 肯丰等巴栏肺 航
  m_nCurrentAction := 0;
  m_boReverseFrame := FALSE;
  m_nShiftX := 0;
  m_nShiftY := 0;
  m_nDownDrawLevel := 0;
  m_nCurrentFrame := -1;
  m_nEffectFrame := -1;
  RealActionMsg.Ident := 0;
  m_UserName := '';
  m_NameWidth := 0;
  m_DescNameWidth := 0;
  m_NameColor := clWhite;
  m_OldNameColor := 255;
  m_dwSendQueryUserNameTime := 0; //GetTickCount;
  m_boWarMode := FALSE;
  m_dwWarModeTime := 0; //War mode
  m_boDeath := FALSE;
  m_boSkeleton := FALSE;
  m_boDelActor := FALSE;
  m_boDelActionAfterFinished := FALSE;

  //m_nChrLight := 0;
  //m_nMagLight := 0;
  m_boLockEndFrame := FALSE;
  m_dwSmoothMoveTime := 0; //GetTickCount;
  m_dwGenAnicountTime := 0;
  m_dwDefFrameTime := 0;
  m_dwDefFrameTick := 0;
  m_dwLoadSurfaceTime := GetTickCount;
  //m_boGrouped := FALSE;
  m_boOpenHealth := FALSE;
  m_noInstanceOpenHealth := FALSE;
  m_CurMagic.ServerMagicCode := 0;
  //CurMagic.MagicSerial := 0;

  m_nSpellFrame := DEFSPELLFRAME;

  m_nNormalSound := -1;
  m_nFootStepSound := -1; //绝澜  //林牢傍牢版快, CM_WALK, CM_RUN
  m_nAttackSound := -1;
  m_nAttack2Sound := -1;
  m_nAttack3Sound := -1;
  m_nAttack4Sound := -1;
  m_nAttack5Sound := -1;
  m_nWeaponSound := -1;
  m_nStruckSound := s_struck_body_longstick;
  //嘎阑锭 唱绰 家府    SM_STRUCK
  m_nStruckWeaponSound := -1;
  m_nScreamSound := -1;
  m_nDieSound := -1; //绝澜    //磷阑锭 唱绰 家府    SM_DEATHNOW
  m_nDie2Sound := -1;

  SafeFillChar(m_IconInfo[0], SizeOf(TIconInfos), #0);
  SafeFillChar(m_IconInfoShow[0], SizeOf(TIconInfoShows), #0);
  m_nWeaponEffect := 0;
end;

destructor TActor.Destroy;
var
  I: Integer;
  msg: pTChrMsg;
  MoveShow: pTMoveHMShow;
begin
  for I := 0 to m_MsgList.Count - 1 do begin
    msg := m_MsgList.Items[I];
    Dispose(msg);
  end;
  m_MsgList.Free;

  for I := 0 to m_nMoveHpList.Count - 1 do begin
    MoveShow := m_nMoveHpList.Items[I];
    MoveShow.Surface.Free;
    Dispose(MoveShow);
  end;
  m_nMoveHpList.Free;
  //if m_UserNameSurface <> nil then
    //m_UserNameSurface.Free;
  if m_UserShopSurface <> nil then
    m_UserShopSurface.Free;
  ClearSayList();
  m_SayList.Free;
  inherited Destroy;
end;

//角色接收到的消息
procedure TActor.SendMsg(wIdent: Word; nX, nY, ndir, nFeature, nState: Integer;
  sStr: string; nSound: Integer);
var
  msg: pTChrMsg;
begin
  New(msg);
  msg.Ident := wIdent;
  msg.x := nX;
  msg.y := nY;
  msg.dir := ndir;
  msg.feature := nFeature;
  msg.state := nState;
  msg.saying := sStr;
  msg.Sound := nSound;
  m_MsgList.Lock;
  try
    m_MsgList.Add(msg);
  finally
    m_MsgList.UnLock;
  end;
end;

//用新消息更新（若已经存在）消息列表
procedure TActor.UpdateMsg(wIdent: Word; nX, nY, ndir, nFeature, nState:
  Integer; sStr: string; nSound: Integer);
var
  I: Integer;
  msg: pTChrMsg;
begin
  m_MsgList.Lock;
  try
    I := 0;
    while TRUE do begin
      //从当前消息列表中寻找,若找到,则删除,同时清除当前玩家控制的角色的走、跑等消息，因为这些消息已经处理了。
      if I >= m_MsgList.Count then
        break;
      msg := m_MsgList.Items[I];//原代码
      if ((Self = g_MySelf) and (msg.Ident >= 0) and (msg.Ident <= 19)) or (msg.Ident = wIdent) then begin
        Dispose(msg);//删除已经存在的相同消息
        m_MsgList.Delete(I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
  SendMsg(wIdent, nX, nY, ndir, nFeature, nState, sStr, nSound);//添加消息
end;

//清除消息号在[3000,3099]之间的消息
procedure TActor.CleanUserMsgs;
var
  I: Integer;
  msg: pTChrMsg;
begin
  m_MsgList.Lock;
  try
    I := 0;
    while TRUE do begin
      if I >= m_MsgList.Count then
        break;
      msg := m_MsgList.Items[I];
      if (msg.Ident >= 3000) and //基本运动消息：走、跑等
      (msg.Ident <= 3099) then begin
        Dispose(msg);
        m_MsgList.Delete(I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
end;

procedure TActor.Click();
begin
  //
end;

procedure TActor.ClearSayList;
var
  SayMessage: pTSayMessage;
  i: integer;
begin
  for i := 0 to m_SayList.Count - 1 do begin
    SayMessage := m_SayList[i];
    DScreen.DisposeSayMsg(SayMessage);
    Dispose(SayMessage);
  end;
  m_SayList.Clear;
end;
//角色动作动画
procedure TActor.CalcActorFrame;
//var
//  haircount: Integer;
begin
  m_boUseMagic := FALSE;
  m_nCurrentFrame := -1;
  //根据appr计算本角色在图片库中的开始图片索引
  m_nBodyOffset := GetOffset(m_wAppearance);
  //动作对应的图片序列定义
  m_Action := GetRaceByPM(m_btRace, m_wAppearance);
  if m_Action = nil then
    Exit;

  case m_nCurrentAction of
    SM_TURN: begin//转身=站立动作的开始帧 + 方向 X 站立动作的图片数
        m_nStartFrame := m_Action.ActStand.start + m_btDir * (m_Action.ActStand.frame + m_Action.ActStand.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActStand.frame - 1;
        m_dwFrameTime := m_Action.ActStand.ftime;
        m_dwStartTime := GetTickCount;
        m_nDefFrameCount := m_Action.ActStand.frame;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_WALK{走}, SM_RUSH, SM_RUSHKUNG, SM_BACKSTEP: begin//走动=走动动作的开始帧 + 方向 X 每方向走动动作的图片数
        m_nStartFrame := m_Action.ActWalk.start + m_btDir * (m_Action.ActWalk.frame + m_Action.ActWalk.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActWalk.frame - 1;
        m_dwFrameTime := m_Action.ActWalk.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := m_Action.ActWalk.usetick;
        m_nCurTick := 0;
        m_nMoveStep := 1;
            if m_nCurrentAction = SM_BACKSTEP then    //转身
          Shift(GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1)
        else
          Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    SM_HIT{普通攻击}: begin
        m_nStartFrame := m_Action.ActAttack.start + m_btDir * (m_Action.ActAttack.frame + m_Action.ActAttack.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActAttack.frame - 1;
        m_dwFrameTime := m_Action.ActAttack.ftime;
        m_dwStartTime := GetTickCount;
        //WarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_STRUCK{受攻击}: begin
        m_nStartFrame := m_Action.ActStruck.start + m_btDir * (m_Action.ActStruck.frame + m_Action.ActStruck.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActStruck.frame - 1;
        m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
        m_dwStartTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_DEATH{被打死}: begin
        m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
        m_nStartFrame := m_nEndFrame; //
        m_dwFrameTime := m_Action.ActDie.ftime;
        m_dwStartTime := GetTickCount;
      end;
    SM_NOWDEATH: begin//死了
        m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
        m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
        m_dwFrameTime := m_Action.ActDie.ftime;
        m_dwStartTime := GetTickCount;
      end;
    SM_SKELETON: begin//彻底死了（不再动作）
        m_nStartFrame := m_Action.ActDeath.start + m_btDir;
        m_nEndFrame := m_nStartFrame + m_Action.ActDeath.frame - 1;
        m_dwFrameTime := m_Action.ActDeath.ftime;
        m_dwStartTime := GetTickCount;
      end;
  end;
end;

procedure TActor.ReadyAction(msg: TChrMsg);
var
  n: Integer;
  UseMagic: PTUseMagicInfo;
begin
   m_nActBeforeX := m_nCurrX;        //动作之前的位置（当服务器不认可时可以回去)
   m_nActBeforeY := m_nCurrY;

   if msg.Ident = SM_ALIVE then begin      //复活
    m_boDeath := FALSE;
    m_boSkeleton := FALSE;
  end;
  if not m_boDeath then begin
    case msg.Ident of
      SM_TURN, SM_WALK, SM_BACKSTEP, SM_RUSH, SM_MAGICMOVE, SM_MAGICFIR, SM_RUSHCBO, SM_RUSHKUNG, SM_RUN, SM_LEAP, SM_HORSERUN, SM_DIGUP, SM_ALIVE: begin
          m_nFeature := msg.feature;
          m_nState := msg.state;
          //是否可以查看角色生命值
          if m_nState and STATE_OPENHEATH <> 0 then
            m_boOpenHealth := TRUE
          else
            m_boOpenHealth := FALSE;
        end;
    end;
    //      n := 0;
    if g_MySelf = Self then begin
      if (msg.Ident = CM_WALK) then
        if not PlayScene.CanWalk(msg.x, msg.y) then
          Exit; //不可行走
      if (msg.Ident = CM_RUN) then
        if not PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, msg.x, msg.y) then
          Exit; //不能跑
      if (msg.Ident = CM_HORSERUN) then
        if not PlayScene.CanHorseRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, msg.x, msg.y) then
          Exit; //捞悼 阂啊

      //msg
      case msg.Ident of
        CM_TURN: begin
            RealActionMsg := msg;
            msg.Ident := SM_TURN;
          end;
        CM_WALK: begin
            RealActionMsg := msg;
            msg.Ident := SM_WALK;
          end;
        CM_SITDOWN: begin
            RealActionMsg := msg;
            msg.Ident := SM_SITDOWN;
          end;
        CM_RUN: begin
            RealActionMsg := msg;
            msg.Ident := SM_RUN;
          end;
        CM_LEAP: begin
            RealActionMsg := msg;
            msg.Ident := SM_LEAP;
          end;
        CM_HIT: begin
            RealActionMsg := msg;
            msg.Ident := SM_HIT;
          end;
        CM_HEAVYHIT: begin
            RealActionMsg := msg;
            msg.Ident := SM_HEAVYHIT;
          end;
        CM_BIGHIT: begin
            RealActionMsg := msg;
            msg.Ident := SM_BIGHIT;
          end;
        CM_POWERHIT: begin
            RealActionMsg := msg;
            msg.Ident := SM_POWERHIT;
          end;
        CM_LONGHIT: begin
            RealActionMsg := msg;
            msg.Ident := SM_LONGHIT;
          end;
        CM_WIDEHIT: begin
            RealActionMsg := msg;
            msg.Ident := SM_WIDEHIT;
          end;
        CM_LONGICEHIT: begin
            RealActionMsg := msg;//保存当前动作
            if g_boLongIceHitIsLong then
              msg.Ident := SM_LONGICEHIT_L
            else
              msg.Ident := SM_LONGICEHIT_S;
          end;
        CM_HORSERUN: begin
            RealActionMsg := msg;
            msg.Ident := SM_HORSERUN;
          end;
        CM_THROW: begin
            if m_nFeature <> 0 then begin
              m_nTargetX := TActor(msg.feature).m_nCurrX; //x 带瘤绰 格钎
              m_nTargetY := TActor(msg.feature).m_nCurrY; //y
              m_nTargetRecog := TActor(msg.feature).m_nRecogId;
            end;
            RealActionMsg := msg;
            msg.Ident := SM_THROW;
          end;
        CM_FIREHIT: begin//烈火
            RealActionMsg := msg;
            msg.Ident := SM_FIREHIT;
          end;
        CM_CRSHIT: begin
            RealActionMsg := msg;
            msg.Ident := SM_CRSHIT;
          end;
        CM_TWINHIT: begin
            RealActionMsg := msg;
            msg.Ident := SM_TWINHIT;
          end;
        CM_110: begin
            RealActionMsg := msg;
            msg.Ident := SM_110;
          end;
        CM_111: begin
            RealActionMsg := msg;
            msg.Ident := SM_111;
          end;
        CM_112: begin
            RealActionMsg := msg;
            msg.Ident := SM_112;
          end;
        CM_113: begin
            RealActionMsg := msg;
            msg.Ident := SM_113;
          end;
        CM_122: begin
            RealActionMsg := msg;
            msg.Ident := SM_122;
          end;
        CM_56: begin
            RealActionMsg := msg;
            msg.Ident := SM_56;
          end;
        {CM_3037: begin
            RealActionMsg := msg;
            msg.Ident := SM_41;
          end;      }
        CM_SPELL: begin
            RealActionMsg := msg;
            UseMagic := PTUseMagicInfo(msg.feature); //根据msg.feature获得pmag指针
            RealActionMsg.dir := UseMagic.MagicSerial;
            msg.Ident := SM_SPELL {msg.Ident - 3000 5012}; //
          end;
      end;

      m_nOldx := m_nCurrX;
      m_nOldy := m_nCurrY;
      m_nOldDir := m_btDir;
    end;
    case msg.Ident of
      SM_STRUCK: begin
          //Abil.HP := msg.x; {HP}
          //Abil.MaxHP := msg.y; {maxHP}
          //msg.dir {damage}
          //饭骇捞 臭栏搁 嘎绰 矫埃捞 陋促.
          m_nMagicStruckSound := msg.x; //1捞惑, 付过瓤苞
          n := Round(200 - m_Abil.Level * 5);
          if n > 80 then
            m_dwStruckFrameTime := n
          else
            m_dwStruckFrameTime := 80;
          m_dwLastStruckTime := GetTickCount;
        end;
      SM_SPELL: begin
          m_btDir := msg.dir;
          //msg.x  :targetx
          //msg.y  :targety
          UseMagic := PTUseMagicInfo(msg.feature);
          if UseMagic <> nil then begin
            m_CurMagic := UseMagic^;
            m_CurMagic.ServerMagicCode := -1; //FIRE 措扁
            //CurMagic.MagicSerial := 0;
            m_CurMagic.TargX := msg.x;
            m_CurMagic.TargY := msg.y;
            Dispose(UseMagic);
          end;
          //DScreen.AddSysMsg ('SM_SPELL');
        end;
    else begin
        if (msg.X <> 0) and (msg.Y <> 0) and (msg.X < 1000) and (msg.Y < 1000) then begin
          m_nCurrX := msg.x;
          m_nCurrY := msg.y;
          m_btDir := msg.dir;
        end;
      end;
    end;
    if (SM_RUSHCBO = msg.Ident) or (SM_BACKSTEP = msg.Ident) then begin
      m_btDir := LoByte(Word(msg.dir));
      m_btStep := HiByte(Word(msg.dir));
    end;
    //m_btStep
    m_nCurrentAction := msg.Ident;
    CalcActorFrame;
    //DScreen.AddSysMsg (IntToStr(msg.Ident) + ' ' + IntToStr(XX) + ' ' + IntToStr(YY) + ' : ' + IntToStr(msg.x) + ' ' + IntToStr(msg.y));
  end
  else begin
    if msg.Ident = SM_SKELETON then begin
      m_nCurrentAction := msg.Ident;
      CalcActorFrame;
      m_boSkeleton := TRUE;
    end;
  end;
  if (msg.Ident = SM_DEATH) or (msg.Ident = SM_NOWDEATH) then begin
    m_boDeath := TRUE;
    PlayScene.ActorDied(Self);
  end;
  RunSound;
end;

function TActor.GetMessage(ChrMsg: pTChrMsg): Boolean;
var
  msg: pTChrMsg;
begin
  Result := FALSE;
  m_MsgList.Lock;
  try
    if m_MsgList.Count > 0 then begin
      msg := m_MsgList.Items[0];
      ChrMsg.Ident := msg.Ident;
      ChrMsg.x := msg.x;
      ChrMsg.y := msg.y;
      ChrMsg.dir := msg.dir;
      ChrMsg.state := msg.state;
      ChrMsg.feature := msg.feature;
      ChrMsg.saying := msg.saying;
      ChrMsg.Sound := msg.Sound;
      Dispose(msg);
      m_MsgList.Delete(0);
      Result := TRUE;
    end;
  finally
    m_MsgList.UnLock;
  end;
end;

procedure TActor.GetUserName(sStr: string; NameColor: Integer);
var
  sUserName: string;
begin
  if sStr = '' then
    exit;
  m_sDescUserName := GetValidStr3(sStr, sUserName, ['\']);

  ArrestStringEx(m_sDescUserName, '#', '#', m_sGuildName);
  ArrestStringEx(m_sDescUserName, '!', '!', m_sGuildRankName);

  m_sDescUserName := AnsiReplaceText(m_sDescUserName, '#', '');
  m_sDescUserName := AnsiReplaceText(m_sDescUserName, '!', '');
  SetUserName(sUserName, NameColor);
end;

procedure TActor.ProcMsg;
var
  msg: TChrMsg;
  Meff: TMagicEff;
begin
  while (m_nCurrentAction = 0) and GetMessage(@msg) do begin
    case msg.Ident of
      SM_STRUCK: begin
          m_nHiterCode := msg.Sound;
          ReadyAction(msg);
        end;
      {SM_DEATH, //27
      SM_NOWDEATH,
        SM_SKELETON,
        SM_ALIVE,
        SM_ACTION_MIN..SM_ACTION_MAX, //26
      SM_ACTION2_MIN..SM_ACTION2_MAX, //35   2293    293
      3000..3099: ReadyAction(msg);  }
      SM_SPACEMOVE_HIDE: begin//修改传送地图不显示动画
          Meff := TScrollHideEffect.Create(250, 10, m_nCurrX, m_nCurrY, Self);
          PlayScene.m_EffectList.Add(Meff);
          PlaySound(s_spacemove_out);
        end;
      SM_SPACEMOVE_HIDE2: begin
          Meff := TScrollHideEffect.Create(1590, 10, m_nCurrX, m_nCurrY, Self);
          PlayScene.m_EffectList.Add(Meff);
          PlaySound(s_spacemove_out);
        end;
      SM_SPACEMOVE_HIDE3: begin
          if g_WMons[51].Images[3770] <> nil then begin
            Meff := TScrollHideEffect.Create(3770, 10, m_nCurrX, m_nCurrY, Self);
            Meff.ImgLib := g_WMons[51];
            PlayScene.m_EffectList.Add(Meff);
          end
          else begin
            Meff := TScrollHideEffect.Create(1590, 10, m_nCurrX, m_nCurrY, Self);
            PlayScene.m_EffectList.Add(Meff);
            PlaySound(s_spacemove_out);
          end;
          PlaySound(s_spacemove_out);
        end;
      SM_SPACEMOVE_SHOW: begin//修改传送地图不显示动画
          Meff := TCharEffect.Create(260, 10, Self);
          PlayScene.m_EffectList.Add(Meff);
          msg.Ident := SM_TURN;
          ReadyAction(msg);
          PlaySound(s_spacemove_in);
        end;
      SM_SPACEMOVE_SHOW2: begin
          Meff := TCharEffect.Create(1600, 10, Self);
          PlayScene.m_EffectList.Add(Meff);
          msg.Ident := SM_TURN;
          ReadyAction(msg);
          PlaySound(s_spacemove_in);
        end;
      SM_SPACEMOVE_SHOW3: begin
          if g_WMons[51].Images[3780] <> nil then begin
            Meff := TCharEffect.Create(3780, 10, Self);
            Meff.ImgLib := g_WMons[51];
            PlayScene.m_EffectList.Add(Meff);
          end
          else begin
            Meff := TCharEffect.Create(1600, 10, Self);
            PlayScene.m_EffectList.Add(Meff);
            msg.Ident := SM_TURN;
          end;
          msg.Ident := SM_TURN;
          ReadyAction(msg);
          PlaySound(s_spacemove_in);
        end;
    else begin
        ReadyAction(msg); //Damian
      end;
    end;
  end;
end;

procedure TActor.ProcHurryMsg; //紧急消息处理：使用魔法、魔法失败
var
  n: Integer;
  msg: TChrMsg;
  fin: Boolean;
begin
  n := 0;
  while TRUE do begin
    if m_MsgList.Count <= n then
      break;
    msg := pTChrMsg(m_MsgList[n])^;//取出消息
    fin := FALSE;
    case msg.Ident of
      SM_MAGICFIRE:
        if m_CurMagic.ServerMagicCode <> 0 then begin
          m_CurMagic.ServerMagicCode := 111;
          m_CurMagic.Target := msg.x;
          if msg.y in [0..MAXMAGICTYPE - 1] then
            m_CurMagic.EffectType := TMagicType(msg.y); //EffectType
          m_CurMagic.EffectNumber := msg.dir; //Effect
          m_CurMagic.TargX := msg.feature;
          m_CurMagic.TargY := msg.state;
          m_CurMagic.Recusion := TRUE;
          fin := TRUE;
               //这里可以显示使用魔法的名称，但是客户端不知道魔法的名称，
               //应该在本地保留一个魔法名称列表，根据ServerMaigicCode获得名称
        end;
      SM_MAGICFIRE_FAIL:
        if m_CurMagic.ServerMagicCode <> 0 then begin
          m_CurMagic.ServerMagicCode := 0;
          fin := TRUE;
        end;
    end;
    if fin then begin
      Dispose(pTChrMsg(m_MsgList[n]));
      m_MsgList.Delete(n);
    end
    else
      Inc(n);
  end;
end;
//当前是否没有可执行的动作
function TActor.IsIdle: Boolean;
begin
  if (m_nCurrentAction = 0) and (m_MsgList.Count = 0) then
    Result := TRUE
  else
    Result := FALSE;
end;
//当前动作是否已经完成
function TActor.ActionFinished: Boolean;
begin
  if (m_nCurrentAction = 0) or (m_nCurrentFrame >= m_nEndFrame) then
    Result := TRUE
  else
    Result := FALSE;
end;
//可否行走
function TActor.CanWalk: Integer;
begin
  if (GetTickCount - g_dwLatestSpellTick < g_dwMagicPKDelayTime) then
    Result := -1 //掉饭捞
  else
    Result := 1;
end;
//可否跑
function TActor.CanRun: Integer;
begin
  Result := 1;
  //检查人物的HP值是否低于指定值，低于指定值将不允许跑
  if m_Abil.HP < RUN_MINHEALTH then begin
    Result := -1;
  end; // else
  //检查人物是否被攻击，如果被攻击将不允许跑，取消检测将可以跑步逃跑
//   if (GetTickCount - LastStruckTime < 3*1000) or (GetTickCount - LatestSpellTime < MagicPKDelayTime) then
//      Result := -2;

end;

function TActor.Strucked: Boolean;
var
  I: Integer;
begin
  Result := FALSE;
  for I := 0 to m_MsgList.Count - 1 do begin
    if pTChrMsg(m_MsgList[I]).Ident = SM_STRUCK then begin
      Result := TRUE;
      break;
    end;
  end;
end;

//dir : 方向
//step : 步长  (走是1，跑是2）
//cur : 当前帧(全部帧中的第几帧）
//max : 全部帧

procedure TActor.Shift(dir, step, cur, max: Integer);
var
  unx, uny, ss, v: Integer;
begin
  unx := UNITX * step;
  uny := UNITY * step;
  if cur > max then
    cur := max;
  m_nRx := m_nCurrX;
  m_nRy := m_nCurrY;
  //  ss := Round((max - cur - 1) / max) * step;
  case dir of
    DR_UP: begin
        ss := Round((max - cur) / max) * step;
        m_nShiftX := 0;
        m_nRy := m_nCurrY + ss;
        if ss = step then
          m_nShiftY := -Round(uny / max * cur)
        else
          m_nShiftY := Round(uny / max * (max - cur));
      end;
    DR_UPRIGHT: begin
        if max >= 6 then
          v := 2
        else
          v := 0;
        ss := Round((max - cur + v) / max) * step;
        m_nRx := m_nCurrX - ss;
        m_nRy := m_nCurrY + ss;
        if ss = step then begin
          m_nShiftX := Round(unx / max * cur);
          m_nShiftY := -Round(uny / max * cur);
        end
        else begin
          m_nShiftX := -Round(unx / max * (max - cur));
          m_nShiftY := Round(uny / max * (max - cur));
        end;
      end;
    DR_RIGHT: begin
        ss := Round((max - cur) / max) * step;
        m_nRx := m_nCurrX - ss;
        if ss = step then
          m_nShiftX := Round(unx / max * cur)
        else
          m_nShiftX := -Round(unx / max * (max - cur));
        m_nShiftY := 0;
      end;
    DR_DOWNRIGHT: begin
        if max >= 6 then
          v := 2
        else
          v := 0;
        ss := Round((max - cur - v) / max) * step;
        m_nRx := m_nCurrX - ss;
        m_nRy := m_nCurrY - ss;
        if ss = step then begin
          m_nShiftX := Round(unx / max * cur);
          m_nShiftY := Round(uny / max * cur);
        end
        else begin
          m_nShiftX := -Round(unx / max * (max - cur));
          m_nShiftY := -Round(uny / max * (max - cur));
        end;
      end;
    DR_DOWN: begin
        if max >= 6 then
          v := 1
        else
          v := 0;
        ss := Round((max - cur - v) / max) * step;
        m_nShiftX := 0;
        m_nRy := m_nCurrY - ss;
        if ss = step then
          m_nShiftY := Round(uny / max * cur)
        else
          m_nShiftY := -Round(uny / max * (max - cur));
      end;
    DR_DOWNLEFT: begin
        if max >= 6 then
          v := 2
        else
          v := 0;
        ss := Round((max - cur - v) / max) * step;
        m_nRx := m_nCurrX + ss;
        m_nRy := m_nCurrY - ss;
        if ss = step then begin
          m_nShiftX := -Round(unx / max * cur);
          m_nShiftY := Round(uny / max * cur);
        end
        else begin
          m_nShiftX := Round(unx / max * (max - cur));
          m_nShiftY := -Round(uny / max * (max - cur));
        end;
      end;
    DR_LEFT: begin
        ss := Round((max - cur) / max) * step;
        m_nRx := m_nCurrX + ss;
        if ss = step then
          m_nShiftX := -Round(unx / max * cur)
        else
          m_nShiftX := Round(unx / max * (max - cur));
        m_nShiftY := 0;
      end;
    DR_UPLEFT: begin
        if max >= 6 then
          v := 2
        else
          v := 0;
        ss := Round((max - cur + v) / max) * step;
        m_nRx := m_nCurrX + ss;
        m_nRy := m_nCurrY + ss;
        if ss = step then begin
          m_nShiftX := -Round(unx / max * cur);
          m_nShiftY := -Round(uny / max * cur);
        end
        else begin
          m_nShiftX := Round(unx / max * (max - cur));
          m_nShiftY := Round(uny / max * (max - cur));
        end;
      end;
  end;
end;

procedure TActor.ShowEffect(nID, nX, nY: Integer);
var
  Meff: TMagicEff;
begin
  Meff := nil;
  case nID of
    Effect_DEADLINESS: begin
        Meff := TCharEffect.Create(1416 {4190}, 12, Self);
        Meff.ImgLib := g_WMain99Images;
        Meff.NextFrameTime := 60 {80};
      end;
    Effect_VAMPIRE: begin
        Meff := TCharEffect.Create(1090, 10, Self);
        Meff.ImgLib := g_WMagic2Images;
        Meff.NextFrameTime := 50;
      end;
    EFFECT_MISSION_ACCEPT: begin
        Meff := TCharEffect.Create(1337, 34, Self, False);
        Meff.ImgLib := g_WMain99Images;
        Meff.NextFrameTime := 80;
      end;
    EFFECT_MISSION_NEXT: begin
        Meff := TCharEffect.Create(1217, 28, Self, False);
        Meff.ImgLib := g_WMain99Images;
        Meff.NextFrameTime := 80;
      end;
    EFFECT_MISSION_COMPLETE: begin
        Meff := TCharEffect.Create(1246, 20, Self, False);
        Meff.ImgLib := g_WMain99Images;
        Meff.NextFrameTime := 80;
      end;
    EFFECT_DARE_WIN: begin
        Meff := TCharEffect.Create(1371, 45, Self, False);
        Meff.ImgLib := g_WMain99Images;
        Meff.NextFrameTime := 65;
        PlaySoundEx('wav\dare-win.wav');
      end;
    EFFECT_DARE_LOSS: begin
        Meff := TCharEffect.Create(1278, 58, Self, False);
        Meff.ImgLib := g_WMain99Images;
        Meff.NextFrameTime := 90;
        PlaySoundEx('wav\dare-death.wav');
      end;
    EFFECT_BEACON_1,
      EFFECT_BEACON_2,
      EFFECT_BEACON_3: begin
        Meff := TCharEffect.Create((nID - EFFECT_BEACON_1) * 20, 20, Self);
        Meff.ImgLib := g_WMagic3Images;
        Meff.NextFrameTime := 100;
      end;
    EFFECT_BEACON_4,
      EFFECT_BEACON_5,
      EFFECT_BEACON_6,
      EFFECT_BEACON_7,
      EFFECT_BEACON_8,
      EFFECT_BEACON_9,
      EFFECT_BEACON_10: begin
        Meff := TNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WMagic3Images, (nID - EFFECT_BEACON_1) * 20,
          20, 100, True);
        PlaySoundEx('wav\newysound-mix.wav');
      end;
    EFFECT_LEVELUP: begin
        Meff := TCharEffect.Create(2020, 16, Self);
        Meff.ImgLib := g_WMain99Images;
        Meff.NextFrameTime := 100;
        PlaySoundEx('wav\powerup.wav');
      end;
    EFFECT_SHIELD: begin
        Meff := TCharEffect.Create(790, 10, Self);
        Meff.ImgLib := g_WMagic5Images;
        Meff.NextFrameTime := 60 {80};
        PlaySoundEx(bmg_heroshield);
      end;
  end;
  if Meff <> nil then
    PlayScene.m_EffectList.Add(Meff);
end;
//人物外貌特征改变
procedure TActor.FeatureChanged;
//var
//  haircount: Integer;
begin
  case m_btRace of
    0: begin//人物
        m_btHair := HAIRfeature(m_nFeature); // 得到M2发来对应的发型 , 女=7 男=6 主体,英雄 女=3 男=4
        m_btDress := DRESSfeature(m_nFeature);
        m_btWeapon := WEAPONfeature(m_nFeature);

        m_btHorse := Horsefeature(m_nFeatureEx);
        m_btEffect := Effectfeature(m_nFeatureEx);
        m_nBodyOffset := HUMANFRAME * m_btDress; //男0, 女1
        m_nHairOffset := HUMHAIRANFRAME * m_btHair;
        m_nWeaponOffset := HUMANFRAME * m_btWeapon; //(weapon*2 + m_btSex);

        if m_btEffect > 0 then
          m_nHumWinOffset := (m_btEffect - 1) * HUMANFRAME;
      end;
    50: ; //npc
  else begin
      m_wAppearance := APPRfeature(m_nFeature);
      m_nBodyOffset := GetOffset(m_wAppearance);
      //BodyOffset := MONFRAME * (Appearance mod 10);
    end;
  end;
end;
{
function TActor.Light: Integer;
begin
Result := m_nChrLight;
end;
     }
//装载当前动作对应的图片
procedure TActor.LoadSurface;
var
  mimg: TWMImages;
begin
  mimg := GetMonImg(m_wAppearance);
  if mimg <> nil then begin
    if (not m_boReverseFrame) then
      m_BodySurface := mimg.GetCachedImage(GetOffset(m_wAppearance) + m_nCurrentFrame, m_nPx, m_nPy)
    else
      m_BodySurface := mimg.GetCachedImage(GetOffset(m_wAppearance) + m_nEndFrame - (m_nCurrentFrame - m_nStartFrame), m_nPx, m_nPy);
  end;
end;

//取角色的宽度
function TActor.CharWidth: Integer;
begin
  if m_BodySurface <> nil then
    Result := m_BodySurface.Width
  else
    Result := 48;
end;
//取角色的高度
function TActor.CharHeight: Integer;
begin
  if m_BodySurface <> nil then
    Result := m_BodySurface.Height
  else
    Result := 70;
end;
//判断某一点是否是角色的身体
function TActor.CheckSelect(dx, dy: Integer): Boolean;
var
  c: Integer;
begin
  Result := FALSE;             //错误
  if m_BodySurface <> nil then begin
    c := m_BodySurface.Pixels[dx, dy];
    if (c <> 0) and
      ((m_BodySurface.Pixels[dx - 1, dy] <> 0) and
      (m_BodySurface.Pixels[dx + 1, dy] <> 0) and
      (m_BodySurface.Pixels[dx, dy - 1] <> 0) and
      (m_BodySurface.Pixels[dx, dy + 1] <> 0)) then
      Result := TRUE;
  end;
end;

procedure TActor.DrawEffSurface(dsurface, source: TDirectDrawSurface; ddx, ddy:
  Integer; blend: Boolean; ceff: TColorEffect; blendmode: integer);
begin
  if m_nState and $00800000 <> 0 then begin
    blend := TRUE; //隐身状态
  end;
  if (not blend) and (blendmode = 0) then begin
    if ceff = ceNone then begin
      if source <> nil then
        dsurface.Draw(ddx, ddy, source.ClientRect, source, TRUE);
    end
    else begin
      if source <> nil then begin
        DrawEffect(dsurface, ddx, ddy, source, ceff, blend, blendmode);
      end;
    end;
  end
  else begin
    if ceff = ceNone then begin
      if source <> nil then
        DrawBlend(dsurface, ddx, ddy, source, blendmode);
    end
    else begin
      if source <> nil then begin
        DrawEffect(dsurface, ddx, ddy, source, ceff, blend, blendmode);
      end;
    end;
  end;
end;

//画武器闪烁光
procedure TActor.DrawWeaponGlimmer(dsurface: TDirectDrawSurface; ddx, ddy:
  Integer);
//var
//  idx, ax, ay: Integer;
//  d: TDirectDrawSurface;
begin
  //荤侩救窃..(堪拳搬) 弊贰侨 坷幅...
  (*if BoNextTimeFireHit and WarMode and GlimmingMode then begin
     if GetTickCount - GlimmerTime > 200 then begin
        GlimmerTime := GetTickCount;
        Inc (CurGlimmer);
        if CurGlimmer >= MaxGlimmer then CurGlimmer := 0;
     end;
     idx := GetEffectBase (5-1{堪拳搬馆娄烙}, 1) + Dir*10 + CurGlimmer;
     d := FrmMain.WMagic.GetCachedImage (idx, ax, ay);
     if d <> nil then
        DrawBlend (dsurface, ddx + ax, ddy + ay, d, 1);
                         //dx + ax + ShiftX,
                         //dy + ay + ShiftY,
                         //d, 1);
  end;*)
end;
//人物显示颜色，中毒
//根据当前状态state获得颜色效果（比如中毒状态等，人物显示的颜色就可能不同）
function TActor.GetDrawEffectValue: TColorEffect;
var
  ceff: TColorEffect;
begin
  ceff := ceNone;

   //高亮
  if ((g_FocusCret = Self) or (g_MagicTarget = Self)) and (m_nState and $00800000 = 0) then begin
    ceff := ceBright;
  end;

   //中了绿毒
  if m_nState and $80000000 <> 0 then begin
    ceff := ceGreen;
  end;
  if m_nState and $40000000 <> 0 then begin
    ceff := ceRed;
  end;
  if m_nState and $20000000 <> 0 then begin
    ceff := ceBlue;
  end;
  if m_nState and $10000000 <> 0 then begin
    ceff := ceYellow;
  end;
  //付厚幅
  if m_nState and $08000000 <> 0 then begin
    ceff := ceFuchsia;
  end;
  if m_nState and $04000000 <> 0 then begin
    ceff := ceGrayScale;
  end;
  Result := ceff;
end;

procedure TActor.DrawChr(dsurface: TDirectDrawSurface; dx, dy: Integer; blend:
  Boolean; boFlag: Boolean);
//显示角色
var
  idx, ax, ay: Integer;
  d: TDirectDrawSurface;
  ceff: TColorEffect;
  wimg: TWMImages;
begin
  d := nil; //jacky
  if not (m_btDir in [0..7]) then
    Exit;
  if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
    m_dwLoadSurfaceTime := GetTickCount;
    LoadSurface; //由于图片每60秒会释放一次（60秒内未使用的话），所以每60秒要检查一下是否已经被释放了.
  end;

  ceff := GetDrawEffectValue;

  if m_BodySurface <> nil then begin
    DrawEffSurface(dsurface,
      m_BodySurface,
      dx + m_nPx + m_nShiftX,
      dy + m_nPy + m_nShiftY,
      blend,
      ceff);
  end;

  if m_boUseMagic {and (EffDir[Dir] = 1)} and (m_CurMagic.EffectNumber > 0) then
    if m_nCurEffFrame in [0..m_nSpellFrame - 1] then begin
      GetEffectBase(m_CurMagic.EffectNumber - 1, 0, wimg, idx);
      idx := idx + m_nCurEffFrame;
      if wimg <> nil then
        d := wimg.GetCachedImage(idx, ax, ay);
      if d <> nil then
        DrawBlend(dsurface,
          dx + ax + m_nShiftX,
          dy + ay + m_nShiftY,
          d, 1);
    end;
end;

procedure TActor.DrawEff(dsurface: TDirectDrawSurface; dx, dy: Integer);
begin
end;

procedure TActor.DrawStruck(dsurface: TDirectDrawSurface);
var
  i, ii, ax, ay, nx, ny: integer;
  MoveShow: pTMoveHMShow;
  Index: integer;
  SayMessage: pTSayMessage;
  SayImage: pTSayImage;
  d: TDirectDrawSurface;
  py: smallint;
begin
  if (GetTickCount < m_dwSayTime) then begin
    for I := 0 to m_SayList.Count - 1 do begin
      SayMessage := m_SayList[i];
      ax := m_nSayX - (m_SayWidthsArr div 2);
      ay := m_nSayY - 3 - (m_SayList.Count * 16) + i * 16;
      if not m_boDeath then
        Dec(ay, m_nShowY);
      dsurface.Draw(ax, ay, SayMessage.SaySurface.ClientRect, SayMessage.SaySurface, True);
      if (SayMessage.ImageList <> nil) and (SayMessage.ImageList.Count > 0) then begin
        for ii := 0 to SayMessage.ImageList.Count - 1 do begin
          SayImage := SayMessage.ImageList[ii];
          if (SayImage.nIndex <= High(g_FaceIndexInfo)) then begin
            d := g_WFaceImages.GetCachedImage(g_FaceIndexInfo[SayImage.nIndex].ImageIndex, nx, ny);
            if d <> nil then begin
              dsurface.Draw(ax + SayImage.nLeft, ay + (SAYLISTHEIGHT - d.Height) div 2 - 1, d.ClientRect, d, True);
              py := ny;
              if (GetTickCount - g_FaceIndexInfo[SayImage.nIndex].dwShowTime) > LongWord(nx) then begin
                g_FaceIndexInfo[SayImage.nIndex].ImageIndex := g_FaceIndexInfo[SayImage.nIndex].ImageIndex + py;
                g_FaceIndexInfo[SayImage.nIndex].dwShowTime := GetTickCount;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  i := 0;
  while TRUE do begin
    if I >= m_nMoveHpList.Count then
      break;
    MoveShow := m_nMoveHpList.Items[I];
    Index := (GetTickCount - MoveShow.dwMoveHpTick) div 40;
    if Index > 40 then begin
      MoveShow.Surface.Free;
      m_nMoveHpList.Delete(I);
      Dispose(MoveShow);
    end
    else if Index > 20 then begin
      g_DXCanvas.Draw(m_nSayX - MoveShow.Surface.Width div 2, m_nSayY - Index - 30,
        MoveShow.Surface.ClientRect, MoveShow.Surface, TRUE,
        cColor4($FFFFFF or (((45 - Index) * 10) shl 24 and $FF000000)));
      Inc(I);
    end
    else begin
      dsurface.Draw(m_nSayX - MoveShow.Surface.Width div 2, m_nSayY - Index - 30,
        MoveShow.Surface.ClientRect, MoveShow.Surface, TRUE);
      Inc(I);
    end;
  end;
end;
//缺省帧
function TActor.GetDefaultFrame(wmode: Boolean): Integer;
var
  cf: Integer;
  pm: pTMonsterAction;
begin
  Result := 0; //Jacky
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    Exit;
  m_dwDefFrameTick := pm.ActStand.ftime;
   if m_boDeath then begin            //死亡
      if m_boSkeleton then            //地上尸体骷髅
      Result := pm.ActDeath.start
    else
      Result := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
  end
  else begin
    m_nDefFrameCount := pm.ActStand.frame;
    if m_nCurrentDefFrame < 0 then
      cf := 0
    else if m_nCurrentDefFrame >= pm.ActStand.frame then
      cf := 0
    else
      cf := m_nCurrentDefFrame;
    Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
  end;
end;
//默认运动
procedure TActor.DefaultMotion;   //缺省动作
begin
  m_boReverseFrame := FALSE;
  if m_boWarMode then begin
    if (GetTickCount - m_dwWarModeTime > 4 * 1000) then
      //and not BoNextTimeFireHit then
      m_boWarMode := FALSE;
  end;
  m_nCurrentFrame := GetDefaultFrame(m_boWarMode and (m_btHorse = 0));
  Shift(m_btDir, 0, 1, 1);
end;

//人物动作声音(脚步声、武器攻击声)

procedure TActor.SetSound;
var
  cx, cy, bidx, wunit, attackweapon: Integer;
  hiter: TActor;
begin
  if m_btRace = 0 then begin{人类}
    if (Self = g_MySelf) and//基本动作
      ((m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_RUN) or
      (m_nCurrentAction = SM_LEAP) or
      (m_nCurrentAction = SM_HORSERUN) or
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)) then begin

      if m_btHorse = 0 then begin
        cx := g_MySelf.m_nCurrX - Map.m_nBlockLeft;
        cy := g_MySelf.m_nCurrY - Map.m_nBlockTop;
        cx := cx div 2 * 2;
        cy := cy div 2 * 2;
        bidx := Map.m_MArr[cx, cy].wBkImg and $7FFF;
        wunit := Map.m_MArr[cx, cy].btArea;
        bidx := wunit * 10000 + bidx - 1;
        case bidx of
          330..349, 450..454, 550..554, 750..754,
            950..954, 1250..1254, 1400..1424, 1455..1474,
            1500..1524, 1550..1574:
               m_nFootStepSound := s_walk_lawn_l;  //草地上行走

          250..254, 1005..1009, 1050..1054, 1060..1064, 1450..1454,
            1650..1654:
               m_nFootStepSound := s_walk_rough_l; //粗糙的地面

          605..609, 650..654, 660..664, 2000..2049,
            3025..3049, 2400..2424, 4625..4649, 4675..4678:
               m_nFootStepSound := s_walk_stone_l;  //石头地面上行走

          1825..1924, 2150..2174, 3075..3099, 3325..3349,
            3375..3399:
               m_nFootStepSound := s_walk_cave_l;  //洞穴里行走

          3230, 3231, 3246, 3277:
               m_nFootStepSound := s_walk_wood_l;  //木头地面行走

          //带傈..
          3780..3799:
            m_nFootStepSound := s_walk_wood_l;

          3825..4434:
            if (bidx - 3825) mod 25 = 0 then
              m_nFootStepSound := s_walk_wood_l
            else
              m_nFootStepSound := s_walk_ground_l;

          2075..2099, 2125..2149:
               m_nFootStepSound := s_walk_room_l;   //房间里

          1800..1824:
               m_nFootStepSound := s_walk_water_l;  //水中

        else
          m_nFootStepSound := s_walk_ground_l;
        end;
        //泵傈郴何
        if (bidx >= 825) and (bidx <= 1349) then begin
          if ((bidx - 825) div 25) mod 2 = 0 then
            m_nFootStepSound := s_walk_stone_l;
        end;
        //悼奔郴何
        if (bidx >= 1375) and (bidx <= 1799) then begin
          if ((bidx - 1375) div 25) mod 2 = 0 then
            m_nFootStepSound := s_walk_cave_l;
        end;
        case bidx of
          1385, 1386, 1391, 1392:
            m_nFootStepSound := s_walk_wood_l;
        end;

         bidx := Map.m_MArr[cx, cy].wMidImg and $7FFF;   //检查地图属性
        bidx := bidx - 1;
        case bidx of
          0..115:
            m_nFootStepSound := s_walk_ground_l;
          120..124:
            m_nFootStepSound := s_walk_lawn_l;
        end;

        bidx := Map.m_MArr[cx, cy].wFrImg and $7FFF;
        bidx := bidx - 1;
        case bidx of
          //寒倒辨
          221..289, 583..658, 1183..1206, 7163..7295,
            7404..7414:
            m_nFootStepSound := s_walk_stone_l;
          //唱公付风
          3125..3267, {3319..3345, 3376..3433,} 3757..3948,
          6030..6999:
            m_nFootStepSound := s_walk_wood_l;
          //规官蹿
          3316..3589:
            m_nFootStepSound := s_walk_room_l;
        end;
      end
      else
        m_nFootStepSound := s_horsewalk;

      if (m_nCurrentAction = SM_RUN) or (m_nCurrentAction = SM_LEAP) or (m_nCurrentAction = SM_HORSERUN) then
        m_nFootStepSound := m_nFootStepSound + 2;

    end;

      if m_btSex = 0 then begin //男
      m_nScreamSound := s_man_struck;
      m_nDieSound := s_man_die;
    end
    else begin //女
      m_nScreamSound := s_wom_struck;
      m_nDieSound := s_wom_die;
    end;

      case m_nCurrentAction of      //攻击动作
      SM_THROW, SM_HIT, SM_HIT + 1, SM_HIT + 2, SM_POWERHIT, SM_LONGHIT, SM_LONGICEHIT_L, SM_LONGICEHIT_S,
        SM_WIDEHIT, SM_FIREHIT, SM_CRSHIT, SM_TWINHIT, SM_110, SM_111, SM_112, SM_113, SM_122, SM_56: begin
          case (m_btWeapon div 2) of
            6, 20: m_nWeaponSound := s_hit_short;
            1: m_nWeaponSound := s_hit_wooden;
            2, 13, 9, 5, 14, 22: m_nWeaponSound := s_hit_sword;
            4, 17, 10, 15, 16, 23: m_nWeaponSound := s_hit_do;
            3, 7, 11: m_nWeaponSound := s_hit_axe;
            24: m_nWeaponSound := s_hit_club;
            8, 12, 18, 21: m_nWeaponSound := s_hit_long;
          else
            m_nWeaponSound := s_hit_fist;
          end;
        end;
      SM_STRUCK: begin//受攻击
          if m_nMagicStruckSound >= 1 then begin //付过栏肺 嘎澜
            //strucksound := s_struck_magic;  //烙矫..
          end
          else begin
            hiter := PlayScene.FindActor(m_nHiterCode);
            //            attackweapon := 0;
            if hiter <> nil then begin //锭赴仇捞 公均栏肺 锭啡绰瘤 八荤
              attackweapon := hiter.m_btWeapon div 2;
              if hiter.m_btRace = 0 then
                case (m_btDress div 2) of
                  3: //癌渴
                    case attackweapon of
                      6: m_nStruckSound := s_struck_armor_sword;
                      1, 2, 4, 5, 9, 10, 13, 14, 15, 16, 17: m_nStruckSound :=
                        s_struck_armor_sword;
                      3, 7, 11: m_nStruckSound := s_struck_armor_axe;
                      8, 12, 18: m_nStruckSound := s_struck_armor_longstick;
                    else
                      m_nStruckSound := s_struck_armor_fist;
                    end;
                else //老馆
                  case attackweapon of
                    6: m_nStruckSound := s_struck_body_sword;
                    1, 2, 4, 5, 9, 10, 13, 14, 15, 16, 17: m_nStruckSound :=
                      s_struck_body_sword;
                    3, 7, 11: m_nStruckSound := s_struck_body_axe;
                    8, 12, 18: m_nStruckSound := s_struck_body_longstick;
                  else
                    m_nStruckSound := s_struck_body_fist;
                  end;
                end;
            end;
          end;
        end;
    end;

    //付过 家府
    if m_boUseMagic and (m_CurMagic.MagicSerial > 0) then begin
      if m_CurMagic.MagicSerial = 123 then begin
        m_nMagicStartSound := 10000 + m_CurMagic.MagicSerial * 10 + m_btSex;
        m_nMagicFireSound := -1;
      end
      else begin
        m_nMagicStartSound := 10000 + m_CurMagic.MagicSerial * 10;
        m_nMagicFireSound := 10000 + m_CurMagic.MagicSerial * 10 + 1;
      end;
      m_nMagicExplosionSound := 10000 + m_CurMagic.MagicSerial * 10 + 2;
    end;

  end
  else begin
    if m_nCurrentAction = SM_STRUCK then begin//受攻击
      if m_nMagicStruckSound >= 1 then begin //付过栏肺 嘎澜
        //strucksound := s_struck_magic;  //烙矫..
      end
      else begin
        hiter := PlayScene.FindActor(m_nHiterCode);
        if hiter <> nil then begin //锭赴仇捞 公均栏肺 锭啡绰瘤 八荤
          attackweapon := hiter.m_btWeapon div 2;
          case attackweapon of
            6: m_nStruckSound := s_struck_body_sword;
            1, 2, 4, 5, 9, 10, 13, 14, 15, 16, 17: m_nStruckSound := s_struck_body_sword;
            3, 11: m_nStruckSound := s_struck_body_axe;
            8, 12, 18: m_nStruckSound := s_struck_body_longstick;
          else
            m_nStruckSound := s_struck_body_fist;
          end;
        end;
      end;
    end;

    if m_btRace = 50 then begin
    end
    else begin
      m_nAppearSound := 200 + (m_wAppearance) * 10;
      m_nNormalSound := 200 + (m_wAppearance) * 10 + 1;
      m_nAttackSound := 200 + (m_wAppearance) * 10 + 2; //快况撅
      m_nWeaponSound := 200 + (m_wAppearance) * 10 + 3; //茸(公扁戎滴冯)
      m_nScreamSound := 200 + (m_wAppearance) * 10 + 4;
      m_nDieSound := 200 + (m_wAppearance) * 10 + 5;
      m_nDie2Sound := 200 + (m_wAppearance) * 10 + 6;
      m_nAttack2Sound := 200 + (m_wAppearance) * 10 + 7;
      m_nAttack3Sound := 200 + (m_wAppearance) * 10 + 8;
      m_nAttack4Sound := 200 + (m_wAppearance) * 10 + 9;
    end;
  end;

  //漠 嘎绰 家府
  if m_nCurrentAction = SM_STRUCK then begin//受攻击
    hiter := PlayScene.FindActor(m_nHiterCode);
    //    attackweapon := 0;
    if hiter <> nil then begin //锭赴仇捞 公均栏肺 锭啡绰瘤 八荤
      attackweapon := hiter.m_btWeapon div 2;
      if hiter.m_btRace = 0 then//人类
        case (attackweapon div 2) of
          6, 20: m_nStruckWeaponSound := s_struck_short;
          1: m_nStruckWeaponSound := s_struck_wooden;
          2, 13, 9, 5, 14, 22: m_nStruckWeaponSound := s_struck_sword;
          4, 17, 10, 15, 16, 23: m_nStruckWeaponSound := s_struck_do;
          3, 7, 11: m_nStruckWeaponSound := s_struck_axe;
          24: m_nStruckWeaponSound := s_struck_club;
          8, 12, 18, 21: m_nStruckWeaponSound := s_struck_wooden; //long;
          //else struckweaponsound := s_struck_fist;
        end;
    end;
  end;
end;
(*
procedure TActor.LoadUsername();
{var
 nWidth, nHeight: Integer;  }
begin
 m_UserNameSurface := nil;
{ nWidth := frmMain.Canvas.TextWidth(m_UserName) + 2;
 nHeight := frmMain.Canvas.TextHeight(m_UserName) + 2;
 m_UserNameSurface := TDirectDrawSurface.Create(DDraw);
 m_UserNameSurface.SystemMemory := True;
 m_UserNameSurface.SetSize(nWidth, nHeight);
 m_UserNameSurface.Canvas.Font.Name := DEF_FONT_NAME;
 m_UserNameSurface.Canvas.Font.Size := DEF_FONT_SIZE;
 m_UserNameSurface.Fill(0);
 SetBkMode(m_UserNameSurface.Canvas.Handle, TRANSPARENT);
 BoldTextOutEx(m_UserNameSurface, 1, 1, clwhite, $8, m_UserName);
 m_UserNameSurface.Canvas.Release;   }
end;
     *)

procedure TActor.LoadShopTitle();
begin
  if m_UserShopSurface <> nil then
    m_UserShopSurface.Free;
  m_UserShopSurface := nil;
end;

procedure TActor.SetEffigyState(nEffigyState, nOffset: Integer);
begin

end;

procedure TActor.SetUsername(Username: string; nameColor: Integer; boClear: Boolean);
begin
  if boClear then begin

  end
  else begin
    if NameColor <> -1 then begin
      m_OldNameColor := NameColor;
      m_NameColor := GetRGB(NameColor);
    end;
    if Username <> '' then
      m_UserName := Username;
    m_NameWidth := g_DXCanvas.TextWidth(m_UserName);
  end;
end;
//播放动作声效
procedure TActor.RunSound;
begin
  m_boRunSound := TRUE;
  SetSound;
  case m_nCurrentAction of
    SM_STRUCK: begin//被攻击
        if (m_nStruckWeaponSound >= 0) then
          PlaySound(m_nStruckWeaponSound);//攻击的武器的声效
        if (m_nStruckSound >= 0) then
          PlaySound(m_nStruckSound); //被攻击的声效
        if (m_nScreamSound >= 0) then
          PlaySound(m_nScreamSound);//尖叫
      end;
    SM_NOWDEATH: begin
        if (m_nDieSound >= 0) then begin
          PlaySound(m_nDieSound);
          //              if Self.m_btRace = RC_USERHUMAN then
          if Self = g_MySelf then begin
            g_TargetCret := nil;
            FrmDlg2.DWndDeath.Visible := True;
            g_boDoctorAlive := False;
          end;
          //PlayBGM(bmg_gameover);
        end;
      end;
    SM_THROW, SM_HIT, SM_FLYAXE, SM_DIGDOWN: begin
        if m_nAttackSound >= 0 then
          PlaySound(m_nAttackSound);
      end;
    SM_HIT_2: begin
        if m_nAttack2Sound >= 0 then
          PlaySound(m_nAttack2Sound)
        else if m_nAttackSound >= 0 then
          PlaySound(m_nAttackSound);
      end;
    SM_HIT_3: begin
        if m_nAttack3Sound >= 0 then
          PlaySound(m_nAttack3Sound)
        else if m_nAttackSound >= 0 then
          PlaySound(m_nAttackSound);
      end;
    SM_HIT_4: begin
        if m_nAttack4Sound >= 0 then
          PlaySound(m_nAttack4Sound)
        else if m_nAttackSound >= 0 then
          PlaySound(m_nAttackSound);
      end;
    SM_HIT_5: begin
        if m_nAttack5Sound >= 0 then
          PlaySound(m_nAttack5Sound)
        else if m_nAttackSound >= 0 then
          PlaySound(m_nAttackSound);
      end;
    SM_LIGHTING: begin
        if m_nDie2Sound >= 0 then
          PlaySound(m_nDie2Sound)
        else if m_nAttackSound >= 0 then
          PlaySound(m_nAttackSound);
      end;
    SM_ALIVE: begin
        PlaySound(m_nAppearSound);
        if Self = g_MySelf then
          PlayMapMusic(True);
      end;
    SM_DIGUP {殿厘,巩凯覆}: begin
        PlaySound(m_nAppearSound);
      end;
    SM_SPELL: begin
        PlaySound(m_nMagicStartSound);
      end;
  end;
end;

procedure TActor.RunActSound(frame: Integer);
begin
  if m_boRunSound then begin//需要播放声效
    if m_btRace = 0 then begin//人类
      case m_nCurrentAction of
        SM_THROW, SM_HIT, SM_HIT + 1, SM_HIT + 2://扔、击
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            m_boRunSound := FALSE; //声效已经播放
          end;
        SM_POWERHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            if m_btSex = 0 then//播放人物的声音
              PlaySound(s_yedo_man)
            else
              PlaySound(s_yedo_woman);
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        SM_LONGHIT:
          if frame = 2 then begin
            if m_btHorse <> 0 then begin
              PlaySoundEx('Wav\63.wav');
            end
            else begin
              PlaySound(m_nWeaponSound);
              PlaySound(s_longhit);
            end;
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        SM_WIDEHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(s_widehit);
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        SM_FIREHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(s_firehit);
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        SM_LONGICEHIT_L, SM_LONGICEHIT_S:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySoundEx(bmg_longswordhit);
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        SM_CRSHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            //PlaySound(s_firehit); //Damian
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        SM_TWINHIT:
          if frame = 2 then begin
            PlaySound(m_nWeaponSound);
            PlaySound(10000061); //Damian
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        SM_110:
          if frame = 2 then begin
            if m_btSex = 0 then
              PlaySoundEx(bmg_cboZs1_start_m)
            else
              PlaySoundEx(bmg_cboZs1_start_w);
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        SM_112:
          if frame = 6 then begin
            if m_btSex = 0 then
              PlaySoundEx(bmg_cboZs3_start_m)
            else
              PlaySoundEx(bmg_cboZs3_start_w);
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        SM_113:
          if frame = 2 then begin
            PlaySoundEx(bmg_cboZs4_start);
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        SM_122:
          if frame = 2 then begin
            PlaySoundEx('wav\cboZs7_start.wav');
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        SM_56: begin
            if m_btSex = 0 then
              PlaySound(11230)
            else
              PlaySound(11231);
            m_boRunSound := FALSE;
          end;
      end;
    end
    else begin
      if m_btRace = 50 then begin
      end
      else begin
        //(** 货 荤款靛
        if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_TURN) then begin
          if (frame = 1) and (Random(8) = 1) then begin
            PlaySound(m_nNormalSound);
            m_boRunSound := FALSE; //茄锅父 家府晨
          end;
        end;
        if m_nCurrentAction = SM_HIT then begin
          if (frame = 3) and (m_nAttackSound >= 0) then begin
            PlaySound(m_nWeaponSound);
            m_boRunSound := FALSE;
          end;
        end;
        case m_wAppearance of
          80: {//包冠零} begin
              if m_nCurrentAction = SM_NOWDEATH then begin
                if (frame = 2) then begin
                  PlaySound(m_nDie2Sound);
                  m_boRunSound := FALSE; //茄锅父 家府晨
                end;
              end;
            end;
        end;
      end; //*)
    end;
  end;
end;

procedure TActor.RunFrameAction(frame: Integer);
begin
end;

procedure TActor.ActionEnded;
begin
end;

function TActor.Run: Boolean;
  function MagicTimeOut: Boolean;
  begin
    if Self = g_MySelf then begin
      Result := GetTickCount - m_dwWaitMagicRequest > 3000;
    end
    else
      Result := GetTickCount - m_dwWaitMagicRequest > 2000;
    if Result then
      m_CurMagic.ServerMagicCode := 0;
  end;
var
  prv: Integer;
  m_dwFrameTimetime: LongWord;
  bofly: Boolean;
begin
  Result := False;
  if (m_nCurrentAction = SM_WALK) or
    (m_nCurrentAction = SM_BACKSTEP) or
    (m_nCurrentAction = SM_RUN) or
    (m_nCurrentAction = SM_LEAP) or
    (m_nCurrentAction = SM_HORSERUN) or
    (m_nCurrentAction = SM_RUSH) or
    (m_nCurrentAction = SM_RUSHCBO) or
    (m_nCurrentAction = SM_MAGICMOVE) or
    (m_nCurrentAction = SM_MAGICFIR) or
    (m_nCurrentAction = SM_RUSHKUNG) then
    Exit;

  m_boMsgMuch := FALSE;
  if Self <> g_MySelf then begin
    if m_MsgList.Count >= 2 then
      m_boMsgMuch := TRUE;
  end;

   //声音效果
  RunActSound(m_nCurrentFrame - m_nStartFrame);
  RunFrameAction(m_nCurrentFrame - m_nStartFrame);

  prv := m_nCurrentFrame;
   if m_nCurrentAction <> 0 then begin  //动作不为空
    if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
      m_nCurrentFrame := m_nStartFrame;

    if (Self <> g_MySelf) and (m_boUseMagic) then begin
      m_dwFrameTimetime := Round(m_dwFrameTime / 1.8);
    end
    else begin
      if m_boMsgMuch then
        m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
      else
        m_dwFrameTimetime := m_dwFrameTime;
    end;

    if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
      if m_nCurrentFrame < m_nEndFrame then begin
        //付过牢 版快 辑滚狼 脚龋甫 罐酒, 己傍/角菩甫 犬牢茄饶
        //付瘤阜悼累阑 场辰促.
        if m_boUseMagic then begin
          if (m_nCurEffFrame = m_nSpellFrame - 2) or (MagicTimeOut) then begin //扁促覆 场
            if (m_CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin //辑滚肺 何磐 罐篮 搬苞. 酒流 救吭栏搁 扁促覆
              Inc(m_nCurrentFrame);
              Inc(m_nCurEffFrame);
              m_dwStartTime := GetTickCount;
            end;
          end
          else begin
            if m_nCurrentFrame < m_nEndFrame - 1 then
              Inc(m_nCurrentFrame);
            Inc(m_nCurEffFrame);
            m_dwStartTime := GetTickCount;
          end;
        end
        else begin
          Inc(m_nCurrentFrame);
          m_dwStartTime := GetTickCount;
        end;

      end
      else begin
        if m_boDelActionAfterFinished then begin
          //捞 悼累饶 荤扼咙.
          m_boDelActor := TRUE;
        end;
        //悼累捞 场巢.
        if Self = g_MySelf then begin
          //林牢傍 牢版快
          if FrmMain.ServerAcceptNextAction then begin
            ActionEnded;
            m_nCurrentAction := 0;
            m_boUseMagic := FALSE;
          end;
        end
        else begin
          ActionEnded;
          m_nCurrentAction := 0; //悼累 肯丰
          m_boUseMagic := FALSE;
        end;
      end;
      if m_boUseMagic then begin
        //付过阑 静绰 版快
        if m_nCurEffFrame = m_nSpellFrame - 1 then begin //付过 惯荤 矫痢
          //付过 惯荤
          if m_CurMagic.ServerMagicCode > 0 then begin
            with m_CurMagic do
              PlayScene.NewMagic(Self,
                ServerMagicCode,
                EffectNumber, //Effect
                m_nCurrX,
                m_nCurrY,
                TargX,
                TargY,
                Target,
                EffectType, //EffectType
                Recusion,
                AniTime,
                bofly);
            if bofly then
              PlaySound(m_nMagicFireSound)
            else
              PlaySound(m_nMagicExplosionSound);
          end;
          //LatestSpellTime := GetTickCount;
          m_CurMagic.ServerMagicCode := 0;
        end;
      end;
    end;
    if m_wAppearance in [0, 1, 43] then
      m_nCurrentDefFrame := -10
    else
      m_nCurrentDefFrame := 0;
    m_dwDefFrameTime := GetTickCount;
  end
  else begin
    if GetTickCount - m_dwSmoothMoveTime > 200 then begin
      if GetTickCount - m_dwDefFrameTime > m_dwDefFrameTick then begin
        m_dwDefFrameTime := GetTickCount;
        Inc(m_nCurrentDefFrame);
        if m_nCurrentDefFrame >= m_nDefFrameCount then
          m_nCurrentDefFrame := 0;
      end;
      DefaultMotion;
    end;
  end;
  if prv <> m_nCurrentFrame then begin
    m_dwLoadSurfaceTime := GetTickCount;
    LoadSurface;
    Result := True;
  end;
end;

// 根据当前动作和状态计算下一个动作对应的帧
function TActor.Move(step: Integer; out boChange: Boolean): Boolean;
var
  prv, curstep, maxstep: Integer;
  fastmove, normmove: Boolean;
begin
  Result := FALSE;
  boChange := False;
  if (m_nCurrentAction = SM_RUSHCBO) then begin
    Result := True;
    if GetTickCount - m_dwStartTime < HA.Act111.ftime then
      exit;
    m_dwStartTime := GetTickCount;
  end;

  fastmove := FALSE;
  normmove := FALSE;
  if (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_MAGICFIR) then
    //or (CurrentAction = SM_RUSH) or (CurrentAction = SM_RUSHKUNG) then
    fastmove := TRUE;
  if (m_nCurrentAction = SM_RUSH) or (m_nCurrentAction = SM_RUSHCBO) 
  or (m_nCurrentAction = SM_MAGICMOVE) or (m_nCurrentAction = SM_RUSHKUNG) 
  or (m_nCurrentAction = SM_MAGICFIR)
    then
    normmove := TRUE;
  if (Self = g_MySelf) and (not fastmove) and (not normmove) then begin
    g_boMoveSlow := FALSE;
    g_boAttackSlow := FALSE;
    g_nMoveSlowLevel := 0;
    {if m_Abil.Weight > m_Abil.MaxWeight then begin
      g_nMoveSlowLevel := m_Abil.Weight div m_Abil.MaxWeight;
      g_boMoveSlow := TRUE;
    end;
    if m_Abil.WearWeight > m_Abil.MaxWearWeight then begin
      g_nMoveSlowLevel := g_nMoveSlowLevel + m_Abil.WearWeight div m_Abil.MaxWearWeight;
      g_boMoveSlow := TRUE;
    end;
    if m_Abil.HandWeight > m_Abil.MaxHandWeight then begin
      g_boAttackSlow := TRUE;
    end;   }
      //免负重
    if g_boMoveSlow and (m_nSkipTick < g_nMoveSlowLevel) then begin
      Inc(m_nSkipTick); //茄锅 疆促.
      Exit;
    end
    else begin
      m_nSkipTick := 0;
    end;
      //走动的声音
    if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_RUN) or
      (m_nCurrentAction = SM_LEAP) or
      (m_nCurrentAction = SM_HORSERUN) or
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG) then begin
      case (m_nCurrentFrame - m_nStartFrame) of
        1: PlaySound(m_nFootStepSound); //走路声音
        4: PlaySound(m_nFootStepSound + 1);
      end;
    end;
  end;

  Result := FALSE;
  m_boMsgMuch := FALSE;
  if (Self <> g_MySelf) {or m_boShowCbo m_dwFrameTime} then begin
    if (m_MsgList.Count >= 2) {or m_boShowCbo} then
      m_boMsgMuch := TRUE;
  end;
  prv := m_nCurrentFrame;
   //移动
  if (m_nCurrentAction = SM_WALK) or
    (m_nCurrentAction = SM_RUN) or
    (m_nCurrentAction = SM_LEAP) or
    (m_nCurrentAction = SM_HORSERUN) or
    (m_nCurrentAction = SM_RUSH) or
    (m_nCurrentAction = SM_RUSHCBO) or
    (m_nCurrentAction = SM_MAGICMOVE) or
    (m_nCurrentAction = SM_MAGICFIR) or
    (m_nCurrentAction = SM_RUSHKUNG) then begin
     //调整当前帧
    if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then begin
      m_nCurrentFrame := m_nStartFrame - 1;
    end;
    if m_nCurrentFrame < m_nEndFrame then begin
      Inc(m_nCurrentFrame);
      if m_boMsgMuch and (not normmove) then //加快步伐
        if m_nCurrentFrame < m_nEndFrame then
          Inc(m_nCurrentFrame);

      //何靛反霸 捞悼窍霸 窍妨绊
      curstep := m_nCurrentFrame - m_nStartFrame + 1;
      maxstep := m_nEndFrame - m_nStartFrame + 1;
      Shift(m_btDir, m_nMoveStep, curstep, maxstep);//变速
      //Result := Self = g_MySelf;
    end;
    if m_nCurrentFrame >= m_nEndFrame then begin
      if Self = g_MySelf then begin
        if FrmMain.ServerAcceptNextAction then begin
          m_nCurrentAction := 0;//当前动作：无
          m_boLockEndFrame := TRUE;
          m_dwSmoothMoveTime := GetTickCount;
        end;
      end
      else begin
        m_nCurrentAction := 0; //悼累 肯丰
        m_boLockEndFrame := TRUE;
        m_dwSmoothMoveTime := GetTickCount;
      end;
      //      Result := TRUE;
    end;
    if (m_nCurrentAction = SM_RUSH) or (m_nCurrentAction = SM_RUSHCBO) then begin
      if Self = g_MySelf then begin
        g_dwDizzyDelayStart := GetTickCount;
        g_dwDizzyDelayTime := 300; //掉饭捞
      end;
    end;
    if m_nCurrentAction = SM_RUSHKUNG then begin//野蛮冲撞
      if m_nCurrentFrame >= m_nEndFrame - 3 then begin
        m_nCurrX := m_nActBeforeX;
        m_nCurrY := m_nActBeforeY;
        m_nRx := m_nCurrX;
        m_nRy := m_nCurrY;
        m_nCurrentAction := 0;
        m_boLockEndFrame := TRUE;
        //m_dwSmoothMoveTime := GetTickCount;
      end;
    end;
    if m_nCurrentAction = SM_MAGICMOVE then begin
      //十步一杀
      if m_nCurrentFrame = m_nEndFrame - 3 then begin
        PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WMagic10Images, 220, 10, HA.ActHit.ftime, True));
      end;
    end;
    Result := TRUE;
  end;
  //缔吧澜龙
  if (m_nCurrentAction = SM_BACKSTEP) then begin//后退
    if (m_nCurrentFrame > m_nEndFrame) or (m_nCurrentFrame < m_nStartFrame) then begin
      m_nCurrentFrame := m_nEndFrame + 1;
    end;
    if m_nCurrentFrame > m_nStartFrame then begin
      Dec(m_nCurrentFrame);
      if m_boMsgMuch or fastmove then
        if m_nCurrentFrame > m_nStartFrame then
          Dec(m_nCurrentFrame);

      //何靛反霸 捞悼窍霸 窍妨绊
      curstep := m_nEndFrame - m_nCurrentFrame + 1;
      maxstep := m_nEndFrame - m_nStartFrame + 1;
      Shift(GetBack(m_btDir), m_nMoveStep, curstep, maxstep);
      //      Result := Self = g_MySelf;
    end;
    if m_nCurrentFrame <= m_nStartFrame then begin
      if Self = g_MySelf then begin
        //if FrmMain.ServerAcceptNextAction then begin
        m_nCurrentAction := 0; //消息为空
        m_boLockEndFrame := TRUE;//锁定当前操作
        m_dwSmoothMoveTime := GetTickCount;

        //第肺 剐赴 促澜 茄悼救 给 框流牢促.
        g_dwDizzyDelayStart := GetTickCount;
        g_dwDizzyDelayTime := 1000; //1檬 掉饭捞
        //end;
      end
      else begin
        m_nCurrentAction := 0; //悼累 肯丰
        m_boLockEndFrame := TRUE;
        m_dwSmoothMoveTime := GetTickCount;
      end;
      //      Result := TRUE;
    end;
    Result := TRUE;
  end
  else if (m_nCurrentAction = SM_MAGICFIR) then begin
    if (m_nCurrentFrame > m_nEndFrame) or (m_nCurrentFrame < m_nStartFrame) then begin
      m_nCurrentFrame := m_nEndFrame + 1;
    end;
    if m_nCurrentFrame > m_nStartFrame then begin
      Dec(m_nCurrentFrame);
      if m_boMsgMuch or fastmove then
        if m_nCurrentFrame > m_nStartFrame then
          Dec(m_nCurrentFrame);

    end;
    if m_nCurrentFrame <= m_nStartFrame then begin
      if Self = g_MySelf then begin
        m_nCurrentAction := 0;
      end
      else begin
        m_nCurrentAction := 0;
      end;
      //      Result := TRUE;
    end;
    Result := TRUE;
  end;
   //若当前动作和上一个动作帧不同，则装载当前动作画面
  if prv <> m_nCurrentFrame then begin
    m_dwLoadSurfaceTime := GetTickCount;
    LoadSurface;
    boChange := True;
  end;
end;

//移动失败（服务器不接受移动命令）时，退回到上次的位置
procedure TActor.MoveFail;
begin
  m_nCurrentAction := 0; //悼累 肯丰
  m_boLockEndFrame := TRUE;
  g_MySelf.m_nCurrX := m_nOldx;
  g_MySelf.m_nCurrY := m_nOldy;
  g_MySelf.m_btDir := m_nOldDir;
  CleanUserMsgs;
end;

function TActor.CanCancelAction: Boolean;
begin
  Result := FALSE;
  if m_nCurrentAction = SM_HIT then
    if not m_boUseEffect then
      Result := TRUE;
end;

procedure TActor.CancelAction;
begin
  m_nCurrentAction := 0; //悼累 肯丰
  m_boLockEndFrame := TRUE;
end;

procedure TActor.CleanCharMapSetting(x, y: Integer);
begin
  g_MySelf.m_nCurrX := x;
  g_MySelf.m_nCurrY := y;
  g_MySelf.m_nRx := x;
  g_MySelf.m_nRy := y;
  m_nOldx := x;
  m_nOldy := y;
  m_nCurrentAction := 0;
  m_nCurrentFrame := -1;
  CleanUserMsgs;
end;

//实现分行显示说话内容到Saying
procedure TActor.Say(str: string; boFirst: Boolean);
const
  MAXWIDTH = 150;
var
  SayImage: pTSayImage;
  SayMessage: pTSayMessage;
  WideStr, WideStr2: WideString;
  i, ii, nid, nident, nindex: integer;
  nLen, nTextLen: integer;
  tstr, tstr2, AddStr, AddStr2, OldStr, OldStr2, cmdstr, sid, sident, sindex: string;
  boClickName, boClickItem, boBeginColor, boImage: Boolean;
  nFColor {, nBColor}: TColor;
  StdItem: TStdItem;
begin
  if boFirst then begin
    ClearSayList();
    m_dwSayTime := GetTickCount + 5000;
    m_SayWidthsArr := 1;
  end;
  with DScreen do begin
    if Str = '' then
      Exit;
    WideStr := str;
    SayMessage := NewSayMsg(MAXWIDTH, 16, us_None);
    nLen := 1;
    nFColor := clWhite;
    //    nBColor := $8;
    with SayMessage.SaySurface do begin
      //SetBkMode(Handle, TRANSPARENT);
      boClickName := False;
      boClickItem := False;
      boBeginColor := False;
      boImage := False;
      AddStr := '';
      i := 1;
      while True do begin
        if i > Length(WideStr) then
          break;
        tstr := WideStr[i];
        OldStr := Copy(WideStr, I + 1, Length(WideStr));
        if boImage then begin
          if tstr = '#' then begin
            boImage := False;
            nindex := StrToIntDef(cmdstr, -1);
            if nIndex in [Low(g_FaceIndexInfo)..High(g_FaceIndexInfo)] then begin
              if (nLen + SAYFACEWIDTH) > (MAXWIDTH - 1) then begin
                OldStr := '#' + cmdstr + '#' + OldStr;
                cmdstr := '';
                Break;
              end
              else begin
                New(SayImage);
                SayImage.nLeft := nLen;
                SayImage.nRight := nLen + SAYFACEWIDTH;
                SayImage.nIndex := nIndex;
                Inc(nLen, SAYFACEWIDTH);
                if SayMessage.ImageList = nil then
                  SayMessage.ImageList := TList.Create;
                SayMessage.ImageList.Add(SayImage);
              end;
            end;
            cmdstr := '';
          end
          else
            cmdstr := cmdstr + tstr;
        end
        else if boClickName then begin
          if tstr = #7 then begin
            boClickName := False;
            nTextLen := g_DXCanvas.TextWidth(cmdstr);
            if (nLen + nTextLen) > (MAXWIDTH - 1) then begin
              WideStr2 := cmdstr;
              cmdstr := '';
              AddStr2 := '';
              for ii := 1 to Length(WideStr2) do begin
                tstr2 := WideStr2[ii];
                OldStr2 := Copy(WideStr2, ii + 1, Length(WideStr2));
                if (nLen + g_DXCanvas.TextWidth(AddStr2 + tstr2)) > (MAXWIDTH - 1) then begin
                  nTextLen := g_DXCanvas.TextWidth(AddStr2);
                  TextOutEx(nLen, 2, AddStr2, clYellow);
                  Inc(nLen, nTextLen);
                  AddStr2 := '';
                  OldStr2 := tstr2 + OldStr2;
                  break;
                end
                else
                  AddStr2 := AddStr2 + tstr2;
              end;
              OldStr := #7 + OldStr2 + #7 + OldStr;
              cmdstr := '';
              Break;
            end
            else begin
              TextOutEx(nLen, 2, cmdstr, clYellow);
              Inc(nLen, nTextLen);
              cmdstr := '';
            end;
          end
          else
            cmdstr := cmdstr + tstr;
        end
        else if boClickItem then begin
          if tstr = '}' then begin
            boClickItem := False;
            cmdstr := GetValidStr3(cmdstr, sid, ['/']);
            cmdstr := GetValidStr3(cmdstr, sident, ['/']);
            cmdstr := GetValidStr3(cmdstr, sindex, ['/']);
            cmdstr := '';
            nid := StrToIntDef(sid, -1);
            nident := StrToIntDef(sident, -1);
            nindex := StrToIntDef(sindex, 0);
            if (nId >= 0) and (nident > 0) and (nindex <> 0) then begin
              StdItem := GetStdItem(nident);
              if StdItem.Name <> '' then begin
                cmdstr := '<' + StdItem.Name + '>';
                WideStr := cmdstr + OldStr;
                i := 1;
                cmdstr := '';
                Continue;
              end;
            end;
          end
          else
            cmdstr := cmdstr + tstr;
        end
        else if boBeginColor then begin
          if tstr = #6 then begin
            boBeginColor := False;
            cmdstr := '';
          end
          else
            cmdstr := cmdstr + tstr;
        end
        else begin
          if tstr = #7 then begin
            boClickName := True;
            TextOutEx(nLen, 2, AddStr, nFColor);
            Inc(nLen, g_DXCanvas.TextWidth(AddStr));
            AddStr := '';
            cmdstr := '';
          end
          else if tstr = '{' then begin
            boClickItem := True;
            TextOutEx(nLen, 2, AddStr, nFColor);
            Inc(nLen, g_DXCanvas.TextWidth(AddStr));
            AddStr := '';
            cmdstr := '';
          end
          else if tstr = #6 then begin
            boBeginColor := True;
            TextOutEx(nLen, 2, AddStr, nFColor);
            Inc(nLen, g_DXCanvas.TextWidth(AddStr));
            AddStr := '';
            cmdstr := '';
          end
          else if tstr = #5 then begin
            TextOutEx(nLen, 2, AddStr, nFColor);
            Inc(nLen, g_DXCanvas.TextWidth(AddStr));
            AddStr := '';
            cmdstr := '';
          end
          else if tstr = '#' then begin
            boImage := True;
            TextOutEx(nLen, 2, AddStr, nFColor);
            Inc(nLen, g_DXCanvas.TextWidth(AddStr));
            AddStr := '';
            cmdstr := '';
          end
          else if (nLen + g_DXCanvas.TextWidth(AddStr + tstr)) > (MAXWIDTH - 1) then begin
            TextOutEx(nLen, 2, AddStr, nFColor);
            Inc(nLen, g_DXCanvas.TextWidth(AddStr));
            AddStr := '';
            cmdstr := '';
            OldStr := tstr + OldStr;
            Break;
          end
          else
            AddStr := AddStr + tstr;
        end;
        Inc(i);
      end;
      if AddStr <> '' then begin
        TextOutEx(nLen, 2, AddStr, nFColor);
        Inc(nLen, g_DXCanvas.TextWidth(AddStr));
      end;
      //Release;
      if nLen > m_SayWidthsArr then
        m_SayWidthsArr := nLen;

      m_SayList.Add(SayMessage);
      if OldStr <> '' then
        Say(OldStr, False);
    end;
  end;
end;

{============================== NPCActor =============================}

procedure TNpcActor.CalcActorFrame;
var
  pm: pTMonsterAction;
  //  haircount: Integer;
begin
  m_boUseMagic := FALSE;
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetNpcOffset(m_wAppearance);
  {
  if m_btRace = 50 then //NPC
     m_nBodyOffset := MERCHANTFRAME * m_wAppearance;
  }
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if (pm = nil) then
    Exit;
  if m_boCanModDir then
    m_btDir := m_btDir mod 3; //规氢篮 0, 1, 2 观俊 绝澜..
  case m_nCurrentAction of
    SM_TURN: begin//转向
        m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
        m_dwStartTime := GetTickCount;
        m_nDefFrameCount := pm.ActStand.frame;
        Shift(m_btDir, 0, 0, 1);
        if ((m_wAppearance = 33) or (m_wAppearance = 34)) and not m_boUseEffect then begin
          m_boUseEffect := TRUE;
          m_nEffectStart := 30;
          m_nEffectFrame := m_nEffectStart;
          m_nEffectEnd := m_nEffectStart + 9;
          m_dwEffectStartTime := GetTickCount();
          m_dwEffectFrameTime := 300;
        end
        else begin
          if m_wAppearance in [42..47] then begin
            m_nStartFrame := 20;
            m_nEndFrame := 10;
            m_boUseEffect := TRUE;
            m_nEffectStart := 0;
            m_nEffectFrame := 0;
            m_nEffectEnd := 19;
            m_dwEffectStartTime := GetTickCount();
            m_dwEffectFrameTime := 100;
          end
          else begin
            if m_wAppearance = 51 then begin
              m_boUseEffect := TRUE;
              m_nEffectStart := 60;
              m_nEffectFrame := m_nEffectStart;
              m_nEffectEnd := m_nEffectStart + 7;
              m_dwEffectStartTime := GetTickCount();
              m_dwEffectFrameTime := 500;
            end;
          end;
        end;
      end;
    SM_HIT: begin//攻击
        case m_wAppearance of
          125: ;
          33, 34 {, 52}: begin
              m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
              m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
              m_dwStartTime := GetTickCount;
              m_nDefFrameCount := pm.ActStand.frame;
            end;
          95: begin
              m_nStartFrame := pm.ActAttack.start;
              m_nEndFrame := m_nStartFrame + 22;
              m_dwFrameTime := 150;
              m_dwStartTime := GetTickCount;
            end
        else begin
            m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
            m_dwFrameTime := pm.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            if m_wAppearance = 51 then begin
              m_boUseEffect := TRUE;
              m_nEffectStart := 60;
              m_nEffectFrame := m_nEffectStart;
              m_nEffectEnd := m_nEffectStart + 7;
              m_dwEffectStartTime := GetTickCount();
              m_dwEffectFrameTime := 500;
            end;
          end;
        end;
      end;
    SM_DIGUP: begin
        {if m_wAppearance = 52 then begin
          m_bo248 := TRUE;
          m_dwUseEffectTick := GetTickCount + 23000;
          Randomize;
          PlaySound(Random(7) + 146);
          m_boUseEffect := TRUE;
          m_nEffectStart := 60;
          m_nEffectFrame := m_nEffectStart;
          m_nEffectEnd := m_nEffectStart + 11;
          m_dwEffectStartTime := GetTickCount();
          m_dwEffectFrameTime := 100;
        end;   }
      end;
  end;
end;

constructor TNpcActor.Create;
begin
  inherited;
  m_EffSurface := nil;
  m_boHitEffect := FALSE;
  m_bo248 := FALSE;
  m_boShowName := True;
  m_MissionList := nil;
  m_MissionStatus := NPCMS_None;
  m_boCanAnimation := True;
  m_boCanChangeDir := True;
  m_boCanModDir := True;
end;

destructor TNpcActor.Destroy;
begin
  if m_MissionList <> nil then
    m_MissionList.Free;
end;
// 画NPC 人物自身图
procedure TNpcActor.DrawChr(dsurface: TDirectDrawSurface; dx, dy: Integer; blend, boFlag: Boolean);
var
  ceff: TColorEffect;
begin
  if m_boCanModDir then
    m_btDir := m_btDir mod 3;
  if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
    m_dwLoadSurfaceTime := GetTickCount;
    LoadSurface;
  end;
  ceff := GetDrawEffectValue;
  if m_BodySurface <> nil then begin
    if (m_wAppearance = 76) then begin
      DrawBlend(dsurface,
        dx + m_nPx + m_nShiftX,
        dy + m_nPy + m_nShiftY,
        m_BodySurface,
        1);
    end
    else if (m_wAppearance = 51) then begin
      DrawEffSurface(dsurface,
        m_BodySurface,
        dx + m_nPx + m_nShiftX,
        dy + m_nPy + m_nShiftY,
        TRUE,
        ceff);
    end
    else begin
        DrawEffSurface (dsurface,      //此处为画
        m_BodySurface,
        dx + m_nPx + m_nShiftX,
        dy + m_nPy + m_nShiftY,
        blend,
        ceff);
    end;
  end;
end;

procedure TNpcActor.DrawEff(dsurface: TDirectDrawSurface; dx, dy: Integer);
begin
  //  inherited;
  if m_boUseEffect and (m_EffSurface <> nil) then begin
    DrawBlend(dsurface,
      dx + m_nEffX + m_nShiftX,
      dy + m_nEffY + m_nShiftY,
      m_EffSurface,
      1);
  end;
end;

procedure TNpcActor.SetUsername(Username: string; nameColor: Integer; boClear: Boolean = False);
begin
  inherited;
  m_DescNameWidth := 0;
  if (not boClear) and (m_sDescUserName <> '') then begin
    m_DescNameWidth := g_DXCanvas.TextWidth(m_sDescUserName);
  end;
end;

function TNpcActor.GetDefaultFrame(wmode: Boolean): Integer;
var
  cf: Integer;
  pm: pTMonsterAction;
begin
  Result := 0; //Jacky
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    Exit;
  if m_boCanModDir then
    m_btDir := m_btDir mod 3; //NPC只有3个方向（如商人）
  m_dwDefFrameTick := pm.ActStand.ftime;
  if m_nCurrentDefFrame < 0 then
    cf := 0
  else if m_nCurrentDefFrame >= pm.ActStand.frame then
    cf := 0
  else
    cf := m_nCurrentDefFrame;
  Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
end;

procedure TNpcActor.LoadSurface;
begin
  m_BodySurface := nil;
  if m_btRace = 50 then begin
    m_BodySurface := GetNpcImg(m_nBodyOffset + m_nCurrentFrame, m_nPx, m_nPy);
    if m_wAppearance = 41 then begin
      Inc(m_nPy, 37);
      Dec(m_nPx, 15);
    end;
  end;
  if m_wAppearance in [42..47] then
    m_BodySurface := nil;
  if m_boUseEffect then begin
    if m_wAppearance = 33 then begin
      Inc(m_nPx, 18);
      Dec(m_nPy, 59);
      m_EffSurface := GetNpcImg(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      Inc(m_nEffX, 18);
      Dec(m_nEffy, 59);
    end
    else
    if m_wAppearance = 34 then begin
      Inc(m_nPx, 12);
      Dec(m_nPy, 69);
      m_EffSurface := GetNpcImg(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      Inc(m_nEffX, 12);
      Dec(m_nEffy, 69);
    end
    else if m_wAppearance = 42 then begin
      m_EffSurface := GetNpcImg(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 71;
      m_nEffY := m_nEffY + 5;
    end
    else if m_wAppearance = 43 then begin
      m_EffSurface := GetNpcImg(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 71;
      m_nEffY := m_nEffY + 37;
    end
    else if m_wAppearance = 44 then begin
      m_EffSurface := GetNpcImg(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 7;
      m_nEffY := m_nEffY + 12;
    end
    else if m_wAppearance = 45 then begin
      m_EffSurface := GetNpcImg(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 6;
      m_nEffY := m_nEffY + 12;
    end
    else if m_wAppearance = 46 then begin
      m_EffSurface := GetNpcImg(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 7;
      m_nEffY := m_nEffY + 12;
    end
    else if m_wAppearance = 47 then begin
      m_EffSurface := GetNpcImg(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX := m_nEffX + 8;
      m_nEffY := m_nEffY + 12;
    end
    else if m_wAppearance = 51 then begin
      m_EffSurface := GetNpcImg(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end; {
    else if m_wAppearance = 52 then begin
      m_EffSurface := GetNpcImg(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end;  }
  end;
end;
(*
procedure TNpcActor.LoadUsername;
{var
 nWidth, nHeight: Integer;    }
begin
 {m_UserNameSurface := TDXImageTexture.Create;
 m_UserNameSurface.Size := Point(12 * 7 + 2, 14);
 m_UserNameSurface.PatternSize := Point(12 * 7 + 2, 14);
 m_UserNameSurface.Format := D3DFMT_R5G6B5;
 m_UserNameSurface.Active := True;
 nWidth := ((12 * 7 + 2) - g_DXCanvas.TextWidth(m_UserName)) div 2 + 1;
 m_UserNameSurface.Clear;
 m_UserNameSurface.TextOutEx(nWidth, 1, PChar(m_UserName), clWhite, clBlack, g_Font);  }
end;
       *)

function TNpcActor.Run: Boolean;
var
  nEffectFrame: Integer;
  dwEffectFrameTime: LongWord;
begin
  Result := inherited Run;
  nEffectFrame := m_nEffectFrame;
  if m_boUseEffect then begin    //NPC是否使用了魔法类
    if m_boUseMagic then begin
      dwEffectFrameTime := Round(m_dwEffectFrameTime / 3);
    end
    else
      dwEffectFrameTime := m_dwEffectFrameTime;

    if GetTickCount - m_dwEffectStartTime > dwEffectFrameTime then begin
      m_dwEffectStartTime := GetTickCount();
      if m_nEffectFrame < m_nEffectEnd then begin
        Inc(m_nEffectFrame);
      end
      else begin
        if m_bo248 then begin
          if GetTickCount > m_dwUseEffectTick then begin
            m_boUseEffect := FALSE;
            m_bo248 := FALSE;
            m_dwUseEffectTick := GetTickCount();
          end;
          m_nEffectFrame := m_nEffectStart;
        end
        else
          m_nEffectFrame := m_nEffectStart;
        m_dwEffectStartTime := GetTickCount();
      end;
    end;
  end;
  if nEffectFrame <> m_nEffectFrame then begin     //魔法桢
    m_dwLoadSurfaceTime := GetTickCount();
    LoadSurface();
    Result := True;
  end;
  if m_boCanChangeDir and (Random(200) = 0) then begin
    SendMsg(SM_TURN, m_nCurrX, m_nCurrY, Random(8), m_nFeature, m_nState, '', 0);
  end
  else begin
    if m_boCanAnimation and (Random(300) = 0) then
      SendMsg(SM_HIT, m_nCurrX, m_nCurrY, m_btDir, m_nFeature, m_nState, '', 0);
  end;
end;

{============================== HUMActor =============================}

//            荤恩

{-------------------------------}

constructor THumActor.Create;
begin
  inherited Create;
  m_HairSurface := nil;
  m_WeaponSurface := nil;
  m_WeaponEffectSurface := nil;
  m_HumWinSurface := nil;
  m_HoresSurface := nil;
  m_boWeaponEffect := FALSE;
  m_dwFrameTime := 150;
  m_dwFrameTick := GetTickCount();
  m_nFrame := 0;
  m_nHumWinOffset := 0;
  m_boShowName := True;
end;

destructor THumActor.Destroy;
begin
  inherited Destroy;
end;

procedure THumActor.CalcActorFrame;
var
  nx, ny: integer;
  meff: TMagicEff;
  //  haircount: Integer;
begin
  m_boUseMagic := FALSE;
  m_boHitEffect := FALSE;
  m_boShowCbo := False;
  m_boNoCheckSpeed := False;
  m_boReverse := False;
  m_nCurrentFrame := -1;
  m_nCurEffFrame := 0;
  m_nCurCboFrame := 0;
  m_nHitEffectNumber := -1;
  m_btHair := HAIRfeature(m_nFeature); //发型
  m_btDress := DRESSfeature(m_nFeature);//武器//服装
  m_btWeapon := WEAPONfeature(m_nFeature);
  m_btHorse := Horsefeature(m_nFeatureEx);
  m_btEffect := Effectfeature(m_nFeatureEx);
  m_nBodyOffset := HUMANFRAME * (m_btDress); //m_btSex; //男0, 女1

  m_nHairOffset := HUMHAIRANFRAME * m_btHair;

  m_nWeaponOffset := HUMANFRAME * m_btWeapon; //(weapon*2 + m_btSex);

  if m_btEffect > 0 then
    m_nHumWinOffset := (m_btEffect - 1) * HUMANFRAME;
  case m_nCurrentAction of
    SM_TURN: begin//转
        m_nStartFrame := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip);
        m_nEndFrame := m_nStartFrame + HA.ActStand.frame - 1;
        m_dwFrameTime := HA.ActStand.ftime;
        m_dwStartTime := GetTickCount;
        m_nDefFrameCount := HA.ActStand.frame;
        Shift(m_btDir, 0, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    SM_WALK,//走
      SM_BACKSTEP: begin//后退
        m_nStartFrame := HA.ActWalk.start + m_btDir * (HA.ActWalk.frame + HA.ActWalk.skip);
        m_nEndFrame := m_nStartFrame + HA.ActWalk.frame - 1;
        m_dwFrameTime := HA.ActWalk.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActWalk.usetick;
        m_nCurTick := 0;
        //WarMode := FALSE;
        m_nMoveStep := 1;
        if m_nCurrentAction = SM_BACKSTEP then begin
          m_nMoveStep := m_btStep;
          Shift(GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1)
        end
        else
          Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    SM_RUSHCBO: begin//跑动中改变方向
        m_nRushDir := 0;
        m_nSpellCboSkip := 10;
        m_nHitEffectNumber := 2;
        m_boShowCbo := True;
        m_boNoCheckSpeed := True;
        m_nStartFrame := HA.Act111.start + m_btDir * (HA.Act111.frame + HA.Act111.skip);
        m_nEndFrame := m_nStartFrame + HA.Act111.frame - 1;
        m_dwFrameTime := HA.Act111.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.Act111.usetick;
        m_nCurTick := 0;
        m_nMoveStep := m_btStep;
        Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
        PlaySoundEx(bmg_cboZs2_start);
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
      end;
    SM_MAGICMOVE: begin
        meff := TNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WMagic5Images, m_btDir * 10 + 10, 10, HA.ActHit.ftime, True);
        PlayScene.m_EffectList.Add(meff);
        PlaySound(10702);
        m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
        m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
        m_dwFrameTime := HA.ActHit.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActHit.usetick;
        m_nCurTick := 0;
        //m_boWarMode := TRUE;
        //m_dwWarModeTime := GetTickCount;
        m_nMoveStep := 0;
        Shift(m_btDir, m_nMoveStep, 0, 1);

      end;
    SM_MAGICFIR: begin
        meff := TNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WMagic2Images, 670, 10, HA.ActSpell.ftime, True);
        PlayScene.m_EffectList.Add(meff);
        PlaySoundEx('wav\M18-1.wav');
        m_nStartFrame := HA.ActSpell.start + m_btDir * (HA.ActSpell.frame + HA.ActSpell.skip);
        m_nEndFrame := m_nStartFrame + HA.ActSpell.frame - 1;
        m_dwFrameTime := HA.ActSpell.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActSpell.usetick;
        m_nCurTick := 0;
        m_boWarMode := False;
        m_nMoveStep := 0;
        Shift(m_btDir, m_nMoveStep, 0, 1);
      end;
    SM_RUSH: begin
        if m_nRushDir = 0 then begin
          m_nRushDir := 1;
          m_nStartFrame := HA.ActRushLeft.start + m_btDir * (HA.ActRushLeft.frame + HA.ActRushLeft.skip);
          m_nEndFrame := m_nStartFrame + HA.ActRushLeft.frame - 1;
          m_dwFrameTime := HA.ActRushLeft.ftime;
          m_dwStartTime := GetTickCount;
          m_nMaxTick := HA.ActRushLeft.usetick;
          m_nCurTick := 0;
          m_nMoveStep := 1;
          Shift(m_btDir, 1, 0, m_nEndFrame - m_nStartFrame + 1);
        end
        else begin
          m_nRushDir := 0;
          m_nStartFrame := HA.ActRushRight.start + m_btDir * (HA.ActRushRight.frame + HA.ActRushRight.skip);
          m_nEndFrame := m_nStartFrame + HA.ActRushRight.frame - 1;
          m_dwFrameTime := HA.ActRushRight.ftime;
          m_dwStartTime := GetTickCount;
          m_nMaxTick := HA.ActRushRight.usetick;
          m_nCurTick := 0;
          m_nMoveStep := 1;
          Shift(m_btDir, 1, 0, m_nEndFrame - m_nStartFrame + 1);
        end;
      end;
    SM_RUSHKUNG: begin//野蛮冲撞
        m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
        m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
        m_dwFrameTime := HA.ActRun.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActRun.usetick;
        m_nCurTick := 0;
        m_nMoveStep := 1;
        Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    {SM_BACKSTEP:
       begin
          startframe := pm.ActWalk.start + (pm.ActWalk.frame - 1) + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
          m_nEndFrame := startframe - (pm.ActWalk.frame - 1);
          m_dwFrameTime := pm.ActWalk.ftime;
          m_dwStartTime := GetTickCount;
          m_nMaxTick := pm.ActWalk.UseTick;
          m_nCurTick := 0;
          m_nMoveStep := 1;
          Shift (GetBack(Dir), m_nMoveStep, 0, m_nEndFrame-startframe+1);
       end;  }
    SM_SITDOWN: begin
        m_nStartFrame := HA.ActSitdown.start + m_btDir * (HA.ActSitdown.frame + HA.ActSitdown.skip);
        m_nEndFrame := m_nStartFrame + HA.ActSitdown.frame - 1;
        m_dwFrameTime := HA.ActSitdown.ftime;
        m_dwStartTime := GetTickCount;
      end;
    SM_RUN: begin
        m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
        m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
        m_dwFrameTime := HA.ActRun.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActRun.usetick;
        m_nCurTick := 0;
        m_nMoveStep := 2;
        Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    SM_LEAP: begin
        m_boShowCbo := True;
        m_boNoCheckSpeed := False;
        m_nStartFrame := HA.ActLeap.start + m_btDir * (HA.ActLeap.frame + HA.ActLeap.skip);
        m_nEndFrame := m_nStartFrame + HA.ActLeap.frame - 1;
        m_dwFrameTime := HA.ActLeap.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActRun.usetick;
        m_nCurTick := 0;
        m_nMoveStep := 2;
        Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    SM_HORSERUN: begin
        m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
        m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
        m_dwFrameTime := HA.ActRun.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActRun.usetick;
        m_nCurTick := 0;
        m_nMoveStep := 3;
        Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    SM_THROW: begin
        m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
        m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
        m_dwFrameTime := HA.ActHit.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        m_boThrow := TRUE;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_HIT, SM_POWERHIT, SM_LONGHIT, SM_WIDEHIT, SM_FIREHIT, SM_CRSHIT, SM_LONGICEHIT_L, SM_LONGICEHIT_S: begin
        m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
        m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
        m_dwFrameTime := HA.ActHit.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        if (m_nCurrentAction = SM_POWERHIT) then begin//攻杀
          m_boHitEffect := TRUE;
          m_nHitEffectNumber := 1;
        end;
        if (m_nCurrentAction = SM_LONGHIT) then begin //刺杀
          m_boHitEffect := TRUE;
          m_nHitEffectNumber := 2;
        end;
        if (m_nCurrentAction = SM_WIDEHIT) then begin//半月
          m_boHitEffect := TRUE;
          m_nHitEffectNumber := 3;
        end;
        if (m_nCurrentAction = SM_FIREHIT) then begin //烈火
          m_boHitEffect := TRUE;
          m_nHitEffectNumber := 4;
        end;
        if (m_nCurrentAction = SM_CRSHIT) then begin//抱月
          m_boHitEffect := TRUE;
          m_nHitEffectNumber := 6;
          nx := m_nCurrX;
          ny := m_nCurrY;
          GetNextPosXY(m_btDir, nx, ny);
          meff := TDelayNormalDrawEffect.Create(nx, ny, g_WMagic4Images, 390, 25, 30, True, 300);
          PlayScene.m_EffectList.Add(meff);
          TDelayNormalDrawEffect(meff).SoundID := 10522;
        end;
        if (m_nCurrentAction = SM_LONGICEHIT_L) then begin
          m_boHitEffect := TRUE;
          m_nHitEffectNumber := 17;
          meff := TNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WMagic5Images, m_btDir * 10 + 550, 10, HA.ActHit.ftime, True);
          PlayScene.m_EffectList.Add(meff);
        end;
        if (m_nCurrentAction = SM_LONGICEHIT_S) then begin
          m_boHitEffect := TRUE;
          m_nHitEffectNumber := 18;
          meff := TNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WMagic5Images, m_btDir * 10 + 710, 10, HA.ActHit.ftime, True);
          PlayScene.m_EffectList.Add(meff);
        end;
        if (m_nCurrentAction = SM_LONGHIT) and (m_btHorse <> 0) then begin
          m_nStartFrame := HA.ActHorseHit.start + m_btDir * (HA.ActHorseHit.frame + HA.ActHorseHit.skip);
          m_nEndFrame := m_nStartFrame + HA.ActHorseHit.frame - 1;
          m_dwFrameTime := HA.ActHorseHit.ftime;
          m_boHitEffect := TRUE;
          m_nHitEffectNumber := 19;
        end;
        {if m_nCurrentAction = SM_56 then begin
          m_boHitEffect := TRUE;
          m_nHitEffectNumber := 9;
        end;   }
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_TWINHIT: begin //狂风斩
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        m_dwStartTime := GetTickCount;
        m_boHitEffect := TRUE;
        m_nHitEffectNumber := 7;
        m_nStartFrame := HA.ActBigHit.start + m_btDir * (HA.ActBigHit.frame + HA.ActBigHit.skip);
        m_nEndFrame := m_nStartFrame + HA.ActBigHit.frame - 1;
        m_dwFrameTime := HA.ActBigHit.ftime;
        meff := TDelayNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WMagic99Images, 670 + m_btDir * 10, 6, 100, True, 700);
        TDelayNormalDrawEffect(meff).SoundID := 10000060;
        PlayScene.m_EffectList.Add(meff);
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_110: begin
        m_nCurCboFrame := 0;
        m_nSpellFrame := 17;
        m_nSpellCboSkip := 20;
        m_nHitEffectNumber := 1;
        m_boShowCbo := True;
        m_boNoCheckSpeed := True;
        m_nStartFrame := HA.Act110.start + m_btDir * (HA.Act110.frame + HA.Act110.skip);
        m_nEndFrame := m_nStartFrame + HA.Act110.frame - 1;
        m_dwFrameTime := HA.Act110.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_112: begin
        m_nCurCboFrame := 0;
        m_nSpellFrame := 10;
        m_nSpellCboSkip := 10;
        m_nHitEffectNumber := 3;
        m_boShowCbo := True;
        m_boNoCheckSpeed := True;
        m_nStartFrame := HA.Act112.start + m_btDir * (HA.Act112.frame + HA.Act112.skip);
        m_nEndFrame := m_nStartFrame + HA.Act112.frame - 1;
        m_dwFrameTime := HA.Act112.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        meff := TDelayNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WcboEffectImages, 2003 + m_btDir * 10, 4, 80, True, 500);
        PlayScene.m_EffectList.Add(meff);
        Shift(m_btDir, 0, 0, 1);
        PlaySoundEx('wav\cboZs7_start.wav')
      end;
    SM_113: begin
        m_nCurCboFrame := 0;
        m_nSpellFrame := 10;
        m_nSpellCboSkip := 10;
        m_nHitEffectNumber := 4;
        m_boShowCbo := True;
        m_boNoCheckSpeed := True;
        m_nStartFrame := HA.Act113.start + m_btDir * (HA.Act113.frame + HA.Act113.skip);
        m_nEndFrame := m_nStartFrame + HA.Act113.frame - 1;
        m_dwFrameTime := HA.Act113.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_122: begin
        m_nCurCboFrame := 0;
        m_nSpellFrame := 6;
        m_nSpellCboSkip := 10;
        m_nHitEffectNumber := 5;
        m_boShowCbo := True;
        m_nStartFrame := HA.Act122.start + m_btDir * (HA.Act122.frame + HA.Act122.skip);
        m_nEndFrame := m_nStartFrame + HA.Act122.frame - 1;
        m_dwFrameTime := HA.Act122.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_56: begin
        m_nCurCboFrame := 0;
        m_nSpellFrame := 6;
        m_nSpellCboSkip := 10;
        m_nHitEffectNumber := 9;
        m_boShowCbo := True;
        m_nStartFrame := HA.Act122.start + m_btDir * (HA.Act122.frame + HA.Act122.skip);
        m_nEndFrame := m_nStartFrame + HA.Act122.frame - 1;
        m_dwFrameTime := HA.Act122.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_HEAVYHIT: begin
        m_nStartFrame := HA.ActHeavyHit.start + m_btDir * (HA.ActHeavyHit.frame + HA.ActHeavyHit.skip);
        m_nEndFrame := m_nStartFrame + HA.ActHeavyHit.frame - 1;
        m_dwFrameTime := HA.ActHeavyHit.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_BIGHIT: begin
        m_nStartFrame := HA.ActBigHit.start + m_btDir * (HA.ActBigHit.frame + HA.ActBigHit.skip);
        m_nEndFrame := m_nStartFrame + HA.ActBigHit.frame - 1;
        m_dwFrameTime := HA.ActBigHit.ftime;
        m_dwStartTime := GetTickCount;
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_SPELL: begin
        m_nCurEffFrame := 0;
        m_nCurCboFrame := 0;
        m_nNewMagicFrame := 2;
        m_boUseMagic := TRUE;
        m_dwStartTime := GetTickCount;
        //m_nSpellFrame := m_CurMagic.nFrame;
        case m_CurMagic.EffectNumber of
          56: begin
              m_nStartFrame := HA.ActBigHit.start + m_btDir * (HA.ActBigHit.frame + HA.ActBigHit.skip);
              m_nEndFrame := m_nStartFrame + HA.ActBigHit.frame - 1;
              m_dwFrameTime := HA.ActBigHit.ftime;
              m_nSpellFrame := 8;
              meff := TDelayNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WMagic2Images, 748 + m_btDir * 20, 8, HA.ActBigHit.ftime, True, HA.ActBigHit.ftime * m_nSpellFrame);
              PlayScene.m_EffectList.Add(meff);
            end;
          70: begin
              m_nStartFrame := HA.ActWarMode.start + m_btDir * (HA.ActWarMode.frame + HA.ActWarMode.skip);
              m_nEndFrame := m_nStartFrame + HA.ActSpell.frame - 1;
              m_dwFrameTime := HA.ActSpell.ftime;
              m_nSpellFrame := 8;
            end;
          114: begin
              m_nSpellCboSkip := 20;
              m_nNewMagicFrame := 4;
              m_boShowCbo := True;
              m_boNoCheckSpeed := True;
              m_nStartFrame := HA.Act114.start + m_btDir * (HA.Act114.frame + HA.Act114.skip);
              m_nEndFrame := m_nStartFrame + HA.Act114.frame - 1;
              m_dwFrameTime := HA.Act114.ftime;
              m_nSpellFrame := 11;
            end;
          115: begin
              m_nSpellCboSkip := 10;
              m_boShowCbo := True;
              m_boNoCheckSpeed := True;
              m_nStartFrame := HA.Act115.start + m_btDir * (HA.Act115.frame + HA.Act115.skip);
              m_nEndFrame := m_nStartFrame + HA.Act115.frame - 1;
              m_dwFrameTime := HA.Act115.ftime;
              m_nSpellFrame := 6;
            end;
          116: begin
              m_nSpellCboSkip := 10;
              m_boShowCbo := True;
              m_boNoCheckSpeed := True;
              m_nStartFrame := HA.Act116.start + m_btDir * (HA.Act116.frame + HA.Act116.skip);
              m_nEndFrame := m_nStartFrame + HA.Act116.frame - 1;
              m_dwFrameTime := HA.Act116.ftime;
              m_nSpellFrame := 6;
            end;
          117: begin
              m_nSpellCboSkip := 10;
              m_boShowCbo := True;
              m_boNoCheckSpeed := True;
              m_nStartFrame := HA.Act117.start + m_btDir * (HA.Act117.frame + HA.Act117.skip);
              m_nEndFrame := m_nStartFrame + HA.Act117.frame - 1;
              m_dwFrameTime := HA.Act117.ftime;
              m_nSpellFrame := 8;
            end;
          118: begin
              m_nSpellCboSkip := 10;
              m_boShowCbo := True;
              m_boNoCheckSpeed := True;
              m_nStartFrame := HA.Act118.start + m_btDir * (HA.Act118.frame + HA.Act118.skip);
              m_nEndFrame := m_nStartFrame + HA.Act118.frame - 1;
              m_dwFrameTime := HA.Act118.ftime;
              m_nSpellFrame := 5;
            end;
          119: begin
              m_nSpellCboSkip := 20;
              m_boShowCbo := True;
              m_boNoCheckSpeed := True;
              m_nNewMagicFrame := 3;
              m_nStartFrame := HA.Act119.start + m_btDir * (HA.Act119.frame + HA.Act119.skip);
              m_nEndFrame := m_nStartFrame + HA.Act119.frame - 1;
              m_dwFrameTime := HA.Act119.ftime;
              m_nSpellFrame := 9;
            end;
          120: begin
              m_nSpellCboSkip := 20;
              m_boShowCbo := True;
              m_boNoCheckSpeed := True;
              m_nNewMagicFrame := 4;
              m_nStartFrame := HA.Act120.start + m_btDir * (HA.Act120.frame + HA.Act120.skip);
              m_nEndFrame := m_nStartFrame + HA.Act120.frame - 1;
              m_dwFrameTime := HA.Act120.ftime;
              m_nSpellFrame := 8;
            end;
          121: begin
              m_nSpellCboSkip := 20;
              m_boShowCbo := True;
              m_boNoCheckSpeed := True;
              m_nNewMagicFrame := 4;
              m_nStartFrame := HA.Act121.start + m_btDir * (HA.Act121.frame + HA.Act121.skip);
              m_nEndFrame := m_nStartFrame + HA.Act121.frame - 1;
              m_dwFrameTime := HA.Act121.ftime;
              m_nSpellFrame := 15;
            end;
          123: begin
              m_nSpellCboSkip := 10;
              m_boShowCbo := True;
              m_boNoCheckSpeed := True;
              m_nNewMagicFrame := 3;
              m_nStartFrame := HA.Act123.start + m_btDir * (HA.Act123.frame + HA.Act123.skip);
              m_nEndFrame := m_nStartFrame + HA.Act123.frame - 1;
              m_dwFrameTime := HA.Act123.ftime;
              m_nSpellFrame := 10;
            end;
          124: begin
              m_nSpellCboSkip := 13;
              m_boShowCbo := True;
              m_boNoCheckSpeed := True;
              m_nNewMagicFrame := 3;
              m_nStartFrame := HA.Act124.start + m_btDir * (HA.Act124.frame + HA.Act124.skip);
              m_nEndFrame := m_nStartFrame + HA.Act124.frame - 1;
              m_dwFrameTime := HA.Act124.ftime;
              m_nSpellFrame := 13;
            end;
        else begin
            m_nStartFrame := HA.ActSpell.start + m_btDir * (HA.ActSpell.frame + HA.ActSpell.skip);
            m_nEndFrame := m_nStartFrame + HA.ActSpell.frame - 1;
            m_dwFrameTime := HA.ActSpell.ftime;

            case m_CurMagic.EffectNumber of
              26: begin //心灵启示
                  //m_nMagLight := 2;
                  m_nSpellFrame := 20;
                  m_dwFrameTime := m_dwFrameTime div 2;
                end;
              35: begin //
                  //m_nMagLight := 2;
                  m_nSpellFrame := 15;
                  m_dwFrameTime := Round(m_dwFrameTime * 0.7);
                end;
              29: begin //魔法盾
                  //m_nMagLight := 2;
                  m_nSpellFrame := 17;
                  m_dwFrameTime := Round(m_dwFrameTime * 0.6);
                end;
              43: begin //狮子吼
                  //m_nMagLight := 2;
                  m_nSpellFrame := 20;
                  m_dwFrameTime := m_dwFrameTime div 2;
                end;
              72: begin //死亡之眼
                  //m_nMagLight := 2;
                  m_nSpellFrame := 17;
                  m_dwFrameTime := Round(m_dwFrameTime * 0.6);
                end;
            else begin //.....  措雀汗贱, 荤磊辣雀, 葫汲浅
                //m_nMagLight := 2;
                m_nSpellFrame := DEFSPELLFRAME;
              end;
            end;
          end;
        end;
        m_dwWaitMagicRequest := GetTickCount;
        m_boWarMode := TRUE;
        m_dwWarModeTime := GetTickCount;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_STRUCK: begin
        if m_btHorse <> 0 then begin
          m_nStartFrame := HA.ActHorseStruck.start + m_btDir * (HA.ActHorseStruck.frame + HA.ActHorseStruck.skip);
          m_nEndFrame := m_nStartFrame + HA.ActHorseStruck.frame - 1;
          m_dwFrameTime := 30 {m_dwStruckFrameTime}; //HA.ActHorseStruck.ftime;
          m_dwStartTime := GetTickCount;
          Shift(m_btDir, 0, 0, 1);
          m_dwGenAnicountTime := GetTickCount;
          m_nCurBubbleStruck := 0;
        end
        else begin
          m_nStartFrame := HA.ActStruck.start + m_btDir * (HA.ActStruck.frame + HA.ActStruck.skip);
          m_nEndFrame := m_nStartFrame + HA.ActStruck.frame - 1;
          m_dwFrameTime := 30 {m_dwStruckFrameTime}; //HA.ActStruck.ftime;
          m_dwStartTime := GetTickCount;
          Shift(m_btDir, 0, 0, 1);
          m_dwGenAnicountTime := GetTickCount;
          m_nCurBubbleStruck := 0;
        end;
      end;
    SM_NOWDEATH: begin
        m_nStartFrame := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip);
        m_nEndFrame := m_nStartFrame + HA.ActDie.frame - 1;
        m_dwFrameTime := HA.ActDie.ftime;
        m_dwStartTime := GetTickCount;
      end;
    SM_ALIVE: begin
        m_nStartFrame := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip);
        m_nEndFrame := m_nStartFrame + HA.ActDie.frame - 1;
        m_dwFrameTime := HA.ActDie.ftime;
        m_dwStartTime := GetTickCount;
        m_boReverse := True;
        PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WMain99Images, 1010, 18, 30, False));
        PlaySoundEx(bmg_Alive);
        FrmDlg2.DWndDeath.Visible := False;
      end;
  end;
end;

procedure THumActor.DefaultMotion;
begin
  inherited DefaultMotion;
  {if (m_btEffect = 50) then begin
    if (m_nCurrentFrame <= 536) then begin
      if (GetTickCount - m_dwFrameTick) > 100 then begin
        if m_nFrame < 19 then
          Inc(m_nFrame)
        else begin
          if not m_bo2D0 then
            m_bo2D0 := TRUE
          else
            m_bo2D0 := FALSE;
          m_nFrame := 0;
        end;
        m_dwFrameTick := GetTickCount();
      end;
      m_HumWinSurface := g_WEffectImages.GetCachedImage(m_nHumWinOffset + m_nFrame, m_nSpx, m_nSpy);
    end;
  end
  else }
  if (m_btEffect <> 0) then begin
    if (m_btHorse <> 0) and (not m_boDeath) then begin
      m_HumWinSurface := g_WHumHorseWingImages.GetCachedImage((m_btEffect - 1) * HUMHORSEANFRAME + m_nCurrentFrame, m_nSpx, m_nSpy);
    end
    else begin
      if m_nCurrentFrame < 64 then begin
        if (GetTickCount - m_dwFrameTick) > m_dwFrameTime then begin
          if m_nFrame < 7 then
            Inc(m_nFrame)
          else
            m_nFrame := 0;
          m_dwFrameTick := GetTickCount();
        end;
        m_HumWinSurface := GetWHumWinImage(m_nHumWinOffset + (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
      end
      else begin
        m_HumWinSurface := GetWHumWinImage(m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
      end;
    end;
  end;
end;

function THumActor.GetDefaultFrame(wmode: Boolean): Integer;//动态函数
var
  cf: Integer;
  //  pm: pTMonsterAction;
begin
  //GlimmingMode := FALSE;
  //dr := Dress div 2;            //HUMANFRAME * (dr)
  m_boShowCbo := False;
  m_boNoCheckSpeed := False;
  if m_boDeath then//死亡
    Result := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip) + (HA.ActDie.frame - 1)
  else if wmode then begin//战斗状态
    //GlimmingMode := TRUE;
    Result := HA.ActWarMode.start + m_btDir * (HA.ActWarMode.frame + HA.ActWarMode.skip);
  end
  else begin  //站立状态
    m_nDefFrameCount := HA.ActStand.frame;
    m_dwDefFrameTick := HA.ActStand.ftime;
    if m_nCurrentDefFrame < 0 then
      cf := 0
    else if m_nCurrentDefFrame >= HA.ActStand.frame then
      cf := 0 //HA.ActStand.frame-1
    else
      cf := m_nCurrentDefFrame;
    Result := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip) + cf;
  end;
end;

procedure THumActor.RunFrameAction(frame: Integer);
var
  Meff: TMapEffect;
  event: TClEvent;
  mfly: TFlyingAxe;
begin
  m_boHideWeapon := FALSE;
  if m_nCurrentAction = SM_HEAVYHIT then begin
    if (frame = 5) and (m_boDigFragment) then begin
      m_boDigFragment := FALSE;
      Meff := TMapEffect.Create(8 * m_btDir, 3, m_nCurrX, m_nCurrY);
      Meff.ImgLib := g_WEffectImages;
      Meff.NextFrameTime := 80;
      PlaySound(s_strike_stone);
      //PlaySound (s_drop_stonepiece);
      PlayScene.m_EffectList.Add(Meff);
      event := EventMan.GetEvent(m_nCurrX, m_nCurrY, ET_PILESTONES);
      if event <> nil then
        event.m_nEventParam := event.m_nEventParam + 1;
    end;
  end;
  if m_nCurrentAction = SM_THROW then begin
    if (frame = 3) and (m_boThrow) then begin
      m_boThrow := FALSE;
      mfly := TFlyingAxe(PlayScene.NewFlyObject(Self,
        m_nCurrX,
        m_nCurrY,
        m_nTargetX,
        m_nTargetY,
        m_nTargetRecog,
        mtFlyAxe));
      if mfly <> nil then begin
        TFlyingAxe(mfly).ReadyFrame := 40;
        mfly.ImgLib := g_WMons[3];
        mfly.FlyImageBase := FLYOMAAXEBASE;
      end;
    end;
    if frame >= 3 then
      m_boHideWeapon := TRUE;
  end;
end;

procedure THumActor.DoWeaponBreakEffect;
begin
  m_boWeaponEffect := TRUE;
  m_nCurWeaponEffect := 0;
end;

function THumActor.Run: Boolean;
  //判断魔法是否已经完成（人类：3秒，其他：2秒）
  function MagicTimeOut: Boolean;
  begin
    if Self = g_MySelf then begin
      Result := GetTickCount - m_dwWaitMagicRequest > 5000;
    end
    else
      Result := GetTickCount - m_dwWaitMagicRequest > 3500;
    if Result then
      m_CurMagic.ServerMagicCode := 0;
  end;
var
  prv: Integer;
  m_dwFrameTimetime: LongWord;
  bofly: Boolean;
begin
  Result := False;
  if GetTickCount - m_dwGenAnicountTime > 120 then begin //林贱狼阜 殿... 局聪皋捞记 瓤苞
    if (Self = g_MySelf) and (g_UseItems[U_WEAPON].S.Name <> '') then begin
      m_nWeaponEffect := g_UseItems[U_WEAPON].S.AniCount;
    end;
    m_dwGenAnicountTime := GetTickCount;
    Inc(m_nGenAniCount);
    if m_nGenAniCount > 100000 then
      m_nGenAniCount := 0;
    Inc(m_nCurBubbleStruck);
  end;
   if m_boWeaponEffect then begin  //武器效果，每120秒变化一帧，共5帧
    if GetTickCount - m_dwWeaponpEffectTime > 120 then begin
      m_dwWeaponpEffectTime := GetTickCount;
      Inc(m_nCurWeaponEffect);
      if m_nCurWeaponEffect >= MAXWPEFFECTFRAME then
        m_boWeaponEffect := FALSE;
    end;
  end;

  if (m_nCurrentAction = SM_WALK) or
    (m_nCurrentAction = SM_BACKSTEP) or
    (m_nCurrentAction = SM_RUN) or
    (m_nCurrentAction = SM_LEAP) or
    (m_nCurrentAction = SM_HORSERUN) or
    (m_nCurrentAction = SM_RUSH) or
    (m_nCurrentAction = SM_RUSHCBO) or
    (m_nCurrentAction = SM_MAGICMOVE) or
    (m_nCurrentAction = SM_MAGICFIR) or
    (m_nCurrentAction = SM_RUSHKUNG) then
    Exit;

  m_boMsgMuch := FALSE;
  if (Self <> g_MySelf) {or m_boShowCbo} then begin
    if (m_MsgList.Count >= 2) {or m_boShowCbo} then
      m_boMsgMuch := TRUE;
  end;
   //动作声效
  RunActSound(m_nCurrentFrame - m_nStartFrame);
  RunFrameAction(m_nCurrentFrame - m_nStartFrame);

  prv := m_nCurrentFrame;
  if m_nCurrentAction <> 0 then begin
    if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
      m_nCurrentFrame := m_nStartFrame;

    if (Self <> g_MySelf) and (m_boUseMagic) then begin
      m_dwFrameTimetime := Round(m_dwFrameTime / 1.8);
    end
    else begin
      if m_boMsgMuch then
        m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
      else
        m_dwFrameTimetime := m_dwFrameTime;
    end;

    if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
      if m_nCurrentFrame < m_nEndFrame then begin

        //付过牢 版快 辑滚狼 脚龋甫 罐酒, 己傍/角菩甫 犬牢茄饶
        //付瘤阜悼累阑 场辰促.
        {m_nCurCboFrame := 17;
        m_boShowCbo := True;}
        if m_boUseMagic then begin
          if (m_nCurEffFrame = m_nSpellFrame - m_nNewMagicFrame) or (MagicTimeOut) then begin//魔法执行完
            if (m_CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin
              Inc(m_nCurrentFrame);
              Inc(m_nCurEffFrame);
              m_dwStartTime := GetTickCount;
            end;
          end
          else begin
            Inc(m_nCurEffFrame);
            if (m_nCurrentFrame < m_nEndFrame - 1) or (m_nCurEffFrame >= m_nSpellFrame) then
              Inc(m_nCurrentFrame);
            m_dwStartTime := GetTickCount;
          end;
        end
        else if m_boShowCbo then begin
          if (m_nCurCboFrame = m_nSpellFrame - 1) then begin
            Inc(m_nCurrentFrame);
            Inc(m_nCurCboFrame);
            m_dwStartTime := GetTickCount;
          end
          else begin
            if m_nCurrentFrame < m_nEndFrame - 1 then
              Inc(m_nCurrentFrame);
            Inc(m_nCurCboFrame);
            m_dwStartTime := GetTickCount;
          end;
        end
        else begin
          Inc(m_nCurrentFrame);
          m_dwStartTime := GetTickCount;
        end;

      end
      else begin
        if Self = g_MySelf then begin
          if FrmMain.ServerAcceptNextAction then begin//锁定人物本身 服务器返回结果 则释放
            m_nCurrentAction := 0;
            m_boReverse := False;
            m_boUseMagic := FALSE;
          end;
        end
        else begin//不是人物
          m_nCurrentAction := 0;  //动作为空
          m_boUseMagic := FALSE;
          m_boReverse := False;
        end;
        m_boHitEffect := FALSE;
      end;
      if m_boUseMagic then begin
        if m_nCurEffFrame = m_nSpellFrame - (m_nNewMagicFrame - 1) then begin //魔法过程 先放自身魔法 的-1图
          //付过 惯荤
          if m_CurMagic.ServerMagicCode > 0 then begin
            with m_CurMagic do
              PlayScene.NewMagic(Self,
                ServerMagicCode,
                EffectNumber,
                m_nCurrX,
                m_nCurrY,
                TargX,
                TargY,
                Target,
                EffectType,
                Recusion,
                AniTime,
                bofly);
            if bofly then
              PlaySound(m_nMagicFireSound)
            else
              PlaySound(m_nMagicExplosionSound);
          end;
          if Self = g_MySelf then begin
            g_dwLatestSpellTick := GetTickCount;
            g_boLatestSpell := False;
            SetMagicUse(g_nLastMagicIdx);
          end;
          m_CurMagic.ServerMagicCode := 0;
        end;
      end;

    end;
    if m_btRace = 0 then
      m_nCurrentDefFrame := 0
    else
      m_nCurrentDefFrame := -10;
    m_dwDefFrameTime := GetTickCount;
  end
  else begin
    if GetTickCount - m_dwSmoothMoveTime > 200 then begin
      if GetTickCount - m_dwDefFrameTime > m_dwDefFrameTick then begin
        m_dwDefFrameTime := GetTickCount;
        Inc(m_nCurrentDefFrame);
        if m_nCurrentDefFrame >= m_nDefFrameCount then
          m_nCurrentDefFrame := 0;
      end;
      DefaultMotion;
    end;
  end;

  if prv <> m_nCurrentFrame then begin
    m_dwLoadSurfaceTime := GetTickCount;
    prv := m_nCurrentFrame;
    if m_boReverse then begin
      m_nCurrentFrame := m_nEndFrame - (m_nCurrentFrame - m_nStartFrame);
    end;
    try
      LoadSurface;
    finally
      m_nCurrentFrame := prv;
    end;
    Result := True;
  end;
end;
{
function THumActor.Light: Integer;
var
 l: Integer;
begin
 l := m_nChrLight;
 if l < m_nMagLight then begin
   if m_boUseMagic or m_boHitEffect then
     l := m_nMagLight;
 end;
 Result := l;
end;     }

procedure THumActor.LoadShopTitle;
var
  d: TDirectDrawSurface;
begin
  if m_boShop then begin

    d := g_WMain99Images.Images[438];
    if d <> nil then begin
      if m_UserShopSurface = nil then begin
        m_UserShopSurface := TDXImageTexture.Create(g_DXCanvas);
        m_UserShopSurface.CopyTexture(d);
      end;
      m_UserShopSurface.TextOutEx((d.Width - g_DXCanvas.TextWidth(m_sShopTitle)) div 2, 4, m_sShopTitle, $82FF);
    end;
  end
  else begin
    if m_UserShopSurface <> nil then
      m_UserShopSurface.Free;
    m_UserShopSurface := nil;
  end;
  //m_UserShopSurface := nil;
end;

procedure THumActor.LoadSurface;
var
  CurrentFrame: Integer;
begin
  if (m_btHorse <> 0) and (not m_boDeath) then begin
    m_BodySurface := g_WHumHorseImages.GetCachedImage(HUMHORSEANFRAME * m_btDress + m_nCurrentFrame, m_nPx, m_nPy);
    //if m_BodySurface = nil then
      //m_BodySurface := g_WHumHorseImages.GetCachedImage(HUMHORSEANFRAME * m_btSex + m_nCurrentFrame, m_nPx, m_nPy);

    m_HoresSurface := g_WRideImages.GetCachedImage(RIDEFRAME * (m_btHorse - 1) + m_nCurrentFrame, m_nhsX, m_nhsy);
    //if m_HoresSurface = nil then
      //m_HoresSurface := g_WRideImages.GetCachedImage(RIDEFRAME + m_nCurrentFrame, m_nhsX, m_nhsy);

    if m_nHairOffset >= 0 then
      m_HairSurface := g_WHairImgImages.GetCachedImage(m_nHairOffset + m_nCurrentFrame + HUMANFRAME, m_nHpx, m_nHpy)
    else
      m_HairSurface := nil;

    if (m_btEffect <> 0) then
      m_HumWinSurface := g_WHumHorseWingImages.GetCachedImage((m_btEffect - 1) * HUMHORSEANFRAME + m_nCurrentFrame, m_nSpx, m_nSpy)
    else
      m_HumWinSurface := nil;
    m_WeaponSurface := nil;
    m_WeaponEffectSurface := nil;

  end
  else if m_boShowCbo then begin
    m_HoresSurface := nil;
    m_HumWinSurface := nil;
    m_HairSurface := nil;

    m_BodySurface := GetWcboHumImg(m_btDress, m_nCurrentFrame, m_nPx, m_nPy);
    if m_BodySurface = nil then
      m_BodySurface := GetWcboHumImg(m_btDress, m_btDir * 10, m_nPx, m_nPy);

    if m_nHairOffset >= 0 then begin
      m_HairSurface := g_WcboHairImages.GetCachedImage(HUMCBOANFRAME * 2 + HUMCBOANFRAME * m_btSex + m_nCurrentFrame,
        m_nHpx, m_nHpy);
      if m_HairSurface = nil then
        m_HairSurface := g_WcboHairImages.GetCachedImage(HUMCBOANFRAME * 2 + HUMCBOANFRAME * m_btSex + m_btDir * 10,
          m_nHpx, m_nHpy);
    end;

    if (m_btEffect > 0) then begin
      m_HumWinSurface := GetWcboHumEffectImg((m_btEffect - 1), m_nCurrentFrame, m_nSpx, m_nSpy);
      if m_HumWinSurface = nil then
        m_HumWinSurface := GetWcboHumEffectImg((m_btEffect - 1), m_btDir * 10, m_nSpx, m_nSpy);
    end;

    m_WeaponSurface := GetWcboWeaponImg(m_btWeapon, m_nCurrentFrame, m_nWpx, m_nWpy);
    if m_WeaponSurface = nil then
      m_WeaponSurface := GetWcboWeaponImg(m_btWeapon, m_btDir * 10, m_nWpx, m_nWpy);

    m_WeaponEffectSurface := nil;
    if m_nWeaponEffect > 0 then
      m_WeaponEffectSurface := GetWcboWeaponImg(((m_nWeaponEffect - 1) + m_btSex), m_nCurrentFrame, m_nWepx, m_nWepy);

  end
  else begin
    m_HoresSurface := nil;
    m_HumWinSurface := nil;
    CurrentFrame := m_nCurrentFrame;
    if m_boUseMagic and (m_CurMagic.EffectNumber = 70) then begin
      CurrentFrame := m_nStartFrame;
    end;
    m_BodySurface := GetWHumImg(m_btDress, m_btSex, CurrentFrame, m_nPx, m_nPy);
    if m_BodySurface = nil then
      m_BodySurface := GetWHumImg(m_btSex, m_btSex, CurrentFrame, m_nPx, m_nPy);

    if m_nHairOffset >= 0 then
      m_HairSurface := g_WHairImgImages.GetCachedImage(m_nHairOffset + CurrentFrame, m_nHpx, m_nHpy)
    else
      m_HairSurface := nil;

    if (m_btEffect <> 0) then begin
      if CurrentFrame < 64 then begin
        if (GetTickCount - m_dwFrameTick) > m_dwFrameTime then begin
          if m_nFrame < 7 then//8个动作
            Inc(m_nFrame)
          else
            m_nFrame := 0;
          m_dwFrameTick := GetTickCount();
        end;
        m_HumWinSurface := GetWHumWinImage(m_nHumWinOffset + (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
      end
      else begin
        m_HumWinSurface := GetWHumWinImage(m_nHumWinOffset + CurrentFrame, m_nSpx, m_nSpy);
      end;
    end;

    //WeaponSurface:=FrmMain.WWeapon.GetCachedImage(WeaponOffset + CurrentFrame, wpx, wpy);
    m_WeaponSurface := GetWWeaponImg(m_btWeapon, m_btSex, CurrentFrame, m_nWpx, m_nWpy);
    if m_WeaponSurface = nil then
      m_WeaponSurface := GetWWeaponImg(0, m_btSex, CurrentFrame, m_nWpx, m_nWpy);

    m_WeaponEffectSurface := nil;
    if m_nWeaponEffect > 0 then
      m_WeaponEffectSurface := GetWHumWinImage(HUMANFRAME * ((m_nWeaponEffect - 1) + m_btSex) + CurrentFrame, m_nWepx, m_nWepy);
  end;
end;

{-----------------------------------------------------------------}
//绘制人物
{-----------------------------------------------------------------}
procedure THumActor.DrawChr(dsurface: TDirectDrawSurface; dx, dy: Integer;
  blend: Boolean; boFlag: Boolean);
var
  idx, ax, ay: Integer;
  d: TDirectDrawSurface;
  ceff: TColorEffect;
  wimg: TWMImages;
begin
  d := nil; //Jacky
  if not (m_btDir in [0..7]) then//当前站立方向 不属于0..7
    Exit;
  if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin//60秒释放一次未使用的图片，所以每隔60秒要重新装载一次
    m_dwLoadSurfaceTime := GetTickCount;
    LoadSurface; //重新装载图片到bodysurface
  end;
  ceff := GetDrawEffectValue;//人物显示颜色
  if m_btRace = 0 then begin//人类
    if (m_nCurrentFrame >= 0) and (m_nCurrentFrame <= 599) then
      m_nWpord := WORDER[m_btSex, m_nCurrentFrame];

    if (m_btEffect <> 0) and (m_btEffect <> 50) and (m_HumWinSurface <> nil) then begin
      if (m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5) then begin
        DrawBlend(dsurface,
          dx + m_nSpx + m_nShiftX,
          dy + m_nSpy + m_nShiftY,
          m_HumWinSurface,
          1);
      end;
    end; //0x0047D03F

    if m_HoresSurface <> nil then
      DrawEffSurface(dsurface, m_HoresSurface, dx + m_nhsx + m_nShiftX, dy + m_nhsy + m_nShiftY, blend, ceff);

      //先画武器
    if (m_nWpord = 0) and (not blend) and (m_btWeapon >= 2) and (m_WeaponSurface <> nil) and (not m_boHideWeapon) then begin
      DrawEffSurface(dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);
      if m_WeaponEffectSurface <> nil then
        DrawBlend(dsurface,
          dx + m_nWepx + m_nShiftX,
          dy + m_nWepy + m_nShiftY,
          m_WeaponEffectSurface,
          1);
    end;
      //画人物
    if m_BodySurface <> nil then
      DrawEffSurface(dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
      //画头发
    if m_HairSurface <> nil then
      DrawEffSurface(dsurface, m_HairSurface, dx + m_nHpx + m_nShiftX, dy + m_nHpy + m_nShiftY, blend, ceff);

      //后画武器
    if (m_nWpord = 1) and {(not blend) and}(m_btWeapon >= 2) and (m_WeaponSurface <> nil) and (not m_boHideWeapon) then begin
      DrawEffSurface(dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);
      if m_WeaponEffectSurface <> nil then
        DrawBlend(dsurface,
          dx + m_nWepx + m_nShiftX,
          dy + m_nWepy + m_nShiftY,
          m_WeaponEffectSurface,
          1);
    end;

    if (m_btEffect = 50) then begin
      if (m_HumWinSurface <> nil) then
        DrawBlend(dsurface,
          dx + m_nSpx + m_nShiftX,
          dy + m_nSpy + m_nShiftY,
          m_HumWinSurface,
          1);
    end
    else if (m_btEffect <> 0) and (m_HumWinSurface <> nil) then begin
      if (m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6) or (m_btDir = 2) then begin
        DrawBlend(dsurface,
          dx + m_nSpx + m_nShiftX,
          dy + m_nSpy + m_nShiftY,
          m_HumWinSurface,
          1);
      end;
    end;

    //显示魔法盾时效果
    if {(not m_boShowcbo) and}(m_nState and $00100000 <> 0) then begin //林贱狼阜
      if (m_nCurrentAction = SM_STRUCK) and (m_nCurBubbleStruck < 3) then
        idx := MAGBUBBLESTRUCKBASE + m_nCurBubbleStruck
      else
        idx := MAGBUBBLEBASE + (m_nGenAniCount mod 3);
      d := g_WMagic99Images.GetCachedImage(idx, ax, ay);
      if d <> nil then
        DrawBlend(dsurface,
          dx + ax + m_nShiftX,
          dy + ay + m_nShiftY,
          d, 1);
    end;

    if {(not m_boShowcbo) and}(m_nState and $01000000 <> 0) then begin //林贱狼阜
      {if (m_nCurrentAction = SM_STRUCK) and (m_nCurBubbleStruck < 3) then
        idx := 3999 + m_nCurBubbleStruck
      else  }
      idx := 3998 + (m_nGenAniCount mod 4);
      d := g_WcboEffectImages.GetCachedImage(idx, ax, ay);
      if d <> nil then
        DrawBlend(dsurface,
          dx + ax + m_nShiftX,
          dy + ay + m_nShiftY,
          d, 1);
    end;

  end;

  //显示魔法效果
  {if m_boShowCbo and (m_CurMagic.EffectNumber > 0) then begin

  end else   }
  if m_boUseMagic and (m_CurMagic.EffectNumber > 0) then begin
    if m_nCurEffFrame in [0..m_nSpellFrame - 1] then begin
      GetEffectBase(m_CurMagic.EffectNumber - 1, 0, wimg, idx);//取得魔法效果所在图库
      if m_CurMagic.EffectNumber in [114, 119..121, 123] then
        idx := idx + m_nCurEffFrame + m_btDir * m_nSpellCboSkip
      else if m_CurMagic.EffectNumber = 56 then
        idx := idx + m_nCurEffFrame + m_btDir * 20
      else
        idx := idx + m_nCurEffFrame;//IDx对应WIL文件 里的图片位置，即用技能时显示的动画
      if wimg <> nil then
        d := wimg.GetCachedImage(idx, ax, ay);
      if d <> nil then
        DrawBlend(dsurface,
          dx + ax + m_nShiftX,
          dy + ay + m_nShiftY,
          d, 1);

      if m_CurMagic.EffectNumber = 33 then begin
        d := g_WMagic2Images.GetCachedImage(400 + m_nCurEffFrame, ax, ay);
        if d <> nil then
          DrawBlend(dsurface,
            dx + ax + m_nShiftX + 5,
            dy + ay + m_nShiftY + 5,
            d, 1);
      end;

    end;
  end;

{----------------------------------------------------------------------------}
//显示攻击效果              2007.10.31 updata
//m_boHitEffect 是否是攻击类型
//m_nHitEffectNumber  使用攻击的数组 取出图的号
//m_btDir  方向
//m_nCurrentFrame 当前的桢数   m_nStartFrame开始的桢数
{----------------------------------------------------------------------------}
  if m_boShowCbo and (m_nHitEffectNumber > 0) then begin
    GetEffectBase(m_nHitEffectNumber - 1, 2, wimg, idx);
    if (m_nHitEffectNumber = 3) and (m_nCurCboFrame < 4) then
      idx := 1921 + m_btDir * m_nSpellCboSkip + m_nCurCboFrame
    else if m_nHitEffectNumber = 2 then
      idx := idx + m_btDir * m_nSpellCboSkip + (m_nCurrentFrame - m_nStartFrame)
    else
      idx := idx + m_btDir * m_nSpellCboSkip + m_nCurCboFrame;
    if wimg <> nil then
      d := wimg.GetCachedImage(idx, ax, ay);
    if d <> nil then
      DrawBlend(dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 1);

  end
  else if m_boHitEffect and (m_nHitEffectNumber > 0) then begin
    GetEffectBase(m_nHitEffectNumber - 1, 1, wimg, idx);
    if m_nHitEffectNumber <> 7 then
      idx := idx + m_btDir * 10 + (m_nCurrentFrame - m_nStartFrame)
    else
      idx := idx{开始的号} + (m_nCurrentFrame - m_nStartFrame);
    if wimg <> nil then
      d := wimg.GetCachedImage(idx, ax, ay);
    if d <> nil then
      DrawBlend(dsurface,
        dx + ax + m_nShiftX,
        dy + ay + m_nShiftY,
        d, 1);
  end;

  //显示武器破碎效果
  if m_boWeaponEffect and (not m_boShowcbo) then begin
    idx := WPEFFECTBASE + m_btDir * 10 + m_nCurWeaponEffect;
    d := g_WMagicImages.GetCachedImage(idx, ax, ay);
    if d <> nil then
      DrawBlend(dsurface,
        dx + ax + m_nShiftX,
        dy + ay + m_nShiftY,
        d, 1);
  end;

end;

end.

