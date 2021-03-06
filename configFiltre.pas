unit configFiltre;

interface
//uses
uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
FMX.Graphics, FMX.Objects, FMX.Ani, FMX.StdCtrls, FMX.Dialogs, logiqueFiltre;

//types


 // @table : array of string
 // @tableauTable : array of table
 type
    dataFiltre = class (TObject)
     procedure concevoirData ();
     function getTabEnsembleTable () : tableauTable;
     function getTabEntierValeur () : tableauTable;
     function getTabEnsembleChamp () : tableInt;
     function getTableNiveau () : tableInt;
     function getTableDate () : table;

      private
       tableEmploye : table;
       tabAdr : table;
       tabCom : table;
       tabEval : table;
       tabContrat : table;
       tabTypeCont : table;
       tabWil : table;

       tabEntier : table;
       tabValeur : table;

       nbChampEmploye, nbChampAdr, nbChampCom,
       nbChampEval, nbChampContrat,
       nbChampTypeCont, nbChampWil, tailleTable : integer;

       tabEnsembleTable : tableauTable;
       tabEntierString : tableauTable;
       tabEnsembleChamp : tableInt;
       tableNiveau : tableInt;
       tabDate : table;
      public

    end;

//procedure
procedure creerDataFiltre ();

//variables
var
   infoFiltre : dataFiltre;

implementation

procedure creerDataFiltre ();
begin
  infoFiltre := dataFiltre.Create;
end;

