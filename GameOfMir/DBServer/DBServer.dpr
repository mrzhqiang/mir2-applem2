program DBServer;

uses
  Forms,
  frmcpyrcd in 'frmcpyrcd.pas' {FrmCopyRcd},
  CreateId in 'CreateId.pas' {FrmCreateId},
  CreateChr in 'CreateChr.pas' {FrmCreateChr},
  UsrSoc in 'UsrSoc.pas' {FrmUserSoc},
  FIDHum in 'FIDHum.pas' {FrmIDHum},
  IDSocCli in 'IDSocCli.pas' {FrmIDSoc},
  FDBexpl in 'FDBexpl.pas' {FrmFDBExplore},
  AddrEdit in 'AddrEdit.pas' {FrmEditAddr},
  DBSMain in 'DBSMain.pas' {FrmDBSrv},
  HumDB in 'HumDB.pas',
  DBShare in 'DBShare.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  DBTools in 'DBTools.pas' {frmDBTool},
  EditRcd in 'EditRcd.pas' {frmEditRcd},
  TestSelGate in 'TestSelGate.pas' {frmTestSelGate},
  RouteManage in 'RouteManage.pas' {frmRouteManage},
  RouteEdit in 'RouteEdit.pas' {frmRouteEdit},
  Common in '..\Common\Common.pas',
  newchr in 'newchr.pas' {FrmNewChr},
  MudUtil in '..\Common\MudUtil.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  EDcode in '..\Common\EDcode.pas',
  OldMirDB in 'OldMirDB.pas',
  SQLiteTable3 in '..\Common\SQLiteTable3.pas',
  SQLite3 in '..\Common\SQLite3.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'DBServer';
  Application.CreateForm(TFrmDBSrv, FrmDBSrv);
  Application.CreateForm(TFrmCopyRcd, FrmCopyRcd);
  Application.CreateForm(TFrmCreateId, FrmCreateId);
  Application.CreateForm(TFrmCreateChr, FrmCreateChr);
  Application.CreateForm(TFrmIDHum, FrmIDHum);
  Application.CreateForm(TFrmIDSoc, FrmIDSoc);
  Application.CreateForm(TFrmNewChr, FrmNewChr);
  Application.CreateForm(TFrmUserSoc, FrmUserSoc);
  Application.CreateForm(TFrmFDBExplore, FrmFDBExplore);
  Application.CreateForm(TFrmCreateChr, FrmCreateChr);
  Application.CreateForm(TFrmEditAddr, FrmEditAddr);
  Application.CreateForm(TfrmDBTool, frmDBTool);
  Application.CreateForm(TfrmEditRcd, frmEditRcd);
  Application.CreateForm(TfrmRouteManage, frmRouteManage);
  Application.CreateForm(TfrmRouteEdit, frmRouteEdit);
  Application.Run;
end.

