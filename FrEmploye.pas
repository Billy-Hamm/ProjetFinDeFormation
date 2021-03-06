unit FrEmploye;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, FrEmployeMaquette,
  FrEmployeClick, FrFiltreElement, FMX.Ani;

type
  Temploye = class(TFrame)
    titreListeEmploye: TRectangle;
    Label13: TLabel;
    nomEmploye: TLabel;
    posteEmploye: TLabel;
    performanceEmploye: TLabel;
    identifiant: TLabel;
    topListeEmploye: TRectangle;
    Label12: TLabel;
    Image1: TImage;
    VertScrollBox1: TVertScrollBox;
    Layout1: TLayout;
    filtreClick: TLayout;
    appaFiltre: TFloatAnimation;
    procedure titreListeEmployeResize(Sender: TObject);
    procedure appaFiltreFinish(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;



implementation
uses logiqueEmploye;

{$R *.fmx}

procedure Temploye.appaFiltreFinish(Sender: TObject);
begin
appaFiltre.Enabled := False;
end;


procedure Temploye.Image1Click(Sender: TObject);
begin
appaDispaFiltreEmploye ();
end;

procedure Temploye.titreListeEmployeResize(Sender: TObject);
var
  diffIdent,
  diffNomP,
  diffPost,
  diffPerf : Single;

  identPos, nomPrPos, postPos, perfPos : Single;
begin

diffIdent := 4.25831;
diffNomP := 9.7786;
diffPost := 16.0482;
diffPerf := 22.9395;

identPos := 70.81168;
nomPrPos := 177.3935;
postPos := 352.8245;
perfPos := 530.955;

if (titreListeEmploye.Width < 782) and (titreListeEmploye.Width > 752) then
begin
  identifiant.Position.X := identPos - diffIdent;
  nomEmploye.Position.X := nomPrPos - diffNomP;
  posteEmploye.Position.X := postPos - diffPost;
  performanceEmploye.Position.X := perfPos - diffPerf;
end;

if (titreListeEmploye.Width < 752) and (titreListeEmploye.Width > 722) then
begin
  identifiant.Position.X := identPos - (diffIdent * 2);
  nomEmploye.Position.X := nomPrPos - (diffNomP * 2);
  posteEmploye.Position.X := postPos - (diffPost * 2);
  performanceEmploye.Position.X := perfPos - (diffPerf * 2);
end;

if (titreListeEmploye.Width < 722) and (titreListeEmploye.Width > 692) then
begin
  identifiant.Position.X := identPos - (diffIdent * 3);
  nomEmploye.Position.X := nomPrPos - (diffNomP * 3);
  posteEmploye.Position.X := postPos - (diffPost * 3);
  performanceEmploye.Position.X := perfPos - (diffPerf * 3);
end;

if (titreListeEmploye.Width < 692) and (titreListeEmploye.Width > 662) then
begin
  identifiant.Position.X := identPos - (diffIdent * 4);
  nomEmploye.Position.X := nomPrPos - (diffNomP * 4);
  posteEmploye.Position.X := postPos - (diffPost * 4);
  performanceEmploye.Position.X := perfPos - (diffPerf * 4);
end;

if (titreListeEmploye.Width < 662) and (titreListeEmploye.Width > 632) then
begin
  identifiant.Position.X := identPos - (diffIdent * 5);
  nomEmploye.Position.X := nomPrPos - (diffNomP * 5);
  posteEmploye.Position.X := postPos - (diffPost * 5);
  performanceEmploye.Position.X := perfPos - (diffPerf * 5);
end;

if (titreListeEmploye.Width < 632) then
begin
  identifiant.Position.X := identPos - (diffIdent * 6);
  nomEmploye.Position.X := nomPrPos - (diffNomP * 6);
  posteEmploye.Position.X := postPos - (diffPost * 6);
  performanceEmploye.Position.X := perfPos - (diffPerf * 6);
end;

if titreListeEmploye.Width <= 669 then
  nomEmploye.Width := 130
else
  nomEmploye.Width := 155;

end;

end.
