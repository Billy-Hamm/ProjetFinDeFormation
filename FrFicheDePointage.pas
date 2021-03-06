unit FrFicheDePointage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Edit, FMX.Controls.Presentation;

type
  TficheDePointage = class(TFrame)
    titreListeEmploye: TRectangle;
    Label13: TLabel;
    nomEmploye: TLabel;
    posteEmploye: TLabel;
    performanceEmploye: TLabel;
    identifiant: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Line1: TLine;
    Line2: TLine;
    btnConfirme: TLayout;
    valFdp: TCircle;
    Rectangle1: TRectangle;
    Line3: TLine;
    Line4: TLine;
    titreHeureSup: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Layout1: TLayout;
    Circle1: TCircle;
    Line5: TLine;
    Line6: TLine;
    Label12: TLabel;
    VertScrollBox1: TVertScrollBox;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

end.
