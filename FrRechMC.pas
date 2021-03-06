unit FrRechMC;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.Edit,
  FrEntierIntervalle, FMX.Ani;

type
{ On va cr?er un type de Element crit?re pour qu'il puisse h?riter de toutes les propri?t?
et attribut de Element crit?re et aussi on avoir d'autre que ce dernier n'a pas }
  TRechMC = class(TFrame)
    headerRech: TLayout;
    bgc: TRectangle;
    btnCritere: TRectangle;
    Label1: TLabel;
    btnValidation: TRectangle;
    Label3: TLabel;
    Label4: TLabel;
    conteneurCritereElement: TLayout;
    conteneurSaisiCritere: TVertScrollBox;
    conteneurCritere: TVertScrollBox;
    appaHauteur: TFloatAnimation;
    dispHauteur: TFloatAnimation;
    Line1: TLine;
    procedure appaHauteurFinish(Sender: TObject);
    procedure dispHauteurFinish(Sender: TObject);
  private
    { D?clarations priv?es }
  public
    { D?clarations publiques }
  end;

  // Les procedures

  { On va dynamiser cette procedure en lui donner comme param?tre un tableau qui va lui
  permettre d'avoir les ?l?ment de crit?re selon la page dans laquelle nous sommes }
  procedure creationElementCritere ();

  // Les variables
  var
    tabElementCritere : array [0..5] of string;

implementation

{$R *.fmx}

procedure creationElementCritere ();
begin
  tabElementCritere [0] := 'Poste';
  tabElementCritere [1] := 'Salaire';
  tabElementCritere [2] := 'Ancienet?';
  tabElementCritere [3] := 'T. Contrat';
  tabElementCritere [4] := 'DDN';
  tabElementCritere [5] := 'Sexe';
end;

procedure TRechMC.appaHauteurFinish(Sender: TObject);
begin
appaHauteur.Enabled := False;
end;

procedure TRechMC.dispHauteurFinish(Sender: TObject);
begin
dispHauteur.Enabled := False;
end;

end.
