unit logiqueEvaluation;

interface

uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
FMX.Graphics, FMX.Objects, FMX.Dialogs, FrEvaluationTopElement, logiquePartager,
FrEmployeMaquetteEval, FrEvaluation, FrFiltreElementInformation, FrFiltreElement;


// Procédure générique
procedure recupererDonneesEval ();



// gestion du filtre
procedure creationFiltreElementEval();
procedure creationFiltreInformationEval ();
procedure ajoutFiltreInformationEval ();
function valideFiltreEval () : TtabFiltreSelect;
procedure retireEmployeEval ();
procedure appaDispaFiltreEval ();

// Procédures création
  //Procédure d'initialisation
  procedure initialisationEval ();
  procedure creeEnsembleElementsEval ();
procedure creeTopElementEval ();
procedure creeEmployeEvals ();
procedure creeElementEval ();

// Procédure d'ajout
procedure ajouterTopElementEval ();
procedure ajouterEnsembleElementsEmployeEval ();
procedure ajouterTousEmployeEval ();
procedure ajouterMargeEmployeEval ();
procedure ajouterEmployeEval ();

// Procédure de retrait
procedure retirerTopElementEval ();
procedure retirerTousElementEmployeEval ();
procedure retirerEnsembleElementEmployeEval ();

var
  topEvaluation : TevaluationTopElement;
  UnEmployeEval : TemployeMaquetteEval;
  LesEmployeEval : array of TemployeMaquetteEval;
  elemenetPersonneEval : array of string;
  TousEmployeEval : Tevaluation;
  nombreEmployeEval : Integer;
  // Cette variable permet de faire à ce que le code sql ne soit pas exécté + une fois
  sentinelleEval : Boolean;

  filtreElementEval : TfiltreElement;
  filtreInformationEval : TfiltreElementInformation;
  tabFiltreInformationEval : TtabFiltreType;
  toggleFiltreEval : Boolean;

implementation

uses Principale, dmBasesDeDonnees;



 // Procédure de création

 procedure initialisationEval ();
 begin
   sentinelleEval := True;
 end;


procedure creeEnsembleElementsEval ();
begin
  toggleFiltreEval := False;
  creeTopElementEval ();
  creeElementEval ();
  creationFiltreElementEval();
  ajoutFiltreInformationEval ();
end;

procedure creeTopElementEval ();
begin
  topEvaluation := TevaluationTopElement.Create(Pprincipale);
end;

procedure creeElementEval ();
begin
  TousEmployeEval := Tevaluation.Create(Pprincipale);
end;

procedure recupererDonneesEval ();
 var
  j : Integer;
  reqSql1, reqSql2 : string;
begin
  j := 0;
  nombreEmployeEval := 0;
  reqSql1 := 'SELECT idEmploye, nomEmp, prenomEmp FROM Employe';
  reqSql2 := 'SELECT count(*) FROM Employe';

  requeteSql(reqSql2);
   basesDeDonnees.FDQuery1.First;
   while not basesDeDonnees.FDQuery1.Eof do
    begin
      nombreEmployeEval := basesDeDonnees.FDQuery1.Fields[0].AsInteger;
      basesDeDonnees.FDQuery1.Next;
    end;


    // Le 2 représenter le nombre d'information à récupérer pour un employé
    SetLength(elemenetPersonneEval, nombreEmployeEval * 3);


   requeteSql (reqSql1);
    basesDeDonnees.FDQuery1.First;
    while not basesDeDonnees.FDQuery1.Eof do
      begin
        elemenetPersonneEval[j] := basesDeDonnees.FDQuery1.FieldByName('idEmploye').AsString;
        j := j + 1;
        elemenetPersonneEval[j] := basesDeDonnees.FDQuery1.FieldByName('nomEmp').AsString;
        j := j + 1;
        elemenetPersonneEval[j] := basesDeDonnees.FDQuery1.FieldByName('prenomEmp').AsString;
        j := j + 1;
        basesDeDonnees.FDQuery1.Next;
      end;

end;

procedure creeEmployeEvals ();
var
   i,k : SmallInt;
begin
k := 0;

   if sentinelleEval = true then
    begin
      recupererDonneesEval ();
      sentinelleEval := False;
    end;

    SetLength(LesEmployeEval, nombreEmployeEval);
    for  i := 0 to nombreEmployeEval-1 do
         begin


            // Création de la frame puis renommer le name
            UnEmployeEval := TemployeMaquetteEval.Create(TousEmployeEval);
            UnEmployeEval.Name := UnEmployeEval.Name + inttostr(i);
            // Injection de données dans la Frame
            UnEmployeEval.identifiant.Text := elemenetPersonneEval[k];
            UnEmployeEval.nomEmploye.Text := elemenetPersonneEval[k+1] + ' ' +
            elemenetPersonneEval[k+2];
            // Ici le 3 représente le nombre d'élement à prenre
            k := k + 3;
            // Stocker les frame dans le tableau pour l'affichage
            LesEmployeEval[i] := UnEmployeEval;
         end;