procedure dataFiltre.concevoirData();
begin
tailleTable := 7;
{ @4 : c'est le nombre de champs dont on a besoin pour une table.
  @(*2) : g?n?ralement les nom des champs dans la base de donn?es ne sont pas les m?mes que
  dans le programme, ce qui fait qu'avec les noms qui sont affich? ? l'ecran, on ne peut
  pas faire de requ?te sql, alors, on va faire une correspondance entre les noms ?
  affich? et ceux ? faire des requ?tes. Pour savoir les nom qui doivent ?tre affich?
  ? l'ecrant, il va falloir faire la (taille du tableau -2) + @1 /2 et pour les champs avec
  lesquels on fera nos requ?tes seront dans l'intervalle (taille - 2) + @1 /2 et (taille - 2)+@1.
  @2 : c'est la partie de configuration de la table. La premi?re position sera l'id de la
  de la table et la derni?re sera le nom de la table (la derni?re case du tableau).
  @1 : repr?sente d'eventuelles  cl?s ?trang?res, dans mon cas, il n'y a qu'une cl?
  ?trang?re, elle peut ?tre sup ? @1 (si elle (fk) n'exite pasmettez '0' ? la place).
  ** Pour partie la configuration (apr?s les champs visible et invisible), la premi?re
  position, c'est pour l'id de la table, la derni?re partie c'est pour le nom de la
  table et au mileu c'est pour les cl?s ?trang?re }
  nbChampEmploye := 4;
   SetLength(infoFiltre.tableEmploye, (infoFiltre.nbChampEmploye*2)+2+1);
   infoFiltre.tableEmploye[0] := 'nom';
   infoFiltre.tableEmploye[1] := 'prenom';
   infoFiltre.tableEmploye[2] := 'Date de Naissance';
   infoFiltre.tableEmploye[3] := 'Sex';
   infoFiltre.tableEmploye[4] := 'nomEmp';
   infoFiltre.tableEmploye[5] := 'preEmp';
   infoFiltre.tableEmploye[6] := 'ddn';
   infoFiltre.tableEmploye[7] := 'sexe';
   infoFiltre.tableEmploye[8] := 'idEmp';
   infoFiltre.tableEmploye[9] := 'idAdr';
   infoFiltre.tableEmploye[10] := 'EMPLOYE';

  infoFiltre.nbChampAdr := 2;
   SetLength(infoFiltre.tabAdr, (infoFiltre.nbChampAdr*2)+2+1);
   infoFiltre.tabAdr[0] := 'Habitation';
   infoFiltre.tabAdr[1] := 'N? Habitation';
   infoFiltre.tabAdr[2] := 'habitation';
   infoFiltre.tabAdr[3] := 'numHab';
   infoFiltre.tabAdr[4] := 'idAdr';
   infoFiltre.tabAdr[5] := 'idCom';
   infoFiltre.tabAdr[6] := 'ADRESSE';

  infoFiltre.nbChampCom := 1;
   SetLength(infoFiltre.tabCom, (infoFiltre.nbChampCom*2)+2+1);
   infoFiltre.tabCom[0] := 'Commune';
   infoFiltre.tabCom[1] := 'nomCom';
   infoFiltre.tabCom[2] := 'idCom';
   infoFiltre.tabCom[3] := 'idWilaya';
   infoFiltre.tabCom[4] := 'COMMUNE';

  infoFiltre.nbChampContrat := 2;
   SetLength(infoFiltre.tabContrat, (infoFiltre.nbChampContrat*2)+2+2);
   infoFiltre.tabContrat[0] := 'Salaire';
   infoFiltre.tabContrat[1] := 'Poste';
   infoFiltre.tabContrat[2] := 'salaire';
   infoFiltre.tabContrat[3] := 'poste';
   infoFiltre.tabContrat[4] := 'idCont';
   infoFiltre.tabContrat[5] := 'idEmp';
   infoFiltre.tabContrat[6] := 'idTpCont';
   infoFiltre.tabContrat[7] := 'CONTRAT';

  infoFiltre.nbChampEval := 2;
   SetLength(infoFiltre.tabEval, (infoFiltre.nbChampEval*2)+2+1);
   infoFiltre.tabEval[0] := 'Ponctualit?';
   infoFiltre.tabEval[1] := 'Comp?tance';
   infoFiltre.tabEval[2] := 'ponctualite';
   infoFiltre.tabEval[3] := 'competance';
   infoFiltre.tabEval[4] := 'idEval';
   infoFiltre.tabEval[5] := 'idEmp';
   infoFiltre.tabEval[6] := 'EVAL';

  infoFiltre.nbChampTypeCont := 1;
   SetLength(infoFiltre.tabTypeCont,  (infoFiltre.nbChampTypeCont*2)+2+1);
   infoFiltre.tabTypeCont[0] := 'Type de Contrat';
   infoFiltre.tabTypeCont[1] := 'typeContrat';
   infoFiltre.tabTypeCont[2] := 'idTpCont';
   infoFiltre.tabTypeCont[3] := '0';
   infoFiltre.tabTypeCont[4] := 'TYPE_CONTRAT';

  infoFiltre.nbChampWil := 1;
   SetLength(tabWil, (nbChampWil * 2) + 2 + 1);
   SetLength(infoFiltre.tabTypeCont,  (infoFiltre.nbChampTypeCont*2)+2+1);
   infoFiltre.tabWil[0] := 'Wilaya';
   infoFiltre.tabWil[1] := 'nomWilaya';
   infoFiltre.tabWil[2] := 'idWilaya';
   infoFiltre.tabWil[3] := '0';
   infoFiltre.tabWil[4] := 'WILYA';

   SetLength(tableNiveau, tailleTable);
   infoFiltre.tableNiveau[0] := 0;
   infoFiltre.tableNiveau[1] := 1;
   infoFiltre.tableNiveau[2] := 2;
   infoFiltre.tableNiveau[3] := 1;
   infoFiltre.tableNiveau[4] := 1;
   infoFiltre.tableNiveau[5] := 2;
   infoFiltre.tableNiveau[6] := 3;

   SetLength(infoFiltre.tabEnsembleTable, tailleTable);
   infoFiltre.tabEnsembleTable[0] := infoFiltre.tableEmploye;
   infoFiltre.tabEnsembleTable[1] := infoFiltre.tabAdr;
   infoFiltre.tabEnsembleTable[2] := infoFiltre.tabCom;
   infoFiltre.tabEnsembleTable[3] := infoFiltre.tabContrat;
   infoFiltre.tabEnsembleTable[4] := infoFiltre.tabEval;
   infoFiltre.tabEnsembleTable[5] := infoFiltre.tabTypeCont;
   infoFiltre.tabEnsembleTable[6] := infoFiltre.tabWil;

   SetLength(infoFiltre.tabEnsembleChamp, tailleTable);
   infoFiltre.tabEnsembleChamp[0] := infoFiltre.nbChampEmploye ;
   infoFiltre.tabEnsembleChamp[1] := infoFiltre.nbChampAdr ;
   infoFiltre.tabEnsembleChamp[2] := infoFiltre.nbChampCom ;
   infoFiltre.tabEnsembleChamp[3] := infoFiltre.nbChampContrat ;
   infoFiltre.tabEnsembleChamp[4] := infoFiltre.nbChampEval ;
   infoFiltre.tabEnsembleChamp[5] := infoFiltre.nbChampTypeCont ;
   infoFiltre.tabEnsembleChamp[6] := infoFiltre.nbChampWil ;

   SetLength(infoFiltre.tabEntier, 4);
   infoFiltre.tabEntier[0] := infoFiltre.tableEmploye[2];
   infoFiltre.tabEntier[1] := infoFiltre.tabContrat[0];
   infoFiltre.tabEntier[2] := infoFiltre.tabEval[0];
   infoFiltre.tabEntier[3] := infoFiltre.tabEval[1];

  SetLength(tabDate, 1);
   tabDate[0] := infoFiltre.tableEmploye[2];

   SetLength(infoFiltre.tabValeur, 9);
   infoFiltre.tabValeur[0] := infoFiltre.tableEmploye[0];
   infoFiltre.tabValeur[1] := infoFiltre.tableEmploye[1];
   infoFiltre.tabValeur[2] := infoFiltre.tableEmploye[3];
   infoFiltre.tabValeur[3] := infoFiltre.tabAdr[0];
   infoFiltre.tabValeur[4] := infoFiltre.tabAdr[1];
   infoFiltre.tabValeur[5] := infoFiltre.tabCom[0];
   infoFiltre.tabValeur[6] := infoFiltre.tabContrat[1];
   infoFiltre.tabValeur[7] := infoFiltre.tabTypeCont[0];
   infoFiltre.tabValeur[8] := infoFiltre.tabWil[0];

   SetLength(infoFiltre.tabEntierString, 2);
   infoFiltre.tabEntierString[0] := infoFiltre.tabEntier;
   infoFiltre.tabEntierString[1] := infoFiltre.tabValeur;


end;

function dataFiltre.getTabEnsembleTable() : tableauTable;
begin
  Result := tabEnsembleTable;
end;

function dataFiltre.getTabEntierValeur() : tableauTable;
begin
  Result := tabEntierString;
end;

function dataFiltre.getTabEnsembleChamp () : tableInt;
begin
  Result := tabEnsembleChamp;
end;

function dataFiltre.getTableNiveau () : tableInt;
begin
  Result := tableNiveau;
end;

function dataFiltre.getTableDate() : table;
begin
  Result := tabDate;
end;

end.
