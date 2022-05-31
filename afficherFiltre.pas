unit afficherFiltre;

interface
uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
FMX.Graphics, FMX.Objects, FMX.Ani, FMX.StdCtrls, FMX.Dialogs, FrFiltreElementInformation,
FrFiltre, FrFiltreMaquette, logiquePartager, logiqueFiltre;

// Types


// Procedures

procedure affichageFiltre ();
procedure dialog (tableau : table);
  procedure creationFiltreMaquette (tab : table);
  procedure creationFiltre();
  procedure detruireFiltre ();
  procedure ajouterFiltre ();
  procedure retireFiltre ();
  procedure ajouterHauteur (taille : Single);
  function getIntervalle () : Boolean;
  function valeurBase (champBaseDonne : string) : string;


var
   filtre : Tfiltre;
   tabMaquetteFiltre : array of TfiltreMaquette;
   nombreLignes : Integer;
   intervalle : Boolean;

implementation
uses logiqueEmploye, varGlobale, Principale, dmBasesDeDonnees,
logiqueEvaluation, logiqueConge;

procedure affichageFiltre ();
begin
// La variable 'CheminActuel' vient de l'Unité VarGlobale (c'est d'ailleurs une
// mauvaise façon de faire, mais bon...)

if CheminAcutuel = 'Employés' then
   begin
       retireEmploye ();
       dialog (tabTexte);
   end;

if CheminAcutuel = 'Evaluations' then
   begin
       retireEmployeEval ();
       Dialog (tabTexte);
   end;

if CheminAcutuel = 'Congés' then
  begin
    retireConge ();
    Dialog (tabTexte);
  end;

end;

function getIntervalle () : Boolean;
begin
  Result := intervalle;
end;


// Cette procédure permet la création des éléments de filtre
procedure dialog (tableau : table);
begin
     // Gestion de la création et de la destruction du filtre
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


procedure creationFiltreMaquette (tab : table);
var
   maquetteFiltre : TfiltreMaquette;
//   titreFiltre : array [0..4] of TLabel;
   titreMaquette, titreFiltre : array [0..3] of TLabel;
   tailleFiltreMaquette : Single;
   i, j,k,l : Integer;
begin
     SetLength(tabMaquetteFiltre, 0);

     j := 0;
     titreFiltre[0] := filtre.Label1;
     titreFiltre[1] := filtre.Label2;
     titreFiltre[2] := filtre.Label3;
     titreFiltre[3] := filtre.Label4;


     // on ajoute les titre au niveau du filtre
     l := 0;
     for i:= 0 to Length(tab)-1 do
         begin
          if valeurBase (tab[i]) <> '' then
           begin
              titreFiltre[l].Text := tab[i];
              l:= l + 1;
           end;

         end;

      // Changer ça avec une nouvelle centre de base de données.
     requeteSqll(toutJointure);

     // Début de la lecture du result de la base de données
    basesDeDonnees.FDQuery2.First;
    while not basesDeDonnees.FDQuery2.Eof do
          begin
          k := 0;
             maquetteFiltre := TfiltreMaquette.Create(filtre);
             maquetteFiltre.Name := maquetteFiltre.Name + IntToStr(j);
             titreMaquette[0] := maquetteFiltre.Label1;
             titreMaquette[1] := maquetteFiltre.Label2;
             titreMaquette[2] := maquetteFiltre.Label3;
             titreMaquette[3] := maquetteFiltre.Label4;

             maquetteFiltre.nomEmploye.Text := basesDeDonnees.FDQuery2.FieldByName(dataTables[0][0 +dataChamps[0]]).AsString + ' ' +
             basesDeDonnees.FDQuery2.FieldByName(dataTables[0][1 +dataChamps[0]]).AsString;

             for i := 0 to Length(tab)-1 do
                 begin
                  if valeurBase (tab[i]) <> '' then
                   begin
                     titreMaquette[k].Text :=  basesDeDonnees.FDQuery2.
                      FieldByName( valeurBase (tab[i]) ).AsString;
                      k := k + 1;
                   end;

                 end;

             SetLength(tabMaquetteFiltre, Length(tabMaquetteFiltre)+1 );
             tabMaquetteFiltre[Length(tabMaquetteFiltre)-1] := maquetteFiltre;
             basesDeDonnees.FDQuery2.Next;
             j := j + 1;

          end;

         tailleFiltreMaquette := tabMaquetteFiltre[0].Height;
         ajouterHauteur (tailleFiltreMaquette);
end;

function valeurBase (champBaseDonne : string) : string;
var
    valeurRenvoie : string;
begin
valeurRenvoie := '';
     if (champBaseDonne <> dataTables[0][0]) and (champBaseDonne <> dataTables[0][1]) then
       begin
         valeurRenvoie := champsBase (champBaseDonne, 1);
       end;
       Result := valeurRenvoie;
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
  // La taille du conteneur des employés
    filtre.Height := filtre.topListeEmploye.Height +
    filtre.titreListeEmploye.Height + (taille * Length(tabMaquetteFiltre));

  // Taille de la verticalBox  du conteneur des employés
    filtre.VertScrollBox1.Height := taille * Length(tabMaquetteFiltre) ;
    Pprincipale.prinContainer.Height := filtre.VertScrollBox1.Height;
end;





end.
