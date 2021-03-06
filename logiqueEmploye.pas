unit logiqueEmploye;

interface

uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
FMX.Graphics, FMX.Objects, FMX.Ani,  FMX.Dialogs, FrEmployeTopElement, FrEmployeMaquette,
FrEmploye, logiquePartager, FrFiltreElementInformation, FrFiltreElement;



// Proc?dure g?n?rique
procedure responsiveEmploye (route : string);
function valideFiltreEmploye () : TtabFiltreSelect;
procedure appaDispaFiltreEmploye ();
procedure retireEmploye ();

// Proc?dures cr?ation
  //Cr?ation des employ?s
  procedure initialisationEmploye ();
procedure creeEnsembleElementsEmploye ();
procedure creeEmployes ();
procedure creeTopElement ();
procedure creeElementEmploye ();
  //Cr?ation de filtre
procedure creationFiltreElement();
procedure creationFiltreInformation ();



//proc?dure ajout
procedure ajouterEnsembleElementsEmploye ();
procedure ajouterTopElement();
procedure ajouterTousEmploye();
procedure ajouterMargeEmploye ();
procedure ajouterEmploye ();

procedure ajoutFiltreInformation ();

//proc?dure retrait
procedure retirerTopElement();
procedure retirerTousElement ();
procedure retirerEnsembleElementEmploye ();





var
  topEmploye : TemployeTopElemnt;
  LesEmploye : array of TemployeMaquette;
  elemenetPersonne : array of string;
  UnEmploye : TemployeMaquette;
  TousEmploye : Temploye;
  nombreEmploye : Integer;
  // Cette variable permet de faire ? ce que le code sql ne soit pas ex?ct? + une fois
  debut : Boolean;
  // Pour que la cr?ation des information de filtre ne s'ex?cute qu'une fois
  exeFiltre : Boolean;
  // pour ex?cuter une seule fois la procedure de responsive
  verRes : Integer;
  toggleFiltre : Boolean;

  filtreElement : TfiltreElement;
  filtreInformation : TfiltreElementInformation;
  tabFiltreInformation : TtabFiltreType;


implementation

uses Principale, dmBasesDeDonnees;
// Les proc?dures de cr?ation

// Initialisations
procedure initialisationEmploye ();
begin
  debut := True;
  verRes := 0;
end;


procedure creeEnsembleElementsEmploye ();
begin
  toggleFiltre := False;
  creeTopElement ();
  creeElementEmploye ();
  creationFiltreElement();
  ajoutFiltreInformation ();
end;

procedure creeElementEmploye ();
begin
   TousEmploye := Temploye.Create(Pprincipale);
end;


procedure creeTopElement ();
begin
   topEmploye := TemployeTopElemnt.Create(Pprincipale);
end;

procedure recupererDonneesEmploye ();
 var
  j : Integer;
  reqSql1, reqSql2 : string;
begin
  j := 0;
  nombreEmploye := 0;
  reqSql1 := 'SELECT idEmploye, nomEmp, prenomEmp FROM Employe';
  reqSql2 := 'SELECT count(*) FROM Employe';

  requeteSql(reqSql2);
   basesDeDonnees.FDQuery1.First;
   while not basesDeDonnees.FDQuery1.Eof do
    begin
      nombreEmploye := basesDeDonnees.FDQuery1.Fields[0].AsInteger;
      basesDeDonnees.FDQuery1.Next;
    end;


    // Le 3 repr?senter le nombre d'information ? r?cup?rer pour un employ?
    SetLength(elemenetPersonne, nombreEmploye * 3);


   requeteSql (reqSql1);
    basesDeDonnees.FDQuery1.First;
    while not basesDeDonnees.FDQuery1.Eof do
      begin
        elemenetPersonne[j] := basesDeDonnees.FDQuery1.FieldByName('idEmploye').AsString;
        j := j + 1;
        elemenetPersonne[j] := basesDeDonnees.FDQuery1.FieldByName('nomEmp').AsString;
        j := j + 1;
        elemenetPersonne[j] := basesDeDonnees.FDQuery1.FieldByName('prenomEmp').AsString;
        j := j + 1;
        basesDeDonnees.FDQuery1.Next;
      end;

end;


procedure creeEmployes ();
var
   i,k : integer;
