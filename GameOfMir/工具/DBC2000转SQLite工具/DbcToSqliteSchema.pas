unit DbcToSqliteSchema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, DBTables, DB, ShlObj, ActiveX, SQLiteTable3, SQLite3;

type
  TFieldInfo = record
    FieldName: string;
    FieldType: TFieldType;
    Size: Integer;
    Required: Boolean;
    DefaultValue: string;
  end;
  PFieldInfo = ^TFieldInfo;

  TTableInfo = class
    TableName: string;
    Fields: TList;
    PrimaryKeys: TStringList;
    Indexes: TStringList;
    constructor Create;
    destructor Destroy; override;
  end;

  TFrmDbcToSqlite = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    EdtDatabasePath: TEdit;
    BtnSelectDatabase: TButton;
    Label2: TLabel;
    EdtSqlitePath: TEdit;
    BtnSelectSqlite: TButton;
    BtnExport: TButton;
    BtnClose: TButton;
    MemoLog: TMemo;
    ProgressBar: TProgressBar;
    CheckBoxExportData: TCheckBox;
    CheckBoxExportSchema: TCheckBox;
    Label3: TLabel;
    ListBoxTables: TListBox;
    BtnRefreshTables: TButton;
    procedure BtnSelectDatabaseClick(Sender: TObject);
    procedure BtnSelectSqliteClick(Sender: TObject);
    procedure BtnExportClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnRefreshTablesClick(Sender: TObject);
  private
    FDatabase: TDatabase;
    FSqliteDB: TSQLiteDatabase;
    FTables: TList;
    
    function ConnectDatabase: Boolean;
    procedure DisconnectDatabase;
    function GetTableList: Boolean;
    function GetTableSchema(const TableName: string): TTableInfo;
    function ConvertFieldType(FieldType: TFieldType; Size: Integer): string;
    function GenerateCreateTableSQL(TableInfo: TTableInfo): string;
    function GenerateCreateIndexSQL(TableInfo: TTableInfo): string;
    function ExportTableSchema(TableInfo: TTableInfo): Boolean;
    function ExportTableData(const TableName: string): Boolean;
    function QuoteIdentifier(const Name: string): string;
    procedure Log(const Msg: string);
    procedure ClearTables;
  public
    { Public declarations }
  end;

var
  FrmDbcToSqlite: TFrmDbcToSqlite;

implementation

{$R *.dfm}

// Windows Shell API 函数声明
function ShBrowseForFolder(var lpbi: TBrowseInfo): PItemIDList; stdcall; external 'shell32.dll' name 'SHBrowseForFolderA';
function ShGetPathFromIDList(pidl: PItemIDList; pszPath: PChar): BOOL; stdcall; external 'shell32.dll' name 'SHGetPathFromIDListA';
function ShGetMalloc(out ppMalloc: IMalloc): HResult; stdcall; external 'shell32.dll' name 'SHGetMalloc';

const
  BIF_RETURNONLYFSDIRS = $0001;
  BIF_NEWDIALOGSTYLE = $0040;

// 辅助函数：将 ANSI/GBK 字符串转换为 UTF-8
function AnsiToUTF8(const S: string): string;
var
  WS: WideString;
  UTF8Str: UTF8String;
begin
  // 先将 ANSI 字符串转换为 WideString（Unicode）
  WS := S;
  // 再将 WideString 转换为 UTF-8
  UTF8Str := UTF8Encode(WS);
  Result := string(UTF8Str);
end;

{ TTableInfo }

constructor TTableInfo.Create;
begin
  inherited;
  Fields := TList.Create;
  PrimaryKeys := TStringList.Create;
  Indexes := TStringList.Create;
end;

destructor TTableInfo.Destroy;
var
  i: Integer;
begin
  for i := 0 to Fields.Count - 1 do
    Dispose(PFieldInfo(Fields[i]));
  Fields.Free;
  PrimaryKeys.Free;
  Indexes.Free;
  inherited;
end;

{ TFrmDbcToSqlite }

procedure TFrmDbcToSqlite.FormCreate(Sender: TObject);
begin
  FDatabase := nil;
  FSqliteDB := nil;
  FTables := TList.Create;
  // 默认设置为当前目录
  EdtDatabasePath.Text := GetCurrentDir;
  EdtSqlitePath.Text := '.\mir2.sqlite';
  CheckBoxExportSchema.Checked := True;
  CheckBoxExportData.Checked := False;
