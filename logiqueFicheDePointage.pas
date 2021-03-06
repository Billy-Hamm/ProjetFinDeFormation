unit logiqueFicheDePointage;

interface

uses System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
FMX.Graphics, FMX.Objects, FMX.Ani,  FMX.Dialogs, Data.DB, Data.Win.ADODB,
FrTopElementFichePointage,FrFicheDePointage, dmBasesDeDonnees, logiquePartager,
FrEmployeMaquetteFdp;

//types
type
    FicheDePointageHerite = class (TficheDePointage)

      private
       procedure clicValidationFdp (Sender : TObject);
//       procedure clicValidationHeureSupFpd (Sender : TObject);
      public

    end;

// Procedures et fonctions
  //procedure g?n?rique
   procedure recupererDonneesFdp ();
{ Quand nous recevons un boolean de la BDD, il est repr?senter sous forme de 1 et 0
pour true ou false. Alors pour nos objet Tcheckbox, on convertie ou on fait la corres-
pondance des chiffre et les boolean. }
function renvoieCheck (valeurCheck : string) : Boolean;

{ L'heure renvoy? par la BDD est sous cette forme : "00:00:00", alors ce qu'on fait,
c'est extraire les heures et les minute de cette cha?ne de caract?re parce que c'est
ce dont on a besoin }
function extHM (heureMinute : string; debut : integer) : string;

  // Procedrue de creation
   procedure initialisationFdp ();
   procedure creerTopElementFdp ();
   procedure creerConteneurFdp ();
   procedure creerElementFdp ();
   procedure creerEnsembleElementFdp ();
   procedure creerEmpPasPointer ();
procedure creerEmpDejaPointer ();
procedure recupererEmpDejaPointerFdp ();
procedure recupererEmpPasPointer();



 // Procedure d'ajout!
procedure ajouterMargeFdp ();
procedure ajouterTopElementFdp();
procedure ajouterEnsembleEmpFdp();
procedure ajouterFdp ();
procedure ajouterTousEmployeFdp ();

// Les procedure de retrait
procedure retirerEnsembleElementEmployeFdp ();
procedure retireEmployeFdp ();
procedure retirerTousElementFdp ();
procedure retirerTopElementFdp();



