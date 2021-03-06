unit logiqueConge;

interface
uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
FMX.Graphics, FMX.Objects, FMX.Dialogs, logiquePartager, FrEmployeMaquetteConge,
FrConge, FrCongeTopElement, logiqueFiltre, configFiltre;

// les types
type
    Conges = class (Tconge)
      private
       procedure appaFiltre (Sender : TObject);
      public
    end;

// Proc?dure g?n?rique


// Proc?dures cr?ation
  //Proc?dure d'initialisation
  procedure initialisationConge ();
procedure creeTopElementConge ();
procedure creeEmployeConges ();
procedure creeElementConge ();
procedure creeEnsembleElementsConge ();
procedure recupererDonneesConge ();

// Proc?dure d'ajout
procedure ajouterTopElementConge ();
procedure ajouterEnsembleElementsEmployeConge ();
procedure ajouterTousEmployeConge ();
procedure ajouterMargeEmployeConge ();
procedure ajouterEmployeConge ();

// Proc?dure de retrait
procedure retirerTopElementConge ();
procedure retirerTousElementEmployeConge ();
procedure retireConge ();
procedure retirerEnsembleElementEmployeConge ();

var
  topConge       : TcongeTopElement;
  UnEmployeConge      : TemployeMaquetteConge;
  LesEmployeConge     : array of TemployeMaquetteConge;
  elemenetPersonneConge : array of string;
  TousEmployeConge    : Conges;
  nombreEmployeConge  : Integer;
  // Cette variable permet de faire ? ce que le code sql ne soit pas ex?ct? + une fois
  sentinelleConge : Boolean;
  toogleFiltreElement : Boolean;

implementation

uses Principale, dmBasesDeDonnees;


 // Proc?dure de cr?ation
procedure initialisationConge ();
begin
  sentinelleConge := True;
end;





procedure creeEnsembleElementsConge ();
begin
   creeTopElementConge ();
   creeElementConge ();
   toogleFiltreElement := False;
end;

procedure creeTopElementConge ();
begin
  topConge := TcongeTopElement.Create(Pprincipale);
end;

procedure creeElementConge ();
begin
  TousEmployeConge := Conges.Create(Pprincipale);

  creerDataFiltre ();
  infoFiltre.concevoirData();

  creationConteneurFilter(TousEmployeConge);
  ajoutInformation( infoFiltre.getTabEntierValeur() );
  recevoirTablesChamps ( infoFiltre.getTabEnsembleTable(),
                      infoFiltre.getTabEnsembleChamp (), infoFiltre.getTableNiveau (),
                      infoFiltre.getTableDate() );
  conteneurFiltre.Parent := TousEmployeConge.conteneurFiltre;

  TousEmployeConge.Image1.OnClick := TousEmployeConge.appaFiltre;
  Pprincipale.Label7.Text := infoFiltre.getTabEnsembleTable()[0][0];
end;

procedure Conges.appaFiltre(Sender: TObject);
begin
  if toogleFiltreElement = False then
    begin
      TousEmployeConge.appaConteneurFiltre.Enabled := True;
      toogleFiltreElement := True;
    end
    else
     begin
       TousEmployeConge.dispConteneurFiltre.Enabled := True;
       toogleFiltreElement := False;
     end;
end;


procedure recupererDonneesConge ();
 var
  j : Integer;
  reqSql1, reqSql2 : string;