end;

procedure TFrmDbcToSqlite.BtnSelectDatabaseClick(Sender: TObject);
var
  BrowseInfo: TBrowseInfo;
  Buffer: array[0..MAX_PATH] of Char;
  ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  SelectedDir: string;
begin
  SelectedDir := EdtDatabasePath.Text;
  if not DirectoryExists(SelectedDir) then
    SelectedDir := GetCurrentDir;
  
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  BrowseInfo.hwndOwner := Handle;
  BrowseInfo.pszDisplayName := Buffer;
  BrowseInfo.lpszTitle := PChar('选择 DBC2000 数据库目录');
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS or BIF_NEWDIALOGSTYLE;
  
  if ShGetMalloc(ShellMalloc) = S_OK then begin
    ItemIDList := ShBrowseForFolder(BrowseInfo);
    if ItemIDList <> nil then begin
      if ShGetPathFromIDList(ItemIDList, Buffer) then begin
        SelectedDir := Buffer;
        EdtDatabasePath.Text := SelectedDir;
      end;
      ShellMalloc.Free(ItemIDList);
    end;
  end;
end;

procedure TFrmDbcToSqlite.BtnSelectSqliteClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(Self);
  try
    SaveDialog.Filter := 'SQLite数据库|*.sqlite|所有文件|*.*';
    SaveDialog.Title := '选择或创建 SQLite 数据库文件';
    SaveDialog.DefaultExt := 'sqlite';
    if SaveDialog.Execute then
      EdtSqlitePath.Text := SaveDialog.FileName;
  finally
    SaveDialog.Free;
  end;
end;

procedure TFrmDbcToSqlite.BtnRefreshTablesClick(Sender: TObject);
begin
  if not ConnectDatabase then
    Exit;
    
  if GetTableList then begin
    Log(Format('找到 %d 个表', [ListBoxTables.Items.Count]));
  end;
end;

function TFrmDbcToSqlite.ConnectDatabase: Boolean;
var
  DbPath: string;
begin
  Result := False;
  DisconnectDatabase;
  
  DbPath := Trim(EdtDatabasePath.Text);
  if (DbPath = '') or not DirectoryExists(DbPath) then begin
    Log('错误: 数据库目录不存在');
    Exit;
  end;
  
  try
    FDatabase := TDatabase.Create(Self);
    FDatabase.DatabaseName := 'DBC2000_TEMP';
    FDatabase.DriverName := 'STANDARD';
    FDatabase.Params.Clear;
    FDatabase.Params.Add('PATH=' + DbPath);
    FDatabase.LoginPrompt := False;
    FDatabase.Connected := True;
    
    Log('成功连接到数据库: ' + DbPath);
    Result := True;
  except
    on E: Exception do begin
      Log('连接数据库失败: ' + E.Message);
      DisconnectDatabase;
    end;
  end;
end;

procedure TFrmDbcToSqlite.DisconnectDatabase;
begin
  if FDatabase <> nil then begin
    try
      if FDatabase.Connected then
        FDatabase.Connected := False;
    except
    end;
    FDatabase.Free;
    FDatabase := nil;
  end;
end;

function TFrmDbcToSqlite.GetTableList: Boolean;
var
  TableList: TStringList;
begin
  Result := False;
  ListBoxTables.Items.Clear;
  
  if not Assigned(FDatabase) or not FDatabase.Connected then begin
    Log('错误: 数据库未连接');
    Exit;
  end;
  
  try
    TableList := TStringList.Create;
    try
      FDatabase.Session.GetTableNames(FDatabase.DatabaseName, '*.*', False, False, TableList);
      ListBoxTables.Items.Assign(TableList);
      Result := True;
    finally
      TableList.Free;
    end;
  except
    on E: Exception do begin
      Log('获取表列表失败: ' + E.Message);
    end;
  end;
end;

function TFrmDbcToSqlite.GetTableSchema(const TableName: string): TTableInfo;
var
  Table: TTable;
  i: Integer;
  FieldInfo: PFieldInfo;
  IndexDef: TIndexDef;
