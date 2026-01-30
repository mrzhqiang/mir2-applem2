unit DbToSqlite;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, SQLiteAdapter, SQLiteTable3, HumDB,
  OldMirDB, Grobal2, DBShare, HUtil32, Common;

type
  TFrmDbToSqlite = class(TForm)
    Panel1: TPanel;
    BtnSelectHumDB: TButton;
    BtnSelectMirDB: TButton;
    BtnSelectSqlite: TButton;
    BtnMigrate: TButton;
    BtnClose: TButton;
    EdtHumDB: TEdit;
    EdtMirDB: TEdit;
    EdtSqlite: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MemoLog: TMemo;
    ProgressBar: TProgressBar;
    procedure BtnSelectHumDBClick(Sender: TObject);
    procedure BtnSelectMirDBClick(Sender: TObject);
    procedure BtnSelectSqliteClick(Sender: TObject);
    procedure BtnMigrateClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FHumDB: TFileHumDB;
    FHumDataDB: TFileDB;
    FSqliteAdapter: TSQLiteAdapter;
    
    function CreateSqliteSchema: Boolean;
    function MigrateHumDB: Boolean;
    function MigrateHumDataDB: Boolean;
    procedure Log(const Msg: string);
  public
    { Public declarations }
  end;

var
  FrmDbToSqlite: TFrmDbToSqlite;

implementation

uses Dialogs;

{$R *.dfm}

// 将 Stream 转换为十六进制字符串（用于 SQLite BLOB）
function StreamToHex(Stream: TMemoryStream): string;
const
  HexChars: array[0..15] of Char = ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');
var
  i: Integer;
  Bytes: PByte;
begin
  Result := '';
  if Stream.Size = 0 then
    Exit;
  Bytes := Stream.Memory;
  SetLength(Result, Stream.Size * 2);
  for i := 0 to Stream.Size - 1 do begin
    Result[i * 2 + 1] := HexChars[(Bytes[i] shr 4) and $0F];
    Result[i * 2 + 2] := HexChars[Bytes[i] and $0F];
  end;
end;

procedure TFrmDbToSqlite.FormCreate(Sender: TObject);
begin
  FHumDB := nil;
  FHumDataDB := nil;
  FSqliteAdapter := nil;
  EdtSqlite.Text := '.\DB\game.sqlite';
end;

procedure TFrmDbToSqlite.BtnSelectHumDBClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(Self);
  try
    OpenDialog.Filter := '数据库文件|*.DB|所有文件|*.*';
    OpenDialog.Title := '选择 Hum.DB 文件';
    if OpenDialog.Execute then
      EdtHumDB.Text := OpenDialog.FileName;
  finally
    OpenDialog.Free;
  end;
end;

procedure TFrmDbToSqlite.BtnSelectMirDBClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(Self);
  try
    OpenDialog.Filter := '数据库文件|*.DB|所有文件|*.*';
    OpenDialog.Title := '选择 Mir.DB 文件';
    if OpenDialog.Execute then
      EdtMirDB.Text := OpenDialog.FileName;
  finally
    OpenDialog.Free;
  end;
end;

procedure TFrmDbToSqlite.BtnSelectSqliteClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(Self);
  try
    SaveDialog.Filter := 'SQLite数据库|*.sqlite|所有文件|*.*';
    SaveDialog.Title := '选择或创建 SQLite 数据库文件';
    SaveDialog.DefaultExt := 'sqlite';
    if SaveDialog.Execute then
      EdtSqlite.Text := SaveDialog.FileName;
  finally
    SaveDialog.Free;
  end;
end;

procedure TFrmDbToSqlite.Log(const Msg: string);
begin
  MemoLog.Lines.Add(FormatDateTime('hh:nn:ss', Now) + ' - ' + Msg);
  Application.ProcessMessages;
end;

function TFrmDbToSqlite.CreateSqliteSchema: Boolean;
var
  SchemaSQL: TStringList;
  SQL: string;
