unit SQLiteAdapter;

{
  SQLite 数据库适配层
  提供统一的数据库访问接口，支持从 BDE/ADO 迁移到 SQLite
}

interface

uses
  Classes, SysUtils, SQLiteTable3, SQLite3;

type
  // 数据库适配器接口
  IDBAdapter = interface
    function Open(const ConnectionString: string): Boolean;
    procedure Close;
    function IsConnected: Boolean;
    function ExecSQL(const SQL: string): Boolean;
    function Query(const SQL: string): TSQLiteTable;
    function GetTableString(const SQL: string): string;
    function GetTableValue(const SQL: string): Int64;
    function BeginTransaction: Boolean;
    function Commit: Boolean;
    function Rollback: Boolean;
    function GetLastInsertRowID: Int64;
    function GetLastChangedRows: Int64;
  end;

  // SQLite 适配器实现
  TSQLiteAdapter = class(TInterfacedObject, IDBAdapter)
  private
    FDatabase: TSQLiteDatabase;
    FConnected: Boolean;
    FDbPath: string;
  public
    constructor Create;
    destructor Destroy; override;
    
    function Open(const ConnectionString: string): Boolean;
    procedure Close;
    function IsConnected: Boolean;
    function ExecSQL(const SQL: string): Boolean;
    function Query(const SQL: string): TSQLiteTable;
    function GetTableString(const SQL: string): string;
    function GetTableValue(const SQL: string): Int64;
    function BeginTransaction: Boolean;
    function Commit: Boolean;
    function Rollback: Boolean;
    function GetLastInsertRowID: Int64;
    function GetLastChangedRows: Int64;
    
    property Database: TSQLiteDatabase read FDatabase;
  end;

implementation

{ TSQLiteAdapter }

constructor TSQLiteAdapter.Create;
begin
  inherited Create;
  FDatabase := nil;
  FConnected := False;
  FDbPath := '';
end;

destructor TSQLiteAdapter.Destroy;
begin
  Close;
  inherited;
end;

function TSQLiteAdapter.Open(const ConnectionString: string): Boolean;
begin
  Result := False;
  try
    Close;
    FDbPath := ConnectionString;
    FDatabase := TSQLiteDatabase.Create(FDbPath);
    FDatabase.SetTimeout(30000); // 30秒超时
    FConnected := True;
    Result := True;
  except
    on E: Exception do begin
      FConnected := False;
      raise Exception.Create('SQLite 连接失败: ' + E.Message);
    end;
  end;
end;

procedure TSQLiteAdapter.Close;
begin
  if Assigned(FDatabase) then begin
    try
      FDatabase.Free;
    except
    end;
    FDatabase := nil;
  end;
  FConnected := False;
end;

function TSQLiteAdapter.IsConnected: Boolean;
begin
  Result := FConnected and Assigned(FDatabase);
end;

function TSQLiteAdapter.ExecSQL(const SQL: string): Boolean;
begin
  Result := False;
  if not IsConnected then
    Exit;
  try
    FDatabase.ExecSQL(SQL);
    Result := True;
  except
    on E: Exception do begin
      raise Exception.Create('SQL 执行失败: ' + E.Message + #13#10 + 'SQL: ' + SQL);
    end;
  end;
end;

function TSQLiteAdapter.Query(const SQL: string): TSQLiteTable;
begin
  Result := nil;
  if not IsConnected then
    Exit;
  try
    Result := FDatabase.GetTable(SQL);
  except
    on E: Exception do begin
      raise Exception.Create('SQL 查询失败: ' + E.Message + #13#10 + 'SQL: ' + SQL);
    end;
  end;
end;

function TSQLiteAdapter.GetTableString(const SQL: string): string;
begin
  Result := '';
  if not IsConnected then
    Exit;
  try
    Result := FDatabase.GetTableString(SQL);
  except
    on E: Exception do begin
      raise Exception.Create('SQL 查询字符串失败: ' + E.Message + #13#10 + 'SQL: ' + SQL);
    end;
  end;
end;

function TSQLiteAdapter.GetTableValue(const SQL: string): Int64;
begin
  Result := 0;
  if not IsConnected then
    Exit;
  try
    Result := FDatabase.GetTableValue(SQL);
  except
    on E: Exception do begin
      raise Exception.Create('SQL 查询数值失败: ' + E.Message + #13#10 + 'SQL: ' + SQL);
    end;
  end;
end;

function TSQLiteAdapter.BeginTransaction: Boolean;
begin
  Result := False;
  if not IsConnected then
    Exit;
  try
    FDatabase.BeginTransaction;
    Result := True;
  except
    on E: Exception do begin
      raise Exception.Create('开始事务失败: ' + E.Message);
    end;
  end;
end;

function TSQLiteAdapter.Commit: Boolean;
begin
  Result := False;
  if not IsConnected then
    Exit;
  try
    FDatabase.Commit;
    Result := True;
  except
    on E: Exception do begin
      raise Exception.Create('提交事务失败: ' + E.Message);
    end;
  end;
end;

function TSQLiteAdapter.Rollback: Boolean;
begin
  Result := False;
  if not IsConnected then
    Exit;
  try
    FDatabase.Rollback;
    Result := True;
  except
    on E: Exception do begin
      raise Exception.Create('回滚事务失败: ' + E.Message);
    end;
  end;
end;

function TSQLiteAdapter.GetLastInsertRowID: Int64;
begin
  Result := 0;
  if not IsConnected then
    Exit;
  try
    Result := FDatabase.GetLastInsertRowID;
  except
  end;
end;

function TSQLiteAdapter.GetLastChangedRows: Int64;
begin
  Result := 0;
  if not IsConnected then
    Exit;
  try
    Result := FDatabase.GetLastChangedRows;
  end;
end;

end.

