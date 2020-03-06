program GameCenter;

uses
  Forms,
  GMain in 'GMain.pas' {frmMain},
  GShare in 'GShare.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  DataBackUp in 'DataBackUp.pas',
  Common in '..\Common\Common.pas',
  EDcode in '..\Common\EDcode.pas',
  SEShare in '..\Common\SEShare.pas',
  MD5Unit in '..\Common\MD5Unit.pas',
  MemRun in '..\MyCommon\MemRun.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.HintPause := 100;
  Application.HintShortPause := 100;
  Application.HintHidePause := 15000;
  Application.Title := 'GameCenter';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