begin
  Result := False;
  try
    Log('正在创建 SQLite 数据库结构...');
    
    // 读取 Schema SQL 文件
    SchemaSQL := TStringList.Create;
    try
      if FileExists('.\SQL\sqlite_schema.sql') then
        SchemaSQL.LoadFromFile('.\SQL\sqlite_schema.sql')
      else if FileExists('..\SQL\sqlite_schema.sql') then
        SchemaSQL.LoadFromFile('..\SQL\sqlite_schema.sql')
      else begin
        Log('错误: 找不到 sqlite_schema.sql 文件');
        Exit;
      end;
      
      // 执行 SQL 语句
      for SQL in SchemaSQL do begin
        SQL := Trim(SQL);
        if (SQL <> '') and (SQL[1] <> '-') then begin
          try
            FSqliteAdapter.ExecSQL(SQL);
          except
            on E: Exception do begin
              // 忽略已存在的表错误
              if Pos('already exists', LowerCase(E.Message)) = 0 then
                Log('警告: ' + E.Message);
            end;
          end;
        end;
      end;
    finally
      SchemaSQL.Free;
    end;
    
    Log('SQLite 数据库结构创建完成');
    Result := True;
  except
    on E: Exception do begin
      Log('错误: 创建数据库结构失败 - ' + E.Message);
      Result := False;
    end;
  end;
end;

function TFrmDbToSqlite.MigrateHumDB: Boolean;
var
  i, Count: Integer;
  HumInfo: THumInfo;
  SQL: string;
  SuccessCount, FailCount: Integer;
