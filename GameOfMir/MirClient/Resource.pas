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
  // 选择角色界面的开始按钮
  BTN_SELECT_ROLE_START = 1899;
  // 选择角色界面的新建按钮
  BTN_SELECT_ROLE_NEW = 1900;
  // 选择角色界面的删除按钮
  BTN_SELECT_ROLE_DELETE = 1901;
  // 选择角色界面的恢复按钮
  BTN_SELECT_ROLE_RECOVER = 2136;
  // 选择角色界面的退出按钮
  BTN_SELECT_ROLE_EXIT = 1902;
  // 选择角色界面的左侧选择按钮正常状态
  BTN_SELECT_ROLE_LEFT_NORMAL = 1903;
  // 选择角色界面的左侧选择按钮按下状态
  BTN_SELECT_ROLE_LEFT_PRESSE = 1904;
  // 创建角色背景
  BG_CREATE_ROLE = 1905;
  // 创建角色时的战士职业
  BTN_WARRIOR = 1911;
  // 创建角色时的法师职业
  BTN_WIZZARD = 1912;
  // 创建角色时的道士职业
  BTN_MONK = 1913;
  // 创建角色时的男性
  BTN_MALE = 1914;
  // 创建角色时的女性
  BTN_FEMALE = 1915;
  // 创建角色时确定按钮
  BTN_CREATE_OK = 1892;
  // 创建角色时关闭按钮
  BTN_CREATE_CLOSE = 1850;
{$ELSE}
  SELECTEDFRAME = 16;
  FREEZEFRAME = 16;
  EFFECTFRAME = 14;
  // 登录时的仙侠背景 301 -- 800x600 or 302 -- 1024x768
  LOGINBAGIMGINDEX = 301;
  // 实际上是三个角色栏的界面
  PLAY_SCENE_BEGIN = 9;
  // 选择角色界面的开始按钮
  BTN_SELECT_ROLE_START = 13;
  // 选择角色界面的新建按钮
  BTN_SELECT_ROLE_NEW = 13;
  // 选择角色界面的删除按钮
  BTN_SELECT_ROLE_DELETE = 13;
  // 选择角色界面的恢复按钮
  BTN_SELECT_ROLE_RECOVER = 13;
  // 选择角色界面的退出按钮
  BTN_SELECT_ROLE_EXIT = 13;
  // 选择角色界面的左侧选择按钮正常状态
  BTN_SELECT_ROLE_LEFT_NORMAL = 1903;
  // 选择角色界面的左侧选择按钮按下状态
  BTN_SELECT_ROLE_LEFT_PRESSE = 1904;
{$IFEND}
  // 选择人物的动画 800x600
  BG_SELECT_RULE = 2062;
  // 剑侠界面的感叹号
  EXCLAMATION_POINT = 288;

implementation

end.