// Variables
var
   topElementFdp : TtopElementFdp;
   conteneurFdp : FicheDePointageHerite;
   nombreEmployeFdp : integer;
   // les employ? qui sont pointable et qui ne sont pas encore pointer
   empPasPointer : array of string;
   { Les employ?s du jour qui sont point?. C'est int?ressant si vous fermez
   l'application apr?s avoir point? un certain nombre d'employ?s, ? la reouverture, on
   va r?cup?rer ceux sont pointer pour ne pas faire deux fois la m?me action. }
   empPointerFdp : array of string;
   { Les employ? qui ont fait des heures sup. M?me cas de figure que "empPointerFdp". }
   empPointerDHS : array of string;
   { Le tableau qui va contenir l'ensemble des employ?s ? afficher ? l'?cran. }
   LesEmployeFdp : array of TemployeMaquetteFdp;
   { c'est pour avoir les l'ensemble des informations d'un employ? lorsqu'on le pointe. }
   tabRenvoyerParValidationPointage : tabElementPointage;
   unEmployeFdp : TemployeMaquetteFdp;
   sentinelleFdp, construireUnefois : Boolean;
   adoRep :  TADOQuery;
   procEmpPasPointer : TADOStoredProc;
   { nbEmpPointerFdp : le nombre d'employ? qui ont ?t? point?; nbEmpPointerDHS :
   le nombre d'employ?s qui ont ?t? pointer comme faisons des heures sup. }
   nbEmpPointerFdp, nbEmpPointerDHS : integer;
   { nbEleRecupFdpPasPointer : qu'on nous recup?rons les informations d'un employ? dans
   la base de donn?es, nous recevons un certain nombre d'?l?ment par exemple : nom,
   prenom... Cette variable compte le nombre de tous ces ?l?ments. C'est la m?me logique
   pour le reste des variable qui ont une nommonclature similaire. }
   nbEleRecupFdpPasPointer, nbEleRecupFdpPointer , nbEleRecupDHS : integer;


implementation
uses Principale;

procedure initialisationFdp ();
begin
   sentinelleFdp := True;
   construireUnefois := True;

end;

procedure creerTopElementFdp ();
begin
  topElementFdp := TtopElementFdp.Create(Pprincipale);
  topElementFdp.ajoutTempsHeure();
end;

procedure creerConteneurFdp ();
begin
   conteneurFdp := FicheDePointageHerite.Create(Pprincipale);
   conteneurFdp.valFdp.OnClick := conteneurFdp.clicValidationFdp;
end;

procedure creerEnsembleElementFdp ();
begin
  creerTopElementFdp ();
  creerConteneurFdp ();
end;



procedure recupererDonneesFdp ();

begin
 adoRep := basesDeDonnees.ADOQuery1;
 procEmpPasPointer := basesDeDonnees.ADOStoredProc1;
// Ici "nombreEmpPointer" n'est pas une table mais une vue (view) qui se trouve sur le server (BDD)
   ExeRequeteSqlServer('SELECT * FROM nombreEmpPointerFdp');
   nbEmpPointerFdp := adoRep.Fields[0].AsInteger;


   if nbEmpPointerFdp = 0 then
     begin
        recupererEmpPasPointer();
     end
      else
       begin
         recupererEmpDejaPointerFdp ();
         recupererEmpPasPointer();
       end;

end;


procedure recupererEmpPasPointer();
var j : integer;
begin
j := 0;
nbEleRecupFdpPasPointer := 3;
procEmpPasPointer.Active := true;
// Ex?cution de la proc?dure stock?e
procEmpPasPointer.ExecProc;

// recup?ration des ?l?ment renvoy?s par la proc?dure

procEmpPasPointer.First;
 while not procEmpPasPointer.Eof do
   begin
     SetLength(empPasPointer, Length(empPasPointer) + nbEleRecupFdpPasPointer);
//     idPP (id personne) me servira ? nommer chaque employ?MaquetteFdp
       empPasPointer[j] := procEmpPasPointer.FieldByName('idPP').AsString;
       j := j + 1;
       empPasPointer[j] := procEmpPasPointer.FieldByName('nomPP').AsString;
       j := j + 1;
       empPasPointer[j] := procEmpPasPointer.FieldByName('prenomPP').AsString;
       j := j + 1;
        if empPasPointer[0] = '' then
            break;
     procEmpPasPointer.Next;
   end;
  procEmpPasPointer.Close;
end;


procedure recupererEmpDejaPointerFdp ();
var j : integer;
begin
j := 0;
nbEleRecupFdpPointer := 9;

   ExeRequeteSqlServer('SELECT * FROM empDejaPointer');
   // On r?cup?re les informations de chaque employ?
   adoRep.First;
   while not adoRep.Eof do
     begin
       SetLength(empPointerFdp, Length(empPointerFdp) + nbEleRecupFdpPointer);
//     idPP (id personne) me servira ? nommer chaque employ?MaquetteFdp
       empPointerFdp[j] := adoRep.FieldByName('id_ce').AsString;
       j := j + 1;
       empPointerFdp[j] := adoRep.FieldByName('nom_pers').AsString;
       j := j + 1;
       empPointerFdp[j] := adoRep.FieldByName('pre_pers').AsString;
       j := j + 1;
       empPointerFdp[j] := adoRep.FieldByName('statut').AsString;
       j := j + 1;
       empPointerFdp[j] := adoRep.FieldByName('heure_arrive').AsString;
       j := j + 1;
       empPointerFdp[j] := adoRep.FieldByName('heure_depart').AsString;
       j := j + 1;
       empPointerFdp[j] := adoRep.FieldByName('retard').AsString;
       j := j + 1;
       empPointerFdp[j] := adoRep.FieldByName('journe_complete').AsString;
       j := j + 1;
       empPointerFdp[j] := adoRep.FieldByName('obs_fdp').AsString;
       j := j + 1;
       adoRep.Next;
     end;



     ExeRequeteSqlServer('SELECT * FROM nombreEmpPointerDHS');
     nbEmpPointerDHS := adoRep.Fields[0].AsInteger;

     if nbEmpPointerDHS <> 0 then
       begin
       j := 0;
       nbEleRecupDHS := 7 ;

         ExeRequeteSqlServer('SELECT * FROM empDejaPointerDHS');
          adoRep.First;
           while not adoRep.Eof do
             begin
               SetLength(empPointerDHS, Length(empPointerDHS) + nbEleRecupDHS);
        //     id_ce me servira de savoir qui est l'employ? qui ? effectuer HS
               empPointerDHS[j] := adoRep.FieldByName('heure_sup').AsString;
               j := j + 1;
               empPointerDHS[j] := adoRep.FieldByName('_150').AsString;
               j := j + 1;
               empPointerDHS[j] := adoRep.FieldByName('_200').AsString;
               j := j + 1;
               empPointerDHS[j] := adoRep.FieldByName('recup').AsString;
               j := j + 1;
               empPointerDHS[j] := adoRep.FieldByName('a_recup').AsString;
               j := j + 1;
               empPointerDHS[j] := adoRep.FieldByName('obs_dhs').AsString;
               j := j + 1;
               empPointerDHS[j] := adoRep.FieldByName('id_ce').AsString;
               j := j + 1;

               adoRep.Next;
             end;
       end;


end;



procedure creerElementFdp ();

begin


   if sentinelleFdp = True then
    begin
      recupererDonneesFdp ();
      sentinelleFdp := False;
    end;

    if nbEmpPointerFdp = 0 then
     begin
        creerEmpPasPointer ();
     end
      else
       begin
         creerEmpDejaPointer ();
         creerEmpPasPointer ();
       end;

end;


procedure creerEmpPasPointer ();
var i,k, tailleTabEmp, tailleTrouve : integer;
begin
k := 0;
tailleTrouve :=  Length(LesEmployeFdp);
tailleTabEmp :=  Length(empPasPointer) div nbEleRecupFdpPasPointer ;
      if empPasPointer[0] = '' then
           tailleTabEmp := 0;
      SetLength(LesEmployeFdp, tailleTrouve + tailleTabEmp );

    for  i := 0 to Length(LesEmployeFdp) -1 do
         begin
            // Cr?ation de la frame puis renommer le name
            UnEmployeFdp := TemployeMaquetteFdp.Create(conteneurFdp);
            UnEmployeFdp.Name := UnEmployeFdp.Name + empPasPointer[k] ;
             if empPasPointer[0] = '' then
                break;
            // Injection de donn?es dans la Frame
            UnEmployeFdp.nomEmploye.Text := empPasPointer[k+1] + ' ' +
            empPasPointer[k+2];
            // nbEleRecupFdpPasPointer = 3
            k := k + nbEleRecupFdpPasPointer;
            // Stocker les frames dans le tableau pour l'affichage
            LesEmployeFdp[tailleTrouve + i] := UnEmployeFdp;
         end;
end;


procedure creerEmpDejaPointer ();
var tailleTab, tailleTrouve, i, k,l,m,n : integer;
begin
// Pour faire varier les ?l?ment dans le tableau empPointerFdp
k := 0;

tailleTab := Length(empPointerFdp) div nbEleRecupFdpPointer ;
tailleTrouve := Length(LesEmployeFdp);
  SetLength(LesEmployeFdp, tailleTrouve + tailleTab);

    For i := 0 to Length(LesEmployeFdp)-1 do
      begin
          UnEmployeFdp := TemployeMaquetteFdp.Create(conteneurFdp);
          UnEmployeFdp.Name := UnEmployeFdp.Name + empPasPointer[k] ;
          // Injection de donn?es dans la Frame
          UnEmployeFdp.nomEmploye.Text := empPointerFdp[k+1] + ' ' +
          empPointerFdp[k+2];
          unEmployeFdp.libelleStatut.Text := empPointerFdp[k+3];
          unEmployeFdp.AH.Text := extHM(empPointerFdp[k+4],0);
          unEmployeFdp.AM.Text := extHM(empPointerFdp[k+4],3);
          unEmployeFdp.DH.Text := extHM(empPointerFdp[k+5],0);
          unEmployeFdp.DM.Text := extHM(empPointerFdp[k+5],3);
          unEmployeFdp.retard.IsChecked := renvoieCheck( empPointerFdp[k+6]);
          unEmployeFdp.jrComplete.IsChecked := renvoieCheck( empPointerFdp[k+7]);
          unEmployeFdp.Memo1.Text := empPointerFdp[k+8];

          if Length(empPointerDHS) <> 0 then
           begin
           // Pour faire varier les ?l?ment dans le tableau empPointerDHS
              m := 0;
              // Pour passer d'un employ? en heures sup ? l'autre.
              n := nbEleRecupDHS;
             for l := 0 to nbEmpPointerDHS-1 do
               begin
                 if empPointerFdp[k] = empPointerDHS[ n-1 ] then
                   begin
                      unEmployeFdp.heuresSup.Text := empPointerDHS[m];
                      unEmployeFdp._150.IsChecked := renvoieCheck( empPointerDHS[m+1] );
                      unEmployeFdp._200.IsChecked := renvoieCheck( empPointerDHS[m+2] );
                      unEmployeFdp.aRecup.IsChecked := renvoieCheck( empPointerDHS[m+3] );
                      unEmployeFdp.retard.IsChecked := renvoieCheck( empPointerDHS[m+4] );
                      // Il manque de faire le truc pour l'obs de heureSup
                      m := m + nbEleRecupDHS;
                   end;
               n := n + nbEleRecupDHS;
               end;
           end;

          k := k + nbEleRecupFdpPointer;
          LesEmployeFdp[ Length(LesEmployeFdp) + 1] := unEmployeFdp;
      end;

end;


function renvoieCheck (valeurCheck : string) : Boolean;
var val : Boolean;
begin
  if valeurCheck = '0' then
    val := False
  else
    val := True;
    Result := val;
end;

function extHM (heureMinute : string; debut : integer) : string;
var val : string;
begin
   val := copy(heureMinute, debut, 2);
   Result := val;
end;

procedure ajouterEnsembleEmpFdp();
begin
     if construireUnefois = True then
       begin
          creerEnsembleElementFdp();
          ajouterTousEmployeFdp();
          construireUnefois := False;
       end;

   ajouterTopElementFdp ();
   ajouterFdp ();
end;

procedure ajouterTopElementFdp ();

begin
  topElementFdp.Parent := Pprincipale.containeTopElement;
  appaTopElementFdp();
  TopElementFdpAnim.Parent := topElementFdp;
  TopElementFdpAnim.Enabled := true;
end;

procedure ajouterTousEmployeFdp ();
var i : integer;
begin
  creerElementFdp();
  ajouterMargeFdp();

  for i:= 0 to Length(LesEmployeFdp)-1 do
    begin
      LesEmployeFdp[i].Parent := conteneurFdp.VertScrollBox1;
    end;
end;


procedure ajouterFdp ();
begin

   conteneurFdp.Parent := Pprincipale.prinContainer;
   appaTousEmployeFdp ();
   TousEmployeFdpAnim.Parent := conteneurFdp;
   TousEmployeFdpAnim.Enabled := true;
end;


procedure ajouterMargeFdp ();
begin
   // La taille du conteneur des employ?s
    conteneurFdp.Height := conteneurFdp.titreListeEmploye.Height  +
    (unEmployeFdp.Height * Length(LesEmployeFdp));

  // Taille de la verticalBox  du conteneur des employ?s
    conteneurFdp.VertScrollBox1.Height := (LesEmployeFdp[0].Height * Length(LesEmployeFdp)) ;

  // Taille du prinContainer
    Pprincipale.prinContainer.Height := conteneurFdp.Height ;
end;


procedure retirerTopElementFdp();
begin
  topElementFdp.Parent := nil;
end;

procedure retirerTousElementFdp ();
begin
  conteneurFdp.Destroy;
end;

procedure retireEmployeFdp ();
begin
  conteneurFdp.Parent := nil;
end;


procedure retirerEnsembleElementEmployeFdp ();
begin
  retirerTopElementFdp();
  retireEmployeFdp ();
end;




procedure FicheDePointageHerite.clicValidationFdp(Sender: TObject);
var
i : integer;
req : string;
begin
  for i := 0 to nombreEmployeFdp-1 do
    begin
      if LesEmployeFdp[i].selection = True then
        begin
        { Au lieu de construire cette requette ici, on va cr?er un fonction au niveau de la
         BDD avec des variable pour des v?rification d'erreure }
          tabRenvoyerParValidationPointage := LesEmployeFdp[i].validationPointage();
           if Length(tabRenvoyerParValidationPointage) >= 2 then
            begin
              req := 'INSERT INTO FICHE_POINTAGE ' +
              'date_jour,statut,heure_arrive,heure_depart,retard,journe_complete,obs_fdp,id_ce' +
              'VALUES' +
              '( getDate()' + ',' + tabRenvoyerParValidationPointage [0] + ',' +
              tabRenvoyerParValidationPointage [1] + ',' + tabRenvoyerParValidationPointage [2] +
              tabRenvoyerParValidationPointage [3] + ',' + tabRenvoyerParValidationPointage [4] +
              tabRenvoyerParValidationPointage [5] + ',' + LesEmployeFdp[i].Name + ' )';
            end
            else
              begin
                ShowMessage(tabRenvoyerParValidationPointage[0]);
              end;
        end;
    end;
end;




end.