begin
  Result := False;
  SuccessCount := 0;
  FailCount := 0;
  
  try
    Log('开始迁移 Hum.DB...');
    
    if not FileExists(EdtHumDB.Text) then begin
      Log('错误: Hum.DB 文件不存在');
      Exit;
    end;
    
    FHumDB := TFileHumDB.Create(EdtHumDB.Text);
    try
      if not FHumDB.Open then begin
        Log('错误: 无法打开 Hum.DB 文件');
        Exit;
      end;
      
      Count := FHumDB.Count;
      Log(Format('找到 %d 条角色记录', [Count]));
      
      ProgressBar.Max := Count;
      ProgressBar.Position := 0;
      
      FSqliteAdapter.BeginTransaction;
      try
        for i := 0 to Count - 1 do begin
          if FHumDB.Get(i, HumInfo) = 0 then begin
            try
              SQL := Format(
                'INSERT OR REPLACE INTO hum_info (chr_name, account, deleted, gm_deleted, selected, mod_date, count) ' +
                'VALUES (''%s'', ''%s'', %d, %d, %d, ''%s'', %d)',
                [
                  StringReplace(HumInfo.sChrName, '''', '''''', [rfReplaceAll]),
                  StringReplace(HumInfo.sAccount, '''', '''''', [rfReplaceAll]),
                  Ord(HumInfo.boDeleted),
                  Ord(HumInfo.boGMDeleted),
                  Ord(HumInfo.boSelected),
                  FormatDateTime('yyyy-mm-dd hh:nn:ss', HumInfo.dModDate),
                  HumInfo.btCount
                ]
              );
              
              FSqliteAdapter.ExecSQL(SQL);
              Inc(SuccessCount);
            except
              on E: Exception do begin
                Inc(FailCount);
                Log(Format('迁移角色 %s 失败: %s', [HumInfo.sChrName, E.Message]));
              end;
            end;
          end;
          
          ProgressBar.Position := i + 1;
          if (i mod 100) = 0 then
            Application.ProcessMessages;
        end;
        
        FSqliteAdapter.Commit;
      except
        FSqliteAdapter.Rollback;
        raise;
      end;
      
      Log(Format('Hum.DB 迁移完成: 成功 %d 条, 失败 %d 条', [SuccessCount, FailCount]));
      Result := True;
    finally
      FHumDB.Close;
      FHumDB.Free;
      FHumDB := nil;
    end;
  except
    on E: Exception do begin
      Log('错误: 迁移 Hum.DB 失败 - ' + E.Message);
      Result := False;
    end;
  end;
end;

function TFrmDbToSqlite.MigrateHumDataDB: Boolean;
var
  i, Count: Integer;
  HumDataInfo: THumDataInfo;
  SQL: string;
  SuccessCount, FailCount: Integer;
  BlobData: TMemoryStream;
  ChrName, Account: string;
begin
  Result := False;
  SuccessCount := 0;
  FailCount := 0;
  
  try
    Log('开始迁移 Mir.DB...');
    
    if not FileExists(EdtMirDB.Text) then begin
      Log('警告: Mir.DB 文件不存在，跳过');
      Result := True;
      Exit;
    end;
    
    FHumDataDB := TFileDB.Create(EdtMirDB.Text);
    try
      if not FHumDataDB.Open then begin
        Log('错误: 无法打开 Mir.DB 文件');
        Exit;
      end;
      
      Count := FHumDataDB.Count;
      Log(Format('找到 %d 条角色数据记录', [Count]));
      
      ProgressBar.Max := Count;
      ProgressBar.Position := 0;
      
      BlobData := TMemoryStream.Create;
      try
        FSqliteAdapter.BeginTransaction;
        try
          for i := 0 to Count - 1 do begin
            if FHumDataDB.Get(i, HumDataInfo) = 0 then begin
              try
                // 获取角色名和账号
                ChrName := Trim(HumDataInfo.Data.sChrName);
                Account := Trim(HumDataInfo.Data.sAccount);
                
                if ChrName = '' then begin
                  Inc(FailCount);
                  Log(Format('跳过空角色名记录 (索引 %d)', [i]));
                  Continue;
                end;
                
                // 将完整的 THumDataInfo 序列化为 BLOB
                BlobData.Clear;
                BlobData.Write(HumDataInfo, SizeOf(THumDataInfo));
                BlobData.Position := 0;
                
                // 使用参数化查询插入 BLOB（更高效）
                // 先删除旧记录（如果存在）
                SQL := Format(
                  'DELETE FROM hum_data WHERE chr_name = ''%s''',
                  [StringReplace(ChrName, '''', '''''', [rfReplaceAll])]
                );
                FSqliteAdapter.ExecSQL(SQL);
                
                // 使用十六进制字符串插入 BLOB（SQLite 支持 X'hex' 格式）
                SQL := Format(
                  'INSERT INTO hum_data (chr_name, account, data_blob, data_size, updated_at) ' +
                  'VALUES (''%s'', ''%s'', X''%s'', %d, julianday(''now''))',
                  [
                    StringReplace(ChrName, '''', '''''', [rfReplaceAll]),
                    StringReplace(Account, '''', '''''', [rfReplaceAll]),
                    StreamToHex(BlobData),
                    BlobData.Size
                  ]
                );
                
                FSqliteAdapter.ExecSQL(SQL);
                Inc(SuccessCount);
                
                if (SuccessCount mod 100) = 0 then
                  Log(Format('已迁移 %d 条记录...', [SuccessCount]));
              except
                on E: Exception do begin
                  Inc(FailCount);
                  Log(Format('迁移角色数据 %s 失败: %s', [ChrName, E.Message]));
                end;
              end;
            end;
            
            ProgressBar.Position := i + 1;
            if (i mod 100) = 0 then
              Application.ProcessMessages;
          end;
          
          FSqliteAdapter.Commit;
        except
          FSqliteAdapter.Rollback;
          raise;
        end;
      finally
        BlobData.Free;
      end;
      
      Log(Format('Mir.DB 迁移完成: 成功 %d 条, 失败 %d 条', [SuccessCount, FailCount]));
      Result := True;
    finally
      FHumDataDB.Close;
      FHumDataDB.Free;
      FHumDataDB := nil;
    end;
  except
    on E: Exception do begin
      Log('错误: 迁移 Mir.DB 失败 - ' + E.Message);
      Result := False;
    end;
  end;
end;

procedure TFrmDbToSqlite.BtnMigrateClick(Sender: TObject);
var
  SqlitePath: string;
begin
  if Trim(EdtHumDB.Text) = '' then begin
    ShowMessage('请选择 Hum.DB 文件');
    Exit;
  end;
  
  if Trim(EdtSqlite.Text) = '' then begin
    ShowMessage('请选择 SQLite 数据库文件');
    Exit;
  end;
  
  SqlitePath := EdtSqlite.Text;
  
  // 确保目录存在
  if not DirectoryExists(ExtractFilePath(SqlitePath)) then
    ForceDirectories(ExtractFilePath(SqlitePath));
  
  try
    BtnMigrate.Enabled := False;
    MemoLog.Clear;
    ProgressBar.Position := 0;
    
    // 创建 SQLite 适配器
    FSqliteAdapter := TSQLiteAdapter.Create;
    try
      if not FSqliteAdapter.Open(SqlitePath) then begin
        Log('错误: 无法打开 SQLite 数据库');
        Exit;
      end;
      
      // 创建 Schema
      if not CreateSqliteSchema then begin
        Log('错误: 创建数据库结构失败');
        Exit;
      end;
      
      // 迁移 Hum.DB
      if not MigrateHumDB then begin
        Log('错误: 迁移 Hum.DB 失败');
        Exit;
      end;
      
      // 迁移 Mir.DB
      if not MigrateHumDataDB then begin
        Log('错误: 迁移 Mir.DB 失败');
        Exit;
      end;
      
      Log('迁移完成！');
      ShowMessage('数据库迁移完成！');
    finally
      FSqliteAdapter.Close;
      FSqliteAdapter.Free;
      FSqliteAdapter := nil;
    end;
  finally
    BtnMigrate.Enabled := True;
  end;
end;

procedure TFrmDbToSqlite.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

end.