begin
  Result := TTableInfo.Create;
  Result.TableName := TableName;
  
  if not Assigned(FDatabase) or not FDatabase.Connected then
    Exit;
  
  Table := TTable.Create(Self);
  try
    Table.DatabaseName := FDatabase.DatabaseName;
    Table.TableName := TableName;
    Table.Open;
    
    // 获取字段信息
    for i := 0 to Table.FieldCount - 1 do begin
      New(FieldInfo);
      FieldInfo.FieldName := Table.Fields[i].FieldName;
      FieldInfo.FieldType := Table.Fields[i].DataType;
      FieldInfo.Size := Table.Fields[i].Size;
      FieldInfo.Required := Table.Fields[i].Required;
      if Table.Fields[i].DefaultExpression <> '' then
        FieldInfo.DefaultValue := Table.Fields[i].DefaultExpression
      else
        FieldInfo.DefaultValue := '';
      Result.Fields.Add(FieldInfo);
    end;
    
    // 获取主键信息
    for i := 0 to Table.IndexDefs.Count - 1 do begin
      IndexDef := Table.IndexDefs[i];
      if ixPrimary in IndexDef.Options then begin
        Result.PrimaryKeys.Add(IndexDef.Fields);
      end else if not (ixExpression in IndexDef.Options) and (IndexDef.Fields <> '') then begin
        if IndexDef.Name <> '' then
          Result.Indexes.Add(Format('%s=%s', [IndexDef.Name, IndexDef.Fields]))
        else
          Result.Indexes.Add(Format('idx_%s_%d=%s', [TableName, i, IndexDef.Fields]));
      end;
    end;
    
    Table.Close;
  finally
    Table.Free;
  end;
end;

function TFrmDbcToSqlite.ConvertFieldType(FieldType: TFieldType; Size: Integer): string;
begin
  case FieldType of
    ftString, ftFixedChar, ftWideString:
      if Size > 0 then
        Result := Format('TEXT(%d)', [Size])
      else
        Result := 'TEXT';
    ftSmallint, ftInteger, ftWord, ftAutoInc:
      Result := 'INTEGER';
    ftLargeint:
      Result := 'INTEGER';
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      Result := 'REAL';
    ftBoolean:
      Result := 'INTEGER';
    ftDate, ftTime, ftDateTime, ftTimeStamp:
      Result := 'REAL';
    ftMemo, ftWideMemo, ftBlob, ftGraphic, ftOraBlob, ftOraClob:
      Result := 'BLOB';
    else
      Result := 'TEXT';
  end;
end;

function TFrmDbcToSqlite.QuoteIdentifier(const Name: string): string;
begin
  // SQLite 使用方括号或双引号来引用标识符
  Result := '[' + StringReplace(Name, ']', ']]', [rfReplaceAll]) + ']';
end;

function TFrmDbcToSqlite.GenerateCreateTableSQL(TableInfo: TTableInfo): string;
var
  i, j: Integer;
  FieldInfo: PFieldInfo;
  SQL: TStringList;
  FieldDefs: string;
  PrimaryKeyDef: string;
  SafeTableName, SafeFieldName: string;