begin
k := 0;

   if debut then
    begin
      recupererDonneesEmploye ();
      debut := False;
    end;

    SetLength(LesEmploye, nombreEmploye);
    for  i := 0 to nombreEmploye-1 do
         begin


            // Cr?ation de la frame puis renommer le name
            UnEmploye := TemployeMaquette.Create(TousEmploye);
            UnEmploye.Name := UnEmploye.Name + inttostr(i);
            // Injection de donn?es dans la Frame
            UnEmploye.identifiant.Text := elemenetPersonne[k];
            UnEmploye.nomEmploye.Text := elemenetPersonne[k+1] + ' ' +
            elemenetPersonne[k+2];
            // Ici le 3 repr?sente le nombre d'?lement ? prendre
            k := k + 3;
            // Stocker les frames dans le tableau pour l'affichage
            LesEmploye[i] := UnEmploye;
         end;
end;


// Les proc?dures d'ajout


 procedure ajouterEnsembleElementsEmploye ();
begin
  creeEnsembleElementsEmploye ();
  ajouterTopElement();
  ajouterEmploye ();
end;

procedure ajouterTopElement();
begin
  topEmploye.Parent := Pprincipale.containeTopElement;
  appaTopElementEmploye ();
  TopElementEmployeAnim.Parent := topEmploye;
  TopElementEmployeAnim.Enabled := true;

end;


procedure ajouterTousEmploye();
  var
    j : Integer;
begin
  creeEmployes ();
  ajouterMargeEmploye ();

  for j:= 0 to Length(LesEmploye)-1 do
    begin
      LesEmploye[j].Parent := TousEmploye.VertScrollBox1;
    end;

end;

procedure ajouterEmploye ();

begin

   ajouterTousEmploye();
   TousEmploye.Parent := Pprincipale.prinContainer;
   appaTousEmployes ();
   TousEmployesAnim.Parent := TousEmploye;
   TousEmployesAnim.Enabled := true;

end;



procedure ajouterMargeEmploye ();
begin
  // La taille du conteneur des employ?s
    TousEmploye.Height := TousEmploye.topListeEmploye.Height +
    TousEmploye.titreListeEmploye.Height + (UnEmploye.Height * nombreEmploye);

  // Taille de la verticalBox  du conteneur des employ?s
    TousEmploye.VertScrollBox1.Height := UnEmploye.Height * nombreEmploye ;

  // Taille du prinContainer
    Pprincipale.prinContainer.Height := TousEmploye.Height ;
end;


// Les proc?dures de retrait

procedure retirerTopElement();
begin
  topEmploye.Destroy;
end;

procedure retirerTousElement ();
begin
  TousEmploye.Destroy;
end;

procedure retireEmploye ();
begin
  TousEmploye.Parent := nil;
end;


procedure retirerEnsembleElementEmploye ();
begin
  retirerTopElement();
  retirerTousElement ();
  Finalize(LesEmploye);
  Finalize(tabFiltreInformation);
end;


// Pour le responsive

procedure responsiveEmploye (route : string);

begin
  if route = 'Employ?s' then
    begin
      if Pprincipale.Width < 782 then
        begin
          TousEmploye.VertScrollBox1.Anchors := [TAnchorKind.akLeft, TAnchorKind.akRight];
          TousEmploye.Parent := Pprincipale;
          TousEmploye.Position.Y := 322;
        end;

      if Pprincipale.Width >= 782 then
        begin
          TousEmploye.Parent := Pprincipale.prinContainer;
        end;

    end;


end;



{
*************************************************
*************************************************
}

// gestion du filtre
procedure creationFiltreElement();
begin
    filtreElement := TfiltreElement.Create(TousEmploye);
end;

procedure creationFiltreInformation ();
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
    SetLength(tabFiltreInformation, tailleTab);

    for i := 0 to tailleTab-1 do
        begin
           filtreInformation := TfiltreElementInformation.Create(filtreElement);
           filtreInformation.Name := filtreInformation.Name + IntToStr(i);
           filtreInformation.texteFiltre.Text := informations[i];
           tabFiltreInformation[i] := filtreInformation;
        end;
end;



procedure ajoutFiltreInformation ();
var
   j : Integer;
begin
     creationFiltreInformation ();

  for j:= 0 to Length(tabFiltreInformation)-1 do
      begin
        tabFiltreInformation[j].Parent := filtreElement.body;
      end;

      filtreElement.Parent := TousEmploye.filtreClick;
end;


function valideFiltreEmploye () : TtabFiltreSelect;
begin
   Result := elementSect(tabFiltreInformation);
end;

procedure appaDispaFiltreEmploye ();
begin
  if toggleFiltre = False then
begin
 TousEmploye.filtreClick.Visible := True;
 TousEmploye.appaFiltre.Enabled := True;
 toggleFiltre := True;
end
else
  begin
    TousEmploye.filtreClick.Visible := False;
    toggleFiltre := False;
  end;
end;

{
*************************************************
*************************************************
}


end.

