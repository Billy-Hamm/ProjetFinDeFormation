unit logiqueFiltre;

interface

uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
FMX.Graphics, FMX.Objects, FMX.Ani, FMX.StdCtrls, FMX.Dialogs, System.Generics.Collections,
FrElementListCrit,FrEntierIntervalle, FrRechMC, FMX.types, FMX.Edit, FMX.Layouts,FMX.ListBox;

// L'ensemble des types
type
    postionEdit = array [0..1] of Single;

    table = array of string;
    tableInt = array of integer;
    tableauTable = array of table;

    FiltreRech = class (TRechMC)
     procedure tableauInformationCritere ( dataEntierString : tableauTable );
     private
      procedure apparitionDesCritere(Sender : TObject);
      procedure validationRecherche(Sender : TObject);
     public
    end;

    Critere = Class (TelementlisteCrit)
     private
       procedure clicSurCritere (Sender : TObject);
     public

    End;

    EntiersValeurs = Class (TentierIntervalle)
      private
      procedure detruireElement(Sender : TObject);
      public
    End;


// Toutes les proc?dures de classes

{ @ComposantProprio c'es le composant propri?taire que l'on va passer en param?tre
lorsqu'on va appeler cette procedure. }
procedure creationConteneurFilter (ComposantProprio : TComponent);
procedure ajoutInformation (information : tableauTable);
procedure creationCritere ();
procedure creationEnsembleCritere();
procedure viderChamps (index : integer );
procedure recupererLesChamps ();

procedure ConcevoirJointure ( allData : tableauTable; champsVisible : tableInt );

procedure recevoirTablesChamps (tables : tableauTable; champs, niveau : tableInt;
          tabDates : table);

function checkValueInArray (value : string; tab : table) : Boolean;

{ Recup?re le texte qui se trouve sur le bouton sur lequel on a cliqu? }
function donnerTextBoutonCliquer( bouton : TRectangle ) : String;

{ On cr?e la frame qui va permttre de mettre ?l?ment de recherche. }
procedure  creerEntierValeur (texte : string; index : integer);
{ @tabPosition est un tableau qui aura une taille de deux, la position 0 sera la
l'affichage des edits de entier et la position 1 sera l'affichage des valeurString  }
procedure entierValeur(nomCrit : string; tabPosition : postionEdit; indice : integer);

{ pour afficher dans le conteneurFilter.conteneurCritere }
procedure ajouterConteneurCritere();

procedure afficherElementSaisi(texteCritere : string);

procedure ajoutElementSaisiDansConteneur ();

function jointureDirect (jointureHeader : string) : String;

function jointureIndirect (indexTable : integer) : string;

procedure ajoutValeurDansTableJointure (tempJoin : string);

function dernierNiveauJoin ( indexTableau : integer) : string;

{ nbChamp va recevoir deux valeur, soit 1 soit 2: 1 c'est pour revoyer juste la cor-
respondance base de donn?e de la chaine qui lui est donn?e, mais 2 c'est pour
revoyer le nom de la table '.' la correspondance base de donn?es "Employe.idEmp" }
function champsBase (champ : string; nbChamp : integer) : string;

function trouverLaConditionText(posTable : integer) : string;

function trouverLaConditionEdit(posTable : integer) : string;

function renvoiSigne (comboB : TComboBox) : string;

procedure conditionJointure () ;

function construireCondition () : string;



// Toutes les variables
var
   { Permet de toujours distinguer les names des ?l?ments de saisi }
   incChampSaisi : integer;
   { c'est le FrRechMC }
   conteneurFiltre : FiltreRech;
   { c'est le FrElementlisteCrit. Dans ce frame on trouve aussi la frame ValeurCritere }
   ElementCritere : Critere;
   { Ce tableau va concatener les ?l?ments de intervalleCritere (les 2 edits) et
   et les ?l?ment de valeurCritere }
   tabEnsembleCritere : array of string;
   { tableau contenant uniquement les ?l?ments de IntervalleCritere et ValeurCritere }
   tabEntier, tabValeur : array of string;
   { tableau contenant tous les ?l?ments de FrElementListCrit }
   tabElementCritere : array of Critere;
   { Pour g?rer l'apparition et la disparition du contenru des crit?res. }
   toogleAppaCritere : Boolean ;
   tabEntierValeur : array of  EntiersValeurs;
   nombreCritere : integer;
   { le texte des champs de crit?re visible (frEntierIntervalle) }
   tabTexte : table;
   dataTables : tableauTable;
   dataChamps, dataNiveau : tableInt;
   dataDates : table;

   enteteJointure : string;

   tabPartielData : table;

   tableJointure : table;

   tabConditions : table;

   toutJointure : string;


   { Note : Je cr?e tabEnsembleCritere, tabEntier et tabValeur pour pouvoir distinguer
   le nombre d'edit que je vais faire sortir, par exemple s'il faut chercher un poste,
   je ne suis pas oblig? de sorter deux edits, un seul suffira pour.
   - Alors ce que je fais, dans une procedure que je vais cr?er, je passerai
   un element du tableau tabEnsembleCritere et si ce dernier se trouve dans un des
   tableaux la g?n?ration des edits se fera en fonction. }

implementation
uses afficherFiltre;

procedure creationConteneurFilter (ComposantProprio : TComponent);
begin
nombreCritere := 1;
toogleAppaCritere := False;
  conteneurFiltre := FiltreRech.Create(ComposantProprio);
  conteneurFiltre.btnCritere.OnClick := conteneurFiltre.apparitionDesCritere;
  conteneurFiltre.btnValidation.OnClick := conteneurFiltre.validationRecherche;
end;

procedure ajoutInformation (information : tableauTable);
begin
  conteneurFiltre.tableauInformationCritere(information);
  creationEnsembleCritere();
  ajoutElementSaisiDansConteneur ();
  creationCritere ();
end;


procedure FiltreRech.apparitionDesCritere(Sender: TObject);
begin
  if toogleAppaCritere = False then
    begin
      appaHauteur.Enabled := True;
      toogleAppaCritere := True;
    end
    else
     begin
       dispHauteur.Enabled := True;
       toogleAppaCritere := False;
     end;

end;


procedure FiltreRech.tableauInformationCritere( dataEntierString : tableauTable );
var
   tailleTotal, i, j, k, l : integer;
begin
     j := 0;
// Initilisation des tableaux
  SetLength(tabEntier, Length(dataEntierString[0]) );
  SetLength(tabValeur, Length(dataEntierString[1]) );
  tailleTotal := Length(tabEntier) + Length(tabValeur);
  SetLength(tabEnsembleCritere, tailleTotal);

  for k := 0 to Length(dataEntierString[0])-1 do
      tabEntier[k] := dataEntierString[0][k];

  for l := 0 to Length(dataEntierString[1])-1 do
      tabValeur[l] := dataEntierString[1][l];


  for i := 0 to Length(tabEnsembleCritere)-1 do
    begin
      if i <= Length(tabEntier)-1 then
        begin
          tabEnsembleCritere[i] := tabEntier[i];
        end
        else
          begin
            tabEnsembleCritere[i] := tabValeur[j];
            j := j + 1;
          end;
    end;

end;

procedure creationCritere ();
var
   i : integer;
begin
 SetLength(tabElementCritere, Length(tabEnsembleCritere));
  For i := 0 to Length(tabEnsembleCritere)-1 do
    begin
      ElementCritere := Critere.Create(conteneurFiltre);
      ElementCritere.Name := ElementCritere.Name + IntToStr(i);
      ElementCritere.nomCritere.Text := tabEnsembleCritere[i];
      ElementCritere.rectElementCrit.OnClick := ElementCritere.clicSurCritere;
      tabElementCritere[i] := ElementCritere;
    end;
    // Il doit y avoir une fontion d'ajout des ?l?ments de crit?re ici
    ajouterConteneurCritere();
end;


procedure ajouterConteneurCritere();
var i : integer;
begin
  for i := 0 to Length(tabElementCritere)-1 do
    begin
      tabElementCritere[i].Parent := conteneurFiltre.conteneurCritere;
    end;
end;



procedure Critere.clicSurCritere(Sender: TObject);
begin
{ @4 repr?sente le nombre de champs disponible sur la frame filtre, grosso modo, c'est
le nombre de maximal de crit?re pour une recherche. }
     if nombreCritere <= 4 then
       begin
         afficherElementSaisi ( donnerTextBoutonCliquer ( (Sender as TRectangle) ) );
       end;


end;


procedure afficherElementSaisi(texteCritere : string);
var i : integer;
begin
     for i:= 0 to Length(tabEntierValeur)-1 do
       begin
         if (tabEntierValeur[i].libelleCritere.Text = texteCritere) and
         (tabEntierValeur[i].Visible = False) then
           begin
             tabEntierValeur[i].Align := TAlignLayout.Bottom;
             tabEntierValeur[i].Visible := True;
             tabEntierValeur[i].Align := TAlignLayout.Top;
             nombreCritere := nombreCritere + 1;
           end;
       end;
end;



function donnerTextBoutonCliquer( bouton : TRectangle ) : String;
var i : integer;
begin
  for i := 0 to (bouton.Controls.Count)-1 do
      if bouton.Controls[i] is TLabel then
         Result := (bouton.Controls[i] as TLabel).Text;
end;


procedure creationEnsembleCritere();
var
   i : integer;
begin
     for i := 0 to Length(tabEnsembleCritere)-1 do
       begin
          creerEntierValeur(tabEnsembleCritere[i], i);
       end;
end;



procedure  creerEntierValeur (texte : string; index : integer);
var i : integer;
    tabPos : postionEdit;
begin

      for i := 0 to Length(tabEnsembleCritere)-1 do
        begin
          if i <= Length(tabEntier)-1 then
            begin
              if tabEntier[i] = texte then
                begin
                  // On va avoir notre fonction de cr?ation ici
                  tabPos[0] := 145; tabPos[1] := 432;
                  entierValeur( texte, tabPos, index );
                  break;
                end;
            end
            else
              begin
              tabPos[0] := 432; tabPos[1] := 145;
                entierValeur( texte, tabPos, index );
                Break;
              end;
        end;

end;


procedure entierValeur(nomCrit : string; tabPosition : postionEdit; indice : integer);
var
   elementSaisi : EntiersValeurs;
begin
 SetLength(tabEntierValeur, Length(tabEnsembleCritere) );
     incChampSaisi := incChampSaisi + 1;
     elementSaisi := EntiersValeurs.Create(conteneurFiltre);
     elementSaisi.Name := elementSaisi.Name + IntToStr(incChampSaisi);

     with elementSaisi do
      begin
        libelleCritere.Text := nomCrit;
        containerIntervalle.Position.X := tabPosition[0];
        RectCritStr.Position.X := tabPosition[1];
        Visible := False;
        btnDestroy.OnClick :=  detruireElement;
      end;

     tabEntierValeur[indice] := elementSaisi;
end;


procedure ajoutElementSaisiDansConteneur ();
var i : integer;
begin
     for i := 0 to Length(tabEntierValeur)-1 do
       begin
         tabEntierValeur[i].Parent := conteneurFiltre.conteneurSaisiCritere;
       end;

end;



procedure EntiersValeurs.detruireElement(Sender: TObject);
var
   nameParent : string;
   i : integer;
begin

  nameParent := (Sender as TCircle).GetParentComponent.Name;

  for i := 0 to Length(tabEntierValeur)-1 do
    begin
      if tabEntierValeur[i].Name = nameParent then
        begin
          tabEntierValeur[i].Visible := False;
          viderChamps(i);
          nombreCritere := nombreCritere - 1 ;
        end;
    end;

end;

procedure viderChamps (index : integer );
var
   i,j : integer;
begin

   for i := 0 to tabEntierValeur[index].Controls.Count - 1 do
     begin
       if (tabEntierValeur[index].Controls[i] is Tlayout) then
         begin
           for j := 0 to tabEntierValeur[index].Controls[i].Controls.Count -1 do
             begin
               if tabEntierValeur[index].Controls[i].Controls[j] is TRectangle then
                 begin
                   (tabEntierValeur[index].Controls[i].Controls[j].Controls[0] as TEdit).
                   Text := '';
                 end;

             end;
         end;

       if tabEntierValeur[index].Controls[i] is TRectangle then
         begin
            (tabEntierValeur[index].Controls[i].Controls[0] as Tedit).Text := '';
         end;
     end;

end;


procedure FiltreRech.validationRecherche(Sender: TObject);
begin
     Finalize(tableJointure);
     recupererLesChamps ();
     affichageFiltre ();
end;


procedure recevoirTablesChamps (tables : tableauTable; champs, niveau : tableInt;
          tabDates : table);
begin
  dataTables := tables;
  dataChamps := champs;
  dataNiveau := niveau;
  dataDates := tabDates;
end;


procedure recupererLesChamps ();
var
   i, j : integer;

begin
  j := 0;
   if nombreCritere-1 = 0 then
   begin
     ShowMessage('Choisissez les crit?re de recherche');
   end
   else
    begin
    SetLength(tabTexte, nombreCritere-1);
     for i := 0 to Length(tabEntierValeur) - 1 do
       begin
         if tabEntierValeur[i].Visible = True then
            begin
              tabTexte[j] := tabEntierValeur[i].libelleCritere.Text;
              j := j + 1;
            end;
       end;

        ConcevoirJointure(dataTables, dataChamps);

    end;

end;


procedure ConcevoirJointure ( allData : tableauTable; champsVisible : tableInt );
var
   i, j, k, agm: integer;
   selectionChamps, nom, prenom,nomBase, prenomBase, tablePrincipale: string;
begin
  selectionChamps := '';
  enteteJointure := '';
  agm := 1;
  nom := allData[0][0];
  prenom := allData[0][1];
  nomBase := allData[0][0 + dataChamps[0]];
  prenomBase := allData[0][1 + dataChamps[0]];
  tablePrincipale := allData[0][ Length(allData[0])-1 ];
  Finalize(tabPartielData);
  SetLength(tabPartielData, agm);
  tabPartielData[0] := tablePrincipale;

  for k := 0 to Length(tabTexte)-1 do
   begin
    for i := 0 to Length(allData)-1 do
      begin
        for j := 0 to champsVisible[i]-1 do
          begin
            if allData[i][j] = tabTexte[k] then
              begin
                if (tabTexte[k] <> nom) and (tabTexte[k] <> prenom) then
                  begin
                    selectionChamps := selectionChamps+ ' , ' + allData[i][ Length(allData[i])-1 ]
                    + '.' + allData[i][ j + champsVisible[i] ];

                    if checkValueInArray(allData[i][ Length(allData[i])-1 ], tabPartielData) = False then
                       begin
                         SetLength(tabPartielData, agm + 1);
                         tabPartielData[ agm ] := allData[i][ Length(allData[i])-1 ];
                         agm := agm + 1 ;
                       end;

                  end;
              end;

          end;
      end;
   end;

    enteteJointure := 'SELECT ' + tablePrincipale + '.' + nomBase +' , ' + tablePrincipale +
                   '.' + prenomBase + selectionChamps + ' FROM ' + tablePrincipale;
                   // ex?cuter conditionJointure ()
                       conditionJointure ();
                   // Ex?cuter jointureDierect puis construireCondition
                       toutJointure := jointureDirect(enteteJointure) + construireCondition ();
                       ShowMessage( toutJointure );
//                       for l :=0 to Length(tabTexte)-1 do
//                        ShowMessage(tabTexte[l]);
end;


function checkValueInArray (value : string; tab : table) : Boolean;
var l : integer;
    val : Boolean;
begin
val := False;
  for l := 0 to Length(tab)-1 do
    begin
       if tab[l] = value then
         begin
          val := True;
          break;
         end;

    end;

   Result := val;

end;


function jointureDirect (jointureHeader : string) : String;
var join, table1, table2, lien : string;
    i,j,k,l,m,n, o,agm, indiceTable, increment : integer;
    tabIndiceTable : tableInt;
    secTour : Boolean;
    preTour : Boolean;
begin
indiceTable := 0;
increment := 1;
agm := 1;
secTour := False;
SetLength(tabIndiceTable, increment);
table1 := dataTables[0][ Length(dataTables[0]) -1 ];
join := '';


  for i := 1 to Length(tabPartielData) - 1 do
    begin
     preTour := False;
      for j := 0 to Length(dataTables) - 1 do
        begin
          if tabPartielData[i] = dataTables[j][ Length(dataTables[j])-1 ] then
            begin
             indiceTable := j;
             break;
            end;

        end;

      for k := (dataChamps[0] * 2) to Length(dataTables[0])- 2 do
        begin

          for l := (dataChamps[indiceTable] * 2) to Length(dataTables[indiceTable]) -2 do
            begin
               if dataTables[0][k] = dataTables[indiceTable][l] then
                 begin
                  SetLength(tableJointure, agm);
                   lien := dataTables[0][k];
                   table2 := dataTables[indiceTable][ Length(dataTables[indiceTable]) - 1] ;
                   tableJointure[agm-1] := ' JOIN ' +  table2 + ' ON ' + table2 + '.' + lien + ' = '
                   + table1 + '.' + lien;
                   preTour := True;
                   agm := agm + 1 ;
                 end;

            end;

        end;

      if preTour = False then
        begin
          SetLength(tabIndiceTable, increment);
          tabIndiceTable[increment-1] := indiceTable;
          increment := increment + 1;
          secTour := True;
        end;

    end;

    for m:=0 to Length(tableJointure)-1 do
     begin

       join := join + tableJointure[m];
     end;

    if secTour = True then
      begin
      for n:=0 to Length(tabIndiceTable)-1 do
       begin
         o := 25;
         join := join + jointureIndirect (tabIndiceTable[n]);
       end;
      end;

    Result := jointureHeader + join;
end;


function jointureIndirect (indexTable : integer) : string;
var i,j,k,l,m,n,o : integer;
    jointure, jointureConf, table2, table1, lien : string;
    arret, nivSup : Boolean;
begin
 arret := False;
 nivSup := False;


         for k := 0 to Length(dataTables) - 1 do
           begin
            if indexTable <> k then
             begin
              for j := (dataChamps[ indexTable ] * 2) to Length(dataTables[ indexTable ])- 2 do
                 begin

                   for l := (dataChamps[k] * 2) to Length(dataTables[k]) - 2 do
                     begin

                       if dataTables[indexTable][j] = dataTables[k][l] then
                         begin
                           table2 := dataTables[indexTable][Length(dataTables[indexTable]) -1 ];
                           table1 := dataTables[k][ Length(dataTables[k]) - 1];
                           lien := dataTables[indexTable][j];
                           jointureConf := ' JOIN ' + table2 + ' ON ' + table2 + '.' + lien + ' = '
                                + table1 + '.' + lien;

                            if checkValueInArray(jointureConf, tableJointure) = False then
                              begin
                                ajoutValeurDansTableJointure(jointureConf);
                                jointure := jointureConf ;
                              end;

                           if dataNiveau[indexTable] = 3 then
                             begin
                                nivSup := True;
                             end;

                           for m := 0 to Length(dataTables) - 1 do
                             begin
                               if k <> m then
                                 begin
                                    for n := (dataChamps[k] * 2) to Length(dataTables[k]) - 2 do
                                      begin
                                        for o := (dataChamps[m] * 2) to Length(dataTables[m]) - 2 do
                                          begin
                                            if dataTables[k][n] = dataTables[m][o] then
                                              begin


                                                table2 := dataTables[k][Length(dataTables[k]) - 1];
                                                table1 := dataTables[m][Length(dataTables[m]) - 1];
                                                lien := dataTables[k][n];
                                                jointureConf := ' JOIN ' + table2 + ' ON ' + table2 + '.' + lien + ' = '
                                                         + table1 + '.' + lien;
                                                  if checkValueInArray(jointureConf, tableJointure) = False then
                                                  begin
                                                  ajoutValeurDansTableJointure(jointureConf);
                                                    jointure := jointureConf + jointure ;
                                                  end;

                                                  if nivSup = True then
                                                    begin
                                                      if checkValueInArray(
                                                      dernierNiveauJoin(m), tableJointure ) = False then
                                                       begin

                                                         jointure := dernierNiveauJoin(m)
                                                         + jointure;
                                                       end;
                                                    end;

                                                         arret := True;

                                              end;
                                               if arret = True then
                                                            break;
                                          end;
                                          if arret = True then
                                             break;
                                      end;
                                      if arret = True then
                                             break;
                                 end;
                                 if arret = True then
                                             break;
                             end;
                              if arret = True then
                                             break;
                         end;
                           if arret = True then
                                             break;
                     end;
                       if arret = True then
                                             break;
                 end;
                  if arret = True then
                                             break;
             end;
             if arret = True then
                                             break;
           end;



       Result := jointure;
end;

procedure ajoutValeurDansTableJointure (tempJoin : string);

begin
if Length(tableJointure) = 0 then
begin
   SetLength(tableJointure, 1);
   tableJointure[ Length(tableJointure) - 1 ] := tempJoin;
end
   else
   begin
      SetLength(tableJointure, Length(tableJointure) + 1 );
      tableJointure[ Length(tableJointure ) - 1 ] := tempJoin;
   end;



end;

function dernierNiveauJoin ( indexTableau : integer) : string;
var k, l : integer;
    lien, table1, table2, joinFinal: string;
begin
table1 := dataTables[0][ Length(dataTables[0]) -1 ];
     for k := (dataChamps[0] * 2) to Length(dataTables[0])- 2 do
        begin

          for l := (dataChamps[indexTableau] * 2) to Length(dataTables[indexTableau]) -2 do
            begin
               if dataTables[0][k] = dataTables[indexTableau][l] then
                 begin
                   lien := dataTables[0][k];
                   table2 := dataTables[indexTableau][ Length(dataTables[indexTableau]) - 1] ;
                   joinFinal := ' JOIN ' +  table2 + ' ON ' + table2 + '.' + lien + ' = '
                   + table1 + '.' + lien;
                   break;
                 end;

            end;

        end;
       Result := joinFinal;
end;


procedure conditionJointure () ;
var i,j : integer;

begin
 SetLength(tabConditions, 0);
  for j := 0 to Length(tabEntierValeur) - 1 do
   begin
    if tabEntierValeur[j].Visible = True then
     begin
      for i := 0 to Length(tabEnsembleCritere)-1 do
        begin
          if i <= Length(tabEntier)-1 then
            begin
              if tabEntier[i] = tabEntierValeur[j].libelleCritere.Text then
                begin
                   if trouverLaConditionEdit (j) <> '' then
                     begin
                       SetLength(tabConditions, Length(tabConditions)+1 );
                       tabConditions[  Length(tabConditions)-1 ] := trouverLaConditionEdit (j);
                     end;
                  break;
                end;
            end
            else
              begin
                 if trouverLaConditionText(j) <> '' then
                     begin
                       SetLength(tabConditions, Length(tabConditions)+1 );
                       tabConditions[  Length(tabConditions)-1 ] := trouverLaConditionText(j);
                     end;
                Break;
              end;
        end;
     end;
   end;

end;

function trouverLaConditionEdit(posTable : integer) : string;
var vide,i,j, lay, combo : integer;
    tabEdit : array of Tedit;
    table1, table2, signe, condition : string;
begin
vide := 0; lay := 0; combo := 0;
condition := ''; table1 := ''; table2 := ''; signe := '';

   for i := 0 to tabEntierValeur[posTable].Controls.Count - 1 do
     begin
       if (tabEntierValeur[posTable].Controls[i] is Tlayout) then
         begin
           for j := 0 to tabEntierValeur[posTable].Controls[i].Controls.Count -1 do
             begin
               if (tabEntierValeur[posTable].Controls[i].Controls[j] is TComboBox) then
                 begin
                   lay := i; combo := j;
                 end;

               if tabEntierValeur[posTable].Controls[i].Controls[j] is TRectangle then
                 begin
                  if (tabEntierValeur[posTable].Controls[i].Controls[j].Controls[0] as TEdit).
                   Text <> '' then
                    begin
                    SetLength(tabEdit, vide+1);
                     tabEdit [vide] := (tabEntierValeur[posTable].Controls[i].Controls[j]
                     .Controls[0] as TEdit);
                      vide := vide + 1;
                    end;
                 end;

             end;
         end;


     end;

     if Length(tabEdit) > 0 then
       begin
         if Length(tabEdit) > 1 then
           begin
            if checkValueInArray(tabEntierValeur[posTable].libelleCritere.Text,
               dataDates) = True then
               begin
                 table1 := 'LTRIM('+ '''' + tabEdit[0].Text + '''' + ')';
                 table2 := 'LTRIM('+ '''' +  tabEdit[1].Text  + '''' + ')';
               end
               else
                begin
                  table1 := 'LTRIM('+ tabEdit[0].Text + ')';
                  table2 := 'LTRIM('+ tabEdit[1].Text + ')';
                end;

              condition := champsBase(tabEntierValeur[posTable].libelleCritere.Text, 2) +
              ' BETWEEN ' + table1 + ' AND ' +  table2;
           end
           else
             begin
              if checkValueInArray(tabEntierValeur[posTable].libelleCritere.Text,
               dataDates) = True then
               begin
                 table1 :='LTRIM('+  '''' + tabEdit[0].Text + '''' + ')';
               end
               else
                begin
                  table1 := 'LTRIM('+ tabEdit[0].Text + ')';
                end;
              signe := renvoiSigne ( (tabEntierValeur[posTable].Controls[lay].Controls[combo]  as TComboBox) );
              condition := champsBase(tabEntierValeur[posTable].libelleCritere.Text, 2) +
              ' ' + signe + ' ' +  table1;
             end;
       end;
       Result := condition;
end;


function trouverLaConditionText(posTable : integer) : string;
var i : integer;
   texteCond, condition : string;
begin
condition := '';
   for i := 0 to tabEntierValeur[posTable].Controls.Count - 1 do
     begin
        if tabEntierValeur[posTable].Controls[i] is TRectangle then
         begin
           texteCond := (tabEntierValeur[posTable].Controls[i].Controls[0] as Tedit).Text;
         end;
     end;

     if texteCond <> '' then
        condition := champsBase(tabEntierValeur[posTable].libelleCritere.Text, 2) +
               ' = ' + 'LTRIM('+  '''' + texteCond + '''' + ')';

     Result := condition;

