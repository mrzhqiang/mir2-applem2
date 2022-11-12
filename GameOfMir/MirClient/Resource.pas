unit Resource;
// 资源，包含客户端 UI 文件的路径、编码以及分辨率信息
interface

uses
  Grobal2;

const
  // g_WOChrSelImages -- Data\ChrSel.wil 文件
  // g_WMain99Images -- DATADIRNAME + 'Prguse_.pak';
{$IF Var_Interface = Var_Mir2}
  // selected frame 选人时点了左边或右边的角色此时会有人物动画，有16帧
  SELECTEDFRAME = 16;
  //打开ChrSel.wil,,可以看到男54是40-55
  //freeze frame 男54,,60-72,,共13帧
  FREEZEFRAME = 13;
  EFFECTFRAME = 14;
  // 登录时的大门 800x600
  LOGINBAGIMGINDEX = 22;
  // 开门动画：一共 10 帧，从 23 开始到 33 结束，有图像的分辨率是 496x361
  PLAY_SCENE_BEGIN = 23;
{$ELSE}
  SELECTEDFRAME = 16;
  FREEZEFRAME = 16;
  EFFECTFRAME = 14;
  // 登录时的仙侠背景 301 -- 800x600 or 302 -- 1024x768
  LOGINBAGIMGINDEX = 301;
  // 实际上是三个角色栏的界面
  PLAY_SCENE_BEGIN = 9;
{$IFEND}
  // 选择人物的动画 800x600
  BG_SELECT_RULE = 2062;

implementation

end.