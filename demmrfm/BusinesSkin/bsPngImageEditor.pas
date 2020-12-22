{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       BusinessSkinForm                                            }
{       Version 9.45                                                }
{                                                                   }
{       Copyright (c) 2000-2011 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit bsPngImageEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, bsSkinCtrls, bsPngImage, Buttons;

type
  TbsPNGEditorForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    OD: TOpenDialog;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    PaintPanel: TbsskinPaintPanel;
    procedure PaintPanelOnPaint(Cnvs: TCanvas; R: TRect);
  public
    { Public declarations }
    FPngImage: TbsPngImage;
  end;

var
  bsPNGEditorForm: TbsPNGEditorForm;

  procedure ExecutePngEditor(AEditImage: TbsPngImage);

implementation

{$R *.DFM}

procedure ExecutePngEditor(AEditImage: TbsPngImage);
var
  F: TbsPNGEditorForm;
begin
  F := TbsPNGEditorForm.Create(Application);
  F.Position := poScreenCenter;
  F.FPngImage.Assign(AEditImage);
  if F.ShowModal = mrOk
  then
    begin
      AEditImage.Assign(F.FPngImage);
    end;
  F.Free;
end;

procedure TbsPNGEditorForm.FormCreate(Sender: TObject);
begin
  FPngImage := TbsPngImage.Create;
  PaintPanel := TbsSkinPaintPanel.Create(Self);
  PaintPanel.SetBounds(96, 8, 251, 251);
  PaintPanel.Parent := Self;
  PaintPanel.OnPanelPaint := PaintPanelOnPaint;
end;

procedure TbsPNGEditorForm.PaintPanelOnPaint(Cnvs: TCanvas; R: TRect);
begin
 Cnvs.Brush.Color := clWhite;
 Cnvs.Brush.Style := bsSolid;
 Cnvs.FillRect(R);
 if not FPngImage.Empty
 then
   begin
     FPngImage.Draw(Cnvs, R);
   end;
end;

procedure TbsPNGEditorForm.Button2Click(Sender: TObject);
begin
  FPngImage.Assign(nil);
  PaintPanel.RePaint;
  Label1.Caption := IntToStr(FPngImage.Width) + ' x ' + IntToStr(FPngImage.Height);
end;

procedure TbsPNGEditorForm.Button1Click(Sender: TObject);
begin
  if OD.Execute
  then
    begin
      FPngImage.LoadFromFile(OD.FileName);
      PaintPanel.RePaint;
      Label1.Caption := IntToStr(FPngImage.Width) + ' x ' + IntToStr(FPngImage.Height); 
    end;
end;

procedure TbsPNGEditorForm.BitBtn1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TbsPNGEditorForm.BitBtn2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TbsPNGEditorForm.FormDestroy(Sender: TObject);
begin
  FPngImage.Free;
end;

procedure TbsPNGEditorForm.FormShow(Sender: TObject);
begin
  Label1.Caption := IntToStr(FPngImage.Width) + ' x ' + IntToStr(FPngImage.Height);
end;

end.
