# 安全规则

## 输入验证
- 所有用户输入必须验证
- 检查字符串长度和格式
- 验证数值范围
- 过滤危险字符和 SQL 注入代码
- 示例：
  ```pascal
  // 验证用户名
  if (Length(UserName) < 3) or (Length(UserName) > 20) then
    raise Exception.Create('用户名长度必须在3-20字符之间');
  
  // 验证是否包含非法字符
  if Pos('''', UserName) > 0 then
    raise Exception.Create('用户名包含非法字符');
  ```

## SQL 注入防护
- 使用参数化查询，不要拼接 SQL 字符串
- 验证所有数据库输入
- 使用存储过程处理敏感操作
- 示例：
  ```pascal
  // 错误：容易 SQL 注入
  SQL := Format('SELECT * FROM Users WHERE Name=''%s''', [UserName]);
  
  // 正确：使用参数
  SQL := 'SELECT * FROM Users WHERE Name=:Name';
  Query.ParamByName('Name').AsString := UserName;
  ```

## 密码安全
- 密码不能明文存储
- 使用哈希算法（如 MD5、SHA）存储密码
- 添加盐值（Salt）增强安全性
- 密码传输使用加密通道
- 实现密码强度验证

## 文件操作安全
- 验证文件路径，防止路径遍历攻击
- 检查文件扩展名和类型
- 限制文件大小
- 验证文件权限
- 示例：
  ```pascal
  // 检查路径是否安全
  if Pos('..', FilePath) > 0 then
    raise Exception.Create('非法文件路径');
  ```

## 网络通信安全
- 验证数据包来源和完整性
- 使用加密传输敏感数据
- 实现防重放攻击机制
- 限制连接频率防止暴力破解
- 验证客户端版本和合法性

## 权限控制
- 实现基于角色的访问控制（RBAC）
- 验证用户权限后再执行操作
- 记录敏感操作的审计日志
- 限制管理员操作范围

## 错误处理
- 不要向用户暴露系统内部信息
- 记录详细错误日志供管理员查看
- 返回友好的错误提示给用户
- 避免信息泄露

## 代码安全
- 不要硬编码密码和密钥
- 敏感配置使用配置文件或环境变量
- 定期更新依赖库修复安全漏洞
- 代码审查时关注安全问题
