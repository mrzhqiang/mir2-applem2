program LSetup;

uses
  Forms,
  FrmMain in 'FrmMain.pas' {FormMain},
  FrmEditServer in 'FrmEditServer.pas' {FormEditServer},
  MD5Unit in '..\..\Common\MD5Unit.pas',
  FrmEditUpData in 'FrmEditUpData.pas' {FormEditUpData},
  Share in '..\Login\Share.pas',
  HUtil32 in '..\..\Common\HUtil32.pas',
  FrmLogin in 'FrmLogin.pas' {FormLogin},
  EDcode in '..\用户更新工具\Common\EDcode.pas',
  SCShare in '..\用户更新工具\Common\SCShare.pas',
  GeneralCommon in '..\..\Common\GeneralCommon.pas',
  DES in '..\..\Common\DES.pas',
  MyCommon in '..\..\MyCommon\MyCommon.pas';

{$R *.res}
{$R Data.res}
{$R DataMir2.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'LSetup';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormEditUpData, FormEditUpData);
  Application.CreateForm(TFormEditServer, FormEditServer);
  Application.Run;
end.