begin
  j := 0;
  nombreEmployeConge := 0;
  reqSql1 := 'SELECT nomEmp, prenomEmp FROM Employe';
  reqSql2 := 'SELECT count(*) FROM Employe';

  requeteSql(reqSql2);
   basesDeDonnees.FDQuery1.First;
   while not basesDeDonnees.FDQuery1.Eof do
    begin
      nombreEmployeConge := basesDeDonnees.FDQuery1.Fields[0].AsInteger;
      basesDeDonnees.FDQuery1.Next;
    end;


    // Le 2 repr?senter le nombre d'information ? r?cup?rer pour un employ?
    SetLength(elemenetPersonneConge, nombreEmployeConge * 2);


   requeteSql (reqSql1);
    basesDeDonnees.FDQuery1.First;
    while not basesDeDonnees.FDQuery1.Eof do
      begin
        elemenetPersonneConge[j] := basesDeDonnees.FDQuery1.FieldByName('nomEmp').AsString;
        j := j + 1;
        elemenetPersonneConge[j] := basesDeDonnees.FDQuery1.FieldByName('prenomEmp').AsString;
        j := j + 1;
        basesDeDonnees.FDQuery1.Next;
      end;

end;


procedure creeEmployeConges ();
var
   i,k : SmallInt;
begin
k := 0;

   if sentinelleConge = true then
    begin
      recupererDonneesConge ();
      sentinelleConge := False;
    end;

    SetLength(LesEmployeConge, nombreEmployeConge);
    for  i := 0 to nombreEmployeConge-1 do
         begin


            // Cr?ation de la frame puis renommer le name
            UnEmployeConge := TemployeMaquetteConge.Create(Pprincipale);
            UnEmployeConge.Name := UnEmployeConge.Name + inttostr(i);
            // Injection de donn?es dans la Frame
            UnEmployeConge.nomEmploye.Text := elemenetPersonneConge[k] + ' ' +
            elemenetPersonneConge[k+1];
            // 2 repr?sente le nombre d'informations ? prendre (nom et prenom)
            k := k + 2;
            // Stocker les frame dans le tableau pour l'affichage
            LesEmployeConge[i] := UnEmployeConge;
         end;
end;



// Proc?dure d'ajout

procedure ajouterEnsembleElementsEmployeConge ();
begin

  creeEnsembleElementsConge ();
  ajouterTopElementConge ();
  ajouterEmployeConge ();
end;


procedure ajouterTopElementConge ();
begin
  topConge.Parent := Pprincipale.containeTopElement;
  appaTopElementConge ();
  TopElementCongeAnim.Parent := topConge;
  TopElementCongeAnim.Enabled := true;
end;



procedure ajouterTousEmployeConge ();
  var
    j : Integer;
begin
  creeEmployeConges ();
  ajouterMargeEmployeConge ();

  for j:= 0 to Length(LesEmployeConge)-1 do
    begin
      LesEmployeConge[j].Parent := TousEmployeConge.VertScrollBox1;
    end;

end;


procedure ajouterEmployeConge ();
begin
      ajouterTousEmployeConge();


   TousEmployeConge.Parent := Pprincipale.prinContainer;
   appaTousEmployesConge();
   TousEmployeCongeAnim.Parent := TousEmployeConge;
   TousEmployeCongeAnim.Enabled := True;

end;


procedure ajouterMargeEmployeConge ();
begin
  // La taille du conteneur des employ?s
    TousEmployeConge.Height := TousEmployeConge.topListeEmploye.Height +
    TousEmployeConge.titreListeEmploye.Height + (UnEmployeConge.Height * nombreEmployeConge);

  // Taille de la verticalBox  du conteneur des employ?s
    TousEmployeConge.VertScrollBox1.Height := UnEmployeConge.Height * nombreEmployeConge ;

  // Taille du prinContainer
    Pprincipale.prinContainer.Height := TousEmployeConge.Height ;
end;


// Proc?dure de retrait

procedure retirerTopElementConge ();
begin
  topConge.Destroy;
end;

procedure retirerTousElementEmployeConge ();
begin
  TousEmployeConge.Destroy;
end;

procedure retireConge ();
begin
  TousEmployeConge.Parent := nil;
end;

procedure retirerEnsembleElementEmployeConge ();
begin
   retirerTopElementConge ();
   retirerTousElementEmployeConge ();
   Finalize(LesEmployeConge);
end;





end.