end;


function champsBase (champ : string; nbChamp : integer) : string;
var i,j : integer;
    valeurBase, valeurSimple : string;
    arret : Boolean;
begin
arret := False;
valeurBase := ''; valeurSimple := '';
    for i := 0 to Length(dataTables)-1 do
     begin
       for j := 0 to dataChamps[i] - 1 do
         begin
           if champ = dataTables[i][j] then
            begin
              valeurBase := dataTables[i][j + dataChamps[i]];
              valeurSimple := valeurBase;
              valeurBase := dataTables[i][ Length(dataTables[i])-1 ] + '.' +
              valeurBase;
              arret := True;
               break;
            end;
         end;
         if arret = True then
          break;
     end;

     if nbChamp = 1 then
      Result := valeurSimple
      else
       Result := valeurBase;
end;

function renvoiSigne (comboB : TComboBox) : string;
var signeCombo : string;
begin
if comboB.ItemIndex <> - 1 then
   signeCombo := comboB.Items[comboB.ItemIndex]
  else
   signeCombo := ' = ';
  Result := signeCombo;

end;


function construireCondition () : string;
var i : integer;
    conditionConstuit : string;
begin
conditionConstuit := '';
  if Length(tabConditions) > 0 then
    begin
      for i := 0 to Length(tabConditions)-1 do
      begin
       if i = 0 then
        conditionConstuit := '  WHERE ' + '( '+ tabConditions[i] + ' )'
       else
        conditionConstuit := conditionConstuit + ' AND ' + '( ' + tabConditions[i] + ' )';
      end;
    end;
    Result := conditionConstuit;
end;



end.
