program DbcToSqliteTool;

uses
  Windows, SysUtils, Forms,
  DbcToSqliteSchema in 'DbcToSqliteSchema.pas' {FrmDbcToSqlite};

{$R DbcToSqliteSchema.res}

function SetDllDirectory(lpPathName: PChar): BOOL; stdcall; external 'kernel32.dll' name 'SetDllDirectoryA';

begin
  // 设置 DLL 搜索路径为程序目录，确保能找到 sqlite3.dll
  SetDllDirectory(PChar(ExtractFilePath(ParamStr(0))));
  
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmDbcToSqlite, FrmDbcToSqlite);
  Application.Run;
end.
