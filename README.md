# 苹果引擎-兰达尔版本
版本来自网络开源的 mir2-applem2 仓库，即苹果引擎。

## 编译条件
1. 下载并安装 Delphi 2007 破解版；
2. 安装本仓库中的 demmrfm/Raize_5.5 程序。
3. 依次安装及添加库依赖：
   https://www.bilibili.com/video/BV1Us411w7X3?from=search&seid=10712681474963178557
    
**注意： 库依赖需要打开 Delphi 2007，找到 Tools 菜单，依次进入：`Options | Library - Win32 | Library path` 进行添加。**


## 引擎编译
这部分请参考：【编译教程】，其中库依赖的添加方式已更新，参考意义不大。

## 登录器编译
打开【mir2】项目组，参考编译视频进行相关操作。

### 简单登录器
最简单的是编译 【mir2】 程序。

注意：在 `GameOfMir\Common\Grobal2.pas` 中的代码： `Var_Interface = Var_Mir2;` 

- `Var_Interface` 表示可以切换界面
  - `Var_Mir2` 表示盛大界面
  - `Var_Default` 需要改名为 `default.exe`

### 自由登录器
进阶一点的是编译 Login.exe 程序，这一步需要先编译两个版本的 【简单登录器】 到 `GameOfMir\工具\FreeLogin\Data.rc` 文件指定的目录。

注意：`default` 表示剑侠端，`mir2` 表示盛大端。

```text
mir2Data  Data  D:\Release\Client\mir2.exe
defaultData Data  D:\Release\Client\default.exe
```

到这里开始双击 `Data.cmd` 执行资源生成，可以看到 `Data.RES` 文件的修改日期发生了变化，说明资源成功更新。

这个时候可以编译 `Login.exe` 程序。 

### 登录器配置器
这时候可以直接编译登录器配置器，在 `\工具\登录器配置器` 目录下打开项目即可。