program DbToSqlite;

uses
  Forms,
  DbToSqlite in 'DbToSqlite.pas' {FrmDbToSqlite};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmDbToSqlite, FrmDbToSqlite);
  Application.Run;
end.

