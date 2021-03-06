unit FrFiltre;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FrFiltreMaquette, FMX.Ani;

type
  Tfiltre = class(TFrame)
    containeTitreConge: TLayout;
    topListeEmploye: TRectangle;
    Label12: TLabel;
    titreListeEmploye: TRectangle;
    photoEmploye: TLabel;
    nomEmploye: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    VertScrollBox1: TVertScrollBox;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation
uses logiqueEmploye;

{$R *.fmx}

end.