end;




// Procédure d'ajout

procedure ajouterEnsembleElementsEmployeEval ();
begin

  creeEnsembleElementsEval ();
  ajouterTopElementEval ();
  ajouterEmployeEval ();
end;


procedure ajouterTopElementEval ();
begin
  topEvaluation.Parent := Pprincipale.containeTopElement;
  appaTopElementEval ();
  TopElementEvalAnim.Parent := topEvaluation;
  TopElementEvalAnim.Enabled := true;
end;



procedure ajouterTousEmployeEval ();
  var
    j : Integer;
begin
  creeEmployeEvals ();
  ajouterMargeEmployeEval ();

  for j:= 0 to Length(LesEmployeEval)-1 do
    begin
      LesEmployeEval[j].Parent := TousEmployeEval.VertScrollBox1;
    end;

end;


procedure ajouterEmployeEval ();
begin

   ajouterTousEmployeEval();

   TousEmployeEval.Parent := Pprincipale.prinContainer;
   appaTousEmployesEval();
   TousEmployeEvalAnim.Parent := TousEmployeEval;
   TousEmployeEvalAnim.Enabled := True;

end;


procedure ajouterMargeEmployeEval ();
begin
  // La taille du conteneur des employés
    TousEmployeEval.Height := TousEmployeEval.topListeEmploye.Height +
    TousEmployeEval.titreListeEmploye.Height + (UnEmployeEval.Height * nombreEmployeEval);

  // Taille de la verticalBox  du conteneur des employés
    TousEmployeEval.VertScrollBox1.Height := UnEmployeEval.Height * nombreEmployeEval ;

  // Taille du prinContainer
    Pprincipale.prinContainer.Height := TousEmployeEval.Height ;
end;





// Procédure de retrait

procedure retirerTopElementEval ();
begin
  topEvaluation.Destroy;
end;

procedure retirerTousElementEmployeEval ();
begin
  TousEmployeEval.Destroy;
end;

procedure retirerEnsembleElementEmployeEval ();
begin
   retirerTopElementEval ();
   retirerTousElementEmployeEval ();
   Finalize(LesEmployeEval);
  Finalize(tabFiltreInformationEval);
end;

procedure retireEmployeEval ();
begin
   TousEmployeEval.parent := nil;
end;

{
*****************************************
*****************************************
}
// Gestion du filtre

procedure creationFiltreElementEval();
begin
    filtreElementEval := TfiltreElement.Create(TousEmployeEval);
end;

procedure creationFiltreInformationEval ();
var
   informations : array [0..3] of string;
   i : Integer;
   tailleTab : Integer;
begin
    tailleTab := Length(informations);
    informations [0] := 'sexeEmp';
    informations [1] := 'dateNaissanceEmp';
    informations [2] := 'Sit. Civil';
    informations [3] := 'idEmploye';
    SetLength(tabFiltreInformationEval, tailleTab);

    for i := 0 to tailleTab-1 do
        begin
           filtreInformationEval := TfiltreElementInformation.Create(filtreElementEval);
           filtreInformationEval.Name := filtreInformationEval.Name + IntToStr(i);
           filtreInformationEval.texteFiltre.Text := informations[i];
           tabFiltreInformationEval[i] := filtreInformationEval;
        end;
end;

procedure ajoutFiltreInformationEval ();
var
   j : Integer;
begin
     creationFiltreInformationEval ();

  for j:= 0 to Length(tabFiltreInformationEval)-1 do
      begin
        tabFiltreInformationEval[j].Parent := filtreElementEval.body;
      end;

      filtreElementEval.Parent := TousEmployeEval.filtreClick;
end;

function valideFiltreEval () : TtabFiltreSelect;
begin
   Result := elementSect(tabFiltreInformationEval);
end;


procedure appaDispaFiltreEval ();
begin
  if toggleFiltreEval = False then
begin
 TousEmployeEval.filtreClick.Visible := True;
 TousEmployeEval.appaFiltre.Enabled := True;
 toggleFiltreEval := True;
end
else
  begin
    TousEmployeEval.filtreClick.Visible := False;
    toggleFiltreEval := False;
  end;
end;


{
*****************************************
*****************************************
}


end.
