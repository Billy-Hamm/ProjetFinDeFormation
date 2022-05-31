unit FrEvaluation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Ani, FMX.Controls.Presentation, FrEmployeMaquetteEval,
  FrEvaluationClick;

type
  Tevaluation = class(TFrame)
    titreListeEmploye: TRectangle;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label15: TLabel;
    topListeEmploye: TRectangle;
    Label12: TLabel;
    Image1: TImage;
    VertScrollBox1: TVertScrollBox;
    headEval: TLayout;
    filtreClick: TLayout;
    appaFiltre: TFloatAnimation;
    procedure Image1Click(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

implementation

{$R *.fmx}

uses logiqueEvaluation ;


procedure Tevaluation.Image1Click(Sender: TObject);
begin
appaDispaFiltreEval ();
end;

end.
