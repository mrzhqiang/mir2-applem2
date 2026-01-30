# 项目规则文件
# 这个文件用于定义项目级别的 AI 助手行为规则

# Delphi 代码规范和最佳实践

## 命名规范
- 类名使用 PascalCase（如：TMyClass）
- 接口名以 I 开头（如：IMyInterface）
- 单元名使用 PascalCase（如：MyUnit.pas）
- 变量和函数参数使用 camelCase（如：myVariable）
- 常量使用 UPPER_CASE（如：MAX_COUNT）
- 私有成员变量以 F 开头（如：FMyField）
- 属性名使用 PascalCase（如：MyProperty）
- 事件处理程序以 On 开头（如：OnClick）

## 代码结构
- 单元结构顺序：unit 声明、uses 子句、type 声明、var 声明、implementation、initialization、finalization
- 类成员顺序：published、public、protected、private
- 使用 interface 和 implementation 分离声明和实现
- 每个单元文件只包含一个主要类或功能模块

## 类型和变量声明
- 使用明确的类型声明，避免使用 var 类型推断
- 字符串使用 AnsiString（Delphi 2007 默认）
- 指针类型使用明确的类型定义
- 数组和记录类型使用 type 关键字定义

## 异常处理
- 使用 try..except 处理异常
- 使用 try..finally 确保资源释放
- 在关键操作处添加异常处理
- 记录异常信息以便调试

## 内存管理
- 对象创建后必须释放（使用 try..finally）
- 使用 Free 而不是 Destroy 释放对象
- 检查对象是否为 nil 再释放
- 避免内存泄漏，及时释放资源

## 单元和依赖
- uses 子句按字母顺序排列
- 避免循环依赖
- 将常用的类型和函数放在 Common 单元
- 使用条件编译处理不同版本差异

## 注释规范
- 使用 { } 或 (* *) 进行块注释
- 使用 // 进行行注释
- 为公共接口添加注释说明
- 复杂算法必须添加注释
- 使用中文注释说明业务逻辑

## Delphi 2007 特定规则
- 注意 AnsiString 和 WideString 的区别
- 使用 TStringList 处理字符串列表
- 注意 Unicode 编码问题（Delphi 2007 使用 ANSI）
- 使用 TFileStream 进行文件操作
- 注意组件和控件的生命周期管理

# 项目特定规则（mir2-applem2）
- 这是一个 Delphi 2007 项目（mir2-applem2）
- 注意处理中文编码问题（使用 AnsiString）
- 保持与现有代码风格一致
- GameOfMir\Common\Grobal2.pas 中的 Var_Interface 设置很重要，修改前需谨慎
- 第三方库位于 demmrfm 目录，不要修改这些文件
- 编译前确保所有库依赖已正确添加到 Library path
- 注意区分 mir2 和 default 两个版本的代码差异

# Delphi 编程模式和最佳实践

## 对象创建和销毁
- 使用构造函数 Create 创建对象
- 使用析构函数 Destroy（通过 Free 调用）
- 在 try..finally 块中确保对象释放
- 示例：
  ```pascal
  var
    Obj: TMyObject;
  begin
    Obj := TMyObject.Create;
    try
      // 使用对象
    finally
      Obj.Free;
    end;
  end;
  ```

## 字符串处理
- 使用 AnsiString 类型（Delphi 2007 默认）
- 使用 StringReplace、Pos、Copy 等字符串函数
- 注意字符串索引从 1 开始
- 使用 Format 函数格式化字符串输出

## 集合和枚举
- 使用枚举类型定义常量集合
- 使用集合类型（set of）进行多选操作
- 使用 in 操作符检查集合成员

## 文件操作
- 使用 TFileStream 进行文件读写
- 使用 TStringList 读写文本文件
- 使用 FileExists 检查文件是否存在
- 注意文件路径使用反斜杠（Windows）

## 组件使用
- 窗体组件在 DFM 文件中定义
- 运行时创建的组件必须手动释放
- 注意组件的 Owner 属性
- 事件处理程序命名规范：组件名+事件名（如：Button1Click）

# 文件操作规则
- 不要修改第三方库文件（demmrfm 目录下的文件）
- 修改代码前先检查相关依赖
- 修改 .pas 文件时注意对应的 .dfm 文件
- 备份重要文件后再进行修改

# 响应规则
- 使用中文回复用户
- 提供清晰的代码说明和注释
