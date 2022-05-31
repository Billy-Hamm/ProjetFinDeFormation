unit FrFiltreElementInformation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Ani;

type
  TfiltreElementInformation = class(TFrame)
    filtreInformation: TRectangle;
    texteFiltre: TLabel;
    colorAnim: TColorAnimation;
    procedure colorAnimFinish(Sender: TObject);
    procedure filtreInformationClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    nomFilter : string;
    toggle : Boolean;
  end;


implementation

{$R *.fmx}

procedure TfiltreElementInformation.colorAnimFinish(Sender: TObject);
begin
colorAnim.Enabled := False;
end;

procedure TfiltreElementInformation.filtreInformationClick(Sender: TObject);
begin
if toggle = False then
  begin
     colorAnim.Trigger := '';
     colorAnim.TriggerInverse := '';
     toggle := True;
     nomFilter := texteFiltre.Text;
  end
  else
    begin
      colorAnim.Trigger := 'IsMouseOver=true';
      colorAnim.TriggerInverse := 'IsMouseOver=false';
      toggle := False;
      nomFilter := '';
    end;

end;

end.
