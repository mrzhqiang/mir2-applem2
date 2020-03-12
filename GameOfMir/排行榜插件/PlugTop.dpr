program PlugTop;

uses
  Forms,
  FrmMain in 'FrmMain.pas' {FormMain},
  Grobal2 in '..\Common\Grobal2.pas',
  MudUtil in '..\Common\MudUtil.pas',
  Common in '..\Common\Common.pas',
  MyCommon in '..\MyCommon\MyCommon.pas',
  HUtil32 in '..\Common\HUtil32.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'PlugTop';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
