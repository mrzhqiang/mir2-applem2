# 常用命令和快捷操作

## Delphi 编译命令
- 编译项目：在 Delphi IDE 中按 `Ctrl+F9` 或使用菜单 `Project > Build`
- 运行项目：按 `F9` 或使用菜单 `Run > Run`
- 清理项目：使用菜单 `Project > Clean`
- 重新编译：使用菜单 `Project > Build All Projects`

## Git 常用命令
```bash
# 查看状态
git status

# 添加文件
git add .
git add <文件名>

# 提交
git commit -m "类型: 描述"

# 推送
git push

# 拉取
git pull

# 查看日志
git log
git log --oneline

# 创建分支
git checkout -b feature/功能名称

# 切换分支
git checkout <分支名>

# 合并分支
git merge <分支名>
```

## 项目特定命令
- 清理编译文件：运行 `Build\Clear.bat` 或 `清理垃圾.bat`
- 编译登录器：打开 `mir2.bdsgroup` 项目组
- 编译服务端：打开 `所有服务端.bdsgroup` 项目组

## 文件操作
- 查找文件：在 Cursor 中使用 `Ctrl+P` 快速打开文件
- 全局搜索：使用 `Ctrl+Shift+F` 搜索代码
- 查找引用：使用 `Shift+F12` 查找符号引用
- 重命名：使用 `F2` 重命名符号

## 代码导航
- 转到定义：`F12` 或 `Ctrl+Click`
- 返回：`Alt+Left` 返回上一个位置
- 前进：`Alt+Right` 前进到下一个位置
- 符号搜索：`Ctrl+T` 搜索符号
- 文件搜索：`Ctrl+P` 快速打开文件

## 代码编辑
- 格式化代码：`Shift+Alt+F`（如果支持）
- 注释/取消注释：`Ctrl+/` 或 `Ctrl+Shift+/`
- 复制行：`Shift+Alt+Down`
- 移动行：`Alt+Up/Down`
- 多光标：`Alt+Click` 添加光标

## 调试相关
- 设置断点：`F9` 切换断点
- 开始调试：`F5` 启动调试
- 单步执行：`F10` 单步跳过，`F11` 单步进入
- 继续执行：`F5` 继续到下一个断点
- 停止调试：`Shift+F5`

## 常用 PowerShell 命令（Windows）
```powershell
# 查找文件
Get-ChildItem -Recurse -Filter "*.pas" | Select-String "关键词"

# 清理编译文件
Get-ChildItem -Recurse -Include *.dcu,*.obj,*.exe | Remove-Item

# 统计代码行数
Get-ChildItem -Recurse -Include *.pas | Get-Content | Measure-Object -Line
```

## 数据库操作
- 连接数据库：使用 DBServer 或 SQLServer 工具
- 执行 SQL：在数据库管理工具中执行
- 备份数据库：定期备份 Mud2 目录下的数据库文件

## 网络调试
- 检查端口占用：`netstat -ano | findstr :端口号`
- 查看连接：`netstat -an`
- 测试连接：使用 telnet 或专用工具测试 Socket 连接