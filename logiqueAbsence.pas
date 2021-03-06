unit logiqueAbsence;

interface
uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
FMX.Graphics, FMX.Objects, FMX.Dialogs, FrAbsenceTopElement, FrAbsence, FrEmployeMaquetteAbsence, logiquePartager;

//procedure de recuperation des donnees
procedure recupererDonneesAbs ();



//procedure de cr?ation
procedure initialisationAbsence();
procedure creeTopElementAbsence ();
procedure creeEmployeAbsence ();
procedure creeElementAbsence ();
procedure creeEnsembleElementsAbsence ();
//procedure recupererDonneesAbsence ();


var
sentinelleAbsence : boolean;
topElementAbsence : TabsenceTopElement;
conteneurAbsence : Tabsence;
elementEmployeAbsence : TemployeMaquetteAbsence;
nombreEmployeAbs : integer;
elemenetPersonneAbs : array of string;
// le tableau dynamique qui doit contenir l'ensemble de nos ?l?ments absence employ?s
tabEmployeAbsence : array of TemployeMaquetteAbsence;


implementation

uses Principale, dmBasesDeDonnees;
          //valeur de d?part
procedure initialisationAbsence();
begin
  sentinelleAbsence := true;
end;

procedure creeTopElementAbsence ();
begin
  topElementAbsence := TabsenceTopElement.create(Pprincipale);
end;

procedure creeEmployeAbsence ();
begin
  conteneurAbsence := Tabsence.Create(Pprincipale);
end;

procedure creeEnsembleElementsAbsence ();
begin
  creeTopElementAbsence ();
  creeEmployeAbsence ();
end;


procedure recupererDonneesAbs ();
var i : integer;
    reqSql1, reqSql2 : string;
begin
  i := 0;
  nombreEmployeAbs := 0;
  reqSql1 := 'SELECT idEmploye, nomEmp, prenomEmp FROM Employe'; //Pour avoir tous les employ?s
  reqSql2 := 'SELECT count(*) FROM Employe';                //Pour connaitre le nombre d'employ?s

  requeteSql(reqSql2);
  basesDeDonnees.FDQuery1.First;
   while not basesDeDonnees.FDQuery1.Eof do
    begin
      nombreEmployeAbs := basesDeDonnees.FDQuery1.Fields[0].AsInteger;    //Stocker le nombre d'employ?sAbs compt?s par reqSql2
      basesDeDonnees.FDQuery1.Next;
    end;
     // Le 3 repr?senter le nombre d'information ? r?cup?rer pour un employ?
     SetLength(elemenetPersonneAbs, nombreEmployeAbs * 3);    //Definir la taille du tableau (elementPersonneAbs) et sa taille

    requeteSql (reqSql1);
      basesDeDonnees.FDQuery1.First;
      while not basesDeDonnees.FDQuery1.Eof do
      begin
        elemenetPersonneAbs[i] := basesDeDonnees.FDQuery1.FieldByName('idEmploye').AsString;
        i := i + 1;
        elemenetPersonneAbs[i] := basesDeDonnees.FDQuery1.FieldByName('nomEmp').AsString;
        i := i + 1;
        elemenetPersonneAbs[i] := basesDeDonnees.FDQuery1.FieldByName('prenomEmp').AsString;
        i := i + 1;
        basesDeDonnees.FDQuery1.Next;
      end;

end;


procedure creeElementAbsence ();
var i : integer;
  begin
  if sentinelleAbsence = true then
    begin
      recupererDonneesAbs();
      sentinelleAbsence := false;
    end;

  SetLength(tabEmployeAbsence, nombreEmployeAbs);
    for i := 0 to (nombreEmployeAbs-1) do
      begin
        elementEmployeAbsence := TemployeMaquetteAbsence.Create(conteneurAbsence);
        elementEmployeAbsence.nomEmploye.Text :=  elemenetPersonneAbs[i+1] + ' ' +
        elemenetPersonneAbs[i+2];
        // Il faut stocker tout ce que nous avons fait avec cet ellement
        // sinon, il (elementEmployeAbsence) va se volatiliser et on aura que
        // la derni?re valeur de elementEmployeAbsence
        tabEmployeAbsence[i] := elementEmployeAbsence ;
      end;
  end;

// Les proc?dures d'ajout

 procedure ajouterEnsembleElementsAbs ();
begin
  creeEnsembleElementsAbsence ();
  creeTopElementAbsence();
end;



end.
