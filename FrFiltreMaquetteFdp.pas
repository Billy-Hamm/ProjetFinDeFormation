unit FrFiltreMaquetteFdp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  FrFiltreMaquetteClickFdp;

type
  TfiltreMaquetteFdp = class(TFrame)
    elementEmploye: TRectangle;
    photoEmploye: TImage;
    nomEmploye: TLabel;
    elementFiltrer: TLabel;
    Circle1: TCircle;
    nbrJourConge: TLabel;
    bgcFiltreFdp: TRectangle;
    containeurToutElementFiltre: TLayout;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

end.
