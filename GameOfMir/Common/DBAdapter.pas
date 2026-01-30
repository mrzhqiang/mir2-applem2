unit DBAdapter;

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
    function GetTableValue(const SQL: string): Int64;
    function GetTableString(const SQL: string): string;
    function GetLastInsertRowID: Int64;
    function GetLastChangedRows: Int64;
    procedure BeginTransaction;
    procedure Commit;
    procedure Rollback;
    function TableExists(const TableName: string): Boolean;
  end;

  // SQLite 适配器实现
  TSQLiteAdapter = class(TInterfacedObject, IDBAdapter)
  private
    FDatabase: TSQLiteDatabase;
    FConnected: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Open(const ConnectionString: string): Boolean;
    procedure Close;
    function IsConnected: Boolean;
    function ExecSQL(const SQL: string): Boolean;
    function Query(const SQL: string): TSQLiteTable;
    function GetTableValue(const SQL: string): Int64;
    function GetTableString(const SQL: string): string;
    function GetLastInsertRowID: Int64;
    function GetLastChangedRows: Int64;
    procedure BeginTransaction;
    procedure Commit;
    procedure Rollback;
    function TableExists(const TableName: string): Boolean;
  end;

  // 数据库适配器工厂
  TDBAdapterFactory = class
  public
    class function CreateAdapter(DbType: Integer; const ConnectionString: string): IDBAdapter;
  end;

implementation

{ TSQLiteAdapter }

constructor TSQLiteAdapter.Create;
begin
  inherited;
  FDatabase := nil;
  FConnected := False;
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
    if FDatabase <> nil then
      FreeAndNil(FDatabase);
    
    FDatabase := TSQLiteDatabase.Create(ConnectionString);
    FConnected := True;
    Result := True;
  except
    FConnected := False;
    Result := False;
  end;
end;

procedure TSQLiteAdapter.Close;
begin
  if FDatabase <> nil then begin
    FreeAndNil(FDatabase);
    FConnected := False;
  end;
end;

function TSQLiteAdapter.IsConnected: Boolean;
begin
  Result := FConnected and (FDatabase <> nil);
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
    Result := False;
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
    Result := nil;
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
    Result := 0;
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
    Result := '';
  end;
end;

function TSQLiteAdapter.GetLastInsertRowID: Int64;
begin
  Result := 0;
  if IsConnected then
    Result := FDatabase.GetLastInsertRowID;
end;

function TSQLiteAdapter.GetLastChangedRows: Int64;
begin
  Result := 0;
  if IsConnected then
    Result := FDatabase.GetLastChangedRows;
end;

procedure TSQLiteAdapter.BeginTransaction;
begin
  if IsConnected then
    FDatabase.BeginTransaction;
end;

procedure TSQLiteAdapter.Commit;
begin
  if IsConnected then
    FDatabase.Commit;
end;

procedure TSQLiteAdapter.Rollback;
begin
  if IsConnected then
    FDatabase.Rollback;
end;

function TSQLiteAdapter.TableExists(const TableName: string): Boolean;
begin
  Result := False;
  if IsConnected then
    Result := FDatabase.TableExists(TableName);
end;

{ TDBAdapterFactory }

class function TDBAdapterFactory.CreateAdapter(DbType: Integer; const ConnectionString: string): IDBAdapter;
begin
  Result := nil;
  case DbType of
    2: // SQLITE
    begin
      Result := TSQLiteAdapter.Create;
      Result.Open(ConnectionString);
    end;
  end;
end;

end.

