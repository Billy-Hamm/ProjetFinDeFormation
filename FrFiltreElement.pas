unit FrFiltreElement;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts,
  FrFiltreElementInformation, FrFiltre, FrFiltreMaquette, logiquePartager;

type
  TfiltreElement = class(TFrame)
    Layout2: TLayout;
    Rectangle2: TRectangle;
    containe: TRectangle;
    header: TLayout;
    Line1: TLine;
    val: TRectangle;
    body: TVertScrollBox;
    procedure valClick(Sender: TObject);
  private
    { D?clarations priv?es }
  public
    { D?clarations publiques }
  end;
  procedure dialog (tableau : TtabFiltreSelect);
  procedure creationFiltreMaquette (tab : TtabFiltreSelect);
  procedure creationFiltre();
  procedure detruireFiltre ();
  procedure ajouterFiltre ();
  procedure retireFiltre ();
  procedure ajouterHauteur (taille : Single);
  function getIntervalle () : Boolean;


var
   filtre : Tfiltre;
   tabMaquetteFiltre : array of TfiltreMaquette;
   nombreLignes : Integer;
   intervalle : Boolean;


implementation
uses logiqueEmploye, varGlobale, FrEmploye, Principale, dmBasesDeDonnees,
logiqueEvaluation;

{$R *.fmx}

 

procedure TfiltreElement.valClick(Sender: TObject);
begin
// La variable 'CheminActuel' vient de l'Unit? VarGlobale (c'est d'ailleurs une
// mauvaise fa?on de faire, mais bon...)

if CheminAcutuel = 'Employ?s' then
   begin
     if Length(valideFiltreEmploye()) <> 0 then
      begin
       retireEmploye ();
       dialog (valideFiltreEmploye());
      end;
   end;

if CheminAcutuel = 'Evaluations' then
   begin
    if Length(valideFiltreEval()) <> 0 then
     begin
       retireEmployeEval ();
       Dialog (valideFiltreEval ());
     end;
   end;

end;

function getIntervalle () : Boolean;
begin
  Result := intervalle;
end;

// Cette proc?dure permet la cr?ation des ?l?ments de filtre
procedure dialog (tableau : TtabFiltreSelect);
begin
     // Gestion de la cr?ation et de la destruction du filtre
     try
        creationFiltre();
     except
     on E : EComponentError do
         begin
           detruireFiltre ();
           Finalize(tabMaquetteFiltre);
           creationFiltre();
         end;
     end;

    creationFiltreMaquette (tableau);
    ajouterFiltre ();
    intervalle := True;

end;

procedure creationFiltre();
begin
   filtre := Tfiltre.Create(Pprincipale);
end;

procedure detruireFiltre ();
begin
     filtre.Destroy;
end;

procedure creationFiltreMaquette (tab : TtabFiltreSelect);
var
   maquetteFiltre : TfiltreMaquette;
//   titreFiltre : array [0..4] of TLabel;
   titreMaquette, titreFiltre : array [0..3] of TLabel;
   valeur, requeteEnsemble, reqSql2 : string;
   tailleFiltreMaquette : Single;
   i, j : Integer;
begin
     // On va arranger ?a, avec un truc du genre si c'est vide ne toggle

     j := 0;
     titreFiltre[0] := filtre.Label1;
     titreFiltre[1] := filtre.Label2;
     titreFiltre[2] := filtre.Label3;
     titreFiltre[3] := filtre.Label4;


     // on ajoute les titre au niveau du filtre
     for i:= 0 to Length(tab)-1 do
         begin
           titreFiltre[i].Text := tab[i];
         end;

     // On prend l'ensemble des l'?l?ments s?lectionn?s pour les mettre dans la requ?te
     for i:= 0 to Length(tab)-1 do
         begin
              valeur := valeur +', '+ tab[i];
         end;

     requeteEnsemble := 'SELECT nomEmp, prenomEmp' + valeur + ' FROM Employe';
     reqSql2 := 'SELECT count(*) FROM Employe';

     requeteSql(reqSql2);
   basesDeDonnees.FDQuery1.First;
   while not basesDeDonnees.FDQuery1.Eof do
    begin
    // Il va falloir enregistre le nombre de ligne de la requette
    // ?a va servir pour ajouter de la longuer ? l'?l?ment de filtre.
      nombreLignes :=  basesDeDonnees.FDQuery1.Fields[0].AsInteger;
      basesDeDonnees.FDQuery1.Next;
    end;
    SetLength(tabMaquetteFiltre, nombreLignes);


     requeteSql(requeteEnsemble);

     // D?but de la lecture du result de la base de donn?es
    basesDeDonnees.FDQuery1.First;
    while not basesDeDonnees.FDQuery1.Eof do
          begin
             maquetteFiltre := TfiltreMaquette.Create(filtre);
             maquetteFiltre.Name := maquetteFiltre.Name + IntToStr(j);
             titreMaquette[0] := maquetteFiltre.Label1;
             titreMaquette[1] := maquetteFiltre.Label2;
             titreMaquette[2] := maquetteFiltre.Label3;
             titreMaquette[3] := maquetteFiltre.Label4;

             maquetteFiltre.nomEmploye.Text := basesDeDonnees.FDQuery1.FieldByName('nomEmp').AsString + ' ' +
             basesDeDonnees.FDQuery1.FieldByName('prenomEmp').AsString;

             for i := 0 to Length(tab)-1 do
                 begin
                   titreMaquette[i].Text :=  basesDeDonnees.FDQuery1.FieldByName(tab[i]).AsString;
                 end;

             tabMaquetteFiltre[j] := maquetteFiltre;
             basesDeDonnees.FDQuery1.Next;
             j := j + 1;

          end;

         tailleFiltreMaquette := tabMaquetteFiltre[0].Height;
         ajouterHauteur (tailleFiltreMaquette);
end;

procedure ajouterFiltre ();
var
   k : Integer;
begin
  for k := 0 to Length(tabMaquetteFiltre)-1 do
      begin
        tabMaquetteFiltre[k].Parent := filtre.VertScrollBox1;
      end;


      filtre.Parent := Pprincipale.prinContainer;
end;

procedure retireFiltre ();
begin
  filtre.Parent := nil;
end;

procedure ajouterHauteur (taille : Single);
begin
  // La taille du conteneur des employ?s
    filtre.Height := filtre.topListeEmploye.Height +
    filtre.titreListeEmploye.Height + (taille * nombreLignes);

  // Taille de la verticalBox  du conteneur des employ?s
    filtre.VertScrollBox1.Height := taille * nombreLignes ;
end;

end.