begin
  SQL := TStringList.Create;
  try
    SafeTableName := QuoteIdentifier(TableInfo.TableName);
    SQL.Add(Format('CREATE TABLE IF NOT EXISTS %s (', [SafeTableName]));
    
    FieldDefs := '';
    for i := 0 to TableInfo.Fields.Count - 1 do begin
      FieldInfo := PFieldInfo(TableInfo.Fields[i]);
      if FieldDefs <> '' then
        FieldDefs := FieldDefs + ',' + #13#10 + '    ';
      
      SafeFieldName := QuoteIdentifier(FieldInfo.FieldName);
      FieldDefs := FieldDefs + Format('%s %s', 
        [SafeFieldName, ConvertFieldType(FieldInfo.FieldType, FieldInfo.Size)]);
      
      if FieldInfo.Required then
        FieldDefs := FieldDefs + ' NOT NULL';
      
      if FieldInfo.DefaultValue <> '' then begin
        // 默认值如果是字符串，需要加引号；如果是数字，直接使用
        if (FieldInfo.FieldType = ftString) or (FieldInfo.FieldType = ftMemo) or 
           (FieldInfo.FieldType = ftWideString) or (FieldInfo.FieldType = ftFixedChar) then
          FieldDefs := FieldDefs + Format(' DEFAULT ''%s''', 
            [StringReplace(FieldInfo.DefaultValue, '''', '''''', [rfReplaceAll])])
        else
          FieldDefs := FieldDefs + Format(' DEFAULT %s', [FieldInfo.DefaultValue]);
      end;
    end;
    
    // 添加主键定义
    if TableInfo.PrimaryKeys.Count > 0 then begin
      PrimaryKeyDef := '';
      for j := 0 to TableInfo.PrimaryKeys.Count - 1 do begin
        if PrimaryKeyDef <> '' then
          PrimaryKeyDef := PrimaryKeyDef + ', ';
        PrimaryKeyDef := PrimaryKeyDef + QuoteIdentifier(TableInfo.PrimaryKeys[j]);
      end;
      FieldDefs := FieldDefs + ',' + #13#10 + '    PRIMARY KEY (' + PrimaryKeyDef + ')';
    end;
    
    SQL.Add('    ' + FieldDefs);
    SQL.Add(');');
    
    Result := SQL.Text;
  finally
    SQL.Free;
  end;
end;

function TFrmDbcToSqlite.GenerateCreateIndexSQL(TableInfo: TTableInfo): string;
var
  i: Integer;
  IndexName, IndexFields: string;
  SQL: TStringList;
  FieldList: TStringList;
  j: Integer;
begin
  SQL := TStringList.Create;
  FieldList := TStringList.Create;
  try
    for i := 0 to TableInfo.Indexes.Count - 1 do begin
      IndexName := TableInfo.Indexes.Names[i];
      IndexFields := TableInfo.Indexes.ValueFromIndex[i];
      if IndexName = '' then
        IndexName := Format('idx_%s_%d', [TableInfo.TableName, i]);
      
      if IndexFields <> '' then begin
        // 解析字段列表并添加引号
        FieldList.Clear;
        FieldList.Delimiter := ',';
        FieldList.DelimitedText := IndexFields;
        IndexFields := '';
        for j := 0 to FieldList.Count - 1 do begin
          if IndexFields <> '' then
            IndexFields := IndexFields + ', ';
          IndexFields := IndexFields + QuoteIdentifier(Trim(FieldList[j]));
        end;
        
        SQL.Add(Format('CREATE INDEX IF NOT EXISTS %s ON %s (%s);',
          [QuoteIdentifier(IndexName), QuoteIdentifier(TableInfo.TableName), IndexFields]));
      end;
    end;
    Result := SQL.Text;
  finally
    FieldList.Free;
    SQL.Free;
  end;
end;

function TFrmDbcToSqlite.ExportTableSchema(TableInfo: TTableInfo): Boolean;
var
  CreateSQL, IndexSQL: string;
begin
  Result := False;
  try
    CreateSQL := GenerateCreateTableSQL(TableInfo);
    IndexSQL := GenerateCreateIndexSQL(TableInfo);
    
    // 记录生成的 SQL（用于调试）
    Log(Format('创建表 %s 的 SQL:', [TableInfo.TableName]));
    Log(CreateSQL);
    
    // 执行创建表语句
    try
      FSqliteDB.ExecSQL(CreateSQL);
    except
      on E: Exception do begin
        Log(Format('执行 CREATE TABLE 失败: %s', [E.Message]));
        Log('SQL 语句:');
        Log(CreateSQL);
        raise;
      end;
    end;
    
    // 执行创建索引语句
    if IndexSQL <> '' then begin
      try
        FSqliteDB.ExecSQL(IndexSQL);
      except
        on E: Exception do begin
          Log(Format('执行 CREATE INDEX 失败: %s', [E.Message]));
          Log('SQL 语句:');
          Log(IndexSQL);
          // 索引创建失败不影响表创建，只记录警告
        end;
      end;
    end;
    
    Log(Format('已导出表结构: %s', [TableInfo.TableName]));
    Result := True;
  except
    on E: Exception do begin
      Log(Format('导出表结构失败 %s: %s', [TableInfo.TableName, E.Message]));
      Log('请检查表名和字段名是否包含特殊字符');
    end;
  end;
end;

function TFrmDbcToSqlite.ExportTableData(const TableName: string): Boolean;
var
  Table: TTable;
  i: Integer;
  FieldNames, FieldValues: string;
  SQL: string;
  TotalRecords, ProcessedRecords: Integer;
  BlobStream: TMemoryStream;
  HexStr: string;
  AnsiHexStr: AnsiString;
begin
  Result := False;
  ProcessedRecords := 0;
  
  if not Assigned(FDatabase) or not FDatabase.Connected then
    Exit;
  
  Table := TTable.Create(Self);
  try
    Table.DatabaseName := FDatabase.DatabaseName;
    Table.TableName := TableName;
    Table.Open;
    
    TotalRecords := Table.RecordCount;
    ProgressBar.Max := TotalRecords;
    ProgressBar.Position := 0;
    
    FSqliteDB.BeginTransaction;
    try
      // 构建字段名列表（字段名也需要转换为 UTF-8 并使用引号）
      FieldNames := '';
      for i := 0 to Table.FieldCount - 1 do begin
        if FieldNames <> '' then
          FieldNames := FieldNames + ', ';
        FieldNames := FieldNames + QuoteIdentifier(AnsiToUTF8(Table.Fields[i].FieldName));
      end;
      
      Table.First;
      while not Table.Eof do begin
        // 构建值列表
        FieldValues := '';
        for i := 0 to Table.FieldCount - 1 do begin
          if FieldValues <> '' then
            FieldValues := FieldValues + ', ';
          
          if Table.Fields[i].IsNull then
            FieldValues := FieldValues + 'NULL'
          else begin
            case Table.Fields[i].DataType of
              ftString, ftFixedChar, ftWideString, ftMemo, ftWideMemo:
                begin
                  // 将 ANSI/GBK 编码的字符串转换为 UTF-8
                  FieldValues := FieldValues + '''' + 
                    StringReplace(AnsiToUTF8(Table.Fields[i].AsString), '''', '''''', [rfReplaceAll]) + '''';
                end;
              ftInteger, ftSmallint, ftWord, ftAutoInc, ftLargeint:
                FieldValues := FieldValues + IntToStr(Table.Fields[i].AsInteger);
              ftFloat, ftCurrency, ftBCD, ftFMTBcd:
                FieldValues := FieldValues + FloatToStr(Table.Fields[i].AsFloat);
              ftBoolean:
                FieldValues := FieldValues + IntToStr(Ord(Table.Fields[i].AsBoolean));
              ftDate, ftTime, ftDateTime, ftTimeStamp:
                FieldValues := FieldValues + Format('julianday(''%s'')', 
                  [FormatDateTime('yyyy-mm-dd hh:nn:ss', Table.Fields[i].AsDateTime)]);
              ftBlob, ftGraphic:
                begin
                  // 将 BLOB 转换为十六进制字符串
                  BlobStream := TMemoryStream.Create;
                  try
                    TBlobField(Table.Fields[i]).SaveToStream(BlobStream);
                    BlobStream.Position := 0;
                    SetLength(AnsiHexStr, BlobStream.Size * 2);
                    BinToHex(BlobStream.Memory, PAnsiChar(AnsiHexStr), BlobStream.Size);
                    HexStr := string(AnsiHexStr);
                    FieldValues := FieldValues + 'X''' + HexStr + '''';
                  finally
                    BlobStream.Free;
                  end;
                end;
              else
                begin
                  // 对于其他字符串类型，也转换为 UTF-8
                  FieldValues := FieldValues + '''' + 
                    StringReplace(AnsiToUTF8(Table.Fields[i].AsString), '''', '''''', [rfReplaceAll]) + '''';
                end;
            end;
          end;
        end;
        
        SQL := Format('INSERT INTO %s (%s) VALUES (%s)', 
          [TableName, FieldNames, FieldValues]);
        
        try
          FSqliteDB.ExecSQL(SQL);
          Inc(ProcessedRecords);
        except
          on E: Exception do
            Log(Format('插入数据失败: %s', [E.Message]));
        end;
        
        ProgressBar.Position := ProgressBar.Position + 1;
        Table.Next;
        
        if (ProcessedRecords mod 100) = 0 then
          Application.ProcessMessages;
      end;
      
      FSqliteDB.Commit;
      Log(Format('已导出 %d 条数据: %s', [ProcessedRecords, TableName]));
      Result := True;
    except
      FSqliteDB.Rollback;
      raise;
    end;
  finally
    Table.Close;
    Table.Free;
  end;
end;

procedure TFrmDbcToSqlite.Log(const Msg: string);
begin
  MemoLog.Lines.Add(FormatDateTime('hh:nn:ss', Now) + ' - ' + Msg);
  Application.ProcessMessages;
end;

procedure TFrmDbcToSqlite.ClearTables;
var
  i: Integer;
begin
  for i := 0 to FTables.Count - 1 do
    TTableInfo(FTables[i]).Free;
  FTables.Clear;
end;

procedure TFrmDbcToSqlite.BtnExportClick(Sender: TObject);
var
  i: Integer;
  TableInfo: TTableInfo;
  SqlitePath: string;
  SelectedTables: TStringList;
begin
  if Trim(EdtDatabasePath.Text) = '' then begin
    ShowMessage('请选择 DBC2000 数据库目录');
    Exit;
  end;
  
  if Trim(EdtSqlitePath.Text) = '' then begin
    ShowMessage('请选择 SQLite 数据库文件');
    Exit;
  end;
  
  if not CheckBoxExportSchema.Checked and not CheckBoxExportData.Checked then begin
    ShowMessage('请至少选择导出表结构或数据');
    Exit;
  end;
  
  if ListBoxTables.Items.Count = 0 then begin
    ShowMessage('请先刷新表列表');
    Exit;
  end;
  
  // 获取选中的表
  SelectedTables := TStringList.Create;
  try
    if ListBoxTables.SelCount > 0 then begin
      for i := 0 to ListBoxTables.Items.Count - 1 do begin
        if ListBoxTables.Selected[i] then
          SelectedTables.Add(ListBoxTables.Items[i]);
      end;
    end else begin
      SelectedTables.Assign(ListBoxTables.Items);
    end;
    
    if SelectedTables.Count = 0 then begin
      ShowMessage('请至少选择一个表');
      Exit;
    end;
    
    BtnExport.Enabled := False;
    MemoLog.Clear;
    ProgressBar.Position := 0;
    
    // 连接源数据库
    if not ConnectDatabase then
      Exit;
    
    try
      // 创建 SQLite 数据库
      SqlitePath := EdtSqlitePath.Text;
      if not DirectoryExists(ExtractFilePath(SqlitePath)) then
        ForceDirectories(ExtractFilePath(SqlitePath));
      
      if FileExists(SqlitePath) then
        DeleteFile(SqlitePath);
      
      FSqliteDB := TSQLiteDatabase.Create(SqlitePath);
      try
        // SQLite 默认设置已经足够，无需额外配置 PRAGMA
        // 如果需要优化性能，可以在使用数据库时再设置
        
        ProgressBar.Max := SelectedTables.Count;
        ProgressBar.Position := 0;
        
        // 导出每个表
        for i := 0 to SelectedTables.Count - 1 do begin
          Log(Format('处理表: %s', [SelectedTables[i]]));
          
          if CheckBoxExportSchema.Checked then begin
            TableInfo := GetTableSchema(SelectedTables[i]);
            try
              if not ExportTableSchema(TableInfo) then
                Continue;
            finally
              TableInfo.Free;
            end;
          end;
          
          if CheckBoxExportData.Checked then begin
            if not ExportTableData(SelectedTables[i]) then
              Log(Format('导出表数据失败: %s', [SelectedTables[i]]));
          end;
          
          ProgressBar.Position := i + 1;
        end;
        
        Log('导出完成！');
        ShowMessage('导出完成！');
      finally
        FSqliteDB.Free;
        FSqliteDB := nil;
      end;
    finally
      DisconnectDatabase;
      BtnExport.Enabled := True;
    end;
  finally
    SelectedTables.Free;
  end;
end;

procedure TFrmDbcToSqlite.BtnCloseClick(Sender: TObject);
begin
  DisconnectDatabase;
  ClearTables;
  Close;
end;

end.
