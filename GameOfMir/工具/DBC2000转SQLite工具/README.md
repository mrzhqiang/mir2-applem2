# DBC2000 转 SQLite3 工具

## 功能说明

这个工具可以将 DBC2000（基于 BDE/Paradox）数据库的表结构导出为 SQLite3 数据库文件。

## 主要功能

1. **连接 DBC2000 数据库**：通过 BDE 连接到 DBC2000 数据库目录
2. **读取表结构**：自动读取数据库中的所有表及其字段定义
3. **导出表结构**：将表结构转换为 SQLite3 的 CREATE TABLE 语句
4. **导出数据**（可选）：可选择性地导出表数据到 SQLite3
5. **索引支持**：自动转换主键和索引定义

## 使用方法

### 1. 准备工作

- 确保系统已安装 BDE（Borland Database Engine）
- 确保 DBC2000 数据库文件（.DB 文件）在指定目录中
- 确保有 SQLite3 支持（项目已包含 SQLiteTable3 单元）

### 2. 运行工具

1. 编译并运行 `DbcToSqliteSchema.exe`
2. 点击"浏览..."选择 DBC2000 数据库目录（包含 .DB 文件的目录）
3. 点击"刷新表列表"按钮，工具会自动扫描并列出所有表
4. 选择要导出的表（可多选，默认全选）
5. 选择导出选项：
   - **导出表结构**：生成 CREATE TABLE 语句
   - **导出数据**：同时导出表中的数据
6. 选择或输入 SQLite 数据库文件路径
7. 点击"开始导出"按钮

### 3. 查看结果

- 导出过程中会在日志窗口显示进度和状态信息
- 导出完成后，可以使用 SQLite 工具（如 SQLite Expert、DB Browser for SQLite）打开生成的 SQLite 文件查看结果

## 数据类型映射

| DBC2000/Paradox 类型 | SQLite3 类型 |
|---------------------|--------------|
| String, FixedChar, WideString | TEXT |
| Smallint, Integer, Word, AutoInc | INTEGER |
| Largeint | INTEGER |
| Float, Currency, BCD | REAL |
| Boolean | INTEGER (0/1) |
| Date, Time, DateTime, TimeStamp | REAL (Julian Day) |
| Memo, Blob, Graphic | BLOB |

## 注意事项

1. **BDE 配置**：工具使用 STANDARD 驱动连接 Paradox 数据库，确保 BDE 配置正确
2. **文件权限**：确保对数据库目录有读取权限
3. **大文件处理**：对于包含大量数据的表，导出数据可能需要较长时间
4. **字符编码**：注意处理中文字符的编码问题
5. **主键处理**：如果原表没有主键，SQLite 表将使用 INTEGER PRIMARY KEY AUTOINCREMENT

## 技术实现

- 使用 `TDatabase` 和 `TTable` 组件连接 BDE 数据库
- 使用 `TSQLiteDatabase` 创建和管理 SQLite 数据库
- 自动转换字段类型、主键和索引定义
- 支持事务处理，确保数据一致性

## 文件结构

```
DBC2000转SQLite工具/
├── DbcToSqliteSchema.pas    # 主程序单元
├── DbcToSqliteSchema.dfm    # 表单设计文件
├── DbcToSqliteSchema.dpr    # 项目文件
└── README.md                # 使用说明
```

## 依赖项

- `DBTables` - BDE 数据库访问
- `DB` - 数据库通用组件
- `SQLiteTable3` - SQLite3 数据库访问
- `SQLite3` - SQLite3 接口

## 常见问题

### Q: 无法连接到数据库？
A: 检查 BDE 是否正确安装，数据库目录路径是否正确，文件权限是否足够。

### Q: 导出失败？
A: 查看日志窗口的错误信息，常见原因包括：
- 表名包含特殊字符
- 字段类型不支持
- 数据格式错误

### Q: 如何只导出表结构？
A: 取消勾选"导出数据"选项，只勾选"导出表结构"。

### Q: 支持哪些数据库格式？
A: 目前支持通过 BDE 访问的 Paradox 格式数据库（DBC2000 使用的格式）。

## 更新日志

### v1.0 (2024)
- 初始版本
- 支持表结构导出
- 支持数据导出
- 支持索引转换
