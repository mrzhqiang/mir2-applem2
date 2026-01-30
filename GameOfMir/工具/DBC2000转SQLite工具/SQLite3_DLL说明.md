# SQLite3.dll 配置说明

## 问题描述

如果运行程序时出现错误："由于找不到 sqlite3.dll，无法继续执行代码"，说明系统无法找到 SQLite3 动态链接库文件。

## 解决方案

### 方案 1：将 sqlite3.dll 复制到程序目录（推荐）

1. 找到 `sqlite3.dll` 文件（位于 `GameOfMir\Common\sqlite3.dll`）
2. 将 `sqlite3.dll` 复制到程序可执行文件（`DbcToSqliteTool.exe`）所在的目录
3. 重新运行程序

### 方案 2：将 sqlite3.dll 复制到系统目录

1. 将 `sqlite3.dll` 复制到以下目录之一：
   - `C:\Windows\System32\` (32位系统或64位系统的32位程序)
   - `C:\Windows\SysWOW64\` (64位系统的32位程序)
2. 重新运行程序

### 方案 3：添加到系统 PATH 环境变量

1. 将包含 `sqlite3.dll` 的目录添加到系统 PATH 环境变量
2. 重新启动程序

## 程序自动搜索路径

程序启动时会自动在以下位置搜索 `sqlite3.dll`：

1. 程序可执行文件所在目录
2. `程序目录\..\Common\` (即 `GameOfMir\Common\`)
3. `.\Common\` (当前工作目录下的 Common 目录)

如果程序在这些位置找到了 DLL，会自动设置搜索路径。

## 验证 DLL 是否存在

可以通过以下方式验证：

1. 检查 `GameOfMir\Common\sqlite3.dll` 文件是否存在
2. 如果不存在，可以从 SQLite 官网下载：
   - 访问 https://www.sqlite.org/download.html
   - 下载 "Precompiled Binaries for Windows" 中的 `sqlite-dll-win32-x86-*.zip`
   - 解压后找到 `sqlite3.dll` 文件

## 注意事项

- 确保下载的 `sqlite3.dll` 版本与程序兼容（通常是 32 位版本）
- 如果使用 64 位程序，需要下载 64 位版本的 DLL
- 建议将 DLL 放在程序目录中，这样便于程序分发和部署

## 故障排除

如果按照上述步骤操作后仍然无法找到 DLL：

1. 检查 DLL 文件是否损坏（尝试重新下载）
2. 检查文件权限（确保有读取权限）
3. 检查防病毒软件是否阻止了 DLL 加载
4. 查看程序日志窗口中的警告信息，了解程序搜索了哪些路径
